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

unit adxppFormsManager;

{$I adxolDefs.inc}

interface

uses
  SysUtils, Classes, Dialogs, ComObj, OleCtrls, Forms, StdCtrls,
  {$IFNDEF ADX_VCL5}Variants,{$ENDIF}
  {$IFDEF ADX_VCL5}OleServer, FileCtrl,{$ENDIF}
  Windows, Messages, Graphics, Controls, ComCtrls, ExtCtrls, ToolWin,
  Buttons, Menus, TypInfo,
  Office2000, MSPpt2000,
  adxAddin, adxHostAppEvents,
  {$IFNDEF ADX_VCL5}OLEServer,{$ENDIF}
  adxWSbcls, adxCore
  ;

type

  TadxPowerPointVersion = integer;

  TadxPowerPointTaskPaneClassName = string;

  TadxPowerPointSplitter = (
    sbNone,
    sbStandard
  );

  TadxPowerPointTaskPanePosition = (
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

  TadxPowerPointCloseButtonClickEventArgs = class
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


  TadxPowerPointCloseButtonClickEventHandler = procedure(Sender: TObject; Args: TadxPowerPointCloseButtonClickEventArgs) of object;

  TadxPowerPointEnterEventArgs = class
  end;

  TadxPowerPointExitEventArgs = class
  end;

  TadxPowerPointFormEnterEventHandler = procedure(Sender: TObject; Args: TadxPowerPointEnterEventArgs) of object;
  TadxPowerPointFormExitEventHandler = procedure(Sender: TObject; Args: TadxPowerPointExitEventArgs) of object;

  TadxPowerPointPostMessageReceivedEventArgs = class
  public
    wParam: Cardinal;
    lParam: Cardinal;
  end;

  TadxPowerPointPostMessageReceivedEventHandler = procedure(Args: TadxPowerPointPostMessageReceivedEventArgs) of object;

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

//TODO
{$IFDEF ADX_VCL5}
  TadxKeyFilterAction = integer;
const
  faSendToHostApplication = $03;
  faSendToTaskPane = $30;
{$ELSE}
  TadxKeyFilterAction = (faSendToHostApplication = $03, faSendToTaskPane = $30);
{$ENDIF}

type

  TadxPowerPointTaskPanesCollectionItem = class;

  TadxBeforeTaskPaneInstanceCreateEventArgs = class
  private
    FItem: TadxPowerPointTaskPanesCollectionItem;
    FCancel: boolean;
  public
    constructor Create(AItem: TadxPowerPointTaskPanesCollectionItem; ADefaultCancel: boolean); overload;
    destructor Destroy; override;
    property Item: TadxPowerPointTaskPanesCollectionItem read FItem;
    property Cancel: boolean read FCancel write FCancel;
  end;

  TadxBeforeTaskPaneInstanceCreateEventHandler = procedure(ASender: TObject;
    Args: TadxBeforeTaskPaneInstanceCreateEventArgs) of object;


  TadxPowerPointTaskPanesCollection = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TadxPowerPointTaskPanesCollectionItem;
    procedure SetItem(Index: Integer; Value: TadxPowerPointTaskPanesCollectionItem);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
  public
    {$IFDEF ADX_VCL5}
    function Owner: TPersistent;
    {$ENDIF}
    function Add: TadxPowerPointTaskPanesCollectionItem; overload;
    property Items[Index: Integer]: TadxPowerPointTaskPanesCollectionItem read GetItem write SetItem; default;
  end;

  TadxPowerPointTaskPanesManager = class;
  TadxPowerPointTaskPane = class(TadxPPCustomForm)
  private
    FHostHandle: HWND;
    FWindowHandle: HWND;
    FFormsManager: TadxPowerPointTaskPanesManager;
    FItem: TadxPowerPointTaskPanesCollectionItem;

    FOnADXBeforeFormShow: TadxBeforeTaskPaneShowEventHandler;
    FOnADXAfterFormShow: TadxAfterTaskPaneShowEventHandler;

    FOnADXCloseButtonClick: TadxPowerPointCloseButtonClickEventHandler;
    FOnADXEnter: TadxPowerPointFormEnterEventHandler;
    FOnADXExit: TadxPowerPointFormExitEventHandler;
    FOnADXPostMessage: TadxPowerPointPostMessageReceivedEventHandler;
    FOnADXAfterTaskPaneHide: TadxAfterTaskPaneHideEventHandler;
    FisHiddenByDeveloper: boolean;
    procedure MarkHiddenByDeveloper(value: boolean);

    function GetAddinModule: TObject;
    function GetPowerPointAppObj: PowerPointApplication;

    procedure UpdateAppWindowPropertyAfterBeforeFormShowEvent(AAppWindowProperty: Pointer);
    procedure AdxPPShow(AAppWindowProperty: Pointer; raiseEvents: boolean);
    procedure ADXPPHide(raiseEvents: boolean);
    procedure DisposePowerPointObjects;

    procedure DoADXBeforeTaskPaneShow(Args: TadxBeforeTaskPaneShowEventArgs);
    procedure DoADXAfterTaskPaneHide(args: TadxAfterTaskPaneHideEventArgs);
    procedure DoADXAfterFormShow(Args: TadxAfterTaskPaneShowEventArgs);

    procedure SetContextForm(APowerPointContextArgs: TObject; AAppWindowProperty: Pointer);
    function GetPowerPointApp: TPowerPointApplication;

    procedure DoAdxEnter(args: TadxPowerPointEnterEventArgs);
    procedure DoAdxExit(args: TadxPowerPointExitEventArgs);
    procedure DoAdxPostMessage(args: TadxPowerPointPostMessageReceivedEventArgs);

    procedure DoReceiveAdxPostMessageCluster(msg: TMessage);
    function GetCurrentPowerPointWindowHandle: HWND;
    class function GetPositionKey(Position: TadxPowerPointTaskPanePosition): string;
    procedure InternalSetDragItems(ADragItems: TList; dragWindowLayouts: TadxDragWindowLayout; AllowedDropPosition: TadxAllowedDropPosition);

  protected
    procedure HideByManager(UsingVisibleProperty: boolean); override;

    function  AdxRegistryKey: string; override;
    function  AdxLocalRegistryKey: string; override;
    function  GetDefaultRegionState: TadxInternalRegionState; override;

    function  AdxLayoutKey: string; override;
    function  RegistryKey: string; override;
    procedure DoInstanceFocused(focused: boolean); override;

    procedure WndProc(var Msg: TMessage); override;

    procedure SetDragItems(ADragItems: TList); override;
    procedure GetDragLayoutParams(var lParams: TadxDragLayoutParams); override;
    procedure SetDragForm(AItemType: TAdxItemType; ALayout: TadxWindowLayout); override;
    function  IsDragDropAllowed: boolean; override;
    function  IsExpandFromMinimizedState: boolean; override;
    function  UseOfficeThemeBackColor: boolean; override;



  public
    constructor CreateEx(AFormsManager: TadxPowerPointTaskPanesManager; AItem: TadxPowerPointTaskPanesCollectionItem); virtual;
    destructor Destroy; override;

    procedure Hide; override;
    procedure Show; override;
    procedure ADXPostMessage(wParam, lParam: Cardinal);
    property CurrentPowerPointWindowHandle: HWND read GetCurrentPowerPointWindowHandle;
    property PowerPointAppObj: PowerPointApplication read GetPowerPointAppObj;
    property PowerPointApp: TPowerPointApplication read GetPowerPointApp;
    property PowerPointTaskPaneManager: TadxPowerPointTaskPanesManager read FFormsManager;
    property AddinModule: TObject read GetAddinModule;
    property Item: TadxPowerPointTaskPanesCollectionItem read FItem;

  published
    property OnADXBeforeTaskPaneShow: TadxBeforeTaskPaneShowEventHandler read FOnADXBeforeFormShow write FOnADXBeforeFormShow;
    property OnADXAfterTaskPaneShow: TadxAfterTaskPaneShowEventHandler read FOnADXAfterFormShow write FOnADXAfterFormShow;
    property OnADXCloseButtonClick: TadxPowerPointCloseButtonClickEventHandler read FOnADXCloseButtonClick write FOnADXCloseButtonClick;

    property OnADXEnter: TadxPowerPointFormEnterEventHandler read FOnADXEnter write FOnADXEnter;
    property OnADXExit: TadxPowerPointFormExitEventHandler read FOnADXExit write FOnADXExit;
    property OnADXPostMessageReceived: TadxPowerPointPostMessageReceivedEventHandler read FOnADXPostMessage write FOnADXPostMessage;
    property OnADXAfterTaskPaneHide: TadxAfterTaskPaneHideEventHandler read FOnADXAfterTaskPaneHide write FOnADXAfterTaskPaneHide;
  end;

  TadxPowerPointTaskPanesManager = class(TComponent)
  private
    WasFirstWindowActivateFlag: boolean;
    hMessageMutex:  THandle;
    FReceiverWindow: Pointer;

    FState: TObject;
    FPowerPointHook: TadxWdHook;

    FPowerPointVersion: integer;
    FItems: TadxPowerPointTaskPanesCollection;
    FAddinModuleEvents: TObject; //TAddinEvents
    FPowerPointEvents: TObject; //TadxPowerPointEvents;
    FOnADXInitialize: TadxInitializeEventHandler;
    FOnADXBeforeFormInstanceCreate: TadxBeforeTaskPaneInstanceCreateEventHandler;
    FOnADXError: TadxErrorEventHandler;
    FHostHandle: HWND;

    procedure AddCloseButtonClickMessageToReceiver();

    procedure HideAllForms();
    procedure DeleteAllForms();

    procedure SetPowerPointVersion;
    function GetItems: TadxPowerPointTaskPanesCollection;
    procedure SetItems(const Value: TadxPowerPointTaskPanesCollection);
    function COMAddInModule: TadxCOMAddInModule;
    function ReceiverWindowHandle: HWND;

    function GetPowerPointAppObj: PowerPointApplication;

    function FindFormByHandle(AFormHandle: HWND): TadxPowerPointTaskPane;
    procedure DoRegionCloseButtonClick(AFormHandle: HWND); overload;
    procedure DoRegionCloseButtonClick(AForm: TadxPowerPointTaskPane); overload;


    procedure DoAddInBeginShutdown(Sender: TObject);
    procedure DoAddInFinalize(Sender: TObject);
    procedure DoAddInInitialize(Sender: TObject);
    procedure DoAddInStartupComplete(Sender: TObject);

    procedure ProcessEnableByCOMAddinsDialog;

    procedure DoADXInitialize;
    procedure DoBeforeFormInstanceCreate(Args: TadxBeforeTaskPaneInstanceCreateEventArgs);

    procedure TryShow(Form: TadxPowerPointTaskPane);
    procedure ShowForms(APowerPointContextArgs: TObject);
    procedure ShowForm(AItem: TadxPowerPointTaskPanesCollectionItem; APowerPointContextArgs: TObject);
    function CreateTaskPaneInstance(AItem: TadxPowerPointTaskPanesCollectionItem; HostHandle: HWND): TadxPowerPointTaskPane;
    function GetAdxItemType(Item: TadxPowerPointTaskPanesCollectionItem): TAdxItemType;
    procedure DoWindowActivate(APowerPointContextArgs: TObject);
    procedure DoProtectedWindowActivate(APowerPointContextArgs: TObject);
    procedure DoProcessContextWindow(APowerPointContextArgs: TObject);
    procedure DeleteFormsForNotVisibleHostHandle;

    function WindowClassName: string;

    procedure CheckSecondComponent(AOwner: TComponent);

    procedure CreatePowerPointEvents();
    procedure DisposePowerPointEvents();
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
    function GetHostHandle: HWND;

    function  AdxRegistryKey: string;
    function  AdxLocalRegistryKey: string;

    function ConvertPositionToAllowedDropPosition(Position: TadxPowerPointTaskPanePosition): TadxAllowedDropPosition;
    procedure LoadPositionsFromRegistry;
    function CheckAllowedDropPosition(Item: TadxPowerPointTaskPanesCollectionItem; WindowLayout: TadxWindowLayout): boolean;
    function CompareAllowedDropPositionsAndWindowLayout(Item: TadxPowerpointTaskPanesCollectionItem; WindowLayout: TadxWindowLayout; AllowedDropPosition: TadxAllowedDropPosition): boolean;
    function GetPosition(ItemType: TadxItemType; WindowLayout: TadxWindowLayout): TadxPowerPointTaskPanePosition;
    function GetPositionSize(Position: TadxPowerPointTaskPanePosition): integer;
    function GetADXWindowLayout(AllowedDropPosition: TadxAllowedDropPosition): TadxWindowLayout;
    function GetWasAddinInitialize: boolean;

    property HostHandle: HWND read GetHostHandle;
    property WasAddinInitialize: boolean read GetWasAddinInitialize;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property PowerPointAppObj: PowerPointApplication read GetPowerPointAppObj;
  published
    property Items: TadxPowerPointTaskPanesCollection read GetItems write SetItems;

    property OnADXInitialize: TadxInitializeEventHandler read FOnADXInitialize write FOnADXInitialize;
    property OnADXBeforeTaskPaneInstanceCreate: TadxBeforeTaskPaneInstanceCreateEventHandler
      read FOnADXBeforeFormInstanceCreate write FOnADXBeforeFormInstanceCreate;
    property OnADXError: TadxErrorEventHandler  read FOnADXError write FOnADXError;
  end;

  TadxPowerPointTaskPanesCollectionItem = class(TCollectionItem)
  private
    FDefaultRegionState: TadxRegionState;
    FFormInstances: TObject;
    FLayout: TadxPowerPointTaskPanePosition;
    FEnabled: boolean;
    FSplitter: TadxPowerPointSplitter;
    FFormClassName: TadxPowerPointTaskPaneClassName;
    FTag: Longint;
    FCloseButton: boolean;
    FAlwaysShowHeader: boolean;
    FRestoreFromMinimizedState: boolean;
    FAllowedDropPositions: TadxAllowedDropPositions;
    FIsDragDropAllowed: boolean;
    FIsHiddenStateAllowed: boolean;
    FRegionBorder: TadxRegionBorderStyle;
    FUseOfficeThemeForBackground: boolean;
    procedure SetPosition(const Value: TadxPowerPointTaskPanePosition);
    procedure SetEnabled(const Value: boolean);
    procedure SetSplitter(const Value: TadxPowerPointSplitter);
    procedure SetFormClassName(const Value: TadxPowerPointTaskPaneClassName);
    procedure SetAlwaysShowHeader(const Value: boolean);
    procedure SetCloseButton(const Value: boolean);

    function GetTaskPaneInstance: TadxPowerPointTaskPane;
    procedure DeleteAllForms;
    procedure DeleteFormsForNotVisibleHostHandle;
    procedure HideAllForms;
    procedure HideAllNotInjectedForms;
    procedure SetAppWindowProperty(APowerPointContextArgs: TObject; AAppWindowProperty: Pointer);
    function FindForm(HostHandle: HWND): TadxPowerPointTaskPane;
    procedure FormsHideShow;

    function CreateForm: TadxPowerPointTaskPane;
    function CreateTaskPane: TadxPowerPointTaskPane;
    function FormsManager: TadxPowerPointTaskPanesManager;
    function GetAdxLayout: integer;
    function GetDefaultRegionState: TadxRegionState;
    procedure SetDefaultRegionState(const Value: TadxRegionState);
    procedure SetAllowedDropPositions(
      const Value: TadxAllowedDropPositions);

    function ItemRegistryKey: string;
    procedure SavePositionToRegistry;
    procedure LoadPositionFromRegistry;
    procedure AddCurrentPositionToAllowedDropPositions;
    procedure SetIsDragDropAllowed(const Value: boolean);
    class function ConvertPositionToDesignString(Position: TadxPowerPointTaskPanePosition): string;
    procedure SetHideButtonVisible (const Value: boolean);
    function GetTaskPaneInstanceCount: integer;
    function GetTaskPaneInstances(Index: Integer): TadxPowerPointTaskPane;
    procedure SetUseOfficeThemeForBackground(const Value: boolean);

  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure ShowTaskPane;
    function CreateTaskPaneInstance(): TadxPowerPointTaskPane;
    property TaskPaneInstance: TadxPowerPointTaskPane read GetTaskPaneInstance;
    property TaskPaneInstanceCount: integer read GetTaskPaneInstanceCount;
    property TaskPaneInstances[Index: Integer]: TadxPowerPointTaskPane read GetTaskPaneInstances;
  published
    property Position: TadxPowerPointTaskPanePosition read FLayout write SetPosition default pUnknown;
    property AllowedDropPositions: TadxAllowedDropPositions read FAllowedDropPositions write SetAllowedDropPositions default [];
    property TaskPaneClassName: TadxPowerPointTaskPaneClassName read FFormClassName write SetFormClassName;
    property Enabled: boolean read FEnabled write SetEnabled default true;
    property Splitter: TadxPowerPointSplitter read FSplitter write SetSplitter default sbStandard;
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


  TadxPowerPointTaskPaneClass = class of TadxPowerPointTaskPane;

var
  adxPpForm: TadxPowerPointTaskPane;

function Log: ILog;


implementation

{$R adxPowerPointTaskPane.dfm}

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

var
  FormsManagerSingleton: TadxPowerPointTaskPanesManager;

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
      if r.OpenKeyReadOnly('Software\Add-in Express\InstalledProducts\Add-in Express 2007 for VCL\Plugins\ADX Extensions VCL for Microsoft PowerPoint') then begin
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

type

  TadxPowerPointExceptionManager = class(TadxExceptionManager)
    procedure InternalProcessADXXError(err: SysUtils.Exception; whereHappened: string); override;
  end;

  TPowerPointAppWindowBehaviour = class(TAppWindowBehaviour)
  protected
    procedure WM_DESTROY(hWnd: THandle; Msg: UINT; wParam, lParam: Longint; appWindow: TAppWindow); override;
  end;


  GlobalsPp = class
    class function ADXPpReceiverWindowCaption: string;
    //class function PowerPointWindowClassName: string;
  end;


  TadxPowerPiontAddinEvents = class
  private
    FCOMAddInModule: TadxCOMAddInModule;
    FFormsManager: TadxPowerPointTaskPanesManager;
    FOldAddInBeginShutdown: TNotifyEvent;
    FOldAddInFinalize: TNotifyEvent;
    FOldAddInInitialize: TNotifyEvent;
    FOldAddInStartupComplete: TNotifyEvent;
    procedure Connect;
    procedure Disconnect;
  public
    constructor Create(AFormsManager: TadxPowerPointTaskPanesManager; ACOMAddInModule: TadxCOMAddInModule);
    destructor Destroy; override;
    procedure OnAddInBeginShutdown(Sender: TObject);
    procedure OnAddInFinalize(Sender: TObject);
    procedure OnAddInInitialize(Sender: TObject);
    procedure OnAddInStartupComplete(Sender: TObject);
  end;


  TadxxPowerPointEvents = class(TadxxCustomEvents)
  private
    FFormsManager: TadxPowerPointTaskPanesManager;
    FIntf: MSPpt2000._Application;
    procedure OnWindowActivate(ASender: TObject;
      const Presentation: _Presentation; const Window: MSPpt2000.DocumentWindow);
    procedure OnProtectedViewWindowActivate(ASender: TObject; const PvWindow: IDispatch);
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    constructor CreateEx(AFormsManager: TadxPowerPointTaskPanesManager);
    procedure ConnectTo(AIntf: IDispatch); overload; override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: integer); overload;
    procedure Disconnect; override;
  end;

  TadxPowerPointTaskPanesManagerState = class
  protected
    isShutdown: boolean;
    WasAddinInitialize: boolean;
    isAddinInitialize: boolean;
    procedure Restore;
  public
    constructor Create;
  end;

  TPowerPointContextArgs = class
  private
    function GetPowerPointVersion: integer;
  private
    FHostHandle: HWND;
    FFormsManager: TadxPowerPointTaskPanesManager;
    FPowerPointApplication: MSPpt2000._Application;
    FPresentation: MSPpt2000._Presentation;
    FWindow: MSPpt2000.DocumentWindow;
    FProtectedWindow: IDispatch;
    function GetIsValidForTaskPaneCreating: boolean;
    procedure InitializeActiveContext;
    function GetHostHandle: HWND;
    procedure SetHostHandleFromActiveWindow;
    procedure SetHostHandleFromMainWindow(WindowName: string);
    property PowerPointVersion: integer read GetPowerPointVersion;
  public
    constructor Create(AFormsManager: TadxPowerPointTaskPanesManager); overload;
    constructor Create(AFormsManager: TadxPowerPointTaskPanesManager; AProtectedWindow: IDispatch); overload;
    destructor Destroy; override;
    property HostHandle: HWND read GetHostHandle;
    property IsValidForTaskPaneCreating: boolean read GetIsValidForTaskPaneCreating;
  end;

  TadxPowerPointTaskPanesManagerList = class(TList)
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
    FFormsManager: TadxPowerPointTaskPanesManager;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; AFormsManager: TadxPowerPointTaskPanesManager);
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
  AItem: TadxPowerPointTaskPanesCollectionItem; ADefaultCancel: boolean);
