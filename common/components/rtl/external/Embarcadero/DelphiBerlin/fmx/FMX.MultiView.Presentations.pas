{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.MultiView.Presentations;

interface

{$SCOPEDENUMS ON}

uses
  System.UITypes, System.Classes, System.Types, System.Messaging, System.Generics.Collections, FMX.MultiView.Types,
  FMX.Ani, FMX.MultiView, FMX.Controls, FMX.Objects, FMX.Types;

type

{ TMultiViewBaseBorderedPresentation }

  TMultiViewBaseBorderedPresentation = class abstract(TMultiViewPresentation)
  private
    FBorderLine: TLine;
  protected
    procedure DoInstall; override;
    procedure DoUninstall; override;
  public
    constructor Create(AMultiView: TCustomMultiView); override;
    destructor Destroy; override;
    procedure UpdateStyle; override;
    property BorderLine: TLine read FBorderLine;
  end;

  /// <summary>Base presentation width border and shadowed overlay for target control</summary>
  TMultiViewBaseBorderWithOverlayPresentation = class(TMultiViewBaseBorderedPresentation, IFreeNotification)
  private
    FDetailOverlay: TShadowedOverlayLayout;
    FShadowAnimation: TFloatAnimation;
  protected
    /// <summary>Defines mode of Detail overlay based on drawer placement</summary>
    function DefineDetailOverlayMode: TOverlayMode;
    /// <summary>Set new parent for Detail overlay.</summary>
    procedure LinkDetailOverlayToParent(const AParent: TFmxObject);
    /// <summary>Unset parent of Detail overlay</summary>
    procedure UnlinkDetailOverlayFromParent;
    /// <summary>Notification about releasing form</summary>
    procedure FormReleased(const Sender: TObject; const M: TMessage);
    { IFreeNotification }
    /// <summary>Notification about removing parent of Detail overlay</summary>
    procedure FreeNotification(AObject: TObject);
    procedure DoInstall; override;
    procedure DoUninstall; override;
    procedure DoOpen(const ASpeed: Single); override;
    procedure DoClose(const ASpeed: Single); override;
    /// <summary>Updates parent of detail overlay. <c>ATargetControl</c> is a new parent. If <c>ATargetControl</c> is nil,
    /// method will use parent of MultiView as parent for Detail Overlay.</summary>
    procedure UpdateDetailOverlayParent(const ATargetControl: TControl);
  public
    constructor Create(AMultiView: TCustomMultiView); override;
    destructor Destroy; override;
    procedure ParentChanged; override;
    /// <summary>Resets current focus</summary>
    procedure ResetFocus;
    procedure TargetControlChanging(AOldControl: TControl; ANewControl: TControl); override;
    procedure UpdateSettings; override;
    /// <summary>Access to detail overlay with shadow</summary>
    property DetailOverlay: TShadowedOverlayLayout read FDetailOverlay;
    /// <summary>Access to shadow animator of detail overlay</summary>
    property ShadowAnimation: TFloatAnimation read FShadowAnimation;
  end;

{ TMultiViewDrawerBasePresentation }

  // MultiView moves from left form side
  TMultiViewDrawerBasePresentation = class abstract(TMultiViewBaseBorderWithOverlayPresentation)
  protected const
    MinimalSpeedThreshold = 150; // Pixels per secs
    HidingThreshold = 0.7; 
    ClickAreaExpansion = 5; // Pixels
    StorageTrackingTime = 0.25; // Sec
    SlidingSpeedReduction = 0.5; // Real traverse speed of user's finger is very big. So we should reduce speed of panel
                                 // sliding, because control close/open very-very fast
    DefaultDeadZone = 1; // Pixels
  protected type
    TTrackingInfo = record
      Position: TPointF;
      Time: TDateTime;
    end;
  private
    FMasterAnimation: TFloatAnimation;
    FTracksInfo: TList<TTrackingInfo>;
    FMousePressedAbsolutePosition: TPointF;
    FDrawerCaptured: Boolean;
    FPreviousOffset: Single;
    FDeadZone: Single;
    procedure DoAnimationFinished(Sender: TObject);
    function DoPointInObjectEvent(Sender: TObject; const X, Y: Single): Boolean;
  protected
    function DefineShadowOpacity(const AOffset: Single): Single;
    function DefineOpenedPanelPosition: TPointF; virtual; abstract;
    function DefineHiddenPanelPosition: TPointF; virtual; abstract;
    procedure ShiftPanels(const AOffset: Single); virtual; abstract;
    function NeedHidePanel(const ASpeed: Single): Boolean; virtual; abstract;
    procedure CaptureDrawer(const AX, AY: Single); virtual;
    { Tracking Information about sliding speed }
    procedure TrackInfo(const AX, AY: Single);
    function CalculateMovingSpeed: Single;
    function CalculateSlidingTime(const ASpeed: Single): Single; virtual; abstract;
    { Mouse events }
    procedure DoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Single; Y: Single); virtual;
    procedure DoMouseMove(Sender: TObject; Shift: TShiftState; X: Single; Y: Single); virtual;
    procedure DoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Single; Y: Single); virtual;
  protected
    procedure DoInstall; override;
    procedure DoUninstall; override;
    procedure DoOpen(const ASpeed: Single); override;
    procedure DoClose(const ASpeed: Single); override;
    procedure DoHidden; override;
    procedure DoStartMoving(const ASpeed: Single); override;
  public
    constructor Create(AMultiView: TCustomMultiView); override;
    destructor Destroy; override;
    { inherited }
    procedure Realign; override;
    procedure UpdateSettings; override;
    procedure ControlTypeChanged; override;
  public
    property MasterAnimation: TFloatAnimation read FMasterAnimation;
    /// <summary>If distance between two points less than this value, They are considered as the identical.
    /// This property affects on smooth sliding </summary>
    property DeadZone: Single read FDeadZone write FDeadZone;
  end;

{ TMultiViewDrawerPushingPresentation }

  TMultiViewDrawerPushingPresentation = class(TMultiViewDrawerBasePresentation)
  public
    const PushPanelStyle = 'pushpanel';
  private
    FDetailAnimation: TRectAnimation;
    FSavedTargetControlStyleLookup: string;
  protected
    procedure ShiftPanels(const AOffset: Single); override;
    function DefineOpenedPanelPosition: TPointF; override;
    function DefineHiddenPanelPosition: TPointF; override;
    function NeedHidePanel(const ASpeed: Single): Boolean; override;
  protected
    procedure DoOpen(const ASpeed: Single); override;
    procedure DoClose(const ASpeed: Single); override;
    procedure DoInstall; override;
    procedure DoUninstall; override;
    function GetDisplayName: string; override;
    function CalculateSlidingTime(const ASpeed: Single): Single; override;
    /// <summary>Saves current value of style lookup property of specified control</summary>
    procedure SaveStyleLookupAndUpdateStyle(const AControl: TStyledControl);
    /// <summary>Restores saved value of style lookup property of specified control</summary>
    procedure RestoreSavedStyleLookup(const AControl: TStyledControl);
  public
    constructor Create(AMultiView: TCustomMultiView); override;
    destructor Destroy; override;
    procedure Realign; override;
    procedure UpdateSettings; override;
    procedure TargetControlChanging(AOldControl: TControl; ANewControl: TControl); override;
  public
    property DetailAnimation: TRectAnimation read FDetailAnimation;
  end;

