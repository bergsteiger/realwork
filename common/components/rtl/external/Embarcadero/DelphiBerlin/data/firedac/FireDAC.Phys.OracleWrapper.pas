{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{     FireDAC Oracle Call Interface wrapping classes    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.OracleWrapper;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows, System.Win.Registry,
{$ENDIF}
  System.SysUtils, System.Classes, Data.SqlTimSt, Data.FmtBcd, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Error, FireDAC.Stan.Consts, FireDAC.Stan.Util,
    FireDAC.Stan.Option, FireDAC.Stan.SQLTimeInt,
  FireDAC.Phys.OracleCli;

type
  TOCILib = class;
  TOCIHandle = class;
  TOCIEnv = class;
  EOCINativeException = class;
  TOCIError = class;
  TOCIService = class;
  TOCISession = class;
  TOCIServer = class;
  TOCIDescriptor = class;
  TOCIXid = class;
  TOCITransaction = class;
  TOCIStatement = class;
  TOCIVariable = class;
  TOCISelectItem = class;
  TOCILobLocator = class;
  TOCITempLocator = class;
  TOCILobLocatorClass = class of TOCILobLocator;
  TOCIIntLocator = class;
  TOCIExtLocator = class;
  TOCILobLocatorStream = class;
  TOCIDescribe = class;
  TOCIDirectPath = class;
  TOCIDirectPathColArray = class;
  TOCIDirectPathStream = class;
  TOCIDirectPathColumnParam = class;
  TOCIPLSQLDescriber = class;
  TOCIOpaqueValue = class;
  TOCITimestamp = class;
  TOCITimeInterval = class;
  TOCICollection = class;
  TOCICollectionClass = class of TOCICollection;
  TOCIAdmin = class;
  TOCISubscription = class;
  TOCIChangeRowDesc = class;
  TOCIChangeTableDesc = class;
  TOCIChangeQueryDesc = class;
  TOCIChangeDesc = class;
  TOCIQueryNotification = class;

  TOCILib = class(TFDLibrary)
  private
    FEnv: TOCIEnv;
    FMessages: TFDLog;
    function GetOCIPaths(const AVendorHome, AVendorLib: String): String;
    procedure GetTNSPaths;
    procedure GetNLSLang;

  protected
    procedure GetLibraryInfo; override;
    procedure LoadEntries; override;

  public
{$IFDEF MSWINDOWS}
    FKey: String;
{$ENDIF}
    FOracleHome: String;
    FTNSNames: String;
    FNLSLang: String;
    FInstantClient: Boolean;
    FThreaded: Boolean;

    OCIClientVersion: TOCIClientVersion;
    OCIPasswordChange: TOCIPasswordChange;
    OCIInitialize: TOCIInitialize;
    OCIEnvInit: TOCIEnvInit;
    OCIEnvCreate: TOCIEnvCreate;
    OCIEnvNlsCreate: TOCIEnvNlsCreate;
    OCIHandleAlloc: TOCIHandleAlloc;
    OCIServerAttach: TOCIServerAttach;
    OCIAttrSet: TOCIAttrSet;
    OCISessionBegin: TOCISessionBegin;
    OCISessionEnd: TOCISessionEnd;
    OCIServerDetach: TOCIServerDetach;
    OCIHandleFree: TOCIHandleFree;
    OCIErrorGet: TOCIErrorGet;
    OCIStmtPrepare: TOCIStmtPrepare;
    OCIStmtExecute: TOCIStmtExecute;
    OCIStmtGetNextResult: TOCIStmtGetNextResult;
    OCIParamGet: TOCIParamGet;
    OCIAttrGet: TOCIAttrGet;
    OCIStmtFetch: TOCIStmtFetch;
    OCIDefineByPos: TOCIDefineByPos;
    OCIDefineArrayOfStruct: TOCIDefineArrayOfStruct;
    OCIRowidToChar: TOCIRowidToChar;
    OCIBindByPos: TOCIBindByPos;
    OCIBindByName: TOCIBindByName;
    OCITransStart: TOCITransStart;
    OCITransCommit: TOCITransCommit;
    OCITransRollback: TOCITransRollback;
    OCITransDetach: TOCITransDetach;
    OCITransPrepare: TOCITransPrepare;
    OCITransForget: TOCITransForget;
    OCIDescribeAny: TOCIDescribeAny;
    OCIBreak: TOCIBreak;
    OCIReset: TOCIReset;
    OCIDescriptorAlloc: TOCIDescriptorAlloc;
    OCIDescriptorFree: TOCIDescriptorFree;
    OCIStmtGetPieceInfo: TOCIStmtGetPieceInfo;
    OCIStmtSetPieceInfo: TOCIStmtSetPieceInfo;
    OCIServerVersion: TOCIServerVersion;
    OCIBindDynamic: TOCIBindDynamic;
    OCILobAppend: TOCILobAppend;
    OCILobAssign: TOCILobAssign;
    OCILobCharSetForm: TOCILobCharSetForm;
    OCILobClose: TOCILobClose;
    OCILobCopy: TOCILobCopy;
    OCILobEnableBuffering: TOCILobEnableBuffering;
    OCILobDisableBuffering: TOCILobDisableBuffering;
    OCILobErase: TOCILobErase;
    OCILobFileExists: TOCILobFileExists;
    OCILobFileGetName: TOCILobFileGetName;
    OCILobFileSetName: TOCILobFileSetName;
    OCILobFlushBuffer: TOCILobFlushBuffer;
    OCILobGetLength: TOCILobGetLength;
    OCILobIsOpen: TOCILobIsOpen;
    OCILobLoadFromFile: TOCILobLoadFromFile;
    OCILobLocatorIsInit: TOCILobLocatorIsInit;
    OCILobOpen: TOCILobOpen;
    OCILobRead: TOCILobRead;
    OCILobTrim: TOCILobTrim;
    OCILobWrite: TOCILobWrite;
    OCILobCreateTemporary: TOCILobCreateTemporary;
    OCILobFreeTemporary: TOCILobFreeTemporary;
    OCILobIsTemporary: TOCILobIsTemporary;
    OCIResultSetToStmt: TOCIResultSetToStmt;
    OCIDirPathAbort: TOCIDirPathAbort;
    OCIDirPathDataSave: TOCIDirPathDataSave;
    OCIDirPathFinish: TOCIDirPathFinish;
    OCIDirPathFlushRow: TOCIDirPathFlushRow;
    OCIDirPathPrepare: TOCIDirPathPrepare;
    OCIDirPathLoadStream: TOCIDirPathLoadStream;
    OCIDirPathColArrayEntryGet: TOCIDirPathColArrayEntryGet;
    OCIDirPathColArrayEntrySet: TOCIDirPathColArrayEntrySet;
    OCIDirPathColArrayRowGet: TOCIDirPathColArrayRowGet;
    OCIDirPathColArrayReset: TOCIDirPathColArrayReset;
    OCIDirPathColArrayToStream: TOCIDirPathColArrayToStream;
    OCIDirPathStreamReset: TOCIDirPathStreamReset;
    OCIDirPathStreamToStream: TOCIDirPathStreamToStream;
    OCIDateTimeGetDate: TOCIDateTimeGetDate;
    OCIDateTimeGetTime: TOCIDateTimeGetTime;
    OCIDateTimeConstruct: TOCIDateTimeConstruct;
    OCIDateTimeGetTimeZoneOffset: TOCIDateTimeGetTimeZoneOffset;
    OCIDateTimeAssign: TOCIDateTimeAssign;
    OCIPing: TOCIPing;
    OCINlsCharSetNameToId: TOCINlsCharSetNameToId;
    OCINlsCharSetIdToName: TOCINlsCharSetIdToName;
    OCINlsEnvironmentVariableGet: TOCINlsEnvironmentVariableGet;
    OCIIntervalAssign: TOCIIntervalAssign;
    OCIIntervalCheck: TOCIIntervalCheck;
    OCIIntervalSetYearMonth: TOCIIntervalSetYearMonth;
    OCIIntervalGetYearMonth: TOCIIntervalGetYearMonth;
    OCIIntervalSetDaySecond: TOCIIntervalSetDaySecond;
    OCIIntervalGetDaySecond: TOCIIntervalGetDaySecond;
    OCIDBStartup: TOCIDBStartup;
    OCIDBShutdown: TOCIDBShutdown;
    OCICollSize: TOCICollSize;
    OCICollMax: TOCICollMax;
    OCICollGetElem: TOCICollGetElem;
    OCICollAssignElem: TOCICollAssignElem;
    OCICollAssign: TOCICollAssign;
    OCICollAppend: TOCICollAppend;
    OCICollTrim: TOCICollTrim;
    OCICollIsLocator: TOCICollIsLocator;
    OCIIterCreate: TOCIIterCreate;
    OCIIterDelete: TOCIIterDelete;
    OCIIterInit: TOCIIterInit;
    OCIIterGetCurrent: TOCIIterGetCurrent;
    OCIIterNext: TOCIIterNext;
    OCIIterPrev: TOCIIterPrev;
    OCISubscriptionRegister: TOCISubscriptionRegister;
    OCISubscriptionPost: TOCISubscriptionPost;
    OCISubscriptionUnRegister: TOCISubscriptionUnRegister;
    OCISubscriptionDisable: TOCISubscriptionDisable;
    OCISubscriptionEnable: TOCISubscriptionEnable;
    constructor Create(AMessages: TFDLog; AOwningObj: TObject = nil);
    procedure Load(const AVendorHome, AVendorLib, ANLSLang, ATNSAdmin: String;
      AThreaded: Boolean);
    procedure Unload; override;
    class procedure GetOracleHomeList(AList: TStrings); static;
    procedure GetTNSServicesList(AList: TStrings);
    function CharSetNameToId(const AName: String): ub2;
  end;

  TOCIHandle = class(TObject)
  private
    FHandle: pOCIHandle;
    FType: ub4;
    FOwnHandle: Boolean;
    FOwner: TOCIHandle;
    [weak] FOwningObj: TObject;
    FEnv: TOCIEnv;
    procedure Init(AType: ub4);
    procedure Check(ACode: sb4);
  protected
{$IFDEF FireDAC_MONITOR}
    procedure Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
      const AMsg: String; const AArgs: array of const); overload;
    procedure Trace(AKind: TFDMoniEventKind; const AMsg: String;
      const AArgs: array of const); overload;
    procedure Trace(const AMsg: String; const AArgs: array of const); overload;
{$ENDIF}
    function InitCollection(ACollClass: TOCICollectionClass;
      var AColl: TOCICollection; AhColl: pOCIColl): TOCICollection;
  public
    constructor Create(AEnv: TOCIEnv);
    destructor Destroy; override;
    procedure SetStringAttr(AAtrType: Integer; const AValue: String);
    function GetStringAttr(AAtrType: Integer): String;
    procedure SetBytesAttr(AAtrType: Integer; const AValue: TBytes);
    function GetBytesAttr(AAtrType: Integer): TBytes;
    procedure SetHandleAttr(AAtrType: Integer; AValue: pOCIHandle);
    function GetHandleAttr(AAtrType: Integer): pOCIHandle;
    procedure SetUB1Attr(AAtrType: Integer; AValue: ub1);
    function GetUB1Attr(AAtrType: Integer): ub1;
    procedure SetUB2Attr(AAtrType: Integer; AValue: ub2);
    function GetUB2Attr(AAtrType: Integer): ub2;
    procedure SetUB4Attr(AAtrType: Integer; AValue: ub4);
    function GetUB4Attr(AAtrType: Integer): ub4;
    procedure SetSB1Attr(AAtrType: Integer; AValue: sb1);
    function GetSB1Attr(AAtrType: Integer): sb1;
    procedure SetSB4Attr(AAtrType: Integer; AValue: Sb4);
    function GetSB4Attr(AAtrType: Integer): sb4;
    procedure SetUB8Attr(AAtrType: Integer; AValue: ub8);
    function GetUB8Attr(AAtrType: Integer): ub8;
    property Value: pOCIHandle read FHandle;
    property Handle: pOCIHandle read FHandle write FHandle;
    property HType: ub4 read FType;
    property Env: TOCIEnv read FEnv;
    property Owner: TOCIHandle read FOwner;
    property OwningObj: TObject read FOwningObj;
    property OwnHandle: Boolean read FOwnHandle;
  end;

  TOCIEnv = class(TOCIHandle)
  private
    FError: TOCIError;
    FLib: TOCILib;
    FNLS_CHARSET_ID: ub2;
    FNLS_NCHARSET_ID: ub2;
    FCharsetName: String;
    FExplicitCharsetID: ub2;
    FByteSemantic: Boolean;
    FBuffer: TFDBuffer;
    FDataEncoder: TFDEncoder;
    FMetaEncoder: TFDEncoder;
{$IFDEF FireDAC_MONITOR}
    FMonitor: IFDMoniClient;
    FTracing: Boolean;
    function GetTracing: Boolean;
{$ENDIF}
    procedure InitEnvBase(ACharsetID: ub2);
    procedure UpdateNLSCharsets;
    procedure UpdateEncoder;
  public
    constructor Create(ALib: TOCILib; AOwningObj: TObject = nil
      {$IFDEF FireDAC_Monitor}; const AMonitor: IFDMoniClient = nil {$ENDIF});
    constructor CreateUsingHandle(ALib: TOCILib; AOwningObj: TObject; AHandle,
      AErrHandle: pOCIHandle; const ACharsetName: String; AExplicitCharsetID: ub2;
      AByteSemantic: Boolean {$IFDEF FireDAC_Monitor}; const AMonitor: IFDMoniClient {$ENDIF});
    destructor Destroy; override;
    procedure InitEnv(const ACharsetName: String);
    function CharSetIdToName(AId: ub2): String;
    function CharSetNameToId(const AName: String): ub2;
{$IFDEF FireDAC_MONITOR}
    property Monitor: IFDMoniClient read FMonitor write FMonitor;
    property Tracing: Boolean read GetTracing write FTracing;
{$ENDIF}
    property Error: TOCIError read FError;
    property Lib: TOCILib read FLib;
    property Buffer: TFDBuffer read FBuffer;
    property DataEncoder: TFDEncoder read FDataEncoder;
    property MetaEncoder: TFDEncoder read FMetaEncoder;
    // other
    property CACHE_ARRAYFLUSH: sb4 index OCI_ATTR_CACHE_ARRAYFLUSH read GetSb4Attr write SetSb4Attr;
    property CACHE_MAX_SIZE: ub4 index OCI_ATTR_CACHE_MAX_SIZE read GetUb4Attr write SetUb4Attr;
    property CACHE_OPT_SIZE: ub4 index OCI_ATTR_CACHE_OPT_SIZE read GetUb4Attr write SetUb4Attr;
    property PINOPTION: ub4 index OCI_ATTR_PINOPTION read GetUb4Attr write SetUb4Attr;
    property ALLOC_DURATION: ub2 index OCI_ATTR_ALLOC_DURATION read GetUb2Attr write SetUb2Attr;
    property PIN_DURATION: ub2 index OCI_ATTR_PIN_DURATION read GetUb2Attr write SetUb2Attr;
    property HEAPALLOC: ub4 index OCI_ATTR_HEAPALLOC read GetUb4Attr;
    property SHARED_HEAPALLOC: ub4 index OCI_ATTR_SHARED_HEAPALLOC read GetUb4Attr;
    property OBJECT_: sb4 index OCI_ATTR_OBJECT read GetSb4Attr;
    property OBJECT_NEWNOTNULL: sb4 index OCI_ATTR_OBJECT_NEWNOTNULL read GetSb4Attr write SetSb4Attr;
    property OBJECT_DETECTCHANGE: sb4 index OCI_ATTR_OBJECT_DETECTCHANGE read GetSb4Attr write SetSb4Attr;
    // Character set
    property ENV_CHARSET_ID: ub2 index OCI_ATTR_ENV_CHARSET_ID read GetUb2Attr;
    property ENV_NCHARSET_ID: ub2 index OCI_ATTR_ENV_NCHARSET_ID read GetUb2Attr;
    property ENV_UTF16: ub1 index OCI_ATTR_ENV_UTF16 read GetUb1Attr;
    property NLS_CHARSET_ID: ub2 read FNLS_CHARSET_ID;
    property NLS_NCHARSET_ID: ub2 read FNLS_NCHARSET_ID;
    property CharsetName: string read FCharsetName;
    property ExplicitCharsetID: ub2 read FExplicitCharsetID;
    property ByteSemantic: Boolean read FByteSemantic;
    // LDAP
    property BIND_DN: String index OCI_ATTR_BIND_DN read GetStringAttr write SetStringAttr;
    property LDAP_AUTH: ub2 index OCI_ATTR_LDAP_AUTH read GetUb2Attr write SetUb2Attr;
    property LDAP_CRED: String index OCI_ATTR_LDAP_CRED read GetStringAttr write SetStringAttr;
    property LDAP_CTX: String index OCI_ATTR_LDAP_CTX read GetStringAttr write SetStringAttr;
    property LDAP_HOST: String index OCI_ATTR_LDAP_HOST read GetStringAttr write SetStringAttr;
    property LDAP_PORT: ub2 index OCI_ATTR_LDAP_PORT read GetUb2Attr write SetUb2Attr;
  end;

  EOCINativeException = class(EFDDBEngineException)
  public
    constructor Create(AError: TOCIError); overload;
{$IFDEF BCB}
    constructor Create(AObj: TOCIHandle; AErrorCode: sb4;
      const AMessage: String; Dummy: Cardinal = 0); overload;
{$ELSE}
    constructor Create(AObj: TOCIHandle; AErrorCode: sb4;
      const AMessage: String); overload;
{$ENDIF}
  end;

  TOCIError = class(TOCIHandle)
  private
    FInfo: EFDDBEngineException;
    FIgnoreErrors: Boolean;
  public
    constructor Create(AEnv: TOCIEnv);
    constructor CreateUsingHandle(AEnv: TOCIEnv; AErrHandle: pOCIHandle);
    destructor Destroy; override;
    procedure Check(ACode: sword; AInitiator: TObject = nil);
    procedure ClearInfo;
    procedure CheckAllocateInfo;
    property Info: EFDDBEngineException read FInfo;
    property DML_ROW_OFFSET: ub4 index OCI_ATTR_DML_ROW_OFFSET read GetUb4Attr;
    property IgnoreErrors: Boolean read FIgnoreErrors write FIgnoreErrors;
  end;

  TOCIService = class(TOCIHandle)
  private
    FOnYield: TNotifyEvent;
    FNonBlockinMode: Boolean;
    FBytesPerChar: ub1;
    procedure DoYield;
    procedure SetNonblockingMode(const Value: Boolean);
  public
    constructor Create(AEnv: TOCIEnv; AOwningObj: TObject = nil);
    constructor CreateUsingHandle(AEnv: TOCIEnv; AHandle: pOCISvcCtx;
      AOwningObj: TObject = nil);
    procedure Break(ADoException: Boolean);
    procedure Reset(ADoException: Boolean);
    procedure TurnNONBLOCKING_MODE;
    procedure UpdateNonBlockingMode;
    procedure Ping;
    property OnYield: TNotifyEvent read FOnYield write FOnYield;
    property ENV_: pOCIHandle index OCI_ATTR_ENV read GetHandleAttr;
    property SERVER: pOCIHandle index OCI_ATTR_SERVER read GetHandleAttr write SetHandleAttr;
    property SESSION: pOCIHandle index OCI_ATTR_SESSION read GetHandleAttr write SetHandleAttr;
    property TRANS: pOCIHandle index OCI_ATTR_TRANS read GetHandleAttr write SetHandleAttr;
    property IN_V8_MODE: ub1 index OCI_ATTR_IN_V8_MODE read GetUb1Attr;
    property NONBLOCKING_MODE: Boolean read FNonBlockinMode write SetNonblockingMode;
    property STMTCACHESIZE: ub4 index OCI_ATTR_STMTCACHESIZE read GetUb4Attr write SetUb4Attr;
    property BytesPerChar: ub1 read FBytesPerChar write FBytesPerChar;
    property VARTYPE_MAXLEN_COMPAT: ub1 index OCI_ATTR_VARTYPE_MAXLEN_COMPAT read GetUb1Attr;
  end;

  TOCISession = class(TOCIHandle)
  private
    FStarted: Boolean;
  public
    constructor Create(AService: TOCIService);
    constructor CreateUsingHandle(AService: TOCIService; AHandle: pOCISession);
    destructor Destroy; override;
    procedure Start(const AUser, APassword: String; AAuthentMode: ub4);
    procedure ChangePassword(const AUser, AOldPassword, ANewPassword: String);
    procedure Stop;
    procedure Select;
    property Started: Boolean read FStarted;
    property USERNAME: String index OCI_ATTR_USERNAME read GetStringAttr write SetStringAttr;
    property PASSWORD: String index OCI_ATTR_PASSWORD read GetStringAttr write SetStringAttr;
    property MIGSESSION: ub1 index OCI_ATTR_MIGSESSION read GetUb1Attr write SetUb1Attr;
    property INITIAL_CLIENT_ROLES: Pointer index OCI_ATTR_INITIAL_CLIENT_ROLES write SetHandleAttr;
    // for externally initialized context
    property APPCTX_SIZE: ub4 index OCI_ATTR_APPCTX_SIZE write SetUb4Attr;
    property APPCTX_LIST: pOCIParam index OCI_ATTR_APPCTX_LIST read GetHandleAttr;
    property APPCTX_NAME: String index OCI_ATTR_APPCTX_NAME write SetStringAttr;
    property APPCTX_ATTR: String index OCI_ATTR_APPCTX_ATTR write SetStringAttr;
    property APPCTX_VALUE: String index OCI_ATTR_APPCTX_VALUE write SetStringAttr;
    // End To End Tracing
    property COLLECT_CALL_TIME: ub1 index OCI_ATTR_COLLECT_CALL_TIME read GetUb1Attr write SetUb1Attr; // boolean
    property CALL_TIME: ub8 index OCI_ATTR_CALL_TIME read GetUb8Attr;
    property ACTION: String index OCI_ATTR_ACTION write SetStringAttr;
    property CLIENT_INFO: String index OCI_ATTR_CLIENT_INFO write SetStringAttr;
    property MODULE: String index OCI_ATTR_MODULE write SetStringAttr;
    // other
    property CERTIFICATE: Pointer index OCI_ATTR_CERTIFICATE write SetHandleAttr;
    property CLIENT_IDENTIFIER: String index OCI_ATTR_CLIENT_IDENTIFIER write SetStringAttr;
    property DISTINGUISHED_NAME: String index OCI_ATTR_DISTINGUISHED_NAME write SetStringAttr;
    property PROXY_CREDENTIALS: pOCISession index OCI_ATTR_PROXY_CREDENTIALS write SetHandleAttr;
    // >= 10g2 OCI_ATTR_CURRENT_SCHEMA, OCI_ATTR_DEFAULT_LOBPREFETCH_SIZE,
    // OCI_ATTR_DRIVER_NAME, OCI_ATTR_PROXY_CLIENT, OCI_ATTR_PURITY
    // OCI_ATTR_CONNECTION_CLASS
    property CURRENT_SCHEMA: String index OCI_ATTR_CURRENT_SCHEMA read GetStringAttr write SetStringAttr;
    property MAX_OPEN_CURSORS: ub4 index OCI_ATTR_MAX_OPEN_CURSORS read GetUB4Attr;
    property TRANSACTION_IN_PROGRESS: ub4 index OCI_ATTR_TRANSACTION_IN_PROGRESS read GetUB4Attr;
  end;

  TOCIServer = class(TOCIHandle)
  private
    FAttached: Boolean;
    FServerVersion: String;
    function GetServerVersion: String;
  public
    constructor Create(AService: TOCIService);
    constructor CreateUsingHandle(AService: TOCIService; AHandle: pOCIServer);
    destructor Destroy; override;
    procedure Attach(const AServerName: String);
    procedure Detach;
    procedure Select;
    property ServerVersion: String read GetServerVersion write FServerVersion;
    property Attached: Boolean read FAttached;
    property ENV_: pOCIHandle index OCI_ATTR_ENV read GetHandleAttr;
    property EXTERNAL_NAME: String index OCI_ATTR_EXTERNAL_NAME read GetStringAttr write SetStringAttr;
    property INTERNAL_NAME: String index OCI_ATTR_INTERNAL_NAME read GetStringAttr write SetStringAttr;
    property IN_V8_MODE: ub1 index OCI_ATTR_IN_V8_MODE read GetUb1Attr;
    property FOCBK: Pointer index OCI_ATTR_FOCBK read GetHandleAttr write SetHandleAttr;
    property SERVER_GROUP: String index OCI_ATTR_SERVER_GROUP read GetStringAttr write SetStringAttr;
    property SERVER_STATUS: ub4 index OCI_ATTR_SERVER_STATUS read GetUb4Attr;
    property SEND_TIMEOUT: ub4 index OCI_ATTR_SEND_TIMEOUT read GetUb4Attr write SetUb4Attr;
    property RECEIVE_TIMEOUT: ub4 index OCI_ATTR_RECEIVE_TIMEOUT read GetUb4Attr write SetUb4Attr;
  end;

  TOCIXid = class(TPersistent)
  private
    FEnv: TOCIEnv;
    FOnChanging, FOnChanged: TNotifyEvent;
    FName: String;
    procedure SetBQUAL(const AValue: String);
    function GetBQUAL: String;
    procedure SetGTRID(const AValue: String);
    function GetGTRID: String;
    function GetIsNull: Boolean;
    procedure SetName(const AValue: String);
  public
    FXID: TXID;
    constructor Create(AEnv: TOCIEnv);
    procedure Assign(AValue: TPersistent); override;
    procedure Clear;
    procedure SetParts(const AGTRID, ABQUAL: String);
    procedure MarkTransaction(ATrans: TOCITransaction);
    property IsNull: Boolean read GetIsNull;
    property OnChanging: TNotifyEvent read FOnChanging write FOnChanging;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  published
    property GTRID: String read GetGTRID write SetGTRID;
    property BQUAL: String read GetBQUAL write SetBQUAL;
    property Name: String read FName write SetName;
  end;

  TOCITransactionMode = (tmDefault, tmReadWrite, tmSerializable, tmReadOnly);
  TOCICoupleMode = (omDefault, omTightly, omLoosely);
  TOCITransaction = class(TOCIHandle)
  public
    constructor Create(AService: TOCIService);
    constructor CreateUsingHandle(AService: TOCIService; AHandle: pOCITrans);
    procedure Detach;
    procedure StartLocal(AMode: TOCITransactionMode);
    procedure StartGlobal(AMode: TOCITransactionMode; ATimeOut: uword;
      ANew: Boolean; ACoupleMode: TOCICoupleMode);
    procedure Commit;
    procedure RollBack;
    procedure Select;
    procedure Prepare2PC;
    procedure Commit2PC;
    procedure Forget;
    procedure GetXID(var AValue: TXID);
    procedure SetXID(var AValue: TXID);
    property TRANS_NAME: String index OCI_ATTR_TRANS_NAME read GetStringAttr write SetStringAttr;
  end;

  // otCursor must be first handle based data type
  TOCIVarDataType = (otUnknown, otInt32, otUInt32, otInt64, otUInt64, otSingle,
    otDouble, otNumber, otString, otChar, otNString, otNChar, otRaw, otDateTime,
    otLong, otNLong, otLongRaw, otROWID, otBoolean, otCursor, otNestedDataSet,
    otCLOB, otNCLOB, otBLOB, otCFile, otBFile, otTimeStamp, otIntervalYM, otIntervalDS);
  TOCIVarDataTypes = set of TOCIVarDataType;
  TOCIVarType = (odUnknown, odIn, odOut, odInOut, odRet, odDefine);
  TOCIVarTypes = set of TOCIVarType;

  TOCIStatement = class(TOCIHandle)
  private type
    TPieceLoopData = record
      FVarHndl: pOCIHandle;
      FVar: TOCIVariable;
      FPieceSize: ub4;
      FInd: sb2;
      FIter: ub4;
      FPiece: ub1;
      FRCode: ub2;
      FInOut: ub1;
      FBuff: pUb1;
    end;

  private
    FEof: Boolean;
    FLastRowCount: ub4;
    FPieceBuffLen: ub4;
    FPieceBuff: pUb1;
    FPieceOutVars: TFDObjList;
    FVars: TFDObjList;
    FService: TOCIService;
    FTrans: TOCITransaction;
    FRef: Boolean;
    FCanceled: Boolean;
    FDecimalSep: Char;
    FStrsTrim: LongBool;
    FStrsEmpty2Null: LongBool;
    FSTMT_TYPE: ub2;
    procedure SetPieceBuffLen(AValue: ub4);
    procedure AllocPieceBuff;
    procedure FreePieceBuff;
    function Hndl2PieceVar(varHndl: pOCIHandle): TOCIVariable;
    function GetPiecedExchange: Boolean; inline;
    procedure InitPiecedExchange(out pld: TPieceLoopData);
    procedure DoPiecedExchange(var AData: TPieceLoopData; ARes: sb4);
{$IFDEF FireDAC_MONITOR}
    procedure DumpColumns(ARows: ub4; AEof: Boolean);
    procedure DumpParameters(ARows, AOffset: sb4; ATypes: TOCIVarTypes);
{$ENDIF}
//    function CallbackDefine(Define: pOCIDefine; Iter: cardinal; var Buf: pointer;
//      var BufLen: pUb4; var PieceStatus: ub1; var Ind: pointer): sb4;
    function AddVarBase(const AName: String; APosition: ub4;
      AVarType: TOCIVarType; ADataType: TOCIVarDataType; ASize: ub4): TOCIVariable;
    function GetRowId: String;
  protected
    procedure AddPieceVar(AVar: TOCIVariable);
    procedure RemovePieceVar(AVar: TOCIVariable);
    procedure AddVar(AVar: TOCIVariable); overload;
    procedure RemoveVar(AVar: TOCIVariable);
  public
    constructor Create(AEnv: TOCIEnv; AService: TOCIService;
      ATrans: TOCITransaction = nil; AOwningObj: TObject = nil);
    constructor CreateUsingHandle(AEnv: TOCIEnv; AService: TOCIService;
      ATrans: TOCITransaction; AHandle: pOCIHandle; AOwningObj: TObject = nil);
    destructor Destroy; override;
    procedure AttachToHandle(AHandle: pOCIHandle);
    procedure Prepare(const AStatement: String);
    procedure Describe;
    procedure Execute(ARows, AOffset: sb4; AExact, ACommit: Boolean);
    function NextResultSet: pOCIHandle;
    procedure CancelCursor;
    procedure Fetch(ANRows: ub4);
    function AddVar(const AName: String; AVarType: TOCIVarType;
      ADataType: TOCIVarDataType; ASize: ub4 = 0): TOCIVariable; overload;
    function AddVar(APosition: ub4; AVarType: TOCIVarType;
      ADataType: TOCIVarDataType; ASize: ub4 = 0): TOCIVariable; overload;
    function FetchImplRowids: Boolean;
    // general props
    property Service: TOCIService read FService;
    property Ref: Boolean read FRef write FRef;
    property Eof: Boolean read FEof;
    property Canceled: Boolean read FCanceled;
    property LastRowCount: ub4 read FLastRowCount;
    property PiecedExchange: Boolean read GetPiecedExchange;
    property RowId: String read GetRowId;
    // data format props
    property PieceBuffLen: ub4 read FPieceBuffLen write SetPieceBuffLen;
    property DecimalSep: Char read FDecimalSep write FDecimalSep;
    property StrsTrim: LongBool read FStrsTrim write FStrsTrim;
    property StrsEmpty2Null: LongBool read FStrsEmpty2Null write FStrsEmpty2Null;
    // general attrs
    property ENV_: pOCIHandle index OCI_ATTR_ENV read GetHandleAttr;
    // parse info attrs
    property PARSE_ERROR_OFFSET: ub2 index OCI_ATTR_PARSE_ERROR_OFFSET read GetUB2Attr;
    property STMT_TYPE: ub2 read FSTMT_TYPE;
    property SQLFNCODE: ub2 index OCI_ATTR_SQLFNCODE read GetUB2Attr;
    property PARAM_COUNT: ub4 index OCI_ATTR_PARAM_COUNT read GetUB4Attr;
    property IS_RETURNING: ub4 index OCI_ATTR_STMT_IS_RETURNING read GetUB4Attr;
    // fetch setup attrs
    property PREFETCH_ROWS: ub4 index OCI_ATTR_PREFETCH_ROWS read GetUB4Attr write SetUB4Attr;
    property PREFETCH_MEMORY: ub4 index OCI_ATTR_PREFETCH_MEMORY read GetUB4Attr write SetUB4Attr;
    property FETCH_ROWID: ub4 index OCI_ATTR_FETCH_ROWID read GetUB4Attr write SetUB4Attr;
    // runtime info attrs
    property ROW_COUNT: ub4 index OCI_ATTR_ROW_COUNT read GetUB4Attr;
    property UB8_ROW_COUNT: ub8 index OCI_ATTR_UB8_ROW_COUNT read GetUB8Attr;
    property DML_ROW_COUNT_ARRAY: Pointer index OCI_ATTR_DML_ROW_COUNT_ARRAY read GetHandleAttr;
    property NUM_DML_ERRORS: ub4 index OCI_ATTR_NUM_DML_ERRORS read GetUb4Attr;
    property ROWS_FETCHED: ub4 index OCI_ATTR_ROWS_FETCHED read GetUB4Attr;
    property IMPLICIT_RESULT_COUNT: ub4 index OCI_ATTR_IMPLICIT_RESULT_COUNT read GetUB4Attr;
    // query change notification attrs
    property CQ_QUERYID: ub8 index OCI_ATTR_CQ_QUERYID read GetUB8Attr;
    property CHNF_REGHANDLE: pOCISubscription index OCI_ATTR_CHNF_REGHANDLE write SetHandleAttr;
  end;

  TOCIVariable = class(TOCIHandle)
  private type
    TBindData = packed record
      FInd: PSb2Array;
      FALen: PUb2Array;
      FRCode: PUb2Array;
      FBuffer: pUb1;
    end;
    PBindData = ^TBindData;

    TLongData = record
      FSize: ub4;
      FData: pUb1;
    end;
    PLongData = ^TLongData;

  private
    FPlaceHolder: String;
    FPosition: ub4;
    FBindData: PBindData;
    FValue_byte_sz: ub4;  // value max byte length
    FValue_char_sz: ub4;  // value max char length
    FValue_ty: ub2;       // value type
    FMaxArr_len: ub4;     // maximum number of elements
    FCurEle: ub4;         // actual number of elements
    FDataType: TOCIVarDataType;
    FVarType: TOCIVarType;
    FLongData: LongBool;
    FDumpLabel: String;
    FLastBindedBuffer: pUb1;
    FBufferInited: Boolean;
    FIsPLSQLTable: Boolean;
    FIsCaseSensitive: Boolean;
    FFlagsUpdated: Boolean;
    FByteSemantic: Boolean;
    procedure SetArrayLen(const AValue: ub4);
    procedure SetDataSize(const AValue: ub4);
    procedure SetDataType(const AValue: TOCIVarDataType);
    procedure SetVarType(const AValue: TOCIVarType);
    function GetBuffer(AIndex: ub4): pUb1;
    procedure FreeBuffer;
    procedure CheckBufferAccess;
    procedure FreeLong(ApLong: PLongData);
    procedure InitLong(ApLong: PLongData);
    procedure GetLong(ApLong: PLongData; var AData: pUb1; var ASize: ub4);
    procedure SetLong(ApLong: PLongData; AData: pUb1; ASize: ub4);
    procedure AppendLong(ApLong: PLongData; AData: pUb1; ASize: ub4);
    function GetDumpLabel: String;
    function UpdateHValueNullInd(AIndex: ub4): Boolean;
    function GetBindDataSize: ub4;
    procedure MapBuffer;
    procedure UpdateFlags;
    function GetAsString: String;
    function GetAsInteger: Integer;
  protected
    property Buffer[AIndex: ub4]: pUb1 read GetBuffer;
  public
    constructor Create(AStmt: TOCIStatement);
    destructor Destroy; override;
    // Binding related
    procedure Bind;
    procedure BindTo(AStmt: TOCIStatement);
    procedure BindOff;
    // Buffer related
    procedure ClearBuffer(ATimes, AOffset: sb4);
    procedure InitBuffer(ATimes, AOffset: sb4);
    procedure ResetBuffer(ATimes, AOffset: sb4);
    // Value related
    function GetRawData(AIndex: ub4; out ABuff: pUb1; out ASize: ub4): Boolean;
    function GetData(AIndex: ub4; var ABuff: pUb1; out ASize: ub4;
      AByRef: Boolean): Boolean; overload;
    function GetData(AIndex: ub4; ABuff: pUb1; out ASize: ub4): Boolean; overload;
    procedure SetData(AIndex: ub4; ABuff: pUb1; ASize: ub4);
    procedure AppendData(AIndex: ub4; ABuff: pUb1; ASize: ub4);
    procedure SetIsNull(AIndex: ub4; AIsNull: Boolean); // for LOB fields
{$IFDEF FireDAC_MONITOR}
    function DumpValue(AIndex: ub4): String;
{$ENDIF}

    property Name: String read FPlaceHolder write FPlaceHolder;
    property Position: ub4 read FPosition write FPosition;
    property DumpLabel: String read GetDumpLabel write FDumpLabel;
    property IsPLSQLTable: Boolean read FIsPLSQLTable write FIsPLSQLTable;
    property IsCaseSensitive: Boolean read FIsCaseSensitive write FIsCaseSensitive;
    property DataType: TOCIVarDataType read FDataType write SetDataType;
    property DataSize: ub4 read FValue_byte_sz write SetDataSize;
    property CharSize: ub4 read FValue_char_sz write FValue_char_sz;
    property VarType: TOCIVarType read FVarType write SetVarType;
    property ArrayLen: ub4 read FMaxArr_len write SetArrayLen;
    property ArrayCount: ub4 read FCurEle;

    property BindDataSize: ub4 read GetBindDataSize;
    property LongData: LongBool read FLongData;
    property ByteSemantic: Boolean read FByteSemantic;
    property AsString: String read GetAsString;
    property AsInteger: Integer read GetAsInteger;

    property CHAR_COUNT: ub4 index OCI_ATTR_CHAR_COUNT read GetUb4Attr write SetUb4Attr;
    property CHARSET_ID: ub2 index OCI_ATTR_CHARSET_ID read GetUb2Attr write SetUb2Attr;
    property CHARSET_FORM: ub1 index OCI_ATTR_CHARSET_FORM read GetUb1Attr write SetUb1Attr;
    property PDPRC: ub2 index OCI_ATTR_PDPRC read GetUb2Attr write SetUb2Attr;
    property PDSCL: ub2 index OCI_ATTR_PDSCL read GetUb2Attr write SetUb2Attr;
    property ROWS_RETURNED: ub4 index OCI_ATTR_ROWS_RETURNED read GetUB4Attr;
    property MAXDATA_SIZE: sb4 index OCI_ATTR_MAXDATA_SIZE read GetSb4Attr write SetSb4Attr;
    property MAXCHAR_SIZE: sb4 index OCI_ATTR_MAXCHAR_SIZE read GetSb4Attr write SetSb4Attr;
  end;

  TOCIDescriptor = class(TOCIHandle)
  protected
    procedure Init(AType: ub4);
  public
    destructor Destroy; override;
    constructor CreateUsingHandle(AEnv: TOCIEnv; AHandle: pOCIDescriptor); overload; virtual;
  end;

  TOCISelectItem = class(TOCIDescriptor)
  private
    FService: TOCIService;
    FPosition: sb4;
    FDATA_TYPE: ub4;
    FDATA_SIZE: ub4;
    FPRECISION: ub4;
    FSCALE_: ub4;
    FCHARSET_FORM: ub1;
    FCHAR_SIZE: ub2;
    FDataType: TOCIVarDataType;
    procedure InitFields;
    function GetDataType: TOCIVarDataType;
    function GetVarType: TOCIVarType;
    function GetIsNull: Boolean;
    function GetDataPrecision: sb4;
    function GetDataScale: sb4;
    function GetBytesPerChar: ub1;
    function GetCharSize: ub2;
    function GetDataSize: ub4;
    function GetColumnSize: ub4;
    function GetIsUnicode: Boolean;
    function GetCHARSET_FORM: ub1;
    function GetDATA_SIZE: ub4;
    function GetDATA_TYPE: ub4;
    function GetPRECISION: ub4;
    function GetSCALE: ub4;
    function GetCHAR_SIZE: ub2;
    function GetColProperties: ub8;
  public
    constructor Create(AOwner: TOCIHandle; AService: TOCIService); overload;
    constructor Create(AOwner: TOCIHandle; AService: TOCIService; APosition: sb4); overload;
    procedure Bind;
    property Position: sb4 read FPosition write FPosition;
    property DataType: TOCIVarDataType read GetDataType;
    property DataSize: ub4 read GetDataSize;
    property CharSize: ub2 read GetCharSize;
    property ColumnSize: ub4 read GetColumnSize;
    property DataPrecision: sb4 read GetDataPrecision;
    property DataScale: sb4 read GetDataScale;
    property VarType: TOCIVarType read GetVarType;
    property IsNull: Boolean read GetIsNull;
    property BytesPerChar: ub1 read GetBytesPerChar;
    property IsUnicode: Boolean read GetIsUnicode;
    property ColProperties: ub8 read GetColProperties;
    property DATA_SIZE: ub4 read GetDATA_SIZE;
    property DATA_TYPE: ub4 read GetDATA_TYPE;
    property DISP_SIZE: ub4 index OCI_ATTR_DISP_SIZE read GetUb4Attr;
    property NAME: String index OCI_ATTR_NAME read GetStringAttr;
    property PRECISION: ub4 read GetPRECISION;
    property SCALE: ub4 read GetSCALE;
    property IS_NULL: ub4 index OCI_ATTR_IS_NULL read GetUb4Attr;
    property TYPE_NAME: String index OCI_ATTR_TYPE_NAME read GetStringAttr;
    property SUB_NAME: String index OCI_ATTR_SUB_NAME read GetStringAttr;
    property SCHEMA_NAME: String index OCI_ATTR_SCHEMA_NAME read GetStringAttr;
    property IOMODE: ub1 index OCI_ATTR_IOMODE read GetUB1Attr;
    property CHARSET_ID: ub2 index OCI_ATTR_CHARSET_ID read GetUB2Attr;
    property CHARSET_FORM: ub1 read GetCHARSET_FORM;
    property CHAR_SIZE: ub2 read GetCHAR_SIZE;
    property CHAR_USED: ub4 index OCI_ATTR_CHAR_USED read GetUB4Attr;
    property COL_PROPERTIES: ub8 index OCI_ATTR_COL_PROPERTIES read GetUB8Attr;
  end;

  TOCILobLocator = class(TOCIDescriptor)
  private
    FNational: Boolean;
    FCharsetForm: ub1;
    FOpened: Boolean;
    function GetLength: sb4;
    function GetIsOpen: LongBool;
    function GetIsInit: LongBool;
    procedure CheckCharsetForm;
  public
    constructor Create(AService: TOCIService; AType: ub4);
    constructor CreateUsingHandle(AService: TOCIService; AHandle: pOCIHandle); overload; virtual;
    destructor Destroy; override;
    procedure Assign(AFrom: TOCILobLocator);
    procedure Close;
    procedure Open(AReadOnly: Boolean);
    function Read(ABuff: pUb1; amount: ub4; offset: ub4): ub4;
    property Length: sb4 read GetLength;
    property IsOpen: LongBool read GetIsOpen;
    property IsInit: LongBool read GetIsInit;
    property National: Boolean read FNational write FNational;
  end;

  TOCIIntLocator = class(TOCILobLocator)
  private
    FBuffering: Boolean;
    procedure SetBuffering(const Value: Boolean);
    function GetIsTemporary: LongBool;
  public
    constructor CreateUsingHandle(AService: TOCIService; AHandle: pOCIHandle); overload; override;
    procedure Append(AFrom: TOCIIntLocator);
    procedure Copy(AFrom: TOCIIntLocator; amount, dst_offset, src_offset: ub4);
    procedure Erase(var amount: ub4; offset: ub4);
    procedure FlushBuffer;
    procedure Trim(ANewLen: ub4);
    function Write(ABuff: pUb1; amount: ub4; offset: ub4): ub4;
    procedure LoadFromFile(AFrom: TOCIExtLocator; amount, dst_offset, src_offset: ub4);
    property IsTemporary: LongBool read GetIsTemporary;
    property Buffering: Boolean read FBuffering write SetBuffering;
  end;

  TOCITempLocator = class(TOCIIntLocator)
  public
    constructor CreateTemp(AService: TOCIService; ALobType: ub1; ACache: Boolean);
    destructor Destroy; override;
  end;

  TOCIExtLocator = class(TOCILobLocator)
  private
    function GetFileExists: LongBool;
    function GetDirectory: String;
    function GetFileName: String;
    procedure SetDirectory(const Value: String);
    procedure SetFileName(const Value: String);
    procedure GetFileDir(var ADir, AFileName: String);
    procedure SetFileDir(const ADir, AFileName: String);
  public
    constructor CreateUsingHandle(AService: TOCIService; AHandle: pOCIHandle); overload; override;
    property FileExists: LongBool read GetFileExists;
    property FileName: String read GetFileName write SetFileName;
    property Directory: String read GetDirectory write SetDirectory;
  end;

  TOCILobLocatorStream = class(TStream)
  private
    FLocator: TOCILobLocator;
    FOffset: ub4;
    [weak] FOwningObj: TObject;
    function Bytes2Chars(ABytes: ub4): ub4;
    function Chars2Bytes(AChars: ub4): ub4;
  protected
    function GetSize: Int64; override;
    procedure SetSize(const NewSize: Int64); override;
  public
    constructor Create(ALocator: TOCILobLocator; AOwningObj: TObject);
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
    property Locator: TOCILobLocator read FLocator;
    property OwningObj: TObject read FOwningObj;
  end;

  TOCIDescribe = class(TOCIHandle)
  private
    FCurr: TOCIHandle;
    FStack: TFDPtrList;
    function GetPtr(AIndex: Integer): Pointer;
    function GetSB1(AIndex: Integer): sb1;
    function GetText(AIndex: Integer): String;
    function GetUB1(AIndex: Integer): ub1;
    function GetUB2(AIndex: Integer): ub2;
    function GetUB4(AIndex: Integer): ub4;
    function GetSelectItem(AIndex: Integer): TOCISelectItem;
    function GetIsListOpened: Boolean;
  public
    constructor Create(ASvc: TOCIService);
    destructor Destroy; override;
    procedure DescribeName(const AName: String);
    function OpenList(AAtrType: Integer): ub4;
    procedure CloseList;
    procedure GoToItem(AIndex: Integer);
    property SB1[AIndex: Integer]: sb1 read GetSB1;
    property UB1[AIndex: Integer]: ub1 read GetUB1;
    property UB2[AIndex: Integer]: ub2 read GetUB2;
    property UB4[AIndex: Integer]: ub4 read GetUB4;
    property TEXT[AIndex: Integer]: String read GetText;
    property PTR[AIndex: Integer]: Pointer read GetPtr;
    property SelectItem[AIndex: Integer]: TOCISelectItem read GetSelectItem;
    property IsListOpened: Boolean read GetIsListOpened;
  end;

  TOCIDirectPath = class(TOCIHandle)
  private
    function GetColumns(AIndex: Integer): TOCIDirectPathColumnParam;
  public
    constructor Create(ASvc: TOCIService);
    procedure AbortJob;
    procedure Finish;
    procedure Prepare;
    procedure LoadStream(AStream: TOCIDirectPathStream);
    property BUF_SIZE: ub4 index OCI_ATTR_BUF_SIZE read GetUB4Attr write SetUB4Attr;
    property CHARSET_ID: ub2 index OCI_ATTR_CHARSET_ID read GetUB2Attr write SetUB2Attr;
    property DATEFORMAT: String index OCI_ATTR_DATEFORMAT read GetStringAttr write SetStringAttr;
    property DIRPATH_MODE: ub1 index OCI_ATTR_DIRPATH_MODE read GetUB1Attr write SetUB1Attr;
    property DIRPATH_NOLOG: ub1 index OCI_ATTR_DIRPATH_NOLOG read GetUB1Attr write SetUB1Attr;
    property DIRPATH_PARALLEL: ub1 index OCI_ATTR_DIRPATH_PARALLEL read GetUB1Attr write SetUB1Attr;
    property NUM_COLS: ub2 index OCI_ATTR_NUM_COLS read GetUB2Attr write SetUB2Attr;
    property LIST_COLUMNS: pOCIHandle index OCI_ATTR_LIST_COLUMNS read GetHandleAttr;
    property SCHEMA_NAME: String index OCI_ATTR_SCHEMA_NAME read GetStringAttr write SetStringAttr;
    property NAME: String index OCI_ATTR_NAME read GetStringAttr write SetStringAttr;
    property SUB_NAME: String index OCI_ATTR_SUB_NAME read GetStringAttr write SetStringAttr;
    property Columns[AIndex: Integer]: TOCIDirectPathColumnParam read GetColumns;
  end;

  TOCIDirecPathDataType = (dpUnknown, dpString, dpDateTime, dpInteger,
    dpUInteger, dpFloat, dpRaw);
  TOCIDirecPathDataTypes = set of TOCIDirecPathDataType;
  TOCIDirectPathColArray = class(TOCIHandle)
  public
    constructor Create(ADP: TOCIDirectPath);
    procedure EntryGet(ARowNum: ub4; AColIndex: ub2; var AData: pUb1; var ALen: ub4; var AFlag: ub1);
    procedure EntrySet(ARowNum: ub4; AColIndex: ub2; AData: pUb1; ALen: ub4; AFlag: ub1);
    procedure RowGet(ARowNum: ub4; var ADataArr: ppUb1; var ALenArr: pUb4; var AFlagArr: pUb1);
    procedure Reset;
    function ToStream(AStream: TOCIDirectPathStream; ARowCount, ARowIndex: ub4): sword;
    property NUM_COLS: ub2 index OCI_ATTR_NUM_COLS read GetUB2Attr write SetUB2Attr;
    property NUM_ROWS: ub2 index OCI_ATTR_NUM_ROWS read GetUB2Attr write SetUB2Attr;
    property COL_COUNT: ub2 index OCI_ATTR_COL_COUNT read GetUB2Attr write SetUB2Attr;
    property ROW_COUNT: ub2 index OCI_ATTR_ROW_COUNT read GetUB2Attr write SetUB2Attr;
  end;

  TOCIDirectPathStream = class(TOCIHandle)
  public
    constructor Create(ADP: TOCIDirectPath);
    procedure Reset;
    property BUF_ADDR: Pointer index OCI_ATTR_BUF_ADDR read GetHandleAttr write SetHandleAttr;
    property BUF_SIZE: ub4 index OCI_ATTR_BUF_SIZE read GetUB4Attr write SetUB4Attr;
    property ROW_COUNT: ub4 index OCI_ATTR_ROW_COUNT read GetUB4Attr write SetUB4Attr;
    property STREAM_OFFSET: ub4 index OCI_ATTR_STREAM_OFFSET read GetUB4Attr write SetUB4Attr;
  end;

  TOCIDirectPathColumnParam = class(TOCIDescriptor)
  private
    function GetDataType: TOCIDirecPathDataType;
    procedure SetDataType(AValue: TOCIDirecPathDataType);
  public
    constructor Create(ADP: TOCIDirectPath);
    property CHARSET_ID: ub2 index OCI_ATTR_CHARSET_ID read GetUB2Attr write SetUB2Attr;
    property DATA_SIZE: ub4 index OCI_ATTR_DATA_SIZE read GetUB4Attr write SetUB4Attr;
    property DATA_TYPE: ub2 index OCI_ATTR_DATA_TYPE read GetUB2Attr write SetUB2Attr;
    property DATEFORMAT: String index OCI_ATTR_DATEFORMAT read GetStringAttr write SetStringAttr;
    property NAME: String index OCI_ATTR_NAME read GetStringAttr write SetStringAttr;
    property PRECISION: ub1 index OCI_ATTR_PRECISION read GetUB1Attr write SetUB1Attr;
    property SCALE: sb1 index OCI_ATTR_SCALE read GetSB1Attr write SetSB1Attr;
    property DataType: TOCIDirecPathDataType read GetDataType write SetDataType;
  end;

  TOCIOnDefineParam = procedure (const ANm, ATpNm: String; AVt: TOCIVarType;
    FDt: TOCIVarDataType; ASz, APrec, ASCale: sb4; AIsTable, AIsResult: Boolean) of object;
  TOCIPLSQLDescriber = class(TObject)
  private
    // setup
    FSrvc: TOCIService;
    [weak] FOwningObj: TObject;
    FOPackageName, FOProcedureName: String;
    FOverload: Integer;
    FBoolTrue, FBoolFalse: String;
    FBoolType: TOCIVarDataType;
    FBoolSize: sb4;
    FBindByName: Boolean;
    // run time
    FDescr: TOCIDescribe;
    FSPName: String;
    FObjType: ub1;
    FNumProcs: ub4;
    FProcIndex: ub4;
    FForProc: Boolean;
  public
    constructor CreateForProc(ASrvc: TOCIService; const AOPackageName,
      AOProcedureName: String; AOverload: Integer; AOwningObj: TObject = nil);
    constructor CreateForPack(ASrvc: TOCIService; const AOPackageName: String;
      AOwningObj: TObject = nil);
    destructor Destroy; override;
    procedure Describe;
    function LocateProc(AExactOverload: Boolean): Boolean;
    procedure First(var AProcName: String; var AOverload: Integer);
    procedure Next(var AProcName: String; var AOverload: Integer);
    function Eol: Boolean;
    function BuildSQL(AOnDefPar: TOCIOnDefineParam): String;
    procedure CleanUp;
    property Descr: TOCIDescribe read FDescr;
    property ObjType: ub1 read FObjType;
    property OwningObj: TObject read FOwningObj;
    property BoolFalse: String read FBoolFalse write FBoolFalse;
    property BoolTrue: String read FBoolTrue write FBoolTrue;
    property BoolType: TOCIVarDataType read FBoolType write FBoolType;
    property BoolSize: sb4 read FBoolSize write FBoolSize;
    property BindByName: Boolean read FBindByName write FBindByName;
  end;

  TOCIOpaqueValue = class(TOCIDescriptor)
  private
    procedure CheckSupported;
  protected
    FIsNull: Boolean;
    FParsed: Boolean;
    procedure InternalAssign(ASource: TOCIOpaqueValue); virtual; abstract;
    procedure InternalErase; virtual; abstract;
    procedure InternalParse; virtual; abstract;
    function  GetAsString: string; virtual; abstract;
    procedure SetAsString(const AValue: string); virtual; abstract;
    class function GetMinClientVersion: TFDVersion; virtual;
  public
    constructor Create(AEnv: TOCIEnv; AType: ub4);
    constructor CreateUsingHandle(AEnv: TOCIEnv; AHandle: pOCIDescriptor); override;
    procedure Assign(ASource: TOCIOpaqueValue);
    procedure Clear;
    procedure Parse;
    property IsNull: Boolean read FIsNull;
    property AsString: String read GetAsString write SetAsString;
  end;

  TOCITimestamp = class(TOCIOpaqueValue)
  private
    FYear: sb2;
    FMonth: ub1;
    FDay: ub1;
    FHour: ub1;
    FMinute: ub1;
    FSecond: ub1;
    FNanoSeconds: ub4;
    FTZHour: sb1;
    FTZMinute: sb1;
    function GetAsDateTime: TDateTime;
    procedure SetAsDateTime(const AValue: TDateTime);
    function GetAsSQLTimeStampFun: TSQLTimeStamp;
  protected
    procedure InternalAssign(ASource: TOCIOpaqueValue); override;
    procedure InternalErase; override;
    procedure InternalParse; override;
    function GetAsString: string; override;
    procedure SetAsString(const AValue: string); override;
    class function GetMinClientVersion: TFDVersion; override;
  public
    procedure SetValues(AYear: sb2; AMonth, ADay, AHour, AMinute, ASecond: ub1;
      ANanoSeconds: ub4; ATZHour: sb2 = 0; ATZMinute: sb2 = 0);
    procedure SetAsSQLTimeStamp(const AValue: TSQLTimeStamp);
    procedure GetAsSQLTimeStamp(out AValue: TSQLTimeStamp);
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsSQLTimeStamp: TSQLTimeStamp read GetAsSQLTimeStampFun write SetAsSQLTimeStamp;
    property Year: sb2 read FYear;
    property Month: ub1 read FMonth;
    property Day: ub1 read FDay;
    property Hour: ub1 read FHour;
    property Minute: ub1 read FMinute;
    property Second: ub1 read FSecond;
    property NanoSeconds: ub4 read FNanoSeconds;
    property TZHour: sb1 read FTZHour;
    property TZMinute: sb1 read FTZMinute;
  end;

  TOCITimeIntervalKind = (ikUnknown, ikYear2Month, ikDay2Second);
  TOCITimeInterval = class(TOCIOpaqueValue)
  private
    FYears: sb4;
    FMonths: sb4;
    FDays: sb4;
    FHours: sb4;
    FMinutes: sb4;
    FSeconds: sb4;
    FNanoSeconds: sb4;
    FKind: TOCITimeIntervalKind;
    function GetAsSQLTimeIntervalFun: TFDSQLTimeInterval;
  protected
    procedure InternalAssign(ASource: TOCIOpaqueValue); override;
    procedure InternalErase; override;
    procedure InternalParse; override;
    function GetAsString: string; override;
    procedure SetAsString(const AValue: string); override;
    class function GetMinClientVersion: TFDVersion; override;
  public
    constructor Create(AEnv: TOCIEnv; AType: ub4);
    constructor CreateUsingHandle(AEnv: TOCIEnv; AHandle: pOCIHandle; ADataType: TOCIVarDataType); overload;
    procedure SetYear2Month(AYears, AMonths: sb4);
    procedure SetDay2Second(ADays, AHours, AMinutes, ASeconds, ANanoSeconds: sb4);
    procedure SetAsSQLTimeInterval(const AValue: TFDSQLTimeInterval);
    procedure GetAsSQLTimeInterval(out AValue: TFDSQLTimeInterval);
    property AsSQLTimeInterval: TFDSQLTimeInterval read GetAsSQLTimeIntervalFun write SetAsSQLTimeInterval;
    property Years: sb4 read FYears;
    property Months: sb4 read FMonths;
    property Days: sb4 read FDays;
    property Hours: sb4 read FHours;
    property Minutes: sb4 read FMinutes;
    property Seconds: sb4 read FSeconds;
    property NanoSeconds: sb4 read FNanoSeconds;
    property Kind: TOCITimeIntervalKind read FKind;
  end;

  TOCICollection = class(TOCIDescriptor)
  private
    function GetCount: sb4;
  public
    procedure Assign(AColl: TOCICollection);
    function GetData(AIndex: sb4; var AData: Pointer): Boolean;
    procedure SetData(AIndex: sb4; AData: Pointer);
    procedure Trim(ANumber: sb4);
    property Count: sb4 read GetCount;
  end;

  TOCIDescCollection<T: TOCIDescriptor> = class(TOCICollection)
  private
    FDesc: T;
    function GetItems(AIndex: Integer): T;
  public
    destructor Destroy; override;
    property Items[AIndex: Integer]: T read GetItems; default;
  end;

  TOCIStartupFlag = (sfRestrict, sfForce);
  TOCIStartupFlags = set of TOCIStartupFlag;
  TOCIShutdownMode = (smTransactional, smTransactionalLocal, smImmediate,
    smAbort, smFinal);
  TOCIAdmin = class(TOCIHandle)
  public
    constructor Create(AService: TOCIService);
    procedure Startup(AFlags: TOCIStartupFlags = []);
    procedure Shutdown(AMode: TOCIShutdownMode = smTransactional);
    property PFILE: String index OCI_ATTR_ADMIN_PFILE read GetStringAttr write SetStringAttr;
  end;

  TOCISubscription = class(TOCIHandle)
  private type
    TState = (ssInactive, ssActive, ssDisabled);
  private
    FState: TState;
    class procedure SubEventCallback(ctx: Pointer; subscrhp: pOCISubscription;
      payload: Pointer; paylen: Ub4; desc: pOCIDescriptor; mode: ub4); static; cdecl;
  protected
    procedure DoSubEvent(payload: Pointer; paylen: Ub4; desc: pOCIDescriptor; mode: ub4); virtual;
  public
    constructor Create(AService: TOCIService);
    procedure Register;
    procedure Unregister;
    procedure Enable;
    procedure Disable;
    procedure Post;
    property NAMESPACE: ub4 index OCI_ATTR_SUBSCR_NAMESPACE read GetUb4Attr write SetUb4Attr;
    property _CALLBACK: Pointer index OCI_ATTR_SUBSCR_CALLBACK read GetHandleAttr write SetHandleAttr;
    property CTX: Pointer index OCI_ATTR_SUBSCR_CTX read GetHandleAttr write SetHandleAttr;
    property QOSFLAGS: ub4 index OCI_ATTR_SUBSCR_QOSFLAGS read GetUB4Attr write SetUB4Attr;
    property TIMEOUT: ub4 index OCI_ATTR_SUBSCR_TIMEOUT read GetUB4Attr write SetUB4Attr;
    property RECPTPROTO: ub4 index OCI_ATTR_SUBSCR_RECPTPROTO read GetUB4Attr write SetUB4Attr;
    property RECPT: String index OCI_ATTR_SUBSCR_RECPT read GetStringAttr write SetStringAttr;
    property RECPTPRES: ub4 index OCI_ATTR_SUBSCR_RECPTPRES read GetUB4Attr write SetUB4Attr;
    property PAYLOAD: TBytes index OCI_ATTR_SUBSCR_PAYLOAD read GetBytesAttr write SetBytesAttr;
    property IPADDR: String index OCI_ATTR_SUBSCR_IPADDR read GetStringAttr write SetStringAttr;
    property PORTNO: ub4 index OCI_ATTR_SUBSCR_PORTNO read GetUB4Attr write SetUB4Attr;
  end;

  TOCIChangeRowDesc = class(TOCIDescriptor)
  public
    constructor CreateUsingHandle(AEnv: TOCIEnv; AHandle: pOCIHandle); override;
    property ROWID: String index OCI_ATTR_CHDES_ROW_ROWID read GetStringAttr;
    property OPFLAGS: ub4 index OCI_ATTR_CHDES_ROW_OPFLAGS read GetUB4Attr;
  end;

  TOCIChangeTableDesc = class(TOCIDescriptor)
  public type
    TRows = TOCIDescCollection<TOCIChangeRowDesc>;
  private
    FRows: TOCICollection;
    function GetRows: TRows;
  public
    constructor CreateUsingHandle(AEnv: TOCIEnv; AHandle: pOCIHandle); override;
    destructor Destroy; override;
    property NAME: String index OCI_ATTR_CHDES_TABLE_NAME read GetStringAttr;
    property OPFLAGS: ub4 index OCI_ATTR_CHDES_TABLE_OPFLAGS read GetUB4Attr;
    property ROW_CHANGES: pOCIColl index OCI_ATTR_CHDES_TABLE_ROW_CHANGES read GetHandleAttr;
    property Rows: TRows read GetRows;
  end;

  TOCIChangeQueryDesc = class(TOCIDescriptor)
  public type
    TTables = TOCIDescCollection<TOCIChangeTableDesc>;
  private
    FTables: TTables;
    function GetTables: TTables;
  public
    constructor CreateUsingHandle(AEnv: TOCIEnv; AHandle: pOCIHandle); override;
    destructor Destroy; override;
    property OPERATION: ub4 index OCI_ATTR_CQDES_OPERATION read GetUB4Attr;
    property QUERYID: ub8 index OCI_ATTR_CQDES_QUERYID read GetUB8Attr;
    property TABLE_CHANGES: pOCIColl index OCI_ATTR_CQDES_TABLE_CHANGES read GetHandleAttr;
    property Tables: TTables read GetTables;
  end;

  TOCIChangeDesc = class(TOCIDescriptor)
  public type
    TTables = TOCIDescCollection<TOCIChangeTableDesc>;
    TQueries = TOCIDescCollection<TOCIChangeQueryDesc>;
  private
    FTables: TTables;
    FQueries: TQueries;
    function GetTables: TTables;
    function GetQueries: TQueries;
  public
    constructor CreateUsingHandle(AEnv: TOCIEnv; AHandle: pOCIHandle); override;
    destructor Destroy; override;
    property DBNAME: String index OCI_ATTR_CHDES_DBNAME read GetStringAttr;
    property XID: ub8 index OCI_ATTR_CHDES_XID read GetUB8Attr;
    property NFYTYPE: ub4 index OCI_ATTR_CHDES_NFYTYPE read GetUB4Attr;
    property TABLE_CHANGES: pOCIColl index OCI_ATTR_CHDES_TABLE_CHANGES read GetHandleAttr;
    property QUERIES_: pOCIColl index OCI_ATTR_CHDES_QUERIES read GetHandleAttr;
    property Tables: TTables read GetTables;
    property Queries: TQueries read GetQueries;
  end;

  TOCIQueryChangeEvent = procedure (ASender: TOCIQueryNotification;
    AChange: TOCIChangeDesc) of object;
  TOCIQueryNotification = class(TOCISubscription)
  private
    FChange: TOCIChangeDesc;
    FTables: TOCICollection;
    FOnChange: TOCIQueryChangeEvent;
    function GetTables: TOCICollection;
  protected
    procedure DoSubEvent(payload: Pointer; paylen: Ub4; desc: pOCIDescriptor;
      mode: ub4); override;
    procedure DoChangeEvent(AChange: TOCIChangeDesc); virtual;
  public
    constructor Create(AService: TOCIService);
    destructor Destroy; override;
    property CQ_QOSFLAGS: ub4 index OCI_ATTR_SUBSCR_CQ_QOSFLAGS read GetUB4Attr write SetUB4Attr;
    property ROWIDS: ub4 index OCI_ATTR_CHNF_ROWIDS read GetUB4Attr write SetUB4Attr;
    property OPERATIONS: ub4 index OCI_ATTR_CHNF_OPERATIONS read GetUB4Attr write SetUB4Attr;
    property CHANGELAG: ub4 index OCI_ATTR_CHNF_CHANGELAG read GetUB4Attr write SetUB4Attr;
    property TABLENAMES: pOCIColl index OCI_ATTR_CHNF_TABLENAMES read GetHandleAttr;
    property Tables: TOCICollection read GetTables;
    property OnChange: TOCIQueryChangeEvent read FOnChange write FOnChange;
  end;

const
  // 40 digits, sign, dot
  C_NumStrLen = 40 + 2;
  // Before 10g = 18, starting from 10g = 23
  C_RowIdLen = 23;

  C_Oracle_Home: String = 'ORACLE_HOME';
  C_NLS_LANG: String = 'NLS_LANG';
  C_Tns_Names: String = 'TNS_NAMES';
  C_Tns_Admin: String = 'TNS_ADMIN';
  C_Network: String = 'Network';
  C_Net80: String = 'NET80';
  C_Admin: String = 'Admin';
  C_TnsNamesOra: String = 'tnsnames.ora';

  otCrsTypes: TOCIVarDataTypes = [otCursor, otNestedDataSet];
  otHTypes: TOCIVarDataTypes = [otCursor, otNestedDataSet, otCLOB, otNCLOB, otBLOB,
    otCFile, otBFile];
  otHBlobs: TOCIVarDataTypes = [otCLOB, otNCLOB, otBLOB, otCFile, otBFile];
  otVBlobs: TOCIVarDataTypes = [otLong, otNLong, otLongRaw];
  otAllBlobs: TOCIVarDataTypes = [otLong, otNLong, otLongRaw, otCLOB, otNCLOB,
    otBLOB, otCFile, otBFile];

  procedure OraDate2DateTime(pIn: pUb1; var D: TDateTimeRec);
  procedure DateTime2OraDate(pOut: pUb1; const D: TDateTimeRec);
  procedure OraNumber2Bcd(pIn: pOCINumber; var B: TBcd);
  procedure Bcd2OraNumber(pOut: pOCINumber; const B: TBcd; out ALen: ub2);

implementation

uses
{$IFDEF MSWINDOWS}
  WinAPI.WinSock,
{$ENDIF MSWINDOWS}
  System.Generics.Collections, System.Types, System.DateUtils,
  FireDAC.Stan.ResStrs;

                                     
                                 
                              
                                       
                                            
                              
                              
                                     
                                                                             
                     
                                                                      
 

{-------------------------------------------------------------------------------}
const
  nc2ociValueType: array[TOCIVarDataType] of ub2 = (0, SQLT_INT, SQLT_UIN, SQLT_INT,
    SQLT_UIN, SQLT_FLT, SQLT_FLT, SQLT_VNU, SQLT_CHR, SQLT_CHR, SQLT_CHR, SQLT_CHR,
    SQLT_BIN, SQLT_DAT, SQLT_LNG, SQLT_LNG, SQLT_LBI, SQLT_CHR, SQLT_BOL, SQLT_RSET,
    SQLT_RSET, SQLT_CLOB, SQLT_CLOB, SQLT_BLOB, SQLT_CFILEE, SQLT_BFILEE,
    SQLT_TIMESTAMP_TZ, SQLT_INTERVAL_YM, SQLT_INTERVAL_DS);
  nc2ociValueSize: array[TOCIVarDataType] of sb4 = (0, SizeOf(Integer), SizeOf(Cardinal),
    SizeOf(Int64), SizeOf(UInt64), SizeOf(Single), SizeOf(Double), OCI_NUMBER_SIZE,
    C_FD_DefStrSize * SizeOf(TFDAnsiChar), C_FD_DefStrSize * SizeOf(TFDAnsiChar),
    C_FD_DefStrSize * SizeOf(WideChar), C_FD_DefStrSize * SizeOf(WideChar),
    C_FD_DefStrSize, SizeOf(TOraDate), C_FD_DefLongSize * SizeOf(TFDAnsiChar),
    C_FD_DefLongSize * SizeOf(WideChar), C_FD_DefLongSize, C_RowIdLen * SizeOf(TFDAnsiChar),
    // For otBoolean is specified SizeOf(Int64) instead of SizeOf(LongBool)
    // to avoid FastMM4 error "memory block footer corruption".
    SizeOf(Int64), SizeOf(pOCIStmt), SizeOf(pOCIStmt), SizeOf(pOCILobLocator),
    SizeOf(pOCILobLocator), SizeOf(pOCILobLocator), SizeOf(pOCILobLocator),
    SizeOf(pOCILobLocator), SizeOf(pOCIDateTime), SizeOf(pOCIInterval),
    SizeOf(pOCIInterval));

  nc2ociDPDataType: array[TOCIDirecPathDataType] of ub2 = (0, SQLT_CHR, SQLT_DAT,
    SQLT_INT, SQLT_UIN, SQLT_FLT, SQLT_BIN);
  nc2ociDPValueSize: array[TOCIDirecPathDataType] of sb4 = (0, C_FD_DefStrSize * SizeOf(Char),
    SizeOf(TOraDate), SizeOf(Integer), SizeOf(Cardinal), SizeOf(Double), C_FD_DefStrSize);

{$IFDEF FireDAC_MONITOR}
  dataTypeName: array[TOCIVarDataType] of String =
    ('otUnknown', 'otInt32', 'otUInt32', 'otInt64', 'otUInt64', 'otSingle', 'otDouble',
     'otNumber', 'otString', 'otChar', 'otNString', 'otNChar', 'otRaw', 'otDateTime',
     'otLong', 'otNLong', 'otLongRaw', 'otROWID', 'otBoolean', 'otCursor', 'otDataSet',
     'otCLOB', 'otNCLOB', 'otBLOB', 'otCFile', 'otBFile', 'otTimeStamp', 'otIntervalYM',
     'otIntervalDS');

  varTypeName: array[TOCIVarType] of String =
    ('odUnknown', 'odIn', 'odOut', 'odInOut', 'odRet', 'odDefine');

  hndlNames: array[1 .. 74] of String =
  ('OCI_HTYPE_ENV',
   'OCI_HTYPE_ERROR',
   'OCI_HTYPE_SVCCTX',
   'OCI_HTYPE_STMT',
   'OCI_HTYPE_BIND',
   'OCI_HTYPE_DEFINE',
   'OCI_HTYPE_DESCRIBE',
   'OCI_HTYPE_SERVER',
   'OCI_HTYPE_SESSION',
   'OCI_HTYPE_TRANS',
   'OCI_HTYPE_COMPLEXOBJECT',
   'OCI_HTYPE_SECURITY',
   'OCI_HTYPE_SUBSCRIPTION',
   'OCI_HTYPE_DIRPATH_CTX',
   'OCI_HTYPE_DIRPATH_COLUMN_ARRAY',
   'OCI_HTYPE_DIRPATH_STREAM',
   'OCI_HTYPE_PROC',
   '','','','','','','','','','',
   // post 10.2
   'OCI_HTYPE_ADMIN',
   'OCI_HTYPE_EVENT',
   '','','','','','','','','','','','','','','','','','','','',
   'OCI_DTYPE_LOB',
   'OCI_DTYPE_SNAP',
   'OCI_DTYPE_RSET',
   'OCI_DTYPE_PARAM',
   'OCI_DTYPE_ROWID',
   'OCI_DTYPE_COMPLEXOBJECTCOMP',
   'OCI_DTYPE_FILE',
   'OCI_DTYPE_AQENQ_OPTIONS',
   'OCI_DTYPE_AQDEQ_OPTIONS',
   'OCI_DTYPE_AQMSG_PROPERTIES',
   'OCI_DTYPE_AQAGENT',
   'OCI_DTYPE_LOCATOR',
   'OCI_DTYPE_INTERVAL_YM',
   'OCI_DTYPE_INTERVAL_DS',
   'OCI_DTYPE_AQNFY_DESCRIPTOR',
   // post 8.1
   'OCI_DTYPE_DATE',
   'OCI_DTYPE_TIME',
   'OCI_DTYPE_TIME_TZ',
   'OCI_DTYPE_TIMESTAMP',
   'OCI_DTYPE_TIMESTAMP_TZ',
   'OCI_DTYPE_TIMESTAMP_LTZ',
   'OCI_DTYPE_UCB',
   'OCI_DTYPE_SRVDN',
   'OCI_DTYPE_SIGNATURE',
   'OCI_DTYPE_RESERVED_1'
  );

  LobTypeNames: array[1 .. 3] of String =
  ('OCI_TEMP_BLOB',
   'OCI_TEMP_CLOB',
   'OCI_TEMP_NCLOB'
  );
{$ENDIF}

{$IFDEF POSIX}
  sOCIClientVersion: String = 'OCIClientVersion';
{$ENDIF}
  sOCIEnvCreate: String = 'OCIEnvCreate';
  sOCIInitialize: String = 'OCIInitialize';
  sOCIEnvInit: String = 'OCIEnvInit';
  sOCIEnvNlsCreate: String = 'OCIEnvNlsCreate';
  sOCINlsCharSetNameToId: String = 'OCINlsCharSetNameToId';
  sOCINlsCharSetIdToName: String = 'OCINlsCharSetIdToName';
  sOCINlsEnvironmentVariableGet: String = 'OCINlsEnvironmentVariableGet';

  sOCIHandleAlloc: String = 'OCIHandleAlloc';
  sOCIHandleFree: String = 'OCIHandleFree';
  sOCIAttrSet: String = 'OCIAttrSet';
  sOCIAttrGet: String = 'OCIAttrGet';
  sOCIDescriptorAlloc: String = 'OCIDescriptorAlloc';
  sOCIDescriptorFree: String = 'OCIDescriptorFree';
  sOCIErrorGet: String = 'OCIErrorGet';

  sOCIServerAttach: String = 'OCIServerAttach';
  sOCIServerDetach: String = 'OCIServerDetach';
  sOCIServerVersion: String = 'OCIServerVersion';
  sOCIBreak: String = 'OCIBreak';
  sOCIReset: String = 'OCIReset';

  sOCISessionBegin: String = 'OCISessionBegin';
  sOCISessionEnd: String = 'OCISessionEnd';
  sOCIPasswordChange: String = 'OCIPasswordChange';

  sOCITransStart: String = 'OCITransStart';
  sOCITransCommit: String = 'OCITransCommit';
  sOCITransRollback: String = 'OCITransRollback';
  sOCITransDetach: String = 'OCITransDetach';
  sOCITransPrepare: String = 'OCITransPrepare';
  sOCITransForget: String = 'OCITransForget';

  sOCIStmtPrepare: String = 'OCIStmtPrepare';
  sOCIStmtExecute: String = 'OCIStmtExecute';
  sOCIStmtGetNextResult: String = 'OCIStmtGetNextResult';
  sOCIStmtFetch: String = 'OCIStmtFetch';
{$IFDEF POSIX}
  sOCIStmtFetch2: String = 'OCIStmtFetch2';
{$ENDIF}
  sOCIStmtGetPieceInfo: String = 'OCIStmtGetPieceInfo';
  sOCIStmtSetPieceInfo: String = 'OCIStmtSetPieceInfo';
  sOCIParamGet: String = 'OCIParamGet';
  sOCIResultSetToStmt: String = 'OCIResultSetToStmt';

  sOCIDefineByPos: String = 'OCIDefineByPos';
  sOCIDefineArrayOfStruct: String = 'OCIDefineArrayOfStruct';
  sOCIRowidToChar: String = 'OCIRowidToChar';

  sOCIBindByPos: String = 'OCIBindByPos';
  sOCIBindByName: String = 'OCIBindByName';
  sOCIBindDynamic: String = 'OCIBindDynamic';

  sOCILobAppend: String = 'OCILobAppend';
  sOCILobAssign: String = 'OCILobAssign';
  sOCILobCharSetForm: String = 'OCILobCharSetForm';
  sOCILobCopy: String = 'OCILobCopy';
  sOCILobEnableBuffering: String = 'OCILobEnableBuffering';
  sOCILobDisableBuffering: String = 'OCILobDisableBuffering';
  sOCILobErase: String = 'OCILobErase';
  sOCILobFileExists: String = 'OCILobFileExists';
  sOCILobFileGetName: String = 'OCILobFileGetName';
  sOCILobFileSetName: String = 'OCILobFileSetName';
  sOCILobFlushBuffer: String = 'OCILobFlushBuffer';
  sOCILobGetLength: String = 'OCILobGetLength';
  sOCILobLoadFromFile: String = 'OCILobLoadFromFile';
  sOCILobLocatorIsInit: String = 'OCILobLocatorIsInit';
  sOCILobRead: String = 'OCILobRead';
  sOCILobTrim: String = 'OCILobTrim';
  sOCILobWrite: String = 'OCILobWrite';

  sOCILobClose: String = 'OCILobClose';
  sOCILobIsOpen: String = 'OCILobIsOpen';
  sOCILobOpen: String = 'OCILobOpen';
  sOCILobCreateTemporary: String = 'OCILobCreateTemporary';
  sOCILobFreeTemporary: String = 'OCILobFreeTemporary';
  sOCILobIsTemporary: String = 'OCILobIsTemporary';
  sOCILobFileClose: String = 'OCILobFileClose';
  sOCILobFileIsOpen: String = 'OCILobFileIsOpen';
  sOCILobFileOpen: String = 'OCILobFileOpen';

  sOCIDescribeAny: String = 'OCIDescribeAny';

  sOCIDirPathAbort: String = 'OCIDirPathAbort';
  sOCIDirPathDataSave: String = 'OCIDirPathDataSave';
  sOCIDirPathFinish: String = 'OCIDirPathFinish';
  sOCIDirPathFlushRow: String = 'OCIDirPathFlushRow';
  sOCIDirPathPrepare: String = 'OCIDirPathPrepare';
  sOCIDirPathLoadStream: String = 'OCIDirPathLoadStream';
  sOCIDirPathColArrayEntryGet: String = 'OCIDirPathColArrayEntryGet';
  sOCIDirPathColArrayEntrySet: String = 'OCIDirPathColArrayEntrySet';
  sOCIDirPathColArrayRowGet: String = 'OCIDirPathColArrayRowGet';
  sOCIDirPathColArrayReset: String = 'OCIDirPathColArrayReset';
  sOCIDirPathColArrayToStream: String = 'OCIDirPathColArrayToStream';
  sOCIDirPathStreamReset: String = 'OCIDirPathStreamReset';
  sOCIDirPathStreamToStream: String = 'OCIDirPathStreamToStream';

  sOCIDateTimeGetDate: String = 'OCIDateTimeGetDate';
  sOCIDateTimeGetTime: String = 'OCIDateTimeGetTime';
  sOCIDateTimeConstruct: String = 'OCIDateTimeConstruct';
  sOCIDateTimeGetTimeZoneOffset: String = 'OCIDateTimeGetTimeZoneOffset';
  sOCIDateTimeAssign: String = 'OCIDateTimeAssign';
  sOCIIntervalAssign: String = 'OCIIntervalAssign';
  sOCIIntervalCheck: String = 'OCIIntervalCheck';
  sOCIIntervalSetYearMonth: String = 'OCIIntervalSetYearMonth';
  sOCIIntervalGetYearMonth: String = 'OCIIntervalGetYearMonth';
  sOCIIntervalSetDaySecond: String = 'OCIIntervalSetDaySecond';
  sOCIIntervalGetDaySecond: String = 'OCIIntervalGetDaySecond';

  sOCIPing: String = 'OCIPing';
  sOCIDBStartup: String = 'OCIDBStartup';
  sOCIDBShutdown: String = 'OCIDBShutdown';

  sOCICollSize: String = 'OCICollSize';
  sOCICollMax: String = 'OCICollMax';
  sOCICollGetElem: String = 'OCICollGetElem';
  sOCICollAssignElem: String = 'OCICollAssignElem';
  sOCICollAssign: String = 'OCICollAssign';
  sOCICollAppend: String = 'OCICollAppend';
  sOCICollTrim: String = 'OCICollTrim';
  sOCICollIsLocator: String = 'OCICollIsLocator';

  sOCIIterCreate: String = 'OCIIterCreate';
  sOCIIterDelete: String = 'OCIIterDelete';
  sOCIIterInit: String = 'OCIIterInit';
  sOCIIterGetCurrent: String = 'OCIIterGetCurrent';
  sOCIIterNext: String = 'OCIIterNext';
  sOCIIterPrev: String = 'OCIIterPrev';

  sOCISubscriptionRegister: String = 'OCISubscriptionRegister';
  sOCISubscriptionPost: String = 'OCISubscriptionPost';
  sOCISubscriptionUnRegister: String = 'OCISubscriptionUnRegister';
  sOCISubscriptionDisable: String = 'OCISubscriptionDisable';
  sOCISubscriptionEnable: String = 'OCISubscriptionEnable';

{-------------------------------------------------------------------------------}
function NormalizePath(const APath: String): String;
begin
  if (APath <> '') and (APath[Length(APath)] = '\') then
    Result := Copy(APath, 1, Length(APath) - 1)
  else
    Result := APath;
end;

{-------------------------------------------------------------------------------}
{$IFDEF MSWINDOWS}
function GetRegPathVar(AReg: TRegistry; const AName: String): String;
begin
  Result := NormalizePath(AReg.ReadString(AName));
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function GetOCITypeName(AType: ub2): String;
begin
  case AType of
  SQLT_CHR: Result := 'SQLT_CHR';
  SQLT_NUM: Result := 'SQLT_NUM';
  SQLT_INT: Result := 'SQLT_INT';
  SQLT_FLT: Result := 'SQLT_FLT';
  SQLT_STR: Result := 'SQLT_STR';
  SQLT_VNU: Result := 'SQLT_VNU';
  SQLT_PDN: Result := 'SQLT_PDN';
  SQLT_LNG: Result := 'SQLT_LNG';
  SQLT_VCS: Result := 'SQLT_VCS';
  SQLT_NON: Result := 'SQLT_NON';
  SQLT_RID: Result := 'SQLT_RID';
  SQLT_DAT: Result := 'SQLT_DAT';
  SQLT_VBI: Result := 'SQLT_VBI';
  SQLT_BIN: Result := 'SQLT_BIN';
  SQLT_LBI: Result := 'SQLT_LBI';
  _SQLT_PLI: Result := '_SQLT_PLI';
  SQLT_UIN: Result := 'SQLT_UIN';
  SQLT_SLS: Result := 'SQLT_SLS';
  SQLT_LVC: Result := 'SQLT_LVC';
  SQLT_LVB: Result := 'SQLT_LVB';
  SQLT_AFC: Result := 'SQLT_AFC';
  SQLT_AVC: Result := 'SQLT_AVC';
  SQLT_CUR: Result := 'SQLT_CUR';
  SQLT_RDD: Result := 'SQLT_RDD';
  SQLT_LAB: Result := 'SQLT_LAB';
  SQLT_OSL: Result := 'SQLT_OSL';
  SQLT_NTY: Result := 'SQLT_NTY';
  SQLT_REF: Result := 'SQLT_REF';
  SQLT_CLOB: Result := 'SQLT_CLOB';
  SQLT_BLOB: Result := 'SQLT_BLOB';
  SQLT_BFILEE: Result := 'SQLT_BFILEE';
  SQLT_CFILEE: Result := 'SQLT_CFILEE';
  SQLT_RSET: Result := 'SQLT_RSET';
  SQLT_NCO: Result := 'SQLT_NCO';
  SQLT_VST: Result := 'SQLT_VST';
  SQLT_ODT: Result := 'SQLT_ODT';
  SQLT_REC: Result := 'SQLT_REC';
  SQLT_TAB: Result := 'SQLT_TAB';
  SQLT_BOL: Result := 'SQLT_BOL';
  // post 8.1
  // datetimes and intervals
  SQLT_DATE: Result := 'SQLT_DATE';
  SQLT_TIME: Result := 'SQLT_TIME';
  SQLT_TIME_TZ: Result := 'SQLT_TIME_TZ';
  SQLT_TIMESTAMP: Result := 'SQLT_TIMESTAMP';
  SQLT_TIMESTAMP_TZ: Result := 'SQLT_TIMESTAMP_TZ';
  SQLT_INTERVAL_YM: Result := 'SQLT_INTERVAL_YM';
  SQLT_INTERVAL_DS: Result := 'SQLT_INTERVAL_DS';
  SQLT_TIMESTAMP_LTZ: Result := 'SQLT_TIMESTAMP_LTZ';
  SQLT_PNTY: Result := 'SQLT_PNTY';
  // >= 10
  // binary
  SQLT_IBFLOAT: Result := 'SQLT_IBFLOAT';
  SQLT_IBDOUBLE: Result := 'SQLT_IBDOUBLE';
  else Result := '<type ' + InttoStr(AType) + '>';
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TOCILib                                                                       }
{-------------------------------------------------------------------------------}
constructor TOCILib.Create(AMessages: TFDLog; AOwningObj: TObject);
begin
  inherited Create(S_FD_OraId, AOwningObj);
  FMessages := AMessages;
end;

{-------------------------------------------------------------------------------}
procedure TOCILib.Load(const AVendorHome, AVendorLib, ANLSLang, ATNSAdmin: String;
  AThreaded: Boolean);
var
  sDLLName: String;
{$IFDEF MSWINDOWS}
  iVerMin: Word;
  rWSAData: TWSAData;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  // This is required to avoid AV on OCI.DLL unloading after CQN was
  // registered, received several notifications and unregistered.
  // Do not put WSACleanup() call into Unload - it will lead to same AV.
  WordRec(iVerMin).Hi := 1;
  WordRec(iVerMin).Lo := 1;
  WSAStartUp(iVerMin, rWSAData);
{$ENDIF}
  if ANLSLang <> '' then begin
    FDSetEnv(C_NLS_LANG, ANLSLang);
    FMessages.Value(C_NLS_LANG, ANLSLang);
  end;
  if ATNSAdmin <> '' then begin
    FDSetEnv(C_TNS_ADMIN, ATNSAdmin);
    FMessages.Value(C_TNS_ADMIN, ATNSAdmin);
  end;
  sDLLName := GetOCIPaths(AVendorHome, AVendorLib);
  FThreaded := AThreaded;
  inherited Load([sDLLName], True);
end;

{-------------------------------------------------------------------------------}
procedure TOCILib.Unload;
begin
  FDFreeAndNil(FEnv);
  inherited Unload;
end;

{-------------------------------------------------------------------------------}
{$IFDEF MSWINDOWS}
function TOCILib.GetOCIPaths(const AVendorHome, AVendorLib: String): String;
var
  sExplicitHome: String;
  sExplicitLib: String;
  lExplicitFound: Boolean;
  sEnvPath: String;
  iBestPath: Integer;
  rSR: TSearchRec;
  sDLLName: String;

  {----------------------------------------------------------------------------}
  procedure SearchBestHome;
  var
    i, n, iPrevInd: Integer;
    s: String;
    oSubKeys: TFDStringList;
    oReg: TRegistry;

    function CheckOCI(const AKey, ARoot, ABin: String): Boolean;
    var
      sFileName: String;
      eMType: TFDMachineType;
    begin
      Result := False;
      sFileName := ABin + '\oci.dll';

      // Check OCI existance
      if not FileExists(sFileName) then begin
        FMessages.Msg(Format(S_FD_OracleWarnLibNotInHome, [sFileName, AKey]));
        Exit;
      end;

      // Ok, found something
      FMessages.Msg(Format(S_FD_OracleMsgLibFound, [sFileName, iBestPath, 'reg: ' + AKey]));

      // Check OCI architecture
      eMType := FDGetLibMachineType(sFileName);
      if not (eMType in [mtUnknown, mtNative]) then begin
        FMessages.Msg(Format(S_FD_OracleWarnArchNotSup,
          [C_FD_MachineTypes[eMType], C_FD_MachineTypes[mtNative]]));
        Exit;
      end;

      FKey := AKey;
      FOracleHome := ARoot;
      sDLLName := oReg.ReadString('ORAOCI');
      FInstantClient := False;
      Result := True;
    end;

    function CheckHome(const AKey: String): Boolean;
    var
      i: Integer;
      sRoot, sBin: String;
      lInPath: Boolean;
    begin
      FMessages.Start(Format(S_FD_OracleMsgChckHome, [AKey]));
      try
        Result := oReg.OpenKeyReadOnly(AKey);
        if Result then begin
          sRoot := GetRegPathVar(oReg, C_Oracle_Home);
          if sRoot <> '' then begin
            sBin := sRoot + '\bin';
            if sExplicitHome <> '' then begin
              if (AnsiCompareText(oReg.ReadString('ORACLE_HOME_NAME'), sExplicitHome) = 0) or
                 (AnsiCompareText(sRoot, NormalizePath(sExplicitHome)) = 0) then
                lExplicitFound := CheckOCI(AKey, sRoot, sBin);
            end
            else begin
              i := 1;
              lInPath := False;
              while i <= Length(sEnvPath) do
                if AnsiCompareText(sBin, NormalizePath(FDExtractFieldName(sEnvPath, i))) = 0 then begin
                  lInPath := True;
                  if iBestPath >= i then begin
                    if CheckOCI(AKey, sRoot, sBin) then
                      iBestPath := i;
                  end
                  else
                    FMessages.Msg(Format(S_FD_OracleMsgSkipHome, [i, iBestPath]));
                  Break;
                end;
              if not lInPath then
                FMessages.Msg(Format(S_FD_OracleWarnBinNotInPath, [sBin]));
            end;
          end;
        end;
      finally
        FMessages.Stop;
      end;
    end;

  begin
    FMessages.Start(S_FD_OracleMsgSrchHome);
    iPrevInd := iBestPath;
    oReg := TRegistry.Create;
    try
      oReg.RootKey := HKEY_LOCAL_MACHINE;
      if CheckHome('\Software\Oracle') then begin
        if oReg.OpenKeyReadOnly('\Software\Oracle\All_Homes') then begin
          s := oReg.ReadString('HOME_COUNTER');
          if s = '' then
            n := 1
          else
            n := StrToInt(s);
          for i := 0 to n - 1 do begin
            CheckHome('\Software\Oracle\Home' + IntToStr(i));
            if lExplicitFound then
              Exit;
          end;
        end;
        // search for ORACLE_HOME in the subkeys of HKLM\Software\Oracle because
        // the 10g client seams to have no ORACLE_HOME in HKLM\Software\Oracle or
        // HKLM\Software\Oracle\All_Homes
        if oReg.OpenKeyReadOnly('\Software\Oracle') then begin
          oSubKeys := TFDStringList.Create;
          try
            oReg.GetKeyNames(oSubKeys);
            for i := 0 to oSubKeys.Count - 1 do
              if AnsiCompareText(Copy(oSubKeys[i], 1, 4), 'KEY_') = 0 then begin
                CheckHome('\Software\Oracle\' + oSubKeys[i]);
                if lExplicitFound then
                  Exit;
              end;
          finally
            FDFree(oSubKeys);
          end;
        end;
      end;
    finally
      FDFree(oReg);
      if (iPrevInd = iBestPath) and not lExplicitFound then
        FMessages.Msg(S_FD_OracleMsgNoHome);
      FMessages.Stop;
    end;
  end;

  {----------------------------------------------------------------------------}
  procedure SearchInstantClient;
  var
    i, iPrevInd: Integer;
    sPath: String;

    function CheckInstantClient(const AFileName, AWhere: String; ABestInd: Integer): Boolean;
    const
      C_OCIEI = 'oraociei*.dll';
      C_OCIICUS = 'oraociicus*.dll';
      C_oraclekey = 'oracle.key';
    var
      sProd, sVerStr, sVerName, sCpr, sInfo: String;
      iVer: TFDVersion;
      rSR: TSearchRec;
      eMType: TFDMachineType;
    begin
      Result := False;
      // Check OCI.DLL existance
      if not FileExists(AFileName) then
        Exit;
      // Check OIC existance
      if FindFirst(FDNormPath(sPath) + C_OCIEI, faAnyFile, rSR) <> 0 then begin
        FindClose(rSR);
        if FindFirst(FDNormPath(sPath) + C_OCIICUS, faAnyFile, rSR) <> 0 then
          Exit;
      end;
      FindClose(rSR);

      // Ok, found something
      FMessages.Msg(Format(S_FD_OracleMsgLibFound, [AFileName, ABestInd, AWhere]));

      // Check OIC architecture
      eMType := FDGetLibMachineType(AFileName);
      if not (eMType in [mtUnknown, mtNative]) then begin
        FMessages.Msg(Format(S_FD_OracleWarnArchNotSup,
          [C_FD_MachineTypes[eMType], C_FD_MachineTypes[mtNative]]));
        Exit;
      end;

      // Check OIC version
      FDGetVersionInfo(AFileName, sProd, sVerStr, sVerName, sCpr, sInfo);
      if sVerStr <> '' then begin
        iVer := FDVerStr2Int(sVerStr);
        if iVer < cvOracle100000 then
          FMessages.Msg(Format(S_FD_OracleWarnInvOCIVer, [sVerStr]));
      end;

      iBestPath := ABestInd;
      FKey := '\Software\Oracle';
      FOracleHome := sPath;
      sDLLName := AFileName;
      FInstantClient := True;
      Result := True;
    end;

  begin
    FMessages.Start(S_FD_OracleMsgSrchOIC);
    iPrevInd := iBestPath;
    try
      if sExplicitLib <> '' then begin
        sPath := ExtractFilePath(sExplicitLib);
        lExplicitFound := CheckInstantClient(FDNormPath(sPath) + 'oci.dll', 'VendorLib', 0);
        if lExplicitFound then
          Exit;
      end;
      sPath := GetModuleName(HInstance);
      sPath := ExtractFilePath(sPath);
      if CheckInstantClient(FDNormPath(sPath) + 'oci.dll', 'app folder', 0) then
        Exit;
      i := 1;
      while i <= Length(sEnvPath) do begin
        sPath := FDExtractFieldName(sEnvPath, i);
        if CheckInstantClient(FDNormPath(sPath) + 'oci.dll', 'PATH', i) then
          Exit;
      end;
    finally
      if (iPrevInd = iBestPath) and not lExplicitFound then
        FMessages.Msg(S_FD_OracleMsgNoHome);
      FMessages.Stop;
    end;
  end;

begin
  if AVendorHome <> '' then
    sExplicitHome := AVendorHome
  else
    sExplicitHome := GetEnvironmentVariable(C_Oracle_Home);
  if sExplicitHome <> '' then
    FMessages.Value('Explicit Oracle Home', sExplicitHome);

  if AVendorLib <> '' then
    sExplicitLib := AVendorLib
  else
    sExplicitLib := GetEnvironmentVariable('ORAOCI');
  if AVendorLib <> '' then
    FMessages.Value('Explicit OCI', AVendorLib);

  sEnvPath := GetEnvironmentVariable('PATH');
  iBestPath := MAXINT;
  FInstantClient := False;
  FOracleHome := '';
  lExplicitFound := False;

  // Search for Instant Client
  SearchInstantClient;

  // Check for regular Oracle homes
  SearchBestHome;

  if FOracleHome = '' then
    FDException(OwningObj, [S_FD_LPhys, S_FD_OraId], er_FD_OraNotInstalled, []);
  if sExplicitLib <> '' then
    sDLLName := sExplicitLib
  else if sDLLName = '' then begin
    // Try to avoid OCI.DLL - extra layer in calls to OCI
    if FindFirst(FDNormPath(FOracleHome) + 'Bin\ORACLIENT*.DLL', faAnyFile, rSR) = 0 then begin
      sDLLName := FDNormPath(FOracleHome) + 'Bin\' + rSR.Name;
      FindClose(rSR);
    end
    // If OraClientNN.dll is not found then back to OCI.dll
    else
      sDLLName := FDNormPath(FOracleHome) + 'Bin\OCI.DLL';
    // And single case, when things differs - 8.0.3
    if not FileExists(sDLLName) then
      sDLLName := FDNormPath(FOracleHome) + 'Bin\ORA803.DLL';
  end;
  Result := sDLLName;
end;

{$ELSE}

function TOCILib.GetOCIPaths(const AVendorHome, AVendorLib: String): String;
begin
  FInstantClient := False;
  if AVendorHome <> '' then
    FOracleHome := AVendorHome
  else
    FOracleHome := GetEnvironmentVariable(C_Oracle_Home);
  if AVendorLib <> '' then
    Result := AVendorLib
  else begin
    Result := GetEnvironmentVariable('ORAOCI');
    if Result = '' then begin
      if FOracleHome <> '' then begin
        Result := FDNormPath(FOracleHome);
        if CompareText(Copy(Result, Length(Result) - 3, MAXINT), 'lib/') <> 0 then
          Result := Result + 'lib/';
      end;
      Result := Result + 'libclntsh' + C_FD_DLLExt;
    end;
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
procedure TOCILib.GetTNSPaths;
{$IFDEF MSWINDOWS}
var
  oReg: TRegistry;
{$ENDIF}
begin
  FTNSNames := GetEnvironmentVariable(C_Tns_Names);
  if FTNSNames = '' then begin
    FTNSNames := GetEnvironmentVariable(C_Tns_Admin);
    if FTNSNames <> '' then
      FTNSNames := FDNormPath(FTNSNames) + C_TnsNamesOra
    else if FInstantClient then
      FTNSNames := FDNormPath(FOracleHome) + FDNormPath(C_Network) +
        FDNormPath(C_Admin) + C_TnsNamesOra
{$IFDEF MSWINDOWS}
    else begin
      oReg := TRegistry.Create;
      try
        oReg.RootKey := HKEY_LOCAL_MACHINE;
        oReg.OpenKeyReadOnly(FKey);
        FTNSNames := oReg.ReadString(C_Tns_Names);
        if FTNSNames = '' then begin
          FTNSNames := GetRegPathVar(oReg, C_Tns_Admin);
          if FTNSNames = '' then begin
            if Version >= cvOracle81000 then
              FTNSNames := GetRegPathVar(oReg, C_Network)
            else
              FTNSNames := GetRegPathVar(oReg, C_Net80);
            if FTNSNames = '' then begin
              if Version >= cvOracle81000 then
                FTNSNames := FDNormPath(FOracleHome) + C_Network
              else
                FTNSNames := FDNormPath(FOracleHome) + C_Net80;
            end;
            FTNSNames := FDNormPath(FTNSNames) + C_Admin;
          end;
          FTNSNames := FDNormPath(FTNSNames) + C_TnsNamesOra;
        end;
      finally
        FDFree(oReg);
      end;
    end
{$ENDIF}
    ;
  end;
  if not FileExists(FTNSNames) then
    FTNSNames := '';
end;

{-------------------------------------------------------------------------------}
procedure TOCILib.GetNLSLang;
{$IFDEF MSWINDOWS}
var
  oReg: TRegistry;
{$ENDIF}
begin
  FNLSLang := GetEnvironmentVariable(C_NLS_LANG);
{$IFDEF MSWINDOWS}
  if FNLSLang <> '' then
    Exit;
  oReg := TRegistry.Create;
  try
    oReg.RootKey := HKEY_LOCAL_MACHINE;
    oReg.OpenKeyReadOnly(FKey);
    FNLSLang := oReg.ReadString(C_NLS_LANG);
  finally
    FDFree(oReg);
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TOCILib.GetLibraryInfo;
const
  undef: String = '<UNDEFINED>';
var
  sVer: String;
{$IFDEF POSIX}
  iMaj, iMin, iUpd, iPatch, iPort: sword;
{$ENDIF}
begin
  inherited GetLibraryInfo;
{$IFDEF POSIX}
  @OCIClientVersion := GetProc(sOCIClientVersion, False);
  if Assigned(OCIClientVersion) then begin
    OCIClientVersion(iMaj, iMin, iUpd, iPatch, iPort);
    FVersion := TFDVersion(iMaj) * 100000000 + TFDVersion(iMin) * 1000000 +
      TFDVersion(iUpd) * 10000 + TFDVersion(iPatch) * 100 + TFDVersion(iPort);
  end
  else if Assigned(GetProc(sOCIStmtGetNextResult, False)) then
    FVersion := cvOracle120000
  else if Assigned(GetProc(sOCIPing, False)) then
    FVersion := cvOracle102000
  else if Assigned(GetProc(sOCIEnvNlsCreate, False)) then
    FVersion := cvOracle92000
  else if Assigned(GetProc(sOCIStmtFetch2, False)) then
    FVersion := cvOracle90000
  else if Assigned(GetProc(sOCIEnvCreate, False)) then
    FVersion := cvOracle81000
  else
    FVersion := cvOracle80000;
{$ENDIF}
  if Version < cvOracle80000 then begin
    if Version = 0 then
      sVer := undef
    else
      sVer := VersionStr;
    FDException(OwningObj, [S_FD_LPhys, S_FD_OraId], er_FD_OraBadVersion,
      [DLLName, sVer]);
  end;
  GetTNSPaths;
  GetNLSLang;
end;

{-------------------------------------------------------------------------------}
procedure TOCILib.LoadEntries;
begin
  if Version >= cvOracle92000 then begin
    @OCIEnvNlsCreate := GetProc(sOCIEnvNlsCreate);
    @OCINlsCharSetNameToId := GetProc(sOCINlsCharSetNameToId);
    @OCINlsCharSetIdToName := GetProc(sOCINlsCharSetIdToName);
    @OCINlsEnvironmentVariableGet := GetProc(sOCINlsEnvironmentVariableGet);
  end;
  if Version >= cvOracle81000 then
    @OCIEnvCreate := GetProc(sOCIEnvCreate)
  else begin
    @OCIInitialize := GetProc(sOCIInitialize);
    @OCIEnvInit := GetProc(sOCIEnvInit);
  end;

  @OCIHandleAlloc := GetProc(sOCIHandleAlloc);
  @OCIHandleFree := GetProc(sOCIHandleFree);
  @OCIAttrSet := GetProc(sOCIAttrSet);
  @OCIAttrGet := GetProc(sOCIAttrGet);
  @OCIDescriptorAlloc := GetProc(sOCIDescriptorAlloc);
  @OCIDescriptorFree := GetProc(sOCIDescriptorFree);
  @OCIErrorGet := GetProc(sOCIErrorGet);

  @OCIServerAttach := GetProc(sOCIServerAttach);
  @OCIServerDetach := GetProc(sOCIServerDetach);
  @OCIServerVersion := GetProc(sOCIServerVersion);
  @OCIBreak := GetProc(sOCIBreak);
  if Version >= cvOracle81000 then
    @OCIReset := GetProc(sOCIReset);

  @OCISessionBegin := GetProc(sOCISessionBegin);
  @OCISessionEnd := GetProc(sOCISessionEnd);
  @OCIPasswordChange := GetProc(sOCIPasswordChange);

  @OCITransStart := GetProc(sOCITransStart);
  @OCITransCommit := GetProc(sOCITransCommit);
  @OCITransRollback := GetProc(sOCITransRollback);
  @OCITransDetach := GetProc(sOCITransDetach);
  @OCITransPrepare := GetProc(sOCITransPrepare);
  @OCITransForget := GetProc(sOCITransForget);

  @OCIStmtPrepare := GetProc(sOCIStmtPrepare);
  @OCIStmtExecute := GetProc(sOCIStmtExecute);
  if Version >= cvOracle120000 then
    @OCIStmtGetNextResult := GetProc(sOCIStmtGetNextResult);
  @OCIStmtFetch := GetProc(sOCIStmtFetch);
  @OCIStmtGetPieceInfo := GetProc(sOCIStmtGetPieceInfo);
  @OCIStmtSetPieceInfo := GetProc(sOCIStmtSetPieceInfo);
  @OCIParamGet := GetProc(sOCIParamGet);
  @OCIResultSetToStmt := GetProc(sOCIResultSetToStmt);

  @OCIDefineByPos := GetProc(sOCIDefineByPos);
  @OCIDefineArrayOfStruct := GetProc(sOCIDefineArrayOfStruct);
  if Version >= cvOracle90000 then
    @OCIRowidToChar := GetProc(sOCIRowidToChar);

  @OCIBindByPos := GetProc(sOCIBindByPos);
  @OCIBindByName := GetProc(sOCIBindByName);
  @OCIBindDynamic := GetProc(sOCIBindDynamic);

  @OCILobAppend := GetProc(sOCILobAppend);
  @OCILobAssign := GetProc(sOCILobAssign);
  @OCILobCopy := GetProc(sOCILobCopy);
  @OCILobCharSetForm := GetProc(sOCILobCharSetForm);
  @OCILobEnableBuffering := GetProc(sOCILobEnableBuffering);
  @OCILobDisableBuffering := GetProc(sOCILobDisableBuffering);
  @OCILobErase := GetProc(sOCILobErase);
  @OCILobFileExists := GetProc(sOCILobFileExists);
  @OCILobFileGetName := GetProc(sOCILobFileGetName);
  @OCILobFileSetName := GetProc(sOCILobFileSetName);
  @OCILobFlushBuffer := GetProc(sOCILobFlushBuffer);
  @OCILobGetLength := GetProc(sOCILobGetLength);
  @OCILobLoadFromFile := GetProc(sOCILobLoadFromFile);
  @OCILobLocatorIsInit := GetProc(sOCILobLocatorIsInit);
  @OCILobRead := GetProc(sOCILobRead);
  @OCILobTrim := GetProc(sOCILobTrim);
  @OCILobWrite := GetProc(sOCILobWrite);
  if Version >= cvOracle81000 then begin
    @OCILobClose := GetProc(sOCILobClose);
    @OCILobIsOpen := GetProc(sOCILobIsOpen);
    @OCILobOpen := GetProc(sOCILobOpen);
    @OCILobCreateTemporary := GetProc(sOCILobCreateTemporary);
    @OCILobFreeTemporary := GetProc(sOCILobFreeTemporary);
    @OCILobIsTemporary := GetProc(sOCILobIsTemporary);
  end
  else begin
    @OCILobClose := GetProc(sOCILobFileClose);
    @OCILobIsOpen := GetProc(sOCILobFileIsOpen);
    @OCILobOpen := GetProc(sOCILobFileOpen);
  end;

  @OCIDescribeAny := GetProc(sOCIDescribeAny);

  if Version >= cvOracle81000 then begin
    @OCIDirPathAbort := GetProc(sOCIDirPathAbort);
    @OCIDirPathDataSave := GetProc(sOCIDirPathDataSave);
    @OCIDirPathFinish := GetProc(sOCIDirPathFinish);
    @OCIDirPathFlushRow := GetProc(sOCIDirPathFlushRow);
    @OCIDirPathPrepare := GetProc(sOCIDirPathPrepare);
    @OCIDirPathLoadStream := GetProc(sOCIDirPathLoadStream);
    @OCIDirPathColArrayEntryGet := GetProc(sOCIDirPathColArrayEntryGet);
    @OCIDirPathColArrayEntrySet := GetProc(sOCIDirPathColArrayEntrySet);
    @OCIDirPathColArrayRowGet := GetProc(sOCIDirPathColArrayRowGet);
    @OCIDirPathColArrayReset := GetProc(sOCIDirPathColArrayReset);
    @OCIDirPathColArrayToStream := GetProc(sOCIDirPathColArrayToStream);
    @OCIDirPathStreamReset := GetProc(sOCIDirPathStreamReset);
    if Version < cvOracle90000 then
      @OCIDirPathStreamToStream := GetProc(sOCIDirPathStreamToStream);
  end;

  if Version >= cvOracle90000 then begin
    @OCIDateTimeGetDate := GetProc(sOCIDateTimeGetDate);
    @OCIDateTimeGetTime := GetProc(sOCIDateTimeGetTime);
    @OCIDateTimeConstruct := GetProc(sOCIDateTimeConstruct);
    @OCIDateTimeGetTimeZoneOffset := GetProc(sOCIDateTimeGetTimeZoneOffset);
    @OCIDateTimeAssign := GetProc(sOCIDateTimeAssign);
    @OCIIntervalAssign := GetProc(sOCIIntervalAssign);
    @OCIIntervalCheck := GetProc(sOCIIntervalCheck);
    @OCIIntervalSetYearMonth := GetProc(sOCIIntervalSetYearMonth);
    @OCIIntervalGetYearMonth := GetProc(sOCIIntervalGetYearMonth);
    @OCIIntervalSetDaySecond := GetProc(sOCIIntervalSetDaySecond);
    @OCIIntervalGetDaySecond := GetProc(sOCIIntervalGetDaySecond);
  end;

  if Version >= cvOracle102000 then begin
    @OCIPing := GetProc(sOCIPing);
    @OCIDBStartup := GetProc(sOCIDBStartup);
    @OCIDBShutdown := GetProc(sOCIDBShutdown);
  end;

  @OCICollSize := GetProc(sOCICollSize);
  @OCICollMax := GetProc(sOCICollMax);
  @OCICollGetElem := GetProc(sOCICollGetElem);
  @OCICollAssignElem := GetProc(sOCICollAssignElem);
  @OCICollAssign := GetProc(sOCICollAssign);
  @OCICollAppend := GetProc(sOCICollAppend);
  @OCICollTrim := GetProc(sOCICollTrim);
  @OCICollIsLocator := GetProc(sOCICollIsLocator);

  @OCIIterCreate := GetProc(sOCIIterCreate);
  @OCIIterDelete := GetProc(sOCIIterDelete);
  @OCIIterInit := GetProc(sOCIIterInit);
  @OCIIterGetCurrent := GetProc(sOCIIterGetCurrent);
  @OCIIterNext := GetProc(sOCIIterNext);
  @OCIIterPrev := GetProc(sOCIIterPrev);

  if Version >= cvOracle102000 then begin
    @OCISubscriptionRegister := GetProc(sOCISubscriptionRegister);
    @OCISubscriptionPost := GetProc(sOCISubscriptionPost);
    @OCISubscriptionUnRegister := GetProc(sOCISubscriptionUnRegister);
    @OCISubscriptionDisable := GetProc(sOCISubscriptionDisable);
    @OCISubscriptionEnable := GetProc(sOCISubscriptionEnable);
  end;
end;

{-------------------------------------------------------------------------------}
class procedure TOCILib.GetOracleHomeList(AList: TStrings);
{$IFDEF MSWINDOWS}
var
  s: String;
  oReg: TRegistry;
  n, i: Integer;
  oSubKeys: TFDStringList;
{$ENDIF}
begin
  AList.Clear;
{$IFDEF MSWINDOWS}
  oReg := TRegistry.Create;
  try
    oReg.RootKey := HKEY_LOCAL_MACHINE;
    if oReg.OpenKeyReadOnly('\Software\Oracle\All_Homes') then begin
      s := oReg.ReadString('HOME_COUNTER');
      if s = '' then
        n := 1
      else
        n := StrToInt(s);
      for i := 0 to n - 1 do
        if oReg.OpenKeyReadOnly('\Software\Oracle\Home' + IntToStr(i)) then begin
          s := oReg.ReadString('ORACLE_HOME_NAME');
          if s <> '' then
            AList.Add(s);
        end;
    end;
    if oReg.OpenKeyReadOnly('\Software\Oracle') then begin
      oSubKeys := TFDStringList.Create;
      try
        oReg.GetKeyNames(oSubKeys);
        for i := 0 to oSubKeys.Count - 1 do
          if (AnsiCompareText(Copy(oSubKeys[i], 1, 4), 'KEY_') = 0) and
             oReg.OpenKeyReadOnly('\Software\Oracle\' + oSubKeys[i]) then begin
            s := oReg.ReadString('ORACLE_HOME_NAME');
            if s <> '' then
              AList.Add(s);
          end;
      finally
        FDFree(oSubKeys);
      end;
    end;
  finally
    FDFree(oReg);
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TOCILib.GetTNSServicesList(AList: TStrings);
var
  InComment, InStr: Boolean;
  pCh, pStParam: PChar;
  s, buff: String;
  BraceLevel: Integer;
  f: TFDTextFile;
begin
  AList.Clear;
  AList.Add(S_FD_Local);
  if FTNSNames = '' then
    Exit;
  try
    f := TFDTextFile.Create(FTNSNames, True, False, ecDefault, elDefault);
    try
      buff := f.ExtractString(f.Position, f.Stream.Size);
    finally
      FDFree(f);
    end;
  except
    Exit;
  end;
  InComment := False;
  InStr := False;
  BraceLevel := 0;
  pCh := PChar(Buff) - 1;
  s := '';
  repeat
    Inc(pCh);
    case pCh^ of
    '#':
      if not InComment and not InStr then
        InComment := True;
    '''':
      if not InComment then
        InStr := not InStr;
    '(':
      if not InComment and not InStr then
        Inc(BraceLevel);
    ')':
      if not InComment and not InStr then begin
        Dec(BraceLevel);
        if BraceLevel < 0 then
          FDException(OwningObj, [S_FD_LPhys, S_FD_OraId], er_FD_OraDBTNManyClBraces, [s]);
      end;
    #13, #10:
      if InComment then
        InComment := False;
    'a'..'z', 'A'..'Z', '0'..'9':
      if not InComment and not InStr and (BraceLevel = 0) then begin
        pStParam := pCh;
        while FDInSet(pCh^, ['a'..'z', 'A'..'Z', '0'..'9', '#', '$', '_', '.', '-']) do
          Inc(pCh);
        SetString(s, pStParam, pCh - pStParam);
        AList.Add(s);
        Dec(pCh);
      end;
    end;
  until pCh^ = #0;
end;

{-------------------------------------------------------------------------------}
function TOCILib.CharSetNameToId(const AName: String): ub2;
begin
  if FEnv = nil then begin
    FEnv := TOCIEnv.Create(Self, nil {$IFDEF FireDAC_Monitor}, nil {$ENDIF});
    FEnv.InitEnv('');
  end;
  Result := FEnv.CharSetNameToId(AName);
end;

{-------------------------------------------------------------------------------}
{ TOCIHandle                                                                    }
{-------------------------------------------------------------------------------}
constructor TOCIHandle.Create(AEnv: TOCIEnv);
begin
  inherited Create;
  FEnv := AEnv;
end;

{-------------------------------------------------------------------------------}
destructor TOCIHandle.Destroy;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIHandleFree, ['@HKind', hndlNames[FType], 'HVal', FHandle]);
  end;
{$ENDIF}
begin
  if (FHandle <> nil) and FOwnHandle then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then ProcTrace;
{$ENDIF}
    Check(Env.Lib.OCIHandleFree(FHandle, FType));
  end;
  inherited Destroy;
  FEnv := nil;
  FHandle := nil;
  FType := 0;
  FOwner := nil;
  FOwningObj := nil;
end;

{-------------------------------------------------------------------------------}
procedure TOCIHandle.Init(AType: ub4);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIHandleAlloc, ['@HKind', hndlNames[AType]]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIHandleAlloc(Env.Handle, FHandle, AType, 0, nil));
  FType := AType;
  FOwnHandle := True;
end;

{-------------------------------------------------------------------------------}
procedure TOCIHandle.SetStringAttr(AAtrType: Integer; const AValue: String);
var
  sb: TFDByteString;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    if AAtrType = OCI_ATTR_PASSWORD then
      Trace(sOCIAttrSet, ['VType', 'str', 'AType', AAtrType, 'Val', '*****'])
    else
      Trace(sOCIAttrSet, ['VType', 'str', 'AType', AAtrType, 'Val', AValue]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  sb := Env.MetaEncoder.Encode(AValue);
  Check(Env.Lib.OCIAttrSet(FHandle, FType, PByte(sb),
    Env.MetaEncoder.EncodedLength(sb), AAtrType, Env.Error.FHandle));
end;

{-------------------------------------------------------------------------------}
function TOCIHandle.GetStringAttr(AAtrType: Integer): String;
var
  l: Integer;
  p: PByte;
  iRes: sword;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrGet, ['@VType', 'str', 'AType', AAtrType, 'Result', Result]);
  end;
{$ENDIF}
begin
  // Initialize p and l, otherwise OCI10 raises AV
  p := nil;
  l := 0;
  iRes := Env.Lib.OCIAttrGet(FHandle, FType, @p, @l, AAtrType, Env.Error.FHandle);
  if Env.MetaEncoder.Encoding = ecUTF16 then
    l := l div SizeOf(WideChar);
  Result := Env.MetaEncoder.Decode(p, l);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
procedure TOCIHandle.SetBytesAttr(AAtrType: Integer; const AValue: TBytes);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrSet, ['VType', 'TBytes', 'AType', AAtrType, 'Val',
      FDBin2Hex(PByte(AValue), Length(AValue))]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIAttrSet(FHandle, FType, PByte(AValue),
    Length(AValue), AAtrType, Env.Error.FHandle));
end;

{-------------------------------------------------------------------------------}
function TOCIHandle.GetBytesAttr(AAtrType: Integer): TBytes;
var
  l: Integer;
  p: PByte;
  iRes: sword;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrGet, ['@VType', 'TBytes', 'AType', AAtrType, 'Result', FDBin2Hex(p, l)]);
  end;
{$ENDIF}
begin
  // Initialize p and l, otherwise OCI10 raises AV
  p := nil;
  l := 0;
  iRes := Env.Lib.OCIAttrGet(FHandle, FType, @p, @l, AAtrType, Env.Error.FHandle);
  Result := BytesOf(p, l);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
procedure TOCIHandle.SetHandleAttr(AAtrType: Integer; AValue: pOCIHandle);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrSet, ['VType', 'hndl', 'AType', AAtrType, 'Val', AValue]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIAttrSet(FHandle, FType, AValue, 0, AAtrType, Env.Error.FHandle));
end;

{-------------------------------------------------------------------------------}
function TOCIHandle.GetHandleAttr(AAtrType: Integer): pOCIHandle;
var
  iRes: sword;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrGet, ['@VType', 'hndl', 'AType', AAtrType, 'Result', NativeUInt(Result)]);
  end;
{$ENDIF}
begin
  Result := nil;
  iRes := Env.Lib.OCIAttrGet(FHandle, FType, @Result, nil, AAtrType, Env.Error.FHandle);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
procedure TOCIHandle.SetUB1Attr(AAtrType: Integer; AValue: ub1);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrSet, ['@VType', 'ub1', 'AType', AAtrType, 'Val', AValue]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIAttrSet(FHandle, FType, @AValue, 0, AAtrType, Env.Error.FHandle));
end;

{-------------------------------------------------------------------------------}
function TOCIHandle.GetUB1Attr(AAtrType: Integer): ub1;
var
  iRes: sword;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrGet, ['@VType', 'ub1', 'AType', AAtrType, 'Result', Result]);
  end;
{$ENDIF}
begin
  Result := 0;
  iRes := Env.Lib.OCIAttrGet(FHandle, FType, @Result, nil, AAtrType, Env.Error.FHandle);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
procedure TOCIHandle.SetUB2Attr(AAtrType: Integer; AValue: ub2);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrSet, ['@VType', 'ub2', 'AType', AAtrType, 'Val', AValue]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIAttrSet(FHandle, FType, @AValue, 0, AAtrType, Env.Error.FHandle));
end;

{-------------------------------------------------------------------------------}
function TOCIHandle.GetUB2Attr(AAtrType: Integer): ub2;
var
  iRes: sword;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrGet, ['@VType', 'ub2', 'AType', AAtrType, 'Result', Result]);
  end;
{$ENDIF}
begin
  Result := 0;
  iRes := Env.Lib.OCIAttrGet(FHandle, FType, @Result, nil, AAtrType, Env.Error.FHandle);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
procedure TOCIHandle.SetUB4Attr(AAtrType: Integer; AValue: ub4);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrSet, ['@VType', 'ub4', 'AType', AAtrType, 'Val', AValue]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIAttrSet(FHandle, FType, @AValue, 0, AAtrType, Env.Error.FHandle));
end;

{-------------------------------------------------------------------------------}
function TOCIHandle.GetUB4Attr(AAtrType: Integer): ub4;
var
  iRes: sword;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrGet, ['@VType', 'ub4', 'AType', AAtrType, 'Result', Result]);
  end;
{$ENDIF}
begin
  Result := 0;
  iRes := Env.Lib.OCIAttrGet(FHandle, FType, @Result, nil, AAtrType, Env.Error.FHandle);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
procedure TOCIHandle.SetSB1Attr(AAtrType: Integer; AValue: sb1);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrSet, ['@VType', 'sb1', 'AType', AAtrType, 'Val', AValue]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIAttrSet(FHandle, FType, @AValue, 0, AAtrType, Env.Error.FHandle));
end;

{-------------------------------------------------------------------------------}
function TOCIHandle.GetSB1Attr(AAtrType: Integer): sb1;
var
  iRes: sword;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrGet, ['@VType', 'sb1', 'AType', AAtrType, 'Result', Result]);
  end;
{$ENDIF}
begin
  Result := 0;
  iRes := Env.Lib.OCIAttrGet(FHandle, FType, @Result, nil, AAtrType, Env.Error.FHandle);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
procedure TOCIHandle.SetSB4Attr(AAtrType: Integer; AValue: Sb4);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrSet, ['@VType', 'sb4', 'AType', AAtrType, 'Val', AValue]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIAttrSet(FHandle, FType, @AValue, 0, AAtrType, Env.Error.FHandle));
end;

{-------------------------------------------------------------------------------}
function TOCIHandle.GetSB4Attr(AAtrType: Integer): sb4;
var
  iRes: sword;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrGet, ['@VType', 'sb4', 'AType', AAtrType, 'Result', Result]);
  end;
{$ENDIF}
begin
  Result := 0;
  iRes := Env.Lib.OCIAttrGet(FHandle, FType, @Result, nil, AAtrType, Env.Error.FHandle);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
procedure TOCIHandle.SetUB8Attr(AAtrType: Integer; AValue: ub8);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrSet, ['@VType', 'ub8', 'AType', AAtrType, 'Val', AValue]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIAttrSet(FHandle, FType, @AValue, 0, AAtrType, Env.Error.FHandle));
end;

{-------------------------------------------------------------------------------}
function TOCIHandle.GetUB8Attr(AAtrType: Integer): ub8;
var
  iRes: sword;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrGet, ['@VType', 'ub8', 'AType', AAtrType, 'Result', Result]);
  end;
{$ENDIF}
begin
  Result := 0;
  iRes := Env.Lib.OCIAttrGet(FHandle, FType, @Result, nil, AAtrType, Env.Error.FHandle);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
procedure TOCIHandle.Check(ACode: sb4);
begin
  if ACode <> OCI_SUCCESS then
    Env.Error.Check(ACode, OwningObj);
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
procedure TOCIHandle.Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
  const AMsg: String; const AArgs: array of const);
begin
  if Env.Tracing then
    Env.Monitor.Notify(AKind, AStep, OwningObj, AMsg, AArgs);
end;

{-------------------------------------------------------------------------------}
procedure TOCIHandle.Trace(AKind: TFDMoniEventKind; const AMsg: String;
  const AArgs: array of const);
begin
  if Env.Tracing then
    Env.Monitor.Notify(AKind, esProgress, OwningObj, AMsg, AArgs);
end;

{-------------------------------------------------------------------------------}
procedure TOCIHandle.Trace(const AMsg: String; const AArgs: array of const);
begin
  if Env.Tracing then
    Env.Monitor.Notify(ekVendor, esProgress, OwningObj, AMsg, AArgs);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
function TOCIHandle.InitCollection(ACollClass: TOCICollectionClass;
  var AColl: TOCICollection; AhColl: pOCIColl): TOCICollection;
begin
  if AhColl = nil then
    Result := nil
  else begin
    if AColl = nil then
      AColl := ACollClass.CreateUsingHandle(Env, AhColl)
    else
      AColl.Handle := AhColl;
    Result := AColl;
  end;
end;

{-------------------------------------------------------------------------------}
{ TOCIEnv                                                                       }
{-------------------------------------------------------------------------------}
constructor TOCIEnv.Create(ALib: TOCILib; AOwningObj: TObject
  {$IFDEF FireDAC_Monitor}; const AMonitor: IFDMoniClient {$ENDIF});
begin
  inherited Create(Self);
  FLib := ALib;
  FOwningObj := AOwningObj;
  FType := OCI_HTYPE_ENV;
  FOwnHandle := True;
{$IFDEF FireDAC_Monitor}
  FMonitor := AMonitor;
{$ENDIF}
  FBuffer := TFDBuffer.Create;
  FDataEncoder := TFDEncoder.Create(FBuffer);
  FMetaEncoder := TFDEncoder.Create(FBuffer);
end;

{-------------------------------------------------------------------------------}
constructor TOCIEnv.CreateUsingHandle(ALib: TOCILib; AOwningObj: TObject;
  AHandle, AErrHandle: pOCIHandle; const ACharsetName: String; AExplicitCharsetID: ub2;
  AByteSemantic: Boolean {$IFDEF FireDAC_Monitor}; const AMonitor: IFDMoniClient {$ENDIF});
begin
  inherited Create(Self);
  FLib := ALib;
  FOwningObj := AOwningObj;
  FType := OCI_HTYPE_ENV;
  FOwnHandle := False;
  FHandle := AHandle;
{$IFDEF FireDAC_Monitor}
  FMonitor := AMonitor;
{$ENDIF}
  FError := TOCIError.CreateUsingHandle(Self, AErrHandle);
  UpdateNLSCharsets;
  FExplicitCharsetID := AExplicitCharsetID;
  FCharsetName := UpperCase(ACharsetName);
  FByteSemantic := AByteSemantic;
  FBuffer := TFDBuffer.Create;
  FDataEncoder := TFDEncoder.Create(FBuffer);
  FMetaEncoder := TFDEncoder.Create(FBuffer);
  UpdateEncoder;
end;

{-------------------------------------------------------------------------------}
destructor TOCIEnv.Destroy;
begin
{$IFDEF FireDAC_MONITOR}
  FMonitor := nil;
{$ENDIF}
  FDFreeAndNil(FError);
  FDFreeAndNil(FMetaEncoder);
  FDFreeAndNil(FDataEncoder);
  FDFreeAndNil(FBuffer);
  try
    inherited Destroy;
  except
    // without that QA, Async Exec, 8.1.6.0.0 will raise AV
    // at OCIHandleFree
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIEnv.InitEnvBase(ACharsetID: ub2);
var
  iMode: ub4;

{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace1;
  begin
    Trace(sOCIEnvCreate, ['Mode', iMode]);
  end;

  procedure ProcTrace2;
  begin
    Trace(sOCIInitialize, ['Mode', iMode]);
  end;

  procedure ProcTrace3;
  begin
    Trace(sOCIEnvInit, []);
  end;

  procedure ProcTrace4;
  begin
    Trace(sOCIEnvNlsCreate, ['Mode', iMode, 'charset', ACharsetID,
      'ncharset', 'OCI_UTF16ID']);
  end;
{$ENDIF}

  procedure Check(ACode: sword);
  begin
    if ACode <> OCI_SUCCESS then
      FDException(OwningObj, EOCINativeException.Create(Self, ACode,
        '. Cannot initialize OCI environment')
        {$IFDEF FireDAC_Monitor}, False {$ENDIF});
  end;

begin
  iMode := OCI_OBJECT or OCI_EVENTS;
  if Lib.FThreaded then
    iMode := iMode or OCI_THREADED or OCI_NO_MUTEX;
  if Lib.Version < cvOracle81500 then
    iMode := iMode and not OCI_EVENTS and not OCI_SHARED and not OCI_NO_MUTEX;
  if Lib.Version >= cvOracle102000 then
    iMode := iMode or OCI_NCHAR_LITERAL_REPLACE_ON;
  if (Lib.Version >= cvOracle92000) and (ACharsetID <> 0) then begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then ProcTrace4;
{$ENDIF}
    FByteSemantic := True;
    Check(Lib.OCIEnvNlsCreate(FHandle, iMode, nil, nil, nil, nil, 0, nil,
      ACharsetID, OCI_UTF16ID));
  end
  else if Lib.Version >= cvOracle81000 then begin
    if ACharsetID = OCI_UTF16ID then
      iMode := iMode or OCI_UTF16;
{$IFDEF FireDAC_MONITOR}
    if Tracing then ProcTrace1;
{$ENDIF}
    Check(Lib.OCIEnvCreate(FHandle, iMode, nil, nil, nil, nil, 0, nil));
  end
  else begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then ProcTrace2;
{$ENDIF}
    Check(Lib.OCIInitialize(iMode, nil, nil, nil, nil));
{$IFDEF FireDAC_MONITOR}
    if Tracing then ProcTrace3;
{$ENDIF}
    Check(Lib.OCIEnvInit(FHandle, OCI_DEFAULT, 0, nil));
  end;
  FError := TOCIError.Create(Self);
end;

{-------------------------------------------------------------------------------}
procedure TOCIEnv.InitEnv(const ACharsetName: String);

  function BuildNLSLang: String;
  begin
    if Lib.FNLSLang = '' then
      Result := '_.' + ACharsetName
    else
      Result := Copy(Lib.FNLSLang, 1, Pos('.', Lib.FNLSLang)) + ACharsetName;
  end;

  procedure ErrorCannotSetCharset(const ACharsetName, AReason: String);
  begin
    FDException(OwningObj, [S_FD_LPhys, S_FD_OraId], er_FD_OraCantSetCharset,
      [ACharsetName, AReason]);
  end;

begin
  FCharsetName := '';
  FExplicitCharsetID := 0;
  FByteSemantic := False;
  if Lib.Version < cvOracle81000 then
    ErrorCannotSetCharset('UTF16', S_FD_OraCantUTF16);
  if (ACharsetName <> '') and (Lib.Version < cvOracle92000) then
    ErrorCannotSetCharset(ACharsetName, S_FD_OraCantSetCharsetInUT16);
  // OCI8 does not support OCI Unicode mode, so all metadata will be
  // ANSI encoded. But data will be UTF8 encoded.
  if Lib.Version < cvOracle90000 then
    InitEnvBase(0)
  else
    InitEnvBase(OCI_UTF16ID);
  if ACharsetName <> '' then begin
    FCharsetName := UpperCase(ACharsetName);
    FExplicitCharsetID := CharSetNameToId(ACharsetName);
  end
  else
    if Lib.Version >= cvOracle92000 then begin
      UpdateNLSCharsets;
      FExplicitCharsetID := NLS_CHARSET_ID;
      FCharsetName := UpperCase(CharSetIdToName(NLS_CHARSET_ID));
    end
    else if Lib.Version >= cvOracle81000 then begin
      FExplicitCharsetID := OCI_UTF8ID;
      FCharsetName := 'UTF8';
    end
    else
      ErrorCannotSetCharset('UTF8', S_FD_OraCantUTF16);
  UpdateEncoder;
end;

{-------------------------------------------------------------------------------}
procedure TOCIEnv.UpdateNLSCharsets;

{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace1;
  begin
    Trace(sOCINlsEnvironmentVariableGet, ['item', 'OCI_NLS_CHARSET_ID',
      'valp', FNLS_CHARSET_ID]);
  end;

  procedure ProcTrace2;
  begin
    Trace(sOCINlsEnvironmentVariableGet, ['item', 'OCI_NLS_NCHARSET_ID',
      'valp', FNLS_NCHARSET_ID]);
  end;
{$ENDIF}

var
  iVal: TFDsize_t;
begin
  if Lib.Version >= cvOracle92000 then begin
    Check(FLib.OCINlsEnvironmentVariableGet(@FNLS_CHARSET_ID, SizeOf(FNLS_CHARSET_ID),
      OCI_NLS_CHARSET_ID, 0, iVal));
{$IFDEF FireDAC_MONITOR}
    if Tracing then ProcTrace1;
{$ENDIF}
    Check(FLib.OCINlsEnvironmentVariableGet(@FNLS_NCHARSET_ID, SizeOf(FNLS_NCHARSET_ID),
      OCI_NLS_NCHARSET_ID, 0, iVal));
{$IFDEF FireDAC_MONITOR}
    if Tracing then ProcTrace2;
{$ENDIF}
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIEnv.UpdateEncoder;

{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace1;
  begin
    Trace(ekVendor, esStart, 'NLS setup', []);
    Trace(ekVendor, esProgress, 'NLS_CHARSET_ID=' + IntToStr(NLS_CHARSET_ID), []);
    Trace(ekVendor, esProgress, 'NLS_NCHARSET_ID=' + IntToStr(NLS_NCHARSET_ID), []);
    Trace(ekVendor, esProgress, 'CharsetName=' + CharsetName, []);
    Trace(ekVendor, esProgress, 'ExplicitCharsetID=' + IntToStr(ExplicitCharsetID), []);
    Trace(ekVendor, esProgress, 'ByteSemantic=' + S_FD_Bools[ByteSemantic], []);
    Trace(ekVendor, esEnd, 'NLS setup', []);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then ProcTrace1;
{$ENDIF}
  if (CharsetName = 'UTF8') or (CharsetName = 'AL32UTF8') then
    DataEncoder.Encoding := ecUTF8
  else if (CharsetName = 'UTF16') then
    DataEncoder.Encoding := ecUTF16
  else
    DataEncoder.Encoding := ecANSI;
  // OCI8 does not support Unicode metadata
  if Lib.Version < cvOracle90000 then
    FMetaEncoder.Encoding := ecANSI
  else
    FMetaEncoder.Encoding := ecUTF16;
end;

{-------------------------------------------------------------------------------}
function TOCIEnv.CharSetIdToName(AId: ub2): String;

{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace1;
  begin
    Trace(sOCINlsCharSetIdToName, ['buf', Result, 'id', AId]);
  end;
{$ENDIF}

begin
  if Lib.Version >= cvOracle92000 then begin
    SetLength(Result, OCI_NLS_MAXBUFSZ);
    Check(FLib.OCINlsCharSetIdToName(Handle, PByte(PChar(Result)), OCI_NLS_MAXBUFSZ, AId));
    SetLength(Result, StrLen(PChar(Result)));
{$IFDEF FireDAC_MONITOR}
    if Tracing then ProcTrace1;
{$ENDIF}
  end
  else
    Result := '';
end;

{-------------------------------------------------------------------------------}
function TOCIEnv.CharSetNameToId(const AName: String): ub2;

{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace1;
  begin
    Trace(sOCINlsCharSetNameToId, ['name', AName, 'Result', Result]);
  end;
{$ENDIF}

begin
  if Lib.Version >= cvOracle92000 then begin
    Result := FLib.OCINlsCharSetNameToId(Handle, pOCIText(PChar(AName)));
{$IFDEF FireDAC_MONITOR}
    if Tracing then ProcTrace1;
{$ENDIF}
  end
  else
    Result := 0;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TOCIEnv.GetTracing: Boolean;
begin
  Result := (FMonitor <> nil) and FMonitor.Tracing and FTracing;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ EOCINativeException                                                           }
{-------------------------------------------------------------------------------}
constructor EOCINativeException.Create(AError: TOCIError);
var
  lvl: ub4;
  errCode: sb4;
  errBuf: TFDByteString;
  i1, i2: Integer;
  sMsg, sObj: String;
  eKind: TFDCommandExceptionKind;
begin
  inherited Create(er_FD_OraGeneral,
    FDExceptionLayers([S_FD_LPhys, S_FD_OraId]) + ' ');
  lvl := 1;
  while True do begin
    errCode := 0;
    SetLength(errBuf, 512);
    if AError.Env.Lib.OCIErrorGet(AError.FHandle, lvl, nil, errCode, PByte(errBuf),
                                  Length(errBuf), OCI_HTYPE_ERROR) = OCI_NO_DATA then
      Break;
    SetLength(errBuf, StrLen(PChar(PByte(errBuf))) * SizeOf(Char));
    sMsg := Trim(AError.Env.MetaEncoder.Decode(errBuf));
    i1 := Pos('#13', sMsg);
    i2 := Pos('#10', sMsg);
    if (i2 <> 0) and (i2 < i1) or (i1 = 0) then
      i1 := i2;
    if i1 = 0 then
      i1 := Length(sMsg) + 1;
    sObj := Copy(sMsg, 1, i1 - 1);
    i1 := Pos('(', sObj);
    i2 := Pos(')', sObj);
    sObj := Copy(sObj, i1 + 1, i2 - i1 - 1);
    case errCode of
      100,
     1403: eKind := ekNoDataFound;
     1422: eKind := ekTooManyRows;
       54: eKind := ekRecordLocked;
        1: eKind := ekUKViolated;
     2291,
     2292: eKind := ekFKViolated;
     4043,
     2289,
      942: eKind := ekObjNotExists;
     1005,
     1017: eKind := ekUserPwdInvalid;
    28001: eKind := ekUserPwdExpired;
    28002: eKind := ekUserPwdWillExpire;
    12525, // TNS operation timed out
    12608, // TNS send timeout
    12609, // TNS receive timeout
     1013: eKind := ekCmdAborted;
    12571, // TNS packet write failure
    12560, // TNS protocol adapter error
    12514, // TNS listener does not currently know of service
    12152, // Cannot sent break message
     3135, // connection lost contact
     3114, // not connected to Oracle
     3113, // end of communication chanel
     2396, // exceeded maximum idle time, please connect again
     1041, // hostdef extention does not exist
     1033, // initialization or shutdown is in progress
     1012, // not logged on
       28: // your session has been killed
           eKind := ekServerGone;
     1008,
     1036: eKind := ekInvalidParams;
    else
      if Pos('PLS-00306', sMsg) > 0 then
        eKind := ekInvalidParams
      else
        eKind := ekOther;
    end;
    AppendError(lvl, errCode, sMsg, sObj, eKind, -1, -1);
{$IFDEF FireDAC_MONITOR}
    if AError.Env.Tracing then AError.Trace(ekError, sMsg, ['Lvl', lvl, 'ErrCode', errCode]);
{$ENDIF}
    if lvl = 1 then
      Message := Message + sMsg;
    Inc(lvl);
  end;
end;

{-------------------------------------------------------------------------------}
{$IFDEF BCB}
constructor EOCINativeException.Create(AObj: TOCIHandle; AErrorCode: sb4;
  const AMessage: String; Dummy: Cardinal = 0);
{$ELSE}
constructor EOCINativeException.Create(AObj: TOCIHandle; AErrorCode: sb4;
  const AMessage: String);
{$ENDIF}
var
  sMsg: String;
  eKind: TFDCommandExceptionKind;
begin
  eKind := ekOther;
  case AErrorCode of
  OCI_SUCCESS_WITH_INFO: sMsg := 'OCI_SUCCESS_WITH_INFO';
  OCI_NEED_DATA:         sMsg := 'OCI_NEED_DATA';
  OCI_NO_DATA:           begin sMsg := 'OCI_NO_DATA'; eKind := ekNoDataFound; end;
  OCI_INVALID_HANDLE:    sMsg := 'OCI_INVALID_HANDLE';
  OCI_STILL_EXECUTING:   sMsg := 'OCI_STILL_EXECUTING';
  OCI_CONTINUE:          sMsg := 'OCI_CONTINUE';
  end;
  sMsg := sMsg + AMessage;
  inherited Create(er_FD_OraGeneral,
    FDExceptionLayers([S_FD_LPhys, S_FD_OraId, 'OCI']) + ' ' + sMsg);
  AppendError(1, AErrorCode, sMsg, '', eKind, -1, -1);
{$IFDEF FireDAC_MONITOR}
  if AObj.Env.Tracing then AObj.Trace(ekError, sMsg, ['Lvl', 1, 'ErrCode', AErrorCode]);
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
{ TOCIError                                                                     }
{-------------------------------------------------------------------------------}
constructor TOCIError.Create(AEnv: TOCIEnv);
begin
  inherited Create(AEnv);
  FOwner := AEnv;
  Init(OCI_HTYPE_ERROR);
end;

{-------------------------------------------------------------------------------}
constructor TOCIError.CreateUsingHandle(AEnv: TOCIEnv; AErrHandle: pOCIHandle);
begin
  inherited Create(AEnv);
  FOwner := AEnv;
  FType := OCI_HTYPE_ERROR;
  FHandle := AErrHandle;
  FOwnHandle := False;
end;

{-------------------------------------------------------------------------------}
destructor TOCIError.Destroy;
begin
  ClearInfo;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TOCIError.Check(ACode: sword; AInitiator: TObject = nil);
begin
  if FIgnoreErrors then
    Exit;
  case ACode of
  OCI_SUCCESS:
    ;
  OCI_NEED_DATA,
  OCI_INVALID_HANDLE,
  OCI_STILL_EXECUTING,
  OCI_CONTINUE:
    FDException(AInitiator, EOCINativeException.Create(Self, ACode, '')
       {$IFDEF FireDAC_Monitor}, Env.Tracing {$ENDIF});
  OCI_SUCCESS_WITH_INFO:
    begin
      ClearInfo;
      FInfo := EOCINativeException.Create(Self);
    end;
  OCI_NO_DATA,
  OCI_ERROR:
    FDException(AInitiator, EOCINativeException.Create(Self)
      {$IFDEF FireDAC_Monitor}, Env.Tracing {$ENDIF});
  else
    ;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIError.ClearInfo;
begin
  FDFreeAndNil(FInfo);
end;

{-------------------------------------------------------------------------------}
procedure TOCIError.CheckAllocateInfo;
begin
  if FInfo = nil then
    FInfo := EFDDBEngineException.Create(er_FD_OraGeneral,
      FDExceptionLayers([S_FD_LPhys, S_FD_OraId, 'OCI']));
end;

{-------------------------------------------------------------------------------}
{ TOCIService                                                                   }
{-------------------------------------------------------------------------------}
constructor TOCIService.Create(AEnv: TOCIEnv; AOwningObj: TObject);
begin
  inherited Create(AEnv);
  FOwner := AEnv;
  FOwningObj := AOwningObj;
  Init(OCI_HTYPE_SVCCTX);
  FNonBlockinMode := True;
  FBytesPerChar := 1;
end;

{-------------------------------------------------------------------------------}
constructor TOCIService.CreateUsingHandle(AEnv: TOCIEnv; AHandle: pOCISvcCtx;
  AOwningObj: TObject);
begin
  inherited Create(AEnv);
  FOwner := AEnv;
  FOwningObj := AOwningObj;
  FType := OCI_HTYPE_SVCCTX;
  FHandle := AHandle;
  FNonBlockinMode := False;
  FOwnHandle := False;
  FBytesPerChar := 1;
end;

{-------------------------------------------------------------------------------}
procedure TOCIService.Break(ADoException: Boolean);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIBreak, []);
  end;
{$ENDIF}
var
  errCode: sb4;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  errCode := Env.Lib.OCIBreak(FHandle, Env.Error.FHandle);
  if (errCode <> OCI_SUCCESS) and ADoException then
    Check(errCode);
end;

{-------------------------------------------------------------------------------}
procedure TOCIService.Reset(ADoException: Boolean);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIReset, []);
  end;
{$ENDIF}
var
  errCode: sb4;
begin
  if Env.Lib.Version >= cvOracle81000 then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then ProcTrace;
{$ENDIF}
    errCode := Env.Lib.OCIReset(FHandle, Env.Error.FHandle);
    if (errCode <> OCI_SUCCESS) and ADoException then
      Check(errCode);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIService.DoYield;
begin
  if Assigned(FOnYield) then
    FOnYield(Self);
end;

{-------------------------------------------------------------------------------}
procedure TOCIService.TurnNONBLOCKING_MODE;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrSet, ['AType', 'OCI_ATTR_NONBLOCKING_MODE']);
  end;
{$ENDIF}
begin
  if Env.Lib.Version >= cvOracle80500 then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then ProcTrace;
{$ENDIF}
    Check(Env.Lib.OCIAttrSet(FHandle, FType, nil, 0, OCI_ATTR_NONBLOCKING_MODE,
      Env.Error.FHandle));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIService.SetNonblockingMode(const Value: Boolean);
begin
  if FNonBlockinMode <> Value then begin
    FNonBlockinMode := Value;
    TurnNONBLOCKING_MODE;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIService.UpdateNonBlockingMode;
begin
  if FNonBlockinMode then begin
    TurnNONBLOCKING_MODE;
    TurnNONBLOCKING_MODE;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIService.Ping;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace1;
  begin
    Trace(sOCIPing, []);
  end;
  procedure ProcTrace2;
  begin
    Trace(sOCIServerVersion, []);
  end;
{$ENDIF}
var
  buff: array[0 .. OCI_MAX_ATTR_LEN-1] of char;
begin
  if Assigned(Env.Lib.OCIPing) then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then ProcTrace1;
{$ENDIF}
    Check(Env.Lib.OCIPing(FHandle, Env.Error.FHandle, OCI_DEFAULT));
  end
  else begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then ProcTrace2;
{$ENDIF}
    Check(Env.Lib.OCIServerVersion(SERVER, Env.Error.FHandle, @buff,
      OCI_MAX_ATTR_LEN, OCI_HTYPE_SERVER));
  end;
end;

{-------------------------------------------------------------------------------}
{ TOCIServer                                                                    }
{-------------------------------------------------------------------------------}
constructor TOCIServer.Create(AService: TOCIService);
begin
  inherited Create(AService.Env);
  FOwner := AService;
  FOwningObj := AService.OwningObj;
  Init(OCI_HTYPE_SERVER);
end;

{-------------------------------------------------------------------------------}
constructor TOCIServer.CreateUsingHandle(AService: TOCIService; AHandle: pOCIServer);
begin
  inherited Create(AService.Env);
  FOwner := AService;
  FOwningObj := AService.OwningObj;
  FType := OCI_HTYPE_SERVER;
  FHandle := AHandle;
  FOwnHandle := False;
end;

{-------------------------------------------------------------------------------}
destructor TOCIServer.Destroy;
begin
  try
    Detach;
  except
  end;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TOCIServer.Attach(const AServerName: String);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIServerAttach, ['SrvName', AServerName]);
  end;
{$ENDIF}
var
  sb: TFDByteString;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  sb := Env.MetaEncoder.Encode(AServerName);
  Check(Env.Lib.OCIServerAttach(FHandle, Env.Error.FHandle, PByte(sb),
    Env.MetaEncoder.EncodedLength(sb), OCI_DEFAULT));
  FAttached := True;
  Select;
end;

{-------------------------------------------------------------------------------}
procedure TOCIServer.Detach;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIServerDetach, []);
  end;
{$ENDIF}
begin
  if (FHandle <> nil) and FAttached then begin
    FAttached := False;
    FServerVersion := '';
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then ProcTrace;
{$ENDIF}
    Check(Env.Lib.OCIServerDetach(FHandle, Env.Error.FHandle, OCI_DEFAULT));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIServer.Select;
begin
  TOCIService(FOwner).SERVER := FHandle;
end;

{-------------------------------------------------------------------------------}
function TOCIServer.GetServerVersion: String;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIServerVersion, []);
  end;
{$ENDIF}
var
  sbVer: TFDByteString;
begin
  if FServerVersion = '' then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then ProcTrace;
{$ENDIF}
    SetLength(sbVer, OCI_MAX_ATTR_LEN);
    Env.Lib.OCIServerVersion(FHandle, Env.Error.FHandle, PByte(sbVer),
      OCI_MAX_ATTR_LEN, OCI_HTYPE_SERVER);
    SetLength(sbVer, StrLen(PChar(PByte(sbVer))) * SizeOf(Char));
    FServerVersion := Env.MetaEncoder.Decode(sbVer);
  end;
  Result := FServerVersion;
end;

{-------------------------------------------------------------------------------}
{ TOCISession                                                                   }
{-------------------------------------------------------------------------------}
constructor TOCISession.Create(AService: TOCIService);
begin
  inherited Create(AService.Env);
  FOwner := AService;
  FOwningObj := AService.OwningObj;
  Init(OCI_HTYPE_SESSION);
end;

{-------------------------------------------------------------------------------}
constructor TOCISession.CreateUsingHandle(AService: TOCIService; AHandle: pOCISession);
begin
  inherited Create(AService.Env);
  FOwner := AService;
  FOwningObj := AService.OwningObj;
  FType := OCI_HTYPE_SESSION;
  FHandle := AHandle;
  FOwnHandle := False;
end;

{-------------------------------------------------------------------------------}
destructor TOCISession.Destroy;
begin
  try
    Stop;
  except
  end;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TOCISession.Start(const AUser, APassword: String; AAuthentMode: ub4);
var
  credt: ub4;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCISessionBegin, ['User', AUser, 'Mode', AAuthentMode]);
  end;
{$ENDIF}
begin
  if (AUser = '') and (APassword = '') then
    credt := OCI_CRED_EXT
  else begin
    USERNAME := AUser;
    PASSWORD := APassword;
    credt := OCI_CRED_RDBMS;
  end;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCISessionBegin(FOwner.FHandle, Env.Error.FHandle, FHandle,
    credt, AAuthentMode));
  FStarted := True;
  Select;
end;

{-------------------------------------------------------------------------------}
procedure TOCISession.ChangePassword(const AUser, AOldPassword, ANewPassword: String);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIPasswordChange, ['User', AUser]);
  end;
{$ENDIF}
var
  sbUser, sbOldPwd, sbNewPwd: TFDByteString;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  sbUser := Env.MetaEncoder.Encode(AUser);
  sbOldPwd := Env.MetaEncoder.Encode(AOldPassword);
  sbNewPwd := Env.MetaEncoder.Encode(ANewPassword);
  Check(Env.Lib.OCIPasswordChange(FOwner.FHandle, Env.Error.FHandle,
    PByte(sbUser), Env.MetaEncoder.EncodedLength(sbUser),
    PByte(sbOldPwd), Env.MetaEncoder.EncodedLength(sbOldPwd),
    PByte(sbNewPwd), Env.MetaEncoder.EncodedLength(sbNewPwd), OCI_DEFAULT));
  FStarted := True;
end;

{-------------------------------------------------------------------------------}
procedure TOCISession.Stop;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCISessionEnd, []);
  end;
{$ENDIF}
begin
  if (FHandle <> nil) and FStarted then begin
    FStarted := False;
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then ProcTrace;
{$ENDIF}
    Check(Env.Lib.OCISessionEnd(FOwner.FHandle, Env.Error.FHandle,
      FHandle, OCI_DEFAULT));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCISession.Select;
begin
  TOCIService(FOwner).SESSION := FHandle;
end;

{-------------------------------------------------------------------------------}
{ TOCIXid                                                                       }
{-------------------------------------------------------------------------------}
constructor TOCIXid.Create(AEnv: TOCIEnv);
begin
  inherited Create;
  FEnv := AEnv;
  Clear;
end;

{-------------------------------------------------------------------------------}
procedure TOCIXid.Assign(AValue: TPersistent);
begin
  if AValue is TOCIXid then begin
    GTRID := TOCIXid(AValue).GTRID;
    BQUAL := TOCIXid(AValue).BQUAL;
    Name := TOCIXid(AValue).Name;
  end
  else
    inherited Assign(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TOCIXid.Clear;
begin
  if IsNull then
    Exit;
  if Assigned(FOnChanging) then
    FOnChanging(Self);
  FXID.formatID := NULLXID_ID;
  FXID.gtrid_length := 0;
  FXID.bqual_length := 0;
  FillChar(FXID.data, XIDDATASIZE, 0);
  FName := '';
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

{-------------------------------------------------------------------------------}
procedure TOCIXid.SetParts(const AGTRID, ABQUAL: String);
var
  s: TFDByteString;
begin
  if Length(AGTRID) > MAXGTRIDSIZE then
    FDException(nil, [S_FD_LPhys, S_FD_OraId], er_FD_OraTooLongGTRID,
      [MAXGTRIDSIZE, Length(AGTRID)]);
  if Length(ABQUAL) > MAXBQUALSIZE then
    FDException(nil, [S_FD_LPhys, S_FD_OraId], er_FD_OraTooLongBQUAL,
      [MAXBQUALSIZE, Length(ABQUAL)]);
  if Assigned(FOnChanging) then
    FOnChanging(Self);
  FXID.gtrid_length := Length(AGTRID);
  FXID.bqual_length := Length(ABQUAL);
  if (FXID.gtrid_length > 0) and (FXID.bqual_length > 0) then
    FXID.formatID := 123456;  // default XID format
  s := FEnv.DataEncoder.Encode(AGTRID, ecANSI);
  Move(PByte(s)^, FXID.data, FXID.gtrid_length * SizeOf(TFDAnsiChar));
  s := FEnv.DataEncoder.Encode(ABQUAL, ecANSI);
  Move(PByte(s)^, PByte(NativeUInt(@FXID.data) + NativeUInt(FXID.gtrid_length))^,
    FXID.bqual_length * SizeOf(TFDAnsiChar));
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

{-------------------------------------------------------------------------------}
function TOCIXid.GetGTRID: String;
begin
  Result := FEnv.DataEncoder.Decode(@FXID.data, FXID.gtrid_length, ecANSI);
end;

{-------------------------------------------------------------------------------}
procedure TOCIXid.SetGTRID(const AValue: String);
begin
  if GTRID <> AValue then
    SetParts(AValue, BQUAL);
end;

{-------------------------------------------------------------------------------}
function TOCIXid.GetBQUAL: String;
begin
  Result := FEnv.DataEncoder.Decode(
    PByte(NativeUInt(@FXID.data) + NativeUInt(FXID.gtrid_length)),
    FXID.bqual_length, ecANSI);
end;

{-------------------------------------------------------------------------------}
procedure TOCIXid.SetBQUAL(const AValue: String);
begin
  if BQUAL <> AValue then
    SetParts(GTRID, AValue);
end;

{-------------------------------------------------------------------------------}
function TOCIXid.GetIsNull: Boolean;
begin
  Result := (FXID.formatID = NULLXID_ID);
end;

{-------------------------------------------------------------------------------}
procedure TOCIXid.SetName(const AValue: String);
begin
  if FName <> AValue then begin
    if Length(AValue) > MAXTXNAMELEN then
      FDException(nil, [S_FD_LPhys, S_FD_OraId], er_FD_OraTooLongTXName,
        [MAXTXNAMELEN, Length(AValue)]);
    if Assigned(FOnChanging) then
      FOnChanging(Self);
    FName := AValue;
    if Assigned(FOnChanged) then
      FOnChanged(Self);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIXid.MarkTransaction(ATrans: TOCITransaction);
begin
  if FXID.formatID <> NULLXID_ID then begin
    ATrans.SetXID(FXID);
    if Name <> '' then
      ATrans.TRANS_NAME := Name;
  end;
end;

{-------------------------------------------------------------------------------}
{ TOCITransaction                                                               }
{-------------------------------------------------------------------------------}
const
  ad2OCItm: array[TOCITransactionMode] of ub4 = (OCI_DEFAULT, OCI_TRANS_READWRITE,
    OCI_TRANS_SERIALIZABLE, OCI_TRANS_READONLY);
  ad2OCItn: array[Boolean] of ub4 = (OCI_TRANS_RESUME, OCI_TRANS_NEW);
  ad2OCIcm: array[TOCICoupleMode] of ub4 = (OCI_DEFAULT, OCI_TRANS_LOOSE, OCI_TRANS_TIGHT);

constructor TOCITransaction.Create(AService: TOCIService);
begin
  inherited Create(AService.Env);
  FOwner := AService;
  FOwningObj := AService.OwningObj;
  Init(OCI_HTYPE_TRANS);
end;

{-------------------------------------------------------------------------------}
constructor TOCITransaction.CreateUsingHandle(AService: TOCIService;
  AHandle: pOCITrans);
begin
  inherited Create(AService.Env);
  FOwner := AService;
  FOwningObj := AService.OwningObj;
  FType := OCI_HTYPE_TRANS;
  FHandle := AHandle;
  FOwnHandle := False;
end;

{-------------------------------------------------------------------------------}
procedure TOCITransaction.StartLocal(AMode: TOCITransactionMode);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCITransStart, ['@Kind', 'local', 'Mode', ad2OCItm[AMode]]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCITransStart(FOwner.FHandle, Env.Error.FHandle, 0, ad2OCItm[AMode]));
end;

{-------------------------------------------------------------------------------}
procedure TOCITransaction.StartGlobal(AMode: TOCITransactionMode; ATimeOut: uword;
  ANew: Boolean; ACoupleMode: TOCICoupleMode);
var
  mode: ub4;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCITransStart, ['@Kind', 'global', 'Mode', mode]);
  end;
{$ENDIF}
begin
  mode := ad2OCItn[ANew] or ad2OCIcm[ACoupleMode] or ad2OCItm[AMode];
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCITransStart(FOwner.FHandle, Env.Error.FHandle, ATimeOut, mode));
end;

{-------------------------------------------------------------------------------}
procedure TOCITransaction.Detach;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCITransDetach, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCITransDetach(FOwner.FHandle, Env.Error.FHandle, OCI_DEFAULT));
end;

{-------------------------------------------------------------------------------}
procedure TOCITransaction.Commit;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCITransCommit, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCITransCommit(FOwner.FHandle, Env.Error.FHandle, OCI_DEFAULT));
end;

{-------------------------------------------------------------------------------}
procedure TOCITransaction.Commit2PC;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCITransCommit, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCITransCommit(FOwner.FHandle, Env.Error.FHandle, OCI_TRANS_TWOPHASE));
end;

{-------------------------------------------------------------------------------}
procedure TOCITransaction.RollBack;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCITransRollback, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCITransRollback(FOwner.FHandle, Env.Error.FHandle, OCI_DEFAULT));
end;

{-------------------------------------------------------------------------------}
procedure TOCITransaction.Prepare2PC;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCITransPrepare, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCITransPrepare(FOwner.FHandle, Env.Error.FHandle, OCI_DEFAULT));
end;

{-------------------------------------------------------------------------------}
procedure TOCITransaction.Forget;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCITransForget, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCITransForget(FOwner.FHandle, Env.Error.FHandle, OCI_DEFAULT));
end;

{-------------------------------------------------------------------------------}
procedure TOCITransaction.SetXID(var AValue: TXID);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrSet, ['@VType', 'XID', 'AType', 'OCI_ATTR_XID']);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIAttrSet(FHandle, FType, @AValue, SizeOf(TXID), OCI_ATTR_XID,
    Env.Error.FHandle));
end;

{-------------------------------------------------------------------------------}
procedure TOCITransaction.GetXID(var AValue: TXID);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrGet, ['@VType', 'XID', 'AType', 'OCI_ATTR_XID']);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIAttrGet(FHandle, FType, @AValue, nil, OCI_ATTR_XID,
    Env.Error.FHandle));
end;

{-------------------------------------------------------------------------------}
procedure TOCITransaction.Select;
begin
  // 9.2 client raises AV on second call of TOCIService(FOwner).TRANS
  // if TOCIService(FOwner).TRANS <> FHandle then
  TOCIService(FOwner).TRANS := FHandle;
end;

{-------------------------------------------------------------------------------}
{ TOCIStatement                                                                 }
{-------------------------------------------------------------------------------}
constructor TOCIStatement.Create(AEnv: TOCIEnv; AService: TOCIService;
  ATrans: TOCITransaction; AOwningObj: TObject);
begin
  inherited Create(AEnv);
  FOwner := AEnv;
  FOwningObj := AOwningObj;
  Init(OCI_HTYPE_STMT);
  FPieceBuffLen := C_FD_DefPieceBuffLen;
  FPieceOutVars := TFDObjList.Create;
  FVars := TFDObjList.Create;
  FService := AService;
  FTrans := ATrans;
end;

{-------------------------------------------------------------------------------}
constructor TOCIStatement.CreateUsingHandle(AEnv: TOCIEnv; AService: TOCIService;
  ATrans: TOCITransaction; AHandle: pOCIHandle; AOwningObj: TObject);
begin
  inherited Create(AEnv);
  FOwner := AEnv;
  FOwningObj := AOwningObj;
  FType := OCI_HTYPE_STMT;
  FPieceBuffLen := C_FD_DefPieceBuffLen;
  FPieceOutVars := TFDObjList.Create;
  FVars := TFDObjList.Create;
  FService := AService;
  FTrans := ATrans;
  AttachToHandle(AHandle);
end;

{-------------------------------------------------------------------------------}
procedure TOCIStatement.AttachToHandle(AHandle: pOCIHandle);
begin
  FHandle := AHandle;
  FRef := True;
  FCanceled := False;
  FEof := False;
  FLastRowCount := ROW_COUNT;
end;

{-------------------------------------------------------------------------------}
destructor TOCIStatement.Destroy;
begin
  FDFreeAndNil(FPieceOutVars);
  FDFreeAndNil(FVars);
  Env.Buffer.Release;
  FreePieceBuff;
  if FRef then
    FHandle := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
// Piece wise operation support

procedure TOCIStatement.AllocPieceBuff;
begin
  if FPieceBuff = nil then
    GetMem(FPieceBuff, FPieceBuffLen);
end;

{-------------------------------------------------------------------------------}
procedure TOCIStatement.FreePieceBuff;
begin
  if FPieceBuff <> nil then begin
    FreeMem(FPieceBuff, FPieceBuffLen);
    FPieceBuff := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIStatement.SetPieceBuffLen(AValue: ub4);
begin
  if FPieceBuffLen <> AValue then begin
    FreePieceBuff;
    FPieceBuffLen := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
function TOCIStatement.Hndl2PieceVar(varHndl: pOCIHandle): TOCIVariable;
var
  i: Integer;
begin
  i := 0;
  while (i < FPieceOutVars.Count) and
        (TOCIVariable(FPieceOutVars[i]).FHandle <> varHndl) do
    Inc(i);
  ASSERT(i < FPieceOutVars.Count);
  Result := TOCIVariable(FPieceOutVars[i]);
  ASSERT(Result.LongData);
end;

{-------------------------------------------------------------------------------}
procedure TOCIStatement.AddPieceVar(AVar: TOCIVariable);
begin
  if FPieceOutVars.IndexOf(AVar) = -1 then
    FPieceOutVars.Add(AVar);
end;

{-------------------------------------------------------------------------------}
procedure TOCIStatement.RemovePieceVar(AVar: TOCIVariable);
begin
  FPieceOutVars.Remove(AVar);
end;

{-------------------------------------------------------------------------------}
function TOCIStatement.GetPiecedExchange: Boolean;
begin
  Result := FPieceOutVars.Count > 0;
end;

{-------------------------------------------------------------------------------}
procedure TOCIStatement.InitPiecedExchange(out pld: TPieceLoopData);
begin
  if PiecedExchange then
    FillChar(pld, SizeOf(TPieceLoopData), 0);
end;

{-------------------------------------------------------------------------------}
procedure TOCIStatement.DoPiecedExchange(var AData: TPieceLoopData; ARes: sb4);
var
  varHndl: pOCIHandle;
  iVarType: ub4;
  idx: ub4;
  varIter: ub4;
  pLastInd: Pointer;
  pLastRCode: pUb2;
  uiSize: ub4;

{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace1;
  begin
    Trace(sOCIStmtGetPieceInfo, []);
  end;
  procedure ProcTrace2;
  begin
    Trace(sOCIStmtSetPieceInfo, ['Name', AData.FVar.DumpLabel,
      'alenp', AData.FPieceSize, 'piece', AData.FPiece,
      'indp', pSb2(pLastInd)^]);
  end;
  procedure ProcTrace3;
  begin
    Trace(sOCIStmtSetPieceInfo, ['Name', AData.FVar.DumpLabel,
      'alenp', AData.FPieceSize, 'piece', OCI_LAST_PIECE,
      'indp', pSb2(pLastInd)^]);
  end;
{$ENDIF}

begin
  if (AData.FVar <> nil) and (AData.FInOut <> OCI_PARAM_IN) then begin
    case AData.FPiece of
    OCI_ONE_PIECE,
    OCI_FIRST_PIECE:
      if (AData.FInd = -1) and (AData.FPieceSize = 0) then
        AData.FVar.SetData(AData.FIter, nil, 0)
      else begin
        uiSize := AData.FPieceSize;
        if AData.FVar.DataType in [otNString, otNChar, otNLong, otNCLOB] then
          uiSize := uiSize div SizeOf(WideChar);
        AData.FVar.SetData(AData.FIter, FPieceBuff, uiSize);
      end;
    OCI_NEXT_PIECE,
    OCI_LAST_PIECE:
      AData.FVar.AppendData(AData.FIter, FPieceBuff, AData.FPieceSize);
    end;
  end;
  if ARes = OCI_NEED_DATA then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then ProcTrace1;
{$ENDIF}
    varHndl := nil;
    iVarType := 0;
    AData.FInOut := 0;
    varIter := 0;
    idx := 0;
    AData.FPiece := 0;
    Check(Env.Lib.OCIStmtGetPieceInfo(FHandle, Env.Error.FHandle, varHndl,
      iVarType, AData.FInOut, varIter, idx, AData.FPiece));
    if varHndl <> AData.FVarHndl then begin
      AData.FVar := Hndl2PieceVar(varHndl);
      AData.FVarHndl := varHndl;
      AData.FRCode := OCI_SUCCESS;
      AData.FInd := -1;
    end;
    if varIter <> AData.FIter then begin
      AData.FRCode := OCI_SUCCESS;
      AData.FIter := varIter;
    end;
    pLastInd := @AData.FInd;
    pLastRCode := @AData.FRCode;
    if Env.Lib.Version >= cvOracle81600 then begin
      pLastInd := Pointer(NativeUInt(pLastInd) - AData.FIter * SizeOf(sb2));
      pLastRCode := pUb2(NativeUInt(pLastRCode) - AData.FIter * SizeOf(ub2));
    end;
    if AData.FInOut = OCI_PARAM_OUT then begin
      AllocPieceBuff;
      AData.FPieceSize := FPieceBuffLen;
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then ProcTrace2;
{$ENDIF}
      Check(Env.Lib.OCIStmtSetPieceInfo(AData.FVar.FHandle, iVarType,
        Env.Error.FHandle, FPieceBuff, AData.FPieceSize, AData.FPiece,
        pLastInd, pLastRCode^));
    end
    else begin
      if AData.FVar.GetRawData(AData.FIter, AData.FBuff,
                                        AData.FPieceSize) then
        AData.FInd := 1
      else
        AData.FInd := -1;
      if AData.FVar.DataType in [otNString, otNChar, otNLong, otNCLOB] then
        AData.FPieceSize := AData.FPieceSize * SizeOf(WideChar);
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then ProcTrace3;
{$ENDIF}
      Check(Env.Lib.OCIStmtSetPieceInfo(AData.FVar.FHandle, iVarType,
        Env.Error.FHandle, AData.FBuff, AData.FPieceSize,
        OCI_LAST_PIECE, pLastInd, pLastRCode^));
    end;
  end
  else
    AData.FVar := nil;
end;

{-------------------------------------------------------------------------------}
{
var
  tmpLen: ub4;
  tmpInd: sb4;

function TOCIStatement.CallbackDefine(Define: pOCIDefine; Iter: cardinal; var Buf: pointer;
  var BufLen: pUb4; var PieceStatus: ub1; var Ind: pointer): sb4;
var
  oVar: TOCIVariable;
begin
  oVar := Hndl2PieceVar(Define);
  AllocPieceBuff;
  Buf := FPieceBuff;
  BufLen := @tmpLen;
  Ind := @tmpInd;
  PieceStatus := OCI_NEXT_PIECE;
  Result := OCI_CONTINUE;
end;

function OCICallbackDefine(octxp: pointer; defnp: pOCIDefine; iter: ub4; var bufpp: pointer;
   var alenpp: pUb4; var piecep: ub1; var indpp: pointer; var rcodep: pUb2): sb4; cdecl;
begin
  Result := TOCIStatement(octxp).CallbackDefine(defnp, iter, bufpp,
    alenpp, piecep, indpp);
  rcodep := nil;
end;
}

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
procedure TOCIStatement.DumpColumns(ARows: ub4; AEof: Boolean);
var
  i, j, n: Integer;
  ok: Boolean;
  oVar: TOCIVariable;
begin
  if Env.Tracing then begin
    ok := False;
    for i := 0 to FVars.Count - 1 do begin
      oVar := TOCIVariable(FVars[i]);
      if oVar.VarType = odDefine then begin
        ok := True;
        Break;
      end;
    end;
    if ok and (ARows > 0) then begin
      for j := 0 to ARows - 1 do begin
        n := 1;
        Trace(ekCmdDataOut, esStart, 'Fetched', ['Row', j]);
        for i := 0 to FVars.Count - 1 do begin
          oVar := TOCIVariable(FVars[i]);
          if oVar.VarType = odDefine then begin
            Trace(ekCmdDataOut, 'Column',
              [String('N'), n, '@Name', oVar.DumpLabel, '@Type', dataTypeName[oVar.DataType],
               'Size', oVar.DataSize, '@Data', oVar.DumpValue(j)]);
            Inc(n);
          end;
        end;
        Trace(ekCmdDataOut, esEnd, 'Fetched', ['Row', j]);
      end;
      if AEof then
        Trace(ekCmdDataOut, 'EOF', []);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIStatement.DumpParameters(ARows, AOffset: sb4; ATypes: TOCIVarTypes);
var
  i, j, n: Integer;
  iFrom, iTo: sb4;
  oVar: TOCIVariable;
begin
  if Env.Tracing then begin
    n := 1;
    for i := 0 to FVars.Count - 1 do begin
      oVar := TOCIVariable(FVars[i]);
      if oVar.VarType in ATypes then begin
        if n = 1 then
          Trace(ekCmdDataIn, esStart, 'Binds', []);
        if oVar.IsPLSQLTable then begin
          iFrom := 0;
          iTo := oVar.ArrayLen - 1;
        end
        else begin
          iFrom := AOffset;
          iTo := ARows - 1;
          if iTo > sb4(oVar.ArrayLen - 1) then
            iTo := sb4(oVar.ArrayLen - 1);
        end;
        Trace(ekCmdDataIn, 'Param',
          [String('N'), n, '@Name', oVar.DumpLabel, '@Mode', varTypeName[oVar.VarType],
           '@Type', dataTypeName[oVar.DataType], 'Size', oVar.DataSize,
           '@Data(' + InttoStr(iFrom) + ')', oVar.DumpValue(iFrom)]);
        for j := iFrom + 1 to iTo do
          Trace(ekCmdDataIn, '  ... Data', ['Row', j, '@V', oVar.DumpValue(j)]);
        Inc(n);
      end;
    end;
    if n > 1 then
      Trace(ekCmdDataIn, esEnd, 'Binds', []);
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
// Main operations

procedure TOCIStatement.AddVar(AVar: TOCIVariable);
begin
  if FVars.IndexOf(AVar) = -1 then
    FVars.Add(AVar);
end;

{-------------------------------------------------------------------------------}
procedure TOCIStatement.RemoveVar(AVar: TOCIVariable);
begin
  FVars.Remove(AVar);
end;

{-------------------------------------------------------------------------------}
function TOCIStatement.AddVarBase(const AName: String; APosition: ub4;
  AVarType: TOCIVarType; ADataType: TOCIVarDataType; ASize: ub4): TOCIVariable;
begin
  Result := TOCIVariable.Create(Self);
  try
    if AName <> '' then
      Result.Name := AName
    else if APosition <> $FFFFFFFF then
      Result.Position := APosition;
    Result.VarType := AVarType;
    Result.DataType := ADataType;
    if ASize > 0 then begin
      if ADataType in [otString, otChar, otLong] then
        ASize := ASize * SizeOf(TFDAnsiChar)
      else if ADataType in [otNString, otNChar, otNLong] then
        ASize := ASize * SizeOf(WideChar);
      Result.DataSize := ASize;
    end;
    Result.Bind;
  except
    FDFree(Result);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
function TOCIStatement.AddVar(const AName: String; AVarType: TOCIVarType;
  ADataType: TOCIVarDataType; ASize: ub4): TOCIVariable;
begin
  Result := AddVarBase(AName, $FFFFFFFF, AVarType, ADataType, ASize);
end;

{-------------------------------------------------------------------------------}
function TOCIStatement.AddVar(APosition: ub4; AVarType: TOCIVarType;
  ADataType: TOCIVarDataType; ASize: ub4): TOCIVariable;
begin
  Result := AddVarBase('', APosition, AVarType, ADataType, ASize);
end;

{-------------------------------------------------------------------------------}
procedure TOCIStatement.Prepare(const AStatement: String);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIStmtPrepare, ['Stmt', AStatement]);
  end;
{$ENDIF}
var
  sb: TFDByteString;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  sb := Env.MetaEncoder.Encode(AStatement);
  Check(Env.Lib.OCIStmtPrepare(FHandle, Env.Error.FHandle, PByte(sb),
    Env.MetaEncoder.EncodedLength(sb), OCI_NTV_SYNTAX, OCI_DEFAULT));
  FSTMT_TYPE := GetUB2Attr(OCI_ATTR_STMT_TYPE);
end;

{-------------------------------------------------------------------------------}
procedure TOCIStatement.Describe;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIStmtExecute, ['@mode', 'OCI_DESCRIBE_ONLY']);
  end;
{$ENDIF}
var
  res: sb4;
begin
  FService.UpdateNonBlockingMode;
  try
    repeat
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then ProcTrace;
{$ENDIF}
      res := Env.Lib.OCIStmtExecute(FService.FHandle, FHandle, Env.Error.FHandle,
        0, 0, nil, nil, OCI_DESCRIBE_ONLY);
      case res of
        OCI_STILL_EXECUTING:
          FService.DoYield;
        OCI_NO_DATA, OCI_NEED_DATA, OCI_SUCCESS:
          ;
        else
          Check(res);
      end;
    until (res <> OCI_NEED_DATA) and (res <> OCI_STILL_EXECUTING);
  except
    on E: EOCINativeException do begin
      if (Env.Lib.Version >= cvOracle81000) and (E.ErrorCount > 0) then
        E.Errors[0].CommandTextOffset := PARSE_ERROR_OFFSET;
      raise;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIStatement.Execute(ARows, AOffset: sb4; AExact, ACommit: Boolean);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace1;
  begin
    Trace(sOCIStmtExecute, ['ARows', ARows, 'AOffset', AOffset,
      'AExact', AExact, 'ACommit', ACommit]);
  end;
  procedure ProcTrace2;
  begin
    Trace(sOCIStmtFetch, ['ARows', ARows]);
  end;
{$ENDIF}
var
  mode: ub4;
  res: sb4;
  pieceLoopData: TPieceLoopData;
begin
  mode := OCI_DEFAULT;
  if AExact then
    mode := mode or OCI_EXACT_FETCH;
  if ACommit then
    mode := mode or OCI_COMMIT_ON_SUCCESS;
  FService.UpdateNonBlockingMode;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing and not FRef then DumpParameters(ARows, AOffset, [odIn, odInOut]);
{$ENDIF}
  FLastRowCount := 0;
  FCanceled := False;
  InitPiecedExchange(pieceLoopData);
  Env.Error.ClearInfo;
  try
    try
      repeat
        if not FRef then begin
{$IFDEF FireDAC_MONITOR}
          if Env.Tracing then ProcTrace1;
{$ENDIF}
          res := Env.Lib.OCIStmtExecute(FService.FHandle, FHandle,
            Env.Error.FHandle, ARows, AOffset, nil, nil, mode);
        end
        else begin
{$IFDEF FireDAC_MONITOR}
          if Env.Tracing then ProcTrace2;
{$ENDIF}
          res := Env.Lib.OCIStmtFetch(FHandle, Env.Error.FHandle, ARows,
            OCI_FETCH_NEXT, OCI_DEFAULT);
        end;
        case res of
          OCI_STILL_EXECUTING:
            FService.DoYield;
          OCI_NO_DATA:
            begin
              // OCI_NO_DATA is returned for:
              // 1) SELECT returning no rows
              // 2) EOF on REF CURSOR
              // 3) PL/SQL block with "raise NO_DATA_FOUND"
              // 4) other commands calling (3)
              // 5) OCI_EXACT_FETCH and rows < ARows
              // The exception must be raised only for (3), (4) and (5)
              if not (((STMT_TYPE = OCI_STMT_SELECT) or FRef) and not AExact) then
                Check(res);
              if PiecedExchange then
                DoPiecedExchange(pieceLoopData, res);
            end;
          OCI_NEED_DATA, OCI_SUCCESS:
            if PiecedExchange then
              DoPiecedExchange(pieceLoopData, res);
          OCI_SUCCESS_WITH_INFO:
            begin
              if PiecedExchange then
                DoPiecedExchange(pieceLoopData, res);
              Check(res);
            end;
          else
            Check(res);
        end;
      until (res <> OCI_NEED_DATA) and (res <> OCI_STILL_EXECUTING);
    finally
      FLastRowCount := ROW_COUNT;
    end;
  except
    on E: EOCINativeException do begin
      if E.ErrorCount > 0 then begin
        if Env.Lib.Version >= cvOracle81000 then
          E.Errors[0].CommandTextOffset := PARSE_ERROR_OFFSET;
        if sb4(FLastRowCount) <> ARows - AOffset then
          E.Errors[0].RowIndex := AOffset + sb4(FLastRowCount);
      end;
      if PiecedExchange then begin
        FService.Break(False);
        FService.Reset(False);
      end;
      if (E.Kind <> ekServerGone) and
         ACommit and (FTrans <> nil) and (FLastRowCount = 0) then
        FTrans.RollBack;
      raise;
    end;
  end;
  FEof := (ARows > 0) and
    ((FLastRowCount <> ub4(ARows)) or AExact and (FLastRowCount = ub4(ARows))) and
    ((STMT_TYPE = OCI_STMT_SELECT) or FRef);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then begin
    if not FRef then DumpParameters(ARows, AOffset, [odOut, odInOut, odRet]);
    DumpColumns(FLastRowCount, FEof);
  end;
{$ENDIF}
  if FEof then
    FCanceled := True;
end;

{-------------------------------------------------------------------------------}
function TOCIStatement.NextResultSet: pOCIHandle;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace1;
  begin
    Trace(sOCIStmtGetNextResult, []);
  end;
{$ENDIF}
var
  pRes: Pointer;
  iRType: ub4;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace1;
{$ENDIF}
  if (Env.Lib.OCIStmtGetNextResult(FHandle, Env.Error.FHandle, pRes, iRType, OCI_DEFAULT) = OCI_SUCCESS) and
     (iRType = OCI_RESULT_TYPE_SELECT) then
    Result := pOCIHandle(pRes)
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
procedure TOCIStatement.Fetch(ANRows: ub4);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIStmtFetch, ['ARows', ANRows]);
  end;
{$ENDIF}
var
  res: sb4;
  prevRowCount: ub4;
  pieceLoopData: TPieceLoopData;
begin
  if FCanceled then begin
    FLastRowCount := 0;
    FEof := True;
    Exit;
  end;
  prevRowCount := ROW_COUNT;
  InitPiecedExchange(pieceLoopData);
  Env.Error.ClearInfo;
  try
    repeat
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then ProcTrace;
{$ENDIF}
      res := Env.Lib.OCIStmtFetch(FHandle, Env.Error.FHandle, ANRows,
        OCI_FETCH_NEXT, OCI_DEFAULT);
      case res of
        OCI_STILL_EXECUTING:
          FService.DoYield;
        OCI_NO_DATA, OCI_NEED_DATA, OCI_SUCCESS:
          if PiecedExchange then
            DoPiecedExchange(pieceLoopData, res);
        else
          Check(res);
      end;
    until (res <> OCI_NEED_DATA) and (res <> OCI_STILL_EXECUTING);
  except
    if PiecedExchange then begin
      FService.Break(False);
      FService.Reset(False);
    end;
    raise;
  end;
  FLastRowCount := ROW_COUNT - prevRowCount;
  FEof := FLastRowCount <> ANRows;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then DumpColumns(FLastRowCount, FEof);
{$ENDIF}
  if FEof then
    FCanceled := True;
end;

{-------------------------------------------------------------------------------}
procedure TOCIStatement.CancelCursor;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIStmtFetch, ['ARows', '<cancel>']);
  end;
{$ENDIF}
begin
  if FCanceled then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIStmtFetch(FHandle, Env.Error.FHandle, 0, OCI_FETCH_NEXT, OCI_DEFAULT));
  FCanceled := True;
end;

{-------------------------------------------------------------------------------}
function TOCIStatement.GetRowId: String;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrGet, ['@VType', 'str', 'AType', 'OCI_ATTR_ROWID', 'Result', Result]);
  end;
{$ENDIF}
var
  hRID: pOCIDescriptor;
  iRes: sword;
  aBuff: array [0 .. C_RowIdLen-1] of Byte;
  iLen: ub2;
begin
  Result := '';
  if (FLastRowCount = 1) and (Env.Lib.Version >= cvOracle90000) then begin
    Check(Env.Lib.OCIDescriptorAlloc(Env.Handle, hRID, OCI_DTYPE_ROWID, 0, nil));
    try
      iRes := Env.Lib.OCIAttrGet(FHandle, OCI_HTYPE_STMT, @hRID, nil, OCI_ATTR_ROWID,
        Env.Error.FHandle);
      if iRes <> OCI_NO_DATA then begin
        Check(iRes);
        Check(Env.Lib.OCIRowidToChar(hRID, @aBuff[0], iLen, Env.Error.FHandle));
        Result := Env.DataEncoder.Decode(@aBuff[0], iLen, ecANSI);
      end;
    finally
      Check(Env.Lib.OCIDescriptorFree(hRID, OCI_DTYPE_ROWID));
    end;
  end;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TOCIStatement.FetchImplRowids: Boolean;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrSet, ['@VType', 'ub4', 'AType', OCI_ATTR_FETCH_ROWID, 'Val', 1]);
  end;
{$ENDIF}
var
  iVal: ub4;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  iVal := 1;
  Result := Env.Lib.OCIAttrSet(FHandle, FType, @iVal, 0,
    OCI_ATTR_FETCH_ROWID, Env.Error.FHandle) = OCI_SUCCESS;
end;

{-------------------------------------------------------------------------------}
{ TOCIVariable                                                                  }
{-------------------------------------------------------------------------------}
procedure OraDate2DateTime(pIn: pUb1; var D: TDateTimeRec);
var
  pDate: POraDate;
begin
  D.DateTime := 0.0;
  pDate := POraDate(pIn);
  if (pDate^.century > 100) or (pDate^.century = 100) and (pDate^.year > 100) then
    D.DateTime := FDDateTime2MSecs(EncodeDateTime(
      Word((pDate^.century - 100) * 100 + (pDate^.year - 100)), pDate^.month, pDate^.day,
      Word(pDate^.hour - 1), Word(pDate^.minute - 1), Word(pDate^.second - 1), 0));
end;

{-------------------------------------------------------------------------------}
procedure DateTime2OraDate(pOut: pUb1; const D: TDateTimeRec);
var
  tmp, Y, M, D2, H, M2, S: Word;
  dt: TDateTime;
  pDate: POraDate;
begin
  dt := FDMSecs2DateTime(D.DateTime);
  pDate := POraDate(pOut);
  Y := 0;
  M := 0;
  D2 := 0;
  DecodeDate(dt, Y, M, D2);
  pDate^.century := ub1(Y div 100 + 100);
  pDate^.year := ub1(Y - (pDate^.century - 100) * 100 + 100);
  pDate^.month := ub1(M);
  pDate^.day := ub1(D2);
  H := 0;
  M2 := 0;
  S := 0;
  tmp := 0;
  DecodeTime(dt, H, M2, S, tmp);
  pDate^.hour := ub1(H + 1);
  pDate^.minute := ub1(M2 + 1);
  pDate^.second := ub1(S + 1);
end;

{-------------------------------------------------------------------------------}
procedure Bcd2OraNumber(pOut: pOCINumber; const B: TBcd; out ALen: ub2);
var
  i: Integer;
  pNibble: PByte;
  pOutB: PByte;
  iByteInd: Integer;
  iDigitInd: Integer;
  iDigit: Integer;
  iPrec: Integer;
  iScaleOffset: Integer;
  lNegative: WordBool;
  lWasDigit: WordBool;
begin
  FillChar(pOut^[0], OCI_NUMBER_SIZE, 0);

  // check for 0
  if B.Precision > 0 then begin
    iPrec := (B.Precision - 1) div 2;
    while (iPrec >= 0) and (B.Fraction[iPrec] = 0) do
      Dec(iPrec);
  end
  else
    iPrec := -1;
  if iPrec < 0 then begin
    pOut^[0] := 1;
    pOut^[1] := Byte(-128);
    ALen := 2;
    Exit;
  end;

  iPrec := B.Precision - B.SignSpecialPlaces and 63;
  lNegative := (B.SignSpecialPlaces and (1 shl 7)) <> 0;

  pNibble := @B.Fraction[0];
  iDigitInd := iPrec mod 2;
  lWasDigit := False;
  iScaleOffset := 0;
  Inc(iPrec, iDigitInd);

  iByteInd := 2;
  pOutB := @pOut^[iByteInd];

  for i := 0 to B.Precision + B.Precision mod 2 do begin
    if iByteInd = OCI_NUMBER_SIZE then begin
      Inc(pOut^[iByteInd - 1]);
      Break;
    end;

    iDigit := 0;
    if i < B.Precision then
      if i mod 2 = 0 then
        iDigit := pNibble^ shr 4
      else begin
        iDigit := pNibble^ and 15;
        pNibble := PByte(NativeUInt(pNibble) + 1);
      end;
    if iDigit <> 0 then
      lWasDigit := True;

    if iDigitInd = 0 then
      pOutB^ := iDigit * 10
    else begin
      pOutB^ := pOutB^ + iDigit + 1;
      if (pOutB^ > 1) or lWasDigit then begin
        Inc(iByteInd);
        pOutB := PByte(NativeUInt(pOutB) + 1);
      end
      else
        Inc(iScaleOffset);
    end;
    iDigitInd := 1 - iDigitInd;
  end;

  while pOut^[iByteInd - 1] = 1 do begin
    pOut^[iByteInd - 1] := 0;
    Dec(iByteInd);
  end;

  pOut^[1] := iPrec div 2 - 1 - iScaleOffset + 65 + 128;

  if lNegative then begin
    pOut^[1] := not pOut^[1];

    if iByteInd < OCI_NUMBER_SIZE then
      Inc(iByteInd);

    for i := iByteInd - 1 downto 2 do
      pOut^[i] := 102 - pOut^[i];
  end;
  pOut^[0] := iByteInd - 1;
  ALen := iByteInd;
end;

{-------------------------------------------------------------------------------}
procedure OraNumber2Bcd(pIn: pOCINumber; var B: TBcd);
var
  iPrec: Integer;
  iScale: Integer;
  i: Integer;
  lNegative: WordBool;
  iExponent: Integer;
  iLen: Integer;
  iDigit: Byte;
  pNibble: PByte;
  iNibbleDigit: Integer;
  iCurByte: Integer;

  procedure SetNibble(ADigit: Byte);
  begin
    if iNibbleDigit = 0 then
      pNibble^ := ADigit shl 4
    else
      pNibble^ := pNibble^ or ADigit;
    iNibbleDigit := 1 - iNibbleDigit;
    if iNibbleDigit = 0 then
      pNibble := PByte(NativeUInt(pNibble) + SizeOf(Byte));
  end;

begin
  FillChar(B, SizeOf(TBcd), 0);

  iLen := pIn^[0];
  // Special value - zero
  if (iLen = 1) and (pIn^[1] = Byte(-128)) then begin
    B.Precision := 10;
    B.SignSpecialPlaces := 2;
    Exit;
  end
  // Special value - +oo
  else if (iLen = 2) and (pIn^[1] = 255) and (pIn^[1] = 101) then
    FDException(nil, [S_FD_LPhys, S_FD_OraId], er_FD_OraCantConvNum, ['+oo'])
  // Special value - -oo
  else if (iLen = 1) and (pIn^[1] = 0) then
    FDException(nil, [S_FD_LPhys, S_FD_OraId], er_FD_OraCantConvNum, ['-oo']);

  lNegative := pIn^[1] and $80 = 0;
  if not lNegative then
    iExponent := pIn^[1] - 128 - 65
  else begin
    iExponent := not pIn^[1] - 128 - 65;
    if pIn^[iLen] = 102 then
      Dec(iLen);
  end;

  iNibbleDigit := 0;
  if iExponent < 0 then begin
    pNibble := @(B.Fraction[Abs(iExponent) - 1]);
    iPrec := (Abs(iExponent) - 1) * 2 + (iLen - 1) * 2;
    iScale := iPrec;
  end
  else if iExponent >= iLen - 1 then begin
    pNibble := @(B.Fraction[0]);
    iPrec := (iExponent + 1) * 2;
    iScale := 0;
  end
  else begin
    pNibble := @(B.Fraction[0]);
    iPrec := (iLen - 1) * 2;
    iScale := iPrec - (iExponent + 1) * 2;
  end;

  for i := 2 to iLen do begin
    if lNegative then
      iCurByte := 101 - pIn^[i]
    else
      iCurByte := pIn^[i] - 1;

    iDigit := iCurByte div 10;
    if (i = 2) and (iDigit = 0) and (iPrec > iScale) then
      Dec(iPrec)
    else
      SetNibble(iDigit);

    iDigit := iCurByte mod 10;
    if (i = iLen) and (iDigit = 0) and (iScale > 0) then begin
      Dec(iPrec);
      Dec(iScale);
    end
    else
      SetNibble(iDigit);
  end;
  B.Precision := iPrec;
  B.SignSpecialPlaces := iScale;
  if lNegative then
    B.SignSpecialPlaces := B.SignSpecialPlaces or (1 shl 7);
end;

{-------------------------------------------------------------------------------}
constructor TOCIVariable.Create(AStmt: TOCIStatement);
begin
  inherited Create(AStmt.Env);
  FOwner := AStmt;
  FOwningObj := AStmt.OwningObj;
  ArrayLen := 1;
end;

{-------------------------------------------------------------------------------}
destructor TOCIVariable.Destroy;
begin
  FreeBuffer;
  FHandle := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
// Get/Set props

procedure TOCIVariable.SetArrayLen(const AValue: ub4);
begin
  if FMaxArr_len <> AValue then begin
    FreeBuffer;
    FMaxArr_len := AValue;
    if (FMaxArr_len = 0) and FIsPLSQLTable then
      FMaxArr_len := 1;
    FCurEle := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.SetDataSize(const AValue: ub4);
begin
  if FValue_byte_sz <> AValue then begin
    FFlagsUpdated := False;
    FValue_byte_sz := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.SetDataType(const AValue: TOCIVarDataType);
begin
  if FDataType <> AValue then begin
    FFlagsUpdated := False;
    FDataType := AValue;
    FValue_ty := nc2ociValueType[AValue];
    FValue_byte_sz := nc2ociValueSize[AValue];
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.SetVarType(const AValue: TOCIVarType);
begin
  if FVarType <> AValue then begin
    FFlagsUpdated := False;
    FVarType := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
function TOCIVariable.GetDumpLabel: String;
begin
  if FDumpLabel = '' then
    if Name = '' then
      Result := Format('#%d', [Position])
    else
      Result := Name
  else
    Result := FDumpLabel;
end;

{-------------------------------------------------------------------------------}
// Buffer management

procedure TOCIVariable.UpdateFlags;
var
  iBPC: ub1;
  iMaxSize: ub4;
  lSetMax: Boolean;
begin
  if FFlagsUpdated then
    Exit;

  FreeBuffer;
  lSetMax := False;
  iBPC := TOCIStatement(FOwner).FService.BytesPerChar;

  // Long's & In/InOut & PL/SQL & pice-wise will be followed by ORA-03127:
  // No new operations allowed until the active operation ends.
  // Although statement execution finished with OCI_SUCCESS.
  if (DataType in otVBlobs) and (VarType in [odIn, odOut, odInOut]) and
     (TOCIStatement(FOwner).STMT_TYPE in [OCI_STMT_BEGIN, OCI_STMT_DECLARE]) and
     (DataSize = 0) then begin
    FLongData := False;
    FValue_byte_sz := C_FD_MaxPLSQLDataSize;
    lSetMax := True;
  end

  else begin
    if (DataType in [otRaw]) and (DataSize = C_FD_DefStrSize) or
       (DataType in [otString, otChar]) and (DataSize = C_FD_DefStrSize * SizeOf(TFDAnsiChar)) or
       (DataType in [otNString, otNChar]) and (DataSize = C_FD_DefStrSize * SizeOf(WideChar)) then begin
      lSetMax := True;
      if TOCIStatement(FOwner).STMT_TYPE in [OCI_STMT_BEGIN, OCI_STMT_DECLARE] then
        iMaxSize := C_FD_MaxPLSQLDataSize
      else if (DataType in [otChar, otNChar, otRaw]) and
              (FOwner.Env.Lib.Version < cvOracle120000) then
        iMaxSize := 2000
      else
        iMaxSize := 4000;
      if DataType <> otRaw then
        iMaxSize := iMaxSize div iBPC;
      if DataType in [otNString, otNChar] then
        iMaxSize := iMaxSize * SizeOf(WideChar);
      if iMaxSize > FValue_byte_sz then
        FValue_byte_sz := iMaxSize;
    end;

    FLongData := (
      (DataType in [otString, otNString, otChar, otNChar, otRaw]) and
         (VarType = odDefine) and (DataSize > C_FD_DefMaxStrSize)
      or
      (DataType in otVBlobs) and (
         (DataSize = 0) or (DataSize > C_FD_DefMaxStrSize)
      )
    );
  end;

  if FDataType in [otChar, otString, otLong, otROWID] then
    FValue_char_sz := DataSize div SizeOf(TFDAnsiChar)
  else if FDataType in [otNChar, otNString, otNLong] then
    FValue_char_sz := DataSize div SizeOf(WideChar)
  else
    FValue_char_sz := DataSize;

  // 1) adjust buffer size in bytes to be even, otherwise ORA-24508 will be raised
  // at executing SP returning REF CURSOR with NVARCHAR(15) on 9.2.0.8.
  // 2) do not make buffer size greater than 65535 for piece fetching data,
  // otherwise OCIStmtSetPieceInfo will raise ORA-24307.
  // 3) do not make buffer size greater than allowed for SQL data type (eg 1333
  // for CHAR with UTF8 encoding), otherwise OCIStmtExecute will raise ORA-01461
  if (DataType in [otString, otChar, otNString, otNChar, otRaw, otLong, otNLong, otLongRaw, otROWID]) and
     (DataSize and 1 = 1) then
    if lSetMax or LongData and (DataSize >= 65535) then
      Dec(FValue_byte_sz)
    else
      Inc(FValue_byte_sz);

  FByteSemantic := Env.ByteSemantic or
    ((VarType = odOut) or (DataType = otNLong)) and
    (FOwner.Env.Lib.Version < cvOracle90000);

  FFlagsUpdated := True;
end;

{-------------------------------------------------------------------------------}
function TOCIVariable.GetBindDataSize: ub4;
var
  L: ub4;
begin
  if LongData then
    L := SizeOf(TLongData)
  else
    L := FValue_byte_sz;
  Result := SizeOf(TBindData) + (SizeOf(sb2) + SizeOf(ub2) +
    SizeOf(ub2) + L) * FMaxArr_len;
end;

{-------------------------------------------------------------------------------}
function TOCIVariable.GetBuffer(AIndex: ub4): pUb1;
var
  L: ub4;
begin
  if LongData then
    L := SizeOf(TLongData)
  else
    L := FValue_byte_sz;
  Result := pUb1(NativeUInt(FBindData^.FBuffer) + L * ub4(AIndex));
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.ClearBuffer(ATimes, AOffset: sb4);
var
  i: Integer;
  dType: ub4;
  lIsTemp: LongBool;
  hErr: pOCIError;

  procedure DoClear(i: Integer);
{$IFDEF FireDAC_MONITOR}
    procedure ProcTrace1;
    begin
      Trace(sOCIHandleFree, ['@HKind', hndlNames[dType], 'HVal', ppOCIHandle(Buffer[i])^]);
    end;
    procedure ProcTrace2;
    begin
      Trace(sOCIDescriptorFree, ['@HKind', hndlNames[dType], 'HVal', ppOCIHandle(Buffer[i])^]);
    end;
    procedure ProcTrace3;
    begin
      Trace(sOCILobIsTemporary, ['HVal', ppOCIHandle(Buffer[i])^]);
    end;
    procedure ProcTrace4;
    begin
      Trace(sOCILobFreeTemporary, ['HVal', ppOCIHandle(Buffer[i])^]);
    end;
{$ENDIF}
  begin
    if LongData then
      FreeLong(PLongData(Buffer[i]))
    else if (dType <> 0) and (ppOCIHandle(Buffer[i])^ <> nil) then begin
      if dType = OCI_HTYPE_STMT then begin
{$IFDEF FireDAC_MONITOR}
        if Env.Tracing then ProcTrace1;
{$ENDIF}
        Check(Env.Lib.OCIHandleFree(ppOCIHandle(Buffer[i])^, dType));
      end
      else begin
        if (Env.Lib.Version >= cvOracle81000) and (dType = OCI_DTYPE_LOB) and
           (VarType in [odIn, odInOut]) then begin
          hErr := Env.Error.FHandle;
{$IFDEF FireDAC_MONITOR}
          if Env.Tracing then ProcTrace3;
{$ENDIF}
          Check(Env.Lib.OCILobIsTemporary(Env.Handle, hErr,
            ppOCIHandle(Buffer[i])^, lIsTemp));
          if lIsTemp then begin
{$IFDEF FireDAC_MONITOR}
            if Env.Tracing then ProcTrace4;
{$ENDIF}
            Check(Env.Lib.OCILobFreeTemporary(TOCIStatement(FOwner).FService.Handle,
              hErr, ppOCIHandle(Buffer[i])^));
          end;
        end;
{$IFDEF FireDAC_MONITOR}
        if Env.Tracing then ProcTrace2;
{$ENDIF}
        Check(Env.Lib.OCIDescriptorFree(ppOCIHandle(Buffer[i])^, dType));
      end;
      ppOCIHandle(Buffer[i])^ := nil;
    end;
  end;

begin
  if not FBufferInited then
    Exit;
  FBufferInited := False;
  ASSERT(FOwner <> nil);
  ASSERT((ATimes = -1) or (ATimes <= sb4(FMaxArr_len)));
  ASSERT((AOffset = -1) or (AOffset <= sb4(FMaxArr_len) - 1));
  dType := 0;
  case DataType of
  otCursor,
  otNestedDataSet:
    dType := OCI_HTYPE_STMT;
  otCLOB,
  otNCLOB,
  otBLOB:
    dType := OCI_DTYPE_LOB;
  otCFile,
  otBFile:
    dType := OCI_DTYPE_FILE;
  otTimeStamp:
    dType := OCI_DTYPE_TIMESTAMP_TZ;
  otIntervalYM:
    dType := OCI_DTYPE_INTERVAL_YM;
  otIntervalDS:
    dType := OCI_DTYPE_INTERVAL_DS;
  end;
  if ATimes = -1 then
    ATimes := FMaxArr_len;
  if AOffset = -1 then
    AOffset := 0;
  for i := AOffset to ATimes - 1 do
    DoClear(i);
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.FreeBuffer;
begin
  if FBindData <> nil then begin
    if FOwner <> nil then begin
      ClearBuffer(-1, -1);
      TOCIStatement(FOwner).RemovePieceVar(Self);                                                
    end;
    FreeMem(FBindData);
    FBindData := nil;
    FLastBindedBuffer := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.InitBuffer(ATimes, AOffset: sb4);
var
  i: Integer;
  dType: ub4;
  lobType: ub1;
  csid: ub2;
  csfrm: ub1;

  procedure DoInit(i: sb4);
{$IFDEF FireDAC_MONITOR}
    procedure ProcTrace1;
    begin
      Trace(sOCIHandleAlloc, ['@HKind', hndlNames[dType]]);
    end;
    procedure ProcTrace2;
    begin
      Trace(sOCIDescriptorAlloc, ['@HKind', hndlNames[dType]]);
    end;
    procedure ProcTrace3;
    begin
      Trace(sOCILobCreateTemporary, ['@LobType', LobTypeNames[LobType], 'HVal',
        ppOCIHandle(Buffer[i])^]);
    end;
{$ENDIF}
  begin
    FBindData^.FInd[i] := -1;
    FBindData^.FALen[i] := ub2(FValue_char_sz);
    FBindData^.FRCode[i] := OCI_SUCCESS;
    if LongData then
      InitLong(PLongData(Buffer[i]))
    else if dType <> 0 then begin
      ppOCIHandle(Buffer[i])^ := nil;
      if dType = OCI_HTYPE_STMT then begin
{$IFDEF FireDAC_MONITOR}
        if Env.Tracing then ProcTrace1;
{$ENDIF}
        Check(Env.Lib.OCIHandleAlloc(Env.Handle, ppOCIHandle(Buffer[i])^,
          OCI_HTYPE_STMT, 0, nil));
        FBindData^.FInd[i] := 0;
      end
      else begin
{$IFDEF FireDAC_MONITOR}
        if Env.Tracing then ProcTrace2;
{$ENDIF}
        Check(Env.Lib.OCIDescriptorAlloc(Env.Handle, ppOCIHandle(Buffer[i])^,
          dType, 0, nil));
        if (Env.Lib.Version >= cvOracle81000) and (dType = OCI_DTYPE_LOB) and
           (VarType in [odIn, odInOut]) then begin
          case DataType of
          otBLOB:
            begin
              lobType := OCI_TEMP_BLOB;
              csid := 0;
              csfrm := SQLCS_IMPLICIT;
            end;
          otCLOB:
            begin
              lobType := OCI_TEMP_CLOB;
              csid := Env.ExplicitCharsetID;
              csfrm := SQLCS_IMPLICIT;
            end;
          otNCLOB:
            begin
              lobType := OCI_TEMP_CLOB;
              csid := OCI_UTF16ID;
              csfrm := SQLCS_NCHAR;
            end;
          end;
{$IFDEF FireDAC_MONITOR}
          if Env.Tracing then ProcTrace3;
{$ENDIF}
          Check(Env.Lib.OCILobCreateTemporary(TOCIStatement(FOwner).FService.FHandle,
            Env.Error.FHandle, ppOCIHandle(Buffer[i])^, csid, csfrm, lobType, True,
            OCI_DURATION_SESSION));
          FBindData^.FInd[i] := 0;
        end;
      end;
    end;
  end;

begin
  if FBufferInited then
    Exit;
  FBufferInited := True;
  ASSERT((ATimes = -1) or (ATimes <= sb4(FMaxArr_len)));
  ASSERT((AOffset = -1) or (AOffset <= sb4(FMaxArr_len) - 1));
  case DataType of
  otCursor,
  otNestedDataSet:
    dType := OCI_HTYPE_STMT;
  otCLOB,
  otNCLOB,
  otBLOB:
    dType := OCI_DTYPE_LOB;
  otCFile,
  otBFile:
    dType := OCI_DTYPE_FILE;
  otTimeStamp:
    dType := OCI_DTYPE_TIMESTAMP_TZ;
  otIntervalYM:
    dType := OCI_DTYPE_INTERVAL_YM;
  otIntervalDS:
    dType := OCI_DTYPE_INTERVAL_DS;
  else
    dType := 0;
  end;
  CheckBufferAccess;
  if ATimes = -1 then
    ATimes := FMaxArr_len;
  if AOffset = -1 then
    AOffset := 0;
  for i := AOffset to ATimes - 1 do
    DoInit(i);
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.ResetBuffer(ATimes, AOffset: sb4);
begin
  ClearBuffer(ATimes, AOffset);
  InitBuffer(ATimes, AOffset);
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.CheckBufferAccess;
begin
  ASSERT(FOwner <> nil);
  ASSERT(FValue_ty > 0);
  ASSERT(FMaxArr_len > 0);
  UpdateFlags;
  ASSERT((DataType in [otString, otNString, otChar, otNChar, otLong, otNLong,
                       otRaw, otLongRaw]) or (FValue_byte_sz > 0));
  if FBindData = nil then begin
    GetMem(FBindData, BindDataSize);
    MapBuffer;
  end;
  InitBuffer(-1, -1);
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.MapBuffer;
var
  p: pUb1;
begin
  p := pUb1(FBindData);
  Inc(p, SizeOf(TBindData));
  FBindData^.FInd := PSb2Array(p);
  Inc(p, SizeOf(sb2) * FMaxArr_len);
  FBindData^.FALen := PUb2Array(p);
  Inc(p, SizeOf(ub2) * FMaxArr_len);
  FBindData^.FRCode := PUb2Array(p);
  Inc(p, SizeOf(ub2) * FMaxArr_len);
  FBindData^.FBuffer := pUb1(p);
end;

{-------------------------------------------------------------------------------}
// Binding

procedure TOCIVariable.Bind;
var
  v1: ub4;
  v2: pUb4;
  sz: sb4;
  tp: ub2;
  plcHldr: String;
  sbPlcHldr: TFDByteString;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace1;
  begin
    Trace(sOCIDefineByPos, ['Pos', FPosition, '@Mode', 'OCI_DYNAMIC_FETCH',
      '@tp', GetOCITypeName(tp), 'sz', sz]);
  end;
  procedure ProcTrace2;
  begin
    Trace(sOCIDefineByPos, ['Pos', FPosition, '@tp', GetOCITypeName(tp),
      'sz', sz, 'valuep', FBindData^.FBuffer]);
  end;
  procedure ProcTrace5;
  begin
    Trace(sOCIBindByPos, ['Pos', FPosition, '@Mode', 'OCI_DATA_AT_EXEC',
      '@tp', GetOCITypeName(tp), 'sz', sz]);
  end;
  procedure ProcTrace6;
  begin
    Trace(sOCIBindByPos, ['Pos', FPosition, '@tp', GetOCITypeName(tp),
      'sz', sz, 'valuep', FBindData^.FBuffer]);
  end;
  procedure ProcTrace7;
  begin
    Trace(sOCIBindByName, ['Name', plcHldr, '@Mode', 'OCI_DATA_AT_EXEC',
      '@tp', GetOCITypeName(tp), 'sz', sz]);
  end;
  procedure ProcTrace8;
  begin
    Trace(sOCIBindByName, ['Name', plcHldr, '@tp', GetOCITypeName(tp),
      'sz', sz, 'valuep', FBindData^.FBuffer]);
  end;
{$ENDIF}
  procedure SetMaxSize;
  begin
    if Env.Lib.Version < cvOracle90000 then begin
      if VarType <> odDefine then
        MAXDATA_SIZE := FValue_byte_sz;
    end
    else
      MAXCHAR_SIZE := FValue_char_sz;
  end;
begin
  ASSERT(FOwner <> nil);
  CheckBufferAccess;
  tp := FValue_ty;
  sz := FValue_byte_sz;
  if DataType in otVBlobs then begin
    // this is special case - if value size <> 0 then
    // there was mapping VARCHAR2/RAW into otLong/otNLong/otLongRaw
    if FValue_char_sz <> 0 then begin
      if DataType = otLong then
        tp := nc2ociValueType[otString]
      else if DataType = otNLong then
        tp := nc2ociValueType[otNString]
      else if DataType = otLongRaw then
        tp := nc2ociValueType[otRaw];
    end
    else
      sz := $7FFFFFFF;
  end;
  if VarType = odDefine then begin
    FType := OCI_HTYPE_DEFINE;
    if LongData then begin
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then ProcTrace1;
{$ENDIF}
      Check(Env.Lib.OCIDefineByPos(FOwner.FHandle, FHandle, Env.Error.FHandle,
        FPosition, nil, sz, tp, nil, nil, nil, OCI_DYNAMIC_FETCH));
      TOCIStatement(FOwner).AddPieceVar(Self);
    end
    else begin
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then ProcTrace2;
{$ENDIF}
      Check(Env.Lib.OCIDefineByPos(FOwner.FHandle, FHandle, Env.Error.FHandle,
        FPosition, FBindData^.FBuffer, sz, tp, FBindData^.FInd, pUb2(FBindData^.FALen),
        pUb2(FBindData^.FRCode), OCI_DEFAULT));
    end;
  end
  else if VarType in [odRet, odUnknown, odIn, odOut, odInOut] then begin
    if (FHandle = nil) or (FBindData^.FBuffer <> FLastBindedBuffer) then begin
      FLastBindedBuffer := FBindData^.FBuffer;
      FType := OCI_HTYPE_BIND;
      if FIsPLSQLTable and
         (TOCIStatement(FOwner).Stmt_Type in [OCI_STMT_BEGIN, OCI_STMT_DECLARE]) then begin
        v1 := FMaxArr_len;
        v2 := @FCurEle;
      end
      else begin
        v1 := 0;
        v2 := nil;
      end;
      if FPosition <> 0 then
        if LongData then begin
{$IFDEF FireDAC_MONITOR}
          if Env.Tracing then ProcTrace5;
{$ENDIF}
          Check(Env.Lib.OCIBindByPos(FOwner.FHandle, FHandle, Env.Error.FHandle,
            FPosition, nil, sz, tp, nil, nil, nil, v1, v2, OCI_DATA_AT_EXEC));
          TOCIStatement(FOwner).AddPieceVar(Self);
        end
        else begin
{$IFDEF FireDAC_MONITOR}
          if Env.Tracing then ProcTrace6;
{$ENDIF}
          Check(Env.Lib.OCIBindByPos(FOwner.FHandle, FHandle, Env.Error.FHandle,
            FPosition, FBindData^.FBuffer, sz, tp, FBindData^.FInd, pUb2(FBindData^.FALen),
            pUb2(FBindData^.FRCode), v1, v2, OCI_DEFAULT));
        end
      else begin
        if FIsCaseSensitive and (Env.Lib.Version >= cvOracle81600) then
          plcHldr := ':"' + Copy(FPlaceHolder, 2, Length(FPlaceHolder)) + '"'
        else
          plcHldr := FPlaceHolder;
        sbPlcHldr := Env.MetaEncoder.Encode(plcHldr);
        if LongData then begin
{$IFDEF FireDAC_MONITOR}
          if Env.Tracing then ProcTrace7;
{$ENDIF}
          Check(Env.Lib.OCIBindByName(FOwner.FHandle, FHandle, Env.Error.FHandle,
            PByte(sbPlcHldr), Env.MetaEncoder.EncodedLength(sbPlcHldr), nil,
            sz, tp, nil, nil, nil, v1, v2, OCI_DATA_AT_EXEC));
          TOCIStatement(FOwner).AddPieceVar(Self);
        end
        else begin
{$IFDEF FireDAC_MONITOR}
          if Env.Tracing then ProcTrace8;
{$ENDIF}
          Check(Env.Lib.OCIBindByName(FOwner.FHandle, FHandle, Env.Error.FHandle,
            PByte(sbPlcHldr), Env.MetaEncoder.EncodedLength(sbPlcHldr), FBindData^.FBuffer,
            sz, tp, FBindData^.FInd, pUb2(FBindData^.FALen), pUb2(FBindData^.FRCode),
            v1, v2, OCI_DEFAULT));
        end;
      end;
    end;
  end
  else
    FDException(OwningObj, [S_FD_LPhys, S_FD_OraId], er_FD_OraBadVarType, []);
  case DataType of
  otNChar,
  otNString,
  otNLong:
    begin
      if VarType = odDefine then
        CHARSET_FORM := SQLCS_NCHAR;
      CHARSET_ID := OCI_UTF16ID;
      SetMaxSize;
    end;
  otChar,
  otString,
  otLong:
    begin
      if Env.ExplicitCharsetID <> 0 then
        CHARSET_ID := Env.ExplicitCharsetID;
      SetMaxSize;
    end;
  otROWID:
    begin
      CHARSET_ID := OCI_US7ASCIIID;
      SetMaxSize;
    end;
  otNCLOB:
    CHARSET_FORM := SQLCS_NCHAR;
  end;
  TOCIStatement(FOwner).AddVar(Self);
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.BindTo(AStmt: TOCIStatement);
begin
  FOwner := AStmt;
  Bind;
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.BindOff;
begin
  if FOwner <> nil then begin
    ClearBuffer(-1, -1);
    TOCIStatement(FOwner).RemovePieceVar(Self);
    TOCIStatement(FOwner).RemoveVar(Self);
    FOwner := nil;
    FHandle := nil;
  end;
end;

{-------------------------------------------------------------------------------}
// Long value

procedure TOCIVariable.FreeLong(ApLong: PLongData);
begin
  if ApLong^.FData <> nil then
    try
      FreeMem(ApLong^.FData, ApLong^.FSize);
    finally
      InitLong(ApLong);
    end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.InitLong(ApLong: PLongData);
begin
  ApLong^.FData := nil;
  ApLong^.FSize := 0;
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.GetLong(ApLong: PLongData; var AData: pUb1; var ASize: ub4);
begin
  ASize := ApLong^.FSize;
  AData := ApLong^.FData;
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.SetLong(ApLong: PLongData; AData: pUb1; ASize: ub4);
begin
  FreeLong(ApLong);
  GetMem(ApLong^.FData, ASize);
  Move(AData^, ApLong^.FData^, ASize);
  ApLong^.FSize := ASize;
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.AppendLong(ApLong: PLongData; AData: pUb1; ASize: ub4);
begin
  if ApLong^.FData = nil then
    SetLong(ApLong, AData, ASize)
  else begin
    ReallocMem(ApLong^.FData, ApLong^.FSize + ASize);
    Move(AData^, pUb1(NativeUInt(ApLong^.FData) + ApLong^.FSize)^, ASize);
    Inc(ApLong^.FSize, ASize);
  end;
end;

{-------------------------------------------------------------------------------}
// Get/Set value

function TOCIVariable.GetRawData(AIndex: ub4; out ABuff: pUb1; out ASize: ub4): Boolean;
begin
  ASSERT(AIndex < FMaxArr_len);
  ASSERT(FBindData <> nil);
  ASSERT(DataType in [otString, otChar, otLong,
                      otNString, otNChar, otNLong,
                      otRaw, otLongRaw]);
  if FBindData^.FInd[AIndex] = -1 then begin
    Result := False;
    ABuff := nil;
    ASize := 0;
  end
  else begin
    Result := True;
    ABuff := Buffer[AIndex];
    if LongData then
      GetLong(PLongData(ABuff), ABuff, ASize)
    else
      ASize := FBindData^.FALen[AIndex];
    if ByteSemantic then
      case DataType of
      otString, otChar, otLong:
        ASize := ASize div SizeOf(TFDAnsiChar);
      otNString, otNChar, otNLong:
        ASize := ASize div SizeOf(WideChar);
      end;
  end;
end;

{-------------------------------------------------------------------------------}
function TOCIVariable.GetData(AIndex: ub4; var ABuff: pUb1; out ASize: ub4;
  AByRef: Boolean): Boolean;
var
  pBuff: pUb1;
  pANSI: Pointer;
begin
  ASSERT(AIndex < FMaxArr_len);
  ASSERT(FBindData <> nil);
  if (FBindData^.FInd[AIndex] = -1) and (DataType < otCursor) then begin
    Result := False;
    if AByRef then
      ABuff := nil;
    ASize := 0;
  end
  else begin
    Result := True;
    pBuff := Buffer[AIndex];
    case DataType of
      otInt32:
        begin
          ASize := SizeOf(Integer);
          if AByRef then
            ABuff := pBuff
          else
            PInteger(ABuff)^ := PInteger(pBuff)^;
        end;
      otUInt32:
        begin
          ASize := SizeOf(Cardinal);
          if AByRef then
            ABuff := pBuff
          else
            PCardinal(ABuff)^ := PCardinal(pBuff)^;
        end;
      otInt64:
        begin
          ASize := SizeOf(Int64);
          if AByRef then
            ABuff := pBuff
          else
            PInt64(ABuff)^ := PInt64(pBuff)^;
        end;
      otUInt64:
        begin
          ASize := SizeOf(UInt64);
          if AByRef then
            ABuff := pBuff
          else
            PUInt64(ABuff)^ := PUInt64(pBuff)^;
        end;
      otSingle:
        begin
          ASize := SizeOf(Single);
          if AByRef then
            ABuff := pBuff
          else
            PSingle(ABuff)^ := PSingle(pBuff)^;
        end;
      otDouble:
        begin
          ASize := SizeOf(Double);
          if AByRef then
            ABuff := pBuff
          else
            PDouble(ABuff)^ := PDouble(pBuff)^;
        end;
      otNumber:
        if AByRef then begin
          ASize := OCI_NUMBER_SIZE;
          ABuff := pBuff;
        end
        else begin
          OraNumber2Bcd(pOCINumber(pBuff), PBcd(ABuff)^);
          ASize := SizeOf(TBcd);
        end;
      otROWID:
        begin
          ASize := FBindData^.FALen[AIndex] div SizeOf(TFDAnsiChar);
          if AByRef then
            ABuff := pBuff
          else
            Move(pBuff^, PFDAnsiString(ABuff)^, ASize * SizeOf(TFDAnsiChar));
        end;
      otRaw, otLongRaw:
        begin
          if LongData then
            GetLong(PLongData(pBuff), pBuff, ASize)
          else
            ASize := FBindData^.FALen[AIndex];
          if (ASize = 0) and TOCIStatement(FOwner).StrsEmpty2Null then begin
            Result := False;
            if AByRef then
              ABuff := nil;
          end
          else if AByRef then
            ABuff := pBuff
          else if ABuff <> nil then
            Move(pBuff^, PByte(ABuff)^, ASize);
        end;
      otString, otChar, otLong:
        begin
          if LongData then
            GetLong(PLongData(pBuff), pBuff, ASize)
          else
            ASize := FBindData^.FALen[AIndex];
          if ByteSemantic then
            ASize := ASize div SizeOf(TFDAnsiChar);
          if Env.DataEncoder.Encoding = ecUTF8 then begin
            pANSI := nil;
            ASize := Env.DataEncoder.Decode(pBuff, ASize, pANSI, ecANSI);
            pBuff := pANSI;
          end;
          if (DataType = otChar) and TOCIStatement(FOwner).StrsTrim then
            while (ASize > 0) and (PFDAnsiString(pBuff)[ASize - 1] = TFDAnsiChar(' ')) do
              Dec(ASize);
          if (ASize = 0) and TOCIStatement(FOwner).StrsEmpty2Null then begin
            Result := False;
            if AByRef then
              ABuff := nil;
          end
          else if AByRef then
            ABuff := pBuff
          else if ABuff <> nil then begin
            Move(pBuff^, PFDAnsiString(ABuff)^, ASize * SizeOf(TFDAnsiChar));
            if (DataType = otChar) and not TOCIStatement(FOwner).StrsTrim and
               (ASize < FValue_char_sz) then
              FillChar((PFDAnsiString(pBuff) + ASize)^,
                (FValue_char_sz - ASize) * SizeOf(TFDAnsiChar), 0);
          end;
        end;
      otNString, otNChar, otNLong:
        begin
          if LongData then
            GetLong(PLongData(pBuff), pBuff, ASize)
          else
            ASize := FBindData^.FALen[AIndex];
          if ByteSemantic then
            ASize := ASize div SizeOf(WideChar);
          if (DataType = otNChar) and TOCIStatement(FOwner).StrsTrim then
            while (ASize > 0) and (PWideChar(pBuff)[ASize - 1] = ' ') do
              Dec(ASize);
          if (ASize = 0) and TOCIStatement(FOwner).StrsEmpty2Null then begin
            Result := False;
            if AByRef then
              ABuff := nil;
          end
          else if AByRef then
            ABuff := pBuff
          else if ABuff <> nil then begin
            Move(pBuff^, PWideChar(ABuff)^, ASize * SizeOf(WideChar));
            if (DataType = otNChar) and not TOCIStatement(FOwner).StrsTrim and
               (ASize < FValue_char_sz) then
              FillChar((PWideChar(pBuff) + ASize)^,
                (FValue_char_sz - ASize) * SizeOf(WideChar), 0);
          end;
        end;
      otDateTime:
        if AByRef then begin
          ASize := SizeOf(TOraDate);
          ABuff := pBuff;
        end
        else begin
          OraDate2DateTime(pBuff, PDateTimeRec(ABuff)^);
          ASize := SizeOf(TDateTime);
        end;
      otBoolean:
        begin
          ASize := SizeOf(WordBool);
          if AByRef then
            ABuff := pBuff
          else
            PWordBool(ABuff)^ := PInteger(pBuff)^ = 1;
        end;
    else
      if DataType >= otCursor then begin
        Result := UpdateHValueNullInd(AIndex);
        ASize := SizeOf(pOCIDescriptor);
        if AByRef then
          ABuff := pBuff
        else if ABuff <> nil then
          ppOCIHandle(ABuff)^ := ppOCIHandle(pBuff)^;
      end
      else
        ASSERT(False);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.SetData(AIndex: ub4; ABuff: pUb1; ASize: ub4);
var
  pUTF8: Pointer;
  pUTF16: PWideChar;
  i: ub4;
  uiLen: ub2;

  procedure ErrorDataTooLarge(AMax, AActual: ub4);
  begin
    FDException(OwningObj, [S_FD_LPhys, S_FD_OraId], er_FD_AccDataToLarge,
      [DumpLabel, AMax, AActual]);
  end;

begin
  ASSERT(AIndex < FMaxArr_len);
  ASSERT(FBindData <> nil);
  if LongData then
    FreeLong(PLongData(Buffer[AIndex]));
  if ABuff = nil then
    FBindData^.FInd[AIndex] := -1
  else begin
    FBindData^.FInd[AIndex] := 0;
    case DataType of
      otInt32:
        begin
          PInteger(Buffer[AIndex])^ := PInteger(ABuff)^;
          FBindData^.FALen[AIndex] := ub2(SizeOf(Integer));
        end;
      otUInt32:
        begin
          PCardinal(Buffer[AIndex])^ := PCardinal(ABuff)^;
          FBindData^.FALen[AIndex] := ub2(SizeOf(Cardinal));
        end;
      otInt64:
        begin
          PInt64(Buffer[AIndex])^ := PInt64(ABuff)^;
          FBindData^.FALen[AIndex] := ub2(SizeOf(Int64));
        end;
      otUInt64:
        begin
          PUInt64(Buffer[AIndex])^ := PUInt64(ABuff)^;
          FBindData^.FALen[AIndex] := ub2(SizeOf(UInt64));
        end;
      otSingle:
        begin
          PSingle(Buffer[AIndex])^ := PSingle(ABuff)^;
          FBindData^.FALen[AIndex] := ub2(SizeOf(Single));
        end;
      otDouble:
        begin
          PDouble(Buffer[AIndex])^ := PDouble(ABuff)^;
          FBindData^.FALen[AIndex] := ub2(SizeOf(Double));
        end;
      otNumber:
        begin
          Bcd2OraNumber(pOCINumber(Buffer[AIndex]), PBcd(ABuff)^, uiLen);
          FBindData^.FALen[AIndex] := uiLen;
        end;
      otROWID:
        begin
          if ASize > FValue_char_sz then
            ErrorDataTooLarge(FValue_char_sz, ASize);
          Move(PFDAnsiString(ABuff)^, Buffer[AIndex]^, ASize * SizeOf(TFDAnsiChar));
          FBindData^.FALen[AIndex] := ub2(ASize * SizeOf(TFDAnsiChar));
        end;
      otRaw, otLongRaw:
        begin
          if TOCIStatement(FOwner).StrsEmpty2Null and (ASize = 0) then
            FBindData^.FInd[AIndex] := -1
          else begin
            if (ASize > FValue_char_sz) and (
              (DataType = otRaw) or
              (DataType = otLongRaw) and not LongData
               ) then
              ErrorDataTooLarge(FValue_char_sz, ASize);
            if LongData then begin
              SetLong(PLongData(Buffer[AIndex]), ABuff, ASize);
              FBindData^.FALen[AIndex] := ub2(SizeOf(TLongData));
            end
            else begin
              Move(PByte(ABuff)^, Buffer[AIndex]^, ASize);
              FBindData^.FALen[AIndex] := ub2(ASize);
            end;
          end;
        end;
      otString, otChar, otLong:
        begin
          if (DataType = otChar) and TOCIStatement(FOwner).StrsTrim then
            while (ASize > 0) and (PFDAnsiString(ABuff)[ASize - 1] = TFDAnsiChar(' ')) do
              Dec(ASize);
          if TOCIStatement(FOwner).StrsEmpty2Null and (ASize = 0) then
            FBindData^.FInd[AIndex] := -1
          else begin
            if Env.DataEncoder.Encoding = ecUTF8 then begin
              pUTF8 := nil;
              ASize := Env.DataEncoder.Encode(ABuff, ASize, pUTF8, ecANSI);
              ABuff := pUTF8;
            end;
            if (ASize > FValue_char_sz) and (
              (DataType in [otString, otChar]) or
              (DataType = otLong) and not LongData
               ) then
              ErrorDataTooLarge(FValue_char_sz, ASize);
            if LongData then begin
              SetLong(PLongData(Buffer[AIndex]), ABuff, ASize * SizeOf(TFDAnsiChar));
              FBindData^.FALen[AIndex] := ub2(SizeOf(TLongData));
            end
            else begin
              Move(PFDAnsiString(ABuff)^, Buffer[AIndex]^, ASize * SizeOf(TFDAnsiChar));
              if (DataType = otChar) and not TOCIStatement(FOwner).StrsTrim and
                 (ASize < FValue_char_sz) then
                FillChar((PFDAnsiString(Buffer[AIndex]) + ASize)^,
                  (FValue_char_sz - ASize) * SizeOf(TFDAnsiChar), Byte(' '));
              if ByteSemantic then
                ASize := ASize * SizeOf(TFDAnsiChar);
              FBindData^.FALen[AIndex] := ub2(ASize);
            end;
          end;
        end;
      otNString, otNChar, otNLong:
        begin
          if ASize = $FFFFFFFF then
            ASize := StrLen(PWideChar(ABuff));
          if (DataType = otNChar) and TOCIStatement(FOwner).StrsTrim then
            while (ASize > 0) and (PWideChar(ABuff)[ASize - 1] = ' ') do
              Dec(ASize);
          if TOCIStatement(FOwner).StrsEmpty2Null and (ASize = 0) then
            FBindData^.FInd[AIndex] := -1
          else begin
            if (ASize > FValue_char_sz) and (
              (DataType in [otNString, otNChar]) or
              (DataType = otNLong) and not LongData
               ) then
              ErrorDataTooLarge(FValue_char_sz, ASize);
            if LongData then begin
              SetLong(PLongData(Buffer[AIndex]), ABuff, ASize * SizeOf(WideChar));
              FBindData^.FALen[AIndex] := ub2(SizeOf(TLongData));
            end
            else begin
              Move(PWideChar(ABuff)^, Buffer[AIndex]^, ASize * SizeOf(WideChar));
              if (DataType = otNChar) and not TOCIStatement(FOwner).StrsTrim and
                 (ASize < FValue_char_sz) then begin
                pUTF16 := PWideChar(Buffer[AIndex]) + ASize;
                for i := ASize to FValue_char_sz - 1 do begin
                  pUTF16^ := ' ';
                  Inc(pUTF16);
                end;
              end;
              if ByteSemantic then
                ASize := ASize * SizeOf(WideChar);
              FBindData^.FALen[AIndex] := ub2(ASize);
            end;
          end;
        end;
      otDateTime:
        begin
          DateTime2OraDate(Buffer[AIndex], PDateTimeRec(ABuff)^);
          FBindData^.FALen[AIndex] := SizeOf(TOraDate);
        end;
      otBoolean:
        begin
          if PWordBool(ABuff)^ then
            PInteger(Buffer[AIndex])^ := 1
          else
            PInteger(Buffer[AIndex])^ := 0;
          FBindData^.FALen[AIndex] := SizeOf(LongBool);
        end;
    else
      if DataType >= otCursor then begin
        if ppOCIHandle(ABuff)^ <> nil then begin
          ppOCIHandle(Buffer[AIndex])^ := ppOCIHandle(ABuff)^;
          FBindData^.FALen[AIndex] := ub2(SizeOf(pOCIHandle));
          UpdateHValueNullInd(AIndex);
        end;
      end
      else
        ASSERT(False);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TOCIVariable.UpdateHValueNullInd(AIndex: ub4): Boolean;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobLocatorIsInit, []);
  end;
{$ENDIF}
var
  init: LongBool;
begin
  if (DataType >= otCLOB) and (DataType <= otBFile) then
    if ppOCIHandle(Buffer[AIndex])^ = nil then
      FBindData^.FInd[AIndex] := -1
    else begin
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then ProcTrace;
{$ENDIF}
      init := False;
      Check(Env.Lib.OCILobLocatorIsInit(Env.Handle, Env.Error.FHandle,
        ppOCIHandle(Buffer[AIndex])^, init));
      if not init then
        FBindData^.FInd[AIndex] := -1
      else
        FBindData^.FInd[AIndex] := 0;
    end;
  Result := (FBindData^.FInd[AIndex] = 0);
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.SetIsNull(AIndex: ub4; AIsNull: Boolean);
begin
  ASSERT(AIndex < FMaxArr_len);
  ASSERT(FBindData <> nil);
  if AIsNull then
    FBindData^.FInd[AIndex] := -1
  else
    FBindData^.FInd[AIndex] := 0;
end;

{-------------------------------------------------------------------------------}
procedure TOCIVariable.AppendData(AIndex: ub4; ABuff: pUb1; ASize: ub4);
begin
  ASSERT(AIndex < FMaxArr_len);
  ASSERT(LongData);
  ASSERT(FBindData <> nil);
  AppendLong(PLongData(Buffer[AIndex]), ABuff, ASize);
  FBindData^.FInd[AIndex] := 0;
  FBindData^.FALen[AIndex] := ub2(SizeOf(TLongData));
end;

{-------------------------------------------------------------------------------}
function TOCIVariable.GetData(AIndex: ub4; ABuff: pUb1; out ASize: ub4): Boolean;
begin
  Result := GetData(AIndex, ABuff, ASize, False);
end;

{-------------------------------------------------------------------------------}
function TOCIVariable.GetAsString: String;
var
  p: pUb1;
  sz: ub4;
begin
  Result := '';
  p := nil;
  sz := 0;
  if GetData(0, p, sz, True) then
    case DataType of
    otString, otChar, otLong:
      Result := Env.DataEncoder.Decode(p, sz, ecANSI);
    otNString, otNChar, otNLong:
      Result := Env.DataEncoder.Decode(p, sz, ecUTF16);
    else
      ASSERT(False);
    end;
end;

{-------------------------------------------------------------------------------}
function TOCIVariable.GetAsInteger: Integer;
var
  p: pUb1;
  sz: ub4;
begin
  Result := 0;
  p := nil;
  sz := 0;
  if GetData(0, p, sz, True) then
    case DataType of
    otInt32:
      Result := PInteger(p)^;
    otUInt32:
      Result := PCardinal(p)^;
    otInt64:
      Result := PInt64(p)^;
    otUInt64:
      Result := PUInt64(p)^;
    else
      ASSERT(False);
    end;
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
function TOCIVariable.DumpValue(AIndex: ub4): String;
var
  p: pUb1;
  sz: ub4;
  rBCD: TBcd;
  iLen: Integer;
  buff: array [0..127] of Char;
  d: TDateTimeRec;
  rTS: TSQLTimeStamp;
begin
  p := nil;
  sz := 0;
  if not GetData(AIndex, p, sz, True) then
    Result := 'NULL'
  else
    case DataType of
      otString, otChar, otLong:
        if sz > 1024 then
          Result := '(truncated at 1024) ''' + TFDEncoder.Deco(p, 1024, Env.DataEncoder.Encoding) + ' ...'''
        else
          Result := '''' + TFDEncoder.Deco(p, sz, Env.DataEncoder.Encoding) + '''';
      otNString, otNChar, otNLong:
        if sz > 1024 then begin
          SetString(Result, PWideChar(p), 1024);
          Result := '(truncated at 1024) ''' + Result + ' ...''';
        end
        else begin
          SetString(Result, PWideChar(p), sz);
          Result := '''' + Result + '''';
        end;
      otROWID:
        Result := TFDEncoder.Deco(p, sz, Env.DataEncoder.Encoding);
      otNumber:
        begin
          OraNumber2Bcd(pOCINumber(p), rBCD);
          FDBCD2Str(buff, iLen, rBCD, '.');
          SetString(Result, buff, iLen);
        end;
      otRaw, otLongRaw:
        if sz > 512 then
          Result := '(truncated at 512) ' + FDBin2Hex(p, 512) + ' ...'
        else
          Result := FDBin2Hex(p, sz);
      otInt32:
        Result := IntToStr(PInteger(p)^);
      otUInt32:
        Result := IntToStr(PCardinal(p)^);
      otInt64:
        Result := IntToStr(PInt64(p)^);
      otUInt64:
        Result := IntToStr(PUInt64(p)^);
      otSingle:
        Result := FDFloat2Str(PSingle(p)^, '.');
      otDouble:
        Result := FDFloat2Str(PDouble(p)^, '.');
      otDateTime:
        begin
          OraDate2DateTime(p, d);
          rTS := DateTimeToSQLTimeStamp(FDMSecs2DateTime(d.DateTime));
          Result := Format('%.4d-%.2d-%.2d %.2d:%.2d:%.2d.%.3d',
            [rTS.Year, rTS.Month, rTS.Day, rTS.Hour, rTS.Minute, rTS.Second, rTS.Fractions]);
        end;
      otBoolean:
        Result := BoolToStr(PWordBool(p)^, True);
      else
        if DataType >= otCursor then
          Result := '<HANDLE> $' + IntToHex(PInteger(p)^, 8)
        else
          ASSERT(False);
    end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TOCIDescriptor                                                                }
{-------------------------------------------------------------------------------}
constructor TOCIDescriptor.CreateUsingHandle(AEnv: TOCIEnv; AHandle: pOCIDescriptor);
begin
  inherited Create(AEnv);
  FHandle := AHandle;
  FOwnHandle := False;
end;

{-------------------------------------------------------------------------------}
procedure TOCIDescriptor.Init(AType: ub4);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIDescriptorAlloc, ['@HKind', hndlNames[AType]]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIDescriptorAlloc(Env.FHandle, FHandle, AType, 0, nil));
  FType := AType;
end;

{-------------------------------------------------------------------------------}
destructor TOCIDescriptor.Destroy;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIDescriptorFree, ['@HKind', hndlNames[FType], 'HVal', FHandle]);
  end;
{$ENDIF}
begin
  if (FHandle <> nil) and OwnHandle then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then ProcTrace;
{$ENDIF}
    Check(Env.Lib.OCIDescriptorFree(FHandle, FType));
    FHandle := nil;
  end;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
{ TOCISelectItem                                                                }
{-------------------------------------------------------------------------------}
constructor TOCISelectItem.Create(AOwner: TOCIHandle; AService: TOCIService);
begin
  inherited Create(AOwner.Env);
  FOwner := AOwner;
  FOwningObj := AOwner.OwningObj;
  FService := AService;
  FType := OCI_DTYPE_PARAM;
  FOwnHandle := False;
  InitFields;
