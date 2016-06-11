{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Types;

{$DEFINE STYLERESOURCECACHE}

{$MINENUMSIZE 4}
{$H+}

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Types, System.UITypes, System.Math, System.Math.Vectors, System.SysUtils, System.Rtti,
  System.Generics.Collections, System.Messaging, FMX.ActnList;

const
{$HPPEMIT '#define FireMonkeyVersion 240'}
  FireMonkeyVersion = 240;
{$EXTERNALSYM FireMonkeyVersion}

{ Global Settings }

var
  GlobalUseHWEffects: Boolean = True deprecated;
  // On low-end hardware or mobile bitmap effects are slowly
  GlobalDisableFocusEffect: Boolean = False;
  // Allow using Direct3D for UI and 3D rendering
  GlobalUseDX: Boolean = True;
  // Force using legacy DX9 feature level in Direct3D
  GlobalUseDXInDX9Mode: Boolean = False;
  // Give higher priority to Direct3D WARP device instead of hardware layer
  GlobalUseDXSoftware: Boolean = False;
  // Allow using Direct2D for UI rendering
  GlobalUseDirect2D: Boolean = True;
  // Use ClearType rendering in GDI+ renderer
  GlobalUseGDIPlusClearType: Boolean = True;
  /// <summary>The number of decimal digits for the rounding floating point
  /// values.</summary>
  DigitRoundSize: TRoundToRange = -3;
  // Use GPU Canvas
  GlobalUseGPUCanvas: Boolean = False;

  GlobalUseDX10: Boolean = True deprecated 'Use GlobalUseDX.';
  GlobalUseDX10Software: Boolean = True deprecated 'Use GlobalUseDXSoftware.';

type
  TVKAutoShowMode = (DefinedBySystem, Never, Always);

  TVKAutoShowModeHelper = record helper for TVKAutoShowMode
  const
    vkasDefinedBySystem = TVKAutoShowMode.DefinedBySystem deprecated 'Use TVKAutoShowMode.DefinedBySystem';
    vkasNever = TVKAutoShowMode.Never deprecated 'Use TVKAutoShowMode.Never';
    vkasAlways = TVKAutoShowMode.Always deprecated 'Use TVKAutoShowMode.Always';
  end;

var
  VKAutoShowMode: TVKAutoShowMode = TVKAutoShowMode.DefinedBySystem;

type

  TOSPlatform = (Windows, OSX, iOS, Android);

  TPointArray = array [0..0] of TPointF;

  TLongByteArray = array [0..MaxInt - 1] of Byte;
  PLongByteArray = ^TLongByteArray;

                                                             
  TCorner = (TopLeft, TopRight, BottomLeft, BottomRight);

  TCornerHelper = record helper for TCorner
  const
    crTopLeft = TCorner.TopLeft deprecated 'Use TCorner.TopLeft';
    crTopRight = TCorner.TopRight deprecated 'Use TCorner.TopRight';
    crBottomLeft = TCorner.BottomLeft deprecated 'Use TCorner.BottomLeft';
    crBottomRight = TCorner.BottomRight deprecated 'Use TCorner.BottomRight';
  end;

  TCorners = set of TCorner;

  TCornerType = (Round, Bevel, InnerRound, InnerLine);

  TCornerTypeHelper = record helper for TCornerType
  const
    ctRound = TCornerType.Round deprecated 'Use TCornerType.Round';
    ctBevel = TCornerType.Bevel deprecated 'Use TCornerType.Bevel';
    ctInnerRound = TCornerType.InnerRound deprecated 'Use TCornerType.InnerRound';
    ctInnerLine = TCornerType.InnerLine deprecated 'Use TCornerType.InnerLine';
  end;

  { Four courners describing arbitrary 2D rectangle }
  PCornersF = ^TCornersF;
  TCornersF = array [0 .. 3] of TPointF;

  TSide = (Top, Left, Bottom, Right);

  TSideHelper = record helper for TSide
  const
    sdTop = TSide.Top deprecated 'Use TSide.Top';
    sdLeft = TSide.Left deprecated 'Use TSide.Left';
    sdBottom = TSide.Bottom deprecated 'Use TSide.Bottom';
    sdRight = TSide.Right deprecated 'Use TSide.Right';
  end;

  TSides = set of TSide;

  TTextAlign = (Center, Leading, Trailing);

  TTextAlignHelper = record helper for TTextAlign
  const
    taCenter = TTextAlign.Center deprecated 'Use TTextAlign.Center';
    taLeading = TTextAlign.Leading deprecated 'Use TTextAlign.Leading';
    taTrailing = TTextAlign.Trailing deprecated 'Use TTextAlign.Trailing';
  public
    /// <summary> This method converts <b>TTextAlign</b> value to <b>THorzRectAlign</b> </summary>
    function AsHorzRectAlign: THorzRectAlign; inline;
    /// <summary> This method converts <b>TTextAlign</b> value to <b>TVertRectAlign</b> </summary>
    function AsVertRectAlign: TVertRectAlign; inline;
  end;

  TVertRectAlignHelper = record helper for TVertRectAlign
  public
    /// <summary> This method converts <b>TVertRectAlign</b> value to <b>TTextAlign</b> </summary>
    function AsTextAlign: TTextAlign; inline;
  end;

  THorzRectAlignHelper = record helper for THorzRectAlign
  public
    /// <summary> This method converts <b>THorzRectAlign</b> value to <b>TTextAlign</b> </summary>
    function AsTextAlign: TTextAlign; inline;
  end;

  TTextTrimming = (None, Character, Word);
  /// <summary>A type that text controls use to specify whether to consider the
  /// ampersand (&amp;) as a special character</summary>
  TPrefixStyle = (HidePrefix, NoPrefix);

  TTextTrimmingHelper = record helper for TTextTrimming
  const
    ttNone = TTextTrimming.None deprecated 'Use TTextTrimming.None';
    ttCharacter = TTextTrimming.Character deprecated 'Use TTextTrimming.Character';
    ttWord = TTextTrimming.Word deprecated 'Use TTextTrimming.Word';
  end;
  TStyledSetting = (Family, Size, Style, FontColor, Other);

  TStyledSettingHelper = record helper for TStyledSetting
  const
    ssFamily = TStyledSetting.Family deprecated 'Use TStyledSetting.Family';
    ssSize = TStyledSetting.Size deprecated 'Use TStyledSetting.Size';
    ssStyle = TStyledSetting.Style deprecated 'Use TStyledSetting.Style';
    ssFontColor = TStyledSetting.FontColor deprecated 'Use TStyledSetting.FontColor';
    ssOther = TStyledSetting.Other deprecated 'Use TStyledSetting.Other';
  end;
  TStyledSettings = set of TStyledSetting;

  TMenuItemChange = (Enabled, Visible, Text, Shortcut, Checked, Bitmap);

  TMenuItemChangeHelper = record helper for TMenuItemChange
  const
    mcEnabled = TMenuItemChange.Enabled deprecated 'Use TMenuItemChange.Enabled';
    mcVisible = TMenuItemChange.Visible deprecated 'Use TMenuItemChange.Visible';
    mcText = TMenuItemChange.Text deprecated 'Use TMenuItemChange.Text';
    mcShortcut = TMenuItemChange.Shortcut deprecated 'Use TMenuItemChange.Shortcut';
    mcChecked = TMenuItemChange.Checked deprecated 'Use TMenuItemChange.Checked';
    mcBitmap = TMenuItemChange.Bitmap deprecated 'Use TMenuItemChange.Bitmap';
  end;
  TMenuItemChanges = set of TMenuItemChange;

  TScreenOrientation = (Portrait, Landscape, InvertedPortrait, InvertedLandscape);

  TScreenOrientationHelper = record helper for TScreenOrientation
  const
    soPortrait = TScreenOrientation.Portrait deprecated 'Use TScreenOrientation.Portrait';
    soLandscape = TScreenOrientation.Landscape deprecated 'Use TScreenOrientation.Landscape';
    soInvertedPortrait = TScreenOrientation.InvertedPortrait deprecated 'Use TScreenOrientation.InvertedPortrait';
    soInvertedLandscape = TScreenOrientation.InvertedLandscape deprecated 'Use TScreenOrientation.InvertedLandscape';
  end;
  TScreenOrientations = set of TScreenOrientation;

  TPixelFormat = (None, RGB, RGBA, BGR, BGRA, RGBA16, BGR_565, BGRA4, BGR4, BGR5_A1, BGR5, BGR10_A2, RGB10_A2, L, LA,
    LA4, L16, A, R16F, RG16F, RGBA16F, R32F, RG32F, RGBA32F);

  TPixelFormatList = TList<TPixelFormat>;

const
  PixelFormatBytes: array[TPixelFormat] of Integer = ({ None } 0, { RGB } 4, { RGBA } 4, { BGR } 4, { BGRA } 4,
    { RGBA16 } 8, { BGR_565 } 2, { BGRA4 } 2, { BGR4 } 2, { BGR5_A1 } 2, { BGR5 } 2, { BGR10_A2 } 4, { RGB10_A2 } 4,
    { L } 1, { LA } 2, { LA4 } 1, { L16 } 2, { A } 1, { R16F } 2, { RG16F } 4, { RGBA16F } 8, { R32F } 4, { RG32F } 8,
    { RGBA32F } 16);

  NullRect: TRectF = (Left: 0; Top: 0; Right: 0; Bottom: 0);

  AllCorners: TCorners = [TCorner.TopLeft, TCorner.TopRight,
    TCorner.BottomLeft, TCorner.BottomRight];

  AllSides: TSides = [TSide.Top, TSide.Left, TSide.Bottom, TSide.Right];

  ClosePolygon: TPointF = (X: $FFFF; Y: $FFFF) deprecated 'Non-closed polygons are not supported.';

  /// <summary>A special polygon point marker typically used for converting paths to polygons and vice-versa,
  /// usually indicating path closure. For the rendering methods, this marker has no meaning and the actual
  /// interpretation may be platform-dependent.</summary>
  PolygonPointBreak: TPointF = (X: $FFFFFF; Y: $FFFFFF);

  AllStyledSettings: TStyledSettings = [TStyledSetting.Family,
                                        TStyledSetting.Size,
                                        TStyledSetting.Style,
                                        TStyledSetting.FontColor,
                                        TStyledSetting.Other];
  DefaultStyledSettings: TStyledSettings = [TStyledSetting.Family,
                                            TStyledSetting.Size,
                                            TStyledSetting.Style,
                                            TStyledSetting.FontColor];

  InvalidSize : TSizeF = (cx: -1; cy: -1);

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

  TTouch = record
    Location: TPointF;
  end;
  TTouches = array of TTouch;

  TTouchAction = (None, Up, Down, Move, Cancel);
  TTouchActions = set of TTouchAction;

type
  TFormStyle = (Normal, Popup, StayOnTop);

  TFormStyleHelper = record helper for TFormStyle
  const
    fsNormal = TFormStyle.Normal deprecated 'Use TFormStyle.Normal';
    fsPopup = TFormStyle.Popup deprecated 'Use TFormStyle.Popup';
    fsStayOnTop = TFormStyle.StayOnTop deprecated 'Use TFormStyle.StayOnTop';
  end;

  TAlignLayout = (None, Top, Left, Right, Bottom, MostTop, MostBottom, MostLeft, MostRight, Client, Contents, Center, VertCenter, HorzCenter, Horizontal, Vertical, Scale, Fit, FitLeft, FitRight);

  TAlignLayoutHelper = record helper for TAlignLayout
  const
    alNone = TAlignLayout.None deprecated 'Use TAlignLayout.None';
    alTop = TAlignLayout.Top deprecated 'Use TAlignLayout.Top';
    alLeft = TAlignLayout.Left deprecated 'Use TAlignLayout.Left';
    alRight = TAlignLayout.Right deprecated 'Use TAlignLayout.Right';
    alBottom = TAlignLayout.Bottom deprecated 'Use TAlignLayout.Bottom';
    alMostTop = TAlignLayout.MostTop deprecated 'Use TAlignLayout.MostTop';
    alMostBottom = TAlignLayout.MostBottom deprecated 'Use TAlignLayout.MostBottom';
    alMostLeft = TAlignLayout.MostLeft deprecated 'Use TAlignLayout.MostLeft';
    alMostRight = TAlignLayout.MostRight deprecated 'Use TAlignLayout.MostRight';
    alClient = TAlignLayout.Client deprecated 'Use TAlignLayout.Client';
    alContents = TAlignLayout.Contents deprecated 'Use TAlignLayout.Contents';
    alCenter = TAlignLayout.Center deprecated 'Use TAlignLayout.Center';
    alVertCenter = TAlignLayout.VertCenter deprecated 'Use TAlignLayout.VertCenter';
    alHorzCenter = TAlignLayout.HorzCenter deprecated 'Use TAlignLayout.HorzCenter';
    alHorizontal = TAlignLayout.Horizontal deprecated 'Use TAlignLayout.Horizontal';
    alVertical = TAlignLayout.Vertical deprecated 'Use TAlignLayout.Vertical';
    alScale = TAlignLayout.Scale deprecated 'Use TAlignLayout.Scale';
    alFit = TAlignLayout.Fit deprecated 'Use TAlignLayout.Fit';
    alFitLeft = TAlignLayout.FitLeft deprecated 'Use TAlignLayout.FitLeft';
    alFitRight = TAlignLayout.FitRight deprecated 'Use TAlignLayout.FitRight';
  end;

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

  TDragOperation = (None, Move, Copy, Link);

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

  TFmxObject = class;
  TFmxObjectClass = class of TFmxObject;
  TBounds = class;
  TLineMetricInfo = class;
  TTouchManager = class;
  TCustomPopupMenu = class;

  TWindowHandle = class
  protected
    /// <summary>Return window scale factor usually overrided in descendants</summary>
    function GetScale: Single; virtual;
  public
    /// <summary>Return True is Scale is integer value</summary>
    function IsScaleInteger: Boolean;
    /// <summary>Window scale factor</summary>
    property Scale: Single read GetScale;
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

  IObjectState = interface
    ['{0402E1A6-1F75-4D28-BFEA-8092803B00EE}']
    function SaveState: Boolean;
    function RestoreState: Boolean;
  end;

  IContent = interface
    ['{96E89B94-2AD6-4AD3-A07C-92E66B2E6BC8}']
    function GetParent: TFmxObject;
    function GetObject: TFmxObject;
    function GetChildrenCount: Integer;
    property Parent: TFmxObject read GetParent;
    property ChildrenCount: Integer read GetChildrenCount;
    procedure Changed;
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

  ITabStopController = interface;

  IControl = interface(IFreeNotificationBehavior)
    ['{7318D022-D048-49DE-BF55-C5C36A2AD1AC}']
    function GetObject: TFmxObject;
    procedure SetFocus;
    function GetIsFocused: Boolean;
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
    function ShowContextMenu(const ScreenPosition: TPointF): Boolean;
    function ScreenToLocal(P: TPointF): TPointF;
    function LocalToScreen(P: TPointF): TPointF;
    function ObjectAtPoint(P: TPointF): IControl;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure MouseMove(Shift: TShiftState; X, Y: Single);
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure MouseClick(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure KeyUp(var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure Tap(const Point: TPointF);
    procedure DialogKey(var Key: Word; Shift: TShiftState);
    procedure AfterDialogKey(var Key: Word; Shift: TShiftState);
    function FindTarget(P: TPointF; const Data: TDragObject): IControl;
    procedure DragEnter(const Data: TDragObject; const Point: TPointF);
    procedure DragOver(const Data: TDragObject; const Point: TPointF; var Operation: TDragOperation);
    procedure DragDrop(const Data: TDragObject; const Point: TPointF);
    procedure DragLeave;
    procedure DragEnd;
    function CheckForAllowFocus: Boolean;
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
    function GetTabStopController: ITabStopController;
    function GetTabStop: Boolean;
    procedure SetTabStop(const TabStop: Boolean);
    /// <summary>This method returns true if the control has an available hint to display.</summary>
    function HasHint: Boolean;
    /// <summary>If HasHint is true, this method is invoked in order to know if the control has an available 
    /// string to swho as hint.</summary>
    function GetHintString: string;
    /// <summary>If HasHint is true, this method is invoked in order to know if the control has a custom hint 
    /// object to manage the hint display. This usually returns an instance of THint to allow the form to manage
    /// it.</summary>
    function GetHintObject: TObject;
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
    property IsFocused: Boolean read GetIsFocused;
    property TabStop: Boolean read GetTabStop write SetTabStop;
  end;

  /// <summary> This interface is used to acces to property <b>ReadOnly</b> of all classes which supports this property
  /// </summary>
  IReadOnly = interface
    ['{495B8B0C-D7C8-4835-AA5F-580939D21444}']
    function GetReadOnly: Boolean;
    procedure SetReadOnly(const Value: Boolean);
    /// <summary> The property to which we have access </summary>
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
  end;

  IRoot = interface
    ['{7F7BB7B0-5932-49dd-9D35-712B2BA5D8EF}']
    procedure AddObject(const AObject: TFmxObject);
    procedure InsertObject(Index: Integer; const AObject: TFmxObject);
    procedure RemoveObject(const AObject: TFmxObject); overload;
    procedure RemoveObject(Index: Integer); overload;
    procedure BeginInternalDrag(const Source: TObject; const ABitmap: TObject);
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

  TVirtualKeyboardType = (Default, NumbersAndPunctuation, NumberPad, PhonePad, Alphabet, URL, NamePhonePad, EmailAddress);

  TVirtualKeyboardTypeHelper = record helper for TVirtualKeyboardType
  const
    vktDefault = TVirtualKeyboardType.Default deprecated 'Use TVirtualKeyboardType.Default';
    vktNumbersAndPunctuation = TVirtualKeyboardType.NumbersAndPunctuation deprecated 'Use TVirtualKeyboardType.NumbersAndPunctuation';
    vktNumberPad = TVirtualKeyboardType.NumberPad deprecated 'Use TVirtualKeyboardType.NumberPad';
    vktPhonePad = TVirtualKeyboardType.PhonePad deprecated 'Use TVirtualKeyboardType.PhonePad';
    vktAlphabet = TVirtualKeyboardType.Alphabet deprecated 'Use TVirtualKeyboardType.Alphabet';
    vktURL = TVirtualKeyboardType.URL deprecated 'Use TVirtualKeyboardType.URL';
    vktNamePhonePad = TVirtualKeyboardType.NamePhonePad deprecated 'Use TVirtualKeyboardType.NamePhonePad';
    vktEmailAddress = TVirtualKeyboardType.EmailAddress deprecated 'Use TVirtualKeyboardType.EmailAddress';
  end;

  TVirtualKeyboardState = (AutoShow, Visible, Error, Transient);

  TVirtualKeyboardStateHelper = record helper for TVirtualKeyboardState
  const
    vksAutoShow = TVirtualKeyboardState.AutoShow deprecated 'Use TVirtualKeyboardState.AutoShow';
    vksVisible = TVirtualKeyboardState.Visible deprecated 'Use TVirtualKeyboardState.Visible';
    vksError = TVirtualKeyboardState.Error deprecated 'Use TVirtualKeyboardState.Error';
    vksTransient = TVirtualKeyboardState.Transient deprecated 'Use TVirtualKeyboardState.Transient';
  end;

  TVirtualKeyboardStates = set of TVirtualKeyboardState;

  TReturnKeyType = (Default, Done, Go, Next, Search, Send);

  TReturnKeyTypeHelper = record helper for TReturnKeyType
  const
    rktDefault = TReturnKeyType.Default deprecated 'Use TReturnKeyType.Default';
    rktDone = TReturnKeyType.Done deprecated 'Use TReturnKeyType.Done';
    rktGo = TReturnKeyType.Go deprecated 'Use TReturnKeyType.Go';
    rktNext = TReturnKeyType.Next deprecated 'Use TReturnKeyType.Next';
    rktSearch = TReturnKeyType.Search deprecated 'Use TReturnKeyType.Search';
    rktSend = TReturnKeyType.Send deprecated 'Use TReturnKeyType.Send';
  end;

  IVirtualKeyboardControl = interface
    ['{41127080-97FC-4C30-A880-AB6CD351A6C4}']
    procedure SetKeyboardType(Value: TVirtualKeyboardType);
    function GetKeyboardType: TVirtualKeyboardType;
    property KeyboardType: TVirtualKeyboardType read GetKeyboardType write SetKeyboardType;
    //
    procedure SetReturnKeyType(Value: TReturnKeyType);
    function GetReturnKeyType: TReturnKeyType;
    property ReturnKeyType: TReturnKeyType read GetReturnKeyType write SetReturnKeyType;
    //
    function IsPassword: Boolean;
  end;

  TAdjustType = (None, FixedSize, FixedWidth, FixedHeight);

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

    function GetAdjustType: TAdjustType;
    function GetAdjustSizeValue: TSizeF;
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

    property AdjustType: TAdjustType read GetAdjustType;
    property AdjustSizeValue: TSizeF read GetAdjustSizeValue;
  end;

  IItemsContainer = interface
    ['{100B2F87-5DCB-4699-B751-B4439588E82A}']
    function GetItemsCount: Integer;
    function GetItem(const AIndex: Integer): TFmxObject;
    function GetObject: TFmxObject;
  end;

  IPurgatoryItem = interface
    ['{44D32F6F-0666-4A4D-9CCE-61ACA319EB05}']
    function CanDispose: Boolean;
  end;


  ITabList = interface
    ['{80C67BA2-3064-4d90-A8E1-B00028CA670E}']
    procedure Add(const TabStop: IControl);
    procedure Remove(const TabStop: IControl);
    procedure Update(const TabStop: IControl; const NewValue: TTabOrder);
    function GetTabOrder(const TabStop: IControl): TTabOrder;
    function GetCount: Integer;
    function GetItem(const Index: Integer): IControl;
    function FindNextTabStop(const Current: IControl; const MoveForward: Boolean; const Climb: Boolean): IControl;
    property Count: Integer read GetCount;
  end;

  ITabStopController = interface
    ['{E7D2E0C5-EA3B-40bd-B728-5E4BB264EFC1}']
    function GetTabList: ITabList;
    property TabList: ITabList read GetTabList;
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
  TDragOverEvent = procedure(Sender: TObject; const Data: TDragObject; const Point: TPointF;
    var Operation: TDragOperation) of object;
  TDragDropEvent = procedure(Sender: TObject; const Data: TDragObject; const Point: TPointF) of object;
  TCanFocusEvent = procedure(Sender: TObject; var ACanFocus: Boolean) of object;

  PDeviceDisplayMetrics = ^TDeviceDisplayMetrics;
  TDeviceDisplayMetrics = record
    PhysicalScreenSize: TSize;
    LogicalScreenSize: TSize;
    /// <summary>When available, complete screen area in pixels, including status bars and button bars. Can be
    /// the same as PhysicalScreenSize.</summary>
    RawScreenSize: TSize;
    AspectRatio: Single;
    PixelsPerInch: Integer;
    ScreenScale: Single;
    FontScale: Single;

    constructor Create(const APhysicalScreenSize, ALogicalScreenSize: TSize; const AAspectRatio: Single;
      const APixelsPerInch: Integer; const AScreenScale, AFontScale: Single);

    class operator Equal(const Left, Right: TDeviceDisplayMetrics): Boolean;
    class operator NotEqual(const Left, Right: TDeviceDisplayMetrics): Boolean; inline;

    class function Default: TDeviceDisplayMetrics; static;
  end;

{ TBounds }

  TBounds = class(TPersistent)
  private
    FRight: Single;
    FBottom: Single;
    FTop: Single;
    FLeft: Single;
    FOnChange: TNotifyEvent;
    FDefaultValue: TRectF;
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
    procedure ReadRectInt(Reader: TReader);
    procedure ReadRect(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoChange; virtual;
  public
    constructor Create(const ADefaultValue: TRectF); virtual;
    procedure Assign(Source: TPersistent); override;
    function Equals(Obj: TObject): Boolean; override;
    function PaddingRect(const R: TRectF): TRectF;
    function MarginRect(const R: TRectF): TRectF;
    function Width: Single;
    function Height: Single;
    property Rect: TRectF read GetRect write SetRect;
    property DefaultValue: TRectF read FDefaultValue write FDefaultValue;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    function Empty: Boolean;
    function MarginEmpty: Boolean;
    function ToString: string; override;
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
    FStoreAsInt: Boolean;
    procedure SetPoint(const Value: TPointF);
    procedure SetX(const Value: Single);
    procedure SetY(const Value: Single);
    function GetPoint: TPointF;
    function IsXStored: Boolean;
    function IsYStored: Boolean;
    procedure ReadXInt(Reader: TReader);
    procedure WriteXInt(Writer: TWriter);
    procedure ReadYInt(Reader: TReader);
    procedure WriteYInt(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadPoint(Reader: TReader);
    procedure WritePoint(Writer: TWriter);
    procedure DoChange; virtual;
  public
    constructor Create(const ADefaultValue: TPointF); virtual;
    procedure Assign(Source: TPersistent); override;
    procedure SetPointNoChange(const P: TPointF);
    function Empty: Boolean;
    procedure Reflect(const Normal: TPointF);
    property Point: TPointF read GetPoint write SetPoint;
    property StoreAsInt: Boolean read FStoreAsInt write FStoreAsInt;
    property DefaultValue: TPointF read FDefaultValue write FDefaultValue;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property X: Single read FX write SetX stored IsXStored nodefault;
    property Y: Single read FY write SetY stored IsYStored nodefault;
  end;

  TControlSize = class(TPersistent)
  private
    FUsePlatformDefault: Boolean;
    FSize: TSizeF;
    FDefaultValue: TSizeF;
    FOnChange: TNotifyEvent;
    procedure SetWidth(const AValue: Single);
    procedure SetHeight(const AValue: Single);
    function GetWidth: Single;
    function GetHeight: Single;
    function StoreWidthHeight: Boolean;
    procedure SetUsePlatformDefault(const Value: Boolean);
    function GetSize: TSizeF;
    procedure SetSize(const Value: TSizeF);
  protected
    procedure DoChange; virtual;
  public
    constructor Create(const ASize: TSizeF);
    procedure Assign(Source: TPersistent); override;
    procedure SetPlatformDefaultWithoutNotification(const Value: Boolean); inline;
    procedure SetSizeWithoutNotification(const Value: TSizeF);
    property DefaultValue: TSizeF read FDefaultValue write FDefaultValue;
    property Size: TSizeF read GetSize write SetSize;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Width: Single read GetWidth write SetWidth stored StoreWidthHeight;
    property Height: Single read GetHeight write SetHeight stored StoreWidthHeight;
    property PlatformDefault: Boolean read FUsePlatformDefault write SetUsePlatformDefault default True;
  end;

  IRotatedControl = interface
    ['{9EACF441-30E1-467D-88DA-CC8B2977758F}']
    function GetRotationAngle: Single;
    function GetRotationCenter: TPosition;
    function GetScale: TPosition;
    procedure SetRotationAngle(const Value: Single);
    procedure SetRotationCenter(const Value: TPosition);
    procedure SetScale(const Value: TPosition);
    property RotationAngle: Single read GetRotationAngle write SetRotationAngle;
    property RotationCenter: TPosition read GetRotationCenter write SetRotationCenter;
    property Scale: TPosition read GetScale write SetScale;
  end;

  TCaretDisplayChanged = procedure (Sender: TCustomCaret; const VirtualKeyboardState: TVirtualKeyboardStates) of object;

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
    procedure SetDefaultColor(const Value: TAlphaColor);
  protected
    function GetOwner: TPersistent; override;
    procedure DoDisplayChanged(const VirtualKeyboardState: TVirtualKeyboardStates); virtual;
    procedure DoUpdateFlasher; virtual;
  public
    constructor Create(const AOwner: TFMXObject); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
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
    property Pos: TPointF read FPos write SetPos;
    property Size: TSizeF read FSize write SetSize;
    property Color: TAlphaColor read FColor write SetColor default TAlphaColorRec.Null;
    property DefaultColor: TAlphaColor read FDefaultColor write SetDefaultColor;
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

  TTrigger = type string;

  TAnimationType = (&In, Out, InOut);

  TInterpolationType = (Linear, Quadratic, Cubic, Quartic, Quintic, Sinusoidal, Exponential, Circular, Elastic, Back, Bounce);

  TMouseEvent = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single) of object;
  TMouseMoveEvent = procedure(Sender: TObject; Shift: TShiftState; X, Y: Single) of object;
  TMouseWheelEvent = procedure(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean) of object;
  TKeyEvent = procedure(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState) of object;
  TProcessTickEvent = procedure(Sender: TObject; time, deltaTime: Single) of object;
  TVirtualKeyboardEvent = procedure(Sender: TObject; KeyboardVisible: Boolean; const Bounds : TRect) of object;
  TTapEvent = procedure(Sender: TObject; const Point: TPointF) of object;
  TTouchEvent = procedure(Sender: TObject; const Touches: TTouches; const Action: TTouchAction) of object;

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

  TEnumProcResult = (Continue, Discard, Stop);

  TFmxObject = class(TComponent, IFreeNotification, IActionClient)
  public type
    /// <summary> Determines the current state of the object
    /// <para>CallingFreeNotify - state is set before sending notifications in <b>BeforeDestruction</b> method.
    /// See also <b>IFreeNotification</b></para>
    /// <para>CallingRelease - state is set in <b>Release</b> method</para>
    /// </summary>
    TObjectState = set of (CallingFreeNotify, CallingRelease);
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
    FActionClient: Boolean;
    FActionLink: TActionLink;
    FObjectState: TObjectState;
    FRoot: IRoot;
    procedure SetStyleName(const Value: string);
    procedure SetStored(const Value: Boolean);
    function GetChildrenCount: Integer; inline;
    function GetIndexOfChild(const Child: TFmxObject): Integer;
    procedure SetIndexOfChild(const Child: TFmxObject; NewIndex: Integer);
    procedure SetIndex(NewIndex: Integer);
    { IActionClient }
    function IActionClient.GetRoot = GetActionRoot;
    function GetActionRoot: TComponent;
    function GetActionClient: Boolean; inline;
    procedure SetActionClient(const Value: boolean);
    function GetAction: TBasicAction;
    procedure SetAction(const Value: TBasicAction);
    function GetIndex: Integer;

    class constructor Create;
    class destructor Destroy;
  protected
    FStyleName: string;
    [Weak] FParent: TFmxObject;
    function CreateChildrenList(const Children: TFmxObjectList): TFmxChildrenList; virtual;
    procedure ResetChildrenIndicesSpan(const First, Last: Integer);
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
    procedure InitiateAction; virtual;
    procedure DoActionChange(Sender: TObject); virtual;
    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); virtual;
    procedure DoActionClientChanged; virtual;
    property ActionLink: TActionLink read FActionLink;
    property Action: TBasicAction read GetAction write SetAction;
    procedure DoInventory(Dict: TDictionary<string, TFmxObject>; const Prefix: string);
  public
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
  protected
    procedure AddToResourcePool; virtual;
    procedure RemoveFromResourcePool; virtual;
    { parent }
    procedure SetParent(const Value: TFmxObject); virtual;
    procedure DoRootChanging(const NewRoot: IRoot); virtual;
    procedure DoRootChanged; virtual;
    procedure ParentChanged; virtual;
    procedure ChangeOrder; virtual;
    procedure ChangeChildren; virtual;
    { children }
    procedure DoAddObject(const AObject: TFmxObject); virtual;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); virtual;
    procedure DoRemoveObject(const AObject: TFmxObject); virtual;
    procedure DoDeleteChildren; virtual;
    function SearchInto: Boolean; virtual;
    { IFreeNotification }
    procedure FreeNotification(AObject: TObject); virtual;
    { design }
    function SupportsPlatformService(const AServiceGUID: TGUID; out AService): Boolean; virtual;
    { Data }
    function GetData: TValue; virtual;
    procedure SetData(const Value: TValue); virtual;
    procedure IgnoreIntegerValue(Reader: TReader);
    procedure IgnoreFloatValue(Reader: TReader);
    procedure IgnoreBooleanValue(Reader: TReader);
    procedure IgnoreIdentValue(Reader: TReader);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeforeDestruction; override;
    procedure Release; virtual;
    function Released: Boolean;
    /// <summary> Describes the current state of this instance. Indicates that a component needs to avoid certain
    /// actions. <para>See also <b>TComponent.ComponentState</b></para></summary>
    property ObjectState: TObjectState read FObjectState;
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
    procedure BringChildToFront(const Child: TFmxObject);
    procedure SendChildToBack(const Child: TFmxObject);
    procedure BringToFront; virtual;
    procedure SendToBack; virtual;
    procedure AddObjectsToList(const AList: TFmxObjectList);
    procedure Sort(Compare: TFmxObjectSortCompare); virtual;
    /// <summary>Loops through the children of this object, and runs the specified procedure once per object as the first parameter in each call.</summary>
    procedure EnumObjects(const Proc: TFunc<TFmxObject, TEnumProcResult>);
    { animation property }
    procedure AnimateFloat(const APropertyName: string; const NewValue: Single; Duration: Single = 0.2;
      AType: TAnimationType = TAnimationType.In; AInterpolation: TInterpolationType = TInterpolationType.Linear);
      deprecated 'Use FMX.Ani.TAnimator instead';
    procedure AnimateFloatDelay(const APropertyName: string; const NewValue: Single; Duration: Single = 0.2;
      Delay: Single = 0.0; AType: TAnimationType = TAnimationType.In;
      AInterpolation: TInterpolationType = TInterpolationType.Linear);
      deprecated 'Use FMX.Ani.TAnimator instead';
    procedure AnimateFloatWait(const APropertyName: string; const NewValue: Single; Duration: Single = 0.2;
      AType: TAnimationType = TAnimationType.In; AInterpolation: TInterpolationType = TInterpolationType.Linear);
      deprecated 'Use FMX.Ani.TAnimator instead';
    procedure AnimateInt(const APropertyName: string; const NewValue: Integer; Duration: Single = 0.2;
      AType: TAnimationType = TAnimationType.In; AInterpolation: TInterpolationType = TInterpolationType.Linear);
      deprecated 'Use FMX.Ani.TAnimator instead';
    procedure AnimateIntWait(const APropertyName: string; const NewValue: Integer; Duration: Single = 0.2;
      AType: TAnimationType = TAnimationType.In; AInterpolation: TInterpolationType = TInterpolationType.Linear);
      deprecated 'Use FMX.Ani.TAnimator instead';
    procedure AnimateColor(const APropertyName: string; NewValue: TAlphaColor; Duration: Single = 0.2;
      AType: TAnimationType = TAnimationType.In; AInterpolation: TInterpolationType = TInterpolationType.Linear);
      deprecated 'Use FMX.Ani.TAnimator instead';
    procedure StopPropertyAnimation(const APropertyName: string);
    { notify }
    procedure AddFreeNotify(const AObject: IFreeNotification);
    procedure RemoveFreeNotify(const AObject: IFreeNotification);
    { resource }
    function FindStyleResource(const AStyleLookup: string; const Clone: Boolean = False): TFmxObject; overload; virtual;
    { }
    property Root: IRoot read FRoot;
    property Stored: Boolean read FStored write SetStored;
    { tags }
    property TagObject: TObject read FTagObject write FTagObject;
    property TagFloat: Single read FTagFloat write FTagFloat;
    property TagString: string read FTagString write FTagString;
    { children }
    property ChildrenCount: Integer read GetChildrenCount;
    property Children: TFmxChildrenList read FChildrenList;
    property Data: TValue read GetData write SetData;
    property Parent: TFmxObject read FParent write SetParent;
    property Index: Integer read GetIndex write SetIndex;
    property ActionClient: boolean read GetActionClient;
  published
    property StyleName: string read FStyleName write SetStyleName;
  end;

  TTabList = class(TAggregatedObject, ITabList)
  strict private
    FTabList: TList<IControl>;
    procedure CreateTabList;
    function ParentIsRoot: Boolean;
  protected
    function IsAddable(const TabStop: IControl): Boolean; virtual;
  public
    constructor Create(const TabStopController: ITabStopController);
    destructor Destroy; override;
    procedure Clear;
    procedure Add(const TabStop: IControl); virtual;
    procedure Remove(const TabStop: IControl); virtual;
    procedure Update(const TabStop: IControl; const NewValue: TTabOrder);
    function IndexOf(const TabStop: IControl): Integer; virtual;
    function GetCount: Integer; virtual;
    function GetItem(const Index: Integer): IControl; virtual;
    function GetTabOrder(const TabStop: IControl): TTabOrder;
    function FindNextTabStop(const Current: IControl; const MoveForward: Boolean; const Climb: Boolean): IControl;
  end;
  TTabListClass = class of TTabList;

{ TCustomPopupMenu }

  TCustomPopupMenu = class(TFmxObject)
  private
    [Weak] FPopupComponent: TComponent;
    FOnPopup: TNotifyEvent;
  protected
    procedure DoPopup; virtual;
    property OnPopup: TNotifyEvent read FOnPopup write FOnPopup;
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

  TInteractiveGesture = (Zoom, Pan, Rotate, TwoFingerTap, PressAndTap, LongTap, DoubleTap);

  TInteractiveGestureHelper = record helper for TInteractiveGesture
  const
    igZoom = TInteractiveGesture.Zoom deprecated 'Use TInteractiveGesture.Zoom';
    igPan = TInteractiveGesture.Pan deprecated 'Use TInteractiveGesture.Pan';
    igRotate = TInteractiveGesture.Rotate deprecated 'Use TInteractiveGesture.Rotate';
    igTwoFingerTap = TInteractiveGesture.TwoFingerTap deprecated 'Use TInteractiveGesture.TwoFingerTap';
    igPressAndtap = TInteractiveGesture.PressAndtap deprecated 'Use TInteractiveGesture.PressAndtap';
    igLongTap = TInteractiveGesture.LongTap deprecated 'Use TInteractiveGesture.LongTap';
    igDoubleTap = TInteractiveGesture.DoubleTap deprecated 'Use TInteractiveGesture.DoubleTap';
  end;
  TInteractiveGestures = set of TInteractiveGesture;

  TCustomGestureManager = class;
  TCustomGestureCollection = class;
  TCustomGestureCollectionItem = class;

  TGestureType = (Standard, Recorded, Registered, None);

  TGestureTypeHelper = record helper for TGestureType
  const
    gtStandard = TGestureType.Standard deprecated 'Use TGestureType.Standard';
    gtRecorded = TGestureType.Recorded deprecated 'Use TGestureType.Recorded';
    gtRegistered = TGestureType.Registered deprecated 'Use TGestureType.Registered';
    gtNone = TGestureType.None deprecated 'Use TGestureType.None';
  end;
  TGestureTypes = set of TGestureType;

  TGestureOption = (UniDirectional, Skew, Endpoint, Rotate);

  TGestureOptionHelper = record helper for TGestureOption
  const
    goUniDirectional = TGestureOption.UniDirectional deprecated 'Use TGestureOption.UniDirectional';
    goSkew = TGestureOption.Skew deprecated 'Use TGestureOption.Skew';
    goEndpoint = TGestureOption.Endpoint deprecated 'Use TGestureOption.Endpoint';
    goRotate = TGestureOption.Rotate deprecated 'Use TGestureOption.Rotate';
  end;
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
    property Options: TGestureOptions read GetOptions write SetOptions default [TGestureOption.UniDirectional, TGestureOption.Rotate];
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
    TGestureEngineFlag = (MouseEvents, TouchEvents);

    TGestureEngineFlagHelper = record helper for TGestureEngineFlag
    const
      efMouseEvents = TGestureEngineFlag.MouseEvents deprecated 'Use TGestureEngineFlag.MouseEvents';
      efTouchEvents = TGestureEngineFlag.TouchEvents deprecated 'Use TGestureEngineFlag.TouchEvents';
    end;
    TGestureEngineFlags = set of TGestureEngineFlag;
  protected
    function GetActive: Boolean; virtual; abstract;
    function GetFlags: TGestureEngineFlags; virtual; abstract;
    procedure SetActive(const Value: Boolean); virtual; abstract;
  public
    constructor Create(const AControl: TComponent); virtual; abstract;
    procedure BroadcastGesture(const AControl: TComponent; EventInfo: TGestureEventInfo); virtual; abstract;
    property Active: Boolean read GetActive write SetActive;
    property Flags: TGestureEngineFlags read GetFlags;
  end;

  TCustomGestureManager = class(TComponent)
  protected
    function GetGestureList(AControl: TComponent): TGestureArray; virtual; abstract;
    function GetStandardGestures(AControl: TComponent): TStandardGestures; virtual; abstract;
    procedure SetStandardGestures(AControl: TComponent; AStandardGestures: TStandardGestures); virtual; abstract;
  public
    function AddRecordedGesture(const Item: TCustomGestureCollectionItem): TGestureID; overload; virtual; abstract;
    function FindCustomGesture(AGestureID: TGestureID): TCustomGestureCollectionItem; overload; virtual; abstract;
    function FindCustomGesture(const AName: string): TCustomGestureCollectionItem; overload; virtual; abstract;
    function FindGesture(const AControl: TComponent; AGestureID: TGestureID): TCustomGestureCollectionItem; overload; virtual; abstract;
    function FindGesture(const AControl: TComponent; const AName: string): TCustomGestureCollectionItem; overload; virtual; abstract;
    procedure RemoveActionNotification(Action: TCustomAction; Item: TCustomGestureCollectionItem); virtual;
    procedure RegisterControl(const AControl: TComponent); virtual; abstract;
    procedure RemoveRecordedGesture(AGestureID: TGestureID); overload; virtual; abstract;
    procedure RemoveRecordedGesture(const AGesture: TCustomGestureCollectionItem); overload; virtual; abstract;
    function SelectGesture(const AControl: TComponent; AGestureID: TGestureID): Boolean; overload; virtual; abstract;
    function SelectGesture(const AControl: TComponent; const AName: string): Boolean; overload; virtual; abstract;
    procedure UnregisterControl(const AControl: TComponent); virtual; abstract;
    procedure UnselectGesture(const AControl: TComponent; AGestureID: TGestureID); virtual; abstract;
    property GestureList[AControl: TComponent]: TGestureArray read GetGestureList;
    property StandardGestures[AControl: TComponent]: TStandardGestures read GetStandardGestures write SetStandardGestures;
  end;

  TCustomTouchManager = class(TPersistent)
  private
  type
    TObjectWrapper = class(TObject)
      [Weak] FObject : TComponent;
      constructor Create(const AObject: TComponent);
    end;
  private
    [Weak] FControl: TComponent;
    FGestureEngine: TCustomGestureEngine;
    FGestureManager: TCustomGestureManager;
    FInteractiveGestures: TInteractiveGestures;
    FDefaultInteractiveGestures: TInteractiveGestures;
    FStandardGestures: TStandardGestures;
    function GetStandardGestures: TStandardGestures;
    function IsInteractiveGesturesStored: Boolean;
    procedure SetInteractiveGestures(const Value: TInteractiveGestures);
    procedure SetGestureEngine(const Value: TCustomGestureEngine);
    procedure SetGestureManager(const Value: TCustomGestureManager);
    procedure SetStandardGestures(const Value: TStandardGestures);
    function GetGestureList: TGestureArray;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    function IsDefault: Boolean;
  public
    constructor Create(AControl: TComponent);
    destructor Destroy; override;
    procedure ChangeNotification(const AControl: TComponent);
    function FindGesture(AGestureID: TGestureID): TCustomGestureCollectionItem; overload;
    function FindGesture(const AName: string): TCustomGestureCollectionItem; overload;
    procedure RemoveChangeNotification(const AControl: TComponent);
    function SelectGesture(AGestureID: TGestureID): Boolean; overload;
    function SelectGesture(const AName: string): Boolean; overload;
    procedure UnselectGesture(AGestureID: TGestureID); inline;
    property GestureEngine: TCustomGestureEngine read FGestureEngine write SetGestureEngine;
    property GestureList: TGestureArray read GetGestureList;
    property GestureManager: TCustomGestureManager read FGestureManager write SetGestureManager;
    property InteractiveGestures: TInteractiveGestures
      read FInteractiveGestures write SetInteractiveGestures stored IsInteractiveGesturesStored;
    property DefaultInteractiveGestures: TInteractiveGestures
      read FDefaultInteractiveGestures write FDefaultInteractiveGestures;
    property StandardGestures: TStandardGestures read GetStandardGestures write SetStandardGestures;
  end;

  TTouchManager = class(TCustomTouchManager)
  published
    property GestureManager;
    property InteractiveGestures;
  end;
  
  IGestureControl = interface
  ['{A263006D-3472-40F8-A917-F2221B48A459}']
    procedure BroadcastGesture(EventInfo: TGestureEventInfo);
    procedure CMGesture(var EventInfo: TGestureEventInfo);
    function TouchManager: TTouchManager;
    function GetFirstControlWithGesture(AGesture: TInteractiveGesture): TComponent;
    function GetFirstControlWithGestureEngine: TComponent;
    function GetListOfInteractiveGestures: TInteractiveGestures;
    procedure Tap(const Point: TPointF);
  end;

  IMultiTouch = interface
    ['{A263006D-3472-40F8-A917-F2221B48ABDD}']
    procedure MultiTouch(const Touches: TTouches; const Action: TTouchAction);
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
    function GetTick: Double;
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

{ TGuillotineBinPack }

  TFreeChoiceHeuristic = (BestAreaFit, BestShortSideFit, BestLongSideFit, WorstAreaFit, WorstShortSideFit,
    WorstLongSideFit);

  TSplitMethodHeuristic = (ShorterLeftoverAxis, LongerLeftoverAxis, MinimizeArea, MaximizeArea, ShorterAxis,
    LongerAxis);

  TGuillotineBinPack = class
  private
    FSize: TPoint;
    FUsedRectangles: TList<TRect>;
    FFreeRectangles: TList<TRect>;
    FSupportsRectangleInversion: Boolean;
    FUsedRectangleArea: Integer;

    function ScoreByHeuristic(const NodeSize: TPoint; const FreeRect: TRect;
      const Heuristic: TFreeChoiceHeuristic): Integer;

    procedure FindPositionForNewNode(const NodeSize: TPoint; const Heuristic: TFreeChoiceHeuristic;
      out NodeIndex: Integer; out NodeRect: TRect);

    procedure SplitFreeRectAlongAxis(const FreeRect, PlacedRect: TRect; const SplitHorizontal: Boolean);
    procedure SplitFreeRectByHeuristic(const FreeRect, PlacedRect: TRect; const AMethod: TSplitMethodHeuristic);

    function GetOccupancy: Single;
  public
    constructor Create; overload;
    constructor Create(const ASize: TPoint); overload;
    destructor Destroy; override;

    procedure Init(const ASize: TPoint);
    procedure MergeFreeList;

    function Insert(const NodeSize: TPoint; const Merge: Boolean = True;
      const FreeChoice: TFreeChoiceHeuristic = TFreeChoiceHeuristic.BestAreaFit;
      const SplitMethod: TSplitMethodHeuristic = TSplitMethodHeuristic.MinimizeArea): TRect;

    property Size: TPoint read FSize;
    property Occupancy: Single read GetOccupancy;
    property SupportsRectangleInversion: Boolean read FSupportsRectangleInversion write FSupportsRectangleInversion;
  end;

  EGraphicsException = class(Exception);
  ECannotDetermineDirect3DLevel = class(EGraphicsException);
  ECannotCreateD3DDevice = class(EGraphicsException);
  ECannotCreateD2DFactory = class(EGraphicsException);
  ECannotCreateDWriteFactory = class(EGraphicsException);
  ECannotCreateWICImagingFactory = class(EGraphicsException);
  ECannotCreateRenderTarget = class(EGraphicsException);
  ECannotCreateTexture = class(EGraphicsException);
  ECannotCreateSwapChain = class(EGraphicsException);
  ERetrieveSurfaceContents = class(EGraphicsException);
  ECannotCreateRenderTargetView = class(EGraphicsException);
  ECannotResizeBuffers = class(EGraphicsException);
  EBitmapSizeTooBig = class(Exception);
  EBitmapLoadingFailed = class(Exception);
  EThumbnailLoadingFailed = class(Exception);
  EBitmapSavingFailed = class(Exception);
  EBitmapFormatUnsupported = class(Exception);
  EBitmapIncorrectSize = class(Exception);
  ERetrieveSurfaceDescription = class(Exception);
  EAcquireBitmapAccess = class(Exception);
  EVideoCaptureFault = class(Exception);
  EInvalidCallingConditions = class(Exception);
  EInvalidRenderingConditions = class(Exception);
  ETextureSizeTooSmall = class(Exception);
  ECannotAcquireBitmapAccess = class(Exception);
  ECannotFindSuitablePixelFormat = class(Exception);
  ECannotFindShader = class(Exception);
  ECannotCreateDirect3D = class(Exception);
  ECannotAcquireDXGIFactory = class(Exception);
  ECannotAssociateWindowHandle = class(Exception);
  ECannotRetrieveDisplayMode = class(Exception);
  ECannotRetrieveBufferDesc = class(Exception);
  ECannotCreateSamplerState = class(Exception);
  ECannotRetrieveSurface = class(Exception);
  ECannotUploadTexture = class(Exception);
  ECannotActivateTexture = class(Exception);
  ECannotAcquireTextureAccess = class(Exception);
  ECannotCopyTextureResource = class(Exception);
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

  ///<summary>Provider a persistent object for the designer. A different TPersistent can be routed into the
  /// designer using this interface. This can be used to expose properties of non-controls in the
  /// Object Inspector.</summary>
  IPersistentProvider = interface
    ['{B0B03758-A2F5-49B9-9A39-C2C2405B2EAD}']
    ///<summary>Return the provided persistent</summary>
    function GetPersistent: TPersistent;
  end;

  ///<summary>Shim is a representative of a visual non-control object in the Designer. The shim needs to implement
  /// this interface in order to let the Designer know about its bounding rectangles.
  ///</summary>
  IPersistentShim = interface
    ['{B6F815C7-BFD1-489D-A661-0CD4639EC920}']
    ///<summary>Return bounding rectangle of shim.</summary>
    function GetBoundsRect: TRect;
  end;

  ///<summary>Extension of TPersistent directly exposed to the Designer.</summary>
  IDesignablePersistent = interface
    ['{4A731994-9060-4F3C-92D7-C123B04601D4}']
    ///<summary>GetDesignParent should return a TPersistent known to the designer, e.g. its parent TControl.</summary>
    function GetDesignParent: TPersistent;
    ///<summary>Bounding rectangle representing this TPersistent in the designer</summary>
    function GetBoundsRect: TRect;
    ///<summary>
    /// Bind this persistent with its shim, thus enabling GetBoundsRect without using the host.
    /// Example: TItemAppearanceProperties as IDesignablePersistent are bound to the TListItemShim
    ///          Their counterpart FmxReg.TListViewObjectsProperties are bound to the same TListItemShim
    ///</summary>
    procedure Bind(AShim: IPersistentShim);
    ///<summary>
    /// Unbind this persistent. The implementation would normally clear its reference to IPersistentShim.
    ///</summary>
    procedure Unbind;
    ///<summary>True if this TPersistent is currently in Design mode and wants the Designer to create
    ///IItem for itself.</summary>
    function BeingDesigned: Boolean;
  end;

  ///<summary>Interface for TPersistent to receive bounding rectangle changes from the Designer.</summary>
  IMovablePersistent = interface
    ['{A86F9221-09E9-40A7-AF0E-5C3EB859C297}']
    /// <summary>Set bounds rectangle.</summary>
    procedure SetBoundsRect(const AValue: TRect);
  end;

  ///<summary>Interface that allows binding a TPersistent with a TreeView Sprig in StructureView</summary>
  ISpriggedPersistent = interface
    ['{0F1D325A-8082-4DEA-8ABF-56A359A218A4}']
    /// <summary>Set link to a TreeView sprig specified by APersistent. nil to break the link.</summary>
    procedure SetSprig(const APersistent: TPersistent);
    /// <summary>Get link to a TreeView sprig. Returns nil if link does not exist.</summary>
    function GetSprig: TPersistent;
  end;


{ Pixel Formats }

function PixelToFloat4(Input: Pointer; InputFormat: TPixelFormat): TAlphaColorF;
procedure Float4ToPixel(const Input: TAlphaColorF; Output: Pointer; OutputFormat: TPixelFormat);

function PixelToAlphaColor(Input: Pointer; InputFormat: TPixelFormat): TAlphaColor;
procedure AlphaColorToPixel(Input: TAlphaColor; Output: Pointer; OutputFormat: TPixelFormat);

procedure ScanlineToAlphaColor(Input: Pointer; Output: PAlphaColor; PixelCount: Integer; InputFormat: TPixelFormat);
procedure AlphaColorToScanline(Input: PAlphaColor; Output: Pointer; PixelCount: Integer; OutputFormat: TPixelFormat);

function PixelFormatToString(Format: TPixelFormat): string;
function FindClosestPixelFormat(Format: TPixelFormat; const FormatList: TPixelFormatList): TPixelFormat;

{ Resources }

type
  TCustomFindStyleResource = function(const AStyleLookup: string; const Clone: Boolean = False): TFmxObject of object;

procedure AddCustomFindStyleResource(const ACustomProc: TCustomFindStyleResource);
procedure RemoveCustomFindStyleResource(const ACustomProc: TCustomFindStyleResource);

procedure AddResource(const AObject: TFmxObject);
procedure RemoveResource(const AObject: TFmxObject);
function FindStyleResource(const AStyleLookup: string; const Clone: Boolean = False): TFmxObject;

{ Lang }

procedure LoadLangFromFile(const AFileName: string);
procedure LoadLangFromStrings(const AStr: TStrings);
procedure ResetLang;

{ Align }

procedure ArrangeControl(const Control: IAlignableObject; AAlign: TAlignLayout; const AParentWidth, AParentHeight: Single;
  const ALastWidth, ALastHeight: Single; var R: TRectF);

procedure AlignObjects(const AParent: TFmxObject; APadding: TBounds; AParentWidth, AParentHeight: Single;
  var ALastWidth, ALastHeight: Single; var ADisableAlign: Boolean);

procedure RecalcAnchorRules(const Parent : TFmxObject; Anchors : TAnchors; const BoundsRect : TRectF;
  var AOriginalParentSize:TPointF; var AAnchorOrigin:TPointF; var AAnchorRules:TPointF);
procedure RecalcControlOriginalParentSize(const Parent: TFmxObject; ComponentState : TComponentState;
  const Anchoring: Boolean; var AOriginalParentSize : TPointF);

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

{ Four 2D corners describing arbitrary rectangle. }

function CornersF(Left, Top, Width, Height: Single): TCornersF; overload;
function CornersF(const Pt1, Pt2, Pt3, Pt4: TPointF): TCornersF; overload;
function CornersF(const Rect: TRect): TCornersF; overload;
function CornersF(const Rect: TRectF): TCornersF; overload;

{ Helper functions }

function IsHandleValid(Hnd: TFmxHandle): Boolean;

procedure RegisterFmxClasses(const RegClasses: array of TPersistentClass); overload;
procedure RegisterFmxClasses(const RegClasses: array of TPersistentClass;
  const GroupClasses: array of TPersistentClass); overload;

var
  AnchorAlign: array [TAlignLayout] of TAnchors = (
    { TAlignLayout.None }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop],

    { TAlignLayout.Top }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akRight],

    { TAlignLayout.Left }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akBottom],

    { TAlignLayout.Right }
    [TAnchorKind.akRight,
     TAnchorKind.akTop,
     TAnchorKind.akBottom],

    { TAlignLayout.Bottom }
    [TAnchorKind.akLeft,
     TAnchorKind.akRight,
     TAnchorKind.akBottom],

    { TAlignLayout.MostTop }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akRight],

    { TAlignLayout.MostBottom }
    [TAnchorKind.akLeft,
     TAnchorKind.akRight,
     TAnchorKind.akBottom],

    { TAlignLayout.MostLeft }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akBottom],

    { TAlignLayout.MostRight }
    [TAnchorKind.akRight,
     TAnchorKind.akTop,
     TAnchorKind.akBottom],

    { TAlignLayout.Client }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akRight,
     TAnchorKind.akBottom],

    { TAlignLayout.Contents }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akRight,
     TAnchorKind.akBottom],

    { TAlignLayout.Center }
    [],

    { TAlignLayout.VertCenter }
    [TAnchorKind.akLeft,
     TAnchorKind.akRight],

    { TAlignLayout.HorzCenter }
    [TAnchorKind.akTop,
     TAnchorKind.akBottom],

    { vaHorizintal }
    [TAnchorKind.akLeft,
     TAnchorKind.akRight],

    { TAlignLayout.Vertical }
    [TAnchorKind.akTop,
     TAnchorKind.akBottom],

    { TAlignLayout.Scale }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akRight,
     TAnchorKind.akBottom],

    { TAlignLayout.Fit }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akRight,
     TAnchorKind.akBottom],

    { TAlignLayout.FitLeft }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akRight,
     TAnchorKind.akBottom],

    { TAlignLayout.FitRight }
    [TAnchorKind.akLeft,
     TAnchorKind.akTop,
     TAnchorKind.akRight,
     TAnchorKind.akBottom]
  );

