{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Forms;

{$MINENUMSIZE 4}
{$H+}

{$IFDEF WIN32}
{$HPPEMIT '#pragma link "d3d10.lib"'}
{$HPPEMIT '#pragma link "d3d10_1.lib"'}
{$HPPEMIT '#pragma link "dxgi.lib"'}
{$ENDIF}
(*$HPPEMIT '#if defined(WIN32) && defined(CreateWindow)'*)
(*$HPPEMIT '  #define __SAVE_CREATEWINDOW CreateWindow'*)
(*$HPPEMIT '  #undef  CreateWindow'*)
(*$HPPEMIT '#endif'*)

(*$HPPEMIT END '#if defined(__SAVE_CREATEWINDOW)'*)
(*$HPPEMIT END '  #define CreateWindow __SAVE_CREATEWINDOW'*)
(*$HPPEMIT END '  #undef  __SAVE_CREATEWINDOW'*)
(*$HPPEMIT END '#endif'*)

interface

uses
  System.TypInfo, System.Math, System.Classes, System.SysUtils, System.Types,
  System.UITypes, FMX.Types, FMX.Types3D, System.Generics.Collections,
  FMX.ActnList, FMX.Messages, FMX.Styles, FMX.Controls, FMX.TextLayout
{$IFDEF MSWINDOWS}
  , Winapi.Messages
{$ENDIF}
  ;

{$SCOPEDENUMS ON}

/// <summary>
/// This value indicates that the auto-update action will not be performed.
/// </summary>
const ActionUpdateDelayNever: Integer = -1;

type

  TCommonCustomForm = class;

  { Application }

  TExceptionEvent = procedure(Sender: TObject; E: Exception) of object;
  TIdleEvent = procedure(Sender: TObject; var Done: Boolean) of object;

  TDeviceKind = (dkDesktop, dkiPhone, dkiPad);
  TDeviceKinds = set of TDeviceKind;

  TFormOrientations = TScreenOrientations;
  TFormOrientation = TScreenOrientation;

  TFormFactor = class(TPersistent)
  private
    FSize: TSize;
    FOrientations: TFormOrientations;
    FDevices: TDeviceKinds;
    procedure SetSupportedOrientations(AOrientations: TFormOrientations);
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    function GetWidth: Integer;
    function GetHeight: Integer;
  public
    constructor Create;
    procedure AdjustToScreenSize;
  published
    property Width: Integer read GetWidth write SetWidth stored True;
    property Height: Integer read GetHeight write SetHeight stored True;
    property Orientations: TFormOrientations read FOrientations write SetSupportedOrientations stored True default [TFormOrientation.soPortrait, TFormOrientation.soLandscape];
    property Devices: TDeviceKinds read FDevices write FDevices stored True;
  end;

  { IDesignerHook }

{$IFDEF MSWINDOWS}
  IDesignerHook = interface(IDesignerNotify)
  ['{65A688CA-60DD-4038-AAFF-8F56A8B6AB69}']
    function IsDesignMsg(Sender: TFmxObject; var Message: TMessage): Boolean;
    procedure UpdateBorder;
    procedure PaintGrid;
    procedure DrawSelectionMarks(AControl: TFMXObject);
    function IsSelected(Instance: TPersistent): Boolean;
    function IsMobile: Boolean;
    procedure DesignerModified(Activate: Boolean = False);
    procedure ValidateRename(AComponent: TComponent; const CurName, NewName: string);
    function UniqueName(const BaseName: string): string;
    function GetRoot: TComponent;
    procedure FormFamilyChanged(const OldFormFamilyName, NewFormFamilyName, FormClassName: string);
    procedure SelectComponent(Instance: TPersistent);
    function SupportsPlatformService(const AServiceGUID: TGUID; out AService: IInterface): Boolean;
  end;
  IDesignerStorage = interface
  ['{ACCC9241-07E2-421B-8F4C-B70D1E4050AE}']
    function GetDesignerMobile: Boolean;
    procedure SetDesignerMobile(const Value: Boolean);
    function GetDesignerWidth: Integer;
    procedure SetDesignerWidth(const Value: Integer);
    function GetDesignerHeight: Integer;
    procedure SetDesignerHeight(const Value: Integer);
    function GetDesignerDeviceName: string;
    procedure SetDesignerDeviceName(const Value: string);
    function GetDesignerOrientation: TFormOrientation;
    procedure SetDesignerOrientation(const Value: TFormOrientation);
    property Mobile: Boolean read GetDesignerMobile write SetDesignerMobile;
    property Width: Integer read GetDesignerWidth write SetDesignerWidth;
    property Height: Integer read GetDesignerHeight write SetDesignerHeight;
    property DeviceName: string read GetDesignerDeviceName write SetDesignerDeviceName;
    property Orientation: TFormOrientation read GetDesignerOrientation write SetDesignerOrientation;
  end;
{$ELSE}
  IDesignerHook = interface
  end;
  IDesignerStorage = interface
  end;
{$ENDIF}

  { TApplication }

  TApplication = class(TComponent)
  private type
    TFormRegistryItem = class
    public
      InstanceClass: TComponentClass;
      Instance: TComponent;
      Reference: Pointer;
    end;
    TFormRegistryItems = TList<TFormRegistryItem>;
    TFormRegistry = TDictionary<String,TFormRegistryItems>;

  private
    FOnException: TExceptionEvent;
    FRunning: Boolean;
    FTerminate: Boolean;
    FOnIdle: TIdleEvent;
    FTitle: string;
    FMainForm: TCommonCustomForm;
    FCreateForms: array of TFormRegistryItem;
    FBiDiMode: TBiDiMode;
    FTimerActionHandle: TFmxHandle;
    FActionUpdateDelay: Integer;
    FTimerActionInterval: Integer;
    FActionClientsList: TList<TFmxObject>;
    FOnActionUpdate: TActionEvent;
    FIdleDone: Boolean;
    FRealCreateFormsCalled: Boolean;
    FFormFactor: TFormFactor;
    FFormRegistry: TFormRegistry;
    FMainFormFamily: string;
    FDefaultTitle: string;
    FLastKeyPress: TDateTime;
    FLastUserActive: TDateTime;
    FIdleMessage: TIdleMessage;
    procedure Idle;
    procedure SetupActionTimer;
    procedure SetActionUpdateDelay(const Value: integer);
    procedure DoUpdateActions;
    procedure UpdateActionTimerProc;
    function GetFormRegistryItem(const FormFamily: string; const FormFactor : TFormFactor): TFormRegistryItem;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure FormDestroyed(const AForm: TCommonCustomForm);
    procedure RealCreateForms;
    procedure CreateForm(const InstanceClass: TComponentClass; var Reference);
    procedure CreateMainForm;
    procedure RegisterFormFamily(const AFormFamily: string;
                                 const AForms: array of TComponentClass);
    procedure ProcessMessages;
    property LastKeyPress: TDateTime read FLastKeyPress;
    property LastUserActive: TDateTime read FLastUserActive;
    procedure DoIdle(var Done: Boolean);
    function HandleMessage: Boolean;
    procedure Run;
    procedure Terminate;
    procedure Initialize;
    procedure HandleException(Sender: TObject);
    procedure ShowException(E: Exception);
    property BiDiMode: TBiDiMode read FBiDiMode write FBiDiMode default bdLeftToRight;
    property Terminated: Boolean read FTerminate write FTerminate;
    /// <summary>
    /// This event is executed after processing all the events (mouse, keyboard, timers).
    /// </summary>
    /// <param name="Sender">
    /// Usually Application.
    /// </param>
    /// <param name="Done">
    /// This option indicates that you need to perform some standard operations
    /// (eg updating of all Actions), that run in Idle and methods OnIdle. For example:
    /// you can control what the user has stopped its activities and assign a value to <c>False</c>,
    /// in order to reduce the load on the processor when the user is asleep.
    /// </param>
    property OnIdle: TIdleEvent read FOnIdle write FOnIdle;
    property MainForm: TCommonCustomForm read FMainForm write FMainform;
    property Title: string read FTitle write FTitle; // deprecated
    property DefaultTitle: string read FDefaultTitle;
    property OnException: TExceptionEvent read FOnException write FOnException;

    function UpdateAction(Action: TBasicAction): Boolean; override;
    /// <summary>
    /// Delay until updating of all Actions. DoIdle method runs the timer
    /// that activates update of all Actions after the specified timeinterval (ActionUpdateDelay)
    /// <para>If <c>ActionUpdateDelay = 0</c>, then DoIdle activates update immediately. </para>
    /// <para>If <c>ActionUpdateDelay &lt; 0</c>, then DoIdle does not activate update. See also <see cref="ActionUpdateDelayNever"/></para>
    /// </summary>
    /// <remarks>
    /// This is performed only if the parameter <c>Done = True</c>. See <see cref="OnIdle"/>
    /// </remarks>
    property ActionUpdateDelay: Integer read FActionUpdateDelay write SetActionUpdateDelay;
    property OnActionUpdate: TActionEvent read FOnActionUpdate write FOnActionUpdate;
    procedure RegisterActionClient(const ActionClient: TFmxObject);
    procedure UnregisterActionClient(const ActionClient: TFmxObject);
    function GetActionClients: TEnumerable<TFmxObject>;
    function GetDeviceForm(const FormFamily: string; const FormFactor : TFormFactor): TCommonCustomForm; overload;
    function GetDeviceForm(const FormFamily: string): TCommonCustomForm; overload;
    procedure OverrideScreenSize(W, H: Integer);
    property FormFactor: TFormFactor read FFormFactor;
  end;


  /// <summary>
  ///   This class is intended for communication action with the Forms.
  /// </summary>
  TFormActionLink = class(FMX.ActnList.TActionLink)
  private
    FForm: TCommonCustomForm;
    function ActionCustomViewComponent: boolean;
  protected
    property Form: TCommonCustomForm read FForm;
    procedure AssignClient(AClient: TObject); override;
    function IsCaptionLinked: Boolean; override;
    function IsCheckedLinked: Boolean; override;
    function IsEnabledLinked: Boolean; override;
    function IsGroupIndexLinked: Boolean; override;
    function IsHelpLinked: Boolean;  override;
    function IsHintLinked: Boolean; override;
    function IsVisibleLinked: Boolean; override;
    function IsOnExecuteLinked: Boolean; override;
    procedure SetCaption(const Value: string); override;
    procedure SetVisible(Value: Boolean); override;
  end;

  { Forms }

  TCloseEvent = procedure(Sender: TObject; var Action: TCloseAction) of object;
  TCloseQueryEvent = procedure(Sender: TObject; var CanClose: Boolean) of object;

  TFmxFormBorderStyle = (bsNone, bsSingle, bsSizeable, bsToolWindow, bsSizeToolWin);

  TFmxFormState = (fsRecreating, fsModal);
  TFmxFormStates = set of TFmxFormState;

  TFormPosition = (poDesigned, poDefault, poDefaultPosOnly, poDefaultSizeOnly,
    poScreenCenter, poDesktopCenter, poMainFormCenter, poOwnerFormCenter);

  IFMXWindowService = interface(IInterface)
    ['{26C42398-9AFC-4D09-9541-9C71E769FC35}']
    function FindForm(const AHandle: TWindowHandle): TCommonCustomForm;
    function CreateWindow(const AForm: TCommonCustomForm): TWindowHandle;
    procedure DestroyWindow(const AForm: TCommonCustomForm);
    procedure ReleaseWindow(const AForm: TCommonCustomForm);
    procedure SetWindowState(const AForm: TCommonCustomForm; const AState: TWindowState);
    procedure ShowWindow(const AForm: TCommonCustomForm);
    procedure HideWindow(const AForm: TCommonCustomForm);
    function ShowWindowModal(const AForm: TCommonCustomForm): TModalResult;
    procedure InvalidateWindowRect(const AForm: TCommonCustomForm; R: TRectF);
    procedure InvalidateImmediately(const AForm: TCommonCustomForm);
    procedure SetWindowRect(const AForm: TCommonCustomForm; ARect: TRectF);
    function GetWindowRect(const AForm: TCommonCustomForm): TRectF;
    function GetClientSize(const AForm: TCommonCustomForm): TPointF;
    procedure SetClientSize(const AForm: TCommonCustomForm; const ASize: TPointF);
    procedure SetWindowCaption(const AForm: TCommonCustomForm; const ACaption: string);
    procedure SetCapture(const AForm: TCommonCustomForm);
    procedure ReleaseCapture(const AForm: TCommonCustomForm);
    function ClientToScreen(const AForm: TCommonCustomForm; const Point: TPointF): TPointF;
    function ScreenToClient(const AForm: TCommonCustomForm; const Point: TPointF): TPointF;
    procedure BringToFront(const AForm: TCommonCustomForm);
    procedure SendToBack(const AForm: TCommonCustomForm);
    procedure Activate(const AForm: TCommonCustomForm);
    function GetWindowScale(const AForm: TCommonCustomForm): Single;
    procedure SetFullScreen(const AForm: TCommonCustomForm; const AValue: Boolean);
    function GetFullScreen(const AForm: TCommonCustomForm): Boolean;
    procedure SetShowFullScreenIcon(const AForm: TCommonCustomForm; const AValue: Boolean);
  end;

  TWindowBorder = class(TFmxObject)
  private
    [weak]FForm: TCommonCustomForm;
  protected
    function GetSupported: Boolean; virtual; abstract;
    procedure Resize; virtual; abstract;
    procedure Activate; virtual; abstract;
    procedure Deactivate; virtual; abstract;
    procedure StyleChanged; virtual; abstract;
    procedure ScaleChanged; virtual; abstract;
  public
    constructor Create(const AForm: TCommonCustomForm); reintroduce; virtual;
    property Form: TCommonCustomForm read FForm;
    property IsSupported: Boolean read GetSupported;
  end;

  IFMXWindowBorderService = interface(IInterface)
  ['{F3FC3133-CEF0-446F-B3C6-7820989DDFC6}']
    function CreateWindowBorder(const AForm: TCommonCustomForm): TWindowBorder;
  end;

  TFormBorder = class(TPersistent)
  private
    FWindowBorder: TWindowBorder;
    [weak]FForm: TCommonCustomForm;
    FStyling: Boolean;
    procedure SetStyling(const Value: Boolean);
  protected
    function GetSupported: Boolean;
    procedure Recreate;
  public
    constructor Create(const AForm: TCommonCustomForm);
    destructor Destroy; override;
    procedure StyleChanged;
    procedure ScaleChanged;
    procedure Resize;
    procedure Activate;
    procedure Deactivate;
    property WindowBorder: TWindowBorder read FWindowBorder;
    property IsSupported: Boolean read GetSupported;
  published
    property Styling: Boolean read FStyling write SetStyling default True;
  end;

  TVKStateChangeMessage = class(FMX.Messages.TMessage)
  private
    FKeyboardShown: Boolean;
    FBounds: TRect;
  public
    constructor Create(AKeyboardShown: Boolean; const Bounds: TRect);
    property KeyboardVisible: Boolean read FKeyboardShown;
    property KeyboardBounds: TRect read FBounds;
  end;

  TScaleChangedMessage = class(FMX.Messages.TMessage)
  private
    FForm: TCommonCustomForm;
  public
    constructor Create(const AForm: TCommonCustomForm);
    property Form: TCommonCustomForm read FForm;
  end;

{ TCommonCustomForm }

  TWindowStyle = (wsGPUSurface);
  TWindowStyles = set of TWindowStyle;

  TCommonCustomForm = class(TFmxObject, IRoot, IContainerObject, IAlignRoot,
    IPaintControl, IStyleBookOwner, IDesignerStorage, IOriginalContainerSize)
  private class var
  private
    FDesigner: IDesignerHook;
    FCaption: string;
    FLeft: Integer;
    FTop: Integer;
    FTransparency: Boolean;
    FHandle: TWindowHandle;
    FContextHandle: THandle;
    FBorderStyle: TFmxFormBorderStyle;
    FBorderIcons: TBorderIcons;
    FVisible: Boolean;
    FTopMost: Boolean;
    FShowActivated: Boolean;
    FModalResult: TModalResult;
    FFormState: TFmxFormStates;
    FStaysOpen: Boolean;
    FBiDiMode: TBiDiMode;
    FActive: Boolean;
    FTarget: IControl;
    FHovered, FCaptured, FFocused: IControl;
    FMousePos, FDownPos, FResizeSize, FDownSize: TPointF;
    FDragging, FResizing: Boolean;
    FHeight: Integer;
    FWidth: Integer;
    FCursor: TCursor;
    FPosition: TFormPosition;
    FWindowState: TWindowState;
    FShowFullScreenIcon : Boolean;
    FFullScreen : Boolean;
    FPadding: TBounds;
    FFormFactor : TFormFactor;
    FFormFamily : string;
    FOldActiveForm: TCommonCustomForm;
    FParentNote: boolean;
    FBorder: TFormBorder;
    FStateChangeMessageId: Integer;
    FOnClose: TCloseEvent;
    FOnCloseQuery: TCloseQueryEvent;
    FOnActivate: TNotifyEvent;
    FOnDeactivate: TNotifyEvent;
    FOnCreate: TNotifyEvent;
    FOnDestroy: TNotifyEvent;
    FOnResize: TNotifyEvent;
    FOnMouseDown: TMouseEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseEvent;
    FOnMouseWheel: TMouseWheelEvent;
    FOnKeyDown: TKeyEvent;
    FOnKeyUp: TKeyEvent;
    FOnShow: TNotifyEvent;
    FOnHide: TNotifyEvent;
    FOnFocusChanged: TNotifyEvent;
    FOnVirtualKeyboardShown: TVirtualKeyboardEvent;
    FOnVirtualKeyboardHidden: TVirtualKeyboardEvent;
    FActivation: boolean;
    FStyleBook: TStyleBook;
    FScaleChangedId: Integer;
    FStyleChangedId: Integer;
    FStyleBookChanged: Boolean;
    FPreloadedBorderStyling: Boolean;
    FOriginalContainerSize: TPointF;
    {$IFDEF MSWINDOWS}
    FDesignerMobile: Boolean;
    FDesignerWidth: Integer;
    FDesignerHeight: Integer;
    FDesignerDeviceName: string;
    FDesignerOrientation: TFormOrientation;
    function GetDesignerMobile: Boolean;
    procedure SetDesignerMobile(const Value: Boolean);
    function GetDesignerWidth: Integer;
    procedure SetDesignerWidth(const Value: Integer);
    function GetDesignerHeight: Integer;
    procedure SetDesignerHeight(const Value: Integer);
    function GetDesignerDeviceName: string;
    procedure SetDesignerDeviceName(const Value: string);
    function GetDesignerOrientation: TFormOrientation;
    procedure SetDesignerOrientation(const Value: TFormOrientation);
    {$ENDIF}
    procedure ReadDesignerMobile(Reader: TReader);
    procedure WriteDesignerMobile(Writer: TWriter);
    procedure ReadDesignerWidth(Reader: TReader);
    procedure WriteDesignerWidth(Writer: TWriter);
    procedure ReadDesignerHeight(Reader: TReader);
    procedure WriteDesignerHeight(Writer: TWriter);
    procedure ReadDesignerDeviceName(Reader: TReader);
    procedure WriteDesignerDeviceName(Writer: TWriter);
    procedure ReadDesignerOrientation(Reader: TReader);
    procedure WriteDesignerOrientation(Writer: TWriter);
    procedure SetDesigner(const ADesigner: IDesignerHook);
    procedure SetLeft(const Value: Integer);
    procedure SetTop(const Value: Integer);
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    procedure SetCaption(const Value: string);
    function GetClientHeight: Integer;
    function GetClientWidth: Integer;
    procedure SetBorderStyle(const Value: TFmxFormBorderStyle);
    procedure SetBorderIcons(const Value: TBorderIcons);
    procedure SetVisible(const Value: Boolean);
    procedure SetTopMost(const Value: Boolean);
    procedure SetClientHeight(const Value: Integer);
    procedure SetClientWidth(const Value: Integer);
    procedure SetBiDiMode(const Value: TBiDiMode);
    procedure SetCursor(const Value: TCursor);
    procedure SetPosition(const Value: TFormPosition);
    procedure SetWindowState(const Value: TWindowState);
    function GetLeft: Integer;
    function GetTop: Integer;
    procedure PaddingChanged(Sender: TObject);
    procedure ShowCaret(const Control: IControl);
    procedure HideCaret(const Control: IControl);
    procedure AdvanceTabFocus(const MoveForward: Boolean);
    procedure ScaleChangedHandler(const Sender: TObject; const Msg: FMX.Messages.TMessage);
    procedure StyleChangedHandler(const Sender: TObject; const Msg: FMX.Messages.TMessage);
    function GetFullScreen: Boolean;
    procedure SetFullScreen(const AValue: Boolean);
    function GetShowFullScreenIcon: Boolean;
    procedure SetShowFullScreenIcon(const AValue: Boolean);
    procedure PreloadProperties;
    procedure SetPadding(const Value: TBounds);
    function GetOriginalContainerSize: TPointF;
    procedure SetBorder(const Value: TFormBorder);
  protected
    FActiveControl: IControl;
    FUpdating: Integer;
    FLastWidth, FLastHeight: single;
    FDisableAlign: Boolean;
    FWinService: IFMXWindowService;
    FCursorService: IFMXCursorService;
    function GetBackIndex: Integer; override;
    procedure InvalidateRect(R: TRectF);
    procedure Recreate; virtual;
    procedure Resize; virtual;
    procedure SetActive(const Value: Boolean); virtual;
    procedure DefineProperties(Filer: TFiler); override;
    function FindTarget(P: TPointF; const Data: TDragObject): IControl; virtual;
    procedure SetFormFamily(const Value: string);
    procedure UpdateStyleBook; virtual;
    procedure SetStyleBookWithoutUpdate(const StyleBook: TStyleBook);
    { IInterface }
    function QueryInterface(const IID: TGUID; out Obj): HResult; override;
    { IAlignRoot }
    procedure Realign; virtual;
    procedure ChildrenAlignChanged;
    { Preload }
    procedure AddPreloadProperyNames(const PropertyNames: TList<string>); virtual;
    procedure SetPreloadProperies(const PropertyStore: TDictionary<string, Variant>); virtual;
    { Handle }
    procedure CreateHandle; virtual;
    procedure DestroyHandle; virtual;
    procedure ResizeHandle; virtual;
    { IRoot }
    function GetObject: TFmxObject;
    function GetActiveControl: IControl;
    procedure SetActiveControl(const AControl: IControl);
    procedure SetCaptured(const Value: IControl);
    function NewFocusedControl(const Value: IControl): IControl;
    procedure SetFocused(const Value: IControl);
    procedure SetHovered(const Value: IControl);
    procedure SetTransparency(const Value: Boolean); virtual;
    function GetCaptured: IControl;
    function GetFocused: IControl;
    function GetBiDiMode: TBiDiMode;
    function GetHovered: IControl;
    procedure BeginInternalDrag(const Source: TObject; const ABitmap: TBitmap);
    { IStyleBookOwner }
    function GetStyleBook: TStyleBook;
    procedure SetStyleBook(const Value: TStyleBook);
    { IPaintControl }
    procedure PaintRects(const UpdateRects: array of TRectF); virtual;
    function GetContextHandle: THandle;
    procedure SetContextHandle(const AContextHandle: THandle);
    property ContextHandle: THandle read FContextHandle;
    { Border }
    function CreateBorder: TFormBorder; virtual;
    { TFmxObject }
    procedure Loaded; override;
    procedure FreeNotification(AObject: TObject); override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    { TComponent }
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ValidateRename(AComponent: TComponent; const CurName, NewName: string); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    { IContainerObject }
    function GetContainerWidth: Single;
    function GetContainerHeight: Single;
    /// <summary>
    ///   The function performs a sequential update of all controls with actions in the form
    /// </summary>
    procedure UpdateActions; virtual;
    function GetActionLinkClass: TActionLinkClass; override;
    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); override;
    function CaptionStore: boolean;
    procedure VirtualKeyboardChangeHandler(const Sender: TObject; const Msg: FMX.Messages.TMessage); virtual;
    procedure IsDialogKey(const Key: Word;
                          const KeyChar: WideChar;
                          const Shift: TShiftState;
                            var IsDialog: boolean); virtual;
    procedure AddToTabList(const AObject: TFmxObject); override;
    { Events }
    procedure DoShow; virtual;
    procedure DoHide; virtual;
    procedure DoClose(var CloseAction: TCloseAction); virtual;
    procedure DoScaleChanged; virtual;
    procedure DoStyleChanged; virtual;
    procedure DoMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); virtual;
    procedure DoMouseMove(Shift: TShiftState; X, Y: Single); virtual;
    procedure DoMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); virtual;
    procedure DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); virtual;
    procedure DoFocusChanged; virtual;
    { Window style }
    function GetWindowStyle: TWindowStyles; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); virtual;
    destructor Destroy; override;
    procedure InitializeNewForm; virtual;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    { children }
    function ObjectAtPoint(P: TPointF): IControl; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); virtual;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); virtual;
    procedure MouseLeave; virtual;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); virtual;
    procedure KeyUp(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); virtual;
    procedure MouseCapture;
    procedure ReleaseCapture;