{ TMultiViewDrawerOverlapPresentation }

  TMultiViewDrawerOverlapPresentation = class(TMultiViewDrawerBasePresentation)
  protected
    function DefineOpenedPanelPosition: TPointF; override;
    function DefineHiddenPanelPosition: TPointF; override;
    procedure ShiftPanels(const AOffset: Single); override;
    function NeedHidePanel(const ASpeed: Single): Boolean; override;
    function GetDisplayName: string; override;
    function CalculateSlidingTime(const ASpeed: Single): Single; override;
    procedure DoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Single; Y: Single); override;
  protected
    procedure DoOpen(const ASpeed: Single); override;
    procedure DoClose(const ASpeed: Single); override;
  public
    procedure Realign; override;
  end;

{ TMultiViewPopoverPresentation }

  // MultiView drops down from master button
  TMultiViewPopoverPresentation = class(TMultiViewPresentation)
  private
    FPopover: TCustomPopover;
  protected
    procedure DoClosePopup(Sender: TObject);
    procedure DoUninstall; override;
    procedure DoInstall; override;
    procedure DoOpen(const ASpeed: Single); override;
    procedure DoClose(const ASpeed: Single); override;
    function GetDisplayName: string; override;
    function GetExpandedSize: TSizeF; override;
  public
    constructor Create(AMultiView: TCustomMultiView); override;
    procedure Realign; override;
    procedure UpdateSettings; override;
  public
    property Popover: TCustomPopover read FPopover;
  end;

{ TMultiViewDockedPanelPresentation }

  // Split view. Multi View is aligned by left side and detail fill the rest space of form
  TMultiViewDockedPanelPresentation = class(TMultiViewBaseBorderedPresentation)
  protected
    function GetDisplayName: string; override;
    function GetMasterButtonVisible: Boolean; override;
    procedure DoInstall; override;
    procedure DoUninstall; override;
  public
    procedure UpdateSettings; override;
    function NeedHideInDesignTime: Boolean; override;
    function CanShowHideInDesignTime: Boolean; override;
  end;

  { TMultiViewNavigationPanePresentation }

  /// <summary>Presentation like a navigation Pane for windows OS</summary>
  TMultiViewNavigationPanePresentation = class(TMultiViewBaseBorderWithOverlayPresentation)
  public const
    CloseSpeedReduction = 0.5;
  private
    FSavedSize: TSizeF;
    FMasterAnimation: TFloatAnimation;
  private
    procedure OverlayClickHandler(Sender: TObject);
    procedure AnimationFinishedHandler(Sender: TObject);
  protected
    function GetDisplayName: string; override;
    procedure DoInstall; override;
    procedure DoUninstall; override;
    procedure DoOpen(const ASpeed: Single); override;
    procedure DoClose(const ASpeed: Single); override;
    procedure SetExpandedSize(const Value: TSizeF); override;
    function GetExpandedSize: TSizeF; override;
    function GetCollapsedSize: TSizeF; override;
  public
    constructor Create(AMultiView: TCustomMultiView); override;
    destructor Destroy; override;
    function NeedHideInDesignTime: Boolean; override;
    /// <summary>Resets current focus</summary>
    procedure ResetFocus;
    procedure TargetControlChanging(AOldControl: TControl; ANewControl: TControl); override;
    procedure UpdateSettings; override;
    procedure Realign; override;
    /// <summary>Updates width of MultiView based on current state (opened, closed)</summary>
    procedure RecalculateWidth;
  end;

implementation

uses
  System.Math, System.SysUtils, System.Math.Vectors, {$IFDEF MACOS}Macapi.CoreFoundation, {$ENDIF} FMX.Platform, FMX.Pickers, 
  FMX.Forms, FMX.Graphics, FMX.Consts;

{ TMultiViewPopoverPresentation }

procedure TMultiViewPopoverPresentation.Realign;
begin
  inherited;
  FPopover.IsOpen := False;
  if MultiView.HasTargetControl then
    MultiView.TargetControl.Align := TAlignLayout.Client;
  if MultiView.HasMasterButton then
    MultiView.MasterButton.Visible := True;
end;

procedure TMultiViewPopoverPresentation.UpdateSettings;
var
  PopoverOptions: TPopoverAppearance;
begin
  inherited;
  PopoverOptions := MultiView.PopoverOptions;
  FPopover.AppearanceDuration := PopoverOptions.AppearanceDuration;
  FPopover.TintColor := PopoverOptions.TintColor;
  FPopover.StyleLookup := PopoverOptions.StyleLookup;
  FPopover.Height := PopoverOptions.PopupHeight;
  if csDesigning in MultiView.ComponentState then
    MultiView.Height := PopoverOptions.PopupHeight;
end;

constructor TMultiViewPopoverPresentation.Create(AMultiView: TCustomMultiView);
begin
  inherited;
  FPopover := TCustomPopover.Create(nil);
  FPopover.Stored := False;
  FPopover.Width := AMultiView.Width;
  FPopover.Visible := False;
  FPopover.OnClosePopup := DoClosePopup;
  FPopover.TintColor := MultiView.PopoverOptions.TintColor;
end;

procedure TMultiViewPopoverPresentation.DoClosePopup(Sender: TObject);
begin
  DoStartHiding;
  Close;
  DoHidden;
  MultiView.MasterContent.Parent := MultiView;
end;

procedure TMultiViewPopoverPresentation.DoInstall;
begin
  inherited;
  MultiView.Visible := False;
  MultiView.Align := TAlignLayout.None;
  MultiView.Size.Size := GetExpandedSize;
end;

procedure TMultiViewPopoverPresentation.DoUninstall;
begin
  FPopover.Free;
  inherited;
end;

function TMultiViewPopoverPresentation.GetDisplayName: string;
begin
  Result := SPopover;
end;

function TMultiViewPopoverPresentation.GetExpandedSize: TSizeF;
begin
  Result := TSizeF.Create(MultiView.Width, MultiView.PopoverOptions.PopupHeight);
end;

