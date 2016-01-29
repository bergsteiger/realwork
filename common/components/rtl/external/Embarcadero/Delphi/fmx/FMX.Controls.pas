{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Controls;

interface

uses
  System.Classes, System.Actions, System.Types, System.Rtti, System.UITypes,
  System.Generics.Collections, System.Generics.Defaults, System.SysUtils,
  System.UIConsts, System.Math, FMX.ActnList, FMX.Types, FMX.Messages,
  FMX.Styles, FMX.VirtualKeyboard, FMX.TextLayout;

{$SCOPEDENUMS ON}

type

  TControl = class;
  TStyledControl = class;
  TStyleBook = class;

  IStyleBookOwner = interface
    ['{BA1AE6C6-FCF7-43E2-92AA-2869FF203309}']
    function GetStyleBook: TStyleBook;
    procedure SetStyleBook(const Value: TStyleBook);
    property StyleBook: TStyleBook read GetStyleBook write SetStyleBook;
  end;

  IScene = interface(IStyleBookOwner)
    ['{16DB110E-DA7D-4e75-BC2D-999FA12E45F5}']
    procedure AddUpdateRect(R: TRectF);
    function GetUpdateRectsCount: Integer;
    function GetUpdateRect(const Index: Integer): TRectF;
    function GetObject: TFmxObject;
    function GetCanvas: TCanvas;
    function GetSceneScale: Single;
    function LocalToScreen(P: TPointF): TPointF;
    function ScreenToLocal(P: TPointF): TPointF;
    procedure ChangeScrollingState(const AControl: TControl; const Active: Boolean);
    { access }
    property Canvas: TCanvas read GetCanvas;
  end;

  { IDesignerControl: Control implementing this is part of the designer }
  IDesignerControl = interface
    ['{C57A701D-E4B5-4711-BFA4-716E2164A929}']
  end;

{ TCustomControlAction }
  /// <summary>
  /// Àn action that has some extra features that can be used controls (in Fire Monkey).
  /// </summary>
  /// <remarks>
  ///   The value of <c>DisableIfNoHandler</c>, default is False
  /// </remarks>
  TCustomControlAction = class(TCustomAction)
  private
    //FDropdownMenu: TCustomPopupMenu;
    //FEnableDropdown: Boolean;
    FPopupMenu: TCustomPopupMenu;
    //procedure SetDropdownMenu(Value: TPopupMenu);
    //procedure SetEnableDropdown(Value: Boolean);
    procedure SetPopupMenu(const Value: TCustomPopupMenu);
  protected
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    //property DropdownMenu: TPopupMenu read FDropdownMenu write SetDropdownMenu;
    //property EnableDropdown: Boolean read FEnableDropdown write SetEnableDropdown default False;
    property PopupMenu: TCustomPopupMenu read FPopupMenu write SetPopupMenu;
  end;

{ TControlAction }

  TControlAction = class(TCustomControlAction)
  published
    property AutoCheck;
    property Text;
    property Checked;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property UnsupportedArchitectures;
    property UnsupportedPlatforms;
    property OnExecute;
    property OnUpdate;
    property PopupMenu;
  end;

{ TCustomViewAction }

  TOnCreateComponent = procedure (Sender: TObject; var NewComponent: TComponent) of object;
  TOnBeforeShow = procedure (Sender: TObject; var CanShow: boolean) of object;

  TCustomViewAction = class(TCustomAction)
  private
    FComponent: TComponent;
    FOnCreateComponent: TonCreateComponent;
    FOnAfterShow: TNotifyEvent;
    FOnBeforeShow: TOnBeforeShow;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoCreateComponent(var NewComponent: TComponent); virtual;
    procedure DoBeforeShow(var CanShow: boolean); virtual;
    procedure DoAfterShow; virtual;
    function ComponentText: string; virtual;
    procedure SetComponent(const Value: TComponent); virtual;
    procedure ComponentChanged; virtual;
    property Component: TComponent read FComponent write SetComponent;
    property OnCreateComponent: TOnCreateComponent read FOnCreateComponent write FonCreateComponent;
    property OnBeforeShow: TOnBeforeShow read FOnBeforeShow write FOnBeforeShow;
    property OnAfterShow: TNotifyEvent read FOnAfterShow write FOnAfterShow;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
  end;

{ TControlActionLink }
  /// <summary>
  ///   This class is intended for communication action with the control.
  /// </summary>
  TControlActionLink = class(FMX.ActnList.TActionLink)
  private
    FClient: TControl;
    function ActionCustomViewComponent: boolean;
  protected
    property Client: TControl read FClient;
    procedure AssignClient(AClient: TObject); override;
    function IsCaptionLinked: Boolean; override;
    function IsCheckedLinked: Boolean; override;
    function IsEnabledLinked: Boolean; override;
    function IsGroupIndexLinked: Boolean; override;
    function IsHelpLinked: Boolean;  override;
    function IsHintLinked: Boolean; override;
    function IsVisibleLinked: Boolean; override;
    function IsOnExecuteLinked: Boolean; override;
    function IsPopupMenuLinked: boolean; virtual;
    procedure SetCaption(const Value: string); override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetGroupIndex(Value: Integer); override;
    procedure SetHelpContext(Value: THelpContext); override;
    procedure SetHelpKeyword(const Value: string); override;
    procedure SetHelpType(Value: THelpType); override;
    procedure SetVisible(Value: Boolean); override;
    procedure SetOnExecute(Value: TNotifyEvent); override;
    procedure SetChecked(Value: Boolean); override;
    procedure SetPopupMenu(const Value: TCustomPopupMenu); virtual;
  end;

  TCaret = class (TCustomCaret)
  private const
    FMXFlasher = 'FMXFlasher';
  public
    class function FlasherName: string; override;
  published
    property Color;
    property Interval;
    property Width;
  end;

{ TControl }

  TEnumControlsRef = reference to procedure(const AControl: TControl; var Done: boolean);

  TControlList = TList<TControl>;

  TOnPaintEvent = procedure(Sender: TObject; Canvas: TCanvas; const ARect: TRectF) of object;

  TPaintStage = (psAll, psBackground, psText);

  TControl = class(TFmxObject, IControl, IContainerObject, IAlignRoot,
    IAlignableObject, IEffectContainer)
  private class var
    FPaintStage: TPaintStage;
  strict private
    FOnMouseUp: TMouseEvent;
    FOnMouseDown: TMouseEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseWheel: TMouseWheelEvent;
    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FHitTest: Boolean;
    FClipChildren: Boolean;
    FAutoCapture: Boolean;
    FPadding: TBounds;
    FMargins: TBounds;
    FTempCanvas: TCanvas;
    FRotationAngle: Single;
    FPosition: TPosition;
    FScale: TPosition;
    FSkew: TPosition;
    FRotationCenter: TPosition;
    FCanFocus: Boolean;
    FOnCanFocus: TCanFocusEvent;
    FOnEnter: TNotifyEvent;
    FOnExit: TNotifyEvent;
    FClipParent: Boolean;
    FOnMouseLeave: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    FDesignVisible: Boolean;
    FOnPaint: TOnPaintEvent;
    FOnPainting: TOnPaintEvent;
    FCursor: TCursor;
    FInheritedCursor: TCursor;
    FDragMode: TDragMode;
    FEnableDragHighlight: Boolean;
    FOnDragEnter: TDragEnterEvent;
    FOnDragDrop: TDragDropEvent;
    FOnDragLeave: TNotifyEvent;
    FOnDragOver: TDragOverEvent;
    FOnDragEnd: TNotifyEvent;
    FIsDragOver: Boolean;
    FOnKeyDown: TKeyEvent;
    FOnKeyUp: TKeyEvent;
    FHint: string;
    FShowHint: Boolean;
    FPopupMenu: TCustomPopupMenu;
    FRecalcEnabled, FEnabled, FAbsoluteEnabled: Boolean;
    FTabOrder: TTabOrder;
    FAddingToTabList: Boolean;
    FOnResize: TNotifyEvent;
    FDisableEffect: Boolean;
    FAcceptsControls: boolean;
    FControls: TControlList;
    FEnableExecuteAction: boolean;
    FCanParentFocus: boolean;
    FMinClipHeight: single;
    FMinClipWidth: single;
    FSmallSizeControl: boolean;
    FTouchTargetExpansion: TBounds;
    FOnDeactivate: TNotifyEvent;
    FOnActivate: TNotifyEvent;
    FSimpleTransform: Boolean;
    FFixedSize: TSize;
    FEffects: TList<TEffect>;
    procedure AddToEffectsList(const AEffect: TEffect);
    procedure RemoveFromEffectsList(const AEffect: TEffect);
    class var FEmptyControlList: TControlList;
    function GetInvertAbsoluteMatrix: TMatrix;
    procedure SetRotationAngle(const Value: Single);
    procedure SetPosition(const Value: TPosition);
    procedure SetHitTest(const Value: Boolean);
    procedure SetClipChildren(const Value: Boolean);
    function GetCanvas: TCanvas; inline;
    procedure SetLocked(const Value: Boolean);
    procedure SetTempCanvas(const Value: TCanvas);
    procedure SetOpacity(const Value: Single);
    procedure SetDesignVisible(const Value: Boolean);
    procedure SetTabOrder(const Value: TTabOrder);
    procedure UpdateDesignVisible(const Value: Boolean);
    function IsOpacityStored: Boolean;
    function IsTabOrderStored: Boolean;
    procedure SetCursor(const Value: TCursor);
    procedure RefreshInheritedCursor;
    procedure RefreshInheritedCursorForChildren;
    function GetAbsoluteWidth: Single;
    function GetAbsoluteHeight: Single;
    function GetTabOrder: TTabOrder;
    function IsAnchorsStored: Boolean;
    function GetEnabled: Boolean;
    function GetCursor: TCursor;
    function GetInheritedCursor: TCursor;
    function GetAbsoluteHasEffect: Boolean;
    function GetAbsoluteHasDisablePaintEffect: Boolean;
    function GetAbsoluteHasAfterPaintEffect: Boolean;
    procedure PaddingChanged(Sender: TObject);
    procedure MarginsChanged(Sender: TObject);
    procedure MatrixChanged(Sender: TObject);
    function GetControlsCount: Integer;
    function OnClickStored: Boolean;
    function IsPopupMenuStored: boolean;
    procedure RequestAlign;
    function GetIsChildFocused: boolean;
    procedure SetIsChildFocused(const Value: boolean);
    procedure SetMinClipHeight(const Value: single);
    procedure SetMinClipWidth(const Value: single);
    function UpdateSmallSizeControl: boolean;
    procedure SetScale(const Value: TPosition);
    class constructor Create;
    class destructor Destroy;
    procedure SetOnClick(const Value: TNotifyEvent);
    function GetIsFocused: Boolean;
    procedure SetPadding(const Value: TBounds);
    procedure SetMargins(const Value: TBounds);
    procedure SetTouchTargetExpansion(const Value: TBounds);
    procedure InternalSizeChanged;
    procedure ReadFixedWidth(Reader: TReader);
    procedure WriteFixedWidth(Writer: TWriter);
    procedure ReadFixedHeight(Reader: TReader);
    procedure WriteFixedHeight(Writer: TWriter);
    function IsHeightStored: Boolean;
    function IsWidthStored: Boolean;
    function IsPositionStored: Boolean;
  private
    [Weak] FParentControl: TControl;
    FInflated: Boolean;
    FOnApplyStyleLookup: TNotifyEvent;
    FAlign: TAlignLayout;
    FAnchors: TAnchors;
    FUpdateEffects: Boolean;
    FDisableFocusEffect: Boolean;
  protected
    FScene: IScene;
    FHeight, FLastHeight: Single;
    FWidth, FLastWidth: Single;
    FVisible: Boolean;
    FLocalMatrix: TMatrix;
    FAbsoluteMatrix: TMatrix;
    FInvAbsoluteMatrix: TMatrix;
    FEffectBitmap: TBitmap;
    FLocked: Boolean;
    FOpacity, FAbsoluteOpacity: Single;
    FInPaintTo: Boolean;
    FInPaintToAbsMatrix, FInPaintToInvMatrix: TMatrix;
    FUpdateRect: TRectF;
    FPressed, FDoubleClick: Boolean;
    FAbsoluteHasEffect: Boolean;
    FAbsoluteHasDisablePaintEffect: Boolean;
    FAbsoluteHasAfterPaintEffect: Boolean;
    FUpdating: Integer;
    FNeedAlign: Boolean;
    FDisablePaint: Boolean;
    FDisableAlign: Boolean;
    FRecalcOpacity: Boolean;
    FRecalcUpdateRect: Boolean;
    FRecalcAbsolute: Boolean;
    FRecalcHasEffect: Boolean;
    FHasClipParent: TControl;
    FRecalcHasClipParent: Boolean;
    FDesignInteractive: Boolean;
    FDesignSelectionMarks: Boolean;
    FIsMouseOver: Boolean;
    FIsFocused: Boolean;
    { added for aligment using a relation between align and anchors}
    FAnchorMove: Boolean;
    FAnchorRules: TPointF;
    FAnchorOrigin: TPointF;
    FOriginalParentSize: TPointF;
    FLeft: Single;
    FTop: Single;
    FExplicitLeft: Single;
    FExplicitTop: Single;
    FExplicitWidth: Single;
    FExplicitHeight: Single;
    FIsChildFocused: Boolean;
    function CheckHitTest(const AHitTest: Boolean): Boolean;
    procedure SetInPaintTo(Value: Boolean);
    procedure EndUpdateNoChanges;
    { }
    procedure SetEnabled(const Value: Boolean); virtual;
    procedure Loaded; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ChangeParent; override;
    procedure ChangeOrder; override;
    procedure ChangeChildren; override;
    procedure SetVisible(const Value: Boolean); virtual;
    function DoSetWidth(var Value: Single; NewValue: single; var LastValue: Single): boolean; virtual;
    function DoSetHeight(var Value: Single; NewValue: single; var LastValue: Single): boolean; virtual;
    { matrix }
    procedure DoMatrixChanged(Sender: TObject); virtual;
    procedure SetHeight(const Value: Single); virtual;
    procedure SetWidth(const Value: Single); virtual;
    function GetAbsoluteRect: TRectF; virtual;
    function GetChildrenMatrix(var Matrix: TMatrix; var Simple: Boolean): Boolean; virtual;
    function GetAbsoluteScale: TPointF; virtual;
    function GetLocalRect: TRectF; virtual;
    function GetBoundsRect: TRectF; virtual;
    function GetParentedRect: TRectF; virtual;
    function GetClipRect: TRectF; virtual;
    function GetEffectsRect: TRectF; virtual;
    function GetAbsoluteEnabled: Boolean; virtual;
    function GetChildrenRect: TRectF;
    procedure SetBoundsRect(const Value: TRectF); virtual;
    procedure SetPopupMenu(const Value: TCustomPopupMenu);
    { optimizations }
    function GetAbsoluteMatrix: TMatrix; virtual;
    function GetHasClipParent: TControl;
    function GetUpdateRect: TRectF; virtual;
    procedure RecalcAbsoluteNow;
    procedure RecalcUpdateRect; virtual;
    procedure RecalcOpacity; virtual;
    procedure RecalcAbsolute; virtual;
    procedure RecalcEnabled; virtual;
    procedure RecalcHasEffect; virtual;
    procedure RecalcHasClipParent; virtual;
    { opacity }
    function GetAbsoluteOpacity: Single; virtual;
    { events }
    procedure BeginAutoDrag; virtual;
    procedure Capture;
    procedure ReleaseCapture;
    property EnableExecuteAction: boolean read FEnableExecuteAction write FEnableExecuteAction;
    procedure Click; virtual;
    procedure DblClick; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); virtual;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); virtual;
    procedure KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState); virtual;
    procedure KeyUp(var Key: Word; var KeyChar: WideChar; Shift: TShiftState); virtual;
    procedure DialogKey(var Key: Word; Shift: TShiftState); virtual;
    procedure ContextMenu(const ScreenPosition: TPointF); virtual;
    procedure DragEnter(const Data: TDragObject; const Point: TPointF); virtual;
    procedure DragOver(const Data: TDragObject; const Point: TPointF; var Accept: Boolean); virtual;
    procedure DragDrop(const Data: TDragObject; const Point: TPointF); virtual;
    procedure DragLeave; virtual;
    procedure DragEnd; virtual;
    function GetCanFocus: boolean; virtual;
    function GetCanParentFocus: boolean; virtual;
    function EnterChildren(AObject: IControl): Boolean; virtual;
    function ExitChildren(AObject: IControl): Boolean; virtual;
    function GetParentedVisible: Boolean; virtual;
    { IEffectContainer }
    procedure NeedUpdateEffects;
    procedure BeforeEffectEnabledChanged(const Enabled: Boolean);
    procedure EffectEnabledChanged(const Enabled: Boolean);
    { IAlignRoot }
    procedure Realign;
    procedure ChildrenAlignChanged;
    { IAlignableObject }
    function GetAlign: TAlignLayout;
    procedure SetAlign(const Value: TAlignLayout); virtual;
    function GetAnchors: TAnchors;
    procedure SetAnchors(const Value: TAnchors); virtual;
    function GetMargins: TBounds;
    function GetPadding: TBounds;
    function GetWidth: single;
    function GetHeight: single;
    function GetLeft: single;
    function GetTop: single;
    function GetAllowAlign: Boolean;
    function GetAnchorRules : TPointF;
    function GetAnchorOrigin : TPointF;
    function GetOriginalParentSize : TPointF;
    function GetAnchorMove : Boolean;
    procedure SetAnchorMove(Value : Boolean);
    { IContainerObject }
    function GetContainerWidth: Single;
    function GetContainerHeight: Single;
    { IControl }
    function IControl.GetObject = GetObject;
    function GetObject: TFmxObject;
    function GetParent: TFmxObject;
    function GetVisible: Boolean;
    function GetDesignInteractive: Boolean;
    function GetPopupMenu: TCustomPopupMenu;
    procedure DoEnter; virtual;
    procedure DoExit; virtual;
    procedure DoActivate; virtual;
    procedure DoDeactivate; virtual;
    procedure DoMouseEnter; virtual;
    procedure DoMouseLeave; virtual;
    function GetTabOrderValue: TTabOrder;
    procedure UpdateTabOrder(Value: TTabOrder);
    function CheckForAllowFocus: Boolean;
    function ScreenToLocal(P: TPointF): TPointF; virtual;
    function LocalToScreen(P: TPointF): TPointF; virtual;
    function GetDragMode: TDragMode;
    procedure SetDragMode(const ADragMode: TDragMode);
    function GetLocked: Boolean;
    function GetHitTest: Boolean;
    function GetAcceptsControls: Boolean;
    procedure SetAcceptsControls(const Value: boolean);
    function FindTarget(P: TPointF; const Data: TDragObject): IControl; virtual;
    function ObjectAtPoint(P: TPointF): IControl; virtual;
    { design }
    function SupportsPlatformService(const AServiceGUID: TGUID; out AService: IInterface): Boolean; override;
    { optimization }
    function GetFirstVisibleObjectIndex: Integer; virtual;
    function GetLastVisibleObjectIndex: Integer; virtual;
    function GetDefaultSize: TSizeF; virtual;
    { bi-di }
    function FillTextFlags: TFillTextFlags; virtual;
    { paint internal }
    procedure ApplyEffect;
    procedure PaintInternal;
    function SupportsPaintStage(const Stage: TPaintStage): Boolean; virtual;
    { paint }
    procedure PaintChildren; virtual;
    procedure Painting; virtual;
    procedure Paint; virtual;
    procedure DoPaint; virtual;
    procedure AfterPaint; virtual;
    { align }
    procedure DoRealign; virtual;
    { changes }
    procedure Move; virtual;
    procedure Resize; virtual;
    procedure Disappear; virtual;
    procedure Show; virtual;
    procedure Hide; virtual;
    property MinClipWidth: single read FMinClipWidth write SetMinClipWidth;
    property MinClipHeight: single read FMinClipHeight write SetMinClipHeight;
    property SmallSizeControl: boolean read FSmallSizeControl;
    { children }
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    procedure DoDeleteChildren; override;
    { props }
    class property PaintStage: TPaintStage read FPaintStage write FPaintStage;
    property TempCanvas: TCanvas read FTempCanvas write SetTempCanvas;
    { added for aligment using a relation between align and anchors}
    procedure SetLeft(const Value: Single);
    procedure SetTop(const Value: Single);
    procedure UpdateExplicitBounds;
    procedure UpdateAnchorRules;
    property FixedSize: TSize read FFixedSize;
    property Left: Single read FLeft write SetLeft;
    property Top: Single read FTop write SetTop;
    property ExplicitLeft: Single read FExplicitLeft;
    property ExplicitTop: Single read FExplicitTop;
    property ExplicitWidth: Single read FExplicitWidth;
    property ExplicitHeight: Single read FExplicitHeight;
    property Hint: string read FHint write FHint;
    property ShowHint: Boolean read FShowHint write FShowHint default False;
    function GetActionLinkClass: TActionLinkClass; override;
    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); override;
    { other }
    procedure AddToTabList(const AObject: TFmxObject); override;
    function GetControls: TControlList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetNewScene(AScene: IScene); virtual;
    procedure SetBounds(X, Y, AWidth, AHeight: Single); virtual;
    function AbsoluteToLocal(P: TPointF): TPointF; virtual;
    function LocalToAbsolute(P: TPointF): TPointF; virtual;
    function AbsoluteToLocalVector(P: TVector): TVector; virtual;
    function LocalToAbsoluteVector(P: TVector): TVector; virtual;
    function PointInObject(X, Y: Single): Boolean; virtual;
    function PointInObjectLocal(X, Y: Single): Boolean; virtual;
    { check for support interface }
    function IsIControl: Boolean; override;
    function AsIControl: IControl; override;
    { drag and drop }
    function MakeScreenshot: TBitmap;
    { align }
    procedure BeginUpdate; virtual;
    function IsUpdating: Boolean; virtual;
    procedure EndUpdate; virtual;
    { effects }
    procedure UpdateEffects;
    { }
    procedure SetFocus;
    procedure PaintTo(const ACanvas: TCanvas; const ARect: TRectF; const AParent: TFmxObject = nil);
    procedure Repaint;
    procedure InvalidateRect(ARect: TRectF);
    procedure Lock;
    property AbsoluteMatrix: TMatrix read GetAbsoluteMatrix;
    property AbsoluteOpacity: Single read GetAbsoluteOpacity;
    property AbsoluteWidth: Single read GetAbsoluteWidth;
    property AbsoluteHeight: Single read GetAbsoluteHeight;
    property AbsoluteScale: TPointF read GetAbsoluteScale;
    property AbsoluteEnabled: Boolean read GetAbsoluteEnabled;
    property HasEffect: Boolean read GetAbsoluteHasEffect;
    property HasDisablePaintEffect: Boolean read GetAbsoluteHasDisablePaintEffect;
    property HasAfterPaintEffect: Boolean read GetAbsoluteHasAfterPaintEffect;
    property HasClipParent: TControl read GetHasClipParent;
    property ChildrenRect: TRectF read GetChildrenRect;
    property InvertAbsoluteMatrix: TMatrix read GetInvertAbsoluteMatrix;
    property InPaintTo: Boolean read FInPaintTo;
    property LocalRect: TRectF read GetLocalRect;
    property AbsoluteRect: TRectF read GetAbsoluteRect;
    property UpdateRect: TRectF read GetUpdateRect;
    property BoundsRect: TRectF read GetBoundsRect write SetBoundsRect;
    property ParentedRect: TRectF read GetParentedRect;
    property ParentedVisible: Boolean read GetParentedVisible;
    property ClipRect: TRectF read GetClipRect;
    property Canvas: TCanvas read GetCanvas;
    property Controls: TControlList read GetControls;
    property ControlsCount: Integer read GetControlsCount;
    property ParentControl: TControl read FParentControl;
    property Scene: IScene read FScene;
    property AutoCapture: Boolean read FAutoCapture write FAutoCapture default False;
    property CanFocus: Boolean read FCanFocus write FCanFocus default False;
    property CanParentFocus: Boolean read FCanParentFocus write FCanParentFocus default False;
    property DisableFocusEffect: Boolean read FDisableFocusEffect write FDisableFocusEffect default False;
    property IsInflated: Boolean read FInflated;
    function EnumControls(Proc: TEnumControlsRef;
                          const VisibleOnly: Boolean = True): Boolean;
    { triggers }
    property IsMouseOver: Boolean read FIsMouseOver;
    property IsDragOver: Boolean read FIsDragOver;
    property IsFocused: Boolean read GetIsFocused;
    property IsChildFocused: Boolean read FIsChildFocused;
    property IsVisible: Boolean read FVisible;
    property Align: TAlignLayout read FAlign write SetAlign default TAlignLayout.alNone;
    property Anchors: TAnchors read FAnchors write SetAnchors stored IsAnchorsStored nodefault;
    property Cursor: TCursor read GetCursor write SetCursor default crDefault;
    property InheritedCursor: TCursor read GetInheritedCursor default crDefault;
    property DragMode: TDragMode read GetDragMode write SetDragMode default TDragMode.dmManual;
    property EnableDragHighlight: Boolean read FEnableDragHighlight write FEnableDragHighlight default True;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Position: TPosition read FPosition write SetPosition stored IsPositionStored;
    property RotationAngle: Single read FRotationAngle write SetRotationAngle;
    property RotationCenter: TPosition read FRotationCenter write FRotationCenter;
    property Locked: Boolean read FLocked write SetLocked default False;
    property Width: Single read GetWidth write SetWidth stored IsWidthStored nodefault;
    property Height: Single read GetHeight write SetHeight stored IsHeightStored nodefault;
    property Padding: TBounds read GetPadding write SetPadding;
    property Margins: TBounds read GetMargins write SetMargins;
    property Opacity: Single read FOpacity write SetOpacity stored IsOpacityStored nodefault;
    property ClipChildren: Boolean read FClipChildren write SetClipChildren default False;
    property ClipParent: Boolean read FClipParent write FClipParent default False;
    property HitTest: Boolean read FHitTest write SetHitTest default True;
    property PopupMenu: TCustomPopupMenu read FPopupMenu write SetPopupMenu stored IsPopupMenuStored;
    property Scale: TPosition read FScale write SetScale;
    property TabOrder: TTabOrder read GetTabOrder write SetTabOrder stored IsTabOrderStored default -1;
    property Visible: Boolean read FVisible write SetVisible default True;
    property DesignVisible: Boolean read FDesignVisible write SetDesignVisible default True;
    property OnDragEnter: TDragEnterEvent read FOnDragEnter write FOnDragEnter;
    property OnDragLeave: TNotifyEvent read FOnDragLeave write FOnDragLeave;
    property OnDragOver: TDragOverEvent read FOnDragOver write FOnDragOver;
    property OnDragDrop: TDragDropEvent read FOnDragDrop write FOnDragDrop;
    property OnDragEnd: TNotifyEvent read FOnDragEnd write FOnDragEnd;
    property OnKeyDown: TKeyEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyUp: TKeyEvent read FOnKeyUp write FOnKeyUp;
    property OnClick: TNotifyEvent read FOnClick write SetOnClick stored OnClickStored;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnCanFocus: TCanFocusEvent read FOnCanFocus write FOnCanFocus;
    property OnEnter: TNotifyEvent read FOnEnter write FOnEnter;
    property OnExit: TNotifyEvent read FOnExit write FOnExit;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnMouseWheel: TMouseWheelEvent read FOnMouseWheel write FOnMouseWheel;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnPainting: TOnPaintEvent read FOnPainting write FOnPainting;
    property OnPaint: TOnPaintEvent read FOnPaint write FOnPaint;
    property OnResize: TNotifyEvent read FOnResize write FOnResize;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property OnApplyStyleLookup: TNotifyEvent read FOnApplyStyleLookup write FOnApplyStyleLookup;
    property TouchTargetExpansion: TBounds read FTouchTargetExpansion write SetTouchTargetExpansion;
  published
    property Touch;
    property OnGesture;
  end;

  TOrientation = (orHorizontal, orVertical);