end;

{-------------------------------------------------------------------------------}
constructor TOCISelectItem.Create(AOwner: TOCIHandle; AService: TOCIService;
  APosition: sb4);
begin
  Create(AOwner, AService);
  Position := APosition;
  Bind;
end;

{-------------------------------------------------------------------------------}
procedure TOCISelectItem.InitFields;
begin
  FDATA_TYPE := $FFFFFFFF;
  FDATA_SIZE := $FFFFFFFF;
  FPRECISION := $FFFFFFFF;
  FSCALE_ := $FFFFFFFF;
  FCHARSET_FORM := $FF;
  FCHAR_SIZE := $FFFF;
  FDataType := otUnknown;
end;

{-------------------------------------------------------------------------------}
procedure TOCISelectItem.Bind;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIParamGet, ['Pos', FPosition]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIParamGet(FOwner.FHandle, OCI_HTYPE_STMT, Env.Error.FHandle,
    FHandle, FPosition));
  InitFields;
end;

{-------------------------------------------------------------------------------}
function TOCISelectItem.GetPRECISION: ub4;
begin
  if FPRECISION = $FFFFFFFF then
    FPRECISION := GetUb4Attr(OCI_ATTR_PRECISION);
  Result := FPRECISION;
end;

{-------------------------------------------------------------------------------}
function TOCISelectItem.GetSCALE: ub4;
begin
  if FSCALE_ = $FFFFFFFF then
    FSCALE_ := GetUb4Attr(OCI_ATTR_SCALE);
  Result := FSCALE_;
