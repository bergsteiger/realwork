{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.MultiView.Types;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.UITypes, System.Types, FMX.Objects, FMX.Controls, FMX.Ani, FMX.Controls.Presentation,
  FMX.Controls.Model;

{ TOverlayLayout }

const
  MM_MODE_CHANGED = MM_USER + 1;
  MM_INTERCEPTION_SIZE_CHANGED = MM_USER + 2;
  MM_OVERLAY_LAYOUT_USER = MM_USER + 3;

type
  /// <summary>Determines area, where layout will catch mouse events.</summary>
  TOverlayMode = (None, AllLocalArea, LeftSide, RightSide, BottomSide, TopSide);

  /// <summary>Event handler for checking is Point in control or not</summary>
  TOnPointInObjectEvent = function (Sender: TObject; const X, Y: Single): Boolean of object;

  /// <summary>Model of <c>TOverlayLayout</c>.</summary>
  TCustomOverlayLayoutModel = class(TDataModel)
  public const
    DefaultMode = TOverlayMode.AllLocalArea;
    DefaultSizeInterception = 20;
  private
    FMode: TOverlayMode;
    FInterceptionSize: Single;
    FOnPointInObjectEvent: TOnPointInObjectEvent;
    procedure SetMode(const Value: TOverlayMode);
    procedure SetInterceptionSize(const Value: Single);
  public
    constructor Create; override;
  public
    /// <summary>Mode of catching mouse events. See <c>TOverlayMode</c></summary>
    property Mode: TOverlayMode read FMode write SetMode;
    /// <summary>Size of area, where layout will catch mouse events</summary>
    property InterceptionSize: Single read FInterceptionSize write SetInterceptionSize;
    /// <summary>Raises when platform checks is point in control or not.</summary>
    property OnPointInObjectEvent: TOnPointInObjectEvent read FOnPointInObjectEvent write FOnPointInObjectEvent;
  end;

  /// <summary>Layout intercept mouse events, when mouse is in special local region on this control and doesn't intercept, when
  /// mouse in another local regions. It is useful, when you want to catch mouse event in special region.
  /// For example, for making sliding effect from side of screen.</summary>
  TCustomOverlayLayout = class(TPresentedControl)
  public type
    TOverlayMode = TOverlayMode deprecated 'Use global type TOverlayMode instead';
  private
    FMousePressedPos: TPointF;
    procedure SetMode(const Value: TOverlayMode);
    function GetMode: TOverlayMode;
    procedure SetInterceptionSize(const Value: Single);
    function GetInterceptionSize: Single;
    function IsInterceptionSizeStored: Boolean;
    procedure SetOnPointInObjectEvent(const Value: TOnPointInObjectEvent);
    function GetOnPointInObjectEvent: TOnPointInObjectEvent;
    function GetModel: TCustomOverlayLayoutModel; overload;
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Single; Y: Single); override;
    procedure DoMouseLeave; override;
    function DefineModelClass: TDataModelClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    /// <summary>Model of <c>TCustomOverlayLayout</c></summary>
    property Model: TCustomOverlayLayoutModel read GetModel;
    property MousePressedPosition: TPointF read FMousePressedPos;
    property Pressed;
  public
    /// <summary>Mode of catching mouse events. See <c>TOverlayMode</c></summary>
    property Mode: TOverlayMode read GetMode write SetMode default TOverlayMode.AllLocalArea;
    /// <summary>Size of area, where layout will catch mouse events</summary>
    property InterceptionSize: Single read GetInterceptionSize write SetInterceptionSize
      stored IsInterceptionSizeStored nodefault;
    /// <summary>Raises when platform checks is point in control or not.</summary>
    property OnPointInObjectEvent: TOnPointInObjectEvent read GetOnPointInObjectEvent write SetOnPointInObjectEvent;
  end;

  TOverlayLayout = class(TCustomOverlayLayout)
  published
    property Mode;
    property InterceptionSize;
    property OnPointInObjectEvent;
  end;

{ TShadowedOverlayLayout }

const
  MM_COLOR_CHANGED = MM_OVERLAY_LAYOUT_USER + 1;
  MM_ENABLED_SHADOW_CHANGED = MM_OVERLAY_LAYOUT_USER + 2;
  MM_SHADOW_OPACITY_CHANGED = MM_OVERLAY_LAYOUT_USER + 3;
  MM_SHADOWED_OVERLAY_LAYOUT_USER = MM_OVERLAY_LAYOUT_USER + 4;

type

  /// <summary>Model of <c>TShadowedOverlayLayout</c>.</summary>
  TCustomShadowedOverlayLayoutModel = class(TCustomOverlayLayoutModel)
  private
    FEnabledShadow: Boolean;
    FColor: TAlphaColor;
    procedure SetColor(const Value: TAlphaColor);
    procedure SetEnabledShadow(const Value: Boolean);
  public
    /// <summary>Will shadow show or not?</summary>
    property EnabledShadow: Boolean read FEnabledShadow write SetEnabledShadow default True;
    /// <summary>Color of Shadow</summary>
    property ShadowColor: TAlphaColor read FColor write SetColor;
  end;

  TShadowedOverlayLayout = class(TCustomOverlayLayout)
  private
    procedure SetColor(const Value: TAlphaColor);
    function GetColor: TAlphaColor;
    procedure SetEnabledShadow(const Value: Boolean);
    function GetEnabledShadow: Boolean;
    function GetModel: TCustomShadowedOverlayLayoutModel;
  protected
    function DefineModelClass: TDataModelClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    /// <summary>Model of <c>TShadowedOverlayLayout</c></summary>
    property Model: TCustomShadowedOverlayLayoutModel read GetModel;
  published
    property Color: TAlphaColor read GetColor write SetColor;
    property ControlType;
    property EnabledShadow: Boolean read GetEnabledShadow write SetEnabledShadow default True;
    property Mode;
    property InterceptionSize;
  end;