procedure TMultiViewPopoverPresentation.DoClose;
begin
  inherited;
  if csDesigning in MultiView.ComponentState then
    MultiView.Visible := False
  else
    FPopover.IsOpen := False;
end;

procedure TMultiViewPopoverPresentation.DoOpen;
begin
  inherited;
  if csDesigning in MultiView.ComponentState then
  begin
    MultiView.Visible := True;
    MultiView.Size.Size := GetExpandedSize;
  end
  else
  begin
    FPopover.Width := MultiView.Width;
    FPopover.PlacementTarget := MultiView.MasterButton;

    MultiView.MasterContent.Parent := FPopover;
    DoStartShowing;
    FPopover.Popup;
    DoShown;
  end;
end;

{ TMultiViewDrawerPresentation }

procedure TMultiViewDrawerBasePresentation.Realign;
begin
  inherited;
  if (csDesigning in MultiView.ComponentState) or Opened then
    MultiView.Position.Point := DefineOpenedPanelPosition
  else
    MultiView.Position.Point := DefineHiddenPanelPosition;

  if MultiView.HasMasterButton then
    MultiView.MasterButton.Visible := True;
end;

procedure TMultiViewDrawerBasePresentation.DoStartMoving(const ASpeed: Single);
begin
  inherited;
  if MultiView.DrawerOptions.Placement = TPanelPlacement.Left then
  begin
    if ASpeed > 0 then
      DoStartShowing
    else
      DoStartHiding;
  end
  else
  begin
    if ASpeed < 0 then
      DoStartShowing
    else
      DoStartHiding;
  end;
end;

function TMultiViewDrawerBasePresentation.CalculateMovingSpeed: Single;
var
  Distance: Single;
  Interval: TTimeStamp;
begin
  Result := 0;
  if FTracksInfo.Count < 2 then
    Exit;

  Interval := DateTimeToTimeStamp(FTracksInfo.Last.Time - FTracksInfo.First.Time);
  Distance := FTracksInfo.Last.Position.X - FTracksInfo.First.Position.X;
  if Interval.Time = 0 then
    Result := MultiView.DrawerOptions.DurationSliding
  else
    Result := (Distance / Interval.Time) * MSecsPerSec;
end;

constructor TMultiViewDrawerBasePresentation.Create(AMultiView: TCustomMultiView);
begin
  inherited;
  FTracksInfo := TList<TTrackingInfo>.Create;
  FDrawerCaptured := False;
  FPreviousOffset := 0;
  FDeadZone := DefaultDeadZone;

  // Detail overlay layer for catching mouse events
  FDetailOverlay.OnMouseDown := DoMouseDown;
  FDetailOverlay.OnMouseMove := DoMouseMove;
  FDetailOverlay.OnMouseUp := DoMouseUp;
  FDetailOverlay.OnPointInObjectEvent := DoPointInObjectEvent;

  // Animation of moving Master panel
  FMasterAnimation := TFloatAnimation.Create(nil);
  FMasterAnimation.Parent := MultiView;
  FMasterAnimation.Stored := False;
  FMasterAnimation.PropertyName := 'position.x';
  FMasterAnimation.Duration := MultiView.DrawerOptions.DurationSliding;
  FMasterAnimation.OnFinish := DoAnimationFinished;
end;

function TMultiViewDrawerBasePresentation.DefineShadowOpacity(const AOffset: Single): Single;
begin
  if SameValue(MultiView.Width, 0, TEpsilon.Vector) then
    Result := 0
  else if Opened then
    Result := 1 - Abs(AOffset) / MultiView.Width
  else
    Result := Abs(AOffset) / MultiView.Width;
  Result := MultiView.ShadowOptions.Opacity * Result;
end;

destructor TMultiViewDrawerBasePresentation.Destroy;
begin
  inherited Destroy;
  FTracksInfo.Free;
  FMasterAnimation.Free;
  FMasterAnimation := nil;
end;

procedure TMultiViewDrawerBasePresentation.DoInstall;
begin
  inherited;
  MultiView.Align := TAlignLayout.Vertical;
  MultiView.Visible := True;
  if MultiView.HasTargetControl then
  begin
    MultiView.TargetControl.Margins.Left := 0;
    MultiView.TargetControl.Margins.Right := 0;
  end;
end;

procedure TMultiViewDrawerBasePresentation.DoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Single);
begin
  CaptureDrawer(X, Y);
  MultiView.Visible := True;
  ResetFocus;
end;

procedure TMultiViewDrawerBasePresentation.DoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);

  function NormalizeInBounds(const AOffset: Single): Single;
  begin
    if Opened then
    begin
      if MultiView.DrawerOptions.Placement = TPanelPlacement.Left then
        Result := EnsureRange(AOffset, -MultiView.Width, 0)
      else
        Result := EnsureRange(AOffset, 0, MultiView.Width);
    end
    else
    begin
      if MultiView.DrawerOptions.Placement = TPanelPlacement.Left then
        Result := EnsureRange(AOffset, 0, MultiView.Width)
      else
        Result := EnsureRange(AOffset, -MultiView.Width, 0);
    end;
  end;

  function CalculateOffset: Single;
  var
    MouseAbsoultePos: TPointF;
    Offset: Single;
  begin
    MouseAbsoultePos := FDetailOverlay.LocalToAbsolute(TPointF.Create(X, Y));
    Offset := MouseAbsoultePos.X - FMousePressedAbsolutePosition.X;
    Result := NormalizeInBounds(Offset);
  end;

  procedure UpdateShadowOpacity(const AOffset: SIngle);
  begin
    if MultiView.ShadowOptions.Enabled then
      FDetailOverlay.Opacity := DefineShadowOpacity(AOffset);
  end;

  function PointInMultiView(AMouseAbsoultePos: TPointF): Boolean;
  begin
    Result := MultiView.LocalRect.Contains(MultiView.AbsoluteToLocal(AMouseAbsoultePos));
  end;

var
  Offset: Single;
  MouseAbsoultePos: TPointF;
begin
  MouseAbsoultePos := DetailOverlay.LocalToAbsolute(TPointF.Create(X, Y));
{$IFDEF ANDROID}
  if not Opened then
    FDrawerCaptured := True
  else
    if PointInMultiView(MouseAbsoultePos) and not FDrawerCaptured then
    begin
      FDrawerCaptured := True;
      CaptureDrawer(X, Y);
    end;
{$ELSE}
  FDrawerCaptured := True;
{$ENDIF}

  if (ssLeft in Shift) and FDetailOverlay.Pressed and FDrawerCaptured then
  begin
    Offset := CalculateOffset;
    // Optimization: When user slowly moves finger through screen, OS can generate a lot of the similar mouse events.
    // We reject events, If they aren't noticeable in UI (very close pixels will be rounded in Paint in one)
    if Abs(FPreviousOffset - Offset) > DeadZone then
    begin
      ShiftPanels(Offset);
      // If offset is zero, we can not define a direction of sliding , so we don't invoke OnStartHiding or OnStartShowing
      if not (TPresentationState.Moving in State) and (Offset <> 0) then
        StartMoving(Offset);
      UpdateShadowOpacity(Offset);
      TrackInfo(X, Y);
      FPreviousOffset := Offset;
    end;
  end;
