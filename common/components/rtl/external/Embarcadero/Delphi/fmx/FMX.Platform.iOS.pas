{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Platform.iOS;

interface

uses FMX.Types, FMX.Platform, FMX.Forms, Macapi.ObjectiveC, iOSapi.UIKit, iOSapi.GLKit;

const
  FMXStartChangeDeviceOrientation = 'FMXWillAnimateRotationToInterfaceOrientation';

type

  TiOSWindowHandle = class(TWindowHandle)
  private
    FHandle: TOCLocal;
    function GetView: UIView;
    function GetGLView: GLKView;
    function GetForm: TCommonCustomForm;
  public
    constructor Create(const AHandle: TOCLocal);
    property View: UIView read GetView;
    property GLView: GLKView read GetGLView;
    property Form: TCommonCustomForm read GetForm;
    property Handle: TOCLocal read FHandle;
  end;

  TiOSOpenApplicationContext = class
  private
    FSourceApp: string;
    FURL: string;
    FContext: Pointer;
  public
    constructor Create(ASourceApp: string; AURL: string; AContext: Pointer);
    property SourceApp: string read FSourceApp;
    property URL: string read FURL;
    property Context: Pointer read FContext;
  end;

function WindowHandleToPlatform(const AHandle: TWindowHandle): TiOSWindowHandle;

procedure RegisterCorePlatformServices;
procedure UnregisterCorePlatformServices;

implementation

uses
  System.Classes, System.SysUtils, System.Types, System.UITypes, System.TypInfo, System.SyncObjs, System.Rtti,
  System.Math, System.UIConsts, FMX.Controls,
  FMX.Dialogs, FMX.Menus, iOSapi.CocoaTypes, iOSapi.Foundation, iOSapi.CoreGraphics,
  Macapi.ObjCRuntime, Macapi.CoreFoundation, {System.RegularExpressions,} System.StrUtils, iOSapi.QuartzCore,
  iOSapi.OpenGLES, System.Variants, FMX.Consts, System.Generics.Collections,
  FMX.Canvas.iOS,
  FMX.Canvas.GPU,
  FMX.Context.GLES,
  FMX.Controls.iOS,
  FMX.Pickers, FMX.TextLayout, FMX.Text, FMX.Styles, FMX.VirtualKeyboard, FMX.Gestures, FMX.Gestures.iOS,
  FMX.Layouts, FMX.StdCtrls, FMX.Objects;

const
  DBL_TAP_DELAY = 0.3; // Sec, Duration between first and second tap (Apple recommend use this value)

type
{$M+}

  id = Pointer;
  SEL = Pointer;
  PUIApplication = Pointer;
  PNSDictionary = Pointer;

  FMXViewController = interface(UIViewController)
    ['{FB1283E6-B1AB-419F-B331-160096B10C62}']
    function shouldAutorotateToInterfaceOrientation(AinterfaceOrientation: UIInterfaceOrientation): Boolean; cdecl;
    function shouldAutorotate: Boolean; cdecl;
    function supportedInterfaceOrientations: NSUInteger; cdecl;
    procedure didReceiveMemoryWarning; cdecl;
    procedure didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation); cdecl;
    procedure viewDidAppear(animated: Boolean); cdecl;
    procedure viewWillAppear(animated: Boolean); cdecl;
    procedure viewWillDisappear(animated: Boolean); cdecl;
    procedure viewDidLayoutSubviews; cdecl;
    procedure willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation; duration: NSTimeInterval); cdecl;
  end;

  TFMXViewController = class(TOCLocal)
  protected
    function GetObjectiveCClass: PTypeInfo; override;
  public
    constructor Create;
    function shouldAutorotateToInterfaceOrientation(AinterfaceOrientation: UIInterfaceOrientation): Boolean; cdecl;
    function shouldAutorotate: Boolean; cdecl;
    function supportedInterfaceOrientations: NSUInteger; cdecl;
    procedure didReceiveMemoryWarning; cdecl;
    procedure didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation); cdecl;
    procedure viewDidAppear(animated: Boolean); cdecl;
    procedure viewWillAppear(animated: Boolean); cdecl;
    procedure viewWillDisappear(animated: Boolean); cdecl;
    procedure viewDidLayoutSubviews; cdecl;
    procedure willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation; duration: NSTimeInterval); cdecl;
  end;

  FMXWindow = interface(UIWindow)
    ['{B0EB8A41-2F1D-43DF-9207-25E3ACE7E08A}']
  end;

  TFMXWindow = class(TOCLocal)
  protected
    function GetObjectiveCClass: PTypeInfo; override;
  public
    Text: UITextField;
    RootView: UIView;
    RootViewController: TFMXViewController;
    constructor Create(const ABounds: NSRect); overload;
  end;

  TApplicationDelegate = class{(TOCLocal, UIApplicationDelegate)}
  private
    FMainWindow: TFMXWindow;
  public
    procedure application(Sender: UIApplication; didChangeStatusBarFrame: CGRect); overload; cdecl;
    procedure application(Sender: UIApplication; didChangeStatusBarOrientation: UIInterfaceOrientation); overload; cdecl;
    procedure application(Sender: UIApplication; didFailToRegisterForRemoteNotificationsWithError: NSError); overload; cdecl;
    function application(Sender: UIApplication; didFinishLaunchingWithOptions: NSDictionary): Boolean; overload; cdecl;
    procedure application(Sender: UIApplication; didReceiveLocalNotification: UILocalNotification); overload; cdecl;
//    procedure application(Sender: UIApplication; didReceiveRemoteNotification: NSDictionary); cdecl; overload;
    procedure application(Sender: UIApplication; didRegisterForRemoteNotificationsWithDeviceToken: NSData); overload; cdecl;
    function application(Sender: UIApplication; handleOpenURL: NSURL): Boolean; overload; cdecl;
    function application(Sender: UIApplication; openURL: NSURL; sourceApplication: NSString; annotation: Pointer): Boolean; overload; cdecl;
//    procedure application(Sender: UIApplication; willChangeStatusBarFrame: CGRect); cdecl; overload;
    procedure application(const Sender: UIApplication; const willChangeStatusBarOrientation: UIInterfaceOrientation; const duration: NSTimeInterval); overload; cdecl;
    procedure applicationDidBecomeActive(const Sender: UIApplication); cdecl;
    procedure applicationDidEnterBackground(const Sender: UIApplication); cdecl;
//    procedure applicationDidFinishLaunching(Sender: UIApplication); cdecl;
    procedure applicationDidReceiveMemoryWarning(Sender: UIApplication); cdecl;
    procedure applicationProtectedDataDidBecomeAvailable(Sender: UIApplication); cdecl;
    procedure applicationProtectedDataWillBecomeUnavailable(Sender: UIApplication); cdecl;
    procedure applicationSignificantTimeChange(Sender: UIApplication); cdecl;
    procedure applicationWillEnterForeground(Sender: UIApplication); cdecl;
    procedure applicationWillResignActive(Sender: UIApplication); cdecl;
    procedure applicationWillTerminate(Sender: UIApplication); cdecl;
    procedure setWindow(window: UIWindow); cdecl;
    function window: UIWindow; cdecl;
    property MainWindow: TFMXWindow read FMainWindow;
  end;

  { TPlatformCocoaTouch }

  TPlatformCocoaTouch = class(TInterfacedObject , IFMXApplicationService, IFMXSystemFontService,
    IFMXTimerService, IFMXWindowService, IFMXClipboardService, IFMXScreenService,
    IFMXLocaleService, IFMXDialogService, IFMXTextService, IFMXContextService, IFMXCanvasService,
    IFMXDeviceService, IFMXStyleService, IFMXStyleHiResService, IFMXSystemInformationService,
    IFMXImageGeneratorService, IFMXLoggingService, IFMXApplicationEventService,
    IFMXDefaultMetricsService, IFMXDefaultPropertyValueService)
  private
    UIApp: UIApplication;
    FMainScreen: UIScreen;
    FCurrentDevice: UIDevice;
    FAppDelegate: TApplicationDelegate;
    FIdleTimer: TFmxHandle;
    FHandleCounter: TFmxHandle;
    FObjectiveCMap: TDictionary<TFmxHandle, IObjectiveC>;
    FObjectMap: TDictionary<TFmxHandle, TObject>;
    FTimers: TList<TFmxHandle>;
    FFormHandle: TWindowHandle;
    FTerminating: Boolean;
    FOnApplicationEvent: TApplicationEventHandler;
    FRotationView: UIImageView;
    FRotationViewAnimated: Boolean;
    function NewFmxHandle: TFmxHandle;
    procedure ValidateHandle(FmxHandle: TFmxHandle);
    function AllocObjectHandle(const Objc: TObject): TFmxHandle;
    procedure DeleteObjectHandle(const FmxHandle: TFmxHandle);
    function HandleToObject(const FmxHandle: TFmxHandle): TObject;
    procedure ResetIdleTimer;
    procedure IdleTimerFunc;
    procedure InternalWaitMessage(AInterval: Single);
    function IsPopupForm(const AForm: TCommonCustomForm): Boolean;
    procedure InitializeFormFactor(FormFactor: TFormFactor);
//    procedure DoReleaseWindow(AForm: TCommonCustomForm);
  public
    constructor Create;
    destructor Destroy; override;
    { IFMXApplicationService }
    procedure Run;
    procedure Terminate;
    function HandleMessage: Boolean;
    procedure WaitMessage;
    function GetTitle: string;
    function Terminating: Boolean;
    { IFMXSystemFontService }
    function GetDefaultFontFamilyName: string;
    { IFMXTimerService }
    function CreateTimer(Interval: Integer; TimerFunc: TTimerProc): TFmxHandle;
    function DestroyTimer(Timer: TFmxHandle): Boolean;
    function GetTick: Extended;
    { IFMXWindowService }
    function FindForm(const AHandle: TWindowHandle): TCommonCustomForm;
    function CreateWindow(const AForm: TCommonCustomForm): TWindowHandle;
    procedure DestroyWindow(const AForm: TCommonCustomForm);
    procedure ReleaseWindow(const AForm: TCommonCustomForm);
    procedure ShowWindow(const AForm: TCommonCustomForm);
    procedure HideWindow(const AForm: TCommonCustomForm);
    procedure BringToFront(const AForm: TCommonCustomForm);
    procedure SendToBack(const AForm: TCommonCustomForm);
    procedure Activate(const AForm: TCommonCustomForm);
    function ShowWindowModal(const AForm: TCommonCustomForm): TModalResult;
    procedure InvalidateWindowRect(const AForm: TCommonCustomForm; R: TRectF);
    procedure InvalidateImmediately(const AForm: TCommonCustomForm);
    procedure SetWindowRect(const AForm: TCommonCustomForm; ARect: TRectF);
    function GetWindowRect(const AForm: TCommonCustomForm): TRectF;
    function GetClientSize(const AForm: TCommonCustomForm): TPointF;
    procedure SetClientSize(const AForm: TCommonCustomForm; const ASize: TPointF);
    procedure SetWindowCaption(const AForm: TCommonCustomForm; const ACaption: string);
    procedure SetCapture(const AForm: TCommonCustomForm);
    procedure SetWindowState(const AForm: TCommonCustomForm; const AState: TWindowState);
    procedure ReleaseCapture(const AForm: TCommonCustomForm);
    function ClientToScreen(const AForm: TCommonCustomForm; const Point: TPointF): TPointF;
    function ScreenToClient(const AForm: TCommonCustomForm; const Point: TPointF): TPointF;
    function GetWindowScale(const AForm: TCommonCustomForm): Single;
    procedure SetFullScreen(const AForm: TCommonCustomForm; const AValue: Boolean);
    function GetFullScreen(const AForm: TCommonCustomForm): Boolean;
    procedure SetShowFullScreenIcon(const AForm: TCommonCustomForm; const AValue: Boolean);
    { IFMXClipboardService }
    procedure SetClipboard(Value: TValue);
    function GetClipboard: TValue;
    { IFMXScreenService }
    function GetScreenSize: TPointF;
    function GetScreenScale: Single;
    function GetScreenOrientation: TScreenOrientation;
    { IFMXLocaleService }
    function GetCurrentLangID: string;
    function GetLocaleFirstDayOfWeek: string;
    { IFMXDialogService }
    function DialogOpenFiles(var AFileName: TFileName; const AInitDir, ADefaultExt, AFilter, ATitle: string;
      var AFilterIndex: Integer; var AFiles: TStrings; var AOptions: TOpenOptions): Boolean;
    function DialogPrint(var ACollate, APrintToFile: Boolean;
      var AFromPage, AToPage, ACopies: Integer; AMinPage, AMaxPage: Integer; var APrintRange: TPrintRange;
      AOptions: TPrintDialogOptions): Boolean;
    function PageSetupGetDefaults(var AMargin, AMinMargin: TRect; var APaperSize: TPointF;
      AUnits: TPageMeasureUnits; AOptions: TPageSetupDialogOptions): Boolean;
    function DialogPageSetup(var AMargin, AMinMargin :TRect; var APaperSize: TPointF;
      var AUnits: TPageMeasureUnits; AOptions: TPageSetupDialogOptions): Boolean;
    function DialogSaveFiles(var AFileName: TFileName; const AInitDir, ADefaultExt, AFilter, ATitle: string;
      var AFilterIndex: Integer; var AFiles: TStrings; var AOptions: TOpenOptions): Boolean;
    function DialogPrinterSetup: Boolean;
    function MessageDialog(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons;
      DefaultButton: TMsgDlgBtn; X, Y: Integer; HelpCtx: Longint; const HelpFileName: string): Integer;
    function InputQuery(const ACaption: string; const APrompts: array of string;
      var AValues: array of string; CloseQueryFunc: TInputCloseQueryFunc = nil): Boolean;
    { IFMXTextService }
    function GetTextServiceClass: TTextServiceClass;
    { IFMXContextService }
    procedure RegisterContextClasses;
    procedure UnregisterContextClasses;
    { IFMXCanvasService }
    procedure RegisterCanvasClasses;
    procedure UnregisterCanvasClasses;
    { IFMXDeviceService }
    function GetModel: string;
    { IFMXStyleService }
    function GetSystemStyle: TFmxObject;
    { IFMXStyleHiResService }
    function GetSystemStyleHiRes: TFmxObject;
    { }
//    property RootViewController: TFMXViewController read FRootViewController write FRootViewController;
    property AppDelegate: TApplicationDelegate read FAppDelegate;
    { IFMXSystemInformationService }
    function GetScrollingBehaviour: TScrollingBehaviours;
    function GetMinScrollThumbSize: Single;
    function GetCaretWidth: Integer;
    { IFMXImageGeneratorService }
    function GenerateTabIcon(const ASource, ADest: TBitmap; const IsSelected, HiRes: Boolean): Boolean;
    procedure Log(Fmt: String; Params: array of const);
     { IFMXApplicationEventService }
    procedure SetApplicationEventHandler(AEventHandler: TApplicationEventHandler);
    function HandleApplicationEvent(AEvent: TApplicationEvent; AContext: TObject): Boolean;
    { IFMXDefaultMetricsService }
    function SupportsDefaultSize(const AComponent: TComponentKind): Boolean;
    function GetDefaultSize(const AComponent: TComponentKind): TSize;
    { IFMXDefaultPropertyValueService }
    function GetDefaultPropertyValue(const AClassName, PropertyName: string): TValue;

  end;

(*
{$M+}
  TFMXWindow = class;
  TTextServiceCocoa = class;
*)

  FMXTextPosition = interface(UITextPosition)
    ['{771836F3-8AC3-4DBB-B3D2-2F8AF5669B26}']
  end;

  TFMXTextPosition = class(TOCLocal)
  private
    FPosition: Integer;
  public
    constructor Create(AValue: Integer);
    function GetObjectiveCClass: PTypeInfo; override;
    property Position: Integer read FPosition write FPosition;
  end;

  FMXTextRange = interface(UITextRange)
    ['{72F2910F-D4F9-4A1E-B5C8-38A62206A883}']
    function isEmpty: Boolean; cdecl;
    function start: UITextPosition; cdecl;
    function &end: UITextPosition; cdecl;
  end;

  TFMXTextRange = class(TOCLocal)
  private
    FRange: NSRange;
  public
    constructor Create(const ALocation, ALength: Integer);
    function GetObjectiveCClass: PTypeInfo; override;
    function isEmpty: Boolean; cdecl;
    function start: UITextPosition; cdecl;
    function &end: UITextPosition; cdecl;
  end;

{ TFMXEditActionsMenu }

  TStandartActionType = (satUnknow, satCut, satCopy, satPaste, satSelect,
                         satSelectAll, satPromptForReplace, satReplace);

  /// <summary>
  ///   Context menu with standart edit actions: Cut, Copy, Past, Select, SelectAll
  /// </summary>
  TFMXEditActionsMenu = class abstract
  strict private
    FParentView: UIView;
    procedure SetControl(const AControl: TControl);
  protected
    FMenuController: UIMenuController;
    [weak] FControl: TControl;
    FReplaceMenu: Boolean;
    procedure DoControlChanged; virtual;
    procedure DoDefineSelectionFrame(var Frame: CGRect); virtual;
  public
    constructor Create(const AParentView: UIView);
    destructor Destroy; override;
    /// <summary>
    ///   Do we need to show action in the context menu in the current conditions?
    /// </summary>
    function CanPerformAction(const AAction: SEL): Boolean; virtual; abstract;
    function DefineActionType(const AAction: SEL): TStandartActionType;
    procedure Show;
    procedure Hide;
    function IsVisible: Boolean;
    function HasControl: Boolean;
    { Standart Actions }
    procedure Cut; virtual; abstract;
    procedure Copy; virtual; abstract;
    procedure Paste; virtual; abstract;
    procedure Select; virtual; abstract;
    procedure SelectAll; virtual; abstract;
    procedure PromptForReplace; virtual; abstract;
    property Control: TControl read FControl write SetControl;
  end;