{ TPopover }

  TArrowDirection = (None, Top, Bottom, Left, Right);

  TCustomPopover = class(TPopup)
  public const
    DefaultAppearanceDuration = 0.3;
    DefaultShadowOpacity = 0.1;
    DefaultShadowEnabled = False;
    DefaultIndentFromScreenBorder = 5;
  protected type
    TArrowInfo = record
      Direction: TArrowDirection;
      Container: TControl;
      Arrow: TControl;
      Tint: ITintedObject;
    public
      function IsEmpty: Boolean;
      class function Empty: TArrowInfo; static;
    end;
  private
    FOpacityAnimation: TFloatAnimation;
    FAppearanceDuration: Single;
    FShadow: TRectangle;
    FShadowEnabled: Boolean;
    FIndentFromScreenBorder: Single;
    { Style's objects }
    FContent: TControl;
    FTopArrow: TArrowInfo;
    FBottomArrow: TArrowInfo;
    FLeftArrow: TArrowInfo;
    FRightArrow: TArrowInfo;
    FTintColor: TAlphaColor;
    FTintContent: ITintedObject;
    procedure SetAppearanceDuration(const Value: Single);
    function IsAppearanceDurationStored: Boolean;
    function IsIndentFromScreenBorderStored: Boolean;
    function GetCurrentArrow: TArrowInfo;
    procedure DoPlacementChanged(Sender: TObject);
    procedure SetTintColor(const Value: TAlphaColor);
    function IsTintColorStored: Boolean;
  protected
    procedure UpdateArrowPosition; virtual;
    procedure UpdatePadding; virtual;
    procedure UpdateTint; virtual;
    procedure HideArrows;
    procedure DoClosePopup; override;
    procedure DoPopup; override;
    { Style }
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    function GetDefaultStyleLookupName: string; override;
    property Content: TControl read FContent;
    property Shadow: TRectangle read FShadow;
    property TopArrow: TArrowInfo read FTopArrow;
    property BottomArrow: TArrowInfo read FBottomArrow;
    property LeftArrow: TArrowInfo read FLeftArrow;
    property RightArrow: TArrowInfo read FRightArrow;
    property CurrentArrow: TArrowInfo read GetCurrentArrow;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Popup(const AShowModal: Boolean = False); override;
    property TintContent: ITintedObject read FTintContent;
  public
    property AppearanceDuration: Single read FAppearanceDuration write SetAppearanceDuration
      stored IsAppearanceDurationStored nodefault;
    property ShadowEnabled: Boolean read FShadowEnabled write FShadowEnabled default DefaultShadowEnabled;
    property IndentFromScreenBorder: Single read FIndentFromScreenBorder write FIndentFromScreenBorder
      stored IsIndentFromScreenBorderStored nodefault;
    property TintColor: TAlphaColor read FTintColor write SetTintColor stored IsTintColorStored;
  end;

  TSeparatorLine = class(TLine);

{ TMultiViewAppearance }

  /// <summary>Base class for storing options of TMultiView. It provides a OnChange handler and Owner.</summary>
  TMultiViewAppearance = class(TPersistent)
  private
    FOwner: TComponent;
    FOnChanged: TNotifyEvent;
  protected
    /// <summary>Notifies about changed properties. Should use in successors.</summary>
    procedure DoChanged; virtual;
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TComponent; const AInternalChange: TNotifyEvent);
    /// <summary>Are properties contains a default values or not?</summary>
    function AreDefaultValues: Boolean; virtual;
    /// <summary>Owner of this settings</summary>
    property Owner: TComponent read FOwner;
    /// <summary>Raises, when one of properties was changed</summary>
    property OnChanged: TNotifyEvent read FOnChanged;
  end;

{ TDrawerAppearance }

  TSlidingMode = (PushingDetailView, OverlapDetailView);
  TPanelPlacement = (Left, Right);

  /// <summary>Storing options of drawer presentation for TMultiView</summary>
  TDrawerAppearance = class(TMultiViewAppearance)
  public const
    DefaultDurationSliding = 0.25;
    DefaultTouchAreaSize = 20;
    DefaultMode = TSlidingMode.OverlapDetailView;
    DefaultPlacement = TPanelPlacement.Left;
  private
    FMode: TSlidingMode;
    FPlacement: TPanelPlacement;
    FDurationSliding: Single;
    FTouchAreaSize: Single;
    procedure SetDurationSliding(const Value: Single);
    procedure SetMode(const Value: TSlidingMode);
    procedure SetTouchAreaSize(const Value: Single);
    procedure SetPlacement(const Value: TPanelPlacement);
  protected
    function IsDurationSlidingStored: Boolean; virtual;
    /// <summary>Is value of <c>TouchAreaSize</c> default or not?</summary>
    function IsTouchAreaSizeStored: Boolean; virtual;
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(AOwner: TComponent; const AInternalChange: TNotifyEvent);
    function AreDefaultValues: Boolean; override;
  published
    property DurationSliding: Single read FDurationSliding write SetDurationSliding
      stored IsDurationSlidingStored nodefault;
    property Placement: TPanelPlacement read FPlacement write SetPlacement default DefaultPlacement;
    property Mode: TSlidingMode read FMode write SetMode default DefaultMode;
    property TouchAreaSize: Single read FTouchAreaSize write SetTouchAreaSize stored IsTouchAreaSizeStored nodefault;
  end;

