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

unit adxxlFormsManager;

{$I adxolDefs.inc}

interface

uses
  SysUtils, Classes, Dialogs, ComObj, OleCtrls, Forms, StdCtrls,
  {$IFNDEF ADX_VCL5}Variants,{$ENDIF}
  {$IFDEF ADX_VCL5}OleServer, FileCtrl,{$ENDIF}
  Windows, Messages, Graphics, Controls, ComCtrls, ExtCtrls, ToolWin,
  Buttons, Menus, TypInfo,
  Office2000, Excel2000,
  adxAddin, adxWSbcls, adxCore;

type

  TadxExcelVersion = integer;

  TadxExcelTaskPaneClassName = string;

  TadxExcelSplitter = (
    sbNone,
    sbStandard
  );

  TadxExcelTaskPanePosition = (
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

  TadxExcelCloseButtonClickEventArgs = class
  private
    FCloseForm: boolean;
    FDisableItem: boolean;
    procedure SetCloseForm(const Value: boolean);
    procedure SetDisableItem(const Value: boolean);
  public
    constructor Create;
    property CloseForm: boolean read FCloseForm write SetCloseForm;
    property DisableItem: boolean read FDisableItem write SetDisableItem;
  end;


  TadxExcelCloseButtonClickEventHandler = procedure(Sender: TObject; Args: TadxExcelCloseButtonClickEventArgs) of object;

  TadxExcelEnterEventArgs = class
  end;

  TadxExcelExitEventArgs = class
  end;

  TadxExcelFormEnterEventHandler = procedure(Sender: TObject; Args: TadxExcelEnterEventArgs) of object;
  TadxExcelFormExitEventHandler = procedure(Sender: TObject; Args: TadxExcelExitEventArgs) of object;

  TadxExcelPostMessageReceivedEventArgs = class
  public
    wParam: Cardinal;
    lParam: Cardinal;
  end;

  TadxExcelPostMessageReceivedEventHandler = procedure(Args: TadxExcelPostMessageReceivedEventArgs) of object;

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

  TadxBeforeCellEditEventArgs = class
  public
    constructor Create();
    destructor Destroy; override;
  end;

  TadxBeforeCellEditEventHandler = procedure(ASender: TObject; Args: TadxBeforeCellEditEventArgs) of object;

  TadxAfterCellEditEventArgs = class
  public
    constructor Create();
    destructor Destroy; override;
  end;

  TadxAfterCellEditEventHandler = procedure(ASender: TObject; Args: TadxAfterCellEditEventArgs) of object;

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
  TadxKeyFilterEventArgs = class
  private
    FAdxKeyInfo: TadxKeyInfo;
    FAction: TadxKeyFilterAction;
    function GetKeyCode: byte;
    function GetKeyValue: Cardinal;
    function GetPressed: boolean;
    function GetShiftState: TShiftState;
  public
    constructor Create(AAdxKeyInfo: TadxKeyInfo);
    destructor Destroy; override;
    property ShiftState: TShiftState read GetShiftState;
    property Pressed: boolean read GetPressed;
    property KeyCode: byte read GetKeyCode;
    property KeyValue: Cardinal read GetKeyValue;
    property Action: TadxKeyFilterAction read FAction write FAction;
  end;

  TadxKeyFilterEventHandler = procedure(ASender: TObject; Args: TadxKeyFilterEventArgs) of object;

  TadxExcelTaskPanesCollectionItem = class;

  TadxBeforeTaskPaneInstanceCreateEventArgs = class
  private
    FItem: TadxExcelTaskPanesCollectionItem;
    FCancel: boolean;
  public
    constructor Create(AItem: TadxExcelTaskPanesCollectionItem; ADefaultCancel: boolean); overload;
    destructor Destroy; override;
    property Item: TadxExcelTaskPanesCollectionItem read FItem;
    property Cancel: boolean read FCancel write FCancel;
  end;

  TadxBeforeTaskPaneInstanceCreateEventHandler = procedure(ASender: TObject;
    Args: TadxBeforeTaskPaneInstanceCreateEventArgs) of object;


  TadxExcelTaskPanesCollection = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TadxExcelTaskPanesCollectionItem;
    procedure SetItem(Index: Integer; Value: TadxExcelTaskPanesCollectionItem);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
  public
    {$IFDEF ADX_VCL5}
    function Owner: TPersistent;
    {$ENDIF}
    function Add: TadxExcelTaskPanesCollectionItem; overload;
    property Items[Index: Integer]: TadxExcelTaskPanesCollectionItem read GetItem write SetItem; default;
  end;

  TadxExcelTaskPanesManager = class;
  TadxExcelTaskPane = class(TadxXLCustomForm)
  private
    FFormsManager: TadxExcelTaskPanesManager;
    FItem: TadxExcelTaskPanesCollectionItem;

    FWindowHandle: HWND;

    FOnADXBeforeFormShow: TadxBeforeTaskPaneShowEventHandler;
    FOnADXAfterFormShow: TadxAfterTaskPaneShowEventHandler;
    FOnADXBeforeCellEdit: TadxBeforeCellEditEventHandler;
    FOnADXAfterCellEdit: TadxAfterCellEditEventHandler;
    FOnADXKeyFilter: TadxKeyFilterEventHandler;

    FOnADXCloseButtonClick: TadxExcelCloseButtonClickEventHandler;
    FOnADXEnter: TadxExcelFormEnterEventHandler;
    FOnADXExit: TadxExcelFormExitEventHandler;
    FOnADXPostMessage: TadxExcelPostMessageReceivedEventHandler;
    FOnADXAfterTaskPaneHide: TadxAfterTaskPaneHideEventHandler;

    function GetAddinModule: TObject;
    function GetExcelAppObj: ExcelApplication;

    procedure UpdateAppWindowPropertyAfterBeforeFormShowEvent(AAppWindowProperty: Pointer);
    procedure AdxXlShow(AAppWindowProperty: Pointer; raiseEvents: boolean);
    procedure ADXXlHide(raiseEvents: boolean);
    procedure DisposeExcelObjects;

    procedure DoBeforeCellEdit(Args: TadxBeforeCellEditEventArgs);
    procedure DoAfterCellEdit(Args: TadxAfterCellEditEventArgs);
    procedure DoADXBeforeTaskPaneShow(Args: TadxBeforeTaskPaneShowEventArgs);
    procedure DoADXAfterTaskPaneHide(args: TadxAfterTaskPaneHideEventArgs);
    procedure DoADXAfterFormShow(Args: TadxAfterTaskPaneShowEventArgs);
    procedure DoADXKeyFilter(Args: TadxKeyFilterEventArgs);

    procedure InitializeForm(AExcelContextArgs: TObject; AAppWindowProperty: Pointer);
    function GetExcelApp: TExcelApplication;

    procedure DoAdxEnter(args: TadxExcelEnterEventArgs);
    procedure DoAdxExit(args: TadxExcelExitEventArgs);
    procedure DoAdxPostMessage(args: TadxExcelPostMessageReceivedEventArgs);

    procedure DoReceiveAdxPostMessageCluster(msg: TMessage);
    class function GetPositionKey(Position: TadxExcelTaskPanePosition): string;

    procedure InternalSetDragItems(ADragItems: TList; dragWindowLayouts: TadxDragWindowLayout; AllowedDropPosition: TadxAllowedDropPosition);

  protected
    procedure HideByManager(UsingVisibleProperty: boolean); override;

    function  AdxRegistryKey: string; override;
    function  AdxLayoutKey: string; override;
    function  RegistryKey: string; override;
    function  AdxLocalRegistryKey: string; override;
    function  GetDefaultRegionState: TadxInternalRegionState; override;
    procedure DoInstanceFocused(focused: boolean); override;

    procedure SetDragItems(ADragItems: TList); override;
    procedure GetDragLayoutParams(var lParams: TadxDragLayoutParams); override;
    procedure SetDragForm(AItemType: TAdxItemType; ALayout: TadxWindowLayout); override;

    function  IsDragDropAllowed: boolean; override;
    function  IsExpandFromMinimizedState: boolean; override;
    function  UseOfficeThemeBackColor: boolean; override;

    procedure WndProc(var Msg: TMessage); override;

  public
    constructor CreateEx(AFormsManager: TadxExcelTaskPanesManager; AItem: TadxExcelTaskPanesCollectionItem); virtual;
    destructor Destroy; override;

    procedure Hide; override;
    procedure Show; override;
    procedure ADXPostMessage(wParam, lParam: Cardinal);

    property ExcelAppObj: ExcelApplication read GetExcelAppObj;
    property ExcelApp: TExcelApplication read GetExcelApp;
    property ExcelTaskPaneManager: TadxExcelTaskPanesManager read FFormsManager;
    property AddinModule: TObject read GetAddinModule;
    property Item: TadxExcelTaskPanesCollectionItem read FItem;

  published
    property OnADXBeforeTaskPaneShow: TadxBeforeTaskPaneShowEventHandler read FOnADXBeforeFormShow write FOnADXBeforeFormShow;
    property OnADXAfterTaskPaneShow: TadxAfterTaskPaneShowEventHandler read FOnADXAfterFormShow write FOnADXAfterFormShow;
    property OnADXBeforeCellEdit: TadxBeforeCellEditEventHandler read FOnADXBeforeCellEdit write FOnADXBeforeCellEdit;
    property OnADXAfterCellEdit: TadxAfterCellEditEventHandler read FOnADXAfterCellEdit write FOnADXAfterCellEdit;
    property OnADXKeyFilter: TadxKeyFilterEventHandler read FOnADXKeyFilter write FOnADXKeyFilter;
    property OnADXCloseButtonClick: TadxExcelCloseButtonClickEventHandler read FOnADXCloseButtonClick write FOnADXCloseButtonClick;

    property OnADXEnter: TadxExcelFormEnterEventHandler read FOnADXEnter write FOnADXEnter;
    property OnADXExit: TadxExcelFormExitEventHandler read FOnADXExit write FOnADXExit;
    property OnADXPostMessageReceived: TadxExcelPostMessageReceivedEventHandler read FOnADXPostMessage write FOnADXPostMessage;
    property OnADXAfterTaskPaneHide: TadxAfterTaskPaneHideEventHandler read FOnADXAfterTaskPaneHide write FOnADXAfterTaskPaneHide;
  end;

  TadxExcelTaskPanesManager = class(TComponent)
  private
    hMessageMutex:  THandle;
    FReceiverWindow: Pointer;

    FState: TObject;
    FHostHandle: HWND;
    FExcelHook: TadxXLHook;

    FExcelVersion: integer;
    FItems: TadxExcelTaskPanesCollection;
    FAddinModuleEvents: TObject; //TAddinEvents

    FOnADXInitialize: TadxInitializeEventHandler;
    FOnADXBeforeFormInstanceCreate: TadxBeforeTaskPaneInstanceCreateEventHandler;
    FOnADXError: TadxErrorEventHandler;

    procedure AddCloseButtonClickMessageToReceiver();

    procedure CreateMutexes;
    procedure DeleteMutexes;

    procedure HideAllForms();
    procedure DeleteAllForms();

    procedure SetExcelVersion;
    procedure AddinsToLog;

    function GetItems: TadxExcelTaskPanesCollection;
    procedure SetItems(const Value: TadxExcelTaskPanesCollection);
    function COMAddInModule: TadxCOMAddInModule;
    function CheckHostVisible: boolean;
    function ReceiverWindowHandle: HWND;

    function GetExcelAppObj: ExcelApplication;

    function FindFormByHandle(AFormHandle: HWND): TadxExcelTaskPane;
    procedure DoRegionCloseButtonClick(AFormHandle: HWND); overload;
    procedure DoRegionCloseButtonClick(AForm: TadxExcelTaskPane); overload;


    procedure DoAddInBeginShutdown(Sender: TObject);
    procedure DoAddInFinalize(Sender: TObject);
    procedure DoAddInInitialize(Sender: TObject);
    procedure DoAddInStartupComplete(Sender: TObject);

    procedure DoADXInitialize(Args: TadxInitializeEventArgs);
    procedure DoBeforeFormInstanceCreate(Args: TadxBeforeTaskPaneInstanceCreateEventArgs);

    procedure DoBeforeCellEdit;
    procedure DoAfterCellEdit;
    procedure TryShow(Form: TadxExcelTaskPane);

    procedure DoShowForm(AItem: TadxExcelTaskPanesCollectionItem; AExcelContextArgs: TObject);
    function GetAdxItemType(Item: TadxExcelTaskPanesCollectionItem): TAdxItemType;
    function  AdxRegistryKey: string;
    function  AdxLocalRegistryKey: string;
    function ConvertPositionToAllowedDropPosition(Position: TadxExcelTaskPanePosition): TadxAllowedDropPosition;
    procedure LoadPositionsFromRegistry;
    function CheckAllowedDropPosition(Item: TadxExcelTaskPanesCollectionItem; WindowLayout: TadxWindowLayout): boolean;
    function CompareAllowedDropPositionsAndWindowLayout(Item: TadxExcelTaskPanesCollectionItem; WindowLayout: TadxWindowLayout; AllowedDropPosition: TadxAllowedDropPosition): boolean;
    function GetPosition(ItemType: TadxItemType; WindowLayout: TadxWindowLayout): TadxExcelTaskPanePosition;
    function GetPositionSize(Position: TadxExcelTaskPanePosition): integer;
    function GetADXWindowLayout(AllowedDropPosition: TadxAllowedDropPosition): TadxWindowLayout;
    function GetWasAddinInitialize: boolean;
    property WasAddinInitialize: boolean read GetWasAddinInitialize;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property ExcelAppObj: ExcelApplication read GetExcelAppObj;
  published
    property Items: TadxExcelTaskPanesCollection read GetItems write SetItems;

    property OnADXInitialize: TadxInitializeEventHandler read FOnADXInitialize write FOnADXInitialize;
    property OnADXBeforeTaskPaneInstanceCreate: TadxBeforeTaskPaneInstanceCreateEventHandler
      read FOnADXBeforeFormInstanceCreate write FOnADXBeforeFormInstanceCreate;
    property OnADXError: TadxErrorEventHandler  read FOnADXError write FOnADXError;
  end;

  TadxExcelTaskPanesCollectionItem = class(TCollectionItem)
  private
    FDefaultRegionState: TadxRegionState;
    FFormInstances: TObject;//TadxXlFormsManagerList;
    FLayout: TadxExcelTaskPanePosition;
    FEnabled: boolean;
    FSplitter: TadxExcelSplitter;
    FFormClassName: TadxExcelTaskPaneClassName;
    FTag: Longint;
    FCloseButton: boolean;
    FAlwaysShowHeader: boolean;
    FRestoreFromMinimizedState: boolean;
    FAllowedDropPositions: TadxAllowedDropPositions;
    FIsDragDropAllowed: boolean;
    FIsHiddenStateAllowed : boolean;
    FRegionBorder: TadxRegionBorderStyle;
    FUseOfficeThemeForBackground: boolean;
    procedure SetPosition(const Value: TadxExcelTaskPanePosition);
    procedure SetEnabled(const Value: boolean);
    procedure SetSplitter(const Value: TadxExcelSplitter);
    procedure SetFormClassName(const Value: TadxExcelTaskPaneClassName);
    procedure SetAlwaysShowHeader(const Value: boolean);
    procedure SetCloseButton(const Value: boolean);

    function GetFormInstance: TadxExcelTaskPane;
    procedure DeleteAllForms;
    procedure HideAllForms;
    procedure HideAllNotInjectedForms;
    procedure SetAppWindowProperty(AExcelContextArgs: TObject; AAppWindowProperty: Pointer);
    function FindForm: TadxExcelTaskPane;
    procedure FormsHideShow;

    function CreateForm: TadxExcelTaskPane;
    function GetForm(Cancel: boolean): TadxExcelTaskPane;
    function FormsManager: TadxExcelTaskPanesManager;
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

    class function ConvertPositionToDesignString(Position: TadxExcelTaskPanePosition): string;
    procedure SetHideButtonVisible(const Value: boolean);
    procedure SetUseOfficeThemeForBackground(const Value: boolean);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function CreateTaskPaneInstance(): TadxExcelTaskPane;
    procedure ShowTaskPane();
    property TaskPaneInstance: TadxExcelTaskPane read GetFormInstance;
  published
    property Position: TadxExcelTaskPanePosition read FLayout write SetPosition default pUnknown;
    property AllowedDropPositions: TadxAllowedDropPositions read FAllowedDropPositions write SetAllowedDropPositions  default [];
    property TaskPaneClassName: TadxExcelTaskPaneClassName read FFormClassName write SetFormClassName;
    property Enabled: boolean read FEnabled write SetEnabled default true;
    property Splitter: TadxExcelSplitter read FSplitter write SetSplitter default sbStandard;
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


  TadxExcelTaskPaneClass = class of TadxExcelTaskPane;

var
  adxXlForm: TadxExcelTaskPane;

function Log: ILog;


implementation

{$R adxExcelTaskPane.dfm}

uses Math, ShlObj, ActiveX, Contnrs, Registry;

const
  adxErrorCantContain = 'The %s class cannot be contained in the %s class.';
  adxErrorCantContainEmptyParam = 'The %s param cannot be nil.';
  adxErrorSecondComponent = 'It isn''t possible to place second %s component!';
  adxLCID: Integer = LOCALE_USER_DEFAULT;

  ADXXOL = 'ADXXXL';
  EMPTY = 'EMPTY';

  { Error messages }
  adxECode = 31100;
  adxECodeCantContain = adxECode + 1;

var
  FormsManagerSingleton: TadxExcelTaskPanesManager;

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
      if r.OpenKeyReadOnly('Software\Add-in Express\InstalledProducts\Add-in Express 2007 for VCL\Plugins\ADX Extensions VCL for Microsoft Excel') then begin
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

  TadxExcelExceptionManager = class(TadxExceptionManager)
    procedure InternalProcessADXXError(err: SysUtils.Exception; whereHappened: string); override;
  end;

  TExcelAppWindowBehaviour = class(TAppWindowBehaviour)
  protected
    procedure WM_DESTROY(hWnd: THandle; Msg: UINT; wParam, lParam: Longint; appWindow: TAppWindow); override;
  end;


  GlobalsXl = class
    class function ADXXlReceiverWindowCaption: string;
  end;


  TadxExcelAddinEvents = class
  private
    FCOMAddInModule: TadxCOMAddInModule;
    FFormsManager: TadxExcelTaskPanesManager;
    FOldAddInBeginShutdown: TNotifyEvent;
    FOldAddInFinalize: TNotifyEvent;
    FOldAddInInitialize: TNotifyEvent;
    FOldAddInStartupComplete: TNotifyEvent;
    procedure Connect;
    procedure Disconnect;
  public
    constructor Create(AFormsManager: TadxExcelTaskPanesManager; ACOMAddInModule: TadxCOMAddInModule);
    destructor Destroy; override;
    procedure OnAddInBeginShutdown(Sender: TObject);
    procedure OnAddInFinalize(Sender: TObject);
    procedure OnAddInInitialize(Sender: TObject);
    procedure OnAddInStartupComplete(Sender: TObject);
  end;

  TadxExcelTaskPanesManagerState = class
  protected
    isShutdown: boolean;
    WasAddinInitialize: boolean;
    isAddinInitialize: boolean;
    procedure Restore;
  public
    constructor Create;
  end;

  TExcelContextArgs = class
  private
    FHostHandle: HWND;
  public
    constructor Create(AFormsManager: TadxExcelTaskPanesManager);
    destructor Destroy; override;
  end;

  TadxExcelTaskPanesManagerList = class(TList)
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
    FFormsManager: TadxExcelTaskPanesManager;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; AFormsManager: TadxExcelTaskPanesManager);
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


