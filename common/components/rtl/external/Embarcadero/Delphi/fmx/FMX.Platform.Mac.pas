{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Platform.Mac;

interface

uses
  Macapi.ObjectiveC, Macapi.CocoaTypes, System.Types, System.UITypes, System.Classes,
  System.Generics.Collections, Macapi.AppKit, FMX.Types, FMX.Platform,
  FMX.Text, FMX.Forms, FMX.Controls;

type

  TMacWindowHandle = class(TWindowHandle)
  private class var
    FWindowHandles: TList<TMacWindowHandle>;
  private
    FHandle: TOCLocal;
    FBufferSize: TSize;
    FBuffer: CGContextRef;
    FBits: Pointer;
    function GetWindow: NSWindow;
    function GetView: NSView;
    function GetGLView: NSOpenGLView;
    function GetForm: TCommonCustomForm;
    procedure UpdateLayer(const Ctx: CGContextRef);
    procedure CreateBuffer;
    procedure FreeBuffer;
  public
    constructor Create(const AHandle: TOCLocal);
    destructor Destroy; override;
    class function FindForm(const window: NSWindow): TCommonCustomForm;
    property Wnd: NSWindow read GetWindow;
    property View: NSView read GetView;
    property GLView: NSOpenGLView read GetGLView;
    property Form: TCommonCustomForm read GetForm;
    property Handle: TOCLocal read FHandle;
  end;

function WindowHandleToPlatform(const AHandle: TWindowHandle): TMacWindowHandle;

procedure RegisterCorePlatformServices;
procedure UnregisterCorePlatformServices;

function ShiftStateFromModFlags(M: NSUInteger): TShiftState;

implementation

uses
  System.SysUtils, System.TypInfo, System.SyncObjs, System.Rtti, System.Math,
  FMX.Dialogs, FMX.Menus, Macapi.Foundation, Macapi.QuartzCore, Macapi.CoreGraphics,
  Macapi.ObjCRuntime, Macapi.CoreFoundation, System.RegularExpressions, System.StrUtils,
  System.Variants, FMX.Consts,
  FMX.Canvas.Mac,
  FMX.Canvas.GPU,
  FMX.Context.Mac,
  FMX.ExtCtrls, FMX.Gestures, FMX.Gestures.Mac, FMX.Objects, FMX.Styles, FMX.Messages,
  FMX.TextLayout, FMX.Types3D, FMX.Controls.Mac, FMX.Forms.Border.Mac;

const
  KEY_ENTER        = $24;
  KEY_SPACE        = $31;
  KEY_ESC          = $35;
  KEY_F1           = $7A;
  KEY_F2           = $78;
  KEY_F3           = $63;
  KEY_F4           = $76;
  KEY_F5           = $60;
  KEY_F6           = $61;
  KEY_F7           = $62;
  KEY_F8           = $64;
  KEY_F9           = $65;
  KEY_F10          = $6D;
  KEY_F11          = $67;
  KEY_F12          = $6F;
  KEY_F13          = $69;
  KEY_F14          = $6B;
  KEY_F15          = $71;
  KEY_F16          = $6A;
  KEY_F17          = $40;
  KEY_F18          = $4F;
  KEY_F19          = $50;
  KEY_POWER        = $7F7F;
  KEY_TAB          = $30;
  KEY_INS          = $72;
  KEY_DEL          = $75;
  KEY_HOME         = $73;
  KEY_END          = $77;
  KEY_PAGUP        = $74;
  KEY_PAGDN        = $79;
  KEY_UP           = $7E;
  KEY_DOWN         = $7D;
  KEY_LEFT         = $7B;
  KEY_RIGHT        = $7C;
  KEY_NUMLOCK      = $47;
  KEY_NUMPADEQUAL  = $51;
  KEY_NUMPAD0      = $52;
  KEY_NUMPAD1      = $53;
  KEY_NUMPAD2      = $54;
  KEY_NUMPAD3      = $55;
  KEY_NUMPAD4      = $56;
  KEY_NUMPAD5      = $57;
  KEY_NUMPAD6      = $58;
  KEY_NUMPAD7      = $59;
  KEY_NUMPAD8      = $5b;
  KEY_NUMPAD9      = $5c;
  KEY_PADDIV       = $4B;
  KEY_PADMULT      = $43;
  KEY_PADSUB       = $4E;
  KEY_PADADD       = $45;
  KEY_PADDEC       = $41;
  KEY_PADENTER     = $4C;
  KEY_BACKSPACE    = $33;
  KEY_CAPSLOCK     = $39;
  KEY_1            = 18;
  KEY_2            = 19;
  KEY_3            = 20;
  KEY_4            = 21;
  KEY_5            = 23;
  KEY_6            = 22;
  KEY_7            = 26;
  KEY_8            = 28;
  KEY_9            = 25;
  KEY_0            = 29;

  KEY_Q            = 12;
  KEY_W            = 13;
  KEY_E            = 14;
  KEY_R            = 15;
  KEY_T            = 17;
  KEY_Y            = 16;
  KEY_U            = 32;
  KEY_I            = 34;
  KEY_O            = 31;
  KEY_P            = 35;
  KEY_A            = 0;
  KEY_S            = 1;
  KEY_D            = 2;
  KEY_F            = 3;
  KEY_G            = 5;
  KEY_H            = 4;
  KEY_J            = 38;
  KEY_K            = 40;
  KEY_L            = 37;
  KEY_Z            = 6;
  KEY_X            = 7;
  KEY_C            = 8;
  KEY_V            = 9;
  KEY_B            = 11;
  KEY_N            = 45;
  KEY_M            = 46;

  KEY_TILDE        = 50; // `/~ key
  KEY_PARA         = 10; // PlusMinus / Paragraph
  KEY_MINUS        = 27; // -/_ key
  KEY_EQUAL        = 24; // =/+ key
  KEY_BACKSLASH    = 42; // \/| key
  KEY_LEFTBRACKET  = 33; // [/{ key
  KEY_RIGHTBRACKET = 30; // ]/} key
  KEY_QUOTE        = 39; // '/" key
  KEY_SEMICOLON    = 41; // ;/: key
  KEY_COMMA        = 43; // ,/< key
  KEY_SLASH        = 44; // //? key
  KEY_PERIOD       = 47; // ./> key

type
  TKeyCode = record
    OSX: Word;
    Win: Word;
  end;

const
  MacToWin: array [0..34] of TKeyCode = (
    (OSX: KEY_F1       ; Win: vkF1),
    (OSX: KEY_F2       ; Win: vkF2),
    (OSX: KEY_F3       ; Win: vkF3),
    (OSX: KEY_F4       ; Win: vkF4),
    (OSX: KEY_F5       ; Win: vkF5),
    (OSX: KEY_F6       ; Win: vkF6),
    (OSX: KEY_F7       ; Win: vkF7),
    (OSX: KEY_F8       ; Win: vkF8),
    (OSX: KEY_F9       ; Win: vkF9),
    (OSX: KEY_F10      ; Win: vkF10),
    (OSX: KEY_F11      ; Win: vkF11),
    (OSX: KEY_F12      ; Win: vkF12),
    (OSX: KEY_F13      ; Win: vkF13),
    (OSX: KEY_F14      ; Win: vkF14),
    (OSX: KEY_F15      ; Win: vkF15),
    (OSX: KEY_F16      ; Win: vkF16),
    (OSX: KEY_F17      ; Win: vkF17),
    (OSX: KEY_F18      ; Win: vkF18),
    (OSX: KEY_F19      ; Win: vkF19),
    (OSX: KEY_TAB      ; Win: vkTab),
    (OSX: KEY_INS      ; Win: vkInsert),
    (OSX: KEY_DEL      ; Win: vkDelete),
    (OSX: KEY_HOME     ; Win: vkHome),
    (OSX: KEY_END      ; Win: vkEnd),
    (OSX: KEY_PAGUP    ; Win: vkPrior),
    (OSX: KEY_PAGDN    ; Win: vkNext),
    (OSX: KEY_UP       ; Win: vkUp),
    (OSX: KEY_DOWN     ; Win: vkDown),
    (OSX: KEY_LEFT     ; Win: vkLeft),
    (OSX: KEY_RIGHT    ; Win: vkRight),
    (OSX: KEY_NUMLOCK  ; Win: vkNumLock),
    (OSX: KEY_PADENTER ; Win: vkReturn),
    (OSX: KEY_BACKSPACE; Win: vkBack),
    (OSX: KEY_ENTER    ; Win: vkReturn),
    (OSX: KEY_ESC      ; Win: vkEscape)
  );

  MacToWinEx: array [0..62] of TKeyCode = (
    (OSX: KEY_NUMPAD0  ; Win: vkNumpad0),
    (OSX: KEY_NUMPAD1  ; Win: vkNumpad1),
    (OSX: KEY_NUMPAD2  ; Win: vkNumpad2),
    (OSX: KEY_NUMPAD3  ; Win: vkNumpad3),
    (OSX: KEY_NUMPAD4  ; Win: vkNumpad4),
    (OSX: KEY_NUMPAD5  ; Win: vkNumpad5),
    (OSX: KEY_NUMPAD6  ; Win: vkNumpad6),
    (OSX: KEY_NUMPAD7  ; Win: vkNumpad7),
    (OSX: KEY_NUMPAD8  ; Win: vkNumpad8),
    (OSX: KEY_NUMPAD9  ; Win: vkNumpad9),
    (OSX: KEY_PADDIV   ; Win: vkDivide),
    (OSX: KEY_PADMULT  ; Win: vkMultiply),
    (OSX: KEY_PADSUB   ; Win: vkSubtract),
    (OSX: KEY_PADADD   ; Win: vkAdd),
    (OSX: KEY_PADDEC   ; Win: vkDecimal),

    (OSX: KEY_SEMICOLON   ; Win: vkSemicolon),
    (OSX: KEY_EQUAL       ; Win: vkEqual),
    (OSX: KEY_COMMA       ; Win: vkComma),
    (OSX: KEY_MINUS       ; Win: vkMinus),
    (OSX: KEY_PERIOD      ; Win: vlPeriod),
    (OSX: KEY_SLASH       ; Win: vkSlash),
    (OSX: KEY_TILDE       ; Win: vkTilde),
    (OSX: KEY_LEFTBRACKET ; Win: vkLeftBracket),
    (OSX: KEY_BACKSLASH   ; Win: vkBackslash),
    (OSX: KEY_RIGHTBRACKET; Win: vkRightBracket),
    (OSX: KEY_QUOTE       ; Win: vkQuote),
    (OSX: KEY_PARA        ; Win: vkBrowserForward),
    (OSX: KEY_1           ; Win: vk1),
    (OSX: KEY_2           ; Win: vk2),
    (OSX: KEY_3           ; Win: vk3),
    (OSX: KEY_4           ; Win: vk4),
    (OSX: KEY_5           ; Win: vk5),
    (OSX: KEY_6           ; Win: vk6),
    (OSX: KEY_7           ; Win: vk7),
    (OSX: KEY_8           ; Win: vk8),
    (OSX: KEY_9           ; Win: vk9),
    (OSX: KEY_0           ; Win: vk0),

    (OSX: KEY_Q           ; Win: vkQ),
    (OSX: KEY_W           ; Win: vkW),
    (OSX: KEY_E           ; Win: vkE),
    (OSX: KEY_R           ; Win: vkR),
    (OSX: KEY_T           ; Win: vkT),
    (OSX: KEY_Y           ; Win: vkY),
    (OSX: KEY_U           ; Win: vkU),
    (OSX: KEY_I           ; Win: vkI),
    (OSX: KEY_O           ; Win: vkO),
    (OSX: KEY_P           ; Win: vkP),
    (OSX: KEY_A           ; Win: vkA),
    (OSX: KEY_S           ; Win: vkS),
    (OSX: KEY_D           ; Win: vkD),
    (OSX: KEY_F           ; Win: vkF),
    (OSX: KEY_G           ; Win: vkG),
    (OSX: KEY_H           ; Win: vkH),
    (OSX: KEY_J           ; Win: vkJ),
    (OSX: KEY_K           ; Win: vkK),
    (OSX: KEY_L           ; Win: vkL),
    (OSX: KEY_Z           ; Win: vkZ),
    (OSX: KEY_X           ; Win: vkX),
    (OSX: KEY_C           ; Win: vkC),
    (OSX: KEY_V           ; Win: vkV),
    (OSX: KEY_B           ; Win: vkB),
    (OSX: KEY_N           ; Win: vkN),
    (OSX: KEY_M           ; Win: vkM)
    );

  IntervalPress = 1/24/60/60/10;

type
{$M+}

  TApplicationDelegate = class(TOCLocal, NSApplicationDelegate)
  public
    procedure applicationWillTerminate(Notification: Pointer); cdecl;
    procedure applicationDidFinishLaunching(Notification: Pointer); cdecl;
  end;

  { TPlatformCocoa }

  TPlatformCocoa = class(TInterfacedObject, IFMXApplicationService, IFMXSystemFontService,
    IFMXTimerService, IFMXWindowService, IFMXMenuService, IFMXDragDropService, IFMXClipboardService,
    IFMXCursorService, IFMXMouseService, IFMXScreenService, IFMXLocaleService, IFMXDialogService,
    IFMXTextService, IFMXContextService, IFMXCanvasService, IFMXStyleService, IFMXStyleHiResService, IFMXWindowBorderService,
    IFMXHideAppService, IFMXSystemInformationService, IFMXLoggingService)
  private type
    TCurrentMenu = (cmSystem, cmDefault, cmMain);
  private
    NSApp: NSApplication;
    FAppDelegate: NSApplicationDelegate;
    FRunLoopObserver: CFRunLoopObserverRef;
    FAppKitMod: HMODULE;
    FHandleCounter: TFmxHandle;
    FObjectiveCMap: TDictionary<TFmxHandle, IObjectiveC>;
    FNSHandles: TList<TFmxHandle>;
    FTimers: TList<TFmxHandle>;
    FModalStack: TStack<TCommonCustomForm>;
    FRestartModal: Boolean;
    FMenuBar: NSMenu;
    FMainMenu: NSMenu;
    FInDestroyMenuItem: Boolean;
    FDefaultMenu: TCurrentMenu;
    FClassHookCount: Integer;
    FTerminating: Boolean;
    FCursor: TCursor;
    function NewFmxHandle: TFmxHandle;
    procedure ValidateHandle(FmxHandle: TFmxHandle);
    function HandleToObjC(FmxHandle: TFmxHandle): IObjectiveC; overload;
    function HandleToObjC(FmxHandle: TFmxHandle; const IID: TGUID; out Intf): Boolean; overload;
    function AllocHandle(const Objc: IObjectiveC): TFmxHandle;
    procedure DeleteHandle(FmxHandle: TFmxHandle);
    procedure CreateChildMenuItems(AChildMenu: IItemsContainer; AParentMenu: NSMenu);
    procedure DoReleaseWindow(AForm: TCommonCustomForm);
    procedure RemoveChildHandles(const AMenu: IItemsContainer);
    procedure HookFrame(const NSWin: NSWindow);
    procedure UnHookFrame(const NSWin: NSWindow);
    procedure ClearNSHandles;
    function NewNSMenu(const Text: string): NSMenu;
    function keyDown(const Sender: TObject; const Form: TCommonCustomForm;
      const event: NSEvent; const IsInputContext: boolean;
      var VKKeyCode: Integer; var Shift: TShiftState): boolean;
    procedure CreateDefaultMenuItem;
  public
    constructor Create;
    destructor Destroy; override;
    function DefaultAction(Key: Char; Shift: TShiftState): boolean;
    { IFMXApplicationService }
    procedure Run;
    procedure Terminate;
    function HandleMessage: Boolean;
    procedure WaitMessage;
    function GetTitle: string;
    function Terminating: Boolean;
    { IFMXHideAppService }
    function GetHidden: boolean;
    procedure SetHidden(const Value: boolean);
    procedure HideOthers;
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
    { IFMXWindowBorderService }
    function CreateWindowBorder(const AForm: TCommonCustomForm): TWindowBorder;
    { IFMXMenuService }
    procedure StartMenuLoop(const AView: IMenuView);
    function ShortCutToText(ShortCut: TShortCut): string;
    procedure ShortCutToKey(ShortCut: TShortCut; var Key: Word; var Shift: TShiftState);
    function TextToShortCut(Text: String): integer;
    procedure CreateOSMenu(AForm: TCommonCustomForm; const AMenu: IItemsContainer);
    procedure UpdateMenuItem(const AItem: IItemsContainer; AChange: TMenuItemChanges);
    procedure DestroyMenuItem(const AItem: IItemsContainer);
    function IsMenuBarOnWindowBorder: boolean;
    procedure UpdateMenuBar;
    { IFMXDragDropService }
    procedure BeginDragDrop(AForm: TCommonCustomForm; const Data: TDragObject; ABitmap: TBitmap);
    { IFMXClipboardService }
    procedure SetClipboard(Value: TValue);
    function GetClipboard: TValue;
    { IFMXCursorService }
    procedure SetCursor(const ACursor: TCursor);
    function GetCursor: TCursor;
    { IFMXMouseService }
    function GetMousePos: TPointF;
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
    { IFMXStyleService }
    function GetSystemStyle: TFmxObject;
    { IFMXStyleHiResService }
    function GetSystemStyleHiRes: TFmxObject;
    { IFMXSystemInformationService }
    function GetScrollingBehaviour: TScrollingBehaviours;
    function GetMinScrollThumbSize: Single;
    function GetCaretWidth: Integer;
    procedure Log(Fmt: String; Params: array of const);
    { IFMXWindowService }
    procedure SetFullScreen(const AForm: TCommonCustomForm; const AValue: Boolean);
    function GetFullScreen(const AForm: TCommonCustomForm): Boolean;
    procedure SetShowFullScreenIcon(const AForm: TCommonCustomForm; const AValue: Boolean);
  end;

{$M+}
  TFMXWindow = class;
  TTextServiceCocoa = class;

  TFMXViewBase = class(TOCLocal, NSTextInputClient)
  private
    FOwner: TFMXWindow;
    FShift: TShiftState;
    FMarkedRange: NSRange;
    FBackingStore: NSMutableAttributedString;//NSTextStorage;
    FSelectedRange: NSRange;
  protected
    function GetNativeView: NSView;
  public
    constructor Create(const AOwner: TFMXWindow);
    destructor Destroy; override;
    function acceptsFirstResponder: Boolean; cdecl;
    function becomeFirstResponder: Boolean; cdecl;
    function resignFirstResponder: Boolean; cdecl;
    procedure rightMouseDown(theEvent: NSEvent); cdecl;
    procedure rightMouseUp(theEvent: NSEvent); cdecl;
    procedure drawRect(dirtyRect: NSRect); cdecl;
//    function menuForEvent(event: Pointer {NSEvent}): Pointer; {NSMenu}      // May need to do something special to delegate this method.
    procedure keyDown(event: NSEvent); cdecl;
    procedure keyUp(event: NSEvent); cdecl;
    procedure mouseUp(event: NSEvent); cdecl;
    procedure mouseDown(event: NSEvent); cdecl;
    procedure mouseDragged(event: NSEvent); cdecl;
    procedure rightMouseDragged(event: NSEvent); cdecl;
    procedure otherMouseDragged(event: NSEvent); cdecl;
    procedure mouseMoved(event: NSEvent); cdecl;
    procedure scrollWheel(event: NSEvent); cdecl;
    { NSTextInputClient }
    procedure insertText(text: Pointer {NSString}; replacementRange: NSRange); cdecl;
    procedure doCommandBySelector(selector: SEL); cdecl;
    procedure setMarkedText(text: Pointer {NSString}; selectedRange: NSRange; replacementRange: NSRange); cdecl;
    procedure unMarkText; cdecl;
    function selectedRange: NSRange; cdecl;
    function markedRange: NSRange; cdecl;
    function hasMarkedText: Boolean; cdecl;
    function attributedSubstringForProposedRange(aRange: NSRange; actualRange: PNSRange): NSAttributedString; cdecl;
    function validAttributesForMarkedText: Pointer {NSArray}; cdecl;
    function firstRectForCharacterRange(aRange: NSRange; actualRange: PNSRange): NSRect; cdecl;
    function characterIndexForPoint(aPoint: NSPoint): NSUInteger; cdecl;
    function attributedString: NSAttributedString; cdecl;
    function fractionOfDistanceThroughGlyphForPoint(aPoint: NSPoint): CGFloat; cdecl;
    function baselineDeltaForCharacterAtIndex(anIndex: NSUInteger): CGFloat; cdecl;
    function windowLevel: NSInteger; cdecl;
    function drawsVerticallyForCharacterAtIndex(charIndex: NSUInteger): Boolean; cdecl;
    { Text Service }
    function FocusedTextService: TTextServiceCocoa;
    procedure UpdateTextServiceControl;
    { }
    property NativeView: NSView read GetNativeView;
    property Owner: TFMXWindow read FOwner;
  end;

  FMXView = interface(NSView)
    ['{56304E8C-08A2-4386-B116-D4E364FDC2AD}']
    function acceptsFirstResponder: Boolean; cdecl;
    function becomeFirstResponder: Boolean; cdecl;
    function resignFirstResponder: Boolean; cdecl;
    procedure rightMouseDown(theEvent: NSEvent); cdecl;
    procedure rightMouseUp(theEvent: NSEvent); cdecl;
    procedure drawRect(dirtyRect: NSRect); cdecl;
    procedure keyDown(event: NSEvent); cdecl;
    procedure keyUp(event: NSEvent); cdecl;
    procedure mouseUp(event: NSEvent); cdecl;
    procedure mouseDown(event: NSEvent); cdecl;
    procedure mouseDragged(event: NSEvent); cdecl;
    procedure rightMouseDragged(event: NSEvent); cdecl;
    procedure otherMouseDragged(event: NSEvent); cdecl;
    procedure mouseMoved(event: NSEvent); cdecl;
    procedure scrollWheel(event: NSEvent); cdecl;
    {Touch and Gestures}
    procedure magnifyWithEvent(event: NSEvent); cdecl;
    procedure rotateWithEvent(event: NSEvent); cdecl;
    procedure swipeWithEvent(event: NSEvent); cdecl;
    procedure touchesBeganWithEvent(event: NSEvent); cdecl;
    procedure touchesCancelledWithEvent(event: NSEvent); cdecl;
    procedure touchesEndedWithEvent(event: NSEvent); cdecl;
    procedure touchesMovedWithEvent(event: NSEvent); cdecl;
  end;

  TFMXView = class(TFMXViewBase, NSTextInputClient)
  private
    FGestureControl: TFmxObject;
    FSwipePoint: TPointF;
    FEventInfo: TGestureEventInfo;
  public
    constructor Create(const AOwner: TFMXWindow; AFRameRect: NSRect);
    function GetObjectiveCClass: PTypeInfo; override;
    {Touch and Gestures}
    procedure magnifyWithEvent(event: NSEvent); cdecl;
    procedure rotateWithEvent(event: NSEvent); cdecl;
    procedure swipeWithEvent(event: NSEvent); cdecl;
    procedure touchesBeganWithEvent(event: NSEvent); cdecl;
    procedure touchesCancelledWithEvent(event: NSEvent); cdecl;
    procedure touchesEndedWithEvent(event: NSEvent); cdecl;
    procedure touchesMovedWithEvent(event: NSEvent); cdecl;
  end;

  FMXView3D = interface(NSOpenGLView)
    ['{FC9E6699-53C6-4117-BAF0-A7BD455BAF75}']
    function acceptsFirstResponder: Boolean; cdecl;
    function becomeFirstResponder: Boolean; cdecl;
    function resignFirstResponder: Boolean; cdecl;
    procedure rightMouseDown(theEvent: NSEvent); cdecl;
    procedure rightMouseUp(theEvent: NSEvent); cdecl;
    procedure drawRect(dirtyRect: NSRect); cdecl;
    procedure keyDown(event: NSEvent); cdecl;
    procedure keyUp(event: NSEvent); cdecl;
    procedure mouseUp(event: NSEvent); cdecl;
    procedure mouseDown(event: NSEvent); cdecl;
    procedure mouseDragged(event: NSEvent); cdecl;
    procedure rightMouseDragged(event: NSEvent); cdecl;
    procedure otherMouseDragged(event: NSEvent); cdecl;
    procedure mouseMoved(event: NSEvent); cdecl;
    procedure scrollWheel(event: NSEvent); cdecl;
  end;

  TFMXView3D = class(TFMXViewBase, NSTextInputClient)
  public
    constructor Create(const AOwner: TFMXWindow; AFrameRect: NSRect);
    destructor Destroy; override;
    function GetObjectiveCClass: PTypeInfo; override;
  end;

  FMXWindow = interface(NSWindow)
    ['{A4C4B329-38C4-401F-8937-1C380801B1C8}']
    function draggingEntered(Sender: Pointer): NSDragOperation; cdecl;
    procedure draggingExited(Sender: Pointer {id}); cdecl;
    function draggingUpdated(Sender: Pointer): NSDragOperation; cdecl;
    function performDragOperation(Sender: Pointer): Boolean; cdecl;
    function canBecomeKeyWindow: Boolean; cdecl;
    function canBecomeMainWindow: Boolean; cdecl;
    function acceptsFirstResponder: Boolean; cdecl;
    function becomeFirstResponder: Boolean; cdecl;
    function resignFirstResponder: Boolean; cdecl;
    function performKeyEquivalent(event: NSEvent): Boolean; cdecl;
  end;

  FMXPanelWindow = interface(NSPanel)
    ['{52EB2081-6E73-4D3E-8EF9-8008275A7D6B}']
    function draggingEntered(Sender: Pointer): NSDragOperation; cdecl;
    procedure draggingExited(Sender: Pointer {id}); cdecl;
    function draggingUpdated(Sender: Pointer): NSDragOperation; cdecl;
    function performDragOperation(Sender: Pointer): Boolean; cdecl;
    function canBecomeKeyWindow: Boolean; cdecl;
    function canBecomeMainWindow: Boolean; cdecl;
    function acceptsFirstResponder: Boolean; cdecl;
    function becomeFirstResponder: Boolean; cdecl;
    function resignFirstResponder: Boolean; cdecl;
  end;

  TFMXWindow = class(TOCLocal) //(NSWindow)
  private
    FViewObj: TFMXViewBase;
    FDelegate: NSWindowDelegate;
    FDelayRelease: Boolean;
  protected
    function GetView: NSView;
  public
    NeedUpdateShadow: Boolean;
    Wnd: TCommonCustomForm;
    LastEvent: NSEvent; // for DragNDrop
    function GetObjectiveCClass: PTypeInfo; override;
    destructor Destroy; override;
    function windowShouldClose(Sender: Pointer {id}): Boolean; cdecl;
    procedure windowWillClose(notification: NSNotification); cdecl;
    procedure windowDidBecomeKey(notification: NSNotification); cdecl;
    procedure windowDidResignKey(notification: NSNotification); cdecl;
    procedure windowDidResize(notification: NSNotification); cdecl;
    procedure windowDidMove(notification: NSNotification); cdecl;
    procedure windowDidChangeBackingProperties(notification: NSNotification); cdecl;
    function draggingEntered(Sender: Pointer {NSDraggingInfo}): NSDragOperation; cdecl;
    procedure draggingExited(Sender: Pointer {NSDraggingInfo} {id}); cdecl;
    function draggingUpdated(Sender: Pointer {NSDraggingInfo}): NSDragOperation; cdecl;
    function performDragOperation(Sender: Pointer {NSDraggingInfo}): Boolean; cdecl;
    function acceptsFirstResponder: Boolean; cdecl;
    function canBecomeKeyWindow: Boolean; cdecl;
    function canBecomeMainWindow: Boolean; cdecl;
    function becomeFirstResponder: Boolean; cdecl;
    function resignFirstResponder: Boolean; cdecl;
    function performKeyEquivalent(event: NSEvent): Boolean; cdecl;
    property View: NSView read GetView;
  end;
  PFMXWindow = ^TFMXWindow;

  TFMXPanelWindow = class(TFMXWindow)
  public
    function GetObjectiveCClass: PTypeInfo; override;
    function canBecomeMainWindow: Boolean; cdecl;
  end;

  { TTextServiceCocoa }
  TTextServiceCocoa = class(TTextService)
  private
    FCaretPosition: TPoint;
    FText : string;
    FMarkedText : string;
    FImeMode: TImeMode;
  protected
    function GetText: string; override;
    procedure SetText(const Value: string); override;
    function GetCaretPostion: TPoint; override;
    procedure SetCaretPosition(const Value: TPoint); override;

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


    procedure DrawSingleLine(const Canvas: TCanvas;
      const ARect: TRectF; const FirstVisibleChar: integer; const Font: TFont;
      const AOpacity: Single; const Flags: TFillTextFlags; const ATextAlign: TTextAlign;
      const AVTextAlign: TTextAlign = TTextAlign.taCenter;
      const AWordWrap: Boolean = False); overload; override;

    procedure DrawSingleLine(const Canvas: TCanvas;
      const S: string;
      const ARect: TRectF;
      const Font: TFont;
      const AOpacity: Single; const Flags: TFillTextFlags; const ATextAlign: TTextAlign;
      const AVTextAlign: TTextAlign = TTextAlign.taCenter;
      const AWordWrap: Boolean = False); overload; override;

    function HasMarkedText: boolean; override;

    function GetImeMode: TImeMode; override;
    procedure SetImeMode(const Value: TImeMode); override;

    { Cocoa }
  private
    FMarkedRange: NSRange;
    FSelectedRange: NSRange;
  public
    constructor Create(const Owner: IControl; SupportMultiLine: Boolean); override;
    destructor Destroy; override;
    procedure SetMarkedRange(const Value: NSRange);
    procedure SetSelectedRange(const Value: NSRange);
  end;

var
  PlatformCocoa: TPlatformCocoa;

procedure RegisterCorePlatformServices;
begin
  PlatformCocoa := TPlatformCocoa.Create;
  TPlatformServices.Current.AddPlatformService(IFMXApplicationService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXHideAppService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXSystemFontService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXTimerService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXWindowService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXMenuService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXDragDropService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXClipboardService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXCursorService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXMouseService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXScreenService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXLocaleService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXDialogService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXTextService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXContextService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXCanvasService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXStyleService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXStyleHiResService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXWindowBorderService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXSystemInformationService, PlatformCocoa);
  TPlatformServices.Current.AddPlatformService(IFMXLoggingService, PlatformCocoa);
end;

procedure UnregisterCorePlatformServices;
begin
end;

procedure DoUpdateKey(var Key: Word;
                      var Ch: WideChar;
                      var Shift: TShiftState);
begin
  //Zero out Key, if you pressed the usual character
  if (Ch >= ' ') and
     ((Shift * [ssCtrl, ssCommand]) = []) then
  begin
    Shift := Shift - [ssAlt];
    Key := 0;
  end;
  //Zero out Ch, if you pressed a keypad of the Alt, Ctrl, or Cmd
  if (([ssAlt, ssCtrl, ssCommand] * Shift) <> []) and (Key > 0) then
  begin
    Ch := #0;
  end;
end;

procedure DoKeyUp(const Sender: TObject;
                  Form: TCommonCustomForm;
                  Key: Word;
                  Ch: WideChar;
                  Shift: TShiftState);
begin
  if Assigned(Form) then
  try
    DoUpdateKey(Key, Ch, Shift);
    Form.KeyUp(Key, Ch, Shift);
  except
    Application.HandleException(Sender);
  end;
end;

function DoKeyDown(const Sender: TObject;
                    const Form: TCommonCustomForm;
                    var Key: Word;
                    var Ch: WideChar;
                    Shift: TShiftState): boolean;
begin
  Result := False;
  if Assigned(Form) then
  try
    DoUpdateKey(Key, Ch, Shift);
    Form.KeyDown(Key, Ch, Shift);
    Result := Key = 0;
  except
    Application.HandleException(Sender);
  end;
end;

var
  NSFMXPBoardtype: NSString;

{ TApplicationDelegate }

procedure TApplicationDelegate.applicationWillTerminate(Notification: Pointer);
begin
  Application.Free;
  Application := nil;
end;

procedure TApplicationDelegate.applicationDidFinishLaunching(Notification: Pointer);
begin

end;

{ TPlatformCocoa }

constructor TPlatformCocoa.Create;
var
  AutoReleasePool: NSAutoreleasePool;
begin
  inherited;
  FDefaultMenu := cmSystem;
  FAppKitMod := LoadLibrary('/System/Library/Frameworks/AppKit.framework/AppKit');
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    AutoReleasePool.init;
    NSApp := TNSApplication.Wrap(TNSApplication.OCClass.sharedApplication);
    FAppDelegate := TApplicationDelegate.Create;
    NSApp.setDelegate(FAppDelegate);
    Application := TApplication.Create(nil);
    FObjectiveCMap := TDictionary<TFmxHandle, IObjectiveC>.Create;
  finally
    AutoReleasePool.release;
  end;
  FNSHandles := TList<TFmxHandle>.Create;
  FTimers := TList<TFmxHandle>.Create;
  NSFMXPBoardtype := NSSTR('NSFMXPBoardtype' + IntToStr(Integer(Pointer(Application))));
end;

destructor TPlatformCocoa.Destroy;
begin
  ClearNSHandles;
  FreeAndNil(FTimers);
  FreeAndNil(FNSHandles);

  if FModalStack <> nil then
    FModalStack.Free;
  FreeLibrary(FAppKitMod);
  FreeAndNil(Application);
  FObjectiveCMap.Free;
  inherited;
end;

function TPlatformCocoa.DefaultAction(Key: Char; Shift: TShiftState): boolean;
var
  Form: TCommonCustomForm;
begin
  Result := False;
  if (FDefaultMenu in [cmSystem, cmDefault]) then
  begin
    if (Shift = [ssCommand]) then
    begin
      if (Key = 'Q') then
      begin
        Terminate;
        Result := True;
      end;
      if (Key = 'H') then
      begin
        SetHidden(not GetHidden);
        Result := True;
      end;
      if (Key = 'W') and Assigned(Screen) then
      begin
        Form := Screen.ActiveForm;
        if Assigned(Form) and
          (not (TFmxFormState.fsModal in Form.FormState)) then
        begin
          Form.Close;
          Result := True;
        end;
      end;
    end;
    if (Shift = [ssAlt, ssCommand]) and (Key = 'H') then
    begin
      HideOthers;
      Result := True;
    end;
  end;
end;

function VKeyFromKeyCode(AKeyCode: Word; Shift: TShiftState; var ISFNkey: boolean): Integer;
var i: integer;
begin
  Result := 0;
  ISFNkey := False;
  for I := Low(MacToWin) to High(MacToWin) do
    if MacToWin[I].OSX = AKeyCode then
    begin
      Result := MacToWin[I].Win;
      ISFNkey := True;
      Exit;
    end;

  if ([ssCtrl, ssCommand] * Shift <> []) then
  for I := Low(MacToWinEx) to High(MacToWinEx) do
    if MacToWinEx[I].OSX = AKeyCode then
    begin
      Result := MacToWinEx[I].Win;
      Exit;
    end;
end;

function TPlatformCocoa.keyDown(const Sender: TObject;
                                const Form: TCommonCustomForm;
                                const event: NSEvent;
                                const IsInputContext: boolean;
                                  var VKKeyCode: Integer;
                                  var Shift: TShiftState): boolean;
var
  K: word;
  Ch: WideChar;
  ShortcutKey: string;
  I: Integer;
  NSChars: NSString;
  IsFNKey: boolean;
begin
  Result := False;
  K := 0;
  Shift := ShiftStateFromModFlags(event.modifierFlags);
  VKKeyCode := VKeyFromKeyCode(event.keyCode, Shift, IsFNKey);
  // Do not handle the modified letters in the KeyDown event
  if (not IsInputContext) and
     (not IsFNKey) then Exit;

  if (VKKeyCode <> 0) and
     (IsInputContext or IsFNKey) then
  begin
    K := VKKeyCode;
    Ch := #0;
    Result := DefaultAction(Char(K), Shift) or DoKeyDown(Sender, Form, K, Ch, Shift);
    if not Result then
    begin
      if not IsInputContext then
        Result := K < 32
      else
        Result := IsFNKey;
    end;
  end;
  // handle is not modified by the letter
  if (not Result) and
     (not IsFNKey) and
     ([ssAlt, ssCtrl, ssCommand] * Shift = []) then
  begin
    NSChars := event.charactersIgnoringModifiers;
    if NSChars <> nil then
      ShortcutKey := UTF8ToString(NSChars.UTF8String);
    for I := 1 to Length(ShortcutKey) do
    begin
      Ch := ShortcutKey[I];
      K := Word(Ch);
      if DefaultAction(Char(K), Shift) or DoKeyDown(Sender, Form, K, Ch, Shift) then
        Result := True;
    end;
    if not IsInputContext then
      Result := True;
  end;
end;

{ App =========================================================================}

procedure RunLoopObserverCallback(observer: CFRunLoopObserverRef; activity: CFRunLoopActivity; info: Pointer); cdecl;
var
  Done: Boolean;
begin
  Done := False;
  if (TThread.CurrentThread.ThreadID = MainThreadID) then
    CheckSynchronize;
  Application.DoIdle(Done);
end;

procedure TPlatformCocoa.Run;
begin
  Application.RealCreateForms;
  FRunLoopObserver := CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopBeforeWaiting, True, 0, RunLoopObserverCallback, nil);
  CFRunLoopAddObserver(CFRunLoopGetCurrent, FRunLoopObserver, kCFRunLoopCommonModes);
  NSApp.Run;