end;

{-------------------------------------------------------------------------------}
function TOCISelectItem.GetDATA_SIZE: ub4;
begin
  if FDATA_SIZE = $FFFFFFFF then
    FDATA_SIZE := GetUb4Attr(OCI_ATTR_DATA_SIZE);
  Result := FDATA_SIZE;
end;

{-------------------------------------------------------------------------------}
function TOCISelectItem.GetDATA_TYPE: ub4;
begin
  if FDATA_TYPE = $FFFFFFFF then
    FDATA_TYPE := GetUb4Attr(OCI_ATTR_DATA_TYPE);
  Result := FDATA_TYPE;
end;

{-------------------------------------------------------------------------------}
function TOCISelectItem.GetCHARSET_FORM: ub1;
begin
  if FCHARSET_FORM = $FF then
    FCHARSET_FORM := GetUb1Attr(OCI_ATTR_CHARSET_FORM);
  Result := FCHARSET_FORM;
end;

{-------------------------------------------------------------------------------}
function TOCISelectItem.GetCHAR_SIZE: ub2;
begin
  if FCHAR_SIZE = $FFFF then
    FCHAR_SIZE := GetUb2Attr(OCI_ATTR_CHAR_SIZE);
  Result := FCHAR_SIZE;
end;

{-------------------------------------------------------------------------------}
function TOCISelectItem.GetIsUnicode: Boolean;
begin
  Result := (CHARSET_FORM in [SQLCS_NCHAR, SQLCS_EXPLICIT]) or
    (FOwner.Env.DataEncoder.Encoding in [ecUTF8, ecUTF16]);