end;

procedure TMultiViewDrawerBasePresentation.DoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);

  function IsClick: Boolean;
  var
    AbsolutePos: TPointF;
  begin
    AbsolutePos := DetailOverlay.LocalToAbsolute(TPointF.Create(X, Y));
    Result := FMousePressedAbsolutePosition.Distance(AbsolutePos) < ClickAreaExpansion;
  end;

var
  Speed: Single;
  NormalizedSpeed: Single;
begin
  Speed := CalculateMovingSpeed;
  NormalizedSpeed := Speed * (1 - SlidingSpeedReduction);
  if Opened and IsClick then
    Close(NormalizedSpeed)
  else
    if Opened or not IsClick then
      if NeedHidePanel(Speed) then
        Close(NormalizedSpeed)
      else
        Open(NormalizedSpeed);
  FDrawerCaptured := False;
end;

procedure TMultiViewDrawerBasePresentation.DoUninstall;
begin
  FMasterAnimation.Parent := nil;
  if MultiView.HasTargetControl then
  begin
    MultiView.TargetControl.Margins.Left := 0;
    MultiView.TargetControl.Margins.Right := 0;
  end;
  inherited;
end;

procedure TMultiViewDrawerBasePresentation.DoAnimationFinished(Sender: TObject);
begin
  EndMoving;
  if Opened then
    DoShown
  else
    DoHidden;
end;

procedure TMultiViewDrawerBasePresentation.DoClose(const ASpeed: Single);
begin
  if MultiView.ShadowOptions.Enabled then
   if SameValue(ASpeed, DefaultSpeed, TEpsilon.Vector) then
      FShadowAnimation.Duration := MultiView.DrawerOptions.DurationSliding
    else
      FShadowAnimation.Duration := CalculateSlidingTime(ASpeed);
  inherited;
end;

procedure TMultiViewDrawerBasePresentation.DoHidden;
begin
  inherited;
  MultiView.Visible := False;
end;

procedure TMultiViewDrawerBasePresentation.CaptureDrawer;
begin
  FMousePressedAbsolutePosition := DetailOverlay.LocalToAbsolute(TPointF.Create(AX, AY));
  FTracksInfo.Clear;
  TrackInfo(AX, AY);
end;

procedure TMultiViewDrawerBasePresentation.ControlTypeChanged;
begin
  inherited;
  FDetailOverlay.ControlType := MultiView.ControlType;
end;

procedure TMultiViewDrawerBasePresentation.TrackInfo(const AX, AY: Single);
var
  TrackingInfo: TTrackingInfo;
  Stopped: Boolean;
begin
  Stopped := False;
  while (FTracksInfo.Count > 0) and not Stopped do
    if (Now - FTracksInfo[0].Time) * SecsPerDay > StorageTrackingTime then
      FTracksInfo.Delete(0)
    else
      Stopped := True;

  TrackingInfo.Position := DetailOverlay.LocalToAbsolute(TPointF.Create(AX, AY));
  TrackingInfo.Time := Now;
  FTracksInfo.Add(TrackingInfo);
end;

procedure TMultiViewDrawerBasePresentation.UpdateSettings;
begin
  inherited;
  DetailOverlay.Mode := DefineDetailOverlayMode;
  FMasterAnimation.Duration := MultiView.DrawerOptions.DurationSliding;
  Realign;

  if MultiView.DrawerOptions.Placement = TPanelPlacement.Left then
    BorderLine.Align := TAlignLayout.Right
  else
    BorderLine.Align := TAlignLayout.Left;
end;

procedure TMultiViewDrawerBasePresentation.DoOpen(const ASpeed: Single);
begin
  inherited;
  MultiView.Visible := True;

  if MultiView.ShadowOptions.Enabled then
    if SameValue(ASpeed, DefaultSpeed, TEpsilon.Vector) then
      FShadowAnimation.Duration := MultiView.DrawerOptions.DurationSliding
    else
      FShadowAnimation.Duration := CalculateSlidingTime(ASpeed);
end;

function TMultiViewDrawerBasePresentation.DoPointInObjectEvent(Sender: TObject; const X, Y: Single): Boolean;
var
  AbsolutePoint: TPointF;
begin
  // Exclude area of master button from DetailOverlay for correct for correct working of master button.
  // Because DetailOverlay can block MasterButton, in this case user can not click on master button
  if MultiView.HasMasterButton then
  begin
    AbsolutePoint := DetailOverlay.LocalToAbsolute(TPointF.Create(X, Y));
    Result := not MultiView.MasterButton.PointInObject(AbsolutePoint.X, AbsolutePoint.Y);
  end
  else
    Result := True;
end;

{ TMultiViewDockedPanelPresentation }

procedure TMultiViewDockedPanelPresentation.DoInstall;
begin
  inherited;
  MultiView.Visible := True;

  // Align multiview
  if MultiView.SplitViewOptions.Placement = TPanelPlacement.Left then
    MultiView.Align := TAlignLayout.Left
  else
    MultiView.Align := TAlignLayout.Right;

  // Hides master button
  if MultiView.HasMasterButton then
    MultiView.MasterButton.Visible := GetMasterButtonVisible;

  // Resets margins from TargetControl
  if MultiView.HasTargetControl then
  begin
    MultiView.TargetControl.Align := TAlignLayout.Client;
    MultiView.TargetControl.Margins.Left := 0;
    MultiView.TargetControl.Margins.Right := 0;
  end;
end;

procedure TMultiViewDockedPanelPresentation.DoUninstall;
begin
  MultiView.Align := TAlignLayout.None;
  inherited;
end;

function TMultiViewDockedPanelPresentation.GetDisplayName: string;
begin
  Result := SDockedPanel;
end;

function TMultiViewDockedPanelPresentation.GetMasterButtonVisible: Boolean;
begin
  Result := False;
end;

function TMultiViewDockedPanelPresentation.CanShowHideInDesignTime: Boolean;
begin
  Result := False;
end;

function TMultiViewDockedPanelPresentation.NeedHideInDesignTime: Boolean;
begin
  Result := False;
end;

procedure TMultiViewDockedPanelPresentation.UpdateSettings;
begin
  inherited;
  if MultiView.SplitViewOptions.Placement = TPanelPlacement.Left then
  begin
    MultiView.Align := TAlignLayout.Left;
    FBorderLine.Align := TAlignLayout.Right;
  end
  else
  begin
    MultiView.Align := TAlignLayout.Right;
    FBorderLine.Align := TAlignLayout.Left;
  end;
