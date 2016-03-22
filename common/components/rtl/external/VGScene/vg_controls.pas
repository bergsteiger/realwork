unit vg_controls;

{$I vg_define.inc}

interface

uses
  {$IFDEF WINDOWS} Windows, {$ENDIF}
  {$IFNDEF NOVCL} Graphics, Controls, Menus, Forms, Dialogs, ActnList, ImgList, vg_actions, {$ENDIF}
  {$IFDEF LCL} LCLType, {$ENDIF}
  {$IFDEF NOVCL} vg_forms, {$ENDIF}
  Variants, Classes, SysUtils, vg_scene, vg_objects, vg_ani,

  vgTypes,
  vgBitmap{,
  vgNonModelTypes}
  ;

type

  TvgSelectionItem = class(TvgControl) { Deprecated }
  private
  protected
    procedure PaintChildren; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
  published
    property Resource;
  end;

  TvgPanel = class(TvgControl)
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Resource;
  end;

  TvgCalloutPanel = class(TvgPanel)
  private
    FCalloutLength: single;
    FCalloutWidth: single;
    FCalloutPosition: TvgCalloutPosition;
    FCalloutOffset: single;
    procedure SetCalloutLength(const Value: single);
    procedure SetCalloutPosition(const Value: TvgCalloutPosition);
    procedure SetCalloutWidth(const Value: single);
    procedure SetCalloutOffset(const Value: single);
  protected
    procedure ApplyStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property CalloutWidth: single read FCalloutWidth write SetCalloutWidth;
    property CalloutLength: single read FCalloutLength write SetCalloutLength;
    property CalloutPosition: TvgCalloutPosition read FCalloutPosition write SetCalloutPosition default vgCalloutTop;
    property CalloutOffset: single read FCalloutOffset write SetCalloutOffset;
  end;

  TvgStatusBar = class(TvgControl)
  private
    FShowSizeGrip: boolean;
    procedure SetShowSizeGrip(const Value: boolean);
  protected
    procedure ApplyStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align default vaBottom;
    property Resource;
    property ShowSizeGrip: boolean read FShowSizeGrip write SetShowSizeGrip;
  end;

  TvgToolBar = class(TvgControl)
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align default vaTop;
    property Resource;
  end;

  TvgTextControl = class(TvgControl)
  private
    FFont: TvgFont;
    FTextAlign: TvgTextAlign;
    FVertTextAlign: TvgTextAlign;
    FFontFill: TvgBrush;
    FWordWrap: boolean;
    function GetText: WideString;
    procedure SetFont(const Value: TvgFont);
    procedure SetTextAlign(const Value: TvgTextAlign);
    procedure SetVertTextAlign(const Value: TvgTextAlign);
    procedure SetFontFill(const Value: TvgBrush);
    procedure FontFillChanged(Sender: TObject);
    procedure SetWordWrap(const Value: boolean);
  protected
    FText: WideString;
    procedure ApplyStyle; override;
    procedure SetText(const Value: WideString); virtual;
    procedure FontChanged(Sender: TObject); virtual;
    function GetData: Variant; override;
    procedure SetData(const Value: Variant); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    property Font: TvgFont read FFont write SetFont;
    property FontFill: TvgBrush read FFontFill write SetFontFill;
    property Text: WideString read GetText write SetText;
    property VertTextAlign: TvgTextAlign read FVertTextAlign write SetVertTextAlign;
    property TextAlign: TvgTextAlign read FTextAlign write SetTextAlign;
    property WordWrap: boolean read FWordWrap write SetWordWrap default false;
  published
  end;

  TvgLabel = class(TvgTextControl)
  private
    FWordWrap: boolean;
    FAutoSize: boolean;
    procedure SetWordWrap(const Value: boolean);
    procedure SetAutoSize(const Value: boolean);
  protected
    procedure ApplyStyle; override;
    procedure SetText(const Value: WideString); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AutoSize: boolean read FAutoSize write SetAutoSize default false;
    property AutoTranslate default true;
    property BindingSource;
    property Font;
    property TextAlign;
    property VertTextAlign;
    property Text;
    property Resource;
    property HitTest default false;
    property WordWrap: boolean read FWordWrap write SetWordWrap default true;
  end;

  TvgValueLabel = class(TvgLabel)
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AutoTranslate default false;
    property WordWrap default false;
  end;

  TvgCustomButton = class(TvgTextControl)
  private
    FPressing: boolean;
    FIsPressed: boolean;
    FModalResult: TModalResult;
    FStaysPressed: boolean;
    FRepeatTimer: TvgTimer;
    FRepeat: boolean;
    procedure SetIsPressed(const Value: boolean);
  protected
    procedure Click; override;
    procedure DblClick; override;
    procedure SetData(const Value: Variant); override;
    procedure ApplyStyle; override;
    procedure DoRepeatTimer(Sender: TObject);
    procedure DoRepeatDelayTimer(Sender: TObject);
    procedure pm_SetModalResult(Value: TModalResult); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
    procedure MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
  published
    {$IFNDEF NOVCL}
    property Action;
    {$ENDIF}
    property AutoTranslate default true;
    property StaysPressed: boolean read FStaysPressed write FStaysPressed;
    { triggers }
    property IsPressed: boolean read FIsPressed write SetIsPressed;
    { props }
    property CanFocused default true;
    property DisableFocusEffect;
    property TabOrder;
    property Font;
    property ModalResult: TModalResult read FModalResult write pm_SetModalResult default mrNone;
    property TextAlign;
    property Text;
    property RepeatClick: boolean read FRepeat write FRepeat default false;
    property WordWrap default false;
    property Resource;
  end;

  TvgButton = class(TvgCustomButton)
  private
    FDefault: boolean;
    FCancel: boolean;
  protected
    procedure DialogKey(var Key: Word; Shift: TShiftState); override;
    procedure pm_SetDefault(Value: boolean); virtual;
    procedure pm_SetCancel(Value: boolean); virtual;
  public
  published
    property CanFocused default true;
    property DisableFocusEffect;
    property Default: boolean read FDefault write pm_SetDefault default false;
    property Cancel: boolean read FCancel write pm_SetCancel default false;
    property TabOrder;
  end;

  TvgRoundButton = class(TvgButton)
  private
  protected
  public
  published
  end;

  TvgCircleButton = class(TvgButton)
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
  published
  end;

  TvgPopupButton = class(TvgButton)
  private
    {$IFNDEF NOVCL}
    FPopupMenu: TPopupMenu;
    {$ENDIF}
  protected
    procedure Click; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    {$IFNDEF NOVCL}
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
    {$ENDIF}
  end;

  TvgButtonLayout = (
    vgGlyphLeft,
    vgGlyphRight,
    vgGlyphTop,
    vgGlyphBottom,
    vgGlyphCenter
  );

  TvgBitmapButton = class(TvgCustomButton)
  private
    FBitmap: TvgBitmap;
    FBitmapLayout: TvgButtonLayout;
    FBitmapSpacing: single;
    FBitmapSize: single;
    FBitmapPadding: single;
    procedure SetBitmap(const Value: TvgBitmap);
    procedure SetBitmapLayout(const Value: TvgButtonLayout);
    procedure SetBitmapSpacing(const Value: single);
    procedure SetBitmapSize(const Value: single);
    procedure SetBitmapPadding(const Value: single);
  protected
    {$IFNDEF NOVCL}
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    {$ENDIF}
    procedure DoBitmapChanged(Sender: TObject);
    procedure ApplyStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
  published
    property Bitmap: TvgBitmap read FBitmap write SetBitmap;
    property BitmapLayout: TvgButtonLayout read FBitmapLayout write SetBitmapLayout default vgGlyphLeft;
    property BitmapSpacing: single read FBitmapSpacing write SetBitmapSpacing;
    property BitmapSize: single read FBitmapSize write SetBitmapSize;
    property BitmapPadding: single read FBitmapPadding write SetBitmapPadding;
  end;

  TvgPathButton = class(TvgCustomButton)
  private
    FPath: TvgPathData;
    FPathLayout: TvgButtonLayout;
    FPathSize: single;
    FPathSpacing: single;
    FPathPadding: single;
    FStrokeThickness: single;
    FFill: TvgBrush;
    FStroke: TvgBrush;
    FStrokeCap: TvgStrokeCap;
    FStrokeDash: TvgStrokeDash;
    FStrokeJoin: TvgStrokeJoin;
    procedure SetPath(const Value: TvgPathData);
    procedure SetPathLayout(const Value: TvgButtonLayout);
    procedure SetPathPadding(const Value: single);
    procedure SetPathSize(const Value: single);
    procedure SetPathSpacing(const Value: single);
    function isStrokeThicknessStored: Boolean;
    procedure SetFill(const Value: TvgBrush);
    procedure SetStroke(const Value: TvgBrush);
    procedure SetStrokeCap(const Value: TvgStrokeCap);
    procedure SetStrokeDash(const Value: TvgStrokeDash);
    procedure SetStrokeJoin(const Value: TvgStrokeJoin);
    procedure SetStrokeThickness(const Value: single);
  protected
    procedure DoPathChanged(Sender: TObject);
    procedure ApplyStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
  published
    property Path: TvgPathData read FPath write SetPath;
    property PathLayout: TvgButtonLayout read FPathLayout write SetPathLayout default vgGlyphLeft;
    property PathSpacing: single read FPathSpacing write SetPathSpacing;
    property PathSize: single read FPathSize write SetPathSize;
    property PathPadding: single read FPathPadding write SetPathPadding;
    property PathFill: TvgBrush read FFill write SetFill;
    property PathStroke: TvgBrush read FStroke write SetStroke;
    property PathStrokeThickness: single read FStrokeThickness write SetStrokeThickness stored isStrokeThicknessStored;
    property PathStrokeCap: TvgStrokeCap read FStrokeCap write SetStrokeCap default vgCapFlat;
    property PathStrokeDash: TvgStrokeDash read FStrokeDash write SetStrokeDash default vgDashSolid;
    property PathStrokeJoin: TvgStrokeJoin read FStrokeJoin write SetStrokeJoin default vgJoinMiter;
  end;

  TvgToolButton = class(TvgBitmapButton)
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
  published
    property CanFocused default false;
    property TabOrder;
    property BitmapLayout default vgGlyphTop;
  end;

  TvgToolPathButton = class(TvgPathButton)
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
  published
    property CanFocused default false;
    property TabOrder;
    property PathLayout default vgGlyphTop;
  end;

  TvgBitmapStateButton = class(TvgCustomButton)
  private
    FBitmap: TvgBitmap;
    FBitmapDown: TvgBitmap;
    FBitmapHot: TvgBitmap;
    procedure SetBitmap(const Value: TvgBitmap);
    procedure SetBitmapDown(const Value: TvgBitmap);
    procedure SetBitmapHot(const Value: TvgBitmap);
  protected
    procedure DoBitmapChanged(Sender: TObject);
    procedure ApplyStyle; override;
    procedure Paint; override;
    procedure MouseEnter; override;
    procedure MouseLeave; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    procedure StartTriggerAnimation(AInstance: TvgObject; ATrigger: string); override;
  published
    property Bitmap: TvgBitmap read FBitmap write SetBitmap;
    property BitmapHot: TvgBitmap read FBitmapHot write SetBitmapHot;
    property BitmapDown: TvgBitmap read FBitmapDown write SetBitmapDown;
  end;

  TvgSpeedButton = class(TvgCustomButton)
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
  published
    property CanFocused default false;
    property RepeatClick default true;
    property TabOrder;
  end;

  TvgColorButton = class(TvgCustomButton)
  private
    FFill: TvgShape;
    FColor: string;
    FOnChange: TNotifyEvent;
    FUseStandardDialog: boolean;
    procedure SetColor(const Value: string);
  protected
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure Click; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
  published
    property AutoTranslate default false;
    property CanFocused default true;
    property DisableFocusEffect;
    property TabOrder;
    property Color: string read FColor write SetColor;
    property UseStandardDialog: boolean read FUseStandardDialog write FUseStandardDialog default true;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TvgCornerButton = class(TvgCustomButton)
  private
    FyRadius: single;
    FxRadius: single;
    FCorners: TvgCorners;
    FCornerType: TvgCornerType;
    FSides: TvgSides;
    function IsCornersStored: Boolean;
    procedure SetxRadius(const Value: single);
    procedure SetyRadius(const Value: single);
    procedure SetCorners(const Value: TvgCorners);
    procedure SetCornerType(const Value: TvgCornerType);
    procedure SetSides(const Value: TvgSides);
    function IsSidesStored: Boolean;
  protected
    procedure ApplyStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
  published
    property xRadius: single read FxRadius write SetxRadius;
    property yRadius: single read FyRadius write SetyRadius;
    property Corners: TvgCorners read FCorners write SetCorners stored IsCornersStored;
    property CornerType: TvgCornerType read FCornerType write SetCornerType default vgCornerRound;
    property Sides: TvgSides read FSides write SetSides stored IsSidesStored;
  end;

  TvgCheckBox = class(TvgTextControl)
  private
    FPressing: boolean;
    FOnChange: TNotifyEvent;
    FIsPressed: boolean;
    FIsChecked: boolean;
    procedure SetIsChecked(const Value: boolean);
  protected
    procedure ApplyStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
    procedure MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    function GetData: Variant; override;
    procedure SetData(const Value: Variant); override;
    procedure ToggleChecked;
  published
    { triggers }
    property IsPressed: boolean read FIsPressed;
    property IsChecked: boolean read FIsChecked write SetIsChecked;
    { props }
    property AutoTranslate default true;
    property BindingSource;
    property CanFocused default true;
    property DisableFocusEffect;
    property TabOrder;
    property Font;
    property TextAlign;
    property Text;
    property Resource;
    property WordWrap;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TvgPathCheckBox = class(TvgCheckBox)
  private
    FPath: TvgPathData;
    procedure SetPath(const Value: TvgPathData);
  protected
    procedure ApplyStyle; override;
    procedure DoPathChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
  published
    property Resource;
    property Path: TvgPathData read FPath write SetPath;
  end;

  TvgRadioButton = class(TvgTextControl)
  private
    FPressing: boolean;
    FOnChange: TNotifyEvent;
    FIsPressed: boolean;
    FIsChecked: boolean;
    FGroupName: string;
    procedure SetIsChecked(const Value: boolean);
  protected
    procedure ApplyStyle; override;
    procedure EnterFocus; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
    procedure MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    function GetData: Variant; override;
    procedure SetData(const Value: Variant); override;
  published
    { triggers }
    property IsPressed: boolean read FIsPressed;
    property IsChecked: boolean read FIsChecked write SetIsChecked;
    { props }
    property AutoTranslate default true;
    property BindingSource;
    property CanFocused default true;
    property DisableFocusEffect;
    property TabOrder;
    property Font;
    property TextAlign;
    property Text;
    property Resource;
    property WordWrap;
    property GroupName: string read FGroupName write FGroupName;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TvgGroupBox = class(TvgTextControl)
  private
  protected
    procedure ApplyStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
  published
    property AutoTranslate default true;
    property Font;
    property TextAlign;
    property Text;
    property Resource;
  end;

  TvgCloseButton = class(TvgControl)
  private
    FPressing: boolean;
    FOnClick: TNotifyEvent;
    FCloseForm: boolean;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
    procedure MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
  published
    { props }
    property Resource;
    property CloseForm: boolean read FCloseForm write FCloseForm default true;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TvgSizeGrip = class(TvgControl, IvgSizeGrip)
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
  published
    property Resource;
  end;

  TvgSplitter = class(TvgControl)
  private
    FPressed: boolean;
    FControl: TvgVisualObject;
    FDownPos: TvgPoint;
    FMinSize: single;
    FMaxSize: single;
    FNewSize, FOldSize: single;
    FSplit: single;
    FShowGrip: boolean;
    procedure SetShowGrip(const Value: boolean);
  protected
    procedure ApplyStyle; override;
    procedure Paint; override;
    procedure SetAlign(const Value: TvgAlign); override;
    function FindObject: TvgVisualObject;
    procedure CalcSplitSize(X, Y: single; var NewSize, Split: single);
    procedure UpdateSize(X, Y: single);
    function DoCanResize(var NewSize: single): Boolean;
    procedure UpdateControlSize;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
    procedure MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
  published
    property MinSize: single read FMinSize write FMinSize;
    property ShowGrip: boolean read FShowGrip write SetShowGrip default true;
  end;

  TvgProgressBar = class(TvgControl)
  private
    FMin: single;
    FValue: single;
    FMax: single;
    FOrientation: TvgOrientation;
    procedure SetMax(const Value: single);
    procedure SetMin(const Value: single);
    procedure SetOrientation(const Value: TvgOrientation);
    procedure SetValue(const Value: single);
  protected
    procedure ApplyStyle; override;
    function GetData: Variant; override;
    procedure SetData(const Value: Variant); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    procedure Realign; override;
  published
    property BindingSource;
    property Min: single read FMin write SetMin;
    property Max: single read FMax write SetMax;
    property Orientation: TvgOrientation read FOrientation write SetOrientation;
    property Value: single read FValue write SetValue;
    property Resource;
  end;

  TvgCustomTrack = class;
  TvgScrollBar = class;

  TvgThumb = class(TvgControl)
  private
    FTrack: TvgCustomTrack;
    FDownOffset: TvgPoint;
    FPressed: boolean;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
    procedure MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
  published
    property Resource;
  end;

  TvgCustomTrack = class(TvgControl)
  private
    function GetThumb: TvgThumb;
    procedure SetFrequency(const Value: single);
    function GetIsTracking: boolean;
  protected
    FOnChange, FOnTracking: TNotifyEvent;
    FValue: single;
    FMin: single;
    FMax: single;
    FViewportSize: single;
    FOrientation: TvgOrientation;
    FTracking: boolean;
    FFrequency: single;
    procedure SetMax(const Value: single); virtual;
    procedure SetMin(const Value: single); virtual;
    procedure SetValue(Value: single);
    procedure SetViewportSize(const Value: single);
    procedure SetOrientation(const Value: TvgOrientation);
    function GetThumbRect: TvgRect;
    property Thumb: TvgThumb read GetThumb;
    function GetData: Variant; override;
    procedure SetData(const Value: Variant); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
    procedure MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    procedure Realign; override;
    property IsTracking: boolean read GetIsTracking;
    property Min: single read FMin write SetMin;
    property Max: single read FMax write SetMax;
    property Frequency: single read FFrequency write SetFrequency;
    property Orientation: TvgOrientation read FOrientation write SetOrientation;
    property Value: single read FValue write SetValue;
    property ViewportSize: single read FViewportSize write SetViewportSize;
    property Tracking: boolean read FTracking write FTracking default true;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnTracking: TNotifyEvent read FOnTracking write FOnTracking;
  end;

  TvgTrack = class(TvgCustomTrack)
  private
  protected
  public
  published
    property BindingSource;
    property Resource;
    property Min: single read FMin write SetMin;
    property Max: single read FMax write SetMax;
    property Frequency: single read FFrequency write SetFrequency;
    property Orientation: TvgOrientation read FOrientation write SetOrientation;
    property Value: single read FValue write SetValue;
    property ViewportSize: single read FViewportSize write SetViewportSize;
    property Tracking: boolean read FTracking write FTracking;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TvgTrackBar = class(TvgCustomTrack)
  private
  protected
    procedure SetMax(const Value: single); override;
    procedure SetMin(const Value: single); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property BindingSource;
    property CanFocused default true;
    property DisableFocusEffect;
    property TabOrder;
    property Resource;
    property Min: single read FMin write SetMin;
    property Max: single read FMax write SetMax;
    property Frequency: single read FFrequency write SetFrequency;
    property Orientation: TvgOrientation read FOrientation write SetOrientation;
    property Value: single read FValue write SetValue;
    property Tracking: boolean read FTracking write FTracking;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TvgScrollBar = class(TvgControl)
  private
    FOnChange: TNotifyEvent;
    FValue: single;
    FMin: single;
    FMax: single;
    FViewportSize: single;
    FOrientation: TvgOrientation;
    FSmallChange: single;
    procedure SetMax(const Value: single);
    procedure SetMin(const Value: single);
    procedure SetValue(const Value: single);
    procedure SetViewportSize(const Value: single);
    procedure SetOrientation(const Value: TvgOrientation);
  protected
    procedure DoTrackChanged(Sender: TObject);
    procedure DoMinButtonClick(Sender: TObject);
    procedure DoMaxButtonClick(Sender: TObject);
    function Track: TvgCustomTrack;
    function MinButton: TvgCustomButton;
    function MaxButton: TvgCustomButton;
    function GetData: Variant; override;
    procedure SetData(const Value: Variant); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    procedure Realign; override;
  published
    property BindingSource;
    property Resource;
    property Min: single read FMin write SetMin;
    property Max: single read FMax write SetMax;
    property Orientation: TvgOrientation read FOrientation write SetOrientation;
    property Value: single read FValue write SetValue;
    property ViewportSize: single read FViewportSize write SetViewportSize;
    property SmallChange: single read FSmallChange write FSmallChange;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TvgSmallScrollBar = class(TvgScrollBar)
  private
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TvgAniIndicatorStyle = (
    vgAniIndicatorLine,
    vgAniIndicatorCircle
  );

  TvgAniIndicator = class(TvgControl)
  private
    FDragTimer: TvgTimer;
    FLayout: TvgVisualObject;
    FAni: TvgFloatAnimation;
    FEnabled: boolean;
    FStyle: TvgAniIndicatorStyle;
    procedure SetEnabled(const Value: boolean);
    procedure SetStyle(const Value: TvgAniIndicatorStyle);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    procedure Paint; override;
  published
    property Enabled: boolean read FEnabled write SetEnabled;
    property Style: TvgAniIndicatorStyle read FStyle write SetStyle;
  end;

  TvgAngleButton = class(TvgControl)
  private
    FPressing: boolean;
    FOnChange: TNotifyEvent;
    FOldPos: TvgPoint;
    FSaveValue, FValue: single;
    FFrequency: single;
    FTracking: boolean;
    FShowValue: boolean;
    procedure SetValue(const Value: single);
    procedure SetShowValue(const Value: boolean);
  protected
    function Tick: TvgVisualObject;
    function Text: TvgText;
    procedure ApplyStyle; override;
    function GetData: Variant; override;
    procedure SetData(const Value: Variant); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
    procedure MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
  published
    { props }
    property BindingSource;
    property Resource;
    property Frequency: single read FFrequency write FFrequency;
    property Tracking: boolean read FTracking write FTracking default true;
    property ShowValue: boolean read FShowValue write SetShowValue default false;
    property Value: single read FValue write SetValue;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;          

  TvgExpanderButton = class(TvgCustomButton)
  private
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
  published
    property CanFocused default false;
  end;

  TvgExpander = class(TvgTextControl)
  private
    FShowCheck: boolean;
    FIsChecked: boolean;
    FOnCheckChange: TNotifyEvent;
    procedure DoButtonClick(Sender: TObject);
    procedure SetIsChecked(const Value: boolean);
    procedure SetShowCheck(const Value: boolean);
  protected
    FIsExpanded: boolean;
    FContent: TvgContent;
    FButton: TvgCustomButton;
    FCheck: TvgCheckBox;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure SetIsExpanded(const Value: boolean); virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadContentSize(Reader: TReader);
    procedure WriteContentSize(Writer: TWriter);
    {$IfDef vgDesign}
    procedure DesignClick; override;
    {$EndIf vgDesign}
    procedure DoCheckChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    procedure Realign; override;
    procedure AddObject(AObject: TvgObject); override;
  published
    property Font;
    property TextAlign;
    property Text;
    property Resource;
    property AutoTranslate default true;
    property IsExpanded: boolean read FIsExpanded write SetIsExpanded default true;
    property IsChecked: boolean read FIsChecked write SetIsChecked default true;
    property ShowCheck: boolean read FShowCheck write SetShowCheck;
    property OnCheckChange: TNotifyEvent read FOnCheckChange write FOnCheckChange;
  end;

  TvgPopupBox = class(TvgCustomButton)
  private
    FItems: TvgWideStrings;
    FItemIndex: integer;
    {$IFNDEF NOVCL}
    FPopup: TPopupMenu;
    {$ENDIF}
    FOnChange: TNotifyEvent;
    procedure SetItems(const Value: TvgWideStrings);
    procedure SetItemIndex(const Value: integer);
  protected
    procedure ApplyStyle; override;
    procedure Click; override;
    procedure DoItemsChanged(Sender: TObject); virtual;
    procedure DoItemClick(Sender: TObject);
    procedure DoPopup; virtual;
    function GetData: Variant; override;
    procedure SetData(const Value: Variant); override;
    procedure SetText(const Value: WideString); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
  published
    property BindingSource;
    property CanFocused default true;
    property DisableFocusEffect;
    property TabOrder;
    property Text stored false;
    property Items: TvgWideStrings read FItems write SetItems;
    property ItemIndex: integer read FItemIndex write SetItemIndex;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TvgWindow = class(TvgTextControl)
  private
    FShowCloseButton: boolean;
    FShowSizeGrip: boolean;
    FOnCloseClick: TNotifyEvent;
    procedure SetShowCloseButton(const Value: boolean);
    procedure SetShowSizeGrip(const Value: boolean);
  protected
    procedure ApplyStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
  published
    property ShowCloseButton: boolean read FShowCloseButton write SetShowCloseButton default true;
    property ShowSizeGrip: boolean read FShowSizeGrip write SetShowSizeGrip default true;
    property OnCloseClick: TNotifyEvent read FOnCloseClick write FOnCloseClick;
    { props }
    property AutoTranslate default true;
    property Font;
    property TextAlign;
    property Text;
    property Resource;
  end;

  TvgCloseAlign = (
    vgButtonAlignLeft,
    vgButtonAlignRight
  );

  TvgHudWindow = class(TvgWindow)
  private
    FDisableShadowOnOSX: boolean;
    FFill: TvgBrush;
    FStrokeThickness: single;
    FStroke: TvgBrush;
    FStrokeCap: TvgStrokeCap;
    FStrokeDash: TvgStrokeDash;
    FStrokeJoin: TvgStrokeJoin;
    FCloseAlign: TvgCloseAlign;
    FShowCaption: boolean;
    procedure SetDisableShadowOnOSX(const Value: boolean);
    procedure SetFill(const Value: TvgBrush);
    function isStrokeThicknessStored: Boolean;
    procedure SetStroke(const Value: TvgBrush);
    procedure SetStrokeCap(const Value: TvgStrokeCap);
    procedure SetStrokeDash(const Value: TvgStrokeDash);
    procedure SetStrokeJoin(const Value: TvgStrokeJoin);
    procedure SetStrokeThickness(const Value: single);
    procedure SetCloseAlign(const Value: TvgCloseAlign);
    procedure SetShowCaption(const Value: boolean);
  protected
    procedure ApplyStyle; override;
    procedure DoFillChanged(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
  published
    property DisableShadowOnOSX: boolean read FDisableShadowOnOSX write SetDisableShadowOnOSX default true;
    property ButtonAlign: TvgCloseAlign read FCloseAlign write SetCloseAlign default vgButtonAlignLeft;
    property Fill: TvgBrush read FFill write SetFill;
    property Stroke: TvgBrush read FStroke write SetStroke;
    property StrokeThickness: single read FStrokeThickness write SetStrokeThickness stored isStrokeThicknessStored;
    property StrokeCap: TvgStrokeCap read FStrokeCap write SetStrokeCap default vgCapFlat;
    property StrokeDash: TvgStrokeDash read FStrokeDash write SetStrokeDash default vgDashSolid;
    property StrokeJoin: TvgStrokeJoin read FStrokeJoin write SetStrokeJoin default vgJoinMiter;
    property ShowCaption: boolean read FShowCaption write SetShowCaption default true;
  end;

  TvgImageControl = class(TvgControl)
  private
    FImage: TvgImage;
    FOnChange: TNotifyEvent;
    FBitmap: TvgBitmap;
    FEnableOpenDialog: boolean;
    procedure SetBitmap(const Value: TvgBitmap);
  protected
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure Click; override;
    procedure DragOver(const Data: TvgDragObject; const Point: TvgPoint; var Accept: Boolean); override;
    procedure DragDrop(const Data: TvgDragObject; const Point: TvgPoint); override;
    procedure DoBitmapChanged(Sender: TObject); virtual;
    function GetData: Variant; override;
    procedure SetData(const Value: Variant); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
  published
    property CanFocused default true;
    property DisableFocusEffect;
    property EnableOpenDialog: boolean read FEnableOpenDialog write FEnableOpenDialog default true;
    property TabOrder;
    property Bitmap: TvgBitmap read FBitmap write SetBitmap;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TvgHudLabel = class(TvgLabel)
  private
  protected
  public
  published
  end;

  TvgHudButton = class(TvgButton)
  private
  protected
  public
  published
  end;

  TvgHudRoundButton = class(TvgButton)
  private
  protected
  public
  published
  end;

  TvgHudCircleButton = class(TvgCircleButton)
  private
  protected
  public
  published
  end;

  TvgHudCornerButton = class(TvgCornerButton)
  private
  protected
  public
  published
  end;

  TvgHudSpeedButton = class(TvgSpeedButton)
  private
  protected
  public
  published
  end;

  TvgHudCheckBox = class(TvgCheckBox)
  private
  protected     
  public
  published
  end;

  TvgHudRadioButton = class(TvgRadioButton)
  private
  protected
  public
  published
  end;

  TvgHudGroupBox = class(TvgGroupBox)
  private
  protected
  public
  published
  end;

  TvgHudPopupBox = class(TvgPopupBox)
  private
  protected
  public
  published
  end;

  TvgHudAngleButton = class(TvgAngleButton)
  private
  protected
  public
  published
  end;

  TvgHudTrack = class(TvgTrack)
  private
  protected
  public
  published
  end;

  TvgHudTrackBar = class(TvgTrackBar)
  private
  protected
  public
  published
  end;

  TvgHudScrollBar = class(TvgScrollBar)
  private
  protected
  public
  published
  end;

  TvgLayerWindow = class(TvgHudWindow)
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
  published
  end;

  TvgHudPanel = class(TvgPanel)
  private
  protected
  public
  published
  end;

  TvgHudCloseButton = class(TvgCloseButton)
  private
  protected
  public
  published
  end;

  TvgHudSizeGrip = class(TvgSizeGrip)
  private
  protected
  public
  published
  end;

  TvgHudStatusBar = class(TvgStatusBar)
  private
  protected
  public
  published
  end;

implementation {===============================================================}

uses
  {$IFNDEF NOVCL}
  vg_dsgn,
  {$ENDIF}
  Math, vg_layouts,

  vgObjectList,
  vgAnyObjectList,
  vgCustomObjectList
  ;

{$R *.res}

{ TvgSelectionItem }

constructor TvgSelectionItem.Create(AOwner: TComponent);
begin
  inherited;
  HitTest := false;
end;

procedure TvgSelectionItem.Paint;
begin
  inherited;
end;

procedure TvgSelectionItem.PaintChildren;
begin
  if csDesigning in ComponentState then Exit;
  inherited;
end;

{ TvgPanel ====================================================================}

constructor TvgPanel.Create(AOwner: TComponent);
begin
  inherited;
  Width := 120;
  Height := 100;
end;

{ TvgCalloutPanel }

constructor TvgCalloutPanel.Create(AOwner: TComponent);
begin
  inherited;
  FCalloutWidth := 23;
  FCalloutLength := 11;
end;

procedure TvgCalloutPanel.ApplyStyle;
var
  Back: TvgObject;
begin
  inherited;
  Back := FindResource('Backgound');
  if (Back = nil) and (FResourceLink is TvgCalloutRectangle) then
    Back := FResourceLink;
  if (Back <> nil) and (Back is TvgCalloutRectangle) then
  begin
    TvgCalloutRectangle(Back).CalloutWidth := FCalloutWidth;
    TvgCalloutRectangle(Back).CalloutLength := FCalloutLength;
    TvgCalloutRectangle(Back).CalloutPosition := FCalloutPosition;
    TvgCalloutRectangle(Back).CalloutOffset := FCalloutOffset;
  end;
end;

procedure TvgCalloutPanel.SetCalloutLength(const Value: single);
begin
  if FCalloutLength <> Value then
  begin
    FCalloutLength := Value;
    ApplyStyle;
  end;
end;

procedure TvgCalloutPanel.SetCalloutPosition(
  const Value: TvgCalloutPosition);
begin
  if FCalloutPosition <> Value then
  begin
    FCalloutPosition := Value;
    ApplyStyle;
  end;
end;

procedure TvgCalloutPanel.SetCalloutWidth(const Value: single);
begin
  if FCalloutWidth <> Value then
  begin
    FCalloutWidth := Value;
    ApplyStyle;
  end;
end;

procedure TvgCalloutPanel.SetCalloutOffset(const Value: single);
begin
  if FCalloutOffset <> Value then
  begin
    FCalloutOffset := Value;
    ApplyStyle;
  end;
end;

{ TvgStatusBar }

constructor TvgStatusBar.Create(AOwner: TComponent);
begin
  inherited;
  FShowSizeGrip := true;
  Height := 22;
  Align := vaBottom;
end;

procedure TvgStatusBar.ApplyStyle;
var
  sizeGrip: TvgObject;
begin
  inherited;
  sizeGrip := FindResource('sizegrip');
  if (sizeGrip <> nil) and (sizeGrip is TvgVisualObject) then
  begin
    TvgVisualObject(sizeGrip).visible := FShowSizeGrip;
    if (Scene <> nil)
       {$IfDef vgDesign}and not (Scene.GetDesignTime){$EndIf vgDesign} then
    begin
      TvgVisualObject(sizeGrip).Locked := false;
      TvgVisualObject(sizeGrip).HitTest := true;
    end;//Scene <> nil..
  end;//sizeGrip <> nil..
end;

procedure TvgStatusBar.SetShowSizeGrip(const Value: boolean);
begin
  if FShowSizeGrip <> Value then
  begin
    FShowSizeGrip := Value;
    Resource := FResource;
  end;
end;

{ TvgToolBar }

constructor TvgToolBar.Create(AOwner: TComponent);
begin
  inherited;
  Height := 40;
  Align := vaTop;
end;

{ TvgTextControl ===================================================================}

constructor TvgTextControl.Create(AOwner: TComponent);
begin
  inherited;
  FFont := TvgFont.Create;
  FFont.OnChanged := FontChanged;
  FFontFill := TvgBrush.Create(vgBrushSolid, $FF000000);
  FFontFill.OnChanged := FontFillChanged;
  FWordWrap := false;
end;

procedure TvgTextControl.Cleanup;
begin
  FreeAndNil(FFontFill);
  FreeAndNil(FFont);
  inherited;
end;

function TvgTextControl.GetData: Variant;
begin
  Result := Text;
end;

procedure TvgTextControl.SetData(const Value: Variant);
begin
  if VarIsNull(Value) then
    Text := ''
  else
    if VarIsType(Value, varDate) then
      Text := DateTimeToStr(VarToDateTime(Value))
    else
      Text := VarToWideStr(Value);
end;

procedure TvgTextControl.ApplyStyle;
var
  S: TvgObject;
  NewT: WideString;
begin
  inherited;
  { from style }
  S := FindResource('foreground');
  if (S <> nil) and (S is TvgBrushObject) then
    FontFill.Assign(TvgBrushObject(S).Brush);
  { to style }
  S := FindResource('text');
  if (S <> nil) and (S is TvgText) then
  begin
    TvgText(S).Text := FText;
    TvgText(S).HorzTextAlign := FTextAlign;
    TvgText(S).VertTextAlign := FVertTextAlign;
    TvgText(S).WordWrap := FWordWrap;
    TvgText(S).Font.Assign(FFont);
  end;
  { translate }
  if FAutoTranslate then
  begin
    NewT := Translate(Text); // need for collection texts
    if (FScene <> nil)
       {$IfDef vgDesign}and not (FScene.GetDesignTime){$EndIf vgDesign} then
      Text := NewT;
  end;
end;

procedure TvgTextControl.FontChanged(Sender: TObject);
var
  T: TvgObject;
begin
  T := FindResource('text');
  if (T <> nil) and (T is TvgText) then
    TvgText(T).Font.Assign(FFont);
end;

procedure TvgTextControl.FontFillChanged(Sender: TObject);
var
  T: TvgObject;
begin
  T := FindResource('text');
  if (T <> nil) and (T is TvgText) then
    TvgText(T).Fill.Assign(FontFill);
end;

function TvgTextControl.GetText: WideString;
begin
  Result := FText;
end;

procedure TvgTextControl.SetText(const Value: WideString);
var
  T: TvgObject;
begin
  if FText <> Value then
  begin
    FText := Value;
    T := FindResource('text');
    if (T <> nil) and (T is TvgText) then
    begin
      TvgText(T).Text := FText;
      TvgText(T).UpdateEffects;
    end
    else
      if (FResourceLink <> nil) and (FResourceLink is TvgText) then
        TvgText(FResourceLink).Text := FText
      else
        Repaint;
    UpdateEffects;
  end;
end;

procedure TvgTextControl.SetFontFill(const Value: TvgBrush);
begin
  FFontFill := Value;
end;

procedure TvgTextControl.SetFont(const Value: TvgFont);
begin
  FFont.Assign(Value);
end;

procedure TvgTextControl.SetTextAlign(const Value: TvgTextAlign);
var
  T: TvgObject;
begin
  FTextAlign := Value;
  T := FindResource('text');
  if (T <> nil) and (T is TvgText) then
    TvgText(T).HorzTextAlign := FTextAlign
  else
    Repaint;
end;

procedure TvgTextControl.SetVertTextAlign(const Value: TvgTextAlign);
var
  T: TvgObject;
begin
  FVertTextAlign := Value;
  T := FindResource('text');
  if (T <> nil) and (T is TvgText) then
    TvgText(T).VertTextAlign := FVertTextAlign
  else
    Repaint;
end;

procedure TvgTextControl.SetWordWrap(const Value: boolean);
var
  T: TvgObject;
begin
  FWordWrap := Value;
  T := FindResource('text');
  if (T <> nil) and (T is TvgText) then
    TvgText(T).WordWrap := Value;
end;

{ TvgLabel }

constructor TvgLabel.Create(AOwner: TComponent);
begin
  inherited;
  FAutoTranslate := true;
  Width := 120;
  Height := 15;
  FWordWrap := true;
  HitTest := false;
end;

procedure TvgLabel.ApplyStyle;
var
  T: TvgObject;
  S: TvgAlign;
begin
  inherited;
  T := FindResource('text');
  if (T <> nil) and (T is TvgText) then
  begin
    TvgText(T).WordWrap := WordWrap;
    if AutoSize then
    begin
      FWordWrap := false;
      TvgText(T).WordWrap := false;
      TvgText(T).VertTextAlign := vgTextAlignNear;
      TvgText(T).HorzTextAlign := vgTextAlignNear;

      S := TvgText(T).Align;
      TvgText(T).Align := vaNone;
      TvgText(T).AutoSize := true;
      Width := TvgText(T).Width;
      Height := TvgText(T).Height;
      TvgText(T).AutoSize := false;
      TvgText(T).Align := S;
    end;
  end;
end;

procedure TvgLabel.SetWordWrap(const Value: boolean);
var
  T: TvgObject;
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    T := FindResource('text');
    if (T <> nil) and (T is TvgText) then
      TvgText(T).WordWrap := Value;
  end;
end;

procedure TvgLabel.SetAutoSize(const Value: boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    if FAutoSize then
    begin
      ApplyStyle;
    end;
  end;
end;

procedure TvgLabel.SetText(const Value: WideString);
begin
  if Value <> FText then
  begin
    inherited;
    if FAutoSize then
      ApplyStyle;
  end
  else
    inherited;
end;

{ TvgValueLabel }

constructor TvgValueLabel.Create(AOwner: TComponent);
begin
  inherited;
  FAutoTranslate := false;
  FWordWrap := false;
end;

{ TvgCustomButton ===================================================================}

procedure TvgCustomButton.ApplyStyle;
begin
  inherited;
  StartTriggerAnimation(Self, 'IsPressed');
  ApplyTriggerEffect(Self, 'IsPressed');
end;

constructor TvgCustomButton.Create(AOwner: TComponent);
begin
  inherited;
  FAutoTranslate := true;
  FWordWrap := false;
  Width := 80;
  Height := 22;
  AutoCapture := true;
  CanFocused := true;
end;

procedure TvgCustomButton.Cleanup;
begin
  if FRepeatTimer <> nil then
    FreeAndNil(FRepeatTimer);
  inherited;
end;

procedure TvgCustomButton.KeyDown(var Key: Word; var KeyChar: System.WideChar;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) or (Key = VK_SPACE) then
  begin
    Click;
  end;
end;

procedure TvgCustomButton.DoRepeatTimer(Sender: TObject);
begin
  Click;
end;

procedure TvgCustomButton.DoRepeatDelayTimer(Sender: TObject);
begin
  FRepeatTimer.OnTimer := DoRepeatTimer;
  FRepeatTimer.Interval := 100;
end;

procedure TvgCustomButton.DblClick;
begin
  inherited;
  Click;
end;

procedure TvgCustomButton.Click;
var
  O: TComponent;
begin
  if Assigned(Self) and (ModalResult <> mrNone) then
  begin
    O := Scene.GetComponent;
    while O <> nil do
    begin
      if (O is TCustomForm) then
      begin
        TCustomForm(O).ModalResult := FModalResult;
        Break;
      end;
      O := O.Owner;
    end;
  end;
  inherited;
end;

procedure TvgCustomButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: single);
begin
  inherited;
  if Button = mbLeft then
  begin
    FPressing := true;
    if FStaysPressed then
      FIsPressed := not FIsPressed
    else
    begin
      FIsPressed := true;
      if FRepeat then
      begin
        if FRepeatTimer = nil then
        begin
          FRepeatTimer := TvgTimer.Create(Self);
          FRepeatTimer.Interval := 500;
        end;
        FRepeatTimer.OnTimer := DoRepeatDelayTimer;
        FRepeatTimer.Enabled := true;
      end;
    end;
    StartTriggerAnimation(Self, 'IsPressed');
    ApplyTriggerEffect(Self, 'IsPressed');
  end;
end;

procedure TvgCustomButton.MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single);
begin
  inherited;
  if (ssLeft in Shift) and (FPressing) then
  begin
    if FIsPressed <> vgPtInRect(vgPoint(X, Y), LocalRect) then
    begin
      if not FStaysPressed then
      begin
        FIsPressed := vgPtInRect(vgPoint(X, Y), LocalRect);
        StartTriggerAnimation(Self, 'IsPressed');
        ApplyTriggerEffect(Self, 'IsPressed');
      end;
    end;
  end;