//    function GetImeWindowRect: TRectF; virtual;
    procedure Activate;
    procedure Deactivate;
    procedure DragEnter(const Data: TDragObject; const Point: TPointF); virtual;
    procedure DragOver(const Data: TDragObject; const Point: TPointF; var Accept: Boolean); virtual;
    procedure DragDrop(const Data: TDragObject; const Point: TPointF); virtual;
    procedure DragLeave; virtual;
    procedure EnterMenuLoop;
    { manully start }
    procedure StartWindowDrag; virtual;
    procedure StartWindowResize; virtual;
    { settings }
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); virtual;
    function ClientToScreen(const Point: TPointF): TPointF;
    function ScreenToClient(const Point: TPointF): TPointF;
    function CloseQuery: Boolean; virtual;
    function ClientRect: TRectF;
    procedure Release; override;
    procedure Close;
    procedure Show;
    procedure Hide;
    procedure BringToFront; override;
    procedure SendToBack; override;
    function ShowModal: TModalResult;
    procedure CloseModal;
    procedure Invalidate;
    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;
    property Handle: TWindowHandle read FHandle;
    property ModalResult: TModalResult read FModalResult write FModalResult;
    property FormState: TFmxFormStates read FFormState;
    property Designer: IDesignerHook read FDesigner write SetDesigner;
    property Captured: IControl read FCaptured;
    property Focused: IControl read FFocused write SetFocused;
    property Hovered: IControl read FHovered;
    property Active: Boolean read FActive write SetActive;
    property BiDiMode: TBiDiMode read GetBiDiMode write SetBiDiMode default bdLeftToRight;
    property Caption: string read FCaption write SetCaption stored CaptionStore;
    property Cursor: TCursor read FCursor write SetCursor default crDefault;
    property Border: TFormBorder read FBorder write SetBorder;
    property BorderStyle: TFmxFormBorderStyle read FBorderStyle write SetBorderStyle
      default TFmxFormBorderStyle.bsSizeable;
    property BorderIcons: TBorderIcons read FBorderIcons write SetBorderIcons
      default [TBorderIcon.biSystemMenu, TBorderIcon.biMinimize, TBorderIcon.biMaximize];
    property ClientHeight: Integer read GetClientHeight write SetClientHeight;
    property ClientWidth: Integer read GetClientWidth write SetClientWidth;
    property OriginalContainerSize: TPointF read GetOriginalContainerSize;
    property Padding: TBounds read FPadding write SetPadding;
    property Position: TFormPosition read FPosition write SetPosition default TFormPosition.poDefaultPosOnly;
    property StyleBook: TStyleBook read FStyleBook write SetStyleBook;
    property Transparency: Boolean read FTransparency write SetTransparency default False;
    property Width: Integer read FWidth write SetWidth stored False;
    property Height: Integer read FHeight write SetHeight stored False;
    property ShowActivated: Boolean read FShowActivated write FShowActivated default True;
    property StaysOpen: Boolean read FStaysOpen write FStaysOpen default True;
    property TopMost: Boolean read FTopMost write SetTopMost default False;
    property Visible: Boolean read FVisible write SetVisible default False;
    property WindowState: TWindowState read FWindowState write SetWindowState default TWindowState.wsNormal;
    property WindowStyle: TWindowStyles read GetWindowStyle;
    property FullScreen : Boolean read GetFullScreen write SetFullScreen default False;
    property ShowFullScreenIcon : Boolean read GetShowFullScreenIcon write SetShowFullScreenIcon default True;
    property FormFactor: TFormFactor read FFormFactor write FFormFactor;
    property FormFamily : string read FFormFamily write SetFormFamily;
    property OnCreate: TNotifyEvent read FOnCreate write FOnCreate;
    property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
    property OnClose: TCloseEvent read FOnClose write FOnClose;
    property OnCloseQuery: TCloseQueryEvent read FOnCloseQuery write FOnCloseQuery;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property OnKeyDown: TKeyEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyUp: TKeyEvent read FOnKeyUp write FOnKeyUp;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnMouseWheel: TMouseWheelEvent read FOnMouseWheel write FOnMouseWheel;
    property OnResize: TNotifyEvent read FOnResize write FOnResize;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;
    property OnFocusChanged: TNotifyEvent read FOnFocusChanged write FOnFocusChanged;
    property OnVirtualKeyboardShown: TVirtualKeyboardEvent read FOnVirtualKeyboardShown write FOnVirtualKeyboardShown;
    property OnVirtualKeyboardHidden: TVirtualKeyboardEvent read FOnVirtualKeyboardHidden write FOnVirtualKeyboardHidden;
  published
    // do not move this
    property Left: Integer read GetLeft write SetLeft;
    property Top: Integer read GetTop write SetTop;
  end;

  { TCustomForm }

  TCustomForm = class(TCommonCustomForm, IScene)
  private
    FCanvas: TCanvas;
    FTempCanvas: TCanvas;
    FFill: TBrush;
    FDrawing: Boolean;
    FUpdateRects: array of TRectF;
    FStyleLookup: string;
    FNeedStyleLookup: Boolean;
    FResourceLink: TControl;
    FOnPaint: TOnPaintEvent;
    FControls: TControlList;
    FQuality: TCanvasQuality;
    FScrollControl: TControl;
    procedure SetFill(const Value: TBrush);
    procedure FillChanged(Sender: TObject);
    { IScene }
    function GetCanvas: TCanvas;
    function GetUpdateRectsCount: Integer;
    function GetUpdateRect(const Index: Integer): TRectF;
    function GetSceneScale: Single;
    function LocalToScreen(P: TPointF): TPointF;
    function ScreenToLocal(P: TPointF): TPointF;
    procedure SetStyleLookup(const Value: string);
    procedure AddUpdateRect(R: TRectF);
    procedure ChangeScrollingState(const AControl: TControl; const Active: Boolean);
    function IsStyleLookupStored: Boolean;
    function GetActiveHDControl: TControl;
    procedure SetActiveHDControl(const Value: TControl);
    procedure SetQuality(const Value: TCanvasQuality);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    procedure DoDeleteChildren; override;
    procedure ChangeChildren; override;
    procedure UpdateStyleBook; override;
    { TForm }
    procedure ApplyStyleLookup; virtual;
    { Preload }
    procedure AddPreloadProperyNames(const PropertyNames: TList<string>); override;
    procedure SetPreloadProperies(const PropertyStore: TDictionary<string, Variant>); override;
    { }
    procedure DoPaint(const Canvas: TCanvas; const ARect: TRectF); virtual;
    { resources }
    function GetStyleObject: TControl;
    { Handle }
    procedure CreateHandle; override;
    procedure DestroyHandle; override;
    procedure ResizeHandle; override;
    procedure PaintRects(const UpdateRects: array of TRectF); override;
    procedure RecreateCanvas;
    { inherited }
    procedure Realign; override;
    procedure DoScaleChanged; override;
    procedure DoStyleChanged; override;
    { Window style }
    function GetWindowStyle: TWindowStyles; override;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    destructor Destroy; override;
    procedure InitializeNewForm; override;
    procedure EndUpdate; override;
    procedure PaintTo(const Canvas: TCanvas);
    property Action;
    property Canvas: TCanvas read GetCanvas;
    property Fill: TBrush read FFill write SetFill;
    property Quality: TCanvasQuality read FQuality write SetQuality;
    property ActiveControl: TControl read GetActiveHDControl write SetActiveHDControl;
    property StyleLookup: string read FStyleLookup write SetStyleLookup stored IsStyleLookupStored;
    property OnPaint: TOnPaintEvent read FOnPaint write FOnPaint;
  end;

  TForm = class(TCustomForm)
  published
    property Action;
    property ActiveControl;
    property BiDiMode;
    property Border;
    property BorderIcons default [TBorderIcon.biSystemMenu, TBorderIcon.biMinimize, TBorderIcon.biMaximize];
    property BorderStyle default TFmxFormBorderStyle.bsSizeable;
    property Caption;
    property ClientHeight;
    property ClientWidth;
    property Cursor default crDefault;
    property Fill;
    property Height;
    property Left;
    property Padding;
    property Position default TFormPosition.poDefaultPosOnly;
    property Quality default TCanvasQuality.ccSystemDefault;
    property StaysOpen default True;
    property ShowActivated default True;
    property StyleBook;
    property StyleLookup;
    property Transparency default False;
    property Top;
    property TopMost default False;
    property Visible;
    property WindowState default TWindowState.wsNormal;
    property Width;
    property FormFactor;
    property FormFamily;
    property FullScreen default False;
    property ShowFullScreenIcon default False;
    {events}
    property OnActivate;
    property OnCreate;
    property OnClose;
    property OnCloseQuery;
    property OnDeactivate;
    property OnDestroy;
    property OnKeyDown;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnResize;
    property OnPaint;
    property OnShow;
    property OnHide;
    property Touch;
    property OnGesture;
    property OnFocusChanged;
    property OnVirtualKeyboardShown;
    property OnVirtualKeyboardHidden;
  end;

  { TFrame }

  TFrame = class(TControl)
  private
  protected
    procedure Paint; override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  published
    property Action;
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

  { TScreen }

  TScreen = class(TComponent)
  private
    FManagingDataModules: Boolean;
    FForms: TList<TCommonCustomForm>;
    FDataModules: TList<TDataModule>;
    procedure AddDataModule(DataModule: TDataModule);
    procedure AddForm(const AForm: TCommonCustomForm);
    function GetForm(Index: Integer): TCommonCustomForm;
    function GetFormCount: Integer;
    procedure RemoveDataModule(DataModule: TDataModule);
    procedure RemoveForm(const AForm: TCommonCustomForm);
    function GetDataModule(Index: Integer): TDataModule;
    function GetDataModuleCount: Integer;
    function GetActiveForm: TCommonCustomForm;
    procedure SetActiveForm(const Value: TCommonCustomForm);
    function GetFocusControl: IControl;
    function GetFocusObject: TFmxObject;
  protected
    property FocusObject: TFmxObject read GetFocusObject;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IndexFormOfObject(Obj: TFmxObject; VisibleOnly: boolean = True): integer;
    function NextActiveForm(const OldActiveForm: TCommonCustomForm): TCommonCustomForm;
    function MousePos: TPointF;
    function Size: TSize;
    property FormCount: Integer read GetFormCount;
    property Forms[Index: Integer]: TCommonCustomForm read GetForm;
    property DataModuleCount: Integer read GetDataModuleCount;
    property DataModules[Index: Integer]: TDataModule read GetDataModule;
    property ActiveForm: TCommonCustomForm read GetActiveForm write SetActiveForm;
    property FocusControl: IControl read GetFocusControl;
    function GetObjectByTarget(const Target: TObject): TFmxObject;
  end;

type
  { IDesignerForm: Form implementing this is part of the designer }
  IDesignerForm = interface
    ['{5D785E12-F0A8-416B-AC6A-20747833CE5D}']
  end;

var
  Screen: TScreen;
  Application: TApplication;

type
  TApplicationState = (asNone, asRunning, asTerminating, asTerminated);

function ApplicationState: TApplicationState;

implementation

uses
  System.Variants,
  System.Generics.Defaults,
  System.RTLConsts,
  System.Rtti, System.Actions,
  FMX.Consts,
  FMX.Dialogs,
  FMX.Platform, FMX.Menus,
  FMX.TextLayout.GPU,
  FMX.Filter, FMX.Materials, FMX.Text;

type
  TOpenFmxObject = class(TFmxObject);
  TOpenControl = class(TControl);

function PropertyValuesFromStream(const ComponentName: string; const Properties: array of string; const Input: TStream): TArray<Variant>; forward;
function ReadResource(const FormClass: TClass; const PropertyNames: array of string; const PropertyStore : TDictionary<string, Variant>) : Boolean; forward;

procedure DoneApplication;
begin
  Application.DestroyComponents;
end;

function ApplicationState: TApplicationState;
var
  AppService: IFMXApplicationService;
begin
  Result := TApplicationState.asNone;
  if Assigned(Application) then
  begin
    if Application.Terminated then
      result := TApplicationState.asTerminated
    else
    begin
      if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationService, IInterface(AppService)) and
        (AppService.Terminating) then
        Result := TApplicationState.asTerminating
      else
      begin
        if Application.FRunning then
          Result := TApplicationState.asRunning;
      end;
    end;
  end;
end;

{ TApplication }

constructor TApplication.Create(AOwner: TComponent);
begin
  inherited;
  FIdleMessage := TIdleMessage.Create;
  FDefaultTitle := SAppDefault;
  FActionUpdateDelay := 100;
  FLastUserActive := Now;
  FFormRegistry := TDictionary<string,TFormRegistryItems>.Create;
  FFormFactor := TFormFactor.Create;
  FMainFormFamily := EmptyStr;
  if not Assigned(System.Classes.ApplicationHandleException) then
    System.Classes.ApplicationHandleException := HandleException;
  if not Assigned(System.Classes.ApplicationShowException) then
    System.Classes.ApplicationShowException := ShowException;
end;

procedure TApplication.CreateForm(const InstanceClass: TComponentClass; var Reference);
var
  Instance: TComponent;
  RegistryItems : TFormRegistryItems;
  RegItem : TFormRegistryItem;
