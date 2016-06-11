{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{          FireDAC physical layer base classes          }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Phys;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  System.Classes, System.SysUtils, System.SyncObjs, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Util,
    FireDAC.Stan.Error, FireDAC.Stan.Factory,
  FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys.SQLGenerator,
  FireDAC.UI.Intf;

type
  TFDPhysManager = class;
  TFDPhysDriver = class;
  TFDPhysDriverLink = class;
  TFDPhysDriverService = class;
  TFDPhysConnectionHost = class;
  TFDPhysConnection = class;
  TFDPhysTransaction = class;
  TFDPhysEventThread = class;
  TFDPhysEventMessage = class;
  TFDPhysEventStartMessage = class;
  TFDPhysEventStopMessage = class;
  TFDPhysEventAlerter = class;
  TFDPhysCommand = class;
  TFDPhysDriverClass = class of TFDPhysDriver;
  TFDPhysConnectionClass = class of TFDPhysConnection;

  TFDPhysCliHandles = record
    FDriverCliHandles: Pointer;
    FTxSerialID: LongWord;
    FDriverID: array [0 .. 10] of Char;
  end;
  PFDPhysCliHandles = ^TFDPhysCliHandles;

  TFDPhysFindObjMode = (fomNone, fomMBActive, fomMBNotInactive, fomIfActive);
  TFDPhysRecoveryFlags = set of (rfInRecovery, rfEmergencyClose);

  TFDPhysManager = class(TFDObject,
    {$IFNDEF FireDAC_SkipIUnk} IUnknown, {$ENDIF}
    IFDStanObject, IFDStanOptions, IFDPhysManager, IFDPhysManagerMetadata)
  private
    FLock: TCriticalSection;
    FDriverDefs: IFDStanDefinitions;
    FDriverIDs: TFDStringList;
    FRDBMSNames: TFDStringList;
    FDriverClasses: TFDClassList;
    FDriverList: TFDPtrList;
    FDriverLinkList: TFDObjList;
    FState: TFDPhysManagerState;
    FConnectionDefs: IFDStanConnectionDefs;
    FUpdateDriverIDs: Boolean;
    procedure CheckActive;
    procedure CheckActiveOrStoping;
    procedure CleanupDrivers;
    procedure CleanupManager;
    function FindDriverClass(const ADriverID: String): TFDPhysDriverClass;
    function DriverByID(const ADriverID: String;
      AMode: TFDPhysFindObjMode; ARequired: Boolean): TFDPhysDriver;
    procedure InternalClose(ATerminate, AWaitForClose: Boolean);
    procedure Shutdown;
    procedure ErrorDriverNotReg(const ADriverID, ABaseDriverID: String);
    procedure UpdateDriverIDs;
    procedure CheckUpdateDriverIDs;
  protected
    FOptions: IFDStanOptions;
    // IUnknown
    function _Release: Integer; stdcall;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    // IFDStanObject
    function GetName: TComponentName;
    function GetParent: IFDStanObject;
    procedure BeforeReuse;
    procedure AfterReuse;
    procedure SetOwner(const AOwner: TObject; const ARole: TComponentName);
    // IFDStanOptions
    property Options: IFDStanOptions read FOptions implements IFDStanOptions;
    // IFDPhysManager
    procedure CreateDriver(const ADriverID: String;
      out ADrv: IFDPhysDriver; AIntfRequired: Boolean = True);
    procedure CreateConnection(const AConnectionDef: IFDStanConnectionDef;
      out AConn: IFDPhysConnection; AIntfRequired: Boolean = True); overload;
    procedure CreateConnection(const AConDefName: String;
      out AConn: IFDPhysConnection; AIntfRequired: Boolean = True); overload;
    procedure CreateMetadata(out AMeta: IFDPhysManagerMetadata);
    procedure CreateDefaultConnectionMetadata(out AConMeta: IFDPhysConnectionMetadata);
    procedure Open;
    procedure Close(AWait: Boolean = False);
    procedure CloseConnectionDef(const AConnectionDef: IFDStanConnectionDef);
    procedure RefreshMetadataCache;
    function DriverIDFromSharedCliHandle(ASharedCliHandle: Pointer): String;
    procedure RegisterRDBMSKind(AKind: TFDRDBMSKind; const AName: String);
    procedure RegisterDriverClass(ADriverClass: TClass);
    function GetDriverDefs: IFDStanDefinitions;
    function GetConnectionDefs: IFDStanConnectionDefs;
    function GetOptions: IFDStanOptions;
    function GetState: TFDPhysManagerState;
    // IFDPhysManagerMetadata
    function GetDriverCount: Integer;
    function GetDriverID(AIndex: Integer): String;
    function GetBaseDriverID(AIndex: Integer): String; overload;
    function GetBaseDriverID(const ADriverID: String): String; overload;
    function GetBaseDriverClass(const ADriverID: String): TClass;
    function GetRDBMSKind(const ADriverID: String): TFDRDBMSKind;
    function GetRDBMSName(AKind: TFDRDBMSKind): String;
    procedure GetRDBMSNames(ANames: TStrings);
    procedure CreateDriverMetadata(const ADriverID: String; out AMeta: IFDPhysDriverMetadata);
  public
    procedure Initialize; override;
    destructor Destroy; override;
    function FindDriverLink(const ADriverID: String): TFDPhysDriverLink;
  end;

  TFDPhysDriver = class(TInterfacedObject,
    IFDStanObject, IFDPhysDriver, IFDPhysDriverMetadata)
  private
    FLock: TCriticalSection;
    FDriverID: String;
    FParams: IFDStanDefinition;
    FState: TFDPhysDriverState;
    FManager: TFDPhysManager;
    FConnHostList: TFDPtrList;
    FConnectionList: TFDPtrList;
    FMessages: TFDLog;
    FUsageCount: Integer;
    procedure Stop;
    procedure Shutdown;
    function FindConnectionHost(
      const AConnectionDef: IFDStanConnectionDef): TFDPhysConnectionHost;
  protected
    // IFDStanObject
    function GetName: TComponentName;
    function GetParent: IFDStanObject;
    procedure BeforeReuse;
    procedure AfterReuse;
    procedure SetOwner(const AOwner: TObject; const ARole: TComponentName);
    // IFDPhysDriver
    function GetDriverID: String;
    function GetBaseDrvID: String;
    function GetDbKind: TFDRDBMSKind;
    function GetCliObj: Pointer; virtual;
    function GetMessages: TStrings;
    procedure Load;
    procedure Unload;
    procedure Employ;
    procedure Vacate;
    procedure CreateConnection(const AConnectionDef: IFDStanConnectionDef;
      out AConn: IFDPhysConnection);
    procedure CloseConnectionDef(const AConnectionDef: IFDStanConnectionDef);
    procedure CreateMetadata(out ADrvMeta: IFDPhysDriverMetadata);
    procedure CreateConnectionWizard(out AWizard: IFDPhysDriverConnectionWizard);
    function GetConnectionCount: Integer;
    function GetConnections(AIndex: Integer): IFDPhysConnection;
    function GetState: TFDPhysDriverState;
    // IFDPhysDriverMetadata
    function GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable; virtual;
    function GetBaseDrvDesc: String;
    // overridable by descendants
    class function GetBaseDriverID: String; virtual;
    class function GetBaseDriverDesc: String; virtual;
    /// <summary> Returns database kind of this driver. The descendant classes must override this method. </summary>
    class function GetRDBMSKind: TFDRDBMSKind; virtual;
    class function GetConnectionDefParamsClass: TFDConnectionDefParamsClass; virtual;
    procedure InternalLoad; virtual; abstract;
    procedure InternalUnload; virtual; abstract;
    function InternalCreateConnection(AConnHost: TFDPhysConnectionHost): TFDPhysConnection; virtual; abstract;
    procedure GetVendorParams(out AHome, ALib: String);
  public
    constructor Create(AManager: TFDPhysManager; const ADriverDef: IFDStanDefinition); virtual;
    destructor Destroy; override;
    property DriverID: String read FDriverID;
    property BaseDriverID: String read GetBaseDrvID;
    /// <summary> Returns database kind of this driver. </summary>
    property RDBMSKind: TFDRDBMSKind read GetDbKind;
    property State: TFDPhysDriverState read FState;
    property Manager: TFDPhysManager read FManager;
    property Params: IFDStanDefinition read FParams;
    property Messages: TFDLog read FMessages;
  end;

  TFDPhysDriverLink = class(TFDComponent)
  private
    FDriverID: String;
    FVendorHome: String;
    FVendorLib: String;
    FOnDriverDestroying: TNotifyEvent;
    FOnDriverCreated: TNotifyEvent;
    FServiceList: TFDObjList;
    procedure SetDriverID(const AValue: String);
    function GetDriverIntf: IFDPhysDriver;
    function GetDriverState: TFDPhysDriverState;
    function GetServices(AIndex: Integer): TFDPhysDriverService;
    function GetServicesCount: Integer;
    procedure SetupDef(const AParams: IFDStanDefinition);
    procedure SetUpdateDriverIDs;
  protected
    function GetActualDriverID: String; virtual;
    function GetBaseDriverID: String; virtual;
    function IsConfigured: Boolean; virtual;
    procedure ApplyTo(const AParams: IFDStanDefinition); virtual;
    procedure DoDriverCreated; virtual;
    procedure DoDriverDestroying; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Release;
    property DriverState: TFDPhysDriverState read GetDriverState;
    property DriverIntf: IFDPhysDriver read GetDriverIntf;
    property ActualDriverID: String read GetActualDriverID;
    property ServicesCount: Integer read GetServicesCount;
    property Services[AIndex: Integer]: TFDPhysDriverService read GetServices;
  published
    property BaseDriverID: String read GetBaseDriverID;
    property DriverID: String read FDriverID write SetDriverID;
    property VendorHome: String read FVendorHome write FVendorHome;
    property VendorLib: String read FVendorLib write FVendorLib;
    property OnDriverCreated: TNotifyEvent read FOnDriverCreated write FOnDriverCreated;
    property OnDriverDestroying: TNotifyEvent read FOnDriverDestroying write FOnDriverDestroying;
  end;

  TFDPhysServiceProgressEvent = procedure (ASender: TFDPhysDriverService; const AMessage: String) of object;
  TFDPhysDriverService = class (TFDComponent, IFDStanErrorHandler)
  private
    FDriverLink: TFDPhysDriverLink;
    FActive: Boolean;
    FOnError: TFDErrorEvent;
    FStreamingActive: Boolean;
    FBeforeExecute: TNotifyEvent;
    FAfterExecute: TNotifyEvent;
    procedure SetActive(const AValue: Boolean);
    procedure SetDriverLink(const AValue: TFDPhysDriverLink);
    function GetCliObj: TObject;
  protected
    // TComponent
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
    // introduced
    function GetActualActive: Boolean; virtual;
    procedure CheckActive(AAutoActivate, ANeedActivation: Boolean); virtual;
    procedure InternalUninstall; virtual;
    procedure InternalInstall; virtual;
    procedure InternalExecute; virtual;
    procedure DoBeforeExecute; virtual;
    procedure DoAfterExecute; virtual;
    // IFDStanErrorHandler
    procedure HandleException(const AInitiator: IFDStanObject;
      var AException: Exception);
    // must be strong-typed by descendants
    property DriverLink: TFDPhysDriverLink read FDriverLink write SetDriverLink;
    // for static services
    property ActualActive: Boolean read GetActualActive;
    property Active: Boolean read FActive write SetActive default False;
    // for dynamic services
    procedure Execute;
  public
    destructor Destroy; override;
    property CliObj: TObject read GetCliObj;
  published
    property OnError: TFDErrorEvent read FOnError write FOnError;
    property BeforeExecute: TNotifyEvent read FBeforeExecute write FBeforeExecute;
    property AfterExecute: TNotifyEvent read FAfterExecute write FAfterExecute;
  end;

  TFDPhysConnectionHost = class(TInterfacedObject,
    {$IFNDEF FireDAC_SkipIUnk} IUnknown, {$ENDIF}
    IFDStanObjectHost)
  private
    [Weak] FDriverObj: TFDPhysDriver;
    FConnectionDef: IFDStanConnectionDef;
    FConnectionCount: Integer;
    FPool: IFDStanObjectFactory;
    FPassCode: LongWord;
{$IFDEF FireDAC_MONITOR}
    FMonitor: IFDMoniClient;
    FInitialTracing: Boolean;
    procedure AddMoniClient;
{$ENDIF}
    procedure Employ;
    procedure Vacate;
  protected
    // IUnknown
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    // IFDStanObjectHost
    function GetObjectKindName: TComponentName;
    procedure CreateObject(out AObject: IFDStanObject);
    // other
  public
    constructor Create(ADriver: TFDPhysDriver; const AConnectionDef: IFDStanConnectionDef);
    destructor Destroy; override;
    procedure CreateConnection(out AConn: IFDPhysConnection);
    property ConnectionDef: IFDStanConnectionDef read FConnectionDef;
  end;

  TFDPhysConnection = class(TInterfacedObject,
    {$IFNDEF FireDAC_SkipIUnk} IUnknown, {$ENDIF}
    IFDMoniAdapter, IFDStanObject, IFDStanOptions, IFDStanErrorHandler,
    IFDPhysConnection)
  private
    FDriver: IFDPhysDriver;
    [Weak] FDriverObj: TFDPhysDriver;
    FConnHost: TFDPhysConnectionHost;
    FLock: TCriticalSection;
    FErrorHandler: IFDStanErrorHandler;
    FRecoveryHandler: IFDPhysConnectionRecoveryHandler;
    FMetadata: TObject;
    FLogin: IFDGUIxLoginDialog;
    FLoginPrompt: Boolean;
    FPreparedCommands: Integer;
    FInternalConnectionDef: IFDStanConnectionDef;
    FPoolManaged: Boolean;
    FMoniAdapterHelper: TFDMoniAdapterHelper;
    FSharedHandle: PFDPhysCliHandles;
    FTransaction: IFDPhysTransaction;
    [Weak] FTransactionObj: TFDPhysTransaction;
    FRecoveryFlags: TFDPhysRecoveryFlags;
    FCliHandles: TFDPhysCliHandles;
{$IFDEF FireDAC_MONITOR}
    procedure UpdateMonitor;
{$ENDIF}
    procedure CheckInactive;
    procedure CheckActive(ADisconnectingAllowed: Boolean = False);
    procedure IncPrepared(ACommand: TFDPhysCommand);
    procedure DecPrepared;
    procedure ConnectBase;
    procedure DoConnect;
    procedure DoLogin;
    procedure CheckTransaction;
    procedure AllocTransactionHandles;
    procedure ReleaseTransactionHandles;
    procedure DisconnectTransactions;
    procedure DisconnectCommands;
    function GetDriverID: String;
    procedure DisconnectEvents;
    procedure RecoverConnection(const AInitiator: IFDStanObject; AOnLogin: Boolean);
  public
    // IUnknown
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  protected
    FOptions: IFDStanOptions;
{$IFDEF FireDAC_MONITOR}
    FMonitor: IFDMoniClient;
    FTracing: Boolean;
{$ENDIF}
    // IFDMoniAdapter
    function GetHandle: LongWord;
    function GetItemCount: Integer; virtual;
    procedure GetItem(AIndex: Integer; out AName: String; out AValue: Variant;
      out AKind: TFDMoniAdapterItemKind); virtual;
    function GetSupportItems: TFDMoniAdapterItemKinds; virtual;
    // IFDStanObject
    function GetName: TComponentName;
    function GetParent: IFDStanObject;
    procedure BeforeReuse;
    procedure AfterReuse;
    procedure SetOwner(const AOwner: TObject; const ARole: TComponentName);
    // IFDStanOptions
    property Options: IFDStanOptions read FOptions implements IFDStanOptions;
    procedure GetParentOptions(var AOpts: IFDStanOptions);
    // IFDStanErrorHandler
    procedure HandleException(const AInitiator: IFDStanObject;
      var AException: Exception);
    // IFDPhysConnection
    function GetDriver: IFDPhysDriver;
    function GetState: TFDPhysConnectionState;
    function GetOptions: IFDStanOptions;
    function GetCommandCount: Integer;
    function GetCommands(AIndex: Integer): IFDPhysCommand;
    function GetErrorHandler: IFDStanErrorHandler;
    function GetRecoveryHandler: IFDPhysConnectionRecoveryHandler;
    function GetLogin: IFDGUIxLoginDialog;
    function GetLoginPrompt: Boolean;
    function GetConnectionDef: IFDStanConnectionDef;
    function GetMessages: EFDDBEngineException; virtual;
    function GetCliObj: Pointer; virtual;
    function GetCliHandle: Pointer;
    function GetSharedCliHandle: Pointer;
    function GetTransaction: IFDPhysTransaction;
    function GetTransactionCount: Integer;
    function GetTransactions(AIndex: Integer): IFDPhysTransaction;
    function GetCurrentCatalog: String;
    function GetCurrentSchema: String;
    function GetEventCount: Integer;
    function GetEvents(AIndex: Integer): IFDPhysEventAlerter;
    procedure SetOptions(const AValue: IFDStanOptions);
    procedure SetErrorHandler(const AValue: IFDStanErrorHandler);
    procedure SetRecoveryHandler(const AValue: IFDPhysConnectionRecoveryHandler);
    procedure SetLogin(const AValue: IFDGUIxLoginDialog);
    procedure SetLoginPrompt(const AValue: Boolean);
    procedure SetSharedCliHandle(AValue: Pointer);
    procedure SetTransaction(const AValue: IFDPhysTransaction);
    procedure SetCurrentCatalog(const AValue: String);
    procedure SetCurrentSchema(const AValue: String);
    procedure CreateMetadata(out AConnMeta: IFDPhysConnectionMetadata);
    procedure CreateCommandGenerator(out AGen: IFDPhysCommandGenerator;
      const ACommand: IFDPhysCommand);
    procedure CreateCommand(out ACmd: IFDPhysCommand);
    procedure CreateMetaInfoCommand(out AMetaCmd: IFDPhysMetaInfoCommand);
    procedure CreateTransaction(out ATx: IFDPhysTransaction);
    procedure CreateEvent(const AEventKind: String; out AEvent: IFDPhysEventAlerter);
    procedure Open;
    procedure Close;
    procedure ForceDisconnect;
    function Ping: Boolean;
    procedure ChangePassword(const ANewPassword: String);
    function GetLastAutoGenValue(const AName: String = ''): Variant; virtual;
    procedure SaveLastAutoGenValue(const AValue: Variant);
    function Clone: IFDPhysConnection;
    procedure AnalyzeSession(AMessages: TStrings); virtual;
{$IFDEF FireDAC_MONITOR}
    procedure TracingChanged;
    function GetTracing: Boolean;
    procedure SetTracing(AValue: Boolean);
    function GetMonitor: IFDMoniClient;
    procedure TraceList(AList: TStrings; const AName: String);
    procedure TraceConnInfo(AKind: TFDMoniAdapterItemKind; const AName: String);
{$ENDIF}
  protected
    // overridable by descendants
    procedure InternalConnect; virtual; abstract;
    procedure InternalSetMeta; virtual;
    procedure InternalDisconnect; virtual; abstract;
    procedure InternalPing; virtual;
    function InternalCreateMetadata: TObject; virtual; abstract;
    function InternalCreateTransaction: TFDPhysTransaction; virtual; abstract;
    function InternalCreateEvent(const AEventKind: String): TFDPhysEventAlerter; virtual;
    function InternalCreateCommand: TFDPhysCommand; virtual; abstract;
    function InternalCreateMetaInfoCommand: TFDPhysCommand; virtual;
    function InternalCreateCommandGenerator(
      const ACommand: IFDPhysCommand): TFDPhysCommandGenerator; virtual; abstract;
    procedure InternalChangePassword(
      const AUserName, AOldPassword, ANewPassword: String); virtual;
{$IFDEF FireDAC_MONITOR}
    procedure InternalTracingChanged; virtual;
{$ENDIF}
    procedure InternalOverrideNameByCommand(
      var AParsedName: TFDPhysParsedName; const ACommand: IFDPhysCommand); virtual;
    procedure InternalExecuteDirect(
      const ASQL: String; ATransaction: TFDPhysTransaction); virtual; abstract;
    function InternalGetCurrentCatalog: String; virtual;
    function InternalGetCurrentSchema: String; virtual;
    function InternalGetCliHandle: Pointer; virtual;
    function InternalGetSharedCliHandle: Pointer; virtual;
    procedure InternalAnalyzeSession(AMessages: TStrings); virtual;
  protected
    FState: TFDPhysConnectionState;
    FCommandList: TFDPtrList;
    FTransactionList: TFDPtrList;
    FEventList: TFDPtrList;
    FDefaultSchema,
    FDefaultCatalog,
    FCurrentCatalog,
    FCurrentSchema: String;
    FAvoidImplicitMeta,
    FRemoveDefaultMeta: TFDPhysNameParts;
    FLastAutoGenValue: Variant;
{$IFDEF FireDAC_MONITOR}
    procedure Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
      const AMsg: String; const AArgs: array of const);
{$ENDIF}
  public
    constructor Create(ADriverObj: TFDPhysDriver; AConnHost: TFDPhysConnectionHost); virtual;
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
    property DriverObj: TFDPhysDriver read FDriverObj;
    property TransactionObj: TFDPhysTransaction read FTransactionObj;
    property ConnectionDef: IFDStanConnectionDef read GetConnectionDef;
    property CliObj: Pointer read GetCliObj;
    property DefaultSchema: String read FDefaultSchema;
    property DefaultCatalog: String read FDefaultCatalog;
    property AvoidImplicitMeta: TFDPhysNameParts read FAvoidImplicitMeta;
    property RemoveDefaultMeta: TFDPhysNameParts read FRemoveDefaultMeta;
    property DriverID: String read GetDriverID;
  end;

  TFDPhysTxNotification = (
    cpBeforeCmdPrepare, cpAfterCmdPrepareSuccess, cpAfterCmdPrepareFailure,
    cpAfterCmdUnprepare,
    cpBeforeCmdExecute, cpAfterCmdExecuteSuccess, cpAfterCmdExecuteFailure);

  TFDPhysTransaction = class(TInterfacedObject,
    IFDMoniAdapter, IFDStanObject, IFDStanErrorHandler,
    IFDPhysTransaction)
  private
    FConnection: IFDPhysConnection;
    [Weak] FConnectionObj: TFDPhysConnection;
    FOptions,
    FExternalOptions: TFDTxOptions;
    FSavepoints: TFDStringList;
    FSerialID: LongWord;
    FMoniAdapterHelper: TFDMoniAdapterHelper;
    FRetaining: Boolean;
    FCommandList: TFDPtrList;
    FState: TFDPhysTransactionState;
    FStateHandlerList: TInterfaceList;
    FPrevAutoStop: Boolean;
    FExplicitActive: Boolean;
    FLockAutoStopCount: Integer;
    FNotifyCount: Integer;
    FSharedActive: Boolean;
{$IFDEF FireDAC_MONITOR}
    procedure UpdateMonitor;
{$ENDIF}
    function GetCLIAutoCommit: Boolean;
    function GetDriverID: String;
    procedure TxOperation(AOperation: TFDPhysTransactionState;
      ABefore: Boolean);
  protected
    // IFDMoniAdapter
    function GetHandle: LongWord;
    function GetItemCount: Integer; virtual;
    procedure GetItem(AIndex: Integer; out AName: String; out AValue: Variant;
      out AKind: TFDMoniAdapterItemKind); virtual;
    function GetSupportItems: TFDMoniAdapterItemKinds; virtual;
    // IFDStanObject
    function GetName: TComponentName;
    function GetParent: IFDStanObject;
    procedure BeforeReuse;
    procedure AfterReuse;
    procedure SetOwner(const AOwner: TObject; const ARole: TComponentName);
    // IFDStanErrorHandler
    procedure HandleException(const AInitiator: IFDStanObject;
      var AException: Exception);
    // IFDPhysTransaction
    function GetOptions: TFDTxOptions;
    function GetActive: Boolean;
    function GetTopSerialID: LongWord;
    function GetSerialID: LongWord;
    function GetNestingLevel: LongWord;
    function GetConnection: IFDPhysConnection;
    function GetCliObj: Pointer; virtual;
    function GetState: TFDPhysTransactionState;
    procedure SetOptions(const AValue: TFDTxOptions);
    function StartTransaction: LongWord;
    procedure Commit;
    procedure CommitRetaining;
    procedure Rollback;
    procedure RollbackRetaining;
    procedure LockAutoStop;
    procedure UnlockAutoStop(ASuccess, AAllowStop: Boolean);
    procedure AddStateHandler(const AHandler: IFDPhysTransactionStateHandler);
    procedure RemoveStateHandler(const AHandler: IFDPhysTransactionStateHandler);
    procedure Disconnect;
  protected
    FIDAutoCommit: LongWord;
    // overridable by descendants
    procedure InternalStartTransaction(AID: LongWord); virtual; abstract;
    procedure InternalCommit(AID: LongWord); virtual; abstract;
    procedure InternalRollback(AID: LongWord); virtual; abstract;
    procedure InternalSetSavepoint(const AName: String); virtual;
    procedure InternalRollbackToSavepoint(const AName: String); virtual;
    procedure InternalCommitSavepoint(const AName: String); virtual;
    procedure InternalChanged; virtual;
    procedure InternalAllocHandle; virtual;
    procedure InternalReleaseHandle; virtual;
    procedure InternalSelect; virtual;
    procedure InternalUnSelect; virtual;
    procedure InternalNotify(ANotification: TFDPhysTxNotification;
      ACommandObj: TFDPhysCommand); virtual;
    procedure InternalCheckState(ACommandObj: TFDPhysCommand; ASuccess: Boolean); virtual;
    // other
    procedure Update;
    procedure DisconnectCommands(AFilter: TFDPhysDisconnectFilter;
      AMode: TFDPhysDisconnectMode);
    procedure Stop(ASuccess: Boolean);
    procedure CheckStoping(AAllowUnprepare, AForce, ASuccess: Boolean);
    procedure Notify(ANotification: TFDPhysTxNotification;
      ACommandObj: TFDPhysCommand);
    procedure TransactionFinished;
    procedure TransactionStarted;
    procedure ReleaseHandleBase;
  public
    constructor Create(AConnection: TFDPhysConnection); virtual;
    destructor Destroy; override;
    property ConnectionObj: TFDPhysConnection read FConnectionObj;
    property Retaining: Boolean read FRetaining;
    property CLIAutoCommit: Boolean read GetCLIAutoCommit;
    property DriverID: String read GetDriverID;
  end;

  TFDPhysEventThread = class(TFDThread)
  private
    FAlerter: TFDPhysEventAlerter;
  protected
    procedure DoTimeout; override;
    class function GetStartMsgClass: TFDThreadMsgClass; override;
    class function GetStopMsgClass: TFDThreadMsgClass; override;
  public
    constructor Create(AAlerter: TFDPhysEventAlerter);
  end;

  TFDPhysEventMessage = class(TFDThreadMsgBase)
  private
    FMsgThread: TFDPhysEventThread;
    procedure BasePerform;
  public
    function Perform(AThread: TFDThread): Boolean; override;
  end;

  TFDPhysEventStartMessage = class(TFDThreadStartMsg)
  public
    function Perform(AThread: TFDThread): Boolean; override;
  end;

  TFDPhysEventStopMessage = class(TFDThreadStopMsg)
  public
    function Perform(AThread: TFDThread): Boolean; override;
  end;

  TFDPhysEventAlerter = class(TInterfacedObject,
    IFDMoniAdapter, IFDStanObject, IFDStanErrorHandler,
    IFDPhysEventAlerter)
  private
    FConnection: IFDPhysConnection;
    [Weak] FConnectionObj: TFDPhysConnection;
    FKind: String;
    FState: TFDPhysEventAlerterState;
    FNames: TFDStringList;
    FSubscriptionName: String;
    FHandler: IFDPhysEventHandler;
    FOptions,
    FExternalOptions: TFDEventAlerterOptions;
    FMoniAdapterHelper: TFDMoniAdapterHelper;
    function GetDriverID: String;
    procedure DoNamesChanging(ASender: TObject);
    procedure DoTimeout;
    procedure MarkChangeHandlers(const AHandler: IFDPhysChangeHandler;
      AModified: Boolean);
    function AreChangeHandlersModified: Boolean;
{$IFDEF FireDAC_MONITOR}
    procedure UpdateMonitor;
{$ENDIF}
  protected
    FMsgThread: TFDThread;
    /// <summary> The list of associated IFDPhysChangeHandler change handlers. </summary>
    FChangeHandlers: TInterfaceList;
    /// <summary> The list of associated IFDPhysChangeHandler change handler names. </summary>
    FChangeHandlerNames: TFDStringList;
    function IsRunning: Boolean;
    procedure SetupCommand(const ACmd: IFDPhysCommand);
    // IFDMoniAdapter
    function GetHandle: LongWord;
    function GetItemCount: Integer; virtual;
    procedure GetItem(AIndex: Integer; out AName: String; out AValue: Variant;
      out AKind: TFDMoniAdapterItemKind); virtual;
    function GetSupportItems: TFDMoniAdapterItemKinds; virtual;
    // IFDStanObject
    function GetName: TComponentName;
    function GetParent: IFDStanObject;
    procedure BeforeReuse;
    procedure AfterReuse;
    procedure SetOwner(const AOwner: TObject; const ARole: TComponentName);
    // IFDStanErrorHandler
    procedure HandleException(const AInitiator: IFDStanObject;
      var AException: Exception);
    // IFDPhysEventAlerter
    function GetConnection: IFDPhysConnection;
    function GetState: TFDPhysEventAlerterState;
    function GetKind: String;
    function GetOptions: TFDEventAlerterOptions;
    function GetNames: TStrings;
    function GetSubscriptionName: String;
    function GetHandler: IFDPhysEventHandler;
    procedure SetOptions(const AValue: TFDEventAlerterOptions);
    procedure SetNames(const AValue: TStrings);
    procedure SetSubscriptionName(const AValue: String);
    procedure SetHandler(const AValue: IFDPhysEventHandler);
    procedure Register;
    procedure Unregister;
    procedure Signal(const AEvent: String; const AArgument: Variant);
    procedure Refresh(const AHandler: IFDPhysChangeHandler; AForce: Boolean);
    procedure AddChangeHandler(const AHandler: IFDPhysChangeHandler);
    procedure RemoveChangeHandler(const AHandler: IFDPhysChangeHandler);
    procedure AbortJob;
    // overridable by descendants
    procedure InternalAllocHandle; virtual;
    procedure InternalReleaseHandle; virtual;
    procedure InternalHandle(AEventMessage: TFDPhysEventMessage); virtual; abstract;
    procedure InternalAbortJob; virtual;
    procedure InternalRegister; virtual;
    procedure InternalUnregister; virtual;
    procedure InternalSignal(const AEvent: String; const AArgument: Variant); virtual; abstract;
    /// <summary> Implements driver specific refreshing of a change handler. Is called
    ///  from Refresh method as result of direct method call or a change notification. </summary>
    procedure InternalRefresh(const AHandler: IFDPhysChangeHandler); virtual;
    /// <summary> Implements driver specific event notification handling. Is called
    ///  as result of processing of the change notifications queue. </summary>
    procedure InternalHandleEvent(const AEventName: String; const AArgument: Variant); virtual;
    /// <summary> Implements driver specific timeout handling. Is called
    ///  as result of timeout processing of the change notifications queue. </summary>
    procedure InternalHandleTimeout(var AContinue: Boolean); virtual;
    /// <summary> Implements driver specific change handler registration. Is called
    ///  from AddChangeHandler / RemoveChangeHandler methods. </summary>
    procedure InternalChangeHandlerModified(const AHandler: IFDPhysChangeHandler;
      const AEventName: String; AOperation: TOperation); virtual;
  public
    constructor Create(AConnection: TFDPhysConnection; const AKind: String); virtual;
    destructor Destroy; override;
    property ConnectionObj: TFDPhysConnection read FConnectionObj;
    property DriverID: String read GetDriverID;
  end;

  TFDPhysDataTableInfo = record
    FSourceName: String;
    FSourceID: Integer;
    FOriginName: String;
    FArraySize: Integer;
  end;

  TFDPhysDataColumnInfo = record
    FParentTableSourceID: Integer;
    FTableSourceID: Integer;
    FSourceName: String;
    FSourceID: Integer;
    FSourceTypeName: String;
    FSourceType: TFDDataType;
    FOriginTabName: TFDPhysParsedName;
    FOriginColName: String;
    FType: TFDDataType;
    FLen: LongWord;
    FPrec: Integer;
    FScale: Integer;
    FAttrs: TFDDataAttributes;
    FForceAddOpts,
    FForceRemOpts: TFDDataOptions;
  end;

  TFDPhysCommand = class(TInterfacedObject,
    {$IFNDEF FireDAC_SkipIUnk} IUnknown, {$ENDIF}
    IFDMoniAdapter, IFDStanObject, IFDStanOptions, IFDStanErrorHandler,
    IFDPhysCommand, IFDPhysMetaInfoCommand)
  private
    FBaseObjectName: String;
    FSchemaName: String;
    FCatalogName: string;
    FCommandText: String;
    FCommandKind: TFDPhysCommandKind;
    FFixedCommandKind: Boolean;
    FMacros: TFDMacros;
    FParams: TFDParams;
    FObjectScopes: TFDPhysObjectScopes;
    FTableKinds: TFDPhysTableKinds;
    FWildcard: String;
    FExecutor: IFDStanAsyncExecutor;
    FState: TFDPhysCommandState;
    FThreadID: TThreadID;
    FSourceObjectName: String;
    FSourceRecordSetName: String;
    FRecordSetIndex: Integer;
    FOverload: Word;
    FEof: Boolean;
    FFirstFetch: Boolean;
    FNextRecordSet: Boolean;
    FErrorHandler: IFDStanErrorHandler;
    FExecuteCount: Integer;
    FStateHandler: IFDPhysCommandStateHandler;
    FRowsAffected: TFDCounter;
    FRowsAffectedReal: Boolean;
    FErrorAction: TFDErrorAction;
    FMappingHandler: IFDPhysMappingHandler;
    FMoniAdapterHelper: TFDMoniAdapterHelper;
{$IFDEF FireDAC_MONITOR}
    procedure UpdateMonitor;
{$ENDIF}
    procedure CheckState(ARequiredState: TFDPhysCommandState);
    function DoDefineDataTable(ADatSManager: TFDDatSManager; ATable: TFDDatSTable;
      ARootID: Integer; const ARootName: String; AMetaInfoMergeMode: TFDPhysMetaInfoMergeMode): TFDDatSTable;
    procedure PreprocessCommand(ACreateParams, ACreateMacros,
      AExpandParams, AExpandMacros, AExpandEscapes, AParseSQL: Boolean);
    function CheckMetaAvailability: Boolean;
    procedure OpenBase;
    procedure FetchBase(ATable: TFDDatSTable; AAll: Boolean);
    procedure ExecuteBase(ATimes, AOffset: Integer);
    procedure BeginDefine;
    function GetParamsOwner: TPersistent;
    function GetDriverID: String;
    procedure CheckPreprocessCommand(ACreateParams: Boolean);
    procedure ExecuteTask(const AOperation: IFDStanAsyncOperation;
      const AHandler: IFDStanAsyncHandler; ABlocked: Boolean);
  protected
    FOptions: IFDStanOptions;
    // IFDStanObject
    function GetName: TComponentName;
    function GetParent: IFDStanObject;
    procedure BeforeReuse;
    procedure AfterReuse;
    procedure SetOwner(const AOwner: TObject; const ARole: TComponentName);
    // IFDStanErrorHandler
    procedure HandleException(const AInitiator: IFDStanObject;
      var AException: Exception);
    // IFDStanOptions
    property Options: IFDStanOptions read FOptions implements IFDStanOptions;
    procedure GetParentOptions(var AOpts: IFDStanOptions);
    // IFDMoniAdapter
    function GetHandle: LongWord;
    function GetItemCount: Integer; virtual;
    procedure GetItem(AIndex: Integer; out AName: String; out AValue: Variant;
      out AKind: TFDMoniAdapterItemKind); virtual;
    function GetSupportItems: TFDMoniAdapterItemKinds; virtual;
    // IFDPhysCommand
    function GetSchemaName: String;
    function GetCatalogName: String;
    function GetBaseObjectName: String;
    function GetConnection: IFDPhysConnection;
    function GetOptions: IFDStanOptions;
    function GetState: TFDPhysCommandState;
    function GetCommandText: String;
    function GetCommandKind: TFDPhysCommandKind;
    function GetParams: TFDParams;
    function GetOverload: Word;
    function GetNextRecordSet: Boolean;
    function GetErrorHandler: IFDStanErrorHandler;
    function GetSourceObjectName: String;
    function GetSourceRecordSetName: String;
    function GetMacros: TFDMacros;
    function GetRowsAffected: TFDCounter;
    function GetRowsAffectedReal: Boolean;
    function GetErrorAction: TFDErrorAction;
    function GetMappingHandler: IFDPhysMappingHandler;
    function GetSQLOrderByPos: Integer;
    function GetCliObj: Pointer; virtual;
    function GetTransaction: IFDPhysTransaction;
    function GetSQLText: String;
    function GetStateHandler: IFDPhysCommandStateHandler;
    procedure SetSchemaName(const AValue: String);
    procedure SetCatalogName(const AValue: String);
    procedure SetBaseObjectName(const AValue: String);
    procedure SetOptions(const AValue: IFDStanOptions);
    procedure SetCommandText(const AValue: String);
    procedure SetCommandKind(const AValue: TFDPhysCommandKind);
    procedure SetSourceObjectName(const AValue: String);
    procedure SetSourceRecordSetName(const AValue: String);
    procedure SetNextRecordSet(const AValue: Boolean);
    procedure SetErrorHandler(const AValue: IFDStanErrorHandler);
    procedure SetOverload(const AValue: Word);
    procedure SetMappingHandler(const AValue: IFDPhysMappingHandler);
    procedure SetState(const AValue: TFDPhysCommandState);
    procedure SetTransaction(const AValue: IFDPhysTransaction);
    procedure SetStateHandler(const AValue: IFDPhysCommandStateHandler);
    procedure SetMacros(AValue: TFDMacros);
    procedure SetParams(AValue: TFDParams);
    procedure AbortJob(const AWait: Boolean = False);
    function Define(ADatSManager: TFDDatSManager; ATable: TFDDatSTable = nil;
      AMetaInfoMergeMode: TFDPhysMetaInfoMergeMode = mmReset): TFDDatSTable; overload;
    function Define(ATable: TFDDatSTable;
      AMetaInfoMergeMode: TFDPhysMetaInfoMergeMode = mmReset): TFDDatSTable; overload;
    procedure Execute(ATimes: Integer = 0; AOffset: Integer = 0;
      ABlocked: Boolean = False);
    procedure Fetch(ATable: TFDDatSTable; AAll: Boolean = True;
      ABlocked: Boolean = False); overload;
    procedure Fetch(ADatSManager: TFDDatSManager;
      AMetaInfoMergeMode: TFDPhysMetaInfoMergeMode = mmReset); overload;
    procedure CloseStreams;
    procedure Preprocess;
    procedure Prepare(const ACommandText: String = ''; ACreateParams: Boolean = True);
    procedure Unprepare;
    procedure Open(ABlocked: Boolean = False);
    procedure Close;
    procedure CloseAll;
    procedure Disconnect;
    procedure CheckAsyncProgress;
    // IFDPhysMetaInfoCommand
    function GetMetaInfoKind: TFDPhysMetaInfoKind;
    procedure SetMetaInfoKind(AValue: TFDPhysMetaInfoKind);
    function GetTableKinds: TFDPhysTableKinds;
    procedure SetTableKinds(AValue: TFDPhysTableKinds);
    function GetWildcard: String;
    procedure SetWildcard(const AValue: String);
    function GetObjectScopes: TFDPhysObjectScopes;
    procedure SetObjectScopes(AValue: TFDPhysObjectScopes);
  protected
    [Weak] FConnectionObj: TFDPhysConnection;
    FConnection: IFDPhysConnection;
    [Weak] FTransactionObj: TFDPhysTransaction;
    FTransaction: IFDPhysTransaction;
    FDbCommandText: String;
    FMetaInfoKind: TFDPhysMetaInfoKind;
    FBuffer: TFDBuffer;
    FSQLValuesPos: Integer;
    FSQLValuesPosEnd: Integer;
    FSQLOrderByPos: Integer;
    FSQLLimitSkip,
    FSQLLimitRows: Integer;
    FRecordsFetched: Integer;
    // utils
    function GetTraceCommandText(const ACmd: String = ''): String;
{$IFDEF FireDAC_MONITOR}
    procedure Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
      const AMsg: String; const AArgs: array of const);
    function EnterTrace(AConnObj: TFDPhysConnection): Boolean;
    function ExitTrace(AConnObj: TFDPhysConnection; var AUpdateMonitor: Boolean): Boolean;
{$ENDIF}
    function CheckFetchColumn(ADataType: TFDDataType; AAttributes: TFDDataAttributes): Boolean; overload;
    procedure CheckParamMatching(AParam: TFDParam;
      ADataType: TFieldType; AParamType: TParamType; APrec: Integer);
    procedure CreateCommandGenerator(out AGen: IFDPhysCommandGenerator);
    function OpenBlocked: Boolean;
    procedure GenerateStoredProcParams(const AName: TFDPhysParsedName;
      AOverload: Word = 0);
    procedure GenerateStoredProcCall(const AName: TFDPhysParsedName;
      ASPUsage: TFDPhysCommandKind = skStoredProc);
    procedure GetSelectMetaInfoParams(out AName: TFDPhysParsedName);
    procedure GenerateSelectMetaInfo(const AName: TFDPhysParsedName);
    procedure GenerateLimitSelect();
    procedure GenerateParamMarkers();
    procedure ColTypeMapError(AColumn: TFDDatSColumn);
    procedure ParTypeMapError(AParam: TFDParam);
    procedure ParTypeUnknownError(AParam: TFDParam);
    procedure ParDefChangedError(ADataType: TFieldType; AParam: TFDParam);
    procedure ParSetChangedError(AExpected, AActual: Integer);
    procedure UnsupParamObjError(AParam: TFDParam);
    procedure CheckMetaInfoParams(const AName: TFDPhysParsedName);
    procedure CheckExact(AUseRecsMax: Boolean; ATimes, AOffset: Integer;
      AValue: TFDCounter; AFetch: Boolean);
    // overridables
    procedure InternalAbort; virtual;
    procedure InternalPrepare; virtual; abstract;
    procedure InternalUnprepare; virtual; abstract;
    function InternalOpen: Boolean; virtual; abstract;
    function InternalNextRecordSet: Boolean; virtual; abstract;
    procedure InternalClose; virtual; abstract;
    procedure InternalExecute(ATimes, AOffset: Integer; var ACount: TFDCounter); virtual; abstract;
    procedure InternalCloseStreams; virtual;
    function InternalUseStandardMetadata: Boolean; virtual;
    function InternalColInfoStart(var ATabInfo: TFDPhysDataTableInfo): Boolean; virtual; abstract;
    function InternalColInfoGet(var AColInfo: TFDPhysDataColumnInfo): Boolean; virtual; abstract;
    function InternalFetchRowSet(ATable: TFDDatSTable; AParentRow: TFDDatSRow;
      ARowsetSize: LongWord): LongWord; virtual; abstract;
  public
    constructor Create(AConnection: TFDPhysConnection);
    destructor Destroy; override;
    property DriverID: String read GetDriverID;
  end;