{ TShadowAppearance }

  /// <summary>Storing shadow appearance options for TMultiView. When Master view is sliding, TMultiView overflows
  /// detail view with using shadow layout</summary>
  TShadowAppearance = class(TMultiViewAppearance)
  public const
    DefaultEnabled = True;
    DefaultColor = TAlphaColorRec.Black;
    DefaultOpacity = 0.3;
  private
    FEnabled: Boolean;
    FColor: TAlphaColor;
    FOpacity: Single;
    procedure SetColor(const Value: TAlphaColor);
    procedure SetOpacity(const Value: Single);
    procedure SetEnabled(const Value: Boolean);
  protected
    function IsOpacityStored: Boolean; virtual;
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(AOwner: TComponent; const AInternalChange: TNotifyEvent);
    function AreDefaultValues: Boolean; override;
  published
    property Color: TAlphaColor read FColor write SetColor default DefaultColor;
    property Enabled: Boolean read FEnabled write SetEnabled default DefaultEnabled;
    property Opacity: Single read FOpacity write SetOpacity stored IsOpacityStored nodefault;
  end;

{ TPopoverAppearance }

  /// <summary>Storing options of popover presentation for TMultiView</summary>
  TPopoverAppearance = class(TMultiViewAppearance)
  public const
    DefaultHeight = 400;
    DefaultAppearanceDuration = 0.25;
    DefaultTintColor = TAlphaColorRec.Null;
  private
    FPopupHeight: Single;
    FAppearanceDuration: Single;
    FStyleLookup: string;
    FTintColor: TAlphaColor;
    procedure SetPopupHeight(const Value: Single);
    procedure SetStyleLookup(const Value: string);
    procedure SetAppearanceDuration(const Value: Single);
    procedure SetTintColor(const Value: TAlphaColor);
  protected
    function IsHeightStored: Boolean; virtual;
    /// <summary>Is value of <c>AppearanceDuration</c> default or not?</summary>
    function IsAppearanceDurationStored: Boolean; virtual;
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(AOwner: TComponent; const AInternalChange: TNotifyEvent);
    function AreDefaultValues: Boolean; override;
  published
    property StyleLookup: string read FStyleLookup write SetStyleLookup nodefault;
    property PopupHeight: Single read FPopupHeight write SetPopupHeight stored IsHeightStored nodefault;
    property AppearanceDuration: Single read FAppearanceDuration write SetAppearanceDuration
      stored IsAppearanceDurationStored nodefault;
    property TintColor: TAlphaColor read FTintColor write SetTintColor default DefaultTintColor;
  end;

{ TSplitViewAppearance }
  
  TSplitViewAppearance = class(TMultiViewAppearance)
  public const
    DefaultPlacement = TPanelPlacement.Left;
  private
    FPlacement: TPanelPlacement;
    procedure SetPlacement(const Value: TPanelPlacement);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(AOwner: TComponent; const AInternalChange: TNotifyEvent);
    function AreDefaultValues: Boolean; override;
  published
    property Placement: TPanelPlacement read FPlacement write SetPlacement default DefaultPlacement;
  end;

{ TNavigationPaneAppearance }

  /// <summary>Storing options of navigation pane presentation for TMultiView</summary>
  TNavigationPaneAppearance = class(TMultiViewAppearance)
  public const
    DefaultCollapsedWidth = 50;
  private
    FCollapsedWidth: Single;
    procedure SetCollapsedWidth(const Value: Single);
  protected
    /// <summary>Should we save <c>CollapsedWidth</c> value in resource or not</summary>
    function IsCollapsedWidthStored: Boolean; virtual;
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(AOwner: TComponent; const AInternalChange: TNotifyEvent);
    /// <summary>Are all values default or not?</summary>
    function AreDefaultValues: Boolean; override;
  published
    /// <summary>Size visible part of TMultiView in hidden state</summary>
    property CollapsedWidth: Single read FCollapsedWidth write SetCollapsedWidth stored IsCollapsedWidthStored nodefault;
  end;

implementation

uses
  System.Math, System.Math.Vectors, System.SysUtils, System.UIConsts, FMX.Types, FMX.Graphics, FMX.Consts, FMX.Forms,
  FMX.Presentation.Factory, FMX.MultiView.Types.Style {$IFDEF IOS}, FMX.MultiView.Types.iOS{$ENDIF};

{ TOverlayLayout }

constructor TCustomOverlayLayout.Create(AOwner: TComponent);
begin
  inherited;
  HitTest := True;
  AutoCapture := True;
  FMousePressedPos := TPointF.Zero;
  CanUseDefaultPresentation := False;
  SetAcceptsControls(False);
end;

