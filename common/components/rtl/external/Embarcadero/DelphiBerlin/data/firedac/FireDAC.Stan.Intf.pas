{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{              FireDAC standard layer API               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Stan.Intf;

interface

uses
  System.SysUtils, System.Classes, System.IniFiles, System.Variants,
    System.TypInfo, System.SyncObjs, System.Generics.Collections,
  Data.FmtBcd, Data.SqlTimSt,
  FireDAC.Stan.Consts;

type
  IFDStanComponentReference = interface;
  TFDComponent = class;
  IFDStanObject = interface;
  IFDStanObjectHost = interface;
  IFDStanObjectFactory = interface;
  IFDStanErrorHandler = interface;
  IFDStanExpressionDataSource = interface;
  IFDStanExpressionParser = interface;
  IFDStanExpressionEvaluator = interface;
  IFDStanDefinitionStorage = interface;
  IFDStanDefinition = interface;
  IFDStanDefinitions = interface;
  TFDConnectionDefParams = class;
  TFDConnectionDefParamsClass = class of TFDConnectionDefParams;
  IFDStanConnectionDef = interface;
  IFDStanConnectionDefs = interface;
  IFDStanConnectionDefParams = interface;
  IFDStanAsyncOperation = interface;
  IFDStanAsyncExecutor = interface;
  TFDMoniAdapterHelper = class;
{$IFDEF FireDAC_MONITOR}
  IFDMoniClientOutputHandler = interface;
  IFDMoniClient = interface;
  IFDMoniRemoteClient = interface;
  IFDMoniFlatFileClient = interface;
  IFDMoniCustomClient = interface;
{$ENDIF}
  IFDMoniAdapter = interface;
  TFDStorableObject = class;
  TFDStorableObjectClass = class of TFDStorableObject;
  IFDStanStorage = interface;
  TFDStorageManager = class;

  { --------------------------------------------------------------------------}
  { DBMS kinds                                                                }
  { --------------------------------------------------------------------------}
  /// <summary> Standard database kinds known to FireDAC. A custom database
  ///  kind may be provided starting from 100. To register new database kind
  ///  use call:
  ///
  ///  const
  ///    CMyDBKind = 100;
  ///    CMyDBName = 'DBStore';
  ///  FDPhysManager().RegisterRDBMSKind(CMyDBKind, CMyDBName); </summary>
  TFDRDBMSKinds = class
  public const
    Unknown = 0;
    Oracle = 1;
    MSSQL = 2;
    MSAccess = 3;
    MySQL = 4;
    DB2 = 5;
    SQLAnywhere = 6;
    Advantage = 7;
    Interbase = 8;
    Firebird = 9;
    SQLite = 10;
    PostgreSQL = 11;
    NexusDB = 12;
    DataSnap = 13;
    Informix = 14;
    Teradata = 15;
    MongoDB = 16;
    Other = 17;
  end;
  TFDRDBMSKind = type Integer;

  { --------------------------------------------------------------------------}
  { DB types and options                                                      }
  { --------------------------------------------------------------------------}
  TFDDataType = (dtUnknown,                                 // unknown
    dtBoolean,                                              // Boolean
    dtSByte, dtInt16, dtInt32, dtInt64,                     // signed int
    dtByte, dtUInt16, dtUInt32, dtUInt64,                   // unsinged int
    dtSingle, dtDouble, dtExtended,                         // float point numbers
    dtCurrency, dtBCD, dtFmtBCD,                            // high-precision numbers
    dtDateTime, dtTime, dtDate, dtDateTimeStamp,            // date and time
    dtTimeIntervalFull, dtTimeIntervalYM, dtTimeIntervalDS, // time interval
    dtAnsiString, dtWideString, dtByteString,               // string
    dtBlob, dtMemo, dtWideMemo, dtXML,                      // value blobs
    dtHBlob, dtHMemo, dtWideHMemo,                          // handle blobs
    dtHBFile,                                               // external files
    dtRowSetRef, dtCursorRef, dtRowRef,
      dtArrayRef, dtParentRowRef,                           // adt -> ftDataSet, ftCursor, ftADT, ftArray
    dtGUID, dtObject);                                      // adt -> IFDDataStoredObject
  TFDDataTypes = set of TFDDataType;

  TFDDataAttribute = (caSearchable, caAllowNull, caFixedLen,
    caBlobData, caReadOnly, caAutoInc, caROWID, caDefault,
    caRowVersion, caInternal, caCalculated, caVolatile, caUnnamed,
    caVirtual, caBase, caExpr);
  TFDDataAttributes = set of TFDDataAttribute;
  TFDDataOption = (coAllowNull, coUnique, coReadOnly, coInUpdate,
    coInWhere, coInKey, coAfterInsChanged, coAfterUpdChanged);
  TFDDataOptions = set of TFDDataOption;

  TFDStreamMode = (smOpenRead, smOpenWrite, smOpenReadWrite);

  TFDCompareDataOption = (coNoCase, coPartial, coNullFirst, coDescNullLast,
    coDescending, coCache, coNullsNotEqual, coNoSymbols);
  TFDCompareDataOptions = set of TFDCompareDataOption;

  TFDSortOption = (soNoCase, soNullFirst, soDescNullLast, soDescending,
    soUnique, soPrimary, soNoSymbols);
  TFDSortOptions = set of TFDSortOption;

  TFDLocateOption = (loPartial, loNearest, loNoCase, loLast, loExcludeKeyRow,
    loUseRowID, loFromCurrent, loBackward);
  TFDLocateOptions = set of TFDLocateOption;

  TFDMergeMetaMode = (mmNone, mmMerge, mmAdd, mmUpdate, mmAddOrError, mmError);
  TFDMergeDataMode = (dmNone, dmDataSet, dmDataAppend, dmDataMerge, dmDeltaSet,
    dmDeltaAppend, dmDeltaMerge);
  TFDMergeOptions = set of (moPreserveState);

  PFDDataStoredObject = ^IFDDataStoredObject;
  IFDDataStoredObject = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2000}']
    function Compare(const AOtherObjInt: IFDDataStoredObject;
      AOptions: TFDCompareDataOptions): Integer;
  end;

  { --------------------------------------------------------------------------}
  { Base types                                                                }
  { --------------------------------------------------------------------------}
  PLargeInt = ^Int64;
  PULargeInt = ^UInt64;
  PPByte = ^PByte;

{$IFNDEF NEXTGEN}
  TFDByteString = RawByteString;
  TFDAnsiString = AnsiString;
  PFDAnsiString = PAnsiChar;
  TFDAnsiChar = AnsiChar;
{$ELSE}
  TFDByteString = TBytes;
  TFDAnsiString = String;
  PFDAnsiString = PByte;
  TFDAnsiChar = Byte;
  TRecordBuffer = PByte;
{$ENDIF}

  TFDCharSet = {$IFDEF NEXTGEN} TSysCharSet {$ELSE} set of AnsiChar {$ENDIF};
  TFDByteSet = set of Byte;
  TFDStringArray = array of String;
  TFDVariantArray = array of Variant;

  TFDsize_t = NativeUInt;
  TFDssize_t = NativeInt;
  TFDCounter = {$IFDEF FireDAC_64} Int64 {$ELSE} Integer {$ENDIF};
  TFDVersion = UInt64;
  PFDsize_t = ^TFDsize_t;

  TFDParseFmtSettings = record
    FDelimiter: Char;
    FQuote: Char;
    FQuote1: Char;
    FQuote2: Char;
  end;
  PFDFormatSettings = ^TFormatSettings;

  TFDEncoding = (ecDefault, ecUTF8, ecUTF16, ecANSI);
  TFDTextEndOfLine = (elDefault, elWindows, elPosix);
  TFDLocalID = LongWord;

  TFDPtrList = {$IFDEF AUTOREFCOUNT} TList<Pointer> {$ELSE} TList {$ENDIF};
  TFDObjList = {$IFDEF AUTOREFCOUNT} TList<TObject> {$ELSE} TList {$ENDIF};
  TFDClassList = {$IFDEF AUTOREFCOUNT} TList<TClass> {$ELSE} TList {$ENDIF};
  TFDThreadObjList = {$IFDEF AUTOREFCOUNT} TThreadList<TObject> {$ELSE} TThreadList {$ENDIF};

  TFDValWrapper = class(TObject)
  private
    FVal: NativeUInt;
    function GetInt: Integer; inline;
    function GetPtr: Pointer; inline;
  public
    constructor Create(APtr: Pointer); overload;
    constructor Create(AVal: LongWord); overload;
    property AsPtr: Pointer read GetPtr;
    property AsInt: Integer read GetInt;
  end;

  TFDStringList = class(TStringList)
  private
    function GetPtrs(AIndex: Integer): Pointer;
    procedure SetPtrs(AIndex: Integer; const AValue: Pointer);
    function GetInts(AIndex: Integer): LongWord;
    procedure SetInts(AIndex: Integer; const AValue: LongWord);
  public
    procedure AddPtr(const AStr: String; APtr: Pointer);
    procedure AddInt(const AStr: String; AInt: LongWord);
    property Ptrs[AIndex: Integer]: Pointer read GetPtrs write SetPtrs;
    property Ints[AIndex: Integer]: LongWord read GetInts write SetInts;
  end;

  { --------------------------------------------------------------------------}
  { Objects and factories interfaces                                          }
  { --------------------------------------------------------------------------}
  IFDStanComponentReference = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2029}']
    procedure SetComponentReference(const AValue: IInterfaceComponentReference);
  end;

  TFDComponent = class(TComponent)
  end;

  IFDStanObject = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2001}']
    // private
    function GetName: TComponentName;
    function GetParent: IFDStanObject;
    // public
    procedure BeforeReuse;
    procedure AfterReuse;
    procedure SetOwner(const AOwner: TObject; const ARole: TComponentName);
    property Name: TComponentName read GetName;
    property Parent: IFDStanObject read GetParent;
  end;

  IFDStanObjectHost = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2002}']
    // private
    function GetObjectKindName: TComponentName;
    // public
    procedure CreateObject(out AObject: IFDStanObject);
    property ObjectKindName: TComponentName read GetObjectKindName;
  end;

  IFDStanObjectFactory = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2003}']
    procedure Open(const AHost: IFDStanObjectHost; const ADef: IFDStanDefinition);
    procedure Close;
    procedure Acquire(out AObject: IFDStanObject);
    procedure Release(const AObject: IFDStanObject);
  end;

  { --------------------------------------------------------------------------}
  { Definition, connection definition interfaces                              }
  { --------------------------------------------------------------------------}
  TFDDefinitionState = (asAdded, asModified, asDeleted, asLoading, asLoaded);
  TFDDefinitionStyle = (atPersistent, atPrivate, atTemporary);
  TFDMonitorBy = (mbNone, mbFlatFile, mbRemote, mbCustom);

  IFDStanDefinitionStorage = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2012}']
    // private
    function GetFileName: String;
    procedure SetFileName(const AValue: String);
    function GetGlobalFileName: String;
    procedure SetGlobalFileName(const AValue: String);
    function GetDefaultFileName: String;
    procedure SetDefaultFileName(const AValue: String);
    // public
    function CreateIniFile: TCustomIniFile;
    // R/O
    function ActualFileName: String;
    // R/W
    property FileName: String read GetFileName write SetFileName;
    property GlobalFileName: String read GetGlobalFileName write SetGlobalFileName;
    property DefaultFileName: String read GetDefaultFileName write SetDefaultFileName;
  end;

  IFDStanDefinition = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2013}']
    // private
    function GetName: String;
    function GetState: TFDDefinitionState;
    function GetStyle: TFDDefinitionStyle;
    function GetAsBoolean(const AName: String): LongBool;
    function GetAsInteger(const AName: String): LongInt;
    function GetAsString(const AName: String): String;
    function GetAsXString(const AName: String): String;
    function GetParentDefinition: IFDStanDefinition;
    function GetParams: TStrings;
    function GetOnChanging: TNotifyEvent;
    function GetOnChanged: TNotifyEvent;
    function GetUpdatable: Boolean;
    procedure SetName(const AValue: String);
    procedure SetParams(const AValue: TStrings);
    procedure SetAsBoolean(const AName: String; const AValue: LongBool);
    procedure SetAsYesNo(const AName: String; const AValue: LongBool);
    procedure SetAsInteger(const AName: String; const AValue: LongInt);
    procedure SetAsString(const AName, AValue: String);
    procedure SetParentDefinition(const AValue: IFDStanDefinition);
    procedure SetOnChanging(AValue: TNotifyEvent);
    procedure SetOnChanged(AValue: TNotifyEvent);
    // public
    procedure Apply;
    procedure Clear;
    procedure Cancel;
    procedure Delete;
    procedure MarkPersistent;
    procedure MarkUnchanged;
    procedure OverrideBy(const ADefinition: IFDStanDefinition; AAll: Boolean);
    function ParseString(const AStr: String; AKeywords: TStrings = nil): String; overload;
    function ParseString(const AStr: String; AKeywords: TStrings; const AFmt: TFDParseFmtSettings): String; overload;
    function BuildString(AKeywords: TStrings = nil): String; overload;
    function BuildString(AKeywords: TStrings; const AFmt: TFDParseFmtSettings): String; overload;
    function HasValue(const AName: String): Boolean; overload;
    function HasValue(const AName: String; var ALevel: Integer): Boolean; overload;
    function OwnValue(const AName: String): Boolean;
    function IsSpecified(const AName: String): Boolean;
    procedure ToggleUpdates(APassCode: LongWord; ADisableDelete, ADisableModify: Boolean);
{$IFDEF FireDAC_MONITOR}
    procedure BaseTrace(const AMonitor: IFDMoniClient);
    procedure Trace(const AMonitor: IFDMoniClient);
{$ENDIF}
    property State: TFDDefinitionState read GetState;
    property Style: TFDDefinitionStyle read GetStyle;
    property Updatable: Boolean read GetUpdatable;
    property AsXString[const AName: String]: String read GetAsXString;
    property AsString[const AName: String]: String read GetAsString write SetAsString;
    property AsBoolean[const AName: String]: LongBool read GetAsBoolean write SetAsBoolean;
    property AsYesNo[const AName: String]: LongBool read GetAsBoolean write SetAsYesNo;
    property AsInteger[const AName: String]: LongInt read GetAsInteger write SetAsInteger;
    property ParentDefinition: IFDStanDefinition read GetParentDefinition write SetParentDefinition;
    // published
    property Params: TStrings read GetParams write SetParams;
    property Name: String read GetName write SetName;
    property OnChanging: TNotifyEvent read GetOnChanging write SetOnChanging;
    property OnChanged: TNotifyEvent read GetOnChanged write SetOnChanged;
  end;

  IFDStanDefinitions = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2014}']
    // private
    function GetCount: Integer;
    function GetItems(AIndex: Integer): IFDStanDefinition;
    function GetAutoLoad: Boolean;
    function GetStorage: IFDStanDefinitionStorage;
    function GetLoaded: Boolean;
    function GetBeforeLoad: TNotifyEvent;
    function GetAfterLoad: TNotifyEvent;
    function GetUpdatable: Boolean;
    function GetName: String;
    procedure SetAutoLoad(AValue: Boolean);
    procedure SetBeforeLoad(AValue: TNotifyEvent);
    procedure SetAfterLoad(AValue: TNotifyEvent);
    procedure SetName(const AValue: String);
    // public
    function Add: IFDStanDefinition;
    function AddTemporary: IFDStanDefinition;
    function FindDefinition(const AName: String): IFDStanDefinition;
    function DefinitionByName(const AName: String): IFDStanDefinition;
    procedure Cancel;
    procedure Save(AIfModified: Boolean = True);
    function Load: Boolean;
    function Refresh: Boolean;
    procedure Clear;
    procedure BeginRead;
    procedure EndRead;
    procedure BeginWrite;
    procedure EndWrite;
    property Count: Integer read GetCount;
    property Items[AIndex: Integer]: IFDStanDefinition read GetItems; default;
    property Loaded: Boolean read GetLoaded;
    property Updatable: Boolean read GetUpdatable;
    // published
    property Name: String read GetName write SetName;
    property AutoLoad: Boolean read GetAutoLoad write SetAutoLoad;
    property Storage: IFDStanDefinitionStorage read GetStorage;
    property BeforeLoad: TNotifyEvent read GetBeforeLoad write SetBeforeLoad;
    property AfterLoad: TNotifyEvent read GetAfterLoad write SetAfterLoad;
  end;

  /// <summary> TFDConnectionDefParams class implements base class for FireDAC driver specific connection definition classes. </summary>
  TFDConnectionDefParams = class(TFDStringList)
  private
    function GetDriverID: String;
    procedure SetDriverID(const AValue: String);
    function GetPooled: Boolean;
    procedure SetPooled(const AValue: Boolean);
    function GetDatabase: TFileName;
    procedure SetDatabase(const AValue: TFileName);
    function GetUserName: String;
    procedure SetUserName(const AValue: String);
    function GetPassword: String;
    procedure SetPassword(const AValue: String);
    function GetMonitorBy: TFDMonitorBy;
    procedure SetMonitorBy(const AValue: TFDMonitorBy);
    function GetMonitorByInitial: Boolean;
    procedure SetMonitorByInitial(const AValue: Boolean);
    function GetPoolCleanupTimeout: Integer;
    procedure SetPoolCleanupTimeout(const AValue: Integer);
    function GetPoolExpireTimeout: Integer;
    procedure SetPoolExpireTimeout(const AValue: Integer);
    function GetPoolMaximumItems: Integer;
    procedure SetPoolMaximumItems(const AValue: Integer);
    function GetNewPassword: String;
    procedure SetNewPassword(const AValue: String);
    function GetExpandedDatabase: String;
    function GetConnectionDef: String;
    procedure SetConnectionDef(const AValue: String);
  protected
    FDef: IFDStanDefinition;
  public
    constructor Create(const ADef: IFDStanDefinition);
    destructor Destroy; override;
    property ExpandedDatabase: String read GetExpandedDatabase;
    property NewPassword: String read GetNewPassword write SetNewPassword;
    property ConnectionDef: String read GetConnectionDef write SetConnectionDef;
  published
    property DriverID: String read GetDriverID write SetDriverID stored False;
    property Database: TFileName read GetDatabase write SetDatabase stored False;
    property UserName: String read GetUserName write SetUserName stored False;
    property Password: String read GetPassword write SetPassword stored False;
    property MonitorBy: TFDMonitorBy read GetMonitorBy write SetMonitorBy stored False;
    property MonitorByInitial: Boolean read GetMonitorByInitial write SetMonitorByInitial stored False;
    property Pooled: Boolean read GetPooled write SetPooled stored False;
    property PoolCleanupTimeout: Integer read GetPoolCleanupTimeout write SetPoolCleanupTimeout stored False;
    property PoolExpireTimeout: Integer read GetPoolExpireTimeout write SetPoolExpireTimeout stored False;
    property PoolMaximumItems: Integer read GetPoolMaximumItems write SetPoolMaximumItems stored False;
  end;

  IFDStanConnectionDef = interface(IFDStanDefinition)
    ['{3E9B315B-F456-4175-A864-B2573C4A2015}']
    // private
    function GetConnectionDefParams: TFDConnectionDefParams;
    procedure SetConnectionDefParams(AValue: TFDConnectionDefParams);
    // public
    procedure WriteOptions(AFormatOptions: TObject; AUpdateOptions: TObject;
      AFetchOptions: TObject; AResourceOptions: TObject);
    procedure ReadOptions(AFormatOptions: TObject; AUpdateOptions: TObject;
      AFetchOptions: TObject; AResourceOptions: TObject);
    // published
    property Params: TFDConnectionDefParams read GetConnectionDefParams write SetConnectionDefParams;
  end;

  IFDStanConnectionDefs = interface(IFDStanDefinitions)
    ['{3E9B315B-F456-4175-A864-B2573C4A2016}']
    // private
    function GetConnectionDefs(AIndex: Integer): IFDStanConnectionDef;
    // public
    function AddConnectionDef: IFDStanConnectionDef;
    function FindConnectionDef(const AName: String): IFDStanConnectionDef;
    function ConnectionDefByName(const AName: String): IFDStanConnectionDef;
    property Items[AIndex: Integer]: IFDStanConnectionDef read GetConnectionDefs; default;
  end;

  IFDStanConnectionDefParams = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2032}']
    function CreateParams(const ADef: IFDStanDefinition): TObject;
  end;

  { --------------------------------------------------------------------------}
  { Error handling interfaces                                                 }
  { --------------------------------------------------------------------------}
  TFDErrorAction = (eaFail, eaSkip, eaRetry, eaApplied, eaDefault,
    eaExitSuccess, eaExitFailure);

  IFDStanErrorHandler = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2007}']
    procedure HandleException(const AInitiator: IFDStanObject; var AException: Exception);
  end;

  { --------------------------------------------------------------------------}
  { Expression evaluation interfaces                                          }
  { --------------------------------------------------------------------------}
  TFDParserOption = (poAggregate, poDefaultExpr, poFieldNameGiven);
  TFDParserOptions = set of TFDParserOption;

  TFDExpressionOption = (ekNoCase, ekPartial);
  TFDExpressionOptions = set of TFDExpressionOption;
  TFDExpressionScopeKind = (ckUnknown, ckField, ckAgg, ckConst);

  TFDAggregateKind = (akSum, akAvg, akCount, akMin, akMax, akFirst, akLast);

  IFDStanExpressionDataSource = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2008}']
    // private
    function GetVarIndex(const AName: String): Integer;
    function GetVarType(AIndex: Integer): TFDDataType;
    function GetVarScope(AIndex: Integer): TFDExpressionScopeKind;
    function GetVarData(AIndex: Integer): Variant;
    procedure SetVarData(AIndex: Integer; const AValue: Variant);
    function GetSubAggregateValue(AIndex: Integer): Variant;
    function GetPosition: Pointer;
    procedure SetPosition(AValue: Pointer);
    function GetRowNum: Integer;
    function GetDatabase: String;
    function GetUser: String;
    // public
    property VarIndex[const AName: String]: Integer read GetVarIndex;
    property VarType[AIndex: Integer]: TFDDataType read GetVarType;
    property VarScope[AIndex: Integer]: TFDExpressionScopeKind read GetVarScope;
    property VarData[AIndex: Integer]: Variant read GetVarData write SetVarData;
    property SubAggregateValue[AIndex: Integer]: Variant read GetSubAggregateValue;
    property Position: Pointer read GetPosition write SetPosition;
    property RowNum: Integer read GetRowNum;
    property Database: String read GetDatabase;
    property User: String read GetUser;
  end;

  IFDStanExpressionEvaluator = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2010}']
    // private
    function GetSubAggregateCount: Integer;
    function GetSubAggregateKind(AIndex: Integer): TFDAggregateKind;
    function GetDataSource: IFDStanExpressionDataSource;
    function GetDataType: TFDDataType;
    // public
    function HandleNotification(AKind: Word; AReason: Word;
      AParam1, AParam2: NativeInt): Boolean;
    function Evaluate: Variant;
    // support for aggregates
    function EvaluateSubAggregateArg(AIndex: Integer): Variant;
    property SubAggregateCount: Integer read GetSubAggregateCount;
    property SubAggregateKind[AIndex: Integer]: TFDAggregateKind read GetSubAggregateKind;
    property DataSource: IFDStanExpressionDataSource read GetDataSource;
    property DataType: TFDDataType read GetDataType;
  end;

  IFDStanExpressionParser = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2009}']
    // private
    function GetDataSource: IFDStanExpressionDataSource;
    // public
    function Prepare(const ADataSource: IFDStanExpressionDataSource;
      const AExpression: String; AOptions: TFDExpressionOptions;
      AParserOptions: TFDParserOptions; const AFixedVarName: String): IFDStanExpressionEvaluator;
    property DataSource: IFDStanExpressionDataSource read GetDataSource;
  end;

  { --------------------------------------------------------------------------}
  { Async execute interfaces                                                  }
  { --------------------------------------------------------------------------}
  TFDStanAsyncMode = (amBlocking, amNonBlocking, amCancelDialog, amAsync);
  TFDStanAsyncState = (asInactive, asExecuting, asFinished, asFailed, asAborted, asExpired);

  IFDStanAsyncHandler = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2025}']
    procedure HandleFinished(const AInitiator: IFDStanObject;
      AState: TFDStanAsyncState; AException: Exception);
  end;

  IFDStanAsyncOperation = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2022}']
    procedure Execute;
    procedure AbortJob;
    function AbortSupported: Boolean;
  end;

  IFDStanAsyncExecutor = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2023}']
    // private
    function GetState: TFDStanAsyncState;
    function GetMode: TFDStanAsyncMode;
    function GetTimeout: Cardinal;
    function GetOperation: IFDStanAsyncOperation;
    function GetHandler: IFDStanAsyncHandler;
    // public
    procedure Setup(const AOperation: IFDStanAsyncOperation;
      const AMode: TFDStanAsyncMode; const ATimeout: Cardinal;
      const AHandler: IFDStanAsyncHandler; ASilentMode: Boolean);
    procedure Run;
    procedure AbortJob;
    procedure Launched;
    // R/O
    property State: TFDStanAsyncState read GetState;
    property Mode: TFDStanAsyncMode read GetMode;
    property Timeout: Cardinal read GetTimeout;
    property Operation: IFDStanAsyncOperation read GetOperation;
    property Handler: IFDStanAsyncHandler read GetHandler;
  end;

  { --------------------------------------------------------------------------}
  { Storage interfaces                                                        }
  { --------------------------------------------------------------------------}
  TFDStorageFormat = (sfAuto, sfXML, sfBinary, sfJSON);
  TFDStorageMode = (smRead, smWrite);
  TFDStoreItem = (siMeta, siData, siDelta, siVisible);
  TFDStoreItems = set of TFDStoreItem;

  TFDStorageDeferredAction = procedure (const APropName, AValue: String) of object;
  TFDStorageLoaderProc = function (const AStorage: IFDStanStorage): TObject;
  TFDStorageSaverProc = procedure (AObject: TObject; const AStorage: IFDStanStorage);
  TFDStorageObjectStyle = (osObject, osFlatArray, osTypedArray);

  TFDStorableObject = class(TObject)
  protected
    class function GetClassPrefix: String; virtual;
    class function GetStreamingName(const AStorage: IFDStanStorage): String; virtual;
    class function GetObjectStyle: TFDStorageObjectStyle; virtual;
    procedure InternalSaveToStorage(const AStorage: IFDStanStorage); virtual;
    procedure InternalLoadFromStorage(const AStorage: IFDStanStorage); virtual;
  public
    constructor Create; overload; virtual;
    procedure SaveToStorage(const AStorage: IFDStanStorage);
    procedure LoadFromStorage(const AStorage: IFDStanStorage); overload;
  end;

  IFDStanStorage = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2031}']
    // private
    function GetMode: TFDStorageMode;
    function GetStreamVersion: Integer;
    function GetOwnStream: Boolean;
    procedure SetOwnStream(AValue: Boolean);
    // public
    procedure Open(AResOpts: TObject; AEncoder: TObject;
      const AFileName: String; AStream: TStream; AMode: TFDStorageMode);
    function IsOpen: Boolean;
    procedure Close;
    function IsObjectEnd(const AObjectName: String): Boolean;
    function ReadBoolean(const APropName: String; ADefValue: Boolean): Boolean;
    function ReadDate(const APropName: String; ADefValue: TDateTime): TDateTime;
    function ReadFloat(const APropName: String; ADefValue: Double): Double;
    function ReadInteger(const APropName: String; ADefValue: Integer): Integer;
    function ReadLongWord(const APropName: String; ADefValue: Cardinal): Cardinal;
    function ReadInt64(const APropName: String; ADefValue: Int64): Int64;
    function ReadObjectBegin(const AObjectName: String; AStyle: TFDStorageObjectStyle): String;
    procedure ReadObjectEnd(const AObjectName: String; AStyle: TFDStorageObjectStyle);
    function ReadAnsiString(const APropName: String; const ADefValue: TFDAnsiString): TFDAnsiString;
    function ReadString(const APropName: String; const ADefValue: UnicodeString): UnicodeString;
    function ReadValue(const APropName: String; APropIndex: Word; ADataType: TFDDataType;
      out ABuff: Pointer; out ALen: Cardinal): Boolean;
    function ReadEnum(const APropName: String; ATypeInfo: PTypeInfo;
      ADefValue: Integer): Integer;
    function TestObject(const AObjectName: String): Boolean;
    /// <summary> Combines TestObject and ReadObjectBegin methods. TestAndReadObjectBegin
    ///  does not raise an exception, like ReadObjectBegin, when a storage has not the
    ///  specified by AObjectName object. The method returns True, when there is specified
    ///  object, otherwise returns False and preserves the current position in storage. </summary>
    function TestAndReadObjectBegin(const AObjectName: String; AStyle: TFDStorageObjectStyle): Boolean;
    function TestProperty(const APropName: String): Boolean;
    function TestAndReadProperty(const APropName: String): Boolean;
    procedure WriteBoolean(const APropName: String; const AValue, ADefValue: Boolean);
    procedure WriteDate(const APropName: String; const AValue, ADefValue: TDateTime);
    procedure WriteFloat(const APropName: String; const AValue, ADefValue: Double);
    procedure WriteInteger(const APropName: String; const AValue, ADefValue: Integer);
    procedure WriteLongWord(const APropName: String; const AValue, ADefValue: Cardinal);
    procedure WriteInt64(const APropName: String; const AValue, ADefValue: Int64);
    procedure WriteObjectBegin(const AObjectName: String; AStyle: TFDStorageObjectStyle);
    procedure WriteObjectEnd(const AObjectName: String; AStyle: TFDStorageObjectStyle);
    procedure WriteAnsiString(const APropName: String; const AValue, ADefValue: TFDAnsiString);
    procedure WriteString(const APropName: String; const AValue, ADefValue: UnicodeString);
    procedure WriteValue(const APropName: String; APropIndex: Word; ADataType: TFDDataType;
      ABuff: Pointer; ALen: Cardinal);
    procedure WriteEnum(const APropName: String; ATypeInfo: PTypeInfo; const AValue,
      ADefValue: Integer);
    procedure LockDeferring;
    procedure UnLockDeferring;
    procedure DeferAction(const APropName, AValue: String; AAction: TFDStorageDeferredAction);
    function GetBookmark: TObject;
    procedure SetBookmark(const AValue: TObject);
    function IsStored(AItem: TFDStoreItem): Boolean;
    function BeginGrowthEstimation: Int64;
    procedure EndGrowthEstimation(ABase: Int64; ATimes: Cardinal);
    // high level
    function LoadObject: TObject;
    procedure SaveObject(AObject: TObject);
    procedure AddFilterObj(AKey, AFilter: TObject);
    procedure RemoveFilterObj(AKey: TObject);
    function GetFilterObj(AKey: TObject): TObject;
    // properties
    property Mode: TFDStorageMode read GetMode;
    property StreamVersion: Integer read GetStreamVersion;
    property OwnStream: Boolean read GetOwnStream write SetOwnStream;
  end;

  TFDStorageManager = class(TObject)
  private
    FClasses: TFDStringList;
    FPrevName: String;
    FPrevIndex: Integer;
    FLock: TCriticalSection;
    procedure LookupClass(const AName: String; var AClass: TClass;
      var ALoader: TFDStorageLoaderProc; var ASaver: TFDStorageSaverProc);
  public
    constructor Create;
    destructor Destroy; override;
    procedure RegisterClass(AClass: TFDStorableObjectClass); overload;
    procedure RegisterClassAlias(const AName: String; AClass: TFDStorableObjectClass);
    procedure RegisterClass(AClass: TClass; const AStreamingName: String;
      ALoader: TFDStorageLoaderProc; ASaver: TFDStorageSaverProc); overload;
    procedure SaveObject(AObject: TObject; const AStorage: IFDStanStorage);
    function LoadObject(const AStorage: IFDStanStorage): TObject;
  end;

  { --------------------------------------------------------------------------}
  { Debug monitor interfaces                                                  }
  { --------------------------------------------------------------------------}
  TFDMoniEventKind = (ekLiveCycle, ekError,
    ekConnConnect, ekConnTransact, ekConnService,
    ekCmdPrepare, ekCmdExecute, ekCmdDataIn, ekCmdDataOut,
    ekAdaptUpdate,
    ekVendor,
    ekComponent);
  TFDMoniEventKinds = set of TFDMoniEventKind;
  PFDMoniEventKinds = ^TFDMoniEventKinds;
  TFDMoniEventStep = (esStart, esProgress, esEnd);
  TFDMoniTracing = (eaAuto, eaTrue, eaFalse);
  TFDTraceFileColumns = set of (tiRefNo, tiTime, tiThreadID, tiClassName,
    tiObjID, tiMsgText);