var
  FDPhysManagerObj: TFDPhysManager;

implementation

uses
  System.Variants, System.Generics.Defaults, System.Generics.Collections,
    System.Types,
  FireDAC.Stan.Consts, FireDAC.Stan.ResStrs,
  FireDAC.Phys.SQLPreprocessor, FireDAC.Phys.Meta;

const
  CFOMs: array[Boolean] of TFDPhysFindObjMode = (fomIfActive, fomMBActive);

{ ----------------------------------------------------------------------------- }
{ TFDPhysManager                                                                }
{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.Initialize;
begin
  inherited Initialize;
  FLock := TCriticalSection.Create;
  FDPhysManagerObj := Self;
  FOptions := TFDOptionsContainer.Create(nil, TFDFetchOptions,
    TFDUpdateOptions, TFDTopResourceOptions, nil);
  FDriverIDs := TFDStringList.Create;
  FRDBMSNames := TFDStringList.Create(dupError, True, False);
  RegisterRDBMSKind(TFDRDBMSKinds.Other, S_FD_Other_RDBMS);
  FDriverClasses := TFDClassList.Create;
  FDriverList := TFDPtrList.Create;
  FDriverLinkList := TFDObjList.Create;
end;

{ ----------------------------------------------------------------------------- }
destructor TFDPhysManager.Destroy;
begin
  CleanupManager;
  FDriverDefs := nil;
  FConnectionDefs := nil;
  FDFreeAndNil(FDriverList);
  FDFreeAndNil(FDriverLinkList);
  FDFreeAndNil(FDriverClasses);
  FDFreeAndNil(FDriverIDs);
  FDFreeAndNil(FRDBMSNames);
  _AddRef;
  FOptions := nil;
  inherited Destroy;
  FDPhysManagerObj := nil;
  FDFreeAndNil(FLock);
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager._Release: Integer;
begin
  Result := FDDecRef;
  if Result = 0 then
    Shutdown;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  Result := inherited QueryInterface(IID, Obj);
  CheckUpdateDriverIDs;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager.GetOptions: IFDStanOptions;
begin
  Result := Self as IFDStanOptions;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager.GetConnectionDefs: IFDStanConnectionDefs;
begin
  if FConnectionDefs = nil then
    FDCreateInterface(IFDStanConnectionDefs, FConnectionDefs);
  Result := FConnectionDefs;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager.GetDriverDefs: IFDStanDefinitions;
begin
  if FDriverDefs = nil then begin
    FDCreateInterface(IFDStanDefinitions, FDriverDefs);
    FDriverDefs.Name := S_FD_DefDrvFileName;
    FDriverDefs.Storage.DefaultFileName := S_FD_DefDrvFileName;
    FDriverDefs.Storage.GlobalFileName := FDReadRegValue(S_FD_DrvValName);
  end;
  Result := FDriverDefs;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager.GetState: TFDPhysManagerState;
begin
  Result := FState;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.CheckActive;
begin
  if FState <> dmsActive then
    FDException(Self, [S_FD_LPhys], er_FD_AccDrvMngrMB, ['Active']);
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.CheckActiveOrStoping;
begin
  if not (FState in [dmsActive, dmsStoping, dmsTerminating]) then
    FDException(Self, [S_FD_LPhys], er_FD_AccDrvMngrMB, ['Active or Stoping']);
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.RegisterRDBMSKind(AKind: TFDRDBMSKind; const AName: String);
begin
  if FRDBMSNames.IndexOf(AName) = -1 then
    FRDBMSNames.AddInt(AName, AKind);
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.RegisterDriverClass(ADriverClass: TClass);
begin
  FDriverClasses.Add(TFDPhysDriverClass(ADriverClass));
  FUpdateDriverIDs := True;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.Open;
begin
  GetConnectionDefs;
  GetDriverDefs;
  FState := dmsActive;
  FUpdateDriverIDs := True;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.CleanupDrivers;
var
  i: Integer;
  [Weak] oDrv: TFDPhysDriver;
begin
  FLock.Enter;
  try
    for i := FDriverList.Count - 1 downto 0 do begin
      oDrv := TFDPhysDriver(FDriverList[i]);
      if oDrv.FState in [drsRegistered, drsLoaded, drsActive] then
        oDrv.Shutdown;
    end;
  finally
    FLock.Leave;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.CleanupManager;
begin
  FLock.Enter;
  try
    if FDriverDefs <> nil then
      FDriverDefs.Clear;
    if FConnectionDefs <> nil then
      FConnectionDefs.Clear;
    FState := dmsInactive;
  finally
    FLock.Leave;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.InternalClose(ATerminate, AWaitForClose: Boolean);
var
  i: Integer;
  lStop, lTimeOut, lFree: Boolean;
  iStartTime: Cardinal;
begin
  lStop := False;
  lFree := False;
  lTimeOut := False;
  try
    FLock.Enter;
    try
      if (FState = dmsInactive) and not ATerminate then
        Exit;
      if ATerminate and (FState in [dmsStoping, dmsInactive]) then begin
        lFree := (FState = dmsInactive) and (RefCount = 0);
        FState := dmsTerminating;
      end
      else begin
        if FState <> dmsInactive then begin
          CheckActive;
          lStop := True;
        end;
        if ATerminate then
          FState := dmsTerminating
        else
          FState := dmsStoping;
      end;
      if lStop then
        for i := 0 to FDriverList.Count - 1 do
          TFDPhysDriver(FDriverList[i]).Stop;
    finally
      FLock.Leave;
    end;
  finally
    iStartTime := TThread.GetTickCount();
    while not lTimeOut and (FDriverList.Count > 0) do begin
      lTimeOut := FDTimeout(iStartTime, C_FD_PhysManagerShutdownTimeout);
      CleanupDrivers;
      Sleep(1);
    end;
    if FDriverList.Count = 0 then
      if FState = dmsTerminating then
        lFree := True
      else if FState = dmsStoping then
        CleanupManager;
    if lTimeOut then
      FDException(nil, [S_FD_LPhys], er_FD_AccShutdownTO, []);
    if lFree then
      FDFree(Self);
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.Close(AWait: Boolean);
begin
  InternalClose(False, AWait);
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.Shutdown;
begin
  InternalClose(True, True);
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.ErrorDriverNotReg(const ADriverID, ABaseDriverID: String);
var
  sDrvID, s: String;
begin
  if ABaseDriverID <> '' then
    sDrvID := ABaseDriverID
  else
    sDrvID := ADriverID;
  if (CompareText(sDrvID, S_FD_TDBXId) = 0) or
     (CompareText(sDrvID, S_FD_ODBCId) = 0) or
     (CompareText(sDrvID, S_FD_MSSQLId) = 0) or
     (CompareText(sDrvID, S_FD_MSAccId) = 0) or
     (CompareText(sDrvID, S_FD_DB2Id) = 0) or
     (CompareText(sDrvID, S_FD_MySQLId) = 0) or
     (CompareText(sDrvID, S_FD_OraId) = 0) or
     (CompareText(sDrvID, S_FD_ASAId) = 0) or
     (CompareText(sDrvID, S_FD_ADSId) = 0) or
     (CompareText(sDrvID, S_FD_IBId) = 0) or
     (CompareText(sDrvID, S_FD_IBLiteId) = 0) or
     (CompareText(sDrvID, S_FD_FBId) = 0) or
     (CompareText(sDrvID, S_FD_PGId) = 0) or
     (CompareText(sDrvID, S_FD_SQLiteId) = 0) or
     (CompareText(sDrvID, S_FD_DSId) = 0) or
     (CompareText(sDrvID, S_FD_InfxId) = 0) or
     (CompareText(sDrvID, S_FD_TDataId) = 0) or
     (CompareText(sDrvID, S_FD_MongoId) = 0) then
    s := Format(S_FD_AccSrcNotFoundExists, [UpperCase(ABaseDriverID)])
  else
    s := Format(S_FD_AccSrcNotFoundNotExists, [UpperCase(ADriverID), S_FD_DefDrvFileName]);
  FDException(Self, [S_FD_LPhys], er_FD_AccSrvNotFound, [ADriverID, s]);
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager.FindDriverClass(const ADriverID: String): TFDPhysDriverClass;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FDriverClasses.Count - 1 do
    if CompareText(TFDPhysDriverClass(FDriverClasses[i]).GetBaseDriverID, ADriverID) = 0 then begin
      Result := TFDPhysDriverClass(FDriverClasses[i]);
      Break;
    end;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager.FindDriverLink(const ADriverID: String): TFDPhysDriverLink;
var
  i: Integer;
begin
  Result := nil;
  FLock.Enter;
  try
    for i := 0 to FDriverLinkList.Count - 1 do
      if CompareText(TFDPhysDriverLink(FDriverLinkList[i]).ActualDriverID, ADriverID) = 0 then begin
        Result := TFDPhysDriverLink(FDriverLinkList[i]);
        Exit;
      end;
  finally
    FLock.Leave;
  end;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager.DriverByID(const ADriverID: String;
  AMode: TFDPhysFindObjMode; ARequired: Boolean): TFDPhysDriver;
var
  oDef: IFDStanDefinition;
  oDrvClass: TFDPhysDriverClass;
  oLink: TFDPhysDriverLink;
  sBaseDriverID: String;
  i: Integer;
begin
  if ADriverID = '' then
    FDException(Self, [S_FD_LPhys], er_FD_AccSrvNotDefined, []);

  sBaseDriverID := '';
  FLock.Enter;
  try
    case AMode of
    fomNone:
      ;
    fomMBActive:
      CheckActive;
    fomMBNotInactive:
      CheckActiveOrStoping;
    fomIfActive:
      if FState <> dmsActive then begin
        Result := nil;
        Exit;
      end;
    end;

    Result := nil;
    for i := 0 to FDriverList.Count - 1 do
      if CompareText(TFDPhysDriver(FDriverList[i]).FDriverID, ADriverID) = 0 then begin
        Result := TFDPhysDriver(FDriverList[i]);
        Break;
      end;

    if (Result = nil) and ARequired then begin
      oDef := GetDriverDefs.FindDefinition(ADriverID);
      if oDef = nil then begin
        oDef := GetDriverDefs.Add;
        oDef.Name := ADriverID;
      end;

      oLink := FindDriverLink(ADriverID);
      if oLink <> nil then
        oLink.SetupDef(oDef);

      sBaseDriverID := oDef.AsString[C_FD_DrvBaseId];
      if sBaseDriverID = '' then
        sBaseDriverID := oDef.Name;
      oDrvClass := FindDriverClass(sBaseDriverID);

      if oDrvClass <> nil then
        Result := oDrvClass.Create(Self, oDef);
    end;

  finally
    FLock.Leave;
  end;

  if Result = nil then begin
    if ARequired then
      ErrorDriverNotReg(ADriverID, sBaseDriverID);
  end
  else
    Result.FLock.Enter;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.CreateDriver(const ADriverID: String;
  out ADrv: IFDPhysDriver; AIntfRequired: Boolean);
var
  oDrv: TFDPhysDriver;
begin
  ADrv := nil;
  oDrv := DriverByID(ADriverID, CFOMs[AIntfRequired], True);
  if oDrv <> nil then begin
    ADrv := oDrv as IFDPhysDriver;
    oDrv.FLock.Leave;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.CreateConnection(const AConnectionDef: IFDStanConnectionDef;
  out AConn: IFDPhysConnection; AIntfRequired: Boolean);
var
  oDrv: TFDPhysDriver;
begin
  ASSERT(AConnectionDef <> nil);
  AConn := nil;
  GetConnectionDefs.BeginRead;
  try
    oDrv := DriverByID(AConnectionDef.Params.DriverID, CFOMs[AIntfRequired], True);
    if oDrv <> nil then
      try
        oDrv.CreateConnection(AConnectionDef, AConn);
      finally
        oDrv.FLock.Leave;
      end;
  finally
    GetConnectionDefs.EndRead;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.CreateConnection(const AConDefName: String;
  out AConn: IFDPhysConnection; AIntfRequired: Boolean);
var
  oDef: IFDStanConnectionDef;
begin
  if Pos('=', AConDefName) <> 0 then begin
    oDef := GetConnectionDefs.AddTemporary as IFDStanConnectionDef;
    oDef.ParseString(AConDefName);
  end
  else
    oDef := GetConnectionDefs.ConnectionDefByName(AConDefName);
  CreateConnection(oDef, AConn, AIntfRequired);
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.CreateMetadata(out AMeta: IFDPhysManagerMetadata);
begin
  Supports(TObject(Self), IFDPhysManagerMetadata, AMeta);
  ASSERT(Assigned(AMeta));
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.CreateDefaultConnectionMetadata(
  out AConMeta: IFDPhysConnectionMetadata);
begin
  AConMeta := TFDPhysConnectionMetadata.Create(nil, 0, 0, False) as IFDPhysConnectionMetadata;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.CreateDriverMetadata(const ADriverID: String;
  out AMeta: IFDPhysDriverMetadata);
var
  oDrv: IFDPhysDriver;
begin
  CreateDriver(ADriverID, oDrv);
  oDrv.CreateMetadata(AMeta);
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.RefreshMetadataCache;
var
  i, j: Integer;
  oDrv: TFDPhysDriver;
  oConnMeta: IFDPhysConnectionMetadata;
begin
  FLock.Enter;
  try
    for i := 0 to FDriverList.Count - 1 do begin
      oDrv := TFDPhysDriver(FDriverList[i]);
      for j := 0 to oDrv.GetConnectionCount - 1 do
        if Supports(oDrv.GetConnections(j), IFDPhysConnectionMetadata, oConnMeta) then
          oConnMeta.RefreshMetadataCache;
    end;
  finally
    FLock.Leave;
  end;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager.DriverIDFromSharedCliHandle(ASharedCliHandle: Pointer): String;
begin
  if ASharedCliHandle = nil then
    Result := ''
  else
    Result := String(PFDPhysCliHandles(ASharedCliHandle)^.FDriverID);
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.CloseConnectionDef(const AConnectionDef: IFDStanConnectionDef);
var
  oDrv: TFDPhysDriver;
begin
  ASSERT(AConnectionDef <> nil);
  oDrv := DriverByID(AConnectionDef.Params.DriverID, fomIfActive, False);
  if oDrv <> nil then
    try
      oDrv.CloseConnectionDef(AConnectionDef);
    finally
      oDrv.FLock.Leave;
    end;
end;

{ ----------------------------------------------------------------------------- }
// IFDPhysManagerMetadata

procedure TFDPhysManager.CheckUpdateDriverIDs;
begin
  FLock.Enter;
  try
    if FUpdateDriverIDs then begin
      FUpdateDriverIDs := False;
      UpdateDriverIDs;
    end;
  finally
    FLock.Leave;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.UpdateDriverIDs;
var
  i: Integer;
  oDef: IFDStanDefinition;
  oLink: TFDPhysDriverLink;
  sID, sBaseID: String;
begin
  FDriverIDs.Clear;
  FDriverIDs.Sorted := True;
  FDriverIDs.Duplicates := dupIgnore;
  for i := 0 to GetDriverDefs.Count - 1 do
    FDriverIDs.Add(GetDriverDefs[i].Name);
  for i := 0 to FDriverLinkList.Count - 1 do
    FDriverIDs.Add(TFDPhysDriverLink(FDriverLinkList[i]).ActualDriverID);
  for i := 0 to FDriverClasses.Count - 1 do
    FDriverIDs.Add(TFDPhysDriverClass(FDriverClasses[i]).GetBaseDriverID);
  FDriverIDs.Sorted := False;
  for i := FDriverIDs.Count - 1 downto 0 do begin
    sID := FDriverIDs[i];
    sBaseID := '';
    oDef := GetDriverDefs.FindDefinition(sID);
    if oDef <> nil then
      sBaseID := oDef.AsString[C_FD_DrvBaseId]
    else begin
      oLink := FindDriverLink(sID);
      if oLink <> nil then
        sBaseID := oLink.BaseDriverID;
    end;
    if sBaseID = '' then
      sBaseID := sID;
    if FindDriverClass(sBaseID) = nil then
      FDriverIDs.Delete(i)
    else
      FDriverIDs[i] := sID + '=' + sBaseID;
  end;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager.GetDriverCount: Integer;
begin
  Result := FDriverIDs.Count;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager.GetDriverID(AIndex: Integer): String;
begin
  Result := FDriverIDs.KeyNames[AIndex];
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager.GetBaseDriverID(AIndex: Integer): String;
begin
  Result := FDriverIDs.ValueFromIndex[AIndex];
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager.GetBaseDriverID(const ADriverID: String): String;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to FDriverIDs.Count - 1 do
    if CompareText(GetDriverID(i), ADriverID) = 0 then begin
      Result := GetBaseDriverID(i);
      Break;
    end;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager.GetBaseDriverClass(const ADriverID: String): TClass;
var
  sId: String;
begin
  sId := GetBaseDriverID(ADriverID);
  if sId <> '' then
    Result := FindDriverClass(sId)
  else
    Result := nil;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager.GetRDBMSKind(const ADriverID: String): TFDRDBMSKind;
var
  oDrvClass: TFDPhysDriverClass;
  i: Integer;
begin
  Result := TFDRDBMSKinds.Unknown;
  oDrvClass := TFDPhysDriverClass(GetBaseDriverClass(ADriverID));
  if oDrvClass <> nil then
    Result := oDrvClass.GetRDBMSKind
  else begin
    i := FRDBMSNames.IndexOf(ADriverID);
    if i <> -1 then
      Result := TFDRDBMSKind(FRDBMSNames.Ints[i]);
  end;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager.GetRDBMSName(AKind: TFDRDBMSKind): String;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to FRDBMSNames.Count - 1 do
    if TFDRDBMSKind(FRDBMSNames.Ints[i]) = AKind then begin
      Result := FRDBMSNames[i];
      Break;
    end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.GetRDBMSNames(ANames: TStrings);
begin
  ANames.SetStrings(FRDBMSNames);
end;

{ ----------------------------------------------------------------------------- }
// IFDStanObject

function TFDPhysManager.GetName: TComponentName;
begin
  Result := ClassName;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysManager.GetParent: IFDStanObject;
begin
  Result := nil;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.AfterReuse;
begin
  // nothing
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.BeforeReuse;
begin
  // nothing
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysManager.SetOwner(const AOwner: TObject;
  const ARole: TComponentName);
begin
  // nothing
end;

{ ----------------------------------------------------------------------------- }
{ TFDPhysConnectionDefParams                                                    }
{ ----------------------------------------------------------------------------- }
type
  TFDPhysConnectionDefParams = class(TInterfacedObject, IFDStanConnectionDefParams)
  private
    FClass: TFDConnectionDefParamsClass;
  protected
    // IFDStanConnectionDefParams
    function CreateParams(const ADef: IFDStanDefinition): TObject;
  public
    constructor Create(AClass: TFDConnectionDefParamsClass);
  end;

{ ----------------------------------------------------------------------------- }
constructor TFDPhysConnectionDefParams.Create(AClass: TFDConnectionDefParamsClass);
begin
  inherited Create;
  FClass := AClass;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnectionDefParams.CreateParams(const ADef: IFDStanDefinition): TObject;
begin
  Result := FClass.Create(ADef);
end;

{ ----------------------------------------------------------------------------- }
{ TFDPhysConnectionDefParamsFactory                                             }
{ ----------------------------------------------------------------------------- }
type
  TFDPhysConnectionDefParamsFactory = class(TFDMultyInstanceFactory)
  protected
    function CreateObject(const AProvider: String): TObject; override;
    function Match(const AIID: TGUID; const AProvider: String;
      AValidate: Boolean): Boolean; override;
  public
    constructor Create;
  end;

{ ----------------------------------------------------------------------------- }
constructor TFDPhysConnectionDefParamsFactory.Create;
begin
  inherited Create(nil, IFDStanConnectionDefParams);
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnectionDefParamsFactory.CreateObject(const AProvider: String): TObject;
var
  oMeta: IFDPhysManagerMetadata;
begin
  Supports(FDPhysManager, IFDPhysManagerMetadata, oMeta);
  Result := TFDPhysConnectionDefParams.Create(
    TFDPhysDriverClass(oMeta.GetBaseDriverClass(AProvider)).GetConnectionDefParamsClass);
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnectionDefParamsFactory.Match(const AIID: TGUID;
  const AProvider: String; AValidate: Boolean): Boolean;
var
  oMeta: IFDPhysManagerMetadata;
begin
  Result := IsEqualGUID(AIID, IFDStanConnectionDefParams) and
    Supports(FDPhysManager, IFDPhysManagerMetadata, oMeta) and
    (oMeta.GetBaseDriverClass(AProvider) <> nil);
end;

{ ----------------------------------------------------------------------------- }
{ TFDPhysDriver                                                                 }
{ ----------------------------------------------------------------------------- }
constructor TFDPhysDriver.Create(AManager: TFDPhysManager; const ADriverDef: IFDStanDefinition);
var
  oParentDef: IFDStanDefinition;
  sBaseDriverID: String;
begin
  inherited Create;
  // Pins the driver in the manager
  _AddRef;
  FState := drsUnknown;
  FManager := AManager;
  FManager.FLock.Enter;
  FManager.FDriverList.Add(Self);
  FManager.FLock.Leave;
  FLock := TCriticalSection.Create;
  FDriverID := ADriverDef.Name;
  sBaseDriverID := ADriverDef.AsString[C_FD_DrvBaseId];
  if (sBaseDriverID <> '') and (sBaseDriverID <> FDriverID) then begin
    if ADriverDef.ParentDefinition = nil then begin
      oParentDef := AManager.GetDriverDefs.FindDefinition(sBaseDriverID);
      if (oParentDef <> nil) and (ADriverDef <> oParentDef) then
        ADriverDef.ParentDefinition := oParentDef;
    end;
  end;
  FParams := ADriverDef;
  FState := drsRegistered;
  FConnHostList := TFDPtrList.Create;
  FConnectionList := TFDPtrList.Create;
  FMessages := TFDLog.Create;
end;

{ ----------------------------------------------------------------------------- }
destructor TFDPhysDriver.Destroy;
var
  i: Integer;
begin
  Shutdown;
  for i := FConnHostList.Count - 1 downto 0 do
    FDFree(TFDPhysConnectionHost(FConnHostList[i]));
  FDFreeAndNil(FConnHostList);
  FDFreeAndNil(FConnectionList);
  FManager.FLock.Enter;
  FManager.FDriverList.Remove(Self);
  FManager.FLock.Leave;
  FState := drsUnknown;
  FParams := nil;
  FManager := nil;
  FDFreeAndNil(FLock);
  FDFreeAndNil(FMessages);
  inherited Destroy;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriver.GetDriverID: String;
begin
  Result := FDriverID;
end;

{ ----------------------------------------------------------------------------- }
class function TFDPhysDriver.GetBaseDriverID: String;
begin
  Result := '';
  ASSERT(False);
end;

{ ----------------------------------------------------------------------------- }
class function TFDPhysDriver.GetBaseDriverDesc: String;
begin
  Result := '';
  ASSERT(False);
end;

{ ----------------------------------------------------------------------------- }
class function TFDPhysDriver.GetRDBMSKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.Unknown;
  ASSERT(False);
end;

{ ----------------------------------------------------------------------------- }
class function TFDPhysDriver.GetConnectionDefParamsClass: TFDConnectionDefParamsClass;
begin
  Result := nil;
  ASSERT(False);
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriver.GetBaseDrvID: String;
begin
  Result := GetBaseDriverID;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriver.GetBaseDrvDesc: String;
begin
  Result := GetBaseDriverDesc;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriver.GetDbKind: TFDRDBMSKind;
begin
  Result := GetRDBMSKind;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriver.GetState: TFDPhysDriverState;
begin
  Result := FState;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriver.GetCliObj: Pointer;
begin
  Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDriver.GetMessages: TStrings;
begin
  Result := Messages;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriver.GetConnectionCount: Integer;
begin
  Result := FConnectionList.Count;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriver.GetConnections(AIndex: Integer): IFDPhysConnection;
begin
  FLock.Enter;
  try
    Result := TFDPhysConnection(FConnectionList[AIndex]) as IFDPhysConnection;
  finally
    FLock.Leave;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriver.Stop;
var
  i: Integer;
  oConnHost: TFDPhysConnectionHost;
begin
  FLock.Enter;
  try
    for i := 0 to FConnHostList.Count - 1 do begin
      oConnHost := TFDPhysConnectionHost(FConnHostList[i]);
      if oConnHost.FPool <> nil then
        oConnHost.FPool.Close;
    end;
    if FState <> drsActive then
      Exit;
    if FRefCount <= 1 then begin
      FState := drsLoaded;
      Exit;
    end;
    FState := drsStoping;
    for i := FConnectionList.Count - 1 downto 0 do
      TFDPhysConnection(FConnectionList[i]).ForceDisconnect;
  finally
    FLock.Leave;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriver.Unload;
var
  oLink: TFDPhysDriverLink;
begin
  FLock.Enter;
  try
    if FState <> drsLoaded then
      Exit;
    oLink := FManager.FindDriverLink(FDriverID);
    if oLink <> nil then
      oLink.DoDriverDestroying;
    try
      InternalUnload;
    except
      // not visible
    end;
    FState := drsRegistered;
  finally
    FLock.Leave;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriver.Shutdown;
var
  lLeave: Boolean;
begin
  lLeave := True;
  FLock.Enter;
  try
    Stop;
    Unload;
    if (FState = drsRegistered) and (FRefCount = 1) then
      lLeave := _Release > 0;
  finally
    if lLeave then
      FLock.Leave;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriver.Load;
var
  oLink: TFDPhysDriverLink;
begin
  FLock.Enter;
  try
    if FState <> drsRegistered then
      Exit;
    oLink := FManager.FindDriverLink(FDriverID);
    FMessages.Clear;
    FMessages.Start('Loading driver ' + FDriverID);
    try
      try
        FState := drsLoading;
        if oLink <> nil then
          oLink.SetupDef(FParams);
        InternalLoad;
        FState := drsLoaded;
      except
        on E: Exception do begin
          FState := drsRegistered;
          FMessages.Msg('Error: ' + E.Message);
          raise;
        end;
      end;
    finally
      FMessages.Stop;
    end;
    if oLink <> nil then
      oLink.DoDriverCreated;
  finally
    FLock.Leave;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriver.Employ;
begin
  FLock.Enter;
  try
    Load;
    if AtomicIncrement(FUsageCount) = 1 then
      if FState = drsLoaded then
        FState := drsActive;
  finally
    FLock.Leave;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriver.Vacate;
begin
  FLock.Enter;
  try
    if AtomicDecrement(FUsageCount) = 0 then
      if FState in [drsActive, drsStoping] then
        FState := drsLoaded;
  finally
    FLock.Leave;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriver.GetVendorParams(out AHome, ALib: String);
begin
  if Params <> nil then begin
    AHome := Params.AsXString[S_FD_DrvVendorHome];
    ALib := Params.AsXString[S_FD_DrvVendorLib];
  end
  else begin
    AHome := '';
    ALib := '';
  end;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriver.FindConnectionHost(
  const AConnectionDef: IFDStanConnectionDef): TFDPhysConnectionHost;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FConnHostList.Count - 1 do
    if TFDPhysConnectionHost(FConnHostList[i]).FConnectionDef = AConnectionDef then begin
      Result := TFDPhysConnectionHost(FConnHostList[i]);
      Break;
    end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriver.CreateConnection(const AConnectionDef: IFDStanConnectionDef;
  out AConn: IFDPhysConnection);
var
  oConnHost: TFDPhysConnectionHost;
begin
  ASSERT(AConnectionDef <> nil);
  FLock.Enter;
  try
    oConnHost := FindConnectionHost(AConnectionDef);
    if oConnHost = nil then
      oConnHost := TFDPhysConnectionHost.Create(Self, AConnectionDef);
    oConnHost.CreateConnection(AConn);
  finally
    FLock.Leave;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriver.CloseConnectionDef(const AConnectionDef: IFDStanConnectionDef);
var
  oConnHost: TFDPhysConnectionHost;
begin
  ASSERT(AConnectionDef <> nil);
  FLock.Enter;
  try
    oConnHost := FindConnectionHost(AConnectionDef);
    if oConnHost <> nil then begin
      if oConnHost.FPool <> nil then
        oConnHost.FPool.Close;
      FDFree(oConnHost);
    end;
  finally
    FLock.Leave;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriver.CreateMetadata(out ADrvMeta: IFDPhysDriverMetadata);
begin
  Supports(TObject(Self), IFDPhysDriverMetadata, ADrvMeta);
  ASSERT(Assigned(ADrvMeta));
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriver.CreateConnectionWizard(
  out AWizard: IFDPhysDriverConnectionWizard);
begin
  Supports(TObject(Self), IFDPhysDriverConnectionWizard, AWizard);
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriver.GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable;
var
  i: Integer;
  s: String;
begin
  if AParams = nil then begin
    AParams := TFDDatSTable.Create;
    AParams.Columns.Add('ID', dtInt32).AutoIncrement := True;
    AParams.Columns.Add('Name', dtWideString).Size := C_FD_DefStrSize;
    AParams.Columns.Add('Type', dtWideString).Size := C_FD_DefMaxStrSize;
    AParams.Columns.Add('DefVal', dtWideString).Size := C_FD_DefStrSize;
    AParams.Columns.Add('Caption', dtWideString).Size := C_FD_DefStrSize;
    AParams.Columns.Add('LoginIndex', dtInt32);
  end;
  Result := AParams;

  s := '';
  for i := 0 to FManager.FDriverList.Count - 1 do begin
    if s <> '' then
      s := s + ';';
    s := s + TFDPhysDriver(FManager.FDriverList[i]).DriverID;
  end;
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_DriverID, s, GetDriverID, S_FD_ConnParam_Common_DriverID, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_Pooled, '@L', S_FD_False, S_FD_ConnParam_Common_Pooled, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_Database, '@S', '', S_FD_ConnParam_Common_Database, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_UserName, '@S', '', S_FD_ConnParam_Common_BDEStyleUserName, 0]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_Password, '@P', '', S_FD_ConnParam_Common_Password, 1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MonitorBy, S_FD_MoniFlatFile + ';' + S_FD_MoniRemote + ';' + S_FD_MoniCustom, '', S_FD_ConnParam_Common_MonitorBy, -1]);
  if (AKeys <> nil) and
     (CompareText(AKeys.Values[S_FD_ConnParam_Common_Pooled], S_FD_True) = 0) then begin
    Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_Pool_CleanupTimeout, '@I', IntToStr(C_FD_PoolCleanupTimeout), S_FD_ConnParam_Common_Pool_CleanupTimeout, -1]);
    Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_Pool_ExpireTimeout, '@I', IntToStr(C_FD_PoolExpireTimeout), S_FD_ConnParam_Common_Pool_ExpireTimeout, -1]);
    Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_Pool_MaximumItems, '@I', IntToStr(C_FD_PoolMaximumItems), S_FD_ConnParam_Common_Pool_MaximumItems, -1]);
  end;