{ TStyledControl }

  TStyledControl = class(TControl)
  protected type
    TAdjustType = (None, FixedSize, FixedWidth, FixedHeight);
  strict private
    FStylesData: TDictionary<string, TValue>;
    FScaleChangedId: Integer;
    FStyleChangedId: Integer;
    FDisableDisappear: Boolean;
    FResourceLink: TFmxObject;
    [Weak] FResourceControl: TControl;
    FAdjustType: TAdjustType;
    FAdjustSizeValue: TSizeF;
    FStyleLookup: string;
    FIsNeedStyleLookup: Boolean;
    FAutoTranslate: Boolean;
    FHelpType: THelpType;
    FHelpKeyword: string;
    FHelpContext: THelpContext;
    function GetStyleData(const Index: string): TValue;
    procedure SetStyleData(const Index: string; const Value: TValue);
    procedure SetStyleLookup(const Value: string);
    procedure ScaleChangedHandler(const Sender: TObject; const Msg: FMX.Messages.TMessage);
    procedure StyleChangedHandler(const Sender: TObject; const Msg : TMessage);
  protected
    function SearchInto: Boolean; override;
    function GetBackIndex: Integer; override;
    function IsHelpContextStored: Boolean;
    procedure SetHelpContext(const Value: THelpContext);
    procedure SetHelpKeyword(const Value: string);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function DoSetWidth(var Value: Single; NewValue: single; var LastValue: Single): boolean; override;
    function DoSetHeight(var Value: Single; NewValue: single; var LastValue: Single): boolean; override;
    procedure DoApplyStyleLookup; virtual;
    { control }
    procedure Painting; override;
    procedure ApplyStyle; virtual;
    procedure FreeStyle; virtual;
    procedure Inflate; virtual;
    function GetDefaultStyleLookupName: string; virtual;
    function IsStyleLookupStored: Boolean; virtual;
    procedure DoEnter; override;
    procedure Disappear; override;
    procedure AdjustSize; virtual;
    procedure AdjustFixedSize(const Ref: TControl); virtual;
    procedure DoStyleChanged; virtual;
    { }
    function GetStyleObject: TFmxObject; overload; virtual;
    function GetStyleObject(const Clone: Boolean): TFmxObject; overload; virtual;
    property AdjustType: TAdjustType read FAdjustType write FAdjustType;
    property AdjustSizeValue: TSizeF read FAdjustSizeValue write FAdjustSizeValue;
    property DisableDisappear: Boolean read FDisableDisappear write FDisableDisappear;
    property IsNeedStyleLookup: Boolean read FIsNeedStyleLookup;
    property ResourceLink: TFmxObject read FResourceLink;
    property ResourceControl: TControl read FResourceControl;
  public
    constructor Create(AOwner: TComponent); override;
    procedure BeforeDestruction; override;
    destructor Destroy; override;
    function FindStyleResource(const AStyleLookup: string; const Clone: Boolean = False): TFmxObject; override;
    procedure SetNewScene(AScene: IScene); override;
    procedure ApplyStyleLookup; virtual;
    procedure NeedStyleLookup;
    procedure UpdateStyle; deprecated;
    property AutoTranslate: Boolean read FAutoTranslate write FAutoTranslate;
    property DefaultStyleLookupName: string read GetDefaultStyleLookupName;
    property HelpType: THelpType read FHelpType write FHelpType default htContext;
    property HelpKeyword: string read FHelpKeyword write SetHelpKeyword stored IsHelpContextStored;
    property HelpContext: THelpContext read FHelpContext write SetHelpContext stored IsHelpContextStored default 0;
    property StylesData[const Index: string]: TValue read GetStyleData write SetStyleData;
    property StyleLookup: string read FStyleLookup write SetStyleLookup stored IsStyleLookupStored nodefault;
  end;

{ TStyleBook }

  IDesignStyleBook = interface
  ['{C0DEE038-2C7D-4E37-BB1A-92548465EE74}']
    procedure FillStrings;
    function GetDesignResource: string;
    procedure SetDesignResource(const Value: string);
    property DesignResource: string read GetDesignResource write SetDesignResource;
  end;

{ TStyleContainer }

  TStyleContainer = class(TControl)
  private type
    TLinkRec = record
      Offset, Size: Integer;
    end;
  private
    FBinary: TMemoryStream;
    FBinaryDict: TDictionary<string,TLinkRec>;
  protected
  public
    destructor Destroy; override;
    procedure Release; override;
    procedure LoadFromIndexedStream(const AStream: TStream);
    function FindStyleResource(const AStyleLookup: string; const Clone: Boolean = False): TFmxObject; override;
  end;

{ TStyleBook }

  TStyleBook = class(TFmxObject, IDesignStyleBook)
  private
    FResource: TStrings;
    FStyle: TFmxObject;
    FFileName: string;
    FDesignResource: string;
    FHiResStyleBook: TStyleBook;
    FNeedUpdateStyle: Boolean;
    FNeedRecreateStyle: Boolean;
    procedure SetResource(const Value: TStrings);
    procedure SetFileName(const Value: string);
    procedure DoResourceChanged(Sender: TObject);
    procedure LoadFromFile;
    procedure SetHiResStyleBook(const Value: TStyleBook);
    function IsResourceStored: Boolean;
    procedure RecreateStyleFromResource;
    { IDesignStyleBook }
    procedure FillStrings;
    function GetDesignResource: string;
    procedure SetDesignResource(const Value: string);
  protected
    procedure Loaded; override;
    { vcl }
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadResources(Stream: TStream);
    procedure WriteResources(Stream: TStream);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property Style: TFmxObject read FStyle;
  published
    property FileName: string read FFileName write SetFileName;
    property Resource: TStrings read FResource write SetResource stored IsResourceStored;
    property HiResStyleBook: TStyleBook read FHiResStyleBook write SetHiResStyleBook;
  end;

  TStyleChangedMessage = class(TMessage)
  private
    FStyleBook: TStyleBook;
  public
    constructor Create(const AStyleBook: TStyleBook);
    property StyleBook: TStyleBook read FStyleBook;
  end;

  TBeforeStyleChangingMessage = class(TMessage)
  end;

  TStyleManagerHelper = class helper for TStyleManager
  public
    // Return active style for IScene
    class function ActiveStyleForScene(const Scene: IScene): TFmxObject; static;
    // Return Active Style Descriptor for selected object
    class function GetStyleDescriptionForControl(const AObject: TControl): TStyleDescription;
  end;

{ TTextControl }

  TTextControl = class(TStyledControl, ITextSettings)
  private
    FTextSettings: TTextSettings;
    FLastTextSettings: TTextSettings;
    FDefaultTextSettings: TTextSettings;
    FDefaultShadowSettings: TTextSettings;
    FStyledSettings: TStyledSettings;
    FTextObject: TControl;
    FTextShadow: TControl;
    FITextSettings: ITextSettings;
    FIShadowSettings: ITextSettings;
    FText: string;
    FIsChanging: Boolean;
    FIsDisableDesign: Boolean;
    function IsTextStored: Boolean;
    function GetText: string;
    function GetFont: TFont;
    procedure SetFont(const Value: TFont);
    function GetTextAlign: TTextAlign;
    procedure SetTextAlign(const Value: TTextAlign);
    function GetVertTextAlign: TTextAlign;
    procedure SetVertTextAlign(const Value: TTextAlign);
    function GetWordWrap: Boolean;
    procedure SetWordWrap(const Value: Boolean);
    function GetFontColor: TAlphaColor;
    procedure SetFontColor(const Value: TAlphaColor);
    function GetTrimming: TTextTrimming;
    procedure SetTrimming(const Value: TTextTrimming);
    procedure ReadFontFillColor(Reader: TReader);
    procedure ReadFontFillKind(Reader: TReader);
    { ITextSettings }
    function GetDefaultTextSettings: TTextSettings;
    function GetTextSettings: TTextSettings;
    function GetStyledSettings: TStyledSettings;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure DoStyleChanged; override;
    procedure SetText(const Value: string); virtual;
    procedure SetName(const Value: TComponentName); override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); override;
    procedure Loaded; override;
    function FindTextObject: TFmxObject; virtual;
    property TextObject: TControl read FTextObject;
    { ITextSettings }
    procedure SetTextSettings(const Value: TTextSettings); virtual;
    procedure SetStyledSettings(const Value: TStyledSettings); virtual;
    procedure DoChanged; virtual;
    function StyledSettingsStored: Boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    property Text: string read GetText write SetText stored IsTextStored;
    property DefaultTextSettings: TTextSettings read GetDefaultTextSettings;
    property TextSettings: TTextSettings read GetTextSettings write SetTextSettings;
    property StyledSettings: TStyledSettings read GetStyledSettings write SetStyledSettings stored StyledSettingsStored nodefault;
    procedure Change;
    property Font: TFont read GetFont write SetFont;
    property FontColor: TAlphaColor read GetFontColor write SetFontColor default TAlphaColorRec.Black;
    property VertTextAlign: TTextAlign read GetVertTextAlign write SetVertTextAlign default TTextAlign.taCenter;
    property TextAlign: TTextAlign read GetTextAlign write SetTextAlign default TTextAlign.taLeading;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap default False;
    property Trimming: TTextTrimming read GetTrimming write SetTrimming default TTextTrimming.ttNone;
  end;

{ TContent }

  TContent = class(TControl, IContent)
  private
    FParentAligning: Boolean;
  protected
    procedure DoRealign; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
//    property Hint;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
//    property ShowHint default False;
    property Visible default True;
    property Width;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnClick;
    property OnDblClick;

    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;

    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

{ TPopup }

  TPlacement = (plBottom, plTop, plLeft, plRight,
    plCenter, plBottomCenter, plTopCenter, plLeftCenter,
    plRightCenter, plAbsolute, plMouse, plMouseCenter);

  TPopup = class(TStyledControl)
  private
    FSaveParent: TFmxObject;
    FSaveScale: TPointF;
    FPopupForm: TFmxObject;
    FIsOpen: Boolean;
    FStaysOpen: Boolean;
    FPlacement: TPlacement;
    FPlacementTarget: TControl;
    FPlacementRectangle: TBounds;
    FHorizontalOffset: Single;
    FVerticalOffset: Single;
    FDragWithParent: Boolean;
    FClosingAnimation: Boolean;
    FStyleBook: TStyleBook;
    FModalResult: TModalResult;
    FModal: Boolean;
    FDragTimer: TTimer;
    FOnClosePopup: TNotifyEvent;
    FOnPopup: TNotifyEvent;
    FBorderWidth: Single;
    procedure SetIsOpen(const Value: Boolean);
    procedure SetPlacementRectangle(const Value: TBounds);
    procedure SetModalResult(const Value: TModalResult);
    procedure DoTimer(Sender: TObject);
    function GetPopupForm: TFmxObject;
    function GetFormLeft: Single;
    procedure SetFormLeft(ALeft: Single);
    function GetFormTop: Single;
    procedure SetFormTop(ATop: Single);
    procedure SetStaysOpen(const AValue: Boolean);
    procedure SetPlacementTarget(const Value: TControl);
    procedure SetStyleBook(const Value: TStyleBook);
  protected
    procedure ApplyStyle; override;
    procedure ApplyPlacement; virtual;
    procedure Paint; override;
    procedure SetVisible(const Value: Boolean); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DialogKey(var Key: Word; Shift: TShiftState); override;
    procedure DoClosePopup; virtual;
    procedure DoPopup; virtual;
    procedure DoFormClose(Sender: TObject; var Action: TCloseAction);
    procedure ClosePopup; virtual;
    procedure CreatePopupForm; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function PopupModal: TModalResult; virtual;
    function HasPopupForm: Boolean;
    procedure Popup(const AShowModal: Boolean = False); virtual;
    property ModalResult: TModalResult read FModalResult write SetModalResult;
    property IsOpen: Boolean read FIsOpen write SetIsOpen;
    property PopupForm: TFmxObject read GetPopupForm;
    property BorderWidth : Single read FBorderWidth write FBorderWidth;
  published
    property Align;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property DragWithParent: Boolean read FDragWithParent write FDragWithParent default False;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property HorizontalOffset: Single read FHorizontalOffset write FHorizontalOffset;
    property Padding;
    property Opacity;
    property Margins;
    property Placement: TPlacement read FPlacement write FPlacement default TPlacement.plBottom;
    property PlacementRectangle: TBounds read FPlacementRectangle write SetPlacementRectangle;
    property PlacementTarget: TControl read FPlacementTarget write SetPlacementTarget;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StaysOpen: Boolean read FStaysOpen write SetStaysOpen default False;
    property StyleBook: TStyleBook read FStyleBook write SetStyleBook;
    property StyleLookup;
    property TabOrder;
    property VerticalOffset: Single read FVerticalOffset write FVerticalOffset;
    property Visible default False;
    property Width;
    property Left: Single read GetFormLeft write SetFormLeft;
    property Top: Single read GetFormTop write SetFormTop;

    {events}
    property OnApplyStyleLookup;
    property OnClosePopup: TNotifyEvent read FOnClosePopup write FOnClosePopup;
    property OnPopup: TNotifyEvent read FOnPopup write FOnPopup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnClick;
    property OnDblClick;

    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;

    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

{ TPathAnimation }

  TPathAnimation = class(TAnimation)
  private
    FPath: TPathData;
    FPolygon: TPolygon;
    FObj: TControl;
    FStart: TPointF;
    FRotate: Boolean;
    FSpline: TSpline;
    procedure SetPath(const Value: TPathData);
  protected
    procedure ProcessAnimation; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Start; override;
  published
    property AnimationType default TAnimationType.atIn;
    property AutoReverse default False;
    property Enabled default False;
    property Delay;
    property Duration nodefault;
    property Interpolation default TInterpolationType.itLinear;
    property Inverse default False;
    property Loop default False;
    property OnProcess;
    property OnFinish;
    property Path: TPathData read FPath write SetPath;
    property Rotate: Boolean read FRotate write FRotate default False;
    property Trigger;
    property TriggerInverse;
  end;

  IInflatableContent<T: TStyledControl> = interface
    function GetInflatableItems: TList<T>;
    procedure NotifyInflated;
  end;

  TContentInflater<T: TStyledControl> = class(TInterfacedObject, IInterface)
  strict private
    FInflatable: IInflatableContent<T>;
    procedure ReceiveIdleMessage(const Sender : TObject; const M : FMX.Messages.TMessage);
  public
    constructor Create(const Inflatable: IInflatableContent<T>);
    destructor Destroy; override;
    procedure Inflate(Total: Boolean);
  end;

  TControlsFilter<T: TFmxObject> = class(TEnumerableFilter<TControl,T>)
  end;

  ISearchResponder = interface
    ['{C73631F4-5AD7-48b9-92D2-CC808B911B5E}']
    procedure SetFilterPredicate(const Predicate: TPredicate<string>);
  end;

  IListBoxHeaderTrait = interface
    ['{C7BDF195-C1E2-48f9-9376-1382C60A6BCC}']
  end;

procedure CloseAllPopups;
function IsPopup(const Wnd: TFmxObject): Boolean;
function CanClosePopup(const Wnd: TFmxObject): Boolean;
procedure PopupBringToFront;
procedure ClosePopup(const AIndex: Integer); overload;
procedure ClosePopup(Wnd: TFmxObject); overload;

function GetPopup(const AIndex: Integer): TFmxObject;
function GetPopupCount: Integer;

procedure UpdateStyleSettings(const TextSettings,
                                    LastTextSettings,
                                    DefaultTextSettings: TTextSettings;
                                var StyledSettings: TStyledSettings);

procedure FreeControls;

implementation

uses System.RTLConsts, FMX.Consts, FMX.Forms, FMX.Ani, FMX.Objects,
  FMX.Platform, FMX.Layouts, FMX.Edit, FMX.Header, FMX.ExtCtrls;

type

  TOpenObject = class(TFmxObject);

  TOpenFMXActionLink = class (TActionLink);

  TOpenCustomAction = class (TCustomAction);

  TOpenForm = class(TForm);

{ TCustomControlAction }

constructor TCustomControlAction.Create(AOwner: TComponent);
begin
  inherited;
  DisableIfNoHandler := False;
end;

procedure TCustomControlAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (AComponent = FPopupMenu) and (Operation = opRemove) then
    PopupMenu := nil;
end;

procedure TCustomControlAction.SetPopupMenu(const Value: TCustomPopupMenu);
var
  I: Integer;
  OldPopup: TCustomPopupMenu;
begin
  if Value <> FPopupMenu then
  begin
    OldPopup := FPopupMenu;
    for I := 0 to ClientCount - 1 do
      if Clients[I] is TControlActionLink then
        TControlActionLink(Clients[I]).SetPopupMenu(Value);
    FPopupMenu := Value;
    if Assigned(FPopupMenu) then
      TComponent(FPopupMenu).FreeNotification(self);
    if Assigned(OldPopup) then
      TComponent(OldPopup).RemoveFreeNotification(self);
    Change;
  end;
end;

{ TCustomViewAction }

procedure TCustomViewAction.DoCreateComponent(
  var NewComponent: TComponent);
begin
  if Assigned(FonCreateComponent) then
    FonCreateComponent(self, NewComponent);
end;

procedure TCustomViewAction.DoBeforeShow(var CanShow: boolean);
begin
  if Assigned(FOnBeforeShow) then
    FOnBeforeShow(self, CanShow);
end;

procedure TCustomViewAction.DoAfterShow;
begin
  if Assigned(FOnAfterShow) then
    FOnAfterShow(self);
end;

function TCustomViewAction.HandlesTarget(Target: TObject): Boolean;
begin
  result := True;
end;

procedure TCustomViewAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FComponent) then
    Component := nil;
end;

function TCustomViewAction.ComponentText: string;
begin
  Result := '';
  if Assigned(FComponent) then
  begin
    if FComponent is TCommonCustomForm then
      result := TCommonCustomForm(FComponent).Caption
    else if FComponent is TTextControl then
      result := TTextControl(FComponent).Text
    else
      result := FComponent.Name;
  end;
end;

procedure TCustomViewAction.SetComponent(const Value: TComponent);
begin
  if FComponent <> Value then
  begin
    if Assigned(FComponent) then
    begin
      FComponent.RemoveFreeNotification(self);
      FComponent := nil;
    end;
    FComponent := Value;
    if Assigned(FComponent) then
      FComponent.FreeNotification(self);
    ComponentChanged;
  end;
end;

procedure TCustomViewAction.ComponentChanged;
begin

end;

{ TControlActionLink }

procedure TControlActionLink.AssignClient(AClient: TObject);
begin
  if Not Assigned(AClient) then
    raise EActionError.CreateFMT(SParamIsNil, ['AClient']);
  if (not (AClient is TControl)) then
    raise EActionError.CreateFmt(StrNoClientClass, [AClient.ClassName]);
  FClient := TControl(AClient);
end;

function TControlActionLink.IsCaptionLinked: Boolean;
begin
  Result := (FClient is TTextControl) and
            (inherited IsCaptionLinked) and
            (TTextControl(FClient).Text = TContainedAction(Action).Caption);
end;

function TControlActionLink.ActionCustomViewComponent: boolean;
begin
  Result := (Action is TCustomViewAction) and
            (TCustomViewAction(Action).Component = FClient);
end;

function TControlActionLink.IsCheckedLinked: Boolean;
var ObjChecked: IIsChecked;
begin
  if ActionCustomViewComponent then
  begin
    Result := False;
    Exit;
  end;
  Result := Assigned(FClient) and
            (inherited IsCheckedLinked) and
            ((FClient.QueryInterface(IIsChecked, ObjChecked) = S_OK) or
             (FClient.QueryInterface(IGroupName, ObjChecked) = S_OK)) and
            (ObjChecked.IsChecked = TContainedAction(Action).Checked);
end;

function TControlActionLink.IsEnabledLinked: Boolean;
begin
  if ActionCustomViewComponent then
  begin
    Result := False;
    Exit;
  end;
  Result := (inherited IsEnabledLinked) and
            (FClient.Enabled = TContainedAction(Action).Enabled);
end;

function TControlActionLink.IsGroupIndexLinked: Boolean;
var ObjGroup: IGroupName;
    S: string;
begin
  if ActionCustomViewComponent then
  begin
    Result := False;
    Exit;
  end;
  Result := Assigned(FClient) and
            (inherited IsCheckedLinked) and
            (FClient.QueryInterface(IGroupName, ObjGroup) = S_OK);
  if Result then
  begin
    S := ObjGroup.GroupName;
    Result := (S = '') or
              (S = '0') or
              (S = IntToStr(TContainedAction(Action).GroupIndex));
  end;
end;

function TControlActionLink.IsHelpLinked: Boolean;
begin
  Result := (FClient is TStyledControl) and
            (inherited IsHelpLinked) and
            (TStyledControl(FClient).HelpContext = TContainedAction(Action).HelpContext) and
            (TStyledControl(FClient).HelpKeyword = TContainedAction(Action).HelpKeyword) and
            (TStyledControl(FClient).HelpType = TContainedAction(Action).HelpType);
end;

function TControlActionLink.IsHintLinked: Boolean;
begin
  Result := False;  // Currently the property is not supported.
end;

function TControlActionLink.IsOnExecuteLinked: Boolean;
begin
  if ActionCustomViewComponent or (not FClient.EnableExecuteAction) then
  begin
    Result := False;
    Exit;
  end;
  Result := (inherited IsOnExecuteLinked) and
            (DelegatesEqual(@FClient.OnClick, @Action.OnExecute));
end;

function TControlActionLink.IsVisibleLinked: Boolean;
begin
  if ActionCustomViewComponent then
  begin
    Result := False;
    Exit;
  end;
  Result := (inherited IsVisibleLinked) and
            (FClient.Visible = TContainedAction(Action).Visible);
end;

procedure TControlActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then TTextControl(FClient).Text := Value;
end;

procedure TControlActionLink.SetChecked(Value: Boolean);
var ObjChecked: IIsChecked;
begin
  if IsCheckedLinked and
     ((FClient.QueryInterface(IIsChecked, ObjChecked) = S_OK) or
      (FClient.QueryInterface(IGroupName, ObjChecked) = S_OK)) then
    ObjChecked.IsChecked := Value;
end;

procedure TControlActionLink.SetEnabled(Value: Boolean);
begin
  if IsEnabledLinked then FClient.Enabled := Value;
end;

procedure TControlActionLink.SetGroupIndex(Value: Integer);
begin
  if IsGroupIndexLinked then
    (FClient as IGroupName).GroupName := inttostr(Value);
end;

procedure TControlActionLink.SetHelpContext(Value: THelpContext);
begin
  if IsHelpLinked then TStyledControl(FClient).HelpContext := Value;
end;

procedure TControlActionLink.SetHelpKeyword(const Value: string);
begin
  if IsHelpLinked then TStyledControl(FClient).HelpKeyword := Value;
end;

procedure TControlActionLink.SetHelpType(Value: THelpType);
begin
  if IsHelpLinked then TStyledControl(FClient).HelpType := Value;
end;

procedure TControlActionLink.SetOnExecute(Value: TNotifyEvent);
begin
  if IsOnExecuteLinked then FClient.OnClick := Value;
end;

procedure TControlActionLink.SetVisible(Value: Boolean);
begin
  if IsVisibleLinked then FClient.Visible := Value;
end;

function TControlActionLink.IsPopupMenuLinked: boolean;
begin
  Result := (FClient is TControl) and
            (Action is TCustomControlAction) and
            (TControl(FClient).PopupMenu = TCustomControlAction(Action).PopupMenu);
end;

procedure TControlActionLink.SetPopupMenu(const Value: TCustomPopupMenu);
begin
  if IsPopupMenuLinked then TControl(FClient).PopupMenu := Value;
end;

{ TCaret }

class function TCaret.FlasherName: string;
begin
  Result := FMXFlasher;
end;

procedure ShowVirtualKeyboard(const Displayed: boolean;
                              const Caret: TCustomCaret;
                              var VirtualKeyBoardState: TVirtualKeyBoardState);
var
  VKbSvc: IFMXVirtualKeyboardService;
begin
  VirtualKeyBoardState := [];
  if (TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(VKbSvc))) then
  begin
    if Displayed and
       Assigned(Caret) and
       (not TCaret(Caret).ReadOnly) then
    begin
      VirtualKeyBoardState := VKbSvc.VirtualKeyBoardState;
      if (vksAutoShow in VirtualKeyBoardState) and
         (not (vksError in VirtualKeyBoardState)) then
      begin
        if VKbSvc.ShowVirtualKeyboard(Caret.Owner) then
          VirtualKeyBoardState := VirtualKeyBoardState + [vksVisible]
        else
          VirtualKeyBoardState := VirtualKeyBoardState - [vksVisible]
      end;
    end
    else
    begin
      VirtualKeyBoardState := VKbSvc.VirtualKeyBoardState;
      if (vksAutoShow in VirtualKeyBoardState) and
         (not (vksError in VirtualKeyBoardState)) and
         (VKbSvc.HideVirtualKeyboard) then
      begin
        VirtualKeyBoardState := VirtualKeyBoardState - [vksVisible];
      end;
    end;
  end;
end;

{ TControl }

constructor TControl.Create(AOwner: TComponent);
var
  DefaultSize: TSizeF;