{$IFDEF FireDAC_MONITOR}
  IFDMoniClientOutputHandler = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2028}']
    procedure HandleOutput(const AClassName, AObjName, AMessage: String);
  end;

  IFDMoniClient = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2005}']
    // private
    function GetTracing: Boolean;
    procedure SetTracing(const AValue: Boolean);
    function GetName: TComponentName;
    procedure SetName(const AValue: TComponentName);
    function GetEventKinds: TFDMoniEventKinds;
    procedure SetEventKinds(const AValue: TFDMoniEventKinds);
    function GetOutputHandler: IFDMoniClientOutputHandler;
    procedure SetOutputHandler(const AValue: IFDMoniClientOutputHandler);
    // public
    procedure Notify(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
      ASender: TObject; const AMsg: String; const AArgs: array of const);
    function RegisterAdapter(const AAdapter: IFDMoniAdapter): LongWord;
    procedure UnregisterAdapter(const AAdapter: IFDMoniAdapter);
    procedure AdapterChanged(const AAdapter: IFDMoniAdapter);
    procedure ResetFailure;
    property Tracing: Boolean read GetTracing write SetTracing;
    property Name: TComponentName read GetName write SetName;
    property EventKinds: TFDMoniEventKinds read GetEventKinds write SetEventKinds;
    property OutputHandler: IFDMoniClientOutputHandler read GetOutputHandler
      write SetOutputHandler;
  end;

  IFDMoniRemoteClient = interface(IFDMoniClient)
    ['{3E9B315B-F456-4175-A864-B2573C4A2026}']
    // private
    function GetHost: String;
    procedure SetHost(const AValue: String);
    function GetPort: Integer;
    procedure SetPortI(const AValue: Integer);
    function GetTimeout: Integer;
    procedure SetTimeout(const AValue: Integer);
    // public
    property Host: String read GetHost write SetHost;
    property Port: Integer read GetPort write SetPortI;
    property Timeout: Integer read GetTimeout write SetTimeout;
  end;

  IFDMoniCustomClient = interface(IFDMoniClient)
    ['{3E9B315B-F456-4175-A864-B2573C4A2030}']
    // private
    function GetSynchronize: Boolean;
    procedure SetSynchronize(AValue: Boolean);
    // public
    property Synchronize: Boolean read GetSynchronize write SetSynchronize;
  end;

  IFDMoniFlatFileClient = interface(IFDMoniCustomClient)
    ['{3E9B315B-F456-4175-A864-B2573C4A2027}']
    // private
    function GetFileName: String;
    procedure SetFileName(const Value: String);
    function GetFileAppend: Boolean;
    procedure SetFileAppend(const Value: Boolean);
    function GetFileColumns: TFDTraceFileColumns;
    procedure SetFileColumns(const Value: TFDTraceFileColumns);
    function GetFileEncoding: TFDEncoding;
    procedure SetFileEncoding(const AValue: TFDEncoding);
    // public
    property FileName: String read GetFileName write SetFileName;
    property FileAppend: Boolean read GetFileAppend write SetFileAppend;
    property FileColumns: TFDTraceFileColumns read GetFileColumns write SetFileColumns;
    property FileEncoding: TFDEncoding read GetFileEncoding write SetFileEncoding;
  end;
{$ENDIF}

  TFDMoniAdapterItemKind = (ikSQL, ikParam, ikStat, ikClientInfo, ikSessionInfo,
    ikFireDACInfo);
  TFDMoniAdapterItemKinds = set of TFDMoniAdapterItemKind;
  TFDMoniAdapterHelper = class(TObject)
  private
    FProxy: IFDStanObject;
    FRole: TComponentName;
    FHandle: LongWord;
    [Weak] FAdaptedObj: TObject;
    [Weak] FParentObj: TObject;
{$IFDEF FireDAC_MONITOR}
    FMoniClient: IFDMoniClient;
{$ENDIF}
    function GetIsRegistered: Boolean;
    function GetName: TComponentName;
    function GetParent: IFDStanObject;
  public
    constructor Create(const AAdapterObj, AParentObj: TObject);
    destructor Destroy; override;
    procedure SetOwner(const AOwner: TObject; const ARole: TComponentName);
{$IFDEF FireDAC_MONITOR}
    procedure RegisterClient(const AMoniClient: IFDMoniClient);
    procedure UnRegisterClient;
{$ENDIF}
    property IsRegistered: Boolean read GetIsRegistered;
    property Name: TComponentName read GetName;
    property Parent: IFDStanObject read GetParent;
    property Handle: LongWord read FHandle;
  end;

  IFDMoniAdapter = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2006}']
    // private
    function GetHandle: LongWord;
    function GetItemCount: Integer;
    function GetSupportItems: TFDMoniAdapterItemKinds;
    // public
    procedure GetItem(AIndex: Integer; out AName: String; out AValue: Variant;
      out AKind: TFDMoniAdapterItemKind);
    property Handle: LongWord read GetHandle;
    property ItemCount: Integer read GetItemCount;
    property SupportItems: TFDMoniAdapterItemKinds read GetSupportItems;
  end;

  // next GUID -> xxx033