end;

{ ----------------------------------------------------------------------------- }
// IFDStanObject

function TFDPhysDriver.GetName: TComponentName;
begin
  Result := GetDriverID;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriver.GetParent: IFDStanObject;
begin
  Supports(FDPhysManager, IFDStanObject, Result);
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriver.AfterReuse;
begin
  // nothing
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriver.BeforeReuse;
begin
  // nothing
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriver.SetOwner(const AOwner: TObject;
  const ARole: TComponentName);
begin
  // nothing
end;

{ ----------------------------------------------------------------------------- }
{ TFDPhysDriverLink                                                             }
{ ----------------------------------------------------------------------------- }
constructor TFDPhysDriverLink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDPhysManager();
  FDPhysManagerObj.FLock.Enter;
  FDPhysManagerObj.FDriverLinkList.Add(Self);
  FDPhysManagerObj.FLock.Leave;
  FServiceList := TFDObjList.Create;
  SetUpdateDriverIDs;
end;

{ ----------------------------------------------------------------------------- }
destructor TFDPhysDriverLink.Destroy;
var
  i: Integer;
begin
  for i := FServiceList.Count - 1 downto 0 do
    TFDPhysDriverService(FServiceList[i]).DriverLink := nil;
  if FDPhysManagerObj <> nil then begin
    FDPhysManagerObj.FLock.Enter;
    FDPhysManagerObj.FDriverLinkList.Remove(Self);
    FDPhysManagerObj.FLock.Leave;
  end;
  FDFreeAndNil(FServiceList);
  SetUpdateDriverIDs;
  inherited Destroy;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverLink.SetDriverID(const AValue: String);
begin
  if FDriverID <> AValue then begin
    FDriverID := AValue;
    SetUpdateDriverIDs;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverLink.SetUpdateDriverIDs;
begin
  if FDPhysManagerObj <> nil then
    FDPhysManagerObj.FUpdateDriverIDs := True;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriverLink.GetBaseDriverID: String;
begin
  ASSERT(False);
  Result := '';
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriverLink.GetActualDriverID: String;
begin
  if DriverID = '' then
    Result := BaseDriverID
  else
    Result := DriverID;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriverLink.GetDriverIntf: IFDPhysDriver;
begin
  FDPhysManager.CreateDriver(ActualDriverID, Result, True);
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriverLink.GetDriverState: TFDPhysDriverState;
var
  oDrv: TFDPhysDriver;
begin
  Result := drsUnknown;
  if FDPhysManagerObj <> nil then begin
    oDrv := FDPhysManagerObj.DriverByID(ActualDriverID, fomIfActive, False);
    if oDrv <> nil then begin
      Result := oDrv.State;
      oDrv.FLock.Leave;
    end;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverLink.Release;
var
  oDrv: TFDPhysDriver;
begin
  if FDPhysManagerObj <> nil then begin
    oDrv := FDPhysManagerObj.DriverByID(ActualDriverID, fomIfActive, False);
    if oDrv <> nil then
      try
        if oDrv.GetConnectionCount > 0 then
          FDException(Self, [S_FD_LPhys], er_FD_AccCannotReleaseDrv, [ActualDriverID]);
      finally
        if oDrv._Release > 0 then
          oDrv.FLock.Leave;
      end;
  end;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriverLink.IsConfigured: Boolean;
begin
  Result := (FVendorHome <> '') or (FVendorLib <> '') or (FDriverID <> '');
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverLink.ApplyTo(const AParams: IFDStanDefinition);
begin
  if FVendorHome <> '' then
    AParams.AsString[S_FD_DrvVendorHome] := FVendorHome;
  if FVendorLib <> '' then
    AParams.AsString[S_FD_DrvVendorLib] := FVendorLib;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverLink.SetupDef(const AParams: IFDStanDefinition);
begin
  SetUpdateDriverIDs;
  AParams.AsString[C_FD_DrvBaseId] := BaseDriverID;
  if IsConfigured then
    ApplyTo(AParams);
  AParams.MarkUnchanged;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriverLink.GetServices(AIndex: Integer): TFDPhysDriverService;
begin
  Result := TFDPhysDriverService(FServiceList[AIndex]);
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriverLink.GetServicesCount: Integer;
begin
  Result := FServiceList.Count;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverLink.DoDriverCreated;
var
  i: Integer;
  oSvc: TFDPhysDriverService;
begin
  if Assigned(FOnDriverCreated) then
    FOnDriverCreated(Self);
  for i := 0 to FServiceList.Count - 1 do begin
    oSvc := TFDPhysDriverService(FServiceList[i]);
    if oSvc.ActualActive then
      oSvc.InternalInstall;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverLink.DoDriverDestroying;
var
  i: Integer;
  oSvc: TFDPhysDriverService;
begin
  for i := 0 to FServiceList.Count - 1 do begin
    oSvc := TFDPhysDriverService(FServiceList[i]);
    if oSvc.ActualActive then
      oSvc.InternalUnInstall;
  end;
  if Assigned(FOnDriverDestroying) then
    FOnDriverDestroying(Self);
end;

{ ----------------------------------------------------------------------------- }
{ TFDPhysDriverService                                                          }
{ ----------------------------------------------------------------------------- }
destructor TFDPhysDriverService.Destroy;
begin
  Active := False;
  DriverLink := nil;
  inherited Destroy;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverService.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = DriverLink then
      DriverLink := nil;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriverService.GetActualActive: Boolean;
begin
  Result := (DriverLink <> nil) and Active;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverService.CheckActive(AAutoActivate, ANeedActivation: Boolean);
begin
  if DriverLink = nil then
    FDException(Self, [S_FD_LPhys], er_FD_SvcLinkMBSet, []);
  if AAutoActivate and not Active then
    Active := True;
  if ANeedActivation and not Active then
    FDException(Self, [S_FD_LPhys, DriverLink.ActualDriverID], er_FD_SvcMBActive, []);
  if FDPhysManager().State = dmsInactive then
    FDPhysManager().Open;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverService.SetActive(const AValue: Boolean);
begin
  if FActive <> AValue then
    if csReading in ComponentState then
      FStreamingActive := AValue
    else begin
      FActive := AValue;
      if DriverLink <> nil then
        if AValue then begin
          if DriverLink.DriverState in [drsLoaded, drsActive] then
            InternalInstall;
        end
        else
          InternalUninstall;
    end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverService.Loaded;
begin
  inherited Loaded;
  if FStreamingActive then
    Active := True;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverService.SetDriverLink(const AValue: TFDPhysDriverLink);
begin
  if FDriverLink <> AValue then begin
    Active := False;
    if FDriverLink <> nil then
      FDriverLink.FServiceList.Remove(Self);
    FDriverLink := AValue;
    if FDriverLink <> nil then
      FDriverLink.FServiceList.Add(Self);
  end;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysDriverService.GetCliObj: TObject;
begin
  Result := DriverLink.DriverIntf.CliObj;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverService.HandleException(const AInitiator: IFDStanObject;
  var AException: Exception);
begin
  if Assigned(FOnError) then
    FOnError(Self, AInitiator as TObject, AException);
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverService.Execute;
var
  oDrv: IFDPhysDriver;
  oWait: IFDGUIxWaitCursor;
begin
  FDCreateInterface(IFDGUIxWaitCursor, oWait);
  oWait.StartWait;
  try
    DoBeforeExecute;
    CheckActive(False, False);
    oDrv := DriverLink.DriverIntf;
    try
      oDrv.Employ;
      try
        InternalExecute;
      finally
        oDrv.Vacate;
      end;
    finally
      oDrv := nil;
    end;
    DoAfterExecute;
  finally
    oWait.StopWait;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverService.InternalInstall;
begin
  // nothing
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverService.InternalUninstall;
begin
  // nothing
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverService.InternalExecute;
begin
  // nothing
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverService.DoBeforeExecute;
begin
  if Assigned(BeforeExecute) then
    BeforeExecute(Self);
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysDriverService.DoAfterExecute;
begin
  if Assigned(AfterExecute) then
    AfterExecute(Self);
end;

{ ----------------------------------------------------------------------------- }
{ TFDPhysConnectionHost                                                         }
{ ----------------------------------------------------------------------------- }
constructor TFDPhysConnectionHost.Create(ADriver: TFDPhysDriver;
  const AConnectionDef: IFDStanConnectionDef);
begin
  inherited Create;
  FDriverObj := ADriver;
  FDriverObj.FLock.Enter;
  FDriverObj.FConnHostList.Add(Self);
  FDriverObj.FLock.Leave;
  FPassCode := Random($7FFFFFFF);
  FConnectionDef := AConnectionDef;
{$IFDEF FireDAC_MONITOR}
  FInitialTracing := True;
  if FConnectionDef.Params.MonitorBy <> mbNone then
    AddMoniClient;
{$ENDIF}
  if FConnectionDef.Params.Pooled and not FDIsDesignTime then begin
    if FConnectionDef.Style <> atTemporary then
      FConnectionDef.ToggleUpdates(FPassCode, True, True);
    FDCreateInterface(IFDStanObjectFactory, FPool);
    FPool.Open(Self, FConnectionDef);
  end
  else
    if FConnectionDef.Style <> atTemporary then
      FConnectionDef.ToggleUpdates(FPassCode, True, False);
end;

{ ----------------------------------------------------------------------------- }
destructor TFDPhysConnectionHost.Destroy;
begin
  ASSERT(FConnectionCount = 0);
  FDriverObj.FLock.Enter;
  FDriverObj.FConnHostList.Remove(Self);
  FDriverObj.FLock.Leave;
  if FConnectionDef.Style = atTemporary then begin
    if FConnectionDef.ParentDefinition <> nil then
      FConnectionDef.ParentDefinition := nil;
  end
  else
    FConnectionDef.ToggleUpdates(FPassCode, False, False);
  FPassCode := 0;
  FDriverObj := nil;
  FConnectionDef := nil;
  FPool := nil;
{$IFDEF FireDAC_MONITOR}
  FMonitor := nil;
{$ENDIF}  
  inherited Destroy;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnectionHost._AddRef: Integer;
begin
  Result := -1;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnectionHost._Release: Integer;
begin
  Result := -1;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnectionHost.Employ;
begin
  if AtomicIncrement(FConnectionCount) = 1 then
    if FConnectionDef.Style <> atTemporary then
      FConnectionDef.ToggleUpdates(FPassCode, True, True);
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnectionHost.Vacate;
begin
  if AtomicDecrement(FConnectionCount) = 0 then
    if FConnectionDef.Style <> atTemporary then
      FConnectionDef.ToggleUpdates(FPassCode, True, False)
    else if not FConnectionDef.Params.Pooled then
      FDFree(Self);
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnectionHost.GetObjectKindName: TComponentName;
begin
  Result := 'connection';
  if (FConnectionDef <> nil) and (FConnectionDef.Name <> '') then
    Result := Result + ' ' + FConnectionDef.Name;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnectionHost.CreateObject(out AObject: IFDStanObject);
begin
  AObject := FDriverObj.InternalCreateConnection(Self) as IFDStanObject;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnectionHost.CreateConnection(out AConn: IFDPhysConnection);
var
  oObj: IFDStanObject;
begin
  if FConnectionDef.Params.Pooled and not FDIsDesignTime then begin
    FPool.Acquire(oObj);
    Supports(oObj, IFDPhysConnection, AConn);
  end
  else
    AConn := FDriverObj.InternalCreateConnection(Self) as IFDPhysConnection;
end;

{ ----------------------------------------------------------------------------- }
{$IFDEF FireDAC_MONITOR}
procedure TFDPhysConnectionHost.AddMoniClient;
var
  rGUID: TGUID;
  oClnt: IUnknown;
begin
  FMonitor := nil;
  case FConnectionDef.Params.MonitorBy of
  mbFlatFile: rGUID := IFDMoniFlatFileClient;
  mbRemote:   rGUID := IFDMoniRemoteClient;
  mbCustom:   rGUID := IFDMoniCustomClient;
  else        Exit;
  end;
  FInitialTracing := FConnectionDef.Params.MonitorByInitial;
  FDCreateInterface(rGUID, oClnt);
  FMonitor := oClnt as IFDMoniClient;
end;
{$ENDIF}

{ ----------------------------------------------------------------------------- }
{ TFDPhysConnection                                                             }
{ ----------------------------------------------------------------------------- }
constructor TFDPhysConnection.Create(ADriverObj: TFDPhysDriver;
  AConnHost: TFDPhysConnectionHost);
begin
  FDriver := ADriverObj as IFDPhysDriver;
  FDriverObj := ADriverObj;
  FDriverObj.FLock.Enter;
  try
    FMoniAdapterHelper := TFDMoniAdapterHelper.Create(Self, FDriverObj);
{$IFDEF FireDAC_MONITOR}
    FMonitor := AConnHost.FMonitor;
    if FMonitor <> nil then begin
      FTracing := AConnHost.FInitialTracing;
      TracingChanged;
    end;
    if GetTracing then
      FMonitor.Notify(ekLiveCycle, esProgress, Self, 'CreateConnection',
        ['ConnectionDef', AConnHost.ConnectionDef.Name]);
{$ENDIF}
    inherited Create;
    FState := csDisconnected;
    FPoolManaged := (AConnHost.FPool <> nil);
    FLoginPrompt := False;
    FDriverObj.FConnectionList.Add(Self);
    FConnHost := AConnHost;
    FConnHost.Employ;
    if FConnHost.FConnectionDef.Style <> atTemporary then begin
      FDCreateInterface(IFDStanConnectionDef, FInternalConnectionDef);
      FInternalConnectionDef.ParentDefinition := FConnHost.ConnectionDef;
    end;
    FLock := TCriticalSection.Create;
    FCommandList := TFDPtrList.Create;
    FTransactionList := TFDPtrList.Create;
    FEventList := TFDPtrList.Create;
    SetOptions(nil);
    ConnectionDef.ReadOptions(FOptions.FormatOptions, FOptions.UpdateOptions,
      FOptions.FetchOptions, FOptions.ResourceOptions);
    CheckTransaction;
  finally
    FDriverObj.FLock.Leave;
  end;
end;

{ ----------------------------------------------------------------------------- }
destructor TFDPhysConnection.Destroy;
begin
  FDHighRefCounter(FRefCount);
  FDriverObj.FLock.Enter;
  try
{$IFDEF FireDAC_MONITOR}
    if GetTracing then
      FMonitor.Notify(ekLiveCycle, esProgress, Self, 'DestroyConnection',
        ['ConnectionDef', ConnectionDef.Name]);
{$ENDIF}
    try
      if FCommandList <> nil then
        ForceDisconnect;
      FDriverObj.FConnectionList.Remove(Self);
      FTransactionObj := nil;
      FTransaction := nil;
      SetErrorHandler(nil);
      SetLogin(nil);
      FDFreeAndNil(FMetadata);
      FDFreeAndNil(FCommandList);
      FDFreeAndNil(FTransactionList);
      FDFreeAndNil(FEventList);
      FOptions := nil;
      FDFreeAndNil(FLock);
      inherited Destroy;
    finally
      FDFree(FMoniAdapterHelper);
      FMoniAdapterHelper := nil;
{$IFDEF FireDAC_MONITOR}
      SetTracing(False);
      FMonitor := nil;
{$ENDIF}
    end;
  finally
    FDriverObj.FLock.Leave;
    if FConnHost <> nil then
      FConnHost.Vacate;
    FConnHost := nil;
    FInternalConnectionDef := nil;
    FDriverObj := nil;
    FDriver := nil;
    FRefCount := 0;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.Lock;
begin
  FLock.Enter;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.Unlock;
begin
  FLock.Leave;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection._AddRef: Integer;
begin
  Result := inherited _AddRef;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection._Release: Integer;

  procedure ReleaseToPool;
  var
    oPoolItem: IFDStanObject;
  begin
    Lock;
    try
      if not FPoolManaged then begin
        Supports(TObject(Self), IFDStanObject, oPoolItem);
        FConnHost.FPool.Release(oPoolItem);
        AtomicDecrement(FRefCount);
        Pointer(oPoolItem) := nil;
      end;
    finally
      UnLock;
    end;
  end;

begin
  Result := AtomicDecrement(FRefCount);
  if Result <= 1 then
    if (Result = 1) and (FConnHost <> nil) and (FConnHost.FPool <> nil) then
      ReleaseToPool
    else if Result = 0 then
      FDFree(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysConnection.GetState: TFDPhysConnectionState;
begin
  Result := FState;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection.GetDriverID: String;
begin
  if FDriverObj <> nil then
    Result := FDriverObj.FDriverID
  else
    Result := '';
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
// Tracing

procedure TFDPhysConnection.Trace(AKind: TFDMoniEventKind;
  AStep: TFDMoniEventStep; const AMsg: String; const AArgs: array of const);
begin
  if GetTracing then
    FMonitor.Notify(AKind, AStep, Self, AMsg, AArgs);
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection.GetTracing: Boolean;
begin
  Result := FTracing and (FMonitor <> nil) and FMonitor.Tracing;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.SetTracing(AValue: Boolean);
var
  lPrevTracing: Boolean;
begin
  lPrevTracing := GetTracing;
  if AValue <> FTracing then begin
    FTracing := AValue;
    if lPrevTracing <> GetTracing then
      TracingChanged;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.TracingChanged;
begin
  InternalTracingChanged;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.InternalTracingChanged;
begin
  // nothing
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection.GetMonitor: IFDMoniClient;
begin
  Result := FMonitor;
end;
{$ENDIF}

{ ----------------------------------------------------------------------------- }
// Get interfaces

function TFDPhysConnection.GetDriver: IFDPhysDriver;
begin
  Result := FDriver;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.CreateCommandGenerator(out AGen: IFDPhysCommandGenerator;
  const ACommand: IFDPhysCommand);
begin
  AGen := InternalCreateCommandGenerator(ACommand) as IFDPhysCommandGenerator;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.CreateMetadata(out AConnMeta: IFDPhysConnectionMetadata);
begin
  if FMetadata = nil then
    FMetadata := InternalCreateMetadata;
  Supports(FMetadata, IFDPhysConnectionMetadata, AConnMeta);
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection.GetCliObj: Pointer;
begin
  Result := nil;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection.InternalGetCliHandle: Pointer;
begin
  Result := nil;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection.GetCliHandle: Pointer;
begin
  FCliHandles.FDriverCliHandles := InternalGetCliHandle;
  if (GetTransaction <> nil) and GetTransaction.Active then
    FCliHandles.FTxSerialID := NativeUInt(GetTransaction.SerialID)
  else
    FCliHandles.FTxSerialID := 0;
  StrCopy(@FCliHandles.FDriverID, PChar(GetDriverID));
  Result := @FCliHandles;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection.InternalGetSharedCliHandle: Pointer;
begin
  if FSharedHandle <> nil then
    Result := FSharedHandle^.FDriverCliHandles
  else
    Result := nil;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection.GetSharedCliHandle: Pointer;
begin
  Result := FSharedHandle;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.SetSharedCliHandle(AValue: Pointer);
begin
  CheckInactive;
  FSharedHandle := PFDPhysCliHandles(AValue);
end;

{ ----------------------------------------------------------------------------- }
// Options interface

procedure TFDPhysConnection.GetParentOptions(var AOpts: IFDStanOptions);
begin
  AOpts := FDriverObj.FManager.GetOptions;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection.GetOptions: IFDStanOptions;
begin
  Result := Self as IFDStanOptions;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.SetOptions(const AValue: IFDStanOptions);
begin
  if (FOptions <> AValue) or (FMetadata = nil) then begin
    FOptions := AValue;
    if FOptions = nil then
      FOptions := TFDOptionsContainer.Create(nil, TFDFetchOptions,
        TFDUpdateOptions, TFDTopResourceOptions, GetParentOptions);
  end;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection.GetConnectionDef: IFDStanConnectionDef;
begin
  if FInternalConnectionDef <> nil then
    Result := FInternalConnectionDef
  else
    Result := FConnHost.ConnectionDef;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection.GetMessages: EFDDBEngineException;
begin
  Result := nil;
end;

{ ----------------------------------------------------------------------------- }
// Transactions

function TFDPhysConnection.GetTransactionCount: Integer;
begin
  Result := FTransactionList.Count;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection.GetTransactions(AIndex: Integer): IFDPhysTransaction;
begin
  Lock;
  try
    Result := TFDPhysTransaction(FTransactionList[AIndex]) as IFDPhysTransaction;
  finally
    Unlock;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.CreateTransaction(out ATx: IFDPhysTransaction);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ekLiveCycle, esProgress, 'CreateTransaction', ['ConnectionDef', ConnectionDef.Name]);
  end;
{$ENDIF}

var
  oTxObj: TFDPhysTransaction;
  oConnMeta: IFDPhysConnectionMetadata;
  lCreate: Boolean;
begin
{$IFDEF FireDAC_MONITOR}
  if GetTracing then Trace1;
{$ENDIF}
  lCreate := FTransactionList.Count = 0;
  if not lCreate then begin
    CreateMetadata(oConnMeta);
    lCreate := oConnMeta.TxMultiple;
  end;
  if lCreate then begin
    oTxObj := InternalCreateTransaction;
    if GetState = csConnected then
      oTxObj.InternalAllocHandle;
  end
  else
    oTxObj := TFDPhysTransaction(FTransactionList[0]);
  ATx := oTxObj as IFDPhysTransaction;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection.GetTransaction: IFDPhysTransaction;
begin
  Result := FTransaction;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.SetTransaction(const AValue: IFDPhysTransaction);
var
  oTxObj: TFDPhysTransaction;
begin
  if AValue <> FTransaction then begin
    if FTransactionObj <> nil then begin
      if GetState in [csConnecting, csConnected] then
        FTransactionObj.InternalUnselect;
      FTransactionObj.FConnection := FTransactionObj.FConnectionObj as IFDPhysConnection;
    end;
    FTransaction := nil;
    FTransactionObj := nil;
    if AValue <> nil then begin
      oTxObj := AValue as TFDPhysTransaction;
      if oTxObj.FConnectionObj <> Self then
        FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccCantAssignTxIntf, []);
      FTransaction := AValue;
      FTransactionObj := oTxObj;
      if GetState in [csConnecting, csConnected] then
        FTransactionObj.InternalSelect;
      FTransactionObj.FConnection := nil;
    end;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.CheckTransaction;
var
  oTx: IFDPhysTransaction;
begin
  if FTransaction = nil then begin
    CreateTransaction(oTx);
    SetTransaction(oTx);
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.AllocTransactionHandles;
var
  i: Integer;
  oTran: TFDPhysTransaction;
begin
  if (FTransactionList.Count > 0) and
     (GetSharedCliHandle() <> nil) and (FSharedHandle^.FTxSerialID > 0) then begin
    oTran := TFDPhysTransaction(FTransactionList[0]);
    oTran.FSerialID := FSharedHandle^.FTxSerialID;
    FSharedHandle^.FTxSerialID := 0;
    oTran.FSharedActive := True;
    oTran.TransactionStarted;
  end;
  for i := 0 to FTransactionList.Count - 1 do
    TFDPhysTransaction(FTransactionList[i]).InternalAllocHandle;
  if (GetState in [csConnecting, csConnected]) and (FTransactionObj <> nil) then
    FTransactionObj.InternalSelect;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.ReleaseTransactionHandles;
var
  i: Integer;
begin
  if (GetState in [csConnecting, csConnected]) and (FTransactionObj <> nil) then
    FTransactionObj.InternalUnSelect;
  for i := 0 to FTransactionList.Count - 1 do
    TFDPhysTransaction(FTransactionList[i]).ReleaseHandleBase;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.DisconnectTransactions;
var
  i: Integer;
begin
  for i := 0 to FTransactionList.Count - 1 do
    TFDPhysTransaction(FTransactionList[i]).Disconnect;
end;

{ ----------------------------------------------------------------------------- }
// Events

function TFDPhysConnection.GetEventCount: Integer;
begin
  Result := FEventList.Count;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection.GetEvents(AIndex: Integer): IFDPhysEventAlerter;
begin
  Lock;
  try
    Result := TFDPhysEventAlerter(FEventList[AIndex]) as IFDPhysEventAlerter;
  finally
    Unlock;
  end;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection.InternalCreateEvent(const AEventKind: String): TFDPhysEventAlerter;
begin
  Result := nil;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.CreateEvent(const AEventKind: String; out AEvent: IFDPhysEventAlerter);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ekLiveCycle, esProgress, 'CreateEvent', ['EventKind', AEventKind,
      'ConnectionDef', ConnectionDef.Name]);
  end;
{$ENDIF}

var
  oEventObj: TFDPhysEventAlerter;
  oMeta: IFDPhysConnectionMetadata;
  sEvent: String;
  i: Integer;
begin
{$IFDEF FireDAC_MONITOR}
  if GetTracing then Trace1;
{$ENDIF}
  CreateMetadata(oMeta);
  if not oMeta.EventSupported then
    FDCapabilityNotSupported(Self, [S_FD_LPhys, DriverID]);
  if AEventKind <> '' then
    sEvent := AEventKind
  else begin
    i := 1;
    sEvent := FDExtractFieldName(oMeta.EventKinds, i);
  end;
  oEventObj := InternalCreateEvent(sEvent);
  if oEventObj = nil then
    FDCapabilityNotSupported(Self, [S_FD_LPhys, DriverID]);
  AEvent := oEventObj as IFDPhysEventAlerter;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.DisconnectEvents;
var
  i: Integer;
begin
  for i := 0 to FEventList.Count - 1 do
    TFDPhysEventAlerter(FEventList[i]).Unregister;
end;

{ ----------------------------------------------------------------------------- }
// Commands

function TFDPhysConnection.GetCommandCount: Integer;
begin
  Result := FCommandList.Count;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection.GetCommands(AIndex: Integer): IFDPhysCommand;
begin
  Lock;
  try
    Result := TFDPhysCommand(FCommandList[AIndex]) as IFDPhysCommand;
  finally
    UnLock;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.CreateCommand(out ACmd: IFDPhysCommand);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ekLiveCycle, esProgress, 'CreateCommand', ['ConnectionDef', ConnectionDef.Name]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if GetTracing then Trace1;
{$ENDIF}
  ACmd := InternalCreateCommand as IFDPhysCommand;
end;

{-------------------------------------------------------------------------------}
function TFDPhysConnection.InternalCreateMetaInfoCommand: TFDPhysCommand;
begin
  Result := InternalCreateCommand;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.CreateMetaInfoCommand(out AMetaCmd: IFDPhysMetaInfoCommand);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ekLiveCycle, esProgress, 'CreateMetaInfoCommand', ['ConnectionDef', ConnectionDef.Name]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if GetTracing then Trace1;
{$ENDIF}
  AMetaCmd := InternalCreateMetaInfoCommand as IFDPhysMetaInfoCommand;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.InternalOverrideNameByCommand(
  var AParsedName: TFDPhysParsedName; const ACommand: IFDPhysCommand);
var
  oConnMeta: IFDPhysConnectionMetadata;
  s: String;
begin
  CreateMetadata(oConnMeta);
  if (AParsedName.FCatalog = '') and (npCatalog in oConnMeta.NameParts) and
     not (npCatalog in FAvoidImplicitMeta) then begin
    s := GetCurrentCatalog;
    if AnsiCompareText(oConnMeta.UnQuoteObjName(s), oConnMeta.UnQuoteObjName(DefaultCatalog)) <> 0 then
      AParsedName.FCatalog := s;
  end;
  if (AParsedName.FSchema = '') and (npSchema in oConnMeta.NameParts) and
     not (npSchema in FAvoidImplicitMeta) then begin
    s := GetCurrentSchema;
    if AnsiCompareText(oConnMeta.UnQuoteObjName(s), oConnMeta.UnQuoteObjName(DefaultSchema)) <> 0 then
      AParsedName.FSchema := s;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.DisconnectCommands;