begin
  inherited;
  FSimpleTransform := True;
  FTabOrder := -1;
  FAddingToTabList := False;
  FEnabled := True;
  FRecalcEnabled := True;
  FEnableDragHighlight := True;
  FDesignVisible := True;
  FOpacity := 1;
  FLocalMatrix := IdentityMatrix;
  FPadding := TBounds.Create(RectF(0, 0, 0, 0));
  FPadding.OnChange := PaddingChanged;
  FMargins := TBounds.Create(RectF(0, 0, 0, 0));
  FMargins.OnChange := MarginsChanged;
  FPosition := TPosition.Create(PointF(0, 0));
  FScale := TPosition.Create(PointF(1, 1));
  FSkew := TPosition.Create(PointF(0, 0));
  FRotationCenter := TPosition.Create(PointF(0.5, 0.5));
  FPosition.OnChange := MatrixChanged;
  FScale.OnChange := MatrixChanged;
  FSkew.OnChange := MatrixChanged;
  FRotationCenter.OnChange := MatrixChanged;
  FTouchTargetExpansion := TBounds.Create(RectF(0, 0, 0, 0));
  FAnchors := [TAnchorKind.akLeft, TAnchorKind.akTop];
  DefaultSize := GetDefaultSize;
  FWidth := DefaultSize.Width;
  FHeight := DefaultSize.Height;
  FLastWidth := FWidth;
  FLastHeight := FHeight;
  FVisible := True;
  FHitTest := True;
  FRecalcAbsolute := True;
  FRecalcOpacity := True;
  FUpdateEffects := True;
  FRecalcUpdateRect := True;
  FCanFocus := False;
  FAcceptsControls := True;
  FDesignSelectionMarks := True;
  FInheritedCursor := crDefault;
end;

procedure TControl.DoDeleteChildren;
begin
  inherited;
  if Assigned(FControls) then
    FreeAndNil(FControls);
  if Assigned(FEffects) then
    FEffects.Clear;
end;

destructor TControl.Destroy;
begin
  FreeAndNil(FEffectBitmap);
  FreeAndNil(FControls);
  if Assigned(FEffects) then
    FreeAndNil(FEffects);
  FreeAndNil(FPadding);
  FreeAndNil(FMargins);
  FreeAndNil(FRotationCenter);
  FreeAndNil(FScale);
  FreeAndNil(FSkew);
  FreeAndNil(FPosition);
  FreeAndNil(FTouchTargetExpansion);
  inherited;
end;

procedure TControl.Loaded;
begin
  inherited;
  if csDestroying in ComponentState then
    Exit;
  FLastWidth := FWidth;
  FLastHeight := FHeight;

  MatrixChanged(Self);

  UpdateAnchorRules;

  if Assigned(Children) and (ChildrenCount > 0) then
    Realign;
  if Assigned(FRoot) and Assigned(FRoot.GetActiveControl) and (FRoot.GetActiveControl.GetObject = Self) then
    SetFocus;
end;

procedure TControl.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('FixedWidth', ReadFixedWidth, WriteFixedWidth, FFixedSize.Width <> 0);
  Filer.DefineProperty('FixedHeight', ReadFixedHeight, WriteFixedHeight, FFixedSize.Height <> 0);
end;

procedure TControl.ReadFixedWidth(Reader: TReader);
begin
  FFixedSize.Width := Reader.ReadInteger;
end;

procedure TControl.WriteFixedWidth(Writer: TWriter);
begin
  Writer.WriteInteger(FFixedSize.Width);
end;

procedure TControl.ReadFixedHeight(Reader: TReader);
begin
  FFixedSize.Height := Reader.ReadInteger;
end;

procedure TControl.WriteFixedHeight(Writer: TWriter);
begin
  Writer.WriteInteger(FFixedSize.Height);
end;

procedure TControl.NeedUpdateEffects;
begin
  UpdateEffects;
  FRecalcUpdateRect := True;
  FRecalcHasEffect := True;
  Repaint;
end;

procedure TControl.BeforeEffectEnabledChanged(const Enabled: Boolean);
begin
  if not Enabled then
    Repaint;
end;

procedure TControl.EffectEnabledChanged(const Enabled: Boolean);
begin
  NeedUpdateEffects;
  RecalcHasEffect;
end;

procedure TControl.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited ;
  if (Operation = opRemove) and (AComponent = FPopupMenu) then
    FPopupMenu := nil;
end;

procedure TControl.DoAddObject(const AObject: TFmxObject);
var
  AlignObject: IAlignableObject;
  IsTControl: Boolean;
  NeedRepaint: Boolean;
begin
  IsTControl := AObject is TControl;
  NeedRepaint := False;
  if IsTControl then
    TControl(AObject).FUpdating := FUpdating;

  inherited DoAddObject(AObject);

  if Supports(AObject, IAlignableObject, AlignObject) and
     ((AlignObject.Align <> TAlignLayout.alNone) or (AlignObject.Anchors <> [TAnchorKind.akLeft, TAnchorKind.akTop])) then
    FNeedAlign := True;
  if (AObject is TEffect) then
  begin
    AddToEffectsList(TEffect(AObject));
    if TEffect(AObject).Enabled then
    begin
      RecalcHasEffect;
      if not (csLoading in ComponentState) then
      begin
        RecalcUpdateRect;
        NeedRepaint := True;
      end;
    end;
  end;
  if IsTControl then
  begin
    if not Assigned(FControls) then
    begin
      FControls := TControlList.Create;
      FControls.Capacity := 10;
    end;
    TControl(AObject).SetNewScene(FScene);
    if Assigned(TempCanvas) then
      TControl(AObject).TempCanvas := TempCanvas;
    if FInPaintTo then
      TControl(AObject).FInPaintTo := True;
    TControl(AObject).FUpdating := FUpdating;
    if not FSimpleTransform then
      TControl(AObject).FSimpleTransform := False;
    TControl(AObject).RecalcOpacity;
    TControl(AObject).RecalcAbsolute;
    TControl(AObject).RecalcUpdateRect;
    TControl(AObject).RecalcHasClipParent;
    RecalcHasEffect;
    FControls.Add(TControl(AObject));
    if HasEffect then
    begin
      UpdateEffects;
      NeedRepaint := True;
    end;
    if (TControl(AObject).Align <> TAlignLayout.alNone) then
      Realign
    else
      NeedRepaint := True;
  end;
  RefreshInheritedCursorForChildren;
  if NeedRepaint then
    Repaint;
end;

procedure TControl.DoRemoveObject(const AObject: TFmxObject);
begin
  inherited;
  if (AObject is TControl) then
  begin
    if Assigned(FControls)  then
      FControls.Remove(TControl(AObject));
    TControl(AObject).FUpdating := 0;
    if not (csDestroying in ComponentState) and Assigned(Scene) then
    begin
      if Assigned(Canvas) and (TCanvasStyle.SupportClipRects in Canvas.GetCanvasStyle) then
        Scene.AddUpdateRect(TControl(AObject).UpdateRect)
      else
        Scene.AddUpdateRect(NullRect);
    end;
    TControl(AObject).SetNewScene(nil);
    if (TControl(AObject).Align <> TAlignLayout.alNone) then
      Realign;
  end;
  if AObject is TEffect then
  begin
    RemoveFromEffectsList(TEffect(AObject));
    RecalcHasEffect;
  end;
  if (AObject is TControl) then
  begin
    ChildrenAlignChanged;
    if Assigned(TControl(AObject).TempCanvas) then
      TControl(AObject).TempCanvas := nil;
    if TControl(AObject).FInPaintTo then
      TControl(AObject).FInPaintTo := False;
  end;
end;

{ matrix }

procedure TControl.MatrixChanged(Sender: TObject);
begin
  DoMatrixChanged(Sender);
end;

procedure TControl.RecalcUpdateRect;
var
  I: Integer;
begin
  FRecalcUpdateRect := True;
  if Assigned(FControls) then
    for I := GetFirstVisibleObjectIndex to GetLastVisibleObjectIndex - 1 do
      if I < FControls.Count then
        FControls[I].RecalcUpdateRect;
end;

function TControl.GetUpdateRect: TRectF;
var
  R: TRectF;
  P: TControl;
  I: Integer;
begin
  if FRecalcUpdateRect then
  begin
    FRecalcUpdateRect := False;
    FUpdating := FUpdating + 1;
    FUpdateRect := AbsoluteRect;
    if not (csLoading in ComponentState) then
    begin
      P := ParentControl;
      while Assigned(P) do
      begin
        if P.ClipChildren or P.SmallSizeControl then
          IntersectRect(FUpdateRect, FUpdateRect, P.UpdateRect);
        P := P.ParentControl;
      end;
      if Assigned(Canvas) and IntersectRect(FUpdateRect, RectF(0, 0, Canvas.Width, Canvas.Height)) and not FInPaintTo then
        IntersectRect(FUpdateRect, FUpdateRect, RectF(0, 0, Canvas.Width, Canvas.Height));
      if not FUpdateRect.IsEmpty then
      begin
        { Focused }
        if CanFocus and IsFocused then
          InflateRect(FUpdateRect, 5, 5);
        { Effects }
        if HasEffect and not (ClipChildren or SmallSizeControl) then
        begin
          R := GetEffectsRect;
          R := NormalizeRectF([LocalToAbsolute(R.TopLeft), LocalToAbsolute(PointF(R.Right, R.Top)),
            LocalToAbsolute(R.BottomRight), LocalToAbsolute(PointF(R.Left, R.Bottom))]);
          FUpdateRect := UnionRect(FUpdateRect, R);
        end;
        { Children }
        if not (ClipChildren or SmallSizeControl) and (ControlsCount > 0) then
        begin
          for I := GetLastVisibleObjectIndex - 1 downto GetFirstVisibleObjectIndex do
          begin
            if not FControls[I].Visible then
              Continue;
            R := FControls[I].UpdateRect;
            FUpdateRect := UnionRect(FUpdateRect, R);
          end;
        end;
        { inflate rect - remove antialiasing artefacts }
        if not FUpdateRect.IsEmpty then
          InflateRect(FUpdateRect, 1, 1);
      end
      else
        Disappear;
    end;
    FUpdating := FUpdating - 1;
  end;
  Result := FUpdateRect;
end;

function TControl.GetVisible: Boolean;
begin
  Result := Visible;
end;

function TControl.GetWidth: single;
begin
  Result := FWidth;
end;

function TControl.GetChildrenRect: TRectF;
var
  I: Integer;
  Control: TControl;
begin
  Result := AbsoluteRect;
  { children }
  if not (ClipChildren or SmallSizeControl) and Assigned(FControls) then
    for I := GetFirstVisibleObjectIndex to GetLastVisibleObjectIndex - 1 do
    begin
      Control := FControls[I];
      if Control.Visible then
        Result := UnionRect(Result, Control.GetChildrenRect);
    end
end;

function TControl.GetAbsoluteWidth: Single;
var
  V: TVector;
begin
  V := LocalToAbsoluteVector(Vector(Width, Height));
  Result := V.X;
end;

function TControl.GetAlign: TAlignLayout;
begin
  Result := FAlign;
end;

function TControl.GetAllowAlign: Boolean;
begin
  Result := Visible or ((FAnchors * [TAnchorKind.akRight, TAnchorKind.akBottom] <> []) and (FAlign = TAlignLayout.alNone));
end;

function TControl.GetAnchors: TAnchors;
begin
  Result := FAnchors;
end;

function TControl.GetAnchorRules : TPointF;
begin
  Result := FAnchorRules;
end;

function TControl.GetAnchorOrigin : TPointF;
begin
  Result := FAnchorOrigin;
end;

function TControl.GetAnchorMove: Boolean;
begin
  Result := FAnchorMove;
end;

procedure TControl.SetAnchorMove(Value: Boolean);
begin
  FAnchorMove := Value;
end;

function TControl.GetOriginalParentSize : TPointF;
begin
  Result := FOriginalParentSize;
end;

function TControl.GetAbsoluteHeight: Single;
var
  V: TVector;
begin
  V := LocalToAbsoluteVector(Vector(Width, Height));
  Result := V.Y;
end;

function TControl.GetAbsoluteScale: TPointF;
var
  P: TFmxObject;
begin
  Result := Scale.Point;
  P := Parent;
  while Assigned(P) do
  begin
    if P is TControl then
    begin
      Result.X := Result.X * TControl(P).Scale.X;
      Result.Y := Result.Y * TControl(P).Scale.Y;
    end;
    P := P.Parent;
  end;
end;

function TControl.GetChildrenMatrix(var Matrix: TMatrix; var Simple: Boolean): Boolean;
begin
  Simple := True;
  Result := False;
end;

function TControl.GetAbsoluteMatrix: TMatrix;
var
  ChildrenMatrix, FinalLocalMatrix: TMatrix;
  SimpleChildrenTransform: Boolean;
begin
  if FRecalcAbsolute then
  begin
    if Assigned(FParentControl) then
    begin
      if FParentControl.GetChildrenMatrix(ChildrenMatrix, SimpleChildrenTransform) then
      begin
        FinalLocalMatrix := MatrixMultiply(FLocalMatrix, ChildrenMatrix);
        FSimpleTransform := FSimpleTransform and SimpleChildrenTransform;
      end
      else
        FinalLocalMatrix := FLocalMatrix;

      if FParentControl.FSimpleTransform and FSimpleTransform then
      begin
        FAbsoluteMatrix := FParentControl.AbsoluteMatrix;
        FAbsoluteMatrix.m31 := FAbsoluteMatrix.m31 + FinalLocalMatrix.m31;
        FAbsoluteMatrix.m32 := FAbsoluteMatrix.m32 + FinalLocalMatrix.m32;
        FInvAbsoluteMatrix := FAbsoluteMatrix;
        FInvAbsoluteMatrix.m31 := -FInvAbsoluteMatrix.m31;
        FInvAbsoluteMatrix.m32 := -FInvAbsoluteMatrix.m32;
      end else begin
        if not FParentControl.FSimpleTransform then
          FSimpleTransform := False;
        FAbsoluteMatrix := MatrixMultiply(FinalLocalMatrix, FParentControl.AbsoluteMatrix);
        FInvAbsoluteMatrix := FAbsoluteMatrix;
        InvertMatrix(FInvAbsoluteMatrix);
      end;
    end
    else
    begin
      FAbsoluteMatrix := FLocalMatrix;
      FInvAbsoluteMatrix := FAbsoluteMatrix;
      InvertMatrix(FInvAbsoluteMatrix);
    end;

    Result := FAbsoluteMatrix;

    FRecalcAbsolute := False;
  end
  else
    Result := FAbsoluteMatrix;
end;

function TControl.GetInvertAbsoluteMatrix: TMatrix;
begin
  AbsoluteMatrix; // Force recalaculation if need
  Result := FInvAbsoluteMatrix;
end;

procedure TControl.RecalcAbsoluteNow;
var
  I: Integer;
begin
  AbsoluteMatrix;
  // recalc
  if Assigned(FControls) then
    for I := 0 to FControls.Count - 1 do
      FControls[I].RecalcAbsoluteNow;
end;

procedure TControl.RecalcAbsolute;
var
  I: Integer;
begin
  if FRecalcAbsolute then Exit;
  FRecalcAbsolute := True;

  if Assigned(FControls) then
    for I := 0 to FControls.Count - 1 do
    begin
      if not FSimpleTransform then
        FControls[I].FSimpleTransform := False;
      FControls[I].RecalcAbsolute;
    end;
end;

procedure TControl.ActionChange(Sender: TBasicAction; CheckDefaults: Boolean);
begin
  if Sender is TCustomAction then
  begin
    if (not CheckDefaults) or (Enabled = True) then
      Enabled := TCustomAction(Sender).Enabled;
    if (not CheckDefaults) or (Hint = '') then
      Hint := TCustomAction(Sender).Hint;
    if (not CheckDefaults) or (Visible = True) then
      Visible := TCustomAction(Sender).Visible;
    if (EnableExecuteAction) and ((not CheckDefaults) or (@OnClick = nil)) then
      OnClick := TCustomAction(Sender).OnExecute;
    if Sender is TCustomControlAction then
    begin
      if (not CheckDefaults) or (Not Assigned(PopupMenu)) then
        PopupMenu := TCustomControlAction(Sender).PopupMenu;
    end;
  end;
  inherited;
end;

function TControl.AbsoluteToLocalVector(P: TVector): TVector;
begin
  P.W := 0;
  if FInPaintTo then
    Result := FInPaintToAbsMatrix.Transform(P)
  else
    if FSimpleTransform then
      Result := P
    else
      Result := InvertAbsoluteMatrix.Transform(P);
end;

function TControl.LocalToAbsoluteVector(P: TVector): TVector;
begin
  P.W := 0;
  if FInPaintTo then
    Result := FInPaintToInvMatrix.Transform(P)
  else
    if FSimpleTransform then
      Result := P
    else
      Result := AbsoluteMatrix.Transform(P);
end;

function TControl.AbsoluteToLocal(P: TPointF): TPointF;
var
  V: TVector;
begin
  V.X := P.X;
  V.Y := P.Y;
  V.W := 1;
  if FInPaintTo then
    V := FInPaintToInvMatrix.Transform(V)
  else begin
    if FSimpleTransform then
    begin
      V.X := P.X + InvertAbsoluteMatrix.m31;
      V.Y := P.Y + InvertAbsoluteMatrix.m32;
    end else
      V := InvertAbsoluteMatrix.Transform(V);
  end;
  Result.X := V.X;
  Result.Y := V.Y;
end;

function TControl.LocalToAbsolute(P: TPointF): TPointF;
var
  V: TVector;
begin
  V.X := P.X;
  V.Y := P.Y;
  V.W := 1;
  if FInPaintTo then
    V := FInPaintToAbsMatrix.Transform(V)
  else begin
    if FSimpleTransform then
    begin
      V.X := P.X + AbsoluteMatrix.m31;
      V.Y := P.Y + AbsoluteMatrix.m32;
    end else
      V := AbsoluteMatrix.Transform(V);
  end;
  Result := PointF(V.X, V.Y);
end;

{ Opacity }

function TControl.GetAbsoluteOpacity: Single;
begin
  if FRecalcOpacity then
  begin
    if Assigned(FParentControl) then
      FAbsoluteOpacity := FOpacity * FParentControl.AbsoluteOpacity
    else
      FAbsoluteOpacity := FOpacity;

    if not AbsoluteEnabled { and (FScene)) {and ((FScene.GetRoot <> Self) and (FScene.GetRoot <> Parent)) }
    then
      FAbsoluteOpacity := FAbsoluteOpacity * 0.8;

    Result := FAbsoluteOpacity;

    FRecalcOpacity := False;
  end
  else
  begin
    Result := FAbsoluteOpacity;
  end;
end;

procedure TControl.RecalcOpacity;
var
  I: Integer;
begin
  if FRecalcOpacity then Exit;
  FRecalcOpacity := True;
  if Assigned(FControls) then
    for I := 0 to FControls.Count - 1 do
      FControls[I].RecalcOpacity;
end;

{ methods }

class constructor TControl.Create;
begin
  FEmptyControlList := TControlList.Create;
end;

class destructor TControl.Destroy;
begin
  FreeAndNil(FEmptyControlList);
end;

function TControl.PointInObject(X, Y: Single): Boolean;
var
  P: TPointF;
begin
  P := AbsoluteToLocal(PointF(X, Y));
  Exit(PointInObjectLocal(P.X, P.Y));
end;

function TControl.PointInObjectLocal(X, Y: Single): Boolean;
begin
  Result := (X >= (0 - TouchTargetExpansion.Left))
        and (X <= (Width + TouchTargetExpansion.Right))
        and (Y >= (0 - TouchTargetExpansion.Top))
        and (Y <= (Height + TouchTargetExpansion.Bottom));
end;

function TControl.ScreenToLocal(P: TPointF): TPointF;
begin
  if Assigned(Scene) then
    Result := AbsoluteToLocal(Scene.ScreenToLocal(P))
  else
    Result := AbsoluteToLocal(P);
end;

function TControl.LocalToScreen(P: TPointF): TPointF;
begin
  if Assigned(Scene) then
    Result := Scene.LocalToScreen(LocalToAbsolute(P))
  else
    Result := LocalToAbsolute(P);
end;

procedure TControl.ChangeChildren;
var
  I, C: Integer;
  Changes: Integer;
begin
  inherited;
  Changes := 0;
  if not(csLoading in ComponentState) and Assigned(FControls) then
  begin
    C := 0;
    for I := 0 to ChildrenCount - 1 do
      if (Children[I] is TControl) then
      begin
        if C = FControls.Count then
          FControls.Add(TControl(Children[I]))
        else
          if FControls[C] <> TControl(Children[I]) then
          begin
            Inc(Changes);
            FControls[C] := TControl(Children[I]);
          end;
        Inc(C);
      end;
    while C < Controls.Count do
    begin
      Inc(Changes);
      FControls.Delete(FControls.Count - 1);
    end;
    if Changes > 0 then
      Realign;
  end;
end;

procedure TControl.ChangeOrder;
var
  AlignRoot: IAlignRoot;
begin
  inherited;
  if not(csLoading in ComponentState) and Supports(Parent, IAlignRoot, AlignRoot) then
    AlignRoot.Realign;
end;

procedure TControl.ChangeParent;
begin
  inherited;
  if Assigned(FParent) and (FParent is TControl) then
    FParentControl := TControl(FParent)
  else
    FParentControl := nil;
  RefreshInheritedCursor;
end;

function TControl.CheckForAllowFocus: Boolean;
begin
  Result := ParentedVisible and CanFocus and AbsoluteEnabled
end;

function TControl.CheckHitTest(const AHitTest: Boolean): Boolean;
begin
  Result := FHitTest;
  if (csDesigning in ComponentState) then
    Result := True;
  if (csDesigning in ComponentState) and FLocked then
    Result := False;
  if (csDesigning in ComponentState) and not FDesignVisible then
    Result := False;
end;

procedure TControl.ChildrenAlignChanged;
var
  I: Integer;
  AlignObject: IAlignableObject;
begin
  FNeedAlign := False;
  UpdateAnchorRules;
  if Assigned(Children) then
    for I := 0 to ChildrenCount - 1 do
      if Supports(Children[I], IAlignableObject, AlignObject) and
         ((AlignObject.Align <> TAlignLayout.alNone) or (AlignObject.Anchors <> [TAnchorKind.akLeft, TAnchorKind.akTop])) then
      begin
        FNeedAlign := True;
        Break;
      end;
end;

function TControl.FillTextFlags: TFillTextFlags;
begin
  if Assigned(FRoot) and (FRoot.BiDiMode = bdRightToLeft) then
  begin
    Result := [TFillTextFlag.ftRightToLeft]
  end
  else
    Result := [];
end;

function TControl.FindTarget(P: TPointF; const Data: TDragObject): IControl;
var
  I: Integer;
  NewObj: IControl;
  LP: TPointF;
begin
  Result := nil;
  if not Visible then
    Exit;
  if not AbsoluteEnabled and not(csDesigning in ComponentState) then
    Exit;
  LP := P;
  if Assigned(FScene) then
    LP := FScene.ScreenToLocal(LP);
  if (ClipChildren or SmallSizeControl) and not PointInObject(LP.X, LP.Y) then
    Exit;
  if Assigned(Children) then
    for I := ChildrenCount - 1 downto 0 do
    begin
      if not Supports(TFmxObject(Children[I]), IControl, NewObj) then
        Continue;
      if not NewObj.Visible then
        Continue;

      NewObj := NewObj.FindTarget(P, Data);
      if Assigned(NewObj) then
      begin
        Result := NewObj;
        Exit;
      end;
    end;

  if PointInObject(LP.X, LP.Y) and CheckHitTest(HitTest) then
    Result := Self;
end;

function TControl.ObjectAtPoint(P: TPointF): IControl;
var
  I: Integer;
  NewObj: IControl;
  Control: TControl;
  LP: TPointF;
begin
  if not FDesignVisible and (csDesigning in ComponentState) then
  begin
    Result := nil;
    Exit;
  end;
  if not Visible and not(csDesigning in ComponentState) then
  begin
    Result := nil;
    Exit;
  end;
  if not AbsoluteEnabled and not(csDesigning in ComponentState) then
  begin
    Result := nil;
    Exit;
  end;
  LP := P;
  if Assigned(FScene) then
    LP := FScene.ScreenToLocal(LP);
  if (ClipChildren or SmallSizeControl) and not PointInObject(LP.X, LP.Y) then
  begin
    Result := nil;
    Exit;
  end;
  if ControlsCount > 0 then
    for I := GetLastVisibleObjectIndex - 1 downto GetFirstVisibleObjectIndex do
    begin
      Control := Controls[I];
      if not Control.GetVisible and not(csDesigning in ComponentState) then
        Continue;

      NewObj := Control.ObjectAtPoint(P);
      if Assigned(NewObj) then
      begin
        Result := NewObj;
        Exit;
      end;
    end;

  Result := nil;
  if PointInObject(LP.X, LP.Y) and CheckHitTest(HitTest) then
    Result := Self;
end;

function TControl.OnClickStored: Boolean;
begin
  Result := (not (ActionClient and
                 (ActionLink is TActionLink) and
                 (TOpenFMXActionLink(ActionLink).IsOnExecuteLinked) and
                 (Action is TContainedAction)))
end;

function TControl.GetCanvas: TCanvas;
begin
  if Assigned(FTempCanvas) then
    Result := FTempCanvas
  else
    if Assigned(FScene) then
      Result := FScene.GetCanvas
    else
      Result := nil;
end;

procedure TControl.RefreshInheritedCursor;

  function GetParentInheritedCursor: TCursor;
  begin
    Result := crDefault;
    if Assigned(ParentControl) then
      Result := ParentControl.InheritedCursor;
    if Parent is TCommonCustomForm then
      Result := (Parent as TCommonCustomForm).Cursor;
  end;

var
  CursorTmp: TCursor;
begin
  if (Cursor = crDefault) and Assigned(Parent) then
    CursorTmp := GetParentInheritedCursor
  else
    CursorTmp := Cursor;

  if FInheritedCursor <> CursorTmp then
  begin
    FInheritedCursor := CursorTmp;
    RefreshInheritedCursorForChildren;
  end;
end;

procedure TControl.RefreshInheritedCursorForChildren;
var
  ChildControl: TControl;
begin
  if Controls.Count > 0 then
    for ChildControl in Controls do
      if ChildControl.Cursor = crDefault then
         ChildControl.RefreshInheritedCursor;
end;

procedure TControl.SetInPaintTo(Value: Boolean);
var
  I: Integer;
begin
  FInPaintTo := Value;
  FInPaintToAbsMatrix := AbsoluteMatrix;
  FInPaintToInvMatrix := InvertAbsoluteMatrix;
  if Assigned(FControls) then
    for I := 0 to FControls.Count - 1 do
      FControls[I].SetInPaintTo(Value);