end;

procedure TvgCustomButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: single);
begin
  if FPressing then
  begin
    if FRepeatTimer <> nil then
      FRepeatTimer.Enabled := false;
    FPressing := false;
    if not FStaysPressed then
    begin
      FIsPressed := false;
      StartTriggerAnimation(Self, 'IsPressed');
      ApplyTriggerEffect(Self, 'IsPressed');
    end;
  end;
  inherited;
end;

procedure TvgCustomButton.SetData(const Value: Variant);
begin
  if VarIsEvent(Value) then
    OnClick := VariantToEvent(Value);
end;

procedure TvgCustomButton.pm_SetModalResult(Value: TModalResult);
begin
 FModalResult := Value;
end;

procedure TvgCustomButton.SetIsPressed(const Value: boolean);
begin
  if FStaysPressed then
  begin
    if Value <> FIsPressed then
    begin
      FIsPressed := Value;
      StartTriggerAnimation(Self, 'IsPressed');
      ApplyTriggerEffect(Self, 'IsPressed');
    end;
  end;
end;

{ TvgButton }

procedure TvgButton.DialogKey(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Default and (Key = VK_RETURN) then
  begin
    Click;
    Key := 0;
  end;
  if Cancel and (Key = VK_ESCAPE) then
  begin
    Click;
    Key := 0;
  end;
end;

procedure TvgButton.pm_SetDefault(Value: boolean);
begin
 FDefault := Value;
end;

procedure TvgButton.pm_SetCancel(Value: boolean);
begin
 FCancel := Value;
end;

{ TvgCircleButton }

constructor TvgCircleButton.Create(AOwner: TComponent);
begin
  inherited;
  Width := 21;
  Height := 21;
end;

{ TvgPopupButton }

constructor TvgPopupButton.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TvgPopupButton.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  {$IFNDEF NOVCL}
  if (Operation = opRemove) and (AComponent = FPopupMenu) then
    FPopupMenu := nil;
  {$ENDIF}
end;

procedure TvgPopupButton.Click;
var
  VP: TvgPoint;
begin
  inherited;
  {$IFNDEF NOVCL}
  if FPopupMenu = nil then Exit;
  if Scene <> nil then
  begin
    VP := LocalToAbsolute(vgPoint(0, Height));
    VP := Scene.LocalToScreen(VP);
    FPopupMenu.Popup(round(VP.X), round(VP.Y));
  end;
  {$ENDIF}
end;

{ TvgBitmapButton }

constructor TvgBitmapButton.Create(AOwner: TComponent);
begin
  inherited;
  FBitmap := TvgBitmap.Create(1, 1);
  FBitmap.OnChange := DoBitmapChanged;
  FBitmapLayout := vgGlyphLeft;
  FBitmapSize := 32;
  FBitmapPadding := 2;
  Width := 50;
  Height := 60;
end;

procedure TvgBitmapButton.Cleanup;
begin
  FreeAndNil(FBitmap);
  inherited;
end;

{$IFNDEF NOVCL}
procedure TvgBitmapButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);

  procedure CopyImage(ImageList: TCustomImageList; Index: Integer);
  begin
    BitmapSize := ImageList.Width;
    if ImageList is TvgImageList then
      Bitmap.Assign(TvgImageList(ImageList).Images[Index]);
  end;

begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      { Copy image from action's imagelist }
      if (Bitmap.Width <= 1) and (ActionList <> nil) and (ActionList.Images <> nil) and (ActionList.Images is TvgImageList) and
        (ImageIndex >= 0) and (ImageIndex < TvgImageList(ActionList.Images).Count) then
        CopyImage(ActionList.Images, ImageIndex);
    end;
end;
{$ENDIF}

procedure TvgBitmapButton.ApplyStyle;
var
  T: TvgObject;
begin
  inherited;
  DoBitmapChanged(Self);
  T := FindResource('text');
  if (T <> nil) and (T is TvgVisualObject) then
  begin
    TvgVisualObject(T).Padding.Rect := vgRect(FBitmapPadding, FBitmapPadding, FBitmapPadding, FBitmapPadding);
  end;
end;

procedure TvgBitmapButton.DoBitmapChanged(Sender: TObject);
var
  T: TvgObject;
begin
  T := FindResource('image');
  if (T <> nil) and (T is TvgImage) then
  begin
    TvgImage(T).Bitmap.Assign(FBitmap);
    TvgVisualObject(T).Padding.Rect := vgRect(FBitmapPadding, FBitmapPadding, FBitmapPadding, FBitmapPadding);
    if ((TvgImage(T).Bitmap.Width = 1) or (TvgImage(T).Bitmap.Height = 1)) and (TvgImage(T).Bitmap.ResourceName = '') then
    begin
      TvgVisualObject(T).Align := vaNone;
    end
    else
      case FBitmapLayout of
        vgGlyphLeft: begin
          TvgVisualObject(T).Align := vaLeft;
          TvgVisualObject(T).Width := FBitmapSize;
          TvgVisualObject(T).Padding.right := FBitmapSpacing;
        end;
        vgGlyphRight: begin
          TvgVisualObject(T).Align := vaRight;
          TvgVisualObject(T).Width := FBitmapSize;
          TvgVisualObject(T).Padding.left := FBitmapSpacing;
        end;
        vgGlyphTop: begin
          TvgVisualObject(T).Align := vaTop;
          TvgVisualObject(T).Height := FBitmapSize;
          TvgVisualObject(T).Padding.bottom := FBitmapSpacing;
        end;
        vgGlyphBottom: begin
          TvgVisualObject(T).Align := vaBottom;
          TvgVisualObject(T).Height := FBitmapSize;
          TvgVisualObject(T).Padding.top := FBitmapSpacing;
        end;
        vgGlyphCenter: begin
          TvgVisualObject(T).Align := vaCenter;
          TvgVisualObject(T).Width := FBitmapSize;
          TvgVisualObject(T).Height := FBitmapSize;
          TvgVisualObject(T).Padding.Rect := vgRect(FBitmapSpacing, FBitmapSpacing, FBitmapSpacing, FBitmapSpacing);
        end;
      end;
  end;
end;

procedure TvgBitmapButton.SetBitmap(const Value: TvgBitmap);
begin
  FBitmap.Assign(Value);
end;

procedure TvgBitmapButton.SetBitmapLayout(const Value: TvgButtonLayout);
begin
  if FBitmapLayout <> Value then
  begin
    FBitmapLayout := Value;
    ApplyStyle;
  end;
end;

procedure TvgBitmapButton.SetBitmapSpacing(const Value: single);
begin
  if FBitmapSpacing <> Value then
  begin
    FBitmapSpacing := Value;
    if not (csLoading in ComponentState) then
      ApplyStyle;
  end;
end;

procedure TvgBitmapButton.SetBitmapSize(const Value: single);
begin
  if FBitmapSize <> Value then
  begin
    FBitmapSize := Value;
    if not (csLoading in ComponentState) then
      ApplyStyle;
  end;
end;

procedure TvgBitmapButton.SetBitmapPadding(const Value: single);
begin
  if FBitmapPadding <> Value then
  begin
    FBitmapPadding := Value;
    if not (csLoading in ComponentState) then
      ApplyStyle;
  end;
end;

{ TvgPathButton }

constructor TvgPathButton.Create(AOwner: TComponent);
begin
  inherited;
  FPath := TvgPathData.Create;
  FPath.OnChanged := DoPathChanged;
  FPathLayout := vgGlyphLeft;
  FPathSize := 32;
  FPathPadding := 2;
  FFill := TvgBrush.Create(vgBrushSolid, $FFFFFFFF);
  FFill.OnChanged := DoPathChanged;
  FStroke := TvgBrush.Create(vgBrushSolid, $FF000000);
  FStroke.SolidColor := $FF000000;
  FStroke.OnChanged := DoPathChanged;
  FStrokeThickness := 1;
  Width := 50;
  Height := 60;
end;

procedure TvgPathButton.Cleanup;
begin
  FreeAndNil(FFill);
  FreeAndNil(FStroke);
  FreeAndNil(FPath);
  inherited;
end;

procedure TvgPathButton.ApplyStyle;
var
  T: TvgObject;
begin
  inherited;
  T := FindResource('path');
  if (T <> nil) and (T is TvgPath) then
  begin
    TvgPath(T).Data.Assign(FPath);
    TvgPath(T).Fill.Assign(FFill);
    TvgPath(T).Stroke.Assign(FStroke);
    TvgPath(T).StrokeThickness := FStrokeThickness;
    TvgPath(T).StrokeCap := FStrokeCap;
    TvgPath(T).StrokeJoin := FStrokeJoin;
    TvgPath(T).StrokeDash := FStrokeDash;
  end;
  T := FindResource('pathowner');
  if (T <> nil) and (T is TvgVisualObject) then
  begin
    TvgVisualObject(T).Padding.Rect := vgRect(FPathPadding, FPathPadding, FPathPadding, FPathPadding);
    if (Length(FPath.PathData) = 0) then
    begin
      TvgVisualObject(T).Align := vaNone;
    end
    else
      case FPathLayout of
        vgGlyphLeft: begin
          TvgVisualObject(T).Align := vaLeft;
          TvgVisualObject(T).Width := FPathSize;
          TvgVisualObject(T).Padding.right := FPathSpacing;
        end;
        vgGlyphRight: begin
          TvgVisualObject(T).Align := vaRight;
          TvgVisualObject(T).Width := FPathSize;
          TvgVisualObject(T).Padding.left := FPathSpacing;
        end;
        vgGlyphTop: begin
          TvgVisualObject(T).Align := vaTop;
          TvgVisualObject(T).Height := FPathSize;
          TvgVisualObject(T).Padding.bottom := FPathSpacing;
        end;
        vgGlyphBottom: begin
          TvgVisualObject(T).Align := vaBottom;
          TvgVisualObject(T).Height := FPathSize;
          TvgVisualObject(T).Padding.top := FPathSpacing;
        end;
        vgGlyphCenter: begin
          TvgVisualObject(T).Align := vaCenter;
          TvgVisualObject(T).Width := FPathSize;
          TvgVisualObject(T).Height := FPathSize;
          TvgVisualObject(T).Padding.Rect := vgRect(FPathSpacing, FPathSpacing, FPathSpacing, FPathSpacing);
        end;
      end;
  end;
  T := FindResource('text');
  if (T <> nil) and (T is TvgVisualObject) then
  begin
    TvgVisualObject(T).Padding.Rect := vgRect(FPathPadding, FPathPadding, FPathPadding, FPathPadding);
  end;
end;

procedure TvgPathButton.DoPathChanged(Sender: TObject);
begin
  Repaint;
  ApplyStyle;
end;

procedure TvgPathButton.SetPath(const Value: TvgPathData);
begin
  FPath.Assign(Value);
end;

procedure TvgPathButton.SetPathLayout(const Value: TvgButtonLayout);
begin
  if FPathLayout <> Value then
  begin
    FPathLayout := Value;
    ApplyStyle;
  end;
end;

procedure TvgPathButton.SetPathPadding(const Value: single);
begin
  if FPathPadding <> Value then
  begin
    FPathPadding := Value;
    if not (csLoading in ComponentState) then
      ApplyStyle;
  end;
end;

procedure TvgPathButton.SetPathSize(const Value: single);
begin
  if FPathSize <> Value then
  begin
    FPathSize := Value;
    if not (csLoading in ComponentState) then
      ApplyStyle;
  end;
end;

procedure TvgPathButton.SetPathSpacing(const Value: single);
begin
  if FPathSpacing <> Value then
  begin
    FPathSpacing := Value;
    if not (csLoading in ComponentState) then
      ApplyStyle;
  end;
end;

function TvgPathButton.isStrokeThicknessStored: Boolean;
begin
  Result := FStrokeThickness <> 1;
end;

procedure TvgPathButton.SetFill(const Value: TvgBrush);
begin
  FFill := Value;
end;

procedure TvgPathButton.SetStroke(const Value: TvgBrush);
begin
  FStroke := Value;
end;

procedure TvgPathButton.SetStrokeCap(const Value: TvgStrokeCap);
begin
  if FStrokeCap <> Value then
  begin
    FStrokeCap := Value;
    if not (csLoading in ComponentState) then
      ApplyStyle;
  end;
end;

procedure TvgPathButton.SetStrokeDash(const Value: TvgStrokeDash);
begin
  if FStrokeDash <> Value then
  begin
    FStrokeDash := Value;
    if not (csLoading in ComponentState) then
      ApplyStyle;
  end;
end;

procedure TvgPathButton.SetStrokeJoin(const Value: TvgStrokeJoin);
begin
  if FStrokeJoin <> Value then
  begin
    FStrokeJoin := Value;
    if not (csLoading in ComponentState) then
      ApplyStyle;
  end;
end;

procedure TvgPathButton.SetStrokeThickness(const Value: single);
begin
  if FStrokeThickness <> Value then
  begin
    FStrokeThickness := Value;
    if not (csLoading in ComponentState) then
      ApplyStyle;
  end;
end;

{ TvgToolButton }

constructor TvgToolButton.Create(AOwner: TComponent);
begin
  inherited;
  CanFocused := false;
  FBitmapLayout := vgGlyphTop;
end;

{ TvgToolPathButton }

constructor TvgToolPathButton.Create(AOwner: TComponent);
begin
  inherited;
  CanFocused := false;
  FPathLayout := vgGlyphTop;
end;

{ TvgSpeedButton }

constructor TvgSpeedButton.Create(AOwner: TComponent);
begin
  inherited;
  CanFocused := false;
  FRepeat := true;
  Width := 23;
  Height := 23;
  Text := '';
end;

procedure TvgSpeedButton.Cleanup;
begin
  inherited;
end;

{ TvgColorButton }

constructor TvgColorButton.Create(AOwner: TComponent);
begin
  inherited;
  FAutoTranslate := false;
  FColor := vcBlack;
  FUseStandardDialog := true;
end;

procedure TvgColorButton.Cleanup;
begin
  inherited;
end;

procedure TvgColorButton.ApplyStyle;
var
  O: TvgObject;
begin
  inherited;
  O := FindResource('fill');
  if (O <> nil) and (O is TvgShape) then
  begin
    FFill := TvgShape(O);
    FFill.Fill.Color := FColor;
  end;
end;

procedure TvgColorButton.FreeStyle;
begin
  inherited;
  FFill := nil;
end;

procedure TvgColorButton.SetColor(const Value: string);
begin
  FColor := Value;
  if FFill <> nil then
    FFill.Fill.Color := FColor;
  if not (csLoading in ComponentState) then
    if Assigned(FOnChange) then
      FOnChange(Self);
end;

function SwapColor(const C: TvgColor): TvgColor;
begin
  Result := C;
  TvgColorRec(Result).R := TvgColorRec(C).B;
  TvgColorRec(Result).B := TvgColorRec(C).R;
end;

procedure TvgColorButton.Click;
{$IFNDEF NOVCL}
var
  C: TColorDialog;
  V: TvgBrushDialog;
{$ENDIF}
begin
  inherited;
  {$IFNDEF NOVCL}
  if FUseStandardDialog then
  begin
    C := TColorDialog.Create(nil);
    C.Color := SwapColor(vgStrToColor(FColor)) and $FFFFFF;
    if C.Execute then
    begin
      Color := vgColorToStr($FF000000 or SwapColor(C.Color));
    end;
    FreeAndNil(C);
  end
  else
  begin
    V := TvgBrushDialog.Create(nil);
    V.Brush.Style := vgBrushSolid;
    V.Brush.Color := FColor;
    V.ShowStyles := [vgBrushSolid];
    if V.Execute then
    begin
      Color := V.Brush.Color;
    end;
    FreeAndNil(V);
  end;
  {$ENDIF}
end;

{ TvgCornerButton }

constructor TvgCornerButton.Create(AOwner: TComponent);
begin
  inherited;
  FCorners := AllCorners;
  FxRadius := 3;
  FyRadius := 3;
  FSides := AllSides;
end;

procedure TvgCornerButton.Cleanup;
begin

  inherited;
end;

procedure TvgCornerButton.ApplyStyle;
var
  Background: TvgObject;
begin
  inherited;
  Background := FindResource('Background');
  if (Background <> nil) and (Background is TvgRectangle) then
  begin
    TvgRectangle(Background).CornerType := FCornerType;
    TvgRectangle(Background).Corners := FCorners;
    TvgRectangle(Background).xRadius := xRadius;
    TvgRectangle(Background).yRadius := yRadius;
    TvgRectangle(Background).Sides := FSides;
  end;
end;

function TvgCornerButton.IsCornersStored: Boolean;
begin
  Result := FCorners <> AllCorners;
end;

function TvgCornerButton.IsSidesStored: Boolean;
begin
  Result := FSides * AllSides <> []
end;

procedure TvgCornerButton.SetCorners(const Value: TvgCorners);
begin
  if FCorners <> Value then
  begin
    FCorners := Value;
    ApplyStyle;
  end;
end;

procedure TvgCornerButton.SetCornerType(const Value: TvgCornerType);
begin
  if FCornerType <> Value then
  begin
    FCornerType := Value;
    ApplyStyle;
  end;
end;

procedure TvgCornerButton.SetxRadius(const Value: single);
begin
  if FxRadius <> Value then
  begin
    FxRadius := Value;
    ApplyStyle;
  end;
end;

procedure TvgCornerButton.SetyRadius(const Value: single);
begin
  if FyRadius <> Value then
  begin
    FyRadius := Value;
    ApplyStyle;
  end;
end;

procedure TvgCornerButton.SetSides(const Value: TvgSides);
begin
  if FSides <> Value then
  begin
    FSides := Value;
    ApplyStyle;
  end;
end;

{ TvgCheckBox ===================================================================}

constructor TvgCheckBox.Create(AOwner: TComponent);
begin
  inherited;
  FAutoTranslate := true;
  AutoCapture := true;
  CanFocused := true;
  TextAlign := vgTextAlignNear;
  Width := 120;
  Height := 19;
end;

procedure TvgCheckBox.Cleanup;
begin
  inherited;
end;

function TvgCheckBox.GetData: Variant;
begin
  Result := IsChecked;
end;

procedure TvgCheckBox.SetData(const Value: Variant);
begin
  if VarIsEvent(Value) then
    OnChange := VariantToEvent(Value)
  else
    if VarIsType(Value, varBoolean) then
      IsChecked := Value
    else
      IsChecked := false;
end;

procedure TvgCheckBox.ApplyStyle;
begin
  inherited;
  StartTriggerAnimation(Self, 'IsChecked');
end;

procedure TvgCheckBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: single);
begin
  inherited;
  if Button = mbLeft then
  begin
    FPressing := true;
    FIsPressed := true;
    StartTriggerAnimation(Self, 'IsPressed');
  end;
