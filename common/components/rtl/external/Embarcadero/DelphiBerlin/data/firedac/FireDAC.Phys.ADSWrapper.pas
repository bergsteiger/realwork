{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{ FireDAC Advantage Database Server API wrapping classes}
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.ADSWrapper;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  System.Classes, System.Generics.Collections,
  FireDAC.Stan.Util, FireDAC.Stan.Intf, FireDAC.Stan.Error, FireDAC.Stan.Consts,
  FireDAC.Phys.ADSCli;

type
  EADSNativeException = class;
  TADSLib = class;
  TADSHandle = class;
  TADSConnection = class;
  TADSColumnDef = class;
  TADSBLOBStream = class;
  TADSVariable = class;
  TADSVariables = class;
  TADSStatement = class;
  TADSCursor = class;
  TADSTable = class;
  TADSDictionary = class;

  EADSNativeException = class(EFDDBEngineException)
  public
    constructor Create(ACode: UNSIGNED32; ALib: TADSLib; AOwner: TADSHandle = nil); overload;
  end;

  TADSLib = class(TFDLibrary)
  private
    FEncoder: TFDEncoder;
    FVersionStr: String;
    FServers: TStrings;
    procedure UpdateVersion;
    procedure Check(ACode: UNSIGNED32);
    function GetDateFormat: String;
    procedure SetDateFormat(const AValue: String);
    function GetDecimals: Word;
    procedure SetDecimals(const AValue: Word);
    function GetDefaultPath: String;
    procedure SetDefaultPath(const AValue: String);
    function GetShowDeleted: Boolean;
    procedure SetShowDeleted(const AValue: Boolean);
    function GetEpoch: Word;
    procedure SetEpoch(const AValue: Word);
    function GetExact: Boolean;
    procedure SetExact(const AValue: Boolean);
    function GetSearchPath: String;
    procedure SetSearchPath(const AValue: String);
    function GetAliasFileName: String;
  protected
    procedure LoadEntries; override;
  public
    FAdsNullTerminateStrings: TAdsNullTerminateStrings;
    FAdsGetLastError: TAdsGetLastError;
    FAdsConnect101: TAdsConnect101;
    FAdsConnect60: TAdsConnect60;
    FAdsDisconnect: TAdsDisconnect;
    FAdsBeginTransaction: TAdsBeginTransaction;
    FAdsCreateSavepoint: TAdsCreateSavepoint;
    FAdsCommitTransaction: TAdsCommitTransaction;
    FAdsRollbackTransaction80: TAdsRollbackTransaction80;
    FAdsGetTransactionCount: TAdsGetTransactionCount;
    FAdsDisableAutoIncEnforcement: TAdsDisableAutoIncEnforcement;
    FAdsEnableAutoIncEnforcement: TAdsEnableAutoIncEnforcement;
    FAdsDisableRI: TAdsDisableRI;
    FAdsEnableRI: TAdsEnableRI;
    FAdsDisableUniqueEnforcement: TAdsDisableUniqueEnforcement;
    FAdsEnableUniqueEnforcement: TAdsEnableUniqueEnforcement;
    FAdsFindServers: TAdsFindServers;
    FAdsGetCollation: TAdsGetCollation;
    FAdsSetCollation: TAdsSetCollation;
    FAdsGetConnectionPath: TAdsGetConnectionPath;
    FAdsGetDateFormat: TAdsGetDateFormat;
    FAdsSetDateFormat: TAdsSetDateFormat;
    FAdsGetDateFormat60: TAdsGetDateFormat60;
    FAdsSetDateFormat60: TAdsSetDateFormat60;
    FAdsGetDecimals: TAdsGetDecimals;
    FAdsSetDecimals: TAdsSetDecimals;
    FAdsGetDefault: TAdsGetDefault;
    FAdsSetDefault: TAdsSetDefault;
    FAdsGetDeleted: TAdsGetDeleted;
    FAdsShowDeleted: TAdsShowDeleted;
    FAdsGetEpoch: TAdsGetEpoch;
    FAdsSetEpoch: TAdsSetEpoch;
    FAdsGetExact: TAdsGetExact;
    FAdsSetExact: TAdsSetExact;
    FAdsGetSearchPath: TAdsGetSearchPath;
    FAdsSetSearchPath: TAdsSetSearchPath;
    FAdsGetVersion: TAdsGetVersion;
    FAdsIsConnectionAlive: TAdsIsConnectionAlive;
{$IFDEF FireDAC_64}
    FAdsRegisterCallbackFunction101: TAdsRegisterCallbackFunction101;
{$ELSE}
    FAdsRegisterCallbackFunction: TAdsRegisterCallbackFunction;
{$ENDIF}
    FAdsClearCallbackFunction: TAdsClearCallbackFunction;
    FAdsDDGetDatabaseProperty: TAdsDDGetDatabaseProperty;
    FAdsDDSetDatabaseProperty: TAdsDDSetDatabaseProperty;

    FAdsCreateSQLStatement: TAdsCreateSQLStatement;
    FAdsPrepareSQLW: TAdsPrepareSQLW;
    FAdsExecuteSQLDirectW: TAdsExecuteSQLDirectW;
    FAdsPrepareSQL: TAdsPrepareSQL;
    FAdsExecuteSQLDirect: TAdsExecuteSQLDirect;
    FAdsCloseSQLStatement: TAdsCloseSQLStatement;
    FAdsClearSQLParams: TAdsClearSQLParams;
    FAdsExecuteSQL: TAdsExecuteSQL;
    FAdsGetLastAutoinc: TAdsGetLastAutoinc;
    FAdsSetSQLTimeout: TAdsSetSQLTimeout;
    FAdsStmtSetTableReadOnly: TAdsStmtSetTableReadOnly;
    FAdsStmtSetTableCharType: TAdsStmtSetTableCharType;
    FAdsStmtSetTableCollation: TAdsStmtSetTableCollation;
    FAdsStmtSetTableLockType: TAdsStmtSetTableLockType;
    FAdsStmtSetTableType: TAdsStmtSetTableType;
    FAdsStmtSetTablePassword: TAdsStmtSetTablePassword;
    FAdsGetBinary: TAdsGetBinary;
    FAdsSetBinary: TAdsSetBinary;
    FAdsGetBinaryLength: TAdsGetBinaryLength;
    FAdsGetMemoLength: TAdsGetMemoLength;
    FAdsFileToBinary: TAdsFileToBinary;
    FAdsBinaryToFile: TAdsBinaryToFile;
    FAdsIsNull: TAdsIsNull;
    FAdsSetNull: TAdsSetNull;
    FAdsIsEmpty: TAdsIsEmpty;
    FAdsSetEmpty: TAdsSetEmpty;
    FAdsGetLogical: TAdsGetLogical;
    FAdsGetString: TAdsGetString;
    FAdsGetDouble: TAdsGetDouble;
    FAdsGetLong: TAdsGetLong;
    FAdsGetShort: TAdsGetShort;
    FAdsGetLongLong: TAdsGetLongLong;
    FAdsGetJulian: TAdsGetJulian;
    FAdsGetMilliseconds: TAdsGetMilliseconds;
    FAdsGetFieldLength: TAdsGetFieldLength;
    FAdsGetFieldLength100: TAdsGetFieldLength100;
    FAdsGetStringW: TAdsGetStringW;
    FAdsGetField: TAdsGetField;
    FAdsSetLogical: TAdsSetLogical;
    FAdsSetString: TAdsSetString;
    FAdsSetDouble: TAdsSetDouble;
    FAdsSetLong: TAdsSetLong;
    FAdsSetShort: TAdsSetShort;
    FAdsSetLongLong: TAdsSetLongLong;
    FAdsSetJulian: TAdsSetJulian;
    FAdsSetMilliseconds: TAdsSetMilliseconds;
    FAdsSetStringW: TAdsSetStringW;
    FAdsSetField: TAdsSetField;
    FAdsSetTimeStampRaw: TAdsSetTimeStampRaw;
    FAdsGetRecordCount: TAdsGetRecordCount;
    FAdsGetNumFields: TAdsGetNumFields;
    FAdsAtBOF: TAdsAtBOF;
    FAdsAtEOF: TAdsAtEOF;
    FAdsCacheRecords: TAdsCacheRecords;
    FAdsCloseTable: TAdsCloseTable;
    FAdsSkip: TAdsSkip;
    FAdsGetRecordNum: TAdsGetRecordNum;
    FAdsGotoRecord: TAdsGotoRecord;
    FAdsGotoTop: TAdsGotoTop;
    FAdsGotoBottom: TAdsGotoBottom;
    FAdsGetFieldType: TAdsGetFieldType;
    FAdsGetMemoDataType: TAdsGetMemoDataType;
    FAdsGetFieldDecimals: TAdsGetFieldDecimals;
    FAdsGetFieldName: TAdsGetFieldName;
    FAdsGetKeyColumn: TAdsGetKeyColumn;
    FAdsGetLastTableUpdate: TAdsGetLastTableUpdate;
    FAdsConvertStringToJulian: TAdsConvertStringToJulian;
    FAdsAppendRecord: TAdsAppendRecord;
    FAdsDeleteRecord: TAdsDeleteRecord;
    FAdsWriteRecord: TAdsWriteRecord;
    FAdsRecallRecord: TAdsRecallRecord;
    FAdsRecallAllRecords: TAdsRecallAllRecords;
    FAdsIsRecordDeleted: TAdsIsRecordDeleted;
    FAdsOpenTable101: TAdsOpenTable101;
    FAdsOpenTable: TAdsOpenTable;
    FAdsCreateTable: TAdsCreateTable;
    FAdsPackTable: TAdsPackTable;
    FAdsZapTable: TAdsZapTable;
    FAdsGetTableType: TAdsGetTableType;
    FAdsGetTableRights: TAdsGetTableRights;
    FAdsGetTableLockType: TAdsGetTableLockType;
    FAdsGetTableCharType: TAdsGetTableCharType;
    FAdsCreateIndex: TAdsCreateIndex;
    FAdsCopyTable: TAdsCopyTable;
    FAdsEnableEncryption: TAdsEnableEncryption;
    FAdsEncryptTable: TAdsEncryptTable;
    FAdsIsTableEncrypted: TAdsIsTableEncrypted;
    FAdsDecryptTable: TAdsDecryptTable;
    FAdsReindex: TAdsReindex;
    FAdsLockRecord: TAdsLockRecord;
    FAdsUnLockRecord: TAdsUnlockRecord;

    FAdsMgGetInstallInfo: TAdsMgGetInstallInfo;
    constructor Create(AOwningObj: TObject = nil);
    destructor Destroy; override;
    procedure Load(const AVendorHome, AVendorLib: String);
    procedure ListServers(AList: TStrings);
    procedure ListAliases(AList: TStrings);
    function ResolveAlias(const AName: String; var APath: String; AType: String): Boolean;
    class function DumpField(AField: PAceChar): String; static;

    property AliasFileName: String read GetAliasFileName;
    property Encoder: TFDEncoder read FEncoder;

    // Library settings
    property DateFormat: String read GetDateFormat write SetDateFormat;
    property Decimals: Word read GetDecimals write SetDecimals;
    property DefaultPath: String read GetDefaultPath write SetDefaultPath;
    property SearchPath: String read GetSearchPath write SetSearchPath;
    property ShowDeleted: Boolean read GetShowDeleted write SetShowDeleted;
    property Epoch: Word read GetEpoch write SetEpoch;
    property Exact: Boolean read GetExact write SetExact;
  end;

  TADSHandle = class(TObject)
  private
    FLib: TADSLib;
    FHandle: ADSHANDLE;
    FOwnHandle: Boolean;
    [weak] FOwningObj: TObject;
    [weak] FConnection: TADSConnection;
    FEncoder: TFDEncoder;
{$IFDEF FireDAC_MONITOR}
    function GetTracing: Boolean; inline;
{$ENDIF}
  protected
{$IFDEF FireDAC_MONITOR}
    procedure Trace(const AMsg: String; const AArgs: array of const); overload;
    procedure Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
      const AMsg: String; const AArgs: array of const); overload;
    property Tracing: Boolean read GetTracing;
{$ENDIF}
  public
    constructor Create;
    constructor CreateUsingHandle(AHandle: ADSHANDLE);
    destructor Destroy; override;
    procedure Check(ACode: UNSIGNED32);
    property Handle: ADSHANDLE read FHandle;
    property Lib: TADSLib read FLib;
    property OwningObj: TObject read FOwningObj write FOwningObj;
    property Connection: TADSConnection read FConnection;
    property Encoder: TFDEncoder read FEncoder;
  end;

  TADSProgressCallback = procedure (ASender: TADSConnection;
    APercent: Word; var AAbort: Boolean) of object;

  TADSConnection = class(TADSHandle)
  private
    FServerVersion: TFDVersion;
    FAutoIncEnforcement: Boolean;
    FRIEnforcement: Boolean;
    FUniqueEnforcement: Boolean;
    FAbortRequest: Boolean;
    FLastAutoInc: UNSIGNED32;
    FServerVersionStr: String;
    FOnProgress: TADSProgressCallback;
    FProgressCount: Integer;
{$IFDEF FireDAC_MONITOR}
    FTracing: Boolean;
    FMonitor: IFDMoniClient;
{$ENDIF}
    procedure BeforeConnecting;
    procedure AfterConnecting;
    function GetTransactionCount: UNSIGNED32;
    procedure SetAutoIncEnforcement(const AValue: Boolean);
    procedure SetRIEnforcement(const AValue: Boolean);
    procedure SetUniqueEnforcement(const AValue: Boolean);
    function GetCollation: String;
    procedure SetCollation(const AValue: String);
    function GetDateFormat: String;
    procedure SetDateFormat(const AValue: String);
    function GetConnectionPath: String;
    function DoProgress(usPercent: UNSIGNED16): Boolean;
    procedure SetOnProgress(const AValue: TADSProgressCallback);
  public
    constructor Create(ALib: TADSLib; AOwningObj: TObject = nil
      {$IFDEF FireDAC_Monitor}; const AMonitor: IFDMoniClient = nil {$ENDIF});
    constructor CreateUsingHandle(ALib: TADSLib; AHandle: ADSHANDLE;
      AOwningObj: TObject = nil {$IFDEF FireDAC_Monitor}; const AMonitor: IFDMoniClient = nil {$ENDIF});
    destructor Destroy; override;
    procedure Connect101(const AConnStr: String);
    procedure Connect60(const AConnPath: String; AServerTypes: UNSIGNED16;
      AUserName, APassword: String; AOptions: UNSIGNED32);
    procedure Disconnect;
    function Ping: Boolean;
    procedure BeginTransaction(const AName: String);
    procedure Commit;
    procedure Rollback(const AName: String);
    procedure EnableProgress;
    procedure DisableProgress;
    procedure Abort;
    property TransactionCount: UNSIGNED32 read GetTransactionCount;
    property ServerVersion: TFDVersion read FServerVersion;
    property ServerVersionStr: String read FServerVersionStr;
    property LastAutoInc: UNSIGNED32 read FLastAutoInc;
    property ConnectionPath: String read GetConnectionPath;
    property AutoIncEnforcement: Boolean read FAutoIncEnforcement write SetAutoIncEnforcement;
    property RIEnforcement: Boolean read FRIEnforcement write SetRIEnforcement;
    property UniqueEnforcement: Boolean read FUniqueEnforcement write SetUniqueEnforcement;
    property Collation: String read GetCollation write SetCollation;
    property DateFormat: String read GetDateFormat write SetDateFormat;
{$IFDEF FireDAC_MONITOR}
    property Monitor: IFDMoniClient read FMonitor write FMonitor;
    property Tracing: Boolean read FTracing write FTracing;
{$ENDIF}
    property OnProgress: TADSProgressCallback read FOnProgress write SetOnProgress;
  end;

  TADSColumnDef = class(TObject)
  private
    FCursor: TADSCursor;
    FPosition: UNSIGNED16;
    FLength: UNSIGNED32;
    FName: String;
    FFieldType: UNSIGNED16;
    FPrecision: UNSIGNED32;
    FScale: UNSIGNED16;
    FMemoType: UNSIGNED16;
  public
    constructor Create(ACursor: TADSCursor; AIndex: Integer);
    property Name: String read FName;
    property Position: UNSIGNED16 read FPosition;
    property FieldType: UNSIGNED16 read FFieldType;
    property MemoType: UNSIGNED16 read FMemoType;
    property Precision: UNSIGNED32 read FPrecision;
    property Scale: UNSIGNED16 read FScale;
    property Length: UNSIGNED32 read FLength;
  end;

  TADSBLOBStream = class(TStream)
  private
    FObj: TADSHandle;
    FVariable: TADSVariable;
    FPosition: Int64;
    FSize: Int64;
    constructor Create(AObj: TADSHandle; AVariable: TADSVariable);
  protected
    procedure SetSize(NewSize: Longint); override;
  public
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
    procedure SaveToFile(const AFileName: string);
    procedure LoadFromFile(const AFileName: string);
    property Obj: TADSHandle read FObj;
  end;

  TADSVariable = class(TObject)
  private
    FObj: TADSHandle;
    [weak] FVars: TADSVariables;
    FField: PAceChar;
    FValueType: UNSIGNED16;
    FIsImage: Boolean;
    FName: String;
    FNameBytes: TFDByteString;
    function GetIsNull: Boolean;
    function GetPosition: UNSIGNED16;
    procedure SetName(const AValue: String);
    procedure SetPosition(const AValue: UNSIGNED16);
    function GetAsString: String;
    procedure SetAsString(const AValue: String);
{$IFDEF FireDAC_MONITOR}
    function DumpSQLDataType: String;
    function DumpValue: String;
    function DumpLabel: String;
{$ENDIF}
  public
    constructor Create(AVars: TADSVariables; AObj: TADSHandle);
    function GetData(AValue: Pointer; var ASize: Integer): Boolean;
    procedure SetData(AValue: Pointer; ASize: Integer);
    function CreateBlobStream: TADSBLOBStream;
    function GetDataLength: UNSIGNED32;
    procedure Clear;
    property IsNull: Boolean read GetIsNull;
    property AsString: String read GetAsString write SetAsString;
    property Position: UNSIGNED16 read GetPosition write SetPosition;
    property Name: String read FName write SetName;
    property ValueType: UNSIGNED16 read FValueType write FValueType;
    property IsImage: Boolean read FIsImage write FIsImage;
  end;

  TADSVariables = class(TObject)
  private
    [weak] FStmt: TADSStatement;
    FObj: TADSHandle;
    FList: TFDObjList;
    function GetItems(AIndex: Integer): TADSVariable; inline;
    function GetCount: Integer; inline;
    procedure SetCount(const AValue: Integer);
  public
    constructor Create(AStmt: TADSStatement; AObj: TADSHandle);
    destructor Destroy; override;
    procedure Clear;
    function Add: TADSVariable;
    function FindVar(const AName: String): TADSVariable;
    function VarByName(const AName: String): TADSVariable;
    property Count: Integer read GetCount write SetCount;
    property Items[AIndex: Integer]: TADSVariable read GetItems; default;
  end;

  TADSLockType = (ltProprietary, ltCompatible);
  TADSTableType = (ttDefault, ttCDX, ttVFP, ttADT, ttNTX);
  TADSStatement = class(TADSHandle)
  private
    FCursorHandle: ADSHANDLE;
    FTimeout: UNSIGNED32;
    FCharType: UNSIGNED16;
    FCollation: String;
    FLockType: TADSLockType;
    FReadOnly: Boolean;
    FTableType: TADSTableType;
    FStrsTrim: Boolean;
    FStrsEmpty2Null: Boolean;
    FParams: TADSVariables;
    function GetLastAutoInc: UNSIGNED32;
    procedure SetTimeout(const AValue: UNSIGNED32);
    procedure SetCharType(const AValue: UNSIGNED16);
    procedure SetCollation(const AValue: String);
    procedure SetLockType(const AValue: TADSLockType);
    procedure SetReadOnly(const AValue: Boolean);
    procedure SetTableType(const AValue: TADSTableType);
    function GetRecordCount: UNSIGNED32;
{$IFDEF FireDAC_MONITOR}
    // procedure DumpParams;
{$ENDIF}
  public
    constructor Create(AConn: TADSConnection; AOwningObj: TObject = nil);
    destructor Destroy; override;
    procedure Prepare(const ASQL: String);
    procedure Unprepare;
    procedure ExecuteDirect(const ASQL: String);
    procedure Execute;
    procedure Close;
    function GetCursor: TADSCursor;
    procedure SetTablePassword(const ATableName, APassword: String);
    // RO
    property LastAutoInc: UNSIGNED32 read GetLastAutoInc;
    property RecordCount: UNSIGNED32 read GetRecordCount;
    property Params: TADSVariables read FParams;
    // Stmt settings
    property Timeout: UNSIGNED32 read FTimeout write SetTimeout;
    property CharType: UNSIGNED16 read FCharType write SetCharType;
    property Collation: String read FCollation write SetCollation;
    property LockType: TADSLockType read FLockType write SetLockType;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
    property TableType: TADSTableType read FTableType write SetTableType;
    // Props
    property StrsTrim: Boolean read FStrsTrim write FStrsTrim;
    property StrsEmpty2Null: Boolean read FStrsEmpty2Null write FStrsEmpty2Null;
  end;

  TADSCursor = class(TADSHandle)
  private
    FStmt: TADSStatement;
    FColumns: TADSVariables;
    FCacheRecords: Integer;
    FColumnDefsCount: Word;
    function GetBof: Boolean;
    function GetEof: Boolean;
    procedure SetCacheRecords(const AValue: Integer);
    function GetRecordCount: UNSIGNED32;
    function GetColumnDefs(AIndex: Integer): TADSColumnDef;
    function GetRecNo: UNSIGNED32;
    procedure SetRecNo(const AValue: UNSIGNED32);
    function GetKeyColumns: String;
    function GetLastUpdate: TDateTime;
    function GetDeleted: Boolean;
    function GetTableType: TADSTableType;
    function GetCharType: UNSIGNED16;
    function GetCheckRights: UNSIGNED16;
    function GetLockType: TADSLockType;
    procedure UpdateFieldsNum;
{$IFDEF FireDAC_MONITOR}
    procedure DumpColumns;
{$ENDIF}
  protected
    FCharType: UNSIGNED16;
    FCheckRights: UNSIGNED16;
    FLockType: TADSLockType;
    FTableType: TADSTableType;
    constructor Create(AParent: TObject; AHandle: ADSHANDLE; AOwningObj: TObject = nil);
  public
    destructor Destroy; override;
    procedure AddColumns;
    procedure Close;
    procedure Skip(ARecs: Integer = 1);
    procedure Top;
    procedure Bottom;
    procedure CopyTable(const AFile: String; AFilterOptions: UNSIGNED16);
    procedure EnableEncryption(const APassword: String);
    // Editing
    procedure Append;
    procedure Delete;
    procedure Recall;
    procedure Post;
    procedure Lock(ARec: UNSIGNED32; AWaitTimeout: Cardinal = 0);
    procedure UnLock(ARec: UNSIGNED32);
    // RO
    property Columns: TADSVariables read FColumns;
    property ColumnDefsCount: Word read FColumnDefsCount;
    property ColumnDefs[AIndex: Integer]: TADSColumnDef read GetColumnDefs;
    // Cursor props
    property Bof: Boolean read GetBof;
    property Eof: Boolean read GetEof;
    property IsDeleted: Boolean read GetDeleted;
    property KeyColumns: String read GetKeyColumns;
    property LastUpdate: TDateTime read GetLastUpdate;
    property RecordCount: UNSIGNED32 read GetRecordCount;
    property RecNo: UNSIGNED32 read GetRecNo write SetRecNo;
    property CacheRecords: Integer read FCacheRecords write SetCacheRecords;
    // Object props
    property CharType: UNSIGNED16 read GetCharType;
    property CheckRights: UNSIGNED16 read GetCheckRights;
    property LockType: TADSLockType read GetLockType;
    property TableType: TADSTableType read GetTableType;
  end;

  TADSTable = class(TADSCursor)
  private
    FTableName: String;
    FAlias: String;
    FOptions: UNSIGNED32;
    FMemoSize: UNSIGNED16;
    function GetIsEncrypted: Boolean;
  public
    constructor Create(AConn: TADSConnection; AOwningObj: TObject = nil);
    procedure Open;
    procedure Open101;
    procedure CreateTable(const AFields: String; AMemoSize: UNSIGNED16);
    procedure Pack;
    procedure Zap;
    procedure RecallAll;
    procedure CreateIndex(const AFileName, ATag, AKeyExpr, ACondition,
      AWhile: String; AOptions: UNSIGNED32);
    procedure Reindex;
    procedure Encrypt;
    procedure Decrypt;
    property IsEncrypted: Boolean read GetIsEncrypted;
    property TableName: String read FTableName write FTableName;
    property Alias: String read FAlias write FAlias;
    // not used by Open101
    property TableType write FTableType;
    property CharType write FCharType;
    property LockType write FLockType;
    property CheckRights write FCheckRights;
    property Options: UNSIGNED32 read FOptions write FOptions;
    property MemoSize: UNSIGNED16 read FMemoSize write FMemoSize;
  end;

  TADSDictionary = class(TADSHandle)
  private
    FHasDictionary: Boolean;
    function GetString(AIndex: Integer): String;
    function GetLongWord(AIndex: Integer): UNSIGNED32;
    function GetWord(AIndex: Integer): UNSIGNED16;
    procedure SetString(AIndex: Integer; const AValue: String);
    procedure SetLongWord(AIndex: Integer; const AValue: UNSIGNED32);
    procedure SetWord(AIndex: Integer; const AValue: UNSIGNED16);
  public
    constructor Create(AConnection: TADSConnection);
    property HasDictionary: Boolean read FHasDictionary;
    property Comment: String index ADS_DD_COMMENT read GetString write SetString;
    property VersionMajor: String index ADS_DD_VERSION_MAJOR read GetString write SetString;
    property VersionMinor: String index ADS_DD_VERSION_MINOR read GetString write SetString;
    property UserDefinedProp: String index ADS_DD_USER_DEFINED_PROP read GetString write SetString;
    property DefaultTablePath: String index ADS_DD_DEFAULT_TABLE_PATH read GetString write SetString;
    property TempTablePath: String index ADS_DD_TEMP_TABLE_PATH read GetString write SetString;
    property LoginRequired: UNSIGNED16 index ADS_DD_LOG_IN_REQUIRED read GetWord write SetWord;
    property VerifyAccessRights: UNSIGNED16 index ADS_DD_VERIFY_ACCESS_RIGHTS read GetWord write SetWord;
    property EncryptTablePassword: String index ADS_DD_ENCRYPT_TABLE_PASSWORD read GetString write SetString;
    property EncryptNewTable: UNSIGNED16 index ADS_DD_ENCRYPT_NEW_TABLE read GetWord write SetWord;
    property DataEncryptType: UNSIGNED32 index ADS_DD_DATA_ENCRYPTION_TYPE read GetLongWord write SetLongWord;
    property FtsDelimiters: String index ADS_DD_FTS_DELIMITERS read GetString write SetString;
    property FtsNoise: String index ADS_DD_FTS_NOISE read GetString write SetString;
    property FtsDropChars: String index ADS_DD_FTS_DROP_CHARS read GetString write SetString;
    property FtsConditionalChars: String index ADS_DD_FTS_CONDITIONAL_CHARS read GetString write SetString;
    property LoginsDisabled: UNSIGNED16 index ADS_DD_LOGINS_DISABLED read GetWord write SetWord;
    property LoginsDisabledErrStr: String index ADS_DD_LOGINS_DISABLED_ERRSTR read GetString write SetString;
    property Encrypted: UNSIGNED16 index ADS_DD_ENCRYPTED read GetWord write SetWord;
    property EncryptIndexes: UNSIGNED16 index ADS_DD_ENCRYPT_INDEXES read GetWord write SetWord;
    property EncryptCommunication: UNSIGNED16 index ADS_DD_ENCRYPT_COMMUNICATION read GetWord write SetWord;
  end;

