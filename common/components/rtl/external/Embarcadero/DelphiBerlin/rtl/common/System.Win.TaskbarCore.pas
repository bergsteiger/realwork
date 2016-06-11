{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Win.TaskbarCore;

interface

{$SCOPEDENUMS ON}

uses
  System.SysUtils, System.Classes, System.Actions, System.Win.Taskbar, Winapi.Windows, Winapi.ShlObj, Generics.Collections;

const
  MAX_BUTTON_COUNT = 7;

type
  TThumbButtonState = (Enabled, DismissOnClick, NoBackground, Hidden, NonInteractive);
  TThumbButtonStates = set of TThumbButtonState;

  TThumbTabProperty = (AppThumbAlways, AppThumbWhenActive, AppPeekAlways, AppPeekWhenActive, CustomizedPreview);
  TThumbTabProperties = set of TThumbTabProperty;

  TTaskBarProgressState = (None, Indeterminate, Normal, Error, Paused);

  TThumButtonArray = array of THUMBBUTTON;

  TProgressState = record
    State: TTaskBarProgressState;
    MaxValue: Int64;
    CurrentValue: Int64;
  end;

  TTaskbarHandler = class(TComponent)
  public
    procedure DoWindowPreviewRequest; virtual; abstract;
    procedure DoThumbPreviewRequest(APreviewHeight, APreviewWidth: Word); virtual; abstract;
    procedure DoThumbButtonNotify(ItemID: Word); virtual; abstract;
    procedure CheckApplyChanges; virtual; abstract;
    procedure Initialize; virtual; abstract;
    procedure UnregisterTab; virtual; abstract;
    function ActivateTab: Boolean; virtual; abstract;
  end;

  TPreviewClipRegion = class(TPersistent)
  private
    FBounds: TRect;
    FOnChange: TNotifyEvent;
    procedure SetConstraints(Index: Integer; Value: Integer);
    function GetConstraints(Index: Integer): Integer;
  protected
    procedure Change;
    procedure AssignTo(Dest: TPersistent); override;
  public
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Bounds: TRect read FBounds;
  published
    property Left: Integer index 0 read GetConstraints write SetConstraints default 0;
    property Top: Integer index 1 read GetConstraints write SetConstraints default 0;
    property Height: Integer index 2 read GetConstraints write SetConstraints default 0;
    property Width: Integer index 3 read GetConstraints write SetConstraints default 0;
  end;

  TThumbBarButtonBase = class;

  TThumbButtonActionLink = class(TContainedActionLink)
  private
    FClient: TThumbBarButtonBase;
  protected
    procedure AssignClient(AClient: TObject); override;
    procedure SetVisible(Value: Boolean); override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetHint(const Value: string); override;
    procedure SetImageIndex(Value: Integer); override;
  end;

  TThumbBarButtonBase = class(TCollectionItem)
  private
    FButton: THUMBBUTTON;
    FButtonState: TThumbButtonStates;
    FActionLink: TContainedActionLink;
    procedure SetButtonState(const Value: TThumbButtonStates);
    procedure SetHint(const Value: string);
    function ReadHint: string;
    procedure UpdateButtonStatus;
  protected
    procedure OnActionChange(Sender: TObject); dynamic; abstract;
    procedure SetActionImageIndex(Value: Integer); dynamic;
    procedure SetActionVisible(Value: Boolean); dynamic;
    procedure SetActionEnabled(Value: Boolean); dynamic;
    procedure SetActionHint(const Value: string); dynamic;

    procedure SetAction(const Value: TBasicAction); virtual;
    function GetAction: TBasicAction; virtual;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function ExecuteButtonAction(const ASender: TObject): Boolean; dynamic;
    function GetHIcon: HICON; virtual; abstract;
    function GetButton: THUMBBUTTON;
    function GetNamePath: string; override;
    property ButtonState: TThumbButtonStates read FButtonState write SetButtonState default [TThumbButtonState.Enabled];
    property Action: TBasicAction read GetAction write SetAction;
    property Hint: string read ReadHint write SetHint;
  end;

  TThumbBarButtonListBase = class(TOwnedCollection)
  private
    [Weak] FOwnerItem: TCollectionItem;
    FButtonsAdded: Boolean;
    FOnChange: TNotifyEvent;
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(const AOwner: TPersistent; const ItemClass: TCollectionItemClass; const AOwnerItem: TCollectionItem = nil);
    procedure DoButtonClickEvent(AIndex: Integer);
    function Add: TThumbBarButtonBase;
    function GetButtonArray: TThumButtonArray;
    property OwnerItem: TCollectionItem read FOwnerItem;
    property ButtonsAdded: Boolean read FButtonsAdded write FButtonsAdded;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TTaskbarBase = class(TTaskbarHandler)
  private
    FTaskBar: TWinTaskbar;
    FProgressState: TProgressState;
    FPreviewClipRegion: TPreviewClipRegion;
    FOverlayHint: string;
    FTabProperties: TThumbTabProperties;
    FToolTip: string;
    FChangesNeedsToBeApplied: Boolean;
    FTaskbarIsAvailable: Boolean;
    FRegistered: Boolean;
    procedure SetProgressValue(const Value: Int64);
    procedure SetProgressMaxValue(const Value: Int64);
    procedure SetPreviewClipRegion(const Value: TPreviewClipRegion);
    function GetProgressMaxValue: Int64;
    function GetProgressState: TTaskBarProgressState;
    function GetProgressValue: Int64;
    procedure SetOverlayHint(const Value: string);
    procedure SetProgressState(const Value: TTaskBarProgressState);
    procedure SetTabProperties(const Value: TThumbTabProperties);
    procedure SetToolTip(const Value: string);
  protected
    function GetOwner: TPersistent; override;
    function GetFormHandle: HWND; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Initialize; override;
    procedure InvalidateThumbPreview;
    procedure UpdateClipRegion(const ATaskbar: TWinTaskbar);
    procedure UpdateTab;
    procedure CheckApplyChanges; override;
    procedure ApplyChanges;
    procedure ApplyOverlayChanges;
    procedure ApplyProgressChanges;
    procedure ApplyButtonsChanges; virtual; abstract;
    procedure ApplyTabsChanges;
    procedure ApplyClipAreaChanges;
    procedure ClearClipArea;
    procedure UnregisterTab; override;
    function GetMainWindowHwnd: HWND; virtual; abstract;
    function GetOverlayHIcon: HICON; virtual; abstract;
    property TaskbarIsAvailable: Boolean read FTaskbarIsAvailable;
    property PreviewClipRegion: TPreviewClipRegion read FPreviewClipRegion write SetPreviewClipRegion;
    property ProgressState: TTaskBarProgressState read GetProgressState write SetProgressState default TTaskBarProgressState.none;
    property ProgressMaxValue: Int64 read GetProgressMaxValue write SetProgressMaxValue  default 0;
    property ProgressValue: Int64 read GetProgressValue write SetProgressValue  default 0;
    property OverlayHint: string read FOverlayHint write SetOverlayHint;
    property TabProperties: TThumbTabProperties read FTabProperties write SetTabProperties;
    property ToolTip: string read FToolTip write SetToolTip;
    property TaskBar: TWinTaskbar read FTaskBar;
  end;

implementation

uses
  Winapi.Dwmapi, System.RTLConsts;

{ TPreviewClipRegion }

procedure TPreviewClipRegion.AssignTo(Dest: TPersistent);
begin
  if Dest is TPreviewClipRegion then
  begin
    TPreviewClipRegion(Dest).FBounds.Left := FBounds.Left;
    TPreviewClipRegion(Dest).FBounds.Top := FBounds.Top;
    TPreviewClipRegion(Dest).FBounds.Height := FBounds.Height;
    TPreviewClipRegion(Dest).FBounds.Width := FBounds.Width;
    Change;
  end
  else
    inherited AssignTo(Dest);
end;

procedure TPreviewClipRegion.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TPreviewClipRegion.GetConstraints(Index: Integer): Integer;
begin
  case Index of
    0: Result := FBounds.Left;
    1: Result := FBounds.Top;
    2: Result := FBounds.Height;
    3: Result := FBounds.Width;
  else
    Result := 0;
  end;
end;

procedure TPreviewClipRegion.SetConstraints(Index: Integer; Value: Integer);
begin
  case Index of
    0:
      if Value <> FBounds.Left then
      begin
        FBounds.Left := Value;
        Change;
      end;
    1:
      if Value <> FBounds.Top then
      begin
        FBounds.Top := Value;
        Change;
      end;
    2:
      if Value <> FBounds.Height then
      begin
        FBounds.Height := Value;
        Change;
      end;
    3:
      if Value <> FBounds.Width then
      begin
        FBounds.Width := Value;
        Change;
      end;
  end;
end;

{ TThumbBarButtonBase }

destructor TThumbBarButtonBase.Destroy;
begin
  FActionLink.Free;
  inherited;
end;

function TThumbBarButtonBase.ExecuteButtonAction(const ASender: TObject): Boolean;
begin
  Result := False;
  if FActionLink.Action <> nil then
    Result := FActionLink.Action.Execute;
end;

function TThumbBarButtonBase.GetAction: TBasicAction;
begin
  Result := FActionLink.Action;
end;

function TThumbBarButtonBase.GetButton: THUMBBUTTON;
begin
  FButton.hIcon := GetHIcon;
  Result := FButton;
end;

function TThumbBarButtonBase.GetNamePath: string;
begin
  if TThumbBarButtonListBase(Collection).OwnerItem <> nil then
    Result := TThumbBarButtonListBase(Collection).OwnerItem.GetNamePath + '.' + inherited GetNamePath
  else
    Result := inherited GetNamePath;
end;

constructor TThumbBarButtonBase.Create(Collection: TCollection);
begin
  inherited;
  FButton.dwMask := THB_FLAGS or THB_ICON;
  ButtonState := [TThumbButtonState.Enabled];
  FActionLink := TThumbButtonActionLink.Create(Self);
  FActionLink.OnChange := OnActionChange;
  if Collection.Count > MAX_BUTTON_COUNT then
    raise ETaskbarException.CreateFmt(SButtonsLimitException, [MAX_BUTTON_COUNT]);;
end;

function TThumbBarButtonBase.ReadHint: string;
begin
  Result := FButton.szTip;
end;

procedure TThumbBarButtonBase.SetAction(const Value: TBasicAction);
begin
  if Value <> FActionLink.Action then
  begin
    FActionLink.Action := Value;
    FActionLink.OnChange := OnActionChange;
    OnActionChange(FActionLink.Action);
    Changed(False);
  end;
end;

procedure TThumbBarButtonBase.SetActionEnabled(Value: Boolean);
begin
  inherited;
  if Value then
    Include(FButtonState, TThumbButtonState.Enabled)
  else
    Exclude(FButtonState, TThumbButtonState.Enabled)
end;

procedure TThumbBarButtonBase.SetActionHint(const Value: string);
begin
  Hint := Value;
end;

procedure TThumbBarButtonBase.SetActionImageIndex(Value: Integer);
begin

end;

procedure TThumbBarButtonBase.SetActionVisible(Value: Boolean);
begin
  if Value then
    Exclude(FButtonState, TThumbButtonState.Hidden)
  else
    Include(FButtonState, TThumbButtonState.Hidden);
  UpdateButtonStatus;
end;

procedure TThumbBarButtonBase.SetButtonState(const Value: TThumbButtonStates);
begin
  FButtonState := Value;
  UpdateButtonStatus;
  Changed(False);
end;

procedure TThumbBarButtonBase.UpdateButtonStatus;
begin
  FButton.dwFlags := 0;
  if TThumbButtonState.Enabled in FButtonState then
    FButton.dwFlags := FButton.dwFlags + THBF_ENABLED
  else
    FButton.dwFlags := FButton.dwFlags + THBF_DISABLED;
  if TThumbButtonState.DismissOnClick in FButtonState then
    FButton.dwFlags := FButton.dwFlags + THBF_DISMISSONCLICK;
  if TThumbButtonState.NoBackground in FButtonState then
    FButton.dwFlags := FButton.dwFlags + THBF_NOBACKGROUND;
  if TThumbButtonState.Hidden in FButtonState then
    FButton.dwFlags := FButton.dwFlags + THBF_HIDDEN;
  if TThumbButtonState.NonInteractive in FButtonState then
    FButton.dwFlags := FButton.dwFlags + THBF_NONINTERACTIVE;
end;

procedure TThumbBarButtonBase.SetHint(const Value: string);
begin
  StrPLCopy(FButton.szTip, Value, High(FButton.szTip));
  FButton.dwMask := FButton.dwMask or THB_TOOLTIP;
  Changed(False);
end;

{ TThumbBarButtonListBase }

function TThumbBarButtonListBase.Add: TThumbBarButtonBase;
begin
  if Count < MAX_BUTTON_COUNT then
    Result := TThumbBarButtonBase(inherited Add)
  else
    raise ETaskbarException.CreateFmt(SButtonsLimitException, [MAX_BUTTON_COUNT]);
end;

constructor TThumbBarButtonListBase.Create(const AOwner: TPersistent; const ItemClass: TCollectionItemClass; const AOwnerItem: TCollectionItem = nil);
begin
  inherited Create(AOwner, ItemClass);
  FOwnerItem := AOwnerItem;
  FButtonsAdded := False;
end;

procedure TThumbBarButtonListBase.DoButtonClickEvent(AIndex: Integer);
begin
  TThumbBarButtonBase(Items[AIndex]).ExecuteButtonAction(Items[AIndex]);
end;

function TThumbBarButtonListBase.GetButtonArray: TThumButtonArray;
var
  I: Integer;
begin
  SetLength(Result, Count);
  for I := 0 to Count - 1  do
  begin
    Result[I] := TThumbBarButtonBase(Items[I]).GetButton;
    Result[I].iId := I;
  end;
end;

procedure TThumbBarButtonListBase.Update(Item: TCollectionItem);
begin
  inherited;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

{ TThumbButtonActionLink }

procedure TThumbButtonActionLink.AssignClient(AClient: TObject);
begin
  inherited;
  FClient := TThumbBarButtonBase(AClient);
end;

procedure TThumbButtonActionLink.SetVisible(Value: Boolean);
begin
  inherited;
  FClient.SetActionVisible(Value);
end;

procedure TThumbButtonActionLink.SetEnabled(Value: Boolean);
begin
  inherited;
  if not (Value and not (TThumbButtonState.Enabled in FClient.ButtonState)) then
    FClient.SetActionEnabled(Value);
end;

procedure TThumbButtonActionLink.SetHint(const Value: string);
begin
  inherited;
  FClient.SetActionHint(Value);
end;

procedure TThumbButtonActionLink.SetImageIndex(Value: Integer);
begin
  inherited;
  FClient.SetActionImageIndex(Value);
end;

{ TTaskbarBase }

procedure TTaskbarBase.UnregisterTab;
begin
  FRegistered := False;
end;

procedure TTaskbarBase.UpdateClipRegion(const ATaskbar: TWinTaskbar);
begin
  if FTaskbarIsAvailable then
  begin
    if (FPreviewClipRegion.Width > 0) and (FPreviewClipRegion.Height > 0) then
      ATaskbar.SetThumbnailClip(GetFormHandle, PreviewClipRegion.Bounds)
    else
      ATaskbar.ClearThumbnailClip(GetFormHandle);
  end;
end;

procedure TTaskbarBase.UpdateTab;
var
  LpfIsiconic: LONGBOOL;
  LHandle: HWND;
  LFlags: Integer;
begin
  if FTaskbarIsAvailable then
  begin
    LHandle := GetFormHandle;
    if not FRegistered and TaskBar.RegisterTab(LHandle) then
    begin
      TaskBar.SetTabOrder(LHandle);
      TaskBar.SetTabActive(LHandle);
      FRegistered := True;
    end
    else
      raise ETaskbarException.CreateFmt(SCouldNotRegisterTabException, [TaskBar.LastError]);

    if FRegistered then
    begin
      LFlags := 0;
      if TThumbTabProperty.AppThumbAlways in FTabProperties then
        LFlags := LFlags or STPF_USEAPPTHUMBNAILALWAYS;
      if TThumbTabProperty.AppThumbWhenActive in FTabProperties then
        LFlags := LFlags or STPF_USEAPPTHUMBNAILWHENACTIVE;
      if TThumbTabProperty.AppPeekAlways in FTabProperties then
        LFlags := LFlags or STPF_USEAPPPEEKALWAYS;
      if TThumbTabProperty.AppPeekWhenActive in FTabProperties then
        LFlags := LFlags or STPF_USEAPPPEEKWHENACTIVE;

      TaskBar.SetTabProperties(LHandle, LFlags);

      if TThumbTabProperty.CustomizedPreview in FTabProperties then
      begin
        LpfIsiconic := True;
        DwmSetWindowAttribute(LHandle, DWMWA_FORCE_ICONIC_REPRESENTATION, @LpfIsiconic, SizeOf(LpfIsiconic));
        DwmSetWindowAttribute(LHandle, DWMWA_HAS_ICONIC_BITMAP, @LpfIsiconic, SizeOf(LpfIsiconic));
      end
      else
      begin
        LpfIsiconic := False;
        DwmSetWindowAttribute(LHandle, DWMWA_FORCE_ICONIC_REPRESENTATION, @LpfIsiconic, SizeOf(LpfIsiconic));
        DwmSetWindowAttribute(LHandle, DWMWA_HAS_ICONIC_BITMAP, @LpfIsiconic, SizeOf(LpfIsiconic));
      end;
      DwmInvalidateIconicBitmaps(LHandle);
    end;
  end;
end;

procedure TTaskbarBase.ApplyChanges;
begin
  if (csReading in Owner.ComponentState) or not FTaskbarIsAvailable then Exit;
  FTaskBar.MainWindow := GetMainWindowHwnd;
  ApplyOverlayChanges;
  ApplyButtonsChanges;
  ApplyTabsChanges;
  ApplyClipAreaChanges;
  ApplyProgressChanges;
end;

procedure TTaskbarBase.ApplyClipAreaChanges;
begin
  if (csDesigning in Owner.ComponentState) or (csReading in Owner.ComponentState) or not FTaskbarIsAvailable then
    Exit;
  FChangesNeedsToBeApplied := True;
  if (FTaskBar <> nil) and (GetFormHandle <> 0) then
  begin
    if (FPreviewClipRegion.Bounds.Height = 0) or (FPreviewClipRegion.Bounds.Width = 0) then
      FTaskBar.ClearThumbnailClip(GetFormHandle)
    else
      FTaskBar.SetThumbnailClip(GetFormHandle,FPreviewClipRegion.Bounds);
    FChangesNeedsToBeApplied := False;
  end;
end;

procedure TTaskbarBase.CheckApplyChanges;
begin
  if FChangesNeedsToBeApplied then
  begin
    ApplyChanges;
    FChangesNeedsToBeApplied := False;
  end;
end;

procedure TTaskbarBase.ClearClipArea;
begin
  if (csDesigning in Owner.ComponentState) or not FTaskbarIsAvailable then
    Exit;
  if FTaskBar <> nil then
    FTaskBar.ClearThumbnailClip(GetFormHandle);
end;

constructor TTaskbarBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRegistered := False;
  FPreviewClipRegion := TPreviewClipRegion.Create;
end;

destructor TTaskbarBase.Destroy;
begin
  FPreviewClipRegion.Free;
  FTaskBar.Free;
  inherited;
end;

procedure TTaskbarBase.Initialize;
begin
  if (FTaskBar = nil ) then
  begin
    FTaskBarIsAvailable := CheckWin32Version(6, 1);
    if FTaskBarIsAvailable and not (csDesigning in Owner.ComponentState) then
      FTaskBar := TWinTaskbar.Create;
  end;
end;

function TTaskbarBase.GetProgressValue: Int64;
begin
  Result := FProgressState.CurrentValue;
end;

procedure TTaskbarBase.InvalidateThumbPreview;
begin
  DwmInvalidateIconicBitmaps(GetFormHandle);
end;

function TTaskbarBase.GetOwner: TPersistent;
begin
  Result := Owner;
end;

function TTaskbarBase.GetProgressMaxValue: Int64;
begin
  Result := FProgressState.MaxValue;
end;

function TTaskbarBase.GetProgressState: TTaskBarProgressState;
begin
  Result := FProgressState.State;
end;

procedure TTaskbarBase.SetPreviewClipRegion(const Value: TPreviewClipRegion);
begin
  FChangesNeedsToBeApplied := True;
  FPreviewClipRegion.Assign(Value);
  ApplyClipAreaChanges;
end;

procedure TTaskbarBase.SetProgressValue(const Value: Int64);
begin
  if Value <> FProgressState.CurrentValue then
  begin
    if Value > ProgressMaxValue then
      FProgressState.CurrentValue := ProgressMaxValue
    else if Value < 0 then
      FProgressState.CurrentValue := 0
    else
      FProgressState.CurrentValue := Value;
    FChangesNeedsToBeApplied := True;
    ApplyProgressChanges;
  end;
end;

procedure TTaskbarBase.SetProgressMaxValue(const Value: Int64);
begin
  if FProgressState.MaxValue <> Value then
  begin
    FChangesNeedsToBeApplied := True;
    if Value < 0 then
      FProgressState.MaxValue := 0
    else
      FProgressState.MaxValue := Value;
    if FProgressState.MaxValue < ProgressValue then
      ProgressValue := FProgressState.MaxValue;
    ApplyProgressChanges;
  end;
end;

procedure TTaskbarBase.SetProgressState(
  const Value: TTaskBarProgressState);
begin
  if Value <> FProgressState.State then
  begin
    FChangesNeedsToBeApplied := True;
    FProgressState.State := Value;
    ApplyProgressChanges;
  end
end;

procedure TTaskbarBase.SetTabProperties(const Value: TThumbTabProperties);
var
  TmpProperties: TThumbTabProperties;
begin
  FChangesNeedsToBeApplied := True;
  TmpProperties := Value;
  if (TThumbTabProperty.AppThumbAlways in TmpProperties) and (TThumbTabProperty.AppThumbWhenActive in TmpProperties) then
  begin
    if TThumbTabProperty.AppThumbAlways in FTabProperties then
    begin
      Exclude(TmpProperties, TThumbTabProperty.AppThumbAlways);
      Include(TmpProperties, TThumbTabProperty.AppThumbWhenActive);
    end
    else
    begin
      Exclude(TmpProperties, TThumbTabProperty.AppThumbWhenActive);
      Include(TmpProperties, TThumbTabProperty.AppThumbAlways);
    end;
  end;

  if (TThumbTabProperty.AppPeekAlways in TmpProperties) and (TThumbTabProperty.AppPeekWhenActive in TmpProperties) then
  begin
    if TThumbTabProperty.AppPeekAlways in FTabProperties then
    begin
      Exclude(TmpProperties, TThumbTabProperty.AppPeekAlways);
      Include(TmpProperties, TThumbTabProperty.AppPeekWhenActive);
    end
    else
    begin
      Exclude(TmpProperties, TThumbTabProperty.AppPeekWhenActive);
      Include(TmpProperties, TThumbTabProperty.AppPeekAlways);
    end;
  end;
  FTabProperties := TmpProperties;
  ApplyTabsChanges;
end;


procedure TTaskbarBase.SetToolTip(const Value: string);
begin
  if Value <> FToolTip then
  begin
    FChangesNeedsToBeApplied := True;
    FToolTip := Value;
    if FTaskBar <> nil then
      ApplyTabsChanges;
  end;
end;

procedure TTaskbarBase.ApplyOverlayChanges;
begin
  if (csDesigning in Owner.ComponentState) or (csReading in Owner.ComponentState) or not FTaskbarIsAvailable then
    Exit;
  FChangesNeedsToBeApplied := True;
  if (FTaskBar <> nil) and (GetFormHandle <> 0) then
  begin
    FTaskBar.SetOverlayIcon(GetOverlayHIcon, FOverlayHint);
    FChangesNeedsToBeApplied := False;
  end;
end;

procedure TTaskbarBase.ApplyProgressChanges;
var
  LFormHwn : HWND;
begin
  if (csDesigning in Owner.ComponentState) or (csReading in Owner.ComponentState) or not FTaskbarIsAvailable then
    Exit;
  FChangesNeedsToBeApplied := True;
  LFormHwn := GetFormHandle;
  if (FTaskBar <> nil) and (LFormHwn <> 0) then
  begin
    FTaskBar.SetProgressValue(LFormHwn, FProgressState.CurrentValue, ProgressMaxValue);
    case FProgressState.State of
      TTaskBarProgressState.None: FTaskBar.SetProgressState(LFormHwn,TBPF_NOPROGRESS);
      TTaskBarProgressState.Indeterminate: FTaskBar.SetProgressState(LFormHwn,TBPF_INDETERMINATE);
      TTaskBarProgressState.Normal: FTaskBar.SetProgressState(LFormHwn,TBPF_NORMAL);
      TTaskBarProgressState.Error: FTaskBar.SetProgressState(LFormHwn,TBPF_ERROR);
      TTaskBarProgressState.Paused: FTaskBar.SetProgressState(LFormHwn,TBPF_PAUSED);
    end;
    FChangesNeedsToBeApplied := False;
  end;
end;

procedure TTaskbarBase.ApplyTabsChanges;
begin
  if (csDesigning in Owner.ComponentState) or (csReading in Owner.ComponentState) or not FTaskbarIsAvailable then
    Exit;
  FChangesNeedsToBeApplied := True;
  if (FTaskBar <> nil) and (GetFormHandle <> 0) then
  begin
    UpdateTab;
    UpdateClipRegion(TaskBar);
    FTaskBar.SetThumbnailTooltip(GetFormHandle, FToolTip);
    FChangesNeedsToBeApplied := False;
  end;
end;

procedure TTaskbarBase.SetOverlayHint(const Value: string);
begin
  FChangesNeedsToBeApplied := True;
  FOverlayHint := Value;
  if not (csDesigning in Owner.ComponentState) then
    ApplyOverlayChanges;
end;

end.