const
  varFDAString = {$IFDEF NEXTGEN} varUString {$ELSE} varString {$ENDIF};
  C_FD_MaxInt64: Int64 = 9223372036854775807;
  C_FD_MinInt64: Int64 = -9223372036854775807;
  C_FD_MaxUTF8Len = 3;
  C_FD_Alignment = {$IFDEF CPUARM} 4 {$ELSE} 2 {$ENDIF};

  // Monitor default values
  C_FD_MonitorPort = 8050;
  C_FD_MonitorTimeout = 3000;
  C_FD_MonitorFileName = '$(TEMP)' + C_FD_PathDelim + 'trace$(NEXT).txt';
  C_FD_MonitorAppend = False;
  C_FD_MonitorColumns = [tiRefNo, tiTime, tiMsgText];
  C_FD_MonitorEncoding = 0;

  // DatS
  C_FD_AllTypes = [dtBoolean .. dtObject];
  C_FD_InvariantDataTypes = [dtRowSetRef, dtCursorRef, dtRowRef, dtArrayRef, dtParentRowRef];
  C_FD_BlobTypes = [dtBlob, dtMemo, dtWideMemo, dtXML, dtHBlob, dtHBFile, dtHMemo, dtWideHMemo];
  C_FD_StrTypes = [dtAnsiString, dtWideString, dtByteString];
  C_FD_VarLenTypes = C_FD_BlobTypes + C_FD_StrTypes;
  C_FD_WideTypes = [dtWideString, dtWideMemo, dtXML, dtWideHMemo];
  C_FD_AnsiTypes = [dtAnsiString, dtMemo, dtHMemo];
  C_FD_CharTypes = C_FD_WideTypes + C_FD_AnsiTypes;
  C_FD_NumTypes = [dtSByte, dtInt16, dtInt32, dtInt64,
                   dtByte, dtUInt16, dtUInt32, dtUInt64,
                   dtSingle, dtDouble, dtExtended,
                   dtCurrency, dtBCD, dtFmtBCD];
  C_FD_LateSerTypes = C_FD_BlobTypes + [dtByteString];
  C_FD_NumUnsignedTypes = [dtByte, dtUInt16, dtUInt32, dtUInt64];
  C_FD_NonSearchableDataTypes = C_FD_InvariantDataTypes + C_FD_BlobTypes;
  C_FD_DataTypeNames: array[TFDDataType] of String = (
    'Unknown',
    'Boolean',
    'SByte', 'Int16', 'Int32', 'Int64',
    'Byte', 'UInt16', 'UInt32', 'UInt64',
    'Single', 'Double', 'Extended',
    'Currency', 'BCD', 'FmtBCD',
    'DateTime', 'Time', 'Date', 'DateTimeStamp',
    'TimeIntervalFull', 'TimeIntervalYM', 'TimeIntervalDS',
    'AnsiString', 'WideString', 'ByteString',
    'Blob', 'Memo', 'WideMemo', 'XML',
    'HBlob', 'HMemo', 'WideHMemo',
    'HBFile',
    'RowSetRef', 'CursorRef', 'RowRef',
      'ArrayRef', 'ParentRowRef',
    'GUID', 'Object');