end;

{-------------------------------------------------------------------------------}
function TOCISelectItem.GetDataType: TOCIVarDataType;
begin
  if FDataType = otUnknown then
    case DATA_TYPE of
    SQLT_CHR,
    SQLT_VCS:
      if IsUnicode then
        FDataType := otNString
      else
        FDataType := otString;
    SQLT_NUM:
      if (sb1(SCALE) = -127) and (sb2(PRECISION) > 0) then
        FDataType := otDouble
      else
        FDataType := otNumber;
    SQLT_INT,
    _SQLT_PLI:
      FDataType := otInt32;
    SQLT_UIN:
      FDataType := otUInt32;
    SQLT_LNG:
      if IsUnicode then
        FDataType := otNLong
      else
        FDataType := otLong;
    SQLT_RID,
    SQLT_RDD:
      FDataType := otROWID;
    SQLT_DAT:
      FDataType := otDateTime;
    SQLT_BIN:
      FDataType := otRaw;
    SQLT_LBI:
      FDataType := otLongRaw;
    SQLT_AFC:
      if IsUnicode then
        FDataType := otNChar
      else
        FDataType := otChar;
    SQLT_CLOB:
      if IsUnicode then
        FDataType := otNCLOB
      else
        FDataType := otCLOB;
    SQLT_BLOB:
      FDataType := otBLOB;
    SQLT_BFILEE:
      FDataType := otBFile;
    SQLT_CFILEE:
      FDataType := otCFile;
    SQLT_CUR:
      FDataType := otCursor;          // used in PL/SQL, maps to REF CURSOR
    SQLT_RSET:
      FDataType := otNestedDataSet;   // used in SQL, maps to SELECT CURSOR(SELECT ...)
    SQLT_TIMESTAMP,
    SQLT_TIMESTAMP_TZ,
    SQLT_TIMESTAMP_LTZ:
      FDataType := otTimeStamp;
    SQLT_INTERVAL_YM:
      FDataType := otIntervalYM;
    SQLT_INTERVAL_DS:
      FDataType := otIntervalDS;
    SQLT_IBFLOAT:
      FDataType := otSingle;
    SQLT_IBDOUBLE:
      FDataType := otDouble;
    SQLT_BOL:
      FDataType := otBoolean;
    end;
  Result := FDataType;