function TCustomOverlayLayout.DefineModelClass: TDataModelClass;
begin
  Result := TCustomOverlayLayoutModel;
end;

procedure TCustomOverlayLayout.DoMouseLeave;
begin
  inherited;
  Pressed := False;
end;

function TCustomOverlayLayout.GetMode: TOverlayMode;
begin
  Result := Model.Mode;
end;

function TCustomOverlayLayout.GetModel: TCustomOverlayLayoutModel;
begin
  Result := inherited GetModel<TCustomOverlayLayoutModel>;
end;

function TCustomOverlayLayout.GetOnPointInObjectEvent: TOnPointInObjectEvent;
begin
  Result := Model.OnPointInObjectEvent;
end;

function TCustomOverlayLayout.GetInterceptionSize: Single;
begin
  Result := Model.InterceptionSize;
end;

function TCustomOverlayLayout.IsInterceptionSizeStored: Boolean;
begin
  Result := not SameValue(InterceptionSize, TCustomOverlayLayoutModel.DefaultSizeInterception, TEpsilon.Scale);
end;

procedure TCustomOverlayLayout.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FMousePressedPos := TPointF.Create(X, Y);
  inherited;
end;

procedure TCustomOverlayLayout.SetMode(const Value: TOverlayMode);
begin
  Model.Mode := Value;
end;

procedure TCustomOverlayLayout.SetOnPointInObjectEvent(const Value: TOnPointInObjectEvent);
begin
  Model.OnPointInObjectEvent := Value;
end;

procedure TCustomOverlayLayout.SetInterceptionSize(const Value: Single);
begin
  Model.InterceptionSize := Value;
end;

{ TShadowAppearance }

procedure TShadowAppearance.AssignTo(Dest: TPersistent);
var
  DestShadowAppearance: TShadowAppearance;
begin
  if Dest is TShadowAppearance then
  begin
    DestShadowAppearance := TShadowAppearance(Dest);
    DestShadowAppearance.Color := Color;
    DestShadowAppearance.Enabled := Enabled;
    DestShadowAppearance.Opacity := Opacity;
  end
  else
    inherited;
end;

constructor TShadowAppearance.Create(AOwner: TComponent; const AInternalChange: TNotifyEvent);
begin
  inherited;
  FColor := TAlphaColorRec.Black;
  FOpacity := DefaultOpacity;
  FEnabled := DefaultEnabled;
end;

function TShadowAppearance.AreDefaultValues: Boolean;
begin
  Result := inherited and not IsOpacityStored and (Enabled = DefaultEnabled) and (Color = DefaultColor);
end;

function TShadowAppearance.IsOpacityStored: Boolean;
begin
  Result := not SameValue(FOpacity, DefaultOpacity, TEpsilon.Scale);
end;

procedure TShadowAppearance.SetColor(const Value: TAlphaColor);
begin
  if Color <> Value then
  begin
    FColor := Value;
    DoChanged;
  end;
end;

procedure TShadowAppearance.SetEnabled(const Value: Boolean);
begin
  if Enabled <> Value then
  begin
    FEnabled := Value;
    DoChanged;
  end;
end;

procedure TShadowAppearance.SetOpacity(const Value: Single);
begin
  if not SameValue(Opacity, Value) then
  begin
    FOpacity := EnsureRange(Value, 0, 1);
    DoChanged;
  end;
end;

{ TSlidingAppearance }

procedure TDrawerAppearance.AssignTo(Dest: TPersistent);
var
  DestSlidingAppearance: TDrawerAppearance;
begin
  if Dest is TDrawerAppearance then
  begin
    DestSlidingAppearance := Dest as TDrawerAppearance;
    DestSlidingAppearance.DurationSliding := DurationSliding;
    DestSlidingAppearance.Mode := Mode;
    DestSlidingAppearance.TouchAreaSize := TouchAreaSize;
    DestSlidingAppearance.Placement := Placement;
  end
  else
    inherited;
end;

constructor TDrawerAppearance.Create(AOwner: TComponent; const AInternalChange: TNotifyEvent);
begin
  inherited;
  FDurationSliding := DefaultDurationSliding;
  FTouchAreaSize := DefaultTouchAreaSize;
  FMode := DefaultMode;
  FPlacement := DefaultPlacement;
end;

function TDrawerAppearance.AreDefaultValues: Boolean;
begin
  Result := inherited and not IsDurationSlidingStored and not IsTouchAreaSizeStored and (Mode = DefaultMode) and
    (Placement = DefaultPlacement);
end;

function TDrawerAppearance.IsDurationSlidingStored: Boolean;
begin
  Result := not SameValue(DurationSliding, DefaultDurationSliding, TEpsilon.Scale);
end;

function TDrawerAppearance.IsTouchAreaSizeStored: Boolean;
begin
  Result := not SameValue(TouchAreaSize, DefaultTouchAreaSize, TEpsilon.Scale);
end;

procedure TDrawerAppearance.SetPlacement(const Value: TPanelPlacement);
begin
  if Placement <> Value then
  begin
    FPlacement := Value;
    DoChanged;
  end;
end;

procedure TDrawerAppearance.SetDurationSliding(const Value: Single);
begin
  if not SameValue(DurationSliding, Value) then
  begin
    FDurationSliding := Value;
    DoChanged;
  end;
end;