function FDStorageManager(): TFDStorageManager;

implementation

uses
  FireDAC.Stan.Util, FireDAC.Stan.Error;

var
  GStorageManager: TFDStorageManager = nil;

{-------------------------------------------------------------------------------}
function FDStorageManager(): TFDStorageManager;
begin
  if GStorageManager = nil then
    GStorageManager := TFDStorageManager.Create;
  Result := GStorageManager;
end;

{ ----------------------------------------------------------------------------- }
{ TFDValWrapper                                                                 }
{ ----------------------------------------------------------------------------- }
constructor TFDValWrapper.Create(APtr: Pointer);
begin
  inherited Create;
  FVal := NativeUInt(APtr);
end;

{ ----------------------------------------------------------------------------- }
constructor TFDValWrapper.Create(AVal: LongWord);
begin
  inherited Create;
  FVal := NativeUInt(AVal);
end;

{ ----------------------------------------------------------------------------- }
function TFDValWrapper.GetInt: Integer;
begin
  Result := Integer(FVal);
end;

{ ----------------------------------------------------------------------------- }
function TFDValWrapper.GetPtr: Pointer;
begin
  Result := Pointer(FVal);
end;

{ ----------------------------------------------------------------------------- }
{ TFDStringList                                                                 }
{ ----------------------------------------------------------------------------- }
procedure TFDStringList.AddPtr(const AStr: String; APtr: Pointer);
begin
{$IFDEF AUTOREFCOUNT}
  AddObject(AStr, TFDValWrapper.Create(APtr));
{$ELSE}
  AddObject(AStr, TObject(APtr));
{$ENDIF}
end;