end;

procedure TvgCheckBox.MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single);
begin
  inherited;
  if (ssLeft in Shift) and (FPressing) then
  begin
    if FIsPressed <> vgPtInRect(vgPoint(X, Y), LocalRect) then
    begin
      FIsPressed := vgPtInRect(vgPoint(X, Y), LocalRect);
      StartTriggerAnimation(Self, 'IsPressed');
    end;
  end;
end;

procedure TvgCheckBox.ToggleChecked;
begin
  IsChecked := not IsChecked;
end;

procedure TvgCheckBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: single);
begin
  inherited;
  if FPressing then
  begin
    FPressing := false;
    FIsPressed := false;
    if vgPtInRect(vgPoint(X, Y), LocalRect) then
      ToggleChecked;
  end;
end;

procedure TvgCheckBox.KeyDown(var Key: Word; var KeyChar: System.WideChar;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) or (Key = VK_SPACE) then
    ToggleChecked;
end;

procedure TvgCheckBox.SetIsChecked(const Value: boolean);
begin
  if FIsChecked <> Value then
  begin
    FIsChecked := Value;
    StartTriggerAnimation(Self, 'IsChecked');
    if Assigned(FOnChange) then
    begin
      FOnChange(Self);
    end;
  end;
end;

{ TvgPathCheckBox =============================================================}

constructor TvgPathCheckBox.Create(AOwner: TComponent);
begin
  inherited;
  FPath := TvgPathData.Create;
  FPath.OnChanged := DoPathChange;
  FPath.Data := 'M 341.236,311.738 L 309.372,342.676 L 291.667,325.488 L 291.667,304.863 L 309.372,321.997 L 341.236,291.113 Z';
end;

procedure TvgPathCheckBox.Cleanup;
begin
  FreeAndNil(FPath);
  inherited;
end;

procedure TvgPathCheckBox.ApplyStyle;
var
  Checkmark: TvgObject;
begin
  inherited;
  Checkmark := FindResource('checkmark');
  if (Checkmark <> nil) and (Checkmark is TvgPath) then
  begin
    TvgPath(Checkmark).Data.Assign(FPath);
  end;
end;

procedure TvgPathCheckBox.DoPathChange(Sender: TObject);
begin
  ApplyStyle;
end;

procedure TvgPathCheckBox.SetPath(const Value: TvgPathData);
begin
  FPath.Assign(Value);
end;

{ TvgRadioButton ===================================================================}

constructor TvgRadioButton.Create(AOwner: TComponent);
begin
  inherited;
  FAutoTranslate := true;
  AutoCapture := true;
  CanFocused := true;
  TextAlign := vgTextAlignNear;
  Width := 120;
  Height := 19;