procedure TDrawerAppearance.SetMode(const Value: TSlidingMode);
begin
  if Mode <> Value then
  begin
    FMode := Value;
    DoChanged;
  end;
end;

procedure TDrawerAppearance.SetTouchAreaSize(const Value: Single);
begin
  if not SameValue(TouchAreaSize, Value, TEpsilon.Position) then
  begin
    FTouchAreaSize := Value;
    DoChanged;
  end;
end;

{ TShadowedOverlayLayout }

constructor TShadowedOverlayLayout.Create(AOwner: TComponent);
begin
  inherited;
  FDesignSelectionMarks := False;
end;

function TShadowedOverlayLayout.DefineModelClass: TDataModelClass;
begin
  Result := TCustomShadowedOverlayLayoutModel;
end;

function TShadowedOverlayLayout.GetColor: TAlphaColor;
begin
  Result := Model.ShadowColor;
end;

function TShadowedOverlayLayout.GetEnabledShadow: Boolean;
begin
  Result := Model.EnabledShadow;
end;

function TShadowedOverlayLayout.GetModel: TCustomShadowedOverlayLayoutModel;
begin
  Result := inherited GetModel<TCustomShadowedOverlayLayoutModel>;
end;

procedure TShadowedOverlayLayout.SetColor(const Value: TAlphaColor);
begin
  Model.ShadowColor := Value;
end;

procedure TShadowedOverlayLayout.SetEnabledShadow(const Value: Boolean);
begin
  Model.EnabledShadow := Value;
end;

{ TPopoverAppearance }

procedure TPopoverAppearance.AssignTo(Dest: TPersistent);
var
  DestShadowAppearance: TPopoverAppearance;
begin
  if Dest is TPopoverAppearance then
  begin
    DestShadowAppearance := Dest as TPopoverAppearance;
    DestShadowAppearance.PopupHeight := PopupHeight;
    DestShadowAppearance.StyleLookup := StyleLookup;
  end
  else
    inherited;
end;

constructor TPopoverAppearance.Create(AOwner: TComponent; const AInternalChange: TNotifyEvent);
begin
  inherited;
  FPopupHeight := DefaultHeight;
  FAppearanceDuration := DefaultAppearanceDuration;
  FTintColor := DefaultTintColor;
end;

function TPopoverAppearance.AreDefaultValues: Boolean;
begin
  Result := inherited and not IsHeightStored and (StyleLookup = '') and not IsAppearanceDurationStored and
    (TintColor = DefaultTintColor);
end;

function TPopoverAppearance.IsAppearanceDurationStored: Boolean;
begin
  Result := not SameValue(AppearanceDuration, DefaultAppearanceDuration, TEpsilon.Scale);
end;

function TPopoverAppearance.IsHeightStored: Boolean;
begin
  Result := not SameValue(PopupHeight, DefaultHeight, TEpsilon.Scale);
end;

procedure TPopoverAppearance.SetAppearanceDuration(const Value: Single);
begin
  if not SameValue(Value, AppearanceDuration, TEpsilon.Scale) then
  begin
    FAppearanceDuration := Value;
    DoChanged;
  end;
end;

procedure TPopoverAppearance.SetPopupHeight(const Value: Single);
var
  NewValue: Single;
begin
  NewValue := Max(0, Value);
  if not SameValue(PopupHeight, NewValue, TEpsilon.Scale) then
  begin
    FPopupHeight := NewValue;
    DoChanged;
  end;
end;

procedure TPopoverAppearance.SetStyleLookup(const Value: string);
begin
  if StyleLookup <> Value then
  begin
    FStyleLookup := Value;
    DoChanged;
  end;
end;

procedure TPopoverAppearance.SetTintColor(const Value: TAlphaColor);
begin
  if TintColor <> Value then
  begin
    FTintColor := Value;
    DoChanged;
  end;
end;

{ TSplitViewAppearance }

function TSplitViewAppearance.AreDefaultValues: Boolean;
begin
  Result := Placement = DefaultPlacement;
end;

procedure TSplitViewAppearance.AssignTo(Dest: TPersistent);
var
  DestSplitViewAppearance: TSplitViewAppearance;
begin
  if Dest is TSplitViewAppearance then
  begin
    DestSplitViewAppearance := Dest as TSplitViewAppearance;
    DestSplitViewAppearance.Placement := Placement;
  end
  else
    inherited;
end;

constructor TSplitViewAppearance.Create(AOwner: TComponent; const AInternalChange: TNotifyEvent);
begin
  inherited;
  FPlacement := DefaultPlacement;
end;

procedure TSplitViewAppearance.SetPlacement(const Value: TPanelPlacement);
begin
  if Placement <> Value then
  begin
    FPlacement := Value;
    DoChanged;
  end;
end;

{ TCustomPopover }

constructor TCustomPopover.Create(AOwner: TComponent);
const
  PropertyToAppearanceAnimate = 'opacity';