{ TadxXlErrorEventArgs }

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

{ TadxXlInitializeEventArgs }

constructor TadxInitializeEventArgs.Create;
begin

end;

destructor TadxInitializeEventArgs.Destroy;
begin

  inherited;
end;

{ TadxXlBeforeFormShowEventArgs }

constructor TadxBeforeTaskPaneShowEventArgs.Create;
begin

end;

destructor TadxBeforeTaskPaneShowEventArgs.Destroy;
begin

  inherited;
end;

{ TadxXlAfterFormShowEventArgs }

constructor TadxAfterTaskPaneShowEventArgs.Create;
begin

end;

destructor TadxAfterTaskPaneShowEventArgs.Destroy;
begin

  inherited;
end;

{ TadxXlBeforeCellEditEventArgs }

constructor TadxBeforeCellEditEventArgs.Create;
begin

end;

destructor TadxBeforeCellEditEventArgs.Destroy;
begin

  inherited;
end;

{ TadxXlAfterCellEditEventArgs }

constructor TadxAfterCellEditEventArgs.Create;
begin

end;

destructor TadxAfterCellEditEventArgs.Destroy;
begin

  inherited;
end;

{ TadxXlKeyFilterEventArgs }

constructor TadxKeyFilterEventArgs.Create(AAdxKeyInfo: TadxKeyInfo);
begin
  FAdxKeyInfo:= AAdxKeyInfo;
  FAction:= faSendToTaskPane;