end;

procedure TvgRadioButton.Cleanup;
begin
  inherited;
end;

function TvgRadioButton.GetData: Variant;
begin
  Result := IsChecked;
end;

procedure TvgRadioButton.SetData(const Value: Variant);
begin
  if VarIsEvent(Value) then
    OnChange := VariantToEvent(Value)
  else
    if VarIsType(Value, varBoolean) then
      IsChecked := Value
    else
      IsChecked := false;
end;

procedure TvgRadioButton.ApplyStyle;
begin
  inherited;
  StartTriggerAnimation(Self, 'IsChecked');
end;

procedure TvgRadioButton.EnterFocus;
begin
  inherited;
end;

procedure TvgRadioButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: single);
begin
  inherited;
  if Button = mbLeft then
  begin
    FPressing := true;
    FIsPressed := true;
    StartTriggerAnimation(Self, 'IsPressed');
  end;
end;

procedure TvgRadioButton.MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single);
begin
  inherited;
  if (ssLeft in Shift) and (FPressing) then
  begin
    if FIsPressed <> vgPtInRect(vgPoint(X, Y), LocalRect) then
    begin
      FIsPressed := vgPtInRect(vgPoint(X, Y), LocalRect);
      StartTriggerAnimation(Self, 'IsPressed');
    end;
  end;
end;

procedure TvgRadioButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: single);
begin
  inherited;
  if FPressing then
  begin
    FPressing := false;
    FIsPressed := false;
    if vgPtInRect(vgPoint(X, Y), LocalRect) then
    begin
      IsChecked := not IsChecked;
    end;
  end;
end;

procedure TvgRadioButton.KeyDown(var Key: Word; var KeyChar: System.WideChar;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) or (Key = VK_SPACE) then
  begin
    IsChecked := not IsChecked;
  end;
end;

procedure TvgRadioButton.SetIsChecked(const Value: boolean);
var
  List: TvgCustomObjectList;
  i, c, cc: integer;
begin
  if FIsChecked <> Value then
  begin
    if Value then
      FIsChecked := Value;
    { group }
    c := 0;
    cc := 0;
    if Assigned(FScene) and (FScene.GetRoot <> nil) then
    begin
      List := TvgCustomObjectList.Create;
      try
       TvgObject(FScene.GetRoot).AddControlsToList(List);
       for i := 0 to List.Count - 1 do
         if (TvgObject(List[i]) is TvgRadioButton) and (TvgObject(List[i]) <> Self) and
            (TvgRadioButton(List[i]).GroupName = GroupName) then
         begin
           if TvgRadioButton(List[i]).IsChecked then
             cc := cc + 1;
           if Value then
             TvgRadioButton(List[i]).IsChecked := false;
           c := c + 1;
         end;
      finally
       FreeAndNil(List);
      end;//try..finally
    end;//Assigned(FScene) and (FScene.GetRoot <> nil)
    { check }
    // ��������� � ����� �������, ����� �� ���� - http://mdp.garant.ru/pages/viewpage.action?pageId=327816533
    if (not (not Value and (c = 0))) and (not (not Value and (cc = 0))) then
    begin
      FIsChecked := Value;
      StartTriggerAnimation(Self, 'IsChecked');      
    end;
    { event }
    // �������� ������, ���� �� �������������� ����������� - http://mdp.garant.ru/pages/viewpage.action?pageId=327353074   
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

{ TvgCloseButton }

constructor TvgCloseButton.Create(AOwner: TComponent);
begin
  inherited;
  CanFocused := false;
  CloseForm := true;
  Width := 20;
  Height := 20;
end;

procedure TvgCloseButton.Cleanup;
begin

  inherited;
end;

procedure TvgCloseButton.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: single);
begin
  inherited;
  if Button = mbLeft then
    FPressing := true;
end;

procedure TvgCloseButton.MouseMove(Shift: TShiftState; X, Y, Dx,
  Dy: single);
begin
  inherited;
end;

procedure TvgCloseButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: single);
var
  O: TComponent;
begin
  inherited;
  if FPressing then
  begin
    if FCloseForm and (Scene <> nil) then
    begin
      O := Scene.GetComponent;
      while O <> nil do
      begin
        if (O is TCustomForm) then
        begin
          TCustomForm(O).Close;
          Break;
        end;
        O := O.Owner;
      end;
    end;
    FPressing := false;
    if Assigned(FOnClick) then
      FOnClick(Self);
  end;
end;

{ TvgSizeGrip }

constructor TvgSizeGrip.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TvgSizeGrip.Cleanup;
begin
  inherited;
end;

{ TvgGroupBox =================================================================}

constructor TvgGroupBox.Create(AOwner: TComponent);
begin
  inherited;
  FautoTranslate := true;
  CanFocused := false;
  Width := 120;
  Height := 100;
end;

procedure TvgGroupBox.Cleanup;
begin
  inherited;
end;

procedure TvgGroupBox.ApplyStyle;
begin
  inherited;
end;

{ TvgSplitter ===================================================================}

constructor TvgSplitter.Create(AOwner: TComponent);
begin
  inherited;
  FMinSize := 20;
  FShowGrip := true;
  AutoCapture := true;
  Width := 5;
  Align := vaLeft;
  Cursor := crHSplit;
end;

procedure TvgSplitter.Cleanup;
begin
  inherited;
end;

procedure TvgSplitter.ApplyStyle;
var
  grip: TvgObject;
begin
  inherited;
  grip := FindResource('grip');
  if (grip <> nil) and (grip is TvgVisualObject) then
  begin
    TvgVisualObject(grip).visible := FShowGrip;
  end;
end;

procedure TvgSplitter.Paint;
{$IfDef vgDesign}
var
  R: TvgRect;
{$EndIf vgDesign}  
begin
  inherited;
  {$IfDef vgDesign}
  if Assigned(Scene) and Scene.GetDesignTime and not Locked and not FInPaintTo then
  begin
    R := LocalRect;
    vgInflateRect(R, -0.5, -0.5);
    TvgCanvas(Canvas).StrokeThickness := 1;
    TvgCanvas(Canvas).StrokeDash := vgDashDash;
    TvgCanvas(Canvas).Stroke.Style := vgBrushSolid;
    TvgCanvas(Canvas).Stroke.SolidColor := $A0909090;
    TvgCanvas(Canvas).DrawRect(R, 0, 0, AllCorners, AbsoluteOpacity);
    TvgCanvas(Canvas).StrokeDash := vgDashSolid;
  end;
  {$EndIf vgDesign}
end;

procedure TvgSplitter.SetAlign(const Value: TvgAlign);
begin
  inherited;
  if Align in [vaTop, vaBottom] then
    Cursor := crVSplit
  else
    Cursor := crHSplit;
end;

function TvgSplitter.FindObject: TvgVisualObject;
var
  P: TvgPoint;
  I: Integer;
  R: TvgRect;
begin
  Result := nil;
  P := Position.Point;
  case Align of
    vaLeft, vaMostLeft: P.X := P.X - 1;
    vaRight, vaMostRight: P.X := P.X + Width + 1;
    vaTop: P.Y := P.Y - 1;
    vaBottom: P.Y := P.Y + Height + 1;
  else
    Exit;
  end;
  if Parent <> nil then
    for I := 0 to Parent.ChildrenCount - 1 do
    begin
      if not Parent.Children[I].IsVisual then Continue;
      if TvgVisualObject(Parent.Children[I]).Locked then Continue;
      if (Align in [vaLeft, vaMostLeft, vaRight, vaMostRight]) and not ((TvgVisualObject(Parent.Children[I]).Align in [vaLeft, vaMostLeft, vaRight, vaMostRight])) then Continue;
      if (Align in [vaTop, vaBottom, vaMostTop, vaMostBottom]) and not ((TvgVisualObject(Parent.Children[I]).Align in [vaTop, vaBottom, vaMostTop, vaMostBottom])) then Continue;

      Result := TvgVisualObject(Parent.Children[I].Visual);
      if Result.Visible then
      begin
        R := Result.LocalRect;
        vgOffsetRect(R, Result.Position.X, Result.Position.Y);
        if (R.Right - R.Left) = 0 then
          if Align in [vaTop, vaLeft, vaMostLeft] then
            R.Left := R.Left - 1
          else
            R.Right := R.Right + 1;
        if (R.Bottom - R.Top) = 0 then
          if Align in [vaTop, vaLeft, vaMostLeft] then
            R.Top := R.Top - 1
          else
            R.Bottom := R.Bottom + 1;
        if vgPtInRect(P, R) then Exit;
      end;
    end;
  Result := nil;
end;

procedure TvgSplitter.UpdateSize(X, Y: single);
begin
  CalcSplitSize(X, Y, FNewSize, FSplit);
end;

procedure TvgSplitter.CalcSplitSize(X, Y: single; var NewSize, Split: single);
var
  S: single;
begin
  if Align in [vaLeft, vaRight, vaMostLeft, vaMostRight] then
    Split := X - FDownPos.X
  else
    Split := Y - FDownPos.Y;
  S := 0;
  case Align of
    vaLeft, vaMostLeft: S := FControl.Width + Split;
    vaRight, vaMostRight: S := FControl.Width - Split;
    vaTop: S := FControl.Height + Split;
    vaBottom: S := FControl.Height - Split;
  end;
  NewSize := S;
  if S < FMinSize then
    NewSize := FMinSize
  else
  if S > FMaxSize then
    NewSize := FMaxSize;
  if S <> NewSize then
  begin
    if Align in [vaRight, vaMostRight, vaBottom] then
      S := S - NewSize
    else
      S := NewSize - S;
    Split := Split + S;
  end;
end;

function TvgSplitter.DoCanResize(var NewSize: single): Boolean;
begin
  Result := true;
  if (NewSize <= FMinSize) {and FAutoSnap }then
    NewSize := FMinSize;
end;

procedure TvgSplitter.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: single);
var
  i: integer;
begin
  inherited;
  if Button = mbLeft then
  begin
    FPressed := true;
    FDownPos := vgPoint(X, Y);
    FControl := FindObject;
    if Assigned(FControl) then
    begin
      if Align in [vaLeft, vaMostLeft, vaRight, vaMostRight] then
      begin
        FMaxSize := TvgVisualObject(Parent.Visual).Width - FMinSize - TvgVisualObject(Parent.Visual).Margins.left - TvgVisualObject(Parent.Visual).Margins.right;
        for I := 0 to Parent.ChildrenCount - 1 do
        begin
          if not Parent.Children[I].IsVisual then Continue;
          with Parent.Children[I].Visual do
            if (Align in [vaLeft, vaRight, vaMostLeft, vaMostRight]) then
              FMaxSize := FMaxSize - Width - Padding.Left - Padding.Right;
        end;
        FMaxSize := FMaxSize + FControl.Width;
      end
      else
      begin
        FMaxSize := TvgVisualObject(Parent.Visual).Height - FMinSize - TvgVisualObject(Parent.Visual).Margins.top - TvgVisualObject(Parent.Visual).Margins.bottom;
        for I := 0 to Parent.ChildrenCount - 1 do
        begin
          if not Parent.Children[I].IsVisual then Continue;
          with Parent.Children[I].Visual do
            if Align in [vaTop, vaBottom] then
              FMaxSize := FMaxSize - Height - Padding.top - Padding.bottom;
        end;
        FMaxSize := FMaxSize + FControl.Height;
      end;
      UpdateSize(X, Y);
    end;
  end;
end;

procedure TvgSplitter.MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single);
var
  NewSize, Split: single;
begin
  inherited;
  if FPressed and Assigned(FControl) then
  begin
    CalcSplitSize(X, Y, NewSize, Split);
    if DoCanResize(NewSize) then
    begin
      FNewSize := NewSize;
      FSplit := Split;
      UpdateControlSize;
    end;
  end;
end;

procedure TvgSplitter.UpdateControlSize;
begin
  if FNewSize <> FOldSize then
  begin
    case Align of
      vaLeft, vaMostLeft: FControl.Width := FNewSize;
      vaTop: FControl.Height := FNewSize;
      vaRight, vaMostRight:
        begin
          FControl.Position.X := FControl.Position.X + (FControl.Width - FNewSize);
          FControl.Width := FNewSize;
        end;
      vaBottom:
        begin
          FControl.Position.Y := FControl.Position.Y + (FControl.Height - FNewSize);
          FControl.Height := FNewSize;
        end;
    end;
//    if Assigned(FOnMoved) then FOnMoved(Self);
    FOldSize := FNewSize;
  end;
end;

procedure TvgSplitter.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: single);
begin
  inherited;
  FPressed := false;
  FControl := nil;
end;

procedure TvgSplitter.SetShowGrip(const Value: boolean);
begin
  if FShowGrip <> Value then
  begin
    FShowGrip := Value;
    ApplyStyle;
  end;
end;

{ TvgProgressBar ==============================================================}

constructor TvgProgressBar.Create(AOwner: TComponent);
begin
  inherited;
  CanFocused := false;
  FMax := 100;
  Width := 100;
  Height := 20;
end;

procedure TvgProgressBar.Cleanup;
begin
  inherited;
end;

function TvgProgressBar.GetData: Variant;
begin
  Result := Value;
end;

procedure TvgProgressBar.SetData(const Value: Variant);
begin
  if VarIsNumeric(Value) then
    Self.Value := Value
  else
    Self.Value := Min
end;

procedure TvgProgressBar.ApplyStyle;
var
  I: TvgObject;
begin
  inherited;
  if Orientation = vgHorizontal then
  begin
    I := FindResource('hindicator');
    if (I <> nil) and (I is TvgVisualObject) then
      TvgVisualObject(I).StartTriggerAnimation(Self, 'IsVisible');
  end
  else
  begin
    I := FindResource('vindicator');
    if (I <> nil) and (I is TvgVisualObject) then
      TvgVisualObject(I).StartTriggerAnimation(Self, 'IsVisible');
  end;
  Realign;
end;

procedure TvgProgressBar.Realign;
var
  hI, vI, T: TvgObject;
begin
  if not FDisableAlign then
  begin
    FDisableAlign := true;
    T := nil;
    if Orientation = vgHorizontal then
    begin
      T := FindResource('vtrack');
      if T <> nil then
        TvgVisualObject(T.Visual).Visible := false;
      T := FindResource('htrack')
    end
    else
    begin
      T := FindResource('htrack');
      if T <> nil then
        TvgVisualObject(T.Visual).Visible := false;
      T := FindResource('vtrack');
    end;
    if T = nil then
      T := FindResource('track');
    if (T <> nil) and (T is TvgVisualObject) and (Max > Min) then
    begin
      hI := FindResource('hindicator');
      vI := FindResource('vindicator');
      if Orientation = vgHorizontal then
      begin
        if (hI <> nil) and (hI is TvgVisualObject) then
        begin
          TvgVisualObject(hI).Width := ((Value - Min) / (Max - Min)) * (TvgVisualObject(T).Width - TvgVisualObject(T).Margins.Left - TvgVisualObject(T).Margins.Right -
            TvgVisualObject(hI).Padding.Left - TvgVisualObject(hI).Padding.Right);
          TvgVisualObject(hI).Visible := TvgVisualObject(hI).Width > 2;
        end;
        if (vI <> nil) and (vI is TvgVisualObject) then
          TvgVisualObject(vI).Visible := false;
      end
      else
      begin
        if (vI <> nil) and (vI is TvgVisualObject) then
        begin
          TvgVisualObject(vI).Height := ((Value - Min) / (Max - Min)) * (TvgVisualObject(T).Height - TvgVisualObject(T).Margins.Top - TvgVisualObject(T).Margins.Bottom -
            TvgVisualObject(hI).Padding.Top - TvgVisualObject(hI).Padding.Bottom);
          TvgVisualObject(vI).Visible := TvgVisualObject(vI).Height > 2;
        end;
        if (hI <> nil) and (hI is TvgVisualObject) then
          TvgVisualObject(hI).Visible := false;
      end;
    end;
    FDisableAlign := false;
  end;
  inherited;
end;

procedure TvgProgressBar.SetMax(const Value: single);
begin
  FMax := Value;
end;

