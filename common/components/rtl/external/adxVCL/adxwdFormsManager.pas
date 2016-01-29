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

unit adxwdFormsManager;

{$I adxolDefs.inc}

interface

uses
  SysUtils, Classes, Dialogs, ComObj, OleCtrls, Forms, StdCtrls,
  {$IFNDEF ADX_VCL5}Variants,{$ENDIF}
  {$IFDEF ADX_VCL5}OleServer, FileCtrl,{$ENDIF}
  Windows, Messages, Graphics, Controls, ComCtrls, ExtCtrls, ToolWin,
  Buttons, Menus, TypInfo,
  Office2000, Word2000,
  adxAddin, adxHostAppEvents,
  {$IFNDEF ADX_VCL5}OLEServer,{$ENDIF}
  adxWSbcls, adxCore
  ;

type

  TadxWordVersion = integer;

  TadxWordTaskPaneClassName = string;

  TadxWordSplitter = (
    sbNone,
    sbStandard
  );

  TadxWordTaskPanePosition = (
    pUnknown,
    pTop,
    pBottom,
    pRight,
    pLeft
  );

  TadxErrorEventArgs = class
  private
    FE: SysUtils.Exception;
    FHandled: boolean;
    procedure SetHandled(const Value: boolean);
  public
    constructor Create(AE: SysUtils.Exception);
    destructor Destroy; override;
    property E: SysUtils.Exception read FE;
    property Handled: boolean read FHandled write SetHandled;
  end;

  TadxErrorEventHandler = procedure(ASender: TObject; Args: TadxErrorEventArgs) of object;

  TadxWordCloseButtonClickEventArgs = class
  private
    FCloseTaskPane: boolean;
    FDisableItem: boolean;
    procedure SetCloseTaskPane(const Value: boolean);
    procedure SetDisableItem(const Value: boolean);
  public
    constructor Create;
    property CloseTaskPane: boolean read FCloseTaskPane write SetCloseTaskPane;
    property DisableItem: boolean read FDisableItem write SetDisableItem;
  end;


  TadxWordCloseButtonClickEventHandler = procedure(Sender: TObject; Args: TadxWordCloseButtonClickEventArgs) of object;

  TadxWordEnterEventArgs = class
  end;

  TadxWordExitEventArgs = class
  end;

  TadxWordFormEnterEventHandler = procedure(Sender: TObject; Args: TadxWordEnterEventArgs) of object;
  TadxWordFormExitEventHandler = procedure(Sender: TObject; Args: TadxWordExitEventArgs) of object;

  TadxWordPostMessageReceivedEventArgs = class
  public
    wParam: Cardinal;
    lParam: Cardinal;
  end;

  TadxWordPostMessageReceivedEventHandler = procedure(Args: TadxWordPostMessageReceivedEventArgs) of object;

  TadxInitializeEventArgs = class
  public
    constructor Create();
    destructor Destroy; override;
  end;

  TadxInitializeEventHandler = procedure(ASender: TObject; Args: TadxInitializeEventArgs) of object;

  TadxBeforeTaskPaneShowEventArgs = class
  public
    constructor Create();
    destructor Destroy; override;
  end;

  TadxAfterTaskPaneHideEventArgs = class
  end;

  TadxBeforeTaskPaneShowEventHandler = procedure(ASender: TObject; Args: TadxBeforeTaskPaneShowEventArgs) of object;
  TadxAfterTaskPaneHideEventHandler = procedure(ASender: TObject; Args: TadxAfterTaskPaneHideEventArgs) of object;

  TadxAfterTaskPaneShowEventArgs = class
  public
    constructor Create();
    destructor Destroy; override;
  end;

  TadxAfterTaskPaneShowEventHandler = procedure(ASender: TObject; Args: TadxAfterTaskPaneShowEventArgs) of object;

{$IFDEF ADX_VCL5}
  TadxKeyFilterAction = integer;
const
  faSendToHostApplication = $03;
  faSendToTaskPane = $30;
{$ELSE}
  TadxKeyFilterAction = (faSendToHostApplication = $03, faSendToTaskPane = $30);
{$ENDIF}

type

  TadxWordTaskPanesCollectionItem = class;

  TadxBeforeTaskPaneInstanceCreateEventArgs = class
  private
    FItem: TadxWordTaskPanesCollectionItem;
    FCancel: boolean;
  public
    constructor Create(AItem: TadxWordTaskPanesCollectionItem; ADefaultCancel: boolean); overload;
    destructor Destroy; override;
    property Item: TadxWordTaskPanesCollectionItem read FItem;
    property Cancel: boolean read FCancel write FCancel;
  end;

  TadxBeforeTaskPaneInstanceCreateEventHandler = procedure(ASender: TObject;
    Args: TadxBeforeTaskPaneInstanceCreateEventArgs) of object;


  TadxWordTaskPanesCollection = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TadxWordTaskPanesCollectionItem;
    procedure SetItem(Index: Integer; Value: TadxWordTaskPanesCollectionItem);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
  public
    {$IFDEF ADX_VCL5}
    function Owner: TPersistent;
    {$ENDIF}
    function Add: TadxWordTaskPanesCollectionItem; overload;
    property Items[Index: Integer]: TadxWordTaskPanesCollectionItem read GetItem write SetItem; default;
  end;

  TadxWordTaskPanesManager = class;
  TadxWordTaskPane = class(TadxWDCustomForm)
  private
    FHostHandle: HWND;
    FWindowHandle: HWND;
    FFormsManager: TadxWordTaskPanesManager;
    FItem: TadxWordTaskPanesCollectionItem;

    FOnADXBeforeFormShow: TadxBeforeTaskPaneShowEventHandler;
    FOnADXAfterFormShow: TadxAfterTaskPaneShowEventHandler;

    FOnADXCloseButtonClick: TadxWordCloseButtonClickEventHandler;
    FOnADXEnter: TadxWordFormEnterEventHandler;
    FOnADXExit: TadxWordFormExitEventHandler;
    FOnADXPostMessage: TadxWordPostMessageReceivedEventHandler;
    FOnADXAfterTaskPaneHide: TadxAfterTaskPaneHideEventHandler;

    FisHiddenByDeveloper: boolean;

    function GetAddinModule: TObject;
    function GetWordAppObj: WordApplication;

    procedure UpdateAppWindowPropertyAfterBeforeFormShowEvent(AAppWindowProperty: Pointer);
    procedure AdxWdShow(AAppWindowProperty: Pointer; raiseEvents: boolean);
    procedure ADXWdHide(raiseEvents: boolean);
    procedure DisposeWordObjects;

    procedure DoADXBeforeTaskPaneShow(Args: TadxBeforeTaskPaneShowEventArgs);
    procedure DoADXAfterTaskPaneHide(args: TadxAfterTaskPaneHideEventArgs);
    procedure DoADXAfterFormShow(Args: TadxAfterTaskPaneShowEventArgs);

    procedure InitializeForm(AWordContextArgs: TObject; AAppWindowProperty: Pointer);
    function GetWordApp: TWordApplication;

    procedure DoAdxEnter(args: TadxWordEnterEventArgs);
    procedure DoAdxExit(args: TadxWordExitEventArgs);
    procedure DoAdxPostMessage(args: TadxWordPostMessageReceivedEventArgs);

    procedure DoReceiveAdxPostMessageCluster(msg: TMessage);
    procedure MarkHiddenByDeveloper(value: boolean);
    function GetCurrentWordWindowHandle: HWND;

    class function GetPositionKey(Position: TadxWordTaskPanePosition): string;
    procedure InternalSetDragItems(ADragItems: TList; dragWindowLayouts: TadxDragWindowLayout; AllowedDropPosition: TadxAllowedDropPosition);
  protected
    procedure HideByManager(UsingVisibleProperty: boolean); override;
    function  AdxRegistryKey: string; override;
    function  AdxLayoutKey: string; override;
    function  RegistryKey: string; override;
    function  AdxLocalRegistryKey: string; override;
    function  GetDefaultRegionState: TadxInternalRegionState; override;

    procedure DoInstanceFocused(focused: boolean); override;

    procedure WndProc(var Msg: TMessage); override;

    procedure SetDragItems(ADragItems: TList); override;
    procedure GetDragLayoutParams(var lParams: TadxDragLayoutParams); override;
    procedure SetDragForm(AItemType: TAdxItemType; ALayout: TadxWindowLayout); override;
    function  IsDragDropAllowed: boolean; override;
    function  UseOfficeThemeBackColor: boolean; override;

    function  IsExpandFromMinimizedState: boolean; override;

  public
    constructor CreateEx(AFormsManager: TadxWordTaskPanesManager; AItem: TadxWordTaskPanesCollectionItem); virtual;
    destructor Destroy; override;

    procedure Hide; override;
    procedure Show; override;
    procedure ADXPostMessage(wParam, lParam: Cardinal);

    property WordAppObj: WordApplication read GetWordAppObj;
    property WordApp: TWordApplication read GetWordApp;
    property WordTaskPaneManager: TadxWordTaskPanesManager read FFormsManager;
    property AddinModule: TObject read GetAddinModule;
    property Item: TadxWordTaskPanesCollectionItem read FItem;
    property CurrentWordWindowHandle: HWND read GetCurrentWordWindowHandle;

  published
    property OnADXBeforeTaskPaneShow: TadxBeforeTaskPaneShowEventHandler read FOnADXBeforeFormShow write FOnADXBeforeFormShow;
    property OnADXAfterTaskPaneShow: TadxAfterTaskPaneShowEventHandler read FOnADXAfterFormShow write FOnADXAfterFormShow;
    property OnADXCloseButtonClick: TadxWordCloseButtonClickEventHandler read FOnADXCloseButtonClick write FOnADXCloseButtonClick;

    property OnADXEnter: TadxWordFormEnterEventHandler read FOnADXEnter write FOnADXEnter;
    property OnADXExit: TadxWordFormExitEventHandler read FOnADXExit write FOnADXExit;
    property OnADXPostMessageReceived: TadxWordPostMessageReceivedEventHandler read FOnADXPostMessage write FOnADXPostMessage;
    property OnADXAfterTaskPaneHide: TadxAfterTaskPaneHideEventHandler read FOnADXAfterTaskPaneHide write FOnADXAfterTaskPaneHide;
  end;

  TadxWordTaskPanesManager = class(TComponent)
  private
    hMessageMutex:  THandle;
    FReceiverWindow: Pointer;

    FState: TObject;
    FWordHook: TadxWdHook;

    FWordVersion: integer;
    FItems: TadxWordTaskPanesCollection;
    FAddinModuleEvents: TObject;
    FWordEvents: TObject;
    FOnADXInitialize: TadxInitializeEventHandler;
    FOnADXBeforeFormInstanceCreate: TadxBeforeTaskPaneInstanceCreateEventHandler;
    FOnADXError: TadxErrorEventHandler;
    FLastProcessedContextWindow: HWND;

    procedure AddCloseButtonClickMessageToReceiver();
    procedure AddMayBeViewWasChangedMessageToReceiver();

    procedure HideAllForms();
    procedure DeleteAllForms();

    procedure SetWordVersion;
    function GetItems: TadxWordTaskPanesCollection;
    procedure SetItems(const Value: TadxWordTaskPanesCollection);
    function COMAddInModule: TadxCOMAddInModule;
    function ReceiverWindowHandle: HWND;

    function GetWordAppObj: WordApplication;

    function FindFormByHandle(AFormHandle: HWND): TadxWordTaskPane;
    procedure DoRegionCloseButtonClick(AFormHandle: HWND); overload;
    procedure DoRegionCloseButtonClick(AForm: TadxWordTaskPane); overload;


    procedure DoAddInBeginShutdown(Sender: TObject);
    procedure DoAddInFinalize(Sender: TObject);
    procedure DoAddInInitialize(Sender: TObject);
    procedure DoAddInStartupComplete(Sender: TObject);

    procedure DoProcessAllWordWindows;
    procedure ProcessEnableByCOMAddinsDialog;

    procedure DoADXInitialize;
    procedure DoBeforeFormInstanceCreate(Args: TadxBeforeTaskPaneInstanceCreateEventArgs);

    procedure TryShow(Form: TadxWordTaskPane);
    procedure DoShowForms(AWordContextArgs: TObject);
    procedure DoShowForm(AItem: TadxWordTaskPanesCollectionItem; AWordContextArgs: TObject);
    function GetAdxItemType(Item: TadxWordTaskPanesCollectionItem): TAdxItemType;
    procedure DoProcessContextWindow(AWordContextArgs: TObject);
    procedure DoWindowActivate(AWordContextArgs: TObject);
    procedure DoProtectedWindowActivate(AWordContextArgs: TObject);
    procedure DoDocumentChange(AWordContextArgs: TObject);
    procedure DeleteFormsForNotVisibleHostHandle;

    procedure DoCheckMayBeViewWasChangedMessage(HostHandle: HWND);

    procedure CheckSecondComponent(AOwner: TComponent);

    procedure CreateWordEvents();
    procedure DisposeWordEvents();
    procedure CreateAddinModuleEvents();
    procedure DisposeAddinModuleEvents();
    procedure CreateItems();
    procedure DisposeItems();
    procedure CreateState();
    procedure DisposeState();
    procedure CreateExceptionManager();
    procedure DisposeExceptionManager();
    procedure CreateReceiverWindow();
    procedure DisposeReceiverWindow();
    procedure CreateHook();
    procedure DisposeHook();
    procedure SetFormsManagerSingleton;
    procedure ReleaseFormsManagerSingleton;

    function  AdxRegistryKey: string;
    function  AdxLocalRegistryKey: string;

    function ConvertPositionToAllowedDropPosition(Position: TadxWordTaskPanePosition): TadxAllowedDropPosition;
    procedure LoadPositionsFromRegistry;
    function CheckAllowedDropPosition(Item: TadxWordTaskPanesCollectionItem; WindowLayout: TadxWindowLayout): boolean;
    function CompareAllowedDropPositionsAndWindowLayout(Item: TadxWordTaskPanesCollectionItem; WindowLayout: TadxWindowLayout; AllowedDropPosition: TadxAllowedDropPosition): boolean;
    function GetPosition(ItemType: TadxItemType; WindowLayout: TadxWindowLayout): TadxWordTaskPanePosition;
    function GetPositionSize(Position: TadxWordTaskPanePosition): integer;
    function GetADXWindowLayout(AllowedDropPosition: TadxAllowedDropPosition): TadxWindowLayout;
    function GetWasAddinInitialize: boolean;

    property WasAddinInitialize: boolean read GetWasAddinInitialize;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property WordAppObj: WordApplication read GetWordAppObj;
  published
    property Items: TadxWordTaskPanesCollection read GetItems write SetItems;

    property OnADXInitialize: TadxInitializeEventHandler read FOnADXInitialize write FOnADXInitialize;
    property OnADXBeforeTaskPaneInstanceCreate: TadxBeforeTaskPaneInstanceCreateEventHandler
      read FOnADXBeforeFormInstanceCreate write FOnADXBeforeFormInstanceCreate;
    property OnADXError: TadxErrorEventHandler  read FOnADXError write FOnADXError;
  end;

  TadxWordTaskPanesCollectionItem = class(TCollectionItem)
  private
    FDefaultRegionState: TadxRegionState;
    FFormInstances: TObject;
    FLayout: TadxWordTaskPanePosition;
    FEnabled: boolean;
    FSplitter: TadxWordSplitter;
    FFormClassName: TadxWordTaskPaneClassName;
    FTag: Longint;
    FCloseButton: boolean;
    FAlwaysShowHeader: boolean;
    FRestoreFromMinimizedState: boolean;
    FAllowedDropPositions: TadxAllowedDropPositions;
    FIsDragDropAllowed: boolean;
    FIsHiddenStateAllowed : boolean;
    FRegionBorder: TadxRegionBorderStyle;
    FUseOfficeThemeForBackground: boolean;
    procedure SetPosition(const Value: TadxWordTaskPanePosition);
    procedure SetEnabled(const Value: boolean);
    procedure SetSplitter(const Value: TadxWordSplitter);
    procedure SetFormClassName(const Value: TadxWordTaskPaneClassName);
    procedure SetAlwaysShowHeader(const Value: boolean);
    procedure SetCloseButton(const Value: boolean);

    function GetCurrentTaskPaneInstance: TadxWordTaskPane;
    procedure DeleteAllForms;
    procedure HideAllForms;
    procedure HideAllNotInjectedForms;
    procedure SetAppWindowProperty(AWordContextArgs: TObject; AAppWindowProperty: Pointer);
    function FindForm(HostHandle: HWND): TadxWordTaskPane;
    procedure FormsHideShow;

    function CreateForm: TadxWordTaskPane;
    function GetForm(Cancel: boolean): TadxWordTaskPane;
    function FormsManager: TadxWordTaskPanesManager;
    function GetAdxLayout: integer;
    procedure DeleteFormsForNotVisibleHostHandle;
    function GetTaskPaneInstances(Index: Integer): TadxWordTaskPane;
    function GetTaskPaneInstanceCount: integer;
    function GetDefaultRegionState: TadxRegionState;
    procedure SetDefaultRegionState(const Value: TadxRegionState);
    procedure SetAllowedDropPositions(
      const Value: TadxAllowedDropPositions);

    function ItemRegistryKey: string;
    procedure SavePositionToRegistry;
    procedure LoadPositionFromRegistry;
    procedure AddCurrentPositionToAllowedDropPositions;
    procedure SetIsDragDropAllowed(const Value: boolean);
    class function ConvertPositionToDesignString(Position: TadxWordTaskPanePosition): string;
    procedure SetHideButtonVisible(const Value: boolean);
    procedure SetUseOfficeThemeForBackground(const Value: boolean);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure ShowTaskPane;
    property CurrentTaskPaneInstance: TadxWordTaskPane read GetCurrentTaskPaneInstance;
    property TaskPaneInstanceCount: integer read GetTaskPaneInstanceCount;
    property TaskPaneInstances[Index: Integer]: TadxWordTaskPane read GetTaskPaneInstances;
  published
    property Position: TadxWordTaskPanePosition read FLayout write SetPosition default pUnknown;
    property AllowedDropPositions: TadxAllowedDropPositions read FAllowedDropPositions write SetAllowedDropPositions default [];
    property TaskPaneClassName: TadxWordTaskPaneClassName read FFormClassName write SetFormClassName;
    property Enabled: boolean read FEnabled write SetEnabled default true;
    property Splitter: TadxWordSplitter read FSplitter write SetSplitter default sbStandard;
    property Tag: Longint read FTag write FTag default 0;
    property AlwaysShowHeader: boolean read FAlwaysShowHeader write SetAlwaysShowHeader default false;
    property CloseButton: boolean read FCloseButton write SetCloseButton default false;
    property IsHiddenStateAllowed: boolean read FIsHiddenStateAllowed write SetHideButtonVisible default true;
    property DefaultRegionState: TadxRegionState read GetDefaultRegionState write SetDefaultRegionState default rsNormal;
    property RestoreFromMinimizedState: boolean read FRestoreFromMinimizedState write FRestoreFromMinimizedState default false;
    property IsDragDropAllowed: boolean read FIsDragDropAllowed write SetIsDragDropAllowed default false;
    property RegionBorder: TadxRegionBorderStyle read FRegionBorder write FRegionBorder default rbsSingle;
    property UseOfficeThemeForBackground: boolean read FUseOfficeThemeForBackground write SetUseOfficeThemeForBackground default false;
  end;


  TadxWordTaskPaneClass = class of TadxWordTaskPane;