end;

{ TMultiViewDrawerPushingPresentation }

function TMultiViewDrawerPushingPresentation.CalculateSlidingTime(const ASpeed: Single): Single;
var
  Distance: Single;
  Duration: Single;
begin
  if MultiView.HasTargetControl then
  begin
    if Opened then
    begin
      Distance := Abs(MultiView.Width - MultiView.TargetControl.Margins.Left);
      Duration := Distance / Abs(ASpeed);
    end
    else
    begin
      Distance := Abs(MultiView.TargetControl.Margins.Left);
      Duration := Distance / Abs(ASpeed);
    end;
    Result := Min(Duration, MultiView.DrawerOptions.DurationSliding);
  end
  else
    Result := MultiView.DrawerOptions.DurationSliding;
end;

constructor TMultiViewDrawerPushingPresentation.Create(AMultiView: TCustomMultiView);
const
  PropertyToPushAnimate = 'margins';
begin
  inherited;
  // Animation moves Detail panel
  FDetailAnimation := TRectAnimation.Create(nil);
  FDetailAnimation.PropertyName := PropertyToPushAnimate;
  FDetailAnimation.Stored := False;
  FDetailAnimation.Duration := MultiView.DrawerOptions.DurationSliding;
  FDetailAnimation.OnFinish := DoAnimationFinished;
end;

function TMultiViewDrawerPushingPresentation.DefineHiddenPanelPosition: TPointF;
begin
  Result := DefineOpenedPanelPosition;
end;

function TMultiViewDrawerPushingPresentation.DefineOpenedPanelPosition: TPointF;
var
  X: Single;
begin
  X := 0;
  if MultiView.DrawerOptions.Placement = TPanelPlacement.Right then
    X := GetParentWidth - MultiView.Width;
  Result := TPointF.Create(X, 0);
end;

destructor TMultiViewDrawerPushingPresentation.Destroy;
begin
  inherited;
  FDetailAnimation.Free;
end;

procedure TMultiViewDrawerPushingPresentation.TargetControlChanging(AOldControl, ANewControl: TControl);
begin
  inherited;
  if ANewControl = nil then
  begin
    FDetailAnimation.Parent := nil;
    if AOldControl is TStyledControl then
      RestoreSavedStyleLookup(TStyledControl(AOldControl));
  end
  else
  begin
    FDetailAnimation.Parent := ANewControl;
    if AOldControl is TStyledControl then
    begin
      RestoreSavedStyleLookup(TStyledControl(AOldControl));
      SaveStyleLookupAndUpdateStyle(TStyledControl(ANewControl));
    end;
    ANewControl.BringToFront;
  end;
end;

procedure TMultiViewDrawerPushingPresentation.DoUninstall;
begin
  if MultiView.TargetControl is TStyledControl then
    RestoreSavedStyleLookup(TStyledControl(MultiView.TargetControl));
  FDetailAnimation.Parent := nil;
  inherited;
end;

function TMultiViewDrawerPushingPresentation.GetDisplayName: string;
begin
  Result := SDrawer;
end;

function TMultiViewDrawerPushingPresentation.NeedHidePanel(const ASpeed: Single): Boolean;
begin
  if Abs(ASpeed) < MinimalSpeedThreshold then
  begin
    Result := False;
    if MultiView.HasTargetControl then
      if MultiView.DrawerOptions.Placement = TPanelPlacement.Left then
        Result := MultiView.TargetControl.Margins.Left < MultiView.Width * HidingThreshold
      else
        Result := MultiView.TargetControl.Margins.Left > -MultiView.Width * HidingThreshold;
  end
  else
    if MultiView.DrawerOptions.Placement = TPanelPlacement.Left then
      Result := ASpeed < 0
    else
      Result := ASpeed > 0;
end;

procedure TMultiViewDrawerPushingPresentation.DoClose(const ASpeed: Single);
begin
  inherited;
  if MultiView.HasTargetControl then
  begin
    if SameValue(ASpeed, DefaultSpeed, TEpsilon.Vector) then
      FDetailAnimation.Duration := MultiView.DrawerOptions.DurationSliding
    else
      FDetailAnimation.Duration := CalculateSlidingTime(ASpeed);
    FDetailAnimation.StartValue.Left := MultiView.TargetControl.Margins.Left;
    FDetailAnimation.StartValue.Right := MultiView.TargetControl.Margins.Right;
    FDetailAnimation.StopValue.Left := 0;
    FDetailAnimation.StopValue.Right := 0;
    FDetailAnimation.Start;
  end
  else
  begin
    DoHidden;
    EndMoving;
  end;
end;

procedure TMultiViewDrawerPushingPresentation.DoInstall;
begin
  inherited;
  if MultiView.HasTargetControl then
    MultiView.TargetControl.BringToFront;
end;

procedure TMultiViewDrawerPushingPresentation.Realign;
begin
  inherited;
  if MultiView.HasTargetControl then
  begin
    if Opened then
    begin
      MultiView.TargetControl.BringToFront;
      ShiftPanels(0);
    end;
    FDetailAnimation.Parent := MultiView.TargetControl;
  end;
end;

procedure TMultiViewDrawerPushingPresentation.RestoreSavedStyleLookup(const AControl: TStyledControl);
begin
  if (AControl <> nil) and (AControl.StyleLookup.ToLower = PushPanelStyle) then
    AControl.StyleLookup := FSavedTargetControlStyleLookup;
end;

procedure TMultiViewDrawerPushingPresentation.UpdateSettings;
begin
  inherited;
  if MultiView.HasTargetControl then
    FDetailAnimation.Duration := MultiView.DrawerOptions.DurationSliding;
end;

procedure TMultiViewDrawerPushingPresentation.SaveStyleLookupAndUpdateStyle(const AControl: TStyledControl);
begin
  if AControl <> nil then
  begin
    FSavedTargetControlStyleLookup := AControl.StyleLookup;
    AControl.StyleLookup := PushPanelStyle
  end;
end;

procedure TMultiViewDrawerPushingPresentation.ShiftPanels(const AOffset: Single);
var
  NewLeftMargin: Single;
begin
  if not MultiView.HasTargetControl then
    Exit;

  if Opened then
    if MultiView.DrawerOptions.Placement = TPanelPlacement.Left then
      NewLeftMargin := MultiView.Width + AOffset
    else
      NewLeftMargin := -MultiView.Width + AOffset
  else
    NewLeftMargin := AOffset;
  MultiView.TargetControl.Margins.Left := NewLeftMargin;
  MultiView.TargetControl.Margins.Right := -MultiView.TargetControl.Margins.Left;