begin
  inherited;
  FIndentFromScreenBorder := DefaultIndentFromScreenBorder;
  Placement := TPlacement.BottomCenter;
  FTopArrow.Direction := TArrowDirection.Top;
  FBottomArrow.Direction := TArrowDirection.Bottom;
  FLeftArrow.Direction := TArrowDirection.Left;
  FRightArrow.Direction := TArrowDirection.Right;
{$IFDEF IOS}
  FShadowEnabled := True;
{$ELSE}
  FShadowEnabled := False;
{$ENDIF}

  { Shadow }
  FShadow := TRectangle.Create(nil);
  FShadow.Align := TAlignLayout.Contents;
  FShadow.Opacity := 0;
  FShadow.HitTest := False;
  FShadow.Stored := False;
  FShadow.Stroke.Kind := TBrushKind.None;
  FShadow.Fill.Color := TAlphaColorRec.Black;
  FShadow.Lock;

  { Appearance animation }
  FOpacityAnimation := TFloatAnimation.Create(nil);
  FOpacityAnimation.Parent := Self;
  FOpacityAnimation.Stored := False;
  FOpacityAnimation.Duration := DefaultAppearanceDuration;
  FOpacityAnimation.PropertyName := PropertyToAppearanceAnimate;
  FOpacityAnimation.StartValue := 0;
  FOpacityAnimation.StopValue := 1;
end;

destructor TCustomPopover.Destroy;
begin
  FShadow.Parent := nil;
  FShadow.Free;
  inherited;
end;

procedure TCustomPopover.DoClosePopup;
begin
  FShadow.Parent := nil;
  inherited;
end;

procedure TCustomPopover.DoPlacementChanged(Sender: TObject);
begin
  UpdateArrowPosition;
end;

procedure TCustomPopover.DoPopup;
begin
  inherited;
  if FShadowEnabled and (PlacementTarget <> nil) and (PlacementTarget.Scene <> nil) then
  begin
    FShadow.Parent := PlacementTarget.Scene.GetObject;
    FShadow.BringToFront;
    FShadow.Opacity := 0;
    TAnimator.AnimateFloat(FShadow, 'opacity', DefaultShadowOpacity, AppearanceDuration);
  end;
end;

procedure TCustomPopover.ApplyStyle;

  procedure FindArrowStyleObjects(const ADirection: string; var AArrowInfo: TArrowInfo);
  const
    ArrowContentName = 'arrow-content-%s'; // do not localize
    ArrowName = 'arrow-%s'; // do not localize
  var
    StyleControl: TControl;
  begin
    if FindStyleResource<TControl>(Format(ArrowContentName, [ADirection]), StyleControl) then
    begin
      AArrowInfo.Container := StyleControl;
      AArrowInfo.Container.Visible := False;
    end
    else
      AArrowInfo.Container := nil;

    if FindStyleResource<TControl>(Format(ArrowName, [ADirection]), StyleControl) then
    begin
      AArrowInfo.Arrow := StyleControl;
      Supports(StyleControl, ITintedObject, AArrowInfo.Tint);
    end
    else
      AArrowInfo.Arrow := nil;
  end;

var
  StyleObject: TFmxObject;
begin
  inherited;
  { Background }
  StyleObject := FindStyleResource('bg');
  Supports(StyleObject, ITintedObject, FTintContent);

  { Content }
  FindStyleResource<TControl>('content', FContent);

  { Arrows }
  FindArrowStyleObjects('top', FTopArrow);
  FindArrowStyleObjects('bottom', FBottomArrow);
  FindArrowStyleObjects('left', FLeftArrow);
  FindArrowStyleObjects('right', FRightArrow);

  UpdatePadding;
  UpdateArrowPosition;
  UpdateTint;
end;

procedure TCustomPopover.FreeStyle;

  procedure ClearArrowInfo(var ArrowInfo: TArrowInfo);
  begin
    ArrowInfo.Container := nil;
    ArrowInfo.Arrow := nil;
    ArrowInfo.Tint := nil;
  end;

begin
  FTintContent := nil;
  ClearArrowInfo(FTopArrow);
  ClearArrowInfo(FBottomArrow);
  ClearArrowInfo(FLeftArrow);
  ClearArrowInfo(FRightArrow);
  inherited;
end;

function TCustomPopover.GetCurrentArrow: TArrowInfo;
begin
  if PopupForm is TCustomPopupForm then
    case TCustomPopupForm(PopupForm).RealPlacement of
      TPlacement.Bottom, TPlacement.BottomCenter:
        Result := FTopArrow;
      TPlacement.Top, TPlacement.TopCenter:
        Result := FBottomArrow;
      TPlacement.Left, TPlacement.LeftCenter:
        Result := FRightArrow;
      TPlacement.Right, TPlacement.RightCenter:
        Result := FLeftArrow;
    else
      Result := TArrowInfo.Empty;
    end
  else
    Result := TArrowInfo.Empty;
end;

function TCustomPopover.GetDefaultStyleLookupName: string;
begin
  Result := 'popoverstyle';
end;

procedure TCustomPopover.HideArrows;
begin
  if not FTopArrow.IsEmpty then
    FTopArrow.Container.Visible := False;
  if not FBottomArrow.IsEmpty then
    FBottomArrow.Container.Visible := False;
  if not FLeftArrow.IsEmpty then
    FLeftArrow.Container.Visible := False;
  if not FRightArrow.IsEmpty then
    FRightArrow.Container.Visible := False;
end;

function TCustomPopover.IsAppearanceDurationStored: Boolean;
begin
  Result := not SameValue(AppearanceDuration, DefaultAppearanceDuration, TEpsilon.Vector);
end;

function TCustomPopover.IsIndentFromScreenBorderStored: Boolean;
begin
  Result := not SameValue(IndentFromScreenBorder, DefaultIndentFromScreenBorder, TEpsilon.Vector);
