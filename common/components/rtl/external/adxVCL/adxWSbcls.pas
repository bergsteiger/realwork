{*********************************************************************}
{*                                                                   *}
{*             Add-In Express Component Library                      *}
{*                Add-in Express 2010 for VCL                        *}
{*                                                                   *}
{*             Copyright (C) Add-in Express Ltd.                     *}
{*             ALL RIGHTS RESERVED                                   *}
{*                                                                   *}
{*   The entire contents of this file is protected by U.S. and       *}
{*   International Copyright Laws. Unauthorized reproduction,        *}
{*   reverse-engineering, and distribution of all or any portion of  *}
{*   the code contained in this file is strictly prohibited and may  *}
{*   result in severe civil and criminal penalties and will be       *}
{*   prosecuted to the maximum extent possible under the law.        *}
{*                                                                   *}
{*   RESTRICTIONS                                                    *}
{*                                                                   *}
{*   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES ARE       *}
{*   CONFIDENTIAL AND PROPRIETARY TRADE SECRETS OF ADD-IN EXPRESS    *}
{*   LTD.                                                            *}
{*   THE REGISTERED DEVELOPER IS LICENSED TO DISTRIBUTE              *}
{*   THE ADX Extensions VCL for Microsoft Outlook                    *}
{*   AND ALL ACCOMPANYING VCL COMPONENTS AS PART OF                  *}
{*   AN EXECUTABLE PROGRAM ONLY.                                     *}
{*                                                                   *}
{*   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      *}
{*   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        *}
{*   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       *}
{*   AVAILABLE TO OTHER INDIVIDUALS WITHOUT WRITTEN CONSENT          *}
{*   AND PERMISSION FROM ADD-IN EXPRESS LTD.                         *}
{*                                                                   *}
{*   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       *}
{*   ADDITIONAL RESTRICTIONS.                                        *}
{*                                                                   *}
{*********************************************************************}

unit adxWSbcls;

{$I adxolDefs.inc}
{$DEFINE HideWithoutCheckVisibility}
//{$DEFINE ADX_DEBUG}
{$DEFINE SupportAdjacentWindow}
{$DEFINE SUBSTINSPECTORREGION}

interface

uses
  SysUtils, Classes, Forms, StdCtrls,
  {$IFNDEF ADX_VCL5} Variants, Types, {$ENDIF}
  {$IFDEF  ADX_VCL5} FileCtrl, {$ENDIF}
  Windows, Messages, adxGdiPAPI, Graphics, Controls, Menus, Math, ActiveX, Dialogs,
  OLEServer, COMObj, adxCore, ExtCtrls;

const
  ADXCAPTION_SIZE = 60;
  //adxWindowItemType
  stOlUnknown = 0;
  stOlFolderList = 1;     //2000, 2002
  stOlOutlookBar = 2;     //2000, 2002
  stOlNavigationPane = 3; //2003, 2007
  stOlMail = 4;
  stOlAppointment = 5;
  stOlContact = 6;
  stOlJournal = 7;
  stOlNote = 8;
  stOlTask = 9;
  stOlReadingPane = 10;
  stOlReadingPaneHeader = 101;
  stOlTodoBar = 11;
  stOlMailInspector = 12;
  stOlDefaultInspector = 100;
  stOlWordMailInspector = 13;
  stOlEnvelopeCommandBarForWordInspectorPreviwControl = 28;
  stOlAppointmentInspector = 14;
  stOlTaskInspector = 15;
  stOlContactInspector = 16;
  stOlDistributionListInspector = 33;
  stOlJournalInspector = 17;
  stOlWebViewPane = 18;
  stOlReportInspector = 19;
  stOlMeetingInspector = 32;
  stOlSharingInspector = 34;
  stOlMobileInspector = 35;
  stXlMain = 20;
  stXLSheet = 21;
  stOeMail = 22;
  stOeContacts = 23;
  stOeFolderList = 24;
  stOePreviewPane = 25;
  stOeMessageView = 26;
  stOeMailInspector = 27;
  stOeOutlookBar = 30;
  stWDMain = 40;
  stWDDocument = 41;
  stPPMain = 50;
  stPPDocument = 51;
  stOfficeTaskPane = 110;

  //Adx Command ID
  adxUnknown = 0;
  adxEmulateTab = 11;
  adxEmulateKeyMessage = 22;
  adxShortCut = 33;
  adxSetFocus = 44;
  adxFormLeave = 55;
  adxKeyFilter = 66;
  adxHotKey = 77;
  adxAuditWindowParam = 88;
  adxMenuActive = 99;
  adxFormFocused = 111;
  adxPostMessageCmd = 122;
  adxHideForm = 133;
  adxFormActivate = 144;
  adxSetChildMode = 155;
  adxBlinking = 166;
  adxActivateClientLayout = 177;
  adxExistCompleteRegion = 188;
  adxActivateCompleteReplacement = 199;

  //adxHost Version
  vUnknown =  0;
  v2000 =     1;
  v2002 =     2;
  v2003 =     3;
  v2007 =     4;
  v2010 =    14;
  vOE6  =   106;
  vOEVista= 107;

  //adxWindowLayout
  wlLeft        = $0001;
  wlRight       = $0002;
  wlTop         = $0004;
  wlBottom      = $0008;
  wlClient      = $0010;
  wlDockLeft    = $0100;
  wlDockRight   = $0200;
  wlDockTop     = $0400;
  wlDockBottom  = $0800;

  //adxRefreshKind
  rfPicture     = $0100;
  rfCaption     = $0200;
  rfLighReset   = $0400;

  //adxDragWindowLayout
  dwlUnknown  = $00;
  dwlLeft     = $01;
  dwlRight    = $02;
  dwlTop      = $04;
  dwlBottom   = $08;
  dwlClient   = $10;
  dwlAll      = dwlRight or dwlLeft or dwlTop or dwlBottom or dwlClient;

  reDesignVersion = 2;

  //Transaction
  trANY = 0;
  trRefreshInspectorTab = 1;
  trHookTransaction = 2;

  //adxFormContainnerControlType
  csComboBox = 0;
  csTabControl = 1;

  //adxForm Border Width
  BorderSize = 1;

  //adxTaskPane
  HeaderHeightDefault = 26;
  HeaderHeight2000    = 19;  //Height TaskPane for Office 2000
  HeaderHeight2000Minimize = 20;
  HeaderHeightXP      = HeaderHeightDefault;  //Height TaskPane for Office XP
  HeaderHeight2007    = 19;
  HeaderHeightOEVista = 23;  //Height TaskPane for Vista OE
  BorderWidthFloatingDefault = 6;
  BorderWidthFloatingSimple = 4;

  DefaultTaskButtonHeight = 17;
  DefaultTaskButtonWidth  = 17;
  DefaultTaskButtonOffset = 4;
  DefaultTaskButtonInterval = 1;
  DefaultTaskItemHeight = 20;
  DefaultIconWidth = 16;
  DefaultIconHeight = 16;
  DefaultMenuItemHeight = 22;
  DefaultTaskSeparator = 2;

  DefaultBlinkInterval = 300;
  DefaultBlinkPeriod = 5; //2500;

  themelib = 'uxtheme.dll'; //Themes XP Library

  WM_THEMECHANGED = $031A;

  //TadxFrameStyle
  adxfsSolid  = 1;
  adxfsConvex = 2;

  //Arrangement Window in One Subpane
  OlVTotal    = 10;
  OlHTotal    = 11;
  OrderLayout = olHTotal;

  //ColorConvert
  HLSMAX = 240;
  RGBMAX = 255;
  UNDEFINED = (HLSMAX* 2) div 3;

  //Visible State
  vsUnknown   = -1;
  vsUnvisible =  0;
  vsVisible   =  1;

  VCLKeyboardHookAtomID = '$VCLKeyboardHookAtom$';
  VCLMessageHookAtomID  = '$VCLMessageHookAtom$';

  UnicodeCharBuffer = 64;
  CHAR_BUFFER_COUNT = 256;

  AdxResourceLib = 'IntResource.dll';
  ServicePaneCaption = 'AdxServiceTP';
  ServicePaneProgID = 'ADXXServicePane.ProgID';
  ServicePaneCLSID: TCLSID = '{9E834F6F-BF48-46C5-820C-833B05104A8C}';

type

  TCharBuffer = array [0..CHAR_BUFFER_COUNT-1] of Char;
  TWideCharBuffer = array [0..CHAR_BUFFER_COUNT-1] of WideChar;
  TadxInternalRegionState = (irsUnknown, irsNormal, irsHidden, irsMinimized);
  TadxEventOption = (eoUnknown, eoLockRegionState, eoAvailableRegionState, eoLockRefreshInspectorTab);
  TadxEventOptions = set of TadxEventOption;
  TadxFindWindowCondition = (fwcDefault, fwcAnyVisibleState, fwcWindowMustVisible,
    fwcWindowMustVisibleAndMorePixel, fwcDockRight, fwcDockLeft, fwcDockTop, fwcDockBottom);

  TadxFindWindowConditions = set of TadxFindWindowCondition;
  TToDoBar2010LocationItem = (tlUnknown,
            tlNormalToDoBar,
            tlOffToDoBar,
            tlMinimizedToDoBar,
            tlNoWindowForSubclasing,
            tlTaskList,
            tlAppointments);
  TToDoBar2010Location = set of TToDoBar2010LocationItem;

  TadxRegionStateGuard = class
  private
    FLockCount: integer;
  public
    constructor Create();
    class function Instance: TadxRegionStateGuard;
    class procedure FreeRegionStateInstance;
    procedure Lock;
    procedure UnLock;
    function IsLock: boolean;
  end;

  TadxRefreshInspectorTabStateGuard = class
  private
    FLockCount: integer;
  public
    constructor Create();
    class function Instance: TadxRefreshInspectorTabStateGuard;
    class procedure FreeRefreshInspectorTabStateInstance;
    procedure Lock;
    procedure UnLock;
    function IsLock: boolean;
  end;


  TadxEventRaising = class
  private
    FEventName: string;
    FOptions: TadxEventOptions;
    function IsLockRegionState: boolean;
    function IsLockRefreshInspectorTab: boolean;
  public
    constructor Create(AEventName: string; AOptions: TadxEventOptions);
    destructor Destroy; override;
  end;

  TadxExceptionManager = class
    class procedure ProcessADXXError(err: SysUtils.Exception; whereHappened: string);
    procedure InternalProcessADXXError(err: SysUtils.Exception; whereHappened: string); virtual; abstract;
  end;

  ILog = interface
    procedure AddException(mes: string);
    procedure AddSystemInfo(info: string);
    procedure AddMessage(mes: string);
    procedure AddWarning(mes: string);
    procedure SetAddinName(value: string);
    function AddinName: string;
    procedure AddIndent;
    procedure RemoveIndent;
    procedure SetCountLastMessages(count: integer);
    function GetMessages: string;
    procedure ShowMessages(caption: string);
    procedure ClearMessages;
    procedure Save(fileName: string);
    procedure SetSaveLogToFileByDefaultAfterAddingEachMessage(value: boolean);
    function GetSaveLogToFileByDefaultAfterAddingEachMessage: boolean;
    procedure SetLogFileByDefault(value: string);
    function GetLogFileByDefault: string;
    procedure Disable;
  end;

  TLogIndent = class
  private
    FMes: string;
    FAddBeginEndSuffix: boolean;
    procedure initializeOnDefault;
  public
    constructor Create(); overload;
    constructor Create(Mes: string); overload; virtual;
    constructor Create(Mes: string; AddBeginEndSuffix: boolean); overload;
    destructor Destroy; override;
    procedure LogIndent(); overload;
    procedure LogIndent(Mes: string); overload;
    procedure DoBefore; virtual;
    procedure DoAfter; virtual;
  end;

  TLogEvent = class(TLogIndent)
  public
    constructor Create(Mes: string); override;
    procedure DoBefore; override;
    procedure DoAfter; override;
  end;


  TDebug = class
  public
    class procedure WriteLine(s: string);
    class procedure Assert(Conditional: boolean; ExceptionMessage: string);
  end;

  TWatchObject = class;

  TStoppingWatchObjectEventHandler = procedure(WatchObject: TWatchObject) of object;

  TWatchObject = class(TObject)
  private
    FStopWatch: boolean;
    isExecute: boolean;
    FStoppingWatchObject: TStoppingWatchObjectEventHandler;
    FPause: boolean;
    FWatchEngineIsHook: boolean;
    procedure SetPause(const Value: boolean);
    function GetPause: boolean;
    procedure SetStopWatch(const Value: boolean);
    function GetStopWatch: boolean;
    function GetWatchEngineIsHook: boolean;
    procedure SetWatchEngineIsHook(const Value: boolean);
  protected
    procedure DoExecute; virtual; abstract;
    procedure ProcessHookEvent(hWnd: THandle; Msg: UINT; wParam, lParam: Longint); virtual; //IProcessHookEvent
    function GetWindowHandle: HWND; virtual; //IProcessHookEvent
    function GetHostHandle: HWND; virtual; //IProcessHookEvent
    procedure START_WM_SETREDRAW(window: HWND); virtual;
    procedure END_WM_SETREDRAW(window: HWND); virtual;
  public
    procedure Execute;
    constructor Create;
    destructor Destroy; override;
    property StopWatch: boolean read GetStopWatch write SetStopWatch;
    property Pause: boolean read GetPause write SetPause;
    property StoppingWatchObject: TStoppingWatchObjectEventHandler read FStoppingWatchObject write FStoppingWatchObject;
    property WatchEngineIsHook: boolean read GetWatchEngineIsHook write SetWatchEngineIsHook;
    property HostHandle: HWND read GetHostHandle;
    property WindowHandle: HWND read GetWindowHandle;
  end;


  (*IProcessHookEvent = interface
    procedure ProcessHookEvent(hWnd: THandle; Msg: UINT; wParam, lParam: Longint);
    function GetStopWatch: boolean;
    procedure SetStopWatch(const value: boolean);
    function GetHostHandle: HWND;
    function GetWindowHandle: HWND;
    function GetWatchEngineIsHook: boolean;
    procedure SetWatchEngineIsHook(const value: boolean);
    property StopWatch: boolean read GetStopWatch write SetStopWatch;
    property HostHandle: HWND read GetHostHandle;
    property WindowHandle: HWND read GetWindowHandle;
    property WatchEngineIsHook: boolean read GetWatchEngineIsHook write SetWatchEngineIsHook;
  end;*)


  {$IFDEF ADX_VCL5}
  PCardinal = ^Cardinal;
  PPointer  = ^Pointer;
  PLongint  = ^Longint;
  {$ENDIF}

  TNCFont = (CaptionFont, MenuFont, MessageFont, SmCaptionFont, StatusFont);

  TWindowEvent            = procedure(AppWindowProperty: Pointer) of object;
  TadxFrameStyle          = integer;

  TadxHostVersion         = integer;
  TadxCaption             = array[0..ADXCAPTION_SIZE-1] of Char;
  TadxUnicodeCaption      = array[0..ADXCAPTION_SIZE-1] of AnsiChar;
  PadxUnicodeBuffer       = ^TadxUnicodeBuffer;
  TadxUnicodeBuffer       = array[0..UnicodeCharBuffer-1] of char;
  TVisibleState           = integer;
  TadxItemType            = longint;
  TadxWindowLayout        = integer;
  TadxRefreshKind         = integer;

  TadxKeyFilterAction = integer;

  TadxSplitterDepth = record
    Normal: integer;
    Collapsed: integer;
  end;

  TadxSplitMotion = (smDragging, smTraverse);
  TadxScrollType = (sctUnknown, sctVertical, sctHorizontal);

const
  //adxKeyFilterAction
  faSendToHostApplication = $03;
  faSendToAdxForm = $30;
  MAX_ADX_CAPTION = 60;

type
  PadxRegionParam = ^TadxRegionParam;
  TadxRegionParam = record
    Size:  integer;
    State: integer;
  end;

  PadxBlinkParam = ^TadxBlinkParam;
  TadxBlinkParam = record
    interval: Cardinal;
    period: Cardinal;
    layout: TadxWindowLayout;
    reserved: Cardinal;
    formHandle: HWND;
  end;

  PadxCTPVisibleParams = ^TadxCTPVisibleParams;
  TadxCTPVisibleParams = record
    Position: integer;
    AppHandle: integer;
    Visible: boolean;
  end;

  PAdxCTPParams = ^TAdxCTPParams;
  TAdxCTPParams = packed record
    pType: byte;
    Position: longWord;
    Size: integer;
    Splitter: longWord;
  end;

  TadxCTPUpdateParamType = (utNone, utUpdateSize, utSetSize, utSetSplitter);

  PadxAuditWindowParam = ^TadxAuditWindowParam;
  TadxAuditWindowParam = record
    itemType: TAdxItemType;
    Handle: Cardinal;
    HostHandle: Cardinal;
    Visible: boolean;
  end;

  PadxFormParam = ^TadxFormParam;
  TadxFormParam = record
    {$IFDEF UNICODE}
    Caption:       TadxUnicodeCaption;
    {$ELSE}
    Caption:       TadxCaption;
    {$ENDIF}
    FormHandle:    hwnd;
    AppHandle:     hwnd;
    NewWindowProc: pointer;
    OldWindowProc: pointer;
    Layout:        integer;
    ItemType:      integer;
    List:          Pointer;
    Count:         Integer;
    MainPos:       TWindowPos;
  end;

  PadxMessageCluster = ^TadxMessageCluster;
  TadxMessageCluster = record
    wParam: Cardinal;
    lParam: Cardinal;
  end;

  PadxDragOverMinimizedParams = ^TadxDragOverMinimizedParams;
  TadxDragOverMinimizedParams = record
    KeyState: integer;
    pt: TPoint;
    dataObj: Cardinal;
    Effect: Longint;
    Expand: Longbool;
  end;

  TadxFindScrollbarWindowProcedure = procedure (const OwnerWindow: HWND; const WindowHandle: HWND; var BreakProcess: boolean) of object;
  TadxDragOverMinimizedEvent = procedure (const dataObj: ActiveX.IDataObject; grfKeyState: Longint;
    pt: TPoint; var dwEffect: Longint; var Expand: longbool) of object;

  TadxSplitterMove = procedure (AWidth: integer; AHeight: integer; var Cancel: boolean) of object;

  TadxTaskPaneOption = (toShowBorder, toDraw2007);
  TadxTaskPaneOptions = set of TadxTaskPaneOption;
  TadxTaskPanePreset = (tpsDefault, tpsXP);

  TadxTaskPaneButtonState = (isUp, isFocused, isPressed, isDisabled);
  TadxTaskPaneButton = (pbNext, pbBack, pbMenu, pbClose, pbMinimize, pbDots, pbNone);
  TadxTaskPaneButtons = set of TadxTaskPaneButton;
  TBtnChangeStateEvent = procedure(sender: TObject; pb: TadxTaskPaneButton; var Enabled: Boolean) of object;
  TBtnMouseClick = procedure(sender: TObject; pb: TadxTaskPaneButton) of object;

  TadxMessageHandler = function(msg: Cardinal; wParam, lParam: longint): longint of object;

const
  MaxFormParamListSize = 124;
  HIGHKEY = 512;

type
  TadxFormParamList = array[0..MaxFormParamListSize-1] of TadxFormParam;
  PadxFormParamList = ^TadxFormParamList;

  PAppWindowProperty = ^TAppWindowProperty;
  TAppWindowProperty = record
    EmulateWindowHandle: HWND;
    WindowHandle: HWND;
    Offset: integer;
    VisibleState: TVisibleState;
    HostHandle: HWND;
    Layout: integer;
    ItemType: integer;
    ContainerType: integer;
    Caption: TadxCaption;
    HostVersion: integer;
    Splitter: integer;
    ReceiverHandle: HWND;
    AlwaysShowHeader: boolean;
    CloseButton: boolean;
    SplitterButton: boolean;
    RegionBorder: TadxRegionBorderStyle;
    ItemID: TGUID;
    VerticalScrollbarHandle: HWND;
  end;

  //TadxTheme
  TadxGradientDirection   = (gdNormal, gdInverse);
  TadxGradientStyle       = (gtCornerTopLeft, gtCornerTopRight, gtCornerBottomRight, gtCornerBottomLeft, gtDiagonalRising,
                            gtDiagonalFalling, gtEllipse, gtPyramid, gtVerticalToCenter, gtHorizontalToCenter, gtLeftToRight, gtTopToBottom);

  tag_IsAppThemed         = function: boolean; stdcall;
  tag_IsThemeActive       = function: boolean; stdcall;
  tag_OpenThemeData       = function (hwnd: HWND; pszClassList: PWideChar): HWND; stdcall;
  tag_CloseThemeData      = function (hTheme: HWND): HResult; stdcall;
  tag_GetCurrentThemeName = function (pszThemeFileName: LPWSTR; cchMaxNameChars: Integer; pszColorBuff: LPWSTR;
                            cchMaxColorChars: Integer; pszSizeBuff: LPWSTR; cchMaxSizeChars: Integer): HResult; stdcall;
  tag_DrawThemeEdge       = function (hTheme: HWND; hdc: HDC; iPartId, iStateId: Integer;
                            const pDestRect: TRect; uEdge, uFlags: Uint; pContentRect: PRect): HResult; stdcall;

  TDrawMode               = (drwThemed, drwSimple);

  TWindowColor = record
    Border, BackGround, Shadow, BkGndEnd, Caption: TGPColor;
  end;

  TBtnColor = record
    Border, BorderShadow, BackGround, FocusedBegin, FocusedEnd, SelectedBegin, SelectedEnd, PaneBegin, PaneEnd: TGPColor;
  end;

  TMenuColor = record
    BackGround, ItemBackGround, ItemIconArea, ItemBorder, ItemSelected: TGPColor;
  end;

  TTaskItemColor = record
    BackGround, Selected, Pressed, Border: TGPColor;
  end;

  TadxThemeColor = class
  private
    clXPBlueWndFrame,
    clXPBlueWndBack,
    clXPBluePaneBegin,
    clXPBluePaneEnd,
    clXPBlueBtnFrame,
    clXPBlueBtnSelectBegin,
    clXPBlueBtnSelectEnd,
    clXPBlueItemSelected,
    clXPBlueItemPressed,
    clXPBlueItemBack,
    clXPBlueItemFrame,

    clXPHomeSteadWndFrame,
    clXPHomeSteadWndBack,
    clXPHomeSteadPaneBegin,
    clXPHomeSteadPaneEnd,
    clXPHomeSteadBtnFrame,
    clXPHomeSteadBtnSelectBegin,
    clXPHomeSteadBtnSelectEnd,
    clXPHomeSteadItemSelected,
    clXPHomeSteadItemPressed,
    clXPHomeSteadItemBack,
    clXPHomeSteadItemFrame,

    clXPMetallicWndFrame,
    clXPMetallicWndBack,
    clXPMetallicPaneBegin,
    clXPMetallicPaneEnd,
    clXPMetallicBtnFrame,
    clXPStyleBtnFocusedBegin,
    clXPStyleBtnFocusedEnd,
    clXPMetallicBtnSelectBegin,
    clXPMetallicBtnSelectEnd : Cardinal;
    clXPMetallicItemSelected,
    clXPMetallicItemPressed,
    clXPMetallicItemBack,
    clXPMetallicItemFrame,

    clXPClassicWndFrame,
    clXPClassicWndBack,
    clXPClassicPaneBegin,
    clXPClassicPaneEnd,
    clXPClassicBtnFrame,
    clXPClassicBtnFocusedBegin,
    clXPClassicBtnFocusedEnd,
    clXPClassicBtnSelectBegin,
    clXPClassicBtnSelectEnd,
    clXPClassicItemSelected,
    clXPClassicItemPressed,
    clXPClassicItemBack,
    clXPClassicItemFrame: Cardinal;

    clVistaWndFrameAero,
    clVistaWndBackAero,
    clVistaBtnFrameAero,
    clVistaBtnFrameShadowAero,

    clXPRoyalePaneBegin,
    clXPRoyalePaneEnd,

    cl2007StyleBtnFrameFocused,
    cl2007StyleBtnFrameSelected,
    cl2007StyleBtnFocusedBegin,
    cl2007StyleBtnFocusedEnd,
    cl2007StyleBtnSelectedBegin,
    cl2007StyleBtnSelectedEnd,

    cl2007BlueWndFrame,
    cl2007BlueWndBackBegin,
    cl2007BlueWndBackEnd,
    cl2007BluePaneBegin,
    cl2007BluePaneEnd,
    cl2007BlueItemSelected,
    cl2007BlueItemPressed,
    cl2007BlueItemBack,

    cl2007SilverWndFrame,
    cl2007SilverWndBackBegin,
    cl2007SilverWndBackEnd,
    cl2007SilverPaneBegin,
    cl2007SilverPaneEnd,
    cl2007SilverItemSelected,
    cl2007SilverItemPressed,
    cl2007SilverItemBack,

    cl2007BlackWndFrame,
    cl2007BlackWndBackBegin,
    cl2007BlackWndBackEnd,
    cl2007BlackPaneBegin,
    cl2007BlackPaneEnd,
    cl2007BlackItemSelected,
    cl2007BlackItemPressed,
    cl2007BlackItemBack,

    cl2010BlueWndFrame,
    cl2010BlueWndBackBegin,
    cl2010BlueWndBackEnd,
    cl2010BluePaneBegin,
    cl2010BluePaneEnd,
    cl2010BlueItemSelected,
    cl2010BlueItemPressed,
    cl2010BlueItemBack,

    cl2010SilverWndFrame,
    cl2010SilverWndBackBegin,
    cl2010SilverWndBackEnd,
    cl2010SilverPaneBegin,
    cl2010SilverPaneEnd,
    cl2010SilverItemSelected,
    cl2010SilverItemPressed,
    cl2010SilverItemBack,

    cl2010BlackWndFrame,
    cl2010BlackWndBackBegin,
    cl2010BlackWndBackEnd,
    cl2010BlackPaneBegin,
    cl2010BlackPaneEnd,
    cl2010BlackBtnBorder, 
    cl2010BlackItemSelected,
    cl2010BlackItemPressed,
    cl2010BlackItemBorder, 
    cl2010BlackItemBack: Cardinal;

  public
    constructor Create; virtual;
  end;

  TadxThemeColorClass = class of TadxThemeColor;

  TadxOLThemeColor = class(TadxThemeColor)
  end;

  TadxXLThemeColor = class(TadxThemeColor)
  public
    constructor Create; override;
  end;

  TadxWDThemeColor = class(TadxThemeColor)
  public
    constructor Create; override;
  end;

  TadxPPThemeColor = class(TadxThemeColor)
  public
    constructor Create; override;
  end;

  TThemeColorIndex = integer;

const
  //ThemeColorIndex
  tmUnknown =            -1;
  tmClassic =             0;
  tmLuna_Blue =           1;
  tmLuna_Olive =          2;
  tmLuna_Silver =         3;
  tmRoyale =              4;
  tmOffice2007_Blue =     10;
  tmOffice2007_Silver =   11;
  tmOffice2007_Black =    12;
  tmOffice2010_Blue =     23;
  tmOffice2010_Silver =   24;
  tmOffice2010_Black =    25;
  tmAero =                20;

type
  TadxTheme = class;

  TadxThemeChanged = class(TWinControl)
  private
    FAdxTheme: TadxTheme;
    FAppVersion: TadxHostVersion;
  protected
    procedure WndProc(var Message: TMessage); override;
    function GetThemeIndex: TThemeColorIndex;
  public
    property ThemeIndex: integer read GetThemeIndex;
    constructor CreateEx(AadxTheme: TadxTheme; AAppVersion: TadxHostVersion);
    destructor Destroy; override;
  end;

  TadxTheme = class(TCustomControl)
  private
    FAppVersion: integer;
    FHostHandle: HWND;
    FItemType: integer;

    MSO_Message: TadxThemeChanged;

    hThemeLib: HInst;
    FTheme: HWND;
    FThemeActive: boolean;
    FThemeFileName: string;
    FColorBuf: string;
    FSizeBuf: string;
    FWndColor: TWindowColor;
    FBtnColor: TBtnColor;
    FMenuColor: TMenuColor;
    FItemColor: TTaskItemColor;
    FThemeColor: TadxThemeColor;
    FThemeResourceBitmap: TadxGPBitmap;
    FOfficeThemeAvailable: boolean;

    ThemesAvailable: tag_IsAppThemed;
    IsThemeActive: tag_IsThemeActive;
    OpenThemeData: tag_OpenThemeData;
    CloseThemeData: tag_CloseThemeData;
    GetCurrentThemeName: tag_GetCurrentThemeName;
    FThemeColorIndex: TThemeColorIndex;
    FDPIratio: single;
    FOnThemeChanged: TNotifyEvent;
    FBlinkCursorEnable: Boolean;
    FBlinkCursorTime: Cardinal;

    procedure InitThemeColor(index: TThemeColorIndex);
    procedure SetThemeColorIndex(const Value: TThemeColorIndex);
    function  GetThemeResourceBitmap: TadxGPBitmap;
    procedure DoThemeChanged; virtual;
    procedure SetBlinkCursorEnable(const Value: boolean);

  protected
    procedure WndProc(var message: TMessage); override;
    function  GetAdxThemeColorClass: TadxThemeColorClass; virtual;
    function  GetDPIratio: single; virtual;
    property  ThemeColorIndex: TThemeColorIndex read FThemeColorIndex write SetThemeColorIndex;
    property  HostHandle: HWND read FHostHandle;

  public
    procedure DrawFrame3D(ACanvas: TadxGPGraphics; Rect: TRect; Depth: integer;  const B3DStyle: Cardinal = BDR_SUNKENOUTER; const B3DSide: Cardinal = BF_TOPLEFT or BF_BOTTOMRIGHT);
    procedure DrawFrame(ACanvas: TadxGPGraphics; Rect: TRect; Depth: integer; FrameColor: TGPColor);
    procedure DrawFrameAPI(Handle: HWND; DC: HDC; Rect: TRect; mode: TDrawMode; const B3DStyle: Cardinal = BDR_SUNKENOUTER; const B3DSide: Cardinal = BF_TOPLEFT or BF_BOTTOMRIGHT); overload;
    procedure DrawFrameAPI(Handle: HWND; mode: TDrawMode; const B3DSide: Cardinal = BF_TOPLEFT or BF_BOTTOMRIGHT); overload;
    procedure DrawDots(ACanvas: TadxGPGraphics; ARect: TRect; const Vertical: boolean = true; const Pressed: boolean = false);

    procedure Refresh;
    procedure Initialize(AppVersion: integer; ItemType: integer; AHostHandle: HWND); virtual;

    constructor Create(AOwner: TComponent); override;
    constructor CreateEx(AThemeColor: TadxThemeColor);
    destructor  Destroy; override;

    property OfficeThemeAvailable: boolean read FOfficeThemeAvailable;
    property ThemeActive: boolean read FThemeActive;
    property ThemeFileName: string read FThemeFileName;
    property ColorBufName: string read FColorBuf;
    property SizeBufName: string read FSizeBuf;

    property ThemeColor: TadxThemeColor read FThemeColor;
    property ThemeResourceBitmap: TadxGPBitmap read GetThemeResourceBitmap;
    property DPIratio: single read FDPIratio;
    property BlinkCursorEnable: boolean read FBlinkCursorEnable write SetBlinkCursorEnable;
    property OnThemeChanged: TNotifyEvent read FOnThemeChanged write FOnThemeChanged;
  end;

  TadxDragWindowLayout = integer;

  PadxDragLayoutParams = ^TadxDragLayoutParams;
  TadxDragLayoutParams = record
    ItemType: TadxItemType;
    Layout: TadxWindowLayout;
    Disabled: boolean;
    LayoutSize: integer;
    AppHandle: HWND;
  end;

  PadxDragItemParams = ^TadxDragItemParams;
  TadxDragItemParams = record
    DragLayout: TadxDragWindowLayout;
    ItemType: TadxItemType;
    Disabled: boolean;
    ItemHandle: HWND;
    Reserved: Cardinal;
  end;

  PadxDragItemParamsList = ^TadxDragItemParamsList;
  TadxDragItemParamsList = array[0..255] of TadxDragItemParams;

  PadxDragItemListHeader = ^TadxDragItemListHeader;
  TadxDragItemListHeader = record
    ListItems: PadxDragItemParamsList;
    Count: integer;
    Allowed: LongBool;
  end;

  TadxRegionShadowForm = class(TWinControl)
  private
    FAlphaBlendValue: byte;
    FTransparencyKey: Cardinal;
    procedure SetAlphaBlendValue(const Value: byte);
    procedure SetTransparencyKey(const Value: Cardinal);
    procedure SetLayeredAttributes;
  public
    constructor Create(AOwner: TComponent); override;
    property AlphaBlendValue: byte read FAlphaBlendValue write SetAlphaBlendValue;
    property TransparencyKey: Cardinal read FTransparencyKey write SetTransparencyKey;
  end;

  TadxRegionDragContainer = class;
  TadxDragCustomControl = class;

  TadxRegionDragPanel = class(TadxRegionShadowForm)
  private
    FContainer: TadxRegionDragContainer;
    procedure SetPosition(ALeft, ATop, AWidth, AHeight: integer);
  public
    constructor CreateEx(AContainer: TadxRegionDragContainer);
  end;

  TadxRegionDragContainer = class(TadxRegionShadowForm)
  private
    FDragPanel: TadxRegionDragPanel;
    FDragControls: TadxDragCustomControl;
    FContainerPane: TObject;
    FDragRect: TRect;
    FOldCursor: TCursor;
    FUpdateCount: integer;
    FFormHandle: HWND;
    FHostHandle: HWND;
    FHostVersion: TadxHostVersion;
    FCurrentAppHandle: HWND;
    FCurrentLayout: TadxWindowLayout;
    FCurrentItemsCount: integer;
    FCurrentScreenPos: TWindowPos;
    FCurrentPaneHandle: HWnd;
    FEnableDragAndDrop: boolean;
    FCanvasChanged: boolean;
    FButtonsBitmap: TadxGPBitmap;
    FSelectedControl: TadxDragCustomControl;
    FContainerCursor: TCursor;
    FOSCConnected: boolean;
    function  GetResourceBitmapRect(layout: TadxWindowLayout): TRect;
    function  GetExistLayoutRect(AppHandle: HWnd;  ALayout: integer; var ARect: TRect): boolean;
    procedure DrawResourceImage(ACanvas: TadxGPGraphics; X, Y: integer; ALayout: TadxWindowLayout);
    function  AddItem(dragWindowLayout: TadxDragWindowLayout; AItemType: TadxItemType; AWindowHandle: HWND): integer;
    function  GetMouseCursorPos: TPoint;
    function  DefaultLayoutSize: TSize;
    procedure CanvasChanged;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure MousePassing(mouseOffset: TPoint);

    procedure DoMouseHover(Sender: TObject);
    procedure DoMouseFocused(Sender: TObject);
    procedure DoMouseSelect(Sender: TObject);

    function  GetButtonsBitmap: TadxGPBitmap;
    procedure SetSelectedControl(const Value: TadxDragCustomControl);
    procedure InitializeItems(ItemsPtr: Pointer);
    procedure SetContainerCursor(const Value: TCursor);
    property  ButtonsBitmap: TadxGPBitmap read GetButtonsBitmap;
    property  SelectedControl: TadxDragCustomControl read FSelectedControl write SetSelectedControl;
    property  ContainerCursor: TCursor read FContainerCursor write SetContainerCursor;
    property  HostHandle: HWnd read FHostHandle;
  protected
    procedure WndProc(var Message: TMessage); override;
    procedure Paint;
  public
    constructor CreateEx(AOwner: TObject; AFormHandle: HWND);
    destructor Destroy; override;
  end;

  TadxDragCustomControl = class
  private
    FParent: TadxDragCustomControl;
    FOwner: TadxRegionDragContainer;
    FControls: TList;
    FBounds: TRect;
    FSubclassRect: TRect;
    FWindowRect: TRect;
    FItemType: TadxItemType;
    FLayout: TadxWindowLayout;
    FAppHandle: HWND;
    FState: TadxTaskPaneButtonState;
    procedure SetBounds; virtual;
    procedure SetState(const Value: TadxTaskPaneButtonState);
    procedure GetLayoutParams(var param: TadxDragLayoutParams); virtual;
    procedure OffsetExcludeItem(var ARect: TRect); virtual;
    procedure Paint(ACanvas: TadxGPGraphics); virtual;
    function  FindControl(ACursorPos: TPoint): TadxDragCustomControl;
    function  GetLayoutRect(LayoutIndex: integer): TRect; virtual;
    property  SubClassRect: TRect read FSubclassRect;
    property  WindowRect: TRect read FWindowRect;
    property  ItemType: TadxItemType read FItemType;
    property  Layout: TadxWindowLayout read FLayout;
    property  AppHandle: HWND read FAppHandle;
    property  State: TadxTaskPaneButtonState read FState write SetState;
  protected
    procedure DrawFrame(ACanvas: TadxGPGraphics);
  public
    constructor Create; overload;
    constructor Create(AParent: TadxDragCustomControl; AOwner: TadxRegionDragContainer;
      AItemType: TadxItemType; ALayout: TadxWindowLayout; AHandle: HWND); overload; virtual;
    destructor Destroy; override;
  end;

  TadxDragControl = class(TadxDragCustomControl)
  private
    procedure SetBounds; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  end;

  TadxDragControlRP = class(TadxDragControl)
  private
    procedure SetBounds; override;
    function  GetLayoutRect(LayoutIndex: integer): TRect; override;
    procedure OffsetExcludeItem(var ARect: TRect); override;
  end;

  TadxDragControlCTP = class(TadxDragControl)
  private
    FSubclassHandle: HWnd;
    function  GetLayoutRect(LayoutIndex: integer): TRect; override;
    procedure GetLayoutParams(var param: TadxDragLayoutParams); override;
    procedure OffsetExcludeItem(var ARect: TRect); override;
  public
    constructor Create(AParent: TadxDragCustomControl; AOwner: TadxRegionDragContainer;
      AItemType: TadxItemType; ALayout: TadxWindowLayout; AHandle: HWND); overload; override;
  end;

  TadxDragControlTotal = class(TadxDragCustomControl)
  private
    procedure SetBounds; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  public
    constructor Create(AParent: TadxDragCustomControl; AOwner: TadxRegionDragContainer;
      AItemType: TadxItemType; ALayout: TadxWindowLayout; AHandle: HWND); overload; override;
  end;

  TadxDragControlTotalRP = class(TadxDragCustomControl)
  private
    procedure SetBounds; override;
    function  GetLayoutRect(LayoutIndex: integer): TRect; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  public
    constructor Create(AParent: TadxDragCustomControl; AOwner: TadxRegionDragContainer;
      AItemType: TadxItemType; ALayout: TadxWindowLayout; AHandle: HWND); overload; override;
  end;

  PadxContainerForm = ^TadxContainerForm;
  TadxContainerForm = record
    param: PadxFormParam;
    glyph: TObject;
  end;

  PadxFloatingParam = ^TadxFloatingParam;
  TadxFloatingParam = record
    containerHandle: HWnd;
    floatingPos: TWindowPos;
    minimizeRect: TRect;
  end;

  TadxWMIEmulateWindow = class(TWinControl)
  private
    FControlParent: HWND;
    FControlHandle: HWND;
    MainPos: TWindowPos;
    FRect: TRect;
    FControlRect: TRect;
    OffsetX, OffsetY: integer;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    FResponse: boolean;
    constructor CreateEx(AControlHandle: HWND);
    destructor Destroy; override;
  end;

  TAuditKey = record
    Pressed: boolean;
    Toogled: boolean;
  end;

const
  //adxKeyState
  csPressed = $0F;
  csReleased = $F0;

type
  TadxKeyState = integer;

  PadxKeyInfo = ^TadxKeyInfo;
  TadxKeyInfo = record
    Alt: boolean;
    Control: boolean;
    Shift: boolean;
    KeyCode: byte;
    KeyValue: Cardinal;
    State: TadxKeyState;
  end;

  TKeyActionProc = function(keyCode, keyData: Cardinal; sysMessage: boolean): boolean of Object;
  THookKeyAction = (kaUnknown, kaPreProcess, kaSelectedKey, kaShortCut, kaHotKey, kaTabKey, kaWBKey);

  TadxKeyboardHook = class
  private
    fAtom: Cardinal;
    fConnected: boolean;
    fOnKeyReleased: TKeyActionProc;
    fOnKeyPressed:  TKeyActionProc;
    fAuditKey: TAuditKey;
    fKeyEventArgs: TadxKeyInfo;

    HookProc: Pointer;
    //KeyboardState: TKeyboardState;
    fKeyAction: THookKeyAction;
    function  CallbackFunction(code: longint; wParam, lParam: Cardinal): Longint; stdcall;
    function  GetAuditKey(key: integer): TAuditKey;
    procedure SetKeyAction(const Value: THookKeyAction);
    function  GetFormHandle: HWnd; virtual;
    function  SendKeyPressMessage(handle: HWND; KeyCode, KeyData: Cardinal; sysMessage, cmdMessage: boolean; state: TadxKeyState; makePost: boolean): Longint;
    function  SendKeyCharMessage(handle: HWND; KeyCode, KeyData: Cardinal; sysMessage, cmdMessage, makePost: boolean): longint;

  protected
    HookHandle: HHook;
    ActiveHandle: HWnd;
    fFormHandle: HWnd;
    HostHandle: HWnd;

    function  GetConnected: boolean;
    procedure SetConnected(const Value: boolean);

    procedure HookAction_SetFormStyleCHILD;
    procedure HookAction_SetFormStyleOVERLAPPED;
    function  ProcessCustomKey(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
    function  ProcessArrowAction(keyCode, keyData: Cardinal): boolean;
    function  SendKeyToHandle(handle: Cardinal; KeyCode, KeyData: Cardinal): boolean;

    function  PreProcessKey_Pressed(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
    function  PreProcessKey_Released(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;

    function  SelectKey_Pressed(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
    function  SelectKey_Released(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
    function  ShortCut_Pressed(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
    function  HotKey_Pressed(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
    function  TabKey_Pressed(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
    function  WBKey_Pressed(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
    function  WBKey_Released(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
    function  GetKeyFilterAction(const DefaultAction: TadxKeyFilterAction = faSendToAdxForm): TadxKeyFilterAction;

    function  ActiveWebBrowser: boolean;
    function  KeyboardHookProc(code: longint; wParam, lParam: Cardinal): Longint; virtual;

    property  Connected: boolean read GetConnected write SetConnected;
    property  OnKeyPressed:  TKeyActionProc read fOnKeyPressed write fOnKeyPressed;
    property  OnKeyReleased: TKeyActionProc read fOnKeyReleased write fOnKeyReleased;
    property  AuditKey[key: integer]: TAuditKey read GetAuditKey;

    property  FormHandle: HWnd read GetFormHandle write fFormHandle;
    property  KeyAction: THookKeyAction read fKeyAction write SetKeyAction;

  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

  PMethod = ^TMethod;
  TadxHookMessageHandler = procedure(message: TCWPStruct) of object;

  TadxMessageHook = class
  private
    FAtom: Cardinal;
    FConnected: boolean;
    HookProc: Pointer;

    FOnMessageConnections: TList;
    function  CallbackFunction(code: longint; wParam, lParam: Cardinal): Longint; stdcall;
  protected
    HookHandle: HHook;
    function  GetConnectThreadID: Cardinal; virtual;
    function  GetConnected: boolean;
    procedure SetConnected(const Value: boolean);
    function  MessageHookProc(code: longint; wParam, lParam: Cardinal): Longint; virtual;
    procedure DoMessage(msg: TCWPStruct);
    property  Connected: boolean read GetConnected write SetConnected;
  public
    constructor Create;
    destructor Destroy; override;
    procedure OnMessageConnect(handler: TadxHookMessageHandler; obj: TObject);
    procedure OnMessageDisconnect(handler: TadxHookMessageHandler);
  end;

  TadxMessageRetHook = class
  private
    HookProc: Pointer;
    function  CallbackFunction(code: longint; wParam, lParam: Cardinal): Longint; stdcall;
  protected
    HookHandle: HHook;
    function  MessageHookProc(code: longint; wParam, lParam: Cardinal): Longint; virtual;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TadxMouseHook = class
  private
    HookProc: Pointer;
    function  GetConnectThreadID: Cardinal; virtual;
    function  CallbackFunction(code: longint; wParam, lParam: Cardinal): Longint; stdcall;
  protected
    HookHandle: HHook;
    function  MessageHookProc(code: longint; wParam, lParam: Cardinal): Longint; virtual;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TadxCustomHook = class
  private
    FActiveFormHandle: HWND;
    FIsIMEComposition: boolean;
    procedure DoFocused(HandleFocused: HWND; FlagFocused: boolean);
    procedure SetActiveFormHandle(const Value: HWND); 
    procedure SetIsIMEComposition(const Value: boolean);
  public
    property ActiveFormHandle: HWND read FActiveFormHandle write SetActiveFormHandle;
    property IsIMEComposition: boolean read FIsIMEComposition write SetIsIMEComposition;
    constructor Create;
  end;

  TadxOLHook = class;

  TadxOLKeyBoardHook = class(TadxKeyboardHook)
  private
    FParent: TadxOLHook;
  protected
    function KeyboardHookProc(code: longint; wParam, lParam: Cardinal): Longint; override;
  public
    constructor CreateEx(AParent: TadxOLHook);
  end;

  TadxOLMessageHook = class(TadxMessageHook)
  private
    FEnableProcessWatchObjects: boolean;
    FWatchObjects: TList;
    FParent: TadxOLHook;
    FActiveFocus: HWND;
    procedure InternalDeleteStoppedObjects;
    function GetEnableProcessWatchObjects: boolean;
    procedure SetEnableProcessWatchObjects(const Value: boolean);
  protected
    procedure ProcessWatchObjects(msg: TCWPStruct);
    function MessageHookProc(code: longint; wParam, lParam: Cardinal): Longint; override;
    procedure AddWatchObjects(WatchObject: TWatchObject);
  public
    constructor CreateEx(AParent: TadxOLHook);
    destructor Destroy; override;
    property EnableProcessWatchObjects: boolean read GetEnableProcessWatchObjects write SetEnableProcessWatchObjects;
  end;

  MsoCTPDockPosition = TOleEnum;
  TIntUpdateOLExplorerParam = procedure (ARegionHandle: Hwnd; ARegionPos: TWindowPos); cdecl;
  TIntAddCTP = function (CTPFactory: OleVariant; CTPParentWindow: OleVariant; PCTPParam: Cardinal): HResult; cdecl;
  TIntDeleteCTP = function (position: MsoCTPDockPosition; CTPParentWindow: OleVariant): HResult; cdecl;
  TIntUpdateCTP = function (CTPParentWindow: OleVariant; PCTPParam: Cardinal): HResult; cdecl;
  TIntUpdateCompatibility = function(CFunc: Cardinal; PCParam: Cardinal): HResult; cdecl;

  TadxIntResource = class
  private
    FOwner: TadxOLHook;
    FIntModule: HModule;
    FModuleName: string;
    FNeedFree: boolean;
    IntUpdateOLExplorerParam: TIntUpdateOLExplorerParam;
    IntAddCTP: TIntAddCTP;
    IntDeleteCTP: TIntDeleteCTP;
    IntUpdateCTP: TIntUpdateCTP;
    IntUpdateCompatibility: TIntUpdateCompatibility;
    procedure DoUpdateOLExplorerParam(ARegionHandle: Hwnd; ARegionPos: TWindowPos);
    function DoAddCTP(const CTPFactory: IDispatch; const CTPParentWindow: IDispatch; PCTPParam: PAdxCTPParams): HResult;
    function DoUpdateCTP(const CTPParentWindow: IDispatch; PCTPParam: PAdxCTPParams): HResult;
    function DoDeleteCTP(position: integer; const CTPParentWindow: IDispatch): Hresult;
    function DoUpdateCompatibility(CFunc: Cardinal; PCParam: Cardinal): HResult;
  public
    constructor Create(AOwner: TadxOLHook);
    destructor Destroy; override;
  end;

  TAppScrollWindow = class;

  TadxOLHook = class(TadxCustomHook)
  private
    fKeyboardHook: TadxOLKeyBoardHook;
    fMessageHook: TadxOLMessageHook;
    fIsCustomizeForm: boolean;
    fHostVersion: TadxHostVersion;
    fIntResource: TadxIntResource;
    fAppScrollWindow: TAppScrollWindow;
    procedure UpdateOLExplorerParam(ARegionHandle: Hwnd; ARegionPos: TWindowPos);
    procedure UpdateOLScrollBar(ScrollHandle: HWND);
    function GetEnableProcessWatchObjects: boolean;
    procedure SetEnableProcessWatchObjects(const Value: boolean);
  public
    function AddCTP(const CTPFactory: IDispatch; const CTPParentWindow: IDispatch; PCTPParam: PAdxCTPParams): HResult;
    function DeleteCTP(position: integer; CTPParentWindow: IDispatch): HResult;
    function UpdateCTP(const CTPParentWindow: IDispatch; PCTPParam: PAdxCTPParams): HResult;
    function UpdateCompatibility (CFunc: Cardinal; PCParam: Cardinal): HResult;
    constructor CreateEx(AHostVersion: TadxHostVersion);
    destructor Destroy; override;
    procedure AddHandleHookWatchObject(WatchObject: TWatchObject);
    property KeyboardHook: TadxOLKeyBoardHook read fKeyboardHook;
    property MessageHook: TadxOLMessageHook read fMessageHook;
    property HostVersion: TadxHostVersion read fHostVersion;
    property EnableProcessWatchObjects: boolean read GetEnableProcessWatchObjects write SetEnableProcessWatchObjects;
  end;

  TadxAuditWindow = class
  private
    fOwner: TadxAuditWindow;
    fAdxItem: TadxItemType;
    fClassPath: string;
    fHostHandle: Cardinal;
    auditWindowParam: TadxAuditWindowParam;
    fHandle: Cardinal;
    fVisible: boolean;
    function GetVisible: boolean;
    procedure SetHandle(const Value: Cardinal);
  public
    property Visible: boolean read GetVisible;
    property Handle: Cardinal read fHandle write SetHandle;
    property AdxItem: TadxItemType read fAdxItem write fAdxItem;
    function UpdateVisible(AHandle: Cardinal; AVisible: boolean): boolean;
    procedure UpdateHandle(AHandle: Cardinal);
    constructor Create(hostHandle: Cardinal; itemType: TAdxItemType; classPath: string);
    destructor Destroy; override;
  end;

  TadxAuditWindowList = class(TList)
  public
    function  AddItem(AuditHostHandle: Cardinal; ItemType: TadxItemType; ClassPath: string): integer;
    procedure RemoveItem(auditWindow: TadxAuditWindow);
    procedure ClearItems;
    procedure UpdateVisible(AHandle: Cardinal; AVisible: boolean);
    procedure UpdateHandle(AHandle: Cardinal);
    function GetHandleOfItem(ItemType: TAdxItemType): Cardinal;
    destructor Destroy; override;
  end;

  TadxOEHook = class;

  TadxOEKeyBoardHook = class(TadxKeyboardHook)
  private
    fParent: TadxOEHook;
    fLastKeyPressed: byte;
  protected
    function KeyboardHookProc(code: longint; wParam, lParam: Cardinal): Longint; override;
  public
    constructor CreateEx(AdxHostHandle: Cardinal; AParent: TadxOEHook);
  end;

  TadxOEMessageHook = class(TadxMessageHook)
  private
    fParent: TadxOeHook;
    fHostHandle: Cardinal;
    FActiveFocus: HWND;
    msg:  TCWPStruct;
  protected
    function  GetConnectThreadID: Cardinal; override;
    function  MessageHookProc(code: longint; wParam, lParam: Cardinal): Longint; override;
    property Parent: TadxOeHook read fParent;
  public
    constructor CreateEx(AdxHostHandle: Cardinal; AParent: TadxOEHook);
  end;

  TadxOEMessageHookInCurrentThread = class(TadxMessageHook)
  private
    fParent: TadxOeHook;
    FActiveFocus: HWND;
    FHostHandle: HWND;
    msg:  TCWPStruct;
  protected
    function  MessageHookProc(code: longint; wParam, lParam: Cardinal): Longint; override;
    property Parent: TadxOeHook read fParent;
  public
    constructor CreateEx(AdxHostHandle: Cardinal; AParent: TadxOEHook);
  end;

  TadxOEHook = class(TadxCustomHook)
  private
    fKeyboardHook: TadxOEKeyBoardHook;
    fMessageHook: TadxOEMessageHook;
    fMessageHookInCurrentThread: TadxOEMessageHookInCurrentThread;
    fHostHandle: Cardinal;
    fHostVersion: TadxHostVersion;

    oeHook_Atom: word;
    oeHook_Atom_Name: string;
    fHookAlreadyExists: boolean;
    fAuditWindowList: TadxAuditWindowList;
    fMenuActive: boolean;

    procedure AddExplorerItems;
    procedure RemoveExplorerItems;
    procedure SetHostHandle(const Value: Cardinal);
    procedure SetHookAlreadyExists(const Value: boolean);
    function GetHookAlreadyExists: boolean;
    property MenuActive: boolean read fMenuActive write fMenuActive;

  protected
    //ActiveFormHandle: Cardinal;
    LoseFocusHandle: Cardinal;
    property HostVersion: TadxHostVersion read fHostVersion;
    property HookAlreadyExists: boolean read GetHookAlreadyExists write SetHookAlreadyExists;

  public
    property HostHandle: Cardinal read fHostHandle write SetHostHandle;
    property AuditWindowList: TadxAuditWindowList read fAuditWindowList;
    constructor CreateEx(ApplicationHostHandle: Cardinal; AHostVersion: TadxHostVersion);
    destructor Destroy; override;
  end;

  TadxXlHook = class;
  TadxWdHook = class;

  TadxXLKeyBoardHook = class(TadxKeyboardHook)
  private
    FHostHandle: HWND;
    FParent: TadxXLHook;
    function GetFormHandle: HWND; override;
  protected
    function KeyboardHookProc(code: longint; wParam, lParam: Cardinal): Longint; override;
  public
    constructor CreateEx(AHostHandle: HWND; AParent: TadxXLHook);
    //property FormHandle: HWND read GetFormHandle write fFormHandle;
  end;

  TadxWDKeyBoardHook = class(TadxKeyboardHook)
  private
    FHostHandle: HWND;
    FParent: TadxWDHook;
    function GetFormHandle: HWND; override;
  protected
    function KeyboardHookProc(code: longint; wParam, lParam: Cardinal): Longint; override;
  public
    constructor CreateEx(AHostHandle: HWND; AParent: TadxWDHook);
  end;

  TadxXLMessageHook = class(TadxMessageHook)
  private
    FHostHandle: HWND;
    FActiveControl: HWND;
    FActiveFocus: HWND;
    FLastFocus: HWND;
    FFormHandle: HWND;
    FParent: TadxXLHook;
    FEditMode: boolean;
  protected
    function  MessageHookProc(code: longint; wParam, lParam: Cardinal): Longint; override;
  public
    constructor CreateEx(AHostHandle: HWND; AParent: TadxXLHook);
  end;

  TadxWDMessageHook = class(TadxMessageHook)
  private
    FHostHandle: HWND;
    //FActiveControl: HWND;
    FActiveFocus: HWND;
    FLastFocus: HWND;
    //FFormHandle: HWND;
    FParent: TadxWDHook;
  protected
    function  MessageHookProc(code: longint; wParam, lParam: Cardinal): Longint; override;
  public
    constructor CreateEx(AHostHandle: HWND; AParent: TadxWDHook);
  end;

  TadxWDMessageRetHook = class(TadxMessageRetHook)
  private
    FParent: TadxWDHook;
  protected
    function MessageHookProc(code: longint; wParam, lParam: Cardinal): Longint; override;
  public
    constructor CreateEx(AParent: TadxWDHook);
  end;

  TBeforeCellEditEventHandler = procedure of object;
  TAfterCellEditEventHandler = procedure of object;

  TadxXLHook = class(TadxCustomHook)
  private
    FKeyboardHook: TadxXLKeyBoardHook;
    FMessageHook: TadxXLMessageHook;
    FBeforeCellEdit: TBeforeCellEditEventHandler;
    FAfterCellEdit: TAfterCellEditEventHandler;
    FHostHandle: HWND;
    FMenuActive: boolean;
    FHostVersion: TadxHostVersion;
    FKeyPressed: boolean;
    procedure DoBeforeCellEdit;
    procedure DoAfterCellEdit;
    procedure SetMenuActive(const Value: boolean);
  public
    constructor CreateEx(AHostVersion: TadxHostVersion; AHostHandle: HWND;
      ABeforeCellEdit: TBeforeCellEditEventHandler;
      AAfterCellEdit: TAfterCellEditEventHandler);
    destructor Destroy; override;
    property KeyboardHook: TadxXLKeyBoardHook read FKeyboardHook;
    property MenuActive: boolean read FMenuActive write SetMenuActive;
    property KeyPressed: boolean read FKeyPressed write FKeyPressed;
  end;

  TadxWDHook = class(TadxCustomHook)
  private
    fKeyboardHook: TadxWDKeyBoardHook;
    fMessageHook: TadxWDMessageHook;
    fMessageRetHook: TadxWDMessageRetHook;
    FHostHandle: HWND;
    FMenuActive: boolean;
    FHostVersion: TadxHostVersion;
    procedure SetMenuActive(const Value: boolean);
  public
    constructor CreateEx(AHostVersion: TadxHostVersion; AHostHandle: HWND);
    destructor Destroy; override;
    property KeyboardHook: TadxWDKeyBoardHook read fKeyboardHook;
    property MenuActive: boolean read FMenuActive write SetMenuActive;
  end;

  TadxForm = class;

  TadxFormRegion = class
  private
    FOwner: TadxForm;
    FadxRegionParam: TadxRegionParam;
    FadxlayoutKey: string;
    FSize: longint;
    FState: TadxInternalRegionState;
    function RegistrySave(ARegion: TadxRegionParam): boolean;
    function RegistryLoad(var ARegion: TadxRegionParam): boolean;
    procedure SetState(const Value: TadxInternalRegionState);
  public
    class function GetRegionParam(RegionHandle: HWND; var param: TadxRegionParam; layout: TadxWindowLayout): boolean;
    class function SetRegionParam(RegionHandle: HWND; param: TadxRegionParam; layout: TadxWindowLayout): boolean;
  public
    constructor Create(AOwner: TadxForm);
    procedure Initialize;
    procedure UpdateParam;
    procedure Store(ASize: longint; AState: TadxInternalRegionState);
    property Size: longint read FSize write FSize;
    property State: TadxInternalRegionState read FState write SetState;
    property Owner: TadxForm read FOwner;
  end;

  TadxxCustomEvents = class;

  TadxxEventDispatch = class(TObject, IUnknown, IDispatch)
  private
    FServer: TadxxCustomEvents;
    InternalRefCount: Integer;
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { IDispatch }
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
    function ServerDisconnect: boolean;
  protected
  public
    constructor Create(Server: TadxxCustomEvents);
  end;


  TadxxCustomEvents = class(TComponent, IUnknown)
  private
    FServerData: PServerData;
    FRefCount: Longint;
    FEventDispatch: TadxxEventDispatch;
    FEventsConnection: Longint;
  protected
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; override;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    procedure InitServerData; virtual; abstract;
    procedure ConnectEvents(const Obj: IUnknown);
    procedure DisconnectEvents(const Obj: Iunknown);
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); virtual;
    property ServerData: PServerData read FServerData write FServerData;
    property EventDispatch: TadxxEventDispatch read FEventDispatch write FEventDispatch;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ConnectTo(AIntf: IDispatch); overload; virtual; abstract;
    procedure Disconnect; virtual; abstract;
  published
  end;

  TProtectionControl = class(TControl);

  Globals = class
    class function ContertToRegionState(InternalRegionState: TadxInternalRegionState; default: TadxRegionState): TadxRegionState;
    class function ContertToInternalRegionState(RegionState: TadxRegionState): TadxInternalRegionState;
    class function ContainsADXStrings(whole: string; part: string): boolean;
    class function CompareADXStrings(str1: string; str2: string): boolean;
    class procedure WriteStringsToFile(const FileName, Data: string);
    class function WithoutBackSlash(s: string): string;
    class function GetAppDataFolder: string;
    class function GetTempDir: WideString;
    class function GetLongFileName(Path: string): string;

    class function WM_ADD_ALIEN_FORM: string;
    class function WM_RESIZE_TAB: string;
    class function WM_DELETE_PROC_IN_HOOKS_CHAIN: string;

    class function WM_ADX_SEARCH_WINDOW_ENGINE_SHOW: string;
    class function WM_ADX_SEARCH_WINDOW_ENGINE_HIDE: string;
    class function WM_ADX_WINDOW_ENGINE_HIDE: string;
    class function WM_ADXCLOSEAPPWINDOW: string;
    class function WM_ADXDELETEEMULATEWINDOW: string;
    class function WM_ADXWMIPOSCHANGE: string;
    class function WM_ADXREMOVECONTROLLEDRESIZEWINDOW: string;
    class function WM_ADX_WORDEDITOR_HIDE: string;
    class function WM_ADXEXIST: string;
    class function WM_ADXHIDEALLREGIONFORMS: string;
    class function WM_ADXEXISTSERVICEFORM: string;
    class function WM_ADX_READING_PANE_DIALOG_SHOW: string;
    class function WM_ADX_READING_PANE_DIALOG_HIDE: string;
    class function WM_ADXGETPICTURE: string;
    class function WM_ADXMAYBEWORDVIEWWASCHANGED: string;
    class function WM_ADXSTARTTRANSACTION: string;
    class function WM_ADXENDTRANSACTION: string;
    class function WM_ADXCTP_VISIBLECHANGED: string;
    class function adxMessageResultValue: integer;
    class function CheckADXMessageResult(WindowHandle: HWND;
      Msg: Cardinal; WParam: Integer; LParam: Integer): boolean;
    class function BoolToStr(value: boolean): string;
    class function ADXOLForm(root: boolean): string;
    class function ADXXLForm: string;
    class function ADXWDForm: string;
    class function ADXPPForm: string;
  end;

  APIUtils = class
    class function GetActiveWindow(WindowClass: string): HWND;
  end;

  TadxCursors = class
  private
    FIndex: TCursor;
    FDragValid: TCursor;
    FDragInvalid: TCursor;
    procedure GetCursor(var ACursor: TCursor; ResourceName: string);
    function GetDragInvalid: TCursor;
    function GetDragValid: TCursor;
  public
    property DragValid: TCursor read GetDragValid;
    property DragInvalid: TCursor read GetDragInvalid;
    constructor Create;
    destructor Destroy; override;
  end;

  TadxFormHook = class;

  TadxFormMouseLeave = class(TThread)
  protected
    FMouseLeave: boolean;
    FParent: TadxFormHook;
    FProcessID: Cardinal;
    procedure Execute; override;
    procedure SetMouseLeave(const Value: boolean);
    property MouseLeave: boolean read FMouseLeave write SetMouseLeave;
  public
    constructor CreateEx(AParent: TadxFormHook);
  end;

  TadxFormMessageHook = class(TadxMessageHook)
  protected
    FParent: TadxFormHook;
    function MessageHookProc(code: longint; wParam, lParam: Cardinal): Longint; override;
  public
    constructor CreateEx(AParent: TadxFormHook);
    property Parent: TadxFormHook read FParent;
  end;

  TadxFormMouseHook = class(TadxMouseHook)
  protected
    FParent: TadxFormHook;
    function  MessageHookProc(code: longint; wParam, lParam: Cardinal): Longint; override;
  public
    constructor CreateEx(AParent: TadxFormHook);
    property Parent: TadxFormHook read FParent;
  end;

  TadxFormHook = class
  private
    FFormHandle: Hwnd;
    FContainerHandle: Hwnd;
    FMouseHook: TadxFormMouseHook;
    FMessageHook: TadxFormMessageHook;
    FMouseLeaveThread: TadxFormMouseLeave;
    FInProcess: boolean;
    FMouseCapture: boolean;
    procedure SetMouseCapture(const Value: boolean);
  public
    procedure ContainerHideFloating;
    constructor Create(AContainerHandle: Hwnd; AFormHandle: HWnd; AInProcess: boolean = true);
    destructor Destroy; override;
    property FormHandle: HWnd read FFormHandle;
    property ContainerHandle: Hwnd read FContainerHandle;
    property InProcess: boolean read FInProcess;
    property MouseCapture: boolean read FMouseCapture write SetMouseCapture;
  end;

  TAppHostWindow = class;
  TAppWindow = class;
  TadxContainer = class;
  TadxContainerPane = class;

  TadxForm = class(TForm)
  private
    FNeededRegionState: TadxInternalRegionState;
    FInstanceFocused: boolean;
    FFormID: string;
    FAppWindow: TAppWindow;
    FContainerPane: TadxContainerPane;
    FInjected: boolean;

    FOldColor: TColor;
    FStyleUpdate: boolean;
    FHostHandle: HWND;
    FEmulateWindow: HWND;
    FAppHandle: HWND;
    FLayout: integer;             //TadxLayout;
    FItemType: integer;           //TadxItemType;
    FItemID: TGUID;
    FContainerType: integer;
    FHostVersion: integer;
    FSplitterStyle: integer;
    FAlwaysShowHeader: boolean;
    FSplitButtonVisible: boolean;
    FCloseButtonOnHeader: boolean;
    FRegionBorderStyle: TadxRegionBorderStyle;
    FChildMode: boolean;

    ScreenPos: TWindowPos;

    FVisible: boolean;
    FWindowState: TWindowState;
    VOffset: word;
    FUserHeight: integer;
    FUserWidth:  integer;
    FDefaultWidth: integer;
    FDefaultHeight: integer;
    ActivateEventFlag: boolean;

    UserVisible: boolean;
    FLockVisible: boolean;

    FContainer: TadxContainer;
    FormParam: PadxFormParam;
    FTheme: TadxTheme;
    {$IFNDEF ADX_VCL5}
    FAutoSize: Boolean;
    {$ENDIF}

    FFormHook: TadxFormHook;
    FIconImage: TadxGPBitmap;
    FFormRegion: TadxFormRegion;
    FIsClientLayout: boolean;
    FIsFloating: boolean;
    FBorderStyle: TFormBorderStyle;

    FOnADXDragOverMinimized: TadxDragOverMinimizedEvent;
    FOnADXSplitterMove: TadxSplitterMove;

    procedure AdxInject;
    procedure AdxReject;
    procedure AdxExtract(index: integer);

    function  GetFormID: string;
    function  GetEnableSize: boolean;
    function  GetBorderSides: word; virtual;
    function  GetBorderWidth: integer; virtual;
    function  GetRegionState: TadxRegionState;
    function  GetFutureRegionState: TadxRegionState;
    function  GetRegionBorderSize: integer;
    function  GetUserHeight: integer;
    function  GetUserWidth: integer;
    function  GetCaption: TCaption;
    function  GetIconImage: TadxGPBitmap;
    function  GetFormRegion: TadxFormRegion;
    function  GetVisible: boolean;
    function  GetActive: boolean;
    procedure GetUserSize(var ASize: integer);
    function  GetMinFormOnContainerWhenShowHeader: integer;

    procedure SetVisible(value: boolean);
    procedure SetRegionBorderStyle(const Value: TadxRegionBorderStyle);
    procedure SetUserWidth(const Value: integer);
    procedure SetUserHeight(const Value: integer);
    procedure SetWindowState(value: TWindowState);
    procedure SetLockVisible(value: boolean);
    procedure SetFloatingPos(floatingPos: TWindowPos);
    procedure SetVisibleInThread(VisibleState: boolean); virtual;
    procedure SetFormRegionState(value: TadxInternalRegionState);
    procedure SetRegionState(const Value: TadxRegionState);
    function  SetRegionStateByMessage(ARegionState: TadxRegionState): boolean;
    procedure SetBorderWidth(const Value: integer);
    procedure SetBorderStyle(const Value: TFormBorderStyle);
    procedure SetInstanceFocused(const Value: boolean);
    procedure SetUserSize(ASize: integer);
    procedure SetChildMode(const Value: boolean);

    function  IsHeaderVisible: boolean;
    function  IsSplitterVisible: boolean;
    function  IsDockLayout: boolean;
    function  IsInspectorForm: boolean;
    function  IsExplorerForm: boolean;
    function  IsRedesignSupport(Version: integer): boolean;

    function  EnableMinimizeRegion: boolean;
    procedure UpdateRegion(DestDC: HDC; ARegion: HRGN);
    procedure StoreRegionParam;
    function  VerifyConstrains(MOffset: TPoint): boolean;
    procedure ReleaseFloating;
    procedure HighlightInternal(interval, period: Cardinal);
    procedure CMActivate(var Message: TCMActivate); message CM_ACTIVATE;

    procedure DrawFrame; virtual;
    procedure DrawFrameFloating; virtual;
    procedure IconChanged(Sender: TObject);
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;

    procedure DoAdxDragOverMinimized(params: PadxDragOverMinimizedParams);
    procedure DoBeforeDelete;
    procedure DoInternalActivate;
    procedure DoDeactivate;
    procedure DoNestedActivation(Msg: Cardinal; Control: TWinControl; Form: TCustomForm);
    procedure DoThemeChanged(Sender: TObject);

    procedure ShowOnTop;
    procedure ShowFloating(containerHandle: Hwnd; floatingPos: TWindowPos);
    procedure HideFloating;
    procedure HideOfTop;

    procedure InitFormParamStructure;
    procedure SendMessageToDragContainerWithDragItems(dragContainerHandle: HWND);
    procedure CreateAdxObjectsInstances; virtual;

    property IconImage: TadxGPBitmap read GetIconImage;
    property MinFormOnContainerWhenShowHeader: integer read GetMinFormOnContainerWhenShowHeader;
    property BorderSides: word read GetBorderSides;
    property RegionBorderStyle: TadxRegionBorderStyle read FRegionBorderStyle write SetRegionBorderStyle;
    property RegionBorderSize: integer read GetRegionBorderSize;
    property ItemType: integer read FItemType;
    property HostVersion: Integer read FHostVersion;
    property Container: TadxContainer read FContainer;
    property ContainerPane: TadxContainerPane read FContainerPane;
    property UserHeight: integer read GetUserHeight write SetUserHeight;
    property UserWidth: integer read GetUserWidth write SetUserWidth;
    property EnableSize: boolean read GetEnableSize;
    property InstanceFocused: boolean read FInstanceFocused write SetInstanceFocused;

  protected
    FAppWindowProperty: Pointer;
    function  IsSubstInspectorRegion: boolean; virtual;
    function  GetAppWindowProperty: Pointer;
    function  GetDefaultRegionState: TadxInternalRegionState; virtual;
    procedure GetDragLayoutParams(var AlayoutParams: TadxDragLayoutParams); virtual;
    function  GetBackColor: TColor; virtual;
    function  GetCTPSize: integer;
    function  GetOSCConnected: boolean; virtual;
    procedure UpdateCTPParam(uType: TadxCTPUpdateParamType; ASize: integer); virtual;

    procedure SetDragItems(ADragItems: TList); virtual;
    procedure SetDragForm(AItemType: TAdxItemType; ALayout: TadxWindowLayout); virtual;
    procedure SetCaption(value: TCaption); virtual;
    {$IFNDEF ADX_VCL5}
    procedure SetAutoSize(Value: Boolean); override;
    {$ENDIF}

    procedure DoInstanceFocused(focused: boolean); virtual;
    procedure DoActivate(); virtual;

    function  IsExpandFromMinimizedState: boolean; virtual;
    function  IsDragDropAllowed: boolean; virtual;
    function  IsSupportAdjacentWindow: boolean; virtual;
    procedure ActivateClientLayout;
    procedure HideByManager; overload;
    procedure HideByManager(UsingVisibleProperty: boolean); overload; virtual;
    procedure Paint; override;
    procedure Deactivate; override;
    function  UseOfficeThemeBackColor: boolean; virtual;
    function  RegistryKey: string; virtual;
    function  AdxRegistryKey: string; virtual;
    function  AdxLocalRegistryKey: string; virtual;
    function  AdxLayoutKey: string; virtual;
    function  AdxLockWindowUpdate(HwndLock: HWND): boolean; virtual;

    procedure ConstrainedResize(var MinWidth, MinHeight, MaxWidth, MaxHeight: Integer); override;
    procedure WndProc(var Msg: TMessage); override;
    procedure CreateParams(var params: TCreateParams); override;
    procedure UpdateColor(AHostVersion: TadxHostVersion);
    procedure InitProperties(AAppWindowProperty: Pointer);
    procedure ShowInternal;

    property ChildMode: boolean read FChildMode write SetChildMode;
    property OldColor: TColor read FOldColor;
    property FormRegion: TadxFormRegion read GetFormRegion;
    property HostHandle: HWND read FHostHandle;
    property AppWindow: TAppWindow read FAppWindow;
    property Layout: Integer read FLayout;
    property LockVisible: boolean read FLockVisible write SetLockVisible;
    property Injected: boolean read fInjected;
    property IsClientLayout: boolean read FIsClientLayout;
    property IsFloating: boolean read FIsFloating;
    property FormID: string read GetFormID;
    property OSCConnected: boolean read GetOSCConnected;

  public
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure Activate; override;
    procedure Highlight;
    procedure Hide; virtual;
    procedure Show; overload; virtual;
    function  ShowModal: Integer; override;
    procedure Close;

    constructor Create(AOwner: TComponent); override;
    constructor CreateInstanceForClientLayout;
    destructor  Destroy; override;
    property RegionState: TadxRegionState read GetRegionState write SetRegionState;

  published
    property WindowState: TWindowState read FWindowState write SetWindowState;
    property Visible: boolean read GetVisible write SetVisible;
    property BorderWidth: integer read GetBorderWidth write SetBorderWidth;
    property BorderStyle: TFormBorderStyle read FBorderStyle write SetBorderStyle default bsNone;
    property Active: boolean read GetActive;
    {$IFNDEF ADX_VCL5}
    property AutoSize: Boolean read FAutoSize write SetAutoSize default False;
    {$ENDIF}
    property Caption: TCaption read GetCaption write SetCaption;
    property OnADXDragOverMinimized: TadxDragOverMinimizedEvent read FOnADXDragOverMinimized write FOnADXDragOverMinimized;
    property OnADXSplitterMove: TadxSplitterMove read FOnADXSplitterMove write FOnADXSplitterMove;
  end;

  TadxOlActiveInspectorForms = array [0..5] of TADXForm;

  TadxXLCustomForm = class(TadxForm)
  private
    procedure CreateAdxObjectsInstances; override;
  end;

  TadxWDCustomForm = class(TadxForm)
  private
    procedure CreateAdxObjectsInstances; override;
  end;

  TadxPPCustomForm = class(TadxForm)
  private
    procedure CreateAdxObjectsInstances; override;
  end;

  TadxOLCustomForm = class(TadxForm)
  private
    procedure CreateAdxObjectsInstances; override;
  protected
    function AdxLockWindowUpdate(HwndLock: HWND): boolean; override;
  end;

  TadxOECustomForm = class(TadxForm)
  private
    procedure DrawFrame; override;
    procedure SetVisibleInThread(VisibleState: boolean); override;
    procedure CreateAdxObjectsInstances; override;
  protected
    procedure OffsetFormPosition;
  public
    procedure Hide; override;
    constructor Create(AOwner: TComponent); override;
  end;

  TAppWindowCustom = class
  private
    FHandle: HWND;
    FParent: HWND;
    procedure SetHandle(const Value: HWND); virtual;
  protected
    OldWindowProc: Pointer;
    NewWindowProc: Pointer;
    function MainWndProc(hWnd: THandle; Msg: UINT; wParam, lParam: Longint): Cardinal; stdcall;
    function WndProc(hWnd: THandle; Msg: UINT; wParam, lParam: Longint): Cardinal; virtual;
    property Parent: HWND read FParent write FParent;
  public
    constructor Create;
    destructor Destroy; override;
    property Handle: HWND read FHandle write SetHandle;
  end;

  TAppScrollWindow = class(TAppWindowCustom)
  private
    procedure SetHandle(const Value: HWND); override;
  protected
    function WndProc(hWnd: THandle; Msg: UINT; wParam, lParam: Longint): Cardinal; override;
  public
    constructor CreateEx(AHandle: THandle);
    destructor Destroy; override;
  end;

  TAppHostWindow = class(TAppWindowCustom)
  private
    FOwner: TadxCustomHook;
    FActive: boolean;
    procedure SetHandle(const Value: HWND); override;
    procedure SetActive(const Value: boolean);
  protected
    function WndProc(hWnd: THandle; Msg: UINT; wParam, lParam: Longint): Cardinal; override;
  public
    constructor CreateEx(AOwner: TadxCustomHook);
    destructor Destroy; override;
    property Active: boolean read FActive write SetActive;
  end;

  TAppWindowBehaviour = class;

  TAppNegotiateFunctionCode = (nfcUnknown, nfcAddCustomWindowToTop, nfcReplacePrevWindow, nfcReplaceNextWindow,
    nfcGetReservedRect, nfcPlaceWindowAdjacentToRect, nfcRecalcPaneLayout, nfcGetFullClientArea);

  PAppWindowControllerParam = ^TAppWindowControllerParam;  
  TAppWindowControllerParam = packed record
    FullClientAreaRect: TRect;
    PreviewAreaRect: TRect;
    PrevHandle: HWnd;
    NextHandle: HWnd;
  end;

  TAppWindowController = class
  private
    FAppWindow: TAppWindow;
    FConnected: boolean;
    FContainerPane: TadxContainerPane;
    FRequiredSize: TSize;
    FAppHandle:  HWnd;
    FPaneHandle:  HWnd;
    FPrevHandle: HWnd;
    FNextHandle: HWnd;
    FFullClientAreaRect: TRect;
    FPreviewAreaRect: TRect;
    FSizing: boolean;
  protected
    function DoAddCustomWindowToTop(AHandle: HWnd): longint;
    function DoReplacePrevWindow(AHandle: HWnd): longint;
    function DoReplaceNextWindow(AHandle: HWnd): longint;
    function DoGetReservedRect(lParam: longint): longint;
    function DoPlaceWindowAdjacentToRect(lParam: longint): longint;
    function DoGetFullClientArea(lParam: longint): longint;
    function DoWindowPosChanging(lParam: longint): longint;
    function DoRecalcPaneLayout: longint;
    function GetActive: boolean;
  public
    procedure RecalcPreviewPaneLayout;
    procedure SwapController(swapHandle: HWND; wParam: longint; lParam: PAppWindowControllerParam);
    function HandleMessage(msg: cardinal; wParam, lParam: longint): longint;
    function Connect: boolean;
    function Disconnect: boolean;
    constructor Create(AppWindow: TAppWindow; ContainerPane: TadxContainerPane);
    destructor Destroy; override;
    property Active: boolean read GetActive;
  end;

  TAppWindow = class(TAppWindowCustom)
  private
    FOwner: TadxForm;
    FClipStyles: longint;
    MainPos: TWindowPos;
    ScreenPos: TWindowPos;
    OldScreenPos: TWindowPos;
    FOnNegotiateWindowMessage: TadxMessageHandler;
    function  GetOwner: TadxForm;
    {$IFDEF SupportAdjacentWindow}
    function  DoNegotiateWindowMessage(msg: Cardinal; wParam, lParam: longint): longint;
    {$ENDIF}
    procedure SetOwner(const Value: TadxForm);
    procedure ResizeTaskPane;
    function  GetAppWindowProperty: Pointer;
    function  GetPane: TadxContainerPane;
    procedure InitMainPos;
    function  SwapWndProc(newProc, oldProc: Pointer): boolean;
    procedure IntSwapWndProc;
    procedure RestoreWndProc;
  protected
    function  WndProc(hWnd: THandle; Msg: UINT; wParam, lParam: Longint): Cardinal; override;
    procedure SetClippingStyle;
    procedure RestoreClippingStyle;
  public
    constructor CreateEx(AOwner: TadxForm);
    procedure AdxRefresh;
    property Owner: TadxForm read GetOwner write SetOwner;
    property AppWindowProperty: Pointer read GetAppWindowProperty;
    property Pane: TadxContainerPane read GetPane;
  end;

  TAppWindowBehaviour = class
  protected
    procedure WM_PARENTNOTIFY_DESTROY(hWnd: THandle; Msg: UINT; wParam, lParam: Longint; appWindow: TAppWindow); virtual;
    procedure WM_SHOWWINDOW_HIDE(hWnd: THandle; Msg: UINT; wParam, lParam: Longint; appWindow: TAppWindow); virtual;
    procedure WM_SHOWWINDOW_SHOW(hWnd: THandle; Msg: UINT; wParam, lParam: Longint; appWindow: TAppWindow); virtual;
    procedure WM_DESTROY(hWnd: THandle; Msg: UINT; wParam, lParam: Longint; appWindow: TAppWindow); virtual;
    procedure SHOW_WHEN_WINDOWPOSCHANGING(appWindow: TAppWindow); virtual;
    procedure HIDE_WHEN_WINDOWPOSCHANGING(appWindow: TAppWindow); virtual;
  public
    class procedure SetSingleton(AAppWindowBehaviour :TAppWindowBehaviour);
    class function GetSingleton: TAppWindowBehaviour;
    class procedure HideAllFormsInAllAddins(WindowHandle: HWND);
    class procedure SingletonFree;
  end;

  TCustomCheckHandle = function(Handle: HWND): boolean of object;

  TFindWindowObject = class
  private
    FHostVersion: TadxHostVersion;
  protected
    function CheckWindowTrue(Handle: HWND): boolean;

    function IsWindowVisibleAndMorePixel(WindowHandle: HWND): boolean;
    function InternalFindChildWindow(HWNDParent: HWND; WindowName: string; WindowClass: string; ExcludeChildWindowClass: string; detail: boolean; Condition: TadxFindWindowConditions): HWND;
    function InternalFindChildWindowWithControlID(HWNDParent: HWND; WindowName: string; WindowClass: string; ExcludeChildWindowClass: string; detail: boolean; AControlID: integer; FindVisibleWindow: boolean): HWND; overload;
    function InternalFindChildWindowWithControlID(HWNDParent: HWND; WindowName: string; WindowClass: string; ExcludeChildWindowClass: string; detail: boolean; AControlID: integer; FindVisibleWindow: boolean; CustomCheckHandleProc: TCustomCheckHandle): HWND; overload;

    function MustVisible(Condition: TadxFindWindowConditions): boolean;
    function FindChildWindowV(HWNDParent: HWND; WindowName: string; WindowClass: string;
      ExcludeChildWindowClass: string; detail: boolean; FindVisibleWindow: boolean): HWND; overload;

    function FindIn2000(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; virtual; abstract;
    function FindIn2002(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; virtual; abstract;
    function FindIn2003(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; virtual; abstract;
    function FindIn2007(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; virtual; abstract;
    function FindIn2010(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; virtual; abstract;
  public
    function Find(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; overload; virtual;
    constructor Create(AHostVersion: TadxHostVersion);
    destructor Destroy; override;
  end;

  TFindWindowFactory = class
  public
    function CreateSpecificFindWindowObject(ItemType: TadxItemType): TFindWindowObject; virtual;
    class function CreateFindWindowObject(ItemType: TadxItemType): TFindWindowObject;
    class procedure SetSingleton(AFindWindowFactory: TFindWindowFactory);
    class function GetSingleton: TFindWindowFactory;
    class procedure SingletonFree;
  end;

  TadxVisibleChange = procedure(AVisible: boolean; Sender: TObject) of object;

  TadxWndInfo = record
    handle: HWND;
    x, y, cx, cy: integer;
  end;

  TSplitterStyle = integer;

  TadxMenuItem = class(TMenuItem)
  private
    FContainerPane: TadxContainerPane;
    FFont: TFont;
    procedure UpdateFont;
  protected
    procedure AdvancedDrawItem(ACanvas: TCanvas; ARect: TRect;
      State: TOwnerDrawState; TopLevel: Boolean); override;
{$IFDEF ADX_VCL5}
    procedure MeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
{$ELSE}
    procedure MeasureItem(ACanvas: TCanvas; var Width, Height: Integer); override;
{$ENDIF}
  public
    constructor CreateEx(AContainerPane: TadxContainerPane; AOwner: TComponent);
    destructor Destroy; override;
  end;

  TadxContextMenu = class(TPopupMenu)
  private
    FContainerPane: TadxContainerPane;
    procedure UpdateItems(adxContainer: TadxContainer; adxForm: TadxForm);
    procedure ItemClick(Sender: TObject);
  public
    constructor CreateEx(AContainerPane: TadxContainerPane);
  end;

  TadxPanePart = class;
  TadxPaneLayout = (plVertical, plHorizontal);
  TadxPanePartClass = class of TadxPanePart;

  TadxSplitterRuler = class
  private
    OldPos: TPoint;
    FClipRect: TRect;
    FMoveRect: TRect;
    FMouseDown: boolean;
    FSplitMove: boolean;
    FSplitMotion: TadxSplitMotion;
    FSplitterDragging: boolean;
    FDownPos: TPoint;
    FBounds: TRect;
    FOwner: TadxContainerPane;
    function  VerifyConstrains(ASplitPos: TPoint): boolean;
    procedure DoMouseDown(Param: integer; MousePt: TPoint);
    procedure DoMouseMove(Param: integer; MousePt: TPoint);
    procedure DoMouseUp(Param: integer; MousePt: TPoint);
    constructor Create(AOwner: TadxContainerPane; ASplitBounds: TRect);
  end;

  TadxHighlightTimer = class;

  TadxHighlightController = class
  private
    FOwner: TadxContainerPane;
    FFormHandle: HWnd;
    FStartTickCount: Cardinal;
    FInterval: Cardinal;
    FPeriod: Cardinal;
    FTimer: TadxHighlightTimer;
    FIsStoped: boolean;
    procedure StartTimer;
    procedure StopTimer;
  public
    procedure Initialize(blinkParam: TadxBlinkParam);
    procedure OnTimer(sender: TObject);
    constructor Create(AOwner: TadxContainerPane);
    destructor Destroy; override;
    property FormHandle: HWnd read FFormHandle write FFormHandle;
    property IsStoped: boolean read fIsStoped;
  end;

  TadxHighlightTimer = class(TThread)
  private
    procedure SetInterval(const Value: Cardinal);
  protected
    FOnTimer: TNotifyEvent;
    FInterval: Cardinal;
    procedure Execute; override;
  public
    constructor CreateEx(Interval: Cardinal);
    destructor Destroy; override;
    property Interval: Cardinal read FInterval write SetInterval;
    property OnTimer: TNotifyEvent read FOnTimer write FOnTimer;
  end;

  TadxContainerPane = class(TadxTheme, IDropTarget)
  private
    ListControl: TadxContextMenu;
    ScreenPos: TWindowPos;

    FContainer: TadxContainer;
    FAdxControl: TadxForm;
    FVisible: boolean;
    FAppWindow: TAppWindow;
    {$IFDEF SupportAdjacentWindow}
    FAppController: TAppWindowController;
    {$ENDIF}
    FFloatingFormHandle: Hwnd;
    FDragContainer: TadxRegionDragContainer;
    FLastDataObject: IDataObject;
    FDragSelectedPart: TAdxPanePart;
    FTempFormHandle: HWND;
    FHeaderHeight: integer;
    FOptions: TadxTaskPaneOptions;
    FPreset: TadxTaskPanePreset;
    FTaskCaption: TCaption;
    FUpdateCount: integer;
    FCanvasChanged: boolean;
    FNeedResize: boolean;
    FIsMouseTracking: Boolean;
    FDragMousePos: TPoint;
    FDelayBeforeDrag: integer;
    FMainParts: TadxPanePart;
    FSelectedPart: TadxPanePart;
    FSplitterRuler: TadxSplitterRuler;
    FSplitterMove: TPoint;
    FStartIndex: integer;
    FBitmap: TadxGPBitmap;
    FGradientBitmap: TadxGPBitmap;
    FHostVersion: TadxHostVersion;
    FHighLighController: TadxHighlightController;
    FHighlighted: boolean;
    FPaintMutex: Cardinal;

    // IDropTarget
    function DragEnter(const dataObj: IDataObject; grfKeyState: Longint;
                       pt: TPoint; var dwEffect: Longint): HResult; stdcall;
    function DragOver (grfKeyState: Longint; pt: TPoint;
                       var dwEffect: Longint): HResult;  reintroduce; stdcall;
    function DragLeave: HResult; stdcall;
    function Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
                  var dwEffect: Longint): HResult; stdcall;
    // IUnknown
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    procedure BeginUpdate;
    procedure EndUpdate;
    procedure HighlightRequest(BlinkParam: PadxBlinkParam);
    procedure CanvasChanged;
    procedure NeedResize;

    procedure SetVisible(value: boolean);
    procedure SetFloatingFormHandle(const Value: Hwnd);
    procedure SetDragSelectedPart(const Value: TAdxPanePart);
    procedure SetItemsList;
    //procedure SetItemCaption (param: PadxFormParam; NewCaption: string);
    procedure SetSelectedPart(const Value: TadxPanePart);
    procedure SetTaskCaption(Avalue: TCaption);
    procedure SetHeaderHeight(AValue: Integer );
    procedure SetPreset(AValue: TadxTaskPanePreset);
    procedure SetOptions(AValue: TadxTaskPaneOptions);
    procedure SetStartIndex(const Value: integer);
    procedure SetMouseCursor(ACursor: TCursor);
    procedure SetSplitterMove(X, Y: integer);
    procedure SetUserHeight(const Value: integer);
    procedure SetUserWidth(const Value: integer);
    procedure SetHighlighted(const Value: boolean);

    function  GetTaskButtonHeight: integer; virtual;
    function  GetTaskButtonWidth: integer; virtual;
    function  GetTaskButtonOffset: integer; virtual;
    function  GetTaskIconHeight: integer;
    function  GetTaskIconWidth: integer;
    function  GetTaskMenuItemHeight: integer; virtual;
    function  GetHeaderHeight: Integer; virtual;
    function  GetSplitterDepth: TadxSplitterDepth; virtual;
    function  GetItemTextSize(Index: integer): TSize;
    function  GetPositionInZOrder: LongWord; virtual;
    function  GetPaneLayout: TadxPaneLayout;
    function  GetFormLayout: integer;
    function  GetFormItemType: integer;
    function  GetRegionBorderSize: integer;
    function  GetPaneItems: TList;
    function  GetPaneItem(Index: integer): PadxContainerForm;
    function  GetHeaderHeightMin: Integer;
    function  GetPreset: TadxTaskPanePreset; virtual;
    function  GetPaneOffset: TRect; virtual;
    function  GetMouseCursorPos: TPoint;
    function  GetClipRect: TRect;
    function  GetSplitMotion: TadxSplitMotion; virtual;
    function  GetUserHeight: integer;
    function  GetUserWidth: integer;
    procedure GetUserSize(var ASize: integer);
    procedure GetRequiredSize(var ASize: TSize; RecalcArea: boolean);

    procedure HostEnableWindow(AEnabled: Boolean); virtual;
    function  ScaledButtonHeight: integer; virtual;
    function  CreatePainter: TadxPanePart;
    procedure CreateSplitterRuler(SplitBounds: TRect);

    procedure RecreateParts(AWidth, AHeight: integer);
    procedure RecalcScreenPosition;

    function  ConnectController: boolean;
    procedure DisconnectController;
    procedure SwapController(swapHandle: HWND; oper: integer; param: Pointer);
    procedure OffsetPanePosition; virtual;
    procedure UpdateFormPosition(ABounds: TRect);
    procedure UpdateAppScrollBar; virtual;
    //procedure UpdateHighlight(HLFormHandle: HWnd);
    procedure ResetHighlight(HLFormHandle: HWnd);
    procedure UpdateGradientBitmap(ARect: TRect);
    procedure SyncAdxRefresh;
    function  AdxLockWindowUpdate(HwndLock: HWND): boolean; virtual;
    function  ShowFormFloating(formHandle: HWND): boolean;
    procedure ContainerRefresh(rfKind: TadxRefreshKind; SendRequest: boolean; FormHandle: HWnd);

    function  IsMinimizedState: boolean;
    function  IsHiddenState: boolean;
    function  IsNormalState: boolean;
    function  IsHeaderVisible: boolean;
    function  IsSplitterVisible: boolean;
    function  IsSplitButtonVisible: boolean;
    function  IsClientLayout: boolean;
    function  IsActiveIndex(index: integer): boolean;
    function  IsItemHighlight(index: integer): boolean;
    function  IsRedesignSupport(Version: integer): boolean;
    function  IsSplitterHighlight: boolean;
    function  IsHeaderHighlight: boolean;

    function  EnableClose: boolean;
    function  EnableNavigation: boolean;
    function  EnableScroll(next: boolean): boolean;
    function  EnableMinimize: boolean;
    function  EnableMinimizeRegion: boolean;
    function  EnableIcon(index: integer): boolean;
    function  EnableSplitterResize: boolean;

    procedure DoActionSelectBack(Sender: TObject);
    procedure DoActionSelectNext(Sender: TObject);
    procedure DoActionMenuOpen(Sender: TObject);
    procedure DoActionCloseForm(Sender: TObject);
    procedure DoActionShowForm(Sender: TObject);
    procedure DoActionMinimize(Sender: TObject);
    procedure DoActionHide(Sender: TObject);
    procedure DoActionDraggingForm(MouseOffset: TPoint);
    procedure DoActionStopDragging;
    procedure DoResize;
    procedure DoThemeChanged; override;

    procedure DrawBackGround(ACanvas: TadxGPGraphics; ARect: TRect; mode: TDrawMode); virtual;
    procedure DrawBackGroundColor(ACanvas: TadxGPGraphics; ARect: TRect; AColor: Cardinal);
    procedure DrawPane(ACanvas: TadxGPGraphics; ARect: TRect; mode: TDrawMode; Depth: integer); overload;
    procedure DrawPane(ACanvas: TadxGPGraphics; ARect: TRect); overload;
    procedure DrawPaneMinimize(ACanvas: TadxGPGraphics; ARect: TRect; mode: TDrawMode; Depth: integer); virtual;
    procedure DrawPaneButton(ACanvas: TadxGPGraphics; BtnRect: TRect; presset: TadxTaskPanePreset; BtnImage: integer; state: TadxTaskPaneButtonState; style: TAlign);
    procedure DrawPaneText(ACanvas: TadxGPGraphics; ARect: TRect; AText: string; state: TadxTaskPaneButtonState);
    procedure DrawPaneTextIndex(ACanvas: TadxGPGraphics; ARect: TRect; Index: integer; state: TadxTaskPaneButtonState);
    procedure DrawPaneButtonFrame(ACanvas: TadxGPGraphics; ARect: TRect; state: TadxTaskPaneButtonState); virtual;
    procedure DrawPaneFrame(ACanvas: TadxGPGraphics; Rect: TRect; Depth: integer; mode: TDrawMode); virtual;
    procedure DrawBorder(ACanvas: TadxGPGraphics; Rect: TRect; Depth: integer); virtual;
    procedure DrawIcon(ACanvas: TadxGPGraphics; ARect: Trect);
    procedure DrawIconIndex(ACanvas: TadxGPGraphics; ARect: Trect; Index: integer);
    procedure DrawSeparator(ACanvas: TadxGPGraphics; ARect: Trect);
    procedure DrawSplitter(ACanvas: TadxGPGraphics; ARect: TRect); virtual;
    function  DrawCTPBackground(ACanvas: TadxGPGraphics; ARect: TRect): boolean;
    function  DrawGradient(ACanvas: TadxGPGraphics; ARect: TRect): boolean;
    procedure DrawSplitterButton(ACanvas: TadxGPGraphics; ARect: TRect; state: TadxTaskPaneButtonState);
    procedure DrawMoveSplitter(APos: TPoint; ARect: TRect; MoveSplitter: boolean);
    procedure DrawMenuItem(dc: HDC; AMenuItem: TMenuItem; ARect: TRect; State: TOwnerDrawState);

    procedure WMSetCursor(var Message: TWMSetCursor); Message WM_SETCURSOR;
    procedure WMLButtonDown(var Message: TWMLButtonDown); Message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); Message WM_LBUTTONDBLCLK;
    procedure WMLButtonUp(var Message: TWMLButtonUp); Message WM_LBUTTONUP;
    procedure WMEraseBkgnd( var Message: TWMEraseBkgnd ); Message WM_ERASEBKGND;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMMouseLeave(var Msg: TMessage); message WM_MOUSELEAVE;
    procedure WMWindowPosChanging(var Msg: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
    procedure CMCursorChanged(var Message: TMessage); message CM_CURSORCHANGED;

    property  PositionInZOrder: LongWord read GetPositionInZOrder;
    property  FloatingFormHandle: Hwnd read FFloatingFormHandle write SetFloatingFormHandle;
    property  DragSelectedPart: TAdxPanePart read FDragSelectedPart write SetDragSelectedPart;

    property  SelectedPart: TadxPanePart read FSelectedPart write SetSelectedPart;
    property  TaskButtonHeight: integer read GetTaskButtonHeight;
    property  TaskButtonWidth: integer read GetTaskButtonWidth;
    property  TaskButtonOffset: integer read GetTaskButtonOffset;
    property  TaskIconWidth: integer read GetTaskIconWidth;
    property  TaskIconHeight: integer read GetTaskIconHeight;
    property  TaskMenuItemHeight: integer read GetTaskMenuItemHeight;
    property  TaskCaption: TCaption read FTaskCaption write SetTaskCaption;
    property  HeaderHeight: Integer read GetHeaderHeight write SetHeaderHeight;
    property  HeaderHeightMin: Integer read GetHeaderHeightMin;
    property  SplitterDepth: TadxSplitterDepth read GetSplitterDepth;
    property  RegionBorderSize: integer read GetRegionBorderSize;
    property  SplitterMove: TPoint read FSplitterMove;
    property  Preset: TadxTaskPanePreset read GetPreset write SetPreset;
    property  Options: TadxTaskPaneOptions read FOptions write SetOptions;
    property  PaneOffset: TRect read GetPaneOffset;
    property  PaneLayout: TadxPaneLayout read GetPaneLayout;
    property  FormLayout: integer read GetFormLayout;
    property  FormItemType: integer read GetFormItemType;
    property  PaneItems: TList read GetPaneItems;
    property  StartIndex: integer read FStartIndex write SetStartIndex;
    property  UserWidth: integer read GetUserWidth write SetUserWidth;
    property  UserHeight: integer read GetUserHeight write SetUserHeight;
    property  Highlighted: boolean read FHighlighted write SetHighlighted;

  protected
    procedure WndProc(var Message: TMessage); override;
    procedure Paint; override;
    procedure PaintBitmap(AWidth, AHeight: integer);
    procedure PaintTo(DestDC: HDC; X, Y: integer);

  public
    procedure Initialize(AppVersion: integer; ItemType: integer; AHostHandle: HWND); override;
    procedure Show;
    procedure Hide;
    constructor CreateEx(AContainer: TadxContainer);
    destructor Destroy; override;
    property  Visible: boolean read FVisible write SetVisible;
    property  AdxControl: TadxForm read FAdxControl;
  end;

  TadxXLContainerPane = class(TadxContainerPane)
  private
    procedure HostEnableWindow(AEnabled: Boolean); override;
    function  GetPaneOffset: TRect; override;
    function  GetPositionInZOrder: LongWord; override;
    procedure OffsetPanePosition; override;
    procedure DrawSplitter(ACanvas: TadxGPGraphics; ARect: TRect); override;
    procedure DrawPaneFrame(ACanvas: TadxGPGraphics; ARect: TRect; Depth: integer; mode: TDrawMode); override;
  protected
    function  GetAdxThemeColorClass: TadxThemeColorClass; override;
  public
    procedure Initialize(AppVersion: integer; ItemType: integer; AHostHandle: HWND); override;
  end;

  TadxOLContainerPane = class(TadxContainerPane)
  private
    function  GetPositionInZOrder: LongWord; override;
    function  GetPaneOffset: TRect; override;
    function  GetPreset: TadxTaskPanePreset; override;
    function  AdxLockWindowUpdate(HwndLock: HWND): boolean; override;
    procedure DrawBackGround(ACanvas: TadxGPGraphics; ARect: TRect; mode: TDrawMode); override;
    procedure DrawBorder(ACanvas: TadxGPGraphics; Rect: TRect; Depth: integer); override;
    procedure DrawPaneFrame(ACanvas: TadxGPGraphics; Rect: TRect; Depth: integer; mode: TDrawMode); override;
    procedure UpdateAppScrollBar; override;
  protected
    procedure WndProc(var Message: TMessage); override;
  end;

  TadxWDContainerPane = class(TadxContainerPane)
  private
    function  GetPaneOffset: TRect; override;
    procedure DrawSplitter(ACanvas: TadxGPGraphics; ARect: TRect); override;
    procedure DrawBorder(ACanvas: TadxGPGraphics; Rect: TRect; Depth: integer); override;
    procedure DrawPaneFrame(ACanvas: TadxGPGraphics; ARect: TRect; Depth: integer; mode: TDrawMode); override;
    function GetPositionInZOrder: LongWord; override;
  protected
    function  GetAdxThemeColorClass: TadxThemeColorClass; override;
    procedure WndProc(var Message: TMessage); override;

  public
    procedure Initialize(AppVersion: integer; ItemType: integer; AHostHandle: HWND); override;
  end;

  TadxPPContainerPane = class(TadxContainerPane)
  private
    function GetPaneOffset: TRect; override;
    function GetPositionInZOrder: LongWord; override;
    procedure DrawSplitter(ACanvas: TadxGPGraphics; ARect: TRect); override;
    procedure DrawPaneFrame(ACanvas: TadxGPGraphics; ARect: TRect; Depth: integer; mode: TDrawMode); override;
  protected
    function GetAdxThemeColorClass: TadxThemeColorClass; override;
  public
    procedure Initialize(AppVersion: integer; ItemType: integer; AHostHandle: HWND); override;
  end;

  TadxOEContainerPane = class(TadxContainerPane)
  private
    function  GetPositionInZOrder: LongWord; override;
    function  GetTaskButtonHeight: integer; override;
    function  GetTaskButtonWidth: integer; override;
    function  GetTaskButtonOffset: integer; override;
    function  ScaledButtonHeight: integer; override;
    procedure OffsetPanePosition; override;
    procedure DrawPaneFrame(ACanvas: TadxGPGraphics; ARect: TRect; Depth: integer; mode: TDrawMode); override;
    procedure DrawPaneButtonFrame(ACanvas: TadxGPGraphics; ARect: TRect; state: TadxTaskPaneButtonState); override;
  protected
    function  GetDPIratio: single; override;
  public
    procedure Initialize(AppVersion: integer; ItemType: integer; AHostHandle: HWND); override;
  end;

  TadxContainerGetPictures = class(TThread)
  protected
    FOwner: TadxContainer;
    FFormHandle: HWnd;
    function GetPictureFromHandle(AHandle: HWnd): TadxGPImage;
    procedure Execute; override;
  public
    constructor CreateEx(AOwner: TadxContainer; AFormHandle: Hwnd);
  end;

  TadxContainer = class(TList)
  private
    FMutex: THandle;
    FOwner: TadxForm;
    function  GetPictureFromHandle(AHandle: HWnd): TadxGPImage;
    {$IFDEF UNICODE}
    function GetCaptionFromHandle(AHandle: HWnd): TadxUnicodeCaption;
    {$ELSE}
    function GetCaptionFromHandle(AHandle: HWnd): TadxCaption;
    {$ENDIF}
    function  ExistClientLayout: boolean;
    function  ActivateClientLayout: boolean;
    function  ExistCompleteRegions: boolean;
    function  GetIndex(param: PadxFormParam): integer; overload;
    function  GetIndex(FormHandle: HWnd): integer; overload;
    function  GetOwner: TadxForm;
    function  BeginRequired: boolean;
    procedure EndRequired;
    procedure SetOwner(const Value: TadxForm);
    procedure AddForm(param: PadxFormParam);
    procedure DeleteForm(param: PadxFormParam);
    procedure MoveList(PListArr: PadxFormParamList; CountMove: word); //PPointerList
    procedure UpdateParam(param: PadxFormParam);
    procedure ClearListForm;
    procedure HideAllForm;
    procedure Refresh(rfKind: TadxRefreshKind; FormHandle: Hwnd);
    procedure UpdatePictures(FormHandle: Hwnd);
    property  Owner: TadxForm read GetOwner write SetOwner;
  public
    constructor CreateEx(AOwner: TadxForm);
    destructor Destroy; override;
  end;

  TadxPanePart = class
  private
    FParts: TList;
    FOwner: TadxContainerPane;
    FParent: TadxPanePart;
    FBounds: TRect;
    FState: TadxTaskPaneButtonState;
    FFixedState: TadxTaskPaneButtonState;
    FPriority: integer;
    FFloating: boolean;
    FBoundsOffsetWidth: integer;
    FBoundsOffsetHeight: integer;
    FDefaultHeight: integer;
    FDefaultWidth: integer;
    FIntervalOffset: integer;
    FOnClick: TNotifyEvent;
    FEnableDrag: boolean;
    FOnDblClick: TNotifyEvent;
    FDisposed: boolean;
    function  GetParts(index: integer): TadxPanePart;
    function  IndexOf: integer; virtual;
    function  GetWidth: integer;
    function  GetHeight: integer;
    function  GetFloating: boolean;
    function  Disabled: boolean; virtual;
    function  DefaultHeight: integer; virtual;
    function  DefaultWidth: integer; virtual;
    function  RequiredWidth: integer; virtual;
    function  FindPart(ACursorPos: TPoint): TadxPanePart; virtual;
    function  UpdateState(ACursorPos: TPoint; AState: TadxTaskPaneButtonState): boolean;
    procedure ResetState(AState: TadxTaskPaneButtonState; current: TadxPanePart; detail: boolean = false);
    procedure SetState(const Value: TadxTaskPaneButtonState); virtual;
    procedure GetDefaultSize(var AWidth: integer; var AHeight: integer);
    procedure GetRequiredSize(var AWidth: integer; var AHeight: integer); virtual;
    procedure Initialize; virtual;
    procedure CreateParts; virtual;
    procedure DeleteParts;
    function  NeedRemove: boolean; virtual;
    procedure UpdateBounds; virtual;
    procedure UpdateRegion(ARegion: TadxGPRegion; X, Y: integer); virtual;
    procedure SetBounds(const Value: TRect);
    function  AddPart(ClassPart: TadxPanePartClass; Priority: integer): TadxPanePart; overload;
    function  AddPart(Part: TadxPanePart): TadxPanePart; overload;
    procedure Paint(ACanvas: TadxGPGraphics); virtual;
    procedure DoMouseUp(sender: TObject; Param: integer; MousePt: TPoint); virtual;
    procedure DoMouseDown(sender: TObject; Param: integer; MousePt: TPoint); virtual;
    procedure DoMouseHover(sender: TObject; Param: integer; MousePt: TPoint); virtual;
    procedure DoMouseDblClick(sender: TObject; Param: integer; MousePt: TPoint); virtual;
    property  Parts[index: integer]: TadxPanePart read GetParts;
    property  Owner: TadxContainerPane read FOwner;
    property  Bounds: TRect read FBounds write SetBounds;
    property  State: TadxTaskPaneButtonState read FState write SetState;
    property  Priority: integer read FPriority;
    property  EnableDrag: boolean read FEnableDrag;
    property  Floating: boolean read GetFloating;
  public
    procedure DrawFrame(ACanvas: TadxGPGraphics);
    constructor Create(AOwner: TadxContainerPane; AParent: TadxPanePart; APriority: integer); virtual;
    destructor Destroy; override;
    property  Width: integer read GetWidth;
    property  Height: integer read GetHeight;
    property  OnClick: TNotifyEvent read FOnClick write FOnClick;
    property  OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
  end;

  TadxPanePartButton = class(TadxPanePart)
  private
    FPaneButton: TadxTaskPaneButton;
    procedure Initialize; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  end;

  TadxPanePartDots = class(TadxPanePart)
  private
    procedure Initialize; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  end;

  TadxPanePartIcon = class(TadxPanePart)
  private
    procedure Initialize; override;
    function  Disabled: boolean; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  end;

  TadxPanePartIconPlace = class(TadxPanePart)
  private
    procedure Initialize; override;
    procedure CreateParts; override;
  end;

  TadxPanePartBackButton = class(TadxPanePartButton)
  private
    procedure Initialize; override;
    function  Disabled: boolean; override;
  end;

  TadxPanePartNextButton = class(TadxPanePartButton)
  private
    procedure Initialize; override;
    function  Disabled: boolean; override;
  end;

  TadxPanePartCloseButton = class(TadxPanePartButton)
  private
    procedure Initialize; override;
  end;

  TadxPanePartMinimizeButton = class(TadxPanePartButton)
  private
    procedure Initialize; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  end;

  TadxPanePartNavigateButtons = class(TadxPanePart)
  private
    procedure Initialize; override;
    procedure CreateParts; override;
  end;

  TadxPanePartMenuButton = class(TadxPanePartButton)
  private
    procedure Initialize; override;
  end;

  TadxPanePartCaption = class(TadxPanePart)
  private
    procedure Initialize; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  end;

  TadxPanePartMenuAndCaption = class(TadxPanePartButton)
  private
    procedure Initialize; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  end;

  TadxPanePartMenuAndCaptionEx = class(TadxPanePart)
  private
    procedure SetState(const Value: TadxTaskPaneButtonState); override;
    function  FindPart(ACursorPos: TPoint): TadxPanePart; override;
    procedure Initialize; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
    procedure CreateParts; override;
  end;

  TadxPanePartSeparator = class(TadxPanePart)
  private
    procedure Initialize; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  end;

  TadxPanePartGalleryItems = class;

  TadxPanePartGallery = class(TadxPanePart)
  private
    FGalleryItems: TadxPanePartGalleryItems;
    procedure Initialize; override;
    procedure CreateParts; override;
  end;

  TadxPanePartGalleryItems = class(TadxPanePart)
  private
    FStartIndex: integer;
    FEndIndex: integer;

    procedure UpdateBounds_1;
    procedure UpdateBounds; override;
    function  DefaultWidth: integer; override;
    procedure Initialize; override;
    procedure CreateParts; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  end;

  TadxPanePartGalleryItem = class(TadxPanePart)
  private
    FCurrentItemIndex: integer;
    procedure Initialize; override;
    function  IndexOf: integer; override;
    function  DefaultWidth: integer; override;
    function  FindPart(ACursorPos: TPoint): TadxPanePart; override;
    procedure CreateParts; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
    procedure SetCurrentItemIndex(const Value: integer);
    property  CurrentItemIndex: integer read FCurrentItemIndex write SetCurrentItemIndex;
  end;

  TadxPanePartGalleryItemCaption = class(TadxPanePart)
  private
    procedure Initialize; override;
    function  RequiredWidth: integer; override;
    procedure GetRequiredSize(var AWidth: integer; var AHeight: integer); override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  end;

  TadxPanePartGalleryItemIcon = class(TadxPanePart)
  private
    procedure Initialize; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  end;

  TadxPanePartGalleryButtonBack = class(TadxPanePart)
  private
    procedure DoAction(Sender: TObject);
    procedure Initialize; override;
    function  NeedRemove: boolean; override;
    function  DefaultWidth: integer; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  end;

  TadxPanePartGalleryButtonNext = class(TadxPanePart)
  private
    procedure DoAction(Sender: TObject);
    procedure Initialize; override;
    function  DefaultWidth: integer; override;
    function  NeedRemove: boolean; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  end;

  TadxPanePartHeaderOlder = class(TadxPanePart)
  private
    procedure Initialize; override;
    procedure CreateParts; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  end;

  TadxPanePartHeader = class(TadxPanePart)
  private
    procedure Initialize; override;
    procedure CreateParts; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  public
    destructor Destroy; override;
  end;

  TadxPanePartSplitterButton = class(TadxPanePart)
  private
    procedure Paint(ACanvas: TadxGPGraphics); override;
    procedure DoMouseHover(sender: TObject; Param: integer; MousePt: TPoint); override;
    procedure Initialize; override;
  end;

  TadxPanePartSplitter = class(TadxPanePart)
  private
    FSplitterButton: TadxPanePartSplitterButton;
    function  FindPart(ACursorPos: TPoint): TadxPanePart; override;
    procedure SetState(const Value: TadxTaskPaneButtonState); override;
    procedure DoMouseHover(sender: TObject; Param: integer; MousePt: TPoint); override;
    procedure DoMouseDown(sender: TObject; Param: integer; MousePt: TPoint); override;
    procedure DoMouseDblClick(sender: TObject; Param: integer; MousePt: TPoint); override;
    procedure Initialize; override;
    procedure CreateParts; override;
    procedure UpdateBounds; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  public
    destructor Destroy; override;
  end;

  TadxPanePartFormArea = class(TadxPanePart)
  private
    FClientBounds: TRect;
    function  FindPart(ACursorPos: TPoint): TadxPanePart; override;
    procedure Initialize; override;
    procedure UpdateBounds; override;
    procedure UpdateRegion(ARegion: TadxGPRegion; X, Y: integer); override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
    property  ClientBounds: TRect read FClientBounds;
  public
    destructor Destroy; override;
  end;

  TadxPanePartMain = class(TadxPanePart)
  private
    FFormAreaPart: TadxPanePart;
    FSplitterPart: TadxPanePart;
    FHeaderPart:   TadxPanePart;
    procedure Initialize; override;
    procedure CreateParts; override;
    procedure UpdateBounds; override;
    procedure Paint(ACanvas: TadxGPGraphics); override;
  end;

type
  TadxContainerClass = class of TadxContainer;
  TadxThemeClass = class of TadxTheme;
  TadxFormRegionClass = class of TadxFormRegion;

  PadxObjectsClasses = ^TadxObjectsClasses;
  TadxObjectsClasses = record
    ContainerClass: TadxContainerClass;
    ThemeClass: TadxThemeClass;
    FormsRegionClass: TadxFormRegionClass;
  end;


  TBitmapParam = packed record
    handle: HBITMAP;
    palette: HPALETTE;
  end;

  PictureHelper = class
  private
    class function  GetPictureMessage: dword;
    class procedure GetPicturePointer(picture: TadxGPImage; var nativeImage: Pointer);
    class procedure GetPictureFromAdxForm(Handle: HWND; var picture: TadxGPImage);
  end;

  procedure Invalidate(StartWnd: HWND);
  procedure PaintAll(StartWnd: HWND);
  procedure CopyAppWindowProperty(DstAppWindowProperty: Pointer; SrcAppWindowProperty: Pointer);
  procedure SendMessageFindWindows(HWNDParent: HWND; ExcludedHandle: HWND; WindowName: string; WindowClass: string; Msg: Cardinal; wparam, lparam: Cardinal; MakePostMessage: boolean);
  procedure FindScrollbarWindow(HWNDParent: HWND; ExcludedHandle: HWND; WindowName: string; WindowClass: string; OwnerWindow: HWND;  proc: TadxFindScrollbarWindowProcedure; var LastProcessedWindow: HWND);
  function GetInternetExplorerServerWindow(FHostVersion: integer; FHostHandle: HWND): HWND;
  function PowerPointWindowClass(FHostVersion: integer): string;
  function GetAppWindowHandle(FHostVersion: integer; FItemType: TadxItemType; FHostHandle: HWND): HWND;
  function GetTextDocumentHandle(HostVersion: integer; EditorType: TOleEnum; InspectorHandle: HWND): HWND;
  function GetOffset(FHostVersion: integer; FItemType: TadxItemType): integer;
  function FindChildWindow(HWNDParent: HWND; WindowName: string; WindowClass: string; detail: boolean; FindVisibleWindow: boolean = false): HWND; overload;
  function FindChildWindow(HWNDParent: HWND; WindowName: string; WindowClass: string; ExcludeChildWindowClass: string; detail: boolean; FindVisibleWindow: boolean = true): HWND; overload;
  function FindChildWindowWithControlID(HWNDParent: HWND; WindowName: string; WindowClass: string; ExcludeChildWindowClass: string; detail: boolean; AControlID: integer; FindVisibleWindow: boolean = true): HWND;
  function FindExactChildWindow(HWNDParent: HWND; WindowName: string; WindowClass: string; detail: boolean): HWND;
  function FindWindowFromPath(HWNDParent: HWND; FindWindowPath: WideString; var FoundWindowPath: WideString; ChildAssist: boolean): HWND;
  function FindEmulateWindow(HWNDParent: HWND; WindowName: string; WindowClass: string; ControlHandle: HWND): HWND;
  function IsAdxFormHandle(ActiveHandle: HWND; var FormHandle: HWnd): boolean;
  function FindMainWindowInProcess(HWNDParent: HWND; WindowName: string; WindowClass: string): HWND; overload;
  function FindMainWindowInProcess(HWNDParent: HWND; WindowName: string; WindowClass: string; MustVisible: boolean): HWND; overload;
  function HandleFromCurrentProcess(Handle: HWND): boolean;
  function GetSize(AppHandle: HWND; Layout: TadxWindowLayout): integer;
  function IsWindowVisibleSetRedraw(Window: HWND; SetRedrawWindow: HWND): boolean;
  function GetWindowLongCheckUnicode(hWnd: HWND; nIndex: Integer): longint;
  function GetWindowClassPath(HandleMainWindow: HWnd; HandleWindow: HWnd): string;
  procedure RefreshWindowThroughDistortion(AHandle: HWND);
  function WindowPosToRect(wPos: TWindowPos): TRect;
  function RectToWindowPos(R: TRect): TWindowPos;
  function GetScrollType(AHandle: HWND): TadxScrollType;

  function adxextLockWindowUpdate(hWndLock:HWND): bool;
  function adxextUnlockWindowUpdate(hWndLock:HWND): bool;

  procedure SendMessageCluster(Handle: HWND; wParam, lParam: Cardinal);
  procedure ReceiveMessageCluster(msg: TMessage; var wParam, lParam: Cardinal);

  procedure NewAppWindowProperty(var AppWindowProperty: PAppWindowProperty);

const
  adxMessage_IsNET_Subclass = 101;
  adxMessage_IsVCL_Subclass = 202;
  mutexWaiting = 10000;

var
  ExceptionManager: TadxExceptionManager;
  RegionStateGuard: TadxRegionStateGuard;
  RefreshInspectorTabStateGuard: TadxRefreshInspectorTabStateGuard;
  WM_ADXGETTYPESUBCLASS, WM_ADXCOMMAND,
  WM_ADXMAYBEWORDVIEWWASCHANGED: dword;
  WM_ADXSTARTTRANSACTION, WM_ADXENDTRANSACTION: dword;
  hResizeEmulateWibdowMutexSbcls: THandle;
  ILogSingleton:  ILog;
  AppWindowBehaviourSingleton: TAppWindowBehaviour;
  FindWindowFactorySingleton: TFindWindowFactory;
  AdxCursors: TadxCursors;

  function Log: ILog;

  procedure APIInitialize;

  procedure APIFinalize;


implementation

uses Registry, ShlObj, Imm;

{$R adxWSbcls.res }

type

  TLog = class(TInterfacedObject, ILog)
  private
    hLogMutex:  THandle;
    FDisable: boolean;
    FSaveLogToFileByDefaultAfterAddingEachMessage: boolean;
    FLogFileByDefault: string;
    FCountLastMessages: integer;
    FMessages: TStringList;
    FSystemInfo: TStringList;
    FExceptions: TStringList;
    FIndentCount: integer;
    FIndent: string;
    FAddinName: string;
    procedure PutToRightsCountLastMessages;
    procedure SaveMessages(Sender: TObject);
    procedure InternalAddMessage(mes: string);
  public
    constructor Create(ACountLastMessages: integer);
    destructor Destroy; override;
    procedure AddException(mes: string);
    procedure AddSystemInfo(info: string);
    procedure AddMessage(mes: string);
    procedure AddWarning(mes: string);
    procedure AddIndent;
    procedure RemoveIndent;

    procedure SetCountLastMessages(ACountLastMessages: integer);
    function GetMessages: string;
    procedure ShowMessages(caption: string);
    procedure ClearMessages;
    procedure Save(fileName: string);
    procedure SetSaveLogToFileByDefaultAfterAddingEachMessage(value: boolean);
    function GetSaveLogToFileByDefaultAfterAddingEachMessage: boolean;
    procedure SetLogFileByDefault(value: string);
    function GetLogFileByDefault: string;
    procedure Disable;
    procedure SetAddinName(value: string);
    function AddinName: string;
  end;

  TWinControlAccess = class(TWinControl);
  TGPImageAccess = class(TadxGPImage);
  TGPBitmapAccess = class(TadxGPBitmap);

  TSetLWA = function (Hwnd: THandle; crKey: COLORREF; bAlpha: Byte; dwFlags: DWORD): Boolean; stdcall;

const
  ITEMHEIGHT = 22;
  BEFTEXTSPACE = 8;
  BEFSHORTCUTSPACE = 18;
  AFTSHORTCUTSPACE = 12;
  SEPITEMHEIGHT = 7;
  MINMENUWIDTH = 48;

  AdxFormID             = 777;

  DefaultSplitterSize    = 4;
  CollapsedSplitterSize  = 6;

  spltOff               = 0;
  spltStandart          = 1;
  spltAdvanced          = 2;
  spltButtonSize        = 18;

  MinAppWindowWidth     = 10;
  MinAppWindowHeight    = 10;
  MinAdjacentWindowWidth  = 30;
  MinAdjacentWindowHeight = 30;
  MinCTPWindowWidth     = 74;
  MinCTPWindowHeight    = 33;

  MaxDelayBeforeDrag = 5;

  adxECode = 31100;
  adxECodeFormNotSupport= adxECode + 20;

  adxMessageResult          = 77;
  adxMessage_IsContainer    = 55;
  adxMessage_IsOneForm      = 99;

  adxOeReceiverWindowCaption = 'ADXOeReceiverWindow';
  adxOlReceiverWindowCaption = 'ADXOlReceiverWindowCaption';
  adxOlReadingPaneDialogSubPane = 'ADXOlDialogSubPane';
  adxOlReadingPaneSubPaneOffset = 5;

  dragEdgeOffset = 20;
  dragEdgeOffsetClient = 4;

var
  WM_ADXDELPROC, WM_ADXSETOLDPROC, WM_ADXSETNEWPROC, WM_ADXGETCONTAINERFORM,
  WM_ADXADDFORM, WM_ADXDELETEFORM, WM_ADXSETCONTAINER, WM_ADXGETAPPWINDOWPOS,
  WM_ADXUPDATEFORMPARAM, WM_ADXSETMAINPOS, WM_ADXHIDEALLREGIONFORMS,
  WM_ADXSETLATESTPROC, WM_ADXEXIST, WM_ADXEXISTSERVICEFORM, WM_ADXEXISTLAYOUT,
  WM_ADXWMIGETCONTROL, WM_ADXWMIPOSCHANGE, WM_ADXSETACTIVATE, WM_ADXWMISETPOS,
  WM_MSO_BROADCASTCHANGE, WM_ADXSUPPORTMINIMIZE, WM_ADXREDESIGNSUPPORT,
  WM_ADXGETREGIONPARAM, WM_ADXGETREGIONSIZE, WM_ADXSETREGIONPARAM,
  WM_ADXSHOWFLOATING, WM_ADXHIDEFLOATING, WM_ADXCONTAINERHIDEFLOATING, WM_ADXSETFLOATINGPOS,
  WM_ADX_READING_PANE_HIDE_FROM_SBCLS, WM_ADX_DESTROY_EMBEDED_WINDOW, WM_ADXFORMSHOW,
  //WM_ADX_READING_PANE_DIALOG_SHOW, WM_ADX_READING_PANE_DIALOG_HIDE,
  WM_ADXCLOSEBUTTONCLICK, WM_ADXGETPICTURE, WM_ADXMOUSELEAVE, WM_ADXGETFORMDEFAULTSIZE,
  WM_ADXGETDRAGLAYOUTPARAMS, WM_ADXSETDRAGFORM, WM_ADXSETDRAGITEMS,
  WM_ADXDRAGOVERMINIMIZED, WM_ADXUPDATECLIPREGION, WM_ADXSWAPCONTROLLER,
  WM_ADXCONTAINERREFRESH, WM_ADXGETCAPTION, 
  WM_NEGOTIATE_WINDOW_PANE, WM_REMOVING_WNDPROC: dword;

  LockedLevel: integer = 0;
  SetLWAproc: TSetLWA = nil;

function TestLWA: boolean;
var
  lModule: HMODULE;
begin
  Result := False;
  if not Assigned(SetLWAproc) then begin
    lModule := GetModuleHandle(User32);
    if lModule <> 0 then begin
      @SetLWAproc := GetProcAddress(lModule, 'SetLayeredWindowAttributes');
      Result:= true;
    end;
  end
  else
    Result:= true;
end;

function SetLWA(Hwnd: THandle; crKey: COLORREF; bAlpha: Byte; dwFlags: DWORD): Boolean;
begin
  Result := False;
  if TestLWA then begin
    if Assigned(SetLWAproc) then
      Result := SetLWAproc(Hwnd, crKey, bAlpha, dwFlags);
  end;
end;

function GPSystemColor(index: integer): TGPColor;
begin
  result:= ColorRefToARGB(GetSysColor(index));
end;

function TextExtent(text: string; dc: HDC; var size: TSize): TSize;
begin
  result.cx:= 0; result.cy:= 0;
  if dc = 0 then exit;
{$IFDEF UNICODE}
  GetTextExtentPoint32W(dc, PWideChar(text), length(text), size);
{$ELSE}
  GetTextExtentPoint32(dc, PChar(text), length(text), size);
{$ENDIF}
  result:= size;
end;

function  GetIntPoint(X, Y: Longint): TPoint;
begin
  Result:= Point(X, Y);
  if X > 32768 then Result.X:= X - 65536;
  if Y > 32768 then Result.Y:= Y - 65536;
end;

function GPTextExtent(text: WideString; gr: TadxGPGraphics; font: TadxGPFont; var size: TSize): TSize;
begin
  size.cx:= 0; size.cy:= 0;
  if Assigned(gr) then
    gr.MeasureString(text, font, size);
  result:= size;
end;

function AdxextLockWindowUpdate(hWndLock:HWND): bool;
begin
  if (hWndLock <> 0) then begin
    Inc(LockedLevel);
    if (LockedLevel = 1) then begin
      Result := Windows.LockWindowUpdate(hWndLock);
      exit;
    end;
  end;
  Result := false;
end;

function AdxextUnlockWindowUpdate(hWndLock:HWND): bool;
begin
  if (hWndLock <> 0) then begin
        Dec(LockedLevel);
        if (LockedLevel < 0) then begin
          LockedLevel := 0;
        end;
        if (LockedLevel = 0) then begin
          Result := Windows.LockWindowUpdate(0);
          exit;
        end;
  end;
  Result := false;
end;

procedure NewAppWindowProperty(var AppWindowProperty: PAppWindowProperty);
begin
  PAppWindowProperty(AppWindowProperty)^.Offset:= 0;
  PAppWindowProperty(AppWindowProperty)^.EmulateWindowHandle := 0;
  PAppWindowProperty(AppWindowProperty)^.WindowHandle := 0;
  PAppWindowProperty(AppWindowProperty)^.Layout := -1;
  PAppWindowProperty(AppWindowProperty)^.ItemType := -1;
  PAppWindowProperty(AppWindowProperty)^.HostHandle := 0;
  PAppWindowProperty(AppWindowProperty)^.ContainerType := -1;
  PAppWindowProperty(AppWindowProperty)^.HostVersion := -1;
  PAppWindowProperty(AppWindowProperty)^.Splitter := 0;
  PAppWindowProperty(AppWindowProperty)^.Caption := '';
  PAppWindowProperty(AppWindowProperty)^.ReceiverHandle := 0;
  PAppWindowProperty(AppWindowProperty)^.RegionBorder := rbsSingle;
  PAppWindowProperty(AppWindowProperty)^.ItemID := GUID_NULL;
  PAppWindowProperty(AppWindowProperty)^.VerticalScrollbarHandle := 0;
end;

function GetItemName(item: TadxItemType): string;
begin
  case item of
    stOlFolderList           : result:= 'OlFolderList';
    stOlOutlookBar           : result:= 'OlOutlookBar';
    stOlNavigationPane       : result:= 'OlNavigationPane';
    stOlMail                 : result:= 'OlMail';
    stOlAppointment          : result:= 'OlAppointment';
    stOlContact              : result:= 'OlContact';
    stOlJournal              : result:= 'OlJournal';
    stOlNote                 : result:= 'OlNote';
    stOlTask                 : result:= 'OlTask';
    stOlReadingPane          : result:= 'OlReadingPane';
    stOlTodoBar              : result:= 'OlTodoBar';
    stOlMailInspector        : result:= 'OlMailInspector';
    stOlDefaultInspector     : result:= 'OlDefaultInspector';
    stOlWordMailInspector    : result:= 'OlWordMailInspector';
    stOlAppointmentInspector : result:= 'OlAppointmentInspector';
    stOlTaskInspector        : result:= 'OlTaskInspector';
    stOlContactInspector     : result:= 'OlContactInspector';
    stOlDistributionListInspector: result:= 'OlDistributionListInspector';
    stOlJournalInspector     : result:= 'OlJournalInspector';
    stOlWebViewPane          : result:= 'OlWebViewPane';
    stOlReportInspector      : result:= 'OlReportInspector';
    stOlMeetingInspector     : result:= 'OlMeetingInspector';
    stXlMain                 : result:= 'XlMain';
    stXLSheet                : result:= 'XLSheet';
    stOeMail                 : result:= 'OeMail';
    stOeContacts             : result:= 'OeContacts';
    stOeFolderList           : result:= 'OeFolderList';
    stOePreviewPane          : result:= 'OePreviewPane';
    stOeMessageView          : result:= 'OeMessageView';
    stOeMailInspector        : result:= 'OeMailInspector';
    stOeOutlookBar           : result:= 'OeOutlookBar'
  else
    result:= '';
  end;
end;

type
  TadxolFormType = Integer;
const
  ftExplorer = 1;
  ftInspector = 2;

function Log: ILog;
begin
  if (ILogSingleton = nil) then begin
    ILogSingleton := TLog.Create(5000);
  end;
  result := ILogSingleton;
end;

procedure AdxShowMessage(Mess: String; Caption: string);
begin
  MessageBox(0, PChar(Mess), PChar(Caption), MB_OK or MB_ICONERROR or MB_APPLMODAL);
end;

function AdxLayoutToString(adxLayout: integer): string;
begin
  case adxLayout of
    wlLeft: Result:= 'wlLeft';
    wlRight: Result:= 'wlRight';
    wlTop: Result:= 'wlTop';
    wlBottom: Result:= 'wlBottom';
    wlClient: Result:= 'wlClient';
  else
    Result:= 'wlUnknown';
  end;
end;

function WindowLayoutToString(adxLayout: integer): string;
begin
  case adxLayout of
    wlLeft:   Result:= 'Left';
    wlRight:  Result:= 'Right';
    wlTop:    Result:= 'Top';
    wlBottom: Result:= 'Bottom';
    wlClient: Result:= 'Client';
    wlDockLeft:   Result:= 'DockLeft';
    wlDockRight:  Result:= 'DockRight';
    wlDockTop:    Result:= 'DockTop';
    wlDockBottom: Result:= 'DockBottom';
  else
    Result:= 'wlUnknown';
  end;
end;

procedure Invalidate(StartWnd: HWND);
var
  tempWindow: HWND;
begin
  InvalidateRect(StartWnd, nil, true);
  tempWindow:= GetWindow(StartWnd, GW_CHILD);
  while tempWindow > 0 do begin
    Invalidate(tempWindow);
    tempWindow:= GetWindow(tempWindow, GW_HWNDNEXT);
  end;
end;

procedure PaintAll(StartWnd: HWND);
var
  tempWindow: HWND;
begin
  if IsWindowVisible(StartWnd) then begin
    SendMessage(StartWnd, WM_PAINT, 0, 0);
    tempWindow:= GetWindow(StartWnd, GW_CHILD);
    while tempWindow > 0 do begin
      PaintAll(tempWindow);
      tempWindow:= GetWindow(tempWindow, GW_HWNDNEXT);
    end;
  end;
end;

function GetRefreshPos(AHandle: HWND; var RefreshPos: TWindowPos): boolean;
var
  wPos: TWindowPos;
  rc: TRect;
  tempHandle: HWnd;
  msgResult: integer;
begin
  Result:= false;
  if SendMessage(AHandle, WM_ADXGETAPPWINDOWPOS, 0, Cardinal(@wPos)) = adxMessageResult then begin
    Result := true;
    RefreshPos:= wPos;
  end
  else begin
    tempHandle := GetWindow(GetParent(AHandle), GW_CHILD);
    while tempHandle > 0 do begin
      if tempHandle <> AHandle then begin
        rc:= Rect(0, 0, 0, 0);
        msgResult:= SendMessage(tempHandle, WM_NEGOTIATE_WINDOW_PANE, integer(nfcGetFullClientArea), Cardinal(@rc));
        Result:= (msgResult = adxMessageResult) or (not IsRectEmpty(rc));
        if Result then begin
          RefreshPos:= RectToWindowPos(rc);
          break;
        end;
      end;
      tempHandle:= GetWindow(tempHandle, GW_HWNDNEXT);
    end;
  end;
end;

procedure AdxEnableWindow(StartWnd: HWND; flagEnable: boolean);
var
  tempWindow: HWND;
begin
  EnableWindow(StartWnd, flagEnable);
  tempWindow:= GetWindow(StartWnd, GW_CHILD);
  while tempWindow > 0 do begin
    AdxEnableWindow(tempWindow, flagEnable);
    tempWindow:= GetWindow(tempWindow, GW_HWNDNEXT);
  end;
end;

procedure SendMessageCluster(Handle: HWND; wParam, lParam: Cardinal);
var
  msgCluster: PadxMessageCluster;
begin
  GetMem(msgCluster, sizeOf(TAdxMessageCluster));
  msgCluster^.wParam:= wParam;
  msgCluster^.lParam:= lParam;
  if IsWindow(Handle) then
    PostMessage(Handle, WM_ADXCOMMAND, adxPostMessageCmd, Cardinal(msgCluster));
end;

procedure ReceiveMessageCluster(msg: TMessage; var wParam, lParam: Cardinal);
var
  msgCluster: PadxMessageCluster;
begin
  msgCluster:= PadxMessageCluster(msg.LParam);
  if msgCluster <> nil then begin
    wParam:= msgCluster^.wParam;
    lParam:= msgCluster^.lParam;
    FreeMem(msgCluster);
  end;
end;

function DelHotKeyPrefix(const Caption : string): string;
var i : Integer;
begin
  Result := Caption;
  i := 1;
  while i < Length(Result) do begin
    if Result[i] = cHotkeyPrefix then begin
        Delete(Result, i, 1);
        if Result[i] = cHotkeyPrefix then Inc(i);
    end { if }
    else Inc(i);
  end; { while }
end;

function DarkerColor(const Color : TGPColor; const Percent : Byte) : TGPColor;
var
  R, G, B : Byte;
begin
  R := GetRed(Color);
  G := GetGreen(Color);
  B := GetBlue(Color);
  R := R - MulDiv(R, Percent, 100);
  G := G - MulDiv(G, Percent, 100);
  B := B - MulDiv(B, Percent, 100);
  Result := MakeColor(R, G, B);
end;

function LighterColor(const Color : TGPColor; const Percent : Byte) : TGPColor;
var
  R, G, B : Byte;
begin
  R := GetRed(Color);
  G := GetGreen(Color);
  B := GetBlue(Color);
  R := R + MulDiv(255 - R, Percent, 100);
  G := G + MulDiv(255 - G, Percent, 100);
  B := B + MulDiv(255 - B, Percent, 100);
  Result := MakeColor(R, G, B);
end;

procedure CopyAppWindowProperty(DstAppWindowProperty: Pointer; SrcAppWindowProperty: Pointer);
begin
  if (DstAppWindowProperty = nil) or (SrcAppWindowProperty = nil) then Exit;
  with PAppWindowProperty(DstAppWindowProperty)^ do begin
    WindowHandle        := PAppWindowProperty(SrcAppWindowProperty)^.WindowHandle;
    Offset              := PAppWindowProperty(SrcAppWindowProperty)^.Offset;
    VisibleState        := PAppWindowProperty(SrcAppWindowProperty)^.VisibleState;
    HostHandle          := PAppWindowProperty(SrcAppWindowProperty)^.HostHandle;
    Layout              := PAppWindowProperty(SrcAppWindowProperty)^.Layout;
    ItemType            := PAppWindowProperty(SrcAppWindowProperty)^.ItemType;
    ContainerType       := PAppWindowProperty(SrcAppWindowProperty)^.ContainerType;
    HostVersion         := PAppWindowProperty(SrcAppWindowProperty)^.HostVersion;
    Splitter            := PAppWindowProperty(SrcAppWindowProperty)^.Splitter;
    Caption             := PAppWindowProperty(SrcAppWindowProperty)^.Caption;
    ReceiverHandle      := PAppWindowProperty(SrcAppWindowProperty)^.ReceiverHandle;
    EmulateWindowHandle := PAppWindowProperty(SrcAppWindowProperty)^.EmulateWindowHandle;
    AlwaysShowHeader    := PAppWindowProperty(SrcAppWindowProperty)^.AlwaysShowHeader;
    CloseButton         := PAppWindowProperty(SrcAppWindowProperty)^.CloseButton;
    SplitterButton      := PAppWindowProperty(SrcAppWindowProperty)^.SplitterButton;
    RegionBorder        := PAppWindowProperty(SrcAppWindowProperty)^.RegionBorder;
    ItemID              := PAppWindowProperty(SrcAppWindowProperty)^.ItemID;
    VerticalScrollbarHandle:= PAppWindowProperty(SrcAppWindowProperty)^.VerticalScrollbarHandle;
  end;
end;

function GetWindowLongCheckUnicode(hWnd: HWND; nIndex: Integer): longint;
begin
  try
    if IsWindowUnicode(hWnd) then
      result:= GetWindowLongW(hWnd, nIndex)
    else
      result:= GetWindowLongA(hWnd, nIndex);
  except
    on E:SysUtils.Exception do begin
      Log.AddException('GetWindowLongCheckUnicode' + E.Message);
      raise E;
    end;
  end;
end;

function SetWindowLongCheckUnicode(hWnd: HWND; nIndex: Integer; dwNewLong: Longint): Longint;
begin
  try
    if IsWindowUnicode(hWnd) then
      result:= SetWindowLongW(hWnd, nIndex, dwNewLong)
    else
      result:= SetWindowLongA(hWnd, nIndex, dwNewLong);
  except
    on E:SysUtils.Exception do begin
      Log.AddException('SetWindowLongCheckUnicode' + E.Message);
      raise E;
    end;
  end;
end;

procedure SetExWinAPIProperty(Handle :HWND; Prop: integer);
begin
  SetWindowLongCheckUnicode(Handle, GWL_EXSTYLE, GetWindowLongCheckUnicode(Handle, GWL_EXSTYLE) or Prop);
end;

procedure SetWinAPIProperty(Handle :HWND; Prop: integer);
begin
  SetWindowLongCheckUnicode(Handle, GWL_STYLE, GetWindowLongCheckUnicode(Handle, GWL_STYLE) or Prop);
end;

procedure UnSetWinAPIProperty(Handle :HWND; Prop: integer);
begin
  SetWindowLongCheckUnicode(Handle, GWL_STYLE, GetWindowLongCheckUnicode(Handle, GWL_STYLE) and not Prop);
end;

procedure UnSetExWinAPIProperty(Handle :HWND; Prop: integer);
begin
  SetWindowLongCheckUnicode(Handle, GWL_EXSTYLE, GetWindowLongCheckUnicode(Handle, GWL_EXSTYLE) and not Prop);
end;

function GetRectWidth( ARect: TRect ): Integer;
begin
  Result:=ARect.Right - ARect.Left;
end;

function GetRectHeight( ARect: TRect ): Integer;
begin
  Result:=ARect.Bottom - ARect.Top;
end;

function WindowPosToRect(wPos: TWindowPos): TRect;
begin
  Result:= Rect(wPos.x, wPos.y, wPos.x+ wPos.cx, wPos.y+ wPos.cy);
end;

function RectToWindowPos(R: TRect): TWindowPos;
begin
  Result.x:= R.Left;
  Result.y:= R.Top;
  Result.cx:= R.Right- R.Left;
  Result.cy:= R.Bottom- R.Top;
  Result.flags:= 0;
end;

procedure RefreshWindowThroughDistortion(AHandle: HWND);
var
  R: TRect;
begin
  GetWindowRect(AHandle, R);
  SetWindowPos(AHandle, 0, 0, 0, R.Right- R.Left- 1, R.Bottom- R.Top- 1, SWP_NOMOVE or SWP_NOZORDER or SWP_NOACTIVATE);
  SetWindowPos(AHandle, 0, 0, 0, R.Right- R.Left, R.Bottom- R.Top, SWP_NOMOVE or SWP_NOZORDER or SWP_NOACTIVATE);
end;

function GetScrollType(AHandle: HWND): TadxScrollType;
var
  R: TRect;
begin
  if AHandle <= 0 then begin
    Result:= sctUnknown;
    exit;
  end;
  GetWindowRect(AHandle, R);
  if (R.Bottom - R.Top <= 0) or (R.Right - R.Left <= 0) then
    Result := GetScrollType(GetWindow(AHandle, GW_CHILD))
  else begin
    if (R.Bottom - R.Top) > (R.Right - R.Left) then
      Result:= sctVertical
    else
      Result := sctHorizontal;
  end;
end;


function GetSystemFontHandle(const NCFont: TNCFont; FontWeight: Longint = FW_BOLD): HFONT;
var
  NCM: TNonClientMetrics;
  LF: TLogFont;
begin
  Result:= 0;
  NCM.cbSize := SizeOf(NCM);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NCM, 0) then begin
    case NCFont of
      SmCaptionFont:  LF := NCM.lfSmCaptionFont;
      CaptionFont:    LF := NCM.lfCaptionFont;
      MenuFont:       LF := NCM.lfMenuFont;
      MessageFont:    LF := NCM.lfMessageFont;
      StatusFont:     LF := NCM.lfStatusFont;
    else
      exit;
    end;
    LF.lfWeight:= FontWeight;
    Result := CreateFontIndirect(LF);
  end
end;

{procedure RegistryReadStrings(const valueName: string; aStrings: TStrings; oReg:TRegistry);
var
  valueType : DWORD ;
  valueLen  : DWORD ;
  p, buffer : PChar ;
begin
  aStrings.Clear ;
  SetLastError(RegQueryValueEx(oReg.CurrentKey, PChar(valueName),nil, @valueType,nil, @valueLen)) ;
  if GetLastError = ERROR_SUCCESS then
    if valueType = REG_MULTI_SZ then begin
      GetMem(buffer, valueLen) ;
      try
        RegQueryValueEx(oReg.CurrentKey, PChar(valueName), nil, nil, PBYTE(buffer), @valueLen) ;
        p := buffer ;
        while p^ <> #0 do begin
          aStrings.Add(p) ;
          Inc(p, lstrlen(p) + 1)
        end
      finally
        FreeMem(buffer)
      end
    end
    else raise ERegistryException.Create('String list expected')
  else raise SysUtils.Exception.Create('Unable read MULTI_SZ value')
end;

procedure RegistryWriteStrings(const valueName: string; aStrings: TStrings; oReg:TRegistry) ;
var
  p, buffer : PChar ;
  i         : Integer ;
  size      : DWORD ;
begin
  size := 0 ;
  for i := 0 to aStrings.Count - 1 do Inc(size, Length(aStrings [i]) + 1) ;
  Inc (size) ;
  GetMem(buffer, size) ;
  try
    p := buffer ;
    for i := 0 to aStrings.count - 1 do begin
      lstrcpy(p, PChar(aStrings [i])) ;
      Inc(p, lstrlen (p) + 1)
    end;
    p^ := #0 ;
    SetLastError(RegSetValueEx(oReg.CurrentKey, PChar(valueName), 0, REG_MULTI_SZ, buffer, size)) ;
    if GetLastError <> ERROR_SUCCESS then
      raise SysUtils.Exception.Create('Unable to write MULTI_SZ value') ;
  finally
    FreeMem(buffer);
  end
end; }

function GetCharUnicode(KeyCode, KeyData: Cardinal; var chBuff; MenuActivate: boolean): integer;
var
  flags, ScanCode: Cardinal;
  KeyboardState: TKeyboardState;
begin
  ScanCode:= (KeyData shr 16) and $000000FF;
  flags:= byte(MenuActivate);
  GetKeyboardState(KeyboardState);
  result:= ToUnicode(KeyCode, ScanCode, KeyboardState, chBuff, UnicodeCharBuffer, flags);
end;

function TransmitMessage(hWnd: HWND; Msg: Cardinal; wParam, lParam: Longint; makePost: boolean): Longint;
begin
  result := 0;
  if makePost then
    PostMessageW(hWnd, Msg, wParam, lParam)
  else
    result:= SendMessageW(hWnd, Msg, wParam, lParam);
end;

function FindEmulateWindow(HWNDParent: HWND; WindowName: string; WindowClass: string; ControlHandle: HWND): HWND;
var
  TempWindow: HWND;
  lpBuffer : TCharBuffer;
  FindClass: string;
  FindName: string;
  CompareClass: boolean;
  CompareCaption: boolean;
begin
  Result:= 0;
  TempWindow:= GetWindow(HWNDParent, GW_CHILD);
  while TempWindow > 0 do begin
    if GetWindowText(tempWindow, @lpBuffer, CHAR_BUFFER_COUNT) > 0 then
      FindName:= StrPas(lpBuffer);

    if GetClassName(tempWindow, @lpBuffer, CHAR_BUFFER_COUNT) > 0 then
      FindClass:= StrPas(lpBuffer);

    CompareClass := (pos(WindowClass, FindClass) > 0) or (WindowClass = EmptyStr);
    CompareCaption := (pos(WindowName, FindName) > 0) or (WindowName = EmptyStr);

    if CompareClass and CompareCaption then begin
      if HWND(SendMessage(TempWindow, WM_ADXWMIGETCONTROL, 0, 0)) = ControlHandle then begin
        Result:= TempWindow;
        break;
      end;
    end
    else begin
      Result:= FindEmulateWindow(TempWindow, WindowName, WindowClass, ControlHandle);
      if Result > 0 then break;
    end;
    TempWindow:= GetWindow(TempWindow, GW_HWNDNEXT);
  end;
end;

function FindWindowFromPath(HWNDParent: HWND; FindWindowPath: WideString; var FoundWindowPath: WideString; ChildAssist: boolean): HWND;
var
  TempWindow, TempWindowNext: HWND;
  lpBuffer : TCharBuffer;
  StorePath: string;
begin
  Result:= 0;
  tempWindow:= GetWindow(HWNDParent, GW_CHILD);
  while tempWindow > 0 do begin
    StorePath:= FoundWindowPath;
    if GetClassName(tempWindow, @lpBuffer, CHAR_BUFFER_COUNT) > 0 then
      FoundWindowPath:= FoundWindowPath+ StrPas(lpBuffer)+'\';

    if (FoundWindowPath = FindWindowPath) and (TempWindow > 0) then begin
      Result:= TempWindow;
      if not ChildAssist then break
      else if GetWindow(Result, GW_CHILD) > 0 then break;
    end;
    TempWindowNext:= FindWindowFromPath(TempWindow, FindWindowPath, FoundWindowPath, ChildAssist);
    if TempWindowNext > 0 then begin
      Result:= TempWindowNext;
      break;
    end;
    TempWindow:= GetWindow(tempWindow, GW_HWNDNEXT);
    FoundWindowPath:= StorePath;
  end;
end;

function GetWindowClassName(HandleWindow: HWND): string;
var
  lpBuffer : TCharBuffer;
begin
  Result:= '';
  if GetClassName(HandleWindow, @lpBuffer, CHAR_BUFFER_COUNT) > 0 then
    Result:= StrPas(lpBuffer);
end;

function GetWindowCaption(HandleWindow: HWND): string;
var
  lpBuffer : TCharBuffer;
begin
  Result:= '';
  if GetWindowText(HandleWindow, @lpBuffer, CHAR_BUFFER_COUNT) > 0 then
    Result:= StrPas(lpBuffer);
end;

function GetWindowClassPath(HandleMainWindow: HWnd; HandleWindow: HWnd): string;
var
  lpBuffer : TCharBuffer;
  tempWnd: HWnd;
begin
  Result:= '';
  tempWnd:= HandleWindow;

  while tempWnd > 0 do begin
    if GetClassName(tempWnd, @lpBuffer, CHAR_BUFFER_COUNT) > 0 then begin
      if result = '' then
        result := trim(StrPas(lpBuffer))
      else
        result := trim(StrPas(lpBuffer))+ '\'+ result;
    end;
    tempWnd := GetParent(tempWnd);
    if (tempWnd = 0) or (tempWnd = HandleMainWindow) then break;
  end;
end;

function GetSize(AppHandle: HWND; Layout: TadxWindowLayout): integer;
var
  ARegion: TadxRegionParam;
begin
  result := 0;
  if SendMessage(AppHandle, WM_ADXGETREGIONSIZE, Cardinal(@ARegion), Layout) = adxMessageResult then begin
    result := ARegion.Size;
  end;
end;

function IsWindowVisibleSetRedraw(Window: HWND; SetRedrawWindow: HWND): boolean;
begin
  if (Window = 0) then begin
    result := false;
    exit;
  end;

  result := (IsWindowVisible(Window) or (not IsWindowVisible(Window) and (Window = SetRedrawWindow)));
  exit;
end;

function FindMainWindowInProcess(HWNDParent: HWND; WindowName: string; WindowClass: string): HWND;
var
  FoundWindow: HWND;
  FindClass: string;
  FindName: string;
  WindowProcessID: cardinal;
  tempWindow: HWND;
  CompareClass: boolean;
  CompareCaption: boolean;
begin
  FoundWindow := 0;
  tempWindow := GetWindow(HWNDParent, GW_CHILD);
  while (tempWindow > 0) do begin
    FindName:= GetWindowCaption(tempWindow);
    FindClass:= GetWindowClassName(tempWindow);

    CompareCaption := (pos(WindowName, FindName) > 0) or (WindowName = '');
    CompareClass := (pos(WindowClass, FindClass) > 0) or (WindowClass = '');

    if (CompareClass and CompareCaption) then begin
      GetWindowThreadProcessId(tempWindow, @WindowProcessID);
      if (GetCurrentProcessId() = WindowProcessID) then begin
        FoundWindow := tempWindow;
        if (IsWindowVisible(FoundWindow)) then begin
          break;
        end;
      end;
    end;
    tempWindow := GetWindow(tempWindow, GW_HWNDNEXT);
  end;
  result := FoundWindow;
end;

function FindMainWindowInProcess(HWNDParent: HWND; WindowName: string; WindowClass: string; MustVisible: boolean): HWND;
var
  FoundWindow: HWND;
  FindClass: string;
  FindName: string;
  WindowProcessID: cardinal;
  tempWindow: HWND;
  CompareClass: boolean;
  CompareCaption: boolean;
begin
  FoundWindow := 0;
  tempWindow := GetWindow(HWNDParent, GW_CHILD);
  while (tempWindow > 0) do begin
    FindName:= GetWindowCaption(tempWindow);
    FindClass:= GetWindowClassName(tempWindow);

    CompareCaption := (pos(WindowName, FindName) > 0) or (WindowName = '');
    CompareClass := (pos(WindowClass, FindClass) > 0) or (WindowClass = '');

    if (CompareClass and CompareCaption) then begin
      GetWindowThreadProcessId(tempWindow, @WindowProcessID);
      if (GetCurrentProcessId() = WindowProcessID) then begin
        FoundWindow := tempWindow;
        if (MustVisible and IsWindowVisible(FoundWindow)) or (not MustVisible) then begin
          break;
        end;
      end;
    end;
    tempWindow := GetWindow(tempWindow, GW_HWNDNEXT);
  end;
  result := FoundWindow;
end;

function HandleFromCurrentProcess(Handle: HWND): boolean;
var
  WindowProcessID: cardinal;
begin
  GetWindowThreadProcessId(Handle, @WindowProcessID);
  result := (GetCurrentProcessId() = WindowProcessID);
end;


function FindChildWindow(HWNDParent: HWND; WindowName: string; WindowClass: string; detail: boolean; FindVisibleWindow: boolean = false): HWND;
var
  tempWindow: HWND;
  FindName, FindClass: string;
begin
  Result:= 0;
  FindName:= '';
  tempWindow:= GetWindow(HWNDParent, GW_CHILD);
  while tempWindow > 0 do begin
    if (FindVisibleWindow and IsWindowVisible(tempWindow)) or (not FindVisibleWindow) then begin
      if WindowName <> '' then
        FindName:= GetWindowCaption(tempWindow);
      FindClass:= GetWindowClassName(tempWindow);
      if ((pos(WindowName, FindName) > 0) or (WindowName = '')) and ((pos(WindowClass, FindClass) > 0) or (WindowClass = '')) then begin
        Result:= tempWindow;
        break;
      end
      else
      if detail then begin
        Result:= FindChildWindow(tempWindow, WindowName, WindowClass, true, FindVisibleWindow);
        if Result > 0 then
          break;
      end;
    end;
    tempWindow:= GetWindow(tempWindow, GW_HWNDNEXT);
  end;
end;

function FindChildWindow(HWNDParent: HWND; WindowName: string; WindowClass: string; ExcludeChildWindowClass: string; detail: boolean; FindVisibleWindow: boolean = true): HWND;
var
  foundWindow, tempWindow: HWND;
  FindName, FindClass, IncludeChildWindowClass: string;
begin
  FoundWindow:= 0;
  FindClass:= '';
  FindName:= '';
  tempWindow:= GetWindow(HWNDParent, GW_CHILD);
  while tempWindow > 0 do begin
    if WindowName <> '' then
      FindName:= GetWindowCaption(tempWindow);

    FindClass:= GetWindowClassName(tempWindow);
    if ((pos(WindowName, FindName) > 0) or (WindowName = '')) and ((pos(WindowClass, FindClass) > 0) or (WindowClass = '')) then begin
      Result:= tempWindow; FoundWindow:= Result;
      if ExcludeChildWindowClass <> '' then begin
        if ExcludeChildWindowClass[1] = '#' then begin
          IncludeChildWindowClass := ExcludeChildWindowClass;
          Delete(IncludeChildWindowClass, 1, 1);
          if FindChildWindow(tempWindow, '', IncludeChildWindowClass, '', false, FindVisibleWindow) > 0 then
            break;
        end
        else begin
          if FindChildWindow(tempWindow, '', ExcludeChildWindowClass, '', false, FindVisibleWindow) <= 0 then
            break;
        end;
      end
      else begin
        if ((FindVisibleWindow) and IsWindowVisible(Result))
        or ((not FindVisibleWindow)) then begin
          break;
        end;
      end;
    end
    else if detail then begin
      Result:= FindChildWindow(tempWindow, WindowName, WindowClass, ExcludeChildWindowClass, true, FindVisibleWindow);
      if Result > 0 then begin
        FoundWindow:= Result;
        if ((FindVisibleWindow) and IsWindowVisible(Result))
        or (not FindVisibleWindow) then begin
          break;
        end;
      end;
    end;
    tempWindow:= GetWindow(tempWindow, GW_HWNDNEXT);
  end;
  Result:= FoundWindow;
end;

function FindChildWindowWithControlID(HWNDParent: HWND; WindowName: string; WindowClass: string; ExcludeChildWindowClass: string; detail: boolean; AControlID: integer; FindVisibleWindow: boolean = true): HWND;
var
  foundWindow, tempWindow: HWND;
  FindName, FindClass, IncludeChildWindowClass: string;
  ControlID: integer;
begin
  FoundWindow:= 0;
  FindClass:= '';
  FindName:= '';
  tempWindow:= GetWindow(HWNDParent, GW_CHILD);
  while tempWindow > 0 do begin
    if WindowName <> '' then
      FindName:= GetWindowCaption(tempWindow);
    FindClass:= GetWindowClassName(tempWindow);

    ControlID := GetWindowLong(tempWindow, GWL_ID);
    if ((pos(WindowName, FindName) > 0) or (WindowName = ''))
      and ((pos(WindowClass, FindClass) > 0) or (WindowClass = ''))
      and ((ControlID = AControlID) or (AControlID = 0)) then begin

      Result:= tempWindow; FoundWindow:= Result;
      if ExcludeChildWindowClass <> '' then begin
        if ExcludeChildWindowClass[1] = '#' then begin
          IncludeChildWindowClass := ExcludeChildWindowClass;
          Delete(IncludeChildWindowClass, 1, 1);
          if FindChildWindowWithControlID(tempWindow, '', IncludeChildWindowClass, '', false, AControlID, FindVisibleWindow) > 0 then
            break;
        end
        else begin
          if FindChildWindowWithControlID(tempWindow, '', ExcludeChildWindowClass, '', false, AControlID, FindVisibleWindow) <= 0 then
            break;
        end;
      end
      else begin
        if ((FindVisibleWindow) and IsWindowVisible(Result))
        or (not FindVisibleWindow)  then begin
          break;
        end;
      end;
    end
    else if detail then begin
      Result:= FindChildWindowWithControlID(tempWindow, WindowName, WindowClass, ExcludeChildWindowClass, true, AControlID, FindVisibleWindow);
      if Result > 0 then begin
        FoundWindow:= Result;
        if ((FindVisibleWindow) and IsWindowVisible(Result))
        or (not FindVisibleWindow)  then begin
          break;
        end;
      end;
    end;
    tempWindow:= GetWindow(tempWindow, GW_HWNDNEXT);
  end;
  Result:= FoundWindow;
end;

function FindExactChildWindow(HWNDParent: HWND; WindowName: string; WindowClass: string; detail: boolean): HWND;
var
  foundWindow, tempWindow: HWND;
  FindName, FindClass: string;
  CompareClass, CompareCaption: boolean;
begin
  FoundWindow:= 0;
  FindClass:= '';
  FindName:= '';
  tempWindow:= GetWindow(HWNDParent, GW_CHILD);
  while tempWindow > 0 do begin
    if WindowName <> '' then
      FindName:= GetWindowCaption(tempWindow);
    FindClass:= GetWindowClassName(tempWindow);

    CompareClass := ((pos(WindowClass, FindClass) = 1) or (WindowClass = ''));
    CompareCaption := ((pos(WindowName, FindName) = 1) or (WindowName = ''));

    if CompareClass and CompareCaption then begin
      Result := tempWindow;
      FoundWindow := Result;
      break;
    end
    else begin
      if detail then begin
        Result:= FindExactChildWindow(tempWindow, WindowName, WindowClass, true);
        if Result > 0 then begin
          FoundWindow := Result;
          break;
        end;
      end;
    end;
    tempWindow:= GetWindow(tempWindow, GW_HWNDNEXT);
  end;
  Result:= FoundWindow;
end;

function IsAdxFormHandle(ActiveHandle: HWND; var FormHandle: HWnd): boolean;
var TempHandle: HWnd;
begin
  TempHandle:= ActiveHandle;
  Result:= false;
  try
    while true do begin
      TempHandle := Windows.GetParent(TempHandle);
      if TempHandle = 0 then break;
      if GetWindowLongCheckUnicode(TempHandle, GWL_USERDATA) = AdxFormID then begin
        Result:= true;
        FormHandle:= TempHandle;
        break;
      end;
    end;
  except
    on e: Exception do begin
      Log.AddException('IsAdxFormHandle: '+e.Message);
    end;
  end;
end;

function EmptySize(Handle: HWND): boolean;
var
  R: TRect;
begin
  if (IsWindow(Handle)) then begin
    GetWindowRect(Handle, R);
    result := (R.Right - R.Left + R.Bottom - R.Top <= 0);
  end else begin
    result := true;
  end;
end;

function GetInternetExplorerServerWindow(FHostVersion: integer; FHostHandle: HWND): HWND;
var
  H: HWND;
begin
  result := 0;
  if FHostVersion = v2000 then begin
      H := FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
      H := FindChildWindow(H, '', 'AfxWnd', '', false);
      Result := FindChildWindow(H, '', 'Shell Embedding', '', false);
  end;
  if FHostVersion = v2002 then begin
      H := FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
      H := FindChildWindow(H, '', 'AfxWndA', '', false);
      Result := FindChildWindow(H, '', 'Shell Embedding', '', false);
  end;
  if FHostVersion = v2003 then begin
      H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
      H:= FindChildWindow(H, '', 'AfxWndW', '', false);
      Result := FindChildWindow(H, '', 'Shell Embedding', '', false);
  end;
  if FHostVersion = v2007 then begin
      H := FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
      H := FindChildWindow(H, '', 'AfxWndW', '', false);
      Result := FindChildWindow(H, '', 'Shell Embedding', '', false);
  end;
  if FHostVersion = v2010 then begin
      Result := FindChildWindow(FHostHandle, '', 'Shell Embedding', '', false);
  end;

  if (Result > 0) and (not IsWindowVisible(Result)) then begin
    Result := 0;
  end;
end;

function GetTextDocumentHandle(HostVersion: integer; EditorType: TOleEnum; InspectorHandle: HWND): HWND;
begin
  Log.AddMessage('GetTextDocumentHandle EditorType = ' + IntToStr(EditorType));
  result := 0;
  if ((EditorType = 1{olEditorText})
      or (EditorType = 3 {olEditorRTF})) then begin
      if (HostVersion = v2000) then begin
          case EditorType of
              1: {olEditorText} begin
                  result := FindChildWindowWithControlID(InspectorHandle, '', 'RichEdit20A', '', true, $2020);
                  exit;
              end;
              3: {olEditorRTF} begin
                  result := FindChildWindowWithControlID(InspectorHandle, '', 'RichEdit20A', '', true, $0ABC);
                  exit;
              end
              else begin
                exit;
              end;
          end;
      end;

      if (HostVersion = v2002) then begin
          case EditorType of

              1: {olEditorText} begin
                  result := FindChildWindowWithControlID(InspectorHandle, '', 'RichEdit20W', '', true, $2020);
                  exit;
              end;

              3: {olEditorRTF} begin
                  result := FindChildWindowWithControlID(InspectorHandle, '', 'RichEdit20W', '', true, $0ABC);
                  exit;
              end
              else begin
                exit;
              end;
          end;
      end;
      
      if (HostVersion = v2003) then begin
          case EditorType of

              1: {olEditorText} begin
                  result := FindChildWindowWithControlID(InspectorHandle, '', 'RichEdit20W', '', true, $2020);
                  exit;
              end;

              3: {olEditorRTF} begin
                  result := FindChildWindowWithControlID(InspectorHandle, '', 'RichEdit20W', '', true, $0ABC);
                  exit;
              end
              else begin
                exit;
              end;
          end;
      end;

      if (HostVersion = v2007)
        or (HostVersion = v2010) then begin
          //It is neccessary to use the Word Editor
          exit;
      end;
  end;

end;

function PowerPointWindowClass(FHostVersion: integer): string;
begin
  if FHostVersion = v2000 then begin
    result := 'PP9FrameClass';
    exit;
  end;
  if FHostVersion = v2002 then begin
    result := 'PP10FrameClass';
    exit;
  end;
  if FHostVersion = v2003 then begin
    result := 'PP11FrameClass';
    exit;
  end;
  if FHostVersion = v2007 then begin
    result := 'PP12FrameClass';
    exit;
  end;
  if FHostVersion = v2010 then begin
    result := 'PPTFrameClass';
    exit;
  end;
  raise SysUtils.Exception.Create('PowerPointWindowClass: Unknown FHostVersion');
end;

function GetAppWindowHandle(FHostVersion: integer; FItemType: TadxItemType; FHostHandle: HWND): HWND;
var
  H: HWND;
  FW: WideString;
  finder: TFindWindowObject;
begin
  Result:= 0;
  if FHostHandle <= 0 then exit;

  case FItemType of
    stOlFolderList: begin
         if (FHostVersion = v2000) or (FHostVersion = v2002) then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           Result:= FindChildWindow(H, '', 'SysTreeView32', '', false);
         end;
       end;
    stOlOutlookBar: begin
         if FHostVersion = v2002 then begin
           H:= FindChildWindow(FHostHandle, '', 'AfxWndW', '', false);
           Result:= FindChildWindow(H, '', 'rctrl_renwnd32', '', false);
         end;
         if FHostVersion = v2000 then begin
           H:= FindChildWindow(FHostHandle, '', 'SysListView32', '', true);
           Result:= H;
           if Result > 0 then Result:= GetParent(Result);
           if Result > 0 then Result:= GetParent(Result);
         end;
       end;
    stOlNavigationPane: begin
         if FHostVersion = v2003 then begin
           H := FindChildWindow(FHostHandle, '', 'AfxWndW', '', false);
           H := FindChildWindow(H, '', 'WUNDERBAR', '', false);
           Result:= FindChildWindow(H, '', 'NativeHWNDHost', '', false);
         end;
         if FHostVersion = v2007 then begin
           FW:= '';
           H := FindWindowFromPath(FHostHandle, 'AfxWndW\WUNDERBAR\NetUINativeHWNDHost\NetUIHWND\', FW, false);
           Result:= GetParent(H);
         end;
         if FHostVersion = v2010 then begin
           Result:= FindChildWindowWithControlID(FHostHandle, '', 'NetUINativeHWNDHost', '', false, $0067);
         end;
       end;
    stOlMail: begin
         if FHostVersion = v2010 then begin
           Result:= FindChildWindowWithControlID(FHostHandle, '', 'SUPERGRID', '', false, $1260);
         end;
         if FHostVersion = v2007 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWndW', '', false);
           Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
           if Result = 0 then
             Result:= FindChildWindow(H, '', 'rctrl_renwnd32', '', false);
         end;
         if FHostVersion = v2003 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWndW', '', false);
           Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
           if Result = 0 then
             Result:= FindChildWindow(H, '', 'rctrl_renwnd32', '', false);
         end;
         if FHostVersion = v2002 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWnd', '', false);
           Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
           if Result = 0 then
             Result:= FindChildWindow(H, '', 'rctrl_renwnd32', '', false);
         end;
         if FHostVersion = v2000 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWnd', '', false);
           Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
           if Result = 0 then
             Result:= FindChildWindow(H, '', 'rctrl_renwnd32', '', false);
         end;
       end;
    stOlTask: begin
         if FHostVersion = v2010 then begin
           Result:= FindChildWindowWithControlID(FHostHandle, '', 'SUPERGRID', '', false, $1260);
           if Result = 0 then
             Result:= FindChildWindowWithControlID(FHostHandle, '', 'rctrl_renwnd32', '', false, $006D);
         end
         else
         if (FHostVersion = v2003) or (FHostVersion = v2007) then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWndW', '', false);
           Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
           if Result = 0 then Result:= FindChildWindow(H, '', 'rctrl_renwnd32', '', false);
         end
         else
         if FHostVersion = v2002 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWnd', '', false);
           Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
           if Result = 0 then Result:= FindChildWindow(H, '', 'rctrl_renwnd32', '', false);
         end
         else
         if FHostVersion = v2000 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWnd', '', false);
           Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
           if Result = 0 then Result:= FindChildWindow(H, '', 'rctrl_renwnd32', '', false);
         end;
       end;
    stOlReadingPane: begin
        FW := '';
        if (FHostVersion = v2010) then begin
          Result := FindWindowFromPath(FHostHandle, 'rctrl_renwnd32\AfxWndW\', FW, true);
          //if (Result = 0) then
          //  Result := FindWindowFromPath(FHostHandle, 'rctrl_renwnd32\AfxWndW\#32770\', FW, true);
          //H := FindChildWindow(Result, '', '#32770', true, true);
          //if H > 0 then
          //  Result:= GetParent(Result);
        end;
        if (FHostVersion = v2007) then begin
            Result := FindWindowFromPath(FHostHandle, 'rctrl_renwnd32\rctrl_renwnd32\AfxWndW\', FW, true);
            if (Result <> 0) then begin
                Result := GetParent(Result);
                if (EmptySize(Result)) then begin
                    Result := 0;
                end;
            end;
        end;
        if (FHostVersion = v2003) then begin
            Result := FindWindowFromPath(FHostHandle, 'rctrl_renwnd32\rctrl_renwnd32\AfxWndW\', FW, true);
            if (Result <> 0) then begin
              Result := GetParent(Result);
              if (EmptySize(Result)) then begin
                  Result := 0;
              end;
            end;
        end;
        if (FHostVersion = v2002) then begin
            Result := FindWindowFromPath(FHostHandle, 'rctrl_renwnd32\rctrl_renwnd32\', FW, true);
            if (Result <> 0) then begin
                if (EmptySize(Result)) then begin
                  Result := 0;
                end;

            end;
        end;
        if (FHostVersion = v2000) then begin
            Result := FindWindowFromPath(FHostHandle, 'rctrl_renwnd32\rctrl_renwnd32\', FW, true);
            if (Result <> 0) then begin
                if (EmptySize(Result)) then begin
                    Result := 0;
                end;
            end;
        end;
      end;
    stOlReadingPaneHeader: begin
        Result:= FindChildWindow(FHostHandle, adxOlReadingPaneDialogSubPane, '', '', true);
      end;
    stOlAppointment: begin
         if FHostVersion = v2010 then begin
           {H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWndW', '', false);
           Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
           if Result = 0 then begin
             FW:= '';
             Result:= FindWindowFromPath(H, 'AfxWndW\AfxWndW\', FW, true);
             if Result > 0 then Result:= GetParent(Result);
           end;}
         end;
         if FHostVersion = v2007 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWndW', '', false);
           Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
           if Result = 0 then begin
             FW:= '';
             Result:= FindWindowFromPath(H, 'AfxWndW\AfxWndW\', FW, true);
             if Result > 0 then Result:= GetParent(Result);
           end;
         end;
         if FHostVersion = v2003 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWndW', '', false);
           Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
           if Result = 0 then begin
             FW:= '';
             Result:= FindWindowFromPath(H, 'AfxWndW\AfxWndW\', FW, true);
             if Result > 0 then Result:= GetParent(Result);
           end;
         end;
         if FHostVersion = v2002 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWnd', '', false);
           Result:= FindChildWindow(H, '', 'AfxWnd', '', false);
           if Result = 0 then Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
         end;
         if FHostVersion = v2000 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWnd', '', false);
           Result:= FindChildWindow(H, '', 'AfxWnd', '', false);
           if Result = 0 then Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
         end;
       end;
    stOlNote: begin
         if FHostVersion = v2010 then begin
           H := FindChildWindow(FHostHandle, '', 'SysListView32', true, true);
           if H > 0 then
             Result:= GetParent(H);
           if Result = 0 then
             Result:= FindChildWindowWithControlID(FHostHandle, '', 'SUPERGRID', '', false, $1260);
         end;
         if FHostVersion = v2007 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWndW', '', false);
           Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
           if Result = 0 then begin
              H:= FindChildWindow(H, '', 'SysListView32', '', true);
              if H > 0 then
                Result:= GetParent(H);
           end;
         end;
         if FHostVersion = v2003 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWndW', '', false);
           Result:= FindChildWindow(H, '', 'SUPERGRID', '', true);
           if Result = 0 then Result:= FindChildWindow(H, '', 'AfxWndW', 'SysAnimate32', true);
         end;
         if FHostVersion = v2002 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWnd', '', false);
           Result:= FindChildWindow(H, '', 'AfxWnd', '', false);
           if Result = 0 then Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
         end;
         if FHostVersion = v2000 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWnd', '', false);
           Result:= FindChildWindow(H, '', 'AfxWnd', '', false);
           if Result = 0 then Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
         end;
       end;
    stOlContact: begin
         if FHostVersion = v2010 then begin
           Result:= FindChildWindowWithControlID(FHostHandle, '', 'SUPERGRID', '', false, $1260);
           if Result = 0 then
             Result:= FindChildWindowWithControlID(FHostHandle, '', 'rctrl_renwnd32', '', false, $006D);
         end
         else
         if (FHostVersion = v2003) or (FHostVersion = v2007) then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWndW', '', false);
           Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
           if Result = 0 then Result:= FindChildWindow(H, '', 'rctrl_renwnd32', '', false);
         end
         else
         if FHostVersion = v2002 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWnd', '', false);
           Result:= FindChildWindowWithControlID(H, '', 'rctrl_renwnd32', '', false, $006D);
           if Result = 0 then
             Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
         end
         else
         if FHostVersion = v2000 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWnd', '', false);
           Result:= FindChildWindowWithControlID(H, '', 'rctrl_renwnd32', '', false, $006D);
           if Result = 0 then
             Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
         end;
       end;
    stOlJournal: begin
         if FHostVersion = v2010 then begin
           Result:= FindChildWindowWithControlID(FHostHandle, '', 'SUPERGRID', '', false, $1260);
           if Result = 0 then
             Result:= FindChildWindowWithControlID(FHostHandle, '', 'rctrl_renwnd32', '', false, $006D);
         end
         else
         if (FHostVersion = v2003) or (FHostVersion = v2007) then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWndW', '', false);
           Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
           if Result = 0 then Result:= FindChildWindow(H, '', 'rctrl_renwnd32', '', false);
         end
         else
         if FHostVersion = v2002 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWnd', '', false);
           Result:= FindChildWindowWithControlID(H, '', 'rctrl_renwnd32', '', false, $006D);
           if Result = 0 then
             Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
         end
         else
         if FHostVersion = v2000 then begin
           H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
           H:= FindChildWindow(H, '', 'AfxWnd', '', false);
           Result:= FindChildWindowWithControlID(H, '', 'rctrl_renwnd32', '', false, $006D);
           if Result = 0 then
             Result:= FindChildWindow(H, '', 'SUPERGRID', '', false);
         end;
       end;
    stOlTodoBar: begin
      finder := TFindWindowFactory.CreateFindWindowObject(FItemType);
      if (finder <> nil) then begin
        try
          result := finder.Find(FHostHandle, [fwcDefault]);
        finally
          finder.Free;
        end;
      end;
    end;

(*         if (FHostVersion = v2007) then begin
           FW:= '';
           H := FindChildWindowWithControlID(FHostHandle, '', 'AfxWndW', '', false, $0068);
           Result := FindWindowFromPath(H, 'WUNDERBAR\NetUINativeHWNDHost\NetUIHWND\NetUICtrlNotifySink\', FW, true);
           if Result > 0 then Result:= GetParent(Result);
           if Result > 0 then Result:= GetParent(Result);
         end;
         if (FHostVersion = v2010) then begin
           FW:= '';
           Result := FindWindowFromPath(FHostHandle, 'AfxWndW\WUNDERBAR\NetUINativeHWNDHost\NetUIHWND\NetUICtrlNotifySink\', FW, true);
           if Result > 0 then Result:= GetParent(Result);
           if Result > 0 then Result:= GetParent(Result);
         end;
       end;
*)
    stOlWebViewPane: begin
         if FHostVersion = v2000 then begin
             H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
             Result:= FindChildWindow(H, '', 'AfxWnd', '', false);
         end;
         if FHostVersion = v2002 then begin
             H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
             Result:= FindChildWindow(H, '', 'AfxWndA', '', false);
         end;
         if FHostVersion = v2003 then begin
             H:= FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
             H:= FindChildWindow(H, '', 'AfxWndW', '', false);
             Result := FindChildWindow(H, '', 'Shell Embedding', '', false);
         end;
         if FHostVersion = v2007 then begin
             H := FindChildWindow(FHostHandle, '', 'rctrl_renwnd32', '', false);
             H := FindChildWindow(H, '', 'AfxWndW', '', false);
             Result := FindChildWindow(H, '', 'Shell Embedding', '', false);
         end;
         if FHostVersion = v2010 then begin
             Result := FindChildWindow(FHostHandle, '', 'Shell Embedding', '', false);
         end;
       end;

    stOlDefaultInspector,
    stOlMailInspector,
    stOlWordMailInspector,
    stOlEnvelopeCommandBarForWordInspectorPreviwControl,
    stOlAppointmentInspector,
    stOlTaskInspector,
    stOlContactInspector,
    stOlJournalInspector,
    stOlReportInspector,
    stOlDistributionListInspector,
    stOlMeetingInspector,
    stOlSharingInspector,
    stOlMobileInspector:
       begin
         finder := TFindWindowFactory.CreateFindWindowObject(FItemType);
         if (finder <> nil) then begin
           try
             result := finder.Find(FHostHandle, [fwcDefault]);
           finally
             finder.Free;
           end;
         end;
       end;

     stXlMain: begin
       Result := FindMainWindowInProcess(FHostHandle, '', 'XLMAIN');
     end;
     stXlSheet: begin
       Result := FindChildWindow(FHostHandle, '', 'XLDESK', '', false);
     end;

     stWDMain: begin
       Result := FindMainWindowInProcess(FHostHandle, '', 'OpusApp');
     end;
     stWDDocument: begin
       Result := FindChildWindow(FHostHandle, '', '_WwF', '', false);
     end;

     stPPMain: begin
       if FHostVersion = v2000 then begin
         Result := FindMainWindowInProcess(FHostHandle, '', PowerPointWindowClass(FHostVersion));
       end;
       if FHostVersion = v2002 then begin
         Result := FindMainWindowInProcess(FHostHandle, '', PowerPointWindowClass(FHostVersion));
       end;
       if FHostVersion = v2003 then begin
         Result := FindMainWindowInProcess(FHostHandle, '', PowerPointWindowClass(FHostVersion));
       end;
       if FHostVersion = v2007 then begin
         Result := FindMainWindowInProcess(FHostHandle, '', PowerPointWindowClass(FHostVersion));
       end;
       if FHostVersion = v2010 then begin
         Result := FindMainWindowInProcess(FHostHandle, '', PowerPointWindowClass(FHostVersion));
       end;
     end;

     stPPDocument: begin
       Result := FindChildWindow(FHostHandle, '', 'MDIClient', '', false);
     end;

     stOeMail: begin
       H := FindChildWindow(FHostHandle, '', 'Outlook Express Message View', '', false);
       Result := FindChildWindow(H, '', 'Outlook Express Message List', '', false);
     end;
     stOeFolderList: begin
       H := FindChildWindow(FHostHandle, '', 'Outlook Express Navigation Pane', '', false);
       Result := FindChildWindow(H, '', 'ThorTreeViewWndClass', '', true);
     end;
     stOeContacts: begin
       H := FindChildWindow(FHostHandle, '', 'Outlook Express Navigation Pane', '', false);
       Result := FindChildWindow(H, '', 'Outlook Express Address Book Control', '', true);
     end;
     stOeOutlookBar: begin
       H := FindChildWindow(FHostHandle, '', 'Outlook Express Outlook Bar', '', false);
       Result := FindChildWindow(H, '', 'Outlook Express Outlook Bar Frame', '', false);
     end;
     stOePreviewPane: begin
       H := FindChildWindow(FHostHandle, '', 'Outlook Express Message View', '', false);
       Result := FindChildWindow(H, '', 'ME_DocHost', '', true);
     end;
     stOeMailInspector: begin
       Result:= FindChildWindow(FHostHandle, '', 'ME_DocHost', '', true);
     end;
  end;
end;

function GetOffset(FHostVersion: integer; FItemType: TadxItemType): integer;
begin
  Result:= 0;
end;

procedure SendMessageFindWindows(HWNDParent: HWND; ExcludedHandle: HWND; WindowName: string; WindowClass: string; Msg: Cardinal; wparam, lparam: Cardinal; MakePostMessage: boolean);
var
  TempWindow: HWND;
  FindClass: string;
  FindName: string;
  CompareClass: boolean;
  CompareCaption: boolean;

begin
  Log.AddMessage('SendMessage Find Windows');
  Log.AddIndent;
  try
    try
      TempWindow:= GetWindow(HWNDParent, GW_CHILD);
      while TempWindow > 0 do begin
        FindName:= '';
        FindClass:= GetWindowClassName(TempWindow);

        //Outlook has been locking up when opening Outlook, replying to a message
        //and clicking Send
        //'ThorConnWndClass'
        //TDebug.WriteLine('FindClass (VCL) TadxReceiverWindow: ' + IntToStr(pos(FindClass, 'TadxReceiverWindow')));
        //TDebug.WriteLine('FindClass (VCL) WindowsForms: ' + IntToStr(pos(FindClass, 'WindowsForms')));

        if (pos('TadxReceiverWindow', FindClass) <= 0) and (pos('WindowsForms', FindClass) <= 0)  then begin
          TempWindow:= GetWindow(TempWindow, GW_HWNDNEXT);
          continue;
        end;

        FindName:= GetWindowCaption(TempWindow);

        CompareClass := (pos(WindowClass, FindClass) > 0) or (WindowClass = '');
        CompareCaption := (pos(WindowName, FindName) > 0) or (WindowName = '');

        if CompareClass
           and CompareCaption
           and (ExcludedHandle <> TempWindow) then begin
          if (MakePostMessage) then  begin
            PostMessage(TempWindow, Msg, wparam, lparam);
          end
          else begin
            SendMessage(TempWindow, Msg, wparam, lparam);
          end;
        end;
        TempWindow:= GetWindow(TempWindow, GW_HWNDNEXT);
      end;
    except
      on E:SysUtils.Exception do begin
        Log.AddWarning('SendMessageFindWindows Error: FindClass = ' + FindClass + #13#10 + E.Message);
        raise E;
      end;
    end;
  finally
    Log.RemoveIndent;
  end;
end;

procedure FindScrollbarWindow(HWNDParent: HWND; ExcludedHandle: HWND; WindowName: string; WindowClass: string; OwnerWindow: HWND; proc: TadxFindScrollbarWindowProcedure; var LastProcessedWindow: HWND);
var
  TempWindow: HWND;
  FindClass: string;
  FindName: string;
  CompareClass: boolean;
  CompareCaption: boolean;
  BreakCycle: boolean;
begin
  LastProcessedWindow := 0;

  Log.AddMessage('SendMessage Find Windows');
  Log.AddIndent;
  try
    try
      TempWindow:= GetWindow(HWNDParent, GW_CHILD);
      while TempWindow > 0 do begin
        FindName:= '';
        FindClass:= GetWindowClassName(TempWindow);

        FindName:= GetWindowCaption(TempWindow);

        CompareClass := (pos(WindowClass, FindClass) > 0) or (WindowClass = '');
        CompareCaption := (pos(WindowName, FindName) > 0) or (WindowName = '');

        if CompareClass
           and CompareCaption
           and (ExcludedHandle <> TempWindow) then begin
           BreakCycle := false;
           Proc(OwnerWindow, TempWindow, BreakCycle);
           if (BreakCycle) then begin
             LastProcessedWindow := TempWindow;
             break;
           end;
        end;
        TempWindow:= GetWindow(TempWindow, GW_HWNDNEXT);
      end;
    except
      on E:SysUtils.Exception do begin
        Log.AddWarning('ProcessFindWindows Error: FindClass = ' + FindClass + #13#10 + E.Message);
        raise E;
      end;
    end;
  finally
    Log.RemoveIndent;
  end;
end;


{ TCustomAppWindow }

constructor TAppWindowCustom.Create;
begin
  FHandle:= 0;
  NewWindowProc := VirtualAlloc(nil, 12, MEM_RESERVE or MEM_COMMIT, PAGE_EXECUTE_READWRITE);
  asm
    mov  EAX, Self
    mov  ECX, [EAX].TAppWindowCustom.NewWindowProc
    mov  word  ptr [ECX+0], $6858
    mov  dword ptr [ECX+2], EAX
    mov  word  ptr [ECX+6], $E950
    mov  EAX, OFFSET(TAppWindowCustom.MainWndProc)
    sub  EAX, ECX
    sub  EAX, 12
    mov  dword ptr [ECX+8], EAX
  end;
end;

destructor TAppWindowCustom.Destroy;
begin
  VirtualFree(NewWindowProc, 0, MEM_RELEASE);
  inherited;
end;

function TAppWindowCustom.MainWndProc(hWnd: THandle; Msg: UINT; wParam, lParam: Integer): Cardinal; stdcall;
begin
  result:= WndProc(hWnd, Msg, wParam, lParam);
end;

procedure TAppWindowCustom.SetHandle(const Value: HWND);
begin
  if FHandle <> Value then begin
    FHandle := Value;
    FParent := Windows.GetParent(FHandle);
  end;
end;

function TAppWindowCustom.WndProc(hWnd: THandle; Msg: UINT; wParam, lParam: Integer): Cardinal;
begin
  Result := CallWindowProc(OldWindowProc, hwnd, Msg, wParam, lParam);
end;

{ TAppWindow }

constructor TAppWindow.CreateEx(AOwner: TadxForm);
begin
  Create;
  FOwner:= AOwner;
end;

procedure TAppWindow.AdxRefresh;
var
  RefreshPos: TWindowPos;
  EnableRefreshWhenHostMinimize: boolean;
  EnableRefresh_ReadingPane_WhenHostMinimize: boolean;
  RefreshItems: set of byte;
  containerPane: TadxContainerPane;
begin
  EnableRefresh_ReadingPane_WhenHostMinimize := (owner.FItemType = stOlReadingPane)
  and ((owner.FHostVersion = v2003)
    or (owner.FHostVersion = v2007)
    or (owner.FHostVersion = v2010) );

  RefreshItems:= [stOlMailInspector, stOlAppointmentInspector, stOlContactInspector, stOlDistributionListInspector,
                  stOlTaskInspector, stOlJournalInspector, stOlReportInspector, stOlMeetingInspector,
                  stOlMail, stOlFolderList, stOlOutlookBar, stOlNavigationPane, stOlTodoBar,
                  stXLSheet, stWDDocument, stPPDocument, stOfficeTaskPane];

  //When Oulook Minimize
  EnableRefreshWhenHostMinimize := EnableRefresh_ReadingPane_WhenHostMinimize
    or (byte(owner.FItemType) in RefreshItems);

  if (Handle <> 0) and (IsWindowVisible(owner.fHostHandle) or EnableRefreshWhenHostMinimize) then begin
    containerPane := Pane;
    if Assigned(containerPane) then
      containerPane.NeedResize;
    {$IFDEF SupportAdjacentWindow}
    if Assigned(FOwner) and FOwner.IsSupportAdjacentWindow then begin
      DoNegotiateWindowMessage(WM_NEGOTIATE_WINDOW_PANE, integer(nfcRecalcPaneLayout), 0);
      Invalidate(handle);
      exit;
    end;
    {$ENDIF}

    if GetRefreshPos(Handle, RefreshPos){ and (FOwner.Injected)} then
      SetWindowPos(Handle, 0, RefreshPos.x, RefreshPos.y, RefreshPos.cx, RefreshPos.cy, SWP_NOZORDER or SWP_NOACTIVATE)
    else begin
        try
          SetWindowPos(Handle, 0, MainPos.x, MainPos.y, MainPos.cx, MainPos.cy, SWP_NOZORDER or SWP_NOACTIVATE);
        except
          on E:SysUtils.Exception do begin
            //Exception for Outlook XP is closed with ADXOlForm in ReadingPane
            Log.AddException('AdxRefresh.SetWindowPos: ' + E.Message);
            raise E;
          end;
        end;
        if Owner.FEmulateWindow > 0 then
          SendMessage(Handle, WM_ADXWMISETPOS, 0, Cardinal(@MainPos));
    end;
    Invalidate(handle);
  end;
end;

function TAppWindow.WndProc(hWnd: THandle; Msg: UINT; wParam, lParam: Longint): Cardinal;
var
  wPos: PWindowPos;
  NewLParam, index: longint;
  ParentNotifyMessage: integer;
  cond1, cond2, cond3, isSupportAdjacentWindow: boolean;
  adxFormParam: TadxFormParam;
  awp: PAppWindowProperty;
  wParamValue, lParamValue: Cardinal;
  HIDE_WHEN_WINDOWPOSCHANGING, SHOW_WHEN_WINDOWPOSCHANGING: boolean;
begin
  try
    NewLParam:= lparam; Result:= 0;
    if Msg = WM_PARENTNOTIFY then begin
      ParentNotifyMessage := LOWORD(wParam);
      if (ParentNotifyMessage = WM_DESTROY) then begin
        if (TAppWindowBehaviour.GetSingleton <> nil) then begin
          TAppWindowBehaviour.GetSingleton.WM_PARENTNOTIFY_DESTROY(hWnd, Msg, wParam, lParam, self);
        end;
      end;
    end

    else
    if Msg = WM_REMOVING_WNDPROC then begin
      TDebug.WriteLine('!!! Process REMOVING_WNDPROC');
      if lParam = Longint(OldWindowProc) then begin
        OldWindowProc:= Pointer(wParam);
        Result:= 1;
        exit;
      end;
    end

    else
    if Msg = WM_WINDOWPOSCHANGED then begin
      Result := CallWindowProc(OldWindowProc, hwnd, Msg, wparam, lParam);
      if Pane <> nil then
        Pane.UpdateAppScrollBar;
      exit;
    end
    {$IFDEF SupportAdjacentWindow}
    else
    if Msg = WM_NEGOTIATE_WINDOW_PANE then begin
      if Assigned(FOwner) and FOwner.IsSupportAdjacentWindow then
        Result:= DoNegotiateWindowMessage(Msg, wParam, lParam);
      exit;
    end
    {$ENDIF}
    else
    if Msg = WM_ADXUPDATECLIPREGION then begin
      if Assigned(Owner) then
        Owner.UpdateRegion(Cardinal(wParam), Cardinal(lParam));
      CallWindowProc(OldWindowProc, hwnd, Msg, wparam, lParam);
      Result:= adxMessageResult;
      exit;
    end

    else
    if Msg = WM_SETREDRAW then begin
      if (not boolean(wParam)) and (Owner.ItemType = stOlReadingPane) and (Owner.HostVersion <> v2010) then begin
        //02.06.2009 This message with (wParam = 0) makes the ReadingPane window invisible.
        //See blinking effect on SelectionChange.
        Result := 0;
        exit;
      end;
    end

    else
    if Msg = WM_WINDOWPOSCHANGING then begin
      wPos:= Pointer(lParam);
      cond1:= (wPos^.cx+ WPos^.cy  > 0);
      cond2:= not((wPos^.flags and SWP_NOMOVE > 0) and (wPos^.flags and SWP_NOSIZE > 0));
      cond3:= not((wPos^.flags and SWP_NOREDRAW > 0) and (wPos^.flags and SWP_FRAMECHANGED > 0));
      isSupportAdjacentWindow:= Assigned(FOwner) and FOwner.IsSupportAdjacentWindow;

      if (not cond1) and cond2 then begin
        MainPos := wPos^;
      end;

      if cond1 and cond3 or isSupportAdjacentWindow then begin
        {$IFDEF SupportAdjacentWindow}
        if isSupportAdjacentWindow then
          DoNegotiateWindowMessage(Msg, wParam, lParam)
        else
        {$ENDIF}
        begin
          MainPos:= wPos^;
          OldScreenPos:= ScreenPos;
          if Assigned(Owner.ContainerPane) then
            Owner.ContainerPane.RecalcScreenPosition;

          wPos^:= ScreenPos;
          NewLParam:= longint(wPos);
          ResizeTaskPane;
        end;
        Result := CallWindowProc(OldWindowProc, hwnd, Msg, wparam, NewLParam);

        if (CallWindowProc(OldWindowProc, hwnd, WM_ADXEXIST, 0, 0) <> adxMessageResult) then
          CallWindowProc(OldWindowProc, hwnd, WM_ADXWMISETPOS, 0, Cardinal(@ScreenPos));
        exit;
      end;

      //Office 2010
      SHOW_WHEN_WINDOWPOSCHANGING := ((WPos^.flags and SWP_SHOWWINDOW) > 0);
      HIDE_WHEN_WINDOWPOSCHANGING := ((WPos^.flags and SWP_HIDEWINDOW) > 0);

      if (TAppWindowBehaviour.GetSingleton <> nil) then begin
        if (SHOW_WHEN_WINDOWPOSCHANGING) then begin
           TAppWindowBehaviour.GetSingleton.SHOW_WHEN_WINDOWPOSCHANGING(self);
        end;
        if (HIDE_WHEN_WINDOWPOSCHANGING) then begin
           TAppWindowBehaviour.GetSingleton.HIDE_WHEN_WINDOWPOSCHANGING(self);
        end;
      end;
    end

    else
    if Msg = WM_CLOSE then begin
      if (Owner <> nil) and (Owner.IsExplorerForm) then begin
        awp := PAppWindowProperty(owner.FAppWindowProperty);
        Log.AddMessage('TAppWindow.WndProc.WM_CLOSE send WM_ADX_DESTROY_EMBEDED_WINDOW ' + owner.FormID);
        SendMessage(awp^.ReceiverHandle, WM_ADX_DESTROY_EMBEDED_WINDOW, awp^.HostHandle, awp^.WindowHandle);
      end;
    end

    else
    if Msg = WM_SHOWWINDOW then begin
      //TODO Move this code to the TAppWindowBehaviour
      if (Owner <> nil) and (Owner.IsExplorerForm) then begin
        if not boolean(wparam) then begin
          awp := PAppWindowProperty(owner.FAppWindowProperty);
          Log.AddMessage('TAppWindow.WndProc.WM_SHOWWINDOW send WM_ADX_DESTROY_EMBEDED_WINDOW');
          SendMessage(awp^.ReceiverHandle, WM_ADX_DESTROY_EMBEDED_WINDOW, awp^.HostHandle, awp^.WindowHandle);
        end;
      end;

      if (TAppWindowBehaviour.GetSingleton <> nil) then begin
        if (not boolean(wparam)) then begin
          TAppWindowBehaviour.GetSingleton.WM_SHOWWINDOW_HIDE(hWnd, Msg, wParam, lParam, self);
        end
        else begin
          TAppWindowBehaviour.GetSingleton.WM_SHOWWINDOW_SHOW(hWnd, Msg, wParam, lParam, self);
        end;
      end;
    end

    else
    if Msg = WM_DESTROY then begin
      TAppWindowBehaviour.GetSingleton.WM_DESTROY(hWnd, Msg, wParam, lParam, self);
    end

    else
    if Msg = WM_ADXUPDATEFORMPARAM  then begin
      if Assigned(Owner.Container) then Owner.Container.UpdateParam(PadxFormParam(lParam));
    end

    else
    if Msg = WM_ADXCOMMAND  then begin
      if wParam = adxBlinking then begin
        if PadxBlinkParam(lParam)^.layout = Owner.Layout then begin
          Result:= adxMessageResult;
          Pane.HighlightRequest(PadxBlinkParam(lParam));
          exit;
        end;
      end
      else
      if wParam = adxActivateClientLayout then begin
        if Assigned(owner.Container) and owner.Container.ActivateClientLayout then
          Result:= adxMessageResult;
          exit;
      end;
    end

    else
    if Msg = WM_ADXEXIST  then begin
      Result:= adxMessageResult;
      if (wParam > 0) and (wParam <> Owner.ItemType) then
        Result:= 0;
      exit;
    end

    else
    if Msg = WM_ADXEXISTLAYOUT  then begin
      if (wParam = Owner.Layout) and (not Owner.IsClientLayout) then begin
        Result:= adxMessageResult;
        if Pointer(lParam) <> nil then
          //PCardinal(lParam)^:= Owner.Handle;
          PCardinal(lParam)^:= Pane.Handle;
        exit;
      end;
    end

    else
    if Msg = WM_ADXEXISTSERVICEFORM then begin
      if owner.Layout = wlClient then begin
        if owner.Container is TadxContainer then begin
          if owner.Container.ExistClientLayout then begin
            Result := adxMessageResult;
            exit;
          end
        end;
      end;
    end

    else
    if Msg = WM_ADXHIDEALLREGIONFORMS  then begin
      Result:= CallWindowProc(OldWindowProc, hWnd, Msg, wParam, lParam);
      if Assigned(owner.Container) then
         owner.Container.HideAllForm;
      exit;
    end

    else
    if Msg = WM_ADXGETTYPESUBCLASS  then begin
      Result:= adxMessage_IsVCL_Subclass;
      exit;
    end

    else
    if Msg = WM_ADXADDFORM then begin
      if (Owner.ItemType = PadxFormParam(lparam)^.ItemType) and (Owner.Layout = PadxFormParam(lparam)^.Layout) then begin
        if not Assigned(Owner.FContainer) then
          Owner.FContainer:= TadxContainer.CreateEx(Owner);
        Owner.InitFormParamStructure;
        if Owner.Container.Count <= 0 then
          Owner.Container.AddForm(Owner.FormParam);
        if PadxFormParam(lParam).FormHandle <> Owner.Handle then begin
          Owner.Container.AddForm(PadxFormParam(lParam));
          Owner.ContainerPane.SetItemsList;
          Owner.ContainerPane.Show;
          Result:= adxMessageResult;
        end;
        exit;
      end;
    end

    else
    if Msg = WM_ADXSETCONTAINER then begin
      adxFormParam := PadxFormParam(lparam)^;
      if (Owner.ItemType = adxFormParam.ItemType) and (Owner.Layout = adxFormParam.Layout) then begin
        if adxFormParam.Count >= Owner.MinFormOnContainerWhenShowHeader then begin
          if not Assigned(Owner.Container) then
            Owner.FContainer:= TadxContainer.CreateEx(Owner);
          Owner.Container.MoveList(PadxFormParamList(adxFormParam.List), adxFormParam.Count); //PPointerList
        end;

        Result:= adxMessageResult;
        if not Owner.EnableSize then
          Owner.SetUserSize(PadxRegionParam(wparam)^.Size);

        Owner.FormRegion.Size:=  PadxRegionParam(wparam)^.Size;
        Owner.FInjected:= true;
        Owner.FormRegion.FState:= TadxInternalRegionstate(PadxRegionParam(wparam)^.State);
        Owner.ShowOnTop;
        exit;
      end;
    end

    else
    if Msg = WM_ADXDELETEFORM then begin
      with PadxFormParam(lparam)^ do
      if (Owner.ItemType = ItemType) and (Owner.Layout = Layout) then begin
        if Assigned(Owner.FContainer) then begin
          if Owner.Container.Count > 0 then begin
            Owner.Container.DeleteForm(PadxFormParam(lparam));
            Owner.ContainerPane.SetItemsList;
            Result:= adxMessageResult;
            exit;
          end;
         end;
      end;
    end

    else
    if Msg = WM_ADXSETACTIVATE then begin
      with PadxFormParam(lparam)^ do
      if (Owner.ItemType = ItemType) and (Owner.Layout = Layout) then begin
        if Assigned (Owner.Container) then begin
          Index:= Owner.Container.GetIndex(PadxFormParam(lparam));
          if Index >= 0 then begin
            Owner.FormRegion.FState:= irsNormal;
            Owner.AdxExtract(Index);
            Result:= adxMessageResult;
            exit;
          end;
        end;
      end;
    end

    {else
    if Msg = WM_NEGOTIATE_WINDOW_PANE then begin
      if (TAppNegotiateFunctionCode(wParam mod 8) = nfcGetFullClientArea)  and (Pointer(GetWindowLongCheckUnicode(Handle, GWL_WNDPROC)) = NewWindowProc) then begin
        PRect(lParam)^:= Rect(MainPos.x, MainPos.y, MainPos.x+ MainPos.cx, MainPos.y+ MainPos.cy);
        Result:= adxMessageResult;
        exit;
      end;
    end}

    else
    if Msg = WM_ADXGETAPPWINDOWPOS then begin
      if wParam > 0 then begin
        if (not Owner.IsClientLayout) and (wParam = Owner.Layout) then begin
          PWindowPos(lparam)^:= MainPos;
          Result:= adxMessageResult;
          exit;
        end;
      end
      else
      if Pointer(GetWindowLongCheckUnicode(Handle, GWL_WNDPROC)) = NewWindowProc then begin
      //if CallWindowProc(OldWindowProc, Handle, WM_ADXEXIST, 0, 0) <> AdxMessageResult then begin
        PWindowPos(lparam)^:= MainPos;
        Result:= adxMessageResult;
        exit;
      end;
    end

    else
    if Msg = WM_ADXSETLATESTPROC then begin
      if owner.Layout <> wlClient then begin
        if CallWindowProc(OldWindowProc, hwnd, WM_ADXEXIST, 0, 0) <> AdxMessageResult then begin
          Result:= AdxMessageResult;
          PCardinal(lparam)^:= Cardinal(OldWindowProc);
          OldWindowProc:= Pointer(PCardinal(wParam)^);
          exit;
        end;
      end
      else begin
        Result:= AdxMessageResult;
        wParamValue:= PCardinal(wParam)^;
        lParamValue:= PCardinal(lParam)^;

        PCardinal(lparam)^:= Cardinal(NewWindowProc);
        try
          if SendMessage(hwnd, WM_ADXSETNEWPROC, Cardinal(@NewWindowProc), wParam) <> adxMessageResult then
            raise Exception.Create('SendMessage(WM_ADXSETNEWPROC)');
        except
          Result:= 0;
          PCardinal(wParam)^:= wParamValue;
          PCardinal(lParam)^:= lParamValue;
        end;
        exit;
      end;
    end

    else
    if Msg = WM_ADXSETMAINPOS then begin
        MainPos:= PWindowPos(lparam)^;
        Result:= adxMessageResult;
        exit;
    end

    else
    if Msg = WM_ADXGETREGIONPARAM then begin
      if Owner.Layout = integer(lparam) then begin
        Owner.FormRegion.UpdateParam;
        PAdxRegionParam(wparam)^.Size:= Owner.FormRegion.Size;
        PAdxRegionParam(wparam)^.State:= ord(Owner.FormRegion.State);
        Result:= adxMessageResult;
        exit;
      end;
    end

    else
    if Msg = WM_ADXGETREGIONSIZE then begin
      if (Owner.Layout = integer(lparam)) and Assigned(Pane) then begin
        Owner.FormRegion.UpdateParam;
        if Pane <> nil then
          Pane.GetUserSize(PAdxRegionParam(wparam)^.Size);

        if ((Owner.Layout = wlTop) or (Owner.Layout = wlBottom) or (Owner.Layout = wlDockTop) or (Owner.Layout = wlDockBottom)) and Pane.IsHeaderVisible then
          inc(PAdxRegionParam(wparam)^.Size, Pane.HeaderHeight);

        PAdxRegionParam(wparam)^.State:= ord(Owner.FormRegion.State);
        Result:= adxMessageResult;
        exit;
      end;
    end

    else
    if Msg = WM_ADXSETREGIONPARAM then begin
      if Owner.Layout = integer(lparam) then begin
        if Owner.Injected then begin
          if PAdxRegionParam(wparam)^.Size > 0 then
            Owner.FormRegion.Size:=  PAdxRegionParam(wparam)^.Size;
          if PAdxRegionParam(wparam)^.State <> ord(irsUnknown) then
            Owner.FormRegion.State:= TadxInternalRegionstate(PAdxRegionParam(wparam)^.State);
        end;
        Result:= adxMessageResult;
        exit;
      end;
    end

    else
    if Msg = WM_ADXGETCONTAINERFORM then begin
      with PAdxFormParam(lparam)^ do
      if Self.Owner <> nil then begin
        if (Owner.ItemType = ItemType) and (Owner.Layout = Layout) then begin
          Result:= adxMessage_IsOneForm;
          if Assigned(Owner.FContainer) then
            if Owner.Container.Count > 0 then
              Result:= adxMessage_IsContainer;
          exit;
        end;
      end;
    end

    {else
    if Msg = WM_ADXDELPROC then begin
      if OldWindowProc = Pointer(wParam) then begin
        OldWindowProc:=  Pointer(lParam);
        Result:= adxMessageResult;
        exit;
      end;
    end}

    else
    if Msg = WM_ADXDELPROC then begin
      if OldWindowProc = Pointer(PCardinal(wParam)^) then begin
        OldWindowProc:=  Pointer(PCardinal(lParam)^);
        Result:= adxMessageResult;
        exit;
      end;
    end

    else
    if Msg = WM_ADXSETNEWPROC then begin
      if OldWindowProc = Pointer(PCardinal(wParam)^) then begin
        OldWindowProc := Pointer(PCardinal(lParam)^);
        Result:= adxMessageResult;
        exit;
      end;
    end

    else
    if Msg = WM_ADXCONTAINERREFRESH then begin
      if Owner.Layout = (wParam and $00FF) then begin
        if Assigned(Pane) then
          Pane.ContainerRefresh(wParam and $FF00, false, lParam);
        Result:= adxMessageResult;
        exit;
      end;
    end;

    Result := CallWindowProc(OldWindowProc, hwnd, Msg, wparam, NewLParam);
  except
    on E: Exception do begin
      Log.AddException(Format('TAppWindow.WndProc(msg= %x, wparam= %x, lparam= %x). %s', [Msg, wParam, lParam, e.Message]));
      raise E;
    end;
  end;
end;

function TAppWindow.GetAppWindowProperty: Pointer;
begin
  result := Owner.FAppWindowProperty;
end;

function TAppWindow.GetOwner: TadxForm;
begin
  if (FOwner = nil) then begin
    Log.AddWarning('TAppWindow.FOwner = nil');
  end;
  result := FOwner;
end;

function TAppWindow.GetPane: TadxContainerPane;
begin
  result:= nil;
  if Assigned(FOwner) then
    result:= FOwner.ContainerPane;
end;

procedure TAppWindow.InitMainPos;
var
  R: TRect;
  wInfo: TWindowInfo;
  wPos:  TWindowPos;
begin
  if (handle > 0) and (Parent > 0) then begin
    if GetRefreshPos(Handle, wPos) then
      MainPos:= wPos
    else begin
      GetWindowRect(handle, R);
      GetWindowInfo(Parent, wInfo);
      OffsetRect(R, -wInfo.rcClient.Left, -wInfo.rcClient.Top);
      MainPos:= RectToWindowPos(R);
    end;
  end;
end;

procedure TAppWindow.SetClippingStyle;
var
  styles: longint;
begin
  styles:= GetWindowLongCheckUnicode(Handle, GWL_STYLE);
  FClipStyles:= styles and (WS_CLIPCHILDREN or WS_CLIPSIBLINGS);
  SetWinAPIProperty(Handle, WS_CLIPCHILDREN or WS_CLIPSIBLINGS);
end;

procedure TAppWindow.SetOwner(const Value: TadxForm);
begin
  FOwner := Value;
end;

procedure TAppWindow.ResizeTaskPane;
begin
  if Assigned(Owner.ContainerPane) then
    Owner.ContainerPane.DoResize;
end;

procedure TAppWindow.RestoreClippingStyle;
begin
  SetWinAPIProperty(Handle, FClipStyles);
end;

procedure TAppWindow.RestoreWndProc;
var
  flagRestore: boolean;
begin
  flagRestore:= false;
  if GetWindowLongCheckUnicode(Handle, GWL_WNDPROC) = Longint(NewWindowProc) then
    flagRestore:= true
  else begin
    if SendMessage(Handle, WM_REMOVING_WNDPROC, Longint(OldWindowProc), Longint(NewWindowProc)) <> 1 then
      flagRestore:= true;
  end;
  if flagRestore then begin
    SetWindowLongCheckUnicode(Handle, GWL_WNDPROC, Cardinal(OldWindowProc));
  end;
end;

function TAppWindow.SwapWndProc(newProc, oldProc: Pointer): boolean;
begin
  Result:= true;
  if SendMessage(Handle, WM_REMOVING_WNDPROC, Longint(newProc), Longint(oldProc)) <> 1 then begin
    Result:= false;
    SetWindowLongCheckUnicode(Handle, GWL_WNDPROC, Cardinal(newProc));
  end;
end;

procedure TAppWindow.IntSwapWndProc;
begin
  if SendMessage(Handle, WM_REMOVING_WNDPROC, Longint(OldWindowProc), Longint(NewWindowProc)) <> 1 then
    SendMessage(Handle, WM_ADXDELPROC, Longint(@NewWindowProc), Longint(@OldWindowProc));
end;

{$IFDEF SupportAdjacentWindow}
function TAppWindow.DoNegotiateWindowMessage(msg: Cardinal; wParam, lParam: Integer): longint;
begin
  Result:= 0;
  if Assigned(FOnNegotiateWindowMessage) then
    Result:= FOnNegotiateWindowMessage(msg, wParam, lParam);
end;
{$ENDIF}

{ TAdxContainerPane }

constructor TAdxContainerPane.CreateEx(AContainer: TAdxContainer);
begin
  inherited visible:= false;
  FVisible:= false;
  FHostVersion:= vUnknown;
  FContainer := AContainer; 
  if Assigned(AContainer) then
    FAdxControl:= AContainer.Owner;

  FAppWindow:= FAdxControl.AppWindow;
  if not Assigned(FAppWindow) then
    ExceptionManager.ProcessADXXError(Exception.Create('AppWindow is nil'), ClassName+'.CreateEx');

  FPreset:= tpsDefault;
  FOptions:= [];
  FHeaderHeight:= HeaderHeight2000;
  FUpdateCount:= 0;
  FStartIndex:= 0;
  FTaskCaption:= '';
  FDragMousePos:= Point(0, 0);
  FDelayBeforeDrag:= 0;
  FPaintMutex:= CreateMutex(nil, false, nil);

  CreateParented(GetDesktopWindow);
  {$IFDEF SupportAdjacentWindow}
  FAppController:= TAppWindowController.Create(FAppWindow, self);
  {$ENDIF}

  Caption:= 'AdxTaskPane';
  Options:= [];
  SetWindowLongCheckUnicode(Handle, GWL_STYLE, WS_CHILDWINDOW or WS_CLIPSIBLINGS);
  UnSetExWinAPIProperty(Handle, WS_EX_CONTROLPARENT);
  TaskCaption:= '';
  Font.Color:= $000000;
  ListControl:= TadxContextMenu.CreateEx(self);

  FMainParts:= CreatePainter;
  FCanvasChanged:= true;
  FHighLighController:= TadxHighlightController.Create(self);

  {Allow window to accept drop events}
  OleCheck(RegisterDragDrop(Handle, Self));
end;

function TadxContainerPane.CreatePainter: TadxPanePart;
begin
  result:= TadxPanePartMain.Create(self, nil, 0)
end;

procedure TadxContainerPane.CreateSplitterRuler(SplitBounds: TRect);
begin
  if not Assigned(FSplitterRuler) then
    FSplitterRuler:= TadxSplitterRuler.Create(self, SplitBounds);
end;

destructor TAdxContainerPane.Destroy;
var
  step: string;
begin
  Log.AddMessage('TAdxContainerPane.Destroy');
  try
    if Assigned(ListControl) then begin
      if (ListControl.Items <> nil) then begin
        step := 'ListControl.Items.Clear';
        ListControl.Items.Clear;
      end;
      step := 'ListControl.Free';
      ListControl.Free;
      ListControl := nil;
    end;

    if Assigned(FHighLighController) then begin
      step := 'FBlinkController.Destroy';
      FreeAndNil(FHighLighController);
    end;

    if Assigned(FMainParts) then begin
      step := 'FMainParts.Destroy';
      FreeAndNil(FMainParts);
    end;

    if Assigned(FSplitterRuler) then begin
      step := 'FSplitterRuler.Destroy';
      FreeAndNil(FSplitterRuler);
    end;
    FAdxControl:= nil;

    if Assigned(FBitmap) then begin
      step := 'FBitmap.Destroy';
      FreeAndNil(FBitmap);
    end;

    if Assigned(FGradientBitmap) then begin
      step := 'FGradientBitmap.Destroy';
      FreeAndNil(FGradientBitmap);
    end;

    {$IFDEF SupportAdjacentWindow}
    if Assigned(FAppController) then begin
      step := 'FAppController.Destroy';
      FreeAndNil(FAppController);
    end;
    {$ENDIF}

    if (FPaintMutex > 0) then begin
      step := 'CloseHandle(FPaintMutex)';
      CloseHandle(FPaintMutex);
    end;

    step := 'RevokeDragDrop';
    RevokeDragDrop(Handle);

    step := 'inherited';
    inherited;
  except
    on E:SysUtils.Exception do begin
      Log.AddException('TAdxContainerPane.Destroy ' + step + ' ' + E.Message);
      raise E;
    end;
  end;
end;

procedure TadxContainerPane.DoActionCloseForm(Sender: TObject);
begin
if Assigned(AdxControl) then begin
    PostMessage(PAppWindowProperty(AdxControl.FAppWindowProperty)^.ReceiverHandle, WM_ADXCLOSEBUTTONCLICK,
    AdxControl.Handle, 0);
  end;
end;

procedure TadxContainerPane.DoActionDraggingForm(MouseOffset: TPoint);
var
  needHandle: HWND;
  needIndex: integer;
  adxContainerForm: PadxContainerForm;

begin
  try
    if not TestLWA then begin
      Log.AddWarning('Extensions DragAndDrop not supported in this version Windows.');
      exit;
    end;
    if not Assigned(FDragContainer) then begin
      needHandle:= 0;
      if Assigned(SelectedPart) then begin
        if IsMinimizedState then begin
          if (SelectedPart.EnableDrag) and (SelectedPart is TadxPanePartGalleryItem) then begin
            needIndex := TadxPanePartGalleryItem(SelectedPart).IndexOf;
            adxContainerForm:= GetPaneItem(needIndex);
            if Assigned(adxContainerForm) then
              needHandle := adxContainerForm^.param.FormHandle
            else
              if Assigned(AdxControl) then needHandle := AdxControl.Handle;
          end;
        end
        else begin
          if Assigned(AdxControl) and SelectedPart.EnableDrag and (not AdxControl.IsClientLayout) then
            needHandle := AdxControl.Handle;
        end;
      end;
      if needHandle > 0 then begin
        if Assigned(AdxControl) then
          AdxControl.ReleaseFloating;
        if not Assigned(FDragContainer) then
          FDragContainer:= TadxRegionDragContainer.CreateEx(self, needHandle);
        FDragContainer.MousePassing(MouseOffset);
      end;
    end
    else begin
      if FDragContainer.Visible then
        FDragContainer.MousePassing(MouseOffset);
    end;
  except
    on e: Exception do begin
      Log.AddException('TadxContainerPane.DoActionDraggingForm: '+ e.Message);
      if Assigned(FDragContainer) then
        FreeAndNil(FDragContainer);
      raise e;
    end;
  end;
end;

procedure TadxContainerPane.DoActionHide(Sender: TObject);
begin
  if Assigned(FAppWindow) then
    AdxLockWindowUpdate(FAppWindow.Parent);
  try
    case FAdxControl.FormRegion.State of
      irsHidden: FAdxControl.SetFormRegionState(irsNormal);
      irsNormal: begin
        FAdxControl.SetFormRegionState(irsHidden);
        if IsWindowVisible(HostHandle) then
          Windows.SetFocus(HostHandle);
      end;
    end;
  finally
    AdxLockWindowUpdate(0);
  end;
end;

procedure TadxContainerPane.DoActionMenuOpen(Sender: TObject);
var
  R: TRect;
begin
  R:= TadxPanePart(Sender).FBounds;
  Windows.ClientToScreen(handle, R.BottomRight);
  ListControl.Popup(R.Right+1, R.Bottom);
end;

procedure TadxContainerPane.DoActionMinimize(Sender: TObject);
var
  adxFormHandle: HWND;
begin
  if Assigned(AdxControl) then begin
    //FPartsChanged:= true;
    AdxLockWindowUpdate(HostHandle);
    try
      case AdxControl.FormRegion.State of
        irsNormal: AdxControl.SetFormRegionState(irsMinimized);
        irsMinimized: begin
          adxFormHandle:= FFloatingFormHandle;

          FloatingFormHandle:= 0;
          if (adxFormHandle > 0) and (adxFormHandle <> AdxControl.Handle) then begin
            if SendMessage(adxFormHandle, WM_ADXCOMMAND, adxFormActivate, 0) = adxMessageResult then
              AdxControl.ReleaseFloating;
          end
          else
            AdxControl.Activate;
        end;
      end;
    finally
      AdxLockWindowUpdate(0);
    end;
  end;
end;

procedure TadxContainerPane.DoActionSelectBack(Sender: TObject);
var
  index: integer;
begin
  index:= FContainer.GetIndex(AdxControl.FormParam);
  if index > 0 then begin
    ListControl.Items[Index-1].Default:= true;
    FAdxControl.AdxExtract(Index-1);
  end;
end;

procedure TadxContainerPane.DoActionSelectNext(Sender: TObject);
var
  index: integer;
begin
  index:= FContainer.GetIndex(AdxControl.FormParam);
  if index < FContainer.Count then begin
    ListControl.Items[Index+1].Default:= true;
    FAdxControl.AdxExtract(Index+1);
  end;
end;

procedure TadxContainerPane.DoActionShowForm(Sender: TObject);
var
  adxContainerForm: PadxContainerForm;
  needHandle: Hwnd;
  needIndex: integer;
begin
  needHandle:= 0; needIndex:= -1;
  if (Sender is TadxPanePartGalleryItem) and Assigned(AdxControl) then begin
    needIndex:= TadxPanePartGalleryItem(Sender).IndexOf;
    adxContainerForm:= GetPaneItem(needIndex);
    if (adxContainerForm <> nil) and (adxContainerForm^.param <> nil) then
      needHandle := adxContainerForm^.param.FormHandle
    else begin
      needHandle := AdxControl.Handle;
      needIndex:= -1;
    end;
  end;
  if needHandle = FloatingFormHandle then
    FloatingFormHandle:= 0
  else begin
    if SendMessage(needHandle, WM_ADXSUPPORTMINIMIZE, 0, 0) = adxMessageResult then
      FloatingFormHandle:= needHandle
    else begin
      FloatingFormHandle:= 0;
      Hide;
      if Assigned(AdxControl) then begin
        AdxControl.AdxExtract(needIndex);
      end;
    end;
  end;
  TadxPanePartGalleryItem(Sender).State:= isUp;
end;

procedure TadxContainerPane.DoActionStopDragging;
begin
  if Assigned(FDragContainer) then begin
    try
      FDragContainer.DoMouseSelect(nil);
    finally
      FreeAndNil(FDragContainer);
    end;
  end;
end;

procedure TadxContainerPane.DoResize;
var
  wPos: TWindowPos;
begin
  if (Left <> ScreenPos.x) or (Top <> ScreenPos.y) or (Width <> ScreenPos.cx) or (Height <> ScreenPos.cy) then
    FNeedResize:= true;

  if  FNeedResize then begin
    CanvasChanged;
    FNeedResize:= false;
    SetWindowPos(Handle, PositionInZOrder, ScreenPos.x, ScreenPos.y, ScreenPos.cx, ScreenPos.cy, ScreenPos.flags);
    if Assigned(FAdxControl) then begin
      SetWindowPos(FAdxControl.Handle, 0, FAdxControl.ScreenPos.x, FAdxControl.ScreenPos.y, FAdxControl.ScreenPos.cx, FAdxControl.ScreenPos.cy, SWP_NOZORDER or SWP_NOACTIVATE);
      if FAppVersion = v2010 then
        FAdxControl.Update;
    end;

    if IsMinimizedState and (FloatingFormHandle > 0) then begin
      wPos:= AdxControl.ScreenPos;
      SendMessage(FloatingFormHandle, WM_ADXSETFLOATINGPOS, 0, Cardinal(@wPos));
    end;
  end;
end;

procedure TadxContainerPane.DoThemeChanged;
begin
  inherited;
  CanvasChanged;
  if (FHostVersion = v2010) and Assigned(FAppWindow) then
    FAppWindow.AdxRefresh;
  if Visible then
    Invalidate;
end;

function TadxContainerPane.DragEnter(const dataObj: IDataObject;
  grfKeyState: Integer; pt: TPoint; var dwEffect: Integer): HResult;
begin
  dwEffect := DROPEFFECT_MOVE;
  FLastDataObject:= dataObj;
  Result  := S_OK;
end;

function TadxContainerPane.DragLeave: HResult;
begin
  Result := S_OK;
  FLastDataObject:= nil;
  DragSelectedPart:= nil;
end;

function TadxContainerPane.DragOver(grfKeyState: Integer; pt: TPoint;
  var dwEffect: Integer): HResult;
var
  params: TadxDragOverMinimizedParams;
begin
  Result := S_OK;
  dwEffect:= DROPEFFECT_NONE;
  DragSelectedPart:= FMainParts.FindPart(GetMouseCursorPos());

  if FTempFormHandle > 0 then begin
    params.KeyState:= grfKeyState;
    params.pt:= pt;
    params.dataObj:= Cardinal(FLastDataObject);
    params.Effect:= DROPEFFECT_MOVE;
    params.Expand:= false;
    dwEffect:= params.Effect;

    if FloatingFormHandle = 0 then
    if SendMessage(FTempFormHandle, WM_ADXDRAGOVERMINIMIZED, 0, Cardinal(@params)) = adxMessageResult then begin
      if params.Expand then begin
        SelectedPart:= DragSelectedPart;
        DoActionShowForm(DragSelectedPart);
        dwEffect:= DROPEFFECT_MOVE;
      end;
    end;
  end;
end;

function TadxContainerPane.Drop(const dataObj: IDataObject;
  grfKeyState: Integer; pt: TPoint; var dwEffect: Integer): HResult;
begin
  Result := S_OK;
  FLastDataObject:= nil;
  FloatingFormHandle:= 0;
end;

procedure TadxContainerPane.DrawIcon(ACanvas: TadxGPGraphics; ARect: Trect);
var
  icon: TadxGPBitmap;
begin
  if Assigned(FAdxControl) then begin
    icon:= FAdxControl.IconImage;
    if Assigned(icon) then begin
      ACanvas.DrawImage(icon, MakeRect(ARect));
    end;
  end;
end;

procedure TadxContainerPane.DrawMenuItem(dc: HDC; AMenuItem: TMenuItem;
  ARect: TRect; State: TOwnerDrawState);
var
  iconAreaOffset, fontWeight, iW, iH, index: longint;
  gpFont: TadxGPFont;
  ACanvas: TadxGPGraphics;
  pen: TadxGPPen;
  brush: TadxGPSolidBrush;
  pFormItem: PadxContainerForm;
  iconRect: TGPRect;
  textSize: TSize;
  textLayout: TGPPointF;
  itemCaption: string;
  isHighlight: boolean;

begin
  iW:= TaskIconWidth; iH:= TaskIconHeight; fontWeight:= FW_REGULAR;
  iconAreaOffset:= round(TaskMenuItemHeight* 1.2);
  isHighlight:= IsItemHighlight(AMenuItem.MenuIndex);

  ACanvas:= TadxGPGraphics.Create(dc);

  brush:= TadxGPSolidBrush.Create(colorBlack);
  try
    if (odSelected in State) or isHighlight then begin
      pen:= TadxGPPen.Create(FMenuColor.ItemBorder);
      brush.SetColor(FMenuColor.ItemSelected);
      if Preset = tpsDefault then begin
        brush.SetColor(MakeColor($C1, $D2, $EE));
        pen.SetColor(MakeColor($31, $6A, $C5));
      end;
      ACanvas.FillRectangle(brush, MakeRect(ARect.Left, ARect.Top, GetRectWidth(ARect)-1, GetRectHeight(ARect)-1));
      ACanvas.DrawRectangle(pen, MakeRect(ARect.Left, ARect.Top, GetRectWidth(ARect)-1, GetRectHeight(ARect)-1));
      pen.Free;
    end
    else begin
      brush.SetColor(FMenuColor.ItemBackGround);
      ACanvas.FillRectangle(brush, MakeRect(ARect));

      brush.SetColor(FMenuColor.ItemIconArea);
      if Preset = tpsDefault then
        brush.SetColor(GPSystemColor(COLOR_BTNFACE));
      ACanvas.FillRectangle(brush, MakeRect(ARect.Left, ARect.Top, iconAreaOffset, GetRectHeight(ARect)));
    end;

    index:= AMenuItem.MenuIndex;
    if index >= 0 then begin
      pFormItem:= PadxContainerForm(FContainer[index]);
      if Assigned(pFormItem) then begin
        if pFormItem^.glyph is TadxGPImage then begin
          iconRect:= MakeRect(ARect.Left+ (iconAreaOffset - iW) div 2, ARect.Top+ (TaskMenuItemHeight - iH) div 2, iW, iH);
          ACanvas.DrawImage((pFormItem^.glyph as TadxGPImage), iconRect);
        end;

        itemCaption:= string(pFormItem^.param.Caption);
        if AmenuItem.Default then
          fontWeight:= FW_BOLD;

        gpFont:= TadxGPFont.Create(dc, GetSystemFontHandle(MenuFont, fontWeight));
        if (gpFont.GDIResult <> Ok) then begin
          gpFont.Free;
          TadxMenuItem(AMenuItem).UpdateFont;
          gpFont:= TadxGPFont.Create(dc, TadxMenuItem(AMenuItem).FFont.Handle);
        end;

        GPTextExtent(itemCaption, ACanvas, gpFont, textSize);

        textLayout.X:= TaskButtonOffset+ ARect.Left+ iconAreaOffset;
        textLayout.Y:= ARect.Top+ (GetRectHeight(ARect) - textSize.cy) / 2;
        brush.SetColor(colorBlack);
        ACanvas.DrawString(itemCaption, length(itemCaption), gpFont, textLayout, brush);
        gpFont.Free;
      end;
    end;

  finally
    brush.Free;
    ACanvas.Free;
  end;
end;

procedure TadxContainerPane.DrawMoveSplitter(APos: TPoint; ARect: TRect; MoveSplitter: boolean);
var
  ASize: TSize;
  dc: HDC;
begin
  if (FAppWindow <> nil) and (not FAdxControl.EnableSize) then begin
    dc:= GetWindowDC(FAppWindow.Parent);
    ASize.cx:= GetRectWidth(ARect);
    ASize.cy:= GetRectHeight(ARect);
    case FormLayout of
      wlRight, wlLeft: begin
        PatBlt(dc, ARect.Left+ apos.X, ARect.Top, ASize.cx+ 1, ASize.cy, PATINVERT);
        if MoveSplitter then
          SetSplitterMove(aPos.X, 0);
      end;
      wlBottom, wlTop: begin
        PatBlt(dc, ARect.Left, ARect.Top+ aPos.Y, ASize.cx, ASize.cy+ 1, PATINVERT);
        if MoveSplitter then
          SetSplitterMove(0, aPos.Y);
      end;
    end;
    ReleaseDC(FAppWindow.Parent, dc);
  end;
end;

procedure TadxContainerPane.DrawSplitter(ACanvas: TadxGPGraphics; ARect: TRect);
begin
  case AdxControl.HostVersion of
    v2000, v2002, vOe6, vOeVista:
      DrawBackGround(ACanvas, ARect, drwSimple);

    v2003: begin
             if FAdxControl.IsInspectorForm then begin
               DrawBackGround(ACanvas, ARect, drwSimple);
             end
             else begin
               DrawBackGround(ACanvas, ARect, drwThemed);
             end;
           end;

    v2007: begin
             if FAdxControl.IsInspectorForm then
               DrawBackGround(ACanvas, ARect, drwThemed);
           end;
  end;
end;

function TadxContainerPane.EnableClose: boolean;
begin
  result:= false;
  if Assigned(AdxControl) then begin
    result:= AdxControl.FCloseButtonOnHeader;
  end;
end;

function TadxContainerPane.EnableIcon(index: integer): boolean;
begin
  result:= false;
  if Assigned(PaneItems) and (PaneItems.Count > 0) and (index >= 0) and (index < PaneItems.Count) then begin
    result:= Assigned(PadxContainerForm(PaneItems[index])^.glyph);
  end
  else begin
    if Assigned(FAdxControl) then
      result:= not FAdxControl.Icon.Empty;
  end;
end;

function TadxContainerPane.EnableMinimize: boolean;
begin
  result:= false;
  if Assigned(AdxControl) then
    result:= AdxControl.Layout < wlClient;
end;

function TadxContainerPane.EnableMinimizeRegion: boolean;
begin
  result:= true;
  if Assigned(FAdxControl) then
    result:= FAdxControl.EnableMinimizeRegion;
end;

function TadxContainerPane.EnableNavigation: boolean;
begin
  result:= false;
  if Assigned(FContainer) then begin
    result:= (FContainer.Count > 1);
  end;
end;

function TadxContainerPane.EnableScroll(next: boolean): boolean;
begin
  result:= false;
  if Assigned(FAdxControl) and Assigned(FContainer) then begin
    if next then
      result:= (FContainer.GetIndex(FAdxControl.FormParam) < FContainer.Count-1)
    else
      result:= (FContainer.GetIndex(FAdxControl.FormParam) > 0);
  end;
end;

function TadxContainerPane.EnableSplitterResize: boolean;
begin
  Result:= true;
  if Assigned(FAdxControl) then
    Result:= FAdxControl.EnableSize;
end;

procedure TadxContainerPane.RecalcScreenPosition;
var
  SplitSize, MinHeight, HeaderSize: integer;
  FrameChanged: boolean;
  acFlags: Cardinal;
  pOffset: TRect;
begin
  try
    if FAppWindow.Handle <= 0 then exit;
    FrameChanged:= (FAppWindow.MainPos.flags and SWP_FRAMECHANGED <> 0);
    pOffset:= PaneOffset;

    if FAdxControl.FormRegion.State = irsHidden then
      SplitSize:= SplitterDepth.Collapsed
    else
      SplitSize := SplitterDepth.Normal;

    HeaderSize:= 0;
    MinHeight:= MinAppWindowHeight;
    if IsHeaderVisible then begin
      MinHeight:= HeaderHeight + SplitSize + 1;
      HeaderSize:= HeaderHeight;
    end;

    ScreenPos:= FAppWindow.MainPos;
    FAppWindow.ScreenPos:= FAppWindow.MainPos;

    case FAdxControl.Layout of
      wlClient:  begin
                   FAdxControl.FSplitterStyle:= spltOff;
                   if FAdxControl.IsClientLayout then begin
                     if IsHeaderVisible then begin
                       ScreenPos.cy:= HeaderSize+ SplitSize+ pOffset.Top+ pOffset.Bottom+ 1;

                       FAppWindow.ScreenPos.y  := FAppWindow.ScreenPos.y  + ScreenPos.cy;
                       FAppWindow.ScreenPos.cy := FAppWindow.ScreenPos.cy - ScreenPos.cy;
                     end
                     else begin
                       ScreenPos.cx:= 0;
                       ScreenPos.cy:= 0;
                     end;
                   end
                   else
                     FAppWindow.ScreenPos.cx:= 0;
                  end;
      wlLeft:     begin
                    ScreenPos.cx := UserWidth + SplitterMove.X;
                    if FrameChanged then begin
                      ScreenPos.x := left;
                      FAppWindow.MainPos.x := ScreenPos.x;
                      FAppWindow.MainPos.cx := FAppWindow.MainPos.cx + ScreenPos.cx;
                    end;
                    if (SplitterMove.X <> 0) and FAdxControl.Injected then
                      UserWidth:= ScreenPos.cx;

                    //Constrains ==================================================
                    if ScreenPos.cx > FAppWindow.MainPos.cx - MinAppWindowWidth then begin
                      ScreenPos.cx := FAppWindow.MainPos.cx - MinAppWindowWidth;
                      if SplitterMove.X <> 0 then
                        UserWidth:= ScreenPos.cx;
                    end
                    else
                    if ScreenPos.cx < MinAppWindowWidth then begin
                      ScreenPos.cx:= MinAppWindowWidth;
                      if SplitterMove.X <> 0 then
                        UserWidth:= ScreenPos.cx;
                    end;
                    //=============================================================

                    case FAdxControl.FormRegion.State of
                      irsHidden:    ScreenPos.cx:= SplitSize;
                      irsMinimized: ScreenPos.cx:= HeaderSize+ SplitSize;
                    end;
                    inc(ScreenPos.cx, pOffset.Left+ pOffset.Right);

                    FAppWindow.ScreenPos.x  := FAppWindow.ScreenPos.x  + ScreenPos.cx * byte(not FrameChanged);
                    FAppWindow.ScreenPos.cx := FAppWindow.ScreenPos.cx - ScreenPos.cx * byte(not FrameChanged);
                  end;

      wlRight:    begin
                    ScreenPos.cx := UserWidth- SplitterMove.X;
                    if FrameChanged then
                      FAppWindow.MainPos.cx := FAppWindow.MainPos.cx + ScreenPos.cx;

                    if (SplitterMove.X <> 0) and FAdxControl.Injected then
                      UserWidth:= ScreenPos.cx;

                    //Constrains ==================================================
                    if ScreenPos.cx > FAppWindow.MainPos.cx - MinAppWindowWidth then begin
                      ScreenPos.cx := FAppWindow.MainPos.cx - MinAppWindowWidth;
                      if SplitterMove.X <> 0 then
                        UserWidth:= ScreenPos.cx;
                    end
                    else
                    if ScreenPos.cx < MinAppWindowWidth then begin
                      ScreenPos.cx:= MinAppWindowWidth;
                      if SplitterMove.X <> 0 then
                        UserWidth:= ScreenPos.cx;
                    end;
                    //=============================================================

                    case FAdxControl.FormRegion.State of
                      irsHidden:    ScreenPos.cx := SplitSize;
                      irsMinimized: ScreenPos.cx := HeaderSize+ SplitSize;
                    end;
                    inc(ScreenPos.cx, pOffset.Left+ pOffset.Right);

                    ScreenPos.x  := FAppWindow.MainPos.x + FAppWindow.MainPos.cx - ScreenPos.cx;
                    FAppWindow.ScreenPos.cx := FAppWindow.ScreenPos.cx - ScreenPos.cx;
                  end;

      wlTop:      begin
                    ScreenPos.cy := UserHeight + SplitterMove.Y;
                    if FrameChanged then begin
                      ScreenPos.y := top; FAppWindow.MainPos.y := ScreenPos.y;
                      FAppWindow.MainPos.cy := FAppWindow.MainPos.cy + ScreenPos.cy;
                    end;
                    if (SplitterMove.Y <> 0) and FAdxControl.Injected then
                      UserHeight:= ScreenPos.cy;

                    if IsHeaderVisible then
                      inc(ScreenPos.cy, HeaderSize);

                    //Constrains ==================================================
                    if ScreenPos.cy > FAppWindow.MainPos.cy - MinAppWindowHeight then begin
                      ScreenPos.cy := FAppWindow.MainPos.cy - MinAppWindowHeight;
                      if SplitterMove.Y <> 0 then
                        UserHeight:= ScreenPos.cy- HeaderSize;
                    end
                    else
                    if ScreenPos.cy < MinHeight then begin
                      ScreenPos.cy:= MinHeight;
                      if SplitterMove.Y <> 0 then
                        UserHeight:= ScreenPos.cy- HeaderHeight;
                    end;
                    //=============================================================

                    case FAdxControl.FormRegion.State of
                      irsHidden:    ScreenPos.cy := SplitSize;
                      irsMinimized: ScreenPos.cy := HeaderSize+ SplitSize
                    end;
                    inc(ScreenPos.cy, pOffset.Top+ pOffset.Bottom);

                    FAppWindow.ScreenPos.y  := FAppWindow.ScreenPos.y  + ScreenPos.cy * byte(not FrameChanged);
                    FAppWindow.ScreenPos.cy := FAppWindow.ScreenPos.cy - ScreenPos.cy * byte(not FrameChanged);
                  end;

      wlBottom:   begin
                    ScreenPos.cy := UserHeight- SplitterMove.Y;
                    if FrameChanged then
                      FAppWindow.MainPos.cy := FAppWindow.MainPos.cy + ScreenPos.cy;

                    if (SplitterMove.Y <> 0) and FAdxControl.Injected then
                      UserHeight:= ScreenPos.cy;

                    if IsHeaderVisible then
                      inc(ScreenPos.cy, HeaderSize);

                    //Constrains ==================================================
                    if ScreenPos.cy > FAppWindow.MainPos.cy  - MinAppWindowHeight then begin
                      ScreenPos.cy := FAppWindow.MainPos.cy - MinAppWindowHeight;
                      if SplitterMove.Y <> 0 then
                        UserHeight:= ScreenPos.cy- HeaderSize;
                    end
                    else
                    if ScreenPos.cy < MinHeight then begin
                      ScreenPos.cy:= MinHeight;
                      if SplitterMove.Y <> 0 then
                        UserHeight:= ScreenPos.cy- HeaderHeight;
                    end;
                    //=============================================================

                    case FAdxControl.FormRegion.State of
                      irsHidden: ScreenPos.cy:= SplitSize;
                      irsMinimized: ScreenPos.cy:= HeaderSize+ SplitSize;
                    end;
                    inc(ScreenPos.cy, pOffset.Top+ pOffset.Bottom);

                    ScreenPos.y:= FAppWindow.MainPos.y + FAppWindow.MainPos.cy - ScreenPos.cy;
                    FAppWindow.ScreenPos.cy := FAppWindow.ScreenPos.cy - ScreenPos.cy * byte(not FrameChanged);
                  end;

      wlDockLeft: begin
                    inc(FAppWindow.ScreenPos.x, fAppWindow.ScreenPos.cx);
                    FAppWindow.ScreenPos.cx := 0;
                    UserWidth := ScreenPos.cx - (pOffset.Left + pOffset.Right);
                  end;
      wlDockRight: begin
                    FAppWindow.ScreenPos.cx := 0;
                    UserWidth := ScreenPos.cx - (pOffset.Left + pOffset.Right);
                  end;
      wlDockTop:  begin
                    inc(FAppWindow.ScreenPos.y, FAppWindow.ScreenPos.cy);
                    FAppWindow.ScreenPos.cy := 0;
                    UserHeight := ScreenPos.cy - headerSize - (pOffset.Top + pOffset.Bottom);
                  end;
      wlDockBottom: begin
                    FAppWindow.ScreenPos.cy := 0;
                    UserHeight := ScreenPos.cy - headerSize - (pOffset.Top + pOffset.Bottom);
                  end;
    end;

    acFlags := 0;
    if (ScreenPos.cx = Width) and (ScreenPos.cy = Height) then
      acFlags := SWP_NOSIZE;
    if PositionInZOrder <> HWND_TOP then
      ScreenPos.flags := SWP_NOACTIVATE or acFlags
    else
      ScreenPos.flags := SWP_NOACTIVATE or SWP_NOZORDER or acFlags;

    OffsetPanePosition;
    if FloatingFormHandle > 0 then begin
      FAppWindow.ScreenPos.hwndInsertAfter:= FloatingFormHandle;
      FAppWindow.ScreenPos.flags:= FAppWindow.ScreenPos.flags and (not SWP_NOZORDER);
    end;

  except
    on E: SysUtils.Exception do begin
      Log.AddException(ClassName+'.RecalcScreenPosition: '+E.Message);
      raise E;
    end;
  end;
end;

procedure TadxContainerPane.RecreateParts(AWidth, AHeight: integer);
begin
  CanvasChanged;
  FSelectedPart := nil;
  FMainParts.Initialize;
  FMainParts.Bounds:= Rect(0, 0, AWidth, AHeight);
  PostMessage(Handle, WM_PAINT, 0, 0);
end;

procedure TadxContainerPane.SetDragSelectedPart(const Value: TAdxPanePart);
var
  needIndex: integer;
  containerForm: PadxContainerForm;
begin
  if FDragSelectedPart <> Value then begin
    FDragSelectedPart := Value;
    if FDragSelectedPart = nil then begin
      FTempFormHandle:= 0;
      exit;
    end;

    if FDragSelectedPart is TadxPanePartGalleryItem then begin
      needIndex:= TadxPanePartGalleryItem(FDragSelectedPart).IndexOf;
      containerForm:= GetPaneItem(needIndex);
      if containerForm <> nil then
        FTempFormHandle:= containerForm^.param.FormHandle
      else
        FTempFormHandle:= FAdxControl.Handle;
    end;
  end;
end;

function TadxContainerPane.ShowFormFloating(formHandle: HWND): boolean;
var
  wPos: TWindowPos;
  headerSize: integer;
begin
  wPos:= ScreenPos;
  if SendMessage(formHandle, WM_ADXREDESIGNSUPPORT, reDesignVersion, 0) <> adxMessageResult then begin
    //For compatibility with version ADX 2009
    headerSize:= HeaderHeight;
    case FormLayout of
      wlLeft:   inc(wPos.x, headerSize);
      wlRight:  dec(wPos.x, headerSize);
      wlTop:    inc(wPos.y, headerSize);
      wlBottom: dec(wPos.y, headerSize);
    end;
  end;
  result:= (SendMessage(formHandle, WM_ADXSHOWFLOATING, Handle, Cardinal(@wPos)) = adxMessageResult);
end;

procedure TadxContainerPane.HighlightRequest(BlinkParam: PadxBlinkParam);
var
  param: TadxBlinkParam;
  i: integer;
begin
  param:= BlinkParam^;
  i:= -1;
  if Assigned(FHighLighController) then begin
    if FContainer.Count > 0 then
      i:= FContainer.GetIndex(param.formHandle);
    if StartIndex <> i then
      StartIndex:= i;
    FHighLighController.Initialize(param);
  end;
end;

procedure TadxContainerPane.SetFloatingFormHandle(const Value: Hwnd);
begin
  if FFloatingFormHandle <> value then begin
    if FFloatingFormHandle > 0 then begin
      SendMessage(FFloatingFormHandle, WM_ADXHIDEFLOATING, 0, 0);

      PaintAll(AdxControl.FAppWindow.Handle);;
      HostEnableWindow(true);

      BeginUpdate;
      FMainParts.ResetState(isUp, nil, true);
      CanvasChanged;
      EndUpdate;
    end;
    if Value > 0 then begin
      HostEnableWindow(false);
      if not ShowFormFloating(Value) then begin
        FFloatingFormHandle:= 0;
        exit;
      end;
    end;
    FFloatingFormHandle := Value;
  end;
end;

//procedure TadxContainerPane.SetItemCaption(param: PadxFormParam; NewCaption: string);
//var
//  index: integer;
//begin
//  if Assigned(FContainer) then begin
//    index:= FContainer.GetIndex(param);
//    if index >= 0 then begin
//    {$IFDEF UNICODE}
//      StrPCopy(PadxContainerForm(FContainer[index])^.param^.Caption, AnsiString(NewCaption));
//    {$ELSE}
//      StrPCopy(PadxContainerForm(FContainer[index])^.param^.Caption, NewCaption);
//    {$ENDIF}
//      ListControl.Items[index].Caption:= NewCaption;
//    end;
//  end;
//  TaskCaption:= ' '+ NewCaption;
//end;

procedure TAdxContainerPane.SetItemsList;
begin
  if Assigned(FContainer) and Assigned(FAdxControl) then
    ListControl.UpdateItems(FContainer, FAdxControl);
  NeedResize;
  RecreateParts(ScreenPos.cx, ScreenPos.cy);
end;

procedure TadxContainerPane.SetMouseCursor(ACursor: TCursor);
begin
  if (not IsMinimizedState) and (not EnableSplitterResize) then
    Cursor:= ACursor;
end;

procedure TAdxContainerPane.SetVisible(value: boolean);
begin
  if FVisible <> value then begin
    if Value then Show
    else Hide;
  end;
end;

procedure TAdxContainerPane.Show;
begin
  Windows.SetParent(Handle, FAdxControl.AppWindow.Parent);
  if not IsWindowVisible(handle) then begin
    BeginUpdate;
    try
      inherited visible:= true;
      FVisible:= true;
      CanvasChanged;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TadxContainerPane.SyncAdxRefresh;
begin
  if Assigned(FAppWindow) then
  try
    AdxLockWindowUpdate(FAppWindow.Parent);
    FAppWindow.AdxRefresh;
  finally
    AdxLockWindowUpdate(0);
  end;
end;

procedure TadxContainerPane.UpdateFormPosition(ABounds: TRect);
begin
  if Assigned(FAdxControl) then begin
    FAdxControl.ScreenPos.x:= ABounds.Left;
    FAdxControl.ScreenPos.y:= ABounds.Top;
    FAdxControl.ScreenPos.cx:= GetRectWidth(ABounds);
    FAdxControl.ScreenPos.cy:= GetRectHeight(ABounds);
  end;
end;

procedure TadxContainerPane.UpdateAppScrollBar;
begin

end;

procedure TadxContainerPane.WndProc(var Message: TMessage);
begin
  try
    inherited;
    if Message.Msg = WM_ADXCONTAINERHIDEFLOATING then begin
      if Cardinal(Message.WParam) = FloatingFormHandle then begin
        if Assigned(AdxControl) and (AdxControl.FHostHandle > 0) and (GetWindowLong(AdxControl.FHostHandle, GWL_STYLE) and WS_DISABLED > 0) then
          exit
        else
          FloatingFormHandle:= 0;
      end;
    end
    {$IFDEF SupportAdjacentWindow}
    else
    if Message.Msg = WM_NEGOTIATE_WINDOW_PANE then begin
      if Assigned(FAppController) then begin
        if Assigned(FAdxControl) and FAdxControl.IsSupportAdjacentWindow then
          Message.Result:= FAppController.HandleMessage(Message.Msg, Message.WParam, Message.LParam);
        exit;
      end;
    end
    {$ENDIF}
    else
    if Message.Msg = WM_ADXREDESIGNSUPPORT then begin
      Message.Result:= 0;
      if IsRedesignSupport(Message.WParam) then
        Message.Result:= adxMessageResult;
      exit;
    end

    else
    if Message.Msg = WM_CAPTURECHANGED then begin
      DoActionStopDragging;
    end
  except
    on e: Exception do
      TadxExceptionManager.ProcessADXXError(e, Format('%s.WndProc(%x, %x, %x).', [ClassName, Message.Msg, Message.WParam, Message.LParam]));
  end;
end;

function TadxContainerPane._AddRef: Integer;
begin
  //Ignore referance counting
  Result := 1;
end;

function TadxContainerPane._Release: Integer;
begin
  //Ignore referance counting
  Result := 1;
end;

procedure TAdxContainerPane.Hide;
begin
{$IFNDEF HideWithoutCheckVisibility}
  if IsWindowVisible(handle) then
{$ENDIF}
  begin
    inherited visible:= false; FVisible:= false;
  end;
  if Assigned(FMainParts) then
    FMainParts.DeleteParts;
  Windows.SetParent(handle, 0);
end;

procedure TadxContainerPane.HostEnableWindow(AEnabled: Boolean);
begin
  EnableWindow(AdxControl.FAppWindow.Handle, AEnabled);
end;

function TadxContainerPane.GetClipRect: TRect;
var
  wPos: TWindowPos;
begin
  Result:= Rect(0, 0, 0, 0);
  if (FAppWindow <> nil) then
    if SendMessage(FAppWindow.Handle, WM_ADXGETAPPWINDOWPOS, 0, Cardinal(@wPos)) = adxMessageResult then
      Result:= Rect(wPos.x, wPos.y, wPos.cx + wPos.x, wPos.cy + wPos.y);
end;

function TadxContainerPane.GetFormItemType: integer;
begin
  result:= stOlUnknown;
  if Assigned(FAdxControl) then
    result:= FAdxControl.ItemType;
end;

function TadxContainerPane.GetFormLayout: integer;
begin
  result:= 1;
  if Assigned(FAdxControl) then
    result:= FAdxControl.Layout;
end;

function TadxContainerPane.GetPaneItem(Index: integer): PadxContainerForm;
begin
  result:= nil;
  if Assigned(FContainer) then begin
    if FContainer.Count > 0 then begin
      if (Index >= 0) and (Index < FContainer.Count) then begin
        result:= PadxContainerForm(FContainer[Index]);
      end;
    end
  end;
end;

function TadxContainerPane.GetPaneItems: TList;
begin
  result:= nil;
  if Assigned(FContainer) then
    result:= FContainer;
end;

function TadxContainerPane.GetPaneLayout: TadxPaneLayout;
begin
  result:= plHorizontal;
  if Assigned(FAdxControl) then begin
    if IsMinimizedState then begin
      case FAdxControl.Layout of
        wlLeft, wlRight: result:= plVertical;
        wlTop, wlBottom: result:= plHorizontal;
      end;
    end
  end;
end;

function TadxContainerPane.GetPositionInZOrder: LongWord;
begin
  result:= HWND_TOP;
end;

function TadxContainerPane.GetPreset: TadxTaskPanePreset;
begin
  result:= FPreset;
end;

function TadxContainerPane.GetRegionBorderSize: integer;
begin
  Result:= 0;
  if Assigned(FAdxControl) then
  case FAdxControl.FRegionBorderStyle of
    rbsNone:    Result:= 0;
    rbsSingle:  Result:= 1;
  end;
end;

procedure TadxContainerPane.Initialize(AppVersion, ItemType: integer; AHostHandle: HWND);
begin
  inherited;
  FHostVersion:= AppVersion;
  case AppVersion of
    v2000, v2002: begin
                    Options:= [toShowBorder];
                    Preset:=  tpsDefault;
                  end;
    v2003:        begin
                    Options:= [toShowBorder];
                    Preset:=  tpsXP;
                  end;
    v2007,
    v2010:        begin
                    Options := [toShowBorder, toDraw2007];
                    Preset := tpsXP;
                  end;
  end;
end;

function TadxContainerPane.IsActiveIndex(index: integer): boolean;
var
  i: integer;
begin
  i:= -1;
  if FloatingFormHandle > 0 then
    i:= FContainer.GetIndex(FloatingFormHandle);
//  else begin
//    if Assigned(AdxControl) then
//      i:= FContainer.GetIndex(AdxControl.Handle);
//  end;
  result:= (i >= 0) and (i = index);
end;

function TadxContainerPane.IsItemHighlight(index: integer): boolean;
var
  i: integer;
begin
  Result:= false;
  if Assigned(FHighLighController) then begin
    if FContainer.Count > 0 then
      i:= FContainer.GetIndex(FHighLighController.FFormHandle)
    else
      i:= 0;
    Result:= (i >= 0) and (i = index) and FHighlighted;
//    if IsNormalState then
//      Result:= Result and (not AdxControl.InstanceFocused);
  end;
end;

function TadxContainerPane.IsClientLayout: boolean;
begin
  result:= false;
  if Assigned(FAdxControl) then
    result:=FAdxControl.IsClientLayout;
end;

function TadxContainerPane.IsHeaderVisible: boolean;
begin
  Result:= false;
  if Assigned(FAdxControl) then begin
    Result:= (FContainer.Count >= FAdxControl.MinFormOnContainerWhenShowHeader);
    {$IFDEF SUBSTINSPECTORREGION}
    if (FAdxControl.IsSubstInspectorRegion or FAdxControl.IsClientLayout) then begin
      Result := true;
      if fContainer.ExistCompleteRegions then
        Result:= false;
    end;
    {$ENDIF}
  end;
end;

function TadxContainerPane.IsHiddenState: boolean;
begin
  result:= false;
  if Assigned(AdxControl) then
    result:= (AdxControl.FormRegion.State = irsHidden);
end;

function TadxContainerPane.IsMinimizedState: boolean;
begin
  result:= false;
  if Assigned(AdxControl) then
    result:= (AdxControl.FormRegion.State = irsMinimized);
end;

function TadxContainerPane.IsNormalState: boolean;
begin
  result:= false;
  if Assigned(AdxControl) then
    result:= (AdxControl.FormRegion.State = irsNormal);
end;

function TadxContainerPane.IsSplitButtonVisible: boolean;
begin
  result:= false;
  if Assigned(FAdxControl) then
    result:= FAdxControl.FSplitButtonVisible;
end;

function TadxContainerPane.IsSplitterHighlight: boolean;
begin
  Result:= false;
  if IsHiddenState then
    Result:= FHighlighted;
end;

function TadxContainerPane.IsHeaderHighlight: boolean;
begin
  Result:= false;
  if IsNormalState then begin
    if FHighLighController.FormHandle <> AdxControl.Handle then
      Result:= FHighlighted
    else begin
      if FHighLighController.IsStoped then
        Result:= FHighlighted and (not AdxControl.InstanceFocused)
      else
        Result:= FHighlighted;
    end;
  end;
end;

function TadxContainerPane.IsSplitterVisible: boolean;
begin
  Result:= true;
  if Assigned(FAdxControl) then
    Result:= FAdxControl.IsSplitterVisible;
end;

procedure TadxContainerPane.NeedResize;
begin
  FNeedResize:= true;
end;

function TadxContainerPane.IsRedesignSupport(Version: integer): boolean;
begin
  result:= true;
  if Assigned(FAdxControl) then
    result:= FAdxControl.IsRedesignSupport(Version);
end;

procedure TadxContainerPane.OffsetPanePosition;
begin
end;

procedure TadxContainerPane.PaintBitmap(AWidth, AHeight: integer);
var
  grBitmap: TadxGPGraphics;
  clipRect: TRect;
begin
  if FCanvasChanged or (not Assigned(FBitmap)) then begin
    if Assigned(FBitmap) then
       FreeAndNil(FBitmap);
    clipRect:= Rect(0, 0, AWidth, AHeight);
    FBitmap:= TadxGPBitmap.Create(AWidth, AHeight);
    grBitmap:= TadxGPGraphics.Create(FBitmap);
    grBitmap.SetSmoothingMode(SmoothingModeHighQuality);
    try
      case Preset of
        tpsXP:      DrawBackGround(grBitmap, clipRect, drwThemed);
        tpsDefault: DrawBackGround(grBitmap, clipRect, drwSimple);
      end;
      if Assigned(FMainParts) then
        FMainParts.Paint(grBitmap);
    finally
      grBitmap.Free;
    end;
  end;
end;

procedure TadxContainerPane.PaintTo(DestDC: HDC; X, Y: integer);
var
  thisCanvas: TadxGPGraphics;
  clipRect: TRect;
  Rgn: TadxGPRegion;
begin
  if (WaitForSingleObject(FPaintMutex, 2000) = WAIT_OBJECT_0) then begin
    if DestDC = 0 then exit;

    clipRect:= Rect(0, 0, Width, Height);
    Rgn:= TadxGPRegion.Create(MakeRect(X, Y, GetRectWidth(clipRect), GetRectHeight(clipRect)));

    thisCanvas:= TadxGPGraphics.Create(DestDC);
    PaintBitmap(GetRectWidth(clipRect), GetRectHeight(clipRect));
    try
      if Assigned(FMainParts) then
        FMainParts.UpdateRegion(Rgn, X, Y);
    finally
      thisCanvas.SetClip(Rgn, CombineModeReplace);
      thisCanvas.DrawImage(FBitmap, X, Y);
      thisCanvas.Free;
      rgn.Free;
    end;
    FCanvasChanged:= false;
    ReleaseMutex(FPaintMutex);
  end;
end;

procedure TadxContainerPane.Paint;
begin
  if csDesigning in ComponentState then exit;
  Self.PaintTo(GetWindowDC(Handle), 0, 0);
end;

{ TadxContainerGetPictures }

constructor TadxContainerGetPictures.CreateEx(AOwner: TadxContainer; AFormHandle: Hwnd);
begin
  Create(true);
  FOwner:= AOwner;
  FFormHandle:= AFormHandle;
  FreeOnTerminate:= true;
  Priority:= tpNormal;
  Resume;
end;

procedure TadxContainerGetPictures.Execute;
var
  i: integer;
  pFormItem: PadxContainerForm;
begin
  while (not Terminated) and Assigned(FOwner) do begin
    if FOwner.BeginRequired then begin
      try
        for i:= 0 to FOwner.Count- 1 do begin
          pFormItem:= FOwner[i];
          if pFormItem <> nil then begin
             if (FFormHandle > 0) and (pFormItem^.param^.FormHandle <> FFormHandle) then
               Continue;
             pFormItem.glyph:= GetPictureFromHandle(pFormItem^.param^.FormHandle);
          end;
        end;
        Terminate;
      finally
        FOwner.EndRequired;
      end;
    end
      else sleep(100);
  end;
end;

function TadxContainerGetPictures.GetPictureFromHandle(AHandle: HWnd): TadxGPImage;
begin
  result:= nil;
  if AHandle > 0 then  begin
    PictureHelper.GetPictureFromAdxForm(AHandle, result);
  end;
end;

{ TAdxContainer }

function TadxContainer.ActivateClientLayout: boolean;
var
  i: integer;
  pFormItem: PadxContainerForm;
  formHandles: TList;
begin
  Result := false;
  FormHandles:= TList.Create;
  if Count > 0 then begin
    for i:= 0 to Count- 1 do begin
      pFormItem:= Items[i];
      formHandles.Add(Pointer(pFormItem^.param^.FormHandle));
    end;
  end;

  if (formHandles.Count > 0) then begin
    for i:= 0 to formHandles.Count- 1 do begin
      if (SendMessage(Cardinal(formHandles[i]), WM_ADXCOMMAND, adxActivateClientLayout, 0) = adxMessageResult) then
         Result := true;
    end;
  end;
  formHandles.Free;
end;

procedure TAdxContainer.AddForm(param: PAdxFormParam);
var
  fp_new: PadxContainerForm;
begin
  BeginRequired;
  try
    GetMem(fp_new, sizeof(TadxContainerForm));
    GetMem(fp_new^.param, sizeof(TadxFormParam));
    fp_new^.param^ := param^;
    fp_new^.glyph  := nil;
    Add(fp_new);
  finally
    EndRequired;
  end;
  UpdatePictures(param^.FormHandle);
end;

constructor TAdxContainer.CreateEx(AOwner: TadxForm);
begin
  Create;
  FMutex:= CreateMutex(nil, false, nil);
  Owner:= AOwner;
end;

procedure TAdxContainer.DeleteForm(param: PAdxFormParam);
var i: integer;
begin
  BeginRequired;
  try
    for i:= 0 to Count-1 do
      if PadxContainerForm(Items[i])^.param^.FormHandle = param^.FormHandle then begin
         FreeMem(PadxContainerForm(Items[i])^.param, sizeof(TadxFormParam));
         if Assigned(PadxContainerForm(Items[i])^.glyph) then
            FreeAndNil(PadxContainerForm(Items[i])^.glyph);
         FreeMem(Items[i], sizeof(TadxContainerForm));

         Items[i] := nil;
         Delete(i);
         Pack;
         break;
      end;
  finally
    EndRequired;
  end;
end;

procedure TAdxContainer.UpdateParam(param: PAdxFormParam);
var i: integer;
begin
  for i:= 0 to Count-1 do
    if PadxContainerForm(Items[i])^.param^.FormHandle = param^.FormHandle then begin
       PadxContainerForm(Items[i])^.param^.ItemType := param^.ItemType;
       PadxContainerForm(Items[i])^.param^.Layout := param^.Layout;
       break;
    end;
end;

procedure TadxContainer.UpdatePictures(FormHandle: Hwnd);
var
  i: integer;
  pFormItem: PadxContainerForm;
begin
  BeginRequired;
  try
    for i:= 0 to Count- 1 do begin
      pFormItem:= Items[i];
      if pFormItem <> nil then begin
         if (FormHandle > 0) and (pFormItem^.param^.FormHandle <> FormHandle) then
           Continue;
         pFormItem^.glyph:= GetPictureFromHandle(pFormItem^.param^.FormHandle);
      end;
    end;
  finally
    EndRequired;
  end;
end;

function TAdxContainer.GetIndex(param: PAdxFormParam): integer;
var
  i: integer;
begin
  Result:= -1;
  if Count <= 0 then exit;
  for i:= 0 to Count-1 do
    if PadxContainerForm(Items[i])^.param^.FormHandle = param^.FormHandle then begin
       Result:= i;
       break;
    end;
end;

function TadxContainer.GetIndex(FormHandle: HWnd): integer;
var
  i: integer;
begin
  Result:= -1;
  if Count <= 0 then exit;
  for i:= 0 to Count-1 do
    if PadxContainerForm(Items[i])^.param^.FormHandle = FormHandle then begin
       Result:= i;
       break;
    end;
end;

destructor TAdxContainer.Destroy;
begin
  try
    ClearListForm;

    if FMutex > 0 then
      CloseHandle(FMutex);
    inherited Destroy;
  except
    on E:SysUtils.Exception do begin
      Log.AddException('TAdxContainer.Destroy ' + E.Message);
      raise E;
    end;
  end;
end;

procedure TadxContainer.EndRequired;
begin
  ReleaseMutex(FMutex);
end;

function TadxContainer.ExistClientLayout: boolean;
var
  i: integer;
  formHandle: Hwnd;
begin
  Result:= false;
  if Count > 0 then begin
    for i:= 0 to Count-1 do begin
      formHandle:= PadxContainerForm(Items[i])^.param^.FormHandle;
      if SendMessage(formHandle, WM_ADXEXISTSERVICEFORM, 0, 0) = adxMessageResult then begin
        Result:= true;
        break;
      end;
    end;
  end
  else if Owner.IsClientLayout then
         Result:= true;
end;

function TadxContainer.ExistCompleteRegions: boolean;
var
  i: integer;
  pFormItem: PadxContainerForm;
begin
  if (Count > 0) then begin
    for i:= 0 to Count- 1 do begin
      pFormItem:= Items[i];
      if pFormItem <> nil then begin
        if (SendMessage(pformItem^.param^.FormHandle, WM_ADXCOMMAND, adxExistCompleteRegion, 0) <> adxMessageResult) then begin
          Result:= false;
          exit;
        end;
      end;
    end;
  end;
  Result := true;
end;

procedure TAdxContainer.MoveList(PListArr: PadxFormParamList; CountMove: word);//PPointerList
var
  i: integer;
  fp: PAdxFormParam;
  lf_new: PadxContainerForm;
begin
  ClearListForm;
  BeginRequired;
  try
    for i:= 1 to CountMove do begin
      fp := @PListArr[i-1];
      GetMem(lf_new, sizeof(TadxContainerForm));
      GetMem(lf_new^.param, sizeof(TadxFormParam));
      lf_new^.param^ := fp^;
      lf_new^.glyph:= nil;
      Add(lf_new);
    end;
  finally
    EndRequired;
  end;
  UpdatePictures(0);
  if Assigned(FOwner.ContainerPane) then
    FOwner.ContainerPane.SetItemsList;
end;

procedure TadxContainer.Refresh(rfKind: TadxRefreshKind; FormHandle: Hwnd);
var
  i: integer;
  pFormItem: PadxContainerForm;
begin
  for i:= 0 to Count- 1 do begin
    pFormItem:= Items[i];
    if pFormItem <> nil then begin
       if (FormHandle > 0) and (pFormItem^.param^.FormHandle <> FormHandle) then
         Continue;
       case rfKind of
         rfPicture: pFormItem^.glyph:= GetPictureFromHandle(pFormItem^.param^.FormHandle);
         rfCaption: pFormItem^.param.Caption:= GetCaptionFromHandle(pFormItem^.param^.FormHandle);
       end;
    end;
  end;
end;

function TadxContainer.BeginRequired: boolean;
begin
  result:= WaitForSingleObject(FMutex, 10000) = WAIT_OBJECT_0;
end;

procedure TadxContainer.ClearListForm;
var
  i: integer;
begin
  BeginRequired;
  try
    for i := 0 to Count - 1 do begin
      FreeMem(PadxContainerForm(Items[i])^.param, sizeof(TadxFormParam));
      if Assigned(PadxContainerForm(Items[i])^.glyph) then
        FreeAndNil(PadxContainerForm(Items[i])^.glyph);
      FreeMem(Items[i], sizeof(TadxContainerForm));
      Items[i] := nil;
    end;
  finally
    Clear;
    EndRequired;
  end;
end;

procedure TadxContainer.SetOwner(const Value: TadxForm);
begin
  FOwner := Value;
end;

function TadxContainer.GetOwner: TadxForm;
begin
  if (FOwner = nil) then begin
    Log.AddWarning('TadxContainer.FOwner = nil');
  end;
  result := FOwner;
end;

function TadxContainer.GetPictureFromHandle(AHandle: HWnd): TadxGPImage;
begin
  result:= nil;
  if AHandle > 0 then  begin
    PictureHelper.GetPictureFromAdxForm(AHandle, result);
  end;
end;

{$IFDEF UNICODE}
function TadxContainer.GetCaptionFromHandle(AHandle: HWnd): TadxUnicodeCaption;
{$ELSE}
function TadxContainer.GetCaptionFromHandle(AHandle: HWnd): TadxCaption;
{$ENDIF}
begin
  SendMessage(AHandle, WM_ADXGETCAPTION, 0, Integer(@Result));
end;

procedure TadxContainer.HideAllForm;
var
  i: integer;
  FormHandles: TList;
  PFormParam: PAdxFormParam;
begin
  FormHandles:= TList.Create;
  if Count > 0 then begin
    for i:= 0 to Count- 1 do begin
      PFormParam:= PadxContainerForm(Items[i])^.param;
      if Owner.Handle <> PFormParam^.FormHandle then
        FormHandles.Add(Pointer(PFormParam^.FormHandle));
    end;
  end;
  for i:= 0 to FormHandles.Count- 1 do
    SendMessage(Cardinal(FormHandles[i]), WM_ADXCOMMAND, adxHideForm, 0);

  owner.HideByManager;
  FormHandles.Free;
end;

{ TadxFormRegion }

constructor TadxFormRegion.Create(AOwner: TadxForm);
begin
  inherited Create;
  FOwner := AOwner;
  FSize  := 0;
  FState := irsUnknown;
end;

function TadxFormRegion.RegistryLoad(var ARegion: TadxRegionParam): boolean;
var
  Reg: TRegistry;
  KeyName: string;
  LocalKeyName: string;
  KeyValue: string;
begin
  result:= false;
  KeyName:= FOwner.AdxRegistryKey;
  LocalKeyName:= FOwner.AdxLocalRegistryKey;
  KeyValue:= FOwner.AdxLayoutKey;

  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.KeyExists(KeyName) then begin
      Reg.OpenKey(KeyName, false);
      if Reg.ValueExists(KeyValue+'_Size') then begin
        ARegion.Size := Reg.ReadInteger(KeyValue+'_Size');
        result:= true;
      end;
    end;
    if Reg.KeyExists(LocalKeyName) then begin
      Reg.OpenKey(LocalKeyName, false);
      if Reg.ValueExists(KeyValue+'_State') then begin
        ARegion.State := Reg.ReadInteger(KeyValue+'_State');
        if (not FOwner.FSplitButtonVisible) and (ARegion.State = ord(irsHidden)) then
            ARegion.State := ord(irsMinimized);
      end
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function TadxFormRegion.RegistrySave(ARegion: TadxRegionParam): boolean;
var
  Reg: TRegistry;
  KeyName : string;
  LocalKeyName : string;
  KeyValue: string;
begin
  Result:= false;
  KeyName:= FOwner.AdxRegistryKey;
  LocalKeyName:= FOwner.AdxLocalRegistryKey;
  KeyValue:= FOwner.AdxLayoutKey;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey(KeyName, true) then begin
      Reg.WriteInteger(KeyValue+'_Size', ARegion.Size);
      result:= true;
    end;
    if Reg.OpenKey(LocalKeyName, true) then begin
      Reg.WriteInteger(KeyValue+'_State', ord(ARegion.State));
      result:= true;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure TadxFormRegion.Initialize;
begin
  if (FOwner.Layout = wlClient) or (FOwner.IsClientLayout) then begin
    FState:= irsNormal;
    FSize := 0;
  end
  else begin
    if FState = irsUnknown then
      FadxRegionParam.State:= ord(FOwner.GetDefaultRegionState);

    FOwner.GetUserSize(FadxRegionParam.Size);

    FadxlayoutKey:= FOwner.AdxLayoutKey;
    if not TadxFormRegion.GetRegionParam(FOwner.AppWindow.Handle, FadxRegionParam, FOwner.Layout) then
      RegistryLoad(FadxRegionParam);

    FState := TadxInternalRegionstate(FadxRegionParam.State);

    if (FOwner.FNeededRegionState <> irsUnknown) then begin
      FState := FOwner.FNeededRegionState;
      FOwner.FNeededRegionState := irsUnknown;
    end;

    if (FState = irsMinimized) and (not FOwner.EnableMinimizeRegion) then
      FState:= irsNormal;

    FSize  := FadxRegionParam.Size;
  end;
end;

procedure TadxFormRegion.Store(ASize: longint; AState: TadxInternalRegionState);
begin
  if (FOwner.Layout = wlClient) or (FOwner.IsClientLayout) then
    exit
  else begin
    FadxRegionParam.Size := ASize;
    FadxRegionParam.State := ord(AState);
    RegistrySave(FadxRegionParam);
  end;
end;

procedure TadxFormRegion.UpdateParam;
begin
  FOwner.GetUserSize(FSize);
end;

class function TadxFormRegion.GetRegionParam(RegionHandle: HWND;
  var param: TadxRegionParam; layout: TadxWindowLayout): boolean;
var
  fParam: TadxRegionParam;
begin
  Result:= false;
  if SendMessage(RegionHandle, WM_ADXGETREGIONPARAM, Cardinal(@fParam), layout) = adxMessageResult then begin
    param := fParam;
    Result:= true;
  end;
end;

class function TadxFormRegion.SetRegionParam(RegionHandle: HWND;
  param: TadxRegionParam; layout: TadxWindowLayout): boolean;
var
  fParam: TadxRegionParam;
begin
  Result:= false;
  fParam:= param;
  if SendMessage(RegionHandle, WM_ADXSETREGIONPARAM, Cardinal(@fParam), layout) = adxMessageResult then
    Result:= true;
end;

procedure TadxFormRegion.SetState(const Value: TadxInternalRegionState);
var
  rParam: TadxRegionParam;
  oldState: TadxInternalRegionState;
begin
  FOwner.ReleaseFloating;

  oldState := FState;
  FState := Value;

  if FOwner.Visible then begin
    try
      if not FOwner.Injected then begin
        rParam.Size:= -1;
        rParam.State := ord(FState);
        TadxFormRegion.SetRegionParam(FOwner.AppWindow.Handle, rParam, FOwner.Layout);
      end
      else begin
        case value of
          irsNormal:   FOwner.ShowOnTop;
          irsHidden:   FOwner.HideOfTop;
          irsMinimized: begin
            if oldState = irsNormal then
              FOwner.HideOfTop
            else
              FOwner.ShowOnTop;
          end;
        end;
        FOwner.AppWindow.AdxRefresh;
      end;
    except
      on E:SysUtils.Exception do begin
        Log.AddException(format('TadxFormRegion.SetState <%d>: %s', [ord(FState), E.Message]));
        raise E;
      end;
    end;
  end;
end;


{ TadxForm }

constructor TadxForm.Create(AOwner: TComponent);
  {$IFNDEF ADX_VCL5}
var
  ID: TGuid;
  {$ENDIF}
begin
  FFormID := 'EmptyID';
  {$IFNDEF ADX_VCL5}
  CreateGUID(ID);
  FFormID := GUIDToString(ID);
  {$ENDIF}
  FIsClientLayout:= false;
  FRegionBorderStyle:= rbsSingle;
  FBorderStyle := bsNone;

  if not (csDesigning in self.ComponentState) then begin
    Log.AddMessage('TadxForm.Create: Before inherited TForm.Create(AOwner)');
    inherited Create(AOwner);
    Log.AddMessage('TadxForm.Create: After inherited TForm.Create(AOwner)');
  end
  else
    inherited Create(AOwner);

  inherited BorderWidth:= 1;

  if csDesigning in self.ComponentState then begin
    inherited BorderStyle:= bsNone;
  end
  else begin
    TDebug.WriteLine('TadxForm.Create: CurrentThreadID = '+IntToHex(GetCurrentThreadID, 8));

    GetMem(FAppWindowProperty, sizeof(TAppWindowProperty));
    FSplitterStyle:= spltOff;
    FInjected:= false;
    New(FormParam);
    FormParam.List := nil;

    inherited Visible:= false;
    FVisible := false;
    FLockVisible:= FVisible;
    FIsFloating:= false;
    UserVisible:= FVisible;
    FOldColor:= Color;
    FChildMode:= true;

    inherited WindowState := wsNormal;
    FWindowState:= wsNormal;
    SetWindowLongCheckUnicode(Handle, GWL_USERDATA, AdxFormID);

    //Case 1138
    //Moved to CreateParams SetWindowLongCheckUnicode(Handle, GWL_STYLE, WS_CHILD or WS_CLIPCHILDREN or WS_CLIPSIBLINGS);
    //Moved to CreateParams SetExWinAPIProperty(Handle, WS_EX_TOOLWINDOW);
    //Moved to CreateParams Windows.SetParent(handle, GetDesktopWindow);

    AutoScroll:= true;
    ActivateEventFlag:= false;

    FDefaultWidth := ClientWidth  + BorderWidth * 2;
    FDefaultHeight:= ClientHeight + BorderWidth * 2;
    FUserWidth := FDefaultWidth;
    FUserHeight:= FDefaultHeight;

    CreateAdxObjectsInstances;
    FTheme.Parent:= Self;
    FTheme.OnThemeChanged:= DoThemeChanged;
    Icon.OnChange := IconChanged;

    inherited AutoSize:= false;
  end;
end;

constructor TadxForm.CreateInstanceForClientLayout;
begin
  Log.AddMessage('TadxForm.CreateInstanceForClientLayout');
  Create(nil);
  FFormID := FormID + ' [ServiceForm]';
  Log.AddMessage('TadxForm.CreateInstanceForClientLayout ' + FormID);
  FIsClientLayout:= true;
end;

procedure TadxForm.CreateParams(var params: TCreateParams);
begin
  inherited;
  if not (csDesigning in self.ComponentState) then begin
    params.Style := WS_CHILD or WS_CLIPCHILDREN or WS_CLIPSIBLINGS;
    params.ExStyle :=  params.ExStyle or WS_EX_TOOLWINDOW;
    params.WndParent := GetDesktopWindow;
  end;
end;

procedure TadxForm.CreateAdxObjectsInstances;
begin
  FFormRegion:= TadxFormRegion.Create(Self);
  FTheme:= TadxTheme.Create(nil);
  FAppWindow := TAppWindow.CreateEx(self);
  FContainer := TadxContainer.CreateEx(Self);
  FContainerPane:= TadxContainerPane.CreateEx(FContainer);
end;

procedure TadxForm.StoreRegionParam;
var
  userSize: integer;
begin
  if FInjected then begin
    if EnableSize then FormRegion.Store(FormRegion.Size, FormRegion.State)
    else begin
      userSize:= 0;
      GetUserSize(userSize);
      if userSize > 0 then
        FormRegion.Store(userSize, FormRegion.State);
    end;
  end;
end;

function TadxForm.VerifyConstrains(MOffset: TPoint): boolean;
var
  ACancel: boolean;
  event: TadxEventRaising;
begin
  Result:= true;
  ACancel:= false;
  if Assigned(FOnADXSplitterMove) then begin
    event := TadxEventRaising.Create('OnADXSplitterMove', [eoLockRegionState]);
    try
      case FLayout of
        wlLeft:   FOnADXSplitterMove(Width+ MOffset.X, Height, ACancel);
        wlRight:  FOnADXSplitterMove(Width- MOffset.X, Height, ACancel);
        wlTop:    FOnADXSplitterMove(Width, Height+ MOffset.Y, ACancel);
        wlBottom: FOnADXSplitterMove(Width, Height- MOffset.Y, ACancel);
      end;
    finally
      event.Free;
    end;
    Result:= not ACancel;
  end;
end;

procedure TadxForm.Hide;
begin
  TDebug.WriteLine(ClassName+'.Hide() CurrentThread= '+IntToHex(GetCurrentThreadId, 8));
  if csDesigning in self.ComponentState then begin
    inherited hide;
    exit;
  end;

  ReleaseFloating;

  StoreRegionParam;
  if fVisible then
    AdxReject;

  {$IFNDEF HideWithoutCheckVisibility}
  if IsWindowVisible(handle) then
  {$ENDIF}
  begin
    if IsWindowVisible(FHostHandle) then begin
      //Another inspector will be activated when layout is changed
      //.NET does not contain this code
      //Windows.SetFocus(FHostHandle);
    end;
    if (FormRegion.State <> irsHidden) {or EnableSize} then
      DoDeactivate;
    inherited Visible:= false;
  end;

  FVisible:= false;
  Windows.SetParent(handle, 0);
  if Assigned(FContainerPane) then begin
    FContainerPane.Hide;
  end;
end;

procedure TadxForm.SendMessageToDragContainerWithDragItems(dragContainerHandle: HWND);
var
  dragItemListHeader: TadxDragItemListHeader;
  itemList: TList;
  i: integer;
begin
  itemList:= TList.Create;
  try
    SetDragItems(itemList);

    dragItemListHeader.Count:= itemList.Count;
    dragItemListHeader.Allowed:= IsDragDropAllowed;
    dragItemListHeader.ListItems:= nil;

    if itemList.Count > 0 then begin
      GetMem(dragItemListHeader.ListItems, SizeOf(TadxDragItemParams)* itemList.Count);
      for i:= 0 to itemList.Count- 1 do begin
        if itemList[i] <> nil then begin
          dragItemListHeader.ListItems^[i]:= PadxDragItemParams(itemList[i])^;
          FreeMem(itemList[i]);
        end;
      end;
    end;
    SendMessage(dragContainerHandle, WM_ADXSETDRAGITEMS, 0, Cardinal(@dragItemListHeader));
  finally
    itemList.Free;
    if dragItemListHeader.ListItems <> nil then
      FreeMem(dragItemListHeader.ListItems);
  end;
end;

{$IFNDEF ADX_VCL5}
procedure TadxForm.SetAutoSize(Value: Boolean);
begin
  if not (csDesigning in self.ComponentState) then begin
    FAutoSize := false;
  end
  else begin
     inherited;
     FAutoSize := value;
  end;
end;
{$ENDIF}

procedure TadxForm.DoActivate;
begin
  if Assigned(fContainerPane) then
    FContainerPane.ContainerRefresh(rfLighReset, not FInjected, Handle);
  if Assigned(OnActivate) then
     OnActivate(Self);
end;

procedure TadxForm.DoAdxDragOverMinimized(params: PadxDragOverMinimizedParams);
var
  event: TadxEventRaising;
begin
  if Assigned(FOnADXDragOverMinimized) and (params <> nil) then
  try
    event := TadxEventRaising.Create('OnADXDragOverMinimized', [eoLockRegionState]);
    try
      FOnADXDragOverMinimized(IDataObject(params^.dataObj), params^.KeyState, params.pt, params.Effect, params.Expand);
    finally
      event.Free;
    end;
  except
    on e: Exception do begin
      TadxExceptionManager.ProcessADXXError(E, ClassName +'.DoAdxDragOverMinimized');
    end;
  end;
end;

procedure TadxForm.DoNestedActivation(Msg: Cardinal; Control: TWinControl;
  Form: TCustomForm);
begin
  if Control = nil then Exit;
  while (Control.Parent <> nil) and not (Control is TCustomForm) do
    Control := Control.Parent;
  if Assigned(Control) and (Control <> Form) then
    SendMessage(Control.Handle, Msg, 0, 0)
end;

procedure TadxForm.DoThemeChanged(Sender: TObject);
begin
  if UseOfficeThemeBackColor then
    Color:= GetBackColor;
  RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
end;

procedure TadxForm.Activate;
var
  event: TadxEventRaising;
begin
  if not (csDesigning in self.ComponentState) then begin
    event := TadxEventRaising.Create('Activate', [eoLockRefreshInspectorTab]);
    try
      if not Injected then begin
        InitFormParamStructure;
        try
          if SendMessage(Appwindow.Handle, WM_ADXSETACTIVATE, 0, Cardinal(FormParam)) <> adxMessageResult then
            exit;
        finally
          if (FormParam^.List <> nil) then begin
            FreeMem(FormParam^.List);
            FormParam^.List:= nil;
            FormParam^.Count := 0;
          end;
        end;
      end
      else begin
        if FormRegion.State <> irsNormal then begin
          try
            AdxLockWindowUpdate(FHostHandle);
            FormRegion.State:= irsNormal;
            ShowOnTop;
            if Assigned(FAppWindow) then
              FAppWindow.AdxRefresh;
          finally
            AdxLockWindowUpdate(0);
          end;
        end;
      end;
    finally
      event.Free;
    end;

  end;
  DoNestedActivation(CM_ACTIVATE, ActiveControl, Self);
end;

procedure TadxForm.Deactivate;
begin
  DoNestedActivation(CM_DEACTIVATE, ActiveControl, Self);
end;

procedure TadxForm.InitProperties(AAppWindowProperty: Pointer);
var
  AppWindowProperty: PAppWindowProperty;
begin
  if FVisible or FInjected then
    exit;

  CopyAppWindowProperty(FAppWindowProperty, AAppWindowProperty);
  AppWindowProperty := FAppWindowProperty;

  FLayout:= AppWindowProperty^.Layout;
  if IsClientLayout then
    FLayout:= wlClient;
  FItemType:= AppWindowProperty^.ItemType;
  FHostHandle := AppWindowProperty^.HostHandle;
  FHostVersion:= AppWindowProperty^.HostVersion;
  FContainerType := AppWindowProperty^.ContainerType;
  FSplitterStyle:= AppWindowProperty^.Splitter;
  if FSplitterStyle <> spltOff then
    FSplitterStyle := spltAdvanced;
  FEmulateWindow:= AppWindowProperty^.EmulateWindowHandle;
  FAlwaysShowHeader:= AppWindowProperty^.AlwaysShowHeader;
  FCloseButtonOnHeader:= AppWindowProperty^.CloseButton;
  FSplitButtonVisible:= AppWindowProperty^.SplitterButton;
  FRegionBorderStyle:= AppWindowProperty^.RegionBorder;
  FAppHandle:= AppWindowProperty^.WindowHandle;
  FItemID:= AppWindowProperty^.ItemID;

  if FEmulateWindow > 0 then
    FAppWindow.Handle:= FEmulateWindow
  else
    FAppWindow.Handle:= FAppHandle;

  if AppWindowProperty^.Caption <> '' then Caption:= AppWindowProperty^.Caption;
  vOffset := AppWindowProperty.Offset;

  FIsFloating:= false;
  FUserWidth := FDefaultWidth;
  FUserHeight:= FDefaultHeight;

  FFormRegion.Initialize;
  FTheme.Initialize(FHostVersion, FItemType, FHostHandle);
  FContainerPane.Initialize(FHostVersion, FItemType, FHostHandle);

  if not EnableSize then
    SetUserSize(FormRegion.Size);
end;

procedure TadxForm.ShowInternal;
begin
  if FVisible or FInjected or (FAppWindow.Handle <= 0) then
    exit;
  try
    Log.AddMessage('TadxForm.ShowInternal() ' + FormID);
    FStyleUpdate:= false;
    FAppWindow.InitMainPos;

    if UseOfficeThemeBackColor then
      Color:= GetBackColor;

    AdxInject;
    FVisible:= true;
    if FInjected then begin
      if Assigned(FContainerPane) then begin
        FContainerPane.TaskCaption:= ' '+Caption;
        FContainerPane.Show;
        //Showing task pane when File -> Print in 2010. Case 109
        if FContainerPane.PositionInZOrder <> HWND_TOP then begin
          SetWindowPos(FContainerPane.Handle, FContainerPane.PositionInZOrder, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
        end;
      end;
      if not (FormRegion.State in [irsHidden, irsMinimized]) then begin
        Windows.SetParent(handle, FContainerPane.Handle);
        if not IsWindowVisible(Handle) then begin
          //inherited Visible:= true;
          SetVisibleInThread(true);
        end;
        DoInternalActivate;
      end;
    end;

  except
    on E: SysUtils.Exception do begin
      Log.AddException(ClassName+'.Show(AppWindowProperty)');
      raise E;
    end;
  end;
end;

procedure TadxForm.SetVisibleInThread(VisibleState: boolean);
var
  appHandle: HWND;
begin
  appHandle:= Application.Handle;
  if FHostVersion = v2010 then
    Application.Handle:= 0;
  try
    inherited Visible:= VisibleState;
  finally
    if FHostVersion = v2010 then
      Application.Handle := appHandle;
  end;
end;

procedure TadxForm.ShowOnTop;
begin
  try
    FStyleUpdate:= false;
    TDebug.WriteLine('TadxForm.ShowOnTop');

    ReleaseFloating;

    if FormRegion.State = irsNormal then begin
      //Windows.SetParent(Handle, FAppWindow.Parent);
      Windows.SetParent(handle, FContainerPane.Handle);
      if not IsWindowVisible(Handle) then begin
        SetVisibleInThread(true);
        DoInternalActivate;
        FVisible:= true;
      end;
    end;

    if Assigned(FContainerPane) then begin
      FContainerPane.TaskCaption:= ' '+ Caption;
      FContainerPane.Show;
    end;

    StoreRegionParam;
  except
    on E: SysUtils.Exception do begin
      Log.AddException(ClassName+'.ShowOnTop');
      raise E;
    end;
  end;
end;

procedure TadxForm.SetFloatingPos(floatingPos: TWindowPos);
var
  cx, cy: integer;
begin
  cx:= floatingPos.cx;
  cy:= floatingPos.cy;
  if EnableSize then begin
    case FLayout of
      wlRight, wlLeft: cx:= Width;
      wlTop, wlBottom: cy:= Height;
    end;
  end;
  SetWindowPos(Handle, 0, floatingPos.x, floatingPos.y, cx, cy, SWP_NOACTIVATE or SWP_NOZORDER);
end;

procedure TadxForm.ShowFloating(containerHandle: Hwnd; floatingPos: TWindowPos);
var
  wPos: TWindowPos;
  headerSize: integer;
  pOffset: TRect;
begin
  try
    if Assigned(FormRegion) then
      FormRegion.Initialize;

    headerSize:= 0;
    if SendMessage(containerHandle, WM_ADXREDESIGNSUPPORT, reDesignVersion, 0) = adxMessageResult then begin
      //For compatibility with version ADX 2009
      headerSize:= FContainerPane.HeaderHeight;
    end;

    pOffset:= Rect(0,0,0,0);
    if Assigned(FContainerPane) then
      pOffset:= FContainerPane.PaneOffset;

    wPos:= floatingPos;
    case FLayout of
      wlLeft: begin
        wPos.x:= wPos.x+ headerSize+ pOffset.Left;
        dec(wPos.x);
        wPos.cx:= UserWidth + BorderWidthFloatingDefault* 2;
        inc(wPos.y, pOffset.Top);
        dec(wPos.cy, pOffset.Top+ pOffset.Bottom);
      end;
      wlRight: begin
        wPos.x:= wPos.x + wPos.cx - (UserWidth + BorderWidthFloatingDefault * 2)- headerSize- pOffset.Right;
        inc(wPos.x);
        wPos.cx:= UserWidth + BorderWidthFloatingDefault* 2;
        inc(wPos.y, pOffset.Top);
        dec(wPos.cy, pOffset.Top+ pOffset.Bottom);
      end;
      wlTop: begin
        wPos.y:= wPos.y+ headerSize+ pOffset.Top;
        dec(wPos.y);
        wPos.cy:= UserHeight + BorderWidthFloatingDefault* 2;
        inc(wPos.x, pOffset.Left);
        dec(wPos.cx, pOffset.Left+ pOffset.Right);
      end;
      wlBottom: begin
        wPos.y:= wPos.y + wPos.cy - (UserHeight + BorderWidthFloatingDefault* 2)- headerSize- pOffset.Bottom;
        inc(wPos.y);
        wPos.cy:= UserHeight + BorderWidthFloatingDefault* 2;
        inc(wPos.x, pOffset.Left);
        dec(wPos.cx, pOffset.Left+ pOffset.Right);
      end;
    end;

    ReleaseFloating;

    FIsFloating:= true;
    Windows.SetParent(Handle, FAppWindow.Parent);
    SetWindowPos(Handle, HWND_TOP, wPos.x, wPos.y, wPos.cx, wPos.cy, SWP_NOACTIVATE);

    Perform(CM_BORDERCHANGED, 0, 0);
    FAppWindow.SetClippingStyle;

    SetVisibleInThread(true);
    DoInternalActivate;

    FFormHook:= TadxFormHook.Create(containerHandle, Handle, (ItemType <> stOlWordMailInspector));
  except
    on E: SysUtils.Exception do begin
      Log.AddException(ClassName+'.ShowFloating');
      raise E;
    end;
  end;
end;

procedure TadxForm.HideFloating;
begin
  try
    FIsFloating:= false;
    FAppWindow.RestoreClippingStyle;
    DoDeactivate;
    SetVisibleInThread(false);
    Windows.SetParent(Handle, 0);
    ReleaseFloating;
  except
    on E: SysUtils.Exception do begin
      Log.AddException(ClassName+'.HideAsModal');
      raise E;
    end;
  end;
end;

procedure TadxForm.HideOfTop;
begin
  try
    TDebug.WriteLine('TadxForm.HideOfTop');
  {$IFNDEF HideWithoutCheckVisibility}
    if IsWindowVisible(handle) then
  {$ENDIF}
    begin
      if IsFloating then begin
        if Assigned(FContainerPane) then
          FContainerPane.FloatingFormHandle:= 0;
      end
      else begin
        DoDeactivate;
        SetVisibleInThread(false);
      end;
    end;

    if Assigned(FContainerPane) and (not (FormRegion.State in [irsMinimized, irsHidden])) then begin
      FContainerPane.Hide;
    end;

    Windows.SetParent(Handle, 0);

    StoreRegionParam;
  except
    on E: SysUtils.Exception do begin
      Log.AddException(ClassName+'.HideOfTop');
      raise E;
    end;
  end;
end;

procedure TadxForm.Close;
begin
  if not (csDesigning in self.ComponentState) then begin
    Hide;
  end;
  inherited Close;
end;

procedure TadxForm.CMActivate(var Message: TCMActivate);
begin
end;

procedure TadxForm.ConstrainedResize(var MinWidth, MinHeight, MaxWidth,
  MaxHeight: Integer);
begin
  if not (csDesigning in self.ComponentState) then begin
    MinWidth:= 0;
    MinHeight:= 0;
    MaxWidth:= 0;
    MaxHeight:= 0;
  end
  else
    inherited;
end;

procedure TadxForm.DrawFrame;
begin
end;

procedure TadxForm.DrawFrameFloating;
var
  gr: TadxGPGraphics;
  brush: TadxGPSolidBrush;
  pen: TadxGPPen;
  rgn: TadxGPRegion;
  R, RClient, RRect: TRect;
  clBrush, clPen: TGPColor;
  bWidth: integer;

begin
  if not Assigned(FTheme) then exit;

  clPen:= GPSystemColor(COLOR_3DSHADOW);
  clBrush:= DarkerColor(GPSystemColor(COLOR_BTNFACE), 3);
  bWidth:= BorderWidth;

  case FHostVersion of
    v2003,
    v2007,
    v2010: begin
      clPen:= FTheme.FItemColor.Border;
      clBrush:= FTheme.FItemColor.BackGround;
    end;
  end;

  gr:= TadxGPGraphics.Create(GetWindowDC(Handle));
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  RClient:= R;
  InflateRect(RClient, -(bWidth), -(bWidth));

  rgn:= TadxGPRegion.Create(MakeRect(R));
  brush:= TadxGPSolidBrush.Create(clBrush);

  pen:= TadxGPPen.Create(clPen);
  try
    rgn.Exclude(MakeRect(RClient));
    gr.FillRegion(brush, rgn);

    RRect:= R;
    dec(RRect.Right);
    dec(RRect.Bottom);
    gr.DrawRectangle(pen, MakeRect(RRect));

    RRect:= RClient;
    dec(RRect.Left);
    dec(RRect.Top);
    gr.DrawRectangle(pen, MakeRect(RRect));

    if (FHostVersion = v2000) or (FHostVersion = v2002) then begin
      pen.SetColor(colorWhite);
      RRect := Rect(R.Left, R.Top, R.Right - 1, R.Bottom - 1);
      InflateRect(RRect, -1, -1);
      gr.DrawRectangle(pen, MakeRect(RRect));
      InflateRect(RRect, -3, -3);
      gr.DrawRectangle(pen, MakeRect(RRect));
    end;
  finally
    pen.Free;
    brush.Free;
    rgn.Free;
    gr.Free;
  end;
end;

procedure TadxForm.Paint;
begin
  inherited;
end;

procedure TadxForm.AdxInject;
var
  FlagOrderLayout: boolean;
begin
  try
    Log.AddMessage('TadxForm.AdxInject');
    if not FInjected then
    with FAppWindow do begin
      FInjected:= false; FlagOrderLayout:= false;
      if Handle = 0 then exit;
      OldWindowProc:= Pointer(GetWindowLongCheckUnicode(Handle, GWL_WNDPROC));

      InitFormParamStructure;

      try
        if SendMessage(FAppWindow.Handle, WM_ADXADDFORM, 0, Cardinal(FormParam)) <> adxMessageResult then begin
          SendMessage(Handle, WM_ADXGETAPPWINDOWPOS, 0, Cardinal(@MainPos));
          case OrderLayout of
            olVTotal: if Layout in [wlleft, wlRight, wlClient] then FlagOrderLayout:= true;
            olHTotal: if Layout in [wlTop, wlBottom, wlClient] then FlagOrderLayout:= true;
          end;
          if (not FContainerPane.ConnectController) and FlagOrderLayout then begin
            if SendMessage(Handle, WM_ADXSETLATESTPROC, Cardinal(@NewWindowProc), Cardinal(@OldWindowProc)) <> AdxMessageResult then
              SetWindowLongCheckUnicode(Handle, GWL_WNDPROC, Cardinal(NewWindowProc));
          end
          else
            SetWindowLongCheckUnicode(Handle, GWL_WNDPROC, Cardinal(NewWindowProc));

          FInjected:= true;
        end;
      except
        on e: Exception do begin
          Log.AddException(self.Name + '.AdxInject: '+ e.Message);
          FAppWindow.RestoreWndProc;
          FInjected:= false;
          raise e;
        end;
      end;
      FAppWindow.AdxRefresh;
    end;
  except
    on E: SysUtils.Exception do begin
      Log.AddException(ClassName+'.AdxInject');
      raise E;
    end;
  end;
end;

procedure TadxForm.AdxReject;
var FormIndex: integer;
    IsContainerActive: boolean;
begin
  Log.AddMessage('TadxForm.AdxReject');
  try
    AdxLockwindowUpdate(AppWindow.Parent);
    try
      InitFormParamStructure; FormIndex:= -1;
      if Assigned(FContainer) then FormIndex:= FContainer.GetIndex(FormParam);
      SendMessage(FAppWindow.Handle, WM_ADXDELETEFORM, 0, Cardinal(FormParam));

      if FInjected then
      with FAppWindow do begin
        InitMainPos;
        IsContainerActive:= (SendMessage(FAppWindow.Handle, WM_ADXGETCONTAINERFORM, 0, Cardinal(FormParam)) = adxMessage_IsContainer);
        if not IsContainerActive then begin
          if Pointer(GetWindowLongCheckUnicode(Handle, GWL_WNDPROC)) = NewWindowProc then begin
            CallWindowProc(OldWindowProc, Handle, WM_ADXSETMAINPOS, 0, Cardinal(@MainPos));
            //SetWindowLongCheckUnicode(Handle, GWL_WNDPROC, Cardinal(OldWindowProc))
            FAppWindow.RestoreWndProc;
          end
          else begin
            //SendMessage(Handle, WM_ADXDELPROC, Cardinal(@NewWindowProc), Cardinal(@OldWindowProc));
            FAppWindow.IntSwapWndProc;
          end;
        end
        else begin
          if FContainer.Count > 0 then begin
            if FormIndex < FContainer.Count then
              AdxExtract(FormIndex)
            else AdxExtract(0);

            if FContainer.Count <= 1 then begin
              FContainer.ClearListForm;
              FContainerPane.Hide;
            end;
          end
          else begin
            //SendMessage(Handle, WM_ADXDELPROC, Cardinal(@NewWindowProc), Cardinal(@OldWindowProc));
            FAppWindow.IntSwapWndProc;
          end;
        end;

      end;
      FInjected:= false;
      if IsSupportAdjacentWindow then
        FContainerPane.DisconnectController
      else
        FAppWindow.AdxRefresh;
      FContainerPane.UpdateAppScrollBar;
    finally
      AdxLockWindowUpdate(0);
    end;
  except
    on E: SysUtils.Exception do begin
      Log.AddException(ClassName+'.AdxReject');
      raise E;
    end;
  end;
end;

procedure TadxForm.Highlight;
begin
  if Visible then
    HighlightInternal(DefaultBlinkInterval, DefaultBlinkPeriod);
end;

procedure TadxForm.HighlightInternal(interval, period: Cardinal);
var
  param: TadxBlinkParam;
begin
  param.reserved:= 0;
  param.interval:= interval;
  param.period:= period;
  param.formHandle:= Handle;
  param.layout:= FLayout;
  if Assigned(FAppWindow) then
    SendMessage(FAppWindow.Handle, WM_ADXCOMMAND, adxBlinking, Integer(@param));
end;

procedure TadxForm.SetVisible(value: boolean);
begin
  if FVisible <> value then begin
    if (csDesigning in self.ComponentState) or (csLoading in self.ComponentState) then begin
      FVisible:= value;
      exit;
    end;
    if FLockVisible then FVisible:= value
    else begin
      if value then self.Show
      else HideByManager(true);
    end;
  end;
end;

function TadxForm.GetEnableSize: boolean;
begin
  Result:= (FSplitterStyle = spltOff) and (not IsDockLayout);
end;

procedure TadxForm.SetLockVisible(value: boolean);
begin
  if FLockVisible <> value then begin
    FLockVisible:= value;
    if value then UserVisible:= FVisible
    else FVisible:= UserVisible;
  end;
end;

procedure TadxForm.SetWindowState(value: TWindowState);
begin
  FWindowState:= wsNormal;
  inherited WindowState:= wsNormal;
end;

procedure TadxForm.SetBorderWidth(const Value: integer);
begin
  Perform(CM_BORDERCHANGED, 0, 0);
end;

procedure TadxForm.SetBorderStyle(const Value: TFormBorderStyle);
begin
  FBorderStyle := bsNone;
end;

procedure TadxForm.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  R: TRect;
  needRefresh: boolean;
  delta: integer;
begin
  try
    needRefresh:= false;
    if not (csDesigning in self.ComponentState) then begin
      needRefresh:= FInjected and (EnableSize and not IsFloating);
      if EnableSize and IsFloating then begin
        GetWindowRect(Handle, R);
        AWidth:= R.Right - R.Left;
        AHeight:= R.Bottom - R.Top;
      end
      else
      if FInjected then begin
        GetWindowRect(Handle, R);
        case Layout of
          wlLeft, wlRight: begin
            AHeight:= R.Bottom - R.Top;
            if {EnableSize and} (Width <> AWidth) then begin
              FUserWidth:= AWidth;
              needRefresh:= true;
            end;
          end;
          wlTop, wlBottom: begin
            AWidth:= R.Right - R.Left;
            if {EnableSize and} (Height <> AHeight) then begin
              FUserHeight:= AHeight;
              needRefresh:= true;
            end;
          end;
          wlDockLeft, wlDockRight: begin
            AHeight:= Height;
            if AWidth <= MinCTPWindowWidth then
              AWidth := MinCTPWindowWidth;

            if (Width <> AWidth) then begin
              delta := AWidth - Width;
              FUserWidth:= AWidth;
              UpdateCTPParam(utUpdateSize, delta);
              inherited SetBounds(ScreenPos.x, ScreenPos.y, AWidth, AHeight);
              exit;
            end;
          end;
          wlDockTop, wlDockBottom: begin
            AWidth:= Width;
            if (AHeight <= MinCTPWindowHeight) and (not IsHeaderVisible) then
              AHeight := MinCTPWindowHeight;
            if (Height <> AHeight) then begin
              delta := AHeight - Height;
              FUserHeight:= AHeight;
              UpdateCTPParam(utUpdateSize, delta);
              inherited SetBounds(ScreenPos.x, ScreenPos.y, AWidth, AHeight);
              exit;
            end;
          end;
        end;
      end;
    end;
    inherited;

    if not (csDesigning in self.ComponentState) then
      if needRefresh then begin
        FAppWindow.AdxRefresh;
      end;
  except
    on E: SysUtils.Exception do begin
      Log.AddException(format(ClassName+'.SetBounds(%d,%d,%d,%d)', [ALeft, ATop, AWidth, AHeight]));
      raise E;
    end;
  end;
end;

procedure TadxForm.ActivateClientLayout;
begin
  PostMessage(fAppWindow.Handle, WM_ADXCOMMAND, adxActivateClientLayout, 0);
end;

procedure TadxForm.AdxExtract(index: integer);
var FP: PAdxFormParam;
    adxRegion: TadxRegionParam;
begin
  Log.AddMessage('TadxForm.AdxExtract');
  if Index < 0 then exit;
  try
    try
      AdxLockWindowUpdate(FHostHandle);

      adxRegion.State := ord(FormRegion.State);
      adxRegion.Size := FormRegion.Size;
      if not EnableSize then
        GetUserSize(adxRegion.Size);

      if FContainer.Count < index+1 then exit;
      InitFormParamStructure;
      FP := PadxContainerForm(FContainer[Index])^.param;
      if not Assigned(FP) then exit;

      if SendMessage(FP.FormHandle, WM_ADXSETOLDPROC, 0, Cardinal(@FAppWindow.OldWindowProc)) = adxMessageResult then
      with FAppWindow do begin
        if SendMessage(Handle, WM_ADXSETNEWPROC, Cardinal(@NewWindowProc), Cardinal(@FP^.NewWindowProc)) <> adxMessageResult then begin
          CallWindowProc(FP^.NewWindowProc, Handle, WM_ADXSETMAINPOS, 0, Cardinal(@MainPos));
          //SetWindowLongCheckUnicode(Handle, GWL_WNDPROC, Cardinal(FP^.NewWindowProc));
          if FAppWindow.SwapWndProc(FP^.NewWindowProc, FAppWindow.NewWindowProc) then
            FContainerPane.SwapController(FP.FormHandle, 0, nil)
          else
            FContainerPane.SwapController(FP.FormHandle, 1, nil)
        end
        else
          FContainerPane.SwapController(FP.FormHandle, 0, nil);
        if FormRegion.State = irsMinimized then
          if SendMessage(FP^.FormHandle, WM_ADXSUPPORTMINIMIZE, 0, 0) <> adxMessageResult then
             adxRegion.State := ord(irsNormal);
        if SendMessage(Handle, WM_ADXSETCONTAINER, Cardinal(@adxRegion), Cardinal(FormParam)) = adxMessageResult then begin
          FInjected:= false;
          HideOfTop;
          FContainer.ClearListForm;
          FContainerPane.ListControl.Items.Clear;
        end;
        AdxRefresh;
      end;
    except
      on E: SysUtils.Exception do begin
        Log.AddException(format(ClassName+'.AdxExtract(%d)', [Index])+': '+E.Message);
        raise E;
      end;
    end;
  finally
    AdxLockWindowUpdate(0);
  end;
end;

destructor TadxForm.Destroy;
var
  step: string;
begin
  TDebug.WriteLine('TadxForm.Destroy: ('+Caption+') CurrentThreadID = '+IntToHex(GetCurrentThreadID, 8));
    try
      if not (csDesigning in self.ComponentState) then begin
        Log.AddMessage('TadxForm.Destroy ' + FormID);
        Log.AddIndent;
        try
          step := 'DoBeforeDelete';
          DoBeforeDelete;

          if FVisible then begin
            step := 'AdxReject';
            AdxReject;
          end;

          if Assigned(FContainerPane) then begin
            step := 'FContainerPane.Free';
            FContainerPane.Free;
            FContainerPane := nil; 
          end;

          if Assigned(FContainer) then begin
            step := 'FContainer.Free';
            FContainer.Free;
            FContainer := nil;
          end;

          if Assigned(FAppWindow) then begin
            step := 'FAppWindow.Destroy';
            FAppWindow.Free;
            FAppWindow := nil;
          end;

          step := 'FFormRegion.Free';
          if Assigned(FFormRegion) then begin
            FFormRegion.Free;
            FFormRegion := nil;
          end;

          if (FormParam <> nil) then begin
            step := 'Dispose(FormParam)';
            if (FormParam.List <> nil) then begin
              FreeMem(FormParam.List);
              FormParam.List := nil;
            end;
            Dispose(FormParam);
            FormParam := nil;
          end;

          if (FTheme <> nil) then begin
            step := 'FTheme.Destroy';
            FreeAndNil(FTheme);
          end;

          if (FAppWindowProperty <> nil) then begin
            step := 'FreeMem(FAppWindowProperty)';
            FreeMem(FAppWindowProperty);
            FAppWindowProperty := nil;
          end;
        finally
          Log.RemoveIndent;
        end;
      end;

      step := 'Destroy.inherited';

      if not (csDesigning in self.ComponentState) then begin
        Log.AddMessage('TadxForm.Destroy: Before inherited TForm.Destroy');
        inherited Destroy;
        Log.AddMessage('TadxForm.Destroy: After inherited TFrom.Destroy');
      end
      else
        inherited Destroy;

      step := '';
    except
      on E: SysUtils.Exception do begin
        Log.AddException(format(ClassName+'.Destroy (%s)', [step])+': '+E.Message);
        raise E;
      end;
    end;
end;

procedure TadxForm.SetCaption(value: TCaption);
var
  S: string;
begin
  if GetCaption <> Value then begin
    if not (csDesigning in self.ComponentState) then begin
      S:= value;
      if length(S) > MAX_ADX_CAPTION then
        S:= copy(value, 1, MAX_ADX_CAPTION- 1);

      SetTextBuf(PChar(S));
      if Assigned(FContainerPane) then begin
        FContainerPane.ContainerRefresh(rfCaption, not FInjected, Handle);
        FContainerPane.TaskCaption := ' '+ S;
        //FContainerPane.SetItemCaption(FormParam, S);
      end;
    end
    else
      SetTextBuf(PChar(Value));
  end;
end;

procedure TadxForm.SetChildMode(const Value: boolean);
begin
  if FChildMode <> Value then begin
    FChildMode := value;
    if FChildMode then
      SetWinAPIProperty(Handle, WS_CHILDWINDOW)
    else
      UnSetWinAPIProperty(Handle, WS_CHILDWINDOW);
  end;
end;

procedure TadxForm.SetFormRegionState(value: TadxInternalRegionState);
begin
  if Assigned(FormRegion) then
    FormRegion.State:= value;
end;

function TadxForm.GetCaption: TCaption;
var Len: Integer;
begin
  Len := GetTextLen;
  SetString(Result, PChar(nil), Len);
  if Len <> 0 then GetTextBuf(Pointer(Result), Len + 1);
end;

function TadxForm.GetCTPSize: integer;
var
  headerSize: integer;
  pOffset: TRect;
begin
  Result:= FFormRegion.Size;
  pOffset:= Rect(0, 0, 0, 0);
  headerSize:= 0;
  if Assigned(FContainerPane) then begin
    pOffset:= FContainerPane.PaneOffset;
    if IsHeaderVisible then
      headerSize:= FContainerPane.HeaderHeight;
  end;
  case FLayout of
    wlDockLeft, wlDockRight: Result:= Result + pOffset.Left + pOffset.Right;
    wlDockTop, wlDockBottom: Result:= Result + pOffset.Top + pOffset.Bottom + headerSize
  end;
end;

function TadxForm.GetDefaultRegionState: TadxInternalRegionState;
begin
  result := irsNormal; 
end;

procedure TadxForm.GetDragLayoutParams(var AlayoutParams: TadxDragLayoutParams);
begin

end;

procedure TadxForm.IconChanged(Sender: TObject);
begin
  if Assigned(FContainerPane) then
    FContainerPane.ContainerRefresh(rfPicture, not FInjected, Handle);
end;

procedure TadxForm.InitFormParamStructure;
var
  i: integer;
  p: Pointer;
begin
  try
    with FormParam^ do begin
      StrPCopy(Caption, AnsiString(self.Caption));
      FormHandle:=    self.Handle;
      AppHandle:=     FAppWindow.Handle;
      NewWindowProc:= FAppWindow.NewWindowProc;
      OldWindowProc:= FAppWindow.OldWindowProc;
      Layout:=        self.Layout;
      ItemType:=      self.ItemType;

      if (List <> nil) then begin
        FreeMem(List); //sizeof(TadxFormParam) * Count);
        List := nil;
      end;

      Count:= 0;
      List:=  nil;
      MainPos := FAppWindow.MainPos;
      if Assigned(FContainer) then begin
        if FContainer.Count > 0 then begin
          GetMem(List, sizeof(TadxFormParam) * FContainer.Count);

          for i := 0 to FContainer.Count - 1 do begin
            p := Pointer(Cardinal(List) + Cardinal(i * sizeof(TadxFormParam)));
            PadxFormParam(p)^ := PadxContainerForm(FContainer[i])^.param^;
          end;
          Count:= FContainer.Count;
        end;
      end;
    end;
  except
    on E: SysUtils.Exception do begin
      Log.AddException(ClassName+'.InitFormParamStructure: '+E.Message);
      raise E;
    end;
  end;
end;

function TadxForm.RegistryKey: string;
begin
  result := 'base';
end;

procedure TadxForm.ReleaseFloating;
begin
  if Assigned(FFormHook) then begin
    FreeAndNil(FFormHook);
    if IsWindowVisible(FHostHandle) then
      Windows.SetFocus(FHostHandle);
  end;
  fIsFloating := false;
end;

procedure TadxForm.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
//  if csDesigning in ComponentState then begin
//    inherited;
//    exit;
//  end;
//
//  if Assigned(Canvas) then
//    Canvas.FillRect(ClientRect);
  inherited;
end;

procedure TadxForm.WndProc(var Msg: TMessage);
var
  wmKey: TWMKey;
  cmd: TMSG;
  key: word;
  bWidth, bSides: integer;
  //shiftState: TShiftState;
  nativeImage: Pointer;
  sp: PNCCalcSizeParams;
  lParams: TadxDragLayoutParams;
  WPos: PWindowPos;
  SHOW_WHEN_WINDOWPOSCHANGING: boolean;
begin
  try
    if not (csDesigning in self.ComponentState) then begin


      if Msg.Msg = WM_WINDOWPOSCHANGING then begin
        WPos:= Pointer(Msg.lParam);
        SHOW_WHEN_WINDOWPOSCHANGING := ((WPos^.flags and SWP_SHOWWINDOW) > 0);

        if (SHOW_WHEN_WINDOWPOSCHANGING)
        and (FHostVersion = v2010)
        and (FormRegion <> nil) and (FormRegion.FState = irsMinimized) and (not IsFloating)//Case 2111
        then begin
          Log.AddMessage('EXCLUDE SWP_SHOWWINDOW');
          WPos^.flags := WPos^.flags xor SWP_SHOWWINDOW;
        end;
        inherited WndProc(Msg);
        exit;
      end;

      if Msg.Msg = WM_ADXGETPICTURE then begin
        nativeImage:= nil;
        PictureHelper.GetPicturePointer(IconImage, nativeImage);
        if nativeImage <> nil then begin
          PPointer(Msg.LParam)^:= nativeImage;
          Msg.Result:= adxMessageResult;
        end
        else
          Msg.Result:= 0;
        exit;
      end

      else
      if (Msg.Msg = WM_ADXGETCAPTION) then begin
        if Pointer(Msg.LParam) <> nil then begin
          StrPCopy(PAnsiChar(Msg.LParam), AnsiString(Caption));
        end;
      end

      else
      if (Msg.Msg = WM_ADXMOUSELEAVE) then begin
        if Assigned(FFormHook) then
          FFormHook.MouseCapture:= true;
        exit;
      end

      else
      if (Msg.Msg = WM_ENDSESSION) then begin
          Log.AddMessage('TadxForm.WndProc.WM_ENDSESSION');
          exit;
      end

      else
      if Msg.Msg = WM_ADXSETOLDPROC then begin
        FAppWindow.OldWindowProc := Pointer(PCardinal(Msg.LParam)^);
        Msg.Result:= adxMessageResult;
        exit;
      end

      else
      if Msg.Msg = WM_ADXSUPPORTMINIMIZE then begin
        Msg.Result:= adxMessageResult;
        exit;
      end

      else
      if Msg.Msg = WM_ADXREDESIGNSUPPORT then begin
        Msg.Result:= 0;
        if IsRedesignSupport(Msg.WParam) then
          Msg.Result:= adxMessageResult;
        exit;
      end

      else
      if Msg.Msg = WM_ADXSWAPCONTROLLER then begin
        Msg.Result:= 0;
        if Assigned(FContainerPane) then begin
          FContainerPane.SwapController(0, Msg.WParam, Pointer(Msg.LParam));
          Msg.Result:= adxMessageResult;
        end;
        exit;
      end

      else
      if Msg.Msg = WM_ADXDRAGOVERMINIMIZED then begin
        DoAdxDragOverMinimized(PadxDragOverMinimizedParams(msg.LParam));
        Msg.Result:= adxMessageResult;
        exit;
      end

      else
      if Msg.Msg = WM_ADXSHOWFLOATING then begin
        if IsExpandFromMinimizedState then begin
          EnableWindow(FAppWindow.Handle, true);
          PostMessage(Handle, WM_ADXCOMMAND, adxFormActivate, 0);
          Msg.Result:= 0;
          exit;
        end;
        ShowFloating(Cardinal(Msg.WParam), PWindowPos(Msg.LParam)^);
        Msg.Result:= adxMessageResult;
        exit;
      end

      else
      if Msg.Msg = WM_ADXHIDEFLOATING then begin
        HideFloating;
        Msg.Result:= adxMessageResult;
        exit;
      end

      else
      if Msg.Msg = WM_ADXSETFLOATINGPOS then begin
        SetFloatingPos(PWindowPos(Msg.LParam)^);
        Msg.Result:= adxMessageResult;
        exit;
      end

      else
      if Msg.Msg = WM_ADXGETDRAGLAYOUTPARAMS then begin
        if Pointer(Msg.LParam) <> nil then begin
          lParams:= PadxDragLayoutParams(Msg.LParam)^;
          GetDragLayoutParams(lParams);
          PadxDragLayoutParams(Msg.LParam)^:= lParams;
          Msg.Result:= adxMessageResult;
        end
        else
          Msg.Result:= 0;
        exit;
      end

      else
      if Msg.Msg = WM_ADXGETFORMDEFAULTSIZE then begin
        if Pointer(Msg.LParam) <> nil then begin
          PSize(Msg.LParam).cx:= FDefaultWidth;
          PSize(Msg.LParam).cy:= FDefaultHeight;
          Msg.Result:= adxMessageResult;
        end
        else
          Msg.Result:= 0;
        exit;
      end

      else
      if Msg.Msg = WM_ADXSETDRAGITEMS then begin
        if Msg.WParam > 0 then begin
          SendMessageToDragContainerWithDragItems(Msg.WParam);
          Msg.Result := adxMessageResult;
        end
        else
          Msg.Result:= 0;
        exit;
      end

      else
      if Msg.Msg = WM_ADXSETDRAGFORM then begin
        SetDragForm(Msg.WParam, Msg.LParam);
        Msg.Result:= adxMessageResult;
        exit;
      end

      else
      if Msg.Msg = WM_ADXCOMMAND then begin
        case Msg.WParam of
          adxHotKey:
          begin
            if Perform(CM_DIALOGCHAR, PMSG(Msg.LParam)^.wParam, PMSG(Msg.LParam)^.lParam) > 0 then
              Msg.Result := adxMessageResult;
          end;

          adxShortCut:
          begin
            wmKey.Msg:= PMSG(Msg.LParam)^.message;
            wmKey.CharCode:= PMSG(Msg.LParam)^.wParam;
            wmKey.KeyData:= PMSG(Msg.LParam)^.lParam;
            if (ActiveControl <> nil) and (TProtectionControl(ActiveControl).PopupMenu <> nil) then
              TProtectionControl(ActiveControl).PopupMenu.IsShortCut(wmKey)
            else
            if self.PopupMenu <> nil then begin
              if self.PopupMenu.IsShortCut(wmKey) then
                Msg.Result := adxMessageResult;
            end
            else
            if IsShortCut(wmKey) then
              Msg.Result := adxMessageResult;
          end;

          adxEmulateTab:
          begin
            if inherited Visible then
              if Perform(CM_DIALOGKEY, PMSG(Msg.LParam)^.wParam, PMSG(Msg.LParam)^.lParam) > 0 then
                Msg.Result := adxMessageResult;
          end;

          adxEmulateKeyMessage:
          begin
            cmd:= PMSG(Msg.LParam)^;
            if cmd.wParam = VK_RETURN then begin
                if (ActiveControl.Perform(CB_GETDROPPEDSTATE, 0, 0) <> 1) and (cmd.message = WM_KEYDOWN) then begin
                  key:= cmd.wParam;
                  if self is TadxXLCustomForm then begin
//                    if ActiveControl is TWinControl then begin
//                      shiftState:= [];
//                      if GetKeyState(VK_MENU) and $80 > 0 then Include(shiftState, ssAlt);
//                      if GetKeyState(VK_SHIFT) and $80 > 0 then Include(shiftState, ssShift);
//                      if GetKeyState(VK_CONTROL) and $80 > 0 then Include(shiftState, ssCtrl);
//                      if KeyPreview and (self <> ActiveControl) and Assigned(OnKeyDown) then
//                        OnKeyDown(self, key, shiftState);
//                      if Assigned(TWinControlAccess(ActiveControl).OnKeyDown) then
//                        TWinControlAccess(ActiveControl).OnKeyDown(ActiveControl, key, shiftState);
//                    end;
                    Perform(CM_DIALOGKEY, key, cmd.lParam);
                    Msg.Result:= adxMessageResult;
                    exit;
                  end
                  else begin
                    Perform(CM_DIALOGKEY, key, cmd.lParam);
                    exit;
                  end;
                end

                else
                if cmd.message <> WM_CHAR then begin
                  ActiveControl.Perform(cmd.message, cmd.wParam, cmd.lParam);
                  Msg.Result := adxMessageResult;
                end;
            end
          end;

          adxSetFocus: begin
            if inherited visible then begin
              if Msg.LParam <> 0 then begin
                if IsWindowVisible(Msg.LParam) then
                  Windows.SetFocus(Msg.LParam);
              end
              else
                SetFocus;
            end;
            Msg.Result := adxMessageResult;
          end;

          adxHideForm: begin
            HideByManager;
          end;

          adxFormFocused: begin
            InstanceFocused:= Boolean(Msg.LParam);
          end;

          adxSetChildMode: begin
            ChildMode := (Msg.LParam <> 0);
          end;

          adxFormActivate: begin
            Activate;
            Msg.Result := adxMessageResult;
          end;

          adxActivateClientLayout: begin
            if (IsClientLayout) then begin
              Activate;
              Msg.Result := adxMessageResult;
              exit;
            end;
          end;

          adxExistCompleteRegion: begin
            if (fIsClientLayout or IsSubstInspectorRegion()) then
              Msg.Result := adxMessageResult;
            exit;
          end;
        end;
        exit;
      end

      else
      if Msg.Msg = WM_ADXEXISTSERVICEFORM then begin
        if IsCLientLayout then begin
          Msg.Result:= adxMessageResult;
        end;
        exit;
      end

      else
      if Msg.Msg = WM_ADXFORMSHOW then begin
        if Boolean(Msg.WParam) then
          inherited Visible:= True
        else
          inherited Visible:= False;
      end

      else
      case Msg.Msg of
        WM_PAINT, WM_NCPAINT: begin
          inherited WndProc(Msg);
          if Assigned(FormRegion) and (FormRegion.State = irsMinimized) then begin
            DrawFrameFloating;
          end
          else
            DrawFrame;
          exit;
        end;

        WM_MOUSEACTIVATE: begin
          inherited;
          if Assigned(fContainerPane) then
            FContainerPane.ContainerRefresh(rfLighReset, not FInjected, Handle);
          exit;
        end;

//        WM_NCHITTEST: if IsFloating then begin
//          inherited;
//          pt.X := Msg.LParamLo;
//          pt.Y := Msg.LParamHi;
//          GetWindowRect(Handle, R);
//          case FLayout of
//            wlLeft:   begin
//              R.Left:= R.Right- (inherited BorderWidth);
//              if PtInRect(R, pt) then
//                Msg.Result:= HTRIGHT;
//            end;
//            wlRight:  begin
//              R.Right:= R.Left+ (inherited BorderWidth);
//              if PtInRect(R, pt) then
//                Msg.Result:= HTLEFT;
//            end;
//            wlTop:    begin
//              R.Top:= R.Bottom- (inherited BorderWidth);
//              if PtInRect(R, pt) then
//                Msg.Result:= HTBOTTOM;
//            end;
//            wlBottom: begin
//              R.Bottom:= R.Top+ (inherited BorderWidth);
//              if PtInRect(R, pt) then
//                Msg.Result:= HTTOP;
//            end;
//          end;
//          exit;
//        end;

        WM_NCCALCSIZE: begin
          if msg.WParam > 0 then begin
            DefaultHandler(msg);
            sp:= PNCCalcSizeParams(Pointer(msg.LParam));
            bWidth:= BorderWidth;
            bSides:= BorderSides;

            if bSides and BF_LEFT   <> 0 then inc(sp^.rgrc[0].Left, bWidth);
            if bSides and BF_TOP    <> 0 then inc(sp^.rgrc[0].Top, bWidth);
            if bSides and BF_RIGHT  <> 0 then dec(sp^.rgrc[0].Right, bWidth);
            if bSides and BF_BOTTOM <> 0 then dec(sp^.rgrc[0].Bottom, bWidth);
            exit;
          end;
        end;

        WM_THEMECHANGED: FTheme.Refresh;

        WM_ACTIVATE: begin
          if (Msg.WParam = 0) then begin
            if (Msg.LParam = 0) then begin
              Windows.PostMessage(HostHandle, WM_NCACTIVATE, 0, 0);
            end
            else begin
              if ((not Windows.IsChild(fHostHandle, Msg.LParam)) and (HWND(Msg.LParam) <> HostHandle)) then begin
                Windows.PostMessage(HostHandle, WM_NCACTIVATE, 0, 0);
              end
            end;
          end
          else Windows.PostMessage(HostHandle, WM_NCACTIVATE, 1, 0);
        end;
      end; {case}
    end; {if ComponentState is not csDesigning}

    inherited WndProc(Msg);
  except
    on e: Exception do begin
      Log.AddException(Format('TAdxForm.WndProc(msg= %x, wparam= %x, lparam= %x). %s', [Msg.Msg, Msg.WParam, msg.LParam, e.Message]));
      raise E;
    end;
  end;
end;

function TadxForm.AdxLayoutKey: string;
begin
  case Layout of
    wlLeft:   result:= 'Left';
    wlRight:  result:= 'Right';
    wlTop:    result:= 'Top';
    wlBottom: result:= 'Bottom';
  else
    result:= 'Unknown';
  end;
end;

function TadxForm.AdxLocalRegistryKey: string;
begin
  result := '\Software\Microsoft\Office\Outlook\AddIns\ADXForm\';
end;

function TadxForm.AdxLockWindowUpdate(HwndLock: HWND): boolean;
begin
  Result:= LockWindowUpdate(HwndLock);
end;

function TadxForm.AdxRegistryKey: string;
begin
  result := '\Software\Microsoft\Office\Outlook\AddIns\ADXForm\';
end;

procedure TadxForm.DoBeforeDelete;
var
  Action: TCloseAction;
begin
  Action := caFree;
  DoClose(Action);
end;

function TadxForm.GetActive: boolean;
begin
  if not (csDesigning in self.ComponentState) then begin
    if IsFloating then
       result:= IsWindowVisible(Handle)
    else
      result:= (Injected and (FormRegion.State = irsNormal)) or IsFloating;
  end
  else result:= inherited Active;
end;

function TadxForm.GetMinFormOnContainerWhenShowHeader: integer;
begin
  if (FAlwaysShowHeader) or (FormRegion.State =  irsMinimized) then
    result:= 0
  else
    result:= 2;
end;

function TadxForm.GetOSCConnected: boolean;
begin
  Result:= false;
end;

function TadxForm.GetRegionBorderSize: integer;
begin
  Result:= 0;
  case FRegionBorderStyle of
    rbsNone:    Result:= 0;
    rbsSingle:  Result:= 1;
  end;
end;

function TadxForm.GetRegionState: TadxRegionState;
begin
  result := TadxRegionState(99);
  try
    if (not Visible) and (TadxRegionStateGuard.Instance.IsLock) then begin
      raise SysUtils.Exception.Create('It is not possible to get the RegionState property at the moment.');
    end;


    if (FormRegion <> nil) then begin
        if (FormRegion.State =irsUnknown) or (not FInjected) then begin
            if (TadxRegionStateGuard.Instance.IsLock) then begin
              raise SysUtils.Exception.Create('It is not possible to get the RegionState property at the moment (2).');
            end
            else begin
              result := GetFutureRegionState;
              exit;
            end;
        end;

        case FormRegion.State of
          irsUnknown: raise SysUtils.Exception.Create('It is not possible to get the RegionState property at the moment (3).');
          irsNormal: result := rsNormal;
          irsHidden: result := rsHidden;
          irsMinimized: result := rsMinimized;
        end;
    end
    else begin
      raise SysUtils.Exception.Create('It is not possible to get the RegionState property at the moment (3).');
    end;
  except
    on e: Exception do begin
      TadxExceptionManager.ProcessADXXError(E, ClassName +'.GetRegionState');
    end;
  end;
end;

function TadxForm.EnableMinimizeRegion: boolean;
begin
  result:= true;
end;

function TadxForm.GetBackColor: TColor;
begin
  if Assigned(FTheme) and (FTheme.FAppVersion > v2002) then begin
    result:= ARGBToColorRef(DarkerColor(FTheme.FWndColor.BackGround, 5));
  end
  else
    result:= Color;
end;

function TadxForm.GetBorderSides: word;
begin
  Result:= BF_TOPLEFT + BF_BOTTOMRIGHT;
  if (not IsFloating) and (RegionBorderStyle = rbsNone) then begin
    Result:= 0;
    if IsHeaderVisible then
      Result:= BF_TOP;
  end;
end;

function TadxForm.IsHeaderVisible: boolean;
begin
  result:= false;
  if Assigned(FContainer) then
    result:= (FContainer.Count >= MinFormOnContainerWhenShowHeader);
end;

procedure TadxForm.DoInternalActivate;
begin
  if Visible then
    if not ActivateEventFlag then begin
      if IsDockLayout then
        UpdateCTPParam(utSetSplitter, 0);
      ActivateEventFlag:= true;
      DoActivate;
    end;
end;

procedure TadxForm.DoDeactivate;
begin
  if Visible then
    if ActivateEventFlag then begin
      ActivateEventFlag:= false;
      if Assigned(fContainerPane) then
        FContainerPane.ContainerRefresh(rfLighReset, not FInjected, Handle);
      if Assigned(OnDeactivate) then OnDeactivate(Self);
    end;
end;

function TadxForm.GetVisible: boolean;
begin
  result:= fVisible;
end;

procedure TadxForm.DoInstanceFocused(focused: boolean);
begin
  //
end;

procedure TadxForm.SetInstanceFocused(const Value: boolean);
begin
  if FInstanceFocused <> Value then begin
    FInstanceFocused := Value;
    if Assigned(fContainerPane) then
      FContainerPane.ContainerRefresh(rfLighReset, not FInjected, Handle);
    DoInstanceFocused(FInstanceFocused);
  end;
end;

procedure TadxForm.HideByManager;
begin
  HideByManager(false);
end;

function TadxForm.GetFormID: string;
begin
  result := FFormID;
end;

function TadxForm.GetFormRegion: TadxFormRegion;
begin
  result:= FFormRegion;
end;

function TadxForm.GetIconImage: TadxGPBitmap;
var
  stream: TMemoryStream;
begin
  if FIconImage = nil then begin
    if not Icon.Empty then begin
      stream:= TMemoryStream.Create;
      Icon.SaveToStream(stream);
      try
        IconToBitmap(stream, FIconImage);
      finally
        stream.Free;
      end;
    end;
  end;
  result:= FIconImage;
end;

procedure TadxForm.SetDragForm(AItemType: TAdxItemType;
  ALayout: TadxWindowLayout);
begin

end;

procedure TadxForm.SetDragItems(ADragItems: TList);
var
  dragItem: PadxDragItemParams;
  appHandle: HWND;
begin
  AppHandle := GetAppWindowHandle(FHostVersion, stOlMail, FHostHandle);
  if AppHandle > 0 then begin
    GetMem(dragItem, SizeOf(TadxDragItemParams));
    dragItem^.DragLayout:= dwlAll;
    dragItem^.ItemType:= stOlMail;
    dragItem^.ItemHandle:= AppHandle;
    ADragItems.Add(dragItem);
  end;

  AppHandle := GetAppWindowHandle(FHostVersion, stOlReadingPane, FHostHandle);
  if AppHandle > 0 then begin
    GetMem(dragItem, SizeOf(TadxDragItemParams));
    dragItem^.DragLayout:= dwlAll;
    dragItem^.ItemType:= stOlReadingPane;
    dragItem^.ItemHandle:= AppHandle;
    ADragItems.Add(dragItem);
  end;

  AppHandle := GetAppWindowHandle(FHostVersion, stOlTodoBar, FHostHandle);
  if AppHandle > 0 then begin
    GetMem(dragItem, SizeOf(TadxDragItemParams));
    dragItem^.DragLayout:= dwlBottom;
    dragItem^.ItemType:= stOlTodoBar;
    dragItem^.ItemHandle:= AppHandle;
    ADragItems.Add(dragItem);
  end;

  AppHandle := GetAppWindowHandle(FHostVersion, stOlNavigationPane, FHostHandle);
  if AppHandle > 0 then begin
    GetMem(dragItem, SizeOf(TadxDragItemParams));
    dragItem^.DragLayout:= dwlBottom;
    dragItem^.ItemType:= stOlNavigationPane;
    dragItem^.ItemHandle:= AppHandle;
    ADragItems.Add(dragItem);
  end;
end;

function TadxForm.GetBorderWidth: integer;
begin
  Result:= 0;
  if IsFloating then
    Result:= BorderWidthFloatingDefault;
end;

procedure TadxForm.SetRegionBorderStyle(
  const Value: TadxRegionBorderStyle);
begin
  if FRegionBorderStyle <> Value then begin
    FRegionBorderStyle := Value;
    if Assigned(FAppWindow) then
      FAppWindow.AdxRefresh;
  end;
end;

procedure TadxForm.SetRegionState(const Value: TadxRegionState);
begin
  try
    if (Visible) then begin
      if (FormRegion <> nil) then begin
        if (TadxRegionStateGuard.Instance.IsLock) then begin
          raise SysUtils.Exception.Create('It is not possible to set the RegionState property at the moment.');
        end;

        if (Injected) then begin
           if (FormRegion.State <> irsUnknown) then begin
            case Value of
              rsNormal: if self.FormRegion.State <> irsNormal then SetFormRegionState(irsNormal);
              rsHidden: if self.FormRegion.State <> irsHidden then self.SetFormRegionState(irsHidden);
              rsMinimized: if self.FormRegion.State <> irsMinimized then self.SetFormRegionState(irsMinimized);
            end;
          end;
        end
        else begin
          if (not SetRegionStateByMessage(value)) then begin
            FNeededRegionState := Globals.ContertToInternalRegionState(value);
          end;
        end;
      end;
    end;
  except
    on e: Exception do begin
      TadxExceptionManager.ProcessADXXError(E, ClassName +'.SetRegionState');
    end;
  end;
end;

function TadxForm.GetUserHeight: integer;
var
  bSize: integer;
begin
  bSize:= RegionBorderSize;
  if IsHeaderVisible and (bSize = 0) then
    result:= FUserHeight + 1
  else
    result:= FUserHeight + bSize* 2;
end;

procedure TadxForm.GetUserSize(var ASize: integer);
begin
  case FLayout of
    wlLeft, wlRight, wlDockLeft, wlDockRight: ASize:= UserWidth;
    wlTop, wlBottom, wlDockTop, wlDockBottom: ASize:= UserHeight;
    wlClient: ASize:= 0;
  end;
end;

function TadxForm.GetUserWidth: integer;
begin
  result:= FUserWidth + RegionBorderSize* 2;
end;

procedure TadxForm.SetUserWidth(const Value: integer);
begin
  FUserWidth := Value - RegionBorderSize* 2;
end;

procedure TadxForm.SetUserHeight(const Value: integer);
var
  bSize: integer;
begin
  bSize:= RegionBorderSize;
  //FUserHeight := Value - RegionBorderSize* 2;
  if IsHeaderVisible and (bSize = 0) then
    FUserHeight := Value - 1
  else
    FUserHeight := Value - bSize* 2;
end;

procedure TadxForm.SetUserSize(ASize: integer);
begin
  case FLayout of
    wlLeft, wlRight, wlDockLeft, wlDockRight: UserWidth := ASize;
    wlTop, wlBottom, wlDockTop, wlDockBottom: UserHeight:= ASize;
  end;
end;

procedure TadxForm.UpdateRegion(DestDC: HDC; ARegion: HRGN);
var
  wInfoHost: TWindowInfo;
  RPane, RRegion: TRect;
  Rgn: HRGN;
  //hOffset: integer;
begin
  GetWindowInfo(FHostHandle, wInfoHost);
  //if IsWindowVisible(Handle) then begin
  if FInjected then begin
    //GetWindowRect(Handle, RPane);
    GetWindowRect(FContainerPane.Handle, RPane);
    OffsetRect(RPane, -wInfoHost.rcWindow.Left, -wInfoHost.rcWindow.Top);
    RRegion:= RPane;
    Rgn:= CreateRectRgnIndirect(RRegion);
    CombineRgn(ARegion, ARegion, Rgn, RGN_XOR);
    DeleteObject(Rgn);
  end;
  {if IsWindowVisible(FContainerPane.Handle) then begin
    GetWindowRect(FContainerPane.Handle, RPane);
    OffsetRect(RPane, -wInfoHost.rcWindow.Left, -wInfoHost.rcWindow.Top);
    hOffset := wInfoHost.rcClient.Left- wInfoHost.rcWindow.Left;
    FContainerPane.PaintTo(DestDC, RPane.Left- hOffset, RPane.Top);
  end;}
end;

function TadxForm.UseOfficeThemeBackColor: boolean;
begin
  result:= true;
end;

procedure TadxForm.HideByManager(UsingVisibleProperty: boolean);
begin
  Hide;
end;

procedure TadxForm.UpdateColor(AHostVersion: TadxHostVersion);
begin
  if UseOfficeThemeBackColor and assigned(FTheme) then begin
    FTheme.Initialize(AHostVersion, stOlUnknown, 0);
    Color:= GetBackColor;
  end;
end;

procedure TadxForm.UpdateCTPParam(uType: TadxCTPUpdateParamType; ASize: integer);
begin
end;

function TadxForm.GetFutureRegionState: TadxRegionState;
var
  RegionParam: TadxRegionParam;
begin
  if (TadxFormRegion.GetRegionParam(PAppWindowProperty(FAppWindowProperty).WindowHandle, RegionParam, PAppWindowProperty(FAppWindowProperty).Layout)) then begin
    Result := Globals.ContertToRegionState(TadxInternalRegionstate(RegionParam.State), TadxRegionState(GetDefaultregionState()));
    exit;
  end
  else begin
    if Assigned(FFormRegion) then
      FFormRegion.RegistryLoad(RegionParam);
    Result := Globals.ContertToRegionState(TadxInternalRegionstate(RegionParam.State), TadxRegionState(GetDefaultregionState()));
    exit;
  end;
end;

function TadxForm.SetRegionStateByMessage(
  ARegionState: TadxRegionState): boolean;
var
  RegionParam: TadxRegionParam;
begin
  RegionParam.State := ord(Globals.ContertToInternalRegionState(ARegionState));
  RegionParam.Size := -1;
  Result := TadxFormRegion.SetRegionParam(PAppWindowProperty(FAppWindowProperty).WindowHandle, RegionParam, PAppWindowProperty(FAppWindowProperty).Layout);
end;

function TadxForm.IsSupportAdjacentWindow: boolean;
begin
  Result:= false;
  if (FItemType = stOlReadingPane) and (FHostVersion >= v2003) then
    Result:= OSCConnected;
end;

function TadxForm.IsSubstInspectorRegion: boolean;
begin
  result := false;
end;

{ TDebug }

class procedure TDebug.Assert(Conditional: boolean; ExceptionMessage: string);
begin
//{$IFDEF DEBUG} //TODO:IFDEF DEBUG
//  if (not Conditional) then begin
//    raise SysUtils.Exception.Create('Assert: ' + ExceptionMessage);
//  end;
//{$ENDIF}
end;

class procedure TDebug.WriteLine(s: string);
begin
//  {$IFDEF UNICODE}
//  OutputDebugString(PWideChar(s)); { TODO : !!! }
//  {$ELSE}
//  OutputDebugString(PAnsiChar(s));
//  {$ENDIF}
end;

function TadxForm.GetAppWindowProperty: Pointer;
begin
  result := FAppWindowProperty;
end;

function TadxForm.IsDockLayout: boolean;
begin
  Result:= (FItemType = stOfficeTaskPane);
end;

function TadxForm.IsDragDropAllowed: boolean;
begin
  result:= true;
end;

function TadxForm.IsExpandFromMinimizedState: boolean;
begin
  result:= false;
end;

function TadxForm.IsExplorerForm: boolean;
begin
  result := not IsInspectorForm;
end;

function TadxForm.IsInspectorForm: boolean;
begin
  result:= false;
  case FItemType of
    stOlFolderList: result := false;
    stOlOutlookBar: result := false;
    stOlNavigationPane: result := false;
    stOlMail: result := false;
    stOlAppointment: result := false;
    stOlContact: result := false;
    stOlJournal: result := false;
    stOlNote: result := false;
    stOlTask: result := false;
    stOlReadingPane: result := false;
    stOlTodoBar: result := false;
    stOlWebViewPane: result := false;

    stOlMailInspector: result := true;
    stOlDefaultInspector: result:= true;

    stOlWordMailInspector: result := true;
    stOlAppointmentInspector: result := true;
    stOlTaskInspector: result := true;
    stOlContactInspector: result := true;
    stOlJournalInspector: result := true;
    stOlMeetingInspector: result := true;
    stOlDistributionListInspector: result := true;
    
    stXlMain: result:= false;
    stXLSheet: result:= false;
  end;
end;

function TadxForm.IsRedesignSupport(Version: integer): boolean;
begin
  result:= (Version = reDesignVersion);
end;

function TadxForm.IsSplitterVisible: boolean;
begin
  Result:= true;
  if IsDockLayout or ((FLayout = wlClient) and (not IsClientLayout)) then
    Result:= false;
end;

{ TadxXLCustomForm }

procedure TadxXLCustomForm.CreateAdxObjectsInstances;
var
  fThemeColor: TadxXLThemeColor;
begin
  fThemeColor:= TadxXLThemeColor.Create;

  FFormRegion:= TadxFormRegion.Create(Self);
  FTheme:= TadxTheme.CreateEx(fThemeColor);
  FAppWindow := TAppWindow.CreateEx(self);
  FContainer := TadxContainer.CreateEx(Self);
  FContainerPane:= TadxXLContainerPane.CreateEx(FContainer);
end;

{ TadxOLCustomForm }

function TadxOLCustomForm.AdxLockWindowUpdate(HwndLock: HWND): boolean;
begin
  Result:= true;
  if FHostVersion < v2010 then
    Result:= LockWindowUpdate(HwndLock);
end;

procedure TadxOLCustomForm.CreateAdxObjectsInstances;
begin
  FFormRegion:= TadxFormRegion.Create(Self);
  FTheme:= TadxTheme.Create(nil);
  FAppWindow := TAppWindow.CreateEx(self);
  FContainer := TadxContainer.CreateEx(Self);
  FContainerPane:= TadxOLContainerPane.CreateEx(FContainer);
end;

{ TAdxWMIEmulateWindow }

constructor TAdxWMIEmulateWindow.CreateEx(AControlHandle: HWND);
var
  R: TRect;
  currentFocus: HWND;
begin
  FControlHandle:= AControlHandle;
  FResponse:= true;
  if FControlHandle > 0 then begin
    GetWindowRect(FControlHandle, R);
    GetWindowRect(GetParent(FControlHandle), FRect);
    FControlParent:= GetParent(FControlHandle);
    OffsetX:= (FRect.Right- FRect.Left) - (R.Right- R.Left) - 4; //4- BorderWidth
    OffsetY:= (FRect.Bottom- FRect.Top) - (R.Bottom- R.Top) - 4;

    CreateParented(GetParent(FControlHandle));
    Windows.GetClientRect(GetParent(FControlHandle), FRect);
    with MainPos do begin
      x:= 0; y:= 0; cx:= FRect.Right- FRect.Left; cy:= FRect.Bottom- FRect.Top;
      SetWindowPos(Handle, 0, x, y, cx, cy, SWP_NOZORDER or SWP_NOACTIVATE);
    end;

    SetWindowLongCheckUnicode(Handle, GWL_STYLE, WS_CHILDWINDOW or WS_CLIPSIBLINGS or WS_VISIBLE);
    currentFocus := GetFocus;
    Windows.SetParent(FControlHandle, Handle);
    if (currentFocus <> GetFocus) then begin
      Windows.SetFocus(currentFocus);//Case 1444
    end;

    Caption := 'AdxWMIEmulateWindow';
    ShowWindowAsync(Handle, SW_SHOWNORMAL);

    Windows.GetClientRect(FControlHandle, FControlRect);
  end;
end;

destructor TAdxWMIEmulateWindow.Destroy;
begin
  try
    Log.AddMessage('TAdxWMIEmulateWindow.Destroy');
    if (IsWindow(FControlHandle) and IsWindow(FControlParent)) then begin
      Log.AddMessage('TAdxWMIEmulateWindow.Destroy before SetParent');
      windows.SetParent(FControlHandle, FControlParent);
      Log.AddMessage('TAdxWMIEmulateWindow.Destroy after SetParent');
    end;
    inherited;
  except
    on E:SysUtils.Exception do begin
      Log.AddException('TAdxWMIEmulateWindow.Destroy ' + E.Message);
      raise E;
    end;
  end;
end;

procedure TAdxWMIEmulateWindow.WndProc(var Message: TMessage);
var R, R1: TRect;
    DeltaX, DeltaY: integer;
    IsControlWindowResize: boolean;
begin
  try
    if not FResponse then begin
      inherited;
      exit;
    end;

    if Message.Msg = WM_ADXWMISETPOS then begin
      if (WaitForSingleObject(hResizeEmulateWibdowMutexSbcls, mutexWaiting) = WAIT_OBJECT_0) then begin
        try
          //TODO: Synchronization
          with PWindowPos(Message.LParam)^ do
            SetWindowPos(FControlHandle, 0, 0, 0, cx-OffsetX, cy-OffsetY, SWP_NOREDRAW or SWP_NOMOVE or SWP_FRAMECHANGED or SWP_NOACTIVATE);
        finally
          ReleaseMutex(hResizeEmulateWibdowMutexSbcls);
        end;
      end;
    end;

    if Message.Msg = WM_ADXWMIGETCONTROL then begin
      if FResponse then Message.Result:= FControlHandle
      else Message.Result:= 0;
      exit;
    end;
    if Message.Msg = WM_ADXWMIPOSCHANGE then begin
      Windows.GetClientRect(FControlHandle, R1);
      IsControlWindowResize:= ((R1.Right - R1.Left) - (FControlRect.Right - FControlRect.Left)) + ((R1.Bottom - R1.Top) - (FControlRect.Bottom - FControlRect.Top)) <> 0;

      Windows.GetClientRect(GetParent(Handle), R);
      DeltaX:= (R.Right- R.Left) - (FRect.Right- FRect.Left);
      DeltaY:= (R.Bottom- R.top) - (FRect.Bottom- FRect.Top);

      if (DeltaX <> 0) or (DeltaY <> 0) then begin
        FRect:= R;
        MainPos.cx:= MainPos.cx + DeltaX;
        MainPos.cy:= MainPos.cy + DeltaY;
        with MainPos do SetWindowPos(Handle, 0, 0, 0, cx, cy, SWP_NOZORDER or SWP_NOMOVE or SWP_NOACTIVATE);
      end
      else
      if IsControlWindowResize then begin
        FControlRect:= R1;
        with MainPos do SetWindowPos(Handle, 0, 0, 0, cx, cy, SWP_NOZORDER or SWP_NOMOVE or SWP_NOACTIVATE);
      end;
    end;

    if Message.Msg = WM_ERASEBKGND then begin
      Message.Result:= 1;
      exit;
    end;
    inherited;

  except
    on e: Exception do begin
      Log.AddException(Format('TAdxWMIEmulateWindow.WndProc(msg= %x, wparam= %x, lparam= %x). %s', [Message.Msg, Message.WParam, Message.LParam, e.Message]));
      raise E;
    end;
  end;
end;

{ TAdxOlHook }

constructor TadxKeyboardHook.Create;
begin
  inherited Create;
  HookProc := VirtualAlloc(nil, 12, MEM_RESERVE or MEM_COMMIT, PAGE_EXECUTE_READWRITE);
  asm
    mov  EAX, Self
    mov  ECX, [EAX].TadxKeyboardHook.HookProc;
    mov  word  ptr [ECX+0], $6858
    mov  dword ptr [ECX+2], EAX
    mov  word  ptr [ECX+6], $E950
    mov  EAX, OFFSET(TadxKeyboardHook.CallbackFunction)
    sub  EAX, ECX
    sub  EAX, 12
    mov  dword ptr [ECX+8], EAX
  end;  
  HookHandle := SetWindowsHookEx(WH_KEYBOARD, HookProc, 0, GetCurrentThreadId);
  fConnected:= false;
end;

destructor TadxKeyboardHook.Destroy;
begin
  Log.AddMessage('TadxKeyboardHook.Destroy');
  Log.AddIndent;
  try
    try
      VirtualFree(HookProc, 0, MEM_RELEASE);
      Connected:= false;
      UnhookWindowsHookEx(HookHandle);
      inherited Destroy;

    except
      on E:SysUtils.Exception do begin
        Log.AddException('TadxKeyboardHook.Destroy ' + E.Message);
        raise E;
      end;
    end;

  finally
    Log.RemoveIndent;
  end;
end;

procedure TadxKeyboardHook.SetConnected(const Value: boolean);
begin
  if Value <> fConnected then begin
    if Value then begin
      fAtom:= AddAtom(PChar(VCLKeyboardHookAtomID));
      fConnected:= (fAtom > 0);
    end
    else begin
      fAtom:= FindAtom(PChar(VCLKeyboardHookAtomID));
      if fAtom > 0 then DeleteAtom(fAtom);
      fConnected:= false;
    end;
  end;
end;

function TadxKeyboardHook.GetConnected: boolean;
begin
  if not FConnected then begin
    fAtom:= FindAtom(PChar(VCLKeyboardHookAtomID));
    if fAtom <= 0 then begin
      fAtom:= AddAtom(PChar(VCLKeyboardHookAtomID));
      fConnected:= (fAtom > 0);
    end;
  end;
  Result:= FConnected;
end;

procedure TadxKeyboardHook.HookAction_SetFormStyleCHILD;
begin
  if FormHandle > 0 then begin
    if (GetWindowLongCheckUnicode(FormHandle, GWL_STYLE) and WS_CHILD) = 0 then
      SetWinAPIProperty(FormHandle, WS_CHILD);
    FormHandle:= 0;
  end;
end;

procedure TadxKeyboardHook.HookAction_SetFormStyleOVERLAPPED;
begin
  if FormHandle > 0 then begin
    if (GetWindowLongCheckUnicode(FormHandle, GWL_STYLE) and WS_CHILD) > 0 then
      UnSetWinAPIProperty(FormHandle, WS_CHILD);
  end;
end;

function TadxKeyboardHook.CallbackFunction(code: Longint; wParam, lParam: Cardinal): Longint;
begin
  Result:= KeyboardHookProc(code, wParam, lParam);
end;

function TadxKeyboardHook.KeyboardHookProc(code: Integer; wParam, lParam: Cardinal): Longint;
begin
  if (Code = HC_ACTION) and Connected then begin
    { Implementation keyboard hook - override }
  end;
  Result:= CallNextHookEx(HookHandle, Code, wparam, lparam);
end;

function TadxKeyboardHook.ProcessArrowAction(keyCode, keyData: Cardinal): boolean;
var VKey: byte;
begin
  VKey:= byte(keyCode);
  if AuditKey[VKey].Pressed then begin
    ActiveHandle:= Windows.GetFocus;
    //if IsAdxFormHandle(ActiveHandle, fFormHandle) then
    HookAction_SetFormStyleOVERLAPPED;
  end
  else
    HookAction_SetFormStyleCHILD;
  result:= true;
end;

function TadxKeyboardHook.ProcessCustomKey(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
var
  VKey: Word;
begin
  result:= false;
  if not (Assigned(OnKeyPressed) or Assigned(OnKeyReleased)) then exit;

  VKey:= keyCode;
  if (VKey >= HIGHKEY) then begin
    Log.AddWarning('VKey(' + IntToStr(VKey)+ ') >= HIGHKEY');
    exit;
  end;

  if AuditKey[VKey].Pressed then begin
    ActiveHandle:= Windows.GetFocus;
    if FormHandle > 0 then begin
      if Assigned(OnKeyPressed) then begin
        //TDebug.WriteLine(Format('!!! Key pressed (%x) FormHandle (%x)', [keyCode, FormHandle]));
        result := OnKeyPressed(keyCode, keyData, sysMessage);
      end;
    end;
  end
  else begin
    if FormHandle > 0 then begin
      if Assigned(OnKeyReleased) then begin
        //TDebug.WriteLine(Format('!!! Key released (%x) FormHandle (%x)', [keyCode, FormHandle]));
        result := OnKeyReleased(keyCode, keyData, sysMessage);
      end;
      FormHandle:= 0;
    end;
  end;
end;

function TadxKeyboardHook.SendKeyCharMessage(handle: HWND; KeyCode,
  KeyData: Cardinal; sysMessage, cmdMessage, makePost: boolean): longint;
var
  msg: TMSG;
  CharUnicode: array[0.. UnicodeCharBuffer-1] of word;
  count, i: integer;

begin
  result:= 0;
  msg.wParam  := KeyCode;
  msg.lParam  := KeyData;
  msg.hwnd    := handle;
  msg.message := WM_CHAR;
  if sysMessage then msg.message := WM_SYSCHAR;

  fillChar(CharUnicode, UnicodeCharBuffer* SizeOf(word), 0);
  count:= GetCharUnicode(KeyCode, KeyData, CharUnicode, sysMessage);

  if count = 0 then exit;
  if (count = -1) and (count < UnicodeCharBuffer) then begin
    msg.message := WM_DEADCHAR;
    msg.WParam := integer(CharUnicode[0]);
    if cmdMessage then
      result := TransmitMessage(FormHandle, WM_ADXCOMMAND, adxEmulateKeyMessage, Cardinal(@msg), makePost)
    else
      result := TransmitMessage(handle, msg.message, msg.WParam, msg.LParam, makePost);
  end
  else begin
    for i:= 0 to count- 1 do
    if i < UnicodeCharBuffer then begin
      msg.WParam := integer(CharUnicode[i]);
      if cmdMessage then
        result := TransmitMessage(FormHandle, WM_ADXCOMMAND, adxEmulateKeyMessage, Cardinal(@msg), makePost)
      else
        result := TransmitMessage(handle, msg.message, msg.WParam, msg.LParam, makePost);
    end;
  end;
end;

function TadxKeyboardHook.SendKeyPressMessage(handle: HWND; KeyCode,
  KeyData: Cardinal; sysMessage, cmdMessage: boolean; state: TadxKeyState;
  makePost: boolean): Longint;
var
  msg: TMSG;

begin
  msg.wParam  := KeyCode;
  msg.lParam  := KeyData;
  msg.hwnd    := handle;
  msg.message := WM_KEYDOWN;
  if sysMessage then msg.message := WM_SYSKEYDOWN;
  if state = csReleased then begin
    msg.message := WM_KEYUP;
    if sysMessage then msg.message := WM_SYSKEYUP;
  end;
  if cmdMessage then
    result := TransmitMessage(FormHandle, WM_ADXCOMMAND, adxEmulateKeyMessage, Cardinal(@msg), makePost)
  else
    result := TransmitMessage(handle, msg.message, msg.wParam, msg.lParam, makePost);
end;

function TadxKeyboardHook.SendKeyToHandle(handle: Cardinal; KeyCode, KeyData: Cardinal): boolean;
var
  keyPressed: byte;
  sysMessage: boolean;
begin
  keyPressed:= byte(KeyCode);
  try
    sysMessage:= AuditKey[VK_MENU].Pressed;
    if AuditKey[keyPressed].Pressed then begin
      SendKeyPressMessage(handle, KeyCode, KeyData, sysMessage, false, csPressed, true);
      SendKeyCharMessage(handle, KeyCode, KeyData, sysMessage, false, true);
      result:= true;
    end
    else begin
      SendKeyPressMessage(handle, KeyCode, KeyData, sysMessage, false, csReleased, true);
      result:= true;
    end;
  except
    on e: Exception do begin
      Log.AddException(format('%s KeyCode= %d KeyData= %d', [e.Message, KeyCode, KeyData]));
      raise;
    end;
  end;
end;

function TadxKeyboardHook.PreProcessKey_Pressed(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
begin
  result:= (SendKeyPressMessage(ActiveHandle, keyCode, keyData, sysMessage, true, csPressed, false) = adxMessageResult);
  result:= result or (SendKeyCharMessage(ActiveHandle, keyCode, keyData, sysMessage, true, false) = adxMessageResult);
end;

function TadxKeyboardHook.PreProcessKey_Released(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
begin
  result:= (SendKeyPressMessage(ActiveHandle, keyCode, keyData, sysMessage, true, csReleased, false) = adxMessageResult);
end;

function TadxKeyboardHook.SelectKey_Pressed(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
begin
  SendKeyPressMessage(ActiveHandle, keyCode, keyData, sysMessage, false, csPressed, false);
  SendKeyCharMessage(ActiveHandle, keyCode, keyData, sysMessage, false, false);
  result:= true;
end;

function TadxKeyboardHook.SelectKey_Released(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
begin
  SendKeyPressMessage(ActiveHandle, keyCode, keyData, sysMessage, false, csReleased, false);
  result:= true;
end;

function TadxKeyboardHook.HotKey_Pressed(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
var
  lpBuffer : TCharBuffer;
  asciiCode: integer;
  m: TMSG;
  KeyboardState: TKeyboardState;
begin
  result:= false;
  GetKeyboardState(KeyboardState);
  if ToAscii(keyCode, byte(keyData shr 16), KeyboardState, @lpBuffer, 0) >= 1 then begin
    asciiCode:= byte(lpBuffer[0]);    
    m.hwnd:= ActiveHandle;
    m.wParam:= asciiCode;
    m.lParam:= longword(keyData) or $20000000;
    Result:= (SendMessage(FormHandle, WM_ADXCOMMAND, adxHotKey, Cardinal(@m)) = adxMessageResult);
  end;
end;

function TadxKeyboardHook.WBKey_Pressed(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
var
  msgID: Cardinal;
begin
  msgID:= WM_KEYDOWN;
  if sysMessage then
    msgID:= WM_SYSKEYDOWN;
  result:= PostMessage(ActiveHandle, msgID, keyCode, keyData);
  Application.ProcessMessages;
end;

function TadxKeyboardHook.WBKey_Released(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
var
  msgID: Cardinal;
begin
  if byte(KeyCode) = VK_TAB then
    ActiveHandle:= Windows.GetFocus;

  msgID:= WM_KEYUP;
  if sysMessage then msgID:= WM_SYSKEYUP;
  result:= PostMessage(ActiveHandle, msgID, keyCode, keyData);
  Application.ProcessMessages;
end;

function TadxKeyboardHook.ShortCut_Pressed(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
var
  m: TMSG;
begin
  m.wParam:=  keyCode;
  m.lParam:=  keyData;
  result:= (SendMessage(FormHandle, WM_ADXCOMMAND, adxShortCut, Cardinal(@m)) = adxMessageResult);
end;

function TadxKeyboardHook.TabKey_Pressed(keyCode, keyData: Cardinal; sysMessage: boolean): boolean;
var
  m: TMSG;
begin
  m.wParam:=  keyCode;
  m.lParam:=  keyData;
  result:= (SendMessage(FormHandle, WM_ADXCOMMAND, adxEmulateTab, Cardinal(@m)) = adxMessageResult);
end;

function TadxKeyboardHook.ActiveWebBrowser: boolean;
var
  WndClassName: string;
begin
  ActiveHandle:= Windows.GetFocus;
  WndClassName:= GetWindowClassName(Activehandle);
  result:= (WndClassName = 'Internet Explorer_Server') or (WndClassName = 'SysListView32');
end;

function TadxKeyboardHook.GetAuditKey(key: integer): TAuditKey;
var
  keyState: smallint;
begin
  fAuditKey.Pressed:= false;
  fAuditKey.Toogled:= false;
  if (key > 0) and (key <= 255) then begin
    keyState:= GetKeyState(key);
    fAuditKey.Pressed:= (keyState and $80 > 0);
    fAuditKey.Toogled:= (keyState and $01 > 0);
  end;
  result:= fAuditKey;
end;

function TadxKeyboardHook.GetFormHandle: HWnd;
begin
  if not IsAdxFormHandle(ActiveHandle, FFormHandle) then
    FFormHandle := 0;
  result:= FFormHandle
end;

function TadxKeyboardHook.GetKeyFilterAction(const DefaultAction: TadxKeyFilterAction = faSendToAdxForm): TadxKeyFilterAction;
begin
  result:= DefaultAction;
  try
    result:= TadxKeyFilterAction(SendMessage(FFormhandle, WM_ADXCOMMAND, adxKeyFilter, Cardinal(@fKeyEventArgs)) );
  except
  end;
end;

procedure TadxKeyboardHook.SetKeyAction(const Value: THookKeyAction);
begin
  fKeyAction := Value;

  case fKeyAction of
    kaUnknown: begin
      fOnKeyPressed:=  nil;
      fOnKeyReleased:= nil;
    end;
    kaPreProcess: begin
      fOnKeyPressed:=  PreProcessKey_Pressed;
      fOnKeyReleased:= PreProcessKey_Released;
    end;
    kaSelectedKey: begin
      fOnKeyPressed:=  SelectKey_Pressed;
      fOnKeyReleased:= SelectKey_Released;
    end;
    kaShortCut: begin
      fOnKeyPressed:=  ShortCut_Pressed;
      fOnKeyReleased:= nil;
    end;
    kaHotKey: begin
      fOnKeyPressed:=  HotKey_Pressed;
      fOnKeyReleased:= nil;
    end;
    kaTabKey: begin
      fOnKeyPressed:=  TabKey_Pressed;
      fOnKeyReleased:= nil;
    end;
    kaWBKey: begin
      fOnKeyPressed:=  WBKey_Pressed;
      fOnKeyReleased:= WBKey_Released;
    end;
  end;
end;

{ TadxMessageHook }

function TadxMessageHook.CallbackFunction(code: Integer; wParam, lParam: Cardinal): Longint;
begin
  Result:= MessageHookProc(code, wParam, lParam);
end;

constructor TadxMessageHook.Create;
begin
  HookProc := VirtualAlloc(nil, 12, MEM_RESERVE or MEM_COMMIT, PAGE_EXECUTE_READWRITE);
  asm
    mov  EAX, Self
    mov  ECX, [EAX].TadxMessageHook.HookProc;
    mov  word  ptr [ECX+0], $6858
    mov  dword ptr [ECX+2], EAX
    mov  word  ptr [ECX+6], $E950
    mov  EAX, OFFSET(TadxMessageHook.CallbackFunction)
    sub  EAX, ECX
    sub  EAX, 12
    mov  dword ptr [ECX+8], EAX
  end;
  HookHandle := SetWindowsHookEx(WH_CALLWNDPROC, HookProc, 0, GetConnectThreadID);
  FConnected:= false;
  FOnMessageConnections:= TList.Create;
end;

destructor TadxMessageHook.Destroy;
begin
  if Assigned(FOnMessageConnections) then begin
    while FOnMessageConnections.Count > 0 do begin
      FreeMem(FOnMessageConnections.Items[0]);
      FOnMessageConnections.Delete(0);
    end;
    FOnMessageConnections.Free;
  end;

  Log.AddMessage('TadxMessageHook.Destroy');
  Log.AddIndent;
  try
    try
      VirtualFree(HookProc, 0, MEM_RELEASE);
      Connected:= false;
      UnhookWindowsHookEx(HookHandle);
      inherited Destroy;
    except
      on E:SysUtils.Exception do begin
        Log.AddException('TadxMessageHook.Destroy ' + E.Message);
        raise E;
      end;
    end;

  finally
    Log.RemoveIndent;
  end;
  inherited;
end;

procedure TadxMessageHook.DoMessage(msg: TCWPStruct);
var
  i: integer;
  handler: TadxHookMessageHandler;
  method: TMethod;
begin
  if FOnMessageConnections.Count > 0 then
  for i:= 0 to FOnMessageConnections.Count - 1 do begin
    method:= PMethod(FOnMessageConnections[i])^;
    handler := TadxHookMessageHandler(method);
    if Assigned(handler) then
      handler(msg);
  end;
end;

function TadxMessageHook.GetConnectThreadID: Cardinal;
begin
  result:= GetCurrentThreadId;
end;

function TadxMessageHook.GetConnected: boolean;
begin
  if not FConnected then begin
    FAtom:= FindAtom(PChar(VCLMessageHookAtomID));
    if FAtom <= 0 then begin
      FAtom:= AddAtom(PChar(VCLMessageHookAtomID));
      FConnected:= (FAtom > 0);
    end;
  end;
  Result:= FConnected;
end;

function TadxMessageHook.MessageHookProc(code: Integer; wParam, lParam: Cardinal): Longint;
begin
  if (Code = HC_ACTION) and Connected then begin
    { Implementation message hook - override }
  end;
  Result:= CallNextHookEx(HookHandle, Code, wparam, lparam);
end;

procedure TadxMessageHook.OnMessageConnect(handler: TadxHookMessageHandler; obj: TObject);
var
  i: integer;
  exist: boolean;
  pm: PMethod;
begin
  exist:= false;
  if FOnMessageConnections.Count > 0 then
  for i:= 0 to FOnMessageConnections.Count - 1 do begin
    if Assigned(FOnMessageConnections.Items[i]) then
      if (PMethod(FOnMessageConnections.Items[i])^.Code = @handler) and (PMethod(FOnMessageConnections.Items[i])^.Data = Pointer(obj)) then begin
        exist:= true;
        break;
      end;
  end;
  if not exist then begin
    GetMem(pm, SizeOf(TMethod));
    pm^.Code:= @handler;
    pm^.Data:= obj;
    FOnMessageConnections.Add(pm);
  end;
end;

procedure TadxMessageHook.OnMessageDisconnect(handler: TadxHookMessageHandler);
var
  i: integer;
begin
  if FOnMessageConnections.Count > 0 then
  for i:= 0 to FOnMessageConnections.Count - 1 do begin
    if Assigned(FOnMessageConnections.Items[i]) then
      if PMethod(FOnMessageConnections.Items[i])^.Code = @handler then begin
        FreeMem(FOnMessageConnections.Items[i]);
        FOnMessageConnections.Delete(i);
        break;
      end;
  end;
end;

procedure TadxMessageHook.SetConnected(const Value: boolean);
begin
  if Value <> FConnected then begin
    if Value then begin
      FAtom:= AddAtom(PChar(VCLMessageHookAtomID));
      FConnected:= (FAtom > 0);
    end
    else begin
      FAtom:= FindAtom(PChar(VCLMessageHookAtomID));
      if FAtom > 0 then DeleteAtom(FAtom);
      FConnected:= false;
    end;
  end;
end;

{ TadxPostMessageHook }

function TadxMouseHook.CallbackFunction(code: Integer; wParam,
  lParam: Cardinal): Longint;
begin
  Result:= MessageHookProc(code, wParam, lParam);
end;

constructor TadxMouseHook.Create;
begin
  HookProc := VirtualAlloc(nil, 12, MEM_RESERVE or MEM_COMMIT, PAGE_EXECUTE_READWRITE);
  asm
    mov  EAX, Self
    mov  ECX, [EAX].TadxMouseHook.HookProc;
    mov  word  ptr [ECX+0], $6858
    mov  dword ptr [ECX+2], EAX
    mov  word  ptr [ECX+6], $E950
    mov  EAX, OFFSET(TadxMouseHook.CallbackFunction)
    sub  EAX, ECX
    sub  EAX, 12
    mov  dword ptr [ECX+8], EAX
  end;
  HookHandle := SetWindowsHookEx(WH_MOUSE, HookProc, 0, GetConnectThreadID);
end;

destructor TadxMouseHook.Destroy;
begin
  Log.AddMessage('TadxPostMessageHook.Destroy');
  try
    VirtualFree(HookProc, 0, MEM_RELEASE);
    UnhookWindowsHookEx(HookHandle);
    inherited Destroy;
  except
    on E:SysUtils.Exception do begin
      Log.AddException('TadxPostMessageHook.Destroy ' + E.Message);
      raise E;
    end;
  end;
  inherited;
end;

function TadxMouseHook.GetConnectThreadID: Cardinal;
begin
  result:= GetCurrentThreadId;
end;

function TadxMouseHook.MessageHookProc(code: Integer; wParam,
  lParam: Cardinal): Longint;
begin
  if (Code = HC_ACTION) {and Connected} then begin
    { Implementation postMessage hook - override }
  end;
  Result:= CallNextHookEx(HookHandle, Code, wparam, lparam);
end;

{ TadxCustomHook }

constructor TadxCustomHook.Create;
begin
  FActiveFormHandle:= 0;
end;

procedure TadxCustomHook.DoFocused(HandleFocused: HWND; FlagFocused: boolean);
begin
  SendMessage(HandleFocused, WM_ADXCOMMAND, adxFormFocused, Cardinal(FlagFocused));
end;

procedure TadxCustomHook.SetActiveFormHandle(const Value: HWND);
begin
  if FActiveFormHandle <> Value then begin
    if FActiveFormHandle > 0 then begin
      DoFocused(FActiveFormHandle, false);
      if Value > 0 then
        DoFocused(Value, true);
    end
    else
    if Value > 0 then begin
      DoFocused(Value, true);
    end;
    FActiveFormHandle := Value
  end;
end;

procedure TadxCustomHook.SetIsIMEComposition(const Value: boolean);
begin
  if FIsIMEComposition <> Value then
    FIsIMEComposition := Value;
end;

{ TadxOLHook }

procedure TadxOLHook.AddHandleHookWatchObject(WatchObject: TWatchObject);
begin
  if (watchObject <> nil) then begin
    WatchObject.WatchEngineIsHook := true;
    if (MessageHook <> nil) then begin
      MessageHook.AddWatchObjects(watchObject);
    end;
  end;
end;

constructor TadxOLHook.CreateEx(AHostVersion: TadxHostVersion);
begin
  Log.AddMessage('TadxOLHook.CreateEx');
  Create;
  fKeyboardHook:= TadxOLKeyboardHook.CreateEx(self);
  fMessageHook:= TadxOLMessageHook.CreateEx(self);
  fIsCustomizeForm:= false;
  fHostVersion:= AHostVersion;
  //UpdateCompatibility(1, 0); //Support OSC
end;

destructor TadxOLHook.Destroy;
begin
  Log.AddMessage('TAdxOlHook.Destroy');
  try
    if Assigned(fKeyboardHook) then
      FreeAndNil(fKeyboardHook);
    if Assigned(fMessageHook) then
      FreeAndNil(fMessageHook);
    if Assigned(fAppScrollWindow) then
      FreeAndNil(fAppScrollWindow);
    if Assigned(fIntResource) then
      FreeAndNil(fIntResource);
    inherited Destroy;
  except
    on E:SysUtils.Exception do begin
      Log.AddException('TAdxOlHook.Destroy ' + E.Message);
      raise E;
    end;
  end;
end;

function TadxOLHook.GetEnableProcessWatchObjects: boolean;
begin
  result := fMessageHook.EnableProcessWatchObjects;
end;

procedure TadxOLHook.SetEnableProcessWatchObjects(const Value: boolean);
begin
  fMessageHook.EnableProcessWatchObjects := Value;
end;

function TadxOLHook.AddCTP(const CTPFactory: IDispatch; const CTPParentWindow: IDispatch; PCTPParam: PAdxCTPParams): HResult;
begin
  Result:= S_FALSE;
  try
  if not Assigned(fIntResource) then
    fIntResource:= TadxIntResource.Create(self);
  if Assigned(fIntResource) then
    Result:= fIntResource.DoAddCTP(CTPFactory, CTPParentWindow, PCTPParam);

  except
    on E:SysUtils.Exception do begin
      Log.AddException('TadxOLHook.AddCTP ' + E.Message);
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create(E.Message), 'TadxOLHook.AddCTP');
    end;
  end;
end;

function TadxOLHook.DeleteCTP(position: integer; CTPParentWindow: IDispatch): Hresult;
begin
  Result:= S_FALSE;
  try
    if not Assigned(fIntResource) then
      fIntResource:= TadxIntResource.Create(self);
    if Assigned(fIntResource) then
      Result:= fIntResource.DoDeleteCTP(position, CTPParentWindow);

  except
    on E:SysUtils.Exception do begin
      Log.AddException('TadxOLHook.DeleteCTP ' + E.Message);
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create(E.Message), 'TadxOLHook.DeleteCTP');
    end;
  end;
end;

function TadxOLHook.UpdateCompatibility(CFunc, PCParam: Cardinal): HResult;
begin
  Result:= S_FALSE;
  try
    if not Assigned(fIntResource) then
      fIntResource:= TadxIntResource.Create(self);
    if Assigned(fIntResource) then
      Result:= fIntResource.DoUpdateCompatibility(CFunc, PCParam);
  except
    on E:SysUtils.Exception do begin
      Log.AddException('TadxOLHook.UpdateCompatibility ' + E.Message);
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create(E.Message), 'TadxOLHook.UpdateCompatibility');
    end;
  end;
end;

function TadxOLHook.UpdateCTP(const CTPParentWindow: IDispatch; PCTPParam: PAdxCTPParams): HResult;
begin
  Result:= S_FALSE;
  try
  if Assigned(fIntResource) then
    Result:= fIntResource.DoUpdateCTP(CTPParentWindow, PCTPParam);

  except
    on E:SysUtils.Exception do begin
      Log.AddException('TadxOLHook.UpdateCTP ' + E.Message);
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create(E.Message), 'TadxOLHook.UpdateCTP');
    end;
  end;
end;

procedure TadxOLHook.UpdateOLExplorerParam(ARegionHandle: Hwnd; ARegionPos: TWindowPos);
begin
  if not Assigned(fIntResource) then
    fIntResource:= TadxIntResource.Create(self);
  if Assigned(fIntResource) then
    fIntResource.DoUpdateOLExplorerParam(ARegionHandle, ARegionPos);
end;

procedure TadxOLHook.UpdateOLScrollBar(ScrollHandle: HWND);
var
  wProc: Cardinal;
  regionHandle: HWND;
begin
  regionHandle:= GetParent(ScrollHandle);
  wProc:= GetWindowLongCheckUnicode(regionHandle, GWL_WNDPROC);
  if CallWindowProc(Pointer(wProc), regionHandle, WM_ADXEXIST, stOlContact, 0) = adxMessageResult then begin
    if not Assigned(fAppScrollWindow) then
      fAppScrollWindow:= TAppScrollWindow.Create;
    fAppScrollWindow.Handle:= 0;
    fAppScrollWindow.Handle:= ScrollHandle;
  end;
end;

{ TadxOLKeyBoardHook }

constructor TadxOLKeyBoardHook.CreateEx(AParent: TadxOLHook);
begin
  Create;
  FParent:= AParent;
end;

function TadxOLKeyBoardHook.KeyboardHookProc(code: Integer; wParam, lParam: Cardinal): Longint;
var
  keyPressed: byte;
  lockMessage: boolean;
  menuPressed, ctrlPressed, shiftPressed, onlyMenuPressed, shortCutPressed,
  isHotKey, CopyPasteOperation: boolean;
  keyFilterAction: TadxKeyFilterAction;

begin
  lockMessage:= false;
  try
    if (Code = HC_ACTION) and Connected and (not FParent.IsIMEComposition) then begin
      keyPressed:= byte(wparam);

      menuPressed :=  (AuditKey[VK_MENU].Pressed)    and (keyPressed <> VK_MENU);
      shiftPressed := (AuditKey[VK_SHIFT].Pressed)   and (keyPressed <> VK_SHIFT);
      ctrlPressed :=  (AuditKey[VK_CONTROL].Pressed) and (keyPressed <> VK_CONTROL);
      onlyMenuPressed := menuPressed and (not shiftPressed) and (not ctrlPressed);
      shortCutPressed := keyPressed in [VK_F1 .. VK_F24, VK_INSERT, VK_DELETE, VK_END, VK_HOME];
      isHotKey := (keyPressed in [$30 .. $5A]) and onlyMenuPressed;//[D0..Z]
      CopyPasteOperation := (keyPressed in [$43, $56, $58]) and ctrlPressed;
      CopyPasteOperation := CopyPasteOperation or ((keyPressed = VK_INSERT) and (ctrlPressed or shiftPressed));

      //WebBrowser
      if ActiveWebBrowser and (not menuPressed) then begin
        if (not (keyPressed in [$30 .. $5A])) or (CopyPasteOperation) then begin
          KeyAction:= kaWBKey;
          lockMessage := ProcessCustomKey(wParam, lParam, menuPressed);
        end;

        if LockMessage then begin
          CallNextHookEx(HookHandle, Code, wparam, lparam);
          Result:= 1;
          exit;
        end
        else begin
          Result:= CallNextHookEx(HookHandle, Code, wparam, lparam);
          exit;
        end;
      end;

      KeyAction:= kaUnknown;
      keyFilterAction := faSendToHostApplication;

      if ctrlPressed or shiftPressed or menuPressed or shortCutPressed then begin
        if isHotKey then begin
          KeyAction:= kaHotKey
        end
        else begin
          if keyPressed <> VK_MENU then begin
            KeyAction:= kaShortCut;
          end;
        end;
        lockMessage:= ProcessCustomKey(wParam, lParam, menuPressed);
        if (not lockMessage) and (fFormHandle > 0) then begin
          fKeyEventArgs.Alt := menuPressed;
          fKeyEventArgs.Control := ctrlPressed;
          fKeyEventArgs.Shift := shiftPressed;
          fKeyEventArgs.KeyCode := keyPressed;
          fKeyEventArgs.State := csReleased;
          if AuditKey[keyPressed].Pressed then
            fKeyEventArgs.State := csPressed;
          fKeyEventArgs.KeyValue := lParam;
          keyFilterAction := GetKeyFilterAction(faSendToHostApplication);
        end;
      end;

      if not lockMessage then begin
        if FParent.fIsCustomizeForm then begin
          if keyPressed = VK_TAB then begin
            KeyAction:= kaTabKey
          end
          else begin
            KeyAction:= kaSelectedKey;
          end;
          lockMessage:= ProcessCustomKey(wParam, lParam, menuPressed);
        end
        else begin
          if keyPressed in [VK_BACK, VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN] then begin
            ProcessArrowAction(wParam, lParam);
          end
          else begin
            if (CopyPasteOperation)
               or (keyPressed in [VK_HOME, VK_END, VK_PRIOR, VK_NEXT, VK_SPACE, VK_ESCAPE, VK_DELETE]) then begin
              KeyAction:= kaSelectedKey
            end
            else begin
              if keyPressed = VK_TAB then
                KeyAction:= kaTabKey
              else
              if keyPressed = VK_RETURN then
                KeyAction:= kaPreProcess
              else
              if keyFilterAction = faSendToAdxForm then
                KeyAction:= kaSelectedKey;
            end;
            lockMessage:= ProcessCustomKey(wParam, lParam, menuPressed);
          end;
        end;
      end;
    end;

    if LockMessage then begin
      CallNextHookEx(HookHandle, Code, wparam, lparam);
      Result:= 1;
    end
    else Result:= CallNextHookEx(HookHandle, Code, wparam, lparam);

  except
    on e: Exception do begin
      Log.AddException(Format('TadxOLKeyBoardHook.CallbackFunction(wparam= %x, lparam= %x). %s', [wparam, lparam, e.Message]));
      raise E;
    end;
  end;
end;

{ TadxOLMessageHook }

procedure TadxOLMessageHook.AddWatchObjects(WatchObject: TWatchObject);
begin
  if (WatchObject = nil) then exit;
  FWatchObjects.Add(WatchObject);
end;

constructor TadxOLMessageHook.CreateEx(AParent: TadxOLHook);
begin
  Create;
  FEnableProcessWatchObjects := true;
  FParent:= AParent;
  FWatchObjects := TList.Create;
end;

destructor TadxOLMessageHook.Destroy;
var
  i: integer;
begin
  if (FWatchObjects <> nil) then begin
    if FWatchObjects.Count > 0 then begin
      for i := 0 to FWatchObjects.Count-1 do begin
        TInterfacedObject(FWatchObjects.Items[i]).Free;
      end;
    end;
    FWatchObjects.Free;
  end;
  inherited Destroy;
end;

function TadxOLMessageHook.GetEnableProcessWatchObjects: boolean;
begin
  result := FEnableProcessWatchObjects;
end;

procedure TadxOLMessageHook.InternalDeleteStoppedObjects;
var
  index: integer;
  watchObject: TWatchObject;
begin
  try
    index := 0;
    while (0 <= index) and (index < FWatchObjects.Count) do begin
      if (index >= FWatchObjects.Count) then begin
        break;
      end;
      watchObject := TWatchObject(FWatchObjects[index]);
      if (watchObject.StopWatch) then begin

        Log.AddMessage('TadxOLMessageHook.DeleteStoppedObjects - begin');
        Log.AddMessage(watchObject.ClassName + ' ' +  IntToStr(index));
        watchObject.Free;
        FWatchObjects.Delete(index);
        Log.AddMessage('TadxOLMessageHook.DeleteStoppedObjects - end');
      end
      else begin
        Inc(index);
      end;
    end;

  except
    on E:SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxOLMessageHook.InternalDeleteStoppedObjects: ' + E.Message), 'TadxOLMessageHook.InternalDeleteStoppedObjects');
    end;
  end;
end;

function TadxOLMessageHook.MessageHookProc(code: Integer; wParam, lParam: Cardinal): Longint;
var
  msg: TCWPStruct;
  tempHandle: HWND;
begin
  try
    if code = HC_ACTION then begin
      msg:= PCWPStruct(Pointer(lParam))^;

      DoMessage(msg);
      ProcessWatchObjects(msg);
      case msg.message of
        WM_SETFOCUS: begin
          FActiveFocus := msg.hwnd;
          if not IsAdxFormHandle(FActiveFocus, tempHandle) then
            FParent.ActiveFormHandle:= 0
          else begin
            FParent.ActiveFormHandle:= tempHandle;
            FParent.fIsCustomizeForm:= (FindChildWindow(GetParent(tempHandle), '', 'F3 Server', true) > 0);
          end;
        end;

        WM_KILLFOCUS: begin
          if not IsAdxFormHandle(msg.wParam, tempHandle) then
            FParent.ActiveFormHandle:= 0
          else
            FParent.ActiveFormHandle:= tempHandle;
        end;

        WM_WINDOWPOSCHANGING: begin
          if FParent.HostVersion = v2010 then
            FParent.UpdateOLExplorerParam(msg.hwnd, PWindowPos(msg.lParam)^);
        end;

        WM_SETREDRAW: begin
          if FParent.HostVersion = v2010 then begin
            if GetWindowClassName(msg.hwnd) = 'NUIScrollbar' then
              FParent.UpdateOLScrollBar(msg.hwnd);
          end;
        end;

        WM_IME_STARTCOMPOSITION: begin
          FParent.IsIMEComposition := true;
        end;

        WM_IME_ENDCOMPOSITION: begin
          FParent.IsIMEComposition := false;
        end;
      end;
    end;
    result:= CallNextHookEx(HookHandle, code, wParam, lParam);
  except
    on E: Exception do begin
      Log.AddException(Format('TadxOLMessageHook.CallbackFunction(code= %x, wParam= %x, lParam= %x). %s', [code, wParam, lParam, E.Message]));
      raise E;
    end;
  end;
end;

constructor TadxTheme.CreateEx(AThemeColor: TadxThemeColor);
begin
  fThemeColor:= AThemeColor;
  Create(nil);
end;

constructor TAdxTheme.Create;
begin
  inherited;
  visible:= false;
  FBlinkCursorEnable:= true;
  FThemeResourceBitmap:= nil;
  FDPIratio:= GetDPIratio;

  height:= 0;
  width:=  0;

  if not Assigned(FThemeColor) then
    FThemeColor:= GetAdxThemeColorClass.Create;

  if (Win32Platform  = VER_PLATFORM_WIN32_NT) and (((Win32MajorVersion = 5) and (Win32MinorVersion >= 1)) or (Win32MajorVersion > 5)) then
  begin
    hThemeLib := LoadLibrary(themelib);
    if hThemeLib <> 0 then begin
      ThemesAvailable     := GetProcAddress(hThemeLib, 'IsAppThemed');
      IsThemeActive       := GetProcAddress(hThemeLib, 'IsThemeActive');
      OpenThemeData       := GetProcAddress(hThemeLib, 'OpenThemeData');
      CloseThemeData      := GetProcAddress(hThemeLib, 'CloseThemeData');
      GetCurrentThemeName := GetProcAddress(hThemeLib, 'GetCurrentThemeName');

      FTheme:= OpenThemeData(FHostHandle, 'Window');
    end;
  end;

  MSO_Message:= TadxThemeChanged.CreateEx(self, v2007);
  MSO_Message.Handle;

  Caption:= '';

  FWndColor.BackGround:=    GPSystemColor(COLOR_3DHIGHLIGHT);
  FWndColor.Border:=        GPSystemColor(COLOR_WINDOWFRAME);

  FBtnColor.Border:=        GPSystemColor(COLOR_APPWORKSPACE);
  FBtnColor.FocusedBegin:=  GPSystemColor(COLOR_ACTIVEBORDER);
  FBtnColor.FocusedEnd:=    GPSystemColor(COLOR_APPWORKSPACE);
  FBtnColor.SelectedBegin:= GPSystemColor(COLOR_CAPTIONTEXT);
  FBtnColor.SelectedEnd:=   GPSystemColor(COLOR_CAPTIONTEXT);
  FBtnColor.PaneBegin:=     GPSystemColor(COLOR_APPWORKSPACE);
  FBtnColor.PaneEnd:=       GPSystemColor(COLOR_APPWORKSPACE);
end;

destructor TAdxTheme.Destroy;
var
  step: string;
begin
  Log.AddMessage(ClassName+'.Destroy: ');
  Log.AddIndent;
  try
    try
      if Assigned(MSO_Message) then begin
        step := 'MSO_Message.Free';
        FreeAndNil(MSO_Message);
      end;

      if Assigned(ThemesAvailable) and ThemesAvailable then begin
        step := 'CloseThemeData(FTheme)';
        CloseThemeData(FTheme);
        FTheme := 0;
      end;

      if (hThemeLib <> 0) then begin
        step := 'FreeLibrary(hThemeLib)';
        FreeLibrary(hThemeLib);
        hThemeLib := 0;
      end;

      if Assigned(FThemeColor) then begin
        step := 'FThemeColor.Free';
        FreeAndNil(FThemeColor);
      end;

      if Assigned(FThemeResourceBitmap) then begin
        step := 'FAdxThemeBitmap.Free';
        FreeAndNil(FThemeResourceBitmap);
      end;

      step := 'inherited Destroy';
      inherited Destroy;
    except
      on E: SysUtils.Exception do begin
        Log.AddException(ClassName+'.Destroy: ' + step + ' ' + E.Message);
        raise E;
      end;
    end;
  finally
    Log.RemoveIndent;
  end;
end;

procedure TadxTheme.DoThemeChanged;
begin
  Refresh;
  if Assigned(FOnThemeChanged) then
    FOnThemeChanged(self);
end;

function TadxTheme.GetThemeResourceBitmap: TadxGPBitmap;
begin
  if (FThemeResourceBitmap = nil) then begin
    FThemeResourceBitmap:= TadxGPBitmap.Create(HInstance, 'ADXTHEMEBITMAP');
  end;
  result:= FThemeResourceBitmap;
end;

procedure TAdxTheme.Initialize(AppVersion, ItemType: integer; AHostHandle: HWND);
begin
  try
    FAppVersion:= AppVersion;
    FHostHandle:= AHostHandle;
    FOfficeThemeAvailable:= (AppVersion = v2007) or (AppVersion = v2010);
    FItemType:= ItemType;
    //if (not Assigned(MSO_Message)) {and FOfficeThemeAvailable} then begin
      //MSO_Message:= TadxThemeChanged.CreateEx(self, AppVersion);
      //MSO_Message.Handle;
    //end;
    if Assigned(MSO_Message) then
      MSO_Message.FAppVersion:= AppVersion;
    Refresh;
  except
    on E: SysUtils.Exception do begin
      Log.AddException(format(ClassName+'.Initialize(%d, %d, %s)', [AppVersion, ItemType, E.Message]));
      raise E;
    end;
  end;
end;

procedure TadxTheme.InitThemeColor(index: TThemeColorIndex);
begin
  case index of
    tmUnknown: begin
      fWndColor.Border:=          GPSystemColor(COLOR_BTNFACE);
      fWndColor.Background:=      GPSystemColor(COLOR_BTNFACE);

      fBtnColor.Border:=          GPSystemColor(COLOR_WINDOWFRAME);
      fBtnColor.FocusedBegin:=    ThemeColor.clXPClassicBtnFocusedBegin;
      fBtnColor.FocusedEnd:=      ThemeColor.clXPStyleBtnFocusedEnd;
      fBtnColor.SelectedBegin:=   GPSystemColor(COLOR_ACTIVECAPTION);
      fBtnColor.SelectedEnd:=     GPSystemColor(COLOR_ACTIVECAPTION);
      fBtnColor.PaneBegin:=       GPSystemColor(COLOR_BTNFACE);
      fBtnColor.PaneEnd:=         GPSystemColor(COLOR_BTNFACE);

      fMenuColor.BackGround:=     GPSystemColor(COLOR_WINDOW);
      fMenuColor.ItemBackGround:= GPSystemColor(COLOR_WINDOW);

      FItemColor.BackGround:=     ThemeColor.clXPClassicItemBack;
      FItemColor.Selected:=       ThemeColor.clXPClassicItemSelected;
      FItemColor.Pressed:=        ThemeColor.clXPClassicItemPressed;
      FItemColor.Border:=         ThemeColor.clXPClassicItemFrame;
    end;

    tmClassic: begin
      fWndColor.Border:=          ThemeColor.clXPClassicWndFrame;
      fWndColor.Background:=      ThemeColor.clXPClassicWndBack;

      fBtnColor.Border:=          GPSystemColor(COLOR_WINDOWFRAME);
      fBtnColor.FocusedBegin:=    ThemeColor.clXPClassicBtnFocusedBegin;
      fBtnColor.FocusedEnd:=      ThemeColor.clXPClassicBtnFocusedEnd;
      fBtnColor.SelectedBegin:=   ThemeColor.clXPClassicBtnSelectBegin;
      fBtnColor.SelectedEnd:=     ThemeColor.clXPClassicBtnSelectEnd;
      fBtnColor.PaneBegin:=       ThemeColor.clXPClassicPaneBegin;
      fBtnColor.PaneEnd:=         ThemeColor.clXPClassicPaneEnd;

      FItemColor.BackGround:=     ThemeColor.clXPClassicItemBack;
      FItemColor.Selected:=       ThemeColor.clXPClassicItemSelected;
      FItemColor.Pressed:=        ThemeColor.clXPClassicItemPressed;
      FItemColor.Border:=         ThemeColor.clXPClassicItemFrame;
    end;

    tmLuna_Blue: begin
      fWndColor.Border:=          ThemeColor.clXPBlueWndFrame;
      fWndColor.Background:=      ThemeColor.clXPBlueWndBack;

      fBtnColor.Border:=          ThemeColor.clXPBlueBtnFrame;
      fBtnColor.FocusedBegin:=    ThemeColor.clXPStyleBtnFocusedBegin;
      fBtnColor.FocusedEnd:=      ThemeColor.clXPStyleBtnFocusedEnd;
      fBtnColor.SelectedBegin:=   ThemeColor.clXPBlueBtnSelectBegin;
      fBtnColor.SelectedEnd:=     ThemeColor.clXPBlueBtnSelectEnd;
      fBtnColor.PaneBegin:=       ThemeColor.clXPBluePaneBegin;
      fBtnColor.PaneEnd:=         ThemeColor.clXPBluePaneEnd;

      FItemColor.BackGround:=     ThemeColor.clXPBlueItemBack;
      FItemColor.Selected:=       ThemeColor.clXPBlueItemSelected;
      FItemColor.Pressed:=        ThemeColor.clXPBlueItemPressed;
      FItemColor.Border:=         ThemeColor.clXPBlueItemFrame;
    end;

    tmLuna_Olive: begin
      fWndColor.Border:=          ThemeColor.clXPHomeSteadWndFrame;
      fWndColor.Background:=      ThemeColor.clXPHomeSteadWndBack;

      fBtnColor.Border:=          ThemeColor.clXPHomeSteadBtnFrame;
      fBtnColor.FocusedBegin:=    ThemeColor.clXPStyleBtnFocusedBegin;
      fBtnColor.FocusedEnd:=      ThemeColor.clXPStyleBtnFocusedEnd;
      fBtnColor.SelectedBegin:=   ThemeColor.clXPHomeSteadBtnSelectBegin;
      fBtnColor.SelectedEnd:=     ThemeColor.clXPHomeSteadBtnSelectEnd;
      fBtnColor.PaneBegin:=       ThemeColor.clXPHomeSteadPaneBegin;
      fBtnColor.PaneEnd:=         ThemeColor.clXPHomeSteadPaneEnd;

      FItemColor.BackGround:=     ThemeColor.clXPHomeSteadItemBack;
      FItemColor.Selected:=       ThemeColor.clXPHomeSteadItemSelected;
      FItemColor.Pressed:=        ThemeColor.clXPHomeSteadItemPressed;
      FItemColor.Border:=         ThemeColor.clXPHomeSteadItemFrame;
    end;

    tmLuna_Silver: begin
      fWndColor.Border:=          ThemeColor.clXPMetallicWndFrame;
      fWndColor.Background:=      ThemeColor.clXPMetallicWndBack;

      fBtnColor.Border:=          ThemeColor.clXPMetallicBtnFrame;
      fBtnColor.FocusedBegin:=    ThemeColor.clXPStyleBtnFocusedBegin;
      fBtnColor.FocusedEnd:=      ThemeColor.clXPStyleBtnFocusedEnd;
      fBtnColor.SelectedBegin:=   ThemeColor.clXPMetallicBtnSelectBegin;
      fBtnColor.SelectedEnd:=     ThemeColor.clXPMetallicBtnSelectEnd;
      fBtnColor.PaneBegin:=       ThemeColor.clXPMetallicPaneBegin;
      fBtnColor.PaneEnd:=         ThemeColor.clXPMetallicPaneEnd;

      FItemColor.BackGround:=     ThemeColor.clXPMetallicItemBack;
      FItemColor.Selected:=       ThemeColor.clXPMetallicItemSelected;
      FItemColor.Pressed:=        ThemeColor.clXPMetallicItemPressed;
      FItemColor.Border :=        ThemeColor.clXPMetallicItemFrame;
    end;

    tmRoyale: begin
      fWndColor.Border:=          ThemeColor.clXPClassicWndFrame;
      fWndColor.Background:=      ThemeColor.clXPClassicWndBack;

      fBtnColor.Border:=          GPSystemColor(COLOR_WINDOWFRAME);
      fBtnColor.FocusedBegin:=    ThemeColor.clXPClassicBtnFocusedBegin;
      fBtnColor.FocusedEnd:=      ThemeColor.clXPClassicBtnFocusedEnd;
      fBtnColor.SelectedBegin:=   ThemeColor.clXPClassicBtnSelectBegin;
      fBtnColor.SelectedEnd:=     ThemeColor.clXPClassicBtnSelectEnd;
      fBtnColor.PaneBegin:=       ThemeColor.clXPRoyalePaneBegin;
      fBtnColor.PaneEnd:=         ThemeColor.clXPRoyalePaneEnd;

      FItemColor.BackGround:=     ThemeColor.clXPClassicItemBack;
      FItemColor.Selected:=       ThemeColor.clXPClassicItemSelected;
      FItemColor.Pressed:=        ThemeColor.clXPClassicItemPressed;
      FItemColor.Border:=         fWndColor.Border;
    end;

    tmOffice2007_Blue: begin
      fBtnColor.FocusedBegin:=    ThemeColor.cl2007StyleBtnFocusedBegin;
      fBtnColor.FocusedEnd:=      ThemeColor.cl2007StyleBtnFocusedEnd;
      fBtnColor.SelectedBegin:=   ThemeColor.cl2007StyleBtnSelectedBegin;
      fBtnColor.SelectedEnd:=     ThemeColor.cl2007StyleBtnSelectedEnd;

      fWndColor.Border:=          ThemeColor.cl2007BlueWndFrame;
      fWndColor.Background:=      ThemeColor.cl2007BlueWndBackBegin;
      fWndColor.Shadow:=          ThemeColor.cl2007BlueWndBackEnd;

      fBtnColor.PaneBegin:=       ThemeColor.cl2007BluePaneBegin;
      fBtnColor.PaneEnd:=         ThemeColor.cl2007BluePaneEnd;
      fBtnColor.Border:=          ThemeColor.cl2007StyleBtnFrameSelected;

      FItemColor.BackGround:=     ThemeColor.cl2007BlueItemBack;
      FItemColor.Selected:=       ThemeColor.cl2007BlueItemSelected;
      FItemColor.Pressed:=        ThemeColor.cl2007BlueItemPressed;
      FItemColor.Border:=         fWndColor.Border;
    end;

    tmOffice2007_Silver: begin
      fBtnColor.FocusedBegin:=    ThemeColor.cl2007StyleBtnFocusedBegin;
      fBtnColor.FocusedEnd:=      ThemeColor.cl2007StyleBtnFocusedEnd;
      fBtnColor.SelectedBegin:=   ThemeColor.cl2007StyleBtnSelectedBegin;
      fBtnColor.SelectedEnd:=     ThemeColor.cl2007StyleBtnSelectedEnd;

      fWndColor.Border:=          ThemeColor.cl2007SilverWndFrame;
      fWndColor.Background:=      ThemeColor.cl2007SilverWndBackBegin;
      fWndColor.Shadow:=          ThemeColor.cl2007SilverWndBackEnd;

      fBtnColor.PaneBegin:=       ThemeColor.cl2007SilverPaneBegin;
      fBtnColor.PaneEnd:=         ThemeColor.cl2007SilverPaneEnd;
      fBtnColor.Border:=          ThemeColor.cl2007StyleBtnFrameSelected;

      FItemColor.BackGround:=     ThemeColor.cl2007SilverItemBack;
      FItemColor.Selected:=       ThemeColor.cl2007SilverItemSelected;
      FItemColor.Pressed:=        ThemeColor.cl2007SilverItemPressed;
      FItemColor.Border:=         fWndColor.Border;
    end;

    tmOffice2007_Black: begin
      fBtnColor.FocusedBegin:=    ThemeColor.cl2007StyleBtnFocusedBegin;
      fBtnColor.FocusedEnd:=      ThemeColor.cl2007StyleBtnFocusedEnd;
      fBtnColor.SelectedBegin:=   ThemeColor.cl2007StyleBtnSelectedBegin;
      fBtnColor.SelectedEnd:=     ThemeColor.cl2007StyleBtnSelectedEnd;

      fWndColor.Border:=          ThemeColor.cl2007BlackWndFrame;
      fWndColor.Background:=      ThemeColor.cl2007BlackWndBackBegin;
      fWndColor.Shadow:=          ThemeColor.cl2007BlackWndBackEnd;

      fBtnColor.PaneBegin:=       ThemeColor.cl2007BlackPaneBegin;
      fBtnColor.PaneEnd:=         ThemeColor.cl2007BlackPaneEnd;
      fBtnColor.Border:=          ThemeColor.cl2007StyleBtnFrameSelected;

      FItemColor.BackGround:=     ThemeColor.cl2007BlackItemBack;
      FItemColor.Selected:=       ThemeColor.cl2007BlackItemSelected;
      FItemColor.Pressed:=        ThemeColor.cl2007BlackItemPressed;
      FItemColor.Border:=         fWndColor.Border;
    end;

    tmOffice2010_Blue: begin
      fBtnColor.FocusedBegin:=    ThemeColor.cl2007StyleBtnFocusedBegin;
      fBtnColor.FocusedEnd:=      ThemeColor.cl2007StyleBtnFocusedEnd;
      fBtnColor.SelectedBegin:=   ThemeColor.cl2007StyleBtnSelectedBegin;
      fBtnColor.SelectedEnd:=     ThemeColor.cl2007StyleBtnSelectedEnd;

      fWndColor.Border:=          ThemeColor.cl2010BlueWndFrame;
      fWndColor.Background:=      ThemeColor.cl2010BlueWndBackBegin;
      fWndColor.Shadow:=          ThemeColor.cl2010BlueWndBackEnd;

      fBtnColor.PaneBegin:=       ThemeColor.cl2010BluePaneBegin;
      fBtnColor.PaneEnd:=         ThemeColor.cl2010BluePaneEnd;
      fBtnColor.Border:=          ThemeColor.cl2007StyleBtnFrameSelected;

      FItemColor.BackGround:=     ThemeColor.cl2010BlueItemBack;
      FItemColor.Selected:=       ThemeColor.cl2010BlueItemSelected;
      FItemColor.Pressed:=        ThemeColor.cl2010BlueItemPressed;
      FItemColor.Border:=         fWndColor.Border;
    end;

    tmOffice2010_Silver: begin
      fBtnColor.FocusedBegin:=    ThemeColor.cl2007StyleBtnFocusedBegin;
      fBtnColor.FocusedEnd:=      ThemeColor.cl2007StyleBtnFocusedEnd;
      fBtnColor.SelectedBegin:=   ThemeColor.cl2007StyleBtnSelectedBegin;
      fBtnColor.SelectedEnd:=     ThemeColor.cl2007StyleBtnSelectedEnd;

      fWndColor.Border:=          ThemeColor.cl2010SilverWndFrame;
      fWndColor.Background:=      ThemeColor.cl2010SilverWndBackBegin;
      fWndColor.Shadow:=          ThemeColor.cl2010SilverWndBackEnd;

      fBtnColor.PaneBegin:=       ThemeColor.cl2010BluePaneBegin;
      fBtnColor.PaneEnd:=         ThemeColor.cl2010BluePaneEnd;
      fBtnColor.Border:=          ThemeColor.cl2007StyleBtnFrameSelected;

      FItemColor.BackGround:=     ThemeColor.cl2010BlueItemBack;
      FItemColor.Selected:=       ThemeColor.cl2010BlueItemSelected;
      FItemColor.Pressed:=        ThemeColor.cl2010BlueItemPressed;
      FItemColor.Border:=         fWndColor.Border;
    end;

    tmOffice2010_Black: begin
      fBtnColor.FocusedBegin:=    ThemeColor.cl2010BlackPaneBegin;
      fBtnColor.FocusedEnd:=      ThemeColor.cl2010BlackPaneEnd;
      fBtnColor.SelectedBegin:=   ThemeColor.cl2007StyleBtnSelectedBegin;
      fBtnColor.SelectedEnd:=     ThemeColor.cl2007StyleBtnSelectedEnd;

      fWndColor.Border:=          ThemeColor.cl2010BlackWndFrame;
      fWndColor.Background:=      ThemeColor.cl2010BlackWndBackBegin;
      fWndColor.Shadow:=          ThemeColor.cl2010BlackWndBackEnd;

      fBtnColor.PaneBegin:=       ThemeColor.cl2010BlackPaneBegin;
      fBtnColor.PaneEnd:=         ThemeColor.cl2010BlackPaneEnd;
      fBtnColor.Border:=          ThemeColor.cl2010BlackBtnBorder;

      FItemColor.BackGround:=     ThemeColor.cl2010BlackItemBack;
      FItemColor.Selected:=       ThemeColor.cl2010BlackItemSelected;
      FItemColor.Pressed:=        ThemeColor.cl2010BlackItemPressed;
      FItemColor.Border:=         ThemeColor.cl2010BlackItemBorder;
    end;

    tmAero: begin
      fWndColor.Border:=          ThemeColor.clVistaWndFrameAero;
      fWndColor.Background:=      ThemeColor.clVistaWndBackAero;
      fBtnColor.Border:=          ThemeColor.clVistaBtnFrameAero;
      fBtnColor.BorderShadow:=    ThemeColor.clVistaBtnFrameShadowAero;
    end;
  end;

  fMenuColor.BackGround:=     GPSystemColor(COLOR_WINDOW);
  fMenuColor.ItemBackGround:= GPSystemColor(COLOR_WINDOW);
  fMenuColor.ItemBorder:=     DarkerColor(fBtnColor.Border, 10);
  fMenuColor.ItemSelected:=   LighterColor(fBtnColor.FocusedEnd, 20);
  fMenuColor.ItemIconArea:=   fBtnColor.PaneBegin; //DarkerColor(fBtnColor.PaneBegin, 5);
end;

procedure TadxTheme.SetBlinkCursorEnable(const Value: boolean);
begin
  if FBlinkCursorEnable <> Value then begin
    if Value then begin
      SetCaretBlinkTime(FBlinkCursorTime);
    end
    else begin
      FBlinkCursorTime:= GetCaretBlinkTime;
      SetCaretBlinkTime(MAXWORD);
    end;
    FBlinkCursorEnable := Value;
  end;
end;

procedure TadxTheme.SetThemeColorIndex(const Value: TThemeColorIndex);
begin
  if Value <> FThemeColorIndex then begin
    FThemeColorIndex := Value;
    InitThemeColor(FThemeColorIndex);
  end;
end;

procedure TadxTheme.Refresh;
var
  ThemeName: string;
  i, p: word;
//  sysFont: HFONT;
  themeFileName, colorBuf, sizeBuf: TWideCharBuffer;
begin
//  sysFont:= GetSystemFontHandle(MenuFont, FW_BOLD);
//  if sysFont > 0 then begin
//    if (Canvas.Font.Handle <> sysFont) and (sysFont > 0) then
//      Canvas.Font.Handle := sysFont;
//    if Abs(Canvas.Font.Height) < 11 then
//      Canvas.Font.Height:= -11;
//  end;

  Font.Style := [fsBold];
  if Abs(Font.Height) < 11 then
    Canvas.Font.Height:= -11;

  ThemeColorIndex:= tmUnknown;
  if FOfficeThemeAvailable then begin
    if MSO_Message <> nil then
      ThemeColorIndex:= MSO_Message.ThemeIndex;
  end
  else begin
    ThemeColorIndex:= tmClassic;
    if Assigned(ThemesAvailable) and ThemesAvailable then begin
      try
        GetCurrentThemeName(@themeFileName, CHAR_BUFFER_COUNT, @colorBuf, CHAR_BUFFER_COUNT, @sizeBuf, CHAR_BUFFER_COUNT);
        FThemeFileName:= string(themeFileName);
        FColorBuf:= string(colorBuf);
        FSizeBuf:= string(sizeBuf);

        ThemeName:= ''; p:= length(FThemeFileName);
        if length(FThemeFileName) <= 0 then begin
          Log.AddWarning(ClassName+'.Refresh: FThemeFileName is NULL');
          GetCurrentThemeName(@themeFileName, CHAR_BUFFER_COUNT, @colorBuf, CHAR_BUFFER_COUNT, @sizeBuf, CHAR_BUFFER_COUNT);
          FThemeFileName:= string(themeFileName);
          FColorBuf:= string(colorBuf);
          FSizeBuf:= string(sizeBuf);
        end;
        for i:= length(FThemeFileName) downto 1 do begin
          if FThemeFileName[i] = '.' then p:= i;
          if FThemeFileName[i] = '\' then begin
            ThemeName:= copy(FThemeFileName, i+1, p-i-1);
            break;
          end;
        end;
      except
        on e: Exception do begin
          Log.AddException(ClassName+'.Refresh - GetCurrentThemeName exception: '+e.Message);
          raise e;
        end;
      end;

      FThemeActive := IsThemeActive;
      ThemeName := UpperCase(ThemeName);

      if FThemeActive then begin
        if ThemeName = 'ROYALE' then
          ThemeColorIndex:= tmRoyale
        else
        if ThemeName = 'LUNA' then begin
          if UpperCase(FColorBuf) = 'NORMALCOLOR' then
            ThemeColorIndex:= tmLuna_Blue
          else
          if UpperCase(FColorBuf) = 'HOMESTEAD' then
            ThemeColorIndex:= tmLuna_Olive
          else
          if UpperCase(FColorBuf) = 'METALLIC' then
            ThemeColorIndex:= tmLuna_Silver;
        end
        else begin
          if ThemeName = 'AERO' then
            ThemeColorIndex:= tmAero;
        end;
      end;
    end;
  end;
end;

procedure TadxTheme.DrawFrame3D(ACanvas: TadxGPGraphics; Rect: TRect; Depth: integer; const B3DStyle, B3DSide: Cardinal);
var
  i: integer;
  R: TRect;
  pen: TadxGPPen;
  cl1, cl2: TGPColor;
begin
  if Depth <= 0 then exit;
  for i:= 0 to Depth-1 do begin
    R:= Rect;
    InflateRect(R, -i, -i);

    cl1:= GPSystemColor(COLOR_3DSHADOW); cl2:= cl1;
    case ($FF and B3DStyle) of
      BDR_RAISEDINNER: begin
        cl1:= GPSystemColor(COLOR_3DHIGHLIGHT);
        cl2:= GPSystemColor(COLOR_3DSHADOW);
      end;
      BDR_SUNKENOUTER: begin
        cl1:= GPSystemColor(COLOR_3DSHADOW);
        cl2:= GPSystemColor(COLOR_3DHIGHLIGHT);
      end;
    end;

    pen:= TadxGPPen.Create(cl1);
    try
      if B3DSide and BF_LEFT > 0 then
        ACanvas.DrawLine(pen, R.Left, R.Bottom, R.Left, R.Top);
      if B3DSide and BF_TOP > 0 then
        ACanvas.DrawLine(pen, R.Left, R.Top, R.Right, R.Top);
      pen.SetColor(cl2);
      if B3DSide and BF_RIGHT > 0 then
        ACanvas.DrawLine(pen, R.Right, R.Top, R.Right, R.Bottom);
      if B3DSide and BF_BOTTOM > 0 then
        ACanvas.DrawLine(pen, R.Left, R.Bottom, R.Right, R.Bottom);
    finally
      pen.Free;
    end;
  end;
end;

procedure TadxTheme.DrawFrameAPI(Handle: HWND; mode: TDrawMode; const B3DSide: Cardinal);
var
  R: TRect;
begin
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  DrawFrameAPI(Handle, GetWindowDC(handle), R, mode, BDR_SUNKENOUTER, B3DSide);
end;

procedure TadxTheme.DrawFrame(ACanvas: TadxGPGraphics; Rect: TRect; Depth: integer; FrameColor: TGPColor);
var
  i: integer;
  R: TRect;
  pen: TadxGPPen;
begin
  pen:= TadxGPPen.Create(FrameColor);
  try
    for i:= 0 to Depth-1 do begin
      R:= Rect;
      InflateRect(R, -i, -i);
      ACanvas.DrawRectangle(pen, MakeRect(R));
    end;
  finally
    pen.Free;
  end;
end;

procedure TadxTheme.DrawFrameAPI(Handle: HWND; DC: HDC; Rect: TRect; mode: TDrawMode; const B3DStyle, B3DSide: Cardinal);
var Pen, OldPen: HPen;
    OldBrush: HBrush;
    OldPoint: TPoint;
    frameColor: Cardinal;
begin
  frameColor:= ARGBToColorRef(FWndColor.Border);
  if mode = drwThemed then
    Pen := CreatePen(PS_SOLID, 1, frameColor)
  else
    Pen := CreatePen(PS_SOLID, 1, GPSystemColor(COLOR_BTNFACE));

  OldPen := SelectObject(DC, Pen);
  OldBrush := SelectObject(DC, GetStockObject(NULL_BRUSH));
  case mode of
    drwSimple: DrawEdge(DC, Rect, B3DStyle, B3DSide);
    drwThemed: begin
      if B3DSide = $0F then
        Rectangle(DC, Rect.Left, Rect.Top, Rect.Right, Rect.Bottom)
      else begin
        if B3DSide and BF_LEFT > 0 then begin
          MoveToEx(DC, Rect.Left, Rect.Top, @OldPoint);
          LineTo(DC, Rect.Left, Rect.Bottom);
        end;
        if B3DSide and BF_TOP > 0 then begin
          MoveToEx(DC, Rect.Left, Rect.Top, @OldPoint);
          LineTo(DC, Rect.Right, Rect.Top);
        end;
        if B3DSide and BF_RIGHT > 0 then begin
          MoveToEx(DC, Rect.Right-1, Rect.Top, @OldPoint);
          LineTo(DC, Rect.Right-1, Rect.Bottom);
        end;
        if B3DSide and BF_BOTTOM > 0 then begin
          MoveToEx(DC, Rect.Left, Rect.Bottom-1, @OldPoint);
          LineTo(DC, Rect.Right, Rect.Bottom-1);
        end;
      end;
    end;
  end;
  SelectObject(DC, OldBrush);
  SelectObject(DC, OldPen);
  DeleteObject(Pen);
  ReleaseDC(Handle, DC);
end;

procedure TadxTheme.DrawDots(ACanvas: TadxGPGraphics; ARect: TRect;
  const Vertical: boolean = true; const Pressed: boolean = false);
const
  space: integer = 6;
var
  countDots, vOffset, hOffset: integer;
  i, X, Y: integer;
  aclDark, aclWindow, aclBtnFace: TGPColor;
  dots: TadxGPBitmap;
begin
  aclDark:=    MakeColor($5F, $5F, $5F);
  aclWindow:=  GPSystemColor(COLOR_WINDOW);
  aclBtnFace:= GPSystemColor(COLOR_BTNFACE);

  if Vertical then begin
    countDots:= round((ARect.Bottom- ARect.Top- space)/ 4);
    if countDots > 5 then countDots:= 5;
    vOffset:= round((ARect.Bottom- ARect.Top- countDots* 4) / 2);
    hOffset:= round((ARect.Right- ARect.left- 3)/ 2);
  end
  else begin
    countDots:= round((ARect.Right- ARect.left- space)/ 4);
    if countDots > 5 then countDots:= 5;
    hOffset:= round((ARect.Right- ARect.left- countDots* 4) / 2);
    vOffset:= round((ARect.Bottom- ARect.Top- 3)/ 2);
  end;

  dots:= TadxGPBitmap.Create(GetRectWidth(ARect), GetRectHeight(ARect));
  try
    for i:= 0 to countDots-1 do begin
      if Vertical then begin
        X:= hOffset;
        Y:= vOffset + i*4;
      end
      else begin
        Y:= vOffset;
        X:= hOffset + i*4;
      end;

      if Pressed then begin
        if Vertical then inc(X)
        else inc(Y);

        dots.SetPixel(X,   Y,   aclDark);
        dots.SetPixel(X+1, Y,   aclDark);
        dots.SetPixel(X,   Y+1, aclDark);
        dots.SetPixel(X+1, Y+1, aclDark);
      end
      else begin
        dots.SetPixel(X,   Y,   aclWindow);
        dots.SetPixel(X+1, Y,   aclWindow);
        dots.SetPixel(X,   Y+1, aclWindow);
        dots.SetPixel(X+1, Y+1, aclBtnFace);

        dots.SetPixel(X+2, Y+1, aclDark);
        dots.SetPixel(X+1, Y+2, aclDark);
        dots.SetPixel(X+2, Y+2, aclDark);
      end;
    end;

    ACanvas.DrawImage(dots, MakeRect(ARect));
  finally
    dots.Free;
  end;
end;

procedure TAdxTheme.WndProc(var message: TMessage);
begin
  if Message.Msg = WM_THEMECHANGED then
    DoThemeChanged;  
  inherited;
end;

function TadxTheme.GetAdxThemeColorClass: TadxThemeColorClass;
begin
  result:= TadxThemeColor;
end;

function TadxTheme.GetDPIratio: single;
begin
  result:= 1;
  if Assigned(Screen) then begin
    if Screen.PixelsPerInch = 96 then exit;

    result:= Screen.PixelsPerInch / 96;
    if result < 1 then
      result:= 1;
  end;
end;

procedure TadxOLMessageHook.ProcessWatchObjects(msg: TCWPStruct);
var
  index: integer;
  watchObject: TWatchObject;
begin
  if not EnableProcessWatchObjects then exit;
  
  if (msg.message = WM_SETREDRAW) then begin
    index := 0;
    while (0 <= index) and (index < FWatchObjects.Count) do begin
      if (index >= FWatchObjects.Count) then begin
        break;
      end;
      watchObject := TWatchObject(FWatchObjects[index]);
      if (msg.wParam = 0) then begin
        watchObject.START_WM_SETREDRAW(msg.hwnd);
      end
      else begin
        watchObject.END_WM_SETREDRAW(msg.hwnd);
      end;
      Inc(index);
    end;
  end;


  if (msg.message = WM_SETREDRAW) and (msg.wParam = 0) then begin
    exit; //Case 830
  end;

  case msg.message of
    WM_DESTROY,
    WM_NCDESTROY,
    WM_CLOSE,
    WM_SHOWWINDOW,
    WM_WINDOWPOSCHANGED,
    WM_SETREDRAW:
    try
      index := 0;
      while (0 <= index) and (index < FWatchObjects.Count) do begin
        if (index >= FWatchObjects.Count) then begin
          break;
        end;
        watchObject := TWatchObject(FWatchObjects[index]);

        if (watchObject.WindowHandle = msg.hwnd) or (watchObject.WindowHandle = 0) then begin
          watchObject.ProcessHookEvent(msg.hwnd, msg.message, msg.wParam, msg.lParam);
        end;
        Inc(index);
      end;

      InternalDeleteStoppedObjects;
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxOLMessageHook.ProcessWatchObjects: ' + E.Message), 'TadxOLMessageHook.ProcessWatchObjects');
      end;
    end;
  end;
end;

procedure TadxOLMessageHook.SetEnableProcessWatchObjects(const Value: boolean);
begin
  FEnableProcessWatchObjects := Value;
end;

{ TadxContainerPane }

procedure TadxContainerPane.CanvasChanged;
begin
  FCanvasChanged:= true;
end;

procedure TadxContainerPane.CMCursorChanged(var Message: TMessage);
var
  P: TPoint;
begin
  GetCursorPos(P);
  Perform(WM_SETCURSOR, WPARAM(Handle), HTCLIENT);
end;

function TadxContainerPane.ConnectController: boolean;
begin
  Result:= false;
  {$IFDEF SupportAdjacentWindow}
  if Assigned(FAdxControl) and (FAdxControl.IsSupportAdjacentWindow) then
    if Assigned(FAppController) then
      Result:= FAppController.Connect;
  {$ENDIF}
end;

procedure TadxContainerPane.ContainerRefresh(rfKind: TadxRefreshKind; SendRequest: boolean; FormHandle: HWnd);
begin
  if SendRequest and Assigned(FAppwindow) then
    PostMessage(FAppWindow.Handle, WM_ADXCONTAINERREFRESH, FormLayout or rfKind, FormHandle)
  else begin
    case rfKind of
      rfCaption, rfPicture: begin
        if Assigned(FContainer) then
          FContainer.Refresh(rfKind, FormHandle);
        if Assigned(FMainParts) then begin
          FMainParts.Bounds:= FMainParts.FBounds;
          CanvasChanged;
          Paint;
        end;
      end;
      rfLighReset : ResetHighlight(FormHandle);
    end;
  end;
end;

procedure TadxContainerPane.DisconnectController;
begin
  {$IFDEF SupportAdjacentWindow}
  if Assigned(FAdxControl) and (FAdxControl.IsSupportAdjacentWindow) then
    if Assigned(FAppController) then
      FAppController.Disconnect;
  {$ENDIF}
end;

procedure TadxContainerPane.SwapController(swapHandle: HWND; oper: integer; param: Pointer);
begin
  {$IFDEF SupportAdjacentWindow}
  if Assigned(FAdxControl) and (FAdxControl.IsSupportAdjacentWindow) then
    if Assigned(FAppController) then
      FAppController.SwapController(swapHandle, oper, PAppWindowControllerParam(param));
  {$ENDIF}
end;

function TadxContainerPane.GetMouseCursorPos: TPoint;
var R:  TRect;
begin
  GetCursorPos(result);
  GetWindowRect(Handle, R);
  dec(result.X, R.Left);
  dec(result.Y, R.Top);
end;

procedure TadxContainerPane.WMMouseLeave(var Msg: TMessage);
begin
  FIsMouseTracking:= False;
  BeginUpdate;
  SelectedPart:= nil;
  EndUpdate;
  Inherited;
end;

procedure TadxContainerPane.WMMouseMove(var Message: TWMMouseMove);
var
  eventTrack: TTrackMouseEvent;
begin
  inherited;
  if not FIsMouseTracking then begin
    FIsMouseTracking:= True;
    eventTrack.cbSize:= SizeOf(eventTrack);
    eventTrack.dwFlags:= TME_LEAVE;
    eventTrack.hwndTrack:= Handle;
    eventTrack.dwHoverTime:= 0;
    TrackMouseEvent(eventTrack);
  end;
  if (Message.Keys and MK_LBUTTON) > 0 then begin
    if Assigned(FSplitterRuler) then
      FSplitterRuler.DoMouseMove(Message.Keys, Point(Message.XPos, Message.YPos));
    if FDelayBeforeDrag > MaxDelayBeforeDrag then begin
      BlinkCursorEnable:= false;
      DoActionDraggingForm(Point(Message.XPos, Message.YPos));
    end
    else inc(FDelayBeforeDrag);
  end
  else
    BlinkCursorEnable:= true;
end;

procedure TadxContainerPane.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result:= 1;
end;

procedure TadxContainerPane.WMSetCursor(var Message: TWMSetCursor);
var
  part: TadxPanePart;
  mousePos: TPoint;
begin
  inherited;
  BeginUpdate;
  mousePos:= GetMouseCursorPos;
  part:= FMainParts.FindPart(mousePos);
  SelectedPart:= part;
  if Assigned(part) then
    part.DoMouseHover(self, Message.MouseMsg, mousePos);
  EndUpdate;
end;

procedure TadxContainerPane.WMWindowPosChanging(var Msg: TWMWindowPosChanging);
begin
  if (Msg.WindowPos.cx > 0) and (Msg.WindowPos.cy > 0) then begin
    RecreateParts(Msg.WindowPos.cx, Msg.WindowPos.cy);
  end;
  inherited;
end;

procedure TadxContainerPane.WMLButtonUp(var Message: TWMLButtonUp);
var
  part: TadxPanePart;
  mousePos: TPoint;
begin
  inherited;
  BeginUpdate;
  mousePos:= GetMouseCursorPos;
  part:= FMainParts.FindPart(mousePos);
  SelectedPart:= part;
  if Assigned(part) then begin
    part.DoMouseUp(part, 0, Point(Message.XPos, Message.YPos));
  end;
  EndUpdate;
  if Assigned(FSplitterRuler) then begin
    FSplitterRuler.DoMouseUp(0, mousePos);
    FreeAndNil(FSplitterRuler);
  end;
  FDelayBeforeDrag := 0;
  DoActionStopDragging();
end;

procedure TadxContainerPane.WMLButtonDown(var Message: TWMLButtonDown);
var
  part: TadxPanePart;
  mousePos: TPoint;
begin
  inherited;
  BeginUpdate;
  mousePos:= GetMouseCursorPos;
  part:= FMainParts.FindPart(mousePos);
  SelectedPart:= part;
  if Assigned(part) then
    part.DoMouseDown(part, Message.Keys, mousePos);
  EndUpdate;
  if Assigned(FSplitterRuler) then
    FSplitterRuler.DoMouseDown(0, mousePos);

  fDragMousePos := Point(Message.XPos, Message.YPos);
end;

procedure TadxContainerPane.WMLButtonDblClk(var Message: TWMLButtonDblClk);
var
  part: TadxPanePart;
begin
  inherited;
  BeginUpdate;
  part:= FMainParts.FindPart(GetMouseCursorPos);
  SelectedPart:= part;
  if Assigned(part) then begin
    part.State:= isPressed;
    part.DoMouseDblClick(part, 0, Point(Message.XPos, Message.YPos));
  end;
  EndUpdate;
end;

procedure TadxContainerPane.SetHeaderHeight(AValue: Integer);
begin
  if AValue < 15 Then AValue:= 15;
  if FHeaderHeight <> AValue then begin
    FHeaderHeight:= AValue;
  end;
end;

procedure TadxContainerPane.SetHighlighted(const Value: boolean);
begin
  if FHighlighted <> Value then begin
    FHighlighted := Value;
    CanvasChanged;
    if IsWindowVisible(Handle) then
      PaintTo(GetWindowDC(Handle), 0, 0);
  end;
end;

procedure TadxContainerPane.SetPreset(AValue: TAdxTaskPanePreset);
begin
  if FPreset <> Avalue then begin
    FPreset:= Avalue;
    case FPreset of
      tpsDefault: HeaderHeight:= HeaderHeight2000;
      tpsXP:      HeaderHeight:= HeaderHeightXP;
    end;
  end;
end;

procedure TadxContainerPane.SetSelectedPart(const Value: TadxPanePart);
begin
  if FSelectedPart <> Value then begin
    if Assigned(FSelectedPart) then begin
      FSelectedPart.State:= isUp;
    end;
    FSelectedPart := Value;
  end;
end;

procedure TadxContainerPane.SetSplitterMove(X, Y: integer);
begin
  FSplitterMove.X:= X;
  FSplitterMove.Y:= Y;
end;

procedure TadxContainerPane.SetStartIndex(const Value: integer);
var
  fItems: TList;
begin
  fItems:= PaneItems;
  if Assigned(fItems) then begin
    if (Value < 0) then exit;
    if (Value > fItems.Count-1) then exit;
    FStartIndex := Value;
    if Assigned(FMainParts) then begin
      FMainParts.Bounds:= FMainParts.FBounds;
      Paint;
    end;
  end;
end;

procedure TadxContainerPane.SetOptions(AValue: TAdxTaskPaneOptions);
begin
  if FOptions <> AValue then begin
   FOptions:= AValue;
  end;
end;

function TadxContainerPane.ScaledButtonHeight: integer;
begin
  result:= DefaultTaskButtonHeight;
end;

procedure TadxContainerPane.SetTaskCaption(Avalue: TCaption);
begin
  if AValue <> FTaskCaption then begin
    FTaskCaption:= AValue;
    CanvasChanged;
    PostMessage(Handle, WM_PAINT, 0, 0);
  end;
end;

procedure TadxContainerPane.SetUserHeight(const Value: integer);
var
  splitSize: integer;
begin
  if Assigned(FAdxControl) then begin
    splitSize := 0;
    if not FAdxControl.IsDockLayout then
      splitSize := SplitterDepth.Normal;
    if not FAdxControl.EnableSize then
      FAdxControl.UserHeight:= Value- splitSize;
  end;
end;

procedure TadxContainerPane.SetUserWidth(const Value: integer);
var
  splitSize: integer;
begin
  if Assigned(FAdxControl) then begin
    splitSize:= 0;
    if not FAdxControl.IsDockLayout then
      splitSize:= SplitterDepth.Normal;

    if not FAdxControl.EnableSize then
      FAdxControl.UserWidth:= Value- splitSize;
  end;
end;

function TadxContainerPane.GetPaneOffset: TRect;
begin
  result:= Rect(0, 0, 0, 0)
end;

function TadxContainerPane.GetSplitMotion: TadxSplitMotion;
begin
  Result:= smTraverse;
end;

function TadxContainerPane.GetSplitterDepth: TadxSplitterDepth;
begin
  result.Normal:= DefaultSplitterSize;
  result.Collapsed:= CollapsedSplitterSize;
end;

function TadxContainerPane.GetHeaderHeight: Integer;
begin
  result:= round(FHeaderHeight* DPIratio);
  if result < HeaderHeightMin then
    result:= HeaderHeightMin;
end;

function TadxContainerPane.GetHeaderHeightMin: Integer;
begin
  result:= 0;
  if (Preset = tpsDefault) and IsMinimizedState then
    result:= round(HeaderHeight2000Minimize* DPIratio);
end;

function TadxContainerPane.GetItemTextSize(Index: integer): TSize;
var
  text: string;
  pFormItem: PadxContainerForm;
  textFont: TadxGPFont;
  gpGraphics: TadxGPGraphics;
begin
  pFormItem:= GetPaneItem(Index);
  textFont:= TadxGPFont.Create(Canvas.Handle);
  gpGraphics:= TadxGPGraphics.Create(Canvas.Handle);
  if Assigned(pFormItem) then begin
    text:= string(pFormItem^.param^.Caption);
    GPTextExtent(text, gpGraphics, textFont, result);
  end
  else
    GPTextExtent(TaskCaption, gpGraphics, textFont, result);
  textFont.Free;
  gpGraphics.Free;
end;

function TadxContainerPane.GetTaskButtonHeight: integer;
begin
  result:= round(DefaultTaskButtonHeight* DPIratio);
end;

function TadxContainerPane.GetTaskButtonWidth: integer;
begin
  result:= round(DefaultTaskButtonWidth* DPIratio);
end;

function TadxContainerPane.GetTaskIconHeight: integer;
begin
  result:= round(DefaultIconHeight* DPIratio);
end;

function TadxContainerPane.GetTaskIconWidth: integer;
begin
  result:= round(DefaultIconWidth* DPIratio);
end;

function TadxContainerPane.GetTaskMenuItemHeight: integer;
begin
  if Round(DPIratio* 100) <> 100 then
    result:= round(DefaultMenuItemHeight* DPIratio* 0.92)
  else
    result:= DefaultMenuItemHeight;
end;

function TadxContainerPane.GetUserHeight: integer;
begin
  Result:= 0;
  if Assigned(FAdxControl) then begin
    Result:= FAdxControl.UserHeight+ SplitterDepth.Normal;
    //if IsHeaderVisible {and (RegionBorderSize = 0)} then
    //  inc(Result);
  end;
end;

procedure TadxContainerPane.GetUserSize(var ASize: integer);
begin
  case FormLayout of
    wlLeft, wlRight, wlDockLeft, wlDockRight: ASize:= UserWidth;
    wlTop, wlBottom, wlDockTop, wlDockBottom: ASize:= UserHeight;
    wlClient: ASize:= 0;
  end;
end;

procedure TadxContainerPane.GetRequiredSize(var ASize: TSize; RecalcArea: boolean);
var
  SplitSize, HeaderSize: integer;
  pOffset: TRect;
begin
    pOffset:= PaneOffset;

    SplitSize := SplitterDepth.Normal;
    if FAdxControl.FormRegion.State = irsHidden then
      SplitSize:= SplitterDepth.Collapsed;

    HeaderSize:= 0;
    if IsHeaderVisible then
      HeaderSize:= HeaderHeight;

    ASize.cx:= 0;
    ASize.cy:= 0; 

    case FormLayout of
      wlClient:   begin
                    if FAdxControl.IsClientLayout then begin
                      if IsHeaderVisible then
                        ASize.cy:= HeaderSize+ SplitSize+ pOffset.Top+ pOffset.Bottom+ 1
                      else
                        ASize.cy:= 0;
                    end;
                  end;
      wlLeft:     begin
                    Asize.cx := UserWidth + SplitterMove.X;
                    if (SplitterMove.X <> 0) and FAdxControl.Injected then
                      UserWidth:= Asize.cx;
                    case FAdxControl.FormRegion.State of
                      irsHidden:    Asize.cx:= SplitSize;
                      irsMinimized: Asize.cx:= HeaderSize+ SplitSize;
                    end;
                    inc(Asize.cx, pOffset.Left+ pOffset.Right);
                  end;

      wlRight:    begin
                    Asize.cx := UserWidth- SplitterMove.X;
                    if (SplitterMove.X <> 0) and FAdxControl.Injected then
                      UserWidth:= Asize.cx;

                    case FAdxControl.FormRegion.State of
                      irsHidden:    Asize.cx := SplitSize;
                      irsMinimized: Asize.cx := HeaderSize+ SplitSize;
                    end;
                    inc(Asize.cx, pOffset.Left+ pOffset.Right);
                  end;

      wlTop:      begin
                    Asize.cy := UserHeight + SplitterMove.Y;
                    if (SplitterMove.Y <> 0) and FAdxControl.Injected then
                      UserHeight:= Asize.cy;

                    if IsHeaderVisible then
                      inc(Asize.cy, HeaderSize);

                    case FAdxControl.FormRegion.State of
                      irsHidden:    Asize.cy := SplitSize;
                      irsMinimized: Asize.cy := HeaderSize+ SplitSize
                    end;
                    inc(Asize.cy, pOffset.Top+ pOffset.Bottom);
                  end;

      wlBottom:   begin
                    Asize.cy := UserHeight- SplitterMove.Y;
                    if (SplitterMove.Y <> 0) and FAdxControl.Injected then
                      UserHeight:= Asize.cy;

                    if IsHeaderVisible then
                      inc(Asize.cy, HeaderSize);

                    case FAdxControl.FormRegion.State of
                      irsHidden: Asize.cy:= SplitSize;
                      irsMinimized: Asize.cy:= HeaderSize+ SplitSize;
                    end;
                    inc(Asize.cy, pOffset.Top+ pOffset.Bottom);
                  end;
    end;
    FSplitterMove:= Point(0, 0);
end;

function TadxContainerPane.GetUserWidth: integer;
begin
  Result:= 0;
  if Assigned(FAdxControl) then
    Result:= FAdxControl.UserWidth+ SplitterDepth.Normal;
end;

function TadxContainerPane.GetTaskButtonOffset: integer;
begin
  result:= DefaultTaskButtonOffset;
end;

procedure TadxContainerPane.DrawPane(ACanvas: TadxGPGraphics; ARect: TRect; mode: TDrawMode; Depth: integer);
var
  imageOffset: TPoint;
  tb: TadxGPTextureBrush;
  destRect: TRect;
begin
  if (ThemeResourceBitmap <> nil) and (mode = drwThemed) then begin
    imageOffset:= Point(0, 0);
    if not IsHeaderHighlight then begin
      if ThemeColorIndex >= tmOffice2010_Blue then begin
        destRect:= Rect(ARect.Left+1, ARect.Top+1, ARect.Right, ARect.Bottom);
        ACanvas.SetSmoothingMode(SmoothingModeNone);
        case ThemeColorIndex of
          tmOffice2010_Blue:   imageOffset:= Point(60, 90);
          tmOffice2010_Silver: imageOffset:= Point(130, 90);
          tmOffice2010_Black:  imageOffset:= Point(60, 117);
        else
          imageOffset:= Point(60, 90); //Blue
        end;
        ACanvas.DrawImage(ThemeResourceBitmap, MakeRect(destRect), imageOffset.X, imageOffset.Y, 64, 24, UnitPixel);
        ACanvas.SetSmoothingMode(SmoothingModeHighQuality);
      end
      else begin
        imageOffset.X := integer(ThemeColorIndex);
        if imageOffset.X <= 0 then imageOffset.X := 0;
        tb:= TadxGPTextureBrush.Create(ThemeResourceBitmap, MakeRect(imageOffset.X, 0, 1, HeaderHeightXP));
        tb.TranslateTransform(0, ARect.Top);
        tb.ScaleTransform(1, DPIratio);
        ACanvas.FillRectangle(tb, ARect.Left, ARect.Top, GetRectWidth(ARect)- 1, GetRectHeight(ARect));
        tb.Free;
      end
    end
    else begin
      if ThemeColorIndex = tmOffice2010_Black then
        imageOffset:= Point(6, 0)
      else
        imageOffset:= Point(5, 0);
      tb:= TadxGPTextureBrush.Create(ThemeResourceBitmap, MakeRect(imageOffset.X, 0, 1, HeaderHeightXP));
      tb.TranslateTransform(0, ARect.Top);
      tb.ScaleTransform(1, DPIratio);
      ACanvas.FillRectangle(tb, ARect.Left, ARect.Top, GetRectWidth(ARect)- 1, GetRectHeight(ARect));
      tb.Free;
    end;
  end
  else
    DrawBackGround(ACanvas, ARect, mode);
  DrawPaneFrame(ACanvas, ARect, Depth, mode);
end;

procedure TadxContainerPane.DrawPaneMinimize(ACanvas: TadxGPGraphics; ARect: TRect; mode: TDrawMode; Depth: integer);
var
  pen: TadxGPPen;
  brush: TadxGPSolidBrush;
begin
  DrawBackGround(ACanvas, ARect, mode);

  brush:= TadxGPSolidBrush.Create(FItemColor.BackGround);
  pen:= TadxGPPen.Create(FItemColor.Border);
  try
    if mode = drwThemed then begin
      ACanvas.FillRectangle(brush, MakeRect(ARect.Left, ARect.Top, GetRectWidth(ARect)-1, GetRectHeight(ARect)-1));

      ACanvas.DrawRectangle(pen, MakeRect(ARect.Left, ARect.Top, GetRectWidth(ARect)-1, GetRectHeight(ARect)-1));
      if (FThemeColorIndex = tmOffice2010_Black) then
        pen.SetColor(FBtnColor.Border)
      else
        pen.SetColor(colorWhite);
      ACanvas.DrawRectangle(pen, MakeRect(ARect.Left+1, ARect.Top+1, GetRectWidth(ARect)-3, GetRectHeight(ARect)-3));
    end
    else begin
      brush.SetColor(GPSystemColor(COLOR_BTNFACE));
      ACanvas.FillRectangle(brush, MakeRect(ARect));

      pen.SetColor(GPSystemColor(COLOR_3DSHADOW));
      ACanvas.DrawRectangle(pen, MakeRect(ARect.Left, ARect.Top, GetRectWidth(ARect)-1, GetRectHeight(ARect)-1));
      pen.SetColor(colorWhite);
      ACanvas.DrawRectangle(pen, MakeRect(ARect.Left+1, ARect.Top+1, GetRectWidth(ARect)-3, GetRectHeight(ARect)-3));
    end;
  finally
    pen.Free;
    brush.Free;
  end;
end;

procedure TadxContainerPane.DrawBackGround(ACanvas: TadxGPGraphics;
  ARect: TRect; mode: TDrawMode);
var
  brush: TadxGPSolidBrush;
begin
  brush:= TadxGPSolidBrush.Create(GPSystemColor(COLOR_BTNFACE));
  if mode = drwThemed then
    brush.SetColor(FWndColor.BackGround);
  ACanvas.SetSmoothingMode(SmoothingModeNone);
  ACanvas.FillRectangle(brush, MakeRect(ARect));
  ACanvas.SetSmoothingMode(SmoothingModeHighQuality);
  brush.Free;
end;

procedure TadxContainerPane.DrawBackGroundColor(ACanvas: TadxGPGraphics; ARect: TRect; AColor: Cardinal);
var
  brush: TadxGPSolidBrush;
begin
  brush:= TadxGPSolidBrush.Create(AColor);
  ACAnvas.SetSmoothingMode(SmoothingModeNone);
  ACanvas.FillRectangle(brush, MakeRect(ARect));
  ACAnvas.SetSmoothingMode(SmoothingModeHighQuality);
  brush.Free;
end;

procedure TadxContainerPane.DrawBorder(ACanvas: TadxGPGraphics; Rect: TRect; Depth: integer);
begin
  case FPreset of
    tpsXP: begin
      DrawFrame(ACanvas, Rect, Depth, FWndColor.Border);
    end;
    tpsDefault: begin
      DrawFrame3D(ACanvas, Rect, Depth);
    end;
  end;
end;


procedure TadxContainerPane.DrawIconIndex(ACanvas: TadxGPGraphics; ARect: Trect; Index: integer);
var
  icon: TadxGPBitmap;
  pFormItem: PadxContainerForm;

begin
  pFormItem:= GetPaneItem(Index);
  if Assigned(pFormItem) then begin
    icon:= TadxGPBitmap(pFormItem^.glyph);
    if Assigned(icon) then
      ACanvas.DrawImage(icon, MakeRect(ARect));
  end
  else
    DrawIcon(ACanvas, ARect);
end;

procedure TadxContainerPane.DrawPane(ACanvas: TadxGPGraphics; ARect: TRect);
begin
  case FPreset of
    tpsXP: begin
      if IsMinimizedState then
        DrawPaneMinimize(ACanvas, ARect, drwThemed, BorderSize)
      else
        DrawPane(ACanvas, ARect, drwThemed, BorderSize);
    end;
    tpsDefault: begin
      if IsMinimizedState then
        DrawPaneMinimize(ACanvas, ARect, drwSimple, BorderSize)
      else
        DrawPane(ACanvas, ARect, drwSimple, BorderSize);
    end;
  end;
end;

procedure TadxContainerPane.DrawPaneButton(ACanvas: TadxGPGraphics; BtnRect: TRect;
  presset: TadxTaskPanePreset; BtnImage: integer;
  state: TadxTaskPaneButtonState; style: TAlign);

var
  HOffsetThemeIndex, VOffsetThemeIndex, HOffsetBtnImage, VOffsetBtnImage: integer;
  EnableFrame, EnableBackGround: boolean;
  BtnBackColor: TGPColor;
  brush: TadxGPBrush;
  DestRect: TRect;
  dx, dy: integer;
  imageAttr: TadxGPImageAttributes;
  transparentColor: TGPColor;

begin
  if (GetRectWidth(BtnRect) <= 0) or (GetRectHeight(BtnRect) <= 0) or (ThemeResourceBitmap = nil) then exit;

  HOffsetThemeIndex:= Integer(FThemeColorIndex) * 2;
  VOffsetThemeIndex:= 90;
  if presset = tpsDefault then
    VOffsetThemeIndex := 120;

  VOffsetBtnImage := 30;
  if (FThemeColorIndex = tmOffice2010_Black) and (not IsHeaderHighlight) then
    VOffsetBtnImage := 160;

  HOffsetBtnImage := DefaultTaskButtonWidth* BtnImage;

  EnableFrame := false;
  EnableBackGround := false;
  BtnBackColor := GPSystemColor(COLOR_BTNFACE);

  case state of
    isDisabled: begin
      inc(VOffsetBtnImage, DefaultTaskButtonHeight* 2);
    end;
    isFocused:  begin
      EnableFrame := true;
      EnableBackGround := true;
      BtnBackColor := FBtnColor.FocusedBegin;
    end;
    isPressed:  begin
      EnableFrame := true;
      EnableBackGround := true;
      BtnBackColor := FBtnColor.SelectedBegin;
      inc(VOffsetBtnImage, DefaultTaskButtonHeight);
      HOffsetThemeIndex := Integer(FThemeColorIndex)* 2 + 1;
    end;
  end;

  try
    brush:= nil;
    try
      if EnableBackGround then begin
        if ThemeColorIndex = tmUnknown then begin
          brush:= TadxGPSolidBrush.Create(BtnBackColor);
          ACanvas.FillRectangle(brush, MakeRect(BtnRect));
        end
        else begin
          brush:= TadxGPTextureBrush.Create(ThemeResourceBitmap, MakeRect(HOffsetThemeIndex, VOffsetThemeIndex, 1, DefaultTaskButtonHeight));
          TadxGPTextureBrush(brush).TranslateTransform(0, BtnRect.Top);
          TadxGPTextureBrush(brush).ScaleTransform(1, GetRectHeight(BtnRect)/DefaultTaskButtonHeight);
          ACanvas.FillRectangle(brush, MakeRect(BtnRect));
        end;
      end;

      if BtnImage >= 0 then begin
        dx := Round((GetRectWidth(BtnRect)  - DefaultTaskButtonWidth) / 2);
        dy := Round((GetRectHeight(BtnRect) - DefaultTaskButtonHeight)/ 2);

        case style of
          alLeft: begin
            dx := Round((TaskButtonWidth - DefaultTaskButtonWidth) / 2);
            DestRect := Rect(BtnRect.Left + dx, BtnRect.Top + dy,
                             BtnRect.Left + dx + DefaultTaskButtonWidth,
                             BtnRect.Top  + dy + DefaultTaskButtonHeight);
          end;
          alRight: begin
            dx := Round((TaskButtonWidth - DefaultTaskButtonWidth) / 2);
            DestRect := Rect(BtnRect.Right - DefaultTaskButtonWidth - dx, BtnRect.Top + dy,
                             BtnRect.Right - dx,
                             BtnRect.Top + dy + DefaultTaskButtonHeight);
          end;
          alTop: begin
            dy := Round((TaskButtonHeight - DefaultTaskButtonHeight) / 2);
            DestRect := Rect(BtnRect.Left + dx, BtnRect.Top + dy,
                             BtnRect.Left + dx + DefaultTaskButtonWidth,
                             BtnRect.Top  + dy + DefaultTaskButtonHeight);
          end;
          alBottom: begin
            dy := Round((TaskButtonHeight - DefaultTaskButtonHeight) / 2);
            DestRect := Rect(BtnRect.Left + dx, BtnRect.Bottom - DefaultTaskButtonHeight - dy,
                             BtnRect.Left + dx + DefaultTaskButtonWidth,
                             BtnRect.Bottom - dy);
          end
          else begin
            DestRect := Rect(BtnRect.Left + dx, BtnRect.Top + dy,
                             BtnRect.Left + dx + DefaultTaskButtonWidth,
                             BtnRect.Top  + dy + DefaultTaskButtonHeight);
          end;
        end;

        if HOffsetBtnImage < integer(ThemeResourceBitmap.GetWidth) then begin
          imageAttr:= TadxGPImageAttributes.Create;
          try
            ThemeResourceBitmap.GetPixel(HOffsetBtnImage,  VOffsetBtnImage, transparentColor);
            imageAttr.SetColorKey(transparentColor, transparentColor);
            ACanvas.DrawImage(ThemeResourceBitmap, MakeRect(destRect), HOffsetBtnImage,  VOffsetBtnImage, DefaultTaskButtonWidth, DefaultTaskButtonHeight, UnitPixel, imageAttr);
          finally
            imageAttr.Free;
          end;
        end;
      end;

      if EnableFrame then begin
        DrawPaneButtonFrame(ACanvas, BtnRect, state);
      end;
    finally
      if Assigned(brush) then
        brush.Free;
    end;
  except
    on E: Exception do begin
      Log.AddException('ADXTheme.DrawPaneButton: '+E.Message);
      raise E;
    end;
  end;
end;

procedure TadxContainerPane.DrawPaneFrame(ACanvas: TadxGPGraphics; Rect: TRect;
  Depth: integer; mode: TDrawMode);
var
  R: TRect;
begin
  if Depth > 0 then begin
    case mode of
      drwSimple: DrawFrame3D(ACanvas, Rect, Depth, BDR_RAISEDINNER, BF_LEFT or BF_TOP or BF_RIGHT);
      drwThemed: begin
        R:= Rect;
        inc(R.Bottom);
        DrawFrame(ACanvas, R, Depth, FWndColor.Border);
      end;
    end;
  end;
end;

procedure TadxContainerPane.DrawPaneText(ACanvas: TadxGPGraphics; ARect: TRect; AText: string; state: TadxTaskPaneButtonState);
var
  strDots, strPaint: string;
  textSize: TSize;
  vOffsetFont, hOffsetFont: integer;
  layout: TGPPointF;
  br: TadxGPSolidBrush;
  textFont: TadxGPFont;
  bm: TadxGPBitmap;
  bmGraphics: TadxGPGraphics;
  maxTextSize: integer;
  clText: Cardinal;

begin
  strPaint:= AText;
  strDots:= '';
  textFont:= TadxGPFont.Create(Canvas.Handle, GetSystemFontHandle(MenuFont, FW_BOLD));
  if (textFont.GDIResult <> Ok) then begin
    textFont.Free;
    textFont:= TadxGPFont.Create(Canvas.Handle, Font.Handle);
  end;

  clText:= colorBlack;
  if (FThemeColorIndex = tmOffice2010_Black) and (state = isUp) and (not IsHeaderHighlight) then
    clText:=  colorWhite; // GPSystemColor(COLOR_3DFACE);
  br:= TadxGPSolidBrush.Create(clText);

  if PaneLayout = plVertical then
    maxTextSize:= GetRectHeight(ARect)
  else
    maxTextSize:= GetRectWidth(ARect);

  while GPTextExtent(strPaint+ strDots, ACanvas, textFont, textSize).cx >= maxTextSize do begin
    strDots:= '…';
    if length(strPaint) > 0 then
      strPaint:= copy(strPaint, 1, length(strPaint)-1)
    else break;
  end;

  if length(strPaint) > 0 then begin
    vOffsetFont:= (GetRectHeight(ARect) - textSize.cy) and $01;
    layout.X:= ARect.Left;
    layout.Y:= ARect.Top + Round(int((GetRectHeight(ARect) - textSize.cy) / 2)) + vOffsetFont;

    if PaneLayout = plVertical then begin
      bm:= TadxGPBitmap.Create(textSize.cx, textSize.cy);
      bmGraphics:= TadxGPGraphics.Create(bm);
      hOffsetFont := (GetRectWidth(ARect) - textSize.cy) and $01;
      try
        layout.X:= 0;
        layout.Y:= 0;
        bmGraphics.SetTextRenderingHint(TextRenderingHintAntiAliasGridFit);
        bmGraphics.DrawString(strPaint+ strDots, length(strPaint+ strDots), textFont, layout, br);

        case FormLayout of
          wlLeft: begin
            bm.RotateFlip(Rotate270FlipNone);
            ACanvas.DrawImage(bm, ARect.Left + Round((GetRectWidth(ARect) - integer(bm.GetWidth)) / 2) + hOffsetFont, ARect.Top);
          end;
          wlRight: begin
            bm.RotateFlip(Rotate90FlipNone);
            ACanvas.DrawImage(bm, ARect.Left + Round((GetRectWidth(ARect) - integer(bm.GetWidth)) / 2), ARect.Top);
          end;
        end;
      finally
        bmGraphics.Free;
        bm.Free;
      end;
    end
    else
      ACanvas.DrawString(strPaint+ strDots, length(strPaint+ strDots), textFont, layout, br);
  end;
  br.Free;
  textFont.Free;
end;

procedure TadxContainerPane.DrawPaneTextIndex(ACanvas: TadxGPGraphics; ARect: TRect; Index: integer; state: TadxTaskPaneButtonState);
var
  text: string;
  pFormItem: PadxContainerForm;

begin
  pFormItem:= GetPaneItem(Index);
  if Assigned(pFormItem) then begin
    text:= string(pFormItem^.param^.Caption);
    DrawPaneText(ACanvas, ARect, text, state);
  end
  else
    DrawPaneText(ACanvas, ARect, TaskCaption, state);
end;

procedure TadxContainerPane.DrawSeparator(ACanvas: TadxGPGraphics; ARect: Trect);
const
  sepOffset = 2;
var
  pen: TadxGPPen;
  clShadow: Cardinal;
begin
  pen:= TadxGPPen.Create(FItemColor.Border);
  if (FThemeColorIndex = tmOffice2010_Black) then
    clShadow:= FBtnColor.Border
  else
    clShadow:= colorWhite;

  if Preset = tpsDefault then begin
    pen.SetColor(GPSystemColor(COLOR_3DSHADOW));
    clShadow:= colorWhite;
  end;
  try
    case PaneLayout of
      plHorizontal: begin
        ACanvas.DrawLine(pen, ARect.Left+ 1, ARect.Top+ sepOffset- 1 , ARect.Left+ 1, ARect.Bottom- sepOffset);
        pen.SetColor(clShadow);
        ACanvas.DrawLine(pen, ARect.Left+ 2, ARect.Top+ sepOffset- 1 , ARect.Left+ 2, ARect.Bottom- sepOffset);
      end;
      plVertical: begin
        ACanvas.DrawLine(pen, ARect.Left+ sepOffset- 1, ARect.Top+ 1, ARect.Right- sepOffset, ARect.Top+ 1);
        pen.SetColor(clShadow);
        ACanvas.DrawLine(pen, ARect.Left+ sepOffset- 1, ARect.Top+ 2, ARect.Right- sepOffset, ARect.Top+ 2);
      end;
    end;
  finally
    pen.Free;
  end;
end;

procedure TadxContainerPane.DrawSplitterButton(ACanvas: TadxGPGraphics; ARect: TRect; state: TadxTaskPaneButtonState);
var
  i, offset: integer;
  cl1, cl2: TGPColor;
  splitSize: word;
  pen: TadxGPPen;
  isBlinking: boolean;

  function GDColor(BeginColor, EndColor: TGPColor; index: integer): TGPColor;
  var
    dr, dg, db, yr, yg, yb: integer;
  begin
    yr:= GetRed(EndColor);
    yg:= GetGreen(EndColor);
    yb:= GetBlue(EndColor);

    dr:= GetRed(BeginColor) - yr;
    dg:= GetGreen(BeginColor) - yg;
    db:= GetBlue(BeginColor) - yb;

    Result:= MakeColor(yr + Round(dr/splitSize* index),
                       yg + Round(dg/splitSize* index),
                       yb + Round(db/splitSize* index));
  end;

begin
  cl1:= 0; cl2:= 0;
  isBlinking:= IsSplitterHighlight;
  pen:= TadxGPPen.Create(GPSystemColor(COLOR_BTNFACE));

  try
    if IsHiddenState then
      splitSize:= SplitterDepth.Collapsed
    else
      splitSize:= SplitterDepth.Normal;

    for i:= 0 to splitSize-1 do begin
      case state of
      isUp:      begin
                   cl1:= GDColor(GPSystemColor(COLOR_BTNFACE), GPSystemColor(COLOR_APPWORKSPACE), 1);
                   cl2:= GPSystemColor(COLOR_BTNFACE);
                 end;
      isfocused: begin
                   cl1:= themeColor.cl2007StyleBtnSelectedBegin;
                   cl2:= themeColor.cl2007StyleBtnFocusedBegin;
                 end;
      isPressed: begin
                   cl1:= themeColor.cl2007StyleBtnFocusedBegin;
                   cl2:= themeColor.cl2007StyleBtnSelectedBegin;
                 end;
      end;
      if isBlinking then begin
//        cl1:= MakeColor(255, 0, 0);
//        cl2:= MakeColor(255, 0, 0);
        cl1:= themeColor.cl2007StyleBtnSelectedBegin;
        cl2:= themeColor.cl2007StyleBtnFocusedBegin;
      end;

      Offset:= 0;
      if ((i = 0) or (i= splitSize-1)) and (not IsHiddenState) then
        Offset:= 1;

      case FormLayout of
        wlBottom, wlTop: begin
                 pen.SetColor(GDColor(cl1, cl2, i));
                 if (State <> isUp) or isBlinking then
                   ACanvas.DrawLine(pen, ARect.Left+ Offset, ARect.Top + i, ARect.Right- Offset- 1, ARect.Top + i);
                 DrawDots(ACanvas, ARect, false, State = isPressed);
               end;
        wlRight, wlLeft: begin
                 pen.SetColor(GDColor(cl1, cl2, i));
                 if (State <> isUp) or isBlinking then
                   ACanvas.DrawLine(pen, ARect.Left + i, ARect.Top+ Offset, ARect.Left + i, ARect.Bottom- Offset- 1);
                 DrawDots(ACanvas, ARect, true, State = isPressed);
               end;
      end;
    end;
  finally
    if Assigned(pen) then
      pen.Free;
  end;
end;

procedure TadxContainerPane.UpdateGradientBitmap(ARect: TRect);
const
  resourceImageWidth = 200;
  resourceImageHeight = 12;
  resourceOffsetThemeIndex = 145;
var
  bSize: TSize;
  grBitmap: TadxGPGraphics;
begin
  bSize.cx:= resourceImageWidth;
  bSize.cy:= resourceImageHeight;
  bSize.cx:= ARect.Bottom - ARect.Top;

  if Assigned(FGradientBitmap) then begin
    if (integer(FGradientBitmap.GetWidth) <> bSize.cy) or (integer(FGradientBitmap.GetHeight) <> bSize.cx) then
      FreeAndNil(FGradientBitmap)
    else
      exit;
  end;

  if not Assigned(FGradientBitmap) then begin
    fGradientBitmap := TadxGPBitmap.Create(bSize.cx, bSize.cy);
    grBitmap:= TadxGPGraphics.Create(fGradientBitmap);
    try
      grBitmap.SetSmoothingMode(SmoothingModeNone);
      grBitmap.DrawImage(ThemeResourceBitmap, MakeRect(0, 0, bSize.cx, bSize.cy), 0, resourceOffsetThemeIndex, resourceImageWidth- 1, resourceImageHeight, UnitPixel);
      fGradientBitmap.RotateFlip(Rotate90FlipNone);
    finally
      grBitmap.Destroy;
    end;
  end;
end;

procedure TadxContainerPane.ResetHighlight(HLFormHandle: HWnd);
begin
  if Assigned(FHighLighController) and (FHighLighController.FormHandle = HLFormHandle) then begin
    FHighLighController.FormHandle := HLFormHandle;
    Highlighted:= false;
  end;
end;

//procedure TadxContainerPane.UpdateHighlight(HLFormHandle: HWnd);
//begin
//  if IsMinimizedState then begin
//    Highlighted:= true;
//    exit;
//  end
//  else
//  if IsNormalState then begin
//    if Assigned(AdxControl) and (AdxControl.Handle = HLFormHandle) then begin
//      if not AdxControl.InstanceFocused then begin
//        Highlighted:= true;
//        exit;
//      end;
//    end;
//  end;
//  Highlighted:= false;
//end;

function TadxContainerPane.DrawCTPBackground(ACanvas: TadxGPGraphics; ARect: TRect): boolean;
const
  resourceItemHeight = 2;
var
  hOffsetThemeIndex: integer;
  cl: TGPColor;
  brush: TadxGPSolidBrush;
  fLayout: integer;
  dockHandle: HWnd;
  RDock: TRect;
begin
    Result:= false;
    hOffsetThemeIndex:= resourceItemHeight* (ThemeColorIndex- 10);
    if fAppVersion = v2010 then
      hOffsetThemeIndex:= resourceItemHeight* (ThemeColorIndex- 20);

    dockHandle:= FindChildWindow(HostHandle, 'MsoDockLeft', 'MsoCommandBarDock', false);
    if (dockHandle > 0) then begin
      Result:= true;
      GetWindowRect(dockHandle, RDock);
      if ((RDock.Bottom - RDock.Top) <= 0) then begin
        Result:= false;
        exit;
      end;

      UpdateGradientBitmap(RDock);

      ACanvas.SetSmoothingMode(SmoothingModeNone);
      brush:= nil;

      fLayout:= FormLayout;
      case fLayout of
        wlDockLeft, wlDockRight: begin
          ACanvas.DrawImage(FGradientBitmap, MakeRect(ARect), hOffsetThemeIndex, 0, 1, RDock.Bottom - RDock.Top, UnitPixel);
        end;
        wlDockTop: begin
          FGradientBitmap.GetPixel(hOffsetThemeIndex, 1, cl);
          brush:= TadxGPSolidBrush.Create(cl);
          ACanvas.FillRectangle(brush, ARect.Left, ARect.Top, GetRectWidth(ARect), GetRectHeight(ARect));
        end;
        wlDockBottom: begin
          FGradientBitmap.GetPixel(hOffsetThemeIndex, RDock.Bottom - RDock.Top - 1, cl);
          brush:= TadxGPSolidBrush.Create(cl);
          ACanvas.FillRectangle(brush, ARect.Left, ARect.Top, GetRectWidth(ARect), GetRectHeight(ARect));
        end;
      end;

      ACanvas.SetSmoothingMode(SmoothingModeHighQuality);
      if Assigned(brush) then
        brush.Free;
    end;
end;

function TadxContainerPane.DrawGradient(ACanvas: TadxGPGraphics; ARect: TRect): boolean;
const
  resourceItemHeight = 2;
var
  hOffsetThemeIndex: integer;
  dockHandle: HWnd;
  RHandle, RDock: TRect;
begin
    Result:= false;
    hOffsetThemeIndex:= resourceItemHeight* (ThemeColorIndex- 10);
    if fAppVersion = v2010 then
      hOffsetThemeIndex:= resourceItemHeight* (ThemeColorIndex- 20);

    dockHandle:= FindChildWindow(HostHandle, 'MsoDockLeft', 'MsoCommandBarDock', false);
    if (dockHandle > 0) then begin
      Result:= true;
      GetWindowRect(dockHandle, RDock);
      UpdateGradientBitmap(RDock);

      GetWindowRect(Handle, RHandle);
      OffsetRect(RHandle, 0, -RDock.Top);

      ACanvas.SetSmoothingMode(SmoothingModeNone);
      ACanvas.DrawImage(FGradientBitmap, MakeRect(ARect), hOffsetThemeIndex, RHandle.Top, 1, RHandle.Bottom - RHandle.Top, UnitPixel);
      ACanvas.SetSmoothingMode(SmoothingModeHighQuality);
    end;
end;

procedure TadxContainerPane.DrawPaneButtonFrame(ACanvas: TadxGPGraphics; ARect: TRect;
  state: TadxTaskPaneButtonState);
begin
  if not IsMinimizedState then
    DrawFrame(ACanvas, ARect, 1, fBtnColor.Border);
end;

function TadxContainerPane.AdxLockWindowUpdate(HwndLock: HWND): boolean;
begin
  Result:= LockWindowUpdate(HwndLock);
end;

procedure TadxContainerPane.BeginUpdate;
begin
  {if FUpdateCount <= 0 then
    FCanvasChanged:= false;  }
  inc(FUpdateCount);
end;

procedure TadxContainerPane.EndUpdate;
begin
  dec(FUpdateCount);
  if FUpdateCount <= 0 then begin
    FUpdateCount:= 0;
    if FCanvasChanged then begin
      PostMessage(Handle, WM_PAINT, 0, 0);
      //FCanvasChanged:= false;
    end;
  end;
end;

{ TAdxMSOTheme }

constructor TadxThemeChanged.CreateEx(AAdxTheme: TAdxTheme; AAppVersion: TadxHostVersion);
begin
  FAppVersion:= AAppVersion;
  CreateParented(GetDesktopWindow);
  FAdxTheme:= AAdxTheme;
end;

destructor TadxThemeChanged.Destroy;
begin
  FAdxTheme:= nil;
  inherited;
end;

function TadxThemeChanged.GetThemeIndex: TThemeColorIndex;
var
  Reg: TRegistry;
  keyName: string;
  themeIndex: integer;
begin
  themeIndex := 0;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    case FAppVersion of
      v2007: keyName:= '\Software\Microsoft\Office\12.0\Common\';
      v2010: keyName:= '\Software\Microsoft\Office\14.0\Common\';
    end;
    if Reg.KeyExists(keyName) then begin
      Reg.OpenKey(keyName, false);
      if Reg.ValueExists('Theme') then
        themeIndex := Reg.ReadInteger('Theme');
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;

  Result:= tmOffice2007_Blue;
  case FAppVersion of
    v2007: begin
      case themeIndex of
        2: Result:= tmOffice2007_Silver;
        3: Result:= tmOffice2007_Black;
      end;
    end;
    v2010: begin
      Result:= tmOffice2010_Silver;
      case themeIndex of
        1: Result:= tmOffice2010_Blue;
        2: Result:= tmOffice2010_Silver;
        3: Result:= tmOffice2010_Black;
      end;
    end;
  end;
end;

procedure TadxThemeChanged.WndProc(var Message: TMessage);
begin
  inherited;
  if ((Message.Msg = WM_MSO_BROADCASTCHANGE) and (Message.WParam = $48)) or (Message.Msg = WM_SYSCOLORCHANGE) or (Message.Msg = WM_SETTINGCHANGE) then begin
    if Assigned(FAdxTheme) then
      FAdxTheme.DoThemeChanged;
  end;
end;

procedure TadxForm.Show;
begin
  inherited Show;
end;

function TadxForm.ShowModal: Integer;
begin
  result:= mrOK;
  Show;
end;

{ TLog }

procedure TLog.AddMessage(mes: string);
begin
  try
    if (not FDisable) then begin
      InternalAddMessage(mes);
    end;
  except
    on E:SysUtils.Exception do begin
      TDebug.WriteLine('Log.AddMessage: ' + E.Message);
    end;
  end;
end;

procedure TLog.AddIndent;
begin
  FIndentCount := FIndentCount + 1;
end;

procedure TLog.AddSystemInfo(info: string);
begin
  try
    if (FSystemInfo.IndexOf(info) < 0) then begin
      FSystemInfo.Add(info);
    end;
  except
    on E:SysUtils.Exception do begin
      TDebug.WriteLine('Log.AddSystemInfo: ' + E.Message);
    end;
  end;
end;

procedure TLog.ClearMessages;
begin
  FMessages.Clear;
end;

constructor TLog.Create(ACountLastMessages: integer);
begin
  inherited Create();
  FAddinName := '';
  hLogMutex := CreateMutex(nil, False, nil);
  FDisable := false;
  FIndent := '--';
  FIndentCount := 0;
  FCountLastMessages := ACountLastMessages;
  FMessages := TStringList.Create;
  FMessages.Capacity := ACountLastMessages + 100;
  FSystemInfo := TStringList.Create;
  FExceptions := TStringList.Create;
  FLogFileByDefault := 'C:\ADXXLog.txt';
end;

destructor TLog.Destroy;
begin
  CloseHandle(hLogMutex);
  FExceptions.Free;
  FExceptions := nil;
  FSystemInfo.Free;
  FSystemInfo := nil;
  FMessages.Free;
  FMessages := nil;
  inherited Destroy;
end;

procedure TLog.Disable;
begin
  InternalAddMessage('Disable Log ' + DateTimeToStr(Now));
  FDisable := True;
end;

function TLog.GetMessages: string;
begin
  result := '';
  result := result + #13#10 + 'Exceptions:'  + #13#10 + '============' + #13#10 + FExceptions.Text;
  result := result + #13#10 + 'System Info:' + #13#10 + '============' + #13#10 + FSystemInfo.Text;
  result := result + #13#10 + 'Log:'         + #13#10 + '============' + #13#10 + FMessages.Text;
end;

procedure TLog.PutToRightsCountLastMessages;
begin
  if (not FDisable) then begin
    while (FMessages.Count > FCountLastMessages) do begin
      FMessages.Delete(FMessages.Count - 1);
    end;
  end;
end;

procedure TLog.RemoveIndent;
begin
  FIndentCount := max(FIndentCount - 1, 0);
end;

procedure TLog.SaveMessages(Sender: TObject);
var
  saveDialog: TSaveDialog;
begin
  saveDialog := TSaveDialog.Create(nil);
  try
    saveDialog.Filter := 'Text files (*.txt)|*.TXT';
    saveDialog.DefaultExt := 'txt';
    if saveDialog.Execute then begin
      Save(saveDialog.FileName);
    end;
  finally
    saveDialog.Free;
  end;
end;

procedure TLog.SetCountLastMessages(ACountLastMessages: integer);
begin
  FCountLastMessages := ACountLastMessages;
  PutToRightsCountLastMessages;
end;

procedure TLog.ShowMessages(caption: string);
var
  f: TForm;
  m:  TMemo;
  menu: TMainMenu;
  mi: TMenuItem;
begin
  InternalAddMessage('Show time: ' + DateTimeToStr(Now));

  f := TForm.Create(nil);
  f.Caption := caption;
  f.Position := poScreenCenter;
  f.BorderIcons := [biSystemMenu];
  menu := TMainMenu.Create(f);
  mi := TMenuItem.Create(menu);
  mi.Caption := 'Save as ...';
  mi.OnClick := SaveMessages;
  menu.Items.Add(mi);
  try
    m := TMemo.Create(f);
    m.ScrollBars := ssBoth;
    m.Align := alClient;
    m.Parent := f;
    m.Lines.Text := GetMessages();
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TLog.AddException(mes: string);
begin
  try
    FExceptions.Add(mes);
    InternalAddMessage('|=========================');
    InternalAddMessage('|Exception time: ' + DateTimeToStr(Now));
    InternalAddMessage('|' + mes);
    InternalAddMessage('|-------------------------');
  except
    on E:SysUtils.Exception do begin
      TDebug.WriteLine('Log.AddException: ' + E.Message);
    end;
  end;
end;

procedure TLog.AddWarning(mes: string);
begin
  try
    if (not FDisable) then begin
      InternalAddMessage('*!* ' + mes);
    end;
  except
    on E:SysUtils.Exception do begin
      TDebug.WriteLine('Log.AddWarning: ' + E.Message);
    end;
  end;
end;

procedure TLog.Save(fileName: string);
var
  log: TStringList;
begin
  InternalAddMessage('Save time: ' + DateTimeToStr(Now));
  log := nil;
  try
    log := TStringList.Create;
    log.Text := GetMessages();
    log.SaveToFile(fileName);
  finally
    if (log <> nil) then begin
      log.Free;
    end;
  end;
end;

procedure TLog.InternalAddMessage(mes: string);
var
  TotalIndent: string;
  i: integer;
  time: string;
  threadID: integer;
begin
  try
    WaitForSingleObject(hLogMutex, mutexWaiting);
    try
      if (FCountLastMessages > 0) then begin
        TotalIndent := EmptyStr;
        for i := 1 to FIndentCount do begin
          TotalIndent := TotalIndent + FIndent;
        end;
        time := DateTimeToStr(Now());
        threadID := GetCurrentThreadId;
        FMessages.Insert(0, time + char(9) + IntToStr(threadID) + char(9) +  TotalIndent + mes);
        TDebug.WriteLine(IntToStr(threadID) + char(9) + FAddinName + char(9) +  TotalIndent + mes);
        PutToRightsCountLastMessages;
        if (FSaveLogToFileByDefaultAfterAddingEachMessage) then begin
          Save(FLogFileByDefault);
        end;
      end;
    finally
      ReleaseMutex(hLogMutex);
    end;
  except
    on E:SysUtils.Exception do begin
      TDebug.WriteLine('InternalAddMessage: ' + E.Message);
    end;
  end;
end;

function TLog.GetLogFileByDefault: string;
begin
  result := FLogFileByDefault;
end;

function TLog.GetSaveLogToFileByDefaultAfterAddingEachMessage: boolean;
begin
  result := FSaveLogToFileByDefaultAfterAddingEachMessage;
end;

procedure TLog.SetLogFileByDefault(value: string);
begin
  FLogFileByDefault := value;
end;

procedure TLog.SetSaveLogToFileByDefaultAfterAddingEachMessage(
  value: boolean);
begin
  FSaveLogToFileByDefaultAfterAddingEachMessage := value;
end;

function TLog.AddinName: string;
begin
  result := FAddinName;
end;

procedure TLog.SetAddinName(value: string);
begin
  FAddinName := value;
end;

{ TadxXLHook }

constructor TadxXLHook.CreateEx(AHostVersion: TadxHostVersion; AHostHandle: HWND;
      ABeforeCellEdit: TBeforeCellEditEventHandler;
      AAfterCellEdit: TAfterCellEditEventHandler);
begin
  Create;
  FHostHandle := AHostHandle;
  FHostVersion:= AHostVersion;
  FBeforeCellEdit := ABeforeCellEdit;
  FAfterCellEdit := AAfterCellEdit;

  FMenuActive:= false;
  FActiveFormHandle:= 0;

  FKeyboardHook:= TadxXLKeyBoardHook.CreateEx(FHosthandle, self);
  FMessageHook:= TadxXLMessageHook.CreateEx(FHosthandle, self);
end;

destructor TadxXLHook.Destroy;
begin
  if Assigned (FKeyboardHook) then begin
    FKeyboardHook.Free;
    FKeyboardHook := nil;
  end;
  if Assigned(FMessageHook) then begin
    FMessageHook.Free;
    FMessageHook := nil;
  end;
  inherited;
end;

procedure TadxXLHook.DoAfterCellEdit;
begin
  if Assigned(FAfterCellEdit) then begin
    FAfterCellEdit;
  end;
end;

procedure TadxXLHook.DoBeforeCellEdit;
begin
   if Assigned(FBeforeCellEdit) then begin
     FBeforeCellEdit;
   end;
end;

procedure TadxXLHook.SetMenuActive(const Value: boolean);
begin
  if FMenuActive <> Value then begin
    FMenuActive := Value;
  end;
end;

{ TadxWDHook }

constructor TadxWDHook.CreateEx(AHostVersion: TadxHostVersion; AHostHandle: HWND);
begin
  Create;
  FHostHandle := AHostHandle;
  FHostVersion:= AHostVersion;

  FMenuActive:= false;
  FActiveFormHandle:= 0;

  fKeyboardHook:= TadxWDKeyBoardHook.CreateEx(FHosthandle, self);
  fMessageHook:= TadxWDMessageHook.CreateEx(FHosthandle, self);
  fMessageRetHook:= TadxWDMessageRetHook.CreateEx(self);
end;

destructor TadxWDHook.Destroy;
begin
  if Assigned (fKeyboardHook) then begin
    fKeyboardHook.Free;
    fKeyboardHook := nil;
  end;
  if Assigned(fMessageHook) then begin
    fMessageHook.Free;
    fMessageHook := nil;
  end;
  if Assigned(fMessageRetHook) then begin
    fMessageRetHook.Free;
    fMessageRetHook := nil;
  end;
  inherited;
end;

procedure TadxWDHook.SetMenuActive(const Value: boolean);
begin
  if FMenuActive <> Value then begin
    FMenuActive := Value;
  end;
end;

{ TadxXLKeyBoardHook }

constructor TadxXLKeyBoardHook.CreateEx(AHostHandle: HWND; AParent: TadxXLHook);
begin
  inherited Create;
  FHostHandle:= AHostHandle;
  FParent:= AParent;
end;

function TadxXLKeyBoardHook.GetFormHandle: HWND;
begin
  if FFormHandle = 0 then
    FFormHandle:= FParent.ActiveFormHandle;
  result:= FFormHandle;
end;

function TadxXLKeyBoardHook.KeyboardHookProc(code: Integer; wParam, lParam: Cardinal): Longint;
var
  lockMessage: boolean;
  menuPressed, shiftPressed, ctrlPressed, onlyMenuPressed, isShortCut: boolean;
  keyPressed: byte;
  keyFilterAction: TadxKeyFilterAction;

begin
  lockMessage:= false;
  try
    if (code = HC_ACTION) and Connected then begin
      keyPressed:= byte(wparam);
      fParent.KeyPressed:= AuditKey[keyPressed].Pressed;
      //TDebug.WriteLine(format('!!! Key= %s - %s', [IntToHex(keyPressed, 4), boolToStr(fParent.KeyPressed, true)]));

      keyFilterAction := faSendToAdxForm;

      menuPressed := AuditKey[VK_MENU].Pressed and (keyPressed <> VK_MENU);
      shiftPressed := AuditKey[VK_SHIFT].Pressed and (keyPressed <> VK_SHIFT);
      ctrlPressed := AuditKey[VK_CONTROL].Pressed and (keyPressed <> VK_CONTROL);
      onlyMenuPressed := menuPressed and (not shiftPressed) and (not ctrlPressed);

      isShortCut := menuPressed or shiftPressed or ctrlPressed
        or (keyPressed in [VK_F1 .. VK_F24, VK_INSERT, VK_DELETE, VK_END, VK_HOME]);

      KeyAction:= kaUnknown;

      if (not FParent.MenuActive) and ((keyPressed <> VK_MENU) or (not AuditKey[VK_MENU].Pressed)) then begin
        if isShortCut and (FormHandle <> 0) then begin
          if (keyPressed in [VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN]) and onlyMenuPressed then begin
            KeyAction:= kaSelectedKey;
          end
          else begin
            if (keyPressed in [$30 .. $5A]) and onlyMenuPressed then
              KeyAction:= kaHotKey
            else
              KeyAction:= kaShortCut;
          end;
          lockMessage:= ProcessCustomKey(wParam, lParam, menuPressed);
        end;

        if (not lockMessage) and (not ((keyPressed in [$30 .. $5A]) and onlyMenuPressed) ) then begin
          if isShortCut and (FormHandle <> 0) then begin
            FKeyEventArgs.Alt := menuPressed;
            FKeyEventArgs.Control := ctrlPressed;
            FKeyEventArgs.Shift := shiftPressed;
            FKeyEventArgs.KeyCode := keyPressed;
            FKeyEventArgs.State := csReleased;
            if AuditKey[keyPressed].Pressed then
              FKeyEventArgs.State := csPressed;
            FKeyEventArgs.KeyValue := lParam;
            keyFilterAction := GetKeyFilterAction;
          end;

          case keyFilterAction of
            faSendToAdxForm: begin
              if ActiveWebBrowser then begin
                if (not (keyPressed in [$30 .. $5A])) or ((keyPressed in [$43, $56, $58]) and CtrlPressed) then begin
                  KeyAction:= kaWBKey;
                  lockMessage := (FormHandle <> 0);
                  ProcessCustomKey(wParam, lParam, menuPressed);
                end;
              end
              else begin
                case keyPressed of
                  VK_TAB: KeyAction:= kaTabKey;
                  VK_RETURN: begin
                    KeyAction:= kaTabKey;
                    ProcessCustomKey(wParam, lParam, menuPressed);
                    KeyAction:= kaSelectedKey;
                  end;
                else
                  KeyAction:= kaSelectedKey;
                end;
                if not lockMessage then
                  lockMessage := ProcessCustomKey(wParam, lParam, menuPressed);
              end;
            end;
            faSendToHostApplication: begin
              if IsWindowVisible(FParent.FHostHandle) then
                Windows.SetFocus(FParent.FHostHandle);
              lockMessage:= false;
            end;
          end
        end;
      end;

      if LockMessage then begin
        CallNextHookEx(HookHandle, Code, wparam, lparam);
        Result:= 1;
        exit;
      end
    end;

    Result:= CallNextHookEx(HookHandle, Code, wparam, lparam);
  except
    on e: Exception do begin
      Log.AddException(Format('TadxXLKeyBoardHook.CallbackFunction(code= %x, wParam= %x, lParam= %x). %s', [code, wParam, lParam, e.Message]));
      raise e;
    end;
  end;
end;

{ TadxWDKeyBoardHook }

constructor TadxWDKeyBoardHook.CreateEx(AHostHandle: HWND; AParent: TadxWDHook);
begin
  inherited Create;
  FHostHandle:= AHostHandle;
  FParent:= AParent;
end;

function TadxWDKeyBoardHook.GetFormHandle: HWND;
begin
  if FFormHandle = 0 then
    FFormHandle:= FParent.ActiveFormHandle;
  result:= FFormHandle;
end;

function TadxWDKeyBoardHook.KeyboardHookProc(code: Integer; wParam, lParam: Cardinal): Longint;
var
  lockMessage: boolean;
  menuPressed, shiftPressed, ctrlPressed, onlyMenuPressed, isShortCut: boolean;
  keyPressed: byte;

begin
  try
    if (code = HC_ACTION) and Connected then begin
      keyPressed:= byte(wparam);
      lockMessage:= false;

      menuPressed := AuditKey[VK_MENU].Pressed and (keyPressed <> VK_MENU);
      shiftPressed := AuditKey[VK_SHIFT].Pressed and (keyPressed <> VK_SHIFT);
      ctrlPressed := AuditKey[VK_CONTROL].Pressed and (keyPressed <> VK_CONTROL);
      onlyMenuPressed := menuPressed and (not shiftPressed) and (not ctrlPressed);

      KeyAction:= kaUnknown;

      isShortCut := menuPressed or shiftPressed or ctrlPressed
        or (keyPressed in [VK_F1 .. VK_F24, VK_INSERT, VK_DELETE, VK_END, VK_HOME]);
      if isShortCut and (FormHandle <> 0) then begin
        if (keyPressed in [$30 .. $5A]) and onlyMenuPressed then
          KeyAction:= kaHotKey
        else
          KeyAction:= kaShortCut;
        lockMessage:= ProcessCustomKey(wParam, lParam, menuPressed);
      end;

      if not lockMessage then begin
        case keyPressed of
          VK_TAB: KeyAction:= kaTabKey;
          VK_RETURN: KeyAction:= kaPreProcess;
        end;
        lockMessage := ProcessCustomKey(wParam, lParam, menuPressed);
      end;

      if LockMessage then begin
        CallNextHookEx(HookHandle, Code, wparam, lparam);
        Result:= 1;
        exit;
      end;
    end;

    Result:= CallNextHookEx(HookHandle, Code, wparam, lparam);
  except
    on e: Exception do begin
      Log.AddException(Format('TadxWDKeyBoardHook.CallbackFunction(code= %x, wParam= %x, lParam= %x). %s', [code, wParam, lParam, e.Message]));
      raise e;
    end;
  end;
end;

{ TadxXLMessageHook }

constructor TadxXLMessageHook.CreateEx(AHostHandle: HWND; AParent: TadxXLHook);
begin
  inherited Create;
  FHostHandle:= AHostHandle;
  FParent:= AParent;
  FEditMode:= false;
end;

function TadxXLMessageHook.MessageHookProc(code: Integer; wParam, lParam: Cardinal): Longint;
var
  msg: TCWPStruct;
  wndFromPoint, tempHandle: HWND;
  activateFlag, minimizeFlag: Cardinal;
  fwEvent: integer;
  pt: TPoint;
  className: string;

begin
  try
    if code = HC_ACTION then begin
      msg:= PCWPStruct(Pointer(lParam))^;

      case msg.message of
        WM_SYSCOMMAND: begin
          if FParent.FHostVersion in [v2000, v2002, v2003] then begin
            if msg.wParam = SC_KEYMENU then
              fParent.MenuActive:= true;
          end;
        end;

        WM_ENTERIDLE: begin
          if FParent.FHostVersion in [v2000, v2002, v2003] then begin
            if not fParent.MenuActive then
              if (GetWindowClassName(msg.hwnd) = 'XLMAIN') and (msg.wParam = MSGF_MENU) then
                fParent.MenuActive:= true;
          end;
        end;

        WM_CAPTURECHANGED: begin
          if FParent.FHostVersion in [v2000, v2002, v2003] then begin
            if fParent.MenuActive and (msg.lParam = 0) then begin
              className:= GetWindowClassName(msg.hwnd);
              if (className = 'MsoCommandBar') or (className = 'MsoCommandBarPopup') then
                fParent.MenuActive:= false;
            end;
          end;
        end;

        WM_SETFOCUS: begin
          FActiveFocus := msg.hwnd;
          if not IsAdxFormHandle(FActiveFocus, tempHandle) then
            FParent.ActiveFormHandle:= 0
          else
            FParent.ActiveFormHandle:= tempHandle;

          className:= GetWindowClassName(msg.hWnd);
          if not FEditMode then
          if (GetWindowClassName(msg.wParam) = 'EXCEL7') and (className = 'EXCEL6') or (className = 'EXCEL<') then begin
            fParent.DoBeforeCellEdit;
            FEditMode:= true;
          end;
        end;

        WM_KILLFOCUS: begin
          if (FParent.FHostVersion = v2007)
             or (FParent.FHostVersion = v2010) then begin
            if GetWindowClassName(msg.hwnd) = 'NetUIHWND' then begin
              className := GetWindowClassName(GetParent(msg.hwnd));
              if className = 'NUIPane' then begin
                FParent.MenuActive:= false;
                //if FLastFocus <> 0 then
                if IsAdxFormHandle(FLastFocus, tempHandle) then begin
                  if IsWindowVisible(FLastFocus) then
                    SetFocus(FLastFocus);
                end;
              end;
            end
            else
            if GetWindowClassName(msg.wParam) = 'NetUIHWND' then begin
              className := GetWindowClassName(GetParent(msg.wParam));
              if className = 'NUIPane' then begin
                FParent.MenuActive:= true;
                FLastFocus:= msg.hwnd;
              end;
            end;
          end;

          if not IsAdxFormHandle(msg.wParam, tempHandle) then
            FParent.ActiveFormHandle:= 0
          else
            FParent.ActiveFormHandle:= tempHandle;

          className:= GetWindowClassName(msg.hWnd);
          if FEditMode then
          if (GetWindowClassName(msg.wParam) = 'EXCEL7') and ((className = 'EXCEL6') or (className = 'EXCEL<')) then begin
            FParent.DoAfterCellEdit;
            FEditMode:= false;
          end;
        end;

        WM_ACTIVATE: begin
          if GetWindowClassName(msg.hwnd) = 'XLMAIN' then begin
            activateFlag := msg.wParam and $0000FFFF;
            minimizeFlag := msg.wParam shr 16;
            if (activateFlag <> 0) and (minimizeFlag = 0) then begin
              if FActiveControl <> 0 then begin
                PostMessage(FActiveControl, WM_ADXCOMMAND, adxSetFocus, 0);
                FActiveControl := 0;
              end;
            end
            else begin
              if IsAdxFormHandle(FActiveFocus, FFormHandle) then
                FActiveControl := FFormHandle;
            end;
          end;
        end;

        WM_PARENTNOTIFY: begin
          fwEvent:= msg.wParam and $FFFF;
          if (fwEvent = WM_LBUTTONDOWN) or (fwEvent = WM_RBUTTONDOWN) or (fwEvent = WM_MBUTTONDOWN) then begin
            if (msg.hWnd = FHostHandle) then begin
              fParent.FMenuActive:= false;
              GetCursorPos(pt);
              wndFromPoint:= WindowFromPoint(pt);
              if not IsAdxFormHandle(wndFromPoint, FFormHandle) then begin
                if IsWindowVisible(FHostHandle) then
                  SetFocus(FHostHandle);
              end;
            end;
          end;
        end;

        WM_IME_STARTCOMPOSITION: begin
          FParent.IsIMEComposition := true;
        end;

        WM_IME_ENDCOMPOSITION: begin
          FParent.IsIMEComposition := false;
        end;
      end;
    end;
    result:= CallNextHookEx(HookHandle, code, wParam, lParam);
  except
    on e: Exception do begin
      Log.AddException(Format('TadxXLMessageHook.CallbackFunction(code= %x, wParam= %x, lParam= %x). %s', [code, wParam, lParam, e.Message]));
      raise e;
    end;
  end;
end;

{ TadxWDMessageHook }

constructor TadxWDMessageHook.CreateEx(AHostHandle: HWND; AParent: TadxWDHook);
begin
  inherited Create;
  FHostHandle:= AHostHandle;
  FParent:= AParent;
end;

function TadxWDMessageHook.MessageHookProc(code: Integer; wParam, lParam: Cardinal): Longint;
var
  msg: TCWPStruct;
  tempHandle: HWND;
  //activateFlag, minimizeFlag: Cardinal;
  className: string;

begin
  try
    if code = HC_ACTION then begin
      msg:= PCWPStruct(Pointer(lParam))^;

      case msg.message of
        WM_SYSCOMMAND: begin
          if FParent.FHostVersion in [v2000, v2002, v2003] then begin
            if msg.wParam = SC_KEYMENU then
              fParent.MenuActive:= true;
          end;
        end;

        WM_ENTERIDLE: begin
          if FParent.FHostVersion in [v2000, v2002, v2003] then begin
            if not fParent.MenuActive then
              if (GetWindowClassName(msg.hwnd) = 'OpusApp') and (msg.wParam = MSGF_MENU) then
                fParent.MenuActive:= true;
          end;
        end;

        WM_CAPTURECHANGED: begin
          if FParent.FHostVersion in [v2000, v2002, v2003] then begin
            if fParent.MenuActive then
              if (GetWindowClassName(msg.hwnd) = 'MsoCommandBar') and (msg.lParam = 0) then
                fParent.MenuActive:= false;
          end;
        end;

        WM_SETFOCUS: begin
          FActiveFocus := msg.hwnd;
          if not IsAdxFormHandle(FActiveFocus, tempHandle) then
            FParent.ActiveFormHandle:= 0
          else
            FParent.ActiveFormHandle:= tempHandle;
        end;

        WM_KILLFOCUS: begin
          if (FParent.FHostVersion = v2007)
            or (FParent.FHostVersion = v2010) then begin
            if GetWindowClassName(msg.hwnd) = 'NetUIHWND' then begin
              className := GetWindowClassName(GetParent(msg.hwnd));
              if className = 'NUIPane' then begin
                FParent.MenuActive:= false;
                if IsAdxFormHandle(FLastFocus, tempHandle) then begin
                  if IsWindowVisible(FLastFocus) then
                    SetFocus(FLastFocus);
                end;
              end;
            end
            else
            if GetWindowClassName(msg.wParam) = 'NetUIHWND' then begin
              className := GetWindowClassName(GetParent(msg.wParam));
              if className = 'NUIPane' then begin
                FParent.MenuActive:= true;
                FLastFocus:= msg.hwnd;
              end;
            end;
          end;

          if not IsAdxFormHandle(msg.wParam, tempHandle) then
            FParent.ActiveFormHandle:= 0
          else
            FParent.ActiveFormHandle:= tempHandle;
        end;

        //WM_ACTIVATE: begin
        //  if GetWindowClassName(msg.hwnd) = 'OpusApp' then begin
        //    activateFlag := msg.wParam and $0000FFFF;
        //    minimizeFlag := msg.wParam shr 16;
        //    if (activateFlag <> 0) and (minimizeFlag = 0) then begin
        //      if FActiveControl <> 0 then begin
        //        //Post message doesnot allow set focus to another opened document
        //        //PostMessage(FActiveControl, WM_ADXCOMMAND, adxSetFocus, 0);
        //        FActiveControl := 0;
        //      end;
        //    end
        //    else begin
        //      if IsAdxFormHandle(FActiveFocus, FFormHandle) then
        //        FActiveControl := FFormHandle;
        //    end;
        //  end;
        //end;
      end;
    end;
    result:= CallNextHookEx(HookHandle, code, wParam, lParam);
  except
    on e: Exception do begin
      Log.AddException(Format('TadxWDMessageHook.CallbackFunction(code= %x, wParam= %x, lParam= %x). %s', [code, wParam, lParam, e.Message]));
      raise e;
    end;
  end;
end;

{ Globals }

class function Globals.adxMessageResultValue: integer;
begin
  result := adxMessageResult;
end;

class function Globals.CheckADXMessageResult(WindowHandle: HWND;
      Msg: Cardinal; WParam: Integer; LParam: Integer): boolean;
var
  MessageResult: integer;
begin
  MessageResult := SendMessage(WindowHandle, Msg, WParam, LParam);
  result := MessageResult = Globals.adxMessageResultValue;
end;

class function Globals.CompareADXStrings(str1, str2: string): boolean;
begin
  result := UpperCase(str1) = UpperCase(str2);
end;

class function Globals.GetAppDataFolder: string;
var
  P: array[0..MAX_PATH-1] of Char;
  Res: Bool;
begin
  res := SHGetSpecialFolderPath{SHGetFolderPath}(0, P, CSIDL_APPDATA {CSIDL_LOCAL_APPDATA}, false);
  if (res) then
    result := P
  else
    result := Globals.GetTempDir;
end;


class function Globals.GetLongFileName(Path: string): string;
var
  I : Integer;
  SearchHandle : THandle;
  FindData : TWin32FindData;
  IsBackSlash : Boolean;
begin
  Path := ExpandFileName(Path);
  Result := ExtractFileDrive(Path);
  I := Length(Result);
  if Length(Path) <= I then  // only drive
    Exit;
  if Path[I + 1] = '\' then
  begin
    Result := Result + '\';
    Inc(I);
  end;
  Delete(Path, 1, I);
  repeat
    I := Pos('\', Path);
    IsBackSlash := I > 0;
    if not IsBackSlash then
      I := Length(Path) + 1;
    SearchHandle := FindFirstFile(PChar(Result + Copy(Path, 1,
      I - 1)), FindData);
    if SearchHandle <> INVALID_HANDLE_VALUE then
    begin
      try
        Result := Result + FindData.cFileName;
        if IsBackSlash then
          Result := Result + '\';
      finally
        Windows.FindClose(SearchHandle);
      end;
    end
    else
    begin
      Result := Result + Path;
      Break;
    end;
    Delete(Path, 1, I);
  until Length(Path) = 0;
end;

class function Globals.GetTempDir: WideString;
var
  Buffer: array[0..1023] of Char;
begin
  {$IFDEF UNICODE}
  SetString(Result, Buffer, GetTempPath(Length(Buffer) - 1, Buffer));
  {$ELSE}
  SetString(Result, Buffer, GetTempPath(Sizeof(Buffer) - 1, Buffer));
  {$ENDIF}
end;

class function Globals.WithoutBackSlash(s: string): string;
begin
  result := s;
  if result = EmptyStr then
    exit;
  if result[Length(result)] = '\' then begin
    Delete(result, Length(result), 1);
  end;
  while result[1] = '\' do begin
    Delete(result, 1, 1);
  end;
end;

class procedure Globals.WriteStringsToFile(const FileName, Data: string);
var
  Stream: TStream;
  dir: string;
begin
  if FileExists(FileName) then exit;
  dir := ExtractFileDir(FileName);
  if not DirectoryExists(dir) then
    CreateDir(dir);
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    {$IFDEF UNICODE}
    Stream.WriteBuffer(Pointer(data)^, Length(Data) * SizeOf(Char));
    {$ELSE}
    Stream.WriteBuffer(Pointer(data)^, Length(Data));
    {$ENDIF}
  finally
    Stream.Free;
  end;
end;

class function Globals.ContainsADXStrings(whole, part: string): boolean;
begin
  result := false;
  if (Pos(part, whole) > 0) then
    result := true;
end;

class function Globals.WM_ADD_ALIEN_FORM: string;
begin
  result := 'WM_ADD_ALIEN_FORM';
end;

class function Globals.WM_DELETE_PROC_IN_HOOKS_CHAIN: string;
begin
  result := 'WM_DELETE_PROC_IN_HOOKS_CHAIN';
end;

class function Globals.WM_RESIZE_TAB: string;
begin
  result := 'WM_RESIZE_TAB';
end;

class function Globals.WM_ADX_SEARCH_WINDOW_ENGINE_HIDE: string;
begin
  result := 'WM_ADX_SEARCH_WINDOW_ENGINE_HIDE';
end;

class function Globals.WM_ADX_SEARCH_WINDOW_ENGINE_SHOW: string;
begin
  result := 'WM_ADX_SEARCH_WINDOW_ENGINE_SHOW';
end;

class function Globals.WM_ADX_WINDOW_ENGINE_HIDE: string;
begin
  result := 'WM_ADX_WINDOW_ENGINE_HIDE';
end;

class function Globals.WM_ADX_WORDEDITOR_HIDE: string;
begin
  result := 'WM_ADX_WORDEDITOR_HIDE';
end;

class function Globals.WM_ADXCLOSEAPPWINDOW: string;
begin
  result := 'WM_ADXCLOSEAPPWINDOW';
end;

class function Globals.WM_ADXDELETEEMULATEWINDOW: string;
begin
  result := 'WM_ADXDELETEEMULATEWINDOW';
end;

class function Globals.WM_ADXEXIST: string;
begin
  result := 'WM_ADXEXIST';
end;

class function Globals.WM_ADXEXISTSERVICEFORM: string;
begin
  result := 'WM_ADXEXISTSERVICEFORM';
end;

class function Globals.WM_ADXHIDEALLREGIONFORMS: string;
begin
  result := 'WM_ADXHIDEALLREGIONFORMS';
end;

class function Globals.WM_ADXWMIPOSCHANGE: string;
begin
  result := 'WM_ADXWMIPOSCHANGE';
end;

class function Globals.WM_ADXREMOVECONTROLLEDRESIZEWINDOW: string;
begin
  result := 'WM_REMOVECONTROLLEDRESIZEWINDOW';
end;

class function Globals.BoolToStr(value: boolean): string;
begin
  if (Value) then
    result := 'true'
  else
    result := 'false';
end;

class function Globals.WM_ADX_READING_PANE_DIALOG_HIDE: string;
begin
  result := 'WM_ADX_READING_PANE_DIALOG_HIDE';
end;

class function Globals.WM_ADX_READING_PANE_DIALOG_SHOW: string;
begin
  result := 'WM_ADX_READING_PANE_DIALOG_SHOW';
end;

class function Globals.WM_ADXGETPICTURE: string;
begin
  result := 'WM_ADXGETPICTURE';
end;

class function Globals.ADXOLForm(root: boolean): string;
begin
  if root then begin
    //This should be ADXForm (without OL) for compatibility
    result := 'ADXForm';
  end
  else begin
    //This should not be changed. See the FoldersForExcludingFromUseWebViewPaneLayout recomendations.
    result := 'ADXXOL';
  end;
end;

class function Globals.ADXPPForm: string;
begin
  result := 'ADXPPForm';
end;

class function Globals.ADXWDForm: string;
begin
  result := 'ADXWDForm';
end;

class function Globals.ADXXLForm: string;
begin
  result := 'ADXXLForm';
end;

class function Globals.WM_ADXMAYBEWORDVIEWWASCHANGED: string;
begin
  result := 'WM_ADXMAYBEWORDVIEWWASCHANGED';
end;

class function Globals.WM_ADXENDTRANSACTION: string;
begin
  result := 'WM_ADXENDTRANSACTION';
end;

class function Globals.WM_ADXSTARTTRANSACTION: string;
begin
  result := 'WM_ADXSTARTTRANSACTION';
end;

class function Globals.ContertToInternalRegionState(
  RegionState: TadxRegionState): TadxInternalRegionState;
begin
  result := irsNormal;
  case RegionState of
    rsNormal: result := irsNormal;
    rsHidden: result := irsHidden;
    rsMinimized: result := irsMinimized;
  end;
end;

class function Globals.ContertToRegionState(
  InternalRegionState: TadxInternalRegionState; default: TadxRegionState): TadxRegionState;
begin
  result := rsNormal;
  case InternalRegionState of
    irsUnknown: result := default;
    irsNormal: result := rsNormal;
    irsHidden: result := rsHidden;
    irsMinimized: result := rsMinimized;
  end;
end;

class function Globals.WM_ADXCTP_VISIBLECHANGED: string;
begin
  result := 'WM_ADXCTP_VISIBLECHANGED';
end;

{ TadxThemeColor }

constructor TadxThemeColor.Create;
begin
  clXPBlueWndFrame          := MakeColor($00, $2C, $94);
  clXPBlueWndBack           := MakeColor($D6, $E3, $F7);
  clXPBluePaneBegin         := MakeColor($D8, $E9, $FD);
  clXPBluePaneEnd           := MakeColor($7B, $A4, $E0);
  clXPBlueBtnFrame          := MakeColor($00, $2C, $94);
  clXPBlueBtnSelectBegin    := MakeColor($E7, $EF, $FF);
  clXPBlueBtnSelectEnd      := MakeColor($9C, $BE, $EF);
  clXPBlueItemFrame         := MakeColor($5F, $8A, $D0);
  clXPBlueItemSelected      := MakeColor($EF, $E7, $A2);
  clXPBlueItemPressed       := MakeColor($ED, $9E, $2F);
  clXPBlueItemBack          := MakeColor($CC, $E1, $FC);

  clXPHomeSteadWndFrame     := MakeColor($63, $82, $5A);
  clXPHomeSteadWndBack      := MakeColor($EF, $EF, $E7);
  clXPHomeSteadPaneBegin    := MakeColor($EF, $F3, $D6);
  clXPHomeSteadPaneEnd      := MakeColor($B5, $C7, $8C);
  clXPHomeSteadBtnFrame     := MakeColor($39, $5D, $39);
  clXPHomeSteadBtnSelectBegin := MakeColor($EF, $EF, $D6);
  clXPHomeSteadBtnSelectEnd := MakeColor($C6, $D3, $A5);
  clXPHomeSteadItemFrame    := MakeColor($A6, $B1, $89);
  clXPHomeSteadItemSelected := MakeColor($EF, $E7, $A2);
  clXPHomeSteadItemPressed  := MakeColor($ED, $9E, $2F);
  clXPHomeSteadItemBack     := MakeColor($E8, $E7, $CC);

  clXPClassicWndFrame       := GPSystemColor(COLOR_APPWORKSPACE);
  clXPClassicWndBack        := GPSystemColor(COLOR_CAPTIONTEXT);
  clXPClassicPaneBegin      := MakeColor($F7, $F3, $F7);
  clXPClassicPaneEnd        := MakeColor($D6, $D3, $CE);
  clXPClassicBtnFrame       := MakeColor($08, $24, $6B);
  clXPClassicBtnFocusedBegin:= MakeColor($B5, $BE, $D6);
  clXPClassicBtnFocusedEnd  := MakeColor($B5, $BE, $D6);
  clXPClassicBtnSelectBegin := MakeColor($F7, $F7, $F7);
  clXPClassicBtnSelectEnd   := MakeColor($F7, $F7, $F7);
  clXPClassicItemFrame      := MakeColor($A6, $A6, $A6);
  clXPClassicItemSelected   := MakeColor($B6, $BD, $D2);
  clXPClassicItemPressed    := MakeColor($85, $92, $B5);
  clXPClassicItemBack       := MakeColor($EC, $EA, $E7);

  clXPMetallicWndFrame      := MakeColor($7B, $7D, $94);
  clXPMetallicWndBack       := MakeColor($F7, $F3, $F7);
  clXPMetallicPaneBegin     := MakeColor($F7, $F3, $FF);
  clXPMetallicPaneEnd       := MakeColor($94, $92, $B5);
  clXPMetallicBtnFrame      := MakeColor($4A, $49, $6B);
  clXPMetallicBtnSelectBegin:= MakeColor($E7, $EB, $F7);
  clXPMetallicBtnSelectEnd  := MakeColor($C6, $C3, $D6);
  clXPMetallicItemFrame     := MakeColor($AB, $AB, $BD);
  clXPMetallicItemSelected  := MakeColor($EF, $E7, $A2);
  clXPMetallicItemPressed   := MakeColor($ED, $9E, $2F);
  clXPMetallicItemBack      := MakeColor($E5, $E5, $EE);

  clXPRoyalePaneBegin       := MakeColor($F7, $F7, $F7);
  clXPRoyalePaneEnd         := MakeColor($EF, $EB, $EF);

  clXPStyleBtnFocusedBegin  := MakeColor($FF, $EB, $BD);
  clXPStyleBtnFocusedEnd    := MakeColor($FF, $D3, $94);

  clVistaWndFrameAero       := MakeColor($99, $B4, $D1);
  clVistaWndBackAero        := GPSystemColor(COLOR_BTNFACE);
  clVistaBtnFrameAero       := MakeColor($69, $BB, $E3);
  clVistaBtnFrameShadowAero := MakeColor($4F, $8F, $AE);

  cl2007StyleBtnFocusedBegin:= MakeColor($FF, $F5, $CC);
  cl2007StyleBtnFocusedEnd  := MakeColor($FF, $DC, $7A);
  cl2007StyleBtnFrameFocused:= MakeColor($FF, $BD, $69);
  cl2007StyleBtnFrameSelected := MakeColor($FB, $CB, $3C);
  cl2007StyleBtnSelectedBegin := MakeColor($FC, $97, $3D);
  cl2007StyleBtnSelectedEnd := MakeColor($FF, $B8, $5E);

  cl2007BlueWndFrame        := MakeColor($65, $93, $CF);
  cl2007BlueWndBackBegin    := MakeColor($E3, $EF, $FF); //($BF, $DB, $FF);
  cl2007BlueWndBackEnd      := MakeColor($65, $91, $CD);
  cl2007BluePaneBegin       := MakeColor($E3, $EF, $FF);
  cl2007BluePaneEnd         := MakeColor($B3, $D4, $FF);
  cl2007BlueItemSelected    := MakeColor($EF, $E7, $A2);
  cl2007BlueItemPressed     := MakeColor($FB, $8C, $3C);
  cl2007BlueItemBack        := MakeColor($D5, $E4, $F2);

  cl2007SilverWndFrame      := MakeColor($6F, $70, $74);
  cl2007SilverWndBackBegin  := MakeColor($F0, $F1, $F2); //($CF, $D3, $DC);
  cl2007SilverWndBackEnd    := MakeColor($9B, $9F, $A6);
  cl2007SilverPaneBegin     := MakeColor($F2, $F2, $F9);
  cl2007SilverPaneEnd       := MakeColor($99, $97, $B5);
  cl2007SilverItemSelected  := MakeColor($FF, $EE, $C2);
  cl2007SilverItemPressed   := MakeColor($FB, $8C, $3C);
  cl2007SilverItemBack      := MakeColor($E6, $E6, $ED);

  cl2007BlackWndFrame       := MakeColor($4C, $53, $5C);
  cl2007BlackWndBackBegin   := MakeColor($F0, $F1, $F2);  //($53, $53, $53);
  cl2007BlackWndBackEnd     := MakeColor($0F, $0F, $0F);
  cl2007BlackPaneBegin      := MakeColor($FF, $FF, $FF);
  cl2007BlackPaneEnd        := MakeColor($BD, $C1, $C8);
  cl2007BlackItemSelected   := MakeColor($EF, $E7, $A2);
  cl2007BlackItemPressed    := MakeColor($FB, $8C, $3C);
  cl2007BlackItemBack       := MakeColor($EB, $EB, $EB);

  cl2010BlueWndFrame        := MakeColor($BB, $C8, $D8);
  cl2010BlueWndBackBegin    := MakeColor($CF, $DD, $EE);
  cl2010BlueWndBackEnd      := MakeColor($C2, $D4, $E8);
  cl2010BluePaneBegin       := MakeColor($DB, $E1, $E7);
  cl2010BluePaneEnd         := MakeColor($DB, $E1, $E7);
  cl2010BlueItemSelected    := MakeColor($FD, $F4, $B7);
  cl2010BlueItemPressed     := MakeColor($FF, $D8, $6C);
  cl2010BlueItemBack        := MakeColor($DB, $E1, $E7);

  cl2010SilverWndFrame      := MakeColor($D3, $D7, $EA);
  cl2010SilverWndBackBegin  := MakeColor($E9, $ED, $F1);
  cl2010SilverWndBackEnd    := MakeColor($DA, $DE, $E3);
  cl2010SilverPaneBegin     := MakeColor($DB, $E1, $E7);
  cl2010SilverPaneEnd       := MakeColor($DB, $E1, $E7);
  cl2010SilverItemSelected  := MakeColor($FD, $F4, $B7);
  cl2010SilverItemPressed   := MakeColor($FF, $D8, $6C);
  cl2010SilverItemBack      := MakeColor($DB, $E1, $E7);

  cl2010BlackWndFrame      := MakeColor($75, $75, $75);
  cl2010BlackWndBackBegin  := MakeColor($83, $83, $83);
  cl2010BlackWndBackEnd    := MakeColor($48, $48, $48);
  cl2010BlackPaneBegin     := MakeColor($BD, $BD, $BD);
  cl2010BlackPaneEnd       := MakeColor($91, $91, $91);
  cl2010BlackBtnBorder     := MakeColor($35, $35, $35);
  cl2010BlackItemSelected  := MakeColor($BD, $BD, $BD);
  cl2010BlackItemPressed   := MakeColor($80, $80, $80);
  cl2010BlackItemBack      := MakeColor($59, $59, $59);
  cl2010BlackItemBorder    := MakeColor($6D, $6D, $6D);
end;

{ TadxXLThemeColor }

constructor TadxXLThemeColor.Create;
begin
  inherited;
//  clWndFrameBlue            := MakeColor($B9, $D4, $F9);
//  clWndFrameHomeStead       := MakeColor($FF, $FF, $FF);
//  clWndFrameMetallic        := MakeColor($FF, $FF, $FF);
//  clWndFrameClassic         := MakeColor($EA, $E8, $E4);

  clXPBlueWndFrame            := MakeColor($7B, $A4, $E0);
  clXPHomeSteadWndFrame       := MakeColor($B5, $C4, $8F);
  clXPMetallicWndFrame        := MakeColor($99, $97, $B5);
  clXPClassicWndFrame         := MakeColor($D0, $CC, $C4);
  clXPBlueWndBack             := MakeColor($C4, $DA, $FA);
  clXPHomeSteadWndBack        := MakeColor($F2, $F1, $E4);
  clXPMetallicWndBack         := MakeColor($F3, $F3, $F7);
  clXPClassicWndBack          := GPSystemColor(COLOR_BTNFACE);
end;

{ TadxXLContainerPane }

procedure TadxXLContainerPane.DrawPaneFrame(ACanvas: TadxGPGraphics; ARect: TRect;
  Depth: integer; mode: TDrawMode);
var
  R: TRect;
begin
  if Depth > 0 then begin
    R:= Rect(ARect.Left, ARect.Top, ARect.Right-1, ARect.Bottom);
    case mode of
      drwThemed: DrawFrame(ACanvas, R, Depth, FWndColor.Border);
      drwSimple: DrawFrame3D(ACanvas, R, Depth, BDR_RAISEDINNER, BF_TOPLEFT or BF_BOTTOMRIGHT);
    end;
  end;
end;

procedure TadxXLContainerPane.DrawSplitter(ACanvas: TadxGPGraphics; ARect: TRect);
begin
  case FAdxControl.HostVersion of
    v2007, v2010:
      DrawBackGround(ACanvas, ARect, drwThemed)
    else
      inherited;
  end;
end;

function TadxXLContainerPane.GetAdxThemeColorClass: TadxThemeColorClass;
begin
  result:= TadxXLThemeColor;
end;

function TadxXLContainerPane.GetPaneOffset: TRect;
begin
  result := inherited GetPaneOffset;
  if toDraw2007 in Options then
    result.Top := 0
  else
  if AdxControl.Layout <> wlBottom then
    result.Top := 2;
end;

function TadxXLContainerPane.GetPositionInZOrder: LongWord;
begin
  result:= HWND_BOTTOM;
end;

procedure TadxXLContainerPane.HostEnableWindow(AEnabled: Boolean);
begin
end;

procedure TadxXLContainerPane.Initialize(AppVersion, ItemType: integer; AHostHandle: HWND);
begin
  inherited;
  case AppVersion of
    v2007,
    v2010: begin
      Options:= [toDraw2007];
      Preset:= tpsXP;
    end;
  end;
end;

procedure TadxXLContainerPane.OffsetPanePosition;
begin
  if Assigned(FAdxControl) then
  case FAdxControl.HostVersion of
    v2007: begin
        case FAdxControl.Layout of
          wlLeft: begin
            inc(ScreenPos.x);
            inc(FAppWindow.ScreenPos.x);
            dec(FAppWindow.ScreenPos.cx);
          end;
          wlRight: begin
            if FAdxControl.FormRegion.State = irsHidden then begin
              dec(ScreenPos.x);
              dec(FAppWindow.ScreenPos.cx);
            end;
          end;
          wlTop: begin
            if FAdxControl.FormRegion.State = irsHidden then begin
              inc(ScreenPos.y);
              inc(FAppWindow.ScreenPos.y);
              dec(FAppWindow.ScreenPos.cy);
            end;
          end;
        end;
    end;
    v2010: begin
        case FAdxControl.Layout of
          wlLeft: begin
            dec(ScreenPos.x);
            dec(FAppWindow.ScreenPos.x);
            inc(FAppWindow.ScreenPos.cx);
            dec(ScreenPos.y);
            inc(ScreenPos.cy, 2);
          end;
          wlRight: begin
            inc(ScreenPos.x);
            inc(FAppWindow.ScreenPos.cx);
            dec(ScreenPos.y);
            inc(ScreenPos.cy, 2);
          end;
          wlTop: begin
            dec(ScreenPos.y);
            dec(FAppWindow.ScreenPos.y);
            inc(FAppWindow.ScreenPos.cy);
          end;
          wlBottom: begin
            inc(ScreenPos.y);
            inc(FAppWindow.ScreenPos.cy);
          end;
        end;
    end
    else begin
        case FAdxControl.Layout of
          wlLeft: begin
            inc(ScreenPos.x);
            inc(ScreenPos.y);
            dec(ScreenPos.cy);
          end;
          wlRight: begin
            dec(ScreenPos.x);
            dec(FAppWindow.ScreenPos.cx);
            inc(ScreenPos.y);
            dec(ScreenPos.cy);
          end;
          wlTop: begin
            inc(ScreenPos.x);
            ScreenPos.cx := ScreenPos.cx - 1;
            inc(ScreenPos.y);
          end;
          wlBottom: begin
            inc(ScreenPos.x);
            ScreenPos.cx := ScreenPos.cx - 1;
          end;
        end;
      end;
  end;
end;

{ TADXXExceptionManager }

class procedure TadxExceptionManager.ProcessADXXError(err: Exception; whereHappened: string);
begin
  if (ExceptionManager <> nil) then begin
    ExceptionManager.InternalProcessADXXError(err, whereHappened);
  end
  else begin
    AdxShowMessage(whereHappened + ': ' + err.Message, 'TADXXExceptionManager.ProcessADXXError');
  end;
end;


{ TadxOEHook }

constructor TadxOEHook.CreateEx(ApplicationHostHandle: Cardinal; AHostVersion: TadxHostVersion);
begin
  Create;
  fHostHandle:= ApplicationHostHandle;
  fHostVersion:= AHostVersion;
  oeHook_Atom_Name := '@ADXOeVCLHookAtom';
  fHookAlreadyExists:= true;
  fMenuActive:= false;

  fKeyboardHook:= TadxOEKeyBoardHook.CreateEx(fHostHandle, self);
  fMessageHook:= TadxOEMessageHook.CreateEx(fHostHandle, self);
  fMessageHookInCurrentThread:= TadxOEMessageHookInCurrentThread.CreateEx(fHostHandle, self);
  fAuditWindowList := TadxAuditWindowList.Create;

  AddExplorerItems;
end;

procedure TadxOEHook.AddExplorerItems;
var
  classPath: string;
begin
  case fHostVersion of
    vOe6: begin
      classPath := 'Outlook Express Message View\Outlook Express Message List';
      fAuditWindowList.AddItem(fHostHandle, stOeMail, classPath);

      classPath := 'Outlook Express Navigation Pane\Outlook Express Pane Frame\ThorTreeViewWndClass';
      fAuditWindowList.AddItem(fHostHandle, stOeFolderList, classPath);

      classPath := 'Outlook Express Navigation Pane\Outlook Express Pane Frame\Outlook Express Address Book Control';
      fAuditWindowList.AddItem(fHostHandle, stOeContacts, classPath);

      classPath := 'Outlook Express Message View\ME_DocHost';
      fAuditWindowList.AddItem(fHostHandle, stOePreviewPane, classPath);

      classPath := 'Outlook Express Outlook Bar\Outlook Express Outlook Bar Frame';
      fAuditWindowList.AddItem(fHostHandle, stOeOutlookBar, classPath);
    end;

    vOeVista: begin
      classPath := 'Outlook Express Message View\Outlook Express Message List';
      fAuditWindowList.AddItem(fHostHandle, stOeMail, classPath);

      classPath := 'Outlook Express Navigation Pane\ThorTreeViewWndClass';
      fAuditWindowList.AddItem(fHostHandle, stOeFolderList, classPath);

      classPath := 'Outlook Express Message View\ME_DocHost';
      fAuditWindowList.AddItem(fHostHandle, stOePreviewPane, classPath);
    end;
  end;
end;

procedure TadxOEHook.RemoveExplorerItems;
begin
  if Assigned(fAuditWindowList) then
    fAuditWindowList.ClearItems;
end;

function TadxOEHook.GetHookAlreadyExists: boolean;
begin
  if fHookAlreadyExists then begin
    fHookAlreadyExists := (Windows.FindAtom(PChar(oeHook_Atom_Name)) > 0);
    if not fHookAlreadyExists then begin
      oeHook_Atom := Windows.AddAtom(PChar(oeHook_Atom_Name));
      fHookAlreadyExists := false;
    end;
  end;
  result:= fHookAlreadyExists;
end;

procedure TadxOEHook.SetHookAlreadyExists(const Value: boolean);
begin
  if fHookAlreadyExists <> Value then begin
    if not Value then begin
      oeHook_Atom:= Windows.FindAtom(PChar(oeHook_Atom_Name));
      if (oeHook_Atom > 0) then
        Windows.DeleteAtom(oeHook_Atom);
      fHookAlreadyExists := false;
    end;
  end;
end;

procedure TadxOEHook.SetHostHandle(const Value: Cardinal);
begin
  if fHostHandle <> Value then begin
    RemoveExplorerItems;
    fHostHandle := Value;
    AddExplorerItems;
  end;
end;

destructor TadxOEHook.Destroy;
begin
  if Assigned(fMessageHook) then begin
    fMessageHook.Free;
    fMessageHook := nil;
  end;
  if Assigned(fMessageHookInCurrentThread) then begin
    fMessageHookInCurrentThread.Free;
    fMessageHookInCurrentThread := nil;
  end;
  if Assigned(fKeyboardHook) then begin
    fKeyboardHook.Free;
    fKeyboardHook := nil;
  end;

  if Assigned(fAuditWindowList) then begin
    fAuditWindowList.Free;
    fAuditWindowList := nil;
  end;

  HookAlreadyExists := false;
  inherited;
end;

{ TadxOEKeyBoardHook }

constructor TadxOEKeyBoardHook.CreateEx(AdxHostHandle: Cardinal; AParent: TadxOEHook);
begin
  HostHandle:= AdxHostHandle;
  fParent:= AParent;
  fLastKeyPressed:= 0;
  Create;
end;

function TadxOEKeyBoardHook.KeyboardHookProc(code: Integer; wParam, lParam: Cardinal): Longint;
var
  lockMessage: boolean;
  keyPressed: byte;
  menuPressed, ctrlPressed, shiftPressed, shortCutPressed, isShortCut: boolean;

begin
  lockMessage:= false;

  try
    if code = HC_ACTION then begin
      keyPressed:= byte(wParam);
      if AuditKey[keyPressed].Pressed then
        fLastKeyPressed:= keyPressed;

      menuPressed:=  (AuditKey[VK_MENU].Pressed)    and (keyPressed <> VK_MENU);
      ctrlPressed:=  (AuditKey[VK_CONTROL].Pressed) and (keyPressed <> VK_CONTROL);
      shiftPressed:= (AuditKey[VK_SHIFT].Pressed)   and (keyPressed <> VK_SHIFT);
      shortCutPressed:= ((keyPressed >= VK_F1) and (keyPressed <= VK_F24)) or (keyPressed = VK_DELETE) or (keyPressed = VK_INSERT);
      isShortCut:= menuPressed or shiftPressed or ctrlPressed or shortCutPressed;

      if (keyPressed = VK_MENU) then begin
        SendKeyToHandle(fParent.LoseFocusHandle, wParam, lParam);
        lockMessage:= true;
      end
      else begin
        if isShortCut then begin
          KeyAction:= kaPreProcess;
          lockMessage:= ProcessCustomKey(wParam, lParam, menuPressed);
          if (not lockMessage) and (not fParent.HookAlreadyExists) then
            SendKeyToHandle(fParent.LoseFocusHandle, wParam, lParam);
        end;
        if not lockMessage then begin
          if fParent.MenuActive then begin
            SendKeyToHandle(fParent.LoseFocusHandle, wParam, lParam);
            lockMessage:= true;
          end
          else begin
            if ActiveWebBrowser then begin
              if (not (keyPressed in [VK_RETURN, $30 .. $5A])) or ((keyPressed in [$43, $56, $58]) and CtrlPressed) then
                KeyAction:= kaWBKey
              else
                KeyAction:= kaSelectedKey;
            end
            else begin
              if keyPressed = VK_TAB then
                KeyAction:= kaTabKey
              else
                KeyAction:= kaSelectedKey;
            end;
            lockMessage:= ProcessCustomKey(wParam, lParam, menuPressed);
          end;
        end;
      end;
    end;

    if lockMessage then begin
      CallNextHookEx(HookHandle, code, 0, 0);
      result:= 1;
    end
    else
      result:= CallNextHookEx(HookHandle, code, wParam, lParam);

  except
    on e: Exception do begin
      Log.AddException(format('TadxOEKeyBoardHook.KeyboardHookProc(%d, %d, %d): %s', [code, wParam, lParam, e.Message]));
      raise e;
    end;
  end;
end;

{ TadxOEMessageHook }

constructor TadxOEMessageHook.CreateEx(AdxHostHandle: Cardinal; AParent: TadxOEHook);
begin
  fParent:= AParent;
  fHostHandle:= AdxHostHandle;
  Create;
end;

function TadxOEMessageHook.GetConnectThreadID: Cardinal;
var
{$IFDEF ADX_VCL5}
  processID: pointer;
{$ELSE}
  processID: LongWord;
{$ENDIF}
  threadID: Cardinal;
begin
{$IFDEF ADX_VCL5}
  processID:= nil;
{$ELSE}
  processID:= 0;
{$ENDIF}
  threadID:= GetWindowThreadProcessId(fHostHandle, processID);
  result:= threadID;
end;

function TadxOEMessageHook.MessageHookProc(code: Integer; wParam, lParam: Cardinal): Longint;
const
  TB_SETANCHORHIGHLIGHT = $0449;
var
  visible, PreviewPaneVisible: boolean;
  PreviewPaneHandle: Cardinal;
  activateFlag, minimizeFlag: integer;
  className: string;
  WPos: TWindowPos;
  tempHandle: HWND;
  R: TRect;

begin
  try
    if code = HC_ACTION then begin
      msg := PCWPStruct(lParam)^;
      case msg.message of
        WM_ACTIVATE: begin
          activateFlag:= msg.wParam and $0000FFFF;
          minimizeFlag:= msg.wParam shr 16;
          if (activateFlag <> 0) and (minimizeFlag = 0) then begin
            className:= GetWindowClassName(msg.hWnd);
            if (className = 'Outlook Express Browser Class') or (className = 'ATH_Note') then
              fParent.LoseFocusHandle := msg.hWnd;
          end;
        end;

        WM_SETFOCUS: begin
          FActiveFocus := msg.hwnd;
          if not IsAdxFormHandle(FActiveFocus, tempHandle) then
            FParent.ActiveFormHandle:= 0
          else
            FParent.ActiveFormHandle:= tempHandle;
        end;

        WM_KILLFOCUS: begin
          if not IsAdxFormHandle(msg.wParam, tempHandle) then
            FParent.ActiveFormHandle:= 0
          else
            FParent.ActiveFormHandle:= tempHandle;
        end;

        WM_SHOWWINDOW: if not Parent.HookAlreadyExists then begin
          visible:= (msg.wParam = 1);
          Parent.AuditWindowList.UpdateVisible(msg.hWnd, visible);
        end;

        TB_SETANCHORHIGHLIGHT: begin
          if (GetWindowClassName(msg.hWnd) = 'ToolbarWindow32') then
            fParent.MenuActive:= (msg.wParam = 1);
        end;

        WM_CREATE: if not Parent.HookAlreadyExists then begin
          Parent.AuditWindowList.UpdateHandle(msg.hWnd);
        end;

        WM_WINDOWPOSCHANGING: if not Parent.HookAlreadyExists then begin
          if GetWindowClassName(msg.hWnd) = 'Outlook Express Message List' then begin
            WPos:= PWindowPos(msg.lParam)^;
            GetWindowRect(GetParent(msg.hWnd), R);
            PreviewPaneVisible:= (R.Bottom- R.Top- WPos.cy >= 10) or (R.Right- R.Left- WPos.cx >= 10);
            PreviewPaneHandle:= Parent.AuditWindowList.GetHandleOfItem(stOePreviewPane);
            if PreviewPaneHandle > 0 then
              Parent.AuditWindowList.UpdateVisible(PreviewPaneHandle, PreviewPaneVisible);

          end;
        end;
      end;
    end;
    result:= CallNextHookEx(HookHandle, code, wParam, lParam);

  except
    on e: Exception do begin
      Log.AddException(format('TadxOEMessageHook.MessageHookProc(%d, %d, %d): %s', [code, wParam, lParam, e.Message]));
      raise e;
    end;
  end;
end;

{ TadxOEMessageHookInCurrentThread }

constructor TadxOEMessageHookInCurrentThread.CreateEx(AdxHostHandle: Cardinal; AParent: TadxOEHook);
begin
  fParent:= AParent;
  fHostHandle:= AdxHostHandle;
  Create;
end;

function TadxOEMessageHookInCurrentThread.MessageHookProc(code: Integer; wParam, lParam: Cardinal): Longint;
var
  tempHandle: HWND;

begin
  try
    if code = HC_ACTION then begin
      msg := PCWPStruct(lParam)^;
      case msg.message of
        WM_SETFOCUS: begin
          FActiveFocus := msg.hwnd;
          if not IsAdxFormHandle(FActiveFocus, tempHandle) then
            FParent.ActiveFormHandle:= 0
          else
            FParent.ActiveFormHandle:= tempHandle;
        end;

        WM_KILLFOCUS: begin
          if not IsAdxFormHandle(msg.wParam, tempHandle) then
            FParent.ActiveFormHandle:= 0
          else
            FParent.ActiveFormHandle:= tempHandle;
        end;
      end;
    end;
    result:= CallNextHookEx(HookHandle, code, wParam, lParam);

  except
    on e: Exception do begin
      Log.AddException(format('TadxOEMessageHookInCurrentThread.MessageHookProc(%d, %d, %d): %s', [code, wParam, lParam, e.Message]));
      raise e;
    end;
  end;
end;

{ TadxAuditWindowList }

function TadxAuditWindowList.AddItem(AuditHostHandle: Cardinal; ItemType: TadxItemType; ClassPath: string): integer;
begin
  result:= Add(TadxAuditWindow.Create(AuditHostHandle, ItemType, ClassPath));
end;

procedure TadxAuditWindowList.ClearItems;
var
  i: integer;
  auditWindow: TadxAuditWindow;
begin
  for i:= 0 to count- 1 do begin
    auditWindow:= TadxAuditWindow(Items[i]);
    if Assigned(auditWindow) then
      FreeAndNil(auditWindow);
  end;
  Clear;
end;

destructor TadxAuditWindowList.Destroy;
begin
  ClearItems;
  inherited;
end;

function TadxAuditWindowList.GetHandleOfItem(ItemType: TAdxItemType): Cardinal;
var
  i: integer;
  auditWindow: TadxAuditWindow;
begin
  result:= 0;
  for i:= 0 to count- 1 do begin
    auditWindow:= TadxAuditWindow(Items[i]);
    if Assigned(auditWindow) then
    if auditWindow.AdxItem = ItemType then begin
      result:= auditWindow.Handle;
      break;
    end;
  end;
end;

procedure TadxAuditWindowList.RemoveItem(auditWindow: TadxAuditWindow);
begin
  if Assigned(auditWindow) then begin
    Remove(Pointer(auditWindow));
    FreeAndNil(auditWindow);
  end;
end;

procedure TadxAuditWindowList.UpdateHandle(AHandle: Cardinal);
var
  i: integer;
  auditWindow: TadxAuditWindow;
begin
  for i:= 0 to count- 1 do begin
    auditWindow:= TadxAuditWindow(Items[i]);
    if Assigned(auditWindow) then
      auditWindow.UpdateHandle(AHandle);
  end;
end;

procedure TadxAuditWindowList.UpdateVisible(AHandle: Cardinal; AVisible: boolean);
var
  i: integer;
  auditWindow: TadxAuditWindow;
begin
  for i:= 0 to count- 1 do begin
    auditWindow:= TadxAuditWindow(Items[i]);
    if Assigned(auditWindow) then
      auditWindow.UpdateVisible(AHandle, AVisible);
  end;
end;

{ TadxAuditWindow }

constructor TadxAuditWindow.Create(hostHandle: Cardinal; itemType: TAdxItemType; classPath: string);
begin
  fAdxItem:= itemType;
  fClassPath:= classPath;
  fHostHandle:= hostHandle;
  fVisible:= false;
end;

destructor TadxAuditWindow.Destroy;
begin
  if Assigned(fOwner) then
    FreeAndNil(fOwner);
  inherited;
end;

function TadxAuditWindow.GetVisible: boolean;
begin
  result:= fVisible;
  if fVisible then begin
    if Assigned(fOwner) then
      result:= fOwner.Visible;
  end;
end;

procedure TadxAuditWindow.SetHandle(const Value: Cardinal);
var
  H: Cardinal;
  style: integer;
begin
  if fHandle <> Value then begin
    fHandle := Value;
    H:= GetParent(fHandle);
    if (H <> 0) and (H <> fHostHandle) then begin
      if not Assigned(fOwner) then
        fOwner:= TadxAuditWindow.create(fHostHandle, fAdxItem, '');
      fOwner.Handle:= H;
      style:= GetWindowLongCheckUnicode(H, GWL_STYLE);
      fOwner.fVisible:= (style and WS_VISIBLE) > 0;
    end;
  end;
end;

procedure TadxAuditWindow.UpdateHandle(AHandle: Cardinal);
var
  getClassPath: string;
  style: integer;
  AVisible: boolean;
begin
  getClassPath:= GetWindowClassPath(fHostHandle, AHandle);
  if getClassPath = fClassPath then begin
    style:= GetWindowLongCheckUnicode(fHandle, GWL_STYLE);
    AVisible:= (style and WS_VISIBLE) > 0;
    if Handle <> AHandle then begin
      UpdateVisible(Handle, false);
    end;
    Handle:= AHandle;
    UpdateVisible(AHandle, AVisible);
  end;
end;

function TadxAuditWindow.UpdateVisible(AHandle: Cardinal; AVisible: boolean): boolean;
var
  storeVisible, resultVisible: boolean;
begin
  result:= false;
  storeVisible:= Visible;
  if Handle = AHandle then begin
    result:= true;
    fVisible:= AVisible;
  end
  else begin
    if Assigned(fOwner) then
      result:= fOwner.UpdateVisible(AHandle, AVisible);
  end;
  if result then begin
    resultVisible:= Visible;
    if (storeVisible <> resultVisible) and (fClassPath <> '') then begin
      auditWindowParam.itemType:= fAdxItem;
      auditWindowParam.Handle:= Handle;
      auditWindowParam.HostHandle:= fHostHandle;
      auditWindowParam.Visible:= resultVisible;

      LockWindowUpdate(fHostHandle);
      try
        SendMessageFindWindows(GetDesktopWindow, 0, adxOeReceiverWindowCaption, '', WM_ADXCOMMAND, adxAuditWindowParam, Cardinal(@auditWindowParam), false);
      finally
        LockWindowUpdate(0);
      end;
    end;
  end;
end;

{ TadxOECustomForm }

constructor TadxOECustomForm.Create(AOwner: TComponent);
begin
  inherited;
  if FHostVersion = vOeVista then
    BorderWidth:= 0;
end;

procedure TadxOECustomForm.CreateAdxObjectsInstances;
begin
  FFormRegion:= TadxFormRegion.Create(Self);
  FTheme     := TadxTheme.Create(nil);
  FAppWindow := TAppWindow.CreateEx(self);
  FContainer := TadxContainer.CreateEx(Self);
end;

procedure TadxOECustomForm.DrawFrame;
var
  R: TRect;
begin
  if not Assigned(FTheme) then
    inherited
  else
  if BorderWidth > 0 then begin
    GetWindowRect(Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    case FHostVersion of
      vOE6: begin
        FTheme.DrawFrameAPI(Handle, GetWindowDC(Handle), R, drwSimple);
      end;
      vOEVista: begin
        if FItemType = stOeMailInspector then
          FTheme.DrawFrameAPI(Handle, GetWindowDC(Handle), R, drwSimple, BDR_SUNKENOUTER, BorderSides);
      end;
    end;
  end;
end;

procedure TadxOECustomForm.Hide;
begin
  inherited;
  Application.ProcessMessages;
end;

procedure TadxOECustomForm.OffsetFormPosition;
begin
  case FHostVersion of
    vOE6: if FItemType <> stOeMailInspector then begin
      case FLayout of
        wlLeft: begin
          inc(ScreenPos.x);
        end;
        wlRight: begin
          if FItemType = stOeMail then begin
            dec(ScreenPos.x);
            dec(FAppWindow.ScreenPos.cx);
          end;
        end;
        wlTop, wlBottom: begin
          case FItemType of
            stOePreviewPane: begin
              inc(ScreenPos.x);
              dec(ScreenPos.cx);
            end;
            stOeMail: begin
              inc(ScreenPos.x);
              dec(ScreenPos.cx, 2);
            end;
            stOeFolderList, stOeContacts: begin
              dec(ScreenPos.x);
              inc(ScreenPos.cx, 2);
            end;
          end;
        end;
      end;
    end;

    vOEVista: if FItemType = stOeMail then begin
      case FLayout of
        wlLeft: begin
          inc(ScreenPos.x);
        end;
        wlTop, wlBottom: begin

        end;
      end;
    end;
  end;
end;

procedure TadxOECustomForm.SetVisibleInThread(VisibleState: boolean);
begin
  if VisibleState then
    PostMessage(Handle, WM_ADXFORMSHOW, integer(VisibleState), 0)
  else
    inherited;
end;

{ TadxOEContainerPane }

procedure TadxOEContainerPane.DrawPaneButtonFrame(ACanvas: TadxGPGraphics;
  ARect: TRect; state: TadxTaskPaneButtonState);
var
  R: TRect;
begin
  if FAppVersion = vOEVista then begin
    R:= ARect;
    case state of
      isFocused: begin
        InflateRect(R, 0, 1);
        DrawFrame(ACanvas, R, 1, FBtnColor.Border);
      end;
      isPressed: begin
        DrawFrame(ACanvas, R, 1, FBtnColor.BorderShadow);
        InflateRect(R, -1, 1);
        DrawFrame(ACanvas, R, 1, FBtnColor.Border);
      end;
    end;
  end
  else
    inherited DrawPaneButtonFrame(ACanvas, ARect, state)
end;

procedure TadxOEContainerPane.DrawPaneFrame(ACanvas: TadxGPGraphics; ARect: TRect;
  Depth: integer; mode: TDrawMode);
begin
  if Assigned(FAdxControl) then begin
    if mode = drwThemed then begin
      case FAdxControl.Layout of
        wlLeft:  DrawFrame(ACanvas, ARect, Depth, fWndColor.Border);
        wlRight: DrawFrame(ACanvas, ARect, Depth, fWndColor.Border)
      else
        inherited DrawPaneFrame(ACanvas, ARect, Depth, mode);
      end;
    end
    else
      inherited DrawPaneFrame(ACanvas, ARect, Depth, mode);
  end;
end;

function TadxOEContainerPane.GetDPIratio: single;
var
  pRatio: single;
  nRatio: single;

begin
  pRatio:= 0.93;
  nRatio:= 0.85;
  result:= 1;
  if Assigned(Screen) then begin
    if Screen.PixelsPerInch = 96 then exit;

    if FAppVersion = vOEVista then
      pRatio:= 0.89;

    result:= Screen.PixelsPerInch / 96;
    if result < 1 then
      result:= result / nRatio
    else
      result:= result * pRatio;
  end;
end;

function TadxOEContainerPane.GetPositionInZOrder: LongWord;
begin
  result:= HWND_TOP;
end;

function TadxOEContainerPane.GetTaskButtonHeight: integer;
begin
  if FAppVersion = vOEVista then
    result:= HeaderHeight
  else
    result:= inherited GetTaskButtonHeight;
end;

function TadxOEContainerPane.GetTaskButtonOffset: integer;
begin
  if FAppVersion = vOEVista then
    result:= 0
  else
    result:= inherited GetTaskButtonOffset;
end;

function TadxOEContainerPane.GetTaskButtonWidth: integer;
begin
  if FAppVersion = vOEVista then
    result:= DefaultTaskButtonWidth+ 4
  else
    result:= inherited GetTaskButtonWidth;
end;

function TadxOEContainerPane.ScaledButtonHeight: integer;
begin
  if FAppVersion = vOEVista then
    result:= HeaderHeightOEVista
  else
    result:= inherited ScaledButtonHeight;
end;

procedure TadxOEContainerPane.Initialize(AppVersion, ItemType: integer;
  AHostHandle: HWND);
begin
  inherited Initialize(AppVersion, ItemType, AHostHandle);
  case AppVersion of
    vOE6: begin
      Options:= [toShowBorder];
      Preset:= tpsDefault;
    end;
    vOEVista: begin
      Options:= [];
      Preset:= tpsXP;
      HeaderHeight:= HeaderHeightOEVista;
    end;
  end;
end;

procedure TadxOEContainerPane.OffsetPanePosition;
begin
  if Assigned(FAdxControl) then
  case FAdxControl.HostVersion of
    vOE6: if FAdxControl.ItemType <> stOeMailInspector then begin
      case FAdxControl.Layout of
        wlLeft: begin
          inc(ScreenPos.x);
        end;
        wlRight: begin
          if FAdxControl.ItemType = stOeMail then begin
            dec(ScreenPos.x);
            dec(FAppWindow.ScreenPos.cx);
          end;
        end;
        wlTop, wlBottom: begin
          case FAdxControl.ItemType of
            stOePreviewPane: begin
              inc(ScreenPos.x);
              dec(ScreenPos.cx);
            end;
            stOeMail: begin
              inc(ScreenPos.x);
              dec(ScreenPos.cx, 2);
            end;
            stOeFolderList, stOeContacts: begin
              dec(ScreenPos.x);
              inc(ScreenPos.cx, 2);
            end;
          end;
        end;
      end;
    end;

    vOEVista: if FAdxControl.ItemType = stOeMail then begin
      case FAdxControl.Layout of
        wlLeft: inc(ScreenPos.x);
      end;
    end;
  end;
end;

{ TLogIndent }

constructor TLogIndent.Create;
begin
  initializeOnDefault;
  DoBefore();
  Log.AddIndent();
end;

constructor TLogIndent.Create(Mes: string);
begin
  initializeOnDefault;
  DoBefore();
  FMes := Mes;
  if (Length(FMes) > 0) then begin
    Log.AddMessage(FMes);
  end;
  Log.AddIndent();
end;

constructor TLogIndent.Create(Mes: string; AddBeginEndSuffix: boolean);
begin
  initializeOnDefault;
  DoBefore();
  FMes := Mes;
  FAddBeginEndSuffix := AddBeginEndSuffix;
  if ((Length(FMes) > 0) and FAddBeginEndSuffix) then begin
    Log.AddMessage('{+' + FMes);
  end;
  Log.AddIndent();
end;

destructor TLogIndent.Destroy;
begin
  Log.RemoveIndent();
  if ((Length(FMes) > 0) and (FAddBeginEndSuffix)) then begin
    Log.AddMessage('{-' + FMes);
  end;
  DoAfter();
  inherited;
end;

procedure TLogIndent.DoAfter;
begin
end;

procedure TLogIndent.DoBefore;
begin
end;

procedure TLogIndent.initializeOnDefault;
begin
 FMes := EmptyStr;
 FAddBeginEndSuffix := false;
end;

procedure TLogIndent.LogIndent(Mes: string);
begin
end;

procedure TLogIndent.LogIndent;
begin
end;

{ TLogEvent }

constructor TLogEvent.Create(Mes: string);
begin
  inherited Create('Event ' + Mes, true);
end;

procedure TLogEvent.DoAfter;
begin
  Log.AddMessage(EmptyStr);
end;

procedure TLogEvent.DoBefore;
begin
  Log.AddMessage(EmptyStr);
end;


{ TadxOLContainerPane }

function TadxOLContainerPane.AdxLockWindowUpdate(HwndLock: HWND): boolean;
begin
  Result:= true;
  if FAppVersion < v2010 then
    Result:= LockWindowUpdate(HwndLock);
end;

procedure TadxOLContainerPane.DrawBackGround(ACanvas: TadxGPGraphics;
  ARect: TRect; mode: TDrawMode);
var
  Result: boolean;
  itemType: TadxItemType;
begin
  Result:= false;
  if FAppVersion in [v2007, v2010] then begin
    itemType:= FormItemType;
    if (itemType = stOlNavigationPane) and (FAppVersion = v2010) then begin
      DrawBackGroundColor(ACanvas, ARect, fWndColor.Shadow);
      Result := true;
    end
    else
    if itemType = stOfficeTaskPane then begin
      Result:= DrawCTPBackground(ACanvas, ARect);
    end
    else begin
      if Assigned(FAdxControl) and (not FAdxControl.IsInspectorForm) then
        Result:= DrawGradient(ACanvas, ARect);
    end;
  end;

  if not Result then
    inherited DrawBackGround(ACanvas, ARect, mode);
end;

procedure TadxOLContainerPane.DrawBorder(ACanvas: TadxGPGraphics; Rect: TRect; Depth: integer);
begin
  if Assigned(FAdxControl) and (FAdxControl.HostVersion = v2003) and FAdxControl.IsInspectorForm then
    DrawFrame(ACanvas, Rect, Depth, FItemColor.Border)
  else
    inherited;
end;

procedure TadxOLContainerPane.DrawPaneFrame(ACanvas: TadxGPGraphics; Rect: TRect;
  Depth: integer; mode: TDrawMode);
var
  R: TRect;
begin
  if Assigned(AdxControl) and (AdxControl.HostVersion = v2003) and (AdxControl.IsInspectorForm) then
    exit;
  if Depth > 0 then begin
    R:= Rect;
    dec(R.Right);
    case mode of
      drwSimple: DrawFrame3D(ACanvas, R, Depth, BDR_RAISEDINNER, BF_TOPLEFT or BF_BOTTOMRIGHT {BF_LEFT or BF_TOP or BF_RIGHT});
      drwThemed: DrawFrame(ACanvas, R, Depth, FWndColor.Border);
    end;
  end;
end;

function TadxOLContainerPane.GetPaneOffset: TRect;
var
  fLayout, fItemType: integer;
begin
  fLayout:= FormLayout;
  fItemType:= FormItemType;

  if FAppVersion in [v2007, v2010] then begin
    if Assigned(FAdxControl) and FAdxControl.IsInspectorForm then begin
      case fLayout of
        wlLeft:   Result:= Rect(5, 6, 0, 7);
        wlRight:  Result:= Rect(0, 6, 5, 7);
        wlTop:    Result:= Rect(5, 6, 5, 0);
        wlBottom: Result:= Rect(5, 0, 5, 7);
        wlClient: begin
          if FAdxControl.IsClientLayout then
            Result:= Rect(5, 6, 5, 0)
          else
            Result:= Rect(5, 6, 5, 7)
        end
      else
        Result:= inherited GetPaneOffset;
      end;
    end

    else
    if fItemType = stOfficeTaskPane then begin
      case fLayout of
        wlDockLeft:   Result:= Rect(3, 3, 0, 3);
        wlDockRight:  Result:= Rect(0, 3, 3, 3);
        wlDockTop:    Result:= Rect(3, 3, 3, 0);
        wlDockBottom: Result:= Rect(3, 0, 3, 3)
      else
        Result:= inherited GetPaneOffset;
      end;
    end

    else
    if (fItemType = stOlNavigationPane) and (FAppVersion = v2010) then begin
      Result:= Rect(4, 0, 0, 4);
    end

    else
      Result:= inherited GetPaneOffset;
  end
  else begin
    Result:= inherited GetPaneOffset;
  end;
end;

function TadxOLContainerPane.GetPositionInZOrder: LongWord;
begin
  if (FAppVersion = v2010) and (not IsHiddenState) then
    Result:= HWND_BOTTOM
  else
  if (FAppVersion = v2007) and (FormLayout = wlTop) then
    Result:= HWND_BOTTOM
  else
    Result:= inherited GetPositionInZOrder;
end;

function TadxOLContainerPane.GetPreset: TadxTaskPanePreset;
begin
  if (FAppVersion = v2003) and Assigned(FAdxControl) and FAdxControl.IsInspectorForm then
    result:= tpsDefault
  else
    result:= inherited GetPreset;
end;

procedure TadxOLContainerPane.UpdateAppScrollBar;
const
  OlContactScrollOffset = 36;
var
  scrollHandle, vScrollHandle, hScrollHandle: HWND;
  rRegion, rScroll, R: TRect;
  offset, OlScrollSize: integer;
  flagUpdate: boolean;
  isVertical: boolean;
  isHorizontal: boolean;
begin
  if (FHostVersion = v2010) and Assigned(FAppWindow) then begin
    if FItemType = stOlJournal then
      exit;
    if CallWindowProc(FAppWindow.OldWindowProc, FAppWindow.Handle, WM_ADXEXIST, 0, 0) = adxMessageResult then
       exit;

    isVertical:= false;
    isHorizontal:= false;
    hScrollHandle:= 0;
    vScrollHandle:= 0;

    scrollHandle:= GetWindow(FAppWindow.Handle, GW_CHILD);
    while scrollHandle > 0 do begin
      if GetWindowClassName(scrollHandle) = 'NUIScrollbar' then begin
        case GetScrollType(scrollHandle) of
          sctVertical: begin
            vScrollHandle:= scrollHandle;
            isVertical:= true;
          end;
          sctHorizontal: begin
            hScrollHandle:= scrollHandle;
            isHorizontal:= true;
          end;
        end;
      end;
      scrollHandle:= GetWindow(scrollHandle, GW_HWNDNEXT);
    end;

    offset:= 0;
    OlScrollSize:= Round(DPIratio * 17);
    flagUpdate:= true;
    if FItemType = stOlContact then begin
      offset:= Round(DPIratio* OlContactScrollOffset);
      flagUpdate:= (GetWindowClassName(FAppWindow.Handle) <> 'SUPERGRID');
    end;

    if flagUpdate then begin
      GetWindowRect(FAppWindow.Handle, rRegion);
      if isVertical then begin
        GetWindowRect(vScrollHandle, rScroll);
        OffsetRect(rRegion, -rRegion.Left, -rRegion.Top);

        R:= Rect(rRegion.Right - GetRectWidth(rScroll) - offset, 0, rRegion.Right - offset, rRegion.Bottom);
        if isHorizontal then
          dec(R.Bottom, OlScrollSize);
        if GetRectWidth(rRegion)- offset > GetRectWidth(rScroll) then
          SetWindowPos(vScrollHandle, 0, R.Left, R.Top, GetRectWidth(R), GetRectHeight(R), SWP_NOACTIVATE or SWP_NOZORDER);
      end;
      if isHorizontal then begin
        GetWindowRect(hScrollHandle, rScroll);
        OffsetRect(rRegion, -rRegion.Left, -rRegion.Top);
        R:= Rect(0, rRegion.Bottom - GetRectHeight(rScroll), rRegion.Right - offset, rRegion.Bottom);
        if isVertical then
          dec(R.Right, OlScrollSize);
        SetWindowPos(hScrollHandle, 0, R.Left, R.Top, GetRectWidth(R), GetRectHeight(R), SWP_NOACTIVATE or SWP_NOZORDER);
      end;
    end;
  end;
end;

procedure TadxOLContainerPane.WndProc(var Message: TMessage);
var
  WPos: PWindowPos;
  SHOW_WHEN_WINDOWPOSCHANGING: boolean;
begin
if not (csDesigning in self.ComponentState) then begin
    if Message.Msg = WM_WINDOWPOSCHANGING then begin
      WPos:= Pointer(Message.lParam);
      SHOW_WHEN_WINDOWPOSCHANGING := ((WPos^.flags and SWP_SHOWWINDOW) > 0);

      if (SHOW_WHEN_WINDOWPOSCHANGING)
      and (AdxControl.FHostVersion = v2010)
      and (not AdxControl.Visible)
      then begin
        Log.AddMessage('EXCLUDE SWP_SHOWWINDOW');
        //Case 1437
        WPos^.flags := WPos^.flags xor SWP_SHOWWINDOW;
      end;
    end;
  end;
  inherited WndProc(Message);
end;

{ TadxxCustomEvents }

constructor TadxxCustomEvents.Create(AOwner: TComponent);
const
  adxECode = 31100;
  adxECodeCantContain = adxECode + 13;
  adxErrorCantContain = 'The %s class cannot be contained in the %s class.';
begin
  inherited Create(AOwner);
  InitServerData;
  Inc(FServerData^.InstanceCount);
  FEventDispatch := TadxxEventDispatch.Create(Self);
end;

destructor TadxxCustomEvents.Destroy;
begin
  Disconnect;
  if Assigned(FEventDispatch) then begin
    FEventDispatch.ServerDisconnect;
    if (FEventDispatch._Release = 0) then FEventDispatch.Free;
    Dec(FServerData^.InstanceCount);
  end;
  inherited Destroy;
end;

{ IUnknown }

function TadxxCustomEvents.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := S_OK
  else Result := E_NOINTERFACE;
end;

function TadxxCustomEvents._AddRef: Integer;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TadxxCustomEvents._Release: Integer;
begin
  Dec(FRefCount);
  Result := FRefCount;
end;

procedure TadxxCustomEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
end;

procedure TadxxCustomEvents.ConnectEvents(const Obj: IUnknown);
begin
  ComObj.InterfaceConnect(Obj, FServerData^.EventIID, FEventDispatch, FEventsConnection);
end;

procedure TadxxCustomEvents.DisconnectEvents(const Obj: Iunknown);
begin
  ComObj.InterfaceDisconnect(Obj, FServerData^.EventIID, FEventsConnection);
end;


{ TadxEventDispatch }

constructor TadxxEventDispatch.Create(Server: TadxxCustomEvents);
begin
  inherited Create;
  FServer := Server;
  InternalRefCount := 1;
end;

function TadxxEventDispatch.ServerDisconnect: boolean;
begin
  FServer := nil;
  if FServer <> nil then Result := False
  else Result := True;
end;

{ IUnknown }

function TadxxEventDispatch.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then begin
    Result := S_OK;
    Exit;
  end;
  if IsEqualIID(IID, FServer.FServerData^.EventIID) then begin
    GetInterface(IDispatch, Obj);
    Result := S_OK;
    Exit;
  end;
  Result := E_NOINTERFACE;
end;

function TadxxEventDispatch._AddRef: Integer;
begin
  if FServer <> nil then FServer._AddRef;
  InternalRefCount := InternalRefCount + 1;
  Result := InternalRefCount;
end;

function TadxxEventDispatch._Release: Integer;
begin
  if FServer <> nil then FServer._Release;
  InternalRefCount := InternalRefCount -1;
  Result := InternalRefCount;
end;

{ IDispatch }

function TadxxEventDispatch.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result:= S_OK;
end;

function TadxxEventDispatch.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TadxxEventDispatch.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TadxxEventDispatch.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
  i: integer;
  vVarArray : TVariantArray;
  vPVarArgIn: PVariantArg;
  vPDispParams: PDispParams;
  vFistArrItem, vLastArrItem: integer;
begin
  vPDispParams := PDispParams(@Params);
  SetLength(vVarArray, vPDispParams.cArgs);
  vFistArrItem := Low(vVarArray); vLastArrItem := High(vVarArray);
  if vPDispParams.cNamedArgs > 0 then
    for i := vFistArrItem to vLastArrItem do begin
      vPVarArgIn := @vPDispParams.rgvarg[i];
      vVarArray[vPDispParams.rgdispidNamedArgs[i]] := POleVariant(vPVarArgIn)^;
    end
  else
    for i := vFistArrItem to vLastArrItem do begin
      vPVarArgIn := @vPDispParams.rgvarg[i];
      vVarArray[vLastArrItem - i] := POleVariant(vPVarArgIn)^;
    end;
  if FServer <> nil then
    try
      FServer.InvokeEvent(DispID, vVarArray);
    except
      on E: SysUtils.Exception do
        TadxExceptionManager.ProcessADXXError(E, ClassName + '.Invoke');
    end;
  if vPDispParams.cNamedArgs > 0 then
    for i := vFistArrItem to vLastArrItem do begin
      vPVarArgIn := @vPDispParams.rgvarg[i];
      if (vPVarArgIn.vt and varByRef) <> varByRef then Continue;
      POleVariant(vPVarArgIn)^ := vVarArray[vPDispParams.rgdispidNamedArgs[i]];
    end
  else
    for i := vFistArrItem to vLastArrItem do begin
      vPVarArgIn := @vPDispParams.rgvarg[i];
      if (vPVarArgIn.vt and varByRef) <> varByRef then Continue;
      POleVariant(vPVarArgIn)^ := vVarArray[vLastArrItem - i];
    end;
  SetLength(vVarArray, 0);
  Result := S_OK;
end;

{ APIUtils }

class function APIUtils.GetActiveWindow(WindowClass: string): HWND;
var
  activeHandle: HWND;
  text: string;
begin
  activeHandle := Windows.GetActiveWindow();
  if (activeHandle > 0) then begin
    text := GetWindowClassName(activeHandle);
    if (pos(WindowClass, text) > 0) then begin
      result := activeHandle;
      Exit;
    end;
  end;
  result := 0;
  exit;
end;

{ TadxWDContainerPane }

procedure TadxWDContainerPane.DrawBorder(ACanvas: TadxGPGraphics; Rect: TRect; Depth: integer);
begin
  if Assigned(FAdxControl) and (FAdxControl.HostVersion in [v2000, v2002]) then
    DrawFrame3D(ACanvas, Rect, Depth, BDR_SUNKENOUTER)
  else
    inherited;
end;

procedure TadxWDContainerPane.DrawPaneFrame(ACanvas: TadxGPGraphics;
  ARect: TRect; Depth: integer; mode: TDrawMode);
var
  R: TRect;
begin
  if Depth > 0 then begin
    R:= Rect(ARect.Left, ARect.Top, ARect.Right-1, ARect.Bottom);
    case mode of
      drwThemed: DrawFrame(ACanvas, R, Depth, FWndColor.Border);
      drwSimple: DrawFrame3D(ACanvas, R, Depth, BDR_RAISEDINNER, BF_TOPLEFT or BF_BOTTOMRIGHT);
    end;
  end;
end;

procedure TadxWDContainerPane.DrawSplitter(ACanvas: TadxGPGraphics; ARect: TRect);
begin
  case AdxControl.HostVersion of
    v2007, v2010:
      DrawBackGround(ACanvas, ARect, drwThemed)
    else
      inherited;
  end;
end;

function TadxWDContainerPane.GetAdxThemeColorClass: TadxThemeColorClass;
begin
  result:= TadxWDThemeColor;
end;

function TadxWDContainerPane.GetPaneOffset: TRect;
begin
  result := inherited GetPaneOffset;
  if toDraw2007 in Options then
    result.Top := 0
  else
  if AdxControl.Layout <> wlBottom then
    result.Top := 2;
end;

function TadxWDContainerPane.GetPositionInZOrder: LongWord;
begin
  result:= HWND_BOTTOM;
end;

procedure TadxWDContainerPane.Initialize(AppVersion, ItemType: integer; AHostHandle: HWND);
begin
  inherited Initialize(AppVersion, ItemType, AHostHandle);
  case AppVersion of
    v2007,
    v2010: begin
      Options := [toDraw2007];
      Preset  := tpsXP;
    end;
  end;
end;

procedure TadxWDContainerPane.WndProc(var Message: TMessage);
var
  WPos: PWindowPos;
  SHOW_WHEN_WINDOWPOSCHANGING: boolean;
begin
  if not (csDesigning in self.ComponentState) then begin
    if Message.Msg = WM_WINDOWPOSCHANGING then begin
      WPos:= Pointer(Message.lParam);
      SHOW_WHEN_WINDOWPOSCHANGING := ((WPos^.flags and SWP_SHOWWINDOW) > 0);

      if (SHOW_WHEN_WINDOWPOSCHANGING)
      and (AdxControl.FHostVersion = v2010)
      and (not AdxControl.Visible)
      then begin
        Log.AddMessage('EXCLUDE SWP_SHOWWINDOW');
        //Flashing on desktop for Word 2010: File Tab, Print, Home
        WPos^.flags := WPos^.flags xor SWP_SHOWWINDOW;
      end;
    end;
  end;
  inherited WndProc(Message);
end;
{ TadxWDThemeColor }

constructor TadxWDThemeColor.Create;
begin
  inherited;
//  clWndFrameBlue            := MakeColor($B9, $D4, $F9); //$F9D4B9;
//  clWndFrameHomeStead       := MakeColor($FF, $FF, $FF); //$FFFFFF;
//  clWndFrameMetallic        := MakeColor($FF, $FF, $FF); //$FFFFFF;
//  clWndFrameClassic         := MakeColor($EA, $E8, $EA); //$E4E8EA;

  clXPBlueWndFrame            := MakeColor($7B, $A4, $E0);
  clXPHomeSteadWndFrame       := MakeColor($B5, $C4, $8F);
  clXPMetallicWndFrame        := MakeColor($99, $97, $B5);
  clXPClassicWndFrame         := MakeColor($D0, $CC, $C4);
  clXPBlueWndBack             := MakeColor($C4, $DA, $FA); //$FADAC4;
  clXPHomeSteadWndBack        := MakeColor($F2, $F1, $E4); //$E4F1F2;
  clXPMetallicWndBack         := MakeColor($F3, $F3, $F7); //$F7F3F3;
  clXPClassicWndBack          := GPSystemColor(COLOR_BTNFACE);
end;

{ TadxWDCustomForm }

procedure TadxWDCustomForm.CreateAdxObjectsInstances;
var
  fThemeColor: TadxWDThemeColor;
begin
  fThemeColor:= TadxWDThemeColor.Create;

  FFormRegion:= TadxFormRegion.Create(Self);
  FTheme:= TadxTheme.CreateEx(fThemeColor);
  FAppWindow := TAppWindow.CreateEx(self);
  FContainer := TadxContainer.CreateEx(Self);
  FContainerPane:= TadxWDContainerPane.CreateEx(FContainer);
end;

{ TadxPanePart }

function TadxPanePart.AddPart(ClassPart: TadxPanePartClass; Priority: integer): TadxPanePart;
begin
  result:= nil;
  if ClassPart <> nil then begin
    result:= ClassPart.Create(Owner, self, Priority);
    FParts.Add(result);
  end;
end;

function TadxPanePart.AddPart(Part: TadxPanePart): TadxPanePart;
begin
  result:= Part;
  if Part <> nil then begin
    FParts.Add(Part);
  end;
end;

constructor TadxPanePart.Create(AOwner: TadxContainerPane; AParent: TadxPanePart; APriority: integer);
begin
  FParts:= TList.Create;
  FOwner:= AOwner;
  FParent:= AParent;
  FPriority:= APriority;
  FState:= isUp;
  FDisposed:= false;

  Initialize;
  CreateParts;
end;

function TadxPanePart.DefaultWidth: integer;
var
  i: integer;
  part: TadxPanePart;
begin
  result:= 0;
  if Assigned(FParts) and (FParts.Count > 0) then begin
    for i:= 0 to FParts.Count- 1 do begin
      part:= Parts[i];
      if Assigned(part) then
        inc(result, part.DefaultWidth);
    end;
    if Owner.PaneLayout = plVertical then
      result:= FBoundsOffsetHeight* 2 + result+ FIntervalOffset* (FParts.Count- 1)
    else
      result:= FBoundsOffsetWidth* 2 + result+ FIntervalOffset* (FParts.Count- 1);
  end
  else
    result:= FDefaultWidth;
end;

function TadxPanePart.DefaultHeight: integer;
var
  i, h: integer;
  part: TadxPanePart;
begin
  result:= 0;
  if Assigned(FParts) and (FParts.Count > 0) then begin
    for i:= 0 to FParts.Count- 1 do begin
      part:= Parts[i];
      if Assigned(part) then begin
        h:= part.DefaultHeight;
        if h > result then
          result:= h;
      end;
    end;
  end
  else
    result:= FDefaultHeight;
end;

function TadxPanePart.RequiredWidth: integer;
var
  i: integer;
  part: TadxPanePart;
begin
  result:= 0;
  if Assigned(FParts) and (FParts.Count > 0) then begin
    for i:= 0 to FParts.Count- 1 do begin
      part:= Parts[i];
      if Assigned(part) then
        inc(result, part.RequiredWidth);
    end;
    if Owner.PaneLayout = plVertical then
      result:= FBoundsOffsetHeight* 2 + result+ FIntervalOffset* (FParts.Count- 1)
    else
      result:= FBoundsOffsetWidth* 2 + result+ FIntervalOffset* (FParts.Count- 1);
  end
  else
    result:= FDefaultWidth;
end;

procedure TadxPanePart.ResetState(AState: TadxTaskPaneButtonState; current: TadxPanePart; detail: boolean = false);
var
  i: integer;
  part: TadxPanePart;
begin
  if Assigned(FParts) and (FParts.Count > 0) then begin
    for i:= 0 to FParts.Count- 1 do begin
      part:= Parts[i];
      if Assigned(part) and (part <> current) then begin
        part.FState:= AState;
        if detail then
          part.ResetState(AState, current, detail);
      end;
    end;
  end;
end;

procedure TadxPanePart.GetDefaultSize(var AWidth: integer; var AHeight: integer);
var
  i, w, h: integer;
  part: TadxPanePart;
begin
  AWidth:= 0; AHeight:= 0;
  if Assigned(FParts) and (FParts.Count > 0) then begin
    for i:= 0 to FParts.Count- 1 do begin
      part:= Parts[i];
      if Assigned(part) then begin
        part.GetDefaultSize(w, h);
        inc(AWidth, w);
        if h > AHeight then
          Aheight:= h;
      end;
    end;
    if Owner.PaneLayout = plVertical then
      inc(AWidth, FBoundsOffsetHeight* 2 + FIntervalOffset* (FParts.Count- 1))
    else
      inc(AWidth, FBoundsOffsetWidth* 2 + FIntervalOffset* (FParts.Count- 1));
  end
  else begin
    AWidth:=  FDefaultWidth;
    AHeight:= FDefaultHeight;
  end;
end;

procedure TadxPanePart.GetRequiredSize(var AWidth, AHeight: integer);
var
  i, w, h: integer;
  part: TadxPanePart;
begin
  AWidth:= 0; AHeight:= 0;
  if Assigned(FParts) and (FParts.Count > 0) then begin
    for i:= 0 to FParts.Count- 1 do begin
      part:= Parts[i];
      if Assigned(part) then begin
        part.GetRequiredSize(w, h);
        inc(AWidth, w);
        if h > AHeight then
          Aheight:= h;
      end;
    end;
    if Owner.PaneLayout = plVertical then
      inc(AWidth, FBoundsOffsetHeight* 2 + FIntervalOffset* (FParts.Count- 1))
    else
      inc(AWidth, FBoundsOffsetWidth* 2 + FIntervalOffset* (FParts.Count- 1));
  end
  else begin
    AWidth:=  FDefaultWidth;
    AHeight:= FDefaultHeight;
  end;
end;

procedure TadxPanePart.DeleteParts;
begin
  try
    if Assigned(FParts) then begin
      while FParts.Count > 0 do begin
        if Assigned(Parts[0]) then
          Parts[0].Free;
        FParts.Delete(0);
      end;
    end;
  except
    on e: Exception do begin
      Log.AddException(ClassName+'.DeleteParts. '+e.Message);
      raise e;
    end;
  end;
end;

destructor TadxPanePart.Destroy;
begin
  try
    FDisposed:= true;
    if Assigned(Owner) then begin
      if Owner.SelectedPart = self then
        Owner.SelectedPart:= nil;
    end;
    DeleteParts;
    if Assigned(FParts) then
      FreeAndNil(FParts);
    inherited;
  except
    on e: Exception do begin
      Log.AddException(format('%s.Destroy. %s', [ClassName, e.Message]));
      raise e;
    end;
  end;
end;

function TadxPanePart.Disabled: boolean;
begin
  result:= false;
end;

procedure TadxPanePart.DoMouseUp(sender: TObject; Param: integer; MousePt: TPoint);
begin
  if Assigned(FOnClick) and (State = isPressed) then
    FOnClick(sender);
end;

procedure TadxPanePart.DoMouseHover(sender: TObject; Param: integer; MousePt: TPoint);
begin
  State:= isFocused;
end;

procedure TadxPanePart.DoMouseDblClick(sender: TObject; Param: integer; MousePt: TPoint);
begin
  if Assigned(FOnDblClick) then
    FOnDblClick(sender);
end;

procedure TadxPanePart.DoMouseDown(sender: TObject; Param: integer; MousePt: TPoint);
begin
  State:= isPressed;
end;

procedure TadxPanePart.DrawFrame(ACanvas: TadxGPGraphics);
var
  pen: TadxGPPen;
begin
  pen:= TadxGPPen.Create(colorBlack);
  ACanvas.DrawRectangle(pen, MakeRect(FBounds));
  pen.Free;
end;

function TadxPanePart.GetParts(index: integer): TadxPanePart;
begin
  if (index >= 0) and (index < FParts.Count) then
    result:= TadxPanePart(FParts.Items[index])
  else
    result:= nil;
end;

function TadxPanePart.GetWidth: integer;
begin
  result:= 0;
  case Owner.PaneLayout of
    plVertical:   result:= FBounds.Bottom- FBounds.Top;
    plHorizontal: result:= FBounds.Right-  FBounds.Left;
  end;
end;

function TadxPanePart.IndexOf: integer;
begin
  result:= -1;
  if Assigned(FParent) then
    result:= FParent.FParts.IndexOf(self);
end;

procedure TadxPanePart.Initialize;
begin
  FBounds:= Rect(0, 0, 0, 0);
  FDefaultWidth:=   Owner.TaskButtonWidth;
  FDefaultHeight:=  Owner.TaskButtonHeight;
  if Owner.Preset = tpsXP then
    fDefaultHeight := DefaultTaskItemHeight;
  FBoundsOffsetWidth:=  Owner.TaskButtonOffset;
  FBoundsOffsetHeight:=   0;
  FIntervalOffset:= DefaultTaskButtonInterval;
  FFloating:=       false;
  FFixedState:=     isUp; //isFocused;
  FState:=          isUp;
  FEnableDrag:=     true;
  if Disabled then
    FState:=        isDisabled;
end;

function TadxPanePart.NeedRemove: boolean;
begin
  result:= false;
end;

function TadxPanePart.GetFloating: boolean;
var
  i: integer;
  part: TadxPanePart;
begin
  result:= FFloating;
  if Assigned(FParts) and (FParts.Count > 0) then begin
    result:= false;
    for i:= 0 to FParts.Count- 1 do begin
      part:= Parts[i];
      if Assigned(part) then begin
        if part.Floating then begin
           result:= true;
           break;
        end;
      end;
    end;
  end;
end;

function TadxPanePart.GetHeight: integer;
begin
  result:= 0;
  case Owner.PaneLayout of
    plVertical:   result:= FBounds.Right-  FBounds.Left;
    plHorizontal: result:= FBounds.Bottom- FBounds.Top;
  end;
end;

procedure TadxPanePart.Paint(ACanvas: TadxGPGraphics);
var
  i: integer;
  part: TadxPanePart;
begin
  if Assigned(FParts) then begin
    for i:= 0 to FParts.Count- 1 do begin
      part:= Parts[i];
      if Assigned(part) then begin
        part.Paint(ACanvas);
        //part.DrawFrame(ACanvas);
      end;
    end;
  end;
end;

procedure TadxPanePart.CreateParts;
begin
end;

procedure TadxPanePart.SetBounds(const Value: TRect);
begin
  FBounds := Value;
  DeleteParts;
  Createparts;
  UpdateBounds;
  //Owner.CanvasChanged;
end;

procedure TadxPanePart.SetState(const Value: TadxTaskPaneButtonState);
begin
  if (FState <> Value) then
  if (not self.Disabled) then begin
      FState := Value;
    Owner.CanvasChanged;
  end;
end;

procedure TadxPanePart.UpdateBounds;
var
  i, hOffset, vOffset, DefaultSize, AHeight, AWidth: integer;
  FloatingCount, SizeWithOutFloating, SizeFloating, MidSizeFloating: integer;
  isFloating, flagCalculate: boolean;
  LowPriorityPart, Part: TadxPanePart;
  R: TRect;

begin
  flagCalculate:= true;
  while Assigned(FParts) and flagCalculate do begin
    flagCalculate:= false;

    repeat
      LowPriorityPart:= nil;
      FloatingCount:= 0;
      SizeWithOutFloating:= 0;

      for i:= 0 to FParts.Count- 1 do begin
        part:= Parts[i];
        if Assigned(Part) then begin
          if LowPriorityPart = nil then
            LowPriorityPart:= Part
          else
          if Part.Priority < LowPriorityPart.Priority then
            LowPriorityPart:= Part;

          if Part.Floating then
            inc(FloatingCount)
          else
            inc(SizeWithOutFloating, Part.DefaultWidth);
        end;
      end;

      DefaultSize:= DefaultWidth;
      if (DefaultSize > Width) and (LowPriorityPart <> nil) then begin
         FParts.Remove(LowPriorityPart);
         if LowPriorityPart.Floating then
            dec(FloatingCount);
         LowPriorityPart.Free;
      end;
    until (DefaultSize <= Width) or (FParts.Count <= 0);

    if FParts.Count <= 0 then exit;

    if Owner.PaneLayout = plVertical then
      SizeFloating:= Width - SizeWithOutFloating - FBoundsOffsetHeight* 2 - FIntervalOffset* (FParts.Count - 1)
    else
      SizeFloating:= Width - SizeWithOutFloating - FBoundsOffsetWidth* 2 - FIntervalOffset* (FParts.Count - 1);

    if FloatingCount > 0 then
      MidSizeFloating:= Round(SizeFloating/ FloatingCount)
    else
      MidSizeFloating:= SizeFloating;

    hOffset:= FBounds.Left+ FBoundsOffsetWidth;
    vOffset:= FBounds.Top + FBoundsOffsetHeight;

    for i:= 0 to FParts.Count- 1 do begin
      part:= Parts[i];
      part.GetDefaultSize(AWidth, AHeight);
      isFloating:= part.Floating;
      R:= Rect(0,0,0,0);

      if Assigned(Part) then begin
        case Owner.PaneLayout of
          plVertical: begin
            R.Left:=    hOffset+ Round((GetRectWidth(FBounds)- AHeight) / 2);
            R.Top:=     vOffset;
            R.Right:=   R.Left+ AHeight;
            if isFloating then begin
              if FloatingCount = 1 then
                R.Bottom := R.Top+ SizeFloating
              else begin
                R.Bottom := R.Top+ MidSizeFloating;
                dec(SizeFloating, MidSizeFloating);
                dec(FloatingCount);
              end;
            end
            else
              R.Bottom := R.Top+ AWidth;
            if GetRectHeight(R) > 0 then
              vOffset := R.Bottom + FIntervalOffset;
          end;
          plHorizontal: begin
            R.Left:=    hOffset;
            R.Top:=     vOffset+ Round((GetRectHeight(FBounds) - AHeight) / 2);
            R.Bottom:=  R.Top+ AHeight;
            if isFloating then begin
              if FloatingCount = 1 then
                R.Right := R.Left+ SizeFloating
              else begin
                R.Right := R.Left+ MidSizeFloating;
                dec(SizeFloating, MidSizeFloating);
                dec(FloatingCount);
              end;
            end
            else
              R.Right := R.Left+ AWidth;
            if GetRectWidth(R) > 0 then
              hOffset := R.Right + FIntervalOffset;
          end;
        end; { case }

        if (GetRectWidth(R) = 0) or Part.NeedRemove then begin
          if Part.NeedRemove then
            flagCalculate:= true;
          FParts.Items[i]:= nil;
          Part.Free;
        end
        else begin
          if (FParts.Count = 1) and (not isFloating) then begin
            if Owner.PaneLayout = plHorizontal then begin
              //Align to Right
              R.Left:= FBounds.Right- GetRectWidth(R)- FBoundsOffsetWidth;
              R.Right:= FBounds.Right- FBoundsOffsetWidth;
            end;
          end;
          Part.Bounds:= R;
        end;
      end;
    end;
    FParts.Pack;
  end;
end;

procedure TadxPanePart.UpdateRegion(ARegion: TadxGPRegion; X, Y: integer);
var
  i: integer;
  part: TadxPanePart;
begin
  if Assigned(FParts) then begin
    for i:= 0 to FParts.Count- 1 do begin
      part:= Parts[i];
      if Assigned(part) then begin
        part.UpdateRegion(ARegion, X, Y);
      end;
    end;
  end;
end;

function TadxPanePart.FindPart(ACursorPos: TPoint): TadxPanePart;
var
  i: integer;
  part: TadxPanePart;
begin
  result:= nil;
  if Assigned(FParts) and (FParts.Count > 0) then begin
    for i:= 0 to FParts.Count- 1 do begin
      part:= Parts[i];
      if Assigned(part) then begin
        result:= part.FindPart(ACursorPos);
        if result <> nil then
          break;
      end;
    end;
  end
  else begin
    if PtInRect(FBounds, ACursorPos) then
      result:= self;
  end;
end;

function TadxPanePart.UpdateState(ACursorPos: TPoint; AState: TadxTaskPaneButtonState): boolean;
var
  i: integer;
  part: TadxPanePart;
begin
  result:= false;
  try
    Owner.BeginUpdate;
    if Assigned(FParts) and (FParts.Count > 0) then begin
      for i:= 0 to FParts.Count- 1 do begin
        part:= Parts[i];
        if Assigned(part) then begin
          if part.UpdateState(ACursorPos, AState) then
            result:= true
          else begin
            if part.Disabled then part.State:= isDisabled
            else part.State:= isUp;
          end;
        end;
      end;
    end
    else begin
      result:= PtInRect(FBounds, ACursorPos);
      if result then begin
        if Disabled then State:= isDisabled
        else State:= AState;
      end;
    end;
  finally
    Owner.EndUpdate;
  end;
end;

{ TadxPanePartButton }

procedure TadxPanePartButton.Initialize;
begin
  inherited Initialize;
  FBoundsOffsetWidth := 0;
  FFloating   := false;
  FPaneButton:= pbNone;
end;

procedure TadxPanePartButton.Paint(ACanvas: TadxGPGraphics);
begin
  Owner.DrawPaneButton(ACanvas, FBounds, Owner.Preset, Integer(FPaneButton), State, alNone);
end;

{ TadxPanePartCaption }

procedure TadxPanePartCaption.Initialize;
begin
  inherited;
  FBoundsOffsetWidth := 0;
  FDefaultWidth:= 0;
  FFloating   := true;
end;

procedure TadxPanePartCaption.Paint(ACanvas: TadxGPGraphics);
var
  captionRect: TRect;
begin
  inherited;
  if GetRectWidth(FBounds)- FBoundsOffsetWidth*2 > 0 then begin
    captionRect:= FBounds;
    inc(captionRect.Left, FBoundsOffsetWidth);
    dec(captionRect.Right, FBoundsOffsetWidth);
    Owner.DrawPaneText(ACanvas, captionRect, Owner.TaskCaption, FState);
  end;
end;

{ TadxPanePartMainOlder }

procedure TadxPanePartHeaderOlder.CreateParts;
begin
  inherited;
  if Assigned(FParts) then begin
    if Owner.EnableNavigation then
      AddPart(TadxPanePartNavigateButtons, 1);
    if Owner.EnableNavigation then begin
      if Owner.Preset = tpsDefault then begin
        AddPart(TadxPanePartCaption, 3);
        AddPart(TadxPanePartMenuButton, 4);
      end
      else
        AddPart(TadxPanePartMenuAndCaption, 3);
    end
    else
      AddPart(TadxPanePartCaption, 3);
    if Owner.EnableClose then
      AddPart(TadxPanePartCloseButton, 0);
  end;
end;

procedure TadxPanePartHeaderOlder.Initialize;
begin
  inherited;
  //FBoundsOffsetHeight:= byte(Owner.FAppVersion <> vOeVista);
end;

procedure TadxPanePartHeaderOlder.Paint(ACanvas: TadxGPGraphics);
begin
  Owner.DrawPane(ACanvas, FBounds);
  inherited;
end;

{ TadxPanePartBackButton }

function TadxPanePartBackButton.Disabled: boolean;
begin
  result:= not Owner.EnableScroll(false);
end;

procedure TadxPanePartBackButton.Initialize;
begin
  inherited;
  FPaneButton:= pbBack;
  FEnableDrag:= false;
  FOnClick:= Owner.DoActionSelectBack;
end;

{ TadxPanePartNextButton }

function TadxPanePartNextButton.Disabled: boolean;
begin
  result:= not Owner.EnableScroll(true);
end;

procedure TadxPanePartNextButton.Initialize;
begin
  inherited;
  FPaneButton:= pbNext;
  FEnableDrag:= false;
  FOnClick:= Owner.DoActionSelectNext;
end;

{ TadxPanePartNavigateButtons }

procedure TadxPanePartNavigateButtons.CreateParts;
begin
  inherited;
  if Assigned(FParts) then begin
    AddPart(TadxPanePartBackButton, 0);
    AddPart(TadxPanePartNextButton, 1);
  end;
end;

procedure TadxPanePartNavigateButtons.Initialize;
begin
  inherited;
  FBoundsOffsetWidth := 0;
end;

{ TadxPanePartCloseButton }

procedure TadxPanePartCloseButton.Initialize;
begin
  inherited;
  FPaneButton:= pbClose;
  FEnableDrag:= false;
  OnClick:= Owner.DoActionCloseForm;
end;

{ TadxPanePartMenuButton }

procedure TadxPanePartMenuButton.Initialize;
begin
  inherited;
  FPaneButton:= pbMenu;
  FOnClick:= Owner.DoActionMenuOpen;
end;

{ TadxPanePartMenuAndCaption }

procedure TadxPanePartMenuAndCaption.Initialize;
begin
  inherited;
  FBoundsOffsetWidth := 2;
  FFloating:= true;
  FPaneButton:= pbMenu;
  FOnClick:= Owner.DoActionMenuOpen;
end;

procedure TadxPanePartMenuAndCaption.Paint(ACanvas: TadxGPGraphics);
var
  captionRect: TRect;
begin
  //inherited;
  Owner.DrawPaneButton(ACanvas, FBounds, Owner.Preset, Integer(FPaneButton), State, alRight);
  if GetRectWidth(FBounds)- DefaultWidth- FIntervalOffset- FBoundsOffsetWidth*2 > 0 then begin
    captionRect:= FBounds;
    inc(captionRect.Left, FBoundsOffsetWidth);
    dec(captionRect.Right, DefaultWidth+ FIntervalOffset+ FBoundsOffsetWidth);
    Owner.DrawPaneText(ACanvas, captionRect, Owner.TaskCaption, FState);
  end;
end;

{ TadxPanePartDots }

procedure TadxPanePartDots.Initialize;
begin
  inherited;
  FBoundsOffsetWidth := 0;
  FDefaultWidth:= 6;
end;

procedure TadxPanePartDots.Paint(ACanvas: TadxGPGraphics);
begin
  inherited;
  Owner.DrawDots(ACanvas, FBounds);
end;

{ TPictureHelper }

class procedure PictureHelper.GetPicturePointer(picture: TadxGPImage; var nativeImage: Pointer);
begin
  if Assigned(picture) then
    nativeImage:= TGPImageAccess(picture).nativeImage
  else
    nativeImage:= nil;
end;

class procedure PictureHelper.GetPictureFromAdxForm(Handle: HWND; var picture: TadxGPImage);
var
  nativeImage, cloneimage: GpImage;
  imageObj: TadxGPImage;
  lastResult: TStatus;
begin
  picture:= nil;
  if SendMessage(Handle, GetPictureMessage, 0, Cardinal(@nativeImage)) = adxMessageResult then begin
    imageObj:= TGPImageAccess.Create(nativeImage, Ok);
    case imageObj.GetType of
      ImageTypeBitmap: begin
        lastResult:= GdipCloneImage(nativeImage, cloneimage);
        if cloneimage <> nil then
          picture:= TGPBitmapAccess.Create(cloneimage, lastResult);
      end;
    end;
    TGPImageAccess(imageObj).nativeImage:= nil;
    imageObj.Free;
  end;
end;

//class function PictureHelper.IID_IPicture: TGuid;
//begin
//  result := StringToGUID('{7BF80980-BF32-101A-8BBB-00AA00300CAB}');
//end;

class function PictureHelper.GetPictureMessage: dword;
begin
  result := WM_ADXGETPICTURE;
end;

{ TadxPanePartMain }

procedure TadxPanePartHeader.CreateParts;
begin
  inherited;
  if Assigned(FParts) then begin
    if Owner.IsMinimizedState then begin
      case Owner.PaneLayout of
        plVertical: begin
          if Owner.EnableMinimize then
            AddPart(TadxPanePartMinimizeButton, 2);
          AddPart(TadxPanePartSeparator, 1);
          AddPart(TadxPanePartGallery, 0);
        end;
        plHorizontal: begin
          AddPart(TadxPanePartGallery, 0);
          AddPart(TadxPanePartSeparator, 1);
          if Owner.EnableMinimize then
            AddPart(TadxPanePartMinimizeButton, 2);
        end;
      end;
    end
    else begin
      if Owner.EnableNavigation then
         AddPart(TadxPanePartNavigateButtons, 0);
      AddPart(TadxPanePartMenuAndCaptionEx, 3);

//      if Owner.EnableIcon(-1) then
//        AddPart(TadxPanePartIconPlace, 0);
//      if Owner.EnableNavigation then begin
//        if Owner.Preset = tpsDefault then begin
//          AddPart(TadxPanePartCaption, 2);
//          AddPart(TadxPanePartMenuButton, 4);
//        end
//        else
//          AddPart(TadxPanePartMenuAndCaption, 2);
//      end
//      else
//        AddPart(TadxPanePartCaption, 2);

      if Owner.EnableClose then
        AddPart(TadxPanePartCloseButton, 1);
      if Owner.EnableMinimize then
        AddPart(TadxPanePartMinimizeButton, 2);
    end;
  end;
end;

destructor TadxPanePartHeader.Destroy;
begin
  if FParent is TadxPanePartMain then
    TadxPanePartMain(FParent).FHeaderPart:= nil;
  inherited;
end;

procedure TadxPanePartHeader.Initialize;
begin
  inherited;
  if Owner.IsMinimizedState then begin
    FBoundsOffsetWidth := 0;
    FBoundsOffsetHeight:= 0;
    case Owner.PaneLayout of
      plVertical:   FBoundsOffsetHeight:= 2;
      plHorizontal: FBoundsOffsetWidth:=  2;
    end;
  end;
  //FOffsetHeight:= byte(Owner.FAppVersion <> vOeVista);
end;

procedure TadxPanePartHeader.Paint(ACanvas: TadxGPGraphics);
begin
  Owner.DrawPane(ACanvas, FBounds);
  inherited;
end;

{ TadxPanePartMain }

procedure TadxPanePartMain.CreateParts;
begin
  inherited;
  if Assigned(FParts) then begin
    FFormAreaPart:= nil;
    FHeaderPart:= nil;
    FSplitterPart:= nil;

    if Owner.IsHiddenState then begin
      FSplitterPart:= TadxPanePartSplitter.Create(Owner, self, 0);
      AddPart(FSplitterPart);
      exit;
    end
    else begin
      if Owner.IsHeaderVisible then begin
        if Owner.EnableMinimizeRegion then
          FHeaderPart:=   TadxPanePartHeader.Create(Owner, self, 1)
        else
          FHeaderPart:=   TadxPanePartHeaderOlder.Create(Owner, self, 1);
        AddPart(FHeaderPart);
      end;
      if Owner.IsSplitterVisible then begin
        FSplitterPart:= TadxPanePartSplitter.Create(Owner, self, 0);
        AddPart(FSplitterPart);
      end;
    end;

    if (not Owner.IsMinimizedState) and (not Owner.IsClientLayout) then begin
      FFormAreaPart:= TadxPanePartFormArea.Create(Owner, self, 2);
      AddPart(FFormAreaPart);
    end;
  end;
end;

procedure TadxPanePartMain.Initialize;
begin
  inherited;
  FDefaultWidth:= 0;
  FDefaultHeight:= 0;
  FBoundsOffsetWidth:= 0;
  FBoundsOffsetHeight:= 0;
  FIntervalOffset:= 0;
end;

procedure TadxPanePartMain.Paint(ACanvas: TadxGPGraphics);
begin
  if Assigned(FHeaderPart) then
    FHeaderPart.Paint(ACanvas);
  if Assigned(FSplitterPart) then
    FSplitterPart.Paint(ACanvas);
  if Assigned(FFormAreaPart) then
    FFormAreaPart.Paint(ACanvas);  
end;

procedure TadxPanePartMain.UpdateBounds;
var
  splitSize, headerSize, fLayout: integer;
  pOffset: TRect;
  splitRect, headerRect, formRect: TRect;
begin
  fLayout:= Owner.FormLayout;
  pOffset:= Owner.PaneOffset;

  splitSize:= 0;
  if Owner.IsSplitterVisible then
    splitSize:= Owner.SplitterDepth.Normal;

  headerSize:= 0;
  if Owner.IsHeaderVisible then
    headerSize:= Owner.HeaderHeight;

  formRect:= Rect(fBounds.Left+ pOffset.Left, fBounds.Top+ pOffset.Top, fBounds.Right- pOffset.Right, fBounds.Bottom- pOffset.Bottom);
  splitRect:=  formRect;
  headerRect:= formRect;

  if Owner.IsHiddenState then begin
  end

  else
  if Owner.IsMinimizedState then begin
      case fLayout of
        wlLeft: begin
          headerRect.Right:= headerRect.Left+ headerSize;
          splitRect.Left:= headerRect.Right;
        end;
        wlRight: begin
          headerRect.Left:= headerRect.Right- headerSize;
          splitRect.Right:= headerRect.Left;
        end;
        wlTop: begin
          headerRect.Bottom:= headerRect.Top+ headerSize;
          splitRect.Top:= headerRect.Bottom;
        end;
        wlBottom: begin
          headerRect.Top:= headerRect.Bottom- headerSize;
          splitRect.Bottom:= headerRect.Top;
        end;
      end;
  end

  else begin
      case fLayout of
        wlClient, wlDockLeft, wlDockRight, wlDockTop, wlDockBottom: begin
          if Owner.IsClientLayout then begin
            headerRect.Bottom:= headerRect.Top+ headerSize;
            splitRect.Top:= splitRect.Bottom- splitSize;
          end
          else begin
            headerRect.Bottom:= headerRect.Top + headerSize;
            inc(formRect.Top, headerSize);
          end;
        end;
        wlLeft: begin
          dec(headerRect.Right, splitSize);
          headerRect.Bottom:= headerRect.Top + headerSize;
          inc(formRect.Top, headerSize);
          dec(formRect.Right, splitSize);
          splitRect.Left:= splitRect.Right- splitSize;
        end;
        wlRight: begin
          inc(headerRect.Left, splitSize);
          headerRect.Bottom:= headerRect.Top + headerSize;
          inc(formRect.Top, headerSize);
          inc(formRect.Left, splitSize);
          splitRect.Right:= splitRect.Left+ splitSize;
        end;
        wlTop: begin
          headerRect.Bottom:= headerRect.Top + headerSize;
          inc(formRect.Top, headerSize);
          dec(formRect.Bottom, splitSize);
          splitRect.Top:= splitRect.Bottom - splitSize;
        end;
        wlBottom: begin
          splitRect.Bottom:= splitRect.Top+ splitSize;
          headerRect.Top:= headerRect.Top+ splitSize;
          headerRect.Bottom:= headerRect.Top+ headerSize;
          inc(formRect.Top, splitSize+ headerSize);
        end;
      end;
  end;

  if Assigned(FFormAreaPart) then
    FFormAreaPart.Bounds:= formRect;
  if Assigned(FHeaderPart) then
    FHeaderPart.Bounds:= headerRect;
  if Assigned(FSplitterPart) then
    FSplitterPart.Bounds:= splitRect;
end;

{ TadxPanePartMinimizeButton }

procedure TadxPanePartMinimizeButton.Initialize;
begin
  inherited Initialize;
  FPaneButton:= pbMinimize;
  FEnableDrag := false;
  if Owner.IsMinimizedState then begin
    FDefaultWidth := Owner.HeaderHeight - 5;
    FDefaultHeight:= Owner.HeaderHeight - 5;
  end;
  FOnClick:= Owner.DoActionMinimize;
end;

procedure TadxPanePartMinimizeButton.Paint(ACanvas: TadxGPGraphics);
var
  imageIndex: integer;
begin
  imageindex:= integer(FPaneButton);
  if Owner.IsMinimizedState then begin
    case Owner.FormLayout of
      wlLeft:   inc(imageIndex);
      wlTop:    inc(imageIndex, 3);
      wlBottom: inc(imageIndex, 2);
    end;
  end
  else begin
    case Owner.FormLayout of
      wlRight:  inc(imageIndex);
      wlTop:    inc(imageIndex, 2);
      wlBottom: inc(imageIndex, 3);
    end;
  end;
  Owner.DrawPaneButton(ACanvas, FBounds, Owner.Preset, imageIndex, State, alNone);
end;

{ TadxPanePartIcon }

function TadxPanePartIcon.Disabled: boolean;
begin
  result:= not Owner.EnableIcon(-1);
end;

procedure TadxPanePartIcon.Initialize;
begin
  inherited;
  FBoundsOffsetWidth := 0;
  FDefaultWidth:=  Owner.TaskIconWidth;
  FDefaultHeight:=  Owner.TaskIconHeight;
end;

procedure TadxPanePartIcon.Paint(ACanvas: TadxGPGraphics);
begin
  inherited;
  Owner.DrawIcon(ACanvas, FBounds);
end;

{ TadxPanePartIconPlace }

procedure TadxPanePartIconPlace.CreateParts;
begin
  inherited;
  if Assigned(FParts) then begin
    AddPart(TadxPanePartIcon, 0);
  end;
end;

procedure TadxPanePartIconPlace.Initialize;
begin
  inherited;
  FBoundsOffsetWidth := 4;
  FBoundsOffsetHeight:= Owner.HeaderHeight mod 2;
end;

{ TadxContextMenu }

constructor TadxContextMenu.CreateEx(AContainerPane: TadxContainerPane);
begin
  Create(nil);
  FContainerPane:= AContainerPane;
  Alignment:= paRight;
  Items.Clear;
  OwnerDraw:= true;
end;

procedure TadxContextMenu.ItemClick(Sender: TObject);
var
  Index: integer;
  adxForm: TadxForm;
  container: TadxContainer;
begin
  adxForm:= FContainerPane.FAdxControl;
  container:= FContainerPane.FContainer;

  Index:= Items.IndexOf(TadxMenuItem(sender));
  Items[Index].Default:= true;
  if container.GetIndex(adxForm.FormParam) <> index then
    adxForm.AdxExtract(Index);
end;

procedure TadxContextMenu.UpdateItems(adxContainer: TadxContainer; adxForm: TadxForm);
var
  i: integer;
  Index: integer;
  Item: TadxMenuItem;
  pFormItem: PadxContainerForm;

begin
  Index:= -1;
  adxContainer.BeginRequired;
  try
    Items.Clear;
    for i:= 0 to adxContainer.Count-1 do begin
      pFormItem:= PadxContainerForm(adxContainer[i]);
      if adxForm.Handle = pFormItem^.param^.FormHandle then
        Index:= i;
      Item:= TadxMenuItem.CreateEx(FContainerPane, self);

      Item.Caption:= string(pFormItem^.param^.Caption);
      Items.Add(Item);
      Item.OnClick:= ItemClick;
    end;
    if Index >= 0 then
      Items[index].Default:= true;
  finally
    adxContainer.EndRequired;
  end;
end;

{ TadxMenuItem }

procedure TadxMenuItem.AdvancedDrawItem(ACanvas: TCanvas; ARect: TRect;
  State: TOwnerDrawState; TopLevel: Boolean);
begin
  if Assigned(FContainerPane) then
    FContainerPane.DrawMenuItem(ACanvas.Handle, self, ARect, State);
end;

{$IFDEF ADX_VCL5}
procedure TadxMenuItem.MeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
{$ELSE}
procedure TadxMenuItem.MeasureItem(ACanvas: TCanvas; var Width, Height: Integer);
{$ENDIF}
var
  gpFont: TadxGPFont;
  textSize: TSize;
  fontWeight: longint;
  gpGraphics: TadxGPGraphics;
begin
  fontWeight:= FW_NORMAL;
  if Default then
    fontWeight:= FW_BOLD;

  gpFont:= TadxGPFont.Create(ACanvas.Handle, GetSystemFontHandle(MenuFont, fontWeight));
  if gpFont.GDIResult <> Ok then begin
    gpFont.Free;
    UpdateFont;
    gpFont:= TadxGPFont.Create(ACanvas.Handle, FFont.Handle);  
  end;

  gpGraphics:= TadxGPGraphics.Create(ACanvas.Handle);
  try
    GPTextExtent(Caption, gpGraphics, gpFont, textSize);
  finally
    gpFont.Free;
    gpGraphics.Free;
  end;

  Width:= DefaultMenuItemHeight+ textSize.cx+ DefaultTaskButtonWidth;
  if Assigned(FContainerPane) then
    Height:= FContainerPane.TaskMenuItemHeight
  else
    Height:= DefaultMenuItemHeight;
end;

procedure TadxMenuItem.UpdateFont;
begin
  if Default then
    FFont.Style:= [fsBold]
  else
    FFont.Style:= [];
end;

constructor TadxMenuItem.CreateEx(AContainerPane: TadxContainerPane; AOwner: TComponent);
begin
  FContainerPane:= AContainerPane;
  FFont:= TFont.Create;
  if Assigned(FContainerPane) then
    FFont.Assign(FContainerPane.Font);
  Create(AOwner);
  {$IFDEF ADX_VCL5}
  OnMeasureItem:= MeasureItem;
  {$ENDIF}
end;

destructor TadxMenuItem.Destroy;
begin
  if Assigned(FFont) then
    FFont.Free;
  inherited;
end;

{ TadxPanePartSeparator }

procedure TadxPanePartSeparator.Initialize;
begin
  inherited;
  FFloating := false;
  FDefaultHeight := Owner.HeaderHeight- 4;
  FDefaultWidth  := DefaultTaskSeparator;
end;

procedure TadxPanePartSeparator.Paint(ACanvas: TadxGPGraphics);
var
  pen: TadxGPPen;
  clShadow: Cardinal;
begin
  inherited;
  pen:= TadxGPPen.Create(Owner.FItemColor.Border);
  if (Owner.ThemeColorIndex = tmOffice2010_Black) then
    clShadow:= Owner.FBtnColor.Border
  else
    clShadow:= colorWhite;

  if Owner.Preset = tpsDefault then begin
    pen.SetColor(GPSystemColor(COLOR_3DSHADOW));
    clShadow:= colorWhite;
  end;
  try
    case Owner.PaneLayout of
      plVertical: begin
        ACanvas.DrawLine(pen, FBounds.Left+1, FBounds.Top, FBounds.Right-2, FBounds.Top);
        pen.SetColor(clShadow);
        ACanvas.DrawLine(pen, FBounds.Left+1, FBounds.Top+1, FBounds.Right-2, FBounds.Top+1);
      end;
      plHorizontal: begin
        ACanvas.DrawLine(pen, FBounds.Left, FBounds.Top+1, FBounds.Left, FBounds.Bottom-2);
        pen.SetColor(clShadow);
        ACanvas.DrawLine(pen, FBounds.Left+1, FBounds.Top+1, FBounds.Left+1, FBounds.Bottom-2);
      end;
    end;
  finally
    pen.Free;
  end;
end;

{ TadxPanePartGallery }

procedure TadxPanePartGallery.CreateParts;
begin
  inherited;
  if Assigned(FParts) then begin
    FGalleryItems:= TadxPanePartGalleryItems.Create(Owner, self, 0);
    AddPart(TadxPanePartGalleryButtonBack, 2);
    AddPart(FGalleryItems);
    AddPart(TadxPanePartGalleryButtonNext, 1);
  end;
end;

procedure TadxPanePartGallery.Initialize;
begin
  inherited;
  FFloating:= true;
  FBoundsOffsetWidth := 0;
  FBoundsOffsetHeight:= 0;
  FGalleryItems:= nil;
  FDefaultHeight:= Owner.HeaderHeight- 5;
end;

{ TadxPaneGalleryButtonBack }

function TadxPanePartGalleryButtonBack.DefaultWidth: integer;
begin
  result:= inherited DefaultWidth;
//  if FParent is TadxPanePartGallery then begin
//    if Assigned(TadxPanePartGallery(FParent).FGalleryItems) then
//      if TadxPanePartGallery(FParent).FGalleryItems.EnableBack then
//        result:= FDefaultWidth;
//  end;
end;

procedure TadxPanePartGalleryButtonBack.DoAction(Sender: TObject);
begin
  Owner.StartIndex:= Owner.StartIndex-1;
end;

procedure TadxPanePartGalleryButtonBack.Initialize;
begin
  inherited;
  FDefaultWidth:= 8;
  FDefaultHeight:= Owner.HeaderHeight - 5;
  OnClick:= DoAction;
end;

function TadxPanePartGalleryButtonBack.NeedRemove: boolean;
begin
  result:= Owner.StartIndex <= 0;
end;

procedure TadxPanePartGalleryButtonBack.Paint(ACanvas: TadxGPGraphics);
var
  imageIndex: integer;
begin
  imageIndex:= integer(pbMinimize)+ 4;
  if Owner.PaneLayout = plVertical then
    inc(imageIndex, 2);
  Owner.DrawPaneButton(ACanvas, FBounds, Owner.Preset, imageIndex, State, alNone);
end;

{ TadxPaneGalleryButtonNext }

function TadxPanePartGalleryButtonNext.DefaultWidth: integer;
begin
  result:= inherited DefaultWidth;
//  if FParent is TadxPanePartGallery then begin
//    if Assigned(TadxPanePartGallery(FParent).FGalleryItems) then
//      if TadxPanePartGallery(FParent).FGalleryItems.EnableNext then
//        result:= FDefaultWidth;
//  end;
end;

procedure TadxPanePartGalleryButtonNext.DoAction(Sender: TObject);
begin
  Owner.StartIndex:= Owner.StartIndex+ 1;
end;

procedure TadxPanePartGalleryButtonNext.Initialize;
begin
  inherited;
  FDefaultWidth:= 8;
  FDefaultHeight:= Owner.HeaderHeight - 5;
  OnClick:= DoAction;
end;

function TadxPanePartGalleryButtonNext.NeedRemove: boolean;
var
  fItems: TadxPanePartGalleryItems;
begin
  result:= true;
  if FParent is TadxPanePartGallery then begin
    fItems:= TadxPanePartGallery(FParent).FGalleryItems;
    if Assigned(fItems) and Assigned(fItems.FParts) and Assigned(Owner.PaneItems) then begin
      result:= (Owner.StartIndex + fItems.FParts.Count) >= Owner.PaneItems.Count;
    end;
  end;
end;

procedure TadxPanePartGalleryButtonNext.Paint(ACanvas: TadxGPGraphics);
var
  imageIndex: integer;
begin
  imageIndex:= integer(pbMinimize)+ 4;
  case Owner.PaneLayout of
    plVertical:   inc(imageIndex, 3);
    plHorizontal: inc(imageIndex);
  end;
  Owner.DrawPaneButton(ACanvas, FBounds, Owner.Preset, imageIndex, State, alNone);
end;

{ TadxPanePartGalleryItems }

procedure TadxPanePartGalleryItems.CreateParts;
var
  paneItems: TList;
  i: integer;

begin
  inherited CreateParts;
  paneItems:= Owner.PaneItems;
  if (paneItems <> nil) and (paneItems.Count > 0) then begin
    for i := 0 to paneItems.Count- 1 do begin
      with TadxPanePartGalleryItem(AddPart(TadxPanePartGalleryItem, paneItems.Count- i)) do begin
        CurrentItemIndex:= i;
      end; 
    end;
  end
  else
    AddPart(TadxPanePartGalleryItem, 1);
end;

function TadxPanePartGalleryItems.DefaultWidth: integer;
begin
  if Assigned(FParts) and (FParts.Count > 0) then begin
    if Owner.PaneLayout = plVertical then
      result:= FBoundsOffsetHeight*2 + Parts[0].DefaultWidth
    else
      result:= FBoundsOffsetWidth*2 + Parts[0].DefaultWidth;
  end
  else
    result:= FDefaultWidth;
end;

procedure TadxPanePartGalleryItems.Initialize;
begin
  inherited;
  FFloating:= true;
  FBoundsOffsetWidth := 0;
  FBoundsOffsetHeight:= 0;
  FDefaultHeight:= Owner.HeaderHeight- 5;
  FIntervalOffset:= 4;
end;

procedure TadxPanePartGalleryItems.Paint(ACanvas: TadxGPGraphics);
var
  i: integer;
  part: TadxPanePart;
  R: TRect;
begin
  if Assigned(FParts) then begin
    for i:= 0 to FParts.Count- 1 do begin
      part:= Parts[i];
      if Assigned(part) then begin
        part.Paint(ACanvas);
        if i < (FParts.Count- 1) then begin
          R:= part.Bounds;
          case Owner.PaneLayout of
            plVertical:   Owner.DrawSeparator(ACanvas, Rect(R.Left, R.Bottom+1, R.Right, R.Bottom+ FIntervalOffset+ 1));
            plHorizontal: Owner.DrawSeparator(ACanvas, Rect(R.Right+1, R.Top, R.Right+ FIntervalOffset+ 1, R.Bottom));
          end;
        end;
        //part.DrawFrame(ACanvas);
      end;
    end;
  end;
end;

procedure TadxPanePartGalleryItems.UpdateBounds;
begin
  UpdateBounds_1;
end;

procedure TadxPanePartGalleryItems.UpdateBounds_1;
var
  i, w, AWidth, AHeight, reqWidth, layoutWidth, hOffset, vOffset: integer;
  part: TadxPanePart;
  R: TRect;
  lRequiredWidthFromIndex: integer;

  function RequiredWidthFromIndex(AIndex: integer): integer;
  var
    j: integer;
    part: TadxPanePart;
    DefaultWidth: integer;
    RequiredWidth: integer;
  begin
    result:= 0;
    for j:= AIndex to FParts.Count- 1 do begin
      part:= Parts[j];
      if Assigned(part) then begin
        DefaultWidth := part.DefaultWidth;
        RequiredWidth := part.RequiredWidth;
        if j = FParts.Count-1 then
          inc(result, DefaultWidth)
        else
          inc(result, RequiredWidth);
      end;
    end;
  end;

begin
  FStartIndex:= 0;
  FEndIndex:= MAXINT;

  try
  layoutWidth:= Width;
  case Owner.PaneLayout of
    plVertical:   dec(layoutWidth, FBoundsOffsetHeight* 2);
    plHorizontal: dec(layoutWidth, FBoundsOffsetWidth* 2);
  end;

  lRequiredWidthFromIndex := RequiredWidthFromIndex(0);
  while (FStartIndex < Owner.StartIndex) and (FParts.Count > 0) and (lRequiredWidthFromIndex > layoutWidth) do begin
    inc(FStartIndex);
    Parts[0].Free;
    FParts.Delete(0);
  end;

  reqWidth:= 0;
  for i:= 0 to FParts.Count- 1 do begin
    part:= Parts[i];
    if Assigned(part) then begin
      w:= part.RequiredWidth;
      if reqWidth + w > layoutWidth then begin
        w:= part.DefaultWidth;
        if reqWidth + w <= layoutWidth then begin
          FEndIndex:= i;
        end;
        break;
      end
      else begin
        inc(reqWidth, w+ FIntervalOffset);
        FEndIndex:= i;
      end;
    end;
  end;

  while (FParts.Count > 0) and (FParts.Count-1 > FEndIndex) do begin
    Parts[FParts.Count- 1].Free;
    FParts.Delete(FParts.Count- 1);
  end;

  Owner.FStartIndex:= FStartIndex;

  hOffset:= FBounds.Left+ FBoundsOffsetWidth;
  vOffset:= FBounds.Top + FBoundsOffsetHeight;

  if FParts.Count > 0 then
  for i:= 0 to FParts.Count- 1 do begin
    part:= Parts[i];
    part.GetRequiredSize(AWidth, AHeight);
    R:= Rect(0,0,0,0);

    if Assigned(Part) then begin
      case Owner.PaneLayout of
        plVertical: begin
          R.Left:=    hOffset+ ((GetRectWidth(FBounds)- AHeight) div 2);
          R.Top:=     vOffset;
          R.Right:=   R.Left+ AHeight;
          if i = FParts.Count- 1 then
            R.Bottom := FBounds.Bottom- FBoundsOffsetHeight
          else
            R.Bottom := R.Top+ AWidth;
          if GetRectHeight(R) > 0 then
            vOffset := R.Bottom + FIntervalOffset;
        end;
        plHorizontal: begin
          R.Left:=    hOffset;
          R.Top:=     vOffset+ ((GetRectHeight(FBounds) - AHeight) div 2);
          R.Bottom:=  R.Top+ AHeight;
          if i = FParts.Count- 1 then
            R.Right := FBounds.Right- FBoundsOffsetWidth
          else
            R.Right:= R.Left + AWidth;
          if GetRectWidth(R) > 0 then
            hOffset := R.Right + FIntervalOffset;
        end;
      end; { case }

      if GetRectWidth(R) = 0 then begin
        FParts.Remove(Part);
        Part.Free;
      end
      else
        Part.Bounds:= R;
    end;
  end;
  except
    on e: Exception do begin
      Log.AddException('TadxPanePartGalleryItems.UpdateBounds_1: '+e.Message);
      raise e;
    end;
  end;
end;

{ TadxPanePartGalleryItem }

procedure TadxPanePartGalleryItem.CreateParts;
begin
  inherited;
  if Owner.EnableIcon(FCurrentItemIndex) then
    AddPart(TadxPanePartGalleryItemIcon, 2);
  AddPart(TadxPanePartGalleryItemCaption, 1);

//  if (IndexOf >= 0) and (IndexOf < FParent.FParts.Count-1) then
//    AddPart(TadxPanePartGallerySeparator, 0);
end;

function TadxPanePartGalleryItem.DefaultWidth: integer;
begin
  if Assigned(FParts) and (FParts.Count > 0) then begin
    if Owner.PaneLayout = plVertical then
      result:= FBoundsOffsetHeight + Parts[0].DefaultWidth
    else
      result:= FBoundsOffsetWidth + Parts[0].DefaultWidth
  end
  else
    result:= FDefaultWidth;
end;

function TadxPanePartGalleryItem.FindPart(ACursorPos: TPoint): TadxPanePart;
begin
  result:= nil;
  if PtInRect(FBounds, ACursorPos) then
    result:= self;
end;

function TadxPanePartGalleryItem.IndexOf: integer;
begin
  result:= FCurrentItemIndex;
  //result:= FStartIndex+ inherited IndexOf ;
end;

procedure TadxPanePartGalleryItem.Initialize;
begin
  inherited;
  FFloating:= true;
  FBoundsOffsetWidth := 0;
  FBoundsOffsetHeight:= 0;
  case Owner.PaneLayout of
    plVertical:   FBoundsOffsetHeight:= 4;
    plHorizontal: FBoundsOffsetWidth := 4;
  end;
  FIntervalOffset:= 4;
  FDefaultHeight:= Owner.HeaderHeight- 5;
  OnClick:= Owner.DoActionShowForm;
end;

procedure TadxPanePartGalleryItem.Paint(ACanvas: TadxGPGraphics);
var
  br: TadxGPSolidBrush;
  pen: TadxGPPen;
begin
  if Owner.IsActiveIndex(FCurrentItemIndex) then begin
    pen:= TadxGPPen.Create(DarkerColor(Owner.FBtnColor.FocusedEnd, 10));
    br:= TadxGPSolidBrush.Create(Owner.FBtnColor.FocusedEnd);
    ACanvas.FillRectangle(br, MakeRect(FBounds));
    ACanvas.DrawRectangle(pen, MakeRect(FBounds));
    br.Free;
    pen.Free;
  end;

  case state of
    isFocused:  begin
      br:= TadxGPSolidBrush.Create(Owner.FItemColor.Selected);
      ACanvas.FillRectangle(br, MakeRect(FBounds));
      br.Free;
    end;
    isPressed:  begin
      br:= TadxGPSolidBrush.Create(Owner.FItemColor.Pressed);
      ACanvas.FillRectangle(br, MakeRect(FBounds));
      br.Free;
    end
    else begin
      if Owner.IsItemHighlight(FCurrentItemIndex) then begin
        br:= TadxGPSolidBrush.Create(Owner.FBtnColor.FocusedEnd);
        ACanvas.FillRectangle(br, MakeRect(FBounds));
        br.Free;
      end;
    end;
  end;
  inherited Paint(ACanvas);
end;

procedure TadxPanePartGalleryItem.SetCurrentItemIndex(const Value: integer);
begin
  FCurrentItemIndex := Value;
  if Owner.IsActiveIndex(FCurrentItemIndex) then
      FState:= FFixedState
end;

{ TadxPanePartGalleryItemCaption }

procedure TadxPanePartGalleryItemCaption.GetRequiredSize(var AWidth,
  AHeight: integer);
begin
  inherited;
  AWidth:=  RequiredWidth;
  AHeight:= FDefaultHeight;
end;

procedure TadxPanePartGalleryItemCaption.Initialize;
begin
  inherited;
  FFloating:= true;
  FDefaultWidth:= 0;
  FDefaultHeight:= Owner.HeaderHeight- 5;
end;

procedure TadxPanePartGalleryItemCaption.Paint(ACanvas: TadxGPGraphics);
begin
  Owner.DrawPaneTextIndex(ACanvas, FBounds, FParent.IndexOf, FParent.State);
end;

function TadxPanePartGalleryItemCaption.RequiredWidth: integer;
begin
  result:= Owner.GetItemTextSize(FParent.IndexOf).cx + FIntervalOffset;
end;

{ TadxPanePartGalleryItemIcon }

procedure TadxPanePartGalleryItemIcon.Initialize;
begin
  inherited;
  fDefaultHeight := Owner.TaskIconHeight;
  fDefaultWidth  := Owner.TaskIconWidth;
end;

procedure TadxPanePartGalleryItemIcon.Paint(ACanvas: TadxGPGraphics);
begin
  Owner.DrawIconIndex(ACanvas, FBounds, FParent.IndexOf);
end;

{ TadxFormMessageHook }

constructor TadxFormMouseHook.CreateEx(AParent: TadxFormHook);
begin
  FParent:= AParent;
  Create;
end;

function TadxFormMouseHook.MessageHookProc(code: Integer; wParam, lParam: Cardinal): Longint;
var
  msg: TMouseHookStruct;
  RForm, RContainer: TRect;
begin
  if Code = HC_ACTION then begin
    msg:= PMouseHookStruct(Pointer(lParam))^;
    case wParam of
      WM_NCLBUTTONDOWN, WM_NCRBUTTONDOWN, WM_NCMBUTTONDOWN,
      WM_LBUTTONDOWN, WM_RBUTTONDOWN, WM_MBUTTONDOWN: begin
        GetWindowRect(Parent.FormHandle, RForm);
        GetWindowRect(Parent.ContainerHandle, RContainer);
        if (not PtInRect(RForm, msg.pt)) and (not PtInRect(RContainer, msg.pt)) then
          Parent.ContainerHideFloating;
      end;
    end;
  end;
  Result:= CallNextHookEx(HookHandle, Code, wparam, lparam);
end;

{ TadxFormMessageHook }

constructor TadxFormMessageHook.CreateEx(AParent: TadxFormHook);
begin
  FParent:= AParent;
  Create;
end;

function TadxFormMessageHook.MessageHookProc(code: Integer; wParam, lParam: Cardinal): Longint;
var
  msg: TCWPStruct;
begin
  if Code = HC_ACTION then begin
    msg:= PCWPStruct(Pointer(lParam))^;
    case msg.message of
        WM_ACTIVATEAPP: begin
          if msg.wParam = 0 then
            Parent.ContainerHideFloating;
        end;
        WM_NCHITTEST: if not FParent.InProcess then begin
          //if (msg.hwnd = Parent.FormHandle) or (msg.hwnd = Parent.ContainerHandle) then begin
          if not Parent.InProcess then begin
            FParent.MouseCapture:= false;
          end;
        end;
    end;
  end;
  Result:= CallNextHookEx(HookHandle, Code, wparam, lparam);
end;

{ TadxFormHook }

procedure TadxFormHook.ContainerHideFloating;
begin
  SendMessage(ContainerHandle, WM_ADXCONTAINERHIDEFLOATING, FormHandle, 0);
end;

constructor TadxFormHook.Create(AContainerHandle, AFormHandle: HWnd; AInProcess: boolean = true);
begin
  FInProcess:= AInProcess;
  FContainerHandle:= AContainerHandle;
  FFormHandle:= AFormHandle;
  FMouseHook:= TadxFormMouseHook.CreateEx(self);
  FMessageHook:= TadxFormMessageHook.CreateEx(self);
  FMouseCapture := false;
  if not InProcess then
    FMouseLeaveThread:= TadxFormMouseLeave.CreateEx(self)
  else
    FMouseLeaveThread:= nil;
end;

destructor TadxFormHook.Destroy;
begin
  if isWindow(ContainerHandle) then
    ContainerHideFloating;
  if Assigned(FMouseHook) then
    FMouseHook.Free;
  if Assigned(FMessageHook) then
    FMessageHook.Free;
  if Assigned(FMouseLeaveThread) then begin
    FMouseLeaveThread.FreeOnTerminate:= false;
    FMouseLeaveThread.Terminate;
    FMouseLeaveThread.Free;
  end;
  if not InProcess then
    MouseCapture:= false;
  inherited;
end;

procedure TadxFormHook.SetMouseCapture(const Value: boolean);
begin
  if FMouseCapture <> Value then begin
    FMouseCapture := Value;
    if FMouseCapture then
      SetCapture(FormHandle)
    else
      ReleaseCapture;
  end;
end;

{ TadxFormMouseLeave }

constructor TadxFormMouseLeave.CreateEx(AParent: TadxFormHook);
begin
  Create(true);
  FreeOnTerminate:= true;
  Priority:= tpLower;
  FParent:= AParent;
  FMouseLeave:= false;
  FProcessID:= GetCurrentProcessId;
  Resume;
end;

procedure TadxFormMouseLeave.Execute;
var
  pt: TPoint;
  pid: PCardinal;
  handle: HWND;
begin
  GetMem(pid, sizeOf(Cardinal));
  while not Terminated do begin
    GetCursorPos(pt);
    handle:= WindowFromPoint(pt);
    pid^:= 0;
    GetWindowThreadProcessId(handle, pid);
    MouseLeave:= Cardinal(pid^) <> FProcessID;
    sleep(10);
  end;
  FreeMem(pid);
end;

procedure TadxFormMouseLeave.SetMouseLeave(const Value: boolean);
begin
  if FMouseLeave <> Value then begin
    FMouseLeave:= Value;
    if FMouseLeave then
      PostMessage(FParent.FormHandle, WM_ADXMOUSELEAVE, 0, 0);
  end;
end;

{ TadxDragCustomControl }

constructor TadxDragCustomControl.Create;
begin
  if FControls = nil then
    FControls:= TList.Create;
end;

constructor TadxDragCustomControl.Create(AParent: TadxDragCustomControl; AOwner: TadxRegionDragContainer;
  AItemType: TadxItemType; ALayout: TadxWindowLayout; AHandle: HWND);
begin
  FParent     := AParent;
  FOwner      := AOwner;
  FItemType   := AItemType;
  FAppHandle  := AHandle;
  FLayout     := ALayout;
  FControls   := TList.Create;
  FWindowRect := GetLayoutRect(wlClient);
  FSubclassRect := GetLayoutRect(0);
  SetBounds;
end;

destructor TadxDragCustomControl.Destroy;
var
  i: integer;
  control: TadxDragCustomControl;
begin
  if Assigned(FControls) then begin
    if FControls.Count > 0 then
    for i:= 0 to FControls.Count- 1 do begin
      control:= TadxDragCustomControl(FControls[i]);
      if Assigned(Control) then
        control.Free;
    end;
    FreeAndNil(FControls);
  end;
  inherited;
end;

procedure TadxDragCustomControl.DrawFrame(ACanvas: TadxGPGraphics);
var
  Pen: TadxGPPen;
begin
  pen:= TadxGPPen.Create(MakeColor($FF, $00, $00));
  ACanvas.DrawRectangle(pen, MakeRect(FBounds));
  pen.Free;
end;

function TadxDragCustomControl.FindControl(ACursorPos: TPoint): TadxDragCustomControl;
var
  i: integer;
  control: TadxDragCustomControl;
begin
  result:= nil;
  if not Assigned(FControls) then exit;

  if FControls.Count > 0 then begin
    for i:= 0 to FControls.Count- 1 do begin
      control:= TadxDragCustomControl(FControls[i]);
      if Assigned(Control) then begin
        result:= control.FindControl(ACursorPos);
        if result <> nil then
          break;
      end;
    end;
  end
  else begin
    if PtInRect(FBounds, ACursorPos) then
      result:= self;
  end;
end;

procedure TadxDragCustomControl.GetLayoutParams(var param: TadxDragLayoutParams);
begin
  param.Disabled := true;
  param.ItemType := FItemType;
  param.Layout := FLayout;
  param.LayoutSize := 0;
  param.AppHandle := FAppHandle;
end;

function TadxDragCustomControl.GetLayoutRect(LayoutIndex: integer): TRect;
var
  ownerRect: TRect;
  wPos: TWindowPos;
  wInfo: TWindowInfo;
  H: HWND;
begin
  GetWindowRect(FOwner.Handle, ownerRect);
  if SendMessage(AppHandle, WM_ADXGETAPPWINDOWPOS, LayoutIndex, Cardinal(@wPos)) = adxMessageResult then begin
    result.Left   := wPos.x;
    result.Top    := wPos.y;
    result.Right  := wPos.x + wPos.cx;
    result.Bottom := wPos.y + wPos.cy;

    H:= GetParent(AppHandle);
    if H > 0 then begin
      GetWindowInfo(H, wInfo);
      OffsetRect(result, wInfo.rcClient.Left, wInfo.rcClient.Top);
    end;
  end
  else
    GetWindowRect(AppHandle, result);

  OffsetRect(result, -ownerRect.Left, -ownerRect.Top);
end;

procedure TadxDragCustomControl.OffsetExcludeItem(var ARect: TRect);
begin
  if (FOwner.FCurrentItemsCount < 2) and (FAppHandle = FOwner.FCurrentAppHandle) then begin
    case FOwner.FCurrentLayout  of
      wlLeft:   ARect.Left:=  FSubClassRect.Left;
      wlRight:  ARect.Right:= FSubClassRect.Right;
      wlTop: begin
        if FLayout = wlClient then
          ARect.Top:= FSubClassRect.Top;
      end;
      wlBottom: begin
        if FLayout = wlClient then
          ARect.Bottom:= FSubClassRect.Bottom;
      end;
    end;
  end;
end;

procedure TadxDragCustomControl.Paint(ACanvas: TadxGPGraphics);
var
  i: integer;
  control: TadxDragCustomControl;
begin
  if Assigned(FControls) and (FControls.Count > 0) then begin
    for i:= 0 to FControls.Count- 1 do begin
      control:= TadxDragCustomControl(FControls[i]);
      if Assigned(Control) then
        control.Paint(ACanvas);
    end;
  end;
end;

procedure TadxDragCustomControl.SetBounds;
begin

end;

procedure TadxDragCustomControl.SetState(const Value: TadxTaskPaneButtonState);
begin
  if (FState <> Value) then begin
    FState := Value;
    FOwner.CanvasChanged;
    if FState = isFocused then
      FOwner.DoMouseFocused(self);
  end;
end;

{ TadxRegionDragContainer }

function TadxRegionDragContainer.AddItem(dragWindowLayout: TadxDragWindowLayout;
  AItemType: TadxItemType; AWindowHandle: HWND): integer;
begin
  result:= -1;
  if Assigned(FDragControls) then begin
    if AItemType = stOfficeTaskPane then begin
      case dragWindowLayout of
        dwlLeft:  result:= FDragControls.FControls.Add(TadxDragControlCTP.Create(nil, self, AItemType, wlLeft, AWindowHandle));
        dwlRight: result:= FDragControls.FControls.Add(TadxDragControlCTP.Create(nil, self, AItemType, wlRight, AWindowHandle));
        dwlTop:   result:= FDragControls.FControls.Add(TadxDragControlCTP.Create(nil, self, AItemType, wlTop, AWindowHandle));
        dwlBottom:result:= FDragControls.FControls.Add(TadxDragControlCTP.Create(nil, self, AItemType, wlBottom, AWindowHandle));
      end;
    end
    else
    if (AItemType = stOlReadingPane) and (FOSCConnected) then begin
      case dragWindowLayout of
        dwlLeft:  result:= FDragControls.FControls.Add(TadxDragControlRP.Create(nil, self, AItemType, wlLeft, AWindowHandle));
        dwlRight: result:= FDragControls.FControls.Add(TadxDragControlRP.Create(nil, self, AItemType, wlRight, AWindowHandle));
        dwlTop:   result:= FDragControls.FControls.Add(TadxDragControlRP.Create(nil, self, AItemType, wlTop, AWindowHandle));
        dwlBottom:result:= FDragControls.FControls.Add(TadxDragControlRP.Create(nil, self, AItemType, wlBottom, AWindowHandle));
        dwlAll:   result:= FDragControls.FControls.Add(TadxDragControlTotalRP.Create(nil, self, AItemType, wlClient, AWindowHandle));
      end;
    end
    else begin
      case dragWindowLayout of
        dwlLeft:  result:= FDragControls.FControls.Add(TadxDragControl.Create(nil, self, AItemType, wlLeft, AWindowHandle));
        dwlRight: result:= FDragControls.FControls.Add(TadxDragControl.Create(nil, self, AItemType, wlRight, AWindowHandle));
        dwlTop:   result:= FDragControls.FControls.Add(TadxDragControl.Create(nil, self, AItemType, wlTop, AWindowHandle));
        dwlBottom:result:= FDragControls.FControls.Add(TadxDragControl.Create(nil, self, AItemType, wlBottom, AWindowHandle));
        dwlAll:   result:= FDragControls.FControls.Add(TadxDragControlTotal.Create(nil, self, AItemType, wlClient, AWindowHandle));
      end;
    end;
  end
end;

procedure TadxRegionDragContainer.BeginUpdate;
begin
  if fUpdateCount <= 0 then
    fCanvasChanged := false;
  inc(fUpdateCount);
end;

procedure TadxRegionDragContainer.EndUpdate;
var
  graphics: TadxGPGraphics;
begin
  dec(fUpdateCount);
  if fUpdateCount <= 0 then begin
    fUpdateCount := 0;
    if fCanvasChanged then begin
      graphics:= TadxGPGraphics.Create(GetDC(Handle));
      try
        FDragControls.Paint(graphics);
      finally
        fCanvasChanged := false;
        graphics.Free;
      end;
    end;
  end;
end;

procedure TadxRegionDragContainer.CanvasChanged;
begin
  FCanvasChanged:= true;
end;

constructor TadxRegionDragContainer.CreateEx(AOwner: TObject; AFormHandle: HWND);
var
  R, RParent: TRect;
  containerPane: TadxContainerPane;
  wPos: TWindowPos;
  cl: Cardinal;
begin
  CreateParented(GetDesktopWindow);
  FUpdateCount:= 0;
  FContainerPane:= AOwner;
  FFormHandle:= AFormHandle;
  FEnableDragAndDrop:= false;
  FDragControls := TadxDragCustomControl.Create();
  FOldCursor := TadxContainerPane(FContainerPane).Cursor;

  containerPane:= TadxContainerPane(FContainerPane);
  if Assigned(containerPane) and Assigned(containerPane.AdxControl) then begin
    FHostVersion:= containerPane.AdxControl.HostVersion;
    FHostHandle := containerPane.AdxControl.HostHandle;
    FCurrentLayout:= containerPane.AdxControl.Layout;
    FOSCConnected:= containerPane.AdxControl.OSCConnected;
    FCurrentScreenPos:= containerPane.ScreenPos;
    FCurrentPaneHandle:= containerPane.Handle;
    if Assigned(containerPane.AdxControl.AppWindow) then
      FCurrentAppHandle:= containerPane.AdxControl.AppWindow.Handle;
    if Assigned(containerPane.FContainer) then
      FCurrentItemsCount:= containerPane.FContainer.Count;

    if FHostHandle > 0 then begin
      GetWindowRect(FHostHandle, R);
      SetWindowPos(Handle, HWND_TOP, R.Left, R.Top, GetRectWidth(R), GetRectheight(R), SWP_NOACTIVATE);
    end;

    //calculate dragRect
    GetWindowRect(containerPane.AdxControl.AppWindow.Parent, RParent);
    wPos:= containerPane.AdxControl.ScreenPos;
    if ContainerPane.IsMinimizedState then begin
      case containerPane.AdxControl.Layout of
        wlLeft: begin
          dec(wPos.x, containerPane.HeaderHeight);
          inc(wPos.cx, containerPane.HeaderHeight);
        end;
        wlRight: begin
          inc(wPos.cx, containerPane.HeaderHeight);
        end;
        wlTop, wlClient: begin
          dec(wPos.y, containerPane.HeaderHeight);
          inc(wPos.cy, containerPane.HeaderHeight);
        end;
        wlBottom: begin
          inc(wPos.cy, containerPane.HeaderHeight);
        end;
      end;
    end
    else begin
      dec(wPos.y, containerPane.HeaderHeight);
      inc(wPos.cy, containerPane.HeaderHeight);
    end;
    FDragRect := Rect(RParent.Left+ wPos.x, RParent.Top+ wPos.y,
                     RParent.Left+ wPos.x + wPos.cx, RParent.Top+ wPos.y + wPos.cy);
  end;

  FDragPanel:= TadxRegionDragPanel.CreateEx(self);
  if Assigned(ButtonsBitmap) then begin
    ButtonsBitmap.GetPixel(0, 0, cl);
    Color:= ARGBToColorRef(cl);
  end
  else
    Color := clFuchsia;
  TransparencyKey := Color;

  InitializeItems(nil);
  if FEnableDragAndDrop then
    Visible:= true;
end;

function TadxRegionDragContainer.DefaultLayoutSize: TSize;
var
  defSize: TSize;
begin
  result.cx:= 0; result.cy:= 0;
  if SendMessage(FFormHandle, WM_ADXGETFORMDEFAULTSIZE, 0, Cardinal(@defSize)) = adxMessageResult then
    result := defSize;
end;

destructor TadxRegionDragContainer.Destroy;
begin
  if FContainerPane is TadxContainerPane then
    TadxContainerPane(FContainerPane).BlinkCursorEnable:= true;
  if Assigned(FDragPanel) then begin
    FDragPanel.Hide;
    FreeAndNil(FDragPanel);
  end;
  if Assigned(FDragControls) then
    FreeAndNil(FDragControls);
  TadxContainerPane(FContainerPane).Cursor:= FOldCursor;
  inherited;
end;

procedure TadxRegionDragContainer.DoMouseFocused(Sender: TObject);
var
  control: TadxDragCustomControl;
  lrect, rHost: TRect;
  limitSize: integer;
  lParams: TadxDragLayoutParams;
  defSize: TSize;
  msgResult: integer;

begin
  if Sender is TadxDragCustomControl then begin
    control:= TadxDragCustomControl(Sender);
    lrect := control.SubClassRect;

    control.GetLayoutParams(lParams);

    msgResult:= SendMessage(FFormHandle, WM_ADXGETDRAGLAYOUTPARAMS, 0, Cardinal(@lParams));
    if msgResult = adxMessageResult then begin
      if lParams.LayoutSize <= 0 then begin
        defSize:= DefaultLayoutSize;
        case control.Layout of
          wlLeft, wlRight, wlDockLeft, wlDockRight: lParams.LayoutSize := defSize.cx;
          wlTop, wlBottom, wlDockTop, wlDockBottom: lParams.LayoutSize := defSize.cy;
        end;
      end;
    end;

    if (msgResult = adxMessageResult) and (not lParams.Disabled) and ((lParams.LayoutSize > 0) or (lParams.Layout = wlClient)) then begin
      ContainerCursor := AdxCursors.DragValid;
      if control.ItemType = stOfficeTaskPane then begin
        case control.Layout of
          wlLeft: begin
            lrect.Right:= lrect.Left + lParams.LayoutSize;
            control.OffsetExcludeItem(lrect);
          end;
          wlRight: begin
            lrect.Left := lrect.Right - lParams.LayoutSize;
            control.OffsetExcludeItem(lrect);
          end;
          wlTop: begin
            lrect.Bottom := lrect.Top + lParams.LayoutSize;
            inc(lrect.Left, control.WindowRect.Left - control.SubClassRect.Left);
            lrect.Right := lrect.Left + GetRectWidth(control.WindowRect);
          end;
          wlBottom: begin
            lrect.Top := lrect.Bottom - lParams.LayoutSize;
            inc(lrect.Left, control.WindowRect.Left - control.SubClassRect.Left);
            lrect.Right := lrect.Left + GetRectWidth(control.WindowRect);
          end;
        end;
      end
      else
      if (control.ItemType = stOlReadingPane) and (FOSCConnected) then begin
        lrect := control.WindowRect;
        GetExistLayoutRect(control.AppHandle, control.Layout, lRect);
        case control.Layout of
          wlLeft: begin
            limitSize := GetRectWidth(control.SubClassRect) - MinAppWindowWidth;
            if lParams.LayoutSize < limitSize then
              lrect.Right:= lrect.Left + lParams.LayoutSize
            else
              lrect.Right:= lrect.Left + limitSize;
            control.OffsetExcludeItem(lrect);
          end;
          wlRight: begin
            limitSize := GetRectWidth(control.SubClassRect) - MinAppWindowWidth;
            if lParams.LayoutSize < limitSize then
              lrect.Left:= lrect.Right - lParams.LayoutSize
            else
              lrect.Left:= lrect.Right - limitSize;
            control.OffsetExcludeItem(lrect);
          end;
          wlTop: begin
            limitSize := GetRectHeight(control.SubClassRect) - MinAppWindowHeight;
            if lParams.LayoutSize < limitSize then
              lrect.Bottom := lrect.Top + lParams.LayoutSize
            else
              lrect.Bottom := lrect.Top + limitSize;
            control.OffsetExcludeItem(lrect);
          end;
          wlBottom: begin
            limitSize := GetRectHeight(control.SubClassRect) - MinAppWindowHeight;
            if lParams.LayoutSize < limitSize then
              lrect.Top := lrect.Bottom - lParams.LayoutSize
            else
              lrect.Top := lrect.Bottom - limitSize;
            control.OffsetExcludeItem(lrect);
          end;
          wlClient: begin
            lrect := control.WindowRect;
            control.OffsetExcludeItem(lrect);
          end;
        end;
      end
      else begin
        case control.Layout of
          wlLeft: begin
            limitSize := GetRectWidth(lrect) - MinAppWindowWidth;
            if lParams.LayoutSize < limitSize then
               lrect.Right:= lrect.Left + lParams.LayoutSize
            else
               lrect.Right:= lrect.Left + limitSize;
          end;
          wlRight: begin
            limitSize := GetRectWidth(lrect) - MinAppWindowWidth;
            if lParams.LayoutSize < limitSize then
              lrect.Left := lrect.Right - lParams.LayoutSize
            else
              lrect.Left := lrect.Right - limitSize;
          end;
          wlTop: begin
            limitSize := GetRectHeight(lrect) - MinAppWindowHeight;
            if lParams.LayoutSize < limitSize then
              lrect.Bottom := lrect.Top + lParams.LayoutSize
            else
              lrect.Bottom := lrect.Top + limitSize;
            inc(lrect.Left, control.WindowRect.Left - control.SubClassRect.Left);
            lrect.Right := lrect.Left + GetRectWidth(control.WindowRect);
            control.OffsetExcludeItem(lrect);
          end;
          wlBottom: begin
            limitSize := GetRectHeight(lrect) - MinAppWindowHeight;
            if lParams.LayoutSize < limitSize then
              lrect.Top := lrect.Bottom - lParams.LayoutSize
            else
              lrect.Top := lrect.Bottom - limitSize;
            inc(lrect.Left, control.WindowRect.Left - control.SubClassRect.Left);
            lrect.Right := lrect.Left + GetRectWidth(control.WindowRect);
            control.OffsetExcludeItem(lrect);
          end;
          wlClient: begin
            lrect := control.WindowRect;
            control.OffsetExcludeItem(lrect);
          end;
        end;
      end;

      GetWindowRect(FHostHandle, rHost);
      FDragPanel.SetPosition(rHost.Left + lrect.Left, rHost.Top + lrect.Top, GetRectWidth(lrect), GetRectHeight(lrect));
      if not FDragPanel.Visible then
        FDragPanel.Visible := true;
    end
    else begin
      control.State:= isDisabled;
      ContainerCursor := AdxCursors.DragInvalid;
    end;
  end;
end;

procedure TadxRegionDragContainer.DoMouseHover(Sender: TObject);
begin
  if FDragPanel.Visible then
    FDragPanel.Visible := false;
end;

procedure TadxRegionDragContainer.DoMouseSelect(Sender: TObject);
var
  ALayout: integer;
begin
  if Assigned(SelectedControl) and (SelectedControl.State = isFocused) then begin
    ALayout:= SelectedControl.Layout;
    if SelectedControl.ItemType = stOfficeTaskPane then
      ALayout:= ALayout shl 8;
    PostMessage(FFormHandle, WM_ADXSETDRAGFORM, SelectedControl.ItemType, ALayout);
  end;
end;

procedure TadxRegionDragContainer.DrawResourceImage(ACanvas: TadxGPGraphics; X, Y: integer; ALayout: TadxWindowLayout);
var
  imageAttr: TadxGPImageAttributes;
  R: TRect;
begin
  if Assigned(ACanvas) and Assigned(ButtonsBitmap) then begin
    imageAttr:= TadxGPImageAttributes.Create;
    try
      imageAttr.SetColorKey(Color, Color);
      R:= GetResourceBitmapRect(ALayout);
      InflateRect(R, 1, 1);
      ACanvas.DrawImage(ButtonsBitmap,
        MakeRect(X, Y, GetRectWidth(R), GetRectHeight(R)),
        R.Left, R.Top, GetRectWidth(R), GetRectHeight(R), UnitPixel, imageAttr);
    finally
      imageAttr.Free;
    end;
  end;
end;

function TadxRegionDragContainer.GetButtonsBitmap: TadxGPBitmap;
begin
  if not Assigned(FButtonsBitmap) then
    FButtonsBitmap:= TadxGPBitmap.Create(HInstance, 'ADXDRAGBUTTONS');
  result:= FButtonsBitmap;  
end;

function TadxRegionDragContainer.GetExistLayoutRect(AppHandle: HWnd; ALayout: integer; var ARect: TRect): boolean;
var
  pHandle: HWnd;
  R, RHost: TRect;
begin
  Result:= SendMessage(AppHandle, WM_ADXEXISTLAYOUT, ALayout, Integer(@pHandle)) = adxMessageResult;
  if Result then begin
    pHandle:= GetParent(pHandle);
    GetWindowRect(pHandle, R);
    GetWindowRect(FHostHandle, RHost);
    OffsetRect(R, -RHost.Left, -RHost.Top);
    ARect:= R;
  end;
end;

function TadxRegionDragContainer.GetMouseCursorPos: TPoint;
var
  R: TRect;
begin
  GetCursorPos(result);
  GetWindowRect(Handle, R);
  dec(result.X, R.Left);
  dec(result.Y, R.Top);
end;

function TadxRegionDragContainer.GetResourceBitmapRect(layout: TadxWindowLayout): TRect;
begin
  result:= Rect(0, 0, 0, 0);
  case layout of
    wlClient: result:= Rect(0, 0, 88, 88);
    wlLeft:   result:= Rect(100, 0, 132, 29);
    wlRight:  result:= Rect(140, 0, 172, 29);
    wlTop:    result:= Rect(100, 50, 129, 82);
    wlBottom: result:= Rect(140, 50, 169, 82);
  end;
end;

procedure TadxRegionDragContainer.InitializeItems(ItemsPtr: Pointer);
var
  dragItemListHeader: TadxDragItemListHeader;
  dragItem: PadxDragItemParams;
  i: integer;
begin
  if ItemsPtr = nil then begin
    if FFormHandle > 0 then
      SendMessage(FFormHandle, WM_ADXSETDRAGITEMS, Handle, 0);
  end
  else begin
    dragItemListHeader:= PadxDragItemListHeader(ItemsPtr)^;
    FEnableDragAndDrop:= dragItemListHeader.Allowed;

    if FEnableDragAndDrop then
    for i:= 0 to dragItemListHeader.Count- 1 do begin
      dragItem:= @dragItemListHeader.ListItems[i];
      AddItem(dragItem^.DragLayout, dragItem^.ItemType, dragItem^.ItemHandle);
    end;
  end;
end;

procedure TadxRegionDragContainer.MousePassing(mouseOffset: TPoint);
var
  control: TadxDragCustomControl;
begin
  if not FEnableDragAndDrop then exit;
  BeginUpdate;
  control := FDragControls.FindControl(GetMouseCursorPos);
  SelectedControl := control;
  if Assigned(control) then begin
    control.State := isFocused;
    if control.State <> isFocused then
      DoMouseHover(nil);
  end
  else begin
    if FContainerPane is TadxXLContainerPane then
      ContainerCursor := crDefault; //Excel restore default cursor
    ContainerCursor := AdxCursors.DragInvalid;
    DoMouseHover(nil);
  end;
  EndUpdate;
end;

procedure TadxRegionDragContainer.Paint;
var
  graphics: TadxGPGraphics;
begin
  graphics:= TadxGPGraphics.Create(GetDC(Handle));
  try
    FDragControls.Paint(graphics);
  finally
    graphics.Free;
  end;
end;

procedure TadxRegionDragContainer.SetContainerCursor(const Value: TCursor);
begin
  if FContainerCursor <> Value then begin
    FContainerCursor := Value;
    if Assigned(FContainerPane) then begin
      TadxContainerPane(FContainerPane).Cursor:= FContainerCursor;
    end;
  end;
end;

procedure TadxRegionDragContainer.SetSelectedControl(const Value: TadxDragCustomControl);
begin
  if FSelectedControl <> Value then begin
    if Assigned(FSelectedControl) then
      FSelectedControl.State := isUp;
    FSelectedControl := Value;  
  end;
end;

procedure TadxRegionDragContainer.WndProc(var Message: TMessage);
begin
  if Message.Msg = WM_ADXSETDRAGITEMS then begin
    if Pointer(Message.LParam) <> nil then begin
      InitializeItems(Pointer(Message.LParam));
      Message.Result:= adxMessageResult;
    end
    else Message.Result:= 0;
    exit;
  end
  else
  if Message.Msg = WM_PAINT then begin
    Paint;
  end;
  inherited;
end;

{ TadxDragControl }

procedure TadxDragControl.Paint(ACanvas: TadxGPGraphics);
var
  R: TRect;
  pen: TadxGPPen;
begin
  if (FParent = nil) then
    FOwner.DrawResourceImage(ACanvas, FBounds.Left, FBounds.Top, Layout);

  if State = isFocused then begin
    R:= FBounds;
    InflateRect(R, -dragEdgeOffsetClient, -dragEdgeOffsetClient);
    OffsetRect(R, 1, 1);
    if FParent <> nil then
    case FLayout of
      wlLeft, wlRight: OffsetRect(R, 0, -1);
      wlTop, wlBottom: OffsetRect(R, -1, 0);
    end;

    pen:= TadxGPPen.Create(colorWhite);
    ACanvas.DrawRectangle(pen, MakeRect(R));
    pen.Free;
  end;
end;

procedure TadxDragControl.SetBounds;
var
  clientRect: TRect;
begin
  if not IsRectEmpty(SubClassRect) then begin
    FBounds := FOwner.GetResourceBitmapRect(Layout);
    OffsetRect(FBounds, -FBounds.Left, -FBounds.Top);

    if FParent = nil then begin
      case Layout of
        wlLeft: begin
          OffsetRect(FBounds, SubClassRect.Left + dragEdgeOffset,
            SubClassRect.Top + Round( (GetRectHeight(SubClassRect) - GetRectHeight(FBounds)) / 2 ));
        end;
        wlRight: begin
          OffsetRect(FBounds, SubClassRect.Right - dragEdgeOffset - GetRectWidth(FBounds),
            SubClassRect.Top + Round( (GetRectHeight(SubClassRect) - GetRectHeight(FBounds)) / 2 ));
        end;
        wlTop: begin
          OffsetRect(FBounds, SubClassRect.Left + Round( (GetRectWidth(SubClassRect) - GetRectWidth(FBounds)) / 2 ),
            SubClassRect.Top + dragEdgeOffset);
        end;
        wlBottom: begin
          OffsetRect(FBounds, SubClassRect.Left + Round( (GetRectWidth(SubClassRect) - GetRectWidth(FBounds)) / 2 ),
            SubClassRect.Bottom - dragEdgeOffset - GetRectHeight(FBounds));
        end;
        wlClient: begin
          OffsetRect(FBounds, SubClassRect.Left + Round( (GetRectWidth(SubClassRect) - GetRectWidth(FBounds)) / 2),
            SubClassRect.Top + Round( (GetRectHeight(SubClassRect) - GetRectHeight(FBounds)) / 2 ));
        end;
      end;
    end
    else begin
      clientRect := FOwner.GetResourceBitmapRect(wlClient);
      OffsetRect(clientRect, -clientRect.Left, -clientRect.Top);
      OffsetRect(clientRect, SubClassRect.Left + Round( (GetRectWidth(SubClassRect) - GetRectWidth(clientRect)) / 2),
                             SubClassRect.Top + Round( (GetRectHeight(SubClassRect) - GetRectHeight(clientRect)) / 2) );
      case Layout of
        wlLeft: begin
          OffsetRect(FBounds, clientRect.Left,
            clientRect.Top + Round( (GetRectHeight(clientRect) - GetRectHeight(FBounds)) / 2 ));
        end;
        wlRight: begin
          OffsetRect(FBounds, clientRect.Right - GetRectWidth(FBounds),
            clientRect.Top + Round( (GetRectHeight(clientRect) - GetRectHeight(FBounds)) / 2 ));
        end;
        wlTop: begin
          OffsetRect(FBounds, clientRect.Left + Round( (GetRectWidth(clientRect) - GetRectWidth(FBounds)) / 2 ),
            clientRect.Top);
        end;
        wlBottom: begin
          OffsetRect(FBounds, clientRect.Left + Round((GetRectWidth(clientRect) - GetRectWidth(FBounds)) / 2) ,
            clientRect.Bottom - GetRectHeight(FBounds));
        end;
        wlClient: begin
          InflateRect(FBounds, -28, -28);
          OffsetRect(FBounds, -FBounds.Left, -FBounds.Top);
          OffsetRect(FBounds, clientRect.Left + Round( (GetRectWidth(clientRect) - GetRectWidth(FBounds)) / 2 ),
            clientRect.Top + Round( (GetRectHeight(clientRect) - GetRectHeight(FBounds)) / 2 ));
        end;
      end;
    end;
    dec(FBounds.Right);
    dec(FBounds.Bottom);
  end;
end;

{ TadxDragControlTotal }

constructor TadxDragControlTotal.Create(AParent: TadxDragCustomControl; AOwner: TadxRegionDragContainer;
  AItemType: TadxItemType; ALayout: TadxWindowLayout; AHandle: HWND);
begin
  inherited;
  FControls.Add(TadxDragControl.Create(self, AOwner, AItemType, wlLeft, AHandle));
  FControls.Add(TadxDragControl.Create(self, AOwner, AItemType, wlRight, AHandle));
  FControls.Add(TadxDragControl.Create(self, AOwner, AItemType, wlTop, AHandle));
  FControls.Add(TadxDragControl.Create(self, AOwner, AItemType, wlBottom, AHandle));
  FControls.Add(TadxDragControl.Create(self, AOwner, AItemType, wlClient, AHandle));
end;

procedure TadxDragControlTotal.Paint(ACanvas: TadxGPGraphics);
begin
  FOwner.DrawResourceImage(ACanvas, FBounds.Left, FBounds.Top, Layout);
  inherited Paint(ACanvas);
end;

procedure TadxDragControlTotal.SetBounds;
begin
  inherited;
  if not IsRectEmpty(SubClassRect) then begin
    FBounds := FOwner.GetResourceBitmapRect(Layout);
    FBounds.Left := SubClassRect.Left + Round( (GetRectWidth(SubClassRect)  - GetRectWidth(FBounds)) / 2 );
    FBounds.Top  := SubClassRect.Top  + Round( (GetRectHeight(SubClassRect) - GetRectHeight(FBounds)) / 2 );
  end;
end;

{ TadxRegionShadowForm }

constructor TadxRegionShadowForm.Create(AOwner: TComponent);
{$IFDEF ADX_VCL5}
const
  WS_EX_LAYERED = $00080000;
{$ENDIF}
begin
  inherited Create(AOwner);
  Visible:= false;
  FAlphaBlendValue:= 255;
  FTransparencyKey:= $FF000000;
  SetWindowLongCheckUnicode(Handle, GWL_STYLE, WS_OVERLAPPED or WS_CLIPSIBLINGS or WS_CLIPCHILDREN);
  SetExWinAPIProperty(Handle, WS_EX_TOOLWINDOW or WS_EX_LAYERED);
end;

procedure TadxRegionShadowForm.SetAlphaBlendValue(const Value: byte);
begin
  if FAlphaBlendValue <> Value then begin
    FAlphaBlendValue := Value;
    SetLayeredAttributes;
  end;
end;

procedure TadxRegionShadowForm.SetLayeredAttributes;
const
{$IFDEF ADX_VCL5}
  LWA_ALPHA = $00000002;
  LWA_COLORKEY = $00000001;
{$ENDIF}
  cUseAlpha: array [Boolean] of Integer = (0, LWA_ALPHA);
  cUseColorKey: array [Boolean] of Integer = (0, LWA_COLORKEY);
begin
  SetLWA(Handle, FTransparencyKey, FAlphaBlendValue,
    cUseAlpha[FAlphaBlendValue < 255] or cUseColorKey[FTransparencyKey < $01000000]);
end;

procedure TadxRegionShadowForm.SetTransparencyKey(const Value: Cardinal);
begin
  if FTransparencyKey <> Value then begin
    FTransparencyKey := Value;
    SetLayeredAttributes;
  end;
end;

{ TadxRegionDragPanel }

constructor TadxRegionDragPanel.CreateEx(AContainer: TadxRegionDragContainer);
begin
  CreateParented(GetDesktopWindow);
  FContainer:= AContainer;
  Color:= $D17A4D;
  AlphaBlendValue:= 100;
end;

procedure TadxRegionDragPanel.SetPosition(ALeft, ATop, AWidth, AHeight: integer);
begin
  SetWindowPos(Handle, FContainer.Handle, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_HIDEWINDOW);
  SetWindowPos(Handle, FContainer.Handle, ALeft, ATop, AWidth, AHeight, SWP_NOACTIVATE or SWP_SHOWWINDOW);
end;

{ TadxPanePartMenuAndCaptionEx }

procedure TadxPanePartMenuAndCaptionEx.CreateParts;
begin
  inherited;
  if Owner.EnableIcon(-1) then
    AddPart(TadxPanePartIconPlace, 0);
  AddPart(TadxPanePartCaption, 1);
  if Owner.EnableNavigation then
    AddPart(TadxPanePartMenuButton, 2);
end;

function TadxPanePartMenuAndCaptionEx.FindPart(ACursorPos: TPoint): TadxPanePart;
begin
  if PtInRect(FBounds, ACursorPos) then
    result := self
  else
    result:= nil;
end;

procedure TadxPanePartMenuAndCaptionEx.Initialize;
begin
  inherited;
  FIntervalOffset := 0;
  FBoundsOffsetWidth := 0;
  FFloating := true;
  OnClick := Owner.DoActionMenuOpen;
end;

procedure TadxPanePartMenuAndCaptionEx.Paint(ACanvas: TadxGPGraphics);
begin
  Owner.DrawPaneButton(ACanvas, FBounds, Owner.Preset, -1, State, alNone);
  inherited;
end;

procedure TadxPanePartMenuAndCaptionEx.SetState(
  const Value: TadxTaskPaneButtonState);
begin
  if Owner.EnableNavigation then
    inherited SetState(Value);
end;

{ TadxCursors }

procedure TadxCursors.GetCursor(var ACursor: TCursor; ResourceName: string);
var
  cur: HCursor;
begin
  cur:= 0;
  if ACursor = 0 then begin
    try
      cur:= LoadCursor(HInstance, PChar(ResourceName));
    except
    end;
    if cur > 0 then begin
      ACursor:= FIndex;
      Screen.Cursors[ACursor]:= cur;
      inc(FIndex);
    end;
  end;
end;

constructor TadxCursors.Create;
begin
  FIndex:= 1;
end;

destructor TadxCursors.Destroy;
begin
  if (FDragValid <> 0) and (FDragValid <> crDefault) then
    DestroyCursor(FDragValid);
  if (FDragInvalid <> 0) and (FDragInvalid <> crDefault) then
    DestroyCursor(FDragInvalid);
  inherited;
end;

function TadxCursors.GetDragInvalid: TCursor;
begin
  if FDragInvalid = 0 then
    GetCursor(FDragInvalid, 'ADXDRAGINVALID');
  Result:= FDragInvalid;
end;

function TadxCursors.GetDragValid: TCursor;
begin
  if FDragValid = 0 then
    GetCursor(FDragValid, 'ADXDRAGVALID');
  Result:= FDragValid;
end;

{ TadxPPCustomForm }

procedure TadxPPCustomForm.CreateAdxObjectsInstances;
var
  fThemeColor: TadxPPThemeColor;
begin
  fThemeColor:= TadxPPThemeColor.Create;

  FFormRegion:= TadxFormRegion.Create(Self);
  FTheme:= TadxTheme.CreateEx(fThemeColor);
  FAppWindow := TAppWindow.CreateEx(self);
  FContainer := TadxContainer.CreateEx(Self);
  FContainerPane:= TadxPPContainerPane.CreateEx(FContainer);
end;

{ TadxPPThemeColor }

constructor TadxPPThemeColor.Create;
begin
  inherited;
//  clWndFrameBlue            := MakeColor($B9, $D4, $F9);
//  clWndFrameHomeStead       := MakeColor($FF, $FF, $FF);
//  clWndFrameMetallic        := MakeColor($FF, $FF, $FF);
//  clWndFrameClassic         := MakeColor($EA, $E8, $EA);

  clXPBlueWndFrame            := MakeColor($7B, $A4, $E0);
  clXPHomeSteadWndFrame       := MakeColor($B5, $C4, $8F);
  clXPMetallicWndFrame        := MakeColor($99, $97, $B5);
  clXPClassicWndFrame         := MakeColor($D0, $CC, $C4);
  clXPBlueWndBack             := MakeColor($C4, $DA, $FA);
  clXPHomeSteadWndBack        := MakeColor($F2, $F1, $E4);
  clXPMetallicWndBack         := MakeColor($F3, $F3, $F7);
  clXPClassicWndBack          := GPSystemColor(COLOR_BTNFACE);
end;

{ TadxPPContainerPane }

procedure TadxPPContainerPane.DrawPaneFrame(ACanvas: TadxGPGraphics; ARect: TRect; Depth: integer; mode: TDrawMode);
var
  R: TRect;
begin
  if Depth > 0 then begin
    R:= Rect(ARect.Left, ARect.Top, ARect.Right-1, ARect.Bottom);
    case mode of
      drwThemed: DrawFrame(ACanvas, R, Depth, FWndColor.Border);
      drwSimple: DrawFrame3D(ACanvas, R, Depth, BDR_RAISEDINNER, BF_TOPLEFT or BF_BOTTOMRIGHT);
    end;
  end;
end;

procedure TadxPPContainerPane.DrawSplitter(ACanvas: TadxGPGraphics; ARect: TRect);
begin
  case AdxControl.HostVersion of
    v2007, v2010:
      DrawBackGround(ACanvas, ARect, drwThemed)
    else
      inherited;
  end;
end;

function TadxPPContainerPane.GetAdxThemeColorClass: TadxThemeColorClass;
begin
  result:= TadxPPThemeColor;
end;

function TadxPPContainerPane.GetPaneOffset: TRect;
begin
  result := inherited GetPaneOffset;
  if toDraw2007 in Options then
    result.Top := 0
  else
  if AdxControl.Layout <> wlBottom then
    result.Top := 2;
end;

function TadxPPContainerPane.GetPositionInZOrder: LongWord;
begin
  result:= HWND_BOTTOM;
end;

procedure TadxPPContainerPane.Initialize(AppVersion, ItemType: integer; AHostHandle: HWND);
begin
  inherited Initialize(AppVersion, ItemType, AHostHandle);
  case AppVersion of
    v2007,
    v2010: begin
      Options := [toDraw2007];
      Preset  := tpsXP;
    end;
  end;
end;

{ TAppWindowBehaviour }

class function TAppWindowBehaviour.GetSingleton: TAppWindowBehaviour;
begin
  result := AppWindowBehaviourSingleton;
end;

class procedure TAppWindowBehaviour.HideAllFormsInAllAddins(WindowHandle: HWND);
var
  resMessage: integer;
begin
  Log.AddMessage('TAppWindowBehaviour.HideAllFormsInAllAddins');
  if (WindowHandle <> 0) then begin
    SendMessage(WindowHandle, WM_ADXHIDEALLREGIONFORMS, 0, 0);
    resMessage := SendMessage(WindowHandle, WM_ADXEXIST, 0, 0);
    if (resMessage = Globals.adxMessageResultValue) then begin
      Log.AddWarning('TAppWindowBehaviour.HideAllFormsInAllAddins: CheckADXMessageResult Error');
    end;
  end;
end;

procedure TAppWindowBehaviour.HIDE_WHEN_WINDOWPOSCHANGING(
  appWindow: TAppWindow);
begin
  //
end;

class procedure TAppWindowBehaviour.SetSingleton(
  AAppWindowBehaviour: TAppWindowBehaviour);
begin
  if Assigned(AppWindowBehaviourSingleton) then begin
    raise SysUtils.Exception.Create('AppWindowBehaviourSingleton already exists.');
  end;
  AppWindowBehaviourSingleton := AAppWindowBehaviour;
end;

procedure TAppWindowBehaviour.SHOW_WHEN_WINDOWPOSCHANGING(
  appWindow: TAppWindow);
begin
  //
end;

class procedure TAppWindowBehaviour.SingletonFree;
begin
  if Assigned( AppWindowBehaviourSingleton) then begin
    AppWindowBehaviourSingleton.Free;
    AppWindowBehaviourSingleton := nil;
  end;
end;

procedure TAppWindowBehaviour.WM_DESTROY(hWnd: THandle; Msg: UINT; wParam,
  lParam: Integer; appWindow: TAppWindow);
var
  awp: PAppWindowProperty;
begin
  //Outlook realization
  Log.AddMessage('TAppWindowBehaviour.WM_DESTROY');
  awp := PAppWindowProperty(appWindow.FOwner.FAppWindowProperty);
  Log.AddMessage('TAppWindow.WndProc.WM_DESTROY send WM_ADX_DESTROY_EMBEDED_WINDOW ' + appWindow.FOwner.FormID);
  SendMessage(awp^.ReceiverHandle, WM_ADX_DESTROY_EMBEDED_WINDOW, awp^.HostHandle, awp^.WindowHandle);
end;

procedure TAppWindowBehaviour.WM_PARENTNOTIFY_DESTROY(hWnd: THandle; Msg: UINT;
  wParam, lParam: Integer; appWindow: TAppWindow);
begin
  //Outlook realization
  if (not IsWindowVisible(PAppWindowProperty(appWindow.owner.FAppWindowProperty)^.HostHandle)) then begin
    Log.AddMessage('AppWindow.wndproc: WM_PARENTNOTIFY - SendMessage(WM_ADX_READING_PANE_HIDE_FROM_SBCLS) ' + appWindow.owner.FormID);
    SendMessage(PAppWindowProperty(appWindow.owner.FAppWindowProperty)^.ReceiverHandle,
      WM_ADX_READING_PANE_HIDE_FROM_SBCLS,
      PAppWindowProperty(appWindow.owner.FAppWindowProperty)^.HostHandle, stOlReadingPane);
  end;
end;

procedure TAppWindowBehaviour.WM_SHOWWINDOW_HIDE(hWnd: THandle; Msg: UINT;
  wParam, lParam: Integer; appWindow: TAppWindow);
begin
 //
end;

procedure TAppWindowBehaviour.WM_SHOWWINDOW_SHOW(hWnd: THandle; Msg: UINT;
  wParam, lParam: Integer; appWindow: TAppWindow);
begin
 //
end;

{ TAppScrollWindow }

constructor TAppScrollWindow.CreateEx(AHandle: THandle);
begin
  FHandle:= 0;
  Create;
  Handle:= AHandle;
end;

destructor TAppScrollWindow.Destroy;
begin
  Handle:= 0;
  inherited;
end;

procedure TAppScrollWindow.SetHandle(const Value: HWND);
begin
  if FHandle <> Value then begin
      if Value > 0 then begin
        OldWindowProc:= Pointer(GetWindowLongCheckUnicode(Value, GWL_WNDPROC));
        if CallWindowProc(OldWindowProc, Value, WM_ADXEXIST, 0, 0) <> adxMessageResult then begin
          SetWindowLongCheckUnicode(Value, GWL_WNDPROC, Cardinal(NewWindowProc));
          FHandle:= Value;
        end
        else
          OldWindowProc:= nil;
      end
      else begin
        if (FHandle > 0) and (OldWindowProc <> nil) then
          SetWindowLongCheckUnicode(FHandle, GWL_WNDPROC, Cardinal(OldWindowProc));
        FHandle:= 0;
        OldWindowProc:= nil;
      end;
  end;
end;

function TAppScrollWindow.WndProc(hWnd: THandle; Msg: UINT; wParam,
  lParam: Integer): Cardinal;
begin
  if Msg = WM_SETREDRAW then begin
    Result:= 0;
    Handle:= 0;
  end
  else
  if Msg = WM_ADXEXIST then begin
    Result:= adxMessageResult;
  end
  else
    Result:= inherited WndProc(hWnd, Msg, wParam, lParam);
end;

{ TAppHostWindow }

constructor TAppHostWindow.CreateEx(AOwner: TadxCustomHook);
begin
  FOwner:= AOwner;
  Create;
end;

destructor TAppHostWindow.Destroy;
begin
  Active:= false;
  inherited;
end;

procedure TAppHostWindow.SetActive(const Value: boolean);
begin
  if FActive <> Value then begin
    if FHandle > 0 then begin
      if Value then begin
        OldWindowProc:= Pointer(GetWindowLongCheckUnicode(FHandle, GWL_WNDPROC));
        SetWindowLongCheckUnicode(FHandle, GWL_WNDPROC, Cardinal(NewWindowProc));
      end
      else begin
        SetWindowLongCheckUnicode(FHandle, GWL_WNDPROC, Cardinal(OldWindowProc));
      end;
    end;
    FActive := Value;
  end;
end;

procedure TAppHostWindow.SetHandle(const Value: HWND);
begin
  if FHandle <> Value then begin
    Active:= false;
    FHandle:= Value;
    Active:= true;
  end;
end;

function TAppHostWindow.WndProc(hWnd: THandle; Msg: UINT; wParam,
  lParam: Integer): Cardinal;
begin
  result:= inherited WndProc(hWnd, Msg, wParam, lParam);
end;

procedure APIInitialize;
begin
  adxGdiPAPI.StartupGDI;
  OleInitialize(nil);
end;

procedure APIFinalize;
begin
  OleUninitialize;
  adxGdiPAPI.ShutdownGDI;
end;

{ TadxPanePartSplitter }

procedure TadxPanePartSplitter.CreateParts;
begin
  inherited;
  FSplitterButton:= nil;

  if (not Owner.IsMinimizedState) {and (not Owner.EnableSplitterResize)} then
  if Owner.IsSplitButtonVisible or Owner.IsHiddenState then begin
    FSplitterButton:= TadxPanePartSplitterButton.Create(Owner, self, 0);
    AddPart(FSplitterButton);
  end;
end;

procedure TadxPanePartSplitter.DoMouseHover(sender: TObject; Param: integer; MousePt: TPoint);
var
  mCursor: TCursor;
begin
  inherited;
  if Param = WM_MOUSEMOVE then begin
    mCursor:= crDefault;
    case Owner.FormLayout of
      wlLeft, wlRight: mCursor:= crHSplit;
      wlTop, wlBottom: mCursor:= crVSplit;
    end;
    Owner.SetMouseCursor(mCursor);
  end;
end;

destructor TadxPanePartSplitter.Destroy;
begin
  if FParent is TadxPanePartMain then
    TadxPanePartMain(FParent).FSplitterPart:= nil;
  inherited;
end;

procedure TadxPanePartSplitter.DoMouseDblClick(sender: TObject; Param: integer; MousePt: TPoint);
begin
  if Assigned(FSplitterButton) then
    inherited DoMouseDblClick(sender, Param, MousePt);
end;

procedure TadxPanePartSplitter.DoMouseDown(sender: TObject; Param: integer; MousePt: TPoint);
begin
  inherited;
  Owner.CreateSplitterRuler(FBounds);
end;

function TadxPanePartSplitter.FindPart(ACursorPos: TPoint): TadxPanePart;
var
  btnRect: TRect;
begin
  Result:= nil;
  if Assigned(FSplitterButton) then begin
    btnRect:= FSplitterButton.Bounds;
    InflateRect(btnRect, 1, 1);
    if PtInRect(btnRect, ACursorPos) then
      Result:= FSplitterButton;
  end;
  if Result = nil then
    if PtInRect(FBounds, ACursorPos) then
      Result:= self;
end;

procedure TadxPanePartSplitter.Initialize;
begin
  inherited;
  FEnableDrag:= false;
  FOnDblClick:= Owner.DoActionHide;
end;

procedure TadxPanePartSplitter.Paint(ACanvas: TadxGPGraphics);
begin
  Owner.DrawSplitter(ACanvas, FBounds);
  if Assigned(FSplitterButton) then
    FSplitterButton.Paint(ACanvas);
end;

procedure TadxPanePartSplitter.SetState(const Value: TadxTaskPaneButtonState);
begin
  if (FState <> Value) then begin
    FState := Value;
    if FState = isUp then
      Owner.SetMouseCursor(crDefault);
  end;
end;

procedure TadxPanePartSplitter.UpdateBounds;
var
  R: TRect;
  AWidth, AHeight: integer;
begin
  if Assigned(FSplitterButton) then begin
    R:= Rect(0, 0, 0, 0);
    if Owner.IsHiddenState then
      R:= FBounds
    else begin
      AWidth:= GetRectWidth(FBounds);
      AHeight:= GetRectHeight(FBounds);
      case Owner.FormLayout of
        wlLeft, wlRight: R:= Rect(0, Round(AHeight/ 2)- spltButtonSize, 3, Round(AHeight/ 2)+ spltButtonSize);
        wlBottom, wlTop: R:= Rect(Round(AWidth/ 2)- spltButtonSize, 0, Round(AWidth/ 2)+ spltButtonSize, 3);
      end;
      OffsetRect(R, fBounds.Left, fBounds.Top);
    end;
    FSplitterButton.Bounds:= R;
  end;
end;

{ TadxPanePartFormArea }

destructor TadxPanePartFormArea.Destroy;
begin
  if FParent is TadxPanePartMain then
    TadxPanePartMain(FParent).FFormAreaPart:= nil;
  inherited;
end;

function TadxPanePartFormArea.FindPart(ACursorPos: TPoint): TadxPanePart;
begin
  Result:= nil;
end;

procedure TadxPanePartFormArea.Initialize;
begin
  inherited;
  FEnableDrag:= false;
end;

procedure TadxPanePartFormArea.Paint(ACanvas: TadxGPGraphics);
begin
  Owner.DrawBorder(ACanvas, Rect(fBounds.Left, fBounds.Top, FBounds.Right-1, FBounds.Bottom-1), 1);
end;

procedure TadxPanePartFormArea.UpdateBounds;
var
  bSize: integer;
begin
  bSize:= Owner.RegionBorderSize;
  FClientBounds:= FBounds;
  if bSize > 0 then
    InflateRect(FClientBounds, -bSize, -bSize)
  else begin
    if Owner.IsHeaderVisible then
      inc(FClientBounds.Top);
  end;
  Owner.UpdateFormPosition(FClientBounds);
end;

procedure TadxPanePartFormArea.UpdateRegion(ARegion: TadxGPRegion; X, Y: integer);
begin
  if not Owner.IsMinimizedState then begin
    ARegion.Exclude(MakeRect(ClientBounds.Left+ X, ClientBounds.Top+ Y, GetRectWidth(ClientBounds), GetRectHeight(ClientBounds)));
  end;
end;

{ TadxPanePartSplitterButton }

procedure TadxPanePartSplitterButton.DoMouseHover(sender: TObject;
  Param: integer; MousePt: TPoint);
begin
  inherited;
  if Param = WM_MOUSEMOVE then begin
    Owner.SetMouseCursor(crDefault);
  end;
end;

procedure TadxPanePartSplitterButton.Initialize;
begin
  inherited;
  FEnableDrag:= false;
  FOnClick:= Owner.DoActionHide;
end;

procedure TadxPanePartSplitterButton.Paint(ACanvas: TadxGPGraphics);
begin
  Owner.DrawSplitterButton(ACanvas, FBounds, FState);
end;

{ TadxSplitterRuler }

constructor TadxSplitterRuler.Create(AOwner: TadxContainerPane; ASplitBounds: TRect);
begin
  FOwner:= AOwner;
  FBounds:= ASplitBounds;
  FSplitMotion:= FOwner.GetSplitMotion;
end;

procedure TadxSplitterRuler.DoMouseDown(Param: integer; MousePt: TPoint);
var
  R, RParent: TRect;
begin
  OldPos:= Point(0,0);
  if (not FOwner.IsMinimizedState) and (not FOwner.EnableSplitterResize) then begin
    FMouseDown:= true;
    FDownPos:= MousePt;
    FClipRect:= FOwner.GetClipRect;

    FMoveRect:= FBounds;
    GetWindowRect(FOwner.FAppWindow.Parent, RParent);
    GetWindowRect(FOwner.Handle, R);
    OffsetRect(FMoveRect, R.Left- RParent.Left, R.Top- RParent.Top);

    FSplitMove:= true;
    if FSplitMotion <> smDragging then
      FOwner.DrawMoveSplitter(OldPos, FMoveRect, false);
  end;
end;

procedure TadxSplitterRuler.DoMouseMove(Param: integer; MousePt: TPoint);
var
  P: TPoint;
begin
  if (param = MK_LBUTTON) and FMouseDown and FSplitMove then begin
    P:= Point(MousePt.X- FDownPos.X, MousePt.Y- FDownPos.Y);
    if VerifyConstrains(P) then begin
      if FSplitMotion <> smDragging then begin
        FOwner.DrawMoveSplitter(OldPos, FMoveRect, false);
        FOwner.DrawMoveSplitter(P, FMoveRect, false);
        OldPos:= P;
      end
      else begin
        if not FSplitterDragging then begin
          FSplitterDragging := true;
          FOwner.SetSplitterMove(P.X, P.Y);
          FOwner.SyncAdxRefresh;
          FOwner.SetSplitterMove(0, 0);
          FSplitterDragging := false;
        end;
      end;
    end;
  end;
end;

procedure TadxSplitterRuler.DoMouseUp(Param: integer; MousePt: TPoint);
begin
  if FSplitMove and (not FOwner.EnableSplitterResize) then begin
    FMouseDown:= false;
    if FSplitMotion <> smDragging then begin
      FOwner.DrawMoveSplitter(OldPos, FMoveRect, true);
      FOwner.SyncAdxRefresh;
    end;
    FOwner.SetSplitterMove(0, 0);
  end;
end;

function TadxSplitterRuler.VerifyConstrains(ASplitPos: TPoint): boolean;
var
  clipRect, R, paneRect: TRect;
  appHandle: Cardinal;
begin
  Result:= true;
  if Assigned(FOwner.AdxControl) then
    Result:= FOwner.AdxControl.VerifyConstrains(ASplitPos);

  if Result and Assigned(FOwner.FAppWindow) then begin
    appHandle:= FOwner.FAppWindow.Handle;
    if SendMessage(FOwner.FAppWindow.Handle, WM_ADXEXISTLAYOUT, wlClient, Cardinal(@appHandle)) <> adxMessageResult then
      appHandle:= FOwner.FAppWindow.Handle;

    GetWindowRect(appHandle, clipRect);
    GetWindowRect(FOwner.Handle, paneRect);
    GetWindowRect(FOwner.FAppWindow.Parent, R);
    OffsetRect(clipRect, -R.Left, -R.Top);
    OffsetRect(paneRect, -R.Left, -R.Top);

    case FOwner.FormLayout of
      wlLeft: begin
        dec(clipRect.Left, FOwner.ScreenPos.cx);
        clipRect.Top:= paneRect.Top;
        clipRect.Bottom:= paneRect.Bottom;
        InflateRect(clipRect, -MinAppWindowWidth, 0);
      end;
      wlRight: begin
        inc(clipRect.Right, FOwner.ScreenPos.cx);
        clipRect.Top:= paneRect.Top;
        clipRect.Bottom:= paneRect.Bottom;
        InflateRect(clipRect, -MinAppWindowWidth, 0);
      end;
      wlTop: begin
        dec(clipRect.Top, FOwner.ScreenPos.cy);
        if FOwner.IsHeaderVisible then
          inc(clipRect.Top, FOwner.HeaderHeight- MinAppWindowHeight);
        InflateRect(clipRect, 0, -MinAppWindowHeight);
      end;
      wlBottom: begin
        inc(clipRect.Bottom, FOwner.ScreenPos.cy);
        if FOwner.IsHeaderVisible then
          dec(clipRect.Bottom, FOwner.HeaderHeight- MinAppWindowHeight);
        InflateRect(clipRect, 0, -MinAppWindowHeight);
      end;
    end;
    Result:= PtInRect(clipRect, Point(ASplitPos.X+ FDownPos.X+ paneRect.Left, ASplitPos.Y+ FDownPos.Y+ paneRect.Top));
  end;
end;

{ TWatchObject }

constructor TWatchObject.Create;
begin
  FStopWatch := false;
  isExecute := false;
  FWatchEngineIsHook := false;
end;

destructor TWatchObject.Destroy;
begin
  Log.AddMessage(self.ClassName + '(TWatchObject).Destroy');
  inherited;
end;

procedure TWatchObject.END_WM_SETREDRAW(window: HWND);
begin
  //
end;

procedure TWatchObject.Execute;
begin
  try
    if isExecute then begin
      exit;
    end;

    isExecute := true;
    try
      DoExecute;
    finally
      isExecute := false;
    end;
  except
    on E: SysUtils.Exception do begin
      Log.AddException(self.ClassName + ' Execute.Exception: ' + E.Message);
      self.StopWatch := true;
    end;
  end;
end;

function TWatchObject.GetHostHandle: HWND;
begin
  result := 0;
end;

function TWatchObject.GetPause: boolean;
begin
  result := FPause;
end;

function TWatchObject.GetStopWatch: boolean;
begin
  result := FStopWatch;
end;

function TWatchObject.GetWatchEngineIsHook: boolean;
begin
  result := FWatchEngineIsHook;
end;

function TWatchObject.GetWindowHandle: HWND;
begin
  result := 0;
end;

procedure TWatchObject.ProcessHookEvent(hWnd: THandle; Msg: UINT; wParam,
  lParam: Integer);
begin
  //
end;

procedure TWatchObject.SetPause(const Value: boolean);
begin
  FPause := Value;
end;

procedure TWatchObject.SetStopWatch(const Value: boolean);
begin
  if (Value) then begin
    if Assigned(FStoppingWatchObject) then begin
      FStoppingWatchObject(self);
    end;
  end;
  FStopWatch := Value;
end;

procedure TWatchObject.SetWatchEngineIsHook(const Value: boolean);
begin
  FWatchEngineIsHook := value;
end;

{ TadxOLIntercept }

constructor TadxIntResource.Create(AOwner: TadxOLHook);
var
{$IFNDEF ADX_DEBUG}
  stream: TResourceStream;
{$ENDIF}
  lpBuffer: array [0..1023] of char;
begin
  FOwner:= AOwner;
  FNeedFree:= false;

  GetTempPath(1024, @lpBuffer);
  {$IFNDEF ADX_DEBUG}
  FModuleName:= string(lpBuffer)+ AdxResourceLib;
  {$ELSE}
  FModuleName:= 'c:\temp\'+ AdxResourceLib;
  {$ENDIF}

  {$IFNDEF ADX_DEBUG}
  if not FileExists(FModuleName) then begin
    stream:= TResourceStream.Create(HInstance, 'ADXINTRESOURCE', RT_RCDATA);
    stream.SaveToFile(FModuleName);
    stream.Free;
  end;
 {$ENDIF}

  FIntModule:= LoadLibrary(PChar(FModuleName));
  FNeedFree:= true;

  if FIntModule > 0 then begin
    IntUpdateOLExplorerParam:= GetProcAddress(FIntModule, PChar('UpdateOLExplorerParam'));
    IntAddCTP:= GetProcAddress(FIntModule, PChar('AddCTP'));
    IntDeleteCTP:= GetProcAddress(FIntModule, PChar('DeleteCTP'));
    IntUpdateCTP:= GetProcAddress(FIntModule, PChar('UpdateCTP'));
    IntUpdateCompatibility:= GetProcAddress(FIntModule, PChar('UpdateCompatibility'));
  end;
end;

destructor TadxIntResource.Destroy;
begin
  if FNeedFree and (FIntModule > 0) then begin
    FreeLibrary(FIntModule);
    FIntModule:= 0;
    {$IFNDEF ADX_DEBUG}
    if FModuleName <> '' then
      DeleteFile(PChar(FModuleName));
    {$ENDIF}
  end;
  inherited;
end;

function TadxIntResource.DoAddCTP(const CTPFactory: IDispatch; const CTPParentWindow: IDispatch; PCTPParam: PAdxCTPParams): HResult;
begin
  Result:= S_FALSE;
  if Assigned(IntAddCTP) then
    Result:= IntAddCTP(CTPFactory, CTPParentWindow, Cardinal(PCTPParam));
end;

function TadxIntResource.DoDeleteCTP(position: integer; const CTPParentWindow: IDispatch): Hresult;
begin
  Result:= S_FALSE;
  if Assigned(IntDeleteCTP) then
    Result:= IntDeleteCTP(position, CTPParentWindow);
end;

function TadxIntResource.DoUpdateCompatibility(CFunc, PCParam: Cardinal): HResult;
begin
  Result:= S_FALSE;
  if Assigned(IntUpdateCompatibility) then
    Result:= IntUpdateCompatibility(CFunc, PCParam);
end;

function TadxIntResource.DoUpdateCTP(const CTPParentWindow: IDispatch; PCTPParam: PAdxCTPParams): HResult;
begin
  Result:= S_FALSE;
  if Assigned(IntUpdateCTP) then
    Result:= IntUpdateCTP(CTPParentWindow, Cardinal(PCTPParam));
end;

procedure TadxIntResource.DoUpdateOLExplorerParam(ARegionHandle: Hwnd;
  ARegionPos: TWindowPos);
begin
  if Assigned(IntUpdateOLExplorerParam) then
    IntUpdateOLExplorerParam(ARegionHandle, ARegionPos);
end;

procedure TWatchObject.START_WM_SETREDRAW(window: HWND);
begin
  //
end;

{ TadxRegionStateGuard }

constructor TadxRegionStateGuard.Create;
begin
  FLockCount := 0;
end;

class procedure TadxRegionStateGuard.FreeRegionStateInstance;
begin
  if (RegionStateGuard <> nil) then begin
    RegionStateGuard.Free;
    RegionStateGuard := nil;
  end;
end;

class function TadxRegionStateGuard.Instance: TadxRegionStateGuard;
begin
  if (RegionStateGuard = nil) then begin
    RegionStateGuard := TadxRegionStateGuard.Create;
  end;
  result := RegionStateGuard;
end;

function TadxRegionStateGuard.IsLock: boolean;
begin
  result := (FLockCount > 0);
end;

procedure TadxRegionStateGuard.Lock;
begin
  inc(FLockCount);
end;

procedure TadxRegionStateGuard.UnLock;
begin
  dec(FLockCount);
end;

{ TadxEventRaising }

constructor TadxEventRaising.Create(AEventName: string; AOptions: TadxEventOptions);
begin
  FOptions := AOptions;
  FEventName := AEventName;
  Log.AddMessage('raise ' + FEventName);
  if (IsLockRegionState) then begin
    Log.AddMessage('RegionState Lock: ' + FEventName);
    TadxRegionStateGuard.Instance.Lock;
  end;
  if (IsLockRefreshInspectorTab) then begin
    Log.AddMessage('RefreshInspectorTab Lock: ' + FEventName);
    TadxRefreshInspectorTabStateGuard.Instance.Lock;
  end;
end;

destructor TadxEventRaising.Destroy;
begin
  Log.AddMessage('after ' + FEventName + ' raising');
  if (IsLockRegionState) then begin
    TadxRegionStateGuard.Instance.UnLock();
    Log.AddMessage('RegionState UnLock: ' + FEventName);
  end;
  if (IsLockRefreshInspectorTab) then begin
    TadxRefreshInspectorTabStateGuard.Instance.UnLock();
    Log.AddMessage('RefreshInspectorTab UnLock: ' + FEventName);
  end;
  inherited;
end;

function TadxEventRaising.IsLockRefreshInspectorTab: boolean;
begin
  result := (eoLockRefreshInspectorTab in FOptions);
end;

function TadxEventRaising.IsLockRegionState: boolean;
begin
  result := (eoLockRegionState in FOptions);
end;

{ TFindWindowFactory }

class function TFindWindowFactory.CreateFindWindowObject(
  ItemType: TadxItemType): TFindWindowObject;
begin
  if (GetSingleton <> nil) then begin
    result := GetSingleton.CreateSpecificFindWindowObject(ItemType);
  end
  else begin
    raise SysUtils.Exception.Create('FindWindowFactory.GetFindWindowObject: Singleton is null.');
  end;
end;

function TFindWindowFactory.CreateSpecificFindWindowObject(
  ItemType: TadxItemType): TFindWindowObject;
begin
  result := nil;
end;

class function TFindWindowFactory.GetSingleton: TFindWindowFactory;
begin
  result := FindWindowFactorySingleton;
end;

class procedure TFindWindowFactory.SetSingleton(
  AFindWindowFactory: TFindWindowFactory);
begin
  if Assigned(FindWindowFactorySingleton) then begin
    raise SysUtils.Exception.Create('FindWindowFactory already exists.');
  end;
  FindWindowFactorySingleton := AFindWindowFactory;
end;

class procedure TFindWindowFactory.SingletonFree;
begin
  if Assigned(FindWindowFactorySingleton) then begin
    FindWindowFactorySingleton.Free;
    FindWindowFactorySingleton := nil;
  end;
end;

{ TFindWindowObject }

function TFindWindowObject.CheckWindowTrue(Handle: HWND): boolean;
begin
  result := true;
end;

constructor TFindWindowObject.Create(AHostVersion: TadxHostVersion);
begin
  inherited Create;
  FHostVersion := AHostVersion;
end;

destructor TFindWindowObject.Destroy;
begin
  inherited Destroy;
end;

function TFindWindowObject.Find(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  case FHostVersion of
    v2000: begin
      result := FindIn2000(HostHandle, Condition);
      exit;
    end;
    v2002: begin
      result := FindIn2002(HostHandle, Condition);
      exit;
    end;
    v2003: begin
      result := FindIn2003(HostHandle, Condition);
      exit;
    end;
    v2007: begin
      result := FindIn2007(HostHandle, Condition);
      exit;
    end;
    v2010: begin
      result := FindIn2010(HostHandle, Condition);
      exit;
    end;
    else
      raise SysUtils.Exception.Create('FindWindowObject.Find Unknown Host Version.');
  end;
end;

function TFindWindowObject.FindChildWindowV(HWNDParent: HWND; WindowName,
  WindowClass, ExcludeChildWindowClass: string; detail,
  FindVisibleWindow: boolean): HWND;
begin
  if FindVisibleWindow then begin
    result := self.InternalFindChildWindow(HWNDParent, WindowName, WindowClass, ExcludeChildWindowClass, detail, [fwcWindowMustVisible])
  end
  else begin
    result := self.InternalFindChildWindow(HWNDParent, WindowName, WindowClass, ExcludeChildWindowClass, detail, [fwcAnyVisibleState])
  end;
end;

function TFindWindowObject.InternalFindChildWindow(HWNDParent: HWND;
  WindowName: string; WindowClass: string;
  ExcludeChildWindowClass: string;
  detail: boolean; Condition: TadxFindWindowConditions): HWND;
var
  foundWindow, tempWindow: HWND;
  FindName, FindClass, IncludeChildWindowClass: string;
begin
  FoundWindow := 0;
  FindClass := '';
  FindName := '';
  tempWindow := GetWindow(HWNDParent, GW_CHILD);
  while tempWindow > 0 do begin
    if (Condition = [fwcAnyVisibleState])
      or ((Condition = [fwcWindowMustVisible]) and IsWindowVisible(tempWindow))
      or ((Condition = [fwcWindowMustVisibleAndMorePixel]) and IsWindowVisibleAndMorePixel(tempWindow))
    then begin

      if WindowName <> '' then begin
        FindName:= GetWindowCaption(tempWindow);
      end;

      FindClass:= GetWindowClassName(tempWindow);

      if ((pos(WindowName, FindName) > 0) or (WindowName = ''))
      and ((pos(WindowClass, FindClass) > 0) or (WindowClass = '')) then begin
        Result:= tempWindow;
        FoundWindow:= Result;
        if ExcludeChildWindowClass <> '' then begin
          if ExcludeChildWindowClass[1] = '#' then begin
            IncludeChildWindowClass := ExcludeChildWindowClass;
            Delete(IncludeChildWindowClass, 1, 1);
            if self.InternalFindChildWindow(tempWindow, '', IncludeChildWindowClass, '', false, Condition) > 0 then begin
              break;
            end;
          end
          else begin
            if self.InternalFindChildWindow(tempWindow, '', ExcludeChildWindowClass, '', false, Condition) <= 0 then begin
              break;
            end;
          end;
        end
        else begin
          //if (Condition = fwcAnyVisibleState)
          //or ((Condition = fwcWindowMustVisible) and IsWindowVisible(Result))
          //or ((Condition = fwcWindowMustVisibleAndMorePixel) and IsWindowVisibleAndMorePixel(Result))
          //then begin
            break;
          //end;
        end;
      end
      else if detail then begin
        Result:= Self.InternalFindChildWindow(tempWindow, WindowName, WindowClass, ExcludeChildWindowClass, true, Condition);
        if Result > 0 then begin
          FoundWindow:= Result;
          //if (Condition = fwcAnyVisibleState)
          //or ((Condition = fwcWindowMustVisible) and IsWindowVisible(Result))
          //or ((Condition = fwcWindowMustVisibleAndMorePixel) and IsWindowVisibleAndMorePixel(Result))
          //then begin
            break;
          //end;
        end;
      end;
    end;
    tempWindow:= GetWindow(tempWindow, GW_HWNDNEXT);
  end;
  Result:= FoundWindow;
end;

function TFindWindowObject.InternalFindChildWindowWithControlID(
  HWNDParent: HWND; WindowName, WindowClass,
  ExcludeChildWindowClass: string; detail: boolean; AControlID: integer;
  FindVisibleWindow: boolean; CustomCheckHandleProc: TCustomCheckHandle): HWND;
var
  foundWindow, tempWindow: HWND;
  FindName, FindClass, IncludeChildWindowClass: string;
  ControlID: integer;
begin
  FoundWindow:= 0;
  FindClass:= '';
  FindName:= '';
  tempWindow:= GetWindow(HWNDParent, GW_CHILD);
  while tempWindow > 0 do begin
    if WindowName <> '' then
      FindName:= GetWindowCaption(tempWindow);
    FindClass:= GetWindowClassName(tempWindow);

    ControlID := GetWindowLong(tempWindow, GWL_ID);
    if ((pos(WindowName, FindName) > 0) or (WindowName = ''))
      and ((pos(WindowClass, FindClass) > 0) or (WindowClass = ''))
      and ((ControlID = AControlID) or (AControlID = 0))
      and CustomCheckHandleProc(tempWindow) then begin

      Result:= tempWindow; FoundWindow:= Result;
      if ExcludeChildWindowClass <> '' then begin
        if ExcludeChildWindowClass[1] = '#' then begin
          IncludeChildWindowClass := ExcludeChildWindowClass;
          Delete(IncludeChildWindowClass, 1, 1);
          if InternalFindChildWindowWithControlID(tempWindow, '', IncludeChildWindowClass, '', false, AControlID, FindVisibleWindow) > 0 then
            break;
        end
        else begin
          if InternalFindChildWindowWithControlID(tempWindow, '', ExcludeChildWindowClass, '', false, AControlID, FindVisibleWindow) <= 0 then
            break;
        end;
      end
      else begin
        if ((FindVisibleWindow) and IsWindowVisible(Result))
        or (not FindVisibleWindow)  then begin
          break;
        end;
      end;
    end
    else if detail then begin
      Result:= InternalFindChildWindowWithControlID(tempWindow, WindowName, WindowClass, ExcludeChildWindowClass, true, AControlID, FindVisibleWindow);
      if Result > 0 then begin
        if CustomCheckHandleProc(Result) then begin
          FoundWindow:= Result;
          if ((FindVisibleWindow) and IsWindowVisible(Result))
          or (not FindVisibleWindow)  then begin
            break;
          end;
        end;
      end;
    end;
    tempWindow:= GetWindow(tempWindow, GW_HWNDNEXT);
  end;
  Result:= FoundWindow;
end;

function TFindWindowObject.InternalFindChildWindowWithControlID(
  HWNDParent: HWND; WindowName, WindowClass,
  ExcludeChildWindowClass: string; detail: boolean; AControlID: integer;
  FindVisibleWindow: boolean): HWND;
begin
  result := InternalFindChildWindowWithControlID(
    HWNDParent, WindowName, WindowClass,
    ExcludeChildWindowClass, detail, AControlID,
    FindVisibleWindow, CheckWindowTrue);
end;

function TFindWindowObject.IsWindowVisibleAndMorePixel(
  WindowHandle: HWND): boolean;
var
  R: TRect;
  MorePixel: boolean;
begin
  Windows.GetClientRect(WindowHandle, R);
  MorePixel := ((R.Right - R.Left) > 1) and ((R.Bottom - R.Top) > 1);
  result := IsWindowVisible(WindowHandle) and MorePixel;
end;

function TFindWindowObject.MustVisible(
  Condition: TadxFindWindowConditions): boolean;
begin
  result := (Condition = [fwcWindowMustVisible]);
end;

{ TadxDragControlCTP }

constructor TadxDragControlCTP.Create(AParent: TadxDragCustomControl;
  AOwner: TadxRegionDragContainer; AItemType: TadxItemType;
  ALayout: TadxWindowLayout; AHandle: HWND);
begin
  Create;
  FSubclassHandle := 0;
  FParent := AParent;
  FOwner := AOwner;
  FItemType := AItemType;
  FLayout := ALayout;
  if FOwner.HostHandle > 0 then begin
    FAppHandle := FindChildWindow(FOwner.HostHandle, 'MsoDock' + WindowLayoutToString(layout), '', false);
    if FAppHandle > 0 then
      FSubclassHandle := FindChildWindow(FAppHandle, ServicePaneCaption, '', false);
  end;
  FWindowRect := GetLayoutRect(0);
  FSubclassRect := windowRect;
  SetBounds;
end;

procedure TadxDragControlCTP.GetLayoutParams(var param: TadxDragLayoutParams);
begin
  param.Disabled := true;
  param.ItemType := FItemType;
  param.Layout:= FLayout shl 8;
  param.LayoutSize := 0;
  param.AppHandle := FSubclassHandle;
end;

function TadxDragControlCTP.GetLayoutRect(LayoutIndex: integer): TRect;
var
  ownerRect: TRect;
  wPos: TWindowPos;
  wInfo: TWindowInfo;
  H: HWND;
  getSize: boolean;
begin
  getSize:= false;
  GetWindowRect(FOwner.Handle, ownerRect);
  if FSubclassHandle > 0 then begin
    if SendMessage(FSubclassHandle, WM_ADXGETAPPWINDOWPOS, LayoutIndex, Cardinal(@wPos)) = adxMessageResult then begin
      Result.Left   := wPos.x;
      Result.Top    := wPos.y;
      Result.Right  := wPos.x + wPos.cx;
      Result.Bottom := wPos.y + wPos.cy;

      H:= FAppHandle;
      if H > 0 then begin
        GetWindowInfo(H, wInfo);
        OffsetRect(Result, wInfo.rcClient.Left, wInfo.rcClient.Top);
      end;
      getSize:= true;
    end;
  end;

  if not getSize then begin
    GetWindowInfo(FOwner.HostHandle, wInfo);
    GetWindowRect(FAppHandle, Result);
    case FLayout of
      wlLeft: begin
        Result.Left := Result.Right;
        Result.Right := wInfo.rcClient.Right;
      end;
      wlRight: begin
        Result.Right := Result.Left;
        Result.Left := wInfo.rcClient.Left;
      end;
      wlTop: begin
        Result.Top := Result.Bottom;
        Result.Bottom := wInfo.rcClient.Bottom;
      end;
      wlBottom: begin
        Result.Bottom := Result.Top;
        Result.Top := wInfo.rcClient.Top;
      end;
    end;
  end;

  OffsetRect(Result, -ownerRect.Left, -ownerRect.Top);
end;

procedure TadxDragControlCTP.OffsetExcludeItem(var ARect: TRect);
begin
  if FOwner.FCurrentItemsCount < 2 then begin
    case FOwner.FCurrentLayout  of
      wlDockTop: begin
        dec(ARect.Top, FOwner.FCurrentScreenPos.cy);
      end;
      wlDockBottom: begin
        inc(ARect.Bottom, FOwner.FCurrentScreenPos.cy);
      end;
    end;
  end;
end;

{ TAppWindowControler }

function TAppWindowController.Connect: boolean;
var
  tempWindow: HWND;
begin
  Result:= false;
  FPrevHandle:= 0;
  FNextHandle:= 0;
  if Assigned(FContainerPane) and Assigned(FAppWindow) then begin
    FAppHandle:= FAppWindow.Handle;
    FPaneHandle:= FContainerPane.Handle;
    FConnected := true;
    if FAppHandle > 0 then begin
      tempWindow := GetWindow(GetParent(FAppHandle), GW_CHILD);
      while tempWindow > 0 do begin
        if tempWindow <> FPaneHandle then begin
          FNextHandle:= SendMessage(tempWindow, WM_NEGOTIATE_WINDOW_PANE, integer(nfcAddCustomWindowToTop), FContainerPane.Handle);
          if FNextHandle > 0 then
            break;
        end;
        tempWindow:= GetWindow(tempWindow, GW_HWNDNEXT);
      end;
    end;
    if FNextHandle > 0 then begin
      SendMessage(FNextHandle, WM_NEGOTIATE_WINDOW_PANE, integer(nfcGetFullClientArea), integer(@FFullClientAreaRect));
      if Assigned(FAppWindow) then
        FAppWindow.MainPos:= RectToWindowPos(FFullClientAreaRect);
      Result:= true;
    end;
  end;
end;

constructor TAppWindowController.Create(AppWindow: TAppWindow; ContainerPane: TadxContainerPane);
begin
  FAppWindow := AppWindow;
  FContainerPane:= ContainerPane;
  FPrevHandle:= 0;
  FNextHandle:= 0;
  FAppHandle := 0;
  FPaneHandle := 0;
  FConnected := false;
  FFullClientAreaRect:= Rect(0, 0, 0, 0);
  FPreviewAreaRect:= Rect(0, 0, 0, 0);
  FAppWindow.FOnNegotiateWindowMessage:= HandleMessage;
end;

destructor TAppWindowController.Destroy;
begin
  if Assigned(FAppWindow) then
    FAppWindow.FOnNegotiateWindowMessage:= nil;
  inherited;
end;

function TAppWindowController.Disconnect: boolean;
begin
  Result:= true;
  FConnected := false;
  if FPrevHandle > 0 then
	  SendMessage(FPrevHandle, WM_NEGOTIATE_WINDOW_PANE, integer(nfcReplaceNextWindow), FNextHandle);
  if FNextHandle > 0 then
	  SendMessage(FNextHandle, WM_NEGOTIATE_WINDOW_PANE, integer(nfcReplacePrevWindow), FPrevHandle);

  RecalcPreviewPaneLayout;

  FAppHandle := 0;
  FPrevHandle:= 0;
  FNextHandle:= 0;
  FFullClientAreaRect:= Rect(0, 0, 0, 0);
end;

function TAppWindowController.DoAddCustomWindowToTop(AHandle: HWnd): Longint;
begin
  Result:= 0;
  if FPrevHandle <= 0 then begin
    FPrevHandle:= AHandle;
    Result:= FContainerPane.Handle;
    FConnected := true;
  end;
end;

function TAppWindowController.DoGetReservedRect(lParam: Integer): longint;
var
  pSize: TSize;
  R: TRect;
  wPos: TWindowPos;
begin
  Result:= 0;
  if FNextHandle > 0 then begin
    if SendMessage(FNextHandle, WM_NEGOTIATE_WINDOW_PANE, longint(nfcGetReservedRect), lParam) <> 1 then
      exit;
  end;
  R:= PRect(lParam)^;
  if Assigned(FContainerPane) then begin
    FContainerPane.GetRequiredSize(pSize, true);
    FRequiredSize:= pSize;

    GetRefreshPos(FAppWindow.Handle, wPos);
    case FContainerPane.FormLayout of
      wlLeft: begin
        if pSize.cx > wPos.cx - R.Right then
          pSize.cx := wPos.cx - R.Right;
      end;
      wlRight: begin
        if pSize.cx > wPos.cx - R.Left then
          pSize.cx := wPos.cx - R.Left;
      end;
      wlTop: begin
        if pSize.cy > wPos.cy - (R.Top + R.Bottom) then
          pSize.cy := wPos.cy - (R.Top + R.Bottom);

      end;
      wlBottom: begin
        if pSize.cy > wPos.cy - (R.Top + R.Bottom) then
          pSize.cy := wPos.cy - (R.Top + R.Bottom);
      end;
    end;
    if not FContainerPane.IsHiddenState then begin
      if pSize.cx < MinAdjacentWindowWidth then pSize.cx := 0;
      if pSize.cy < MinAdjacentWindowHeight then pSize.cy := 0;
    end;
    FRequiredSize:= pSize;

    case FContainerPane.FormLayout of
      wlLeft:   inc(R.Left, pSize.cx);
      wlTop:    inc(R.Top, pSize.cy);
      wlRight:  inc(R.Right, pSize.cx);
      wlBottom: inc(R.Bottom, pSize.cy);
      wlClient: begin
        inc(R.Left, pSize.cx);
        inc(R.Top, pSize.cx);
      end;
    end;
    PRect(lParam)^:= R;
  end;
  Result:= 1;
end;

function TAppWindowController.DoGetFullClientArea(lParam: Integer): longint;
begin
  Result:= 0;
  PRect(lParam)^:= FFullClientAreaRect;
end;

function TAppWindowController.DoPlaceWindowAdjacentToRect(lParam: Integer): longint;
var
  pSize: TSize;
  rc: TRect;
  wPos: TWindowPos;
begin
  Result:= 0;
  rc:= PRect(lParam)^;
  //FContainerPane.GetRequiredSize(pSize, false);
  pSize:= FRequiredSize;

  if Assigned(FContainerPane) then begin
    wPos:= FContainerPane.ScreenPos;
    wPos.flags:= SWP_NOZORDER or SWP_NOACTIVATE;
    case FContainerPane.FormLayout of
      wlLeft: begin
        wPos.x:= rc.Left - pSize.cx;
        wPos.y:= rc.Top;
        wPos.cx:= pSize.cx;
        wPos.cy:= GetRectHeight(rc);
        dec(rc.Left, pSize.cx);
      end;
      wlTop: begin
        wPos.x:= rc.Left;
        wPos.y:= rc.Top - pSize.cy;
        wPos.cx:= GetRectWidth(rc);
        wPos.cy:= pSize.cy;
        dec(rc.Top, pSize.cy);
      end;
      wlRight: begin
        wPos.x:= rc.Left + GetRectWidth(rc);
        wPos.y:= rc.Top;
        wPos.cx:= pSize.cx;
        wPos.cy:= GetRectHeight(rc);
        inc(rc.Right, pSize.cx);
      end;
      wlBottom: begin
        wPos.x:= rc.Left;
        wPos.y:= rc.Bottom;
        wPos.cx:= GetRectWidth(rc);
        wPos.cy:= pSize.cy;
        inc(rc.Bottom, pSize.cy);
      end;
      wlClient: begin
        dec(rc.Left, pSize.cx);
        dec(rc.Top, pSize.cy);
      end;
    end;

    FContainerPane.ScreenPos:= wPos;
    FContainerPane.DoResize;
  end;

  PRect(lParam)^:= rc;
  if FNextHandle > 0 then begin
    SendMessage(FNextHandle, WM_NEGOTIATE_WINDOW_PANE, longint(nfcPlaceWindowAdjacentToRect), lParam);
  end;
end;

function TAppWindowController.DoRecalcPaneLayout: longint;
begin
  Result:= 0;
  RecalcPreviewPaneLayout;
end;

function TAppWindowController.DoReplaceNextWindow(AHandle: HWnd): Longint;
begin
  Result:= 0;
  FNextHandle:= AHandle;
end;

function TAppWindowController.DoReplacePrevWindow(AHandle: HWnd): Longint;
begin
  Result:= 0;
  if (AHandle > 0) then begin
    SendMessage(AHandle, WM_NEGOTIATE_WINDOW_PANE, integer(nfcGetFullClientArea), integer(@FFullClientAreaRect));
    if Assigned(FAppWindow) then
      FAppWindow.MainPos:= RectToWindowPos(FFullClientAreaRect);
  end;
  FPrevHandle:= AHandle;
end;

function TAppWindowController.DoWindowPosChanging(lParam: Integer): longint;
var
  wPos: TWindowPos;
  rc, rcReserved, rcParent, rcNewArea: TRect;
begin
  Result:= 1;
  if FPrevHandle <= 0 then begin
    wPos:= PWindowPos(lParam)^;
    if wPos.flags and SWP_NOSIZE = 0 then begin
      if wPos.flags and SWP_NOMOVE > 0 then begin
        GetWindowRect(wPos.hwnd, rc);
        GetWindowRect(GetParent(wPos.hwnd), rcParent);
        OffsetRect(rc, -rcParent.Left, -rcParent.Top);
        wPos.x:= rc.Left;
        wPos.y:= rc.Top;
      end;

      if not FSizing then begin
        if Assigned(FAppWindow) then
          FAppWindow.MainPos:= wPos;
        FSizing:= true;
        //rcNewArea:= WindowPosToRect(wPos);
        rcReserved:= Rect(0, 0, 0, 0);
        if SendMessage(FPaneHandle, WM_NEGOTIATE_WINDOW_PANE, integer(nfcGetReservedRect), integer(@rcReserved)) = 1 then begin
          rcNewArea:= WindowPosToRect(wPos);
          if not EqualRect(FPreviewAreaRect, rcNewArea) then begin
            inc(wPos.x, rcReserved.Left);
            inc(wPos.y, rcReserved.Top);
            dec(wPos.cx, rcReserved.Left + rcReserved.Right);
            dec(wPos.cy, rcReserved.Top + rcReserved.Bottom);

            FPreviewAreaRect:= WindowPosToRect(wPos);
            FFullClientAreaRect := rcNewArea;
          end;
          //FFullClientAreaRect := rcNewArea;
          rc:= FPreviewAreaRect;
          SendMessage(FPaneHandle, WM_NEGOTIATE_WINDOW_PANE, longint(nfcPlaceWindowAdjacentToRect), longint(@rc));
        end;
        PWindowPos(lParam)^:= wPos;
        FSizing:= false;
      end;
    end;
  end;
end;

function TAppWindowController.GetActive: boolean;
begin
  Result:= (FPrevHandle = 0) and FConnected;
end;

function TAppWindowController.HandleMessage(msg: cardinal; wParam, lParam: longint): longint;
begin
  Result:= 0;
  if msg = WM_NEGOTIATE_WINDOW_PANE then begin
    case TAppNegotiateFunctionCode(wParam mod 8) of
      nfcAddCustomWindowToTop:      Result:= DoAddCustomWindowToTop(lParam);
      nfcReplacePrevWindow:         Result:= DoReplacePrevWindow(lParam);
      nfcReplaceNextWindow:         Result:= DoReplaceNextWindow(lParam);
      nfcGetReservedRect:           Result:= DoGetReservedRect(lParam);
      nfcPlaceWindowAdjacentToRect: Result:= DoPlaceWindowAdjacentToRect(lParam);
      nfcRecalcPaneLayout:          Result:= DoRecalcPaneLayout;
      nfcGetFullClientArea:         Result:= DoGetFullClientArea(lParam);
    end;
  end
  else
  if msg = WM_WINDOWPOSCHANGING then begin
    Result:= DoWindowPosChanging(lParam);
  end;
end;

procedure TAppWindowController.RecalcPreviewPaneLayout;
var
  rc, rcReserved, rcParent: TRect;
begin
  if FPrevHandle > 0 then
		SendMessage(FPrevHandle, WM_NEGOTIATE_WINDOW_PANE, integer(nfcRecalcPaneLayout), 0)
  else begin
    if FSizing then
      exit;
    if FConnected then begin
      rcReserved:= Rect(0, 0, 0, 0);
      if SendMessage(FPaneHandle, WM_NEGOTIATE_WINDOW_PANE, integer(nfcGetReservedRect), integer(@rcReserved)) = 1 then begin
        if IsRectEmpty(FFullClientAreaRect) then begin
          GetWindowRect(GetParent(FAppHandle), rcParent);
          GetWindowRect(FAppHandle, FFullClientAreaRect);
          OffsetRect(FFullClientAreaRect, -rcParent.Left, -rcParent.Top);
        end;

        rc:= FFullClientAreaRect;
        inc(rc.left, rcReserved.left);
        inc(rc.top, rcReserved.top);
        dec(rc.right, rcReserved.right);
        dec(rc.bottom, rcReserved.bottom);

        FSizing:= true;
        SetWindowPos(FAppHandle, 0, rc.Left, rc.Top, GetRectWidth(rc), GetRectHeight(rc), SWP_NOZORDER or SWP_NOACTIVATE);
        FPreviewAreaRect:= rc;

        SendMessage(FPaneHandle, WM_NEGOTIATE_WINDOW_PANE, integer(nfcPlaceWindowAdjacentToRect), integer(@rc));
        FSizing:= false;
      end;
    end
    else begin
      rc:= FFullClientAreaRect;
      SetWindowPos(FAppHandle, 0, rc.Left, rc.Top, GetRectWidth(rc), GetRectHeight(rc), SWP_NOZORDER or SWP_NOACTIVATE);
      FPreviewAreaRect:= rc;
    end;
  end;
end;

procedure TAppWindowController.SwapController(swapHandle: HWND; wParam: longint; lParam: PAppWindowControllerParam);
var
  param: TAppWindowControllerParam;
begin
  if swapHandle > 0 then begin
    //SendParam
    param.FullClientAreaRect:= FFullClientAreaRect;
    param.PreviewAreaRect:= FPreviewAreaRect;
    param.PrevHandle := FPrevHandle;
    param.NextHandle := FNextHandle;
    FPrevHandle:= 0;
    FNextHandle:= 0;
    FConnected := false;
    SendMessage(swapHandle, WM_ADXSWAPCONTROLLER, wParam, longint(@param));
  end
  else begin
    //Receive param
    if lParam <> nil then begin
      FFullClientAreaRect := lParam^.FullClientAreaRect;
      FPreviewAreaRect := lParam^.PreviewAreaRect;
      FPrevHandle:= lParam^.PrevHandle;
      FNextHandle:= lParam^.NextHandle;
      FConnected := true;
      if Assigned(FAppWindow) then
        FAppHandle:= FAppWindow.Handle;
      if Assigned(FContainerPane) then
        FPaneHandle:= FContainerPane.Handle;
    end;

    case wParam of
      0: begin
        if FPrevHandle > 0 then
          SendMessage(FPrevHandle, WM_NEGOTIATE_WINDOW_PANE, integer(nfcReplaceNextWindow), FPaneHandle);
        if FNextHandle > 0 then
          SendMessage(FNextHandle, WM_NEGOTIATE_WINDOW_PANE, integer(nfcReplacePrevWindow), FPaneHandle);
      end;
      1: begin
        if lParam <> nil then begin
          if lParam^.PrevHandle > 0 then
            SendMessage(lParam^.PrevHandle, WM_NEGOTIATE_WINDOW_PANE, integer(nfcReplaceNextWindow), lParam^.NextHandle);
          if lParam^.NextHandle > 0 then
            SendMessage(lParam^.NextHandle, WM_NEGOTIATE_WINDOW_PANE, integer(nfcReplacePrevWindow), FPaneHandle);//lParam^.PrevHandle);

          FPrevHandle:= 0;
          if FNextHandle <= 0 then
            FNextHandle:= SendMessage(lParam^.PrevHandle, WM_NEGOTIATE_WINDOW_PANE, integer(nfcAddCustomWindowToTop), FContainerPane.Handle);
          if FNextHandle > 0 then begin
            SendMessage(FNextHandle, WM_NEGOTIATE_WINDOW_PANE, integer(nfcGetFullClientArea), integer(@FFullClientAreaRect));
            if Assigned(FAppWindow) then
              FAppWindow.MainPos:= RectToWindowPos(FFullClientAreaRect);
          end;
        end;
      end;
    end; {case}

  end;
end;

{ TadxDragControlTotalRP }

constructor TadxDragControlTotalRP.Create(AParent: TadxDragCustomControl; AOwner: TadxRegionDragContainer; AItemType: TadxItemType;
  ALayout: TadxWindowLayout; AHandle: HWND);
begin
  inherited;
  FControls.Add(TadxDragControlRP.Create(self, AOwner, AItemType, wlLeft, AHandle));
  FControls.Add(TadxDragControlRP.Create(self, AOwner, AItemType, wlRight, AHandle));
  FControls.Add(TadxDragControlRP.Create(self, AOwner, AItemType, wlTop, AHandle));
  FControls.Add(TadxDragControlRP.Create(self, AOwner, AItemType, wlBottom, AHandle));
  //FControls.Add(TadxDragControlRP.Create(self, AOwner, AItemType, wlClient, AHandle));
end;


function TadxDragControlTotalRP.GetLayoutRect(LayoutIndex: integer): TRect;
var
  ownerRect: TRect;
  wInfo: TWindowInfo;
  wPos: TWindowPos;
  H: HWND;
begin
  GetWindowRect(FOwner.Handle, ownerRect);
  Result:= Rect(0, 0, 0, 0);

  if LayoutIndex = 0 then begin
    if GetRefreshPos(AppHandle, wPos) then begin
      Result:= WindowPosToRect(wPos);
      H:= GetParent(AppHandle);
      if H > 0 then begin
        GetWindowInfo(H, wInfo);
        OffsetRect(Result, wInfo.rcClient.Left, wInfo.rcClient.Top);
      end;
    end;
  end;
  if IsRectEmpty(Result) then
    GetWindowRect(AppHandle, Result);

  OffsetRect(Result, -ownerRect.Left, -ownerRect.Top);
end;

procedure TadxDragControlTotalRP.Paint(ACanvas: TadxGPGraphics);
begin
  FOwner.DrawResourceImage(ACanvas, FBounds.Left, FBounds.Top, Layout);
  inherited Paint(ACanvas);
end;

procedure TadxDragControlTotalRP.SetBounds;
begin
  inherited;
  if not IsRectEmpty(SubClassRect) then begin
    FBounds := FOwner.GetResourceBitmapRect(Layout);
    FBounds.Left := SubClassRect.Left + Round( (GetRectWidth(SubClassRect)  - GetRectWidth(FBounds)) / 2 );
    FBounds.Top  := SubClassRect.Top  + Round( (GetRectHeight(SubClassRect) - GetRectHeight(FBounds)) / 2 );
  end;
end;

{ TadxDragControlRP }

function TadxDragControlRP.GetLayoutRect(LayoutIndex: integer): TRect;
var
  ownerRect: TRect;
  wInfo: TWindowInfo;
  wPos: TWindowPos;
  H: HWND;
begin
  if FParent <> nil then begin
    case LayoutIndex of
      0:        Result:= FParent.SubClassRect;
      wlClient: Result:= FParent.WindowRect;
    end;
    exit;
  end;

  GetWindowRect(FOwner.Handle, ownerRect);
  Result:= Rect(0, 0, 0, 0);

  if LayoutIndex = 0 then begin
    if GetRefreshPos(AppHandle, wPos) then begin
      Result:= WindowPosToRect(wPos);
      H:= GetParent(AppHandle);
      if H > 0 then begin
        GetWindowInfo(H, wInfo);
        OffsetRect(Result, wInfo.rcClient.Left, wInfo.rcClient.Top);
      end;
    end;
  end;
  if IsRectEmpty(Result) then
    GetWindowRect(AppHandle, Result);

  OffsetRect(Result, -ownerRect.Left, -ownerRect.Top);
end;

procedure TadxDragControlRP.OffsetExcludeItem(var ARect: TRect);
var
  rHost, currRect: TRect;
begin
  if (FAppHandle = FOwner.FCurrentAppHandle) and (FOwner.FCurrentItemsCount <= 1) then begin
    GetWindowRect(FOwner.FCurrentPaneHandle, currRect);
    GetWindowRect(FOwner.FHostHandle, rHost);
    OffsetRect(currRect, -rHost.Left, -rHost.Top);
    case FOwner.FCurrentLayout  of
      wlLeft: begin
        if Layout <> wlRight then
          ARect.Left:=  currRect.Left;
      end;
      wlRight:  begin
        if Layout <> wlLeft then
          ARect.Right:= currRect.Right;
      end;
      wlTop: begin
        if Layout <> wlBottom then
          ARect.Top:= currRect.Top;
      end;
      wlBottom: begin
        if Layout <> wlTop then
          ARect.Bottom:= currRect.Bottom;
      end;
    end;
  end;
end;

procedure TadxDragControlRP.SetBounds;
var
  clientRect: TRect;
begin
  if not IsRectEmpty(SubClassRect) then begin
    FBounds := FOwner.GetResourceBitmapRect(Layout);
    OffsetRect(FBounds, -FBounds.Left, -FBounds.Top);

    clientRect := FOwner.GetResourceBitmapRect(wlClient);
    OffsetRect(clientRect, -clientRect.Left, -clientRect.Top);
    OffsetRect(clientRect, SubClassRect.Left + Round( (GetRectWidth(SubClassRect) - GetRectWidth(clientRect)) / 2),
                           SubClassRect.Top + Round( (GetRectHeight(SubClassRect) - GetRectHeight(clientRect)) / 2) );
    case Layout of
      wlLeft: begin
        OffsetRect(FBounds, clientRect.Left,
          clientRect.Top + Round( (GetRectHeight(clientRect) - GetRectHeight(FBounds)) / 2 ));
      end;
      wlRight: begin
        OffsetRect(FBounds, clientRect.Right - GetRectWidth(FBounds),
          clientRect.Top + Round( (GetRectHeight(clientRect) - GetRectHeight(FBounds)) / 2 ));
      end;
      wlTop: begin
        OffsetRect(FBounds, clientRect.Left + Round( (GetRectWidth(clientRect) - GetRectWidth(FBounds)) / 2 ),
          clientRect.Top);
      end;
      wlBottom: begin
        OffsetRect(FBounds, clientRect.Left + Round((GetRectWidth(clientRect) - GetRectWidth(FBounds)) / 2) ,
          clientRect.Bottom - GetRectHeight(FBounds));
      end;
      wlClient: begin
        InflateRect(FBounds, -28, -28);
        OffsetRect(FBounds, -FBounds.Left, -FBounds.Top);
        OffsetRect(FBounds, clientRect.Left + Round( (GetRectWidth(clientRect) - GetRectWidth(FBounds)) / 2 ),
          clientRect.Top + Round( (GetRectHeight(clientRect) - GetRectHeight(FBounds)) / 2 ));
      end;
    end;
  end;
  dec(FBounds.Right);
  dec(FBounds.Bottom);
end;

{ TadxMessageRetHook }

function TadxMessageRetHook.CallbackFunction(code: Integer; wParam, lParam: Cardinal): Longint;
begin
  Result:= MessageHookProc(code, wParam, lParam);
end;

constructor TadxMessageRetHook.Create;
begin
  HookProc := VirtualAlloc(nil, 12, MEM_RESERVE or MEM_COMMIT, PAGE_EXECUTE_READWRITE);
  asm
    mov  EAX, Self
    mov  ECX, [EAX].TadxMessageRetHook.HookProc;
    mov  word  ptr [ECX+0], $6858
    mov  dword ptr [ECX+2], EAX
    mov  word  ptr [ECX+6], $E950
    mov  EAX, OFFSET(TadxMessageRetHook.CallbackFunction)
    sub  EAX, ECX
    sub  EAX, 12
    mov  dword ptr [ECX+8], EAX
  end;
  HookHandle := SetWindowsHookEx(WH_CALLWNDPROCRET, HookProc, 0, GetCurrentThreadId);
end;

destructor TadxMessageRetHook.Destroy;
begin
  try
    VirtualFree(HookProc, 0, MEM_RELEASE);
    UnhookWindowsHookEx(HookHandle);
    inherited Destroy;
  except
    on E:SysUtils.Exception do begin
      Log.AddException('TadxMessageRetHook.Destroy ' + E.Message);
      raise E;
    end;
  end;
  inherited;
end;

function TadxMessageRetHook.MessageHookProc(code: Integer; wParam, lParam: Cardinal): Longint;
begin
  if Code = HC_ACTION then begin
    { Implementation message hook - override }
  end;
  Result:= CallNextHookEx(HookHandle, Code, wparam, lparam);
end;

{ TadxWDMessageRetHook }

constructor TadxWDMessageRetHook.CreateEx(AParent: TadxWDHook);
begin
  FParent:= AParent;
  Create;
end;

function TadxWDMessageRetHook.MessageHookProc(code: Integer; wParam, lParam: Cardinal): Longint;
var
  msg: PCWPRetStruct;
  mousePt: TPoint;
  R: TRect;
begin
  if Code = HC_ACTION then begin
    msg:= PCWPRetStruct(lParam);
    if msg^.message = WM_MOUSEACTIVATE then begin
      if msg^.lResult = MA_ACTIVATEANDEAT then begin
        GetCursorPos(mousePt);
        GetWindowRect(msg^.hWnd, R);
        dec(mousePt.X, R.Left);
        dec(mousePt.Y, R.Top);
        PostMessage(msg^.hWnd, WM_LBUTTONDOWN, 1, (mousePt.X + (mousePt.Y shl 16)));
      end;
    end;
  end;
  Result:= CallNextHookEx(HookHandle, Code, wparam, lparam);
end;

{ TadxBlinkController }

constructor TadxHighlightController.Create(AOwner: TadxContainerPane);
begin
  FOwner:= AOwner;
  FOwner.FHighlighted:= false;
end;

destructor TadxHighlightController.Destroy;
begin
  StopTimer;
  inherited;
end;

procedure TadxHighlightController.Initialize(blinkParam: TadxBlinkParam);
begin
  if (FTimer = nil) or (FInterval <> blinkParam.interval) then begin
    FFormHandle:= blinkParam.formHandle;
    FInterval:= blinkParam.interval;
    FPeriod:= 1;
    if blinkParam.period > 1 then
      FPeriod:= blinkParam.period- 1;
    FOwner.Highlighted:= false;
    FStartTickCount:= GetTickCount;
    StartTimer;
  end;
end;

procedure TadxHighlightController.OnTimer(sender: TObject);
begin
  //if GetTickCount - FStartTickCount > FPeriod then begin
  if FPeriod <= 0 then begin
    if not FOwner.Highlighted then begin
      StopTimer;
      FOwner.Highlighted:= True;
      PostMessage(FOwner.Handle, WM_PAINT, 0, 0);
      exit;
    end;
  end;
  FOwner.Highlighted:= not FOwner.Highlighted;
  if (FPeriod > 0) and FOwner.Highlighted then
    dec(FPeriod);
end;

procedure TadxHighlightController.StartTimer;
begin
  FIsStoped:= false;
  if not Assigned(FTimer) then begin
    FTimer:= TadxHighlightTimer.CreateEx(FInterval);
    FTimer.OnTimer:= OnTimer;
  end
  else
    FTimer.Interval:= FInterval;
end;

procedure TadxHighlightController.StopTimer;
begin
  if Assigned(FTimer) then begin
    FTimer.OnTimer:= nil;
    FTimer.Terminate;
    FTimer:= nil;
    FIsStoped:= true;
  end;
end;

{ TadxHighlightTimer }

constructor TadxHighlightTimer.CreateEx(Interval: Cardinal);
begin
  FInterval:= Interval;
  Create(true);
  FreeOnTerminate:= True;
  Priority:= tpNormal;
  Resume;
end;

destructor TadxHighlightTimer.Destroy;
begin
  FOnTimer:= nil;
  Terminate;
  inherited;
end;

procedure TadxHighlightTimer.Execute;
begin
  sleep(FInterval);
  while not Terminated do begin
    if Assigned(FOnTimer) then
      FOnTimer(self);
    sleep(FInterval);
  end;
end;

procedure TadxHighlightTimer.SetInterval(const Value: Cardinal);
begin
  if FInterval <> Value then begin
    Suspend;
    FInterval := Value;
    Resume;
  end;
end;

{ TadxRefreshInspectorTabStateGuard }

constructor TadxRefreshInspectorTabStateGuard.Create;
begin
  FLockCount := 0;
end;

class procedure TadxRefreshInspectorTabStateGuard.FreeRefreshInspectorTabStateInstance;
begin
  if (RefreshInspectorTabStateGuard <> nil) then begin
    RefreshInspectorTabStateGuard.Free;
    RefreshInspectorTabStateGuard := nil;
  end;
end;

class function TadxRefreshInspectorTabStateGuard.Instance: TadxRefreshInspectorTabStateGuard;
begin
  if (RefreshInspectorTabStateGuard = nil) then begin
    RefreshInspectorTabStateGuard := TadxRefreshInspectorTabStateGuard.Create;
  end;
  result := RefreshInspectorTabStateGuard;
end;

function TadxRefreshInspectorTabStateGuard.IsLock: boolean;
begin
  result := (FLockCount > 0);
end;

procedure TadxRefreshInspectorTabStateGuard.Lock;
begin
  inc(FLockCount);
end;

procedure TadxRefreshInspectorTabStateGuard.UnLock;
begin
  dec(FLockCount);
end;

initialization
  ILogSingleton := nil;
  AppWindowBehaviourSingleton := nil;
  FindWindowFactorySingleton := nil;
  ExceptionManager := nil;
  RegionStateGuard := nil;
  AdxCursors:= TadxCursors.Create;

  WM_ADXWMIGETCONTROL:=    RegisterWindowMessage('WM_ADXWMIGETCONTROL');
  WM_ADXWMIPOSCHANGE:=     RegisterWindowMessage('WM_ADXWMIPOSCHANGE');
  WM_ADXWMISETPOS:=        RegisterWindowMessage('WM_ADXWMISETPOS');

  WM_ADXDELPROC:=          RegisterWindowMessage('WM_ADXDELPROC');
  WM_ADXSETNEWPROC:=       RegisterWindowMessage('WM_ADXSETNEWPROC');
  WM_ADXSETOLDPROC:=       RegisterWindowMessage('WM_ADXSETOLDPROC');
  WM_ADXGETCONTAINERFORM:= RegisterWindowMessage('WM_ADXGETCONTAINERFORM');
  WM_ADXGETAPPWINDOWPOS:=  RegisterWindowMessage('WM_ADXGETAPPWINDOWPOS');
  WM_ADXGETREGIONPARAM:=   RegisterWindowMessage('WM_ADXGETREGIONPARAM');
  WM_ADXGETREGIONSIZE:=    RegisterWindowMessage('WM_ADXGETREGIONSIZE');
  WM_ADXSETREGIONPARAM:=   RegisterWindowMessage('WM_ADXSETREGIONPARAM');
  WM_ADXSETMAINPOS:=       RegisterWindowMessage('WM_ADXSETMAINPOS');
  WM_ADXADDFORM:=          RegisterWindowMessage('WM_ADXADDFORM');
  WM_ADXDELETEFORM:=       RegisterWindowMessage('WM_ADXDELETEFORM');
  WM_ADXSETCONTAINER:=     RegisterWindowMessage('WM_ADXSETCONTAINER');
  WM_ADXUPDATEFORMPARAM:=  RegisterWindowMessage('WM_ADXUPDATEFORMPARAM');

  WM_ADXSETLATESTPROC:=    RegisterWindowMessage('WM_ADXSETLATESTPROC');
  WM_ADXEXIST:=            RegisterWindowMessage('WM_ADXEXIST');
  WM_ADXEXISTLAYOUT:=      RegisterWindowMessage('WM_ADXEXISTLAYOUT');
  WM_ADXSETACTIVATE:=      RegisterWindowMessage('WM_ADXSETACTIVATE');
  WM_ADXCOMMAND:=          RegisterWindowMessage('WM_ADXCOMMAND');
  //WM_ADXUPDATESIZE:=       RegisterWindowMessage('WM_ADXUPDATESIZE');
  WM_ADXGETTYPESUBCLASS:=  RegisterWindowMessage('WM_ADXGETTYPESUBCLASS');
  WM_MSO_BROADCASTCHANGE:= RegisterWindowMessage('WM_MSO_BROADCASTCHANGE');
  WM_ADXSHOWFLOATING:=     RegisterWindowMessage('WM_ADXSHOWFLOATING');
  WM_ADXHIDEFLOATING:=     RegisterWindowMessage('WM_ADXHIDEFLOATING');
  WM_ADXSETFLOATINGPOS:=   RegisterWindowMessage('WM_ADXSETFLOATINGPOS');
  WM_ADXCONTAINERHIDEFLOATING:= RegisterWindowMessage('WM_ADXCONTAINERHIDEFLOATING');
  WM_ADXCONTAINERREFRESH:= RegisterWindowMessage('WM_ADXCONTAINERREFRESH');

  WM_ADXSUPPORTMINIMIZE:=  RegisterWindowMessage('WM_ADXSUPPORTMINIMIZE');
  WM_ADXMOUSELEAVE:=       RegisterWindowMessage('WM_ADXMOUSELEAVE');
  WM_ADXGETFORMDEFAULTSIZE:=    RegisterWindowMessage('WM_ADXGETFORMDEFAULTSIZE');

  WM_ADXGETDRAGLAYOUTPARAMS:=   RegisterWindowMessage('WM_ADXGETDRAGLAYOUTPARAMS');
  WM_ADXSETDRAGFORM:=      RegisterWindowMessage('WM_ADXSETDRAGFORM');
  WM_ADXSETDRAGITEMS:=     RegisterWindowMessage('WM_ADXSETDRAGITEMS');

  WM_ADXDRAGOVERMINIMIZED:= RegisterWindowMessage('WM_ADXDRAGOVERMINIMIZED');
  WM_ADXUPDATECLIPREGION:=     RegisterWindowMessage('WM_ADXUPDATECLIPREGION');
  WM_ADXREDESIGNSUPPORT:=  RegisterWindowMessage('WM_ADXREDESIGNSUPPORT');
  //WM_ADXCTP_VISIBLECHANGED:=  RegisterWindowMessage('WM_ADXCTP_VISIBLECHANGED');

  WM_ADX_READING_PANE_HIDE_FROM_SBCLS := RegisterWindowMessage('WM_ADX_READING_PANE_HIDE_FROM_SBCLS');  //See THideReadingPaneWindowFromSBCLSMessage
//  {$IFDEF UNICODE}
//  WM_ADX_READING_PANE_DIALOG_SHOW:= RegisterWindowMessage(PWideChar(Globals.WM_ADX_READING_PANE_DIALOG_SHOW));
//  WM_ADX_READING_PANE_DIALOG_HIDE:= RegisterWindowMessage(PWideChar(Globals.WM_ADX_READING_PANE_DIALOG_HIDE));
//  {$ELSE}
//  WM_ADX_READING_PANE_DIALOG_SHOW:= RegisterWindowMessage(PansiChar(Globals.WM_ADX_READING_PANE_DIALOG_SHOW));
//  WM_ADX_READING_PANE_DIALOG_HIDE:= RegisterWindowMessage(PansiChar(Globals.WM_ADX_READING_PANE_DIALOG_HIDE));
//  {$ENDIF}
  WM_ADX_DESTROY_EMBEDED_WINDOW := RegisterWindowMessage('WM_ADX_DESTROY_EMBEDED_WINDOW');
  WM_ADXFORMSHOW:=         RegisterWindowMessage('WM_ADXFORMSHOW');
  WM_ADXCLOSEBUTTONCLICK:= RegisterWindowMessage('WM_ADXCLOSEBUTTONCLICK');
  {$IFDEF UNICODE}
  WM_ADXHIDEALLREGIONFORMS := RegisterWindowMessage(PWideChar(Globals.WM_ADXHIDEALLREGIONFORMS));
  WM_ADXEXISTSERVICEFORM := RegisterWindowMessage(PWideChar(Globals.WM_ADXEXISTSERVICEFORM));
  {$ELSE}
  WM_ADXHIDEALLREGIONFORMS := RegisterWindowMessage(PansiChar(Globals.WM_ADXHIDEALLREGIONFORMS));
  WM_ADXEXISTSERVICEFORM := RegisterWindowMessage(PansiChar(Globals.WM_ADXEXISTSERVICEFORM));
  {$ENDIF}
  {$IFDEF UNICODE}
  WM_ADXGETPICTURE := RegisterWindowMessage(PWideChar(Globals.WM_ADXGETPICTURE));
  {$ELSE}
  WM_ADXGETPICTURE := RegisterWindowMessage(PAnsiChar(Globals.WM_ADXGETPICTURE));
  {$ENDIF}
  WM_ADXGETCAPTION := RegisterWindowMessage('WM_ADXGETCAPTION');

  {$IFDEF UNICODE}
  WM_ADXMAYBEWORDVIEWWASCHANGED := RegisterWindowMessage(PWideChar(Globals.WM_ADXMAYBEWORDVIEWWASCHANGED));
  {$ELSE}
  WM_ADXMAYBEWORDVIEWWASCHANGED := RegisterWindowMessage(PAnsiChar(Globals.WM_ADXMAYBEWORDVIEWWASCHANGED));
  {$ENDIF}

  {$IFDEF UNICODE}
  WM_ADXSTARTTRANSACTION := RegisterWindowMessage(PWideChar(Globals.WM_ADXSTARTTRANSACTION));
  WM_ADXENDTRANSACTION := RegisterWindowMessage(PWideChar(Globals.WM_ADXENDTRANSACTION));
  {$ELSE}
  WM_ADXSTARTTRANSACTION := RegisterWindowMessage(PAnsiChar(Globals.WM_ADXSTARTTRANSACTION));
  WM_ADXENDTRANSACTION := RegisterWindowMessage(PAnsiChar(Globals.WM_ADXENDTRANSACTION));
  {$ENDIF}
  WM_NEGOTIATE_WINDOW_PANE:= WM_USER + $7FFE;
  WM_REMOVING_WNDPROC:= WM_USER + $7FFD;
  WM_ADXSWAPCONTROLLER:= RegisterWindowMessage('WM_ADXSWAPCONTROLLER');

finalization
  ILogSingleton := nil;
  ExceptionManager := nil;
  if Assigned(AdxCursors) then begin
    AdxCursors.Free;
    AdxCursors := nil;
  end;

  TadxRegionStateGuard.FreeRegionStateInstance;
  TAppWindowBehaviour.SingletonFree;
end.

