{*********************************************************}
{*                  STTRICON.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$I+} {I/O Checking On}
{$H+} {Huge strings}

unit StTrIcon;

interface

{$IFNDEF WIN32}
  !! Error: This unit cannot be compiled with Delphi 1
{$ENDIF}

uses
  SysUtils, Windows, Forms, Classes, Controls, Messages, Menus, Graphics,
  ExtCtrls, ShellApi,
  StShBase, StBase, StConst, Dialogs;

{$Z+}
const
  TrayIconID = WM_USER + $2FF;

type

  TTrayClickEvent = procedure(Sender : TObject;
                              Button : TMouseButton;
                              Shift : TShiftState) of object;

  TTrayDblClickEvent = procedure(Sender : TObject;
                                 Button : TMouseButton;
                                 Shift : TShiftState;
                                 var RestoreApp : Boolean) of object;

  TStCustomTrayIcon = class(TStShellComponent)
  protected{private}
    {property variables}
    FActive         : Boolean;
    FAnimate        : Boolean;
    FCloseToTray    : Boolean;
    FHideOnRestore  : Boolean;
    FHint           : string;
    FIcon           : TIcon;
    FImages         : TImageList;
    FImageIndex     : Integer;
    FInterval       : Integer;
    FMinimizeToTray : Boolean;
    FPopupMenu      : TPopupMenu;
    FShowHint       : Boolean;

    {event variables}
    FOnClick    : TTrayClickEvent;
    FOnDblClick : TTrayDblClickEvent;
    FOnMinimize : TNotifyEvent;
    FOnRestore  : TNotifyEvent;

    {internal variables}
    IsActive    : Boolean;
    Handle      : HWnd;
    NewWndProc  : TFarProc;
    PrevWndProc : TFarProc;
    InitCount   : Byte;
    Timer       : TTimer;
    CurIndex    : Integer;
    ActiveIcon  : TIcon;
    DefPopup    : TPopupMenu;
    WasAnimated : Boolean;

    procedure SetActive(const Value: Boolean);
    procedure SetAnimate(const Value: Boolean);
    procedure SetHint(const Value: string);
    procedure SetIcon(const Value: TIcon);
    procedure SetShowHint(const Value: Boolean);
    procedure SetImages(const Value: TImageList);
    procedure SetImageIndex(const Value: Integer);
    procedure SetInterval(const Value: Integer);

    function  NotifyIcon(Msg : Integer) : Boolean;

    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;                                                           
    procedure AppWndProc(var Msg : TMessage);
    procedure HookForm(Value : Boolean);
    procedure WndProc(var Msg : TMessage);
    procedure DoTimer(Sender : TObject);
    procedure ResetIcon;
    procedure DoCloseClick(Sender : TObject);
    procedure DoRestoreClick(Sender : TObject);
  protected
{$Z-}
    {properties}
    property Active : Boolean
      read FActive write SetActive
      default True;

    property Animate : Boolean
      read FAnimate write SetAnimate default False;

    property CloseToTray : Boolean
      read FCloseToTray write FCloseToTray default True;

    property HideOnRestore : Boolean
      read FHideOnRestore write FHideOnRestore default False;

    property Hint : string
      read FHint write SetHint;

    property Icon : TIcon
      read FIcon write SetIcon;

    property Images : TImageList
      read FImages write SetImages;

    property ImageIndex : Integer
      read FImageIndex write SetImageIndex default 0;

    property Interval : Integer
      read FInterval write SetInterval default 250;

    property MinimizeToTray : Boolean
      read FMinimizeToTray write FMinimizeToTray default False;

    property PopupMenu : TPopupMenu
      read FPopupMenu write FPopupMenu;

    property ShowHint : Boolean
      read FShowHint write SetShowHint
      default True;

    {events}
    property OnClick : TTrayClickEvent
      read FOnClick write FOnClick;

    property OnDblClick : TTrayDblClickEvent
      read FOnDblClick write FOnDblClick;

    property OnMinimize : TNotifyEvent
      read FOnMinimize write FOnMinimize;

    property OnRestore : TNotifyEvent
      read FOnRestore write FOnRestore;

{$Z+}
    {methods}
    procedure DoClick(Button : TMouseButton; Shift : TShiftState);
    procedure DoDblClick(Button : TMouseButton; Shift : TShiftState);
    procedure DoRestore;

  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
{$Z-}
    procedure AddToTray;
    procedure DeleteFromTray;
    procedure RestoreApplication;
  end;

  TStTrayIcon = class(TStCustomTrayIcon)
  published
    {properties}
    property Active;
    property Animate;
    property CloseToTray;
    property HideOnRestore;
    property Hint;
    property Icon;
    property Images;
    property ImageIndex;
    property Interval;
    property MinimizeToTray;
    property PopupMenu;
    property ShowHint;

    {events}
    property OnClick;
    property OnDblClick;
    property OnMinimize;
    property OnRestore;
  end;