end;

function TCustomPopover.IsTintColorStored: Boolean;
begin
  Result := FTintColor <> claNull;
end;

procedure TCustomPopover.Popup(const AShowModal: Boolean);
begin
  inherited;
  TCustomPopupForm(PopupForm).OnRealPlacementChanged := DoPlacementChanged;
  TCustomPopupForm(PopupForm).ContentPadding.Rect := TRectF.Create(-IndentFromScreenBorder, 0,
    -IndentFromScreenBorder, 0);
  FOpacityAnimation.Start;
end;

procedure TCustomPopover.SetAppearanceDuration(const Value: Single);
begin
  if not SameValue(Value, AppearanceDuration, TEpsilon.Vector) then
  begin
    FAppearanceDuration := Value;
    FOpacityAnimation.Duration := Value;
  end;
end;

procedure TCustomPopover.SetTintColor(const Value: TAlphaColor);
begin
  if FTintColor <> Value then
  begin
    FTintColor := Value;
    UpdateTint;
  end;
end;

procedure TCustomPopover.UpdateArrowPosition;
var
  PopupRect: TRectF;
  TargetControlRect: TRectF;
  LCurrentArrow: TArrowInfo;
  ArrowPosition: TPointF;

  function CalculateVerticalArrowPosition: TPointF;
  var
    Center: Single;
    ArrowOffset: Single;
  begin
    if (TargetControlRect.Right >= PopupRect.Right) and (TargetControlRect.Left <= PopupRect.Left) then
    begin
      Center := TargetControlRect.Width / 2;
      ArrowOffset := Center - LCurrentArrow.Arrow.Width / 2;
    end
    else if (TargetControlRect.Right < PopupRect.Right) and (TargetControlRect.Left > PopupRect.Left) then
    begin
      Center := TargetControlRect.Width / 2;
      ArrowOffset := (TargetControlRect.Left - PopupRect.Left) + (Center - LCurrentArrow.Arrow.Width / 2);
    end
    else if TargetControlRect.Right - PopupRect.Left < PopupRect.Right - TargetControlRect.Left then
    begin
      Center := (TargetControlRect.Right - PopupRect.Left) / 2;
      ArrowOffset := Center - LCurrentArrow.Arrow.Width / 2;
    end
    else
    begin
      Center := (PopupRect.Right - TargetControlRect.Left) / 2;
      ArrowOffset := Width - (Center + LCurrentArrow.Arrow.Width / 2);
    end;

    Result := TPointF.Create(ArrowOffset, 0);
  end;

  function CalcualteHorizontalArrowPosition: TPointF;
  var
    Center: Single;
    ArrowOffset: Single;
  begin
    if (TargetControlRect.Bottom >= PopupRect.Bottom) and (TargetControlRect.Top <= PopupRect.Top) then
    begin
      Center := TargetControlRect.Height / 2;
      ArrowOffset := Center - LCurrentArrow.Arrow.Height / 2;
    end
    else if (TargetControlRect.Bottom < PopupRect.Bottom) and (TargetControlRect.Top > PopupRect.Top) then
    begin
      Center := TargetControlRect.Height / 2;
      ArrowOffset := (TargetControlRect.Top - PopupRect.Top) + (Center - LCurrentArrow.Arrow.Height / 2);
    end
    else if TargetControlRect.Bottom - PopupRect.Top < PopupRect.Bottom - TargetControlRect.Top then
    begin
      Center := (TargetControlRect.Bottom - PopupRect.Top) / 2;
      ArrowOffset := Center - LCurrentArrow.Arrow.Height / 2;
    end
    else
    begin
      Center := (PopupRect.Bottom - TargetControlRect.Top) / 2;
      ArrowOffset := Height - (Center + LCurrentArrow.Arrow.Height / 2);
    end;

    Result := TPointF.Create(0, ArrowOffset);
  end;

begin
  if (PopupForm = nil) or (PlacementTarget = nil) or (PlacementTarget.Scene = nil) or
    (PlacementTarget.Scene.GetObject = nil) then
    Exit;

  TargetControlRect := PlacementTarget.AbsoluteRect;
  PopupRect := (PopupForm as TCustomPopupForm).ScreenContentRect;
  PopupRect.TopLeft := (PlacementTarget.Scene.GetObject as TCustomForm).ScreenToClient(PopupRect.TopLeft);
  PopupRect.BottomRight := (PlacementTarget.Scene.GetObject as TCustomForm).ScreenToClient(PopupRect.BottomRight);

  HideArrows;
  LCurrentArrow := GetCurrentArrow;
  if not LCurrentArrow.IsEmpty then
  begin
    case LCurrentArrow.Direction of
      TArrowDirection.Top, TArrowDirection.Bottom:
        ArrowPosition := CalculateVerticalArrowPosition;
      TArrowDirection.Left, TArrowDirection.Right:
        ArrowPosition := CalcualteHorizontalArrowPosition;
    end;
    LCurrentArrow.Arrow.Position.Point := ArrowPosition;
    LCurrentArrow.Container.Visible := True;
  end;

  UpdatePadding;
end;

function ConvertLocalRect(const ASourceLocal: TRectF; ASourceControl, ADestControl: TControl): TRectF;
var
  AbsoluteRect: TRectF;