var
  i: Integer;
  oCmd: TFDPhysCommand;
begin
  for i := FCommandList.Count - 1 downto 0 do begin
    oCmd := TFDPhysCommand(FCommandList[i]);
    if GetState = csRecovering then
      oCmd.AbortJob(True);
    oCmd.Disconnect;
  end;
end;

{ ----------------------------------------------------------------------------- }
// Exception handling

function TFDPhysConnection.GetErrorHandler: IFDStanErrorHandler;
begin
  Result := FErrorHandler;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.SetErrorHandler(const AValue: IFDStanErrorHandler);
begin
  FErrorHandler := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.HandleException(const AInitiator: IFDStanObject;
  var AException: Exception);
begin
{$IFDEF FireDAC_MONITOR}
  if not (AException is EFDDBEngineException) and GetTracing then
    Trace(ekError, esProgress, AException.Message, []);
{$ENDIF}
  if Assigned(GetErrorHandler()) then
    GetErrorHandler().HandleException(AInitiator, AException);
end;

{-------------------------------------------------------------------------------}
// Connection management

procedure TFDPhysConnection.CheckActive(ADisconnectingAllowed: Boolean = False);
begin
  if not ADisconnectingAllowed and not (FState in [csConnected, csRecovering]) or
         ADisconnectingAllowed and not (FState in [csConnected, csDisconnecting, csRecovering]) then
    FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccSrvMBConnected, []);
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.CheckInactive;
begin
  if FState <> csDisconnected then
    FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccSrvMBDisConnected, []);
end;

{-------------------------------------------------------------------------------}
function TFDPhysConnection.GetLogin: IFDGUIxLoginDialog;
begin
  Result := FLogin;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.SetLogin(const AValue: IFDGUIxLoginDialog);
begin
  if FLogin <> nil then
    FLogin.ConnectionDef := nil;
  FLogin := AValue;
  if FLogin <> nil then
    FLogin.ConnectionDef := ConnectionDef;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysConnection.GetLoginPrompt: Boolean;
begin
  Result := FLoginPrompt;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.SetLoginPrompt(const AValue: Boolean);
begin
  FLoginPrompt := AValue;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.BeforeReuse;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ekLiveCycle, esProgress, 'BeforeReuse', ['ConnectionDef', ConnectionDef.Name]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if GetTracing then Trace1;
{$ENDIF}
  FPoolManaged := False;
  // The connecting / pinging moved out of here to Open. This enables
  // automatic connection recovery for pooled connections. Because at this
  // moment TFDConnection recovery handler and options are not yet set.
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.AfterReuse;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ekLiveCycle, esProgress, 'AfterReuse', ['ConnectionDef', ConnectionDef.Name]);
  end;
{$ENDIF}

var
  i: Integer;
begin
{$IFDEF FireDAC_MONITOR}
  if GetTracing then Trace1;
{$ENDIF}
  FPoolManaged := True;
  DisconnectCommands;
  DisconnectEvents;
  DisconnectTransactions;
  for i := 0 to FTransactionList.Count - 1 do
    TFDPhysTransaction(FTransactionList[i]).SetOptions(nil);
  SetOptions(nil);
  SetErrorHandler(nil);
  SetOwner(nil, '');
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.ForceDisconnect;
var
  i: Integer;
  oCmd: TFDPhysCommand;
begin
  Lock;
  try
    for i := FCommandList.Count - 1 downto 0 do
      try
        oCmd := TFDPhysCommand(FCommandList[i]);
        if oCmd.GetState in [csExecuting, csFetching] then
          oCmd.AbortJob(True);
        oCmd.Disconnect;
      except
        // hide exceptions
      end;
    if GetState = csConnected then
      Close;
  finally
    UnLock;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.ConnectBase;
begin
  FDriver.Employ;
  try
    InternalConnect;
    try
      AllocTransactionHandles;
      InternalSetMeta;
    except
      ReleaseTransactionHandles;
      raise;
    end;
  except
    try
      InternalDisconnect;
    finally
      FDriver.Vacate;
    end;
    raise;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.DoConnect;
var
  lConnected: Boolean;
begin
  lConnected := False;
  repeat
    try
      ConnectBase;
      lConnected := True;
    except
      on E: EFDDBEngineException do
        if E.Kind = ekServerGone then
          RecoverConnection(Self, True)
        else
          raise;
    end;
  until lConnected;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.DoLogin;
  procedure LoginAborted;
  var
    s: String;
  begin
    s := ConnectionDef.Name;
    if s = '' then
      s := S_FD_Unnamed;
    FDException(Self, [S_FD_LPhys, DriverID], er_FD_ClntDbLoginAborted, [s]);
  end;
var
  oDlg: IFDGUIxLoginDialog;
begin
  if not Assigned(FLogin) then begin
    FDCreateInterface(IFDGUIxLoginDialog, oDlg, False);
    if oDlg = nil then begin
      DoConnect;
      Exit;
    end;
    oDlg.ConnectionDef := ConnectionDef;
  end
  else
    oDlg := FLogin;
  try
    if not oDlg.Execute(DoConnect) then
      LoginAborted;
  finally
    if not Assigned(FLogin) then
      oDlg.ConnectionDef := nil;
  end;
end;

{ ----------------------------------------------------------------------------- }
{$IFDEF FireDAC_MONITOR}
procedure TFDPhysConnection.TraceList(AList: TStrings; const AName: String);
var
  i: Integer;
begin
  if AList.Count > 0 then begin
    Trace(ekConnConnect, esStart, AName, []);
    for i := 0 to AList.Count - 1 do
      Trace(ekConnConnect, esProgress, AList[i], []);
    Trace(ekConnConnect, esEnd, AName, []);
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.TraceConnInfo(AKind: TFDMoniAdapterItemKind;
  const AName: String);
var
  i: Integer;
  sName: String;
  vVal: Variant;
  eKind: TFDMoniAdapterItemKind;
  oList: TFDStringList;
begin
  oList := TFDStringList.Create;
  try
    FTracing := False;
    try
      for i := 0 to GetItemCount - 1 do begin
        sName := '';
        vVal := Unassigned;
        eKind := ikStat;
        GetItem(i, sName, vVal, eKind);
        if eKind = AKind then
          oList.Add(sName + '=' + VarToStr(vVal));
      end;
    finally
      FTracing := True;
    end;
    TraceList(oList, AName);
  finally
    FDFree(oList);
  end;
end;
{$ENDIF}

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.InternalSetMeta;
var
  oConnDef: IFDStanConnectionDef;

  procedure SetParam(var AParam: String; const AName: String;
    var AFlags: TFDPhysNameParts; AFlag: TFDPhysNamePart);
  begin
    if oConnDef.HasValue(AName) then
      AParam := oConnDef.AsString[AName];
    if AParam = '*' then begin
      Include(AFlags, AFlag);
      AParam := '';
    end;
  end;

begin
  oConnDef := ConnectionDef;
  // get user specified default schema and catalog names
  SetParam(FDefaultCatalog, S_FD_ConnParam_Common_MetaDefCatalog, FRemoveDefaultMeta, npCatalog);
  SetParam(FDefaultSchema, S_FD_ConnParam_Common_MetaDefSchema, FRemoveDefaultMeta, npSchema);
  // get user specified current schema and catalog names
  SetParam(FCurrentCatalog, S_FD_ConnParam_Common_MetaCurCatalog, FAvoidImplicitMeta, npCatalog);
  SetParam(FCurrentSchema, S_FD_ConnParam_Common_MetaCurSchema, FAvoidImplicitMeta, npSchema);
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.Open;
var
  oConnDef: IFDStanConnectionDef;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    if not FMoniAdapterHelper.IsRegistered then
      FMoniAdapterHelper.RegisterClient(GetMonitor);
    Trace(ekConnConnect, esStart, 'Open', ['ConnectionDef', oConnDef.Name]);
    oConnDef.Trace(FMonitor);
    TraceConnInfo(ikFireDACInfo, C_FD_Product + ' info');
  end;

  procedure Trace2;
  begin
    if FDriver.Messages <> nil then
      TraceList(FDriver.Messages, 'Driver log');
    TraceConnInfo(ikClientInfo, 'Client info');
    if FState = csConnected then begin
      UpdateMonitor;
      TraceConnInfo(ikSessionInfo, 'Session info');
    end;
    Trace(ekConnConnect, esEnd, 'Open', ['ConnectionDef', oConnDef.Name]);
  end;
{$ENDIF}

begin
  oConnDef := ConnectionDef;
  if oConnDef.Params.Pooled and (GetState = csConnected) then begin
    if (GetOptions.ResourceOptions as TFDTopResourceOptions).AutoReconnect then
      Ping;
    Exit;
  end;
{$IFDEF FireDAC_MONITOR}
  if GetTracing then Trace1;
  try
{$ENDIF}
    Lock;
    try
      CheckInactive;
      FState := csConnecting;
      FDefaultCatalog := '';
      FDefaultSchema := '';
      FCurrentCatalog := '';
      FCurrentSchema := '';
      FRemoveDefaultMeta := [];
      FAvoidImplicitMeta := [];
      try
{$IFDEF FireDAC_MONITOR}
        SetTracing((oConnDef.Params.MonitorBy <> mbNone) and FConnHost.FInitialTracing);
{$ENDIF}
        if GetLoginPrompt and not oConnDef.Params.Pooled and not FDGUIxSilent() and
           (GetSharedCliHandle() = nil) then
          DoLogin
        else
          DoConnect;
        // following is required to "refresh" metadata after connecting server
        FDFreeAndNil(FMetadata);
        FState := csConnected;
      except
        FState := csDisconnected;
        raise;
      end;
    finally
      UnLock;
    end;
{$IFDEF FireDAC_MONITOR}
  finally
    if GetTracing then Trace2;
  end;
{$ENDIF}
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.Close;
var
  oConnDef: IFDStanConnectionDef;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ekConnConnect, esStart, 'Close', ['ConnectionDef', oConnDef.Name]);
  end;

  procedure Trace2;
  begin
    Trace(ekConnConnect, esEnd, 'Close', ['ConnectionDef', oConnDef.Name]);
  end;
{$ENDIF}

begin
  oConnDef := ConnectionDef;
{$IFDEF FireDAC_MONITOR}
  if GetTracing then Trace1;
  try
{$ENDIF}
    Lock;
    try
      CheckActive;
      // If the state will be csDisconnecting, but the connection is broken
      // and there were active transactions, then DisconnectTransactions will
      // rollback them. That will lead to errors. So, leave csRecovering -
      // means the connection is broken.
      if FState <> csRecovering then
        FState := csDisconnecting;
      DisconnectCommands;
      DisconnectEvents;
      DisconnectTransactions;
      ReleaseTransactionHandles;
      InternalDisconnect;
      // TFDPhysCommand.DoDefineDataTable, etc keep a reference to a metadata.
      // If connection is failed and closed then AV will be raised at exiting
      // from DoDefineDataTable, etc, because metadata reference is invalid.
      // FDFreeAndNil(FMetadata);
    finally
      FDriver.Vacate;
      FState := csDisconnected;
      UnLock;
    end;
{$IFDEF FireDAC_MONITOR}
  finally
    if GetTracing then Trace2;
  end;
{$ENDIF}
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.ChangePassword(const ANewPassword: String);
begin
  FDriver.Employ;
  try
    InternalChangePassword(ConnectionDef.Params.UserName, ConnectionDef.Params.Password,
      ANewPassword);
  finally
    FDriver.Vacate;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.InternalChangePassword(const AUserName,
  AOldPassword, ANewPassword: String);
begin
  FDCapabilityNotSupported(Self, [S_FD_LPhys, DriverID]);
end;

{ ----------------------------------------------------------------------------- }
procedure TFDPhysConnection.DecPrepared;
begin
  Lock;
  Dec(FPreparedCommands);
  UnLock;
end;

{ ----------------------------------------------------------------------------- }
function SortOnUsage(Item1, Item2: Pointer): Integer;
var
  oCmdObj1, oCmdObj2: TFDPhysCommand;
begin
  oCmdObj1 := TFDPhysCommand(Item1);
  oCmdObj2 := TFDPhysCommand(Item2);
  if oCmdObj1.FExecuteCount > oCmdObj2.FExecuteCount then
    Result := -1
  else if oCmdObj1.FExecuteCount < oCmdObj2.FExecuteCount then
    Result := 1
  else
    Result := 0;
end;

{$IFDEF AUTOREFCOUNT}
type
  TFDPhysCommandComparer = class(TInterfacedObject, IComparer<Pointer>)
    function Compare(const Left, Right: Pointer): Integer;
  end;

function TFDPhysCommandComparer.Compare(const Left, Right: Pointer): Integer;
begin
  Result := SortOnUsage(Left, Right);
end;
{$ENDIF}

procedure TFDPhysConnection.IncPrepared(ACommand: TFDPhysCommand);
var
  j, i, n: Integer;
  oCmdObj: TFDPhysCommand;
  oResOpts: TFDTopResourceOptions;
begin
  Lock;
  try
    oResOpts := FOptions.ResourceOptions as TFDTopResourceOptions;
    if (oResOpts.MaxCursors > 0) and
       (FPreparedCommands + 1 > oResOpts.MaxCursors) then begin
      FCommandList.Sort({$IFDEF AUTOREFCOUNT} TFDPhysCommandComparer.Create {$ELSE} SortOnUsage {$ENDIF});
      n := (oResOpts.MaxCursors * C_FD_CrsPctClose) div 100;
      i := 0;
      for j := FCommandList.Count - 1 downto 0 do begin
        oCmdObj := TFDPhysCommand(FCommandList[j]);
        if oCmdObj <> ACommand then begin
          oCmdObj.Disconnect;
          Inc(i);
          if i >= n then
            Break;
        end;
      end;
    end;
    Inc(FPreparedCommands);
  finally
    UnLock;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysConnection.GetLastAutoGenValue(const AName: String = ''): Variant;
var
  oCmd: IFDPhysCommand;
  oGen: IFDPhysCommandGenerator;
  oTab: TFDDatSTable;
  oFtch: TFDFetchOptions;
  oRes: TFDResourceOptions;
begin
  if not VarIsNull(FLastAutoGenValue) and not VarIsEmpty(FLastAutoGenValue) then begin
    Result := FLastAutoGenValue;
    Exit;
  end;
  CreateCommand(oCmd);
  CreateCommandGenerator(oGen, nil);

  oFtch := oCmd.Options.FetchOptions;
  oFtch.RowsetSize := 1;
  oFtch.Items := oFtch.Items - [fiMeta];
  oFtch.RecordCountMode := cmVisible;
  oFtch.Mode := fmOnDemand;
  oFtch.AutoFetchAll := afAll;

  oRes := oCmd.Options.ResourceOptions;
  if oRes.CmdExecMode = amAsync then
    oRes.CmdExecMode := amBlocking;
  oRes.DirectExecute := True;
  oRes.Persistent := False;

  oCmd.CommandText := oGen.GenerateReadGenerator(AName, '', False, True);
  oCmd.CommandKind := oGen.CommandKind;

  oTab := TFDDatSTable.Create;
  try
    oCmd.Define(oTab);
    oCmd.Open;
    oCmd.Fetch(oTab);
    if oTab.Rows.Count > 0 then
      Result := oTab.Rows[0].GetData(0)
    else
      Result := Null;
  finally
    FDFree(oTab);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.SaveLastAutoGenValue(const AValue: Variant);
begin
  FLastAutoGenValue := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysConnection.Clone: IFDPhysConnection;
begin
  FDriverObj.FManager.CreateConnection(ConnectionDef, Result);
  Result.Options := GetOptions;
  Result.ErrorHandler := GetErrorHandler;
  Result.RecoveryHandler := GetRecoveryHandler;
  Result.CurrentCatalog := GetCurrentCatalog;
  Result.CurrentSchema := GetCurrentSchema;
  if GetSharedCliHandle <> nil then begin
    if Result.State in [csConnected, csRecovering] then
      Result.Close;
    Result.SharedCliHandle := GetSharedCliHandle;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.InternalAnalyzeSession(AMessages: TStrings);
var
  oConnMeta: IFDPhysConnectionMetadata;
  iVer: TFDVersion;
begin
  CreateMetadata(oConnMeta);

  // 1. Diff between clnt and srv versions must be <= 1 major version
  iVer := oConnMeta.ServerVersion div 100000000 - oConnMeta.ClientVersion div 100000000;
  if iVer < 0 then
    iVer := -iVer;
  if iVer > 1 then
    AMessages.Add(Format(S_FD_PhysWarnMajVerDiff,
      [FDVerInt2Str(oConnMeta.ClientVersion), FDVerInt2Str(oConnMeta.ServerVersion)]));
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.AnalyzeSession(AMessages: TStrings);
begin
  CheckActive(False);
  AMessages.BeginUpdate;
  try
    AMessages.Clear;
    InternalAnalyzeSession(AMessages);
  finally
    AMessages.EndUpdate;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysConnection.InternalGetCurrentCatalog: String;
begin
  Result := ConnectionDef.Params.ExpandedDatabase;
end;

{-------------------------------------------------------------------------------}
function TFDPhysConnection.GetCurrentCatalog: String;
var
  oConnMeta: IFDPhysConnectionMetadata;
  rName: TFDPhysParsedName;
begin
  CreateMetadata(oConnMeta);
  if npCatalog in oConnMeta.NameParts then begin
    if FCurrentCatalog <> '' then
      rName.FCatalog := FCurrentCatalog
    else
      rName.FCatalog := InternalGetCurrentCatalog;
    Result := oConnMeta.EncodeObjName(rName, nil, [eoNormalize]);
  end
  else
    Result := '';
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.SetCurrentCatalog(const AValue: String);
begin
  FCurrentCatalog := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysConnection.InternalGetCurrentSchema: String;
begin
  Result := ConnectionDef.AsString[S_FD_ConnParam_Common_UserName];
end;

{-------------------------------------------------------------------------------}
function TFDPhysConnection.GetCurrentSchema: String;
var
  oConnMeta: IFDPhysConnectionMetadata;
  rName: TFDPhysParsedName;
begin
  CreateMetadata(oConnMeta);
  if npSchema in oConnMeta.NameParts then begin
    if FCurrentSchema <> '' then
      rName.FSchema := FCurrentSchema
    else
      rName.FSchema := InternalGetCurrentSchema;
    Result := oConnMeta.EncodeObjName(rName, nil, [eoNormalize]);
  end
  else
    Result := '';
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.SetCurrentSchema(const AValue: String);
begin
  FCurrentSchema := AValue;
end;

{-------------------------------------------------------------------------------}
// Connection recovery

function TFDPhysConnection.GetRecoveryHandler: IFDPhysConnectionRecoveryHandler;
begin
  Result := FRecoveryHandler;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.SetRecoveryHandler(const AValue: IFDPhysConnectionRecoveryHandler);
begin
  FRecoveryHandler := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.RecoverConnection(const AInitiator: IFDStanObject; AOnLogin: Boolean);
var
  oExc: Exception;
  eAction: TFDPhysConnectionRecoverAction;
  lDone, lAutoRetry, lRaised: Boolean;
  i, iTrials: Integer;
  oCmdList: TFDObjList;
  oEvtList: TFDObjList;
  oParsList: TFDObjList;
  oCmd: TFDPhysCommand;
  oPars: TFDParams;
  oPrevMeta: TObject;
{$IFDEF FireDAC_MONITOR}
  sDefName: String;
{$ENDIF}

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ekConnConnect, esStart, 'RecoverConnection', ['ConnectionDef', sDefName]);
  end;

  procedure Trace2;
  begin
    Trace(ekConnConnect, esEnd, 'RecoverConnection', ['ConnectionDef', sDefName]);
  end;

  procedure Trace3;
  begin
    Trace(ekConnConnect, esProgress, 'HandleConnectionRecover', ['ConnectionDef', sDefName]);
  end;

  procedure Trace4;
  begin
    Trace(ekConnConnect, esProgress, 'HandleConnectionRestored', ['ConnectionDef', sDefName]);
  end;

  procedure Trace5;
  begin
    Trace(ekConnConnect, esProgress, 'HandleConnectionLost', ['ConnectionDef', sDefName]);
  end;
{$ENDIF}

  procedure ConnectionRecover(AExitState: TFDPhysConnectionState);
  begin
    if not AOnLogin then
      FState := csRecovering;
    try
      if Assigned(GetRecoveryHandler()) then begin
{$IFDEF FireDAC_MONITOR}
        if GetTracing then Trace3;
{$ENDIF}
        GetRecoveryHandler().HandleConnectionRecover(AInitiator, oExc, eAction);
      end;
    finally
      if not AOnLogin and (FState = csRecovering) then
        FState := AExitState;
    end;
  end;

  procedure ConnectionRestored(AExitState: TFDPhysConnectionState);
  begin
    FState := AExitState;
    if Assigned(GetRecoveryHandler()) then begin
{$IFDEF FireDAC_MONITOR}
      if GetTracing then Trace4;
{$ENDIF}
      GetRecoveryHandler().HandleConnectionRestored();
    end;
  end;

  procedure ConnectionLost(AExitState: TFDPhysConnectionState);
  begin
    if not AOnLogin then
      FState := csConnected;
    try
      if Assigned(GetRecoveryHandler()) then begin
{$IFDEF FireDAC_MONITOR}
        if GetTracing then Trace4;
{$ENDIF}
        GetRecoveryHandler().HandleConnectionLost();
      end;
    finally
      if not AOnLogin and (FState = csRecovering) then
        FState := AExitState;
    end;
  end;

begin
  oExc := AcquireExceptionObject();
  lRaised := False;
  try
    if not (rfInRecovery in FRecoveryFlags) and
       (oExc is EFDDBEngineException) and (EFDDBEngineException(oExc).Kind = ekServerGone) and
       (AOnLogin or (GetState = csConnected)) then begin
{$IFDEF FireDAC_MONITOR}
      sDefName := ConnectionDef.Name;
      if GetTracing then Trace1;
      try
{$ENDIF}
        Lock;
        Include(FRecoveryFlags, rfInRecovery);
        try
          lDone := False;
          lAutoRetry := False;
          iTrials := 1;
          eAction := faDefault;
          ConnectionRecover(csConnected);
          oCmdList := TFDObjList.Create;
          oParsList := TFDObjList.Create;
          oEvtList := TFDObjList.Create;
          if not AOnLogin then begin
            // TFDPhysCommand.DoDefineDataTable, etc keep a reference to a metadata.
            // If connection is failed and restored then AV will be raised at exiting
            // from DoDefineDataTable, etc, because metadata reference is invalid.
            oPrevMeta := FMetadata;
            FMetadata := nil;
          end
          else
            oPrevMeta := nil;
          try
            for i := 0 to FCommandList.Count - 1 do begin
              oCmd := TFDPhysCommand(FCommandList[i]);
              if oCmd.GetState <> csInactive then begin
                oCmdList.Add(oCmd);
                if (oCmd.GetCommandKind in [skStoredProc, skStoredProcWithCrs, skStoredProcNoCrs]) and
                   (fiMeta in oCmd.GetOptions.FetchOptions.Items) then begin
                  oPars := TFDParams.Create;
                  oParsList.Add(oPars);
                  oPars.Assign(oCmd.GetParams);
                end
                else
                  oParsList.Add(nil);
              end;
            end;
            for i := 0 to FEventList.Count - 1 do
              if TFDPhysEventAlerter(FEventList[i]).GetState <> esInactive then
                oEvtList.Add(FEventList[i]);
            // Prohibit to call state handlers, otherwise datasets will be disconnected.
            // But only Phys commands must be reprepared.
            Include(FRecoveryFlags, rfEmergencyClose);
            try
              ForceDisconnect;
            finally
              Exclude(FRecoveryFlags, rfEmergencyClose);
            end;
            if eAction = faDefault then
              if (FOptions.ResourceOptions as TFDTopResourceOptions).AutoReconnect then begin
                eAction := faRetry;
                lAutoRetry := True;
              end
              else
                eAction := faFail;
            repeat
              case eAction of
              faFail:
                begin
                  ConnectionLost(csDisconnected);
                  lRaised := True;
                  raise oExc;
                end;
              faRetry:
                begin
                  // if first trial, do not wait, may be DBMS is already available
                  if lAutoRetry and (iTrials > 1) then
                    Sleep(C_FD_PhysConnRetryDelay);
                  FState := csConnecting;
                  try
                    ConnectBase;
                    ConnectionRestored(csConnected);
                    lDone := True;
                  except
                    on EFDDBEngineException do begin
                      FState := csDisconnected;
                      FDFree(oExc);
                      oExc := AcquireExceptionObject();
                      ConnectionRecover(csDisconnected);
                    end;
                  end;
                end;
              faCloseAbort,
              faOfflineAbort:
                begin
                  ConnectionLost(csDisconnected);
                  Abort;
                end;
              end;
              Inc(iTrials);
              if (eAction = faRetry) and lAutoRetry and (iTrials > C_FD_PhysConnRetryCount) then begin
                ConnectionLost(csDisconnected);
                lRaised := True;
                raise oExc;
              end;
            until lDone;
          finally
            if not AOnLogin then begin
              FDFreeAndNil(FMetadata);
              FMetadata := oPrevMeta;
            end;
            if GetState = csConnected then begin
              for i := 0 to oCmdList.Count - 1 do begin
                TFDPhysCommand(oCmdList[i]).Prepare();
                if oParsList[i] <> nil then begin
                  TFDPhysCommand(oCmdList[i]).GetParams.AssignValues(TFDParams(oParsList[i]), [ptInput, ptInputOutput]);
                  FDFree(TFDParams(oParsList[i]));
                end;
              end;
              for i := 0 to oEvtList.Count - 1 do
                TFDPhysEventAlerter(oEvtList[i]).Register();
            end;
            FDFree(oCmdList);
            FDFree(oParsList);
            FDFree(oEvtList);
          end;
        finally
          UnLock;
          Exclude(FRecoveryFlags, rfInRecovery);
        end;
{$IFDEF FireDAC_MONITOR}
      finally
        if GetTracing then Trace2;
      end;
{$ENDIF}
    end
    else begin
      lRaised := True;
      raise oExc;
    end;
  finally
    if not lRaised then
      FDFree(oExc);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysConnection.Ping: Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ekConnConnect, esStart, 'Ping', ['ConnectionDef', ConnectionDef.Name]);
  end;

  procedure Trace2;
  begin
    Trace(ekConnConnect, esEnd, 'Ping', ['ConnectionDef', ConnectionDef.Name]);
  end;
{$ENDIF}

begin
  Result := False;
  if GetState in [csDisconnecting, csConnecting, csRecovering] then
    Exit;
  _AddRef;
  try
{$IFDEF FireDAC_MONITOR}
    if GetTracing then Trace1;
    try
{$ENDIF}
      case GetState of
      csConnected:
        try
          InternalPing;
          Result := True;
        except
          on E: EFDDBEngineException do
            if E.Kind = ekServerGone then begin
              RecoverConnection(Self, False);
              Result := GetState = csConnected;
            end;
        end;
      csDisconnected:
        Open;
      end;
{$IFDEF FireDAC_MONITOR}
    finally
      if GetTracing then Trace2;
    end;
{$ENDIF}
  finally
    _Release;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.InternalPing;
var
  oGen: IFDPhysCommandGenerator;
  s: String;
begin
  CreateCommandGenerator(oGen, nil);
  s := oGen.GeneratePing;
  if s <> '' then
    InternalExecuteDirect(s, TransactionObj);
end;

{-------------------------------------------------------------------------------}
// IFDStanObject

function TFDPhysConnection.GetName: TComponentName;
begin
  if FMoniAdapterHelper <> nil then
    Result := FMoniAdapterHelper.Name
  else
    Result := '';
end;

{-------------------------------------------------------------------------------}
function TFDPhysConnection.GetParent: IFDStanObject;
begin
  if FMoniAdapterHelper <> nil then
    Result := FMoniAdapterHelper.Parent
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.SetOwner(const AOwner: TObject;
  const ARole: TComponentName);
begin
  FMoniAdapterHelper.SetOwner(AOwner, ARole);
{$IFDEF FireDAC_MONITOR}
  FMoniAdapterHelper.UnRegisterClient;
  FMoniAdapterHelper.RegisterClient(GetMonitor);
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
// IFDMoniAdapter

function TFDPhysConnection.GetHandle: LongWord;
begin
  if FMoniAdapterHelper = nil then
    Result := 0
  else
    Result := FMoniAdapterHelper.Handle;
end;

{-------------------------------------------------------------------------------}
function TFDPhysConnection.GetSupportItems: TFDMoniAdapterItemKinds;
begin
  Result := [ikStat, ikFireDACInfo, ikClientInfo, ikSessionInfo];
end;

{-------------------------------------------------------------------------------}
function TFDPhysConnection.GetItemCount: Integer;
begin
  Result := 6;
  if GetState <> csDisconnected then
    Inc(Result, 2);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysConnection.GetItem(AIndex: Integer; out AName: String;
  out AValue: Variant; out AKind: TFDMoniAdapterItemKind);
var
  s: String;
  iLen: Integer;

  procedure Add(const AStr: String);
  begin
    if iLen + Length(AStr) + 1 > 50 then begin
      s := s + C_FD_EOL + '  ';
      iLen := 0;
    end;
    s := s + AStr + ';';
    Inc(iLen, Length(AStr) + 1);
  end;

begin
  case AIndex of
  0:
    begin
      AName := 'Commands';
      AValue := FCommandList.Count;
      AKind := ikStat;
    end;
  1:
    begin
      AName := 'Transactions';
      AValue := FTransactionList.Count;
      AKind := ikStat;
    end;
  2:
    begin
      AName := 'Tool';
      AValue := C_FD_ToolName;
      AKind := ikFireDACInfo;
    end;
  3:
    begin
      AName := C_FD_Product;
      AValue := C_FD_Version;
      AKind := ikFireDACInfo;
    end;
  4:
    begin
      AName := 'Platform';
      AValue :=
{$IFDEF MSWINDOWS}
        'Windows'
{$ENDIF}
{$IFDEF ANDROID}
        'Android'
{$ENDIF}
{$IFDEF LINUX}
        'Linux'
{$ENDIF}
{$IFDEF MACOS}
  {$IFDEF IOS}
    {$IFDEF CPUARM}
        'iOS Device'
    {$ELSE}
        'iOS Emulator'
    {$ENDIF}
  {$ELSE}
        'OS X'
  {$ENDIF}
{$ENDIF}
{$IFDEF FireDAC_64}
      + ' 64 bit'
{$ENDIF}
{$IFDEF FireDAC_32}
      + ' 32 bit'
{$ENDIF}
      ;
      AKind := ikFireDACInfo;
    end;
  5:
    begin
      AName := 'Defines';
      s := '';
      iLen := 0;
{$IFDEF FireDAC_NOLOCALE_DATA}
      Add('FireDAC_NOLOCALE_DATA');
{$ENDIF}
{$IFDEF FireDAC_NOLOCALE_META}
      Add('FireDAC_NOLOCALE_META');
{$ENDIF}
{$IFDEF FireDAC_MONITOR}
      Add('FireDAC_MONITOR');
{$ENDIF}
{$IFDEF FireDAC_DEBUG}
      Add('FireDAC_DEBUG');
{$ENDIF}
{$IFDEF FireDAC_SynEdit}
      Add('FireDAC_SynEdit');
{$ENDIF}
{$IFDEF FireDAC_MOBILE}
      Add('FireDAC_MOBILE');
{$ENDIF}
      AValue := Copy(s, 1, Length(s) - 1);
      AKind := ikFireDACInfo;
    end;
  6:
    begin
      AName := 'Current catalog';
      AValue := FCurrentCatalog;
      AKind := ikSessionInfo;
    end;
  7:
    begin
      AName := 'Current schema';
      AValue := FCurrentSchema;
      AKind := ikSessionInfo;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
procedure TFDPhysConnection.UpdateMonitor;
begin
  if GetTracing then
    FMonitor.AdapterChanged(Self as IFDMoniAdapter);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TFDPhysTransaction                                                            }
{-------------------------------------------------------------------------------}
constructor TFDPhysTransaction.Create(AConnection: TFDPhysConnection);
begin
  inherited Create;
  FState := tsInactive;
  FConnection := AConnection as IFDPhysConnection;
  FConnectionObj := AConnection;
  FConnectionObj.Lock;
  FConnectionObj.FTransactionList.Add(Self);
  FConnectionObj.UnLock;
  FSavepoints := TFDStringList.Create;
  SetOptions(nil);
  FMoniAdapterHelper := TFDMoniAdapterHelper.Create(Self, AConnection);
  FCommandList := TFDPtrList.Create;
  FStateHandlerList := TInterfaceList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysTransaction.Destroy;
begin
  Disconnect;
  FDHighRefCounter(FRefCount);
  try
    if FConnectionObj.FTransactionObj = Self then
      FConnectionObj.SetTransaction(nil);
    FConnectionObj.Lock;
    FConnectionObj.FTransactionList.Remove(Self);
    FConnectionObj.UnLock;
    InternalReleaseHandle;
    FDFreeAndNil(FSavepoints);
    FExternalOptions := nil;
    FDFreeAndNil(FOptions);
    FDFree(FMoniAdapterHelper);
    FMoniAdapterHelper := nil;
    FDFreeAndNil(FCommandList);
    FDFreeAndNil(FStateHandlerList);
    inherited Destroy;
  finally
    FRefCount := 0;
    FConnectionObj := nil;
    FConnection := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.Disconnect;
begin
  if not (GetState in [tsCommiting, tsRollingback]) and
     not (rfEmergencyClose in FConnectionObj.FRecoveryFlags) and
     not FSharedActive then
    case GetOptions.DisconnectAction of
    xdCommit:
      while GetActive do
        Commit;
    xdRollback:
      while GetActive do
        Rollback;
    end;
  TransactionFinished;
end;

{-------------------------------------------------------------------------------}
// Get/Set