begin
  if FRealCreateFormsCalled then
  begin
    Instance := TComponent(InstanceClass.NewInstance);
    TComponent(Reference) := Instance;
    try
      Instance.Create(Self);
      for RegItem in FCreateForms do
        if RegItem.InstanceClass = InstanceClass then
        begin
          RegItem.Instance := Instance;
          RegItem.Reference := @Reference;
        end;
    except
      TComponent(Reference) := nil;
      raise;
    end;
  end
  else
  begin
    SetLength(FCreateForms, Length(FCreateForms) + 1);
    FCreateForms[High(FCreateForms)] := TFormRegistryItem.Create;
    FCreateForms[High(FCreateForms)].InstanceClass := InstanceClass;
    FCreateForms[High(FCreateForms)].Reference := @Reference;

    // Add the form to form registry in case RegisterFormFamily will not be called
    if FFormRegistry.ContainsKey(EmptyStr) then
    begin
      RegistryItems := FFormRegistry[EmptyStr];
    end
    else begin
      RegistryItems := TFormRegistryItems.Create;
      FFormRegistry.Add(EmptyStr, RegistryItems);
    end;

    RegistryItems.Add(FCreateForms[High(FCreateForms)]);
  end;
end;

procedure TApplication.RealCreateForms;
var
  I: Integer;
  FormFamilyNotInUse: Boolean;
begin
  FFormFactor.AdjustToScreenSize;
  if not FRealCreateFormsCalled then
  begin
    FormFamilyNotInUse := FFormRegistry.Keys.Count = 1;
    FRealCreateFormsCalled := True;
    for I := 0 to High(FCreateForms) do
    begin
      if FormFamilyNotInUse or (FCreateForms[I].InstanceClass.InheritsFrom(TDataModule)) then
      begin
        CreateForm(FCreateForms[I].InstanceClass, FCreateForms[I].Reference^);
        FCreateForms[I].Instance := TComponent(FCreateForms[I].Reference^);
      end;
    end;
  end;
  if not Assigned(FMainForm) then
    CreateMainForm;
end;

procedure TApplication.RegisterFormFamily(const AFormFamily: string; const AForms: array of TComponentClass);
var
  FamilyList : TFormRegistryItems;
  RegItem : TFormRegistryItem;
  FormsList : TList<TComponentClass>;
begin
  FamilyList := TFormRegistryItems.Create;
  FormsList := TList<TComponentClass>.Create;
  FormsList.AddRange(AForms);

  for RegItem in FCreateForms do
    if FormsList.Contains(RegItem.InstanceClass) then
    begin
      FamilyList.Add(RegItem);
    end;

  FFormRegistry.Add(AFormFamily, FamilyList);

  if FMainFormFamily = EmptyStr then
    FMainFormFamily := AFormFamily;

  FormsList.Free;
end;

procedure TApplication.CreateMainForm;
var
  I: Integer;
begin
  if not Assigned(FMainForm) then
  begin
    if FFormRegistry.Keys.Count = 1 then
    begin
      for I := 0 to High(FCreateForms) do
        if (not FCreateForms[I].InstanceClass.InheritsFrom(TDataModule)) then
        begin
          FMainForm := TCommonCustomForm(FCreateForms[I].Reference^);
          break;
        end
    end
    else
      FMainForm := GetDeviceForm(FMainFormFamily);
  end;

  if Assigned(FMainForm) then
    FMainForm.Visible := True;
end;

destructor TApplication.Destroy;
type
  TExceptionEvent = procedure(E: Exception) of object;
var
  P: TNotifyEvent;
  E: TExceptionEvent;
  I: Integer;
  LFRList: TFormRegistryItems;
begin
  System.Classes.WakeMainThread := nil;
  P := HandleException;
  if @P = @System.Classes.ApplicationHandleException then
    System.Classes.ApplicationHandleException := nil;
  E := ShowException;
  if @E = @System.Classes.ApplicationShowException then
    System.Classes.ApplicationShowException := nil;
  if Assigned(FMainForm) then
    FMainForm.Free;
  for I := 0 to Length(FCreateForms)-1 do
    FreeAndNil(FCreateForms[I]);
  SetLength(FCreateForms, 0);
  if Assigned(FFormRegistry) then
  begin
    for LFRList in FFormRegistry.Values do
      LFRList.DisposeOf;
    FreeAndNil(FFormRegistry);
  end;
  if Assigned(FFormFactor) then
    FreeAndNil(FFormFactor);
  if Assigned(FActionClientsList) then
    FreeAndNil(FActionClientsList);
  FreeAndNil(FIdleMessage);
  inherited;
end;

procedure TApplication.FormDestroyed(const AForm: TCommonCustomForm);
var
  RegItem : TFormRegistryItem;
begin
  for RegItem in FCreateForms do
    if RegItem.Instance = AForm then
      RegItem.Instance := nil;

  if FMainForm = AForm then
    FMainForm := nil;
end;

function TApplication.GetDeviceForm(const FormFamily: string) : TCommonCustomForm;
begin
  Result := GetDeviceForm(FormFamily, FFormFactor);
end;

function TApplication.GetDeviceForm(const FormFamily: string; const FormFactor : TFormFactor): TCommonCustomForm;
var
  RegItem: TFormRegistryItem;
begin
  Result := nil;
  RegItem := GetFormRegistryItem(FormFamily, FormFactor);
  if RegItem <> nil then
  begin
    if RegItem.Instance = nil then
    begin
      try
        RegItem.Instance := TComponent(RegItem.InstanceClass.NewInstance);
        RegItem.Instance.Create(Self);
        TComponent(RegItem.Reference^) := RegItem.Instance;
        Result := TCommonCustomForm(RegItem.Instance);
      except
        RegItem.Instance := nil;
        raise;
      end;
    end
    else
      Result := TCommonCustomForm(RegItem.Instance);
  end;
end;

function TApplication.GetFormRegistryItem(const FormFamily: string; const FormFactor : TFormFactor): TFormRegistryItem;
  const
    PropertyNames : array [0..5] of String =
                      ('FormFactor.Width',
                       'FormFactor.Height',
                       'FormFactor.Devices',
                       'FormFactor.Aspect',
                       'FormFactor.Orientations',
                       'FormFamily');

  function DiffWeight(X1, X2 : Single) : Single;
  begin
    Result := Abs(X1 - X2);
    if Result <= 0.1 then
      Result := 1.0;
    Result := 1.0/Result;
  end;

  function CalcWeight(const F : TFormFactor) : Single;
  var
    W1, W2 : Single;
  begin
    W1 :=
      DiffWeight(F.Width, FormFactor.Width) *
      DiffWeight(F.Height, FormFactor.Height);
    W2 :=
      DiffWeight(F.Height, FormFactor.Width) *
      DiffWeight(F.Width, FormFactor.Height);

    Result := Max(W1, W2);
  end;

  // For comparison with the current device family
  function IsCompatible(const F : TFormFactor) : Boolean;
  begin
    Result := FormFactor.Devices * F.Devices <> [];
  end;

  function GetFormFactor(const FormClass : TClass; var FamilyName : String; const FormFactor : TFormFactor) : Boolean;
  var
    PropertyStore : TDictionary<String,Variant>;
    TI : PTypeInfo;
    Val : Variant;
  begin
    PropertyStore := TDictionary<String,Variant>.Create;
    ReadResource(FormClass, PropertyNames, PropertyStore);

    PropertyStore.TryGetValue('FormFactor.Width', Val);
    if (Val <> Unassigned) and (Val <> Null) then
      FormFactor.Width := Val;

    PropertyStore.TryGetValue('FormFactor.Height', Val);
    if (Val <> Unassigned) and (Val <> Null) then
      FormFactor.Height := Val;

    TI := TypeInfo(TDeviceKinds);
    PropertyStore.TryGetValue('FormFactor.Devices', Val);
    if (Val <> Unassigned) and (Val <> Null) then
      FormFactor.Devices := TDeviceKinds(Byte(StringToSet(TI, Val)));

    TI := TypeInfo(TFormOrientations);
    PropertyStore.TryGetValue('FormFactor.Orientations', Val);
    if (Val <> Unassigned) and (Val <> Null) then
      FormFactor.Orientations := TFormOrientations(Byte(StringToSet(TI, Val)));

    PropertyStore.TryGetValue('FormFamily', Val);
    if (Val <> Unassigned) and (Val <> Null) then
      FamilyName := Val;

    PropertyStore.Free;

    Result := True;
  end;


var
  Weight, MaxWeight : Single;
  LoadedFamilyName : String;
  LoadedFormFactor : TFormFactor;
  RegItem, BestForm : TFormRegistryItem;

begin
  Result := nil;
  BestForm := nil;
  MaxWeight := -1;

  if FFormRegistry.ContainsKey(FormFamily) then
  begin
    LoadedFormFactor := TFormFactor.Create;

    for RegItem in FFormRegistry[FormFamily] do
    begin
      GetFormFactor(RegItem.InstanceClass,
        LoadedFamilyName,
        LoadedFormFactor);

      if not (RegItem.Instance is TDataModule) and IsCompatible(LoadedFormFactor) then
      begin
        Weight := CalcWeight(LoadedFormFactor);
        if Weight > MaxWeight then
        begin
          MaxWeight := Weight;
          BestForm := RegItem;
        end;
      end;
    end;
    Result := BestForm;
    LoadedFormFactor.Free;
  end;
end;

function IsClass(const Obj: TObject; const Cls: TClass): Boolean;
var
  Parent: TClass;
begin
  if Assigned(Obj) and Assigned(Cls) then
  begin
  Parent := Obj.ClassType;
  while Assigned(Parent) and (Parent.ClassName <> Cls.ClassName) do
    Parent := Parent.ClassParent;
  Result := Assigned(Parent);
  end
  else
    Result := False;
end;

procedure TApplication.OverrideScreenSize(W, H: Integer);
begin
  FFormFactor.SetWidth(W);
  FFormFactor.SetHeight(H);
end;

procedure TApplication.HandleException(Sender: TObject);
var
  O: TObject;
  procedure DoShowException;
  begin
  if IsClass(O, Exception) then
  begin
      if (not IsClass(O, EAbort)) then
      if Assigned(FOnException) then
        FOnException(Sender, Exception(O))
      else
        ShowException(Exception(O));
    end
    else
    System.SysUtils.ShowException(O, ExceptAddr);
  end;
begin
  O := ExceptObject;
  if O = nil then
  begin
    try
      raise EArgumentNilException.Create(SNullException);
    except
      on E: Exception do
      begin
        O := ExceptObject;
        DoShowException;
      end;
    end;
  end
  else
    DoShowException;
end;

procedure TApplication.ShowException(E: Exception);
var
  Msg: string;
  SubE: Exception;
begin
  Msg := E.Message;
  while True do
  begin
    SubE := E.GetBaseException;
    if SubE <> E then
    begin
      E := SubE;
      if E.Message <> '' then
        Msg := E.Message;
    end
    else
      Break;
  end;
  if (Msg <> '') and (Msg.Chars[Msg.Length - 1] > '.') then Msg := Msg + '.';
  ShowMessage(Msg);
end;

function TApplication.HandleMessage: Boolean;
var
  AppService: IFMXApplicationService;
begin
  Result := False;
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationService, IInterface(AppService)) then
    Result := AppService.HandleMessage;
  if not Result then
    Idle;
end;

procedure TApplication.DoIdle(var Done: Boolean);
begin
  Done := True;
  try
    if Assigned(FOnIdle) then
      FOnIdle(Self, Done);
    FIdleDone := Done;
    if FIdleDone and (FActionUpdateDelay = 0) then
      UpdateActionTimerProc;
    TMessageManager.DefaultManager.SendMessage(Self, FIdleMessage, False);
    SetupActionTimer;
  except
    HandleException(Self);
  end;
end;

procedure TApplication.Idle;
var
  Done: Boolean;
  AppService: IFMXApplicationService;
begin
  DoIdle(Done);
  if (TThread.CurrentThread.ThreadID = MainThreadID) and CheckSynchronize then
    Done := False;

  if Done and
    TPlatformServices.Current.SupportsPlatformService(IFMXApplicationService, IInterface(AppService)) then
    AppService.WaitMessage;
end;

procedure TApplication.RegisterActionClient(const ActionClient: TFmxObject);
begin
  if not Assigned(FActionClientsList) then
    FActionClientsList := TList<TFmxObject>.Create;
  FActionClientsList.Add(ActionClient);
end;

procedure TApplication.UnregisterActionClient(const ActionClient: TFmxObject);
begin
  if Assigned(FActionClientsList) then
    FActionClientsList.Remove(ActionClient);
end;

function TApplication.GetActionClients: TEnumerable<TFmxObject>;
begin
  if not Assigned(FActionClientsList) then
    FActionClientsList := TList<TFmxObject>.Create;
  Result := FActionClientsList;
end;

function TApplication.UpdateAction(Action: TBasicAction): Boolean;
var Supp: boolean;
begin
  Result := False;
  if Assigned(Action) then
  begin
    if Action is TCustomAction then
      Supp := TCustomAction(Action).Supported
    else
      Supp := True;
    if Supp then
    begin
      if (Action is TContainedAction) and
         (TContainedAction(Action).DisableIfNoHandler) and
         (not Assigned(TContainedAction(Action).OnExecute)) then
        TContainedAction(Action).Enabled := False;
      if Assigned(FOnActionUpdate) then
        FOnActionUpdate(Action, Result);
    end;
  end;
end;

procedure TApplication.UpdateActionTimerProc;
begin
  if FIdleDone then
  try
    DoUpdateActions;
  finally
    FIdleDone := False;
  end;
end;

procedure TApplication.DoUpdateActions;
var
  I: integer;
begin
  for I := 0 to Screen.FormCount - 1 do
    if Screen.Forms[I].Active then
      Screen.Forms[I].UpdateActions;
  for I := 0 to Screen.FormCount - 1 do
    if not Screen.Forms[I].Active then
      Screen.Forms[I].UpdateActions;
end;

procedure TApplication.SetupActionTimer;
var
  TimerService: IFMXTimerService;

  procedure KillTimer;
  begin
    if FTimerActionHandle <> 0 then
    begin
      TimerService.DestroyTimer(FTimerActionHandle);
      FTimerActionHandle := 0;
      FTimerActionInterval := 0;
    end;
  end;

begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, IInterface(TimerService)) then
  begin
    if FIdleDone and (FActionUpdateDelay > 0) then
    begin
      if (FTimerActionHandle = 0) or
         (FTimerActionInterval <> FActionUpdateDelay) then
      begin
        KillTimer;
        try
          FTimerActionHandle := TimerService.CreateTimer(FActionUpdateDelay, UpdateActionTimerProc);
          FTimerActionInterval := FActionUpdateDelay;
        except
          FTimerActionHandle := 0;
          FTimerActionInterval := 0;
          raise;
        end;
      end;
    end
    else
      KillTimer;
  end;
end;

procedure TApplication.SetActionUpdateDelay(const Value: integer);
begin
  if FActionUpdateDelay <> Value then
  begin
    FActionUpdateDelay := Value;
    SetupActionTimer;
  end;
end;

type
  TOpenMainMenu = class (TMainMenu)
  end;

procedure TApplication.Run;
var
  AppService: IFMXApplicationService;
  TitleDef: boolean;
begin
  AddExitProc(DoneApplication);
  FRunning := True;
  try
    if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationService, IInterface(AppService)) then
    begin
      TitleDef := (Title <> '') and
                  (Title <> FDefaultTitle) and
                  (Title <> SAppDefault);
      FDefaultTitle := AppService.GetTitle;
      if not TitleDef then
        FTitle := FDefaultTitle;
      AppService.Run;
    end;
  finally
    FRunning := False;
  end;
end;

procedure TApplication.Terminate;
var
  AppService: IFMXApplicationService;
  TimerService: IFMXTimerService;
begin
  if (FTimerActionHandle <> 0) and
    (TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, IInterface(TimerService))) then
  begin
    TimerService.DestroyTimer(FTimerActionHandle);
    FTimerActionHandle := 0;
  end;
  // FTerminated is set to true in Platform.Terminate
  if CallTerminateProcs and
    TPlatformServices.Current.SupportsPlatformService(IFMXApplicationService, IInterface(AppService)) then
    AppService.Terminate;
end;

procedure TApplication.Initialize;
begin
  if Assigned(InitProc) then
    TProcedure(InitProc);
end;

procedure TApplication.ProcessMessages;
var
  AppService: IFMXApplicationService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationService, IInterface(AppService)) then
    while AppService.HandleMessage do { loop };
end;

{ TFormActionLink }

{type
  TOpenCustomViewAction = class (TCustomViewAction)
  end;}

procedure TFormActionLink.AssignClient(AClient: TObject);
begin
  if not Assigned(AClient) then
    raise EActionError.CreateFMT(SParamIsNil, ['AClient']);
  if (not (AClient is FMX.Forms.TCommonCustomForm)) then
    raise EActionError.CreateFmt(StrNoClientClass, [AClient.ClassName]);
  FForm := FMX.Forms.TCommonCustomForm(AClient);
end;

function TFormActionLink.ActionCustomViewComponent: boolean;
begin
  Result := False;
{  Result := (Action is TCustomViewAction) and
            (TOpenCustomViewAction(Action).Component = FForm);}
end;

function TFormActionLink.IsCaptionLinked: Boolean;
begin
  Result := Assigned(FForm) and
            (inherited IsCaptionLinked) and
            ((FForm.Caption = '') or (FForm.Caption = FForm.Name) or (FForm.Caption = TContainedAction(Action).Caption));
end;

function TFormActionLink.IsCheckedLinked: Boolean;
begin
  Result := False;
end;

function TFormActionLink.IsEnabledLinked: Boolean;
begin
  Result := False;
end;

function TFormActionLink.IsGroupIndexLinked: Boolean;
begin
  Result := False;
end;

function TFormActionLink.IsHelpLinked: Boolean;
begin
  Result := False;
end;

function TFormActionLink.IsHintLinked: Boolean;
begin
  Result := False;
end;

function TFormActionLink.IsOnExecuteLinked: Boolean;
begin
  Result := False;
end;

function TFormActionLink.IsVisibleLinked: Boolean;
begin
  if ActionCustomViewComponent then
  begin
    Result := False;
    Exit;
  end;
  Result := (inherited IsVisibleLinked) and
            (FForm.Visible = TContainedAction(Action).Visible);
end;

procedure TFormActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then FForm.Caption := Value;
end;

procedure TFormActionLink.SetVisible(Value: Boolean);
begin
  if IsVisibleLinked then FForm.Visible := Value;
end;

{ TScaleChangedMessage }

constructor TScaleChangedMessage.Create(const AForm: TCommonCustomForm);
begin
  inherited Create;
  FForm := AForm;
end;

{ TWindowBorder }

constructor TWindowBorder.Create(const AForm: TCommonCustomForm);
begin
  inherited Create(nil);
  FForm := AForm;
end;

{ TFormBorder }

constructor TFormBorder.Create(const AForm: TCommonCustomForm);
var
  BorderService: IFMXWindowBorderService;
begin
  inherited Create;
  FStyling := AForm.FPreloadedBorderStyling;
  FForm := AForm;
  if (FForm.BorderStyle <> TFmxFormBorderStyle.bsNone) and not (csDesigning in FForm.ComponentState) then
  begin
    if not (csDestroying in FForm.ComponentState) and TPlatformServices.Current.SupportsPlatformService(IFMXWindowBorderService, IInterface(BorderService)) then
      FWindowBorder := BorderService.CreateWindowBorder(FForm);
  end;
end;

destructor TFormBorder.Destroy;
begin
  FreeAndNil(FWindowBorder);
  inherited;
end;

function TFormBorder.GetSupported: Boolean;
begin
  Result := FStyling and Assigned(FWindowBorder) and FWindowBorder.IsSupported;