procedure TvgProgressBar.SetMin(const Value: single);
begin
  FMin := Value;
end;

procedure TvgProgressBar.SetOrientation(const Value: TvgOrientation);
{$IfDef vgDesign}
var
  T: single;
{$EndIf vgDesign}
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    // swap
    {$IfDef vgDesign}
    if Assigned(FScene) and (FScene.GetDesignTime) and not (csLoading in ComponentState) then
    begin
      T := Width;
      Width := Height;
      Height := T;
    end;
    {$EndIf vgDesign}
    Realign;
  end;//FOrientation <> Value
end;

procedure TvgProgressBar.SetValue(const Value: single);
begin
  if FValue <> Value then
  begin
    FValue := Value;
    Realign;
  end;
end;

{ TvgThumb ====================================================================}

constructor TvgThumb.Create(AOwner: TComponent);
begin
  inherited;
  CanFocused := false;
  AutoCapture := true;
end;

procedure TvgThumb.Cleanup;
begin
  inherited;
end;

procedure TvgThumb.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: single);
begin
  inherited;
  if (Button = mbLeft) and Enabled then
  begin
    FPressed := true;
    FDownOffset := vgPoint(X, Y);

    if FTrack <> nil then
      FTrack.SetFocus;
  end;
end;

procedure TvgThumb.MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single);
var
  P: TvgPoint;
begin
  inherited;
  if FPressed and (FTrack <> nil) and (Enabled) and (Parent <> nil) and (Parent.IsVisual) then
  begin
    if FTrack.Orientation = vgHorizontal then
    begin
      P := FTrack.AbsoluteToLocal(LocalToAbsolute(vgPoint(X, 0)));
      if FTrack.ViewportSize = 0 then
        FTrack.Value := FTrack.Min + (((P.X) / FTrack.Width) * (FTrack.FMax - FTrack.FMin))
      else
        FTrack.Value := FTrack.Min + (((P.X - FDownOffset.X) / FTrack.Width) * (FTrack.FMax - FTrack.FMin))
    end
    else
    begin
      P := FTrack.AbsoluteToLocal(LocalToAbsolute(vgPoint(0, Y)));
      if FTrack.ViewportSize = 0 then
        FTrack.Value := FTrack.Min + (((P.Y) / FTrack.Height) * (FTrack.FMax - FTrack.FMin))
      else
        FTrack.Value := FTrack.Min + (((P.Y - FDownOffset.Y) / FTrack.Height) * (FTrack.FMax - FTrack.FMin))
    end;
  end;
end;

procedure TvgThumb.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: single);
var
  V: single;
begin
  inherited;
  if FPressed then
  begin
    if not FTrack.Tracking and Assigned(FTrack.FOnChange) then
    begin
      FTrack.FTracking := true;
      V := FTrack.FValue;
      FTrack.FValue := $FFFF;
      FTrack.Value := V;
      FTrack.FTracking := false;
    end;
    FPressed := false;
  end;
end;

{ TvgCustomTrack ====================================================================}

constructor TvgCustomTrack.Create(AOwner: TComponent);
begin
  inherited;
  FViewportSize := 0;
  FMax := 100;
  FTracking := true;
  Width := 100;
  Height := 15;
end;

procedure TvgCustomTrack.Cleanup;
begin
  inherited;
end;

function TvgCustomTrack.GetData: Variant;
begin
  Result := Value;
end;

procedure TvgCustomTrack.SetData(const Value: Variant);
begin
  if VarIsEvent(Value) then
    OnChange := VariantToEvent(Value)
  else
   if VarIsNumeric(Value) then
     Self.Value := Value
   else
     Self.Value := Min
end;

function TvgCustomTrack.GetThumbRect: TvgRect;
begin
  Result := LocalRect;
  if (FMax - FMin) > 0 then
  begin
    if Orientation = vgHorizontal then
    begin
      Result := vgRect(0, 0, (FViewportSize / (FMax - FMin)) * Width, Height);
      vgOffsetRect(Result, Round((((FValue - FMin) / (FMax - FMin))) * Width), 0);
      if Result.Right - Result.Left < Height then
      begin
        Result.Right := Result.Left + trunc(Height / 2);
        Result.Left := Result.Left - trunc(Height / 2);
      end;
      if Result.Right > Width then
        vgOffsetRect(Result, Width - Result.Right, 0);
      if Result.Left < 0 then
        vgOffsetRect(Result, - Result.Left, 0);
    end
    else
    begin
      Result := vgRect(0, 0, Width, (FViewportSize / (FMax - FMin)) * Height);
      if Result.Bottom - Result.Top < Width then
      begin
        Result.Bottom := Result.Top + trunc(Width / 2);
        Result.Top := Result.Top - trunc(Width / 2);
      end;
      vgOffsetRect(Result, 0, Round((((FValue - FMin) / (FMax - FMin))) * Height));
      if Result.Bottom > Height then
        vgOffsetRect(Result, 0, Height - Result.Bottom);
      if Result.Top < 0 then
        vgOffsetRect(Result, 0, - Result.Top);
    end;
  end;
  if (Thumb <> nil) and (Thumb.Parent <> nil) and (Thumb.Parent.IsVisual) then
  begin
    if vgRectWidth(Result) > TvgVisualObject(Thumb.Parent).Margins.Left + Thumb.Padding.Left + TvgVisualObject(Thumb.Parent).Margins.Right - Thumb.Padding.Right then
    begin
      Result.Left := Result.Left + TvgVisualObject(Thumb.Parent).Margins.Left + Thumb.Padding.Left;
      Result.Right := Result.Right - TvgVisualObject(Thumb.Parent).Margins.Right - Thumb.Padding.Right;
    end;
    Result.Top := Result.Top + TvgVisualObject(Thumb.Parent).Margins.Top + Thumb.Padding.Top;
    Result.Bottom := Result.Bottom - TvgVisualObject(Thumb.Parent).Margins.Bottom - Thumb.Padding.Bottom;
  end;
end;

function TvgCustomTrack.GetThumb: TvgThumb;
var
  T: TvgObject;
begin
  T := FindResource('thumb');
  if (T <> nil) and (T is TvgThumb) then
  begin
    Result := TvgThumb(T);
    Result.FTrack := Self;
  end
  else
    Result := nil;
end;

procedure TvgCustomTrack.Realign;
begin
  inherited ;
  if Thumb <> nil then
  begin
    with GetThumbRect do
    begin
      Thumb.Position.X := Left;
      Thumb.Position.Y := Top;
      if Round(Right - Left) > 0 then
        Thumb.Width := Round(Right - Left);
      if Round(Bottom - Top) > 0 then
        Thumb.Height := Round(Bottom - Top);
    end;
  end;
end;

procedure TvgCustomTrack.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: single);
begin
  inherited;
  if Button = mbLeft then
  begin
    if Orientation = vgHorizontal then
    begin
      if FViewportSize = 0 then
        Value := Min + ((X / Width) * (FMax - FMin))
      else
      begin
        if Min + ((X / Width) * (FMax - FMin)) > Value then
          Value := Value + FViewportSize
        else
          Value := Value - FViewportSize
      end;
    end
    else
    begin
      if FViewportSize = 0 then
        Value := Min + ((Y / Height) * (FMax - FMin))
      else
      begin
        if Min + ((Y / Height) * (FMax - FMin)) > Value then
          Value := Value + FViewportSize
        else
          Value := Value - FViewportSize
      end;
    end;
  end;
end;

procedure TvgCustomTrack.MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single);
begin
  inherited;
end;

procedure TvgCustomTrack.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: single);
begin
  inherited;
end;

procedure TvgCustomTrack.KeyDown(var Key: Word; var KeyChar: System.WideChar;
  Shift: TShiftState);
var
  inc: single;
begin
  inc := Frequency;
  if inc = 0 then inc := 1;
  inherited;
  case Key of
    VK_HOME: Value := Min;
    VK_END: Value := Max;
    VK_UP: Value := Value - inc;
    VK_DOWN: Value := Value + inc;
    VK_LEFT: Value := Value - inc;
    VK_RIGHT: Value := Value + inc;
  else
    Exit;
  end;
  if not Tracking and Assigned(FOnChange) then
    FOnChange(Self);
  Key := 0;
end;

procedure TvgCustomTrack.SetMax(const Value: single);
begin
  if FMax <> Value then
  begin
    FMax := Value;
    if FMax < FMin then
      FMax := FMin + 0.001;
    if FViewportSize > (FMax - FMin) then
      FViewportSize := FMax - FMin;
    if FValue > FMax - FViewportSize then
      FValue := FMax - FViewportSize;
    Realign;
  end;
end;

procedure TvgCustomTrack.SetMin(const Value: single);
begin
  if FMin <> Value then
  begin
    FMin := Value;
    Realign;
  end;
end;

procedure TvgCustomTrack.SetOrientation(const Value: TvgOrientation);
{$IfDef vgDesign}
var
  T: single;
{$EndIf vgDesign}  
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    // swap
    {$IfDef vgDesign}
    if Assigned(FScene) and (FScene.GetDesignTime) and not (csLoading in ComponentState) then
    begin
      T := Width;
      Width := Height;
      Height := T;
    end;
    {$EndIf vgDesign}
    Realign;
  end;//FOrientation <> Value
end;

function TvgCustomTrack.GetIsTracking: boolean;
begin
  Result := (Thumb <> nil) and Thumb.FPressed;
end;

procedure TvgCustomTrack.SetFrequency(const Value: single);
begin
  if FFrequency <> Value then
  begin
    FFrequency := Value;
    if FFrequency <> 0 then
      Self.Value := Round(Self.Value / Frequency) * Frequency;
  end;
end;

procedure TvgCustomTrack.SetValue(Value: single);
begin
  if FFrequency <> 0 then
    Value := Round(Value / Frequency) * Frequency;
  if FValue <> Value then
  begin
    FValue := Value;
    if FValue > FMax - FViewportSize then FValue := FMax - FViewportSize;
    if FValue < FMin then FValue := FMin;
    if GetIsTracking and Assigned(FOnTracking) then
      FOnTracking(Self);
    if Tracking and Assigned(FBindingObjects) then
      ToBindingObjects;
    if GetIsTracking and Tracking and Assigned(FOnChange) then
      FOnChange(Self)
    else
      if not GetIsTracking and Assigned(FOnChange) then
        FOnChange(Self);
    Realign;
  end;
end;

procedure TvgCustomTrack.SetViewportSize(const Value: single);
begin
  if FViewportSize <> Value then
  begin
    FViewportSize := Value;
    if FViewportSize > (FMax - FMin) then
      FViewportSize := FMax - FMin;
    if FValue > FMax - FViewportSize then
      Self.Value := FMax - FViewportSize;
    Realign;
  end;
end;

{ TvgTrackBar }

constructor TvgTrackBar.Create(AOwner: TComponent);
begin
  inherited;
  FViewportSize := 0;
  CanFocused := true;
end;

{ TvgScrollBar ================================================================}

constructor TvgScrollBar.Create(AOwner: TComponent);
begin
  inherited;
  FMax := 100;
  FViewportSize := 0;
  FSmallChange := 1;
  Width := 150;
  Height := 18;
end;

procedure TvgScrollBar.Cleanup;
begin
  inherited;
end;

function TvgScrollBar.GetData: Variant;
begin
  Result := Value;
end;

procedure TvgScrollBar.SetData(const Value: Variant);
begin
  if VarIsEvent(Value) then
    OnChange := VariantToEvent(Value)
  else
    if VarIsNumeric(Value) then
      Self.Value := Value
    else
      Self.Value := Min
end;

function TvgScrollBar.Track: TvgCustomTrack;
var
  T: TvgObject;
  HT, VT: TvgCustomTrack;
begin
  HT := nil; VT := nil;
  T := FindResource('htrack');
  if (T <> nil) and (T is TvgCustomTrack) then
  begin
    HT := TvgCustomTrack(T);
    HT.FOrientation := vgHorizontal;
    HT.FMax := Max;
    HT.FMin := Min;
    HT.FValue := Value;
    HT.ViewportSize := ViewportSize;
    HT.Visible := Orientation = vgHorizontal;
    HT.OnChange := DoTrackChanged;
    HT.CanFocused := false;
    if HT.visible then HT.Realign;
  end;
  T := FindResource('vtrack');
  if (T <> nil) and (T is TvgCustomTrack) then
  begin
    VT := TvgCustomTrack(T);
    VT.FOrientation := vgVertical;
    VT.FMax := Max;
    VT.FMin := Min;
    VT.FValue := Value;
    VT.ViewportSize := ViewportSize;
    VT.Visible := Orientation = vgVertical;
    VT.OnChange := DoTrackChanged;
    VT.CanFocused := false;
    if VT.visible then VT.Realign;
  end;
  if Orientation = vgVertical then
    Result := VT
  else
    Result := HT;
end;

function TvgScrollBar.MinButton: TvgCustomButton;
var
  T: TvgObject;
  LB, TB: TvgCustomButton;
begin
  TB := nil; LB := nil;
  T := FindResource('leftbutton');
  if (T <> nil) and (T is TvgCustomButton) then
  begin
    LB := TvgCustomButton(T);
    LB.OnClick := DoMinButtonClick;
    LB.Visible := Orientation = vgHorizontal;
    LB.CanFocused := false;
  end;

  T := FindResource('topbutton');
  if (T <> nil) and (T is TvgCustomButton) then
  begin
    TB := TvgCustomButton(T);
    TB.OnClick := DoMinButtonClick;
    TB.Visible := Orientation = vgVertical;
    TB.CanFocused := false;
  end;

  if Orientation = vgVertical then
    Result := TB
  else
    Result := LB;
end;

function TvgScrollBar.MaxButton: TvgCustomButton;
var
  T: TvgObject;
  RB, BB: TvgCustomButton;
begin
  RB := nil; BB := nil;
  T := FindResource('rightbutton');
  if (T <> nil) and (T is TvgCustomButton) then
  begin
    RB := TvgCustomButton(T);
    RB.OnClick := DoMaxButtonClick;
    RB.Visible := Orientation = vgHorizontal;
    RB.CanFocused := false;
  end;

  T := FindResource('bottombutton');
  if (T <> nil) and (T is TvgCustomButton) then
  begin
    BB := TvgCustomButton(T);
    BB.OnClick := DoMaxButtonClick;
    BB.Visible := Orientation = vgVertical;
    RB.CanFocused := false;
  end;

  if Orientation = vgVertical then
    Result := BB
  else
    Result := RB;
end;

procedure TvgScrollBar.DoTrackChanged(Sender: TObject);
begin
  Value := TvgCustomTrack(Sender).Value;
end;

procedure TvgScrollBar.DoMinButtonClick(Sender: TObject);
begin
  Value := Value - SmallChange;
end;

procedure TvgScrollBar.DoMaxButtonClick(Sender: TObject);
begin
  Value := Value + SmallChange;
end;

procedure TvgScrollBar.Realign;
begin
  if FDisableAlign then Exit;
  FDisableAlign := true;
  Track;
  MinButton;
  MaxButton;
  FDisableAlign := false;
  inherited;
end;

procedure TvgScrollBar.SetMax(const Value: single);
begin
  if FMax <> Value then
  begin
    FMax := Value;
    if FMax < FMin then
      FMax := FMin + 0.001;
    if FValue > FMax - FViewportSize then
      Self.Value := FMax - FViewportSize;
    if FViewportSize > (FMax - FMin) then
      FViewportSize := FMax - FMin;
    Realign;
  end;
end;

procedure TvgScrollBar.SetMin(const Value: single);
begin
  if FMin <> Value then
  begin
    FMin := Value;
    if FValue < FMin then
      Self.Value := FMin;
    Realign;
  end;
end;

procedure TvgScrollBar.SetOrientation(const Value: TvgOrientation);
{$IfDef vgDesign}
var
  T: single;
{$EndIf vgDesign}
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    // swap
    {$IfDef vgDesign}
    if Assigned(FScene) and (FScene.GetDesignTime) and not (csLoading in ComponentState) then
    begin
      T := Width;
      Width := Height;
      Height := T;
    end;
    {$EndIf vgDesign}
    Realign;
  end;//FOrientation <> Value