function TFDPhysTransaction.GetActive: Boolean;
begin
  Result := FSavepoints.Count > 0;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTransaction.GetOptions: TFDTxOptions;
begin
  if FExternalOptions <> nil then
    Result := FExternalOptions
  else
    Result := FOptions;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTransaction.GetSerialID: LongWord;
begin
  if FSavepoints.Count > 0 then
    Result := FSavepoints.Ints[FSavepoints.Count - 1]
  else
    Result := 0;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTransaction.GetTopSerialID: LongWord;
begin
  if FSavepoints.Count > 0 then
    Result := FSavepoints.Ints[0]
  else
    Result := 0;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTransaction.GetNestingLevel: LongWord;
begin
  Result := FSavepoints.Count;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTransaction.GetConnection: IFDPhysConnection;
begin
  Result := FConnectionObj as IFDPhysConnection;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTransaction.GetCliObj: Pointer;
begin
  // nothing
  Result := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.SetOptions(const AValue: TFDTxOptions);
begin
  if (FExternalOptions <> AValue) or (FCommandList = nil) then begin
    FExternalOptions := AValue;
    if FExternalOptions = nil then
      FOptions := TFDTxOptions.Create
    else
      FDFreeAndNil(FOptions);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTransaction.GetState: TFDPhysTransactionState;
begin
  Result := FState;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTransaction.GetDriverID: String;
begin
  if FConnectionObj <> nil then
    Result := FConnectionObj.DriverID
  else
    Result := '';
end;

{-------------------------------------------------------------------------------}
// Commands management

procedure TFDPhysTransaction.DisconnectCommands(AFilter: TFDPhysDisconnectFilter;
  AMode: TFDPhysDisconnectMode);
var
  i: Integer;
  oCmd: TFDPhysCommand;
begin
  if not (rfEmergencyClose in FConnectionObj.FRecoveryFlags) then
    for i := FStateHandlerList.Count - 1 downto 0 do
      IFDPhysTransactionStateHandler(FStateHandlerList[i]).HandleDisconnectCommands(AFilter, AMode);
  for i := FCommandList.Count - 1 downto 0 do
    if i < FCommandList.Count then begin
      oCmd := TFDPhysCommand(FCommandList[i]);
      if (oCmd.GetState <> csInactive) and (not Assigned(AFilter) or AFilter(oCmd.GetCliObj)) then begin
        if oCmd.GetState in [csExecuting, csFetching, csAborting] then
          oCmd.AbortJob(True);
        case AMode of
        dmOffline: oCmd.Disconnect;
        dmRelease: oCmd.CloseAll;
        end;
      end;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.Stop(ASuccess: Boolean);
begin
  if not (GetState in [tsCommiting, tsRollingback]) and
     not (rfEmergencyClose in FConnectionObj.FRecoveryFlags) then
    while GetActive do
      try
        if xoFinishRetaining in GetOptions.StopOptions then
          if ASuccess then
            CommitRetaining
          else
            RollbackRetaining
        else
          if ASuccess then
            Commit
          else
            Rollback;
      except
        on E: EFDDBEngineException do begin
          if ASuccess and (E.Kind <> ekServerGone) then
            Stop(False);
          raise;
        end;
      end;
  TransactionFinished;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.CheckStoping(AAllowUnprepare, AForce, ASuccess: Boolean);
var
  i: Integer;
  oCmd: TFDPhysCommand;
  lStop: Boolean;
begin
  lStop := True;
  if not AForce then
    for i := FCommandList.Count - 1 downto 0 do begin
      oCmd := TFDPhysCommand(FCommandList[i]);
      case oCmd.GetState of
      csInactive:
        ;
      csPrepared:
        if not AAllowUnprepare or
           (oCmd.GetOptions.FetchOptions.AutoFetchAll = afDisable) then begin
          lStop := False;
          Break;
        end;
      csExecuting,
      csOpen,
      csFetching,
      csAborting:
        begin
          lStop := False;
          Break;
        end;
      end;
    end;
  if lStop then
    Stop(ASuccess);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.InternalCheckState(ACommandObj: TFDPhysCommand;
  ASuccess: Boolean);
begin
  if ASuccess then
    case ACommandObj.GetCommandKind of
    skStartTransaction: TransactionStarted;
    skCommit:           TransactionFinished;
    skRollback:         TransactionFinished;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.Notify(ANotification: TFDPhysTxNotification;
  ACommandObj: TFDPhysCommand);
begin
  if not (FState in [tsInactive, tsActive]) then
    Exit;
  // As result of InternalNotify, a transaction may be marked as finished,
  // then the associated commands belonging to components will be destroyed,
  // and Self may be destroyed (FRefCount = 0) earlier, then all processing
  // will be finished. So, temporary increment a reference.
  _AddRef;
  Inc(FNotifyCount);
  try
    InternalNotify(ANotification, ACommandObj);
  finally
    Dec(FNotifyCount);
    _Release;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.InternalNotify(ANotification: TFDPhysTxNotification;
  ACommandObj: TFDPhysCommand);
var
  oMeta: IFDPhysConnectionMetadata;
begin
  if ANotification in [cpBeforeCmdPrepare, cpAfterCmdPrepareSuccess,
                       cpAfterCmdPrepareFailure, cpAfterCmdUnprepare] then
    Exit;
  FConnectionObj.CreateMetadata(oMeta);
  if oMeta.TxSupported then begin
    FConnectionObj.Lock;
    try
      if oMeta.TxAutoCommit then
        case ANotification of
        cpBeforeCmdExecute:
          if not GetActive then
            Update;
        cpAfterCmdExecuteSuccess,
        cpAfterCmdExecuteFailure:
          InternalCheckState(ACommandObj, ANotification = cpAfterCmdExecuteSuccess);
        end
      else
        case ANotification of
        cpBeforeCmdExecute:
          if not (ACommandObj.GetCommandKind in [skStartTransaction, skCommit, skRollback]) then
            if GetOptions.AutoStart and not GetActive then begin
              StartTransaction;
              FIDAutoCommit := GetSerialID;
            end;
        cpAfterCmdExecuteSuccess,
        cpAfterCmdExecuteFailure:
          if not (ACommandObj.GetCommandKind in [skStartTransaction, skCommit, skRollback]) then begin
            if GetOptions.AutoStop and GetActive and
               (not (xoIfAutoStarted in GetOptions.StopOptions) or
                (FIDAutoCommit <> 0) and (FIDAutoCommit = GetSerialID)) then
              CheckStoping(True, True, ANotification <> cpAfterCmdExecuteFailure);
          end
          else
            InternalCheckState(ACommandObj, ANotification = cpAfterCmdExecuteSuccess);
        end;
    finally
      FConnectionObj.UnLock;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
// TX management

procedure TFDPhysTransaction.TxOperation(AOperation: TFDPhysTransactionState;
  ABefore: Boolean);
var
  i: Integer;
begin
  for i := FStateHandlerList.Count - 1 downto 0 do
    IFDPhysTransactionStateHandler(FStateHandlerList[i]).
      HandleTxOperation(AOperation, ABefore);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.TransactionStarted;
var
  ePrevState: TFDPhysTransactionState;
begin
  ePrevState := FState;
  FSavepoints.Clear;
  FIDAutoCommit := 0;
  Inc(FSerialID);
  FSavepoints.AddInt(IntToStr(FSerialID), FSerialID);
  FState := tsActive;
  if ePrevState = tsInactive then
    TxOperation(tsActive, False);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.TransactionFinished;
var
  ePrevState: TFDPhysTransactionState;
begin
  ePrevState := FState;
  FSavepoints.Clear;
  FIDAutoCommit := 0;
  FState := tsInactive;
  if ePrevState = tsActive then
    TxOperation(tsCommiting, False);
end;

{-------------------------------------------------------------------------------}
function TFDPhysTransaction.StartTransaction: LongWord;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    if not FMoniAdapterHelper.IsRegistered then
      FMoniAdapterHelper.RegisterClient(FConnectionObj.GetMonitor);
    FConnectionObj.Trace(ekConnTransact, esStart, 'StartTransaction',
      ['ConnectionDef', FConnectionObj.ConnectionDef.Name]);
  end;

  procedure Trace2;
  begin
    UpdateMonitor;
    FConnectionObj.Trace(ekConnTransact, esEnd, 'StartTransaction',
      ['ConnectionDef', FConnectionObj.ConnectionDef.Name]);
  end;
{$ENDIF}

var
  s: String;
  oMeta: IFDPhysConnectionMetadata;
  lExecuted: Boolean;
  iLastSerialID: LongWord;
begin
  TxOperation(tsActive, True);
{$IFDEF FireDAC_MONITOR}
  if FConnectionObj.GetTracing then Trace1;
  try
{$ENDIF}
    Result := 0;
    FConnectionObj.CheckActive;
    FConnectionObj.CreateMetadata(oMeta);
    if not oMeta.TxSupported then
      FDCapabilityNotSupported(Self, [S_FD_LPhys, DriverID]);
    FConnectionObj.Lock;
    if FSavepoints.Count = 0 then
      FState := tsStarting;
    try
      lExecuted := False;
      repeat
        try
          Result := FSerialID + 1;
          if (FSavepoints.Count > 0) and not GetOptions.EnableNested then
            FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccTxMBInActive, [ClassName]);
          if (FSavepoints.Count = 0) or oMeta.TxNested then begin
            Update;
            s := IntToStr(Result);
            InternalStartTransaction(Result);
          end
          else begin
            if not oMeta.TxSavepoints then
              FDCapabilityNotSupported(Self, [S_FD_LPhys, DriverID]);
            s := C_FD_SysSavepointPrefix + IntToStr(Result);
            InternalSetSavepoint(s);
          end;
          Inc(FSerialID);
          FSavepoints.AddInt(s, FSerialID);
          FState := tsActive;
          lExecuted := True;
          if (FNotifyCount = 0) and (FSavepoints.Count = 1) then
            FExplicitActive := True;
        except
          on E: EFDDBEngineException do
            if E.Kind = ekServerGone then begin
              iLastSerialID := FSerialID;
              FConnectionObj.RecoverConnection(Self, False);
              if iLastSerialID = FSerialID then
                TransactionFinished;
            end
            else
              raise;
        end;
      until lExecuted;
    finally
      // FConnectionObj is nil when connection recovery is aborted
      if FConnectionObj <> nil then begin
        if FSavepoints.Count = 0 then
          FState := tsInactive
        else
          FState := tsActive;
        FConnectionObj.UnLock;
      end;
    end;
{$IFDEF FireDAC_MONITOR}
  finally
    if (FConnectionObj <> nil) and FConnectionObj.GetTracing then Trace2;
  end;
{$ENDIF}
  TxOperation(tsActive, False);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.InternalSetSavepoint(const AName: String);
var
  oGen: IFDPhysCommandGenerator;
  s: String;
begin
  ConnectionObj.CreateCommandGenerator(oGen, nil);
  s := oGen.GenerateSavepoint(AName);
  if s <> '' then
    ConnectionObj.InternalExecuteDirect(s, Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.InternalRollbackToSavepoint(const AName: String);
var
  oGen: IFDPhysCommandGenerator;
  s: String;
begin
  ConnectionObj.CreateCommandGenerator(oGen, nil);
  s := oGen.GenerateRollbackToSavepoint(AName);
  if s <> '' then
    ConnectionObj.InternalExecuteDirect(s, Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.InternalCommitSavepoint(const AName: String);
var
  oGen: IFDPhysCommandGenerator;
  s: String;
begin
  ConnectionObj.CreateCommandGenerator(oGen, nil);
  s := oGen.GenerateCommitSavepoint(AName);
  if s <> '' then
    ConnectionObj.InternalExecuteDirect(s, Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.Commit;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FConnectionObj.Trace(ekConnTransact, esStart, 'Commit',
      ['ConnectionDef', FConnectionObj.ConnectionDef.Name,
       'Retaining', FRetaining]);
  end;

  procedure Trace2;
  begin
    UpdateMonitor;
    FConnectionObj.Trace(ekConnTransact, esEnd, 'Commit',
      ['ConnectionDef', FConnectionObj.ConnectionDef.Name,
       'Retaining', FRetaining]);
  end;
{$ENDIF}

var
  oMeta: IFDPhysConnectionMetadata;
  s: String;
  iLastSerialID: LongWord;
begin
  if not ((FState = tsActive) or not GetOptions.AutoStop) then
    Exit;
  TxOperation(tsCommiting, True);
{$IFDEF FireDAC_MONITOR}
  if FConnectionObj.GetTracing then Trace1;
{$ENDIF}
  FConnectionObj.Lock;
  FState := tsCommiting;
  try
    FConnectionObj.CheckActive(True);
    FConnectionObj.CreateMetadata(oMeta);
    if not oMeta.TxSupported then
      FDCapabilityNotSupported(Self, [S_FD_LPhys, DriverID]);
    if not (GetActive or not GetOptions.AutoStop) then
      FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccTxMBActive, [ClassName]);
    try
      if (FSavepoints.Count <= 1) or
         (FSavepoints.Count > 1) and oMeta.TxNested then
        InternalCommit(GetSerialID)
      else begin
        s := FSavepoints[FSavepoints.Count - 1];
        InternalCommitSavepoint(s);
        if FRetaining then
          InternalSetSavepoint(s);
      end;
      if not FRetaining and (FSavepoints.Count > 0) then
        FSavepoints.Delete(FSavepoints.Count - 1);
    except
      on E: EFDDBEngineException do
        if E.Kind = ekServerGone then begin
          iLastSerialID := FSerialID;
          FConnectionObj.RecoverConnection(Self, False);
          if iLastSerialID = FSerialID then
            TransactionFinished;
        end
        else
          raise;
    end;
  finally
    // FConnectionObj is nil when connection recovery is aborted
    if FConnectionObj <> nil then begin
      if FSavepoints.Count = 0 then begin
        FState := tsInactive;
        FExplicitActive := False;
      end
      else
        FState := tsActive;
      FConnectionObj.UnLock;
{$IFDEF FireDAC_MONITOR}
      if FConnectionObj.GetTracing then Trace2;
{$ENDIF}
    end;
  end;
  TxOperation(tsCommiting, False);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.CommitRetaining;
begin
  FRetaining := True;
  try
    Commit;
  finally
    FRetaining := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.Rollback;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FConnectionObj.Trace(ekConnTransact, esStart, 'Rollback',
      ['ConnectionDef', FConnectionObj.ConnectionDef.Name,
       'Retaining', FRetaining]);
  end;

  procedure Trace2;
  begin
    UpdateMonitor;
    FConnectionObj.Trace(ekConnTransact, esEnd, 'Rollback',
      ['ConnectionDef', FConnectionObj.ConnectionDef.Name,
       'Retaining', FRetaining]);
  end;
{$ENDIF}

var
  oMeta: IFDPhysConnectionMetadata;
  s: String;
  iLastSerialID: LongWord;
begin
  if not ((FState = tsActive) or not GetOptions.AutoStop) then
    Exit;
  TxOperation(tsRollingback, True);
{$IFDEF FireDAC_MONITOR}
  if FConnectionObj.GetTracing then Trace1;
{$ENDIF}
  FConnectionObj.Lock;
  FState := tsRollingback;
  try
    FConnectionObj.CheckActive(True);
    FConnectionObj.CreateMetadata(oMeta);
    if not oMeta.TxSupported then
      FDCapabilityNotSupported(Self, [S_FD_LPhys, DriverID]);
    if not (GetActive or not GetOptions.AutoStop) then
      FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccTxMBActive, []);
    try
      if (FSavepoints.Count <= 1) or
         (FSavepoints.Count > 1) and oMeta.TxNested then
        InternalRollback(GetSerialID)
      else begin
        s := FSavepoints[FSavepoints.Count - 1];
        InternalRollbackToSavepoint(s);
        if FRetaining then
          InternalSetSavepoint(s);
      end;
      if not FRetaining and (FSavepoints.Count > 0) then
        FSavepoints.Delete(FSavepoints.Count - 1);
    except
      on E: EFDDBEngineException do
        if E.Kind = ekServerGone then begin
          iLastSerialID := FSerialID;
          FConnectionObj.RecoverConnection(Self, False);
          if iLastSerialID = FSerialID then
            TransactionFinished;
        end
        else
          raise;
    end;
  finally
    // FConnectionObj is nil when connection recovery is aborted
    if FConnectionObj <> nil then begin
      if FSavepoints.Count = 0 then begin
        FState := tsInactive;
        FExplicitActive := False;
      end
      else
        FState := tsActive;
      FConnectionObj.UnLock;
{$IFDEF FireDAC_MONITOR}
      if FConnectionObj.GetTracing then Trace2;
{$ENDIF}
    end;
  end;
  TxOperation(tsRollingback, False);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.RollbackRetaining;
begin
  FRetaining := True;
  try
    Rollback;
  finally
    FRetaining := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.LockAutoStop;
var
  oTx: TFDTxOptions;
begin
  if FLockAutoStopCount = 0 then begin
    oTx := GetOptions;
    FPrevAutoStop := oTx.AutoStop;
    oTx.AutoStop := False;
    // Driver should not update CLI autocommit mode, so just clear xoAutoCommit.
    oTx.Changed := oTx.Changed - [xoAutoCommit, xoAutoStop];
  end;
  Inc(FLockAutoStopCount);
  if (FLockAutoStopCount = 1) and not GetActive then
    FExplicitActive := False;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.UnlockAutoStop(ASuccess, AAllowStop: Boolean);
var
  oTx: TFDTxOptions;
begin
  if FLockAutoStopCount > 0 then begin
    Dec(FLockAutoStopCount);
    if FLockAutoStopCount = 0 then begin
      oTx := GetOptions;
      oTx.AutoStop := FPrevAutoStop;
      // Driver should not update CLI autocommit mode, so just clear xoAutoCommit.
      oTx.Changed := oTx.Changed - [xoAutoCommit, xoAutoStop];
      if not FExplicitActive and FPrevAutoStop and AAllowStop then
        Stop(ASuccess);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.AddStateHandler(const AHandler: IFDPhysTransactionStateHandler);
begin
  FStateHandlerList.Add(AHandler);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.RemoveStateHandler(const AHandler: IFDPhysTransactionStateHandler);
begin
  FStateHandlerList.Remove(AHandler);
end;

{-------------------------------------------------------------------------------}
function TFDPhysTransaction.GetCLIAutoCommit: Boolean;
var
  oTx: TFDTxOptions;
begin
  oTx := GetOptions;
  if FLockAutoStopCount = 0 then
    Result := oTx.AutoCommit
  else
    Result := oTx.AutoStart and FPrevAutoStop and
      (xoIfAutoStarted in oTx.StopOptions) and (xoIfCmdsInactive in oTx.StopOptions);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.InternalChanged;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.Update;
var
  lExecuted: Boolean;
begin
  if GetOptions.Changed <> [] then begin
    FConnectionObj.Lock;
    try
      lExecuted := False;
      repeat
        try
          InternalChanged;
          lExecuted := True;
        except
          on E: EFDDBEngineException do
            if E.Kind = ekServerGone then
              FConnectionObj.RecoverConnection(Self, False)
            else
              raise;
        end;
      until lExecuted;
      GetOptions.ClearChanged;
    finally
      FConnectionObj.UnLock;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.ReleaseHandleBase;
begin
  GetOptions.ResetChanged;
  InternalReleaseHandle;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.InternalAllocHandle;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.InternalReleaseHandle;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.InternalSelect;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.InternalUnSelect;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
// IFDStanErrorHandler

procedure TFDPhysTransaction.HandleException(
  const AInitiator: IFDStanObject; var AException: Exception);
begin
  FConnectionObj.HandleException(AInitiator, AException);
end;

{-------------------------------------------------------------------------------}
// IFDStanObject

function TFDPhysTransaction.GetName: TComponentName;
begin
  Result := FMoniAdapterHelper.Name;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTransaction.GetParent: IFDStanObject;
begin
  Result := FMoniAdapterHelper.Parent;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.SetOwner(const AOwner: TObject;
  const ARole: TComponentName);
begin
  FMoniAdapterHelper.SetOwner(AOwner, ARole);
{$IFDEF FireDAC_MONITOR}
  FMoniAdapterHelper.UnRegisterClient;
  FMoniAdapterHelper.RegisterClient(FConnectionObj.GetMonitor);
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.BeforeReuse;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.AfterReuse;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
// IFDMoniAdapter

function TFDPhysTransaction.GetHandle: LongWord;
begin
  if FMoniAdapterHelper = nil then
    Result := 0
  else
    Result := FMoniAdapterHelper.Handle;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTransaction.GetSupportItems: TFDMoniAdapterItemKinds;
begin
  Result := [ikStat];
end;

{-------------------------------------------------------------------------------}
function TFDPhysTransaction.GetItemCount: Integer;
begin
  Result := 3;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTransaction.GetItem(AIndex: Integer; out AName: String;
  out AValue: Variant; out AKind: TFDMoniAdapterItemKind);
const
  C_States: array [TFDPhysTransactionState] of String = ('Inactive', 'Active',
    'Starting', 'Commiting', 'Rolling back');
begin
  case AIndex of
  0:
    begin
      AName := 'Commands';
      AValue := FCommandList.Count;
      AKind := ikStat;
    end;
  1:
    begin
      AName := 'Start count';
      AValue := FSerialID;
      AKind := ikStat;
    end;
  2:
    begin
      AName := 'State';
      AValue := C_States[FState];
      AKind := ikStat;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
procedure TFDPhysTransaction.UpdateMonitor;
begin
  if FConnectionObj.GetTracing then
    FConnectionObj.FMonitor.AdapterChanged(Self as IFDMoniAdapter);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TFDPhysEventThread                                                            }
{-------------------------------------------------------------------------------}
constructor TFDPhysEventThread.Create(AAlerter: TFDPhysEventAlerter);
begin
  inherited Create;
  FAlerter := AAlerter;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventThread.DoTimeout;
begin
  if Active and (FAlerter.GetOptions.Timeout > -1) then
    if FAlerter.GetOptions.Synchronize then
      TFDThread.Synchronize(FAlerter.DoTimeout)
    else
      FAlerter.DoTimeout;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysEventThread.GetStartMsgClass: TFDThreadMsgClass;
begin
  Result := TFDPhysEventStartMessage;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysEventThread.GetStopMsgClass: TFDThreadMsgClass;
begin
  Result := TFDPhysEventStopMessage;
end;

{-------------------------------------------------------------------------------}
function TFDPhysEventStartMessage.Perform(AThread: TFDThread): Boolean;
begin
  (AThread as TFDPhysEventThread).FAlerter.InternalRegister;
  Result := inherited Perform(AThread);
end;

{-------------------------------------------------------------------------------}
function TFDPhysEventStopMessage.Perform(AThread: TFDThread): Boolean;
begin
  (AThread as TFDPhysEventThread).FAlerter.InternalUnregister;
  Result := inherited Perform(AThread);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventMessage.BasePerform;
begin
  FMsgThread.FAlerter.InternalHandle(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysEventMessage.Perform(AThread: TFDThread): Boolean;
begin
  FMsgThread := AThread as TFDPhysEventThread;
  if FMsgThread.Active then begin
    if FMsgThread.FAlerter.GetOptions.Synchronize then
      TFDThread.Synchronize(BasePerform)
    else
      BasePerform;
  end;
  Result := True;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysEventAlerter                                                           }
{-------------------------------------------------------------------------------}
constructor TFDPhysEventAlerter.Create(AConnection: TFDPhysConnection;
  const AKind: String);
begin
  inherited Create;
  FConnection := AConnection as IFDPhysConnection;
  FConnectionObj := AConnection;
  FConnectionObj.Lock;
  FConnectionObj.FEventList.Add(Self);
  FConnectionObj.UnLock;
  FKind := AKind;
  FState := esInactive;
  FNames := TFDStringList.Create(dupError, False, False);
  FNames.OnChanging := DoNamesChanging;
  FChangeHandlers := TInterfaceList.Create;
  FChangeHandlerNames := TFDStringList.Create(dupAccept, False, False);
  SetOptions(nil);
  FMoniAdapterHelper := TFDMoniAdapterHelper.Create(Self, AConnection);
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysEventAlerter.Destroy;
begin
  Unregister;
  FDHighRefCounter(FRefCount);
  try
    FConnectionObj.Lock;
    FConnectionObj.FEventList.Remove(Self);
    FConnectionObj.UnLock;
    FExternalOptions := nil;
    FDFreeAndNil(FNames);
    FDFreeAndNil(FOptions);
    FDFreeAndNil(FChangeHandlers);
    FDFreeAndNil(FChangeHandlerNames);
    FDFree(FMoniAdapterHelper);
    FMoniAdapterHelper := nil;
    inherited Destroy;
  finally
    FRefCount := 0;
    FConnectionObj := nil;
    FConnection := nil;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysEventAlerter.GetConnection: IFDPhysConnection;
begin
  Result := FConnectionObj as IFDPhysConnection;
end;

{-------------------------------------------------------------------------------}
function TFDPhysEventAlerter.GetHandler: IFDPhysEventHandler;
begin
  Result := FHandler;
end;

{-------------------------------------------------------------------------------}
function TFDPhysEventAlerter.GetNames: TStrings;
begin
  Result := FNames;
end;

{-------------------------------------------------------------------------------}
function TFDPhysEventAlerter.GetSubscriptionName: String;
begin
  Result := FSubscriptionName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysEventAlerter.GetOptions: TFDEventAlerterOptions;
begin
  if FExternalOptions <> nil then
    Result := FExternalOptions
  else
    Result := FOptions;
end;

{-------------------------------------------------------------------------------}
function TFDPhysEventAlerter.GetState: TFDPhysEventAlerterState;
begin
  Result := FState;
end;

{-------------------------------------------------------------------------------}
function TFDPhysEventAlerter.GetKind: String;
begin
  Result := FKind;
end;

{-------------------------------------------------------------------------------}
function TFDPhysEventAlerter.GetDriverID: String;
begin
  if FConnectionObj <> nil then
    Result := FConnectionObj.DriverID
  else
    Result := '';
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.SetHandler(const AValue: IFDPhysEventHandler);
begin
  FHandler := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.SetNames(const AValue: TStrings);
begin
  if FNames <> AValue then begin
    Unregister;
    FNames.SetStrings(AValue);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.SetSubscriptionName(const AValue: String);
begin
  if FSubscriptionName <> AValue then begin
    Unregister;
    FSubscriptionName := AValue;
    if AValue <> '' then
      GetOptions.Synchronize := True;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.SetOptions(const AValue: TFDEventAlerterOptions);
begin
  if (FExternalOptions <> AValue) or (FMoniAdapterHelper = nil) then begin
    FExternalOptions := AValue;
    if FExternalOptions = nil then
      FOptions := TFDEventAlerterOptions.Create
    else
      FDFreeAndNil(FOptions);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.DoTimeout;
var
  lContinue: Boolean;
begin
  if GetOptions.Timeout > 0 then begin
    lContinue := True;
    InternalHandleTimeout(lContinue);
    if not lContinue then
      AbortJob;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.DoNamesChanging(ASender: TObject);
begin
  Unregister;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.Register;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    if not FMoniAdapterHelper.IsRegistered then
      FMoniAdapterHelper.RegisterClient(FConnectionObj.GetMonitor);
    FConnectionObj.Trace(ekConnService, esStart, 'RegisterEvent',
      ['ConnectionDef', FConnectionObj.ConnectionDef.Name,
       'Kind', GetKind]);
  end;

  procedure Trace2;
  begin
    UpdateMonitor;
    FConnectionObj.Trace(ekConnService, esEnd, 'RegisterEvent',
      ['ConnectionDef', FConnectionObj.ConnectionDef.Name,
       'Kind', GetKind]);
  end;
{$ENDIF}

begin
  if FState = esRegistered then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if FConnectionObj.GetTracing then Trace1;
  try
{$ENDIF}
    FConnectionObj.CheckActive;
    FConnectionObj.Lock;
    FState := esRegistering;
    try
      try
        InternalAllocHandle;
        FMsgThread := TFDPhysEventThread.Create(Self);
        if GetOptions.Timeout > 0 then
          FMsgThread.IdleTimeout := GetOptions.Timeout;
        FMsgThread.Active := True;
        FState := esRegistered;
      except
        InternalReleaseHandle;
        if FMsgThread <> nil then begin
          FMsgThread.Shutdown(True);
          FMsgThread := nil;
        end;
        FState := esInactive;
        raise;
      end;
    finally
      FConnectionObj.UnLock;
    end;
{$IFDEF FireDAC_MONITOR}
  finally
    if FConnectionObj.GetTracing then Trace2;
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.Unregister;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FConnectionObj.Trace(ekConnService, esStart, 'UnregisterEvent',
      ['ConnectionDef', FConnectionObj.ConnectionDef.Name,
       'Kind', GetKind]);
  end;

  procedure Trace2;
  begin
    UpdateMonitor;
    FConnectionObj.Trace(ekConnService, esEnd, 'UnregisterEvent',
      ['ConnectionDef', FConnectionObj.ConnectionDef.Name,
       'Kind', GetKind]);
  end;
{$ENDIF}