var
  adxWdForm: TadxWordTaskPane;

function Log: ILog;


implementation

{$R adxWordTaskPane.dfm}

uses Math, ShlObj, ActiveX, Contnrs, Registry;

const
  adxErrorCantContain = 'The %s class cannot be contained in the %s class.';
  adxErrorCantContainEmptyParam = 'The %s param cannot be nil.';
  adxErrorSecondComponent = 'It isn''t possible to place second %s component!';
  adxLCID: Integer = LOCALE_USER_DEFAULT;

  ADXXWD = 'ADXXWD';
  EMPTY = 'EMPTY';

  { Error messages }
  adxECode = 31100;
  adxECodeCantContain = adxECode + 1;

  ribbonStateVisible = 1;
  ribbonStateUnvisible = 0;
  ribbonStateNoRibbon = -1;

var
  FormsManagerSingleton: TadxWordTaskPanesManager;

function Log: ILog;
begin
  result := adxWSbcls.Log;
end;

function ProductVersionAndPackage: string;
var
  r: TRegistry;
begin
  try
    result := 'Unknown';
    r := TRegistry.Create(KEY_READ);
    try
      r.RootKey := HKEY_LOCAL_MACHINE;
      if r.OpenKeyReadOnly('Software\Add-in Express\InstalledProducts\Add-in Express 2007 for VCL\Plugins\ADX Extensions VCL for Microsoft Word') then begin
        if r.ValueExists('Version') then begin
          result := r.ReadString('Version');
          {$IFDEF ADXXOL_TRIAL}
          result := result + ' Trial';
          {$ENDIF}
        end;
        r.CloseKey;
      end;
    finally
      r.Free;
    end;
  except
    result := EmptyStr;
  end;
end;

function AdxShowYesNoError(Mess: string; Caption: string): integer;
begin
  result := MessageBox(0, PChar(Mess), PChar(Caption), MB_YESNO or MB_ICONERROR or MB_APPLMODAL);
end;

procedure AdxShowError(Mess: string; Caption: string);
begin
  MessageBox(0, PChar(Mess), PChar(Caption), MB_OK or MB_ICONERROR or MB_APPLMODAL);
end;

{$IFDEF UNICODE}
function GetWindowText_(Handle: HWND): PChar;
var
  text: array [0..MAX_PATH - 1] of Char;
begin
  FillChar(text, SizeOf(text), 0);                  // <<-- Specify buffer size in bytes
  Windows.GetWindowText(Handle, text, Length(text));// <<-- Count should be chars not bytes
  Result := text;
end;
{$ELSE}
function GetWindowText_(Handle: HWND): PChar;
var
  text: array [0..259] of AnsiChar;
begin
  FillChar(text, 260, 0);
  Windows.GetWindowText(Handle, text, 260);
  Result := text;
end;
{$ENDIF}


{$IFDEF UNICODE}
function GetWindowClassName(Handle: HWND): PChar;
var
  clName: array [0..MAX_PATH - 1] of Char;
begin
  FillChar(clName, SizeOf(clName), 0);
  GetClassName(Handle, clName, Length(clName));
  Result := clName;
end;
{$ELSE}
function GetWindowClassName(Handle: HWND): PChar;
var
  clName: array [0..259] of AnsiChar;
begin
  FillChar(clName, 260, 0);
  GetClassName(Handle, clName, 260);
  Result := clName;
end;
{$ENDIF}