implementation

{$IFDEF TRIALRUN}
uses
  {$IFDEF Win32} Registry, {$ELSE} Ver, {$ENDIF}
  IniFiles,
  StTrial;
{$I TRIAL00.INC} {FIX}
{$I TRIAL01.INC} {CAB}
{$I TRIAL02.INC} {CC}
{$I TRIAL03.INC} {VC}
{$I TRIAL04.INC} {TCC}
{$I TRIAL05.INC} {TVC}
{$I TRIAL06.INC} {TCCVC}
{$ENDIF}

constructor TStCustomTrayIcon.Create(AOwner: TComponent);
var
  MI   : TMenuItem;
  I, J : Integer;
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create(AOwner);

  { Since we hook the main form's window procedure, we must }
  { insure that only one StTrayIcon exists per application. }
  if not (csDesigning in ComponentState) then begin
    for I := 0 to Pred(Screen.FormCount) do
      for J := 0 to Pred(Screen.Forms[I].ComponentCount) do
        if (Screen.Forms[I].Components[J] is TStTrayIcon)
            and (Screen.Forms[I].Components[J] <> Self) then
          RaiseStError(EStTrayIconError, stscTrayIconDuplicate);
  end;

  FActive         := True;
  FCloseToTray    := True;
  FIcon           := TIcon.Create;
  FInterval       := 250;
  FShowHint       := True;
  ActiveIcon      := TIcon.Create;
  { If no popup menu is assigned,  provide a basic popup with }
  { Restore and Close on it. Aids in development. }
  if not (csDesigning in ComponentState) then begin
    DefPopup := TPopupMenu.Create(Self);
    MI := TMenuItem.Create(Self);
    MI.Caption := SysToolStr[stscTrayIconClose];
    MI.OnClick := DoCloseClick;
    DefPopup.Items.Add(MI);

    MI := TMenuItem.Create(Self);
    MI.Caption := SysToolStr[stscTrayIconRestore];
    MI.OnClick := DoRestoreClick;
    DefPopup.Items.Add(MI);

    FPopupMenu := DefPopup;
  end;

  InitCount := 0;
  if not (csDesigning in ComponentState) then begin
    Handle := AllocateHWnd(WndProc);
    NewWndProc := MakeObjectInstance(AppWndProc);
  end;
end;

destructor TStCustomTrayIcon.Destroy;
begin
  {restore old wnd proc}
  if not (csDesigning in ComponentState) then
    DeleteFromTray;

  FIcon.Free;
  ActiveIcon.Free;

  DefPopup.Free;
  DefPopup := nil;

  if Assigned(Timer) then begin
    Timer.Free;
    Timer := nil;
  end;

  if Handle <> 0 then
    DeallocateHWnd(Handle);

  if Assigned(NewWndProc) then begin
    HookForm(False);
    FreeObjectInstance(NewWndProc);
  end;

  inherited Destroy;
end;

procedure TStCustomTrayIcon.Notification(AComponent: TComponent;       
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then begin
    if AComponent = FPopupMenu then
      FPopupMenu := nil;
    if AComponent = FImages then
      FImages := nil;
  end;
end;

procedure TStCustomTrayIcon.SetHint(const Value: string);
begin
  if Value <> FHint then begin
    FHint := Value;
    if not (csDesigning in ComponentState) then
      if FShowHint and IsActive then
        if not NotifyIcon(NIM_MODIFY) then
          RaiseStError(EStTrayIconError, stscTrayIconError);
  end;
end;

procedure TStCustomTrayIcon.SetIcon(const Value: TIcon);
begin
  FIcon.Assign(Value);
  if not (csDesigning in ComponentState) then begin                    
    ActiveIcon.Assign(FIcon);                                          
    if IsActive then                                                   
      ResetIcon;                                                       
  end;
end;

procedure TStCustomTrayIcon.WndProc(var Msg : TMessage);
var
  ShiftState : TShiftState;
  P          : TPoint;
begin
  with Msg do begin
    if (lParam >= WM_LBUTTONDOWN) and
       (lParam <= WM_MBUTTONDBLCLK) then begin
          ShiftState := KeysToShiftState(wParam);
      case lParam of
        WM_LBUTTONDOWN : DoClick(mbLeft, ShiftState);
        WM_MBUTTONDOWN : DoClick(mbMiddle, ShiftState);
        WM_RBUTTONDOWN :
          if Assigned(FPopupMenu) then begin
            SetForegroundWindow(Application.Handle);
            Application.ProcessMessages;
            GetCursorPos(P);
            FPopupMenu.AutoPopup := False;
            FPopupMenu.PopupComponent := Owner;
            FPopupMenu.Popup(P.X, P.Y);
          end;
        WM_LBUTTONDBLCLK : DoDblClick(mbLeft, ShiftState);
        WM_MBUTTONDBLCLK : DoDblClick(mbMiddle, ShiftState);
        WM_RBUTTONDBLCLK : DoDblClick(mbRight, ShiftState);
      end;
    end;
  end;
  try
    Dispatch(Msg);
    if Msg.Msg = WM_QUERYENDSESSION then
      Msg.Result := 1;
  except
    Application.HandleException(Self);
  end;
end;

procedure TStCustomTrayIcon.AppWndProc(var Msg : TMessage);
begin
  with Msg do begin
    { If the form state is wsMinimized then hide the application and }
    { main form when we get the second WM_WINDOWPOSCHANGED message.  }
    if (Msg = WM_WINDOWPOSCHANGED) then
      if (InitCount < 2) then begin
        if TForm(Owner).WindowState = wsMinimized then begin
          try
            ShowWindow(Application.Handle, SW_HIDE);
            ShowWindow(TForm(Owner).Handle, SW_HIDE);
          except
          end;
          Inc(InitCount);
      end else
        InitCount := 2;
    end;

    if (Msg = WM_SYSCOMMAND) then
      if wParam = SC_MINIMIZE then
        if Assigned(FOnMinimize) then
          FOnMinimize(Self);
      if (((wParam = SC_MINIMIZE) and FMinimizeToTray) or
         ((wParam = SC_CLOSE) and FCloseToTray)) and FActive then begin
      try
        AddToTray;
        ShowWindow(Application.Handle, SW_HIDE);
        TForm(Owner).Hide;
      except
        Application.HandleException(Self);
      end;
      Exit;
    end;
    if Assigned(PrevWndProc) then
      Result := CallWindowProc(PrevWndProc, TForm(Owner).Handle, Msg, wParam, lParam);
  end;
end;

function TStCustomTrayIcon.NotifyIcon(Msg : Integer) : Boolean;
var
  Flags      : Integer;
  NotifyData : TNotifyIconData;
  IconHandle : HICON;
begin

  IconHandle := ActiveIcon.Handle;
  if IconHandle = 0 then
    IconHandle := Application.Icon.Handle;
  if IconHandle = 0 then
    IconHandle := LoadIcon(0, IDI_Application);

  Flags := NIF_MESSAGE or NIF_ICON;
  if FShowHint then
    Flags := Flags or NIF_TIP;
  FillChar(NotifyData, sizeof(NotifyData), 0);
  with NotifyData do begin
    cbSize := SizeOf(NotifyData);
    Wnd    := Handle;
    uID    := 2;
    uFlags := Flags;
    StrLCopy(szTip, PChar(FHint), SizeOf(szTip));
    uCallBackMessage := TrayIconID;
    hIcon := IconHandle;
  end;
  Result := Shell_NotifyIcon(Msg, @NotifyData);
end;

procedure TStCustomTrayIcon.SetActive(const Value: Boolean);
begin
  if not (csDesigning in ComponentState) then begin
    if Value then begin
      AddToTray;
      FActive := True;
      if WasAnimated then
        Animate := True;
    end else begin
      if FAnimate then begin
        Animate := False;
        WasAnimated := True;
      end;
      DeleteFromTray;
      FActive := False;
    end;
  end else begin
    FActive := Value;
    IsActive := False;
  end;
end;

procedure TStCustomTrayIcon.DoClick(Button : TMouseButton;
                                    Shift : TShiftState);
begin
  if Assigned(OnClick) then
    OnClick(Self, Button, Shift);
end;

procedure TStCustomTrayIcon.DoDblClick(Button : TMouseButton;
                                       Shift : TShiftState);
var
  RestoreApp : Boolean;
begin
  RestoreApp := True;
  if Assigned(OnDblClick) then
    OnDblClick(Self, Button, Shift, RestoreApp);
  if RestoreApp then
    DoRestore;
end;

procedure TStCustomTrayIcon.Loaded;
begin
  inherited Loaded;
  if not (csDesigning in ComponentState) then begin
    if FActive then
      AddToTray;
    if FIcon.Handle <> 0 then
      SetIcon(FIcon)
    else
      if Assigned(FImages) then
        SetImages(FImages);
  end;
end;

procedure TStCustomTrayIcon.HookForm(Value : Boolean);
begin
  if (not (csDesigning in ComponentState))
      and not (csDestroying in ComponentState) then begin
    if Assigned(PrevWndProc) then
      Exit;
    if Value then begin
      PrevWndProc:= Pointer(
        SetWindowLong(TForm(Owner).Handle, GWL_WNDPROC, LongInt(NewWndProc)))
    end else if Assigned(PrevWndProc) then begin
      SetWindowLong(TForm(Owner).Handle, GWL_WNDPROC, LongInt(PrevWndProc));
      PrevWndProc := nil;
    end;
  end;
end;

procedure TStCustomTrayIcon.DoRestore;
begin
  if Assigned(FOnRestore) then
    FOnRestore(Self);
  if (TForm(Owner).WindowState = wsMinimized) and (InitCount >= 2) then
    TForm(Owner).WindowState := wsNormal;
  TForm(Owner).Show;
  SetForegroundWindow(TForm(Owner).Handle);
  ShowWindow(Application.Handle, SW_NORMAL);
  Application.Restore;
  BringWindowToTop(Application.Handle);
  if FHideOnRestore then
    DeleteFromTray;
end;

procedure TStCustomTrayIcon.SetShowHint(const Value: Boolean);
begin
  FShowHint := Value;
  { Must remove the icon and add it again to get the hint status to change.}
  if not (csDesigning in ComponentState) and IsActive then
    if not NotifyIcon(NIM_MODIFY) then
      RaiseStError(EStTrayIconError, stscTrayIconError);
end;

procedure TStCustomTrayIcon.AddToTray;
begin
  if IsActive = True then
    Exit;
  if not Assigned(PrevWndProc) then
    HookForm(True);
  if not NotifyIcon(NIM_ADD) then begin
    IsActive := False;
    RaiseStError(EStTrayIconError, stscTrayIconCantAdd)
  end else
    IsActive := True;
end;

procedure TStCustomTrayIcon.DeleteFromTray;
begin
  if not IsActive then
    Exit;
  NotifyIcon(NIM_DELETE);
  IsActive := False;
end;

procedure TStCustomTrayIcon.RestoreApplication;
begin
  DoRestore;
end;

procedure TStCustomTrayIcon.SetAnimate(const Value: Boolean);
begin
  if FAnimate <> Value then begin
    FAnimate := Value;
    if (csDesigning in ComponentState) or not FActive then
      Exit;
    WasAnimated := FAnimate;
    if FAnimate then begin
      if not Assigned(Timer) then
        Timer := TTimer.Create(Self);
      Timer.OnTimer := DoTimer;
      if FInterval = 0 then
        FInterval := 200;
      Timer.Interval := FInterval;
    end else begin
      { Stop animation. Timer might not be assigned so check first. }
      if Assigned(Timer) then
        Timer.Enabled := False;
      { Reset the static icon. If Icon is being used then that }
      { will become the active icon. If an image list is used  }
      {then use ImageIndex to determine the active icon.       }
      if (Icon.Handle = 0) then begin
        if Assigned(FImages) then
          FImages.GetIcon(FImageIndex, ActiveIcon);
      end else
        ActiveIcon.Assign(FIcon);
      ResetIcon;
    end;
    if Assigned(Timer) then
      Timer.Enabled := FAnimate;
  end;
end;

procedure TStCustomTrayIcon.SetImages(const Value: TImageList);
begin
  FImages := Value;
  if not (csDesigning in ComponentState) and not (csLoading in ComponentState) then
    if (FIcon.Handle = 0) and (Value <> nil) then begin
      FImages.GetIcon(FImageIndex, ActiveIcon);
      ResetIcon;
    end;
end;

procedure TStCustomTrayIcon.SetInterval(const Value: Integer);
begin
  FInterval := Value;
  if Assigned(Timer) then
    Timer.Interval := FInterval;
end;

procedure TStCustomTrayIcon.DoTimer(Sender: TObject);
begin
  if Assigned(FImages) and IsActive then begin
    FImages.GetIcon(CurIndex, ActiveIcon);
    ResetIcon;
    Inc(CurIndex);
    if CurIndex > Pred(FImages.Count) then
      CurIndex := 0;
  end;
end;

procedure TStCustomTrayIcon.ResetIcon;
begin
  if not NotifyIcon(NIM_MODIFY) then
    RaiseStError(EStTrayIconError, stscTrayIconError);
end;

procedure TStCustomTrayIcon.SetImageIndex(const Value: Integer);
begin
  FImageIndex := Value;
  if not (csDesigning in ComponentState) and IsActive then begin
    if not Assigned(Images) then
      RaiseStError(EStTrayIconError, stscImageListInvalid);
    Images.GetIcon(FImageIndex, ActiveIcon);
    ResetIcon;
  end;
end;

procedure TStCustomTrayIcon.DoCloseClick(Sender: TObject);
begin
  PostQuitMessage(0);
end;

procedure TStCustomTrayIcon.DoRestoreClick(Sender: TObject);
begin
  DoRestore;
end;

end.