end;

function TControl.GetIsChildFocused: boolean;
begin
  Result := FIsChildFocused;
end;

procedure TControl.SetIsChildFocused(const Value: boolean);
begin
  FIsChildFocused := Value;
end;

function TControl.GetIsFocused: Boolean;
begin
  Result := FIsFocused;
end;

procedure TControl.PaintTo(const ACanvas: TCanvas; const ARect: TRectF; const AParent: TFmxObject = nil);
var
  SaveTempCanvas: TCanvas;
  SaveDisableAlign: Boolean;
  SavePos: TPointF;
  SaveScale: TPointF;
  SaveParent: TFmxObject;
  SaveRotate: Single;
  SaveInPaintTo: Boolean;
begin
  if (Width < 1) or (Height < 1) then
    Exit;
  SaveDisableAlign := FDisableAlign;
  SaveInPaintTo := FInPaintTo;
  FDisableAlign := True;
  try
    SetInPaintTo(True);
    SaveTempCanvas := TempCanvas;
    try
      TempCanvas := ACanvas;
      { save }
      SavePos := Position.Point;
      SaveScale := Scale.Point;
      SaveParent := FParent;
      SaveRotate := RotationAngle;
      FParent := AParent;
      ChangeParent;
      FPosition.SetPointNoChange(PointF(ARect.Left, ARect.Top));
      FScale.SetPointNoChange(PointF(RectWidth(ARect) / Width, RectHeight(ARect) / Height));
      FRotationAngle := 0;
      MatrixChanged(Self);

      { paint }
      RecalcHasEffect;
      TempCanvas.SetMatrix(AbsoluteMatrix);
      PaintInternal;

      { restore }
      FRotationAngle := SaveRotate;
      FPosition.SetPointNoChange(SavePos);
      FScale.SetPointNoChange(SaveScale);
      FParent := SaveParent;
      ChangeParent;
      MatrixChanged(Self);
      RecalcUpdateRect;
      RecalcAbsoluteNow;
      RecalcOpacity;
      RecalcEnabled;
      RecalcHasEffect;
    finally
      TempCanvas := SaveTempCanvas;
    end;
  finally
    SetInPaintTo(SaveInPaintTo);
    FDisableAlign := SaveDisableAlign;
  end;
end;

procedure TControl.UpdateEffects;
begin
  if HasEffect then
    FUpdateEffects := True;
  if Assigned(FParentControl) then
    FParentControl.UpdateEffects;
end;

procedure TControl.UpdateExplicitBounds;
begin
if not (csReading in ComponentState) then
  begin
    FExplicitLeft := FLeft;
    FExplicitTop := FTop;
    FExplicitWidth := FWidth;
    FExplicitHeight := FHeight;
  end;
end;

procedure TControl.ApplyEffect;
var
  R: TRectF;
  Effect: TEffect;
  EffectRect: TRectF;
  S: TPointF;
begin
  if (not Assigned(Children))
    or (not Assigned(FScene))
    or FDisableEffect
    or (not HasEffect) then Exit;

  if not FUpdateEffects then
  begin
    if Assigned(FEffectBitmap) and Assigned(FEffects) and (FEffects.Count > 0) then
    begin
      Canvas.SetMatrix(AbsoluteMatrix);
      for Effect in FEffects do
        if Effect.Enabled then
        begin
          EffectRect := Effect.GetRect(RectF(0, 0, Width, Height));
          Canvas.DrawBitmap(FEffectBitmap, RectF(0, 0, FEffectBitmap.Width, FEffectBitmap.Height), EffectRect, AbsoluteOpacity, RotationAngle = 0);
          Break;
        end;
    end;
  end else begin
    if Assigned(FEffects) and (FEffects.Count > 0) then
      for Effect in FEffects do
        if Effect.Enabled then
        begin
          EffectRect := Effect.GetRect(RectF(0, 0, Width, Height));
          S := GetAbsoluteScale;
          MultiplyRect(EffectRect, S.X, S.Y);
          if not Assigned(FEffectBitmap) then
            FEffectBitmap := TBitmap.Create(trunc(RectWidth(EffectRect)), trunc(RectHeight(EffectRect)))
          else if (FEffectBitmap.Width <> trunc(RectWidth(EffectRect))) or (FEffectBitmap.Height <> trunc(RectHeight(EffectRect))) then
            FEffectBitmap.SetSize(trunc(RectWidth(EffectRect)), trunc(RectHeight(EffectRect)));
          { Paint Self }
          R := RectF(Effect.GetOffset.X, Effect.GetOffset.Y, (Effect.GetOffset.X + Width), (Effect.GetOffset.Y + Height));
          MultiplyRect(R, S.X, S.Y);
          if not (esDisablePaintToBitmap in Effect.EffectStyle) then
          begin
            if FEffectBitmap.Canvas.BeginScene then
            try
              FEffectBitmap.Canvas.Clear(0);
              PaintTo(FEffectBitmap.Canvas, R);
            finally
              FEffectBitmap.Canvas.EndScene;
            end;
          end
          else
          begin
            FEffectBitmap.ClearRect(R, 0);
          end;
          { apply effects }
          Effect.ProcessEffect(FEffectBitmap.Canvas, FEffectBitmap, S.X);
          { draw effectBitmap }
          MultiplyRect(EffectRect, 1 / S.X, 1 / S.Y);
          Canvas.SetMatrix(AbsoluteMatrix);
          Canvas.DrawBitmap(FEffectBitmap, RectF(0, 0, FEffectBitmap.Width, FEffectBitmap.Height), EffectRect, AbsoluteOpacity, RotationAngle = 0);
          Break;
        end;
    FUpdateEffects := False;
  end;
end;

procedure TControl.Painting;
begin
  if Assigned(FOnPainting) then
    FOnPainting(Self, Canvas, LocalRect);
end;

procedure TControl.Paint;
begin
end;

procedure TControl.PaintInternal;
var
  ClipParentObject: TControl;
  State, State1: TCanvasSaveState;
  R: TRectF;
  SupportsStage: Boolean;
begin
  if FDisablePaint or (Width < 1) or (Height < 1) then Exit;
  SupportsStage := SupportsPaintStage(FPaintStage);
  if not HasDisablePaintEffect or FInPaintTo then
  begin
    ClipParentObject := HasClipParent;
    if Assigned(ClipParentObject) then
    begin
      State1 := Canvas.SaveState;
      try
        Canvas.SetMatrix(ClipParentObject.AbsoluteMatrix);
        R := ClipParentObject.LocalRect;
        Canvas.ExcludeClipRect(R);
        if (ClipChildren or SmallSizeControl) then
        begin
          // Clip self
          State := Canvas.SaveState;
          try
            Canvas.SetMatrix(AbsoluteMatrix);
            Canvas.IntersectClipRect(ClipRect);
            if HasEffect and not HasAfterPaintEffect and not (FInPaintTo) then
              ApplyEffect;
            Painting;
            if SupportsStage then
              Paint;
            Canvas.SetMatrix(AbsoluteMatrix);
            PaintChildren;
            Canvas.SetMatrix(AbsoluteMatrix);
            DoPaint;
            AfterPaint;
            if HasAfterPaintEffect and not (FInPaintTo) then
              ApplyEffect;
          finally
            Canvas.RestoreState(State);
          end;
        end else
        begin
          Canvas.SetMatrix(AbsoluteMatrix);
          if HasEffect and not HasAfterPaintEffect and not (FInPaintTo) then
            ApplyEffect;
          Painting;
          if SupportsStage then
            Paint;
          Canvas.SetMatrix(AbsoluteMatrix);
          PaintChildren;
          Canvas.SetMatrix(AbsoluteMatrix);
          DoPaint;
          AfterPaint;
          if HasAfterPaintEffect and not (FInPaintTo) then
            ApplyEffect;
        end;
      finally
        Canvas.RestoreState(State1);
      end;
      PaintChildren;
      if Assigned(FOnPaint) then
      begin
        Canvas.SetMatrix(AbsoluteMatrix);
        DoPaint;
      end;
    end
    else
    begin
      if (ClipChildren or SmallSizeControl) then
      begin
        State := Canvas.SaveState;
        try
          Canvas.SetMatrix(AbsoluteMatrix);
          Canvas.IntersectClipRect(ClipRect);
          if HasEffect and not HasAfterPaintEffect and not (FInPaintTo) then
            ApplyEffect;
          Painting;
          if SupportsStage then
            Paint;
          Canvas.SetMatrix(AbsoluteMatrix);
          PaintChildren;
          Canvas.SetMatrix(AbsoluteMatrix);
          DoPaint;
          AfterPaint;
          if HasAfterPaintEffect and not (FInPaintTo) then
            ApplyEffect;
        finally
          Canvas.RestoreState(State);
        end;
      end
      else
      begin
        Canvas.SetMatrix(AbsoluteMatrix);
        if HasEffect and not HasAfterPaintEffect and not (FInPaintTo) then
          ApplyEffect;
        Painting;
        if SupportsStage then
          Paint;
        Canvas.SetMatrix(AbsoluteMatrix);
        PaintChildren;
        Canvas.SetMatrix(AbsoluteMatrix);
        DoPaint;
        AfterPaint;
        if HasAfterPaintEffect and not (FInPaintTo) then
          ApplyEffect;
      end;
    end;
  end;
  if HasDisablePaintEffect and not FInPaintTo then
    ApplyEffect;

  if IsDragOver and EnableDragHighlight then
  begin
    Canvas.SetMatrix(AbsoluteMatrix);
    Canvas.Stroke.Kind := TBrushKind.bkSolid;
    Canvas.Stroke.Color := $B2005ACC;
    Canvas.Stroke.Cap := TStrokeCap.scFlat;
    Canvas.Stroke.Join := TStrokeJoin.sjMiter;
    Canvas.Stroke.Dash := TStrokeDash.sdSolid;
    Canvas.Stroke.Thickness := 3;
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.DrawRect(R, 1, 1, AllCorners, 1);
    Canvas.Stroke.Dash := TStrokeDash.sdSolid;
  end;
  {$IFDEF MSWINDOWS}
  if FDesignSelectionMarks and Assigned(FRoot) and (FRoot.GetObject is TCommonCustomForm) and
    Assigned(TCommonCustomForm(FRoot.GetObject).Designer) and
    TCommonCustomForm(FRoot.GetObject).Designer.IsSelected(Self) then
      TCommonCustomForm(FRoot.GetObject).Designer.DrawSelectionMarks(Self);
  {$ENDIF}
end;

procedure TControl.DoPaint;
begin
  if Assigned(FOnPaint) then
    FOnPaint(Self, Canvas, LocalRect);
end;

procedure TControl.AfterPaint;
begin
end;

procedure TControl.PaintChildren;
var
  I, j: Integer;
  R: TRectF;
  AllowPaint: Boolean;
  Control: TControl;
begin
  if not Assigned(FScene) then
    Exit;
  if ControlsCount > 0 then
  begin
    for I := GetFirstVisibleObjectIndex to GetLastVisibleObjectIndex - 1 do
      if ((FControls[I].Visible) or (not FControls[I].Visible and (csDesigning in ComponentState) and not FControls[I].Locked)) then
      begin
        Control := FControls[I];
        if not Assigned(Control.FScene) then
          Continue;
        if (csDesigning in Control.ComponentState) and not Control.FDesignVisible then
          Continue;

        if not Control.FInPaintTo and (Control.UpdateRect.IsEmpty) then
          Continue;
        if (Self.ClipChildren or Self.SmallSizeControl) and not IntersectRect(Self.UpdateRect, Control.UpdateRect) then
          Continue;
        // Check visibility
        AllowPaint := False;
        if (csDesigning in Control.ComponentState) or Control.FInPaintTo then
          AllowPaint := True;
        if not AllowPaint then
        begin
          R := UnionRect(Control.GetChildrenRect, Control.UpdateRect);
          for j := 0 to FScene.GetUpdateRectsCount - 1 do
            if IntersectRect(FScene.GetUpdateRect(j), R) then
            begin
              AllowPaint := True;
              Break;
            end;
        end;
        // Paint
        if AllowPaint then
          Control.PaintInternal;
      end;
  end;
end;

function TControl.GetParentedVisible: Boolean;
var
  P: TFmxObject;
begin
  P := Self;
  Result := False;
  while Assigned(P) do
  begin
    if P.IsIControl and (not P.AsIControl.Visible) then
     Exit;
    P := P.Parent;
  end;
  Result := True;
end;

function TControl.GetPopupMenu: TCustomPopupMenu;
begin
  Result := FPopupMenu;
end;

procedure TControl.InvalidateRect(ARect: TRectF);
var
  P: array of TPointF;
begin
  if not Assigned(Scene) then Exit;
  if not Visible and not(csDesigning in ComponentState) then Exit;
  if (csDesigning in ComponentState) and not DesignVisible then Exit;
  if not(csDesigning in ComponentState) and not ParentedVisible then Exit;
  SetLength(P,4);
  P[0] := LocalToAbsolute(ARect.TopLeft);
  P[1] := LocalToAbsolute(PointF(ARect.Right, ARect.Top));
  P[2] := LocalToAbsolute(PointF(ARect.Left, ARect.Bottom));
  P[3] := LocalToAbsolute(ARect.BottomRight);
  Scene.AddUpdateRect(NormalizeRectF(P));
end;

function TControl.IsAnchorsStored: Boolean;
begin
  Result := Anchors <> AnchorAlign[Align];
end;

function TControl.IsIControl: Boolean;
begin
  Result := True;
end;

function TControl.AsIControl: IControl;
begin
  Result := Self;
end;

procedure TControl.Repaint;
var
  R: TRectF;
begin
  if IsUpdating then Exit;
  if FInPaintTo then Exit;
  if not Assigned(FScene) then
    Exit;
  if csDestroying in ComponentState then
    Exit;
  if not Visible and not(csDesigning in ComponentState) then
    Exit;
  if (csDesigning in ComponentState) and not FDesignVisible then
    Exit;
  if not (csDesigning in ComponentState) and not ParentedVisible then
    Exit;
  if HasDisablePaintEffect then
    UpdateEffects;
  if Assigned(Canvas) and (TCanvasStyle.SupportClipRects in Canvas.GetCanvasStyle) then
  begin
    R := UpdateRect;
    if R.IsEmpty then Exit;
    FScene.AddUpdateRect(R);
  end else
    FScene.AddUpdateRect(NullRect);
end;

procedure TControl.Move;
begin
end;

procedure TControl.Resize;
begin
  if Assigned(FOnResize) then
    FOnResize(Self);
end;

procedure TControl.Lock;
var
  I: Integer;
begin
  Locked := True;
  if Assigned(FControls) then
    for I := 0 to FControls.Count - 1 do
      FControls[I].Lock;
end;

function TControl.GetFirstVisibleObjectIndex: Integer;
begin
  Result := 0;
end;

function TControl.GetLastVisibleObjectIndex: Integer;
begin
  if Assigned(FControls) then
    Result := FControls.Count
  else
    Result := 0;
end;

function TControl.GetLeft: single;
begin
  Result := Position.X;
end;

function TControl.GetLocalRect: TRectF;
begin
  Result := RectF(0, 0, FWidth, FHeight);
end;

function TControl.GetLocked: Boolean;
begin
  Result := FLocked;
end;

function TControl.GetAbsoluteRect: TRectF;
begin
  Result := NormalizeRectF([LocalToAbsolute(PointF(0, 0)), LocalToAbsolute(PointF(Width, 0)),
    LocalToAbsolute(PointF(Width, Height)), LocalToAbsolute(PointF(0, Height))]);
end;

function TControl.GetClipRect: TRectF;
begin
  Result := RectF(0, 0, Width, Height);
end;

function TControl.GetContainerHeight: Single;
begin
  Result := Height;
end;

function TControl.GetContainerWidth: Single;
begin
  Result := Width;
end;

function TControl.GetControls: TControlList;
begin
  if Assigned(FControls) then
    Result := FControls
  else
    Result := FEmptyControlList
end;

function TControl.GetControlsCount: Integer;
begin
  if Assigned(FControls) then
    Result := FControls.Count
  else
    Result := 0;
end;

function TControl.GetCursor: TCursor;
begin
  Result := FCursor;
end;

function TControl.GetObject: TFmxObject;
begin
  Result := Self;
end;

function TControl.GetDragMode: TDragMode;
begin
  Result := FDragMode;
end;

function TControl.GetBoundsRect: TRectF;
begin
  Result := RectF(0, 0, Width, Height);
end;

function TControl.GetMargins: TBounds;
begin
  Result := FMargins;
end;

procedure TControl.SetMargins(const Value: TBounds);
begin
  FMargins.Assign(Value);
end;

function TControl.GetPadding: TBounds;
begin
  Result := FPadding;
end;

procedure TControl.SetPadding(const Value: TBounds);
begin
  FPadding.Assign(Value);
end;

function TControl.GetParent: TFmxObject;
begin
  Result := Parent;
end;

function TControl.GetParentedRect: TRectF;
begin
  Result := RectF(0, 0, Width, Height);
  OffsetRect(Result, Position.X, Position.Y);
end;

procedure TControl.SetBoundsRect(const Value: TRectF);
begin
  SetBounds(Value.Left, Value.Top, Value.Width, Value.Height);
end;

{ }

procedure TControl.MarginsChanged(Sender: TObject);
var
  AlignRoot: IAlignRoot;
begin
  UpdateSmallSizeControl;
  if not(csLoading in ComponentState) and Supports(Parent, IAlignRoot, AlignRoot) then
    AlignRoot.Realign;
end;

procedure TControl.PaddingChanged(Sender: TObject);
begin
  UpdateSmallSizeControl;
  Realign;
end;

procedure TControl.BeginUpdate;
var
  I: Integer;
begin
  Inc(FUpdating);
  if Assigned(FControls) then
    for I := 0 to FControls.Count - 1 do
      FControls[I].BeginUpdate;
end;

procedure TControl.EndUpdate;
var
  I: Integer;
begin
  if IsUpdating then
  begin
    if Assigned(FControls) then
      for I := 0 to FControls.Count - 1 do
        FControls[I].EndUpdate;
    Dec(FUpdating);
    if not IsUpdating then
      Realign;
  end;
end;

procedure TControl.EndUpdateNoChanges;
var
  I: Integer;
begin
  if IsUpdating then
  begin
    if Assigned(FControls) then
      for I := 0 to FControls.Count - 1 do
        FControls[I].EndUpdate;
    Dec(FUpdating);
  end;
end;

procedure TControl.DoRealign;
begin
  if not FNeedAlign then
    Exit;
  AlignObjects(Self, FPadding, FWidth, FHeight, FLastWidth, FLastHeight, FDisableAlign);
end;

procedure TControl.Realign;
begin
  if csDestroying in ComponentState then
    Exit;
  if FDisableAlign then
    Exit;
  if IsUpdating then
    Exit;
  if csLoading in ComponentState then
  begin
    FLastWidth := FWidth;
    FLastHeight := FHeight;
    Exit;
  end;
  if ((FLastWidth <> FWidth) or (FLastHeight <> FHeight)) and HasEffect then
    UpdateEffects;
  DoRealign;
end;

{ events }

procedure TControl.KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
var
  VP: TPointF;
