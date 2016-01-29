{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Types;

{$DEFINE STYLERESOURCECACHE}

{$MINENUMSIZE 4}
{$H+}

interface

uses
  System.Types, System.UITypes, System.UIConsts, System.Math, System.Variants,
  System.Classes, System.Actions, System.SysUtils, System.StrUtils, System.Rtti,
  System.Generics.Collections, System.Generics.Defaults, FMX.ActnList,
  FMX.PixelFormats, FMX.Messages, FMX.Surfaces;

{$SCOPEDENUMS ON}

const
{$HPPEMIT '#define FireMonkeyVersion 18.0'}
  FireMonkeyVersion = 18.0;
{$EXTERNALSYM FireMonkeyVersion}

{ Global Settings }

var
  GlobalUseHWEffects: Boolean = True;
  // On low-end hardware or mobile bitmap effects are slowly
  GlobalDisableFocusEffect: Boolean = False;
  // Use Direct3D 10 in Windows Vista or Windows 7 by default
  GlobalUseDX10: Boolean = True;
  // Use Direct3D 10 in Windows Vista or Windows 7 in software mode
  GlobalUseDX10Software: Boolean = False;
  // Use Direct2D in Windows Vista or Windows 7 by default
  GlobalUseDirect2D: Boolean = True;
  // Use ClearType rendering in GDI+ renderer
  GlobalUseGDIPlusClearType: Boolean = True;
  /// <remarks> The digit of rounding, of width and height controls</remarks>
  DigitRoundSize: TRoundToRange = -3;
  // Use GPU Canvas
  GlobalUseGPUCanvas: Boolean = False;

type
  ///	<summary>
  ///	Specify when the function
  ///	<see cref="IFMXVirtualKeyboardService.GetVirtualKeyBoardState"/> TVKAutoShowMode.
  ///	<para><c>vkasDefinedBySystem</c> - Is determined by the system (default). For example for Windows, the function
  ///	GetVirtualKeyBoardState returns vksAutoShow if you are not keyboard
  ///	represented in the system</para>
  ///	<para><c>vkasNever</c> - Never returned vksAutoShow</para>
  ///	<para><c>vkasAlways</c> - Always returned vksAutoShow  </para>
  ///	</summary>
  TVKAutoShowMode = (vkasDefinedBySystem, vkasNever, vkasAlways);

var
  /// <summary>
  ///  This variable is used for debugging purposes. Determines which value will return
  ///  as a function <see cref="IFMXVirtualKeyboardService.GetVirtualKeyBoardState"/>
  /// </summary>
  VKAutoShowMode: TVKAutoShowMode = TVKAutoShowMode.vkasDefinedBySystem;


type

  TPointArray = array [0..0] of TPointF;

  TLongByteArray = array [0..MaxInt - 1] of Byte;
  PLongByteArray = ^TLongByteArray;

                                                             
  TCorner = (crTopLeft, crTopRight, crBottomLeft, crBottomRight);

  TCorners = set of TCorner;

  TCornerType = (ctRound, ctBevel, ctInnerRound, ctInnerLine);

  { Four courners describing arbitrary 2D rectangle }
  PCornersF = ^TCornersF;
  TCornersF = array [0 .. 3] of TPointF;

  TSide = (sdTop, sdLeft, sdBottom, sdRight);

  TSides = set of TSide;

  PAlphaColorArray = ^TAlphaColorArray;
  TAlphaColorArray = array [0 .. MaxInt div 4 - 1] of TAlphaColor;

  PAlphaColorRecArray = ^TAlphaColorRecArray;
  TAlphaColorRecArray = array [0 .. MaxInt div 4 - 1] of TAlphaColorRec;

  TTextAlign = (taCenter, taLeading, taTrailing);
  TTextTrimming = (ttNone, ttCharacter, ttWord);
  TStyledSetting = (ssFamily, ssSize, ssStyle, ssFontColor, ssOther);
  TStyledSettings = set of TStyledSetting;

  TMenuItemChange = (mcEnabled, mcVisible, mcText, mcShortcut, mcChecked);
  TMenuItemChanges = set of TMenuItemChange;

  TScreenOrientation = (soPortrait, soLandscape, soInvertedPortrait, soInvertedLandscape);
  TScreenOrientations = set of TScreenOrientation;

const
  IdentityMatrix: TMatrix = (m11: 1.0; m12: 0.0; m13: 0.0; m21: 0.0; m22: 1.0; m23: 0.0; m31: 0.0; m32: 0.0; m33: 1.0);
  NullRect: TRectF = (Left: 0; Top: 0; Right: 0; Bottom: 0);

  AllCorners: TCorners = [TCorner.crTopLeft, TCorner.crTopRight,
    TCorner.crBottomLeft, TCorner.crBottomRight];

  AllSides: TSides = [TSide.sdTop, TSide.sdLeft, TSide.sdBottom, TSide.sdRight];

  ClosePolygon: TPointF = (X: $FFFF; Y: $FFFF);

  AllStyledSettings: TStyledSettings = [TStyledSetting.ssFamily,
                                        TStyledSetting.ssSize,
                                        TStyledSetting.ssStyle,
                                        TStyledSetting.ssFontColor,
                                        TStyledSetting.ssOther];
  DefaultStyledSettings: TStyledSettings = [TStyledSetting.ssFamily,
                                            TStyledSetting.ssSize,
                                            TStyledSetting.ssStyle,
                                            TStyledSetting.ssFontColor];

type
  TGestureID = rgiFirst .. igiLast;

  TInteractiveGestureFlag = (gfBegin, gfInertia, gfEnd);
  TInteractiveGestureFlags = set of TInteractiveGestureFlag;

  TGestureEventInfo = record
    GestureID: TGestureID;
    Location: TPointF;
    Flags: TInteractiveGestureFlags;
    Angle: Double;
    InertiaVector: TPointF;
    Distance: Integer;
    TapLocation: TPointF;
  end;

  TGestureEvent = procedure(Sender: TObject; const EventInfo: TGestureEventInfo;
     var Handled: Boolean) of object;

type

  TAlignLayout = (alNone, alTop, alLeft, alRight, alBottom, alMostTop, alMostBottom, alMostLeft, alMostRight, alClient,
    alContents, alCenter, alVertCenter, alHorzCenter, alHorizontal, alVertical, alScale, alFit, alFitLeft, alFitRight);

  TImeMode = (imDontCare, // All IMEs
              imDisable,  // All IMEs
              imClose,    // Chinese and Japanese only
              imOpen,     // Chinese and Japanese only
              imSAlpha,   // Japanese and Korea
              imAlpha,    // Japanese and Korea
              imHira,     // Japanese only
              imSKata,    // Japanese only
              imKata,     // Japanese only
              imChineseClose, // Chinese IME only
              imOnHalf,   // Chinese IME only
              imSHanguel, // Korean IME only
              imHanguel   // Korean IME only
              );

  TDragObject = record
    Source: TObject;
    Files: array of string;
    Data: TValue;
  end;

  TFmxHandle = THandle;
  TFlasherInterval = -1..1000;

const
  cIdNoTimer: TFmxHandle = TFmxHandle(-1);

type
  TCanActionExecEvent = procedure(Sender: TCustomAction; var CanExec: Boolean) of object;

  TCanvas = class;
  TCanvasClass = class of TCanvas;
  TFmxObject = class;
  TFmxObjectClass = class of TFmxObject;
  TBitmap = class;
  TBounds = class;
  TLineMetricInfo = class;
  TTouchManager = class;
  TCustomPopupMenu = class;

  TWindowHandle = class
  end;

  IFreeNotification = interface
    ['{FEB50EAF-A3B9-4b37-8EDB-1EF9EE2F22D4}']
    procedure FreeNotification(AObject: TObject);
  end;

  IFreeNotificationBehavior = interface
    ['{83F052C5-8696-4AFA-88F5-DCDFEF005480}']
    procedure AddFreeNotify(const AObject: IFreeNotification);
    procedure RemoveFreeNotify(const AObject: IFreeNotification);
  end;

  /// <summary>
  /// This interface provides access to the field IsChecked, to control the type of TCheckBox, TRadioButton
  /// </summary>
  IIsChecked = interface
    ['{DE946EB7-0A6F-4458-AEB0-C911122630D0}']
    function GetIsChecked: boolean;
    procedure SetIsChecked(const Value: boolean);
    function IsCheckedStored: boolean;
    property IsChecked: boolean read GetIsChecked write SetIsChecked;
  end;

  /// <summary>
  /// This interface provides access to the field GroupName, to control the type of TRadioButton
  /// </summary>
  /// <remarks>
  /// For action, this property can only be an integer (see <see cref="TContainedAction.GroupIndex"/>).
  /// </remarks>
  IGroupName = interface (IIsChecked)
    ['{F5C14792-67AB-41F2-99C1-90C7F94102EE}']
    function GetGroupName: string;
    procedure SetGroupName(const Value: string);
    function GroupNameStored: boolean;
    property GroupName: string read GetGroupName write SetGroupName;
  end;

  TCustomCaret = class;

  ICaret = interface
    ['{F4EFFFB8-E83C-421D-B123-C370FB7BCCC7}']
    function GetObject: TCustomCaret;
    procedure ShowCaret;
    procedure HideCaret;
  end;

  IFlasher = interface
    ['{1A9163B4-47FD-45D6-A54F-70158CB01777}']
    function GetColor: TAlphaColor;
    function GetPos: TPointF;
    function GetSize: TSizeF;
    function GetVisible: Boolean;
    function GetOpacity: Single;
    function GetInterval: TFlasherInterval;
    function GetCaret: TCustomCaret;
    procedure SetCaret(const Value: TCustomCaret);

    property Color: TAlphaColor read GetColor;
    property Pos: TPointF read GetPos;
    property Size: TSizeF read GetSize;
    property Visible: boolean read GetVisible;
    property Opacity: Single read GetOpacity;
    property Interval: TFlasherInterval read GetInterval;
    property Caret: TCustomCaret read GetCaret write SetCaret;
    procedure UpdateState;
  end;

  IContainerObject = interface
    ['{DE635E60-CB00-4741-92BB-3B8F1F29A67C}']
    function GetContainerWidth: Single;
    function GetContainerHeight: Single;
    property ContainerWidth: single read GetContainerWidth;
    property ContainerHeight: single read GetContainerHeight;
  end;

  IOriginalContainerSize = interface
    ['{E76F6097-AF5D-49a1-9C7B-5127D6068059}']
    function GetOriginalContainerSize: TPointF;
    property OriginalContainerSize: TPointF read GetOriginalContainerSize;
  end;


  IContent = interface
    ['{96E89B94-2AD6-4AD3-A07C-92E66B2E6BC8}']
    function GetParent: TFmxObject;
    function GetObject: TFmxObject;
    function GetChildrenCount: Integer;
    property Parent: TFmxObject read GetParent;
    property ChildrenCount: Integer read GetChildrenCount;
  end;

  IFMXCursorService = interface(IInterface)
    ['{5D359E54-2543-414E-8268-A53292E4FDB4}']
    procedure SetCursor(const ACursor: TCursor);
    function GetCursor: TCursor;
  end;

  IFMXMouseService = interface(IInterface)
    ['{2370205F-CF27-4DF6-9B1F-5EBC27271D5A}']
    function GetMousePos: TPointF;
  end;

  IControl = interface(IFreeNotificationBehavior)
    ['{7318D022-D048-49DE-BF55-C5C36A2AD1AC}']
    function GetObject: TFmxObject;
    procedure SetFocus;
    procedure SetIsChildFocused(const Value: Boolean);
    function GetIsFocused: boolean;
    function GetIsChildFocused: Boolean;
    function GetCanFocus: Boolean;
    function GetCanParentFocus: Boolean;
    function GetEnabled: Boolean;
    function GetAbsoluteEnabled: Boolean;
    function GetPopupMenu: TCustomPopupMenu;
    function EnterChildren(AObject: IControl): Boolean;
    function ExitChildren(AObject: IControl): Boolean;
    procedure DoEnter;
    procedure DoExit;
    procedure DoActivate;
    procedure DoDeactivate;
    procedure DoMouseEnter;
    procedure DoMouseLeave;
    function ScreenToLocal(P: TPointF): TPointF;
    function LocalToScreen(P: TPointF): TPointF;
    function ObjectAtPoint(P: TPointF): IControl;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure MouseMove(Shift: TShiftState; X, Y: Single);
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure KeyUp(var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure DialogKey(var Key: Word; Shift: TShiftState);
    function FindTarget(P: TPointF; const Data: TDragObject): IControl;
    procedure DragEnter(const Data: TDragObject; const Point: TPointF);
    procedure DragOver(const Data: TDragObject; const Point: TPointF; var Accept: Boolean);
    procedure DragDrop(const Data: TDragObject; const Point: TPointF);
    procedure DragLeave;
    procedure DragEnd;
    function CheckForAllowFocus: Boolean;
    function GetTabOrderValue: TTabOrder;
    procedure UpdateTabOrder(Value: TTabOrder);
    procedure Repaint;
    function GetDragMode: TDragMode;
    procedure SetDragMode(const ADragMode: TDragMode);
    procedure BeginAutoDrag;
    function GetParent: TFmxObject;
    function GetLocked: Boolean;
    function GetVisible: Boolean;
    procedure SetVisible(const Value: Boolean);
    function GetHitTest: Boolean;
    function GetCursor: TCursor;
    function GetInheritedCursor: TCursor;
    function GetDesignInteractive: Boolean;
    function GetAcceptsControls: Boolean;
    procedure SetAcceptsControls(const Value: Boolean);
    procedure BeginUpdate;
    procedure EndUpdate;
    { access }
    property AbsoluteEnabled: Boolean read GetAbsoluteEnabled;
    property Cursor: TCursor read GetCursor;
    property InheritedCursor: TCursor read GetInheritedCursor;
    property DragMode: TDragMode read GetDragMode write SetDragMode;
    property DesignInteractive: Boolean read GetDesignInteractive;
    property Enabled: Boolean read GetEnabled;
    property Parent: TFmxObject read GetParent;
    property Locked: Boolean read GetLocked;
    property HitTest: Boolean read GetHitTest;
    property PopupMenu: TCustomPopupMenu read GetPopupMenu;
    property Visible: Boolean read GetVisible write SetVisible;
    property AcceptsControls: Boolean read GetAcceptsControls write SetAcceptsControls;
    property IsFocused: boolean read GetIsFocused;
    property IsChildFocused: boolean read GetIsChildFocused write SetIsChildFocused;
  end;

  ITouchEvents = interface
  ['{BA964024-0550-4FE9-8B62-2820FCBD88A7}']
    procedure LongTap(const X, Y: Single);
    procedure DblTap;
  end;

  IRoot = interface
    ['{7F7BB7B0-5932-49dd-9D35-712B2BA5D8EF}']
    procedure AddObject(const AObject: TFmxObject);
    procedure InsertObject(Index: Integer; const AObject: TFmxObject);
    procedure RemoveObject(const AObject: TFmxObject); overload;
    procedure RemoveObject(Index: Integer); overload;
    procedure BeginInternalDrag(const Source: TObject; const ABitmap: TBitmap);
    function GetActiveControl: IControl;
    procedure SetActiveControl(const AControl: IControl);
    function GetCaptured: IControl;
    procedure SetCaptured(const Value: IControl);
    function GetFocused: IControl;
    procedure SetFocused(const Value: IControl);
    function NewFocusedControl(const Value: IControl): IControl;
    function GetHovered: IControl;
    procedure SetHovered(const Value: IControl);
    function GetObject: TFmxObject;
    function GetBiDiMode: TBiDiMode;
    { access }
    property Captured: IControl read GetCaptured write SetCaptured;
    property Focused: IControl read GetFocused write SetFocused;
    property Hovered: IControl read GetHovered write SetHovered;
    property BiDiMode: TBiDiMode read GetBiDiMode;
  end;

  IAlignRoot = interface
  ['{86DF30A6-0394-4a0e-8722-1F2CDB242CE8}']
    procedure Realign;
    procedure ChildrenAlignChanged;
  end;

  INativeControl = interface
  ['{3E6F1A17-BAE3-456C-8551-5F6EA92EEE32}']
    function GetHandle: TFmxHandle;
    procedure SetHandle(const Value: TFmxHandle);
    function GetHandleSupported: boolean;
    property HandleSupported: boolean read GetHandleSupported;
    property Handle: TFmxHandle read GetHandle write SetHandle;
  end;

  IPaintControl = interface
  ['{47959F99-CCA5-4ACF-BB8D-357F126E9C78}']
    procedure PaintRects(const UpdateRects: array of TRectF);
    procedure SetContextHandle(const AContextHandle: THandle);
    function GetContextHandle: THandle;
    property ContextHandle: THandle read GetContextHandle write SetContextHandle;
  end;

  ///  <summary>Enumeration used by controls which support IVirtualKeyboardControl
  ///  interface to control the type of on-screen keyboard to be displayed.
  ///  The values may have different interpretations on different devices, but
  ///  should generally follow these guidelines:
  ///  <para><c>vktDefault:</c> An alpha-numeric keyboard for general
  ///  text entry</para>
  ///  <para><c>vktNumbersAndPunctuation:</c> A keyboard which provides for numeric
  ///  entry and punctuation symbols.</para>
  ///  <para><c>vktNumberPad:</c> A numeric-only keyboard.</para>
  ///  <para><c>vktPhonePad:</c> A keyboard for entering a telephone number,
  ///  including '*' and '#' symbols.</para></summary>
  TVirtualKeyboardType = (vktDefault, vktNumbersAndPunctuation, vktNumberPad, vktPhonePad,
                          vktAlphabet, vktURL, vktNamePhonePad, vktEmailAddress);

  /// <summary>
  /// It is used to determine the current state of the keyboard
  /// <para>see <c>IFMXVirtualKeyboardService</c></para>
  /// <para><c>vksAutoShow</c> The keyboard should always show up when receiving the input focus</para>
  /// <para><c>vksVisible</c> At this time the keyboard is visible</para>
  /// <para><c>vksError</c> If you try to display the onscreen keyboard error occurs</para>
  /// </summary>
  TVirtualKeyBoardState = set of (vksAutoShow, vksVisible, vksError);

  /// <summary>Controls which implement this interface can set the style of on-screen
  ///  keyboard which will be displayed when the control is activated. This
  ///  setting is used only on devices which use an on-screen keyboard. It is ignored
  ///  on devices which use a physical keyboard for text entry.</summary>
  IVirtualKeyboardControl = interface
    ['{41127080-97FC-4C30-A880-AB6CD351A6C4}']
    procedure SetKeyboardType(Value: TVirtualKeyboardType);
    function GetKeyboardType: TVirtualKeyboardType;
    property KeyboardType: TVirtualKeyboardType read GetKeyboardType write SetKeyboardType;
  end;

  IAlignableObject = interface
    ['{420D3E98-4433-4cbe-9767-0B494DF08354}']
    function GetAlign: TAlignLayout;
    procedure SetAlign(const Value: TAlignLayout);
    function GetAnchors: TAnchors;
    procedure SetAnchors(const Value: TAnchors);
    function GetMargins: TBounds;
    procedure SetBounds(X, Y, AWidth, AHeight: Single);
    function GetPadding: TBounds;
    function GetWidth: single;
    function GetHeight: single;
    function GetLeft: single;
    function GetTop: single;
    function GetAllowAlign: Boolean;

    function GetAnchorRules: TPointF;
    function GetAnchorOrigin: TPointF;
    function GetOriginalParentSize: TPointF;
    function GetAnchorMove : Boolean;
    procedure SetAnchorMove(Value : Boolean);

    { access }
    property Align: TAlignLayout read GetAlign write SetAlign;
    property AllowAlign: Boolean read GetAllowAlign;
    property Anchors: TAnchors read GetAnchors write SetAnchors;
    property Margins: TBounds read GetMargins;
    property Padding: TBounds read GetPadding;
    property Left: single read GetLeft;
    property Height: single read GetHeight;
    property Width: single read GetWidth;
    property Top: single read GetTop;

    property AnchorRules: TPointF read GetAnchorRules;
    property AnchorOrigin: TPointF read GetAnchorOrigin;
    property OriginalParentSize: TPointF read GetOriginalParentSize;
    property AnchorMove : Boolean read GetAnchorMove write SetAnchorMove;
  end;

  IItemsContainer = interface
    ['{100B2F87-5DCB-4699-B751-B4439588E82A}']
    function GetItemsCount: Integer;
    function GetItem(const AIndex: Integer): TFmxObject;
    function GetObject: TFmxObject;
  end;

  TTangentPair = record
    I: Single;
    Ip1: Single;
  end;

  TSpline = class(TObject)
  private
    FTangentsX, FTangentsY: array of TTangentPair;
    FValuesX, FValuesY: array of Single;
  public
    constructor Create(const Polygon: TPolygon);
    destructor Destroy; override;
    procedure SplineXY(const t: Single; var X, Y: Single);
  end;

  TDragEnterEvent = procedure(Sender: TObject; const Data: TDragObject; const Point: TPointF) of object;
  TDragOverEvent = procedure(Sender: TObject; const Data: TDragObject; const Point: TPointF; var Accept: Boolean) of object;
  TDragDropEvent = procedure(Sender: TObject; const Data: TDragObject; const Point: TPointF) of object;
  TCanFocusEvent = procedure(Sender: TObject; var ACanFocus: Boolean) of object;

{ TBounds }

  TBounds = class(TPersistent)
  private
    FRight: Single;
    FBottom: Single;
    FTop: Single;
    FLeft: Single;
    FOnChange: TNotifyEvent;
    FDefaultValue: TRectF;
    FStoreAsInt: Boolean;
    function GetRect: TRectF;
    procedure SetRect(const Value: TRectF);
    procedure SetBottom(const Value: Single);
    procedure SetLeft(const Value: Single);
    procedure SetRight(const Value: Single);
    procedure SetTop(const Value: Single);
    function IsBottomStored: Boolean;
    function IsLeftStored: Boolean;
    function IsRightStored: Boolean;
    function IsTopStored: Boolean;
    procedure ReadLeftInt(Reader: TReader);
    procedure ReadBottomInt(Reader: TReader);
    procedure ReadRightInt(Reader: TReader);
    procedure ReadTopInt(Reader: TReader);
    procedure WriteLeftInt(Writer: TWriter);
    procedure WriteBottomInt(Writer: TWriter);
    procedure WriteRightInt(Writer: TWriter);
    procedure WriteTopInt(Writer: TWriter);
    procedure ReadRectInt(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadRect(Reader: TReader);
    procedure WriteRect(Writer: TWriter);
  public
    constructor Create(const ADefaultValue: TRectF); virtual;
    procedure Assign(Source: TPersistent); override;
    function Equals(Obj: TObject): Boolean; override;
    function PaddingRect(const R: TRectF): TRectF;
    function MarginRect(const R: TRectF): TRectF;
    function Width: Single;
    function Height: Single;
    property Rect: TRectF read GetRect write SetRect;
    property StoreAsInt: Boolean read FStoreAsInt write FStoreAsInt;
    property DefaultValue: TRectF read FDefaultValue write FDefaultValue;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    function Empty: Boolean;
    function MarginEmpty: Boolean;
  published
    property Left: Single read FLeft write SetLeft stored IsLeftStored nodefault;
    property Top: Single read FTop write SetTop stored IsTopStored nodefault;
    property Right: Single read FRight write SetRight stored IsRightStored nodefault;
    property Bottom: Single read FBottom write SetBottom stored IsBottomStored nodefault;
  end;

{ TPosition }

  TPosition = class(TPersistent)
  private
    FOnChange: TNotifyEvent;
    FY: Single;
    FX: Single;
    FDefaultValue: TPointF;
    procedure SetPoint(const Value: TPointF);
    procedure SetX(const Value: Single);
    procedure SetY(const Value: Single);
    function GetPoint: TPointF;
    function GetVector: TVector;
    procedure SetVector(const Value: TVector);
    function IsXStored: Boolean;
    function IsYStored: Boolean;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadPoint(Reader: TReader);
    procedure WritePoint(Writer: TWriter);
  public
    constructor Create(const ADefaultValue: TPointF); virtual;
    procedure Assign(Source: TPersistent); override;
    procedure SetPointNoChange(const P: TPointF);
    function Empty: Boolean;
    procedure Reflect(const Normal: TVector);
    property Point: TPointF read GetPoint write SetPoint;
    property Vector: TVector read GetVector write SetVector;
    property DefaultValue: TPointF read FDefaultValue write FDefaultValue;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property X: Single read FX write SetX stored IsXStored nodefault;
    property Y: Single read FY write SetY stored IsYStored nodefault;
  end;

  TCaretDisplayChanged = procedure (Sender: TCustomCaret; const VirtualKeyBoardState: TVirtualKeyBoardState) of object;

  TCaretClass = class of TCustomCaret;

  TCustomCaret = class (TPersistent)
  private
    [Weak]FOwner: TFMXObject;
    FIControl: IControl;
    FVisible: Boolean;
    FDisplayed: Boolean;
    FTemporarilyHidden: Boolean;
    FChanged: Boolean;
    FUpdateCount: Integer;
    FOnDisplayChanged: TCaretDisplayChanged;
    FColor: TAlphaColor;
    FDefaultColor: TAlphaColor;
    FPos: TPointF;
    FSize: TSizeF;
    FInterval: TFlasherInterval;
    FReadOnly: Boolean;
    procedure SetColor(const Value: TAlphaColor);
    procedure SetPos(const Value: TPointF);
    procedure SetSize(const Value: TSizeF);
    procedure SetTemporarilyHidden(const Value: boolean);
    procedure SetVisible(const Value: Boolean);
    procedure SetInterval(const Value: TFlasherInterval);
    procedure SetReadOnly(const Value: boolean);
    procedure StartTimer;
    function GetWidth: Word;
    procedure SetWidth(const Value: Word);
    function GetFlasher: IFlasher;
  protected
    function GetOwner: TPersistent; override;
    /// <summary>
    ///   hide the caret
    /// </summary>
    procedure Hide; virtual;
    /// <summary>
    ///   if possible (CanShow = True and Visible = True), the caret show.
    /// </summary>
    procedure Show; virtual;
    /// <summary>
    ///   This method is performed after changing the Displayed
    /// </summary>
    procedure DoDisplayChanged(const VirtualKeyBoardState: TVirtualKeyBoardState); virtual;
    procedure DoUpdateFlasher; virtual;
    procedure SetDefaultColor(const Value: TAlphaColor);
  public
    constructor Create(const AOwner: TFMXObject); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Pos: TPointF read FPos write SetPos;
    property Size: TSizeF read FSize write SetSize;
    property Color: TAlphaColor read FColor write SetColor default TAlphaColorRec.Null;
    property DefaultColor: TAlphaColor read FDefaultColor;
    property Interval: TFlasherInterval read FInterval write SetInterval default 0;
    property Owner: TFMXObject read FOwner;
    property Control: IControl read FIControl;
    procedure BeginUpdate;
    procedure EndUpdate;
    class function FlasherName: string; virtual; abstract;
    property UpdateCount: integer read FUpdateCount;
    /// <summary>
    ///   The update of the "Flasher", if UpdateCount = 0.
    /// </summary>
    procedure UpdateFlasher;
    /// <summary>
    ///   This property controls the visibility of a caret, for the control in which the input focus.
    /// </summary>
    property Visible: Boolean read FVisible write SetVisible;
    /// <summary>
    ///   The function returns true, if the control is visible, enabled,
    ///   has the input focus and it in an active form
    /// </summary>
    function CanShow: Boolean; virtual;
    /// <summary>
    ///   This property is set to True, after the successful execution of
    ///   method Show, and is set to False after method Hide
    /// </summary>
    property Displayed: Boolean read FDisplayed;
    /// <summary>
    ///   If this property is 'true', the blinking control is invisible
    ///   and does not take values of Visible, Displayed.
    ///   When you change the properties, methods DoShow, DoHide, DoDisplayChanged not met.
    /// </summary>
    property TemporarilyHidden: boolean read FTemporarilyHidden write SetTemporarilyHidden;
    /// <summary>
    ///   Blinking visual component is displayed.
    ///   Usually this line, having a thickness of one or two pixels.
    /// </summary>
    property Flasher: IFlasher read GetFlasher;
    property ReadOnly: boolean read FReadOnly write SetReadOnly;
    property Width: Word read GetWidth write SetWidth default 0;

    property OnDisplayChanged: TCaretDisplayChanged read FOnDisplayChanged write FOnDisplayChanged;
  end;

{ TTransform }

  TTransform = class(TPersistent)
  private
    FMatrix: TMatrix;
    FRotationAngle: Single;
    FPosition: TPosition;
    FScale: TPosition;
    FSkew: TPosition;
    FRotationCenter: TPosition;
    FOnChanged: TNotifyEvent;
    procedure SetRotationAngle(const Value: Single);
    procedure SetScale(const Value: TPosition);
    procedure SetPosition(const Value: TPosition);
  protected
    procedure MatrixChanged(Sender: TObject);
    property Skew: TPosition read FSkew write FSkew;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Matrix: TMatrix read FMatrix;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  published
    property Position: TPosition read FPosition write SetPosition;
    property Scale: TPosition read FScale write SetScale;
    property RotationAngle: Single read FRotationAngle write SetRotationAngle;
    property RotationCenter: TPosition read FRotationCenter write FRotationCenter;
  end;

{ TGradientPoint }

  TGradientPoint = class(TCollectionItem)
  private
    FColor: TAlphaColor;
    FOffset: Single;
    function GetColor: TAlphaColor;
    procedure SetColor(const Value: TAlphaColor);
  public
    procedure Assign(Source: TPersistent); override;
    property IntColor: TAlphaColor read FColor write FColor;
  published
    property Color: TAlphaColor read GetColor write SetColor;
    property Offset: Single read FOffset write FOffset nodefault;
  end;

{ TGradientPoints }

  TGradientPoints = class(TCollection)
  private
    function GetPoint(Index: Integer): TGradientPoint;
  public
    property Points[Index: Integer]: TGradientPoint read GetPoint; default;
  end;

{ TGradient }

  TGradientStyle = (gsLinear, gsRadial);

  TGradient = class(TPersistent)
  private
    FPoints: TGradientPoints;
    FOnChanged: TNotifyEvent;
    FStartPosition: TPosition;
    FStopPosition: TPosition;
    FStyle: TGradientStyle;
    FRadialTransform: TTransform;
    procedure SetStartPosition(const Value: TPosition);
    procedure SetStopPosition(const Value: TPosition);
    procedure PositionChanged(Sender: TObject);
    procedure SetColor(const Value: TAlphaColor);
    procedure SetColor1(const Value: TAlphaColor);
    function IsLinearStored: Boolean;
    procedure SetStyle(const Value: TGradientStyle);
    function IsRadialStored: Boolean;
    procedure SetRadialTransform(const Value: TTransform);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Change;
    function InterpolateColor(Offset: Single): TAlphaColor; overload;
    function InterpolateColor(X, Y: Single): TAlphaColor; overload;
    function Equal(const AGradient: TGradient): Boolean;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    { fast access }
    property Color: TAlphaColor write SetColor;
    property Color1: TAlphaColor write SetColor1;
  published
    property Points: TGradientPoints read FPoints write FPoints;
    property Style: TGradientStyle read FStyle write SetStyle default TGradientStyle.gsLinear;
    { linear }
    property StartPosition: TPosition read FStartPosition write SetStartPosition stored IsLinearStored;
    property StopPosition: TPosition read FStopPosition write SetStopPosition stored IsLinearStored;
    { radial }
    property RadialTransform: TTransform read FRadialTransform write SetRadialTransform stored IsRadialStored;
  end;

{ TBrushResource }

  TBrush = class;
  TBrushObject = class;

  TBrushResource = class(TInterfacedPersistent, IFreeNotification)
  private
    FStyleResource: TBrushObject;
    FStyleLookup: string;
    FOnChanged: TNotifyEvent;
    function GetBrush: TBrush;
    procedure SetStyleResource(const Value: TBrushObject);
    function GetStyleLookup: string;
    procedure SetStyleLookup(const Value: string);
    { IFreeNotification }
    procedure FreeNotification(AObject: TObject);
  public
    destructor Destroy; override;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    procedure Assign(Source: TPersistent); override;
    property Brush: TBrush read GetBrush;
  published
    property StyleResource: TBrushObject read FStyleResource write SetStyleResource stored False;
    property StyleLookup: string read GetStyleLookup write SetStyleLookup;
  end;

{ TBrushBitmap }

  TWrapMode = (wmTile, wmTileOriginal, wmTileStretch);

  TBrushBitmap = class(TInterfacedPersistent)
  private
    FOnChanged: TNotifyEvent;
    FBitmap: TBitmap;
    FWrapMode: TWrapMode;
    procedure SetWrapMode(const Value: TWrapMode);
    procedure SetBitmap(const Value: TBitmap);
  protected
    procedure DoChanged; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    procedure Assign(Source: TPersistent); override;
  published
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property WrapMode: TWrapMode read FWrapMode write SetWrapMode;
  end;

{ TBrush }

  TBrushKind = (bkNone, bkSolid, bkGradient, bkBitmap, bkResource);

  TBrush = class(TPersistent)
  private
    FColor: TAlphaColor;
    FKind: TBrushKind;
    FOnChanged: TNotifyEvent;
    FGradient: TGradient;
    FDefaultKind: TBrushKind;
    FDefaultColor: TAlphaColor;
    FResource: TBrushResource;
    FBitmap: TBrushBitmap;
    FOnGradientChanged: TNotifyEvent;
    procedure SetColor(const Value: TAlphaColor);
    procedure SetKind(const Value: TBrushKind);
    procedure SetGradient(const Value: TGradient);
    function IsColorStored: Boolean;
    function IsGradientStored: Boolean;
    function GetColor: TAlphaColor;
    function IsKindStored: Boolean;
    procedure SetResource(const Value: TBrushResource);
    function IsResourceStored: Boolean;
    function IsBitmapStored: Boolean;
  protected
    procedure GradientChanged(Sender: TObject);
    procedure ResourceChanged(Sender: TObject);
    procedure BitmapChanged(Sender: TObject);
  public
    constructor Create(const ADefaultKind: TBrushKind; const ADefaultColor: TAlphaColor);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    property OnGradientChanged: TNotifyEvent read FOnGradientChanged write FOnGradientChanged;
    property DefaultColor: TAlphaColor read FDefaultColor write FDefaultColor;
    property DefaultKind: TBrushKind read FDefaultKind write FDefaultKind;
  published
    property Color: TAlphaColor read GetColor write SetColor stored IsColorStored;
    property Bitmap: TBrushBitmap read FBitmap write FBitmap stored IsBitmapStored;
    property Kind: TBrushKind read FKind write SetKind stored IsKindStored;
    property Gradient: TGradient read FGradient write SetGradient stored IsGradientStored;
    property Resource: TBrushResource read FResource write SetResource stored IsResourceStored;
  end;

  TStrokeCap = (scFlat, scRound);

  TStrokeJoin = (sjMiter, sjRound, sjBevel);

  TStrokeDash = (sdSolid, sdDash, sdDot, sdDashDot, sdDashDotDot, sdCustom);

  TDashArray = array of Single;

  TStrokeBrush = class(TBrush)
  public type
    TDashData = record
      DashArray: TDashArray;
      DashOffset: Single;
      constructor Create(const ADashArray: TDashArray; ADashOffset: Single);
    end;
    TDashDevice = (ddScreen, ddPrinter);
    TStdDashes = array [TDashDevice, TStrokeDash] of TDashData;
  private class var
    FStdDash: TStdDashes;
    FStdDashCreated: Boolean;
  private var
    FJoin: TStrokeJoin;
    FThickness: Single;
    FCap: TStrokeCap;
    FDash: TStrokeDash;
    FDashArray: TDashArray;
    FDashOffset: Single;
    function IsThicknessStored: Boolean;
    procedure SetCap(const Value: TStrokeCap);
    procedure SetDash(const Value: TStrokeDash);
    procedure SetJoin(const Value: TStrokeJoin);
    procedure SetThickness(const Value: Single);
    function GetDashArray: TDashArray;

    class function GetStdDash(const Device: TDashDevice;
      const Dash: TStrokeDash): TDashData; static;
  public
    constructor Create(const ADefaultKind: TBrushKind; const ADefaultColor: TAlphaColor); reintroduce;
    procedure Assign(Source: TPersistent); override;
    procedure SetCustomDash(const Dash: array of Single; Offset: Single);
    property DashArray: TDashArray read GetDashArray;
    property DashOffset: Single read FDashOffset;
    class property StdDash[const Device: TDashDevice; const Dash: TStrokeDash]: TDashData read GetStdDash;
  published
    property Thickness: Single read FThickness write SetThickness stored IsThicknessStored nodefault;
    property Cap: TStrokeCap read FCap write SetCap default TStrokeCap.scFlat;
    property Dash: TStrokeDash read FDash write SetDash default TStrokeDash.sdSolid;
    property Join: TStrokeJoin read FJoin write SetJoin default TStrokeJoin.sjMiter;
  end;

{ TFont }

  TFont = class(TPersistent)
  private
    FSize: Single;
    FFamily: TFontName;
    FStyle: TFontStyles;
    FUpdating: boolean;
    FOnChanged: TNotifyEvent;
    procedure SetFamily(const Value: TFontName);
    procedure SetSize(const Value: Single);
    procedure SetStyle(const Value: TFontStyles);
  protected
    function DefaultFamily: string; virtual;
    procedure DoChanged; virtual;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    procedure SetSettings(const AFamily: string; const ASize: Single; const AStyle: TFontStyles);
    function Equals(Obj: TObject): Boolean; override;
    function IsFamilyStored: Boolean;
    function IsSizeStored: Boolean;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  published
    property Family: TFontName read FFamily write SetFamily stored IsFamilyStored;
    property Size: Single read FSize write SetSize stored IsSizeStored nodefault;
    property Style: TFontStyles read FStyle write SetStyle default [];
  end;

  /// <summary>
  ///   This class combines some of properties that relate to the text
  /// </summary>
  TTextSettings = class (TPersistent)
  private
    FOwner: TPersistent;
    FFont: TFont;
    FUpdateCount: Integer;
    FHorzAlign: TTextAlign;
    FVertAlign: TTextAlign;
    FWordWrap: Boolean;
    FFontColor: TAlphaColor;
    FIsChanged: Boolean;
    FIsAdjustChanged: Boolean;
    FOnChanged: TNotifyEvent;
    FTrimming: TTextTrimming;
    procedure SetFontColor(const Value: TAlphaColor);
    procedure SetHorzAlign(const Value: TTextAlign);
    procedure SetVertAlign(const Value: TTextAlign);
    procedure SetWordWrap(const Value: Boolean);
    procedure SetTrimming(const Value: TTextTrimming);
  protected
    procedure DoChanged; virtual;
    procedure SetFont(const Value: TFont); virtual;
    function GetOwner: TPersistent; override;
  public
    constructor Create(const AOwner: TPersistent); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignNoStyled(const TextSettings: TTextSettings;
                     const StyledSettings: TStyledSettings);
    function Equals(Obj: TObject): Boolean; override;
    procedure Change;
    procedure BeginUpdate;
    procedure EndUpdate;
    property UpdateCount: integer read FUpdateCount;
    property IsChanged: boolean read FIsChanged write FIsChanged;
    property IsAdjustChanged: boolean read FIsAdjustChanged write FIsAdjustChanged;
    property Font: TFont read FFont write SetFont;
    property FontColor: TAlphaColor read FFontColor write SetFontColor default TAlphaColorRec.Black;
    property HorzAlign: TTextAlign read FHorzAlign write SetHorzAlign default TTextAlign.taLeading;
    property VertAlign: TTextAlign read FVertAlign write SetVertAlign default TTextAlign.taCenter;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
    property Trimming: TTextTrimming read FTrimming write SetTrimming default TTextTrimming.ttNone;
    property Owner: TPersistent read FOwner;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  end;

  ITextSettings = interface
  ['{FD99635D-D8DB-4E26-B36F-97D3AABBCCB3}']
    function GetDefaultTextSettings: TTextSettings;
    function GetTextSettings: TTextSettings;
    procedure SetTextSettings(const Value: TTextSettings);
    function GetStyledSettings: TStyledSettings;
    procedure SetStyledSettings(const Value: TStyledSettings);

    property DefaultTextSettings: TTextSettings read GetDefaultTextSettings;
    property TextSettings: TTextSettings read GetTextSettings write SetTextSettings;
    property StyledSettings: TStyledSettings read GetStyledSettings write SetStyledSettings;
  end;

{ TBitmapCodec }

  PBitmapCodecSaveParams = ^TBitmapCodecSaveParams;
  TBitmapCodecSaveParams = record
    // encode quality 0..100
    Quality: Integer;
  end;

  TCustomBitmapCodec = class abstract
  public
    class function GetImageSize(const AFileName: string): TPointF; virtual; abstract;
    class function IsValid(const AStream: TStream): Boolean; virtual; abstract;
    function LoadFromFile(const AFileName: string; const Bitmap: TBitmapSurface): Boolean; virtual; abstract;
    function LoadThumbnailFromFile(const AFileName: string; const AFitWidth, AFitHeight: Single;
      const UseEmbedded: Boolean; const Bitmap: TBitmapSurface): Boolean; virtual; abstract;
    function LoadFromStream(const AStream: TStream; const Bitmap: TBitmapSurface): Boolean; virtual; abstract;
    function SaveToFile(const AFileName: string; const Bitmap: TBitmapSurface; const SaveParams: PBitmapCodecSaveParams = nil): Boolean; virtual; abstract;
    function SaveToStream(const AStream: TStream; const Bitmap: TBitmapSurface; const Extension: string;
      const SaveParams: PBitmapCodecSaveParams = nil): Boolean; virtual; abstract;
  end;
  TCustomBitmapCodecClass = class of TCustomBitmapCodec;

{ TBitmapCodecManager }

  EBitmapCodecManagerException = class(Exception);

  TBitmapCodecManager = class sealed
  public type
    TBitmapCodecClassDescriptor = record
      Extension: string;
      Description: string;
      BitmapCodecClass: TCustomBitmapCodecClass;
      CanSave: Boolean;
    end;
  strict private type
    TBitmapCodecDescriptorField = (Extension, Description);
  strict private
    class var FBitmapCodecClassDescriptors: TList<TBitmapCodecClassDescriptor>;
    class function FindBitmapCodecDescriptor(const Name: string; const Field: TBitmapCodecDescriptorField): TBitmapCodecClassDescriptor;
  private
  public
    // Reserved for internal use only - do not call directly!
    class procedure UnInitialize;
    // Register a bitmap codec class with a file extension, description
    class procedure RegisterBitmapCodecClass(const Extension, Description: string; const CanSave: Boolean;
      const BitmapCodecClass: TCustomBitmapCodecClass); overload;
    // Helpful function
    class function GetFileTypes: string;
    class function GetFilterString: string;
    class function IsCodedExists(const AFileName: string): Boolean; overload;
    class function GetImageSize(const AFileName: string): TPointF;
    class function LoadFromFile(const AFileName: string; const Bitmap: TBitmapSurface): Boolean;
    class function LoadThumbnailFromFile(const AFileName: string; const AFitWidth, AFitHeight: Single;
      const UseEmbedded: Boolean; const Bitmap: TBitmapSurface): Boolean;
    class function LoadFromStream(const AStream: TStream; const Bitmap: TBitmapSurface): Boolean;
    class function SaveToStream(const AStream: TStream; const Bitmap: TBitmapSurface; const Extension: string;
      SaveParams: PBitmapCodecSaveParams = nil): Boolean; overload;
    class function SaveToFile(const AFileName: string; const Bitmap: TBitmapSurface; const SaveParams: PBitmapCodecSaveParams = nil): Boolean;
  end;

{ TBitmap }

  IBitmapObject = interface(IFreeNotificationBehavior)
    ['{5C17D001-47C1-462F-856D-8358B7B2C842}']
    function GetBitmap: TBitmap;
    property Bitmap: TBitmap read GetBitmap;
  end;

  TBitmapHandle = THandle;

  TBitmapData = record
  private
    FPixelFormat: TPixelFormat;
    FWidth: Integer;
    FHeight: Integer;
    function GetBytesPerPixel: Integer;
    function GetBytesPerLine: Integer;
  public
    Data: Pointer;
    Pitch: Integer;
    constructor Create(const AWidth, AHeight: Integer; const APixelFormat: TPixelFormat);
    function GetPixel(const X, Y: Integer): TAlphaColor;
    procedure SetPixel(const X, Y: Integer; const AColor: TAlphaColor);
    procedure Copy(const Source: TBitmapData);
    // Access to scanline in PixelFormat
    function GetScanline(const I: Integer): Pointer;
    function GetPixelAddr(const I, J: Integer): Pointer;
    property PixelFormat: TPixelFormat read FPixelFormat;
    property BytesPerPixel: Integer read GetBytesPerPixel;
    property BytesPerLine: Integer read GetBytesPerLine;
    property Width: Integer read FWidth;
    property Height: Integer read FHeight;
  end;

  TMapAccess = (maRead, maWrite, maReadWrite);

  IBitmapAccess = interface
  ['{E6A4D7BB-B9C3-4D52-A4E3-B2BE974F9A93}']
    procedure SetHandle(const Handle: TBitmapHandle);
    procedure SetPixelFormat(const PixelFormat: TPixelFormat);
    procedure SetBitmapScale(const Scale: Single);
    property Handle: TBitmapHandle write SetHandle;
    property PixelFormat: TPixelFormat write SetPixelFormat;
    property BitmapScale: Single write SetBitmapScale;
  end;

  IBitmapLink = interface
  ['{95910ECE-2F2F-4BB3-A79C-0139E743180A}']
    procedure SetResourceBitmap(const ABitmap: TBitmap);
  end;

  TBitmap = class(TInterfacedPersistent, IStreamPersist, IFreeNotification,
    IBitmapAccess, IBitmapLink)
  private
    FNotifyList: TList<Pointer>;
    FHeight: Integer;
    FWidth: Integer;
    FOnChange: TNotifyEvent;
    FResource: TObject;
    FStyleLookup: string;
    FHandle: TBitmapHandle;
    FCanvas: TCanvas;
    FMapped: Boolean;
    FMapAccess: TMapAccess;
    FPixelFormat: TPixelFormat;
    FBitmapScale: Single;
    FCanvasClass: TCanvasClass;
    function GetCanvasClass: TCanvasClass;
    function GetCanvas: TCanvas;
    function GetStyleLookup: string;
    procedure SetStyleLookup(const Value: string);
    function GetBitmap: TBitmap;
    procedure BitmapChanged;
    { IBitmapLink }
    procedure SetResourceBitmap(const ABitmap: TBitmap);
    { IBitmapAccess }
    procedure SetHandle(const Handle: TBitmapHandle);
    procedure SetPixelFormat(const PixelFormat: TPixelFormat);
    function GetHandle: TBitmapHandle;
    function GetPixelFormat: TPixelFormat;
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
  protected
    { internal }
    FTexture: TObject;
    FTextureNeedUpdate: Boolean;
    procedure Recreate;
    procedure SetBitmapScale(const Scale: Single);
    { vcl }
    procedure AssignTo(Dest: TPersistent); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadBitmap(Stream: TStream);
    procedure WriteBitmap(Stream: TStream);
    { IFreeNotification }
    procedure FreeNotification(AObject: TObject); virtual;
  public
    constructor Create(const AWidth, AHeight: Integer); virtual;
    constructor CreateFromStream(const AStream: TStream); virtual;
    constructor CreateFromFile(const AFileName: string); virtual;
    constructor CreateFromBitmapAndMask(const Bitmap, Mask: TBitmap);
    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;
    procedure SetSize(const AWidth, AHeight: Integer);
    procedure Clear(const AColor: TAlphaColor); virtual;
    procedure ClearRect(const ARect: TRectF; const AColor: TAlphaColor = 0);
    // Size of source and destination bitmap must be equal
    procedure CopyFromBitmap(const Source: TBitmap); overload;
    procedure CopyFromBitmap(const Source: TBitmap; SrcRect: TRect; DstX, DstY: Integer); overload;
    function IsEmpty: Boolean;
    function HandleAllocated: Boolean;
    { FreeNotify }
    procedure AddFreeNotify(const AObject: IFreeNotification);
    procedure RemoveFreeNotify(const AObject: IFreeNotification);
    { Manipulation }
    procedure Rotate(const Angle: Single);
    procedure Resize(const AWidth, AHeight: Integer);
    procedure FlipHorizontal;
    procedure FlipVertical;
    procedure InvertAlpha;
    procedure ReplaceOpaqueColor(const Color: TAlphaColor);
    { Mask }
    function CreateMask: PByteArray;
    procedure ApplyMask(const Mask: PByteArray; const DstX: Integer = 0; const DstY: Integer = 0);
    { Thumb }
    function CreateThumbnail(const Width, Height: Integer): TBitmap;
    { I/O }
    procedure LoadFromFile(const AFileName: string; const Rotate: Single = 0);
    procedure LoadThumbnailFromFile(const AFileName: string; const AFitWidth, AFitHeight: Single;
      const UseEmbedded: Boolean = True);
    procedure SaveToFile(const AFileName: string; const SaveParams: PBitmapCodecSaveParams = nil);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);
    { Painting }
    property Canvas: TCanvas read GetCanvas;
    { Direct access  }
    function Map(const Access: TMapAccess; var Data: TBitmapData): Boolean;
    procedure Unmap(var Data: TBitmapData);
    { Properties }
    property CanvasClass: TCanvasClass read GetCanvasClass;
    property Handle: TBitmapHandle read GetHandle;
    property PixelFormat: TPixelFormat read GetPixelFormat;
    property BitmapScale: Single read FBitmapScale; // hi resolution mode
    property Width: Integer read FWidth write SetWidth;
    property Height: Integer read FHeight write SetHeight;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    { Internal usage only }
    property ResourceBitmap: TBitmap read GetBitmap; // use to resource link
  published
    property StyleLookup: string read GetStyleLookup write SetStyleLookup;
  end;

{ TPathData }

  TPathData = class;

  IPathObject = interface(IFreeNotificationBehavior)
    ['{8C014863-4F69-48F2-9CF7-E336BFD3F06B}']
    function GetPath: TPathData;
    property Path: TPathData read GetPath;
  end;

  TPathPointKind = (ppMoveTo, ppLineTo, ppCurveTo, ppClose);

  TPathPoint = packed record
    Kind: TPathPointKind;
    Point: TPointF;
  end;

  TPathObject = class;

  TPathData = class(TInterfacedPersistent, IFreeNotification)
  private
    FOnChanged: TNotifyEvent;
    FStyleResource: TObject;
    FStyleLookup: string;
    FStartPoint: TPointF;
    FPathData: array of TPathPoint;
    FRecalcBounds: Boolean;
    FBounds: TRectF;
    function GetPathString: string;
    procedure SetPathString(const Value: string);
    procedure AddArcSvgPart(const Center, Radius: TPointF; StartAngle, SweepAngle: Single);
    procedure AddArcSvg(const P1, Radius: TPointF; Angle: Single; const LargeFlag, SweepFlag: Boolean; const P2: TPointF);
    function GetStyleLookup: string;
    procedure SetStyleLookup(const Value: string);
    function GetPath: TPathData;
    function GetCount: Integer; inline;
    function GetPoint(AIndex: Integer): TPathPoint; inline;
    function GetPointFromStr(const S: string; var Pos: Integer): TPointF;
    function GetNum(const S: string; var Pos: Integer): string;
    function GetTok(const S: string; var Pos: Integer): string;
  protected
    { rtl }
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadPath(Stream: TStream);
    procedure WritePath(Stream: TStream);
    { IFreeNotification }
    procedure FreeNotification(AObject: TObject);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    { creation }
    function LastPoint: TPointF;
    procedure MoveTo(const P: TPointF);
    procedure MoveToRel(const P: TPointF);
    procedure LineTo(const P: TPointF);
    procedure LineToRel(const P: TPointF);
    procedure HLineTo(const X: Single);
    procedure HLineToRel(const X: Single);
    procedure VLineTo(const Y: Single);
    procedure VLineToRel(const Y: Single);
    procedure CurveTo(const ControlPoint1, ControlPoint2, EndPoint: TPointF);
    procedure CurveToRel(const ControlPoint1, ControlPoint2, EndPoint: TPointF);
    procedure SmoothCurveTo(const ControlPoint2, EndPoint: TPointF);
    procedure SmoothCurveToRel(const ControlPoint2, EndPoint: TPointF);
    procedure QuadCurveTo(const ControlPoint, EndPoint: TPointF);
    procedure ClosePath;
    { shapes }
    procedure AddEllipse(const ARect: TRectF);
    procedure AddRectangle(const ARect: TRectF; const XRadius, YRadius: Single; const ACorners: TCorners;
      const ACornerType: TCornerType = TCornerType.ctRound);
    procedure AddArc(const Center, Radius: TPointF; StartAngle, SweepAngle: Single);
    { modification }
    procedure Clear;
    procedure Flatten(const Flatness: Single = 0.25);
    procedure Scale(const scaleX, scaleY: Single);
    procedure Translate(const dX, dY: Single);
    procedure FitToRect(const ARect: TRectF);
    procedure ApplyMatrix(const M: TMatrix);
    { params }
    function GetBounds: TRectF;
    { convert }
    function FlattenToPolygon(var Polygon: TPolygon; const Flatness: Single = 0.25): TPointF;
    function IsEmpty: Boolean;
    { access }
    property Count: Integer read GetCount;
    property Points[AIndex: Integer]: TPathPoint read GetPoint; default;
    { resoruces }
    property ResourcePath: TPathData read GetPath;
  published
    property Data: string read GetPathString write SetPathString stored False;
    { This property allow to link path with PathObject by name. }
    property StyleLookup: string read GetStyleLookup write SetStyleLookup;
  end;

{ TCanvasSaveState }

  TCanvasSaveState = class(TPersistent)
  private
  protected
    FAssigned: Boolean;
    FFill: TBrush;
    FStroke: TStrokeBrush;
    FDash: TDashArray;
    FDashOffset: Single;
    FFont: TFont;
    FMatrix: TMatrix;
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Assigned: Boolean read FAssigned;
  end;

  TRegion = array of TRectF;
  TRegionArray = array of TRegion;

{ TCanvas }

  ECanvasException = class(Exception);

  TFillTextFlag = (ftRightToLeft);

  TFillTextFlags = set of TFillTextFlag;

  TAbstractPrinter = class(TPersistent);

  PClipRects = ^TClipRects;
  TClipRects = array of TRectF;

  ICanvasObject = interface
  ['{61166E3B-9BC3-41E3-9D9A-5C6AB6460950}']
    function GetCanvas: TCanvas;
    property Canvas: TCanvas read GetCanvas;
  end;

  TCanvasStyle = (NeedGPUSurface, SupportClipRects);
  TCanvasStyles = set of TCanvasStyle;

  TCanvasQuality = (ccSystemDefault, ccHighPerformance, ccHighQuality);

  TCanvas = class abstract(TInterfacedPersistent)
  private
    FBeginSceneCount: Integer;
    FFill: TBrush;
    FStroke: TStrokeBrush;
    FParent: TWindowHandle;
    [Weak] FBitmap: TBitmap;
    FScale: Single;
    FQuality: TCanvasQuality;
    procedure SetFill(const Value: TBrush);
    { deprecated }
    function GetStrokeThickness: Single;
    procedure SetStrokeDash(const Value: TStrokeDash);
    procedure SetStrokeCap(const Value: TStrokeCap);
    procedure SetStrokeJoin(const Value: TStrokeJoin);
    procedure SetStrokeThickness(const Value: Single);
  protected type
    TMatrixMeaning = (mmUnknown, mmIdentity, mmTranslate);
  private
    FMatrixMeaning: TMatrixMeaning;
    FMatrixTranslate: TPointF;
    FBlending: Boolean;
    procedure SetBlending(const Value: Boolean);
  type
    TCanvasSaveStateList = TObjectList<TCanvasSaveState>;
  protected
    FClippingChangeCount: Integer;
    FSavingStateCount: Integer;
    FWidth, FHeight: Integer;
    FMatrix: TMatrix;
    FFont: TFont;
    FCanvasSaveData: TCanvasSaveStateList;
    FPrinter: TAbstractPrinter;
    procedure FontChanged(Sender: TObject); virtual;
    { Window }
    function CreateSaveState: TCanvasSaveState; virtual;
    procedure Initialize;
    procedure UnInitialize;
    function GetCanvasScale: Single; virtual;
    { scene }
    function DoBeginScene(const AClipRects: PClipRects = nil; AContextHandle: THandle = 0): Boolean; virtual;
    procedure DoEndScene; virtual;
    { constructors }
    constructor CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
      const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault); virtual;
    constructor CreateFromBitmap(const ABitmap: TBitmap; const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault); virtual;
    constructor CreateFromPrinter(const APrinter: TAbstractPrinter); virtual;
    { bitmap }
    class procedure DoInitializeBitmap(const Bitmap: TBitmap); virtual; abstract;
    class procedure DoFinalizeBitmap(const Bitmap: TBitmap); virtual; abstract;
    class function DoMapBitmap(const Bitmap: TBitmap; const Access: TMapAccess; var Data: TBitmapData): Boolean; virtual; abstract;
    class procedure DoUnmapBitmap(const Bitmap: TBitmap; var Data: TBitmapData); virtual; abstract;
    class procedure DoCopyBitmap(const Source, Dest: TBitmap); virtual;
    { states }
    procedure DoBlendingChanged; virtual;
    { drawing }
    procedure DoFillRect(const ARect: TRectF; const AOpacity: Single; const ABrush: TBrush); virtual; abstract;
    procedure DoFillRoundRect(const ARect: TRectF; const XRadius, YRadius: Single; const ACorners: TCorners;
      const AOpacity: Single; const ABrush: TBrush; const ACornerType: TCornerType = TCornerType.ctRound); virtual;
    procedure DoFillPath(const APath: TPathData; const AOpacity: Single; const ABrush: TBrush); virtual; abstract;
    procedure DoFillEllipse(const ARect: TRectF; const AOpacity: Single; const ABrush: TBrush); virtual; abstract;
    procedure DoDrawBitmap(const ABitmap: TBitmap; const SrcRect, DstRect: TRectF; const AOpacity: Single; const HighSpeed: Boolean); virtual; abstract;
    procedure DoDrawLine(const APt1, APt2: TPointF; const AOpacity: Single; const ABrush: TStrokeBrush); virtual; abstract;
    procedure DoDrawRect(const ARect: TRectF; const AOpacity: Single; const ABrush: TStrokeBrush); virtual; abstract;
    procedure DoDrawPath(const APath: TPathData; const AOpacity: Single; const ABrush: TStrokeBrush); virtual; abstract;
    procedure DoDrawEllipse(const ARect: TRectF; const AOpacity: Single; const ABrush: TStrokeBrush); virtual; abstract;
    property Parent: TWindowHandle read FParent;
  protected
    function TransformPoint(const P: TPointF): TPointF; inline;
    function TransformRect(const Rect: TRectF): TRectF; inline;
    property MatrixMeaning: TMatrixMeaning read FMatrixMeaning;
    property MatrixTranslate: TPointF read FMatrixTranslate;
  public
    destructor Destroy; override;
    { style }
    class function GetCanvasStyle: TCanvasStyles; virtual;
    { scene }
    procedure SetSize(const AWidth, AHeight: Integer); virtual;
    function BeginScene(AClipRects: PClipRects = nil; AContextHandle: THandle = 0): Boolean;
    procedure EndScene;
    property BeginSceneCount: integer read FBeginSceneCount;
    { buffer }
    procedure Clear(const Color: TAlphaColor); virtual; abstract;
    procedure ClearRect(const ARect: TRectF; const AColor: TAlphaColor = 0); virtual; abstract;
    { matrix }
    procedure SetMatrix(const M: TMatrix); virtual;
    procedure MultiplyMatrix(const M: TMatrix);
    { state }
    function SaveState: TCanvasSaveState;
    procedure RestoreState(const State: TCanvasSaveState);
    { bitmap }
    class procedure InitializeBitmap(const Bitmap: TBitmap);
    class procedure FinalizeBitmap(const Bitmap: TBitmap);
    class function MapBitmap(const Bitmap: TBitmap; const Access: TMapAccess; var Data: TBitmapData): Boolean;
    class procedure UnmapBitmap(const Bitmap: TBitmap; var Data: TBitmapData);
    class procedure CopyBitmap(const Source, Dest: TBitmap);
    { clipping }
    procedure IntersectClipRect(const ARect: TRectF); virtual; abstract;
    procedure ExcludeClipRect(const ARect: TRectF); virtual; abstract;
    { drawing }
    procedure FillArc(const Center, Radius: TPointF; StartAngle, SweepAngle: Single; const AOpacity: Single); overload;
    procedure FillArc(const Center, Radius: TPointF; StartAngle, SweepAngle: Single;
      const AOpacity: Single; const ABrush: TBrush); overload;
    procedure FillRect(const ARect: TRectF; const XRadius, YRadius: Single; const ACorners: TCorners;
      const AOpacity: Single; const ACornerType: TCornerType = TCornerType.ctRound); overload;
    procedure FillRect(const ARect: TRectF; const XRadius, YRadius: Single; const ACorners: TCorners;
      const AOpacity: Single; const ABrush: TBrush; const ACornerType: TCornerType = TCornerType.ctRound); overload;
    procedure FillPath(const APath: TPathData; const AOpacity: Single); overload;
    procedure FillPath(const APath: TPathData; const AOpacity: Single; const ABrush: TBrush); overload;
    procedure FillEllipse(const ARect: TRectF; const AOpacity: Single); overload;
    procedure FillEllipse(const ARect: TRectF; const AOpacity: Single; const ABrush: TBrush); overload;
    procedure DrawBitmap(const ABitmap: TBitmap; const SrcRect, DstRect: TRectF; const AOpacity: Single;
      const HighSpeed: Boolean = False);
    procedure DrawLine(const APt1, APt2: TPointF; const AOpacity: Single); overload;
    procedure DrawLine(const APt1, APt2: TPointF; const AOpacity: Single; const ABrush: TStrokeBrush); overload;
    procedure DrawRect(const ARect: TRectF; const XRadius, YRadius: Single; const ACorners: TCorners;
      const AOpacity: Single; const ACornerType: TCornerType = TCornerType.ctRound); overload;
    procedure DrawRect(const ARect: TRectF; const XRadius, YRadius: Single; const ACorners: TCorners;
      const AOpacity: Single; const ABrush: TStrokeBrush; const ACornerType: TCornerType = TCornerType.ctRound); overload;
    procedure DrawPath(const APath: TPathData; const AOpacity: Single); overload;
    procedure DrawPath(const APath: TPathData; const AOpacity: Single; const ABrush: TStrokeBrush); overload;
    procedure DrawEllipse(const ARect: TRectF; const AOpacity: Single); overload;
    procedure DrawEllipse(const ARect: TRectF; const AOpacity: Single; const ABrush: TStrokeBrush); overload;
    procedure DrawArc(const Center, Radius: TPointF; StartAngle, SweepAngle: Single; const AOpacity: Single); overload;
    procedure DrawArc(const Center, Radius: TPointF; StartAngle, SweepAngle: Single; const AOpacity: Single; const ABrush: TStrokeBrush); overload;
    { mesauring }
    function PtInPath(const APoint: TPointF; const APath: TPathData): Boolean; virtual; abstract;
    { helpers }
    procedure DrawRectSides(const ARect: TRectF; const XRadius, YRadius: Single; const ACorners: TCorners;
      const AOpacity: Single; const ASides: TSides; const ACornerType: TCornerType = TCornerType.ctRound); overload;
    procedure DrawRectSides(const ARect: TRectF; const XRadius, YRadius: Single; const ACorners: TCorners;
      const AOpacity: Single; const ASides: TSides; const ABrush: TStrokeBrush; const ACornerType: TCornerType = TCornerType.ctRound); overload;
    procedure DrawDashRect(const ARect: TRectF; const XRadius, YRadius: Single; const ACorners: TCorners;
      const AOpacity: Single; const AColor: TAlphaColor);
    { linear polygon }
    procedure FillPolygon(const Points: TPolygon; const AOpacity: Single); virtual;
    procedure DrawPolygon(const Points: TPolygon; const AOpacity: Single); virtual;
    { text }
    function LoadFontFromStream(const AStream: TStream): Boolean; virtual;
    { deprecated, use TTextLayout }
    procedure FillText(const ARect: TRectF; const AText: string; const WordWrap: Boolean; const AOpacity: Single;
      const Flags: TFillTextFlags; const ATextAlign: TTextAlign; const AVTextAlign: TTextAlign = TTextAlign.taCenter); virtual;// deprecated 'use TTextLayout';
    procedure MeasureText(var ARect: TRectF; const AText: string; const WordWrap: Boolean; const Flags: TFillTextFlags;
      const ATextAlign: TTextAlign; const AVTextAlign: TTextAlign = TTextAlign.taCenter); virtual;// deprecated 'use TTextLayout';
    procedure MeasureLines(const ALines: TLineMetricInfo; const ARect: TRectF; const AText: string; const WordWrap: Boolean; const Flags: TFillTextFlags;
      const ATextAlign: TTextAlign; const AVTextAlign: TTextAlign = TTextAlign.taCenter); virtual;
    function TextToPath(Path: TPathData; const ARect: TRectF; const AText: string; const WordWrap: Boolean;
      const ATextAlign: TTextAlign; const AVTextAlign: TTextAlign = TTextAlign.taCenter): Boolean; virtual;// deprecated 'use TTextLayout';
    function TextWidth(const AText: string): Single;// deprecated 'use TTextLayout';
    function TextHeight(const AText: string): Single;// deprecated 'use TTextLayout';
    { deprecated - moved to TStokeBrush }
    procedure SetCustomDash(const Dash: array of Single; Offset: Single);
    property StrokeThickness: Single read GetStrokeThickness write SetStrokeThickness;
    property StrokeCap: TStrokeCap write SetStrokeCap;
    property StrokeDash: TStrokeDash write SetStrokeDash;
    property StrokeJoin: TStrokeJoin write SetStrokeJoin;
    { properties }
    property Blending: Boolean read FBlending write SetBlending;
    property Quality: TCanvasQuality read FQuality;
    property Stroke: TStrokeBrush read FStroke;
    property Fill: TBrush read FFill write SetFill;
    property Font: TFont read FFont;
    { usage in PaintTo }
    property Matrix: TMatrix read FMatrix;
    { read only }
    property Width: Integer read FWidth;
    property Height: Integer read FHeight;
    property Bitmap: TBitmap read FBitmap;
    property Scale: Single read FScale;
    { statistics }
    property ClippingChangeCount: Integer read FClippingChangeCount;
    property SavingStateCount: Integer read FSavingStateCount;
  end;

  ECanvasManagerException = class(Exception);

  TCanvasDestroyMessage = class(TMessage);

  TCanvasManager = class sealed
  private type
    TCanvasClassRec = record
      CanvasClass: TCanvasClass;
      Default: Boolean;
      PrinterCanvas: Boolean;
    end;
  strict private
    class var FCanvasList: TList<TCanvasClassRec>;
    class var FDefaultCanvasClass: TCanvasClass;
    class var FDefaultPrinterCanvasClass: TCanvasClass;
    class var FMeasureBitmap: TBitmap;
    class var FEnableSoftwareCanvas: Boolean;
  private
    class function GetDefaultCanvas: TCanvasClass; static;
    class function GetMeasureCanvas: TCanvas; static;
    class function GetDefaultPrinterCanvas: TCanvasClass; static;
  public
    // Reserved for internal use only - do not call directly!
    class procedure UnInitialize;
    // Register a rendering Canvas class
    class procedure RegisterCanvas(const CanvasClass: TCanvasClass; const ADefault: Boolean; const APrinterCanvas: Boolean);
    // Return default Canvas
    class property DefaultCanvas: TCanvasClass read GetDefaultCanvas;
    // Return default Canvas
    class property DefaultPrinterCanvas: TCanvasClass read GetDefaultPrinterCanvas;
    // Return canvas instance used for text measuring for example
    class property MeasureCanvas: TCanvas read GetMeasureCanvas;
    // Creation helper
    class function CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
      const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault): TCanvas;
    class function CreateFromBitmap(const ABitmap: TBitmap;
      const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault): TCanvas;
    class function CreateFromPrinter(const APrinter: TAbstractPrinter): TCanvas;
    class procedure RecreateFromPrinter(const Canvas: TCanvas; const APrinter: TAbstractPrinter);
    class procedure EnableSoftwareCanvas(const Enable: Boolean);
  end;

  TPrinterCanvas = class(TCanvas)
  end;

  TPrinterCanvasClass = class of TPrinterCanvas;

  TMouseEvent = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single) of object;
  TMouseMoveEvent = procedure(Sender: TObject; Shift: TShiftState; X, Y: Single) of object;
  TMouseWheelEvent = procedure(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean) of object;
  TKeyEvent = procedure(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState) of object;
  TProcessTickEvent = procedure(Sender: TObject; time, deltaTime: Single) of object;
  TVirtualKeyboardEvent = procedure(Sender: TObject; KeyboardVisible: Boolean; const Bounds : TRect) of object;

  TAnimationType = (atIn, atOut, atInOut);

  TInterpolationType = (itLinear, itQuadratic, itCubic, itQuartic,
    itQuintic, itSinusoidal, itExponential, itCircular,
    itElastic, itBack, itBounce);

  TFmxObjectSortCompare = reference to function (Left, Right: TFmxObject): Integer;

  TFmxObjectList = TList<TFmxObject>;

  TFmxChildrenList = class(TEnumerable<TFmxObject>)
  strict private
    [weak] FChildren: TFmxObjectList;
  protected
    function DoGetEnumerator: TEnumerator<TFmxObject>; override;
    function GetChildCount: Integer; virtual;
    function GetChild(AIndex: Integer): TFmxObject; virtual;
  public
    constructor Create(const AChildren: TFmxObjectList);
    destructor Destroy; override;
    property Count: Integer read GetChildCount;
    function IndexOf(const Obj: TFmxObject): Integer; virtual;
    property Items[Index: Integer]: TFmxObject read GetChild; default;
  end;

{ TFmxObject }


  TFmxObject = class(TComponent, IFreeNotification)
  strict private
    FChildren: TFmxObjectList;
    FChildrenList: TFmxChildrenList;
    FStyleObjectsDict: TDictionary<string, TFmxObject>;
  private
    FStored: Boolean;
    [Weak] FTagObject: TObject;
    FTagFloat: Single;
    FTagString: string;
    FNotifyList: TList<Pointer>;
    FIndex: Integer;
    FActionClient: boolean;
    FActionLink: TActionLink;
    FCallingFreeNotify: Boolean;
    FTouchManager: TTouchManager;
    FOnGesture: TGestureEvent;
    FReleased: Boolean;
    procedure SetStyleName(const Value: string);
    procedure SetStored(const Value: Boolean);
    function GetChildrenCount: Integer; inline;
    function GetIndex: Integer;
    function GetTouchManager: TTouchManager;
    procedure FixupTabList;
    procedure SetIndex(Idx: Integer);
    { Actions }
    function GetAction: TBasicAction;
    procedure SetAction(const Value: TBasicAction);
    procedure SetActionClient(const Value: boolean);
    procedure SetTouchManager(const Value: TTouchManager);
    class constructor Create;
    class destructor Destroy;
  protected
    [Weak] FRoot: IRoot;
    FStyleName: string;
    [Weak] FParent: TFmxObject;
    FTabList: IInterfaceList;
    function CreateChildrenList(const Children: TFmxObjectList): TFmxChildrenList; virtual;
    procedure ResetChildrenIndices;
    function GetBackIndex: Integer; virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure IgnoreBindingName(Reader: TReader);
    { RTL }
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure SetParentComponent(Value: TComponent); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { Actions }
    function GetActionLinkClass: TActionLinkClass; virtual;
    procedure DoGesture(const EventInfo: TGestureEventInfo; var Handled: Boolean); virtual;
    procedure InitiateAction; virtual;
    procedure DoActionChange(Sender: TObject); virtual;
    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); virtual;
    procedure DoActionClientChanged; virtual;
    property ActionLink: TActionLink read FActionLink;
    property Action: TBasicAction read GetAction write SetAction;
    procedure AddToTabList(const AObject: TFmxObject); virtual;
    procedure RemoveFromTabList(const AObject: TFmxObject); virtual;
    procedure DoInventory(Dict: TDictionary<string, TFmxObject>; const Prefix: string);
  public
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
  protected
    { parent }
    procedure SetParent(const Value: TFmxObject); virtual;
    procedure ChangeParent; virtual;
    procedure ChangeOrder; virtual;
    procedure ChangeChildren; virtual;
    { children }
    procedure DoAddObject(const AObject: TFmxObject); virtual;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); virtual;
    procedure DoRemoveObject(const AObject: TFmxObject); virtual;
    procedure DoDeleteChildren; virtual;
    function SearchInto: Boolean; virtual;
    { ani }
    procedure DoAniFinished(Sender: TObject);
    procedure DoAniProcess(Sender: TObject);
    { IFreeNotification }
    procedure FreeNotification(AObject: TObject); virtual;
    { design }
    function SupportsPlatformService(const AServiceGUID: TGUID; out AService: IInterface): Boolean; virtual;
    { Data }
    function GetData: TValue; virtual;
    procedure SetData(const Value: TValue); virtual;
    procedure IgnoreIntegerValue(Reader: TReader);
    procedure IgnoreFloatValue(Reader: TReader);
    procedure IgnoreBooleanValue(Reader: TReader);
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Release; virtual;
    function Released: Boolean;
    { check for support interface }
    function IsIControl: Boolean; virtual;
    function AsIControl: IControl; virtual;
    procedure SetRoot(ARoot: IRoot);
    { design }
    procedure SetDesign(Value: Boolean; SetChildren: Boolean = True);
    function ItemClass: string; virtual;
    { clone }
    function Clone(const AOwner: TComponent): TFmxObject;
    { childs }
    procedure AddObject(const AObject: TFmxObject);
    procedure InsertObject(Index: Integer; const AObject: TFmxObject);
    procedure RemoveObject(const AObject: TFmxObject); overload;
    procedure RemoveObject(Index: Integer); overload;
    function ContainsObject(AObject: TFmxObject): Boolean; virtual;
    procedure Exchange(const AObject1, AObject2: TFmxObject); virtual;
    procedure DeleteChildren;
    function IsChild(AObject: TFmxObject): Boolean; virtual;
    procedure BringToFront; virtual;
    procedure SendToBack; virtual;
    procedure AddObjectsToList(const AList: TFmxObjectList);
    procedure Sort(Compare: TFmxObjectSortCompare); virtual;
    { notify }
    procedure AddFreeNotify(const AObject: IFreeNotification);
    procedure RemoveFreeNotify(const AObject: IFreeNotification);
    { tab }
    procedure GetTabOrderList(const List: TInterfaceList; AChildren: Boolean); virtual;
    { resource }
    function FindStyleResource(const AStyleLookup: string; const Clone: Boolean = False): TFmxObject; virtual;
    { animations }
    procedure StartAnimation(const AName: string); virtual;
    procedure StopAnimation(const AName: string); virtual;
    procedure StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string); virtual;
    procedure StartTriggerAnimationWait(const AInstance: TFmxObject; const ATrigger: string); virtual;
    procedure StopTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string); virtual;
    procedure ApplyTriggerEffect(const AInstance: TFmxObject; const ATrigger: string); virtual;
    { animation property }
    procedure AnimateFloat(const APropertyName: string; const NewValue: Single; Duration: Single = 0.2;
      AType: TAnimationType = TAnimationType.atIn;
      AInterpolation: TInterpolationType = TInterpolationType.itLinear);
    procedure AnimateFloatDelay(const APropertyName: string; const NewValue: Single; Duration: Single = 0.2;
      Delay: Single = 0.0; AType: TAnimationType = TAnimationType.atIn;
      AInterpolation: TInterpolationType = TInterpolationType.itLinear);
    procedure AnimateFloatWait(const APropertyName: string; const NewValue: Single; Duration: Single = 0.2;
      AType: TAnimationType = TAnimationType.atIn;
      AInterpolation: TInterpolationType = TInterpolationType.itLinear);
    procedure AnimateInt(const APropertyName: string; const NewValue: Integer; Duration: Single = 0.2;
      AType: TAnimationType = TAnimationType.atIn;
      AInterpolation: TInterpolationType = TInterpolationType.itLinear);
    procedure AnimateIntWait(const APropertyName: string; const NewValue: Integer; Duration: Single = 0.2;
      AType: TAnimationType = TAnimationType.atIn;
      AInterpolation: TInterpolationType = TInterpolationType.itLinear);
    procedure AnimateColor(const APropertyName: string; NewValue: TAlphaColor; Duration: Single = 0.2;
      AType: TAnimationType = TAnimationType.atIn;
      AInterpolation: TInterpolationType = TInterpolationType.itLinear);
    procedure StopPropertyAnimation(const APropertyName: string);
    procedure CMGesture(var EventInfo: TGestureEventInfo); virtual;
    { }
    property Root: IRoot read FRoot;
    property Stored: Boolean read FStored write SetStored;
    { }
    property TagObject: TObject read FTagObject write FTagObject;
    property TagFloat: Single read FTagFloat write FTagFloat;
    property TagString: string read FTagString write FTagString;
    { children }
    property ChildrenCount: Integer read GetChildrenCount;
    property Children: TFmxChildrenList read FChildrenList;
    property Data: TValue read GetData write SetData;
    property Parent: TFmxObject read FParent write SetParent;
    property Index: Integer read GetIndex write SetIndex;
    property ActionClient: boolean read FActionClient;
    property Touch: TTouchManager read GetTouchManager write SetTouchManager;
    property OnGesture: TGestureEvent read FOnGesture write FOnGesture;
  published
    property StyleName: string read FStyleName write SetStyleName;
  end;

{ TCustomPopupMenu }

  TCustomPopupMenu = class(TFmxObject)
  protected
    FPopupComponent: TComponent;
  public
    procedure Popup(X, Y: Single); virtual; abstract;
    property PopupComponent: TComponent read FPopupComponent write FPopupComponent;
  end;

  TStandardGesture = (
    sgLeft            = sgiLeft,
    sgRight           = sgiRight,
    sgUp              = sgiUp,
    sgDown            = sgiDown,
    sgUpLeft          = sgiUpLeft,
    sgUpRight         = sgiUpRight,
    sgDownLeft        = sgiDownLeft,
    sgDownRight       = sgiDownRight,
    sgLeftUp          = sgiLeftUp,
    sgLeftDown        = sgiLeftDown,
    sgRightUp         = sgiRightUp,
    sgRightDown       = sgiRightDown,
    sgUpDown          = sgiUpDown,
    sgDownUp          = sgiDownUp,
    sgLeftRight       = sgiLeftRight,
    sgRightLeft       = sgiRightLeft,
    sgUpLeftLong      = sgiUpLeftLong,
    sgUpRightLong     = sgiUpRightLong,
    sgDownLeftLong    = sgiDownLeftLong,
    sgDownRightLong   = sgiDownRightLong,
    sgScratchout      = sgiScratchout,
    sgTriangle        = sgiTriangle,
    sgSquare          = sgiSquare,
    sgCheck           = sgiCheck,
    sgCurlicue        = sgiCurlicue,
    sgDoubleCurlicue  = sgiDoubleCurlicue,
    sgCircle          = sgiCircle,
    sgDoubleCircle    = sgiDoubleCircle,
    sgSemiCircleLeft  = sgiSemiCircleLeft,
    sgSemiCircleRight = sgiSemiCircleRight,
    sgChevronUp       = sgiChevronUp,
    sgChevronDown     = sgiChevronDown,
    sgChevronLeft     = sgiChevronLeft,
    sgChevronRight    = sgiChevronRight
);

  TStandardGestures = set of TStandardGesture;

  TInteractiveGesture = (igZoom, igPan, igRotate, igTwoFingerTap, igPressAndTap, igDoubleTap, igLongTap);
  TInteractiveGestures = set of TInteractiveGesture;

  TCustomGestureManager = class;
  TCustomGestureCollection = class;
  TCustomGestureCollectionItem = class;

  TGestureType = (gtStandard, gtRecorded, gtRegistered, gtNone);
  TGestureTypes = set of TGestureType;

  TGestureOption = (goUniDirectional, goSkew, goEndpoint, goRotate);
  TGestureOptions = set of TGestureOption;

  TGestureArray = array of TCustomGestureCollectionItem;
  TGesturePointArray = array of TPointF;

  TCustomGestureCollectionItem = class(TCollectionItem)
  strict protected
    function GetAction: TCustomAction; virtual; abstract;
    function GetDeviation: Integer; virtual; abstract;
    function GetErrorMargin: Integer; virtual; abstract;
    function GetGestureID: TGestureID; virtual; abstract;
    function GetGestureType: TGestureType; virtual; abstract;
    function GetName: string; virtual; abstract;
    function GetOptions: TGestureOptions; virtual; abstract;
    function GetPoints: TGesturePointArray; virtual; abstract;
    procedure SetAction(const Value: TCustomAction); virtual; abstract;
    procedure SetDeviation(const Value: Integer); virtual; abstract;
    procedure SetErrorMargin(const Value: Integer); virtual; abstract;
    procedure SetGestureID(const Value: TGestureID); virtual; abstract;
    procedure SetName(const Value: string); virtual; abstract;
    procedure SetOptions(const Value: TGestureOptions); virtual; abstract;
    procedure SetPoints(const Value: TGesturePointArray); virtual; abstract;
  public
    property Deviation: Integer read GetDeviation write SetDeviation default 20;
    property ErrorMargin: Integer read GetErrorMargin write SetErrorMargin default 20;
    property GestureID: TGestureID read GetGestureID write SetGestureID;
    property GestureType: TGestureType read GetGestureType;
    property Name: string read GetName write SetName;
    property Points: TGesturePointArray read GetPoints write SetPoints;
    property Action: TCustomAction read GetAction write SetAction;
    property Options: TGestureOptions read GetOptions write SetOptions default [TGestureOption.goUniDirectional, TGestureOption.goRotate];
  end;

   TCustomGestureCollection = class(TCollection)
  protected
    function GetGestureManager: TCustomGestureManager; virtual; abstract;
    function GetItem(Index: Integer): TCustomGestureCollectionItem;
    procedure SetItem(Index: Integer; const Value: TCustomGestureCollectionItem);
  public
    function AddGesture: TCustomGestureCollectionItem; virtual; abstract;
    function FindGesture(AGestureID: TGestureID): TCustomGestureCollectionItem; overload; virtual; abstract;
    function FindGesture(const AName: string): TCustomGestureCollectionItem; overload; virtual; abstract;
    function GetUniqueGestureID: TGestureID; virtual; abstract;
    procedure RemoveGesture(AGestureID: TGestureID); virtual; abstract;
    property GestureManager: TCustomGestureManager read GetGestureManager;
    property Items[Index: Integer]: TCustomGestureCollectionItem read GetItem write SetItem; default;
  end;

  TCustomGestureEngine = class
  public type
    TGestureEngineFlag = (efMouseEvents, efTouchEvents);
    TGestureEngineFlags = set of TGestureEngineFlag;
  protected
    function GetActive: Boolean; virtual; abstract;
    function GetFlags: TGestureEngineFlags; virtual; abstract;
    procedure SetActive(const Value: Boolean); virtual; abstract;
  public
    constructor Create(const AControl: TFmxObject); virtual; abstract;
    class function Supported: Boolean; virtual;
    procedure BroadcastGesture(const AControl: TFmxObject; EventInfo: TGestureEventInfo); virtual; abstract;
    property Active: Boolean read GetActive write SetActive;
    property Flags: TGestureEngineFlags read GetFlags;
  end;

  TCustomGestureManager = class(TComponent)
  protected
    function GetGestureList(AControl: TFmxObject): TGestureArray; virtual; abstract;
    function GetStandardGestures(AControl: TFmxObject): TStandardGestures; virtual; abstract;
    procedure SetStandardGestures(AControl: TFmxObject; AStandardGestures: TStandardGestures); virtual; abstract;
  public
    function AddRecordedGesture(const Item: TCustomGestureCollectionItem): TGestureID; overload; virtual; abstract;
    function FindCustomGesture(AGestureID: TGestureID): TCustomGestureCollectionItem; overload; virtual; abstract;
    function FindCustomGesture(const AName: string): TCustomGestureCollectionItem; overload; virtual; abstract;
    function FindGesture(const AControl: TFmxObject; AGestureID: TGestureID): TCustomGestureCollectionItem; overload; virtual; abstract;
    function FindGesture(const AControl: TFmxObject; const AName: string): TCustomGestureCollectionItem; overload; virtual; abstract;
    procedure RemoveActionNotification(Action: TCustomAction; Item: TCustomGestureCollectionItem); virtual;
    procedure RegisterControl(const AControl: TFmxObject); virtual; abstract;
    procedure RemoveRecordedGesture(AGestureID: TGestureID); overload; virtual; abstract;
    procedure RemoveRecordedGesture(const AGesture: TCustomGestureCollectionItem); overload; virtual; abstract;
    function SelectGesture(const AControl: TFmxObject; AGestureID: TGestureID): Boolean; overload; virtual; abstract;
    function SelectGesture(const AControl: TFmxObject; const AName: string): Boolean; overload; virtual; abstract;
    procedure UnregisterControl(const AControl: TFmxObject); virtual; abstract;
    procedure UnselectGesture(const AControl: TFmxObject; AGestureID: TGestureID); virtual; abstract;
    property GestureList[AControl: TFmxObject]: TGestureArray read GetGestureList;
    property StandardGestures[AControl: TFmxObject]: TStandardGestures read GetStandardGestures write SetStandardGestures;
  end;

  TCustomTouchManager = class(TPersistent)
  private
  type
    TObjectWrapper = class(TObject)
      [Weak] FObject : TFmxObject;
      constructor Create(const AObject: TFmxObject);
    end;
  private
    [Weak] FControl: TFmxObject;
    FGestureEngine: TCustomGestureEngine;
    FGestureManager: TCustomGestureManager;
    FInteractiveGestures: TInteractiveGestures;
    FDefaultInteractiveGestures: TInteractiveGestures;
    FStandardGestures: TStandardGestures;
    function GetStandardGestures: TStandardGestures;
    function IsInteractiveGesturesStored: Boolean;
    procedure SetGestureEngine(const Value: TCustomGestureEngine);
    procedure SetGestureManager(const Value: TCustomGestureManager);
    procedure SetStandardGestures(const Value: TStandardGestures);
    function GetGestureList: TGestureArray;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    function IsDefault: Boolean;
  public
    constructor Create(AControl: TFmxObject);
    destructor Destroy; override;
    procedure ChangeNotification(const AControl: TFmxObject);
    function FindGesture(AGestureID: TGestureID): TCustomGestureCollectionItem; overload;
    function FindGesture(const AName: string): TCustomGestureCollectionItem; overload;
    procedure RemoveChangeNotification(const AControl: TFmxObject);
    function SelectGesture(AGestureID: TGestureID): Boolean; overload;
    function SelectGesture(const AName: string): Boolean; overload;
    procedure UnselectGesture(AGestureID: TGestureID); inline;
    property GestureEngine: TCustomGestureEngine read FGestureEngine write SetGestureEngine;
    property GestureList: TGestureArray read GetGestureList;
    property GestureManager: TCustomGestureManager read FGestureManager write SetGestureManager;
    property InteractiveGestures: TInteractiveGestures
      read FInteractiveGestures write FInteractiveGestures stored IsInteractiveGesturesStored;
    property DefaultInteractiveGestures: TInteractiveGestures
      read FDefaultInteractiveGestures write FDefaultInteractiveGestures;
    property StandardGestures: TStandardGestures read GetStandardGestures write SetStandardGestures;
  end;

  TTouchManager = class(TCustomTouchManager)
  published
    property GestureManager;
    property InteractiveGestures;
  end;

{ TAnimation }

  TTrigger = type string;

  TAnimation = class(TFmxObject)
  private
  type
    TTriggerRec = record
      Name: string;
      Prop: TRttiProperty;
      Value: Boolean;
    end;
  private
    FTickCount : Integer;
    FDuration: Single;
    FDelay, FDelayTime: Single;
    FTime: Single;
    FInverse: Boolean;
    FTrigger, FTriggerInverse: TTrigger;
    FLoop: Boolean;
    FPause: Boolean;
    FRunning: Boolean;
    FOnFinish: TNotifyEvent;
    FOnProcess: TNotifyEvent;
    FInterpolation: TInterpolationType;
    FAnimationType: TAnimationType;
    FEnabled: Boolean;
    FAutoReverse: Boolean;
    FTriggerList: TList<TTriggerRec>;
    FInverseTriggerList: TList<TTriggerRec>;
    FTargetClass: TClass;
    procedure SetEnabled(const Value: Boolean);
    procedure SetTrigger(const Value: TTrigger);
    procedure SetTriggerInverse(const Value: TTrigger);
    procedure ParseTriggers(const AInstance: TFmxObject; Normal, Inverse: Boolean);
  protected
    function NormalizedTime: Single;
    procedure FirstFrame; virtual;
    procedure ProcessAnimation; virtual; abstract;
    procedure DoProcess; virtual;
    procedure DoFinish; virtual;
    procedure Loaded; override;
    procedure ChangeParent; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Start; virtual;
    procedure Stop; virtual;
    procedure StopAtCurrent; virtual;
    procedure StartTrigger(const AInstance: TFmxObject; const ATrigger: string);
    procedure StopTrigger(const AInstance: TFmxObject; const ATrigger: string);
    procedure ProcessTick(time, deltaTime: Single);
    property Running: Boolean read FRunning;
    property Pause: Boolean read FPause write FPause;
    property AnimationType: TAnimationType read FAnimationType write FAnimationType default TAnimationType.atIn;
    property AutoReverse: Boolean read FAutoReverse write FAutoReverse default False;
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property Delay: Single read FDelay write FDelay;
    property Duration: Single read FDuration write FDuration nodefault;
    property Interpolation: TInterpolationType read FInterpolation write FInterpolation default TInterpolationType.itLinear;
    property Inverse: Boolean read FInverse write FInverse default False;
    property Loop: Boolean read FLoop write FLoop default False;
    property Trigger: TTrigger read FTrigger write SetTrigger;
    property TriggerInverse: TTrigger read FTriggerInverse write SetTriggerInverse;
    property CurrentTime: Single read FTime;
    property OnProcess: TNotifyEvent read FOnProcess write FOnProcess;
    property OnFinish: TNotifyEvent read FOnFinish write FOnFinish;
  end;

{ TEffect }

  IEffectContainer = interface
  ['{FFC591A9-A520-45F2-BD49-17F76E7B057C}']
    procedure NeedUpdateEffects;
    procedure BeforeEffectEnabledChanged(const Enabled: Boolean);
    procedure EffectEnabledChanged(const Enabled: Boolean);
  end;

  TEffectStyle = set of (esAfterPaint, esDisablePaint, esDisablePaintToBitmap);

  TEffect = class(TFmxObject)
  private
    FEnabled: Boolean;
    FTrigger: TTrigger;
    procedure SetEnabled(const Value: Boolean);
  protected
    FEffectStyle: TEffectStyle;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetRect(const ARect: TRectF): TRectF; virtual;
    function GetOffset: TPointF; virtual;
    procedure ProcessEffect(const Canvas: TCanvas; const Visual: TBitmap; const Data: Single); virtual;
    procedure ApplyTrigger(AInstance: TFmxObject; const ATrigger: string); virtual;
    procedure UpdateParentEffects;
    property EffectStyle: TEffectStyle read FEffectStyle;
    property Trigger: TTrigger read FTrigger write FTrigger;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
  end;

{ TBrushObject }

  IBrushObject = interface(IFreeNotificationBehavior)
    ['{BB870DB6-0228-4165-9906-CF75BFF8C7CA}']
    function GetBrush: TBrush;
    property Brush: TBrush read GetBrush;
  end;

  TBrushObject = class(TFmxObject, IBrushObject)
  private
    FBrush: TBrush;
    { IBrushObject }
    function GetBrush: TBrush;
  protected
    procedure SetName(const NewName: TComponentName); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Brush: TBrush read FBrush write FBrush;
  end;

{ TFontObject }

  IFontObject = interface(IFreeNotificationBehavior)
    ['{F87FBCFE-CE5F-430C-8F46-B20B2E395C1B}']
    function GetFont: TFont;
    property Font: TFont read GetFont;
  end;

  TFontObject = class(TFmxObject, IFontObject)
  private
    FFont: TFont;
    { IFontObject }
    function GetFont: TFont;
  protected
    procedure SetName(const NewName: TComponentName); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Font: TFont read FFont write FFont;
  end;

{ TPathObject }

  TPathObject = class(TFmxObject, IPathObject)
  private
    FPath: TPathData;
    { IPathObject }
    function GetPath: TPathData;
  protected
    procedure SetName(const NewName: TComponentName); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Path: TPathData read FPath write FPath;
  end;

{ TBitmapObject }

  TBitmapObject = class(TFmxObject, IBitmapObject)
  private
    FBitmap: TBitmap;
    { IBitmapObject }
    function GetBitmap: TBitmap;
  protected
    procedure SetName(const NewName: TComponentName); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Bitmap: TBitmap read FBitmap write FBitmap;
  end;

{ TColorObject }

  TColorObject = class(TFmxObject)
  private
    FColor: TAlphaColor;
  protected
    procedure SetName(const NewName: TComponentName); override;
  published
    property Color: TAlphaColor read FColor write FColor;
  end;

  ISizeGrip = interface
    ['{181729B7-53B2-45ea-97C7-91E1F3CBAABE}']
  end;

{ TLang }

  TLang = class(TFmxObject)
  private
    FLang: string;
    FResources: TStrings;
    FOriginal: TStrings;
    FAutoSelect: Boolean;
    FFileName: string;
    FStoreInForm: Boolean;
    procedure SetLang(const Value: string);
    function GetLangStr(const Index: string): TStrings;
  protected
    { vcl }
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadResources(Stream: TStream);
    procedure WriteResources(Stream: TStream);
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddLang(const AName: string);
    procedure LoadFromFile(const AFileName: string);
    procedure SaveToFile(const AFileName: string);
    property Original: TStrings read FOriginal;
    property Resources: TStrings read FResources;
    property LangStr[const Index: string]: TStrings read GetLangStr;
  published
    property AutoSelect: Boolean read FAutoSelect write FAutoSelect default True;
    property FileName: string read FFileName write FFileName;
    property StoreInForm: Boolean read FStoreInForm write FStoreInForm default True;
    property Lang: string read FLang write SetLang;
  end;

{ TTimer }

  TTimerProc = procedure of object;

  IFMXTimerService = interface(IInterface)
    ['{856E938B-FF7B-4E13-85D4-3414A6A9FF2F}']
    function CreateTimer(Interval: Integer; TimerFunc: TTimerProc): TFmxHandle;
    function DestroyTimer(Timer: TFmxHandle): Boolean;
    function GetTick: Extended;
  end;

  TTimer = class(TFmxObject)
  private
    FInterval: Cardinal;
    FTimerHandle: TFmxHandle;
    FOnTimer: TNotifyEvent;
    FEnabled: Boolean;
    FPlatformTimer: IFMXTimerService;
    procedure Timer;
  protected
    procedure SetEnabled(Value: Boolean); virtual;
    procedure SetInterval(Value: Cardinal); virtual;
    procedure SetOnTimer(Value: TNotifyEvent); virtual;
    procedure DoOnTimer; virtual;
    procedure UpdateTimer; virtual;
    procedure KillTimer; virtual;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Interval: Cardinal read FInterval write SetInterval default 1000;
    property OnTimer: TNotifyEvent read FOnTimer write SetOnTimer;
  end;

{ TLineInfo }

  PLineMetric = ^TLineMetric;
  TLineMetric = record
    Index: integer;
    Len: integer;
  end;

  TLineMetricInfo = class
  protected
    FLineMetrics: array of TLineMetric;
    function GetCount: integer; virtual;
    function GetMetrics(Index: Integer): PLineMetric; virtual;
    procedure SetCount(const Value: Integer); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; virtual;
    property Count: integer read GetCount write SetCount;
    property Metrics[ind: integer]: PLineMetric read GetMetrics;
  end;

{$REGION 'Exceptions: Canvas helpers / 2D and 3D engine / GPU'}

  EInvalidCallingConditions = class(Exception);
  EInvalidRenderingConditions = class(Exception);
  ETextureSizeTooSmall = class(Exception);
  ECannotAcquireBitmapAccess = class(Exception);
  ECannotFindSuitablePixelFormat = class(Exception);
  ECannotCreateDirect3D = class(Exception);
  ECannotCreateD3DDevice = class(Exception);
  ECannotAcquireDXGIFactory = class(Exception);
  ECannotAssociateWindowHandle = class(Exception);
  ECannotRetrieveDisplayMode = class(Exception);
  ECannotRetrieveBufferDesc = class(Exception);
  ECannotCreateSamplerState = class(Exception);
  ECannotRetrieveSurface = class(Exception);
  ECannotCreateTexture = class(Exception);
  ECannotUploadTexture = class(Exception);
  ECannotActivateTexture = class(Exception);
  ECannotAcquireTextureAccess = class(Exception);
  ECannotCopyTextureResource = class(Exception);
  ECannotCreateRenderTargetView = class(Exception);
  ECannotActivateFrameBuffers = class(Exception);
  ECannotCreateRenderBuffers = class(Exception);
  ECannotRetrieveRenderBuffers = class(Exception);
  ECannotActivateRenderBuffers = class(Exception);
  ECannotBeginRenderingScene = class(Exception);
  ECannotSyncDeviceBuffers = class(Exception);
  ECannotUploadDeviceBuffers = class(Exception);
  ECannotCreateDepthStencil = class(Exception);
  ECannotRetrieveDepthStencil = class(Exception);
  ECannotActivateDepthStencil = class(Exception);
  ECannotCreateSwapChain = class(Exception);
  ECannotResizeSwapChain = class(Exception);
  ECannotActivateSwapChain = class(Exception);
  ECannotCreateVertexShader = class(Exception);
  ECannotCreatePixelShader = class(Exception);
  ECannotCreateVertexLayout = class(Exception);
  ECannotCreateVertexDeclaration = class(Exception);
  ECannotCreateVertexBuffer = class(Exception);
  ECannotCreateIndexBuffer = class(Exception);
  EShaderCompilationError = class(Exception);
  EProgramCompilationError = class(Exception);
  ECannotFindShaderVariable = class(Exception);
  ECannotActivateShaderProgram = class(Exception);
  ECannotCreateOpenGLContext = class(Exception);
  ECannotUpdateOpenGLContext = class(Exception);
  ECannotDrawMeshObject = class(Exception);
  EFeatureNotSupported = class(Exception);
  EErrorCompressingStream = class(Exception);
  EErrorDecompressingStream = class(Exception);
  EErrorUnpackingShaderCode = class(Exception);

{$ENDREGION}

var
  AniFrameRate: Integer = 60;
  AniThread: TTimer;
  USFormatSettings: TFormatSettings; // used for correct string to float convertion

{ Resources }

procedure AddResource(const AObject: TFmxObject);
procedure RemoveResource(const AObject: TFmxObject);
function FindStyleResource(const AStyleLookup: string; const Clone: Boolean = False): TFmxObject;

{ Lang }

procedure LoadLangFromFile(const AFileName: string);
procedure LoadLangFromStrings(const AStr: TStrings);
procedure ResetLang;

{ Align }

procedure AlignObjects(const AParent: TFmxObject; APadding: TBounds; AParentWidth, AParentHeight: single;
  var ALastWidth, ALastHeight: single; var ADisableAlign: Boolean);

procedure RecalcAnchorRules(const Parent : TFmxObject;
                  Anchors : TAnchors;
                  const BoundsRect : TRectF;
                  const Padding : TBounds;
                  var AOriginalParentSize:TPointF;
                  var AAnchorOrigin:TPointF;
                  var AAnchorRules:TPointF);
procedure RecalcControlOriginalParentSize(const Parent: TFmxObject;
                  ComponentState : TComponentState;
                  var AOriginalParentSize : TPointF);

type
  TCustomTranslateProc = function(const AText: string): string;

var
  CustomTranslateProc: TCustomTranslateProc;

{ This function use to collect string which can be translated. Just place this function at Application start. }

procedure CollectLangStart;
procedure CollectLangFinish;
{ This function return Strings with collected text }
function CollectLangStrings: TStrings;

function Translate(const AText: string): string;
function TranslateText(const AText: string): string;

{ Strings }

function PointToString(R: TPointF): string;
function StringToPoint(S: string): TPointF;

function RectToString(R: TRectF): string;
function StringToRect(S: string): TRectF;

{ Four 2D corners describing arbitrary rectangle. }

function CornersF(Left, Top, Width, Height: Single): TCornersF; overload;
function CornersF(const Pt1, Pt2, Pt3, Pt4: TPointF): TCornersF; overload;
function CornersF(const Rect: TRect): TCornersF; overload;
function CornersF(const Rect: TRectF): TCornersF; overload;

{ Geometry }

function VectorAngleCosine(const v1, v2: TVector): Single;
function VectorCrossProductZ(const v1, v2: TVector): Single;
function VectorAngle(const V, N: TVector): Single;

function MatrixMultiply(const M1, M2: TMatrix): TMatrix;
function MatrixDeterminant(const M: TMatrix): Single;
procedure AdjointMatrix(var M: TMatrix);
procedure ScaleMatrix(var M: TMatrix; const factor: Single);
procedure InvertMatrix(var M: TMatrix);

function CreateRotationMatrix(const Angle: Single): TMatrix;
function CreateScaleMatrix(const ScaleX, ScaleY: Single): TMatrix;
function CreateTranslateMatrix(const DX, DY: Single): TMatrix;

{ Animation }

function InterpolateSingle(const Start, Stop, t: Single): Single;
function InterpolateRotation(Start, Stop, t: Single): Single;
function InterpolateColor(const Start, Stop: TAlphaColor; t: Single): TAlphaColor;

function InterpolateLinear(t, B, C, D: Single): Single;
function InterpolateSine(t, B, C, D: Single; AType: TAnimationType): Single;
function InterpolateQuint(t, B, C, D: Single; AType: TAnimationType): Single;
function InterpolateQuart(t, B, C, D: Single; AType: TAnimationType): Single;
function InterpolateQuad(t, B, C, D: Single; AType: TAnimationType): Single;
function InterpolateExpo(t, B, C, D: Single; AType: TAnimationType): Single;
function InterpolateElastic(t, B, C, D, A, P: Single; AType: TAnimationType): Single;
function InterpolateCubic(t, B, C, D: Single; AType: TAnimationType): Single;
function InterpolateCirc(t, B, C, D: Single; AType: TAnimationType): Single;
function InterpolateBounce(t, B, C, D: Single; AType: TAnimationType): Single;
function InterpolateBack(t, B, C, D, S: Single; AType: TAnimationType): Single;

{ Helper functions }

function IsHandleValid(Hnd: TFmxHandle): Boolean;
procedure ReverseBytes(P: Pointer; Count: Integer);
procedure FillLongword(Src: Pointer; Count: Integer; Value: longword);
procedure FillAlpha(Src: Pointer; Count: Integer; Alpha: Byte);
procedure FillLongwordRect(Src: Pointer; W, H, X1, Y1, X2, Y2: Integer; Value: longword);
function GetToken(var S: string; const Separators: string; const Stop: string = ''): string;
function WideGetToken(var Pos: Integer; const S: string; const Separators: string; const Stop: string = ''): string;

{ Adjusts the given memory address in indexed fashion by the specified pitch,
  which is typically used for accessing 2D images that are given by their
  top-left memory address and horizontal pitch. }
function ShiftAddressByPitch(const Addr: Pointer; const Pitch, Index: Integer): Pointer; inline;

procedure RegisterFmxClasses(const RegClasses: array of TPersistentClass); overload;
procedure RegisterFmxClasses(const RegClasses: array of TPersistentClass;
  const GroupClasses: array of TPersistentClass); overload;

var
  AnchorAlign: array [TAlignLayout] of TAnchors = (
    { alNone }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop],

    { alTop }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akRight],

    { alLeft }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akBottom],

    { alRight }
    [TAnchorKind.akRight,
     TAnchorKind.akTop,
     TAnchorKind.akBottom],

    { alBottom }
    [TAnchorKind.akLeft,
     TAnchorKind.akRight,
     TAnchorKind.akBottom],

    { alMostTop }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akRight],

    { alMostBottom }
    [TAnchorKind.akLeft,
     TAnchorKind.akRight,
     TAnchorKind.akBottom],

    { alMostLeft }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akBottom],

    { alMostRight }
    [TAnchorKind.akRight,
     TAnchorKind.akTop,
     TAnchorKind.akBottom],

    { alClient }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akRight,
     TAnchorKind.akBottom],

    { alContents }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akRight,
     TAnchorKind.akBottom],

    { alCenter }
    [],

    { alVertCenter }
    [TAnchorKind.akLeft,
     TAnchorKind.akRight],

    { alHorzCenter }
    [TAnchorKind.akTop,
     TAnchorKind.akBottom],

    { vaHorizintal }
    [TAnchorKind.akLeft,
     TAnchorKind.akRight],

    { alVertical }
    [TAnchorKind.akTop,
     TAnchorKind.akBottom],

    { alScale }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akRight,
     TAnchorKind.akBottom],

    { alFit }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akRight,
     TAnchorKind.akBottom],

    { alFitLeft }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akRight,
     TAnchorKind.akBottom],

    { alFitRight }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akRight,
     TAnchorKind.akBottom]
  );

{ Debugging }
type
  Log = class abstract
  strict private
    class var FLogger: IInterface;
    class constructor Create;
  public
  type
    ToStringFunc = reference to function(O: TObject) : String;

    class procedure d(const Msg: String); overload;
    class procedure d(const Fmt: String; const Args: array of const); overload;
    class procedure d(const Tag: String; const Instance : TObject; const Msg : String); overload;
    class procedure d(const Tag: String; const Instance : TObject; const Method : String; const Msg : String); overload;
    class procedure TimeStamp(const Msg: String); overload;
    class function ObjToString(const Instance : TObject) : String;
//    class function ArrayToString(AArray : TEnumerable<TControl>) : String; overload;
    class function ArrayToString(const AArray : TEnumerable<TFmxObject>) : String; overload;
    class function ArrayToString(const AArray : TEnumerable<TFmxObject>; MakeStr : ToStringFunc) : String; overload;
    class procedure DumpFmxObject(const O: TFmxObject; Nest: Integer = 0);
  end;

/// <summary>
///   This function removes the char '&' from a string
///  <para> For Example <c>'S&ome text && number' -> 'Some text & number'</c> </para>
/// </summary>
function DelAmp(const Text: string): string;


type
  TEnumerableFilter<F; T: TFmxObject> = class(TEnumerable<T>)
  private
    FBaseEnum: TEnumerable<F>;
    FSelfDestruct: Boolean;
  protected
    function DoGetEnumerator: TEnumerator<T>; override;
  public
    constructor Create(const FullEnum: TEnumerable<F>; SelfDestruct: Boolean = False);
    class function Filter(const Src: TEnumerable<F>): TEnumerableFilter<F,T>;

  type
    TFilterEnumerator = class(TEnumerator<T>)
    private
      FCleanup: TEnumerableFilter<F,T>;
      FRawEnumerator: TEnumerator<F>;
      FCurrent: T;
      function GetCurrent: T;
    protected
      function DoGetCurrent: T; override;
      function DoMoveNext: Boolean; override;
    public
      constructor Create(const Enumerable: TEnumerable<F>; const Cleanup: TEnumerableFilter<F,T>);
      destructor Destroy; override;
      property Current: T read GetCurrent;
      function MoveNext: Boolean;
    end;
  end;

  TIdleMessage = class(FMX.Messages.TMessage)
  end;

/// <summary>
///  Registering the class of flashing control.
///  If at the time perform this function has been instantiated flashing control, it will be destroyed.
///  If FlasherClass = nil, then with passed to function Flasher will be raised exception.
///  If FlasherClass different from nil, then this class must support the interface IFlasher.
/// </summary>
procedure RegisterFlasherClass(const FlasherClass: TFmxObjectClass; const CaretClass: TCaretClass);
/// <summary>
///  Registered class flashing control
/// </summary>
function FlasherClass(const CaretClass: TCaretClass): TFmxObjectClass;
/// <summary>
///  Flashing (blinking) control. The first time, you create a single instance.
/// </summary>
function Flasher(const CaretClass: TCaretClass): TFmxObject;
/// <summary>
///  This function allows you to specify are creating a single instance of Flasher.
/// </summary>
function AssignedFlasher(const CaretClass: TCaretClass): boolean;

type
  TShowVirtualKeyboard = procedure (const Displayed: boolean;
                                    const Caret: TCustomCaret;
                                    var VirtualKeyBoardState: TVirtualKeyBoardState);

procedure RegisterShowVKProc(const ShowVirtualKeyboard: TShowVirtualKeyboard);

var
  SharedContext: TRttiContext;
  ClonePropertiesCache: TDictionary<string, TList<TRttiProperty>>;
  ClonePersistentCache: TDictionary<string, TList<TRttiProperty>>;


implementation

uses
  System.TypInfo, System.RTLConsts, System.Character,
  FMX.Platform, FMX.Forms, FMX.Ani, FMX.Consts, FMX.Styles, FMX.Menus, FMX.TextLayout
  {$IFDEF MACOS}, Macapi.CoreFoundation{$ENDIF};

type

  TOpenCustomAction = class (TCustomAction)
  end;

function IsHandleValid(Hnd: TFmxHandle): Boolean;
begin
  Result := (Hnd <> 0);
end;

procedure RegisterFmxClasses(const RegClasses: array of TPersistentClass;
  const GroupClasses: array of TPersistentClass);
var
  I: Integer;
begin
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);
  for I := Low(GroupClasses) to High(GroupClasses) do
    System.Classes.GroupDescendentsWith(GroupClasses[I], TFmxObject);
  for I := Low(RegClasses) to High(RegClasses) do
    System.Classes.RegisterClass(RegClasses[I]);
end;

procedure RegisterFmxClasses(const RegClasses: array of TPersistentClass);
begin
  RegisterFmxClasses(RegClasses, []);
end;

function DelAmp(const Text: string): string;
var
  I, J: Integer;
  Sb: TCharArray;
begin
  Result := '';
  if Text <> '' then
  begin
    SetLength(Sb, Text.Length);
    I := Low(Text);
    J := 0;
    while I <= High(Text) do
    begin
      if (Text[I] <> '&') then
      begin
        Sb[J] := Text[I];
        Inc(J);
      end
      else
      begin
        if ((I < High(Text)) and (Text[I + 1] = '&')) then
        begin
          Sb[J] := Text[I];
          Inc(J);
          Inc(I);
        end;
      end;
      Inc(I);
    end;
    Result := string.Create(Sb, 0, J);
  end;
end;


{ Resources }

var
  ResourceDict: TDictionary<string,TFmxObjectList> = nil;

procedure AddResource(const AObject: TFmxObject);
var
  ResourceList: TFmxObjectList;
begin
  if not Assigned(ResourceDict) then
    ResourceDict := TDictionary<string,TFmxObjectList>.Create(100);

  if not ResourceDict.TryGetValue(AObject.StyleName, ResourceList) then
  begin
    ResourceList := TFmxObjectList.Create;
    ResourceDict.Add(AObject.StyleName, ResourceList);
  end;

  if ResourceList.IndexOf(AObject) < 0 then
    ResourceList.Add(AObject);
end;

procedure RemoveResource(const AObject: TFmxObject);
var
  ResourceList: TFmxObjectList;
begin
  if Assigned(ResourceDict) and ResourceDict.TryGetValue(AObject.StyleName, ResourceList) then
    ResourceList.Remove(AObject);
end;

function FindStyleResource(const AStyleLookup: string; const Clone: Boolean = False): TFmxObject;
var
  I: Integer;
  ResourceList: TFmxObjectList;
  StyleObject: TFmxObject;
  SaveStyleName: string;
begin
  StyleObject := nil;
  if Assigned(ResourceDict) and ResourceDict.TryGetValue(AStyleLookup, ResourceList) then
    for I := ResourceList.Count - 1 downto 0 do
      if Assigned(ResourceList[I]) and ResourceList[I].Stored then
      begin
        StyleObject := ResourceList[I];
        Break;
      end;
  if Assigned(StyleObject) and Clone then
  begin
    SaveStyleName := StyleObject.StyleName;
    try
      StyleObject.FStyleName := '';
      Result := StyleObject.Clone(nil);
    finally
      StyleObject.FStyleName := SaveStyleName;
    end;
  end
  else
    Result := StyleObject;
end;

{ Scenes }

var
  NeedResetLang: Boolean;

{ Lang }

var
  CollectLang, Lang: TStrings;

procedure CollectLangStart;
begin
  ResetLang;
  if Not Assigned(CollectLang) then
  begin
    CollectLang := TStringList.Create;
//    TStringList(CollectLang).Sorted := True;
    TStringList(CollectLang).CaseSensitive := True;
  end;
end;

procedure CollectLangFinish;
begin
  if Assigned(CollectLang) then
    FreeAndNil(CollectLang);
end;

function CollectLangStrings: TStrings;
begin
  Result := CollectLang;
end;

procedure CollectLangSave;
begin
  if Assigned(CollectLang) then
  begin
    CollectLang.SaveToFile(ExtractFilePath(ParamStr(0)) + 'lang.lng');
  end;
end;

procedure LoadLangFromFile(const AFileName: string);
begin
  if not FileExists(AFileName) then
    Exit;
  ResetLang;
  if Not Assigned(Lang) then
  begin
    Lang := TStringList.Create;
//    TStringList(Lang).Sorted := True;
    TStringList(Lang).CaseSensitive := True;
  end;
  Lang.LoadFromFile(AFileName);
  TStyleManager.UpdateScenes;
end;

procedure LoadLangFromStrings(const AStr: TStrings);
begin
  if Not Assigned(AStr) then
    Exit;
  ResetLang;
  if Not Assigned(Lang) then
  begin
    Lang := TStringList.Create;
//    TStringList(Lang).Sorted := True;
    TStringList(Lang).CaseSensitive := True;
  end;
  Lang.Assign(AStr);
  TStyleManager.UpdateScenes;
end;

procedure ResetLang;
begin
  if Assigned(Lang) then
  begin
    NeedResetLang := True;
    try
      TStyleManager.UpdateScenes;
    finally
      NeedResetLang := False;
      FreeAndNil(Lang);
    end;
  end;
end;

function IndexOfValueStr(Str: TStrings; const Name: string): Integer;
var
  P: Integer;
  S: string;
begin
  for Result := 0 to Str.Count - 1 do
  begin
    S := Str[Result];
    P := S.IndexOf('=') + 1;
    if (P >= 0) and (CompareStr(S.Substring(P), Name) = 0) then Exit;
  end;
  Result := -1;
end;

function Translate(const AText: string): string;
var
  Idx: Integer;
begin
  if AText = '' then
  begin
    Result := '';
    Exit;
  end;
  if Assigned(CustomTranslateProc) then
  begin
    if CustomTranslateProc(AText) <> '' then
      Result := CustomTranslateProc(AText)
    else
      Result := AText;
    Exit;
  end;
  if Assigned(CollectLang) then
  begin
    if CollectLang.IndexOf(AText) < 0 then
      CollectLang.Add(AText)
  end;
  if Assigned(Lang) then
  begin
    if not NeedResetLang then
    begin
      Idx := Lang.IndexOfName(AText);
      if Idx >= 0 then
        Result := Lang.ValueFromIndex[Idx]
      else
        Result := AText;
    end
    else
    begin
      Idx := IndexOfValueStr(Lang, AText);
      if Idx >= 0 then
        Result := Lang.Names[Idx];
      if Result = '' then
        Result := AText;
    end;
  end
  else
    Result := AText;
end;

function TranslateText(const AText: string): string;
begin
  Result := Translate(AText);
end;

{ Align procedure }

procedure AlignObjects(const AParent: TFmxObject; APadding: TBounds; AParentWidth,
  AParentHeight: single; var ALastWidth, ALastHeight: single;
  var ADisableAlign: Boolean);
var
  R: TRectF;
  AlignList: TInterfaceList;

  function InsertBefore(const C1, C2: IAlignableObject; AAlign: TAlignLayout): Boolean;
  begin
    Result := False;
    case AAlign of
      TAlignLayout.alTop, TAlignLayout.alMostTop:
        Result := C1.Top < C2.Top;
      TAlignLayout.alBottom, TAlignLayout.alMostBottom:
        Result := (C1.Top + C1.Height) >= (C2.Top + C2.Height);
      TAlignLayout.alLeft, TAlignLayout.alMostLeft:
        Result := C1.Left < C2.Left;
      TAlignLayout.alRight, TAlignLayout.alMostRight:
        Result := (C1.Left + C1.Width) >= (C2.Left + C2.Width);
    end;
  end;

  procedure DoPosition(const Control: IAlignableObject; AAlign: TAlignLayout);
  var
    NewLeft, NewTop, NewWidth, NewHeight: Single;
    cR, mR: TRectF;
    fitScale: Single;
  begin
    if (AAlign = TAlignLayout.alNone) or (Control.Anchors <> AnchorAlign[AAlign]) then
    begin
      NewLeft := Control.Left - Control.Margins.Left;
      NewTop := Control.Top - Control.Margins.Top;
      NewWidth := Control.Width + Control.Margins.Left + Control.Margins.Right;
      NewHeight := Control.Height + Control.Margins.Top + Control.Margins.Bottom;

      if TAnchorKind.akRight in Control.Anchors then
        if TAnchorKind.akLeft in Control.Anchors then
          // The AnchorRules.X is the original FContext.Width
          NewWidth := AParentWidth - (Control.OriginalParentSize.X - Control.AnchorRules.X)
        else
          // The AnchorRules.X is the original left
          NewLeft := AParentWidth - (ALastWidth - NewLeft)
      else if not (TAnchorKind.akLeft in Control.Anchors) and (Control.OriginalParentSize.X <> 0) then
        // The AnchorRules.X is the original middle of the AControl
        NewLeft := Control.AnchorRules.X * AParentWidth / Control.OriginalParentSize.X - NewWidth / 2;
      if TAnchorKind.akBottom in Control.Anchors then
        if TAnchorKind.akTop in Control.Anchors then
          // The AnchorRules.Y is the original FContext.Height
          NewHeight := AParentHeight - (Control.OriginalParentSize.Y - Control.AnchorRules.Y)
        else
          // The AnchorRules.Y is the original top
          NewTop := AParentHeight - (ALastHeight - NewTop)
      else if not (TAnchorKind.akTop in Control.Anchors) and (Control.OriginalParentSize.Y <> 0) then
        // The AnchorRules.Y is the original middle of the AControl
        NewTop := Control.AnchorRules.Y * AParentHeight / Control.OriginalParentSize.Y - NewHeight / 2;

      Control.AnchorMove := True;
      Control.SetBounds(NewLeft + Control.Margins.Left,
                        NewTop + Control.Margins.Top,
                        NewWidth - Control.Margins.Left - Control.Margins.Right,
                        NewHeight - Control.Margins.Top - Control.Margins.Bottom);
      Control.AnchorMove := False;

      if AAlign = TAlignLayout.alNone then Exit;
    end;

    NewWidth := R.Width;
    if (AAlign in [TAlignLayout.alLeft, TAlignLayout.alRight, TAlignLayout.alVertical,
      TAlignLayout.alMostLeft, TAlignLayout.alMostRight]) then
      NewWidth := Control.Width + Control.Margins.Left + Control.Margins.Right;
    NewHeight := R.Height;
    if (AAlign in [TAlignLayout.alTop, TAlignLayout.alBottom, TAlignLayout.alMostTop,
      TAlignLayout.alMostBottom, TAlignLayout.alHorizontal]) then
      NewHeight := Control.Height + Control.Margins.Top + Control.Margins.Bottom;
    NewLeft := R.Left;
    NewTop := R.Top;
    if (AAlign in [TAlignLayout.alVertical]) then
      NewLeft := Control.Left + Control.Margins.Left;
    if (AAlign in [TAlignLayout.alHorizontal]) then
      NewTop := Control.Top + Control.Margins.Top;
    case AAlign of
      TAlignLayout.alTop, TAlignLayout.alMostTop:
        R.Top := R.Top + NewHeight;
      TAlignLayout.alBottom, TAlignLayout.alMostBottom:
        begin
          R.Bottom := R.Bottom - NewHeight;
          NewTop := R.Bottom;
        end;
      TAlignLayout.alLeft, TAlignLayout.alMostLeft:
        R.Left := R.Left + NewWidth;
      TAlignLayout.alRight, TAlignLayout.alMostRight:
        begin
          R.Right := R.Right - NewWidth;
          NewLeft := R.Right;
        end;
      TAlignLayout.alContents:
        begin
          NewLeft := 0;
          NewTop := 0;
          NewWidth := AParentWidth;
          NewHeight := AParentHeight;
          Control.SetBounds(NewLeft + Control.Margins.Left, NewTop + Control.Margins.Top,
            NewWidth - Control.Margins.Left - Control.Margins.Right, NewHeight - Control.Margins.Top -
            Control.Margins.Bottom);
          Exit;
        end;
      TAlignLayout.alFit, TAlignLayout.alFitLeft, TAlignLayout.alFitRight:
        begin
          // mR := Rect(Padding.Left, Padding.Top, AParentWidth - Padding.Right, AParentHeight - Padding.Bottom);
          mR := RectF(0, 0, AParentWidth, AParentHeight);
          cR := RectF(Control.Left - Control.Margins.Left, Control.Top - Control.Margins.Top,
            Control.Left + Control.Width + Control.Margins.Right,
            Control.Top + Control.Height + Control.Margins.Bottom);
          fitScale := cR.Fit(mR);
          if (fitScale > 0) and (fitScale < 1) then
          begin
            cR.Left := cR.Left / fitScale;
            cR.Right := cR.Right / fitScale;
            cR.Top := cR.Top / fitScale;
            cR.Bottom := cR.Bottom / fitScale;
            RectCenter(cR, mR);
            if AAlign = TAlignLayout.alFitLeft then
              OffsetRect(cR, mR.Left - cR.Left, 0);
            if AAlign = TAlignLayout.alFitRight then
              OffsetRect(cR, mR.Right - cR.Right, 0);
            NewLeft := cR.Left;
            NewTop := cR.Top;
            NewWidth := cR.Right - cR.Left;
            NewHeight := cR.Bottom - cR.Top;
          end
          else
          begin
            if AAlign = TAlignLayout.alFitLeft then
              OffsetRect(cR, mR.Left - cR.Left, 0);
            if AAlign = TAlignLayout.alFitRight then
              OffsetRect(cR, mR.Right - cR.Right, 0);
            NewLeft := cR.Left;
            NewTop := cR.Top;
            NewWidth := cR.Right - cR.Left;
            NewHeight := cR.Bottom - cR.Top;
          end;
          Control.SetBounds(NewLeft + Control.Margins.Left, NewTop + Control.Margins.Top,
            NewWidth - Control.Margins.Left - Control.Margins.Right, NewHeight - Control.Margins.Top -
            Control.Margins.Bottom);
          if AAlign = TAlignLayout.alFitLeft then
            R.Left := R.Left + NewWidth;
          if AAlign = TAlignLayout.alFitRight then
            R.Right := R.Right - NewWidth;
          Exit;
        end;
      TAlignLayout.alCenter:
        begin
          NewLeft := R.Left +
            Trunc((NewWidth - (Control.Width + Control.Margins.Left + Control.Margins.Right)) / 2);
          NewWidth := (Control.Width + Control.Margins.Left + Control.Margins.Right);
          NewTop := R.Top +
            Trunc((NewHeight - (Control.Height + Control.Margins.Top + Control.Margins.Bottom)) / 2);
          NewHeight := (Control.Height + Control.Margins.Top + Control.Margins.Bottom);
        end;
      TAlignLayout.alHorzCenter:
        begin
          NewLeft := R.Left +
            Trunc((NewWidth - (Control.Width + Control.Margins.Left + Control.Margins.Right)) / 2);
          NewWidth := (Control.Width + Control.Margins.Left + Control.Margins.Right);
        end;
      TAlignLayout.alVertCenter:
        begin
          NewTop := R.Top +
            Trunc((NewHeight - (Control.Height + Control.Margins.Top + Control.Margins.Bottom)) / 2);
          NewHeight := (Control.Height + Control.Margins.Top + Control.Margins.Bottom);
        end;
    end;

    if (AAlign = TAlignLayout.alScale) then
    begin
      if (ALastWidth > 0) and (ALastHeight > 0) and (AParentWidth > 0) and (AParentHeight > 0) then
      begin
        Control.SetBounds(Control.Left * (AParentWidth / ALastWidth),
          Control.Top * (AParentHeight / ALastHeight), Control.Width * (AParentWidth / ALastWidth),
          Control.Height * (AParentHeight / ALastHeight));
      end;
      Exit;
    end
    else
    begin
      Control.SetBounds(NewLeft + Control.Margins.Left, NewTop + Control.Margins.Top,
        NewWidth - Control.Margins.Left - Control.Margins.Right, NewHeight - Control.Margins.Top -
        Control.Margins.Bottom);
    end;

    { Adjust client RectF if control didn't resize as we expected }
    if (Control.Width + Control.Margins.Left + Control.Margins.Right <> NewWidth) or
      (Control.Height + Control.Margins.Top + Control.Margins.Bottom <> NewHeight) then
      case AAlign of
        TAlignLayout.alTop:
          R.Top := R.Top - (NewHeight - (Control.Height + Control.Margins.Left + Control.Margins.Right));
        TAlignLayout.alBottom:
          R.Bottom := R.Bottom + (NewHeight - (Control.Height + Control.Margins.Top + Control.Margins.Bottom));
        TAlignLayout.alLeft:
          R.Left := R.Left - (NewWidth - (Control.Width + Control.Margins.Left + Control.Margins.Right));
        TAlignLayout.alRight:
          R.Right := R.Right + (NewWidth - (Control.Width + Control.Margins.Top + Control.Margins.Bottom));
        TAlignLayout.alClient:
          begin
            R.Right := R.Right + NewWidth - (Control.Width + Control.Margins.Left + Control.Margins.Right);
            R.Bottom := R.Bottom + NewHeight - (Control.Height + Control.Margins.Top + Control.Margins.Bottom);
          end;
      end;
  end;

  procedure DoAlign(AAlign: TAlignLayout);
  var
    i, j: Integer;
    Control: IAlignableObject;
    ALCount: Integer;
  begin
    AlignList.Clear;
    for i := 0 to AParent.Children.Count - 1 do
    begin
      if not Supports(AParent.Children[i], IAlignableObject, Control) then
        Continue;
      // Don't realign object with Anchors if it not loaded yet
      if (AAlign = TALignLayout.alNone) and (csLoading in AParent.Children[i].ComponentState) then
        Continue;

      if (Control.Align = AAlign) and (Control.AllowAlign) then
      begin
        j := 0;
        ALCount := AlignList.Count;
        while (j < ALCount) and (AAlign <> TAlignLayout.alNone) and not InsertBefore(Control, IAlignableObject(AlignList[j]), AAlign) do
          Inc(j);
        AlignList.Insert(j, Control);
      end;
    end;
    ALCount := AlignList.Count;
    for i := 0 to ALCount - 1 do
      DoPosition(IAlignableObject(AlignList[i]), AAlign);
  end;

begin
  if (csDestroying in AParent.ComponentState)
    or (not Assigned(AParent.Children))
    or (AParent.Children.Count = 0)
    or ADisableAlign then Exit;
  if csLoading in AParent.ComponentState then
  begin
    ALastWidth := AParentWidth;
    ALastHeight := AParentHeight;
    Exit;
  end;
  if (AParentWidth < 1) or (AParentWidth < 1) then
    Exit;
  if ALastWidth = 0 then
    ALastWidth := AParentWidth;
  if ALastHeight = 0 then
    ALastHeight := AParentHeight;

  ADisableAlign := True;
  try
    R := RectF(0, 0, AParentWidth, AParentHeight);
    if Assigned(APadding) then
      R := APadding.PaddingRect(R);
    AlignList := TInterfaceList.Create;
    try
      // Align
      DoAlign(TAlignLayout.alMostTop);
      DoAlign(TAlignLayout.alMostBottom);
      DoAlign(TAlignLayout.alMostLeft);
      DoAlign(TAlignLayout.alMostRight);
      DoAlign(TAlignLayout.alTop);
      DoAlign(TAlignLayout.alBottom);
      DoAlign(TAlignLayout.alLeft);
      DoAlign(TAlignLayout.alRight);
      DoAlign(TAlignLayout.alFitLeft);
      DoAlign(TAlignLayout.alFitRight);
      DoAlign(TAlignLayout.alClient);
      DoAlign(TAlignLayout.alHorizontal);
      DoAlign(TAlignLayout.alVertical);
      DoAlign(TAlignLayout.alContents);
      DoAlign(TAlignLayout.alCenter);
      DoAlign(TAlignLayout.alHorzCenter);
      DoAlign(TAlignLayout.alVertCenter);
      DoAlign(TAlignLayout.alScale);
      DoAlign(TAlignLayout.alFit);
      // Anchors
      DoAlign(TAlignLayout.alNone);
    finally
      AlignList.Free;
    end;
    ALastWidth := AParentWidth;
    ALastHeight := AParentHeight;
  finally
    ADisableAlign := False;
  end;
end;

{ Geom }

function GetToken(var S: string; const Separators: string; const Stop: string = ''): string;
var
  I: Integer;
  Breaks: string;
begin
  Breaks := Separators + Stop;
  for I := 0 to S.Length - 1 do
  begin
    if Breaks.Contains(S.Chars[I]) then
      Break;
  end;

  Result := S.Substring(0, I);
  S := S.Substring(I + 1);
end;


function WideGetToken(var Pos: Integer; const S: string; const Separators: string;
  const Stop: string = ''): string;
var
  len: Integer;
begin
  Result := '';
  len := S.Length;
  { skip first separators }
  while Pos <= len do
  begin
    if not Separators.Contains(S.Chars[Pos]) then
      Break;
    Inc(Pos);
  end;
  { get }
  while Pos <= len do
  begin
    if Stop.Contains(S.Chars[Pos]) then
      Break;
    if Separators.Contains(S.Chars[Pos]) then
      Break;
    Result := Result + S.Chars[Pos];
    Inc(Pos);
  end;
  { skip separators }
  while Pos <= len do
  begin
    if not Separators.Contains(S.Chars[Pos]) then
      Break;
    Inc(Pos);
  end;
end;

function ShiftAddressByPitch(const Addr: Pointer; const Pitch, Index: Integer): Pointer;
begin
  Result := Pointer(NativeInt(Addr) + Index * Pitch);
end;

procedure ReverseBytes(P: Pointer; Count: Integer);
var
  P1: PByte;
  P2: PByte;
  C: Byte;
begin
  P1 := PByte(P);
  P2 := PByte(P) + Count - 1;
  while P1 < P2 do
  begin
    C := P1^;
    P1^ := P2^;
    P2^ := C;
    System.inc(P1);
    System.dec(P2);
  end;
end;

procedure FillAlpha(Src: Pointer; Count: Integer; Alpha: Byte);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    PAlphaColorRecArray(Src)[I].A := Alpha;
end;

procedure FillLongword(Src: Pointer; Count: Integer; Value: longword);
var
  I: Integer;
  S: PAlphaColorArray;
begin
  if Value = 0 then
    FillChar(Src^, Count * 4, 0)
  else if Value = $FFFFFFFF then
    FillChar(Src^, Count * 4, $FF)
  else
  begin
    S := PAlphaColorArray(Src);
    for I := 0 to Count - 1 do
      S[I] := Value;
  end;
end;

procedure FillLongwordRect(Src: Pointer; W, H, X1, Y1, X2, Y2: Integer; Value: longword);
var
  j: Integer;
begin
  if X2 > W then
    X2 := W;
  if Y2 > H then
    Y2 := H;
  if X1 > X2 then
    X1 := X1;
  if Y1 > Y2 then
    Y1 := Y2;
  for j := Y1 to Y2 - 1 do
  begin
    if Value = 0 then
      FillChar(PAlphaColorArray(Src)[X1 + (j * W)], (X2 - X1) * 4, 0)
    else if Value = $FFFFFFFF then
      FillChar(PAlphaColorArray(Src)[X1 + (j * W)], (X2 - X1) * 4, $FF)
    else
      FillLongword(@PAlphaColorArray(Src)[X1 + (j * W)], X2 - X1, Value);
  end;
end;

{$EXCESSPRECISION OFF}

function RectToString(R: TRectF): string;
begin
  Result := '(' + FloatToStr(R.Left, USFormatSettings) + ',' + FloatToStr(R.Top, USFormatSettings) + ',' + FloatToStr(R.Right, USFormatSettings) + ',' +
    FloatToStr(R.Bottom, USFormatSettings) + ')';
end;

function StringToRect(S: string): TRectF;
begin
  try
    GetToken(S, ',()');
    Result.Left := StrToFloat(GetToken(S, ',()'), USFormatSettings);
    Result.Top := StrToFloat(GetToken(S, ',()'), USFormatSettings);
    Result.Right := StrToFloat(GetToken(S, ',()'), USFormatSettings);
    Result.Bottom := StrToFloat(GetToken(S, ',()'), USFormatSettings);
  except
    Result := RectF(0, 0, 0, 0);
  end;
end;

function PointToString(R: TPointF): string;
begin
  Result := '(' + FloatToStr(R.X, USFormatSettings) + ',' + FloatToStr(R.Y, USFormatSettings) + ')';
end;

function StringToPoint(S: string): TPointF;
begin
  try
    GetToken(S, ',()');
    Result.X := StrToFloat(GetToken(S, ',()'), USFormatSettings);
    Result.Y := StrToFloat(GetToken(S, ',()'), USFormatSettings);
  except
    Result := PointF(0, 0);
  end;
end;

function CornersF(const Pt1, Pt2, Pt3, Pt4: TPointF): TCornersF;
begin
  Result[0] := Pt1;
  Result[1] := Pt2;
  Result[2] := Pt3;
  Result[3] := Pt4;
end;

function CornersF(Left, Top, Width, Height: Single): TCornersF;
begin
  Result[0] := PointF(Left, Top);
  Result[1] := PointF(Left + Width, Top);
  Result[2] := PointF(Left + Width, Top + Height);
  Result[3] := PointF(Left, Top + Height);
end;

function CornersF(const Rect: TRectF): TCornersF;
begin
  Result[0] := PointF(Rect.Left, Rect.Top);
  Result[1] := PointF(Rect.Right, Rect.Top);
  Result[2] := PointF(Rect.Right, Rect.Bottom);
  Result[3] := PointF(Rect.Left, Rect.Bottom);
end;

function CornersF(const Rect: TRect): TCornersF;
begin
  Result[0] := PointF(Rect.Left, Rect.Top);
  Result[1] := PointF(Rect.Right, Rect.Top);
  Result[2] := PointF(Rect.Right, Rect.Bottom);
  Result[3] := PointF(Rect.Left, Rect.Bottom);
end;

function MatrixMultiply(const M1, M2: TMatrix): TMatrix;
begin
  Result.m11 := M1.m11 * M2.m11 + M1.m12 * M2.m21 + M1.m13 * M2.m31;
  Result.m12 := M1.m11 * M2.m12 + M1.m12 * M2.m22 + M1.m13 * M2.m32;
  Result.m13 := M1.m11 * M2.m13 + M1.m12 * M2.m23 + M1.m13 * M2.m33;
  Result.m21 := M1.m21 * M2.m11 + M1.m22 * M2.m21 + M1.m23 * M2.m31;
  Result.m22 := M1.m21 * M2.m12 + M1.m22 * M2.m22 + M1.m23 * M2.m32;
  Result.m23 := M1.m21 * M2.m13 + M1.m22 * M2.m23 + M1.m23 * M2.m33;
  Result.m31 := M1.m31 * M2.m11 + M1.m32 * M2.m21 + M1.m33 * M2.m31;
  Result.m32 := M1.m31 * M2.m12 + M1.m32 * M2.m22 + M1.m33 * M2.m32;
  Result.m33 := M1.m31 * M2.m13 + M1.m32 * M2.m23 + M1.m33 * M2.m33;
end;

function MatrixDeterminant(const M: TMatrix): Single;
begin
  Result := M.M[0].V[0] * (M.M[1].V[1] * M.M[2].V[2] - M.M[2].V[1] * M.M[1].V[2]) - M.M[0].V[1] *
    (M.M[1].V[0] * M.M[2].V[2] - M.M[2].V[0] * M.M[1].V[2]) + M.M[0].V[2] *
    (M.M[1].V[0] * M.M[2].V[1] - M.M[2].V[0] * M.M[1].V[1]);
end;

procedure AdjointMatrix(var M: TMatrix);
var
  a1, a2, a3, b1, b2, b3, c1, c2, c3: Single;
begin
  a1 := M.M[0].V[0];
  a2 := M.M[0].V[1];
  a3 := M.M[0].V[2];
  b1 := M.M[1].V[0];
  b2 := M.M[1].V[1];
  b3 := M.M[1].V[2];
  c1 := M.M[2].V[0];
  c2 := M.M[2].V[1];
  c3 := M.M[2].V[2];
  M.M[0].V[0] := (b2 * c3 - c2 * b3);
  M.M[1].V[0] := -(b1 * c3 - c1 * b3);
  M.M[2].V[0] := (b1 * c2 - c1 * b2);

  M.M[0].V[1] := -(a2 * c3 - c2 * a3);
  M.M[1].V[1] := (a1 * c3 - c1 * a3);
  M.M[2].V[1] := -(a1 * c2 - c1 * a2);

  M.M[0].V[2] := (a2 * b3 - b2 * a3);
  M.M[1].V[2] := -(a1 * b3 - b1 * a3);
  M.M[2].V[2] := (a1 * b2 - b1 * a2);
end;

procedure ScaleMatrix(var M: TMatrix; const factor: Single);
var
  I: Integer;
begin
  for I := 0 to 2 do
  begin
    M.M[I].V[0] := M.M[I].V[0] * factor;
    M.M[I].V[1] := M.M[I].V[1] * factor;
    M.M[I].V[2] := M.M[I].V[2] * factor;
  end;
end;

procedure InvertMatrix(var M: TMatrix);
var
  det: Single;
begin
  det := MatrixDeterminant(M);
  if Abs(det) < Epsilon then
    M := IdentityMatrix
  else
  begin
    AdjointMatrix(M);
    ScaleMatrix(M, 1 / det);
  end;
end;

function VectorAngleCosine(const v1, v2: TVector): Single;
begin
  if (v1.Length <> 0) and (v2.Length <> 0) then
  begin
    Result := v1.DotProduct(v2) / (v1.Length * v2.Length);
    if Result > 1 then
      Result := 1;
  end
  else
    Result := 0;
end;

function VectorCrossProductZ(const v1, v2: TVector): Single;
begin
  // 3D Cross with Z = 0
  Result := v1.X * v2.Y - v1.Y * v2.X;
end;

function VectorAngle(const V, N: TVector): Single;
begin
  if VectorCrossProductZ(V, N) < 0 then
    Result := RadToDeg(ArcCos(VectorAngleCosine(V, N)))
  else
    Result := -RadToDeg(ArcCos(VectorAngleCosine(V, N)));
end;

function CreateRotationMatrix(const Angle: Single): TMatrix;
var
  cosine, sine: Extended;
begin
  SinCos(Angle, sine, cosine);

  Result.m11 := cosine;
  Result.m12 := sine;
  Result.m13 := 0;
  Result.m21 := -sine;
  Result.m22 := cosine;
  Result.m23 := 0;

  Result.m31 := 0;
  Result.m32 := 0;
  Result.m33 := 1;
end;

function CreateScaleMatrix(const ScaleX, ScaleY: Single): TMatrix;
begin
  Result := IdentityMatrix;
  Result.m11 := ScaleX;
  Result.m22 := ScaleY;
end;

function CreateTranslateMatrix(const DX, DY: Single): TMatrix;
begin
  Result := IdentityMatrix;
  Result.m31 := DX;
  Result.m32 := DY;
end;

function InterpolateSingle(const Start, Stop, t: Single): Single;
begin
  Result := Start + (Stop - Start) * t;
end;

function InterpolateRotation(Start, Stop, t: Single): Single;
begin
  Result := InterpolateSingle(Start, Stop, t);
end;

function InterpolateColor(const Start, Stop: TAlphaColor; t: Single): TAlphaColor;
begin
  TAlphaColorRec(Result).A := TAlphaColorRec(Start).A + trunc((TAlphaColorRec(Stop).A - TAlphaColorRec(Start).A) * t);
  TAlphaColorRec(Result).R := TAlphaColorRec(Start).R + trunc((TAlphaColorRec(Stop).R - TAlphaColorRec(Start).R) * t);
  TAlphaColorRec(Result).G := TAlphaColorRec(Start).G + trunc((TAlphaColorRec(Stop).G - TAlphaColorRec(Start).G) * t);
  TAlphaColorRec(Result).B := TAlphaColorRec(Start).B + trunc((TAlphaColorRec(Stop).B - TAlphaColorRec(Start).B) * t);
end;

{ interpolations }

function InterpolateBack(t, B, C, D, S: Single; AType: TAnimationType): Single;
begin
  Result := 0;
  case AType of
    TAnimationType.atIn:
      begin
        if S = 0 then
          S := 1.70158;
        t := t / D;
        Result := C * t * t * ((S + 1) * t - S) + B;
      end;
    TAnimationType.atOut:
      begin
        if S = 0 then
          S := 1.70158;
        t := t / D - 1;
        Result := C * (t * t * ((S + 1) * t + S) + 1) + B;
      end;
    TAnimationType.atInOut:
      begin
        if S = 0 then
          S := 1.70158;
        t := t / (D / 2);
        if t < 1 then
        begin
          S := S * 1.525;
          Result := C / 2 * (t * t * ((S + 1) * t - S)) + B;
        end
        else
        begin
          t := t - 2;
          S := S * 1.525;
          Result := C / 2 * (t * t * ((S + 1) * t + S) + 2) + B;
        end;
      end;
  end;
end;

function InterpolateBounce(t, B, C, D: Single; AType: TAnimationType): Single;
  function _EaseOut(t, B, C, D: Single): Single;
  begin
    t := t / D;
    if t < 1 / 2.75 then
    begin
      Result := C * (7.5625 * t * t) + B;
    end
    else if t < 2 / 2.72 then
    begin
      t := t - (1.5 / 2.75);
      Result := C * (7.5625 * t * t + 0.75) + B;
    end
    else if t < 2.5 / 2.75 then
    begin
      t := t - (2.25 / 2.75);
      Result := C * (7.5625 * t * t + 0.9375) + B;
    end
    else
    begin
      t := t - (2.625 / 2.75);
      Result := C * (7.5625 * t * t + 0.984375) + B;
    end;
  end;
  function _EaseIn(t, B, C, D: Single): Single;
  begin
    Result := C - _EaseOut(D - t, 0, C, D) + B;
  end;

begin
  Result := 0;
  case AType of
    TAnimationType.atIn:
      begin
        Result := _EaseIn(t, B, C, D);
      end;
    TAnimationType.atOut:
      begin
        Result := _EaseOut(t, B, C, D);
      end;
    TAnimationType.atInOut:
      begin
        if t < D / 2 then
          Result := _EaseIn(t * 2, 0, C, D) * 0.5 + B
        else
          Result := _EaseOut(t * 2 - D, 0, C, D) * 0.5 + C * 0.5 + B;
      end;
  end;
end;

function InterpolateCirc(t, B, C, D: Single; AType: TAnimationType): Single;
begin
  Result := 0;
  case AType of
    TAnimationType.atIn:
      begin
        t := t / D;
        Result := -C * (Sqrt(1 - t * t) - 1) + B;
      end;
    TAnimationType.atOut:
      begin
        t := t / D - 1;
        Result := C * Sqrt(1 - t * t) + B;
      end;
    TAnimationType.atInOut:
      begin
        t := t / (D / 2);
        if t < 1 then
          Result := -C / 2 * (Sqrt(1 - t * t) - 1) + B
        else
        begin
          t := t - 2;
          Result := C / 2 * (Sqrt(1 - t * t) + 1) + B;
        end;
      end;
  end;
end;

function InterpolateCubic(t, B, C, D: Single; AType: TAnimationType): Single;
begin
  Result := 0;
  case AType of
    TAnimationType.atIn:
      begin
        t := t / D;
        Result := C * t * t * t + B;
      end;
    TAnimationType.atOut:
      begin
        t := t / D - 1;
        Result := C * (t * t * t + 1) + B;
      end;
    TAnimationType.atInOut:
      begin
        t := t / (D / 2);
        if t < 1 then
          Result := C / 2 * t * t * t + B
        else
        begin
          t := t - 2;
          Result := C / 2 * (t * t * t + 2) + B;
        end;
      end;
  end;
end;

function InterpolateElastic(t, B, C, D, A, P: Single; AType: TAnimationType): Single;
var
  S: Single;
begin
  Result := 0;
  case AType of
    TAnimationType.atIn:
      begin
        if t = 0 then
        begin
          Result := B;
          Exit;
        end;
        t := t / D;
        if t = 1 then
        begin
          Result := B + C;
          Exit;
        end;
        if P = 0 then
          P := D * 0.3;
        if (A = 0) or (A < Abs(C)) then
        begin
          A := C;
          S := P / 4;
        end
        else
        begin
          S := P / (2 * Pi) * ArcSin((C / A));
        end;
        t := t - 1;
        Result := -(A * Power(2, (10 * t)) * Sin((t * D - S) * (2 * Pi) / P)) + B;
      end;
    TAnimationType.atOut:
      begin
        if t = 0 then
        begin
          Result := B;
          Exit;
        end;
        t := t / D;
        if t = 1 then
        begin
          Result := B + C;
          Exit;
        end;
        if P = 0 then
          P := D * 0.3;
        if (A = 0) or (A < Abs(C)) then
        begin
          A := C;
          S := P / 4;
        end
        else
        begin
          S := P / (2 * Pi) * ArcSin((C / A));
        end;
        Result := A * Power(2, (-10 * t)) * Sin((t * D - S) * (2 * Pi) / P) + C + B;
      end;
    TAnimationType.atInOut:
      begin
        if t = 0 then
        begin
          Result := B;
          Exit;
        end;
        t := t / (D / 2);
        if t = 2 then
        begin
          Result := B + C;
          Exit;
        end;
        if P = 0 then
          P := D * (0.3 * 1.5);
        if (A = 0) or (A < Abs(C)) then
        begin
          A := C;
          S := P / 4;
        end
        else
        begin
          S := P / (2 * Pi) * ArcSin((C / A));
        end;

        if t < 1 then
        begin
          t := t - 1;
          Result := -0.5 * (A * Power(2, (10 * t)) * Sin((t * D - S) * (2 * Pi) / P)) + B;
        end
        else
        begin
          t := t - 1;
          Result := A * Power(2, (-10 * t)) * Sin((t * D - S) * (2 * Pi) / P) * 0.5 + C + B;
        end;
      end;
  end;
end;

function InterpolateExpo(t, B, C, D: Single; AType: TAnimationType): Single;
begin
  Result := 0;
  case AType of
    TAnimationType.atIn:
      begin
        If t = 0 Then
          Result := B
        else
          Result := C * Power(2, (10 * (t / D - 1))) + B;
      end;
    TAnimationType.atOut:
      begin
        If t = D then
          Result := B + C
        else
          Result := C * (-Power(2, (-10 * t / D)) + 1) + B;
      end;
    TAnimationType.atInOut:
      begin
        if t = 0 then
        begin
          Result := B;
          Exit;
        end;
        if t = D then
        begin
          Result := B + C;
          Exit;
        end;
        t := t / (D / 2);
        if t < 1 then
          Result := C / 2 * Power(2, (10 * (t - 1))) + B
        else
        begin
          t := t - 1;
          Result := C / 2 * (-Power(2, (-10 * t)) + 2) + B;
        end;
      end;
  end;
end;

function InterpolateLinear(t, B, C, D: Single): Single;
begin
  Result := C * t / D + B;
end;

function InterpolateQuad(t, B, C, D: Single; AType: TAnimationType): Single;
begin
  Result := 0;
  case AType of
    TAnimationType.atIn:
      begin
        t := t / D;
        Result := C * t * t + B;
      end;
    TAnimationType.atOut:
      begin
        t := t / D;
        Result := -C * t * (t - 2) + B;
      end;
    TAnimationType.atInOut:
      begin
        t := t / (D / 2);

        if t < 1 then
          Result := C / 2 * t * t + B
        else
        begin
          t := t - 1;
          Result := -C / 2 * (t * (t - 2) - 1) + B;
        end;
      end;
  end;
end;

function InterpolateQuart(t, B, C, D: Single; AType: TAnimationType): Single;
begin
  Result := 0;
  case AType of
    TAnimationType.atIn:
      begin
        t := t / D;
        Result := C * t * t * t * t + B;
      end;
    TAnimationType.atOut:
      begin
        t := t / D - 1;
        Result := -C * (t * t * t * t - 1) + B;
      end;
    TAnimationType.atInOut:
      begin
        t := t / (D / 2);
        if t < 1 then
          Result := C / 2 * t * t * t * t + B
        else
        begin
          t := t - 2;
          Result := -C / 2 * (t * t * t * t - 2) + B;
        end;
      end;
  end;
end;

function InterpolateQuint(t, B, C, D: Single; AType: TAnimationType): Single;
begin
  Result := 0;
  case AType of
    TAnimationType.atIn:
      begin
        t := t / D;
        Result := C * t * t * t * t * t + B;
      end;
    TAnimationType.atOut:
      begin
        t := t / D - 1;
        Result := C * (t * t * t * t * t + 1) + B;
      end;
    TAnimationType.atInOut:
      begin
        t := t / (D / 2);
        if t < 1 then
          Result := C / 2 * t * t * t * t * t + B
        else
        begin
          t := t - 2;
          Result := C / 2 * (t * t * t * t * t + 2) + B;
        end;
      end;
  end;
end;

function InterpolateSine(t, B, C, D: Single; AType: TAnimationType): Single;
begin
  Result := 0;
  case AType of
    TAnimationType.atIn:
      begin
        Result := -C * Cos(t / D * (Pi / 2)) + C + B;
      end;
    TAnimationType.atOut:
      begin
        Result := C * Sin(t / D * (Pi / 2)) + B;
      end;
    TAnimationType.atInOut:
      begin
        Result := -C / 2 * (Cos(Pi * t / D) - 1) + B;
      end;
  end;
end;

{$EXCESSPRECISION ON}

{ Spline }

{
  See: http://en.wikipedia.org/wiki/Cubic_Hermite_spline
}
function KochanekBartelsInterpolate(const Factor: Single; const Tangents: array of TTangentPair;
  const Values: array of Single; const Closed: Boolean = False): Single;
var
  h00, h10, h01, h11: Single;
  LFactor, LFactorSquared, LFactorCubed: Single;
  I, Ip1: Integer;
begin

  I := Trunc(Factor);
  LFactor := Factor - I;

  Ip1 := I + 1;

  if Ip1 >= Length(Values) then
    if Closed then
      Ip1 := Ip1 - Length(Values)
    else
      Ip1 := Length(Values) - 1;

  LFactorSquared := LFactor * LFactor;
  LFactorCubed := LFactorSquared * LFactor;

  h00 := (2 * LFactorCubed) - (3 * LFactorSquared) + 1;
  h10 := LFactorCubed - (2 * LFactorSquared) + LFactor;
  h01 := (-2 * LFactorCubed) + (3 * LFactorSquared);
  h11 := LFactorCubed - LFactorSquared;

  Result := (h00 * Values[I]) + (h10 * Tangents[I].I) + (h01 * Values[Ip1]) + (h11 * Tangents[I].Ip1);
end;

{
  See: http://en.wikipedia.org/wiki/Kochanek–Bartels_spline
}
procedure CalculateKochanekBartelsTangents(const Tension, Bias, Continuity: Single;
  const Values: array of Single; var Tangents: array of TTangentPair;
  const Closed: Boolean = False);
var
  I, Im1, Ip1, Ip2, LHigh: Integer;
begin
  LHigh := High(Values);
  for I := 0 to LHigh do
  begin
    Im1 := I - 1;
    if Im1 < 0 then
      if Closed then
        Im1 := LHigh
      else
        Im1 := 0;

    Ip1 := I + 1;
    if Ip1 > LHigh then
      if Closed then
        Ip1 := 0
      else
        Ip1 := LHigh;

    Ip2 := I + 2;
    if Ip2 > LHigh then
      if Closed then
        Ip2 := Ip2 - Length(Values)
      else
        Ip2 := LHigh;

    Tangents[I].I := 0.5 * (1 - Tension) * ((1 + Bias) * (1 + Continuity) * (Values[I] - Values[Im1])
      + (1 - Bias) * (1 - Continuity) * (Values[Ip1] - Values[I]));

    Tangents[I].Ip1 := 0.5 * (1 - Tension) * ((1 + Bias) * (1 - Continuity) * (Values[Ip1] - Values[I])
      + (1 - Bias) * (1 + Continuity) * (Values[Ip2] - Values[Ip1]));

  end;

end;

constructor TSpline.Create(const Polygon: TPolygon);
var
  I: Integer;
const
  Tension: Single = 0.0;
  Bias: Single = 0.0;
  Continuity: Single = 0.0;
begin
  inherited Create;
  SetLength(FValuesX, Length(Polygon));
  SetLength(FValuesY, Length(Polygon));
  SetLength(FTangentsX, Length(Polygon));
  SetLength(FTangentsY, Length(Polygon));
  for I := 0 to Length(Polygon) - 1 do
  begin
    FValuesX[I] := Polygon[I].X;
    FValuesY[I] := Polygon[I].Y;
  end;
  CalculateKochanekBartelsTangents(Tension, Bias, Continuity, FValuesX, FTangentsX);
  CalculateKochanekBartelsTangents(Tension, Bias, Continuity, FValuesY, FTangentsY);
end;

destructor TSpline.Destroy;
begin
  inherited;
end;

procedure TSpline.SplineXY(const t: Single; var X, Y: Single);
begin
  X := KochanekBartelsInterpolate(t, FTangentsX, FValuesX);
  Y := KochanekBartelsInterpolate(t, FTangentsY, FValuesY);
end;

{ TBounds }

constructor TBounds.Create(const ADefaultValue: TRectF);
begin
  inherited Create;
  FDefaultValue := ADefaultValue;
  Rect := FDefaultValue;
end;

procedure TBounds.Assign(Source: TPersistent);
begin
  if Source is TBounds then
    Rect := TBounds(Source).Rect
  else if not Assigned(Source) then
    Rect := FDefaultValue
  else
    inherited
end;

function TBounds.GetRect: TRectF;
begin
  Result.Create(FLeft, FTop, FRight, FBottom);
end;

procedure TBounds.SetRect(const Value: TRectF);
begin
  if Rect <> Value then
  begin
    FLeft := Value.Left;
    FTop := Value.Top;
    FRight := Value.Right;
    FBottom := Value.Bottom;
    if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

function TBounds.PaddingRect(const R: TRectF): TRectF;
begin
  Result.Create(R.Left + FLeft,
                R.Top + FTop,
                R.Right - FRight,
                R.Bottom - FBottom);
end;

function TBounds.MarginRect(const R: TRectF): TRectF;
begin
  Result.Create(R.Left - FLeft,
                R.Top - FTop,
                R.Right + FRight,
                R.Bottom + FBottom);
end;

function TBounds.Width: Single;
begin
  Result := Rect.Width;
end;

function TBounds.Height: Single;
begin
  Result := Rect.Height;
end;

function TBounds.IsBottomStored: Boolean;
begin
  Result := not SameValue(FBottom, FDefaultValue.Bottom, Epsilon) and not FStoreAsInt;
end;

function TBounds.IsLeftStored: Boolean;
begin
  Result := not SameValue(FLeft, FDefaultValue.Left, Epsilon) and not FStoreAsInt;
end;

function TBounds.IsRightStored: Boolean;
begin
  Result := not SameValue(FRight, FDefaultValue.Right, Epsilon) and not FStoreAsInt;
end;

function TBounds.IsTopStored: Boolean;
begin
  Result := not SameValue(FTop, FDefaultValue.Top, Epsilon) and not FStoreAsInt;
end;

function TBounds.MarginEmpty: Boolean;
begin
  Result := SameValue(FLeft, 0, Epsilon) and
            SameValue(FTop, 0, Epsilon) and
            SameValue(FRight, 0, Epsilon) and
            SameValue(FBottom, 0, Epsilon);
end;

function TBounds.Empty: Boolean;
begin
  Result := IsRectEmpty(Rect)
end;

function TBounds.Equals(Obj: TObject): Boolean;
begin
  if (Obj is TBounds) then
    Result := TBounds(Obj).Rect = Rect
  else
    Result := inherited;
end;

procedure TBounds.SetBottom(const Value: Single);
begin
  if not SameValue(FBottom, Value, Epsilon) then
  begin
    FBottom := Value;
    if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

procedure TBounds.SetLeft(const Value: Single);
begin
  if not SameValue(FLeft, Value, Epsilon) then
  begin
    FLeft := Value;
    if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

procedure TBounds.SetRight(const Value: Single);
begin
  if not SameValue(FRight, Value, Epsilon) then
  begin
    FRight := Value;
    if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

procedure TBounds.SetTop(const Value: Single);
begin
  if not SameValue(FTop, Value, Epsilon) then
  begin
    FTop := Value;
    if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

procedure TBounds.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Rect', ReadRect, nil, False);
  Filer.DefineProperty('RectI', ReadRectInt, nil, False);
  Filer.DefineProperty('LeftI', ReadLeftInt, WriteLeftInt, FStoreAsInt and not SameValue(FLeft, FDefaultValue.Left, Epsilon));
  Filer.DefineProperty('RightI', ReadRightInt, WriteRightInt, FStoreAsInt and not SameValue(FRight, FDefaultValue.Right, Epsilon));
  Filer.DefineProperty('TopI', ReadTopInt, WriteTopInt, FStoreAsInt and not SameValue(FTop, FDefaultValue.Top, Epsilon));
  Filer.DefineProperty('BottomI', ReadBottomInt, WriteBottomInt, FStoreAsInt and not SameValue(FBottom, FDefaultValue.Bottom, Epsilon));
end;

procedure TBounds.ReadLeftInt(Reader: TReader);
begin
  FLeft := Reader.ReadInteger;
  FStoreAsInt := True;
end;

procedure TBounds.ReadRightInt(Reader: TReader);
begin
  FRight := Reader.ReadInteger;
  FStoreAsInt := True;
end;

procedure TBounds.ReadTopInt(Reader: TReader);
begin
  FTop := Reader.ReadInteger;
  FStoreAsInt := True;
end;

procedure TBounds.ReadBottomInt(Reader: TReader);
begin
  FBottom := Reader.ReadInteger;
  FStoreAsInt := True;
end;

procedure TBounds.ReadRect(Reader: TReader);
begin
  Rect := StringToRect(Reader.ReadString);
end;

procedure TBounds.ReadRectInt(Reader: TReader);
begin
  Rect := StringToRect(Reader.ReadString);
  FStoreAsInt := True;
end;

procedure TBounds.WriteRect(Writer: TWriter);
begin
  Writer.WriteString(String(RectToString(Rect)));
end;

procedure TBounds.WriteLeftInt(Writer: TWriter);
begin
  Writer.WriteInteger(Trunc(FLeft));
end;

procedure TBounds.WriteRightInt(Writer: TWriter);
begin
  Writer.WriteInteger(Trunc(FRight));
end;

procedure TBounds.WriteTopInt(Writer: TWriter);
begin
  Writer.WriteInteger(Trunc(FTop));
end;

procedure TBounds.WriteBottomInt(Writer: TWriter);
begin
  Writer.WriteInteger(Trunc(FBottom));
end;

{ TPosition }

constructor TPosition.Create(const ADefaultValue: TPointF);
begin
  inherited Create;
  FDefaultValue := ADefaultValue;
  FX := FDefaultValue.X;
  FY := FDefaultValue.Y;
end;

procedure TPosition.Assign(Source: TPersistent);
begin
  if Source is TPosition then
  begin
    Point := TPosition(Source).Point;
  end
  else
    inherited
end;

procedure TPosition.SetPointNoChange(const P: TPointF);
begin
  FX := P.X;
  FY := P.Y;
end;

function TPosition.Empty: Boolean;
begin
  Result := (FX = 0) and (FY = 0);
end;

procedure TPosition.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Point', ReadPoint, WritePoint, False);
end;

procedure TPosition.ReadPoint(Reader: TReader);
begin
  Point := StringToPoint(Reader.ReadString);
end;

procedure TPosition.WritePoint(Writer: TWriter);
begin
  Writer.WriteString(String(PointToString(Point)));
end;

function TPosition.IsXStored: Boolean;
begin
  Result := not SameValue(FDefaultValue.X, FX, Epsilon);
end;

function TPosition.IsYStored: Boolean;
begin
  Result := not SameValue(FDefaultValue.Y, FY, Epsilon);
end;

function TPosition.GetVector: TVector;
begin
  Result := System.Types.Vector(FX, FY);
end;

procedure TPosition.SetVector(const Value: TVector);
begin
  Point := PointF(Value.X, Value.Y);
end;

procedure TPosition.Reflect(const Normal: TVector);
begin
  Vector := Vector.Reflect(Normal);
end;

function TPosition.GetPoint: TPointF;
begin
  Result := PointF(FX, FY);
end;

procedure TPosition.SetPoint(const Value: TPointF);
begin
  FX := Value.X;
  FY := Value.Y;
  if Assigned(OnChange) then
    OnChange(Self);
end;

procedure TPosition.SetX(const Value: Single);
begin
  if FX <> Value then
  begin
    FX := Value;
    if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

procedure TPosition.SetY(const Value: Single);
begin
  if FY <> Value then
  begin
    FY := Value;
    if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

{ TTransform }

constructor TTransform.Create;
begin
  inherited;
  FMatrix := IdentityMatrix;
  FPosition := TPosition.Create(PointF(0, 0));
  FPosition.OnChange := MatrixChanged;
  FScale := TPosition.Create(PointF(1, 1));
  FScale.OnChange := MatrixChanged;
  FSkew := TPosition.Create(PointF(0, 0));
  FSkew.OnChange := MatrixChanged;
  FRotationCenter := TPosition.Create(PointF(0.5, 0.5));
  FRotationCenter.OnChange := MatrixChanged;
end;

destructor TTransform.Destroy;
begin
  FRotationCenter.Free;
  FScale.Free;
  FSkew.Free;
  FPosition.Free;
  inherited;
end;

procedure TTransform.Assign(Source: TPersistent);
begin
  if Source is TTransform then
  begin
    FPosition.FX := TTransform(Source).Position.FX;
    FPosition.FY := TTransform(Source).Position.FY;
    FScale.FX := TTransform(Source).Scale.FX;
    FScale.FY := TTransform(Source).Scale.FY;
    FSkew.FX := TTransform(Source).Skew.FX;
    FSkew.FY := TTransform(Source).Skew.FY;
    FRotationCenter.FX := TTransform(Source).RotationCenter.FX;
    FRotationCenter.FY := TTransform(Source).RotationCenter.FY;
    MatrixChanged(Self);
  end
  else
    inherited
end;

procedure TTransform.MatrixChanged(Sender: TObject);
begin
  FMatrix := IdentityMatrix;
  FMatrix.m31 := FPosition.X;
  FMatrix.m32 := FPosition.Y;
  FMatrix.m13 := FSkew.X;
  FMatrix.m23 := FSkew.Y;
  FMatrix.m11 := FScale.X;
  FMatrix.m22 := FScale.Y;
  if FRotationAngle <> 0 then
    FMatrix := MatrixMultiply(CreateRotationMatrix(DegToRad(FRotationAngle)), FMatrix);
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

procedure TTransform.SetPosition(const Value: TPosition);
begin
  FPosition.Assign(Value);
end;

procedure TTransform.SetRotationAngle(const Value: Single);
begin
  if FRotationAngle <> Value then
  begin
    FRotationAngle := Value;
  end;
end;

procedure TTransform.SetScale(const Value: TPosition);
begin
  FScale.Assign(Value);
end;

{ TGradientPoint }

procedure TGradientPoint.Assign(Source: TPersistent);
begin
  if Source is TGradientPoint then
  begin
    FColor := TGradientPoint(Source).FColor;
    FOffset := TGradientPoint(Source).FOffset;
  end
  else
    inherited;
end;

function TGradientPoint.GetColor: TAlphaColor;
begin
  Result := FColor;
end;

procedure TGradientPoint.SetColor(const Value: TAlphaColor);
begin
  FColor := Value;
end;

{ TGradientPoints }

function TGradientPoints.GetPoint(Index: Integer): TGradientPoint;
begin
  Result := TGradientPoint(Items[Index]);
end;

{ TGradient }

constructor TGradient.Create;
var
  P: TGradientPoint;
begin
  inherited;
  FStartPosition := TPosition.Create(PointF(0, 0));
  FStartPosition.OnChange := PositionChanged;
  FStopPosition := TPosition.Create(PointF(0, 1));
  FStopPosition.OnChange := PositionChanged;
  FRadialTransform := TTransform.Create;
  FRadialTransform.OnChanged := PositionChanged;
  FPoints := TGradientPoints.Create(TGradientPoint);
  P := TGradientPoint(FPoints.Add);
  P.IntColor := $FF000000;
  P := TGradientPoint(FPoints.Add);
  P.IntColor := $FFFFFFFF;
  P.Offset := 1;
end;

procedure TGradient.Assign(Source: TPersistent);
var
  SaveChanged: TNotifyEvent;
begin
  if Source is TGradient then
  begin
    SaveChanged := FOnChanged;
    FOnChanged := nil;
    FPoints.Clear;
    FPoints.Assign(TGradient(Source).FPoints);
    FStyle := TGradient(Source).Style;
    if FStyle = TGradientStyle.gsLinear then
    begin
      FStopPosition.Assign(TGradient(Source).StopPosition);
      FStartPosition.Assign(TGradient(Source).StartPosition);
    end
    else
    begin
      FRadialTransform.Assign(TGradient(Source).RadialTransform);
    end;
    FOnChanged := SaveChanged;
    if Assigned(FOnChanged) then
      FOnChanged(Self);
  end
  else
    inherited;
end;

destructor TGradient.Destroy;
begin
  FStartPosition.Free;
  FStopPosition.Free;
  FRadialTransform.Free;
  FPoints.Free;
  inherited;
end;

function TGradient.Equal(const AGradient: TGradient): Boolean;
var
  I: Integer;
begin
  Result := True;
  if FPoints.Count <> AGradient.FPoints.Count then Exit(False);
  if not SameValue(FStartPosition.X, AGradient.FStartPosition.X, Epsilon) then Exit(False);
  if not SameValue(FStartPosition.Y, AGradient.FStartPosition.Y, Epsilon) then Exit(False);
  if not SameValue(FStopPosition.X, AGradient.FStopPosition.X, Epsilon) then Exit(False);
  if not SameValue(FStopPosition.Y, AGradient.FStopPosition.Y, Epsilon) then Exit(False);
  for I := 0 to FPoints.Count - 1 do
  begin
    if FPoints[I].Color <> AGradient.FPoints[I].Color then Exit(False);
    if not SameValue(FPoints[I].Offset, AGradient.FPoints[I].Offset, Epsilon) then Exit(False);
  end;
end;

procedure TGradient.Change;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

function TGradient.InterpolateColor(X, Y: Single): TAlphaColor;
var
  A, B: TVector;
  Projection: Single;
begin
  case Style of
    TGradientStyle.gsLinear: begin
      A := (StopPosition.Vector - StartPosition.Vector);
      B := Vector(X, Y) - StartPosition.Vector;
      Projection := A.Normalize.DotProduct(B) / A.Length;
      Result := InterpolateColor(Projection);
    end;
    TGradientStyle.gsRadial: begin
      A := Vector(X, Y) - RadialTransform.RotationCenter.Vector;
      Result := InterpolateColor(1 - (A.Length * 2));
    end;
  else
    Result := 0;
  end;
end;

function TGradient.InterpolateColor(Offset: Single): TAlphaColor;
var
  I: Integer;
begin
  Result := 0;
  if FPoints.Count > 1 then
  begin
    if Offset < 0 then
      Offset := 0;
    if Offset > 1 then
      Offset := 1;
    if Offset < FPoints[0].Offset then
    begin
      Result := Points[0].IntColor;
      Exit;
    end;
    if Offset > FPoints[FPoints.Count - 1].Offset then
    begin
      Result := FPoints[FPoints.Count - 1].IntColor;
      Exit;
    end;
    for I := 0 to FPoints.Count - 2 do
    begin
      if (Offset < Points[I].Offset) then
        Continue;
      if Offset > Points[I + 1].Offset then
        Continue;
      if Points[I + 1].Offset - Points[I].Offset <= 0 then
        Result := Points[I].IntColor
      else if (I = FPoints.Count - 2) and (Offset > Points[Points.Count - 1].Offset) then // last
        Result := Points[Points.Count - 1].IntColor
      else
        Result := FMX.Types.InterpolateColor(Points[I].IntColor, Points[I + 1].IntColor,
          (Offset - Points[I].Offset) / (Points[I + 1].Offset - Points[I].Offset));
    end;
  end;
end;

procedure TGradient.PositionChanged(Sender: TObject);
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

function TGradient.IsLinearStored: Boolean;
begin
  Result := FStyle = TGradientStyle.gsLinear;
end;

function TGradient.IsRadialStored: Boolean;
begin
  Result := FStyle = TGradientStyle.gsRadial;
end;

procedure TGradient.SetRadialTransform(const Value: TTransform);
begin
  FRadialTransform.Assign(Value);
end;

procedure TGradient.SetStartPosition(const Value: TPosition);
begin
  FStartPosition.Assign(Value);
end;

procedure TGradient.SetStopPosition(const Value: TPosition);
begin
  FStopPosition.Assign(Value);
end;

procedure TGradient.SetColor(const Value: TAlphaColor);
begin
  if (FPoints.Count > 0) and (Points[0].Color <> Value) then
  begin
    Points[0].Color := Value;
    if Assigned(FOnChanged) then
      FOnChanged(Self);
  end;
end;

procedure TGradient.SetColor1(const Value: TAlphaColor);
begin
  if (FPoints.Count > 1) and (Points[1].Color <> Value) then
  begin
    Points[1].Color := Value;
    if Assigned(FOnChanged) then
      FOnChanged(Self);
  end;
end;

procedure TGradient.SetStyle(const Value: TGradientStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    if Assigned(FOnChanged) then
      FOnChanged(Self);
  end;
end;

{ TBrushResource }

destructor TBrushResource.Destroy;
begin
  if Assigned(FStyleResource) then
  begin
    FStyleResource.RemoveFreeNotify(Self);
    FStyleResource := nil;
  end;
  inherited;
end;

procedure TBrushResource.FreeNotification(AObject: TObject);
begin
  if AObject = FStyleResource then
    FStyleResource := nil;
end;

procedure TBrushResource.Assign(Source: TPersistent);
begin
  if Source is TBrushResource then
  begin
    StyleResource := TBrushResource(Source).StyleResource;
    FStyleLookup := TBrushResource(Source).StyleLookup;
  end
  else
    inherited;
end;

procedure TBrushResource.SetStyleResource(const Value: TBrushObject);
begin
  if FStyleResource <> Value then
  begin
    if Assigned(FStyleResource) then
      FStyleResource.RemoveFreeNotify(Self);
    FStyleResource := Value;
    if Assigned(FStyleResource) then
    begin
      FStyleLookup := FStyleResource.StyleName;
      FStyleResource.AddFreeNotify(Self);
    end;
  end;
end;

function TBrushResource.GetStyleLookup: string;
begin
  Result := FStyleLookup;
end;

procedure TBrushResource.SetStyleLookup(const Value: string);
begin
  if Value <> FStyleLookup then
  begin
    FStyleLookup := Value;
  end;
end;

function TBrushResource.GetBrush: TBrush;
var
  O: TFmxObject;
begin
  Result := nil;
  if Assigned(FStyleResource) then
  begin
    Result := TBrushObject(FStyleResource).Brush;
  end
  else if FStyleLookup <> '' then
  begin
    O := FindStyleResource(FStyleLookup);
    if O is TBrushObject then
      StyleResource := TBrushObject(O);
    if Assigned(FStyleResource) then
      Result := TBrushObject(FStyleResource).Brush;
  end;
end;

{ TBrushBitmap }

constructor TBrushBitmap.Create;
begin
  inherited Create;
  FBitmap := TBitmap.Create(0, 0);
end;

destructor TBrushBitmap.Destroy;
begin
  FBitmap.DisposeOf;
  inherited;
end;

procedure TBrushBitmap.DoChanged;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

procedure TBrushBitmap.Assign(Source: TPersistent);
begin
  if Source is TBrushBitmap then
  begin
    FWrapMode := TBrushBitmap(Source).FWrapMode;
    FBitmap.Assign(TBrushBitmap(Source).FBitmap);
    DoChanged;
  end
  else
    inherited;
end;

procedure TBrushBitmap.SetWrapMode(const Value: TWrapMode);
begin
  if FWrapMode <> Value then
  begin
    FWrapMode := Value;
    DoChanged;
  end;
end;

procedure TBrushBitmap.SetBitmap(const Value: TBitmap);
begin
  FBitmap.Assign(Value);
  DoChanged;
end;

{ TBrush }

constructor TBrush.Create;
begin
  inherited Create;
  FDefaultKind := ADefaultKind;
  FDefaultColor := ADefaultColor;
  FColor := ADefaultColor;
  FKind := FDefaultKind;
  FGradient := TGradient.Create;
  FGradient.OnChanged := GradientChanged;
  FResource := TBrushResource.Create;
  FResource.OnChanged := ResourceChanged;
  FBitmap := TBrushBitmap.Create;
  FBitmap.OnChanged := BitmapChanged;
  FBitmap.Bitmap.OnChange := BitmapChanged;
end;

destructor TBrush.Destroy;
begin
  FBitmap.DisposeOf;
  FResource.DisposeOf;
  FGradient.DisposeOf;
  inherited;
end;

procedure TBrush.Assign(Source: TPersistent);
var
  SaveChange: TNotifyEvent;
begin
  if Source is TBrush then
  begin
    SaveChange := FOnChanged;
    FOnChanged := nil;
    FDefaultKind := TBrush(Source).FDefaultKind;
    FDefaultColor := TBrush(Source).FDefaultColor;
    FColor := TBrush(Source).FColor;
    FKind := TBrush(Source).FKind;
    case FKind of
      TBrushKind.bkGradient:
        FGradient.Assign(TBrush(Source).Gradient);
      TBrushKind.bkResource:
        FResource.Assign(TBrush(Source).Resource);
      TBrushKind.bkBitmap:
        FBitmap.Assign(TBrush(Source).Bitmap);
    end;
    FOnChanged := SaveChange;
    if Assigned(FOnChanged) then
      FOnChanged(Self);
  end
  else
    inherited;
end;

procedure TBrush.GradientChanged(Sender: TObject);
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
  if Assigned(FOnGradientChanged) then
    FOnGradientChanged(Self);
end;

procedure TBrush.ResourceChanged(Sender: TObject);
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

procedure TBrush.BitmapChanged(Sender: TObject);
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

function TBrush.IsBitmapStored: Boolean;
begin
  Result := (FKind = TBrushKind.bkBitmap);
end;

function TBrush.IsColorStored: Boolean;
begin
  Result := (FKind = TBrushKind.bkSolid) and (FColor <> FDefaultColor);
end;

function TBrush.IsGradientStored: Boolean;
begin
  Result := FKind = TBrushKind.bkGradient;
end;

function TBrush.IsKindStored: Boolean;
begin
  Result := FKind <> FDefaultKind;
end;

function TBrush.IsResourceStored: Boolean;
begin
  Result := FKind = TBrushKind.bkResource;
end;

procedure TBrush.SetResource(const Value: TBrushResource);
begin
  FResource.Assign(Value);
end;

procedure TBrush.SetGradient(const Value: TGradient);
begin
  FGradient.Assign(Value);
end;

function TBrush.GetColor: TAlphaColor;
begin
  Result := FColor;
end;

procedure TBrush.SetColor(const Value: TAlphaColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    if FKind = TBrushKind.bkGradient then
      FGradient.Color := Value
    else if Assigned(FOnChanged) then
      FOnChanged(Self);
  end;
end;

procedure TBrush.SetKind(const Value: TBrushKind);
begin
  if FKind <> Value then
  begin
    FKind := Value;
    if Assigned(FOnChanged) then
      FOnChanged(Self);
  end;
end;

{ TStrokeBrush }

constructor TStrokeBrush.Create(const ADefaultKind: TBrushKind;
  const ADefaultColor: TAlphaColor);
begin
  inherited;
  FThickness := 1;
end;

function TStrokeBrush.GetDashArray: TDashArray;
begin
  Result := Copy(FDashArray);
end;

class function TStrokeBrush.GetStdDash(const Device: TDashDevice;
  const Dash: TStrokeDash): TDashData;
begin
  if not FStdDashCreated then
  begin
    // create the screen line dashes
    FStdDash[TDashDevice.ddScreen, TStrokeDash.sdSolid] :=
      TDashData.Create(nil, 0);
    FStdDash[TDashDevice.ddScreen, TStrokeDash.sdDash] :=
      TDashData.Create(TDashArray.Create(3, 1), 0);
    FStdDash[TDashDevice.ddScreen, TStrokeDash.sdDot] :=
      TDashData.Create(TDashArray.Create(1, 1), 0);
    FStdDash[TDashDevice.ddScreen, TStrokeDash.sdDashDot] :=
      TDashData.Create(TDashArray.Create(3, 1, 1, 1), 0);
    FStdDash[TDashDevice.ddScreen, TStrokeDash.sdDashDotDot] :=
      TDashData.Create(TDashArray.Create(3, 1, 1, 1, 1, 1), 0);
    FStdDash[TDashDevice.ddScreen, TStrokeDash.sdCustom] :=
      TDashData.Create(nil, 0);

    // create the printer line dashes
  {$IFDEF MACOS}
    // MacOS dashes work strange; these values are experimental values that
    // seem to work correctly
    FStdDash[TDashDevice.ddPrinter, TStrokeDash.sdSolid] :=
      TDashData.Create(nil, 0);
    FStdDash[TDashDevice.ddPrinter, TStrokeDash.sdDash] :=
      TDashData.Create(TDashArray.Create(3 * 2, 6 * 2), 0);
    FStdDash[TDashDevice.ddPrinter, TStrokeDash.sdDot] :=
      TDashData.Create(TDashArray.Create(1 * 2, 3 * 2), 0);
    FStdDash[TDashDevice.ddPrinter, TStrokeDash.sdDashDot] :=
      TDashData.Create(TDashArray.Create(3 * 3, 6 * 3, 1 * 3, 3 * 3), 0);
    FStdDash[TDashDevice.ddPrinter, TStrokeDash.sdDashDotDot] :=
      TDashData.Create(TDashArray.Create(3 * 2, 9 * 2, 1 * 2, 3 * 2, 1 * 2, 3 * 2), 0);
    FStdDash[TDashDevice.ddPrinter, TStrokeDash.sdCustom] :=
      TDashData.Create(nil, 0);
  {$ELSE}
    FStdDash[TDashDevice.ddPrinter] := FStdDash[TDashDevice.ddScreen];
  {$ENDIF}

    FStdDashCreated := True;
  end;

  Result.DashArray := Copy(FStdDash[Device, Dash].DashArray);
  Result.DashOffset := FStdDash[Device, Dash].DashOffset;
end;

procedure TStrokeBrush.Assign(Source: TPersistent);
var
  SaveChange: TNotifyEvent;
begin
  if Source is TStrokeBrush then
  begin
    SaveChange := FOnChanged;
    FOnChanged := nil;

    FDefaultKind := TStrokeBrush(Source).FDefaultKind;
    FDefaultColor := TStrokeBrush(Source).FDefaultColor;
    FColor := TStrokeBrush(Source).Color;
    FKind := TstrokeBrush(Source).Kind;
    case FKind of
      TBrushKind.bkGradient:
        FGradient.Assign(TStrokeBrush(Source).Gradient);
      TBrushKind.bkResource:
        FResource.Assign(TStrokeBrush(Source).Resource);
      TBrushKind.bkBitmap:
        FBitmap.Assign(TStrokeBrush(Source).Bitmap);
    end;

    FThickness := TStrokeBrush(Source).Thickness;
    FCap := TStrokeBrush(Source).Cap;
    FDash := TStrokeBrush(Source).Dash;
    FJoin := TStrokeBrush(Source).Join;
    FDashArray := Copy(TStrokeBrush(Source).FDashArray);
    FDashOffset := TStrokeBrush(Source).FDashOffset;
    FOnChanged := SaveChange;
    if Assigned(FOnChanged) then
      FOnChanged(Self);
  end
  else
    inherited;
end;

procedure TStrokeBrush.SetCustomDash(const Dash: array of Single; Offset: Single);
var
  I: Integer;
begin
  FDash := TStrokeDash.sdCustom;
  SetLength(FDashArray, Length(Dash));
  for I := 0 to High(Dash) do
    FDashArray[I] := Dash[I];
  FDashOffset := Offset;
end;

function TStrokeBrush.IsThicknessStored: Boolean;
begin
  Result := Thickness <> 1;
end;

procedure TStrokeBrush.SetCap(const Value: TStrokeCap);
begin
  if FCap <> Value then
  begin
    FCap := Value;
    if Assigned(FOnChanged) then
      FOnChanged(Self);
  end;
end;

procedure TStrokeBrush.SetDash(const Value: TStrokeDash);
begin
  if FDash <> Value then
  begin
    FDash := Value;
    case FDash of
      TStrokeDash.sdSolid:
        begin
          FDashOffset := 0;
          SetLength(FDashArray, 0);
        end;
      TStrokeDash.sdDash:
        begin
          FDashOffset := 0;
          SetLength(FDashArray, 2);
          FDashArray[0] := 1 * 3;
          FDashArray[1] := 1;
        end;
      TStrokeDash.sdDot:
        begin
          FDashOffset := 0;
          SetLength(FDashArray, 2);
          FDashArray[0] := 1;
          FDashArray[1] := 1;
        end;
      TStrokeDash.sdDashDot:
        begin
          FDashOffset := 0;
          SetLength(FDashArray, 4);
          FDashArray[0] := 1 * 3;
          FDashArray[1] := 1;
          FDashArray[2] := 1;
          FDashArray[3] := 1;
        end;
      TStrokeDash.sdDashDotDot:
        begin
          FDashOffset := 0;
          SetLength(FDashArray, 6);
          FDashArray[0] := 1 * 3;
          FDashArray[1] := 1;
          FDashArray[2] := 1;
          FDashArray[3] := 1;
          FDashArray[4] := 1;
          FDashArray[5] := 1;
        end;
      TStrokeDash.sdCustom:
        ;
    else
      FDashOffset := 0;
      SetLength(FDashArray, 0);
    end;
    if Assigned(FOnChanged) then
      FOnChanged(Self);
  end;
end;

procedure TStrokeBrush.SetJoin(const Value: TStrokeJoin);
begin
  if FJoin <> Value then
  begin
    FJoin := Value;
    if Assigned(FOnChanged) then
      FOnChanged(Self);
  end;
end;

procedure TStrokeBrush.SetThickness(const Value: Single);
begin
  if FThickness <> Value then
  begin
    FThickness := Value;
    if Assigned(FOnChanged) then
      FOnChanged(Self);
  end;
end;

{ TFont }

constructor TFont.Create;
begin
  inherited;
  FUpdating := True;
  try
    Assign(nil);
  finally
    FUpdating := False;
  end;
end;

procedure TFont.DoChanged;
begin
  if (not FUpdating) and Assigned(FOnChanged) then
    FOnChanged(Self);
end;

function TFont.Equals(Obj: TObject): Boolean;
begin
  Result := (Obj is TFont) and
            (SameValue(Size, TFont(Obj).Size, Epsilon)) and
            (Family = TFont(Obj).Family) and
            (Style = TFont(Obj).Style);
end;

function TFont.DefaultFamily: string;
var
  FontSvc: IFMXSystemFontService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXSystemFontService, IInterface(FontSvc)) then
    Result := FontSvc.GetDefaultFontFamilyName
  else
    Result := DefaultFontFamily;
end;

procedure TFont.Assign(Source: TPersistent);
var LFamily: string;
    LSize: single;
    LStyle: TFontStyles;
begin
  if (Source is TFont) or (not Assigned(Source)) then
  begin
    if Assigned(Source) then
    begin
      LFamily := TFont(Source).Family;
      LSize := TFont(Source).Size;
      LStyle := TFont(Source).Style;
    end
    else
    begin
      LFamily := DefaultFamily;
      LSize := DefaultFontSize;
      LStyle := [];
    end;
    if (FFamily <> LFamily) or
       (not SameValue(FSize, LSize, Epsilon)) or
       (FStyle <> LStyle) then
    begin
      FFamily := LFamily;
      FSize := LSize;
      FStyle := LStyle;
      DoChanged;
    end;
  end
  else
    inherited;
end;

function TFont.IsSizeStored: Boolean;
begin
  Result := not SameValue(FSize, DefaultFontSize, Epsilon);
end;

function TFont.IsFamilyStored: Boolean;
begin
  Result := FFamily <> DefaultFamily;
end;

procedure TFont.SetFamily(const Value: TFontName);
begin
  if FFamily <> Value then
  begin
    FFamily := Value;
    DoChanged;
  end;
end;

procedure TFont.SetSettings(const AFamily: string; const ASize: Single; const AStyle: TFontStyles);
begin
  FFamily := AFamily;
  FSize := Max(1, ASize);
  FStyle := AStyle;
  DoChanged;
end;

procedure TFont.SetSize(const Value: Single);
var LSize: Single;
begin
  LSize := Max(1, Value);
  if FSize <> LSize then
  begin
    FSize := LSize;
    DoChanged;
  end;
end;

procedure TFont.SetStyle(const Value: TFontStyles);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    DoChanged;
  end;
end;

{ TTextSettings }

type
  TSettingsFont = class (TFont)
  private
    FTextSettings: TTextSettings;
  protected
    procedure DoChanged; override;
  public
    constructor Create(const ATextSettings: TTextSettings);
    property TextSettings: TTextSettings read FTextSettings;
  end;

{ TSettingsFont }

constructor TSettingsFont.Create(const ATextSettings: TTextSettings);
begin
  inherited Create;
  FTextSettings := ATextSettings;
end;

procedure TSettingsFont.DoChanged;
begin
  if Assigned(FTextSettings) then
  begin
    FTextSettings.IsAdjustChanged := True;
    FTextSettings.Change;
  end;
  inherited;
end;

constructor TTextSettings.Create(const AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
  BeginUpdate;
  try
    Assign(nil);
  finally
    FIsChanged := False;
    FIsAdjustChanged := False;
    EndUpdate;
  end;
end;

destructor TTextSettings.Destroy;
begin
  TSettingsFont(FFont).FTextSettings := nil;
  FreeAndNil(FFont);
  inherited;
end;

procedure TTextSettings.Assign(Source: TPersistent);
begin
  if (not Assigned(Source)) or (Source is TTextSettings) then
  begin
    BeginUpdate;
    try
      if not Assigned(Source) then
      begin
        FreeAndNil(FFont);
        FFont := TSettingsFont.Create(self);
        FontColor := TAlphaColorRec.Black;
        HorzAlign := TTextAlign.taLeading;
        VertAlign := TTextAlign.taCenter;
        Trimming := TTextTrimming.ttNone;
        WordWrap := False;
      end
      else
      begin
        FFont.Assign(TTextSettings(Source).Font);
        FontColor := TTextSettings(Source).FontColor;
        HorzAlign := TTextSettings(Source).HorzAlign;
        VertAlign := TTextSettings(Source).VertAlign;
        WordWrap := TTextSettings(Source).WordWrap;
        Trimming := TTextSettings(Source).Trimming;
      end;
    finally
      EndUpdate;
    end;
  end
  else
    inherited;
end;

function TTextSettings.Equals(Obj: TObject): Boolean;
var Source: TTextSettings;
begin
  Result := Obj is TTextSettings;
  if Result then
  begin
    Source := TTextSettings(Obj);
    Result := (HorzAlign = Source.HorzAlign) and
              (VertAlign = Source.VertAlign) and
              (WordWrap = Source.WordWrap) and
              (FontColor = Source.FontColor) and
              (Trimming = Source.Trimming) and
              (((Font = nil) and (Source.Font = nil)) or
               (Assigned(Font) and Font.Equals(Source.Font)));
  end;
end;

function TTextSettings.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TTextSettings.AssignNoStyled(const TextSettings: TTextSettings;
                                       const StyledSettings: TStyledSettings);
var Tmp: TTextSettings;
begin
  if StyledSettings <> AllStyledSettings then
  begin
    if StyledSettings = [] then
      Assign(TextSettings)
    else
    begin
      if Assigned(TextSettings) then
        Tmp := TextSettings
      else
        Tmp := TTextSettings.Create(nil);
      try
        BeginUpdate;
        try
          if not (TStyledSetting.ssFamily in StyledSettings) then
            Font.Family := Tmp.Font.FFamily;
          if not (TStyledSetting.ssSize in StyledSettings) then
            Font.Size := Tmp.Font.Size;
          if not (TStyledSetting.ssStyle in StyledSettings) then
            Font.Style := Tmp.Font.Style;
          if not (TStyledSetting.ssFontColor in StyledSettings) then
            FontColor := Tmp.FontColor;
          if not (TStyledSetting.ssOther in StyledSettings) then
          begin
            HorzAlign := Tmp.HorzAlign;
            VertAlign := Tmp.VertAlign;
            WordWrap := Tmp.WordWrap;
            Trimming := Tmp.Trimming;
          end;
        finally
          EndUpdate;
        end;
      finally
        if not Assigned(TextSettings) then
          FreeAndNil(Tmp);
      end;
    end;
  end;
end;

procedure TTextSettings.BeginUpdate;
begin
  inc(FUpdateCount);
end;

procedure TTextSettings.EndUpdate;
begin
  if FUpdateCount > 0 then
  begin
    Dec(FUpdateCount);
    if (FUpdateCount = 0) and (FIsChanged or FIsAdjustChanged) then
    begin
      try
        DoChanged;
      finally
        FIsChanged := False;
        FIsAdjustChanged := False;
      end;
    end;
  end;
end;

procedure TTextSettings.Change;
begin
  FIsChanged := True;
  if (FUpdateCount = 0) then
  begin
    try
      DoChanged;
    finally
      FIsChanged := False;
      FIsAdjustChanged := False;
    end;
  end;
end;

procedure TTextSettings.DoChanged;
begin
  if Assigned(OnChanged) then
    OnChanged(self);
end;

procedure TTextSettings.SetFont(const Value: TFont);
begin
  if not (((Font = nil) and (Value = nil)) or
          ((Assigned(Font) and Font.Equals(Value)))) then
  begin
    Font.Assign(Value);
    IsAdjustChanged := True;
    Change;
  end;
end;

procedure TTextSettings.SetFontColor(const Value: TAlphaColor);
begin
  if FFontColor <> Value then
  begin
    FFontColor := Value;
    Change;
  end;
end;

procedure TTextSettings.SetHorzAlign(const Value: TTextAlign);
begin
  if FHorzAlign <> Value then
  begin
    FHorzAlign := Value;
    IsAdjustChanged := True;
    Change;
  end;
end;

procedure TTextSettings.SetVertAlign(const Value: TTextAlign);
begin
  if FVertAlign <> Value then
  begin
    FVertAlign := Value;
    IsAdjustChanged := True;
    Change;
  end;
end;

procedure TTextSettings.SetTrimming(const Value: TTextTrimming);
begin
  if FTrimming <> Value then
  begin
    FTrimming := Value;
    IsAdjustChanged := True;
    Change;
  end;
end;

procedure TTextSettings.SetWordWrap(const Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    IsAdjustChanged := True;
    Change;
  end;
end;

{ TBitmapCodecManager }

class procedure TBitmapCodecManager.UnInitialize;
begin
  FreeAndNil(FBitmapCodecClassDescriptors);
end;

class function TBitmapCodecManager.FindBitmapCodecDescriptor(const Name: string;
  const Field: TBitmapCodecDescriptorField): TBitmapCodecClassDescriptor;
var
  LResult: Boolean;
  LDescriptor: TBitmapCodecClassDescriptor;
begin
  FillChar(Result, SizeOf(Result), 0);
  if Assigned(FBitmapCodecClassDescriptors) then
    for LDescriptor in FBitmapCodecClassDescriptors do
    begin
      case Field of
        TBitmapCodecDescriptorField.Extension: LResult := SameText(Name, LDescriptor.Extension, loUserLocale);
        TBitmapCodecDescriptorField.Description: LResult := SameText(Name, LDescriptor.Description, loUserLocale);
      else
        LResult := False;
      end;
      if LResult then
        Result := LDescriptor;
    end;
end;

class procedure TBitmapCodecManager.RegisterBitmapCodecClass(const Extension, Description: string; const CanSave: Boolean;
  const BitmapCodecClass: TCustomBitmapCodecClass);
var
  LDescriptor: TBitmapCodecClassDescriptor;
begin
  if Not Assigned(FBitmapCodecClassDescriptors) then
    FBitmapCodecClassDescriptors := TList<TBitmapCodecClassDescriptor>.Create;

  LDescriptor.Extension := Extension;
  LDescriptor.Description := Description;
  LDescriptor.BitmapCodecClass := BitmapCodecClass;
  LDescriptor.CanSave := CanSave;
  FBitmapCodecClassDescriptors.Add(LDescriptor);
end;

class function TBitmapCodecManager.IsCodedExists(const AFileName: string): Boolean;
begin
  Result := Assigned(FindBitmapCodecDescriptor(ExtractFileExt(AFileName), TBitmapCodecDescriptorField.Extension).BitmapCodecClass);
end;

class function TBitmapCodecManager.GetFileTypes: string;
var
  Descriptor: TBitmapCodecClassDescriptor;
begin
  Result := '';
  if Assigned(FBitmapCodecClassDescriptors) then
    for Descriptor in FBitmapCodecClassDescriptors do
      if Result = '' then
        Result := '*' + Descriptor.Extension
      else
        Result := Result + ';' + '*' + Descriptor.Extension;
end;

class function TBitmapCodecManager.GetFilterString: string;
var
  Descriptor: TBitmapCodecClassDescriptor;
begin
  Result := '';
  if Assigned(FBitmapCodecClassDescriptors) then
  begin
    for Descriptor in FBitmapCodecClassDescriptors do
      if Result = '' then
        Result := Descriptor.Description + ' (' + '*' + Descriptor.Extension + ')|' + '*' + Descriptor.Extension
      else
        Result := Result + '|' + Descriptor.Description + ' (' + '*' + Descriptor.Extension + ')|' + '*' + Descriptor.Extension;
    // all files
    Result := SVAllFiles + ' (' + GetFileTypes + ')|' + GetFileTypes + '|' + Result;
  end;
end;

class function TBitmapCodecManager.GetImageSize(const AFileName: string): TPointF;
var
  CodecClass: TCustomBitmapCodecClass;
begin
  CodecClass := FindBitmapCodecDescriptor(ExtractFileExt(AFileName), TBitmapCodecDescriptorField.Extension).BitmapCodecClass;
  if Assigned(CodecClass) then
    Result := CodecClass.GetImageSize(AFileName)
  else
    Result := TPointF.Create(0, 0);
end;

class function TBitmapCodecManager.LoadFromFile(const AFileName: string; const Bitmap: TBitmapSurface): Boolean;
var
  CodecClass: TCustomBitmapCodecClass;
  Codec: TCustomBitmapCodec;
begin
  CodecClass := FindBitmapCodecDescriptor(ExtractFileExt(AFileName), TBitmapCodecDescriptorField.Extension).BitmapCodecClass;
  if Assigned(CodecClass) then
  begin
    Codec := CodecClass.Create;
    try
      Result := Codec.LoadFromFile(AFileName, Bitmap);
    finally
      Codec.Free;
    end;
  end
  else
    Result := False;
end;

class function TBitmapCodecManager.LoadThumbnailFromFile(const AFileName: string; const AFitWidth, AFitHeight: Single;
  const UseEmbedded: Boolean; const Bitmap: TBitmapSurface): Boolean;
var
  CodecClass: TCustomBitmapCodecClass;
  Codec: TCustomBitmapCodec;
begin
  CodecClass := FindBitmapCodecDescriptor(ExtractFileExt(AFileName), TBitmapCodecDescriptorField.Extension).BitmapCodecClass;
  if Assigned(CodecClass) then
  begin
    Codec := CodecClass.Create;
    try
      Result := Codec.LoadThumbnailFromFile(AFileName, AFitWidth, AFitHeight, UseEmbedded, Bitmap);
    finally
      Codec.Free;
    end;
  end
  else
    Result := False;
end;

class function TBitmapCodecManager.LoadFromStream(const AStream: TStream; const Bitmap: TBitmapSurface): Boolean;
var
  Codec: TCustomBitmapCodec;
  Descriptor: TBitmapCodecClassDescriptor;
begin
  Result := False;
  if Assigned(FBitmapCodecClassDescriptors) then
    for Descriptor in FBitmapCodecClassDescriptors do
      if Descriptor.BitmapCodecClass.IsValid(AStream) then
      begin
        Codec := Descriptor.BitmapCodecClass.Create;
        try
          Result := Codec.LoadFromStream(AStream, Bitmap);
        finally
          Codec.Free;
        end;
        Break;
      end;
end;

class function TBitmapCodecManager.SaveToFile(const AFileName: string; const Bitmap: TBitmapSurface;
  const SaveParams: PBitmapCodecSaveParams = nil): Boolean;
var
  Codec: TCustomBitmapCodec;
  Descriptor: TBitmapCodecClassDescriptor;
begin
  Result := False;
  if Assigned(FBitmapCodecClassDescriptors) then
    for Descriptor in FBitmapCodecClassDescriptors do
      if SameText(ExtractFileExt(AFileName), Descriptor.Extension, loUserLocale) and Descriptor.CanSave then
      begin
        Codec := Descriptor.BitmapCodecClass.Create;
        try
          Result := Codec.SaveToFile(AFileName, Bitmap, SaveParams);
        finally
          Codec.Free;
        end;
      end;
end;

class function TBitmapCodecManager.SaveToStream(const AStream: TStream; const Bitmap: TBitmapSurface; const Extension: string;
  SaveParams: PBitmapCodecSaveParams = nil): Boolean;
var
  Codec: TCustomBitmapCodec;
  Descriptor: TBitmapCodecClassDescriptor;
begin
  Result := False;
  if Assigned(FBitmapCodecClassDescriptors) then
    for Descriptor in FBitmapCodecClassDescriptors do
      if (SameText(Extension, Descriptor.Extension, loUserLocale) or
        SameText('.' + Extension, Descriptor.Extension, loUserLocale)) and
        Descriptor.CanSave then
      begin
        Codec := Descriptor.BitmapCodecClass.Create;
        try
          Result := Codec.SaveToStream(AStream, Bitmap, Descriptor.Extension, SaveParams);
        finally
          Codec.Free;
        end;
      end;
end;

{ TBitmapData }

constructor TBitmapData.Create(const AWidth, AHeight: Integer;
  const APixelFormat: TPixelFormat);
begin
  Self.FWidth := AWidth;
  Self.FHeight := AHeight;
  Self.FPixelFormat := APixelFormat;
end;

function TBitmapData.GetBytesPerLine: Integer;
begin
  Result := Width * BytesPerPixel;
end;

function TBitmapData.GetBytesPerPixel: Integer;
begin
  Result := GetPixelFormatBytes(PixelFormat);
end;

function TBitmapData.GetPixel(const X, Y: Integer): TAlphaColor;
begin
  Result := PixelToAlphaColor(@PLongByteArray(Data)[Y * Pitch + (X * BytesPerPixel)], PixelFormat);
end;

function TBitmapData.GetPixelAddr(const I, J: Integer): Pointer;
begin
  Result := @PLongByteArray(Data)[J * Pitch + I * BytesPerPixel];
end;

function TBitmapData.GetScanline(const I: Integer): Pointer;
begin
  Result := @PLongByteArray(Data)[I * Pitch];
end;

procedure TBitmapData.Copy(const Source: TBitmapData);
var
  I: Integer;
begin
  if (Source.Pitch = Pitch) and (Pitch = Width * GetPixelFormatBytes(Source.PixelFormat)) then
      Move(Source.Data^, Data^, Pitch * Height)
  else begin
    for I := 0 to Height - 1 do
      Move(PLongByteArray(Source.Data)[I * Source.Pitch], PLongByteArray(Data)[I * Pitch], BytesPerLine)
  end;
end;

procedure TBitmapData.SetPixel(const X, Y: Integer; const AColor: TAlphaColor);
begin
  AlphaColorToPixel(AColor, @PLongByteArray(Data)[Y * Pitch + (X * BytesPerPixel)], PixelFormat);
end;

{ TBitmap }

constructor TBitmap.Create(const AWidth, AHeight: Integer);
begin
  inherited Create;
  FBitmapScale := 1.0;
  FWidth := AWidth;
  FHeight := AHeight;
end;

constructor TBitmap.CreateFromStream(const AStream: TStream);
begin
  inherited Create;
  LoadFromStream(AStream);
end;

constructor TBitmap.CreateFromFile(const AFileName: string);
begin
  inherited Create;
  LoadFromFile(AFileName);
end;

constructor TBitmap.CreateFromBitmapAndMask(const Bitmap, Mask: TBitmap);
var
  I, J: Integer;
  D, B, M: TBitmapData;
  C: TAlphaColor;
begin
  Create(Bitmap.Width, Bitmap.Height);
  if (Bitmap.Width <> Mask.Width) or (Bitmap.Height <> Mask.Height) then
    Exit;
  if Map(TMapAccess.maWrite, D) and Bitmap.Map(TMapAccess.maRead, B) and Mask.Map(TMapAccess.maRead, M) then
  try
    for I := 0 to FWidth - 1 do
      for J := 0 to FHeight - 1 do
      begin
        C := B.GetPixel(I, J);
        TAlphaColorRec(C).A := TAlphaColorRec(C).R;
        D.SetPixel(I, J, C);
      end;
  finally
    Unmap(D);
    Bitmap.Unmap(B);
    Mask.Unmap(M);
  end;
end;

destructor TBitmap.Destroy;
var
  I: Integer;
  BitmapObject: IBitmapObject;
begin
  if Assigned(FNotifyList) then
  begin
    for I := FNotifyList.Count - 1 downto 0 do
      IFreeNotification(FNotifyList[I]).FreeNotification(Self);
    FNotifyList.DisposeOf;
  end;
  if Assigned(FResource) then
  begin
    if Supports(FResource, IBitmapObject, BitmapObject) then
      BitmapObject.RemoveFreeNotify(Self);
    FResource := nil;
  end;
  if not (TCanvasStyle.NeedGPUSurface in CanvasClass.GetCanvasStyle) and Assigned(FTexture) then
    FTexture.DisposeOf;
  FTexture := nil;
  if Assigned(FCanvas) then
    FCanvas.DisposeOf;
  FCanvas := nil;
  CanvasClass.FinalizeBitmap(Self);
  inherited;
end;

function TBitmap.GetHandle: TBitmapHandle;
begin
  if FHandle = 0 then
    CanvasClass.InitializeBitmap(Self);
  Result := FHandle;
end;

function TBitmap.GetPixelFormat: TPixelFormat;
begin
  if HandleAllocated then
    Result := FPixelFormat
  else
    Result := TPixelFormat.pfUnknown;
end;

procedure TBitmap.AddFreeNotify(const AObject: IFreeNotification);
begin
  if not Assigned(FNotifyList) then
    FNotifyList := TList<Pointer>.Create;
  FNotifyList.Add(Pointer(AObject));
end;

procedure TBitmap.RemoveFreeNotify(const AObject: IFreeNotification);
begin
  if Assigned(FNotifyList) then
    FNotifyList.Remove(Pointer(AObject));
end;

function TBitmap.GetStyleLookup: string;
begin
  Result := FStyleLookup;
end;

function TBitmap.HandleAllocated: Boolean;
begin
  Result := Handle <> 0;
end;

procedure TBitmap.SetStyleLookup(const Value: string);
var
  BitmapObject: IBitmapObject;
begin
  if Value <> FStyleLookup then
  begin
    if Assigned(FResource) then
    begin
      if Supports(FResource, IBitmapObject, BitmapObject) then
        BitmapObject.RemoveFreeNotify(Self);
      FResource := nil;
    end;
    FStyleLookup := Value;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TBitmap.SetResourceBitmap(const ABitmap: TBitmap);
var
  BitmapObject: IBitmapObject;
begin
  if Assigned(FResource) then
  begin
    if Supports(FResource, IBitmapObject, BitmapObject) then
      BitmapObject.RemoveFreeNotify(Self);
  end;
  FResource := ABitmap;
  if Assigned(FResource) then
  begin
    if Supports(FResource, IBitmapObject, BitmapObject) then
      BitmapObject.AddFreeNotify(Self);
  end;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TBitmap.SetWidth(const Value: Integer);
begin
  SetSize(Value, Height);
end;

function TBitmap.GetBitmap: TBitmap;
var
  BitmapObject: IBitmapObject;
begin
  Result := nil;
  if Assigned(FResource) then
  begin
    if Supports(FResource, IBitmapObject, BitmapObject) then
      Result := BitmapObject.Bitmap
    else
      if FResource is TBitmap then
        Result := TBitmap(FResource);
  end
  else
  if FStyleLookup <> '' then
  begin
    FResource := FindStyleResource(FStyleLookup);
    if Supports(FResource, IBitmapObject, BitmapObject) then
      Result := BitmapObject.Bitmap;
  end;
end;

procedure TBitmap.SetBitmapScale(const Scale: Single);
begin
  FBitmapScale := Scale;
end;

procedure TBitmap.SetHandle(const Handle: TBitmapHandle);
begin
  FHandle := Handle;
end;

procedure TBitmap.SetHeight(const Value: Integer);
begin
  SetSize(Width, Value);
end;

procedure TBitmap.SetPixelFormat(const PixelFormat: TPixelFormat);
begin
  FPixelFormat := PixelFormat;
end;

procedure TBitmap.SetSize(const AWidth, AHeight: Integer);
begin
  if (FWidth <> AWidth) or (FHeight <> AHeight) then
  begin
    FWidth := AWidth;
    FHeight := AHeight;
    if FWidth < 0 then FWidth := 0;
    if FHeight < 0 then FHeight := 0;
    Recreate;
    BitmapChanged;
  end;
end;

procedure TBitmap.Recreate;
begin
  if not (TCanvasStyle.NeedGPUSurface in CanvasClass.GetCanvasStyle) and Assigned(FTexture) then
    FTexture.DisposeOf;
  FTexture := nil;
  if Assigned(FCanvas) then
    FCanvas.DisposeOf;
  FCanvas := nil;
  CanvasClass.FinalizeBitmap(Self);
  CanvasClass.InitializeBitmap(Self);
end;

function TBitmap.GetCanvasClass: TCanvasClass;
begin
  if not Assigned(FCanvasClass) then
    FCanvasClass := TCanvasManager.GetDefaultCanvas;
  Result := FCanvasClass;
end;

procedure TBitmap.Clear(const AColor: TAlphaColor);
begin
  ClearRect(RectF(0, 0, FWidth, FHeight), AColor);
end;

procedure TBitmap.ClearRect(const ARect: TRectF; const AColor: TAlphaColor);
var
  R: TRectF;
  M: TBitmapData;
  C: Cardinal;
begin
  R := ARect;
  if R.Left < 0 then
    R.Left := 0;
  if R.Top < 0 then
    R.Top := 0;
  if R.Right > FWidth then
    R.Right := FWidth;
  if R.Bottom > FHeight then
    R.Bottom := FHeight;
  if R.Bottom < R.Top then
    R.Bottom := R.Top;
  if R.Right < R.Left then
    R.Right := R.Left;
  if (R.Right < 0) or (R.Top < 0) or (R.Left > FWidth) or (R.Top > FHeight) then
    Exit;
  if Map(TMapAccess.maWrite, M) then
  try
    AlphaColorToPixel(PremultiplyAlpha(AColor), @C, FPixelFormat);
    FillLongwordRect(M.Data, M.Pitch div 4, FHeight, trunc(R.Left), trunc(R.Top), trunc(R.Right), trunc(R.Bottom), C);
  finally
    Unmap(M);
  end;
end;

procedure TBitmap.CopyFromBitmap(const Source: TBitmap);
begin
  TCanvas.CopyBitmap(Source, Self);
  BitmapChanged;
end;

procedure TBitmap.CopyFromBitmap(const Source: TBitmap; SrcRect: TRect; DstX, DstY: Integer);
var
  I: Integer;
  S, D: TBitmapData;
  DstR: TRect;
begin
  if Map(TMapAccess.maWrite, D) then
  begin
    if Source.Map(TMapAccess.maRead, S) then
    begin
      if (DstX = 0) and (DstY = 0) and (SrcRect.Left = 0) and (SrcRect.Top = 0) and (SrcRect.Width = Width) and
         (SrcRect.Height = Height) and (D.Pitch <> Width * 4) and (D.Pitch = S.Pitch) then
        Move(S.Data^, D.Data^, D.Pitch * Height)
      else
      begin
        IntersectRect(SrcRect, Rect(0, 0, Source.Width, Source.Height));
        DstR := Rect(DstX, DstY, DstX + SrcRect.Width, DstY + SrcRect.Height);
        IntersectRect(DstR, Rect(0, 0, Width, Height));
        if (DstR.Width = SrcRect.Width) and (DstR.Height = SrcRect.Height) then
          for I := SrcRect.Top to SrcRect.Bottom - 1 do
            Move(PAlphaColorArray(S.Data)[SrcRect.Left + (I * (S.Pitch div 4))],
              PAlphaColorArray(D.Data)[DstY + (I - SrcRect.Top) * (D.Pitch div 4) + DstX], SrcRect.Width * 4);
      end;
      Source.Unmap(S);
    end;
    Unmap(D);
  end;
end;

procedure TBitmap.BitmapChanged;
begin
  FTextureNeedUpdate := True;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

function TBitmap.IsEmpty: Boolean;
begin
  Result := FWidth * FHeight = 0;
end;

procedure TBitmap.Assign(Source: TPersistent);
var
  D: TBitmapData;
  I: Integer;
begin
  if Source is TBitmap then
  begin
    if Assigned(TBitmap(Source).ResourceBitmap) then
    begin
      FStyleLookup := TBitmap(Source).FStyleLookup;
      BitmapChanged;
    end else
    begin
      FResource := nil;
      FStyleLookup := '';
      SetSize(TBitmap(Source).Width, TBitmap(Source).Height);
      CopyFromBitmap(TBitmap(Source));
    end;
  end else if Source is TBitmapSurface then
  begin
    FResource := nil;
    FStyleLookup := '';
    SetSize(TBitmapSurface(Source).Width, TBitmapSurface(Source).Height);
    if Map(TMapAccess.maWrite, D) then
    try
      if D.Pitch = TBitmapSurface(Source).Pitch then
        Move(TBitmapSurface(Source).Bits^, D.Data^, TBitmapSurface(Source).Pitch * Height)
      else
        for I := 0 to TBitmapSurface(Source).Height - 1 do
          Move(TBitmapSurface(Source).Scanline[I]^, Pointer(NativeInt(D.Data) + I * D.Pitch)^, Width * TBitmapSurface(Source).BytesPerPixel);
    finally
      Unmap(D);
    end;
  end else if Source = nil then
  begin
    Clear(TAlphaColorRec.White);
  end
  else
    inherited;
end;

procedure TBitmap.AssignTo(Dest: TPersistent);
var
  I: Integer;
  M: TBitmapData;
begin
  if Dest is TBitmapSurface then
  begin
    TBitmapSurface(Dest).SetSize(Width, Height, PixelFormat);
    if Map(TMapAccess.maRead, M) then
    try
      if TBitmapSurface(Dest).Pitch <> M.Pitch then
      begin
        for I := 0 to Height - 1 do
          Move(PAlphaColorArray(M.Data)[I * (M.Pitch div 4)],
            TBitmapSurface(Dest).Scanline[I]^, TBitmapSurface(Dest).Pitch);
      end
      else
        Move(M.Data^, TBitmapSurface(Dest).Bits^, TBitmapSurface(Dest).Pitch * Height);
    finally
      Unmap(M);
    end;
  end else
    inherited;
end;

procedure TBitmap.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('PNG', ReadBitmap, WriteBitmap, FWidth * FHeight > 0);
end;

procedure TBitmap.ReadBitmap(Stream: TStream);
begin
  LoadFromStream(Stream);
end;

procedure TBitmap.WriteBitmap(Stream: TStream);
begin
  SaveToStream(Stream);
end;

procedure TBitmap.Rotate(const Angle: Single);
var
  temp: TBitmap;
  M, M2: TMatrix;
  Pts: array of TPointF;
  R: TRectF;
begin
  if Angle = 0 then
    Exit;

  M := IdentityMatrix;
  M.m31 := -FWidth / 2;
  M.m32 := -FHeight / 2;
  M := MatrixMultiply(M, CreateRotationMatrix(DegToRad(Angle)));
  { calc new size }
  SetLength(Pts, 4);
  Pts[0] := M.Transform(Vector(0, 0)).ToPointF;
  Pts[1] := M.Transform(Vector(FWidth, 0)).ToPointF;
  Pts[2] := M.Transform(Vector(FWidth, FHeight)).ToPointF;
  Pts[3] := M.Transform(Vector(0, FHeight)).ToPointF;
  R := NormalizeRectF(Pts);
  { translate }
  M2 := IdentityMatrix;
  M2.m31 := RectWidth(R) / 2;
  M2.m32 := RectHeight(R) / 2;
  M := MatrixMultiply(M, M2);
  { rotate }
  temp := TBitmap.Create(trunc(RectWidth(R)), trunc(RectHeight(R)));
  try
    if temp.Canvas.BeginScene then
    try
      temp.Canvas.Clear(0);
      temp.Canvas.SetMatrix(M);
      temp.Canvas.DrawBitmap(Self, RectF(0, 0, FWidth, FHeight), RectF(0, 0, FWidth, FHeight), 1);
    finally
      temp.Canvas.EndScene;
    end;
    Assign(temp);
  finally
    temp.DisposeOf;
  end;
end;

procedure TBitmap.FlipHorizontal;
var
  I, J: Integer;
  tmp: TAlphaColor;
  M: TBitmapData;
begin
  if Map(TMapAccess.maReadWrite, M) then
  try
    for j := 0 to Height - 1 do
      for I := 0 to (Width - 1) div 2 do
      begin
        tmp := PAlphaColorArray(M.Data)[j * (M.Pitch div 4) + Width - 1 - I];
        PAlphaColorArray(M.Data)[j * (M.Pitch div 4) + Width - 1 - I] := PAlphaColorArray(M.Data)[j * (M.Pitch div 4) + I];
        PAlphaColorArray(M.Data)[j * (M.Pitch div 4) + I] := tmp;
      end;
  finally
    Unmap(M);
  end;
end;

procedure TBitmap.FlipVertical;
var
  I: Integer;
  tmp: PAlphaColorArray;
  M: TBitmapData;
begin
  GetMem(tmp, Width * 4);
  if Map(TMapAccess.maReadWrite, M) then
  try
    for I := 0 to (Height - 1) div 2 do
    begin
      System.Move(PAlphaColorArray(M.Data)[(Height - 1 - I) * (M.Pitch div 4)], tmp[0], M.Pitch);
      System.Move(PAlphaColorArray(M.Data)[I * (M.Pitch div 4)], PAlphaColorArray(M.Data)[(Height - 1 - I) * (M.Pitch div 4)], M.Pitch);
      System.Move(tmp[0], PAlphaColorArray(M.Data)[I * (M.Pitch div 4)], M.Pitch);
    end;
  finally
    Unmap(M);
  end;
  FreeMem(tmp, Width * 4);
end;

procedure TBitmap.FreeNotification(AObject: TObject);
begin
  if FResource = AObject then
    FResource := nil;
end;

procedure TBitmap.InvertAlpha;
var
  I, J: Integer;
  M: TBitmapData;
  C: PAlphaColorRec;
begin
  if Map(TMapAccess.maReadWrite, M) then
  try
    for J := 0 to Height - 1 do
      for I := 0 to Width - 1 do
      begin
        C := @PAlphaColorArray(M.Data)[J * (M.Pitch div 4) + I];
        C^.Color := UnpremultiplyAlpha(C^.Color);
        C^.A := $FF - C^.A;
        C^.Color := PremultiplyAlpha(C^.Color);
      end;
  finally
    Unmap(M);
  end;
end;

procedure TBitmap.ReplaceOpaqueColor(const Color: TAlphaColor);
var
  I, J: Integer;
  M: TBitmapData;
  C: PAlphaColorRec;
begin
  if Map(TMapAccess.maReadWrite, M) then
  try
    for J := 0 to Height - 1 do
      for I := 0 to Width - 1 do
      begin
        C := @PAlphaColorArray(M.Data)[J * (M.Pitch div 4) + I];
        if C^.A > 0 then
          C^.Color := PremultiplyAlpha(MakeColor(Color, C^.A / $FF));
      end;
  finally
    Unmap(M);
  end;
end;

procedure TBitmap.Resize(const AWidth, AHeight: Integer);
var
  BufferTmp: TBitmap;
begin
  BufferTmp := CreateThumbnail(AWidth, AHeight);
  try
    Assign(BufferTmp);
  finally
    BufferTmp.Free;
  end;
end;

function TBitmap.CreateMask: PByteArray;
var
  I, J: Integer;
  M: TBitmapData;
  C: PAlphaColorRec;
begin
  GetMem(Result, Width * Height);
  if Map(TMapAccess.maReadWrite, M) then
  try
    for j := 0 to Height - 1 do
      for I := 0 to Width - 1 do
      begin
        C := @PAlphaColorArray(M.Data)[J * (M.Pitch div 4) + I];
        Result[I + (J * Width)] := C^.A;
      end;
  finally
    Unmap(M);
  end;
end;

procedure TBitmap.ApplyMask(const Mask: PByteArray; const DstX: Integer = 0; const DstY: Integer = 0);
var
  I, J: Integer;
  M: TBitmapData;
  C: PAlphaColorRec;
begin
  if Map(TMapAccess.maReadWrite, M) then
  try
    for J := 0 to Height - 1 do
      for I := 0 to Width - 1 do
      begin
        if (I - DstX < 0) or (I - DstX > Width - 1) or (J - DstY < 0) or (J - DstY > Height - 1) then
          Continue;
        if Mask[I - DstX + ((J - DstY) * Width)] > 0 then
        begin
          C := @PAlphaColorArray(M.Data)[J * (M.Pitch div 4) + I];
          C^.Color := PremultiplyAlpha(MakeColor(UnpremultiplyAlpha(C^.Color), ($FF - Mask[I - DstX + ((j - DstY) * Width)]) / $FF));
        end;
      end;
  finally
    Unmap(M);
  end;
end;

function TBitmap.CreateThumbnail(const Width, Height: Integer): TBitmap;
var
  R: TRectF;
begin
  Result := TBitmap.Create(Width, Height);
  if Result.Canvas.BeginScene then
  try
    R := RectF(0, 0, Self.Width, Self.Height);
    R.Fit(RectF(0, 0, Width, Height));
    Result.Canvas.DrawBitmap(Self, RectF(0, 0, Self.Width, Self.Height), R, 1.0);
  finally
    Result.Canvas.EndScene;
  end;
end;

function TBitmap.Map(const Access: TMapAccess; var Data: TBitmapData): Boolean;
begin
  if CanvasClass.MapBitmap(Self, Access, Data) then
  begin
    Data.Create(Width, Height, FPixelFormat);
    FMapped := True;
    FMapAccess := Access;
    if Access in [TMapAccess.maWrite, TMapAccess.maReadWrite] then
      FTextureNeedUpdate := True;
    Result := True;
  end
  else
    Result := False;
end;

procedure TBitmap.Unmap(var Data: TBitmapData);
begin
  if FMapped then
  begin
    CanvasClass.UnmapBitmap(Self, Data);
    FMapped := False;
    if FMapAccess in [TMapAccess.maWrite, TMapAccess.maReadWrite] then
      BitmapChanged;
  end;
end;

procedure TBitmap.LoadFromFile(const AFileName: string; const Rotate: Single = 0);
var
  Surf: TBitmapSurface;
begin
  Surf := TBitmapSurface.Create;
  try
    if TBitmapCodecManager.LoadFromFile(AFileName, Surf) then
      Assign(Surf);
  finally
    Surf.Free;
  end;
end;

procedure TBitmap.LoadThumbnailFromFile(const AFileName: string; const AFitWidth, AFitHeight: Single;
  const UseEmbedded: Boolean = True);
var
  Surf: TBitmapSurface;
begin
  Surf := TBitmapSurface.Create;
  try
    if TBitmapCodecManager.LoadThumbnailFromFile(AFileName, AFitWidth, AFitHeight, UseEmbedded, Surf) then
      Assign(Surf);
  finally
    Surf.Free;
  end;
end;

procedure TBitmap.LoadFromStream(Stream: TStream);
var
  S: TStream;
  Surf: TBitmapSurface;
begin
  if Stream.Position > 0 then
  begin
    // need to create temp stream
    S := TMemoryStream.Create;
    try
      S.CopyFrom(Stream, Stream.Size - Stream.Position);
      S.Position := 0;
      Surf := TBitmapSurface.Create;
      try
        if TBitmapCodecManager.LoadFromStream(S, Surf) then
          Assign(Surf);
      finally
        Surf.Free;
      end;
    finally
      S.Free;
    end;
  end
  else
    if Stream.Size = 0 then
      Clear(0)
    else begin
      Surf := TBitmapSurface.Create;
      try
        if TBitmapCodecManager.LoadFromStream(Stream, Surf) then
          Assign(Surf);
      finally
        Surf.Free;
      end;
    end;
end;

procedure TBitmap.SaveToFile(const AFileName: string; const SaveParams: PBitmapCodecSaveParams = nil);
var
  Surf: TBitmapSurface;
begin
  Surf := TBitmapSurface.Create;
  try
    Surf.Assign(Self);
    TBitmapCodecManager.SaveToFile(AFileName, Surf, SaveParams);
  finally
    Surf.Free;
  end;
end;

procedure TBitmap.SaveToStream(Stream: TStream);
var
  Surf: TBitmapSurface;
begin
  Surf := TBitmapSurface.Create;
  try
    Surf.Assign(Self);
    TBitmapCodecManager.SaveToStream(Stream, Surf, '.png');
  finally
    Surf.Free;
  end;
end;

function TBitmap.GetCanvas: TCanvas;
begin
  if not Assigned(FCanvas) then
    FCanvas := CanvasClass.CreateFromBitmap(Self);
  Result := FCanvas;
end;

{ TPath }

constructor TPathData.Create;
begin
  inherited Create;
  FRecalcBounds := True;
end;

destructor TPathData.Destroy;
var
  PathObject: IPathObject;
begin
  if Assigned(FStyleResource) then
  begin
    if Supports(FStyleResource, IPathObject, PathObject) then
      PathObject.RemoveFreeNotify(Self);
    FStyleResource := nil;
  end;
  inherited;
end;

procedure TPathData.Assign(Source: TPersistent);
begin
  if Source is TPathData then
  begin
    if Assigned(TPathData(Source).ResourcePath) then
    begin
      FStyleLookup := TPathData(Source).StyleLookup;
      if Assigned(FOnChanged) then
        FOnChanged(Self);
    end
    else
    begin
      SetLength(FPathData, TPathData(Source).Count);
      System.Move(TPathData(Source).FPathData[0], FPathData[0], SizeOf(TPathPoint) * Count);
      if Assigned(FOnChanged) then
        FOnChanged(Self);
    end;
  end
  else
    inherited
end;

function TPathData.GetStyleLookup: string;
begin
  Result := FStyleLookup;
end;

procedure TPathData.SetStyleLookup(const Value: string);
begin
  if Value <> FStyleLookup then
  begin
    FStyleLookup := Value;
    if Assigned(FOnChanged) then
      FOnChanged(Self);
  end;
end;

function TPathData.GetPath: TPathData;
var
  O: TFmxObject;
  PO: IPathObject;
begin
  Result := nil;
  if Assigned(FStyleResource) and Supports(FStyleResource, IPathObject, PO) then
    Result := PO.Path
  else if FStyleLookup <> '' then
  begin
    O := FindStyleResource(FStyleLookup);
    if Supports(O, IPathObject, PO) then
    begin
      if Assigned(FStyleResource) then
        PO.RemoveFreeNotify(Self);
      FStyleResource := O;
      if Assigned(FStyleResource) then
        PO.AddFreeNotify(Self);
      Result := PO.Path;
    end;
  end;
end;

function TPathData.GetCount: Integer;
begin
  Result := Length(FPathData);
end;

function TPathData.GetPoint(AIndex: Integer): TPathPoint;
begin
  Result := FPathData[AIndex];
end;

procedure TPathData.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('Path', ReadPath, WritePath, Count > 0);
end;

procedure TPathData.ReadPath(Stream: TStream);
var
  S: Longint;
  I: Integer;
  k: Byte;
  P: TPointF;
begin
  Stream.Read(S, SizeOf(S));
{$IFDEF FPC_BIG_ENDIAN}
  ReverseBytes(@S, 4);
{$ENDIF}
  SetLength(FPathData, S);
  if S > 0 then
  begin
    if (Stream.Size - 4) div S = 9 then
    begin
      for I := 0 to S - 1 do
      begin
        Stream.Read(k, 1);
        Stream.Read(P, SizeOf(P));
{$IFDEF FPC_BIG_ENDIAN}
        ReverseBytes(@P.X, 4);
        ReverseBytes(@P.Y, 4);
{$ENDIF}
        FPathData[I].Kind := TPathPointKind(k);
        FPathData[I].Point := P;
      end;
    end
    else
    begin
      Stream.Read(FPathData[0], S * SizeOf(TPathPoint));
{$IFDEF FPC_BIG_ENDIAN}
      for I := 0 to S * 3 - 1 do
        ReverseBytes(@PColorArray(PathData)[I], 4);
{$ENDIF}
    end;
  end;
  FRecalcBounds := True;
end;

procedure TPathData.WritePath(Stream: TStream);
var
  S: Longint;
begin
  S := Count;
  Stream.Write(S, SizeOf(S));
  if S > 0 then
    Stream.Write(FPathData[0], S * SizeOf(TPathPoint));
end;

function TPathData.LastPoint: TPointF;
begin
  if Count > 0 then
    Result := FPathData[High(FPathData)].Point
  else
    Result := PointF(0, 0);
end;

procedure TPathData.MoveTo(const P: TPointF);
begin
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppMoveTo;
  FPathData[High(FPathData)].Point := P;
  FStartPoint := FPathData[High(FPathData)].Point;
  FRecalcBounds := True;
end;

procedure TPathData.MoveToRel(const P: TPointF);
var
  LP: TPointF;
begin
  LP := LastPoint;
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppMoveTo;
  FPathData[High(FPathData)].Point := PointF(LP.X + P.X, LP.Y + P.Y);
  FStartPoint := FPathData[High(FPathData)].Point;
  FRecalcBounds := True;
end;

procedure TPathData.LineTo(const P: TPointF);
begin
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppLineTo;
  FPathData[High(FPathData)].Point := P;
  FRecalcBounds := True;
end;

procedure TPathData.LineToRel(const P: TPointF);
var
  LP: TPointF;
begin
  LP := LastPoint;
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppLineTo;
  FPathData[High(FPathData)].Point := PointF(LP.X + P.X, LP.Y + P.Y);
  FRecalcBounds := True;
end;

procedure TPathData.HLineTo(const X: Single);
begin
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppLineTo;
  FPathData[High(FPathData)].Point := PointF(X, FPathData[High(FPathData) - 1].Point.Y);
  FRecalcBounds := True;
end;

procedure TPathData.HLineToRel(const X: Single);
var
  LP: TPointF;
begin
  LP := LastPoint;
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppLineTo;
  FPathData[High(FPathData)].Point := PointF(LP.X + X, LP.Y);
  FRecalcBounds := True;
end;

procedure TPathData.VLineTo(const Y: Single);
begin
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppLineTo;
  FPathData[High(FPathData)].Point := PointF(FPathData[High(FPathData) - 1].Point.X, Y);
  FRecalcBounds := True;
end;

procedure TPathData.VLineToRel(const Y: Single);
var
  LP: TPointF;
begin
  LP := LastPoint;
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppLineTo;
  FPathData[High(FPathData)].Point := PointF(LP.X, LP.Y + Y);
  FRecalcBounds := True;
end;

procedure TPathData.QuadCurveTo(const ControlPoint, EndPoint: TPointF);
var
  LP, CP1, CP2: TPointF;
begin
  LP := LastPoint;
  CP1.X := (1/3 * LP.X) + (2/3 * ControlPoint.X);
  CP1.Y := (1/3 * LP.Y) + (2/3 * ControlPoint.Y);
  CP2.X := (2/3 * ControlPoint.X) + (1/3 * EndPoint.X);
  CP2.Y := (2/3 * ControlPoint.Y) + (1/3 * EndPoint.Y);
  CurveTo(CP1, CP2, EndPoint);
end;

procedure TPathData.CurveTo(const ControlPoint1, ControlPoint2, EndPoint: TPointF);
begin
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppCurveTo;
  FPathData[High(FPathData)].Point := ControlPoint1;
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppCurveTo;
  FPathData[High(FPathData)].Point := ControlPoint2;
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppCurveTo;
  FPathData[High(FPathData)].Point := EndPoint;
  FRecalcBounds := True;
end;

procedure TPathData.CurveToRel(const ControlPoint1, ControlPoint2, EndPoint: TPointF);
var
  LP: TPointF;
begin
  LP := LastPoint;
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppCurveTo;
  FPathData[High(FPathData)].Point := PointF(LP.X + ControlPoint1.X, LP.Y + ControlPoint1.Y);
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppCurveTo;
  FPathData[High(FPathData)].Point := PointF(LP.X + ControlPoint2.X, LP.Y + ControlPoint2.Y);;
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppCurveTo;
  FPathData[High(FPathData)].Point := PointF(LP.X + EndPoint.X, LP.Y + EndPoint.Y);;
  FRecalcBounds := True;
end;

procedure TPathData.SmoothCurveTo(const ControlPoint2, EndPoint: TPointF);
var
  ControlPoint1: TPointF;
begin
  if Count > 2 then
  begin
    ControlPoint1.X := LastPoint.X + (LastPoint.X - FPathData[High(FPathData) - 1].Point.X);
    ControlPoint1.Y := LastPoint.Y + (LastPoint.Y - FPathData[High(FPathData) - 1].Point.Y);
  end
  else
    ControlPoint1 := ControlPoint2;
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppCurveTo;
  FPathData[High(FPathData)].Point := ControlPoint1;
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppCurveTo;
  FPathData[High(FPathData)].Point := ControlPoint2;
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppCurveTo;
  FPathData[High(FPathData)].Point := EndPoint;
  FRecalcBounds := True;
end;

procedure TPathData.SmoothCurveToRel(const ControlPoint2, EndPoint: TPointF);
var
  LP, ControlPoint1: TPointF;
begin
  LP := LastPoint;
  if Count > 2 then
  begin
    ControlPoint1.X := LastPoint.X + (LastPoint.X - FPathData[High(FPathData) - 1].Point.X);
    ControlPoint1.Y := LastPoint.Y + (LastPoint.Y - FPathData[High(FPathData) - 1].Point.Y);
  end
  else
    ControlPoint1 := ControlPoint2;

  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppCurveTo;
  FPathData[High(FPathData)].Point := PointF(ControlPoint1.X, ControlPoint1.Y);
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppCurveTo;
  FPathData[High(FPathData)].Point := PointF(LP.X + ControlPoint2.X, LP.Y + ControlPoint2.Y);
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppCurveTo;
  FPathData[High(FPathData)].Point := PointF(LP.X + EndPoint.X, LP.Y + EndPoint.Y);
  FRecalcBounds := True;
end;

procedure TPathData.ClosePath;
begin
  SetLength(FPathData, Count + 1);
  FPathData[High(FPathData)].Kind := TPathPointKind.ppClose;
  FPathData[High(FPathData)].Point := FStartPoint;
  FRecalcBounds := True;
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

procedure TPathData.Clear;
begin
  FRecalcBounds := True;
  SetLength(FPathData, 0);
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

function TPathData.GetBounds: TRectF;
var
  I: Integer;
begin
  if Length(FPathData) = 0 then
  begin
    Result := RectF(0, 0, 0, 0);
    Exit;
  end;
  if FRecalcBounds then
  begin
    Result := RectF($FFFF, $FFFF, -$FFFF, -$FFFF);
    for I := 0 to High(FPathData) do
    begin
      if FPathData[I].Kind = TPathPointKind.ppClose then
        Continue;

      if FPathData[I].Point.X < Result.Left then
        Result.Left := FPathData[I].Point.X;
      if FPathData[I].Point.X > Result.Right then
        Result.Right := FPathData[I].Point.X;
      if FPathData[I].Point.Y < Result.Top then
        Result.Top := FPathData[I].Point.Y;
      if FPathData[I].Point.Y > Result.Bottom then
        Result.Bottom := FPathData[I].Point.Y;
    end;
    // add small amount
    if RectWidth(Result) = 0 then
      Result.Right := Result.Left + 0.001;
    if RectHeight(Result) = 0 then
      Result.Bottom := Result.Top + 0.001;
    FBounds := Result;
    FRecalcBounds := False;
  end
  else
    Result := FBounds;
end;

procedure TPathData.Scale(const scaleX, scaleY: Single);
var
  I: Integer;
begin
  if Length(FPathData) > 0 then
  begin
    FRecalcBounds := True;
    for I := 0 to High(FPathData) do
      case FPathData[I].Kind of
        TPathPointKind.ppMoveTo, TPathPointKind.ppLineTo, TPathPointKind.ppCurveTo:
          begin
            FPathData[I].Point.X := FPathData[I].Point.X * scaleX;
            FPathData[I].Point.Y := FPathData[I].Point.Y * scaleY;
          end;
        TPathPointKind.ppClose:
          begin
          end;
      end;
  end;
end;

procedure TPathData.Translate(const dX, dY: Single);
var
  I: Integer;
begin
  if Count > 0 then
  begin
    FRecalcBounds := True;
    for I := 0 to High(FPathData) do
      case FPathData[I].Kind of
        TPathPointKind.ppMoveTo, TPathPointKind.ppLineTo, TPathPointKind.ppCurveTo:
          begin
            FPathData[I].Point.X := FPathData[I].Point.X + dX;
            FPathData[I].Point.Y := FPathData[I].Point.Y + dY;
          end;
        TPathPointKind.ppClose:
          begin
          end;
      end;
  end;
end;

procedure TPathData.FitToRect(const ARect: TRectF);
var
  B: TRectF;
begin
  B := GetBounds;
  Translate(-B.Left, -B.Top);
  Scale(RectWidth(ARect) / RectWidth(B), RectHeight(ARect) / RectHeight(B));
  Translate(ARect.Left, ARect.Top);
end;

procedure TPathData.ApplyMatrix(const M: TMatrix);
var
  I: Integer;
begin
  if Length(FPathData) > 0 then
  begin
    FRecalcBounds := True;
    for I := 0 to High(FPathData) do
      case FPathData[I].Kind of
        TPathPointKind.ppMoveTo, TPathPointKind.ppLineTo, TPathPointKind.ppCurveTo:
          begin
            FPathData[I].Point := M.Transform(Vector(FPathData[I].Point)).ToPointF;
          end;
        TPathPointKind.ppClose:
          begin
          end;
      end;
  end;
end;

procedure TPathData.Flatten(const Flatness: Single = 0.25);

  procedure CalculateBezierCoefficients(const Bezier: TCubicBezier; out ax, bx, cx, ay, by, cy: Single);
  begin
    cx := 3.0 * (Bezier[1].X - Bezier[0].X);
    cy := 3.0 * (Bezier[1].Y - Bezier[0].Y);
    bx := 3.0 * (Bezier[2].X - Bezier[1].X) - cx;
    by := 3.0 * (Bezier[2].Y - Bezier[1].Y) - cy;
    ax := Bezier[3].X - Bezier[0].X - cx - bx;
    ay := Bezier[3].Y - Bezier[0].Y - cy - by;
  end;

  function PointOnBezier(const StartPoint: TPointF; const ax, bx, cx, ay, by, cy, t: Single): TPointF;
  var
    tSqr: Single;
    tCube: Single;
  begin
    tSqr := t * t;
    tCube := tSqr * t;
    Result.X := (ax * tCube) + (bx * tSqr) + (cx * t) + StartPoint.X;
    Result.Y := (ay * tCube) + (by * tSqr) + (cy * t) + StartPoint.Y;
  end;

  function CreateBezier(const Bezier: TCubicBezier; const PointCount: Integer): TPolygon;
  var
    ax: Single;
    bx: Single;
    cx: Single;
    ay: Single;
    by: Single;
    cy: Single;
    dT: Single;
    t: Single;
    I: Integer;
  begin
    if PointCount = 0 then
      Exit;
    dT := 1.0 / (1.0 * PointCount - 1.0);
    t := 0.0;
    SetLength(Result, PointCount);
    CalculateBezierCoefficients(Bezier, ax, bx, cx, ay, by, cy);
    for I := 0 to PointCount - 1 do
    begin
      Result[I] := PointOnBezier(Bezier[0], ax, bx, cx, ay, by, cy, t);
      t := t + dT;
    end;
  end;

var
  I, j: Integer;
  BPts: TPolygon;
  B: TCubicBezier;
  F, Len: Single;
  SegCount: Integer;
  OldPathData: array of TPathPoint;
  CurPoint: TPointF;
begin
  { scale }
  if Length(FPathData) > 0 then
  begin
    F := Flatness;
    if F < 0.05 then
      F := 0.05;

    { copy data }
    SetLength(OldPathData, Count);
    System.Move(FPathData[0], OldPathData[0], Count * SizeOf(FPathData[0]));
    SetLength(FPathData, 0);

    I := 0;
    while I < Length(OldPathData) do
    begin
      case OldPathData[I].Kind of
        TPathPointKind.ppMoveTo:
          begin
            MoveTo(OldPathData[I].Point);
            CurPoint := OldPathData[I].Point;
          end;
        TPathPointKind.ppLineTo:
          begin
            LineTo(OldPathData[I].Point);
            CurPoint := OldPathData[I].Point;
          end;
        TPathPointKind.ppCurveTo:
          begin
            B[0] := CurPoint;
            B[1] := OldPathData[I].Point;
            inc(I);
            B[2] := OldPathData[I].Point;
            inc(I);
            B[3] := OldPathData[I].Point;
            // calc length
            BPts := CreateBezier(B, 6);
            Len := 0;
            for j := 0 to High(BPts) - 1 do
              Len := Len + (Vector(BPts[j]) - Vector(BPts[j + 1])).Length;
            // flatten
            SegCount := Round(Len / F);
            if SegCount < 2 then
              LineTo(B[3])
            else
            begin
              BPts := CreateBezier(B, SegCount);
              for j := 0 to High(BPts) do
                LineTo(BPts[j]);
              CurPoint := OldPathData[I].Point;
            end;
          end;
        TPathPointKind.ppClose:
          begin
            ClosePath;
          end;
      end;
      inc(I);
    end;
    if Assigned(FOnChanged) then
      FOnChanged(Self);
  end;
end;

function TPathData.FlattenToPolygon(var Polygon: TPolygon; const Flatness: Single = 0.25): TPointF;

  procedure CalculateBezierCoefficients(const Bezier: TCubicBezier; out ax, bx, cx, ay, by, cy: Single);
  begin
    cx := 3.0 * (Bezier[1].X - Bezier[0].X);
    cy := 3.0 * (Bezier[1].Y - Bezier[0].Y);
    bx := 3.0 * (Bezier[2].X - Bezier[1].X) - cx;
    by := 3.0 * (Bezier[2].Y - Bezier[1].Y) - cy;
    ax := Bezier[3].X - Bezier[0].X - cx - bx;
    ay := Bezier[3].Y - Bezier[0].Y - cy - by;
  end;

  function PointOnBezier(const StartPoint: TPointF; const ax, bx, cx, ay, by, cy, t: Single): TPointF;
  var
    tSqr: Single;
    tCube: Single;
  begin
    tSqr := t * t;
    tCube := tSqr * t;
    Result.X := (ax * tCube) + (bx * tSqr) + (cx * t) + StartPoint.X;
    Result.Y := (ay * tCube) + (by * tSqr) + (cy * t) + StartPoint.Y;
  end;

  function CreateBezier(const Bezier: TCubicBezier; const PointCount: Integer): TPolygon;
  var
    ax: Single;
    bx: Single;
    cx: Single;
    ay: Single;
    by: Single;
    cy: Single;
    dT: Single;
    t: Single;
    I: Integer;
  begin
    if PointCount = 0 then
      Exit;
    dT := 1.0 / (1.0 * PointCount - 1.0);
    t := 0.0;
    SetLength(Result, PointCount);
    CalculateBezierCoefficients(Bezier, ax, bx, cx, ay, by, cy);
    for I := 0 to PointCount - 1 do
    begin
      Result[I] := PointOnBezier(Bezier[0], ax, bx, cx, ay, by, cy, t);
      t := t + dT;
    end;
  end;

  procedure AddPoint(const P: TPointF);
  begin
    if (Length(Polygon) > 0) and (SameValue(P.X, Polygon[High(Polygon)].X, Epsilon) and SameValue(P.Y, Polygon[High(Polygon)].Y, Epsilon)) then
      Exit;
    SetLength(Polygon, Length(Polygon) + 1);
    Polygon[High(Polygon)] := P;
  end;

var
  I, j: Integer;
  BPts: TPolygon;
  B: TCubicBezier;
  SP, CurPoint: TPointF;
  F, Len: Single;
  SegCount: Integer;
begin
  Result := PointF(0, 0);
  SetLength(Polygon, 0);
  if Length(FPathData) > 0 then
  begin
    F := Flatness;
    if F < 0.05 then
      F := 0.05;

    I := 0;
    while I < Count do
    begin
      case FPathData[I].Kind of
        TPathPointKind.ppMoveTo:
          begin
            if Length(Polygon) > 0 then
              AddPoint(ClosePolygon);
            AddPoint(FPathData[I].Point);
            CurPoint := FPathData[I].Point;
            SP := CurPoint;
          end;
        TPathPointKind.ppLineTo:
          begin
            AddPoint(FPathData[I].Point);
            CurPoint := FPathData[I].Point;
          end;
        TPathPointKind.ppCurveTo:
          begin
            B[0] := CurPoint;
            B[1] := FPathData[I].Point;
            inc(I);
            B[2] := FPathData[I].Point;
            inc(I);
            B[3] := FPathData[I].Point;
            // calc length
            BPts := CreateBezier(B, 6);
            Len := 0;
            for j := 0 to High(BPts) - 1 do
              Len := Len + (Vector(BPts[j]) - Vector(BPts[j + 1])).Length;
            // flatten
            SegCount := Round(Len / F);
            if SegCount < 2 then
            begin
              AddPoint(B[0]);
              AddPoint(B[3]);
            end
            else
            begin
              BPts := CreateBezier(B, SegCount);
              for j := 0 to High(BPts) do
                AddPoint(BPts[j]);
            end;
            CurPoint := FPathData[I].Point;
          end;
        TPathPointKind.ppClose:
          begin
            AddPoint(SP);
            AddPoint(ClosePolygon);
          end;
      end;
      inc(I);
    end;
    Result := PointF(Abs(GetBounds.Width), Abs(GetBounds.Height));
  end;
end;

procedure TPathData.FreeNotification(AObject: TObject);
begin
  if FStyleResource = AObject then
    FStyleResource := nil;
end;

procedure TPathData.AddEllipse(const ARect: TRectF);
var
  cx, cy: Single;
  px, py: Single;
begin
  cx := (ARect.Left + ARect.Right) / 2;
  cy := (ARect.Top + ARect.Bottom) / 2;
  px := CurveKappa * (RectWidth(ARect) / 2);
  py := CurveKappa * (RectHeight(ARect) / 2);
  MoveTo(PointF(ARect.Left, cy));
  CurveTo(PointF(ARect.Left, cy - py), PointF(cx - px, ARect.Top), PointF(cx, ARect.Top));
  CurveTo(PointF(cx + px, ARect.Top), PointF(ARect.Right, cy - py), PointF(ARect.Right, cy));
  CurveTo(PointF(ARect.Right, cy + py), PointF(cx + px, ARect.Bottom), PointF(cx, ARect.Bottom));
  CurveTo(PointF(cx - px, ARect.Bottom), PointF(ARect.Left, cy + py), PointF(ARect.Left, cy));
end;

procedure TPathData.AddRectangle(const ARect: TRectF; const XRadius, YRadius: Single; const ACorners: TCorners;
  const ACornerType: TCornerType = TCornerType.ctRound);
var
  R: TRectF;
  X1, X2, Y1, Y2: Single;
begin
  R := ARect;
  X1 := XRadius;
  if RectWidth(R) - (X1 * 2) < 0 then
    X1 := (XRadius * (RectWidth(R) / (X1 * 2)));
  X2 := X1 / 2;
  Y1 := YRadius;
  if RectHeight(R) - (Y1 * 2) < 0 then
    Y1 := (YRadius * (RectHeight(R) / (Y1 * 2)));
  Y2 := Y1 / 2;

  MoveTo(PointF(R.Left, R.Top + Y1));
  if TCorner.crTopLeft in ACorners then
  begin
    case ACornerType of
      // ctRound - default
      TCornerType.ctBevel:
        LineTo(PointF(R.Left + X1, R.Top));
      TCornerType.ctInnerRound:
        CurveTo(PointF(R.Left + X2, R.Top + Y1), PointF(R.Left + X1, R.Top + Y2), PointF(R.Left + X1, R.Top));
      TCornerType.ctInnerLine:
        begin
          LineTo(PointF(R.Left + X2, R.Top + Y1));
          LineTo(PointF(R.Left + X1, R.Top + Y2));
          LineTo(PointF(R.Left + X1, R.Top));
        end;
    else
      CurveTo(PointF(R.Left, R.Top + (Y2)), PointF(R.Left + X2, R.Top), PointF(R.Left + X1, R.Top))
    end;
  end
  else
  begin
    LineTo(PointF(R.Left, R.Top));
    LineTo(PointF(R.Left + X1, R.Top));
  end;
  LineTo(PointF(R.Right - X1, R.Top));
  if TCorner.crTopRight in ACorners then
  begin
    case ACornerType of
      // ctRound - default
      TCornerType.ctBevel:
        LineTo(PointF(R.Right, R.Top + Y1));
      TCornerType.ctInnerRound:
        CurveTo(PointF(R.Right - X1, R.Top + Y2), PointF(R.Right - X2, R.Top + Y1), PointF(R.Right, R.Top + Y1));
      TCornerType.ctInnerLine:
        begin
          LineTo(PointF(R.Right - X1, R.Top + Y2));
          LineTo(PointF(R.Right - X2, R.Top + Y1));
          LineTo(PointF(R.Right, R.Top + Y1));
        end;
    else
      CurveTo(PointF(R.Right - X2, R.Top), PointF(R.Right, R.Top + (Y2)), PointF(R.Right, R.Top + Y1))
    end;
  end
  else
  begin
    LineTo(PointF(R.Right, R.Top));
    LineTo(PointF(R.Right, R.Top + Y1));
  end;
  LineTo(PointF(R.Right, R.Bottom - Y1));
  if TCorner.crBottomRight in ACorners then
  begin
    case ACornerType of
      // ctRound - default
      TCornerType.ctBevel:
        LineTo(PointF(R.Right - X1, R.Bottom));
      TCornerType.ctInnerRound:
        CurveTo(PointF(R.Right - X2, R.Bottom - Y1), PointF(R.Right - X1, R.Bottom - Y2), PointF(R.Right - X1, R.Bottom));
      TCornerType.ctInnerLine:
        begin
          LineTo(PointF(R.Right - X2, R.Bottom - Y1));
          LineTo(PointF(R.Right - X1, R.Bottom - Y2));
          LineTo(PointF(R.Right - X1, R.Bottom));
        end;
    else
      CurveTo(PointF(R.Right, R.Bottom - (Y2)), PointF(R.Right - X2, R.Bottom), PointF(R.Right - X1, R.Bottom))
    end;
  end
  else
  begin
    LineTo(PointF(R.Right, R.Bottom));
    LineTo(PointF(R.Right - X1, R.Bottom));
  end;
  LineTo(PointF(R.Left + X1, R.Bottom));
  if TCorner.crBottomLeft in ACorners then
  begin
    case ACornerType of
      // ctRound - default
      TCornerType.ctBevel:
        LineTo(PointF(R.Left, R.Bottom - Y1));
      TCornerType.ctInnerRound:
        CurveTo(PointF(R.Left + X1, R.Bottom - Y2), PointF(R.Left + X2, R.Bottom - Y1), PointF(R.Left, R.Bottom - Y1));
      TCornerType.ctInnerLine:
        begin
          LineTo(PointF(R.Left + X1, R.Bottom - Y2));
          LineTo(PointF(R.Left + X2, R.Bottom - Y1));
          LineTo(PointF(R.Left, R.Bottom - Y1));
        end;
    else
      CurveTo(PointF(R.Left + X2, R.Bottom), PointF(R.Left, R.Bottom - (Y2)), PointF(R.Left, R.Bottom - Y1))
    end;
  end
  else
  begin
    LineTo(PointF(R.Left, R.Bottom));
    LineTo(PointF(R.Left, R.Bottom - Y1));
  end;
  ClosePath;
end;

procedure DrawArcWithBezier(Path: TPathData; CenterX, CenterY, RadiusX, RadiusY, StartAngle, SweepRange: Single;
  UseMoveTo: Boolean);
var
  Coord: array of TPointF;
  Pts: array of TPointF;
  A, B, C, X, Y: Single;
  ss, cc: Single;
  I: Integer;
begin
  if SweepRange = 0 then
  begin
    if UseMoveTo then
    begin
      if (Length(Path.FPathData) = 0) then
        Path.MoveTo(PointF(CenterX + RadiusX * Cos(StartAngle), CenterY - RadiusY * Sin(StartAngle)))
      else
        Path.LineTo(PointF(CenterX + RadiusX * Cos(StartAngle), CenterY - RadiusY * Sin(StartAngle)));
    end;
    Path.LineTo(PointF(CenterX + RadiusX * Cos(StartAngle), CenterY - RadiusY * Sin(StartAngle)));
    Exit;
  end;
  B := Sin(SweepRange / 2);
  C := Cos(SweepRange / 2);
  A := 1 - C;
  X := A * 4.0 / 3.0;
  Y := B - X * C / B;
  ss := Sin(StartAngle + SweepRange / 2);
  cc := Cos(StartAngle + SweepRange / 2);
  SetLength(Coord, 4);
  Coord[0] := PointF(C, -B);
  Coord[1] := PointF(C + X, -Y);
  Coord[2] := PointF(C + X, Y);
  Coord[3] := PointF(C, B);
  SetLength(Pts, 4);
  for I := 0 to 3 do
  begin
    Pts[I] := PointF(CenterX + RadiusX * (Coord[I].X * cc - Coord[I].Y * ss),
      CenterY + RadiusY * (Coord[I].X * ss + Coord[I].Y * cc));
  end;
  if UseMoveTo then
  begin
    if (Length(Path.FPathData) = 0) then
      Path.MoveTo(Pts[0])
    else
      Path.LineTo(Pts[0]);
  end;
  Path.CurveTo(Pts[1], Pts[2], Pts[3]);
end;

procedure TPathData.AddArc(const Center, Radius: TPointF; StartAngle, SweepAngle: Single);
const
  bezier_arc_angle_epsilon = 0.01;
var
  UseMoveTo: Boolean;
  I: Integer;
  F: Single;
  total_sweep, local_sweep, prev_sweep: Single;
  done: Boolean;
begin
  StartAngle := DegToRad(StartAngle);
  SweepAngle := DegToRad(SweepAngle);

  I := trunc(StartAngle / (2.0 * cPI));
  F := StartAngle - (I * 2.0 * cPI);

  StartAngle := F;

  if SweepAngle >= 2.0 * cPI then
    SweepAngle := 2.0 * cPI;
  if SweepAngle <= -2.0 * cPI then
    SweepAngle := -2.0 * cPI;

  if Abs(SweepAngle) < 1E-10 then
  begin
    Exit;
  end;

  total_sweep := 0.0;

  done := False;
  UseMoveTo := True;
  repeat
    if SweepAngle < 0.0 then
    begin
      prev_sweep := total_sweep;
      local_sweep := -cPI * 0.5;
      total_sweep := total_sweep - (cPI * 0.5);
      if total_sweep <= SweepAngle + bezier_arc_angle_epsilon then
      begin
        local_sweep := SweepAngle - prev_sweep;
        done := True;
      end;
    end
    else
    begin
      prev_sweep := total_sweep;
      local_sweep := cPI * 0.5;
      total_sweep := total_sweep + (Pi * 0.5);
      if total_sweep >= SweepAngle - bezier_arc_angle_epsilon then
      begin
        local_sweep := SweepAngle - prev_sweep;
        done := True;
      end;
    end;
    DrawArcWithBezier(Self, Center.X, Center.Y, Radius.X, Radius.Y, StartAngle, local_sweep, UseMoveTo);
    UseMoveTo := False;
    StartAngle := StartAngle + local_sweep;
  until done;
end;

procedure TPathData.AddArcSvgPart(const Center, Radius: TPointF; StartAngle, SweepAngle: Single);
const
  bezier_arc_angle_epsilon = 0.01;
var
  UseMoveTo: Boolean;
  I: Integer;
  F: Single;
  total_sweep, local_sweep, prev_sweep: Single;
  done: Boolean;
begin
  StartAngle := DegToRad(StartAngle);
  SweepAngle := DegToRad(SweepAngle);

  I := trunc(StartAngle / (2.0 * cPI));
  F := StartAngle - (I * 2.0 * cPI);

  StartAngle := F;

  if SweepAngle >= 2.0 * cPI then
    SweepAngle := 2.0 * cPI;
  if SweepAngle <= -2.0 * cPI then
    SweepAngle := -2.0 * cPI;

  if Abs(SweepAngle) < 1E-10 then
  begin
    Exit;
  end;

  total_sweep := 0.0;

  done := False;
  UseMoveTo := False;
  repeat
    if SweepAngle < 0.0 then
    begin
      prev_sweep := total_sweep;
      local_sweep := -cPI * 0.5;
      total_sweep := total_sweep - (cPI * 0.5);
      if total_sweep <= SweepAngle + bezier_arc_angle_epsilon then
      begin
        local_sweep := SweepAngle - prev_sweep;
        done := True;
      end;
    end
    else
    begin
      prev_sweep := total_sweep;
      local_sweep := cPI * 0.5;
      total_sweep := total_sweep + (Pi * 0.5);
      if total_sweep >= SweepAngle - bezier_arc_angle_epsilon then
      begin
        local_sweep := SweepAngle - prev_sweep;
        done := True;
      end;
    end;
    DrawArcWithBezier(Self, Center.X, Center.Y, Radius.X, Radius.Y, StartAngle, local_sweep, UseMoveTo);
    UseMoveTo := False;
    StartAngle := StartAngle + local_sweep;
  until done;
end;

procedure TPathData.AddArcSvg(const P1, Radius: TPointF; Angle: Single; const LargeFlag, SweepFlag: Boolean;
  const P2: TPointF);
var
  I: Integer;
  m_radii_ok: Boolean;
  V, P, N, sq, rx, ry, x0, y0, X1, Y1, X2, Y2, cx, cy, ux, uy, vx, vy,

    dx2, dy2, prx, pry, px1, py1, cx1, cy1, sx2, sy2,

    sign, coef,

    radii_check, start_angle, sweep_angle,

    cos_a, sin_a: Single;
  tm: TMatrix;
  len: Integer;
begin
  // Trivial case: Arc transformate to point
  if P1 = P2 then
    Exit;

  rx := Radius.X;
  ry := Radius.Y;
  x0 := P1.X;
  y0 := P1.Y;
  X2 := P2.X;
  Y2 := P2.Y;
  Angle := DegToRad(Angle);

  m_radii_ok := True;

  if rx < 0.0 then
    rx := -rx;

  if ry < 0.0 then
    ry := -rx;

  // Calculate the middle point between
  // the current and the final points
  dx2 := (x0 - X2) / 2.0;
  dy2 := (y0 - Y2) / 2.0;

  // Convert angle from degrees to radians
  cos_a := Cos(Angle);
  sin_a := Sin(Angle);

  // Calculate (x1, y1)
  X1 := cos_a * dx2 + sin_a * dy2;
  Y1 := -sin_a * dx2 + cos_a * dy2;

  // Ensure radii are large enough
  prx := rx * rx;
  pry := ry * ry;
  px1 := X1 * X1;
  py1 := Y1 * Y1;

  // Check that radii are large enough
  radii_check := px1 / prx + py1 / pry;

  if radii_check > 1.0 then
  begin
    rx := Sqrt(radii_check) * rx;
    ry := Sqrt(radii_check) * ry;
    prx := rx * rx;
    pry := ry * ry;

    if radii_check > 10.0 then
      m_radii_ok := False;

  end;

  // Calculate (cx1, cy1)
  if LargeFlag = SweepFlag then
    sign := -1.0
  else
    sign := 1.0;

  sq := (prx * pry - prx * py1 - pry * px1) / (prx * py1 + pry * px1);

  if sq < 0 then
    coef := sign * Sqrt(0)
  else
    coef := sign * Sqrt(sq);

  cx1 := coef * ((rx * Y1) / ry);
  cy1 := coef * -((ry * X1) / rx);

  // Calculate (cx, cy) from (cx1, cy1)
  sx2 := (x0 + X2) / 2.0;
  sy2 := (y0 + Y2) / 2.0;
  cx := sx2 + (cos_a * cx1 - sin_a * cy1);
  cy := sy2 + (sin_a * cx1 + cos_a * cy1);

  // Calculate the start_angle (angle1) and the sweep_angle (dangle)
  ux := (X1 - cx1) / rx;
  uy := (Y1 - cy1) / ry;
  vx := (-X1 - cx1) / rx;
  vy := (-Y1 - cy1) / ry;

  // Calculate the angle start
  N := Sqrt(ux * ux + uy * uy);
  P := ux; // (1 * ux ) + (0 * uy )

  if uy < 0 then
    sign := -1.0
  else
    sign := 1.0;

  V := P / N;

  if V < -1.0 then
    V := -1.0;

  if V > 1.0 then
    V := 1.0;

  start_angle := sign * ArcCos(V);

  // Calculate the sweep angle
  N := Sqrt((ux * ux + uy * uy) * (vx * vx + vy * vy));
  P := ux * vx + uy * vy;

  if ux * vy - uy * vx < 0 then
    sign := -1.0
  else
    sign := 1.0;

  V := P / N;

  if V < -1.0 then
    V := -1.0;

  if V > 1.0 then
    V := 1.0;

  sweep_angle := sign * ArcCos(V);

  if (not SweepFlag) and (sweep_angle > 0) then
    sweep_angle := sweep_angle - Pi * 2.0
  else if SweepFlag and (sweep_angle < 0) then
    sweep_angle := sweep_angle + Pi * 2.0;

  len := Count;
  AddArcSvgPart(PointF(0, 0), PointF(rx, ry), RadToDeg(start_angle), RadToDeg(sweep_angle));

  tm := IdentityMatrix;
  tm.m31 := cx;
  tm.m32 := cy;
  tm := MatrixMultiply(CreateRotationMatrix(Angle), tm);

  I := len;
  while I < Count do
  begin
    FPathData[I].Point := tm.Transform(Vector(FPathData[I].Point)).ToPointF;
    Inc(I);
  end;
end;

function TPathData.IsEmpty: Boolean;
begin
  Result := (Length(FPathData) = 0) or (GetBounds.Width * GetBounds.Height = 0);
end;

function TPathData.GetPathString: string;
var
  I: Integer;
  Builder: TStringBuilder;
begin
  Builder := TStringBuilder.Create;
  Result := Builder.ToString;
  try
    I := 0;
    while I < Count do
    begin
      case FPathData[I].Kind of
        TPathPointKind.ppMoveTo:
          Builder.Append('M')
                 .Append(FloatToStr(FPathData[I].Point.X, USFormatSettings))
                 .Append(',')
                 .Append(FloatToStr(FPathData[I].Point.Y, USFormatSettings))
                 .Append(' ');
        TPathPointKind.ppLineTo:
          Builder.Append('L')
                 .Append(FloatToStr(FPathData[I].Point.X, USFormatSettings))
                 .Append(',')
                 .Append(FloatToStr(FPathData[I].Point.Y, USFormatSettings))
                 .Append(' ');
        TPathPointKind.ppCurveTo:
          begin
            Builder.Append('C')
                   .Append(FloatToStr(FPathData[I].Point.X, USFormatSettings))
                   .Append(',')
                   .Append(FloatToStr(FPathData[I].Point.Y, USFormatSettings))
                   .Append(' ');

            Builder.Append(FloatToStr(FPathData[I + 1].Point.X, USFormatSettings))
                   .Append(',')
                   .Append(FloatToStr(FPathData[I + 1].Point.Y, USFormatSettings))
                   .Append(' ');

            Builder.Append(FloatToStr(FPathData[I + 2].Point.X, USFormatSettings))
                   .Append(',')
                   .Append(FloatToStr(FPathData[I + 2].Point.Y, USFormatSettings))
                   .Append(' ');

            Inc(I, 2);
          end;
        TPathPointKind.ppClose:
          Builder.Append('Z ');
      end;
      Inc(I);
    end;
    Result := Builder.ToString;
  finally
    Builder.Free;
  end;
end;

function TPathData.GetTok(const S: string; var Pos: Integer): string;
var
  StringBuilder: TStringBuilder;
begin
  StringBuilder := TStringBuilder.Create;
  try
    Result := StringBuilder.ToString;
    if Pos >= Length(S) then
      Exit;
    while (Pos < S.Length) and S.Chars[Pos].IsInArray([' ']) do
      Inc(Pos);

    while Pos < S.Length do
    begin
      if not 'zmlchvsqtaZMLCHVSQTA'.Contains(S.Chars[Pos]) then
        Break;
      StringBuilder.Append(S.Chars[Pos]);
      Inc(Pos);
    end;
    Result := StringBuilder.ToString;
  finally
    StringBuilder.Free;
  end;
end;

function TPathData.GetNum(const S: string; var Pos: Integer): string;
var
  StringBuilder: TStringBuilder;
begin
  StringBuilder := TStringBuilder.Create;
  try
    Result := '';
    if Pos > S.Length - 1 then
      Exit;
    while (Pos < S.Length) and S.Chars[Pos].IsInArray([' ']) do
      Inc(Pos);
    while Pos < S.Length do
    begin
      if (S.Chars[Pos] = 'e') then
      begin
        StringBuilder.Append(S.Chars[Pos]);
        Inc(Pos);
        Continue;
      end;
      if (S.Chars[Pos] = '-') and (StringBuilder.Length > 0) and (StringBuilder.Chars[StringBuilder.Length - 1] = 'e') then
      begin
        StringBuilder.Append(S.Chars[Pos]);
        Inc(Pos);
        Continue;
      end;
      if (StringBuilder.Length > 0) and (S.Chars[Pos] = '-') then
        Break;
     if not '0123456789.'.Contains(S.Chars[Pos]) and not (S.Chars[Pos] = '-') then
        Break;
      StringBuilder.Append(S.Chars[Pos]);
      Inc(Pos);
    end;
    while S.Chars[Pos].IsInArray([' ']) do
      Inc(Pos);
    Result := StringBuilder.ToString;
  finally
    StringBuilder.Free;
  end;
end;

function TPathData.GetPointFromStr(const S: string; var Pos: Integer): TPointF;
var
  X, Y: string;
begin
  Result := PointF(0, 0);
  if Pos >= S.Length then
    Exit;
  while (Pos < S.Length) and S.Chars[Pos].IsInArray([',', ' ']) do
    Inc(Pos);
  X := GetNum(S, Pos);
  while (Pos < S.Length) and S.Chars[Pos].IsInArray([',', ' ']) do
    Inc(Pos);
  Y := GetNum(S, Pos);
  while (Pos < S.Length) and S.Chars[Pos].IsInArray([',', ' ']) do
    Inc(Pos);
  Result := PointF(StrToFloat(X, USFormatSettings), StrToFloat(Y, USFormatSettings));
end;

procedure TPathData.SetPathString(const Value: string);
var
  PathString, toks: string;
  Token: Char;
  R, CP1, CP2: TPointF;
  Angle: Single;
  large, sweet: Boolean;
  Pos, I: Integer;
  PointFTmp: TPointF;
  Builder: TStringBuilder;
  TokenBuilder: TStringBuilder;
  LastLength: Integer;
begin
  Builder := TStringBuilder.Create;
  TokenBuilder := TStringBuilder.Create;
  try
    { change every #10#13 to space }
    for I := 0 to Value.Length - 1 do
    begin
      if Value.Chars[I].IsInArray([#9, #10, #13]) then
        Builder.Append(' ')
      else
        Builder.Append(Value.Chars[I]);
    end;
    PathString := Builder.ToString;

    { }
    SetLength(FPathData, 0);
    Pos := 0;
    LastLength := -1;
    while (Builder.Length > Pos) and (LastLength <> Pos) do
    begin
      LastLength := Pos;
      toks := GetTok(PathString, Pos);
      TokenBuilder.Clear;
      TokenBuilder.Append(toks);

      while TokenBuilder.Length > 0 do
      begin
        Token := TokenBuilder.Chars[0];
        TokenBuilder.Remove(0, 1);
        try
          if Token.IsInArray(['z', 'Z']) then
            ClosePath;
          if (Token = 'M') then
          begin
            MoveTo(GetPointFromStr(PathString, Pos));
            while (PathString.Chars[Pos].IsDigit or (PathString.Chars[Pos] = '-')) do
            begin
              { next points }
              LineTo(GetPointFromStr(PathString, Pos));
            end;
          end;
          if (Token = 'm') then
          begin
            MoveToRel(GetPointFromStr(PathString, Pos));
            while (PathString.Chars[Pos].IsDigit or (PathString.Chars[Pos] = '-')) do
            begin
              { next points }
              LineToRel(GetPointFromStr(PathString, Pos));
            end;
          end;
          if (Token = 'L') then
          begin
            LineTo(GetPointFromStr(PathString, Pos));
            while (PathString.Chars[Pos].IsDigit or (PathString.Chars[Pos] = '-')) do
            begin
              { next points }
              LineTo(GetPointFromStr(PathString, Pos));
            end;
          end;
          if (Token = 'l') then
          begin
            LineToRel(GetPointFromStr(PathString, Pos));
            while (PathString.Chars[Pos].IsDigit or (PathString.Chars[Pos] = '-')) do
            begin
              { next points }
              LineToRel(GetPointFromStr(PathString, Pos));
            end;
          end;
          if (Token = 'C') then
          begin
            CP1 := GetPointFromStr(PathString, Pos);
            CP2 := GetPointFromStr(PathString, Pos);
            CurveTo(CP1, CP2, GetPointFromStr(PathString, Pos));
            while (PathString.Chars[Pos].IsDigit or (PathString.Chars[Pos] = '-')) do
            begin
              { next points }
              CP1 := GetPointFromStr(PathString, Pos);
              CP2 := GetPointFromStr(PathString, Pos);
              CurveTo(CP1, CP2, GetPointFromStr(PathString, Pos));
            end;
          end;
          if (Token = 'c') then
          begin
            CP1 := GetPointFromStr(PathString, Pos);
            CP2 := GetPointFromStr(PathString, Pos);
            CurveToRel(CP1, CP2, GetPointFromStr(PathString, Pos));
            while (PathString.Chars[Pos].IsDigit or (PathString.Chars[Pos] = '-')) do
            begin
              { next points }
              CP1 := GetPointFromStr(PathString, Pos);
              CP2 := GetPointFromStr(PathString, Pos);
              CurveToRel(CP1, CP2, GetPointFromStr(PathString, Pos));
            end;
          end;
          if (Token = 'S') then
          begin
            CP2 := GetPointFromStr(PathString, Pos);
            SmoothCurveTo(CP2, GetPointFromStr(PathString, Pos));
            while (PathString.Chars[Pos].IsDigit or (PathString.Chars[Pos] = '-')) do
            begin
              { next points }
              CP2 := GetPointFromStr(PathString, Pos);
              SmoothCurveTo(CP2, GetPointFromStr(PathString, Pos));
            end;
          end;
          if (Token = 's') then
          begin
            CP2 := GetPointFromStr(PathString, Pos);
            SmoothCurveToRel(CP2, GetPointFromStr(PathString, Pos));
            while (PathString.Chars[Pos].IsDigit or (PathString.Chars[Pos] = '-')) do
            begin
              { next points }
              CP2 := GetPointFromStr(PathString, Pos);
              SmoothCurveToRel(CP2, GetPointFromStr(PathString, Pos));
            end;
          end;
          if (Token = 'H') then
          begin
            // skip horizontal line
            HLineTo(StrToFloat(GetNum(PathString, Pos), USFormatSettings));
          end;
          if (Token = 'h') then
          begin
            // skip horizontal line
            HLineToRel(StrToFloat(GetNum(PathString, Pos), USFormatSettings));
          end;
          if (Token = 'V') then
          begin
            // skip vertical line
            VLineTo(StrToFloat(GetNum(PathString, Pos), USFormatSettings));
          end;
          if (Token = 'v') then
          begin
            // skip vertical line
            VLineToRel(StrToFloat(GetNum(PathString, Pos), USFormatSettings));
          end;
          if (Token = 'Q') then
          begin
            // skip quadratic bezier
            GetPointFromStr(PathString, Pos);
            GetPointFromStr(PathString, Pos);
          end;
          if (Token = 'q') then
          begin
            // skip quadratic bezier
            GetPointFromStr(PathString, Pos);
            GetPointFromStr(PathString, Pos);
          end;
          if (Token = 'T') then
          begin
            // skip show qudratic bezier
            GetPointFromStr(PathString, Pos);
          end;
          if (Token = 't') then
          begin
            // skip show qudratic bezier
            GetPointFromStr(PathString, Pos);
          end;
          if (Token = 'A') then
          begin
            // arc
            if Count > 0 then
              CP1 := FPathData[High(FPathData)].Point
            else
              CP1 := PointF(0, 0);
            R := GetPointFromStr(PathString, Pos);
            Angle := StrToFloat(GetNum(PathString, Pos), USFormatSettings);

            PointFTmp := GetPointFromStr(PathString, Pos);
            large := PointFTmp.X = 1;
            sweet := PointFTmp.Y = 1;
            CP2 := GetPointFromStr(PathString, Pos);
            AddArcSvg(CP1, R, Angle, large, sweet, CP2);
          end;
          if (Token = 'a') then
          begin
            // arc rel
            if Count > 0 then
              CP1 := FPathData[High(FPathData)].Point
            else
              CP1 := PointF(0, 0);
            R := GetPointFromStr(PathString, Pos);
            Angle := StrToFloat(GetNum(PathString, Pos), USFormatSettings);
            PointFTmp := GetPointFromStr(PathString, Pos);
            large := PointFTmp.X = 1;
            sweet := PointFTmp.Y = 1;
            CP2 := GetPointFromStr(PathString, Pos);
            CP2.X := CP1.X + CP2.X;
            CP2.Y := CP1.Y + CP2.Y;
            AddArcSvg(CP1, R, Angle, large, sweet, CP2);
          end;
        except
        end;
      end;
    end;
    FRecalcBounds := True;
    if Assigned(FOnChanged) then
      FOnChanged(Self);
  finally
    TokenBuilder.Free;
    Builder.Free;
  end;
end;


{ TCanvasManager }


class procedure TCanvasManager.UnInitialize;
var
  CanvasSrv: IFMXCanvasService;
begin
  FreeAndNil(FMeasureBitmap);
  FreeAndNil(FCanvasList);
  if TPlatformServices.Current.SupportsPlatformService(IFMXCanvasService, IInterface(CanvasSrv)) then
    CanvasSrv.UnregisterCanvasClasses;
end;

class function TCanvasManager.CreateFromBitmap(const ABitmap: TBitmap; const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault): TCanvas;
begin
  Result := DefaultCanvas.CreateFromBitmap(ABitmap, AQuality);
end;

class function TCanvasManager.CreateFromPrinter(const APrinter: TAbstractPrinter): TCanvas;
begin
  Result := DefaultPrinterCanvas.CreateFromPrinter(APrinter);
end;

class function TCanvasManager.CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
  const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault): TCanvas;
begin
  Result := DefaultCanvas.CreateFromWindow(AParent, AWidth, AHeight, AQuality);
end;

class function TCanvasManager.GetDefaultCanvas: TCanvasClass;
var
  CanvasSrv: IFMXCanvasService;
  CanvasClassRec: TCanvasClassRec;
begin
  if not Assigned(FDefaultCanvasClass) then
  begin
    Result := nil;
    if not Assigned(FCanvasList) then
      if TPlatformServices.Current.SupportsPlatformService(IFMXCanvasService, IInterface(CanvasSrv)) then
        CanvasSrv.RegisterCanvasClasses;
    if Assigned(FCanvasList) and (FCanvasList.Count > 0) then
    begin
      for CanvasClassRec in FCanvasList do
      begin
        if CanvasClassRec.Default and
          (not FEnableSoftwareCanvas and (TCanvasStyle.NeedGPUSurface in CanvasClassRec.CanvasClass.GetCanvasStyle)) then
        begin
          Result := CanvasClassRec.CanvasClass;
          Break;
        end;
        if CanvasClassRec.Default and
          (FEnableSoftwareCanvas and not (TCanvasStyle.NeedGPUSurface in CanvasClassRec.CanvasClass.GetCanvasStyle)) then
        begin
          Result := CanvasClassRec.CanvasClass;
          Break;
        end;
      end;
      if not Assigned(Result) and FEnableSoftwareCanvas then
      begin
        for CanvasClassRec in FCanvasList do
        begin
          if not (TCanvasStyle.NeedGPUSurface in CanvasClassRec.CanvasClass.GetCanvasStyle) then
          begin
            Result := CanvasClassRec.CanvasClass;
            Break;
          end;
        end;
      end;
      if not Assigned(Result) then
        Result := FCanvasList[0].CanvasClass;
      FDefaultCanvasClass := Result;
    end
    else
      raise ECanvasManagerException.Create('No TCanvas implementation found');
  end
  else
    Result := FDefaultCanvasClass;
end;

class function TCanvasManager.GetDefaultPrinterCanvas: TCanvasClass;
var
  CanvasSrv: IFMXCanvasService;
  CanvasClassRec: TCanvasClassRec;
begin
  if not Assigned(FDefaultPrinterCanvasClass) then
  begin
    Result := nil;
    if not Assigned(FCanvasList) then
      if TPlatformServices.Current.SupportsPlatformService(IFMXCanvasService, IInterface(CanvasSrv)) then
        CanvasSrv.RegisterCanvasClasses;
    if Assigned(FCanvasList) and (FCanvasList.Count > 0) then
    begin
      for CanvasClassRec in FCanvasList do
        if CanvasClassRec.PrinterCanvas then
        begin
          Result := CanvasClassRec.CanvasClass;
          Break;
        end;
      FDefaultPrinterCanvasClass := Result;
    end
    else
      raise ECanvasManagerException.Create('No TCanvas for printer implementation found');
  end
  else
    Result := FDefaultPrinterCanvasClass;
end;

class function TCanvasManager.GetMeasureCanvas: TCanvas;
begin
  if not Assigned(FMeasureBitmap) then
    FMeasureBitmap := TBitmap.Create(1, 1);
  Result := FMeasureBitmap.Canvas
end;

class procedure TCanvasManager.RecreateFromPrinter(const Canvas: TCanvas; const APrinter: TAbstractPrinter);
begin
  Canvas.UnInitialize;
  Canvas.CreateFromPrinter(APrinter);
end;

class procedure TCanvasManager.EnableSoftwareCanvas(const Enable: Boolean);
begin
  FEnableSoftwareCanvas := Enable;
  FDefaultCanvasClass := nil;
end;

class procedure TCanvasManager.RegisterCanvas(const CanvasClass: TCanvasClass; const ADefault: Boolean; const APrinterCanvas: Boolean);
var
  Rec: TCanvasClassRec;
begin
  if Not Assigned(FCanvasList) then
    FCanvasList := TList<TCanvasClassRec>.Create;
  Rec.CanvasClass := CanvasClass;
  Rec.Default := ADefault;
  Rec.PrinterCanvas := APrinterCanvas;
  FCanvasList.Add(Rec);
end;

{ TCanvas }

constructor TCanvas.CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
  const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault);
begin
  inherited Create;
  FQuality := AQuality;
  FParent := AParent;
  FWidth := AWidth;
  FHeight := AHeight;
  Initialize;
end;

class procedure TCanvas.CopyBitmap(const Source, Dest: TBitmap);
var
  S, D: TBitmapData;
begin
  if (Source.Width = Dest.Width) and (Source.Height = Dest.Height) then
  begin
    if not Source.IsEmpty then
    begin
      if (Source.CanvasClass = Dest.CanvasClass) then
        Source.CanvasClass.DoCopyBitmap(Source, Dest)
      else begin
        if Source.Map(TMapAccess.maRead, S) and Dest.Map(TMapAccess.maWrite, D) then
        try
          D.Copy(S);
        finally
          Source.Unmap(S);
          Dest.Unmap(D);
        end;
      end;
    end;
  end else
    raise ECanvasException.Create(SBitmapSizeNotEqual);
end;

constructor TCanvas.CreateFromBitmap(const ABitmap: TBitmap; const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault);
begin
  inherited Create;
  FQuality := AQuality;
  FBitmap := ABitmap;
  FWidth := ABitmap.Width;
  FHeight := ABitmap.Height;
  Initialize;
end;

constructor TCanvas.CreateFromPrinter(const APrinter: TAbstractPrinter);
begin
  inherited Create;
  Initialize;
  FPrinter := APrinter;
end;

procedure TCanvas.Initialize;
begin
  FScale := GetCanvasScale;
  FStroke := TStrokeBrush.Create(TBrushKind.bkSolid, $FF000000);
  FFill := TBrush.Create(TBrushKind.bkSolid, $FFFFFFFF);
  FFont := TFont.Create;
  FFont.OnChanged := FontChanged;
  FCanvasSaveData := TCanvasSaveStateList.Create;
  FMatrixMeaning := TMatrixMeaning.mmIdentity;
  FBlending := True;
end;

procedure TCanvas.UnInitialize;
begin
  FCanvasSaveData.DisposeOf;
  FFont.DisposeOf;
  FStroke.DisposeOf;
  FFill.DisposeOf;
end;

destructor TCanvas.Destroy;
begin
  TMessageManager.DefaultManager.SendMessage(Self, TCanvasDestroyMessage.Create);
  UnInitialize;
  inherited;
end;

function TCanvas.DoBeginScene(const AClipRects: PClipRects = nil; AContextHandle: THandle = 0): Boolean;
begin
  FClippingChangeCount := 0;
  FSavingStateCount := 0;

  Stroke.Thickness := 1;
  Stroke.Cap := TStrokeCap.scFlat;
  Stroke.Join := TStrokeJoin.sjMiter;
  Stroke.Dash := TStrokeDash.sdSolid;
  Stroke.Kind := TBrushKind.bkSolid;
  Fill.Kind := TBrushKind.bkSolid;
  SetMatrix(IdentityMatrix);
  Result := True;
end;

procedure TCanvas.DoBlendingChanged;
begin

end;

class procedure TCanvas.DoCopyBitmap(const Source, Dest: TBitmap);
var
  S, D: TBitmapData;
begin
  if Source.Map(TMapAccess.maRead, S) and Dest.Map(TMapAccess.maWrite, D) then
  try
    D.Copy(S);
  finally
    Source.Unmap(S);
    Dest.Unmap(D);
  end;
end;

procedure TCanvas.DoEndScene;
begin
  if FBitmap <> nil then
    FBitmap.BitmapChanged;
end;

function TCanvas.BeginScene(AClipRects: PClipRects = nil; AContextHandle: THandle = 0): Boolean;
begin
  if FBeginSceneCount = 0 then
    Result := (Width > 0) and (Height > 0) and DoBeginScene(AClipRects, AContextHandle)
  else
    Result := FBeginSceneCount > 0;
  if Result then
    inc(FBeginSceneCount);
end;

procedure TCanvas.EndScene;
begin
  if FBeginSceneCount = 1 then
    DoEndScene;
  if FBeginSceneCount > 0 then
    dec(FBeginSceneCount);
end;

procedure TCanvas.SetMatrix(const M: TMatrix);
begin
  FMatrixMeaning := TMatrixMeaning.mmUnknown;
  FMatrix := M;

  { Check for identity matrix values. It is assumed that the matrix is composed of
    three vectors of unit length, so by comparing some specific values with one,
    we discard any other possibility of other vectors. }
  if SameValue(FMatrix.m11, 1.0, Epsilon) and SameValue(FMatrix.m22, 1.0, Epsilon) and SameValue(FMatrix.m33, 1.0, Epsilon) then
  begin
    if SameValue(FMatrix.m31, 0.0, Epsilon) and SameValue(FMatrix.m32, 0.0, Epsilon) then
    begin // If no translation is present, we have an identity matrix.
      FMatrixMeaning := TMatrixMeaning.mmIdentity;
    end
    else
    begin // Translation information is present in the matrix.
      FMatrixMeaning := TMatrixMeaning.mmTranslate;

      FMatrixTranslate.X := FMatrix.m31;
      FMatrixTranslate.Y := FMatrix.m32;
    end;
  end;
end;

procedure TCanvas.MultiplyMatrix(const M: TMatrix);
var
  MulMatrix: TMatrix;
begin
  MulMatrix := MatrixMultiply(FMatrix, M);
  SetMatrix(MulMatrix);
end;

function TCanvas.CreateSaveState: TCanvasSaveState;
begin
  Result := TCanvasSaveState.Create;
end;

procedure TCanvas.RestoreState(const State: TCanvasSaveState);
begin
  if FCanvasSaveData.IndexOf(State) >= 0 then
    Assign(State);
end;

procedure TCanvas.FontChanged(Sender: TObject);
begin
end;

class procedure TCanvas.InitializeBitmap(const Bitmap: TBitmap);
begin
  if Assigned(Bitmap) and not Bitmap.IsEmpty then
    DoInitializeBitmap(Bitmap);
end;

class procedure TCanvas.FinalizeBitmap(const Bitmap: TBitmap);
begin
  if Assigned(Bitmap) and (Bitmap.FHandle <> 0) then
  begin
    DoFinalizeBitmap(Bitmap);
    Bitmap.FHandle := 0;
  end;
end;

class function TCanvas.MapBitmap(const Bitmap: TBitmap; const Access: TMapAccess; var Data: TBitmapData): Boolean;
begin
  if Assigned(Bitmap) and Bitmap.HandleAllocated then
    Result := DoMapBitmap(Bitmap, Access, Data)
  else
    Result := False;
end;

class procedure TCanvas.UnmapBitmap(const Bitmap: TBitmap; var Data: TBitmapData);
begin
  if Assigned(Bitmap) and Bitmap.HandleAllocated then
    DoUnmapBitmap(Bitmap, Data);
end;

function TCanvas.LoadFontFromStream(const AStream: TStream): Boolean;
begin
  Result := False;
                                                       
end;

procedure TCanvas.MeasureLines(const ALines: TLineMetricInfo; const ARect: TRectF; const AText: string; const WordWrap: Boolean; const Flags: TFillTextFlags;
  const ATextAlign: TTextAlign; const AVTextAlign: TTextAlign = TTextAlign.taCenter);
var
  WStartChar, WSaveChar, WCurChar, WCutOffChar: Integer;
  LCurChar: Integer;
  TmpS: string;
  WWidth: Single;
  LEditRectWidth: Single;
  Tok, LText: string;

  function _IsSurrogate(Surrogate: WideChar): Boolean;
  begin
    Result := (Integer(Surrogate) >= $D800) and (Integer(Surrogate) <= $DFFF);
  end;

  procedure _SkipSeparators(var Pos: Integer; const S: string);
  const
    // #$0020   SPACE
    // #$0021 ! EXCLAMATION MARK
    // #$002C , COMMA
    // #$002D - HYPHEN-MINUS
    // #$002E . FULL STOP
    // #$003A : COLON
    // #$003B ; SEMICOLON
    // #$003F ? QUESTION MARK
    BasicSeparatos: string = #$0020#$0021#$002C#$002D#$002E#$003A#$003B#$003F;
    MaxBasicSeparators: WideChar = #$003F;
  var
    ch: WideChar;
  begin
    while Pos < S.Length do
    begin
      ch := S.Chars[Pos];
      if (ch > MaxBasicSeparators) or not BasicSeparatos.Contains(ch) then
        Break;
      if _IsSurrogate(ch) then
        Inc(Pos, 2)
      else
        Inc(Pos);
    end;
  end;

  function _WideGetToken(var Pos: Integer; const S: string): string;
  const
  //#$0020   SPACE
  //#$0021 ! EXCLAMATION MARK
  //#$002C , COMMA
  //#$002D - HYPHEN-MINUS
  //#$002E . FULL STOP
  //#$003A : COLON
  //#$003B ; SEMICOLON
  //#$003F ? QUESTION MARK
    BasicSeparatos: string = #$0020#$0021#$002C#$002D#$002E#$003A#$003B#$003F;
    MaxBasicSeparators: WideChar = #$003F;
  var
    ch: WideChar;
  begin
    Result := '';
    { skip first separators }
    _SkipSeparators(Pos, S);

    { get }
    while Pos < S.Length do
    begin
      ch := S.Chars[Pos];
      if (ch <= MaxBasicSeparators) and BasicSeparatos.Contains(ch) then
        Break;
      if _IsSurrogate(ch) then
      begin
        Result := Result + S.Substring(Pos, 2);
        Inc(Pos, 2)
      end
      else
      begin
        Result := Result + S.Chars[Pos];
        Inc(Pos);
      end;
    end;

    { skip separators }
    _SkipSeparators(Pos, S);
  end;

  function RoundToPowerOf2(I: Integer): Integer;
  begin
    I := I or (I shr 1);
    I := I or (I shr 2);
    I := I or (I shr 4);
    I := I or (I shr 8);
    I := I or (I shr 16);
    Result := I + 1;
  end;

  function CutOffPoint(TmpS: string; Width: Single): integer;
  var
    W : Single;
    Delta: Integer;
  begin
    Delta := RoundToPowerOf2(Tmps.Length) div 2;
    Result := Delta;

    while Delta > 0 do
    begin
      W := TextWidth(TmpS.Substring(0, Result));
      if W > Width then
        Result := Result - Delta;
      Delta := Delta div 2;
      Result := Result + Delta;
    end;
  end;

begin
  ALines.Count := 0;
  if AText = '' then
    Exit;

  ALines.Count := 1;
  LEditRectWidth := ARect.Width;

  // first check linecreaks
  LText := AText;
  TmpS := '';

  LCurChar := 0;

  ALines.Count := 1;
  ALines.Metrics[0].Index := 1;
  while LCurChar < LText.Length do
  begin
    if (LText.Chars[LCurChar] = #13) or (LText.Chars[LCurChar] = #10) then
    begin
      if (LText.Chars[LCurChar] = #13) and (LCurChar + 1 < LText.Length) then
        if LText.Chars[LCurChar + 1] = #10 then
          Inc(LCurChar);

      if WordWrap and (TextWidth(TmpS) > LEditRectWidth) then
      begin
        WCurChar := 0;
        WStartChar := 0;
        WSaveChar := 0;
        Tok := _WideGetToken(WCurChar, TmpS);
        while Tok <> '' do
        begin
          WWidth := TextWidth(TmpS.Substring(WStartChar, WCurChar - WStartChar));
          if WWidth > LEditRectWidth then
          begin
            if WSaveChar = WStartChar then
            begin
              WCutOffChar := CutOffPoint(TmpS.Substring(WStartChar, WCurChar - WStartChar), LEditRectWidth);
              ALines.Metrics[ALines.Count - 1].Len := WCutoffChar;
              WCurChar := WStartChar + WCutOffChar;
              WStartChar := WStartChar + WCutOffChar;
            end
            else
            begin
              ALines.Metrics[ALines.Count - 1].Len := WSaveChar - WStartChar;
              WStartChar := WSaveChar;
            end;
            ALines.Count := ALines.Count + 1;
            ALines.Metrics[ALines.Count - 1].Index :=
              ALines.Metrics[ALines.Count - 2].Index + ALines.Metrics[ALines.Count - 2].Len;
          end;
          WSaveChar := WCurChar;
          Tok := _WideGetToken(WCurChar, TmpS);
          if WSaveChar = WCurChar then
            Break; { !!! - error }
        end;

        ALines.Metrics[ALines.Count - 1].Len := WCurChar - WStartChar;
      end
      else
        ALines.Metrics[ALines.Count - 1].Len := Length(Tmps);

      ALines.Count := ALines.Count + 1;
      ALines.Metrics[ALines.Count - 1].Index := LCurChar + 2;

      TmpS := '';
    end
    else
      TmpS := TmpS + LText.Chars[LCurChar];
    Inc(LCurChar);
  end;

// last line
  if WordWrap and (TextWidth(TmpS) > LEditRectWidth) then
  begin
    WCurChar := 0;
    WStartChar := 0;
    WSaveChar := 0;
    Tok := _WideGetToken(WCurChar, TmpS);
    while Tok <> '' do
    begin
      Tok := TmpS.Substring(WStartChar, WCurChar - WStartChar);
      WWidth := TextWidth(TmpS.Substring(WStartChar, WCurChar - WStartChar));
      if WWidth > LEditRectWidth then
      begin
        if WSaveChar = WStartChar then
        begin
          WCutOffChar := CutOffPoint(TmpS.Substring(WStartChar, WCurChar - WStartChar), LEditRectWidth);
          ALines.Metrics[ALines.Count - 1].Len := WCutoffChar;
          WCurChar := WStartChar + WCutOffChar;
          WStartChar := WStartChar + WCutOffChar;
        end
        else
        begin
          ALines.Metrics[ALines.Count - 1].Len := WSaveChar - WStartChar;
          WStartChar := WSaveChar;
        end;
        ALines.Count := ALines.Count + 1;
        ALines.Metrics[ALines.Count - 1].Index :=
          ALines.Metrics[ALines.Count - 2].Index + ALines.Metrics[ALines.Count - 2].Len;
      end;

      WSaveChar := WCurChar;
      Tok := _WideGetToken(WCurChar, TmpS);
      if WSaveChar = WCurChar then
        Break; { !!! - error }
    end;
    ALines.Metrics[ALines.Count - 1].Len := WCurChar - WStartChar;
  end
  else
    ALines.Metrics[ALines.Count - 1].Len := Length(Tmps);
end;

procedure TCanvas.MeasureText(var ARect: TRectF; const AText: string;
  const WordWrap: Boolean; const Flags: TFillTextFlags; const ATextAlign,
  AVTextAlign: TTextAlign);
var
  Layout: TTextLayout;
begin
  if AText.IsEmpty then
  begin
    ARect.Right := ARect.Left;
    Exit;
  end;

  Layout := TTextLayoutManager.TextLayoutByCanvas(Self.ClassType).Create(Self);
  try
    Layout.BeginUpdate;
    Layout.TopLeft := ARect.TopLeft;
    Layout.MaxSize := PointF(ARect.Width, ARect.Height);
    Layout.Text := AText;
    Layout.WordWrap := WordWrap;
    Layout.HorizontalAlign := ATextAlign;
    Layout.VerticalAlign := AVTextAlign;
    Layout.Font := Self.Font;
    Layout.Color := Self.Fill.Color;
    Layout.RightToLeft := TFillTextFlag.ftRightToLeft in Flags;
    Layout.EndUpdate;
    ARect := Layout.TextRect;
  finally
    FreeAndNil(Layout);
  end;
end;

function TCanvas.TextHeight(const AText: string): Single;
var
  R: TRectF;
begin
  R := RectF(0, 0, 10000, 10000);
  MeasureText(R, AText, False, [], TTextAlign.taLeading, TTextAlign.taLeading);
  Result := R.Bottom;
end;

function TCanvas.TextToPath(Path: TPathData; const ARect: TRectF;
  const AText: string; const WordWrap: Boolean; const ATextAlign,
  AVTextAlign: TTextAlign): Boolean;
var
  Layout: TTextLayout;
begin
  if AText.IsEmpty then
    Exit(False);

  Layout := TTextLayoutManager.TextLayoutByCanvas(Self.ClassType).Create;
  try
    Layout.BeginUpdate;
    Layout.TopLeft := ARect.TopLeft;
    Layout.MaxSize := PointF(ARect.Width, ARect.Height);
    Layout.Text := AText;
    Layout.WordWrap := WordWrap;
    Layout.HorizontalAlign := ATextAlign;
    Layout.VerticalAlign := AVTextAlign;
    Layout.Font := Self.Font;
    Layout.Color := Self.Fill.Color;
    Layout.EndUpdate;
    Layout.ConvertToPath(Path);
    Result := True;
  finally
    FreeAndNil(Layout);
  end;
end;

function TCanvas.TextWidth(const AText: string): Single;
var
  R: TRectF;
begin
  R := RectF(0, 0, 10000, 20);
  MeasureText(R, AText, False, [], TTextAlign.taLeading, TTextAlign.taCenter);
  Result := R.Right;
end;

function TCanvas.TransformPoint(const P: TPointF): TPointF;
var
  V: TVector;
begin
  case FMatrixMeaning of
    TMatrixMeaning.mmUnknown:
      begin
        V.X := P.X;
        V.Y := P.Y;
        V.W := 1.0;
        V := FMatrix.Transform(V);
        Result.X := V.X;
        Result.Y := V.Y;
      end;
    TMatrixMeaning.mmIdentity:
      Result := P;
    TMatrixMeaning.mmTranslate:
      begin
        Result.X := P.X + FMatrixTranslate.X;
        Result.Y := P.Y + FMatrixTranslate.Y;
      end;
  end;
end;

function TCanvas.TransformRect(const Rect: TRectF): TRectF;
var
  V: TVector;
begin
  case FMatrixMeaning of
    TMatrixMeaning.mmUnknown:
      begin
        V.X := Rect.Left;
        V.Y := Rect.Top;
        V.W := 1.0;
        V := FMatrix.Transform(V);
        Result.Left := V.X;
        Result.Top := V.Y;
        V.X := Rect.Right;
        V.Y := Rect.Top;
        V.W := 1.0;
        V := FMatrix.Transform(V);
        Result.Right := V.X;
        Result.Bottom := V.Y;
        V.X := Rect.Right;
        V.Y := Rect.Bottom;
        V.W := 1.0;
        V := FMatrix.Transform(V);
        Result.Right := V.X;
        Result.Bottom := V.Y;
        V.X := Rect.Left;
        V.Y := Rect.Bottom;
        V.W := 1.0;
        V := FMatrix.Transform(V);
        Result.Left := V.X;
        Result.Bottom := V.Y;
      end;
    TMatrixMeaning.mmIdentity:
      Result := Rect;
    TMatrixMeaning.mmTranslate:
      begin
        Result := Rect;
        Result.Offset(FMatrixTranslate.X, FMatrixTranslate.Y)
      end;
  end;
end;

procedure TCanvas.FillArc(const Center, Radius: TPointF; StartAngle, SweepAngle: Single; const AOpacity: Single);
begin
  FillArc(Center, Radius, StartAngle, SweepAngle, AOpacity, FFill);
end;

procedure TCanvas.FillArc(const Center, Radius: TPointF; StartAngle, SweepAngle: Single; const AOpacity: Single; const ABrush: TBrush);
var
  P: TPathData;
begin
  P := TPathData.Create;
  try
    P.AddArc(Center, Radius, StartAngle, SweepAngle);
    FillPath(P, AOpacity, ABrush);
  finally
    P.Free;
  end;
end;

procedure TCanvas.DrawArc(const Center, Radius: TPointF; StartAngle, SweepAngle: Single; const AOpacity: Single);
begin
  DrawArc(Center, Radius, StartAngle, SweepAngle, AOpacity, FStroke);
end;

procedure TCanvas.DrawArc(const Center, Radius: TPointF; StartAngle, SweepAngle: Single; const AOpacity: Single; const ABrush: TStrokeBrush);
var
  P: TPathData;
begin
  P := TPathData.Create;
  try
    P.AddArc(Center, Radius, StartAngle, SweepAngle);
    DrawPath(P, AOpacity, ABrush);
  finally
    P.Free;
  end;
end;

procedure TCanvas.DrawBitmap(const ABitmap: TBitmap; const SrcRect, DstRect: TRectF; const AOpacity: Single; const HighSpeed: Boolean);
begin
  DoDrawBitmap(ABitmap, SrcRect, DstRect, AOpacity, HighSpeed);
end;

procedure TCanvas.DrawEllipse(const ARect: TRectF; const AOpacity: Single);
begin
  DrawEllipse(ARect, AOpacity, FStroke);
end;

procedure TCanvas.DrawEllipse(const ARect: TRectF; const AOpacity: Single; const ABrush: TStrokeBrush);
begin
  if ABrush.Kind <> TBrushKind.bkNone then
    DoDrawEllipse(ARect, AOpacity, ABrush);
end;

procedure TCanvas.DrawLine(const APt1, APt2: TPointF; const AOpacity: Single);
begin
  DrawLine(APt1, APt2, AOpacity, FStroke);
end;

procedure TCanvas.DrawLine(const APt1, APt2: TPointF; const AOpacity: Single; const ABrush: TStrokeBrush);
begin
  if ABrush.Kind <> TBrushKind.bkNone then
    DoDrawLine(APt1, APt2, AOpacity, ABrush);
end;

function TCanvas.SaveState: TCanvasSaveState;
var
  SaveData : TCanvasSaveState;
begin
  FSavingStateCount := FSavingStateCount + 1;
  for SaveData in FCanvasSaveData do
  begin
    if not SaveData.Assigned then
    begin
      SaveData.Assign(Self);
      Result := SaveData;
      Exit;
    end;
  end;
  Result := CreateSaveState;
  try
    Result.Assign(Self);
    FCanvasSaveData.Add(Result);
  except
    Result.Free;
    raise;
  end;
end;

procedure TCanvas.SetBlending(const Value: Boolean);
begin
  if FBlending <> Value then
  begin
    FBlending := Value;
    DoBlendingChanged;
  end;
end;

procedure TCanvas.SetCustomDash(const Dash: array of Single; Offset: Single);
begin
  Stroke.SetCustomDash(Dash, Offset);
end;

procedure TCanvas.SetFill(const Value: TBrush);
begin
  FFill.Assign(Value);
end;

procedure TCanvas.FillPath(const APath: TPathData; const AOpacity: Single);
begin
  FillPath(APath, AOpacity, FFill);
end;

procedure TCanvas.FillPath(const APath: TPathData; const AOpacity: Single; const ABrush: TBrush);
begin
  if (ABrush.Kind <> TBrushKind.bkNone) and not APath.IsEmpty then
    DoFillPath(APath, AOpacity, ABrush);
end;

procedure TCanvas.FillPolygon(const Points: TPolygon; const AOpacity: Single);
var
  I: Integer;
  Path: TPathData;
begin
  Path := TPathData.Create;
  try
    for I := 0 to High(Points) do
    begin
      if I = 0 then
        Path.MoveTo(Points[I])
      else
      if (Points[I].X = ClosePolygon.X) and (Points[I].Y = ClosePolygon.Y) then
        Path.ClosePath
      else
        Path.LineTo(Points[I]);
    end;
    Path.ClosePath;
    FillPath(Path, AOpacity);
  finally
    Path.Free;
  end;
end;

procedure TCanvas.DoFillRoundRect(const ARect: TRectF; const XRadius,
  YRadius: Single; const ACorners: TCorners; const AOpacity: Single;
  const ABrush: TBrush; const ACornerType: TCornerType = TCornerType.ctRound);
var
  Path: TPathData;
  x1, x2, y1, y2: Single;
  R: TRectF;
begin
  R := ARect;
  x1 := XRadius;
  if RectWidth(R) - (x1 * 2) < 0 then
    x1 := RectWidth(R) / 2;
  x2 := XRadius * CurveKappaInv;
  y1 := YRadius;
  if RectHeight(R) - (y1 * 2) < 0 then
    y1 := RectHeight(R) / 2;
  y2 := YRadius * CurveKappaInv;
  Path := TPathData.Create;
  Path.MoveTo(PointF(R.Left, R.Top + y1));
  if TCorner.crTopLeft in ACorners then
  begin
    case ACornerType of
      // ctRound - default
      TCornerType.ctBevel: Path.LineTo(PointF(R.Left + x1, R.Top));
      TCornerType.ctInnerRound: Path.CurveTo(PointF(R.Left + x2, R.Top + y1), PointF(R.Left + x1, R.Top + y2), PointF(R.Left + x1, R.Top));
      TCornerType.ctInnerLine:
        begin
          Path.LineTo(PointF(R.Left + x2, R.Top + y1));
          Path.LineTo(PointF(R.Left + x1, R.Top + y2));
          Path.LineTo(PointF(R.Left + x1, R.Top));
        end;
    else
      Path.CurveTo(PointF(R.Left, R.Top + (y2)), PointF(R.Left + x2, R.Top), PointF(R.Left + x1, R.Top))
    end;
  end
  else
  begin
    Path.LineTo(PointF(R.Left, R.Top));
    Path.LineTo(PointF(R.Left + x1, R.Top));
  end;
  Path.LineTo(PointF(R.Right - x1, R.Top));
  if TCorner.crTopRight in ACorners then
  begin
    case ACornerType of
      // ctRound - default
      TCornerType.ctBevel: Path.LineTo(PointF(R.Right, R.Top + y1));
      TCornerType.ctInnerRound: Path.CurveTo(PointF(R.Right - x1, R.Top + y2), PointF(R.Right - x2, R.Top + y1), PointF(R.Right, R.Top + y1));
      TCornerType.ctInnerLine:
        begin
          Path.LineTo(PointF(R.Right - x1, R.Top + y2));
          Path.LineTo(PointF(R.Right - x2, R.Top + y1));
          Path.LineTo(PointF(R.Right, R.Top + y1));
        end;
    else
      Path.CurveTo(PointF(R.Right - x2, R.Top), PointF(R.Right, R.Top + (y2)), PointF(R.Right, R.Top + y1))
    end;
  end
  else
  begin
    Path.LineTo(PointF(R.Right, R.Top));
    Path.LineTo(PointF(R.Right, R.Top + y1));
  end;
  Path.LineTo(PointF(R.Right, R.Bottom - y1));
  if TCorner.crBottomRight in ACorners then
  begin
    case ACornerType of
      // ctRound - default
      TCornerType.ctBevel: Path.LineTo(PointF(R.Right - x1, R.Bottom));
      TCornerType.ctInnerRound: Path.CurveTo(PointF(R.Right - x2, R.Bottom - y1), PointF(R.Right - x1, R.Bottom - y2), PointF(R.Right - x1, R.Bottom));
      TCornerType.ctInnerLine:
        begin
          Path.LineTo(PointF(R.Right - x2, R.Bottom - y1));
          Path.LineTo(PointF(R.Right - x1, R.Bottom - y2));
          Path.LineTo(PointF(R.Right - x1, R.Bottom));
        end;
    else
      Path.CurveTo(PointF(R.Right, R.Bottom - (y2)), PointF(R.Right - x2, R.Bottom), PointF(R.Right - x1, R.Bottom))
    end;
  end
  else
  begin
    Path.LineTo(PointF(R.Right, R.Bottom));
    Path.LineTo(PointF(R.Right - x1, R.Bottom));
  end;
  Path.LineTo(PointF(R.Left + x1, R.Bottom));
  if TCorner.crBottomLeft in ACorners then
  begin
    case ACornerType of
      // ctRound - default
      TCornerType.ctBevel: Path.LineTo(PointF(R.Left, R.Bottom - y1));
      TCornerType.ctInnerRound: Path.CurveTo(PointF(R.Left + x1, R.Bottom - y2), PointF(R.Left + x2, R.Bottom - y1), PointF(R.Left, R.Bottom - y1));
      TCornerType.ctInnerLine:
        begin
          Path.LineTo(PointF(R.Left + x1, R.Bottom - y2));
          Path.LineTo(PointF(R.Left + x2, R.Bottom - y1));
          Path.LineTo(PointF(R.Left, R.Bottom - y1));
        end;
    else
      Path.CurveTo(PointF(R.Left + x2, R.Bottom), PointF(R.Left, R.Bottom - (y2)), PointF(R.Left, R.Bottom - y1))
    end;
  end
  else
  begin
    Path.LineTo(PointF(R.Left, R.Bottom));
    Path.LineTo(PointF(R.Left, R.Bottom - y1));
  end;
  Path.ClosePath;
  DoFillPath(Path, AOpacity, ABrush);
  Path.Free;
end;

procedure TCanvas.FillRect(const ARect: TRectF; const XRadius, YRadius: Single; const ACorners: TCorners; const AOpacity: Single;
  const ACornerType: TCornerType);
begin
  FillRect(ARect, XRadius, YRadius, ACorners, AOpacity, FFill, ACornerType);
end;

procedure TCanvas.FillRect(const ARect: TRectF; const XRadius, YRadius: Single; const ACorners: TCorners; const AOpacity: Single;
  const ABrush: TBrush; const ACornerType: TCornerType);
begin
  if ABrush.Kind <> TBrushKind.bkNone then
  begin
    if ((XRadius = 0) and (YRadius = 0)) or (ACorners = []) then
      DoFillRect(ARect, AOpacity, ABrush)
    else
      DoFillRoundRect(ARect, XRadius, YRadius, ACorners, AOpacity, ABrush, ACornerType)
  end;
end;

procedure TCanvas.FillEllipse(const ARect: TRectF; const AOpacity: Single);
begin
  FillEllipse(ARect, AOpacity, FFill);
end;

procedure TCanvas.FillEllipse(const ARect: TRectF; const AOpacity: Single; const ABrush: TBrush);
begin
  if ABrush.Kind <> TBrushKind.bkNone then
    DoFillEllipse(ARect, AOpacity, ABrush);
end;

procedure TCanvas.FillText(const ARect: TRectF; const AText: string;
  const WordWrap: Boolean; const AOpacity: Single; const Flags: TFillTextFlags;
  const ATextAlign, AVTextAlign: TTextAlign);
var
  Layout: TTextLayout;
begin
  Layout := TTextLayoutManager.TextLayoutByCanvas(Self.ClassType).Create(Self);
  try
    Layout.BeginUpdate;
    Layout.TopLeft := ARect.TopLeft;
    Layout.MaxSize := PointF(ARect.Width, ARect.Height);
    Layout.Text := AText;
    Layout.WordWrap := WordWrap;
    Layout.Opacity := AOpacity;
    Layout.HorizontalAlign := ATextAlign;
    Layout.VerticalAlign := AVTextAlign;
    Layout.Font := Self.Font;
    Layout.Color := Self.Fill.Color;
    Layout.RightToLeft := TFillTextFlag.ftRightToLeft in Flags;
    Layout.EndUpdate;
    Layout.RenderLayout(Self);
  finally
    FreeAndNil(Layout);
  end;
end;

procedure TCanvas.DrawPath(const APath: TPathData; const AOpacity: Single);
begin
  DrawPath(APath, AOpacity, FStroke);
end;

procedure TCanvas.DrawPath(const APath: TPathData; const AOpacity: Single; const ABrush: TStrokeBrush);
begin
  if (ABrush.Kind <> TBrushKind.bkNone) and not APath.IsEmpty then
    DoDrawPath(APath, AOpacity, ABrush);
end;

procedure TCanvas.DrawPolygon(const Points: TPolygon; const AOpacity: Single);
var
  I: Integer;
  Path: TPathData;
begin
  Path := TPathData.Create;
  try
    for I := 0 to High(Points) do
    begin
      if I = 0 then
        Path.MoveTo(Points[I])
      else
      if (Points[I].X = ClosePolygon.X) and (Points[I].Y = ClosePolygon.Y) then
        Path.ClosePath
      else
        Path.LineTo(Points[I]);
    end;
    DrawPath(Path, AOpacity);
  finally
    Path.Free;
  end;
end;

procedure TCanvas.DrawRect(const ARect: TRectF; const XRadius, YRadius: Single; const ACorners: TCorners; const AOpacity: Single;
  const ACornerType: TCornerType);
begin
  DrawRect(ARect, XRadius, YRadius, ACorners, AOpacity, FStroke, ACornerType);
end;

procedure TCanvas.DrawRect(const ARect: TRectF; const XRadius, YRadius: Single; const ACorners: TCorners; const AOpacity: Single;
  const ABrush: TStrokeBrush; const ACornerType: TCornerType);
var
  Path: TPathData;
  x1, x2, y1, y2: Single;
  R: TRectF;
begin
  if ABrush.Kind <> TBrushKind.bkNone then
  begin
    R := ARect;
    if ((XRadius = 0) and (YRadius = 0)) or (ACorners = []) then
      DoDrawRect(ARect, AOpacity, ABrush)
    else begin
      R := ARect;
      x1 := XRadius;
      if RectWidth(R) - (x1 * 2) < 0 then
        x1 := RectWidth(R) / 2;
      x2 := XRadius * CurveKappaInv;
      y1 := YRadius;
      if RectHeight(R) - (y1 * 2) < 0 then
        y1 := RectHeight(R) / 2;
      y2 := YRadius * CurveKappaInv;
      Path := TPathData.Create;
      Path.MoveTo(PointF(R.Left, R.Top + y1));
      if TCorner.crTopLeft in ACorners then
      begin
        case ACornerType of
          // ctRound - default
          TCornerType.ctBevel: Path.LineTo(PointF(R.Left + x1, R.Top));
          TCornerType.ctInnerRound: Path.CurveTo(PointF(R.Left + x2, R.Top + y1), PointF(R.Left + x1, R.Top + y2), PointF(R.Left + x1, R.Top));
          TCornerType.ctInnerLine:
            begin
              Path.LineTo(PointF(R.Left + x2, R.Top + y1));
              Path.LineTo(PointF(R.Left + x1, R.Top + y2));
              Path.LineTo(PointF(R.Left + x1, R.Top));
            end;
        else
          Path.CurveTo(PointF(R.Left, R.Top + (y2)), PointF(R.Left + x2, R.Top), PointF(R.Left + x1, R.Top))
        end;
      end
      else
      begin
        Path.LineTo(PointF(R.Left, R.Top));
        Path.LineTo(PointF(R.Left + x1, R.Top));
      end;
      Path.LineTo(PointF(R.Right - x1, R.Top));
      if TCorner.crTopRight in ACorners then
      begin
        case ACornerType of
          // ctRound - default
          TCornerType.ctBevel: Path.LineTo(PointF(R.Right, R.Top + y1));
          TCornerType.ctInnerRound: Path.CurveTo(PointF(R.Right - x1, R.Top + y2), PointF(R.Right - x2, R.Top + y1), PointF(R.Right, R.Top + y1));
          TCornerType.ctInnerLine:
            begin
              Path.LineTo(PointF(R.Right - x1, R.Top + y2));
              Path.LineTo(PointF(R.Right - x2, R.Top + y1));
              Path.LineTo(PointF(R.Right, R.Top + y1));
            end;
        else
          Path.CurveTo(PointF(R.Right - x2, R.Top), PointF(R.Right, R.Top + (y2)), PointF(R.Right, R.Top + y1))
        end;
      end
      else
      begin
        Path.LineTo(PointF(R.Right, R.Top));
        Path.LineTo(PointF(R.Right, R.Top + y1));
      end;
      Path.LineTo(PointF(R.Right, R.Bottom - y1));
      if TCorner.crBottomRight in ACorners then
      begin
        case ACornerType of
          // ctRound - default
          TCornerType.ctBevel: Path.LineTo(PointF(R.Right - x1, R.Bottom));
          TCornerType.ctInnerRound: Path.CurveTo(PointF(R.Right - x2, R.Bottom - y1), PointF(R.Right - x1, R.Bottom - y2), PointF(R.Right - x1, R.Bottom));
          TCornerType.ctInnerLine:
            begin
              Path.LineTo(PointF(R.Right - x2, R.Bottom - y1));
              Path.LineTo(PointF(R.Right - x1, R.Bottom - y2));
              Path.LineTo(PointF(R.Right - x1, R.Bottom));
            end;
        else
          Path.CurveTo(PointF(R.Right, R.Bottom - (y2)), PointF(R.Right - x2, R.Bottom), PointF(R.Right - x1, R.Bottom))
        end;
      end
      else
      begin
        Path.LineTo(PointF(R.Right, R.Bottom));
        Path.LineTo(PointF(R.Right - x1, R.Bottom));
      end;
      Path.LineTo(PointF(R.Left + x1, R.Bottom));
      if TCorner.crBottomLeft in ACorners then
      begin
        case ACornerType of
          // ctRound - default
          TCornerType.ctBevel: Path.LineTo(PointF(R.Left, R.Bottom - y1));
          TCornerType.ctInnerRound: Path.CurveTo(PointF(R.Left + x1, R.Bottom - y2), PointF(R.Left + x2, R.Bottom - y1), PointF(R.Left, R.Bottom - y1));
          TCornerType.ctInnerLine:
            begin
              Path.LineTo(PointF(R.Left + x1, R.Bottom - y2));
              Path.LineTo(PointF(R.Left + x2, R.Bottom - y1));
              Path.LineTo(PointF(R.Left, R.Bottom - y1));
            end;
        else
          Path.CurveTo(PointF(R.Left + x2, R.Bottom), PointF(R.Left, R.Bottom - (y2)), PointF(R.Left, R.Bottom - y1))
        end;
      end
      else
      begin
        Path.LineTo(PointF(R.Left, R.Bottom));
        Path.LineTo(PointF(R.Left, R.Bottom - y1));
      end;
      Path.ClosePath;
      DoDrawPath(Path, AOpacity, ABrush);
      Path.Free;
    end;
  end;
end;

procedure TCanvas.DrawDashRect(const ARect: TRectF; const XRadius, YRadius: Single; const ACorners: TCorners;
      const AOpacity: Single; const AColor: TAlphaColor);
var
  Brush: TStrokeBrush;
begin
  Brush := TStrokeBrush.Create(TBrushKind.bkSolid, AColor);
  Brush.Thickness := 1;
  Brush.Dash := TStrokeDash.sdDash;
  Brush.Kind := TBrushKind.bkSolid;
  DrawRect(ARect, XRadius, YRadius, ACorners, AOpacity, Brush);
  Brush.Free;
end;

procedure TCanvas.DrawRectSides(const ARect: TRectF; const XRadius, YRadius: Single; const ACorners: TCorners;
  const AOpacity: Single; const ASides: TSides; const ACornerType: TCornerType = TCornerType.ctRound);
begin
  DrawRectSides(ARect, XRadius, YRadius, ACorners, AOpacity, ASides, FStroke, ACornerType);
end;

procedure TCanvas.DrawRectSides(const ARect: TRectF; const XRadius, YRadius: Single; const ACorners: TCorners;
  const AOpacity: Single; const ASides: TSides; const ABrush: TStrokeBrush; const ACornerType: TCornerType = TCornerType.ctRound);
var
  Path: TPathData;
  X1, X2, Y1, Y2: Single;
  R: TRectF;
begin
  R := ARect;
  X1 := XRadius;
  if RectWidth(R) - (X1 * 2) < 0 then
    if X1 <> 0 then // guard divide by zero
      X1 := (XRadius * (RectWidth(R) / (X1 * 2)));
  X2 := X1 / 2;
  Y1 := YRadius;
  if RectHeight(R) - (Y1 * 2) < 0 then
    if Y1 <> 0 then // guard divide by zero
      Y1 := (YRadius * (RectHeight(R) / (Y1 * 2)));
  Y2 := Y1 / 2;
  Path := TPathData.Create;
  try
    Path.MoveTo(PointF(R.Left, R.Top + Y1));
    if TCorner.crTopLeft in ACorners then
    begin
      case ACornerType of
        // ctRound - default
        TCornerType.ctBevel:
          Path.LineTo(PointF(R.Left + X1, R.Top));
        TCornerType.ctInnerRound:
          Path.CurveTo(PointF(R.Left + X2, R.Top + Y1), PointF(R.Left + X1, R.Top + Y2), PointF(R.Left + X1, R.Top));
        TCornerType.ctInnerLine:
          begin
            Path.LineTo(PointF(R.Left + X2, R.Top + Y1));
            Path.LineTo(PointF(R.Left + X1, R.Top + Y2));
            Path.LineTo(PointF(R.Left + X1, R.Top));
          end;
      else
        Path.CurveTo(PointF(R.Left, R.Top + (Y2)), PointF(R.Left + X2, R.Top), PointF(R.Left + X1, R.Top))
      end;
    end
    else
    begin
      if TSide.sdLeft in ASides then
        Path.LineTo(PointF(R.Left, R.Top))
      else
        Path.MoveTo(PointF(R.Left, R.Top));
      if TSide.sdTop in ASides then
        Path.LineTo(PointF(R.Left + X1, R.Top))
      else
        Path.MoveTo(PointF(R.Left + X1, R.Top));
    end;
    if not(TSide.sdTop in ASides) then
      Path.MoveTo(PointF(R.Right - X1, R.Top))
    else
      Path.LineTo(PointF(R.Right - X1, R.Top));
    if TCorner.crTopRight in ACorners then
    begin
      case ACornerType of
        // ctRound - default
        TCornerType.ctBevel:
          Path.LineTo(PointF(R.Right, R.Top + Y1));
        TCornerType.ctInnerRound:
          Path.CurveTo(PointF(R.Right - X1, R.Top + Y2), PointF(R.Right - X2, R.Top + Y1), PointF(R.Right, R.Top + Y1));
        TCornerType.ctInnerLine:
          begin
            Path.LineTo(PointF(R.Right - X1, R.Top + Y2));
            Path.LineTo(PointF(R.Right - X2, R.Top + Y1));
            Path.LineTo(PointF(R.Right, R.Top + Y1));
          end;
      else
        Path.CurveTo(PointF(R.Right - X2, R.Top), PointF(R.Right, R.Top + (Y2)), PointF(R.Right, R.Top + Y1))
      end;
    end
    else
    begin
      if TSide.sdTop in ASides then
        Path.LineTo(PointF(R.Right, R.Top))
      else
        Path.MoveTo(PointF(R.Right, R.Top));
      if TSide.sdRight in ASides then
        Path.LineTo(PointF(R.Right, R.Top + Y1))
      else
        Path.MoveTo(PointF(R.Right, R.Top + Y1));
    end;
    if not(TSide.sdRight in ASides) then
      Path.MoveTo(PointF(R.Right, R.Bottom - Y1))
    else
      Path.LineTo(PointF(R.Right, R.Bottom - Y1));
    if TCorner.crBottomRight in ACorners then
    begin
      case ACornerType of
        // ctRound - default
        TCornerType.ctBevel:
          Path.LineTo(PointF(R.Right - X1, R.Bottom));
        TCornerType.ctInnerRound:
          Path.CurveTo(PointF(R.Right - X2, R.Bottom - Y1), PointF(R.Right - X1, R.Bottom - Y2),
            PointF(R.Right - X1, R.Bottom));
        TCornerType.ctInnerLine:
          begin
            Path.LineTo(PointF(R.Right - X2, R.Bottom - Y1));
            Path.LineTo(PointF(R.Right - X1, R.Bottom - Y2));
            Path.LineTo(PointF(R.Right - X1, R.Bottom));
          end;
      else
        Path.CurveTo(PointF(R.Right, R.Bottom - (Y2)), PointF(R.Right - X2, R.Bottom), PointF(R.Right - X1, R.Bottom))
      end;
    end
    else
    begin
      if TSide.sdRight in ASides then
        Path.LineTo(PointF(R.Right, R.Bottom))
      else
        Path.MoveTo(PointF(R.Right, R.Bottom));
      if TSide.sdBottom in ASides then
        Path.LineTo(PointF(R.Right - X1, R.Bottom))
      else
        Path.MoveTo(PointF(R.Right - X1, R.Bottom));
    end;
    if not(TSide.sdBottom in ASides) then
      Path.MoveTo(PointF(R.Left + X1, R.Bottom))
    else
      Path.LineTo(PointF(R.Left + X1, R.Bottom));
    if TCorner.crBottomLeft in ACorners then
    begin
      case ACornerType of
        // ctRound - default
        TCornerType.ctBevel:
          Path.LineTo(PointF(R.Left, R.Bottom - Y1));
        TCornerType.ctInnerRound:
          Path.CurveTo(PointF(R.Left + X1, R.Bottom - Y2), PointF(R.Left + X2, R.Bottom - Y1),
            PointF(R.Left, R.Bottom - Y1));
        TCornerType.ctInnerLine:
          begin
            Path.LineTo(PointF(R.Left + X1, R.Bottom - Y2));
            Path.LineTo(PointF(R.Left + X2, R.Bottom - Y1));
            Path.LineTo(PointF(R.Left, R.Bottom - Y1));
          end;
      else
        Path.CurveTo(PointF(R.Left + X2, R.Bottom), PointF(R.Left, R.Bottom - (Y2)), PointF(R.Left, R.Bottom - Y1))
      end;
    end
    else
    begin
      if TSide.sdBottom in ASides then
        Path.LineTo(PointF(R.Left, R.Bottom))
      else
        Path.MoveTo(PointF(R.Left, R.Bottom));
      if TSide.sdLeft in ASides then
        Path.LineTo(PointF(R.Left, R.Bottom - Y1))
      else
        Path.MoveTo(PointF(R.Left, R.Bottom - Y1));
    end;
    if (TSide.sdLeft in ASides) then
    begin
      Path.LineTo(PointF(R.Left, R.Top + Y1));
    end;
    DrawPath(Path, AOpacity, ABrush);
  finally
    Path.Free;
  end;
end;

{ Deprecated }

function TCanvas.GetCanvasScale: Single;
begin
  Result := 1.0;
end;

class function TCanvas.GetCanvasStyle: TCanvasStyles;
begin
  Result := [TCanvasStyle.SupportClipRects];
end;

function TCanvas.GetStrokeThickness: Single;
begin
  Result := Stroke.Thickness;
end;

procedure TCanvas.SetSize(const AWidth, AHeight: Integer);
begin
  FWidth := AWidth;
  FHeight := AHeight;
end;

procedure TCanvas.SetStrokeCap(const Value: TStrokeCap);
begin
  FStroke.Cap := Value;
end;

procedure TCanvas.SetStrokeDash(const Value: TStrokeDash);
begin
  FStroke.Dash := Value;
end;

procedure TCanvas.SetStrokeJoin(const Value: TStrokeJoin);
begin
  FStroke.Join := Value;
end;

procedure TCanvas.SetStrokeThickness(const Value: Single);
begin
  FStroke.Thickness := Value;
end;

{ TAniThread }

type

  TAniThread = class(TTimer)
  private
    FAniList: TList<TAnimation>;
    FTime, FDeltaTime: Single;
    FTimerService: IFMXTimerService;
    procedure OneStep;
    procedure DoSyncTimer(Sender: TObject);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure AddAnimation(const Ani: TAnimation);
    procedure RemoveAnimation(const Ani: TAnimation);
  end;

constructor TAniThread.Create;
begin
  inherited Create(nil);
  if not TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, IInterface(FTimerService)) then
    raise EUnsupportedPlatformService.Create('IFMXTimerService');
  if AniFrameRate < 5 then
    AniFrameRate := 5;
  if AniFrameRate > 100 then
    AniFrameRate := 100;
  Interval := trunc(1000 / AniFrameRate / 10) * 10;
  if (Interval <= 0) then Interval := 1;

  OnTimer := DoSyncTimer;
  FAniList := TList<TAnimation>.Create;
  FTime := FTimerService.GetTick;

  Enabled := False;
end;

destructor TAniThread.Destroy;
begin
  FreeAndNil(FAniList);
  FTimerService := nil;
  inherited;
end;

procedure TAniThread.AddAnimation(const Ani: TAnimation);
begin
  if FAniList.IndexOf(Ani) < 0 then
    FAniList.Add(Ani);
  if not Enabled and (FAniList.Count > 0) then
    FTime := FTimerService.GetTick;
  Enabled := FAniList.Count > 0;
end;

procedure TAniThread.RemoveAnimation(const Ani: TAnimation);
begin
  FAniList.Remove(Ani);
  Enabled := FAniList.Count > 0;
end;

procedure TAniThread.DoSyncTimer(Sender: TObject);
begin
  OneStep;
  if AniFrameRate < 5 then
    AniFrameRate := 5;
  Interval := trunc(1000 / AniFrameRate / 10) * 10;
  if (Interval <= 0) then Interval := 1;
end;

procedure TAniThread.OneStep;
var
  I: Integer;
  NewTime: Single;
begin
  NewTime := FTimerService.GetTick;
  FDeltaTime := NewTime - FTime;
  FTime := NewTime;
  if FDeltaTime <= 0 then
    Exit;
  if FAniList.Count > 0 then
  begin
    I := FAniList.Count - 1;
    while I >= 0 do
    begin
      if FAniList[I].FRunning then
      begin
        if (FAniList[I].StyleName <> '') and
          (CompareText(FAniList[I].StyleName, 'caret') = 0) then
        begin
          FAniList[I].Tag := FAniList[I].Tag + 1;
          if FAniList[I].Tag mod 12 = 0 then
          begin
            FAniList[I].ProcessTick(FTime, FDeltaTime);
          end;
        end
        else
          FAniList[I].ProcessTick(FTime, FDeltaTime);
      end;
      dec(I);
      if I >= FAniList.Count then
        I := FAniList.Count - 1;
    end;
  end;
end;

{ TAnimation }

procedure TAnimation.ChangeParent;
begin
  inherited;
  ParseTriggers(nil, False, False);
end;

constructor TAnimation.Create(AOwner: TComponent);
begin
  inherited;
  FEnabled := False;
  Duration := 0.2;
end;

destructor TAnimation.Destroy;
begin
  if Assigned(AniThread) then
    TAniThread(AniThread).FAniList.Remove(Self);
  FreeAndNil(FTriggerList);
  FreeAndNil(FInverseTriggerList);
  inherited;
end;

procedure TAnimation.FirstFrame;
begin

end;

procedure TAnimation.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) and Enabled then
    Start;
end;

procedure TAnimation.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    if not(csDesigning in ComponentState) and not(csLoading in ComponentState) and
      not(csReading in ComponentState) then
    begin
      if FEnabled then
        Start
      else
        Stop;
    end;
  end;
end;

procedure TAnimation.SetTrigger(const Value: TTrigger);
begin
  FTrigger := Value;
  ParseTriggers(nil, False, False);
end;

procedure TAnimation.SetTriggerInverse(const Value: TTrigger);
begin
  FTriggerInverse := Value;
  ParseTriggers(nil, False, False);
end;

function TAnimation.NormalizedTime: Single;
begin
  Result := 0;
  if (FDuration > 0) and (FDelayTime <= 0) then
  begin
    case FInterpolation of
      TInterpolationType.itLinear:
        Result := InterpolateLinear(FTime, 0, 1, FDuration);
      TInterpolationType.itQuadratic:
        Result := InterpolateQuad(FTime, 0, 1, FDuration, FAnimationType);
      TInterpolationType.itCubic:
        Result := InterpolateCubic(FTime, 0, 1, FDuration, FAnimationType);
      TInterpolationType.itQuartic:
        Result := InterpolateQuart(FTime, 0, 1, FDuration, FAnimationType);
      TInterpolationType.itQuintic:
        Result := InterpolateQuint(FTime, 0, 1, FDuration, FAnimationType);
      TInterpolationType.itSinusoidal:
        Result := InterpolateSine(FTime, 0, 1, FDuration, FAnimationType);
      TInterpolationType.itExponential:
        Result := InterpolateExpo(FTime, 0, 1, FDuration, FAnimationType);
      TInterpolationType.itCircular:
        Result := InterpolateCirc(FTime, 0, 1, FDuration, FAnimationType);
      TInterpolationType.itElastic:
        Result := InterpolateElastic(FTime, 0, 1, FDuration, 0, 0, FAnimationType);
      TInterpolationType.itBack:
        Result := InterpolateBack(FTime, 0, 1, FDuration, 0, FAnimationType);
      TInterpolationType.itBounce:
        Result := InterpolateBounce(FTime, 0, 1, FDuration, FAnimationType);
    end;
  end;
end;

procedure TAnimation.DoProcess;
begin
  if Assigned(FOnProcess) then
    FOnProcess(Self);
end;

procedure TAnimation.DoFinish;
begin
  if Assigned(FOnFinish) then
    FOnFinish(Self);
end;

procedure TAnimation.ProcessTick(time, deltaTime: Single);
begin
  inherited;
  if (csDesigning in ComponentState) then
    Exit;
  if csDestroying in ComponentState then
    Exit;

  if Assigned(Parent) and (Parent.IsIControl) and (not Parent.AsIControl.Visible) then
    Stop;

  if not FRunning then
    Exit;
  if FPause then
    Exit;

  if (FDelay > 0) and (FDelayTime <> 0) then
  begin
    if FDelayTime > 0 then
    begin
      FDelayTime := FDelayTime - deltaTime;
      if FDelayTime <= 0 then
      begin
        FDelayTime := 0;
        if FInverse then
          FTime := FDuration
        else
          FTime := 0;
        FirstFrame;
        ProcessAnimation;
        DoProcess;
      end;
    end;
    Exit;
  end;

  if FInverse then
    FTime := FTime - deltaTime
  else
    FTime := FTime + deltaTime;
  if FTime >= FDuration then
  begin
    FTime := FDuration;
    if FLoop then
    begin
      if FAutoReverse then
      begin
        FInverse := True;
        FTime := FDuration;
      end
      else
        FTime := 0;
    end
    else
      if FAutoReverse and (FTickCount = 0) then
      begin
        Inc(FTickCount);
        FInverse := True;
        FTime := FDuration;
      end
      else
        FRunning := False;
  end
  else if FTime <= 0 then
  begin
    FTime := 0;
    if FLoop then
    begin
      if FAutoReverse then
      begin
        FInverse := False;
        FTime := 0;
      end
      else
        FTime := FDuration;
    end
    else
      if FAutoReverse and (FTickCount = 0) then
      begin
        Inc(FTickCount);
        FInverse := False;
        FTime := 0;
      end
      else
        FRunning := False;
  end;

  ProcessAnimation;
  DoProcess;

  if not FRunning then
  begin
    if Assigned(AniThread) then
      TAniThread(AniThread).RemoveAnimation(Self);
    DoFinish;
  end;
end;

procedure TAnimation.Start;
begin
  if not FLoop then
    FTickCount := 0;
  if Assigned(Parent) and (Parent.IsIControl) and (not Parent.AsIControl.Visible) then
    Exit;
  if (Abs(FDuration) < 0.001) or (Not Assigned(FRoot)) or (csDesigning in ComponentState) then
  begin
    { immediate animation }
    FDelayTime := 0;
    if FInverse then
    begin
      FTime := 0;
      FDuration := 1;
    end
    else
    begin
      FTime := 1;
      FDuration := 1;
    end;
    FRunning := True;
    ProcessAnimation;
    DoProcess;
    FRunning := False;
    FTime := 0;
    FDuration := 0.00001;
    DoFinish;
  end
  else
  begin
    FDelayTime := FDelay;
    FRunning := True;
    if FInverse then
      FTime := FDuration
    else
      FTime := 0;
    if FDelay = 0 then
    begin
      FirstFrame;
      ProcessAnimation;
      DoProcess;
    end;

    if not Assigned(AniThread) then
      AniThread := TAniThread.Create;

    TAniThread(AniThread).AddAnimation(Self);
    if not AniThread.Enabled then
      Stop
    else
      FEnabled := True;
  end;
end;

procedure TAnimation.Stop;
begin
  if not FRunning then
    Exit;

  if Assigned(AniThread) then
    TAniThread(AniThread).RemoveAnimation(Self);

  if FInverse then
    FTime := 0
  else
    FTime := FDuration;
  ProcessAnimation;
  DoProcess;
  FRunning := False;
  DoFinish;
end;

procedure TAnimation.StopAtCurrent;
begin
  if not FRunning then
    Exit;

  if Assigned(AniThread) then
    TAniThread(AniThread).RemoveAnimation(Self);

  if FInverse then
    FTime := 0
  else
    FTime := FDuration;
  FRunning := False;
  FEnabled := False;
  DoFinish;
end;

procedure TAnimation.ParseTriggers(const AInstance: TFmxObject; Normal, Inverse: Boolean);
var
  T: TRttiType;
  P: TRttiProperty;
  Line, Setter, Prop, Value: string;
  Trigger: TTriggerRec;
begin
  if not Assigned(AInstance) then
  begin
    if Assigned(FTriggerList) then
      FreeAndNil(FTriggerList);
    if Assigned(FInverseTriggerList) then
      FreeAndNil(FInverseTriggerList);
    FTargetClass := nil;
    Exit;
  end;

  if ((Inverse and Assigned(FInverseTriggerList)) or not Inverse)
    and ((Normal and Assigned(FTriggerList)) or not Normal) then Exit;

  T := SharedContext.GetType(AInstance.ClassInfo);
  if not Assigned(T) then Exit;

  while Inverse do
  begin
    if Assigned(FInverseTriggerList) then
      Break
    else
      FInverseTriggerList := TList<TTriggerRec>.Create;

    Line := FTriggerInverse;
    Setter := GetToken(Line, ';');
    while Setter <> '' do
    begin
      Prop := GetToken(Setter, '=');
      Value := Setter;
      P := T.GetProperty(Prop);
      if Assigned(P) and (P.PropertyType.TypeKind = tkEnumeration) then
      begin
        Trigger.Name := Prop;
        Trigger.Prop := P;
        Trigger.Value := StrToBoolDef(Value, True);
        FInverseTriggerList.Add(Trigger);
      end
      else
      begin
        FreeAndNil(FInverseTriggerList);
        Break;
      end;
      Setter := GetToken(Line, ';');
    end;
    Break;
  end;

  while Normal do
  begin
    if Assigned(FTriggerList) then
      Break
    else
      FTriggerList := TList<TTriggerRec>.Create;

    Line := FTrigger;
    Setter := GetToken(Line, ';');
    while Setter <> '' do
    begin
      Prop := GetToken(Setter, '=');
      Value := Setter;
      P := T.GetProperty(Prop);
      if Assigned(P) and (P.PropertyType.TypeKind = tkEnumeration) then
      begin
        Trigger.Name := Prop;
        Trigger.Prop := P;
        Trigger.Value := StrToBoolDef(Value, True);
        FTriggerList.Add(Trigger);
      end
      else
      begin
        FreeAndNil(FTriggerList);
        Break;
      end;
      Setter := GetToken(Line, ';');
    end;
    Break;
  end;

  if Assigned(FInverseTriggerList) or Assigned(FTriggerList) then
    FTargetClass := AInstance.ClassType;
end;

procedure TAnimation.StartTrigger(const AInstance: TFmxObject; const ATrigger: string);
var
  V: TValue;
  StartValue: Boolean;
  ContainsInTrigger, ContainsInTriggerInverse: Boolean;
  I: Integer;
  Trigger: TTriggerRec;
begin
  if not Assigned(AInstance) then
    Exit;

  ContainsInTrigger := ContainsText(FTrigger, ATrigger);
  ContainsInTriggerInverse := ContainsText(FTriggerInverse, ATrigger);

  ParseTriggers(AInstance, ContainsInTrigger, ContainsInTriggerInverse);

  if not AInstance.InheritsFrom(FTargetClass) then
    Exit;

  if ContainsInTrigger or ContainsInTriggerInverse then
  begin
    if Assigned(FInverseTriggerList) and (FInverseTriggerList.Count > 0) and ContainsInTriggerInverse then
    begin
      StartValue := False;
      for I := 0 to FInverseTriggerList.Count - 1 do
      begin
        Trigger := FInverseTriggerList[I];
        V := Trigger.Prop.GetValue(AInstance);
        StartValue := V.AsBoolean = Trigger.Value;
        if not StartValue then
          Break;
      end;
      if StartValue then
      begin
        Inverse := True;
        Start;
        Exit;
      end;
    end;
    if Assigned(FTriggerList) and (FTriggerList.Count > 0) and ContainsInTrigger then
    begin
      StartValue := False;
      for I := 0 to FTriggerList.Count - 1 do
      begin
        Trigger := FTriggerList[I];
        V := Trigger.Prop.GetValue(AInstance);
        StartValue := V.AsBoolean = Trigger.Value;
        if not StartValue then
          Break;
      end;
      if StartValue then
      begin
        if FTriggerInverse <> '' then
          Inverse := False;
        Start;
      end;
    end;
  end;
end;

procedure TAnimation.StopTrigger(const AInstance: TFmxObject; const ATrigger: string);
begin
  if not Assigned(AInstance) then
    Exit;
  if (FTriggerInverse <> '') and string(FTriggerInverse).ToLower.Contains(ATrigger.ToLower) then
    Stop;
  if (FTrigger <> '') and string(FTrigger).ToLower.Contains(ATrigger.ToLower) then
    Stop;
end;

{ TEffect }

constructor TEffect.Create(AOwner: TComponent);
begin
  inherited;
  FEnabled := True;
end;

destructor TEffect.Destroy;
begin
  inherited;
end;

function TEffect.GetOffset: TPointF;
begin
  Result := PointF(0, 0);
end;

function TEffect.GetRect(const ARect: TRectF): TRectF;
begin
  Result := ARect;
end;

procedure TEffect.ApplyTrigger(AInstance: TFmxObject; const ATrigger: string);
var
  T: TRttiType;
  P: TRttiProperty;
  V: TValue;
  StartValue: Boolean;
  Line, Setter, Prop, Value: string;
begin
  if FTrigger = '' then
    Exit;
  if not Assigned(AInstance) then
    Exit;
  if ContainsText(FTrigger, ATrigger) then
  begin
    Line := FTrigger;
    Setter := GetToken(Line, ';');
    StartValue := False;
    while Setter <> '' do
    begin
      Prop := GetToken(Setter, '=');
      Value := Setter;
      T := SharedContext.GetType(AInstance.ClassInfo);
      if Assigned(T) then
      begin
        P := T.GetProperty(Prop);
        if Assigned(P) and (P.PropertyType.TypeKind = tkEnumeration) then
        begin
          V := P.GetValue(AInstance);
          StartValue := CompareText(BoolToStr(V.AsBoolean, True), string(Value)) = 0;
        end;
      end;
      Setter := GetToken(Line, ';');
    end;
    Enabled := StartValue;
  end;
end;

procedure TEffect.UpdateParentEffects;
var
  EffectContainer: IEffectContainer;
begin
  if not(csLoading in ComponentState) then
    if Supports(FParent, IEffectContainer, EffectContainer) then
      EffectContainer.NeedUpdateEffects;
end;

procedure TEffect.ProcessEffect(const Canvas: TCanvas; const Visual: TBitmap; const Data: Single);
begin
end;

procedure TEffect.SetEnabled(const Value: Boolean);
var
  EffectContainer: IEffectContainer;
begin
  if FEnabled <> Value then
  begin
    if Supports(FParent, IEffectContainer, EffectContainer) then
    begin
      EffectContainer.BeforeEffectEnabledChanged(Value);
      FEnabled := Value;
      EffectContainer.EffectEnabledChanged(Enabled);
    end
    else
      FEnabled := Value;
  end;
end;

{ TFmxReader }

type
  TFmxReader = class(TReader)
  private
  protected
    procedure SetName(Component: TComponent; var Name: string); override;
    function Error(const Message: string): Boolean; override;
  end;

function TFmxReader.Error(const Message: string): Boolean;
begin
  Result := True;
end;

procedure TFmxReader.SetName(Component: TComponent; var Name: string);
begin
  Name := '';
end;

{$REGION 'implementation of purgatory'}
type
  TPurgatory = class (TComponent)
  public const
    TimerInterval: Integer = 10;
  private
    FInstanceList: TList<Pointer>;
    FTimerHandle: TFMXHandle;
    FPlatformTimer: IFMXTimerService;
    procedure StartTimer;
    procedure StopTimer;
    procedure TimerProc;
    procedure UpdateTimer;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(const Instance: TFmxObject);
    procedure Remove(const Instance: TFmxObject);
    function Contains(const Instance: TFmxObject): Boolean;
  end;

var
  vPurgatory: TPurgatory;

{ TPurgatory }

constructor TPurgatory.Create(AOwner: TComponent);
begin
  inherited;
  FTimerHandle := cIdNoTimer;
  FInstanceList := TList<Pointer>.Create;
end;

destructor TPurgatory.Destroy;
begin
  StopTimer;
  FPlatformTimer := nil;
  Clear;
  FreeAndNil(FInstanceList);
  inherited;
end;

function TPurgatory.Contains(const Instance: TFmxObject): Boolean;
begin
  Result := FInstanceList.Contains(Instance);
end;

procedure TPurgatory.Add(const Instance: TFmxObject);
begin
  if Assigned(Instance) and (not Contains(Instance)) then
  begin
    FreeNotification(Instance);
    FInstanceList.Add(Instance);
    if FInstanceList.Count > 0 then
      StartTimer;
  end;
end;

procedure TPurgatory.Remove(const Instance: TFmxObject);
begin
  if Assigned(Instance) then
  begin
    FInstanceList.Remove(Instance);
    RemoveFreeNotification(Instance);
    UpdateTimer;
  end;
end;

procedure TPurgatory.StartTimer;
begin
  if not (csDestroying in ComponentState) then
  begin
    if not Assigned(FPlatformTimer) then
    begin
      if not TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, IInterface(FPlatformTimer)) then
        raise EUnsupportedPlatformService.Create('IFMXTimerService');
    end;
    if FTimerHandle = cIdNoTimer then
      FTimerHandle := FPlatformTimer.CreateTimer(TimerInterval, TimerProc);
  end;
end;

procedure TPurgatory.StopTimer;
begin
  if Assigned(FPlatformTimer) and (FTimerHandle <> cIdNoTimer) then
  begin
    FPlatformTimer.DestroyTimer(FTimerHandle);
    FTimerHandle := cIdNoTimer;
  end;
end;

procedure TPurgatory.TimerProc;
begin
  Clear;
end;

procedure TPurgatory.UpdateTimer;
begin
  if (FInstanceList.Count = 0) and
     (Assigned(FPlatformTimer)) then
    StopTimer;
end;

procedure TPurgatory.Clear;
var
  Instance: TFmxObject;
begin
  try
    while FInstanceList.Count > 0 do
    begin
      Instance := FInstanceList[0];
      FInstanceList.Delete(0);
      RemoveFreeNotification(Instance);
      Instance.DisposeOf;
    end;
  finally
    UpdateTimer;
  end;
end;

procedure TPurgatory.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent is TFmxObject) then
  begin
    FInstanceList.Remove(TFmxObject(AComponent));
    UpdateTimer;
  end;
end;
{$ENDREGION}

{ TFmxObject }

constructor TFmxObject.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIndex := -1;
  FStored := True;
end;

class constructor TFmxObject.Create;
begin
end;

class destructor TFmxObject.Destroy;
begin
end;


destructor TFmxObject.Destroy;
var
  I: Integer;
begin
  FreeAndNil(FActionLink);
  FreeAndNil(FTouchManager);
  SetActionClient(False);
  { NotifList }
  if Assigned(FNotifyList) then
  begin
    FCallingFreeNotify := True;
    for I := FNotifyList.Count - 1 downto 0 do
      IFreeNotification(FNotifyList[I]).FreeNotification(Self);
    FreeAndNil(FNotifyList);
  end;
  { Remove from ResorcesList }
  if StyleName <> '' then
    RemoveResource(Self);
  { }
  if Assigned(FParent) then
    FParent.RemoveObject(Self);
  FRoot := nil;
  DeleteChildren;
  if Assigned(FChildrenList) then
    FChildrenList.Free;
  FreeAndNil(FStyleObjectsDict);
  inherited;
end;

procedure TFmxObject.SetActionClient(const Value: boolean);
begin
  if FActionClient <> Value then
  begin
    FActionClient := Value;
    DoActionClientChanged;
  end;
end;

procedure TFmxObject.Release;
begin
  if not (csDestroying in ComponentState) then
  begin
    if Assigned(vPurgatory) then
    begin
      Parent := nil;
      vPurgatory.Add(self);
      FReleased := True;
    end
    else
      raise EInvalidOperation.CreateFMT(SNotInstance, ['TPurgatory']);
  end;
end;

function TFmxObject.Released: Boolean;
begin
  Result := FReleased;
end;

function TFmxObject.ItemClass: string;
begin
  Result := '';
end;

procedure TFmxObject.Loaded;
begin
  inherited;
  if csDestroying in ComponentState then
    Exit;
  if Assigned(FRoot) then
    FixupTabList;
end;

procedure TFmxObject.AddFreeNotify(const AObject: IFreeNotification);
begin
  if not Assigned(FNotifyList) then
    FNotifyList := TList<Pointer>.Create;
  FNotifyList.Add(Pointer(AObject));
end;

procedure TFmxObject.RemoveFreeNotify(const AObject: IFreeNotification);
begin
  if not FCallingFreeNotify and Assigned(FNotifyList) then
    FNotifyList.Remove(Pointer(AObject));
end;

procedure TFmxObject.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Action then
      Action := nil;
  end;
end;

procedure TFmxObject.RemoveObject(Index: Integer);
begin
  if Assigned(FChildren) and (Index < FChildren.Count) then
    RemoveObject(FChildren[Index]);
end;

procedure TFmxObject.ResetChildrenIndices;
var
  O: TFmxObject;
begin
  if Assigned(FChildren) then
    for O in FChildren do
      O.FIndex := -1;
end;

procedure TFmxObject.FreeNotification(AObject: TObject);
begin
  if AObject is TComponent then
    Notification(TComponent(AObject), opRemove);
end;

function TFmxObject.IsIControl: Boolean;
begin
  Result := False;
end;

function TFmxObject.IsChild(AObject: TFmxObject): Boolean;
begin
  Result := False;
  while not Result and Assigned(AObject) do
  begin
    Result := AObject.Equals(Self);
    if not Result then
      AObject := AObject.Parent;
  end;
end;

function TFmxObject.AsIControl: IControl;
begin
  Result := nil;
end;

function IsUniqueGlobalNameProc(const Name: string): Boolean;
begin
  if Length(Name) = 0 then
    Result := True
  else
    Result := Not Assigned(FindGlobalComponent(Name));
end;

function TFmxObject.Clone(const AOwner: TComponent): TFmxObject;
var
  S: TStream;
  SaveName: string;
  Reader: TFmxReader;
  FSaveIsUniqueGlobalComponentName: TIsUniqueGlobalComponentName;
begin
  ActivateClassGroup(TFmxObject);
  S := TMemoryStream.Create;
  Result := nil;
  try
    { store }
    SaveName := Name;
    Name := '';
    S.WriteComponent(Self);
    Name := SaveName;
    S.Position := 0;
    { load }
    FSaveIsUniqueGlobalComponentName := IsUniqueGlobalComponentNameProc;
    IsUniqueGlobalComponentNameProc := IsUniqueGlobalNameProc;
    try
      Reader := TFmxReader.Create(S, 4096);
      try
        Result := TFmxObject(Reader.ReadRootComponent(nil));
        if Assigned(AOwner) then
          AOwner.InsertComponent(Result);
      finally
        Reader.Free;
        if not Assigned(Result) then
          Result := TFmxObjectClass(ClassType).Create(AOwner);
      end;
    finally
      IsUniqueGlobalComponentNameProc := FSaveIsUniqueGlobalComponentName;
    end;
  finally
    S.Free;
  end;
end;

procedure TFmxObject.DoGesture(const EventInfo: TGestureEventInfo;
  var Handled: Boolean);
begin
  // Override DoGesture to implement default behaviour
  Handled := False;
end;

procedure TFmxObject.CMGesture(var EventInfo: TGestureEventInfo);
var
  Handled: Boolean;
begin
  Handled := False;

  if Assigned(FOnGesture) then
    try
      FOnGesture(Self, EventInfo, Handled);
    except
      Application.HandleException(Self);
    end;

  if not Handled then
    try
      DoGesture(EventInfo, Handled);
    except
      Application.HandleException(Self);
    end;

  if not Handled then
    if Assigned(FParent) and (EventInfo.GestureID <> sgiNoGesture) then
      FParent.CMGesture(EventInfo);
end;

function TFmxObject.ContainsObject(AObject: TFmxObject): Boolean;
begin
  Result := FChildren.Contains(AObject);
end;

{ Property animation }

procedure TFmxObject.AnimateColor(const APropertyName: string; NewValue: TAlphaColor; Duration: Single = 0.2;
  AType: TAnimationType = TAnimationType.atIn;
  AInterpolation: TInterpolationType = TInterpolationType.itLinear);
var
  A: TColorAnimation;
begin
  StopPropertyAnimation(APropertyName);
  A := TColorAnimation.Create(Self);
  A.Parent := Self;
  A.AnimationType := AType;
  A.Interpolation := AInterpolation;
  A.OnFinish := DoAniFinished;
  A.Duration := Duration;
  A.PropertyName := APropertyName;
  A.StartFromCurrent := True;
  A.StopValue := NewValue;
  A.Start;
end;

procedure TFmxObject.AnimateFloat(const APropertyName: string; const NewValue: Single; Duration: Single = 0.2;
  AType: TAnimationType = TAnimationType.atIn;
  AInterpolation: TInterpolationType = TInterpolationType.itLinear);
var
  A: TFloatAnimation;
begin
  StopPropertyAnimation(APropertyName);
  A := TFloatAnimation.Create(Self);
  A.Parent := Self;
  A.AnimationType := AType;
  A.Interpolation := AInterpolation;
  A.OnFinish := DoAniFinished;
  A.OnProcess := DoAniProcess;
  A.Duration := Duration;
  A.PropertyName := APropertyName;
  A.StartFromCurrent := True;
  A.StopValue := NewValue;
  A.Start;
end;

procedure TFmxObject.AnimateFloatDelay(const APropertyName: string; const NewValue: Single; Duration: Single = 0.2;
  Delay: Single = 0.0; AType: TAnimationType = TAnimationType.atIn;
  AInterpolation: TInterpolationType = TInterpolationType.itLinear);
var
  A: TFloatAnimation;
begin
  A := TFloatAnimation.Create(Self);
  A.Parent := Self;
  A.AnimationType := AType;
  A.Interpolation := AInterpolation;
  A.Delay := Delay;
  A.Duration := Duration;
  A.PropertyName := APropertyName;
  A.StartFromCurrent := True;
  A.StopValue := NewValue;
  A.Start;
end;

procedure TFmxObject.AnimateFloatWait(const APropertyName: string; const NewValue: Single; Duration: Single = 0.2;
  AType: TAnimationType = TAnimationType.atIn;
  AInterpolation: TInterpolationType = TInterpolationType.itLinear);
var
  A: TFloatAnimation;
begin
  StopPropertyAnimation(APropertyName);
  A := TFloatAnimation.Create(Self);
  try
    A.Parent := Self;
    A.AnimationType := AType;
    A.Interpolation := AInterpolation;
    A.Duration := Duration;
    A.PropertyName := APropertyName;
    A.StartFromCurrent := True;
    A.StopValue := NewValue;
    A.Start;
    while A.FRunning do
    begin
      Application.ProcessMessages;
      Sleep(0);
    end;
  finally
    A.DisposeOf;
  end;
end;

procedure TFmxObject.AnimateInt(const APropertyName: string; const NewValue: Integer; Duration: Single = 0.2;
  AType: TAnimationType = TAnimationType.atIn;
  AInterpolation: TInterpolationType = TInterpolationType.itLinear);
var
  A: TIntAnimation;
begin
  StopPropertyAnimation(APropertyName);
  A := TIntAnimation.Create(Self);
  A.Parent := Self;
  A.AnimationType := AType;
  A.Interpolation := AInterpolation;
  A.OnFinish := DoAniFinished;
  A.OnProcess := DoAniProcess;
  A.Duration := Duration;
  A.PropertyName := APropertyName;
  A.StartFromCurrent := True;
  A.StopValue := NewValue;
  A.Start;
end;

procedure TFmxObject.AnimateIntWait(const APropertyName: string; const NewValue: Integer; Duration: Single = 0.2;
  AType: TAnimationType = TAnimationType.atIn;
  AInterpolation: TInterpolationType = TInterpolationType.itLinear);
var
  A: TIntAnimation;
begin
  StopPropertyAnimation(APropertyName);
  A := TIntAnimation.Create(Self);
  try
    A.Parent := Self;
    A.AnimationType := AType;
    A.Interpolation := AInterpolation;
    A.Duration := Duration;
    A.PropertyName := APropertyName;
    A.StartFromCurrent := True;
    A.StopValue := NewValue;
    A.Start;
    while A.FRunning do
    begin
      Application.ProcessMessages;
      Sleep(0);
    end;
  finally
    A.DisposeOf;
  end;
end;

procedure TFmxObject.StopPropertyAnimation(const APropertyName: string);
var
  I: Integer;
begin
  for I := (ChildrenCount - 1) downto 0 do
  begin
    if (Children[I] is TCustomPropertyAnimation) and
       (CompareText(TCustomPropertyAnimation(Children[I]).PropertyName, APropertyName) = 0) then
      TFloatAnimation(Children[I]).Stop;
  end;
end;

procedure TFmxObject.DoAniFinished(Sender: TObject);
begin
  TAnimation(Sender).DisposeOf;
end;

procedure TFmxObject.DoAniProcess(Sender: TObject);
begin

end;

{ Animations }

procedure TFmxObject.StartAnimation(const AName: string);
var
  I: Integer;
  E: TAnimation;
begin
  if Assigned(FChildren) then
    for I := 0 to FChildren.Count - 1 do
    begin
      if TFmxObject(FChildren[I]) is TAnimation then
        if CompareText(TAnimation(FChildren[I]).Name, AName) = 0 then
        begin
          E := TAnimation(FChildren[I]);
          E.Start;
        end;
    end;
end;

procedure TFmxObject.StopAnimation(const AName: string);
var
  I: Integer;
  E: TAnimation;
begin
  if Assigned(FChildren) then
    for I := FChildren.Count - 1 downto 0 do
      if TFmxObject(FChildren[I]) is TAnimation then
        if CompareText(TAnimation(FChildren[I]).Name, AName) = 0 then
        begin
          E := TAnimation(FChildren[I]);
          E.Stop;
        end;
end;

procedure TFmxObject.StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string);
var
  I: Integer;
begin
  StopTriggerAnimation(AInstance, ATrigger);
  if Assigned(FChildren) then
    for I := 0 to FChildren.Count - 1 do
    begin
      if FChildren[I] is TAnimation then
        TAnimation(FChildren[I]).StartTrigger(AInstance, ATrigger);
      { locked objects }
      if FChildren[I].IsIControl and FChildren[I].AsIControl.Locked and not FChildren[I].AsIControl.HitTest then
        FChildren[I].StartTriggerAnimation(AInstance, ATrigger);
    end;
end;

procedure TFmxObject.StartTriggerAnimationWait(const AInstance: TFmxObject; const ATrigger: string);
var
  I: Integer;
begin
  StopTriggerAnimation(AInstance, ATrigger);
  if Assigned(FChildren) then
    for I := 0 to FChildren.Count - 1 do
    begin
      if FChildren[I] is TAnimation then
      begin
        TAnimation(FChildren[I]).StartTrigger(AInstance, ATrigger);
        while TAnimation(FChildren[I]).Running do
        begin
          Application.ProcessMessages;
          Sleep(0);
        end;
      end;
      { locked objects }
      if FChildren[I].IsIControl and FChildren[I].AsIControl.Locked and not FChildren[I].AsIControl.HitTest then
        FChildren[I].StartTriggerAnimationWait(AInstance, ATrigger);
    end;
end;

procedure TFmxObject.StopTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string);
var
  Item: TFmxObject;
begin
  if Assigned(Children) then
    for Item in Children do
    begin
      if TFmxObject(Item) is TAnimation then
        TAnimation(Item).StopTrigger(AInstance, ATrigger);
      { locked objects }
      if Item.IsIControl and Item.AsIControl.Locked and
        not Item.AsIControl.HitTest then
        Item.StopTriggerAnimation(AInstance, ATrigger);
    end;
end;

function TFmxObject.SupportsPlatformService(const AServiceGUID: TGUID; out AService: IInterface): Boolean;
begin
  {$IFDEF MSWINDOWS}
  if Assigned(Owner) and (csDesigning in Owner.ComponentState) and (Owner is TCommonCustomForm) and
    Assigned(TCommonCustomForm(Owner).Designer) and
    TCommonCustomForm(Owner).Designer.SupportsPlatformService(AServiceGUID, AService)
  then
    Result := True
  else 
  {$ENDIF}
  if TPlatformServices.Current.SupportsPlatformService(AServiceGUID, AService) then
    Result := True
  else begin
    AService := nil;
    Result := False;
  end;
end;

procedure TFmxObject.ApplyTriggerEffect(const AInstance: TFmxObject; const ATrigger: string);
var
  Obj: TFmxObject;
begin
  if Assigned(Children) then
    for Obj in Children do
    begin
      if Obj is TEffect then
        TEffect(Obj).ApplyTrigger(AInstance, ATrigger);
      { locked objects }
      if Obj.IsIControl and Obj.AsIControl.Locked and
        not Obj.AsIControl.HitTest then
      begin
        Obj.ApplyTriggerEffect(AInstance, ATrigger);
      end;
    end;
end;

procedure TFmxObject.SetRoot(ARoot: IRoot);
var
  I: Integer;
begin
  FRoot := ARoot;
  if Assigned(FChildren) and (FChildren.Count > 0) then
    for I := 0 to FChildren.Count - 1 do
      TFmxObject(FChildren[I]).SetRoot(FRoot);
end;

procedure TFmxObject.ChangeChildren;
begin
  if Assigned(FStyleObjectsDict) then
    FreeAndNil(FStyleObjectsDict);
end;

procedure TFmxObject.ChangeOrder;
begin
  if not(csLoading in ComponentState) and Assigned(Parent) then
    Parent.ChangeChildren;
end;

procedure TFmxObject.ChangeParent;
begin
end;

procedure TFmxObject.SetParent(const Value: TFmxObject);
begin
  if Value = Self then
    Exit;
  if FParent <> Value then
  begin
    if IsChild(Value) then
       raise EInvalidOperation.Create(SCannotCreateCircularDependence);
    if Assigned(FParent) then
      FParent.RemoveObject(Self);
    if Assigned(Value) then
      Value.AddObject(Self)
    else
      FParent := Value;
  end;
end;

function TFmxObject.GetChildrenCount: Integer;
begin
  if Assigned(FChildrenList) then
    Result := FChildrenList.Count
  else
    Result := 0;
end;

procedure TFmxObject.SetParentComponent(Value: TComponent);
var
  R: IRoot;
begin
  inherited;
  if Assigned(FParent) then
    FParent.RemoveObject(Self);

  if Assigned(Value) and (Value is TFmxObject) then
  begin
    TFmxObject(Value).AddObject(Self);
  end
  else if (IInterface(Value).QueryInterface(IRoot, R) = 0) then
  begin
    R.AddObject(Self);
  end
end;

procedure TFmxObject.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I, J: Integer;
  Content: IContent;
begin
  inherited;
  if Supports(Self, IContent) then
    Exit;
  if Assigned(FChildren) then
    for I := 0 to FChildren.Count - 1 do
    begin
      if Supports(FChildren[I], IContent, Content) and (Content.ChildrenCount > 0) then
      begin
        for J := 0 to Content.ChildrenCount - 1 do
          if Content.GetObject.Children[J].Stored then
            Proc(Content.GetObject.Children[J]);
      end;
      if FChildren[I].Stored then
        Proc(FChildren[I]);
    end;
end;

function TFmxObject.GetParentComponent: TComponent;
var
  Content: IContent;
begin
  if Assigned(FParent) and Supports(FParent, IContent, Content) then
    Result := Content.Parent
  else
    Result := FParent;
  if (Not Assigned(Result)) and Assigned(FRoot) then
    Result := FRoot.GetObject;
end;

function TFmxObject.HasParent: Boolean;
begin
  Result := Assigned(FParent);
end;

function TFmxObject.GetData: TValue;
begin
  Result := Name;
end;

procedure TFmxObject.SetData(const Value: TValue);
begin
end;

function TFmxObject.GetActionLinkClass: TActionLinkClass;
begin
  Result := nil;
end;

procedure TFmxObject.IgnoreBindingName(Reader: TReader);
begin
  Reader.ReadString;
end;

procedure TFmxObject.IgnoreBooleanValue(Reader: TReader);
begin
  Reader.ReadBoolean;
end;

procedure TFmxObject.IgnoreFloatValue(Reader: TReader);
begin
  Reader.ReadFloat;
end;

procedure TFmxObject.InitiateAction;
var
  LAction: TOpenCustomAction;
begin
  if Assigned(FActionLink) then
  begin
    if FActionLink.Action is TCustomAction then
      LAction := TOpenCustomAction(FActionLink.Action)
    else
      LAction := nil;
    if Assigned(LAction) then
      LAction.SetTarget(self);
    try
      if not FActionLink.Update then
        UpdateAction(FActionLink.Action);
    finally
      if Assigned(LAction) then
        LAction.SetTarget(nil);
    end;
  end;
end;

function TFmxObject.GetAction: TBasicAction;
begin
  if Assigned(FActionLink) then
    Result := FActionLink.Action
  else
    Result := nil;
end;

procedure TFmxObject.SetAction(const Value: TBasicAction);
var
  lClass: TActionLinkClass;
begin
  if Not Assigned(Value) then
  begin
    if Assigned(Application) then
      Application.UnregisterActionClient(Self);
    FreeAndNil(FActionLink);
    SetActionClient(False);
  end
  else
  begin
    if Not Assigned(FActionLink) then
    begin
      lClass := GetActionLinkClass;
      if Not Assigned(lClass) then
        raise EActionError.CreateFMT(StrEActionNoSuported, [ClassName]);
      FActionLink := lClass.Create(Self);
    end;
    ActionLink.Action := Value;
    ActionLink.OnChange := DoActionChange;
    ActionChange(Value, csLoading in Value.ComponentState);
    Value.FreeNotification(Self);
    SetActionClient(True);
    if Assigned(Application) then
      Application.RegisterActionClient(Self);
  end;
end;

procedure TFmxObject.DoActionChange(Sender: TObject);
begin
  if Sender = Action then ActionChange(TBasicAction(Sender), False);
end;

procedure TFmxObject.ActionChange(Sender: TBasicAction; CheckDefaults: Boolean);
begin
end;

procedure TFmxObject.DoActionClientChanged;
begin
end;

procedure TFmxObject.SetDesign(Value, SetChildren: Boolean);
var
  I: Integer;
begin
  SetDesigning(Value, SetChildren);
  if SetChildren then
    for I := 0 to ChildrenCount - 1 do
      FChildren[I].SetDesign(Value);
end;

function TFmxObject.GetBackIndex: Integer;
begin
  Result := 0;
end;

{ }

function TFmxObject.SearchInto: Boolean;
begin
  Result := True;
end;

procedure TFmxObject.DoInventory(Dict: TDictionary<string, TFmxObject>;
  const Prefix: string);
var
  O: TFmxObject;
  IsRoot: Boolean;
  Key: string;
begin
  IsRoot := False;
  if Dict = nil then
  begin
    if FStyleObjectsDict = nil then
    begin
      FStyleObjectsDict := TDictionary<string, TFmxObject>.Create;
      Dict := FStyleObjectsDict;
      IsRoot := True;
    end
    else
      Exit;
  end;

  if Assigned(FChildren) then
    for O in FChildren do
    begin
      if O.StyleName <> '' then
      begin
        Key := O.StyleName.ToLowerInvariant;
        Dict.AddOrSetValue(Key, O);
        if not IsRoot then
        begin
          if Prefix <> '' then
            Dict.AddOrSetValue(Format('%s.%s',[Prefix, Key]), O);
        end;
      end;
      if O.SearchInto then
        O.DoInventory(Dict, O.StyleName);
    end;
end;

function TFmxObject.FindStyleResource(const AStyleLookup: string; const Clone: Boolean = False): TFmxObject;
{$IFDEF NOSTYLERESOURCECACHE}
var
  I, J: Integer;
  LName: string;
{$ENDIF}

  function FindOnTopLevel(const Name: string): TFmxObject;
  var
    Child: TFmxObject;
  begin
    for Child in FChildren do
    begin
      if SameText(Child.StyleName, Name) then
      begin
        Exit(Child);
      end;
    end;
    Result := nil;
  end;

  function FindOnAllLevel(const Name: string): TFmxObject;
  var
    Child: TFmxObject;
  begin
    Result := FindOnTopLevel(Name);
    if not Assigned(Result) then
      for Child in FChildren do
      begin
        if Child.SearchInto then
        begin
          Result := Child.FindStyleResource(Name);
          if Assigned(Result) then
            Exit;
        end;
      end;
  end;

var
  SaveStyleName: string;
  StyleObject: TFmxObject;
begin
  StyleObject := nil;
  if (AStyleLookup <> '') and
     Assigned(FChildren) and
     (FChildren.Count > 0) then
  begin
{$IFDEF NOSTYLERESOURCECACHE}
    J := AStyleLookup.IndexOf('.');
    if J >= 0 then
    begin
      // Match substring to the first point of top-level elements
      LName := AStyleLookup.Substring(0, J);
      StyleObject := FindOnTopLevel(LName);
      // Search the rest of string in the element found
      if Assigned(StyleObject) then
      begin
        LName := AStyleLookup.Substring(J + 1);
        StyleObject := StyleObject.FindStyleResource(LName);
      end;
    end;
    // Match substring after the last dot (old algorithm)
    if (not Assigned(StyleObject)) then
    begin
      if J >= 0 then
      repeat
        I := AStyleLookup.IndexOf('.', J + 1);
        if I >= 0 then J := I;
      until I < 0;
      if J >= 0 then
        StyleObject := FindOnAllLevel(AStyleLookup.Substring(J + 1))
      else
        StyleObject := FindOnAllLevel(AStyleLookup);
    end;
{$ELSE}
    DoInventory(nil, '');
    FStyleObjectsDict.TryGetValue(AStyleLookup.ToLowerInvariant, StyleObject);
{$ENDIF}
  end;
  if Assigned(StyleObject) and Clone then
  begin
    SaveStyleName := StyleObject.StyleName;
    try
      StyleObject.FStyleName := '';
      Result := StyleObject.Clone(nil);
    finally
      StyleObject.FStyleName := SaveStyleName;
    end;
  end else
    Result := StyleObject;
end;

procedure TFmxObject.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    FMX.Types.RemoveResource(Self);

    FStyleName := Value;
    if (FStyleName <> '') and Stored then
      AddResource(Self);
  end;
end;

procedure TFmxObject.SetTouchManager(const Value: TTouchManager);
begin
  FTouchManager := Value;
end;

procedure TFmxObject.SetStored(const Value: Boolean);
var
  I: Integer;
begin
  if FStored <> Value then
  begin
    FStored := Value;
    if Assigned(FChildren) and (FChildren.Count > 0) then
    begin
      for I := 0 to FChildren.Count - 1 do
        TFmxObject(FChildren[I]).Stored := Value;
    end;
    if not Stored then
      RemoveResource(Self);
  end;
end;

procedure TFmxObject.DoDeleteChildren;
var
  I: Integer;
  Child: TFmxObject;
begin
  if Assigned(FChildren) then
  begin
    for I := FChildren.Count - 1 downto 0 do
    begin
      Child := TFmxObject(FChildren[I]);
      FChildren.Delete(I);
      RemoveFromTabList(Child);
      Child.FParent := nil;
      Child.SetRoot(nil);
      Child.DisposeOf;
    end;
    FreeAndNil(FChildren);
    if Assigned(FChildrenList) then
      FreeAndNil(FChildrenList);
  end;
  FTabList := nil;
end;

procedure TFmxObject.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('BindingName', IgnoreBindingName, nil, False);
end;

procedure TFmxObject.DeleteChildren;
begin
  DoDeleteChildren;
end;

procedure TFmxObject.AddObjectsToList(const AList: TFmxObjectList);
var
  I: Integer;
begin
  AList.Add(Self);
  if Assigned(FChildren) then
    for I := 0 to FChildren.Count - 1 do
      FChildren[I].AddObjectsToList(AList);
end;

procedure TFmxObject.AddToTabList(const AObject: TFmxObject);
begin
  if Assigned(AObject) and AObject.IsIControl then
  begin
    if not Assigned(FTabList) then
      FTabList := TInterfaceList.Create;

    FTabList.Add(AObject.AsIControl);
  end;
end;

procedure TFmxObject.RemoveFromTabList(const AObject: TFmxObject);
begin
  if Assigned(FTabList) and Assigned(AObject) and AObject.IsIControl then
    FTabList.Remove(AObject.AsIControl);
end;

function TFmxObject.CreateChildrenList(const Children: TFmxObjectList): TFmxChildrenList;
begin
  Result := TFmxChildrenList.Create(FChildren);
end;

procedure TFmxObject.DoAddObject(const AObject: TFmxObject);
begin
  if not Assigned(FChildren) then
  begin
    FChildren := TFmxObjectList.Create;
    FChildren.Capacity := 10;
    FChildrenList := CreateChildrenList(FChildren);
//    FChildrenList.SetChildrenList(FChildren);
  end;
  //if FChildren.IndexOf(AObject) < 0 then
  //begin
    AObject.FParent := Self;
    AObject.SetRoot(FRoot);
    AObject.ChangeParent;
    FChildren.Add(AObject);
    if csDesigning in ComponentState then
      AObject.SetDesign(True, True);
    AddToTabList(AObject);
  //end;
end;

procedure TFmxObject.DoRemoveObject(const AObject: TFmxObject);
var
  Idx, I: Integer;
begin
  RemoveFromTabList(AObject);
  if Assigned(FChildren) then
  begin
    Idx := FChildren.IndexOf(AObject);
    if Idx >= 0 then
    begin
      AObject.FParent := nil;
      AObject.SetRoot(nil);
      if AObject.FIndex >= 0 then
        for I := AObject.FIndex to FChildren.Count - 1 do
          TFmxObject(FChildren[I]).FIndex := -1;
      FChildren.Delete(Idx);
    end;
  end;
end;

procedure TFmxObject.AddObject(const AObject: TFmxObject);
begin
  if Assigned(AObject) and (AObject.Parent <> Self) then
  begin
    if Assigned(AObject.Parent) then
      AObject.Parent := nil;
    DoAddObject(AObject);
  end;
end;

procedure TFmxObject.InsertObject(Index: Integer; const AObject: TFmxObject);
begin
  if Assigned(AObject) and (AObject.Parent <> Self) then
  begin
    if Assigned(AObject.Parent) then
      AObject.Parent := nil;
    DoInsertObject(Index, AObject);
  end;
end;

procedure TFmxObject.DoInsertObject(Index: Integer; const AObject: TFmxObject);
var
  I: Integer;
begin
  DoAddObject(AObject);
  FChildren.Insert(Index, FChildren[FChildren.Count - 1]);
  FChildren.Delete(FChildren.Count-1);
  ChangeChildren;
  // update index
  for I := Index to FChildren.Count - 1 do
    FChildren[I].FIndex := -1;
end;

procedure TFmxObject.RemoveObject(const AObject: TFmxObject);
begin
  if Assigned(AObject) then
    DoRemoveObject(AObject);
end;

procedure TFmxObject.Sort(Compare: TFmxObjectSortCompare);
var
  Comparer: IComparer<TFmxObject>;
  Comparsion: TComparison<TFmxObject>;
  I: Integer;
begin
  if Assigned(FChildren) then
  begin
    Comparsion := TComparison<TFmxObject>(Compare);
    Comparer := TComparer<TFmxObject>.Construct(Comparsion);
    FChildren.Sort(Comparer);
    ChangeChildren;
    // update index
    for  I := 0 to FChildren.Count - 1 do
      FChildren[I].FIndex := -1;
  end;
end;

function TFmxObject.GetIndex: Integer;
begin
  if (FIndex < 0) and Assigned(FParent) and Assigned(FParent.Children) then
    FIndex := FParent.Children.IndexOf(Self);
  Result := FIndex;
end;

procedure TFmxObject.SetIndex(Idx: Integer);
var
  I: Integer;
begin
  if Assigned(Parent) and (Parent.FChildren.IndexOf(Self) >= 0) then
  begin
    Parent.FChildren.Remove(Self);
    if (Idx < 0) then
      Idx := 0;
    if (Idx > 0) and (Idx > Parent.FChildren.Count) then
      Idx := Parent.FChildren.Count;
    Parent.FChildren.Insert(Idx, Self);
    // recalc Index
    for I := 0 to Parent.FChildren.Count - 1 do
      TFmxObject(Parent.FChildren[I]).FIndex := -1;
    ChangeOrder;
  end;
end;

procedure TFmxObject.Exchange(const AObject1, AObject2: TFmxObject);
var
  Idx: Integer;
begin
  if Assigned(FChildren) and (AObject1.Parent = Self) and (AObject2.Parent = Self) then
  begin
    FChildren.Exchange(AObject1.Index, AObject2.Index);
    Idx := AObject1.FIndex;
    AObject1.FIndex := AObject2.Index;
    AObject1.ChangeOrder;
    AObject2.FIndex := Idx;
    AObject2.ChangeOrder;
  end;
end;

procedure TFmxObject.GetTabOrderList(const List: TInterfaceList; AChildren: Boolean);
var
  I: Integer;
  Control: IControl;
begin
  if Assigned(FTabList) then
    for I := 0 to FTabList.Count - 1 do
    begin
      Control := IControl(FTabList[I]);
      List.Add(Control);
      if AChildren and (Control.GetObject is TFmxObject) then
        TFmxObject(Control).GetTabOrderList(List, AChildren);
    end;
end;

function TFmxObject.GetTouchManager: TTouchManager;
begin
  if not Assigned(FTouchManager) then
    FTouchManager := TTouchManager.Create(Self);

  Result := FTouchManager;
end;

procedure TFmxObject.FixupTabList;
var
  I, J: Integer;
  List: TInterfaceList;
  Control: IControl;
begin
  if not Assigned(FTabList) then
    Exit;
  List := TInterfaceList.Create;
  try
    List.Count := FTabList.Count;
    for I := 0 to FTabList.Count - 1 do
    begin
      Control := IControl(FTabList[I]);
      J := Control.GetTabOrderValue;       // = loaded FTabOrder value
      if (J >= 0) and (J < FTabList.Count) then
        List[J] := Control;
    end;
    for I := 0 to FTabList.Count - 1 do
    begin
      Control := IControl(List[I]);
      if Assigned(Control) then
        Control.UpdateTabOrder(I);
    end;
  finally
    List.Free;
  end;
end;

procedure TFmxObject.BringToFront;
var
  I: Integer;
begin
  if Assigned(Parent) and Assigned(Parent.FChildren) then
  begin
    Parent.FChildren.Remove(Self);
    Parent.FChildren.Add(Self);
    // recalc Index
    for I := 0 to Parent.FChildren.Count - 1 do
      TFmxObject(Parent.FChildren[I]).FIndex := -1;
    ChangeOrder;
  end;
end;

procedure TFmxObject.SendToBack;
var
  I: Integer;
begin
  if Assigned(Parent) and Assigned(Parent.FChildren) then
  begin
    Parent.FChildren.Remove(Self);
    Parent.FChildren.Insert(Parent.GetBackIndex, Self);
    // recalc Index
    for I := 0 to Parent.FChildren.Count - 1 do
      TFmxObject(Parent.FChildren[I]).FIndex := -1;
    ChangeOrder;
  end;
end;

{ TLang }

function ReadString(S: TStream): string;
var
  L: Integer;
begin
  L := 0;
  S.Read(L, SizeOf(L));
  SetLength(Result, L);
  S.Read(Pointer(Result)^, L * 2);
end;

procedure WriteString(S: TStream; const Value: string);
var
  L: Integer;
begin
  L := Length(Value);
  S.Write(L, SizeOf(L));
  S.Write(Pointer(Value)^, L * 2);
end;

constructor TLang.Create(AOwner: TComponent);
begin
  inherited;
  FOriginal := TStringList.Create;
  FResources := TStringList.Create;
  FAutoSelect := True;
  FStoreInForm := True;
end;

destructor TLang.Destroy;
var
  I: Integer;
begin
  for I := 0 to FResources.Count - 1 do
    TStrings(FResources.Objects[I]).DisposeOf;
  FreeAndNil(FResources);
  FreeAndNil(FOriginal);
  inherited;
end;

procedure TLang.Loaded;
var
  LocaleSvc: IFMXLocaleService;
begin
  inherited;
  if not FFileName.IsEmpty then
    if FileExists(FFileName) then
      LoadFromFile(FFileName);
  if FAutoSelect and TPlatformServices.Current.SupportsPlatformService(IFMXLocaleService, IInterface(LocaleSvc)) then
    FLang := LocaleSvc.GetCurrentLangID;
  if FLang <> '' then
    LoadLangFromStrings(LangStr[FLang]);
end;

procedure TLang.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('ResourcesBin', ReadResources, WriteResources, StoreInForm and (FResources.Count > 0));
end;

procedure TLang.ReadResources(Stream: TStream);
var
  len: Cardinal;
  I: Integer;
  N: string;
  Str: TStrings;
begin
  FOriginal.Text := ReadString(Stream);
  Stream.Read(len, 4);
  for I := 0 to len - 1 do
  begin
    N := ReadString(Stream);
    Str := TStringList.Create;
//    TStringList(Str).Sorted := True;
    TStringList(Str).CaseSensitive := True;
    Str.Text := ReadString(Stream);
    FResources.AddObject(N, Str);
  end;
end;

procedure TLang.WriteResources(Stream: TStream);
var
  len: Cardinal;
  I: Integer;
begin
  WriteString(Stream, FOriginal.Text);
  len := FResources.Count;
  Stream.Write(len, 4);
  for I := 0 to len - 1 do
  begin
    WriteString(Stream, FResources[I]);
    WriteString(Stream, TStrings(FResources.Objects[I]).Text);
  end;
end;

procedure TLang.LoadFromFile(const AFileName: string);
var
  S: TFileStream;
begin
  if FileExists(AFileName) then
  begin
    S := TFileStream.Create(AFileName, fmOpenRead);
    try
      ReadResources(S);
    finally
      S.Free;
    end;
  end;
end;

procedure TLang.SaveToFile(const AFileName: string);
var
  S: TFileStream;
begin
  S := TFileStream.Create(AFileName, fmCreate);
  try
    WriteResources(S);
  finally
    S.Free;
  end;
end;

procedure TLang.AddLang(const AName: string);
var
  Idx: Integer;
  Str: TStrings;
begin
  Idx := FResources.IndexOf(AName);
  if Idx < 0 then
  begin
    Str := TStringList.Create;
//    TStringList(Str).Sorted := True;
    TStringList(Str).CaseSensitive := True;
    FResources.AddObject(AName, Str);
  end;
end;

function TLang.GetLangStr(const Index: string): TStrings;
var
  Idx: Integer;
begin
  Idx := FResources.IndexOf(Index);
  if Idx >= 0 then
    Result := TStrings(FResources.Objects[Idx])
  else
    Result := nil;
end;

procedure TLang.SetLang(const Value: string);
begin
  FLang := Value;
  if not(csLoading in ComponentState) then
  begin
    if FLang = 'en' then
      ResetLang
    else
      LoadLangFromStrings(LangStr[FLang]);
  end;
end;

{ TTimer }

constructor TTimer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInterval := 1000;
  FTimerHandle := cIdNoTimer;
  FEnabled := True;
  if not TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, IInterface(FPlatformTimer)) then
    raise EUnsupportedPlatformService.Create('IFMXTimerService');
end;

destructor TTimer.Destroy;
begin
  FOnTimer := nil;
  FEnabled := False;
  KillTimer;
  inherited Destroy;
end;

procedure TTimer.KillTimer;
begin
  if FTimerHandle <> cIdNoTimer then
  begin
    FPlatformTimer.DestroyTimer(FTimerHandle);
    FTimerHandle := cIdNoTimer;
  end;
end;

procedure TTimer.Loaded;
begin
  inherited Loaded;
  UpdateTimer;
end;

procedure TTimer.UpdateTimer;
begin
  KillTimer;
  if (FEnabled) and (FInterval > 0) and (([csDesigning, csLoading, csDestroying] * ComponentState = [])) and
    Assigned(FOnTimer) then
  begin
    FTimerHandle := FPlatformTimer.CreateTimer(FInterval, Timer);
    if FTimerHandle = 0 then
      FEnabled := False;
  end;
end;

procedure TTimer.Timer;
begin
  if (FEnabled) and (FInterval > 0) then
    DoOnTimer;
end;

procedure TTimer.SetOnTimer(Value: TNotifyEvent);
begin
  if DelegatesEqual(@Value, @FOnTimer) then
    Exit;
  FOnTimer := Value;
  UpdateTimer;
end;

procedure TTimer.DoOnTimer;
begin
  if Assigned(FOnTimer) then
    FOnTimer(Self);
end;

procedure TTimer.SetEnabled(Value: Boolean);
begin
  if (Value <> FEnabled) then
  begin
    FEnabled := Value;
    UpdateTimer;
  end;
end;

procedure TTimer.SetInterval(Value: Cardinal);
begin
  if (Value <> FInterval) then
  begin
    FInterval := Value;
    UpdateTimer;
  end;
end;

{ TBrushObject }

constructor TBrushObject.Create(AOwner: TComponent);
begin
  inherited;
  FBrush := TBrush.Create(TBrushKind.bkSolid, $FFFFFFFF);
end;

destructor TBrushObject.Destroy;
begin
  FreeAndNil(FBrush);
  inherited;
end;

function TBrushObject.GetBrush: TBrush;
begin
  Result := FBrush;
end;

procedure TBrushObject.SetName(const NewName: TComponentName);
begin
  inherited;
  if FStyleName = '' then
    FStyleName := Name;
end;

{ TFontObject }

constructor TFontObject.Create(AOwner: TComponent);
begin
  inherited;
  FFont := TFont.Create;
end;

destructor TFontObject.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;

function TFontObject.GetFont: TFont;
begin
  Result := FFont;
end;

procedure TFontObject.SetName(const NewName: TComponentName);
begin
  inherited;
  if FStyleName = '' then
    FStyleName := Name;
end;

{ TPathObject }

constructor TPathObject.Create(AOwner: TComponent);
begin
  inherited;
  FPath := TPathData.Create();
end;

destructor TPathObject.Destroy;
begin
  FreeAndNil(FPath);
  inherited;
end;

function TPathObject.GetPath: TPathData;
begin
  Result := FPath;
end;

procedure TPathObject.SetName(const NewName: TComponentName);
begin
  inherited;
  if FStyleName = '' then
    FStyleName := Name;
end;

{ TBitmapObject }

constructor TBitmapObject.Create(AOwner: TComponent);
begin
  inherited;
  FBitmap := TBitmap.Create(1, 1);
end;

destructor TBitmapObject.Destroy;
begin
  FreeAndNil(FBitmap);
  inherited;
end;

function TBitmapObject.GetBitmap: TBitmap;
begin
  Result := FBitmap;
end;

procedure TBitmapObject.SetName(const NewName: TComponentName);
begin
  inherited;
  if FStyleName = '' then
    FStyleName := Name;
end;

{ TCanvasSaveState }

procedure TCanvasSaveState.Assign(Source: TPersistent);
var
  LCanvas: TCanvas;
begin
  if Source is TCanvas then
  begin
    LCanvas := TCanvas(Source);
    Self.FAssigned := True;
    Self.FMatrix := LCanvas.FMatrix;
    Self.FFill.Assign(LCanvas.Fill);
    Self.FStroke.Assign(LCanvas.Stroke);
    Self.FFont.Assign(LCanvas.Font);
  end else
    inherited;
end;

procedure TCanvasSaveState.AssignTo(Dest: TPersistent);
var
  LCanvas: TCanvas;
begin
  if Dest is TCanvas then
  begin
    LCanvas := TCanvas(Dest);
    Self.FAssigned := False;
    LCanvas.SetMatrix(Self.FMatrix);
    LCanvas.Fill.Assign(Self.FFill);
    LCanvas.Stroke.Assign(Self.FStroke);
    LCanvas.Font.Assign(Self.FFont);
  end else
    inherited;
end;

constructor TCanvasSaveState.Create;
begin
  inherited Create;
  FFont := TFont.Create;
  FFill := TBrush.Create(TBrushKind.bkSolid, TAlphaColors.Black);
  FStroke := TStrokeBrush.Create(TBrushKind.bkSolid, TAlphaColors.White);
end;

destructor TCanvasSaveState.Destroy;
begin
  FFont.Free;
  FFill.Free;
  FStroke.Free;
  inherited;
end;

{ TLineMetricInfo }

constructor TLineMetricInfo.Create;
begin
  inherited;
  Clear;
end;

destructor TLineMetricInfo.Destroy;
begin
  Clear;
  inherited;
end;

function TLineMetricInfo.GetCount: integer;
begin
  Result := Length(FLineMetrics);
end;

function TLineMetricInfo.GetMetrics(Index: Integer): PLineMetric;
begin
  Result := @FLineMetrics[Index];
end;

procedure TLineMetricInfo.SetCount(const Value: Integer);
begin
  if Count <> Value then
    SetLength(FLineMetrics, Value);
end;

procedure TLineMetricInfo.Clear;
begin
  SetLength(FLineMetrics, 0);
end;

procedure RecalcAnchorRules(const Parent : TFmxObject;
            Anchors : TAnchors;
            const BoundsRect : TRectF;
            const Padding : TBounds;
            var AOriginalParentSize:TPointF;
            var AAnchorOrigin:TPointF;
            var AAnchorRules:TPointF
            );
var
  Rect : TRectF;
begin
  Rect := BoundsRect;
  Rect.Left := Rect.Left - Padding.Left;
  Rect.Top := Rect.Top - Padding.Top;
  Rect.Right := Rect.Right + Padding.Right;
  Rect.Bottom := Rect.Bottom + Padding.Bottom;

  AAnchorOrigin := PointF(Rect.Left + Rect.Width / 2, Rect.Top + Rect.Height / 2);
  if Anchors = [TAnchorKind.akLeft, TAnchorKind.akTop] then
  begin
    AOriginalParentSize.X := 0;
    AOriginalParentSize.Y := 0;
    Exit;
  end;
  if TAnchorKind.akRight in Anchors then
    if TAnchorKind.akLeft in Anchors then
      AAnchorRules.X := Rect.Width else
      AAnchorRules.X := Rect.Left
  else
    AAnchorRules.X := Rect.Left + Rect.Width/2;
  if TAnchorKind.akBottom in Anchors then
    if TAnchorKind.akTop in Anchors then
      AAnchorRules.Y := Rect.Height else
      AAnchorRules.Y := Rect.Top
  else
    AAnchorRules.Y := Rect.Top + Rect.Height/2;
end;

procedure RecalcControlOriginalParentSize(
              const Parent: TFmxObject;
              ComponentState : TComponentState;
              var AOriginalParentSize : TPointF);
var
  Alignable : IAlignableObject;
  Container : IContainerObject;
  OriginalSize: IOriginalContainerSize;
  R : TRectF;
  Margins : TRectF;
begin
  if Supports(Parent, IAlignableObject, Alignable) then
  begin
    R := RectF(0, 0, Alignable.Width, Alignable.Height);
    R.Offset(Alignable.Left, Alignable.Top);
    Margins := Alignable.Margins.GetRect;
  end
  else if Supports(Parent, IOriginalContainerSize, OriginalSize) then
  begin
    R.TopLeft := TPointF.Create(0,0);
    R.BottomRight := OriginalSize.OriginalContainerSize;
    Margins := RectF(0,0,0,0);
  end
  else if Supports(Parent, IContainerObject, Container) then
  begin
    R := RectF(0, 0, Container.ContainerWidth, Container.ContainerHeight);
    Margins := RectF(0,0,0,0);
  end
  else
    Exit;

  if csReading in ComponentState then
  begin
    if not (csDesigning in ComponentState) then
    begin
        AOriginalParentSize.X := R.Left;
        AOriginalParentSize.Y := R.Top;
    end
  end
  else
  begin
    AOriginalParentSize.X := R.Width;
    AOriginalParentSize.Y := R.Height;
  end;

  AOriginalParentSize.X:= AOriginalParentSize.X - (Margins.Left + Margins.Right);
  AOriginalParentSize.Y:= AOriginalParentSize.Y - (Margins.Top + Margins.Bottom);
end;

{ TStrokeBrush.TDashData }

constructor TStrokeBrush.TDashData.Create(const ADashArray: TDashArray;
  ADashOffset: Single);
begin
  DashArray := ADashArray;
  DashOffset := ADashOffset;
end;


{ TCustomTouchManager.TObjectWrapper }
constructor TCustomTouchManager.TObjectWrapper.Create(const AObject: TFmxObject);
begin
  FObject := AObject;
end;

{ TCustomTouchManager }
procedure TCustomTouchManager.AssignTo(Dest: TPersistent);
begin
  if Dest is TCustomTouchManager then
    with TCustomTouchManager(Dest) do
    begin
      FControl := Self.FControl;
      FGestureManager := Self.FGestureManager;
      FGestureEngine := Self.FGestureEngine;
      FInteractiveGestures := Self.FInteractiveGestures;
      FStandardGestures := Self.FStandardGestures;
    end
  else
    inherited;
end;

procedure TCustomTouchManager.ChangeNotification(const AControl: TFmxObject);
begin
end;

constructor TCustomTouchManager.Create(AControl: TFmxObject);
begin
  inherited Create;
  FControl := AControl;
  FGestureEngine := nil;
  FGestureManager := nil;
  FDefaultInteractiveGestures := [];
end;

destructor TCustomTouchManager.Destroy;
begin
  if Assigned(GestureEngine) then
  begin
    GestureEngine.DisposeOf;
    GestureEngine := nil;
  end;

  if Assigned(FGestureManager) then
    SetGestureManager(nil);

  inherited;
end;

function TCustomTouchManager.FindGesture(const AName: string): TCustomGestureCollectionItem;
begin
  Result := nil;
  if Assigned(FGestureManager) then
    Result := FGestureManager.FindGesture(FControl, AName);
end;

function TCustomTouchManager.FindGesture(AGestureID: TGestureID): TCustomGestureCollectionItem;
begin
  Result := nil;
  if Assigned(FGestureManager) then
    Result := FGestureManager.FindGesture(FControl, AGestureID);
end;

function TCustomTouchManager.GetGestureList: TGestureArray;
begin
  Result := nil;
  if Assigned(FGestureManager) then
    Result := FGestureManager.GestureList[FControl];
end;

function TCustomTouchManager.GetStandardGestures: TStandardGestures;
begin
  if Assigned(FGestureManager) then
    FStandardGestures := FGestureManager.StandardGestures[FControl];
  Result := FStandardGestures;
end;

function TCustomTouchManager.IsDefault: Boolean;
begin
  Result := (Not Assigned(FGestureManager)) and not IsInteractiveGesturesStored;
end;

function TCustomTouchManager.IsInteractiveGesturesStored: Boolean;
begin
  Result := InteractiveGestures <> FDefaultInteractiveGestures;
end;

procedure TCustomTouchManager.RemoveChangeNotification(const AControl: TFmxObject);
begin
end;

function TCustomTouchManager.SelectGesture(const AName: string): Boolean;
begin
  Result := False;
  if Assigned(FGestureManager) then
    Result := FGestureManager.SelectGesture(FControl, AName);
end;

function TCustomTouchManager.SelectGesture(AGestureID: TGestureID): Boolean;
begin
  Result := False;
  if Assigned(FGestureManager) then
    Result := FGestureManager.SelectGesture(FControl, AGestureID);
end;

procedure TCustomTouchManager.SetGestureEngine(const Value: TCustomGestureEngine);
begin
  if (Value <> FGestureEngine) and (FControl is TFmxObject) then
  begin
    FGestureEngine := Value;
    if (Assigned(FControl) and Assigned(FGestureEngine)) then
      FGestureEngine.Active := True;
  end;
end;

procedure TCustomTouchManager.SetGestureManager(const Value: TCustomGestureManager);
begin
  if Value <> FGestureManager then
  begin
    if Assigned(FGestureManager) then
    begin
      FGestureManager.RemoveFreeNotification(FControl);
      FGestureManager.UnregisterControl(FControl);
      FGestureManager := nil; // Must be set to nil before calling RegisterControl!!
    end;
    if Assigned(Value) then
    begin
      Value.FreeNotification(FControl);
      Value.RegisterControl(FControl);
    end;
    FGestureManager := Value; // Must be assigned after registering the control!!
  end;
end;

procedure TCustomTouchManager.SetStandardGestures(const Value: TStandardGestures);
begin
   if Value <> FStandardGestures then
  begin
    FStandardGestures := Value;
    if Assigned(FGestureManager) then
      FGestureManager.StandardGestures[FControl] := FStandardGestures;
  end;
end;

procedure TCustomTouchManager.UnselectGesture(AGestureID: TGestureID);
begin
  if Assigned(FGestureManager) then
    FGestureManager.UnselectGesture(FControl, AGestureID);
end;

{ TCustomGestureEngine }

class function TCustomGestureEngine.Supported: Boolean;
begin
  Result := False;
end;

{ TCustomGestureCollection }

function TCustomGestureCollection.GetItem(Index: Integer): TCustomGestureCollectionItem;
begin
  Result := TCustomGestureCollectionItem(inherited GetItem(Index));
end;

procedure TCustomGestureCollection.SetItem(Index: Integer; const Value: TCustomGestureCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TCustomGestureManager }

procedure TCustomGestureManager.RemoveActionNotification(Action: TCustomAction;
  Item: TCustomGestureCollectionItem);
begin
  inherited;
end;

{$REGION ' implementation of Caret'}
var
  vKBTimer: TTimer = nil;
  vActiveCaret: TCustomCaret = nil;
  vOldDisplayed: boolean = False;
  vShowVKProc: TShowVirtualKeyboard = nil;

type
  TKBTimer = class(TTimer)
  public
    constructor Create(AOwner: TComponent); override;
    procedure OnTimerProc(sender: TObject);
  end;

procedure RegisterShowVKProc(const ShowVirtualKeyboard: TShowVirtualKeyboard);
var
  VirtualKeyBoardState: TVirtualKeyBoardState;
begin
  if not DelegatesEqual(@vShowVKProc, @ShowVirtualKeyboard) then
  begin
    try
      VirtualKeyBoardState := [];
      try
        if Assigned(vShowVKProc) and
           vOldDisplayed and
           Assigned(vKBTimer) then
          vShowVKProc(False, vActiveCaret, VirtualKeyBoardState);
      finally
        vShowVKProc := nil;
      end;
      vShowVKProc := ShowVirtualKeyboard;
      if Assigned(vShowVKProc) and
         vOldDisplayed and
         Assigned(vKBTimer) then
        vShowVKProc(True, vActiveCaret, VirtualKeyBoardState);
    except
      vOldDisplayed := False;
      Raise;
    end;
  end;
end;


{ TKBTimer }

constructor TKBTimer.Create(AOwner: TComponent);
begin
  inherited;
  Enabled := False;
  Interval := 25;
  OnTimer := OnTimerProc;
end;

procedure TKBTimer.OnTimerProc(sender: TObject);
var
  NewDisplayed: boolean;
  VirtualKeyBoardState: TVirtualKeyBoardState;
begin
  Enabled := False;
  NewDisplayed := Assigned(vActiveCaret) and (vActiveCaret.Displayed);
  try
    if (Assigned(vShowVKProc)) then
    begin
      VirtualKeyBoardState := [];
      if NewDisplayed then
        vShowVKProc(not NewDisplayed, vActiveCaret, VirtualKeyBoardState);
      vShowVKProc(NewDisplayed, vActiveCaret, VirtualKeyBoardState);
    end;
  finally
    vOldDisplayed := NewDisplayed and (vksVisible in VirtualKeyBoardState);
  end;
end;



{$REGION 'global methods for Flasher'}
type
  TRegisteredFlasher = record
    FlasherClass: TFmxObjectClass;
    Name: string;
    Flasher: TFmxObject;
  end;

var
  vFlashers: TList<TRegisteredFlasher> = nil;

  procedure CheckNameFlasher(const CaretClass: TCaretClass; var Name: string);
  begin
    if Assigned(CaretClass) then
      Name := CaretClass.FlasherName
    else
    begin
      Name := '';
      raise EArgumentNilException.Create(SArgumentNil)
    end;
    Name := Trim(Name);
    if Name = '' then
      raise EArgumentException.Create(sArgumentInvalid);
  end;

  function IndexRegisterFlasher(const CaretClass: TCaretClass): integer;
  var
    I: Integer;
    Name: string;
  begin
    Result := -1;
    if Assigned(CaretClass) then
    begin
      Name := Trim(CaretClass.FlasherName);
      if (Name <> '') and (Assigned(vFlashers)) then
      for I := 0 to vFlashers.Count - 1 do
        if SameText(Name, vFlashers[I].Name) then
        begin
          Result := I;
          Break;
        end;
    end;
  end;

  procedure RegisterFlasherClass(const FlasherClass: TFmxObjectClass; const CaretClass: TCaretClass);
  var
    P: PInterfaceEntry;
    Index: integer;
    RegisteredFlasher: TRegisteredFlasher;
    Name: string;
  begin
    CheckNameFlasher(CaretClass, Name);
    if Assigned(FlasherClass) then
    begin
      P := FlasherClass.GetInterfaceEntry(IFlasher);
      if not Assigned(P) then
        raise EArgumentNilException.CreateFMT(SUnsupportedInterface, [FlasherClass.ClassName, 'IFlasher']);
    end;
    if (not Assigned(vFlashers)) and (not Assigned(FlasherClass)) then
      Exit;

    if not Assigned(vFlashers) then
      vFlashers := TList<TRegisteredFlasher>.Create;
    Index := IndexRegisterFlasher(CaretClass);
    if Index = -1 then
    begin
      RegisteredFlasher.Name := Name;
      RegisteredFlasher.FlasherClass := FlasherClass;
      RegisteredFlasher.Flasher := nil;
      vFlashers.Add(RegisteredFlasher);
    end
    else
    begin
      RegisteredFlasher := vFlashers[Index];
      if RegisteredFlasher.FlasherClass <> FlasherClass then
      begin
        FreeAndNil(RegisteredFlasher.Flasher);
        RegisteredFlasher.Name := Name;
        RegisteredFlasher.FlasherClass := FlasherClass;
        if Assigned(RegisteredFlasher.FlasherClass) then
          vFlashers[Index] := RegisteredFlasher
        else
          vFlashers.Delete(Index);
      end;
    end;
  end;

  function FlasherClass(const CaretClass: TCaretClass): TFmxObjectClass;
  var
    Index: Integer;
  begin
    Result := nil;
    Index := IndexRegisterFlasher(CaretClass);
    if Index >= 0 then
      Result := vFlashers[Index].FlasherClass;
  end;

  function AssignedFlasher(const CaretClass: TCaretClass): boolean;
  var
    Index: Integer;
  begin
    Result := False;
    Index := IndexRegisterFlasher(CaretClass);
    if Index >= 0 then
      Result := Assigned(vFlashers[Index].Flasher);
  end;

  function Flasher(const CaretClass: TCaretClass): TFmxObject;
  var
    RegisteredFlasher: TRegisteredFlasher;
    Index: Integer;
    Name: string;
  begin
    CheckNameFlasher(CaretClass, Name);
    Index := IndexRegisterFlasher(CaretClass);
    if Index >= 0 then
    begin
      RegisteredFlasher := vFlashers[Index];
      if not Assigned(RegisteredFlasher.FlasherClass) then
        raise EClassNotFound.Create(SFlasherNotRegistered);
      if not Assigned(RegisteredFlasher.Flasher) then
      begin
        RegisteredFlasher.Flasher := RegisteredFlasher.FlasherClass.Create(nil);
        RegisteredFlasher.Flasher.Name := Name;
        vFlashers[Index] := RegisteredFlasher;
      end;
      Result := vFlashers[Index].Flasher;
    end
    else
      raise EClassNotFound.Create(SFlasherNotRegistered);
  end;

{$ENDREGION}

{ TCustomCaret }

constructor TCustomCaret.Create(const AOwner: TFMXObject);
begin
  if not Assigned(AOwner) then
    raise EArgumentNilException.Create(SArgumentNil);
  inherited Create;
  FOwner := AOwner;
  if FOwner.QueryInterface(IControl, FIControl) <> S_OK then
    raise EArgumentNilException.CreateFMT(SUnsupportedInterface, [FOwner.ClassName, 'IControl']);
end;

destructor TCustomCaret.Destroy;
var
  LClass: TCaretClass;
begin
  LClass := TCaretClass(ClassType);
  if AssignedFlasher(LClass) then
  begin
    if (FMX.Types.Flasher(LClass) as IFlasher).Caret = self then
    begin
      (FMX.Types.Flasher(LClass) as IFlasher).Caret := nil;
      (FMX.Types.Flasher(LClass) as IFlasher).UpdateState;
    end;
  end;
  if vActiveCaret = self then
  begin
    vActiveCaret := nil;
    if Assigned(vKBTimer) then
      vKBTimer.Enabled := True;
  end;
  inherited;
end;

function TCustomCaret.GetFlasher: IFlasher;
var
  LFlasher: TFmxObject;
begin
  Result := nil;
  if (Owner.ComponentState * [csLoading, csDestroying] = []) then
  begin
    LFlasher := FMX.Types.Flasher(TCaretClass(ClassType));
    if Assigned(LFlasher) then
      Result := LFlasher as IFlasher
  end;
end;

function TCustomCaret.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TCustomCaret.GetWidth: Word;
begin
  Result := Trunc(Size.cx);
end;

procedure TCustomCaret.SetWidth(const Value: Word);
var
  LSize: TSizeF;
begin
  if GetWidth <> Value then
  begin
    LSize := Size;
    LSize.cx := Value;
    Size := LSize;
  end;
end;

function TCustomCaret.CanShow: Boolean;
var
  Root: IRoot;
begin
  Result := (FIControl.Visible) and
            (FIControl.Enabled) and
            (FIControl.IsFocused) and
            ([csLoading, csDestroying] * FOwner.ComponentState = []);
  if Result then
  begin
    Root := FOwner.Root;
    if Assigned(Root) and (Root.GetObject is TCommonCustomForm) then
      Result := TCommonCustomForm(Root.GetObject).Active
    else
      Result := False;
  end;
end;

procedure TCustomCaret.DoDisplayChanged(const VirtualKeyBoardState: TVirtualKeyBoardState);
begin
  if Assigned(FOnDisplayChanged) then
    FOnDisplayChanged(self, VirtualKeyBoardState);
end;

procedure TCustomCaret.DoUpdateFlasher;
begin
  //  NewVisible := Visible and Displayed and (not TemporarilyHidden);
  if Assigned(Flasher) then
  begin
    if Displayed then
      Flasher.Caret := self
    else
      Flasher.Caret := nil;
    Flasher.UpdateState;
  end;
end;

procedure TCustomCaret.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    if FVisible then
      Show
    else
      Hide;
  end;
end;

procedure TCustomCaret.StartTimer;
begin
  if not Assigned(vKBTimer) then
    vKBTimer := TKBTimer.Create(nil);
  if Assigned(vKBTimer) then
    vKBTimer.Enabled := True;
end;

procedure TCustomCaret.Show;
var
  VirtualKeyBoardState: TVirtualKeyBoardState;
  LVisible: Boolean;
  LFlasherClass: TFmxObjectClass;
begin
  LVisible := FVisible and CanShow;
  if LVisible then
  begin
    if Assigned(vActiveCaret) and (vActiveCaret <> self) then
      vActiveCaret.Hide;
    try
      LFlasherClass := FlasherClass(TCaretClass(ClassType));
      if Assigned(LFlasherClass) and Assigned(Flasher) and (not Displayed) then
      begin
        StartTimer;
        FDisplayed := True;
        try
          DoUpdateFlasher;
        finally
          FChanged := False;
          DoDisplayChanged(VirtualKeyBoardState);
        end;
      end;
      if Displayed then
        vActiveCaret := self;
    except
      FVisible := False;
      Raise;
    end;
  end;
end;

procedure TCustomCaret.Hide;
var
  VirtualKeyBoardState: TVirtualKeyBoardState;
begin
  try
    if Displayed then
    begin
      try
        if Assigned(vKBTimer) then
          vKBTimer.Enabled := True;
      finally
        FDisplayed := False;
        try
          DoUpdateFlasher;
        finally
          FChanged := False;
          DoDisplayChanged(VirtualKeyBoardState);
        end;
      end;
    end;
  finally
    if vActiveCaret = self then
      vActiveCaret := nil;
  end;
end;

procedure TCustomCaret.SetTemporarilyHidden(const Value: boolean);
begin
  if FTemporarilyHidden <> Value then
  begin
    FTemporarilyHidden := Value;
    if Displayed then UpdateFlasher;
  end;
end;

procedure TCustomCaret.UpdateFlasher;
begin
  if (FUpdateCount <= 0) then
  begin
    try
      DoUpdateFlasher;
    finally
      FChanged := False;
    end;
  end
  else
    FChanged := True;
end;

procedure TCustomCaret.SetColor(const Value: TAlphaColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    if Displayed then UpdateFlasher;
  end;
end;

procedure TCustomCaret.SetDefaultColor(const Value: TAlphaColor);
begin
  if FDefaultColor <> Value then
  begin
    FDefaultColor := Value;
    if Displayed then UpdateFlasher;
  end;
end;

procedure TCustomCaret.SetInterval(const Value: TFlasherInterval);
begin
  if FInterval <> Value then
  begin
    FInterval := Value;
    if Displayed then UpdateFlasher;
  end;
end;

procedure TCustomCaret.SetPos(const Value: TPointF);
begin
  if not (Value = FPos) then
  begin
    FPos := Value;
    if Displayed then UpdateFlasher;
  end;
end;

procedure TCustomCaret.SetReadOnly(const Value: boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    if Displayed then UpdateFlasher;
    StartTimer;
  end;
end;

procedure TCustomCaret.SetSize(const Value: TSizeF);
begin
  if not (Value = FSize) then
  begin
    FSize := Value;
    if Displayed then UpdateFlasher;
  end;
end;

procedure TCustomCaret.Assign(Source: TPersistent);
begin
  if not Assigned(Source) or (Source is TCustomCaret) then
  begin
    BeginUpdate;
    try
      if Assigned(Source) then
      begin
        Size := TCustomCaret(Source).Size;
        Color := TCustomCaret(Source).Color;
        Interval := TCustomCaret(Source).Interval;
      end
      else
      begin
        Size := PointF(0, 0);
        Color := TAlphaColorRec.Null;
        Interval := 0;
      end;
    finally
      EndUpdate;
    end;
  end
  else
    inherited;
end;

procedure TCustomCaret.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TCustomCaret.EndUpdate;
begin
  if FUpdateCount > 0 then
  begin
    Dec(FUpdateCount);
    if (FUpdateCount = 0) and (FChanged) then
    try
      DoUpdateFlasher;
    finally
      FChanged := False;
    end;
  end;
end;
{$ENDREGION}



{ Initialization and finalization }

procedure FreeCloneCache;
var
  List: TList<TRttiProperty>;
begin
  for List in ClonePropertiesCache.Values do
    List.DisposeOf;
  for List in ClonePersistentCache.Values do
    List.DisposeOf;

  FreeAndNil(ClonePropertiesCache);
  FreeAndNil(ClonePersistentCache);
  SharedContext.Free;
end;

procedure FreeFmxGlobals;
var
  I: integer;
  List: TFmxObjectList;
begin
  FreeAndNil(AniThread);
  if Assigned(ResourceDict) then
  begin
    for List in ResourceDict.Values do
      List.DisposeOf;
    FreeAndNil(ResourceDict);
  end;


  FreeAndNil(CollectLang);
  FreeAndNil(Lang);
  FreeCloneCache;
  FreeAndNil(vKBTimer);
  if Assigned(vFlashers) then
  begin
    for I := vFlashers.Count - 1 downto 0 do
    try
      vFlashers[I].Flasher.DisposeOf;
      vFlashers.Delete(I);
    except
      Continue;
    end;
    FreeAndNil(vFlashers);
  end;
end;

{$IFDEF TEXTDEBUG}
{$IFDEF TEXTDEBUGX}
type
  TTextControlToString = class helper for TObject
  public
    function ToString : String;
  end;

function TTextControlToString.ToString : String;
begin
  Result := ClassName;
  if Self is TFmxObject then
  begin
    if TFmxObject(Self).Name <> EmptyStr then
      Result := Result + ' "' + TFmxObject(Self).Name + '"';

    if Self is TTextControl then
      Result := Result + '="' + TTextControl(Self).Text + '"';

    if Self is TContent then
      Result := Format('%s (%d)', [Result, TContent(Self).ChildrenCount]);;

    if Self is TControl then
      Result := Format('%s {%s} ', [Result, Log.ArrayToString(TControl(Self).Controls)]);

  end;
end;
{$ENDIF}
{$ENDIF}

{ Log }
class procedure Log.d(const Tag: String; const Instance : TObject; const Msg: String);
begin
  Log.d(Tag, Instance, String.Empty, Msg);
end;

class function Log.ArrayToString(const AArray: TEnumerable<TFmxObject>): String;
begin
  Result := ArrayToString(AArray, function(O : TObject):String begin Exit(O.ToString) end);
end;

class function Log.ArrayToString(const AArray: TEnumerable<TFmxObject>;
  MakeStr: ToStringFunc): String;
const
  Delimiter : array [Boolean] of String = ('', ',');
var
  O : TFmxObject;
begin
  Result := EmptyStr;
  for O in AArray do
  begin
    Result := Result + Format('%s%s', [Delimiter[Length(Result)>0], MakeStr(O)]);
  end;
  Result := '[' + Result + ']';
end;

class constructor Log.Create;
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXLoggingService, FLogger);
end;

class procedure Log.d(const Fmt: String; const Args: array of const);
begin
  if Assigned(FLogger) then
    (FLogger as IFMXLoggingService).Log(Fmt, Args);
end;

class procedure Log.d(const Msg: String);
begin
  if Assigned(FLogger) then
    (FLogger as IFMXLoggingService).Log(Msg, []);
end;

class procedure Log.TimeStamp(const Msg: String);
var
  H, M, S, MS: Word;
begin
  DecodeTime(Time, H, M, S, MS);
  if Assigned(FLogger) then
    (FLogger as IFMXLoggingService).Log('%d:%d:%d %s', [M, S, MS, Msg]);
end;

{class function Log.ArrayToString(AArray: TEnumerable<TControl>): String;
var
  R : TList<TFmxObject>;
  O : TFmxObject;
begin
  if AArray = nil then
    Exit('[nil]');
  R := TList<TFmxObject>.Create;
  for O in AArray do
    R.Add(O);
  Result := ArrayToString(R);
  R.Free;
end; }

class procedure Log.d(const Tag: String; const Instance : TObject; const Method, Msg: String);
begin
{$IFDEF TEXTDEBUG}
  if not Assigned(FLogger) then
    Exit;
  try
    if Length(Method) > 0 then
      (FLogger as IFMXLoggingService).Log('%s (%s.%s): %s', [Tag, Log.ObjToString(Instance), Method, Msg])
    else
      (FLogger as IFMXLoggingService).Log('%s (%s): %s', [Tag, Log.ObjToString(Instance), Msg]);
  except
    on E : Exception do;
  end;
{$ENDIF}
end;

class procedure Log.DumpFmxObject(const O: TFmxObject; Nest: Integer = 0);
{$IFDEF TEXTDEBUG}
var
  I : Integer;
  Child : TObject;
begin
  for I := 0 to Nest-1 do
    Write(' ');
  WriteLn(O.ToString);
  if O.Children = nil then Exit;
  for Child in O.Children do
  begin
    if Child is TFmxObject then
      DumpFmxObject(TFmxObject(Child), Nest + 2);
  end;
end;
{$ELSE}
begin
end;
{$ENDIF}

class function Log.ObjToString(const Instance : TObject): String;
var
  ClassName : String;
  Addr : NativeInt;
begin
  ClassName := EmptyStr;
  if Instance <> nil then
  begin
    ClassName := Instance.ClassName;
    Addr := NativeInt(Instance);
  end
  else
    Addr := NativeInt(Instance);
  if Addr = 0 then
    Result := 'Nil'
  else
{$IFDEF AUTOREFCOUNT}
    Result := Format('%s@%8x(%d)', [ClassName, Addr, Instance.RefCount]);
{$ELSE}
    Result := Format('%s@%8x)', [ClassName, Addr]);
{$ENDIF}
end;

procedure RegisterShortCuts;
  procedure RegisterAlpha(Shift: Word);
  var S: TShortCut;
  begin
    for S := Byte('A') to Byte('Z') do
    begin
      RegisterShortCut(S + Shift)
    end;
  end;
  procedure RegisterF(Shift: Word);
  var S: TShortCut;
  begin
    for S := vkF1 to vkF12 do
    begin
      RegisterShortCut(S + Shift)
    end;
  end;
  procedure RegisterOther(Shift: Word);
  const OtherKeys: array [0..3] of TShortCut = (vkInsert, vkDelete, vkReturn, vkEscape);
  var I: integer;
  begin
    for I := Low(OtherKeys) to High(OtherKeys) do
    begin
      RegisterShortCut(OtherKeys[I] + Shift);
    end;
  end;
begin
  RegisterAlpha(scCtrl);
  RegisterAlpha(scCtrl or scAlt);
  RegisterAlpha(scCommand);
  RegisterAlpha(scCtrl or scCommand);
  RegisterAlpha(scShift or scCommand);
  RegisterAlpha(scAlt or scCommand);


  RegisterF(0);
  RegisterF(scCtrl);
  RegisterF(scShift);
  RegisterF(scAlt);
  RegisterF(scShift or scCtrl);
  RegisterF(scCommand);
  RegisterF(scCtrl or scCommand);
  RegisterF(scShift or scCommand);

  RegisterOther(scShift);
  RegisterOther(scCtrl);
  RegisterOther(scAlt);
  RegisterOther(scCommand);

  RegisterShortCut(vkBack or scAlt);
  RegisterShortCut(vkBack or scShift or scAlt);
end;

procedure TFmxObject.IgnoreIntegerValue(Reader: TReader);
begin
  Reader.ReadInteger;
end;

{ TEnumerationFilter<T> }

constructor TEnumerableFilter<F, T>.Create(const FullEnum: TEnumerable<F>;
  SelfDestruct: Boolean);
begin
  FBaseEnum := FullEnum;
  FSelfDestruct := SelfDestruct;
end;

function TEnumerableFilter<F,T>.DoGetEnumerator: TEnumerator<T>;
begin
  if FSelfDestruct then
    Result := TFilterEnumerator.Create(FBaseEnum, Self)
  else
    Result := TFilterEnumerator.Create(FBaseEnum, nil);
end;

class function TEnumerableFilter<F, T>.Filter(
  const Src: TEnumerable<F>): TEnumerableFilter<F, T>;
begin
  Result := TEnumerableFilter<F,T>.Create(Src, True);
end;

constructor TEnumerableFilter<F, T>.TFilterEnumerator.Create(
  const Enumerable: TEnumerable<F>; const Cleanup: TEnumerableFilter<F, T>);
begin
  FRawEnumerator := Enumerable.GetEnumerator;
  FCleanup := Cleanup;
end;

destructor TEnumerableFilter<F,T>.TFilterEnumerator.Destroy;
begin
  FRawEnumerator.Free;
  inherited;
  if Assigned(FCleanup) then
    FCleanup.Free;
end;

function TEnumerableFilter<F,T>.TFilterEnumerator.DoGetCurrent: T;
begin
  Result := GetCurrent;
end;

function TEnumerableFilter<F,T>.TFilterEnumerator.DoMoveNext: Boolean;
begin
  Result := MoveNext;
end;

function TEnumerableFilter<F,T>.TFilterEnumerator.GetCurrent: T;
begin
  Result := FCurrent;
end;

function TEnumerableFilter<F,T>.TFilterEnumerator.MoveNext: Boolean;
begin
  Result := False;
  while (not Result) and (FRawEnumerator.MoveNext) do
    if FRawEnumerator.Current is T then
    begin
      FCurrent := FRawEnumerator.Current as T;
      Result := Assigned(FCurrent);
    end;
end;

{ TFmxChildrenList }

constructor TFmxChildrenList.Create(const AChildren: TFmxObjectList);
begin
  inherited Create;
  FChildren := AChildren;
end;

destructor TFmxChildrenList.Destroy;
begin
  FChildren := nil;
  inherited;
end;

function TFmxChildrenList.DoGetEnumerator: TEnumerator<TFmxObject>;
begin
  Result := FChildren.GetEnumerator;
end;

function TFmxChildrenList.GetChild(AIndex: Integer): TFmxObject;
begin
  Result := FChildren[AIndex];
end;

function TFmxChildrenList.GetChildCount: Integer;
begin
  if Assigned(FChildren) then
    Result := FChildren.Count
  else
    Result := 0;
end;

function TFmxChildrenList.IndexOf(const Obj: TFmxObject): Integer;
begin
  if Assigned(FChildren) then
    Result := FChildren.IndexOf(Obj)
  else
    Result := -1
end;

{ TColorObject }

procedure TColorObject.SetName(const NewName: TComponentName);
begin
  inherited;
  if FStyleName = '' then
    FStyleName := Name;
end;

initialization
  vPurgatory := TPurgatory.Create(nil);
  ClonePropertiesCache := TDictionary<string , TList<TRttiProperty>>.Create;
  ClonePersistentCache := TDictionary<string , TList<TRttiProperty>>.Create;
  SharedContext := TRttiContext.Create;
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);
  GroupDescendentsWith(TCustomActionList, TFmxObject);
  GroupDescendentsWith(TCustomAction, TFmxObject);
  GroupDescendentsWith(TCustomGestureManager, TFmxObject);

  RegisterFmxClasses([TBitmap, TPathData, TBrush, TBounds, TPosition, TGradient,
    TGradientPoints, TGradientPoint, TFmxObject,
    TBrushObject, TFontObject, TPathObject, TBitmapObject, TColorObject, TTimer],
    [TBitmap, TPathData, TBounds, TPosition, TGradient, TBrush,
    TGradientPoints, TGradientPoint]);

  RegisterAlphaColorIntegerConsts;
  RegisterCursorIntegerConsts;
  RegisterShortCuts;

  USFormatSettings := TFormatSettings.Create('en-us');
finalization
  FreeFmxGlobals;
  FreeAndNil(vPurgatory);

end.