begin
  FCancel := ADefaultCancel;
  FItem := AItem;
end;

destructor TadxBeforeTaskPaneInstanceCreateEventArgs.Destroy;
begin
  FItem := nil;
  inherited;
end;

{ TadxPowerPointTaskPanesCollectionItem }

constructor TadxPowerPointTaskPanesCollectionItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FRegionBorder := rbsSingle;
  FEnabled := true;
  FIsHiddenStateAllowed := true;
  FSplitter := sbStandard;
  FUseOfficeThemeForBackground:= false;
  FFormInstances := TadxPowerPointTaskPanesManagerList.Create(Self);
end;

function TadxPowerPointTaskPanesCollectionItem.CreateForm: TadxPowerPointTaskPane;
var
  p: TPersistentClass;
begin
  try
    p := GetClass(TaskPaneClassName);
    result := TadxPowerPointTaskPaneClass(p).CreateEx(FormsManager, self);
    if (result <> nil) then begin
      TadxPowerPointTaskPanesManagerList(FFormInstances).Add(result);
      result.UpdateColor(FormsManager.FPowerPointVersion);
    end;
  except
    on Ex:SysUtils.Exception do begin
      raise SysUtils.Exception.Create('TadxPowerPointTaskPanesCollectionItem.CreateForm: ' + Ex.Message);
    end;
  end;