{ Debugging }
type
  /// <summary>Provides static methods for debug messages.</summary>
  Log = class abstract
  strict private
    class var FLogger: IInterface;
    class function GetLogger: IInterface; static;
  protected
    /// <summary>Referece to the logger service.</summary>
    class property Logger: IInterface read GetLogger;
  public type
    /// <summary>A conversion function used to convert array elements in ArrayToString</summary>
    TToStringFunc = reference to function(const AObject: TObject): string;
    /// <summary>A timestamp of specific point in procedure execution. TLogMarks are used by Log.Trace.
    /// See Trace and TLogToken.</summary>
    TLogMark = record
      /// <summary>A short message</summary>
      Msg: string;
      /// <summary>Timestamp</summary>
      Time: TDateTime;
    end;
    /// <summary>A token received in Trace callback. Token can be used to mark specific points in time during
    ///  procedure execution. Use Mark(Message) to mark specific moment in time. Marks will be printed
    /// in sequence with their elapsed times in Trace output.</summary>
    TLogToken = class
    private
      FMarks: TList<Log.TLogMark>;
      function GetMarkAt(const Index: Integer): TLogMark;
      function GetCount: Integer;
    protected
      constructor Create;
    public
      /// <summary>Mark time during timed execution of a procedure.</summary>
      procedure Mark(const Msg: string);
      /// <summary>Get a mark at Index.</summary>
      property MarkAt[const Index: Integer]: TLogMark read GetMarkAt;
      /// <summary>Count of accumulated Marks.</summary>
      property Count: Integer read GetCount;
    end;
  public
    /// <summary>Log a debug message. Same arguments as Format.</summary>
    class procedure d(const Fmt: string; const Args: array of const); overload;
    /// <summary>Log a simple debug message.</summary>
    class procedure d(const Msg: string); overload; inline;
    /// <summary>Log a debug message with Tag, object data of Instance, Method that invokes the logger and message Msg.
    /// </summary>
    class procedure d(const Tag: string; const Instance: TObject; const Method, Msg: string); overload; inline;
    /// <summary>Log a debug message with Tag, object data of Instance and a message Msg</summary>
    class procedure d(const Tag: string; const Instance: TObject; const Msg: string); overload; inline;
    /// <summary>Log a time stamp with message Msg</summary>
    class procedure TimeStamp(const Msg: string); overload;
    /// <summary>Perform a timed execution of Func and print execution times, return function result.
    /// Proc receives a parameter TLogToken which can be used to mark specific points where timestamps should be taken
    /// in addition to complete procedure time.</summary>
    class function Trace<TResult>(const Tag: string; const Func: TFunc<TLogToken, TResult>;
      const Threshold: Integer = -1): TResult; overload;
    /// <summary>A convenience variant of Trace&lt;TResult&gt; when token is not needed.</summary>
    class function Trace<TResult>(const Tag: string; const Func: TFunc<TResult>; const Threshold: Integer = -1): TResult; overload;
    /// <summary>A convenience variant of Trace&lt;TResult&gt; for procedures.</summary>
    class procedure Trace(const Tag: string; const Proc: TProc<TLogToken>; const Threshold: Integer = -1); overload;
    /// <summary>A convenience variant of Trace&lt;TResult&gt; for procedures when token is not needed.</summary>
    class procedure Trace(const Tag: string; const Proc: TProc; const Threshold: Integer = -1); overload;
    /// <summary>Get a basic string representation of an object, consisting of ClassName and its pointer</summary>
    class function ObjToString(const Instance: TObject): string;
    /// <summary>Get a string representation of array using MakeStr function to convert individual elements.</summary>
    class function ArrayToString(const AArray: TEnumerable<TFmxObject>; const MakeStr: TToStringFunc): string; overload;
    /// <summary>Get a string representation of array using TObject.ToString to convert individual elements.</summary>
    class function ArrayToString(const AArray: TEnumerable<TFmxObject>): string; overload;
    /// <summary>Dump complete TFmxObject with all its children.</summary>
    class procedure DumpFmxObject(const AObject: TFmxObject; const Nest: Integer = 0);
  end;