end;

{-------------------------------------------------------------------------------}
function TOCISelectItem.GetBytesPerChar: ub1;
begin
  Result := $FF;
  if Env.Lib.Version >= cvOracle90000 then
    if CHAR_SIZE <> 0 then
      Result := ub1(DATA_SIZE div CHAR_SIZE);
  if Result = $FF then
    Result := FService.BytesPerChar;
  if (Result = 0) or (Result = $FF) then
    Result := 1;
end;

{-------------------------------------------------------------------------------}
function TOCISelectItem.GetCharSize: ub2;
begin
  if Env.Lib.Version >= cvOracle90000 then
    Result := CHAR_SIZE
  else if (DATA_TYPE in [SQLT_CHR, SQLT_VCS, SQLT_LNG, SQLT_AFC]) and
          (CHARSET_FORM <= SQLCS_IMPLICIT) then
    Result := DATA_SIZE
  else
    Result := ub2(DATA_SIZE div BytesPerChar);
end;

{-------------------------------------------------------------------------------}
function TOCISelectItem.GetDataSize: ub4;
var
  dt: TOCIVarDataType;
begin
  dt := DataType;
  if dt in [otString, otChar, otNString, otNChar, otRaw, otLong, otNLong, otLongRaw] then
    Result := DATA_SIZE
  else
    Result := nc2ociValueSize[dt];
  if (dt in [otNString, otNChar, otNLong]) and (Result < CharSize * SizeOf(WideChar)) then
    Result := CharSize * SizeOf(WideChar);