end;

destructor TadxKeyFilterEventArgs.Destroy;
begin
  inherited;
end;

function TadxKeyFilterEventArgs.GetKeyCode: byte;
begin
  result:= FAdxKeyInfo.KeyCode
end;

function TadxKeyFilterEventArgs.GetKeyValue: Cardinal;
begin
  result:= FAdxKeyInfo.KeyValue;
end;

function TadxKeyFilterEventArgs.GetPressed: boolean;
begin
  result:= false;
  if FAdxKeyInfo.State = csPressed then
    result:= true;
end;

function TadxKeyFilterEventArgs.GetShiftState: TShiftState;
begin
  result:= [];
  if FAdxKeyInfo.Alt then Include(result, ssAlt);
  if FAdxKeyInfo.Control then Include(result, ssCtrl);
  if FAdxKeyInfo.Shift then Include(result, ssShift);
end;

{ TadxXlBeforeFormInstanceCreateEventArgs }

constructor TadxBeforeTaskPaneInstanceCreateEventArgs.Create(
  AItem: TadxExcelTaskPanesCollectionItem; ADefaultCancel: boolean);
begin
  FCancel := ADefaultCancel;
  FItem := AItem;
end;

destructor TadxBeforeTaskPaneInstanceCreateEventArgs.Destroy;
begin
  FItem := nil;
  inherited;
end;

{ TadxXlFormsCollectionItem }

constructor TadxExcelTaskPanesCollectionItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FRegionBorder := rbsSingle;
  FIsHiddenStateAllowed := true;
  FEnabled := true;
  FSplitter := sbStandard;
  FUseOfficeThemeForBackground:= false;
  FFormInstances := TadxExcelTaskPanesManagerList.Create(Self);
end;

function TadxExcelTaskPanesCollectionItem.CreateForm: TadxExcelTaskPane;
var
  p: TPersistentClass;
begin
  try
    p := GetClass(TaskPaneClassName);
    result := TadxExcelTaskPaneClass(p).CreateEx(FormsManager, self);
    if (result <> nil) then begin
      TadxExcelTaskPanesManagerList(FFormInstances).Add(result);
      result.UpdateColor(FormsManager.FExcelVersion);
    end;
  except
    on Ex:SysUtils.Exception do begin
      raise SysUtils.Exception.Create('TadxXlFormsCollectionItem.CreateForm: ' + Ex.Message);
    end;
  end;
end;

function TadxExcelTaskPanesCollectionItem.CreateTaskPaneInstance: TadxExcelTaskPane;
var
  Args: TadxBeforeTaskPaneInstanceCreateEventArgs;
  Cancel: boolean;
begin
  Log.AddMessage('TadxXlFormsCollectionItem.CreateFormInstance');
  try
    if (TadxExcelTaskPanesManagerList(FFormInstances).Count > 0) then begin
      raise SysUtils.Exception.Create('An instance of TadxExcelTaskPane already exists.');
    end;

      Args := TadxBeforeTaskPaneInstanceCreateEventArgs.Create(Self, false);
      try
        FormsManager.DoBeforeFormInstanceCreate(Args);
        Cancel := Args.Cancel;
      finally
        if Assigned(Args) then begin
          Args.Free;
        end;
      end;
      result := self.GetForm(Cancel);
  except
    on E: SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'CreateTaskPaneInstance');
      result := nil;
    end;
  end;
end;

procedure TadxExcelTaskPanesCollectionItem.DeleteAllForms;
var
  Form: TadxExcelTaskPane;
  FormIndex: integer;
begin
  Log.AddMessage('TadxXlFormsCollectionItem.DeleteAllForms ' + IntToStr(TadxExcelTaskPanesManagerList(FFormInstances).Count));
  try
    Log.AddIndent();
    try
      FormIndex := 0;
      while FormIndex < TadxExcelTaskPanesManagerList(FFormInstances).Count do begin
        if TadxExcelTaskPanesManagerList(FFormInstances)[FormIndex] <> nil then begin
          Form := TadxExcelTaskPanesManagerList(FFormInstances)[FormIndex];
          Form.Free;
          TadxExcelTaskPanesManagerList(FFormInstances).Delete(FormIndex);
          Dec(FormIndex);
        end;
        Inc(FormIndex);
      end;
    finally
      Log.RemoveIndent();
    end;
  except
    on E: SysUtils.Exception do begin
      Log.AddException('TadxXlFormsCollectionItem.DeleteAllForms: ' + E.Message);
      raise E;
    end;
  end;
end;

destructor TadxExcelTaskPanesCollectionItem.Destroy;
begin
  if Assigned(FFormInstances) then begin
    FFormInstances.Free;
  end;
  inherited;
end;

function TadxExcelTaskPanesCollectionItem.FindForm(): TadxExcelTaskPane;
begin
  if (TadxExcelTaskPanesManagerList(FFormInstances).Count = 0) then begin
    result := nil;
  end
  else begin
    result := TadxExcelTaskPanesManagerList(FFormInstances)[0];
  end;
end;

procedure TadxExcelTaskPanesCollectionItem.FormsHideShow;
var
  index: integer;
begin
  Log.AddMessage('TadxXlFormsCollectionItem.FormsHideShow');
  for index := 0 to TadxExcelTaskPanesManagerList(FFormInstances).Count - 1 do begin
    if TadxExcelTaskPanesManagerList(FFormInstances)[index] <> nil then begin
      if TadxExcelTaskPane(TadxExcelTaskPanesManagerList(FFormInstances)[index]).Visible then begin
        if (not TadxExcelTaskPane(TadxExcelTaskPanesManagerList(FFormInstances)[index]).LockVisible) then begin
          TadxExcelTaskPane(TadxExcelTaskPanesManagerList(FFormInstances)[index]).Hide();
          if (IsWindowVisible(FormsManager.FHostHandle)) then begin
            FormsManager.TryShow(TadxExcelTaskPane(TadxExcelTaskPanesManagerList(FFormInstances)[index]));
          end;
        end;
      end;
    end;
  end;
end;

function TadxExcelTaskPanesCollectionItem.GetAdxLayout: integer;
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

function TadxExcelTaskPanesCollectionItem.GetForm(Cancel: boolean): TadxExcelTaskPane;
begin
  Log.AddMessage('GetForm');
  result := nil;
  if not Cancel then begin
    result := CreateForm;
    if (result = nil) then begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxXlFormsCollectionItem.GetForm: A form has not been created.'), 'GetForm')
    end;
  end;