{ ----------------------------------------------------------------------------- }
procedure TFDStringList.AddInt(const AStr: String; AInt: LongWord);
begin
{$IFDEF AUTOREFCOUNT}
  AddObject(AStr, TFDValWrapper.Create(AInt));
{$ELSE}
  AddObject(AStr, TObject(AInt));
{$ENDIF}
end;

{ ----------------------------------------------------------------------------- }
function TFDStringList.GetPtrs(AIndex: Integer): Pointer;
begin
{$IFDEF AUTOREFCOUNT}
  Result := Pointer(TFDValWrapper(inherited Objects[AIndex]).FVal);
{$ELSE}
  Result := Pointer(inherited Objects[AIndex]);
{$ENDIF}
end;

{ ----------------------------------------------------------------------------- }
procedure TFDStringList.SetPtrs(AIndex: Integer; const AValue: Pointer);
begin
{$IFDEF AUTOREFCOUNT}
  inherited Objects[AIndex] := TFDValWrapper.Create(AValue);
{$ELSE}
  inherited Objects[AIndex] := TObject(AValue);
{$ENDIF}
end;

{ ----------------------------------------------------------------------------- }
function TFDStringList.GetInts(AIndex: Integer): LongWord;
begin
{$IFDEF AUTOREFCOUNT}
  Result := LongWord(TFDValWrapper(inherited Objects[AIndex]).FVal);
{$ELSE}
  Result := LongWord(Pointer(inherited Objects[AIndex]));
{$ENDIF}
end;