implementation

uses
  System.SysUtils, System.IniFiles, Data.FMTBcd, Data.SqlTimSt;

// ---------------------------------------
// NOT USED "DRIVER FUNCTIONS":
//
// AdsGetErrorString
//
// AdsFindFirstTable
// AdsFindNextTable
// AdsFindClose
//
// AdsFindConnection
//
// AdsGetActiveLinkInfo
// AdsGetNumActiveLinks
//
// AdsGetAllTables
// AdsGetNumOpenTables
//
// AdsGetConnectionPath
// AdsGetConnectionProperty
// AdsGetConnectionType
// AdsGetServerName
//
// AdsGetServerTime
// AdsIsServerLoaded
//
// AdsGetExact22
// AdsSetExact22
// AdsSetServerType
// AdsSetRightsChecking
//
// AdsResetConnection
//
// AdsWriteAllRecords

// ---------------------------------------
// NOT USED "SQL FUNCTIONS":
//
// AdsCacheOpenCursors
//
// AdsGetSQLStatement
// AdsGetSQLStatementHandle
//
// AdsRegisterSQLAbortFunc
// AdsClearSQLAbortFunc
//
// AdsStmtClearTablePasswords
// AdsStmtSetTablePassword
// AdsStmtDisableEncryption
// AdsStmtEnableEncryption
//
// AdsStmtReadAllColumns
// AdsStmtConstrainUpdates
// AdsStmtSetTableRights
//
// ---------------------------------------
// NOT USED "TABLE FUNCTIONS":
//
// most of the table functions

const
  JULIAN_TO_DELPHI_DATE = 1721425;

{-------------------------------------------------------------------------------}
const
  sAdsNullTerminateStrings: String = 'AdsNullTerminateStrings';
  sAdsGetLastError: String = 'AdsGetLastError';
  sAdsConnect101: String = 'AdsConnect101';
  sAdsConnect60: String = 'AdsConnect60';
  sAdsDisconnect: String = 'AdsDisconnect';
  sAdsBeginTransaction: String = 'AdsBeginTransaction';
  sAdsCreateSavepoint: String = 'AdsCreateSavepoint';
  sAdsCommitTransaction: String = 'AdsCommitTransaction';
  sAdsRollbackTransaction80: String = 'AdsRollbackTransaction80';
  sAdsGetTransactionCount: String = 'AdsGetTransactionCount';
  sAdsDisableAutoIncEnforcement: String = 'AdsDisableAutoIncEnforcement';
  sAdsEnableAutoIncEnforcement: String = 'AdsEnableAutoIncEnforcement';
  sAdsDisableRI: String = 'AdsDisableRI';
  sAdsEnableRI: String = 'AdsEnableRI';
  sAdsDisableUniqueEnforcement: String = 'AdsDisableUniqueEnforcement';
  sAdsEnableUniqueEnforcement: String = 'AdsEnableUniqueEnforcement';
  sAdsFindServers: String = 'AdsFindServers';
  sAdsGetCollation: String = 'AdsGetCollation';
  sAdsSetCollation: String = 'AdsSetCollation';
  sAdsGetConnectionPath: String = 'AdsGetConnectionPath';
  sAdsGetDateFormat: String = 'AdsGetDateFormat';
  sAdsSetDateFormat: String = 'AdsSetDateFormat';
  sAdsGetDateFormat60: String = 'AdsGetDateFormat60';
  sAdsSetDateFormat60: String = 'AdsSetDateFormat60';
  sAdsGetDecimals: String = 'AdsGetDecimals';
  sAdsSetDecimals: String = 'AdsSetDecimals';
  sAdsGetDefault: String = 'AdsGetDefault';
  sAdsSetDefault: String = 'AdsSetDefault';
  sAdsGetDeleted: String = 'AdsGetDeleted';
  sAdsShowDeleted: String = 'AdsShowDeleted';
  sAdsGetEpoch: String = 'AdsGetEpoch';
  sAdsSetEpoch: String = 'AdsSetEpoch';
  sAdsGetExact: String = 'AdsGetExact';
  sAdsSetExact: String = 'AdsSetExact';
  sAdsGetSearchPath: String = 'AdsGetSearchPath';
  sAdsSetSearchPath: String = 'AdsSetSearchPath';
  sAdsGetVersion: String = 'AdsGetVersion';
  sAdsIsConnectionAlive: String = 'AdsIsConnectionAlive';
{$IFDEF FireDAC_64}
  sAdsRegisterCallbackFunction101: String = 'AdsRegisterCallbackFunction101';
{$ELSE}
  sAdsRegisterCallbackFunction: String = 'AdsRegisterCallbackFunction';
{$ENDIF}
  sAdsClearCallbackFunction: String = 'AdsClearCallbackFunction';
  sAdsDDGetDatabaseProperty: String = 'AdsDDGetDatabaseProperty';
  sAdsDDSetDatabaseProperty: String = 'AdsDDSetDatabaseProperty';

  sAdsCreateSQLStatement: String = 'AdsCreateSQLStatement';
  sAdsPrepareSQLW: String = 'AdsPrepareSQLW';
  sAdsExecuteSQLDirectW: String = 'AdsExecuteSQLDirectW';
  sAdsPrepareSQL: String = 'AdsPrepareSQL';
  sAdsExecuteSQLDirect: String = 'AdsExecuteSQLDirect';
  sAdsCloseSQLStatement: String = 'AdsCloseSQLStatement';
  sAdsClearSQLParams: String = 'AdsClearSQLParams';
  sAdsExecuteSQL: String = 'AdsExecuteSQL';
  sAdsGetLastAutoInc: String = 'AdsGetLastAutoinc';
  sAdsSetSQLTimeout: String = 'AdsSetSQLTimeout';
  sAdsStmtSetTableCharType: String = 'AdsStmtSetTableCharType';
  sAdsStmtSetTableCollation: String = 'AdsStmtSetTableCollation';
  sAdsStmtSetTableLockType: String = 'AdsStmtSetTableLockType';
  sAdsStmtSetTableReadOnly: String = 'AdsStmtSetTableReadOnly';
  sAdsStmtSetTableType: String = 'AdsStmtSetTableType';
  sAdsStmtSetTablePassword: String = 'AdsStmtSetTablePassword';
  sAdsGetBinary: String = 'AdsGetBinary';
  sAdsSetBinary: String = 'AdsSetBinary';
  sAdsGetBinaryLength: String = 'AdsGetBinaryLength';
  sAdsGetMemoLength: String = 'AdsGetMemoLength';
  sAdsFileToBinary: String = 'AdsFileToBinary';
  sAdsBinaryToFile: String = 'AdsBinaryToFile';
  sAdsIsNull: String = 'AdsIsNull';
  sAdsSetNull: String = 'AdsSetNull';
  sAdsIsEmpty: String = 'AdsIsEmpty';
  sAdsSetEmpty: String = 'AdsSetEmpty';
  sAdsGetLogical: String = 'AdsGetLogical';
  sAdsGetString: String = 'AdsGetString';
  sAdsGetDouble: String = 'AdsGetDouble';
  sAdsGetLong: String = 'AdsGetLong';
  sAdsGetShort: String = 'AdsGetShort';
  sAdsGetLongLong: String = 'AdsGetLongLong';
  sAdsGetJulian: String = 'AdsGetJulian';
  sAdsGetMilliseconds: String = 'AdsGetMilliseconds';
  sAdsGetFieldLength: String = 'AdsGetFieldLength';
  sAdsGetFieldLength100: String = 'AdsGetFieldLength100';
  sAdsGetStringW: String = 'AdsGetStringW';
  sAdsGetField: String = 'AdsGetField';
  sAdsSetLogical: String = 'AdsSetLogical';
  sAdsSetString: String = 'AdsSetString';
  sAdsSetDouble: String = 'AdsSetDouble';
  sAdsSetLong: String = 'AdsSetLong';
  sAdsSetShort: String = 'AdsSetShort';
  sAdsSetLongLong: String = 'AdsSetLongLong';
  sAdsSetJulian: String = 'AdsSetJulian';
  sAdsSetMilliseconds: String = 'AdsSetMilliseconds';
  sAdsSetStringW: String = 'AdsSetStringW';
  sAdsSetField: String = 'AdsSetField';
  sAdsSetTimeStampRaw: String = 'AdsSetTimeStampRaw';
  sAdsGetRecordCount: String = 'AdsGetRecordCount';
  sAdsGetNumFields: String = 'AdsGetNumFields';
  sAdsAtBOF: String = 'AdsAtBOF';
  sAdsAtEOF: String = 'AdsAtEOF';
  sAdsCacheRecords: String = 'AdsCacheRecords';
  sAdsCloseTable: String = 'AdsCloseTable';
  sAdsSkip: String = 'AdsSkip';
  sAdsGetRecordNum: String = 'AdsGetRecordNum';
  sAdsGotoRecord: String = 'AdsGotoRecord';
  sAdsGotoTop: String = 'AdsGotoTop';
  sAdsGotoBottom: String = 'AdsGotoBottom';
  sAdsGetFieldType: String = 'AdsGetFieldType';
  sAdsGetMemoDataType: String = 'AdsGetMemoDataType';
  sAdsGetFieldDecimals: String = 'AdsGetFieldDecimals';
  sAdsGetFieldName: String = 'AdsGetFieldName';
  sAdsGetKeyColumn: String = 'AdsGetKeyColumn';
  sAdsGetLastTableUpdate: String = 'AdsGetLastTableUpdate';
  sAdsConvertStringToJulian: String = 'AdsConvertStringToJulian';
  sAdsAppendRecord: String = 'AdsAppendRecord';
  sAdsDeleteRecord: String = 'AdsDeleteRecord';
  sAdsWriteRecord: String = 'AdsWriteRecord';
  sAdsRecallRecord: String = 'AdsRecallRecord';
  sAdsRecallAllRecords: String = 'AdsRecallAllRecords';
  sAdsIsRecordDeleted: String = 'AdsIsRecordDeleted';
  sAdsOpenTable101: String = 'AdsOpenTable101';
  sAdsOpenTable: String = 'AdsOpenTable';
  sAdsCreateTable: String = 'AdsCreateTable';
  sAdsPackTable: String = 'AdsPackTable';
  sAdsZapTable: String = 'AdsZapTable';
  sAdsGetTableType: String = 'AdsGetTableType';
  sAdsGetTableRights: String = 'AdsGetTableRights';
  sAdsGetTableLockType: String = 'AdsGetTableLockType';
  sAdsGetTableCharType: String = 'AdsGetTableCharType';
  sAdsCreateIndex: String = 'AdsCreateIndex';
  sAdsCopyTable: String = 'AdsCopyTable';
  sAdsEnableEncryption: String = 'AdsEnableEncryption';
  sAdsEncryptTable: String = 'AdsEncryptTable';
  sAdsIsTableEncrypted: String = 'AdsIsTableEncrypted';
  sAdsDecryptTable: String = 'AdsDecryptTable';
  sAdsReindex: String = 'AdsReindex';
  sAdsLockRecord: String = 'AdsLockRecord';
  sAdsUnlockRecord: String = 'AdsUnlockRecord';

  sAdsMgGetInstallInfo: String = 'AdsMgGetInstallInfo';