begin
  if FState = esInactive then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if FConnectionObj.GetTracing then Trace1;
  try
{$ENDIF}
    FConnectionObj.CheckActive(True);
    FConnectionObj.Lock;
    FState := esUnregistering;
    try
      AbortJob;
      FMsgThread.Shutdown(True);
      InternalReleaseHandle;
    finally
      FMsgThread := nil;
      FState := esInactive;
      MarkChangeHandlers(nil, False);
      FConnectionObj.UnLock;
    end;
{$IFDEF FireDAC_MONITOR}
  finally
    if FConnectionObj.GetTracing then Trace2;
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.Signal(const AEvent: String;
  const AArgument: Variant);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FConnectionObj.Trace(ekConnService, esStart, 'SignalEvent',
      ['ConnectionDef', FConnectionObj.ConnectionDef.Name,
       'Event', AEvent]);
  end;

  procedure Trace2;
  begin
    FConnectionObj.Trace(ekConnService, esEnd, 'SignalEvent',
      ['ConnectionDef', FConnectionObj.ConnectionDef.Name,
       'Event', AEvent]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if FConnectionObj.GetTracing then Trace1;
  try
{$ENDIF}
    FConnectionObj.CheckActive;
    InternalSignal(AEvent, AArgument);
{$IFDEF FireDAC_MONITOR}
  finally
    if FConnectionObj.GetTracing then Trace2;
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.Refresh(const AHandler: IFDPhysChangeHandler;
  AForce: Boolean);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FConnectionObj.Trace(ekConnService, esStart, 'Refresh',
      ['ConnectionDef', FConnectionObj.ConnectionDef.Name,
       'SubscriptionName', FSubscriptionName]);
  end;

  procedure Trace2;
  begin
    FConnectionObj.Trace(ekConnService, esEnd, 'Refresh',
      ['ConnectionDef', FConnectionObj.ConnectionDef.Name,
       'SubscriptionName', FSubscriptionName]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if FConnectionObj.GetTracing then Trace1;
  try
{$ENDIF}
    try
      FConnectionObj.CheckActive;
      if IsRunning then begin
        if AForce then
          MarkChangeHandlers(AHandler, True);
        InternalRefresh(AHandler);
      end;
    finally
      MarkChangeHandlers(AHandler, False);
    end;
{$IFDEF FireDAC_MONITOR}
  finally
    if FConnectionObj.GetTracing then Trace2;
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.AddChangeHandler(const AHandler: IFDPhysChangeHandler);
var
  oConnMeta: IFDPhysConnectionMetadata;
  rName: TFDPhysParsedName;
  s: String;
begin
  if FChangeHandlers.IndexOf(AHandler) = -1 then begin
    GetConnection.CreateMetadata(oConnMeta);
    oConnMeta.DecodeObjName(AHandler.TrackEventName, rName, nil,
      [doNormalize, doUnquote]);
    s := rName.FObject;
    FChangeHandlers.Add(AHandler);
    FChangeHandlerNames.Add(s);
    try
      InternalChangeHandlerModified(AHandler, s, opInsert);
    except
      RemoveChangeHandler(AHandler);
      raise;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.RemoveChangeHandler(const AHandler: IFDPhysChangeHandler);
var
  s: String;
  i: Integer;
begin
  i := FChangeHandlers.IndexOf(AHandler);
  if i >= 0 then begin
    s := FChangeHandlerNames[i];
    try
      InternalChangeHandlerModified(AHandler, s, opRemove);
    finally
      FChangeHandlers.Delete(i);
      FChangeHandlerNames.Delete(i);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.AbortJob;
begin
  try
    InternalAbortJob;
    FMsgThread.Active := False;
  except
    // not visible
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysEventAlerter.IsRunning: Boolean;
begin
  Result := (FMsgThread <> nil) and FMsgThread.Active and not FMsgThread.Finished and
    (FState <> esInactive);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.SetupCommand(const ACmd: IFDPhysCommand);
var
  oRes: TFDResourceOptions;
  oFtch: TFDFetchOptions;
begin
  oRes := ACmd.Options.ResourceOptions;
  oRes.PreprocessCmdText := True;
  oRes.CmdExecMode := amBlocking;
  oRes.CmdExecTimeout := $FFFFFFFF;
  oRes.DirectExecute := True;

  oFtch := ACmd.Options.FetchOptions;
  oFtch.AutoClose := True;
  oFtch.RecsSkip := -1;
  oFtch.RecsMax := -1;
  oFtch.Items := oFtch.Items - [fiMeta];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.MarkChangeHandlers(
  const AHandler: IFDPhysChangeHandler; AModified: Boolean);
var
  i: Integer;
begin
  if AHandler = nil then
    for i := FChangeHandlers.Count - 1 downto 0 do
      (FChangeHandlers[i] as IFDPhysChangeHandler).ContentModified := AModified
  else
    AHandler.ContentModified := AModified;
end;

{-------------------------------------------------------------------------------}
function TFDPhysEventAlerter.AreChangeHandlersModified: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := FChangeHandlers.Count - 1 downto 0 do
    if (FChangeHandlers[i] as IFDPhysChangeHandler).ContentModified then begin
      Result := True;
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.InternalAllocHandle;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.InternalRegister;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.InternalUnregister;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.InternalReleaseHandle;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.InternalAbortJob;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.InternalRefresh(const AHandler: IFDPhysChangeHandler);
var
  i: Integer;
  oHnlr: IFDPhysChangeHandler;
begin
  if AHandler = nil then
    for i := FChangeHandlers.Count - 1 downto 0 do begin
      oHnlr := FChangeHandlers[i] as IFDPhysChangeHandler;
      if oHnlr.ContentModified then
        oHnlr.RefreshContent;
    end
  else
    if AHandler.ContentModified then
      AHandler.RefreshContent;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.InternalHandleEvent(const AEventName: String;
  const AArgument: Variant);
var
  i: Integer;
  oHnlr: IFDPhysChangeHandler;
begin
  if GetSubscriptionName <> '' then begin
    i := FChangeHandlerNames.IndexOf(AEventName);
    if i >= 0 then
      oHnlr := FChangeHandlers[i] as IFDPhysChangeHandler
    else
      oHnlr := nil;
    MarkChangeHandlers(oHnlr, True);
    if (GetOptions.AutoRefresh = afAlert) and (TThread.CurrentThread.ThreadID = MainThreadID) then
      Refresh(oHnlr, False);
  end;
  if GetHandler <> nil then
    GetHandler.HandleEvent(AEventName, AArgument);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.InternalHandleTimeout(var AContinue: Boolean);
begin
  if (GetSubscriptionName <> '') and
     (GetOptions.AutoRefresh = afTimeout) and (TThread.CurrentThread.ThreadID = MainThreadID) and
     AreChangeHandlersModified then
    Refresh(nil, False);
  if GetHandler <> nil then
    GetHandler.HandleTimeout(AContinue);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.InternalChangeHandlerModified(
  const AHandler: IFDPhysChangeHandler; const AEventName: String;
  AOperation: TOperation);
var
  i: Integer;
begin
  case AOperation of
  opInsert:
    if (AEventName <> '') and (GetNames.IndexOf(AEventName) = -1) then
      GetNames.Add(AEventName);
  opRemove:
    if AEventName <> '' then begin
      i := GetNames.IndexOf(AEventName);
      if i <> -1 then
        GetNames.Delete(i);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
// IFDStanErrorHandler

procedure TFDPhysEventAlerter.HandleException(
  const AInitiator: IFDStanObject; var AException: Exception);
begin
  FConnectionObj.HandleException(AInitiator, AException);
end;

{-------------------------------------------------------------------------------}
// IFDStanObject

function TFDPhysEventAlerter.GetName: TComponentName;
begin
  Result := FMoniAdapterHelper.Name;
end;

{-------------------------------------------------------------------------------}
function TFDPhysEventAlerter.GetParent: IFDStanObject;
begin
  Result := FMoniAdapterHelper.Parent;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.SetOwner(const AOwner: TObject;
  const ARole: TComponentName);
begin
  FMoniAdapterHelper.SetOwner(AOwner, ARole);
{$IFDEF FireDAC_MONITOR}
  FMoniAdapterHelper.UnRegisterClient;
  FMoniAdapterHelper.RegisterClient(FConnectionObj.GetMonitor);
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.BeforeReuse;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.AfterReuse;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
// IFDMoniAdapter

function TFDPhysEventAlerter.GetHandle: LongWord;
begin
  if FMoniAdapterHelper = nil then
    Result := 0
  else
    Result := FMoniAdapterHelper.Handle;
end;

{-------------------------------------------------------------------------------}
function TFDPhysEventAlerter.GetSupportItems: TFDMoniAdapterItemKinds;
begin
  Result := [ikStat];
end;

{-------------------------------------------------------------------------------}
function TFDPhysEventAlerter.GetItemCount: Integer;
begin
  Result := 1;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysEventAlerter.GetItem(AIndex: Integer; out AName: String;
  out AValue: Variant; out AKind: TFDMoniAdapterItemKind);
const
  C_States: array [TFDPhysEventAlerterState] of String = ('Inactive', 'Registering',
    'Registered', 'Unregistering', 'Fired');
begin
  case AIndex of
  0:
    begin
      AName := 'State';
      AValue := C_States[FState];
      AKind := ikStat;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
procedure TFDPhysEventAlerter.UpdateMonitor;
begin
  if FConnectionObj.GetTracing then
    FConnectionObj.FMonitor.AdapterChanged(Self as IFDMoniAdapter);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TFDPhysCommandAsyncOperation                                                  }
{-------------------------------------------------------------------------------}
type
  TFDPhysCommandAsyncOperation = class(TInterfacedObject, IFDStanAsyncOperation)
  protected
    FCommand: TFDPhysCommand;
    // IFDStanAsyncOperation
    procedure Execute; virtual; abstract;
    procedure AbortJob;
    function AbortSupported: Boolean;
  public
    constructor Create(ACmd: TFDPhysCommand);
    destructor Destroy; override;
  end;

{-------------------------------------------------------------------------------}
constructor TFDPhysCommandAsyncOperation.Create(ACmd: TFDPhysCommand);
begin
  inherited Create;
  FCommand := ACmd;
{$IFNDEF NEXTGEN}
  FCommand._AddRef;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysCommandAsyncOperation.Destroy;
begin
{$IFNDEF NEXTGEN}
  FCommand._Release;
{$ENDIF}
  FCommand := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommandAsyncOperation.AbortJob;
begin
  FCommand.AbortJob;
  while FCommand.GetState = csAborting do
    Sleep(1);
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommandAsyncOperation.AbortSupported: Boolean;
var
  oConnMeta: IFDPhysConnectionMetadata;
begin
  FCommand.GetConnection.CreateMetadata(oConnMeta);
  Result := oConnMeta.AsyncAbortSupported;
end;

{ ----------------------------------------------------------------------------- }
{ TFDPhysCommand                                                                }
{ ----------------------------------------------------------------------------- }
// Constructors

constructor TFDPhysCommand.Create(AConnection: TFDPhysConnection);
begin
  inherited Create;
  FConnection := AConnection as IFDPhysConnection;
  FConnectionObj := AConnection;
  FConnectionObj.Lock;
  FConnectionObj.FCommandList.Add(Self);
  FConnectionObj.UnLock;
  FParams := TFDParams.CreateRefCounted(GetParamsOwner);
  FMacros := TFDMacros.CreateRefCounted(GetParamsOwner);
  SetOptions(nil);
  FObjectScopes := [osMy];
  FTableKinds := [tkSynonym, tkTable, tkView];
  FBuffer := TFDBuffer.Create;
  FMoniAdapterHelper := TFDMoniAdapterHelper.Create(Self, FConnectionObj);
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysCommand.Destroy;
begin
  FDHighRefCounter(FRefCount);
  Disconnect;
{$IFDEF FireDAC_MONITOR}
  if FConnectionObj.GetTracing then
    FConnectionObj.FMonitor.Notify(ekLiveCycle, esProgress, Self, 'Destroy',
      ['Command', GetTraceCommandText]);
{$ENDIF}
  try
    SetTransaction(nil);
    FConnectionObj.Lock;
    FConnectionObj.FCommandList.Remove(Self);
    FConnectionObj.UnLock;
    FParams.RemRef;
    FParams := nil;
    FMacros.RemRef;
    FMacros := nil;
    FOptions := nil;
    FDFreeAndNil(FBuffer);
    inherited Destroy;
  finally
    FDFree(FMoniAdapterHelper);
    FMoniAdapterHelper := nil;
    FTransactionObj := nil;
    FTransaction := nil;
    FConnectionObj := nil;
    FConnection := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.CreateCommandGenerator(out AGen: IFDPhysCommandGenerator);
begin
  FConnection.CreateCommandGenerator(AGen, Self);
  AGen.Params := GetParams;
  AGen.Options := Self as IFDStanOptions;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetParamsOwner: TPersistent;
begin
  Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetDriverID: String;
begin
  if FConnectionObj <> nil then
    Result := FConnectionObj.DriverID
  else
    Result := '';
end;

{-------------------------------------------------------------------------------}
// Tracing

function TFDPhysCommand.GetTraceCommandText(const ACmd: String): String;

  function GetLoc: String;
  begin
    Result := '';
    if GetCatalogName <> '' then
      Result := Result + GetCatalogName + '.';
    if GetSchemaName <> '' then
      Result := Result + GetSchemaName + '.';
    if GetBaseObjectName <> '' then
      Result := Result + GetBaseObjectName + '.';
  end;

var
  sCmd: String;
begin
  if ACmd <> '' then
    sCmd := ACmd
  else
    sCmd := FCommandText;
  if FMetaInfoKind = mkNone then begin
    if FCommandKind in [skStoredProc, skStoredProcWithCrs, skStoredProcNoCrs] then begin
      Result := GetLoc + sCmd;
      if FOverload <> 0 then
        Result := Result + ';' + IntTostr(FOverload);
    end
    else
      Result := sCmd;
  end
  else begin
    sCmd := TrimRight(sCmd);
    case FMetaInfoKind of
    mkCatalogs:         Result := 'Catalog List';
    mkSchemas:          Result := 'Schemas List';
    mkTables:           Result := 'Table List';
    mkTableFields:      Result := 'Table Fields (' + GetLoc + sCmd + ')';
    mkIndexes:          Result := 'Table Indexes (' + GetLoc + sCmd + ')';
    mkIndexFields:      Result := 'Table Index Fields (' + GetLoc + FBaseObjectName + ', ' + sCmd + ')';
    mkPrimaryKey:       Result := 'Table PKeys (' + GetLoc + sCmd + ')';
    mkPrimaryKeyFields: Result := 'Table PKey Fields (' + GetLoc + FBaseObjectName + ')';
    mkForeignKeys:      Result := 'Table FKeys (' + GetLoc + sCmd + ')';
    mkForeignKeyFields: Result := 'Table FKey Fields (' + GetLoc + FBaseObjectName + ', ' + sCmd + ')';
    mkPackages:         Result := 'Packages(' + GetLoc + ')';
    mkProcs:            Result := 'Procedures (' + GetLoc + FBaseObjectName  + ')';
    mkProcArgs:         Result := 'Procedure Args (' + GetLoc + FBaseObjectName + ', ' + sCmd + ')';
    mkGenerators:       Result := 'Generator List';
    mkResultSetFields:  Result := 'ResultSet Fields (' + sCmd + ')';
    mkTableTypeFields:  Result := 'Table Type Fields (' + GetLoc + sCmd + ')';
    end;
  end;
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.Trace(AKind: TFDMoniEventKind;
  AStep: TFDMoniEventStep; const AMsg: String; const AArgs: array of const);
begin
  if FConnectionObj.GetTracing then
    FConnectionObj.FMonitor.Notify(AKind, AStep, Self, AMsg, AArgs);
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.EnterTrace(AConnObj: TFDPhysConnection): Boolean;
begin
  // _AddRef / _Release will preserve command from distruction before esEnd
  // trace call: esStart try ... finally esEnd end. Otherwise to many times
  // will be required to handle this situation.
  _AddRef;
  Result := AConnObj.GetTracing;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.ExitTrace(AConnObj: TFDPhysConnection; var AUpdateMonitor: Boolean): Boolean;
begin
  Result := AConnObj.GetTracing;
  AUpdateMonitor := _Release > 0;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
// Options

function TFDPhysCommand.GetOptions: IFDStanOptions;
begin
  Result := Self as IFDStanOptions;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.GetParentOptions(var AOpts: IFDStanOptions);
begin
  AOpts := FConnectionObj as IFDStanOptions;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetOptions(const AValue: IFDStanOptions);
begin
  if (FOptions <> AValue) or (FBuffer = nil) then begin
    FOptions := AValue;
    if FOptions = nil then
      FOptions := TFDOptionsContainer.Create(nil, TFDFetchOptions,
        TFDBottomUpdateOptions, TFDBottomResourceOptions, GetParentOptions);
  end;
end;

{-------------------------------------------------------------------------------}
// Exception handling

function TFDPhysCommand.GetErrorHandler: IFDStanErrorHandler;
begin
  Result := FErrorHandler;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetErrorHandler(const AValue: IFDStanErrorHandler);
begin
  FErrorHandler := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.HandleException(const AInitiator: IFDStanObject;
  var AException: Exception);
begin
{$IFDEF FireDAC_MONITOR}
  if not (AException is EFDDBEngineException) and FConnectionObj.GetTracing then
    Trace(ekError, esProgress, AException.Message, []);
{$ENDIF}
  if Assigned(GetErrorHandler()) then
    GetErrorHandler().HandleException(AInitiator, AException);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.ParTypeUnknownError(AParam: TFDParam);
begin
  FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccParTypeUnknown, [AParam.Name]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.ParTypeMapError(AParam: TFDParam);
begin
  FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccParDataMapNotSup, [AParam.Name]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.ParDefChangedError(ADataType: TFieldType; AParam: TFDParam);
begin
  FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccParDefChanged,
    [AParam.Name, FieldTypeNames[ADataType], FieldTypeNames[AParam.DataType]]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.ParSetChangedError(AExpected, AActual: Integer);
begin
  FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccParSetChanged, [AExpected, AActual]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.ColTypeMapError(AColumn: TFDDatSColumn);
begin
  FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccColDataMapNotSup, [AColumn.SourceName]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.UnsupParamObjError(AParam: TFDParam);
begin
  FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccUnsupParamObjValue,
    [AParam.SQLName, FieldTypeNames[AParam.DataType]]);
end;

{-------------------------------------------------------------------------------}
// Get/set props

function TFDPhysCommand.GetState: TFDPhysCommandState;
begin
  Result := FState;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetState(const AValue: TFDPhysCommandState);
begin
  FState := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetConnection: IFDPhysConnection;
begin
  Result := FConnection;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetCommandText: String;
begin
  Result := FCommandText;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetCommandText(const AValue: String);
begin
  if FCommandText <> AValue then begin
    Disconnect;
    FCommandText := AValue;
    Preprocess;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetParams: TFDParams;
begin
  Result := FParams;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetMacros: TFDMacros;
begin
  Result := FMacros;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetParams(AValue: TFDParams);
begin
  if AValue = FParams then
    Exit;
  if FParams <> nil then
    if FParams.IsRefCounted then
      FParams.RemRef
    else
      FDFree(FParams);
  FParams := AValue;
  if FParams <> nil then begin
    if FParams.IsRefCounted then
      FParams.AddRef;
  end
  else
    FParams := TFDParams.CreateRefCounted(GetParamsOwner);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetMacros(AValue: TFDMacros);
begin
  if AValue = FMacros then
    Exit;
  if FMacros <> nil then
    if FMacros.IsRefCounted then
      FMacros.RemRef
    else
      FDFree(FMacros);
  FMacros := AValue;
  if FMacros <> nil then begin
    if FMacros.IsRefCounted then
      FMacros.AddRef;
  end
  else
    FMacros := TFDMacros.CreateRefCounted(GetParamsOwner);
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetCommandKind: TFDPhysCommandKind;
begin
  Result := FCommandKind;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetCommandKind(const AValue: TFDPhysCommandKind);
begin
  FCommandKind := AValue;
  FFixedCommandKind := (AValue <> skUnknown);
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetSourceObjectName: String;
begin
  Result := FSourceObjectName;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetSourceObjectName(const AValue: String);
begin
  FSourceObjectName := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetSourceRecordSetName: String;
begin
  Result := FSourceRecordSetName;
  if Result = '' then
    Result := GetSourceObjectName
  else if FRecordSetIndex > 0 then
    Result := Result + '#' + IntToStr(FRecordSetIndex);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetSourceRecordSetName(const AValue: String);
begin
  FSourceRecordSetName := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetOverload: Word;
begin
  Result := FOverload;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetOverload(const AValue: Word);
begin
  if AValue <> FOverload then begin
    Disconnect;
    FOverload := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetBaseObjectName: String;
begin
  Result := FBaseObjectName;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetBaseObjectName(const AValue: String);
begin
  if AValue <> FBaseObjectName then begin
    Disconnect;
    FBaseObjectName := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetSchemaName: String;
begin
  Result := FSchemaName;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetSchemaName(const AValue: String);
begin
  if AValue <> FSchemaName then begin
    Disconnect;
    FSchemaName := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetCatalogName: String;
begin
  Result := FCatalogName;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetCatalogName(const AValue: String);
begin
  if AValue <> FCatalogName then begin
    Disconnect;
    FCatalogName := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetNextRecordSet: Boolean;
begin
  Result := FNextRecordSet;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetNextRecordSet(const AValue: Boolean);
begin
  FNextRecordSet := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetMappingHandler: IFDPhysMappingHandler;
begin
  Result := FMappingHandler;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetMappingHandler(const AValue: IFDPhysMappingHandler);
begin
  FMappingHandler := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetSQLOrderByPos: Integer;
begin
  Result := FSQLOrderByPos;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysCommand.GetCliObj: Pointer;
begin
  Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetSQLText: String;
begin
  Result := FDbCommandText;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetTransaction: IFDPhysTransaction;
begin
  Result := FTransaction;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetTransaction(const AValue: IFDPhysTransaction);
var
  oTxObj: TFDPhysTransaction;
begin
  CheckState(csInactive);
  if AValue <> FTransaction then begin
    if FTransactionObj <> nil then begin
{$IFDEF FireDAC_MONITOR}
      if FMoniAdapterHelper.IsRegistered and
         (FMoniAdapterHelper.Parent = IFDStanObject(FTransactionObj)) then begin
        FMoniAdapterHelper.UnRegisterClient;
        FMoniAdapterHelper.SetOwner(FConnectionObj, '');
      end;
{$ENDIF}
      FConnectionObj.Lock;
      FTransactionObj.FCommandList.Remove(Self);
      FConnectionObj.UnLock;
      FTransaction := nil;
      FTransactionObj := nil;
    end;
    if AValue <> nil then begin
      oTxObj := AValue as TFDPhysTransaction;
      if oTxObj.FConnectionObj <> FConnectionObj then
        FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccCantAssignTxIntf, []);
      FTransaction := AValue;
      FTransactionObj := oTxObj;
      FConnectionObj.Lock;
      FTransactionObj.FCommandList.Add(Self);
      FConnectionObj.UnLock;
{$IFDEF FireDAC_MONITOR}
      if FMoniAdapterHelper.Parent = IFDStanObject(FConnectionObj) then begin
        if FMoniAdapterHelper.IsRegistered then
          FMoniAdapterHelper.UnRegisterClient;
        FMoniAdapterHelper.SetOwner(FTransactionObj, '');
      end;
{$ENDIF}
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetStateHandler: IFDPhysCommandStateHandler;
begin
  Result := FStateHandler;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetStateHandler(const AValue: IFDPhysCommandStateHandler);
begin
  FStateHandler := AValue;
end;

{-------------------------------------------------------------------------------}
// Metainfo get/set

function TFDPhysCommand.GetMetaInfoKind: TFDPhysMetaInfoKind;
begin
  Result := FMetaInfoKind;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetMetaInfoKind(AValue: TFDPhysMetaInfoKind);
begin
  if AValue <> FMetaInfoKind then begin
    Disconnect;
    FMetaInfoKind := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetTableKinds: TFDPhysTableKinds;
begin
  Result := FTableKinds;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetTableKinds(AValue: TFDPhysTableKinds);
begin
  if AValue <> FTableKinds then begin
    Disconnect;
    FTableKinds := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetWildcard: String;
begin
  Result := FWildcard;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetWildcard(const AValue: String);
begin
  if AValue <> FWildcard then begin
    Disconnect;
    FWildcard := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetObjectScopes: TFDPhysObjectScopes;
begin
  Result := FObjectScopes;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetObjectScopes(AValue: TFDPhysObjectScopes);
begin
  if AValue <> FObjectScopes then begin
    Disconnect;
    FObjectScopes := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
// Runtime cycle

procedure TFDPhysCommand.ExecuteTask(const AOperation: IFDStanAsyncOperation;
  const AHandler: IFDStanAsyncHandler; ABlocked: Boolean);
var
  eMode: TFDStanAsyncMode;
  oRes: TFDResourceOptions;
  oConnMeta: IFDPhysConnectionMetadata;
  iTimeout: LongWord;
begin
  oRes := FOptions.ResourceOptions;
  eMode := oRes.CmdExecMode;
  if ABlocked and (eMode = amAsync) then
    eMode := amBlocking;
  FConnection.CreateMetadata(oConnMeta);
  if oConnMeta.AsyncNativeTimeout and (eMode = amBlocking) then
    iTimeout := $FFFFFFFF
  else
    iTimeout := oRes.CmdExecTimeout;
  try
    if FExecutor = nil then
      FDCreateInterface(IFDStanAsyncExecutor, FExecutor);
    FExecutor.Setup(AOperation, eMode, iTimeout, AHandler, oRes.ActualSilentMode);
  except
    on E: Exception do begin
      if AHandler <> nil then
        AHandler.HandleFinished(Self, asFailed, E);
      raise;
    end;
  end;
  FExecutor.Run;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.Disconnect;
begin
  CheckAsyncProgress;
  if GetState = csOpen then
    CloseAll;
  if GetState = csPrepared then
    Unprepare;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.CheckAsyncProgress;
begin
  if GetState in [csExecuting, csFetching] then
    FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccAsyncOperInProgress, []);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.CheckState(ARequiredState: TFDPhysCommandState);
begin
  if GetState <> ARequiredState then
    FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccCantChngCommandState, []);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.AbortJob(const AWait: Boolean = False);
var
  oConnMeta: IFDPhysConnectionMetadata;
begin
  if (FThreadID <> 0) and (FThreadID = TThread.CurrentThread.ThreadID) then begin
    if FState = csFetching then
      FState := csOpen
    else if FState = csExecuting then
      FState := csPrepared;
    Exit;
  end;
  FConnection.CreateMetadata(oConnMeta);
  if oConnMeta.AsyncAbortSupported and (GetState in [csExecuting, csFetching]) then
    try
      FState := csAborting;
      InternalAbort;
    except
      on E: EFDDBEngineException do
        if (E.Kind = ekServerGone) and (GetState = csAborting) then
          FState := csPrepared;
    end;
  if AWait then begin
    while (GetState in [csExecuting, csFetching, csAborting]) or
          (FThreadID <> 0) do
      Sleep(1);
    if (FExecutor <> nil) and (FExecutor.Operation <> nil) then begin
      Sleep(1);
      if TThread.CurrentThread.ThreadID = MainThreadID then
        CheckSynchronize();
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.InternalAbort;
begin
  FDCapabilityNotSupported(Self, [S_FD_LPhys, DriverID]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.PreprocessCommand(ACreateParams, ACreateMacros,
  AExpandParams, AExpandMacros, AExpandEscapes, AParseSQL: Boolean);
var
  oPP: TFDPhysPreprocessor;
  oPList: TFDParams;
  oMList: TFDMacros;
  oConnMeta: IFDPhysConnectionMetadata;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ekCmdPrepare, esProgress, 'Preprocessed', ['CMD', FDbCommandText,
      'FROM', oPP.SQLFromValue, 'VP', oPP.SQLValuesPos, 'VPE', oPP.SQLValuesPosEnd,
      'OBP', oPP.SQLOrderByPos, 'CK', Integer(oPP.SQLCommandKind)]);
  end;
{$ENDIF}

begin
  if not (ACreateParams or ACreateMacros or AExpandParams or AExpandMacros or
          AExpandEscapes or AParseSQL) then
    Exit;
  oPList := nil;
  oMList := nil;
  oPP := TFDPhysPreprocessor.Create;
  oPP.Instrs := [];
  if AExpandParams then begin
    oPP.Instrs := oPP.Instrs + [piExpandParams];
    oPList := GetParams;
  end;
  if AExpandMacros then begin
    oPP.Instrs := oPP.Instrs + [piExpandMacros];
    oMList := GetMacros;
  end;
  if AExpandEscapes then
    oPP.Instrs := oPP.Instrs + [piExpandEscapes];
  if AParseSQL then
    oPP.Instrs := oPP.Instrs + [piParseSQL, piTransformEOLs];
  if ACreateParams then begin
    oPList := TFDParams.CreateRefCounted(GetParamsOwner);
    oPList.BindMode := GetParams.BindMode;
    oPP.Instrs := oPP.Instrs + [piCreateParams];
  end;
  if ACreateMacros then begin
    oMList := TFDMacros.CreateRefCounted(GetParamsOwner);
    oPP.Instrs := oPP.Instrs + [piCreateMacros];
  end;
  try
    FConnection.CreateMetadata(oConnMeta);
    oPP.ConnMetadata := oConnMeta;
    oPP.Source := FCommandText;
    oPP.Params := oPList;
    oPP.MacrosRead := GetMacros;
    oPP.MacrosUpd := oMList;
    oPP.Execute;
    if AParseSQL then begin
      FDbCommandText := oPP.Destination;
{$IFDEF FireDAC_MONITOR}
      if FConnectionObj.GetTracing then Trace1;
{$ENDIF}
      if not FFixedCommandKind and (GetCommandKind = skUnknown) then begin
        SetCommandKind(oPP.SQLCommandKind);
        FFixedCommandKind := False;
      end;
      SetSourceObjectName(oPP.SQLFromValue);
      FSQLValuesPos := oPP.SQLValuesPos;
      FSQLValuesPosEnd := oPP.SQLValuesPosEnd;
      FSQLOrderByPos := oPP.SQLOrderByPos;
      FSQLLimitSkip := oPP.SQLLimitSkip;
      FSQLLimitRows := oPP.SQLLimitRows;
    end;
    if ACreateParams then begin
      oPList.AssignValues(GetParams);
      GetParams.Assign(oPList);
    end;
    if ACreateMacros then begin
      oMList.AssignValues(GetMacros);
      GetMacros.TempLockUpdate;
      GetMacros.Assign(oMList);
    end;
  finally
    if ACreateParams then
      oPList.RemRef;
    if ACreateMacros then
      oMList.RemRef;
    FDFree(oPP);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.CheckPreprocessCommand(ACreateParams: Boolean);
var
  oRes: TFDResourceOptions;
begin
  if not (GetCommandKind in [skStoredProc, skStoredProcWithCrs, skStoredProcNoCrs]) and
     (GetMetaInfoKind = mkNone) then begin
    oRes := FOptions.ResourceOptions;
    PreprocessCommand(oRes.ParamCreate and ACreateParams, oRes.MacroCreate and ACreateParams,
      oRes.ParamExpand, oRes.MacroExpand, oRes.EscapeExpand, True);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.Preprocess;
begin
  CheckPreprocessCommand(True);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.Prepare(const ACommandText: String = ''; ACreateParams: Boolean = True);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    if not FMoniAdapterHelper.IsRegistered then
      FMoniAdapterHelper.RegisterClient(FConnectionObj.GetMonitor);
    Trace(ekCmdPrepare, esStart, 'Prepare', ['Command', GetTraceCommandText(ACommandText)]);
  end;

  procedure Trace2(AUpdateMonitor: Boolean);
  begin
    if AUpdateMonitor then UpdateMonitor;
    Trace(ekCmdPrepare, esEnd, 'Prepare', ['Command', GetTraceCommandText]);
  end;
{$ENDIF}

var
  lPrepared: Boolean;
{$IFDEF FireDAC_MONITOR}
  lUpdateMonitor: Boolean;
{$ENDIF}
begin
  if (GetState <> csInactive) and (ACommandText = '') then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if EnterTrace(FConnectionObj) then Trace1;
  try
{$ENDIF}
    Disconnect;
    ASSERT(FConnection <> nil);
    if FTransaction = nil then begin
      SetTransaction(FConnection.Transaction);
      ASSERT(FTransaction <> nil);
    end;
    FConnectionObj.CheckActive(True);
    if ACommandText <> '' then
      FCommandText := ACommandText;
    if (GetMetaInfoKind = mkNone) and (GetCommandText = '') then
      FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccCommandMBFilled, []);
    FSQLLimitSkip := -1;
    FSQLLimitRows := -1;
    CheckPreprocessCommand((ACommandText <> '') and ACreateParams);
    GetParams.Prepare(GetOptions.FormatOptions.DefaultParamDataType,
                      GetOptions.ResourceOptions.DefaultParamType);
    FBuffer.Release;
    FRecordSetIndex := -1;
    FConnectionObj.IncPrepared(Self);
    try
      lPrepared := False;
      repeat
        try
          FTransactionObj.Notify(cpBeforeCmdPrepare, Self);
          if (GetMetaInfoKind = FireDAC.Phys.Intf.mkNone) or CheckMetaAvailability then
            InternalPrepare;
          lPrepared := True;
        except
          on E: Exception do begin
            InternalUnprepare;
            if (E is EFDDBEngineException) and (EFDDBEngineException(E).Kind = ekServerGone) then
              FConnectionObj.RecoverConnection(Self, False)
            else
              raise;
          end;
        end;
      until lPrepared;
      FTransactionObj.Notify(cpAfterCmdPrepareSuccess, Self);
    except
      GetParams.Markers.Clear;
      FConnectionObj.DecPrepared;
      FTransactionObj.Notify(cpAfterCmdPrepareFailure, Self);
      raise;
    end;
    FState := csPrepared;
{$IFDEF FireDAC_MONITOR}
  finally
    if ExitTrace(FConnectionObj, lUpdateMonitor) then Trace2(lUpdateMonitor);
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.Unprepare;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ekCmdPrepare, esStart, 'Unprepare', ['Command', GetTraceCommandText]);
  end;

  procedure Trace2(AUpdateMonitor: Boolean);
  begin
    if AUpdateMonitor then UpdateMonitor;
    Trace(ekCmdPrepare, esEnd, 'Unprepare', ['Command', GetTraceCommandText]);
  end;
{$ENDIF}

var
  lDestroyed: Boolean;
{$IFDEF FireDAC_MONITOR}
  oConn: TFDPhysConnection;
  lUpdateMonitor: Boolean;
{$ENDIF}
begin
  if GetState = csInactive then
    Exit;
  if (GetStateHandler <> nil) and not (rfEmergencyClose in FConnectionObj.FRecoveryFlags) then begin
    CheckAsyncProgress;
    _AddRef;
    try
      GetStateHandler.HandleUnprepare;
    finally
      lDestroyed := _Release = 0;
    end;
    if lDestroyed or (GetState = csInactive) then
      Exit;
  end;
{$IFDEF FireDAC_MONITOR}
  oConn := FConnectionObj;
  if EnterTrace(oConn) then Trace1;
  try
{$ENDIF}
    CheckAsyncProgress;
    if GetState = csOpen then
      CloseAll;
    if GetState = csInactive then
      Exit;
    CheckState(csPrepared);
    FBuffer.Release;
    try
      InternalUnprepare;
    except
      on E: EFDDBEngineException do
        if E.Kind <> ekServerGone then
          raise;
    end;
    GetParams.Unprepare;
    FConnectionObj.DecPrepared;
    FExecuteCount := 0;
    FRecordsFetched := 0;
    if not FFixedCommandKind then
      SetCommandKind(skUnknown);
    SetSourceObjectName('');
    FExecutor := nil;
    FState := csInactive;
    FTransactionObj.Notify(cpAfterCmdUnprepare, Self);
{$IFDEF FireDAC_MONITOR}
  finally
    if ExitTrace(oConn, lUpdateMonitor) then Trace2(lUpdateMonitor);
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.GenerateStoredProcParams(const AName: TFDPhysParsedName;
  AOverload: Word = 0);
var
  oGen: IFDPhysCommandGenerator;
begin
  CreateCommandGenerator(oGen);
  FDbCommandText := oGen.GenerateStoredProcParams(AName.FCatalog, AName.FSchema,
    AName.FBaseObject, AName.FObject, AOverload);
  if GetCommandKind = skStoredProc then
    SetCommandKind(oGen.CommandKind);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.GenerateStoredProcCall(const AName: TFDPhysParsedName;
  ASPUsage: TFDPhysCommandKind = skStoredProc);
var
  oGen: IFDPhysCommandGenerator;
begin
  CreateCommandGenerator(oGen);
  FDbCommandText := oGen.GenerateStoredProcCall(AName.FCatalog, AName.FSchema,
    AName.FBaseObject, AName.FObject, ASPUsage);
  SetCommandKind(oGen.CommandKind);
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.CheckMetaAvailability: Boolean;
var
  rName1, rName2: TFDPhysParsedName;
  oGen: IFDPhysCommandGenerator;
  oConnMeta: IFDPhysConnectionMetadata;
begin
  // 1) Special single row tables have no indexes and constraints.
  // Avoiding querying metainfo for them optimizes execution.
  // 2) MySQL: "SHOW INDEX FOR dual" always returns an error.
  // 3) Informix: "select DBINFO('sqlca.sqlerrd1') from SYSMASTER:"informix".SYSDUAL"
  // with fiMeta will always return 0, because mkPrimaryKeyFields execution clears
  // sqlca.sqlerrd1 content.
  Result := True;
  if (GetMetaInfoKind in [mkIndexes, mkIndexFields,
                          mkPrimaryKey, mkPrimaryKeyFields,
                          mkForeignKeys, mkForeignKeyFields]) then begin
    FConnection.CreateCommandGenerator(oGen, Self);
    if oGen.SingleRowTable <> '' then begin

      FConnection.CreateMetadata(oConnMeta);
      oConnMeta.DecodeObjName(oGen.SingleRowTable, rName2, nil,
        [doNormalize, doUnquote]);

      GetSelectMetaInfoParams(rName1);
      if CompareText(rName1.FBaseObject, rName2.FObject) = 0 then
        Result := False;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.GetSelectMetaInfoParams(out AName: TFDPhysParsedName);
var
  sCmd: String;
  oConnMeta: IFDPhysConnectionMetadata;
begin
  sCmd := Trim(GetCommandText());
  if GetMetaInfoKind() = mkResultSetFields then
    AName.FObject := sCmd
  else if (GetMetaInfoKind() in [mkCatalogs, mkSchemas, mkTables, mkPackages, mkGenerators]) or
          (GetMetaInfoKind() = mkProcs) and (GetBaseObjectName = '') then begin
    AName.FCatalog := GetCatalogName;
    AName.FSchema := GetSchemaName;
  end
  else begin
    FConnection.CreateMetadata(oConnMeta);
    oConnMeta.DecodeObjName(sCmd, AName, Self, [doNormalize, doUnquote, doMetaParams]);
  end;
  CheckMetaInfoParams(AName);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.GenerateSelectMetaInfo(const AName: TFDPhysParsedName);