{ TFMXTextEditActionsMenu }

  /// <summary>
  ///   Implemented context menu with standart edit actions for text controls
  /// </summary>
  TFMXTextEditActionsMenu = class (TFMXEditActionsMenu)
  private
    FTextInput: ITextInput;
    FTextActions: ITextActions;
  protected
    procedure DoControlChanged; override;
    procedure DoDefineSelectionFrame(var Frame: CGRect); override;
    function GetClipboardService: IFMXClipboardService;
  public
    function CanPerformAction(const AAction: SEL): Boolean; override;
    procedure Cut; override;
    procedure Copy; override;
    procedure Paste; override;
    procedure Select; override;
    procedure SelectAll; override;
    procedure PromptForReplace; override;
  end;

  TFMXViewBase = class(TOCLocal, UIKeyInput, UITextInput, UITextInputTraits, UIGestureRecognizerDelegate)
  private
    FGestureControl: TFmxObject;
    function GetTouchCoord(const touches: NSSet; const Window: UIView; var x, y: single): Boolean;
    procedure InitRecognizers;
    procedure DoLMouseUp(const X, Y: Single);
    procedure DoLMouseDown(const X, Y: Single);
    procedure DoLMouseMove(const X, Y: Single);
    procedure DefineFocusControl;
  protected
    FContextMenu: TFMXTextEditActionsMenu;
    FCarretPositionChanged: Boolean;
    FLastCaretPosition: TPoint;
    FLastContextMenuVisibility: Boolean;
    FClickedAnotherControl: Boolean;
    FChangedFocusedControl: Boolean;
    FText: string;
    [weak]FForm: TCommonCustomForm;
    FSelectRange: NSRange;
    FMarkText: string;
    FMarkRange: NSRange;
    FKeyboardType: TVirtualKeyboardType;
    FDown: Boolean;
    destructor Destroy; override;
  public
    constructor Create(const AForm: TCommonCustomForm);
    { UIView overrides }
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesCancelled(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesMoved(touches: NSSet; withEvent: UIEvent); cdecl;
    function canBecomeFirstResponder: Boolean; cdecl;
    function canResignFirstResponder: Boolean; cdecl;
    function isFirstResponder: Boolean; cdecl;
    function canPerformAction(action: SEL; withSender: Pointer): Boolean; cdecl;
    function isAccessibilityElement: Boolean; cdecl;
    { Touch Actions }
    procedure SingleTap(Sender: id); cdecl;
    procedure LongTap(gestureRecognizer: UILongPressGestureRecognizer); cdecl;
    procedure DblTap(X, Y: Single);
    { UIGestureRecognizerDelegate }
    function gestureRecognizer(gestureRecognizer: UIGestureRecognizer; shouldReceiveTouch: UITouch): Boolean; overload; cdecl;
    function gestureRecognizer(gestureRecognizer: UIGestureRecognizer; shouldRecognizeSimultaneouslyWithGestureRecognizer: UIGestureRecognizer): Boolean; overload; cdecl;
    function gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer): Boolean; cdecl;
    { GestureRecognizer }
    procedure handlePan(gestureRecognizer: UIPanGestureRecognizer); cdecl;
    procedure handleRotate(gestureRecognizer: UIRotationGestureRecognizer); cdecl;
    procedure handleTwoFingerTap(gestureRecognizer: UITapGestureRecognizer); cdecl;
    procedure handleZoom(gestureRecognizer: UIPinchGestureRecognizer); cdecl;
    { Cut, Copy, Paste, Replace, SpellChecker Actions }
    procedure cut(Sender: id); cdecl;
    procedure copy(Sender: id); cdecl;
    procedure paste(Sender: id); cdecl;
    procedure select(Sender: id); cdecl;
    procedure selectAll(Sender: id); cdecl;
    { Context Menu Showing }
    procedure ShowContextMenu;
    procedure HideContextMenu;
    { UIKeyInput }
    procedure deleteBackward; cdecl;
    function hasText: Boolean; cdecl;
    procedure insertText(text: NSString); cdecl;
    { UITextInput }
    function baseWritingDirectionForPosition(position: UITextPosition; inDirection: UITextStorageDirection): UITextWritingDirection; cdecl;
    function beginningOfDocument: UITextPosition; cdecl;
    function endOfDocument: UITextPosition; cdecl;
    function inputDelegate: Pointer; cdecl;
    function markedTextRange: UITextRange; cdecl;
    function markedTextStyle: NSDictionary; cdecl;
    function selectedTextRange: UITextRange; cdecl;
    procedure setBaseWritingDirection(writingDirection: UITextWritingDirection; forRange: UITextRange); cdecl;
    procedure setInputDelegate(inputDelegate: Pointer); cdecl;
    procedure setMarkedText(markedText: NSString; selectedRange: NSRange); cdecl;
    procedure setMarkedTextStyle(markedTextStyle: NSDictionary); cdecl;
    procedure setSelectedTextRange(selectedTextRange: UITextRange); cdecl;
    { Returning and replacing text by text range }
    function textInRange(range: UITextRange): NSString; cdecl;
    procedure replaceRange(range: UITextRange; withText: NSString); cdecl;
    { Computing text ranges and text positions }
    function positionFromPosition(position: UITextPosition; offset: NSInteger): UITextPosition; overload; cdecl;
    function positionFromPosition(position: UITextPosition; inDirection: UITextLayoutDirection; offset: NSInteger): UITextPosition; overload; cdecl;
    function textRangeFromPosition(fromPosition: UITextPosition; toPosition: UITextPosition): UITextRange; cdecl;
    { Evaluating text positions }
    function comparePosition(position: UITextPosition; toPosition: UITextPosition): NSComparisonResult; cdecl;
    function offsetFromPosition(from: UITextPosition; toPosition: UITextPosition): NSInteger; cdecl;
    { Answering layout questions }
    function positionWithinRange(range: UITextRange; farthestInDirection: UITextLayoutDirection): UITextPosition; cdecl; //overload;
    function characterRangeByExtendingPosition(position: UITextPosition; inDirection: UITextLayoutDirection): UITextRange; cdecl;
    { Hit-testing }
    function closestPositionToPoint(point: CGPoint): UITextPosition; overload; cdecl;
    function closestPositionToPoint(point: CGPoint; withinRange: UITextRange): UITextPosition; overload; cdecl;
    function characterRangeAtPoint(point: CGPoint): UITextRange; cdecl;
    { Returning rectangles for text ranges and text positions }
    function firstRectForRange(range: UITextRange): CGRect; cdecl;
    function caretRectForPosition(position: UITextPosition): CGRect; cdecl;

    function tokenizer: Pointer; cdecl;
    procedure unmarkText; cdecl;
    { UITextInputTraits }
    function autocapitalizationType: UITextAutocapitalizationType; cdecl;
    function autocorrectionType: UITextAutocorrectionType; cdecl;
    function enablesReturnKeyAutomatically: Boolean; cdecl;
    function isSecureTextEntry: Boolean; cdecl;
    function keyboardAppearance: UIKeyboardAppearance; cdecl;
    function keyboardType: UIKeyboardType; cdecl;
    function returnKeyType: UIReturnKeyType; cdecl;
    procedure setAutocapitalizationType(autocapitalizationType: UITextAutocapitalizationType); cdecl;
    procedure setAutocorrectionType(autocorrectionType: UITextAutocorrectionType); cdecl;
    procedure setEnablesReturnKeyAutomatically(enablesReturnKeyAutomatically: Boolean); cdecl;
    procedure setKeyboardAppearance(keyboardAppearance: UIKeyboardAppearance); cdecl;
    procedure setKeyboardType(keyboardType: UIKeyboardType); cdecl;
    procedure setReturnKeyType(returnKeyType: UIReturnKeyType); cdecl;
    procedure setSecureTextEntry(secureTextEntry: Boolean); cdecl;
    procedure setSpellCheckingType(spellCheckingType: Integer); cdecl;
    function spellCheckingType: Integer; cdecl;
    property Form: TCommonCustomForm read FForm;
  end;

  FMXView = interface(UIView)
    ['{0A6E8339-D32C-4A5F-BDD1-4CC3A711CF01}']
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesCancelled(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesMoved(touches: NSSet; withEvent: UIEvent); cdecl;
    function canBecomeFirstResponder: Boolean; cdecl;
    function canResignFirstResponder: Boolean; cdecl;
    function canPerformAction(action: SEL; withSender: Pointer): Boolean; cdecl;
    function isFirstResponder: Boolean; cdecl;
    procedure drawRect(R: CGRect); cdecl;
    { Cut, Copy, Paste }
    procedure cut(Sender: id); cdecl;
    procedure copy(Sender: id); cdecl;
    procedure paste(Sender: id); cdecl;
    procedure select(Sender: id); cdecl;
    procedure selectAll(Sender: id); cdecl;
    { Touches }
    procedure SingleTap(Sender: id); cdecl;
    procedure LongTap(gestureRecognizer: UILongPressGestureRecognizer); cdecl;
    procedure handlePan(gestureRecognizer: UIPanGestureRecognizer); cdecl;
    procedure handleRotate(gestureRecognizer: UIRotationGestureRecognizer); cdecl;
    procedure handleTwoFingerTap(gestureRecognizer: UITapGestureRecognizer); cdecl;
    procedure handleZoom(gestureRecognizer: UIPinchGestureRecognizer); cdecl;
    { Accessibility }
    function isAccessibilityElement: Boolean; cdecl;
  end;

  TFMXView = class(TFMXViewBase, UIKeyInput, UITextInput, UITextInputTraits)
  public
    constructor Create(const AOwner: TCommonCustomForm; AFRameRect: NSRect);
    function GetObjectiveCClass: PTypeInfo; override;
    procedure drawRect(R: CGRect); cdecl;
  end;

  FMXView3D = interface(GLKView)
    ['{CC0FB04D-56B0-446D-9464-F18D1B4AFE22}']
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesCancelled(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesMoved(touches: NSSet; withEvent: UIEvent); cdecl;
    function canBecomeFirstResponder: Boolean; cdecl;
    function canResignFirstResponder: Boolean; cdecl;
    function canPerformAction(action: SEL; withSender: Pointer): Boolean; cdecl;
    function isFirstResponder: Boolean; cdecl;
    procedure drawRect(R: CGRect); cdecl;
    { Cut, Copy, Paste }
    procedure cut(Sender: id); cdecl;
    procedure copy(Sender: id); cdecl;
    procedure paste(Sender: id); cdecl;
    procedure select(Sender: id); cdecl;
    procedure selectAll(Sender: id); cdecl;
    { Touches }
    procedure SingleTap(Sender: id); cdecl;
    procedure LongTap(gestureRecognizer: UILongPressGestureRecognizer); cdecl;
    procedure handlePan(gestureRecognizer: UIPanGestureRecognizer); cdecl;
    procedure handleRotate(gestureRecognizer: UIRotationGestureRecognizer); cdecl;
    procedure handleTwoFingerTap(gestureRecognizer: UITapGestureRecognizer); cdecl;
    procedure handleZoom(gestureRecognizer: UIPinchGestureRecognizer); cdecl;
    { Accessibility }
    function isAccessibilityElement: Boolean; cdecl;
  end;

  TFMXView3D = class(TFMXViewBase, UIKeyInput, UITextInput, UITextInputTraits, UIGestureRecognizerDelegate)
  private
  public
    constructor Create(const AOwner: TCommonCustomForm; AFRameRect: NSRect);
    function GetObjectiveCClass: PTypeInfo; override;
    procedure drawRect(R: CGRect); cdecl;
  end;

  { TTextServiceCocoa }
  TTextServiceCocoa = class (TTextService)
  private
    FView: TFMXViewBase;
    FCaretPostion: TPoint;
    FText : string;
    FMarkedText : string;
    FImeMode: TImeMode;
    FCursorShift: Integer;
  protected
    function GetText: string; override;
    procedure SetText(const Value: string); override;
    function GetCaretPostion: TPoint; override;
    procedure SetCaretPosition(const Value: TPoint); override;
    procedure SetCursorShift(const Value: Integer);
  public
    procedure InternalSetMarkedText( const AMarkedText: string ); override;
    function InternalGetMarkedText: string; override;
    procedure InternalStartIMEInput;
    procedure InternalBreakIMEInput;
    procedure InternalEndIMEInput;

    function CombinedText: string; override;
    function TargetClausePosition: TPoint; override;

    procedure EnterControl(const FormHandle: TWindowHandle); override;
    procedure ExitControl(const FormHandle: TWindowHandle); override;

    procedure DrawSingleLine(const  Canvas: TCanvas;
      const ARect: TRectF; const FirstVisibleChar: integer; const Font: TFont;
      const AOpacity: Single; const Flags: TFillTextFlags; const ATextAlign: TTextAlign;
      const AVTextAlign: TTextAlign = TTextAlign.taCenter;
      const AWordWrap: Boolean = False); overload;  override;

    procedure DrawSingleLine(const Canvas: TCanvas;
      const S: string;
      const ARect: TRectF;
      const Font: TFont;
      const AOpacity: Single; const Flags: TFillTextFlags; const ATextAlign: TTextAlign;
      const AVTextAlign: TTextAlign = TTextAlign.taCenter;
      const AWordWrap: Boolean = False); overload; override;

    function HasMarkedText: Boolean; override;

    function GetImeMode: TImeMode; override;
    procedure SetImeMode(const Value: TImeMode); override;

    { Selection }
    procedure BeginSelection; override;
    procedure EndSelection; override;

    { Cocoa }
  private
    FSelectedRange: NSRange;
  public
    constructor Create(const Owner: IControl; SupportMultiLine: Boolean); override;
    destructor Destroy; override;
    procedure SetSelectedRange(const Value: NSRange);
  end;

var
  PlatformCocoa: TPlatformCocoaTouch;

procedure RegisterCorePlatformServices;
begin
  PlatformCocoa := TPlatformCocoaTouch.Create;
  TPlatformServices.Current.AddPlatformService(IFMXApplicationService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXApplicationEventService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXSystemFontService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXTimerService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXWindowService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXClipboardService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXScreenService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXLocaleService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXDialogService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXTextService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXContextService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXCanvasService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXDeviceService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXStyleService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXStyleHiResService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXSystemInformationService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXImageGeneratorService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXLoggingService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXDefaultMetricsService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXDefaultPropertyValueService, PlatformCocoa);
end;

procedure UnregisterCorePlatformServices;
begin
end;

// Application delegates

procedure applicationDidChangeStatusBarFrame(self: id; _cmd: SEL; application: PUIApplication;
  frame: CGRect); cdecl;
begin

end;

procedure applicationdidChangeStatusBarOrientation(self: id; _cmd: SEL; application: PUIApplication;
  orientation: UIInterfaceOrientation); cdecl;
begin

end;

function applicationDidFinishLaunchingWithOptions(self: id; _cmd: SEL;
  application: PUIApplication; options: PNSDictionary): Boolean; cdecl;
begin
  Result := PlatformCocoa.FAppDelegate.application(TUIApplication.Wrap(application), TNSDictionary.Wrap(options));
end;

procedure applicationDidReceiveLocalNotification(self: id; _cmd: SEL; application: PUIApplication;
  notification: Pointer); cdecl;
begin

end;

procedure applicationDidBecomeActive(self: id; _cmd: SEL; application: PUIApplication); cdecl;
begin
  PlatformCocoa.FAppDelegate.applicationDidBecomeActive(TUIApplication.Wrap(application));
end;

procedure applicationDidEnterBackground(self: id; _cmd: SEL; application: PUIApplication); cdecl;
begin
  // This is called.
  PlatformCocoa.FAppDelegate.applicationDidEnterBackground(TUIApplication.Wrap(application));
end;

procedure applicationWillEnterForeground(self: id; _cmd: SEL; application: PUIApplication); cdecl;
begin
  PlatformCocoa.FAppDelegate.applicationWillEnterForeground(TUIApplication.Wrap(application));
end;

procedure applicationWillResignActive(self: id; _cmd: SEL; application: PUIApplication); cdecl;
begin
  // This seems not to be called.
end;

procedure applicationWillTerminate(self: id; _cmd: SEL; application: PUIApplication); cdecl;
begin
  PlatformCocoa.FAppDelegate.applicationWillTerminate(TUIApplication.Wrap(application));
end;

procedure applicationDidReceiveMemoryWarning(self: id; _cmd: SEL; application: PUIApplication); cdecl;
begin
  PlatformCocoa.FAppDelegate.applicationDidReceiveMemoryWarning(TUIApplication.Wrap(application));
end;

procedure setWindow(self: id; _cmd: SEL; window: Pointer); cdecl;
begin

end;

function window(self: id; _cmd: SEL): Pointer; cdecl;
begin
  Result := nil;
end;

{ TApplicationDelegate }

procedure TApplicationDelegate.application(Sender: UIApplication;
  didRegisterForRemoteNotificationsWithDeviceToken: NSData);
begin

end;

procedure TApplicationDelegate.application(Sender: UIApplication;
  didReceiveLocalNotification: UILocalNotification);
begin

end;

function TApplicationDelegate.application(Sender: UIApplication;
  handleOpenURL: NSURL): Boolean;
begin
  Result := application(Sender, handleOpenURL, NSSTR(''), nil);
end;

procedure TApplicationDelegate.application(const Sender: UIApplication;
  const willChangeStatusBarOrientation: UIInterfaceOrientation;
  const duration: NSTimeInterval);
begin

end;

function TApplicationDelegate.application(Sender: UIApplication;
  openURL: NSURL; sourceApplication: NSString; annotation: Pointer): Boolean;
begin
  Result := PlatformCocoa.HandleApplicationEvent(TApplicationEvent.aeOpenURL,
      TiOSOpenApplicationContext.Create(UTF8ToString(sourceApplication.UTF8String),
        UTF8ToString(openURL.absoluteString.UTF8String), annotation));
end;

procedure TApplicationDelegate.application(Sender: UIApplication;
  didChangeStatusBarFrame: CGRect);
begin

end;

procedure TApplicationDelegate.application(Sender: UIApplication;
  didChangeStatusBarOrientation: UIInterfaceOrientation);
begin

end;

function TApplicationDelegate.application(Sender: UIApplication; didFinishLaunchingWithOptions: NSDictionary): Boolean;
var
  UIWin: UIWindow;
  LBounds: NSRect;
begin
  PlatformCocoa.UIApp := Sender;
  { create window }
  FMainWindow := TFMXWindow.Create(TUIScreen.Wrap(TUIScreen.OCClass.mainScreen).bounds);
  UIWin := UIWindow(FMainWindow.Super);
  UIWin.setAutoresizesSubviews(True);
  UIWin.makeKeyAndVisible;
  { }
  LBounds := UIWin.bounds;
  FMainWindow.RootView := TUIView.Alloc;
  FMainWindow.RootView := TUIView.Wrap(FMainWindow.RootView.initWithFrame(TUIScreen.Wrap(TUIScreen.OCClass.mainScreen).bounds));
  FMainWindow.RootView.setAutoResizesSubviews(True);
  FMainWindow.RootView.setOpaque(True);
  FMainWindow.RootViewController := TFMXViewController.Create;
  UIWin.setRootViewController(UIViewController(FMainWindow.RootViewController.Super));
  UIViewController(FMainWindow.RootViewController.Super).setView(FMainWindow.RootView);
  UIWin.addSubview(FMainWindow.RootView);
  { }
  FMX.Forms.Application.RealCreateForms;
  TUIDevice.Wrap(TUIDevice.OCClass.currentDevice).beginGeneratingDeviceOrientationNotifications;
  Result := True;
end;

procedure TApplicationDelegate.application(Sender: UIApplication;
  didFailToRegisterForRemoteNotificationsWithError: NSError);
begin

end;

procedure TApplicationDelegate.applicationDidBecomeActive(const Sender: UIApplication);
begin
  PlatformCocoa.HandleApplicationEvent(TApplicationEvent.aeBecameActive, nil);
end;

procedure TApplicationDelegate.applicationDidEnterBackground(const Sender: UIApplication);
begin
  PlatformCocoa.HandleApplicationEvent(TApplicationEvent.aeEnteredBackground, nil);
end;

procedure TApplicationDelegate.applicationDidReceiveMemoryWarning(Sender: UIApplication);
begin
  PlatformCocoa.HandleApplicationEvent(TApplicationEvent.aeLowMemory, nil);
end;

procedure TApplicationDelegate.applicationProtectedDataDidBecomeAvailable(Sender: UIApplication);
begin

end;

procedure TApplicationDelegate.applicationProtectedDataWillBecomeUnavailable(Sender: UIApplication);
begin

end;

procedure TApplicationDelegate.applicationSignificantTimeChange(Sender: UIApplication);
begin
  PlatformCocoa.HandleApplicationEvent(TApplicationEvent.aeTimeChange, nil);
end;

procedure TApplicationDelegate.applicationWillEnterForeground(Sender: UIApplication);
begin
  PlatformCocoa.HandleApplicationEvent(TApplicationEvent.aeWillBecomeForeground, nil);
end;

procedure TApplicationDelegate.applicationWillResignActive(Sender: UIApplication);
begin
  PlatformCocoa.HandleApplicationEvent(TApplicationEvent.aeWillBecomeInactive, nil);
end;

procedure TApplicationDelegate.applicationWillTerminate(Sender: UIApplication);
begin
  PlatformCocoa.HandleApplicationEvent(TApplicationEvent.aeWillTerminate, nil);
end;

procedure TApplicationDelegate.setWindow(window: UIWindow);
begin

end;

function TApplicationDelegate.window: UIWindow;
begin
  Result := nil;
end;

{ TPlatformCocoaTouch }

constructor TPlatformCocoaTouch.Create;
var
  appDelegateClass: Pointer;
begin
  inherited;
  FAppDelegate := TApplicationDelegate.Create;
  Application := TApplication.Create(nil);
  InitializeFormFactor(Application.FormFactor);
  FMainScreen := TUIScreen.Wrap(TUIScreen.OCClass.mainScreen);
  FCurrentDevice := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);

  // Set up application delegate manually for now

  // Create a class to serve as our application delegate
  appDelegateClass := objc_allocateClassPair(objc_getClass('NSObject'), 'DelphiAppDelegate', 0);

  // Add the UIApplciationDelegate protocol
  class_addProtocol(appDelegateClass, objc_getProtocol('UIApplicationDelegate'));

  // Add the "finish launching" delegate method
  class_addMethod(appDelegateClass, sel_getUid('application:didFinishLaunchingWithOptions:'),
    @applicationDidFinishLaunchingWithOptions, 'v@:@@');

  // Add additional application delegate methods
  class_addMethod(appDelegateClass, sel_getUid('applicationDidEnterBackground:'),
    @applicationDidEnterBackground, 'v@:@');
  class_addMethod(appDelegateClass, sel_getUid('applicationWillResignActive:'),
    @applicationWillResignActive, 'v@:@');
  class_addMethod(appDelegateClass, sel_getUid('applicationDidBecomeActive:'),
    @applicationDidBecomeActive, 'v@:@');
  class_addMethod(appDelegateClass, sel_getUid('application:didChangeStatusBarFrame:'),
    @applicationDidChangeStatusBarFrame, 'v@:@{CGRect={CGPoint=ff}{CGSize=ff}}');
  class_addMethod(appDelegateClass, sel_getUid('application:didChangeStatusBarOrientation:'),
    @applicationdidChangeStatusBarOrientation, 'v@:@l');
  class_addMethod(appDelegateClass, sel_getUid('application:didReceiveLocalNotification:'),
    @applicationDidReceiveLocalNotification, 'v@:@@');
  class_addMethod(appDelegateClass, sel_getUid('applicationWillEnterForeground:'),
    @applicationWillEnterForeground, 'v@:@');
  class_addMethod(appDelegateClass, sel_getUid('applicationWillTerminate:'),
    @applicationWillTerminate, 'v@:@');
  class_addMethod(appDelegateClass, sel_getUid('applicationDidReceiveMemoryWarning:'),
    @applicationDidReceiveMemoryWarning, 'v@:@');
  class_addMethod(appDelegateClass, sel_getUid('setWindow:'), @setWindow, 'v@:@');
  class_addMethod(appDelegateClass, sel_getUid('window'), @window, '@@:'); // this mangling may not be right

  // Add the application dealloc delegate
//    class_addMethod(appDelegateClass, sel_getUid('dealloc'),
//      @applicationDealloc, 'v@:');

  // Add a instance variable for the main window
//    class_addIvar(appDelegateClass, 'window', sizeof(id), 2, '@');

  // Register the delegate class
  objc_registerClassPair(appDelegateClass);

  FObjectiveCMap := TDictionary<TFmxHandle, IObjectiveC>.Create;
  FObjectMap := TDictionary<TFmxHandle, TObject>.Create;
  FTimers := TList<TFmxHandle>.Create;

  FFormHandle := nil;

  FIdleTimer := CreateTimer(10, IdleTimerFunc);
end;

destructor TPlatformCocoaTouch.Destroy;
begin
  DestroyTimer(FIdleTimer);
  FreeAndNil(FTimers);
  FObjectMap.Free;
  FObjectiveCMap.Free;
  inherited;
end;

procedure TPlatformCocoaTouch.IdleTimerFunc;
var
  Done: Boolean;
begin
  Done := False;
  if (TThread.CurrentThread.ThreadID = MainThreadID) then
    CheckSynchronize;
  Application.DoIdle(Done);
end;

{ App =========================================================================}

procedure RunLoopObserverCallback(observer: CFRunLoopObserverRef; activity: CFRunLoopActivity; info: Pointer); cdecl;
begin
  if (TThread.CurrentThread.ThreadID = MainThreadID) then
    CheckSynchronize;
//  Application.DoIdle(Done);
end;

procedure TPlatformCocoaTouch.Run;
begin
//  ExitCode := UIApplicationMain(ParamCount, MarshaledAString(ParamStr(0)), nil, (NSSTR('DelphiAppDelegate') as ILocalObject).GetObjectID);
  ExitCode := UIApplicationMain(System.ArgCount, System.ArgValues, nil, (NSSTR('DelphiAppDelegate') as ILocalObject).GetObjectID);
end;

procedure TPlatformCocoaTouch.Terminate;
var
  I: Integer;
begin
  FTerminating := True;
  for I := FTimers.Count - 1 downto 0 do
  try
    DestroyTimer(FTimers[I]);
  except
    Continue;
  end;
//  UIApp.terminate(nil);
end;

function TPlatformCocoaTouch.Terminating: Boolean;
begin
  Result := FTerminating;
end;

function TPlatformCocoaTouch.HandleApplicationEvent(AEvent: TApplicationEvent; AContext: TObject): Boolean;
begin
  Result := False;
  if Assigned(FOnApplicationEvent) then
    try
      Result := FOnApplicationEvent(AEvent, AContext);
    except
      Application.HandleException(Self);
    end;
end;

function TPlatformCocoaTouch.HandleMessage: Boolean;
begin
  WaitMessage;
  Result := False;
end;

procedure TPlatformCocoaTouch.InternalWaitMessage(AInterval: Single);
var
  TimeoutDate: NSDate;
begin
  TimeoutDate := TNSDate.Wrap(TNSDate.OCClass.dateWithTimeIntervalSinceNow(AInterval));
  TNSRunLoop.Wrap(TNSRunLoop.OCClass.currentRunLoop).runMode(NSDefaultRunLoopMode, TimeoutDate);
end;

procedure TPlatformCocoaTouch.WaitMessage;
begin
  InternalWaitMessage(0.0);
end;

function TPlatformCocoaTouch.GetTitle: string;
var
  AppNameKey: Pointer;
  AppBundle: NSBundle;
  NSAppName: NSString;
begin
  AppNameKey := (NSSTR('CFBundleName') as ILocalObject).GetObjectID;
  AppBundle := TNSBundle.Wrap(TNSBundle.OCClass.mainBundle);
  NSAppName := TNSString.Wrap(AppBundle.infoDictionary.objectForKey(AppNameKey));
  Result := UTF8ToString(NSAppName.UTF8String);
end;

{ Timer =======================================================================}

type
  CocoaTimer = interface(NSObject)
    ['{B65CD0E6-21EA-4E77-BF5E-981C3B0EE632}']
    procedure timerEvent; cdecl;
  end;

  TCocoaTimer = class(TOCLocal)
  private
    FFunc : TTimerProc;
    FTimer: NSTimer;
  public
    function GetObjectiveCClass: PTypeInfo; override;
    procedure timerEvent; cdecl;
    procedure SetTimerFunc(AFunc: TTimerProc);
  end;

function TCocoaTimer.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(CocoaTimer);
end;

procedure TCocoaTimer.timerEvent;
begin
  if Assigned(@FFunc) then
  try
    FFunc;
  except
    on E: Exception do
    begin
      if Assigned(Application) then
        Application.HandleException(nil);
    end;
  end;
end;

procedure TCocoaTimer.SetTimerFunc(AFunc: TTimerProc);
begin
  FFunc := AFunc;
end;

function TPlatformCocoaTouch.CreateTimer(Interval: Integer; TimerFunc: TTimerProc): TFmxHandle;
var
  LInterval: NSTimeInterval;
  User: TCocoaTimer;
begin
  Result := 0;
  if (not FTerminating) and (Interval > 0) and (Assigned(TimerFunc)) then
  begin
    User := TCocoaTimer.Create;
    try
      User.SetTimerFunc(TimerFunc);
      LInterval := Interval/1000;

      User.FTimer := TNSTimer.Wrap(TNSTimer.OCClass.scheduledTimerWithTimeInterval(LInterval,
        User.GetObjectID, sel_getUid('timerEvent'), User.GetObjectID, True));

      Result := AllocObjectHandle(User);
      FTimers.Add(Result);
    finally
      {user is retained (twice, because it's target), by the timer and }
      {released (twice) on timer invalidation}
      NSObject(User.Super).release;
    end;
  end;
end;

function TPlatformCocoaTouch.DestroyTimer(Timer: TFmxHandle): Boolean;
var
  User: TCocoaTimer;
  I: Integer;
begin
  Result := False;
  User := TCocoaTimer(HandleToObject(Timer));
  if Assigned(User) then
  begin
    Result := True;
    User.FTimer.invalidate;
    User.FTimer := nil;
    DeleteObjectHandle(Timer);
    for I := FTimers.Count - 1 downto 0 do
      if FTimers[I] = Timer then
      begin
        FTimers.Delete(I);
        Break;
      end;
  end;
end;

function TPlatformCocoaTouch.GetTick: Extended;
var
  H, M, S, MS: word;
begin
  DecodeTime(Time, H, M, S, MS);
  Result := ((((H * SecsPerHour) + (M * SecsPerMin) + S) * MSecsPerSec) + MS) / 1000;
end;

{ IFMXSystemFontService }

function TPlatformCocoaTouch.GetDefaultFontFamilyName: string;
begin
  Result := 'Helvetica';
end;

{ IFMXClipboardService }

procedure TPlatformCocoaTouch.SetClipboard(Value: TValue);
begin
  if not Value.IsObject then
    TUIPasteboard.Wrap(TUIPasteboard.OCClass.generalPasteboard).setString(NSSTR(Value.ToString));
end;

function TPlatformCocoaTouch.GetClipboard: TValue;
var
  A: NSArray;
  S: NSString;
begin
  if TUIPasteboard.Wrap(TUIPasteboard.OCClass.generalPasteboard).isPersistent then
  begin
    A := TNSArray.Wrap(TUIPasteboard.Wrap(TUIPasteboard.OCClass.generalPasteboard).strings);
    if A.count > 0 then
    begin
      S := TNSString.Wrap(A.objectAtIndex(0));
      Result := UTF8ToString(S.UTF8String);
    end;
  end
  else
    Result := '';
end;

{ IFMXWindowService }

{ Text Service }

constructor TTextServiceCocoa.Create(const Owner: IControl; SupportMultiLine: Boolean);
begin
  inherited;
end;

destructor TTextServiceCocoa.Destroy;
begin
  inherited;
end;

function TTextServiceCocoa.GetText: string;
begin
  Result := FText;
end;

procedure TTextServiceCocoa.SetText(const Value: string);
begin
  FText := Value;
end;

function TTextServiceCocoa.GetCaretPostion: TPoint;
begin
  Result := FCaretPostion;
end;

procedure TTextServiceCocoa.SetCaretPosition(const Value: TPoint);
begin
  FCaretPostion := Value;
end;

procedure TTextServiceCocoa.SetCursorShift(const Value: Integer);
begin
  FCursorShift := Value;
end;

procedure TTextServiceCocoa.InternalSetMarkedText( const AMarkedText: string );
begin
  FMarkedText := AMarkedText;
  (FOwner as ITextInput).UpdateCaretPoint;
end;

procedure TTextServiceCocoa.InternalBreakIMEInput;
begin
  FMarkedText := EmptyStr;
  FCursorShift := 0;
  (FOwner as ITextInput).UpdateCaretPoint;
end;

procedure TTextServiceCocoa.InternalEndIMEInput;
begin
  (FOwner as ITextInput).EndIMEInput;
  FMarkedText := EmptyStr;
  FCursorShift := 0;
end;

procedure TTextServiceCocoa.InternalStartIMEInput;
begin
  (FOwner as ITextInput).StartIMEInput;
end;

function TTextServiceCocoa.InternalGetMarkedText: string;
begin
  Result := FMarkedText;
end;

procedure TTextServiceCocoa.BeginSelection;
begin
  FView.HideContextMenu;
end;

function TTextServiceCocoa.CombinedText: string;
begin
  if FMarkedText <> '' then
    Result := Copy(FText, 1, FCaretPostion.X) + FMarkedText + Copy(FText, FCaretPostion.X + 1, MaxInt)
  else
    Result := FText;
end;

function TTextServiceCocoa.TargetClausePosition: TPoint;
begin
  Result := CaretPosition;
  Result.X := Result.X + FCursorShift;
end;

procedure TTextServiceCocoa.EndSelection;
begin
  if Assigned(FView) then
    FView.FContextMenu.Show;
end;

procedure TTextServiceCocoa.EnterControl(const FormHandle: TWindowHandle);
var
  View: TFMXViewBase;
  VirtKBControl: IVirtualKeyboardControl;
begin
  View := TFMXViewBase(WindowHandleToPlatform(FormHandle).Handle);
  FView := View;
  if Assigned(View.Form.Focused) and Supports(View.Form.Focused, IVirtualKeyboardControl, VirtKBControl) then
    View.FKeyboardType := VirtKBControl.KeyboardType
  else
    View.FKeyboardType := TVirtualKeyboardType.vktDefault;
  View.unmarkText;
  View.FText := '';
end;

procedure TTextServiceCocoa.ExitControl(const FormHandle: TWindowHandle);
var
  View: TFMXViewBase;
begin
  View := TFMXViewBase(WindowHandleToPlatform(FormHandle).Handle);
  View.unmarkText;
  View.FText := '';
  FView := nil;
end;

procedure TTextServiceCocoa.DrawSingleLine(const Canvas: TCanvas;
      const ARect: TRectF; const FirstVisibleChar: integer; const Font: TFont;
      const AOpacity: Single; const Flags: TFillTextFlags; const ATextAlign: TTextAlign;
      const AVTextAlign: TTextAlign = TTextAlign.taCenter;
      const AWordWrap: Boolean = False);
var
  I: Integer;
  S: string;
  Layout: TTextLayout;
  Region: TRegion;
begin
  Layout := TTextLayoutManager.TextLayoutByCanvas(Canvas.ClassType).Create;
  try
    Layout.BeginUpdate;
    Layout.TopLeft := ARect.TopLeft;
    Layout.MaxSize := PointF(ARect.Width, ARect.Height);
    Layout.WordWrap := AWordWrap;
    Layout.HorizontalAlign := ATextAlign;
    Layout.VerticalAlign := AVTextAlign;
    Layout.Font := Font;
    Layout.Color := Canvas.Fill.Color;
    Layout.Opacity := AOpacity;
    Layout.RightToLeft := TFillTextFlag.ftRightToLeft in Flags;
    S := CombinedText;
    Layout.Text := S.Substring(FirstVisibleChar - 1, S.Length - FirstVisibleChar + 1);
    Layout.EndUpdate;
    Layout.RenderLayout(Canvas);

    if not FMarkedText.IsEmpty then
    try
      Canvas.Stroke.Assign(Canvas.Fill);
      Canvas.StrokeThickness := 1;
      Canvas.StrokeDash := TStrokeDash.sdSolid;

      Region := Layout.RegionForRange(TTextRange.Create(CaretPosition.X, FMarkedText.Length));
      for I := Low(Region) to High(Region) do
        Canvas.DrawLine(
          PointF(Region[I].Left, Region[I].Bottom),
          PointF(Region[I].Right, Region[I].Bottom),
          AOpacity, Canvas.Stroke);

      if FSelectedRange.length > 0 then
      begin
        Canvas.StrokeThickness := 3;
        Region := Layout.RegionForRange(TTextRange.Create(CaretPosition.X + 1 + Integer(FSelectedRange.location), FSelectedRange.length));
        for I := Low(Region) to High(Region) do
          Canvas.DrawLine(
            PointF(Region[I].Left, Region[I].Bottom),
            PointF(Region[I].Right, Region[I].Bottom),
            AOpacity, Canvas.Stroke);
      end;
    finally
      Canvas.StrokeThickness := 1;
      Canvas.StrokeDash := TStrokeDash.sdSolid;
    end;
  finally
    FreeAndNil(Layout);
  end;
end;

procedure TTextServiceCocoa.DrawSingleLine(const Canvas: TCanvas;
      const S: string;
      const ARect: TRectF;
      const Font: TFont;
      const AOpacity: Single; const Flags: TFillTextFlags; const ATextAlign: TTextAlign;
      const AVTextAlign: TTextAlign = TTextAlign.taCenter;
      const AWordWrap: Boolean = False);
var
  I: Integer;
  Layout: TTextLayout;
  Region: TRegion;
begin
  Layout := TTextLayoutManager.TextLayoutByCanvas(Canvas.ClassType).Create;
  try
    Layout.BeginUpdate;
    Layout.TopLeft := ARect.TopLeft;
    Layout.MaxSize := PointF(ARect.Width, ARect.Height);
    Layout.WordWrap := AWordWrap;
    Layout.HorizontalAlign := ATextAlign;
    Layout.VerticalAlign := AVTextAlign;
    Layout.Font := Font;
    Layout.Color := Canvas.Fill.Color;
    Layout.Opacity := AOpacity;
    Layout.RightToLeft := TFillTextFlag.ftRightToLeft in Flags;
    Layout.Text := S;
    Layout.EndUpdate;
    Layout.RenderLayout(Canvas);

    if not FMarkedText.IsEmpty then
    try
      Canvas.Stroke.Assign(Canvas.Fill);
      Canvas.StrokeThickness := 1;
      Canvas.StrokeDash := TStrokeDash.sdSolid;

      Region := Layout.RegionForRange(TTextRange.Create(CaretPosition.X, FMarkedText.Length));
      for I := Low(Region) to High(Region) do
        Canvas.DrawLine(
          PointF(Region[I].Left, Region[I].Bottom),
          PointF(Region[I].Right, Region[I].Bottom),
          AOpacity, Canvas.Stroke);

      if FSelectedRange.length > 0 then
      begin
        Canvas.StrokeThickness := 3;
        Region := Layout.RegionForRange(TTextRange.Create(CaretPosition.X + Integer(FSelectedRange.location), FSelectedRange.length));
        for I := Low(Region) to High(Region) do
          Canvas.DrawLine(
            PointF(Region[I].Left, Region[I].Bottom),
            PointF(Region[I].Right, Region[I].Bottom),
            AOpacity, Canvas.Stroke);
      end;
    finally
      Canvas.StrokeThickness := 1;
      Canvas.StrokeDash := TStrokeDash.sdSolid;
    end;
  finally
    FreeAndNil(Layout);
  end;
end;

function TTextServiceCocoa.HasMarkedText: boolean;
begin
  Result := not FMarkedText.IsEmpty;
end;

function TTextServiceCocoa.GetImeMode: TImeMode;
begin
  Result := FImeMode;
end;

procedure TTextServiceCocoa.SetImeMode(const Value: TImeMode);
begin
  FImeMode := Value;
end;

procedure TTextServiceCocoa.SetSelectedRange(const Value: NSRange);
begin
  FSelectedRange := Value;
end;

function TPlatformCocoaTouch.GetTextServiceClass: TTextServiceClass;
begin
  Result := TTextServiceCocoa;
end;

function TPlatformCocoaTouch.FindForm(const AHandle: TWindowHandle): TCommonCustomForm;
begin
  Result := WindowHandleToPlatform(AHandle).Form
end;

function TPlatformCocoaTouch.CreateWindow(const AForm: TCommonCustomForm): TWindowHandle;
var
  View: TFMXViewBase;
  R: CGRect;
  LOrientation: Cardinal;
  Tmp: Single;
begin
  Result := nil;
  if not IsPopupForm(AForm) then
  begin
    R := TUIScreen.Wrap(TUIScreen.OCClass.mainScreen).bounds;
    LOrientation := UIApp.statusBarOrientation;
    if (LOrientation = UIDeviceOrientationLandscapeLeft) or (LOrientation = UIDeviceOrientationLandscapeRight) then
    begin
      Tmp := R.size.width;
      R.size.width := R.size.height;
      R.size.height := Tmp;
      if AForm.BorderStyle <> TFmxFormBorderStyle.bsNone then
        R.size.height := R.size.height - UIApp.statusBarFrame.size.width;
    end
    else
      if AForm.BorderStyle <> TFmxFormBorderStyle.bsNone then
        R.size.height := R.size.height - UIApp.statusBarFrame.size.height;
  end
  else
  begin
    R := CGRectMake(AForm.Left, AForm.Top, AForm.Width, AForm.Height);
  end;

  if TWindowStyle.wsGPUSurface in AForm.WindowStyle then
    View := TFMXView3D.Create(AForm, R)
  else
    View := TFMXView.Create(AForm, R);

  if not IsPopupForm(AForm) then
    UIView(View.Super).setAutoresizingMask(UIViewAutoresizingFlexibleHeight or UIViewAutoresizingFlexibleWidth);

  if AForm.Transparency and Assigned(Application.MainForm) then
    UIView(View.Super).setOpaque(False)
  else
    UIView(View.Super).setOpaque(True);

  Result := TiOSWindowHandle.Create(View);
  UIView(View.Super).setHidden(True);
end;

procedure TPlatformCocoaTouch.DestroyWindow(const AForm: TCommonCustomForm);
begin
  if Assigned(AForm.Handle) then
    WindowHandleToPlatform(AForm.Handle).View.removeFromSuperview;
end;

procedure TPlatformCocoaTouch.ReleaseWindow(const AForm: TCommonCustomForm);
begin
  if (AForm <> nil) and (AForm.Handle <> nil) then
    WindowHandleToPlatform(AForm.Handle).View.removeFromSuperview;
end;

procedure TPlatformCocoaTouch.ResetIdleTimer;
begin
  DestroyTimer(FIdleTimer);
  FIdleTimer := CreateTimer(10, IdleTimerFunc);
end;

procedure TPlatformCocoaTouch.SetWindowRect(const AForm: TCommonCustomForm; ARect: TRectF);
begin
  if Assigned(AForm.Handle) and not ((AForm = Application.MainForm) or not IsPopupForm(AForm)) then
    WindowHandleToPlatform(AForm.Handle).View.setFrame(CGRectMake(ARect.Left, ARect.Top,
      ARect.Right - ARect.Left, ARect.Bottom - ARect.Top))
end;

function TPlatformCocoaTouch.GetWindowRect(const AForm: TCommonCustomForm): TRectF;
var
  LBounds: CGRect;
begin
  if (AForm = Application.MainForm) or not IsPopupForm(AForm) then
  begin
    LBounds := AppDelegate.MainWindow.RootView.bounds;
    Result := RectF(LBounds.origin.x, LBounds.origin.y, LBounds.origin.x + LBounds.size.width,
      LBounds.origin.y + LBounds.size.height);
  end
  else
  begin
    LBounds := WindowHandleToPlatform(AForm.Handle).View.frame;
    Result := RectF(LBounds.origin.x, LBounds.origin.y, LBounds.origin.x + LBounds.size.width,
      LBounds.origin.y + LBounds.size.height);
  end;
end;

function TPlatformCocoaTouch.GetWindowScale(const AForm: TCommonCustomForm): Single;
var
  View: UIView;
begin
  View := WindowHandleToPlatform(AForm.Handle).View;
  Result := Round(View.contentScaleFactor);
end;

procedure TPlatformCocoaTouch.SetFullScreen(const AForm: TCommonCustomForm;
  const AValue: Boolean);
begin

end;

function TPlatformCocoaTouch.GetFullScreen(const AForm: TCommonCustomForm): Boolean;
begin
  Result := True;
end;

procedure TPlatformCocoaTouch.SetShowFullScreenIcon(const AForm: TCommonCustomForm;
  const AValue: Boolean);
begin

end;

procedure TPlatformCocoaTouch.InvalidateImmediately(const AForm: TCommonCustomForm);
begin
  if Assigned(WindowHandleToPlatform(AForm.Handle).GLView) then
    WindowHandleToPlatform(AForm.Handle).GLView.display
  else
    WindowHandleToPlatform(AForm.Handle).View.setNeedsDisplay;
end;

procedure TPlatformCocoaTouch.InvalidateWindowRect(const AForm: TCommonCustomForm; R: TRectF);
begin
  WindowHandleToPlatform(AForm.Handle).View.setNeedsDisplayInRect(CGRectMake(R.left, R.top, R.right - R.left, R.bottom - R.top))
end;

function TPlatformCocoaTouch.IsPopupForm(const AForm: TCommonCustomForm): Boolean;
begin
  if AForm.Owner is TPopup then
    Result := True
  else
    Result := False;
end;

procedure TPlatformCocoaTouch.Log(Fmt: String; Params: array of const);
begin
  NSLog((NSSTR(Format(Fmt, Params)) as ILocalObject).GetObjectID);
end;

function TPlatformCocoaTouch.AllocObjectHandle(const Objc: TObject): TFmxHandle;
begin
  Result := NewFmxHandle;
  TMonitor.Enter(FObjectiveCMap);
  try
    FObjectMap.Add(Result, Objc);
  finally
    TMonitor.Exit(FObjectiveCMap);
  end;
end;

function TPlatformCocoaTouch.NewFmxHandle: TFmxHandle;
begin
{$IF defined(CPUX64)}
  Result := TInterlocked.Add(Int64(FHandleCounter), 16);
{$ELSEIF defined(CPUX86) or defined(CPUARM)}
  Result := TInterlocked.Add(Integer(FHandleCounter), 16);
{$ENDIF}
end;


procedure TPlatformCocoaTouch.SetWindowCaption(const AForm: TCommonCustomForm; const ACaption: string);
begin
  // NOP on iOS
end;

procedure TPlatformCocoaTouch.SetWindowState(const AForm: TCommonCustomForm; const AState: TWindowState);
begin
  // NOP on iOS
end;

procedure TPlatformCocoaTouch.RegisterCanvasClasses;
begin
  if not (TPlatformServices.Current.GlobalFlags.ContainsKey(GlobalDisableiOSGPUCanvas)) or
    (TPlatformServices.Current.GlobalFlags[GlobalDisableiOSGPUCanvas] = False) then
    FMX.Canvas.GPU.RegisterCanvasClasses;
  FMX.Canvas.iOS.RegisterCanvasClasses;
end;

procedure TPlatformCocoaTouch.UnregisterCanvasClasses;
begin
  FMX.Canvas.iOS.UnregisterCanvasClasses;
  if not (TPlatformServices.Current.GlobalFlags.ContainsKey(GlobalDisableiOSGPUCanvas)) or
    (TPlatformServices.Current.GlobalFlags[GlobalDisableiOSGPUCanvas] = False) then
    FMX.Canvas.GPU.UnregisterCanvasClasses;
end;

procedure TPlatformCocoaTouch.RegisterContextClasses;
begin
  FMX.Context.GLES.RegisterContextClasses;
end;

procedure TPlatformCocoaTouch.UnregisterContextClasses;
begin
  FMX.Context.GLES.UnregisterContextClasses;
end;

procedure TPlatformCocoaTouch.ReleaseCapture(const AForm: TCommonCustomForm);
begin
  // NOP on iOS
end;

procedure TPlatformCocoaTouch.SetApplicationEventHandler(AEventHandler: TApplicationEventHandler);
begin
  FOnApplicationEvent := AEventHandler;
end;

procedure TPlatformCocoaTouch.SetCapture(const AForm: TCommonCustomForm);
begin
  // NOP on iOS
end;

{ IFMXImageGeneratorService }

function TPlatformCocoaTouch.GenerateTabIcon(const ASource, ADest: TBitmap; const IsSelected, HiRes: Boolean): Boolean;
var
  Res: TStream;
  ImageGradient: TBitmap;
  ImageSrc, ImageNormal: TBitmap;
  M, HotM: TBitmapData;
  i, j: Integer;
  S, A: TAlphaColor;
  R: TRectF;
begin
  Result := True;
  // Gradient
  if HiRes then
    ImageSrc := TBitmap.Create(30 * 2, 30 * 2)
  else
    ImageSrc := TBitmap.Create(30, 30);
  if ImageSrc.Canvas.BeginScene then
  try
    ImageSrc.Canvas.Fill.Kind := TBrushKind.bkGradient;
    ImageSrc.Canvas.Fill.Gradient.Points.Add;
    ImageSrc.Canvas.Fill.Gradient.Points[0].Color  := $FF9f9f9f;
    ImageSrc.Canvas.Fill.Gradient.Points[0].Offset := 0;
    ImageSrc.Canvas.Fill.Gradient.Points[1].Color  := $FF767676;
    ImageSrc.Canvas.Fill.Gradient.Points[1].Offset := 0.5;
    ImageSrc.Canvas.Fill.Gradient.Points[2].Color  := $FF585858;
    ImageSrc.Canvas.Fill.Gradient.Points[2].Offset := 1;
    ImageSrc.Canvas.FillRect(RectF(0, 0, ImageSrc.Width, ImageSrc.Height), 0, 0, [], 1);
  finally
    ImageSrc.Canvas.EndScene;
  end;
  //
  ImageNormal := TBitmap.Create(ImageSrc.Width, ImageSrc.Height);
  if ImageNormal.Canvas.BeginScene then
  try
    R := RectF(0, 0, ASource.Width, ASource.Height);
    R.Fit(RectF(0, 0, ImageSrc.Width, ImageSrc.Height));
    ImageNormal.Canvas.Clear(0);
    ImageNormal.Canvas.DrawBitmap(ASource, RectF(0, 0, ASource.Width, ASource.Height), R, 1);
  finally
    ImageNormal.Canvas.EndScene;
  end;
  //
  if ImageSrc.Map(TMapAccess.maReadWrite, M) and ImageNormal.Map(TMapAccess.maRead, HotM) then
  try
    for I := 0 to ImageSrc.Width - 1 do
      for J := 0 to ImageSrc.Height - 1 do
      begin
        A := HotM.GetPixel(i, j);
        S := UnpremultiplyAlpha(M.GetPixel(i, j));
        TAlphaColorRec(S).A := TAlphaColorRec(A).A;
        M.SetPixel(i, j, PremultiplyAlpha(S));
      end;
  finally
    ImageNormal.Unmap(HotM);
    ImageSrc.Unmap(M);
  end;
  if IsSelected then
  begin
    if not HiRes and (FindResource(HInstance, PChar('iostabgradient'), RT_RCDATA) <> 0) then
    begin
      Res := TResourceStream.Create(HInstance, 'iostabgradient', RT_RCDATA);
      ImageGradient := TBitmap.CreateFromStream(Res);
      if ImageSrc.Map(TMapAccess.maReadWrite, M) and ImageGradient.Map(TMapAccess.maRead, HotM) then
      try
        for I := 0 to ImageSrc.Width - 1 do
          for J := 0 to ImageSrc.Height - 1 do
          begin
            A := M.GetPixel(i, j);
            S := UnpremultiplyAlpha(HotM.GetPixel(i, j));
            TAlphaColorRec(S).A := TAlphaColorRec(A).A;
            M.SetPixel(i, j, PremultiplyAlpha(S));
          end;
      finally
        ImageGradient.Unmap(HotM);
        ImageSrc.Unmap(M);
      end;
      ImageGradient.Free;
    end;
    if HiRes and (FindResource(HInstance, PChar('iostabgradient2x'), RT_RCDATA) <> 0) then
    begin
      Res := TResourceStream.Create(HInstance, 'iostabgradient2x', RT_RCDATA);
      ImageGradient := TBitmap.CreateFromStream(Res);
      if ImageSrc.Map(TMapAccess.maReadWrite, M) and ImageGradient.Map(TMapAccess.maRead, HotM) then
      try
        for I := 0 to ImageSrc.Width - 1 do
          for J := 0 to ImageSrc.Height - 1 do
          begin
            A := M.GetPixel(i, j);
            S := UnpremultiplyAlpha(HotM.GetPixel(i, j));
            TAlphaColorRec(S).A := TAlphaColorRec(A).A;
            M.SetPixel(i, j, PremultiplyAlpha(S));
          end;
      finally
        ImageGradient.Unmap(HotM);
        ImageSrc.Unmap(M);
      end;
      ImageGradient.Free;
    end;
  end;
  ADest.Assign(ImageSrc);

  ImageNormal.Free;
  ImageSrc.Free;
end;

function TPlatformCocoaTouch.GetCaretWidth: Integer;
begin
  Result := 3;
end;

function TPlatformCocoaTouch.GetClientSize(const AForm: TCommonCustomForm): TPointF;
var
  LOrientation: Cardinal;
begin
  if (AForm = Application.MainForm) or not IsPopupForm(AForm) then
  begin
    Result := TPointF(FMainScreen.bounds.size);
    LOrientation := UIApp.statusBarOrientation;
    if (LOrientation = UIDeviceOrientationLandscapeLeft) or (LOrientation = UIDeviceOrientationLandscapeRight) then
    begin
      Result := TPointF.Create(Result.Y, Result.X);
      if AForm.BorderStyle <> TFmxFormBorderStyle.bsNone then
        Result.Y := Result.Y - UIApp.statusBarFrame.size.width;
    end
    else
      if AForm.BorderStyle <> TFmxFormBorderStyle.bsNone then
        Result.Y := Result.Y - UIApp.statusBarFrame.size.height;
  end
  else
    Result := TPointF(WindowHandleToPlatform(AForm.Handle).View.bounds.size);
end;

procedure TPlatformCocoaTouch.HideWindow(const AForm: TCommonCustomForm);
begin
  if (AForm <> nil) and Assigned(AForm.Handle) then
    WindowHandleToPlatform(AForm.Handle).View.setHidden(True);
end;

procedure TPlatformCocoaTouch.ShowWindow(const AForm: TCommonCustomForm);
var
  LFMXView: TFMXViewBase;
  LView: UIView;
  PickerService: IFMXPickerService;
  LFrame: NSRect;
begin
  LFMXView := TFMXViewBase(WindowHandleToPlatform(AForm.Handle).Handle);
  LView := UIView(LFMXView.Super);

  if not IsPopupForm(AForm) and (AForm.BorderStyle = TFmxFormBorderStyle.bsNone) then
  begin
    UIApp.setStatusBarHidden(True);
    UIViewController(AppDelegate.MainWindow.RootViewController.Super).setWantsFullScreenLayout(True);
    AppDelegate.MainWindow.RootView.setFrame(TUIScreen.Wrap(TUIScreen.OCClass.mainScreen).bounds);
  end
  else
  begin
    UIApp.setStatusBarHidden(False, UIStatusBarAnimationNone);
    UIViewController(AppDelegate.MainWindow.RootViewController.Super).setWantsFullScreenLayout(False);
    if not IsPopupForm(AForm) then
    begin
      LView.setFrame(AppDelegate.MainWindow.RootView.bounds);
      LFrame := LView.bounds;
      AForm.SetBounds(round(LFrame.origin.x), round(LFrame.origin.y), round(LFrame.size.width), round(LFrame.size.height));
    end;
  end;
  LView.setHidden(False);
  AppDelegate.MainWindow.RootView.addSubview(LView);
  AppDelegate.MainWindow.RootView.layoutIfNeeded;
  AppDelegate.MainWindow.RootView.bringSubviewToFront(LView);
  AForm.Activate;
  if TPlatformServices.Current.SupportsPlatformService(IFMXPickerService, IInterface(PickerService)) then
  begin
    PickerService.CloseAllPickers;
    PickerService := nil;
  end;
end;

procedure TPlatformCocoaTouch.BringToFront(const AForm: TCommonCustomForm);
begin
  // NOP on iOS
end;

procedure TPlatformCocoaTouch.SendToBack(const AForm: TCommonCustomForm);
begin
  // NOP on iOS
end;

procedure TPlatformCocoaTouch.Activate(const AForm: TCommonCustomForm);
begin
  // NOP on iOS
end;

function TPlatformCocoaTouch.ShowWindowModal(const AForm: TCommonCustomForm): TModalResult;
var
  R: CGRect;
  LBounds: CGRect;
  BackView: UIView;
begin
  try
    LBounds := AppDelegate.MainWindow.RootView.bounds;
    R := CGRectMake(0, 0, LBounds.size.Width, LBounds.size.Height);
    BackView := TUIView.Alloc;
    BackView := TUIView.Wrap(BackView.initWithFrame(R));
    AppDelegate.MainWindow.RootView.AddSubview(BackView);

    AForm.Show;
    AForm.ModalResult := mrNone;
    repeat
      if not Application.HandleMessage then
        InternalWaitMessage(0.1);
      if Application.Terminated then
        AForm.ModalResult := mrCancel
      else if AForm.ModalResult <> mrNone then
        AForm.CloseModal;
    until AForm.ModalResult <> mrNone;
    AForm.Hide;
  finally
    BackView.removeFromSuperview;
  end;
  Result := AForm.ModalResult;
end;

function TPlatformCocoaTouch.GetDefaultSize(const AComponent: TComponentKind): TSize;
begin
  case AComponent of
    TComponentKind.ckButton: Result := TSize.Create(73, 44);
    TComponentKind.ckLabel: Result := TSize.Create(82, 21);
    TComponentKind.ckEdit: Result := TSize.Create(97, 30);
    TComponentKind.ckScrollBar: Result := TSize.Create(7, 7);
    TComponentKind.ckListBoxItem: Result := TSize.Create(44, 44);
  else
    Result := TSize.Create(80, 22);
  end;
end;

function TPlatformCocoaTouch.SupportsDefaultSize(const AComponent: TComponentKind): Boolean;
begin
  case AComponent of
    TComponentKind.ckButton: Result := True;
    TComponentKind.ckLabel: Result := True;
    TComponentKind.ckEdit: Result := True;
    TComponentKind.ckScrollBar: Result := True;
    TComponentKind.ckListBoxItem: Result := True;
  else
    Result := False;
  end;
end;

function TPlatformCocoaTouch.GetDefaultPropertyValue(const AClassName,
  PropertyName: string): TValue;
begin
  Result := TValue.Empty;

  if string.Compare(AClassName, 'tcolorcombobox', True) = 0 then
    Result := TValue.From<TDropDownKind>(TDropDownKind.ddkNative);
end;

function TPlatformCocoaTouch.ClientToScreen(const AForm: TCommonCustomForm; const Point: TPointF): TPointF;
var
  StatusBarOffset: NSPoint;
begin
  StatusBarOffset := AppDelegate.MainWindow.RootView.frame.origin;
  Result := Point + TPointF.Create(AForm.Left + StatusBarOffset.x, AForm.Top + StatusBarOffset.Y);
end;

function TPlatformCocoaTouch.ScreenToClient(const AForm: TCommonCustomForm; const Point: TPointF): TPointF;
var
  StatusBarOffset: NSPoint;
begin
  StatusBarOffset := AppDelegate.MainWindow.RootView.frame.origin;
  Result := Point - TPointF.Create(AForm.Left + StatusBarOffset.x, AForm.Top + StatusBarOffset.Y);
end;

function TPlatformCocoaTouch.HandleToObject(const FmxHandle: TFmxHandle): TObject;
begin
  TMonitor.Enter(FObjectiveCMap);
  try
    ValidateHandle(FmxHandle);
    if FObjectMap.ContainsKey(FmxHandle) then
      Result := FObjectMap[FmxHandle]
    else
      Result := nil;
  finally
    TMonitor.Exit(FObjectiveCMap);
  end;
end;

procedure TPlatformCocoaTouch.ValidateHandle(FmxHandle: TFmxHandle);
begin
  if (FmxHandle and $F <> 0) then
    raise Exception.Create('invalid handle'); //EInvalidFmxHandle.CreateResFmt(@SInvalidFmxHandle, [HexDisplayPrefix, SizeOf(TFmxHandle) * 2, FmxHandle]);
end;

procedure TPlatformCocoaTouch.SetClientSize(const AForm: TCommonCustomForm; const ASize: TPointF);
begin
  if (AForm = Application.MainForm) or not IsPopupForm(AForm) then
  else
  begin
    AForm.SetBounds(AForm.Left, AForm.Top, Round(ASize.X), Round(ASize.Y));
  end;
end;

{ IFMXScreenService }

function TPlatformCocoaTouch.GetScreenSize: TPointF;
begin
  Result := TPointF(FMainScreen.bounds.size);
end;

function TPlatformCocoaTouch.GetScreenScale: Single;
begin
  Result := Round(AppDelegate.MainWindow.RootView.contentScaleFactor);
end;

function TPlatformCocoaTouch.GetScreenOrientation: TScreenOrientation;
var
  LOrientation: Cardinal;
begin
    LOrientation := FCurrentDevice.orientation;
    case LOrientation of
    UIDeviceOrientationLandscapeLeft:
      Result := TScreenOrientation.soLandscape;
    UIDeviceOrientationLandscapeRight:
      Result := TScreenOrientation.soInvertedLandscape;
    UIDeviceOrientationPortrait:
      Result := TScreenOrientation.soPortrait;
    UIDeviceOrientationPortraitUpsideDown:
      Result := TScreenOrientation.soInvertedPortrait;
    else
      Result := TScreenOrientation.soPortrait;
    end;
end;

{ IFMXSystemInformationService }

function TPlatformCocoaTouch.GetScrollingBehaviour: TScrollingBehaviours;
begin
  Result := [TScrollingBehaviour.sbBoundsAnimation, TScrollingBehaviour.sbAnimation, TScrollingBehaviour.sbAutoShowing, TScrollingBehaviour.sbTouchTracking];
end;

function TPlatformCocoaTouch.GetMinScrollThumbSize: Single;
begin
  Result := 30;
end;

{ IFMXStyleService }

function TPlatformCocoaTouch.GetSystemStyle: TFmxObject;
begin
  Result := FMX.Controls.iOS.GetSystemStyle;
end;

{ IFMXStyleHiResService }

function TPlatformCocoaTouch.GetSystemStyleHiRes: TFmxObject;
begin
  Result := FMX.Controls.iOS.GetSystemStyleHiRes;
end;

{ International ===============================================================}

function TPlatformCocoaTouch.GetCurrentLangID: string;
var
  CurrentLocale: NSLocale;
  LanguageISO: NSString;
begin
  CurrentLocale := TNSLocale.Wrap(TNSLocale.OCClass.currentLocale);
  LanguageISO := TNSString.Wrap(CurrentLocale.objectForKey((NSLocaleLanguageCode as ILocalObject).GetObjectID));
  Result := UTF8ToString(LanguageISO.UTF8String);
  if Length(Result) > 2 then
    Delete(Result, 3, MaxInt);
end;


function TPlatformCocoaTouch.GetLocaleFirstDayOfWeek: string;
var
  cal: NSCalendar;
  firstDay: NSUInteger;
begin
  cal:= TNSCalendar.Wrap(TNSCalendar.OCClass.currentCalendar);
  firstDay:= Cal.firstWeekday;
  Result:= IntToStr(firstDay);
end;

{ IDeviceServices }

function TPlatformCocoaTouch.GetModel: string;
begin
  Result := UTF8ToString(TUIDevice.Wrap(TUIDevice.OCClass.currentDevice).model.UTF8String);
end;

{ Dialogs ===============================================================}

function TPlatformCocoaTouch.DialogOpenFiles(var AFileName: TFileName; const AInitDir, ADefaultExt, AFilter, ATitle: string;
  var AFilterIndex: Integer; var AFiles: TStrings; var AOptions: TOpenOptions): Boolean;
begin
  Result := False;
end;

function TPlatformCocoaTouch.DialogPrint(var ACollate, APrintToFile: Boolean;
      var AFromPage, AToPage, ACopies: Integer; AMinPage, AMaxPage: Integer; var APrintRange: TPrintRange;
      AOptions: TPrintDialogOptions): Boolean;
begin
  Result := False;
end;

function TPlatformCocoaTouch.PageSetupGetDefaults(var AMargin, AMinMargin: TRect; var APaperSize: TPointF; AUnits: TPageMeasureUnits; AOptions: TPageSetupDialogOptions): Boolean;
begin
  Result := False;
end;

function TPlatformCocoaTouch.DialogPageSetup(var AMargin, AMinMargin :TRect; var APaperSize: TPointF;
  var AUnits: TPageMeasureUnits; AOptions: TPageSetupDialogOptions): Boolean;
begin
  Result := False;
end;

function TPlatformCocoaTouch.DialogPrinterSetup: Boolean;
begin
  Result := False;
end;

function TPlatformCocoaTouch.DialogSaveFiles(var AFileName: TFileName; const AInitDir, ADefaultExt, AFilter, ATitle: string;
  var AFilterIndex: Integer; var AFiles: TStrings; var AOptions: TOpenOptions): Boolean;
begin
  Result := False;
end;

type

  TFMXAlertViewDelegate = class(TOCLocal, UIAlertViewDelegate)
  private
    Results: array of Integer;
    Result: Integer;
    Modal: Boolean;
  public
    procedure alertView(alertView: UIAlertView; clickedButtonAtIndex: NSInteger); cdecl;
    procedure alertViewCancel(alertView: UIAlertView); cdecl;
  end;

procedure TFMXAlertViewDelegate.alertView(alertView: UIAlertView; clickedButtonAtIndex: NSInteger);
begin
  if (clickedButtonAtIndex >= 0) and (clickedButtonAtIndex < Length(Results)) then
    Result := Results[clickedButtonAtIndex]
  else
    Result := mrCancel;
  Modal := False;
end;

procedure TFMXAlertViewDelegate.alertViewCancel(alertView: UIAlertView);
begin
  Result := mrCancel;
  Modal := False;
end;

var
  MsgTitles: array[TMsgDlgType] of string = (SMsgDlgWarning, SMsgDlgError, SMsgDlgInformation, SMsgDlgConfirm, '');
  ModalResults: array[TMsgDlgBtn] of Integer = (
    mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry, mrIgnore, mrAll, mrNoToAll,
    mrYesToAll, 0, mrClose);
  ButtonCaptions: array[TMsgDlgBtn] of string = (
    SMsgDlgYes, SMsgDlgNo, SMsgDlgOK, SMsgDlgCancel, SMsgDlgAbort,
    SMsgDlgRetry, SMsgDlgIgnore, SMsgDlgAll, SMsgDlgNoToAll, SMsgDlgYesToAll,
    SMsgDlgHelp, SMsgDlgClose);

function TPlatformCocoaTouch.MessageDialog(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DefaultButton: TMsgDlgBtn; X, Y,
  HelpCtx: Integer; const HelpFileName: string): Integer;
var
  AlertView: UIAlertView;
  B: TMsgDlgBtn;
  Delegate: TFMXAlertViewDelegate;
begin
  Delegate := TFMXAlertViewDelegate.Create;
  Delegate.Modal := True;

  for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
    if B in Buttons then
    begin
      SetLength(Delegate.Results, Length(Delegate.Results) + 1);
      Delegate.Results[High(Delegate.Results)] := ModalResults[B]
    end;

  AlertView := TUIAlertView.Create;
  AlertView := TUIAlertView.Wrap(AlertView.initWithTitle(NSStr(MsgTitles[DlgType]), NSStr(Msg), ILocalObject(Delegate).GetObjectID, nil, nil));
  for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
    if B in Buttons then
      AlertView.addButtonWithTitle(NSStr(ButtonCaptions[B]));
  AlertView.show;

  while Delegate.Modal do
    TNSRunLoop.Wrap(TNSRunLoop.OCClass.currentRunLoop).runMode(NSDefaultRunLoopMode, TNSDate.Wrap(TNSDate.OCClass.date));

  Result := Delegate.Result;
end;

type

  TFMXAlertViewInputDelegate = class(TOCLocal, UIAlertViewDelegate)
  private
    Result: Integer;
    Modal: Boolean;
  public
    procedure alertView(alertView: UIAlertView; clickedButtonAtIndex: NSInteger); cdecl;
    procedure alertViewCancel(alertView: UIAlertView); cdecl;
  end;

procedure TFMXAlertViewInputDelegate.alertView(alertView: UIAlertView; clickedButtonAtIndex: NSInteger);
begin
  if (clickedButtonAtIndex = 0)then
    Result := mrOk
  else
    Result := mrCancel;
  Modal := False;
end;

procedure TFMXAlertViewInputDelegate.alertViewCancel(alertView: UIAlertView);
begin
  Result := mrCancel;
  Modal := False;
end;

procedure TPlatformCocoaTouch.InitializeFormFactor(FormFactor: TFormFactor);
begin
  if Pos(UpperCase(GetModel), 'IPAD') > 0 then
    FormFactor.Orientations := [TFormOrientation.soPortrait, TFormOrientation.soLandscape,
      TFormOrientation.soInvertedPortrait, TFormOrientation.soInvertedLandscape]
  else
    FormFactor.Orientations := [TFormOrientation.soPortrait, TFormOrientation.soLandscape,
      TFormOrientation.soInvertedLandscape]
end;

function TPlatformCocoaTouch.InputQuery(const ACaption: string; const APrompts: array of string; var AValues: array of string;
  CloseQueryFunc: TInputCloseQueryFunc): Boolean;
var
  AlertView: UIAlertView;
  TextField: UITextField;
  Delegate: TFMXAlertViewInputDelegate;
begin
  if (Length(AValues) > 0) and (Length(APrompts) > 0) then
  begin
    Delegate := TFMXAlertViewInputDelegate.Create;
    Delegate.Modal := True;

    AlertView := TUIAlertView.Alloc;
    AlertView.initWithTitle(NSStr(ACaption), NSStr(APrompts[0]), ILocalObject(Delegate).GetObjectID,
      NSStr(SMsgDlgOK), nil);
    AlertView.addButtonWithTitle(NSStr(SMsgDlgCancel));
    AlertView.setAlertViewStyle(UIAlertViewStylePlainTextInput);
    TextField := TUITextField.Wrap(AlertView.textFieldAtIndex(0));
    TextField.setText(NSStr(AValues[0]));

    AlertView.show;
    while Delegate.Modal do
      TNSRunLoop.Wrap(TNSRunLoop.OCClass.currentRunLoop).runMode(NSDefaultRunLoopMode, TNSDate.Wrap(TNSDate.OCClass.date));

    Result := Delegate.Result = mrOk;
    if Result then
      AValues[0] := UTF8ToString(TNSString.Wrap(TextField.text).UTF8String);
  end
  else
    Result := False;
end;

{ }

procedure TPlatformCocoaTouch.DeleteObjectHandle(const FmxHandle: TFmxHandle);
begin
  ValidateHandle(FmxHandle);
  TMonitor.Enter(FObjectiveCMap);
  try
    FObjectMap.Remove(FmxHandle);
  finally
    TMonitor.Exit(FObjectiveCMap);
  end;
end;

{ TFMXViewController }

constructor TFMXViewController.Create;
var
  V: Pointer;
begin
  inherited;
  V := UIViewController(Super).initWithNibName(nil, nil);
  if GetObjectID <> V then
    UpdateObjectID(V);
end;

procedure CaptureSnapShotOfForm(Form: TCommonCustomForm);
var
  Image: UIImage;
  CtxRef: CGContextRef;
  ColorSpace: CGColorSpaceRef;
  ImageRef: CGImageRef;
  W, H: Integer;
  Bitmap: TBitmap;
  BitmapData: TBitmapData;
begin
  if not PlatformCocoa.FRotationViewAnimated and Assigned(Form) and Assigned(WindowHandleToPlatform(Form.Handle).GLView) then
  begin
    W := WindowHandleToPlatform(Form.Handle).GLView.drawableWidth;
    H := WindowHandleToPlatform(Form.Handle).GLView.drawableHeight;
    if (W > 0) and (H > 0) then
    begin
      Bitmap := TBitmap.Create(W, H);
      try
        IBitmapAccess(Bitmap).BitmapScale := WindowHandleToPlatform(Form.Handle).View.contentScaleFactor;

        TCustomForm(Form).PaintTo(Bitmap.Canvas);

        ColorSpace := CGColorSpaceCreateDeviceRGB;
        try
          if Bitmap.Map(TMapAccess.maRead, BitmapData) then
          try
            CtxRef := CGBitmapContextCreate(BitmapData.Data, W, H, 8, BitmapData.Pitch, ColorSpace, kCGImageAlphaPremultipliedLast or kCGBitmapByteOrder32Big);
            try
              ImageRef := CGBitmapContextCreateImage(CtxRef);
              try
                Image := TUIImage.Alloc;
                Image.initWithCGImage(ImageRef, Bitmap.BitmapScale, UIImageOrientationUp);

                PlatformCocoa.FRotationView := TUIImageView.Wrap(TUIImageView.Alloc.initWithImage(Image));
                Image.release;

                PlatformCocoa.FRotationView.setAutoresizingMask(UIViewAutoresizingFlexibleHeight or UIViewAutoresizingFlexibleWidth);
                PlatformCocoa.FRotationView.setFrame(CGRectMake(Form.Left, Form.Top, Form.Width, Form.Height));
              finally
                CGImageRelease(ImageRef);
              end;
            finally
              CGContextRelease(CtxRef);
            end;
          finally
            Bitmap.Unmap(BitmapData);
          end;
        finally
          CGColorSpaceRelease(ColorSpace);
        end;
      finally
        Bitmap.DisposeOf;
      end;
    end;
  end;
end;

procedure TFMXViewController.willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation;
  duration: NSTimeInterval);
var
  LFrame: NSRect;
  Form: TCommonCustomForm;
begin
  if Assigned(Screen.ActiveForm) then
    Form := Screen.ActiveForm
  else if Application.MainForm <> nil then
    Form := Application.MainForm
  else
    Form := nil;

  if Assigned(Form) then
  begin
    LFrame := WindowHandleToPlatform(Form.Handle).View.frame;

    if (Form is TCustomForm) then
    begin
      CaptureSnapShotOfForm(Form);
      if Assigned(PlatformCocoa.FRotationView) then
      begin
        PlatformCocoa.FRotationViewAnimated := True;
        TUIView.OCClass.setAnimationsEnabled(False);
        try
          WindowHandleToPlatform(Form.Handle).View.setAlpha(0.0);

          PlatformCocoa.FRotationView.setAlpha(1.0);
          PlatformCocoa.AppDelegate.MainWindow.RootView.insertSubview(PlatformCocoa.FRotationView, WindowHandleToPlatform(Form.Handle).View);
        finally
          TUIView.OCClass.setAnimationsEnabled(True);
        end;
        // Cross fade
        PlatformCocoa.FRotationView.setFrame(WindowHandleToPlatform(Form.Handle).View.frame);
        PlatformCocoa.FRotationView.setAlpha(0.0);
        WindowHandleToPlatform(Form.Handle).View.setAlpha(1.0);
      end;
    end;

    Form.SetBounds(round(LFrame.origin.x), round(LFrame.origin.y), round(LFrame.size.width), round(LFrame.size.height));
  end;

  TNSNotificationCenter.Wrap(TNSNotificationCenter.OCClass.defaultCenter).postNotificationName((NSSTR(FMXStartChangeDeviceOrientation) as ILocalObject).GetObjectID, nil);
end;

procedure TFMXViewController.didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation);
var
  LFrame: NSRect;
  Form: TCommonCustomForm;
  I: Integer;
begin
  UIViewController(Super).didRotateFromInterfaceOrientation(fromInterfaceOrientation);

  if Assigned(PlatformCocoa.FRotationView) and PlatformCocoa.FRotationViewAnimated then
  begin
    PlatformCocoa.FRotationView.removeFromSuperview;
    PlatformCocoa.FRotationView.release;
    PlatformCocoa.FRotationView := nil;
    PlatformCocoa.FRotationViewAnimated := False;
  end;

  if Assigned(Screen.ActiveForm) then
    Form := Screen.ActiveForm
  else if Application.MainForm <> nil then
    Form := Application.MainForm
  else
    Form := nil;

  if Assigned(Form) then
  begin
    LFrame := WindowHandleToPlatform(Form.Handle).View.frame;
    Form.SetBounds(round(LFrame.origin.x), round(LFrame.origin.y), round(LFrame.size.width), round(LFrame.size.height));
  end;

  for I := 0 to Screen.FormCount - 1 do
  begin
    Form := Screen.Forms[I];
    if (Form.Visible) and not (PlatformCocoa.IsPopupForm(Form)) then
    begin
      LFrame := WindowHandleToPlatform(Form.Handle).View.frame;
      Form.SetBounds(round(LFrame.origin.x), round(LFrame.origin.y), round(LFrame.size.width), round(LFrame.size.height));
    end;
  end;

end;

procedure TFMXViewController.didReceiveMemoryWarning;
begin
  UIViewController(Super).didReceiveMemoryWarning;
end;

function TFMXViewController.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(FMXViewController);
end;

function TFMXViewController.shouldAutorotate: Boolean;
begin
   Result := True;
end;

function TFMXViewController.shouldAutorotateToInterfaceOrientation(
  AinterfaceOrientation: UIInterfaceOrientation): Boolean;
begin
  case AinterfaceOrientation of
    UIInterfaceOrientationLandscapeLeft: Result :=  TFormOrientation.soLandscape in Application.FormFactor.Orientations;
    UIInterfaceOrientationLandscapeRight: Result :=  TFormOrientation.soInvertedLandscape in Application.FormFactor.Orientations;
    UIInterfaceOrientationPortrait: Result :=  TFormOrientation.soPortrait in Application.FormFactor.Orientations;
    UIInterfaceOrientationPortraitUpsideDown: Result :=  TFormOrientation.soInvertedPortrait in Application.FormFactor.Orientations;
  else
    Result := False;
  end;
end;

function TFMXViewController.supportedInterfaceOrientations: NSUInteger;
begin
  Result := 0;
  if Assigned(Application) then
  begin
    if TFormOrientation.soLandscape in Application.FormFactor.Orientations then
      Result := Result or UIInterfaceOrientationMaskLandscapeLeft;
    if TFormOrientation.soInvertedLandscape in Application.FormFactor.Orientations then
      Result := Result or UIInterfaceOrientationMaskLandscapeRight;
    if TFormOrientation.soPortrait in Application.FormFactor.Orientations then
      Result := Result or UIInterfaceOrientationMaskPortrait;
    if TFormOrientation.soInvertedPortrait in Application.FormFactor.Orientations then
      Result := Result or UIInterfaceOrientationMaskPortraitUpsideDown;
  end;
end;

procedure TFMXViewController.viewDidAppear(animated: Boolean);
begin
  UIViewController(Super).viewDidAppear(animated);
end;

procedure TFMXViewController.viewDidLayoutSubviews;
var
  LOrientation: Cardinal;
begin
  if Application.MainForm = nil then
  begin
    LOrientation := PlatformCocoa.UIApp.statusBarOrientation;
    case LOrientation of
      UIDeviceOrientationLandscapeLeft:
        PlatformCocoa.AppDelegate.MainWindow.RootView.setTransform(CGAffineTransform.Create(0, 1, -1, 0, 0, 0));
      UIDeviceOrientationLandscapeRight:
        PlatformCocoa.AppDelegate.MainWindow.RootView.setTransform(CGAffineTransform.Create(0, -1, 1, 0, 0, 0));
    end;
  end;
  UIViewController(Super).viewDidLayoutSubviews;
end;

procedure TFMXViewController.viewWillAppear(animated: Boolean);
begin
  UIViewController(Super).viewWillAppear(animated);
end;

procedure TFMXViewController.viewWillDisappear(animated: Boolean);
begin
  UIViewController(Super).viewWillDisappear(animated);
end;

{ TFMXWindow }

constructor TFMXWindow.Create(const ABounds: NSRect);
var
  V: Pointer;
begin
  inherited Create;
  V :=  UIWindow(Super).initWithFrame(ABounds);
  if GetObjectID <> V then
    UpdateObjectID(V);
end;

function TFMXWindow.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(FMXWindow);
end;

{ TFMXViewBase }

function TFMXViewBase.autocapitalizationType: UITextAutocapitalizationType;
begin
  Result := UIKeyboardAppearanceDefault;
end;

function TFMXViewBase.autocorrectionType: UITextAutocorrectionType;
begin
  if FKeyboardType <> TVirtualKeyboardType.vktDefault then
    Result := UITextAutocorrectionTypeNo
  else
    Result := UITextAutocorrectionTypeDefault;
end;

function TFMXViewBase.baseWritingDirectionForPosition(position: UITextPosition;
  inDirection: UITextStorageDirection): UITextWritingDirection;
begin
  Result := UITextWritingDirectionLeftToRight;
end;

function TFMXViewBase.beginningOfDocument: UITextPosition;
var
  LPos: TFMXTextPosition;
begin
  LPos := TFMXTextPosition.Create(0);
  Result := UITextPosition(LPos.Super);
end;

function TFMXViewBase.canBecomeFirstResponder: Boolean;
begin
  Result := True;
end;

function TFMXViewBase.canPerformAction(action: SEL; withSender: Pointer): Boolean;
begin
  Result := FContextMenu.CanPerformAction(action);
end;

function TFMXViewBase.canResignFirstResponder: Boolean;
begin
  Result := True;
end;

function TFMXViewBase.caretRectForPosition(position: UITextPosition): CGRect;
begin
  Result := CGRectMake(0, 0, 0, 0);
end;

function TFMXViewBase.characterRangeAtPoint(point: CGPoint): UITextRange;
begin
  Result := TUITextRange.Wrap(TFMXTextRange.Create(0, 0).GetObjectID);
end;

function TFMXViewBase.characterRangeByExtendingPosition(
  position: UITextPosition; inDirection: UITextLayoutDirection): UITextRange;
begin
  Result := TUITextRange.Wrap(TFMXTextRange.Create(0, 0).GetObjectID);
end;

function TFMXViewBase.closestPositionToPoint(point: CGPoint;
  withinRange: UITextRange): UITextPosition;
begin
  Result := TUITextPosition.Wrap(TFMXTextPosition.Create(0).GetObjectID);
end;

function TFMXViewBase.closestPositionToPoint(point: CGPoint): UITextPosition;
begin
  Result := TUITextPosition.Wrap(TFMXTextPosition.Create(0).GetObjectID);
end;

function TFMXViewBase.comparePosition(position, toPosition: UITextPosition): NSComparisonResult;
begin
  Result := NSOrderedSame;
end;

procedure TFMXViewBase.copy(Sender: id);
begin
  FContextMenu.Copy;
end;

constructor TFMXViewBase.Create(const AForm: TCommonCustomForm);
begin
  inherited Create;
  FForm := AForm;
  FContextMenu := TFMXTextEditActionsMenu.Create(UIView(Super));
  InitRecognizers;
  FSelectRange := NSMakeRange(0, 0);
  FMarkRange := NSMakeRange(NSNotFound, 0);
end;

procedure TFMXViewBase.cut(Sender: id);
begin
  FContextMenu.Cut;
end;

procedure TFMXViewBase.DblTap(X, Y: Single);

  function GetTappedControl: TFmxObject;
  var
    Obj: IControl;
  begin
    Obj := IControl(FForm.ObjectAtPoint(FForm.ClientToScreen(PointF(X, Y))));
    if Assigned(Obj) then
      Result := Obj.GetObject
    else
      Result := FForm;
  end;

var
  TouchEvents: ITouchEvents;
  EventInfo: TGestureEventInfo;
begin
  FGestureControl := GetTappedControl;
  if Assigned(FGestureControl) and FGestureControl.GetInterface(ITouchEvents, TouchEvents) then
  begin
    try
      TouchEvents.DblTap;
    finally
      TouchEvents := nil;
    end;
    FContextMenu.Show;
  end
  else
  begin
    while Assigned(FGestureControl) do
      if not (TInteractiveGesture.igDoubleTap in FGestureControl.Touch.InteractiveGestures) then
        FGestureControl := FGestureControl.Parent
      else
        Break;

    if Assigned(FGestureControl) then
    begin
      FillChar(EventInfo, Sizeof(EventInfo), 0);
      EventInfo.location := PointF(X, Y);
      EventInfo.GestureID := igiDoubleTap;

      // send message to the control
      FGestureControl.CMGesture(EventInfo);
    end;
  end;
end;

procedure TFMXViewBase.DefineFocusControl;
var
  FocusedControl: TControl;
begin
  if Assigned(Form.Focused) and (Form.Focused.GetObject is TControl) then
    FocusedControl := Form.Focused.GetObject as TControl
  else
    FocusedControl := nil;

  if Assigned(Form.Focused) and (FContextMenu.Control <> FocusedControl) then
    FCarretPositionChanged := True;
  FChangedFocusedControl := FContextMenu.Control <> FocusedControl;
  FContextMenu.Control := FocusedControl;
end;

procedure TFMXViewBase.deleteBackward;
var
  K: Word;
  Ch: Char;
begin
  if FMarkRange.location <> NSNotFound then
  begin
    FSelectRange.location := FMarkRange.location;
    FSelectRange.length := 0;
    FMarkRange := NSMakeRange(NSNotFound, 0);
  end
  else
    if FSelectRange.length > 0 then
    begin
      FSelectRange.length := 0;
    end
    else
    begin
      FSelectRange.location := FSelectRange.location - 1;
      FSelectRange.length := 0;
    end;

  K := vkBack;
  Ch := #0;
  try
    Form.KeyDown(K, Ch, []);
  except
    Application.HandleException(nil);
  end;

  PlatformCocoa.ResetIdleTimer;
end;

destructor TFMXViewBase.Destroy;
begin
  iOSapi.CocoaTypes.TNSObject.OCClass.cancelPreviousPerformRequestsWithTarget(Self.GetObjectID);
  FreeAndNil(FContextMenu);
  inherited Destroy;
end;

function TFMXViewBase.enablesReturnKeyAutomatically: Boolean;
begin
  Result := False;
end;

function TFMXViewBase.endOfDocument: UITextPosition;
begin
  Result := TUITextPosition.Wrap(TFMXTextPosition.Create(FText.length).GetObjectID);
end;

function TFMXViewBase.firstRectForRange(range: UITextRange): CGRect;
var
  glyphRect: CGRect;
  R: TRectF;
  TSObj: ITextInput;
begin
  if (Form.Focused <> nil) and Supports(Form.Focused, ITextInput, TSObj) then
  begin
    R := TRectF.Create(TSObj.GetTargetClausePointF);
  end
  else
  begin
    R := TControl(Form.Focused.GetObject).AbsoluteRect;
  end;

  glyphRect := CGRectMake(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
  Result := glyphRect;
end;

function TFMXViewBase.gestureRecognizer(gestureRecognizer: UIGestureRecognizer; shouldReceiveTouch: UITouch): Boolean;
var
  Obj: IControl;
  LPoint: NSPoint;
  GestureBeingRecognized: TInteractiveGesture;
  TouchEvents: ITouchEvents;
begin
  Result := False;

  if gestureRecognizer.isKindOfClass(objc_getClass('UIPanGestureRecognizer')) then
    GestureBeingRecognized := TInteractiveGesture.igPan
  else if gestureRecognizer.isKindOfClass(objc_getClass('UIRotationGestureRecognizer')) then
    GestureBeingRecognized := TInteractiveGesture.igRotate
  else if gestureRecognizer.isKindOfClass(objc_getClass('UIPinchGestureRecognizer')) then
    GestureBeingRecognized := TInteractiveGesture.igZoom
  else if gestureRecognizer.isKindOfClass(objc_getClass('UITapGestureRecognizer')) then
    GestureBeingRecognized := TInteractiveGesture.igTwoFingerTap
  else if gestureRecognizer.isKindOfClass(objc_getClass('UILongPressGestureRecognizer')) then
    GestureBeingRecognized := TInteractiveGesture.igLongTap
  else
    Exit;

  LPoint := shouldReceiveTouch.locationInView(UIView(Super));
  Obj := IControl(FForm.ObjectAtPoint(FForm.ClientToScreen(PointF(LPoint.X, LPoint.Y))));
  if Assigned(Obj) then
    FGestureControl := Obj.GetObject
  else
    FGestureControl := FForm;

  // If scrolling inside a TScrollBox - don't use pan, use touchesBegan/Moved/Ended instead
  if gestureRecognizer.isKindOfClass(objc_getClass('UIPanGestureRecognizer')) then
  begin
    if (FGestureControl is TScrollBox) or (FGestureControl is TSelectionPoint) then
    begin
      Exit;
    end;

    // If scrolling on top of a TCustomTrack or TSwitch  - don't use pan, use touchesBegan/Moved/Ended instead.
    //Can't scroll with finger on top of a TSwitch or.
    if (FGestureControl is TThumb)  or (FGestureControl is TSwitch) then
    begin
      Exit;
    end;
  end;

  //LongTap also works for text controls like TMemo.
  if GestureBeingRecognized = TInteractiveGesture.igLongTap then
    if Assigned(Obj) then
      if Obj.GetObject.GetInterface(ITouchEvents, TouchEvents) then
      begin
        Result := True;
        Exit;
      end;

  while Assigned(FGestureControl) do
  begin
    if not(GestureBeingRecognized in FGestureControl.Touch.InteractiveGestures) then
    begin
      FGestureControl := FGestureControl.Parent;
    end
    else
      Break;
  end;

  if Assigned(FGestureControl) then
    Result := True;

end;

function TFMXViewBase.gestureRecognizer(gestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer: UIGestureRecognizer): Boolean;
begin
  Result := True;
end;

function TFMXViewBase.gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer): Boolean;
begin
  Result := True;
end;

procedure TFMXViewBase.handlePan(gestureRecognizer: UIPanGestureRecognizer);
var
  Obj: IControl;
  LPoint, LPoint2: NSPoint;
  EventInfo: TGestureEventInfo;
begin
  FillChar(EventInfo, Sizeof(EventInfo), 0);
  LPoint := gestureRecognizer.locationInView(UIView(Super));

  if gestureRecognizer.state = UIGestureRecognizerStateBegan then
  begin
    //DoLMouseUp(LPoint.X, LPoint.Y);
    // Get the control from "under" the gesture.
    Obj := IControl(FForm.ObjectAtPoint(FForm.ClientToScreen(PointF(LPoint.X, LPoint.Y))));
    if Assigned(Obj) then
      FGestureControl := Obj.GetObject
    else
      FGestureControl := FForm;

    while Assigned(FGestureControl) do
    begin
      if not(TInteractiveGesture.igPan in FGestureControl.Touch.InteractiveGestures) then
      begin
        FGestureControl := FGestureControl.Parent;
      end
      else
      begin
        Break;
      end;
    end;
  end;

  if Assigned(FGestureControl) then
  begin
    EventInfo.location := PointF(LPoint.X, LPoint.Y);
    EventInfo.GestureID := igiPan;
    //set flags
    if gestureRecognizer.state = UIGestureRecognizerStateBegan then
      EventInfo.Flags := [TInteractiveGestureFlag.gfBegin]
    else if ((gestureRecognizer.state = UIGestureRecognizerStateEnded) or (gestureRecognizer.state = UIGestureRecognizerStateCancelled)) then
      EventInfo.Flags := [TInteractiveGestureFlag.gfEnd];

    //set distance in case there are 2 finger
                                                   
                    
    if gestureRecognizer.numberOfTouches = 2 then begin
      LPoint := gestureRecognizer.locationOfTouch(0, UIView(Super));
      Lpoint2 := gestureRecognizer.locationOfTouch(1, UIView(Super));
      EventInfo.Distance := Round(Sqrt(Sqr(LPoint.X - LPoint2.X) + Sqr(LPoint.Y - LPoint2.Y)));
    end;

    // send message to the control
    FGestureControl.CMGesture(EventInfo);

    //clear FGestureControl if gesture ended
    if ((gestureRecognizer.state = UIGestureRecognizerStateEnded) or (gestureRecognizer.state = UIGestureRecognizerStateCancelled)) then
      FGestureControl := nil;
  end;
end;

procedure TFMXViewBase.handleRotate(gestureRecognizer: UIRotationGestureRecognizer);
var
  Obj: IControl;
  LPoint: NSPoint;
  EventInfo: TGestureEventInfo;
begin
  FillChar(EventInfo, Sizeof(EventInfo), 0);
  LPoint := gestureRecognizer.locationInView(UIView(Super));

  if gestureRecognizer.state = UIGestureRecognizerStateBegan then
  begin
    //DoLMouseUp(LPoint.X, LPoint.Y);
    // Get the control from "under" the gesture.
    Obj := IControl(FForm.ObjectAtPoint(FForm.ClientToScreen(PointF(LPoint.X, LPoint.Y))));
    if Assigned(Obj) then
      FGestureControl := Obj.GetObject
    else
      FGestureControl := FForm;

    while Assigned(FGestureControl) do
    begin
      if not(TInteractiveGesture.igRotate in FGestureControl.Touch.InteractiveGestures) then
      begin
        FGestureControl := FGestureControl.Parent;
      end
      else
      begin
        Break;
      end;
    end;
  end;

  if Assigned(FGestureControl) then
  begin
    EventInfo.location := PointF(LPoint.X, LPoint.Y);
    EventInfo.GestureID := igiRotate;
    //set flags
    if gestureRecognizer.state = UIGestureRecognizerStateBegan then
      EventInfo.Flags := [TInteractiveGestureFlag.gfBegin]
    else if ((gestureRecognizer.state = UIGestureRecognizerStateEnded) or (gestureRecognizer.state = UIGestureRecognizerStateCancelled)) then
      EventInfo.Flags := [TInteractiveGestureFlag.gfEnd];

    //Rotation should be counterclockwise, just like on WIndows and MAC.
    EventInfo.Angle := -gestureRecognizer.rotation;

    // send message to the control
    FGestureControl.CMGesture(EventInfo);

    //clear FGestureControl if gesture ended
    if ((gestureRecognizer.state = UIGestureRecognizerStateEnded) or (gestureRecognizer.state = UIGestureRecognizerStateCancelled)) then
      FGestureControl := nil;
  end;
end;

procedure TFMXViewBase.handleTwoFingerTap(gestureRecognizer: UITapGestureRecognizer);
var
  Obj: IControl;
  LPoint: NSPoint;
  EventInfo: TGestureEventInfo;
begin
  FillChar(EventInfo, Sizeof(EventInfo), 0);
  LPoint := gestureRecognizer.locationInView(UIView(Super));

  if gestureRecognizer.state = UIGestureRecognizerStateBegan then
  begin
    //DoLMouseUp(LPoint.X, LPoint.Y);
    // Get the control from "under" the gesture.
    Obj := IControl(FForm.ObjectAtPoint(FForm.ClientToScreen(PointF(LPoint.X, LPoint.Y))));
    if Assigned(Obj) then
      FGestureControl := Obj.GetObject
    else
      FGestureControl := FForm;

    while Assigned(FGestureControl) do
    begin
      if not(TInteractiveGesture.igTwoFingerTap in FGestureControl.Touch.InteractiveGestures) then
      begin
        FGestureControl := FGestureControl.Parent;
      end
      else
      begin
        Break;
      end;
    end;
  end;

  if Assigned(FGestureControl) then
  begin
    EventInfo.Location := PointF(LPoint.X, LPoint.Y);
    EventInfo.GestureID := igiTwoFingertap;
    //set flags
    if gestureRecognizer.state = UIGestureRecognizerStateBegan then
      EventInfo.Flags := [TInteractiveGestureFlag.gfBegin]
    else if ((gestureRecognizer.state = UIGestureRecognizerStateEnded) or (gestureRecognizer.state = UIGestureRecognizerStateCancelled)) then
      EventInfo.Flags := [TInteractiveGestureFlag.gfEnd];

                     

    // send message to the control
    FGestureControl.CMGesture(EventInfo);

    //clear FGestureControl if gesture ended
    if ((gestureRecognizer.state = UIGestureRecognizerStateEnded) or (gestureRecognizer.state = UIGestureRecognizerStateCancelled)) then
      FGestureControl := nil;
  end;
end;

procedure TFMXViewBase.handleZoom(gestureRecognizer: UIPinchGestureRecognizer);
var
  Obj: IControl;
  LPoint, LPoint2: NSPoint;
  EventInfo: TGestureEventInfo;
begin
  FillChar(EventInfo, Sizeof(EventInfo), 0);
  LPoint := gestureRecognizer.locationInView(UIView(Super));

  if gestureRecognizer.state = UIGestureRecognizerStateBegan then
  begin
    //DoLMouseUp(LPoint.X, LPoint.Y);
    // Get the control from "under" the gesture.
    Obj := IControl(FForm.ObjectAtPoint(FForm.ClientToScreen(PointF(LPoint.X, LPoint.Y))));
    if Assigned(Obj) then
      FGestureControl := Obj.GetObject
    else
      FGestureControl := FForm;

    while Assigned(FGestureControl) do
    begin
      if not(TInteractiveGesture.igZoom in FGestureControl.Touch.InteractiveGestures) then
      begin
        FGestureControl := FGestureControl.Parent;
      end
      else
      begin
        Break;
      end;
    end;
  end;

  if Assigned(FGestureControl) then
  begin
    EventInfo.Location := PointF(LPoint.X, LPoint.Y);
    EventInfo.GestureID := igiZoom;
    //set flags
    if gestureRecognizer.state = UIGestureRecognizerStateBegan then
      EventInfo.Flags := [TInteractiveGestureFlag.gfBegin]
    else if ((gestureRecognizer.state = UIGestureRecognizerStateEnded) or (gestureRecognizer.state = UIGestureRecognizerStateCancelled)) then
      EventInfo.Flags := [TInteractiveGestureFlag.gfEnd];

    //set distance - the distance between the fingers on the screen
                                                    
    if gestureRecognizer.numberOfTouches = 2 then begin
      LPoint := gestureRecognizer.locationOfTouch(0, UIView(Super));
      Lpoint2 := gestureRecognizer.locationOfTouch(1, UIView(Super));
      EventInfo.Distance := Round(Sqrt(Sqr(LPoint.X - LPoint2.X) + Sqr(LPoint.Y - LPoint2.Y)));

      // send message to the control
      FGestureControl.CMGesture(EventInfo);
    end
    else
      if TInteractiveGestureFlag.gfEnd in EventInfo.Flags then
        FGestureControl.CMGesture(EventInfo);

    //clear FGestureControl if gesture ended
    if TInteractiveGestureFlag.gfEnd in EventInfo.Flags then
      FGestureControl := nil;
  end;
end;

function TFMXViewBase.hasText: Boolean;
begin
  Result := Length(FText) > 0;
end;

procedure TFMXViewBase.InitRecognizers;
var
  TwoFingerTapRecognizer: UITapgestureRecognizer;
  RotateRecognizer: UIRotationGestureRecognizer;
  ZoomRecognizer: UIPinchGestureRecognizer;
  PanRecognizer: UIPanGestureRecognizer;
  LongTapRecognizer: UILongPressGestureRecognizer;
begin
  //Pan recognizer
  PanRecognizer := TUIPanGestureRecognizer.Alloc;
  PanRecognizer := TUIPanGestureRecognizer.Wrap(PanRecognizer.initWithTarget(GetObjectID, sel_getUid('handlePan:')));
  PanRecognizer.setMinimumNumberOfTouches(1);
  PanRecognizer.setMaximumNumberOfTouches(2);
  PanRecognizer.setDelaysTouchesBegan(True);
  PanRecognizer.setCancelsTouchesInView(False);
  PanRecognizer.setDelegate(GetObjectID);
  UIView(Super).addGestureRecognizer(PanRecognizer);

  //Rotate recognizer
  RotateRecognizer := TUIRotationGestureRecognizer.Alloc;
  RotateRecognizer := TUIRotationGestureRecognizer.Wrap(RotateRecognizer.initWithTarget(GetObjectID, sel_getUid('handleRotate:')));
  RotateRecognizer.setDelaysTouchesBegan(True);
  RotateRecognizer.setCancelsTouchesInView(False);
  RotateRecognizer.setDelegate(GetObjectID);
  UIView(Super).addGestureRecognizer(RotateRecognizer);

  //Zoom (Pinch) recognizer
  ZoomRecognizer := TUIPinchGestureRecognizer.Alloc;
  ZoomRecognizer := TUIPinchGestureRecognizer.Wrap(ZoomRecognizer.initWithTarget(GetObjectID, sel_getUid('handleZoom:')));
  ZoomRecognizer.setDelaysTouchesBegan(True);
  ZoomRecognizer.setCancelsTouchesInView(False);
  ZoomRecognizer.setDelegate(GetObjectID);
  UIView(Super).addGestureRecognizer(ZoomRecognizer);

  //TwoFingerTap recognizer
  TwoFingerTapRecognizer := TUITapGestureRecognizer.Alloc;
  TwoFingerTapRecognizer := TUITapGestureRecognizer.Wrap(TwoFingerTapRecognizer.initWithTarget(GetObjectID, sel_getUid('handleTwoFingerTap:')));
  TwoFingerTapRecognizer.setNumberOfTapsRequired(1);
  TwoFingerTapRecognizer.setNumberOfTouchesRequired(2);
  TwoFingerTapRecognizer.setDelaysTouchesBegan(True);
  TwoFingerTapRecognizer.setCancelsTouchesInView(False);
  TwoFingerTapRecognizer.setDelegate(GetObjectID);
  UIView(Super).addGestureRecognizer(TwoFingerTapRecognizer);

  LongTapRecognizer := TUILongPressGestureRecognizer.Alloc;
  LongTapRecognizer := TUILongPressGestureRecognizer.Wrap(LongTapRecognizer.initWithTarget(GetObjectID, sel_getUid('LongTap:')));
  LongTapRecognizer.setDelaysTouchesBegan(True);
  LongTapRecognizer.setCancelsTouchesInView(False);
  LongTapRecognizer.setDelegate(GetObjectID);
  UIView(Super).addGestureRecognizer(LongTapRecognizer);
end;

procedure TFMXViewBase.HideContextMenu;
begin
  FContextMenu.Hide;
end;

function TFMXViewBase.inputDelegate: Pointer;
begin
  Result := nil;
end;

procedure TFMXViewBase.insertText(text: NSString);
var
  I: Integer;
  K: Word;
  Ch: Char;
  Str: string;
begin
  if FMarkRange.location <> NSNotFound then
  begin
    TTextServiceCocoa((Form.Focused as ITextInput).GetTextService).InternalSetMarkedText(EmptyStr);
    TTextServiceCocoa((Form.Focused as ITextInput).GetTextService).InternalEndIMEInput;
//    [_text replaceCharactersInRange:markedTextRange withString:text];
    FSelectRange.location := FMarkRange.location + text.length;
    FSelectRange.length := 0;
    FMarkRange := NSMakeRange(NSNotFound, 0);
  end
  else
    if FSelectRange.length > 0 then
    begin
//      [_text replaceCharactersInRange:selectedNSRange withString:text];
      FSelectRange.length := 0;
      FSelectRange.location := FSelectRange.location + text.length;
    end
    else
    begin
//      [_text insertString:text atIndex:selectedNSRange.location];
      FSelectRange.location := FSelectRange.location + text.length;
//      FForm.Focused := nil;
    end;

  if text.length > 0 then
  begin
    Str := UTF8ToUnicodeString(text.UTF8String);
    for I := Low(Str) to High(Str) do
    begin
      K := 0;
      Ch := Str[I];
      if Ch = #10 then
      begin
        K := vkReturn;
        Ch := #0;
        try
          Form.KeyDown(K, Ch, []);
        except
          Application.HandleException(Form);
        end;
      end
      else
        try
          Form.KeyDown(K, Ch, []);
        except
          Application.HandleException(Form);
        end;
    end;
  end;

  PlatformCocoa.ResetIdleTimer;
end;

function TFMXViewBase.isAccessibilityElement: Boolean;
begin
  Result := False;
end;

function TFMXViewBase.isFirstResponder: Boolean;
begin
  Result := True;
end;

function TFMXViewBase.isSecureTextEntry: Boolean;
begin
  Result := False;
end;

function TFMXViewBase.keyboardAppearance: UIKeyboardAppearance;
begin
  Result := UIKeyboardAppearanceDefault;
end;

function TFMXViewBase.keyboardType: UIKeyboardType;
begin
  case FKeyboardType of
    TVirtualKeyboardType.vktDefault:               Result := UIKeyboardTypeDefault;
    TVirtualKeyboardType.vktNumbersAndPunctuation: Result := UIKeyboardTypeNumbersAndPunctuation;
    TVirtualKeyboardType.vktNumberPad:             Result := UIKeyboardTypeNumberPad;
    TVirtualKeyboardType.vktPhonePad:              Result := UIKeyboardTypePhonePad;
    TVirtualKeyboardType.vktAlphabet:              Result := UIKeyboardTypeAlphabet;
    TVirtualKeyboardType.vktURL:                   Result := UIKeyboardTypeURL;
    TVirtualKeyboardType.vktNamePhonePad:          Result := UIKeyboardTypeNamePhonePad;
    TVirtualKeyboardType.vktEmailAddress:          Result := UIKeyboardTypeEmailAddress;
  else
    Result := UIKeyboardTypeDefault;
  end;
end;

procedure TFMXViewBase.LongTap(gestureRecognizer: UILongPressGestureRecognizer);
var
  TouchEvents: ITouchEvents;
  TouchPoint: NSPoint;
  ControlTmp: IControl;
  LocalPoint: TPointF;
  EventInfo: TGestureEventInfo;
  Handled: Boolean;
  Obj: IControl;
  HoveredObject: TFmxObject;
begin
  Handled := False;
  TouchPoint := gestureRecognizer.locationInView(Super as UIView);

  Obj := Form.ObjectAtPoint(FForm.ClientToScreen(PointF(TouchPoint.X, TouchPoint.Y)));
  try
    if Assigned(Obj) then
    begin
      LocalPoint := Obj.ScreenToLocal(FForm.ClientToScreen(PointF(TouchPoint.X, TouchPoint.Y)));
      HoveredObject := Obj.GetObject;
    end
    else
    begin
      LocalPoint := PointF(TouchPoint.X, TouchPoint.Y);
      HoveredObject := Form;
    end;

    case gestureRecognizer.state of
      UIGestureRecognizerStateBegan:
      begin
        HideContextMenu;
        DoLMouseDown(TouchPoint.x, TouchPoint.y);
        DefineFocusControl;
        if HoveredObject.GetInterface(ITouchEvents, TouchEvents) then
        begin
          TouchEvents.LongTap(LocalPoint.X, LocalPoint.Y);
          Handled := True;
        end;
      end;
      UIGestureRecognizerStateChanged:
        Form.MouseMove([ssTouch], TouchPoint.X, TouchPoint.Y);
      UIGestureRecognizerStateEnded:
        DoLMouseUp(TouchPoint.x, TouchPoint.y);
    end;
  finally
    TouchEvents := nil;
  end;

  if gestureRecognizer.state = UIGestureRecognizerStateBegan then
    if not Handled then
    begin
      // Get the control from "under" the gesture.
      ControlTmp := IControl(FForm.ObjectAtPoint(FForm.ClientToScreen(PointF(TouchPoint.X, TouchPoint.Y))));
      if Assigned(ControlTmp) then
        FGestureControl := ControlTmp.GetObject
      else
        FGestureControl := FForm;

      while Assigned(FGestureControl) do
        if not(TInteractiveGesture.igLongTap in FGestureControl.Touch.InteractiveGestures) then
          FGestureControl := FGestureControl.Parent
        else
          Break;

    if Assigned(FGestureControl) then
    begin
      FillChar(EventInfo, Sizeof(EventInfo), 0);
      EventInfo.location := PointF(TouchPoint.X, TouchPoint.Y);
      EventInfo.GestureID := igiLongTap;
      // set flags
      if gestureRecognizer.state = UIGestureRecognizerStateBegan then
        EventInfo.Flags := [TInteractiveGestureFlag.gfBegin]
      else if ((gestureRecognizer.state = UIGestureRecognizerStateEnded) or
        (gestureRecognizer.state = UIGestureRecognizerStateCancelled)) then
        EventInfo.Flags := [TInteractiveGestureFlag.gfEnd];

      // send message to the control
      FGestureControl.CMGesture(EventInfo);
    end;

    if gestureRecognizer.state = UIGestureRecognizerStateEnded then
      FContextMenu.Show;

    if ((gestureRecognizer.state = UIGestureRecognizerStateEnded) or
      (gestureRecognizer.state = UIGestureRecognizerStateCancelled)) then
      FGestureControl := nil;
  end;
end;

function TFMXViewBase.markedTextRange: UITextRange;
begin
  if FMarkRange.Length = 0 then
    Result := nil
  else
    Result := TUITextRange.Wrap(TFMXTextRange.Create(FMarkRange.Location, FMarkRange.Length).GetObjectID);
end;

function TFMXViewBase.markedTextStyle: NSDictionary;
begin
  Result := nil;
end;

function TFMXViewBase.offsetFromPosition(from, toPosition: UITextPosition): NSInteger;
begin
  Result := 0; //TUITextPosition(toPosition).FValue - TUITextPosition(from).FValue;
end;

procedure TFMXViewBase.paste(Sender: id);
begin
  try
    FContextMenu.Paste;
  except
    Application.HandleException(Self);
  end;
end;

function TFMXViewBase.positionFromPosition(position: UITextPosition;
  offset: NSInteger): UITextPosition;
begin
  Result := nil;
//  Result := TUITextPosition.Wrap(TFMXTextPosition.Create(TUITextPosition(position).FValue + offset).GetObjectID);
end;

function TFMXViewBase.positionFromPosition(position: UITextPosition;
  inDirection: UITextLayoutDirection; offset: NSInteger): UITextPosition;
begin
  Result := nil;
{  case inDirection of
    UITextLayoutDirectionRight: Result := TUITextPosition.alloc.initWith_Value(TUITextPosition(position).FValue + offset);
    UITextLayoutDirectionLeft: Result := TUITextPosition.alloc.initWith_Value(TUITextPosition(position).FValue + offset);
    UITextLayoutDirectionUp: Result := TUITextPosition.alloc.initWith_Value(TUITextPosition(position).FValue + offset);
    UITextLayoutDirectionDown: Result := TUITextPosition.alloc.initWith_Value(TUITextPosition(position).FValue + offset);
  end; }
end;

function TFMXViewBase.positionWithinRange(range: UITextRange;
  farthestInDirection: UITextLayoutDirection): UITextPosition;
begin
  Result := TUITextPosition.Wrap(TFMXTextPosition.Create(0).GetObjectID);
end;

procedure TFMXViewBase.replaceRange(range: UITextRange; withText: NSString);
{var
  i: Integer;
  K: Word;
  Ch: System.WideChar;
  Str: string;}
begin
  unmarkText;

  PlatformCocoa.ResetIdleTimer;
{  if FText.length > 0 then
  begin
    for i := 0 to FText.length - 1 do
    begin
      K := 0;
      Ch := FText[i];
      Form.KeyDown(K, Ch, []);
    end;
  end;}
end;

function TFMXViewBase.returnKeyType: UIReturnKeyType;
begin
  Result := UIReturnKeyDefault;
end;

procedure TFMXViewBase.select(Sender: id);
begin
  FContextMenu.Select;
end;

procedure TFMXViewBase.selectAll(Sender: id);
begin
  FContextMenu.SelectAll;
end;

function TFMXViewBase.selectedTextRange: UITextRange;
begin
  if FSelectRange.Length = 0 then
    Result := nil
  else
    Result := TUITextRange.Wrap(TFMXTextRange.Create(FSelectRange.Location, FSelectRange.Length).GetObjectID);
end;

procedure TFMXViewBase.setAutocapitalizationType(autocapitalizationType: UITextAutocapitalizationType);
begin
end;

procedure TFMXViewBase.setAutocorrectionType(autocorrectionType: UITextAutocorrectionType);
begin
end;

procedure TFMXViewBase.setBaseWritingDirection(writingDirection: UITextWritingDirection; forRange: UITextRange);
begin
end;

procedure TFMXViewBase.setEnablesReturnKeyAutomatically(enablesReturnKeyAutomatically: Boolean);
begin
end;

procedure TFMXViewBase.setInputDelegate(inputDelegate: Pointer);
begin
end;

procedure TFMXViewBase.setKeyboardAppearance(keyboardAppearance: UIKeyboardAppearance);
begin
end;

procedure TFMXViewBase.setKeyboardType(keyboardType: UIKeyboardType);
begin
end;

procedure TFMXViewBase.setMarkedText(markedText: NSString;  selectedRange: NSRange);
var
  TSC: ITextInput;
begin
  if not Assigned(Form.Focused) or not Supports(Form.Focused, ITextInput, TSC) then
    Exit;

  if FMarkRange.location <> NSNotFound then
  begin
    FMarkRange.length := markedText.length;
  end
  else
    if FSelectRange.length > 0 then
    begin
      FMarkRange.location := FSelectRange.location;
      FMarkRange.length := markedText.length;
    end
    else
    try
      FMarkRange.location := FSelectRange.location;
      FMarkRange.length := markedText.length;
      if Assigned(Form.Focused) and Supports(Form.Focused, ITextInput, TSC) then
        TTextServiceCocoa(TSC.GetTextService).InternalStartIMEInput;
    except
      Application.HandleException(Self);
    end;

  FSelectRange := NSMakeRange(FSelectRange.location + FMarkRange.location, FSelectRange.length);
  TTextServiceCocoa(TSC.GetTextService).SetCursorShift(markedText.length);
  TTextServiceCocoa(TSC.GetTextService).InternalSetMarkedText(UTF8ToString(markedText.UTF8String));
  FMarkText := UTF8ToString(markedText.UTF8String);
end;

procedure TFMXViewBase.setMarkedTextStyle(markedTextStyle: NSDictionary);
begin
end;

procedure TFMXViewBase.setReturnKeyType(returnKeyType: UIReturnKeyType);
begin
end;

procedure TFMXViewBase.setSecureTextEntry(secureTextEntry: Boolean);
begin
end;

procedure TFMXViewBase.setSelectedTextRange(selectedTextRange: UITextRange);
begin
end;

procedure TFMXViewBase.setSpellCheckingType(spellCheckingType: Integer);
begin
end;

procedure TFMXViewBase.ShowContextMenu;

  procedure DefineSelectionStates;
  var
    TextInput: ITextInput;
  begin
    if FContextMenu.HasControl and Assigned(Form) and Assigned(Form.Focused) and (Form.Focused.GetObject.GetInterface(ITextInput, TextInput)) then
      FCarretPositionChanged := TextInput.GetTextService.CaretPosition <> FLastCaretPosition
    else
      FCarretPositionChanged := False;
  end;

begin
  DefineSelectionStates;
  if not FCarretPositionChanged and not FLastContextMenuVisibility and
     not FClickedAnotherControl and not FChangedFocusedControl then
    FContextMenu.Show;
end;

procedure TFMXViewBase.SingleTap(Sender: id);
begin
  ShowContextMenu;
end;

function TFMXViewBase.spellCheckingType: Integer;
begin
  Result := 0;
end;

function TFMXViewBase.textInRange(range: UITextRange): NSString;
var
  TextInput: ITextInput;
begin
  if (Form.Focused.GetObject.GetInterface(ITextInput, TextInput)) then
    Result := NSSTR(TextInput.GetTextService.InternalGetMarkedText)
  else
    Result := NSSTR('');
end;

function TFMXViewBase.textRangeFromPosition(fromPosition, toPosition: UITextPosition): UITextRange;
begin
  Result := nil;
//  Result := TUITextRange.alloc.initWith_Location_Length(TUITextPosition(fromPosition).FValue, TUITextPosition(toPosition).FValue - TUITextPosition(fromPosition).FValue);
end;

function TFMXViewBase.tokenizer: Pointer;
begin
  Result := TUITextInputStringTokenizer.Alloc.initWithTextInput(UIView(super));
end;

function TFMXViewBase.GetTouchCoord(const touches: NSSet; const Window: UIView; var x, y: single): Boolean;
var
  touch : UITouch;
  p     : CGPoint;
begin
  Result := False;
  if Assigned(touches) and (touches.count = 1) then
  begin
    touch := TUITouch.Wrap(touches.anyObject);
    p := touch.locationInView(Window);
    x := p.x;
    y := p.y;
    Result := True;
  end;
end;

procedure TFMXViewBase.DoLMouseDown(const X, Y: Single);
var
  PopupList: TList<TPopup>;
  I: Integer;
begin
  if not FDown then
  try
    FDown := True;
    // Store all opened popup
    PopupList := TList<TPopup>.Create;
    try
      // Save all current opened TPopup Forms
      for I := 0 to GetPopupCount - 1 do
        PopupList.Add(GetPopup(I) as TPopup);

      if Assigned(Form) and (not Form.Released) then
      begin
        Form.MouseMove([ssTouch], X, Y);
        Application.ProcessMessages;
        Form.MouseDown(TMouseButton.mbLeft, [ssLeft, ssTouch], X, Y);
        Application.ProcessMessages;
      end;

      // Close only all old opened popup
      if not (Form.Owner is TPopup) then
      begin
        for I := 0 to PopupList.Count - 1 do
          ClosePopup(PopupList[I]);
        PopupList.Clear;
      end;
    finally
      PopupList.DisposeOf;
    end;
  except
    Application.HandleException(Form);
  end;
end;

procedure TFMXViewBase.DoLMouseMove(const X, Y: Single);
begin
  if FDown then
  try
    if Assigned(Form) and (not Form.Released) then
    begin
      Form.MouseMove([ssLeft, ssTouch], X, Y);
      Application.ProcessMessages;
    end;
  except
    Application.HandleException(Form);
  end;
end;

procedure TFMXViewBase.DoLMouseUp(const X, Y: Single);
begin
  if FDown then
  try
    FDown := False;
    if Assigned(Form) and (not Form.Released) then
    begin
      Form.MouseUp(TMouseButton.mbLeft, [ssLeft, ssTouch], X, Y);
      Application.ProcessMessages;
      Form.MouseLeave;
      Application.ProcessMessages;
    end;
  except
    Application.HandleException(Form);
  end;
end;

procedure TFMXViewBase.touchesBegan(touches: NSSet; withEvent: UIEvent);

  procedure ResetSelectionStates;
  begin
    FLastContextMenuVisibility := FContextMenu.IsVisible;
    FCarretPositionChanged := False;
  end;

var
  X, Y : single;
  TextInput: ITextInput;
  LPoint: TPointF;
  Obj: IControl;
  Touch: UITouch;
begin
  try
    if not GetTouchCoord(touches, UIView(Super), X, Y) then
      Exit;

                                                           
    LPoint := PointF(X, Y);

    // find the control from under the gesture
    Obj := IControl(Form.ObjectAtPoint(LPoint));
    if Assigned(Obj) then
      FGestureControl := Obj.GetObject
    else
      FGestureControl := Form;

    while Assigned(FGestureControl) and
      not Assigned(FGestureControl.touch.GestureEngine) do
      FGestureControl := FGestureControl.Parent;

    if Assigned(FGestureControl) then
      if Assigned(FGestureControl.Touch.GestureEngine) then
      begin
        TPlatformGestureEngine(FGestureControl.Touch.GestureEngine).InitialPoint := LPoint;

        // Retain the points/touches.
        TPlatformGestureEngine(FGestureControl.Touch.GestureEngine).ClearPoints;
        TPlatformGestureEngine(FGestureControl.Touch.GestureEngine).AddPoint(LPoint.X, LPoint.Y);
      end;

    ResetSelectionStates;

    // Hide old context menu and set new focused control
    if FContextMenu.IsVisible then
      FContextMenu.Hide;

    // Save caret position for define selection change before mouse down
    if FContextMenu.HasControl and FContextMenu.Control.GetInterface(ITextInput, TextInput) then
      FLastCaretPosition := TextInput.GetTextService.CaretPosition;
    try
      DoLMouseDown(X, Y);
      Touch := TUITouch.Wrap(touches.anyObject);
      if Touch.tapCount = 2 then
        iOSapi.CocoaTypes.TNSObject.OCClass.cancelPreviousPerformRequestsWithTarget(Self.GetObjectID);
      DefineFocusControl;
    finally
      FClickedAnotherControl := Assigned(Obj) and (FContextMenu.Control <> Obj.GetObject);
      UIView(Super).touchesBegan(touches, withEvent);
      PlatformCocoa.ResetIdleTimer;
    end;
  except
    Application.HandleException(Form);
  end;
end;

procedure TFMXViewBase.touchesCancelled(touches: NSSet; withEvent: UIEvent);

  procedure DefineSelectionStates;
  var
    TextInput: ITextInput;
  begin
    if FContextMenu.HasControl and Assigned(Form.Focused) and (Form.Focused.GetObject.GetInterface(ITextInput, TextInput)) then
      FCarretPositionChanged := TextInput.GetTextService.CaretPosition <> FLastCaretPosition
    else
      FCarretPositionChanged := False;
  end;

var
  X, Y : single;
const
  LGestureTypes: TGestureTypes = [TGestureType.gtStandard, TGestureType.gtRecorded, TGestureType.gtRegistered];
begin
  try
    if not GetTouchCoord(touches, UIView(Super), X, Y) then
      Exit;

    //reset the points/touches
    if Assigned(FGestureControl) then
    begin
      if Assigned(FGestureControl.Touch.GestureEngine) then
        TPlatformGestureEngine(FGestureControl.Touch.GestureEngine).ClearPoints;
      FGestureControl := nil;
    end;
    try
      DoLMouseUp(X, Y);
      DefineSelectionStates;
    finally
      UIView(Super).touchesCancelled(touches, withEvent);
      PlatformCocoa.ResetIdleTimer;
    end;
  except
    Application.HandleException(Form);
  end;
end;

procedure TFMXViewBase.touchesEnded(touches: NSSet; withEvent: UIEvent);

  procedure DefineSelectionStates;
  var
    TextInput: ITextInput;
  begin
     if Assigned(FContextMenu) and FContextMenu.HasControl and Assigned(Form) and
      Assigned(Form.Focused) and (Form.Focused.GetObject.GetInterface(ITextInput, TextInput)) then
      FCarretPositionChanged := TextInput.GetTextService.CaretPosition <> FLastCaretPosition
    else
      FCarretPositionChanged := False;
  end;

var
  X, Y : single;
  Touch: UITouch;
  EventInfo: TGestureEventInfo;
const
  LGestureTypes: TGestureTypes = [TGestureType.gtStandard, TGestureType.gtRecorded, TGestureType.gtRegistered];
begin
  try
    if not GetTouchCoord(touches, UIView(Super), X, Y) then
      Exit;

    if Assigned(FGestureControl) then
      if Assigned(FGestureControl.Touch.GestureEngine) then
      begin
        if TPlatformGestureEngine(FGestureControl.Touch.GestureEngine).PointCount > 1 then
        begin
          FillChar(EventInfo, Sizeof(EventInfo), 0);
          if TPlatformGestureEngine.IsGesture
            (TPlatformGestureEngine(FGestureControl.Touch.GestureEngine).Points,
            TPlatformGestureEngine(FGestureControl.Touch.GestureEngine).GestureList, LGestureTypes, EventInfo) then
          begin
            TPlatformGestureEngine(FGestureControl.Touch.GestureEngine).BroadcastGesture(FGestureControl, EventInfo);
          end;
        end;
      end;

    //reset the points/touches
    if Assigned(FGestureControl) then
    begin
      //FGestureControl.Touch.GestureEngine.ClearPoints;
      FGestureControl := nil;
    end;
    try
      DoLMouseUp(X, Y);
      Touch := TUITouch.Wrap(touches.anyObject);
      if Touch.tapCount = 2 then
        DblTap(X, Y)
      else
        NSObject(Self.Super).performSelector(sel_getUid('SingleTap:'), nil, DBL_TAP_DELAY);
      DefineSelectionStates;
    finally
      UIView(Super).touchesEnded(touches, withEvent);
      PlatformCocoa.ResetIdleTimer;
    end;
  except
    Application.HandleException(Form);
  end;
end;

procedure TFMXViewBase.touchesMoved(touches: NSSet; withEvent: UIEvent);
var
  X, Y : single;
begin
  try
    if not GetTouchCoord(touches, UIView(Super), X, Y) then
      Exit;
    if Assigned(FGestureControl) then
      if Assigned(FGestureControl.Touch.GestureEngine) then
        TPlatformGestureEngine(FGestureControl.touch.GestureEngine).AddPoint(X, Y);
    try
      DoLMouseMove(X, Y);
    finally
      UIView(Super).touchesMoved(touches, withEvent);
      PlatformCocoa.ResetIdleTimer;
    end;
  except
    Application.HandleException(Form);
  end;
end;

procedure TFMXViewBase.unmarkText;
var
  I: Integer;
  K: Word;
  Ch: System.WideChar;
  LITextInput: ITextInput;
begin
  if not Assigned(Form.Focused) then
    Exit;

  if not Supports(Form.Focused, ITextInput, LITextInput) then
    Exit;

  if FMarkRange.location = NSNotFound then
    Exit;

  TTextServiceCocoa(LITextInput.GetTextService).InternalBreakIMEInput;
  FMarkRange := NSMakeRange(NSNotFound, 0);
  FSelectRange := NSMakeRange(0, 0);
  if FMarkText.Length > 0 then
  begin
    for I := Low(FMarkText) to High(FMarkText) do
    begin
      K := 0;
      Ch := FMarkText.Chars[I];
      try
        Form.KeyDown(K, Ch, []);
      except
        Application.HandleException(Form);
      end;
    end;
  end;
  TTextServiceCocoa(LITextInput.GetTextService).InternalEndIMEInput;
  FMarkText := EmptyStr;

  PlatformCocoa.ResetIdleTimer;
end;

{ TFMXView }

constructor TFMXView.Create(const AOwner: TCommonCustomForm; AFRameRect: NSRect);
var
  V: Pointer;
begin
  inherited Create(AOwner);
  V := UIView(Super).initWithFrame(AFrameRect);
  if V <> GetObjectID then
    UpdateObjectID(V);
end;

procedure TFMXView.drawRect(R: CGRect);
var
  PaintControl: IPaintControl;
begin
  if (Form <> nil) and Supports(Form, IPaintControl, PaintControl) then
  begin
    PaintControl.ContextHandle := THandle(UIGraphicsGetCurrentContext);
    PaintControl.PaintRects([RectF(R.origin.x, R.origin.y, R.origin.x + R.size.width, R.origin.y + R.size.height)]);
    PaintControl.ContextHandle := 0;
  end;
  PlatformCocoa.ResetIdleTimer;
end;

function TFMXView.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(FMXView);
end;

{ TFMXView3D }

var
  GLKitMod: HMODULE;

constructor TFMXView3D.Create(const AOwner: TCommonCustomForm; AFRameRect: NSRect);
var
  V: Pointer;
begin
  GLKitMod := LoadLibrary(PWideChar(libGLKit));
  inherited Create(AOwner);
  V := GLKView(Super).initWithFrame(AFrameRect, TCustomContextOpenGL.SharedContext);
  GLKView(Super).setContentScaleFactor(TUIScreen.Wrap(TUIScreen.OCClass.mainScreen).scale);
  GLKView(Super).setDrawableDepthFormat(GLKViewDrawableDepthFormat24);
  GLKView(Super).setDrawableStencilFormat(GLKViewDrawableStencilFormat8);
  if V <> GetObjectID then
    UpdateObjectID(V);
end;

function TFMXView3D.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(FMXView3D);
end;

procedure TFMXView3D.drawRect(R: CGRect);
var
  PaintControl: IPaintControl;
begin
  if (Form <> nil) and Supports(Form, IPaintControl, PaintControl) then
    try
      PaintControl.PaintRects([Form.ClientRect]);
    except
      Application.HandleException(Form);
    end;
  PlatformCocoa.ResetIdleTimer;
end;

{ TFMXTextPosition }

constructor TFMXTextPosition.Create(AValue: Integer);
begin
  inherited Create;
  FPosition := AValue;
end;

function TFMXTextPosition.GetObjectiveCClass: PTypeInfo;
begin
    Result := TypeInfo(FMXTextPosition);
end;

{ TFMXTextRange }

constructor TFMXTextRange.Create(const ALocation, ALength: Integer);
begin
  inherited Create;
  FRange.Location := ALocation;
  FRange.Length := ALength;
end;

function TFMXTextRange.&end: UITextPosition;
begin
  Result := TUITextPosition.Wrap(TFMXTextPosition.Create(FRange.Location + FRange.Length).GetObjectID);
end;

function TFMXTextRange.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(FMXTextRange);
end;

function TFMXTextRange.isEmpty: Boolean;
begin
  Result := (FRange.Length = 0);
end;

function TFMXTextRange.start: UITextPosition;
begin
  Result := TUITextPosition.Wrap(TFMXTextPosition.Create(FRange.Location).GetObjectID);
end;

{ TFMXEditActionsMenu }

constructor TFMXEditActionsMenu.Create(const AParentView: UIView);
begin
  Assert(Assigned(AParentView), 'Context menu must have parent UIView');
  FParentView := AParentView;
  FMenuController := TUIMenuController.Wrap(TUIMenuController.OCClass.sharedMenuController);
end;

function TFMXEditActionsMenu.DefineActionType(
  const AAction: SEL): TStandartActionType;
begin
  if AAction = sel_getUid('select:') then
    Result := TStandartActionType.satSelect
  else
  if AAction = sel_getUid('selectAll:') then
    Result := TStandartActionType.satSelectAll
  else
  if AAction = sel_getUid('copy:') then
    Result := TStandartActionType.satCopy
  else
  if AAction = sel_getUid('paste:') then
    Result := TStandartActionType.satPaste
  else
  if AAction = sel_getUid('cut:') then
    Result := TStandartActionType.satCut
  else
  if AAction = sel_getUid('PromptForReplace:') then
    Result := TStandartActionType.satPromptForReplace
  else
  if AAction = sel_getUid('replace:') then
    Result := TStandartActionType.satReplace
  else
    Result := TStandartActionType.satUnknow;
end;

destructor TFMXEditActionsMenu.Destroy;
begin
  FParentView := nil;
  FMenuController := nil;
  inherited Destroy;
end;

procedure TFMXEditActionsMenu.DoControlChanged;
begin
  // Nothing
end;

procedure TFMXEditActionsMenu.DoDefineSelectionFrame(var Frame: CGRect);
begin

end;

function TFMXEditActionsMenu.HasControl: Boolean;
begin
  Result := Assigned(Control);
end;

procedure TFMXEditActionsMenu.Hide;
begin
  if IsVisible then
    FMenuController.setMenuVisible(False{, True});
end;

function TFMXEditActionsMenu.IsVisible: Boolean;
begin
  Result := FMenuController.isMenuVisible;
end;

procedure TFMXEditActionsMenu.SetControl(const AControl: TControl);
begin
  if FControl <> AControl then
  begin
    FControl := AControl;
    DoControlChanged;
    Hide;
  end;
end;

procedure TFMXEditActionsMenu.Show;
var
  AbsolutePos: TPointF;
  ControlFrame: CGRect;
begin
  FReplaceMenu := False;
  if not HasControl then
    Exit;
  // Define default control frame
  AbsolutePos := FControl.LocalToAbsolute(PointF(0, 0));
  ControlFrame := CGRectMake(AbsolutePos.X, AbsolutePos.Y, FControl.Width, FControl.Height);
  // Define user control frame
  DoDefineSelectionFrame(ControlFrame);
  // Show menu
  FMenuController.setTargetRect(ControlFrame, FParentView);
  FMenuController.update;
  FMenuController.setMenuVisible(True, True);
end;

{ TFMXTextEditActionsMenu }

function TFMXTextEditActionsMenu.CanPerformAction(const AAction: SEL): Boolean;
var
  ClipboardService: IFMXClipboardService;
begin
  ClipboardService := GetClipboardService;
  try
    Result := Assigned(FTextInput) and Assigned(ClipboardService);
    if Result then
      case DefineActionType(AAction) of
        satCut:
          Result := not FTextInput.GetSelection.IsEmpty and not FReplaceMenu;
        satCopy:
          Result := not FTextInput.GetSelection.IsEmpty and not FReplaceMenu;
        satPaste:
          Result := ClipboardService.GetClipboard.IsType<string> and
                    not ClipboardService.GetClipboard.IsEmpty and not FReplaceMenu;
        satSelect:
          Result := FTextInput.GetSelection.IsEmpty and FTextInput.HasText and not FReplaceMenu;
        satSelectAll:
          Result := FTextInput.GetSelection.IsEmpty and FTextInput.HasText and not FReplaceMenu;
        satUnknow:
          Result := False;
        satPromptForReplace:
          Result := not FTextInput.GetSelection.IsEmpty and not FReplaceMenu;
        satReplace:
          Result := not FTextInput.GetSelection.IsEmpty and FReplaceMenu;
      else
        Result := False;
      end;
  finally
    ClipboardService := nil;
  end;
end;

procedure TFMXTextEditActionsMenu.Copy;
begin
  if Assigned(FTextActions) then
    FTextActions.CopyToClipboard;
end;

procedure TFMXTextEditActionsMenu.Cut;
begin
  if Assigned(FTextActions) then
    FTextActions.CutToClipboard;
end;

procedure TFMXTextEditActionsMenu.DoControlChanged;
begin
  if Assigned(Control) then
  begin
    Supports(Control, ITextInput, FTextInput);
    Supports(Control, ITextActions, FTextActions)
  end
  else
  begin
    FTextInput := nil;
    FTextActions := nil;
  end;
end;

procedure TFMXTextEditActionsMenu.DoDefineSelectionFrame(var Frame: CGRect);
var
  SelectionRect: TRectF;
  AbsolutePos: TPointF;
begin
  if Assigned(FTextInput) then
  begin
    SelectionRect := FTextInput.GetSelectionRect;
    AbsolutePos := FControl.LocalToAbsolute(SelectionRect.TopLeft);
    Frame := CGRectMake(AbsolutePos.X, AbsolutePos.Y, SelectionRect.Width, SelectionRect.Height);
  end;
end;

function TFMXTextEditActionsMenu.GetClipboardService: IFMXClipboardService;
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, IInterface(Result));
end;