/// <summary>Removes the ampersand '&' characters  of the Text string.</summary>
function DelAmp(const Text: string): string;


type
  TEnumerableFilter<F; T: TFmxObject> = class(TEnumerable<T>)
  private
    FBaseEnum: TEnumerable<F>;
    FSelfDestruct: Boolean;
    FPredicate: TPredicate<T>;
  protected
    function DoGetEnumerator: TEnumerator<T>; override;
  public
    constructor Create(const FullEnum: TEnumerable<F>; SelfDestruct: Boolean = False; const Pred: TPredicate<T> = nil);
    class function Filter(const Src: TEnumerable<F>; const Predicate: TPredicate<T> = nil): TEnumerableFilter<F,T>;

  type
    TFilterEnumerator = class(TEnumerator<T>)
    private
      FCleanup: TEnumerableFilter<F,T>;
      FRawEnumerator: TEnumerator<F>;
      FCurrent: T;
      FPredicate: TPredicate<T>;
      function GetCurrent: T;
    protected
      function DoGetCurrent: T; override;
      function DoMoveNext: Boolean; override;
    public
      constructor Create(const Enumerable: TEnumerable<F>; const Cleanup: TEnumerableFilter<F,T>;
        const Pred: TPredicate<T>);
      destructor Destroy; override;
      property Current: T read GetCurrent;
      function MoveNext: Boolean;
    end;
  end;

  TIdleMessage = class(System.Messaging.TMessage)
  end;

  TDisplay = record
  private
    FIndex: Integer;
    FPrimary: Boolean;
    FBoundsRect: TRect;
    FWorkareaRect: TRect;
  public
    constructor Create(const AIndex: Integer; const APrimary: Boolean; const ABounds, AWorkArea: TRect);
    // Index is the same as MonitorNum. Added for the sake of brevity.
    property Index: Integer read FIndex;
    property Primary: Boolean read FPrimary;
    // Screen sizes (in logical points) without taking into account the taskbar and other decorative elements.
    property BoundsRect: TRect read FBoundsRect;
    // Bounds is the same as BoundsRect. Added for the sake of brevity.
    property Bounds: TRect read FBoundsRect;
    // Screen sizes (in logical points) minus the taskbar, and other decorative items.
    property WorkareaRect: TRect read FWorkareaRect;
    // WorkArea is the same as WorkareaRect. Added for the sake of brevity.
    property WorkArea: TRect read FWorkareaRect;
  end;

/// <summary>Registers the flasher class for the TCustomCaret object specified
/// in the CaretClass parameter.</summary>
procedure RegisterFlasherClass(const FlasherClass: TFmxObjectClass; const CaretClass: TCaretClass);
/// <summary>Returns the class of a flasher registered for the TCustomCaret
/// object specified in the CaretClass parameter.</summary>
function FlasherClass(const CaretClass: TCaretClass): TFmxObjectClass;
/// <summary>Returns the flasher object registered for the TCustomCaret object
/// specified in the CaretClass parameter.</summary>
function Flasher(const CaretClass: TCaretClass): TFmxObject;
/// <summary>Checks whether a flasher is registered for the TCustomCaret object
/// specified in the CaretClass parameter.</summary>
function AssignedFlasher(const CaretClass: TCaretClass): boolean;

type
  TShowVirtualKeyboard = procedure (const Displayed: boolean;
                                    const Caret: TCustomCaret;
                                    var VirtualKeyboardState: TVirtualKeyboardStates);

procedure RegisterShowVKProc(const ShowVirtualKeyboard: TShowVirtualKeyboard);

var
  SharedContext: TRttiContext;
  ClonePropertiesCache: TDictionary<string, TList<TRttiProperty>>;
  ClonePersistentCache: TDictionary<string, TList<TRttiProperty>>;

type
  TKeyKind = (Usual, Functional, Unknown);

  TKeyKindHelper = record helper for TKeyKind
  const
    kkUsual = TKeyKind.Usual deprecated 'Use TKeyKind.Usual';
    kkFunctional = TKeyKind.Functional deprecated 'Use TKeyKind.Functional';
    kkUnknown = TKeyKind.Unknown deprecated 'Use TKeyKind.Unknown';
  end;

  TPurgatoryManager = class
    class procedure DisablePurgatory; static;
  end;

implementation

uses
  System.UIConsts, System.Character, System.Actions, System.RTLConsts, System.TypInfo, System.DateUtils,
  System.Generics.Defaults, FMX.Ani, FMX.Platform, FMX.Forms, FMX.Consts, FMX.Utils, FMX.Styles;

type
  TOpenCustomAction = class(TCustomAction)
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

{ Pixel Formats }

type
  TPixelFormatType = (Undefined, Color, ColorFloat, Luminance);

  TPixelFormatChannel = record
    Component: Char;
    FirstBit, BitLength: Integer;
  end;

  TPixelFormatDesc = record
  public const
    MaxChannels = 4;
  private
    function GetMeaningfulChannelCount: Integer;
  public
    Channels: array [0 .. MaxChannels - 1] of TPixelFormatChannel;
    BitCount: Integer;
    FormatType: TPixelFormatType;

    constructor Create(Format: TPixelFormat);

    function AddChannel(Component: Char; FirstBit, BitLength: Integer): Integer;
    function IndexOf(Component: Char): Integer;
    function IsChannelMeaningful(Index: Integer): Boolean;

    property MeaningfulChannelCount: Integer read GetMeaningfulChannelCount;
  end;

  TPixelFormatComparer = class(TComparer<TPixelFormat>)
  private
    FPivot: TPixelFormat;
  public
    function Compare(const Left, Right: TPixelFormat): Integer; override;

    property Pivot: TPixelFormat read FPivot write FPivot;
  end;

function TPixelFormatDesc.AddChannel(Component: Char; FirstBit, BitLength: Integer): Integer;
var
  I: Integer;