{-------------------------------------------------------------------------------}
{ Utilities                                                                     }
{-------------------------------------------------------------------------------}
function ADSLockType2Int(const AValue: TADSLockType): UNSIGNED16;
begin
  case AValue of
  ltProprietary: Result := ADS_PROPRIETARY_LOCKING;
  ltCompatible:  Result := ADS_COMPATIBLE_LOCKING;
  else           Result := ADS_PROPRIETARY_LOCKING;
  end;
end;

{-------------------------------------------------------------------------------}
function ADSInt2LockType(const AValue: UNSIGNED16): TADSLockType;
begin
  case AValue of
  ADS_PROPRIETARY_LOCKING: Result := ltProprietary;
  ADS_COMPATIBLE_LOCKING:  Result := ltCompatible;
  else                     Result := ltProprietary;
  end;
end;

{-------------------------------------------------------------------------------}
function ADSReadOnly2Int(const AValue: Boolean): UNSIGNED16;
begin
  if AValue then
    Result := ADS_CURSOR_READONLY
  else
    Result := ADS_CURSOR_READWRITE;
end;

{-------------------------------------------------------------------------------}
function ADSInt2ReadOnly(const AValue: UNSIGNED16): Boolean;
begin
  Result := AValue = ADS_CURSOR_READONLY;
end;

{-------------------------------------------------------------------------------}
function ADSTableType2Int(const AValue: TADSTableType): UNSIGNED16;
begin
  case AValue of
  ttCDX: Result := ADS_CDX;
  ttVFP: Result := ADS_VFP;
  ttADT: Result := ADS_ADT;
  ttNTX: Result := ADS_NTX;
  else   Result := ADS_DEFAULT;
  end;
end;

{-------------------------------------------------------------------------------}
function ADSInt2TableType(const AValue: UNSIGNED16): TADSTableType;
begin
  case AValue of
  ADS_CDX: Result := ttCDX;
  ADS_VFP: Result := ttVFP;
  ADS_ADT: Result := ttADT;
  ADS_NTX: Result := ttNTX;
  else     Result := ttDefault;
  end;
end;

{-------------------------------------------------------------------------------}
{ TADSLib                                                                       }
{-------------------------------------------------------------------------------}
constructor TADSLib.Create(AOwningObj: TObject = nil);
begin
  inherited Create(S_FD_ADSId, AOwningObj);
  FEncoder := TFDEncoder.Create(nil);
  FEncoder.Encoding := ecANSI;
end;

{-------------------------------------------------------------------------------}
destructor TADSLib.Destroy;
begin
  FDFreeAndNil(FServers);
  FDFreeAndNil(FEncoder);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TADSLib.Load(const AVendorHome, AVendorLib: String);
var
  sDLLName: String;
begin
  sDLLName := AVendorHome;
  if sDLLName <> '' then
    sDLLName := FDNormPath(FDNormPath(sDLLName) + C_FD_DLLFolder);
  if AVendorLib <> '' then
    sDLLName := sDLLName + AVendorLib
  else
    sDLLName := sDLLName + C_ADSDll;
  inherited Load([sDLLName], True);
end;

{-------------------------------------------------------------------------------}
procedure TADSLib.LoadEntries;
begin
  FAdsNullTerminateStrings := GetProc(sAdsNullTerminateStrings);
  FAdsGetLastError := GetProc(sAdsGetLastError);
  FAdsConnect101 := GetProc(sAdsConnect101, False);
  FAdsConnect60 := GetProc(sAdsConnect60);
  FAdsDisconnect := GetProc(sAdsDisconnect);
  FAdsBeginTransaction := GetProc(sAdsBeginTransaction);
  FAdsCreateSavepoint := GetProc(sAdsCreateSavepoint);
  FAdsCommitTransaction := GetProc(sAdsCommitTransaction);
  FAdsRollbackTransaction80 := GetProc(sAdsRollbackTransaction80);
  FAdsGetTransactionCount := GetProc(sAdsGetTransactionCount, False);
  FAdsDisableAutoIncEnforcement := GetProc(sAdsDisableAutoIncEnforcement);
  FAdsEnableAutoIncEnforcement := GetProc(sAdsEnableAutoIncEnforcement);
  FAdsDisableRI := GetProc(sAdsDisableRI);
  FAdsEnableRI := GetProc(sAdsEnableRI);
  FAdsDisableUniqueEnforcement := GetProc(sAdsDisableUniqueEnforcement);
  FAdsEnableUniqueEnforcement := GetProc(sAdsEnableUniqueEnforcement);
  FAdsFindServers := GetProc(sAdsFindServers, False);
  FAdsGetCollation := GetProc(sAdsGetCollation, False);
  FAdsSetCollation := GetProc(sAdsSetCollation, False);
  FAdsGetConnectionPath := GetProc(sAdsGetConnectionPath);
  FAdsGetDateFormat := GetProc(sAdsGetDateFormat);
  FAdsSetDateFormat := GetProc(sAdsSetDateFormat);
  FAdsGetDateFormat60 := GetProc(sAdsGetDateFormat60);
  FAdsSetDateFormat60 := GetProc(sAdsSetDateFormat60);
  FAdsGetDecimals := GetProc(sAdsGetDecimals);
  FAdsSetDecimals := GetProc(sAdsSetDecimals);
  FAdsGetDefault := GetProc(sAdsGetDefault);
  FAdsSetDefault := GetProc(sAdsSetDefault);
  FAdsGetDeleted := GetProc(sAdsGetDeleted);
  FAdsShowDeleted := GetProc(sAdsShowDeleted);
  FAdsGetEpoch := GetProc(sAdsGetEpoch);
  FAdsSetEpoch := GetProc(sAdsSetEpoch);
  FAdsGetExact := GetProc(sAdsGetExact);
  FAdsSetExact := GetProc(sAdsSetExact);
  FAdsGetSearchPath := GetProc(sAdsGetSearchPath);
  FAdsSetSearchPath := GetProc(sAdsSetSearchPath);
  FAdsGetVersion := GetProc(sAdsGetVersion);
  FAdsIsConnectionAlive := GetProc(sAdsIsConnectionAlive);
{$IFDEF FireDAC_64}
  FAdsRegisterCallbackFunction101 := GetProc(sAdsRegisterCallbackFunction101);
{$ELSE}
  FAdsRegisterCallbackFunction := GetProc(sAdsRegisterCallbackFunction);
{$ENDIF}
  FAdsClearCallbackFunction := GetProc(sAdsClearCallbackFunction);
  FAdsDDGetDatabaseProperty := GetProc(sAdsDDGetDatabaseProperty);
  FAdsDDSetDatabaseProperty := GetProc(sAdsDDSetDatabaseProperty);

  FAdsCreateSQLStatement := GetProc(sAdsCreateSQLStatement);
  FAdsPrepareSQLW := GetProc(sAdsPrepareSQLW, False);
  FAdsExecuteSQLDirectW := GetProc(sAdsExecuteSQLDirectW, False);
  FAdsPrepareSQL := GetProc(sAdsPrepareSQL);
  FAdsExecuteSQLDirect := GetProc(sAdsExecuteSQLDirect);
  FAdsCloseSQLStatement := GetProc(sAdsCloseSQLStatement);
  FAdsClearSQLParams := GetProc(sAdsClearSQLParams);
  FAdsExecuteSQL := GetProc(sAdsExecuteSQL);
  FAdsGetLastAutoinc := GetProc(sAdsGetLastAutoinc);
  FAdsSetSQLTimeout := GetProc(sAdsSetSQLTimeout, False);
  FAdsStmtSetTableReadOnly := GetProc(sAdsStmtSetTableReadOnly);
  FAdsStmtSetTableCharType := GetProc(sAdsStmtSetTableCharType);
  FAdsStmtSetTableCollation := GetProc(sAdsStmtSetTableCollation, False);
  FAdsStmtSetTableLockType := GetProc(sAdsStmtSetTableLockType);
  FAdsStmtSetTableType := GetProc(sAdsStmtSetTableType);
  FAdsStmtSetTablePassword := GetProc(sAdsStmtSetTablePassword);
  FAdsGetBinary := GetProc(sAdsGetBinary);
  FAdsSetBinary := GetProc(sAdsSetBinary);
  FAdsGetBinaryLength := GetProc(sAdsGetBinaryLength);
  FAdsGetMemoLength := GetProc(sAdsGetMemoLength);
  FAdsFileToBinary := GetProc(sAdsFileToBinary);
  FAdsBinaryToFile := GetProc(sAdsBinaryToFile);
  FAdsIsNull := GetProc(sAdsIsNull, False);
  FAdsSetNull := GetProc(sAdsSetNull, False);
  FAdsIsEmpty := GetProc(sAdsIsEmpty);
  FAdsSetEmpty := GetProc(sAdsSetEmpty);
  FAdsGetLogical := GetProc(sAdsGetLogical);
  FAdsGetString := GetProc(sAdsGetString);
  FAdsGetDouble := GetProc(sAdsGetDouble);
  FAdsGetLong := GetProc(sAdsGetLong);
  FAdsGetShort := GetProc(sAdsGetShort);
  FAdsGetLongLong := GetProc(sAdsGetLongLong);
  FAdsGetJulian := GetProc(sAdsGetJulian);
  FAdsGetMilliseconds := GetProc(sAdsGetMilliseconds);
  FAdsGetFieldLength := GetProc(sAdsGetFieldLength);
  FAdsGetFieldLength100 := GetProc(sAdsGetFieldLength100, False);
  FAdsGetStringW := GetProc(sAdsGetStringW, False);
  FAdsGetField := GetProc(sAdsGetField);
  FAdsSetLogical := GetProc(sAdsSetLogical);
  FAdsSetString := GetProc(sAdsSetString);
  FAdsSetDouble := GetProc(sAdsSetDouble);
  FAdsSetLong := GetProc(sAdsSetLong);
  FAdsSetShort := GetProc(sAdsSetShort);
  FAdsSetLongLong := GetProc(sAdsSetLongLong);
  FAdsSetJulian := GetProc(sAdsSetJulian);
  FAdsSetMilliseconds := GetProc(sAdsSetMilliseconds);
  FAdsSetStringW := GetProc(sAdsSetStringW, False);
  FAdsSetField := GetProc(sAdsSetField);
  FAdsSetTimeStampRaw := GetProc(sAdsSetTimeStampRaw);
  FAdsGetRecordCount := GetProc(sAdsGetRecordCount);
  FAdsGetNumFields := GetProc(sAdsGetNumFields);
  FAdsAtBOF := GetProc(sAdsAtBOF);
  FAdsAtEOF := GetProc(sAdsAtEOF);
  FAdsCacheRecords := GetProc(sAdsCacheRecords);
  FAdsCloseTable := GetProc(sAdsCloseTable);
  FAdsSkip := GetProc(sAdsSkip);
  FAdsGetRecordNum := GetProc(sAdsGetRecordNum);
  FAdsGotoRecord := GetProc(sAdsGotoRecord);
  FAdsGotoTop := GetProc(sAdsGotoTop);
  FAdsGotoBottom := GetProc(sAdsGotoBottom);
  FAdsGetFieldType := GetProc(sAdsGetFieldType);
  FAdsGetMemoDataType := GetProc(sAdsGetMemoDataType);
  FAdsGetFieldDecimals := GetProc(sAdsGetFieldDecimals);
  FAdsGetFieldName := GetProc(sAdsGetFieldName);
  FAdsGetKeyColumn := GetProc(sAdsGetKeyColumn);
  FAdsGetLastTableUpdate := GetProc(sAdsGetLastTableUpdate);
  FAdsConvertStringToJulian := GetProc(sAdsConvertStringToJulian);
  FAdsAppendRecord := GetProc(sAdsAppendRecord);
  FAdsDeleteRecord := GetProc(sAdsDeleteRecord);
  FAdsWriteRecord := GetProc(sAdsWriteRecord);
  FAdsRecallRecord := GetProc(sAdsRecallRecord);
  FAdsRecallAllRecords := GetProc(sAdsRecallAllRecords);
  FAdsIsRecordDeleted := GetProc(sAdsIsRecordDeleted);
  FAdsOpenTable101 := GetProc(sAdsOpenTable101, False);
  FAdsOpenTable := GetProc(sAdsOpenTable);
  FAdsCreateTable := GetProc(sAdsCreateTable);
  FAdsPackTable := GetProc(sAdsPackTable);
  FAdsZapTable := GetProc(sAdsZapTable);
  FAdsGetTableType := GetProc(sAdsGetTableType);
  FAdsGetTableRights := GetProc(sAdsGetTableRights);
  FAdsGetTableLockType := GetProc(sAdsGetTableLockType);
  FAdsGetTableCharType := GetProc(sAdsGetTableCharType);
  FAdsCreateIndex := GetProc(sAdsCreateIndex);
  FAdsCopyTable := GetProc(sAdsCopyTable);
  FAdsEnableEncryption := GetProc(sAdsEnableEncryption);
  FAdsEncryptTable := GetProc(sAdsEncryptTable);
  FAdsIsTableEncrypted := GetProc(sAdsIsTableEncrypted);
  FAdsDecryptTable := GetProc(sAdsDecryptTable);
  FAdsReindex := GetProc(sAdsReindex);
  FAdsLockRecord := GetProc(sAdsLockRecord);
  FAdsUnLockRecord := GetProc(sAdsUnlockRecord);

  FAdsMgGetInstallInfo := GetProc(sAdsMgGetInstallInfo);

  UpdateVersion;
  if Version < caADS10 then
    FAdsNullTerminateStrings(0);
end;

{-------------------------------------------------------------------------------}
procedure TADSLib.UpdateVersion;
var
  ulMajor, ulMinor: UNSIGNED32;
  ucLetter: AceChar;
  aBuf: array [0 .. 1024] of AceChar;
  usLen: UNSIGNED16;
begin
  usLen := SizeOf(aBuf);
  Check(FAdsGetVersion(@ulMajor, @ulMinor, @ucLetter, @aBuf[0], @usLen));
  FVersion := ulMajor * 0100000000 + ulMinor * 0001000000;
  FVersionStr := Encoder.Decode(@aBuf[0], usLen);
  FVersionStr := FVersionStr +
    Format(' ver %d.%d%s', [ulMajor, ulMinor, Char(ucLetter)]);
end;

{-------------------------------------------------------------------------------}
procedure TADSLib.Check(ACode: UNSIGNED32);
begin
  if ACode <> AE_SUCCESS then
    FDException(OwningObj, EADSNativeException.Create(ACode, Self, nil)
                {$IFDEF FireDAC_Monitor}, False {$ENDIF});
end;

{-------------------------------------------------------------------------------}
procedure TADSLib.ListServers(AList: TStrings);
var
  hCrs: ADSHANDLE;
  oCrs: TADSCursor;
  iRes: UNSIGNED32;
  s: String;
  iPort, iSize: Integer;
begin
  if FServers = nil then begin
    FServers := TFDStringList.Create;
    if Assigned(FAdsFindServers) then begin
      iRes := FAdsFindServers(ADS_FS_MULTICAST_ONLY, @hCrs);
      if iRes = AE_SUCCESS then begin
        oCrs := TADSCursor.Create(Self, hCrs, Self);
        try
          oCrs.AddColumns;
          while not oCrs.Eof do begin
            s := oCrs.Columns.VarByName('Server Name').AsString;
            if s = '' then
              s := oCrs.Columns.VarByName('IP Addr').AsString;
            oCrs.Columns.VarByName('Port').GetData(@iPort, iSize);
            if iPort <> 0 then
              s := s + ':' + IntToStr(iPort);
            s := '//' + s + '/';
            if FServers.IndexOf(s) = -1 then
              FServers.Add(s);
            oCrs.Skip();
          end;
        finally
          FDFree(oCrs);
        end;
      end;
    end;
  end;
  AList.SetStrings(FServers);