end;

function TadxPowerPointTaskPanesCollectionItem.CreateTaskPaneInstance: TadxPowerPointTaskPane;
var
  ContextArgs: TPowerPointContextArgs;
begin
  result := nil;
  Log.AddMessage('TadxPowerPointTaskPanesCollectionItem.CreateTaskPaneInstance');
  ContextArgs := TPowerPointContextArgs.Create(self.FormsManager);
  try
    try
      if (TadxPowerPointTaskPanesManagerList(FFormInstances).Count > 0) then begin
        raise SysUtils.Exception.Create('An instance of TadxPowerPointTaskPane already exists.');
      end;
      result := self.FormsManager.CreateTaskPaneInstance(self, ContextArgs.HostHandle);
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'CreateTaskPaneInstance');
        result := nil;
      end;
    end;
  finally
    ContextArgs.Free;
  end;
end;

procedure TadxPowerPointTaskPanesCollectionItem.DeleteAllForms;
var
  Form: TadxPowerPointTaskPane;
  FormIndex: integer;
begin
  Log.AddMessage('TadxPowerPointTaskPanesCollectionItem.DeleteAllForms ' + IntToStr(TadxPowerPointTaskPanesManagerList(FFormInstances).Count));
  try
    Log.AddIndent();
    try
      FormIndex := 0;
      while FormIndex < TadxPowerPointTaskPanesManagerList(FFormInstances).Count do begin
        if TadxPowerPointTaskPanesManagerList(FFormInstances)[FormIndex] <> nil then begin
          Form := TadxPowerPointTaskPanesManagerList(FFormInstances)[FormIndex];
          Form.Free;
          TadxPowerPointTaskPanesManagerList(FFormInstances).Delete(FormIndex);
          Dec(FormIndex);
        end;
        Inc(FormIndex);
      end;
    finally
      Log.RemoveIndent();
    end;
  except
    on E: SysUtils.Exception do begin
      Log.AddException('TadxPowerPointTaskPanesCollectionItem.DeleteAllForms: ' + E.Message);
      raise E;
    end;
  end;
end;


destructor TadxPowerPointTaskPanesCollectionItem.Destroy;
begin
  if Assigned(FFormInstances) then begin
    FFormInstances.Free;
  end;
  inherited;
end;

function TadxPowerPointTaskPanesCollectionItem.FindForm(HostHandle: HWND): TadxPowerPointTaskPane;
var
  i: integer;
begin
  result := nil;
  for i:=0 to TadxPowerPointTaskPanesManagerList(FFormInstances).Count - 1 do begin
    if (TadxPowerPointTaskPane(TadxPowerPointTaskPanesManagerList(FFormInstances)[i]).FHostHandle = HostHandle) then begin
      result := TadxPowerPointTaskPanesManagerList(FFormInstances)[i];
      exit;
    end;
  end;
end;

procedure TadxPowerPointTaskPanesCollectionItem.FormsHideShow;
var
  index: integer;
begin
  Log.AddMessage('TadxPowerPointTaskPanesCollectionItem.FormsHideShow');
  for index := 0 to TadxPowerPointTaskPanesManagerList(FFormInstances).Count - 1 do begin
    if TadxPowerPointTaskPanesManagerList(FFormInstances)[index] <> nil then begin
      if TadxPowerPointTaskPane(TadxPowerPointTaskPanesManagerList(FFormInstances)[index]).Visible then begin
        if (not TadxPowerPointTaskPane(TadxPowerPointTaskPanesManagerList(FFormInstances)[index]).LockVisible) then begin
          TadxPowerPointTaskPane(TadxPowerPointTaskPanesManagerList(FFormInstances)[index]).ADXPPHide(true);
          FormsManager.TryShow(TadxPowerPointTaskPane(TadxPowerPointTaskPanesManagerList(FFormInstances)[index]));
        end;
      end;
    end;
  end;
end;

function TadxPowerPointTaskPanesCollectionItem.GetAdxLayout: integer;
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

function TadxPowerPointTaskPanesCollectionItem.CreateTaskPane: TadxPowerPointTaskPane;
begin
  Log.AddMessage('GetForm');
  result := CreateForm;
  if (result = nil) then begin
    TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxPowerPointTaskPanesCollectionItem.GetForm: A form has not been created.'), 'CreateTaskPane')
  end;
end;

function TadxPowerPointTaskPanesCollectionItem.GetTaskPaneInstance: TadxPowerPointTaskPane;
var
  ActiveWindowHandle: HWND;
  i: integer;
  FWindow: MSPpt2000.DocumentWindow;
begin
  if (FormsManager.FPowerPointVersion < v2010) then begin
    if (TadxPowerPointTaskPanesManagerList(FFormInstances).Count = 0) then begin
      result := nil;
    end
    else begin
      result := TadxPowerPointTaskPanesManagerList(FFormInstances)[0];
    end;
  end
  else begin
    Log.AddMessage('TadxWordTaskPanesCollectionItem.GetCurrentTaskPaneInstance');
    ActiveWindowHandle := APIUtils.GetActiveWindow(FormsManager.WindowClassName);
    if (ActiveWindowHandle = 0) then begin
      try
        FWindow := FormsManagerSingleton.PowerPointAppObj.ActiveWindow;
      except
        FWindow := nil;
      end;
      if (FWindow <> nil) then begin
        ActiveWindowHandle := FindMainWindowInProcess(GetDesktopWindow(), FWindow.Caption, PowerPointWindowClass(FormsManager.FPowerPointVersion), false);
      end;
    end;
    result := nil;
    for i := 0 to TadxPowerPointTaskPanesManagerList(FFormInstances).Count - 1 do begin
      if (TadxPowerPointTaskPane(TadxPowerPointTaskPanesManagerList(FFormInstances)[i]).FHostHandle = ActiveWindowHandle)
        or (TadxPowerPointTaskPane(TadxPowerPointTaskPanesManagerList(FFormInstances)[i]).Handle = ActiveWindowHandle) then begin
        result := TadxPowerPointTaskPane(TadxPowerPointTaskPanesManagerList(FFormInstances)[i]);
      end;
    end;
  end;

end;

function TadxPowerPointTaskPanesCollectionItem.FormsManager: TadxPowerPointTaskPanesManager;
begin
  try
  {$IFDEF ADX_VCL5}
      result := TadxPowerPointTaskPanesManager(TadxPowerPointTaskPanesCollection(Collection).GetOwner)
  {$ELSE}
      result := TadxPowerPointTaskPanesManager(Collection.Owner);
  {$ENDIF}
  except
    on Ex: SysUtils.Exception do begin
      raise SysUtils.Exception.Create('TadxPowerPointTaskPanesCollectionItem.FormsManager' + Ex.Message);
    end;
  end;
end;

procedure TadxPowerPointTaskPanesCollectionItem.HideAllForms;
var
  index: integer;
begin
  Log.AddMessage('TadxPowerPointTaskPanesCollectionItem.HideAllForms');
  for index := 0 to TadxPowerPointTaskPanesManagerList(FFormInstances).Count - 1 do begin
    if TadxPowerPointTaskPanesManagerList(FFormInstances)[index] <> nil then begin
      if TadxPowerPointTaskPane(TadxPowerPointTaskPanesManagerList(FFormInstances)[index]).Visible then begin
        TadxPowerPointTaskPane(TadxPowerPointTaskPanesManagerList(FFormInstances)[index]).ADXPPHide(true);
      end;
    end;
  end;
end;

procedure TadxPowerPointTaskPanesCollectionItem.SetAppWindowProperty(
  APowerPointContextArgs: TObject; AAppWindowProperty: Pointer);
var
  PowerPointContextArgs: TPowerPointContextArgs;
  ContextAdxItemType: TAdxItemType;
  AppWindowProperty :PAppWindowProperty;

begin
  Log.AddMessage('TadxPowerPointTaskPanesCollectionItem.SetAppWindowProperty');
  AppWindowProperty := PAppWindowProperty(AAppWindowProperty);

  PowerPointContextArgs := TPowerPointContextArgs(APowerPointContextArgs);

  ContextAdxItemType := FormsManager.GetAdxItemType(self);
  if (ContextAdxItemType > 0) then begin
    AppWindowProperty^.HostHandle := PowerPointContextArgs.FHostHandle;
    AppWindowProperty^.ItemType := ContextAdxItemType;
    AppWindowProperty^.WindowHandle := GetAppWindowHandle(Ord(FormsManager.FPowerPointVersion), ContextAdxItemType, PowerPointContextArgs.FHostHandle);

    AppWindowProperty^.Offset := GetOffset(FormsManager.FPowerPointVersion, ContextAdxItemType);
    AppWindowProperty^.Layout := Self.GetAdxLayout();
    AppWindowProperty^.ContainerType := 0;

    AppWindowProperty^.AlwaysShowHeader:= AlwaysShowHeader;
    AppWindowProperty^.CloseButton := CloseButton;
    AppWindowProperty^.SplitterButton := IsHiddenStateAllowed;
    AppWindowProperty^.RegionBorder := self.RegionBorder;

    AppWindowProperty^.HostVersion  := FormsManager.FPowerPointVersion;
    AppWindowProperty^.Splitter := Ord(Self.Splitter);
  end;
end;

procedure TadxPowerPointTaskPanesCollectionItem.SetEnabled(const Value: boolean);
begin
  if (self.FEnabled <> Value) then begin
    self.FEnabled := Value;
    DeleteAllForms;
  end;
end;

procedure TadxPowerPointTaskPanesCollectionItem.SetFormClassName(
  const Value: TadxPowerPointTaskPaneClassName);