end;

procedure TvgScrollBar.SetValue(const Value: single);
begin
  if FValue <> Value then
  begin
    FValue := Value;
    if FValue > FMax - FViewportSize then
      FValue := FMax - FViewportSize;
    if FValue < FMin then
      FValue := FMin;
    if Assigned(FBindingObjects) then
      ToBindingObjects;
    if Assigned(FOnChange) then
      FOnChange(Self);
    Realign;
  end;
end;

procedure TvgScrollBar.SetViewportSize(const Value: single);
begin
  if FViewportSize <> Value then
  begin
    FViewportSize := Value;
    if FViewportSize > (FMax - FMin) then
      FViewportSize := FMax - FMin;
    if FValue > FMax - FViewportSize then
      Self.Value := FMax - FViewportSize;
    Realign;
  end;
end;

{ TvgSmallScrollBar }

constructor TvgSmallScrollBar.Create(AOwner: TComponent);
begin
  inherited;
  Height := 8;
end;

{ TvgAniIndicator =============================================================}

constructor TvgAniIndicator.Create(AOwner: TComponent);
begin
  inherited;
  FLayout := TvgVisualObject.Create(Self);
  FLayout.Parent := Self;
  FLayout.Align := vaContents;
  FLayout.Locked := true;
  FLayout.Stored := false;
  FAni := TvgFloatAnimation.Create(Self);
  FAni.Parent := FLayout;
  FAni.Loop := true;
  FAni.StartValue := 0;
  FAni.StopValue := 360;
  FAni.Duration := 10;
  FAni.PropertyName := 'RotateAngle';
end;

procedure TvgAniIndicator.Cleanup;
begin
  inherited;
end;

procedure TvgAniIndicator.Paint;
var
  a: integer;
  P, P2: TvgPoint;
  wSize, eSize: single;
  V: single;
begin
  if Width < Height then
    wSize := Width / 2
  else
    wSize := Height / 2;
  eSize := wSize / 3.7;
  wSize := wSize - eSize;

  case FStyle of
    vgAniIndicatorLine:
      begin
        TvgCanvas(Canvas).Stroke.Style := vgBrushsolid;
        TvgCanvas(Canvas).StrokeThickness := eSize / 2;
        for a := 0 to 11 do
        begin
          P := vgPoint(Width / 2 + (cos(vgDegToRad(a * 30)) * wSize), Height / 2 + (sin(vgDegToRad(a * 30)) * wSize));
          P2 := vgPoint(Width / 2 + (cos(vgDegToRad(a * 30)) * (wSize / 2)), Height / 2 + (sin(vgDegToRad(a * 30)) * (wSize / 2)));
          TvgCanvas(Canvas).Fill.SolidColor := $FFBABABA;
          TvgCanvas(Canvas).Stroke.SolidColor := $FFBABABA;
          TvgCanvas(Canvas).DrawLine(P, P2, Opacity);
          if FEnabled then
          begin
            V := ((Trunc(FLayout.RotateAngle) + (30 - Trunc((a / 12) * 30))) mod 30) / 30;
            if V > 1 then V := Abs(V - 2);
            V := 1 - V;
            TvgCanvas(Canvas).Stroke.SolidColor := $FF000000;
            TvgCanvas(Canvas).DrawLine(P, P2, V * Opacity);
          end;
        end;
      end;
    vgAniIndicatorCircle:
      begin
        TvgCanvas(Canvas).Stroke.Style := vgBrushNone;
        for a := 0 to 7 do
        begin
          P := vgPoint(Width / 2 + (cos(vgDegToRad(a * 45)) * wSize), Height / 2 + (sin(vgDegToRad(a * 45)) * wSize));
          TvgCanvas(Canvas).Fill.SolidColor := $FFBABABA;
          TvgCanvas(Canvas).FillEllipse(vgRect(P.X - eSize, P.Y - eSize, P.X + eSize, P.Y + eSize), Opacity);
          if FEnabled then
          begin
            V := ((Trunc(FLayout.RotateAngle) + (30 - Trunc((a / 7) * 30))) mod 30) / 30;
            if V > 1 then V := Abs(V - 2);
            V := 1 - V;
            TvgCanvas(Canvas).Fill.SolidColor := $FF000000;
            TvgCanvas(Canvas).FillEllipse(vgRect(P.X - eSize, P.Y - eSize, P.X + eSize, P.Y + eSize), V * Opacity);
          end;
        end;
      end;
  end;
end;

procedure TvgAniIndicator.SetEnabled(const Value: boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    if FEnabled then
    begin
      FAni.Start;
    end
    else
      FAni.Stop;
  end;
end;

procedure TvgAniIndicator.SetStyle(const Value: TvgAniIndicatorStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    Repaint;
  end;
end;

{ TvgAngleButton ===================================================================}

constructor TvgAngleButton.Create(AOwner: TComponent);
begin
  inherited;
  Width := 30;
  Height := 30;
  FFrequency := 0;
  FTracking := true;
  AutoCapture := true;
end;

procedure TvgAngleButton.Cleanup;
begin
  inherited;
end;

function TvgAngleButton.GetData: Variant;
begin
  Result := Value;
end;

procedure TvgAngleButton.SetData(const Value: Variant);
begin
  if VarIsEvent(Value) then
    OnChange := VariantToEvent(Value)
  else
    if VarIsNumeric(Value) then
      Self.Value := Value
    else
      Self.Value := 0
end;

procedure TvgAngleButton.ApplyStyle;
begin
  inherited;
  Tick;
  Text;
end;

function TvgAngleButton.Tick: TvgVisualObject;
var
  T: TvgObject;
begin
  T := FindResource('tick');
  if (T <> nil) and (T is TvgVisualObject) then
  begin
    Result := TvgVisualObject(T);
    Result.RotateAngle := -FValue;
  end
  else
    Result := nil;
end;

function TvgAngleButton.Text: TvgText;
var
  T: TvgObject;
begin
  T := FindResource('tracktext');
  if (T <> nil) and (T is TvgText) then
  begin
    TvgText(T).Visible := false; //FPressing;
    TvgText(T).Text := IntToStr(Round(Value)) + System.WideChar($B0);
    if FPressing and not FTracking then
      TvgText(T).Opacity := 1
    else
      TvgText(T).Opacity := 0;
  end;

  T := FindResource('text');
  if (T <> nil) and (T is TvgText) then
  begin
    Result := TvgText(T);
    Result.Visible := FShowValue;
    Result.Text := IntToStr(Round(Value)) + System.WideChar($B0);
    if not FShowValue then
      Result.Opacity := 0
    else
      Result.Opacity := 1;
  end
  else
    Result := nil;
end;

procedure TvgAngleButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: single);
begin
  inherited;
  if Button = mbLeft then
  begin
    FPressing := true;
    FOldPos := vgPoint(X, Y);
    FSaveValue := Value;
    Text;
  end;
end;

procedure TvgAngleButton.MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single);
begin
  inherited;
  if (ssLeft in Shift) and (FPressing) then
  begin
    Value := vgVectorAngle(vgVector(1, 0), vgVector(X - (Width / 2), Y - (Height / 2)));
    FOldPos := vgPoint(X, Y);
    Text;
  end;
end;

procedure TvgAngleButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: single);
begin
  inherited;
  if FPressing then
  begin
    FPressing := false;
    Text;
    if Value <> FSaveValue then
      if Assigned(FOnChange) then
        FOnChange(Self);
  end;
end;

procedure TvgAngleButton.Paint;
begin
  inherited;
end;

procedure TvgAngleButton.SetValue(const Value: single);
begin
  if (FFrequency = 0) then
  begin
    if (FValue <> Value) then
    begin
      FValue := Value;
      if Tick <> nil then
        Tick.RotateAngle := -FValue
      else
        Repaint;
      Text;
      if Assigned(FOnChange) and (not FPressing or FTracking) then
        FOnChange(Self);
    end;
  end
  else
  begin
    if FValue <> Round(Value / FFrequency) * FFrequency then
    begin
      FValue := Round(Value / FFrequency) * FFrequency;
      if Tick <> nil then
        Tick.RotateAngle := -FValue
      else
        Repaint;
      Text;
      if Assigned(FOnChange) and (not FPressing or FTracking) then
        FOnChange(Self);
    end;
  end;
end;

procedure TvgAngleButton.SetShowValue(const Value: boolean);
begin
  if FShowValue <> Value then
  begin
    FShowValue := Value;
    Text;
    Repaint;
  end;
end;

procedure TvgTrackBar.Loaded;
begin
  inherited;
end;

procedure TvgTrackBar.SetMax(const Value: single);
begin
  if FMax <> Value then
  begin
    inherited;
  end;
end;

procedure TvgTrackBar.SetMin(const Value: single);
begin
  inherited;
  if FMin <> Value then
  begin
    inherited;
  end;
end;

{ TvgExpanderButton }

constructor TvgExpanderButton.Create(AOwner: TComponent);
begin
  inherited;
  CanFocused := false;
end;

procedure TvgExpanderButton.Cleanup;
begin
  inherited;
end;

{ TvgExpander =================================================================}

constructor TvgExpander.Create(AOwner: TComponent);
begin
  inherited;
  Width := 130;
  Height := 130;

  FAutoTranslate := true;

  FIsExpanded := true;
  FIsChecked := true;

  FContent := TvgContent.Create(Self);
  FContent.Parent := Self;
  FContent.ClipChildren := false;
  FContent.HitTest := false;
  FContent.Locked := true;
  FContent.Stored := false;
  FContent.Padding.Top := 25;
  FContent.Width := Width;
  FContent.Height := Height;
end;

procedure TvgExpander.AddObject(AObject: TvgObject);
begin
  if (FContent <> nil) and (AObject <> FContent) and (AObject <> FResourceLink) then
  begin
    FContent.AddObject(AObject);
  end
  else
    inherited;
end;

procedure TvgExpander.ApplyStyle;
var
  O: TvgObject;
begin
  inherited;
  O := FindResource('checkbox');
  if (O <> nil) and (O is TvgCheckBox) then
  begin
    FCheck := TvgCheckBox(O);
    FCheck.Visible := FShowCheck;
    FCheck.IsChecked := FIsChecked;
    FCheck.OnChange := DoCheckChange;
  end;
  O := FindResource('button');
  if (O <> nil) and (O is TvgCustomButton) then
  begin
    FButton := TvgCustomButton(O);
    FButton.OnClick := DoButtonClick;
    FButton.ApplyResource;
    FButton.StartTriggerAnimation(Self, 'IsExpanded');
    FButton.CanFocused := false;
  end;
  StartTriggerAnimation(Self, 'IsExpanded');
end;

procedure TvgExpander.FreeStyle;
begin
  inherited;
  FCheck := nil;
  FButton := nil;
end;

procedure TvgExpander.Cleanup;
begin
  inherited;
end;

procedure TvgExpander.DoButtonClick(Sender: TObject);
begin
  IsExpanded := not FIsExpanded;
end;

procedure TvgExpander.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('ContentSize', ReadContentSize, WriteContentSize, true);
end;

procedure TvgExpander.ReadContentSize(Reader: TReader);
begin
  if FContent <> nil then
    FContent.Height := vgStrToFloat(Reader.ReadString);
end;

procedure TvgExpander.WriteContentSize(Writer: TWriter);
begin
  if FContent <> nil then
    Writer.WriteString(vgFloatToStr(FContent.Height));
end;

procedure TvgExpander.Realign;
begin
  inherited;
  if csLoading in ComponentState then Exit;
  if FDisableAlign then Exit;
  FDisableAlign := true;
  { content }
  if (FContent <> nil) and (IsExpanded) then
  begin
    FContent.Position.X := 0;
    FContent.Position.Y := FContent.Padding.Top;
    FContent.Width := Width;
    FContent.Height := Height - FContent.Padding.Top;
  end;
  FDisableAlign := false;
end;

procedure TvgExpander.SetIsExpanded(const Value: boolean);
begin
  if FIsExpanded <> Value then
  begin
    if FResourceLink = nil then
      ApplyResource;
    FIsExpanded := Value;
    if FIsExpanded then
    begin
      FContent.Visible := FIsExpanded;
      if FButton <> nil then
        Height := FButton.Height + FContent.Height;
      Repaint;
    end
    else
    begin
      Repaint;
      FContent.Visible := FIsExpanded;
      if FButton <> nil then
        Height := FButton.Height;
    end;
    StartTriggerAnimation(Self, 'IsExpanded');
    if FButton <> nil then
      FButton.StartTriggerAnimation(Self, 'IsExpanded');
  end;
end;

procedure TvgExpander.DoCheckChange(Sender: TObject);
begin
  if (FCheck <> nil) then
  begin
    FIsChecked := FCheck.IsChecked;
    FContent.Enabled := FIsChecked;
    if Assigned(OnCheckChange) then
      OnCheckChange(Self);
  end;
end;

procedure TvgExpander.SetIsChecked(const Value: boolean);
begin
  if FIsChecked <> Value then
  begin
    FIsChecked := Value;
    FContent.Enabled := FIsChecked;
    if FCheck <> nil then
      FCheck.IsChecked := FIsChecked;
  end;
end;

procedure TvgExpander.SetShowCheck(const Value: boolean);
begin
  if FShowCheck <> Value then
  begin
    FShowCheck := Value;
    if FCheck <> nil then
      FCheck.Visible := FShowCheck;
  end;
end;

{$IfDef vgDesign}
procedure TvgExpander.DesignClick;
begin
  inherited;
  IsExpanded := not IsExpanded;
end;
{$EndIf vgDesign}

{ TvgPopupBox =================================================================}

constructor TvgPopupBox.Create(AOwner: TComponent);
begin
  inherited;
  CanFocused := true;
  Height := 21;
  FItems := TvgWideStringList.Create;;
  TvgWideStringList(FItems).OnChange := DoItemsChanged;
  {$IFNDEF NOVCL}
  FPopup := TPopupMenu.Create(nil);
  {$ENDIF}
  FItemIndex := -1;
  FText := '';
end;

procedure TvgPopupBox.Cleanup;
begin
  {$IFNDEF NOVCL}
  FreeAndNil(FPopup);
  {$ENDIF}
  FreeAndNil(FItems);
  inherited;
end;

function TvgPopupBox.GetData: Variant;
begin
  Result := Text;
end;

procedure TvgPopupBox.SetData(const Value: Variant);
var
  S: WideString;
begin
  if VarIsNull(Value) then
    ItemIndex := -1
  else
  if VarIsEvent(Value) then
    OnChange := VariantToEvent(Value)
  else
    if VarIsNumeric(Value) then
      ItemIndex := Value
    else
      if VarIsStr(Value) then
      begin
        S := VarToWideStr(Value);
        if FItems.IndexOf(S) < 0 then
          Text := S
        else
          ItemIndex := FItems.IndexOf(S);
      end;
end;

procedure TvgPopupBox.ApplyStyle;
begin
  inherited;
end;

procedure TvgPopupBox.Click;
begin
  inherited;
  DoPopup;
end;

procedure TvgPopupBox.DoPopup;
{$IFNDEF NOVCL}
var
  Item: TMenuItem;
  VP: TvgPoint;
  i: integer;
{$ENDIF}
begin
  {$IFNDEF NOVCL}
  FPopup.Items.Clear;
  for i := 0 to FItems.Count - 1 do
  begin
    Item := NewItem({$IFDEF FPC}UTF8Encode{$ENDIF}(FItems[i]), 0, i = FItemIndex, true, DoItemClick, 0, '');
    FPopup.Items.Add(Item);
  end;
  if Scene <> nil then
  begin
    VP := LocalToAbsolute(vgPoint(0, Trunc((Height / 2) - ((FItems.Count * 20) div 2))));
    VP := Scene.LocalToScreen(VP);
    FPopup.Popup(round(VP.X), round(VP.Y));
  end;
  {$ENDIF}
end;

procedure TvgPopupBox.DoItemClick(Sender: TObject);
begin
  {$IFNDEF NOVCL}
  ItemIndex := TMenuItem(Sender).MenuIndex;
  {$ENDIF}
end;