end;

procedure TFormBorder.Recreate;
begin
end;

procedure TFormBorder.Resize;
begin
  if IsSupported then
    FWindowBorder.Resize;
end;

procedure TFormBorder.Activate;
begin
  if IsSupported then
    FWindowBorder.Activate;
end;

procedure TFormBorder.Deactivate;
begin
  if IsSupported then
    FWindowBorder.Deactivate;
end;

procedure TFormBorder.ScaleChanged;
begin
  if IsSupported then
    FWindowBorder.ScaleChanged;
end;

procedure TFormBorder.SetStyling(const Value: Boolean);
begin
  if FStyling <> Value then
  begin
    FStyling := Value;
    StyleChanged;
  end;
end;

procedure TFormBorder.StyleChanged;
begin
  if IsSupported then
    FWindowBorder.StyleChanged;
end;

{ TCustomCommonForm }

constructor TCommonCustomForm.Create(AOwner: TComponent);
begin
  GlobalNameSpace.BeginWrite;
  try
    inherited;
    if not TPlatformServices.Current.SupportsPlatformService(IFMXWindowService, IInterface(FWinService)) then
      raise EUnsupportedPlatformService.Create('IFMXWindowService');
    TPlatformServices.Current.SupportsPlatformService(IFMXCursorService, IInterface(FCursorService));
    FOriginalContainerSize := TPointF.Create(-1,-1);
    PreloadProperties;
    InitializeNewForm;
    if (ClassType <> TCommonCustomForm) and not(csDesigning in ComponentState) then
    begin
      if not InitInheritedComponent(Self, TCommonCustomForm) then
        raise EResNotFound.CreateFMT(SResNotFound, [ClassName]);
    end;
  finally
    GlobalNameSpace.EndWrite;
  end;
  FStateChangeMessageId := TMessageManager.DefaultManager.SubscribeToMessage(TVKStateChangeMessage, VirtualKeyboardChangeHandler);
end;

function TCommonCustomForm.CreateBorder: TFormBorder;
begin
  Result := TFormBorder.Create(Self);
end;

constructor TCommonCustomForm.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited Create(AOwner);
  if not TPlatformServices.Current.SupportsPlatformService(IFMXWindowService, IInterface(FWinService)) then
    raise EUnsupportedPlatformService.Create('IFMXWindowService');
  TPlatformServices.Current.SupportsPlatformService(IFMXCursorService, IInterface(FCursorService));
  InitializeNewForm;
end;

procedure TCommonCustomForm.AddPreloadProperyNames(const PropertyNames: TList<string>);
begin
  PropertyNames.Add('Transparency');
  PropertyNames.Add('BorderStyle');
  PropertyNames.Add('EnableBorderStyling');
  PropertyNames.Add('Border.Styling');
end;

procedure TCommonCustomForm.SetPreloadProperies(const PropertyStore: TDictionary<string, Variant>);
var
  Val: Variant;
begin
  // Default
  FPreloadedBorderStyling := True;
  FTransparency := False;
  // Preload
  PropertyStore.TryGetValue('Transparency', Val);
  if (Val <> Unassigned) and (Val <> Null) then
    FTransparency := Val;

  PropertyStore.TryGetValue('BorderStyle', Val);
  if (Val <> Unassigned) and (Val <> Null) then
    FBorderStyle := TFmxFormBorderStyle(GetEnumValue(TypeInfo(TFmxFormBorderStyle), Val));

  PropertyStore.TryGetValue('EnableBorderStyling', Val);
  if (Val <> Unassigned) and (Val <> Null) then
    FPreloadedBorderStyling := Val;

  PropertyStore.TryGetValue('Border.Styling', Val);
  if (Val <> Unassigned) and (Val <> Null) then
    FPreloadedBorderStyling := Val;
end;

function TCommonCustomForm.GetOriginalContainerSize: TPointF;
begin
  Result := FOriginalContainerSize;
  if (Result.X < 0) or (Result.Y < 0)  then
    Result := TPointF.Create(GetContainerWidth, GetContainerHeight);
end;

procedure TCommonCustomForm.PreloadProperties;
var
  PropertyStore: TDictionary<string, Variant>;
  PropertyNames: TList<string>;
begin
  // Optimization - to remove recreation of handle on loading
  PropertyStore := TDictionary<string,Variant>.Create;
  PropertyNames := TList<string>.Create;

  AddPreloadProperyNames(PropertyNames);
  ReadResource(ClassType, PropertyNames.ToArray, PropertyStore);
  SetPreloadProperies(PropertyStore);

  PropertyNames.Free;
  PropertyStore.Free;
end;

procedure TCommonCustomForm.InitializeNewForm;
begin
  FUpdating := 0;
  FWidth := 640;
  FHeight := 480;
  FPadding := TBounds.Create(RectF(0, 0, 0, 0));
  FPadding.OnChange := PaddingChanged;
  FBorderIcons := [TBorderIcon.biSystemMenu, TBorderIcon.biMinimize, TBorderIcon.biMaximize];
  FBorderStyle := TFmxFormBorderStyle.bsSizeable;
  FShowActivated := True;
  FStaysOpen := True;
  FPosition := TFormPosition.poDefaultPosOnly;
  FFormFactor := TFormFactor.Create;
  FFormFamily := EmptyStr;
  FBorder := CreateBorder;
  CreateHandle;
  Screen.AddForm(Self);
  FScaleChangedId := TMessageManager.DefaultManager.SubscribeToMessage(TScaleChangedMessage, ScaleChangedHandler);
  FStyleChangedId := TMessageManager.DefaultManager.SubscribeToMessage(TStyleChangedMessage, StyleChangedHandler);
end;

destructor TCommonCustomForm.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TStyleChangedMessage, FStyleChangedId);
  TMessageManager.DefaultManager.Unsubscribe(TScaleChangedMessage, FScaleChangedId);
  if Assigned(Application) then
    Application.FormDestroyed(Self);
  if Assigned(FActiveControl) then
  begin
    FActiveControl.RemoveFreeNotify(Self);
    FActiveControl := nil;
  end;
  if Assigned(FTarget) then
  begin
    FTarget.RemoveFreeNotify(Self);
    FTarget := nil;
  end;
  if Assigned(FHovered) then
  begin
    FHovered.RemoveFreeNotify(Self);
    FHovered := nil;
  end;
  if Assigned(FFocused) then
  begin
    FFocused.RemoveFreeNotify(Self);
    FFocused := nil;
  end;
  if Assigned(FCaptured) then
  begin
    FCaptured.RemoveFreeNotify(Self);
    FCaptured := nil;
  end;
  if Assigned(FOldActiveForm) then
  begin
    FOldActiveForm.RemoveFreeNotify(Self);
    FOldActiveForm := nil;
  end;
  DestroyHandle;
  FreeAndNil(FBorder);
  FreeAndNil(FPadding);
  FreeAndNil(FFormFactor);
  if Assigned(Screen) then
    Screen.RemoveForm(Self);
  FCursorService := nil;
  FWinService := nil;
  TMessageManager.DefaultManager.Unsubscribe(TVKStateChangeMessage, FStateChangeMessageId);
  inherited;
end;

procedure TCommonCustomForm.CreateHandle;
begin
  FHandle := FWinService.CreateWindow(Self);
  if TFmxFormState.fsRecreating in FormState then
    FWinService.SetWindowRect(Self, RectF(Left, Top, Left + Width, Top + Height));
end;

procedure TCommonCustomForm.DestroyHandle;
begin
  if Assigned(FHandle) then
  begin
    FWinService.DestroyWindow(Self);
    FreeAndNil(FHandle);
  end;
end;

procedure TCommonCustomForm.AfterConstruction;
begin
  inherited;
  ResizeHandle;
  if Assigned(FOnCreate) then
    FOnCreate(Self);
  Resize;
end;

procedure TCommonCustomForm.BeforeDestruction;
begin
  if Assigned(FOnDestroy) then
    FOnDestroy(Self);
  inherited;
end;

procedure TCommonCustomForm.PaddingChanged(Sender: TObject);
begin
  Realign;
end;

procedure TCommonCustomForm.Realign;
begin
end;

procedure TCommonCustomForm.Recreate;
begin
  if (csDesigning in ComponentState) or (FUpdating > 0) then
    Exit;
  FFormState := FFormState + [TFmxFormState.fsRecreating];
  DestroyHandle;
  FBorder.Recreate;
  CreateHandle;
  Realign;
  if Visible then
    FWinService.ShowWindow(Self);
  FFormState := FFormState - [TFmxFormState.fsRecreating];
end;

procedure TCommonCustomForm.PaintRects(const UpdateRects: array of TRectF);
begin
end;

function TCommonCustomForm.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  // Route the QueryInterface through the Designer first
  if not Assigned(Designer) or (Designer.QueryInterface(IID, Obj) <> 0) then
    Result := inherited QueryInterface(IID, Obj)
  else
    Result := 0;
end;

function TCommonCustomForm.CloseQuery: Boolean;
begin
  Result := True;
  if Assigned(FOnCloseQuery) then
    FOnCloseQuery(Self, Result);
end;

procedure TCommonCustomForm.Close;
var
  CloseAction: TCloseAction;
  NeedActiveChange: boolean;
begin
  NeedActiveChange := not (TFmxFormState.fsModal in FFormState) and Active;
  if TFmxFormState.fsModal in FFormState then
    ModalResult := mrCancel
  else
  begin
    if CloseQuery then
    begin
      CloseAction := TCloseAction.caHide;
      DoClose(CloseAction);
      if CloseAction <> TCloseAction.caNone then
      begin
        if (Application.MainForm = Self) and
           (not (CloseAction in [TCloseAction.caMinimize, TCloseAction.caNone])) then
        begin
          Application.Terminate;
          Exit;
        end
        else
        begin
          case CloseAction of
            TCloseAction.caHide: Hide;
            TCloseAction.caFree: Release;
            TCloseAction.caMinimize: Deactivate { WindowState := wsMinimized};
            TCloseAction.caNone: Exit;
          end;
        end;
      end;
    end;
    if NeedActiveChange then
      Screen.NextActiveForm(Self);
  end;
end;

procedure TCommonCustomForm.Show;
var
  ScreenService: IFMXScreenService;
begin
  if not (csDesigning in ComponentState) and
    TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, IInterface(ScreenService)) then
  begin
    case FPosition of
      TFormPosition.poScreenCenter:
        SetBounds(System.Round((ScreenService.GetScreenSize.X - Width) / 2), System.Round((ScreenService.GetScreenSize.Y - Height) / 2), Width, Height);
    end;
  end;
  if FFullScreen then
  begin
    SetFullScreen(True);
    FFullScreen := False;
  end ;
  FVisible := True;
  FWinService.ShowWindow(Self);
  DoShow;
end;

procedure TCommonCustomForm.Hide;
begin
  FVisible := False;
  if not (csDesigning in ComponentState) then
    FWinService.HideWindow(Self);
  DoHide;
  if GetFullScreen then
  begin
    FFullScreen := True;
    SetFullScreen(False);
  end ;
end;

procedure TCommonCustomForm.BringToFront;
begin
  inherited;
  FWinService.BringToFront(self);
end;

procedure TCommonCustomForm.SendToBack;
begin
  inherited;
  FWinService.SendToBack(self);
end;

function TCommonCustomForm.ShowModal: TModalResult;
begin
  FFormState := FFormState + [TFmxFormState.fsModal];
  try
    FOldActiveForm := Screen.ActiveForm;
    if FOldActiveForm <> nil then
      FOldActiveForm.AddFreeNotify(self);
    try
      Result := FWinService.ShowWindowModal(Self);
    finally
      if Assigned(FOldActiveForm) then
      begin
        try
          if FOldActiveForm.Visible then
            Screen.ActiveForm := FOldActiveForm;
        finally
          FOldActiveForm.RemoveFreeNotify(Self);
          FOldActiveForm := nil;
        end;
      end;
    end;
  finally
    FFormState := FFormState - [TFmxFormState.fsModal];
  end;
end;

procedure TCommonCustomForm.CloseModal;
var
  CloseAction: TCloseAction;
begin
  try
    CloseAction := TCloseAction.caNone;
    if CloseQuery then
    begin
      CloseAction := TCloseAction.caHide;
      DoClose(CloseAction);
    end;
    case CloseAction of
      TCloseAction.caNone:
        ModalResult := mrNone;
      TCloseAction.caFree:
        Release;
    end;
  except
    ModalResult := mrNone;
    Application.HandleException(Self);
  end;
end;

procedure TCommonCustomForm.Release;
begin
  FWinService.ReleaseWindow(Self);
  Screen.RemoveForm(Self);
  inherited Release;
end;

procedure TCommonCustomForm.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  NR, PR: TRectF;
  SizeChanged: Boolean;
begin
  if (ALeft <> FLeft) or (ATop <> FTop) or (AWidth <> FWidth) or (AHeight <> FHeight) then
  begin
    SizeChanged := (AWidth <> FWidth) or (AHeight <> FHeight);

    FTop := ATop;
    FLeft := ALeft;
    FWidth := AWidth;
    FHeight := AHeight;
    NR := RectF(FLeft, FTop, FLeft + FWidth, FTop + FHeight);

    // This procedure can be called by the platform in response to a change coming
    // from another source. Check to see if the actual size reported by the
    // platform indicates we actually need to change the value;
    PR := FWinService.GetWindowRect(Self);
    if not EqualRect(PR, NR) then
      FWinService.SetWindowRect(Self, NR);
    if SizeChanged or (csDesigning in ComponentState) then
      ResizeHandle;
    if SizeChanged then
      Resize;
  end;
end;

procedure TCommonCustomForm.IsDialogKey(const Key: Word;
                                        const KeyChar: WideChar;
                                        const Shift: TShiftState;
                                          var IsDialog: boolean);
begin
  IsDialog := (KeyChar < ' ') or
              ((Shift * [ssAlt, ssCtrl, ssCommand]) <> []);
end;

procedure TCommonCustomForm.KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
var
  FocusObj: TFmxObject;
  Done: boolean;
  FocusPopup: TCustomPopupMenu;
  lIsDialog: boolean;
  I: Integer;

  procedure TraverseChildren(Container: TFmxObject);
  var
    I: integer;
    Control: IControl;
  begin
    if Supports(Container, IControl, Control) and (not Control.Enabled) then Exit;
    for I := 0 to Container.ComponentCount - 1 do
      if (Container.Components[I] is TCustomActionList) and
         (TCustomActionList(Container.Components[I]).DialogKey(Key, Shift)) then
      begin
        Done := True;
        Exit;
      end;
    if (Container.ChildrenCount > 0) then
      for I := 0 to Container.ChildrenCount - 1 do
      begin
        TraverseChildren(Container.Children[I]);
        if Done then
          Exit;
      end;
  end;
  procedure OtherForms(IsMain: boolean);
  var I, J: integer;
      F: TCommonCustomForm;
  begin
    if Done then Exit;
    for I := 0 to Screen.FormCount - 1 do
    if (Screen.Forms[I] <> self) and
       (Screen.Forms[I].Visible) and
       (IsMain xor (Screen.Forms[I] <> Application.MainForm)) then
    begin
      F := Screen.Forms[I];
      for J := F.ChildrenCount - 1 downto 0 do
      begin
        if F.Children[J] is TMainMenu then
          TMainMenu(F.Children[J]).DialogKey(Key, Shift);
        if Key = 0 then
        begin
          Done := True;
          Exit;
        end;
      end;
      TraverseChildren(F);
      if Done then Exit;
    end;
  end;
var
  Control: IControl;