end;

{-------------------------------------------------------------------------------}
class function TADSLib.DumpField(AField: PAceChar): String;
begin
  if NativeUInt(AField) < $0000FFFF then
    Result := '#' + IntToStr(NativeUInt(AField))
  else
    Result := TFDEncoder.Deco(PByte(AField), -1, ecANSI);
end;

{-------------------------------------------------------------------------------}
function TADSLib.GetDateFormat: String;
var
  aBuf: array [0 .. ADS_MAX_OBJECT_NAME] of AceChar;
  usLen: UNSIGNED16;
begin
  usLen := SizeOf(aBuf);
  Check(FAdsGetDateFormat(@aBuf[0], @usLen));
  Result := Encoder.Decode(@aBuf[0], usLen);
end;

{-------------------------------------------------------------------------------}
procedure TADSLib.SetDateFormat(const AValue: String);
var
  sb: TFDByteString;
begin
  sb := Encoder.Encode(AValue);
  Check(FAdsSetDateFormat(PAceChar(PByte(sb))));
end;

{-------------------------------------------------------------------------------}
function TADSLib.GetDecimals: Word;
begin
  Check(FAdsGetDecimals(@Result));
end;

{-------------------------------------------------------------------------------}
procedure TADSLib.SetDecimals(const AValue: Word);
begin
  Check(FAdsSetDecimals(AValue));
end;

{-------------------------------------------------------------------------------}
function TADSLib.GetDefaultPath: String;
var
  aBuf: array [0 .. ADS_MAX_PATH] of AceChar;
  usLen: UNSIGNED16;
begin
  usLen := SizeOf(aBuf);
  Check(FAdsGetDefault(@aBuf[0], @usLen));
  Result := Encoder.Decode(@aBuf[0], usLen);
end;

{-------------------------------------------------------------------------------}
procedure TADSLib.SetDefaultPath(const AValue: String);
var
  sb: TFDByteString;
begin
  sb := Encoder.Encode(AValue);
  Check(FAdsSetDefault(PAceChar(PByte(sb))));
end;

{-------------------------------------------------------------------------------}
function TADSLib.GetShowDeleted: Boolean;
var
  iShowDeleted: UNSIGNED16;
begin
  Check(FAdsGetDeleted(@iShowDeleted));
  Result := iShowDeleted <> 0;
end;

{-------------------------------------------------------------------------------}
procedure TADSLib.SetShowDeleted(const AValue: Boolean);
begin
  Check(FAdsShowDeleted(Word(AValue)));
end;

{-------------------------------------------------------------------------------}
function TADSLib.GetEpoch: Word;
begin
  Check(FAdsGetEpoch(@Result));
end;

{-------------------------------------------------------------------------------}
procedure TADSLib.SetEpoch(const AValue: Word);
begin
  Check(FAdsSetEpoch(AValue));
end;

{-------------------------------------------------------------------------------}
function TADSLib.GetExact: Boolean;
var
  iExact: UNSIGNED16;
begin
  Check(FAdsGetExact(@iExact));
  Result := iExact <> 0;
end;

{-------------------------------------------------------------------------------}
procedure TADSLib.SetExact(const AValue: Boolean);
begin
  Check(FAdsSetExact(Word(AValue)));
end;

{-------------------------------------------------------------------------------}
function TADSLib.GetSearchPath: String;
var
  aBuf: array [0 .. 2048] of AceChar;
  usLen: UNSIGNED16;
begin
  usLen := SizeOf(aBuf);
  Check(FAdsGetSearchPath(@aBuf[0], @usLen));
  Result := Encoder.Decode(@aBuf[0], usLen);
end;

{-------------------------------------------------------------------------------}
procedure TADSLib.SetSearchPath(const AValue: String);
var
  sb: TFDByteString;
begin
  sb := Encoder.Encode(AValue);
  Check(FAdsSetSearchPath(PAceChar(PByte(sb))));
end;

{-------------------------------------------------------------------------------}
{$IFDEF MSWINDOWS}
function TADSLib.GetAliasFileName: String;
var
  dwRet       : DWORD;
  acFilename  : array[0..MAX_PATH] of Char;
  pcFile      : pChar;
  strAliasSearchPath : string;
  pcPath      : pChar;
begin
  // If the user has specified the environment var adsini_path, then
  // use that path to do the search, otherwise pass nil to use the
  // default search path.
  strAliasSearchPath := GetEnvironmentVariable('adsini_path');
  if strAliasSearchPath <> '' then begin
    strAliasSearchPath := strAliasSearchPath + '\ads.ini';
    if System.SysUtils.FileExists(strAliasSearchPath) then begin
      Result := strAliasSearchPath;
      Exit;
    end;
    // If we haven't exited, the file isn't present in this directory
    // so fall through to check the default search path.
  end;

  // Use SearchPath to find the ads.ini file to use
  pcPath := nil;
  pcFile := nil;
  dwRet := Winapi.Windows.SearchPath(pcPath, 'ads.ini', nil, Length(acFilename),
    @acFilename, pcFile);
  if dwRet = 0 then
    // file might not exist, just use base filename and let TIniFile create it
    Result := 'ads.ini'
  else
    Result := acFilename;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{$IFDEF POSIX}
function TADSLib.GetAliasFileName: String;
var
  i : integer;
begin
  Result := ParamStr(0);

  { chop this value at the \ }
  for i := Length(Result) downto 1 do
    if Result[i] = '/' then
      break;

  Delete(Result, i, Length(Result) - i + 1);
  Result := Result + '/ads.ini';

  if not FileExists(Result) then begin
    {*
     * In linux we need to search for the file ourselves, can't just
     * pass TIniFile a base filename and have it do the search like
     * we do in windows. We'll basically do the same search here
     * that linux ace does:
     *
     * 1) current dir (already did that if we got here)
     * 2) environment variable
     * 3) home dir in .ads.ini
     * 4) /etc
     *}
    Result := GetEnvironmentVariable('ADSPATH');
    if Result <> '' then begin
      {* Remove slash if it has one. *}
      if Result[Length(Result)] = '/' then
        Delete(Result, Length(Result), 1);

        Result := Result + '/ads.ini';
        if FileExists(Result) then
          Exit;
    end;

    {* Try the home directory *}
    if FileExists(GetEnvironmentVariable('HOME') + '/.ads.ini') then
      Result := GetEnvironmentVariable('HOME') + '/.ads.ini'
    else
      Result := '/etc/ads.ini';
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
procedure TADSLib.ListAliases(AList: TStrings);
var
  oIni: TCustomIniFile;
begin
  try
    oIni := TMemIniFile.Create(AliasFileName);
    try
      oIni.ReadSection('Databases', AList);
    finally
      FDFree(oIni);
    end;
  except
    // nothing
  end;
end;

{-------------------------------------------------------------------------------}
function TADSLib.ResolveAlias(const AName: String; var APath: String; AType: String): Boolean;
var
  oIni: TCustomIniFile;
  s: String;
  i: Integer;
begin
  Result := False;
  APath := '';
  AType := '';
  try
    oIni := TMemIniFile.Create(AliasFileName);
    try
      s := oIni.ReadString('Databases', AName, '');
      Result := s <> '';
      if Result then begin
        i := Pos(';', s);
        if i <> 0 then begin
          APath := Trim(Copy(s, 1, i - 1));
          AType := UpperCase(Trim(Copy(s, i + 1, MAXINT)));
          if AType = 'N' then
            AType := 'NTX'
          else if AType = 'C' then
            AType := 'CDX'
          else if AType = 'A' then
            AType := 'ADT'
          else if AType = 'V' then
            AType := 'VFP'
          else if AType = 'D' then
            AType := '';
        end
        else
          APath := s;
      end;
    finally
      FDFree(oIni);
    end;
  except
    // nothing
  end;
end;

{-------------------------------------------------------------------------------}
{ EADSNativeException                                                           }
{-------------------------------------------------------------------------------}
constructor EADSNativeException.Create(ACode: UNSIGNED32; ALib: TADSLib;
  AOwner: TADSHandle = nil);
var
  iErrCode: UNSIGNED32;
  iErrLen: UNSIGNED16;
  aBuf: array [0 .. ADS_MAX_ERROR_LEN] of AceChar;
  s, sErr, sObj: String;
  eKind: TFDCommandExceptionKind;
  iErrPos: Integer;
  oEncoder: TFDEncoder;

  function Extract(const AMarker1, AMarker2: String): String;
  var
    i1, i2: Integer;
  begin
    Result := '';
    i1 := Pos(AMarker1, sErr);
    if i1 <> 0 then begin
      if AMarker2 = '' then
        i2 := MAXINT
      else
        i2 := Pos(AMarker2, sErr, i1 + Length(AMarker1));
      if i2 <> 0 then
        Result := Copy(sErr, i1 + Length(AMarker1), i2 - i1 - Length(AMarker1));
    end;
  end;

begin
  iErrPos := 0;
  sObj := '';
  if AOwner = nil then
    oEncoder := ALib.Encoder
  else
    oEncoder := AOwner.Encoder;

  iErrLen := SizeOf(aBuf);
  ALib.FAdsGetLastError(@iErrCode, @aBuf[0], @iErrLen);
  sErr := oEncoder.Decode(@aBuf[0], iErrLen);

  if iErrCode = 7200 then begin
    s := Extract('NativeError = ', ';');
    if s <> '' then
      iErrCode := StrToInt(s);
    s := Extract('-- Location of error in the SQL statement is: ', ' ');
    if s <> '' then
      iErrPos := StrToInt(s);
  end;

  case iErrCode of
  7209:
    eKind := ekCmdAborted;
  AE_INVALID_OBJECT_NAME,
  AE_FILE_NOT_FOUND,
  7041:
    eKind := ekObjNotExists;
  AE_INVALID_PASSWORD,
  7060:
    eKind := ekUserPwdInvalid;
  AE_TABLE_ENCRYPTED:
    begin
      sObj := Extract('Table name: ', '');
      eKind := ekUserPwdInvalid;
    end;
  7057:
    begin
      sObj := Extract('The key value supplied for ', ' is not unique.');
      eKind := ekUKViolated;
    end;
  7076:
    begin
      sObj := Extract('for the foreign key update to ', '');
      eKind := ekFKViolated;
    end;
  AE_LOCK_FAILED:
    eKind := ekRecordLocked;
  AE_INVALID_SQL_PARAM_NUMBER,
  AE_INVALID_SQL_PARAM_NAME,
  2129,
  2141:
    eKind := ekInvalidParams;
  6624,
  6633,
  6420:
    eKind := ekServerGone;
  else
    eKind := ekOther;
  end;

  inherited Create(er_FD_ADSGeneral,
    FDExceptionLayers([S_FD_LPhys, S_FD_ADSId]) + ' ' + sErr);

  if iErrCode = 7209 then begin
    FDCode := er_FD_StanTimeout;
    Message := FDGetErrorMessage(er_FD_StanTimeout, []);
  end;

  AppendError(1, ACode, sErr, sObj, eKind, iErrPos - 1, -1);
{$IFDEF FireDAC_MONITOR}
  if (AOwner <> nil) and AOwner.Tracing then
    AOwner.Trace(ekError, esProgress, Message, []);
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
{ TADSHandle                                                                    }
{-------------------------------------------------------------------------------}
constructor TADSHandle.Create;
begin
  inherited Create;
  FOwnHandle := True;
  FEncoder := TFDEncoder.Create(nil);
  FEncoder.Encoding := ecANSI;
end;

{-------------------------------------------------------------------------------}
constructor TADSHandle.CreateUsingHandle(AHandle: ADSHANDLE);
begin
  inherited Create;
  FHandle := AHandle;
  FOwnHandle := False;
  FEncoder := TFDEncoder.Create(nil);
end;

{-------------------------------------------------------------------------------}
destructor TADSHandle.Destroy;
begin
  FDFreeAndNil(FEncoder);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TADSHandle.Check(ACode: UNSIGNED32);
begin
  if ACode <> AE_SUCCESS then
    FDException(OwningObj, EADSNativeException.Create(ACode, Lib, Self)
                {$IFDEF FireDAC_Monitor}, Tracing {$ENDIF});
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TADSHandle.GetTracing: Boolean;
begin
  Result := (Connection <> nil) and Connection.Tracing;
end;

{-------------------------------------------------------------------------------}
procedure TADSHandle.Trace(const AMsg: String; const AArgs: array of const);
begin
  if Tracing then
    Connection.Monitor.Notify(ekVendor, esProgress, OwningObj, AMsg, AArgs);
end;

{-------------------------------------------------------------------------------}
procedure TADSHandle.Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
  const AMsg: String; const AArgs: array of const);
begin
  if Tracing then
    Connection.Monitor.Notify(AKind, AStep, OwningObj, AMsg, AArgs);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TADSConnection                                                                }
{-------------------------------------------------------------------------------}
constructor TADSConnection.Create(ALib: TADSLib; AOwningObj: TObject
  {$IFDEF FireDAC_Monitor}; const AMonitor: IFDMoniClient {$ENDIF});
begin
  inherited Create;
  FLib := ALib;
  FOwningObj := AOwningObj;
  FConnection := Self;
{$IFDEF FireDAC_Monitor}
  FMonitor := AMonitor;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
constructor TADSConnection.CreateUsingHandle(ALib: TADSLib;
  AHandle: ADSHANDLE; AOwningObj: TObject
  {$IFDEF FireDAC_Monitor}; const AMonitor: IFDMoniClient {$ENDIF});
begin
  inherited CreateUsingHandle(AHandle);
  FLib := ALib;
  FOwningObj := AOwningObj;
  FConnection := Self;
{$IFDEF FireDAC_Monitor}
  FMonitor := AMonitor;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
destructor TADSConnection.Destroy;
begin
  if Handle <> 0 then
    Disconnect;
{$IFDEF FireDAC_MONITOR}
  FMonitor := nil;
{$ENDIF}
  FOwningObj := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TADSConnection.BeforeConnecting;
begin
  FServerVersion := 0;
  FAutoIncEnforcement := True;
  FRIEnforcement := True;
  FUniqueEnforcement := True;
end;

{-------------------------------------------------------------------------------}
procedure TADSConnection.AfterConnecting;
var
  oStmt: TADSStatement;
  oCrs: TADSCursor;
begin
  oStmt := TADSStatement.Create(Self, FOwningObj);
  oCrs := nil;
  try
    oStmt.ExecuteDirect('EXECUTE PROCEDURE sp_mgGetInstallInfo()');
    oCrs := oStmt.GetCursor;
    oCrs.AddColumns;
    FServerVersionStr := oCrs.Columns[3].AsString;
    FServerVersion := FDVerStr2Int(FServerVersionStr);
  finally
    FDFree(oCrs);
    FDFree(oStmt);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TADSConnection.Connect101(const AConnStr: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  const
    C_Pwds: array [0 .. 2] of String = ('password', 'ddpassword', 'encryptionpassword');
  var
    sConnStr: String;
    i, i1, i2: Integer;
  begin
    sConnStr := AConnStr;
    for i := 0 to 2 do begin
      i1 := Pos(C_Pwds[i] + '=', LowerCase(sConnStr));
      if i1 <> 0 then begin
        i2 := Pos(';', sConnStr, i1);
        if i2 = 0 then
          i2 := Length(sConnStr) + 1;
        sConnStr := Copy(sConnStr, 1, i1 + Length(C_Pwds[i])) + '***' +
          Copy(sConnStr, i2, Length(sConnStr));
      end;
    end;
    Trace(sAdsConnect101, ['@pucConnectString', sConnStr, 'phConnect', Handle]);
  end;
{$ENDIF}

var
  iRes: UNSIGNED32;
  sb: TFDByteString;
begin
  BeforeConnecting;
  sb := Encoder.Encode(AConnStr);
  iRes := Lib.FAdsConnect101(PAceChar(PByte(sb)), nil, @FHandle);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(iRes);
  AfterConnecting;
end;

{-------------------------------------------------------------------------------}
procedure TADSConnection.Connect60(const AConnPath: String;
  AServerTypes: UNSIGNED16; AUserName, APassword: String;
  AOptions: UNSIGNED32);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsConnect60, ['pucConnectPath', AConnPath, 'usServerTypes', AServerTypes,
      'pucUserName', AUserName, '@pucPassword', '***', 'ulOptions', AOptions,
      'phConnect', Handle]);
  end;
{$ENDIF}

var
  iRes: UNSIGNED32;
  sConnPath, sUserName, sPassword: TFDByteString;
begin
  BeforeConnecting;
  sConnPath := Encoder.Encode(AConnPath);
  sUserName := Encoder.Encode(AUserName);
  sPassword := Encoder.Encode(APassword);
  iRes := Lib.FAdsConnect60(PAceChar(PByte(sConnPath)), AServerTypes,
                            PAceChar(PByte(sUserName)), PAceChar(PByte(sPassword)),
                            AOptions, @FHandle);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(iRes);
  AfterConnecting;
end;

{-------------------------------------------------------------------------------}
function ADStmtCallback(usPercent: UNSIGNED16; iCallbackID: NativeUInt):
  UNSIGNED32; {$IFDEF WIN32} stdcall; {$ENDIF} {$IFDEF POSIX} cdecl; {$ENDIF}
begin
  if TADSConnection(Pointer(iCallbackID)).DoProgress(usPercent) then
    Result := 1
  else
    Result := 0;
end;

{-------------------------------------------------------------------------------}
function TADSConnection.DoProgress(usPercent: UNSIGNED16): Boolean;
begin
  if FAbortRequest then begin
    FAbortRequest := False;
    Result := True;
  end
  else
    Result := False;
  if Assigned(FOnProgress) then
    FOnProgress(Self, usPercent, Result);
end;

{-------------------------------------------------------------------------------}
procedure TADSConnection.EnableProgress;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
  {$IFDEF FireDAC_64}
    Trace(sAdsRegisterCallbackFunction101, ['iCallbackID', Pointer(Self)]);
  {$ELSE}
    Trace(sAdsRegisterCallbackFunction, ['iCallbackID', Pointer(Self)]);
  {$ENDIF}
  end;
{$ENDIF}

