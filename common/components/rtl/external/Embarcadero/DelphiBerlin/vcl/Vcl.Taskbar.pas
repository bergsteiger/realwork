{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Vcl.Taskbar;

interface

uses
  System.SysUtils, System.Classes, Winapi.Windows, System.Win.TaskbarCore, System.Win.Taskbar, Vcl.Graphics,
  Winapi.Messages, Vcl.Controls, Vcl.Forms;

{$M+}

type
  TThumbBarButton = class(TThumbBarButtonBase)
  private
    FIcon: TIcon;
    procedure SetIcon(const Value: TIcon);
  protected
    procedure OnActionChange(Sender: TObject); override;
    procedure SetActionImageIndex(Value: Integer); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function GetHIcon: HIcon; override;
  published
    property Action;
    property ButtonState;
    property Hint;
    property Icon: TIcon read FIcon write SetIcon;
  end;

  TThumbBarButtonList = class(TThumbBarButtonListBase)
  private
    function GetItem(Index: Integer): TThumbBarButton;
    procedure SetItem(Index: Integer; const Value: TThumbBarButton);
  public
    constructor Create(const AOwner: TPersistent; const AOwnerItem: TCollectionItem = nil);
    function Add: TThumbBarButton;
    property Items[Index: Integer]: TThumbBarButton read GetItem write SetItem; default;
  end;

  TThumbPreviewItemRequestEvent = procedure (Sender: TObject; APreviewHeight: Integer; APreviewWidth: Integer; PreviewBitmap: TBitmap) of object;
  TWindowPreviewItemRequestEvent = procedure (Sender: TObject; var Position: TPoint; PreviewBitmap: TBitmap) of object;
  TThumbButtonNotifyEvent = procedure (Sender: TObject; AButtonID: Integer) of object;

  TCustomTaskbar = class(TTaskbarBase)
  private
    FProxyWnd: TForm;
    FTaskbarButtons: TThumbBarButtonList;
    FOverlayIcon: TIcon;
    FOnThumbPreviewRequest: TThumbPreviewItemRequestEvent;
    FOnWindowPreviewItemRequest: TWindowPreviewItemRequestEvent;
    FTmpPreviewBitmap: TBitmap;
    FOnThumbButtonClick: TThumbButtonNotifyEvent;
    FOldProxyWndProc: TWndMethod;
    procedure SetOverlayIcon(const Value: TIcon);
    procedure SetTaskbarButtons(const Value: TThumbBarButtonList);
    procedure UpdateButtons;
    procedure GenerateFormImage(APreviewHeight: Integer = 0; APreviewWidth: Integer = 0);
    procedure ProxyFormWndProc(var message: TMessage);
    procedure DoButtonChange(Sender: TObject);
  protected
    function GetFormHandle: HWND; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Initialize; override;
    procedure DoThumbButtonNotify(ItemID: Word); override;
    procedure DoThumbPreviewRequest(APreviewHeight, APreviewWidth: Word); override;
    procedure DoWindowPreviewRequest; override;
    procedure UnregisterTab; override;
    procedure ApplyButtonsChanges; override;
    function GetMainWindowHwnd: HWND; override;
    function GetOverlayHIcon: HICON; override;
    function ActivateTab: Boolean; override;
    property TaskBarButtons: TThumbBarButtonList read FTaskbarButtons write SetTaskbarButtons;
    property OverlayIcon: TIcon read FOverlayIcon write SetOverlayIcon;
    property OnThumbPreviewRequest: TThumbPreviewItemRequestEvent read FOnThumbPreviewRequest write FOnThumbPreviewRequest;
    property OnWindowPreviewItemRequest: TWindowPreviewItemRequestEvent read FOnWindowPreviewItemRequest write FOnWindowPreviewItemRequest;
    property OnThumbButtonClick: TThumbButtonNotifyEvent read FOnThumbButtonClick write FOnThumbButtonClick;
  end;

  TTaskbar = class(TCustomTaskbar)
  published
    property TaskBarButtons;
    property ProgressState;
    property ProgressMaxValue;
    property ProgressValue;
    property OverlayIcon;
    property OverlayHint;
    property PreviewClipRegion;
    property TabProperties;
    property ToolTip;
    property OnThumbPreviewRequest;
    property OnWindowPreviewItemRequest;
    property OnThumbButtonClick;
  end;

implementation

uses
  Winapi.ShlObj, Vcl.ActnList, Vcl.Consts, Winapi.DwmApi, System.RTLConsts;

{ TThumbBarButton }

constructor TThumbBarButton.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FIcon := TIcon.Create;
end;

destructor TThumbBarButton.Destroy;
begin
  FIcon.Free;
  inherited;
end;

function TThumbBarButton.GetHIcon: HIcon;
begin
  Result := FIcon.Handle;
end;

procedure TThumbBarButton.OnActionChange(Sender: TObject);
begin
  if Action is TCustomAction then
  begin
    SetActionHint(TCustomAction(Action).Hint);
    if not (TCustomAction(Action).Enabled and not (TThumbButtonState.Enabled in ButtonState)) then
      SetActionEnabled(TCustomAction(Action).Enabled);
    SetActionVisible(TCustomAction(Action).Visible);
    if (TCustomAction(Action).Images <> nil) and (TCustomAction(Action).ImageIndex >= 0) then
      SetActionImageIndex(TCustomAction(Action).ImageIndex);
  end;
end;

procedure TThumbBarButton.SetActionImageIndex(Value: Integer);
begin
  inherited;
  if TCustomAction(Action).Images <> nil then
    TCustomAction(Action).Images.GetIcon(Value, Icon);
end;

procedure TThumbBarButton.SetIcon(const Value: TIcon);
begin
  FIcon.Assign(Value);
  Changed(False);
end;

{ TThumbBarButtonList }

function TThumbBarButtonList.Add: TThumbBarButton;
begin
  Result := TThumbBarButton(inherited Add);
end;

constructor TThumbBarButtonList.Create(const AOwner: TPersistent; const AOwnerItem: TCollectionItem = nil);
begin
  inherited Create(AOwner, TThumbBarButton, AOwnerItem);
end;

function TThumbBarButtonList.GetItem(Index: Integer): TThumbBarButton;
begin
  Result := TThumbBarButton(inherited GetItem(Index));
end;

procedure TThumbBarButtonList.SetItem(Index: Integer; const Value: TThumbBarButton);
begin
  inherited SetItem(Index, Value);
end;

{ TCustomTaskbar }

procedure TCustomTaskbar.ApplyButtonsChanges;
begin
  if (csDesigning in Owner.ComponentState) or not TaskbarIsAvailable then Exit;
  UpdateButtons;
end;

constructor TCustomTaskbar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTaskbarButtons := TThumbBarButtonList.Create(Self);
  FTaskbarButtons.OnChange := DoButtonChange;
  FOverlayIcon := TIcon.Create;
  if (AOwner is TCustomForm) and not (csDesigning in AOwner.ComponentState) then
  begin
    TCustomForm(AOwner).TaskbarHandler := Self;
    FTmpPreviewBitmap := TBitmap.Create;
  end;
end;

destructor TCustomTaskbar.Destroy;
begin
  FTaskbarButtons.Free;
  FOverlayIcon.Free;
  FreeAndNil(FTmpPreviewBitmap);
  if FProxyWnd <> nil then
    FProxyWnd.TaskbarHandler := nil;
  if Owner <> nil then
    TForm(Owner).TaskbarHandler := nil;
  FreeAndNil(FProxyWnd);
  inherited;
end;

function TCustomTaskbar.GetMainWindowHwnd: HWND;
begin
  Result := Application.MainFormHandle;
end;

function TCustomTaskbar.GetOverlayHIcon: HICON;
begin
  if OverlayIcon <> nil then
    Result := OverlayIcon.Handle
  else
    Result := 0;
end;

procedure TCustomTaskbar.Initialize;
var
  LHandle: HWND;
begin
  inherited;
  if not TaskbarIsAvailable then Exit;
  LHandle := GetFormHandle;
  if LHandle <> 0 then
  begin
    ApplyTabsChanges;
    ApplyOverlayChanges;
    Taskbar.ThumbBarAddButtons(TaskBarButtons.GetButtonArray, LHandle);
    CheckApplyChanges;
  end;
end;

procedure TCustomTaskbar.ProxyFormWndProc(var message: TMessage);
var
  LForm: TForm;
begin
  LForm := TForm(Owner);
  case message.Msg of
    WM_SETFOCUS:
      begin
        if LForm <> nil then
          LForm.BringToFront;
      end;
    WM_CLOSE:
      begin
        if LForm <> nil then
          LForm.Close;
      end;
    WM_ACTIVATE:
      begin
        if (Application.MainForm <> nil) and (Application.MainForm.WindowState = wsMinimized) then
          ShowWindow(Application.MainForm.Handle, SW_RESTORE);
        if (LForm <> nil) and (LForm.Owner <> nil) then
        begin
          if TForm(LForm.Owner).WindowState = wsMinimized then
            ShowWindow(TForm(LForm.Owner).Handle, SW_RESTORE);
          LForm.BringToFront;
        end;
      end;
    WM_SYSCOMMAND:
      begin
        if LForm <> nil then
        begin
          LForm.WindowProc(message);
          FProxyWnd.WindowState := LForm.WindowState;
        end;
      end;
    else
      if Assigned(FOldProxyWndProc) then
        FOldProxyWndProc(message);
    end;
end;

function TCustomTaskbar.GetFormHandle: HWND;

  procedure CheckMDI;
  begin
    if Owner <> nil then
    begin
      if TForm(Owner).FormStyle = fsMDIChild then
      begin
        if FProxyWnd = nil then
        begin
          FProxyWnd := TForm.Create(nil);
          FProxyWnd.Visible := False;
          FProxyWnd.HandleNeeded;
          FProxyWnd.Caption := TForm(Owner).Caption;
          FProxyWnd.TaskbarHandler := Self;
          FOldProxyWndProc := FProxyWnd.WindowProc;
          FProxyWnd.WindowProc := ProxyFormWndProc;
        end;
      end;
    end;
  end;

begin
  if Owner <> nil then
  begin
    if TForm(Owner).FormStyle = fsMDIChild then
    begin
      CheckMDI;
      if Assigned(FProxyWnd) then
        Result := FProxyWnd.Handle
      else
        Result := 0
    end
    else
      Result := TCustomForm(Owner).Handle
  end
  else
    Result := 0;
end;

function TCustomTaskbar.ActivateTab: Boolean;
begin
  if TaskbarIsAvailable then
    Result := TaskBar.SetTabActive(GetFormHandle)
  else
    Result := False;
end;

procedure TCustomTaskbar.UnregisterTab;
begin
  inherited;
  if TaskbarIsAvailable then
    Taskbar.UnregisterTab(GetFormHandle);
end;

procedure TCustomTaskbar.UpdateButtons;
var
  LHandle: HWND;
begin
  if csReading in Owner.ComponentState then Exit;
  if FTaskbarButtons.Count > 0 then
  begin
    LHandle := GetFormHandle;
    if LHandle <> 0 then
    begin
      TaskBarButtons.ButtonsAdded := Taskbar.ThumbBarUpdateButtons(TaskBarButtons.GetButtonArray, LHandle);
    end;
  end;
end;

procedure TCustomTaskbar.SetOverlayIcon(const Value: TIcon);
begin
  FOverlayIcon.Assign(Value);
  if not (csDesigning in Owner.ComponentState) then
    ApplyOverlayChanges;
end;

procedure TCustomTaskbar.SetTaskbarButtons(const Value: TThumbBarButtonList);
begin
  FTaskbarButtons.Assign(Value);
  if not (csDesigning in Owner.ComponentState) then
    ApplyTabsChanges;
end;

procedure TCustomTaskbar.GenerateFormImage(APreviewHeight: Integer = 0; APreviewWidth: Integer = 0);
var
  LBmp : TBitmap;
begin
  if Owner <> nil then
  begin
    LBmp := TForm(Owner).GetFormImage;
    try
      FTmpPreviewBitmap.Assign(LBmp);
      if APreviewWidth <> 0 then
      begin
        FTmpPreviewBitmap.Canvas.StretchDraw(TRect.Create(0, 0, APreviewWidth, APreviewHeight), FTmpPreviewBitmap);
        FTmpPreviewBitmap.Width := APreviewWidth;
        FTmpPreviewBitmap.Height := APreviewHeight;
      end;
      FTmpPreviewBitmap.PixelFormat := pf32bit;
    finally
      LBmp.Free;
    end;
  end;
end;

procedure TCustomTaskbar.DoWindowPreviewRequest;
var
  Position: TPoint;
  LResult: HResult;
begin
  if Assigned(FOnWindowPreviewItemRequest) then
  begin
    FTmpPreviewBitmap.FreeImage;
    Position.X := 0;
    Position.Y := 0;
    FOnWindowPreviewItemRequest(Self, Position, FTmpPreviewBitmap);
    if FTmpPreviewBitmap.PixelFormat <> pf32bit then
      raise EInvalidGraphicOperation.Create(SInvalidBitmapPixelFormat);
    if (FTmpPreviewBitmap <> nil) and not FTmpPreviewBitmap.Empty and (FTmpPreviewBitmap.Handle <> 0) then
    begin
      LResult := DwmSetIconicLivePreviewBitmap(GetFormHandle, FTmpPreviewBitmap.Handle, Position , 0);
      if Failed(LResult) then
        raise EInvalidGraphicOperation.CreateFmt(SBitmapPreviewException,[LResult]);
    end;
  end
  else if (Owner <> nil) and (TForm(Owner).FormStyle = fsMDIChild) then
  begin
    FTmpPreviewBitmap.FreeImage;
    GenerateFormImage;
    Position.X := TForm(Owner).ClientOrigin.X;
    Position.Y := TForm(Owner).ClientOrigin.Y;
    Position := application.MainForm.ScreenToClient(Position);
    LResult := DwmSetIconicLivePreviewBitmap(GetFormHandle, FTmpPreviewBitmap.Handle, Position , 0);
    if Failed(LResult) then
      raise EInvalidGraphicOperation.CreateFmt(SBitmapPreviewException,[LResult]);
  end;
end;

procedure TCustomTaskbar.DoThumbPreviewRequest(APreviewHeight, APreviewWidth: Word);
var
  LResult: HResult;
begin
  if Assigned(FOnThumbPreviewRequest) then
  begin
    FTmpPreviewBitmap.FreeImage;
    FOnThumbPreviewRequest(Self, APreviewHeight, APreviewWidth, FTmpPreviewBitmap);
    if FTmpPreviewBitmap.PixelFormat <> pf32bit then
      raise EInvalidGraphicOperation.Create(SInvalidBitmapPixelFormat);
    if (FTmpPreviewBitmap <> nil) and not FTmpPreviewBitmap.Empty and (FTmpPreviewBitmap.Handle <> 0) then
    begin
      LResult := DwmSetIconicThumbnail(GetFormHandle, FTmpPreviewBitmap.Handle, 0);
      if Failed(LResult) then
        raise EInvalidGraphicOperation.CreateFmt(SThumbPreviewException, [LResult]);
    end;
  end
  else if (Owner <> nil) and (TForm(Owner).FormStyle = fsMDIChild) then
  begin
    FTmpPreviewBitmap.FreeImage;
    GenerateFormImage(APreviewHeight, APreviewWidth);
    LResult := DwmSetIconicThumbnail(GetFormHandle, FTmpPreviewBitmap.Handle, 0);
    if Failed(LResult) then
      raise EInvalidGraphicOperation.CreateFmt(SBitmapPreviewException,[LResult]);
  end;
end;

procedure TCustomTaskbar.DoButtonChange(Sender: TObject);
begin
  ApplyButtonsChanges;
end;

procedure TCustomTaskbar.DoThumbButtonNotify(ItemID: Word);
begin
  if (TaskBarButtons <> nil) then
  begin
    if TaskBarButtons.Count > ItemID then
      if not TaskBarButtons[ItemID].ExecuteButtonAction(TaskBarButtons[ItemID]) and assigned(FOnThumbButtonClick) then
        FOnThumbButtonClick(TaskBarButtons[ItemID], ItemID);
  end;
end;

end.