type

  ADXFINDWINDOW = record
    StartHandle: HWND;
    FindHandle: HWND;
    ClassName: PChar;
    Title: PChar;
  end;

  TFindWindow = class
    FindInfo: ADXFINDWINDOW;
    FHandles: TList;
    constructor Create(startHandle, findHandle:HWND; findClassName, findTitle:PChar); overload;
    destructor Destroy; override;
    procedure GetWindows(parentHwnd: HWND);
    property Handles: TList read FHandles write FHandles;
  end;


  TadxWordExceptionManager = class(TadxExceptionManager)
    procedure InternalProcessADXXError(err: SysUtils.Exception; whereHappened: string); override;
  end;

  TEnvelopeCommandBarForWordInspectorPreviwControlFinder = class(TFindWindowObject)
    function FindIn2000(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2002(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2003(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2007(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2010(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
  end;

  TFindWordWindowFactory = class(TFindWindowFactory)
  private
    function GetHostVersion: TadxHostVersion;
  protected
    function CreateSpecificFindWindowObject(ItemType: TadxItemType): TFindWindowObject; override;
  public
    property HostVersion: TadxHostVersion read GetHostVersion;
  end;


  TWordAppWindowBehaviour = class(TAppWindowBehaviour)
  protected
    procedure WM_PARENTNOTIFY_DESTROY(hWnd: THandle; Msg: UINT; wParam, lParam: Longint; appWindow: TAppWindow); override;
    procedure WM_SHOWWINDOW_HIDE(hWnd: THandle; Msg: UINT; wParam, lParam: Longint; appWindow: TAppWindow); override;
    procedure WM_DESTROY(hWnd: THandle; Msg: UINT; wParam, lParam: Longint; appWindow: TAppWindow); override;
    procedure SHOW_WHEN_WINDOWPOSCHANGING(appWindow: TAppWindow); override;
    procedure HIDE_WHEN_WINDOWPOSCHANGING(appWindow: TAppWindow); override;
  end;

  TWordDocumentType = (wdtUnknown, wdtStandard, wdtWordEmailDocument, wdtProtectedWindow);

  TContextCause = (ccUnknown, ccWindowActivate);


  GlobalsWd = class
    class function ADXWdReceiverWindowCaption: string;
    class function WordWindowClassName: string;
  end;


  TadxWordAddinEvents = class
  private
    FCOMAddInModule: TadxCOMAddInModule;
    FFormsManager: TadxWordTaskPanesManager;
    FOldAddInBeginShutdown: TNotifyEvent;
    FOldAddInFinalize: TNotifyEvent;
    FOldAddInInitialize: TNotifyEvent;
    FOldAddInStartupComplete: TNotifyEvent;
    procedure Connect;
    procedure Disconnect;
  public
    constructor Create(AFormsManager: TadxWordTaskPanesManager; ACOMAddInModule: TadxCOMAddInModule);
    destructor Destroy; override;
    procedure OnAddInBeginShutdown(Sender: TObject);
    procedure OnAddInFinalize(Sender: TObject);
    procedure OnAddInInitialize(Sender: TObject);
    procedure OnAddInStartupComplete(Sender: TObject);
  end;


  TadxxWordEvents = class(TadxxCustomEvents)
  private
    FFormsManager: TadxWordTaskPanesManager;
    FIntf: Word2000._Application;
    procedure OnDocumentChange(Sender: TObject);
    procedure OnWindowActivate(ASender: TObject; const Doc: WordDocument; const Wn: Word2000.Window);
    procedure OnProtectedViewWindowActivate(ASender: TObject; const PvWindow: IDispatch);
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    constructor CreateEx(AFormsManager: TadxWordTaskPanesManager);
    procedure ConnectTo(AIntf: IDispatch); overload; override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: integer); overload;
    procedure Disconnect; override;
  end;

  TadxWordTaskPanesManagerState = class
  protected
    isShutdown: boolean;
    WasAddinInitialize: boolean;
    isAddinInitialize: boolean;
    procedure Restore;
  public
    constructor Create;
  end;

  TWordContextArgs = class
  private
    FContextCause: TContextCause;
    FHostHandle: HWND;
    FRibbonHandle: HWND;
    FDocument: Word2000.WordDocument;
    FWindow: Word2000.Window;
    FFormsManager: TadxWordTaskPanesManager;
    FWordApplication: Word2000.WordApplication;
    FDocumentType: TWordDocumentType;
    FProtectedWindow: IDispatch;
    function GetIsValidForTaskPaneCreating: boolean;
    procedure InitializeActiveContext(AHostHandle: HWND);
    procedure SetActiveContextDocumentType;
    procedure SetHostHandleFromActiveWindow;
    procedure SetHostHandleFromMainWindow(WindowName: string);
    procedure SetHostHandle(AHostHandle: HWND);
    procedure SetRibbonHandle;
    function GetRibbonState: integer;
    function GetRibbonAvailable: boolean;
  public
    constructor Create(AFormsManager: TadxWordTaskPanesManager); overload;
    constructor Create(AFormsManager: TadxWordTaskPanesManager; AHostHandle: HWND); overload;
    constructor Create(AFormsManager: TadxWordTaskPanesManager; AProtectedWindow: IDispatch); overload;
    destructor Destroy; override;
    property HostHandle: HWND read FHostHandle;
    property WordDocumentType: TWordDocumentType read FDocumentType;
    property IsValidForTaskPaneCreating: boolean read GetIsValidForTaskPaneCreating;
    property RibbonState: integer read GetRibbonState;
    property RibbonAvailable: boolean read GetRibbonAvailable;
    property ContextCause: TContextCause read FContextCause write FContextCause;
  end;

  TadxWordTaskPanesManagerList = class(TList)
  private
    FOwner: TObject;
  public
    function CountClasses(AClassType: TClass): integer;
    procedure Clear; override;
    constructor Create(AOwner: TObject);
    destructor Destroy; override;
    property Owner: TObject read FOwner;
  end;

  TCustomWindowMessage = class
  private
    FReceiverHandle: HWND;
    FRegisterMessageName: string;
    FMessageID: cardinal;
    procedure RegisterMessage(AMessageName: string);
    function GetMessageID: cardinal;
    function GetRegisterMessageName: string;
    function GetSynchronize: boolean;
  protected
    FSynchronize: boolean;
    function GetMessageName: string; virtual; abstract;
    function ProcessMessage(wParam: integer; lParam: integer): integer; virtual; abstract;
  public
    StopProcess: boolean;
    constructor Create(ReceiverHandle: HWND);
    function SendMessage(wParam: integer; lParam: integer): integer;
    procedure PostMessage(wParam: integer; lParam: integer);
    function DoProcessMessage(wParam: integer; lParam: integer): integer;
    property MessageName: string read GetRegisterMessageName;
    property MessageID: cardinal read GetMessageID;
    property Synchronize: boolean read GetSynchronize;
  end;

  TRegionCloseButtonClickMessage = class(TCustomWindowMessage)
  private
    FFormsManager: TadxWordTaskPanesManager;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; AFormsManager: TadxWordTaskPanesManager);
    destructor Destroy; override;
  end;

  TMayBeViewWasChangedMessage = class(TCustomWindowMessage)
  private
    FFormsManager: TadxWordTaskPanesManager;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; AFormsManager: TadxWordTaskPanesManager);
    destructor Destroy; override;
  end;

  TadxReceiverWindow = class(TWinControl)
  private
    FCustomMessages: TList;
    FExecute: boolean;
    FCountCustomMessages: integer;
    procedure SetExecute(const Value: boolean);
  public
    procedure WndProc(var Message: TMessage); override;
    constructor CreateEx(AOwner: TComponent; ACaption: string);
    destructor Destroy; override;
    function RegisterMessage(Msg: Cardinal): boolean;
    procedure AddReceiverCustomMessage(CustomWindowMessage: TCustomWindowMessage);
    function Exists(customWindowMessageType: TClass): boolean;
    property Execute: boolean read FExecute write SetExecute;
  end;


{ TadxErrorEventArgs }

constructor TadxErrorEventArgs.Create(AE: Exception);
begin

end;

destructor TadxErrorEventArgs.Destroy;
begin

  inherited;
end;

procedure TadxErrorEventArgs.SetHandled(const Value: boolean);
begin
  FHandled := value;
end;

{ TadxInitializeEventArgs }

constructor TadxInitializeEventArgs.Create;
begin

end;

destructor TadxInitializeEventArgs.Destroy;
begin

  inherited;
end;

{ TadxBeforeTaskPaneShowEventArgs }

constructor TadxBeforeTaskPaneShowEventArgs.Create;
begin

end;

destructor TadxBeforeTaskPaneShowEventArgs.Destroy;
begin

  inherited;
end;

{ TadxAfterTaskPaneShowEventArgs }

constructor TadxAfterTaskPaneShowEventArgs.Create;
begin

end;

destructor TadxAfterTaskPaneShowEventArgs.Destroy;
begin

  inherited;
end;



{ TadxBeforeTaskPaneInstanceCreateEventArgs }

constructor TadxBeforeTaskPaneInstanceCreateEventArgs.Create(
  AItem: TadxWordTaskPanesCollectionItem; ADefaultCancel: boolean);
begin
  FCancel := ADefaultCancel;
  FItem := AItem;
end;

destructor TadxBeforeTaskPaneInstanceCreateEventArgs.Destroy;
begin
  FItem := nil;
  inherited;
end;

{ TadxWordTaskPanesCollectionItem }

constructor TadxWordTaskPanesCollectionItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FRegionBorder := rbsSingle;
  FIsHiddenStateAllowed := true;
  FEnabled := true;
  FSplitter := sbStandard;
  FUseOfficeThemeForBackground:= false;
  FFormInstances := TadxWordTaskPanesManagerList.Create(Self);
end;

function TadxWordTaskPanesCollectionItem.CreateForm: TadxWordTaskPane;
var
  p: TPersistentClass;
begin
  Log.AddMessage('TadxWordTaskPanesCollectionItem.CreateForm');
  try
    p := GetClass(TaskPaneClassName);
    result := TadxWordTaskPaneClass(p).CreateEx(FormsManager, self);
    if (result <> nil) then begin
      TadxWordTaskPanesManagerList(FFormInstances).Add(result);
      result.UpdateColor(FormsManager.FWordVersion);
    end;
  except
    on Ex:SysUtils.Exception do begin
      raise SysUtils.Exception.Create('TadxWordTaskPanesCollectionItem.CreateForm: ' + Ex.Message);
    end;
  end;
end;

procedure TadxWordTaskPanesCollectionItem.DeleteAllForms;
var
  Form: TadxWordTaskPane;
  FormIndex: integer;
begin
  Log.AddMessage('TadxWordTaskPanesCollectionItem.DeleteAllForms ' + IntToStr(TadxWordTaskPanesManagerList(FFormInstances).Count));
  try
    Log.AddIndent();
    try
      FormIndex := 0;
      while FormIndex < TadxWordTaskPanesManagerList(FFormInstances).Count do begin
        if TadxWordTaskPanesManagerList(FFormInstances)[FormIndex] <> nil then begin
          Form := TadxWordTaskPanesManagerList(FFormInstances)[FormIndex];
          Form.Free;
          TadxWordTaskPanesManagerList(FFormInstances).Delete(FormIndex);
          Dec(FormIndex);
        end;
        Inc(FormIndex);
      end;
    finally
      Log.RemoveIndent();
    end;
  except
    on E: SysUtils.Exception do begin
      Log.AddException('TadxWordTaskPanesCollectionItem.DeleteAllForms: ' + E.Message);
      raise E;
    end;
  end;
end;

procedure TadxWordTaskPanesCollectionItem.DeleteFormsForNotVisibleHostHandle;
var
  Form: TadxWordTaskPane;
  FormIndex: integer;
begin
  Log.AddMessage('TadxWordTaskPanesCollectionItem.DeleteFormsForNotVisibleHostHandle ' + IntToStr(TadxWordTaskPanesManagerList(FFormInstances).Count));
  try
    Log.AddIndent();
    try
      FormIndex := 0;
      while FormIndex < TadxWordTaskPanesManagerList(FFormInstances).Count do begin
        if TadxWordTaskPanesManagerList(FFormInstances)[FormIndex] <> nil then begin
          Form := TadxWordTaskPanesManagerList(FFormInstances)[FormIndex];
          if (not Windows.IsWindowVisible(Form.FHostHandle)) then begin
            Form.Free;
            TadxWordTaskPanesManagerList(FFormInstances).Delete(FormIndex);
            Dec(FormIndex);
          end;
        end;
        Inc(FormIndex);
      end;
    finally
      Log.RemoveIndent();
    end;
  except
    on E: SysUtils.Exception do begin
      Log.AddException('TadxWordTaskPanesCollectionItem.DeleteAllForms: ' + E.Message);
      raise E;
    end;
  end;
end;

destructor TadxWordTaskPanesCollectionItem.Destroy;
begin
  if Assigned(FFormInstances) then begin
    FFormInstances.Free;
  end;
  inherited;
end;

function TadxWordTaskPanesCollectionItem.FindForm(HostHandle: HWND): TadxWordTaskPane;
var
  i: integer;
begin
  Log.AddMessage('TadxWordTaskPanesCollectionItem.FindForm');
  result := nil;
  for i:=0 to TadxWordTaskPanesManagerList(FFormInstances).Count - 1 do begin
    if (TadxWordTaskPane(TadxWordTaskPanesManagerList(FFormInstances)[i]).FHostHandle = HostHandle) then begin
      result := TadxWordTaskPane(TadxWordTaskPanesManagerList(FFormInstances)[i]);
    end;
  end;
end;

procedure TadxWordTaskPanesCollectionItem.FormsHideShow;
var
  index: integer;
begin
  Log.AddMessage('TadxWordTaskPanesCollectionItem.FormsHideShow');
  for index := 0 to TadxWordTaskPanesManagerList(FFormInstances).Count - 1 do begin
    if TadxWordTaskPanesManagerList(FFormInstances)[index] <> nil then begin
      if TadxWordTaskPane(TadxWordTaskPanesManagerList(FFormInstances)[index]).Visible then begin
        if (not TadxWordTaskPane(TadxWordTaskPanesManagerList(FFormInstances)[index]).LockVisible) then begin
          TadxWordTaskPane(TadxWordTaskPanesManagerList(FFormInstances)[index]).ADXWdHide(true);
          FormsManager.TryShow(TadxWordTaskPane(TadxWordTaskPanesManagerList(FFormInstances)[index]));
        end;
      end;
    end;
  end;
end;

function TadxWordTaskPanesCollectionItem.GetAdxLayout: integer;
begin
  case Position of
      pTop: result := wlTop;
      pBottom: result := wlBottom;
      pRight: result := wlRight;
      pLeft: result := wlLeft;
    else begin
      raise SysUtils.Exception.Create('GetAdxLayout: The accordance not found.');
    end;
  end;
end;

function TadxWordTaskPanesCollectionItem.GetForm(Cancel: boolean): TadxWordTaskPane;
begin
  Log.AddMessage('TadxWordTaskPanesCollectionItem.GetForm');
  result := nil;
  if not Cancel then begin
    result := CreateForm;
    if (result = nil) then begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxWordTaskPanesCollectionItem.GetForm: A form has not been created.'), 'GetForm')
    end;
  end;
end;

function TadxWordTaskPanesCollectionItem.GetCurrentTaskPaneInstance: TadxWordTaskPane;
var
  ActiveWindowHandle: HWND;
  i: integer;
  FWindow: Word2000.Window;

begin
  Log.AddMessage('TadxWordTaskPanesCollectionItem.GetCurrentTaskPaneInstance');
  ActiveWindowHandle := APIUtils.GetActiveWindow(GlobalsWD.WordWindowClassName);
  if (ActiveWindowHandle = 0) then begin
    try
      FWindow := FormsManagerSingleton.WordAppObj.ActiveWindow;
    except
      FWindow := nil;
    end;

    if (FWindow <> nil) then begin
      ActiveWindowHandle := FindMainWindowInProcess(GetDesktopWindow(), FWindow.Caption, GlobalsWD.WordWindowClassName, false);
    end;

  end;
  result := nil;
  for i := 0 to TadxWordTaskPanesManagerList(FFormInstances).Count - 1 do begin
    if (TadxWordTaskPane(TadxWordTaskPanesManagerList(FFormInstances)[i]).FHostHandle = ActiveWindowHandle)
      or (TadxWordTaskPane(TadxWordTaskPanesManagerList(FFormInstances)[i]).Handle = ActiveWindowHandle) then begin
      result := TadxWordTaskPane(TadxWordTaskPanesManagerList(FFormInstances)[i]);
    end;
  end;
end;

function TadxWordTaskPanesCollectionItem.FormsManager: TadxWordTaskPanesManager;
begin
  try
  {$IFDEF ADX_VCL5}
      result := TadxWordTaskPanesManager(TadxWordTaskPanesCollection(Collection).GetOwner)
  {$ELSE}
      result := TadxWordTaskPanesManager(Collection.Owner);
  {$ENDIF}
  except
    on Ex: SysUtils.Exception do begin
      raise SysUtils.Exception.Create('TadxWordTaskPanesCollectionItem.FormsManager: ' + Ex.Message);
    end;
  end;
end;

procedure TadxWordTaskPanesCollectionItem.HideAllForms;
var
  index: integer;
begin
  Log.AddMessage('TadxWordTaskPanesCollectionItem.HideAllForms');
  for index := 0 to TadxWordTaskPanesManagerList(FFormInstances).Count - 1 do begin
    if TadxWordTaskPanesManagerList(FFormInstances)[index] <> nil then begin
      if TadxWordTaskPane(TadxWordTaskPanesManagerList(FFormInstances)[index]).Visible then begin
        TadxWordTaskPane(TadxWordTaskPanesManagerList(FFormInstances)[index]).ADXWdHide(true);
      end;
    end;
  end;
end;

procedure TadxWordTaskPanesCollectionItem.SetAppWindowProperty(
  AWordContextArgs: TObject; AAppWindowProperty: Pointer);
var
  WordContextArgs: TWordContextArgs;
  ContextAdxItemType: TAdxItemType;
  AppWindowProperty :PAppWindowProperty;

begin
  Log.AddMessage('TadxWordTaskPanesCollectionItem.SetAppWindowProperty');
  AppWindowProperty := PAppWindowProperty(AAppWindowProperty);

  WordContextArgs := TWordContextArgs(AWordContextArgs);

  ContextAdxItemType := FormsManager.GetAdxItemType(self);
  if (ContextAdxItemType > 0) then begin
    AppWindowProperty^.HostHandle := WordContextArgs.FHostHandle;
    AppWindowProperty^.ItemType := ContextAdxItemType;
    AppWindowProperty^.WindowHandle := GetAppWindowHandle(Ord(FormsManager.FWordVersion), ContextAdxItemType, WordContextArgs.FHostHandle);

    AppWindowProperty^.Offset := GetOffset(FormsManager.FWordVersion, ContextAdxItemType);
    AppWindowProperty^.Layout := Self.GetAdxLayout();
    AppWindowProperty^.ContainerType := 0;

    AppWindowProperty^.AlwaysShowHeader:= AlwaysShowHeader;
    AppWindowProperty^.CloseButton:= CloseButton;
    AppWindowProperty^.SplitterButton := IsHiddenStateAllowed;
    AppWindowProperty^.RegionBorder := RegionBorder;

    AppWindowProperty^.HostVersion  := FormsManager.FWordVersion;
    AppWindowProperty^.Splitter := Ord(Self.Splitter);
  end;
end;

procedure TadxWordTaskPanesCollectionItem.SetEnabled(const Value: boolean);
begin
  if (self.FEnabled <> Value) then begin
    self.FEnabled := Value;
    DeleteAllForms;
  end;
end;

procedure TadxWordTaskPanesCollectionItem.SetFormClassName(
  const Value: TadxWordTaskPaneClassName);
begin
  if (not Globals.CompareADXStrings(Self.FFormClassName, Value)) then begin
    Log.AddMessage('TadxWordTaskPanesCollectionItem.SetFormClassName');
    Self.FFormClassName := Value;
    DeleteAllForms();
  end;
end;

procedure TadxWordTaskPanesCollectionItem.SetPosition(const Value: TadxWordTaskPanePosition);
begin
  if (FLayout <> Value) then begin
    FLayout := Value;
    AddCurrentPositionToAllowedDropPositions;
    if not (csDesigning in self.FormsManager.ComponentState) then begin
      FormsHideShow;
      if (FormsManager.WasAddinInitialize) then begin
        SavePositionToRegistry();
      end;
    end;
  end;
end;

procedure TadxWordTaskPanesCollectionItem.SetSplitter(
  const Value: TadxWordSplitter);
begin
  if (self.FSplitter <> Value) then begin
    self.FSplitter :=Value;
  end;
end;

procedure TadxWordTaskPanesCollectionItem.SetUseOfficeThemeForBackground(const Value: boolean);
var
  taskPane: TadxWordTaskPane;
  i: integer;
begin
  if FUseOfficeThemeForBackground <> Value then begin
    FUseOfficeThemeForBackground := Value;
    for i:= 0 to TaskPaneInstanceCount- 1 do begin
      taskPane:= TaskPaneInstances[i];
      if Assigned(taskPane) then begin
        if FUseOfficeThemeForBackground then
          taskPane.Color := taskPane.GetBackColor()
        else
          taskPane.Color := taskPane.OldColor;
      end;
    end;
  end;
end;

function TadxWordTaskPanesCollectionItem.GetDefaultRegionState: TadxRegionState;
begin
  result := FDefaultRegionState;
end;

procedure TadxWordTaskPanesCollectionItem.SetDefaultRegionState(
  const Value: TadxRegionState);
begin
  if (FDefaultRegionState <> value) then begin
    FDefaultRegionState := value;
    if (not IsHiddenStateAllowed) and (FDefaultRegionState = rsHidden) then begin
      self.FDefaultRegionState := rsMinimized;
    end;
    if (FDefaultRegionState = rsMinimized) then begin
      self.AlwaysShowHeader := true;
    end;
  end;
end;

procedure TadxWordTaskPanesCollectionItem.SetAllowedDropPositions(
  const Value: TadxAllowedDropPositions);
begin
  FAllowedDropPositions := Value;
  AddCurrentPositionToAllowedDropPositions;
end;

procedure TadxWordTaskPanesCollectionItem.AddCurrentPositionToAllowedDropPositions;
begin
  if (IsDragDropAllowed) then begin
     if (self.Position <> pUnknown) then begin
       self.FAllowedDropPositions := self.FAllowedDropPositions + [FormsManager.ConvertPositionToAllowedDropPosition(self.Position)];
     end;
  end;
end;

function TadxWordTaskPanesCollectionItem.ItemRegistryKey: string;
begin
  result := FormsManager.AdxLocalRegistryKey + '\' + self.ClassName + IntToStr(self.Index);
end;

procedure TadxWordTaskPanesCollectionItem.LoadPositionFromRegistry;
var
  Reg: TRegistry;
begin
  if (IsDragDropAllowed) then begin
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.KeyExists(ItemRegistryKey) then begin
        Reg.OpenKey(ItemRegistryKey, false);
        if Reg.ValueExists('Position') then begin
          self.Position := TadxWordTaskPanePosition(Reg.ReadInteger('Position'));
        end;
      end;
    finally
      Reg.CloseKey;
      Reg.Free;
    end;
  end;
end;

procedure TadxWordTaskPanesCollectionItem.SavePositionToRegistry;
var
  Reg: TRegistry;
begin
  if (IsDragDropAllowed) then begin
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CURRENT_USER;
      if (Reg.OpenKey(ItemRegistryKey, true)) then begin
        Reg.WriteInteger('Position', ord(self.Position));
      end;
    finally
      Reg.CloseKey;
      Reg.Free;
    end;
  end;
end;

procedure TadxWordTaskPanesCollectionItem.SetIsDragDropAllowed(
  const Value: boolean);
begin
  FIsDragDropAllowed := Value;
  if (FIsDragDropAllowed) then begin
    FAlwaysShowHeader := true;
    AddCurrentPositionToAllowedDropPositions;
  end;
end;

class function TadxWordTaskPanesCollectionItem.ConvertPositionToDesignString(
  Position: TadxWordTaskPanePosition): string;
begin
  case Position of
    pUnknown: result := 'pUnknown';
    pTop:     result := 'pTop';
    pBottom:  result := 'pBottom';
    pRight:   result := 'pRight';
    pLeft:    result := 'pLeft';
  end;
end;

procedure TadxWordTaskPanesCollectionItem.SetHideButtonVisible(
  const Value: boolean);
begin
  FIsHiddenStateAllowed  := Value;
  if (not FIsHiddenStateAllowed) and (self.DefaultRegionState = rsHidden) then begin
    self.DefaultRegionState := rsMinimized;
  end;
end;

{ TadxWordTaskPanesCollection }

function TadxWordTaskPanesCollection.Add: TadxWordTaskPanesCollectionItem;
begin
  Result := TadxWordTaskPanesCollectionItem.Create(Self);
  if (csDesigning in TadxWordTaskPanesManager(Owner).ComponentState) then begin
    Result.UseOfficeThemeForBackground := true;
  end;
end;

function TadxWordTaskPanesCollection.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := 'Name';
    1: Result := 'TaskPaneClassName';
    2: Result := 'Position';
  else
    Result := '';
  end;
end;

function TadxWordTaskPanesCollection.GetAttrCount: Integer;
begin
  Result := 3;
end;

function TadxWordTaskPanesCollection.GetItem(
  Index: Integer): TadxWordTaskPanesCollectionItem;
begin
  Result := TadxWordTaskPanesCollectionItem(inherited Items[Index]);
end;

function TadxWordTaskPanesCollection.GetItemAttr(Index,
  ItemIndex: Integer): string;
begin
  case Index of
    0: Result := Format('%d - ', [ItemIndex]) + Items[ItemIndex].ClassName;
    1: Result := Items[ItemIndex].TaskPaneClassName;
    2: Result := TadxWordTaskPanesCollectionItem.ConvertPositionToDesignString(Items[ItemIndex].Position);
  else
    Result := '';
  end;
end;

{$IFDEF ADX_VCL5}
function TadxWordTaskPanesCollection.Owner: TPersistent;
begin
  Result:= GetOwner;
end;
{$ENDIF}

procedure TadxWordTaskPanesCollection.SetItem(Index: Integer;
  Value: TadxWordTaskPanesCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TadxWordTaskPane }

procedure TadxWordTaskPane.AdxWdShow(AAppWindowProperty: Pointer;
  raiseEvents: boolean);
var
  adxCaption: TadxCaption;
  WishfulVisible: boolean;
  BeforeFormShowEventArgs: TadxBeforeTaskPaneShowEventArgs;
  AfterFormShowEventArgs: TadxAfterTaskPaneShowEventArgs;
begin
  Log.AddMessage('TadxWordTaskPane.AdxWdShow');

  WishfulVisible := True;
  try
  StrPCopy(adxCaption,  Self.Caption);
  PAppWindowProperty(AAppWindowProperty)^.Caption := adxCaption;
  if Assigned(Self.OnADXBeforeTaskPaneShow) then begin
    Self.LockVisible := true;
    Visible := true;
    if raiseEvents then begin
      BeforeFormShowEventArgs := TadxBeforeTaskPaneShowEventArgs.Create;
      try
        DoADXBeforeTaskPaneShow(BeforeFormShowEventArgs);
      finally
        if Assigned(BeforeFormShowEventArgs) then begin
          BeforeFormShowEventArgs.Free;
        end;
      end;
    end;

    UpdateAppWindowPropertyAfterBeforeFormShowEvent(AAppWindowProperty);

    WishfulVisible := Visible;
    Self.LockVisible := false;
  end;

  if WishfulVisible then begin

    //Update Item properties
    PAppWindowProperty(AAppWindowProperty)^.Layout := Item.GetAdxLayout();
    FWindowHandle :=  PAppWindowProperty(AAppWindowProperty)^.WindowHandle;
    Self.InitProperties(AAppWindowProperty);
    Self.ShowInternal;
    if Assigned(Self.OnADXAfterTaskPaneShow) then begin
      if (raiseEvents) then begin
        AfterFormShowEventArgs := TadxAfterTaskPaneShowEventArgs.Create;
        try
          DoADXAfterFormShow(AfterFormShowEventArgs);
        finally
          if Assigned(AfterFormShowEventArgs) then begin
            AfterFormShowEventArgs.Free;
          end;
        end;
      end;
    end;
  end
  else begin
    FisHiddenByDeveloper := true;
  end;
  except
    on E:SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('AdxPpShow: ' + E.Message), 'AdxPpShow');
    end;
  end;
end;

procedure TadxWordTaskPane.ADXWdHide(raiseEvents: boolean);
var
  AfterTaskPaneHideEventArgs: TadxAfterTaskPaneHideEventArgs;
  NeedToRaiseAfterFormHideEvent: boolean;
begin
  Log.AddMessage('TadxWordTaskPane.ADXWdHide');
  if LockVisible then begin
    Visible := false;
  end
  else begin
    NeedToRaiseAfterFormHideEvent := self.Visible and self.Injected;
    inherited Hide;
    DisposeWordObjects;

    if (raiseEvents and NeedToRaiseAfterFormHideEvent) then begin
      AfterTaskPaneHideEventArgs := TadxAfterTaskPaneHideEventArgs.Create;
      try
        DoADXAfterTaskPaneHide(AfterTaskPaneHideEventArgs);
      finally
        AfterTaskPaneHideEventArgs.Free;
      end;
    end;
  end;
end;

constructor TadxWordTaskPane.CreateEx(AFormsManager: TadxWordTaskPanesManager;
  AItem: TadxWordTaskPanesCollectionItem);
begin
  Log.AddMessage('TadxWordTaskPane.CreateEx');
  try
    inherited Create(AFormsManager);
    if not (csDesigning in self.ComponentState) then begin
      FFormsManager := AFormsManager as TadxWordTaskPanesManager;
      FItem := AItem as TadxWordTaskPanesCollectionItem;
      FisHiddenByDeveloper := false;
    end;
  except
    on E: SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'TadxWordTaskPane.CreateEx');
      raise E;
    end;
  end;