end;

{-------------------------------------------------------------------------------}
function TOCISelectItem.GetColumnSize: ub4;
var
  dt: TOCIVarDataType;
begin
  dt := DataType;
  if dt in [otNChar, otNString, otNLong, otChar, otString, otLong] then
    Result := CharSize
  else
    Result := DataSize;
end;

{-------------------------------------------------------------------------------}
function TOCISelectItem.GetDataPrecision: sb4;
begin
  if DATA_TYPE = SQLT_NUM then begin
    Result := PRECISION;
    if Result = 0 then
      Result := 38;
  end
  else
    Result := 0;
end;

{-------------------------------------------------------------------------------}
function TOCISelectItem.GetDataScale: sb4;
begin
  case DATA_TYPE of
  SQLT_NUM:
    if (PRECISION = 0) and (SCALE = 0) then
      Result := 38
    else begin
      Result := SCALE;
      if sb1(Result) = -127 then
        if PRECISION > 0 then
          Result := 0
        else
          Result := 38;
    end;
  SQLT_TIMESTAMP,
  SQLT_TIMESTAMP_TZ,
  SQLT_TIMESTAMP_LTZ:
    Result := SCALE;
  else
    Result := 0;
  end;
end;

{-------------------------------------------------------------------------------}
function TOCISelectItem.GetVarType: TOCIVarType;
begin
  Result := odUnknown;
  case IOMODE of
  OCI_TYPEPARAM_OUT: Result := odOut;
  OCI_TYPEPARAM_IN: Result := odIn;
  OCI_TYPEPARAM_INOUT: Result := odInOut;
  end;