var
  oGen: IFDPhysCommandGenerator;
  i: Integer;
  oPar: TFDParam;
begin
  GetMacros.Clear;
  GetParams.Clear;
  CreateCommandGenerator(oGen);
  FDbCommandText := oGen.GenerateSelectMetaInfo(GetMetaInfoKind(),
    AName.FCatalog, AName.FSchema, AName.FBaseObject, AName.FObject,
    GetWildcard(), GetObjectScopes(), GetTableKinds(), GetOverload());
  SetCommandKind(oGen.CommandKind);
  for i := 0 to GetParams.Count - 1 do begin
    oPar := GetParams[i];
    if CompareText(oPar.Name, 'CAT') = 0 then
      oPar.Value := AName.FCatalog
    else if CompareText(oPar.Name, 'SCH') = 0 then
      oPar.Value := AName.FSchema
    else if CompareText(oPar.Name, 'BAS') = 0 then
      oPar.Value := AName.FBaseObject
    else if CompareText(oPar.Name, 'OBJ') = 0 then
      oPar.Value := AName.FObject
    else if CompareText(oPar.Name, 'WIL') = 0 then
      oPar.Value := GetWildcard()
    else if CompareText(oPar.Name, 'OVE') = 0 then
      oPar.Value := GetOverload();
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.GenerateLimitSelect();
var
  oFtchOpts: TFDFetchOptions;

  procedure DoGenerate(ASkip, ARows: Integer);
  var
    oGen: IFDPhysCommandGenerator;
  begin
    CreateCommandGenerator(oGen);
    FDbCommandText := oGen.GenerateLimitSelect(ASkip, ARows,
      (oFtchOpts.Mode = fmExactRecsMax) and (ARows >= 0));
    FSQLOrderByPos := oGen.SQLOrderByPos;
  end;

begin
  oFtchOpts := FOptions.FetchOptions;
  if (FSQLLimitSkip <> -1) or (FSQLLimitRows <> -1) then
    DoGenerate(FSQLLimitSkip, FSQLLimitRows)
  else if (oFtchOpts.RecsSkip <> -1) or
          (oFtchOpts.RecsMax <> -1) and (oFtchOpts.Mode <> fmExactRecsMax) then
    DoGenerate(oFtchOpts.RecsSkip, oFtchOpts.RecsMax);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.GenerateParamMarkers();
var
  i: Integer;
  oPars: TFDParams;
begin
  oPars := GetParams();
  if (oPars.Markers.Count = 0) and (oPars.Count > 0) then
    for i := 0 to oPars.Count - 1 do
      oPars.Markers.Add(oPars[i].Name);
end;

{-------------------------------------------------------------------------------}
// Query open / close

type
  TFDPhysCommandAsyncOpen = class(TFDPhysCommandAsyncOperation)
  protected
    procedure Execute; override;
  end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommandAsyncOpen.Execute;
begin
  FCommand.OpenBase;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.CheckMetaInfoParams(const AName: TFDPhysParsedName);

  procedure CheckRequired(const AValue, ASubMsg: String);
  begin
    if AValue = '' then
      FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccMetaInfoNotDefined, [ASubMsg]);
  end;

const
  STabName: String = 'table name';
  SProcName: String = 'procedure name';
  SIndexName: String = 'index name';
  SFKName: String = 'foreign key name';
  STabTypeName: String = 'table type name';
begin
  case GetMetaInfoKind of
  mkCatalogs,
  mkSchemas,
  mkTables:
    ;
  mkTableFields:
    CheckRequired(AName.FObject, STabName);
  mkIndexes:
    CheckRequired(AName.FObject, STabName);
  mkIndexFields:
    begin
      CheckRequired(AName.FBaseObject, STabName);
      CheckRequired(AName.FObject, SIndexName);
    end;
  mkPrimaryKey:
    CheckRequired(AName.FObject, STabName);
  mkPrimaryKeyFields:
    CheckRequired(AName.FBaseObject, STabName);
  mkForeignKeys:
    CheckRequired(AName.FObject, STabName);
  mkForeignKeyFields:
    begin
      CheckRequired(AName.FBaseObject, STabName);
      CheckRequired(AName.FObject, SFKName);
    end;
  mkPackages,
  mkProcs:
    ;
  mkProcArgs:
    CheckRequired(AName.FObject, SProcName);
  mkGenerators,
  mkResultSetFields:
    ;
  mkTableTypeFields:
    CheckRequired(AName.FObject, STabTypeName);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.OpenBase;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ekCmdExecute, esStart, 'Open', ['Command', GetTraceCommandText]);
  end;

  procedure Trace2(AUpdateMonitor: Boolean);
  begin
    if AUpdateMonitor then UpdateMonitor;
    Trace(ekCmdExecute, esEnd, 'Open', ['Command', GetTraceCommandText]);
  end;
{$ENDIF}

var
  lOpened: Boolean;
  lExecuted: Boolean;
{$IFDEF FireDAC_MONITOR}
  lUpdateMonitor: Boolean;
{$ENDIF}
begin
  if GetState = csOpen then
    Exit
  else if GetState = csAborting then begin
    FState := csPrepared;
    Exit;
  end;

{$IFDEF FireDAC_MONITOR}
  if EnterTrace(FConnectionObj) then Trace1;
{$ENDIF}
  try
    if not GetNextRecordSet then
      FConnectionObj.SaveLastAutoGenValue(Null);

    CheckAsyncProgress;
    if GetState = csInactive then
      Prepare;
    CheckState(csPrepared);

    FState := csExecuting;
    FThreadID := TThread.CurrentThread.ThreadID;
    FExecutor.Launched;
    lOpened := False;
    try

      try
        lExecuted := False;
        repeat
          if not GetNextRecordSet then
            FTransactionObj.Notify(cpBeforeCmdExecute, Self);
          try
            if not GetNextRecordSet then
              lOpened := InternalOpen
            else
              lOpened := InternalNextRecordSet;
            lExecuted := True;
          except
            on E: EFDDBEngineException do begin
              if E.Kind = ekServerGone then begin
                FConnectionObj.RecoverConnection(Self, False);
                if GetNextRecordSet then begin
                  lOpened := False;
                  lExecuted := True;
                end
              end
              else
                raise;
            end;
          end;
        until lExecuted;

      finally
        if FState = csAborting then begin
          lOpened := False;
          InternalClose;
        end;
        if lOpened then begin
          FState := csOpen;
          FBuffer.Check;
          FEof := False;
          FFirstFetch := True;
          FRecordsFetched := 0;
          Inc(FExecuteCount);
          Inc(FRecordSetIndex);
        end
        else if FState <> csInactive then
          FState := csPrepared;
      end;

    except
      if not GetNextRecordSet then
        FTransactionObj.Notify(cpAfterCmdExecuteFailure, Self);
      raise;
    end;
    if not lOpened then
      FTransactionObj.Notify(cpAfterCmdExecuteSuccess, Self);

  finally
    FThreadID := 0;
{$IFDEF FireDAC_MONITOR}
    if ExitTrace(FConnectionObj, lUpdateMonitor) then Trace2(lUpdateMonitor);
{$ENDIF}
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.OpenBlocked: Boolean;
begin
  if GetState <> csOpen then
    Open(True);
  Result := (GetState = csOpen);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.Open(ABlocked: Boolean = False);
var
  oOper: IFDStanAsyncOperation;
begin
  oOper := TFDPhysCommandAsyncOpen.Create(Self) as IFDStanAsyncOperation;
  ExecuteTask(oOper, GetStateHandler, ABlocked);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.Close;

{$IFDEF FireDAC_MONITOR}
var
  oConn: TFDPhysConnection;
  lUpdateMonitor: Boolean;
  sCmdText: String;
  procedure Trace1;
  begin
    sCmdText := GetTraceCommandText;
    Trace(ekCmdExecute, esStart, 'Close', ['Command', sCmdText]);
  end;

  procedure Trace2(AUpdateMonitor: Boolean);
  begin
    if AUpdateMonitor then UpdateMonitor;
    oConn.Trace(ekCmdExecute, esEnd, 'Close', ['Command', sCmdText]);
  end;
{$ENDIF}

begin
  if GetState in [csInactive, csPrepared] then
    Exit;
{$IFDEF FireDAC_MONITOR}
  oConn := FConnectionObj;
  if EnterTrace(oConn) then Trace1;
  try
{$ENDIF}
    CheckAsyncProgress;
    if GetState = csOpen then
      try
        try
          InternalClose;
        except
          on E: EFDDBEngineException do
            if E.Kind <> ekServerGone then
              raise;
        end;
      finally
        if GetState <> csInactive then
          FState := csPrepared;
        FRecordSetIndex := -1;
        if not GetNextRecordSet then
          FTransactionObj.Notify(cpAfterCmdExecuteSuccess, Self);
      end;
{$IFDEF FireDAC_MONITOR}
  finally
    if ExitTrace(oConn, lUpdateMonitor) then Trace2(lUpdateMonitor);
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.CloseAll;
begin
  GetParams.Close;
  SetNextRecordSet(False);
  Close;
end;

{-------------------------------------------------------------------------------}
// Defining

function TFDPhysCommand.InternalUseStandardMetadata: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.DoDefineDataTable(ADatSManager: TFDDatSManager;
  ATable: TFDDatSTable; ARootID: Integer; const ARootName: String;
  AMetaInfoMergeMode: TFDPhysMetaInfoMergeMode): TFDDatSTable;
var
  i, j: Integer;
  oFmtOpts: TFDFormatOptions;
  oUpdOpts: TFDBottomUpdateOptions;
  rTabInfo: TFDPhysDataTableInfo;
  rColInfo: TFDPhysDataColumnInfo;
  oChildTab: TFDDatSTable;
  oCol, oChildTabRelCol, oROWIDCol: TFDDatSColumn;
  oRel: TFDDatSRelation;
  lTabCreated, lColCreated, lInUpdate: Boolean;
  oCreatedList: TFDObjList;
  oOriginCols: TFDStringList;
  sName, sTabName, sFirstOriginTabName: String;
  lDefPK, lPKDefined, lNoRowSet, lExtAttrs: Boolean;
  oConnMeta: IFDPhysConnectionMetadata;
  oPKFieldsView: TFDDatSView;
  rMappedTab: TFDPhysMappingName;
  eLocalMetaInfoMergeMode: TFDPhysMetaInfoMergeMode;
  rName, rName1, rName2: TFDPhysParsedName;
  lOriginProvided, lUpdBaseFieldsOnly, lOriginUseful: Boolean;
  iArrayItem: Integer;
  lTabIsArray: Boolean;

  function EnsureTabExistance(ADatSManager: TFDDatSManager; var ASourceID: Integer;
    var ASourceName, ADatSName: String; var ATabCreated: Boolean): TFDDatSTable;
  var
    i: Integer;
    eMapResult: TFDPhysMappingResult;
    sTmp: String;
    oTab: TFDDatSTable;
  begin
    if ATable <> nil then
      Result := ATable
    else
      Result := nil;
    ATabCreated := False;
    ADatSName := '';
    eMapResult := mrDefault;
    sTmp := '';
    oTab := nil;
    rMappedTab := TFDPhysMappingName.Create(0, nkDefault);
    if ((ADatSManager = nil) or (AMetaInfoMergeMode <> mmRely)) and
       (GetMappingHandler <> nil) then begin
      if ASourceID >= 0 then
        eMapResult := GetMappingHandler.MapRecordSet(TFDPhysMappingName.Create(ASourceID, nkID),
          ASourceID, ASourceName, ADatSName, sTmp, oTab);
      if eMapResult = mrMapped then
        rMappedTab := TFDPhysMappingName.Create(ASourceID, nkID)
      else begin
        eMapResult := GetMappingHandler.MapRecordSet(TFDPhysMappingName.Create(ASourceName, nkSource),
          ASourceID, ASourceName, ADatSName, sTmp, oTab);
        if eMapResult = mrMapped then
          rMappedTab := TFDPhysMappingName.Create(ASourceName, nkSource);
      end;
      if (eMapResult = mrMapped) and (ATable = nil) then
        Result := oTab
    end;
    if eMapResult = mrDefault then
      if (ADatSManager <> nil) and (ATable = nil) then begin
        if eLocalMetaInfoMergeMode <> mmReset then begin
          if ASourceName <> '' then
            i := ADatSManager.Tables.IndexOfSourceName(ASourceName)
          else
            i := -1;
          if (i = -1) and (ASourceID >= 0) then
            i := ADatSManager.Tables.IndexOfSourceID(ASourceID);
          if i <> -1 then
            Result := ADatSManager.Tables[i];
        end;
      end;
    if Result = nil then begin
      if (eLocalMetaInfoMergeMode <> mmRely) and ((ARootID <> -1) or (eMapResult <> mrNotMapped)) then begin
        Result := TFDDatSTable.Create;
        Result.CountRef(0);
        oCreatedList.Add(Result);
        ATabCreated := True;
      end;
    end
    else
      if (eLocalMetaInfoMergeMode = mmRely) and (ATable <> nil) and (ATable <> Result) then
        FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccMetaInfoMismatch, []);
    if Result <> nil then
      Result.Setup(FOptions);
  end;

  function EnsureColExistance(ATable: TFDDatSTable; var ASourceID: Integer;
    var ASourceName, ADatSName: String; var AColCreated: Boolean): TFDDatSColumn;
  var
    i: Integer;
    eMapResult: TFDPhysMappingResult;
    sTmp: String;
    oCol: TFDDatSColumn;
  begin
    Result := nil;
    AColCreated := False;
    ADatSName := '';
    sTmp := '';
    oCol := nil;
    eMapResult := mrDefault;
    if ((ATable = nil) or (AMetaInfoMergeMode <> mmRely)) and
       (GetMappingHandler <> nil) and (rMappedTab.FKind <> nkDefault) then begin
      if ASourceID >= 0 then
        eMapResult := GetMappingHandler.MapRecordSetColumn(rMappedTab,
          TFDPhysMappingName.Create(ASourceID, nkID),
          ASourceID, ASourceName, ADatSName, sTmp, oCol);
      if eMapResult <> mrMapped then
        eMapResult := GetMappingHandler.MapRecordSetColumn(rMappedTab,
          TFDPhysMappingName.Create(ASourceName, nkSource),
          ASourceID, ASourceName, ADatSName, sTmp, oCol);
      if (oCol <> nil) and (oCol.Table = ATable) and (eMapResult = mrMapped) then
        Result := oCol;
    end;
    if eMapResult = mrDefault then
      if eLocalMetaInfoMergeMode <> mmReset then begin
        if ASourceName <> '' then
          i := ATable.Columns.IndexOfSourceName(ASourceName)
        else
          i := -1;
        if (i = -1) and (ASourceID >= 0) then
          i := ATable.Columns.IndexOfSourceID(ASourceID);
        if i <> -1 then
          Result := ATable.Columns[i];
      end;
    if Result = nil then
      if (eLocalMetaInfoMergeMode <> mmRely) and (eMapResult <> mrNotMapped) then begin
        Result := TFDDatSColumn.Create;
        oCreatedList.Add(Result);
        AColCreated := True;
      end;
  end;

  procedure CheckColMatching(AColumn: TFDDatSColumn; const AInfo: TFDPhysDataColumnInfo);
  begin
    if not ((AColumn.SourceDataType = AInfo.FSourceType) and
            (AnsiCompareText(AColumn.SourceName, AInfo.FSourceName) = 0) and
            (AColumn.SourceID = AInfo.FSourceID)) then
      FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccMetaInfoMismatch, []);
  end;

  function GetDatSManager: TFDDatSManager;
  begin
    if ADatSManager <> nil then
      Result := ADatSManager
    else if ATable <> nil then
      Result := ATable.Manager
    else
      Result := nil;
  end;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ekCmdPrepare, esProgress, 'Col add (ref)',
      ['Index', ATable.Columns.Count, 'Name', oCol.SourceName,
       '@Type', C_FD_DataTypeNames[oCol.SourceDataType], 'TypeName',
       oCol.SourceDataTypeName]);
  end;

  procedure Trace2;
  begin
    Trace(ekCmdPrepare, esProgress, 'Col add',
      ['Index', ATable.Columns.Count, 'SrcName', oCol.SourceName,
       '@SrcType', C_FD_DataTypeNames[oCol.SourceDataType],
       'SrcSize', oCol.SourceSize, 'SrcPrec', oCol.SourcePrecision,
       'SrcScale', oCol.SourceScale, '@Type', C_FD_DataTypeNames[oCol.DataType],
       'Size', oCol.Size, 'Prec', oCol.Precision, 'Scale', oCol.Scale,
       'OrigTabName', oCol.OriginTabName, 'OrigColName', oCol.OriginColName]);
  end;

  procedure Trace3;
  begin
    Trace(ekCmdPrepare, esProgress, 'Primary key',
      ['Cols', oPKFieldsView.Rows.GetValuesList('COLUMN_NAME', ';', '')]);
  end;      
{$ENDIF}