{ ----------------------------------------------------------------------------- }
procedure TFDStringList.SetInts(AIndex: Integer; const AValue: LongWord);
begin
{$IFDEF AUTOREFCOUNT}
  inherited Objects[AIndex] := TFDValWrapper.Create(AValue);
{$ELSE}
  inherited Objects[AIndex] := TObject(AValue);
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
{ TFDConnectionDefParams                                                        }
{-------------------------------------------------------------------------------}
constructor TFDConnectionDefParams.Create(const ADef: IFDStanDefinition);
begin
  inherited Create;
  FDef := ADef;
  FDef._Release;
end;

{-------------------------------------------------------------------------------}
destructor TFDConnectionDefParams.Destroy;
begin
  Pointer(FDef) := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefParams.GetDriverID: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_DriverID];
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectionDefParams.SetDriverID(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_DriverID] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefParams.GetPooled: Boolean;
begin
  Result := FDef.AsBoolean[S_FD_ConnParam_Common_Pooled];
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectionDefParams.SetPooled(const AValue: Boolean);
begin
  FDef.AsBoolean[S_FD_ConnParam_Common_Pooled] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefParams.GetDatabase: TFileName;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_Database];
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectionDefParams.SetDatabase(const AValue: TFileName);
begin
  FDef.AsString[S_FD_ConnParam_Common_Database] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefParams.GetUserName: String;
var
  iLvlStd, iLvlBDE: Integer;
  lStd, lBde: Boolean;