begin
  { dialog key }
  FocusPopup := nil;
  lIsDialog := False;
  IsDialogKey(Key, KeyChar, Shift, lIsDialog);
  try
    if lIsDialog then
    begin
      Done := False;
      // 1. perform key in Focus Control
      if Assigned(FFocused) then
      begin
        FFocused.DialogKey(Key, Shift);
        if Key = 0 then
          Exit;
        FocusObj := FFocused.GetObject;
      end
      else
        FocusObj := nil;
      // 2. perform key in PopupMenu of Focus Control
      if Supports(FocusObj, IControl, Control) then
      begin
        FocusPopup := Control.PopupMenu;
        if FocusPopup is TPopupMenu then
        begin
          TPopupMenu(FocusPopup).DialogKey(Key, Shift);
          if Key = 0 then
            Exit;
        end
        else
          FocusPopup := nil;
      end;
      // 3. perform key in other Menus
      for i := ChildrenCount - 1 downto 0 do
      if Children[i] <> FocusPopup then
      begin
        if Children[i] is TMainMenu then
          TMainMenu(Children[i]).DialogKey(Key, Shift)
        else if Children[i] is TPopupMenu then
          TPopupMenu(Children[i]).DialogKey(Key, Shift);
        if Key = 0 then
          Exit;
      end;
      // 4. perform key in other, no focus controls
      for i := ChildrenCount - 1 downto 0 do
      if Children[i] <> FocusObj then
      begin
        if Children[i].IsIControl then
          Children[i].AsIControl.DialogKey(Key, Shift);
        if Key = 0 then
          Exit;
      end;
      // 5. perform key in all ActionLists in Childrens
      TraverseChildren(self);
      // 6. perform key in all main menus and ActionLists in other forms
      OtherForms(True);
      OtherForms(False);
      if Done then Exit;
    end;

    { change focus }
    if (Key = vkTab) then
    begin
      AdvanceTabFocus(not (ssShift in Shift));
      Exit;
    end;

    { focused handler }
    if ((Key <> 0) or (KeyChar <> #0)) then
    begin
      if Assigned(FFocused) then
        FFocused.KeyDown(Key, KeyChar, Shift);
      if Assigned(FOnKeyDown) then
        FOnKeyDown(Self, Key, KeyChar, Shift);
    end;
  finally
    Application.FLastKeyPress := Now;
    Application.FLastUserActive := Application.FLastKeyPress;
  end;
end;

procedure TCommonCustomForm.AdvanceTabFocus(const MoveForward: Boolean);
var
  NewFocus: IControl;
  List: TInterfaceList;
  I, CurIdx: Integer;
begin
  NewFocus := nil;
  List := TInterfaceList.Create;
  try
    GetTabOrderList(List, True);

    CurIdx := List.IndexOf(FFocused);
    for I := 0 to List.Count-1 do
    begin
      if MoveForward then
        CurIdx := (CurIdx + 1) mod List.Count
      else
      begin
        CurIdx := CurIdx - 1;
        if CurIdx < 0 then CurIdx := List.Count - 1;
      end;

      if IControl(List[CurIdx]).CheckForAllowFocus then
      begin
        NewFocus := IControl(List[CurIdx]);
        break;
      end;
    end;
  finally
    FreeAndNil(List);
  end;
  if Assigned(NewFocus) then
    NewFocus.SetFocus;
end;

procedure TCommonCustomForm.KeyUp(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
begin
  try
    { focused handler }
    if Assigned(FFocused) then
      FFocused.KeyUp(Key, KeyChar, Shift);
    if Assigned(FOnKeyUp) then
      FOnKeyUp(Self, Key, KeyChar, Shift);
  finally
    Application.FLastKeyPress := Now;
    Application.FLastUserActive := Application.FLastKeyPress;
  end;
end;

procedure TCommonCustomForm.Loaded;
begin
  inherited;
  FLastWidth := GetOriginalContainerSize.X;
  FLastHeight := GetOriginalContainerSize.Y;

  if FStyleBookChanged then
    UpdateStyleBook;
end;

function TCommonCustomForm.ObjectAtPoint(P: TPointF): IControl;
var
  i: Integer;
  Obj: TFmxObject;
  NewObj: IControl;
begin
  Result := nil;
  for i := ChildrenCount - 1 downto 0 do
  begin
    Obj := Children[i];
    if IInterface(Obj).QueryInterface(IControl, NewObj) <> 0 then
      Continue;
    if not NewObj.GetVisible and not(csDesigning in ComponentState) then
      Continue;
    NewObj := NewObj.ObjectAtPoint(P);
    if Assigned(NewObj) then
    begin
      Result := NewObj;
      Exit;
    end;
  end;
end;

procedure TCommonCustomForm.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  P: TPointF;
  Obj: IControl;
  SG: ISizeGrip;
  NewCursor: TCursor;
begin
  try
    { translate coord }
    FMousePos := PointF(X, Y);
    FDownPos := FMousePos;
    NewCursor := Cursor;  // use the form cursor only if no control has been clicked
    Obj := IControl(ObjectAtPoint(ClientToScreen(FMousePos)));
    if Assigned(Obj) then
      if (IInterface(Obj).QueryInterface(ISizeGrip, SG) = 0) then
        StartWindowResize
      else
      begin
        P := Obj.ScreenToLocal(ClientToScreen(FMousePos));
        if (Obj.DragMode = TDragMode.dmAutomatic) and (Button = TMouseButton.mbLeft) then
          Obj.BeginAutoDrag
        else
          Obj.MouseDown(Button, Shift, P.X, P.Y);
        NewCursor := Obj.Cursor;
      end
    else
      DoMouseDown(Button, Shift, X, Y);

    if Assigned(FCursorService) then
      FCursorService.SetCursor(NewCursor);
  finally
    Application.FLastUserActive := Now;
  end;
end;

procedure TCommonCustomForm.MouseLeave;
begin
  MouseMove([], -1, -1);
end;

procedure TCommonCustomForm.MouseMove(Shift: TShiftState; X, Y: Single);
var
  P: TPointF;
  Obj: IControl;
  SG: ISizeGrip;
  NewCursor: TCursor;
begin
  try
    NewCursor := Cursor;
    { drag }
    if FDragging then
    begin
      SetBounds(Round(Left + (X - FDownPos.X)), Round(Top + (Y - FDownPos.Y)), Width, Height);
      Exit;
    end;
    { Form's Resizing }
    if FResizing then
    begin
      FResizeSize.X := Round(FResizeSize.X + (X - FMousePos.X));
      FResizeSize.Y := Round(FResizeSize.Y + (Y - FMousePos.Y));
      SetBounds(Left, Top, Round(FResizeSize.X), Round(FResizeSize.Y));
      if Assigned(FCursorService) then
        FCursorService.SetCursor(crSizeNWSE);
      FMousePos := PointF(X, Y);
      Exit;
    end;
    { translate coord }
    FMousePos := PointF(X, Y);
    if Assigned(FCaptured) then
    begin
      if Assigned(FCursorService) then
      begin
        if (FCaptured.QueryInterface(ISizeGrip, SG) = 0) and Assigned(SG) then
          FCursorService.SetCursor(crSizeNWSE)
        else
          FCursorService.SetCursor(FCaptured.InheritedCursor);
      end;
      P := FCaptured.ScreenToLocal(ClientToScreen(FMousePos));
      FCaptured.MouseMove(Shift, P.X, P.Y);
      Exit;
    end;

    Obj := ObjectAtPoint(ClientToScreen(FMousePos));
    if Assigned(Obj) then
    begin
      SetHovered(Obj);
      P := Obj.ScreenToLocal(ClientToScreen(FMousePos));
      Obj.MouseMove(Shift, P.X, P.Y);
      if ((Obj.QueryInterface(ISizeGrip, SG) = 0) and Assigned(SG)) then
        NewCursor := crSizeNWSE
      else
        NewCursor := Obj.InheritedCursor;
    end
    else
    begin
      DoMouseMove(Shift, X, Y);
      SetHovered(nil);
    end;
    // set cursor
    if Assigned(FCursorService) then
      FCursorService.SetCursor(NewCursor);
    FDownPos := FMousePos;
  finally
    Application.FLastUserActive := Now;
  end;
end;

procedure TCommonCustomForm.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  P: TPointF;
  Obj: IControl;
  NewCursor: TCursor;
begin
  try
    { Drag }
    if FDragging then
    begin
      FDragging := False;
      ReleaseCapture;
    end;
    { Form's Resizing }
    if FResizing then
    begin
      FResizing := False;
      ReleaseCapture;
    end;
    if Assigned(FCaptured) then
    begin
      P := FCaptured.ScreenToLocal(ClientToScreen(FMousePos));
      FCaptured.MouseUp(Button, Shift, P.X, P.Y);
      SetCaptured(nil);
      Exit;
    end;
    Obj := ObjectAtPoint(ClientToScreen(FMousePos));
    if Assigned(Obj) then
    begin
      P := Obj.ScreenToLocal(ClientToScreen(FMousePos));
      Obj.MouseUp(Button, Shift, P.X, P.Y);

      // we are over a control; use its cursor
      NewCursor := Obj.InheritedCursor;
    end
    else
    begin
      // the mouse is over the form; use the form cursor
      NewCursor := Cursor;
      DoMouseUp(Button, Shift, X, Y);
    end;

    // update the cursor
    if Assigned(FCursorService) then
      FCursorService.SetCursor(NewCursor);
  finally
    Application.FLastUserActive := Now;
  end;
end;

procedure TCommonCustomForm.MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
var
  Obj: IControl;
  MousePos: TPointF;
  MouseService: IFMXMouseService;
begin
  try
    if TPlatformServices.Current.SupportsPlatformService(IFMXMouseService, IInterface(MouseService)) then
    begin
      MousePos := MouseService.GetMousePos;
      { event }
      if Assigned(FCaptured) then
      begin
        FCaptured.MouseWheel(Shift, WheelDelta, Handled);
        Exit;
      end;
      DoMouseWheel(Shift, WheelDelta, Handled);
      if not Handled then
      begin
        Obj := ObjectAtPoint(MousePos);
        while Assigned(Obj) do
        begin
          Obj.MouseWheel(Shift, WheelDelta, Handled);
          if Handled then
            Break;
          if Assigned(Obj.Parent) and (Obj.Parent.IsIControl) then
            Obj := Obj.Parent.AsIControl
          else
            Obj := nil;
        end;
      end;
    end;
  finally
    Application.FLastUserActive := Now;
  end;
end;

procedure TCommonCustomForm.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
{$IFDEF WIN32}
  if Assigned(FDesigner) then
    FDesigner.Notification(AComponent, Operation);
{$ENDIF}
  if (Operation = opRemove) and (AComponent = FStyleBook) then
    StyleBook := nil;
end;

procedure TCommonCustomForm.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  OwnedComponent: TComponent;
begin
  inherited GetChildren(Proc, Root);
  if Root = Self then
    for I := 0 to ComponentCount - 1 do
    begin
      OwnedComponent := Components[I];
      if OwnedComponent is TFmxObject then
      begin
        if not Assigned(TFmxObject(OwnedComponent).Parent) then
          Proc(OwnedComponent);
      end
      else
        if not OwnedComponent.HasParent then
          Proc(OwnedComponent);
    end;
end;

{ Drag and Drop }

function TCommonCustomForm.FindTarget(P: TPointF; const Data: TDragObject): IControl;
var
  i: Integer;
  NewObj: IControl;
begin
  Result := nil;
  for i := 0 to ChildrenCount - 1 do
    if Supports(Children[i], IControl, NewObj) and NewObj.Visible and NewObj.HitTest then
    begin
      NewObj := NewObj.FindTarget(P, Data);

      if Assigned(NewObj) then
        Exit(NewObj);
    end;
end;

procedure TCommonCustomForm.FreeNotification(AObject: TObject);
begin
  inherited ;
  if Assigned(FHovered) and (FHovered.GetObject = AObject) then
    FHovered := nil;
  if Assigned(FTarget) and (FTarget.GetObject = AObject) then
    FTarget := nil;
  if Assigned(FCaptured) and (FCaptured.GetObject = AObject) then
    FCaptured := nil;
  if Assigned(FFocused) and (FFocused.GetObject = AObject) then
    FFocused := nil;
  if Assigned(FOldActiveForm) and (FOldActiveForm = AObject) then
    FOldActiveForm := nil;
  if Assigned(FActiveControl) and (FActiveControl.GetObject = AObject) then
    FActiveControl := nil;
end;

procedure TCommonCustomForm.DragDrop(const Data: TDragObject; const Point: TPointF);
begin
  if Assigned(FTarget) then
    FTarget.DragDrop(Data, FTarget.ScreenToLocal(Point));
end;

procedure TCommonCustomForm.DragEnter(const Data: TDragObject; const Point: TPointF);
var
  NewTarget: IControl;
begin
  NewTarget := FindTarget(Point, Data);
  if (NewTarget <> FTarget) then
  begin
    if Assigned(FTarget) then
    begin
      FTarget.DragLeave;
      FTarget.RemoveFreeNotify(Self);
    end;
    FTarget := NewTarget;
    if Assigned(FTarget) then
    begin
      FTarget.AddFreeNotify(Self);
      FTarget.DragEnter(Data, FTarget.ScreenToLocal(Point));
    end;
  end;
end;

procedure TCommonCustomForm.DragLeave;
begin
  if Assigned(FTarget) then
  begin
    FTarget.DragLeave;
    FTarget.RemoveFreeNotify(Self);
  end;
  FTarget := nil;
end;

procedure TCommonCustomForm.DragOver(const Data: TDragObject; const Point: TPointF; var Accept: Boolean);
var
  NewTarget: IControl;
begin
  NewTarget := FindTarget(Point, Data);
  if (NewTarget <> FTarget) then
  begin
    if Assigned(FTarget) then
    begin
      FTarget.DragLeave;
      FTarget.RemoveFreeNotify(Self);
    end;
    FTarget := NewTarget;
    if Assigned(FTarget) then
    begin
      FTarget.AddFreeNotify(Self);
      FTarget.DragEnter(Data, FTarget.ScreenToLocal(Point));
    end;
  end;
  if Assigned(FTarget) then
    FTarget.DragOver(Data, FTarget.ScreenToLocal(Point), Accept);
end;

procedure TCommonCustomForm.EndUpdate;
var
  I: Integer;
begin
  FUpdating := FUpdating - 1;
  for I := 0 to ChildrenCount - 1 do
    if Children[I].IsIControl then
      Children[I].AsIControl.EndUpdate;
  if FUpdating = 0 then
    Recreate;
end;

procedure TCommonCustomForm.EnterMenuLoop;
begin
  TMessageManager.DefaultManager.SendMessage(Self, TStartMenuLoopMessage.Create(Self), True);
end;

procedure TCommonCustomForm.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    FWinService.SetWindowCaption(Self, FCaption);
{$IFDEF WIN32}
    if (csDesigning in ComponentState) and Assigned(FDesigner) then
      FDesigner.UpdateBorder;
{$ENDIF}
  end;
end;

procedure TCommonCustomForm.SetHeight(const Value: Integer);
begin
  SetBounds(Left, Top, Width, Value);
end;

procedure TCommonCustomForm.SetHovered(const Value: IControl);
begin
  if (Value <> FHovered) then
  begin
    if Assigned(FHovered) then
    begin
      FHovered.DoMouseLeave;
      FHovered.RemoveFreeNotify(Self);
    end;
    FHovered := Value;
    if Assigned(FHovered) then
    begin
      FHovered.AddFreeNotify(Self);
      FHovered.DoMouseEnter;
    end;
  end;
end;

procedure TCommonCustomForm.SetLeft(const Value: Integer);
begin
  if (csDesigning in ComponentState) then
  begin
    DesignInfo := (DesignInfo and $FFFF0000) or (Cardinal(Value) and $FFFF);
    if not (csLoading in ComponentState) and (Position <> TFormPosition.poDefaultSizeOnly) then
      Position := TFormPosition.poDesigned;
  end
  else
    SetBounds(Value, Top, Width, Height);
end;

procedure TCommonCustomForm.SetPadding(const Value: TBounds);
begin
  FPadding.Assign(Value);
end;

procedure TCommonCustomForm.SetPosition(const Value: TFormPosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
  end;
end;

procedure TCommonCustomForm.SetTop(const Value: Integer);
begin
  if (csDesigning in ComponentState) then
  begin
    DesignInfo := (DesignInfo and $0000FFFF) or (Value shl 16);
    if not (csLoading in ComponentState) and (Position <> TFormPosition.poDefaultSizeOnly) then
      Position := TFormPosition.poDesigned;
  end
  else
    SetBounds(Left, Value, Width, Height);
end;

procedure TCommonCustomForm.SetWidth(const Value: Integer);
begin
  SetBounds(Left, Top, Value, Height);
end;

procedure TCommonCustomForm.SetWindowState(const Value: TWindowState);
begin
  if FWindowState <> Value then
  begin
    FWindowState := Value;
    if not (csDesigning in ComponentState) then
      if FVisible then
        FWinService.SetWindowState(Self, FWindowState);
  end;
end;

procedure TCommonCustomForm.MouseCapture;
begin
  FWinService.SetCapture(Self);
end;

procedure TCommonCustomForm.ReleaseCapture;
begin
  FWinService.ReleaseCapture(Self);
end;

procedure TCommonCustomForm.Resize;
begin
  if Assigned(FOnResize) then
    FOnResize(Self);
end;

procedure TCommonCustomForm.ResizeHandle;
begin
  FBorder.Resize;
end;

procedure TCommonCustomForm.Invalidate;
begin
  InvalidateRect(ClientRect);
end;

procedure TCommonCustomForm.InvalidateRect(R: TRectF);
begin
  if csDestroying in ComponentState then
    Exit;
  FWinService.InvalidateWindowRect(Self, R);
end;

function TCommonCustomForm.GetClientHeight: Integer;
begin
  Result := round(FWinService.GetClientSize(Self).Y);
end;

function TCommonCustomForm.GetClientWidth: Integer;
begin
  Result := round(FWinService.GetClientSize(Self).X);
end;

function TCommonCustomForm.GetContainerHeight: Single;
begin
  Result := ClientHeight;
end;

function TCommonCustomForm.GetContainerWidth: Single;
begin
  Result := ClientWidth;
end;

function TCommonCustomForm.GetContextHandle: THandle;
begin
  Result := FContextHandle;
end;

function TCommonCustomForm.GetTop: Integer;
begin
  if (csDesigning in ComponentState) and Assigned(Parent) then
    Result := SmallInt((DesignInfo and $FFFF0000) shr 16)
  else
    Result := FTop;
end;

function TCommonCustomForm.GetWindowStyle: TWindowStyles;
begin
  Result := [];
end;

function TCommonCustomForm.GetLeft: Integer;
begin
  if (csDesigning in ComponentState) then
    Result := SmallInt(DesignInfo and $0000FFFF)
  else
    Result := FLeft;
end;

procedure TCommonCustomForm.SetClientHeight(const Value: Integer);
begin
  if csReading in ComponentState then
    FOriginalContainerSize.Y := Value;

  FWinService.SetClientSize(Self, PointF(ClientWidth, Value));
end;

procedure TCommonCustomForm.SetClientWidth(const Value: Integer);
begin
  if csReading in ComponentState then
    FOriginalContainerSize.X := Value;

  FWinService.SetClientSize(Self, PointF(Value, ClientHeight));
end;

procedure TCommonCustomForm.SetContextHandle(const AContextHandle: THandle);
begin
  FContextHandle := AContextHandle;
end;

procedure TCommonCustomForm.SetCursor(const Value: TCursor);
begin
  FCursor := Value;
end;

procedure TCommonCustomForm.SetDesigner(const ADesigner: IDesignerHook);
begin
  FDesigner := ADesigner;
end;

procedure TCommonCustomForm.SetTransparency(const Value: Boolean);
begin
  if FTransparency <> Value then
  begin
    FTransparency := Value;
    if not (csDesigning in ComponentState) then
      Recreate;
  end;
end;

procedure TCommonCustomForm.SetBorderStyle(const Value: TFmxFormBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    if not (csDesigning in ComponentState) then
      Recreate;
{$IFDEF WIN32}
    if (csDesigning in ComponentState) and Assigned(FDesigner) then
      FDesigner.UpdateBorder;
{$ENDIF}
  end;
end;

procedure TCommonCustomForm.SetBiDiMode(const Value: TBiDiMode);
begin
  FBiDiMode := Value;
end;

procedure TCommonCustomForm.SetBorder(const Value: TFormBorder);
begin
end;

procedure TCommonCustomForm.SetBorderIcons(const Value: TBorderIcons);
begin
  if FBorderIcons <> Value then
  begin
    FBorderIcons := Value;
    if not (csDesigning in ComponentState) then
      Recreate;
{$IFDEF WIN32}
    if (csDesigning in ComponentState) and Assigned(FDesigner) then
      FDesigner.UpdateBorder;
{$ENDIF}
  end;
end;

procedure TCommonCustomForm.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    if FVisible then
    begin
      Show;
    end
    else
    begin
      Hide;
    end ;
  end;
end;

function TCommonCustomForm.CaptionStore: boolean;
begin
  result := ((Caption <> '') and (not ActionClient))
            or
            (not (ActionClient and
                  (ActionLink is TFormActionLink) and
                  (TFormActionLink(ActionLink).IsCaptionLinked) and
                  (Action is TContainedAction)));
end;

procedure TCommonCustomForm.ChildrenAlignChanged;
begin
end;

function TCommonCustomForm.ClientRect: TRectF;
begin
  Result := RectF(0, 0, ClientWidth, ClientHeight);
end;

function TCommonCustomForm.ClientToScreen(const Point: TPointF): TPointF;
begin
  Result := FWinService.ClientToScreen(Self, Point);
end;

procedure TCommonCustomForm.DoScaleChanged;
begin
  FBorder.ScaleChanged;
end;

procedure TCommonCustomForm.ScaleChangedHandler(const Sender: TObject; const Msg: FMX.Messages.TMessage);
begin
  if (not (csDestroying in ComponentState)) and
     (TScaleChangedMessage(Msg).Form = Self) then
    DoScaleChanged;
end;

procedure TCommonCustomForm.StyleChangedHandler(const Sender: TObject; const Msg: FMX.Messages.TMessage);
begin
  if (Msg is TStyleChangedMessage) and (not (csDestroying in ComponentState)) then
    DoStyleChanged;
end;

function TCommonCustomForm.ScreenToClient(const Point: TPointF): TPointF;
begin
  Result := FWinService.ScreenToClient(Self, Point);
end;

procedure TCommonCustomForm.SetTopMost(const Value: Boolean);
begin
  if FTopMost <> Value then
  begin
    FTopMost := Value;
    Recreate;
  end;
end;

procedure TCommonCustomForm.ActionChange(Sender: TBasicAction;
  CheckDefaults: Boolean);
begin
  if Sender is TCustomAction then
  begin
    if (not CheckDefaults) or (Visible = True) then
      Visible := TCustomAction(Sender).Visible;
    if (not CheckDefaults) or (Caption = '') or (Caption = Name) then
      Caption := TCustomAction(Sender).Caption;
  end;
  inherited;
end;

procedure TCommonCustomForm.ShowCaret(const Control: IControl);
var
  LICaret: ICaret;
begin
  if Assigned(Control) and
     (Control.QueryInterface(ICaret, IInterface(LICaret)) = S_OK) then
    LICaret.ShowCaret;
end;

procedure TCommonCustomForm.HideCaret(const Control: IControl);
var
  LICaret: ICaret;
begin
  if Assigned(Control) and
     (Control.QueryInterface(ICaret, IInterface(LICaret)) = S_OK) then
    LICaret.HideCaret;
end;

procedure TCommonCustomForm.Activate;
var
  TSC: ITextInput;
  OldActiveForm: TCommonCustomForm;
  LFocused: IControl;
begin
  if FActivation then Exit;
  FActivation := True;
  try
    if not Visible and not Active then
      FActive := True;
    if (not Visible) or
       (Active) or
       (Released) or
       (csDestroying in ComponentState) or
       (ApplicationState <> TApplicationState.asRunning) then Exit;
    OldActiveForm := Screen.ActiveForm;
    FActive := True;
    try
      Screen.ActiveForm := Self;
      FWinService.Activate(Self);
      if Assigned(FFocused) then
      begin
        if Supports(FFocused, ITextInput, TSC) then
          TSC.GetTextService.EnterControl(Handle);
        ShowCaret(FFocused);
      end;
      FBorder.Activate;
    except
      FActive := False;
      Screen.SetActiveForm(OldActiveForm);
      Raise;
    end;
    LFocused := FFocused;
    while Assigned(LFocused) do
    begin
      LFocused.DoActivate;
      if Assigned(LFocused.Parent) and
         (LFocused.Parent.IsIControl) then
        LFocused := LFocused.Parent.AsIControl
      else
        LFocused := nil;
    end;
    if Assigned(FOnActivate) then
      FOnActivate(Self);
  finally
    FActivation := False;
    Application.FLastUserActive := Now;
  end;
end;

procedure TCommonCustomForm.AddToTabList(const AObject: TFmxObject);
begin
  if Assigned(AObject.Owner)
    and (AObject.Owner = Self)
    and (AObject.IsIControl) and (AObject.Stored) then
  begin
    inherited;
    AObject.AsIControl.UpdateTabOrder(FTabList.Count - 1);
  end;
end;

procedure TCommonCustomForm.Deactivate;
var
  TSC: ITextInput;
  LFocused: IControl;
begin
  if (not Active) or FActivation then Exit;
  FActivation := True;
  try
    try
      if not (csDestroying in ComponentState) then
      begin
        if Assigned(FFocused) then
        begin
          HideCaret(FFocused);
          if Supports(FFocused, ITextInput, TSC) then
            TSC.GetTextService.ExitControl(Handle);
        end;
        LFocused := FFocused;
        while Assigned(LFocused) do
        begin
          LFocused.DoDeactivate;
          if Assigned(LFocused.Parent) and
             (LFocused.Parent.IsIControl) then
            LFocused := LFocused.Parent.AsIControl
          else
            LFocused := nil;
        end;
        if Assigned(FOnDeactivate) then
          FOnDeactivate(Self);
      end;
    finally
      FActive := False;
      FBorder.Deactivate;
    end;
  finally
    FActivation := False;
  end;
end;

procedure TCommonCustomForm.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    if Value then
      Activate
    else
      Deactivate;
  end;
end;

procedure TCommonCustomForm.SetFormFamily(const Value: string);
var
  OldFormFamilyName: string;
begin
  if FFormFamily <> Value then
  begin
     OldFormFamilyName := FFormFamily;
     FFormFamily := Value;
  {$IFDEF WIN32}
     if (csDesigning in ComponentState) and Assigned(FDesigner) then
        FDesigner.FormFamilyChanged(OldFormFamilyName, FFormFamily, ClassName);
  {$ENDIF}
  end;
end;

procedure TCommonCustomForm.SetFullScreen(const AValue: Boolean);
begin
  if (csDesigning in ComponentState) or (csLoading in ComponentState) then
    FFullScreen := AValue
  else
    FWinService.SetFullScreen(Self, AValue);
end;

procedure TCommonCustomForm.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('DesignerMobile', ReadDesignerMobile, WriteDesignerMobile, {$IFDEF MSWINDOWS}True{$ELSE}False{$ENDIF});
  Filer.DefineProperty('DesignerWidth', ReadDesignerWidth, WriteDesignerWidth, {$IFDEF MSWINDOWS}True{$ELSE}False{$ENDIF});
  Filer.DefineProperty('DesignerHeight', ReadDesignerHeight, WriteDesignerHeight, {$IFDEF MSWINDOWS}True{$ELSE}False{$ENDIF});
  Filer.DefineProperty('DesignerDeviceName', ReadDesignerDeviceName, WriteDesignerDeviceName, {$IFDEF MSWINDOWS}True{$ELSE}False{$ENDIF});
  Filer.DefineProperty('DesignerOrientation', ReadDesignerOrientation, WriteDesignerOrientation, {$IFDEF MSWINDOWS}True{$ELSE}False{$ENDIF});
  Filer.DefineProperty('EnableBorderStyling', IgnoreBooleanValue, nil, False);
end;

procedure TCommonCustomForm.ReadDesignerDeviceName(Reader: TReader);
begin
  {$IFDEF MSWINDOWS}
  FDesignerDeviceName := Reader.ReadString;
  {$ELSE}
  Reader.ReadString;
  {$ENDIF}
end;

procedure TCommonCustomForm.ReadDesignerHeight(Reader: TReader);
begin
  {$IFDEF MSWINDOWS}
  FDesignerHeight := Reader.ReadInteger;
  {$ELSE}
  Reader.ReadInteger;
  {$ENDIF}
end;

procedure TCommonCustomForm.ReadDesignerMobile(Reader: TReader);
begin
  {$IFDEF MSWINDOWS}
  FDesignerMobile := Reader.ReadBoolean;
  {$ELSE}
  Reader.ReadBoolean;
  {$ENDIF}
end;

procedure TCommonCustomForm.ReadDesignerOrientation(Reader: TReader);
begin
  {$IFDEF MSWINDOWS}
  FDesignerOrientation := TFormOrientation(Reader.ReadInteger);
  {$ELSE}
  Reader.ReadInteger;
  {$ENDIF}
end;

procedure TCommonCustomForm.ReadDesignerWidth(Reader: TReader);
begin
  {$IFDEF MSWINDOWS}
  FDesignerWidth := Reader.ReadInteger;
  {$ELSE}
  Reader.ReadInteger;
  {$ENDIF}
end;

procedure TCommonCustomForm.WriteDesignerDeviceName(Writer: TWriter);
begin
  {$IFDEF MSWINDOWS}
  Writer.WriteString(FDesignerDeviceName);
  {$ENDIF}
end;

procedure TCommonCustomForm.WriteDesignerHeight(Writer: TWriter);
begin
  {$IFDEF MSWINDOWS}
  Writer.WriteInteger(FDesignerHeight);
  {$ENDIF}
end;

procedure TCommonCustomForm.WriteDesignerMobile(Writer: TWriter);
begin
  {$IFDEF MSWINDOWS}
  Writer.WriteBoolean(FDesignerMobile);
  {$ENDIF}
end;

procedure TCommonCustomForm.WriteDesignerOrientation(Writer: TWriter);
begin
  {$IFDEF MSWINDOWS}
  Writer.WriteInteger(Integer(FDesignerOrientation));
  {$ENDIF}
end;

procedure TCommonCustomForm.WriteDesignerWidth(Writer: TWriter);
begin
  {$IFDEF MSWINDOWS}
  Writer.WriteInteger(FDesignerWidth);
  {$ENDIF}
end;

procedure TCommonCustomForm.StartWindowDrag;
begin
  if (csDesigning in ComponentState) then Exit;
  FDragging := True;
  FDownPos := FMousePos;
  MouseCapture;
end;

procedure TCommonCustomForm.StartWindowResize;
begin
  if (csDesigning in ComponentState) then Exit;
  FResizing := True;
  FDownPos := FMousePos;
  FResizeSize := PointF(Width, Height);
  FDownSize := FResizeSize;
  MouseCapture;
end;

type
  TObjInfo = record
    Level: Integer;
    Index: Integer;
    Initiated: Boolean;
    Obj: TObject;
  end;

  TComparerTFmxObject = class (TComparer<TObjInfo>)
  public
    function Compare(const Left, Right: TObjInfo): Integer; override;
  end;

  TTObjInfoList = class (TList<TObjInfo>)

  end;

{ TComparerTFmxObject }

function TComparerTFmxObject.Compare(const Left, Right: TObjInfo): Integer;
begin
  if Left.Obj = Right.Obj then
    Result := 0
  else
  begin
    if Left.Level < Right.Level then
      Result := -1
    else if Left.Level > Right.Level then
      Result := 1
    else
    begin
      if Left.Index < Right.Index then
        Result := -1
      else if Left.Index > Right.Index then
        Result := 1
      else
        Result := 0;
    end;
  end;
end;

procedure TCommonCustomForm.UpdateActions;
var
  I, InitiatedCount: Integer;
  ClientList: TTObjInfoList;
  Bucket: TDictionary<TObject, TObject>;
  Comparer: IComparer<TObjInfo>;

  function IsCollected(Obj: TObject): Boolean;
  begin
    Result := Bucket.ContainsKey(Obj);
    if not Result then
      Bucket.Add(Obj, nil);
  end;

  function CollectObjectInfo(const Client: TFmxObject; var Info: TObjInfo): Boolean;
  var
    O: TFmxObject;
  begin
    Info.Obj := Client;
    Info.Level := 0;
    Info.Index := Client.Index;
    O := Client;
    Result := True;
    while Assigned(O) and O.HasParent do
    begin
      O := TFmxObject(O.GetParentComponent);
      if Assigned(O) and O.IsIControl then
        Result := Result and O.AsIControl.Visible;
      Inc(Info.Level);
    end;

    if Client.IsIControl then
    begin
      Info.Level := Info.Level + ((1 - Byte(Client is TMainMenu)) shl (29));
      Info.Level := Info.Level + ((1 - Byte(Client is TMenuItem)) shl (28));
    end
    else
    begin
      if Client <> Self then
        Info.Level := Info.Level + (1 shl 30);
    end;
  end;

  function CollectActionClients(InfoList: TTObjInfoList) : Integer;
  var
    Client: TFmxObject;
    Info: TObjInfo;
    ParentVisible: Boolean;
    RootSelf: IRoot;
  begin
    QueryInterface(IRoot, RootSelf);
    for Client in Application.GetActionClients do
      if Client.Root = RootSelf then
      begin
        ParentVisible := CollectObjectInfo(Client, Info);
        if ParentVisible and (not IsCollected(Client)) then
          InfoList.Add(Info);
      end;
    Result := InfoList.Count;
  end;

begin
  if ([csDesigning, csDestroying, csLoading, csUpdating] * ComponentState <> []) or
     (FUpdating > 0) then Exit;
  { Update objects in form }
  try
    Comparer := TComparerTFmxObject.Create;
    ClientList := TTObjInfoList.Create(Comparer);
    Bucket := TDictionary<TObject, TObject>.Create;
    for InitiatedCount := 0 to 7 do
    begin
      if CollectActionClients(ClientList) = 0 then
        Break;
      ClientList.Sort;
      for I := 0 to ClientList.Count - 1 do
        TOpenFmxObject(ClientList[I].Obj).InitiateAction;
      ClientList.Clear;
    end;
  finally
    FreeAndNil(ClientList);
    FreeAndNil(Bucket);
  end;
end;

procedure TCommonCustomForm.ValidateRename(AComponent: TComponent; const CurName, NewName: string);
begin
  inherited;
{$IFDEF WIN32}
  if Assigned(FDesigner) then
    FDesigner.ValidateRename(AComponent, CurName, NewName);
{$ENDIF}
end;

procedure TCommonCustomForm.VirtualKeyboardChangeHandler(const Sender: TObject;
  const Msg: FMX.Messages.TMessage);
begin
  if TVKStateChangeMessage(Msg).KeyboardVisible and
    Assigned(FOnVirtualKeyboardShown) then
    FOnVirtualKeyboardShown(Self, true, TVKStateChangeMessage(Msg).KeyboardBounds)
  else if Assigned(FOnVirtualKeyboardHidden) then
    FOnVirtualKeyboardHidden(Self, false, TVKStateChangeMessage(Msg).KeyboardBounds);
end;

{ IRoot }

procedure TCommonCustomForm.DoAddObject(const AObject: TFmxObject);
var
  AlignObject: IAlignableObject;
begin
  inherited;
  if not Assigned(AObject) then
    Exit;
  AObject.SetRoot(Self);
  if Supports(AObject, IAlignableObject, AlignObject) and
    ((AlignObject.Align <> TAlignLayout.alNone) or (AlignObject.Anchors <> [TAnchorKind.akLeft, TAnchorKind.akTop])) then
    Realign;
end;

procedure TCommonCustomForm.DoClose(var CloseAction: TCloseAction);
begin
  if Assigned(FOnClose) then
    FOnClose(Self, CloseAction);
end;

procedure TCommonCustomForm.DoFocusChanged;
begin
  if Assigned(FOnFocusChanged) then
    FOnFocusChanged(Self);
end;

procedure TCommonCustomForm.DoHide;
begin
  if Assigned(FOnHide) then
    FOnHide(Self);
end;

procedure TCommonCustomForm.DoMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if Assigned(OnMouseDown) then
    OnMouseDown(Self, Button, Shift, X, Y);
end;

procedure TCommonCustomForm.DoMouseMove(Shift: TShiftState; X, Y: Single);
begin
  if Assigned(OnMouseMove) then
    OnMouseMove(Self, Shift, X, Y);
end;

procedure TCommonCustomForm.DoMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if Assigned(OnMouseUp) then
    OnMouseUp(Self, Button, Shift, X, Y);
end;

procedure TCommonCustomForm.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  if Assigned(OnMouseWheel) then
    OnMouseWheel(Self, Shift, WheelDelta, Handled);
end;

procedure TCommonCustomForm.DoShow;
begin
  if Assigned(FOnShow) then
    FOnShow(Self);
end;

procedure TCommonCustomForm.DoStyleChanged;
begin

end;

function TCommonCustomForm.GetObject: TFmxObject;
begin
  Result := Self;
end;

function TCommonCustomForm.GetActionLinkClass: TActionLinkClass;
begin
  Result := TFormActionLink;
end;

function TCommonCustomForm.GetActiveControl: IControl;
begin
  Result := FActiveControl;
end;

function TCommonCustomForm.GetBackIndex: Integer;
begin
  Result := 1;
end;

function TCommonCustomForm.GetBiDiMode: TBiDiMode;
begin
  Result := FBiDiMode;
end;

function TCommonCustomForm.GetCaptured: IControl;
begin
  Result := FCaptured;
end;

procedure TCommonCustomForm.SetCaptured(const Value: IControl);
begin
  if FCaptured <> Value then
  begin
    if Assigned(FCaptured) then
    begin
      ReleaseCapture;
      FCaptured.RemoveFreeNotify(Self);
    end;
    FCaptured := Value;
    if Assigned(FCaptured) then
    begin
      MouseCapture;
      FCaptured.AddFreeNotify(Self);
    end;
  end;
end;

function TCommonCustomForm.GetFocused: IControl;
begin
  Result := FFocused;
end;

function TCommonCustomForm.GetFullScreen: Boolean;
begin
  if (csDesigning in ComponentState) then
    Result := FFullScreen
  else
    Result := FWinService.GetFullScreen(Self);
end;

function TCommonCustomForm.GetHovered: IControl;
begin
  Result := FHovered;
end;

function TCommonCustomForm.NewFocusedControl(const Value: IControl): IControl;
var
  NewFocused: IControl;
  P: TFmxObject;
  NewCanFocus: Boolean;
begin
  Result := nil;
  if Assigned(Value) then
  begin
    NewFocused := Value;
    NewCanFocus := False;
    while (not NewCanFocus) and
          (Assigned(NewFocused)) and
          (NewFocused.Visible) and
          (NewFocused.GetCanParentFocus) do
    begin
      NewCanFocus := NewFocused.GetCanFocus;
      if (not NewCanFocus) then
      begin
        if (not Assigned(NewFocused.Parent)) or (not Supports(NewFocused.Parent, IControl, NewFocused)) then
          break;
      end;
    end;
    if Assigned(NewFocused) then
      NewCanFocus := NewFocused.GetCanFocus;
    if NewCanFocus then
    begin
      P := NewFocused.Parent;
      while Assigned(P) and (P.IsIControl) do
      begin
        if not P.AsIControl.Visible or not P.AsIControl.Enabled then
          Exit;
        P := P.Parent;
      end;
      if NewFocused.AbsoluteEnabled then
        Result := NewFocused;
    end;
  end;
end;

procedure TCommonCustomForm.SetFocused(const Value: IControl);
var
  TextInput: ITextInput;
  NewFocused: IControl;

  procedure NotifyToParent(AFocus, AEnterExit: Boolean);
  var
    P: TFmxObject;
    Ctrl: IControl;
  begin
    if (not FParentNote) then
    begin
      FParentNote := True;
      try
        P := FFocused.Parent;
        while P <> nil do
        begin
          if Supports(P, IControl, Ctrl) then
          begin
            if AEnterExit then
            begin
              if AFocus then
              begin
                if Ctrl.EnterChildren(FFocused) then
                  Break;
              end
              else
              begin
                if Ctrl.ExitChildren(FFocused) then
                  Break;
              end;
            end
            else
            begin
              Ctrl.IsChildFocused := AFocus;
            end;
          end;
          P := P.Parent;
        end;
      finally
        FParentNote := False;
      end;
    end;
  end;

begin
  if Assigned(Value) then
  begin
    NewFocused := NewFocusedControl(Value);
    if not Assigned(NewFocused) then
      raise EInvalidOperation.Create(StrCannotFocus);
  end
  else
    NewFocused := nil;
  if FFocused <> NewFocused then
  begin
    if Assigned(FFocused) then
    begin
      if not Supports(FFocused, ITextInput, TextInput) then
        TextInput := nil;
      FFocused.DoExit;
      try
        if Assigned(TextInput) then
          TextInput.GetTextService.ExitControl(Handle);
      except
        FFocused.DoEnter;
        raise;
      end;
      try
        if Assigned(FFocused) then
        begin
          FFocused.RemoveFreeNotify(Self);
          NotifyToParent(False, False);
          NotifyToParent(False, True);
        end;
      finally
        try
          HideCaret(FFocused);
        finally
          FFocused := nil;
        end;
      end;
    end;
    FFocused := NewFocused;
    try
      if Assigned(FFocused) then
      begin
        try
          if not Supports(FFocused, ITextInput, TextInput) then
            TextInput := nil;
          if Assigned(TextInput) then
            TextInput.GetTextService.EnterControl(Handle);
          try
            FFocused.DoEnter;
          except
            if Assigned(TextInput) then
              TextInput.GetTextService.ExitControl(Handle);
            raise;
          end;
        except
          FFocused := nil;
          raise;
        end;
        try
          ShowCaret(FFocused);
        finally
          FFocused.AddFreeNotify(Self);
          NotifyToParent(True, False);
          NotifyToParent(True, True);
        end;
      end;
    finally
      if (not Released) and
         ([csLoading, csDestroying] * ComponentState = []) then
        DoFocusChanged;
    end;
  end;
end;

procedure TCommonCustomForm.BeginInternalDrag(const Source: TObject; const ABitmap: FMX.Types.TBitmap);
var
  D: TDragObject;
  DDService: IFMXDragDropService;
begin
  Fillchar(D, SizeOf(D), 0);
  D.Source := Source;
  if TPlatformServices.Current.SupportsPlatformService(IFMXDragDropService, IInterface(DDService)) then
    DDService.BeginDragDrop(Self, D, ABitmap);
end;

procedure TCommonCustomForm.BeginUpdate;
var
  I: Integer;
begin
  FUpdating := FUpdating + 1;
  for I := 0 to ChildrenCount - 1 do
    if Children[I].IsIControl then
      Children[I].AsIControl.BeginUpdate;
end;

procedure TCommonCustomForm.SetActiveControl(const AControl: IControl);
begin
  if AControl <> FActiveControl then
  begin
    if Assigned(FActiveControl) then
      FActiveControl.RemoveFreeNotify(Self);
    FActiveControl := AControl;
    if Assigned(FActiveControl) then
      FActiveControl.AddFreeNotify(Self);
    if Assigned(FActiveControl) and not(csLoading in ComponentState) then
      FActiveControl.SetFocus;
  end;
end;

function TCommonCustomForm.GetShowFullScreenIcon: Boolean;
begin
  Result := FShowFullScreenIcon;
end;

function TCommonCustomForm.GetStyleBook: TStyleBook;
begin
  Result := FStyleBook;
  if Assigned(FStyleBook) and (FWinService.GetWindowScale(Self) > 1.0) and Assigned(FStyleBook.HiResStyleBook) then
    Result := FStyleBook.HiResStyleBook;
end;

procedure TCommonCustomForm.UpdateStyleBook;
begin
  FStyleBookChanged := False;
  FBorder.StyleChanged;
end;

procedure TCommonCustomForm.SetShowFullScreenIcon(const AValue: Boolean);
begin
  if FShowFullScreenIcon <> AValue then
  begin
    FShowFullScreenIcon := AValue;
    if not (csDesigning in ComponentState) then
      FWinService.SetShowFullScreenIcon(Self, FShowFullScreenIcon);
  end;
end;

procedure TCommonCustomForm.SetStyleBook(const Value: TStyleBook);
begin
  if FStyleBook <> Value then
  begin
    FStyleBook := Value;
    FStyleBookChanged := True;
    if not (csLoading in ComponentState) and not (csDestroying in ComponentState) then
      UpdateStyleBook;
  end;
end;

procedure TCommonCustomForm.SetStyleBookWithoutUpdate(const StyleBook: TStyleBook);
begin
  FStyleBook := StyleBook;
end;

{$IFDEF MSWINDOWS}

function TCommonCustomForm.GetDesignerMobile: Boolean;
begin
  Result := FDesignerMobile;
end;

procedure TCommonCustomForm.SetDesignerMobile(const Value: Boolean);
begin
  FDesignerMobile := Value;
end;

function TCommonCustomForm.GetDesignerDeviceName: string;
begin
  Result := FDesignerDeviceName;
end;

function TCommonCustomForm.GetDesignerHeight: Integer;
begin
  Result := FDesignerHeight;
end;

function TCommonCustomForm.GetDesignerOrientation: TFormOrientation;
begin
  Result := FDesignerOrientation;
end;

function TCommonCustomForm.GetDesignerWidth: Integer;
begin
  Result := FDesignerWidth;
end;

procedure TCommonCustomForm.SetDesignerDeviceName(const Value: string);
begin
  FDesignerDeviceName := Value;
end;

procedure TCommonCustomForm.SetDesignerHeight(const Value: Integer);
begin
  FDesignerHeight := Value;
end;

procedure TCommonCustomForm.SetDesignerOrientation(const Value: TFormOrientation);
begin
  FDesignerOrientation := Value;
end;

procedure TCommonCustomForm.SetDesignerWidth(const Value: Integer);
begin
  FDesignerWidth := Value;
end;

{$ENDIF}

{ TCustomForm }

destructor TCustomForm.Destroy;
begin
  FreeAndNil(FControls);
                                                                                       
  DeleteChildren;
//  if Assigned(FChildren) then
//    FreeAndNil(FChildren);
  if Assigned(FFill) then
    FreeAndNil(FFill);
  inherited;
end;

// Required to force Delphi-style initialization when used from C++.
constructor TCustomForm.Create(AOwner: TComponent);
begin
  inherited;
end;

constructor TCustomForm.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited;
end;

procedure TCustomForm.AddPreloadProperyNames(const PropertyNames: TList<string>);
begin
  inherited ;
  PropertyNames.Add('Quality');
end;

procedure TCustomForm.SetPreloadProperies(const PropertyStore: TDictionary<string, Variant>);
var
  Val: Variant;
begin
  inherited ;
  // Default
  FQuality := TCanvasQuality.ccSystemDefault;
  // Preload
  PropertyStore.TryGetValue('Quality', Val);
  if (Val <> Unassigned) and (Val <> Null) then
    FQuality := TCanvasQuality(GetEnumValue(TypeInfo(TCanvasQuality), Val));
end;

procedure TCustomForm.InitializeNewForm;
begin
  inherited;
  FStyleLookup := 'backgroundstyle';
  FNeedStyleLookup := True;
  FFill := TBrush.Create(TBrushKind.bkNone, TAlphaColors.White);
  FFill.OnChanged := FillChanged;
end;

function TCustomForm.IsStyleLookupStored: Boolean;
begin
  Result := not SameText(FStyleLookup, 'backgroundstyle');
end;

procedure TCustomForm.CreateHandle;
begin
  inherited;
  FCanvas := TCanvasManager.CreateFromWindow(Handle, ClientWidth, ClientHeight, FQuality);
end;

procedure TCustomForm.ResizeHandle;
begin
  inherited;
  if Assigned(FCanvas) and (ClientWidth > 0) and (ClientHeight > 0) then
  begin
    FCanvas.SetSize(ClientWidth, ClientHeight);
    Realign;
  end;
end;

procedure TCustomForm.DestroyHandle;
begin
  FreeAndNil(FCanvas);
  inherited;
end;

procedure TCustomForm.RecreateCanvas;
begin
  FreeAndNil(FCanvas);
  FCanvas := TCanvasManager.CreateFromWindow(Handle, ClientWidth, ClientHeight, FQuality);
end;

procedure TCustomForm.DoPaint(const Canvas: TCanvas; const ARect: TRectF);
begin
  if Assigned(FOnPaint) then
    FOnPaint(Self, Canvas, ClientRect);
end;

procedure TCustomForm.EndUpdate;
begin
  inherited;
  if FUpdating = 0 then
    Realign;
end;

procedure TCustomForm.AddUpdateRect(R: TRectF);
begin
  if csLoading in ComponentState then
    Exit;
  if csDestroying in ComponentState then
    Exit;
  if FDrawing then
    Exit;

  if Assigned(Canvas) and IntersectRect(R, TRectF.Create(0, 0, FCanvas.Width, FCanvas.Height))  then
  begin
    if Assigned(Canvas) and not (TCanvasStyle.SupportClipRects in Canvas.GetCanvasStyle) then
      InvalidateRect(RectF(0, 0, FCanvas.Width, FCanvas.Height))
    else
      InvalidateRect(R);
  end;
end;

procedure TCustomForm.ChangeScrollingState(const AControl: TControl; const Active: Boolean);
begin
  if TCanvasStyle.NeedGPUSurface in TCanvasManager.DefaultCanvas.GetCanvasStyle then
    TTextLayoutNG.DisableGlyphPopulation := Active;
end;

procedure TCustomForm.PaintRects(const UpdateRects: array of TRectF);
var
  I, J: Integer;
  R: TRectF;
  CallOnPaint, AllowPaint: Boolean;
  Control: TControl;
begin
  if not FDrawing then
  begin
    FDrawing := True;
    try
      if Assigned(FScrollControl) then
      begin
        SetLength(FUpdateRects, 1);
        FUpdateRects[0] := RectF(0, 0, Canvas.Width, Canvas.Height);
        if Canvas.BeginScene(@FUpdateRects, ContextHandle) then
        try
          TOpenControl(FScrollControl).PaintInternal;
        finally
          Canvas.EndScene;
        end;
        SetLength(FUpdateRects, 0);
      end
      else
      if Length(UpdateRects) > 0 then
      begin
        if TCanvasStyle.SupportClipRects in TCanvasManager.DefaultCanvas.GetCanvasStyle then
        begin
          SetLength(FUpdateRects, Length(FUpdateRects) + Length(UpdateRects));
        {$IFDEF NEXTGEN}
          for I := 0 to Length(UpdateRects) - 1 do
            FUpdateRects[Length(FUpdateRects) - Length(UpdateRects) + I] := UpdateRects[I];
        {$ELSE}
          Move(UpdateRects[0], FUpdateRects[Length(FUpdateRects) - Length(UpdateRects)], SizeOf(UpdateRects[0]) * Length(UpdateRects));
        {$ENDIF}
          { Split rects if rects too more }
          if (Length(FUpdateRects) > 20) then
          begin
            for I := 1 to High(FUpdateRects) do
              FUpdateRects[0] := UnionRect(FUpdateRects[0], FUpdateRects[I]);
            SetLength(FUpdateRects, 1);
          end;
        end
        else
        begin
          SetLength(FUpdateRects, 1);
          FUpdateRects[0] := RectF(0, 0, Canvas.Width, Canvas.Height);
        end;
        if Length(FUpdateRects) > 0 then
        begin
          try
            ApplyStyleLookup;
            { draw back }
            if Canvas.BeginScene(@FUpdateRects, ContextHandle) then
            try
              if (FFill.Kind = TBrushKind.bkNone) or ((FFill.Color and $FF000000 = 0) and
                 (FFill.Kind = TBrushKind.bkSolid)) then
              begin
                if not (TCanvasStyle.SupportClipRects in TCanvasManager.DefaultCanvas.GetCanvasStyle) then
                begin
                  if Transparency then
                    Canvas.Clear(0)
                  else
                    Canvas.Clear(FFill.Color and $FFFFFF);
                end else
                  for I := 0 to High(FUpdateRects) do
                    if Transparency then
                      Canvas.ClearRect(FUpdateRects[I], 0)
                    else
                      Canvas.ClearRect(FUpdateRects[I], FFill.Color and $FFFFFF);
              end else
              begin
                if Transparency then
                begin
                  if not (TCanvasStyle.SupportClipRects in TCanvasManager.DefaultCanvas.GetCanvasStyle) then
                    Canvas.Clear(0)
                  else
                    for I := 0 to High(FUpdateRects) do
                      Canvas.ClearRect(FUpdateRects[I], 0);
                end;
                Canvas.FillRect(RectF(0, 0, Width, Height), 0, 0, AllCorners, 1, FFill);
              end;
              { children }
              CallOnPaint := False;
              if Assigned(FControls) then
                for I := 0 to FControls.Count - 1 do
                  if (FControls[I].Visible) or (not FControls[I].Visible and (csDesigning in ComponentState) and not FControls[I].Locked) then
                  begin
                    Control := FControls[I];
                    if (Control = FResourceLink) then
                    begin
                      if Self.Transparency then Continue;
                      if (Self.Fill.Kind <> TBrushKind.bkNone) then Continue;
                      if (Self.Fill.Kind = TBrushKind.bkSolid) and (Self.Fill.Color <> Fill.DefaultColor) then Continue;
                    end;
                    if (csDesigning in Control.ComponentState) and not Control.DesignVisible then
                      Continue;
                    if Control.UpdateRect.IsEmpty then
                      Continue;
                    AllowPaint := False;
                    if (csDesigning in ComponentState) or Control.InPaintTo then
                      AllowPaint := True;
                    if not AllowPaint then
                    begin
                      R := UnionRect(Control.ChildrenRect, Control.UpdateRect);
                      for J := 0 to High(FUpdateRects) do
                        if IntersectRect(FUpdateRects[J], R) then
                        begin
                          AllowPaint := True;
                          Break;
                        end;
                      end;
                      if AllowPaint then
                        TOpenControl(Control).PaintInternal;
                      { Call OnPaint after style painted }
                      if (Control = FResourceLink) then
                      begin
                        Self.Canvas.SetMatrix(IdentityMatrix);
                        Self.DoPaint(Self.Canvas, ClientRect);
                        CallOnPaint := True;
                      end;
                  end;
                { Call OnPaint if style not loaded }
                if not CallOnPaint then
                begin
                  Canvas.SetMatrix(IdentityMatrix);
                  DoPaint(Canvas, ClientRect);
                end;
                {$IFDEF MSWINDOWS}
                { draw grid }
                if (csDesigning in ComponentState) and Assigned(Designer) then
                begin
                  Canvas.SetMatrix(IdentityMatrix);
                  Designer.PaintGrid;
                end;
                {$ENDIF}
            finally
              Canvas.EndScene;
            end;
          finally
            SetLength(FUpdateRects, 0);
          end;
        end;
      end;
    finally
      FDrawing := False;
    end;
  end;
end;

procedure TCustomForm.PaintTo(const Canvas: TCanvas);
begin
  FTempCanvas := Canvas;
  try
    PaintRects([RectF(0, 0, FCanvas.Width, FCanvas.Height)]);
  finally
    FTempCanvas := nil;
  end;
end;

procedure TCustomForm.Realign;
begin
  if not (csDesigning in ComponentState) then
  begin
    if FLastWidth <= 0 then
      FLastWidth := GetOriginalContainerSize.X;
    if FLastHeight <= 0 then
      FLastHeight := GetOriginalCOntainerSize.Y;
  end;
  if Assigned(FCanvas) then
  begin
    AlignObjects(Self, Padding, FCanvas.Width, FCanvas.Height, FLastWidth, FLastHeight, FDisableAlign);
    InvalidateRect(ClientRect);
  end;
end;

procedure TCustomForm.DoAddObject(const AObject: TFmxObject);
begin
  inherited;
  if not Assigned(AObject) then
    Exit;
  if AObject is TControl then
  begin
    TControl(AObject).SetNewScene(Self);

    TOpenControl(AObject).RecalcOpacity;
    TOpenControl(AObject).RecalcAbsolute;
    TOpenControl(AObject).RecalcUpdateRect;
    TOpenControl(AObject).RecalcHasClipParent;

    if not Assigned(FControls) then
    begin
      FControls := TControlList.Create;
      FControls.Capacity := 10;
    end;
    FControls.Add(TControl(AObject));

    if (TControl(AObject).Align = TAlignLayout.alNone) then
      TControl(AObject).Repaint;
  end;
end;

procedure TCustomForm.DoDeleteChildren;
begin
  inherited;
  if Assigned(FControls) then
    FreeAndNil(FControls);
end;

procedure TCustomForm.DoRemoveObject(const AObject: TFmxObject);
begin
  inherited;
  if AObject is TControl then
  begin
    if Assigned(FControls)  then
      FControls.Remove(TControl(AObject));

    if not (csDestroying in ComponentState) then
    begin
      if Assigned(Canvas) and (TCanvasStyle.SupportClipRects in Canvas.GetCanvasStyle) then
        AddUpdateRect(TControl(AObject).UpdateRect)
      else
        Invalidate;
    end;
    TControl(AObject).SetNewScene(nil);
  end;
end;

procedure TCustomForm.ChangeChildren;
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
    while C < FControls.Count do
    begin
      Inc(Changes);
      FControls.Delete(FControls.Count - 1);
    end;
    if Changes > 0 then
      Realign;
  end;
end;

procedure TCustomForm.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
end;

procedure TCustomForm.SetActiveHDControl(const Value: TControl);
begin
  SetActiveControl(Value);
end;

procedure TCustomForm.SetFill(const Value: TBrush);
begin
  FFill.Assign(Value);
end;

procedure TCustomForm.SetQuality(const Value: TCanvasQuality);
begin
  if FQuality <> Value then
  begin
    FQuality := Value;
    if not (csLoading in ComponentState) then
      RecreateCanvas;
  end;
end;

procedure TCustomForm.SetStyleLookup(const Value: string);
begin
  FStyleLookup := Value;
  FNeedStyleLookup := True;
  if not (csLoading in ComponentState) then
    ApplyStyleLookup;
end;

procedure TCustomForm.UpdateStyleBook;
begin
  TMessageManager.DefaultManager.SendMessage(nil, TStyleChangedMessage.Create(nil), True);
  inherited;
end;

procedure TCustomForm.FillChanged(Sender: TObject);
begin
  SetLength(FUpdateRects, 0);
  AddUpdateRect(RectF(0, 0, ClientWidth, ClientHeight));
end;

function TCustomForm.GetCanvas: TCanvas;
begin
  if Assigned(FTempCanvas) then
    Result := FTempCanvas
  else
    Result := FCanvas;
end;

function TCustomForm.GetUpdateRectsCount: Integer;
begin
  Result := Length(FUpdateRects);
end;

function TCustomForm.GetWindowStyle: TWindowStyles;
begin
  if TCanvasStyle.NeedGPUSurface in TCanvasManager.DefaultCanvas.GetCanvasStyle then
    Result := inherited GetWindowStyle + [TWindowStyle.wsGPUSurface]
  else
    Result := inherited GetWindowStyle;
end;

function TCustomForm.GetUpdateRect(const Index: Integer): TRectF;
begin
  Result := FUpdateRects[Index];
end;

function TCustomForm.GetStyleObject: TControl;
var
  Obj: TFmxObject;
  ResourceObject: TControl;
  SB: TStyleBook;
  StyleName: string;
begin
  ResourceObject := nil;
  if (FStyleLookup <> '') then
  begin
    { style }
    Obj := nil;
    SB := GetStyleBook;
    if Assigned(SB) and Assigned(SB.Style) then
      Obj := TControl(SB.Style.FindStyleResource(FStyleLookup));
    if not Assigned(Obj) then
      if Assigned(TStyleManager.ActiveStyleForScene(Self)) then
        Obj := TControl(TStyleManager.ActiveStyleForScene(Self).FindStyleResource(FStyleLookup));
    if Not Assigned(Obj) then
      Obj := FMX.Types.FindStyleResource(FStyleLookup);
    if Assigned(Obj) and (Obj is TControl) then
    begin
      ResourceObject := TControl(Obj.Clone(nil));
      ResourceObject.StyleName := '';
    end;
  end;
  if not Assigned(ResourceObject) then
  begin
    if FStyleLookup <> '' then
    begin
      StyleName := FStyleLookup;
      ResourceObject := TControl(FindStyleResource(StyleName));
      if Assigned(ResourceObject) then
        ResourceObject := TControl(ResourceObject.Clone(nil));
    end;
    if not Assigned(ResourceObject) then
    begin
      StyleName := ClassName + 'style';
      StyleName := StyleName.Remove(0, 1);
      ResourceObject := TControl(FindStyleResource(StyleName));
      if Assigned(ResourceObject) then
        ResourceObject := TControl(ResourceObject.Clone(nil));
    end;
  end;
  if not Assigned(ResourceObject) and Assigned(TStyleManager.ActiveStyle) then
  begin
    if FStyleLookup <> '' then
    begin
      StyleName := FStyleLookup;
      ResourceObject := TControl(TStyleManager.ActiveStyle.FindStyleResource(StyleName));
      if Assigned(ResourceObject) then
        ResourceObject := TControl(ResourceObject.Clone(nil));
    end;
    if not Assigned(ResourceObject) then
    begin
      StyleName := ClassName + 'style';
      StyleName := StyleName.Remove(0, 1);
      ResourceObject := TControl(TStyleManager.ActiveStyle.FindStyleResource(StyleName));
      if Assigned(ResourceObject) then
        ResourceObject := TControl(ResourceObject.Clone(nil))
      else
      begin
        // try parent Class
        StyleName := ClassParent.ClassName + 'style';
        StyleName := StyleName.Remove(0, 1);
        ResourceObject := TControl(TStyleManager.ActiveStyle.FindStyleResource(StyleName));
        if Assigned(ResourceObject) then
          ResourceObject := TControl(ResourceObject.Clone(nil));
      end;
    end;
  end;
  Result := ResourceObject;
end;

procedure TCustomForm.ApplyStyleLookup;
var
  ResourceObject: TControl;
begin
  if FNeedStyleLookup then
  begin
    FNeedStyleLookup := False;
    ResourceObject := GetStyleObject;
    if Assigned(ResourceObject) then
    begin
      if Assigned(FResourceLink) then
      begin
        FResourceLink.Release;
        FResourceLink := nil;
      end;
      ResourceObject.Align := TAlignLayout.alContents;
      ResourceObject.DesignVisible := True;
      FResourceLink := ResourceObject;
      AddObject(ResourceObject);
      { bring to front }
      RemoveObject(ResourceObject);
      InsertObject(0, ResourceObject);
      Realign;
      { }
      ResourceObject.Stored := False;
      ResourceObject.Lock;
    end;
  end;
end;

function TCustomForm.GetSceneScale: Single;
begin
  Result := FWinService.GetWindowScale(Self);
end;

procedure TCustomForm.DoStyleChanged;
begin
  if csLoading in ComponentState then
    Exit;
  if csDestroying in ComponentState then
    Exit;
  FNeedStyleLookup := True;
  if not (csLoading in ComponentState) then
    ApplyStyleLookup;
end;

function TCustomForm.GetActiveHDControl: TControl;
begin
  if Assigned(FActiveControl) and (FActiveControl.GetObject is TControl) then
    Result := TControl(FActiveControl.GetObject)
  else
    Result := nil;
end;

procedure TCustomForm.DoScaleChanged;
begin
  inherited;
  DoStyleChanged;
end;

function TCustomForm.ScreenToLocal(P: TPointF): TPointF;
begin
  Result := ScreenToClient(P);
end;

function TCustomForm.LocalToScreen(P: TPointF): TPointF;
begin
  Result := ClientToScreen(P);
end;

{ TFrame }

constructor TFrame.Create(AOwner: TComponent);
begin
  inherited;
  EnableExecuteAction := False;
  if (ClassType <> TFrame) and not (csDesignInstance in ComponentState) then
  begin
    if not InitInheritedComponent(Self, TFrame) then
      raise EResNotFound.CreateFmt(SResNotFound, [ClassName]);
  end
  else
  begin
    Width := 320;
    Height := 240;
  end;
end;

procedure TFrame.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  OwnedComponent: TComponent;
begin
  inherited GetChildren(Proc, Root);
  if Root = Self then
    for I := 0 to ComponentCount - 1 do
    begin
      OwnedComponent := Components[I];
      if not OwnedComponent.HasParent then Proc(OwnedComponent);
    end;
end;

procedure TFrame.Loaded;
begin
  inherited;
  if (csDesigning in ComponentState) and not (DesignInfo = 0) then
  begin
    Position.X := LongRec(DesignInfo).Lo;
    Position.Y := LongRec(DesignInfo).Hi;
    DesignInfo := 0;
  end;
end;

procedure TFrame.Paint;
var
  R: TRectF;
begin
  inherited;
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

{ TScreen }

constructor TScreen.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // Let VCL manage datamodules if it is around
  if (not Assigned(System.Classes.AddDataModule))
    and (not Assigned(System.Classes.RemoveDataModule)) then
  begin
    System.Classes.AddDataModule := AddDataModule;
    System.Classes.RemoveDataModule := RemoveDataModule;
    FManagingDataModules := True
  end
  else
    FManagingDataModules := False;

  FForms := TList<TCommonCustomForm>.Create;
  FDataModules := TList<TDataModule>.Create;
end;

procedure TScreen.AddDataModule(DataModule: TDataModule);
begin
  FDataModules.Add(DataModule);
end;

procedure TScreen.AddForm(const AForm: TCommonCustomForm);

  function FindUniqueFormName(const Name: string): string;
  var
    I: Integer;
  begin
    I := 0;
    Result := Name;
    while FindGlobalComponent(Result) <> nil do
    begin
      Inc(I);
      Result := Format('%s_%d', [Name, I]);
    end;
  end;

begin
  if Length(AForm.Name) = 0 then
    AForm.Name := FindUniqueFormName('form')
  else
    AForm.Name := FindUniqueFormName(AForm.Name);
  FForms.Add(AForm);
end;

procedure TScreen.RemoveDataModule(DataModule: TDataModule);
begin
  FDataModules.Remove(DataModule);
end;

procedure TScreen.RemoveForm(const AForm: TCommonCustomForm);
begin
  FForms.Remove(AForm);
end;

function TScreen.IndexFormOfObject(Obj: TFmxObject; VisibleOnly: boolean = True): integer;
var
  I: Integer;
begin
  Result := -1;
  if Obj <> nil then
  begin
    while Obj.Parent <> nil do
      Obj := Obj.Parent;
    if Obj is TCommonCustomForm then
      for I := 0 to FormCount - 1 do
      if (Forms[I] = Obj) and ((not VisibleOnly) or (Forms[I].Visible)) then
      begin
        Result := I;
        Break;
      end;
  end;
end;

function TScreen.MousePos: TPointF;
var
  MouseSvc: IFMXMouseService;
begin
  if not TPlatformServices.Current.SupportsPlatformService(IFMXMouseService, IInterface(MouseSvc)) then
    raise EUnsupportedPlatformService.Create('IFMXMouseService');
  Result := MouseSvc.GetMousePos;
end;

function TScreen.NextActiveForm(const OldActiveForm: TCommonCustomForm): TCommonCustomForm;
var
  I, CurrIndex: integer;
begin
  Result := nil;
  CurrIndex := IndexFormOfObject(OldActiveForm);
  I := FormCount - 1;
  while (I >= 0) and (I <> CurrIndex) and (not Forms[I].Visible) do Dec(I);
  if (I < 0) or (I = CurrIndex) then
  begin
    I := 0;
    while (I < FormCount) and (I <> CurrIndex) and (not Forms[I].Visible) do Inc(I);
  end;
  if (I < FormCount) and (I <> CurrIndex) then
  begin
    Result := Forms[I];
    ActiveForm := Result;
  end;
end;

function TScreen.GetActiveForm: TCommonCustomForm;
var
  I: integer;
begin
  Result := nil;
  if self <> nil then
  for I := FormCount - 1 downto 0 do
    if (Forms[I].Visible) and (Forms[I].Active) then
    begin
      Result := Forms[I];
      Break;
    end;
end;

procedure TScreen.SetActiveForm(const Value: TCommonCustomForm);
var
  NewActiveForm: TCommonCustomForm;
  I: Integer;
begin
  if Assigned(Value) then
  begin
    if not Value.Released then
  begin
    I := IndexFormOfObject(Value);
    if I < 0 then
      raise EInvalidFmxHandle.Create(sArgumentInvalid);
    NewActiveForm := Forms[I];
    if (not NewActiveForm.Active) and (I < FormCount - 1) then
    begin
      FForms.Delete(I);
      FForms.Add(NewActiveForm);
    end;
    for I := 0 to FormCount - 1 do
      if Forms[I] <> NewActiveForm then
        Forms[I].Deactivate;
    if not NewActiveForm.Active then
      NewActiveForm.Activate;
  end;
  end
  else
  begin
    for I := 0 to FormCount - 1 do
      Forms[I].Deactivate;
  end
end;

function TScreen.Size: TSize;
var
  ScreenService: IFMXScreenService;
  P: TPointF;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, IInterface(ScreenService)) then
  begin
    P := ScreenService.GetScreenSize;
    Result.cx := Round(P.X);
    Result.cy := Round(P.Y);
  end
  else
  begin
    Result.cx := 0;
    Result.cy := 0;
  end;
end;

function TScreen.GetFocusObject: TFmxObject;
var
  LForm: TCommonCustomForm;
begin
  Result := nil;
  if Self <> nil then
  begin
    LForm := GetActiveForm;
    if (LForm <> nil) and (LForm.Focused <> nil) then
      Result := LForm.Focused.GetObject;
  end;
end;

function TScreen.GetFocusControl: IControl;
var
  LForm: TCommonCustomForm;
begin
  Result := nil;
  if Self <> nil then
  begin
    LForm := GetActiveForm;
    if (LForm <> nil) and (LForm.Focused <> nil) then
      Result := LForm.Focused;
  end;
end;

function TScreen.GetObjectByTarget(const Target: TObject): TFmxObject;
var
  TargetControl: IControl;
begin
  Result := nil;
  if Assigned(Target) then
  begin
    // 1. Target as IControl
    if Supports(Target, IControl, TargetControl) then
      Result := TargetControl.GetObject;
    // 2. Target as Form
    if (not Assigned(Result)) and (Target is TCommonCustomForm) then
      Result := TCommonCustomForm(Target);
  end;

  if (not Assigned(Result)) and (Self <> nil) then
  begin
    // 3. FocusControl
    if Assigned(FocusControl) then
      Result := FocusControl.GetObject;
    // 4. ActiveForm
    if (not Assigned(Result)) then
      Result := ActiveForm;
  end;
  // 5. MainForm
  if (Result = nil) and (Assigned(Application)) then
    Result := Application.MainForm;
end;

function TScreen.GetDataModule(Index: Integer): TDataModule;
begin
  Result := FDataModules[Index];
end;

function TScreen.GetDataModuleCount: Integer;
begin
  Result := FDataModules.Count;
end;

function TScreen.GetForm(Index: Integer): TCommonCustomForm;
begin
  Result := FForms[Index];
end;

function TScreen.GetFormCount: Integer;
begin
  Result := FForms.Count;
end;

destructor TScreen.Destroy;
begin
  FreeAndNil(FDataModules);
  FreeAndNil(FForms);

  if FManagingDataModules then
  begin
    System.Classes.AddDataModule := nil;
    System.Classes.RemoveDataModule := nil;
  end;

  inherited Destroy;
end;

function FindGlobalComponent(const Name: string): TComponent;
var
  I: Integer;
begin
  for I := 0 to Screen.FormCount - 1 do
  begin
    Result := Screen.Forms[I];
    if not (csInline in Result.ComponentState) and
      (CompareText(Name, Result.Name) = 0) then Exit;
  end;
  for I := 0 to Screen.DataModuleCount - 1 do
  begin
    Result := Screen.DataModules[I];
    if CompareText(Name, Result.Name) = 0 then Exit;
  end;
  Result := nil;
end;

{ TFormFactor }

constructor TFormFactor.Create;
var
  ScreenSize : TPoint;
begin
  inherited Create;

  ScreenSize := TPoint.Create(320, 480);

  FSize := TSize.Create(ScreenSize.X, ScreenSize.Y);
  FOrientations := [TFormOrientation.soPortrait, TFormOrientation.soLandscape];
  FDevices := [Low(TDeviceKind)..High(TDeviceKind)];
end;

procedure TFormFactor.AdjustToScreenSize;
var
  ScreenService: IFMXScreenService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, IInterface(ScreenService)) then
  begin
    Width := ScreenService.GetScreenSize.Truncate.X;
    Height := ScreenService.GetScreenSize.Truncate.Y;
  end;
end;

procedure TFormFactor.SetHeight(const Value: Integer);
begin
  FSize.cy := Value;
end;

procedure TFormFactor.SetWidth(const Value: Integer);
begin
  FSize.cx := Value;
end;

function TFormFactor.GetWidth : Integer;
begin
  Result := FSize.cx;
end;

function TFormFactor.GetHeight : Integer;
begin
  Result := FSize.cy;
end;

procedure TFormFactor.SetSupportedOrientations(AOrientations: TFormOrientations);
begin
  FOrientations := AOrientations;
end;

procedure FinalizeForms;
begin
  FreeControls;
  TStyleManager.UnInitialize;
  TFilterManager.UnInitialize;
  TBitmapCodecManager.UnInitialize;
  TTextLayoutManager.UnInitialize;
  TCanvasManager.UnInitialize;
  TContextManager.UnInitialize;
  TShaderManager.UnInitialize;
end;

function PropertyValuesFromStream(const ComponentName: string; const Properties: array of string; const Input: TStream): TArray<Variant>;
var
  PropValues: TDictionary<string, Variant>;
  Reader: TReader;
  ObjectName, PropName: string;
  FoundComponent, FoundProperty: Boolean;
  FoundValue: TList<Variant>;

  procedure ConvertValue; forward;

  procedure ConvertHeader(RootComponent: Boolean);
  var
    ClassName: string;
    Flags: TFilerFlags;
    Position: Integer;
  begin
    Reader.ReadPrefix(Flags, Position);
    ClassName := Reader.ReadStr;
    ObjectName := Reader.ReadStr;
    if (RootComponent and (ComponentName = '')) or SameText(ComponentName, ObjectName) then
      FoundComponent := True;
    if ObjectName = '' then
      ObjectName := ClassName;
  end;

  procedure AddValue(const V: Variant);
  begin
    if FoundProperty then
      FoundValue.Add(V);
  end;

  procedure ConvertProperty; forward;

  procedure ConvertValue;
  const
    LineLength = 64;
  var
    I: Integer;
    S, V: string;
  begin
    case Reader.NextValue of
      vaList:
        begin
          Reader.ReadValue;
          while not Reader.EndOfList do
            ConvertValue;
          Reader.ReadListEnd;
        end;
      vaInt8, vaInt16, vaInt32:
        AddValue(Reader.ReadInteger);
      vaExtended:
        AddValue(Reader.ReadFloat);
      vaDouble:
        AddValue(Reader.ReadDouble);
      vaSingle:
        AddValue(Reader.ReadSingle);
      vaCurrency:
        AddValue(Reader.ReadCurrency);
      vaDate:
        AddValue(Reader.ReadDate);
      vaWString, vaUTF8String, vaString, vaLString:
        AddValue(Reader.ReadString);
      vaIdent, vaFalse, vaTrue, vaNil, vaNull:
        AddValue(Reader.ReadIdent);
      vaBinary:
        Reader.SkipValue;
      vaSet:
        begin
          Reader.ReadValue;
          I := 0;
          V := '';
          while True do
          begin
            S := Reader.ReadStr;
            if S = '' then Break;
            if I > 0 then V := V + ', ';
            V := V + S;
            Inc(I);
          end;
          AddValue(V);
        end;
      vaCollection:
        begin
          Reader.ReadValue;
          while not Reader.EndOfList do
          begin
            if Reader.NextValue in [vaInt8, vaInt16, vaInt32] then
              ConvertValue;
            Reader.CheckValue(vaList);
            while not Reader.EndOfList do
              ConvertProperty;
            Reader.ReadListEnd;
          end;
          Reader.ReadListEnd;
        end;
      vaInt64:
        AddValue(Reader.ReadInt64);
    else
      raise EReadError.CreateResFmt(@sPropertyException,
        [ObjectName, DotSep, PropName, IntToStr(Ord(Reader.NextValue))]);
    end;
  end;

  procedure ConvertProperty;
  var
    SaveFound: Boolean;
    Name: string;
  begin
    SaveFound := FoundProperty;
    try
      PropName := Reader.ReadStr;
      Name := PropName;
      FoundProperty := FoundComponent and PropValues.ContainsKey(PropName);
      FoundValue.Clear;
      ConvertValue;
      if FoundValue.Count > 1 then
      else if FoundValue.Count > 0 then
        PropValues[Name] := FoundValue[0];
    finally
      FoundProperty := SaveFound;
    end;
  end;

  procedure ConvertObject(RootComponent: Boolean);
  begin
    ConvertHeader(RootComponent);
    while not Reader.EndOfList do
      ConvertProperty;
    Reader.ReadListEnd;
    if not FoundComponent then
    begin
      while not Reader.EndOfList do
      begin
        ConvertObject(False);
        if FoundComponent then
          Exit;
      end;
      Reader.ReadListEnd;
    end;
  end;

var
  I: Integer;
  InternalInput: TStream;
  Format: TStreamOriginalFormat;
begin
  FoundComponent := False;
  FoundProperty := False;
  FoundValue := TList<Variant>.Create;
  Format := TStreamOriginalFormat.sofUnknown;
  try
    GlobalNameSpace.BeginWrite;
    InternalInput := TMemoryStream.Create;
    try
      ObjectTextToBinary(Input, InternalInput, Format);
      InternalInput.Position := 0;
      Reader := TReader.Create(InternalInput, 4096);
      try
        PropValues := TDictionary<string, Variant>.Create;
        try
          for I := Low(Properties) to High(Properties) do
            PropValues.Add(Properties[I], System.Variants.Null);
          Reader.ReadSignature;
          ConvertObject(True);
          SetLength(Result, Length(Properties));
          for I := Low(Properties) to High(Properties) do
            Result[I] := PropValues[Properties[I]];
        finally
          PropValues.Free;
        end;
      finally
        Reader.Free;
      end;
    finally
      InternalInput.Free;
    end;
  finally
    FoundValue.Free;
    GlobalNameSpace.EndWrite;
  end;
end;

function ReadResource(const FormClass: TClass; const PropertyNames: array of string; const PropertyStore : TDictionary<string, Variant>) : Boolean;
var
  HInst : Cardinal;
  ResourceStream: TResourceStream;
  PeekedValues : TArray<Variant>;
  I : Integer;
begin
  Result := True;

  if FormClass = TComponent then Exit;

  ReadResource(FormClass.ClassParent, PropertyNames, PropertyStore);
  HInst := FindClassHInstance(FormClass);
  if HInst = 0 then HInst := HInstance;
  if FindResource(HInst, PChar(FormClass.ClassName), PChar(RT_RCDATA)) = 0 then Exit;

  ResourceStream := TResourceStream.Create(
                             HInst,
                             FormClass.ClassName, RT_RCDATA);
  try
    PeekedValues := PropertyValuesFromStream('',
                                PropertyNames,
                                ResourceStream);

    for I := 0 to Length(PropertyNames) - 1 do
    begin
      if PeekedValues[I] <> Null then
      begin
        if PropertyStore.ContainsKey(PropertyNames[I]) then
          PropertyStore.Remove(PropertyNames[I]);
        PropertyStore.Add(PropertyNames[I], PeekedValues[I]);
      end;
    end;
  finally
    ResourceStream.Free;
  end;
end;

{ TVKStateChangeMessage }

constructor TVKStateChangeMessage.Create(AKeyboardShown: Boolean; const Bounds: TRect);
begin
  FKeyboardShown := AKeyboardShown;
  FBounds := Bounds;
end;

initialization
  RegisterFmxClasses([TApplication, TFormFactor], [TApplication, TFormFactor]);
  Screen := TScreen.Create(nil);
  System.Classes.RegisterFindGlobalComponentProc(FindGlobalComponent);
finalization
  FinalizeForms;
  System.Classes.UnregisterFindGlobalComponentProc(FindGlobalComponent);
  FreeAndNil(Screen);
  TPlatformServices.UnInitialize;
end.