begin
  for I := 0 to MaxChannels - 1 do
    if (Channels[I].Component = #0) or (Channels[I].BitLength < 1) then
    begin
      Channels[I].Component := Component;
      Channels[I].FirstBit := FirstBit;
      Channels[I].BitLength := BitLength;

      Exit(I);
    end;

  Result := -1;
end;

function TPixelFormatDesc.IsChannelMeaningful(Index: Integer): Boolean;
begin
  Result := (Index >= 0) and (Index <= MaxChannels) and (Channels[Index].BitLength > 0);
  if (not Result) then
    Exit;

  Result := Channels[Index].Component.ToUpper.IsInArray(['R', 'G', 'B', 'A']);
end;

function TPixelFormatDesc.IndexOf(Component: Char): Integer;
var
  I: Integer;
begin
  for I := 0 to MaxChannels - 1 do
    if (Channels[I].BitLength > 0) and (UpCase(Channels[I].Component) = UpCase(Component)) then
      Exit(I);

  Result := -1;
end;

function TPixelFormatDesc.GetMeaningfulChannelCount: Integer;
var
  Index: Integer;
begin
  Result := 0;

  for Index := 0 to MaxChannels - 1 do
    if IsChannelMeaningful(Index) then
      Inc(Result);
end;

constructor TPixelFormatDesc.Create(Format: TPixelFormat);
begin
  FillChar(Self, SizeOf(TPixelFormatDesc), 0);

  case Format of
    TPixelFormat.RGB:
      begin
        BitCount := 32;
        FormatType := TPixelFormatType.Color;
        AddChannel('R', 0, 8);
        AddChannel('G', 8, 8);
        AddChannel('B', 16, 8);
        AddChannel('X', 24, 8);
      end;

    TPixelFormat.RGBA:
      begin
        BitCount := 32;
        FormatType := TPixelFormatType.Color;
        AddChannel('R', 0, 8);
        AddChannel('G', 8, 8);
        AddChannel('B', 16, 8);
        AddChannel('A', 24, 8);
      end;

    TPixelFormat.BGR:
      begin
        BitCount := 32;
        FormatType := TPixelFormatType.Color;
        AddChannel('B', 0, 8);
        AddChannel('G', 8, 8);
        AddChannel('R', 16, 8);
        AddChannel('X', 24, 8);
      end;

    TPixelFormat.BGRA:
      begin
        BitCount := 32;
        FormatType := TPixelFormatType.Color;
        AddChannel('B', 0, 8);
        AddChannel('G', 8, 8);
        AddChannel('R', 16, 8);
        AddChannel('A', 24, 8);
      end;

    TPixelFormat.RGBA16:
      begin
        BitCount := 64;
        FormatType := TPixelFormatType.Color;
        AddChannel('R', 0, 16);
        AddChannel('G', 16, 16);
        AddChannel('B', 32, 16);
        AddChannel('A', 48, 16);
      end;

    TPixelFormat.BGR_565:
      begin
        BitCount := 16;
        FormatType := TPixelFormatType.Color;
        AddChannel('B', 0, 5);
        AddChannel('G', 5, 6);
        AddChannel('R', 11, 5);
      end;

    TPixelFormat.BGRA4:
      begin
        BitCount := 16;
        FormatType := TPixelFormatType.Color;
        AddChannel('B', 0, 4);
        AddChannel('G', 4, 4);
        AddChannel('R', 8, 4);
        AddChannel('A', 12, 4);
      end;

    TPixelFormat.BGR4:
      begin
        BitCount := 16;
        FormatType := TPixelFormatType.Color;
        AddChannel('B', 0, 4);
        AddChannel('G', 4, 4);
        AddChannel('R', 8, 4);
        AddChannel('X', 12, 4);
      end;

    TPixelFormat.BGR5_A1:
      begin
        BitCount := 16;
        FormatType := TPixelFormatType.Color;
        AddChannel('B', 0, 5);
        AddChannel('G', 5, 5);
        AddChannel('R', 10, 5);
        AddChannel('A', 15, 1);
      end;

    TPixelFormat.BGR5:
      begin
        BitCount := 16;
        FormatType := TPixelFormatType.Color;
        AddChannel('B', 0, 5);
        AddChannel('G', 5, 5);
        AddChannel('R', 10, 5);
        AddChannel('X', 15, 1);
      end;

    TPixelFormat.BGR10_A2:
      begin
        BitCount := 32;
        FormatType := TPixelFormatType.Color;
        AddChannel('B', 0, 10);
        AddChannel('G', 10, 10);
        AddChannel('R', 20, 10);
        AddChannel('A', 30, 2);
      end;

    TPixelFormat.RGB10_A2:
      begin
        BitCount := 32;
        FormatType := TPixelFormatType.Color;
        AddChannel('R', 0, 10);
        AddChannel('G', 10, 10);
        AddChannel('B', 20, 10);
        AddChannel('A', 30, 2);
      end;

    TPixelFormat.L:
      begin
        BitCount := 8;
        FormatType := TPixelFormatType.Luminance;
        AddChannel('L', 0, 8);
      end;

    TPixelFormat.LA:
      begin
        BitCount := 16;
        FormatType := TPixelFormatType.Luminance;
        AddChannel('L', 0, 8);
        AddChannel('A', 8, 8);
      end;

    TPixelFormat.LA4:
      begin
        BitCount := 8;
        FormatType := TPixelFormatType.Luminance;
        AddChannel('L', 0, 4);
        AddChannel('A', 4, 4);
      end;

    TPixelFormat.L16:
      begin
        BitCount := 16;
        FormatType := TPixelFormatType.Luminance;
        AddChannel('L', 0, 16);
      end;

    TPixelFormat.A:
      begin
        BitCount := 8;
        FormatType := TPixelFormatType.Color;
        AddChannel('A', 0, 8);
      end;

    TPixelFormat.R16F:
      begin
        BitCount := 16;
        FormatType := TPixelFormatType.ColorFloat;
        AddChannel('R', 0, 16);
      end;

    TPixelFormat.RG16F:
      begin
        BitCount := 32;
        FormatType := TPixelFormatType.ColorFloat;
        AddChannel('R', 0, 16);
        AddChannel('G', 16, 16);
      end;

    TPixelFormat.RGBA16F:
      begin
        BitCount := 64;
        FormatType := TPixelFormatType.ColorFloat;
        AddChannel('R', 0, 16);
        AddChannel('G', 16, 16);
        AddChannel('B', 32, 16);
        AddChannel('A', 48, 16);
      end;

    TPixelFormat.R32F:
      begin
        BitCount := 32;
        FormatType := TPixelFormatType.ColorFloat;
        AddChannel('R', 0, 32);
      end;

    TPixelFormat.RG32F:
      begin
        BitCount := 64;
        FormatType := TPixelFormatType.ColorFloat;
        AddChannel('R', 0, 32);
        AddChannel('G', 32, 32);
      end;

    TPixelFormat.RGBA32F:
      begin
        BitCount := 128;
        FormatType := TPixelFormatType.ColorFloat;
        AddChannel('R', 0, 32);
        AddChannel('G', 32, 32);
        AddChannel('B', 64, 32);
        AddChannel('A', 96, 32);
      end;
  end;
end;

function IsFormatConvertible(SourceFormat, DestFormat: TPixelFormat): Boolean;
var
  SourceDesc, DestDesc: TPixelFormatDesc;
  I, Index: Integer;
begin
  SourceDesc := TPixelFormatDesc.Create(SourceFormat);
  DestDesc := TPixelFormatDesc.Create(DestFormat);

  Result := False;

  if (SourceDesc.FormatType <> DestDesc.FormatType) or (SourceDesc.BitCount < 1) or (DestDesc.BitCount < 1) then
    Exit;

  for I := 0 to TPixelFormatDesc.MaxChannels - 1 do
    if SourceDesc.IsChannelMeaningful(I) then
    begin
      Index := DestDesc.IndexOf(SourceDesc.Channels[I].Component);
      if Index = -1 then
        Exit(False);

      Result := True;
    end;
end;

function GetChannelSizeDifference(SourceFormat, DestFormat: TPixelFormat): Integer;
var
  SourceDesc, DestDesc: TPixelFormatDesc;
  I, Index, BitAcc: Integer;
begin
  SourceDesc := TPixelFormatDesc.Create(SourceFormat);
  DestDesc := TPixelFormatDesc.Create(DestFormat);

  BitAcc := 0;

  for I := 0 to TPixelFormatDesc.MaxChannels - 1 do
    if SourceDesc.IsChannelMeaningful(I) then
    begin
      Index := DestDesc.IndexOf(SourceDesc.Channels[I].Component);
      if Index <> -1 then
        Inc(BitAcc, Sqr(SourceDesc.Channels[I].BitLength - DestDesc.Channels[Index].BitLength));
    end;

  Result := Round(Sqrt(BitAcc));
end;

function GetChannelWastedBits(SourceFormat, DestFormat: TPixelFormat): Integer;
var
  SourceDesc, DestDesc: TPixelFormatDesc;
  I: Integer;
begin
  SourceDesc := TPixelFormatDesc.Create(SourceFormat);
  DestDesc := TPixelFormatDesc.Create(DestFormat);

  Result := 0;

  for I := 0 to TPixelFormatDesc.MaxChannels - 1 do
    if (DestDesc.Channels[I].BitLength > 0) and ((not DestDesc.IsChannelMeaningful(I)) or
      (SourceDesc.IndexOf(DestDesc.Channels[I].Component) = -1)) then
        Inc(Result, DestDesc.Channels[I].BitLength);
end;

function GetChannelLocationDifference(SourceFormat, DestFormat: TPixelFormat): Integer;
var
  SourceDesc, DestDesc: TPixelFormatDesc;
  I, Index, BitAcc: Integer;
begin
  SourceDesc := TPixelFormatDesc.Create(SourceFormat);
  DestDesc := TPixelFormatDesc.Create(DestFormat);

  BitAcc := 0;

  for I := 0 to TPixelFormatDesc.MaxChannels - 1 do
    if SourceDesc.IsChannelMeaningful(I) then
    begin
      Index := DestDesc.IndexOf(SourceDesc.Channels[I].Component);
      if Index <> -1 then
        Inc(BitAcc, Sqr(SourceDesc.Channels[I].FirstBit - DestDesc.Channels[Index].FirstBit));
    end;

  Result := Round(Sqrt(BitAcc));
end;

function TPixelFormatComparer.Compare(const Left, Right: TPixelFormat): Integer;
var
  LeftDiff, RightDiff: Integer;
  LeftDesc, RightDesc, PivotDesc: TPixelFormatDesc;
begin
  // Check how different formats are in terms of useful bit depth.
  LeftDiff := GetChannelSizeDifference(FPivot, Left);
  RightDiff := GetChannelSizeDifference(FPivot, Right);

  if LeftDiff = RightDiff then
  begin
    // Check how many bits are wasted in each of formats.
    LeftDiff := GetChannelWastedBits(FPivot, Left);
    RightDiff := GetChannelWastedBits(FPivot, Right);
  end;

  if LeftDiff = RightDiff then
  begin
    // Check to what extent channel locations are different in each of formats.
    LeftDiff := GetChannelLocationDifference(FPivot, Left);
    RightDiff := GetChannelLocationDifference(FPivot, Right);
  end;

  if LeftDiff = RightDiff then
  begin
    LeftDesc := TPixelFormatDesc.Create(Left);
    RightDesc := TPixelFormatDesc.Create(Left);

    // Check how many meaningful channels are in each of formats.
    LeftDiff := LeftDesc.GetMeaningfulChannelCount;
    RightDiff := RightDesc.GetMeaningfulChannelCount;

    if LeftDiff = RightDiff then
    begin
      // Compare the total bit count in each of formats in comparison to pivot.
      PivotDesc := TPixelFormatDesc.Create(FPivot);

      LeftDiff := Abs(LeftDesc.BitCount - PivotDesc.BitCount);
      RightDiff := Abs(RightDesc.BitCount - PivotDesc.BitCount);
    end;
  end;

  if LeftDiff > RightDiff then
    Result := 1
  else if LeftDiff < RightDiff then
    Result := -1
  else
    Result := 0;
end;

function FindClosestPixelFormat(Format: TPixelFormat; const FormatList: TPixelFormatList): TPixelFormat;
var
  Comparer: TPixelFormatComparer;
  CompatList: TPixelFormatList;
  I: Integer;
begin
  if FormatList.IndexOf(Format) <> -1 then
    Exit(Format);

  Comparer := TPixelFormatComparer.Create;
  Comparer.Pivot := Format;

  CompatList := TPixelFormatList.Create(Comparer);
  try
    for I := 0 to FormatList.Count - 1 do
      if IsFormatConvertible(Format, FormatList[I]) then
        CompatList.Add(FormatList[I]);

    CompatList.Sort;

    if CompatList.Count > 0 then
      Result := CompatList[0]
    else
      Result := TPixelFormat.None;
  finally
    CompatList.Free;
  end;
end;

function PixelToFloat4(Input: Pointer; InputFormat: TPixelFormat): TAlphaColorF;
begin
  case InputFormat of
    TPixelFormat.RGB:
      begin
        Result.R := (PLongWord(Input)^ and $FF) / 255;
        Result.G := ((PLongWord(Input)^ shr 8) and $FF) / 255;
        Result.B := ((PLongWord(Input)^ shr 16) and $FF) / 255;
        Result.A := 1;
      end;

    TPixelFormat.BGR:
      begin
        Result.R := ((PLongWord(Input)^ shr 16) and $FF) / 255;
        Result.G := ((PLongWord(Input)^ shr 8) and $FF) / 255;
        Result.B := (PLongWord(Input)^ and $FF) / 255;
        Result.A := 1;
      end;

    TPixelFormat.RGBA:
      begin
        Result.R := (PLongWord(Input)^ and $FF) / 255;
        Result.G := ((PLongWord(Input)^ shr 8) and $FF) / 255;
        Result.B := ((PLongWord(Input)^ shr 16) and $FF) / 255;
        Result.A := ((PLongWord(Input)^ shr 24) and $FF) / 255;
      end;

    TPixelFormat.BGRA:
      begin
        Result.R := ((PLongWord(Input)^ shr 16) and $FF) / 255;
        Result.G := ((PLongWord(Input)^ shr 8) and $FF) / 255;
        Result.B := (PLongWord(Input)^ and $FF) / 255;
        Result.A := ((PLongWord(Input)^ shr 24) and $FF) / 255;
      end;

    TPixelFormat.RGBA16:
      begin
        Result.R := (PLongWord(Input)^ and $FFFF) / 65535;
        Result.G := ((PLongWord(Input)^ shr 16) and $FFFF) / 65535;
        Result.B := (PLongWord(NativeInt(Input) + 4)^ and $FFFF) / 65535;
        Result.A := ((PLongWord(NativeInt(Input) + 4)^ shr 16) and $FFFF) / 65535;
      end;

    TPixelFormat.BGR_565:
      begin
        Result.R := ((PWord(Input)^ shr 11) and $1F) / 31;
        Result.G := ((PWord(Input)^ shr 5) and $3F) / 63;
        Result.B := (PWord(Input)^ and $1F) / 31;
        Result.A := 1;
      end;

    TPixelFormat.BGRA4:
      begin
        Result.R := ((PWord(Input)^ shr 8) and $0F) / 15;
        Result.G := ((PWord(Input)^ shr 4) and $0F) / 15;
        Result.B := (PWord(Input)^ and $0F) / 15;
        Result.A := ((PLongWord(Input)^ shr 12) and $0F) / 15;
      end;

    TPixelFormat.BGR4:
      begin
        Result.R := ((PWord(Input)^ shr 8) and $0F) / 15;
        Result.G := ((PWord(Input)^ shr 4) and $0F) / 15;
        Result.B := (PWord(Input)^ and $0F) / 15;
        Result.A := 1;
      end;

    TPixelFormat.BGR5_A1:
      begin
        Result.R := ((PWord(Input)^ shr 10) and $1F) / 31;
        Result.G := ((PWord(Input)^ shr 5) and $1F) / 31;
        Result.B := (PWord(Input)^ and $1F) / 31;
        Result.A := (PLongWord(Input)^ shr 15) and $01;
      end;

    TPixelFormat.BGR5:
      begin
        Result.R := ((PWord(Input)^ shr 10) and $1F) / 31;
        Result.G := ((PWord(Input)^ shr 5) and $1F) / 31;
        Result.B := (PWord(Input)^ and $1F) / 31;
        Result.A := 1;
      end;

    TPixelFormat.BGR10_A2:
      begin
        Result.R := ((PLongWord(Input)^ shr 20) and $3FF) / 1023;
        Result.G := ((PLongWord(Input)^ shr 10) and $3FF) / 1023;
        Result.B := (PLongWord(Input)^ and $3FF) / 1023;
        Result.A := ((PLongWord(Input)^ shr 30) and $03) / 3;
      end;

    TPixelFormat.RGB10_A2:
      begin
        Result.R := (PLongWord(Input)^ and $3FF) / 1023;
        Result.G := ((PLongWord(Input)^ shr 10) and $3FF) / 1023;
        Result.B := ((PLongWord(Input)^ shr 20) and $3FF) / 1023;
        Result.A := ((PLongWord(Input)^ shr 30) and $03) / 3;
      end;

    TPixelFormat.L:
      begin
        Result.R := PByte(Input)^ / 255;
        Result.G := Result.R;
        Result.B := Result.R;
        Result.A := 1;
      end;

    TPixelFormat.LA:
      begin
        Result.R := (PWord(Input)^ and $FF) / 255;
        Result.G := Result.R;
        Result.B := Result.R;
        Result.A := ((PWord(Input)^ shr 16) and $FF) / 255;
      end;

    TPixelFormat.LA4:
      begin
        Result.R := (PByte(Input)^ and $0F) / 15;
        Result.G := Result.R;
        Result.B := Result.R;
        Result.A := ((PByte(Input)^ shr 8) and $0F) / 15;
      end;

    TPixelFormat.L16:
      begin
        Result.R := PWord(Input)^ / 65535;
        Result.G := Result.R;
        Result.B := Result.R;
        Result.A := 1;
      end;

    TPixelFormat.A:
      begin
        Result.R := 0;
        Result.G := 0;
        Result.B := 0;
        Result.A := PByte(Input)^ / 255;
      end;

    TPixelFormat.R32F:
      begin
        Result.R := PSingle(Input)^;
        Result.G := 0;
        Result.B := 0;
        Result.A := 1;
      end;

    TPixelFormat.RG32F:
      begin
        Result.R := PSingle(Input)^;
        Result.G := PSingle(NativeInt(Input) + 4)^;
        Result.B := 0;
        Result.A := 1;
      end;

    TPixelFormat.RGBA32F:
      begin
        Result.R := PSingle(Input)^;
        Result.G := PSingle(NativeInt(Input) + 4)^;
        Result.B := PSingle(NativeInt(Input) + 8)^;
        Result.A := PSingle(NativeInt(Input) + 12)^;
      end;

  else
    Result := TAlphaColorF.Create(0, 0, 0, 0);
  end;
end;

procedure Float4ToPixel(const Input: TAlphaColorF; Output: Pointer; OutputFormat: TPixelFormat);
begin
  case OutputFormat of
    TPixelFormat.RGB:
      PLongWord(Output)^ := Round(Input.R * 255) or (Round(Input.G * 255) shl 8) or (Round(Input.B * 255) shl 16)
        or $FF000000;

    TPixelFormat.RGBA:
      PLongWord(Output)^ := Round(Input.R * 255) or (Round(Input.G * 255) shl 8) or (Round(Input.B * 255) shl 16)
        or (Round(Input.A * 255) shl 24);

    TPixelFormat.BGR:
      PLongWord(Output)^ := Round(Input.B * 255) or (Round(Input.G * 255) shl 8) or (Round(Input.R * 255) shl 16)
        or $FF000000;

    TPixelFormat.BGRA:
      PLongWord(Output)^ := Round(Input.B * 255) or (Round(Input.G * 255) shl 8) or (Round(Input.R * 255) shl 16)
        or (Round(Input.A * 255) shl 24);

    TPixelFormat.RGBA16:
      begin
        PLongWord(Output)^ := Round(Input.R * 65535) or (Round(Input.G * 65535) shl 16);
        PLongWord(NativeInt(Output) + 4)^ := Round(Input.B * 65535) or (Round(Input.A * 65535) shl 16);
      end;

    TPixelFormat.BGR_565:
      PWord(Output)^ := Round(Input.R * 31) or (Round(Input.G * 63) shl 5) or (Round(Input.B * 31) shl 11);

    TPixelFormat.BGRA4:
      PWord(Output)^ := Round(Input.B * 15) or (Round(Input.G * 15) shl 4) or (Round(Input.R * 15) shl 8) or
        (Round(Input.A * 15) shl 12);

    TPixelFormat.BGR4:
      PWord(Output)^ := Round(Input.B * 15) or (Round(Input.G * 15) shl 4) or (Round(Input.R * 15) shl 8) or $F000;

    TPixelFormat.BGR5_A1:
      PWord(Output)^ := Round(Input.B * 31) or (Round(Input.G * 31) shl 5) or (Round(Input.R * 31) shl 10) or
        (Round(Input.A) shl 15);

    TPixelFormat.BGR5:
      PWord(Output)^ := Round(Input.B * 31) or (Round(Input.G * 31) shl 5) or (Round(Input.R * 31) shl 10) or $8000;

    TPixelFormat.BGR10_A2:
      PLongWord(Output)^ := Round(Input.B * 1023) or (Round(Input.G * 1023) shl 10) or
        (Round(Input.R * 1023) shl 20) or (Round(Input.A * 3) shl 30);

    TPixelFormat.RGB10_A2:
      PLongWord(Output)^ := Round(Input.R * 1023) or (Round(Input.G * 1023) shl 10) or
        (Round(Input.B * 1023) shl 20) or (Round(Input.A * 3) shl 30);

    TPixelFormat.L:
      PByte(Output)^ := Round(Input.R * 76.5 + Input.G * 150.45 + Input.B * 28.05);

    TPixelFormat.LA:
      PWord(Output)^ := Round(Input.R * 76.5 + Input.G * 150.45 + Input.B * 28.05) or (Round(Input.A * 255) shl 8);

    TPixelFormat.LA4:
      PByte(Output)^ := Round(Input.R * 4.5 + Input.G * 8.85 + Input.B * 1.65) or (Round(Input.A * 15) shl 4);

    TPixelFormat.L16:
      PWord(Output)^ := Round(Input.R * 19660.5 + Input.G * 38665.65 + Input.B * 7208.85);

    TPixelFormat.A:
      PByte(Output)^ := Round(Input.A * 255);

    TPixelFormat.R32F:
      PSingle(Output)^ := Input.R;

    TPixelFormat.RG32F:
      begin
        PSingle(Output)^ := Input.R;
        PSingle(NativeInt(Output) + 4)^ := Input.G;
      end;

    TPixelFormat.RGBA32F:
      begin
        PSingle(Output)^ := Input.R;
        PSingle(NativeInt(Output) + 4)^ := Input.G;
        PSingle(NativeInt(Output) + 8)^ := Input.B;
        PSingle(NativeInt(Output) + 12)^ := Input.A;
      end;
  end;
end;

function PixelToAlphaColor(Input: Pointer; InputFormat: TPixelFormat): TAlphaColor;
begin
  case InputFormat of
    TPixelFormat.BGRA:
      Result := PAlphaColor(Input)^;

    TPixelFormat.BGR:
      begin
        Result := PAlphaColor(Input)^;
        TAlphaColorRec(Result).A := 255;
      end;

    TPixelFormat.RGBA:
      Result := RGBtoBGR(PAlphaColor(Input)^);

    TPixelFormat.RGB:
      begin
        Result := RGBtoBGR(PAlphaColor(Input)^);
        TAlphaColorRec(Result).A := 255;
      end;

    TPixelFormat.L:
      begin
        TAlphaColorRec(Result).R := PByte(Input)^;
        TAlphaColorRec(Result).G := TAlphaColorRec(Result).R;
        TAlphaColorRec(Result).B := TAlphaColorRec(Result).R;
        TAlphaColorRec(Result).A := 255;
      end;

    TPixelFormat.LA:
      begin
        TAlphaColorRec(Result).R := PWord(Input)^ and $FF;
        TAlphaColorRec(Result).G := TAlphaColorRec(Result).R;
        TAlphaColorRec(Result).B := TAlphaColorRec(Result).R;
        TAlphaColorRec(Result).A := PWord(Input)^ shr 8;
      end;

    TPixelFormat.A:
      begin
        Result := 0;
        TAlphaColorRec(Result).A := PByte(Input)^;
      end;

  else
    Result := PixelToFloat4(Input, InputFormat).ToAlphaColor;
  end;
end;

procedure AlphaColorToPixel(Input: TAlphaColor; Output: Pointer; OutputFormat: TPixelFormat);
begin
  case OutputFormat of
    TPixelFormat.BGRA:
      PAlphaColor(Output)^ := Input;

    TPixelFormat.BGR:
      begin
        PAlphaColor(Output)^ := Input;
        PAlphaColorRec(Output).A := 255;
      end;

    TPixelFormat.RGBA:
      PAlphaColor(Output)^ := RGBtoBGR(Input);

    TPixelFormat.RGB:
      begin
        PAlphaColor(Output)^ := RGBtoBGR(Input);
        PAlphaColorRec(Output).A := 255;
      end;

    TPixelFormat.A:
      PByte(Output)^ := TAlphaColorRec(Input).A;

  else
    Float4ToPixel(TAlphaColorF.Create(Input), Output, OutputFormat);
  end;
end;

procedure ScanlineToAlphaColor(Input: Pointer; Output: PAlphaColor; PixelCount: Integer; InputFormat: TPixelFormat);
var
  InpMem: Pointer;
  OutColor: PAlphaColor;
  Index, SrcPitch: Integer;
begin
  SrcPitch := PixelFormatBytes[InputFormat];
  if SrcPitch < 1 then
    Exit;

  InpMem := Input;
  OutColor := Output;

  for Index := 0 to PixelCount - 1 do
  begin
    OutColor^ := PixelToAlphaColor(InpMem, InputFormat);

    Inc(NativeInt(InpMem), SrcPitch);
    Inc(OutColor);
  end;
end;

procedure AlphaColorToScanline(Input: PAlphaColor; Output: Pointer; PixelCount: Integer; OutputFormat: TPixelFormat);
var
  InpData: PAlphaColor;
  OutData: Pointer;
  Index, DestPitch: Integer;
begin
  DestPitch := PixelFormatBytes[OutputFormat];
  if DestPitch < 1 then
    Exit;

  InpData := Input;
  OutData := Output;

  for Index := 0 to PixelCount - 1 do
  begin
    AlphaColorToPixel(InpData^, OutData, OutputFormat);

    Inc(InpData);
    Inc(NativeInt(OutData), DestPitch);
  end;
end;

function PixelFormatToString(Format: TPixelFormat): string;
const
  Text: array[TPixelFormat] of string = ('None', 'RGB', 'RGBA', 'BGR', 'BGRA', 'RGBA16', 'BGR_565', 'BGRA4', 'BGR4',
    'BGR5_A1', 'BGR5', 'BGR10_A2', 'RGB10_A2', 'L', 'LA', 'LA4', 'L16', 'A', 'R16F', 'RG16F', 'RGBA16F', 'R32F',
    'RG32F', 'RGBA32F');
begin
  Result := 'TPixelFormat.' + Text[Format];
end;

{ Resources }

var
  ResourceDict: TDictionary<string,TFmxObjectList> = nil;
  ResourceProcs: TList<TCustomFindStyleResource> = nil;

procedure AddCustomFindStyleResource(const ACustomProc: TCustomFindStyleResource);
begin
  if ResourceProcs = nil then
    ResourceProcs := TList<TCustomFindStyleResource>.Create;

  ResourceProcs.Add(ACustomProc);
end;

procedure RemoveCustomFindStyleResource(const ACustomProc: TCustomFindStyleResource);
begin
  if ResourceProcs <> nil then
    ResourceProcs.Remove(ACustomProc);
end;

procedure AddResource(const AObject: TFmxObject);
var
  ResourceList: TFmxObjectList;
begin
  if ResourceDict = nil then
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
  if (ResourceDict <> nil) and ResourceDict.TryGetValue(AObject.StyleName, ResourceList) then
    ResourceList.Remove(AObject);
end;

function FindStyleResource(const AStyleLookup: string; const Clone: Boolean = False): TFmxObject;
var
  I: Integer;
  ResourceList: TFmxObjectList;
  StyleObject: TFmxObject;
  SaveStyleName: string;
  CustomProc: TCustomFindStyleResource;
begin
  StyleObject := nil;
  if (ResourceDict <> nil) and ResourceDict.TryGetValue(AStyleLookup, ResourceList) then
    for I := ResourceList.Count - 1 downto 0 do
      if (ResourceList[I] <> nil) and ResourceList[I].Stored then
      begin
        StyleObject := ResourceList[I];
        Break;
      end;

  if (StyleObject <> nil) and Clone then
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

  if (Result = nil) and (ResourceProcs <> nil) then
    for CustomProc in ResourceProcs do
    begin
      StyleObject := CustomProc(AStyleLookup, Clone);
      if StyleObject <> nil then
        Exit(StyleObject);
    end;
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
  if CollectLang = nil then
  begin
    CollectLang := TStringList.Create;
//    TStringList(CollectLang).Sorted := True;
    TStringList(CollectLang).CaseSensitive := True;
  end;
end;

procedure CollectLangFinish;
begin
  FreeAndNil(CollectLang);
end;

function CollectLangStrings: TStrings;
begin
  Result := CollectLang;
end;

procedure CollectLangSave;
begin
  if CollectLang <> nil then
    CollectLang.SaveToFile(ExtractFilePath(ParamStr(0)) + 'lang.lng');
end;

procedure LoadLangFromFile(const AFileName: string);
begin
  if not FileExists(AFileName) then
    Exit;
  ResetLang;
  if Lang = nil then
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
  if AStr = nil then
    Exit;
  ResetLang;
  if Lang = nil then
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
  if Lang <> nil then
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
  if CollectLang <> nil then
  begin
    if CollectLang.IndexOf(AText) < 0 then
      CollectLang.Add(AText)
  end;
  if Lang <> nil then
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

function MarginsWidth(const Control: IAlignableObject): Single;
begin
  Result := Control.Margins.Left + Control.Width + Control.Margins.Right;
end;

function MarginsHeight(const Control: IAlignableObject): Single;
begin
  Result := Control.Margins.Top + Control.Height + Control.Margins.Bottom;
end;

procedure ArrangeControlToAnchors(const Control: IAlignableObject; const Scale: TPointF; const ScaleInv: TPointF;
  const AParentWidth: Single; const AParentHeight: Single);
var
  NewLeft, NewTop, NewWidth, NewHeight: Single;
begin
  NewLeft := Control.Left - Control.Margins.Left * Scale.X;
  NewTop := Control.Top - Control.Margins.Top * Scale.Y;
  NewWidth := MarginsWidth(Control) * Scale.X;
  NewHeight := MarginsHeight(Control) * Scale.Y;
  if TAnchorKind.akRight in Control.Anchors then
    if TAnchorKind.akLeft in Control.Anchors then
      // The AnchorRules.X is the original FContext.Width
      NewWidth := (AParentWidth - (Control.OriginalParentSize.X - Control.AnchorRules.X * Scale.X)) + (Control.Margins.Left + Control.Margins.Right) * Scale.X
    else
      // The AnchorRules.X is the original left
      NewLeft := AParentWidth - (Control.OriginalParentSize.X - Control.AnchorRules.X) - (Control.Margins.Left + 0*Control.Margins.Right) * Scale.X
  else if not (TAnchorKind.akLeft in Control.Anchors) and (Control.OriginalParentSize.X <> 0) then
    // The AnchorRules.X is the original middle of the AControl
    NewLeft := Control.AnchorRules.X * AParentWidth / Control.OriginalParentSize.X - Control.Width / 2 - Control.Margins.Left * Scale.X;
  if TAnchorKind.akBottom in Control.Anchors then
    if TAnchorKind.akTop in Control.Anchors then
      // The AnchorRules.Y is the original FContext.Height
      NewHeight := AParentHeight - (Control.OriginalParentSize.Y - Control.AnchorRules.Y * Scale.Y) + (Control.Margins.Top + Control.Margins.Bottom) * Scale.Y
    else
      // The AnchorRules.Y is the original top
      NewTop := AParentHeight - (Control.OriginalParentSize.Y - Control.AnchorRules.Y) - (Control.Margins.Top + 0*Control.Margins.Bottom) * Scale.X
  else if not (TAnchorKind.akTop in Control.Anchors) and (Control.OriginalParentSize.Y <> 0) then
    // The AnchorRules.Y is the original middle of the AControl
    NewTop := Control.AnchorRules.Y * AParentHeight / Control.OriginalParentSize.Y - Control.Height / 2 - Control.Margins.Top * Scale.Y;
  Control.AnchorMove := True;
  try
    NewLeft := NewLeft + Control.Margins.Left * Scale.X;
    NewTop := NewTop + Control.Margins.Top * Scale.Y;
    NewWidth := (NewWidth - (Control.Margins.Left + Control.Margins.Right) * Scale.X) * ScaleInv.X;
    NewHeight := (NewHeight - (Control.Margins.Top + Control.Margins.Bottom) * Scale.Y) * ScaleInv.Y;
    Control.SetBounds(NewLeft, NewTop, NewWidth, NewHeight);
  finally
    Control.AnchorMove := False;
  end;
end;

function FindControlRectForAlignment(const Control: IAlignableObject; const R: TRectF; const AAlign: TAlignLayout;
  const Scale: TPointF): TRectF;
begin
  Result := R;
  if AAlign in [TAlignLayout.Left, TAlignLayout.Right, TAlignLayout.Vertical, TAlignLayout.MostLeft,
    TAlignLayout.MostRight] then
  begin
    Result.Width := MarginsWidth(Control) * Scale.X;
    Result.Height := R.Height;
  end;
  if AAlign in [TAlignLayout.Top, TAlignLayout.Bottom, TAlignLayout.MostTop, TAlignLayout.MostBottom,
    TAlignLayout.Horizontal] then
  begin
    Result.Height := MarginsHeight(Control) * Scale.Y;
    Result.Width := R.Width;
  end;
  if AAlign = TAlignLayout.Vertical then
    Result.SetLocation(Control.Left - Control.Margins.Left, Result.Top)
  else if AAlign = TAlignLayout.Horizontal then
    Result.SetLocation(Result.Left, Control.Top - Control.Margins.Top)
end;

procedure PlaceControlToFit(const Control: IAlignableObject; const Scale: TPointF; var R: TRectF;
  const AAlign: TAlignLayout; const AParentWidth: Single; const AParentHeight: Single);
var
  MR, CR: TRectF;
  FitScale: Single;
begin
  MR := TRectF.Create(0, 0, AParentWidth, AParentHeight);
  CR := TRectF.Create(Control.Left - Control.Margins.Left * Scale.X, Control.Top - Control.Margins.Top * Scale.Y,
    Control.Left + (Control.Width + Control.Margins.Right) * Scale.X,
    Control.Top + (Control.Height + Control.Margins.Bottom) * Scale.Y);
  FitScale := CR.Fit(MR);
  if (FitScale > 0) and (FitScale < 1) then
  begin
    CR := TRectF.Create(CR.Left / FitScale, CR.Top / FitScale, CR.Right / FitScale, CR.Bottom / FitScale);
    RectCenter(CR, MR);
  end;
  if AAlign = TAlignLayout.FitLeft then
    CR.Offset(MR.Left - CR.Left, 0);
  if AAlign = TAlignLayout.FitRight then
    CR.Offset(MR.Right - CR.Right, 0);
  Control.SetBounds(CR.Left + Control.Margins.Left / Scale.X, CR.Top + Control.Margins.Top / Scale.Y,
    (CR.Width - Control.Margins.Left - Control.Margins.Right) / Scale.X,
    (CR.Height - Control.Margins.Top - Control.Margins.Bottom) / Scale.Y);
  if AAlign = TAlignLayout.FitLeft then
    R.Left := R.Left + CR.Width;    // Control.Width * Scale.X
  if AAlign = TAlignLayout.FitRight then
    R.Right := R.Right - CR.Width;  // Control.Width * Scale.X
end;

procedure PlaceControlToContents(const Control: IAlignableObject; const Scale: TPointF; const AParentWidth: Single;
  const AParentHeight: Single);
var
  Left, Top, Width, Height: Single;
begin
  Left := Control.Margins.Left / Scale.X;
  Top := Control.Margins.Top / Scale.Y;
  Width := (AParentWidth - Control.Margins.Left - Control.Margins.Right) / Scale.X;
  Height := (AParentHeight - Control.Margins.Top - Control.Margins.Bottom) / Scale.Y;
  Control.SetBounds(Left, Top, Width, Height);
end;

function ArrangeControlToCenter(const Control: IAlignableObject; const Scale: TPointF; var R: TRectF;
  const NewRect: TRectF): TRectF;
begin
  Result.Left := R.Left + Trunc((NewRect.Width - MarginsWidth(Control) * Scale.X) / 2);
  Result.Width := MarginsWidth(Control) * Scale.X;
  Result.Top := R.Top + Trunc((NewRect.Height - MarginsHeight(Control) * Scale.Y) / 2);
  Result.Height := MarginsHeight(Control) * Scale.Y;
end;

function ArrangeControlToHorzCenter(const Control: IAlignableObject; const Scale: TPointF; var R: TRectF;
  const NewRect: TRectF): TRectF;
begin
  Result := NewRect;
  Result.Left := R.Left + Trunc((NewRect.Width - MarginsWidth(Control) * Scale.X) / 2);
  Result.Width := MarginsWidth(Control) * Scale.X;
end;

function ArrangeControlToVertCenter(const Control: IAlignableObject; const Scale: TPointF; var R: TRectF;
  const NewRect: TRectF): TRectF;
begin
  Result := NewRect;
  Result.Top := R.Top + Trunc((NewRect.Height - MarginsHeight(Control) * Scale.Y) / 2);
  Result.Height := MarginsHeight(Control) * Scale.Y;
end;

function ArrangeControlToScale(const Control: IAlignableObject; const Scale: TPointF; const SX: Single;
  const SY: Single): TRectF;
begin
  Result := TRectF.Create(TPointF.Create((Control.Left - Control.Margins.Left) * SX, (Control.Top - Control.Margins.Top) * SY),
    MarginsWidth(Control) * SX * Scale.X, MarginsHeight(Control) * SY * Scale.Y);
end;

procedure AdjustClientRectAfterResize(const Control: IAlignableObject; const ScaleInv: TPointF; var R: TRectF;
  const AAlign: TAlignLayout; const NewRect: TRectF);
var
  ControlWidth, ControlHeight: Single;
  AdjWidth, AdjHeight: Single;
begin
  ControlWidth := MarginsWidth(Control);
  ControlHeight := MarginsHeight(Control);
  AdjWidth := NewRect.Width * ScaleInv.X;
  AdjHeight := NewRect.Height * ScaleInv.Y;
  { Adjust client RectF if control didn't resize as we expected }
  if (not SameValue(ControlWidth, AdjWidth, TEpsilon.Position))
    or (not SameValue(ControlHeight, AdjHeight, TEpsilon.Position)) then
    case AAlign of
      TAlignLayout.Top:
        R.Top := R.Top - (AdjHeight - ControlHeight);
      TAlignLayout.Bottom:
        R.Bottom := R.Bottom + (AdjHeight - ControlHeight);
      TAlignLayout.Left:
        R.Left := R.Left - (AdjWidth - ControlWidth);
      TAlignLayout.Right:
        R.Right := R.Right + (AdjWidth - ControlWidth);
      TAlignLayout.Client:
        begin
          R.Right := R.Right + AdjWidth - ControlWidth;
          R.Bottom := R.Bottom + AdjHeight - ControlHeight;
        end
    end;
end;

procedure FixedSizeAdjust(const Control: IAlignableObject; const Scale: TPointF; var LControlBounds: TRectF;
  AAlign: TAlignLayout);
var
  LAV: TSizeF;
begin
  LAV := Control.AdjustSizeValue;
  LAV.cx := LAV.cx * Scale.X;
  LAV.cy := LAV.cy * Scale.Y;
  if (Control.AdjustType in [TAdjustType.FixedSize, TAdjustType.FixedHeight]) and (LAV.Height > 0)
    and (AAlign in [TAlignLayout.Left, TAlignLayout.Right, TAlignLayout.MostLeft, TAlignLayout.MostRight,
    TAlignLayout.VertCenter, TAlignLayout.HorzCenter, TAlignLayout.Center, TAlignLayout.Vertical]) then
  begin
    LControlBounds.Top := LControlBounds.Top + Max(0, Round((LControlBounds.Height - LAV.Height) / 2));
    LControlBounds.Height := LAV.Height;
  end;
  if (Control.AdjustType in [TAdjustType.FixedSize, TAdjustType.FixedWidth]) and (LAV.Width > 0)
    and (AAlign in [TAlignLayout.Top, TAlignLayout.Bottom, TAlignLayout.MostTop, TAlignLayout.MostBottom,
    TAlignLayout.VertCenter, TAlignLayout.HorzCenter, TAlignLayout.Center, TAlignLayout.Horizontal]) then
  begin
    LControlBounds.Left := LControlBounds.Left + Max(0, Round((LControlBounds.Width - LAV.Width) / 2));
    LControlBounds.Width := LAV.Width;
  end;
end;

procedure ArrangeControl(const Control: IAlignableObject; AAlign: TAlignLayout;
  const AParentWidth, AParentHeight: Single; const ALastWidth, ALastHeight: Single; var R: TRectF);

  function PaddingRect(Control: IAlignableObject; const Scale: TPointF; const R: TRectF): TRectF;
  begin
    Result := TRectF.Create(R.Left + Control.Margins.Left * Scale.X, R.Top + Control.Margins.Top * Scale.Y,
      R.Right - Control.Margins.Right * Scale.X, R.Bottom - Control.Margins.Bottom * Scale.Y);
  end;
var
  LControlBounds: TRectF;
  LSetBounds: TRectF;
  Rotated: IRotatedControl;
  Scale: TPointF;
  ScaleInv: TPointF;
begin
  if Supports(Control, IRotatedControl, Rotated) then
  begin
    Scale := TPointF.Create(Rotated.Scale.X, Rotated.Scale.Y);
    ScaleInv := TPointF.Create(1, 1);
    if not SameValue(Scale.X, 0, TEpsilon.Scale) then
      ScaleInv.X := 1 / Scale.X;
    if not SameValue(Scale.Y, 0, TEpsilon.Scale) then
      ScaleInv.Y := 1 / Scale.Y;
  end
  else
  begin
    Scale := TPointF.Create(1, 1);
    ScaleInv := TPointF.Create(1, 1);
  end;

  if (AAlign = TAlignLayout.None) or (Control.Anchors <> AnchorAlign[AAlign]) then
    ArrangeControlToAnchors(Control, Scale, ScaleInv, AParentWidth, AParentHeight);
  if AAlign = TAlignLayout.None then
    Exit;
  LControlBounds := FindControlRectForAlignment(Control, R, AAlign, Scale);
  case AAlign of
    TAlignLayout.Top, TAlignLayout.MostTop:
      R.Top := R.Top + LControlBounds.Height;
    TAlignLayout.Bottom, TAlignLayout.MostBottom:
      begin
        R.Bottom := R.Bottom - LControlBounds.Height;
        LControlBounds.SetLocation(LControlBounds.Left, R.Bottom);
      end;
    TAlignLayout.Left, TAlignLayout.MostLeft:
      R.Left := R.Left + LControlBounds.Width;
    TAlignLayout.Right, TAlignLayout.MostRight:
      begin
        R.Right := R.Right - LControlBounds.Width;
        LControlBounds.SetLocation(R.Right, LControlBounds.Top);
      end;
    TAlignLayout.Contents:
      begin
        PlaceControlToContents(Control, Scale, AParentWidth, AParentHeight);
        Exit;
      end;
    TAlignLayout.Fit, TAlignLayout.FitLeft, TAlignLayout.FitRight:
      begin
        PlaceControlToFit(Control, Scale, R, AAlign, AParentWidth, AParentHeight);
        Exit;
      end;
    TAlignLayout.Center:
      LControlBounds := ArrangeControlToCenter(Control, Scale, R, LControlBounds);
    TAlignLayout.HorzCenter:
      LControlBounds := ArrangeControlToHorzCenter(Control, Scale, R, LControlBounds);
    TAlignLayout.VertCenter:
      LControlBounds := ArrangeControlToVertCenter(Control, Scale, R, LControlBounds);
    TAlignLayout.Scale:
      if (ALastWidth > 0) and (ALastHeight > 0) then
        LControlBounds := ArrangeControlToScale(Control, Scale, AParentWidth / ALastWidth, AParentHeight / ALastHeight);
  end;
  LSetBounds := PaddingRect(Control, Scale, LControlBounds);

  FixedSizeAdjust(Control, Scale, LSetBounds, AAlign);

  LSetBounds.Width := LSetBounds.Width * ScaleInv.X;
  LSetBounds.Height := LSetBounds.Height * ScaleInv.Y;
  Control.SetBounds(LSetBounds.Left, LSetBounds.Top, LSetBounds.Width, LSetBounds.Height);
  if AAlign = TAlignLayout.Scale then
    Exit;

  AdjustClientRectAfterResize(Control, ScaleInv, R, AAlign, LControlBounds);
end;

{ Align procedure }

procedure AlignObjects(const AParent: TFmxObject; APadding: TBounds; AParentWidth,
  AParentHeight: Single; var ALastWidth, ALastHeight: Single; var ADisableAlign: Boolean);
var
  R: TRectF;
  AlignList: TInterfaceList;

  function InsertBefore(const C1, C2: IAlignableObject; AAlign: TAlignLayout): Boolean;
  begin
    Result := False;
    case AAlign of
      TAlignLayout.Top, TAlignLayout.MostTop:
        Result := C1.Top < C2.Top;
      TAlignLayout.Bottom, TAlignLayout.MostBottom:
        Result := (C1.Top + C1.Height) >= (C2.Top + C2.Height);
      TAlignLayout.Left, TAlignLayout.MostLeft:
        Result := C1.Left < C2.Left;
      TAlignLayout.Right, TAlignLayout.MostRight:
        Result := (C1.Left + C1.Width) >= (C2.Left + C2.Width);
    end;
  end;

  procedure DoAlign(AAlign: TAlignLayout);
  var
    I, J: Integer;
    Control: IAlignableObject;
    ALCount: Integer;
  begin
    AlignList.Clear;
    for I := 0 to AParent.Children.Count - 1 do
    begin
      if not Supports(AParent.Children[I], IAlignableObject, Control) then
        Continue;
      // Don't realign object with Anchors if it not loaded yet
      if (AAlign = TALignLayout.None) and (csLoading in AParent.Children[I].ComponentState) then
        Continue;

      if (Control.Align = AAlign) and (Control.AllowAlign) then
      begin
        J := 0;
        ALCount := AlignList.Count;
        while (J < ALCount) and (AAlign <> TAlignLayout.None) and not InsertBefore(Control, IAlignableObject(AlignList[J]), AAlign) do
          Inc(J);
        AlignList.Insert(J, Control);
      end;
    end;
    ALCount := AlignList.Count;
    for I := 0 to ALCount - 1 do
      ArrangeControl(IAlignableObject(AlignList[I]), AAlign, AParentWidth, AParentHeight, ALastWidth, ALastHeight, R);
  end;

begin
  if (csDestroying in AParent.ComponentState) or (AParent.Children = nil) or (AParent.Children.Count = 0)
    or ADisableAlign or (AParentWidth < 1) or (AParentWidth < 1) then
    Exit;
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

  R := RectF(0, 0, AParentWidth, AParentHeight);
  if APadding <> nil then
    R := APadding.PaddingRect(R);
  ADisableAlign := True;
  AlignList := TInterfaceList.Create;
  try
    // Align
    DoAlign(TAlignLayout.MostTop);
    DoAlign(TAlignLayout.MostBottom);
    DoAlign(TAlignLayout.MostLeft);
    DoAlign(TAlignLayout.MostRight);
    DoAlign(TAlignLayout.Top);
    DoAlign(TAlignLayout.Bottom);
    DoAlign(TAlignLayout.Left);
    DoAlign(TAlignLayout.Right);
    DoAlign(TAlignLayout.FitLeft);
    DoAlign(TAlignLayout.FitRight);
    DoAlign(TAlignLayout.Client);
    DoAlign(TAlignLayout.Horizontal);
    DoAlign(TAlignLayout.Vertical);
    DoAlign(TAlignLayout.Contents);
    DoAlign(TAlignLayout.Center);
    DoAlign(TAlignLayout.HorzCenter);
    DoAlign(TAlignLayout.VertCenter);
    DoAlign(TAlignLayout.Scale);
    DoAlign(TAlignLayout.Fit);
    // Anchors
    DoAlign(TAlignLayout.None);

    ALastWidth := AParentWidth;
    ALastHeight := AParentHeight;
  finally
    AlignList.Free;
    ADisableAlign := False;
  end;
end;

{ Geom }

function CornersF(const Pt1, Pt2, Pt3, Pt4: TPointF): TCornersF;
begin
  Result[0] := Pt1;
  Result[1] := Pt2;
  Result[2] := Pt3;
  Result[3] := Pt4;
end;

function CornersF(Left, Top, Width, Height: Single): TCornersF;
begin
  Result[0] := TPointF.Create(Left, Top);
  Result[1] := TPointF.Create(Left + Width, Top);
  Result[2] := TPointF.Create(Left + Width, Top + Height);
  Result[3] := TPointF.Create(Left, Top + Height);
end;

function CornersF(const Rect: TRectF): TCornersF;
begin
  Result[0] := TPointF.Create(Rect.Left, Rect.Top);
  Result[1] := TPointF.Create(Rect.Right, Rect.Top);
  Result[2] := TPointF.Create(Rect.Right, Rect.Bottom);
  Result[3] := TPointF.Create(Rect.Left, Rect.Bottom);
end;

function CornersF(const Rect: TRect): TCornersF;
begin
  Result[0] := TPointF.Create(Rect.Left, Rect.Top);
  Result[1] := TPointF.Create(Rect.Right, Rect.Top);
  Result[2] := TPointF.Create(Rect.Right, Rect.Bottom);
  Result[3] := TPointF.Create(Rect.Left, Rect.Bottom);
end;

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
  else if Source = nil then
    Rect := FDefaultValue
  else
    inherited
end;

function TBounds.GetRect: TRectF;
begin
  Result := TRectF.Create(FLeft, FTop, FRight, FBottom);
end;

procedure TBounds.SetRect(const Value: TRectF);
begin
  if Rect <> Value then
  begin
    FLeft := Value.Left;
    FTop := Value.Top;
    FRight := Value.Right;
    FBottom := Value.Bottom;
    DoChange;
  end;
end;

function TBounds.PaddingRect(const R: TRectF): TRectF;
begin
  Result := TRectF.Create(R.Left + FLeft, R.Top + FTop, R.Right - FRight, R.Bottom - FBottom);
end;

function TBounds.MarginRect(const R: TRectF): TRectF;
begin
  Result := TRectF.Create(R.Left - FLeft, R.Top - FTop, R.Right + FRight, R.Bottom + FBottom);
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
  Result := not SameValue(FBottom, FDefaultValue.Bottom, Epsilon);
end;

function TBounds.IsLeftStored: Boolean;
begin
  Result := not SameValue(FLeft, FDefaultValue.Left, Epsilon);
end;

function TBounds.IsRightStored: Boolean;
begin
  Result := not SameValue(FRight, FDefaultValue.Right, Epsilon);
end;

function TBounds.IsTopStored: Boolean;
begin
  Result := not SameValue(FTop, FDefaultValue.Top, Epsilon);
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
    DoChange;
  end;
end;

procedure TBounds.SetLeft(const Value: Single);
begin
  if not SameValue(FLeft, Value, Epsilon) then
  begin
    FLeft := Value;
    DoChange;
  end;
end;

procedure TBounds.SetRight(const Value: Single);
begin
  if not SameValue(FRight, Value, Epsilon) then
  begin
    FRight := Value;
    DoChange;
  end;
end;

procedure TBounds.SetTop(const Value: Single);
begin
  if not SameValue(FTop, Value, Epsilon) then
  begin
    FTop := Value;
    DoChange;
  end;
end;

function TBounds.ToString: string;
begin
  Result := Format('%s (%4.2f,%4.2f)-(%4.2f,%4.2f)', [inherited ToString, FLeft, FTop, FRight, FBottom]);
end;

procedure TBounds.DefineProperties(Filer: TFiler);
begin
  inherited;
  // Compatible
  Filer.DefineProperty('Rect', ReadRect, nil, False);
  Filer.DefineProperty('RectI', ReadRectInt, nil, False);
  Filer.DefineProperty('LeftI', ReadLeftInt, nil, False);
  Filer.DefineProperty('RightI', ReadRightInt, nil, False);
  Filer.DefineProperty('TopI', ReadTopInt, nil, not False);
  Filer.DefineProperty('BottomI', ReadBottomInt, nil, False);
end;

procedure TBounds.DoChange;
begin
  if Assigned(OnChange) then
    OnChange(Self);
end;

procedure TBounds.ReadLeftInt(Reader: TReader);
begin
  FLeft := Reader.ReadInteger;
end;

procedure TBounds.ReadRightInt(Reader: TReader);
begin
  FRight := Reader.ReadInteger;
end;

procedure TBounds.ReadTopInt(Reader: TReader);
begin
  FTop := Reader.ReadInteger;
end;

procedure TBounds.ReadBottomInt(Reader: TReader);
begin
  FBottom := Reader.ReadInteger;
end;

procedure TBounds.ReadRect(Reader: TReader);
begin
  Rect := StringToRect(Reader.ReadString);
end;

procedure TBounds.ReadRectInt(Reader: TReader);
begin
  Rect := TRectF.Create(StringToRect(Reader.ReadString));
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
  Filer.DefineProperty('XI', ReadXInt, WriteXInt, FStoreAsInt and not SameValue(FX, FDefaultValue.X, Epsilon));
  Filer.DefineProperty('YI', ReadYInt, WriteYInt, FStoreAsInt and not SameValue(FY, FDefaultValue.Y, Epsilon));
end;

procedure TPosition.ReadXInt(Reader: TReader);
begin
  FX := Reader.ReadInteger;
  FStoreAsInt := True;
end;

procedure TPosition.WriteXInt(Writer: TWriter);
begin
  Writer.WriteInteger(Trunc(FX));
end;

procedure TPosition.ReadYInt(Reader: TReader);
begin
  FY := Reader.ReadInteger;
  FStoreAsInt := True;
end;

procedure TPosition.WriteYInt(Writer: TWriter);
begin
  Writer.WriteInteger(Trunc(FY));
end;

procedure TPosition.DoChange;
begin
  if Assigned(OnChange) then
    OnChange(Self);
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
  Result := not SameValue(FDefaultValue.X, FX, TEpsilon.Position) and not FStoreAsInt;
end;

function TPosition.IsYStored: Boolean;
begin
  Result := not SameValue(FDefaultValue.Y, FY, TEpsilon.Position) and not FStoreAsInt;
end;

procedure TPosition.Reflect(const Normal: TPointF);
begin
  Point := Point.Reflect(Normal);
end;

function TPosition.GetPoint: TPointF;
begin
  Result := TPointF.Create(FX, FY);
end;

procedure TPosition.SetPoint(const Value: TPointF);
var
  LChange: Boolean;
begin
  LChange := not (SameValue(FX, Value.X, Epsilon) and SameValue(FY, Value.Y, Epsilon));
  FX := Value.X;
  FY := Value.Y;
  if LChange then
    DoChange;
end;

procedure TPosition.SetX(const Value: Single);
var
  LChange: Boolean;
begin
  LChange := not SameValue(FX, Value, Epsilon);
  FX := Value;
  if LChange then
    DoChange;
end;

procedure TPosition.SetY(const Value: Single);
var
  LChange: Boolean;
begin
  LChange := not SameValue(FY, Value, Epsilon);
  FY := Value;
  if LChange then
    DoChange;
end;

{ TTransform }

constructor TTransform.Create;
begin
  inherited;
  FMatrix := TMatrix.Identity;
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
  FMatrix := TMatrix.Identity;
  FMatrix.m31 := FPosition.X;
  FMatrix.m32 := FPosition.Y;
  FMatrix.m13 := FSkew.X;
  FMatrix.m23 := FSkew.Y;
  FMatrix.m11 := FScale.X;
  FMatrix.m22 := FScale.Y;
  if FRotationAngle <> 0 then
    FMatrix := TMatrix.CreateRotation(DegToRad(FRotationAngle)) * FMatrix;
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
    MatrixChanged(Self);
  end;
end;

procedure TTransform.SetScale(const Value: TPosition);
begin
  FScale.Assign(Value);
end;

{ TFmxReader }

type
  TFmxReader = class(TReader)
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
    FDisabled: Boolean;
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
    procedure Disable;
  end;

var
  vPurgatory: TPurgatory;

{ TPurgatory }

class procedure TPurgatoryManager.DisablePurgatory;
begin
  vPurgatory.Disable;
end;

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

procedure TPurgatory.Disable;
begin
  FDisabled := True;
  Clear;
end;

function TPurgatory.Contains(const Instance: TFmxObject): Boolean;
begin
  Result := FInstanceList.Contains(Instance);
end;

procedure TPurgatory.Add(const Instance: TFmxObject);
begin
  if FDisabled then
    Instance.DisposeOf
  else
  if (Instance <> nil) and not Contains(Instance) then
  begin
    FreeNotification(Instance);
    FInstanceList.Add(Instance);
    if FInstanceList.Count > 0 then
      StartTimer;
  end;
end;

procedure TPurgatory.Remove(const Instance: TFmxObject);
begin
  if Instance <> nil then
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
    if FPlatformTimer = nil then
    begin
      if not TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, FPlatformTimer) then
        raise EUnsupportedPlatformService.Create('IFMXTimerService');
    end;
    if FTimerHandle = cIdNoTimer then
      FTimerHandle := FPlatformTimer.CreateTimer(TimerInterval, TimerProc);
  end;
end;

procedure TPurgatory.StopTimer;
begin
  if (FPlatformTimer <> nil) and (FTimerHandle <> cIdNoTimer) then
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
  if (FInstanceList.Count = 0) and (FPlatformTimer <> nil) then
    StopTimer;
end;

procedure TPurgatory.Clear;
var
  Instance: TFmxObject;
  I: Integer;
  PurgatoryItem: IPurgatoryItem;
begin
  try
    I := 0;
    while I < FInstanceList.Count do
    begin
      Instance := FInstanceList[I];
      if Instance.GetInterface(IPurgatoryItem, PurgatoryItem) and (not PurgatoryItem.CanDispose) then
        Inc(I)
      else
      begin
        PurgatoryItem := nil;
        FInstanceList.Delete(I);
        RemoveFreeNotification(Instance);
        Instance.DisposeOf;
      end;
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

procedure TFmxObject.BeforeDestruction;
var
  I: Integer;
begin
  { NotifList }
  Include(FObjectState, CallingFreeNotify);
  if FNotifyList <> nil then
  begin
    for I := FNotifyList.Count - 1 downto 0 do
      IFreeNotification(FNotifyList[I]).FreeNotification(Self);
    FreeAndNil(FNotifyList);
  end;
  inherited;
end;

destructor TFmxObject.Destroy;
begin
  if (Application <> nil) and (Action <> nil) then
    Application.UnregisterActionClient(Self);
  FActionLink.DisposeOf;
  FActionLink := nil;
  SetActionClient(False);
  { Remove from ResorcesList }
  if StyleName <> '' then
    RemoveFromResourcePool;
  { Remove from parent's children list }
  if FParent <> nil then
    FParent.RemoveObject(Self);
  FRoot := nil;
  DeleteChildren;
  if FChildrenList <> nil then
    FChildrenList.Free;
  FreeAndNil(FStyleObjectsDict);
  inherited;
end;

function TFmxObject.GetActionClient: Boolean;
begin
  Result := FActionClient;
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
    if (Application <> nil) and (Action <> nil) then
      Application.UnregisterActionClient(Self);
    if vPurgatory <> nil then
    begin
      Parent := nil;
      Include(FObjectState, CallingRelease);
      vPurgatory.Add(Self);
    end
    else
      raise EInvalidOperation.CreateFMT(SNotInstance, ['TPurgatory']);
  end;
end;

function TFmxObject.Released: Boolean;
begin
  Result := (csDestroying in ComponentState) or ([CallingFreeNotify, CallingRelease] * FObjectState <> []);
end;

function TFmxObject.ItemClass: string;
begin
  Result := '';
end;

procedure TFmxObject.AddFreeNotify(const AObject: IFreeNotification);
begin
  if (AObject <> nil) and not (CallingFreeNotify in FObjectState) then
  begin
    if FNotifyList = nil then
      FNotifyList := TList<Pointer>.Create;
    FNotifyList.Add(Pointer(AObject));
  end;
end;

procedure TFmxObject.RemoveFreeNotify(const AObject: IFreeNotification);
begin
  if not (CallingFreeNotify in FObjectState) and (FNotifyList <> nil) then
    FNotifyList.Remove(Pointer(AObject));
end;

procedure TFmxObject.Notification(AComponent: TComponent; Operation: TOperation);
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
  if (FChildren <> nil) and InRange(Index, 0, FChildren.Count - 1) then
    RemoveObject(FChildren[Index]);
end;

procedure TFmxObject.ResetChildrenIndicesSpan(const First, Last: Integer);
var
  I: Integer;
begin
  if (FChildren <> nil) and (First >= 0) and (Last < FChildren.Count) then
    for I := First to Last do
      FChildren[I].FIndex := -1;
end;

procedure TFmxObject.ResetChildrenIndices;
begin
  if FChildren <> nil then
    ResetChildrenIndicesSpan(0, FChildren.Count - 1);
end;

procedure TFmxObject.FreeNotification(AObject: TObject);
begin
  if AObject is TComponent then
    Notification(TComponent(AObject), opRemove);
end;

function TFmxObject.IsChild(AObject: TFmxObject): Boolean;
begin
  Result := False;
  while not Result and (AObject <> nil) do
  begin
    Result := AObject.Equals(Self);
    if not Result then
      AObject := AObject.Parent;
  end;
end;

function IsUniqueGlobalNameProc(const Name: string): Boolean;
begin
  if Length(Name) = 0 then
    Result := True
  else
    Result := FindGlobalComponent(Name) = nil;
end;

function TFmxObject.Clone(const AOwner: TComponent): TFmxObject;
var
  S: TStream;
  SaveName: string;
  Reader: TFmxReader;
  SavedIsUniqueGlobalComponentName: TIsUniqueGlobalComponentName;
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
    SavedIsUniqueGlobalComponentName := IsUniqueGlobalComponentNameProc;
    IsUniqueGlobalComponentNameProc := IsUniqueGlobalNameProc;
    try
      Reader := TFmxReader.Create(S, 4096);
      try
        BeginGlobalLoading;
        try
          Result := TFmxObject(Reader.ReadRootComponent(nil));
          NotifyGlobalLoading;
        finally
          EndGlobalLoading;
        end;

        if AOwner <> nil then
          AOwner.InsertComponent(Result);
      finally
        Reader.Free;
        if Result = nil then
          Result := TFmxObjectClass(ClassType).Create(AOwner);
      end;
    finally
      IsUniqueGlobalComponentNameProc := SavedIsUniqueGlobalComponentName;
    end;
  finally
    S.Free;
  end;
end;

function TFmxObject.ContainsObject(AObject: TFmxObject): Boolean;
begin
  if FChildren <> nil then
    Result := FChildren.Contains(AObject)
  else
    Result := False;
end;

function TFmxObject.SupportsPlatformService(const AServiceGUID: TGUID; out AService): Boolean;
begin
  if TPlatformServices.Current.SupportsPlatformService(AServiceGUID, AService) then
    Result := True
  else
  begin
    Pointer(AService) := nil;
    Result := False;
  end;
end;

procedure TFmxObject.DoRootChanged;
begin

end;

procedure TFmxObject.DoRootChanging(const NewRoot: IRoot);
begin

end;

procedure TFmxObject.SetRoot(ARoot: IRoot);
var
  I: Integer;
  OldRoot, LRoot: IRoot;
begin
  if FRoot <> ARoot then
  begin
    DoRootChanging(ARoot);
    OldRoot := FRoot;
    try
      FRoot := ARoot;
      if not GetInterface(IRoot, LRoot) and (FChildren <> nil) then
        for I := 0 to FChildren.Count - 1 do
          FChildren[I].SetRoot(FRoot);
      DoRootChanged;
    except
      FRoot := OldRoot;
      if (FChildren <> nil) and (FChildren.Count > 0) then
        for I := 0 to FChildren.Count - 1 do
          FChildren[I].SetRoot(FRoot);
      raise;
    end;
  end;
end;

procedure TFmxObject.ChangeChildren;
begin
  FreeAndNil(FStyleObjectsDict);
end;

procedure TFmxObject.ChangeOrder;
begin
  if not (csLoading in ComponentState) and (Parent <> nil) then
    Parent.ChangeChildren;
end;

procedure TFmxObject.ParentChanged;
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
    if FParent <> nil then
      FParent.RemoveObject(Self);
    if Value <> nil then
      Value.AddObject(Self)
    else
      FParent := Value;
  end;
end;

function TFmxObject.GetChildrenCount: Integer;
begin
  if FChildrenList <> nil then
    Result := FChildrenList.Count
  else
    Result := 0;
end;

procedure TFmxObject.SetParentComponent(Value: TComponent);
var
  R: IRoot;
begin
  inherited;
  if FParent <> nil then
    FParent.RemoveObject(Self);

  if Value is TFmxObject then
    TFmxObject(Value).AddObject(Self)
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
  if FChildren <> nil then
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
  if (FParent <> nil) and Supports(FParent, IContent, Content) then
    Result := Content.Parent
  else
    Result := FParent;
  if (Result = nil) and (FRoot <> nil) then
    Result := FRoot.GetObject;
end;

function TFmxObject.HasParent: Boolean;
begin
  Result := FParent <> nil;
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

procedure TFmxObject.IgnoreIdentValue(Reader: TReader);
begin
  Reader.ReadIdent;
end;

procedure TFmxObject.IgnoreFloatValue(Reader: TReader);
begin
  Reader.ReadFloat;
end;

procedure TFmxObject.InitiateAction;
var
  LAction: TCustomAction;
begin
  if FActionLink <> nil then
  begin
    if FActionLink.Action is TCustomAction then
      LAction := TCustomAction(FActionLink.Action)
    else
      LAction := nil;
    if LAction <> nil then
      LAction.Target := Self;
    try
      if not FActionLink.Update then
        UpdateAction(FActionLink.Action);
    finally
      if LAction <> nil then
        LAction.Target := nil;
    end;
  end;
end;

function TFmxObject.GetAction: TBasicAction;
begin
  if FActionLink <> nil then
    Result := FActionLink.Action
  else
    Result := nil;
end;

procedure TFmxObject.SetAction(const Value: TBasicAction);
var
  LClass: TActionLinkClass;
begin
  if Value = nil then
  begin
    if Application <> nil then
      Application.UnregisterActionClient(Self);
    FreeAndNil(FActionLink);
    SetActionClient(False);
  end
  else
  begin
    if FActionLink = nil then
    begin
      LClass := GetActionLinkClass;
      if LClass = nil then
        raise EActionError.CreateFMT(StrEActionNoSuported, [ClassName]);
      FActionLink := LClass.Create(Self);
    end;
    ActionLink.Action := Value;
    ActionLink.OnChange := DoActionChange;
    ActionChange(Value, csLoading in Value.ComponentState);
    Value.FreeNotification(Self);
    SetActionClient(True);
    if Application <> nil then
      Application.RegisterActionClient(Self);
  end;
end;

function TFmxObject.GetActionRoot: TComponent;
begin
  if FRoot <> nil then
    Result := FRoot.GetObject
  else
    Result := nil;
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

function TFmxObject.SearchInto: Boolean;
begin
  Result := True;
end;

procedure TFmxObject.DoInventory(Dict: TDictionary<string, TFmxObject>; const Prefix: string);
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

  if FChildren <> nil then
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
    if Result = nil then
      for Child in FChildren do
      begin
        if Child.SearchInto then
        begin
          Result := Child.FindStyleResource(Name);
          if Result <> nil then
            Exit;
        end;
      end;
  end;

var
  SaveStyleName: string;
  StyleObject: TFmxObject;
begin
  StyleObject := nil;
  if (AStyleLookup <> '') and (FChildren <> nil) and (FChildren.Count > 0) then
  begin
{$IFDEF NOSTYLERESOURCECACHE}
    J := AStyleLookup.IndexOf('.');
    if J >= 0 then
    begin
      // Match substring to the first point of top-level elements
      LName := AStyleLookup.Substring(0, J);
      StyleObject := FindOnTopLevel(LName);
      // Search the rest of string in the element found
      if StyleObject <> nil then
      begin
        LName := AStyleLookup.Substring(J + 1);
        StyleObject := StyleObject.FindStyleResource(LName);
      end;
    end;
    // Match substring after the last dot (old algorithm)
    if StyleObject = nil then
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
  if (StyleObject <> nil) and Clone then
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

procedure TFmxObject.SetStored(const Value: Boolean);
var
  I: Integer;
begin
  if FStored <> Value then
  begin
    FStored := Value;
    if (FChildren <> nil) and (FChildren.Count > 0) then
      for I := 0 to FChildren.Count - 1 do
        TFmxObject(FChildren[I]).Stored := Value;
    if not Stored then
      RemoveFromResourcePool;
  end;
end;

procedure TFmxObject.DoDeleteChildren;
var
  I: Integer;
  Child: TFmxObject;
begin
  if FChildren <> nil then
  begin
    for I := FChildren.Count - 1 downto 0 do
    begin
      Child := FChildren[I];
      FChildren.Delete(I);
      Child.FParent := nil;
      Child.SetRoot(nil);
      Child.DisposeOf;
    end;
    FreeAndNil(FChildren);
    FreeAndNil(FChildrenList);
  end;
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
  if FChildren <> nil then
    for I := 0 to FChildren.Count - 1 do
      FChildren[I].AddObjectsToList(AList);
end;

function TFmxObject.CreateChildrenList(const Children: TFmxObjectList): TFmxChildrenList;
begin
  Result := TFmxChildrenList.Create(Children);
end;

procedure TFmxObject.DoAddObject(const AObject: TFmxObject);
var
  LRoot: IRoot;
begin
  if FChildren = nil then
  begin
    FChildren := TFmxObjectList.Create;
    FChildren.Capacity := 10;
    FChildrenList := CreateChildrenList(FChildren);
  end;
  AObject.FParent := Self;
  if GetInterface(IRoot, LRoot) then
    AObject.SetRoot(LRoot)
  else
    AObject.SetRoot(FRoot);
  FChildren.Add(AObject);
  if csDesigning in ComponentState then
    AObject.SetDesign(True, True);
  AObject.ParentChanged;
  FreeAndNil(FStyleObjectsDict);
end;

procedure TFmxObject.DoRemoveObject(const AObject: TFmxObject);
var
  Idx: Integer;
begin
  if FChildren <> nil then
  begin
    Idx := FChildren.IndexOf(AObject);
    if Idx >= 0 then
    begin
      AObject.FParent := nil;
      AObject.SetRoot(nil);
      if AObject.FIndex >= 0 then
        ResetChildrenIndicesSpan(AObject.FIndex, FChildren.Count - 1);
      FChildren.Delete(Idx);
      AObject.ParentChanged;
      FreeAndNil(FStyleObjectsDict);
    end;
  end;
end;

procedure TFmxObject.AddObject(const AObject: TFmxObject);
begin
  if (AObject <> nil) and (AObject.Parent <> Self) then
  begin
    if AObject.Parent <> nil then
      AObject.Parent := nil;
    DoAddObject(AObject);
  end;
end;

procedure TFmxObject.InsertObject(Index: Integer; const AObject: TFmxObject);
begin
  if (AObject <> nil) and (AObject.Parent <> Self) then
  begin
    if AObject.Parent <> nil then
      AObject.Parent := nil;
    DoInsertObject(Index, AObject);
  end;
end;

procedure TFmxObject.AddToResourcePool;
begin
  if Stored then
    FMX.Types.AddResource(Self);
end;

procedure TFmxObject.AnimateColor(const APropertyName: string; NewValue: TAlphaColor; Duration: Single;
  AType: TAnimationType; AInterpolation: TInterpolationType);
begin
  TAnimator.AnimateColor(Self, APropertyName, NewValue, Duration, AType, AInterpolation);
end;

procedure TFmxObject.AnimateFloat(const APropertyName: string; const NewValue: Single; Duration: Single;
  AType: TAnimationType; AInterpolation: TInterpolationType);
begin
  TAnimator.AnimateFloat(Self, APropertyName, NewValue, Duration, AType, AInterpolation);
end;

procedure TFmxObject.AnimateFloatDelay(const APropertyName: string; const NewValue: Single; Duration, Delay: Single;
  AType: TAnimationType; AInterpolation: TInterpolationType);
begin
  TAnimator.AnimateFloatDelay(Self, APropertyName, NewValue, Duration, Delay, AType, AInterpolation);
end;

procedure TFmxObject.AnimateFloatWait(const APropertyName: string; const NewValue: Single; Duration: Single;
  AType: TAnimationType; AInterpolation: TInterpolationType);
begin
  TAnimator.AnimateFloatWait(Self, APropertyName, NewValue, Duration, AType, AInterpolation);
end;

procedure TFmxObject.AnimateInt(const APropertyName: string; const NewValue: Integer; Duration: Single;
  AType: TAnimationType; AInterpolation: TInterpolationType);
begin
  TAnimator.AnimateInt(Self, APropertyName, NewValue, Duration, AType, AInterpolation);
end;

procedure TFmxObject.AnimateIntWait(const APropertyName: string; const NewValue: Integer; Duration: Single;
  AType: TAnimationType; AInterpolation: TInterpolationType);
begin
  TAnimator.AnimateIntWait(Self, APropertyName, NewValue, Duration, AType, AInterpolation);
end;

procedure TFmxObject.StopPropertyAnimation(const APropertyName: string);
begin
  TAnimator.StopPropertyAnimation(Self, APropertyName);
end;

procedure TFmxObject.RemoveFromResourcePool;
begin
  FMX.Types.RemoveResource(Self);
end;

procedure TFmxObject.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    RemoveFromResourcePool;

    FStyleName := Value;
    if (FStyleName <> '') then
      AddToResourcePool;
  end;
end;

procedure TFmxObject.DoInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  DoAddObject(AObject);
  if FChildren.Count > 0 then
  begin
    FChildren.Insert(Index, FChildren[FChildren.Count - 1]);
    FChildren.Delete(FChildren.Count - 1);
  end;
  ChangeChildren;
  // update index
  ResetChildrenIndicesSpan(Index, FChildren.Count - 1);
end;

procedure TFmxObject.RemoveObject(const AObject: TFmxObject);
begin
  if AObject <> nil then
    DoRemoveObject(AObject);
end;

procedure TFmxObject.Sort(Compare: TFmxObjectSortCompare);
var
  Comparer: IComparer<TFmxObject>;
  Comparison: TComparison<TFmxObject>;
begin
  if FChildren <> nil then
  begin
    Comparison := TComparison<TFmxObject>(Compare);
    Comparer := TComparer<TFmxObject>.Construct(Comparison);
    FChildren.Sort(Comparer);
    ChangeChildren;
    // update index
    ResetChildrenIndices;
  end;
end;

function TFmxObject.GetIndexOfChild(const Child: TFmxObject): Integer;
begin
  if Children <> nil then
    Result := Children.IndexOf(Child)
  else
    Result := -1;
end;

function TFmxObject.GetIndex: Integer;
begin
  if (FIndex < 0) and (FParent <> nil) then
    FIndex := FParent.GetIndexOfChild(Self);
  Result := FIndex;
end;

procedure TFmxObject.SetIndexOfChild(const Child: TFmxObject; NewIndex: Integer);
begin
  if (FChildren <> nil) and (FChildren.IndexOf(Child) >= 0) then
  begin
    FChildren.Remove(Child);
    if NewIndex < 0 then
      NewIndex := 0;
    if NewIndex > FChildren.Count then
      NewIndex := FChildren.Count;
    FChildren.Insert(NewIndex, Child);
    // recalc Index
    ResetChildrenIndices;
    Child.ChangeOrder;
  end;
end;

procedure TFmxObject.SetIndex(NewIndex: Integer);
begin
  if (Parent <> nil) and (GetIndex <> NewIndex) then
    Parent.SetIndexOfChild(Self, NewIndex);
end;

procedure TFmxObject.EnumObjects(const Proc: TFunc<TFmxObject, TEnumProcResult>);
  procedure EnumChildObjects(const AParentObject: TFmxObject; var ProcResult: TEnumProcResult);
  var
    I: Integer;
    Obj: TFmxObject;
  begin
    if AParentObject.Children <> nil then
      for I := 0 to AParentObject.Children.Count - 1 do
      begin
        Obj := AParentObject.Children[I];
        ProcResult := Proc(Obj);
        if ProcResult = TEnumProcResult.Continue then
          EnumChildObjects(Obj, ProcResult);
        if ProcResult = TEnumProcResult.Stop then
          Break;
        if ProcResult = TEnumProcResult.Discard then
          ProcResult := TEnumProcResult.Continue;
      end;
  end;

var
  ProcResult: TEnumProcResult;
begin
  ProcResult := TEnumProcResult.Continue;
  EnumChildObjects(Self, ProcResult);
end;

procedure TFmxObject.Exchange(const AObject1, AObject2: TFmxObject);
var
  Idx: Integer;
begin
  if (FChildren <> nil) and (AObject1.Parent = Self) and (AObject2.Parent = Self) then
  begin
    FChildren.Exchange(AObject1.Index, AObject2.Index);
    Idx := AObject1.FIndex;
    AObject1.FIndex := AObject2.Index;
    AObject1.ChangeOrder;
    AObject2.FIndex := Idx;
    AObject2.ChangeOrder;
  end;
end;

procedure TFmxObject.BringChildToFront(const Child: TFmxObject);
var
  Idx: Integer;
begin
  if FChildren <> nil then
  begin
    Idx := FChildren.IndexOf(Child);
    if Idx < FChildren.Count - 1 then
    begin
      FChildren.Remove(Child);
      FChildren.Add(Child);
      // recalc Index
      ResetChildrenIndices;
      Child.ChangeOrder;
    end;
  end;
end;

procedure TFmxObject.BringToFront;
begin
  if Parent <> nil then
    Parent.BringChildToFront(Self);
end;

procedure TFmxObject.SendChildToBack(const Child: TFmxObject);
var
  Idx: Integer;
begin
  if FChildren <> nil then
  begin
    Idx := FChildren.IndexOf(Child);
    if Idx > 0 then
    begin
      FChildren.Remove(Child);
      FChildren.Insert(GetBackIndex, Child);
      // recalc Index
      ResetChildrenIndices;
      Child.ChangeOrder;
    end;
  end;
end;

procedure TFmxObject.SendToBack;
begin
  if Parent <> nil then
    Parent.SendChildToBack(Self);
end;

{ TTabList }
constructor TTabList.Create(const TabStopController: ITabStopController);
begin
  inherited Create(TabStopController);
end;

destructor TTabList.Destroy;
begin
  FTabList.Free;
  inherited Destroy;
end;

procedure TTabList.Clear;
begin
  if FTabList <> nil then
    FTabList.Clear;
end;

procedure TTabList.CreateTabList;
begin
  if FTabList = nil then
    FTabList := TList<IControl>.Create;
end;

function TTabList.IsAddable(const TabStop: IControl): Boolean;
begin
  Result := TabStop.GetObject.Stored and (not Supports(TabStop, IContent));
end;

procedure TTabList.Add(const TabStop: IControl);
begin
  if IsAddable(TabStop) then
  begin
    CreateTabList;
    FTabList.Add(TabStop);
  end;
end;

procedure TTabList.Remove(const TabStop: IControl);
begin
  if FTabList <> nil then
    FTabList.Remove(TabStop);
end;

procedure TTabList.Update(const TabStop: IControl; const NewValue: TTabOrder);
var
  OldValue: TTabOrder;
  I: Integer;
  OldCount: Integer;
  TempControl: IControl;
begin
  CreateTabList;

  if NewValue <> -1 then
  begin
    if IndexOf(TabStop) = -1 then
      Add(TabStop);

    if NewValue >= FTabList.Count then
    begin
      OldCount := FTabList.Count;
      FTabList.Count := NewValue + 1;
      for I := OldCount to FTabList.Count - 1 do
        FTabList[I] := nil;
    end;

    OldValue := GetTabOrder(TabStop);

    if (NewValue >= 0) and (NewValue < FTabList.Count) and (OldValue >= 0) then
    begin
      TempControl := FTabList[OldValue];
      FTabList.Delete(OldValue);
      if (NewValue < FTabList.Count) and (FTabList[NewValue] = nil) then
        FTabList[NewValue] := TempControl
      else
        FTabList.Insert(NewValue, TempControl);
    end;
  end
  else
    Remove(TabStop);
end;

function TTabList.FindNextTabStop(const Current: IControl; const MoveForward: Boolean; const Climb: Boolean): IControl;

  function Advance(const X: Integer; const Size: Integer; const MoveForward: Boolean; const Ring: Boolean): Integer;
  const
    AdvanceAdd: array [Boolean] of Integer = (-1, 1);
  begin
    Result := X + AdvanceAdd[MoveForward];
    if Ring then
    begin
      if Result < 0 then
        Result := Size - 1
      else if Result >= Size then
        Result := 0;
    end
    else
      if (Result < 0) or (Result >= Size) then
        Result := -1;
  end;

  function IsTabStop(const C: IControl): Boolean;
  begin
    Result := (C <> nil) and C.CheckForAllowFocus and C.TabStop;
  end;

  function NextTabStop(Initial: IControl; TabIndex: Integer): IControl;
  var
    AsNode: ITabStopController;
    I: Integer;
  begin
    Result := Initial;
    // If result is satisfactory, exit immediately
    if IsTabStop(Result) then
      Exit(Result);
    // If we're climbing up, the current result is to be taken as starting point
    if (not Climb) and (Current <> nil) then
      Result := Current;

    for I := 0 to GetCount do
    begin
      if Supports(Result, ITabStopController, AsNode) then
        Result := AsNode.TabList.FindNextTabStop(nil, MoveForward, False);
      if Result = nil then
      begin
        TabIndex := Advance(TabIndex, GetCount, MoveForward, ParentIsRoot);
        if TabIndex = -1 then
          Break
        else
          Result := GetItem(TabIndex);
      end;
      if IsTabStop(Result) then
        Break;
   end;
  end;

  function PrevTabStop(Initial: IControl; TabIndex: Integer): IControl;
  var
    AsNode: ITabStopController;
    Nested: IControl;
    I: Integer;
  begin
    Result := Initial;
    // Result = rightmost or current
    for I := 0 to GetCount do
    begin
      // go as deep as we can down the rightmost branch
      if Supports(Result, ITabStopController, AsNode) then
        Nested := AsNode.TabList.FindNextTabStop(nil, False, False);
      if Nested <> nil then
        Exit(Nested)
      else
      begin
        if not IsTabStop(Result) then
        begin
          TabIndex := Advance(TabIndex, GetCount, False, ParentIsRoot);
          if TabIndex = -1 then
            if Climb then
              Exit(Current)
            else
              Exit(nil)
          else
            Result := GetItem(TabIndex)
        end;
      end;
      if IsTabStop(Result) then
        Break;
    end;
  end;

var
  TabIndex: Integer;
begin
  Result := nil;
  if GetCount = 0 then
    Exit;

  // If Current = nil: find a starting point
  if Current = nil then
  begin
    if MoveForward then
      TabIndex := 0
    else
      TabIndex := GetCount - 1;
    Result := GetItem(TabIndex);
  end
  else
    TabIndex := IndexOf(Current);

  if MoveForward then
    Result := NextTabStop(Result, TabIndex)
  else
    Result := PrevTabStop(Result, TabIndex);
  if not IsTabStop(Result) then
    Result := nil;
end;

function TTabList.IndexOf(const TabStop: IControl): Integer;
begin
  if FTabList <> nil then
    for Result := 0 to FTabList.Count - 1 do
      if FTabList[Result] = TabStop then
        Exit;
  Result := -1;
end;

function TTabList.ParentIsRoot: Boolean;
begin
  Result := not Supports(Controller, IControl);
end;

function TTabList.GetCount: Integer;
begin
  if FTabList = nil then
    Exit(0);
  Result := FTabList.Count;
end;

function TTabList.GetItem(const Index: Integer): IControl;
begin
  if FTabList = nil then
    Exit(nil);
  Result := FTabList[Index];
end;

function TTabList.GetTabOrder(const TabStop: IControl): TTabOrder;
begin
  Result := IndexOf(TabStop);
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
  if FAutoSelect and TPlatformServices.Current.SupportsPlatformService(IFMXLocaleService, LocaleSvc) then
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
  if not TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, FPlatformTimer) then
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
  if TMethod(Value) = TMethod(FOnTimer) then
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

procedure RecalcAnchorRules(const Parent : TFmxObject; Anchors : TAnchors; const BoundsRect : TRectF;
  var AOriginalParentSize:TPointF; var AAnchorOrigin:TPointF; var AAnchorRules:TPointF);
var
  Rect : TRectF;
begin
  Rect := BoundsRect;
  AAnchorOrigin := TPointF.Create(Rect.Left + Rect.Width / 2, Rect.Top + Rect.Height / 2);
  if Anchors = [TAnchorKind.akLeft, TAnchorKind.akTop] then
  begin
    AOriginalParentSize.X := 0;
    AOriginalParentSize.Y := 0;
    Exit;
  end;
  if TAnchorKind.akRight in Anchors then
    if TAnchorKind.akLeft in Anchors then
      AAnchorRules.X := Rect.Width
    else
      AAnchorRules.X := Rect.Left
  else
    AAnchorRules.X := Rect.Left + Rect.Width/2;
  if TAnchorKind.akBottom in Anchors then
    if TAnchorKind.akTop in Anchors then
      AAnchorRules.Y := Rect.Height
    else
      AAnchorRules.Y := Rect.Top
  else
    AAnchorRules.Y := Rect.Top + Rect.Height/2;
end;

procedure RecalcControlOriginalParentSize(const Parent: TFmxObject; ComponentState : TComponentState;
  const Anchoring: Boolean; var AOriginalParentSize : TPointF);
var
  Alignable : IAlignableObject;
  Container : IContainerObject;
  OriginalSize: IOriginalContainerSize;
  R : TRectF;
begin
  if Supports(Parent, IAlignableObject, Alignable) then
    R := TRectF.Create(TPointF.Create(Alignable.Left, Alignable.Top), Alignable.Width, Alignable.Height)
  else if Supports(Parent, IOriginalContainerSize, OriginalSize) and not Anchoring then
  begin
    R.TopLeft := TPointF.Zero;
    R.BottomRight := OriginalSize.OriginalContainerSize;
  end
  else if Supports(Parent, IContainerObject, Container) then
    R := TRectF.Create(0, 0, Container.ContainerWidth, Container.ContainerHeight)
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
end;

{ TGuillotineBinPack }

constructor TGuillotineBinPack.Create;
begin
  inherited;
  FSupportsRectangleInversion := False;
  FUsedRectangles := TList<TRect>.Create;
  FFreeRectangles := TList<TRect>.Create;
end;

constructor TGuillotineBinPack.Create(const ASize: TPoint);
begin
  Create;
  Init(ASize);
end;

destructor TGuillotineBinPack.Destroy;
begin
  FUsedRectangles.Free;
  FFreeRectangles.Free;
  inherited;
end;

function TGuillotineBinPack.ScoreByHeuristic(const NodeSize: TPoint; const FreeRect: TRect;
  const Heuristic: TFreeChoiceHeuristic): Integer;

  function ScoreBestAreaFit(const ASize: TPoint; const ARect: TRect): Integer; inline;
  begin
    Result := ARect.Width * ARect.Height - ASize.X * ASize.Y;
  end;

  function ScoreBestShortSideFit(const ASize: TPoint; const ARect: TRect): Integer; inline;
  begin
    Result := Min(Abs(ARect.Width - ASize.X), Abs(ARect.Height - ASize.Y));
  end;

  function ScoreBestLongSideFit(const ASize: TPoint; const ARect: TRect): Integer; inline;
  begin
    Result := Max(Abs(ARect.Width - ASize.X), Abs(ARect.Height - ASize.Y));
  end;

begin
  case Heuristic of
    TFreeChoiceHeuristic.BestAreaFit:
      Result := ScoreBestAreaFit(NodeSize, FreeRect);
    TFreeChoiceHeuristic.BestShortSideFit:
      Result := ScoreBestShortSideFit(NodeSize, FreeRect);
    TFreeChoiceHeuristic.BestLongSideFit:
      Result := ScoreBestLongSideFit(NodeSize, FreeRect);
    TFreeChoiceHeuristic.WorstAreaFit:
      Result := -ScoreBestAreaFit(NodeSize, FreeRect);
    TFreeChoiceHeuristic.WorstShortSideFit:
      Result := -ScoreBestShortSideFit(NodeSize, FreeRect);
    TFreeChoiceHeuristic.WorstLongSideFit:
      Result := -ScoreBestLongSideFit(NodeSize, FreeRect);
  else
    Result := 0;
  end;
end;

procedure TGuillotineBinPack.FindPositionForNewNode(const NodeSize: TPoint;
  const Heuristic: TFreeChoiceHeuristic; out NodeIndex: Integer; out NodeRect: TRect);
var
  BestNode: TRect;
  BestScore, Score: Integer;
  I, BestIndex: Integer;
begin
  BestNode := TRect.Empty;
  BestScore := Integer.MaxValue;
  BestIndex := -1;

  for I := 0 to FFreeRectangles.Count - 1 do
  begin
    // If this is a perfect fit upright, choose it immediately.
    if (NodeSize.X = FFreeRectangles[I].Width) and (NodeSize.Y = FFreeRectangles[I].Height) then
    begin
      NodeRect := TRect.Create(FFreeRectangles[I].TopLeft, NodeSize.X, NodeSize.Y);
      NodeIndex := I;
      Exit;
    end
    else if FSupportsRectangleInversion and (NodeSize.Y = FFreeRectangles[I].Width) and
      (NodeSize.X = FFreeRectangles[I].Height) then
    begin
      NodeRect := TRect.Create(FFreeRectangles[I].TopLeft, NodeSize.Y, NodeSize.X);
      NodeIndex := I;
      Exit;
    end
    else if (NodeSize.X <= FFreeRectangles[I].Width) and (NodeSize.Y <= FFreeRectangles[I].Height) then
    begin
      Score := ScoreByHeuristic(NodeSize, FFreeRectangles[I], Heuristic);
      if Score < BestScore then
      begin
        BestNode := TRect.Create(FFreeRectangles[I].TopLeft, NodeSize.X, NodeSize.Y);
        BestScore := Score;
        BestIndex := I;
      end;
    end
    else if FSupportsRectangleInversion and (NodeSize.Y <= FFreeRectangles[I].Width) and
      (NodeSize.X <= FFreeRectangles[I].Height) then
    begin
      Score := ScoreByHeuristic(NodeSize, FFreeRectangles[I], Heuristic);
      if Score < BestScore then
      begin
        BestNode := TRect.Create(FFreeRectangles[I].TopLeft, NodeSize.Y, NodeSize.X);
        BestScore := Score;
        BestIndex := I;
      end;
    end;
  end;

  NodeRect := BestNode;
  NodeIndex := BestIndex;
end;

procedure TGuillotineBinPack.Init(const ASize: TPoint);
begin
  FSize := ASize;
  FUsedRectangles.Clear;
  FFreeRectangles.Clear;
  FFreeRectangles.Add(TRect.Create(0, 0, FSize.X, FSize.Y));
  FUsedRectangleArea := 0;
end;

procedure TGuillotineBinPack.MergeFreeList;
var
  I, J: Integer;
begin
  // Do a Theta(n^2) loop to see if any pair of free rectangles could me merged into one.
  // Note that we miss any opportunities to merge three rectangles into one. (should call this function again to detect that)
  J := 0;
  while J < FFreeRectangles.Count - 1 do
  begin
    I := J + 1;
    while I < FFreeRectangles.Count do
    begin
      if (FFreeRectangles[J].Width = FFreeRectangles[I].Width) and
        (FFreeRectangles[J].Left = FFreeRectangles[I].Left) then
      begin
        if FFreeRectangles[J].Top = FFreeRectangles[I].Bottom then
        begin
          FFreeRectangles.List[J].Top := FFreeRectangles[J].Top - FFreeRectangles[I].Height;
          FFreeRectangles.List[J].Height := FFreeRectangles[J].Height + FFreeRectangles[I].Height;
          FFreeRectangles.Delete(I);
          Dec(I);
        end
        else if FFreeRectangles[J].Bottom = FFreeRectangles[I].Top then
        begin
          FFreeRectangles.List[J].Height := FFreeRectangles[J].Height + FFreeRectangles[I].Height;
          FFreeRectangles.Delete(I);
          Dec(I);
        end;
      end
      else if ((FFreeRectangles[J].Height = FFreeRectangles[I].Height) and
        (FFreeRectangles[J].Top = FFreeRectangles[I].Top)) then
      begin
        if FFreeRectangles[J].Left = FFreeRectangles[I].Right then
        begin
          FFreeRectangles.List[J].Left := FFreeRectangles[J].Left - FFreeRectangles[I].Width;
          FFreeRectangles.List[J].Width := FFreeRectangles[J].Width + FFreeRectangles[I].Width;
          FFreeRectangles.Delete(I);
          Dec(I);
        end
        else if FFreeRectangles[J].Right = FFreeRectangles[I].Left then
        begin
          FFreeRectangles.List[J].Width := FFreeRectangles[J].Width + FFreeRectangles[I].Width;
          FFreeRectangles.Delete(I);
          Dec(I);
        end;
      end;
      Inc(I);
    end;
    Inc(J);
  end;
end;

procedure TGuillotineBinPack.SplitFreeRectAlongAxis(const FreeRect, PlacedRect: TRect; const SplitHorizontal: Boolean);
var
  LBottom, LRight: TRect;
begin
  LBottom.Left := FreeRect.Left;
  LBottom.Top := FreeRect.Top + PlacedRect.Height;
  LBottom.Height := FreeRect.Height - PlacedRect.Height;

  LRight.Left := FreeRect.Left + PlacedRect.Width;
  LRight.Top := FreeRect.Top;
  LRight.Width := FreeRect.Width - PlacedRect.Width;

  if SplitHorizontal then
  begin
    LBottom.Width := FreeRect.Width;
    LRight.Height := PlacedRect.Height;
  end
  else // Split vertically
  begin
    LBottom.Width := PlacedRect.Width;
    LRight.Height := FreeRect.Height;
  end;

  // Add the new rectangles into the free rectangle pool if they weren't degenerate.
  if not LBottom.IsEmpty then
    FFreeRectangles.Add(LBottom);
  if not LRight.IsEmpty then
    FFreeRectangles.Add(LRight);
end;

procedure TGuillotineBinPack.SplitFreeRectByHeuristic(const FreeRect, PlacedRect: TRect;
  const AMethod: TSplitMethodHeuristic);
var
  W, H: Integer;
  Horizontal: Boolean;
begin
  // Compute the lengths of the leftover area.
  W := FreeRect.Width - PlacedRect.Width;
  H := FreeRect.Height - PlacedRect.Height;

  case AMethod of
    TSplitMethodHeuristic.ShorterLeftoverAxis:
      // Split along the shorter leftover axis.
      Horizontal := W <= H;
    TSplitMethodHeuristic.LongerLeftoverAxis:
      // Split along the longer leftover axis.
      Horizontal := W > H;
    TSplitMethodHeuristic.MinimizeArea:
      // Maximize the larger area == minimize the smaller area.
      // Tries to make the single bigger rectangle.
      Horizontal := PlacedRect.Width * H > W * PlacedRect.Height;
    TSplitMethodHeuristic.MaximizeArea:
      // Maximize the smaller area == minimize the larger area.
      // Tries to make the rectangles more even-sized.
      Horizontal := PlacedRect.Width * H <= W * PlacedRect.Height;
    TSplitMethodHeuristic.ShorterAxis:
      // Split along the shorter total axis.
      Horizontal := FreeRect.Width <= FreeRect.Height;
    TSplitMethodHeuristic.LongerAxis:
      // Split along the longer total axis.
      Horizontal := FreeRect.Width > FreeRect.Height;
  else
    Horizontal := True;
  end;
  // Perform the actual split.
  SplitFreeRectAlongAxis(FreeRect, PlacedRect, Horizontal);
end;

function TGuillotineBinPack.Insert(const NodeSize: TPoint; const Merge: Boolean;
  const FreeChoice: TFreeChoiceHeuristic; const SplitMethod: TSplitMethodHeuristic): TRect;
var
  FreeNodeIndex: Integer;
begin
  // Find where to put the new rectangle.
  FreeNodeIndex := 0;
  FindPositionForNewNode(NodeSize, FreeChoice, FreeNodeIndex, Result);

  // Abort if we didn't have enough space in the bin.
  if Result.IsEmpty then
    Exit;

  // Remove the space that was just consumed by the new rectangle.
  SplitFreeRectByHeuristic(FFreeRectangles[FreeNodeIndex], Result, SplitMethod);
  FFreeRectangles.Delete(FreeNodeIndex);

  // Perform a Rectangle Merge step if desired.
  if Merge then
    MergeFreeList;

  // Remember the new used rectangle.
  FUsedRectangles.Add(Result);
  Inc(FUsedRectangleArea, Result.Width * Result.Height);
end;

/// Computes the ratio of used surface area to the total bin area.
function TGuillotineBinPack.GetOccupancy: Single;
begin
  if not FSize.IsZero then
    Result := FUsedRectangleArea / (FSize.X * FSize.Y)
  else
    Result := 0;
end;

{ TCustomPopupMenu }

procedure TCustomPopupMenu.DoPopup;
begin
  if Assigned(OnPopup) then
    OnPopup(Self);
end;

{ TCustomTouchManager.TObjectWrapper }

constructor TCustomTouchManager.TObjectWrapper.Create(const AObject: TComponent);
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

procedure TCustomTouchManager.ChangeNotification(const AControl: TComponent);
begin
end;

constructor TCustomTouchManager.Create(AControl: TComponent);
begin
  inherited Create;
  FControl := AControl;
  FGestureEngine := nil;
  FGestureManager := nil;
  FDefaultInteractiveGestures := [];
end;

destructor TCustomTouchManager.Destroy;
begin
  if GestureEngine <> nil then
  begin
    GestureEngine.DisposeOf;
    GestureEngine := nil;
  end;

  if FGestureManager <> nil then
    SetGestureManager(nil);

  inherited;
end;

function TCustomTouchManager.FindGesture(const AName: string): TCustomGestureCollectionItem;
begin
  Result := nil;
  if FGestureManager <> nil then
    Result := FGestureManager.FindGesture(FControl, AName);
end;

function TCustomTouchManager.FindGesture(AGestureID: TGestureID): TCustomGestureCollectionItem;
begin
  Result := nil;
  if FGestureManager <> nil then
    Result := FGestureManager.FindGesture(FControl, AGestureID);
end;

function TCustomTouchManager.GetGestureList: TGestureArray;
begin
  Result := nil;
  if FGestureManager <> nil then
    Result := FGestureManager.GestureList[FControl];
end;

function TCustomTouchManager.GetStandardGestures: TStandardGestures;
begin
  if FGestureManager <> nil then
    FStandardGestures := FGestureManager.StandardGestures[FControl];
  Result := FStandardGestures;
end;

function TCustomTouchManager.IsDefault: Boolean;
begin
  Result := (FGestureManager = nil) and not IsInteractiveGesturesStored;
end;

function TCustomTouchManager.IsInteractiveGesturesStored: Boolean;
begin
  Result := InteractiveGestures <> FDefaultInteractiveGestures;
end;

procedure TCustomTouchManager.RemoveChangeNotification(const AControl: TComponent);
begin
end;

function TCustomTouchManager.SelectGesture(const AName: string): Boolean;
begin
  Result := False;
  if FGestureManager <> nil then
    Result := FGestureManager.SelectGesture(FControl, AName);
end;

function TCustomTouchManager.SelectGesture(AGestureID: TGestureID): Boolean;
begin
  Result := False;
  if FGestureManager <> nil then
    Result := FGestureManager.SelectGesture(FControl, AGestureID);
end;

procedure TCustomTouchManager.SetGestureEngine(const Value: TCustomGestureEngine);
begin
  if (Value <> FGestureEngine) and (FControl is TComponent) then
  begin
    FGestureEngine := Value;
    if (FControl <> nil) and (FGestureEngine <> nil) then
      FGestureEngine.Active := True;
  end;
end;

procedure TCustomTouchManager.SetGestureManager(const Value: TCustomGestureManager);
begin
  if Value <> FGestureManager then
  begin
    if FGestureManager <> nil then
    begin
//      FGestureManager.RemoveFreeNotification(FControl);
      FGestureManager.UnregisterControl(FControl);
      FGestureManager := nil; // Must be set to nil before calling RegisterControl!!
    end;
    if Value <> nil then
    begin
 //     Value.FreeNotification(FControl); //TODO: gestures
      Value.RegisterControl(FControl);
    end;
    FGestureManager := Value; // Must be assigned after registering the control!!
  end;
end;

procedure TCustomTouchManager.SetInteractiveGestures(const Value: TInteractiveGestures);
var
  Difference: TInteractiveGestures;
  Gesture: TInteractiveGesture;
  OwnerForm: TComponent;
begin
  OwnerForm := Self.FControl;
  while (OwnerForm <> nil) and not (OwnerForm is TCommonCustomForm) do
    OwnerForm := OwnerForm.Owner;

  if OwnerForm <> nil then
  begin
    Difference := [];
    Difference := Value - FInteractiveGestures;
    for Gesture in Difference do
      TCommonCustomForm(OwnerForm).AddRecognizer(Gesture);

    Difference := FInteractiveGestures - Value;
    for Gesture in Difference do
      TCommonCustomForm(OwnerForm).RemoveRecognizer(Gesture);
  end;

  if Value <> FInteractiveGestures then
  begin
    FInteractiveGestures := Value;
  end;
end;

procedure TCustomTouchManager.SetStandardGestures(const Value: TStandardGestures);
begin
   if Value <> FStandardGestures then
  begin
    FStandardGestures := Value;
    if FGestureManager <> nil then
      FGestureManager.StandardGestures[FControl] := FStandardGestures;
  end;
end;

procedure TCustomTouchManager.UnselectGesture(AGestureID: TGestureID);
begin
  if FGestureManager <> nil then
    FGestureManager.UnselectGesture(FControl, AGestureID);
end;

{ TCustomGestureEngine }

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
  VirtualKeyboardState: TVirtualKeyboardStates;
begin
  if @vShowVKProc <> @ShowVirtualKeyboard then
  begin
    try
      VirtualKeyboardState := [];
      try
        if Assigned(vShowVKProc) and vOldDisplayed and (vKBTimer <> nil) then
          vShowVKProc(False, vActiveCaret, VirtualKeyboardState);
      finally
        vShowVKProc := nil;
      end;
      vShowVKProc := ShowVirtualKeyboard;
      if Assigned(vShowVKProc) and vOldDisplayed and (vKBTimer <> nil) then
        vShowVKProc(True, vActiveCaret, VirtualKeyboardState);
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
  VirtualKeyboardStates: TVirtualKeyboardStates;
begin
  Enabled := False;
  NewDisplayed := (vActiveCaret <> nil) and vActiveCaret.Displayed and not vActiveCaret.ReadOnly;
  try
    if Assigned(vShowVKProc) then
    begin
      VirtualKeyboardStates := [];
      if NewDisplayed then
      begin
        VirtualKeyboardStates := [TVirtualKeyboardState.Transient];
        vShowVKProc(not NewDisplayed, vActiveCaret, VirtualKeyboardStates);
      end;
      vShowVKProc(NewDisplayed, vActiveCaret, VirtualKeyboardStates);
    end;
  finally
    VirtualKeyboardStates := VirtualKeyboardStates - [TVirtualKeyboardState.Transient];
    vOldDisplayed := NewDisplayed and (TVirtualKeyboardState.Visible in VirtualKeyboardStates);
  end;
end;

{ TDisplay }

constructor TDisplay.Create(const AIndex: Integer; const APrimary: Boolean; const ABounds, AWorkArea: TRect);
begin
  FIndex := AIndex;
  FPrimary := APrimary;
  FBoundsRect := ABounds;
  FWorkAreaRect := AWorkArea;
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
    if CaretClass <> nil then
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
    if CaretClass <> nil then
    begin
      Name := Trim(CaretClass.FlasherName);
      if (Name <> '') and (vFlashers <> nil) then
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
    if FlasherClass <> nil then
    begin
      P := FlasherClass.GetInterfaceEntry(IFlasher);
      if P = nil then
        raise EArgumentNilException.CreateFMT(SUnsupportedInterface, [FlasherClass.ClassName, 'IFlasher']);
    end;
    if (vFlashers = nil) and (FlasherClass = nil) then
      Exit;

    if vFlashers = nil then
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
        if RegisteredFlasher.FlasherClass <> nil then
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
      Result := vFlashers[Index].Flasher <> nil;
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
      if RegisteredFlasher.FlasherClass = nil then
        raise EClassNotFound.Create(SFlasherNotRegistered);
      if RegisteredFlasher.Flasher = nil then
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
  if AOwner = nil then
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
    if vKBTimer <> nil then
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
    if LFlasher <> nil then
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
  LParent: TFmxObject;
begin
  Result := (FIControl.Visible) and
            (FIControl.Enabled) and
            (FIControl.IsFocused) and
            ([csLoading, csDestroying] * FOwner.ComponentState = []);
  if Result then
  begin
    LParent := FOwner;
    while (LParent <> nil) and (not (LParent is TCommonCustomForm)) do
      LParent := LParent.Parent;
    if (LParent is TCommonCustomForm) then
      Result := TCommonCustomForm(LParent).Active
    else
      Result := False;
  end;
end;

procedure TCustomCaret.DoDisplayChanged(const VirtualKeyboardState: TVirtualKeyboardStates);
begin
  if Assigned(FOnDisplayChanged) then
    FOnDisplayChanged(self, VirtualKeyboardState);
end;

procedure TCustomCaret.DoUpdateFlasher;
begin
  //  NewVisible := Visible and Displayed and (not TemporarilyHidden);
  if Flasher <> nil then
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
  if vKBTimer = nil then
    vKBTimer := TKBTimer.Create(nil);
  if vKBTimer <> nil then
    vKBTimer.Enabled := True;
end;

procedure TCustomCaret.Show;
var
  VirtualKeyboardState: TVirtualKeyboardStates;
  LVisible: Boolean;
  LFlasherClass: TFmxObjectClass;
begin
  LVisible := FVisible and CanShow;
  if LVisible then
  begin
    if (vActiveCaret <> nil) and (vActiveCaret <> self) then
      vActiveCaret.Hide;
    try
      LFlasherClass := FlasherClass(TCaretClass(ClassType));
      if (LFlasherClass <> nil) and (Flasher <> nil) and (not Displayed) then
      begin
        StartTimer;
        FDisplayed := True;
        try
          DoUpdateFlasher;
        finally
          FChanged := False;
          DoDisplayChanged(VirtualKeyboardState);
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
  VirtualKeyboardState: TVirtualKeyboardStates;
begin
  try
    if Displayed then
    begin
      try
        if vKBTimer <> nil then
          vKBTimer.Enabled := True;
      finally
        FDisplayed := False;
        try
          DoUpdateFlasher;
        finally
          FChanged := False;
          DoDisplayChanged(VirtualKeyboardState);
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
  if (Source = nil) or (Source is TCustomCaret) then
  begin
    BeginUpdate;
    try
      if Source <> nil then
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

{ Initialization and finalization
  UnregisterAliases; }

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
  if ResourceDict <> nil then
  begin
    for List in ResourceDict.Values do
      List.DisposeOf;
    FreeAndNil(ResourceDict);
  end;

  FreeAndNil(ResourceProcs);
  FreeAndNil(CollectLang);
  FreeAndNil(Lang);
  FreeCloneCache;
  FreeAndNil(vKBTimer);
  if vFlashers <> nil then
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
var
  Caption: ICaption;
  Content: IContent;
begin
  Result := ClassName;
  if Self is TFmxObject then
  begin
    if TFmxObject(Self).Name <> '' then
      Result := Result + ' "' + TFmxObject(Self).Name + '"';

    if Supports(Self, ICaption, Caption) then
      Result := Result + '="' + Caption.Text + '"';

    if Supports(Self, IContent, Content) then
      Result := Format('%s (%d)', [Result, Content.ChildrenCount]);
  end;
end;
{$ENDIF}
{$ENDIF}

{ Log }

class function Log.GetLogger: IInterface;
begin
  if FLogger = nil then
    TPlatformServices.Current.SupportsPlatformService(IFMXLoggingService, FLogger);
  Result := FLogger;
end;

class procedure Log.d(const Fmt: string; const Args: array of const);
begin
  if Logger <> nil then
    IFMXLoggingService(Logger).Log(Fmt, Args);
end;

class procedure Log.d(const Msg: string);
begin
  d(Msg, []);
end;

class procedure Log.d(const Tag: string; const Instance: TObject; const Method, Msg: string);
begin
  if Method.IsEmpty then
    d('%s (%s): %s', [Tag, ObjToString(Instance), Msg])
  else
    d('%s (%s.%s): %s', [Tag, ObjToString(Instance), Method, Msg]);
end;

class procedure Log.d(const Tag: string; const Instance: TObject; const Msg: string);
begin
  Log.d(Tag, Instance, string.Empty, Msg);
end;

class procedure Log.TimeStamp(const Msg: string);
var
  H, M, S, MS: Word;
begin
  DecodeTime(Time, H, M, S, MS);
  d('%d:%d:%d %s', [M, S, MS, Msg]);
end;

class function Log.ObjToString(const Instance: TObject): string;
var
  ClassName: string;
  Addr: NativeInt;
begin
  ClassName := string.Empty;
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

class function Log.ArrayToString(const AArray: TEnumerable<TFmxObject>; const MakeStr: TToStringFunc): string;
var
  Obj: TFmxObject;
  Builder: TStringBuilder;
  NeedComma: Boolean;
begin
  Builder := TStringBuilder.Create(2);
  try
    Builder.Append('[');
    NeedComma := False;
    for Obj in AArray do
    begin
      if NeedComma then
        Builder.Append(',');
      Builder.Append(MakeStr(Obj));
      NeedComma := True;
    end;
    Builder.Append(']');
    Result := Builder.ToString;
  finally
    Builder.Free;
  end;
end;

class function Log.ArrayToString(const AArray: TEnumerable<TFmxObject>): string;
begin
  Result := ArrayToString(AArray,
    function(const AObject: TObject): string
    begin
      Result := AObject.ToString;
    end);
end;

class procedure Log.DumpFmxObject(const AObject: TFmxObject; const Nest: Integer);
const
  NestAdd = 2;
var
  Builder: TStringBuilder;
  Child: TFmxObject;
  I: Integer;
begin
  Builder := TStringBuilder.Create(Nest);
  try
    for I := 0 to Nest - 1 do
      Builder.Append(' ');
    Builder.Append(AObject.ToString);
    d(Builder.ToString);
  finally
    Builder.Free;
  end;
  if AObject.Children <> nil then
    for Child in AObject.Children do
      DumpFmxObject(Child, Nest + NestAdd);
end;

class function Log.Trace<TResult>(const Tag: string; const Func: TFunc<TLogToken, TResult>; const Threshold: Integer = -1): TResult;
var
  Token: Log.TLogToken;
  Start, Finish, LastTokenTime: TDateTime;
  Output: TStringBuilder;
  I: Integer;
  Total: Integer;
begin
  Output := nil;
  Token := Log.TLogToken.Create;
  try
    Start := Now;
    Result := Func(Token);
    Finish := Now;
    Total := MilliSecondsBetween(Finish, Start);
    if Total > Threshold then
    begin
      Output := TStringBuilder.Create;
      LastTokenTime := Start;
      for I := 0 to Token.Count - 1 do
      begin
        Output.Append(Format('%s(%d/%d) ', [Token.MarkAt[I].Msg, MilliSecondsBetween(Token.MarkAt[I].Time, LastTokenTime),
          MilliSecondsBetween(Token.MarkAt[I].Time, Start)]));
        LastTokenTime := Token.MarkAt[I].Time;
      end;
      d(Format('%s times: %s; total=%d', [Tag, Output.ToString, Total]));  // do not localize
    end;
  finally
    Token.Free;
    Output.Free;
  end;
end;

class function Log.Trace<TResult>(const Tag: string; const Func: TFunc<TResult>; const Threshold: Integer = -1): TResult;
begin
  Result := Trace<TResult>(Tag, function(Token: Log.TLogToken): TResult
    begin
      Result := Func;
    end, Threshold);
end;

class procedure Log.Trace(const Tag: string; const Proc: TProc<Log.TLogToken>; const Threshold: Integer = -1);
begin
  Trace<Integer>(Tag, function(Token: Log.TLogToken): Integer
    begin
      Proc(Token);
      Result := 0;
    end, Threshold);
end;

class procedure Log.Trace(const Tag: string; const Proc: TProc; const Threshold: Integer = -1);
begin
  Trace<Integer>(Tag, function(Token: Log.TLogToken): Integer
    begin
      Proc;
      Result := 0;
    end, Threshold);
end;

{ Log.TLogToken }

constructor Log.TLogToken.Create;
begin
  FMarks := TList<Log.TLogMark>.Create;
end;

function Log.TLogToken.GetCount: Integer;
begin
  Result := FMarks.Count;
end;

function Log.TLogToken.GetMarkAt(const Index: Integer): TLogMark;
begin
  Result := FMarks[Index];
end;

procedure Log.TLogToken.Mark(const Msg: string);
var
  Mark: Log.TLogMark;
begin
  Mark.Msg := Msg;
  Mark.Time := Now;
  FMarks.Add(Mark);
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
  RegisterShortCut(vkHardwareBack);
end;

procedure TFmxObject.IgnoreIntegerValue(Reader: TReader);
begin
  Reader.ReadInteger;
end;

{ TEnumerationFilter<T> }

constructor TEnumerableFilter<F, T>.Create(const FullEnum: TEnumerable<F>; SelfDestruct: Boolean;
  const Pred: TPredicate<T>);
begin
  FBaseEnum := FullEnum;
  FSelfDestruct := SelfDestruct;
  FPredicate := Pred;
end;

function TEnumerableFilter<F,T>.DoGetEnumerator: TEnumerator<T>;
begin
  if FSelfDestruct then
    Result := TFilterEnumerator.Create(FBaseEnum, Self, FPredicate)
  else
    Result := TFilterEnumerator.Create(FBaseEnum, nil, FPredicate);
end;

class function TEnumerableFilter<F, T>.Filter(const Src: TEnumerable<F>; const Predicate: TPredicate<T> = nil):
  TEnumerableFilter<F, T>;
begin
  Result := TEnumerableFilter<F,T>.Create(Src, True, Predicate);
end;

constructor TEnumerableFilter<F, T>.TFilterEnumerator.Create(const Enumerable: TEnumerable<F>;
  const Cleanup: TEnumerableFilter<F, T>; const Pred: TPredicate<T>);
begin
  FRawEnumerator := Enumerable.GetEnumerator;
  FCleanup := Cleanup;
  FPredicate := Pred;
end;

destructor TEnumerableFilter<F,T>.TFilterEnumerator.Destroy;
begin
  FRawEnumerator.Free;
  inherited;
  if FCleanup <> nil then
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
    if (FRawEnumerator.Current is T) and (not Assigned(FPredicate)) or (Assigned(FPredicate) and
      FPredicate(FRawEnumerator.Current as T)) then
    begin
      FCurrent := FRawEnumerator.Current as T;
      Result := FCurrent <> nil;
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
  if FChildren <> nil then
    Result := FChildren.Count
  else
    Result := 0;
end;

function TFmxChildrenList.IndexOf(const Obj: TFmxObject): Integer;
begin
  if FChildren <> nil then
    Result := FChildren.IndexOf(Obj)
  else
    Result := -1
end;

procedure RegisterAliases;
begin
  AddEnumElementAliases(TypeInfo(TVKAutoShowMode), ['vkasDefinedBySystem', 'vkasNever', 'vkasAlways']);
  AddEnumElementAliases(TypeInfo(TCorner), ['crTopLeft', 'crTopRight', 'crBottomLeft', 'crBottomRight']);
  AddEnumElementAliases(TypeInfo(TCornerType), ['ctRound', 'ctBevel', 'ctInnerRound', 'ctInnerLine']);
  AddEnumElementAliases(TypeInfo(TSide), ['sdTop', 'sdLeft', 'sdBottom', 'sdRight']);
  AddEnumElementAliases(TypeInfo(TTextAlign), ['taCenter', 'taLeading', 'taTrailing']);
  AddEnumElementAliases(TypeInfo(TTextTrimming), ['ttNone', 'ttCharacter', 'ttWord']);
  AddEnumElementAliases(TypeInfo(TStyledSetting), ['ssFamily', 'ssSize', 'ssStyle', 'ssFontColor', 'ssOther']);
  AddEnumElementAliases(TypeInfo(TMenuItemChange), ['mcEnabled', 'mcVisible', 'mcText', 'mcShortcut', 'mcChecked', 'mcBitmap']);
  AddEnumElementAliases(TypeInfo(TScreenOrientation), ['soPortrait', 'soLandscape', 'soInvertedPortrait', 'soInvertedLandscape']);
  AddEnumElementAliases(TypeInfo(TFormStyle), ['fsNormal', 'fsPopup', 'fsStayOnTop']);
  AddEnumElementAliases(TypeInfo(TAlignLayout), ['alNone', 'alTop', 'alLeft', 'alRight', 'alBottom', 'alMostTop', 'alMostBottom', 'alMostLeft', 'alMostRight', 'alClient', 'alContents', 'alCenter', 'alVertCenter', 'alHorzCenter', 'alHorizontal', 'alVertical', 'alScale', 'alFit', 'alFitLeft', 'alFitRight']);
  AddEnumElementAliases(TypeInfo(TVirtualKeyboardType), ['vktDefault', 'vktNumbersAndPunctuation', 'vktNumberPad', 'vktPhonePad', 'vktAlphabet', 'vktURL', 'vktNamePhonePad', 'vktEmailAddress']);
  AddEnumElementAliases(TypeInfo(TReturnKeyType), ['rktDefault', 'rktDone', 'rktGo', 'rktNext', 'rktSearch']);
  AddEnumElementAliases(TypeInfo(TInteractiveGesture), ['igZoom', 'igPan', 'igRotate', 'igTwoFingerTap', 'igPressAndtap', 'igLongTap', 'igDoubleTap']);
  AddEnumElementAliases(TypeInfo(TGestureType), ['gtStandard', 'gtRecorded', 'gtRegistered', 'gtNone']);
  AddEnumElementAliases(TypeInfo(TGestureOption), ['goUniDirectional', 'goSkew', 'goEndpoint', 'goRotate']);
  AddEnumElementAliases(TypeInfo(TCustomGestureEngine.TGestureEngineFlag), ['efMouseEvents', 'efTouchEvents']);
  AddEnumElementAliases(TypeInfo(TKeyKind), ['kkUsual', 'kkFunctional', 'kkUnknown']);
  AddEnumElementAliases(TypeInfo(TVirtualKeyboardState), ['vksAutoShow', 'vksVisible', 'vksError', 'vksTransient']);
end;

procedure UnregisterAliases;
begin
  RemoveEnumElementAliases(TypeInfo(TVKAutoShowMode));
  RemoveEnumElementAliases(TypeInfo(TCorner));
  RemoveEnumElementAliases(TypeInfo(TCornerType));
  RemoveEnumElementAliases(TypeInfo(TSide));
  RemoveEnumElementAliases(TypeInfo(TTextAlign));
  RemoveEnumElementAliases(TypeInfo(TTextTrimming));
  RemoveEnumElementAliases(TypeInfo(TStyledSetting));
  RemoveEnumElementAliases(TypeInfo(TMenuItemChange));
  RemoveEnumElementAliases(TypeInfo(TScreenOrientation));
  RemoveEnumElementAliases(TypeInfo(TFormStyle));
  RemoveEnumElementAliases(TypeInfo(TAlignLayout));
  RemoveEnumElementAliases(TypeInfo(TVirtualKeyboardType));
  RemoveEnumElementAliases(TypeInfo(TReturnKeyType));
  RemoveEnumElementAliases(TypeInfo(TInteractiveGesture));
  RemoveEnumElementAliases(TypeInfo(TGestureType));
  RemoveEnumElementAliases(TypeInfo(TGestureOption));
  RemoveEnumElementAliases(TypeInfo(TCustomGestureEngine.TGestureEngineFlag));
  RemoveEnumElementAliases(TypeInfo(TKeyKind));
  RemoveEnumElementAliases(TypeInfo(TVirtualKeyboardState));
end;

{ TTextAlignHelper }

function TTextAlignHelper.AsHorzRectAlign: THorzRectAlign;
begin
  Result := THorzRectAlign(Self);
end;

function TTextAlignHelper.AsVertRectAlign: TVertRectAlign;
begin
  Result := TVertRectAlign(Self);
end;

{ THorzRectAlignHelper }

function THorzRectAlignHelper.AsTextAlign: TTextAlign;
begin
  Result := TTextAlign(Self);
end;

{ TVertRectAlignHelper }

function TVertRectAlignHelper.AsTextAlign: TTextAlign;
begin
  Result := TTextAlign(Self);
end;

{ TControlSize }

procedure TControlSize.Assign(Source: TPersistent);
begin
  if Source is TControlSize then
  begin
    Size := TSizeF.Create(TControlSize(Source).Width, TControlSize(Source).Height);
    SetPlatformDefaultWithoutNotification(TControlSize(Source).PlatformDefault);
  end
  else
    inherited
end;

constructor TControlSize.Create(const ASize: TSizeF);
begin
  inherited Create;
  FSize := ASize;
  FDefaultValue := ASize;
  FUsePlatformDefault := True;
end;

procedure TControlSize.DoChange;
begin
  if Assigned(OnChange) then
    OnChange(Self);
end;

function TControlSize.GetHeight: Single;
begin
  Result := FSize.Height;
end;

function TControlSize.GetSize: TSizeF;
begin
  Result := FSize;
end;

function TControlSize.GetWidth: Single;
begin
  Result := FSize.Width;
end;

procedure TControlSize.SetHeight(const AValue: Single);
var
  Changed: Boolean;
  NewValue: Single;
begin
  NewValue := System.Math.Max(0, AValue);
  Changed := not SameValue(FSize.Height, NewValue, TEpsilon.Position);
  SetPlatformDefaultWithoutNotification(FUsePlatformDefault and not Changed);
  FSize.Height := NewValue;
  if Changed then
    DoChange;
end;

procedure TControlSize.SetSize(const Value: TSizeF);
var
  Changed: Boolean;
  NewValue: TSizeF;
begin
  NewValue.Width := System.Math.Max(0, Value.Width);
  NewValue.Height := System.Math.Max(0, Value.Height);
  Changed := not (SameValue(FSize.Width, NewValue.Width, TEpsilon.Position) and SameValue(FSize.Height, NewValue.Height, TEpsilon.Position));
  SetPlatformDefaultWithoutNotification(FUsePlatformDefault and not Changed);
  FSize.Width := NewValue.Width;
  FSize.Height := NewValue.Height;
  if Changed then
    DoChange;
end;

procedure TControlSize.SetSizeWithoutNotification(const Value: TSizeF);
begin
  FSize.Width := Value.Width;
  FSize.Height := Value.Height;
  SetPlatformDefaultWithoutNotification(False);
end;

procedure TControlSize.SetUsePlatformDefault(const Value: Boolean);
var
  Changed: Boolean;
begin
  Changed := FUsePlatformDefault <> Value;
  SetPlatformDefaultWithoutNotification(Value);
  if Changed then
    DoChange;
end;

procedure TControlSize.SetPlatformDefaultWithoutNotification(const Value: Boolean);
begin
  FUsePlatformDefault := Value;
end;

procedure TControlSize.SetWidth(const AValue: Single);
var
  Changed: Boolean;
  NewValue: Single;
begin
  SetPlatformDefaultWithoutNotification(False);
  NewValue := System.Math.Max(0, AValue);
  Changed := not SameValue(FSize.Width, NewValue, TEpsilon.Position);
  FSize.Width := NewValue;
  if Changed then
    DoChange;
end;

function TControlSize.StoreWidthHeight: Boolean;
begin
  Result := not FUsePlatformDefault;
end;

{ TDeviceDisplayMetrics }

constructor TDeviceDisplayMetrics.Create(const APhysicalScreenSize, ALogicalScreenSize: TSize;
  const AAspectRatio: Single; const APixelsPerInch: Integer; const AScreenScale, AFontScale: Single);
begin
  PhysicalScreenSize := APhysicalScreenSize;
  LogicalScreenSize := ALogicalScreenSize;
  AspectRatio := AAspectRatio;
  PixelsPerInch := APixelsPerInch;
  ScreenScale := AScreenScale;
  FontScale := AFontScale;
end;

class operator TDeviceDisplayMetrics.Equal(const Left, Right: TDeviceDisplayMetrics): Boolean;
begin
  Result := (Left.PhysicalScreenSize = Right.PhysicalScreenSize) and
    (Left.LogicalScreenSize = Right.LogicalScreenSize) and
    (Left.PixelsPerInch = Right.PixelsPerInch) and
    SameValue(Left.AspectRatio, Right.AspectRatio, TEpsilon.Vector) and
    SameValue(Left.ScreenScale, Right.ScreenScale, TEpsilon.Scale) and
    SameValue(Left.FontScale, Right.FontScale, TEpsilon.Scale);
end;

class operator TDeviceDisplayMetrics.NotEqual(const Left, Right: TDeviceDisplayMetrics): Boolean;
begin
  Result := not (Left =  Right);
end;

class function TDeviceDisplayMetrics.Default: TDeviceDisplayMetrics;
const
  DefaultValues: TDeviceDisplayMetrics = (PhysicalScreenSize: (cx: 1024; cy: 768);
    LogicalScreenSize: (cx: 1024; cy: 768); AspectRatio: 1; PixelsPerInch: 96; ScreenScale: 1; FontScale: 1);
begin
  Result := DefaultValues;
end;

function DummyColorToColor(const Color: TColor): TColor;
begin
  Result := Color;
end;

{ TWindowHandle }

function TWindowHandle.GetScale: single;
begin
  Result := 1;
end;

function TWindowHandle.IsScaleInteger: Boolean;
begin
  Result := SameValue(Frac(Scale), 0, TEpsilon.Scale);
end;

initialization
  RegisterAliases;
  vPurgatory := TPurgatory.Create(nil);
  ClonePropertiesCache := TDictionary<string , TList<TRttiProperty>>.Create;
  ClonePersistentCache := TDictionary<string , TList<TRttiProperty>>.Create;
  SharedContext := TRttiContext.Create;
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);
  GroupDescendentsWith(TCustomActionList, TFmxObject);
  GroupDescendentsWith(TCustomAction, TFmxObject);
  GroupDescendentsWith(TCustomGestureManager, TFmxObject);

  RegisterFmxClasses([TFmxObject, TTimer], [TBounds, TPosition]);

  RegisterAlphaColorIntegerConsts;
  RegisterCursorIntegerConsts;
  RegisterShortCuts;

  @System.UITypes.TColorRec.ColorToRGB := @DummyColorToColor;
  @System.UITypes.TAlphaColorRec.ColorToRGB := @System.UIConsts.AlphaColorToColor;

finalization
  UnregisterAliases;
  FreeFmxGlobals;
  FreeAndNil(vPurgatory);

end.