begin
  FConnection.CreateMetadata(oConnMeta);
  rName.FCatalog := '';
  rName.FSchema := '';
  rName.FBaseObject := '';
  rName.FLink := '';
  
  eLocalMetaInfoMergeMode := AMetaInfoMergeMode;
  if GetMetaInfoKind <> mkNone then begin
    if eLocalMetaInfoMergeMode <> mmReset then
      FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccMetaInfoReset, []);
    Result := ATable;
    if Result = nil then begin
      Result := TFDDatSTable.Create;
      Result.CountRef(0);
      Result.Setup(FOptions);
      Result.Name := oConnMeta.DefineMetadataTableName(GetMetaInfoKind);
      if GetDatSManager <> nil then
        GetDatSManager.Tables.Add(Result);
    end
    else
      Result.Reset;
    oConnMeta.DefineMetadataStructure(Result, GetMetaInfoKind);
    Exit;
  end;

  oFmtOpts := FOptions.FormatOptions;
  oUpdOpts := FOptions.UpdateOptions as TFDBottomUpdateOptions;
  if oUpdOpts.UpdateTableName <> '' then
    sTabName := oUpdOpts.UpdateTableName
  else
    sTabName := GetSourceObjectName;
  oROWIDCol := nil;
  oPKFieldsView := nil;
  if (oUpdOpts.KeyFields <> '') or not InternalUseStandardMetadata then begin
    lDefPK := False;
    lPKDefined := False;
  end
  else begin
    lDefPK := (ARootID = -1) and (fiMeta in FOptions.FetchOptions.Items) and (sTabName <> '') and
      not ((sTabName[1] = '(') and (sTabName[Length(sTabName)] = ')')) and
      (Pos('''', sTabName) = 0);
    lPKDefined := False;
  end;
  lNoRowSet := False;
  lTabCreated := False;
  lExtAttrs := False;
  lTabIsArray := False;
  sName := '';
  sFirstOriginTabName := '';
  lOriginProvided := False;
  lOriginUseful := True;
  oCreatedList := TFDObjList.Create;
  oOriginCols := TFDStringList.Create(dupIgnore, True, False);
  try
    try
      if lDefPK then
        oPKFieldsView := oConnMeta.GetTablePrimaryKeyFields(GetCatalogName,
          GetSchemaName, sTabName, '');
      rTabInfo.FSourceID := ARootID;
      rTabInfo.FArraySize := -1;
      if not InternalColInfoStart(rTabInfo) then begin
        lNoRowSet := True;
        ATable := nil;
      end
      else begin
        if ARootID = -1 then
          rTabInfo.FSourceName := GetSourceRecordSetName
        else
          rTabInfo.FSourceName := ARootName + '.' + rTabInfo.FOriginName;
        lTabIsArray := rTabInfo.FArraySize >= 0;
        ATable := EnsureTabExistance(ADatSManager, rTabInfo.FSourceID,
          rTabInfo.FSourceName, sName, lTabCreated);
        if ATable <> nil then begin
          if (eLocalMetaInfoMergeMode = mmOverride) and lTabCreated then
            eLocalMetaInfoMergeMode := mmReset
          else if (eLocalMetaInfoMergeMode = mmReset) and not lTabCreated then
            ATable.Reset;
          if (eLocalMetaInfoMergeMode <> mmRely) or lTabCreated then begin
            if sName <> '' then
              ATable.Name := sName
            else if GetDatSManager <> nil then
              ATable.Name := GetDatSManager.Tables.BuildUniqueName(rTabInfo.FSourceName)
            else
              ATable.Name := rTabInfo.FSourceName;
            ATable.SourceName := rTabInfo.FSourceName;
            ATable.SourceID := rTabInfo.FSourceID;
            ATable.MinimumCapacity := FOptions.FetchOptions.ActualRowsetSize;
            if (GetDatSManager <> nil) and (ATable.Manager <> GetDatSManager) then begin
              if ATable.Manager <> nil then
                ATable.Manager.Tables.Remove(ATable, True);
              GetDatSManager.Tables.Add(ATable);
            end;
          end;
        end;
      end;
      if ATable <> nil then begin
        FillChar(rColInfo, SizeOf(TFDPhysDataColumnInfo), 0);
        rColInfo.FParentTableSourceID := ARootID;
        rColInfo.FTableSourceID := rTabInfo.FSourceID;
        iArrayItem := 0;
        while (iArrayItem = 0) and InternalColInfoGet(rColInfo) or
              lTabIsArray and (iArrayItem < rTabInfo.FArraySize) do begin
          if lTabIsArray then begin
            rColInfo.FSourceName := Format('%s[%d]', [rTabInfo.FOriginName, iArrayItem]);
            rColInfo.FSourceID := iArrayItem;
          end
          else if rColInfo.FSourceName = '' then begin
            Include(rColInfo.FAttrs, caUnnamed);
            rColInfo.FSourceName := S_FD_Unnamed + IntToStr(rColInfo.FSourceID);
          end
          else if StrLIComp(PChar(rColInfo.FSourceName),
                            PChar(C_FD_SysColumnPrefix),
                            Length(C_FD_SysColumnPrefix)) = 0 then begin
            Include(rColInfo.FAttrs, caInternal);
            if not (caROWID in rColInfo.FAttrs) then
              Include(rColInfo.FAttrs, caReadOnly);
            rColInfo.FSourceName := Copy(rColInfo.FSourceName,
              Length(C_FD_SysColumnPrefix) + 1, MAXINT);
            if rColInfo.FOriginColName = '' then
              rColInfo.FOriginColName := rColInfo.FSourceName;
          end;

          lColCreated := False;
          if rColInfo.FType in [dtRowSetRef, dtCursorRef, dtRowRef, dtArrayRef] then begin
            if GetDatSManager <> nil then begin
              oChildTab := DoDefineDataTable(GetDatSManager, nil, rColInfo.FSourceID,
                rTabInfo.FSourceName, AMetaInfoMergeMode);
              if oChildTab <> nil then begin
                oCol := EnsureColExistance(ATable, rColInfo.FSourceID,
                  rColInfo.FSourceName, sName, lColCreated);
                if (oCol <> nil) and (eLocalMetaInfoMergeMode <> mmRely) or lColCreated then begin
                  if lColCreated or (oCol.Name = '') then
                    if sName <> '' then
                      oCol.Name := sName
                    else
                      oCol.Name := ATable.Columns.BuildUniqueName(rColInfo.FSourceName);
                  oCol.DataType := rColInfo.FType;
                  oCol.SourceName := rColInfo.FSourceName;
                  oCol.SourceID := rColInfo.FSourceID;
                  oCol.SourceDataType := rColInfo.FSourceType;
                  oCol.SourceDataTypeName := rColInfo.FSourceTypeName;
                  oCol.OriginTabName := oConnMeta.EncodeObjName(rColInfo.FOriginTabName, nil, [eoBeautify]);
                  rName.FObject := rColInfo.FOriginColName;
                  oCol.OriginColName := oConnMeta.EncodeObjName(rName, nil, [eoBeautify]);
                  oCol.Attributes := rColInfo.FAttrs - [caSearchable];
                  oCol.Options := oCol.Options + rColInfo.FForceAddOpts - rColInfo.FForceRemOpts;
                  if lColCreated then
                    ATable.Columns.Add(oCol);
{$IFDEF FireDAC_MONITOR}
                  if FConnectionObj.GetTracing then Trace1;
{$ENDIF}
                  if lColCreated then begin
                    oChildTabRelCol := TFDDatSColumn.Create;
                    oCreatedList.Add(oChildTabRelCol);
                    oChildTabRelCol.Name := oChildTab.Columns.BuildUniqueName(
                      C_FD_SysNamePrefix + '#' + ATable.Name);
                    oChildTabRelCol.DataType := dtParentRowRef;
                    oChildTabRelCol.SourceDataType := dtUnknown;
                    oChildTabRelCol.SourceID := -1;
                    oChildTabRelCol.Attributes := oCol.Attributes + [caInternal] - [caSearchable];
                    oChildTab.Columns.Add(oChildTabRelCol);

                    oRel := TFDDatSRelation.Create;
                    oCreatedList.Add(oRel);
                    oRel.Nested := True;
                    oRel.Name := GetDatSManager.Relations.BuildUniqueName(
                      C_FD_SysNamePrefix + '#' + ATable.Name + '#' + oChildTab.Name);
                    oRel.ParentTable := ATable;
                    oRel.ParentColumnNames := oCol.Name;
                    oRel.ChildTable := oChildTab;
                    oRel.ChildColumnNames := oChildTabRelCol.Name;
                    GetDatSManager.Relations.Add(oRel);
                  end;
                end;
              end;
            end;
          end

          else begin
            oCol := EnsureColExistance(ATable, rColInfo.FSourceID,
              rColInfo.FSourceName, sName, lColCreated);
            if (oCol <> nil) and (eLocalMetaInfoMergeMode <> mmRely) or lColCreated then begin
              if lColCreated or (oCol.Name = '') then
                if sName <> '' then
                  oCol.Name := sName
                else
                  oCol.Name := ATable.Columns.BuildUniqueName(rColInfo.FSourceName);
              oCol.SourceName := rColInfo.FSourceName;
              oCol.SourceID := rColInfo.FSourceID;
              oCol.SourceDataType := rColInfo.FSourceType;
              oCol.SourceDataTypeName := rColInfo.FSourceTypeName;
              oCol.SourcePrecision := rColInfo.FPrec;
              oCol.SourceScale := rColInfo.FScale;
              oCol.SourceSize := rColInfo.FLen;
              oCol.OriginTabName := oConnMeta.EncodeObjName(rColInfo.FOriginTabName, nil, [eoBeautify]);
              if sFirstOriginTabName = '' then begin
                sFirstOriginTabName := oCol.OriginTabName;
                if (GetSourceObjectName <> '') and (sFirstOriginTabName <> '') and
                   (oUpdOpts.UpdateTableName = '') then begin
                  oConnMeta.DecodeObjName(GetSourceObjectName, rName1, nil, [doUnquote]);
                  oConnMeta.DecodeObjName(sFirstOriginTabName, rName2, nil, [doUnquote]);
                  if CompareText(rName1.FObject, rName2.FObject) <> 0 then
                    lOriginUseful := False;
                end;
              end;
              rName.FObject := rColInfo.FOriginColName;
              oCol.OriginColName := oConnMeta.EncodeObjName(rName, nil, [eoBeautify]);
              oCol.Attributes := rColInfo.FAttrs;
              if caROWID in oCol.Attributes then
                oROWIDCol := oCol;
              oCol.DataType := rColInfo.FType;
              case oCol.DataType of
              dtAnsiString,
              dtWideString,
              dtByteString:
                if rColInfo.FLen <> LongWord(-1) then
                  oCol.Size := rColInfo.FLen;
              dtSByte,
              dtInt16,
              dtInt32,
              dtInt64,
              dtByte,
              dtUInt16,
              dtUInt32,
              dtUInt64:
                oCol.Precision := rColInfo.FPrec;
              dtSingle,
              dtDouble,
              dtExtended,
              dtCurrency,
              dtBCD,
              dtFmtBCD:
                begin
                  if oFmtOpts.DataSnapCompatibility and (rColInfo.FPrec > 32) then begin
                    if rColInfo.FPrec = rColInfo.FScale then
                      rColInfo.FScale := rColInfo.FPrec div 3;
                    rColInfo.FPrec := 32;
                  end;
                  oCol.Precision := rColInfo.FPrec;
                  oCol.Scale := rColInfo.FScale;
                end;
              dtDateTime,
              dtDateTimeStamp,
              dtTime:
                oCol.Scale := rColInfo.FScale;
              dtTimeIntervalFull,
              dtTimeIntervalYM,
              dtTimeIntervalDS:
                begin
                  oCol.Precision := rColInfo.FPrec;
                  oCol.Scale := rColInfo.FScale;
                end;
              dtUnknown:
                begin
                  oCol.DataType := dtAnsiString;
                  oCol.Size := 1;
                  oCol.Attributes := oCol.Attributes + [caAllowNull, caReadOnly];
                  rColInfo.FForceAddOpts := [coAllowNull, coReadOnly];
                  rColInfo.FForceRemOpts := [coInUpdate, coInWhere, coInKey, coAfterInsChanged, coAfterUpdChanged];
                end;
              end;
              if caDefault in oCol.Attributes then
                Include(rColInfo.FForceAddOpts, coAllowNull);
              oCol.Options := oCol.Options + rColInfo.FForceAddOpts - rColInfo.FForceRemOpts;
              lExtAttrs := lExtAttrs or (oCol.Attributes * [caBase, caExpr] <> []);
              if lColCreated then
                ATable.Columns.Add(oCol);
{$IFDEF FireDAC_MONITOR}
              if FConnectionObj.GetTracing then Trace2;
{$ENDIF}
            end;
          end;
          if lTabIsArray then
            Inc(iArrayItem);
        end;

        if not lTabIsArray and (ARootID = -1) then begin
          lOriginProvided := lOriginUseful and (oConnMeta.ColumnOriginProvided or (sFirstOriginTabName <> ''));
          lUpdBaseFieldsOnly := lOriginProvided and not oUpdOpts.UpdateNonBaseFields;
          for i := 0 to ATable.Columns.Count - 1 do begin
            oCol := ATable.Columns.ItemsI[i];
            if not lOriginUseful or (oCol.OriginColName = '') then begin
              oCol.OriginTabName := '';
              rName.FObject := oCol.SourceName;
              oCol.OriginColName := oConnMeta.EncodeObjName(rName, nil, [eoBeautify]);
            end;
            if not lExtAttrs then
              if not lOriginProvided then
                oCol.Attributes := oCol.Attributes + [caBase]
              else if (oCol.OriginTabName = '') and not (caBase in oCol.Attributes) then
                oCol.Attributes := oCol.Attributes + [caExpr, caReadOnly] - [caDefault]
              else if (oCol.OriginTabName <> '') and (CompareText(sFirstOriginTabName, oCol.OriginTabName) = 0) then
                oCol.Attributes := oCol.Attributes + [caBase];

            // SELECT F1 AS A, F1 AS B -> excluded extra occurences of F1 from updates
            // to avoid "Column Xxx cannot be repeated in UPDATE statement"
            if lUpdBaseFieldsOnly and (caBase in oCol.Attributes) then begin
              if oCol.OriginTabName <> '' then
                sName := oCol.OriginTabName + '.'
              else
                sName := '';
              sName := sName + oCol.OriginColName;
              if sName <> '' then begin
                if oOriginCols.IndexOf(sName) >= 0 then
                  oCol.Options := oCol.Options - [coInUpdate, coInWhere, coInKey] +
                    [coAfterInsChanged, coAfterUpdChanged];
                oOriginCols.Add(sName);
              end;
            end;

            // Server side calculated fields has to be excluded from updates
            if [caCalculated, caReadOnly] * oCol.Attributes = [caCalculated, caReadOnly] then
              oCol.Options := oCol.Options - [coInUpdate, coInWhere, coInKey] +
                [coReadOnly, coAfterInsChanged, coAfterUpdChanged];

            // Set key fields and auto-inc fields only for base fields
            if not lUpdBaseFieldsOnly or (caBase in oCol.Attributes) then begin
              if oUpdOpts.KeyFields <> '' then
                if FDFieldInFieldNames(oUpdOpts.KeyFields, oCol.SourceName) then
                  oCol.Options := oCol.Options + [coInKey]
                else
                  oCol.Options := oCol.Options - [coInKey];
              if coInKey in oCol.Options then
                lPKDefined := True;

              if caAutoInc in oCol.Attributes then
                // Non-numeric fields with caAutoInc has to be converted to caROWID
                if oCol.IsAutoIncrementType(oCol.DataType) then
                  oCol.ServerAutoIncrement := True
                else
                  oCol.Attributes := oCol.Attributes - [caAutoInc] + [caROWID]
              else if (oUpdOpts.AutoIncFields <> '') and
                      FDFieldInFieldNames(oUpdOpts.AutoIncFields, oCol.SourceName) then begin
                lInUpdate := coInUpdate in oCol.Options;
                oCol.ServerAutoIncrement := True;
                if oConnMeta.GeneratorSupported and lInUpdate then
                  oCol.Options := oCol.Options + [coInUpdate];
              end;
            end;

            // Exclude non-base fields from editing
            if [caROWID, caRowVersion, caInternal, caCalculated, caBase] * oCol.Attributes = [] then begin
              if lUpdBaseFieldsOnly then begin
                oCol.Attributes := oCol.Attributes - [caAutoInc];
                oCol.Options := oCol.Options - [coInUpdate, coInWhere, coInKey] +
                  [coReadOnly, coAllowNull];
              end
              else if not lExtAttrs and (caExpr in oCol.Attributes) then
                oCol.Options := oCol.Options - [coReadOnly];

              if lOriginProvided then
                oCol.Options := oCol.Options - [coInKey];
              oCol.Options := oCol.Options + [coAfterInsChanged, coAfterUpdChanged];
            end;
          end;
        end;

        if lDefPK and not lPKDefined then begin
{$IFDEF FireDAC_MONITOR}
          if FConnectionObj.GetTracing then Trace3;
{$ENDIF}
          for i := 0 to oPKFieldsView.Rows.Count - 1 do begin
            j := ATable.Columns.IndexOfName(oPKFieldsView.Rows.ItemsI[i].GetData('COLUMN_NAME'));
            if j <> -1 then begin
              oCol := ATable.Columns.ItemsI[j];
              oCol.Options := oCol.Options + [coInKey];
              lPKDefined := True;
            end;
          end;
        end;
        if not lPKDefined and (oROWIDCol <> nil) then
          oROWIDCol.Options := oROWIDCol.Options + [coInKey];

        if lOriginProvided and (GetSourceObjectName = '') and (sFirstOriginTabName <> '') then
          SetSourceObjectName(sFirstOriginTabName);
      end;

    except
      for i := oCreatedList.Count - 1 downto 0 do
        FDFree(TObject(oCreatedList[i]));
      raise;
    end;
  finally
    if (oPKFieldsView <> nil) and (FConnection.State <> csDisconnected) then
      FDClearMetaView(oPKFieldsView, FOptions.FetchOptions);
    FDFree(oCreatedList);
    FDFree(oOriginCols);
  end;
  Result := ATable;
  if lNoRowSet then
    FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccCmdMHRowSet, []);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.BeginDefine;
begin
  CheckAsyncProgress;
  if GetState = csInactive then
    Prepare;
  if GetState = csInactive then
    FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccCmdMBPrepared, []);
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.Define(ADatSManager: TFDDatSManager;
  ATable: TFDDatSTable; AMetaInfoMergeMode: TFDPhysMetaInfoMergeMode): TFDDatSTable;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  var
    sTabName: String;
  begin
    if ATable <> nil then sTabName := ATable.Name else sTabName := '<nil>';
    Trace(ekCmdPrepare, esStart, 'Define(TFDDatSManager)',
      ['ADatSManager', ADatSManager.Name, 'ATable', sTabName, 'Command', GetTraceCommandText]);
  end;

  procedure Trace2;
  var
    sTabName: String;
  begin
    if ATable <> nil then sTabName := ATable.Name else sTabName := '<nil>';
    Trace(ekCmdPrepare, esEnd, 'Define(TFDDatSManager)',
      ['ADatSManager', ADatSManager.Name, 'ATable', sTabName, 'Command', GetTraceCommandText]);
  end;
var
  lUpdateMonitor: Boolean;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if EnterTrace(FConnectionObj) then Trace1;
  try
{$ENDIF}
    BeginDefine;
    if AMetaInfoMergeMode = mmReset then begin
      if GetMetaInfoKind = mkNone then begin
        if ATable <> nil then
          ATable.Reset;
        AMetaInfoMergeMode := mmOverride;
      end
      else if ADatSManager <> nil then
        ADatSManager.Reset;
    end;
    Result := DoDefineDataTable(ADatSManager, ATable, -1, '', AMetaInfoMergeMode);
{$IFDEF FireDAC_MONITOR}
  finally
    if ExitTrace(FConnectionObj, lUpdateMonitor) then Trace2;
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.Define(ATable: TFDDatSTable;
  AMetaInfoMergeMode: TFDPhysMetaInfoMergeMode): TFDDatSTable;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  var
    sTabName: String;
  begin
    if ATable <> nil then sTabName := ATable.Name else sTabName := '<nil>';
    Trace(ekCmdPrepare, esStart, 'Define(TFDDatSTable)',
      ['ATable', sTabName, 'Command', GetTraceCommandText]);
  end;

  procedure Trace2;
  var
    sTabName: String;
  begin
    if ATable <> nil then sTabName := ATable.Name else sTabName := '<nil>';
    Trace(ekCmdPrepare, esEnd, 'Define(TFDDatSTable)',
      ['ATable', sTabName, 'Command', GetTraceCommandText]);
  end;
var
  lUpdateMonitor: Boolean;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if EnterTrace(FConnectionObj) then Trace1;
  try
{$ENDIF}
    BeginDefine;
    Result := DoDefineDataTable(nil, ATable, -1, '', AMetaInfoMergeMode);
{$IFDEF FireDAC_MONITOR}
  finally
    if ExitTrace(FConnectionObj, lUpdateMonitor) then Trace2;
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
// Executing

type
  TFDPhysCommandAsyncExecute = class(TFDPhysCommandAsyncOperation)
  private
    FTimes: Integer;
    FOffset: Integer;
  protected
    // IFDStanAsyncOperation
    procedure Execute; override;
  public
    constructor Create(ACmd: TFDPhysCommand; ATimes, AOffset: Integer);
  end;

{-------------------------------------------------------------------------------}
constructor TFDPhysCommandAsyncExecute.Create(ACmd: TFDPhysCommand;
  ATimes, AOffset: Integer);
begin
  inherited Create(ACmd);
  FTimes := ATimes;
  FOffset := AOffset;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommandAsyncExecute.Execute;
begin
  FCommand.ExecuteBase(FTimes, FOffset);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.CheckExact(AUseRecsMax: Boolean; ATimes, AOffset: Integer;
  AValue: TFDCounter; AFetch: Boolean);

  procedure Error;
  var
    sPref, sMsg, sOper: String;
    eKind: TFDCommandExceptionKind;
    oExc: EFDDBEngineException;
  begin
    if AFetch then
      sOper := 'fetch returned'
    else
      sOper := 'update affected';
    sPref := FDExceptionLayers([S_FD_LPhys, DriverID]) + '-' +
      IntToStr(er_FD_AccExactMismatch) + '. ';
    sMsg := Format(FDGetErrorMessage(er_FD_AccExactMismatch, []),
      [sOper, AValue, ATimes - AOffset]);
    if AValue < ATimes - AOffset then
      eKind := ekNoDataFound
    else
      eKind := ekTooManyRows;
    oExc := EFDDBEngineException.Create(er_FD_AccExactMismatch, sPref + sMsg);
    oExc.AppendError(1, er_FD_AccExactMismatch, sMsg, '', eKind, -1, -1);
    FDException(Self, oExc {$IFDEF FireDAC_Monitor}, FConnectionObj.GetTracing {$ENDIF});
  end;

var
  oFO: TFDFetchOptions;
begin
  oFO := FOptions.FetchOptions;
  if oFO.Mode = fmExactRecsMax then begin
    if AUseRecsMax then begin
      AOffset := 0;
      ATimes := oFO.RecsMax;
    end;
    if (AValue <> ATimes - AOffset) and
       (AValue >= 0) and (ATimes - AOffset >= 0) then
      Error;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.ExecuteBase(ATimes, AOffset: Integer);
var
  eMode: TFDPhysArrayExecMode;
  lAtomic: Boolean;
  lSavepoint: Boolean;
  i: Integer;
{$IFDEF FireDAC_MONITOR}
  lUpdateMonitor: Boolean;
{$ENDIF}

  procedure SetMeta;
  var
    oConnMeta: IFDPhysConnectionMetadata;
  begin
    FConnection.CreateMetadata(oConnMeta);
    eMode := oConnMeta.ArrayExecMode;
    lAtomic := (FTransactionObj <> nil) and FTransactionObj.GetActive and oConnMeta.TxAtomic;
    lSavepoint := lAtomic and (oConnMeta.TxNested or oConnMeta.TxSavepoints);
    oConnMeta := nil;
  end;

  procedure UpdRes(AValue: TFDCounter);
  begin
    if AValue <= -1 then
      FRowsAffected := -1
    else if FRowsAffected >= 0 then begin
      Inc(FRowsAffected, AValue);
      Inc(FExecuteCount, AValue);
    end;
  end;

  function Process_HandleSystemFailure(ATimes, AOffset: Integer; out ACount: TFDCounter;
    AArrayDML: Boolean): Boolean;
  var
    lExecuted: Boolean;
  begin
    Result := True;
    FErrorAction := eaExitSuccess;
    lExecuted := False;
    repeat
      ACount := 0;
      if lSavepoint then
        FTransactionObj.StartTransaction;
      try
        InternalExecute(ATimes, AOffset, ACount);
        CheckExact(not AArrayDML, ATimes, AOffset, ACount, False);
        lExecuted := True;
        if lSavepoint then
          FTransactionObj.Commit;
      except
        on E: EFDDBEngineException do begin
          if lSavepoint then
            FTransactionObj.Rollback;
          case E.Kind of
          ekServerGone:
            begin
              lSavepoint := False;
              FConnectionObj.RecoverConnection(Self, False);
            end;
          ekArrExecMalfunc:
            begin
              Result := False;
              Exit;
            end;
          else
            raise;
          end;
        end;
      end;
    until lExecuted;
    UpdRes(ACount);
  end;

  procedure Process_SingleRow;
  var
    iCount: TFDCounter;
    iRetryLevel: Integer;
    oErr: Exception;
  begin
    iRetryLevel := 0;
    repeat
      try
        Process_HandleSystemFailure(1, 0, iCount, False);
      except
        on E: EFDDBEngineException do begin
          UpdRes(iCount);
          FErrorAction := eaFail;
          if Assigned(GetErrorHandler()) then begin
            Inc(iRetryLevel);
            oErr := EFDDBArrayExecuteError.Create(1, 0, E, iRetryLevel);
            try
              GetErrorHandler().HandleException(nil, oErr);
              if oErr <> nil then
                FErrorAction := EFDDBArrayExecuteError(oErr).Action;
            finally
              FDFree(oErr);
            end;
          end;
          case FErrorAction of
          eaApplied,
          eaSkip:
            FErrorAction := eaExitSuccess;
          eaRetry:
            ;
          eaFail,
          eaDefault:
            raise;
          end;
        end;
      end;
    until FErrorAction in [eaExitSuccess, eaExitFailure];
  end;

  procedure Process_UntilFirstError(AUndoAll: Boolean);
  var
    iCount: TFDCounter;
    iLastTimes, iLastOffset, iRetryLevel: Integer;
    iCurTimes, iCurOffset, iArraySize: Integer;
    oErr: Exception;
  begin
    iLastTimes := 0;
    iLastOffset := 0;
    iRetryLevel := 0;
    iArraySize := FOptions.ResourceOptions.ArrayDMLSize;
    if iArraySize > ATimes - AOffset then
      iArraySize := ATimes - AOffset;
    iCurOffset := AOffset;
    iCurTimes := AOffset + iArraySize;
    repeat
      try
        while iCurOffset < ATimes do begin
          if iCurTimes > ATimes then
            iCurTimes := ATimes;
          if not Process_HandleSystemFailure(iCurTimes, iCurOffset, iCount, True) then begin
            iArraySize := 1;
            iCurTimes := iCurOffset + 1;
            FErrorAction := eaRetry;
            Continue;
          end;
          Inc(iCurOffset, iArraySize);
          Inc(iCurTimes, iArraySize);
        end;
      except
        on E: EFDDBEngineException do begin
          UpdRes(iCount);
          if iCount > 0 then
            iCurOffset := iCurOffset + Integer(iCount);
          if AUndoAll then
            if lAtomic and not lSavepoint then begin
              FErrorAction := eaFail;
              FRowsAffected := 0;
              raise;
            end
            else if (iArraySize > 1) and not (E.Kind in [ekNoDataFound, ekTooManyRows]) then begin
              iArraySize := 1;
              iCurTimes := iCurOffset + 1;
              FErrorAction := eaRetry;
              Continue;
            end;
          FErrorAction := eaFail;
          if Assigned(GetErrorHandler()) then begin
            if (iLastTimes = iCurTimes) and (iLastOffset = iCurOffset) then
              Inc(iRetryLevel)
            else begin
              iLastTimes := iCurTimes;
              iLastOffset := iCurOffset;
              iRetryLevel := 0;
            end;
            oErr := EFDDBArrayExecuteError.Create(iCurTimes, iCurOffset, E, iRetryLevel);
            try
              GetErrorHandler().HandleException(nil, oErr);
              if oErr <> nil then
                FErrorAction := EFDDBArrayExecuteError(oErr).Action;
            finally
              FDFree(oErr);
            end;
          end;
          case FErrorAction of
          eaApplied,
          eaSkip:
            begin
              Inc(iCurOffset);
              if iCurOffset >= iCurTimes then
                Inc(iCurTimes, iArraySize);
              if FErrorAction = eaApplied then
                if FRowsAffected >= 0 then
                  Inc(FRowsAffected);
            end;
          eaRetry:
            ;
          eaFail,
          eaDefault:
            raise;
          end;
        end;
      end;
      if (iCurOffset >= ATimes) and (FErrorAction <> eaExitFailure) then
        FErrorAction := eaExitSuccess;
    until FErrorAction in [eaExitSuccess, eaExitFailure];
  end;

  procedure RemoveCurrentRowErrors(E: EFDDBEngineException; ACurRow: Integer);
  begin
    repeat
      FDFree(E[0]);
      E.Remove(E[0]);
    until (E.ErrorCount = 0) or (ACurRow <> E[0].RowIndex);
  end;

  procedure Process_CollectErrors;
  var
    iCount: TFDCounter;
    iLastTimes, iLastOffset, iRetryLevel: Integer;
    iCurTimes, iCurOffset, iArraySize: Integer;
    oErr: Exception;
  begin
    iLastTimes := 0;
    iLastOffset := 0;
    iRetryLevel := 0;
    iArraySize := FOptions.ResourceOptions.ArrayDMLSize;
    if iArraySize > ATimes - AOffset then
      iArraySize := ATimes - AOffset;
    iCurOffset := AOffset;
    iCurTimes := AOffset + iArraySize;
    while iCurOffset < ATimes do begin
      if iCurTimes > ATimes then
        iCurTimes := ATimes;
      try
        if not Process_HandleSystemFailure(iCurTimes, iCurOffset, iCount, True) then begin
          iArraySize := 1;
          iCurTimes := iCurOffset + 1;
          FErrorAction := eaRetry;
          Continue;
        end;
      except
        on E: EFDDBEngineException do begin
          UpdRes(iCount);
          repeat
            FErrorAction := eaFail;
            AOffset := E[0].RowIndex;
            if Assigned(GetErrorHandler()) then begin
              if (iLastTimes = ATimes) and (iLastOffset = AOffset) then
                Inc(iRetryLevel)
              else begin
                iLastTimes := ATimes;
                iLastOffset := AOffset;
                iRetryLevel := 0;
              end;
              oErr := EFDDBArrayExecuteError.Create(ATimes, AOffset, E, iRetryLevel);
              try
                GetErrorHandler().HandleException(nil, oErr);
                if oErr <> nil then
                  FErrorAction := EFDDBArrayExecuteError(oErr).Action;
              finally
                FDFree(oErr);
              end;
            end;
            case FErrorAction of
            eaApplied,
            eaSkip:
              begin
                RemoveCurrentRowErrors(E, AOffset);
                if FErrorAction = eaApplied then
                  if FRowsAffected >= 0 then
                    Inc(FRowsAffected);
              end;
            eaRetry:
              try
                try
                  InternalExecute(AOffset + 1, AOffset, iCount);
                  CheckExact(False, AOffset + 1, AOffset, iCount, False);
                finally
                  UpdRes(iCount);
                  RemoveCurrentRowErrors(E, AOffset);
                end;
              except
                on E2: EFDDBEngineException do begin
                  E.Merge(E2, 0);
                  FErrorAction := eaRetry;
                end;
              end;
            eaFail,
            eaDefault:
              raise;
            end;
            if (E.ErrorCount = 0) and (FErrorAction <> eaExitFailure) then
              FErrorAction := eaExitSuccess;
          until (E.ErrorCount = 0) or (FErrorAction in [eaExitSuccess, eaExitFailure]);
        end;
      end;
      Inc(iCurOffset, iArraySize);
      Inc(iCurTimes, iArraySize);
    end;
  end;

  procedure MBPrepared;
  begin
    FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccCmdMBPrepared, []);
  end;

  procedure CantExec;
  begin
    FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccCantExecCmdWithRowSet, []);
  end;

  procedure ParamArrMismatch(AParam: TFDParam);
  begin
    FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccParamArrayMismatch,
      [AParam.Name, AParam.ArraySize, ATimes]);
  end;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ekCmdExecute, esStart, 'Execute', ['Command', GetTraceCommandText,
      'ATimes', ATimes, 'AOffset', AOffset]);
  end;

  procedure Trace2(AUpdateMonitor: Boolean);
  begin
    if AUpdateMonitor then UpdateMonitor;
    Trace(ekCmdExecute, esEnd, 'Execute', ['Command', GetTraceCommandText,
      'ATimes', ATimes, 'AOffset', AOffset, 'RowsAffected', FRowsAffected,
      'RowsAffectedReal', FRowsAffectedReal, 'ErrorAction', Integer(FErrorAction)]);
  end;
{$ENDIF}

begin
  if GetState = csAborting then begin
    FState := csPrepared;
    Exit;
  end;

{$IFDEF FireDAC_MONITOR}
  if EnterTrace(FConnectionObj) then Trace1;
{$ENDIF}
  try
    FRowsAffected := 0;
    FRowsAffectedReal := True;
    FErrorAction := eaExitFailure;
    if not GetNextRecordSet then
      FConnectionObj.SaveLastAutoGenValue(Null);

    CheckAsyncProgress;
    if GetState = csInactive then
      Prepare;
    if GetState <> csPrepared then
      MBPrepared;
    if (GetCommandKind in [skSelect, skSelectForLock, skSelectForUnLock]) or
       (GetMetaInfoKind <> mkNone) then
      CantExec;
    for i := 0 to GetParams.Count - 1 do
      if GetParams[i].ArraySize < ATimes then
        ParamArrMismatch(GetParams[i]);

    FErrorAction := eaExitSuccess;
    if ATimes <= 0 then
      ATimes := 1;
    if AOffset < 0 then
      AOffset := 0;
    if AOffset >= ATimes then
      Exit;
    lAtomic := False;
    lSavepoint := False;
    FState := csExecuting;
    FThreadID := TThread.CurrentThread.ThreadID;
    FExecutor.Launched;
    try

      try
        FTransactionObj.Notify(cpBeforeCmdExecute, Self);
        if (ATimes = 1) and (AOffset = 0) then
          Process_SingleRow
        else begin
          SetMeta;
          case eMode of
          aeOnErrorUndoAll:
            Process_UntilFirstError(True);
          aeUpToFirstError:
            Process_UntilFirstError(False);
          aeCollectAllErrors:
            Process_CollectErrors;
          aeNotSupported:
            if (ATimes <> 1) or (AOffset <> 0) then
              FDCapabilityNotSupported(Self, [S_FD_LPhys, DriverID])
            else
              Process_UntilFirstError(False);
          end;
        end;

      finally
        if GetState <> csInactive then
          FState := csPrepared;
        if FRowsAffected = -1 then begin
          FRowsAffectedReal := False;
          FRowsAffected := 0;
        end;
      end;

    except
      FTransactionObj.Notify(cpAfterCmdExecuteFailure, Self);
      raise;
    end;
    case FErrorAction of
    eaExitSuccess:
      FTransactionObj.Notify(cpAfterCmdExecuteSuccess, Self);
    eaExitFailure:
      FTransactionObj.Notify(cpAfterCmdExecuteFailure, Self);
    else
      ASSERT(False);
    end;

  finally
    FThreadID := 0;
{$IFDEF FireDAC_MONITOR}
    if ExitTrace(FConnectionObj, lUpdateMonitor) then Trace2(lUpdateMonitor);
{$ENDIF}
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.Execute(ATimes: Integer = 0; AOffset: Integer = 0;
  ABlocked: Boolean = False);
var
  oOper: IFDStanAsyncOperation;
begin
  oOper := TFDPhysCommandAsyncExecute.Create(Self, ATimes, AOffset) as IFDStanAsyncOperation;
  ExecuteTask(oOper, GetStateHandler, ABlocked);
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetErrorAction: TFDErrorAction;
begin
  Result := FErrorAction;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetRowsAffected: TFDCounter;
begin
  Result := FRowsAffected;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetRowsAffectedReal: Boolean;
begin
  Result := FRowsAffectedReal;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.InternalCloseStreams;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.CloseStreams;
begin
  CheckAsyncProgress;
  if GetState <> csPrepared then
    FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccCmdMBPrepared, []);
  try
    InternalCloseStreams;
  finally
    GetParams.Close;
  end;
end;

{-------------------------------------------------------------------------------}
// Fetching

type
  TFDPhysCommandAsyncFetch = class(TFDPhysCommandAsyncOperation, IFDStanAsyncHandler)
  private
    FTable: TFDDatSTable;
    FAll: Boolean;
  protected
    // IFDStanAsyncOperation
    procedure Execute; override;
    // IFDStanAsyncHandler
    procedure HandleFinished(const AInitiator: IFDStanObject;
      AState: TFDStanAsyncState; AException: Exception);
  public
    constructor Create(ACmd: TFDPhysCommand; ATable: TFDDatSTable; AAll: Boolean);
  end;

{-------------------------------------------------------------------------------}
constructor TFDPhysCommandAsyncFetch.Create(ACmd: TFDPhysCommand;
  ATable: TFDDatSTable; AAll: Boolean);
begin
  inherited Create(ACmd);
  FTable := ATable;
  FAll := AAll;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommandAsyncFetch.Execute;
begin
  FCommand.FetchBase(FTable, FAll);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommandAsyncFetch.HandleFinished(const AInitiator: IFDStanObject;
  AState: TFDStanAsyncState; AException: Exception);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FCommand.Trace(ekCmdExecute, esProgress, 'Eof reached',
      ['ATable', FTable.SourceName, 'Command', FCommand.GetTraceCommandText]);
  end;
{$ENDIF}

var
  oHnlr: IFDPhysCommandStateHandler;
begin
  // StartTransaction calls FConnectionObj.Lock and on MSSQL calls Fetch(True).
  // On Eof the command is closing. That calls TFDPhysTransaction.InternalNotify,
  // which is calling FConnectionObj.Lock. With async fetching that leads to
  // deadlock, so call Close in the calling thread.
  oHnlr := FCommand.GetStateHandler;
  if FCommand.FEof then begin
{$IFDEF FireDAC_MONITOR}
    if FCommand.FConnectionObj.GetTracing then Trace1;
{$ENDIF}
    if FCommand.FOptions.FetchOptions.AutoClose then
      FCommand.Close;
  end;
  if oHnlr <> nil then
    oHnlr.HandleFinished(AInitiator, AState, AException);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.FetchBase(ATable: TFDDatSTable; AAll: Boolean);

  function DoFetch(ARowsSkip, ARowsCount, ARowsetSize: Integer; AMaxLimited: Boolean): Integer;
  var
    iLastFetch, iThrowRows: Integer;
  begin
    Result := 0;
    repeat
      iLastFetch := 0;
      if FRecordsFetched + ARowsetSize > ARowsCount then
        ARowsetSize := ARowsCount - FRecordsFetched;
      if ARowsetSize > 0 then begin
        try
          iLastFetch := InternalFetchRowSet(ATable, nil, ARowsetSize);
        except
          on E: EFDDBEngineException do
            if E.Kind = ekServerGone then
              FConnectionObj.RecoverConnection(Self, False)
            else
              raise;
        end;
        if ARowsSkip > 0 then begin
          if ARowsSkip >= iLastFetch then
            iThrowRows := iLastFetch
          else
            iThrowRows := ARowsSkip;
          Inc(FRecordsFetched, iLastFetch - iThrowRows);
          Inc(Result, iLastFetch - iThrowRows);
          Dec(ARowsSkip, iThrowRows);
          while iThrowRows > 0 do begin
            ATable.Rows.RemoveAt(0);
            Dec(iThrowRows);
          end;
        end
        else begin
          Inc(FRecordsFetched, iLastFetch);
          Inc(Result, iLastFetch);
        end;
      end;
    until (FState <> csFetching) or (iLastFetch <> ARowsetSize) or (FRecordsFetched >= ARowsCount);
    FEof := (iLastFetch <> ARowsetSize) or AMaxLimited and (FRecordsFetched >= ARowsCount);
  end;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ekCmdExecute, esStart, 'Fetch',
      ['ATable', ATable.SourceName, 'Command', GetTraceCommandText]);
  end;

  procedure Trace2(AUpdateMonitor: Boolean);
  begin
    if AUpdateMonitor then UpdateMonitor;
    Trace(ekCmdExecute, esEnd, 'Fetch',
      ['ATable', ATable.SourceName, 'Command', GetTraceCommandText,
       'RowsAffected', FRowsAffected]);
  end;
{$ENDIF}

var
  oFO: TFDFetchOptions;
  eMode: TFDFetchMode;
  iRowsetSize, iRecsSkip, iRecsMax: Integer;
  rState: TFDDatSLoadState;
  lErase: Boolean;
  oConnMeta: IFDPhysConnectionMetadata;
{$IFDEF FireDAC_MONITOR}
  lUpdateMonitor: Boolean;
{$ENDIF}
begin
  if GetState = csAborting then begin
    FState := csOpen;
    Exit;
  end;

{$IFDEF FireDAC_MONITOR}
  if EnterTrace(FConnectionObj) then Trace1;
{$ENDIF}
  try
    FRowsAffected := 0;
    if FEof then
      Exit;

    ASSERT(ATable <> nil);
    CheckAsyncProgress;
    if GetState <> csOpen then
      FDException(Self, [S_FD_LPhys, DriverID], er_FD_AccCmdMBOpen4Fetch, []);

    FState := csFetching;
    FThreadID := TThread.CurrentThread.ThreadID;
    FExecutor.Launched;

    oFO := FOptions.FetchOptions;
    if not FFirstFetch and not AAll then
      eMode := fmOnDemand
    else if AAll then
      eMode := fmAll
    else
      eMode := oFO.Mode;
    iRowsetSize := oFO.ActualRowsetSize;
    iRecsSkip := 0;
    if FFirstFetch then begin
      FConnection.CreateMetadata(oConnMeta);
      if not (loSkip in oConnMeta.LimitOptions) or (GetCommandKind <> skSelect) then
        if FSQLLimitSkip >= 0 then
          iRecsSkip := FSQLLimitSkip
        else
          iRecsSkip := oFO.RecsSkip;
    end;
    iRecsMax := oFO.RecsMax;
    lErase := False;

    if (eMode in [fmAll, fmExactRecsMax]) or (iRecsSkip > 0) then
      ATable.BeginLoadData(rState, lmHavyFetching)
    else
      ATable.BeginLoadData(rState, lmFetching);
    try
      try
        case eMode of
        fmAll:
          if iRecsMax > 0 then
            FRowsAffected := DoFetch(iRecsSkip, iRecsMax, iRowsetSize, True)
          else
            FRowsAffected := DoFetch(iRecsSkip, MAXINT, iRowsetSize, False);
        fmExactRecsMax:
          begin
            FRowsAffected := DoFetch(iRecsSkip, iRowsetSize + 1, iRowsetSize, True);
            if FRowsAffected <> iRowsetSize then begin
              lErase := (FRowsAffected = ATable.Rows.Count);
              CheckExact(False, iRowsetSize, 0, FRowsAffected, True);
            end;
          end;
        fmManual, fmOnDemand:
          if (iRecsMax > 0) and (FRecordsFetched + iRowsetSize > iRecsMax) then
            FRowsAffected := DoFetch(iRecsSkip, iRecsMax, iRowsetSize, True)
          else
            FRowsAffected := DoFetch(iRecsSkip, FRecordsFetched + iRowsetSize, iRowsetSize, False);
        end;
      finally
        // If command is part of TFDQuery, the connection is lost,
        // then query will be closed and ATable destroyed.
        if ATable.DataHandleMode <> lmDestroying then
          ATable.EndLoadData(rState);
      end;
    finally
      FFirstFetch := False;
      if GetState <> csInactive then
        case FState of
        csFetching:
          FState := csOpen;
        csAborting:
          begin
            FState := csOpen;
            FEof := True;
          end;
        end;
      if lErase then begin
        FRowsAffected := 0;
        ATable.Clear;
      end;
    end;
  finally
    FThreadID := 0;
{$IFDEF FireDAC_MONITOR}
    if ExitTrace(FConnectionObj, lUpdateMonitor) then Trace2(lUpdateMonitor);
{$ENDIF}
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.Fetch(ATable: TFDDatSTable; AAll: Boolean = True;
  ABlocked: Boolean = False);
var
  oFetch: TFDPhysCommandAsyncFetch;
begin
  oFetch := TFDPhysCommandAsyncFetch.Create(Self, ATable, AAll);
  ExecuteTask(oFetch as IFDStanAsyncOperation, oFetch as IFDStanAsyncHandler, ABlocked);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.Fetch(ADatSManager: TFDDatSManager;
  AMetaInfoMergeMode: TFDPhysMetaInfoMergeMode = mmReset);
var
  eMode: TFDPhysMetaInfoMergeMode;
  oTab: TFDDatSTable;
  iRows: Integer;
begin
  iRows := 0;
  try
    CheckAsyncProgress;
    if GetState = csInactive then
      Prepare;
    eMode := AMetaInfoMergeMode;
    if eMode = mmReset then begin
      ADatSManager.Reset;
      eMode := mmOverride;
    end;
    while True do begin
      if GetState = csPrepared then
        OpenBlocked;
      if GetState <> csOpen then
        Break;
      oTab := Define(ADatSManager, nil, eMode);
      Fetch(oTab, True, True);
      Inc(iRows, FRowsAffected);
      SetNextRecordSet(True);
    end;
    if (GetState = csOpen) and FOptions.FetchOptions.AutoClose then
      Close;
  finally
    FRowsAffected := iRows;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.CheckFetchColumn(ADataType: TFDDataType;
  AAttributes: TFDDataAttributes): Boolean;
begin
  Result := (ADataType <> dtUnknown) and (
    not (
      (ADataType in [dtRowSetRef, dtCursorRef]) and
        not (fiDetails in FOptions.FetchOptions.Items) or
      (caBlobData in AAttributes) and
        not (fiBlobs in FOptions.FetchOptions.Items)
    ) or (
      GetMetaInfoKind() <> mkNone
    )
  );
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.CheckParamMatching(AParam: TFDParam;
  ADataType: TFieldType; AParamType: TParamType; APrec: Integer);
begin
  if not ((AParamType = AParam.ParamType) or
          (ptUnknown = AParam.ParamType) and (AParamType = ptInput)) or
     not ((ADataType = AParam.DataType) or
          (ADataType in [ftFmtMemo, ftWideMemo]) and
            (AParam.DataType in [ftFmtMemo, ftWideMemo]) or
          (ADataType in [ftInteger, ftAutoInc, ftLongWord]) and
            (AParam.DataType in [ftInteger, ftAutoInc, ftLongWord]) or
          (ADataType in [ftParadoxOle, ftOraInterval]) and
            (AParam.DataType in [ftParadoxOle, ftOraInterval])) or
     not ((APrec = 0) or (APrec = AParam.Precision)) then
    ParDefChangedError(ADataType, AParam);
end;

{-------------------------------------------------------------------------------}
// IFDStanObject

function TFDPhysCommand.GetName: TComponentName;
begin
  Result := FMoniAdapterHelper.Name;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetParent: IFDStanObject;
begin
  Result := FMoniAdapterHelper.Parent;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.SetOwner(const AOwner: TObject;
  const ARole: TComponentName);
begin
  FMoniAdapterHelper.SetOwner(AOwner, ARole);
{$IFDEF FireDAC_MONITOR}
  FMoniAdapterHelper.UnRegisterClient;
  FMoniAdapterHelper.RegisterClient(FConnectionObj.GetMonitor);
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.AfterReuse;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.BeforeReuse;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
// IFDMoniAdapter

function TFDPhysCommand.GetHandle: LongWord;
begin
  if FMoniAdapterHelper = nil then
    Result := 0
  else
    Result := FMoniAdapterHelper.Handle;
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetSupportItems: TFDMoniAdapterItemKinds;
begin
  Result := [ikStat, ikSQL, ikParam];
end;

{-------------------------------------------------------------------------------}
function TFDPhysCommand.GetItemCount: Integer;
begin
  Result := 5 + GetParams.Count + GetMacros.Count;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysCommand.GetItem(AIndex: Integer; out AName: String;
  out AValue: Variant; out AKind: TFDMoniAdapterItemKind);
const
  C_States: array [TFDPhysCommandState] of String = ('Inactive', 'Prepared',
    'Executing', 'Open', 'Fetching', 'Aborting');
var
  oPar: TFDParam;
  oMac: TFDMacro;
begin
  case AIndex of
  0:
    begin
      AName := 'ExecuteCount';
      AValue := FExecuteCount;
      AKind := ikStat;
    end;
  1:
    begin
      AName := 'RowsAffected';
      AValue := FRowsAffected;
      AKind := ikStat;
    end;
  2:
    begin
      AName := 'RecordsFetched';
      AValue := FRecordsFetched;
      AKind := ikStat;
    end;
  3:
    begin
      AName := 'Status';
      AValue := C_States[GetState];
      if (GetState = csOpen) and FEof then
        AValue := AValue + ', Eof';
      AKind := ikStat;
    end;
  4:
    begin
      AName := '@CommandText';
      AValue := GetTraceCommandText;
      AKind := ikSQL;
    end;
  else
    if AIndex - 5 < GetParams.Count then begin
      oPar := GetParams[AIndex - 5];
      AName := oPar.Name;
      if oPar.ArrayType <> atScalar then
        AValue := '<array>'
      else
        AValue := oPar.Value;
      AKind := ikParam;
    end
    else begin
      oMac := GetMacros[AIndex - 5 - GetParams.Count];
      AName := oMac.Name;
      AValue := oMac.Value;
      AKind := ikParam;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
procedure TFDPhysCommand.UpdateMonitor;
begin
  if FConnection.Tracing then
    FConnection.Monitor.AdapterChanged(Self);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
var
  oFact: TFDFactory;

initialization
  TFDSingletonFactory.Create(TFDPhysManager, IFDPhysManager);
  oFact := TFDPhysConnectionDefParamsFactory.Create;

finalization
  FDReleaseFactory(oFact);

end.