procedure TFMXTextEditActionsMenu.Paste;
begin
  if Assigned(FTextActions) then
    FTextActions.PasteFromClipboard;
end;

procedure TFMXTextEditActionsMenu.PromptForReplace;

  function GetLanguage: NSString;
  begin
    Result := TNSString.Wrap(TUITextChecker.OCClass.availableLanguages.objectAtIndex(0));
    if not Assigned(Result) then
      Result := NSStr('en_US');
  end;

var
  TheLanguage: NSString;
  StringRange: NSRange;
  TextChecker: UITextChecker;
  CurrentOffset: NSInteger;
  CurrentRange: NSRange;
  Guesses: NSArray;

  TheText: NSString;
  Word: NSString;
  MenuTmp: UIMenuItem;
  I: Integer;

  GuessesMenuItems: NSMutableArray;
begin
  if not Assigned(FTextInput) or not Assigned(FTextActions) then
    Exit;

  TextChecker := TUITextChecker.Create;
  CurrentOffset := 0;
  StringRange.location := 0;
  TheText := NSSTR(FTextInput.GetSelection);
  StringRange.length := TheText.length - 1;

  TheLanguage := GetLanguage;

  currentRange := TextChecker.rangeOfMisspelledWordInString(TheText,
    StringRange, CurrentOffset, False, TheLanguage);

  if CurrentRange.location = NSNotFound then
    Exit;

  Guesses := TextChecker.guessesForWordRange(currentRange, theText, theLanguage);
  GuessesMenuItems := TNSMutableArray.Create;
  for I := 0 to Guesses.count - 1 do
  begin
    MenuTmp := TUIMenuItem.Alloc;
    Word := TNSString.Wrap(Guesses.objectAtIndex(I));
    MenuTmp.initWithTitle(Word, sel_getUid('replace:'));
    GuessesMenuItems.addObject((MenuTmp as ILocalObject).GetObjectID);
  end;

  Hide;
  FReplaceMenu := True;
  FMenuController.setMenuItems( GuessesMenuItems);