begin
  if (Key = vkApps) and (KeyChar = #0) then
  begin
    VP := LocalToAbsolute(PointF(Width / 2, Height / 2));
    VP := Scene.LocalToScreen(VP);
    ContextMenu(VP);
  end
  else if Assigned(FOnKeyDown) then
    FOnKeyDown(Self, Key, KeyChar, Shift);
end;

procedure TControl.KeyUp(var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Assigned(FOnKeyUp) then
    FOnKeyUp(Self, Key, KeyChar, Shift);
end;

procedure TControl.DialogKey(var Key: Word; Shift: TShiftState);
var
  I: Integer;
  LP: TPointF;
begin
  if IsFocused and (Shift = [ssShift]) and (Key = vkF10) then
  begin
    LP := LocalToAbsolute(PointF(Width / 2, Height / 2));
    LP := Scene.LocalToScreen(LP);
    ContextMenu(LP);
    Key := 0;
    Exit;
  end;
  if ActionClient and Enabled and
    (Action is TCustomAction) and
    (TOpenCustomAction(Action).IsDialogKey(Key, Shift)) then
  begin
    Key := 0;
    TOpenCustomAction(Action).SetShortCutPressed(True);
    try
      Click;
    except
      TOpenCustomAction(Action).SetShortCutPressed(False);
      Raise;
    end;
  end
  else if Assigned(FControls) then
    for I := 0 to FControls.Count - 1 do
      if (FControls[I].Visible or Supports(FControls[I], IContent)) and FControls[I].Enabled then
      begin
        FControls[I].DialogKey(Key, Shift);
        if Key = 0 then
          Break;
      end;
end;

procedure TControl.Disappear;
begin
end;

procedure TControl.Capture;
begin
  if Assigned(FRoot) then
    FRoot.Captured := Self;
end;

procedure TControl.ReleaseCapture;
begin
  if Assigned(FRoot) and Assigned(FRoot.Captured) and (FRoot.Captured.GetObject = Self) then
  begin
    FRoot.SetCaptured(nil);
  end;
end;

procedure TControl.DoMatrixChanged(Sender: TObject);
var
  TranslateMatrix, ScaleMatrix, RotMatrix: TMatrix;
  M1, M2: TMatrix;
begin
  if (not FInPaintTo) and not IsUpdating then
    Repaint;
  if SameValue(FScale.X, 1.0, Epsilon) and SameValue(FScale.Y, 1.0, Epsilon) and SameValue(FRotationAngle, 0.0, Epsilon) then
  begin
    if Assigned(FParentControl) and not FParentControl.FSimpleTransform then
      FSimpleTransform := False
    else
      FSimpleTransform := True;
  end
  else
    FSimpleTransform := False;

  if not FSimpleTransform then
  begin
    if not SameValue(FRotationAngle, 0.0, Epsilon) then
    begin
      // scale
      ScaleMatrix := IdentityMatrix;
      ScaleMatrix.m11 := FScale.X;
      ScaleMatrix.m22 := FScale.Y;
      FLocalMatrix := ScaleMatrix;
      // rotation
      if FRotationAngle <> 0 then
      begin
        M1 := IdentityMatrix;
        M1.m31 := -FRotationCenter.X * FWidth * FScale.X;
        M1.m32 := -FRotationCenter.Y * FHeight * FScale.Y;
        M2 := IdentityMatrix;
        M2.m31 := FRotationCenter.X * FWidth * FScale.X;
        M2.m32 := FRotationCenter.Y * FHeight * FScale.Y;
        RotMatrix := MatrixMultiply(M1, MatrixMultiply(CreateRotationMatrix(DegToRad(FRotationAngle)), M2));
        FLocalMatrix := MatrixMultiply(FLocalMatrix, RotMatrix);
      end;
      // translate
      TranslateMatrix := IdentityMatrix;
      TranslateMatrix.m31 := FPosition.X;
      TranslateMatrix.m32 := FPosition.Y;
      FLocalMatrix := MatrixMultiply(FLocalMatrix, TranslateMatrix);
    end
    else
    begin
      FLocalMatrix := IdentityMatrix;
      FLocalMatrix.m31 := FPosition.X;
      FLocalMatrix.m32 := FPosition.Y;
      FLocalMatrix.m11 := FScale.X;
      FLocalMatrix.m22 := FScale.Y;
    end;
  end
  else
  begin
    FLocalMatrix := IdentityMatrix;
    FLocalMatrix.m31 := FPosition.X;
    FLocalMatrix.m32 := FPosition.Y;
  end;

  RecalcAbsolute;
  RecalcUpdateRect;
  if HasDisablePaintEffect then
    UpdateEffects;
  if (not FInPaintTo) and not IsUpdating then
    Repaint;
end;

procedure TControl.DoMouseEnter;
begin
  FIsMouseOver := True;
  StartTriggerAnimation(Self, 'IsMouseOver');
  ApplyTriggerEffect(Self, 'IsMouseOver');
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TControl.DoMouseLeave;
begin
  FIsMouseOver := False;
  StartTriggerAnimation(Self, 'IsMouseOver');
  ApplyTriggerEffect(Self, 'IsMouseOver');
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;

function TControl.GetCanFocus: boolean;
begin
  Result := FCanFocus and Enabled {and ParentedVisible};
  if Result and (Assigned(OnCanFocus)) then
  begin
    OnCanFocus(self, Result);
  end;
end;

function TControl.GetCanParentFocus: boolean;
begin
  Result := FCanParentFocus;
end;

function TControl.EnterChildren(AObject: IControl): Boolean;
begin
  Result := False;
end;

function TControl.ExitChildren(AObject: IControl): Boolean;
begin
  Result := False;
end;

procedure TControl.DoEnter;
begin
  if CanFocus and (not FIsFocused) then
  begin
    if Assigned(FOnEnter) then
      FOnEnter(Self);

    FIsFocused := True;
    FRecalcUpdateRect := True;
    Repaint;
    if not (DisableFocusEffect or GlobalDisableFocusEffect) then
    begin
      StartTriggerAnimation(Self, 'IsFocused');
      ApplyTriggerEffect(Self, 'IsFocused');
    end;
  end;
end;

procedure TControl.SetNewScene(AScene: IScene);
var
  I: Integer;
begin
  if (not Assigned(AScene)) and (FIsFocused) then
    Exit;
  FScene := AScene;
  if Assigned(FControls) then
    for I := 0 to FControls.Count - 1 do
      FControls[I].SetNewScene(FScene);
end;

procedure TControl.DoExit;
begin
  if FIsFocused then
  begin
    try
      if CanFocus and Assigned(FOnExit) then
        FOnExit(Self);
      FIsFocused := False;
    finally
      FRecalcUpdateRect := True;
      Repaint;
      if not (DisableFocusEffect or GlobalDisableFocusEffect) then
      begin
        StartTriggerAnimation(Self, 'IsFocused');
        ApplyTriggerEffect(Self, 'IsFocused');
      end;
    end;
  end;
end;

procedure TControl.DoInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  inherited DoInsertObject(Index, AObject);
  RefreshInheritedCursorForChildren;
end;

procedure TControl.DoActivate;
begin
  if Assigned(FOnActivate) then
    FOnActivate(self);
end;

procedure TControl.DoDeactivate;
begin
  if Assigned(FOnDeactivate) then
    FOnDeactivate(self);
end;

procedure TControl.SetFocus;
var
  LControl: IControl;
begin
  if Assigned(Root) then
  begin
    LControl := Root.NewFocusedControl(Self.AsIControl);
    if Assigned(LControl) then
      FRoot.SetFocused(LControl);
  end;
end;

procedure TControl.ContextMenu(const ScreenPosition: TPointF);
begin
  if Assigned(FPopupMenu) then
  begin
    FPopupMenu.PopupComponent := Self;
    FPopupMenu.Popup(round(ScreenPosition.X), round(ScreenPosition.Y));
    Exit;
  end;
end;

procedure TControl.Click;
var
  LAction: TOpenCustomAction;
begin
  try
    if Assigned(FOnClick) and
       ((not EnableExecuteAction) or
        (ActionClient and (not DelegatesEqual(@FOnClick, @Action.OnExecute)))) then
      FOnClick(Self)
    else
      if not (csDesigning in ComponentState) and EnableExecuteAction and Assigned(ActionLink) then
      begin
        if ActionLink.Action is TCustomAction then
          LAction := TOpenCustomAction(ActionLink.Action)
        else
          LAction := nil;
        if Assigned(LAction) then
        begin
          if not LAction.Supported then
            Exit;
          LAction.SetTarget(self);
        end;
        try
          if not ActionLink.Execute(Self) then
            ExecuteAction(ActionLink.Action);
        finally
          if Assigned(LAction) then
            LAction.SetTarget(nil);
        end;
      end
      else
        if Assigned(FOnClick) then
          FOnClick(Self);
  finally
    if ActionClient and (Action is TCustomAction) then
      TOpenCustomAction(Action).SetShortCutPressed(False);
  end;
end;

procedure TControl.DblClick;
begin
  if Assigned(FOnDblClick) then
    FOnDblClick(Self);
end;

function TControl.MakeScreenshot: TBitmap;
begin
  Result := TBitmap.Create(Round(Width), Round(Height));
  Result.Clear(0);
  if Result.Canvas.BeginScene then
  try
    PaintTo(Result.Canvas, RectF(0, 0, Result.Width, Result.Height));
  finally
    Result.Canvas.EndScene;
  end;
end;

procedure TControl.BeginAutoDrag;
var
  B, S: TBitmap;
  R: TRectF;
begin
  S := MakeScreenshot;
  try
    B := nil;
    try
      if (S.Width > 512) or (S.Height > 512) then
      begin
        R := RectF(0, 0, S.Width, S.Height);
        R.Fit(RectF(0, 0, 512, 512));
        B := TBitmap.Create(Round(RectWidth(R)), Round(RectHeight(R)));
        if B.Canvas.BeginScene then
        try
          B.Canvas.DrawBitmap(S, RectF(0, 0, S.Width, S.Height), RectF(0, 0, B.Width, B.Height), 0.7, True);
        finally
          B.Canvas.EndScene;
        end;
      end else
      begin
        B := TBitmap.Create(S.Width, S.Height);
        if B.Canvas.BeginScene then
        try
          B.Canvas.DrawBitmap(S, RectF(0, 0, B.Width, B.Height), RectF(0, 0, B.Width, B.Height), 0.7, True);
        finally
          B.Canvas.EndScene;
        end;
      end;
      FRoot.BeginInternalDrag(Self, B);
    finally
      B.Free;
    end;
  finally
    S.Free;
  end;
end;

procedure TControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  VP: TPointF;
begin
  if (not (csDesigning in ComponentState)) and (not FIsFocused) then
    SetFocus;
  if Assigned(FOnMouseDown) then
    FOnMouseDown(Self, Button, Shift, X, Y);
  if (Button = TMouseButton.mbRight)
{$IFDEF MACOS}
    or ((Button = TMouseButton.mbLeft) and (Shift = [ssLeft, ssCtrl]))
{$ENDIF}
  then
  begin
    VP := LocalToAbsolute(PointF(X, Y));
    VP := Scene.LocalToScreen(VP);
    ContextMenu(VP);
    Exit;
  end;
  if FAutoCapture then
    Capture;
  if (ssDouble in Shift) then
  begin
    DblClick;
    FDoubleClick := True;
  end
  else if Button = TMouseButton.mbLeft then
  begin
    FPressed := True;
  end;
end;

procedure TControl.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  if Assigned(FOnMouseMove) then
    FOnMouseMove(Self, Shift, X, Y);
end;

procedure TControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  ReleaseCapture;
  if FPressed and not(FDoubleClick) and PointInObjectLocal(X, Y) then
  begin
    FPressed := False;
    Click;
  end;
  if Assigned(FOnMouseUp) then
    FOnMouseUp(Self, Button, Shift, X, Y);
  FPressed := False;
  FDoubleClick := False;
end;

procedure TControl.MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  if Assigned(FOnMouseWheel) then
    FOnMouseWheel(Self, Shift, WheelDelta, Handled)
end;

procedure TControl.DragEnter(const Data: TDragObject; const Point: TPointF);
begin
  FIsDragOver := True;
  Repaint;
  StartTriggerAnimation(Self, 'IsDragOver');
  ApplyTriggerEffect(Self, 'IsDragOver');
  if Assigned(OnDragEnter) then
    OnDragEnter(Self, Data, Point);
end;

procedure TControl.DragLeave;
begin
  FIsDragOver := False;
  Repaint;
  StartTriggerAnimation(Self, 'IsDragOver');
  ApplyTriggerEffect(Self, 'IsDragOver');
  if Assigned(OnDragLeave) then
    OnDragLeave(Self);
end;

procedure TControl.DragOver(const Data: TDragObject; const Point: TPointF; var Accept: Boolean);
begin
  if Assigned(OnDragOver) then
    OnDragOver(Self, Data, Point, Accept);
end;

procedure TControl.DragDrop(const Data: TDragObject; const Point: TPointF);
begin
  FIsDragOver := False;
  Repaint;
  StartTriggerAnimation(Self, 'IsDragOver');
  ApplyTriggerEffect(Self, 'IsDragOver');
  if Assigned(OnDragDrop) then
    OnDragDrop(Self, Data, Point);
end;

procedure TControl.DragEnd;
begin
  // Call mouse up - for effects - inside control
  if DragMode = TDragMode.dmAutomatic then
    MouseUp(TMouseButton.mbLeft, [ssLeft], $FFFF, $FFFF);
  if Assigned(OnDragEnd) then
    OnDragEnd(Self);
end;

{ controls }

procedure TControl.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    if (not Value) then
    begin
      if FIsFocused then
        FRoot.SetFocused(nil)
      else
        EnumControls(procedure(const AControl: TControl; var Done: boolean)
                     begin
                       if AControl.FIsFocused then
                       begin
                         FRoot.SetFocused(nil);
                         Done := True;
                       end;
                     end);
    end;
    FEnabled := Value;
    RecalcEnabled;
    RecalcOpacity;
    Repaint;
  end;
end;

function TControl.GetInheritedCursor: TCursor;
begin
  Result := FInheritedCursor;
end;

function TControl.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(50, 50);
end;

function TControl.GetDesignInteractive: Boolean;
begin
  Result := FDesignInteractive;
end;

function TControl.GetAbsoluteEnabled: Boolean;
begin
  if FRecalcEnabled then
  begin
    if Assigned(FParentControl) and (not FParentControl.AbsoluteEnabled) then
      FAbsoluteEnabled := False
    else
      FAbsoluteEnabled := FEnabled;

    Result := FAbsoluteEnabled;
    FRecalcEnabled := False;

    if not Result and Assigned(FScene) and IsFocused then
      FRoot.SetFocused(nil);
  end
  else
  begin
    Result := FAbsoluteEnabled;
  end;
end;

procedure TControl.RecalcEnabled;
var
  I: Integer;
begin
  if FRecalcEnabled then Exit;
  FRecalcEnabled := True;
  if Assigned(FControls) then
    for I := 0 to FControls.Count - 1 do
      FControls[I].RecalcEnabled;
end;

procedure TControl.SetTempCanvas(const Value: TCanvas);
var
  I: Integer;
begin
  FTempCanvas := Value;
  if Assigned(FControls) then
    for I := 0 to FControls.Count - 1 do
      FControls[I].TempCanvas := Value;
end;

procedure TControl.SetTop(const Value: Single);
begin
  FTop := Value;
  if csReading in ComponentState then
    FExplicitTop := FTop;
end;

procedure TControl.SetTouchTargetExpansion(const Value: TBounds);
begin
  FTouchTargetExpansion.Assign(Value);
end;

procedure TControl.SetHitTest(const Value: Boolean);
begin
  FHitTest := Value;
end;

procedure TControl.SetAcceptsControls(const Value: boolean);
begin
  FAcceptsControls := Value;
end;

procedure TControl.SetClipChildren(const Value: Boolean);
begin
  if FClipChildren <> Value then
  begin
    FClipChildren := Value;
    Repaint;
  end;
end;

procedure TControl.SetAlign(const Value: TAlignLayout);
var
  AlignRoot: IAlignRoot;
  OldAlign: TAlignLayout;
begin
  if FAlign <> Value then
  begin
    OldAlign:= FAlign;
    FAlign := Value;
    Anchors:= AnchorAlign[Value];
    if not(csLoading in ComponentState)and (not (csDesigning in ComponentState) or
      Assigned(Parent)) then
      if ((OldAlign in [TAlignLayout.alTop, TAlignLayout.alBottom, TAlignLayout.alMostTop, TAlignLayout.alMostBottom]) =
        (Value in [TAlignLayout.alRight, TAlignLayout.alLeft, TAlignLayout.alMostRight, TAlignLayout.alMostLeft]))
        and not (OldAlign in [TAlignLayout.alNone, TAlignLayout.alClient, TAlignLayout.alContents])
        and not (Value in [TAlignLayout.alNone, TAlignLayout.alClient, TAlignLayout.alContents])  then
        SetBounds(Left, Top, Width, Height)
      else if (OldAlign <> TAlignLayout.alNone) and (Value = TAlignLayout.alNone) then
        SetBounds(FExplicitLeft, FExplicitTop, FExplicitWidth, FExplicitHeight);
    if (Align <> TAlignLayout.alNone) and Supports(Parent, IAlignRoot, AlignRoot) then
    begin
      AlignRoot.ChildrenAlignChanged;
      if not (csLoading in ComponentState) then
        AlignRoot.Realign;
    end;
  end;
end;

procedure TControl.SetAnchors(const Value: TAnchors);
var
  OldAnchors: TAnchors;
  AlignRoot: IAlignRoot;
begin
  if FAnchors <> Value then
  begin
    OldAnchors:= FAnchors;
    FAnchors := Value;
    if not (csLoading in ComponentState) then
      if (OldAnchors <> [TAnchorKind.akLeft, TAnchorKind.akTop]) and (FAnchors = [TAnchorKind.akLeft, TAnchorKind.akTop]) and
        ((FExplicitLeft <> Left) or (FExplicitTop <> Top) or (FExplicitWidth <> Width)
        or (FExplicitHeight <> Height)) then
        SetBounds(FExplicitLeft, FExplicitTop, FExplicitWidth, FExplicitHeight)
      else
        UpdateAnchorRules;
    if (Anchors <> [TAnchorKind.akLeft, TAnchorKind.akTop]) and Supports(Parent, IAlignRoot, AlignRoot) then
    begin
      AlignRoot.ChildrenAlignChanged;
      if not (csLoading in ComponentState) then
        AlignRoot.Realign;
    end;
  end;
end;

function TControl.EnumControls(Proc: TEnumControlsRef; const VisibleOnly: Boolean): Boolean;
var
  Tmp: TList<TControl>;
  Control: TControl;
  LIndex: array of Integer;
  LevelCount: integer;
  function UpLevel: boolean;
  begin
    Result := ((not VisibleOnly) or (Control.Visible) or (Control = self)) and
              Assigned(Control.Controls[LIndex[LevelCount - 1]].Controls) and
              (Control.Controls[LIndex[LevelCount - 1]].Controls.Count > 0);
    if Result then
    begin
      Control := Control.Controls[LIndex[LevelCount - 1]];
      inc(LevelCount);
      if Length(LIndex) < LevelCount then
        SetLength(LIndex, Length(LIndex) + 16);
      LIndex[LevelCount - 1] := 0;
    end;
  end;
  function Next: boolean;
  begin
    Result := False;
    repeat
      while LIndex[LevelCount - 1] >= (Control.Controls.Count - 1) do
      begin
        if (Control <> self) and
           (Control.Parent is TControl) then
          Control := TControl(Control.Parent)
        else
          Exit;
        Dec(LevelCount);
      end;
      inc(LIndex[LevelCount - 1]);
    until (not VisibleOnly) or
          Control.Controls[LIndex[LevelCount - 1]].Visible;
    Result := True;
  end;
begin
  Result := False;
  if Assigned(Proc) then
  begin
    Tmp := TList<TControl>.Create;
    try
      if Assigned(Controls) and (Controls.Count > 0) then
      begin
        SetLength(LIndex, 1);
        LevelCount := 1;
        Control := Self;
        LIndex[LevelCount - 1] := 0;
        repeat
          if Control <> self then
            Tmp.Add(Control);
        until (not UpLevel) and (not Next);
      end;
      for Control in Tmp do
      begin
        Proc(Control, Result);
        if Result then Break;
      end;
    finally
      FreeAndNil(Tmp);
    end;
  end;
end;

procedure TControl.SetVisible(const Value: Boolean);
var
  AlignRoot: IAlignRoot;
begin
  if FVisible <> Value then
  begin
    if FVisible then
      Repaint;
    FVisible := Value;
    if FVisible then
      Show
    else
      Hide;
    if not(csLoading in ComponentState) and (Align <> TAlignLayout.alNone) then
    begin
      if Assigned(FParentControl) then
        FParentControl.Realign
      else
        if not(csLoading in ComponentState) and Supports(Parent, IAlignRoot, AlignRoot) then
          AlignRoot.Realign;
    end;
    if FVisible then
    begin
      RecalcUpdateRect;
      Repaint;
      StartTriggerAnimation(Self, 'IsVisible');
    end
    else
    begin
      if FIsFocused then
        FRoot.SetFocused(nil)
      else
        EnumControls(procedure(const AControl: TControl; var Done: boolean)
                     begin
                       if AControl.FIsFocused then
                       begin
                         FRoot.SetFocused(nil);
                         Done := True;
                       end;
                     end);
    end;
  end;
end;

procedure TControl.SetPopupMenu(const Value: TCustomPopupMenu);
begin
  if FPopupMenu <> Value then
  begin
    if Assigned(FPopupMenu) then
      FPopupMenu.RemoveFreeNotification(Self);
    FPopupMenu := Value;
    if Assigned(FPopupMenu) then
      FPopupMenu.FreeNotification(Self);
  end;
end;

procedure TControl.SetPosition(const Value: TPosition);
begin
  FPosition.Assign(Value);
end;

procedure TControl.SetRotationAngle(const Value: Single);
begin
  if FRotationAngle <> Value then
  begin
    FRotationAngle := Value;
    MatrixChanged(Self);
  end;
end;

procedure TControl.SetScale(const Value: TPosition);
begin
  FScale.Assign(Value);
end;

procedure TControl.Hide;
begin
end;

procedure TControl.Show;
begin
end;

function TControl.SupportsPaintStage(const Stage: TPaintStage): Boolean;
begin
  Result := Stage <> TPaintStage.psText;
end;

function TControl.SupportsPlatformService(const AServiceGUID: TGUID; out AService: IInterface): Boolean;
begin
  {$IFDEF MSWINDOWS}
  if Assigned(FScene) and (csDesigning in FScene.GetObject.ComponentState) and (FScene.GetObject is TCommonCustomForm) and
    Assigned(TCommonCustomForm(FScene.GetObject).Designer) and
    TCommonCustomForm(Scene.GetObject).Designer.SupportsPlatformService(AServiceGUID, AService)
  then
    Result := True
  else
  {$ENDIF}
    Result := inherited SupportsPlatformService(AServiceGUID, AService);
end;

function TControl.DoSetWidth(var Value: Single; NewValue: single; var LastValue: Single): boolean;
begin
  NewValue := System.Math.Max(0, NewValue);
  Result := RoundTo(NewValue, DigitRoundSize) <> RoundTo(Value, DigitRoundSize);
  if Result and (NewValue < Value) then
    Repaint;
  LastValue := Value;
  Value := NewValue;
end;

function TControl.DoSetHeight(var Value: Single; NewValue: single; var LastValue: Single): boolean;
begin
  NewValue := System.Math.Max(0, NewValue);
  Result := RoundTo(NewValue, DigitRoundSize) <> RoundTo(Value, DigitRoundSize);
  if Result and (NewValue < Value) then
    Repaint;
  LastValue := Value;
  Value := NewValue;
end;

procedure TControl.RequestAlign;
var
  AlignRoot: IAlignRoot;
begin
  if not(csLoading in ComponentState) and (Align <> TAlignLayout.alNone) then
  begin
    if Assigned(FParentControl) then
      FParentControl.Realign
    else
      if not(csLoading in ComponentState) and Supports(Parent, IAlignRoot, AlignRoot) then
        AlignRoot.Realign;
  end;
end;

procedure TControl.SetBounds(X, Y, AWidth, AHeight: Single);
var
  HChanged, WChanged, SizeChanged: Boolean;
  Moved: Boolean;
  NeedRepaint: Boolean;
  ReductionSize: Boolean;
begin
  ReductionSize := (FHeight > AHeight) or (FWidth > AWidth);
  HChanged := DoSetHeight(FHeight, AHeight, FLastHeight);
  WChanged := DoSetWidth(FWidth, AWidth, FLastWidth);
  SizeChanged := HChanged or WChanged;
  Moved := not (SameValue(X, Position.X, Epsilon) and SameValue(Y, Position.Y, Epsilon));
  NeedRepaint := False;

  if Moved or ((HChanged or WChanged) and (RotationAngle <> 0)) then
  begin
    if Moved or ReductionSize then
      Repaint;
    FPosition.SetPointNoChange(PointF(X, Y));
    FLeft := FPosition.X;
    FTop := FPosition.Y;
    Inc(FUpdating);
    try
      MatrixChanged(Self);
    finally
      Dec(FUpdating);
    end;
    NeedRepaint := True;
  end;

  if Moved or SizeChanged then
  begin
    if (csDesigning in ComponentState) then
      if Assigned(FParentControl) and not (csDestroying in FParentControl.ComponentState) then
        if (TRectF.Union(ParentedRect, FParentControl.LocalRect) <> FParentControl.LocalRect) then
          FParentControl.RecalcUpdateRect;
    UpdateAnchorRules;
    UpdateExplicitBounds;

    RequestAlign;
  end;

  if not(csLoading in ComponentState) and (SizeChanged) then
  begin
    UpdateSmallSizeControl;
    Resize;
    if Assigned(FControls) then
      Realign
    else if HasEffect then
      UpdateEffects;
  end;
  if not(csLoading in ComponentState) and (not (SizeChanged)) and Moved then
    Move;
  if not(csLoading in ComponentState) and (Moved or SizeChanged) then
  begin
    RecalcUpdateRect;
    NeedRepaint := True;
  end;
  if NeedRepaint then
    Repaint;
end;

type
  TOpenScrollBox = class (TScrollBox)

  end;

procedure TControl.InternalSizeChanged;
var
  AlignRoot: IAlignRoot;
  LScrollContent: TScrollContent;
begin
  if not(csLoading in ComponentState) then
  begin
    UpdateEffects;
    RecalcUpdateRect;
    if Parent is TScrollContent then
    begin
      LScrollContent := TScrollContent(Parent);
      if Assigned(LScrollContent.ScrollBox) and
         (not TOpenScrollBox(LScrollContent.ScrollBox).InInternalAlign) then
      begin
        TOpenScrollBox(LScrollContent.ScrollBox).InvalidateContentSize;
      end;
    end
    else
      LScrollContent := nil;
    if ((Align <> TAlignLayout.alNone) or (Assigned(LScrollContent))) then
    begin
      if Assigned(FParentControl) then
        FParentControl.Realign
      else
        if Supports(Parent, IAlignRoot, AlignRoot) then
          AlignRoot.Realign;
    end;
    if Assigned(Children) then
      Realign
    else
      Repaint;
  end;
end;


procedure TControl.SetHeight(const Value: Single);
begin
  if DoSetHeight(FHeight, Value, FLastHeight) then
  begin
    UpdateSmallSizeControl;
    Resize;
    InternalSizeChanged;
    if csReading in ComponentState then
      FExplicitHeight := FHeight;
    if (RotationAngle <> 0) then
      MatrixChanged(Self);
  end;
end;

procedure TControl.SetWidth(const Value: Single);
begin
  if DoSetWidth(FWidth, Value, FLastWidth) then
  begin
    UpdateSmallSizeControl;
    Resize;
    InternalSizeChanged;
    if csReading in ComponentState then
      FExplicitWidth := FWidth;
    if (RotationAngle <> 0) then
      MatrixChanged(Self);
  end;
end;

function TControl.IsOpacityStored: Boolean;
begin
  Result := FOpacity <> 1;
end;

function TControl.IsPopupMenuStored: boolean;
begin
  Result := (not (ActionClient and
                  (ActionLink is TControlActionLink) and
                  (TControlActionLink(ActionLink).IsPopupMenuLinked)));
end;

function TControl.IsTabOrderStored: Boolean;
begin
  Result:= FTabOrder <> -1;
end;

function TControl.IsUpdating: Boolean;
begin
  Result := FUpdating > 0;
end;

function TControl.IsPositionStored: Boolean;
begin
  Result := not (FAlign in [TAlignLayout.alClient, TAlignLayout.alContents, TAlignLayout.alCenter, TAlignLayout.alFit]);
end;

function TControl.IsHeightStored: Boolean;
begin
  Result := True;
end;

function TControl.IsWidthStored: Boolean;
begin
  Result := True;
end;

procedure TControl.SetOnClick(const Value: TNotifyEvent);
begin
  if not DelegatesEqual(@FOnClick, @Value) then
  begin
    FOnClick := Value;
  end;
end;

procedure TControl.SetOpacity(const Value: Single);
begin
  if FOpacity <> Value then
  begin
    FOpacity := Value;
    if FOpacity < 0 then
      FOpacity := 0;
    if FOpacity > 1 then
      FOpacity := 1;
    RecalcOpacity;
    Repaint;
  end;
end;

procedure TControl.UpdateAnchorRules;
begin
  if not FAnchorMove and not (csLoading in ComponentState)
     and not (csDestroying in ComponentState) then
  begin
    RecalcAnchorRules(Parent, FAnchors, ParentedRect, Margins,
      FOriginalParentSize, FAnchorOrigin, FAnchorRules);
    RecalcControlOriginalParentSize(Parent, ComponentState,
      FOriginalParentSize);
  end;
end;

procedure TControl.UpdateDesignVisible(const Value: Boolean);
var
  I: Integer;
begin
  FDesignVisible := Value;
  if Assigned(FControls) then
    for I := 0 to FControls.Count - 1 do
      FControls[I].UpdateDesignVisible(Value);
end;

procedure TControl.SetDesignVisible(const Value: Boolean);
begin
  if FDesignVisible <> Value then
  begin
    FDesignVisible := Value;
    if (csDesigning in ComponentState) and Assigned(FParentControl) then
      FParentControl.Repaint;
  end;
end;

procedure TControl.SetDragMode(const ADragMode: TDragMode);
begin
  FDragMode := ADragMode;
end;

procedure TControl.SetCursor(const Value: TCursor);
var
  CursorService: IFMXCursorService;
begin
  if FCursor <> Value then
  begin
    FCursor := Value;
    if FCursor <> crDefault then
      RefreshInheritedCursor
    else
    begin
      if Assigned(Parent) then
        RefreshInheritedCursor
      else
        FInheritedCursor := crDefault;
    end;

     if IsMouseOver and 
        not (csLoading in ComponentState) and 
        not (csDesigning in ComponentState) and 
        TPlatformServices.Current.SupportsPlatformService(IFMXCursorService, IInterface(CursorService)) then
       CursorService.SetCursor(FInheritedCursor);
  end;
end;

function TControl.GetTabOrderValue: TTabOrder;
begin
  Result := FTabOrder;
end;

function TControl.GetTop: single;
begin
  Result := Position.Y;
end;

function TControl.GetTabOrder: TTabOrder;
begin
  if Assigned(Parent) and Assigned(TOpenObject(Parent).FTabList) then
    Result := TOpenObject(Parent).FTabList.IndexOf(AsIControl)
  else
    Result := -1;
end;

procedure TControl.UpdateTabOrder(Value: TTabOrder);
var
  CurIndex, Count: Integer;
begin
  if Assigned(ParentControl) and ParentControl.FAddingToTabList then
    FTabOrder := Value
  else
  begin
    CurIndex := GetTabOrder;
    if (CurIndex >= 0) and Assigned(Parent) and Assigned(TOpenObject(Parent).FTabList) then
    begin
      Count := TOpenObject(Parent).FTabList.Count;
      if Value < 0 then
        Value := 0;
      if Value >= Count then
        Value := Count - 1;
      if Value <> CurIndex then
      begin
        TOpenObject(Parent).FTabList.Exchange(CurIndex, Value);
      end;
    end;
    FTabOrder := GetTabOrder;
  end;
end;

procedure TControl.SetTabOrder(const Value: TTabOrder);
begin
  if csLoading in ComponentState then
    FTabOrder := Value
  else
    UpdateTabOrder(Value);
end;

procedure TControl.AddToEffectsList(const AEffect: TEffect);
begin
  if not Assigned(FEffects) then
    FEffects := TList<TEffect>.Create;
  FEffects.Add(AEffect);
end;

procedure TControl.RemoveFromEffectsList(const AEffect: TEffect);
begin
  if Assigned(FEffects) then
    FEffects.Remove(AEffect);
end;


procedure TControl.AddToTabList(const AObject: TFmxObject);
begin
  if Assigned(AObject.Owner) and (AObject.IsIControl) and (AObject.Stored) and
    ((AObject.Owner = Owner) or (AObject.Owner = Self) or
    (AObject.Owner is TCommonCustomForm)) then
  begin
    inherited;
    FAddingToTabList := True;
    AObject.AsIControl.UpdateTabOrder(FTabList.Count - 1);
    FAddingToTabList := False;
  end;
end;

procedure TControl.SetLeft(const Value: Single);
begin
  FLeft := Value;
  if csReading in ComponentState then
    FExplicitLeft := FLeft;
end;

procedure TControl.SetLocked(const Value: Boolean);
begin
  FLocked := Value;
end;

procedure TControl.SetMinClipHeight(const Value: single);
begin
  if not SameValue(FMinClipHeight, Value, Epsilon) then
  begin
    FMinClipHeight := Value;
    UpdateSmallSizeControl;
  end;
end;

procedure TControl.SetMinClipWidth(const Value: single);
begin
  if not SameValue(FMinClipWidth, Value, Epsilon) then
  begin
    FMinClipWidth := Value;
    UpdateSmallSizeControl;
  end;
end;

function TControl.UpdateSmallSizeControl: boolean;
var NeedClip: boolean;
    R: TRectF;
begin
  R := LocalRect;
  R := Padding.PaddingRect(R);
  NeedClip := (FMinClipHeight > R.Height) or
              (FMinClipWidth > R.Width);
  Result := NeedClip <> FSmallSizeControl;
  if Result then
    FSmallSizeControl := NeedClip;
end;

function TControl.GetEffectsRect: TRectF;
var
  Effect: TEffect;
begin
  Result := LocalRect;
  if Assigned(FEffects) and (FEffects.Count > 0) then
    for Effect in FEffects do
      if Effect.Enabled then
        Result := UnionRect(Result, Effect.GetRect(LocalRect));
end;

function TControl.GetEnabled: Boolean;
begin
  Result := FEnabled;
end;

function TControl.GetHeight: single;
begin
  Result := FHeight;
end;

function TControl.GetHitTest: Boolean;
begin
  Result := FHitTest;
end;

function TControl.GetAcceptsControls: Boolean;
begin
  Result := FAcceptsControls;
end;

function TControl.GetActionLinkClass: TActionLinkClass;
begin
  Result := TControlActionLink;
end;

function TControl.GetAbsoluteHasAfterPaintEffect: Boolean;
begin
  if FRecalcHasEffect then
    HasEffect; // Force recalc
  Result := FAbsoluteHasAfterPaintEffect;
end;

function TControl.GetAbsoluteHasDisablePaintEffect: Boolean;
begin
  if FRecalcHasEffect then
    HasEffect; // Force recalc
  Result := FAbsoluteHasDisablePaintEffect;
end;

function TControl.GetAbsoluteHasEffect: Boolean;
var
  Effect: TEffect;
begin
  if FRecalcHasEffect then
  begin
    FAbsoluteHasEffect := False;
    FAbsoluteHasDisablePaintEffect := False;
    FAbsoluteHasAfterPaintEffect := False;
    if (FDisableEffect) or (not Assigned(FEffects)) or (FEffects.Count = 0) then
    begin
      Result := FAbsoluteHasEffect;
      Exit;
    end;

    for Effect in FEffects do
    begin
      if Effect.Enabled then
      begin
        FAbsoluteHasEffect := True;
        if esDisablePaint in Effect.EffectStyle then
          FAbsoluteHasDisablePaintEffect := True;
        if esAfterPaint in Effect.EffectStyle then
          FAbsoluteHasAfterPaintEffect := True;
        Break;
      end;
    end;
    FRecalcHasEffect := False;
  end;
  Result := FAbsoluteHasEffect;
end;

procedure TControl.RecalcHasClipParent;
begin
  FRecalcHasClipParent := True;
end;

function TControl.GetHasClipParent: TControl;
var
  I: Integer;
begin
  if FRecalcHasClipParent then
  begin
    FHasClipParent := nil;
    if Assigned(FControls) then
      for I := 0 to FControls.Count - 1 do
        if FControls[I].ClipParent then
        begin
          FHasClipParent := FControls[I];
          Break
        end;
    Result := FHasClipParent;
  end
  else
    Result := FHasClipParent;
end;

procedure TControl.RecalcHasEffect;
begin
  if FRecalcHasEffect then Exit;
  FRecalcHasEffect := True;
  if Assigned(FParentControl) then
    FParentControl.RecalcHasEffect;
end;

type

{ TStyleCache }

  TStyleCache = class
  strict private
    class var FCurrent: TStyleCache;
    class function GetCurrent: TStyleCache; static;
  protected
    constructor Create;
  private
    FStyleList: TList<TFmxObject>;
    FFreeTimer: TTimer;
    FClearStyleCacheId: Integer;
    procedure DoFreeTimer(Sender: TObject);
    procedure Clear;
    procedure ClearStyleCacheHandler(const Sender: TObject; const Msg : TMessage);
  public
    destructor Destroy; override;
    procedure FreeResource(const AResource: TFmxObject);
    function FindResource(const StyleName: string): TFmxObject;
    class procedure Unitialize;
    class property Current: TStyleCache read GetCurrent;
  end;

constructor TStyleCache.Create;
begin
  inherited Create;
  FFreeTimer := TTimer.Create(nil);
  FFreeTimer.OnTimer := DoFreeTimer;
  FFreeTimer.Interval := 5000;
  FFreeTimer.Enabled := False;
  FClearStyleCacheId := TMessageManager.DefaultManager.SubscribeToMessage(TBeforeStyleChangingMessage, ClearStyleCacheHandler);
end;

destructor TStyleCache.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TBeforeStyleChangingMessage, FClearStyleCacheId);
  FreeAndNil(FFreeTimer);
  Clear;
  FreeAndNil(FStyleList);
  inherited;
end;

procedure TStyleCache.Clear;
var
  I: Integer;
begin
  if Assigned(FStyleList) then
  begin
    TMonitor.Enter(Self);
    try
      for I := 0 to FStyleList.Count - 1 do
        FStyleList[I].DisposeOf;
      FStyleList.Clear;
    finally
      TMonitor.Exit(Self);
    end;
  end;
end;

procedure TStyleCache.DoFreeTimer(Sender: TObject);
begin
  FFreeTimer.Enabled := False;
  Clear;
end;

function TStyleCache.FindResource(const StyleName: string): TFmxObject;
var
  I: Integer;
begin
  Result := nil;
  if Assigned(FStyleList) then
  begin
    TMonitor.Enter(Self);
    try
      for I := 0 to FStyleList.Count - 1 do
      begin
        if SameText(FStyleList[I].TagString, StyleName) then
        begin
          Result := FStyleList[I];
          FStyleList.Delete(I);
          Break;
        end;
      end;
    finally
      TMonitor.Exit(Self);
    end;
  end;
end;

procedure TStyleCache.FreeResource(const AResource: TFmxObject);
begin
  TControl(AResource).FInPaintTo := True; // to disable call Repaint
  try
    AResource.Parent := nil;
  finally
    TControl(AResource).FInPaintTo := False;
  end;
  if not Assigned(FStyleList) then
    FStyleList := TList<TFmxObject>.Create;
  FStyleList.Add(AResource);
  FFreeTimer.Enabled := False;
  //FFreeTimer.Enabled := True;
end;

class function TStyleCache.GetCurrent: TStyleCache;
begin
  if not Assigned(FCurrent) then
    FCurrent := TStyleCache.Create;
  Result := FCurrent;
end;

procedure TStyleCache.ClearStyleCacheHandler(const Sender: TObject; const Msg: TMessage);
begin
  Clear;
end;

class procedure TStyleCache.Unitialize;
begin
  if Assigned(FCurrent) then
    FreeAndNil(FCurrent);
end;

{ TStyledControl }

constructor TStyledControl.Create(AOwner: TComponent);
begin
  inherited;
  FDisableDisappear := False;
  FInflated := False;
  FHelpType := htContext;
  FHelpContext := 0;
  FIsNeedStyleLookup := True;
  FScaleChangedId := TMessageManager.DefaultManager.SubscribeToMessage(TScaleChangedMessage, ScaleChangedHandler);
  FStyleChangedId := TMessageManager.DefaultManager.SubscribeToMessage(TStyleChangedMessage, StyleChangedHandler);
end;

destructor TStyledControl.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TStyleChangedMessage, FStyleChangedId);
  TMessageManager.DefaultManager.Unsubscribe(TScaleChangedMessage, FScaleChangedId);
  FreeAndNil(FStylesData);
  inherited;