begin
  Inc(FProgressCount);
  if FProgressCount <> 1 then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
{$IFDEF FireDAC_64}
  Check(Lib.FAdsRegisterCallbackFunction101(@ADStmtCallback, NativeUInt(Self)));
{$ELSE}
  Check(Lib.FAdsRegisterCallbackFunction(@ADStmtCallback, NativeUInt(Self)));
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TADSConnection.DisableProgress;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsClearCallbackFunction, []);
  end;
{$ENDIF}

begin
  if FProgressCount > 0 then
    Dec(FProgressCount);
  if FProgressCount <> 0 then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  FAbortRequest := False;
  Check(Lib.FAdsClearCallbackFunction());
end;

{-------------------------------------------------------------------------------}
procedure TADSConnection.SetOnProgress(const AValue: TADSProgressCallback);
begin
  if (TMethod(FOnProgress).Code <> TMethod(AValue).Code) or
     (TMethod(FOnProgress).Data <> TMethod(AValue).Data) then begin
    if Assigned(FOnProgress) then
      DisableProgress;
    FOnProgress := AValue;
    if Assigned(FOnProgress) then
      EnableProgress;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TADSConnection.Abort;
begin
  FAbortRequest := True;
end;

{-------------------------------------------------------------------------------}
procedure TADSConnection.Disconnect;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsDisconnect, ['hConnect', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  if (Handle = 0) or not FOwnHandle then
    Exit;
  Lib.FAdsDisconnect(Handle);
  FHandle := 0;
end;

{-------------------------------------------------------------------------------}
function TADSConnection.Ping: Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsIsConnectionAlive, ['hConnect', Handle]);
  end;
{$ENDIF}

var
  iFlag: UNSIGNED16;
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsIsConnectionAlive(Handle, @iFlag));
  Result := iFlag <> 0;
end;

{-------------------------------------------------------------------------------}
procedure TADSConnection.BeginTransaction(const AName: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsBeginTransaction, ['hConnect', Handle]);
  end;

  procedure Trace2;
  begin
    Trace(sAdsCreateSavepoint, ['hConnect', Handle, 'pucSavepoint', AName]);
  end;
{$ENDIF}

var
  sb: TFDByteString;
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsBeginTransaction(Handle));
  if AName <> '' then begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace2;
{$ENDIF}
    sb := Encoder.Encode(AName);
    Check(Lib.FAdsCreateSavepoint(Handle, PAceChar(PByte(sb)), 0));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TADSConnection.Commit;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsCommitTransaction, ['hConnect', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsCommitTransaction(Handle));
end;

{-------------------------------------------------------------------------------}
procedure TADSConnection.Rollback(const AName: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsRollbackTransaction80, ['hConnect', Handle, 'pucSavepoint', AName]);
  end;
{$ENDIF}

var
  pucSavepoint: PAceChar;
  sb: TFDByteString;
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  if AName = '' then
    pucSavepoint := nil
  else begin
    sb := Encoder.Encode(AName);
    pucSavepoint := PAceChar(PByte(sb));
  end;
  Check(Lib.FAdsRollbackTransaction80(Handle, pucSavepoint, 0));
end;

{-------------------------------------------------------------------------------}
function TADSConnection.GetTransactionCount: UNSIGNED32;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGetTransactionCount, ['hConnect', Handle, 'pulTransactionCount', Result]);
  end;
{$ENDIF}

var
  iRes: UNSIGNED32;
begin
  if not Assigned(Lib.FAdsGetTransactionCount) then begin
    Result := 0;
    Exit;
  end;
  iRes := Lib.FAdsGetTransactionCount(Handle, @Result);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
procedure TADSConnection.SetAutoIncEnforcement(const AValue: Boolean);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsEnableAutoIncEnforcement, ['hConnect', Handle]);
  end;

  procedure Trace2;
  begin
    Trace(sAdsDisableAutoIncEnforcement, ['hConnect', Handle]);
  end;
{$ENDIF}

begin
  if FAutoIncEnforcement <> AValue then begin
    FAutoIncEnforcement := AValue;
    if AValue then begin
{$IFDEF FireDAC_MONITOR}
      if Tracing then Trace1;
{$ENDIF}
      Check(Lib.FAdsEnableAutoIncEnforcement(Handle));
    end
    else begin
{$IFDEF FireDAC_MONITOR}
      if Tracing then Trace2;
{$ENDIF}
      Check(Lib.FAdsDisableAutoIncEnforcement(Handle));
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TADSConnection.SetRIEnforcement(const AValue: Boolean);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsEnableRI, ['hConnect', Handle]);
  end;

  procedure Trace2;
  begin
    Trace(sAdsDisableRI, ['hConnect', Handle]);
  end;
{$ENDIF}

begin
  if FRIEnforcement <> AValue then begin
    FRIEnforcement := AValue;
    if AValue then begin
{$IFDEF FireDAC_MONITOR}
      if Tracing then Trace1;
{$ENDIF}
      Check(Lib.FAdsEnableRI(Handle));
    end
    else begin
{$IFDEF FireDAC_MONITOR}
      if Tracing then Trace2;
{$ENDIF}
      Check(Lib.FAdsDisableRI(Handle));
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TADSConnection.SetUniqueEnforcement(const AValue: Boolean);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsEnableUniqueEnforcement, ['hConnect', Handle]);
  end;

  procedure Trace2;
  begin
    Trace(sAdsDisableUniqueEnforcement, ['hConnect', Handle]);
  end;
{$ENDIF}

begin
  if FUniqueEnforcement <> AValue then begin
    FUniqueEnforcement := AValue;
    if AValue then begin
{$IFDEF FireDAC_MONITOR}
      if Tracing then Trace1;
{$ENDIF}
      Check(Lib.FAdsEnableUniqueEnforcement(Handle));
    end
    else begin
{$IFDEF FireDAC_MONITOR}
      if Tracing then Trace2;
{$ENDIF}
      Check(Lib.FAdsDisableUniqueEnforcement(Handle));
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TADSConnection.GetCollation: String;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGetCollation, ['hConnect', Handle, 'pucCollation', Result]);
  end;
{$ENDIF}

var
  aBuf: array [0 .. ADS_MAX_OBJECT_NAME] of AceChar;
  usLen: UNSIGNED16;
  iRes: UNSIGNED32;
begin
  Result := '';
  if not Assigned(Lib.FAdsGetCollation) then
    Exit;
  usLen := SizeOf(aBuf);
  iRes := Lib.FAdsGetCollation(Handle, @aBuf[0], @usLen);
  if iRes = AE_SUCCESS then
    Result := Encoder.Decode(@aBuf[0], usLen);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
procedure TADSConnection.SetCollation(const AValue: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsSetCollation, ['hConnect', Handle, 'pucCollation', AValue]);
  end;
{$ENDIF}

var
  sb: TFDByteString;
begin
  if not Assigned(Lib.FAdsGetCollation) then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  sb := Encoder.Encode(AValue);
  Check(Lib.FAdsSetCollation(Handle, PAceChar(PByte(sb))));
end;

{-------------------------------------------------------------------------------}
function TADSConnection.GetConnectionPath: String;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGetConnectionPath, ['hConnect', Handle, 'pucConnectionPath', Result]);
  end;
{$ENDIF}

var
  aBuf: array [0 .. ADS_MAX_PATH] of AceChar;
  usLen: UNSIGNED16;
  iRes: UNSIGNED32;
begin
  Result := '';
  usLen := SizeOf(aBuf);
  iRes := Lib.FAdsGetConnectionPath(Handle, @aBuf[0], @usLen);
  if iRes = AE_SUCCESS then
    Result := Encoder.Decode(@aBuf[0], usLen);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
function TADSConnection.GetDateFormat: String;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGetDateFormat60, ['hConnect', Handle, 'pucFormat', Result]);
  end;
{$ENDIF}

var
  aBuf: array [0 .. ADS_MAX_OBJECT_NAME] of AceChar;
  usLen: UNSIGNED16;
  iRes: UNSIGNED32;
begin
  Result := '';
  usLen := SizeOf(aBuf);
  iRes := Lib.FAdsGetDateFormat60(Handle, @aBuf[0], @usLen);
  if iRes = AE_SUCCESS then
    Result := Encoder.Decode(@aBuf[0], usLen);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
procedure TADSConnection.SetDateFormat(const AValue: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsSetDateFormat60, ['hConnect', Handle, 'pucFormat', AValue]);
  end;
{$ENDIF}

var
  sb: TFDByteString;
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  sb := Encoder.Encode(AValue);
  Check(Lib.FAdsSetDateFormat60(Handle, PAceChar(PByte(sb))));
end;

{-------------------------------------------------------------------------------}
{ TADSStatement                                                                 }
{-------------------------------------------------------------------------------}
constructor TADSStatement.Create(AConn: TADSConnection; AOwningObj: TObject);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsCreateSQLStatement, ['hConnect', Connection.Handle]);
  end;
{$ENDIF}

begin
  inherited Create;
  FLib := AConn.Lib;
  FConnection := AConn;
  FOwningObj := AOwningObj;
  FTimeout := ADS_DEFAULT_SQL_TIMEOUT;
  FCharType := ADS_ANSI;
  FCollation := '';
  FLockType := ltProprietary;
  FReadOnly := False;
  FTableType := ttDefault;
  FParams := TADSVariables.Create(Self, Self);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsCreateSQLStatement(Connection.Handle, @FHandle));
end;

{-------------------------------------------------------------------------------}
destructor TADSStatement.Destroy;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsCloseSQLStatement, ['hStatement ', Handle]);
  end;
{$ENDIF}

begin
  if Handle <> 0 then
    Unprepare;
  FDFreeAndNil(FParams);
  Check(Lib.FAdsCloseSQLStatement(Handle));
  FHandle := 0;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TADSStatement.Prepare(const ASQL: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsPrepareSQLW, ['hStatement', Handle, 'pwcSQL', ASQL]);
  end;

  procedure Trace2;
  begin
    Trace(sAdsPrepareSQL, ['hStatement', Handle, 'pucSQL', ASQL]);
  end;
{$ENDIF}

  procedure PrepareAnsi;
  var
    sb: TFDByteString;
  begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace2;
{$ENDIF}
    sb := Encoder.Encode(ASQL);
    Check(Lib.FAdsPrepareSQL(Handle, PAceChar(PByte(sb))));
  end;

begin
  if Assigned(Lib.FAdsPrepareSQLW) then begin
  {$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
  {$ENDIF}
    Check(Lib.FAdsPrepareSQLW(Handle, PWideChar(ASQL)));
  end
  else
    PrepareAnsi;
end;

{-------------------------------------------------------------------------------}
procedure TADSStatement.Unprepare;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsClearSQLParams, ['hStatement ', Handle]);
  end;
{$ENDIF}

begin
  if Handle <> 0 then begin
    Close;
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(Lib.FAdsClearSQLParams(Handle));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TADSStatement.ExecuteDirect(const ASQL: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsExecuteSQLDirectW, ['hStatement', Handle, 'pwcSQL', ASQL]);
  end;

  procedure Trace2;
  begin
    Trace(sAdsExecuteSQLDirect, ['hStatement', Handle, 'pucSQL', ASQL]);
  end;
{$ENDIF}

  procedure ExecuteAnsi;
  var
    sb: TFDByteString;
  begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace2;
{$ENDIF}
    sb := Encoder.Encode(ASQL);
    Check(Lib.FAdsExecuteSQLDirect(Handle, PAceChar(PByte(sb)),
      @FCursorHandle));
  end;

begin
  FCursorHandle := 0;
  if Assigned(Lib.FAdsExecuteSQLDirectW) then begin
  {$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
  {$ENDIF}
    Check(Lib.FAdsExecuteSQLDirectW(Handle, PWideChar(ASQL), @FCursorHandle));
  end
  else
    ExecuteAnsi;
  FConnection.FLastAutoInc := LastAutoInc;
end;

{-------------------------------------------------------------------------------}
procedure TADSStatement.Execute;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsExecuteSQL, ['hStatement', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
// The following leads to "Error 5023: Advantage does not have a table or cursor
// open with the specified handle.  The handle must be to a table" after call of
// AdsIsEmpty and AdsGetXxx ACE procedures.
//  if Tracing then begin
//    DumpParams;
//    Trace1;
//  end;
{$ENDIF}
  FCursorHandle := 0;
  Check(Lib.FAdsExecuteSQL(Handle, @FCursorHandle));
  FConnection.FLastAutoInc := LastAutoInc;
end;

{-------------------------------------------------------------------------------}
procedure TADSStatement.Close;
var
  iRes: UNSIGNED32;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsCloseTable, ['hTable', FCursorHandle]);
  end;
{$ENDIF}

begin
  if FCursorHandle <> 0 then begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    iRes := Lib.FAdsCloseTable(FCursorHandle);
    FCursorHandle := 0;
    Check(iRes);
  end;
end;

{-------------------------------------------------------------------------------}
function TADSStatement.GetLastAutoInc: UNSIGNED32;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGetLastAutoInc, ['hStatement', Handle, 'ulAutoIncVal', Result]);
  end;
{$ENDIF}

var
  iRes: UNSIGNED32;
begin
  iRes := Lib.FAdsGetLastAutoInc(Handle, @Result);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
function TADSStatement.GetRecordCount: UNSIGNED32;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGetRecordCount, ['hStatement', Handle, 'ulCount', Result]);
  end;
{$ENDIF}

var
  iRes: UNSIGNED32;
begin
  iRes := Lib.FAdsGetRecordCount(Handle, ADS_RESPECTFILTERS or ADS_RESPECTSCOPES, @Result);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
function TADSStatement.GetCursor: TADSCursor;
begin
  if FCursorHandle <> 0 then begin
    Result := TADSCursor.Create(Self, FCursorHandle, OwningObj);
    FCursorHandle := 0;
  end
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
procedure TADSStatement.SetTimeout(const AValue: UNSIGNED32);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsSetSQLTimeout, ['hObj', Handle, 'ulTimeout', AValue]);
  end;
{$ENDIF}

begin
  if not Assigned(Lib.FAdsSetSQLTimeout) then
    Exit;
  if FTimeout <> AValue then begin
    FTimeout := AValue;
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(Lib.FAdsSetSQLTimeout(Handle, AValue));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TADSStatement.SetCharType(const AValue: UNSIGNED16);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsStmtSetTableCharType, ['hStatement', Handle, 'usCharType', AValue]);
  end;
{$ENDIF}

begin
  if FCharType <> AValue then begin
    FCharType := AValue;
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(Lib.FAdsStmtSetTableCharType(Handle, FCharType));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TADSStatement.SetCollation(const AValue: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsStmtSetTableCollation, ['hStatement', Handle, 'pucCollation', AValue]);
  end;
{$ENDIF}

var
  sb: TFDByteString;
begin
  if not Assigned(Lib.FAdsStmtSetTableCollation) then
    Exit;
  if FCollation <> AValue then begin
    FCollation := AValue;
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    sb := Encoder.Encode(FCollation);
    Check(Lib.FAdsStmtSetTableCollation(Handle, PAceChar(PByte(sb))));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TADSStatement.SetLockType(const AValue: TADSLockType);
var
  usLockType: UNSIGNED16;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsStmtSetTableLockType, ['hStatement', Handle, 'usLockType', usLockType]);
  end;
{$ENDIF}

begin
  if FLockType <> AValue then begin
    FLockType := AValue;
    usLockType := ADSLockType2Int(FLockType);
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(Lib.FAdsStmtSetTableLockType(Handle, usLockType));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TADSStatement.SetReadOnly(const AValue: Boolean);
var
  usReadOnly: UNSIGNED16;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsStmtSetTableReadOnly, ['hStatement', Handle, 'usReadOnly', usReadOnly]);
  end;
{$ENDIF}

begin
  if FReadOnly <> AValue then begin
    FReadOnly := AValue;
    if FReadOnly then
      usReadOnly := ADS_CURSOR_READONLY
    else
      usReadOnly := ADS_CURSOR_READWRITE;
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(Lib.FAdsStmtSetTableReadOnly(Handle, usReadOnly));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TADSStatement.SetTableType(const AValue: TADSTableType);
var
  usTableType: UNSIGNED16;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsStmtSetTableType, ['hStatement', Handle, 'usTableType', usTableType]);
  end;
{$ENDIF}

begin
  if FTableType <> AValue then begin
    FTableType := AValue;
    case FTableType of
    ttCDX: usTableType := ADS_CDX;
    ttVFP: usTableType := ADS_VFP;
    ttADT: usTableType := ADS_ADT;
    ttNTX: usTableType := ADS_NTX;
    else   usTableType := ADS_DEFAULT;
    end;
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(Lib.FAdsStmtSetTableType(Handle, usTableType));
  end;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
(*
procedure TADSStatement.DumpParams;
var
  i: Integer;
  oParam: TADSVariable;
begin
  if Tracing and (FParams.Count > 0) then begin
    Trace(ekCmdDataIn, esStart, 'Sent', []);
    for i := 0 to FParams.Count - 1 do begin
      oParam := FParams[i];
      Trace(ekCmdDataIn, esProgress, 'Var', [String('N'), i, 'Name', oParam.DumpLabel,
        '@Type', oParam.DumpSQLDataType, '@Data(0)', oParam.DumpValue]);
    end;
    Trace(ekCmdDataIn, esEnd, 'Sent', []);
  end;
end;
*)
{$ENDIF}

{-------------------------------------------------------------------------------}
procedure TADSStatement.SetTablePassword(const ATableName, APassword: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsStmtSetTablePassword, ['hStatement', Handle,
      'pucTableName', FDUnquote(ATableName), 'pucPassword', '*****']);
  end;
{$ENDIF}

var
  sb1, sb2: TFDByteString;
begin
  sb1 := Encoder.Encode(FDUnquote(ATableName));
  sb2 := Encoder.Encode(APassword);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsStmtSetTablePassword(Handle, PAceChar(PByte(sb1)), PAceChar(PByte(sb2))));
end;