end;

destructor TadxWordTaskPane.Destroy;
var
  index: integer;
begin
  Log.AddMessage('TadxWordTaskPane.Destroy');
  if not (csDesigning in self.ComponentState) then begin
    if self.Visible then
      self.Hide();

    index := TadxWordTaskPanesManagerList(FItem.FFormInstances).IndexOf(self);
    TadxWordTaskPanesManagerList(FItem.FFormInstances)[index] := nil;
    FItem := nil;
    FFormsManager := nil;
  end;
  Log.AddMessage('TadxWordTaskPane.Destroy.inherited');
  inherited;
end;

procedure TadxWordTaskPane.DisposeWordObjects;
begin
  //
end;

procedure TadxWordTaskPane.DoADXAfterFormShow(
  Args: TadxAfterTaskPaneShowEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnADXAfterTaskPaneShow) then begin
    try
      event := TadxEventRaising.Create('OnADXAfterTaskPaneShow', [eoAvailableRegionState]);
      try
        OnADXAfterTaskPaneShow(self, Args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoADXAfterFormShow');
      end;
    end;
  end;
end;

procedure TadxWordTaskPane.DoADXAfterTaskPaneHide(
  args: TadxAfterTaskPaneHideEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnADXAfterTaskPaneHide) then begin
    try
      event := TadxEventRaising.Create('OnADXAfterTaskPaneHide', [eoLockRegionState]);
      try
        OnADXAfterTaskPaneHide(self, args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoADXAfterTaskPaneHide');
      end;
    end;
  end;
end;

procedure TadxWordTaskPane.DoADXBeforeTaskPaneShow(
  Args: TadxBeforeTaskPaneShowEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnADXBeforeTaskPaneShow) then begin
    try
      event := TadxEventRaising.Create('OnADXBeforeTaskPaneShow', [eoAvailableRegionState]);
      try
        OnADXBeforeTaskPaneShow(self, Args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnADXBeforeTaskPaneShow');
      end;
    end;
  end;
end;

function TadxWordTaskPane.GetAddinModule: TObject;
begin
  result := nil;
  if (FFormsManager <> nil) then begin
    result := FFormsManager.Owner;
  end;
end;

function TadxWordTaskPane.GetWordAppObj: WordApplication;
begin
  if (FFormsManager <> nil) then begin
    result := FFormsManager.WordAppObj;
  end;
end;

procedure TadxWordTaskPane.InitializeForm(AWordContextArgs: TObject; AAppWindowProperty: Pointer);
var
  Context: TWordContextArgs;
begin
  Log.AddMessage('TadxWordTaskPane.InitializeForm');
  Context := TWordContextArgs(AWordContextArgs);
  FHostHandle := Context.FHostHandle;
  CopyAppWindowProperty(FAppWindowProperty, AAppWindowProperty);  
end;

procedure TadxWordTaskPane.DoInstanceFocused(focused: boolean);
var
  argsEnter: TadxWordEnterEventArgs;
  argsExit: TadxWordExitEventArgs;
begin
  Log.AddMessage('TadxWordTaskPane.DoInstanceFocused');
  try
    if focused then begin
      argsEnter:= TadxWordEnterEventArgs.Create;
      try
        DoAdxEnter(argsEnter)
      finally
        if Assigned(argsEnter) then
          FreeAndNil(argsEnter);
      end;
    end
    else begin
      argsExit:= TadxWordExitEventArgs.Create;
      try
        DoAdxExit(argsExit);
      finally
        if Assigned(argsExit) then
          FreeAndNil(argsExit);
      end;
    end;
  except
    on e: SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'TadxWordTaskPane.DoInstanceFocused: ' + e.Message);
    end;
  end;
end;

procedure TadxWordTaskPane.DoReceiveAdxPostMessageCluster(msg: TMessage);
var
  postMessageArgs: TadxWordPostMessageReceivedEventArgs;
begin
  Log.AddMessage('TadxWordTaskPane.DoReceiveAdxPostMessageCluster');
  postMessageArgs:= TadxWordPostMessageReceivedEventArgs.Create;
  try
    Log.AddMessage(ClassName+'.DoReceiveAdxPostMessageCluster');
    ReceiveMessageCluster(msg, postMessageArgs.wParam, postMessageArgs.lParam);
    DoAdxPostMessage(postMessageArgs);
  finally
    if Assigned(postMessageArgs) then
      FreeAndNil(postMessageArgs);
  end;
end;

procedure TadxWordTaskPane.WndProc(var Msg: TMessage);
begin
  if not (csDesigning in self.ComponentState) then begin
    if msg.Msg = WM_ADXCOMMAND then begin
      try
        case msg.WParam of
          adxPostMessageCmd: begin
            DoReceiveAdxPostMessageCluster(msg);
          end
        else
          inherited WndProc(Msg);
        end;
      except
        on e: Exception do begin
          TadxExceptionManager.ProcessADXXError(E, format('TadxWordTaskPane.WndProc: Msg= WM_ADXCOMMAND wParam= %x lParam= %x : %s', [Msg.WParam, Msg.LParam, e.Message]));
        end;
      end;
      exit;
    end;
  end;
  inherited WndProc(Msg);
end;

{ TadxWordTaskPaneManager }

procedure TadxWordTaskPanesManager.AddCloseButtonClickMessageToReceiver;
begin
  Log.AddMessage('AddCloseButtonClickMessageToReceiver');
  if (not TadxReceiverWindow(FReceiverWindow).Exists(TRegionCloseButtonClickMessage)) then
    TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
      (TRegionCloseButtonClickMessage.Create(self.ReceiverWindowHandle, self));
end;

procedure TadxWordTaskPanesManager.CheckSecondComponent(AOwner: TComponent);
var
  i: integer;
begin
  for i := 0 to AOwner.ComponentCount - 1 do begin
    if (AOwner.Components[i] is TadxWordTaskPanesManager) then begin
      raise EADXException.Create(Format(adxErrorSecondComponent, [ClassName]), adxECodeCantContain, 0);
    end;
  end;
end;

function TadxWordTaskPanesManager.COMAddInModule: TadxCOMAddInModule;
begin
  try
    result := Owner as TadxCOMAddInModule;
  except
    on E: SysUtils.Exception do begin
      Log.AddException('TadxWordTaskPanesManager.COMAddInModule: ' + E.Message);
      result := nil;
    end;
  end;
end;

constructor TadxWordTaskPanesManager.Create(AOwner: TComponent);
begin
  FLastProcessedContextWindow := 0;
  FState := nil;
  try
    if not (csDesigning in self.ComponentState) then begin
      Log.AddSystemInfo('Time: ' + DateTimeToStr(Now));
      Log.AddSystemInfo('Package: ' + ProductVersionAndPackage);
      Log.AddSystemInfo('ADX Version:' + adxVersion);
      Log.AddSystemInfo('ADX Extensions Version 6.1.754');
      Log.AddMessage('TadxWordTaskPanesManager.Create');
    end;

    if AOwner = nil then begin
      raise EADXException.Create(Format(adxErrorCantContain, [ClassName, 'nil']), adxECodeCantContain, 0);
    end;
    if not (AOwner is TadxCOMAddInModule) then begin
      raise EADXException.Create(Format(adxErrorCantContain, [ClassName, AOwner.ClassName]), adxECodeCantContain, 0);
    end;

    CheckSecondComponent(AOwner);

    inherited Create(AOwner);
    CreateItems();

    if not (csDesigning in self.ComponentState) then begin
      CreateState();
      SetFormsManagerSingleton();
      CreateAddinModuleEvents();
    end;
  except
    on E:SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create(E.Message), 'TadxWordTaskPanesManager.Create');
    end;
  end;
end;


procedure TadxWordTaskPanesManager.CreateAddinModuleEvents;
begin
  if (Owner is TadxCOMAddInModule) then begin
    FAddinModuleEvents := TadxWordAddinEvents.Create(self,
      self.Owner as TadxCOMAddInModule);
  end;
end;

procedure TadxWordTaskPanesManager.CreateExceptionManager;
begin
  ExceptionManager := TADXWordExceptionManager.Create;
end;

procedure TadxWordTaskPanesManager.CreateHook;
begin
  FWordHook := TadxWdHook.CreateEx(self.FWordVersion, 0);
end;

procedure TadxWordTaskPanesManager.CreateItems;
begin
  FItems := TadxWordTaskPanesCollection.Create(Self, TadxWordTaskPanesCollectionItem);
end;

procedure TadxWordTaskPanesManager.CreateReceiverWindow;
begin
  FReceiverWindow := TadxReceiverWindow.CreateEx(
    Self, GlobalsWd.ADXWdReceiverWindowCaption);
  AddCloseButtonClickMessageToReceiver();
  AddMayBeViewWasChangedMessageToReceiver();
end;

procedure TadxWordTaskPanesManager.CreateState;
begin
  FState := TadxWordTaskPanesManagerState.Create;
end;

procedure TadxWordTaskPanesManager.CreateWordEvents;
begin
  FWordEvents := TadxxWordEvents.CreateEx(self);
  TadxxWordEvents(FWordEvents).ConnectTo(WordAppObj, FWordVersion);
end;

procedure TadxWordTaskPanesManager.DeleteAllForms;
var
  index: integer;
begin
  Log.AddMessage('TadxWordTaskPanesManager.DeleteAllForms');
  HideAllForms();
  try
    for index := 0 to Items.Count - 1 do begin
      Items[index].DeleteAllForms;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DeleteAllForms: ' + E.Message), 'DeleteAllForms');
  end;
end;

procedure TadxWordTaskPanesManager.DeleteFormsForNotVisibleHostHandle;
var
  index: integer;
begin
  Log.AddMessage('TadxWordTaskPanesManager.DeleteFormsForNotVisibleHostHandle');
  try
    for index := 0 to Items.Count - 1 do begin
      Items[index].DeleteFormsForNotVisibleHostHandle;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DeleteFormsForNotVisibleHostHandle: ' + E.Message), 'DeleteFormsForNotVisibleHostHandle');
  end;
end;

destructor TadxWordTaskPanesManager.Destroy;
begin

  if not (csDesigning in self.ComponentState) then begin
    ReleaseFormsManagerSingleton;
    DisposeAddinModuleEvents;
    DisposeWordEvents;
    DisposeReceiverWindow;
    DisposeState;
    DisposeHook;
    DisposeExceptionManager();
  end;
  DisposeItems;
  inherited Destroy;
end;

procedure TadxWordTaskPanesManager.DisposeAddinModuleEvents;
begin
  if Assigned(FAddinModuleEvents) then begin
    FAddinModuleEvents.Free;
    FAddinModuleEvents := nil;
  end;
end;

procedure TadxWordTaskPanesManager.DisposeExceptionManager;
begin
  if (ExceptionManager <> nil) then begin
    ExceptionManager.Free;
    ExceptionManager := nil;
  end;
end;

procedure TadxWordTaskPanesManager.DisposeHook;
begin
  if Assigned(FWordHook) then begin
    FWordHook.Free;
    FWordHook := nil;
  end;
end;

procedure TadxWordTaskPanesManager.DisposeItems;
begin
  if Assigned(FItems) then begin
    FItems.Clear;
    FItems.Free;
    FItems := nil;
  end;
end;

procedure TadxWordTaskPanesManager.DisposeReceiverWindow;
begin
  if (FReceiverWindow <> nil) then begin
    TadxReceiverWindow(FReceiverWindow).Free;
    FReceiverWindow := nil;
  end;
end;

procedure TadxWordTaskPanesManager.DisposeState;
begin
  if (FState <> nil) then begin
    FState.Free;
    FState := nil;
  end;
end;

procedure TadxWordTaskPanesManager.DisposeWordEvents;
begin
  if Assigned(FWordEvents) then begin
    TadxxWordEvents(FWordEvents).Disconnect;
    FWordEvents.Free;
    FWordEvents := nil;
  end;
end;

procedure TadxWordTaskPanesManager.DoAddInBeginShutdown(Sender: TObject);
begin
  if (COMAddInModule.HostType <> ohaWord) then begin
    exit;
  end;

  Log.AddMessage('TadxWordTaskPanesManager.DoAddInBeginShutdown');

  try
    TadxWordTaskPanesManagerState(FState).isShutdown := true;
    HideAllForms();
    DeleteAllForms();
    DisposeHook();
    DisposeWordEvents();

    TAppWindowBehaviour.SingletonFree;
    TFindWindowFactory.SingletonFree;
	finally
		TadxWordTaskPanesManagerState(FState).isShutdown := false;
  end;
end;

procedure TadxWordTaskPanesManager.DoAddInFinalize(Sender: TObject);
begin
  if (COMAddInModule.HostType <> ohaWord) then begin
    exit;
  end;

  Log.AddMessage('TadxWordTaskPanesManager.DoAddInFinalize');

  adxWSbcls.APIFinalize;
end;

procedure TadxWordTaskPanesManager.DoAddInInitialize(Sender: TObject);
begin
  if (COMAddInModule.HostType <> ohaWord) then begin
    exit;
  end;

  Log.AddMessage('TadxWordTaskPanesManager.DoAddInInitialize');

  adxWSbcls.APIInitialize;

  CreateExceptionManager;
  TAppWindowBehaviour.SetSingleton(TWordAppWindowBehaviour.Create);
  TFindWindowFactory.SetSingleton(TFindWordWindowFactory.Create);

  try
    TadxWordTaskPanesManagerState(FState).isAddinInitialize := true;
    try
      if (WordAppObj = nil) then begin
        Log.AddWarning('DoAddinInitialize.WordApplication == null');
        exit;
      end;


      SetWordVersion();
      LoadPositionsFromRegistry;
      DoADXInitialize;
      CreateWordEvents;
      CreateReceiverWindow();
      CreateHook;

      ProcessEnableByCOMAddinsDialog;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoAddInInitialize');
      end;
    end;
  finally
    TadxWordTaskPanesManagerState(FState).isAddinInitialize := false;
    TadxWordTaskPanesManagerState(FState).WasAddinInitialize := true;
  end;
end;

procedure TadxWordTaskPanesManager.DoAddInStartupComplete(Sender: TObject);
begin
  if (COMAddInModule.HostType <> ohaWord) then begin
    exit;
  end;

  Log.AddMessage('TadxWordTaskPanesManager.DoAddInStartupComplete');
end;

procedure TadxWordTaskPanesManager.DoADXInitialize;
var
  args: TadxInitializeEventArgs;
  event: TadxEventRaising;
begin
  if Assigned(OnADXInitialize) then begin
    args := TadxInitializeEventArgs.Create;
    try
      try
        event := TadxEventRaising.Create('OnADXInitialize', [eoLockRegionState]);
        try
          OnADXInitialize(self, args);
        finally
          event.Free;
        end;
      except
        on E: SysUtils.Exception do begin
          TadxExceptionManager.ProcessADXXError(E, 'DoADXInitialize');
        end;
      end;
    finally
      args.Free;
    end;
  end;
end;

procedure TadxWordTaskPanesManager.DoBeforeFormInstanceCreate(
  Args: TadxBeforeTaskPaneInstanceCreateEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnADXBeforeTaskPaneInstanceCreate) then begin
    try
      event := TadxEventRaising.Create('OnADXBeforeTaskPaneInstanceCreate', [eoLockRegionState]);
      try
        OnADXBeforeTaskPaneInstanceCreate(self, Args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoBeforeFormInstanceCreate');
      end;
    end;
  end;
end;



procedure TadxWordTaskPanesManager.DoProcessContextWindow(
  AWordContextArgs: TObject);
var
  Context: TWordContextArgs;
begin
  Log.AddMessage('TadxWordTaskPanesManager.DoProcessActiveAPIWindow');
  Context := TWordContextArgs(AWordContextArgs);


  DeleteFormsForNotVisibleHostHandle();

  Log.AddMessage('DoProcessActiveAPIWindow ' + IntToStr(ord(Context.FDocumentType)));

  //WordInspector is closed
  if (Context.FDocumentType = wdtUnknown) then begin
    Log.AddMessage('return ' + IntTostr(ord(Context.FDocumentType)));
    exit;
  end;

  if (Context.FDocumentType = wdtWordEmailDocument) then begin
    Log.AddMessage('return ' + IntTostr(ord(Context.FDocumentType)));
    exit;
  end;
  if (not Context.IsValidForTaskPaneCreating) then begin
    Log.AddMessage('return not IsValidForTaskPaneCreating');
    exit;
  end;

  try
    LockWindowUpdate(Context.FHostHandle);
    DoShowForms(Context);
  finally
    LockWindowUpdate(0);
  end;

  FLastProcessedContextWindow := Context.FHostHandle;
end;

procedure TadxWordTaskPanesManager.DoRegionCloseButtonClick(AFormHandle: HWND);
var
  Form: TadxWordTaskPane;
begin
  Form := FindFormByHandle(AFormHandle);
  DoRegionCloseButtonClick(Form);
end;

procedure TadxWordTaskPanesManager.DoRegionCloseButtonClick(AForm: TadxWordTaskPane);
var
  Args: TadxWordCloseButtonClickEventArgs;
  event: TadxEventRaising;
begin
  Args := nil;
  if Assigned(AForm) and Assigned(AForm.OnAdxCloseButtonClick) then begin
    try
      Args := TadxWordCloseButtonClickEventArgs.Create;
      try
        event := TadxEventRaising.Create('OnAdxCloseButtonClick', [eoLockRegionState]);
        try
          AForm.OnAdxCloseButtonClick(AForm, Args);
        finally
          event.Free;
        end;
        if (Args.CloseTaskPane) then begin
          AForm.FisHiddenByDeveloper := true;
          AForm.ADXWdHide(true);
        end;
        if (Args.DisableItem) then begin
          AForm.Item.Enabled := false;
        end;
      except
        on E: SysUtils.Exception do begin
          TadxExceptionManager.ProcessADXXError(E, 'DoAdxCloseButtonClick');
        end;
      end;
    finally
      if Assigned(Args) then begin
        Args.Free;
      end;
    end;
  end
  else begin
    if Assigned(AForm) then begin
      AForm.Hide;
    end;
  end;
end;

procedure TadxWordTaskPanesManager.DoShowForm(AItem: TadxWordTaskPanesCollectionItem;
  AWordContextArgs: TObject);
var
  WordContextArgs: TWordContextArgs;
  PropertiesIsSetToShowUpForm: boolean;

  Form: TadxWordTaskPane;
  AppWindowProperty: PAppWindowProperty;
  Args: TadxBeforeTaskPaneInstanceCreateEventArgs;
  Cancel: boolean;
  FindWindow: boolean;
begin
  Log.AddMessage('TadxWordTaskPanesManager.DoShowForm');
  WordContextArgs := AWordContextArgs as TWordContextArgs;

  PropertiesIsSetToShowUpForm :=
    (AItem.Position <> pUnknown)
    and (Length(AItem.TaskPaneClassName) > 0)
    and (AItem.Enabled);

  if (not PropertiesIsSetToShowUpForm) then begin
    Log.AddMessage('not PropertiesIsSetToShowUpForm');
    exit;
  end;

  GetMem(AppWindowProperty, sizeof(TAppWindowProperty));
  try
    try
      NewAppWindowProperty(AppWindowProperty);

      AItem.SetAppWindowProperty(WordContextArgs, AppWindowProperty);

      AppWindowProperty.ReceiverHandle := ReceiverWindowHandle;
      FindWindow := AppWindowProperty.WindowHandle > 0;
      if (FindWindow) then begin
        Form := AItem.FindForm(WordContextArgs.FHostHandle);

        if Form = nil then begin
          Args := TadxBeforeTaskPaneInstanceCreateEventArgs.Create(AItem, false);
          try
            DoBeforeFormInstanceCreate(Args);
            Cancel := Args.Cancel;
          finally
            if Assigned(Args) then begin
              Args.Free;
            end;
          end;
          Form := AItem.GetForm(Cancel);
        end;

        if (Form <> nil)
          and (not Form.Visible)
          and (not Form.FisHiddenByDeveloper)
          and (not Form.Injected) then begin
          Form.InitializeForm(WordContextArgs, AppWindowProperty);
          Form.AdxWdShow(AppWindowProperty, true);
        end;
      end
      else begin
        Log.AddWarning('DoShowForm: ' + ' Window not found. '
          + Format('Handle: %x', [WordContextArgs.FHostHandle])
          + ' ItemType = ' + IntToStr(AppWindowProperty.ItemType));
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoShowForm');
      end;
    end;
  finally
    FreeMem(AppWindowProperty);
  end;

end;

procedure TadxWordTaskPanesManager.DoShowForms(AWordContextArgs: TObject);
var
  index: integer;
begin
  Log.AddMessage('TadxWordTaskPanesManager.DoShowForms');
  try
    for index := 0 to Items.Count - 1 do begin
      DoShowForm(Items[Index], AWordContextArgs);
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoShowForms: ' + E.Message), 'DoShowForms');
  end;
end;

function TadxWordTaskPanesManager.FindFormByHandle(
  AFormHandle: HWND): TadxWordTaskPane;
var
  itemIndex: integer;
  formIndex: integer;
begin
  result := nil;
  for itemIndex := 0 to Items.Count - 1 do begin
    for formIndex:=0 to TadxWordTaskPanesManagerList(Items[itemIndex].FFormInstances).Count - 1 do begin
      if (TadxWordTaskPane(TadxWordTaskPanesManagerList(Items[itemIndex].FFormInstances)[formIndex]).Handle = AFormHandle) then begin
        result := TadxWordTaskPane(TadxWordTaskPanesManagerList(Items[itemIndex].FFormInstances)[formIndex]);
      end;
    end;
  end;
end;

function TadxWordTaskPanesManager.GetAdxItemType(
  Item: TadxWordTaskPanesCollectionItem): TAdxItemType;
begin
  result := stWDDocument;
end;

function TadxWordTaskPanesManager.GetWasAddinInitialize: boolean;
begin
  if (FState = nil) then begin
    result := false;
    exit;
  end;
  result :=  TadxWordTaskPanesManagerState(FState).WasAddinInitialize;
end;

function TadxWordTaskPanesManager.GetWordAppObj: WordApplication;
begin
  result := nil;
  if (COMAddInModule <> nil) then begin
    if (not VarIsNull(COMAddInModule.HostApp)) then begin
      IDispatch(COMAddInModule.HostApp).QueryInterface(WordApplication, result);
      exit;
    end;
  end;
end;

function TadxWordTaskPanesManager.GetItems: TadxWordTaskPanesCollection;
begin
  result := FItems;
end;

procedure TadxWordTaskPanesManager.HideAllForms;
var
  index: integer;
begin
  Log.AddMessage('TadxWordTaskPanesManager.HideAllForms');
  try
    for index := 0 to Items.Count - 1 do begin
      Items[index].HideAllNotInjectedForms;
    end;
    for index := 0 to Items.Count - 1 do begin
      Items[index].HideAllForms;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('HideAllForms: ' + E.Message), 'HideAllForms');
  end;
end;

function TadxWordTaskPanesManager.ReceiverWindowHandle: HWND;
begin
  if (FReceiverWindow <> nil) then begin
    result := TadxReceiverWindow(FReceiverWindow).Handle;
  end else begin
    result := 0;
  end;
end;

procedure TadxWordTaskPanesManager.ReleaseFormsManagerSingleton;
begin
  FormsManagerSingleton := nil;
end;

procedure TadxWordTaskPanesManager.SetWordVersion;
var
  hostVersion: string;
begin
  FWordVersion := vUnknown;

  if COMAddinModule = nil then begin
    Log.AddWarning('SetWordVersion: COMAddinModule = nil');
    exit;
  end;

  if WordAppObj <> nil then begin
    hostVersion := WordAppObj.Version;
    Log.AddSystemInfo('Word version: ' + hostVersion);
  end
  else begin
    Log.AddWarning('SetWordVersion: WordAppObj = nil');
    exit;
  end;

  if (Pos('9.0', hostVersion) > 0) then
      FWordVersion := v2000;

  if (Pos('10.0', hostVersion) > 0) then
      FWordVersion := v2002;

  if (Pos('11.0', hostVersion) > 0) then
      FWordVersion := v2003;

  if (Pos('12.0', hostVersion) > 0) then
      FWordVersion := v2007;

  if (Pos('14.0', hostVersion) > 0) then
      FWordVersion := v2010;

  if FWordVersion = vUnknown then
    raise EAbort.Create('SetWordVersion: Word version is not defined.')

end;

procedure TadxWordTaskPanesManager.SetFormsManagerSingleton;
begin
  FormsManagerSingleton := self;
end;

procedure TadxWordTaskPanesManager.SetItems(const Value: TadxWordTaskPanesCollection);
begin
  FItems := Value;
end;


{ TAddinEvents }

procedure TadxWordAddinEvents.Connect;
begin
  FOldAddInInitialize := nil;
  FOldAddInStartupComplete := nil;
  FOldAddInBeginShutdown := nil;
  FOldAddInFinalize := nil;

  if Assigned(FCOMAddInModule) then begin
    if Assigned(FCOMAddInModule.OnAddInInitialize) then
      FOldAddInInitialize := FCOMAddInModule.OnAddInInitialize;
    if Assigned(FCOMAddInModule.OnAddInStartupComplete) then
      FOldAddInStartupComplete := FCOMAddInModule.OnAddInStartupComplete;
    if Assigned(FCOMAddInModule.OnAddInBeginShutdown) then
      FOldAddInBeginShutdown := FCOMAddInModule.OnAddInBeginShutdown;
    if Assigned(FCOMAddInModule.OnAddInFinalize) then
      FOldAddInFinalize := FCOMAddInModule.OnAddInFinalize;

    FCOMAddInModule.OnAddInInitialize := Self.OnAddInInitialize;
    FCOMAddInModule.OnAddInStartupComplete := Self.OnAddInStartupComplete;
    FCOMAddInModule.OnAddInBeginShutdown := Self.OnAddInBeginShutdown;
    FCOMAddInModule.OnAddInFinalize := Self.OnAddInFinalize;
  end;
end;

constructor TadxWordAddinEvents.Create(AFormsManager: TadxWordTaskPanesManager; ACOMAddInModule: TadxCOMAddInModule);
begin
  FFormsManager := AFormsManager;
  FCOMAddInModule := ACOMAddInModule;
  Connect;
end;

destructor TadxWordAddinEvents.Destroy;
begin
  Disconnect;
  inherited;
end;

procedure TadxWordAddinEvents.Disconnect;
begin
  Log.AddMessage('TadxWordAddinEvents.Disconnect');
  if Assigned(FCOMAddInModule) then begin
    if Assigned(FOldAddInInitialize) then
      FCOMAddInModule.OnAddInInitialize := FOldAddInInitialize;
    if Assigned(FOldAddInStartupComplete) then
      FCOMAddInModule.OnAddInStartupComplete := FOldAddInStartupComplete;
    if Assigned(FOldAddInBeginShutdown) then
      FCOMAddInModule.OnAddInBeginShutdown := FOldAddInBeginShutdown;
    if Assigned(FOldAddInFinalize) then
      FCOMAddInModule.OnAddInFinalize := FOldAddInFinalize;
  end;
end;

procedure TadxWordAddinEvents.OnAddInBeginShutdown(Sender: TObject);
begin
  try
    if Assigned(FOldAddInBeginShutdown) then begin
      FOldAddInBeginShutdown(Sender);
    end;
  finally
    try
      Log.AddMessage('');
      Log.AddMessage('Event: OnAddInBeginShutdown');
      Log.AddIndent();
      try
        FFormsManager.DoAddInBeginShutdown(Sender);
      finally
        Log.RemoveIndent;
        Log.AddMessage('');
      end;
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnAddInBeginShutdown')
      end;
    end;
  end;
end;

procedure TadxWordAddinEvents.OnAddInFinalize(Sender: TObject);
begin
  try
    if Assigned(FOldAddInFinalize) then begin
      FOldAddInFinalize(Sender);
    end;
  finally
    try
      Log.AddMessage('Event: OnAddInFinalize');
      FFormsManager.DoAddInFinalize(Sender);
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnAddInFinalize')
      end;
    end;
  end;
end;

procedure TadxWordAddinEvents.OnAddInInitialize(Sender: TObject);
begin
  try
    if Assigned(FOldAddinInitialize) then begin
      FOldAddinInitialize(Sender);
    end;
  finally
    try
      Log.AddMessage('Event: OnAddInInitialize');
      FFormsManager.DoAddInInitialize(Sender);
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnAddInInitialize')
      end;
    end;
  end;
end;

procedure TadxWordAddinEvents.OnAddInStartupComplete(Sender: TObject);
begin
  try
    if Assigned(FOldAddInStartupComplete) then
      FOldAddInStartupComplete(Sender);
  finally
    try
      Log.AddMessage('Event: OnAddInStartupComplete');
      FFormsManager.DoAddInStartupComplete(Sender);
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnAddInStartupComplete')
      end;
    end;
  end;
end;

procedure TadxWordTaskPanesManager.TryShow(Form: TadxWordTaskPane);
var
  ContextArgs: TWordContextArgs;
begin
  Log.AddMessage('TadxWordTaskPanesManager.TryShow');
  if not Form.Visible then begin
    ContextArgs := TWordContextArgs.Create(self);
    try
      DoShowForm(Form.Item, ContextArgs);
    finally
      ContextArgs.Free;
    end;
  end;
end;


function TadxWordTaskPane.AdxLocalRegistryKey: string;
begin
  result := WordTaskPaneManager.AdxLocalRegistryKey;
end;

function TadxWordTaskPane.GetDefaultRegionState: TadxInternalRegionState;
begin
  result:= irsNormal;
  if (not IsClientLayout) and Assigned(Item) then
    result := TadxInternalRegionState(ord(Item.DefaultRegionState) + 1);
end;

class function TadxWordTaskPane.GetPositionKey(
  Position: TadxWordTaskPanePosition): string;
begin
  case Position of
    pUnknown: result:= 'Unknown';
    pBottom:  result:= 'Bottom';
    pRight:   result:= 'Right';
    pLeft:    result:= 'Left';
    pTop:     result:= 'Top';
  end;
end;

procedure TadxWordTaskPane.InternalSetDragItems(ADragItems: TList;
  dragWindowLayouts: TadxDragWindowLayout;
  AllowedDropPosition: TadxAllowedDropPosition);
var
  itemType: TadxItemType;
  ItemHandle: HWND;
  dragItem: PadxDragItemParams;
begin
  if ((Item.AllowedDropPositions * [AllowedDropPosition]) = [AllowedDropPosition]) then begin
    itemType := stWDMain;

    ItemHandle := self.FWindowHandle;

    if (ItemHandle > 0) then begin
      GetMem(dragItem, sizeof(TadxDragItemParams));
      dragItem.Disabled := false;
      dragItem.DragLayout := dragWindowLayouts;
      dragItem.ItemType := itemType;
      dragItem.ItemHandle := ItemHandle;
      dragItem.Reserved := 0;
      ADragItems.Add(dragItem);
    end;
  end;
end;

procedure TadxWordTaskPane.GetDragLayoutParams(
  var lParams: TadxDragLayoutParams);
var
  position: TadxWordTaskPanePosition;
  injectedTaskPaneSize: integer;
begin
  if (not self.Visible) then exit;
  if (not self.Item.IsDragDropAllowed) then exit;

  lParams.Disabled := not self.WordTaskPaneManager.CheckAllowedDropPosition(self.Item, lParams.Layout);
  position := self.WordTaskPaneManager.GetPosition(lParams.ItemType, lParams.Layout);

  injectedTaskPaneSize := GetSize(lParams.AppHandle, lParams.Layout);
  if (injectedTaskPaneSize > 0) then begin
    lParams.LayoutSize := injectedTaskPaneSize;
  end
  else begin
    lParams.LayoutSize := WordTaskPaneManager.GetPositionSize(position);
  end;

end;

procedure TadxWordTaskPane.SetDragForm(AItemType: TAdxItemType;
  ALayout: TadxWindowLayout);
var
  position: TadxWordTaskPanePosition;
begin
  if (self.WordTaskPaneManager.CheckAllowedDropPosition(self.Item, ALayout)) then begin
    position := WordTaskPaneManager.GetPosition(AItemType, ALayout);
    if (self.Item.Position <> position) then begin
      LockWindowUpdate(Self.FHostHandle);
      try
        self.Item.Position := position ;
        Self.Activate();
      finally
        LockWindowUpdate(0);
      end;
    end;
  end;
end;

procedure TadxWordTaskPane.SetDragItems(ADragItems: TList);
begin
  if (not self.Visible) then exit;
  if (not self.Item.IsDragDropAllowed) then exit;

  InternalSetDragItems(ADragItems, dwlBottom, dpBottom);
  InternalSetDragItems(ADragItems, dwlTop, dpTop);
  InternalSetDragItems(ADragItems, dwlLeft, dpLeft);
  InternalSetDragItems(ADragItems, dwlRight, dpRight);
end;

function TadxWordTaskPane.IsDragDropAllowed: boolean;
begin
  result := Item.IsDragDropAllowed; 
end;

function TadxWordTaskPane.IsExpandFromMinimizedState: boolean;
begin
  result := Item.RestoreFromMinimizedState;
end;

procedure TadxWordTaskPane.HideByManager(UsingVisibleProperty: boolean);
begin
  if (UsingVisibleProperty) then begin
    FisHiddenByDeveloper := true;
  end;
  ADXWdHide(true);
end;

{ TadxWordTaskPanesManagerState }

constructor TadxWordTaskPanesManagerState.Create;
begin
  Restore;
end;

procedure TadxWordTaskPanesManagerState.Restore;
begin
	isShutdown := false;
	WasAddinInitialize := false;
	isAddinInitialize := false;
end;

{ TWordContextArgs }

constructor TWordContextArgs.Create(AFormsManager: TadxWordTaskPanesManager);
begin
  Create(AFormsManager, 0);
end;

constructor TWordContextArgs.Create(
  AFormsManager: TadxWordTaskPanesManager; AHostHandle: HWND);
begin
  inherited Create;
  FContextCause := ccUnknown;
  FHostHandle := 0;
  FDocument := nil;
  FWindow := nil;
  FFormsManager := AFormsManager;
  FWordApplication := AFormsManager.WordAppObj;
  FDocumentType := wdtUnknown;
  InitializeActiveContext(AHostHandle);
end;

destructor TWordContextArgs.Destroy;
begin
  FHostHandle := 0;
  FDocument := nil;
  FWindow := nil;
  FFormsManager := nil;
  FWordApplication := nil;
  FDocumentType := wdtUnknown;
  inherited;
end;

function TWordContextArgs.GetIsValidForTaskPaneCreating: boolean;
begin
  result := self.HostHandle <> 0;
end;

function TWordContextArgs.GetRibbonState: integer;
begin
  result := ribbonStateNoRibbon;
  if (FRibbonHandle <> 0) and IsWindow(FRibbonHandle) then begin
    if IsWindowVisible(FRibbonHandle) then begin
      result := ribbonStateVisible;
      Log.AddMessage('RibbonState: ribbonStateVisible');
    end
    else begin
      result := ribbonStateUnvisible;
      Log.AddMessage('RibbonState: ribbonStateUnvisible');
    end;
  end;
end;

procedure TWordContextArgs.InitializeActiveContext(AHostHandle: HWND);
begin
  if (AHostHandle = 0) then begin
    SetHostHandleFromActiveWindow;

    case FFormsManager.FWordVersion of
      v2000, v2002, v2003, v2007, v2010: begin

        //This is happening when wordemaildocument is closed. Debug.Assert(this.hostHandle != IntPtr.Zero, "this.hostHandle = IntPtr.Zero");
        try
          if (FWordApplication.Documents.Count > 0) then begin
            self.FDocument := FWordApplication.ActiveDocument;
          end;
        except
          self.FDocument := nil;
        end;

        //This is happening when document is closed: Debug.Assert(this.document != null, "this.document = null");
        try
          if (FWordApplication.Windows.Count > 0) then begin
            self.FWindow := FWordApplication.ActiveWindow;
          end;
        except
          self.FWindow := nil;
        end;
        //This is happening when document is closed: Debug.Assert(this.window != null, "this.window = null");

        if ((self.FHostHandle = 0)) then begin//Case 1659
          if (self.FWindow <> nil) then begin
            SetHostHandleFromMainWindow(self.FWindow.Caption);//Case 1659
          end;
        end;

        if (self.FProtectedWindow <> nil) then begin
          SetHostHandleFromMainWindow(Variant(self.FProtectedWindow).Caption);
        end;
      end;
    end;

  end
  else begin
    //COM Add-ins Dialog
    SetHostHandle(AHostHandle);
  end;

  if (FHostHandle <> 0) then begin
    SetActiveContextDocumentType;
    SetRibbonHandle;
  end;
end;

function TWordContextArgs.GetRibbonAvailable: boolean;
begin
  result := (RibbonState <> ribbonStateNoRibbon);
  if (result) then begin
    Log.AddMessage('RibbonAvailable');
  end
  else begin
    Log.AddMessage('Ribbon not Available');
  end;
end;

procedure TWordContextArgs.SetActiveContextDocumentType;
var
  EnvelopeCommandBarHandle: HWND;
  NoEnvelope: boolean;
begin
  if (self.FProtectedWindow <> nil) then begin
    FDocumentType := wdtProtectedWindow;
    exit;
  end;

  if (self.FWindow <> nil) then begin
    if (self.FWindow.EnvelopeVisible) then begin
        FDocumentType := wdtWordEmailDocument;
    end else
    begin
        FDocumentType := wdtStandard;
    end;
  end;

  //if (WindowsAPI.IsWindowVisible(this.HostHandle))//Closed WordInspector

  EnvelopeCommandBarHandle := GetAppWindowHandle(FFormsManager.FWordVersion, stOlEnvelopeCommandBarForWordInspectorPreviwControl, self.FHostHandle);
  NoEnvelope := (
      (EnvelopeCommandBarHandle = 0)
      or (
           (EnvelopeCommandBarHandle <> 0)
           and (not Windows.IsWindowVisible(EnvelopeCommandBarHandle))
         )
      );
  if (NoEnvelope) then begin
    FDocumentType := wdtStandard;
  end
  else begin
    if (FDocumentType = wdtUnknown) then begin
      FDocumentType := wdtWordEmailDocument;
    end;
  end;

  //try
      //this.document.GetSmartDocument
  //except
      //documentType = WordDocumentType.WordEmailDocument;
  //end;
end;

procedure TWordContextArgs.SetHostHandle(AHostHandle: HWND);
begin
  self.FHostHandle := AHostHandle;
end;

procedure TWordContextArgs.SetHostHandleFromActiveWindow;
var
  activeHandle: HWND;
begin
  activeHandle := APIUtils.GetActiveWindow(GlobalsWD.WordWindowClassName);
  if (HandleFromCurrentProcess(activeHandle)) then begin
    self.FHostHandle := activeHandle;
  end;
end;

procedure TWordContextArgs.SetRibbonHandle;
begin
  if (FHostHandle <> 0) then begin
    FRibbonHandle := FindChildWindow(FHostHandle, 'Ribbon', 'MsoCommandBar', '', true);
  end;
end;

procedure TWordContextArgs.SetHostHandleFromMainWindow(WindowName: string);
var
  handle: HWND;
begin
  handle := FindMainWindowInProcess(GetDesktopWindow(), WindowName, GlobalsWd.WordWindowClassName, false);
  if (handle <> 0) then begin
    self.FHostHandle := handle;
  end;
end;

constructor TWordContextArgs.Create(
  AFormsManager: TadxWordTaskPanesManager; AProtectedWindow: IDispatch);
begin
  inherited Create;
  FContextCause := ccUnknown;
  FHostHandle := 0;
  FDocument := nil;
  FWindow := nil;
  FFormsManager := AFormsManager;
  FWordApplication := AFormsManager.WordAppObj;
  FDocumentType := wdtUnknown;
  FProtectedWindow := AProtectedWindow;
  InitializeActiveContext(0);
end;

{ TadxWordTaskPanesManagerList }

procedure TadxWordTaskPanesManagerList.Clear;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    TObject(Items[i]).Free;
  inherited;
end;

function TadxWordTaskPanesManagerList.CountClasses(AClassType: TClass): integer;
var
  i: integer;
begin
  result := 0;
  for i := 0 to Count - 1 do begin
    if TObject(Items[i]) is AClassType then
      Inc(result);
  end;
end;

constructor TadxWordTaskPanesManagerList.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor TadxWordTaskPanesManagerList.Destroy;
begin
  FOwner := nil;
  inherited;
end;

{ GlobalsWd }

class function GlobalsWd.ADXWdReceiverWindowCaption: string;
begin
  result := 'ADXWdReceiverWindowCaption';
end;

procedure TadxWordTaskPanesCollectionItem.SetAlwaysShowHeader(
  const Value: boolean);
begin
  FAlwaysShowHeader := Value;
  if (FIsDragDropAllowed) then begin
    FAlwaysShowHeader := true;
  end;
  if (FDefaultRegionState = rsMinimized) then begin
    FAlwaysShowHeader := true;
  end;
  if (FCloseButton) then begin
    FAlwaysShowHeader := true;
  end;
end;

procedure TadxWordTaskPanesCollectionItem.SetCloseButton(
  const Value: boolean);
begin
  if FCloseButton <> Value then begin
    FCloseButton := Value;
    if (FCloseButton) then begin
      self.AlwaysShowHeader := true;
    end;
  end;
end;

{ TADXWordExceptionManager }

procedure TADXWordExceptionManager.InternalProcessADXXError(err: Exception; whereHappened: string);
var
  args: TadxErrorEventArgs;
  event: TadxEventRaising;
begin
  try
    Log.AddException(Format('%s error (%s): the add-in has fired an exception.'#13#10 +
      '%s', ['ADX Extensions', whereHappened, err.Message]));
    args := TadxErrorEventArgs.Create(err);
    try
      if (FormsManagerSingleton <> nil) then begin
        if Assigned(FormsManagerSingleton.OnADXError) then begin
          event := TadxEventRaising.Create('OnADXError', [eoLockRegionState]);
          try
            FormsManagerSingleton.OnADXError(FormsManagerSingleton, args);
          finally
            event.Free;
          end;
        end;
      end;
    if (not args.Handled) then begin
      if (AdxShowYesNoError(Format('%s error (%s): the add-in has fired an exception.'#13#10 +
       '%s ' + #13#10 + '%s', ['ADX Extensions', whereHappened, err.Message, 'Do you want to look at the Log?']), 'Add-in Express Extensions error') = IDYES) then begin
        Log.ShowMessages('ADX Extensions Log');
      end;

    end;
    finally
      args.Free;
    end;
  except
    on MethodErr:SysUtils.Exception do begin
      Windows.MessageBox(GetDesktopWindow, PChar('ADX Extensions error (' + whereHappened + '): ' + err.Message + #13#10 + MethodErr.Message), 'ProcessADXXError', 0);
    end;
  end;
end;

procedure TadxWordTaskPane.DoAdxEnter(args: TadxWordEnterEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnAdxEnter) then begin
    try
      event := TadxEventRaising.Create('OnAdxEnter', [eoLockRegionState]);
      try
        OnAdxEnter(self, args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoAdxEnter');
      end;
    end;
  end;
end;

procedure TadxWordTaskPane.DoAdxExit(args: TadxWordExitEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnAdxExit) then begin
    try
      event := TadxEventRaising.Create('OnAdxExit', [eoLockRegionState]);
      try
        OnAdxExit(self, args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoAdxExit');
      end;
    end;
  end;
end;

procedure TadxWordTaskPane.DoAdxPostMessage(args: TadxWordPostMessageReceivedEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnADXPostMessageReceived) then begin
    try
      event := TadxEventRaising.Create('OnADXPostMessageReceived', [eoLockRegionState]);
      try
        OnADXPostMessageReceived(args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoAdxPostMessage');
      end;
    end;
  end;
end;

function TadxWordTaskPane.GetWordApp: TWordApplication;
begin
  result := nil;
  if (FFormsManager <> nil) and (FFormsManager.Owner <> nil) then begin
    if (FFormsManager.Owner is TadxCOMAddInModule) then begin
      result := (FFormsManager.Owner as TadxCOMAddInModule).WordApp;
    end;
  end;
end;

procedure TadxWordTaskPane.Hide;
begin
  if not (csDesigning in self.ComponentState) then begin
    TDebug.WriteLine('TadxWordTaskPane.Hide');
    self.FisHiddenByDeveloper := true;
    ADXWdHide(true);
  end
  else begin
    inherited Hide;
  end;
end;

procedure TadxWordTaskPane.Show;
begin
  if not (csDesigning in self.ComponentState) then begin
    self.FisHiddenByDeveloper := false;
    if LockVisible then begin
      Visible := true;
    end
    else begin
      WordTaskPaneManager.TryShow(self);
    end;
  end
  else begin
    inherited Show;
  end;
end;

function TadxWordTaskPane.AdxLayoutKey: string;
begin
  result := 'Unknown';
  if Assigned(Item) then begin
    case Item.Position of
      pUnknown:       result := 'Unknown';
      pTop:           result := 'Top';
      pBottom:        result := 'Bottom';
      pRight:         result := 'Right';
      pLeft:          result := 'Left';
    end;
  end;
end;

function TadxWordTaskPane.AdxRegistryKey: string;
begin
  Result := WordTaskPaneManager.AdxRegistryKey;
end;

function TadxWordTaskPane.RegistryKey: string;
begin
  if (Owner = nil) then begin
    TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxWordTaskPane.RegistryKey: Cannot return a RegistryKey. Owner is nil.'), 'RegistryKey');
  end;
  if not (Owner is TadxWordTaskPanesManager) then begin
    TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxWordTaskPane.RegistrPostMessagereturn a RegistryKey. Owner is not TadxWordTaskPaneManager.'), 'RegistryKey');
  end;
  result := TadxWordTaskPanesManager(Owner).COMAddInModule.RegistryKey;
end;

procedure TadxWordTaskPane.ADXPostMessage(wParam, lParam: Cardinal);
begin
  SendMessageCluster(Handle, wParam, lParam);
end;

procedure TadxWordTaskPanesCollectionItem.HideAllNotInjectedForms;
var
  index: integer;
begin
  Log.AddMessage('TadxWordTaskPanesCollectionItem.HideAllNotInjectedForms');
  for index := 0 to TadxWordTaskPanesManagerList(FFormInstances).Count - 1 do begin
    if TadxWordTaskPanesManagerList(FFormInstances)[index] <> nil then begin
      if TadxWordTaskPane(TadxWordTaskPanesManagerList(FFormInstances)[index]).Visible
        and (not TadxWordTaskPane(TadxWordTaskPanesManagerList(FFormInstances)[index]).Injected) then begin
        TadxWordTaskPane(TadxWordTaskPanesManagerList(FFormInstances)[index]).ADXWdHide(true);
      end;
    end;
  end;
end;


{ TCustomWindowMessage }

constructor TCustomWindowMessage.Create(ReceiverHandle: HWND);
begin
  FSynchronize := true;
  FReceiverHandle := ReceiverHandle;
  StopProcess := false;
  RegisterMessage(GetMessageName());
end;

function TCustomWindowMessage.DoProcessMessage(wParam,
  lParam: integer): integer;
begin
  result := 0;
  if (Synchronize) then begin
    WaitForSingleObject(FormsManagerSingleton.hMessageMutex, mutexWaiting);
    try
      result := ProcessMessage(wParam, lParam);
      Log.AddMessage(self.ClassName + '.DoProcessMessage ' + IntToHex(wParam, 8) + ', ' + IntToHex(lParam, 8));
    finally
      ReleaseMutex(FormsManagerSingleton.hMessageMutex);
    end;
    Log.AddMessage('<<<<<<<<<<<<<<<< Synchronize ' + self.ClassName);
    Log.AddMessage('');
  end
  else begin
    ProcessMessage(wParam, lParam);
    Log.AddMessage('<<<<<<<<<<<<<<<< ' + self.ClassName);
    Log.AddMessage('');
  end;
end;

function TCustomWindowMessage.GetMessageID: cardinal;
begin
  result := FMessageID;
end;

function TCustomWindowMessage.GetRegisterMessageName: string;
begin
  result := FRegisterMessageName;
end;

function TCustomWindowMessage.GetSynchronize: boolean;
begin
  result := FSynchronize and (FormsManagerSingleton.hMessageMutex <> 0);
end;

procedure TCustomWindowMessage.PostMessage(wParam, lParam: integer);
begin
  if FReceiverHandle = 0 then
    raise SysUtils.Exception.Create(self.ClassName +  '. ReceiverHandle shoud be define.');
  TDebug.WriteLine(self.ClassName + '.PostMessage(' + IntToHex(FReceiverHandle, 8)
  + ', ' + IntTostr(FMessageID)
  + ', ' + IntToHex(wParam, 8)
  + ', ' + IntTostr(lParam) + ')');

  if (Synchronize) then begin
    WaitForSingleObject(FormsManagerSingleton.hMessageMutex, mutexWaiting);
    ReleaseMutex(FormsManagerSingleton.hMessageMutex);
    Log.AddMessage('>>>>>>>>>>>>>>>> POST Synchronize ' + self.ClassName);
  end
  else begin
    Log.AddMessage('>>>>>>>>>>>>>>>> POST ' + self.ClassName);
  end;

  Windows.PostMessage(FReceiverHandle, FMessageID, wParam, lParam);
end;

procedure TCustomWindowMessage.RegisterMessage(AMessageName: string);
begin
  FRegisterMessageName := AMessageName;
  {$IFDEF UNICODE}
  FMessageID := Windows.RegisterWindowMessage(PChar(FRegisterMessageName));
  {$ELSE}
  FMessageID := Windows.RegisterWindowMessage(PAnsiChar(FRegisterMessageName));
  {$ENDIF}
end;

function TCustomWindowMessage.SendMessage(wParam,
  lParam: integer): integer;
begin
  if FReceiverHandle = 0 then
    raise SysUtils.Exception.Create(self.ClassName +  '. ReceiverHandle shoud be define.');
  TDebug.WriteLine(self.ClassName + '.SendMessage(' + IntToHex(FReceiverHandle, 8)
  + ', ' + IntTostr(FMessageID)
  + ', ' + IntToHex(wParam, 8)
  + ', ' + IntTostr(lParam) + ')');

  if (Synchronize) then begin
    WaitForSingleObject(FormsManagerSingleton.hMessageMutex, mutexWaiting);
    ReleaseMutex(FormsManagerSingleton.hMessageMutex);
    Log.AddMessage('>>>>>>>>>>>>>>>> SEND Synchronize ' + self.ClassName);
  end
  else begin
    Log.AddMessage('>>>>>>>>>>>>>>>> SEND ' + self.ClassName);
  end;

  result := Windows.SendMessage(FReceiverHandle, FMessageID, wParam, lParam);
end;

{ TadxReceiverWindow }

procedure TadxReceiverWindow.AddReceiverCustomMessage(
  CustomWindowMessage: TCustomWindowMessage);
begin
  if (CustomWindowMessage <> nil) then begin
    inc(FCountCustomMessages);
    Log.AddMessage('TadxReceiverWindow.AddReceiverCustomMessage(' + CustomWindowMessage.ClassName + ')' + IntToStr(FCountCustomMessages));
    FCustomMessages.Add(CustomWindowMessage);
  end;
end;

constructor TadxReceiverWindow.CreateEx(AOwner: TComponent; ACaption: string);
begin
  FExecute := False;
  inherited CreateParented(GetDesktopWindow);

  FCountCustomMessages := 0;
  FCustomMessages := TList.Create;

  Caption := ACaption;

  TDebug.WriteLine('================ TadxReceiverWindow.CreateEx ' + Format('%x', [Handle]));
end;

destructor TadxReceiverWindow.Destroy;
begin
  TDebug.WriteLine('*** *** *** TadxReceiverWindow.Destroy');

  while FCustomMessages.Count > 0 do begin
    Log.AddMessage('TadxReceiverWindow.Destroy.FCustomMessages.Delete(' + TCustomWindowMessage(FCustomMessages.Items[0]).ClassName + ')' + IntToStr(FCountCustomMessages));
    dec(FCountCustomMessages);
    TCustomWindowMessage(FCustomMessages.Items[0]).Free;
    FCustomMessages.Items[0] := nil;
    FCustomMessages.Delete(0);
  end;

  if Assigned(FCustomMessages) then begin
    FCustomMessages.Free;
    FCustomMessages := nil;
  end;

  //FCustomMessages.Free;

  inherited;
end;


function TadxReceiverWindow.Exists(
  customWindowMessageType: TClass): boolean;
var
  i: integer;
begin
  for i := 0 to FCustomMessages.Count - 1 do begin
    if (TCustomWindowMessage(FCustomMessages[i]).ClassType = customWindowMessageType) then begin
      result := true;
      exit;
    end;
  end;
  result := false;
end;

function TadxReceiverWindow.RegisterMessage(Msg: Cardinal): boolean;
var
  index: integer;
begin
  result := false;

  if (FCustomMessages <> nil) then begin
    for index := 0 to FCustomMessages.Count - 1 do begin
      if (TCustomWindowMessage(FCustomMessages[index]).MessageID = Msg) then begin
        result := true;
        exit;
      end;
    end;
  end;
end;

procedure TadxReceiverWindow.SetExecute(const Value: boolean);
begin
  if Value then
    TDebug.WriteLine('*** TadxReceiverWindow.MainWndProc Execute BEGIN')
  else
    TDebug.WriteLine('*** TadxReceiverWindow.MainWndProc Execute END');

  FExecute := Value;
end;

procedure TadxReceiverWindow.WndProc(var Message: TMessage);
var
  index: integer;
begin
  if self.RegisterMessage(Message.Msg) then begin
    if Execute then begin
      Log.AddWarning('TadxReceiverWindow.WndProc Executing');
      Message.Result := 10;
      ReleaseMutex(FormsManagerSingleton.hMessageMutex);
      Log.AddMessage('<<<<<<<<<<<<<<<< SKIP');
      exit;
    end;

    index := 0;
    while (0 <= index) and (index < FCustomMessages.Count) do begin
      TDebug.WriteLine('*** *** *** TCustomWindowMessage(FCustomMessages.Items[index]).ClassName ' + IntToStr(index) + '/' + IntToStr(FCustomMessages.Count) );
      if (TCustomWindowMessage(FCustomMessages.Items[index]).MessageID = Message.Msg) then begin
        try
          Execute := true;
          TDebug.WriteLine('*** *** *** ' + TCustomWindowMessage(FCustomMessages.Items[index]).ClassName + '.' + 'PocessMessage');
          TCustomWindowMessage(FCustomMessages.Items[index]).DoProcessMessage(Message.WParam, Message.LParam);
        finally
          Execute := false;
        end;
      end;

      try
        //TDebug.WriteLine('*** *** *** Get TCustomWindowMessage(FCustomMessages.Items[index]).ClassName ' + IntToStr(index) + '/' + IntToStr(FCustomMessages.Count) );
        //CustomWindowMessageClass := TCustomWindowMessage(FCustomMessages.Items[index]).ClassName;
        //TDebug.WriteLine('*** *** *** ' + CustomWindowMessageClass);
        if TCustomWindowMessage(FCustomMessages.Items[index]).StopProcess then begin
          TDebug.WriteLine('*** *** *** StopProcess');
          TCustomWindowMessage(FCustomMessages[index]).Free;
          FCustomMessages[index] := nil;
          FCustomMessages.Delete(index);
        end
        else begin
          inc(index);
        end;
      except
        on E:SysUtils.Exception do begin
          ShowMessage('TadxReceiverWindow ' + E.Message);
        end;
      end;

    end;

  end
  else begin
      TDebug.WriteLine('Recieve > ANY ' + WndMesssageToString(Message.Msg) + '/' +  Format('%x', [Message.Msg]));
      inherited WndProc(Message);
      TDebug.WriteLine('Recieve < ANY ' + WndMesssageToString(Message.Msg) + '/' +  Format('%x', [Message.Msg]));
  end;
  TDebug.WriteLine('TadxReceiverWindow <<<<<<<<<<<<<');
end;

{ TRegionCloseButtonClickMessage }

constructor TRegionCloseButtonClickMessage.Create(ReceiverHandle: HWND;
  AFormsManager: TadxWordTaskPanesManager);
begin
  inherited Create(ReceiverHandle);
  FFormsManager := AFormsManager;
end;

destructor TRegionCloseButtonClickMessage.Destroy;
begin
  FFormsManager := nil;
  inherited;
end;

function TRegionCloseButtonClickMessage.GetMessageName: string;
begin
  result := 'WM_ADXCLOSEBUTTONCLICK';
end;

function TRegionCloseButtonClickMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  formHandle: HWND;
begin
  formHandle := wParam;
  if (FFormsManager <> nil) then begin
    FFormsManager.DoRegionCloseButtonClick(formHandle);
    result := 0;
  end else begin
    result := 0;
  end;
end;

{ TadxWordCloseButtonClickEventArgs }

constructor TadxWordCloseButtonClickEventArgs.Create;
begin
  inherited;
  FCloseTaskPane := true;
  FDisableItem := false;
end;

procedure TadxWordCloseButtonClickEventArgs.SetCloseTaskPane(const Value: boolean);
begin
  FCloseTaskPane := Value;
end;

procedure TadxWordCloseButtonClickEventArgs.SetDisableItem(
  const Value: boolean);
begin
  FDisableItem := Value;
end;

procedure TadxWordTaskPane.UpdateAppWindowPropertyAfterBeforeFormShowEvent(
  AAppWindowProperty: Pointer);
var
  adxCaption: TadxCaption;
  {$IFDEF UNICODE}
  i: integer;
  {$ENDIF}
begin
  PAppWindowProperty(AAppWindowProperty)^.Splitter := ord(Item.Splitter);
  {$IFDEF UNICODE}
  for i := 0 to min(Length(Self.Caption), ADXCAPTION_SIZE) - 1   do begin
    adxCaption[i] := Self.Caption[i+1];
  end;
  adxCaption[min(Length(Self.Caption), ADXCAPTION_SIZE)] := #0;
  {$ELSE}
    StrPCopy(adxCaption,  Self.Caption);
  {$ENDIF}
  PAppWindowProperty(AAppWindowProperty)^.Caption := adxCaption;
end;


function TadxWordTaskPane.UseOfficeThemeBackColor: boolean;
begin
  if Assigned(self.Item) then
    result:= self.Item.UseOfficeThemeForBackground
  else
    result:= false;
end;

{ TadxxWordEvents }

procedure TadxxWordEvents.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{00024500-0000-0000-C000-000000000046}';
    IntfIID:   '{000208D5-0000-0000-C000-000000000046}';
    EventIID:  '{000209FE-0000-0000-C000-000000000046}';
    LicenseKey: nil;
    Version: 500);
    // 2002
    //ClassID:   '{000209FF-0000-0000-C000-000000000046}';
    //IntfIID:   '{00020970-0000-0000-C000-000000000046}';
    //EventIID:  '{00020A00-0000-0000-C000-000000000046}';
    // 2003
    //EventIID:  '{00020A01-0000-0000-C000-000000000046}';
begin
  ServerData := @CServerData;
end;

procedure TadxxWordEvents.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf as Word2000._Application;
  ConnectEvents(FIntf);
end;

procedure TadxxWordEvents.ConnectTo(AIntf: IDispatch; AVersion: integer);
const
  EventIID2000: TGUID = '{000209FE-0000-0000-C000-000000000046}';
  EventIID2002: TGUID = '{00020A00-0000-0000-C000-000000000046}';
  EventIID2003: TGUID = '{00020A01-0000-0000-C000-000000000046}';
begin
  if AVersion = v2000 then
    ServerData^.EventIID := EventIID2000
  else
    if AVersion = v2002 then
      ServerData^.EventIID := EventIID2002
    else
      ServerData^.EventIID := EventIID2003;
  ConnectTo(AIntf);
end;

constructor TadxxWordEvents.CreateEx(AFormsManager: TadxWordTaskPanesManager);
begin
  inherited Create(nil);
  FFormsManager := AFormsManager;
end;

procedure TadxxWordEvents.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TadxxWordEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
var
  event: TLogEvent;
begin
  try
    case DispID of
      -1: Exit;
      3 : begin
        event := TLogEvent.Create('OnDocumentChange');
        try
          OnDocumentChange(Self.FFormsManager);
        finally
          event.Free;
        end;
      end;
      10: begin
        event := TLogEvent.Create('OnWindowActivate');
        try
          OnWindowActivate(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
                IUnknown(TVarData(Params[1]).VPointer) as Word2000.Window);
        finally
          event.Free;
        end;
      end;
      //6 : ;//DocumentBeforeClose;
      //9 : ;//Log.AddMessage('Event OnNewDocument');
      //4 : ;//Log.AddMessage('Event OnDocumentOpen');

      35: begin
         event := TLogEvent.Create('OnProtectedViewWindowActivate');
         try
           OnProtectedViewWindowActivate(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
         finally
           event.Free;
         end;
      end;

    end;
  except
    on E: SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'DoAddInInitialize');
    end;
  end;
end;

procedure TadxxWordEvents.OnDocumentChange(Sender: TObject);
var
  Context: TWordContextArgs;
begin
  Log.AddMessage('TadxxWordEvents.OnDocumentChange');
  Context := TWordContextArgs.Create(self.FFormsManager);
  try
    FFormsManager.DoDocumentChange(Context);
  finally
    Context.Free;
  end;
end;

procedure TadxxWordEvents.OnWindowActivate(ASender: TObject;
  const Doc: WordDocument; const Wn: Word2000.Window);
var
  Context: TWordContextArgs;
begin
  Log.AddMessage('TadxxWordEvents.OnWindowActivate');
  Context := TWordContextArgs.Create(self.FFormsManager);
  try
    FFormsManager.DoWindowActivate(Context);
  finally
    Context.Free;
  end;
end;

class function GlobalsWd.WordWindowClassName: string;
begin
  result := 'OpusApp';
end;

procedure TadxWordTaskPanesCollectionItem.ShowTaskPane;
var
  Context: TWordContextArgs;
  TaskPane: TadxWordTaskPane;
begin
  Log.AddMessage('TadxWordTaskPanesCollectionItem.ShowTaskPane');
  Context := TWordContextArgs.Create(self.FormsManager);
  try
    TaskPane := self.FindForm(Context.FHostHandle);
    if (TaskPane <> nil) then begin
      TaskPane.MarkHiddenByDeveloper(false);
    end;
    self.FormsManager.DoShowForm(self, Context);
  finally
    Context.Free;
  end;
end;

procedure TadxWordTaskPane.MarkHiddenByDeveloper(value: boolean);
begin
  FisHiddenByDeveloper := value;
end;

function TadxWordTaskPane.GetCurrentWordWindowHandle: HWND;
begin
  result := FHostHandle;
end;

function TadxWordTaskPanesCollectionItem.GetTaskPaneInstances(
  Index: Integer): TadxWordTaskPane;
var
  taskPane: TObject;
begin
  result := nil;
  taskPane := TadxWordTaskPanesManagerList(FFormInstances)[Index];
  if (taskPane <> nil) then begin
    result := taskPane as TadxWordTaskPane;
  end;
end;

function TadxWordTaskPanesCollectionItem.GetTaskPaneInstanceCount: integer;
begin
  result := TadxWordTaskPanesManagerList(FFormInstances).Count;
end;

function TadxWordTaskPanesManager.AdxLocalRegistryKey: string;
begin
  if (Owner <> nil) then begin
    result := (Owner as TadxCOMAddInModule).RegistryKey + '\' + Globals.ADXWDForm;
  end
  else begin
    result := '';
  end;
end;

function TadxWordTaskPanesManager.AdxRegistryKey: string;
var
  Reg: TRegistry;
begin
  Result:= '\Software\Microsoft\Office\Word\AddIns\' + Globals.ADXWDForm + '\';
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey(Result, true);
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function TadxWordTaskPanesManager.CheckAllowedDropPosition(
  Item: TadxWordTaskPanesCollectionItem;
  WindowLayout: TadxWindowLayout): boolean;
begin
  result := false;

  if (CompareAllowedDropPositionsAndWindowLayout(Item, WindowLayout, dpBottom)) then result := true;
  if (CompareAllowedDropPositionsAndWindowLayout(Item, WindowLayout, dpLeft)) then result :=  true;
  if (CompareAllowedDropPositionsAndWindowLayout(Item, WindowLayout, dpRight)) then result :=  true;
  if (CompareAllowedDropPositionsAndWindowLayout(Item, WindowLayout, dpTop)) then result :=  true;
end;

function TadxWordTaskPanesManager.CompareAllowedDropPositionsAndWindowLayout(
  Item: TadxWordTaskPanesCollectionItem; WindowLayout: TadxWindowLayout;
  AllowedDropPosition: TadxAllowedDropPosition): boolean;
var
  allowedWindowLayout: TadxWindowLayout;
begin
  result := false;
  if ((Item.AllowedDropPositions * [AllowedDropPosition]) = [AllowedDropPosition]) then begin
    allowedWindowLayout := GetADXWindowLayout(AllowedDropPosition);
    if (allowedWindowLayout = WindowLayout) then begin
      result := true;
    end;
  end;
end;

function TadxWordTaskPanesManager.ConvertPositionToAllowedDropPosition(
  Position: TadxWordTaskPanePosition): TadxAllowedDropPosition;
begin
  case Position of
    pBottom:  result := dpBottom;
    pLeft:    result := dpLeft;
    pRight:   result := dpRight;
    pTop:     result := dpTop;
    else
      raise SysUtils.Exception.Create('ConvertPositionToAllowedDropPosition: Position is pUnknown');
  end;
end;

function TadxWordTaskPanesManager.GetADXWindowLayout(
  AllowedDropPosition: TadxAllowedDropPosition): TadxWindowLayout;
begin
  case AllowedDropPosition of
    dpTop:    result := wlTop;
    dpBottom: result := wlBottom;
    dpRight:  result := wlRight;
    dpLeft:   result := wlLeft;
    else
      raise SysUtils.Exception.Create('GetADXWindowLayout: Indefinite AllowedDropPosition.');
  end;
end;

function TadxWordTaskPanesManager.GetPosition(ItemType: TadxItemType;
  WindowLayout: TadxWindowLayout): TadxWordTaskPanePosition;
begin
  result := pUnknown;
  case ItemType of
    stWDMain:
      case WindowLayout of
        wlBottom: result := pBottom;
        wlLeft: result := pLeft;
        wlRight: result := pRight;
        wlTop: result := pTop;
      end;
     else
       raise SysUtils.Exception.Create('GetPosition: The TadxWordTaskPanePosition is not found.');
  end;
end;

function TadxWordTaskPanesManager.GetPositionSize(
  Position: TadxWordTaskPanePosition): integer;
var
  Reg: TRegistry;
  keyValue: string;
begin
  result := 0;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.KeyExists(AdxRegistryKey) then begin
      Reg.OpenKey(AdxRegistryKey, false);
      keyValue := TadxWordTaskPane.GetPositionKey(Position);
      if Reg.ValueExists(KeyValue + '_Size') then begin
        result := Reg.ReadInteger(KeyValue + '_Size');
      end;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure TadxWordTaskPanesManager.LoadPositionsFromRegistry;
var
  i: integer;
begin
  for i := 0 to Items.Count - 1 do begin
    Items[i].LoadPositionFromRegistry;
  end;
end;

procedure TadxxWordEvents.OnProtectedViewWindowActivate(ASender: TObject;
  const PvWindow: IDispatch);
var
  Context: TWordContextArgs;
begin
  Log.AddMessage('TadxxWordEvents.OnProtectedViewWindowActivate');
  Context := TWordContextArgs.Create(self.FFormsManager, PvWindow);
  try
    FFormsManager.DoProtectedWindowActivate(Context);
  finally
    Context.Free;
  end;
end;

{ TWordAppWindowBehaviour }

procedure TWordAppWindowBehaviour.HIDE_WHEN_WINDOWPOSCHANGING(
  appWindow: TAppWindow);
begin
end;

procedure TWordAppWindowBehaviour.SHOW_WHEN_WINDOWPOSCHANGING(
  appWindow: TAppWindow);
begin
end;

procedure TWordAppWindowBehaviour.WM_DESTROY(hWnd: THandle; Msg: UINT;
  wParam, lParam: Integer; appWindow: TAppWindow);
var
  awpWindowHandle, awpHostHandle: THandle;
begin
  Log.AddMessage('TWordAppWindowBehaviour.WM_DESTROY');
  awpWindowHandle := PAppWindowProperty(appWindow.AppWindowProperty)^.WindowHandle;
  awpHostHandle := PAppWindowProperty(appWindow.AppWindowProperty)^.HostHandle;
  Windows.LockWindowUpdate(awpHostHandle);
  try
    TAppWindowBehaviour.HideAllFormsInAllAddins(awpWindowHandle);
  finally
    Windows.LockWindowUpdate(0);
  end;
end;

procedure TWordAppWindowBehaviour.WM_PARENTNOTIFY_DESTROY(hWnd: THandle;
  Msg: UINT; wParam, lParam: Integer; appWindow: TAppWindow);
begin
end;

procedure TadxWordTaskPanesManager.ProcessEnableByCOMAddinsDialog;
begin
  DoProcessAllWordWindows;
end;

procedure TadxWordTaskPanesManager.DoProcessAllWordWindows;
var
  fwins: TFindWindow;
  fWin: HWND;
  i: integer;
  wTitle: WideString;

  ContextArgs: TWordContextArgs;
begin
  fwins := TFindWindow.Create(GetDesktopWindow, 0, PChar(GlobalsWD.WordWindowClassName), nil);
  try
    for i := 0 to fwins.Handles.Count - 1 do begin
      fWin := HWND(fwins.Handles.Items[i]);
      wTitle := GetWindowText_(fWin);
      if (Windows.IsWindowVisible(fWin)) then begin
        if (HandleFromCurrentProcess(fWin)) then begin
          ContextArgs := TWordContextArgs.Create(self, fWin);
          try
            DoProcessContextWindow(ContextArgs);
          finally
            ContextArgs.Free;
          end;
        end;
      end;
    end;
  finally
    if Assigned(fwins) then fwins.Free;
  end;
end;

procedure TWordAppWindowBehaviour.WM_SHOWWINDOW_HIDE(hWnd: THandle;
  Msg: UINT; wParam, lParam: Integer; appWindow: TAppWindow);
var
  awpWindowHandle, awpHostHandle, awpReceiverHandle: THandle;
  event: TLogEvent;
begin
  event := TLogEvent.Create('TWordAppWindowBehaviour.WM_SHOWWINDOW_HIDE');
  try
    awpWindowHandle := PAppWindowProperty(appWindow.AppWindowProperty)^.WindowHandle;
    awpHostHandle := PAppWindowProperty(appWindow.AppWindowProperty)^.HostHandle;
    awpReceiverHandle := PAppWindowProperty(appWindow.AppWindowProperty)^.ReceiverHandle;

    Windows.LockWindowUpdate(awpHostHandle);
    try
      TAppWindowBehaviour.HideAllFormsInAllAddins(awpWindowHandle);
    finally
      Windows.LockWindowUpdate(0);
    end;
    Log.AddMessage('Event Send msgMayBeWordViewWasChanged');
    PostMessage(awpReceiverHandle, WM_ADXMAYBEWORDVIEWWASCHANGED, awpHostHandle, 0);
  finally
    event.Free;
  end;
end;

{ TFindWindow }

constructor TFindWindow.Create(startHandle, findHandle: HWND;
  findClassName, findTitle: PChar);
begin
  inherited Create;
  FHandles := TList.Create;
  FHandles.Clear;
  FindInfo.StartHandle := startHandle;
  FindInfo.FindHandle := findHandle;
  FindInfo.ClassName := findClassName;
  FindInfo.Title := findTitle;
  GetWindows(startHandle);
end;

var
  A: TFindWindow;

  function OnWindowEnum(handle, PFindInfo:HWND):BOOL; stdcall;
  var
    fInfo: ^ADXFINDWINDOW;
    wClassName, wTitle: widestring;
  begin
    Result := true;
    fInfo := Pointer(PFindInfo);
    if handle = fInfo^.FindHandle then begin
      A.FHandles.Add(Pointer(handle));
      Result := false;
    end
    else begin
      if ((fInfo^.ClassName <> nil) and (fInfo^.Title <> nil)) then begin
        wClassName := GetWindowClassName(handle);
        wTitle := GetWindowText_(handle);
        if ((fInfo^.ClassName = wClassName) and (fInfo^.Title = wTitle)) then begin
          A.FHandles.Add(Pointer(handle));
        end;
      end;
      if ((fInfo^.ClassName <> nil) and (fInfo^.Title = nil)) then begin
        wClassName := GetWindowClassName(handle);
        if fInfo^.ClassName = wClassName then begin
          A.FHandles.Add(Pointer(handle));
        end;
      end;
      if ((fInfo^.ClassName = nil) and (fInfo^.Title <> nil)) then begin
        wTitle := GetWindowText_(handle);
        if fInfo^.Title = wTitle then begin
          A.FHandles.Add(Pointer(handle));
        end;
      end;
    end;
    if Result then begin
      if fInfo^.StartHandle = 0 then begin
        EnumChildWindows(handle, @OnWindowEnum, Longint(PFindInfo));
        if (fInfo^.FindHandle <> 0) then Result := false;
      end;
    end;
  end;

  function WindowsEnumProc( wnd: HWND; lparam: LParam):BOOL; stdcall;
  begin
    if OnWindowEnum(wnd, lparam) then begin
      Result := true;
    end
    else begin
      Result := false;
    end;
  end;

destructor TFindWindow.Destroy;
begin
  if Assigned(FHandles) then begin
    FHandles.Free;
    FHandles := nil;
  end;
  inherited;
end;

procedure TFindWindow.GetWindows(parentHwnd:HWND);
  begin
    A := self;
    if parentHwnd = 0 then begin
      EnumWindows(@WindowsEnumProc, Longint(@FindInfo));
    end
    else begin
      EnumChildWindows(parentHwnd, @WindowsEnumProc, Longint(@FindInfo));
    end;
    A := nil;
end;

procedure TadxWordTaskPanesManager.DoWindowActivate(
  AWordContextArgs: TObject);
var
  EnableShowWindowsInTaskBarProperty: boolean;
  Context: TWordContextArgs;
begin
  Context := TWordContextArgs(AWordContextArgs);

  //Check if the ShowWindowsInTaskBarProperty was enabled
  EnableShowWindowsInTaskBarProperty := false;
  if (FLastProcessedContextWindow <> Context.FHostHandle) then begin
    if (FLastProcessedContextWindow <> 0) then begin
      EnableShowWindowsInTaskBarProperty := true;
    end;
  end;

  DoProcessContextWindow(AWordContextArgs);

  if (EnableShowWindowsInTaskBarProperty) then begin
    DoProcessAllWordWindows;
  end;

end;

procedure TadxWordTaskPanesManager.DoDocumentChange(
  AWordContextArgs: TObject);
begin
  DoProcessContextWindow(AWordContextArgs);
end;

procedure TadxWordTaskPanesManager.AddMayBeViewWasChangedMessageToReceiver;
begin
  Log.AddMessage('AddMayBeViewWasChangedMessageToReceiver');
  if (not TadxReceiverWindow(FReceiverWindow).Exists(TMayBeViewWasChangedMessage)) then
    TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
      (TMayBeViewWasChangedMessage.Create(self.ReceiverWindowHandle, self));
end;

{ TMayBeViewWasChangedMessage }

constructor TMayBeViewWasChangedMessage.Create(ReceiverHandle: HWND;
  AFormsManager: TadxWordTaskPanesManager);
begin
  inherited Create(ReceiverHandle);
  FFormsManager := AFormsManager;
end;

destructor TMayBeViewWasChangedMessage.Destroy;
begin
  FFormsManager := nil;
  inherited;
end;

function TMayBeViewWasChangedMessage.GetMessageName: string;
begin
  result := Globals.WM_ADXMAYBEWORDVIEWWASCHANGED;
end;

function TMayBeViewWasChangedMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  hostHandle: HWND;
  event: TLogEvent;
begin
  hostHandle := wParam;
  if (FFormsManager <> nil) then begin
    event := TLogEvent.Create('DoCheckMayBeViewWasChangedMessage');
    try
      FFormsManager.DoCheckMayBeViewWasChangedMessage(hostHandle);
    finally
      event.Free;
    end;
    result := 0;
  end else begin
    result := 0;
  end;
end;

procedure TadxWordTaskPanesManager.DoCheckMayBeViewWasChangedMessage(
  HostHandle: HWND);
var
  Context: TWordContextArgs;
begin
  DeleteFormsForNotVisibleHostHandle;//Case 2368 
  if (IsWindowVisible(HostHandle)) then begin
    Context := TWordContextArgs.Create(self);
    try
      DoProcessContextWindow(Context);
    finally
      Context.Free;
    end;
  end
  else begin
    Log.AddMessage('HostHandle is not visible ' + IntToStr(hostHandle));
  end;
end;

{ TFindWordWindowFactory }

function TFindWordWindowFactory.CreateSpecificFindWindowObject(
  ItemType: TadxItemType): TFindWindowObject;
begin
  case(ItemType) of
    stOlEnvelopeCommandBarForWordInspectorPreviwControl:
        case HostVersion of
            v2000,
            v2002,
            v2003,
            v2007,
            v2010:
                result := TEnvelopeCommandBarForWordInspectorPreviwControlFinder.Create(HostVersion);
            else raise SysUtils.Exception.Create('FindOutlookWindowFactory.GetFindWindowObject: Unknown HostVersion');
        end;
    else  raise SysUtils.Exception.Create('FindOutlookWindowFactory.GetFindWindowObject: Unknown AdxItemType');
  end;
end;

function TFindWordWindowFactory.GetHostVersion: TadxHostVersion;
begin
  result := TadxHostVersion(FormsManagerSingleton.FWordVersion);
end;


{ TEnvelopeCommandBarForWordInspectorPreviwControlFinder }

function TEnvelopeCommandBarForWordInspectorPreviwControlFinder.FindIn2000(
  HostHandle: HWND; Condition: TadxFindWindowConditions): HWND;
begin
  Result := 0;
end;

function TEnvelopeCommandBarForWordInspectorPreviwControlFinder.FindIn2002(
  HostHandle: HWND; Condition: TadxFindWindowConditions): HWND;
begin
  Result := FindChildWindowV(HostHandle, 'Envelope', 'MsoCommandBar', '', true, MustVisible(Condition));
end;

function TEnvelopeCommandBarForWordInspectorPreviwControlFinder.FindIn2003(
  HostHandle: HWND; Condition: TadxFindWindowConditions): HWND;
begin
  Result := FindChildWindowV(HostHandle, 'Envelope', 'MsoCommandBar', '', true, MustVisible(Condition));
end;

function TEnvelopeCommandBarForWordInspectorPreviwControlFinder.FindIn2007(
  HostHandle: HWND; Condition: TadxFindWindowConditions): HWND;
begin
  Result := 0;
end;

function TEnvelopeCommandBarForWordInspectorPreviwControlFinder.FindIn2010(
  HostHandle: HWND; Condition: TadxFindWindowConditions): HWND;
begin
  Result := 0;
end;

procedure TadxWordTaskPanesManager.DoProtectedWindowActivate(
  AWordContextArgs: TObject);
begin
  DoProcessContextWindow(AWordContextArgs);
end;

initialization
  FormsManagerSingleton := nil;


finalization

end.