end;

procedure TPlatformCocoa.Terminate;
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
  NSApp.terminate(nil);
end;

function TPlatformCocoa.Terminating: boolean;
begin
  Result := FTerminating;
end;

function TPlatformCocoa.HandleToObjC(FmxHandle: TFmxHandle): IObjectiveC;
begin
  TMonitor.Enter(FObjectiveCMap);
  try
    ValidateHandle(FmxHandle);
    if FObjectiveCMap.ContainsKey(FmxHandle) then
      Result := FObjectiveCMap[FmxHandle]
    else
      Result := nil;
  finally
    TMonitor.Exit(FObjectiveCMap);
  end;
end;

function TPlatformCocoa.HandleMessage: Boolean;
begin
  WaitMessage;
  Result := false;
end;

procedure TPlatformCocoa.WaitMessage;
var
  TimeoutDate: NSDate;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    TimeoutDate := TNSDate.Wrap(TNSDate.OCClass.dateWithTimeIntervalSinceNow(0.1));
    NSApp.nextEventMatchingMask(NSAnyEventMask, TimeoutDate, NSDefaultRunLoopMode, False);
  finally
    AutoReleasePool.release;
  end;
end;

function TPlatformCocoa.GetTitle: string;
var AppNameKey: Pointer;
    AppBundle: NSBundle;
    NSAppName: NSString;
    AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    AppNameKey := (NSSTR('CFBundleName') as ILocalObject).GetObjectID;
    AppBundle := TNSBundle.Wrap(TNSBundle.OCClass.mainBundle);
    NSAppName := TNSString.Wrap(AppBundle.infoDictionary.objectForKey(AppNameKey));
    Result := UTF8ToString(NSAppName.UTF8String);
  finally
    AutoReleasePool.release;
  end;
end;

function TPlatformCocoa.GetHidden: boolean;
begin
  Result := NSApp.isHidden;
end;

procedure TPlatformCocoa.SetHidden(const Value: boolean);
begin
  if Value <> GetHidden then
  begin
    if Value then
      NSApp.Hide(self)
    else
      NSApp.UnHide(self);
  end;
end;

procedure TPlatformCocoa.SetShowFullScreenIcon(const AForm: TCommonCustomForm;
  const AValue: Boolean);
var
  NSWin: NSWindow;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    NSWin := WindowHandleToPlatform(AForm.Handle).Wnd;
    if AValue then
      NSWin.setCollectionBehavior(NSWindowCollectionBehaviorFullScreenPrimary)
    else
      NSWin.setCollectionBehavior(NSWindowCollectionBehaviorDefault);
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.HideOthers;
begin
  NSApp.hideOtherApplications(self);
end;

{ Timer =======================================================================}

type
  CocoaTimer = interface(NSObject)
    ['{337887FF-BA77-4703-BE0E-34DC1CB26276}']
    procedure timerEvent; cdecl;
                                                                                  
    procedure release; cdecl;
  end;

  TCocoaTimer = class(TOCLocal)
  private
    FFunc : TTimerProc;
  public
    function GetObjectiveCClass: PTypeInfo; override;
    procedure timerEvent; cdecl;
    procedure SetTimerFunc(AFunc: TTimerProc);
    procedure release; cdecl;
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

procedure TCocoaTimer.release;
var
  RC: Integer;
begin
  RC := NSObject(Super).retainCount;
  NSObject(Super).release;
  if RC = 1 then
    Destroy;
end;

procedure TCocoaTimer.SetTimerFunc(AFunc: TTimerProc);
begin
  FFunc := AFunc;
end;

function TPlatformCocoa.CreateTimer(Interval: Integer; TimerFunc: TTimerProc): TFmxHandle;
var
  Timer: NSTimer;
  User: TCocoaTimer;
  LInterval: NSTimeInterval;