{-------------------------------------------------------------------------------}
{ TADSColumnDef                                                                 }
{-------------------------------------------------------------------------------}
constructor TADSColumnDef.Create(ACursor: TADSCursor; AIndex: Integer);
var
  aBuf: array [0 .. ADS_MAX_FIELD_NAME] of AceChar;
  usLen: UNSIGNED16;
  iRes: UNSIGNED32;
  oLib: TADSLib;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FCursor.Trace('AdsGetFieldXxx', ['hTable', FCursor.Handle,
      'usFld', AIndex + 1, 'Name', Name, 'FieldType', FieldType,
      'MemoType', MemoType, 'Length', Length, 'Precision', Precision,
      'Scale', Scale]);
  end;
{$ENDIF}

begin
  inherited Create;
  FCursor := ACursor;
  oLib := FCursor.Lib;
  FPosition := AIndex + 1;
  FScale := 0;
  FPrecision := 0;
  usLen := SizeOf(aBuf);
  FCursor.Check(oLib.FAdsGetFieldName(FCursor.Handle, FPosition, @aBuf[0], @usLen));
  FName := FCursor.Encoder.Decode(@aBuf[0], usLen);
  FCursor.Check(oLib.FAdsGetFieldType(FCursor.Handle, PAceChar(FPosition), @FFieldType));
  FCursor.Check(oLib.FAdsGetFieldLength(FCursor.Handle, PAceChar(FPosition), @FLength));
  case FFieldType of
  ADS_MEMO:
    begin
      FMemoType := ADS_MEMO;
      iRes := oLib.FAdsGetMemoDataType(FCursor.Handle, PAceChar(FPosition), @FMemoType);
      if (iRes <> AE_SUCCESS) and (iRes <> AE_NO_CURRENT_RECORD) then
        FCursor.Check(iRes);
    end;
  ADS_NUMERIC:
    begin
      FCursor.Check(oLib.FAdsGetFieldDecimals(FCursor.Handle, PAceChar(FPosition), @FScale));
      if FCursor.TableType = ttADT then
        FPrecision := FLength - 1
      else
        FPrecision := FLength;
      if FScale > 0 then
        Dec(FPrecision);
    end;
  ADS_DOUBLE,
  ADS_CURDOUBLE:
    FPrecision := 15;
  ADS_MONEY:
    begin
      FPrecision := 19;
      FScale := 4;
    end;
  end;
{$IFDEF FireDAC_MONITOR}
  if FCursor.Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
{ TADSBLOBStream                                                                }
{-------------------------------------------------------------------------------}
constructor TADSBLOBStream.Create(AObj: TADSHandle; AVariable: TADSVariable);
begin
  inherited Create;
  FObj := AObj;
  FVariable := AVariable;
  FPosition := 0;
end;

{-------------------------------------------------------------------------------}
procedure TADSBLOBStream.SetSize(NewSize: Longint);
begin
  FSize := NewSize;
end;