end;

function TadxExcelTaskPanesCollectionItem.GetFormInstance: TadxExcelTaskPane;
begin
  if (TadxExcelTaskPanesManagerList(FFormInstances).Count = 0) then begin
    result := nil;
  end
  else begin
    result := TadxExcelTaskPanesManagerList(FFormInstances)[0];
  end;
end;

function TadxExcelTaskPanesCollectionItem.FormsManager: TadxExcelTaskPanesManager;
begin
  try
  {$IFDEF ADX_VCL5}
      result := TadxExcelTaskPanesManager(TadxExcelTaskPanesCollection(Collection).GetOwner)
  {$ELSE}
      result := TadxExcelTaskPanesManager(Collection.Owner);
  {$ENDIF}
  except
    on Ex: SysUtils.Exception do begin
      raise SysUtils.Exception.Create('TadxXlFormsCollectionItem.FormsManager: ' + Ex.Message);
    end;
  end;
end;

procedure TadxExcelTaskPanesCollectionItem.HideAllForms;
var
  index: integer;
begin
  Log.AddMessage('TadxXlFormsCollectionItem.HideAllForms');
  for index := 0 to TadxExcelTaskPanesManagerList(FFormInstances).Count - 1 do begin
    if TadxExcelTaskPanesManagerList(FFormInstances)[index] <> nil then begin
      if TadxExcelTaskPane(TadxExcelTaskPanesManagerList(FFormInstances)[index]).Visible then begin
        TadxExcelTaskPane(TadxExcelTaskPanesManagerList(FFormInstances)[index]).ADXXlHide(true);
      end;
    end;
  end;
end;

procedure TadxExcelTaskPanesCollectionItem.SetAppWindowProperty(
  AExcelContextArgs: TObject; AAppWindowProperty: Pointer);
var
  ExcelContextArgs: TExcelContextArgs;
  ContextAdxItemType: TAdxItemType;
  AppWindowProperty :PAppWindowProperty;

begin
  Log.AddMessage('TadxXlFormsCollectionItem.SetAppWindowProperty');
  AppWindowProperty := PAppWindowProperty(AAppWindowProperty);

  ExcelContextArgs := TExcelContextArgs(AExcelContextArgs);

  ContextAdxItemType := FormsManager.GetAdxItemType(self);
  if (ContextAdxItemType > 0) then begin
    AppWindowProperty^.HostHandle := ExcelContextArgs.FHostHandle;
    AppWindowProperty^.ItemType := ContextAdxItemType;
    AppWindowProperty^.WindowHandle := GetAppWindowHandle(Ord(FormsManager.FExcelVersion), ContextAdxItemType, ExcelContextArgs.FHostHandle);

    AppWindowProperty^.Offset := GetOffset(FormsManager.FExcelVersion, ContextAdxItemType);
    AppWindowProperty^.Layout := Self.GetAdxLayout();
    AppWindowProperty^.ContainerType := 0;

    AppWindowProperty^.AlwaysShowHeader:= AlwaysShowHeader;
    AppWindowProperty^.CloseButton:= CloseButton;
    AppWindowProperty^.SplitterButton := IsHiddenStateAllowed;
    AppWindowProperty^.RegionBorder := RegionBorder;

    AppWindowProperty^.HostVersion  := FormsManager.FExcelVersion;
    AppWindowProperty^.Splitter := Ord(Self.Splitter);
  end;
end;

procedure TadxExcelTaskPanesCollectionItem.SetEnabled(const Value: boolean);
begin
  if (self.FEnabled <> Value) then begin
    self.FEnabled := Value;
    DeleteAllForms;
  end;
end;

procedure TadxExcelTaskPanesCollectionItem.SetFormClassName(
  const Value: TadxExcelTaskPaneClassName);
begin
  if (not Globals.CompareADXStrings(Self.FFormClassName, Value)) then begin
    Log.AddMessage('ADXXlFormsCollectionItem.SetFormClassName');
    Self.FFormClassName := Value;
    DeleteAllForms();
  end;
end;

procedure TadxExcelTaskPanesCollectionItem.SetPosition(const Value: TadxExcelTaskPanePosition);
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

procedure TadxExcelTaskPanesCollectionItem.SetSplitter(
  const Value: TadxExcelSplitter);
begin
  if (self.FSplitter <> Value) then begin
    self.FSplitter :=Value;
  end;
end;

procedure TadxExcelTaskPanesCollectionItem.SetUseOfficeThemeForBackground(const Value: boolean);
var
  taskPane: TadxExcelTaskPane;
begin
  if FUseOfficeThemeForBackground <> Value then begin
    FUseOfficeThemeForBackground := Value;
    taskPane:= TaskPaneInstance;
    if Assigned(taskPane) then begin
      if FUseOfficeThemeForBackground then
        taskPane.Color := taskPane.GetBackColor()
      else
        taskPane.Color := taskPane.OldColor;
    end;
  end;
end;

{ TadxXlFormsCollection }

function TadxExcelTaskPanesCollection.Add: TadxExcelTaskPanesCollectionItem;
begin
  Result := TadxExcelTaskPanesCollectionItem.Create(Self);
  if (csDesigning in TadxExcelTaskPanesManager(Owner).ComponentState) then begin
    Result.UseOfficeThemeForBackground := true;
  end;
end;

function TadxExcelTaskPanesCollection.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := 'Name';
    1: Result := 'TaskPaneClassName';
    2: Result := 'Position';
  else
    Result := '';
  end;
end;

function TadxExcelTaskPanesCollection.GetAttrCount: Integer;
begin
  Result := 3;
end;

function TadxExcelTaskPanesCollection.GetItem(
  Index: Integer): TadxExcelTaskPanesCollectionItem;
begin
  Result := TadxExcelTaskPanesCollectionItem(inherited Items[Index]);
end;

function TadxExcelTaskPanesCollection.GetItemAttr(Index,
  ItemIndex: Integer): string;
begin
  case Index of
    0: Result := Format('%d - ', [ItemIndex]) + Items[ItemIndex].ClassName;
    1: Result := Items[ItemIndex].TaskPaneClassName;
    2: Result := TadxExcelTaskPanesCollectionItem.ConvertPositionToDesignString(Items[ItemIndex].Position);
  else
    Result := '';
  end;
end;

{$IFDEF ADX_VCL5}
function TadxExcelTaskPanesCollection.Owner: TPersistent;
begin
  Result := GetOwner;
end;
{$ENDIF}

procedure TadxExcelTaskPanesCollection.SetItem(Index: Integer;
  Value: TadxExcelTaskPanesCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TadxXlForm }

procedure TadxExcelTaskPane.AdxXlShow(AAppWindowProperty: Pointer;
  raiseEvents: boolean);
var
  adxCaption: TadxCaption;
  WishfulVisible: boolean;
  BeforeFormShowEventArgs: TadxBeforeTaskPaneShowEventArgs;
  AfterFormShowEventArgs: TadxAfterTaskPaneShowEventArgs;
begin
  Log.AddMessage('TadxXlForm.AdxXlShow');

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
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('AdxOlShow: ' + E.Message), 'AdxXlShow');
    end;
  end;
end;

procedure TadxExcelTaskPane.ADXXlHide(raiseEvents: boolean);
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
    DisposeExcelObjects;

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

constructor TadxExcelTaskPane.CreateEx(AFormsManager: TadxExcelTaskPanesManager;
  AItem: TadxExcelTaskPanesCollectionItem);
begin
  Log.AddMessage('TadxXlForm.CreateEx');
  try
    inherited Create(AFormsManager);
    if not (csDesigning in self.ComponentState) then begin
      FFormsManager := AFormsManager as TadxExcelTaskPanesManager;
      FItem := AItem as TadxExcelTaskPanesCollectionItem;
    end;
  except
    on E: SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'TadxExcelTaskPane.CreateEx');
      raise E;
    end;
  end;
end;

destructor TadxExcelTaskPane.Destroy;
var
  index: integer;
begin
  Log.AddMessage('TadxXlForm.Destroy ');
  if not (csDesigning in self.ComponentState) then begin
    if self.Visible then
      self.Hide();

    index := TadxExcelTaskPanesManagerList(FItem.FFormInstances).IndexOf(self);
    TadxExcelTaskPanesManagerList(FItem.FFormInstances)[index] := nil;
    FItem := nil;
    FFormsManager := nil;
  end;
  Log.AddMessage('TadxXlForm.Destroy.inherited');
  inherited;
end;

procedure TadxExcelTaskPane.DisposeExcelObjects;
begin
  //
end;