begin
  Result := 0;
  if (not FTerminating) and (Interval > 0) and (Assigned(TimerFunc)) then
  begin
    User := TCocoaTimer.Create;
    try
      User.SetTimerFunc(TimerFunc);
      LInterval := Interval/1000;

      Timer := TNSTimer.Wrap(TNSTimer.OCClass.scheduledTimerWithTimeInterval(LInterval,
        User.GetObjectID, sel_getUid('timerEvent'), User.GetObjectID, True));

      Result := AllocHandle(Timer);
      FTimers.Add(Result);
    finally
      {user is retained (twice, because it's target), by the timer and }
      {released (twice) on timer invalidation}
      NSObject(User.Super).release;
    end;
  end;
end;

function TPlatformCocoa.DestroyTimer(Timer: TFmxHandle): Boolean;
var
  CocoaTimer: NSTimer;
  I: Integer;
begin
  Result := False;
  if HandleToObjC(Timer, NSTimer, CocoaTimer) then
  begin
    Result := True;
    CocoaTimer.invalidate;
    DeleteHandle(Timer);
    for I := FTimers.Count - 1 downto 0 do
      if FTimers[I] = Timer then
      begin
        FTimers.Delete(I);
        Break;
      end;
  end;
end;

function TPlatformCocoa.GetTick: Extended;
var
  H, M, S, MS: word;
begin
  DecodeTime(time, H, M, S, MS);
  Result := ((((H * 60 * 60) + (M * 60) + S) * 1000) + MS) / 1000;
end;

{ Window ======================================================================}

const
  kCGBaseWindowLevelKey = 0;
  kCGMinimumWindowLevelKey = 1;
  kCGDesktopWindowLevelKey = 2;
  kCGBackstopMenuLevelKey = 3;
  kCGNormalWindowLevelKey = 4;
  kCGFloatingWindowLevelKey = 5;
  kCGTornOffMenuWindowLevelKey = 6;
  kCGDockWindowLevelKey = 7;
  kCGMainMenuWindowLevelKey = 8;
  kCGStatusWindowLevelKey = 9;
  kCGModalPanelWindowLevelKey = 10;
  kCGPopUpMenuWindowLevelKey = 11;
  kCGDraggingWindowLevelKey = 12;
  kCGScreenSaverWindowLevelKey = 13;
  kCGMaximumWindowLevelKey = 14;
  kCGOverlayWindowLevelKey = 15;
  kCGHelpWindowLevelKey = 16;
  kCGUtilityWindowLevelKey = 17;
  kCGDesktopIconWindowLevelKey = 18;
  kCGCursorWindowLevelKey = 19;
  kCGAssistiveTechHighWindowLevelKey = 20;
  kCGNumberOfWindowLevelKeys = 21; { Must be last. }

{ TFMXView }

function TFMXView.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(FMXView);
end;

procedure TFMXView.magnifyWithEvent(event: NSEvent);
var
  Obj: IControl;
  LTouches: NSSet;
  LTouchesArray: NSArray;
  LPoint, LPoint2: NSPoint;
  LTouch: NSTouch;
  LDeviceSize: NSSize;
  i, j, distance: Integer;
begin
  // Use mouseLocation instead of locationInWindow because gesture events do not have locationInWindow set
  // (gestures don't move the mouse cursor). We will consider that the gestures are for the control that is
  // under the mouse cursor (on OSX the gestures are for the view under the mouse cursor).
  LPoint := TNSEvent.OCClass.mouseLocation;
  LPoint.Y := TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size.height - LPoint.Y;
  FEventInfo.Location := PointF(LPoint.X, LPoint.Y);

  // Get the control from "under" the gesture.
  Obj := IControl(FOwner.Wnd.ObjectAtPoint(FOwner.Wnd.ClientToScreen(FEventInfo.Location)));
  if Assigned(Obj) then
    FGestureControl := Obj.GetObject
  else
    FGestureControl := FOwner.Wnd;

  while Assigned(FGestureControl) do
  begin
    if not(TInteractiveGesture.igZoom
      in FGestureControl.Touch.InteractiveGestures) then
    begin
      FGestureControl := FGestureControl.Parent;
    end
    else
    begin
      Break;
    end;
  end;

  if Assigned(FGestureControl) then
  begin
    LTouches := event.touchesMatchingPhase(NSTouchPhaseTouching, NSView(Super));
    if LTouches.count >= 2 then
    begin
      LTouchesArray := LTouches.allObjects;
      LTouch := TNSTouch.Wrap(LTouchesArray.objectAtIndex(0));
      LDeviceSize := LTouch.deviceSize;
      FEventInfo.Distance := 0; //reset the distance
      // Find the greatest distance between the touches.
      for i := 0 to LTouches.count - 2 do
      begin
        LTouch := TNSTouch.Wrap(LTouchesArray.objectAtIndex(i));
        LPoint := LTouch.normalizedPosition;
        for j := 1 to LTouches.count - 1 do
        begin
          LTouch := TNSTouch.Wrap(LTouchesArray.objectAtIndex(j));
          LPoint2 := LTouch.normalizedPosition;

          distance := Round(Sqrt(Sqr(LPoint.X * LDeviceSize.width - LPoint2.X * LDeviceSize.width) +
            Sqr(LPoint.Y * LDeviceSize.height - LPoint2.Y * LDeviceSize.height)));
          if distance > FEventInfo.distance then
            FEventInfo.distance := distance;
        end;

        FEventInfo.GestureID := igiZoom;
        // send message to the control
        FGestureControl.CMGesture(FEventInfo);
        // clear the flags
        FEventInfo.Flags := [];
      end
    end
  end
  else
    //send the message up the responder chain
    NSView(Super).magnifyWithEvent(event);
end;

procedure TFMXView.rotateWithEvent(event: NSEvent);
var
  Obj: IControl;
  LPoint: NSPoint;
begin
  // Use mouseLocation instead of locationInWindow because gesture events do not have locationInWindow set
  // (gestures don't move the mouse cursor). We will consider that the gestures are for the control that is
  // under the mouse cursor (on OSX the gestures are for the view under the mouse cursor).
  LPoint := TNSEvent.OCClass.mouseLocation;
  LPoint.Y := TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size.height - LPoint.Y;
  FEventInfo.Location := PointF(LPoint.X, LPoint.Y);

  // Get the control from "under" the gesture.
  Obj := IControl(FOwner.Wnd.ObjectAtPoint(FOwner.Wnd.ClientToScreen
    (FEventInfo.Location)));
  if Assigned(Obj) then
    FGestureControl := Obj.GetObject
  else
    FGestureControl := FOwner.Wnd;
  while Assigned(FGestureControl) do
  begin
    if not(TInteractiveGesture.igRotate
      in FGestureControl.Touch.InteractiveGestures) then
    begin
      FGestureControl := FGestureControl.Parent;
    end
    else
    begin
      Break;
    end;
  end;

  if Assigned(FGestureControl) then
  begin
    //Transform degrees in radians and add them to the existing angle of rotation.
    FEventInfo.Angle := FEventInfo.Angle + event.rotation* Pi / 180;
    FEventInfo.GestureID := igiRotate;
    // send message to the control
    FGestureControl.CMGesture(FEventInfo);
    FEventInfo.Flags := [];
  end
  else
    //send the message up the responder chain
    NSView(Super).rotateWithEvent(event);
end;

procedure TFMXView.swipeWithEvent(event: NSEvent);
var
  Obj: IControl;
  LTouches: NSSet;
  LTouchesArray: NSArray;
  LPoint, LPoint2: NSPoint;
  LTouch: NSTouch;
  width, height: Single;
begin
  // Use mouseLocation instead of locationInWindow because gesture events do not have locationInWindow set
  // (gestures don't move the mouse cursor). We will consider that the gestures are for the control that is
  // under the mouse cursor (on OSX the gestures are for the view under the mouse cursor).
  LPoint := TNSEvent.OCClass.mouseLocation;
  LPoint.Y := TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size.height - LPoint.Y;

  FSwipePoint := PointF(LPoint.X, LPoint.Y);

  // Get the control from "under" the gesture.
  Obj := IControl(FOwner.Wnd.ObjectAtPoint(FOwner.Wnd.ClientToScreen(FSwipePoint)));
  if Assigned(Obj) then
    FGestureControl := Obj.GetObject
  else
    FGestureControl := FOwner.Wnd;

  while Assigned(FGestureControl) do
  begin
    if not(TInteractiveGesture.igPan
      in FGestureControl.Touch.InteractiveGestures) then
    begin
      FGestureControl := FGestureControl.Parent;
    end
    else
    begin
      Break;
    end;
  end;

  if Assigned(FGestureControl) then
  begin
    FEventInfo.Location := FSwipePoint;
    LTouches := event.touchesMatchingPhase(NSTouchPhaseTouching, NSView(Super));
    if LTouches.count = 2 then
    begin
      LTouchesArray := LTouches.allObjects;
      LTouch := TNSTouch.Wrap(LTouchesArray.objectAtIndex(0));
      LPoint := LTouch.normalizedPosition;
      LTouch := TNSTouch.Wrap(LTouchesArray.objectAtIndex(1));
      LPoint2 := LTouch.normalizedPosition;

      //the distance between the 2 fingers
      FEventInfo.Distance := Round(Sqrt(Sqr(LPoint.X - LPoint2.X) + Sqr(LPoint.Y - LPoint2.Y)));

      LPoint.X := Min(LPoint.X, LPoint2.X) + Abs(LPoint.X - LPoint2.X);
      LPoint.Y := 1.0 - Min(LPoint.Y, LPoint2.Y) + Abs(LPoint.Y - LPoint2.Y);

      width := 0;
      height := 0;
      if FGestureControl is TCommonCustomForm then
      begin
        width := TCommonCustomForm(FGestureControl).ClientWidth;
        height := TCommonCustomForm(FGestureControl).ClientHeight;
      end
      else if FGestureControl is TControl then
      begin
        width := TControl(FGestureControl).Canvas.width;
        height := TControl(FGestureControl).Canvas.height;
      end;

      LPoint.X := LPoint.X * width;
      LPoint.Y := LPoint.Y * height;

      if event.deltaX <> 0 then
      begin
        //horizontal swipe
        if event.deltaX > 0 then
        begin
          //swipe-left
          LPoint.X := LPoint.X + FEventInfo.Location.X;
          FEventInfo.Location := PointF(LPoint.X, LPoint.Y);
        end
        else
        begin
          // swipe-right
          LPoint.X := FEventInfo.Location.X - LPoint.X;
          FEventInfo.Location := PointF(LPoint.X, LPoint.Y);
        end;
      end
      else if event.deltaY <> 0 then
      begin
        //vertical swipe
        if event.deltaY > 0 then
        begin
          //swipe-up
          LPoint.Y := LPoint.Y + FEventInfo.Location.Y;
          FEventInfo.Location := PointF(LPoint.X, LPoint.Y);
        end
        else
        begin
          //swipe-down
          LPoint.Y := FEventInfo.Location.Y - LPoint.Y;
          FEventInfo.Location := PointF(LPoint.X, LPoint.Y);
        end;
      end;

      FSwipePoint := FEventInfo.Location;
    end
    else
    begin
      // send the message up the responder chain
      NSView(Super).swipeWithEvent(event);
      Exit;
    end;

    // EventInfo.Distance := Sqrt(Sqr(Point.X - Source.X) + Sqr(Point.Y - Source.Y));;
    // EventInfo.InertiaVector := TPointF(SmallPointToPoint(InertiaVectorFromArgument(LGestureInfo.ullArguments)));
    FEventInfo.GestureID := igiPan;

    // send message to the control
    FGestureControl.CMGesture(FEventInfo);
    FEventInfo.Flags := [];
  end
  else
    // send the message up the responder chain
    NSView(Super).swipeWithEvent(event);
end;

procedure TFMXView.touchesBeganWithEvent(event: NSEvent);
var
  Obj: IControl;
  LTouches: NSSet;
  LTouchesArray: NSArray;
  LPoint, LPoint2: NSPoint;
  LLocation: TPointF;
  LTouch: NSTouch;
  Handled: Boolean;
begin
  Handled := False;
  FillChar(FEventInfo, Sizeof(FEventInfo), 0);

  // Get the location of the gesture.
  // Use mouseLocation instead of locationInWindow because gesture events do not have locationInWindow set
  // (gestures don't move the mouse cursor). We will consider that the gestures are for the control that is
  // under the mouse cursor (on OSX the gestures are for the view under the mouse cursor).
  LPoint := TNSEvent.OCClass.mouseLocation;
  LPoint.Y := TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size.height - LPoint.Y;
  LLocation := PointF(LPoint.X, LPoint.Y);

  // Find the control from "under" the gesture.
  Obj := IControl(FOwner.Wnd.ObjectAtPoint(LLocation));
  if Assigned(Obj) then
    FGestureControl := Obj.GetObject
  else
    FGestureControl := FOwner.Wnd;

  while Assigned(FGestureControl) and
    not Assigned(FGestureControl.Touch.GestureEngine) do
    FGestureControl := FGestureControl.Parent;

  if Assigned(FGestureControl) then
  begin
    TPlatformGestureEngine(FGestureControl.Touch.GestureEngine).InitialPoint := LLocation;

    // Use NSTouch.normalizedPosition to get the movement of the fingers on the trackpad.
    // This points will make up the gesture.
    LTouches := event.touchesMatchingPhase(NSTouchPhaseTouching, NSView(Super));
    if LTouches.count = 2 then
    begin
      LTouchesArray := LTouches.allObjects;
      if Assigned(FGestureControl) then
      begin
        Handled := True;
        LTouch := TNSTouch.Wrap(LTouchesArray.objectAtIndex(0));
        LPoint := LTouch.normalizedPosition;
        LTouch := TNSTouch.Wrap(LTouchesArray.objectAtIndex(1));
        LPoint2 := LTouch.normalizedPosition;

        LPoint.X := Min(LPoint.X, LPoint2.X) + Abs(LPoint.X - LPoint2.X);
        LPoint.Y := 1.0 - Min(LPoint.Y, LPoint2.Y) - Abs(LPoint.Y - LPoint2.Y);

        // Retain the points/touches.
        TPlatformGestureEngine(FGestureControl.Touch.GestureEngine).ClearPoints;
        TPlatformGestureEngine(FGestureControl.Touch.GestureEngine).AddPoint(LPoint.X * 100, LPoint.Y * 100);
      end;
    end;
  end;

  //set the gfBegin flag for interactive gestures.
  FEventInfo.Flags := [TInteractiveGestureFlag.gfBegin];

  if not Handled then
    //send the message up the responder chain
    NSView(Super).touchesBeganWithEvent(event);
end;

procedure TFMXView.touchesCancelledWithEvent(event: NSEvent);
begin
  if Assigned(FGestureControl) then
  begin
    //Handle "end" flag for interactive gestures.
    if FEventInfo.GestureID > igiFirst then
    begin
      FEventInfo.Flags := [TInteractiveGestureFlag.gfEnd];
      // send message to the control
      FGestureControl.CMGesture(FEventInfo);
      FillChar(FEventInfo, Sizeof(FEventInfo), 0);
    end;

    //reset the points/touches
    if Assigned(FGestureControl.Touch.GestureEngine) then
      TPlatformGestureEngine(FGestureControl.Touch.GestureEngine).ClearPoints;
    FGestureControl := nil;
  end
  else
    //send the message up the responder chain
    NSView(Super).touchesCancelledWithEvent(event);
end;

const
  MIN_NO_GESTURE_POINTS = 10;

procedure TFMXView.touchesEndedWithEvent(event: NSEvent);
var
  LEngine: TPlatformGestureEngine;
  Handled: Boolean;
const
  LGestureTypes: TGestureTypes = [TGestureType.gtStandard, TGestureType.gtRecorded, TGestureType.gtRegistered];
begin
  Handled := False;

  if Assigned(FGestureControl) then
  begin
    // Handle "end" flag for interactive gestures.
    if FEventInfo.GestureID > igiFirst then
    begin
      FEventInfo.Flags := [TInteractiveGestureFlag.gfEnd];
      // send message to the control
      FGestureControl.CMGesture(FEventInfo);
    end;

    if Assigned(FGestureControl.Touch.GestureEngine) then
    begin
      // Handle standard gestures.
      LEngine := TPlatformGestureEngine(FGestureControl.Touch.GestureEngine);
      if LEngine.PointCount > 1 then
      begin
        // Make sure there are at least MIN_NO_GESTURE_POINTS points.
        if LEngine.PointCount < MIN_NO_GESTURE_POINTS then
          LEngine.AddPoints(MIN_NO_GESTURE_POINTS - LEngine.PointCount);
        FillChar(FEventInfo, Sizeof(FEventInfo), 0);
        if TPlatformGestureEngine.IsGesture(LEngine.Points, LEngine.GestureList, LGestureTypes, FEventInfo) then
        begin
          LEngine.BroadcastGesture(FGestureControl, FEventInfo);
          Handled := True;
        end;
      end;
      // reset the points/touches
      TPlatformGestureEngine(FGestureControl.Touch.GestureEngine).ClearPoints;
    end;
    FGestureControl := nil;
    FillChar(FEventInfo, Sizeof(FEventInfo), 0);
  end;

  if not Handled then
    NSView(Super).touchesEndedWithEvent(event);
end;

procedure TFMXView.touchesMovedWithEvent(event: NSEvent);
var
  LTouches: NSSet;
  LTouchesArray: NSArray;
  LPoint, LPoint2: NSPoint;
  LTouch: NSTouch;
  Handled: Boolean;
begin
  Handled := False;

  if (Assigned(FGestureControl) and Assigned(FGestureControl.Touch.GestureEngine)) then
  begin
    // retain the points/touches
    LTouches := event.touchesMatchingPhase(NSTouchPhaseTouching, NSView(Super));
    if LTouches.count = 2 then
    begin
      LTouchesArray := LTouches.allObjects;
      // Retain the points/touches.
      if Assigned(FGestureControl) then
      begin
        Handled := True;
        LTouch := TNSTouch.Wrap(LTouchesArray.objectAtIndex(0));
        LPoint := LTouch.normalizedPosition;
        LTouch := TNSTouch.Wrap(LTouchesArray.objectAtIndex(1));
        LPoint2 := LTouch.normalizedPosition;

        LPoint.X := Min(LPoint.X, LPoint2.X) + Abs(LPoint.X - LPoint2.X);
        LPoint.Y := 1.0 - Min(LPoint.Y, LPoint2.Y) - Abs(LPoint.Y - LPoint2.Y);
        // Retain the points/touches.
        TPlatformGestureEngine(FGestureControl.Touch.GestureEngine).AddPoint(LPoint.X * 100, LPoint.Y * 100);
      end;
    end;
  end;

  if not Handled then
    NSView(Super).touchesMovedWithEvent(event);
end;

constructor TFMXView.Create(const AOwner: TFMXWindow; AFrameRect: NSRect);
var
  V: Pointer;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    inherited Create(AOwner);
    V := NSView(Super).initWithFrame(AFrameRect);
    if GetObjectID <> V then
      UpdateObjectID(V);
    NSView(Super).setAcceptsTouchEvents(True);
  finally
    AutoReleasePool.release;
  end;
  FillChar(FEventInfo, Sizeof(FEventInfo), 0);
end;

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
  Result := FCaretPosition;
end;

procedure TTextServiceCocoa.SetCaretPosition(const Value: TPoint);
begin
  FCaretPosition := Value;
end;

procedure TTextServiceCocoa.InternalSetMarkedText( const AMarkedText: string );
begin
  FMarkedText := AMarkedText;
  (FOwner as ITextInput).UpdateCaretPoint;
end;

procedure TTextServiceCocoa.InternalBreakIMEInput;
begin
  FMarkedText := EmptyStr;
  (FOwner as ITextInput).UpdateCaretPoint;
end;

procedure TTextServiceCocoa.InternalEndIMEInput;
begin
  (FOwner as ITextInput).EndIMEInput;
  FMarkedText := EmptyStr;
end;

procedure TTextServiceCocoa.InternalStartIMEInput;
begin
  (FOwner as ITextInput).StartIMEInput;
end;

function TTextServiceCocoa.InternalGetMarkedText: string;
begin
  Result := FMarkedText;
end;

function TTextServiceCocoa.CombinedText: string;
begin
  if FMarkedText <> '' then
    Result := Copy(FText, 1, FCaretPosition.X) + FMarkedText + Copy(FText, FCaretPosition.X + 1, MaxInt)
  else
    Result := FText;
end;

function TTextServiceCocoa.TargetClausePosition: TPoint;
begin
  Result := FCaretPosition;
  Result.X := Result.X + FMarkedText.Length;
end;

procedure TTextServiceCocoa.EnterControl(const FormHandle: TWindowHandle);
begin
end;

procedure TTextServiceCocoa.ExitControl(const FormHandle: TWindowHandle);
var
  Handle: TMacWindowHandle;
  Range: NSRange;
begin
  if not FMarkedText.IsEmpty then
  begin
    Handle := WindowHandleToPlatform(FormHandle);
    Range.location := NSNotFound;
    Range.length := 0;
    TFMXWindow(Handle.Handle).FViewObj.insertText(TNSString.OCClass.stringWithString(NSSTR(FMarkedText)), Range);
  end;
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
  Result := FMarkedText <> '';
end;

function TTextServiceCocoa.GetImeMode: TImeMode;
begin
  Result := FImeMode;
end;

procedure TTextServiceCocoa.SetImeMode(const Value: TImeMode);
begin
  FImeMode := Value;
end;

procedure TTextServiceCocoa.SetMarkedRange(const Value: NSRange);
begin
  FMarkedRange := Value;
end;

procedure TTextServiceCocoa.SetSelectedRange(const Value: NSRange);
begin
  FSelectedRange := Value;
end;

function TPlatformCocoa.GetTextServiceClass: TTextServiceClass;
begin
  Result := TTextServiceCocoa;
end;

{ TFMXViewBase }

constructor TFMXViewBase.Create(const AOwner: TFMXWindow);
begin
  inherited Create;
  FOwner := AOwner;
  FBackingStore := TNSMutableAttributedString.Alloc;
  FBackingStore := TNSMutableAttributedString.Wrap(FBackingStore.initWithString(NSSTR('')));
  FMarkedRange.location := NSNotFound;
  FMarkedRange.length := 0;
  FSelectedRange.location := 0;
  FSelectedRange.length := 0;
  UpdateTextServiceControl;
end;

destructor TFMXViewBase.Destroy;
var
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    FBackingStore.release;
    FOwner := nil;
    NSView(Super).release;
  finally
    AutoreleasePool.release;
  end;
  inherited;
end;

type
  TNSRectArray = array [0..$FFFF] of NSRect;
  PNSRectArray = ^TNSRectArray;

procedure TFMXViewBase.drawRect(dirtyRect: NSRect);
var
  nctx: NSGraphicsContext;
  boundRect: NSRect;
  PaintControl: IPaintControl;
  UpdateRects: array of TRectF;
  R: PNSRectArray;
  I, RCount: NSInteger;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    boundRect := NSView(Super).bounds;

    NativeView.getRectsBeingDrawn(@R, @RCount);
    SetLength(UpdateRects, RCount);
    for I := 0 to RCount - 1 do
    begin
      UpdateRects[I] := RectF(R[I].origin.x, boundRect.size.height - R[I].origin.y - R[I].size.height,
        R[I].origin.x + R[I].size.width, boundRect.size.height - R[I].origin.y);
    end;

    if Assigned(FOwner) then
    begin
      nctx := TNSGraphicsContext.Wrap(TNSGraphicsContext.OCClass.currentContext);

      if Supports(FOwner.Wnd, IPaintControl, PaintControl) then
      begin
        if not (TWindowStyle.wsGPUSurface in FOwner.Wnd.WindowStyle) then
          PaintControl.ContextHandle := THandle(nctx.graphicsPort);
        PaintControl.PaintRects(UpdateRects);
        if not (TWindowStyle.wsGPUSurface in FOwner.Wnd.WindowStyle) then
          PaintControl.ContextHandle := 0;
      end;

      if (FOwner.Wnd.Transparency) then
        WindowHandleToPlatform(FOwner.Wnd.Handle).UpdateLayer(nctx.graphicsPort);

      if FOwner.NeedUpdateShadow and NSWindow(FOwner.Super).isVisible then
      begin
        NSWindow(FOwner.Super).invalidateShadow;
        FOwner.NeedUpdateShadow := False;
      end;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

function TFMXViewBase.GetNativeView: NSView;
begin
  Result := NSView(Super);
end;

function ShiftStateFromModFlags(M: NSUInteger): TShiftState;
begin
  Result := [];
  if M and NSShiftKeyMask = NSShiftKeyMask then
  begin
    Include(Result, ssShift);
    M := M and not NSShiftKeyMask;
  end;
  if M and NSControlKeyMask = NSControlKeyMask then
  begin
    Include(Result, ssCtrl);
    M := M and not NSControlKeyMask;
  end;
  if M and NSAlternateKeyMask = NSAlternateKeyMask then
  begin
    Include(Result, ssAlt);
    M := M and not NSAlternateKeyMask;
  end;
  if M and NSCommandKeyMask = NSCommandKeyMask then
  begin
    Include(Result, ssCommand);
  end;
end;

procedure TFMXViewBase.rightMouseDown(theEvent: NSEvent);
var
  mp: NSPoint;
  SS: TShiftState;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    mp := theEvent.locationInWindow;
    mp.y := NativeView.bounds.size.height - mp.y;
    SS := [ssRight] + ShiftStateFromModFlags(theEvent.modifierFlags);
    try
      FOwner.Wnd.mouseDown(TMouseButton.mbRight, SS, mp.x, mp.y);
    except
      Application.HandleException(Self);
    end;
    NativeView.rightMouseDown(theEvent);
  finally
    AutoReleasePool.release;
  end;
end;

procedure TFMXViewBase.rightMouseUp(theEvent: NSEvent);
var
  mp: NSPoint;
  SS: TShiftState;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    mp := theEvent.locationInWindow;
    mp.y := NativeView.bounds.size.height - mp.y;
    SS := [ssRight] + ShiftStateFromModFlags(theEvent.modifierFlags);
    try
      FOwner.Wnd.mouseUp(TMouseButton.mbRight, SS, mp.x, mp.y);
    except
      Application.HandleException(Self);
    end;
    NativeView.rightMouseUp(theEvent);
  finally
    AutoReleasePool.release;
  end;
end;

procedure TFMXViewBase.mouseUp(event: NSEvent);
var
  mp: NSPoint;
  SS: TShiftState;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    FOwner.LastEvent := nil;
    mp := event.locationInWindow;
    mp.y := TNSView. Wrap(event.window.contentView).bounds.size.height - mp.y;
    SS := [ssLeft] + ShiftStateFromModFlags(event.modifierFlags);
    FOwner.FDelayRelease := True;
    try
      try
        FOwner.Wnd.MouseUp(TMouseButton.mbLeft, SS, mp.x, mp.y);
      except
        Application.HandleException(Self);
      end;
    finally
      FOwner.FDelayRelease := False;
      if csDestroying in FOwner.Wnd.ComponentState then
        FOwner.Wnd.Release;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TFMXViewBase.mouseDown(event: NSEvent);
var
  mp: NSPoint;
  SS: TShiftState;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    mp := event.locationInWindow;
    mp.y := TNSView.Wrap(event.window.contentView).bounds.size.height - mp.y;
    FOwner.LastEvent:= event;
    SS := [ssLeft] + ShiftStateFromModFlags(event.modifierFlags);
    if event.clickCount = 2 then
      Include(SS, ssDouble);
    try
      FOwner.Wnd.MouseDown(TMouseButton.mbLeft, SS, mp.x, mp.y);
    except
      Application.HandleException(Self);
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TFMXViewBase.mouseDragged(event: NSEvent);
var
  mp: NSPoint;
  SS: TShiftState;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    if event.window <> nil then
    begin
      mp := event.locationInWindow;
      mp.y := TNSView.Wrap(event.window.contentView).bounds.size.height - mp.y;
      try
        SS := [ssLeft] + ShiftStateFromModFlags(event.modifierFlags);
        FOwner.LastEvent := event;
        FOwner.Wnd.MouseMove(SS, mp.x, mp.y);
        FOwner.LastEvent := nil;
      except
        Application.HandleException(Self);
      end;
    end;
  finally
    AutoReleasePool.release;
  end;
end;


procedure TFMXViewBase.otherMouseDragged(event: NSEvent);
var
  mp: NSPoint;
  SS: TShiftState;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    if event.window <> nil then
    begin
      mp := event.locationInWindow;
      mp.y := TNSView.Wrap(event.window.contentView).bounds.size.height - mp.y;
      try
        SS := [ssMiddle] + ShiftStateFromModFlags(event.modifierFlags);
        FOwner.LastEvent := event;
        FOwner.Wnd.MouseMove(SS, mp.x, mp.y);
        FOwner.LastEvent := nil;
      except
        Application.HandleException(Self);
      end;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TFMXViewBase.rightMouseDragged(event: NSEvent);
var
  mp: NSPoint;
  SS: TShiftState;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    if event.window <> nil then
    begin
      mp := event.locationInWindow;
      mp.y := TNSView.Wrap(event.window.contentView).bounds.size.height - mp.y;
      try
        SS := [ssRight] + ShiftStateFromModFlags(event.modifierFlags);
        FOwner.LastEvent := event;
        FOwner.Wnd.MouseMove(SS, mp.x, mp.y);
        FOwner.LastEvent := nil;
      except
        Application.HandleException(Self);
      end;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TFMXViewBase.mouseMoved(event: NSEvent);
var
  mp: NSPoint;
  SS: TShiftState;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    mp := event.locationInWindow;
    mp.y := TNSView.Wrap(event.window.contentView).bounds.size.height - mp.y;
    try
      SS := ShiftStateFromModFlags(event.modifierFlags);
      FOwner.Wnd.MouseMove(SS, mp.x, mp.y);
    except
      Application.HandleException(Self);
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TFMXViewBase.scrollWheel(event: NSEvent);
var
  H: Boolean;
  SS: TShiftState;
  D: Single;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    try
      SS := ShiftStateFromModFlags(event.modifierFlags);
      H := False;
      D := 0;
      if event.deltaY <> 0 then
        D := event.deltaY
      else if event.deltaX <> 0 then
      begin
        D := event.deltaX;
        SS := SS + [ssHorizontal];
      end;
      if D <> 0 then
        FOwner.Wnd.MouseWheel(SS, Round(D * 30), H)
    except
      Application.HandleException(Self);
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TFMXViewBase.keyDown(event: NSEvent);
var
  VKKeyCode: Integer;
  Peformed: Boolean;
begin
  FShift := [];
  Peformed := False;
                                                          
  if not hasMarkedText then // IME's conversion window.is active.
  begin
      FOwner.FDelayRelease := True;
      try
        Peformed := PlatformCocoa.KeyDown(self, FOwner.Wnd, event, False, VKKeyCode, FShift);
      finally
        FOwner.FDelayRelease := False;
        if csDestroying in FOwner.Wnd.ComponentState then
          FOwner.Wnd.Release;
      end;
  end;
  if (not Peformed) and (not (csDestroying in FOwner.Wnd.ComponentState)) then
    NativeView.inputContext.handleEvent(event);
end;

procedure TFMXViewBase.keyUp(event: NSEvent);
var
  S: string;
  K: word;
  Ch: WideChar;
  Shift: TShiftState;
  VKKeyCode: Integer;
  IsFNKey: boolean;
begin
  if hasMarkedText then // IME's conversion window.is active.
    exit;
  FShift := [];
  Shift := ShiftStateFromModFlags(event.modifierFlags);

  VKKeyCode := VKeyFromKeyCode(event.keyCode, Shift, IsFNKey);
  if VKKeyCode <> 0 then
  begin
    K := VKKeyCode;
    Ch := #0;
    DoKeyUp(Self, FOwner.Wnd, K, Ch, Shift);
  end
  else
  begin
    S := UTF8ToString(event.characters.UTF8String);
    if Length(S) > 0 then
    begin
      Ch := S[1];
      K := Ord(Ch);
      DoKeyUp(Self, FOwner.Wnd, K, Ch, Shift);
    end;
  end;
end;

function TFMXViewBase.acceptsFirstResponder: Boolean;
begin
  Result := True;
end;

function TFMXViewBase.becomeFirstResponder: Boolean;
begin
  Result := True;
end;

function TFMXViewBase.resignFirstResponder: Boolean;
begin
  Result := True;
end;

{ NSTextInputClient implementation }

function TFMXViewBase.firstRectForCharacterRange(aRange: NSRange;
  actualRange: PNSRange): NSRect;
var
  glyphRect: NSRect;
  R: TRectF;
  TSObj: ITextInput;
begin
  if (FOwner.Wnd.Focused <> nil) and Supports(FOwner.Wnd.Focused, ITextInput, TSObj) then
    R := TRectF.Create(TSObj.GetTargetClausePointF)
  else if FOwner.Wnd.Focused <> nil then
    R := TControl(FOwner.Wnd.Focused.GetObject).AbsoluteRect
  else
    R := TRectF.Create(0, 0, 0, 0);

  glyphRect := MakeNSRect(R.Left, NativeView.bounds.size.height-R.Bottom, R.Right - R.Left, R.Bottom - R.Top);
//   Convert the rect to screen coordinates
  glyphRect := NativeView.convertRectToBase(glyphRect);
  glyphRect.origin := NativeView.window.convertBaseToScreen(glyphRect.origin);
  Result := glyphRect;
end;

function TFMXViewBase.hasMarkedText: Boolean;
begin
  Result := FMarkedRange.location <> NSNotFound;
end;

function ToNSString(const text : Pointer; var NStr: NSString): Boolean;
begin
  if TNSObject.Wrap(text).isKindOfClass(objc_getClass(MarshaledAString('NSAttributedString'))) then
  begin
    NStr := TNSString.Wrap(objc_msgSend(text, sel_getUid(MarshaledAString('string'))));
    Result := True;
  end
  else
  begin
    NStr := TNSString.Wrap(text);
    Result := False;
  end;
end;

procedure TFMXViewBase.insertText(text: Pointer{NSString}; replacementRange: NSRange);
var
  I: Integer;
  K: Word;
  R : NSRange;
  Ch: WideChar;
  Str: string;
  NStr: NSString;
  AutoReleasePool: NSAutoreleasePool;
  TSC: ITextInput;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    if (FShift - [ssAlt, ssShift]) <> [] then
      Exit;
    if hasMarkedText then
    begin
      NativeView.inputContext.discardMarkedText;
      try
        if (FOwner.Wnd.Focused <> nil) and Supports(FOwner.Wnd.Focused, ITextInput, TSC) then
        begin
          TTextServiceCocoa(TSC.GetTextService).InternalSetMarkedText('');
          TTextServiceCocoa(TSC.GetTextService).InternalEndIMEInput;
        end;
      except
        Application.HandleException(Self);
      end;
    end;
    NativeView.inputContext.invalidateCharacterCoordinates;
    ToNSString(text, NStr);
    if NStr.length > 0 then
    begin
      Str := UTF8ToString(NStr.UTF8String);
      for I := 0 to Str.Length - 1 do
      begin
        Ch := Str.Chars[I];
        K := Ord(Ch);
        DoKeyDown(Self, FOwner.Wnd, K, Ch, FShift);
      end;

      // Get a valid range
      if replacementRange.location = NSNotFound then
        if FMarkedRange.location <> NSNotFound then
          replacementRange := FMarkedRange
        else
          replacementRange := FSelectedRange
      else
      begin
        replacementRange.location := 0;
        replacementRange.length := 0;
      end;

      NativeView.inputContext.invalidateCharacterCoordinates;
      try
        if (FOwner.Wnd.Focused <> nil) then
          FOwner.Wnd.Focused.Repaint;
      except
        Application.HandleException(Self);
      end;
    end;
    FBackingStore.beginEditing;
    R.location := 0;
    R.length := FBackingStore.mutableString.length;
    FBackingStore.deleteCharactersInRange(R);
    FBackingStore.endEditing;

    FMarkedRange.location := NSNotFound;
    FMarkedRange.length := 0;
    FSelectedRange.location := 0;
    FSelectedRange.length := 0;
    UpdateTextServiceControl;
  finally
    AutoReleasePool.release;
  end;
end;

function TFMXViewBase.selectedRange: NSRange;
begin
  Result := FSelectedRange;
end;

procedure TFMXViewBase.setMarkedText(text: Pointer {NSString}; selectedRange,
  replacementRange: NSRange);
var
  NStr: NSString;
  IsAttrString: Boolean;
  TSC: ITextInput;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    if not hasMarkedText then
    try
      if (FOwner.Wnd.Focused <> Nil) and Supports(FOwner.Wnd.Focused, ITextInput, TSC) then
        TTextServiceCocoa(TSC.GetTextService).InternalStartIMEInput;
    except
      Application.HandleException(Self);
    end;

  //function ToNSString(const text : Pointer; var NStr: NSString): Boolean;
    IsAttrString := ToNSString(text, NStr);
  //  if TNSObject.Wrap(text).isKindOfClass(objc_getClass(MarshaledAString('NSAttributedString'))) then
  //  begin
  //    NStr := TNSString.Wrap(objc_msgSend(text, sel_getUid(MarshaledAString('string'))));
  //    IsAttrString := True;
  //  end
  //  else
  //  begin
  //    NStr := TNSString.Wrap(text);
  //    IsAttrString := False;
  //  end;

    NativeView.inputContext.invalidateCharacterCoordinates;
    // Get a valid range
    if replacementRange.location = NSNotFound then
      if FMarkedRange.location <> NSNotFound then
        replacementRange := FMarkedRange
      else
        replacementRange := FSelectedRange
    else
    begin
      replacementRange.location := 0;
      replacementRange.length := 0;
    end;

    // Add the text
    FBackingStore.beginEditing;
    try
      if NStr.length = 0 then
      begin
        FBackingStore.deleteCharactersInRange(replacementRange);
        NativeView.inputContext.discardMarkedText;
        FMarkedRange.location := NSNotFound;
        FMarkedRange.length := 0;
        FSelectedRange.location := 0;
        FSelectedRange.length := 0;
        UpdateTextServiceControl;
        try
          if (FOwner.Wnd.Focused <> nil) and Supports(FOwner.Wnd.Focused, ITextInput, TSC) then
          begin
            TTextServiceCocoa(TSC.GetTextService).InternalBreakIMEInput;
            TTextServiceCocoa(TSC.GetTextService).InternalEndIMEInput;
          end;
        except
          Application.HandleException(Self);
        end;
      end
      else
      begin
        FSelectedRange.location := replacementRange.location + selectedRange.location;
        FSelectedRange.length := selectedRange.length;
        FMarkedRange.location := replacementRange.location;
        FMarkedRange.length := NStr.length;
        UpdateTextServiceControl;
        if IsAttrString then
          FBackingStore.replaceCharactersInRange(replacementRange, TNSAttributedString.Wrap(text))
        else
          FBackingStore.replaceCharactersInRange(replacementRange, TNSString.Wrap(text));
        try
          if (FOwner.Wnd.Focused <> nil) and Supports(FOwner.Wnd.Focused, ITextInput, TSC) then
            TSC.GetTextService.InternalSetMarkedText(UTF8ToString(NStr.UTF8String));
        except
          Application.HandleException(Self);
        end;
      end;
    finally
      FBackingStore.endEditing;
    end;

    NativeView.inputContext.invalidateCharacterCoordinates;
    try
      if (FOwner.Wnd.Focused <> nil) then
        FOwner.Wnd.Focused.Repaint;
    except
      Application.HandleException(Self);
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TFMXViewBase.unMarkText;
var
  TSC: ITextInput;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
  //  NativeView.inputContext.invalidateCharacterCoordinates;
    FMarkedRange.location := NSNotFound;
    FMarkedRange.length := 0;
    UpdateTextServiceControl;

    try
      if (FOwner.Wnd.Focused <> Nil) and Supports(FOwner.Wnd.Focused, ITextInput, TSC) then
      begin
        TTextServiceCocoa(TSC.GetTextService).InternalSetMarkedText('');
      end;
    except
      Application.HandleException(Self);
    end;

    NativeView.inputContext.discardMarkedText;
  finally
    AutoReleasePool.release;
  end;

//writeln(' unMarkText|BS Old:', UTF8ToString(FBackingStore.mutableString.UTF8String));
//  FBackingStore.beginEditing;
//  R.location := 0;
//  R.length := FBackingStore.mutableString.length;
//  FBackingStore.deleteCharactersInRange(R);
//  FBackingStore.endEditing;
//writeln(' unMarkText|BS New:', UTF8ToString(FBackingStore.mutableString.UTF8String));

end;

function TFMXViewBase.validAttributesForMarkedText: Pointer {NSArray};
var
  Attribs: array[0..1] of Pointer;
  Attrib: NSString;
  AttrArray: NSArray;
begin
  Attrib := NSMarkedClauseSegmentAttributeName;
  Attribs[0] := (Attrib as ILocalObject).GetObjectID;
  Attrib := NSGlyphInfoAttributeName;
  Attribs[1] := (Attrib as ILocalObject).GetObjectID;
  AttrArray := TNSArray.Wrap(TNSArray.OCClass.arrayWithObjects(@Attribs[0], 2));
  Result := (AttrArray as ILocalObject).GetObjectID;

//  Attrib := NSMarkedClauseSegmentAttributeName;
//  Attribs[0] := (Attrib as ILocalObject).GetObjectID;
//  AttrArray := TNSArray.Wrap(TNSArray.OCClass.arrayWithObjects(@Attribs[0], 1));
//  Result := (AttrArray as ILocalObject).GetObjectID;
end;

procedure TFMXViewBase.doCommandBySelector(selector: SEL);
begin
  NativeView.doCommandBySelector(selector);
end;

function TFMXViewBase.drawsVerticallyForCharacterAtIndex(
  charIndex: NSUInteger): Boolean;
begin
  Result := False;
end;

function TFMXViewBase.fractionOfDistanceThroughGlyphForPoint(
  aPoint: NSPoint): CGFloat;
begin
  Result := 0;
end;

function TFMXViewBase.windowLevel: NSInteger;
begin
  Result := NativeView.window.level;
end;

function TFMXViewBase.FocusedTextService: TTextServiceCocoa;
var
  TSC : ITextInput;
begin
  Result := nil;
  if Owner <> nil then
    if Owner.Wnd <> nil then
      if Owner.Wnd.Focused <> nil then
        if Supports(FOwner.Wnd.Focused, ITextInput, TSC) then
          Result := TTextServiceCocoa(TSC.GetTextService);
end;

procedure TFMXViewBase.UpdateTextServiceControl;
var
  TSC: ITextInput;
begin
  if (FOwner.Wnd.Focused <> Nil) and Supports(FOwner.Wnd.Focused, ITextInput, TSC) then
  begin
    TTextServiceCocoa( TSC.GetTextService ).SetMarkedRange(FMarkedRange);
    TTextServiceCocoa( TSC.GetTextService ).SetSelectedRange(FSelectedRange);
  end;
end;

function TFMXViewBase.attributedString: NSAttributedString;
begin
  Result := FBackingStore;
end;

function TFMXViewBase.attributedSubstringForProposedRange(aRange: NSRange;
  actualRange: PNSRange): NSAttributedString;
begin
  // Get a valid range
  if actualRange <> nil then
  begin
    if (aRange.location <> NSNotFound) and (aRange.location < (FBackingStore.length - 1)) then
      actualRange^.location := aRange.location
    else
      actualRange^.location := 0;
    if (aRange.length) <= (FBackingStore.length - actualRange^.location) then
      actualRange^.length := aRange.length
    else
      actualRange^.length := FBackingStore.length - actualRange^.location - 1;

    // Get the backing store matching the range
    if (actualRange^.location = 0) and (actualRange^.length = FBackingStore.length) then
    begin
      Result := FBackingStore;
    end
    else
    begin
      Result := TNSAttributedString.Wrap(FBackingStore.attributedSubstringFromRange(actualRange^));
    end;
  end
  else
    Result := nil;
end;

function TFMXViewBase.baselineDeltaForCharacterAtIndex(
  anIndex: NSUInteger): CGFloat;
begin
  Result := 0;
end;

function TFMXViewBase.characterIndexForPoint(aPoint: NSPoint): NSUInteger;
begin
  Result := 0;
end;

function TFMXViewBase.markedRange: NSRange;
begin
  Result := FMarkedRange;
end;

{ TFMXView3D }

constructor TFMXView3D.Create(const AOwner: TFMXWindow; AFrameRect: NSRect);
var
  V: Pointer;
begin
  inherited Create(AOwner);
  V := NSOpenGLView(Super).initWithFrame(AFrameRect, TNSOpenGLView.OCClass.defaultPixelFormat);
  if NSAppKitVersionNumber >= NSAppKitVersionNumber10_7 then
    NSOpenGLView(Super).setWantsBestResolutionOpenGLSurface(True);
  if GetObjectID <> V then
    UpdateObjectID(V);
end;

destructor TFMXView3D.Destroy;
begin
  NSOpenGLView(Super).clearGLContext;
  inherited;
end;

function TFMXView3D.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(FMXView3D);
end;

{ TFMXWindow}

function TFMXWindow.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(FMXWindow);
end;

function TFMXWindow.GetView: NSView;
begin
  Result := FViewObj.NativeView;
end;

function TFMXWindow.windowShouldClose(Sender: Pointer): Boolean;
var
  Action: TCloseAction;
begin
  Result := False;
  if Application = nil then
    Exit;
  if Application.Terminated then
    Exit;
  try
    Result := Wnd.CloseQuery;
    if Result and Assigned(Wnd.OnClose) then
    begin
      Action := TCloseAction.caHide;
      Wnd.OnClose(Wnd, Action);
      if Action = TCloseAction.caMinimize then
      begin
        Result := False;
        Wnd.WindowState := TWindowState.wsMinimized;
      end
      else
        if (Application <> nil) and (Wnd = Application.MainForm) then
          Result := (Action in [TCloseAction.caHide, TCloseAction.caFree])
        else
        begin
          Result := (Action = TCloseAction.caHide);
          if Action = TCloseAction.caFree then
            Wnd.Release;
        end;
    end;
  except
    Application.HandleException(Self);
  end;
end;

procedure TFMXWindow.windowWillClose(notification: NSNotification);
begin
  if (Application <> nil) and (Application.MainForm = Wnd) then
    Application.Terminate;
end;


procedure TFMXWindow.windowDidBecomeKey(notification: NSNotification);
begin
  try
    Wnd.Activate;
  except
    Application.HandleException(Self);
  end;
end;

procedure TFMXWindow.windowDidChangeBackingProperties(notification: NSNotification);
begin
  if (Application = nil) or (Application.Terminated) then
    Exit;
  try
    TMessageManager.DefaultManager.SendMessage(nil, TScaleChangedMessage.Create(Wnd), True);
  except
    Application.HandleException(Self);
  end;
end;

procedure TFMXWindow.windowDidResignKey(notification: NSNotification);
begin
  if (Application = nil) or (Application.Terminated) then
    Exit;
  if Wnd <> nil then
  begin
    try
      Wnd.Deactivate;
      if (not Wnd.StaysOpen) then
      begin
        if IsPopup(Wnd) then
        begin
          if CanClosePopup(Wnd) then
            Wnd.Close;
        end
        else
          Wnd.Close;
      end;
    except
      Application.HandleException(Self);
    end;
  end;
end;

procedure TFMXWindow.windowDidResize(notification: NSNotification);
var
  LFrame: NSRect;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    LFrame := NSWindow(Super).frame;
    try
      Wnd.SetBounds(round(LFrame.origin.x),
        round(TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size.height - LFrame.origin.y - LFrame.size.height),
        round(LFrame.size.width), round(LFrame.size.height));
    except
      Application.HandleException(Self);
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TFMXWindow.windowDidMove(notification: NSNotification);
var
  LFrame: NSRect;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    LFrame := NSWindow(Super).frame;
    try
      Wnd.SetBounds(round(LFrame.origin.x),
        round(TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size.height - LFrame.origin.y - LFrame.size.height),
        round(LFrame.size.width), round(LFrame.size.height));
    except
      Application.HandleException(Self);
    end;
  finally
    AutoReleasePool.release;
  end;
end;

var
  GlobalData: TDragObject;

function GetDataObject(sender: NSDraggingInfo): TDragObject;
var
  PBoard: NSPasteboard;
  Str: NSString;
  Arr: NSArray;
  W: string;
  I: Integer;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    FillChar(Result, SizeOf(Result), 0);

    PBoard := sender.draggingPasteboard;
    if PBoard.types.containsObject((NSFMXPboardType as ILocalObject).GetObjectID) then
    begin
      Result := GlobalData;
      Exit;
    end;

    if PBoard.types.containsObject((NSPasteboardTypeString as ILocalObject).GetObjectID) then
    begin
      Str := PBoard.stringForType(NSPasteboardTypeString);
      W := UTF8ToString(str.UTF8String);
      Result.Data := W;
    end;

    if PBoard.types.containsObject((NSFilenamesPboardType as ILocalObject).GetObjectID) then
    begin
      Arr := TNSArray.Wrap(PBoard.propertyListForType(NSFilenamesPboardType));
      SetLength(Result.Files, Arr.count);
      for I := 0 to Arr.count - 1 do
      begin
        Str := TNSString.Wrap(Arr.objectAtIndex(I));
        W := UTF8ToString(Str.UTF8String);
        Result.Files[I] := W;
      end;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

function TFMXWindow.draggingEntered(Sender: Pointer): NSDragOperation;
var
  mp: NSPoint;
  P: TPointF;
  DragInfo: NSDraggingInfo;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    DragInfo := TNSDraggingInfo.Wrap(Sender);
    mp := DragInfo.draggingLocation;
    mp.y := View.bounds.size.height - mp.y;
    P := PointF(mp.x, mp.y);
    try
      Wnd.DragEnter(GetDataObject(DragInfo), Wnd.ClientToScreen(P));
    except
      Application.HandleException(Self);
    end;
    Result := NSDragOperationEvery;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TFMXWindow.draggingExited(Sender: Pointer {id});
begin
  try
    Wnd.DragLeave;
  except
    Application.HandleException(Self);
  end;
end;

function TFMXWindow.draggingUpdated(Sender: Pointer): NSDragOperation;
var
  mp: NSPoint;
  P: TPointF;
  Accept: Boolean;
  DragInfo: NSDraggingInfo;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    DragInfo := TNSDraggingInfo.Wrap(Sender);
    mp := DragInfo.draggingLocation;
    mp.y := View.bounds.size.height - mp.y;
    P := PointF(mp.x, mp.y);
    Accept := False;
    try
      Wnd.DragOver(GetDataObject(DragInfo), Wnd.ClientToScreen(P), Accept);
    except
      Application.HandleException(Self);
    end;
    if Accept then
      Result := NSDragOperationLink
    else
      Result := NSDragOperationNone;
  finally
    AutoReleasePool.release;
  end;
end;

function TFMXWindow.performDragOperation(Sender: Pointer): Boolean;
var
  mp: NSPoint;
  P: TPointF;
  DragInfo: NSDraggingInfo;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    DragInfo := TNSDraggingInfo.Wrap(Sender);
    mp := DragInfo.draggingLocation;
    mp.y := View.bounds.size.height - mp.y;
    P := PointF(mp.x, mp.y);
    try
      Wnd.DragDrop(GetDataObject(DragInfo), Wnd.ClientToScreen(P));
    except
      Application.HandleException(Self);
    end;
    Result := True;
  finally
    AutoReleasePool.release;
  end;
end;

function TFMXWindow.performKeyEquivalent(event: NSEvent): Boolean;
var
  VKKeyCode: integer;
  Shift: TShiftState;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Result := False;
     //IME's conversion window.is active.
    if (FViewObj <> Nil) and FViewObj.hasMarkedText then
      exit;

    Result := PlatformCocoa.KeyDown(self, Wnd, event, True, VKKeyCode, Shift);
//    Result := True; {to cancel the squeak}
  finally
    AutoReleasePool.release;
  end;
end;

function TFMXWindow.acceptsFirstResponder: Boolean;
begin
  Result := True;
end;

function TFMXWindow.becomeFirstResponder: Boolean;
begin
  Result := True;
end;

function TFMXWindow.resignFirstResponder: Boolean;
begin
  Result := True;
end;

function TFMXWindow.canBecomeKeyWindow: Boolean;
begin
  if (Wnd <> nil) and Assigned(Wnd.Handle) then
    Result := True
  else
    Result := False;
end;

function TFMXWindow.canBecomeMainWindow: Boolean;
begin
  Result := True;
end;

destructor TFMXWindow.Destroy;
begin
  if FViewObj <> nil then
  begin
    FViewObj.NativeView.setHidden(True);
    NSWindow(Super).setContentView(nil);
    // A reference for the paint context was manually added when the window was
    // created. Clear the reference here to avoid leaking view objects.
    FViewObj._Release;
    FViewObj := nil;
  end;
  if FDelegate <> nil then
  begin
    FDelegate := nil;
    NSWindow(Super).setDelegate(nil);
  end;
  if Assigned(Wnd.Handle) then
    NSWindow(Super).close;
  Wnd := nil;
  NSWindow(Super).release;
  inherited;
end;

{ TFMXWindowDelegate }

type
  TFMXWindowDelegate = class(TOCLocal, NSWindowDelegate)
  private
    FWindow: TFMXWindow;
  public
    constructor Create(AOwner: TFMXWindow);
    destructor Destroy; override;
    function windowShouldClose(Sender: Pointer {id}): Boolean; cdecl;
    procedure windowWillClose(notification: NSNotification); cdecl;
    procedure windowDidBecomeKey(notification: NSNotification); cdecl;
    procedure windowDidResignKey(notification: NSNotification); cdecl;
    procedure windowDidResize(notification: NSNotification); cdecl;
    procedure windowDidMove(notification: NSNotification); cdecl;
    procedure windowDidChangeBackingProperties(notification: NSNotification); cdecl;
  end;

constructor TFMXWindowDelegate.Create(AOwner: TFMXWindow);
begin
  inherited Create;
  FWindow := AOwner;
end;

destructor TFMXWindowDelegate.Destroy;
begin
  FWindow := nil;
  objc_msgSend(GetObjectID, sel_getUid('release'));
  inherited;
end;

procedure TFMXWindowDelegate.windowDidBecomeKey(notification: NSNotification);
begin
  FWindow.windowDidBecomeKey(notification);
end;

procedure TFMXWindowDelegate.windowDidChangeBackingProperties(notification: NSNotification);
begin
  FWindow.windowDidChangeBackingProperties(notification);
end;

procedure TFMXWindowDelegate.windowDidMove(notification: NSNotification);
begin
  FWindow.windowDidMove(notification);
end;

procedure TFMXWindowDelegate.windowDidResignKey(notification: NSNotification);
begin
  FWindow.windowDidResignKey(notification);
end;

procedure TFMXWindowDelegate.windowDidResize(notification: NSNotification);
begin
  FWindow.windowDidResize(notification);
end;

function TFMXWindowDelegate.windowShouldClose(Sender: Pointer): Boolean;
begin
  Result := FWindow.windowShouldClose(Sender);
end;

procedure TFMXWindowDelegate.windowWillClose(notification: NSNotification);
var
  NSApp: NSApplication;
  ModWin: NSWindow;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    NSApp := TNSApplication.Wrap(TNSApplication.OCClass.sharedApplication);
    ModWin := NSApp.modalWindow;
    if (ModWin <> nil) and (FWindow <> nil) and
      ((ModWin as ILocalObject).GetObjectID = (FWindow.Super as ILocalObject).GetObjectID) then
    begin
      NSApp.abortModal;
    end;
    FWindow.windowWillClose(notification);
  finally
    AutoReleasePool.release;
  end;
end;

function TPlatformCocoa.FindForm(const AHandle: TWindowHandle): TCommonCustomForm;
begin
  Result := WindowHandleToPlatform(AHandle).Form;
end;

procedure frameDrawRect(self: Pointer; _cmd: Pointer; dirtyRect: NSRect); cdecl;
var
  nctx: NSGraphicsContext;
  windowRect: NSRect;
  cornerRadius: Single;
  Path: NSBezierPath;
  Wnd: NSWindow;
  WindowBorder: TWindowBorderCocoa;
  Form: TCommonCustomForm;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Wnd := TNSView.Wrap(self).window;
    Form := TMacWindowHandle.FindForm(Wnd);
    if Assigned(Form) and Form.Border.IsSupported then
    begin
      WindowBorder := TWindowBorderCocoa(Form.Border.WindowBorder);

      windowRect := Wnd.frame;
      windowRect.origin.x := 0;
      windowRect.origin.y := 0;
      cornerRadius := 4;

      nctx := TNSGraphicsContext.Wrap(TNSGraphicsContext.OCClass.currentContext);
      CGContextClearRect(nctx.graphicsPort, windowRect);

      Path := TNSBezierPath.Wrap(TNSBezierPath.OCClass.bezierPathWithRoundedRect(windowRect, cornerRadius, cornerRadius));
      Path.addClip;

      CGContextTranslateCTM(nctx.graphicsPort, 0, Wnd.frame.size.height);
//      CGContextScaleCTM(nctx.graphicsPort, 1, -1);
      WindowBorder.Paint(nctx.graphicsPort);
    end
    else
    begin
      objc_msgSend(self, sel_getUid('drawRectOriginal:'), dirtyRect);
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.HookFrame(const NSWin: NSWindow);
var
  FrameClass: Pointer;
  M1, M2: Pointer;
  AutoReleasePool: NSAutoreleasePool;
begin
  Inc(FClassHookCount);
  if FClassHookCount > 1 then Exit;
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    // Replace drawRect method on window frame
    FrameClass := object_getClass(TNSView.Wrap(NSWin.contentView).superview);
    class_addMethod(FrameClass, sel_getUid('drawRectOriginal:'), @frameDrawRect, 'v@:@{NSRect={NSPoint=ff}{NSSize=ff}}');
    M1 := class_getInstanceMethod(FrameClass, sel_getUid('drawRect:'));
    M2 := class_getInstanceMethod(FrameClass, sel_getUid('drawRectOriginal:'));
    method_exchangeImplementations(M1, M2);
    //
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.UnHookFrame(const NSWin: NSWindow);
var
  FrameClass: Pointer;
  M1, M2: Pointer;
  AutoReleasePool: NSAutoreleasePool;
begin
  Dec(FClassHookCount);
  if FClassHookCount > 0 then Exit;
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    // restore old
    FrameClass := object_getClass(TNSView.Wrap(NSWin.contentView).superview);
    M1 := class_getInstanceMethod(FrameClass, sel_getUid('drawRect:'));
    M2 := class_getInstanceMethod(FrameClass, sel_getUid('drawRectOriginal:'));
    method_exchangeImplementations(M1, M2);
  finally
    AutoReleasePool.release;
  end;
end;

function TPlatformCocoa.CreateWindow(const AForm: TCommonCustomForm): TWindowHandle;
var
  Style: NSUInteger;
  FMXWin: TFMXWindow;
  NSWin: NSWindow;
  NSTitle: NSString;
  R: NSRect;
  LocalObj: ILocalObject;
  DraggedTypes: array[0..3] of Pointer;
  RegTypes: NSArray;
  PaintControl: IPaintControl;
  AutoReleasePool: NSAutoReleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    if AForm.Owner is TPopup then
      FMXWin := TFMXPanelWindow.Create
    else
      FMXWin := TFMXWindow.Create;
    NSWin := NSWindow(FMXWin.Super);
    if AForm.Transparency or (AForm.BorderStyle = TFmxFormBorderStyle.bsNone) then
      Style := NSBorderlessWindowMask
    else
    begin
      Style := NSTitledWindowMask or NSUnifiedTitleAndToolbarWindowMask;
      if AForm.BorderStyle <> TFmxFormBorderStyle.bsNone then
      begin
        if TBorderIcon.biMinimize in AForm.BorderIcons then
          Style := Style or NSMiniaturizableWindowMask;
        if TBorderIcon.biMaximize in AForm.BorderIcons then
          Style := Style or NSWindowZoomButton;
        if TBorderIcon.biSystemMenu in AForm.BorderIcons then
          Style := Style or NSClosableWindowMask;
      end;
      if AForm.BorderStyle in [TFmxFormBorderStyle.bsSizeable, TFmxFormBorderStyle.bsSizeToolWin] then
        Style := Style or NSResizableWindowMask;
    end;
    R := TNSWindow.OCClass.contentRectForFrameRect(MakeNSRect(AForm.Left,
      TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size.height - AForm.Top - AForm.height,
      AForm.width, AForm.height), Style);
    NSWin.initWithContentRect(R, Style, NSBackingStoreBuffered, True);
    NSWin.setAcceptsMouseMovedEvents(True);
    NSWin.setReleasedWhenClosed(False);
    NSWin.setShowsToolbarButton(True);
    if Supports(NSWin, NSPanel) then
      (NSWin as NSPanel).setWorksWhenModal(True);
    NSWin.useOptimizedDrawing(True);
    NSTitle := NSSTR(AForm.Caption);
    NSWin.setTitle(NSTitle);
    if AForm.TopMost then
      NSWin.setLevel(kCGModalPanelWindowLevelKey);
    FMXWin.Wnd := AForm;

    HookFrame(NSWin);

    R := MakeNSRect(0, 0, R.size.width, R.size.height);

    if TWindowStyle.wsGPUSurface in AForm.WindowStyle then
      FMXWin.FViewObj := TFMXView3D.Create(FMXWin, R)
    else
      FMXWin.FViewObj := TFMXView.Create(FMXWin, R);
    if Supports(FMXWin.FViewObj, ILocalObject, LocalObj) then
    begin
      if Supports(AForm, IPaintControl, PaintControl) then
        PaintControl.ContextHandle := THandle(LocalObj.GetObjectID);
      FMXWin.FViewObj._AddRef;
    end;
    FMXWin.View.setAutoresizingMask(NSViewWidthSizable or NSViewHeightSizable);
      TNSView.Wrap(NSWin.contentView).setAutoresizesSubviews(True);
      TNSView.Wrap(NSWin.contentView).addSubview(FMXWin.View);

    if AForm.Transparency then
    begin
      NSWin.setOpaque(False);
      NSWin.setHasShadow(False);
    end
    else
    begin
      NSWin.setOpaque(True);
    end;

    DraggedTypes[0] := (NSPasteboardTypeString as ILocalObject).GetObjectID;
    DraggedTypes[1] := (NSFMXPBoardtype as ILocalObject).GetObjectID;
    DraggedTypes[2] := (NSFilenamesPboardType as ILocalObject).GetObjectID;
    DraggedTypes[3] := nil;
    RegTypes := TNSArray.Wrap(TNSArray.OCClass.arrayWithObjects(@DraggedTypes[0], 3));
    NSWin.registerForDraggedTypes(RegTypes);

    FMXWin.FDelegate := TFMXWindowDelegate.Create(FMXWin);
    NSWin.setDelegate(FMXWin.FDelegate);

    Result := TMacWindowHandle.Create(FMXWin);
  finally
    AutoReleasePool.release;
  end;
end;

function TPlatformCocoa.CreateWindowBorder(const AForm: TCommonCustomForm): TWindowBorder;
begin
  Result := FMX.Forms.Border.Mac.CreateWindowBorder(AForm);
end;

procedure TPlatformCocoa.DestroyWindow(const AForm: TCommonCustomForm);
var
  NSWin: NSWindow;
  PaintControl: IPaintControl;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    if Assigned(AForm.Handle) then
    begin
      NSWin := WindowHandleToPlatform(AForm.Handle).Wnd;
      UnHookFrame(NSWin);
      if NSWin.isVisible then
        NSWin.orderOut(nil);
      if Supports(AForm, IPaintControl, PaintControl) then
        PaintControl.ContextHandle := 0;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.ReleaseWindow(const AForm: TCommonCustomForm);
begin
  if AForm <> nil then
  begin
    DoReleaseWindow(AForm);
  end;
end;

procedure TPlatformCocoa.DoReleaseWindow(AForm: TCommonCustomForm);
var
  AutoReleasePool: NSAutoreleasePool;
begin
  if AForm <> nil then
  begin
    AutoReleasePool := TNSAutoreleasePool.Create;
    try
      if Assigned(AForm.Handle) then
      begin
        WindowHandleToPlatform(AForm.Handle).Wnd.setOneShot(True);
        WindowHandleToPlatform(AForm.Handle).Wnd.orderOut(nil);
      end;
    finally
      AutoReleasePool.release;
    end;
  end;
end;

procedure TPlatformCocoa.SetWindowRect(const AForm: TCommonCustomForm; ARect: TRectF);
var
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    WindowHandleToPlatform(AForm.Handle).Wnd.setFrame(MakeNSRect(ARect.Left, TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size.height - ARect.Bottom,
      ARect.Right - ARect.Left, ARect.Bottom - ARect.Top), True);
  finally
    AutoReleasePool.release;
  end;
end;

function TPlatformCocoa.GetWindowRect(const AForm: TCommonCustomForm): TRectF;
var
  NSWin: NSWindow;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    NSWin := WindowHandleToPlatform(AForm.Handle).Wnd;
    Result := RectF(NSWin.frame.origin.x, TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size.height - NSWin.frame.origin.y - NSWin.frame.size.height,
      NSWin.frame.origin.x + NSWin.frame.size.width, TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size.height - NSWin.frame.origin.y);
  finally
    AutoReleasePool.release;
  end;
end;

function TPlatformCocoa.GetWindowScale(const AForm: TCommonCustomForm): Single;
begin
  if NSAppKitVersionNumber >= NSAppKitVersionNumber10_7 then
    Result := WindowHandleToPlatform(AForm.Handle).Wnd.backingScaleFactor
  else
    Result := 1.0;
end;

procedure TPlatformCocoa.InvalidateImmediately(const AForm: TCommonCustomForm);
begin
  InvalidateWindowRect(AForm, AForm.ClientRect);
end;

procedure TPlatformCocoa.InvalidateWindowRect(const AForm: TCommonCustomForm; R: TRectF);
var
  View: NSView;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    if IntersectRect(R, RectF(0, 0, AForm.width, AForm.height)) then
    begin
      View := WindowHandleToPlatform(AForm.Handle).View;
      View.setNeedsDisplayInRect(MakeNSRect(R.Left, View.bounds.size.height - R.Bottom, R.Right - R.Left, R.Bottom - R.Top));
    end;
  finally
    AutoReleasePool.release;
  end;
end;

function TPlatformCocoa.IsMenuBarOnWindowBorder: boolean;
begin
  Result := False;
end;

{ TFMXAlertDelegate }

type

  AlertDelegate = interface(NSObject)
    ['{F7AE5530-0A75-4303-8F62-7ABCEB6EF8FE}']
    procedure alertDidEndSelector(alert: Pointer; returnCode: NSInteger; contextInfo: Pointer); cdecl;
  end;

  TFMXAlertDelegate = class(TOCLocal, NSAlertDelegate)
  private
    Modal: Boolean;
    Results: array of Integer;
    Result: Integer;
  public
    function GetObjectiveCClass: PTypeInfo; override;
    procedure alertDidEndSelector(alert: Pointer; returnCode: NSInteger; contextInfo: Pointer); cdecl;
  end;

function TFMXAlertDelegate.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(AlertDelegate);
end;

procedure TFMXAlertDelegate.alertDidEndSelector(alert: Pointer; returnCode: NSInteger; contextInfo: Pointer);
var
  R: integer;
begin
  R := returnCode - NSAlertFirstButtonReturn;
  if (R >= 0) and (R < Length(Results)) then
    Result := Results[R]
  else
    Result := mrCancel;
  Modal := False;
end;

var
  MsgTitles: array[TMsgDlgType] of string = (SMsgDlgWarning, SMsgDlgError, SMsgDlgInformation, SMsgDlgConfirm, '');

  ModalResults: array[TMsgDlgBtn] of Integer = (
    mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry, mrIgnore,
    mrAll, mrNoToAll, mrYesToAll, 0, mrClose);
  ButtonCaptions: array[TMsgDlgBtn] of string = (
    SMsgDlgYes, SMsgDlgNo, SMsgDlgOK, SMsgDlgCancel, SMsgDlgAbort,
    SMsgDlgRetry, SMsgDlgIgnore, SMsgDlgAll, SMsgDlgNoToAll, SMsgDlgYesToAll,
    SMsgDlgHelp, SMsgDlgClose);

function TPlatformCocoa.MessageDialog(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DefaultButton: TMsgDlgBtn; X, Y,
  HelpCtx: Integer; const HelpFileName: string): Integer;
var
  Alert: NSAlert;
  Delegate: TFMXAlertDelegate;
  Session: NSModalSession;
  NSWin: NSWindow;
  S: SEL;
  AF: TCommonCustomForm;
  R: integer;
  procedure AddButtons(IsDefault: boolean);
  var
    B: TMsgDlgBtn;
    procedure AddBtn(B: TMsgDlgBtn);
    begin
      SetLength(Delegate.Results, Length(Delegate.Results) + 1);
      Delegate.Results[High(Delegate.Results)] := ModalResults[B];
      Alert.addButtonWithTitle(NSStr(ButtonCaptions[B]));
    end;
  begin
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if (B in Buttons) and (IsDefault xor (B <> DefaultButton)) then
        AddBtn(B);
    if (not IsDefault) and (Length(Delegate.Results) = 0) then
      AddBtn(DefaultButton);
  end;
begin
  Delegate := TFMXAlertDelegate.Create;
  Delegate.Modal := True;

  if Assigned(Screen) then
  begin
    CloseAllPopups;
    AF := Screen.ActiveForm;
    if (AF <> nil) and Assigned(AF.Handle) and (AF.Visible) and not (AF.Owner is TPopup) then
    begin
      NSWin := WindowHandleToPlatform(AF.Handle).Wnd;
      if NSWin <> nil then
        NSWin.retain;
    end;
  end;

  S := sel_getUid('alertDidEndSelector:returnCode:contextInfo:');
  Alert := TNSAlert.Create;
  Alert.setInformativeText(NSSTR(Msg));
  Alert.setMessageText(NSSTR(MsgTitles[DlgType]));
  if DlgType = TMsgDlgType.mtWarning then
    Alert.setAlertStyle(NSWarningAlertStyle)
  else if DlgType = TMsgDlgType.mtError then
    Alert.setAlertStyle(NSCriticalAlertStyle)
  else
    Alert.setAlertStyle(NSInformationalAlertStyle);

  AddButtons(True);
  AddButtons(False);

  if Assigned(NSWin) then
  begin
    Alert.beginSheetModalForWindow(NSWin, ILocalObject(Delegate).GetObjectID, S, nil);
    Session := NSApp.beginModalSessionForWindow(NSWin);
    while Delegate.Modal do
    begin
      NSApp.runModalSession(Session);
      Application.HandleMessage;
    end;
    NSApp.endModalSession(Session);
    NSWin.release;
    Result := Delegate.Result;
  end
  else
  begin
    R := Alert.runModal - NSAlertFirstButtonReturn;
    if (R >= 0) and (R < Length(Delegate.Results)) then
      Result := Delegate.Results[R]
    else
      Result := mrCancel;
  end;
end;

function TPlatformCocoa.InputQuery(const ACaption: string; const APrompts: array of string; var AValues: array of string;
  CloseQueryFunc: TInputCloseQueryFunc): Boolean;
var
  Alert: NSAlert;
  Delegate: TFMXAlertDelegate;
  Session: NSModalSession;
  NSWin: NSWindow;
  S: SEL;
  View: NSView;
  Text: NSTextField;
  Inputs: array of NSTextField;
  I: Integer;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Result := False;
    if (Length(AValues) > 0) and (Length(APrompts) > 0) then
    begin
      Delegate := TFMXAlertDelegate.Create;
      Delegate.Modal := True;
      SetLength(Delegate.Results, 2);
      Delegate.Results[0] := ModalResults[TMsgDlgBtn.mbOK];
      Delegate.Results[1] := ModalResults[TMsgDlgBtn.mbCancel];

      if Assigned(Screen) and Assigned(Screen.ActiveForm) and Assigned(Screen.ActiveForm.Handle) and (Screen.ActiveForm.Visible) then
      begin
        NSWin := WindowHandleToPlatform(Screen.ActiveForm.Handle).Wnd;
        NSWin.retain;
      end;

      S := sel_getUid('alertDidEndSelector:returnCode:contextInfo:');
      Alert := TNSAlert.Wrap(TNSAlert.Alloc.init);
      Alert.setMessageText(NSSTR(ACaption));

      Alert.addButtonWithTitle(NSStr(ButtonCaptions[TMsgDlgBtn.mbOK]));
      Alert.addButtonWithTitle(NSStr(ButtonCaptions[TMsgDlgBtn.mbCancel]));

      View := TNSView.Wrap(TNSView.Alloc.initWithFrame(MakeNSRect(0, 0, 400, Length(AValues) * 60)));

      SetLength(Inputs, Length(AValues));
      for I := 0 to High(Inputs) do
      begin
        Text := TNSTextField.Wrap(TNSTextField.Alloc.initWithFrame(MakeNSRect(0, View.frame.size.height - I * 60 - 36, 400, 24)));
        Text.setDrawsBackground(False);
        Text.setEditable(False);
        Text.setSelectable(False);
        Text.setBordered(False);
        Text.setBackgroundColor(TNSColor.Wrap(TNSColor.OCClass.clearColor));
        Text.setStringValue(NSSTR(APrompts[I]));
        View.addSubview(Text);
        Inputs[I] := TNSTextField.Wrap(TNSTextField.Alloc.initWithFrame(MakeNSRect(0, View.frame.size.height - I * 60 - 60, 400, 24)));
        Inputs[I].setStringValue(NSSTR(AValues[I]));
        View.addSubview(Inputs[I]);
      end;

      Alert.setAccessoryView(View);

      if Assigned(NSWin) then
      begin
        Alert.beginSheetModalForWindow(NSWin, ILocalObject(Delegate).GetObjectID, S, nil);
        Session := NSApp.beginModalSessionForWindow(NSWin);
        while Delegate.Modal do
        begin

          NSApp.runModalSession(Session);
          Application.HandleMessage;
        end;
        NSApp.endModalSession(Session);
        NSWin.release;
        Result := Delegate.Result = mrOk;
        if Result then
          for I := 0 to High(Inputs) do
            {$WARNINGS OFF}
            AValues[I] := Inputs[I].stringValue.UTF8String;
            {$WARNINGS ON}
      end
      else
      begin
        case Alert.runModal of
          NSAlertFirstButtonReturn:
            begin
              for I := 0 to High(Inputs) do
                {$WARNINGS OFF}
                AValues[I] := Inputs[I].stringValue.UTF8String;
                {$WARNINGS ON}
              Result := True;
            end;
        else
          Result := False;
        end;
      end;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

function TPlatformCocoa.AllocHandle(const Objc: IObjectiveC): TFmxHandle;
begin
  Result := NewFmxHandle;
  TMonitor.Enter(FObjectiveCMap);
  try
    FObjectiveCMap.Add(Result, Objc);
  finally
    TMonitor.Exit(FObjectiveCMap);
  end;
end;

function TPlatformCocoa.NewFmxHandle: TFmxHandle;
begin
{$IFDEF CPUX64}
  Result := TInterlocked.Add(Int64(FHandleCounter), 16);
{$ENDIF}
{$IFDEF CPUX86}
  Result := TInterlocked.Add(Integer(FHandleCounter), 16);
{$ENDIF}
end;

procedure TPlatformCocoa.SetWindowCaption(const AForm: TCommonCustomForm; const ACaption: string);
var
  NSWin: NSWindow;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    NSWin := WindowHandleToPlatform(AForm.Handle).Wnd;
    NSWin.setTitle(NSSTR(ACaption));
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.SetWindowState(const AForm: TCommonCustomForm; const AState: TWindowState);
var
  NSWin: NSWindow;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    NSWin := WindowHandleToPlatform(AForm.Handle).Wnd;

    case AState of
    TWindowState.wsMinimized: if not NSWin.isMiniaturized then NSWin.performMiniaturize(nil);
    TWindowState.wsNormal:
      begin
        if NSWin.isMiniaturized then NSWin.performMiniaturize(nil);
        if NSWin.isZoomed then NSWin.performZoom(nil);
      end;
    TWindowState.wsMaximized: if not NSWin.isZoomed then NSWin.performZoom(nil);
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.RegisterCanvasClasses;
begin
  if GlobalUseGPUCanvas then
    FMX.Canvas.GPU.RegisterCanvasClasses;
  FMX.Canvas.Mac.RegisterCanvasClasses;
end;

procedure TPlatformCocoa.UnregisterCanvasClasses;
begin
  if GlobalUseGPUCanvas then
    FMX.Canvas.GPU.UnregisterCanvasClasses;
  FMX.Canvas.Mac.UnregisterCanvasClasses;
end;

procedure TPlatformCocoa.RegisterContextClasses;
begin
  FMX.Context.Mac.RegisterContextClasses;
end;

procedure TPlatformCocoa.UnregisterContextClasses;
begin
  FMX.Context.Mac.UnregisterContextClasses;
end;

procedure TPlatformCocoa.ReleaseCapture(const AForm: TCommonCustomForm);
begin
//  Windows.ReleaseCapture;
end;

procedure TPlatformCocoa.SetCapture(const AForm: TCommonCustomForm);
begin
//  Windows.SetCapture(AHandle);
end;

function TPlatformCocoa.GetCaretWidth: Integer;
begin
  Result := 1;
end;

function TPlatformCocoa.GetClientSize(const AForm: TCommonCustomForm): TPointF;
var
  LView: NSView;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    LView := WindowHandleToPlatform(AForm.Handle).View;
    Result := PointF(LView.frame.size.width, LView.frame.size.height);
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.HideWindow(const AForm: TCommonCustomForm);
begin
  if (AForm <> nil) and Assigned(AForm.Handle) then
    WindowHandleToPlatform(AForm.Handle).Wnd.orderOut(nil);
end;

procedure TPlatformCocoa.ShowWindow(const AForm: TCommonCustomForm);
var
  NSWin: NSWindow;
  frame: NSRect;
  AutoReleasePool: NSAutoReleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    if AForm.WindowState <> TWindowState.wsNormal then
      SetWindowState(AForm, AForm.WindowState);
    NSWin := WindowHandleToPlatform(AForm.Handle).Wnd;

    NSWin.makeKeyAndOrderFront((NSApp as ILocalObject).GetObjectID);
    if AForm = Application.MainForm then
      NSWin.makeMainWindow;
    frame := NSWin.frame;
      AForm.SetBounds(round(frame.origin.x),
        round(TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size.height - frame.origin.y - frame.size.height),
        round(frame.size.width), round(frame.size.height))
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.BringToFront(const AForm: TCommonCustomForm);
var
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    WindowHandleToPlatform(AForm.Handle).Wnd.orderFront(nil);
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.SendToBack(const AForm: TCommonCustomForm);
var
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    WindowHandleToPlatform(AForm.Handle).Wnd.orderBack(nil);
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.Activate(const AForm: TCommonCustomForm);
var
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    WindowHandleToPlatform(AForm.Handle).Wnd.makeKeyWindow;
  finally
    AutoReleasePool.release;
  end;
end;

function TPlatformCocoa.ShowWindowModal(const AForm: TCommonCustomForm): TModalResult;
var
  Session: NSModalSession;
  MR: Integer;
  NSWin: NSWindow;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    if FModalStack = nil then
      FModalStack := TStack<TCommonCustomForm>.Create;
    FRestartModal := False;
    FModalStack.Push(AForm);
    try
      Result := mrNone;
      NSWin := WindowHandleToPlatform(AForm.Handle).Wnd;
      NSWin.retain;
      try
        AForm.Show;
        AForm.ModalResult := mrNone;
        Session := NSApp.beginModalSessionForWindow(NSWin);
        while True do
        begin
          MR := NSApp.runModalSession(Session);
          if MR <> NSRunContinuesResponse then
          begin
            if FRestartModal then
            begin
              FRestartModal := False;
              NSApp.endModalSession(Session);
              Session := NSApp.beginModalSessionForWindow(NSWin);
              Continue;
            end;
            if AForm.Visible then
              AForm.Hide;
            Result := AForm.ModalResult;
            if csDestroying in AForm.ComponentState then
              DoReleaseWindow(AForm);
            FModalStack.Pop;
            if FModalStack.Count > 0 then
              FRestartModal := True;
            Break;
          end;
          if AForm.ModalResult <> 0 then
          begin
            AForm.CloseModal;
            if AForm.ModalResult <> 0 then
            begin
              NSApp.stopModal;
              Continue;
            end;
          end;

          Application.HandleMessage;
        end;
        NSApp.endModalSession(Session);
      finally
        NSWin.release;
      end;
    finally
      if (FModalStack.Count > 0) and (FModalStack.Peek = AForm) then
        FModalStack.Pop;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

function TPlatformCocoa.ClientToScreen(const AForm: TCommonCustomForm; const Point: TPointF): TPointF;
var
  np: NSPoint;
  NSWin: NSWindow;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    NSWin := WindowHandleToPlatform(AForm.Handle).Wnd;
    np := NSPoint(Point);
    np.y := TNSView.Wrap(NSWin.contentView).bounds.size.height - np.y;
    Result := TPointF(NSWin.convertBaseToScreen(np));
    Result.y := TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size.height - Result.y;
  finally
    AutoReleasePool.release;
  end;
end;

function TPlatformCocoa.ScreenToClient(const AForm: TCommonCustomForm; const Point: TPointF): TPointF;
var
  np: NSPoint;
  NSWin: NSWindow;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    NSWin := WindowHandleToPlatform(AForm.Handle).Wnd;
    np := NSPoint(Point);
    np.y := TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size.height - np.y;
    Result := TPointF(NSWin.convertScreenToBase(np));
    Result.y := TNSView.Wrap(NSWin.contentView).bounds.size.height - Result.y;
  finally
    AutoReleasePool.release;
  end;
end;

{ Menus }

type
  TOpenMenuItem = class(TMenuItem);

procedure TPlatformCocoa.StartMenuLoop(const AView: IMenuView);

  procedure EndLoop;
  var
    View: IMenuView;
  begin
    View := AView;
    while View <> nil do
    begin
      View.Loop := False;
      View.Selected := nil;
      View := View.ParentView;
    end;
  end;

  function ContinueLoop: Boolean;
  begin
    Result := AView.Loop;
  end;

  function ForwardSelectNextMenuItem(AView: IMenuView; AStartInd, AEndInd: Integer): Boolean;
  var
    I: Integer;
  begin
    if not Assigned(AView) then
      Exit(False);

    Result := False;
    for I := AStartInd to AEndInd do
      if AView.GetItem(I) is TMenuITem then
      begin
        AView.Selected := TMenuItem(AView.GetItem(I));
        Result := True;
        Break;
      end;
  end;

  function BackwardSelectNextMenuItem(AView: IMenuView; AStartInd, AEndInd: Integer): Boolean;
  var
    I: Integer;
  begin
    if not Assigned(AView) then
      Exit(False);

    Result := False;
    for I := AStartInd downto AEndInd do
      if AView.GetItem(I) is TMenuItem then
      begin
        AView.Selected := TMenuItem(AView.GetItem(I));
        Result := True;
        Break;
      end;
  end;

  procedure SelectFirstMenuItem(AView: IMenuView);
  begin
    ForwardSelectNextMenuItem(AView, 0, AView.GetItemsCount - 1);
  end;

  procedure SelectLastMenuItem(AView: IMenuView);
  begin
    BackwardSelectNextMenuItem(AView, AView.GetItemsCount - 1, 0);
  end;

  procedure SelectPrevMenuItem(AView: IMenuView);
  begin
    if not Assigned(AView) then
      Exit;

    if Assigned(AView.Selected) then
    begin
      { Select first Menu item from old selected to first }
      if BackwardSelectNextMenuItem(AView, AView.Selected.Index - 1, 0) then
        Exit;
      { Select first Menu item from last to old selected }
      BackwardSelectNextMenuItem(AView, AView.GetItemsCount - 1, AView.Selected.Index);
    end
    else
      SelectLastMenuItem(AView);
  end;

  procedure SelectNextMenuItem(AView: IMenuView);
  begin
    if not Assigned(AView) then
      Exit;

    if Assigned(AView.Selected) then
    begin
      { Select first Menu item from old selected to last }
      if ForwardSelectNextMenuItem(AView, AView.Selected.Index + 1, AView.GetItemsCount - 1) then
        Exit;
      { Select first Menu item from first to old selected }
      ForwardSelectNextMenuItem(AView, 0, AView.Selected.Index);
    end
    else
      SelectFirstMenuItem(AView);
  end;


var
  WP: NSPoint;
  P: TPointF;
  InMenus: Boolean;
  CurrentView, NewView: IMenuView;
  Obj: IControl;
  AutoPopupTime: Integer;
  TPos, TOldPos: TPointF;
  event: NSEvent;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    AView.Loop := True;
    TOldPos := GetMousePos;
    TPos := TOldPos;
    AutoPopupTime := 0;
    try
      event := NSApp.nextEventMatchingMask(NSAnyEventMask, TNSDate.Wrap(TNSDate.OCClass.distantFuture), NSDefaultRunLoopMode, True);
      //TNSEvent.OCClass.startPeriodicEventsAfterDelay(0.05, 0.05);
        while ContinueLoop and (event <> nil) do
        begin
          case event.&type of
            NSPeriodic:
              begin
                if (AView <> nil) then
                begin
                  TPos := GetMousePos;
                  AutoPopupTime := AutoPopupTime + 50;
                  // Check auto popup
                  if (TPos.X = TOldPos.X) and (TPos.Y = TOldPos.Y) then
                  begin
                    if (AutoPopupTime >= 500) then
                    begin
                      Obj := AView.ObjectAtPoint(TPos);
                      if (Obj <> nil) and (Obj.GetObject is TMenuItem) then
                      begin
                        TOpenMenuItem(Obj.GetObject).NeedPopup
                      end;
                      AutoPopupTime := 0;
                    end
                  end
                  else
                    AutoPopupTime := 0;
                  TOldPos := TPos;
                end;
              end;
            NSMouseMoved:
              begin
                { Handle MouseOver }
                WP := event.locationInWindow;
                if event.window <> nil then
                  WP := event.window.convertBaseToScreen(WP);
                WP.y := TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size.height - WP.y;
                P := PointF(WP.X, WP.Y);
                Obj := AView.ObjectAtPoint(P);
                { Default }
                NSApp.sendEvent(event);
                { Handle menus }
                AutoPopupTime := 0;
                { Find top level menu }
                CurrentView := AView;
                while CurrentView.ParentView <> nil do
                  CurrentView := CurrentView.ParentView;
                { Check all items }
                while CurrentView <> nil do
                begin
                  Obj := CurrentView.ObjectAtPoint(P);
                  if (Obj <> nil) and (Obj.GetObject is TMenuItem) and not (TMenuItem(Obj.GetObject).IsSelected) then
                  begin
                    if (CurrentView <> AView) then
                    begin
                      NewView := AView;
                      while (NewView <> CurrentView) and (Assigned(NewView)) do
                      begin
                        NewView.Loop := False;
                        NewView := NewView.ParentView;
                      end;
                      TOpenMenuItem(Obj.GetObject).NeedPopup;
                      Exit;
                    end;
                  end;
                  CurrentView := CurrentView.ChildView;
                end;
              end;
            NSLeftMouseDown,
            NSRightMouseDown:
              begin
                { Handle MouseOver if mouse over not menuitem }
                WP := event.locationInWindow;
                if event.window <> nil then
                  WP := event.window.convertBaseToScreen(WP);
                WP.y := TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size.height - WP.y;
                P := PointF(WP.X, WP.Y);
                Obj := AView.ObjectAtPoint(P);
                if (Obj <> nil) and not (Obj is TMenuItem) then
                begin
                  NSApp.sendEvent(event);
                end
                else
                begin
                  { Menus }
                  if (Obj <> nil) and (Obj.GetObject is TMenuItem) then
                  begin
                    if not (TMenuItem(Obj.GetObject).IsSelected) and TMenuItem(Obj.GetObject).HavePopup then
                      TOpenMenuItem(Obj.GetObject).NeedPopup
                    else
                    begin
                      EndLoop;
                      TOpenMenuItem(Obj.GetObject).Click;
                    end;
                  end
                  else
                  begin
                    CurrentView := AView;
                    InMenus := False;
                    while (CurrentView <> nil) and not InMenus do
                    begin
                      if not (CurrentView.IsMenuBar) and (CurrentView.ObjectAtPoint(P) <> nil) then
                        InMenus := True;
                      CurrentView := CurrentView.ParentView;
                    end;
                    if not InMenus then
                      EndLoop;
                  end;
                end;
              end;
            NSLeftMouseUp,
            NSRightMouseUp:
              begin
                { Handle MouseOver if mouse over not menuitem }
                WP := event.locationInWindow;
                if event.window <> nil then
                  WP := event.window.convertBaseToScreen(WP);
                WP.y := TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size.height - WP.y;
                P := PointF(WP.X, WP.Y);
                Obj := AView.ObjectAtPoint(P);
                if (Obj <> nil) and not (Obj is TMenuItem) then
                begin
                  NSApp.sendEvent(event);
                end;
              end;
            NSKeyDown:
              begin
                case event.keyCode of
                  KEY_ENTER:
                    begin
                      if (AView.Selected <> nil) then
                      begin
                        if AView.Selected.HavePopup then
                          AView.Selected.NeedPopup
                        else
                        begin
                          EndLoop;
                          TOpenMenuItem(AView.Selected).Click;
                        end;
                      end
                      else
                        EndLoop;
                    end;
                  KEY_ESC:
                    begin
                      AView.Selected := nil;
                      Exit;
                    end;
                  KEY_LEFT:
                    begin
                      if (AView.ParentView <> nil) then
                        if (AView.ParentView.IsMenuBar) then
                        begin
                          AView.Loop := False;
                          SelectPrevMenuItem(AView.ParentView);
                          if AView.ParentView.Selected <> nil then
                            AView.ParentView.Selected.NeedPopup;
                          Exit;
                        end
                        else
                        begin
                          AView.Loop := False;
                        end;
                    end;
                  KEY_RIGHT:
                    begin
                      if (AView.ParentView <> nil) then
                        if (AView.ParentView.IsMenuBar) then
                        begin
                          AView.Loop := False;
                          SelectNextMenuItem(AView.ParentView);
                          if AView.ParentView.Selected <> nil then
                            AView.ParentView.Selected.NeedPopup;
                          Exit;
                        end
                        else
                        begin
                          AView.Loop := False;
                        end;
                    end;
                  KEY_UP:
                    SelectPrevMenuItem(AView);
                  KEY_DOWN:
                    SelectNextMenuItem(AView);
                end; // case event.keyCode of
              end; // NSKeyDown
          else
            begin
              NSApp.sendEvent(event);
            end;
          end; // case
          event := NSApp.nextEventMatchingMask(NSAnyEventMask, TNSDate.Wrap(TNSDate.OCClass.distantFuture), NSDefaultRunLoopMode, True);
        end; // while
    finally
      AView.Loop := False;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

function TPlatformCocoa.HandleToObjC(FmxHandle: TFmxHandle; const IID: TGUID; out Intf): Boolean;
begin
  Result := Supports(HandleToObjC(FmxHandle), IID, Intf);
end;

procedure TPlatformCocoa.ShortCutToKey(ShortCut: TShortCut; var Key: Word;
  var Shift: TShiftState);
var
  K: char;
  KByte: byte;
  ModifierMask: NSUInteger;
begin
  KByte:= Lo(Shortcut);
  ModifierMask:= 0;

  K:= Chr(KByte);
  Key:= Word(K);

  if ShortCut and scCommand <> 0 then
    ModifierMask := ModifierMask or NSCommandKeyMask;
  if ShortCut and scShift <> 0 then
    ModifierMask := ModifierMask or NSShiftKeyMask;
  if ShortCut and scCtrl <> 0 then
    ModifierMask := ModifierMask or NSControlKeyMask;
  if ShortCut and scAlt <> 0 then
    ModifierMask := ModifierMask or NSAlternateKeyMask;

   Shift:= ShiftStateFromModFlags(ModifierMask);
end;

function ShortCutToChar(ShortCut: TShortCut): string;
var
  key: Byte;
begin
  Result := '';
  Key:= Lo(Word(ShortCut));
  if Key > 0 then
  case Key of
    vkBack         : Result := Chr($232B); //(NSBackspaceCharacter);
    vkTab          : Result := Chr($21E5); //(NSTabCharacter);
    vkReturn       : Result := Chr($21B5); //(NSEnterCharacter);
    vkPrior        : Result := Chr($21DE); //(NSPageUpFunctionKey);
    vkNext         : Result := Chr($21DF); //(NSPageDownFunctionKey);
    vkEnd          : Result := Chr($2198); //(NSEndFunctionKey);
    vkHome         : Result := Chr($2196); //(NSHomeFunctionKey);
    vkLeft         : Result := Chr($2190); //(NSLeftArrowFunctionKey);
    vkUp           : Result := Chr($2191); //(NSUpArrowFunctionKey);
    vkRight        : Result := Chr($2192); //(NSRightArrowFunctionKey);
    vkDown         : Result := Chr($2193); //(NSDownArrowFunctionKey);
    vkDelete       : Result := Chr($2326); //(NSDeleteCharacter);
    vkNumLock      : Result := Chr($2327);
    vkEscape       : Result := Chr($238B);
    vkSemicolon    : Result := ';';
    vkEqual        : Result := '=';
    vkComma        : Result := ',';
    vkMinus        : Result := '-';
    vlPeriod       : Result := '.';
    vkSlash        : Result := '/';
    vkTilde        : Result := '~';
    vkLeftBracket  : Result := '[';
    vkBackslash    : Result := '\';
    vkRightBracket : Result := ']';
    vkQuote        : Result := '''';
    vkNumpad0..vkDivide:
    begin
      Result := 'Num';
      case Key of
        vkNumpad0..vkNumpad9: Result := Result + Chr(Ord('0') + Key - vkNumpad0);
        vkMultiply: Result := Result + '*'; //Chr($00D7);
        vkAdd: Result := Result + '+';
        vkSeparator: Result := Result + ',';
        vkSubtract: Result := Result + '-';
        vkDecimal: Result := Result + '.';
        vkDivide: Result := Result + '/';
      end;
    end;
    $70..$87: Result := 'F' + IntToStr(Key - $6F); //(NSF1FunctionKey+Ord(Key)-$70);
  else
    if Key < $21 then
      Result := Chr($2400 + Key)
    else
      Result := Chr(Key);
  end;
end;

procedure ShortCutToMACKey(ShortCut: TShortCut; var Key: Char; var ModifierMask: NSUInteger);
var
  K: byte;
  S: string;
begin
  K := Lo(ShortCut);
  ModifierMask := 0;
  case K of
    vkBack   : Key := Char(NSBackspaceCharacter);
    vkTab    : Key := Char(NSTabCharacter);
    vkReturn : Key := Char(NSCarriageReturnCharacter);
    vkPrior  : Key := Char(NSPageUpFunctionKey);
    vkNext   : Key := Char(NSPageDownFunctionKey);
    vkEnd    : Key := Char(NSEndFunctionKey);
    vkHome   : Key := Char(NSHomeFunctionKey);
    vkLeft   : Key := Char(NSLeftArrowFunctionKey);
    vkUp     : Key := Char(NSUpArrowFunctionKey);
    vkRight  : Key := Char(NSRightArrowFunctionKey);
    vkDown   : Key := Char(NSDownArrowFunctionKey);
    vkDelete : Key := Char(NSDeleteCharacter);
    vkF1..vkF24: Key := Char(NSF1FunctionKey + (K - vkF1));
  else
    if CharInSet(UpCase(Chr(K)), ['A'..'Z']) then
    begin
      S := Chr(K);
      if ShortCut and scShift <> 0 then
        S := UpperCase(S)
      else
        S := LowerCase(S);
      Key := S[1];
    end
    else
    begin
      S := ShortCutToChar(ShortCut);
      if Length(S) = 1 then
        Key := S[1]
      else
        Key := Chr(K);
    end;
  end;
  if ShortCut and scCtrl <> 0 then
    ModifierMask := ModifierMask or NSControlKeyMask;
  if ShortCut and scAlt <> 0 then
    ModifierMask := ModifierMask or NSAlternateKeyMask;
  if ShortCut and scShift <> 0 then
    ModifierMask := ModifierMask or NSShiftKeyMask;
  if ShortCut and scCommand <> 0 then
    ModifierMask := ModifierMask or NSCommandKeyMask;
end;


function TPlatformCocoa.ShortCutToText(ShortCut: TShortCut): string;
var
  Key: String;
begin
  Result:= '';
  Key := ShortCutToChar(ShortCut);
  if Key <> '' then
  begin
    if ShortCut and scCtrl <> 0 then
      Result:= Result + Chr($2303); // Ctrl modifier (up arrowhead)
    if ShortCut and scAlt <> 0 then
      Result:= Result + Chr($2325); // option modifier (option key)
    if ShortCut and scShift <> 0 then
      Result:= Result + Chr($21E7); // Shift modifier (upwards white arrow)
    if ShortCut and scCommand <> 0 then
      Result:= Result + Chr($2318); // Command modifier (place of interest sign)
    Result:= Result + Key;
  end;
end;

type
  TMenuMACKeyCap = (mkcBkSp, mkcTab, mkcEsc, mkcEnter, mkcSpace, mkcPgUp,
    mkcPgDn, mkcEnd, mkcHome, mkcLeft, mkcUp, mkcRight, mkcDown, mkcIns,
    mkcDel, mkcShift, mkcCtrl, mkcAlt, mkcCmd);

var
  MenuMACKeyCaps: array[TMenuMACKeyCap] of string = (
    SmkcBkSp, SmkcTab, SmkcEsc, SmkcEnter, SmkcSpace, SmkcPgUp,
    SmkcPgDn, SmkcEnd, SmkcHome, SmkcLeft, SmkcUp, SmkcRight,
    SmkcDown, SmkcIns, SmkcDel, SmkcShift, SmkcCtrl, SmkcAlt, SmkcCmd);

function TPlatformCocoa.TextToShortCut(Text: String): integer;
{ If the front of Text is equal to Front then remove the matching piece
    from Text and return True, otherwise return False }

  function CompareFront(var Text: string; const Front: string): Boolean;
  begin
    Result := False;
    if (Length(Text) >= Length(Front)) and
      (AnsiStrLIComp(PChar(Text), PChar(Front), Length(Front)) = 0) then
    begin
      Result := True;
      Delete(Text, 1, Length(Front));
    end;
  end;

var
  Key: TShortCut;
  Shift: TShortCut;
begin
  Result := 0;
  Shift := 0;
  while True do
  begin
    if CompareFront(Text, MenuMACKeyCaps[mkcShift]) then Shift := Shift or scShift
    else if CompareFront(Text, '^') then Shift := Shift or scCtrl
    else if CompareFront(Text, MenuMACKeyCaps[mkcCtrl]) then Shift := Shift or scCtrl
    else if CompareFront(Text, MenuMACKeyCaps[mkcAlt]) then Shift := Shift or scAlt
    else if CompareFront(Text, MenuMACKeyCaps[mkcCmd]) then Shift:= Shift or scCommand
    else Break;
  end;
  if Text = '' then Exit;
  for Key := $08 to $255 do { Copy range from table in ShortCutToText }
    if AnsiCompareText(Text, ShortCutToText(Key)) = 0 then
    begin
      Result := Key or Shift;
      Exit;
    end;
end;
  { TFMXOSMenuItem }

type
  FMXOSMenuItem = interface(NSMenuItem)
    ['{A922028A-C1EE-41AF-8345-26671E6879AD}']
    procedure DispatchMenuClick(Sender: Pointer); cdecl;
  end;

  TFMXOSMenuItem = class(TOCLocal)
  private
    FMXMenuItem: TMenuItem;
  public
    constructor Create(const AFMXMenuItem: TMenuItem);
    destructor Destroy; override;
    function GetObjectiveCClass: PTypeInfo; override;
    procedure DispatchMenuClick(Sender: Pointer); cdecl;
  end;

constructor TFMXOSMenuItem.Create(const AFMXMenuItem: TMenuItem);
var
  Key: Char;
  ModMask: NSUInteger;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    inherited Create;
    FMXMenuItem := AFMXMenuItem;
    ShortCutToMACKey(FMXMenuItem.ShortCut, Key, ModMask);
    UpdateObjectID(NSMenuItem(Super).initWithTitle(NSSTR(DelAmp(FMXMenuItem.Text)),
      sel_getUid(MarshaledAString('DispatchMenuClick:')), NSSTR(Key)));

    if AFMXMenuItem.IsChecked then
      NSMenuItem(Super).setState(NSOnState);

    if AFMXMenuItem.Enabled then
      NSMenuItem(Super).setEnabled(True)
    else
      NSMenuItem(Super).setEnabled(False);

    NSMenuItem(Super).setKeyEquivalentModifierMask(ModMask);
    NSMenuItem(Super).setTarget(GetObjectID);
  finally
    AutoReleasePool.Release;
  end;
end;

destructor TFMXOSMenuItem.Destroy;
begin
  NSMenuItem(Super).Release;
  inherited;
end;

procedure TFMXOSMenuItem.DispatchMenuClick(Sender: Pointer);
begin
  try
    if ((Now - Application.LastKeyPress) > IntervalPress) and
       (FMXMenuItem is TMenuItem) then
      TOpenMenuItem(FMXMenuItem).Click;
  except
    Application.HandleException(Self);
  end;
end;

function TFMXOSMenuItem.GetObjectiveCClass: PTypeInfo;
begin
    Result := TypeInfo(FMXOSMenuItem);
end;

procedure TPlatformCocoa.CreateChildMenuItems(AChildMenu: IItemsContainer; AParentMenu: NSMenu);
var
  I, J: Integer;
  LChildMenuItem: TOpenMenuItem;
  LNSSubMenuItem: TFMXOSMenuItem;
  LNewSubMenu: NSMenu;
  Items: IItemsContainer;
  VisibleItemCount: integer;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    AParentMenu.setAutoenablesItems(False);
    for J := 0 to AChildMenu.GetItemsCount - 1 do
    if AChildMenu.GetItem(J) is TMenuItem then
    begin
      LChildMenuItem := TOpenMenuItem(AChildMenu.GetItem(J));
      if LChildMenuItem.Visible then
      begin
        if LChildMenuItem.Text = '-' then
          AParentMenu.addItem(TNSMenuItem.Wrap(TNSMenuItem.OCClass.separatorItem))
        else
        begin
          LNSSubMenuItem := TFMXOSMenuItem.Create(LChildMenuItem);
          LChildMenuItem.Handle := AllocHandle(LNSSubMenuItem);
          if Supports(AChildMenu.GetItem(J), IItemsContainer, Items) then
          begin
            VisibleItemCount := 0;
            for I := 0 to Items.GetItemsCount - 1 do
              if (Items.GetItem(I) is TMenuItem) and
                 (TMenuItem(Items.GetItem(I)).Visible) then
                inc(VisibleItemCount);
            if VisibleItemCount > 0 then
            begin
              LNewSubMenu := NewNsMenu(TMenuItem(AChildMenu.GetItem(J)).Text);
              CreateChildMenuItems(Items, LNewSubMenu);
              NSMenuItem(LNSSubMenuItem.Super).setSubmenu(LNewSubMenu);
            end;
          end;
          AParentMenu.addItem(NSMenuItem(LNSSubMenuItem.Super));
        end;
      end;
    end;
  finally
    AutoReleasePool.Release;
  end;
end;

procedure TPlatformCocoa.RemoveChildHandles(const AMenu: IItemsContainer);
var
  I: Integer;
  MenuItem: TMenuItem;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    for I := 0 to AMenu.GetItemsCount - 1 do
      if (AMenu.GetItem(I) is TMenuItem) then
      begin
        MenuItem := TMenuItem(AMenu.GetItem(I));
        RemoveChildHandles(MenuItem);
        DestroyMenuItem(MenuItem);
      end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.ClearNSHandles;
var I: integer;
begin
  for I := FNSHandles.Count - 1 downto 0 do
    DeleteHandle(FNSHandles[I]);
  FNSHandles.Clear;
end;

function TPlatformCocoa.NewNSMenu(const Text: string): NSMenu;
var LNSMenu: NSMenu;
    S: NSString;
    AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    inherited;
    LNSMenu := TNSMenu.Create;
    S := NSSTR(DelAmp(Text));
    Result := TNSMenu.Wrap(LNSMenu.initWithTitle(S));
    FNSHandles.Add(AllocHandle(Result));
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.CreateDefaultMenuItem;
var
  FMXAppName: string;
  LNSMenuItem, LQuitItem: NSMenuItem;
  LNewMenu: NSMenu;
  Key: Char;
  ModifierMask: NSUInteger;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    if Application.Title <> '' then
      FMXAppName := Application.Title
    else
      FMXAppName := GetTitle;
    FDefaultMenu := cmDefault;

    LNewMenu := NewNsMenu(FMXAppName);
    LNSMenuItem := TNSMenuItem.Create;
    LNSMenuItem := TNSMenuItem.Wrap(LNSMenuItem.initWithTitle(NSSTR(''), nil, NSSTR('')));
    LNSMenuItem.setSubmenu(LNewMenu);

    LQuitItem := TNSMenuItem.Create;
    ShortCutToMACKey(4177, Key, ModifierMask);
    LQuitItem := TNSMenuItem.Wrap(LQuitItem.initWithTitle(NSSTR(Format(SMenuAppQuit, [FMXAppName])),
      sel_getUid(MarshaledAString('terminate:')), NSSTR(Key)));
    LQuitItem.setKeyEquivalentModifierMask(ModifierMask);

    LNewMenu.addItem(LQuitItem);
    if not Assigned(FMenuBar) then
      CreateOSMenu(nil, nil);
    FMenuBar.insertItem(LNSMenuItem, 0);
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.CreateOSMenu(AForm: TCommonCustomForm;
  const AMenu: IItemsContainer);
var
  LNSMenuItem: NSMenuItem;
  LNewMenu: NSMenu;
  MenuItem: TOpenMenuItem;
  I, J, VisibleItemCount: Integer;
  AutoReleasePool: NSAutoreleasePool;
  Native: INativeControl;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    FMainMenu := NSApp.mainMenu;
    if FMainMenu = nil then
    begin
      FMainMenu := TNSMenu.Create;
      FMenuBar := TNSMenu.Wrap(FMainMenu.initWithTitle(NSSTR('')));
      NSApp.setMainMenu(FMainMenu);
    end;
    FMenuBar.removeAllItems;
    FMenuBar.setAutoenablesItems(False);
    ClearNSHandles;
    VisibleItemCount := 0;
    if Assigned(AMenu) then
    begin
      RemoveChildHandles(AMenu);
      if Supports(AMenu, INativeControl, Native) and Native.HandleSupported then
        for I := 0 to AMenu.GetItemsCount - 1 do
        if (AMenu.GetItem(I) is TMenuItem) and
           (TMenuItem(AMenu.GetItem(I)).Visible) then
          inc(VisibleItemCount);
    end;
    // TMainMenu items
    if VisibleItemCount > 0 then
    begin
      FDefaultMenu := cmMain;
      J := 0;
      for I := 0 to AMenu.GetItemsCount - 1 do
      if AMenu.GetItem(I) is TMenuItem then
      begin
        MenuItem := TOpenMenuItem(AMenu.GetItem(I));
        if MenuItem.Visible then
        begin
          LNewMenu := NewNSMenu(MenuItem.Text);
          LNSMenuItem := TNSMenuItem.Create;
          LNSMenuItem := TNSMenuItem.Wrap(LNSMenuItem.initWithTitle(NSSTR(''), nil, NSSTR('')));
          LNSMenuItem.setSubmenu(LNewMenu);

          if MenuItem.Enabled then
            LNSMenuItem.setEnabled(True)
          else
            LNSMenuItem.setEnabled(False);

          if MenuItem.IsChecked then
            LNSMenuItem.setState(NSOnState);

          if (MenuItem.Enabled) or (J = 0) then
          begin
            CreateChildMenuItems((MenuItem as IItemsContainer), LNewMenu);
            inc(J);
          end;
          MenuItem.Handle := AllocHandle(LNSMenuItem);
          FMenuBar.addItem(LNSMenuItem);
        end;
      end;
    end
    else
      CreateDefaultMenuItem;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.UpdateMenuBar;
begin
  if Assigned(FMenuBar) then
    FMenuBar.removeAllItems;
  CreateDefaultMenuItem;
end;

procedure TPlatformCocoa.UpdateMenuItem(const AItem: IItemsContainer; AChange: TMenuItemChanges);
var
  LMenuItem: TMenuItem;
  LHandle: TFmxHandle;
  LNativeMenuItem: TFMXOSMenuItem;
  LNSMenuItem: NSMenuItem;
  Key: Char;
  ModMask: NSUInteger;
  AutoReleasePool: NSAutoreleasePool;
  IObj: IObjectiveC;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    LMenuItem := AItem as TMenuItem;
    LHandle := (LMenuItem as INativeControl).Handle;
    if LHandle = 0 then Exit;
    IObj := PlatformCocoa.HandleToObjC(LHandle);
    if Assigned(IObj) then
    begin
      if IObj.QueryInterface(NSMenuItem, LNSMenuItem) <> S_OK then
      begin
        LNativeMenuItem := IObj as TFMXOSMenuItem;
        LNSMenuItem := LNativeMenuItem.Super as NSMenuItem;
      end;
      if TMenuItemChange.mcText in AChange then
        LNSMenuItem.setTitle(NSSTR(DelAmp(LMenuItem.Text)));
      if (TMenuItemChange.mcShortCut in AChange) then
      begin
        ShortCutToMACKey(LMenuItem.ShortCut, Key, ModMask);
        LNSMenuItem.setKeyEquivalent(NSSTR(Key));
      end;
      if TMenuItemChange.mcEnabled in AChange then
        LNSMenuItem.setEnabled(LMenuItem.Enabled);
      if TMenuItemChange.mcVisible in AChange then
        LNSMenuItem.setHidden(not LMenuItem.Visible);
      if TMenuItemChange.mcChecked in AChange then
      begin
        if LMenuItem.IsChecked then
          LNSMenuItem.setState(NSOnState)
        else
          LNSMenuItem.setState(NSOffState);
      end;
    end
    else
      raise EInvalidFmxHandle.CreateFMT(SInvalidFmxHandle, [HexDisplayPrefix, SizeOf(LHandle) * 2, LHandle]);
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.DestroyMenuItem(const AItem: IItemsContainer);
var
  P: TFmxObject;
  Native: INativeControl;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    if (not FInDestroyMenuItem) and
        Assigned(AItem) and
       (AItem.GetObject is TFmxObject) then
      P := AItem.GetObject
    else
      Exit;
    FInDestroyMenuItem := true;
    try
      if Assigned(P) and
        (Supports(P, INativeControl, Native)) and
        (Native.Handle <> 0) then
      begin
        DeleteHandle(Native.Handle);
        Native.Handle := 0;
      end;
    finally
      FInDestroyMenuItem := False;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.ValidateHandle(FmxHandle: TFmxHandle);
begin
  if (FmxHandle and $F <> 0) then
    raise EInvalidFmxHandle.CreateResFmt(@SInvalidFmxHandle, [HexDisplayPrefix, SizeOf(TFmxHandle) * 2, FmxHandle]);
end;

{ Drag and Drop ===============================================================}

function NSImageFromBitmap(const Bmp: TBitmap): NSImage;
var
  mem: TMemoryStream;
  Data: NSData;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    mem := TMemoryStream.Create;
    Bmp.SaveToStream(mem);
    Data := TNSData.Wrap(TNSData.OCClass.dataWithBytes(mem.Memory, mem.Size));
  //  Data := NSData.dataWithBytes_length(mem.Memory, mem.size);
    Result := TNSImage.Create;
    Result := TNSImage.Wrap(Result.initWithData(Data));
    mem.Free;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.BeginDragDrop(AForm: TCommonCustomForm; const Data: TDragObject;
  ABitmap: TBitmap);
var
  Img: NSImage;
  Loc: NSPoint;
  Pboard: NSPasteboard;
  PBoardTypes: NSArray;
  FMXPBoardTypePtr: Pointer;
  LocObj: ILocalObject;
  FMXWin: TFMXWindow;
  ViewPtr: Pointer;
  PboardPtr: Pointer;
  AutoReleasePool: NSAutoreleasePool;
  Offset: TPointF;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Img := NSImageFromBitmap(ABitmap);
    Pboard := TNSPasteboard.Wrap(TNSPasteboard.OCClass.pasteboardWithName(NSDragPboard));
    if Supports(NSFMXPBoardType, ILocalObject, LocObj) then
      FMXPBoardTypePtr := LocObj.GetObjectID
    else
      FMXPBoardTypePtr := nil;
    PBoardTypes := TNSArray.Wrap(TNSArray.OCClass.arrayWithObject(FMXPBoardTypePtr));

    if Supports(PBoard, ILocalObject, LocObj) then
      PboardPtr := LocObj.GetObjectID
    else
      PboardPtr := nil;
    Pboard.declareTypes(PBoardTypes, PboardPtr);
  {  if not VarIsObject(Data.Data) and VarIsStr(Data.Data) then
      pboard.setString_forType(NSStr(PChar(Utf8Encode(Data.Data))), NSStringPBoardtype);}
    GlobalData := Data;
    FMXWin := TFMXWindow(WindowHandleToPlatform(AForm.Handle).Handle);
    if FMXWin.LastEvent <> nil then
    begin
      loc := FMXWin.LastEvent.locationInWindow;

      if Data.Source is TControl then
         Offset := TControl(Data.Source).AbsoluteToLocal(AForm.ScreenToClient(GetMousePos))
      else
        Offset.SetLocation((ABitmap.Width div 2), ABitmap.Height div 2);
      Offset.X := -Offset.X;
      Offset.Y := Offset.Y - ABitmap.Height;

      if Supports(FMXWin.View, ILocalObject, LocObj) then
        ViewPtr := LocObj.GetObjectID
      else
        ViewPtr := nil;
      NSWindow(FMXWin.Super).dragImage(img, loc, NSSize(TPoint(Offset)), FMXWin.LastEvent, pboard, ViewPtr, True);
      FMXWin.LastEvent := nil;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.SetClientSize(const AForm: TCommonCustomForm; const ASize: TPointF);
var
  NSWin: NSWindow;
  OldFrame, Frame, R: NSRect;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    NSWin := WindowHandleToPlatform(AForm.Handle).Wnd;
    if NSWin.isVisible then
    begin
      OldFrame := NSWin.frame;
      R.origin := OldFrame.origin;
      R.size := NSSize(ASize);
      Frame := NSWin.frameRectForContentRect(R);
      Frame.origin.x := OldFrame.origin.x;
      Frame.origin.y := OldFrame.origin.y + OldFrame.size.height - Frame.size.height;
      NSWin.setFrame(Frame, True);
    end
    else
      NSWin.setContentSize(NSSize(ASize));
  finally
    AutoReleasePool.release;
  end;
end;

{ Clipboard ===============================================================}

procedure TPlatformCocoa.SetClipboard(Value: TValue);
var
  W: string;
  pb: NSPasteboard;
  types: NSArray;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    W := Value.ToString;
    pb := TNSPasteboard.Wrap(TNSPasteboard.OCClass.generalPasteboard);
    types := TNSArray.Wrap(TNSArray.OCClass.arrayWithObject((NSPasteboardTypeString as ILocalObject).GetObjectID));
    pb.declareTypes(types, (pb as ILocalObject).GetObjectID);
    pb.setString(NSSTR(W), NSPasteboardTypeString);
  finally
    AutoReleasePool.release;
  end;
end;

function TPlatformCocoa.GetClipboard: TValue;
var
  W: string;
  pb: NSPasteboard;
  str: NSString;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Result := TValue.Empty;
    pb := TNSPasteboard.Wrap(TNSPasteboard.OCClass.generalPasteboard);
    str := pb.stringForType(NSPasteboardTypeString);
    if str <> nil then
    begin
      W := UTF8ToString(str.UTF8String);
      Result := W;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.SetCursor(const ACursor: TCursor);
const
  SizeNWSECursor: array [0..192] of byte = (
    $89, $50, $4E, $47, $0D, $0A, $1A, $0A, $00, $00, $00, $0D, $49, $48, $44, $52, $00, $00, $00, $10, $00, $00, $00, $10, $08, $06, $00, $00, $00, $1F, $F3, $FF, $61, $00, $00, $00, $88, $49, $44, $41,
    $54, $78, $9C, $AC, $93, $4B, $0A, $C0, $20, $0C, $44, $45, $8A, $69, $D7, $5D, $7B, $00, $0F, $98, $EB, $6B, $15, $8C, $44, $F1, $1B, $3A, $20, $BA, $D0, $E7, $4C, $A2, $4A, $FD, $A1, $30, $D1, $36,
    $20, $4D, $69, $00, $40, $59, $8B, $00, $FC, $B0, $08, $60, $8C, $A9, $6E, $BF, $A2, $44, $0E, $08, $82, $88, $EA, $8D, $DA, $02, $78, $EF, $43, $0B, $63, $31, $EE, $29, $80, $67, $26, $88, $D6, $BA,
    $82, $58, $6B, $97, $69, $CA, $A6, $91, $93, $AD, $16, $3F, $51, $23, $48, $8A, $D9, $44, $EB, $8B, $AA, $3F, $2B, $F0, $3A, $4F, $16, $41, $A8, $C5, $47, $00, $96, $F7, $DC, $81, $73, $AE, $FB, $C8,
    $44, $0E, $C4, $1F, $6D, $A5, $0F, $00, $00, $FF, $FF, $03, $00, $FD, $DF, $FC, $72, $CD, $04, $2F, $27, $00, $00, $00, $00, $49, $45, $4E, $44, $AE, $42, $60, $82
  );
  SizeNESWCursor: array [0..211] of byte = (
    $89, $50, $4E, $47, $0D, $0A, $1A, $0A, $00, $00, $00, $0D, $49, $48, $44, $52, $00, $00, $00, $10, $00, $00, $00, $10, $08, $06, $00, $00, $00, $1F, $F3, $FF, $61, $00, $00, $00, $9B, $49, $44, $41,
    $54, $78, $9C, $9C, $93, $51, $0E, $C0, $10, $0C, $86, $3D, $88, $CC, $F3, $0E, $E3, $2A, $2E, $E2, $04, $6E, $E0, $C5, $5D, $DC, $4D, $4C, $93, $CD, $1A, $46, $AD, $7F, $D2, $14, $49, $3F, $D5, $96,
    $10, $0B, $95, $52, $48, $23, $55, $D6, $DA, $03, $80, $EB, $ED, $17, $20, $E7, $CC, $06, $1C, $29, $A5, $96, $85, $52, $AA, $79, $12, $A0, $AB, $62, $8C, $BC, $27, $9C, $55, $21, $84, $21, $18, $45,
    $CD, $01, $52, $4A, $E1, $9C, $FB, $0C, $F6, $DE, $F7, $5D, $79, $0B, $85, $4F, $26, $37, $C3, $42, $0E, $33, $70, $6F, $86, $14, $B7, $AB, $8D, $01, $5F, $85, $32, $C6, $C0, $42, $93, $00, $DC, $A2,
    $27, $D8, $5A, $0B, $DD, $58, $8F, $EC, $2C, $03, $18, $1E, $54, $13, $FE, $13, $B6, $01, $33, $ED, $02, $78, $5F, $B5, $EA, $02, $00, $00, $FF, $FF, $03, $00, $27, $CE, $7B, $C4, $F5, $A4, $B6, $D6,
    $00, $00, $00, $00, $49, $45, $4E, $44, $AE, $42, $60, $82
  );
  SizeAllCursor: array [0..174] of byte = (
    $89, $50, $4E, $47, $0D, $0A, $1A, $0A, $00, $00, $00, $0D, $49, $48, $44, $52, $00, $00, $00, $10, $00, $00, $00, $10, $08, $06, $00, $00, $00, $1F, $F3, $FF, $61, $00, $00, $00, $09, $70, $48, $59,
    $73, $00, $00, $0B, $13, $00, $00, $0B, $13, $01, $00, $9A, $9C, $18, $00, $00, $00, $61, $49, $44, $41, $54, $78, $9C, $AC, $53, $CB, $0A, $00, $20, $0C, $1A, $F4, $FF, $DF, $6C, $10, $74, $68, $0F,
    $17, $65, $E0, $A9, $74, $BA, $36, $03, $60, $04, $FB, $94, $6F, $28, $D9, $6C, $2C, $30, $91, $96, $DC, $89, $5C, $91, $99, $48, $95, $19, $49, $84, $E3, $2A, $13, $F0, $55, $B2, $CA, $C1, $49, $D5,
    $B0, $D2, $81, $17, $A5, $99, $3B, $04, $AB, $AF, $02, $DF, $11, $24, $4D, $94, $7C, $A3, $64, $90, $24, $A3, $2C, $59, $A6, $EB, $75, $9E, $00, $00, $00, $FF, $FF, $03, $00, $3A, $00, $A6, $5B, $CC,
    $0B, $A4, $58, $00, $00, $00, $00, $49, $45, $4E, $44, $AE, $42, $60, $82
  );
  WaitCursor: array [0..124] of byte = (
    $89, $50, $4E, $47, $0D, $0A, $1A, $0A, $00, $00, $00, $0D, $49, $48, $44, $52, $00, $00, $00, $10, $00, $00, $00, $10, $08, $06, $00, $00, $00, $1F, $F3, $FF, $61, $00, $00, $00, $44, $49, $44, $41,
    $54, $78, $9C, $62, $60, $C0, $0E, $FE, $E3, $C0, $44, $83, $21, $6E, $C0, $7F, $5C, $80, $18, $43, $70, $6A, $26, $D6, $10, $BA, $19, $80, $D3, $10, $6C, $0A, $C9, $33, $00, $59, $03, $45, $5E, $C0,
    $65, $00, $94, $4D, $5A, $38, $10, $B2, $1D, $C5, $10, $1C, $98, $68, $30, $84, $0C, $00, $00, $00, $00, $FF, $FF, $03, $00, $A9, $31, $25, $E9, $C0, $2C, $FB, $9B, $00, $00, $00, $00, $49, $45, $4E,
    $44, $AE, $42, $60, $82
  );
  HelpCursor: array [0..238] of byte = (
    $89, $50, $4E, $47, $0D, $0A, $1A, $0A, $00, $00, $00, $0D, $49, $48, $44, $52, $00, $00, $00, $12, $00, $00, $00, $12, $08, $06, $00, $00, $00, $56, $CE, $8E, $57, $00, $00, $00, $B6, $49, $44, $41,
    $54, $78, $9C, $A4, $94, $3B, $12, $80, $20, $0C, $44, $69, $6C, $6D, $6C, $BC, $83, $8D, $B5, $F7, $E0, $FE, $37, $01, $89, $93, $8C, $61, $F9, $18, $21, $33, $19, $15, $C9, $73, $B3, $46, $9D, $83,
    $88, $31, $52, $36, $03, $F7, $17, $C5, $1A, $E2, $BD, $0F, $74, $89, $49, $EB, $9F, $30, $06, $05, $81, $70, $51, $D0, $6B, $66, $18, $15, $49, $01, $9F, $9F, $29, $77, $BD, $CE, $F7, $E8, $B8, $98,
    $40, $1A, $D6, $00, $ED, $05, $4C, $79, $94, $B5, $C1, $80, $0B, $40, $D2, $1A, $A9, $5D, $BB, $AA, $30, $1B, $1E, $5D, $29, $B7, $AE, $57, $FC, $A4, $23, $ED, $CF, $D4, $00, $A4, $AF, $08, $D5, $C1,
    $5B, $FC, $0F, $11, $D0, $34, $44, $83, $A6, $20, $4E, $08, $EF, $A7, $61, $32, $B7, $0A, $A9, $F8, $53, $CE, $8E, $05, $E4, $CA, $21, $1C, $F2, $A7, $A6, $68, $BC, $3D, $F0, $28, $53, $64, $F9, $11,
    $48, $3C, $83, $59, $83, $FC, $8D, $85, $8B, $B7, $2F, $C8, $0D, $00, $00, $FF, $FF, $03, $00, $A5, $D1, $28, $C9, $B0, $25, $E3, $01, $00, $00, $00, $00, $49, $45, $4E, $44, $AE, $42, $60, $82
  );
var
  C: NSCursor;
  Image: NSImage;
  Data: NSData;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    case ACursor of
      crCross: C := TNSCursor.Wrap(TNSCursor.OCClass.crosshairCursor);
      crArrow, crDefault: C := TNSCursor.Wrap(TNSCursor.OCClass.arrowCursor);
      crIBeam: C := TNSCursor.Wrap(TNSCursor.OCClass.IBeamCursor);
      crSizeNS: C := TNSCursor.Wrap(TNSCursor.OCClass.resizeUpDownCursor);
      crSizeWE: C := TNSCursor.Wrap(TNSCursor.OCClass.resizeLeftRightCursor);
      crUpArrow: C := TNSCursor.Wrap(TNSCursor.OCClass.resizeUpCursor);
      crDrag, crMultiDrag:  C := TNSCursor.Wrap(TNSCursor.OCClass.dragCopyCursor);
      crHSplit: C := TNSCursor.Wrap(TNSCursor.OCClass.resizeLeftRightCursor);
      crVSplit: C := TNSCursor.Wrap(TNSCursor.OCClass.resizeUpDownCursor);
      crNoDrop, crNo: C := TNSCursor.Wrap(TNSCursor.OCClass.operationNotAllowedCursor);
      crHandPoint: C := TNSCursor.Wrap(TNSCursor.OCClass.pointingHandCursor);
      crAppStart, crSQLWait, crHourGlass:
        begin
          Data := TNSData.Wrap(TNSData.Create.initWithBytes(@WaitCursor[0], Length(WaitCursor)));
          Image := TNSImage.Wrap(TNSImage.Create.initWithData(Data));
          C := TNSCursor.Wrap(TNSCursor.Create.initWithImage(Image, NSPoint(PointF(10, 10))));
        end;
      crHelp:
        begin
          Data := TNSData.Wrap(TNSData.Create.initWithBytes(@HelpCursor[0], Length(HelpCursor)));
          Image := TNSImage.Wrap(TNSImage.Create.initWithData(Data));
          C := TNSCursor.Wrap(TNSCursor.Create.initWithImage(Image, NSPoint(PointF(10, 10))));
        end;
      crSizeNWSE:
        begin
          Data := TNSData.Wrap(TNSData.Create.initWithBytes(@SizeNWSECursor[0], Length(SizeNWSECursor)));
          Image := TNSImage.Wrap(TNSImage.Create.initWithData(Data));
          C := TNSCursor.Wrap(TNSCursor.Create.initWithImage(Image, NSPoint(PointF(10, 10))));
        end;
      crSizeNESW:
        begin
          Data := TNSData.Wrap(TNSData.Create.initWithBytes(@SizeNESWCursor[0], Length(SizeNESWCursor)));
          Image := TNSImage.Wrap(TNSImage.Create.initWithData(Data));
          C := TNSCursor.Wrap(TNSCursor.Create.initWithImage(Image, NSPoint(PointF(10, 10))));
        end;
      crSizeAll:
        begin
          Data := TNSData.Wrap(TNSData.Create.initWithBytes(@SizeAllCursor[0], Length(SizeAllCursor)));
          Image := TNSImage.Wrap(TNSImage.Create.initWithData(Data));
          C := TNSCursor.Wrap(TNSCursor.Create.initWithImage(Image, NSPoint(PointF(10, 10))));
        end;
    else
      C := TNSCursor.Wrap(TNSCursor.OCClass.arrowCursor);
    end;
    if ACursor = crNone then
      TNSCursor.OCClass.setHiddenUntilMouseMoves(True)
    else
    begin
      TNSCursor.OCClass.setHiddenUntilMouseMoves(False);
      C.push;
    end;
    FCursor := ACursor;
  finally
    AutoReleasePool.release;
  end;
end;

function TPlatformCocoa.GetCursor: TCursor;
begin
  Result := FCursor;
end;

procedure TPlatformCocoa.SetFullScreen(const AForm: TCommonCustomForm;
  const AValue: Boolean);
var
  NSWin: NSWindow;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    NSWin := WindowHandleToPlatform(AForm.Handle).Wnd;
    if not (AValue = ((NSWin.styleMask and NSFullScreenWindowMask) > 0)) then
      NSWin.toggleFullScreen(nil);
  finally
    AutoReleasePool.release;
  end;
end;

{ Mouse  ===============================================================}

function TPlatformCocoa.GetMousePos: TPointF;
var
  P: NSPoint;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    P := TNSEvent.OCClass.mouseLocation;
    Result := TPointF.Create(P.x, P.y);
    Result.y := TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size.height - Result.y;
  finally
    AutoReleasePool.release;
  end;
end;

function TPlatformCocoa.GetScreenSize: TPointF;
begin
  Result := TPointF(TNSScreen.Wrap(TNSScreen.OCClass.mainScreen).frame.size)
end;

function TPlatformCocoa.GetScreenScale: Single;
begin
  Result := 1.0;
end;

function TPlatformCocoa.GetScreenOrientation: TScreenOrientation;
begin
  Result := TScreenOrientation.soLandscape;
end;

{ IFMXSystemInformationService }

function TPlatformCocoa.GetScrollingBehaviour: TScrollingBehaviours;
begin
  Result := [TScrollingBehaviour.sbBoundsAnimation, TScrollingBehaviour.sbAutoShowing];
end;

function TPlatformCocoa.GetMinScrollThumbSize: Single;
begin
  Result := 25;
end;

{ IFMXStyleService }

function TPlatformCocoa.GetSystemStyle: TFmxObject;
begin
  Result := FMX.Controls.Mac.GetSystemStyle;
end;

{ IFMXHiResStyleService }

function TPlatformCocoa.GetSystemStyleHiRes: TFmxObject;
begin
  Result := FMX.Controls.Mac.GetSystemStyleHiRes;
end;

{ IFMXScreenService }

{ International ===============================================================}

function TPlatformCocoa.GetCurrentLangID: string;
begin
  Result := UTF8ToString(TNSLocale.Wrap(TNSLocale.OCClass.currentLocale).localeIdentifier.UTF8String);
  if Length(Result) > 2 then
    Delete(Result, 3, MaxInt);
end;

function TPlatformCocoa.GetDefaultFontFamilyName: String;
begin
  Result := 'Helvetica';
end;

function TPlatformCocoa.GetFullScreen(const AForm: TCommonCustomForm): Boolean;
var
  NSWin: NSWindow;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    NSWin := WindowHandleToPlatform(AForm.Handle).Wnd;
    Result := (NSWin.styleMask and NSFullScreenWindowMask) > 0;
  finally
    AutoReleasePool.release;
  end;
end;

function TPlatformCocoa.GetLocaleFirstDayOfWeek: string;
var
  cal: NSCalendar;
  firstDay: NSUInteger;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    cal:= TNSCalendar.Wrap(TNSCalendar.OCClass.currentCalendar);
    firstDay:= Cal.firstWeekday;
    Result:= IntToStr(firstDay);
  finally
    AutoReleasePool.release;
  end;
end;


{ Dialogs ===============================================================}

function TPlatformCocoa.DialogOpenFiles(var AFileName: TFileName; const AInitDir, ADefaultExt, AFilter, ATitle: string;
  var AFilterIndex: Integer; var AFiles: TStrings; var AOptions: TOpenOptions): Boolean;
var
  OpenFile: NSOpenPanel;
  DefaultExt: string;
  Filter: NSArray;
  InitialDir: NSURL;
  outcome: NSInteger;
  I: Integer;

  function AllocFilterStr(const S: string; var Filter: NSArray): Boolean;
  var
    input, pattern: string;
    FileTypes: array of string;
    outcome, aux: TArray<string>;
    i, j: Integer;
    FileTypesNS: array of Pointer;
    NStr: NSString;
    LocObj: ILocalObject;
  begin
    // First, split the string by using '|' as a separator
    Result := false;
    input := S;
    pattern := '\|';

    outcome := TRegEx.Split(input, pattern);

    pattern := '\*\.';
    SetLength(FileTypes, 0);

    for i := 0 to length(outcome) - 1 do
    begin
      if Odd(i) then
        if outcome[i] <> '*.*' then
          if AnsiLeftStr(outcome[i], 2) = '*.' then
          begin
            aux := TRegEx.Split(outcome[i], pattern);
            for j := 0 to length(aux) - 1 do
            begin
              aux[j] := Trim(aux[j]);
              if aux[j] <> '' then
              begin
                if AnsiEndsStr(';', aux[j]) then
                  aux[j] := AnsiLeftStr(aux[j], length(aux[j]) - 1);
                SetLength(FileTypes, length(FileTypes) + 1);
                FileTypes[length(FileTypes) - 1] := aux[j];
              end;
            end;
          end;
    end;

    // create the NSArray from the FileTypes array
    SetLength(FileTypesNS, length(FileTypes));
    for i := 0 to length(FileTypes) - 1 do
    begin
      NStr := NSSTR(FileTypes[i]);
      if Supports(NStr, ILocalObject, LocObj) then
        FileTypesNS[i] := LocObj.GetObjectID;
    end;
    if length(FileTypes) > 0 then begin
      Filter := TNSArray.Wrap(TNSArray.OCClass.arrayWithObjects(@FileTypesNS[0], length(FileTypes)));
      result := true;
    end;
  end;

begin
  Result := False;
  DefaultExt := ADefaultExt;

  OpenFile := TNSOpenPanel.Wrap(TNSOpenPanel.OCClass.openPanel);

  OpenFile.setAllowsMultipleSelection(TOpenOption.ofAllowMultiSelect in AOptions);
  OpenFile.setCanChooseFiles(True);
  OpenFile.setCanChooseDirectories(True);

  AFiles.Clear;

  if AInitDir <> '' then
  begin
    InitialDir := TNSURL.Create;
    InitialDir.initFileURLWithPath(NSSTR(AInitDir));
    OpenFile.setDirectoryURL(InitialDir);
  end;

  if AFileName <> '' then
  begin
    OpenFile.setNameFieldStringValue(NSSTR(AFileName));
  end;

  if AFilter <> '' then
  begin
    if AllocFilterStr(AFilter, Filter) then
      OpenFile.setAllowedFileTypes(Filter);
  end;

  if ATitle <> '' then
    OpenFile.setTitle(NSSTR(ATitle));

  OpenFile.retain;
  try
    outcome := OpenFile.runModal;
    if (FModalStack <> nil) and (FModalStack.Count > 0) then
      FRestartModal := True;
    if outcome = NSOKButton then
    begin
      for I := 0 to OpenFile.URLs.count - 1 do
        AFiles.Add(UTF8ToString(TNSUrl.Wrap(OpenFile.URLs.objectAtIndex(I)).relativePath.UTF8String));

      if AFiles.Count > 0 then
        AFileName := AFiles[0];

      if DefaultExt <> '' then
        if ExtractFileExt(AFileName) = '' then
          ChangeFileExt(AFileName, DefaultExt);
      Result := True;
    end;
  finally
    OpenFile.release;
  end;
end;

function TPlatformCocoa.DialogPrint(var ACollate, APrintToFile: Boolean;
      var AFromPage, AToPage, ACopies: Integer; AMinPage, AMaxPage: Integer; var APrintRange: TPrintRange;
      AOptions: TPrintDialogOptions): Boolean;
var
  printPanel: NSPrintPanel;
  printInfo: NSPrintInfo;
  outcome : NSInteger;
  dict: NSMutableDictionary;
begin
  Result := False;

  printInfo := TNSPrintInfo.Wrap(TNSPrintInfo.OCClass.sharedPrintInfo);
  printPanel := TNSPrintPanel.Wrap(TNSPrintPanel.OCClass.printPanel);
  dict := printInfo.dictionary;

  dict.setValue(TNSNumber.OCClass.numberWithBool(ACollate), NSPrintMustCollate);
  dict.setValue(TNSNumber.OCClass.numberWithInt(AFromPage), NSPrintFirstpage);
  dict.setValue(TNSNumber.OCClass.numberWithInt(AToPage), NSPrintLastPage);
  dict.setValue(TNSNumber.OCClass.numberWithInt(ACopies), NSPrintCopies);
  if APrintrange = TPrintRange.prAllPages then
    dict.setValue(TNSNumber.OCClass.numberWithBool(True), NSPrintAllPages);
  if TPrintDialogOption.poPrintToFile in AOptions then
   printInfo.setJobDisposition(NSPrintSaveJob);

  printPanel.retain;
  try
    outcome := printPanel.runModalWithPrintInfo(printInfo);
    if outcome = NSOKButton then
    begin
      ACollate := TNSNumber.Wrap(printInfo.dictionary.valueForKey(NSPrintMustCollate)).boolValue();
      ACopies := TNSNumber.Wrap(printInfo.dictionary.valueForKey(NSPrintCopies)).integerValue();
      if printInfo.jobDisposition = NSPrintSaveJob then
        APrintToFile := True;
      if TNSNumber.Wrap(printInfo.dictionary.valueForKey(NSPrintAllPages)).boolValue() = True then
        APrintRange := TPrintRange.prAllPages
      else
      begin
        APrintRange := TPrintRange.prPageNums;
        AFromPage := TNSNumber.Wrap(printInfo.dictionary.valueForKey(NSPrintFirstpage)).integerValue();
        AToPage := TNSNumber.Wrap(printInfo.dictionary.valueForKey(NSPrintLastPage)).integerValue();
      end;
      Result := True;
    end;
  finally
    printPanel.release;
  end;
end;

function TPlatformCocoa.PageSetupGetDefaults(var AMargin, AMinMargin: TRect; var APaperSize: TPointF; AUnits: TPageMeasureUnits; AOptions: TPageSetupDialogOptions): Boolean;
begin
  Result := False;
end;

function TPlatformCocoa.DialogPageSetup(var AMargin, AMinMargin :TRect; var APaperSize: TPointF;
  var AUnits: TPageMeasureUnits; AOptions: TPageSetupDialogOptions): Boolean;
const
  POINTS_PER_INCHES = 72;
  MM_PER_INCH = 25.4;
var
  pageSetup: NSPageLayout;
  printInfo: NSPrintInfo;
  outcome: Integer;
  newSize: TPointF;

  function ToPoints(Value: Single): Single;
  begin
    Result := Value /1000;
    Result := Result * POINTS_PER_INCHES;
    if AUnits = TPageMeasureUnits.pmMillimeters then
    begin
      Result := Result / MM_PER_INCH;
    end;
  end;

  function FromPoints(Value: Single): Single;
  begin
    Result := Value * 1000;
    Result := Result / POINTS_PER_INCHES;
    if AUnits = TPageMeasureUnits.pmMillimeters then
    begin
      Result := Result * MM_PER_INCH;
    end;
  end;

begin
  Result := False;
  printInfo := TNSPrintInfo.Wrap(TNSPrintInfo.OCClass.sharedPrintInfo);
  pageSetup := TNSPageLayout.Wrap(TNSPageLayout.OCClass.pageLayout);

  //Calculate paper size for MAC side
  newSize.X := ToPoints(APaperSize.X);
  newSize.y := ToPoints(APaperSize.y);
  printInfo.setPaperSize(NSSize(newSize));

  //If psoMargins is set, use the margins specified by the user,
  //else, let the panel use the defaults.
  if TPageSetupDialogOption.psoMargins in AOptions then
  begin
    printInfo.setLeftMargin(ToPoints(AMargin.Left));
    printInfo.setTopMargin(ToPoints(AMargin.Top));
    printInfo.setRightMargin(ToPoints(AMargin.Right));
    printInfo.setBottomMargin(ToPoints(AMargin.Bottom));
  end;

  printInfo.setHorizontallyCentered(False);
  printInfo.setVerticallyCentered(False);

  pageSetup.retain;
  try
    outcome := pageSetup.runModalWithPrintInfo(printInfo);
    if outcome = NSOKButton then
    begin
      APaperSize := TPointF(printInfo.paperSize);
      //transfrom from points into inches
      APaperSize.X := FromPoints(APaperSize.X);
      APaperSize.y := FromPoints(APaperSize.Y);

      // Set the margins to the values from the dialog.
      AMargin.Left := round(FromPoints(printInfo.LeftMargin));
      AMargin.Top := round(FromPoints(printInfo.TopMargin));
      AMargin.Right := round(FromPoints(printInfo.RightMargin));
      AMargin.Bottom := round(FromPoints(printInfo.BottomMargin));

      //if psoMinMargins is set in options, then adjust the margins to fit
      if TPageSetupDialogOption.psoMinMargins in AOptions then
      begin
        if AMargin.Left < AMinMargin.Left then
          AMargin.Left := AMinMargin.Left;
        if AMargin.Top < AMinMargin.Top then
          AMargin.Top := AMinMargin.Top;
        if AMargin.Right < AMinMargin.Right then
          AMargin.Right := AMinMargin.Right;
        if AMargin.Bottom < AMinMargin.Bottom then
          AMargin.Bottom := AMinMargin.Bottom;
      end;
      //SetPrinter(hDevMode, hDevNames)
      Result := True;
    end;
  finally
    pageSetup.release;
  end;
end;

function TPlatformCocoa.DialogPrinterSetup: Boolean;
begin
  Result := False;
end;

function TPlatformCocoa.DialogSaveFiles(var AFileName: TFileName; const AInitDir, ADefaultExt, AFilter, ATitle: string;
  var AFilterIndex: Integer; var AFiles: TStrings; var AOptions: TOpenOptions): Boolean;
var
  SaveFile: NSSavePanel;
  DefaultExt: string;
  Filter: NSArray;
  InitialDir: NSURL;
  outcome : NSInteger;

  function AllocFilterStr(const S: string; var Filter: NSArray): Boolean;
  var
    input, pattern: string;
    FileTypes: array of string;
    outcome, aux: TArray<string>;
    i, j: Integer;
    FileTypesNS: array of Pointer;
    NStr: NSString;
    LocObj: ILocalObject;
  begin
    Result := false;
    // First, split the string by using '|' as a separator
    input := S;
    pattern := '\|';

    outcome := TRegEx.Split(input, pattern);

    pattern := '\*\.';
    SetLength(FileTypes, 0);

    for i := 0 to length(outcome) - 1 do
    begin
      if Odd(i) then
        if outcome[i] <> '*.*' then
          if AnsiLeftStr(outcome[i], 2) = '*.' then
          begin
            // Split the string by using '*.' as a separator
            aux := TRegEx.Split(outcome[i], pattern);
            for j := 0 to length(aux) - 1 do
            begin
              aux[j] := Trim(aux[j]);
              if aux[j] <> '' then
              begin
                //Remove the ';' if necessary
                if AnsiEndsStr(';', aux[j]) then
                  aux[j] := AnsiLeftStr(aux[j], length(aux[j]) - 1);
                SetLength(FileTypes, length(FileTypes) + 1);
                FileTypes[length(FileTypes) - 1] := aux[j];
              end;
            end;
          end;
    end;

    // create the NSArray from the FileTypes array
    SetLength(FileTypesNS, Length(FileTypes));
    for i := 0 to Length(FileTypes) - 1 do
    begin
      NStr := NSSTR(FileTypes[i]);
      if Supports(NStr, ILocalObject, LocObj) then
        FileTypesNS[i] := LocObj.GetObjectID;
    end;
    if length(FileTypes) > 0 then begin
      Filter := TNSArray.Wrap(TNSArray.OCClass.arrayWithObjects(@FileTypesNS[0], Length(FileTypes)));
      Result := true;
    end;
  end;

begin
  Result := False;

  //SaveFile := TNSSavePanel.Create;
  SaveFile := TNSSavePanel.Wrap(TNSSavePanel.OCClass.savePanel);

  if AInitDir <> '' then
  begin
    InitialDir := TNSURL.Create;
    InitialDir.initFileURLWithPath(NSSTR(AInitDir));
    SaveFile.setDirectoryURL(InitialDir);
  end;

  if AFileName <> '' then
  begin
    SaveFile.setNameFieldStringValue(NSSTR(AFileName));
  end;

  if AFilter <> '' then
  begin
    if AllocFilterStr(AFilter, Filter) then
      SaveFile.setAllowedFileTypes(Filter);
  end;

  if ATitle <> '' then
    SaveFile.setTitle(NSSTR(ATitle));

  SaveFile.retain;
  try
    outcome := SaveFile.runModal;
    if (FModalStack <> nil) and (FModalStack.Count > 0) then
      FRestartModal := True;
    if outcome = NSOKButton then
    begin
      AFileName := UTF8ToString(SaveFile.URL.relativePath.UTF8String);
      if DefaultExt <> '' then
        if ExtractFileExt(AFileName) = '' then
          ChangeFileExt(AFileName, DefaultExt);
      Result := True;
    end;
  finally
    SaveFile.release;
  end;
end;

procedure TPlatformCocoa.DeleteHandle(FmxHandle: TFmxHandle);
var IObj: IObjectiveC;
    Item: NSMenuItem;
    Menu: NSMenu;
    AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    ValidateHandle(FmxHandle);
    TMonitor.Enter(FObjectiveCMap);
    try
      if FObjectiveCMap.TryGetValue(FmxHandle, IObj) then
      begin
        if IObj.QueryInterface(NSMenuItem, Item) = 0 then
        begin
          Item.release;
          Item := nil;
        end;
        if IObj.QueryInterface(NSMenu, Menu) = 0 then
        begin
          Menu.release;
          Menu := nil;
        end;
        FObjectiveCMap.Remove(FmxHandle);
        IObj := nil;
      end;
    finally
      TMonitor.Exit(FObjectiveCMap);
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TPlatformCocoa.Log(Fmt: String; Params: array of const);
begin
  WriteLn(Format(Fmt, Params));
end;


{ TFMXPanelWindow }

function TFMXPanelWindow.canBecomeMainWindow: Boolean;
begin
  Result := False;
end;

function TFMXPanelWindow.GetObjectiveCClass: PTypeInfo;
begin
    Result := TypeInfo(FMXPanelWindow);
end;

{ TMacWindowHandle }

function WindowHandleToPlatform(const AHandle: TWindowHandle): TMacWindowHandle;
begin
  Result := TMacWindowHandle(AHandle);
end;

constructor TMacWindowHandle.Create(const AHandle: TOCLocal);
begin
  inherited Create;
  FHandle := AHandle;
  if not Assigned(FWindowHandles) then
    FWindowHandles := TList<TMacWindowHandle>.Create;
  FWindowHandles.Add(Self);
end;

destructor TMacWindowHandle.Destroy;
begin
  FWindowHandles.Remove(Self);
  if FWindowHandles.Count = 0 then
    FreeAndNil(FWindowHandles);
  FreeBuffer;
  TFMXWindow(FHandle).DisposeOf;
  inherited;
end;

function TMacWindowHandle.GetForm: TCommonCustomForm;
begin
  Result := TFMXWindow(FHandle).Wnd;
end;

function TMacWindowHandle.GetGLView: NSOpenGLView;
begin
  Result := NSOpenGLView(TFMXWindow(FHandle).View);
end;

function TMacWindowHandle.GetView: NSView;
begin
  Result := TFMXWindow(FHandle).View;
end;

function TMacWindowHandle.GetWindow: NSWindow;
begin
  Result := NSWindow(TFMXWindow(FHandle).Super);
end;

procedure TMacWindowHandle.CreateBuffer;
var
  ColorSpace: CGColorSpaceRef;
begin
  FBufferSize := TSize.Create(Form.Width, Form.Height);
  GetMem(FBits, FBufferSize.Width * FBufferSize.Height * 4);
  ColorSpace := CGColorSpaceCreateDeviceRGB;
  FBuffer := CGBitmapContextCreate(FBits, FBufferSize.Width, FBufferSize.Height, 8, FBufferSize.Width * 4, ColorSpace, kCGImageAlphaPremultipliedLast);
  CGColorSpaceRelease(ColorSpace);
end;

procedure TMacWindowHandle.FreeBuffer;
begin
  if Assigned(FBits) then
  begin
    CGContextRelease(FBuffer);
    FreeMem(FBits);
    FBits := nil;
    FBufferSize := TSize.Create(0, 0);
  end;
end;

procedure TMacWindowHandle.UpdateLayer(const Ctx: CGContextRef);
var
  Img: CGImageRef;
  R: CGRect;
  ContextObject: IContextObject;
begin
  if Supports(Form, IContextObject, ContextObject) and Assigned(ContextObject.Context) then
  begin
    if not Assigned(FBits) then
      CreateBuffer
    else if (FBufferSize.Width <> Form.Width) or (FBufferSize.Height <> Form.Height) then
    begin
      FreeBuffer;
      CreateBuffer;
    end;
    { Copy from Context }
    ContextObject.Context.CopyToBits(FBits, FBufferSize.Width * 4, Rect(0, 0, FBufferSize.Width, FBufferSize.Height));
    { Draw }
    R.origin.x := 0;
    R.origin.y := 0;
    R.size.width := FBufferSize.Width;
    R.size.height := FBufferSize.Height;
    CGContextClearRect(Ctx, R);
    Img := CGBitmapContextCreateImage(FBuffer);
    CGContextDrawImage(Ctx, R, Img);
    CGImageRelease(Img);
  end;
end;

class function TMacWindowHandle.FindForm(const window: NSWindow): TCommonCustomForm;
var
  I: Integer;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Result := nil;
    if Assigned(FWindowHandles) then
      for I := 0 to FWindowHandles.Count - 1 do
      begin
        if FWindowHandles[I].Wnd.windowRef = window.windowRef then
        begin
          Result := FWindowHandles[I].Form;
          Break;
        end;
      end;
  finally
    AutoReleasePool.release;
  end;
end;

end.