end;

procedure TStyledControl.BeforeDestruction;
begin
  inherited;
  if Assigned(FResourceLink) then
    FreeStyle;
end;

procedure TStyledControl.Disappear;
var
  SaveResourceLink: TFmxObject;
begin
  inherited;
  if FDisableDisappear then Exit;
  if Assigned(FResourceLink) then
  begin
    SaveResourceLink := FResourceLink;
    FreeStyle;
    if csDesigning in ComponentState then
      FreeAndNil(SaveResourceLink)
    else
      TStyleCache.Current.FreeResource(SaveResourceLink);
    NeedStyleLookup;
  end;
end;

procedure TStyledControl.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Action) then
    Action := nil;
end;

procedure TStyledControl.SetNewScene(AScene: IScene);
var
  OldScene: IScene;
begin
  OldScene := FScene;
  inherited SetNewScene(AScene);
  if (OldScene <> AScene) and Assigned(FScene) and Assigned(FScene.StyleBook) and not IsUpdating then
    NeedStyleLookup;
end;

procedure TStyledControl.Painting;
begin
  inherited;
  ApplyStyleLookup;
end;

procedure TStyledControl.NeedStyleLookup;
begin
  FIsNeedStyleLookup := True;
end;

function TStyledControl.SearchInto: Boolean;
begin
  Result := False;
end;

function TStyledControl.FindStyleResource(const AStyleLookup: string; const Clone: Boolean = False): TFmxObject;
begin
  if Assigned(FResourceLink) then
    Result := FResourceLink.FindStyleResource(AStyleLookup, Clone)
  else
    Result := nil;
end;

function TStyledControl.GetStyleObject: TFmxObject;
begin
  Result := GetStyleObject(True);
end;

function TStyledControl.GetStyleObject(const Clone: Boolean): TFmxObject;

  function GetStyleInObject(ASource: TFmxObject; const AStyleName: string): TFmxObject;
  begin
    Result := nil;
    if Assigned(ASource) then
    begin
      Result := ASource.FindStyleResource(AStyleName, Clone);
      if Assigned(Result) then
        Result.TagString := AStyleName.ToLowerInvariant;
    end;
  end;

var
  ResourceObject: TFmxObject;
  StyleName: string;
begin
  ResourceObject := nil;
  if (FStyleLookup <> '') and (SameText(FStyleLookup, FStyleName)) then
  begin
    Result := ResourceObject;
    Exit;
  end;
  if (FStyleLookup <> '') then
  begin
    if Assigned(FScene) and Assigned(FScene.GetStyleBook) and Assigned(FScene.GetStyleBook.Style) then
      ResourceObject := GetStyleInObject(FScene.GetStyleBook.Style, FStyleLookup);
    if not Assigned(ResourceObject) then
      if Assigned(TStyleManager.ActiveStyleForScene(Scene)) then
        ResourceObject := GetStyleInObject(TStyleManager.ActiveStyleForScene(Scene), FStyleLookup);
    if not Assigned(ResourceObject) then
    begin
      ResourceObject := TControl(FMX.Types.FindStyleResource(FStyleLookup, Clone));
      if Assigned(ResourceObject) then
        ResourceObject.TagString := FStyleLookup;
    end;
  end;
  if not Assigned(ResourceObject) then
  begin
    if Assigned(FScene) and Assigned(FScene.GetStyleBook) and Assigned(FScene.GetStyleBook.Style) then
    begin
      if FStyleLookup <> '' then
      begin
        StyleName := FStyleLookup;
        ResourceObject := GetStyleInObject(FScene.GetStyleBook.Style, StyleName);
      end;
      if not Assigned(ResourceObject) then
      begin
        StyleName := GetDefaultStyleLookupName;
        ResourceObject := GetStyleInObject(FScene.GetStyleBook.Style, StyleName);
      end;
      if not Assigned(ResourceObject) then
      begin
        StyleName := ClassName + 'style';
        StyleName := StyleName.Remove(0, 1);
        ResourceObject := GetStyleInObject(FScene.GetStyleBook.Style, StyleName);
      end;
    end;
    if (not Assigned(ResourceObject)) and Assigned(TStyleManager.ActiveStyleForScene(Scene)) then
    begin
      if FStyleLookup <> '' then
      begin
        StyleName := FStyleLookup;
        ResourceObject := GetStyleInObject(TStyleManager.ActiveStyleForScene(Scene), StyleName);
      end;
      if not Assigned(ResourceObject) then
      begin
        StyleName := GetDefaultStyleLookupName;
        ResourceObject := GetStyleInObject(TStyleManager.ActiveStyleForScene(Scene), StyleName);
      end;
      if not Assigned(ResourceObject) then
      begin
        StyleName := ClassName + 'style';
        StyleName := StyleName.Remove(0, 1);
        ResourceObject := GetStyleInObject(TStyleManager.ActiveStyleForScene(Scene), StyleName);
      end;
      if not Assigned(ResourceObject) then
      begin
        // try parent Class
        StyleName := ClassParent.ClassName + 'style';
        StyleName := StyleName.Remove(0, 1);
        ResourceObject := GetStyleInObject(TStyleManager.ActiveStyleForScene(Scene), StyleName);
      end;
    end;
  end;
  Result := ResourceObject;
end;

procedure CallLoaded(const Obj: TFmxObject);
var
  I: Integer;
begin
  TOpenObject(Obj).Loaded;
  for I := 0 to Obj.ChildrenCount - 1 do
    CallLoaded(Obj.Children[I]);
end;

procedure TStyledControl.DoApplyStyleLookup;
begin
  if Assigned(FOnApplyStyleLookup) then
    FOnApplyStyleLookup(Self);
end;

procedure TStyledControl.ApplyStyleLookup;
var
  StyleObject: TFmxObject;
  StyleControl: TControl;
  SaveDisableAlign: Boolean;
  SaveResourceLink: TFmxObject;
begin
  if FIsNeedStyleLookup then
  begin
    FIsNeedStyleLookup := False;

    if not (csDesigning in ComponentState) then
    begin
      if FStyleLookup <> '' then
        StyleObject := TStyleCache.Current.FindResource(FStyleLookup)
      else
        StyleObject := TStyleCache.Current.FindResource(GetDefaultStyleLookupName);
    end
    else
      StyleObject := nil;
    if not Assigned(StyleObject) then
      StyleObject := GetStyleObject;
    if Assigned(StyleObject) then
    begin
      SaveDisableAlign := FDisableAlign;
      FDisableAlign := True;

      if csLoading in StyleObject.ComponentState then
        CallLoaded(StyleObject);
      if Assigned(FResourceLink) then
      begin
        SaveResourceLink := FResourceLink;
        FResourceLink.Parent := nil;
        FreeStyle;
        SaveResourceLink.DisposeOf;
      end;
      if StyleObject is TControl then
      begin
        StyleControl := TControl(StyleObject);
        FAdjustSizeValue := TPointF.Create(StyleControl.Width, StyleControl.Height);
        StyleControl.DesignVisible := True;
        StyleControl.FAlign := TAlignLayout.alNone;
        StyleControl.FAnchors := AnchorAlign[TAlignLayout.alNone];
        try
          StyleControl.SetBounds(StyleControl.Margins.Left, StyleControl.Margins.Top,
            Width - StyleControl.Margins.Width, Height - StyleControl.Margins.Height);
        finally
          StyleControl.FAlign := TAlignLayout.alContents;
          StyleControl.FAnchors := AnchorAlign[TAlignLayout.alContents];
        end;
        FResourceLink := StyleObject;
        FResourceControl := StyleControl;
        StyleControl.SetAcceptsControls(False);
        InsertObject(0, StyleControl);
        { }
        StyleControl.Stored := False;
        StyleControl.Lock;
        ApplyStyle;
        FUpdateEffects := True;
        DoApplyStyleLookup;

        FDisableAlign := SaveDisableAlign;
        Realign;
      end else begin
        FResourceLink := StyleObject;
        FResourceControl := nil;
        InsertObject(0, StyleObject);
        { }
        StyleObject.Stored := False;
        ApplyStyle;
        DoApplyStyleLookup;

        FDisableAlign := SaveDisableAlign;
        Realign;
      end;
    end;
  end;
end;

procedure TStyledControl.DoStyleChanged;
begin
  FInflated := False;
  if csLoading in ComponentState then
    Exit;
  if csDestroying in ComponentState then
    Exit;
  NeedStyleLookup;
  Repaint;
end;

procedure TStyledControl.AdjustSize;
begin
  case FAdjustType of
    TAdjustType.FixedSize: SetBounds(Position.X, Position.Y, AdjustSizeValue.Width, AdjustSizeValue.Height);
    TAdjustType.FixedWidth: SetBounds(Position.X, Position.Y, AdjustSizeValue.Width, Height);
    TAdjustType.FixedHeight: SetBounds(Position.X, Position.Y, Width, AdjustSizeValue.Height);
  end;
end;

procedure TStyledControl.AdjustFixedSize(const Ref: TControl);
var
  Link: TControl;
begin
  { adjust size }
  FAdjustType := TAdjustType.None;

  if Ref <> Self then
    Link := Ref
  else
    Link := FResourceControl;

  if Assigned(Link) and not Link.FixedSize.IsZero then
  begin
    FAdjustSizeValue := Link.FixedSize;
    if (Link.FixedSize.Width = 0) and (Link.FixedSize.Height <> 0) then
      FAdjustType := TAdjustType.FixedHeight
    else if (Link.FixedSize.Width <> 0) and (Link.FixedSize.Height = 0) then
      FAdjustType := TAdjustType.FixedWidth
    else
      FAdjustType := TAdjustType.FixedSize
  end;

  if FAdjustType <> TAdjustType.None then
    AdjustSize;
end;

procedure TStyledControl.ApplyStyle;
var
  NewT: string;
  Entry: TPair<string, TValue>;
begin
  if FIsFocused and CanFocus and not FDisableFocusEffect and not GlobalDisableFocusEffect then
  begin
    FRecalcUpdateRect := True;
    Repaint;
    StartTriggerAnimation(Self, 'IsFocused');
    ApplyTriggerEffect(Self, 'IsFocused');
  end;
  { translate }
  if FAutoTranslate and ShowHint and (Hint <> '') then
  begin
    NewT := Translate(Hint);
    // need for collection texts
    if not(csDesigning in ComponentState) then
      Hint := NewT;
  end;
  AdjustFixedSize(Self);
  { StylesData }
  if Assigned(FStylesData) and (FStylesData.Count > 0) then
  begin
    for Entry in FStylesData do
      StylesData[Entry.Key] := Entry.Value;
  end;
  FInflated := True;
end;

procedure TStyledControl.FreeStyle;
var
  Entry: TPair<string, TValue>;
begin
  { StylesData }
  if Assigned(FStylesData) and (FStylesData.Count > 0) then
  begin
    for Entry in FStylesData do
      FStylesData.AddOrSetValue(Entry.Key, StylesData[Entry.Key]);
  end;
  if Assigned(FResourceControl) then
    FResourceControl.RecalcEnabled;
  FResourceControl := nil;
  FResourceLink := nil;
end;

procedure TStyledControl.Inflate;
var
  StyleProto: TFmxObject;
begin
  if FInflated then Exit;
  try
    StyleProto := GetStyleObject(False);
    if Assigned(StyleProto) and (StyleProto is TControl) then
      AdjustFixedSize(TControl(StyleProto))
    else
    begin
      FDisableDisappear := True;
      ApplyStyleLookup;
      FDisableDisappear := False;
      Disappear;
    end;

    FInflated := True;
  finally
    FDisableDisappear := False;
  end;
end;


type
  TPropertyApplyProc = reference to procedure(Instance: TObject; Prop: TRttiProperty);

function FindProperty(var O: TObject; Path: String; const Apply: TPropertyApplyProc): Boolean;
var
  Persistent: string;
  P: TRttiProperty;
  T: TRttiType;
  Instance: TObject;
begin
  Result := False;
  Instance := O;

  while Path.Contains('.') do
  begin
    Persistent := GetToken(Path, '.');
    T := SharedContext.GetType(Instance.ClassInfo);
    if Assigned(T) then
    begin
      P := T.GetProperty(Persistent);
      if Assigned(P) and (P.PropertyType.IsInstance) then
        Instance := P.GetValue(Instance).AsObject
    end;
  end;
  if Assigned(Instance) then
  begin
    T := SharedContext.GetType(Instance.ClassInfo);
    P := T.GetProperty(Path);
    O := Instance;
    Result := Assigned(P);
    Apply(O, P);
  end;
end;


function TStyledControl.GetStyleData(const Index: string): TValue;
var
  Obj: TObject;
  InstanceName, PropertyName: string;
  PropertyValue: TValue;
begin
  if Index.Contains('.') then
  begin
    PropertyName := Index;
    InstanceName := GetToken(PropertyName, '.');
  end else begin
    InstanceName := Index;
  end;

  Obj := FindStyleResource(InstanceName);
  if Assigned(Obj) then
  begin
    if not PropertyName.IsEmpty then
    begin
      if FindProperty(Obj, PropertyName,
        procedure (Instance: TObject; Prop: TRttiProperty)
        begin
          PropertyValue := Prop.GetValue(Instance);
        end) then Result := PropertyValue;
    end else
      Result := TFmxObject(Obj).Data
  end else if Assigned(FStylesData) then
    FStylesData.TryGetValue(Index, Result)
  else
    Result := TValue.Empty;
end;

procedure TStyledControl.SetStyleData(const Index: string; const Value: TValue);
var
  Obj: TObject;
  InstanceName, PropertyName: string;
  PropertyValue: TValue;
begin
  PropertyName := Index;
  InstanceName := GetToken(PropertyName, '.');

  if not Assigned(FStylesData) then
    FStylesData := TDictionary<string, TValue>.Create;
  FStylesData.AddOrSetValue(Index, Value);

  Obj := FindStyleResource(InstanceName);
  if Assigned(Obj) then
  begin
    if not PropertyName.IsEmpty then
    begin
      PropertyValue := Value;
      FindProperty(Obj, PropertyName,
        procedure (Instance: TObject; Prop: TRttiProperty)
        begin
          Prop.SetValue(Instance, PropertyValue);
        end);
    end else
      TFmxObject(Obj).Data := Value;
  end
end;

function TStyledControl.GetDefaultStyleLookupName: string;
begin
  Result := ClassName;
  if (Result.Length > 1) and (UpCase(Result.Chars[0]) = 'T') then
    Result := Result.Remove(0, 1);
  Result := Result + 'style';
end;

procedure TStyledControl.DoEnter;
begin
  ApplyStyleLookup;
  inherited;
end;

function TStyledControl.DoSetHeight(var Value: Single; NewValue: single; var LastValue: Single): boolean;
begin
  if FAdjustType in [TAdjustType.FixedSize, TAdjustType.FixedHeight] then
    NewValue := FAdjustSizeValue.Height;
  Result := inherited DoSetHeight(Value, NewValue, LastValue);
end;

function TStyledControl.DoSetWidth(var Value: Single; NewValue: single; var LastValue: Single): boolean;
begin
  if FAdjustType in [TAdjustType.FixedSize, TAdjustType.FixedWidth] then
    NewValue := FAdjustSizeValue.Width;
  Result := inherited DoSetWidth(Value, NewValue, LastValue);
end;

procedure TStyledControl.SetStyleLookup(const Value: string);
begin
  FStyleLookup := Value;
  NeedStyleLookup;
  if not(csLoading in ComponentState) and Assigned(FScene) and not IsUpdating then
  begin
    ApplyStyleLookup;
  end;
end;

procedure TStyledControl.StyleChangedHandler(const Sender: TObject; const Msg: TMessage);
begin
  if Assigned(TStyleChangedMessage(Msg).StyleBook) and Assigned(Scene) and (Scene.StyleBook <> TStyleChangedMessage(Msg).StyleBook) then Exit;
  DoStyleChanged;
end;

procedure TStyledControl.UpdateStyle;
begin
  DoStyleChanged;
end;

function TStyledControl.GetBackIndex: Integer;
begin
  Result := 1;
end;

function TStyledControl.IsHelpContextStored: Boolean;
begin
  // Result := (FActionLink = nil) or not FActionLink.IsHelpContextLinked;
  Result := (FHelpContext <> 0);
end;

function TStyledControl.IsStyleLookupStored: Boolean;
begin
  Result := not ((FStyleLookup = '') or SameText(FStyleLookup, GetDefaultStyleLookupName));
end;

procedure TStyledControl.ScaleChangedHandler(const Sender: TObject; const Msg: FMX.Messages.TMessage);
begin
  DoStyleChanged;
end;

procedure TStyledControl.SetHelpContext(const Value: THelpContext);
begin
  if not(csLoading in ComponentState) then
    FHelpType := htContext;
  FHelpContext := Value;
end;

procedure TStyledControl.SetHelpKeyword(const Value: string);
begin
  if not(csLoading in ComponentState) then
    FHelpType := htKeyword;
  FHelpKeyword := Value;
end;

{ TStyleContainer }

destructor TStyleContainer.Destroy;
begin
  FreeAndNil(FBinary);
  FreeAndNil(FBinaryDict);
  inherited;
end;

function TStyleContainer.FindStyleResource(const AStyleLookup: string; const Clone: Boolean = False): TFmxObject;
var
  StyleObject: TFmxObject;
  StyleName: string;
  BinaryStream: TMemoryStream;
  Rec: TLinkRec;
begin
  if Clone then
  begin
    {$IFDEF NEXTGEN}
    Result := nil;
    if Assigned(FBinaryDict) and Assigned(FBinary) then
    begin
      StyleName := AStyleLookup.ToLowerInvariant;
      if FBinaryDict.TryGetValue(StyleName, Rec) then
      begin
        FBinary.Position := Rec.Offset;

        BinaryStream := TMemoryStream.Create;
        BinaryStream.SetSize(Rec.Size);
        BinaryStream.CopyFrom(FBinary, Rec.Size);
        BinaryStream.Position := 0;
        StyleObject := TFmxObject(BinaryStream.ReadComponent(nil));
        AddObject(StyleObject);
        ChangeChildren;
        BinaryStream.Free;
        Exit(StyleObject);
      end;
    end else
    {$ENDIF}
      Result := inherited FindStyleResource(AStyleLookup, Clone);
  end else begin
    Result := inherited FindStyleResource(AStyleLookup, Clone);
    if not Assigned(Result) and Assigned(FBinaryDict) and Assigned(FBinary) then
    begin
      StyleName := AStyleLookup.ToLowerInvariant;
      if FBinaryDict.TryGetValue(StyleName, Rec) then
      begin
        FBinary.Position := Rec.Offset;

        BinaryStream := TMemoryStream.Create;
        BinaryStream.SetSize(Rec.Size);
        BinaryStream.CopyFrom(FBinary, Rec.Size);
        BinaryStream.Position := 0;
        StyleObject := TFmxObject(BinaryStream.ReadComponent(nil));
        AddObject(StyleObject);
        ChangeChildren;
        BinaryStream.Free;
        Exit(StyleObject);
      end;
    end;
  end;
end;

procedure TStyleContainer.LoadFromIndexedStream(const AStream: TStream);
type
  TIndexItem = record
    Name: string;
    Size: Int64;
  end;