procedure TvgPopupBox.DoItemsChanged(Sender: TObject);
begin
  Repaint;
end;

procedure TvgPopupBox.SetItemIndex(const Value: integer);
begin
  if FItemIndex <> Value then
  begin
    FItemIndex := Value;
    if (FItemIndex >= 0) and (Items.Count > 0) then
      Text := Items[FItemIndex]
    else
    begin
      Text := '';
      FItemIndex := -1;
    end;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TvgPopupBox.SetText(const Value: WideString);
begin
  if FItems.Count > 0 then
  begin
    FItemIndex := Items.IndexOf(Value);
    if FItemIndex >= 0 then
      inherited SetText(Value)
    else
      inherited SetText('')
  end
  else
  begin
    FItemIndex := -1;
    inherited SetText('')
  end;
end;

procedure TvgPopupBox.SetItems(const Value: TvgWideStrings);
begin
  FItems.Assign(Value);
end;

{ TvgWindow ===================================================================}

constructor TvgWindow.Create(AOwner: TComponent);
begin
  inherited;
  FautoTranslate := true;
  FShowCloseButton := true;
  FShowSizeGrip := true;
  HitTest := false;
  TextAlign := vgTextalignNear;
  Width := 200;
  Height := 200;
end;

procedure TvgWindow.ApplyStyle;
var
  sizeGrip, closeBtn: TvgObject;
begin
  inherited;
  closeBtn := FindResource('close');
  if (closeBtn <> nil) and (closeBtn is TvgVisualObject) then
  begin
    TvgVisualObject(closeBtn).visible := FShowCloseButton;
    if (closeBtn is TvgCloseButton) and (Assigned(FOnCloseClick)) then
    begin
      TvgCloseButton(closeBtn).CloseForm := false;
      TvgCloseButton(closeBtn).OnClick := FOnCloseClick;
    end;
  end;
  sizeGrip := FindResource('sizegrip');
  if (sizeGrip <> nil) and (sizeGrip is TvgVisualObject) then
  begin
    TvgVisualObject(sizeGrip).visible := FShowSizeGrip;
  end;
end;

procedure TvgWindow.Cleanup;
begin
  inherited;
end;

procedure TvgWindow.SetShowCloseButton(const Value: boolean);
begin
  if FShowCloseButton <> Value then
  begin
    FShowCloseButton := Value;
    Resource := FResource;
  end;
end;

procedure TvgWindow.SetShowSizeGrip(const Value: boolean);
begin
  if FShowSizeGrip <> Value then
  begin
    FShowSizeGrip := Value;
    Resource := FResource;
  end;
end;

{ TvgLayerWindow }

constructor TvgLayerWindow.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TvgLayerWindow.Cleanup;
begin
  inherited;
end;

{ TvgHudWindow }

constructor TvgHudWindow.Create(AOwner: TComponent);
begin
  inherited;
  FFill := TvgBrush.Create(vgBrushSolid, $EA2F2F2F);
  FFill.OnChanged := DoFillChanged;
  FStroke := TvgBrush.Create(vgBrushSolid, $5B000000);
  FStroke.OnChanged := DoFillChanged;
  FStrokeThickness := 1;
  FDisableShadowOnOSX := true;
  FShowCaption := true;
  Font.Style := vgFontBold;
end;

procedure TvgHudWindow.Cleanup;
begin
  FreeAndNil(FStroke);
  FreeAndNil(FFill);
  inherited;
end;

procedure TvgHudWindow.ApplyStyle;
var
  {$IFDEF DARWIN}
  shadow: TvgObject;
  {$endif}
  back: TvgObject;
begin
  inherited;
  {$IFDEF DARWIN}
  shadow := FindResource('shadow');
  if (shadow <> nil) and (shadow is TvgVisualObject) and (FDisableShadowOnOSX) then
  begin
    TvgVisualObject(shadow).visible := false;
  end;
  {$ENDIF}
  back := FindResource('close');
  if (back <> nil) and (back is TvgCloseButton) then
  begin
    if FCloseAlign = vgButtonAlignLeft then
      TvgCloseButton(back).Align := vaLeft
    else
      TvgCloseButton(back).Align := vaRight;
    if TvgVisualObject(back).Visible then
    begin
      TvgVisualObject(back).Visible := FShowCaption;
      {$IfDef vgDesign}
      TvgVisualObject(back).DesignHide := not FShowCaption;
      {$EndIf vgDesign}
    end;
  end;
  back := FindResource('back');
  if (back <> nil) and (back is TvgShape) then
  begin
    TvgShape(back).Fill.Assign(FFill);
  end;
  back := FindResource('stroke');
  if (back <> nil) and (back is TvgShape) then
  begin
    TvgShape(back).Stroke.Assign(FStroke);
    TvgShape(back).StrokeThickness := FStrokeThickness;
    TvgShape(back).StrokeCap := FStrokeCap;
    TvgShape(back).StrokeDash := FStrokeDash;
    TvgShape(back).StrokeJoin := FStrokeJoin;
    TvgVisualObject(back).Margins.Rect := vgRect(FStrokeThickness, FStrokeThickness, FStrokeThickness, FStrokeThickness);
  end;
  back := FindResource('caption');
  if (back <> nil) and (back is TvgVisualObject) then
  begin
    TvgVisualObject(back).Height := 20 + FStrokeThickness;
    TvgVisualObject(back).Padding.Rect := vgRect(FStrokeThickness, FStrokeThickness, FStrokeThickness, 0);
    TvgVisualObject(back).Visible := FShowCaption;
    {$IfDef vgDesign}
    TvgVisualObject(back).DesignHide := not FShowCaption;
    {$EndIf vgDesign}
  end;
  back := FindResource('text');
  if (back <> nil) and (back is TvgVisualObject) then
  begin
    TvgVisualObject(back).Visible := FShowCaption;
    {$IfDef vgDesign}
    TvgVisualObject(back).DesignHide := not FShowCaption;
    {$EndIf vgDesign}
  end;
end;

procedure TvgHudWindow.SetDisableShadowOnOSX(const Value: boolean);
begin
  if FDisableShadowOnOSX <> Value then
  begin
    FDisableShadowOnOSX := Value;
    Resource := FResource;
  end;
end;

procedure TvgHudWindow.SetFill(const Value: TvgBrush);
begin
  FFill.Assign(Value);
end;

procedure TvgHudWindow.DoFillChanged(Sender: TObject);
begin
  if not (csLoading in ComponentState) then
    ApplyStyle;
end;

function TvgHudWindow.isStrokeThicknessStored: Boolean;
begin
  Result := StrokeThickness <> 1;
end;

procedure TvgHudWindow.SetStroke(const Value: TvgBrush);
begin
  if FStroke <> Value then
  begin
    FStroke := Value;
    if not (csLoading in ComponentState) then
      ApplyStyle;
  end;
end;

procedure TvgHudWindow.SetStrokeCap(const Value: TvgStrokeCap);
begin
  if FStrokeCap <> Value then
  begin
    FStrokeCap := Value;
    if not (csLoading in ComponentState) then
      ApplyStyle;
  end;
end;

procedure TvgHudWindow.SetStrokeDash(const Value: TvgStrokeDash);
begin
  if FStrokeDash <> Value then
  begin
    FStrokeDash := Value;
    if not (csLoading in ComponentState) then
      ApplyStyle;
  end;
end;

procedure TvgHudWindow.SetStrokeJoin(const Value: TvgStrokeJoin);
begin
  if FStrokeJoin <> Value then
  begin
    FStrokeJoin := Value;
    if not (csLoading in ComponentState) then
      ApplyStyle;
  end;
end;

procedure TvgHudWindow.SetStrokeThickness(const Value: single);
begin
  if FStrokeThickness <> Value then
  begin
    FStrokeThickness := Value;
    if not (csLoading in ComponentState) then
      ApplyStyle;
  end;
end;

procedure TvgHudWindow.SetCloseAlign(const Value: TvgCloseAlign);
begin
  if FCloseAlign <> Value then
  begin
    FCloseAlign := Value;
    if not (csLoading in ComponentState) then
      ApplyStyle;
  end;
end;

procedure TvgHudWindow.SetShowCaption(const Value: boolean);
begin
  if FShowCaption <> Value then
  begin
    FShowCaption := Value;
    if not (csLoading in ComponentState) then
      ApplyStyle;
  end;
end;

{ TvgBitmapStateButton }

constructor TvgBitmapStateButton.Create(AOwner: TComponent);
begin
  inherited;
  FBitmap := TvgBitmap.Create(1, 1);
  FBitmap.OnChange := DoBitmapChanged;
  FBitmapHot := TvgBitmap.Create(1, 1);
  FBitmapDown := TvgBitmap.Create(1, 1);
  Width := 64;
  Height := 64;
end;

procedure TvgBitmapStateButton.Cleanup;
begin
  FreeAndNil(FBitmap);
  FreeAndNil(FBitmapHot);
  FreeAndNil(FBitmapDown);
  inherited;
end;

procedure TvgBitmapStateButton.ApplyStyle;
begin
  inherited;
end;

procedure TvgBitmapStateButton.DoBitmapChanged(Sender: TObject);
begin
  Repaint;
end;

procedure TvgBitmapStateButton.SetBitmap(const Value: TvgBitmap);
begin
end;

procedure TvgBitmapStateButton.SetBitmapDown(const Value: TvgBitmap);
begin
end;

procedure TvgBitmapStateButton.SetBitmapHot(const Value: TvgBitmap);
begin
end;

procedure TvgBitmapStateButton.Paint;
var
  scale: single;
  R: TvgRect;
  B: TvgBitmap;
begin
  if IsPressed then
    B := FBitmapDown
  else
    if IsMouseOver then
      B := FBitmapHot
    else
      B := FBitmap;

  R := vgRect(0, 0, B.Width, B.Height);
  scale := vgFitRect(R, LocalRect);
  if scale > 1 then
    TvgCanvas(Canvas).DrawBitmap(B, vgRect(0, 0, B.Width, B.Height), R, AbsoluteOpacity)
  else
  begin
    R := vgRect(0, 0, B.Width, B.Height);
    vgRectCenter(R, LocalRect);
    TvgCanvas(Canvas).DrawBitmap(B, vgRect(0, 0, B.Width, B.Height), R, AbsoluteOpacity)
  end;
end;

procedure TvgBitmapStateButton.MouseEnter;
begin
  inherited;
  Repaint; 
end;

procedure TvgBitmapStateButton.MouseLeave;
begin
  inherited;
  Repaint;
end;

procedure TvgBitmapStateButton.StartTriggerAnimation(AInstance: TvgObject;
  ATrigger: string);
begin
  inherited;
  if Pos('IsPressed', ATrigger) > 0 then
  begin
    Repaint;
  end;
end;

{ TvgImageControl }

constructor TvgImageControl.Create(AOwner: TComponent);
begin
  inherited;
  CanFocused := true;
  FEnableOpenDialog := true;
  FBitmap := TvgBitmap.Create(1, 1);
  FBitmap.OnChange := DoBitmapChanged;
end;

procedure TvgImageControl.Cleanup;
begin
  FreeAndNil(FBitmap);
  inherited;
end;

procedure TvgImageControl.ApplyStyle;
var
  O: TvgObject;
begin
  inherited;
  O := FindResource('image');
  if (O <> nil) and (O is TvgImage) then
  begin
    FImage := TvgImage(O);
    FImage.Bitmap.Assign(FBitmap);
  end;
end;

procedure TvgImageControl.FreeStyle;
begin
  inherited;
  FImage := nil;
end;

procedure TvgImageControl.Click;
{$IFNDEF NOVCL}
var
  D: TOpenDialog;
{$ENDIF}
begin
  inherited;
  if not FEnableOpenDialog then Exit;
  {$IFNDEF NOVCL}
  D := TOpenDialog.Create(nil);
  D.Filter := DefaultFilterClass.GetFileTypes;
  if D.Execute then
  begin
    Bitmap.LoadFromFile(D.FileName);
  end;
  FreeAndNil(D);
  {$ENDIF}
end;

procedure TvgImageControl.DragOver(const Data: TvgDragObject;
  const Point: TvgPoint; var Accept: Boolean);
begin
  inherited;
  // accept correct image file or TvgImage
  Accept :=
    ((Length(Data.Files) > 0) and FileExists(Data.Files[0]) and (Pos(ExtractFileExt(Data.Files[0]), DefaultFilterClass.GetFileTypes) > 0))
    or
    (Data.Source is TvgImage);
end;

procedure TvgImageControl.DragDrop(const Data: TvgDragObject;
  const Point: TvgPoint);
begin
  inherited;
  if Data.Source is TvgImage then
  begin
    Bitmap.Assign(TvgImage(Data.Source).Bitmap);
  end
  else
  if Length(Data.Files) > 0 then
  begin
    Bitmap.LoadFromFile(Data.Files[0]);
  end;
end;

procedure TvgImageControl.SetBitmap(const Value: TvgBitmap);
begin
  FBitmap.Assign(Value);
end;

procedure TvgImageControl.DoBitmapChanged(Sender: TObject);
var
  R: TvgRect;
begin
  if FImage <> nil then
  begin
    { create thumbnail }
    R := vgRect(0, 0, FBitmap.Width, FBitmap.Height);
    vgFitRect(R, vgRect(0, 0, FImage.Width, FImage.Height));
    FImage.Bitmap.SetSize(round(vgRectWidth(R)), round(vgRectHeight(R)));
    if TvgCanvas(FImage.Bitmap.Canvas).BeginScene then
    begin
      TvgCanvas(FImage.Bitmap.Canvas).Clear(0);
      TvgCanvas(FImage.Bitmap.Canvas).DrawBitmap(FBitmap, vgRect(0, 0, FBitmap.Width, FBitmap.Height),
        vgRect(0, 0, FImage.Bitmap.Width, FImage.Bitmap.Height), 1);
      TvgCanvas(FImage.Bitmap.Canvas).EndScene;
    end;
    FImage.Repaint;

    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

function TvgImageControl.GetData: Variant;
begin
  Result := ObjectToVariant(Bitmap);
end;

procedure TvgImageControl.SetData(const Value: Variant);
begin
  if VarIsNull(Value) then
    Bitmap.SetSize(1, 1)
  else
  if VarIsObject(Value) then
  begin
    if VariantToObject(Value) is TPersistent then
      Bitmap.Assign(TPersistent(VariantToObject(Value)));
  end
  else
    if VarIsStr(Value) then
      Bitmap.LoadFromFile(Value)
end;

initialization
  RegisterClasses([TvgSelectionItem, TvgThumb, TvgExpanderButton]);
  RegisterVGObjects('Windows', [TvgBackground, TvgSizeGrip, TvgCloseButton]);
  RegisterVGObjects('Boxes', [TvgCheckBox, TvgPathCheckBox, TvgRadioButton, TvgGroupBox,
    TvgPopupBox]);
  RegisterVGObjects('Controls', [TvgPanel, TvgCalloutPanel, TvgLabel, TvgValueLabel,
    TvgImageControl, TvgProgressBar, TvgTrack, TvgScrollBar, TvgSmallScrollBar, TvgAniIndicator,
    TvgExpander, TvgTrackBar, TvgSplitter]);
  RegisterVGObjects('Tool and Status', [TvgStatusBar, TvgToolBar, TvgToolButton, TvgToolPathButton]);
  RegisterVGObjects('Buttons', [TvgButton, TvgRoundButton, TvgCircleButton, TvgBitmapButton, TvgPathButton, TvgSpeedButton, TvgCornerButton,
    TvgColorButton, TvgAngleButton, TvgBitmapStateButton, TvgPopupButton]);
  RegisterVGObjects('HUD', [TvgHudPanel, TvgHudWindow, TvgHudButton, TvgHudSpeedButton, TvgHudAngleButton, TvgHudTrack, TvgHudTrackBar,
    TvgHudScrollBar, TvgHudPopupBox, TvgHudLabel, TvgHudCheckBox, TvgHudRadioButton, TvgHudGroupBox, TvgHudCloseButton,
    TvgHudStatusBar, TvgHudSizeGrip, TvgHudRoundButton, TvgHudCornerButton, TvgHudCircleButton]);
end.