end;

procedure TMultiViewDrawerPushingPresentation.DoOpen(const ASpeed: Single);
begin
  inherited;
  if MultiView.HasTargetControl then
  begin
    MultiView.TargetControl.BringToFront;
    if SameValue(ASpeed, DefaultSpeed, TEpsilon.Vector) then
      FDetailAnimation.Duration := MultiView.DrawerOptions.DurationSliding
    else
      FDetailAnimation.Duration := CalculateSlidingTime(ASpeed);
    FDetailAnimation.StartValue.Left := MultiView.TargetControl.Margins.Left;
    FDetailAnimation.StartValue.Right := MultiView.TargetControl.Margins.Right;
    if MultiView.DrawerOptions.Placement = TPanelPlacement.Left then
    begin
      FDetailAnimation.StopValue.Left := MultiView.Width;
      FDetailAnimation.StopValue.Right := -MultiView.Width;
    end
    else
    begin
      FDetailAnimation.StopValue.Left := -MultiView.Width;
      FDetailAnimation.StopValue.Right := MultiView.Width;
    end;
    FDetailAnimation.Start;
  end
  else
  begin
    DoShown;
    EndMoving;
  end;
end;

{ TMultiViewDrawerOverlapPresentation }

function TMultiViewDrawerOverlapPresentation.CalculateSlidingTime(const ASpeed: Single): Single;
var
  Distance: Single;
  Duration: Single;
begin
  if Opened then
  begin
    Distance := Abs(DefineOpenedPanelPosition.X - MultiView.Position.X);
    Duration := Distance / Abs(ASpeed);
  end
  else
  begin
    Distance := Abs(DefineHiddenPanelPosition.X - MultiView.Position.X);
    Duration := Distance / Abs(ASpeed);
  end;
  Result := Min(Duration, MultiView.DrawerOptions.DurationSliding);
end;

function TMultiViewDrawerOverlapPresentation.DefineHiddenPanelPosition: TPointF;
begin
  case MultiView.DrawerOptions.Placement of
    TPanelPlacement.Left:
      Result := TPointF.Create(-MultiView.Width, 0);
    TPanelPlacement.Right:
      Result := TPointF.Create(GetParentWidth, 0);
  else
    Result := TPointF.Create(-MultiView.Width, 0);
  end;
end;

function TMultiViewDrawerOverlapPresentation.DefineOpenedPanelPosition: TPointF;
begin
  case MultiView.DrawerOptions.Placement of
    TPanelPlacement.Left:
      Result := TPointF.Zero;
    TPanelPlacement.Right:
      Result := TPointF.Create(GetParentWidth - MultiView.Width, 0);
  else
    Result := TPointF.Zero;
  end;
end;

procedure TMultiViewDrawerOverlapPresentation.DoClose;
begin
  inherited;
  MultiView.BringToFront;
  if SameValue(ASpeed, DefaultSpeed, TEpsilon.Vector) then
    FMasterAnimation.Duration := MultiView.DrawerOptions.DurationSliding
  else
    FMasterAnimation.Duration := CalculateSlidingTime(ASpeed);
  FMasterAnimation.StartValue := MultiView.Position.X;
  FMasterAnimation.StopValue := DefineHiddenPanelPosition.X;
  FMasterAnimation.Start;
end;

procedure TMultiViewDrawerOverlapPresentation.DoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Single);
begin
  inherited;
  if MultiView.DrawerOptions.Mode = TSlidingMode.OverlapDetailView then
    MultiView.BringToFront;
end;

procedure TMultiViewDrawerOverlapPresentation.ShiftPanels(const AOffset: Single);
begin
  if Opened then
    MultiView.Position.X := DefineOpenedPanelPosition.X + AOffset
  else
    MultiView.Position.X := DefineHiddenPanelPosition.X + AOffset;
end;

procedure TMultiViewDrawerOverlapPresentation.DoOpen;
begin
  inherited;
  MultiView.BringToFront;
  if SameValue(ASpeed, DefaultSpeed, TEpsilon.Vector) then
    FMasterAnimation.Duration := MultiView.DrawerOptions.DurationSliding
  else
    FMasterAnimation.Duration := CalculateSlidingTime(ASpeed);
  FMasterAnimation.StartValue := MultiView.Position.X;
  FMasterAnimation.StopValue := DefineOpenedPanelPosition.X;
  FMasterAnimation.Start;
end;

function TMultiViewDrawerOverlapPresentation.GetDisplayName: string;
begin
  Result := SOverlapDrawer;
end;

function TMultiViewDrawerOverlapPresentation.NeedHidePanel(const ASpeed: Single): Boolean;
begin
  if Abs(ASpeed) < MinimalSpeedThreshold then
  begin
    if MultiView.DrawerOptions.Placement = TPanelPlacement.Left then
      Result := MultiView.Position.X < - MultiView.Width * (1 - HidingThreshold)
    else
      Result := MultiView.Position.X > GetParentWidth - MultiView.Width * HidingThreshold;
  end
  else
    if MultiView.DrawerOptions.Placement = TPanelPlacement.Left then
      Result := ASpeed < 0
    else
      Result := ASpeed > 0;
end;

procedure TMultiViewDrawerOverlapPresentation.Realign;
begin
  inherited;
  MultiView.BringToFront;
end;

{ TMultiViewBaseBorderedPresentation }

constructor TMultiViewBaseBorderedPresentation.Create(AMultiView: TCustomMultiView);
begin
  inherited;
  { Border Line }
  FBorderLine := TSeparatorLine.Create(nil);
  FBorderLine.Stored := False;
  FBorderLine.Lock;
  FBorderLine.Width := 1;
  FBorderLine.LineType := TLineType.Left;
end;

destructor TMultiViewBaseBorderedPresentation.Destroy;
begin
  inherited;
  FBorderLine.Free;
  FBorderLine := nil;
end;

procedure TMultiViewBaseBorderedPresentation.DoInstall;
begin
  inherited;
  FBorderLine.Parent := MultiView;
  UpdateStyle;
end;

procedure TMultiViewBaseBorderedPresentation.DoUninstall;
begin
  FBorderLine.Parent := nil;
  inherited;
end;

procedure TMultiViewBaseBorderedPresentation.UpdateStyle;
var
  LineBrush: TBrushObject;
begin
  inherited;
  if MultiView.FindStyleResource<TBrushObject>('dropline', LineBrush) then
    FBorderLine.Stroke.Assign(LineBrush.Brush);
end;

{ TMultiViewBaseBorderWithOverlayPresentation }