{-------------------------------------------------------------------------------}
function TADSBLOBStream.Read(var Buffer; Count: Longint): Longint;
var
  iCount: UNSIGNED32;
  iRes: UNSIGNED32;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FObj.Trace(sAdsGetBinary, ['hTable', FObj.Handle, 'pucFldName',
      FObj.Lib.DumpField(FVariable.FField), 'ulOffset', FPosition, 'pulLen', Count]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if FObj.Tracing then Trace1;
{$ENDIF}
  iCount := Count;
  iRes := FObj.Lib.FAdsGetBinary(FObj.Handle, FVariable.FField, FPosition,
    PAceBinary(@Buffer), @iCount);
  FPosition := FPosition + iCount;
  FObj.Check(iRes);
  Result := iCount;
end;

{-------------------------------------------------------------------------------}
function TADSBLOBStream.Write(const Buffer; Count: Longint): Longint;
var
  usBinaryType: UNSIGNED16;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FObj.Trace(sAdsSetBinary, ['hTable', FObj.Handle, 'pucFldName',
      FObj.Lib.DumpField(FVariable.FField), 'usBinaryType', usBinaryType,
      'ulTotalLength', Count, 'ulOffset', FPosition]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if FObj.Tracing then Trace1;
{$ENDIF}
  if FVariable.IsImage then
    usBinaryType := ADS_IMAGE
  else
    usBinaryType := ADS_BINARY;
  if FSize = 0 then
    FSize := Count;
  FObj.Check(FObj.Lib.FAdsSetBinary(FObj.Handle, FVariable.FField, usBinaryType,
    FSize, FPosition, PAceBinary(@Buffer), Count));
  FPosition := FPosition + Count;
  Result := Count;
end;

{-------------------------------------------------------------------------------}
function TADSBLOBStream.Seek(Offset: Longint; Origin: Word): Longint;
var
  ulLength: UNSIGNED32;
  iRes: UNSIGNED32;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FObj.Trace(sAdsGetBinaryLength, ['hTable', FObj.Handle, 'pucFldName',
      FObj.Lib.DumpField(FVariable.FField), 'pulLength', ulLength]);
  end;
{$ENDIF}

begin
  case Origin of
    soFromBeginning:
      FPosition := Offset;
    soFromCurrent:
      FPosition := FPosition + Offset;
    soFromEnd:
      begin
        iRes := FObj.Lib.FAdsGetBinaryLength(FObj.Handle, FVariable.FField, @ulLength);
{$IFDEF FireDAC_MONITOR}
        if FObj.Tracing then Trace1;
{$ENDIF}
        FObj.Check(iRes);
        FPosition := SIGNED32(ulLength) - Offset;
      end;
  else
    Assert(False);
  end;
  Result := FPosition;
end;

{-------------------------------------------------------------------------------}
function TADSBLOBStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  Result := Seek(Integer(Offset), Word(Origin));
end;

{-------------------------------------------------------------------------------}
procedure TADSBLOBStream.LoadFromFile(const AFileName: string);
var
  usBinaryType: UNSIGNED16;
  sb: TFDByteString;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FObj.Trace(sAdsFileToBinary, ['hTable', FObj.Handle, 'pucFldName',
      FObj.Lib.DumpField(FVariable.FField), 'usBinaryType', usBinaryType,
      'pucFileName', AFileName]);
  end;
{$ENDIF}

begin
  FPosition := 0;
  if FVariable.IsImage then
    usBinaryType := ADS_IMAGE
  else
    usBinaryType := ADS_BINARY;
{$IFDEF FireDAC_MONITOR}
  if FObj.Tracing then Trace1;
{$ENDIF}
  sb := FObj.Encoder.Encode(AFileName);
  FObj.Check(FObj.Lib.FAdsFileToBinary(FObj.Handle, FVariable.FField,
    usBinaryType, PAceChar(PByte(sb))));
end;

{-------------------------------------------------------------------------------}
procedure TADSBLOBStream.SaveToFile(const AFileName: string);
var
  sb: TFDByteString;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FObj.Trace(sAdsBinaryToFile, ['hTable', FObj.Handle, 'pucFldName',
      FObj.Lib.DumpField(FVariable.FField), 'pucFileName', AFileName]);
  end;
{$ENDIF}

begin
  FPosition := 0;
{$IFDEF FireDAC_MONITOR}
  if FObj.Tracing then Trace1;
{$ENDIF}
  sb := FObj.Encoder.Encode(AFileName);
  FObj.Check(FObj.Lib.FAdsBinaryToFile(FObj.Handle, FVariable.FField,
    PAceChar(PByte(sb))));
end;

{-------------------------------------------------------------------------------}
{ TADSVariable                                                                  }
{-------------------------------------------------------------------------------}
constructor TADSVariable.Create(AVars: TADSVariables; AObj: TADSHandle);
begin
  inherited Create;
  FVars := AVars;
  FObj := AObj;
end;

{-------------------------------------------------------------------------------}
procedure TADSVariable.SetName(const AValue: String);
begin
  FName := AValue;
  FNameBytes := FObj.Encoder.Encode(AValue);
  FField := PAceChar(PByte(FNameBytes));
end;

{-------------------------------------------------------------------------------}
function TADSVariable.GetPosition: UNSIGNED16;
begin
  if NativeUInt(FField) < $0000FFFF then
    Result := UNSIGNED16(FField)
  else
    Result := 0;
end;

{-------------------------------------------------------------------------------}
procedure TADSVariable.SetPosition(const AValue: UNSIGNED16);
begin
  FField := PAceChar(AValue);
  FName := '';
  SetLength(FNameBytes, 0);
end;

{-------------------------------------------------------------------------------}
function TADSVariable.GetIsNull: Boolean;
var
  bNull: UNSIGNED16;
  iRes: UNSIGNED32;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FObj.Trace(sAdsIsEmpty, ['hTable', FObj.Handle, 'pucFldName',
      FObj.Lib.DumpField(FField), 'pbEmpty', bNull]);
  end;
{$ENDIF}

begin
  iRes := FObj.Lib.FAdsIsEmpty(FObj.Handle, FField, @bNull);
{$IFDEF FireDAC_MONITOR}
  if FObj.Tracing then Trace1;
{$ENDIF}
  FObj.Check(iRes);
  Result := bNull <> 0;
end;

{-------------------------------------------------------------------------------}
procedure TADSVariable.Clear;
var
  iRes: UNSIGNED32;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FObj.Trace(sAdsSetNull, ['hTable', FObj.Handle, 'pucFldName',
      FObj.Lib.DumpField(FField)]);
  end;

  procedure Trace2;
  begin
    FObj.Trace(sAdsSetEmpty, ['hTable', FObj.Handle, 'pucFldName',
      FObj.Lib.DumpField(FField)]);
  end;
{$ENDIF}

begin
  iRes := AE_NOT_VFP_NULLABLE_FIELD;
  if Assigned(FObj.Lib.FAdsSetNull) then begin
{$IFDEF FireDAC_MONITOR}
    if FObj.Tracing then Trace1;
{$ENDIF}
    iRes := FObj.Lib.FAdsSetNull(FObj.Handle, FField);
  end;
  if iRes = AE_NOT_VFP_NULLABLE_FIELD then begin
{$IFDEF FireDAC_MONITOR}
    if FObj.Tracing then Trace2;
{$ENDIF}
    iRes := FObj.Lib.FAdsSetEmpty(FObj.Handle, FField);
  end;
  FObj.Check(iRes);
end;

{-------------------------------------------------------------------------------}
function TADSVariable.GetData(AValue: Pointer; var ASize: Integer): Boolean;

  procedure GetAsGUID(ApBuff: PByte; ALen: Integer; AValue: Pointer; var ASize: Integer);
  begin
    PGUID(AValue)^ := StringToGUID('{' + FObj.Encoder.Decode(ApBuff, ALen) + '}');
    ASize := SizeOf(TGUID);
  end;

var
  bValue: UNSIGNED16;
  aBuff: array [0 .. 1023] of AceChar;
  pText: Pointer;
  ulLen: UNSIGNED32;
  lDate, lTime: SIGNED32;
  iRes: UNSIGNED32;
  dCurDbl: Double;
begin
  Result := True;
  case FValueType of
  ADS_LOGICAL:
    begin
      FObj.Check(FObj.Lib.FAdsGetLogical(FObj.Handle, FField, @bValue));
      PWordBool(AValue)^ := bValue <> 0;
      ASize := SizeOf(WordBool);
    end;
  ADS_NUMERIC:
    begin
      ulLen := SizeOf(aBuff);
      FObj.Check(FObj.Lib.FAdsGetString(FObj.Handle, FField, @aBuff[0], @ulLen, ADS_NONE));
      pText := nil;
      ASize := FObj.Encoder.Decode(@aBuff[0], ulLen, pText);
      FDStr2BCD(PChar(pText), ASize, PBcd(AValue)^, '.');
      ASize := SizeOf(TBcd);
    end;
  ADS_DOUBLE:
    begin
      FObj.Check(FObj.Lib.FAdsGetDouble(FObj.Handle, FField, pDOUBLE(AValue)));
      ASize := SizeOf(Double);
    end;
  ADS_CURDOUBLE:
    begin
      FObj.Check(FObj.Lib.FAdsGetDouble(FObj.Handle, FField, @dCurDbl));
      PCurrency(AValue)^ := dCurDbl;
      ASize := SizeOf(Currency);
    end;
  ADS_MONEY:
    begin
      ulLen := SizeOf(aBuff);
      FObj.Check(FObj.Lib.FAdsGetField(FObj.Handle, FField, @aBuff[0], @ulLen, ADS_NONE));
      pText := nil;
      ASize := FObj.Encoder.Decode(@aBuff[0], ulLen, pText);
      FDStr2Curr(PChar(pText), ASize, PCurrency(AValue)^, '.');
      ASize := SizeOf(Currency);
    end;
  ADS_INTEGER,
  ADS_AUTOINC:
    begin
      FObj.Check(FObj.Lib.FAdsGetLong(FObj.Handle, FField, PSIGNED32(AValue)));
      ASize := SizeOf(Integer);
    end;
  ADS_SHORTINT:
    begin
      FObj.Check(FObj.Lib.FAdsGetShort(FObj.Handle, FField, PSIGNED16(AValue)));
      ASize := SizeOf(SIGNED16);
    end;
  ADS_LONGLONG,
  ADS_ROWVERSION:
    begin
      FObj.Check(FObj.Lib.FAdsGetLongLong(FObj.Handle, FField, PSIGNED64(AValue)));
      ASize := SizeOf(Int64);
    end;
  ADS_DATE,
  ADS_COMPACTDATE:
    begin
      FObj.Check(FObj.Lib.FAdsGetJulian(FObj.Handle, FField, @lDate));
      if lDate = 0 then
        Result := False
      else begin
        PInteger(AValue)^ := lDate - JULIAN_TO_DELPHI_DATE;
        ASize := SizeOf(Integer);
      end;
    end;
  ADS_TIME:
    begin
      FObj.Check(FObj.Lib.FAdsGetMilliseconds(FObj.Handle, FField, PSIGNED32(AValue)));
      ASize := SizeOf(Integer);
    end;
  ADS_TIMESTAMP,
  ADS_MODTIME:
    begin
      FObj.Check(FObj.Lib.FAdsGetJulian(FObj.Handle, FField, @lDate));
      if lDate = 0 then
        Result := False
      else begin
        FObj.Check(FObj.Lib.FAdsGetMilliseconds(FObj.Handle, FField, @lTime));
        PSQLTimeStamp(AValue)^ := DateTimeToSQLTimeStamp(
          FDDate2DateTime(lDate - JULIAN_TO_DELPHI_DATE) + FDTime2DateTime(lTime));
        ASize := SizeOf(TSQLTimeStamp);
      end;
    end;
  ADS_STRING,
  ADS_CISTRING,
  ADS_VARCHAR,
  ADS_VARCHAR_FOX,
  ADS_MEMO:
    begin
      if FValueType = ADS_MEMO then
        FObj.Check(FObj.Lib.FAdsGetMemoLength(FObj.Handle, FField, @ulLen))
      else if Assigned(FObj.Lib.FAdsGetFieldLength100) then
        FObj.Check(FObj.Lib.FAdsGetFieldLength100(FObj.Handle, FField, ADS_BYTE_LENGTH, @ulLen))
      else
        FObj.Check(FObj.Lib.FAdsGetFieldLength(FObj.Handle, FField, @ulLen));
      iRes := FObj.Lib.FAdsGetString(FObj.Handle, FField, PAceChar(AValue), @ulLen, ADS_NONE);
      if iRes = AE_INSUFFICIENT_BUFFER then
        Dec(ulLen)
      else
        FObj.Check(iRes);
      if (FValueType in [ADS_STRING, ADS_CISTRING]) and ((FVars.FStmt = nil) or FVars.FStmt.StrsTrim) then
        while (ulLen > 0) and (PFDAnsiString(AValue)[ulLen - 1] = TFDAnsiChar(' ')) do
          Dec(ulLen);
      if (ulLen = 0) and ((FVars.FStmt = nil) or FVars.FStmt.StrsEmpty2Null) then
        Result := False;
      ASize := ulLen;
    end;
  ADS_NCHAR,
  ADS_NVARCHAR,
  ADS_NMEMO:
    begin
      if FValueType = ADS_NMEMO then
        FObj.Check(FObj.Lib.FAdsGetMemoLength(FObj.Handle, FField, @ulLen))
      else if Assigned(FObj.Lib.FAdsGetFieldLength100) then
        FObj.Check(FObj.Lib.FAdsGetFieldLength100(FObj.Handle, FField, ADS_CODEUNIT_LENGTH, @ulLen))
      else begin
        FObj.Check(FObj.Lib.FAdsGetFieldLength(FObj.Handle, FField, @ulLen));
        ulLen := ulLen div SizeOf(WideChar);
      end;
      ASSERT(Assigned(FObj.Lib.FAdsGetStringW));
      iRes := FObj.Lib.FAdsGetStringW(FObj.Handle, FField, PWideChar(AValue), @ulLen, ADS_NONE);
      if iRes = AE_INSUFFICIENT_BUFFER then
        Dec(ulLen)
      else
        FObj.Check(iRes);
      if (FValueType = ADS_NCHAR) and ((FVars.FStmt = nil) or FVars.FStmt.StrsTrim) then
        while (ulLen > 0) and (PWideChar(AValue)[ulLen - 1] = ' ') do
          Dec(ulLen);
      if (ulLen = 0) and ((FVars.FStmt = nil) or FVars.FStmt.StrsEmpty2Null) then
        Result := False;
      ASize := ulLen;
    end;
  ADS_RAW,
  ADS_VARBINARY_FOX,
  ADS_SYSTEM_FIELD,
  ADS_TYPE_UNKNOWN:
    begin
      if Assigned(FObj.Lib.FAdsGetFieldLength100) then
        FObj.Check(FObj.Lib.FAdsGetFieldLength100(FObj.Handle, FField, ADS_BYTE_LENGTH, @ulLen))
      else
        FObj.Check(FObj.Lib.FAdsGetFieldLength(FObj.Handle, FField, @ulLen));
      FObj.Check(FObj.Lib.FAdsGetField(FObj.Handle, FField, PAceChar(AValue), @ulLen, ADS_NONE));
      ASize := ulLen;
    end;
  ADS_BINARY,
  ADS_IMAGE,
  ADS_FOXGENERAL,
  ADS_FOXPICTURE:
    begin
      FObj.Check(FObj.Lib.FAdsGetBinaryLength(FObj.Handle, FField, @ulLen));
      FObj.Check(FObj.Lib.FAdsGetBinary(FObj.Handle, FField, 0, PAceBinary(AValue), @ulLen));
      ASize := ulLen;
    end;
  ADS_GUID:
    begin
      ulLen := SizeOf(aBuff);
      FObj.Check(FObj.Lib.FAdsGetField(FObj.Handle, FField, @aBuff[0], @ulLen, ADS_GET_GUID_REGISTRY));
      GetAsGUID(@aBuff[0], ulLen, AValue, ASize);
    end;
  else
    ASSERT(False);
  end;
end;

{-------------------------------------------------------------------------------}
function TADSVariable.GetDataLength: UNSIGNED32;
begin
  case ValueType of
  ADS_MEMO,
  ADS_NMEMO:  FObj.Check(FObj.Lib.FAdsGetMemoLength(FObj.Handle, FField, @Result));
  ADS_BINARY,
  ADS_IMAGE:  FObj.Check(FObj.Lib.FAdsGetBinaryLength(FObj.Handle, FField, @Result));
  else        FObj.Check(FObj.Lib.FAdsGetFieldLength(FObj.Handle, FField, @Result));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TADSVariable.SetData(AValue: Pointer; ASize: Integer);

  procedure SetAsGUID(AValue: Pointer; ApBuff: PByte; out ALen: Integer);
  var
    s: String;
  begin
    s := GUIDToString(PGUID(AValue)^);
    ALen := Length(s);
    Move(s[1], ApBuff^, ALen * SizeOf(Char));
  end;

var
  aBytes: array [0..255] of Byte;
  pText: Pointer;
  iLen: Integer;
  rTS: TADSTimeStamp;
  dCurDbl: Double;
begin
  if AValue = nil then begin
    Clear;
    Exit;
  end;
  case FValueType of
  ADS_LOGICAL:
    FObj.Check(FObj.Lib.FAdsSetLogical(FObj.Handle, FField, UNSIGNED16(Boolean(PWordBool(AValue)^))));
  ADS_NUMERIC:
    begin
      FDBCD2Str(PChar(@aBytes[0]), iLen, PBcd(AValue)^, '.');
      pText := nil;
      iLen := FObj.Encoder.Encode(PChar(@aBytes[0]), iLen, pText);
      FObj.Check(FObj.Lib.FAdsSetString(FObj.Handle, FField, PAceChar(pText), iLen));
    end;
  ADS_DOUBLE:
    FObj.Check(FObj.Lib.FAdsSetDouble(FObj.Handle, FField, PDouble(AValue)^));
  ADS_CURDOUBLE:
    begin
      dCurDbl := PCurrency(AValue)^;
      FObj.Check(FObj.Lib.FAdsSetDouble(FObj.Handle, FField, dCurDbl));
    end;
  ADS_MONEY:
    begin
      FDCurr2Str(PChar(@aBytes[0]), iLen, PCurrency(AValue)^, '.');
      pText := nil;
      iLen := FObj.Encoder.Encode(PChar(@aBytes[0]), iLen, pText);
      FObj.Check(FObj.Lib.FAdsSetString(FObj.Handle, FField, PAceChar(pText), iLen));
    end;
  ADS_INTEGER,
  ADS_AUTOINC:
    FObj.Check(FObj.Lib.FAdsSetLong(FObj.Handle, FField, PSIGNED32(AValue)^));
  ADS_SHORTINT:
    FObj.Check(FObj.Lib.FAdsSetShort(FObj.Handle, FField, PSIGNED16(AValue)^));
  ADS_LONGLONG,
  ADS_ROWVERSION:
    FObj.Check(FObj.Lib.FAdsSetLongLong(FObj.Handle, FField, PSIGNED64(AValue)^));
  ADS_DATE,
  ADS_COMPACTDATE:
    FObj.Check(FObj.Lib.FAdsSetJulian(FObj.Handle, FField, PSIGNED32(AValue)^ + JULIAN_TO_DELPHI_DATE));
  ADS_TIME:
    FObj.Check(FObj.Lib.FAdsSetMilliseconds(FObj.Handle, FField, PSIGNED32(AValue)^));
  ADS_TIMESTAMP,
  ADS_MODTIME:
    begin
      rTS.lDate := FDSQLTimeStamp2Date(PSQLTimeStamp(AValue)^) + JULIAN_TO_DELPHI_DATE;
      rTS.lTime := FDSQLTimeStamp2Time(PSQLTimeStamp(AValue)^);
      FObj.Check(FObj.Lib.FAdsSetTimeStampRaw(FObj.Handle, FField, PAceChar(@rTS), SizeOf(rTS)));
    end;
  ADS_STRING,
  ADS_CISTRING,
  ADS_VARCHAR,
  ADS_VARCHAR_FOX,
  ADS_MEMO:
    begin
      if (FValueType in [ADS_STRING, ADS_CISTRING]) and ((FVars.FStmt = nil) or FVars.FStmt.StrsTrim) then
        while (ASize > 0) and (PFDAnsiString(AValue)[ASize - 1] = TFDAnsiChar(' ')) do
          Dec(ASize);
      if (ASize = 0) and ((FVars.FStmt = nil) or FVars.FStmt.StrsEmpty2Null) then
        Clear
      else
        FObj.Check(FObj.Lib.FAdsSetString(FObj.Handle, FField, PAceChar(AValue), ASize));
    end;
  ADS_NCHAR,
  ADS_NVARCHAR,
  ADS_NMEMO:
    begin
      if (FValueType = ADS_NCHAR) and ((FVars.FStmt = nil) or FVars.FStmt.StrsTrim) then
        while (ASize > 0) and (PWideChar(AValue)[ASize - 1] = ' ') do
          Dec(ASize);
      if (ASize = 0) and ((FVars.FStmt = nil) or FVars.FStmt.StrsEmpty2Null) then
        Clear
      else begin
        ASSERT(Assigned(FObj.Lib.FAdsSetStringW));
        FObj.Check(FObj.Lib.FAdsSetStringW(FObj.Handle, FField, PWideChar(AValue), ASize));
      end;
    end;
  ADS_RAW,
  ADS_VARBINARY_FOX,
  ADS_SYSTEM_FIELD,
  ADS_TYPE_UNKNOWN,
  ADS_BINARY,
  ADS_IMAGE,
  ADS_FOXGENERAL,
  ADS_FOXPICTURE:
    FObj.Check(FObj.Lib.FAdsSetBinary(FObj.Handle, FField, ADS_BINARY, ASize, 0,
      PAceBinary(AValue), ASize));
  ADS_GUID:
    begin
      SetAsGUID(AValue, @aBytes[0], iLen);
      pText := nil;
      iLen := FObj.Encoder.Encode(PChar(@aBytes[0]), iLen, pText);
      FObj.Check(FObj.Lib.FAdsSetString(FObj.Handle, FField, PAceChar(pText), iLen));
    end;
  else
    ASSERT(False);
  end;
end;

{-------------------------------------------------------------------------------}
function TADSVariable.CreateBlobStream: TADSBLOBStream;
begin
  Result := TADSBLOBStream.Create(FObj, Self);
end;

{-------------------------------------------------------------------------------}
function TADSVariable.GetAsString: String;
var
  aBuf: array [0 .. 1023] of AceChar;
  iSize: Integer;
begin
  if IsNull or not GetData(@aBuf[0], iSize) then
    Result := ''
  else
    Result := FObj.Encoder.Decode(@aBuf[0], iSize);
end;

{-------------------------------------------------------------------------------}
procedure TADSVariable.SetAsString(const AValue: String);
var
  sb: TFDByteString;
begin
  sb := FObj.Encoder.Encode(AValue);
  SetData(PByte(sb), Length(sb));
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TADSVariable.DumpSQLDataType: String;
begin
  case ValueType of
  ADS_TYPE_UNKNOWN: Result := 'TYPE_UNKNOWN';
  ADS_LOGICAL:      Result := 'LOGICAL';
  ADS_NUMERIC:      Result := 'NUMERIC';
  ADS_DATE:         Result := 'DATE';
  ADS_STRING:       Result := 'STRING';
  ADS_MEMO:         Result := 'MEMO';
  ADS_BINARY:       Result := 'BINARY';
  ADS_IMAGE:        Result := 'IMAGE';
  ADS_VARCHAR:      Result := 'VARCHAR';
  ADS_COMPACTDATE:  Result := 'COMPACTDATE';
  ADS_DOUBLE:       Result := 'DOUBLE';
  ADS_INTEGER:      Result := 'INTEGER';
  ADS_SHORTINT:     Result := 'SHORTINT';
  ADS_TIME:         Result := 'TIME';
  ADS_TIMESTAMP:    Result := 'TIMESTAMP';
  ADS_AUTOINC:      Result := 'AUTOINC';
  ADS_RAW:          Result := 'RAW';
  ADS_CURDOUBLE:    Result := 'CURDOUBLE';
  ADS_MONEY:        Result := 'MONEY';
  ADS_LONGLONG:     Result := 'LONGLONG';
  ADS_CISTRING:     Result := 'CISTRING';
  ADS_ROWVERSION:   Result := 'ROWVERSION';
  ADS_MODTIME:      Result := 'MODTIME';
  ADS_VARCHAR_FOX:  Result := 'VARCHAR_FOX';
  ADS_VARBINARY_FOX:Result := 'VARBINARY_FOX';
  ADS_SYSTEM_FIELD: Result := 'SYSTEM_FIELD';
  ADS_NCHAR:        Result := 'NCHAR';
  ADS_NVARCHAR:     Result := 'NVARCHAR';
  ADS_NMEMO:        Result := 'NMEMO';
  ADS_FOXGENERAL:   Result := 'FOXGENERAL';
  ADS_FOXPICTURE:   Result := 'FOXPICTURE';
  ADS_GUID:         Result := 'GUID';
  else              Result := 'UNKNOWN(' + IntToStr(ValueType) + ')';
  end;
end;

{-------------------------------------------------------------------------------}
function TADSVariable.DumpValue: String;
var
  aBuff: array [0 .. 1023] of AceChar;
  aBytes: array [0 .. 255] of Byte;
  pData: Pointer;
  iSize: Integer;
begin
  if IsNull then
    Result := 'NULL'
  else begin
    pData := @aBuff[0];
    GetData(pData, iSize);
    case FValueType of
    ADS_LOGICAL:
      Result := S_FD_Bools[PWordBool(pData)^];
    ADS_NUMERIC:
      begin
        FDBCD2Str(PChar(@aBytes[0]), iSize, PBcd(pData)^,
          Char(FormatSettings.DecimalSeparator));
        SetString(Result, PChar(@aBytes[0]), iSize);
      end;
    ADS_DOUBLE:
      Result := FloatToStr(PDouble(pData)^);
    ADS_MONEY,
    ADS_CURDOUBLE:
      Result := CurrToStr(PCurrency(pData)^);
    ADS_INTEGER,
    ADS_AUTOINC:
      Result := IntToStr(PInteger(pData)^);
    ADS_SHORTINT:
      Result := IntToStr(PSmallint(pData)^);
    ADS_LONGLONG,
    ADS_ROWVERSION:
      Result := IntToStr(PInt64(pData)^);
    ADS_DATE,
    ADS_COMPACTDATE:
      Result := DateToStr(FDDate2DateTime(PInteger(pData)^));
    ADS_TIME:
      Result := TimeToStr(FDTime2DateTime(PInteger(pData)^));
    ADS_TIMESTAMP,
    ADS_MODTIME:
      Result := DateTimeToStr(SQLTimeStampToDateTime(PSQLTimeStamp(pData)^));
    ADS_STRING,
    ADS_CISTRING,
    ADS_VARCHAR,
    ADS_VARCHAR_FOX:
      if iSize > 1024 then
        Result := '(truncated at 1024) ''' + FObj.Encoder.Decode(pData, 1024) + ' ...'''
      else
        Result := '''' + FObj.Encoder.Decode(pData, iSize) + '''';
    ADS_NCHAR,
    ADS_NVARCHAR:
      if iSize > 1024 then begin
        SetString(Result, PWideChar(pData), 1024);
        Result := '(truncated at 1024) ''' + Result + ' ...''';
      end
      else begin
        SetString(Result, PWideChar(pData), iSize);
        Result := '''' + Result + '''';
      end;
    ADS_RAW,
    ADS_VARBINARY_FOX,
    ADS_SYSTEM_FIELD,
    ADS_TYPE_UNKNOWN:
      if iSize > 512 then
        Result := '(truncated at 512) ' + FDBin2Hex(pData, 512) + ' ...'
      else
        Result := FDBin2Hex(pData, iSize);
    ADS_BINARY,
    ADS_IMAGE,
    ADS_MEMO,
    ADS_NMEMO,
    ADS_FOXGENERAL,
    ADS_FOXPICTURE:
      Result := '<long value>';
    ADS_GUID:
      Result := GUIDToString(PGUID(pData)^);
    else
      ASSERT(False);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TADSVariable.DumpLabel: String;
begin
  Result := Name;
  if Name = '' then
    Result := '#' + IntToStr(Position);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TADSVariables                                                                 }
{-------------------------------------------------------------------------------}
constructor TADSVariables.Create(AStmt: TADSStatement; AObj: TADSHandle);
begin
  inherited Create;
  FStmt := AStmt;
  FObj := AObj;
  FList := TFDObjList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TADSVariables.Destroy;
begin
  Clear;
  FDFreeAndNil(FList);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TADSVariables.GetCount: Integer;
begin
  Result := FList.Count;
end;

{-------------------------------------------------------------------------------}
procedure TADSVariables.SetCount(const AValue: Integer);
var
  i: Integer;
begin
  if AValue = FList.Count then
    Exit;
  if AValue < FList.Count then begin
    for i := FList.Count - 1 downto AValue do
      FDFree(TADSVariable(FList[i]));
    FList.Count := AValue;
  end
  else
    for i := FList.Count + 1 to AValue do
      Add;
end;

{-------------------------------------------------------------------------------}
function TADSVariables.GetItems(AIndex: Integer): TADSVariable;
begin
  Result := TADSVariable(FList[AIndex]);
end;

{-------------------------------------------------------------------------------}
function TADSVariables.Add: TADSVariable;
begin
  Result := TADSVariable.Create(Self, FObj);
  FList.Add(Result);
end;

{-------------------------------------------------------------------------------}
procedure TADSVariables.Clear;
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    FDFree(TADSVariable(FList[i]));
  FList.Clear;
end;

{-------------------------------------------------------------------------------}
function TADSVariables.FindVar(const AName: String): TADSVariable;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FList.Count - 1 do
    if CompareText(AName, TADSVariable(FList[i]).Name) = 0 then begin
      Result := TADSVariable(FList[i]);
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
function TADSVariables.VarByName(const AName: String): TADSVariable;
begin
  Result := FindVar(AName);
  ASSERT(Result <> nil);
end;

{-------------------------------------------------------------------------------}
{ TADSCursor                                                                    }
{-------------------------------------------------------------------------------}
constructor TADSCursor.Create(AParent: TObject; AHandle: ADSHANDLE;
  AOwningObj: TObject);
begin
  inherited CreateUsingHandle(AHandle);
  if AParent is TADSStatement then begin
    FStmt := TADSStatement(AParent);
    FConnection := FStmt.Connection;
    FLib := FStmt.Lib;
  end
  else if AParent is TADSHandle then begin
    FConnection := TADSHandle(AParent).Connection;
    FLib := FConnection.Lib;
  end
  else if AParent is TADSLib then
    FLib := TADSLib(AParent);
  FOwningObj := AOwningObj;
  FColumns := TADSVariables.Create(FStmt, Self);
  FCacheRecords := 0;
  if Handle <> 0 then
    UpdateFieldsNum;
end;

{-------------------------------------------------------------------------------}
destructor TADSCursor.Destroy;
begin
  if Handle <> 0 then
    Close;
  FDFreeAndNil(FColumns);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TADSCursor.UpdateFieldsNum;
var
  iRes: UNSIGNED32;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGetNumFields, ['hTable', Handle, 'usCount', FColumnDefsCount]);
  end;
{$ENDIF}

begin
  iRes := Lib.FAdsGetNumFields(Handle, @FColumnDefsCount);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
procedure TADSCursor.AddColumns;
var
  i: Integer;
  oDef: TADSColumnDef;
  oCol: TADSVariable;
begin
  Columns.Count := ColumnDefsCount;
  for i := 0 to ColumnDefsCount - 1 do begin
    oDef := ColumnDefs[i];
    try
      oCol := Columns[i];
      oCol.Position := i + 1;
      oCol.Name := oDef.Name;
      oCol.ValueType := oDef.FieldType;
      oCol.IsImage := oDef.FieldType = ADS_IMAGE;
    finally
      FDFree(oDef);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TADSCursor.GetBof: Boolean;
var
  iRes: UNSIGNED32;
  bBOF: UNSIGNED16;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsAtBOF, ['hTable', Handle, 'pbBOF', bBOF]);
  end;
{$ENDIF}

begin
  iRes := Lib.FAdsAtBOF(Handle, @bBOF);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(iRes);
  Result := bBOF <> 0;
end;

{-------------------------------------------------------------------------------}
function TADSCursor.GetEof: Boolean;
var
  iRes: UNSIGNED32;
  bEOF: UNSIGNED16;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsAtEOF, ['hTable', Handle, 'pbEOF', bEOF]);
  end;
{$ENDIF}

begin
  iRes := Lib.FAdsAtEOF(Handle, @bEOF);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(iRes);
  Result := bEOF <> 0;
end;

{-------------------------------------------------------------------------------}
procedure TADSCursor.SetCacheRecords(const AValue: Integer);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsCacheRecords, ['hTable', Handle, 'usRecords', AValue]);
  end;
{$ENDIF}

begin
  if FCacheRecords <> AValue then begin
    FCacheRecords := AValue;
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(Lib.FAdsCacheRecords(Handle, FCacheRecords));
  end;
end;

{-------------------------------------------------------------------------------}
function TADSCursor.GetRecordCount: UNSIGNED32;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGetRecordCount, ['hTable', Handle, 'ulCount', Result]);
  end;
{$ENDIF}

var
  iRes: UNSIGNED32;
begin
  iRes := Lib.FAdsGetRecordCount(Handle, ADS_RESPECTFILTERS or ADS_RESPECTSCOPES, @Result);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