end;

{-------------------------------------------------------------------------------}
function TOCISelectItem.GetIsNull: Boolean;
begin
  Result := (IS_NULL <> 0);
end;

{-------------------------------------------------------------------------------}
function TOCISelectItem.GetColProperties: ub8;
begin
  if Env.Lib.Version >= cvOracle120000 then
    Result := COL_PROPERTIES
  else
    Result := 0;
end;

{-------------------------------------------------------------------------------}
{ TOCILobLocator                                                                }
{-------------------------------------------------------------------------------}
constructor TOCILobLocator.Create(AService: TOCIService; AType: ub4);
begin
  inherited Create(AService.Env);
  FOwner := AService;
  Init(AType);
  FOwnHandle := True;
  FCharsetForm := 0;
end;

{-------------------------------------------------------------------------------}
constructor TOCILobLocator.CreateUsingHandle(AService: TOCIService; AHandle: pOCIHandle);
begin
  inherited Create(AService.Env);
  FOwner := AService;
  FHandle := AHandle;
  FOwnHandle := False;
  FCharsetForm := 0;
end;

{-------------------------------------------------------------------------------}
destructor TOCILobLocator.Destroy;
begin
  if FOpened then
    Close;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TOCILobLocator.Assign(AFrom: TOCILobLocator);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobAssign, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCILobAssign(Env.Handle, Env.Error.FHandle,
    AFrom.FHandle, FHandle));
end;

{-------------------------------------------------------------------------------}
procedure TOCILobLocator.Close;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace1;
  begin
    Trace(sOCILobClose, []);
  end;
  procedure ProcTrace2;
  begin
    Trace(sOCILobFileClose, []);
  end;
{$ENDIF}
begin
  FOpened := False;
  if Env.Lib.Version >= cvOracle81000 then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then ProcTrace1;
{$ENDIF}
    Check(Env.Lib.OCILobClose(FOwner.FHandle, Env.Error.FHandle, FHandle));
  end
  else if FType = OCI_DTYPE_FILE then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then ProcTrace2;
{$ENDIF}
    Check(Env.Lib.OCILobClose(FOwner.FHandle, Env.Error.FHandle, FHandle));
  end;
end;

{-------------------------------------------------------------------------------}
function TOCILobLocator.GetLength: sb4;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobGetLength, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Result := 0;
  Check(Env.Lib.OCILobGetLength(FOwner.FHandle, Env.Error.FHandle, FHandle, ub4(Result)));
end;

{-------------------------------------------------------------------------------}
function TOCILobLocator.GetIsOpen: LongBool;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace1;
  begin
    Trace(sOCILobIsOpen, []);
  end;
  procedure ProcTrace2;
  begin
    Trace(sOCILobFileIsOpen, []);
  end;
{$ENDIF}
begin
  Result := False;
  if Env.Lib.Version >= cvOracle81000 then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then ProcTrace1;
{$ENDIF}
    Check(Env.Lib.OCILobIsOpen(FOwner.FHandle, Env.Error.FHandle, FHandle, Result));
  end
  else if FType = OCI_DTYPE_FILE then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then ProcTrace2;
{$ENDIF}
    Check(Env.Lib.OCILobIsOpen(FOwner.FHandle, Env.Error.FHandle, FHandle, Result));
  end
  else
    Result := True;
end;

{-------------------------------------------------------------------------------}
function TOCILobLocator.GetIsInit: LongBool;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobLocatorIsInit, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Result := False;
  Check(Env.Lib.OCILobLocatorIsInit(Env.Handle, Env.Error.FHandle,
    FHandle, Result));
end;

{-------------------------------------------------------------------------------}
procedure TOCILobLocator.CheckCharsetForm;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobCharSetForm, []);
  end;
{$ENDIF}
begin
  if FCharsetForm = 0 then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then ProcTrace;
{$ENDIF}
    Check(Env.Lib.OCILobCharSetForm(Env.Handle, Env.Error.FHandle,
      FHandle, FCharsetForm));
  end;
end;

{-------------------------------------------------------------------------------}
function TOCILobLocator.Read(ABuff: pUb1; amount: ub4; offset: ub4): ub4;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobRead, []);
  end;
{$ENDIF}

  function Chars2Bytes(AChars: ub4): ub4;
  begin
    if National then
      Result := AChars * SizeOf(WideChar)
    else
      Result := AChars * SizeOf(TFDAnsiChar);
  end;

var
  uiByteLen: ub4;
  csid: ub2;
  iRes: sword;
  pBuff: pUb1;
  iRead, iReadBytes, iTotal: ub4;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  CheckCharsetForm;
  if National then
    csid := OCI_UTF16ID
  else
    csid := Env.ExplicitCharsetID;
  uiByteLen := Chars2Bytes(amount);
  pBuff := ABuff;
  iTotal := amount;
  Result := 0;
  iRes := OCI_SUCCESS;
  while iTotal > 0 do begin
    iRead := iTotal;
    iRes := Env.Lib.OCILobRead(FOwner.FHandle, Env.Error.FHandle, FHandle,
      iRead, offset, pBuff, uiByteLen, nil, nil, csid, FCharsetForm);
    Dec(iTotal, iRead);
    Inc(Result, iRead);
    if iRes <> OCI_NEED_DATA then
      Break;
    iReadBytes := Chars2Bytes(iRead);
    pBuff := pUb1(PByte(pBuff) + iReadBytes);
    Dec(uiByteLen, iReadBytes);
  end;
  if not ((iRes = OCI_SUCCESS) or (iRes = OCI_NEED_DATA)) then
    Check(iRes);
end;

{-------------------------------------------------------------------------------}
procedure TOCILobLocator.Open(AReadOnly: Boolean);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace1;
  begin
    Trace(sOCILobOpen, []);
  end;
  procedure ProcTrace2;
  begin
    Trace(sOCILobFileOpen, []);
  end;
{$ENDIF}
const
  bool2mode: array[Boolean] of ub1 = (OCI_LOB_READWRITE, OCI_LOB_READONLY);
begin
  if Env.Lib.Version >= cvOracle81000 then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then ProcTrace1;
{$ENDIF}
    Check(Env.Lib.OCILobOpen(FOwner.FHandle, Env.Error.FHandle, FHandle,
      bool2mode[AReadOnly]));
  end
  else if FType = OCI_DTYPE_FILE then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then ProcTrace2;
{$ENDIF}
    Check(Env.Lib.OCILobOpen(FOwner.FHandle, Env.Error.FHandle, FHandle,
      OCI_LOB_READONLY));
  end;
  FOpened := True;
end;

{-------------------------------------------------------------------------------}
{ TOCIIntLocator                                                                }
{-------------------------------------------------------------------------------}
constructor TOCIIntLocator.CreateUsingHandle(AService: TOCIService; AHandle: pOCIHandle);
begin
  inherited CreateUsingHandle(AService, AHandle);
  FType := OCI_DTYPE_LOB;
end;

{-------------------------------------------------------------------------------}
procedure TOCIIntLocator.Append(AFrom: TOCIIntLocator);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobAppend, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCILobAppend(FOwner.FHandle, Env.Error.FHandle, FHandle, AFrom.FHandle));
end;

{-------------------------------------------------------------------------------}
procedure TOCIIntLocator.Copy(AFrom: TOCIIntLocator; amount, dst_offset, src_offset: ub4);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobCopy, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCILobCopy(FOwner.FHandle, Env.Error.FHandle, FHandle, AFrom.FHandle,
    amount, dst_offset, src_offset));
end;

{-------------------------------------------------------------------------------}
procedure TOCIIntLocator.SetBuffering(const Value: Boolean);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace1;
  begin
    Trace(sOCILobEnableBuffering, []);
  end;
  procedure ProcTrace2;
  begin
    Trace(sOCILobDisableBuffering, []);
  end;
{$ENDIF}
begin
  if FBuffering <> Value then begin
    FBuffering := Value;
    if FBuffering then begin
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then ProcTrace1;
{$ENDIF}
      Check(Env.Lib.OCILobEnableBuffering(FOwner.FHandle, Env.Error.FHandle, FHandle));
    end
    else begin
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then ProcTrace2;
{$ENDIF}
      Check(Env.Lib.OCILobDisableBuffering(FOwner.FHandle, Env.Error.FHandle, FHandle));
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIIntLocator.Erase(var amount: ub4; offset: ub4);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobErase, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCILobErase(FOwner.FHandle, Env.Error.FHandle, FHandle, amount, offset));
end;

{-------------------------------------------------------------------------------}
procedure TOCIIntLocator.FlushBuffer;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobFlushBuffer, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCILobFlushBuffer(FOwner.FHandle, Env.Error.FHandle, FHandle,
    OCI_LOB_BUFFER_NOFREE));
end;

{-------------------------------------------------------------------------------}
procedure TOCIIntLocator.LoadFromFile(AFrom: TOCIExtLocator; amount, dst_offset, src_offset: ub4);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobLoadFromFile, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCILobLoadFromFile(FOwner.FHandle, Env.Error.FHandle, FHandle,
    AFrom.FHandle, amount, dst_offset, src_offset));
end;

{-------------------------------------------------------------------------------}
procedure TOCIIntLocator.Trim(ANewLen: ub4);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobTrim, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCILobTrim(FOwner.FHandle, Env.Error.FHandle, FHandle, ANewLen));
end;

{-------------------------------------------------------------------------------}
function TOCIIntLocator.Write(ABuff: pUb1; amount: ub4; offset: ub4): ub4;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobWrite, []);
  end;
{$ENDIF}
var
  uiByteLen: ub4;
  csid: ub2;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  CheckCharSetForm;
  if National then begin
    uiByteLen := amount * SizeOf(WideChar);
    csid := OCI_UTF16ID;
  end
  else begin
    uiByteLen := amount * SizeOf(TFDAnsiChar);
    csid := Env.ExplicitCharsetID;
  end;
  Check(Env.Lib.OCILobWrite(FOwner.FHandle, Env.Error.FHandle, FHandle, amount,
    offset, ABuff, uiByteLen, OCI_ONE_PIECE, nil, nil, csid, FCharsetForm));
  Result := amount;
end;

{-------------------------------------------------------------------------------}
function TOCIIntLocator.GetIsTemporary: LongBool;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobIsTemporary, []);
  end;
{$ENDIF}
begin
  if Env.Lib.Version < cvOracle81000 then begin
    Result := False;
    Exit;
  end;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCILobIsTemporary(FOwner.FHandle, Env.Error.FHandle,
    FHandle, Result));
end;

{-------------------------------------------------------------------------------}
constructor TOCITempLocator.CreateTemp(AService: TOCIService; ALobType: ub1; ACache: Boolean);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobCreateTemporary, []);
  end;
{$ENDIF}
var
  csid: ub2;
begin
  if Env.Lib.Version < cvOracle81000 then
    FDCapabilityNotSupported(Self, [S_FD_LPhys, S_FD_OraId]);
  inherited Create(AService, OCI_DTYPE_LOB);
  FNational := (ALobType = OCI_TEMP_NCLOB);
  FBuffering := ACache;
  if National then begin
    FCharsetForm := SQLCS_NCHAR;
    csid := OCI_UTF16ID;
  end
  else begin
    FCharsetForm := SQLCS_IMPLICIT;
    csid := Env.ExplicitCharsetID;
  end;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCILobCreateTemporary(FOwner.FHandle, Env.Error.FHandle,
    FHandle, csid, FCharsetForm, ALobType, ACache, OCI_DURATION_SESSION));
end;

{-------------------------------------------------------------------------------}
destructor TOCITempLocator.Destroy;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobFreeTemporary, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCILobFreeTemporary(FOwner.FHandle, Env.Error.FHandle, FHandle));
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
{ TOCIExtLocator                                                                }
{-------------------------------------------------------------------------------}
constructor TOCIExtLocator.CreateUsingHandle(AService: TOCIService; AHandle: pOCIHandle);
begin
  inherited CreateUsingHandle(AService, AHandle);
  FType := OCI_DTYPE_FILE;
end;

{-------------------------------------------------------------------------------}
function TOCIExtLocator.GetFileExists: LongBool;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobFileExists, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Result := False;
  Check(Env.Lib.OCILobFileExists(FOwner.FHandle, Env.Error.FHandle, FHandle, Result));
end;

{-------------------------------------------------------------------------------}
procedure TOCIExtLocator.GetFileDir(var ADir, AFileName: String);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobFileGetName, []);
  end;
{$ENDIF}
var
  sbDir, sbFile: TFDByteString;
  dirLen, fileLen: ub2;
begin
  dirLen := 30;
  fileLen := 255;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  SetLength(sbDir, dirLen);
  SetLength(sbFile, fileLen);
  Check(Env.Lib.OCILobFileGetName(FOwner.FOwner.FHandle, Env.Error.FHandle,
    FHandle, PByte(sbDir), dirLen, PByte(sbFile), fileLen));
  SetLength(sbDir, dirLen);
  SetLength(sbFile, fileLen);
  ADir := Env.MetaEncoder.Decode(sbDir);
  AFileName := Env.MetaEncoder.Decode(sbFile);
end;

{-------------------------------------------------------------------------------}
procedure TOCIExtLocator.SetFileDir(const ADir, AFileName: String);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCILobFileSetName, []);
  end;
{$ENDIF}
var
  sbDir, sbFileName: TFDByteString;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  sbDir := Env.MetaEncoder.Encode(ADir);
  sbFileName := Env.MetaEncoder.Encode(AFileName);
  Check(Env.Lib.OCILobFileSetName(Env.Handle, Env.Error.FHandle, FHandle,
    PByte(sbDir), ub2(Env.MetaEncoder.EncodedLength(sbDir)),
    PByte(sbFileName), ub2(Env.MetaEncoder.EncodedLength(sbFileName))));
end;

{-------------------------------------------------------------------------------}
function TOCIExtLocator.GetDirectory: String;
var
  AFileName: String;
begin
  AFileName := '';
  Result := '';
  GetFileDir(Result, AFileName);
end;

{-------------------------------------------------------------------------------}
function TOCIExtLocator.GetFileName: String;
var
  sDir: String;
begin
  sDir  := '';
  Result := '';
  GetFileDir(sDir, Result);
end;

{-------------------------------------------------------------------------------}
procedure TOCIExtLocator.SetDirectory(const Value: String);
begin
  SetFileDir(Value, FileName);
end;

{-------------------------------------------------------------------------------}
procedure TOCIExtLocator.SetFileName(const Value: String);
begin
  SetFileDir(Directory, Value);
end;

{-------------------------------------------------------------------------------}
{ TOCILobLocatorStream                                                          }
{-------------------------------------------------------------------------------}
constructor TOCILobLocatorStream.Create(ALocator: TOCILobLocator; AOwningObj: TObject);
begin
  inherited Create;
  FLocator := ALocator;
  FOffset := 0;
  FOwningObj := AOwningObj;
end;

{-------------------------------------------------------------------------------}
destructor TOCILobLocatorStream.Destroy;
begin
  FDFreeAndNil(FLocator);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TOCILobLocatorStream.Bytes2Chars(ABytes: ub4): ub4;
begin
  if FLocator.National then
    Result := ABytes div SizeOf(WideChar)
  else
    Result := ABytes div SizeOf(TFDAnsiChar);
end;

{-------------------------------------------------------------------------------}
function TOCILobLocatorStream.Chars2Bytes(AChars: ub4): ub4;
begin
  if FLocator.National then
    Result := AChars * SizeOf(WideChar)
  else
    Result := AChars * SizeOf(TFDAnsiChar);
end;

{-------------------------------------------------------------------------------}
function TOCILobLocatorStream.Read(var Buffer; Count: Longint): Longint;
begin
  Result := Chars2Bytes(FLocator.Read(pUb1(@Buffer),
    Bytes2Chars(Count), Bytes2Chars(FOffset + 1)));
  Inc(FOffset, Result);
end;

{-------------------------------------------------------------------------------}
function TOCILobLocatorStream.Write(const Buffer; Count: Longint): Longint;
begin
  if FLocator is TOCIIntLocator then
    Result := Chars2Bytes(TOCIIntLocator(FLocator).Write(pUb1(@Buffer),
      Bytes2Chars(Count), Bytes2Chars(FOffset + 1)))
  else
    Result := 0;
  Inc(FOffset, Result);
end;

{-------------------------------------------------------------------------------}
function TOCILobLocatorStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  case Origin of
  soBeginning: FOffset := Offset;
  soCurrent:   FOffset := FOffset + Offset;
  soEnd:       FOffset := FLocator.Length - Offset - 1;
  end;
  Result := FOffset;
end;

{-------------------------------------------------------------------------------}
function TOCILobLocatorStream.GetSize: Int64;
begin
  Result := Chars2Bytes(FLocator.Length);
end;

{-------------------------------------------------------------------------------}
procedure TOCILobLocatorStream.SetSize(const NewSize: Int64);
var
  iLen: sb4;
  iAmount: ub4;
begin
  if FLocator is TOCIIntLocator then begin
    iLen := Chars2Bytes(FLocator.Length);
    if NewSize < iLen then
      TOCIIntLocator(FLocator).Trim(Bytes2Chars(NewSize))
    else begin
      iAmount := Bytes2Chars(iLen - NewSize);
      TOCIIntLocator(FLocator).Erase(iAmount, Bytes2Chars(iLen + 1));
    end;
  end;
end;

{-------------------------------------------------------------------------------}
{ TOCIDescribe                                                                  }
{-------------------------------------------------------------------------------}
constructor TOCIDescribe.Create(ASvc: TOCIService);
begin
  inherited Create(ASvc.Env);
  FOwner := ASvc;
  Init(OCI_HTYPE_DESCRIBE);
  FStack := TFDPtrList.Create;
  FCurr := TOCIHandle.Create(ASvc.Env);
  FCurr.FOwner := FOwner;
  FCurr.FType := OCI_DTYPE_PARAM;
end;

{-------------------------------------------------------------------------------}
destructor TOCIDescribe.Destroy;
begin
  FDFreeAndNil(FStack);
  FCurr.FHandle := nil;
  FDFreeAndNil(FCurr);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TOCIDescribe.DescribeName(const AName: String);

  function InternalDescribeName(const AName: String): sb4;
{$IFDEF FireDAC_MONITOR}
    procedure ProcTrace;
    begin
      Trace(sOCIDescribeAny, ['Name', AName]);
    end;
{$ENDIF}
  var
    sbName: TFDByteString;
  begin
    repeat
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then ProcTrace;
{$ENDIF}
      sbName := Env.MetaEncoder.Encode(AName);
      Result := Env.Lib.OCIDescribeAny(FOwner.FHandle, Env.Error.FHandle,
        PByte(sbName), Env.MetaEncoder.EncodedLength(sbName), OCI_OTYPE_NAME,
        0, OCI_PTYPE_UNK, FHandle);
      if Result = OCI_STILL_EXECUTING then
        TOCIService(FOwner).DoYield;
    until Result <> OCI_STILL_EXECUTING;
  end;

var
  oEx: EOCINativeException;
  res: sb4;
begin
  res := InternalDescribeName(AName);
  if res = OCI_ERROR then begin
    oEx := EOCINativeException.Create(Env.Error);
    res := InternalDescribeName('"PUBLIC".' + AName);
    if (res <> OCI_SUCCESS) and (res <> OCI_SUCCESS_WITH_INFO) then
      raise oEx
    else
      FDFree(oEx);
  end;
  Check(res);
  FCurr.FHandle := GetHandleAttr(OCI_ATTR_PARAM);
end;

{-------------------------------------------------------------------------------}
function TOCIDescribe.OpenList(AAtrType: Integer): ub4;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIAttrGet, ['@VType', 'ub4', 'AType', 'OCI_ATTR_NUM_PARAMS']);
  end;
{$ENDIF}
begin
  FStack.Add(FCurr.FHandle);
  FStack.Add(FCurr.GetHandleAttr(AAtrType));
  Result := 0;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIAttrGet(FStack.Last, OCI_DTYPE_PARAM, @Result, nil,
    OCI_ATTR_NUM_PARAMS, Env.Error.FHandle));
end;

{-------------------------------------------------------------------------------}
procedure TOCIDescribe.CloseList;
begin
  FCurr.FHandle := FStack.Items[FStack.Count - 2];
  FStack.Delete(FStack.Count - 1);
  FStack.Delete(FStack.Count - 1);
end;

{-------------------------------------------------------------------------------}
function TOCIDescribe.GetIsListOpened: Boolean;
begin
  Result := FStack.Count > 0;
end;

{-------------------------------------------------------------------------------}
procedure TOCIDescribe.GoToItem(AIndex: Integer);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIParamGet, ['Index', AIndex]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIParamGet(FStack.Last, OCI_DTYPE_PARAM, Env.Error.FHandle,
    FCurr.FHandle, AIndex));
end;

{-------------------------------------------------------------------------------}
function TOCIDescribe.GetSelectItem(AIndex: Integer): TOCISelectItem;
begin
  try
    GoToItem(AIndex);
  except on E: EOCINativeException do
    // ORA-24334: no descriptor for this position
    if (E.ErrorCount > 0) and (E.Errors[0].ErrorCode = 24334) then begin
      Result := nil;
      Exit;
    end
    else
      raise;
  end;
  Result := TOCISelectItem.Create(FOwner, TOCIService(FOwner));
  Result.FHandle := FCurr.FHandle;
end;

{-------------------------------------------------------------------------------}
function TOCIDescribe.GetPtr(AIndex: Integer): Pointer;
begin
  Result := FCurr.GetHandleAttr(AIndex);
end;

{-------------------------------------------------------------------------------}
function TOCIDescribe.GetSB1(AIndex: Integer): sb1;
begin
  Result := FCurr.GetSB1Attr(AIndex);
end;

{-------------------------------------------------------------------------------}
function TOCIDescribe.GetText(AIndex: Integer): String;
begin
  Result := FCurr.GetStringAttr(AIndex);
end;

{-------------------------------------------------------------------------------}
function TOCIDescribe.GetUB1(AIndex: Integer): ub1;
begin
  Result := FCurr.GetUB1Attr(AIndex);
end;

{-------------------------------------------------------------------------------}
function TOCIDescribe.GetUB2(AIndex: Integer): ub2;
begin
  Result := FCurr.GetUB2Attr(AIndex);
end;

{-------------------------------------------------------------------------------}
function TOCIDescribe.GetUB4(AIndex: Integer): ub4;
begin
  Result := FCurr.GetUB4Attr(AIndex);
end;

{-------------------------------------------------------------------------------}
{ TOCIDirectPath                                                                }
{-------------------------------------------------------------------------------}
constructor TOCIDirectPath.Create(ASvc: TOCIService);
begin
  inherited Create(ASvc.Env);
  FOwner := ASvc;
  Init(OCI_HTYPE_DIRPATH_CTX);
end;

{-------------------------------------------------------------------------------}
procedure TOCIDirectPath.AbortJob;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIDirPathAbort, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIDirPathAbort(Handle, Env.Error.Handle));
end;

{-------------------------------------------------------------------------------}
procedure TOCIDirectPath.Finish;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIDirPathFinish, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIDirPathFinish(Handle, Env.Error.Handle));
end;

{-------------------------------------------------------------------------------}
procedure TOCIDirectPath.Prepare;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIDirPathPrepare, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIDirPathPrepare(Handle, FOwner.Handle, Env.Error.Handle));
end;

{-------------------------------------------------------------------------------}
procedure TOCIDirectPath.LoadStream(AStream: TOCIDirectPathStream);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIDirPathLoadStream, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIDirPathLoadStream(Handle, AStream.Handle, Env.Error.Handle));
end;

{-------------------------------------------------------------------------------}
function TOCIDirectPath.GetColumns(AIndex: Integer): TOCIDirectPathColumnParam;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIParamGet, []);
  end;
{$ENDIF}
begin
  Result := TOCIDirectPathColumnParam.Create(Self);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIParamGet(LIST_COLUMNS, OCI_DTYPE_PARAM, Env.Error.FHandle,
    Result.FHandle, AIndex));
end;

{-------------------------------------------------------------------------------}
constructor TOCIDirectPathColArray.Create(ADP: TOCIDirectPath);
begin
  inherited Create(ADP.Env);
  FOwner := ADP;
  Init(OCI_HTYPE_DIRPATH_COLUMN_ARRAY);
end;

{-------------------------------------------------------------------------------}
procedure TOCIDirectPathColArray.EntryGet(ARowNum: ub4; AColIndex: ub2; var AData: pUb1;
  var ALen: ub4; var AFlag: ub1);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIDirPathColArrayEntryGet, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIDirPathColArrayEntryGet(Handle, Env.Error.Handle, ARowNum,
    AColIndex, AData, ALen, AFlag));
end;

{-------------------------------------------------------------------------------}
procedure TOCIDirectPathColArray.EntrySet(ARowNum: ub4; AColIndex: ub2; AData: pUb1;
  ALen: ub4; AFlag: ub1);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIDirPathColArrayEntrySet, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIDirPathColArrayEntrySet(Handle, Env.Error.Handle, ARowNum,
    AColIndex, AData, ALen, AFlag));
end;

{-------------------------------------------------------------------------------}
procedure TOCIDirectPathColArray.RowGet(ARowNum: ub4; var ADataArr: ppUb1;
  var ALenArr: pUb4; var AFlagArr: pUb1);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIDirPathColArrayRowGet, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIDirPathColArrayRowGet(Handle, Env.Error.Handle, ARowNum,
    ADataArr, ALenArr, AFlagArr));
end;

{-------------------------------------------------------------------------------}
procedure TOCIDirectPathColArray.Reset;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIDirPathColArrayReset, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIDirPathColArrayReset(Handle, Env.Error.Handle));
end;

{-------------------------------------------------------------------------------}
function TOCIDirectPathColArray.ToStream(AStream: TOCIDirectPathStream;
  ARowCount, ARowIndex: ub4): sword;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIDirPathColArrayToStream, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Result := Env.Lib.OCIDirPathColArrayToStream(Handle, FOwner.Handle,
    AStream.Handle, Env.Error.Handle, ARowCount, ARowIndex);
  if not ((Result = OCI_SUCCESS) or (Result = OCI_CONTINUE) or (Result = OCI_NEED_DATA)) then
    Check(Result);
end;

{-------------------------------------------------------------------------------}
constructor TOCIDirectPathStream.Create(ADP: TOCIDirectPath);
begin
  inherited Create(ADP.Env);
  FOwner := ADP;
  Init(OCI_HTYPE_DIRPATH_STREAM);
end;

{-------------------------------------------------------------------------------}
procedure TOCIDirectPathStream.Reset;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIDirPathStreamReset, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIDirPathStreamReset(Handle, Env.Error.Handle));
end;

{-------------------------------------------------------------------------------}
constructor TOCIDirectPathColumnParam.Create(ADP: TOCIDirectPath);
begin
  inherited Create(ADP.Env);
  FOwner := ADP;
  FType := OCI_DTYPE_PARAM;
end;

{-------------------------------------------------------------------------------}
function TOCIDirectPathColumnParam.GetDataType: TOCIDirecPathDataType;
begin
  case DATA_TYPE of
  SQLT_CHR: Result := dpString;
  SQLT_DAT: Result := dpDateTime;
  SQLT_INT: Result := dpInteger;
  SQLT_UIN: Result := dpUInteger;
  SQLT_IBFLOAT,
  SQLT_IBDOUBLE,
  SQLT_FLT: Result := dpFloat;
  SQLT_BIN: Result := dpRaw;
  else Result := dpUnknown;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIDirectPathColumnParam.SetDataType(AValue: TOCIDirecPathDataType);
begin
  DATA_TYPE := nc2ociDPDataType[AValue];
  DATA_SIZE := nc2ociDPValueSize[AValue];
  if AValue in [dpString, dpDateTime, dpRaw, dpUnknown] then begin
    PRECISION := 0;
    SCALE := 0;
  end
  else if AValue in [dpInteger, dpUInteger] then
    SCALE := 0;
end;

{-------------------------------------------------------------------------------}
{ TOCIPLSQLDescriber                                                            }
{-------------------------------------------------------------------------------}
function NormOraName(const AName: String): String;
var
  i: Integer;
begin
  Result := AName;
  for i := 1 to Length(AName) do
    if (i = 1) and not FDInSet(AName[1], ['a' .. 'z', 'A' .. 'Z']) or
       (i > 1) and not FDInSet(AName[i], ['a' .. 'z', 'A' .. 'Z',
                                          '0' .. '9', '#', '$', '_']) then begin
      Result := '"' + AName + '"';
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
function UCOraName(const AName: String): String;
begin
  Result := TrimLeft(TrimRight(AName));
  if Result <> '' then
    if (Result[1] = '"') and (Result[Length(Result)] = '"') then
      Result := Copy(Result, 2, Length(Result) - 2)
    else
      Result := AnsiUpperCase(Result);