begin
  iLvlStd := 0;
  iLvlBDE := 0;
  lStd := FDef.HasValue(S_FD_ConnParam_Common_UserName, iLvlStd);
  lBde := FDef.HasValue(S_FD_ConnParam_Common_BDEStyleUserName, iLvlBDE);
  if lStd or lBde then
    if iLvlStd < iLvlBDE then
      Result := FDef.AsString[S_FD_ConnParam_Common_UserName]
    else
      Result := FDef.AsString[S_FD_ConnParam_Common_BDEStyleUserName];
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectionDefParams.SetUserName(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_UserName] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefParams.GetPassword: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_Password];
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectionDefParams.SetPassword(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_Password] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefParams.GetMonitorBy: TFDMonitorBy;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_Common_MonitorBy];
  if (s <> '') and FDInSet(s[Length(s)], ['-', '+']) then
    s := Copy(s, 1, Length(s) - 1);
  if CompareText(s, '') = 0 then
    Result := mbNone
  else if CompareText(s, S_FD_MoniFlatFile) = 0 then
    Result := mbFlatFile
  else if CompareText(s, S_FD_MoniRemote) = 0 then
    Result := mbRemote
  else if CompareText(s, S_FD_MoniCustom) = 0 then
    Result := mbCustom
  else
    Result := mbNone;
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectionDefParams.SetMonitorBy(const AValue: TFDMonitorBy);
const
  C_MonitorBy: array[TFDMonitorBy] of String = ('', S_FD_MoniFlatFile, S_FD_MoniRemote, S_FD_MoniCustom);
begin
  FDef.AsString[S_FD_ConnParam_Common_MonitorBy] := C_MonitorBy[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefParams.GetMonitorByInitial: Boolean;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_Common_MonitorBy];
  Result := (s <> '') and (s[Length(s)] <> '-');
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectionDefParams.SetMonitorByInitial(const AValue: Boolean);
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_Common_MonitorBy];
  if s <> '' then begin
    if FDInSet(s[Length(s)], ['-', '+']) then
      s := Copy(s, 1, Length(s) - 1);
    if AValue then
      s := s + '+';
    FDef.AsString[S_FD_ConnParam_Common_MonitorBy] := s;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefParams.GetPoolCleanupTimeout: Integer;
begin
  if not FDef.HasValue(S_FD_ConnParam_Common_POOL_CleanupTimeout) then
    Result := 30000
  else
    Result := FDef.AsInteger[S_FD_ConnParam_Common_POOL_CleanupTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectionDefParams.SetPoolCleanupTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_Pool_CleanupTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefParams.GetPoolExpireTimeout: Integer;
begin
  if not FDef.HasValue(S_FD_ConnParam_Common_POOL_ExpireTimeout) then
    Result := 90000
  else
    Result := FDef.AsInteger[S_FD_ConnParam_Common_POOL_ExpireTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectionDefParams.SetPoolExpireTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_Pool_ExpireTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefParams.GetPoolMaximumItems: Integer;
begin
  if not FDef.HasValue(S_FD_ConnParam_Common_POOL_MaximumItems) then
    Result := 50
  else
    Result := FDef.AsInteger[S_FD_ConnParam_Common_POOL_MaximumItems];
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectionDefParams.SetPoolMaximumItems(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_Pool_MaximumItems] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefParams.GetNewPassword: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_NewPassword];
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectionDefParams.SetNewPassword(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_NewPassword] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefParams.GetExpandedDatabase: String;
begin
  Result := FDExpandStr(Database);
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefParams.GetConnectionDef: String;
begin
  Result := FDef.AsString[S_FD_DefinitionParam_Common_ConnectionDef];
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectionDefParams.SetConnectionDef(const AValue: String);
begin
  FDef.AsString[S_FD_DefinitionParam_Common_ConnectionDef] := AValue;
end;

{-------------------------------------------------------------------------------}
{ TFDStorableObject                                                             }
{-------------------------------------------------------------------------------}
constructor TFDStorableObject.Create;
begin
  inherited Create;
end;

{-------------------------------------------------------------------------------}
class function TFDStorableObject.GetClassPrefix: String;
begin
  Result := 'TFD';
end;

{-------------------------------------------------------------------------------}
class function TFDStorableObject.GetStreamingName(const AStorage: IFDStanStorage): String;
begin
  Result := Copy(ClassName, Length(GetClassPrefix()) + 1, Length(ClassName));
end;

{-------------------------------------------------------------------------------}
class function TFDStorableObject.GetObjectStyle: TFDStorageObjectStyle;
begin
  Result := osObject;
end;

{-------------------------------------------------------------------------------}
procedure TFDStorableObject.InternalLoadFromStorage(const AStorage: IFDStanStorage);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDStorableObject.InternalSaveToStorage(const AStorage: IFDStanStorage);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDStorableObject.LoadFromStorage(const AStorage: IFDStanStorage);
var
  sName: String;
  eStyle: TFDStorageObjectStyle;
begin
  sName := GetStreamingName(AStorage);
  eStyle := GetObjectStyle;
  AStorage.ReadObjectBegin(sName, eStyle);
  AStorage.LockDeferring;
  try
    InternalLoadFromStorage(AStorage);
  finally
    AStorage.UnLockDeferring;
    AStorage.ReadObjectEnd(sName, eStyle);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDStorableObject.SaveToStorage(const AStorage: IFDStanStorage);
var
  sName: String;
  eStyle: TFDStorageObjectStyle;
begin
  sName := GetStreamingName(AStorage);
  eStyle := GetObjectStyle;
  AStorage.WriteObjectBegin(sName, eStyle);
  try
    InternalSaveToStorage(AStorage);
  finally
    AStorage.WriteObjectEnd(sName, eStyle);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDStorageManager                                                             }
{-------------------------------------------------------------------------------}
type
  TFDStorageReg = class(TObject)
  private
    FClass: TClass;
    FLoader: TFDStorageLoaderProc;
    FSaver: TFDStorageSaverProc;
    constructor Create(AClass: TClass; ALoader: TFDStorageLoaderProc;
      ASaver: TFDStorageSaverProc);
  end;

constructor TFDStorageReg.Create(AClass: TClass; ALoader: TFDStorageLoaderProc;
  ASaver: TFDStorageSaverProc);
begin
  inherited Create;
  FClass := AClass;
  FLoader := ALoader;
  FSaver := ASaver;
end;

{-------------------------------------------------------------------------------}
constructor TFDStorageManager.Create;
begin
  inherited Create;
  FLock := TCriticalSection.Create;
  FClasses := TFDStringList.Create(dupError, True, False);
  FClasses.OwnsObjects := True;
end;

{-------------------------------------------------------------------------------}
destructor TFDStorageManager.Destroy;
begin
  FDFreeAndNil(FClasses);
  FDFreeAndNil(FLock);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDStorageManager.RegisterClass(AClass: TFDStorableObjectClass);
begin
  RegisterClass(AClass, TFDStorableObjectClass(AClass).GetStreamingName(nil), nil, nil);
end;

{-------------------------------------------------------------------------------}
procedure TFDStorageManager.RegisterClassAlias(const AName: String; AClass: TFDStorableObjectClass);
begin
  RegisterClass(AClass, AName, nil, nil);
end;

{-------------------------------------------------------------------------------}
procedure TFDStorageManager.RegisterClass(AClass: TClass; const AStreamingName: String;
  ALoader: TFDStorageLoaderProc; ASaver: TFDStorageSaverProc);
begin
  FLock.Enter;
  try
    FClasses.AddObject(AStreamingName, TFDStorageReg.Create(AClass, ALoader, ASaver));
  finally
    FLock.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDStorageManager.LookupClass(const AName: String;
  var AClass: TClass; var ALoader: TFDStorageLoaderProc;
  var ASaver: TFDStorageSaverProc);