function TADSCursor.GetTableType: TADSTableType;
var
  iRes: UNSIGNED32;
  pusType: UNSIGNED16;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGetTableType, ['hTable', Handle, 'pusType', pusType]);
  end;
{$ENDIF}

begin
  if Handle = 0 then
    Result := FTableType
  else begin
    iRes := Lib.FAdsGetTableType(Handle, @pusType);
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(iRes);
    Result := ADSInt2TableType(pusType);
  end;
end;

{-------------------------------------------------------------------------------}
function TADSCursor.GetCharType: UNSIGNED16;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGetTableCharType, ['hTable', Handle, 'pusCharType', Result]);
  end;
{$ENDIF}

var
  iRes: UNSIGNED32;
begin
  if Handle = 0 then
    Result := FCharType
  else begin
    iRes := Lib.FAdsGetTableCharType(Handle, @Result);
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(iRes);
  end;
end;

{-------------------------------------------------------------------------------}
function TADSCursor.GetLockType: TADSLockType;
var
  iRes: UNSIGNED32;
  usLockType: UNSIGNED16;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGetTableLockType, ['hTable', Handle, 'pusLockType', usLockType]);
  end;
{$ENDIF}

begin
  if Handle = 0 then
    Result := FLockType
  else begin
    iRes := Lib.FAdsGetTableLockType(Handle, @usLockType);
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(iRes);
    Result := ADSInt2LockType(usLockType);
  end;
end;

{-------------------------------------------------------------------------------}
function TADSCursor.GetCheckRights: UNSIGNED16;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGetTableRights, ['hTable', Handle, 'pusRights', Result]);
  end;
{$ENDIF}

var
  iRes: UNSIGNED32;
begin
  if Handle = 0 then
    Result := FCheckRights
  else begin
    iRes := Lib.FAdsGetTableRights(Handle, @Result);
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(iRes);
  end;
end;

{-------------------------------------------------------------------------------}
function TADSCursor.GetColumnDefs(AIndex: Integer): TADSColumnDef;
begin
  Result := TADSColumnDef.Create(Self, AIndex);
end;

{-------------------------------------------------------------------------------}
procedure TADSCursor.Close;
var
  iRes: UNSIGNED32;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsCloseTable, ['hTable', Handle]);
  end;
{$ENDIF}

begin
  if Handle <> 0 then begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    iRes := Lib.FAdsCloseTable(Handle);
    FHandle := 0;
    Check(iRes);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TADSCursor.Skip(ARecs: Integer);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsSkip, ['hTable', Handle, 'lRecs', ARecs]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsSkip(Handle, ARecs));
{$IFDEF FireDAC_MONITOR}
  if Tracing and ((ARecs > 0) and not Eof or (ARecs < 0) and not Bof) then DumpColumns;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TADSCursor.GetRecNo: UNSIGNED32;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGetRecordNum, ['hTable', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsGetRecordNum(Handle, ADS_IGNOREFILTERS, @Result));
end;

{-------------------------------------------------------------------------------}
procedure TADSCursor.SetRecNo(const AValue: UNSIGNED32);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGotoRecord, ['hTable', Handle, 'ulRec', AValue]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsGotoRecord(Handle, AValue));
{$IFDEF FireDAC_MONITOR}
  if Tracing and not Eof and not Bof then DumpColumns;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TADSCursor.Top;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGotoTop, ['hTable', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsGotoTop(Handle));
{$IFDEF FireDAC_MONITOR}
  if Tracing and not Bof then DumpColumns;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TADSCursor.Bottom;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGotoBottom, ['hTable', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsGotoBottom(Handle));
{$IFDEF FireDAC_MONITOR}
  if Tracing and not Eof then DumpColumns;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TADSCursor.GetKeyColumns: String;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGetKeyColumn, ['hTable', Handle, 'ucKeyColumn', Result]);
  end;
{$ENDIF}

var
  aBuf: array [0 .. ADS_MAX_INDEX_EXPR_LEN] of AceChar;
  usLen: UNSIGNED16;
  iRes: UNSIGNED32;
begin
  usLen := SizeOf(aBuf);
  iRes := Lib.FAdsGetKeyColumn(Handle, @aBuf[0], @usLen);
  case iRes of
  AE_SUCCESS:
    begin
      while (usLen > 0) and ((aBuf[usLen - 1] = AceChar(#0)) or
                             (aBuf[usLen - 1] = AceChar(';'))) do
        Dec(usLen);
      Result := Encoder.Decode(@aBuf[0], usLen);
    end;
  AE_NOT_FOUND:
    ;
  else
    Check(iRes);
  end;
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TADSCursor.GetLastUpdate: TDateTime;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsGetLastTableUpdate, ['hTable', Handle, 'ucDate', DateToStr(Result)]);
  end;
{$ENDIF}

var
  aBuf: array [0 .. 32] of AceChar;
  usLen: UNSIGNED16;
  dJulian: Double;
begin
  usLen := SizeOf(aBuf);
  Check(Lib.FAdsGetLastTableUpdate(Handle, @aBuf[0], @usLen));
  Check(Lib.FAdsConvertStringToJulian(@aBuf[0], usLen, @dJulian));
  Result := FDDate2DateTime(Trunc(dJulian - JULIAN_TO_DELPHI_DATE));
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
procedure TADSCursor.DumpColumns;
var
  i: Integer;
  oCol: TADSVariable;
begin
  if Tracing and (Columns.Count > 0) then begin
    Trace(ekCmdDataOut, esStart, 'Fetched', []);
    for i := 0 to Columns.Count - 1 do begin
      oCol := Columns[i];
      Trace(ekCmdDataOut, esProgress, 'Field', [String('N'), i, 'Name',
        oCol.DumpLabel, '@Type', oCol.DumpSQLDataType, '@Data', oCol.DumpValue]);
    end;
    Trace(ekCmdDataOut, esEnd, 'Fetched', []);
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
procedure TADSCursor.Append;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsAppendRecord, ['hTable', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsAppendRecord(Handle));
end;

{-------------------------------------------------------------------------------}
procedure TADSCursor.Delete;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsDeleteRecord, ['hTable', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsDeleteRecord(Handle));
end;

{-------------------------------------------------------------------------------}
procedure TADSCursor.Recall;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsRecallRecord, ['hTable', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsRecallRecord(Handle));
end;

{-------------------------------------------------------------------------------}
function TADSCursor.GetDeleted: Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsIsRecordDeleted, ['hTable', Handle]);
  end;
{$ENDIF}

var
  iDeleted: UNSIGNED16;
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsIsRecordDeleted(Handle, @iDeleted));
  Result := iDeleted <> 0;
end;

{-------------------------------------------------------------------------------}
procedure TADSCursor.Post;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsWriteRecord, ['hTable', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsWriteRecord(Handle));
end;

{-------------------------------------------------------------------------------}
procedure TADSCursor.Lock(ARec: UNSIGNED32; AWaitTimeout: Cardinal = 0);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsLockRecord, ['hTable', Handle, 'ulRec', ARec]);
  end;
{$ENDIF}

var
  t: Cardinal;
  iRes: UNSIGNED32;
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  t := TThread.GetTickCount;
  repeat
    iRes := Lib.FAdsLockRecord(Handle, ARec);
    if (iRes = AE_LOCK_FAILED) and (AWaitTimeout > 0) then
      Sleep(100);
  until (iRes <> AE_LOCK_FAILED) or FDTimeout(t, AWaitTimeout) or
        Connection.FAbortRequest;
  Connection.FAbortRequest := False;
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
procedure TADSCursor.UnLock(ARec: UNSIGNED32);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsUnlockRecord, ['hTable', Handle, 'ulRec', ARec]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsUnLockRecord(Handle, ARec));
end;

{-------------------------------------------------------------------------------}
procedure TADSCursor.CopyTable(const AFile: String; AFilterOptions: UNSIGNED16);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsCopyTable, ['hTable', Handle, 'usFilterOptions', AFilterOptions,
      'pucFile', AFile]);
  end;
{$ENDIF}

var
  sb: TFDByteString;
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  sb := Encoder.Encode(AFile);
  Check(Lib.FAdsCopyTable(Handle, AFilterOptions, PAceChar(PByte(sb))));
end;

{-------------------------------------------------------------------------------}
procedure TADSCursor.EnableEncryption(const APassword: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsEnableEncryption, ['hTable', Handle]);
  end;
{$ENDIF}

var
  sb: TFDByteString;
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  sb := Encoder.Encode(APassword);
  Check(Lib.FAdsEnableEncryption(Handle, PAceChar(PByte(sb))));
end;

{-------------------------------------------------------------------------------}
{ TADSTable                                                                     }
{-------------------------------------------------------------------------------}
constructor TADSTable.Create(AConn: TADSConnection; AOwningObj: TObject);
begin
  inherited Create(AConn, 0, AOwningObj);
  FTableType := ttDefault;
  FCharType := ADS_ANSI;
  FLockType := ltProprietary;
  FCheckRights := ADS_IGNORERIGHTS;
  FOptions := ADS_DEFAULT;
  FMemoSize := ADS_DEFAULT;
end;

{-------------------------------------------------------------------------------}
procedure TADSTable.Open;
var
  usLockType: UNSIGNED16;
  usTableType: UNSIGNED16;
  sbTab, sbAlias: TFDByteString;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsOpenTable, ['hConnect', Connection.Handle, 'pucName', TableName,
      'pucAlias', Alias, 'usTableType', usTableType, 'usCharType', CharType,
      'usLockType', usLockType, 'usCheckRights', CheckRights, 'ulOptions', Options]);
  end;
{$ENDIF}

begin
  usLockType := ADSLockType2Int(LockType);
  usTableType := ADSTableType2Int(TableType);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  sbTab := Encoder.Encode(TableName);
  sbAlias := Encoder.Encode(Alias);
  FLib.Check(FLib.FAdsOpenTable(Connection.Handle, PAceChar(PByte(sbTab)),
    PAceChar(PByte(sbAlias)), usTableType, CharType, usLockType, CheckRights,
    Options, @Handle));
  UpdateFieldsNum;
end;

{-------------------------------------------------------------------------------}
procedure TADSTable.Open101;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsOpenTable101, ['hConnect', Connection.Handle, 'pucName', TableName]);
  end;
{$ENDIF}

var
  sbTab: TFDByteString;
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  sbTab := Encoder.Encode(TableName);
  FLib.Check(FLib.FAdsOpenTable101(Connection.Handle, PAceChar(PByte(sbTab)), @Handle));
  UpdateFieldsNum;
end;

{-------------------------------------------------------------------------------}
procedure TADSTable.CreateTable(const AFields: String; AMemoSize: UNSIGNED16);
var
  usLockType: UNSIGNED16;
  usTableType: UNSIGNED16;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsCreateTable, ['hConnect', Connection.Handle, 'pucName', TableName,
      'pucAlias', Alias, 'usTableType', usTableType, 'usCharType', CharType,
      'usLockType', usLockType, 'usCheckRights', CheckRights, 'usMemoSize', AMemoSize,
      'pucFields', AFields]);
  end;
{$ENDIF}

var
  sbTab, sbAlias, sbFields: TFDByteString;
begin
  usLockType := ADSLockType2Int(LockType);
  usTableType := ADSTableType2Int(TableType);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  sbTab := Encoder.Encode(TableName);
  sbAlias := Encoder.Encode(Alias);
  sbFields := Encoder.Encode(AFields);
  FLib.Check(FLib.FAdsCreateTable(Connection.Handle, PAceChar(PByte(sbTab)),
    PAceChar(PByte(sbAlias)), usTableType, CharType, usLockType, CheckRights,
    AMemoSize, PAceChar(PByte(sbFields)), @Handle));
  UpdateFieldsNum;
end;

{-------------------------------------------------------------------------------}
procedure TADSTable.Pack;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsPackTable, ['hTable', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsPackTable(Handle));
end;

{-------------------------------------------------------------------------------}
procedure TADSTable.Zap;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsZapTable, ['hTable', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsZapTable(Handle));
end;

{-------------------------------------------------------------------------------}
procedure TADSTable.CreateIndex(const AFileName, ATag, AKeyExpr, ACondition,
  AWhile: String; AOptions: UNSIGNED32);
var
  hIndex: ADSHANDLE;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsCreateIndex, ['hTable', Handle, 'pucFileName', AFileName,
      'pucTag', ATag, 'pucExpr', AKeyExpr, 'pucCondition', ACondition,
      'pucWhile', AWhile, 'ulOptions', AOptions]);
  end;
{$ENDIF}

var
  sbFileName, sbTag, sbKeyExpr, sbCondition, sbWhile: TFDByteString;
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  sbFileName := Encoder.Encode(AFileName);
  sbTag := Encoder.Encode(ATag);
  sbKeyExpr := Encoder.Encode(AKeyExpr);
  sbCondition := Encoder.Encode(AKeyExpr);
  sbWhile := Encoder.Encode(AWhile);
  Check(Lib.FAdsCreateIndex(Handle, PAceChar(PByte(sbFileName)),
    PAceChar(PByte(sbTag)), PAceChar(PByte(sbKeyExpr)),
    PAceChar(PByte(sbCondition)), PAceChar(PByte(sbWhile)), AOptions,
    @hIndex));
end;

{-------------------------------------------------------------------------------}
procedure TADSTable.Encrypt;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsEncryptTable, ['hTable', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsEncryptTable(Handle));
end;

{-------------------------------------------------------------------------------}
function TADSTable.GetIsEncrypted: Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsIsTableEncrypted, ['hTable', Handle]);
  end;
{$ENDIF}

var
  usIsEncrypted: UNSIGNED16;
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsIsTableEncrypted(Handle, @usIsEncrypted));
  Result := usIsEncrypted = ADS_TRUE;
end;

{-------------------------------------------------------------------------------}
procedure TADSTable.Decrypt;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsDecryptTable, ['hTable', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsDecryptTable(Handle));
end;

{-------------------------------------------------------------------------------}
procedure TADSTable.RecallAll;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsRecallAllRecords, ['hTable', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsRecallAllRecords(Handle));
end;

{-------------------------------------------------------------------------------}
procedure TADSTable.Reindex;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsReindex, ['hTable', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsReindex(Handle));
end;

{-------------------------------------------------------------------------------}
{ TADSDictionary                                                                }
{-------------------------------------------------------------------------------}
constructor TADSDictionary.Create(AConnection: TADSConnection);
var
  usLen: UNSIGNED16;
begin
  inherited CreateUsingHandle(AConnection.Handle);
  FConnection := AConnection;
  FOwningObj := AConnection.OwningObj;
  FLib := AConnection.Lib;
  usLen := SizeOf(usLen);
  FHasDictionary := (Lib.FAdsDDGetDatabaseProperty(Handle, ADS_DD_LOG_IN_REQUIRED,
    @usLen, @usLen) <> AE_INVALID_DICTIONARY_HANDLE);
end;

{-------------------------------------------------------------------------------}
function TADSDictionary.GetLongWord(AIndex: Integer): UNSIGNED32;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsDDGetDatabaseProperty, ['hObjects', Handle,
      'usPropertyID', AIndex, 'pvProperty', Result]);
  end;
{$ENDIF}

var
  usLen: UNSIGNED16;
  iRes: UNSIGNED32;
begin
  usLen := SizeOf(Result);
  iRes := Lib.FAdsDDGetDatabaseProperty(Handle, AIndex, @Result, @usLen);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
function TADSDictionary.GetString(AIndex: Integer): String;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsDDGetDatabaseProperty, ['hObjects', Handle,
      'usPropertyID', AIndex, 'pvProperty', Result]);
  end;
{$ENDIF}

var
  aBuf: array [0 .. ADS_DD_MAX_PROPERTY_LEN-1] of AceChar;
  usLen: UNSIGNED16;
  iRes: UNSIGNED32;
begin
  Result := '';
  usLen := SizeOf(aBuf);
  iRes := Lib.FAdsDDGetDatabaseProperty(Handle, AIndex, @aBuf[0], @usLen);
  if iRes = AE_SUCCESS then
    Result := Encoder.Decode(@aBuf[0], usLen - 1);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
function TADSDictionary.GetWord(AIndex: Integer): UNSIGNED16;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsDDGetDatabaseProperty, ['hObjects', Handle,
      'usPropertyID', AIndex, 'pvProperty', Result]);
  end;
{$ENDIF}

var
  usLen: UNSIGNED16;
  iRes: UNSIGNED32;
begin
  usLen := SizeOf(Result);
  iRes := Lib.FAdsDDGetDatabaseProperty(Handle, AIndex, @Result, @usLen);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(iRes);
end;

{-------------------------------------------------------------------------------}
procedure TADSDictionary.SetLongWord(AIndex: Integer; const AValue: UNSIGNED32);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsDDSetDatabaseProperty, ['hObjects', Handle,
      'usPropertyID', AIndex, 'pvProperty', AValue]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsDDSetDatabaseProperty(Handle, AIndex, @AValue, SizeOf(AValue)));
end;

{-------------------------------------------------------------------------------}
procedure TADSDictionary.SetString(AIndex: Integer; const AValue: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsDDSetDatabaseProperty, ['hObjects', Handle,
      'usPropertyID', AIndex, 'pvProperty', AValue]);
  end;
{$ENDIF}

var
  sb: TFDByteString;
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  sb := Encoder.Encode(AValue);
  Check(Lib.FAdsDDSetDatabaseProperty(Handle, AIndex, PAceChar(PByte(sb)), Length(sb)));
end;

{-------------------------------------------------------------------------------}
procedure TADSDictionary.SetWord(AIndex: Integer; const AValue: UNSIGNED16);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(sAdsDDSetDatabaseProperty, ['hObjects', Handle,
      'usPropertyID', AIndex, 'pvProperty', AValue]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.FAdsDDSetDatabaseProperty(Handle, AIndex, @AValue, SizeOf(AValue)));
end;

{-------------------------------------------------------------------------------}
function ADSNativeExceptionLoad(const AStorage: IFDStanStorage): TObject;
begin
  Result := EADSNativeException.Create;
  EADSNativeException(Result).LoadFromStorage(AStorage);
end;

{-------------------------------------------------------------------------------}
initialization
  FDStorageManager().RegisterClass(EADSNativeException, 'ADSNativeException',
    @ADSNativeExceptionLoad, @FDExceptionSave);

end.