procedure TadxExcelTaskPane.DoADXAfterFormShow(
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

procedure TadxExcelTaskPane.DoADXAfterTaskPaneHide(
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

procedure TadxExcelTaskPane.DoADXBeforeTaskPaneShow(
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
        event.free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnADXBeforeTaskPaneShow');
      end;
    end;
  end;
end;

procedure TadxExcelTaskPane.DoADXKeyFilter(Args: TadxKeyFilterEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnADXKeyFilter) then begin
    try
      event := TadxEventRaising.Create('OnADXKeyFilter', [eoLockRegionState]);
      try
        OnADXKeyFilter(self, Args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoADXKeyFilter');
      end;
    end;
  end;
end;

procedure TadxExcelTaskPane.DoAfterCellEdit(Args: TadxAfterCellEditEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnADXAfterCellEdit) then begin
    try
      event := TadxEventRaising.Create('OnADXAfterCellEdit', []);
      try
        OnADXAfterCellEdit(self, Args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoAfterCellEdit');
      end;
    end;
  end;
end;

procedure TadxExcelTaskPane.DoBeforeCellEdit(Args: TadxBeforeCellEditEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnADXBeforeCellEdit) then begin
    try
      event := TadxEventRaising.Create('OnADXBeforeCellEdit', []);
      try
        OnADXBeforeCellEdit(self, Args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoBeforeCellEdit');
      end;
    end;
  end;
end;

function TadxExcelTaskPane.GetAddinModule: TObject;
begin
  result := nil;
  if (FFormsManager <> nil) then begin
    result := FFormsManager.Owner;
  end;
end;

function TadxExcelTaskPane.GetExcelAppObj: ExcelApplication;
begin
  if (FFormsManager <> nil) then begin
    result := FFormsManager.ExcelAppObj;
  end;
end;

procedure TadxExcelTaskPane.InitializeForm(AExcelContextArgs: TObject; AAppWindowProperty: Pointer);
begin
  CopyAppWindowProperty(FAppWindowProperty, AAppWindowProperty);
end;

procedure TadxExcelTaskPane.DoInstanceFocused(focused: boolean);
var
  argsEnter: TadxExcelEnterEventArgs;
  argsExit: TadxExcelExitEventArgs;
begin
  try
    if focused then begin
      argsEnter:= TadxExcelEnterEventArgs.Create;
      try
        DoAdxEnter(argsEnter)
      finally
        if Assigned(argsEnter) then
          FreeAndNil(argsEnter);
      end;
    end
    else begin
      argsExit:= TadxExcelExitEventArgs.Create;
      try
        DoAdxExit(argsExit);
      finally
        if Assigned(argsExit) then
          FreeAndNil(argsExit);
      end;
    end;
  except
    on e: SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'TadxExcelTaskPane.DoInstanceFocused: ' + e.Message);
    end;
  end;
end;

procedure TadxExcelTaskPane.DoReceiveAdxPostMessageCluster(msg: TMessage);
var
  postMessageArgs: TadxExcelPostMessageReceivedEventArgs;
begin
  postMessageArgs:= TadxExcelPostMessageReceivedEventArgs.Create;
  try
    Log.AddMessage(ClassName+'.DoReceiveAdxPostMessageCluster');
    ReceiveMessageCluster(msg, postMessageArgs.wParam, postMessageArgs.lParam);
    DoAdxPostMessage(postMessageArgs);
  finally
    if Assigned(postMessageArgs) then
      FreeAndNil(postMessageArgs);
  end;
end;

procedure TadxExcelTaskPane.WndProc(var Msg: TMessage);
var
  keyInfo: TadxKeyInfo;
  adxKeyFilterEventArgs: TadxKeyFilterEventArgs;

begin
  if not (csDesigning in self.ComponentState) then begin
    if msg.Msg = WM_ADXCOMMAND then begin
      try
        case msg.WParam of
          adxKeyFilter: begin
            msg.Result:= ord(faSendToTaskPane);

            keyInfo := PadxKeyInfo(Pointer(msg.LParam))^;
            adxKeyFilterEventArgs:= TadxKeyFilterEventArgs.Create(keyInfo);
            DoADXKeyFilter(adxKeyFilterEventArgs);
            msg.Result:= ord(adxKeyFilterEventArgs.Action);
            adxKeyFilterEventArgs.Destroy;
          end;

          adxPostMessageCmd: begin
            DoReceiveAdxPostMessageCluster(msg);
          end
        else
          inherited WndProc(Msg);
        end;
      except
        on e: Exception do begin
          TadxExceptionManager.ProcessADXXError(E, format('TadxExcelTaskPane.WndProc: Msg= WM_ADXCOMMAND wParam= %x lParam= %x : %s', [Msg.WParam, Msg.LParam, e.Message]));
        end;
      end;
      exit;
    end;
  end;
  inherited WndProc(Msg);
end;

{ TadxXlFormsManager }

procedure TadxExcelTaskPanesManager.AddCloseButtonClickMessageToReceiver;
begin
  Log.AddMessage('AddCloseButtonClickMessageToReceiver');
  if (not TadxReceiverWindow(FReceiverWindow).Exists(TRegionCloseButtonClickMessage)) then
    TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
      (TRegionCloseButtonClickMessage.Create(self.ReceiverWindowHandle, self));
end;

procedure TadxExcelTaskPanesManager.AddinsToLog;
var
  objAddins, objAddin: IDispatch;
  i, n: integer;
  connect: boolean;
  progID, description, connectMarker: string;
begin
  objAddins := ExcelAppObj.COMAddIns;
  n := OleVariant(objAddins).Count;
  try
    for i := 1 to n do begin
      objAddin := OleVariant(objAddins).Item(i);
      connect := OleVariant(objAddin).Connect;
      progID := OleVariant(objAddin).ProgID;
      description := OleVariant(objAddin).Description;
      if (connect) then begin
        connectMarker := '* ';
      end
      else begin
        connectMarker := '  ';
      end;
      Log.AddSystemInfo(connectMarker + 'Addin ' + IntToStr(i) + ':' + IntToStr(n) + ' ' + progID + ', ' + description);

    end;
  finally
    objAddins := nil;
    objAddin := nil;
  end;

end;

function TadxExcelTaskPanesManager.AdxLocalRegistryKey: string;
begin
  if (Owner <> nil) then begin
    result := (Owner as TadxCOMAddInModule).RegistryKey + '\' + Globals.ADXXLForm;
  end
  else begin
    result := '';
  end;
end;

function TadxExcelTaskPanesManager.AdxRegistryKey: string;
var
  Reg: TRegistry;
begin
  Result:= '\Software\Microsoft\Office\Excel\AddIns\' + Globals.ADXXLForm + '\';
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey(Result, true);
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function TadxExcelTaskPanesManager.CheckAllowedDropPosition(
  Item: TadxExcelTaskPanesCollectionItem;
  WindowLayout: TadxWindowLayout): boolean;
begin
  result := false;

  if (CompareAllowedDropPositionsAndWindowLayout(Item, WindowLayout, dpBottom)) then result := true;
  if (CompareAllowedDropPositionsAndWindowLayout(Item, WindowLayout, dpLeft)) then result :=  true;
  if (CompareAllowedDropPositionsAndWindowLayout(Item, WindowLayout, dpRight)) then result :=  true;
  if (CompareAllowedDropPositionsAndWindowLayout(Item, WindowLayout, dpTop)) then result :=  true;
end;

function TadxExcelTaskPanesManager.CheckHostVisible: boolean;
begin
  result := IsWindowVisible(FHostHandle); 
end;

function TadxExcelTaskPanesManager.COMAddInModule: TadxCOMAddInModule;
begin
  try
    result := Owner as TadxCOMAddInModule;
  except
    on E: SysUtils.Exception do begin
      Log.AddException('TadxXlFormsManager.COMAddInModule: ' + E.Message);
      result := nil;
    end;
  end;
end;

function TadxExcelTaskPanesManager.CompareAllowedDropPositionsAndWindowLayout(
  Item: TadxExcelTaskPanesCollectionItem; WindowLayout: TadxWindowLayout;
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

function TadxExcelTaskPanesManager.ConvertPositionToAllowedDropPosition(
  Position: TadxExcelTaskPanePosition): TadxAllowedDropPosition;
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

constructor TadxExcelTaskPanesManager.Create(AOwner: TComponent);
var
  i: integer;
begin
  FState := nil;
  try
    if not (csDesigning in self.ComponentState) then begin
      Log.AddSystemInfo('Time: ' + DateTimeToStr(Now));
      Log.AddSystemInfo('Package: ' + ProductVersionAndPackage);
      Log.AddSystemInfo('ADX Version:' + adxVersion);
      Log.AddSystemInfo('ADX Extensions Version 6.1.754');
      Log.AddMessage('TadxExcelTaskPanesManager.Create');
    end;

    if AOwner = nil then begin
      raise EADXException.Create(Format(adxErrorCantContain, [ClassName, 'nil']), adxECodeCantContain, 0);
    end;
    if not (AOwner is TadxCOMAddInModule) then begin
      raise EADXException.Create(Format(adxErrorCantContain, [ClassName, AOwner.ClassName]), adxECodeCantContain, 0);
    end;
    for i := 0 to AOwner.ComponentCount - 1 do begin
      if (AOwner.Components[i] is TadxExcelTaskPanesManager) then begin
        raise EADXException.Create(Format(adxErrorSecondComponent, [ClassName]), adxECodeCantContain, 0);
      end;
    end;
    inherited Create(AOwner);

    FState := TadxExcelTaskPanesManagerState.Create;
    FItems := TadxExcelTaskPanesCollection.Create(Self, TadxExcelTaskPanesCollectionItem);

    if not (csDesigning in self.ComponentState) then begin
      FormsManagerSingleton := self;
      if (AOwner is TadxCOMAddInModule) then begin
        FAddinModuleEvents := TadxExcelAddinEvents.Create(self, self.COMAddInModule);
      end;
      CreateMutexes;
    end;
  except
    on E:SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create(E.Message), 'TadxExcelTaskPanesManager.Create');
    end;
  end;
end;

procedure TadxExcelTaskPanesManager.CreateMutexes;
begin
  hMessageMutex := 0; //CreateMutex(nil, False, nil);
end;

procedure TadxExcelTaskPanesManager.DeleteAllForms;
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

procedure TadxExcelTaskPanesManager.DeleteMutexes;
begin
  if (hMessageMutex <> 0) then begin
    CloseHandle(hMessageMutex);
    hMessageMutex := 0;
  end;
end;

destructor TadxExcelTaskPanesManager.Destroy;
begin
  if not (csDesigning in self.ComponentState) then begin
    FormsManagerSingleton := nil;
    if Assigned(FAddinModuleEvents) then begin
      FAddinModuleEvents.Free;
      FAddinModuleEvents := nil;
    end;
    DeleteMutexes;
    if Assigned(FReceiverWindow) then begin
      TadxReceiverWindow(FReceiverWindow).Free;
    end;

    if (FState <> nil) then begin
      FState.Free;
      FState := nil;
    end;

    if Assigned(FItems) then begin
      FItems.Clear;
      FItems.Free;
      FItems := nil;
    end;


  end;
  inherited Destroy;

  if (ExceptionManager <> nil) then begin
    ExceptionManager.Free;
    ExceptionManager := nil;
  end;

end;

procedure TadxExcelTaskPanesManager.DoAddInBeginShutdown(Sender: TObject);
begin
  if (COMAddInModule.HostType <> ohaExcel) then begin
    exit;
  end;

  Log.AddMessage('TadxExcelTaskPanesManager.DoAddInBeginShutdown');


  try
    TadxExcelTaskPanesManagerState(FState).isShutdown := true;
    HideAllForms();
    DeleteAllForms();
    if Assigned(FExcelHook) then begin
      FExcelHook.Free;
      FExcelHook := nil;
    end;

    TAppWindowBehaviour.SingletonFree;
	finally
		TadxExcelTaskPanesManagerState(FState).isShutdown := false;
  end;
end;

procedure TadxExcelTaskPanesManager.DoAddInFinalize(Sender: TObject);
begin
  if (COMAddInModule.HostType <> ohaExcel) then begin
    exit;
  end;

  Log.AddMessage('TadxExcelTaskPanesManager.DoAddInFinalize');

  adxWSbcls.APIFinalize;
end;

procedure TadxExcelTaskPanesManager.DoAddInInitialize(Sender: TObject);
var
  args: TadxInitializeEventArgs;
  contextArgs: TExcelContextArgs;
  ItemIndex: integer;
begin
  if (COMAddInModule.HostType <> ohaExcel) then begin
    exit;
  end;

  Log.AddMessage('TadxExcelTaskPanesManager.DoAddInInitialize');
  if TadxExcelTaskPanesManagerState(FState).WasAddinInitialize then begin
    //Case 1563
    Log.AddMessage('Skip second TadxExcelTaskPanesManager.DoAddInInitialize');
    Exit;
  end;
  adxWSbcls.APIInitialize;


  ExceptionManager := TadxExcelExceptionManager.Create;
  if (AppWindowBehaviourSingleton = nil) then begin //Case 1563
    TAppWindowBehaviour.SetSingleton(TExcelAppWindowBehaviour.Create);
  end;

  try
    TadxExcelTaskPanesManagerState(FState).isAddinInitialize := true;
    try
      if (ExcelAppObj = nil) then begin
        Log.AddWarning('DoAddinInitialize.ExcelApplication == null');
        exit;
      end;

      LoadPositionsFromRegistry;

      args := TadxInitializeEventArgs.Create;
      try
        DoADXInitialize(args);
      finally
        args.Free;
      end;

      SetExcelVersion();

      FReceiverWindow := TadxReceiverWindow.CreateEx(
        Self, GlobalsXl.ADXXlReceiverWindowCaption);
      AddCloseButtonClickMessageToReceiver();


      FHostHandle := GetAppWindowHandle(self.FExcelVersion, stXlMain, GetDesktopWindow());

      if (FHostHandle = 0) then begin
        Sleep(100);
        FHostHandle := GetAppWindowHandle(self.FExcelVersion, stXlMain, GetDesktopWindow());
      end;

      Log.AddMessage('TadxXLHook.CreateEx');
      FExcelHook := TadxXLHook.CreateEx(self.FExcelVersion, self.FHostHandle, self.DoBeforeCellEdit, self.DoAfterCellEdit);

      contextArgs := TExcelContextArgs.Create(self);
      try
        if (CheckHostVisible)
          or (FExcelVersion = v2010)
          or (FExcelVersion = v2007) //Case 2192
           then begin
          try
            adxextLockWindowUpdate(FHostHandle);
            for ItemIndex := 0 to self.Items.Count - 1 do begin
              DoShowForm(self.Items[ItemIndex], contextArgs);
            end;
          finally
            adxextUnlockWindowUpdate(FHostHandle);
          end;
        end;

      finally
        if Assigned(contextArgs) then begin
          contextArgs.Free;
        end;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoAddInInitialize');
      end;
    end;
  finally
    TadxExcelTaskPanesManagerState(FState).isAddinInitialize := false;
    TadxExcelTaskPanesManagerState(FState).WasAddinInitialize := true;
  end;
end;

procedure TadxExcelTaskPanesManager.DoAddInStartupComplete(Sender: TObject);
begin
  if (COMAddInModule.HostType <> ohaExcel) then begin
    exit;
  end;

  AddinsToLog();
  Log.AddMessage('TadxExcelTaskPanesManager.DoAddInStartupComplete');
end;

procedure TadxExcelTaskPanesManager.DoADXInitialize(Args: TadxInitializeEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnADXInitialize) then begin
    try
      event := TadxEventRaising.Create('OnADXInitialize', [eoLockRegionState]);
      try
        OnADXInitialize(self, Args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoADXInitialize');
      end;
    end;
  end;
end;

procedure TadxExcelTaskPanesManager.DoAfterCellEdit;
var
  ItemIndex: integer;
  Args: TadxAfterCellEditEventArgs;
begin
  Log.AddMessage('DoAfterCellEdit');
  for ItemIndex := 0 to self.Items.Count - 1 do begin
    if (self.Items[ItemIndex].TaskPaneInstance <> nil) then begin
      Args := TadxAfterCellEditEventArgs.Create;
      try
        self.Items[ItemIndex].TaskPaneInstance.DoAfterCellEdit(Args);
      finally
        if Assigned(Args) then begin
          Args.Free;
        end;
      end;
    end;
  end;
end;

procedure TadxExcelTaskPanesManager.DoBeforeCellEdit;
var
  ItemIndex: integer;
  Args: TadxBeforeCellEditEventArgs;
begin
  Log.AddMessage('DoBeforeCellEdit');
  for ItemIndex := 0 to self.Items.Count - 1 do begin
    if (self.Items[ItemIndex].TaskPaneInstance <> nil) then begin
      Args := TadxBeforeCellEditEventArgs.Create;
      try
        self.Items[ItemIndex].TaskPaneInstance.DoBeforeCellEdit(Args);
      finally
        if Assigned(Args) then begin
          Args.Free;
        end;
      end;
    end;
  end;
end;

procedure TadxExcelTaskPanesManager.DoBeforeFormInstanceCreate(
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

procedure TadxExcelTaskPanesManager.DoRegionCloseButtonClick(AFormHandle: HWND);
var
  Form: TadxExcelTaskPane;
begin
  Form := FindFormByHandle(AFormHandle);
  DoRegionCloseButtonClick(Form);
end;

procedure TadxExcelTaskPanesManager.DoRegionCloseButtonClick(AForm: TadxExcelTaskPane);
var
  Args: TadxExcelCloseButtonClickEventArgs;
  event: TadxEventRaising;
begin
  Args := nil;
  if Assigned(AForm) and Assigned(AForm.OnAdxCloseButtonClick) then begin
    try
      Args := TadxExcelCloseButtonClickEventArgs.Create;
      try
        event := TadxEventRaising.Create('OnAdxCloseButtonClick', [eoLockRegionState]);
        try
          AForm.OnAdxCloseButtonClick(AForm, Args);
        finally
          event.Free;
        end;
        if (Args.CloseForm) then begin
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

procedure TadxExcelTaskPanesManager.DoShowForm(AItem: TadxExcelTaskPanesCollectionItem;
  AExcelContextArgs: TObject);
var
  ExcelContextArgs: TExcelContextArgs;
  PropertiesIsSetToShowUpForm: boolean;

  Form: TadxExcelTaskPane;
  AppWindowProperty: PAppWindowProperty;
  Args: TadxBeforeTaskPaneInstanceCreateEventArgs;
  Cancel: boolean;
begin
  Log.AddMessage('DoShowForm');
  ExcelContextArgs := AExcelContextArgs as TExcelContextArgs;

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

      AItem.SetAppWindowProperty(ExcelContextArgs, AppWindowProperty);
      AppWindowProperty.ReceiverHandle := ReceiverWindowHandle;
      if (AppWindowProperty.WindowHandle > 0) then begin
        Form := AItem.FindForm;

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

        if (Form <> nil) and (not Form.Visible) and (not Form.Injected) then begin
          Form.InitializeForm(ExcelContextArgs, AppWindowProperty);
          Form.AdxXlShow(AppWindowProperty, true);
        end;
      end
      else begin
        Log.AddWarning('DoShowForm: ' + ' Window not found. '
          + Format('Handle: %x', [ExcelContextArgs.FHostHandle])
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

function TadxExcelTaskPanesManager.FindFormByHandle(
  AFormHandle: HWND): TadxExcelTaskPane;
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

function TadxExcelTaskPanesManager.GetAdxItemType(
  Item: TadxExcelTaskPanesCollectionItem): TAdxItemType;
begin
  result := stXLSheet;
end;

function TadxExcelTaskPanesManager.GetADXWindowLayout(
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

function TadxExcelTaskPanesManager.GetExcelAppObj: ExcelApplication;
begin
  IDispatch(COMAddInModule.HostApp).QueryInterface(ExcelApplication, result);
  //result := IDispatch(COMAddInModule.HostApp) as ExcelApplication;
end;

function TadxExcelTaskPanesManager.GetItems: TadxExcelTaskPanesCollection;
begin
  result := FItems;
end;

function TadxExcelTaskPanesManager.GetPosition(ItemType: TadxItemType;
  WindowLayout: TadxWindowLayout): TadxExcelTaskPanePosition;
begin
  result := pUnknown;

  case ItemType of
    stXLMain:
      case WindowLayout of
        wlBottom: result := pBottom;
        wlLeft: result := pLeft;
        wlRight: result := pRight;
        wlTop: result := pTop;
      end;
     else
       raise SysUtils.Exception.Create('GetPosition: The TadxExcelTaskPanePosition is not found.');
  end;
end;

function TadxExcelTaskPanesManager.GetPositionSize(
  Position: TadxExcelTaskPanePosition): integer;
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
      keyValue := TadxExcelTaskPane.GetPositionKey(Position);
      if Reg.ValueExists(KeyValue + '_Size') then begin
        result := Reg.ReadInteger(KeyValue + '_Size');
      end;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function TadxExcelTaskPanesManager.GetWasAddinInitialize: boolean;
begin
  if (FState = nil) then begin
    result := false;
    exit;
  end;
  result :=  TadxExcelTaskPanesManagerState(FState).WasAddinInitialize;
end;

procedure TadxExcelTaskPanesManager.HideAllForms;
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

procedure TadxExcelTaskPanesManager.LoadPositionsFromRegistry;
var
  i: integer;
begin
  for i := 0 to Items.Count - 1 do begin
    Items[i].LoadPositionFromRegistry;
  end;
end;

function TadxExcelTaskPanesManager.ReceiverWindowHandle: HWND;
begin
  if (FReceiverWindow <> nil) then begin
    result := TadxReceiverWindow(FReceiverWindow).Handle;
  end else begin
    result := 0;
  end;
end;

procedure TadxExcelTaskPanesManager.SetExcelVersion;
var
  hostVersion: string;
begin
  FExcelVersion := vUnknown;

  if COMAddinModule = nil then begin
    Log.AddWarning('SetExcelVersion: COMAddinModule = nil');
    exit;
  end;

  if ExcelAppObj <> nil then begin
    hostVersion := ExcelAppObj.Version[adxLCID];
    Log.AddSystemInfo('Excel version: ' + hostVersion);
  end
  else begin
    Log.AddWarning('SetExcelVersion: ExcelAppObj = nil');
    exit;
  end;

  if (Pos('9.0', hostVersion) > 0) then
      FExcelVersion := v2000;

  if (Pos('10.0', hostVersion) > 0) then
      FExcelVersion := v2002;

  if (Pos('11.0', hostVersion) > 0) then
      FExcelVersion := v2003;

  if (Pos('12.0', hostVersion) > 0) then
      FExcelVersion := v2007;

  if (Pos('14.0', hostVersion) > 0) then
      FExcelVersion := v2010;

  if FExcelVersion = vUnknown then
    raise EAbort.Create('SetExcelVersion: Excel version is not defined.')

end;

procedure TadxExcelTaskPanesManager.SetItems(const Value: TadxExcelTaskPanesCollection);
begin
  FItems := Value;
end;


{ TAddinEvents }

procedure TadxExcelAddinEvents.Connect;
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

constructor TadxExcelAddinEvents.Create(AFormsManager: TadxExcelTaskPanesManager; ACOMAddInModule: TadxCOMAddInModule);
begin
  FFormsManager := AFormsManager;
  FCOMAddInModule := ACOMAddInModule;
  Connect;
end;

destructor TadxExcelAddinEvents.Destroy;
begin
  Disconnect;
  inherited;
end;

procedure TadxExcelAddinEvents.Disconnect;
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

procedure TadxExcelAddinEvents.OnAddInBeginShutdown(Sender: TObject);
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

procedure TadxExcelAddinEvents.OnAddInFinalize(Sender: TObject);
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

procedure TadxExcelAddinEvents.OnAddInInitialize(Sender: TObject);
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

procedure TadxExcelAddinEvents.OnAddInStartupComplete(Sender: TObject);
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

procedure TadxExcelTaskPanesManager.TryShow(Form: TadxExcelTaskPane);
var
  ContextArgs: TExcelContextArgs;
begin
  if not Form.Visible then begin
    ContextArgs := TExcelContextArgs.Create(self);
    try
      DoShowForm(Form.Item, ContextArgs);
    finally
      ContextArgs.Free;
    end;
  end;
end;

{ TadxXlFormsManagerState }

constructor TadxExcelTaskPanesManagerState.Create;
begin
  Restore;
end;

procedure TadxExcelTaskPanesManagerState.Restore;
begin
	isShutdown := false;
	WasAddinInitialize := false;
	isAddinInitialize := false;
end;

{ TExcelContextArgs }

constructor TExcelContextArgs.Create(AFormsManager: TadxExcelTaskPanesManager);
begin
  FHostHandle := AFormsManager.FHostHandle;
end;

destructor TExcelContextArgs.Destroy;
begin
  FHostHandle := 0;
  inherited;
end;

{ TadxXlFormsManagerList }

procedure TadxExcelTaskPanesManagerList.Clear;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    TObject(Items[i]).Free;
  inherited;
end;

function TadxExcelTaskPanesManagerList.CountClasses(AClassType: TClass): integer;
var
  i: integer;
begin
  result := 0;
  for i := 0 to Count - 1 do begin
    if TObject(Items[i]) is AClassType then
      Inc(result);
  end;
end;

constructor TadxExcelTaskPanesManagerList.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor TadxExcelTaskPanesManagerList.Destroy;
begin
  FOwner := nil;
  inherited;
end;

{ GlobalsXl }

class function GlobalsXl.ADXXlReceiverWindowCaption: string;
begin
  result := 'ADXXlReceiverWindowCaption';
end;

procedure TadxExcelTaskPanesCollectionItem.SetAlwaysShowHeader(
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

procedure TadxExcelTaskPanesCollectionItem.SetCloseButton(
  const Value: boolean);
begin
  if FCloseButton <> Value then begin
    FCloseButton := Value;
    if (FCloseButton) then begin
      self.AlwaysShowHeader := true;
    end;
  end;
end;

{ TADXXXlExceptionManager }

procedure TadxExcelExceptionManager.InternalProcessADXXError(err: Exception; whereHappened: string);
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

procedure TadxExcelTaskPane.DoAdxEnter(args: TadxExcelEnterEventArgs);
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

procedure TadxExcelTaskPane.DoAdxExit(args: TadxExcelExitEventArgs);
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

procedure TadxExcelTaskPane.DoAdxPostMessage(args: TadxExcelPostMessageReceivedEventArgs);
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

function TadxExcelTaskPane.GetExcelApp: TExcelApplication;
begin
  result := nil;
  if (FFormsManager <> nil) and (FFormsManager.Owner <> nil) then begin
    if (FFormsManager.Owner is TadxCOMAddInModule) then begin
      result := (FFormsManager.Owner as TadxCOMAddInModule).ExcelApp;
    end;
  end;
end;

procedure TadxExcelTaskPane.Hide;
begin
  if not (csDesigning in self.ComponentState) then begin
    AdxXlHide(true);
  end
  else begin
    inherited Hide;
  end;
end;

procedure TadxExcelTaskPane.Show;
begin
  if not (csDesigning in self.ComponentState) then begin
    if LockVisible then begin
      Visible := true;
    end
    else begin
      ExcelTaskPaneManager.TryShow(self);
    end;
  end
  else begin
    inherited Show;
  end;
end;

function TadxExcelTaskPane.AdxLayoutKey: string;
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

function TadxExcelTaskPane.AdxRegistryKey: string;
begin
  Result:= ExcelTaskPaneManager.AdxRegistryKey;
end;

function TadxExcelTaskPane.RegistryKey: string;
begin
  if (Owner = nil) then begin
    TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxExcelTaskPane.RegistryKey: Cannot return a RegistryKey. Owner is nil.'), 'RegistryKey');
  end;
  if not (Owner is TadxExcelTaskPanesManager) then begin
    TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxExcelTaskPane.RegistrPostMessagereturn a RegistryKey. Owner is not TadxExcelTaskPaneManager.'), 'RegistryKey');
  end;
  result := TadxExcelTaskPanesManager(Owner).COMAddInModule.RegistryKey;
end;

procedure TadxExcelTaskPane.ADXPostMessage(wParam, lParam: Cardinal);
begin
  SendMessageCluster(Handle, wParam, lParam);
end;

procedure TadxExcelTaskPanesCollectionItem.HideAllNotInjectedForms;
var
  index: integer;
begin
  Log.AddMessage('TadxXlFormsCollectionItem.HideAllNotActiveForms');
  for index := 0 to TadxExcelTaskPanesManagerList(FFormInstances).Count - 1 do begin
    if TadxExcelTaskPanesManagerList(FFormInstances)[index] <> nil then begin
      if TadxExcelTaskPane(TadxExcelTaskPanesManagerList(FFormInstances)[index]).Visible
        and (not TadxExcelTaskPane(TadxExcelTaskPanesManagerList(FFormInstances)[index]).Injected) then begin
        TadxExcelTaskPane(TadxExcelTaskPanesManagerList(FFormInstances)[index]).ADXXlHide(true);
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
  AFormsManager: TadxExcelTaskPanesManager);
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

{ TadxExcelCloseButtonClickEventArgs }

constructor TadxExcelCloseButtonClickEventArgs.Create;
begin
  inherited;
  FCloseForm := true;
  FDisableItem := false;
end;

procedure TadxExcelCloseButtonClickEventArgs.SetCloseForm(const Value: boolean);
begin
  FCloseForm := Value;
end;

procedure TadxExcelCloseButtonClickEventArgs.SetDisableItem(
  const Value: boolean);
begin
  FDisableItem := Value;
end;

procedure TadxExcelTaskPane.UpdateAppWindowPropertyAfterBeforeFormShowEvent(
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


function TadxExcelTaskPane.UseOfficeThemeBackColor: boolean;
begin
  if Assigned(self.Item) then
    result:= self.Item.UseOfficeThemeForBackground
  else
    result:= false;
end;

function TadxExcelTaskPanesCollectionItem.GetDefaultRegionState: TadxRegionState;
begin
  result := FDefaultRegionState;
end;

procedure TadxExcelTaskPanesCollectionItem.SetDefaultRegionState(
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

function TadxExcelTaskPane.AdxLocalRegistryKey: string;
begin
  result := ExcelTaskPaneManager.AdxLocalRegistryKey;
end;

function TadxExcelTaskPane.GetDefaultRegionState: TadxInternalRegionState;
begin
  result:= irsNormal;
  if (not IsClientLayout) and Assigned(Item) then
    result := TadxInternalRegionState(ord(Item.DefaultRegionState) + 1);
end;

procedure TadxExcelTaskPanesCollectionItem.ShowTaskPane;
var
  contextArgs: TExcelContextArgs;
begin
  try
    contextArgs := TExcelContextArgs.Create(self.FormsManager);
    try
      self.FormsManager.DoShowForm(self, contextArgs);
    finally
      if Assigned(contextArgs) then begin
        contextArgs.Free;
      end;
    end;
  except
    on E: SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'ShowTaskPane');
    end;
  end;
end;

procedure TadxExcelTaskPanesCollectionItem.SetAllowedDropPositions(
  const Value: TadxAllowedDropPositions);
begin
  FAllowedDropPositions := Value;
  AddCurrentPositionToAllowedDropPositions(); 
end;

procedure TadxExcelTaskPane.GetDragLayoutParams(
  var lParams: TadxDragLayoutParams);
var
  position: TadxExcelTaskPanePosition;
  injectedTaskPaneSize: integer;
begin
  if (not self.Visible) then exit;
  if (not self.Item.IsDragDropAllowed) then exit;

  lParams.Disabled := not self.ExcelTaskPaneManager.CheckAllowedDropPosition(self.Item, lParams.Layout);
  position := self.ExcelTaskPaneManager.GetPosition(lParams.ItemType, lParams.Layout);

  injectedTaskPaneSize := GetSize(lParams.AppHandle, lParams.Layout);
  if (injectedTaskPaneSize > 0) then begin
    lParams.LayoutSize := injectedTaskPaneSize;
  end
  else begin
    lParams.LayoutSize := ExcelTaskPaneManager.GetPositionSize(position);
  end;

end;

procedure TadxExcelTaskPane.SetDragForm(AItemType: TAdxItemType;
  ALayout: TadxWindowLayout);
var
  position: TadxExcelTaskPanePosition;
begin
  if (self.ExcelTaskPaneManager.CheckAllowedDropPosition(self.Item, ALayout)) then begin
    position := ExcelTaskPaneManager.GetPosition(AItemType, ALayout);
    if (self.Item.Position <> position) then begin
      LockWindowUpdate(ExcelTaskPaneManager.FHostHandle);
      try
        self.Item.Position := position ;
        Self.Activate();
      finally
        LockWindowUpdate(0);
      end;
    end;
  end;
end;

procedure TadxExcelTaskPane.SetDragItems(ADragItems: TList);
begin
  if (not self.Visible) then exit;
  if (not self.Item.IsDragDropAllowed) then exit;

  InternalSetDragItems(ADragItems, dwlBottom, dpBottom);
  InternalSetDragItems(ADragItems, dwlTop, dpTop);
  InternalSetDragItems(ADragItems, dwlLeft, dpLeft);
  InternalSetDragItems(ADragItems, dwlRight, dpRight);

end;

procedure TadxExcelTaskPanesCollectionItem.AddCurrentPositionToAllowedDropPositions;
begin
  if (IsDragDropAllowed) then begin
    if (Self.Position <> pUnknown) then begin
      self.FAllowedDropPositions := self.FAllowedDropPositions + [FormsManager.ConvertPositionToAllowedDropPosition(self.Position)];
    end;
  end;
end;

function TadxExcelTaskPanesCollectionItem.ItemRegistryKey: string;
begin
  result := FormsManager.AdxLocalRegistryKey + '\' + self.ClassName + IntToStr(self.Index);
end;

procedure TadxExcelTaskPanesCollectionItem.LoadPositionFromRegistry;
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
          self.Position := TadxExcelTaskPanePosition(Reg.ReadInteger('Position'));
        end;
      end;
    finally
      Reg.CloseKey;
      Reg.Free;
    end;
  end;
end;

procedure TadxExcelTaskPanesCollectionItem.SavePositionToRegistry;
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

procedure TadxExcelTaskPanesCollectionItem.SetIsDragDropAllowed(
  const Value: boolean);
begin
  FIsDragDropAllowed := Value;
  if (FIsDragDropAllowed) then begin
    FAlwaysShowHeader := true;
    AddCurrentPositionToAllowedDropPositions;
  end;
end;

class function TadxExcelTaskPane.GetPositionKey(
  Position: TadxExcelTaskPanePosition): string;
begin
  case Position of
    pUnknown: result:= 'Unknown';
    pBottom:  result:= 'Bottom';
    pRight:   result:= 'Right';
    pLeft:    result:= 'Left';
    pTop:     result:= 'Top';
  end;
end;

procedure TadxExcelTaskPane.InternalSetDragItems(ADragItems: TList;
  dragWindowLayouts: TadxDragWindowLayout;
  AllowedDropPosition: TadxAllowedDropPosition);
var
  itemType: TadxItemType;
  ItemHandle: HWND;
  dragItem: PadxDragItemParams;
begin
  if ((Item.AllowedDropPositions * [AllowedDropPosition]) = [AllowedDropPosition]) then begin
    itemType := stXlMain;

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

function TadxExcelTaskPane.IsDragDropAllowed: boolean;
begin
  result := self.Item.IsDragDropAllowed;
end;

function TadxExcelTaskPane.IsExpandFromMinimizedState: boolean;
begin
  result := Item.RestoreFromMinimizedState;
end;

procedure TadxExcelTaskPane.HideByManager(UsingVisibleProperty: boolean);
begin
  ADXXlHide(true);
end;

class function TadxExcelTaskPanesCollectionItem.ConvertPositionToDesignString(
  Position: TadxExcelTaskPanePosition): string;
begin
  case Position of
    pUnknown: result := 'pUnknown';
    pTop:     result := 'pTop';
    pBottom:  result := 'pBottom';
    pRight:   result := 'pRight';
    pLeft:    result := 'pLeft';
  end;
end;

procedure TadxExcelTaskPanesCollectionItem.SetHideButtonVisible(
  const Value: boolean);
begin
  FIsHiddenStateAllowed := Value;
  if (not FIsHiddenStateAllowed) and (self.DefaultRegionState = rsHidden) then begin
    self.DefaultRegionState := rsMinimized;
  end;
end;

{ TExcelAppWindowBehaviour }

procedure TExcelAppWindowBehaviour.WM_DESTROY(hWnd: THandle; Msg: UINT;
  wParam, lParam: Integer; appWindow: TAppWindow);
var
  awpWindowHandle, awpHostHandle: THandle;
begin
  Log.AddMessage('TExcelAppWindowBehaviour.WM_DESTROY');
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