var
  i: Integer;
  oReg: TFDStorageReg;
begin
  FLock.Enter;
  try
    if FPrevName <> AName then begin
      i := FClasses.IndexOf(AName);
      if i = -1 then
        FDException(Self, [S_FD_LStan], er_FD_StanStrgClassUnknown, [AName]);
      FPrevName := AName;
      FPrevIndex := i;
    end
    else
      i := FPrevIndex;
    oReg := TFDStorageReg(FClasses.Objects[i]);
    AClass := oReg.FClass;
    ALoader := oReg.FLoader;
    ASaver := oReg.FSaver;
  finally
    FLock.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDStorageManager.SaveObject(AObject: TObject; const AStorage: IFDStanStorage);
var
  sName: String;
  oClass: TClass;
  oLoader: TFDStorageLoaderProc;
  oSaver: TFDStorageSaverProc;
begin
  if AObject is TFDStorableObject then
    sName := TFDStorableObject(AObject).GetStreamingName(AStorage)
  else
    sName := AObject.ClassName;
  LookupClass(sName, oClass, oLoader, oSaver);
  if not Assigned(oSaver) then
    TFDStorableObject(AObject).SaveToStorage(AStorage)
  else
    oSaver(AObject, AStorage);
end;

{-------------------------------------------------------------------------------}
function TFDStorageManager.LoadObject(const AStorage: IFDStanStorage): TObject;
var
  sName: String;
  oClass: TClass;
  oLoader: TFDStorageLoaderProc;
  oSaver: TFDStorageSaverProc;
begin
  sName := AStorage.ReadObjectBegin('', osObject);
  try
    LookupClass(sName, oClass, oLoader, oSaver);
    if not Assigned(oLoader) then begin
      Result := TFDStorableObjectClass(oClass).Create;
      TFDStorableObject(Result).InternalLoadFromStorage(AStorage);
    end
    else
      Result := oLoader(AStorage);
  finally
    AStorage.ReadObjectEnd(sName, osObject);
  end;
end;

{ ----------------------------------------------------------------------------- }
{ TFDPhysMoniAdapterComponentProxy                                              }
{ ----------------------------------------------------------------------------- }
type
  TFDMoniAdapterComponentProxy = class(TInterfacedObject, IFDStanObject)
  private
    [Weak] FComp: TComponent;
  protected
    // IFDStanObject
    function GetName: TComponentName;
    function GetParent: IFDStanObject;
    procedure BeforeReuse;
    procedure AfterReuse;
    procedure SetOwner(const AOwner: TObject; const ARole: TComponentName);
  public
    constructor Create(AComp: TComponent);
    destructor Destroy; override;
  end;

{ ----------------------------------------------------------------------------- }
constructor TFDMoniAdapterComponentProxy.Create(AComp: TComponent);
begin
  inherited Create;
  FComp := AComp;
end;

{ ----------------------------------------------------------------------------- }
destructor TFDMoniAdapterComponentProxy.Destroy;
begin
  inherited Destroy;
end;

{ ----------------------------------------------------------------------------- }
function TFDMoniAdapterComponentProxy.GetName: TComponentName;
begin
  if FComp.GetNamePath = '' then
    Result := FComp.ClassName + '($' + IntToHex(Integer(FComp), 8) + ')'
  else
    Result := FComp.GetNamePath;
end;

{ ----------------------------------------------------------------------------- }
function TFDMoniAdapterComponentProxy.GetParent: IFDStanObject;

  function IsApp(AComp: TComponent): Boolean;
  var
    oClass: TClass;
  begin
    oClass := AComp.ClassType;
    while (oClass <> nil) and not oClass.ClassNameIs('TApplication') do
      oClass := oClass.ClassParent;
    Result := (oClass <> nil);
  end;

begin
  Result := nil;
  if (FComp.Owner <> nil) and not IsApp(FComp.Owner) then
    if FComp.Owner.GetInterfaceEntry(IFDStanObject) = nil then
      Result := TFDMoniAdapterComponentProxy.Create(FComp.Owner) as IFDStanObject
    else
      Supports(FComp.Owner, IFDStanObject, Result);
end;

{ ----------------------------------------------------------------------------- }
procedure TFDMoniAdapterComponentProxy.BeforeReuse;
begin
  // nothing
end;

{ ----------------------------------------------------------------------------- }
procedure TFDMoniAdapterComponentProxy.AfterReuse;
begin
  // nothing
end;

{ ----------------------------------------------------------------------------- }
procedure TFDMoniAdapterComponentProxy.SetOwner(
  const AOwner: TObject; const ARole: TComponentName);
begin
  // nothing
end;

{ ----------------------------------------------------------------------------- }
{ TFDMoniAdapterHelper                                                          }
{ ----------------------------------------------------------------------------- }
constructor TFDMoniAdapterHelper.Create(const AAdapterObj, AParentObj: TObject);
begin
  inherited Create;
  FAdaptedObj := AAdapterObj;
  FParentObj := AParentObj;
end;

{ ----------------------------------------------------------------------------- }
destructor TFDMoniAdapterHelper.Destroy;
{$IFDEF FireDAC_MONITOR}
var
  oIntf: IFDMoniAdapter;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if (FMoniClient <> nil) and (FHandle <> 0) then begin
    if Supports(FAdaptedObj, IFDMoniAdapter, oIntf) then
      FMoniClient.UnregisterAdapter(oIntf);
  end;
  FProxy := nil;
{$ENDIF}
  inherited Destroy;
end;

{ ----------------------------------------------------------------------------- }
procedure TFDMoniAdapterHelper.SetOwner(const AOwner: TObject;
  const ARole: TComponentName);
begin
  if AOwner is TComponent then begin
    FProxy := TFDMoniAdapterComponentProxy.Create(TComponent(AOwner));
    FParentObj := nil;
  end
  else begin
    FProxy := nil;
    FParentObj := AOwner;
  end;
  FRole := ARole;
end;

{-------------------------------------------------------------------------------}
function TFDMoniAdapterHelper.GetIsRegistered: Boolean;
begin
{$IFDEF FireDAC_MONITOR}
  Result := FHandle <> 0;
{$ELSE}
  Result := False;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
procedure TFDMoniAdapterHelper.RegisterClient(const AMoniClient: IFDMoniClient);
var
  oIntf: IFDMoniAdapter;
begin
  if not IsRegistered and (AMoniClient <> nil) and AMoniClient.Tracing then begin
    FMoniClient := AMoniClient;
    if Supports(FAdaptedObj, IFDMoniAdapter, oIntf) then begin
      FHandle := FMoniClient.RegisterAdapter(oIntf);
      FMoniClient.AdapterChanged(oIntf);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniAdapterHelper.UnRegisterClient;
var
  oIntf: IFDMoniAdapter;
begin
  if IsRegistered and (FMoniClient <> nil) then
    try
      if Supports(FAdaptedObj, IFDMoniAdapter, oIntf) then
        FMoniClient.UnregisterAdapter(oIntf);
    finally
      FHandle := 0;
    end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
function TFDMoniAdapterHelper.GetName: TComponentName;
begin
  if FProxy <> nil then
    Result := FProxy.Name
  else
    Result := FAdaptedObj.ClassName + '($' + IntToHex(Integer(FAdaptedObj), 8) + ')';
  if FRole <> '' then
    Result := FRole + ': ' + Result;
end;

{-------------------------------------------------------------------------------}
function TFDMoniAdapterHelper.GetParent: IFDStanObject;
begin
  if FProxy <> nil then
    Result := FProxy.Parent
  else
    Supports(FParentObj, IFDStanObject, Result);
end;

{-------------------------------------------------------------------------------}
initialization

finalization
  FDFreeAndNil(GStorageManager);

end.