begin
  if (not Globals.CompareADXStrings(Self.FFormClassName, Value)) then begin
    Log.AddMessage('TadxPowerPointTaskPanesCollectionItem.SetFormClassName');
    Self.FFormClassName := Value;
    DeleteAllForms();
  end;
end;

procedure TadxPowerPointTaskPanesCollectionItem.SetPosition(const Value: TadxPowerPointTaskPanePosition);
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

procedure TadxPowerPointTaskPanesCollectionItem.SetSplitter(
  const Value: TadxPowerPointSplitter);
begin
  if (self.FSplitter <> Value) then begin
    self.FSplitter :=Value;
  end;
end;

procedure TadxPowerPointTaskPanesCollectionItem.SetUseOfficeThemeForBackground(const Value: boolean);
var
  taskPane: TadxPowerPointTaskPane;
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

function TadxPowerPointTaskPanesCollectionItem.GetDefaultRegionState: TadxRegionState;
begin
  result := FDefaultRegionState;
end;

procedure TadxPowerPointTaskPanesCollectionItem.SetDefaultRegionState(
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

procedure TadxPowerPointTaskPanesCollectionItem.SetAllowedDropPositions(
  const Value: TadxAllowedDropPositions);
begin
  FAllowedDropPositions := Value;
  AddCurrentPositionToAllowedDropPositions(); 
end;

procedure TadxPowerPointTaskPanesCollectionItem.AddCurrentPositionToAllowedDropPositions;
begin
  if (IsDragDropAllowed) then begin
     if (self.Position <> pUnknown) then begin
       self.FAllowedDropPositions := self.FAllowedDropPositions + [FormsManager.ConvertPositionToAllowedDropPosition(self.Position)];
     end;
  end;
end;

function TadxPowerPointTaskPanesCollectionItem.ItemRegistryKey: string;
begin
  result := FormsManager.AdxLocalRegistryKey + '\' + self.ClassName + IntToStr(self.Index);
end;

procedure TadxPowerPointTaskPanesCollectionItem.LoadPositionFromRegistry;
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
          self.Position := TadxPowerPointTaskPanePosition(Reg.ReadInteger('Position'));
        end;
      end;
    finally
      Reg.CloseKey;
      Reg.Free;
    end;
  end;
end;

procedure TadxPowerPointTaskPanesCollectionItem.SavePositionToRegistry;
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

procedure TadxPowerPointTaskPanesCollectionItem.SetIsDragDropAllowed(
  const Value: boolean);
begin
  FIsDragDropAllowed := Value;
  if (FIsDragDropAllowed) then begin
    FAlwaysShowHeader := true;
    AddCurrentPositionToAllowedDropPositions;
  end;
end;

class function TadxPowerPointTaskPanesCollectionItem.ConvertPositionToDesignString(
  Position: TadxPowerPointTaskPanePosition): string;
begin
  case Position of
    pUnknown: result := 'pUnknown';
    pTop:     result := 'pTop';
    pBottom:  result := 'pBottom';
    pRight:   result := 'pRight';
    pLeft:    result := 'pLeft';
  end;
end;

procedure TadxPowerPointTaskPanesCollectionItem.SetHideButtonVisible(
  const Value: boolean);
begin
  FIsHiddenStateAllowed := Value;
  if (not FIsHiddenStateAllowed) and (self.DefaultRegionState = rsHidden) then begin
    self.DefaultRegionState := rsMinimized;
  end;
end;

function TadxPowerPointTaskPanesCollectionItem.GetTaskPaneInstanceCount: integer;
begin
  result := TadxPowerPointTaskPanesManagerList(FFormInstances).Count;
end;

function TadxPowerPointTaskPanesCollectionItem.GetTaskPaneInstances(
  Index: Integer): TadxPowerPointTaskPane;
var
  taskPane: TObject;
begin
  result := nil;
  taskPane := TadxPowerPointTaskPanesManagerList(FFormInstances)[Index];
  if (taskPane <> nil) then begin
    result := taskPane as TadxPowerPointTaskPane;
  end;
end;

procedure TadxPowerPointTaskPanesCollectionItem.DeleteFormsForNotVisibleHostHandle;
var
  Form: TadxPowerPointTaskPane;
  FormIndex: integer;
begin
  Log.AddMessage('TadxPowerPointTaskPanesCollectionItem.DeleteFormsForNotVisibleHostHandle ' + IntToStr(TadxPowerPointTaskPanesManagerList(FFormInstances).Count));
  try
    Log.AddIndent();
    try
      FormIndex := 0;
      while FormIndex < TadxPowerPointTaskPanesManagerList(FFormInstances).Count do begin
        if TadxPowerPointTaskPanesManagerList(FFormInstances)[FormIndex] <> nil then begin
          Form := TadxPowerPointTaskPanesManagerList(FFormInstances)[FormIndex];
          if (not Windows.IsWindowVisible(Form.FHostHandle)) then begin
            Form.Free;
            TadxPowerPointTaskPanesManagerList(FFormInstances).Delete(FormIndex);
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
      Log.AddException('TadxPowerPointTaskPanesCollectionItem.DeleteAllForms: ' + E.Message);
      raise E;
    end;
  end;
end;

{ TadxPowerPointTaskPanesCollection }

function TadxPowerPointTaskPanesCollection.Add: TadxPowerPointTaskPanesCollectionItem;
begin
  Result := TadxPowerPointTaskPanesCollectionItem.Create(Self);
  if (csDesigning in TadxPowerPointTaskPanesManager(Owner).ComponentState) then begin
    Result.UseOfficeThemeForBackground := true;
  end;
end;

function TadxPowerPointTaskPanesCollection.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := 'Name';
    1: Result := 'TaskPaneClassName';
    2: Result := 'Position';
  else
    Result := '';
  end;
end;

function TadxPowerPointTaskPanesCollection.GetAttrCount: Integer;
begin
  Result := 3;
end;

function TadxPowerPointTaskPanesCollection.GetItem(
  Index: Integer): TadxPowerPointTaskPanesCollectionItem;
begin
  Result := TadxPowerPointTaskPanesCollectionItem(inherited Items[Index]);
end;

function TadxPowerPointTaskPanesCollection.GetItemAttr(Index,
  ItemIndex: Integer): string;
begin
  case Index of
    0: Result := Format('%d - ', [ItemIndex]) + Items[ItemIndex].ClassName;
    1: Result := Items[ItemIndex].TaskPaneClassName;
    2: Result := TadxPowerPointTaskPanesCollectionItem.ConvertPositionToDesignString(Items[ItemIndex].Position);
  else
    Result := '';
  end;
end;

{$IFDEF ADX_VCL5}
function TadxPowerPointTaskPanesCollection.Owner: TPersistent;
begin
  Result:= GetOwner;
end;
{$ENDIF}

procedure TadxPowerPointTaskPanesCollection.SetItem(Index: Integer;
  Value: TadxPowerPointTaskPanesCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TadxPowerPointTaskPane }

procedure TadxPowerPointTaskPane.AdxPPShow(AAppWindowProperty: Pointer;
  raiseEvents: boolean);
var
  adxCaption: TadxCaption;
  WishfulVisible: boolean;
  BeforeFormShowEventArgs: TadxBeforeTaskPaneShowEventArgs;
  AfterFormShowEventArgs: TadxAfterTaskPaneShowEventArgs;
begin
  Log.AddMessage('TadxPowerPointTaskPane.AdxPPShow');

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
    FWindowHandle := PAppWindowProperty(AAppWindowProperty)^.WindowHandle;

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
  end;
  except
    on E:SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('AdxPpShow: ' + E.Message), 'AdxPpShow');
    end;
  end;
end;

procedure TadxPowerPointTaskPane.ADXPPHide(raiseEvents: boolean);
var
  AfterTaskPaneHideEventArgs: TadxAfterTaskPaneHideEventArgs;
  NeedToRaiseAfterFormHideEvent: boolean;
begin
  if LockVisible then begin
    Visible := false;
  end
  else begin
    NeedToRaiseAfterFormHideEvent := self.Visible and self.Injected;
    inherited Hide;
    DisposePowerPointObjects;

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

constructor TadxPowerPointTaskPane.CreateEx(AFormsManager: TadxPowerPointTaskPanesManager;
  AItem: TadxPowerPointTaskPanesCollectionItem);
begin
  Log.AddMessage('TadxPowerPointTaskPane.CreateEx');
  try
    inherited Create(AFormsManager);
    if not (csDesigning in self.ComponentState) then begin
      FFormsManager := AFormsManager as TadxPowerPointTaskPanesManager;
      FItem := AItem as TadxPowerPointTaskPanesCollectionItem;
      FisHiddenByDeveloper := false;
    end;
  except
    on E: SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'TadxPowerPointTaskPane.CreateEx');
      raise E;
    end;
  end;
end;

destructor TadxPowerPointTaskPane.Destroy;
var
  index: integer;
begin
  Log.AddMessage('TadxPowerPointTaskPane.Destroy ');
  if not (csDesigning in self.ComponentState) then begin
    if self.Visible then
      self.Hide();

    index := TadxPowerPointTaskPanesManagerList(FItem.FFormInstances).IndexOf(self);
    TadxPowerPointTaskPanesManagerList(FItem.FFormInstances)[index] := nil;
    FItem := nil;
    FFormsManager := nil;
  end;
  Log.AddMessage('TadxPowerPointTaskPane.Destroy.inherited');
  inherited;
end;

procedure TadxPowerPointTaskPane.DisposePowerPointObjects;
begin
  //
end;