constructor TMultiViewBaseBorderWithOverlayPresentation.Create(AMultiView: TCustomMultiView);
begin
  inherited;
  TMessageManager.DefaultManager.SubscribeToMessage(TFormReleasedMessage, FormReleased);

  FDetailOverlay := TShadowedOverlayLayout.Create(nil);
  FDetailOverlay.Stored := False;
  FDetailOverlay.Mode := TOverlayMode.LeftSide;
  FDetailOverlay.EnabledShadow := MultiView.ShadowOptions.Enabled;
  FDetailOverlay.Color := MultiView.ShadowOptions.Color;
  FDetailOverlay.Opacity := MultiView.ShadowOptions.Opacity;
  FDetailOverlay.Align := TAlignLayout.Contents;
  FDetailOverlay.Lock;
  FDetailOverlay.ControlType := MultiView.ControlType;

  // Animation Detail overlay shadow opacity
  FShadowAnimation := TFloatAnimation.Create(nil);
  FShadowAnimation.Parent := FDetailOverlay;
  FShadowAnimation.Stored := False;
  FShadowAnimation.PropertyName := 'opacity';
  FShadowAnimation.Duration := MultiView.DrawerOptions.DurationSliding;
end;

function TMultiViewBaseBorderWithOverlayPresentation.DefineDetailOverlayMode: TOverlayMode;
begin
  if Opened then
    Result := TOverlayMode.AllLocalArea
  else if MultiView.DrawerOptions.Placement = TPanelPlacement.Left then
    Result := TOverlayMode.LeftSide
  else
    Result := TOverlayMode.RightSide;
end;

destructor TMultiViewBaseBorderWithOverlayPresentation.Destroy;
begin
  inherited;
  TMessageManager.DefaultManager.Unsubscribe(TFormReleasedMessage, FormReleased);
  FDetailOverlay.Free;
  FDetailOverlay := nil;
end;

procedure TMultiViewBaseBorderWithOverlayPresentation.DoClose(const ASpeed: Single);
begin
  inherited;

  if not (TPresentationState.Moving in State) then
    DoStartHiding;

  FDetailOverlay.Mode := DefineDetailOverlayMode;
  if MultiView.ShadowOptions.Enabled then
  begin
    FShadowAnimation.StartValue := FDetailOverlay.Opacity;
    FShadowAnimation.StopValue := 0;
    FShadowAnimation.Start;
  end;
end;

procedure TMultiViewBaseBorderWithOverlayPresentation.DoInstall;
begin
  inherited;
  UpdateDetailOverlayParent(MultiView.TargetControl);
end;

procedure TMultiViewBaseBorderWithOverlayPresentation.DoOpen(const ASpeed: Single);
begin
  if MultiView.ShadowOptions.Enabled then
  begin
    FShadowAnimation.Duration := MultiView.DrawerOptions.DurationSliding;
    FShadowAnimation.StartValue := FDetailOverlay.Opacity;
    FShadowAnimation.StopValue := MultiView.ShadowOptions.Opacity;
  end;

  inherited;

  if not (TPresentationState.Moving in State) then
    DoStartShowing;

  ResetFocus;

  FDetailOverlay.Mode := TOverlayMode.AllLocalArea;
  FDetailOverlay.BringToFront;

  if MultiView.ShadowOptions.Enabled then
    FShadowAnimation.Start;
end;

procedure TMultiViewBaseBorderWithOverlayPresentation.DoUninstall;
begin
  UnlinkDetailOverlayFromParent;
  inherited;
end;

procedure TMultiViewBaseBorderWithOverlayPresentation.UpdateDetailOverlayParent(const ATargetControl: TControl);
var
  NewParent: TFmxObject;
begin
  if (ATargetControl <> nil) and not (csDestroying in MultiView.TargetControl.ComponentState) then
    NewParent := ATargetControl
  else if (MultiView.ParentControl <> nil) and not (csDestroying in MultiView.ParentControl.ComponentState) then
    NewParent := MultiView.ParentControl
  else if not (csDestroying in MultiView.ComponentState) then
    NewParent := MultiView.Parent
  else 
    NewParent := nil;

  UnlinkDetailOverlayFromParent;
  if NewParent <> nil then
  begin
    LinkDetailOverlayToParent(NewParent);
    FDetailOverlay.BringToFront;
  end;
end;

procedure TMultiViewBaseBorderWithOverlayPresentation.FormReleased(const Sender: TObject; const M: TMessage);
begin
  if Sender = FDetailOverlay.Parent then
    UnlinkDetailOverlayFromParent;
end;

procedure TMultiViewBaseBorderWithOverlayPresentation.FreeNotification(AObject: TObject);
begin
  if AObject = FDetailOverlay.Parent then
    UnlinkDetailOverlayFromParent;
end;

procedure TMultiViewBaseBorderWithOverlayPresentation.LinkDetailOverlayToParent(const AParent: TFmxObject);
begin
  if FDetailOverlay.Parent <> AParent then
  begin
    if FDetailOverlay.Parent <> nil then
      FDetailOverlay.Parent.RemoveFreeNotify(Self);

    FDetailOverlay.Parent := AParent;
    FDetailOverlay.Parent.AddFreeNotify(Self);
  end;
end;

procedure TMultiViewBaseBorderWithOverlayPresentation.ParentChanged;
begin
  inherited;
  UpdateDetailOverlayParent(MultiView.TargetControl);
end;

procedure TMultiViewBaseBorderWithOverlayPresentation.ResetFocus;
var
  PickerService: IFMXPickerService;
begin
  if (MultiView.Root <> nil) and (MultiView.Root.Focused <> nil) then
  begin
    MultiView.Root.Focused := nil;
    if TPlatformServices.Current.SupportsPlatformService(IFMXPickerService, PickerService) then
      PickerService.CloseAllPickers;
  end;
end;

procedure TMultiViewBaseBorderWithOverlayPresentation.TargetControlChanging(AOldControl, ANewControl: TControl);
begin
  inherited;
  if ANewControl = nil then
    UpdateDetailOverlayParent(ANewControl)
  else
  begin
    ANewControl.Align := TAlignLayout.Client;
    LinkDetailOverlayToParent(ANewControl);
    FDetailOverlay.BringToFront;
  end;
end;

procedure TMultiViewBaseBorderWithOverlayPresentation.UnlinkDetailOverlayFromParent;
begin
  if FDetailOverlay.Parent <> nil then
    FDetailOverlay.Parent.RemoveFreeNotify(Self);
  FDetailOverlay.Parent := nil;
end;

procedure TMultiViewBaseBorderWithOverlayPresentation.UpdateSettings;

  function DefineShadowOpacity: Single;
  begin
    if not Opened then
      Result := 0
    else
      Result := MultiView.ShadowOptions.Opacity;
  end;