var
  R: TReader;
  StyleObject: TFmxObject;
  BinaryStream: TMemoryStream;
  Index: array of TIndexItem;
  Offset: Int64;
  I: Integer;
{$IFDEF NEXTGEN}
  Rec: TLinkRec;
{$ENDIF}
begin
  if not Assigned(FBinaryDict) then
    FBinaryDict := TDictionary<string,TLinkRec>.Create(300);

  R := TReader.Create(AStream, 1024);
  R.ReadListBegin;
  while not R.EndOfList do
  begin
    SetLength(Index, Length(Index) + 1);
    Index[High(Index)].Name := R.ReadString.ToLowerInvariant;
    Index[High(Index)].Size := R.ReadInteger;
  end;
  R.ReadListEnd;
  R.Free;

  if not Assigned(FBinary) then
    FBinary := TMemoryStream.Create;
  FBinary.SetSize(AStream.Size - AStream.Position);
  FBinary.Position := 0;
  FBinary.CopyFrom(AStream, AStream.Size - AStream.Position);

  Offset := 0;
  for I := 0 to High(Index) do
  begin
    {$IFNDEF NEXTGEN}
    FBinary.Position := Offset;

    BinaryStream := TMemoryStream.Create;
    BinaryStream.SetSize(Index[I].Size);
    BinaryStream.CopyFrom(FBinary, Index[I].Size);
    BinaryStream.Position := 0;
    StyleObject := TFmxObject(BinaryStream.ReadComponent(nil));
    AddObject(StyleObject);
    BinaryStream.Free;
    {$ELSE}
    if Index[I].Name.Contains('.png') then
    begin
      FBinary.Position := Offset;

      BinaryStream := TMemoryStream.Create;
      BinaryStream.SetSize(Index[I].Size);
      BinaryStream.CopyFrom(FBinary, Index[I].Size);
      BinaryStream.Position := 0;
      StyleObject := TFmxObject(BinaryStream.ReadComponent(nil));
      AddObject(StyleObject);
      BinaryStream.Free;
    end else if not Index[I].Name.IsEmpty and not FBinaryDict.ContainsKey(Index[I].Name) then
    begin
      Rec.Offset := Offset;
      Rec.Size := Index[I].Size;
      FBinaryDict.Add(Index[I].Name, Rec);
    end;
    {$ENDIF}
    Offset := Offset + Index[I].Size;
  end;
end;

procedure TStyleContainer.Release;
var
  StyleObject: TFmxObject;
begin
  FreeAndNil(FBinaryDict);
  if Assigned(Children) then
    for StyleObject in Children do
      StyleObject.StyleName := '';
  inherited;
end;

{ TStyleBook }

constructor TStyleBook.Create(AOwner: TComponent);
begin
  inherited;
  FResource := TStringList.Create;
  TStringList(FResource).OnChange := DoResourceChanged;
  FStyle := TStyleContainer.Create(nil);
end;

destructor TStyleBook.Destroy;
begin
  FreeAndNil(FStyle);
  FreeAndNil(FResource);
  inherited;
end;

procedure TStyleBook.Loaded;
begin
  inherited;
  if FFileName <> '' then LoadFromFile;
  if FNeedRecreateStyle then
    RecreateStyleFromResource;
  if FNeedUpdateStyle then
  begin
    TMessageManager.DefaultManager.SendMessage(nil, TBeforeStyleChangingMessage.Create, True);
    TMessageManager.DefaultManager.SendMessage(nil, TStyleChangedMessage.Create(Self), True);
  end;
end;

procedure TStyleBook.LoadFromFile;
var
  FName: string;
begin
  if not(csLoading in ComponentState) then
  begin
    if FileExists(ExtractFilePath(ParamStr(0)) + FFileName) then
      FName := ExtractFilePath(ParamStr(0)) + FFileName
    else if FileExists(FFileName) then
      FName := FFileName
    else
      FName := '';

    if FName <> '' then
      FResource.LoadFromFile(FName);
  end;
end;

procedure TStyleBook.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('ResourcesBin', ReadResources, WriteResources, FileName = '');
end;

procedure TStyleBook.WriteResources(Stream: TStream);
begin
  TStyleManager.SaveStyleToIndexedBinary(FStyle, Stream);
end;

procedure TStyleBook.ReadResources(Stream: TStream);
{$IFNDEF NEXTGEN}
var
  Desc: TStyleDescription;
{$ENDIF}
begin
  FStyle.Free;
  FStyle := TStyleManager.LoadFromStream(Stream);
  {$IFNDEF NEXTGEN}
  Desc := TStyleManager.FindStyleDescriptor(FStyle);
  if Assigned(Desc) and Desc.PlatformTarget.ToUpper.Contains('[IOSALTERNATE]') and not (csDesigning in ComponentState) then
  begin
    FStyle.Release;
    FStyle := TStyleContainer.Create(nil);
  end;
  {$ENDIF}
  FNeedUpdateStyle := True;
end;

procedure TStyleBook.RecreateStyleFromResource;
var
  S: TStream;
  {$IFDEF WIN32}
  Desc: TStyleDescription;
  {$ENDIF}
  NeedUpdate: Boolean;
begin
  NeedUpdate := False;
  if Assigned(FStyle) then
    FStyle.Release;
  FStyle := nil;
  S := TMemoryStream.Create;
  try
    FResource.SaveToStream(S);
    if S.Position > 0 then
    begin
      S.Position := 0;
      FStyle := TStyleManager.LoadFromStream(S);
      if Assigned(FStyle) then
      begin
        {$IFDEF WIN32}
        Desc := TStyleManager.FindStyleDescriptor(FStyle);
        if Assigned(Desc) and Desc.PlatformTarget.ToUpper.Contains('[IOSALTERNATE]') and not (csDesigning in ComponentState) then
        begin
          FStyle.Release;
          FStyle := TStyleContainer.Create(nil);
        end else
          NeedUpdate := True;
        {$ENDIF}
      end else
        FStyle := TStyleContainer.Create(nil);
    end;
  finally
    S.Free;
  end;
  if NeedUpdate then
  begin
    TMessageManager.DefaultManager.SendMessage(nil, TBeforeStyleChangingMessage.Create, True);
    TMessageManager.DefaultManager.SendMessage(nil, TStyleChangedMessage.Create(Self), True);
  end;
end;

procedure TStyleBook.FillStrings;
var
  M, M2: TMemoryStream;
  SaveChanged: TNotifyEvent;
begin
  if Assigned(FStyle) then
  begin
    M := TMemoryStream.Create;
    try
      M.WriteComponent(FStyle);
      M.Position := 0;
      M2 := TMemoryStream.Create;
      try
        ObjectBinaryToText(M, M2);
        M2.Position := 0;
        SaveChanged := TStringList(FResource).OnChange;
        TStringList(FResource).OnChange := nil;
        TStringList(FResource).LoadFromStream(M2);
        TStringList(FResource).OnChange := SaveChanged;
      finally
        M2.Free;
      end;
    finally
      M.Free;
    end;
  end;
end;

function TStyleBook.GetDesignResource: string;
begin
  Result := FDesignResource;
end;

function TStyleBook.IsResourceStored: Boolean;
begin
  Result := False;
end;

procedure TStyleBook.DoResourceChanged(Sender: TObject);
begin
  if csLoading in ComponentState then
    FNeedRecreateStyle := True
  else
    RecreateStyleFromResource;
end;

procedure TStyleBook.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FHiResStyleBook) then
    HiResStyleBook := nil;
end;

procedure TStyleBook.SetDesignResource(const Value: string);
begin
  FDesignResource := Value;
end;

procedure TStyleBook.SetFileName(const Value: string);
begin
  if FFileName <> Value then
  begin
    FFileName := Value;
    LoadFromFile;
  end;
end;

procedure TStyleBook.SetResource(const Value: TStrings);
begin
  FResource.Assign(Value);
end;

procedure TStyleBook.SetHiResStyleBook(const Value: TStyleBook);
begin
  FHiResStyleBook := Value;
end;

{ TStyleChangedMessage }

constructor TStyleChangedMessage.Create(const AStyleBook: TStyleBook);
begin
  inherited Create;
  FStyleBook := AStyleBook;
end;

{ TStyleManagerHelper }

class function TStyleManagerHelper.ActiveStyleForScene(const Scene: IScene): TFmxObject;
{$IFDEF MSWINDOWS}
var
  StyleSrv: IFMXStyleService;
{$ENDIF}
begin
  {$IFDEF MSWINDOWS}
  if Assigned(Scene) and (csDesigning in Scene.GetObject.ComponentState) and (Scene.GetObject is TCommonCustomForm) and
    Assigned(TCommonCustomForm(Scene.GetObject).Designer) and
    TCommonCustomForm(Scene.GetObject).Designer.SupportsPlatformService(IFMXStyleService, IInterface(StyleSrv)) then
  begin
    Result := StyleSrv.GetSystemStyle;
  end else if Assigned(Scene) and (csDesigning in Scene.GetObject.ComponentState) and (Scene.GetObject is TFmxObject) and
    Assigned(TFmxObject(Scene.GetObject).Root) and (TFmxObject(Scene.GetObject).Root.GetObject is TCommonCustomForm) and
    Assigned(TCommonCustomForm(TFmxObject(Scene.GetObject).Root.GetObject).Designer) and
    TCommonCustomForm(TFmxObject(Scene.GetObject).Root.GetObject).Designer.SupportsPlatformService(IFMXStyleService, IInterface(StyleSrv)) then
  begin
    Result := StyleSrv.GetSystemStyle;
  end else
  {$ENDIF}
  if Assigned(Scene) and (Scene.GetSceneScale > 1.0) then
    Result := ActiveStyleHiRes
  else
    Result := ActiveStyle;
end;

class function TStyleManagerHelper.GetStyleDescriptionForControl(const AObject: TControl): TStyleDescription;
var
  Resources: TFmxObject;
begin
  if Assigned(AObject) and Assigned(AObject.Scene) and Assigned(AObject.Scene.StyleBook) then
    Resources := AObject.Scene.StyleBook.Style
  else
    Resources := ActiveStyleForScene(AObject.Scene);
  Result := FindStyleDescriptor(Resources);
end;

{ TTextControl }

type
  TTextControlSettings = class (TTextSettings)
  private
    FTextControl: TTextControl;
  protected
    procedure DoChanged; override;
  public
    constructor Create(const AOwner: TPersistent); override;
    property TextControl: TTextControl read FTextControl;
  end;

{ TTextControlSettings }

constructor TTextControlSettings.Create(const AOwner: TPersistent);
begin
  inherited;
  if AOwner is TTextControl then
    FTextControl := TTextControl(AOwner);
end;

procedure TTextControlSettings.DoChanged;
begin
  if Assigned(FTextControl) then
    FTextControl.Change;
  inherited;
end;

constructor TTextControl.Create(AOwner: TComponent);
begin
  inherited;
  FIsChanging := True;
  FIsDisableDesign := True;
  FTextSettings := TTextControlSettings.Create(Self);
  FDefaultTextSettings := TTextSettings.Create(Self);
  FDefaultShadowSettings := TTextSettings.Create(Self);
  FLastTextSettings := TTextSettings.Create(Self);
  FStyledSettings := DefaultStyledSettings;
  EnableExecuteAction := True;
end;

destructor TTextControl.Destroy;
begin
  FreeAndNil(FLastTextSettings);
  FreeAndNil(FDefaultTextSettings);
  FreeAndNil(FDefaultShadowSettings);
  FreeAndNil(FTextSettings);
  inherited;
end;

procedure TTextControl.AfterConstruction;
begin
  inherited;
  FIsChanging := False;
end;

procedure TTextControl.DefineProperties(Filer: TFiler);
begin
  inherited;
  // Only for backward compatibility with XE2
  Filer.DefineProperty('FontFill.Color', ReadFontFillColor, nil, False);
  Filer.DefineProperty('FontFill.Kind', ReadFontFillKind, nil, False);
end;

procedure TTextControl.SetName(const Value: TComponentName);
var
  ChangeText: Boolean;
begin
  ChangeText := not(csLoading in ComponentState) and (Name = Text) and
    ((Not Assigned(Owner)) or not(Owner is TComponent) or not(csLoading in TComponent(Owner).ComponentState));
  inherited SetName(Value);
  if ChangeText then
    Text := Value;
end;

procedure TTextControl.ActionChange(Sender: TBasicAction;
  CheckDefaults: Boolean);
begin
  if Sender is TCustomAction then
  begin
    if (not CheckDefaults) or (Text = '') or (Text = Name) then
     Text := TCustomAction(Sender).Text;
  end;
  inherited;
end;

function TTextControl.FindTextObject: TFmxObject;
begin
  Result := FindStyleResource('text');
end;

procedure TTextControl.ApplyStyle;
var
  S: TFmxObject;
  NewT : string;
begin
  FTextSettings.BeginUpdate;
  try
    FIsDisableDesign := True;
    inherited;
    { from text }
    S := FindTextObject;
    if Assigned(S) and (S is TControl) then
    begin
      FTextObject := TControl(S);
      if Supports(S, ITextSettings, FITextSettings) then
        FDefaultTextSettings.Assign(FITextSettings.TextSettings)
      else
        FDefaultTextSettings.Assign(nil);
    end
    else
      FDefaultTextSettings.Assign(nil);
    { from foreground }
    S := FindStyleResource('foreground');
    if Assigned(S) and (S is TBrushObject) then
    begin
      // use instead of the black, foreground color
      if FDefaultTextSettings.FontColor = claBlack then
        FDefaultTextSettings.FontColor := TBrushObject(S).Brush.Color;
    end;
    { shadow }
    S := FindStyleResource('textshadow');
    if Assigned(S) and (S is TControl) then
    begin
      FTextShadow := TControl(S);
      if Supports(S, ITextSettings, FIShadowSettings) then
        FDefaultShadowSettings.Assign(FIShadowSettings.TextSettings)
      else
        FDefaultShadowSettings.Assign(nil);
    end;

    FTextSettings.Change;
  finally
    FTextSettings.EndUpdate;
  end;
  if AutoTranslate and (FText <> '') then
  begin
    NewT := Translate(Text); // need for collection texts
    if not(csDesigning in ComponentState) then
      Text := NewT;
  end;
end;


procedure TTextControl.DoStyleChanged;
var
  NewT : String;
begin
  inherited;
  if AutoTranslate and (FText <> '') then
  begin
    NewT := Translate(Text); // need for collection texts
    if not(csDesigning in ComponentState) then
      Text := NewT;
  end;
end;

procedure UpdateStyleSettings(const TextSettings,
                                    LastTextSettings,
                                    DefaultTextSettings: TTextSettings;
                                var StyledSettings: TStyledSettings);
var
  Tmp: TTextSettings;
begin
  if Assigned(DefaultTextSettings) then
  begin
    Tmp := DefaultTextSettings;
  end
  else
  begin
    Tmp := TTextSettings.Create(nil);
  end;
  try
    // If the user changed the value of the property, and it differs from the default,
    //  then delete the corresponding value from StyledSettings
    if (not SameText(LastTextSettings.Font.Family, TextSettings.Font.Family)) and (not SameText(Tmp.Font.Family, TextSettings.Font.Family)) then
      StyledSettings := StyledSettings - [TStyledSetting.ssFamily];

    if (not SameValue(LastTextSettings.Font.Size, TextSettings.Font.Size, Epsilon)) and (not SameValue(Tmp.Font.Size, TextSettings.Font.Size, Epsilon)) then
      StyledSettings := StyledSettings - [TStyledSetting.ssSize];

    if (LastTextSettings.Font.Style <> TextSettings.Font.Style) and (Tmp.Font.Style <> TextSettings.Font.Style) then
      StyledSettings := StyledSettings - [TStyledSetting.ssStyle];

    if (LastTextSettings.FontColor <> TextSettings.FontColor) and (Tmp.FontColor <> TextSettings.FontColor) then
      StyledSettings := StyledSettings - [TStyledSetting.ssFontColor];

    if ((LastTextSettings.HorzAlign <> TextSettings.HorzAlign) and
        (Tmp.HorzAlign <> TextSettings.HorzAlign))
    or ((LastTextSettings.VertAlign <> TextSettings.VertAlign) and
        (Tmp.VertAlign <> TextSettings.VertAlign))
    or ((LastTextSettings.Trimming <> TextSettings.Trimming) and
        (Tmp.Trimming <> TextSettings.Trimming))
    or ((LastTextSettings.WordWrap <> TextSettings.WordWrap) and
        (Tmp.WordWrap <> TextSettings.WordWrap)) then
      StyledSettings := StyledSettings - [TStyledSetting.ssOther];
  finally
    if not Assigned(DefaultTextSettings) then
      FreeAndNil(Tmp);
  end;
end;

procedure TTextControl.DoChanged;
  procedure UpdateShadowSettings(ShadowSettings: TTextSettings; const Master: TTextSettings);
  var
    Color: TAlphaColor;
  begin
    if not Assigned(ShadowSettings) then
      Exit;
    Color := ShadowSettings.FontColor;
    ShadowSettings.Assign(Master);
    ShadowSettings.FontColor := Color;
  end;

  procedure UpdateShadowText(Str: string);
  begin
    if not Assigned(FTextShadow) then
      Exit;
    if FTextShadow is TText then
      TText(FTextShadow).Text := Str
    else if FTextShadow is TTextControl then
      TTextControl(FTextShadow).Text := Str;
    // ? FTextShadow.UpdateEffects;
    //   FTextShadow.Repaint;
  end;
var
  TextStr: string;
begin
  if Assigned(FITextSettings) then
    FITextSettings.TextSettings.BeginUpdate;

  if Assigned(FIShadowSettings) then
    FIShadowSettings.TextSettings.BeginUpdate;

  try
    if Assigned(FITextSettings) then
    begin
      if (csDesigning in ComponentState) and (not FIsDisableDesign) then
        UpdateStyleSettings(FTextSettings,
                            FLastTextSettings,
                            FDefaultTextSettings,
                            FStyledSettings);
      FITextSettings.TextSettings.Assign(FDefaultTextSettings);
      FITextSettings.TextSettings.AssignNoStyled(TextSettings, FStyledSettings);
      if Assigned(FIShadowSettings) then
        UpdateShadowSettings(FIShadowSettings.TextSettings, FITextSettings.TextSettings);
      FIsDisableDesign := False;
      FLastTextSettings.Assign(TextSettings);
    end;

    TextStr := DelAmp(FText);
    if Assigned(FTextObject) then
    begin
      // set text value
      if FTextObject is TText then
      begin
        TText(FTextObject).Text := TextStr;
        TText(FTextObject).Width := Min(TText(FTextObject).Width, Width - TText(FTextObject).Position.X - 5);
      end;
      if FTextObject is TTextControl then
        TTextControl(FTextObject).Text := TextStr;
      UpdateShadowText(TextStr);
      // Effects
      FTextObject.UpdateEffects;
      UpdateEffects;
      FTextObject.Repaint;
    end
    else
    begin
      if Assigned(ResourceControl) and (ResourceControl is TText) then
        TText(ResourceControl).Text := TextStr
      else
        Repaint;
      UpdateEffects;
    end;
  finally
    if Assigned(FITextSettings) then
      FITextSettings.TextSettings.EndUpdate;
    if Assigned(FIShadowSettings) then
      FIShadowSettings.TextSettings.EndUpdate;
  end;
end;

procedure TTextControl.Change;
begin
  if (not FIsChanging) and ([csLoading, csDestroying] * ComponentState = []) then
  begin
    FIsChanging := True;
    try
      DoChanged;
    finally
      FIsChanging := False;
    end;
  end;
end;

procedure TTextControl.FreeStyle;
begin
  if not (csDestroying in ComponentState) then
  begin
    if Assigned(FITextSettings) then
      FITextSettings.TextSettings.Assign(FDefaultTextSettings);
    if Assigned(FIShadowSettings) then
      FIShadowSettings.TextSettings.Assign(FDefaultShadowSettings);
  end;
  FITextSettings := nil;
  FIShadowSettings := nil;

  FTextObject := nil;
  FTextShadow := nil;
  if Assigned(FDefaultTextSettings) then
    FDefaultTextSettings.Assign(nil);
  inherited;
end;

function TTextControl.IsTextStored: Boolean;
begin
  Result := ((Text <> '') and (not ActionClient))
            or
            (not (ActionClient and
                  (ActionLink is TActionLink) and
                  (TOpenFMXActionLink(ActionLink).IsCaptionLinked) and
                  (Action is TContainedAction)));
end;

procedure TTextControl.Loaded;
begin
  inherited;
  Change;
end;

procedure TTextControl.ReadFontFillColor(Reader: TReader);
var LFontColor: TAlphaColor;
begin
  IdentToAlphaColor(Reader.ReadIdent, Longint(LFontColor));
  FontColor := LFontColor;
end;

procedure TTextControl.ReadFontFillKind(Reader: TReader);
begin
  Reader.ReadIdent;
end;

function TTextControl.GetText: string;
begin
  Result := FText;
end;

procedure TTextControl.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    FTextSettings.Change;
  end;
end;

procedure TTextControl.SetStyledSettings(const Value: TStyledSettings);
begin
  if FStyledSettings <> Value then
  begin
    FStyledSettings := Value;
    Change;
  end;
end;

function TTextControl.GetData: TValue;
begin
  Result := Text;
end;

procedure TTextControl.SetData(const Value: TValue);
begin
  if Value.IsEmpty then
    Text := ''
  else
    Text := Value.ToString;
end;

function TTextControl.GetFont: TFont;
begin
  Result := FTextSettings.Font;
end;

procedure TTextControl.SetFont(const Value: TFont);
begin
  FTextSettings.Font := Value;
end;

function TTextControl.GetFontColor: TAlphaColor;
begin
  Result := FTextSettings.FontColor;
end;

procedure TTextControl.SetFontColor(const Value: TAlphaColor);
begin
  FTextSettings.FontColor := Value;
end;

function TTextControl.GetTextAlign: TTextAlign;
begin
  Result := FTextSettings.HorzAlign;
end;

procedure TTextControl.SetTextAlign(const Value: TTextAlign);
begin
  FTextSettings.HorzAlign := Value;
end;

function TTextControl.GetVertTextAlign: TTextAlign;
begin
  Result := FTextSettings.VertAlign;
end;

procedure TTextControl.SetVertTextAlign(const Value: TTextAlign);
begin
  FTextSettings.VertAlign := Value;
end;

function TTextControl.GetWordWrap: Boolean;
begin
  Result := FTextSettings.WordWrap;
end;

procedure TTextControl.SetWordWrap(const Value: Boolean);
begin
  FTextSettings.WordWrap := Value;
end;

function TTextControl.StyledSettingsStored: Boolean;
begin
  Result := FStyledSettings <> DefaultStyledSettings;
end;

function TTextControl.GetDefaultTextSettings: TTextSettings;
begin
  Result := FDefaultTextSettings;
end;

function TTextControl.GetTextSettings: TTextSettings;
begin
  Result := FTextSettings;
end;

procedure TTextControl.SetTextSettings(const Value: TTextSettings);
begin
  FTextSettings.Assign(Value);
end;

function TTextControl.GetStyledSettings: TStyledSettings;
begin
  Result := FStyledSettings;
end;

function TTextControl.GetTrimming: TTextTrimming;
begin
  Result := FTextSettings.Trimming;
end;

procedure TTextControl.SetTrimming(const Value: TTextTrimming);
begin
  FTextSettings.Trimming := Value;
end;

{ TContent }

constructor TContent.Create(AOwner: TComponent);
begin
  inherited;
  SetAcceptsControls(False);
end;

procedure TContent.DoRealign;
var
  AlignRoot: IAlignRoot;
begin
  if Assigned(Parent) and not(csLoading in Parent.ComponentState) then
    inherited;
  if Assigned(Parent) and not FParentAligning and not(csLoading in ComponentState) then
  begin
    FParentAligning := True;
    if Assigned(FParentControl) then
      FParentControl.Realign
    else
      if not(csLoading in ComponentState) and Supports(Parent, IAlignRoot, AlignRoot) then
        AlignRoot.Realign;
    FParentAligning := False;
  end;
end;

{$REGION 'TPopupList'}
type
  TPopupList = class (TComponent)
  private
    FPopupList: TList<Pointer>;
    FInClear: Boolean;
    function GetItem(const Index: Integer): TPopup;
    function GetCount: Integer;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(Item: TPopup);
    procedure Remove(Item: TPopup);
    procedure Delete(const Index: Integer);
    function IndexOf(Item: TPopup): Integer;
    property Count: Integer read GetCount;
    property Item[const Index: Integer]: TPopup read GetItem; default;
  end;

var
  PopupList: TPopupList;

{ TPopupList }

constructor TPopupList.Create(AOwner: TComponent);
begin
  inherited;
  FPopupList := TList<Pointer>.Create;
end;

procedure TPopupList.Delete(const Index: Integer);
var
  Instance: TPopup;
begin
  if Assigned(FPopupList) then
  begin
    if (0 <= Index) and (Index < Count) then
    begin
      Instance := TPopup(FPopupList[Index]);
      FPopupList.Delete(Index);
      if Assigned(Instance) then
        RemoveFreeNotification(Instance);
    end;
  end;
end;

destructor TPopupList.Destroy;
begin
  Clear;
  FreeAndNil(FPopupList);
  inherited;
end;

procedure TPopupList.Add(Item: TPopup);
begin
  if (not (csDestroying in ComponentState)) and
     (Assigned(Item)) and
     (Assigned(FPopupList)) then
  begin
    if FPopupList.IndexOf(Item) < 0 then
    begin
      TComponent(Item).FreeNotification(self);
      FPopupList.Add(Item);
    end;
  end;
end;

procedure TPopupList.Clear;
var
  I: Integer;
  Instance: TPopup;
begin
  if not FInClear then
  begin
    FInClear := True;
    try
      for I := Count - 1 downto 0 do
      begin
        Instance := TPopup(FPopupList[I]);
        FPopupList.Delete(I);
        if Instance.HasPopupForm then
          TCommonCustomForm(Instance.FPopupForm).Close;
        if Assigned(Instance) then
          RemoveFreeNotification(Instance);
      end;
    finally
      FInClear := False;
    end;
  end;
end;

function TPopupList.GetCount: Integer;
begin
  if Assigned(FPopupList) then
    Result := FPopupList.Count
  else
    Result := 0;
end;

function TPopupList.GetItem(const Index: Integer): TPopup;
begin
  if (Index >= 0) and (Index < Count) then
  begin
    Result := TPopup(FPopupList[Index]);
  end
  else
    raise EListError.CreateFMT(sArgumentOutOfRange_Index, [Index, Count]);
end;

function TPopupList.IndexOf(Item: TPopup): Integer;
begin
  Result := FPopupList.IndexOf(Item);
end;

procedure TPopupList.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
begin
  inherited;
  if Operation = opRemove then
  begin
    if Assigned(FPopupList) then
    begin
      I := FPopupList.IndexOf(AComponent);
      if I >= 0 then
        FPopupList.Delete(I);
    end;
  end;