begin
  AbsoluteRect.TopLeft := ASourceControl.LocalToAbsolute(ASourceLocal.TopLeft);
  AbsoluteRect.BottomRight := ASourceControl.LocalToAbsolute(ASourceLocal.BottomRight);
  Result.TopLeft := ADestControl.AbsoluteToLocal(AbsoluteRect.TopLeft);
  Result.BottomRight := ADestControl.AbsoluteToLocal(AbsoluteRect.BottomRight);
end;

procedure TCustomPopover.UpdatePadding;
var
  ContentRect: TRectF;
begin
  if FContent <> nil then
  begin
    ContentRect := ConvertLocalRect(FContent.LocalRect, FContent, Self);
    Padding.Left := ContentRect.Left;
    Padding.Top := ContentRect.Top;
    Padding.Bottom := Height - ContentRect.Bottom;
    Padding.Right := Width - ContentRect.Right;
  end
  else
    Padding.Rect := TRectF.Empty;
end;

procedure TCustomPopover.UpdateTint;
begin
  if FTopArrow.Tint <> nil then
    FTopArrow.Tint.TintColor := TintColor;

  if FBottomArrow.Tint <> nil then
    FBottomArrow.Tint.TintColor := TintColor;

  if FLeftArrow.Tint <> nil then
    FLeftArrow.Tint.TintColor := TintColor;

  if FRightArrow.Tint <> nil then
    FRightArrow.Tint.TintColor := TintColor;

  if FTintContent <> nil then
    FTintContent.TintColor := TintColor;
end;

{ TPopover.TArrowInfo }

class function TCustomPopover.TArrowInfo.Empty: TArrowInfo;
begin
  Result.Container := nil;
  Result.Arrow := nil;
  Result.Direction := TArrowDirection.None;
  Result.Tint := nil;
end;

function TCustomPopover.TArrowInfo.IsEmpty: Boolean;
begin
  Result := (Self.Container = nil) or (Self.Arrow = nil);
end;

{ TNavigationPaneAppearance }

function TNavigationPaneAppearance.AreDefaultValues: Boolean;
begin
  Result := inherited and not IsCollapsedWidthStored;
end;

procedure TNavigationPaneAppearance.AssignTo(Dest: TPersistent);
var
  DestNavigationPaneAppearance: TNavigationPaneAppearance;
begin
  if Dest is TNavigationPaneAppearance then
  begin
    DestNavigationPaneAppearance := Dest as TNavigationPaneAppearance;
    DestNavigationPaneAppearance.CollapsedWidth := CollapsedWidth;
  end
  else
    inherited;
end;

constructor TNavigationPaneAppearance.Create(AOwner: TComponent; const AInternalChange: TNotifyEvent);
begin
  inherited;
  FCollapsedWidth := DefaultCollapsedWidth;
end;

function TNavigationPaneAppearance.IsCollapsedWidthStored: Boolean;
begin
  Result := not SameValue(FCollapsedWidth, DefaultCollapsedWidth, TEpsilon.Scale);
end;

procedure TNavigationPaneAppearance.SetCollapsedWidth(const Value: Single);
var
  NewValue: Single;
begin
  NewValue := Max(0, Value);
  if not SameValue(NewValue, FCollapsedWidth, TEpsilon.Scale) then
  begin
    FCollapsedWidth := Value;
    DoChanged;
  end;
end;

{ TShadowedOverlayLayoutModel }

procedure TCustomShadowedOverlayLayoutModel.SetColor(const Value: TAlphaColor);
begin
  FColor := Value;
  SendMessage<TAlphaColor>(MM_COLOR_CHANGED, FColor);
end;

procedure TCustomShadowedOverlayLayoutModel.SetEnabledShadow(const Value: Boolean);
begin
  if FEnabledShadow <> Value then
  begin
    FEnabledShadow := Value;
    SendMessage<Boolean>(MM_ENABLED_SHADOW_CHANGED, FEnabledShadow);
  end;
end;

{ TCustomOverlayLayoutModel }

constructor TCustomOverlayLayoutModel.Create;
begin
  inherited Create;
  FMode := DefaultMode;
  FInterceptionSize := DefaultSizeInterception;
end;

procedure TCustomOverlayLayoutModel.SetMode(const Value: TOverlayMode);
begin
  if Mode <> Value then
  begin
    FMode := Value;
    SendMessage<TOverlayMode>(MM_MODE_CHANGED, Value);
  end;
end;

procedure TCustomOverlayLayoutModel.SetInterceptionSize(const Value: Single);
begin
  if not SameValue(FInterceptionSize, Value, TEpsilon.Scale) then
  begin
    FInterceptionSize := Value;
    SendMessage<Single>(MM_INTERCEPTION_SIZE_CHANGED, InterceptionSize);
  end;
end;

{ TMultiViewAppearance }

function TMultiViewAppearance.AreDefaultValues: Boolean;
begin
  Result := True;
end;

constructor TMultiViewAppearance.Create(AOwner: TComponent; const AInternalChange: TNotifyEvent);
begin
  inherited Create;
  FOwner := AOwner;
  FOnChanged := AInternalChange;
end;

procedure TMultiViewAppearance.DoChanged;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self); 
end;

function TMultiViewAppearance.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

initialization
  RegisterFmxClasses([TCustomOverlayLayout, TOverlayLayout, TShadowedOverlayLayout]);
end.