procedure TadxPowerPointTaskPane.DoADXAfterFormShow(
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

procedure TadxPowerPointTaskPane.DoADXAfterTaskPaneHide(
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

procedure TadxPowerPointTaskPane.DoADXBeforeTaskPaneShow(
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

function TadxPowerPointTaskPane.GetAddinModule: TObject;
begin
  result := nil;
  if (FFormsManager <> nil) then begin
    result := FFormsManager.Owner;
  end;
end;

function TadxPowerPointTaskPane.GetPowerPointAppObj: PowerPointApplication;
begin
  if (FFormsManager <> nil) then begin
    result := FFormsManager.PowerPointAppObj;
  end;
end;

procedure TadxPowerPointTaskPane.SetContextForm(APowerPointContextArgs: TObject; AAppWindowProperty: Pointer);
var
  Context: TPowerPointContextArgs;
begin
  Context := TPowerPointContextArgs(APowerPointContextArgs);
  FHostHandle := Context.FHostHandle;
  CopyAppWindowProperty(FAppWindowProperty, AAppWindowProperty);
end;

procedure TadxPowerPointTaskPane.DoInstanceFocused(focused: boolean);
var
  argsEnter: TadxPowerPointEnterEventArgs;
  argsExit: TadxPowerPointExitEventArgs;
begin
  try
    if focused then begin
      argsEnter:= TadxPowerPointEnterEventArgs.Create;
      try
        DoAdxEnter(argsEnter)
      finally
        if Assigned(argsEnter) then
          FreeAndNil(argsEnter);
      end;
    end
    else begin
      argsExit:= TadxPowerPointExitEventArgs.Create;
      try
        DoAdxExit(argsExit);
      finally
        if Assigned(argsExit) then
          FreeAndNil(argsExit);
      end;
    end;
  except
    on e: SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'TadxPowerPointTaskPane.DoInstanceFocused: ' + e.Message);
    end;
  end;
end;

procedure TadxPowerPointTaskPane.DoReceiveAdxPostMessageCluster(msg: TMessage);
var
  postMessageArgs: TadxPowerPointPostMessageReceivedEventArgs;
begin
  postMessageArgs:= TadxPowerPointPostMessageReceivedEventArgs.Create;
  try
    Log.AddMessage(ClassName+'.DoReceiveAdxPostMessageCluster');
    ReceiveMessageCluster(msg, postMessageArgs.wParam, postMessageArgs.lParam);
    DoAdxPostMessage(postMessageArgs);
  finally
    if Assigned(postMessageArgs) then
      FreeAndNil(postMessageArgs);
  end;
end;

procedure TadxPowerPointTaskPane.WndProc(var Msg: TMessage);
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
          TadxExceptionManager.ProcessADXXError(E, format('TadxPowerPointTaskPane.WndProc: Msg= WM_ADXCOMMAND wParam= %x lParam= %x : %s', [Msg.WParam, Msg.LParam, e.Message]));
        end;
      end;
      exit;
    end;
  end;
  inherited WndProc(Msg);
end;


function TadxPowerPointTaskPane.AdxLocalRegistryKey: string;
begin
  result := PowerPointTaskPaneManager.AdxLocalRegistryKey;
end;

function TadxPowerPointTaskPane.GetDefaultRegionState: TadxInternalRegionState;
begin
  result:= irsNormal;
  if (not IsClientLayout) and Assigned(Item) then
    result := TadxInternalRegionState(ord(Item.DefaultRegionState) + 1);
end;

class function TadxPowerPointTaskPane.GetPositionKey(
  Position: TadxPowerPointTaskPanePosition): string;
begin
  case Position of
    pUnknown: result:= 'Unknown';
    pBottom:  result:= 'Bottom';
    pRight:   result:= 'Right';
    pLeft:    result:= 'Left';
    pTop:     result:= 'Top';
  end;
end;

procedure TadxPowerPointTaskPane.GetDragLayoutParams(
  var lParams: TadxDragLayoutParams);
var
  position: TadxPowerPointTaskPanePosition;
  injectedTaskPaneSize: integer;
begin
  if (not self.Visible) then exit;
  if (not self.Item.IsDragDropAllowed) then exit;

  lParams.Disabled := not self.PowerPointTaskPaneManager.CheckAllowedDropPosition(self.Item, lParams.Layout);
  position := self.PowerPointTaskPaneManager.GetPosition(lParams.ItemType, lParams.Layout);

  injectedTaskPaneSize := GetSize(lParams.AppHandle, lParams.Layout);
  if (injectedTaskPaneSize > 0) then begin
    lParams.LayoutSize := injectedTaskPaneSize;
  end
  else begin
    lParams.LayoutSize := PowerPointTaskPaneManager.GetPositionSize(position);
  end;

end;

procedure TadxPowerPointTaskPane.SetDragForm(AItemType: TAdxItemType;
  ALayout: TadxWindowLayout);
var
  position: TadxPowerPointTaskPanePosition;
begin
  if (self.PowerPointTaskPaneManager.CheckAllowedDropPosition(self.Item, ALayout)) then begin
    position := PowerPointTaskPaneManager.GetPosition(AItemType, ALayout);
    if (self.Item.Position <> position) then begin
      LockWindowUpdate(PowerPointTaskPaneManager.FHostHandle);
      try
        self.Item.Position := position ;
        Self.Activate();
      finally
        LockWindowUpdate(0);
      end;
    end;
  end;
end;

procedure TadxPowerPointTaskPane.SetDragItems(ADragItems: TList);
begin
  if (not self.Visible) then exit;
  if (not self.Item.IsDragDropAllowed) then exit;

  InternalSetDragItems(ADragItems, dwlBottom, dpBottom);
  InternalSetDragItems(ADragItems, dwlTop, dpTop);
  InternalSetDragItems(ADragItems, dwlLeft, dpLeft);
  InternalSetDragItems(ADragItems, dwlRight, dpRight);
end;

procedure TadxPowerPointTaskPane.InternalSetDragItems(ADragItems: TList;
  dragWindowLayouts: TadxDragWindowLayout;
  AllowedDropPosition: TadxAllowedDropPosition);
var
  itemType: TadxItemType;
  ItemHandle: HWND;
  dragItem: PadxDragItemParams;
begin
  if ((Item.AllowedDropPositions * [AllowedDropPosition]) = [AllowedDropPosition]) then begin
    itemType := stPPMain;

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

function TadxPowerPointTaskPane.IsDragDropAllowed: boolean;
begin
  result := self.Item.IsDragDropAllowed;
end;

function TadxPowerPointTaskPane.IsExpandFromMinimizedState: boolean;
begin
  result := Item.RestoreFromMinimizedState;
end;

procedure TadxPowerPointTaskPane.HideByManager(UsingVisibleProperty: boolean);
begin
  ADXPPHide(true);
end;

{ TadxPowerPointTaskPanesManager }

procedure TadxPowerPointTaskPanesManager.AddCloseButtonClickMessageToReceiver;
begin
  Log.AddMessage('AddCloseButtonClickMessageToReceiver');
  if (not TadxReceiverWindow(FReceiverWindow).Exists(TRegionCloseButtonClickMessage)) then
    TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
      (TRegionCloseButtonClickMessage.Create(self.ReceiverWindowHandle, self));
end;

procedure TadxPowerPointTaskPanesManager.CheckSecondComponent(AOwner: TComponent);
var
  i: integer;
begin
  for i := 0 to AOwner.ComponentCount - 1 do begin
    if (AOwner.Components[i] is TadxPowerPointTaskPanesManager) then begin
      raise EADXException.Create(Format(adxErrorSecondComponent, [ClassName]), adxECodeCantContain, 0);
    end;
  end;
end;

function TadxPowerPointTaskPanesManager.COMAddInModule: TadxCOMAddInModule;
begin
  try
    result := Owner as TadxCOMAddInModule;
  except
    on E: SysUtils.Exception do begin
      Log.AddException('TadxPowerPointTaskPanesManager.COMAddInModule: ' + E.Message);
      result := nil;
    end;
  end;
end;

constructor TadxPowerPointTaskPanesManager.Create(AOwner: TComponent);
begin
  FState := nil;

  try
    if not (csDesigning in self.ComponentState) then begin
      Log.AddSystemInfo('Time: ' + DateTimeToStr(Now));
      Log.AddSystemInfo('Package: ' + ProductVersionAndPackage);
      Log.AddSystemInfo('ADX Version:' + adxVersion);
      Log.AddSystemInfo('ADX Extensions Version 6.1.754');
      Log.AddMessage('TadxPowerPointTaskPanesManager.Create');
    end;

    if AOwner = nil then begin
      raise EADXException.Create(Format(adxErrorCantContain, [ClassName, 'nil']), adxECodeCantContain, 0);
    end;
    if not (AOwner is TadxCOMAddInModule) then begin
      raise EADXException.Create(Format(adxErrorCantContain, [ClassName, AOwner.ClassName]), adxECodeCantContain, 0);
    end;

    CheckSecondComponent(AOwner);

    inherited Create(AOwner);

    WasFirstWindowActivateFlag := false;
    
    CreateItems();

    if not (csDesigning in self.ComponentState) then begin
      CreateState();
      SetFormsManagerSingleton();
      CreateAddinModuleEvents();
    end;
  except
    on E:SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create(E.Message), 'TadxPowerPointTaskPanesManager.Create');
    end;
  end;
end;


procedure TadxPowerPointTaskPanesManager.CreateAddinModuleEvents;
begin
  //TDebug.Assert(Owner <> nil, 'Owner <> nil');
  //TDebug.Assert(Owner is TadxCOMAddInModule, 'Owner is TadxCOMAddInModule');
  if (Owner is TadxCOMAddInModule) then begin
    FAddinModuleEvents := TadxPowerPiontAddinEvents.Create(self,
      self.Owner as TadxCOMAddInModule);
  end;
end;

procedure TadxPowerPointTaskPanesManager.CreateExceptionManager;
begin
  ExceptionManager := TADXPowerPointExceptionManager.Create;
end;

procedure TadxPowerPointTaskPanesManager.CreateHook;
begin
  FPowerPointHook := TadxWdHook.CreateEx(self.FPowerPointVersion, 0);
end;

procedure TadxPowerPointTaskPanesManager.CreateItems;
begin
  //TDebug.Assert(FItems = nil, 'FItems = nil');
  FItems := TadxPowerPointTaskPanesCollection.Create(Self, TadxPowerPointTaskPanesCollectionItem);
end;

procedure TadxPowerPointTaskPanesManager.CreateReceiverWindow;
begin
  //TDebug.Assert(FReceiverWindow = nil, 'FReceiverWindow = nil');
  FReceiverWindow := TadxReceiverWindow.CreateEx(
    Self, GlobalsPp.ADXPpReceiverWindowCaption);
  AddCloseButtonClickMessageToReceiver();
end;

procedure TadxPowerPointTaskPanesManager.CreateState;
begin
  //TDebug.Assert(FState = nil, 'FState = nil');
  FState := TadxPowerPointTaskPanesManagerState.Create;
end;

procedure TadxPowerPointTaskPanesManager.CreatePowerPointEvents;
begin
  //TDebug.Assert(FPowerPointEvents = nil, 'FPowerPointEvents = nil');
  FPowerPointEvents := TadxxPowerPointEvents.CreateEx(self);
  TadxxPowerPointEvents(FPowerPointEvents).ConnectTo(PowerPointAppObj, FPowerPointVersion);
end;

procedure TadxPowerPointTaskPanesManager.DeleteAllForms;
var
  index: integer;
begin
  Log.AddMessage('DeleteAllForms');
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

destructor TadxPowerPointTaskPanesManager.Destroy;
begin

  if not (csDesigning in self.ComponentState) then begin
    ReleaseFormsManagerSingleton;
    DisposeAddinModuleEvents;
    DisposePowerPointEvents;
    DisposeReceiverWindow;
    DisposeState;
    DisposeHook;
    DisposeExceptionManager();
  end;
  DisposeItems;
  inherited Destroy;
end;

procedure TadxPowerPointTaskPanesManager.DisposeAddinModuleEvents;
begin
  if Assigned(FAddinModuleEvents) then begin
    FAddinModuleEvents.Free;
    FAddinModuleEvents := nil;
  end;
end;

procedure TadxPowerPointTaskPanesManager.DisposeExceptionManager;
begin
  if (ExceptionManager <> nil) then begin
    ExceptionManager.Free;
    ExceptionManager := nil;
  end;
end;

procedure TadxPowerPointTaskPanesManager.DisposeHook;
begin
  if Assigned(FPowerPointHook) then begin
    FPowerPointHook.Free;
    FPowerPointHook := nil;
  end;
end;

procedure TadxPowerPointTaskPanesManager.DisposeItems;
begin
  if Assigned(FItems) then begin
    FItems.Clear;
    FItems.Free;
    FItems := nil;
  end;
end;

procedure TadxPowerPointTaskPanesManager.DisposeReceiverWindow;
begin
  if (FReceiverWindow <> nil) then begin
    TadxReceiverWindow(FReceiverWindow).Free;
    FReceiverWindow := nil;
  end;
end;

procedure TadxPowerPointTaskPanesManager.DisposeState;
begin
  if (FState <> nil) then begin
    FState.Free;
    FState := nil;
  end;
end;

procedure TadxPowerPointTaskPanesManager.DisposePowerPointEvents;
begin
  if Assigned(FPowerPointEvents) then begin
    TadxxPowerPointEvents(FPowerPointEvents).Disconnect;
    FPowerPointEvents.Free;
    FPowerPointEvents := nil;
  end;
end;

procedure TadxPowerPointTaskPanesManager.DoAddInBeginShutdown(Sender: TObject);
begin
  if (COMAddInModule.HostType <> ohaPowerPoint) then begin
    exit;
  end;

  Log.AddMessage('TadxPowerPointTaskPanesManager.DoAddInBeginShutdown');

  try
    TadxPowerPointTaskPanesManagerState(FState).isShutdown := true;
    HideAllForms();
    DeleteAllForms();
    DisposeHook();
    DisposePowerPointEvents();

    TAppWindowBehaviour.SingletonFree;
	finally
		TadxPowerPointTaskPanesManagerState(FState).isShutdown := false;
  end;
end;

procedure TadxPowerPointTaskPanesManager.DoAddInFinalize(Sender: TObject);
begin
  if (COMAddInModule.HostType <> ohaPowerPoint) then begin
    exit;
  end;

  Log.AddMessage('TadxPowerPointTaskPanesManager.DoAddInFinalize');

  adxWSbcls.APIFinalize;
end;

procedure TadxPowerPointTaskPanesManager.DoAddInInitialize(Sender: TObject);
begin
  if (COMAddInModule.HostType <> ohaPowerPoint) then begin
    exit;
  end;

  Log.AddMessage('TadxPowerPointTaskPanesManager.DoAddInInitialize');

  adxWSbcls.APIInitialize;


  CreateExceptionManager;
  TAppWindowBehaviour.SetSingleton(TPowerPointAppWindowBehaviour.Create);

  try
    TadxPowerPointTaskPanesManagerState(FState).isAddinInitialize := true;
    try
      if (PowerPointAppObj = nil) then begin
        Log.AddWarning('DoAddinInitialize.PowerPointApplication == null');
        exit;
      end;
      SetPowerPointVersion();
      LoadPositionsFromRegistry;
      DoADXInitialize;
      CreatePowerPointEvents;
      CreateReceiverWindow();
      CreateHook;

      ProcessEnableByCOMAddinsDialog;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoAddInInitialize');
      end;
    end;
  finally
    TadxPowerPointTaskPanesManagerState(FState).isAddinInitialize := false;
    TadxPowerPointTaskPanesManagerState(FState).WasAddinInitialize := true;
  end;
end;

procedure TadxPowerPointTaskPanesManager.DoAddInStartupComplete(Sender: TObject);
begin
  if (COMAddInModule.HostType <> ohaPowerPoint) then begin
    exit;
  end;

  Log.AddMessage('TadxPowerPointTaskPanesManager.DoAddInStartupComplete');
end;

procedure TadxPowerPointTaskPanesManager.DoADXInitialize;
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

procedure TadxPowerPointTaskPanesManager.DoBeforeFormInstanceCreate(
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

procedure TadxPowerPointTaskPanesManager.DoWindowActivate(
  APowerPointContextArgs: TObject);
begin
  if (not WasFirstWindowActivateFlag) then begin
    WasFirstWindowActivateFlag := true;
    DoProcessContextWindow(APowerPointContextArgs);
  end
  else begin
    if (FPowerPointVersion = v2010) then begin
      DoProcessContextWindow(APowerPointContextArgs);
    end;
  end;
end;

procedure TadxPowerPointTaskPanesManager.DoRegionCloseButtonClick(AFormHandle: HWND);
var
  Form: TadxPowerPointTaskPane;
begin
  Form := FindFormByHandle(AFormHandle);
  DoRegionCloseButtonClick(Form);
end;

procedure TadxPowerPointTaskPanesManager.DoRegionCloseButtonClick(AForm: TadxPowerPointTaskPane);
var
  Args: TadxPowerPointCloseButtonClickEventArgs;
  event: TadxEventRaising;
begin
  Args := nil;
  if Assigned(AForm) and Assigned(AForm.OnAdxCloseButtonClick) then begin
    try
      Args := TadxPowerPointCloseButtonClickEventArgs.Create;
      try
        event := TadxEventRaising.Create('OnAdxCloseButtonClick', [eoLockRegionState]);
        try
          AForm.OnAdxCloseButtonClick(AForm, Args);
        finally
          event.Free;
        end;
        if (Args.CloseTaskPane) then begin
          AForm.Hide;
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

procedure TadxPowerPointTaskPanesManager.ShowForm(AItem: TadxPowerPointTaskPanesCollectionItem;
  APowerPointContextArgs: TObject);
var
  PowerPointContextArgs: TPowerPointContextArgs;
  PropertiesIsSetToShowUpForm: boolean;

  Form: TadxPowerPointTaskPane;
  AppWindowProperty: PAppWindowProperty;
  FindWindow: boolean;
begin
  Log.AddMessage('DoShowForm');
  PowerPointContextArgs := APowerPointContextArgs as TPowerPointContextArgs;

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

      AItem.SetAppWindowProperty(PowerPointContextArgs, AppWindowProperty);
      AppWindowProperty.ReceiverHandle := ReceiverWindowHandle;
      FindWindow := AppWindowProperty.WindowHandle > 0;
      if (FindWindow) then begin
        Form := AItem.FindForm(PowerPointContextArgs.HostHandle);

        if Form = nil then begin
          Form := CreateTaskPaneInstance(AItem, PowerPointContextArgs.HostHandle);
        end;

        if (Form <> nil)
          and (not Form.Visible)
          and (not Form.FisHiddenByDeveloper)
          and (not Form.Injected) then begin
          Form.SetContextForm(PowerPointContextArgs, AppWindowProperty);
          Form.AdxPPShow(AppWindowProperty, true);
        end;
      end
      else begin
        Log.AddWarning('DoShowForm: ' + ' Window not found. '
          + Format('Handle: %x', [PowerPointContextArgs.FHostHandle])
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

procedure TadxPowerPointTaskPanesManager.ShowForms(APowerPointContextArgs: TObject);
var
  index: integer;
begin
  Log.AddMessage('DoShowForms');
  try
    for index := 0 to Items.Count - 1 do begin
      ShowForm(Items[Index], APowerPointContextArgs);
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoShowForms: ' + E.Message), 'DoShowForms');
  end;
end;

function TadxPowerPointTaskPanesManager.FindFormByHandle(
  AFormHandle: HWND): TadxPowerPointTaskPane;
var
  itemIndex: integer;
begin
  result := nil;
  for itemIndex := 0 to Items.Count - 1 do begin
      if (Items[itemIndex].TaskPaneInstance <> nil)
        and (Items[itemIndex].TaskPaneInstance.Handle = AFormHandle) then begin
        result := Items[itemIndex].TaskPaneInstance;
        exit;
      end;
  end;
end;

function TadxPowerPointTaskPanesManager.GetAdxItemType(
  Item: TadxPowerPointTaskPanesCollectionItem): TAdxItemType;
begin
  result := stPPDocument;
end;

function TadxPowerPointTaskPanesManager.GetHostHandle: HWND;
begin
  if (FPowerPointVersion < v2010) then begin
    if (FHostHandle = 0) then begin
      FHostHandle := GetAppWindowHandle(Ord(self.FPowerPointVersion), stPPMain, GetDesktopWindow());
    end;
    //TDebug.Assert(FHostHandle <> 0, 'FHostHandle <> 0');
    result := FHostHandle;
  end
  else begin
    raise Exception.Create('This PowerPoint version can have a few windows');
    result := 0;
  end;
end;

function TadxPowerPointTaskPanesManager.GetPowerPointAppObj: PowerPointApplication;
begin
  result := nil;
  if (COMAddInModule <> nil) then begin
    if (not VarIsNull(COMAddInModule.HostApp)) then begin
      IDispatch(COMAddInModule.HostApp).QueryInterface(PowerPointApplication, result);
      exit;
    end;
  end;
end;

function TadxPowerPointTaskPanesManager.GetWasAddinInitialize: boolean;
begin
  if (FState = nil) then begin
    result := false;
    exit;
  end;
  result :=  TadxPowerPointTaskPanesManagerState(FState).WasAddinInitialize;
end;

function TadxPowerPointTaskPanesManager.GetItems: TadxPowerPointTaskPanesCollection;
begin
  result := FItems;
end;

procedure TadxPowerPointTaskPanesManager.HideAllForms;
var
  index: integer;
begin
  Log.AddMessage('HideAllForms');
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

function TadxPowerPointTaskPanesManager.ReceiverWindowHandle: HWND;
begin
  if (FReceiverWindow <> nil) then begin
    result := TadxReceiverWindow(FReceiverWindow).Handle;
  end else begin
    result := 0;
  end;
end;

procedure TadxPowerPointTaskPanesManager.ReleaseFormsManagerSingleton;
begin
  FormsManagerSingleton := nil;
end;

procedure TadxPowerPointTaskPanesManager.SetPowerPointVersion;
var
  hostVersion: string;
begin
  FPowerPointVersion := vUnknown;

  if COMAddinModule = nil then begin
    Log.AddWarning('SetPowerPointVersion: COMAddinModule = nil');
    exit;
  end;

  if PowerPointAppObj <> nil then begin
    hostVersion := PowerPointAppObj.Version;
    Log.AddSystemInfo('PowerPoint version: ' + hostVersion);
  end
  else begin
    Log.AddWarning('SetPowerPointVersion: PowerPointAppObj = nil');
    exit;
  end;

  if (Pos('9.0', hostVersion) > 0) then
      FPowerPointVersion := v2000;

  if (Pos('10.0', hostVersion) > 0) then
      FPowerPointVersion := v2002;

  if (Pos('11.0', hostVersion) > 0) then
      FPowerPointVersion := v2003;

  if (Pos('12.0', hostVersion) > 0) then
      FPowerPointVersion := v2007;

  if (Pos('14.0', hostVersion) > 0) then
      FPowerPointVersion := v2010;

  if FPowerPointVersion = vUnknown then
    raise EAbort.Create('SetPowerPointVersion: PowerPoint version is not defined.')

end;

procedure TadxPowerPointTaskPanesManager.SetFormsManagerSingleton;
begin
  FormsManagerSingleton := self;
end;

procedure TadxPowerPointTaskPanesManager.SetItems(const Value: TadxPowerPointTaskPanesCollection);
begin
  FItems := Value;
end;


{ TAddinEvents }

procedure TadxPowerPiontAddinEvents.Connect;
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

constructor TadxPowerPiontAddinEvents.Create(AFormsManager: TadxPowerPointTaskPanesManager; ACOMAddInModule: TadxCOMAddInModule);
begin
  FFormsManager := AFormsManager;
  FCOMAddInModule := ACOMAddInModule;
  Connect;
end;

destructor TadxPowerPiontAddinEvents.Destroy;
begin
  Disconnect;
  inherited;
end;

procedure TadxPowerPiontAddinEvents.Disconnect;
begin
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

procedure TadxPowerPiontAddinEvents.OnAddInBeginShutdown(Sender: TObject);
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

procedure TadxPowerPiontAddinEvents.OnAddInFinalize(Sender: TObject);
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

procedure TadxPowerPiontAddinEvents.OnAddInInitialize(Sender: TObject);
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

procedure TadxPowerPiontAddinEvents.OnAddInStartupComplete(Sender: TObject);
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

procedure TadxPowerPointTaskPanesManager.TryShow(Form: TadxPowerPointTaskPane);
var
  ContextArgs: TPowerPointContextArgs;
begin
  if not Form.Visible then begin
    ContextArgs := TPowerPointContextArgs.Create(self);
    try
      ShowForm(Form.Item, ContextArgs);
    finally
      ContextArgs.Free;
    end;
  end;
end;

function TadxPowerPointTaskPanesManager.AdxLocalRegistryKey: string;
begin
  if (Owner <> nil) then begin
    result := (Owner as TadxCOMAddInModule).RegistryKey + '\' + Globals.ADXPPForm;
  end
  else begin
    result := '';
  end;
end;

function TadxPowerPointTaskPanesManager.AdxRegistryKey: string;
var
  Reg: TRegistry;
begin
  Result:= '\Software\Microsoft\Office\PowerPoint\AddIns\' + Globals.ADXPPForm + '\';
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey(Result, true);
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function TadxPowerPointTaskPanesManager.CheckAllowedDropPosition(
  Item: TadxPowerPointTaskPanesCollectionItem;
  WindowLayout: TadxWindowLayout): boolean;
begin
  result := false;

  if (CompareAllowedDropPositionsAndWindowLayout(Item, WindowLayout, dpBottom)) then result := true;
  if (CompareAllowedDropPositionsAndWindowLayout(Item, WindowLayout, dpLeft)) then result :=  true;
  if (CompareAllowedDropPositionsAndWindowLayout(Item, WindowLayout, dpRight)) then result :=  true;
  if (CompareAllowedDropPositionsAndWindowLayout(Item, WindowLayout, dpTop)) then result :=  true;
end;

function TadxPowerPointTaskPanesManager.CompareAllowedDropPositionsAndWindowLayout(
  Item: TadxPowerpointTaskPanesCollectionItem;
  WindowLayout: TadxWindowLayout;
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

function TadxPowerPointTaskPanesManager.ConvertPositionToAllowedDropPosition(
  Position: TadxPowerPointTaskPanePosition): TadxAllowedDropPosition;
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

function TadxPowerPointTaskPanesManager.GetADXWindowLayout(
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

function TadxPowerPointTaskPanesManager.GetPosition(ItemType: TadxItemType;
  WindowLayout: TadxWindowLayout): TadxPowerPointTaskPanePosition;
begin
  result := pUnknown;

  case ItemType of
    stPPMain:
      case WindowLayout of
        wlBottom: result := pBottom;
        wlLeft: result := pLeft;
        wlRight: result := pRight;
        wlTop: result := pTop;
      end;
     else
       raise SysUtils.Exception.Create('GetPosition: The TadxPowerPointTaskPanePosition is not found.');
  end;
end;

function TadxPowerPointTaskPanesManager.GetPositionSize(
  Position: TadxPowerPointTaskPanePosition): integer;
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
      keyValue := TadxPowerPointTaskPane.GetPositionKey(Position);
      if Reg.ValueExists(KeyValue + '_Size') then begin
        result := Reg.ReadInteger(KeyValue + '_Size');
      end;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure TadxPowerPointTaskPanesManager.LoadPositionsFromRegistry;
var
  i: integer;
begin
  for i := 0 to Items.Count - 1 do begin
    Items[i].LoadPositionFromRegistry;
  end;
end;

procedure TadxPowerPointTaskPanesManager.ProcessEnableByCOMAddinsDialog;
var
  Context: TPowerPointContextArgs;

begin
  Context := nil;
  try
    Context := TPowerPointContextArgs.Create(self);
    DoWindowActivate(Context);
  finally
    if Assigned(Context) then begin
      Context.Free;
    end;
  end;
end;

procedure TadxPowerPointTaskPanesManager.DoProcessContextWindow(
  APowerPointContextArgs: TObject);
var
  Context: TPowerPointContextArgs;
begin
  Log.AddMessage('DoProcessContextWindow');
  DeleteFormsForNotVisibleHostHandle();

  Context := TPowerPointContextArgs(APowerPointContextArgs);
  try
    LockWindowUpdate(Context.FHostHandle);
    ShowForms(Context);
  finally
    LockWindowUpdate(0);
  end;
end;

function TadxPowerPointTaskPanesManager.WindowClassName: string;
begin
  case FPowerPointVersion of
    v2000: result := 'PP9FrameClass';
    v2002: result := 'PP10FrameClass';
    v2003: result := 'PP11FrameClass';
    v2007: result := 'PP12FrameClass';
    v2010: result := 'PPTFrameClass';
    else
      raise Exception.Create(' TadxPowerPointTaskPanesManager.WindowClassName: Unknown PowerPoint version.');
  end;
end;

procedure TadxPowerPointTaskPanesManager.DeleteFormsForNotVisibleHostHandle;
var
  index: integer;
begin
  Log.AddMessage('DeleteFormsForNotVisibleHostHandle');
  try
    for index := 0 to Items.Count - 1 do begin
      Items[index].DeleteFormsForNotVisibleHostHandle;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DeleteFormsForNotVisibleHostHandle: ' + E.Message), 'DeleteFormsForNotVisibleHostHandle');
  end;
end;

procedure TadxPowerPointTaskPanesManager.DoProtectedWindowActivate(
  APowerPointContextArgs: TObject);
begin
  DoProcessContextWindow(APowerPointContextArgs);
end;

{ TadxPowerPointTaskPanesManagerState }

constructor TadxPowerPointTaskPanesManagerState.Create;
begin
  Restore;
end;

procedure TadxPowerPointTaskPanesManagerState.Restore;
begin
	isShutdown := false;
	WasAddinInitialize := false;
	isAddinInitialize := false;
end;

{ TPowerPointContextArgs }

constructor TPowerPointContextArgs.Create(AFormsManager: TadxPowerPointTaskPanesManager);
begin
  inherited Create;
  FHostHandle := 0;
  FPresentation := nil;
  FWindow := nil;
  FFormsManager := AFormsManager;
  FPowerPointApplication := AFormsManager.PowerPointAppObj;
  FProtectedWindow := nil;
  InitializeActiveContext;
end;

constructor TPowerPointContextArgs.Create(
  AFormsManager: TadxPowerPointTaskPanesManager;
  AProtectedWindow: IDispatch);
begin
  inherited Create;
  FHostHandle := 0;
  FPresentation := nil;
  FWindow := nil;
  FFormsManager := AFormsManager;
  FPowerPointApplication := AFormsManager.PowerPointAppObj;
  FProtectedWindow := AProtectedWindow;
  InitializeActiveContext;
end;

destructor TPowerPointContextArgs.Destroy;
begin
  FHostHandle := 0;
  FPresentation := nil;
  FWindow := nil;
  FFormsManager := nil;
  FPowerPointApplication := nil;
  inherited;
end;

function TPowerPointContextArgs.GetHostHandle: HWND;
begin
  result := FHostHandle;
end;

function TPowerPointContextArgs.GetIsValidForTaskPaneCreating: boolean;
begin
  result := self.HostHandle <> 0;
end;

function TPowerPointContextArgs.GetPowerPointVersion: integer;
begin
  result := FFormsManager.FPowerPointVersion; 
end;

procedure TPowerPointContextArgs.InitializeActiveContext;
begin
  try
    self.FPresentation := FPowerPointApplication.ActivePresentation;
  except
    self.FPresentation := nil;
    //TDebug.Assert(true, 'TPowerPointContextArgs.InitializeActiveContext.ActivePresentation')
  end;
  try
    self.FWindow := FPowerPointApplication.ActiveWindow;
  except
    self.FWindow := nil;
    //TDebug.Assert(true, 'TPowerPointContextArgs.InitializeActiveContext.ActiveWindow')
  end;
  if (PowerPointVersion < v2010) then begin
    self.FHostHandle := FFormsManager.HostHandle;
  end
  else begin
    SetHostHandleFromActiveWindow;
    if (self.FHostHandle = 0) and (self.FProtectedWindow <> nil) then begin
      try
        SetHostHandleFromMainWindow(Variant(self.FProtectedWindow).Caption);
      except
        on E: SysUtils.Exception do begin
          Log.AddException('TPowerPointContextArgs.InitializeActiveContext.FProtectedWindow: ' + E.Message);
        end;
      end;
    end;
    if (self.FHostHandle = 0) and (self.FWindow <> nil) then begin
      SetHostHandleFromMainWindow(self.FWindow.Caption);
    end;
  end;
end;


procedure TPowerPointContextArgs.SetHostHandleFromActiveWindow;
begin
  self.FHostHandle := APIUtils.GetActiveWindow(FFormsManager.WindowClassName);
  if (self.FHostHandle = 0) then begin
    Log.AddMessage('ActiveWindow is not PowerPoint');
    self.FHostHandle := GetAppWindowHandle(Ord(PowerPointVersion), stPPMain, GetDesktopWindow());
  end;
  Log.AddMessage(' TPowerPointContextArgs.SetHostHandleFromActiveWindow: ' + IntToHex(self.FHostHandle, 8));
end;

procedure TPowerPointContextArgs.SetHostHandleFromMainWindow(
  WindowName: string);
var
  handle: HWND;
begin
  handle := FindMainWindowInProcess(GetDesktopWindow(), WindowName, PowerPointWindowClass(FFormsManager.FPowerPointVersion), false);
  if (handle <> 0) then begin
    self.FHostHandle := handle;
  end;
end;

{ TadxPowerPointTaskPanesManagerList }

procedure TadxPowerPointTaskPanesManagerList.Clear;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    TObject(Items[i]).Free;
  inherited;
end;

function TadxPowerPointTaskPanesManagerList.CountClasses(AClassType: TClass): integer;
var
  i: integer;
begin
  result := 0;
  for i := 0 to Count - 1 do begin
    if TObject(Items[i]) is AClassType then
      Inc(result);
  end;
end;

constructor TadxPowerPointTaskPanesManagerList.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor TadxPowerPointTaskPanesManagerList.Destroy;
begin
  FOwner := nil;
  inherited;
end;

{ GlobalsPp }

class function GlobalsPp.ADXPpReceiverWindowCaption: string;
begin
  result := 'ADXPpReceiverWindowCaption';
end;

procedure TadxPowerPointTaskPanesCollectionItem.SetAlwaysShowHeader(
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

procedure TadxPowerPointTaskPanesCollectionItem.SetCloseButton(
  const Value: boolean);
begin
  if FCloseButton <> Value then begin
    FCloseButton := Value;
    if (FCloseButton) then begin
      self.AlwaysShowHeader := true;
    end;
  end;
end;

{ TADXPowerPointExceptionManager }

procedure TADXPowerPointExceptionManager.InternalProcessADXXError(err: Exception; whereHappened: string);
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

procedure TadxPowerPointTaskPane.DoAdxEnter(args: TadxPowerPointEnterEventArgs);
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

procedure TadxPowerPointTaskPane.DoAdxExit(args: TadxPowerPointExitEventArgs);
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

procedure TadxPowerPointTaskPane.DoAdxPostMessage(args: TadxPowerPointPostMessageReceivedEventArgs);
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

function TadxPowerPointTaskPane.GetPowerPointApp: TPowerPointApplication;
begin
  result := nil;
  if (FFormsManager <> nil) and (FFormsManager.Owner <> nil) then begin
    if (FFormsManager.Owner is TadxCOMAddInModule) then begin
      result := (FFormsManager.Owner as TadxCOMAddInModule).PowerPointApp;
    end;
  end;
end;

procedure TadxPowerPointTaskPane.Hide;
begin
  if not (csDesigning in self.ComponentState) then begin
    FisHiddenByDeveloper := true;
    ADXPPHide(true);
  end
  else begin
    inherited Hide;
  end;
end;

procedure TadxPowerPointTaskPane.Show;
begin
  if not (csDesigning in self.ComponentState) then begin
    self.FisHiddenByDeveloper := false;
    if LockVisible then begin
      Visible := true;
    end
    else begin
      PowerPointTaskPaneManager.TryShow(self);
    end;
  end
  else begin
    inherited Show;
  end;
end;

function TadxPowerPointTaskPane.AdxLayoutKey: string;
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

function TadxPowerPointTaskPane.AdxRegistryKey: string;
begin
  Result:= PowerPointTaskPaneManager.AdxRegistryKey;
end;

function TadxPowerPointTaskPane.RegistryKey: string;
begin
  if (Owner = nil) then begin
    TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxPowerPointTaskPane.RegistryKey: Cannot return a RegistryKey. Owner is nil.'), 'RegistryKey');
  end;
  if not (Owner is TadxPowerPointTaskPanesManager) then begin
    TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxPowerPointTaskPane.RegistrPostMessagereturn a RegistryKey. Owner is not TadxPowerPointTaskPaneManager.'), 'RegistryKey');
  end;
  result := TadxPowerPointTaskPanesManager(Owner).COMAddInModule.RegistryKey;
end;

procedure TadxPowerPointTaskPane.ADXPostMessage(wParam, lParam: Cardinal);
begin
  SendMessageCluster(Handle, wParam, lParam);
end;

procedure TadxPowerPointTaskPanesCollectionItem.HideAllNotInjectedForms;
var
  index: integer;
begin
  Log.AddMessage('TadxPowerPointTaskPanesCollectionItem.HideAllNotInjectedForms');
  for index := 0 to TadxPowerPointTaskPanesManagerList(FFormInstances).Count - 1 do begin
    if TadxPowerPointTaskPanesManagerList(FFormInstances)[index] <> nil then begin
      if TadxPowerPointTaskPane(TadxPowerPointTaskPanesManagerList(FFormInstances)[index]).Visible
        and (not TadxPowerPointTaskPane(TadxPowerPointTaskPanesManagerList(FFormInstances)[index]).Injected) then begin
        TadxPowerPointTaskPane(TadxPowerPointTaskPanesManagerList(FFormInstances)[index]).ADXPPHide(true);
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
  AFormsManager: TadxPowerPointTaskPanesManager);
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

{ TadxPowerPointCloseButtonClickEventArgs }

constructor TadxPowerPointCloseButtonClickEventArgs.Create;
begin
  inherited;
  FCloseTaskPane := true;
  FDisableItem := false;
end;

procedure TadxPowerPointCloseButtonClickEventArgs.SetCloseTaskPane(const Value: boolean);
begin
  FCloseTaskPane := Value;
end;

procedure TadxPowerPointCloseButtonClickEventArgs.SetDisableItem(
  const Value: boolean);
begin
  FDisableItem := Value;
end;

procedure TadxPowerPointTaskPane.UpdateAppWindowPropertyAfterBeforeFormShowEvent(
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


function TadxPowerPointTaskPane.UseOfficeThemeBackColor: boolean;
begin
  if Assigned(self.Item) then
    result:= self.Item.UseOfficeThemeForBackground
  else
    result:= false;
end;

{ TadxxPowerPointEvents }

procedure TadxxPowerPointEvents.InitServerData;
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

procedure TadxxPowerPointEvents.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf as MSPpt2000._Application;
  ConnectEvents(FIntf);
end;

procedure TadxxPowerPointEvents.ConnectTo(AIntf: IDispatch; AVersion: integer);
const
  EventIID: TGUID = '{914934C2-5A91-11CF-8700-00AA0060263B}';
begin
  ServerData^.EventIID := EventIID;
  ConnectTo(AIntf);
end;

constructor TadxxPowerPointEvents.CreateEx(AFormsManager: TadxPowerPointTaskPanesManager);
begin
  inherited Create(nil);
  FFormsManager := AFormsManager;
end;

procedure TadxxPowerPointEvents.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TadxxPowerPointEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;
    2009: OnWindowActivate(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation,
      IUnknown(TVarData(Params[1]).VPointer) as DocumentWindow);
    2029: OnProtectedViewWindowActivate(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
  end;
end;

procedure TadxxPowerPointEvents.OnWindowActivate(ASender: TObject;
  const Presentation: _Presentation; const Window: MSPpt2000.DocumentWindow);
var
  Context: TPowerPointContextArgs;
begin
  Context := TPowerPointContextArgs.Create(self.FFormsManager);
  try
    FFormsManager.DoWindowActivate(Context);
  finally
    Context.Free;
  end;
end;

//class function GlobalsPp.PowerPointWindowClassName: string;
//begin
//  result := 'OpusApp';
//end;

function TadxPowerPointTaskPanesManager.CreateTaskPaneInstance(
  AItem: TadxPowerPointTaskPanesCollectionItem;
  HostHandle: HWND): TadxPowerPointTaskPane;
var
  Args: TadxBeforeTaskPaneInstanceCreateEventArgs;
  taskPane: TadxPowerPointTaskPane;
begin
  taskPane := nil;
  Args := TadxBeforeTaskPaneInstanceCreateEventArgs.Create(AItem, false);
  try
    DoBeforeFormInstanceCreate(Args);
    if (not Args.Cancel) then begin
      taskPane := AItem.CreateTaskPane;

      if (taskPane <> nil) then begin
        taskPane.FHostHandle := HostHandle;
      end;
    end;
  finally
    if Assigned(Args) then begin
      Args.Free;
    end;
  end;

  result := taskPane;
end;

procedure TadxPowerPointTaskPanesCollectionItem.ShowTaskPane;
var
  context: TPowerPointContextArgs;
  taskPane: TadxPowerPointTaskPane;
begin
  Log.AddMessage('TadxPowerPointTaskPanesCollectionItem.ShowTaskPane');
  try
    context := TPowerPointContextArgs.Create(self.FormsManager);
    try
      taskPane := self.FindForm(context.HostHandle);
      if (taskPane <> nil) then begin
        taskPane.MarkHiddenByDeveloper(false);
      end;
      self.FormsManager.ShowForm(self, context);
    finally
      context.Free;
    end;
  except
    on E: SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'ShowTaskPane');
    end;
  end;
end;

procedure TadxPowerPointTaskPane.MarkHiddenByDeveloper(value: boolean);
begin
  FisHiddenByDeveloper := value;
end;

function TadxPowerPointTaskPane.GetCurrentPowerPointWindowHandle: HWND;
begin
  result := self.FHostHandle;
end;

procedure TadxxPowerPointEvents.OnProtectedViewWindowActivate(
  ASender: TObject; const PvWindow: IDispatch);
var
  Context: TPowerPointContextArgs;
begin
  Context := TPowerPointContextArgs.Create(self.FFormsManager, PvWindow);
  try
    FFormsManager.DoProtectedWindowActivate(Context);
  finally
    Context.Free;
  end;
end;

{ TPowerPointAppWindowBehaviour }

procedure TPowerPointAppWindowBehaviour.WM_DESTROY(hWnd: THandle;
  Msg: UINT; wParam, lParam: Integer; appWindow: TAppWindow);
var
  awpWindowHandle, awpHostHandle: THandle;
begin
  Log.AddMessage('TPowerPointAppWindowBehaviour.WM_DESTROY');
  awpWindowHandle := PAppWindowProperty(appWindow.AppWindowProperty)^.WindowHandle;
  awpHostHandle := PAppWindowProperty(appWindow.AppWindowProperty)^.HostHandle;
  Windows.LockWindowUpdate(awpHostHandle);
  try
    TAppWindowBehaviour.HideAllFormsInAllAddins(awpWindowHandle);
  finally
    Windows.LockWindowUpdate(0);
  end;
end;

initialization
  FormsManagerSingleton := nil;


finalization

end.