end;

procedure TPopupList.Remove(Item: TPopup);
var
  I: Integer;
  Instance: TPopup;
begin
  if Assigned(FPopupList) then
  begin
    I := FPopupList.IndexOf(Item);
    if I >= 0 then
    begin
      Instance := TPopup(FPopupList[I]);
      FPopupList.Delete(I);
      if Assigned(Instance) then
        RemoveFreeNotification(Instance);
    end;
  end;
end;
{$ENDREGION}

procedure ClosePopup(const AIndex: Integer);
begin
  if Assigned(PopupList) then
  begin
    if PopupList[AIndex].PopupForm is TCommonCustomForm then
      TCommonCustomForm(PopupList[AIndex].PopupForm).Close
    else
      PopupList[AIndex].ClosePopup;
    PopupList.Delete(AIndex);
  end;
end;

procedure ClosePopup(Wnd: TFmxObject);
var
  Index: Integer;
begin
  if Assigned(Wnd) and (Wnd is TPopup) then
  begin
    Index := PopupList.IndexOf(Wnd as TPopup);
    ClosePopup(Index);
  end;
end;

procedure CloseAllPopups;
var
  I: Integer;
begin
  { close other popups }
  if Assigned(PopupList) then
  begin
    I := PopupList.Count - 1;
    while I >= 0 do
    begin
      if PopupList[I].PopupForm is TCommonCustomForm then
        TCommonCustomForm(PopupList[I].PopupForm).Close
      else
        PopupList[I].ClosePopup;
      I := Min(I - 1, PopupList.Count - 1);
    end;
    PopupList.Clear;
  end;
end;

function IsPopup(const Wnd: TFmxObject): boolean;
var I: integer;
begin
  Result := Assigned(PopupList) and
            Assigned(Wnd) and
            (Wnd is TCommonCustomForm);
  if Result then
  begin
    Result := False;
    for I := 0 to PopupList.Count - 1 do
      if Wnd = PopupList[I].PopupForm then
      begin
        Result := True;
        Exit;
      end;
  end;
end;

function CanClosePopup(const Wnd: TFmxObject): boolean;
begin
  Result := IsPopup(Wnd) and
           (not TCommonCustomForm(Wnd).StaysOpen) and
           (Wnd = PopupList[PopupList.Count - 1].PopupForm);
end;

procedure PopupBringToFront;
begin
  if Assigned(PopupList) and
     (PopupList.Count > 0) and
     (PopupList[PopupList.Count].PopupForm is TCommonCustomForm) then
  begin
    TCommonCustomForm(PopupList[PopupList.Count].PopupForm).BringToFront;
  end;
end;

function GetPopup(const AIndex: Integer): TFmxObject;
begin
  if Assigned(PopupList) then
    Result := PopupList.Item[AIndex]
  else
    Result := nil;
end;

function GetPopupCount: Integer;
begin
  if Assigned(PopupList) then
    Result := PopupList.Count
  else
    Result := 0;
end;

{ TPopup }

constructor TPopup.Create(AOwner: TComponent);
begin
  inherited;
  FBorderWidth := 8;
  FPlacementRectangle := TBounds.Create(TRectF.Empty);
  Visible := False;
  CanFocus := True;
  SetAcceptsControls(False);
end;

procedure TPopup.CreatePopupForm;
var
  NewStyle: TStyleBook;
  P: TPointF;
begin
  if FClosingAnimation then
  begin
    FIsOpen := False;
    Exit;
  end;
  if FIsOpen then
    Exit;

  FPopupForm := TForm.CreateNew(Self);
  TCustomForm(FPopupForm).BeginUpdate;
  try
    TCustomForm(FPopupForm).TopMost := True;
    TCustomForm(FPopupForm).ShowActivated := False;
    TCustomForm(FPopupForm).StaysOpen := StaysOpen;
    TCustomForm(FPopupForm).BorderStyle := TFmxFormBorderStyle.bsNone;
    TCustomForm(FPopupForm).Fill.Kind := TBrushKind.bkNone;
    TCustomForm(FPopupForm).Transparency := True;
    TCustomForm(FPopupForm).SetBounds(0, 0,
                                      Round((Width + 2 * BorderWidth) * AbsoluteMatrix.m11),
                                      Round((Height + 2 * BorderWidth) * AbsoluteMatrix.m22));
    TComponent(FPopupForm).FreeNotification(self);
    TCustomForm(FPopupForm).OnClose := DoFormClose;
    TOpenForm(FPopupForm).SetStyleBookWithoutUpdate(FStyleBook);
    Scale.X := AbsoluteMatrix.m11;
    Scale.Y := AbsoluteMatrix.m22;
    ApplyPlacement;
    { get style }
    if not Assigned(FStyleBook) and Assigned(FScene) then
      NewStyle := FScene.GetStyleBook
    else
      NewStyle := FStyleBook;
    P := TPointF.Create(BorderWidth * Scale.X, BorderWidth * Scale.Y);
    Position.Point := P;
  finally
    TCustomForm(FPopupForm).EndUpdate;
  end;

  { change style }
  if Assigned(NewStyle) then
    TOpenForm(FPopupForm).SetStyleBookWithoutUpdate(NewStyle);
end;

destructor TPopup.Destroy;
begin
  ClosePopup;
  if HasPopupForm then
  begin
    if Parent = FPopupForm then
      Parent := nil;
    FreeAndNil(FPopupForm);
  end;
  FreeAndNil(FPlacementRectangle);
  FreeAndNil(FDragTimer);
  inherited;
end;

procedure TPopup.Paint;
var
  R: TRectF;
begin
  if (csDesigning in ComponentState) then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.Stroke.Thickness := 1;
    Canvas.Stroke.Dash := TStrokeDash.sdDash;
    Canvas.Stroke.Kind := TBrushKind.bkSolid;
    Canvas.Stroke.Color := $A0909090;
    Canvas.DrawRect(R, 0, 0, AllCorners, AbsoluteOpacity);
  end;
end;

procedure TPopup.ApplyPlacement;
var
  Target: TControl;
  AbsolutePos, LocalPos: TPointF;
  Pos: TPointF;
  MouseSvc: IFMXMouseService;
begin
  Target := PlacementTarget;

  if (not Assigned(Target)) and Assigned(FParentControl) then
    Target := TControl(Parent);
  if not Assigned(Target) then
  begin
    case Placement of
      TPlacement.plBottom:
        begin
          LocalPos := PointF(FPlacementRectangle.Left + HorizontalOffset, FPlacementRectangle.Bottom + VerticalOffset);
        end;
      TPlacement.plTop:
        begin
          LocalPos := PointF(FPlacementRectangle.Left + HorizontalOffset, FPlacementRectangle.Top - Height -
            VerticalOffset);
        end;
      TPlacement.plLeft:
        begin
          LocalPos := PointF(FPlacementRectangle.Left - Width - HorizontalOffset,
            FPlacementRectangle.Top + VerticalOffset);
        end;
      TPlacement.plRight:
        begin
          LocalPos := PointF(FPlacementRectangle.Right + HorizontalOffset, FPlacementRectangle.Top + VerticalOffset);
        end;
      TPlacement.plBottomCenter:
        begin
          LocalPos := PointF(FPlacementRectangle.Left + HorizontalOffset, FPlacementRectangle.Bottom + VerticalOffset);
        end;
      TPlacement.plTopCenter:
        begin
          LocalPos := PointF(FPlacementRectangle.Left + HorizontalOffset, FPlacementRectangle.Top - Height -
            VerticalOffset);
        end;
      TPlacement.plLeftCenter:
        begin
          LocalPos := PointF(FPlacementRectangle.Left - Width - HorizontalOffset,
            FPlacementRectangle.Top + VerticalOffset);
        end;
      TPlacement.plRightCenter:
        begin
          LocalPos := PointF(FPlacementRectangle.Right + HorizontalOffset, FPlacementRectangle.Top + VerticalOffset);
        end;
      TPlacement.plCenter:
        begin
          LocalPos := PointF(FPlacementRectangle.Left + (FPlacementRectangle.Right - FPlacementRectangle.Left - Width) /
            2, FPlacementRectangle.Top + (FPlacementRectangle.Bottom - FPlacementRectangle.Top - Height) / 2);
          LocalPos.X := LocalPos.X + HorizontalOffset;
          LocalPos.Y := LocalPos.Y + VerticalOffset;
        end;
      TPlacement.plAbsolute:
        begin
          TForm(FPopupForm).Left := Round(FPlacementRectangle.Left);
          TForm(FPopupForm).Top := Round(FPlacementRectangle.Top);
          Exit;
        end;
      TPlacement.plMouse:
        begin
          if not TPlatformServices.Current.SupportsPlatformService(IFMXMouseService, IInterface(MouseSvc)) then
            raise EUnsupportedPlatformService.Create('IFMXMouseService');
          Pos := MouseSvc.GetMousePos;
          TForm(FPopupForm).Left := Round(Pos.X);
          TForm(FPopupForm).Top := Round(Pos.Y);
          Exit;
        end;
      TPlacement.plMouseCenter:
        begin
          if not TPlatformServices.Current.SupportsPlatformService(IFMXMouseService, IInterface(MouseSvc)) then
            raise EUnsupportedPlatformService.Create('IFMXMouseService');
          Pos := MouseSvc.GetMousePos;
          TForm(FPopupForm).Left := Round(Pos.X) - Round(Width / 2);
          TForm(FPopupForm).Top := Round(Pos.Y);
          Exit;
        end;
    end;
    if Assigned(FScene) then
      Pos := FScene.LocalToScreen(PointF(LocalPos.X, LocalPos.Y))
    else
      Pos := LocalPos;
  end
  else
  begin
    case Placement of
      TPlacement.plBottom:
        begin
          if FPlacementRectangle.Empty then
            LocalPos := PointF(HorizontalOffset, Target.Height + VerticalOffset)
          else
            LocalPos := PointF(FPlacementRectangle.Left + HorizontalOffset, FPlacementRectangle.Bottom + VerticalOffset);
        end;
      TPlacement.plTop:
        begin
          if FPlacementRectangle.Empty then
            LocalPos := PointF(HorizontalOffset, -Height - HorizontalOffset)
          else
            LocalPos := PointF(FPlacementRectangle.Left + HorizontalOffset, FPlacementRectangle.Top - Height -
              VerticalOffset);
        end;
      TPlacement.plLeft:
        begin
          if FPlacementRectangle.Empty then
            LocalPos := PointF(-Width - HorizontalOffset, VerticalOffset)
          else
            LocalPos := PointF(FPlacementRectangle.Left - Width - HorizontalOffset,
              FPlacementRectangle.Top + VerticalOffset);
        end;
      TPlacement.plRight:
        begin
          if FPlacementRectangle.Empty then
            LocalPos := PointF(Target.Width + HorizontalOffset, VerticalOffset)
          else
            LocalPos := PointF(FPlacementRectangle.Right + HorizontalOffset, FPlacementRectangle.Top + VerticalOffset);
        end;
      TPlacement.plBottomCenter:
        begin
          if FPlacementRectangle.Empty then
            LocalPos := PointF(HorizontalOffset - (Width / 2) + (Target.Width / 2), Target.Height + VerticalOffset)
          else
            LocalPos := PointF((FPlacementRectangle.Left + FPlacementRectangle.Right) / 2 - (Width / 2) +
              HorizontalOffset, FPlacementRectangle.Bottom + VerticalOffset);
        end;
      TPlacement.plTopCenter:
        begin
          if FPlacementRectangle.Empty then
            LocalPos := PointF(HorizontalOffset - (Width / 2) + (Target.Width / 2), -Height - HorizontalOffset)
          else
            LocalPos := PointF((FPlacementRectangle.Left + FPlacementRectangle.Right) / 2 - (Width / 2) +
              HorizontalOffset, FPlacementRectangle.Top - Height - VerticalOffset);
        end;
      TPlacement.plLeftCenter:
        begin
          if FPlacementRectangle.Empty then
            LocalPos := PointF(-Width - HorizontalOffset, VerticalOffset - (Height / 2) + (Target.Height / 2))
          else
            LocalPos := PointF(FPlacementRectangle.Left - Width - HorizontalOffset,
              FPlacementRectangle.Top + VerticalOffset);
        end;
      TPlacement.plRightCenter:
        begin
          if FPlacementRectangle.Empty then
            LocalPos := PointF(Target.Width + HorizontalOffset, VerticalOffset - (Height / 2) + (Target.Height / 2))
          else
            LocalPos := PointF(FPlacementRectangle.Right + HorizontalOffset, FPlacementRectangle.Top + VerticalOffset);
        end;
      TPlacement.plCenter:
        begin
          if FPlacementRectangle.Empty then
            LocalPos := PointF((Target.Width - Width) / 2, (Target.Height - Height) / 2)
          else
            LocalPos := PointF(FPlacementRectangle.Left + (FPlacementRectangle.Right - FPlacementRectangle.Left - Width)
              / 2, FPlacementRectangle.Top + (FPlacementRectangle.Bottom - FPlacementRectangle.Top - Height) / 2);
          LocalPos.X := LocalPos.X + HorizontalOffset;
          LocalPos.Y := LocalPos.Y + VerticalOffset;
        end;
      TPlacement.plAbsolute:
        begin
          TForm(FPopupForm).Left := Round(FPlacementRectangle.Left);
          TForm(FPopupForm).Top := Round(FPlacementRectangle.Top);
          Exit;
        end;
      TPlacement.plMouse:
        begin
          if not TPlatformServices.Current.SupportsPlatformService(IFMXMouseService, IInterface(MouseSvc)) then
            raise EUnsupportedPlatformService.Create('IFMXMouseService');
          Pos := MouseSvc.GetMousePos;
          TForm(FPopupForm).Left := Round(Pos.X);
          TForm(FPopupForm).Top := Round(Pos.Y);
          Exit;
        end;
      TPlacement.plMouseCenter:
        begin
          if not TPlatformServices.Current.SupportsPlatformService(IFMXMouseService, IInterface(MouseSvc)) then
            raise EUnsupportedPlatformService.Create('IFMXMouseService');
          Pos := MouseSvc.GetMousePos;
          TForm(FPopupForm).Left := Round(Pos.X) - Round(Width / 2);
          TForm(FPopupForm).Top := Round(Pos.Y);
          Exit;
        end;
    end;
    AbsolutePos := Target.LocalToScreen(LocalPos);
    Pos := PointF(AbsolutePos.X - BorderWidth * Scale.X,
                  AbsolutePos.Y - BorderWidth * Scale.Y);
  end;
  TForm(FPopupForm).Left := Round(Pos.X);
  TForm(FPopupForm).Top := Round(Pos.Y);
end;

function TPopup.GetPopupForm: TFmxObject;
begin
  if HasPopupForm and
    (FPopupForm is TCommonCustomForm) and
    (not TCommonCustomForm(FPopupForm).StaysOpen) then
    Result := TCommonCustomForm(FPopupForm)
  else
    Result := nil;
end;

function TPopup.HasPopupForm: Boolean;
begin
  Result := Assigned(FPopupForm);
end;

procedure TPopup.Popup(const AShowModal: Boolean = False);
begin
  if FClosingAnimation then
  begin
    FIsOpen := False;
    Exit;
  end;
  if FIsOpen then
    Exit;

  FSaveScale := Scale.Point;
  FSaveParent := Parent;

  CreatePopupForm;

  if not Assigned(PopupList) then
    PopupList := TPopupList.Create(nil);
  if not StaysOpen then
    PopupList.Add(Self);

  { show }
  Parent := FPopupForm;
  Visible := True;
  if AShowModal then
    FModalResult := TForm(FPopupForm).ShowModal
  else
    TForm(FPopupForm).Show;
  
  DoPopup;

  { trigger }
  FIsOpen := True;
  ApplyTriggerEffect(Self, 'IsOpen');
  StartTriggerAnimation(Self, 'IsOpen');
  { drag timer }
  if FDragWithParent then
  begin
    if not Assigned(FDragTimer) then
    begin
      FDragTimer := TTimer.Create(Self);
      FDragTimer.Interval := 10;
      FDragTimer.OnTimer := DoTimer;
    end;
    FDragTimer.Enabled := True;
  end;
end;

procedure TPopup.SetModalResult(const Value: TModalResult);
begin
  FModalResult := Value;
end;

function TPopup.PopupModal: TModalResult;
var
  LStaysOpen : Boolean;
begin
  Result := 0;
  if FClosingAnimation then
  begin
    FIsOpen := False;
    Exit;
  end;
  if FIsOpen then
    Exit;

  LStaysOpen := FStaysOpen;
  try
    FStaysOpen := True;
    Popup(True);
    Result := FModalResult;
    IsOpen := False;
  finally
    FStaysOpen := LStaysOpen;
  end;
end;

procedure TPopup.DialogKey(var Key: Word; Shift: TShiftState);
begin
  inherited DialogKey(Key, Shift);
  if (Key = vkEscape) and IsOpen and not StaysOpen then
  begin
    IsOpen := False;
    Key := 0;
  end;
end;

procedure TPopup.ApplyStyle;
var
  B: TFmxObject;
begin
  inherited ApplyStyle;
  B := FindStyleResource('background');
  if Assigned(B) and (B is TControl) then
    Padding.Rect := TControl(B).Padding.Rect;
end;

procedure TPopup.ClosePopup;
begin
  if FClosingAnimation or not HasPopupForm then
    Exit;
  if FModal and (FModalResult = 0) then
  begin
    ModalResult := mrCancel;
    Exit;
  end;
  { drag timer }
  FreeAndNil(FDragTimer);
  { trigger }
  FClosingAnimation := True;
  FIsOpen := False;
  if not (csDestroying in ComponentState) then
  begin
    ApplyTriggerEffect(Self, 'IsOpen');
    StartTriggerAnimationWait(Self, 'IsOpen');
  end;
  { hide }
  Visible := False;
  { remove self }
  FPopupForm.RemoveObject(Self);
  TOpenForm(FPopupForm).SetStyleBookWithoutUpdate(nil);
  SetNewScene(nil);
  { free }
  if not (csDestroying in ComponentState) then
  begin
    Parent := FSaveParent;
    FSaveParent := nil;
    FPopupForm := nil;
    Scale.Point := FSaveScale;
    FClosingAnimation := False;
    DoClosePopup;
  end;
end;

procedure TPopup.DoClosePopup;
begin
  if Assigned(FOnClosePopup) and not (csDestroying in ComponentState) then
    FOnClosePopup(Self);
end;

procedure TPopup.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if (AComponent = FPopupForm) then
      FPopupForm := nil;
    if (AComponent = FPlacementTarget) then
      FPlacementTarget := nil;
    if (AComponent = FStyleBook) then
    begin
      FStyleBook := nil;
      if HasPopupForm then
        TForm(FPopupForm).StyleBook := nil;
    end;
    if (AComponent = FSaveParent) then
      FSaveParent := nil;
  end;
end;

procedure TPopup.SetIsOpen(const Value: Boolean);
begin
  if FIsOpen <> Value then
  begin
    if csDesigning in ComponentState then
    begin
      FIsOpen := False;
      Exit;
    end;
    if Value then
      Popup
    else
    begin
      if HasPopupForm then
        TCommonCustomForm(FPopupForm).Close
      else
        FIsOpen := Value;
    end;
  end;
end;

procedure TPopup.DoFormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not FIsOpen and HasPopupForm then
    DoClosePopup;
  try
    Action := TCloseAction.caFree;
    ClosePopup;
  finally
    FPopupForm := nil;
  end;
end;

procedure TPopup.DoPopup;
begin
  if Assigned(FOnPopup) then
    FOnPopup(Self);
end;

procedure TPopup.DoTimer(Sender: TObject);
begin
  if not HasPopupForm then
    Exit;
  if not (Placement in [TPlacement.plMouse, TPlacement.plMouseCenter]) then
    ApplyPlacement;
end;

procedure TPopup.SetPlacementRectangle(const Value: TBounds);
begin
  FPlacementRectangle.Assign(Value);
end;

procedure TPopup.SetPlacementTarget(const Value: TControl);
begin
  if FPlacementTarget <> Value then
  begin
    if Assigned(FPlacementTarget) then
      FPlacementTarget.RemoveFreeNotification(self);
    FPlacementTarget := Value;
    if Assigned(FPlacementTarget) then
      FPlacementTarget.FreeNotification(self);
  end;
end;

procedure TPopup.SetStyleBook(const Value: TStyleBook);
begin
  if FStyleBook <> Value then
  begin
    if Assigned(FStyleBook) then
      FStyleBook.RemoveFreeNotification(self);
    FStyleBook := nil;
    if HasPopupForm then
      TOpenForm(FPopupForm).SetStyleBookWithoutUpdate(StyleBook);
    FStyleBook := Value;
    if Assigned(FStyleBook) then
      FStyleBook.FreeNotification(self);
    if HasPopupForm and Assigned(FStyleBook) then
      TOpenForm(FPopupForm).SetStyleBookWithoutUpdate(FStyleBook);
  end;
end;

procedure TPopup.SetVisible(const Value: Boolean);
var
  V: Boolean;
begin
  V := Value and (not (csDesigning in ComponentState));
  inherited SetVisible(V);
end;

procedure TPopup.SetStaysOpen(const AValue: Boolean);
begin
  if FStaysOpen <> AValue  then
  begin
    FStaysOpen := AValue;
    if (not FStaysOpen) and HasPopupForm then
      TCommonCustomForm(FPopupForm).Close;
  end;
end;

function TPopup.GetFormLeft: Single;
begin
  if HasPopupForm then
    Result := TCommonCustomForm(FPopupForm).Left
  else
    Result := -1;
end;

procedure TPopup.SetFormLeft(ALeft: Single);
begin
  if HasPopupForm and not (csDesigning in ComponentState) then
    TCommonCustomForm(FPopupForm).Left := Round(ALeft);
end;

function TPopup.GetFormTop: Single;
begin
  if HasPopupForm then
    Result := TCommonCustomForm(FPopupForm).Top
  else
    Result := -1;
end;

procedure TPopup.SetFormTop(ATop: Single);
begin
  if HasPopupForm and not (csDesigning in ComponentState) then
    TCommonCustomForm(FPopupForm).Top := Round(ATop);
end;

{ TPathAnimation }

constructor TPathAnimation.Create(AOwner: TComponent);
begin
  inherited;
  FPath := TPathData.Create;
end;

destructor TPathAnimation.Destroy;
begin
  if Assigned(FSpline) then
    FreeAndNil(FSpline);
  FreeAndNil(FPath);
  inherited;
end;

procedure TPathAnimation.ProcessAnimation;
var
  OldP, P1: TPointF;
begin
  if (Length(FPolygon) > 0) and Assigned(FObj) then
  begin
    OldP := FObj.Position.Point;
    FSpline.SplineXY(NormalizedTime * High(FPolygon), P1.X, P1.Y);
    FObj.Position.X := FStart.X + P1.X;
    FObj.Position.Y := FStart.Y + P1.Y;
    if FRotate and (NormalizedTime <> 0) and (NormalizedTime <> 1) and
      ((OldP.X <> FObj.Position.X) and (OldP.Y <> FObj.Position.Y)) then
    begin
      if Inverse then
      begin
        if VectorCrossProductZ(Vector(FObj.Position.X - OldP.X,
          FObj.Position.Y - OldP.Y), Vector(0, 1)) < 0 then
          FObj.RotationAngle := 180 +
            RadToDeg(ArcCos(VectorAngleCosine(Vector(FObj.Position.X - OldP.X,
            FObj.Position.Y - OldP.Y), Vector(0, 1))))
        else
          FObj.RotationAngle := 180 -
            RadToDeg(ArcCos(VectorAngleCosine(Vector(FObj.Position.X - OldP.X,
            FObj.Position.Y - OldP.Y), Vector(0, 1))))
      end
      else
      begin
        if VectorCrossProductZ(Vector(FObj.Position.X - OldP.X,
          FObj.Position.Y - OldP.Y), Vector(0, 1)) < 0 then
          FObj.RotationAngle :=
            RadToDeg(ArcCos(VectorAngleCosine(Vector(FObj.Position.X - OldP.X,
            FObj.Position.Y - OldP.Y), Vector(0, 1))))
        else
          FObj.RotationAngle :=
            -RadToDeg(ArcCos(VectorAngleCosine(Vector(FObj.Position.X - OldP.X,
            FObj.Position.Y - OldP.Y), Vector(0, 1))))
      end;
    end;
  end;
end;

procedure TPathAnimation.SetPath(const Value: TPathData);
begin
  FPath.Assign(Value);
end;

procedure TPathAnimation.Start;
var
  i: Integer;
begin
  if Assigned(FSpline) then
    FreeAndNil(FSpline);
  SetLength(FPolygon, 0);
  FPath.FlattenToPolygon(FPolygon);
  if Length(FPolygon) > 1 then
    for i := 1 to High(FPolygon) do
      if (FPolygon[i].X = ClosePolygon.X) and (FPolygon[i].Y = ClosePolygon.Y)
      then
        FPolygon[i] := FPolygon[i - 1];
  FSpline := TSpline.Create(FPolygon);
  if Assigned(Parent) and (Parent is TControl) then
    FObj := TControl(Parent)
  else
    FObj := nil;
  if Assigned(FObj) then
    FStart := FObj.Position.Point;
  inherited;
end;

{ TContentInflater }

constructor TContentInflater<T>.Create(const Inflatable: IInflatableContent<T>);
begin
  FInflatable := Inflatable;
  TMessageManager.DefaultManager.SubscribeToMessage(TIdleMessage, ReceiveIdleMessage);
end;

destructor TContentInflater<T>.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TIdleMessage, ReceiveIdleMessage);
  inherited;
end;

procedure TContentInflater<T>.Inflate(Total: Boolean);
var
  I: Integer;
  Stop: TDateTime;
  Items: TList<T>;
begin
  Items := FInflatable.GetInflatableItems;
  if Items.Count = 0 then Exit;
  Stop := Now + EncodeTime(0, 0, 0, 50);
  for I := 0 to Items.Count - 1 do
  begin
    Items[I].Inflate;
    if (not Total) and (Now > Stop) then
      Break;
  end;

  Items.DeleteRange(0, I);
  if Items.Count = 0 then
    FInflatable.NotifyInflated;
end;

procedure TContentInflater<T>.ReceiveIdleMessage(const Sender : TObject; const M : TMessage);
begin
  Inflate(False);
end;

procedure FreeControls;
begin
  TStyleCache.Unitialize;
  FreeAndNil(PopupList);
end;

initialization
  RegisterShowVKProc(ShowVirtualKeyboard);
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);

  RegisterFmxClasses([TStyledControl, TContent, TPopup, TStyleContainer, TStyleBook, TPathAnimation], []);
end.