begin
  inherited;
  FDetailOverlay.Opacity := DefineShadowOpacity;
  FDetailOverlay.EnabledShadow := MultiView.ShadowOptions.Enabled;
  FDetailOverlay.Color := MultiView.ShadowOptions.Color;
  FDetailOverlay.InterceptionSize := MultiView.DrawerOptions.TouchAreaSize;
  FShadowAnimation.Duration := MultiView.DrawerOptions.DurationSliding;
end;

{ TMultiViewNavigationPanePresentation }

constructor TMultiViewNavigationPanePresentation.Create(AMultiView: TCustomMultiView);
begin
  inherited;
  BorderLine.Align := TAlignLayout.Right;

  DetailOverlay.OnClick := OverlayClickHandler;

  // Animation of moving Master panel
  FMasterAnimation := TFloatAnimation.Create(nil);
  FMasterAnimation.Parent := MultiView;
  FMasterAnimation.Stored := False;
  FMasterAnimation.PropertyName := 'Width'; // do not localize
  FMasterAnimation.Interpolation := TInterpolationType.Quartic;
  FMasterAnimation.AnimationType := TAnimationType.Out;
  FMasterAnimation.Duration := MultiView.DrawerOptions.DurationSliding;
  FMasterAnimation.OnFinish := AnimationFinishedHandler;
end;

destructor TMultiViewNavigationPanePresentation.Destroy;
begin
  inherited;
  FMasterAnimation.Free;
  FMasterAnimation := nil;
end;

procedure TMultiViewNavigationPanePresentation.AnimationFinishedHandler(Sender: TObject);
begin
  EndMoving;
  if Opened then
    DoShown
  else
    DoHidden;
end;

procedure TMultiViewNavigationPanePresentation.OverlayClickHandler(Sender: TObject);
begin
  Close;
end;

procedure TMultiViewNavigationPanePresentation.DoInstall;
begin
  // We need save size of multi view before inherited, because base method invokes realing,
  // which replaces width on collapsed width
  FSavedSize := MultiView.Size.Size;

  inherited;

  MultiView.Align := TAlignLayout.Vertical;
  MultiView.Visible := True;
  if MultiView.HasTargetControl then
    MultiView.TargetControl.Margins.Left := MultiView.NavigationPaneOptions.CollapsedWidth;
  RecalculateWidth;
end;

procedure TMultiViewNavigationPanePresentation.DoOpen(const ASpeed: Single);
begin
  inherited;
  MultiView.BringToFront;
  FMasterAnimation.Duration := MultiView.DrawerOptions.DurationSliding;
  FMasterAnimation.StartValue := MultiView.NavigationPaneOptions.CollapsedWidth;
  FMasterAnimation.StopValue := FSavedSize.Width;
  FMasterAnimation.Start;
end;

procedure TMultiViewNavigationPanePresentation.DoClose(const ASpeed: Single);
begin
  if MultiView.ShadowOptions.Enabled then
    ShadowAnimation.Duration := MultiView.DrawerOptions.DurationSliding * CloseSpeedReduction;

  inherited;

  MultiView.BringToFront;
  FMasterAnimation.Duration := MultiView.DrawerOptions.DurationSliding * CloseSpeedReduction;
  FMasterAnimation.StartValue := MultiView.Width;
  FMasterAnimation.StopValue := MultiView.NavigationPaneOptions.CollapsedWidth;
  FMasterAnimation.Start;
end;

procedure TMultiViewNavigationPanePresentation.DoUninstall;
begin
  MultiView.Width := FSavedSize.Width;
  FMasterAnimation.Parent := nil;
  if MultiView.HasTargetControl then
    MultiView.TargetControl.Margins.Left := 0;
  inherited;
end;

function TMultiViewNavigationPanePresentation.GetDisplayName: string;
begin
  Result := SNavigationPane;
end;

function TMultiViewNavigationPanePresentation.GetCollapsedSize: TSizeF;
begin
  Result := TSizeF.Create(MultiView.NavigationPaneOptions.CollapsedWidth, MultiView.Height);
end;

function TMultiViewNavigationPanePresentation.GetExpandedSize: TSizeF;
begin
  Result := FSavedSize;
end;

function TMultiViewNavigationPanePresentation.NeedHideInDesignTime: Boolean;
begin
  Result := False;
end;

procedure TMultiViewNavigationPanePresentation.Realign;
begin
  inherited;
  // Refreshes collapsed width, if user change size of TMultiView in DesignTime
  if (csDesigning in MultiView.ComponentState) and (State = [TPresentationState.Installed]) then
  begin
    MultiView.NavigationPaneOptions.CollapsedWidth := Min(MultiView.Width, ExpandedSize.Width);
    if ExpandedSize.Width <= CollapsedSize.Width then
      MultiView.Width := ExpandedSize.Width;
  end;
  // Updates position, because user can drag multiview in design time
  MultiView.Position.Point := TPointF.Create(0, MultiView.Position.Y);
  // If user change width of MultiView in design time we need to update original saved size of MultiView
  // for correct restoring, when mutiview will unload this presentation.
  if Opened then
    FSavedSize.Width := MultiView.Width;
  if MultiView.HasMasterButton then
    MultiView.MasterButton.Visible := True;
  MultiView.BringToFront;
end;

procedure TMultiViewNavigationPanePresentation.RecalculateWidth;
begin
  if Opened then
    MultiView.Width := FSavedSize.Width
  else
    MultiView.Width := MultiView.NavigationPaneOptions.CollapsedWidth;
end;

procedure TMultiViewNavigationPanePresentation.ResetFocus;
var
  PickerService: IFMXPickerService;
begin
  if (MultiView.Root <> nil) and (MultiView.Root.Focused <> nil) then
  begin
    MultiView.Root.Focused := nil;
    if TPlatformServices.Current.SupportsPlatformService(IFMXPickerService, PickerService) then
      PickerService.CloseAllPickers;
  end;
end;

procedure TMultiViewNavigationPanePresentation.SetExpandedSize(const Value: TSizeF);
begin
  inherited;
  FSavedSize := Value;
end;

procedure TMultiViewNavigationPanePresentation.TargetControlChanging(AOldControl, ANewControl: TControl);
begin
  inherited;
  if ANewControl = nil then
    AOldControl.Margins.Left := 0
  else
  begin
    FDetailOverlay.Opacity := 0;
    ANewControl.Margins.Left := MultiView.NavigationPaneOptions.CollapsedWidth;
  end;
  if Opened then
    MultiView.BringToFront;
end;

procedure TMultiViewNavigationPanePresentation.UpdateSettings;
begin
  inherited;
  RecalculateWidth;
  if MultiView.HasTargetControl then
    MultiView.TargetControl.Margins.Left := MultiView.NavigationPaneOptions.CollapsedWidth;
end;

end.