end;

{-------------------------------------------------------------------------------}
constructor TOCIPLSQLDescriber.CreateForProc(ASrvc: TOCIService;
  const AOPackageName, AOProcedureName: String; AOverload: Integer;
  AOwningObj: TObject);
begin
  inherited Create;
  FSrvc := ASrvc;
  FOwningObj := AOwningObj;
  FOPackageName := AOPackageName;
  FOProcedureName := AOProcedureName;
  FOverload := AOverload;
  FForProc := True;
end;

{-------------------------------------------------------------------------------}
constructor TOCIPLSQLDescriber.CreateForPack(ASrvc: TOCIService;
  const AOPackageName: String; AOwningObj: TObject);
begin
  inherited Create;
  FSrvc := ASrvc;
  FOwningObj := AOwningObj;
  FOPackageName := AOPackageName;
  FOProcedureName := '';
  FOverload := 0;
  FForProc := False;
end;

{-------------------------------------------------------------------------------}
destructor TOCIPLSQLDescriber.Destroy;
begin
  CleanUp;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TOCIPLSQLDescriber.Describe;
begin
  // build obj name
  FSPName := FOPackageName;
  if FOProcedureName <> '' then begin
    if FSPName <> '' then
      FSPName := FSPName + '.';
    FSPName := FSPName + FOProcedureName;
  end;
  ASSERT(FSPName <> '');

  // Describe object and verify object type
  FDescr := TOCIDescribe.Create(FSrvc);
  if FOPackageName <> '' then
    FDescr.DescribeName(FOPackageName)
  else
    FDescr.DescribeName(FOProcedureName);
  FObjType := FDescr.UB1[OCI_ATTR_PTYPE];

  if not (FObjType in [OCI_PTYPE_PKG, OCI_PTYPE_FUNC, OCI_PTYPE_PROC]) or
     (FObjType = OCI_PTYPE_PKG) and (FOProcedureName = '') or
     (FObjType = OCI_PTYPE_PKG) and (FOPackageName = '') then begin
    if FObjType = OCI_PTYPE_SYN then begin
      if FOPackageName <> '' then begin
        FOPackageName := NormOraName(FDescr.TEXT[OCI_ATTR_SCHEMA_NAME]) + '.' +
          NormOraName(FDescr.TEXT[OCI_ATTR_NAME]);
        CleanUp;
        Describe;
      end
      else begin
        FOPackageName := '';
        FOProcedureName := NormOraName(FDescr.TEXT[OCI_ATTR_SCHEMA_NAME]) + '.' +
          NormOraName(FDescr.TEXT[OCI_ATTR_NAME]);
        CleanUp;
        Describe;
      end;
    end
    else if FForProc then
      FDException(OwningObj, [S_FD_LPhys, S_FD_OraId], er_FD_OraNotPLSQLObj, [FSPName]);
  end;
end;

{-------------------------------------------------------------------------------}
function TOCIPLSQLDescriber.LocateProc(AExactOverload: Boolean): Boolean;
var
  sName, sPrevName, sUCProcName: String;
  iOverload, iNumOverload: Integer;
begin
  Result := False;
  // If object is package then locate procedure in it
  if FObjType = OCI_PTYPE_PKG then begin
    FNumProcs := FDescr.OpenList(OCI_ATTR_LIST_SUBPROGRAMS);
    sUCProcName := UCOraName(FOProcedureName);
    FProcIndex := 0;
    iOverload := 1;
    sPrevName := '';
    iNumOverload := -1;
    while FProcIndex < FNumProcs do begin
      FDescr.GoToItem(FProcIndex);
      sName := FDescr.Text[OCI_ATTR_NAME];
      if sName = sPrevName then
        Inc(iOverload)
      else begin
        iOverload := 1;
        sPrevName := sName;
      end;
      if sName = sUCProcName then begin
        if AExactOverload then begin
          if FOverload = 0 then begin
            if iOverload > 1 then begin
              Result := True;
              Break;
            end
            else
              iNumOverload := FProcIndex;
          end
          else if iOverload = FOverload then
            Break;
        end
        else if (iOverload = 1) and ((FOverload = 0) or (FOverload = 1)) or
                (iOverload = FOverload) then
          Break;
      end;
      Inc(FProcIndex);
    end;
    if (iNumOverload >= 0) and not Result then
      FDescr.GoToItem(iNumOverload)
    else if FProcIndex = FNumProcs then
      FDException(OwningObj, [S_FD_LPhys, S_FD_OraId], er_FD_OraNotPackageProc,
        [FOProcedureName, FOverload, FOPackageName]);
    FObjType := FDescr.UB1[OCI_ATTR_PTYPE];
  end
  else begin
    FNumProcs := 1;
    FProcIndex := 0;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIPLSQLDescriber.First(var AProcName: String; var AOverload: Integer);
begin
  if FObjType = OCI_PTYPE_PKG then begin
    FNumProcs := FDescr.OpenList(OCI_ATTR_LIST_SUBPROGRAMS);
    FProcIndex := 0;
    if FProcIndex < FNumProcs then begin
      FDescr.GoToItem(FProcIndex);
      FObjType := FDescr.UB1[OCI_ATTR_PTYPE];
      AProcName := FDescr.Text[OCI_ATTR_NAME];
      AOverload := FDescr.UB2[OCI_ATTR_OVERLOAD_ID];
      if not FForProc then
        FSPName := FOPackageName + '.' + NormOraName(AProcName);
    end;
  end
  else begin
    FNumProcs := 1;
    FProcIndex := 0;
  end;
end;

{-------------------------------------------------------------------------------}
function TOCIPLSQLDescriber.Eol: Boolean;
begin
  Result := FProcIndex >= FNumProcs;
end;

{-------------------------------------------------------------------------------}
procedure TOCIPLSQLDescriber.Next(var AProcName: String; var AOverload: Integer);
begin
  if FProcIndex < FNumProcs then begin
    Inc(FProcIndex);
    if FProcIndex < FNumProcs then begin
      FDescr.GoToItem(FProcIndex);
      FObjType := FDescr.UB1[OCI_ATTR_PTYPE];
      AProcName := FDescr.Text[OCI_ATTR_NAME];
      AOverload := FDescr.UB2[OCI_ATTR_OVERLOAD_ID];
      if not FForProc then
        FSPName := FOPackageName + '.' + NormOraName(AProcName);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TOCIPLSQLDescriber.BuildSQL(AOnDefPar: TOCIOnDefineParam): String;
const
  CRLF: String = #10;
var
  sBody, sDecl, sIn, sOut: String;
  i, iVarCnt, iParCnt: Integer;
  numArgs: ub4;
  item: TOCISelectItem;
  oPars: TFDStringList;

  function GetParName(const AName: String): String;
  var
    i: Integer;
  begin
    if Length(AName) > 30 then begin
      i := oPars.IndexOfName(AName);
      if i >= 0 then
        Result := oPars.ValueFromIndex[i]
      else begin
        Result := Copy(AName, 1, 30 - 1 - Length(IntToStr(iParCnt + 1))) + '_' + IntToStr(iParCnt + 1);
        oPars.Add(AName + '=' + Result);
      end;
    end
    else
      Result := AName;
  end;

  function CreateParam(const APrefix, AVar: String; AItem: TOCISelectItem;
    AIsResult, AExclFromBody, AIsTable: Boolean): Boolean;
  var
    sArg, sVar, sType: String;
    vt: TOCIVarType;
    dt: TOCIVarDataType;
    sz, prc, scl: sb4;
    i, nFields: Integer;
    eVarType: TOCIVarType;
    sParBase, sField: String;
    rawTp: ub4;

    function TmpName(const APrefix: String): String;
    begin
      Result := APrefix + 'v' + IntToStr(iVarCnt);
      Inc(iVarCnt);
    end;

    function GetItemName(AItem: TOCISelectItem): String;
    begin
      Result := AItem.NAME;
      if (Result = '') and AIsResult and not AIsTable then
        Result := 'RESULT';
      Result := APrefix + Result;
    end;

    procedure BodyVar(const AName: String);
    begin
      if not AExclFromBody then
        if AIsResult then
          sBody := AName + ' := ' + sBody
        else if BindByName then
          sBody := sBody + sArg + ' => ' + AName
        else
          sBody := sBody + AName;
    end;

    procedure AddParam;
    begin
      AOnDefPar(sArg, sType, vt, dt, sz, prc, scl, AIsTable, AIsResult);
      Inc(iParCnt);
    end;

    procedure CheckTypeSupported(ADataType: ub4);
    begin
      if AIsTable and (ADataType in [SQLT_REC, SQLT_BOL]) then
        FDException(OwningObj, [S_FD_LPhys, S_FD_OraId], er_FD_OraBadTableType, []);
    end;

    function OBool2ValuePLSQL(const ALeft, ARight: String): String;
    begin
      Result := 'IF ' + ARight + ' IS NULL THEN ' + ALeft + ' := NULL; ' +
                'ELSIF ' + ARight + ' THEN ' + ALeft + ' := ' + BoolTrue + '; ' +
                'ELSE ' + ALeft + ' := ' + BoolFalse + '; END IF;';
    end;

    function Value2OBoolPLSQL(const ALeft, ARight: String): String;
    begin
      Result := 'IF ' + ARight + ' IS NULL THEN ' + ALeft + ' := NULL; ' +
                'ELSE ' + ALeft + ' := (' + ARight + ' = ' + BoolTrue + '); END IF;';
    end;

  begin
    sArg := GetItemName(AItem);
    sType := AItem.TYPE_NAME;
    vt := AItem.VarType;
    dt := AItem.DataType;
    sz := AItem.DataSize;
    prc := AItem.DataPrecision;
    scl := AItem.DataScale;

    Result := True;
    rawTp := AItem.DATA_TYPE;
    CheckTypeSupported(rawTp);
    case rawTp of
    SQLT_REC:
      begin
        sVar := TmpName(APrefix);
        BodyVar(sVar);
        sType := AItem.SCHEMA_NAME + '.' + sType + '.' + AItem.SUB_NAME;
        if sType = '.' then
          FDException(OwningObj, [S_FD_LPhys, S_FD_OraId], er_FD_OraUnNamedRecParam, []);
        sDecl := sDecl + sVar + ' ' + sType + ';' + CRLF;
        eVarType := AItem.VarType;
        sParBase := GetItemName(AItem);
        nFields := FDescr.OpenList(OCI_ATTR_LIST_ARGUMENTS);
        try
          for i := 1 to nFields do begin
            AItem := FDescr.SelectItem[i];
            if AItem = nil then
              Break;
            try
              sField := sVar + '.' + AItem.name;
              if CreateParam(sParBase + '$', sField, AItem, AIsResult, True, False) then begin
                if eVarType in [odIn, odInOut] then
                  sIn := sIn + sField + ' := ' + GetParName(':' + sParBase + '$' + AItem.name) + ';' + CRLF;
                if eVarType in [odOut, odInOut] then
                  sOut := sOut + GetParName(':' + sParBase + '$' + AItem.name) + ' := ' + sField + ';' + CRLF;
              end;
            finally
              FDFree(AItem);
            end;
          end;
        finally
          FDescr.CloseList;
        end;
        Result := False;
      end;
    SQLT_TAB:
      begin
        FDescr.OpenList(OCI_ATTR_LIST_ARGUMENTS);
        try
          AItem := FDescr.SelectItem[1];
          try
            Result := CreateParam(sArg, AVar, AItem, AIsResult, AExclFromBody, True);
          finally
            FDFree(AItem);
          end;
        finally
          FDescr.CloseList;
        end;
      end;
    SQLT_BOL:
      if BoolType = otBoolean then begin
        BodyVar(GetParName(':' + sArg));
        AddParam;
      end
      else begin
        if AVar = '' then begin
          sVar := TmpName(APrefix);
          sDecl := sDecl + sVar + ' BOOLEAN;' + CRLF;
        end
        else
          sVar := AVar;
        if AItem.VarType in [odIn, odInOut] then
          sIn := sIn + Value2OBoolPLSQL(sVar, GetParName(':' + sArg)) + CRLF;
        if AItem.VarType in [odOut, odInOut] then
          sOut := sOut + OBool2ValuePLSQL(GetParName(':' + sArg), sVar) + CRLF;
        dt := BoolType;
        sz := BoolSize;
        BodyVar(sVar);
        AddParam;
        Result := False;
      end;
    else
      BodyVar(GetParName(':' + sArg));
      AddParam;
    end;
  end;

  procedure AppendLine(const AStr: String);
  begin
    if Result <> '' then
      Result := Result + CRLF + AStr
    else
      Result := AStr;
  end;

begin
  // Now start to build a SQL and Params collection
  sDecl := '';
  sIn := '';
  sOut := '';
  sBody := '';
  iVarCnt := 0;
  iParCnt := 0;
  numArgs := FDescr.OpenList(OCI_ATTR_LIST_ARGUMENTS);
  oPars := TFDStringList.Create;
  try
    // If this is a function then build a :Result parameter
    if FObjType = OCI_PTYPE_FUNC then begin
      item := FDescr.SelectItem[0];
      try
        CreateParam('', '', item, True, False, False);
      finally
        FDFree(item);
      end;
      Dec(numArgs);
    end;
    // For each parameter do ...
    sBody := sBody + FSPName;
    if numArgs > 0 then
      sBody := sBody + '(';
    for i := 1 to numArgs do begin
      if i > 1 then
        sBody := sBody + ', ';
      item := FDescr.SelectItem[i];
      if item = nil then
        Break;
      try
        CreateParam('', '', item, False, False, False);
      finally
        FDFree(item);
      end;
    end;
    if numArgs > 0 then
      sBody := sBody + ')';
    // Build an anonymous PL/SQL block
    if sDecl <> '' then begin
      AppendLine('DECLARE');
      AppendLine(sDecl);
    end;
    AppendLine('BEGIN');
    if sIn <> '' then
      AppendLine(sIn);
    AppendLine(sBody + ';');
    if sOut <> '' then
      AppendLine(sOut);
    AppendLine('END;');
  finally
    FDFree(oPars);
    FDescr.CloseList;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIPLSQLDescriber.CleanUp;
begin
  if FDescr <> nil then begin
    if (FOPackageName <> '') and FDescr.IsListOpened then
      FDescr.CloseList;
    FDFreeAndNil(FDescr);
  end;
end;

{-------------------------------------------------------------------------------}
{ TOCIOpaqueValue                                                               }
{-------------------------------------------------------------------------------}
constructor TOCIOpaqueValue.Create(AEnv: TOCIEnv; AType: ub4);
begin
  inherited Create(AEnv);
  FOwner := AEnv;
  Init(AType);
  FOwnHandle := True;
  FIsNull := True;
  CheckSupported;
  Parse;
end;

{-------------------------------------------------------------------------------}
constructor TOCIOpaqueValue.CreateUsingHandle(AEnv: TOCIEnv; AHandle: pOCIHandle);
begin
  inherited CreateUsingHandle(AEnv, AHandle);
  FOwner := AEnv;
  FIsNull := (AHandle = nil);
  CheckSupported;
  Parse;
end;

{-------------------------------------------------------------------------------}
class function TOCIOpaqueValue.GetMinClientVersion: TFDVersion;
begin
  Result := 0;
end;

{-------------------------------------------------------------------------------}
procedure TOCIOpaqueValue.CheckSupported;
begin
  if TOCIEnv(FOwner).Lib.Version <= GetMinClientVersion then
    FDCapabilityNotSupported(Self, [S_FD_LPhys, S_FD_OraId]);
end;

{-------------------------------------------------------------------------------}
procedure TOCIOpaqueValue.Assign(ASource: TOCIOpaqueValue);
begin
  if ASource.IsNull then
    Clear
  else begin
    InternalAssign(ASource);
    FIsNull := False;
    FParsed := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCIOpaqueValue.Clear;
begin
  FIsNull := True;
  FParsed := False;
  Parse;
end;

{-------------------------------------------------------------------------------}
procedure TOCIOpaqueValue.Parse;
begin
  if FParsed then
    Exit;
  if IsNull then
    InternalErase
  else
    InternalParse;
  FParsed := True;
end;

{-------------------------------------------------------------------------------}
{ TOCITimestamp                                                                 }
{-------------------------------------------------------------------------------}
procedure TOCITimestamp.InternalAssign(ASource: TOCIOpaqueValue);
begin
  Check(Env.Lib.OCIDateTimeAssign(Owner.Handle, Env.Error.Handle, ASource.Handle, Handle));
end;

{-------------------------------------------------------------------------------}
procedure TOCITimestamp.InternalErase;
begin
  FYear := 0;
  FMonth := 0;
  FDay := 0;
  FHour := 0;
  FMinute := 0;
  FSecond := 0;
  FNanoSeconds := 0;
  FTZHour := 0;
  FTZMinute := 0;
end;

{-------------------------------------------------------------------------------}
class function TOCITimestamp.GetMinClientVersion: TFDVersion;
begin
  Result := cvOracle90000;
end;

{-------------------------------------------------------------------------------}
procedure TOCITimestamp.InternalParse;
begin
  Check(Env.Lib.OCIDateTimeGetDate(Owner.Handle, Env.Error.Handle, Handle,
    FYear, FMonth, FDay));
  Check(Env.Lib.OCIDateTimeGetTime(Owner.Handle, Env.Error.Handle, Handle,
    FHour, FMinute, FSecond, FNanoSeconds));
  Check(Env.Lib.OCIDateTimeGetTimeZoneOffset(Owner.Handle, Env.Error.Handle, Handle,
    FTZHour, FTZMinute));
end;

{-------------------------------------------------------------------------------}
procedure TOCITimestamp.SetValues(AYear: sb2; AMonth, ADay, AHour,
  AMinute, ASecond: ub1; ANanoSeconds: ub4; ATZHour: sb2 = 0; ATZMinute: sb2 = 0);
var
  sTZ: String;
  pTZ: PByte;
  iLen: ub4;
begin
  if (ATZHour = 0) and (ATZMinute = 0) then begin
    pTZ := nil;
    iLen := 0;
  end
  else begin
    sTZ := Format('%.2d:%.2d', [ATZHour, ATZMinute]);
    pTZ := PByte(PChar(sTZ));
    iLen := Length(sTZ) * SizeOf(Char);
  end;
  FYear := AYear;
  FMonth := AMonth;
  FDay := ADay;
  FHour := AHour;
  FMinute := AMinute;
  FSecond := ASecond;
  FTZHour := ATZHour;
  FTZMinute := ATZMinute;
  Check(Env.Lib.OCIDateTimeConstruct(Owner.Handle, Env.Error.Handle, Handle,
    AYear, AMonth, ADay, AHour, AMinute, ASecond, ANanoSeconds, pTZ, iLen));
  FIsNull := False;
  FParsed := True;
end;

{-------------------------------------------------------------------------------}
function TOCITimestamp.GetAsDateTime: TDateTime;
var
  MSec: ub4;
begin
  if IsNull then
    Result := 0.0
  else begin
    Parse;
    MSec := NanoSeconds div 1000000;
    if MSec >= 1000 then
      MSec := 999;
    Result := EncodeDate(Year, Month, Day) + EncodeTime(Hour, Minute, Second, MSec);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCITimestamp.SetAsDateTime(const AValue: TDateTime);
var
  wYear, wMonth, wDay, wHour, wMin, wSec, wMSec: Word;
begin
  DecodeDate(AValue, wYear, wMonth, wDay);
  DecodeTime(AValue, wHour, wMin, wSec, wMSec);
  SetValues(wYear, ub1(wMonth), ub1(wDay), ub1(wHour), ub1(wMin), ub1(wSec),
    wMSec * 1000000);
end;

{-------------------------------------------------------------------------------}
function TOCITimestamp.GetAsString: string;
begin
  if IsNull then
    Result := ''
  else
    Result := FormatDateTime('ddddd tt' + '.zzz', AsDateTime);
end;

{-------------------------------------------------------------------------------}
procedure TOCITimestamp.SetAsString(const AValue: string);
var
  rFS: TFormatSettings;
begin
  if AValue = '' then
    Clear
  else begin
    rFS.DateSeparator := FormatSettings.DateSeparator;
    rFS.ShortDateFormat := 'ddddd';
    rFS.ShortTimeFormat := 'tt.zzz';
    AsDateTime := StrToDateTime(AValue, rFS);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCITimestamp.GetAsSQLTimeStamp(out AValue: TSQLTimeStamp);
begin
  if IsNull then
    FillChar(AValue, SizeOf(TSQLTimeStamp), 0)
  else begin
    Parse;
    AValue.Year := Year;
    AValue.Month := Month;
    AValue.Day := Day;
    AValue.Hour := Hour;
    AValue.Minute := Minute;
    AValue.Second := Second;
    AValue.Fractions := NanoSeconds div 1000000;
  end;
end;

{-------------------------------------------------------------------------------}
function TOCITimestamp.GetAsSQLTimeStampFun: TSQLTimeStamp;
begin
  GetAsSQLTimeStamp(Result);
end;

{-------------------------------------------------------------------------------}
procedure TOCITimestamp.SetAsSQLTimeStamp(const AValue: TSQLTimeStamp);
begin
  SetValues(AValue.Year, ub1(AValue.Month), ub1(AValue.Day), ub1(AValue.Hour),
    ub1(AValue.Minute), ub1(AValue.Second), AValue.Fractions * 1000000);
end;

{-------------------------------------------------------------------------------}
{ TOCITimeInterval                                                              }
{-------------------------------------------------------------------------------}
constructor TOCITimeInterval.Create(AEnv: TOCIEnv; AType: ub4);
begin
  if AType = OCI_DTYPE_INTERVAL_YM then
    FKind := ikYear2Month
  else if AType = OCI_DTYPE_INTERVAL_DS then
    FKind := ikDay2Second
  else
    ASSERT(False);
  inherited Create(AEnv, AType);
end;

{-------------------------------------------------------------------------------}
constructor TOCITimeInterval.CreateUsingHandle(AEnv: TOCIEnv; AHandle: pOCIHandle;
  ADataType: TOCIVarDataType);
begin
  if ADataType = otIntervalYM then
    FKind := ikYear2Month
  else if ADataType = otIntervalDS then
    FKind := ikDay2Second
  else
    ASSERT(False);
  inherited CreateUsingHandle(AEnv, AHandle);
end;

{-------------------------------------------------------------------------------}
class function TOCITimeInterval.GetMinClientVersion: TFDVersion;
begin
  Result := cvOracle90000;
end;

{-------------------------------------------------------------------------------}
procedure TOCITimeInterval.InternalAssign(ASource: TOCIOpaqueValue);
begin
  ASSERT((ASource is TOCITimeInterval) and (Kind = TOCITimeInterval(ASource).Kind));
  Check(Env.Lib.OCIIntervalAssign(Owner.Handle, Env.Error.Handle, ASource.Handle, Handle));
end;

{-------------------------------------------------------------------------------}
procedure TOCITimeInterval.InternalErase;
begin
  FYears := 0;
  FMonths := 0;
  FDays := 0;
  FHours := 0;
  FMinutes := 0;
  FSeconds := 0;
  FNanoSeconds := 0;
end;

{-------------------------------------------------------------------------------}
procedure TOCITimeInterval.InternalParse;
begin
  case FKind of
  ikYear2Month:
    Check(Env.Lib.OCIIntervalGetYearMonth(Owner.Handle, Env.Error.Handle,
      FYears, FMonths, Handle));
  ikDay2Second:
    Check(Env.Lib.OCIIntervalGetDaySecond(Owner.Handle, Env.Error.Handle,
      FDays, FHours, FMinutes, FSeconds, FNanoSeconds, Handle));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCITimeInterval.SetDay2Second(ADays, AHours, AMinutes, ASeconds,
  ANanoSeconds: sb4);
begin
  ASSERT(FKind = ikDay2Second);
  FYears := 0;
  FMonths := 0;
  FDays := ADays;
  FHours := AHours;
  FMinutes := AMinutes;
  FSeconds := ASeconds;
  FNanoSeconds := ANanoSeconds;
  Check(Env.Lib.OCIIntervalSetDaySecond(Owner.Handle, Env.Error.Handle,
    FDays, AHours, AMinutes, ASeconds, ANanoSeconds, Handle));
  FIsNull := False;
  FParsed := True;
end;

{-------------------------------------------------------------------------------}
procedure TOCITimeInterval.SetYear2Month(AYears, AMonths: sb4);
begin
  ASSERT(FKind = ikYear2Month);
  FYears := AYears;
  FMonths := AMonths;
  FDays := 0;
  FHours := 0;
  FMinutes := 0;
  FSeconds := 0;
  FNanoSeconds := 0;
  FKind := ikYear2Month;
  Check(Env.Lib.OCIIntervalSetYearMonth(Owner.Handle, Env.Error.Handle,
    AYears, AMonths, Handle));
  FIsNull := False;
  FParsed := True;
end;

{-------------------------------------------------------------------------------}
procedure TOCITimeInterval.GetAsSQLTimeInterval(out AValue: TFDSQLTimeInterval);
begin
  FillChar(AValue, SizeOf(TFDSQLTimeInterval), 0);
  if not IsNull then begin
    Parse;
    case Kind of
    ikYear2Month:
      begin
        if (Years < 0) or (Months < 0) then
          AValue.Sign := -1
        else
          AValue.Sign := 1;
        AValue.Kind := itYear2Month;
        AValue.Years := Abs(Years);
        AValue.Months := Abs(Months);
      end;
    ikDay2Second:
      begin
        if (Days < 0) or (Hours < 0) or (Minutes < 0) or (Seconds < 0) or (NanoSeconds < 0) then
          AValue.Sign := -1
        else
          AValue.Sign := 1;
        AValue.Kind := itDay2Second;
        AValue.Days := Abs(Days);
        AValue.Hours := Abs(Hours);
        AValue.Minutes := Abs(Minutes);
        AValue.Seconds := Abs(Seconds);
        AValue.Fractions := Abs(NanoSeconds) div 1000000;
      end;
    else
      ASSERT(False);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCITimeInterval.SetAsSQLTimeInterval(const AValue: TFDSQLTimeInterval);
var
  iSign: Integer;

  function Cvt(AValue: Cardinal): sb4;
  begin
    Result := sb4(AValue);
    if (AValue <> 0) and (iSign < 0) then
      Result := -Result;
  end;

begin
  iSign := AValue.Sign;
  case AValue.Kind of
  itUnknown:
    Clear;
  itYear,
  itMonth,
  itYear2Month:
    SetYear2Month(Cvt(AValue.Years), Cvt(AValue.Months));
  itDay,
  itHour,
  itMinute,
  itSecond,
  itDay2Hour,
  itDay2Minute,
  itDay2Second,
  itHour2Minute,
  itHour2Second,
  itMinute2Second:
    SetDay2Second(Cvt(AValue.Days), Cvt(AValue.Hours), Cvt(AValue.Minutes),
      Cvt(AValue.Seconds), Cvt(AValue.Fractions * 1000000));
  end;
end;

{-------------------------------------------------------------------------------}
function TOCITimeInterval.GetAsSQLTimeIntervalFun: TFDSQLTimeInterval;
begin
  GetAsSQLTimeInterval(Result);
end;

{-------------------------------------------------------------------------------}
function TOCITimeInterval.GetAsString: string;
begin
  Result := FDSQLTimeInterval2Str(AsSQLTimeInterval);
end;

{-------------------------------------------------------------------------------}
procedure TOCITimeInterval.SetAsString(const AValue: string);
begin
  AsSQLTimeInterval := FDStr2SQLTimeInterval(AValue);
end;

{-------------------------------------------------------------------------------}
{ TOCICollection                                                                }
{-------------------------------------------------------------------------------}
procedure TOCICollection.Assign(AColl: TOCICollection);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCICollAssign, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCICollAssign(Env.Handle, Env.Error.Handle, AColl.Handle, Handle));
end;

{-------------------------------------------------------------------------------}
function TOCICollection.GetCount: sb4;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCICollSize, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCICollSize(Env.Handle, Env.Error.Handle, Handle, Result));
end;

{-------------------------------------------------------------------------------}
function TOCICollection.GetData(AIndex: sb4; var AData: Pointer): Boolean;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCICollGetElem, ['index', AIndex]);
  end;
{$ENDIF}
var
  lExists: LongBool;
  pInd: pOCIInd;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  pInd := nil;
  Check(Env.Lib.OCICollGetElem(Env.Handle, Env.Error.Handle, Handle, AIndex,
    lExists, AData, Pointer(pInd)));
  Result := lExists and ((pInd = nil) or (pInd^ = OCI_IND_NOTNULL));
end;

{-------------------------------------------------------------------------------}
procedure TOCICollection.SetData(AIndex: sb4; AData: Pointer);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCICollAssignElem, ['index', AIndex]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCICollAssignElem(Env.Handle, Env.Error.Handle, AIndex,
    AData, nil, Handle));
end;

{-------------------------------------------------------------------------------}
procedure TOCICollection.Trim(ANumber: sb4);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCICollTrim, ['trim_num', ANumber]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCICollTrim(Env.Handle, Env.Error.Handle, ANumber, Handle));
end;

{-------------------------------------------------------------------------------}
{ TOCIDescCollection<T>                                                         }
{-------------------------------------------------------------------------------}
destructor TOCIDescCollection<T>.Destroy;
begin
  FDFreeAndNil(FDesc);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TOCIDescCollection<T>.GetItems(AIndex: Integer): T;
var
  pDesc: ppOCIHandle;
begin
  if FDesc = nil then
    FDesc := T.CreateUsingHandle(Env, nil);
  if GetData(AIndex, Pointer(pDesc)) then begin
    FDesc.Handle := pDesc^;
    Result := FDesc;
  end
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
{ TOCIAdmin                                                                     }
{-------------------------------------------------------------------------------}
const
  ad2OCIsm: array[TOCIShutdownMode] of ub4 = (OCI_DBSHUTDOWN_TRANSACTIONAL,
    OCI_DBSHUTDOWN_TRANSACTIONAL_LOCAL, OCI_DBSHUTDOWN_IMMEDIATE,
    OCI_DBSHUTDOWN_ABORT, OCI_DBSHUTDOWN_FINAL);

constructor TOCIAdmin.Create(AService: TOCIService);
begin
  inherited Create(AService.Env);
  FOwner := AService;
  FOwningObj := AService.OwningObj;
  Init(OCI_HTYPE_ADMIN);
end;

{-------------------------------------------------------------------------------}
procedure TOCIAdmin.Startup(AFlags: TOCIStartupFlags);
var
  flags: ub4;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIDBStartup, ['flags', flags]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  flags := OCI_DEFAULT;
  if sfRestrict in AFlags then
    flags := flags or OCI_DBSTARTUPFLAG_RESTRICT;
  if sfForce in AFlags then
    flags := flags or OCI_DBSTARTUPFLAG_FORCE;
  Check(Env.Lib.OCIDBStartup(FOwner.FHandle, Env.Error.FHandle, FHandle,
    OCI_DEFAULT, flags));
end;

{-------------------------------------------------------------------------------}
procedure TOCIAdmin.Shutdown(AMode: TOCIShutdownMode);
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCIDBShutdown, ['mode', ad2OCIsm[AMode]]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCIDBShutdown(FOwner.FHandle, Env.Error.FHandle, FHandle,
    ad2OCIsm[AMode]));
end;

{-------------------------------------------------------------------------------}
{ TOCISubscription                                                              }
{-------------------------------------------------------------------------------}
constructor TOCISubscription.Create(AService: TOCIService);
begin
  inherited Create(AService.Env);
  FOwner := AService;
  FOwningObj := AService.OwningObj;
  Init(OCI_HTYPE_SUBSCRIPTION);
  _CALLBACK := @TOCISubscription.SubEventCallback;
  CTX := Self;
end;

{-------------------------------------------------------------------------------}
procedure TOCISubscription.Register;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCISubscriptionRegister, []);
  end;
{$ENDIF}
begin
  if FState <> ssInactive then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCISubscriptionRegister(TOCIService(FOwner).Handle,
    @FHandle, 1, Env.Error.Handle, OCI_DEFAULT));
  FState := ssActive;
end;

{-------------------------------------------------------------------------------}
procedure TOCISubscription.Unregister;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCISubscriptionUnRegister, []);
  end;
{$ENDIF}
var
  lPrevIgnore: Boolean;
begin
  if FState = ssInactive then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  lPrevIgnore := Env.Error.IgnoreErrors;
  Env.Error.IgnoreErrors := True;
  try
    Check(Env.Lib.OCISubscriptionUnRegister(TOCIService(FOwner).Handle,
      Handle, Env.Error.Handle, OCI_DEFAULT));
  finally
    Env.Error.IgnoreErrors := lPrevIgnore;
    FState := ssInactive;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCISubscription.Enable;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCISubscriptionEnable, []);
  end;
{$ENDIF}
begin
  if FState <> ssDisabled then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCISubscriptionEnable(Handle, Env.Error.Handle, OCI_DEFAULT));
  FState := ssActive;
end;

{-------------------------------------------------------------------------------}
procedure TOCISubscription.Disable;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCISubscriptionDisable, []);
  end;
{$ENDIF}
begin
  if FState <> ssActive then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCISubscriptionDisable(Handle, Env.Error.Handle, OCI_DEFAULT));
  FState := ssDisabled;
end;

{-------------------------------------------------------------------------------}
procedure TOCISubscription.Post;
{$IFDEF FireDAC_MONITOR}
  procedure ProcTrace;
  begin
    Trace(sOCISubscriptionPost, []);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then ProcTrace;
{$ENDIF}
  Check(Env.Lib.OCISubscriptionPost(TOCIService(FOwner).Handle,
    @FHandle, 1, Env.Error.Handle, OCI_DEFAULT));
end;

{-------------------------------------------------------------------------------}
class procedure TOCISubscription.SubEventCallback(ctx: Pointer;
  subscrhp: pOCISubscription; payload: Pointer; paylen: Ub4;
  desc: pOCIDescriptor; mode: ub4);
begin
  try
    TOCISubscription(ctx).DoSubEvent(payload, paylen, desc, mode);
  except
  end;
end;

{-------------------------------------------------------------------------------}
procedure TOCISubscription.DoSubEvent(payload: Pointer; paylen: Ub4;
  desc: pOCIDescriptor; mode: ub4);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
{ TOCIChangeRowDesc                                                             }
{-------------------------------------------------------------------------------}
constructor TOCIChangeRowDesc.CreateUsingHandle(AEnv: TOCIEnv; AHandle: pOCIHandle);
begin
  inherited CreateUsingHandle(AEnv, AHandle);
  FType := OCI_DTYPE_ROW_CHDES;
  FOwner := AEnv;
  FOwningObj := AEnv.OwningObj;
end;

{-------------------------------------------------------------------------------}
{ TOCIChangeTableDesc                                                           }
{-------------------------------------------------------------------------------}
constructor TOCIChangeTableDesc.CreateUsingHandle(AEnv: TOCIEnv;
  AHandle: pOCIHandle);
begin
  inherited CreateUsingHandle(AEnv, AHandle);
  FType := OCI_DTYPE_TABLE_CHDES;
  FOwner := AEnv;
  FOwningObj := AEnv.OwningObj;
end;

{-------------------------------------------------------------------------------}
destructor TOCIChangeTableDesc.Destroy;
begin
  FDFreeAndNil(FRows);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TOCIChangeTableDesc.GetRows: TRows;
begin
  Result := InitCollection(TRows, FRows, ROW_CHANGES) as TRows;
end;

{-------------------------------------------------------------------------------}
{ TOCIChangeQueryDesc                                                           }
{-------------------------------------------------------------------------------}
constructor TOCIChangeQueryDesc.CreateUsingHandle(AEnv: TOCIEnv;
  AHandle: pOCIHandle);
begin
  inherited CreateUsingHandle(AEnv, AHandle);
  FType := OCI_DTYPE_CQDES;
  FOwner := AEnv;
  FOwningObj := AEnv.OwningObj;
end;

{-------------------------------------------------------------------------------}
destructor TOCIChangeQueryDesc.Destroy;
begin
  FDFreeAndNil(FTables);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TOCIChangeQueryDesc.GetTables: TTables;
begin
  Result := InitCollection(TTables, TOCICollection(FTables), TABLE_CHANGES) as TTables;
end;

{-------------------------------------------------------------------------------}
{ TOCIChangeDesc                                                                }
{-------------------------------------------------------------------------------}
constructor TOCIChangeDesc.CreateUsingHandle(AEnv: TOCIEnv; AHandle: pOCIHandle);
begin
  inherited CreateUsingHandle(AEnv, AHandle);
  FType := OCI_DTYPE_CHDES;
  FOwner := AEnv;
  FOwningObj := AEnv.OwningObj;
end;

{-------------------------------------------------------------------------------}
destructor TOCIChangeDesc.Destroy;
begin
  FDFreeAndNil(FTables);
  FDFreeAndNil(FQueries);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TOCIChangeDesc.GetQueries: TQueries;
begin
  Result := InitCollection(TQueries, TOCICollection(FQueries), QUERIES_) as TQueries;
end;

{-------------------------------------------------------------------------------}
function TOCIChangeDesc.GetTables: TTables;
begin
  Result := InitCollection(TTables, TOCICollection(FTables), TABLE_CHANGES) as TTables;
end;

{-------------------------------------------------------------------------------}
{ TOCIQueryNotification                                                         }
{-------------------------------------------------------------------------------}
constructor TOCIQueryNotification.Create(AService: TOCIService);
begin
  inherited Create(AService);
  NAMESPACE := OCI_SUBSCR_NAMESPACE_DBCHANGE;
end;

{-------------------------------------------------------------------------------}
destructor TOCIQueryNotification.Destroy;
begin
  FDFreeAndNil(FChange);
  FDFreeAndNil(FTables);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TOCIQueryNotification.GetTables: TOCICollection;
begin
  Result := InitCollection(TOCICollection, FTables, TABLENAMES);
end;

{-------------------------------------------------------------------------------}
procedure TOCIQueryNotification.DoSubEvent(payload: Pointer; paylen: Ub4;
  desc: pOCIDescriptor; mode: ub4);
begin
  if FChange = nil then
    FChange := TOCIChangeDesc.CreateUsingHandle(Env, desc)
  else
    FChange.Handle := desc;
  DoChangeEvent(FChange);
end;

{-------------------------------------------------------------------------------}
procedure TOCIQueryNotification.DoChangeEvent(AChange: TOCIChangeDesc);
begin
  if Assigned(FOnChange) then
    FOnChange(Self, AChange);
end;

{-------------------------------------------------------------------------------}
function OCINativeExceptionLoad(const AStorage: IFDStanStorage): TObject;
begin
  Result := EOCINativeException.Create;
  EOCINativeException(Result).LoadFromStorage(AStorage);
end;

{-------------------------------------------------------------------------------}
initialization
  FDStorageManager().RegisterClass(EOCINativeException, 'OCINativeException',
    @OCINativeExceptionLoad, @FDExceptionSave);

end.