//  FMenuController.setTargetRect(ControlFrame, FParentView);
  FMenuController.setMenuVisible(True{, True});

//  currentOffset := currentOffset + currentRange.length - 1;
end;

procedure TFMXTextEditActionsMenu.Select;
begin
  if Assigned(FTextActions) then
  begin
    FTextActions.SelectWord;
    Show;
  end;
end;

procedure TFMXTextEditActionsMenu.SelectAll;
begin
  if Assigned(FTextActions) then
  begin
    FTextActions.SelectAll;
    Show;
  end;
end;

{ TiOSWindowHandle }

function WindowHandleToPlatform(const AHandle: TWindowHandle): TiOSWindowHandle;
begin
  Result := TiOSWindowHandle(AHandle);
end;

constructor TiOSWindowHandle.Create(const AHandle: TOCLocal);
begin
  inherited Create;
  FHandle := AHandle;
end;

function TiOSWindowHandle.GetForm: TCommonCustomForm;
begin
  Result := TFMXViewBase(FHandle).Form;
end;

function TiOSWindowHandle.GetGLView: GLKView;
begin
  Result := GLKView(TFMXViewBase(FHandle).Super);
end;

function TiOSWindowHandle.GetView: UIView;
begin
  Result := UIView(TFMXViewBase(FHandle).Super);
end;

{ TiOSOpenApplicationContext }

constructor TiOSOpenApplicationContext.Create(ASourceApp: string; AURL: string; AContext: Pointer);
begin
  inherited Create;
  FSourceApp := ASourceApp;
  FURL := AURL;
  FContext := AContext;
end;

initialization

finalization
  FreeLibrary(GLKitMod);
end.
