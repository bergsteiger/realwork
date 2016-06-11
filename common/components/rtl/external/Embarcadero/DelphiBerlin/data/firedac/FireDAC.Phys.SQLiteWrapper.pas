{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{          FireDAC SQLite API wrapping classes          }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.SQLiteWrapper;

interface

uses
  System.SysUtils, System.Classes, System.SyncObjs, System.Generics.Collections,
    Data.FmtBCD,
  FireDAC.Stan.Util, FireDAC.Stan.Intf, FireDAC.Stan.Error, FireDAC.Stan.Expr,
    FireDAC.Stan.Consts,
  FireDAC.Phys.SQLiteCli, FireDAC.Phys.SQLiteMeta;

type
  ESQLiteNativeException = class;
  TSQLiteLib = class;
  TSQLiteHandle = class;
  TSQLiteDatabase = class;
  TSQLiteExtension = class;
  TSQLiteExtensionClass = class of TSQLiteExtension;
  TSQLiteExtensionManager = class;
  TSQLiteCollation = class;
  TSQLiteCollationCompareString = class;
  TSQLiteBLOB = class;
  TSQLiteValueDef = class;
  TSQLiteValue = class;
  TSQLiteStmtVar = class;
  TSQLiteBind = class;
  TSQLiteColumn = class;
  TSQLiteVariables = class;
  TSQLiteStatement = class;
  TSQLiteFuncVar = class;
  TSQLiteInput = class;
  TSQLiteInputs = class;
  TSQLiteOutput = class;
  TSQLiteFunction = class;
  TSQLiteFunctionInstance = class;
  TSQLiteExpressionFunction = class;
  TSQLiteExpressionFunctionInstance = class;
  TSQLiteRTree = class;
  TSQLiteRTreeInstance = class;
  TSQLiteRTreeData = class;
  TSQLiteBackup = class;
  TSQLiteVObject = class;
  TSQLiteVTable = class;
  TSQLiteVModule = class;
  TSQLiteVCursor = class;
  TSQLiteVModuleClass = class of TSQLiteVModule;

  TSQLiteDatabaseMode = (smCreate, smReadWrite, smReadOnly);
  TSQLiteSharedCache = (scDefault, scPrivate, scShared);
  TSQLiteDatabaseAuthorizeEvent = procedure (ADB: TSQLiteDatabase;
    ACode: Integer; const AArg1, AArg2, AArg3, AArg4: String; var AResult: Integer) of object;
  TSQLiteDatabaseUpdateEvent = procedure (ADB: TSQLiteDatabase; AOper: Integer;
    const ADatabase, ATable: String; ARowid: sqlite3_int64) of object;
  TSQLiteDatabaseProgressEvent = procedure (ADB: TSQLiteDatabase; var ACancel: Boolean) of object;
  TSQLiteDatabaseWalEvent = procedure (ADB: TSQLiteDatabase; AName: String; AnPages: Integer) of object;

  TSQLiteExtDataType = (etUnknown, etString, etUString, etInteger, etDouble,
    etNumber, etCurrency, etBlob, etBoolean, etDate, etTime, etDateTime);
  TSQLiteStatementState = (ssInactive, ssPrepared, ssRewinded, ssExecuted,
    ssFirstFetch, ssNextFetch, ssEOF);

  TSQLiteFunctionCalculateEvent = procedure (AFunc: TSQLiteFunctionInstance;
    AInputs: TSQLiteInputs; AOutput: TSQLiteOutput;
    var AUserData: TObject) of object;
  TSQLiteFunctionFinalizeEvent = procedure (AFunc: TSQLiteFunctionInstance;
    var AUserData: TObject) of object;

  TSQLiteRTreeDoubleArray = array of sqlite3_rtree_dbl;
  TSQLiteRTreeCalculateEvent = procedure (ARTree: TSQLiteRTreeData;
    const AParams, AColumns: TSQLiteRTreeDoubleArray; var AResult: Boolean) of object;
  TSQLiteRTreeFinalizeEvent = procedure (ARTree: TSQLiteRTreeData;
    var AUserData: TObject) of object;

  ESQLiteNativeException = class(EFDDBEngineException)
  public
    constructor Create(ACode: Integer; AOwner: TSQLiteHandle;
      AMsg: String = ''); overload;
  end;

  TSQLiteLib = class(TFDLibrary)
  private
    FDatabases: TFDObjList;
    FExtensions: TFDObjList;
    FLock: TCriticalSection;
    FLastDatabase: TSQLiteDatabase;
    FLastDBHandle: psqlite3;
{$IFNDEF FireDAC_SQLITE_STATIC}
    function GetSQLiteProcAddress(const AProcName: String; A16: Boolean = False;
      AVer: Integer = 0; ARequired: Boolean = True): Pointer;
{$ENDIF}
    procedure Check(ACode: Integer);
    procedure InstallExtensions(ADatabase: TSQLiteDatabase);
    procedure InstallDatabases(AExtension: TSQLiteExtension);
    procedure DeinstallExtensions(ADatabase: TSQLiteDatabase);
    procedure DeinstallDatabases(AExtension: TSQLiteExtension);
    procedure InstallModules(ADatabase: TSQLiteDatabase);
    procedure DeinstallModules(ADatabase: TSQLiteDatabase);
    procedure AddDatabase(ADatabase: TSQLiteDatabase);
    procedure RemoveDatabase(ADatabase: TSQLiteDatabase);
    function dbH2dbObj(db: psqlite3): TSQLiteDatabase;
  protected
    procedure LoadEntries; override;
    procedure GetLibraryInfo; override;
  public
    FBrand: TFDPhysSQLiteBrand;

    Fsqlite3_libversion: Tsqlite3_libversion;
    Fsqlite3_libversion_number: Tsqlite3_libversion_number;
    Fsqlite3_compileoption_used: Tsqlite3_compileoption_used;
    Fsqlite3_compileoption_get: Tsqlite3_compileoption_get;
    Fsqlite3_initialize: Tsqlite3_initialize;
    Fsqlite3_shutdown: Tsqlite3_shutdown;
    Fsqlite3_config: Tsqlite3_config;
    Fsqlite3_close: Tsqlite3_close;
    Fsqlite3_errcode: Tsqlite3_errcode;
    Fsqlite3_errmsg: Tsqlite3_errmsg;
    Fsqlite3_extended_result_codes: Tsqlite3_extended_result_codes;
    Fsqlite3_open: Tsqlite3_open;
    Fsqlite3_open_v2: Tsqlite3_open_v2;
    Fsqlite3_key: Tsqlite3_key;
    Fsqlite3_rekey: Tsqlite3_key;
    Fsqlite3_trace: Tsqlite3_trace;
    Fsqlite3_profile: Tsqlite3_profile;
    Fsqlite3_busy_timeout: Tsqlite3_busy_timeout;
    Fsqlite3_get_autocommit: Tsqlite3_get_autocommit;
    Fsqlite3_set_authorizer: Tsqlite3_set_authorizer;
    Fsqlite3_update_hook: Tsqlite3_update_hook;
    Fsqlite3_limit: Tsqlite3_limit;
    Fsqlite3_changes: Tsqlite3_changes;
    Fsqlite3_total_changes: Tsqlite3_total_changes;
    Fsqlite3_interrupt: Tsqlite3_interrupt;
    Fsqlite3_last_insert_rowid: Tsqlite3_last_insert_rowid;
    Fsqlite3_db_status: Tsqlite3_db_status;
    Fsqlite3_exec: Tsqlite3_exec;
    Fsqlite3_enable_shared_cache: Tsqlite3_enable_shared_cache;
    Fsqlite3_release_memory: Tsqlite3_release_memory;
    Fsqlite3_soft_heap_limit: Tsqlite3_soft_heap_limit;
    Fsqlite3_status: Tsqlite3_status;
    Fsqlite3_malloc: Tsqlite3_malloc;
    Fsqlite3_memory_used: Tsqlite3_memory_used;
    Fsqlite3_memory_highwater: Tsqlite3_memory_highwater;
    Fsqlite3_prepare: Tsqlite3_prepare;
    Fsqlite3_finalize: Tsqlite3_finalize;
    Fsqlite3_step: Tsqlite3_step;
    Fsqlite3_reset: Tsqlite3_reset;
    Fsqlite3_stmt_status: Tsqlite3_stmt_status;
    Fsqlite3_column_count: Tsqlite3_column_count;
    Fsqlite3_column_type: Tsqlite3_column_type;
    Fsqlite3_column_name: Tsqlite3_column_name;
    Fsqlite3_column_database_name: Tsqlite3_column_database_name;
    Fsqlite3_column_table_name: Tsqlite3_column_table_name;
    Fsqlite3_column_origin_name: Tsqlite3_column_origin_name;
    Fsqlite3_column_decltype: Tsqlite3_column_decltype;
    Fsqlite3_column_blob: Tsqlite3_column_blob;
    Fsqlite3_column_double: Tsqlite3_column_double;
    Fsqlite3_column_int64: Tsqlite3_column_int64;
    Fsqlite3_column_text: Tsqlite3_column_text;
    Fsqlite3_column_bytes_row: Tsqlite3_column_bytes;
    Fsqlite3_column_bytes: Tsqlite3_column_bytes;
    Fsqlite3_clear_bindings: Tsqlite3_clear_bindings;
    Fsqlite3_bind_parameter_count: Tsqlite3_bind_parameter_count;
    Fsqlite3_bind_parameter_index: Tsqlite3_bind_parameter_index;
    Fsqlite3_bind_parameter_name: Tsqlite3_bind_parameter_name;
    Fsqlite3_bind_blob: Tsqlite3_bind_blob;
    Fsqlite3_bind_blob64: Tsqlite3_bind_blob64;
    Fsqlite3_bind_double: Tsqlite3_bind_double;
    Fsqlite3_bind_int64: Tsqlite3_bind_int64;
    Fsqlite3_bind_null: Tsqlite3_bind_null;
    Fsqlite3_bind_text: Tsqlite3_bind_text;
    Fsqlite3_bind_text64: Tsqlite3_bind_text64;
    Fsqlite3_bind_value: Tsqlite3_bind_value;
    Fsqlite3_bind_zeroblob: Tsqlite3_bind_zeroblob;
    Fsqlite3_value_type: Tsqlite3_value_type;
    Fsqlite3_value_blob: Tsqlite3_value_blob;
    Fsqlite3_value_bytes: Tsqlite3_value_bytes;
    Fsqlite3_value_double: Tsqlite3_value_double;
    Fsqlite3_value_int64: Tsqlite3_value_int64;
    Fsqlite3_value_text: Tsqlite3_value_text;
    Fsqlite3_result_blob: Tsqlite3_result_blob;
    Fsqlite3_result_blob64: Tsqlite3_result_blob64;
    Fsqlite3_result_double: Tsqlite3_result_double;
    Fsqlite3_result_error: Tsqlite3_result_error;
    Fsqlite3_result_error_code: Tsqlite3_result_error_code;
    Fsqlite3_result_int64: Tsqlite3_result_int64;
    Fsqlite3_result_null: Tsqlite3_result_null;
    Fsqlite3_result_text: Tsqlite3_result_text;
    Fsqlite3_result_text64: Tsqlite3_result_text64;
    Fsqlite3_result_zeroblob: Tsqlite3_result_zeroblob;
    Fsqlite3_create_collation: Tsqlite3_create_collation;
    Fsqlite3_create_function: Tsqlite3_create_function;
    Fsqlite3_user_data: Tsqlite3_user_data;
    Fsqlite3_enable_load_extension: Tsqlite3_enable_load_extension;
    Fsqlite3_load_extension: Tsqlite3_load_extension;
    Fsqlite3_free: Tsqlite3_free;
    Fsqlite3_table_column_metadata: Tsqlite3_table_column_metadata;
    Fsqlite3_progress_handler: Tsqlite3_progress_handler;
    Fsqlite3_declare_vtab: Tsqlite3_declare_vtab;
    Fsqlite3_create_module: Tsqlite3_create_module;
    Fsqlite3_create_module_v2: Tsqlite3_create_module_v2;
    Fsqlite3_vfs_find: Tsqlite3_vfs_find;
    Fsqlite3_vfs_register: Tsqlite3_vfs_register;
    Fsqlite3_vfs_unregister: Tsqlite3_vfs_unregister;
    Fsqlite3_backup_init: Tsqlite3_backup_init;
    Fsqlite3_backup_step: Tsqlite3_backup_step;
    Fsqlite3_backup_finish: Tsqlite3_backup_finish;
    Fsqlite3_backup_remaining: Tsqlite3_backup_remaining;
    Fsqlite3_backup_pagecount: Tsqlite3_backup_pagecount;
    Fsqlite3_wal_hook: Tsqlite3_wal_hook;
    Fsqlite3_wal_autocheckpoint: Tsqlite3_wal_autocheckpoint;
    Fsqlite3_wal_checkpoint: Tsqlite3_wal_checkpoint;
    Fsqlite3_rtree_geometry_callback: Tsqlite3_rtree_geometry_callback;
    Fsqlite3_rtree_query_callback: Tsqlite3_rtree_query_callback;
    Fsqlite3_blob_open: Tsqlite3_blob_open;
    Fsqlite3_blob_close: Tsqlite3_blob_close;
    Fsqlite3_blob_bytes: Tsqlite3_blob_bytes;
    Fsqlite3_blob_read: Tsqlite3_blob_read;
    Fsqlite3_blob_write: Tsqlite3_blob_write;
    Fsqlite3_vtab_config: Tsqlite3_vtab_config;
    Fsqlite3_vtab_on_conflict: Tsqlite3_vtab_on_conflict;
    constructor Create(AOwningObj: TObject = nil);
    destructor Destroy; override;
    procedure Load(const AVendorHome, AVendorLib: String);
    procedure Unload; override;
    procedure ReleaseMemory(AAmount: Integer);
    procedure SoftHeapLimit(AAmount: Integer);
                                            
(*
    property MemoryUsed: sqlite3_int64 read GetMemoryUsed;
    property MemoryHighwater: sqlite3_int64 read GetMemoryHighwater;
MEMORY_USED
PAGECACHE_USED
PAGECACHE_OVERFLOW
SCRATCH_USED
SCRATCH_OVERFLOW
MALLOC_SIZE
PARSER_STACK
PAGECACHE_SIZE
SCRATCH_SIZE
*)
    property Brand: TFDPhysSQLiteBrand read FBrand;
  end;

  TSQLiteHandle = class(TObject)
  private
    FLib: TSQLiteLib;
    FHandle: psqlite3;
    FOwnHandle: Boolean;
    [Weak] FOwningObj: TObject;
    [Weak] FDatabase: TSQLiteDatabase;
{$IFDEF FireDAC_MONITOR}
    function GetTracing: Boolean; inline;
{$ENDIF}
  public
    constructor Create;
    constructor CreateUsingHandle(AHandle: psqlite3);
    procedure Check(ACode: Integer);
{$IFDEF FireDAC_MONITOR}
    procedure Trace(const AMsg: String; const AArgs: array of const); overload;
    procedure Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
      const AMsg: String; const AArgs: array of const); overload;
    property Tracing: Boolean read GetTracing;
{$ENDIF}
    property Handle: psqlite3 read FHandle;
    property Lib: TSQLiteLib read FLib;
    property Database: TSQLiteDatabase read FDatabase;
    property OwningObj: TObject read FOwningObj;
  end;

  TSQLiteDatabase = class(TSQLiteHandle)
  private
    FBuffer: TFDBuffer;
    FEncoder: TFDEncoder;
    FBusyTimeout: Integer;
    FExtensionInstances: TFDObjList;
    FExtensions: TStrings;
    FVModules: TFDObjList;
    FDateTimeFormat: TSQLiteExtDataType;
    FProgressNOpers: Integer;
    FOnAuthorize: TSQLiteDatabaseAuthorizeEvent;
    FOnUpdate: TSQLiteDatabaseUpdateEvent;
    FOnProgress: TSQLiteDatabaseProgressEvent;
    FOnWal: TSQLiteDatabaseWalEvent;
    FAutoCheckpoint: Integer;
    [Weak] FCurStatement: TSQLiteStatement;
    FVTabs: TFDStringList;
    FSQLHandlerList: TInterfaceList;
    FLastAutoGenValue: Int64;
{$IFDEF FireDAC_MONITOR}
    FTracing: Boolean;
    FMonitor: IFDMoniClient;
    procedure SetTracing(AValue: Boolean);
    procedure UpdateTracing;
{$ENDIF}
    procedure SetBusyTimeout(const AValue: Integer);
    procedure InstallExternalExtensions;
    procedure SetExtensions(const AValue: TStrings);
    function GetInTransaction: Boolean;
    function DoAuthorize(code: Integer; zArg1, zArg2, zArg3, zArg4: PUtf8): Integer;
    procedure SetOnAuthorize(const AValue: TSQLiteDatabaseAuthorizeEvent);
    procedure DoUpdate(oper: Integer; zDb, zTable: PUtf8; rowid: sqlite3_int64);
    procedure SetOnUpdate(const AValue: TSQLiteDatabaseUpdateEvent);
    function GetTotalChanges: Integer;
    function GetLastInsertRowid: sqlite3_int64;
    function GetLastAutoGenValue: Int64;
    procedure SetOnProgress(const AValue: TSQLiteDatabaseProgressEvent);
    function DoProgress: Integer;
    procedure SetProgressNOpers(const AValue: Integer);
    function GetCacheSize: Integer;
    function GetCharacterSet: String;
    function GetEncryption: String;
    procedure SetOnWal(const AValue: TSQLiteDatabaseWalEvent);
    function DoWal(name: PByte; nPages: Integer): Integer;
    procedure SetAutoCheckpoint(const AValue: Integer);
    function GetLimits(AId: Integer): Integer;
    procedure SetLimits(AId: Integer; const AValue: Integer);
    function IsVTab(const ATabName, AColName: String; out ANotNull, AInPK,
      AAutoInc: Boolean): Boolean;
    function DoGetTable(const AObjName: String): Boolean;
    procedure msg2putf8(const AMsg: String; var ApMsg: Pointer);
    procedure Init(ALib: TSQLiteLib; AOwningObj: TObject
      {$IFDEF FireDAC_Monitor}; const AMonitor: IFDMoniClient = nil {$ENDIF});
  public
    constructor Create(ALib: TSQLiteLib; AOwningObj: TObject = nil
      {$IFDEF FireDAC_Monitor}; const AMonitor: IFDMoniClient = nil {$ENDIF});
    constructor CreateUsingHandle(ALib: TSQLiteLib; Asqlite3: psqlite3;
      AOwningObj: TObject = nil {$IFDEF FireDAC_Monitor}; const AMonitor: IFDMoniClient = nil {$ENDIF});
    destructor Destroy; override;
    function APIStrToDlpStr(AStr: PByte): String;
    procedure Open(const AFilename: String; AMode: TSQLiteDatabaseMode;
      ASharedCache: TSQLiteSharedCache);
    procedure Key(const AKey: String);
    procedure ReKey(const AKey: String);
    procedure Close;
    procedure Interrupt;
    procedure EnableExtensions(AValue: Boolean);
    procedure LoadExtension(const AExtension, AEntry: String);
    function DescribeColumn(const ADBName, ATabName, AColName: String;
      out AType, ACollation: String; out ANotNull, AInPK, AAutoInc: Boolean;
      ARaiseError: Boolean = True): Boolean;
    procedure Checkpoint(const ADb: String);
    class procedure ParseObjName(const AObjName: String; var ASchema, AName: String);
    procedure SetLastAutoGenValue(const AValue: Int64);
{$IFDEF FireDAC_MONITOR}
    property Monitor: IFDMoniClient read FMonitor write FMonitor;
    property Tracing: Boolean read FTracing write SetTracing;
{$ENDIF}
    property Buffer: TFDBuffer read FBuffer;
    property Encoder: TFDEncoder read FEncoder;
    property InTransaction: Boolean read GetInTransaction;
    property TotalChanges: Integer read GetTotalChanges;
    property CharacterSet: String read GetCharacterSet;
    property CacheSize: Integer read GetCacheSize;
    property Encryption: String read GetEncryption;
    property SQLHandlerList: TInterfaceList read FSQLHandlerList;
    property CurStatement: TSQLiteStatement read FCurStatement;
    property LastInsertRowid: sqlite3_int64 read GetLastInsertRowid;
    property LastAutoGenValue: Int64 read GetLastAutoGenValue;
    property BusyTimeout: Integer read FBusyTimeout write SetBusyTimeout;
    property Extensions: TStrings read FExtensions write SetExtensions;
    property DateTimeFormat: TSQLiteExtDataType read FDateTimeFormat write FDateTimeFormat;
    property ProgressNOpers: Integer read FProgressNOpers write SetProgressNOpers;
    property AutoCheckpoint: Integer read FAutoCheckpoint write SetAutoCheckpoint;
    property Limits[AId: Integer]: Integer read GetLimits write SetLimits;
    property OnAutorize: TSQLiteDatabaseAuthorizeEvent read FOnAuthorize write SetOnAuthorize;
    property OnUpdate: TSQLiteDatabaseUpdateEvent read FOnUpdate write SetOnUpdate;
    property OnProgress: TSQLiteDatabaseProgressEvent read FOnProgress write SetOnProgress;
    property OnWal: TSQLiteDatabaseWalEvent read FOnWal write SetOnWal;
  end;

  TSQLiteExtension = class(TObject)
  private
    FLib: TSQLiteLib;
    FName: String;
  protected
    class procedure Register(ALib: TSQLiteLib); virtual;
    procedure InternalInstall(ADatabase: TSQLiteDatabase); virtual; abstract;
    procedure InternalDeinstall(ADatabase: TSQLiteDatabase); virtual;
  public
    constructor Create(ALib: TSQLiteLib); virtual;
    destructor Destroy; override;
    procedure InstallAll;
    procedure DeinstallAll;
    property Name: String read FName write FName;
    property Lib: TSQLiteLib read FLib;
  end;

  TSQLiteExtensionInstance = class(TObject)
  private
    [Weak] FDatabase: TSQLiteDatabase;
    [Weak] FExtension: TSQLiteExtension;
  public
    constructor Create(ADB: TSQLiteDatabase; AExt: TSQLiteExtension);
    destructor Destroy; override;
    property Database: TSQLiteDatabase read FDatabase;
    property Extension: TSQLiteExtension read FExtension;
  end;

  TSQLiteExtensionManager = class(TObject)
  private
    FModules: TFDStringList;
    FExtensions: TFDClassList;
    procedure RegisterAll(ALib: TSQLiteLib);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddModule(const AName: String; AClass: TSQLiteVModuleClass);
    procedure AddExtension(const AClasses: array of TSQLiteExtensionClass);
  end;

  TSQLiteCollationEvent = procedure (ASender: TObject; len1: Integer;
    str1: Pointer {utf8/utf16}; len2: Integer; str2: Pointer {utf8/utf16};
    var AResult: Integer) of object;
  TSQLiteCollation = class(TSQLiteExtension)
  private
    FEncoding: Integer;
    FOnCompare: TSQLiteCollationEvent;
    [Weak] FOwningObj: TObject;
  protected
    function Compare(len1: Integer; str1: Pointer {utf8/utf16};
      len2: Integer; str2: Pointer {utf8/utf16}): Integer; virtual;
    procedure InternalInstall(ADatabase: TSQLiteDatabase); override;
    procedure InternalDeinstall(ADatabase: TSQLiteDatabase); override;
  public
    property Encoding: Integer read FEncoding write FEncoding;
    property OnCompare: TSQLiteCollationEvent read FOnCompare write FOnCompare;
    property OwningObj: TObject read FOwningObj write FOwningObj;
  end;

  TSQLiteCollationCompareString = class(TSQLiteCollation)
  private
    FLocaleID: TLocaleID;
    FFlags: LongWord;
    function GetLocaleID: TLocaleID;
    procedure SetLocaleID(const AValue: TLocaleID);
  protected
    function Compare(len1: Integer; str1: Pointer {utf8/utf16};
      len2: Integer; str2: Pointer {utf8/utf16}): Integer; override;
  public
    constructor Create(ALib: TSQLiteLib); override;
    property LocaleID: TLocaleID read GetLocaleID write SetLocaleID;
    property Flags: LongWord read FFlags write FFlags;
  end;

  TSQLiteBLOB = class(TSQLiteHandle)
  private
    FPosition: Integer;
    function GetSize: Integer;
  public
    constructor Create(ADB: TSQLiteDatabase; const ADBAlias, ATable, AColumn: String;
      ARowID: sqlite3_int64; AReadWrite: Boolean); overload;
    destructor Destroy; override;
    procedure Write(const AData; ASize: Integer);
    procedure Read(var AData; ASize: Integer);
    property Position: Integer read FPosition write FPosition;
    property Size: Integer read GetSize;
  end;

  TSQLiteValueDef = class(TObject)
  private
    [Weak] FStmt: TSQLiteStatement;
    FIndex: Integer;
    FName: String;
    FTabName: String;
    FColName: String;
    FDBName: String;
    FTypeName: String;
    FIntDataType: Integer;
    FCollationName: String;
    FNotNull: Boolean;
    FInPrimaryKey: Boolean;
    FAutoInc: Boolean;
  public
    constructor CreateForColumn(AStmt: TSQLiteStatement; AIndex: Integer);
    constructor CreateForParam(AStmt: TSQLiteStatement; AIndex: Integer; ADummy: Integer);
    property Index: Integer read FIndex;
    property Name: String read FName;
    property DBName: String read FDBName;
    property TabName: String read FTabName;
    property ColName: String read FColName;
    property TypeName: String read FTypeName;
    property CollationName: String read FCollationName;
    property NotNull: Boolean read FNotNull;
    property InPrimaryKey: Boolean read FInPrimaryKey;
    property AutoInc: Boolean read FAutoInc;
    property IntDataType: Integer read FIntDataType;
  end;

  TSQLiteValue = class(TObject)
  private
    [Weak] FDatabase: TSQLiteDatabase;
    FExtDataType: TSQLiteExtDataType;
    function GetAnsiString: TFDAnsiString;
    function GetBoolean: WordBool;
    function GetCurrency: Currency;
    function GetDate: TDateTime;
    function GetDateTime: TDateTime;
    function GetFloat: Double;
    function GetInteger: Int64;
    function GetNumber: TBcd;
    function GetTime: TDateTime;
    function GetWideString: UnicodeString;
    function GetAsString: String;
    procedure SetAnsiString(const AValue: TFDAnsiString);
    procedure SetBoolean(const AValue: WordBool);
    procedure SetCurrency(const AValue: Currency);
    procedure SetDate(const AValue: TDateTime);
    procedure SetDateTime(const AValue: TDateTime);
    procedure SetFloat(const AValue: Double);
    procedure SetInteger(const AValue: Int64);
    procedure SetNumber(const AValue: TBcd);
    procedure SetTime(const AValue: TDateTime);
    procedure SetWideString(const AValue: UnicodeString);
    procedure SetAsString(const AValue: String);
    function GetIsNull: Boolean;
  protected
    function InternalGetData(var AValue: Pointer; var ASize: Integer;
      var AIntDataType: Integer): Boolean; virtual;
    procedure InternalSetData(AValue: Pointer; ASize: Integer;
      AIntDataType: Integer); virtual;
  public
    constructor Create(ADatabase: TSQLiteDatabase);
    function GetData(var AValue: Pointer; var ASize: Integer;
      AByRef: Boolean = False; AExtDataType: TSQLiteExtDataType = etUnknown): Boolean;
    procedure SetData(AValue: Pointer; ASize: Integer;
      AExtDataType: TSQLiteExtDataType = etUnknown);
    procedure Clear;
    property Database: TSQLiteDatabase read FDatabase;
    property ExtDataType: TSQLiteExtDataType read FExtDataType write FExtDataType;
    property AsString: String read GetAsString write SetAsString;
    property AsAnsiString: TFDAnsiString read GetAnsiString write SetAnsiString;
    property AsWideString: UnicodeString read GetWideString write SetWideString;
    property AsInteger: Int64 read GetInteger write SetInteger;
    property AsFloat: Double read GetFloat write SetFloat;
    property AsCurrency: Currency read GetCurrency write SetCurrency;
    property AsNumber: TBcd read GetNumber write SetNumber;
    property AsBoolean: WordBool read GetBoolean write SetBoolean;
    property AsDate: TDateTime read GetDate write SetDate;
    property AsTime: TDateTime read GetTime write SetTime;
    property AsDateTime: TDateTime read GetDateTime write SetDateTime;
    property IsNull: Boolean read GetIsNull;
  end;

  TSQLiteStmtVar = class(TSQLiteValue)
  private
    [Weak] FStmt: TSQLiteStatement;
    FIndex: Integer;
  public
    constructor Create(AVars: TSQLiteVariables);
    property Stmt: TSQLiteStatement read FStmt;
    property Index: Integer read FIndex write FIndex;
  end;

  TSQLiteBind = class(TSQLiteStmtVar)
  protected
    procedure InternalSetData(AValue: Pointer; ASize: Integer;
      AIntDataType: Integer); override;
  end;

  TSQLiteColumn = class(TSQLiteStmtVar)
  protected
    function InternalGetData(var AValue: Pointer; var ASize: Integer;
      var AIntDataType: Integer): Boolean; override;
  end;

  TSQLiteVariables = class(TObject)
  private
    [Weak] FStmt: TSQLiteStatement;
    FList: TFDObjList;
    function GetItems(AIndex: Integer): TSQLiteStmtVar; inline;
    function GetCount: Integer; inline;
  public
    constructor Create(AStmt: TSQLiteStatement);
    destructor Destroy; override;
    procedure Clear(ASize: Integer = 0);
    procedure Add(AVar: TSQLiteStmtVar);
    property Count: Integer read GetCount;
    property Items[AIndex: Integer]: TSQLiteStmtVar read GetItems; default;
  end;

  TSQLiteStatement = class(TSQLiteHandle)
  private
    FCmdText: TFDByteString;
    FCmdCurr: PByte;
    FCmdTailLen: Integer;
    FCmdTail: PByte;
    FLastStepError: Integer;
    FState: TSQLiteStatementState;
    FParams: TSQLiteVariables;
    FColumns: TSQLiteVariables;
    FBaseParamIndex: Integer;
    FParamDefsCount: Integer;
    FColumnDefsCount: Integer;
    FUseColumnMetadata: Boolean;
    FStrsTrim: Boolean;
    FStrsEmpty2Null: Boolean;
    FMaxStringSize: Integer;
    procedure PrepareBase;
    procedure Prepare; overload;
    procedure ExecuteBase;
    function GetColumnDefs(AIndex: Integer): TSQLiteValueDef;
    function GetChanges: Integer;
    function GetParamDefs(AIndex: Integer): TSQLiteValueDef;
    function GetIsDrop: Boolean;
  public
    constructor Create(ADB: TSQLiteDatabase; AOwningObj: TObject = nil);
    destructor Destroy; override;
    procedure Prepare(const ACmd: String); overload;
    procedure Unprepare;
    procedure Execute; inline;
    procedure Reset;
    procedure Rewind;
    procedure Clear;
    function Fetch: Boolean;
    function FirstCommand: Boolean; inline;
    function MoreCommands: Boolean; inline;
    function PrepareNextCommand: Boolean;
    // R/O
    property State: TSQLiteStatementState read FState;
    property Changes: Integer read GetChanges;
    property ColumnDefsCount: Integer read FColumnDefsCount;
    property ColumnDefs[AIndex: Integer]: TSQLiteValueDef read GetColumnDefs;
    property ParamDefsCount: Integer read FParamDefsCount;
    property ParamDefs[AIndex: Integer]: TSQLiteValueDef read GetParamDefs;
    property Columns: TSQLiteVariables read FColumns;
    property Params: TSQLiteVariables read FParams;
    property BaseParamIndex: Integer read FBaseParamIndex;
    property IsDrop: Boolean read GetIsDrop;
    // R/W
    property UseColumnMetadata: Boolean read FUseColumnMetadata write FUseColumnMetadata default True;
    property StrsTrim: Boolean read FStrsTrim write FStrsTrim default True;
    property StrsEmpty2Null: Boolean read FStrsEmpty2Null write FStrsEmpty2Null default True;
    property MaxStringSize: Integer read FMaxStringSize write FMaxStringSize default C_FD_DefMaxStrSize;
  end;

  TSQLiteFuncVar = class(TSQLiteValue)
  end;

  TSQLiteInput = class(TSQLiteFuncVar)
  private
    FHandle: psqlite3_value;
    FIntDataType: Integer;
    procedure SetHandle(const AValue: psqlite3_value);
  protected
    function InternalGetData(var AValue: Pointer; var ASize: Integer;
      var AIntDataType: Integer): Boolean; override;
  public
    property Handle: psqlite3_value read FHandle write SetHandle;
    property IntDataType: Integer read FIntDataType;
  end;

  TSQLiteInputs = class(TObject)
  private
    FList: TFDObjList;
    function GetItems(AIndex: Integer): TSQLiteInput; inline;
    function GetCount: Integer; inline;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: Integer read GetCount;
    property Inputs[AIndex: Integer]: TSQLiteInput read GetItems; default;
  end;

  TSQLiteOutput = class(TSQLiteFuncVar)
  private
    FHandle: psqlite3_context;
    FErrorText: String;
    FErrorCode: Integer;
    procedure SetErrorCode(const AValue: Integer);
    procedure SetErrorText(const AValue: String);
  protected
    procedure InternalSetData(AValue: Pointer; ASize: Integer;
      AIntDataType: Integer); override;
    function InternalGetData(var AValue: Pointer; var ASize: Integer;
      var AIntDataType: Integer): Boolean; override;
  public
    property Handle: psqlite3_context read FHandle write FHandle;
    property ErrorCode: Integer read FErrorCode write SetErrorCode;
    property ErrorText: String read FErrorText write SetErrorText;
  end;

  TSQLiteFunction = class(TSQLiteExtension)
  private
    FArgs: Integer;
    FAggregate: Boolean;
    FDeterministic: Boolean;
    FOnCalculate: TSQLiteFunctionCalculateEvent;
    FOnFinalize: TSQLiteFunctionFinalizeEvent;
  protected
    procedure InternalInstall(ADatabase: TSQLiteDatabase); override;
    procedure DoCalculate(AData: TSQLiteFunctionInstance); virtual;
    procedure DoFinalize(AData: TSQLiteFunctionInstance); virtual;
  public
    property Args: Integer read FArgs write FArgs;
    property Aggregate: Boolean read FAggregate write FAggregate;
    property Deterministic: Boolean read FDeterministic write FDeterministic;
    property OnCalculate: TSQLiteFunctionCalculateEvent read FOnCalculate write FOnCalculate;
    property OnFinalize: TSQLiteFunctionFinalizeEvent read FOnFinalize write FOnFinalize;
  end;

  TSQLiteFunctionInstance = class(TSQLiteExtensionInstance)
  private
    FInputs: TSQLiteInputs;
    FOutput: TSQLiteOutput;
    FUserData: TObject;
    function GetFunc: TSQLiteFunction; inline;
  protected
    procedure DoCalculate(context: psqlite3_context; nargs: Integer;
      args: ppsqlite3_value);
    procedure DoFinalize(context: psqlite3_context);
  public
    constructor Create(ADB: TSQLiteDatabase; AFunc: TSQLiteFunction); virtual;
    destructor Destroy; override;
    property Func: TSQLiteFunction read GetFunc;
    property Inputs: TSQLiteInputs read FInputs;
    property Output: TSQLiteOutput read FOutput;
    property UserData: TObject read FUserData write FUserData;
  end;

  TSQLiteExpressionFunction = class(TSQLiteFunction)
  private
    FDesc: TFDExpressionFunctionDesc;
  protected
    class procedure Register(ALib: TSQLiteLib); override;
    procedure InternalInstall(ADatabase: TSQLiteDatabase); override;
    procedure DoCalculate(AData: TSQLiteFunctionInstance); override;
  public
    constructor CreateExpr(ALib: TSQLiteLib;
      ADesc: TFDExpressionFunctionDesc; AArgs: Integer);
    property Desc: TFDExpressionFunctionDesc read FDesc;
  end;

  TSQLiteExpressionFunctionInstance = class(TSQLiteFunctionInstance)
  private
    FFuncArgs: array of Variant;
    procedure InternalCalculate;
  public
    constructor Create(ADatabase: TSQLiteDatabase; AFunc: TSQLiteFunction); override;
  end;

  /// <summary> TFDPhysSQLiteLastAutoGenFunc class implements LAST_INSERT_AUTOGEN
  ///  SQLite custom function. LAST_INSERT_AUTOGEN is similar to build-in
  ///  LAST_INSERT_AUTOINC function, but additionally supports Local SQL
  ///  datasets with auto-incrementing fields. </summary>
  TFDPhysSQLiteLastAutoGenFunc = class(TSQLiteFunction)
  protected
    procedure DoCalculate(AData: TSQLiteFunctionInstance); override;
  public
    constructor Create(ALib: TSQLiteLib); override;
  end;

  TSQLiteRTree = class(TSQLiteExtension)
  private
    FOnCalculate: TSQLiteRTreeCalculateEvent;
    FOnFinalize: TSQLiteRTreeFinalizeEvent;
  protected
    procedure InternalInstall(ADatabase: TSQLiteDatabase); override;
    function DoCalculate(AData: TSQLiteRTreeData): Boolean; virtual;
    procedure DoFinalize(AData: TSQLiteRTreeData); virtual;
  public
    property OnCalculate: TSQLiteRTreeCalculateEvent read FOnCalculate write FOnCalculate;
    property OnFinalize: TSQLiteRTreeFinalizeEvent read FOnFinalize write FOnFinalize;
  end;

  TSQLiteRTreeInstance = class(TSQLiteExtensionInstance)
  private
    function DoCalculate(geom: psqlite3_rtree_geometry; nCoord: Integer;
      aCoord: psqlite3_rtree_dbl; var pRes: Integer): Integer;
    procedure DoFinalize(AData: TSQLiteRTreeData);
    function GetRTree: TSQLiteRTree; inline;
  public
    constructor Create(ADB: TSQLiteDatabase; ARTree: TSQLiteRTree);
    destructor Destroy; override;
    property RTree: TSQLiteRTree read GetRTree;
  end;

  TSQLiteRTreeData = class(TObject)
  private
    [Weak] FRTreeInst: TSQLiteRTreeInstance;
    FParams: TSQLiteRTreeDoubleArray;
    FColumns: TSQLiteRTreeDoubleArray;
    FUserData: TObject;
  public
    property RTreeInst: TSQLiteRTreeInstance read FRTreeInst;
    property Params: TSQLiteRTreeDoubleArray read FParams;
    property Columns: TSQLiteRTreeDoubleArray read FColumns;
    property UserData: TObject read FUserData write FUserData;
  end;

  TSQLiteBackup = class (TSQLiteHandle)
  private
    FDestinationDatabase: TSQLiteDatabase;
    FSourceDatabase: TSQLiteDatabase;
    FDestinationDBName: String;
    FSourceDBName: String;
    FPagesPerStep: Integer;
    FWaitForLocks: Boolean;
    function GetPageCount: Integer;
    function GetRemaining: Integer;
  public
    constructor Create(ALib: TSQLiteLib; ADestDatabase: TSQLiteDatabase);
    procedure Init;
    function Step: Boolean;
    procedure Finish;
    // R/O
    property Remaining: Integer read GetRemaining;
    property PageCount: Integer read GetPageCount;
    // R/W
    property PagesPerStep: Integer read FPagesPerStep write FPagesPerStep default -1;
    property WaitForLocks: Boolean read FWaitForLocks write FWaitForLocks default True;
    property SourceDatabase: TSQLiteDatabase read FSourceDatabase write FSourceDatabase;
    property SourceDBName: String read FSourceDBName write FSourceDBName;
    property DestinationDatabase: TSQLiteDatabase read FDestinationDatabase write FDestinationDatabase;
    property DestinationDBName: String read FDestinationDBName write FDestinationDBName;
  end;

  FDsqlite3_vtab = packed record
    pVTab: sqlite3_vtab;
    pFDModule: TSQLiteVModule;
    pFDTable: TSQLiteVTable;
  end;
  PFDsqlite3_vtab = ^FDsqlite3_vtab;
  TSQLiteVArgs = array of String;

  FDsqlite3_vtab_cursor = packed record
    pVTab: sqlite3_vtab;
    pFDModule: TSQLiteVModule;
    pFDTable: TSQLiteVTable;
    pFDCursor: TSQLiteVCursor;
  end;
  PFDsqlite3_vtab_cursor = ^FDsqlite3_vtab_cursor;

  TSQLiteVColDef = record
    FName: String;
    FDataType: String;
    FHidden: Boolean;
  end;
  TSQLiteVColDefs = array of TSQLiteVColDef;

  TSQLiteVConstraintOp = (coEqual, coGreater, coLess, coLessOrEqual,
    coGreaterOrEqual, coMatch);

  PSQLiteVConstraint = ^TSQLiteVConstraint;
  TSQLiteVConstraint = record
    // input
    FColumn: Integer;
    FOp: TSQLiteVConstraintOp;
    // output
    FArgvIndex: Integer;
    FOmit: Boolean;
  end;

  PSQLiteVOrderBy = ^TSQLiteVOrderBy;
  TSQLiteVOrderBy = record
    // input
    FColumn: Integer;
    FDesc: Boolean;
  end;

  TSQLiteVObject = class(TObject)
  private
    FResult: Integer;
  protected
    procedure Error(const AMsg: String); virtual; abstract;
  public
    function SafeCallException(ExceptObject: TObject;
      ExceptAddr: Pointer): HResult; override;
  end;

  TSQLiteVModule = class(TSQLiteVObject)
  private
    FLib: TSQLiteLib;
    [Weak] FDatabase: TSQLiteDatabase;
    FModule: sqlite3_module;
    FDummyVTab: FDsqlite3_vtab;
    function BuildCreateTableStr(ADatabase: TSQLiteDatabase;
      const ACols: array of TSQLiteVColDef): String;

    procedure xCreateConnect(db: psqlite3; argc: Integer; argv: PPUtf8;
      var ppVTab: psqlite3_vtab; var pzErr: PUtf8;
      const AConnect: Boolean); safecall;
  protected
    procedure Error(const AMsg: String); override;

    function VTabCreate(const AArgs: TSQLiteVArgs): TSQLiteVTable; virtual; abstract;
    function VTabConnect(const AArgs: TSQLiteVArgs): TSQLiteVTable; virtual; abstract;
  public
    constructor Create(const AName: String; ADatabase: TSQLiteDatabase); virtual;
    destructor Destroy; override;
    property Lib: TSQLiteLib read FLib;
    property Database: TSQLiteDatabase read FDatabase;
end;

  TSQLiteVTableDef = class(TSQLiteVObject)
  private
    FInputs: TSQLiteInputs;
    FOutputs: TFDObjList;
    function GetColsOUT(AIndex: Integer): TSQLiteOutput;
  protected
    FDatabase: TSQLiteDatabase;
    function GetColsIN(AIndex: Integer): TSQLiteInput; virtual;
    function GetCount: Integer; virtual;
    procedure AllocColumns(const ACount: Integer); virtual;
  public
    constructor Create(ADatabase: TSQLiteDatabase);
    destructor Destroy; override;
    property ColsIN[AIndex: Integer]: TSQLiteInput read GetColsIN;
    property ColsOUT[AIndex: Integer]: TSQLiteOutput read GetColsOUT;
    property Count: Integer read GetCount;
  end;

  TSQLiteVTable = class(TSQLiteVTableDef)
  private
    FrTab: FDsqlite3_vtab;

    procedure CloseCursors;

    procedure xDisconnect(pVTab: psqlite3_vtab);
    procedure xDestroy(pVTab: psqlite3_vtab);
    procedure xRename(pVTab: psqlite3_vtab; zNew: PUtf8); safecall;

    procedure xSync(pVTab: psqlite3_vtab); safecall;
    procedure xBegin(pVTab: psqlite3_vtab); safecall;
    procedure xCommit(pVTab: psqlite3_vtab); safecall;
    procedure xRollback(pVTab: psqlite3_vtab); safecall;

    procedure xSavepoint(pVTab: psqlite3_vtab; p: Integer); safecall;
    procedure xRelease(pVTab: psqlite3_vtab; p: Integer); safecall;
    procedure xRollbackTo(pVTab: psqlite3_vtab; p: Integer); safecall;

    function xFindFunction(pVTab: psqlite3_vtab; nArg: Integer; zName: PUtf8;
      var pxFunc: Tsqlite3_func_callback; var ppArg: Pointer): Integer; safecall;
    procedure xBestIndex(pVTab: psqlite3_vtab; info: psqlite3_index_info); safecall;
    procedure xUpdate(pVTab: psqlite3_vtab; nArg: Integer; apArgs: ppsqlite3_value;
      var rowid: sqlite3_int64); safecall;

    procedure xOpen(pVTab: psqlite3_vtab; var ppCursor: psqlite3_vtab_cursor);
    procedure xClose(cursor: psqlite3_vtab_cursor);
  protected
    FModule: TSQLiteVModule;
    FName: String;
    FConstraints: array of TSQLiteVConstraint;
    FOrderBys: array of TSQLiteVOrderBy;
    FCursors: TFDObjList;

    function GetColsIN(AIndex: Integer): TSQLiteInput; override;
    function GetCount: Integer; override;

    procedure AllocColumns(const ACount: Integer); override;
    procedure Error(const AMsg: String); override;
    procedure DescribeColumn(const AColName: String; out ANotNull, AInPK,
      AAutoInc: Boolean); virtual; abstract;
    function DescribeColumns: TSQLiteVColDefs; virtual; abstract;

    procedure VTabDisconnect; virtual; abstract;
    procedure VTabDestroy; virtual; abstract;
    procedure VTabRename(const ANewName: String); virtual; abstract;

    procedure VTabSync; virtual; abstract;
    procedure VTabBegin; virtual; abstract;
    procedure VTabCommit; virtual; abstract;
    procedure VTabRollback; virtual; abstract;

    procedure VTabSavepoint(const AVIndex: Integer); virtual; abstract;
    procedure VTabRelease(const AVIndex: Integer); virtual; abstract;
    procedure VTabRollbackTo(const AVIndex: Integer); virtual; abstract;

    function VTabFindFunction(ACount: Integer; const AName: String;
      var AFunc: Tsqlite3_func_callback; var AArg: Pointer): Boolean; virtual; abstract;
    procedure VTabBestIndex(var AIdxNum: Integer; var AIdxStr: String;
      var AOrdered, AFiltered: Boolean; var ACost: Double); virtual; abstract;

    procedure VTabInsert(var ARowid: sqlite3_int64; AOrUpdate: Boolean); virtual; abstract;
    procedure VTabUpdate(const AUpdRowid: sqlite3_int64; const ANewRowid: sqlite3_int64); virtual; abstract;
    procedure VTabDelete(const ARowid: sqlite3_int64); virtual; abstract;

    function VTabOpen: TSQLiteVCursor; virtual; abstract;
    procedure VTabClose(ACursor: TSQLiteVCursor); virtual;
  public
    constructor Create(AModule: TSQLiteVModule; const AName: String);
    destructor Destroy; override;
  end;

  TSQLiteVCursor = class(TSQLiteVTableDef)
  private
    FrCursor: FDsqlite3_vtab_cursor;

    procedure xFilter(cursor: psqlite3_vtab_cursor; idxNum: Integer; idxStr: PUtf8;
      argc: Integer; argv: ppsqlite3_value); safecall;
    procedure xNext(cursor: psqlite3_vtab_cursor); safecall;
    function xEof(cursor: psqlite3_vtab_cursor): Integer; safecall;
    procedure xColumn(cursor: psqlite3_vtab_cursor; context: psqlite3_context;
      index: Integer); safecall;
    procedure xRowid(cursor: psqlite3_vtab_cursor; var pRowid: sqlite3_int64); safecall;

  protected
    FTable: TSQLiteVTable;
    FActive: Boolean;

    procedure Error(const AMsg: String); override;

    procedure VTabFilter(const AIndex: Integer; const AIndexStr: String); virtual; abstract;
    procedure VTabNext; virtual; abstract;
    function VTabEof: Boolean; virtual; abstract;
    procedure VTabColumn(const AIndex: Integer); virtual; abstract;
    procedure VTabRowid(var ARowid: sqlite3_int64); virtual; abstract;
    procedure VTabClose(); virtual; abstract;
  public
    constructor Create(ATable: TSQLiteVTable);
    destructor Destroy; override;
  end;

  function FDExtensionManager(): TSQLiteExtensionManager;

const
  // undefined rowid and column numbers
  C_FD_SQLiteUndefRowid: Integer = -1000;

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
{$IFDEF MACOS}
  Macapi.CoreFoundation,
{$ENDIF}
{$IFDEF ANDROID}
  System.Internal.ICU,
{$ENDIF}
  System.Types, System.Variants, Data.SqlTimSt, Data.DB,
{$IFNDEF NEXTGEN}
  System.AnsiStrings,
{$ENDIF}
  FireDAC.Phys.Intf;

threadvar
  GCachedNumFS: TFormatSettings;

{-------------------------------------------------------------------------------}
const
  ssqlite3_libversion: String = 'sqlite3_libversion';
  ssqlite3_libversion_number: String = 'sqlite3_libversion_number';
  ssqlite3_compileoption_used: String = 'sqlite3_compileoption_used';
  ssqlite3_compileoption_get: String = 'sqlite3_compileoption_get';
  ssqlite3_initialize: String = 'sqlite3_initialize';
  ssqlite3_shutdown: String = 'sqlite3_shutdown';
  ssqlite3_config: String = 'sqlite3_config';
  ssqlite3_close: String = 'sqlite3_close';
  ssqlite3_errcode: String = 'sqlite3_errcode';
  ssqlite3_errmsg: String = 'sqlite3_errmsg';
  ssqlite3_extended_result_codes: String = 'sqlite3_extended_result_codes';
  ssqlite3_open: String = 'sqlite3_open';
  ssqlite3_open_v2: String = 'sqlite3_open_v2';
  ssqlite3_key: String = 'sqlite3_key';
  ssqlite3_rekey: String = 'sqlite3_rekey';
  ssqlite3_trace: String = 'sqlite3_trace';
  ssqlite3_profile: String = 'sqlite3_profile';
  ssqlite3_busy_timeout: String = 'sqlite3_busy_timeout';
  ssqlite3_get_autocommit: String = 'sqlite3_get_autocommit';
  ssqlite3_set_authorizer: String = 'sqlite3_set_authorizer';
  ssqlite3_update_hook: String = 'sqlite3_update_hook';
  ssqlite3_limit: String = 'sqlite3_limit';
  ssqlite3_changes: String = 'sqlite3_changes';
  ssqlite3_total_changes: String = 'sqlite3_total_changes';
  ssqlite3_interrupt: String = 'sqlite3_interrupt';
  ssqlite3_last_insert_rowid: String = 'sqlite3_last_insert_rowid';
  ssqlite3_db_status: String = 'sqlite3_db_status';
  ssqlite3_exec: String = 'sqlite3_exec';
  ssqlite3_enable_shared_cache: String = 'sqlite3_enable_shared_cache';
  ssqlite3_release_memory: String = 'sqlite3_release_memory';
  ssqlite3_soft_heap_limit: String = 'sqlite3_soft_heap_limit';
  ssqlite3_status: String = 'sqlite3_status';
  ssqlite3_malloc: String = 'sqlite3_malloc';
  ssqlite3_memory_used: String = 'sqlite3_memory_used';
  ssqlite3_memory_highwater: String = 'sqlite3_memory_highwater';
  ssqlite3_prepare: String = 'sqlite3_prepare';
  ssqlite3_finalize: String = 'sqlite3_finalize';
  ssqlite3_step: String = 'sqlite3_step';
  ssqlite3_reset: String = 'sqlite3_reset';
  ssqlite3_stmt_status: String = 'sqlite3_stmt_status';
  ssqlite3_column_count: String = 'sqlite3_column_count';
  ssqlite3_column_type: String = 'sqlite3_column_type';
  ssqlite3_column_name: String = 'sqlite3_column_name';
  ssqlite3_column_database_name: String = 'sqlite3_column_database_name';
  ssqlite3_column_table_name: String = 'sqlite3_column_table_name';
  ssqlite3_column_origin_name: String = 'sqlite3_column_origin_name';
  ssqlite3_column_decltype: String = 'sqlite3_column_decltype';
  ssqlite3_column_blob: String = 'sqlite3_column_blob';
  ssqlite3_column_double: String = 'sqlite3_column_double';
  ssqlite3_column_int64: String = 'sqlite3_column_int64';
  ssqlite3_column_text: String = 'sqlite3_column_text';
  ssqlite3_column_bytes: String = 'sqlite3_column_bytes';
  ssqlite3_clear_bindings: String = 'sqlite3_clear_bindings';
  ssqlite3_bind_parameter_count: String = 'sqlite3_bind_parameter_count';
  ssqlite3_bind_parameter_index: String = 'sqlite3_bind_parameter_index';
  ssqlite3_bind_parameter_name: String = 'sqlite3_bind_parameter_name';
  ssqlite3_bind_blob: String = 'sqlite3_bind_blob';
  ssqlite3_bind_blob64: String = 'sqlite3_bind_blob64';
  ssqlite3_bind_double: String = 'sqlite3_bind_double';
  ssqlite3_bind_int64: String = 'sqlite3_bind_int64';
  ssqlite3_bind_null: String = 'sqlite3_bind_null';
  ssqlite3_bind_text: String = 'sqlite3_bind_text';
  ssqlite3_bind_text64: String = 'sqlite3_bind_text64';
  ssqlite3_bind_value: String = 'sqlite3_bind_value';
  ssqlite3_bind_zeroblob: String = 'sqlite3_bind_zeroblob';
  ssqlite3_value_type: String = 'sqlite3_value_type';
  ssqlite3_value_blob: String = 'sqlite3_value_blob';
  ssqlite3_value_bytes: String = 'sqlite3_value_bytes';
  ssqlite3_value_double: String = 'sqlite3_value_double';
  ssqlite3_value_int64: String = 'sqlite3_value_int64';
  ssqlite3_value_text: String = 'sqlite3_value_text';
  ssqlite3_result_blob: String = 'sqlite3_result_blob';
  ssqlite3_result_blob64: String = 'sqlite3_result_blob64';
  ssqlite3_result_double: String = 'sqlite3_result_double';
  ssqlite3_result_error: String = 'sqlite3_result_error';
  ssqlite3_result_error_code: String = 'sqlite3_result_error_code';
  ssqlite3_result_int64: String = 'sqlite3_result_int64';
  ssqlite3_result_null: String = 'sqlite3_result_null';
  ssqlite3_result_text: String = 'sqlite3_result_text';
  ssqlite3_result_text64: String = 'sqlite3_result_text64';
  ssqlite3_result_zeroblob: String = 'sqlite3_result_zeroblob';
  ssqlite3_create_collation: String = 'sqlite3_create_collation';
  ssqlite3_create_function: String = 'sqlite3_create_function';
  ssqlite3_user_data: String = 'sqlite3_user_data';
  ssqlite3_enable_load_extension: String = 'sqlite3_enable_load_extension';
  ssqlite3_load_extension: String = 'sqlite3_load_extension';
  ssqlite3_free: String = 'sqlite3_free';
  ssqlite3_table_column_metadata: String = 'sqlite3_table_column_metadata';
  ssqlite3_progress_handler: String = 'sqlite3_progress_handler';
  ssqlite3_declare_vtab: String = 'sqlite3_declare_vtab';
  ssqlite3_create_module: String = 'sqlite3_create_module';
  ssqlite3_create_module_v2: String = 'sqlite3_create_module_v2';
  ssqlite3_vfs_find: String = 'sqlite3_vfs_find';
  ssqlite3_vfs_register: String = 'sqlite3_vfs_register';
  ssqlite3_vfs_unregister: String = 'sqlite3_vfs_unregister';
  ssqlite3_backup_init: String = 'sqlite3_backup_init';
  ssqlite3_backup_step: String = 'sqlite3_backup_step';
  ssqlite3_backup_finish: String = 'sqlite3_backup_finish';
  ssqlite3_backup_remaining: String = 'sqlite3_backup_remaining';
  ssqlite3_backup_pagecount: String = 'sqlite3_backup_pagecount';
  ssqlite3_wal_hook: String = 'sqlite3_wal_hook';
  ssqlite3_wal_autocheckpoint: String = 'sqlite3_wal_autocheckpoint';
  ssqlite3_wal_checkpoint: String = 'sqlite3_wal_checkpoint';
  ssqlite3_rtree_geometry_callback: String = 'sqlite3_rtree_geometry_callback';
  ssqlite3_rtree_query_callback: String = 'sqlite3_rtree_query_callback';
  ssqlite3_blob_open: String = 'sqlite3_blob_open';
  ssqlite3_blob_close: String = 'sqlite3_blob_close';
  ssqlite3_blob_bytes: String = 'sqlite3_blob_bytes';
  ssqlite3_blob_read: String = 'sqlite3_blob_read';
  ssqlite3_blob_write: String = 'sqlite3_blob_write';
  ssqlite3_vtab_config: String = 'sqlite3_vtab_config';
  ssqlite3_vtab_on_conflict: String = 'sqlite3_vtab_on_conflict';

  C_EDT2IDT: array [TSQLiteExtDataType] of Integer = (SQLITE_NULL,
    SQLITE_TEXT, SQLITE_TEXT, SQLITE_INTEGER, SQLITE_FLOAT, SQLITE_NULL,
    SQLITE_NULL, SQLITE_BLOB, SQLITE_NULL, SQLITE_NULL, SQLITE_NULL, SQLITE_NULL);

  C_IntTypeNames: array [1..5] of String = ('SQLITE_INTEGER', 'SQLITE_FLOAT',
    'SQLITE_TEXT', 'SQLITE_BLOB', 'SQLITE_NULL');

  C_TimeBase: Int64 = 211813444800000;

var
  Gsqlite3_user_data: Tsqlite3_user_data = nil;
  GExtensionManager: TSQLiteExtensionManager = nil;

{-------------------------------------------------------------------------------}
function FDExtensionManager(): TSQLiteExtensionManager;
begin
  if GExtensionManager = nil then
    GExtensionManager := TSQLiteExtensionManager.Create;
  Result := GExtensionManager;
end;

{-------------------------------------------------------------------------------}
procedure j2date(const AValue: Int64; out AYear, AMonth, ADay: Word);
var
  Z, A, B, C, D, E, X1: Integer;
begin
  Z := (AValue + 43200000) div MSecsPerDay;
  A := Trunc((Z - 1867216.25) / 36524.25);
  A := Z + 1 + A - (A div 4);
  B := A + 1524;
  C := Trunc((B - 122.1) / 365.25);
  D := Trunc(365.25 * C);
  E := Trunc((B - D) / 30.6001);
  X1 := Trunc(30.6001 * E);
  ADay := B - D - X1;
  if E < 14 then
    AMonth := E - 1
  else
    AMonth := E - 13;
  if AMonth > 2 then
    AYear := C - 4716
  else
    AYear := C - 4715;
end;

{-------------------------------------------------------------------------------}
function date2j(AYear, AMonth, ADay: Word): Int64;
var
  A, B, X1, X2: Integer;
begin
  if AMonth <= 2 then begin
    Dec(AYear);
    Inc(AMonth, 12);
  end;
  A := AYear div 100;
  B := 2 - A + (A div 4);
  X1 := Trunc(365.25 * (AYear + 4716));
  X2 := Trunc(30.6001 * (AMonth + 1));
  Result := Trunc((X1 + X2 + ADay + B - 1524.5) * MSecsPerDay);
end;

{-------------------------------------------------------------------------------}
procedure j2time(const AValue: Int64; out AHour, AMin, ASec: Word; out AFsec: Cardinal);
var
  s: Integer;
begin
  s := ((AValue + MSecsPerDay div 2) mod MSecsPerDay) div MSecsPerSec;
  AHour := s div SecsPerHour;
  s := s - AHour * SecsPerHour;
  AMin := s div SecsPerMin;
  ASec := s - AMin * SecsPerMin;
  AFsec := AValue mod MSecsPerSec;
end;

{-------------------------------------------------------------------------------}
function time2j(AHour, AMin, ASec: Word; AFsec: Cardinal): Int64;
begin
  Result := ((AHour * MinsPerHour + AMin) * SecsPerMin + ASec) * MSecsPerSec + AFsec;
end;

{-------------------------------------------------------------------------------}
{ TSQLiteLib                                                                    }
{-------------------------------------------------------------------------------}
constructor TSQLiteLib.Create(AOwningObj: TObject = nil);
begin
  inherited Create(S_FD_SQLiteId, AOwningObj);
  FDatabases := TFDObjList.Create;
  FExtensions := TFDObjList.Create;
  FLock := TCriticalSection.Create;
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteLib.Destroy;
begin
  FDFreeAndNil(FLock);
  FDFreeAndNil(FExtensions);
  FDFreeAndNil(FDatabases);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteLib.Load(const AVendorHome, AVendorLib: String);
{$IFNDEF FireDAC_SQLITE_STATIC}
var
  sDLLName: String;
  aSQLiteDllNames: array of String;
{$ENDIF}
begin
{$IFNDEF FireDAC_SQLITE_STATIC}
  sDLLName := AVendorHome;
  if sDLLName <> '' then
    sDLLName := FDNormPath(FDNormPath(sDLLName) + C_FD_DLLFolder);
  if AVendorLib <> '' then begin
    SetLength(aSQLiteDllNames, 1);
    aSQLiteDllNames[0] := sDLLName + AVendorLib;
  end
  else begin
    SetLength(aSQLiteDllNames, 2);
    aSQLiteDllNames[0] := sDLLName + C_SQLiteDll;
    aSQLiteDllNames[1] := sDLLName + C_BDBDll;
    {$IF NOT DEFINED(ANDROID) AND DEFINED(POSIX)}
    Insert(sDLLName + C_CGSQLiteDll, aSQLiteDllNames, 0);
    {$ENDIF}
  end;
  inherited Load(aSQLiteDllNames, True);
{$ELSE}
  LoadEntries;
{$ENDIF}

                                                                       
  if Assigned(Fsqlite3_initialize) then
    Check(Fsqlite3_initialize());

{$IFDEF FireDAC_SQLITE_STATIC}
  // See http://www.sqlite.org/cvstrac/tktview?tn=3679 for details.
  // Requires SQLite version > 3.6.11.
  Check(Fsqlite3_enable_shared_cache(1));
{$ENDIF}
  FDExtensionManager().RegisterAll(Self);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteLib.Unload;
begin
{$IFNDEF FireDAC_SQLITE_STATIC}
  if hDLL <> 0 then begin
{$ENDIF}
    if FExtensions <> nil then
      while FExtensions.Count <> 0 do
        FDFree(TSQLiteExtension(FExtensions[0]));
{$IFDEF FireDAC_32}
    // For x64 is used v 3.6.23, which gives AV at sqlite3_shutdown call
                                                                      
    if Assigned(Fsqlite3_shutdown) then
      Check(Fsqlite3_shutdown());
{$ENDIF}
{$IFNDEF FireDAC_SQLITE_STATIC}
  end;
  inherited Unload;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
{$IFNDEF FireDAC_SQLITE_STATIC}
function TSQLiteLib.GetSQLiteProcAddress(const AProcName: String;
  A16: Boolean = False; AVer: Integer = 0; ARequired: Boolean = True): Pointer;
var
  sName: String;
begin
  if A16 then
    sName := AProcName + '16'
  else
    sName := AProcName;
  if AVer > 0 then
    sName := sName + '_v' + IntToStr(AVer);
  Result := GetProc(sName, ARequired);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
procedure TSQLiteLib.GetLibraryInfo;
begin
  inherited GetLibraryInfo;
  if Pos('libdb', LowerCase(DLLName)) <> 0 then
    FBrand := sbBDB
  else
    FBrand := sbSQLite;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteLib.LoadEntries;
begin
{$IFDEF FireDAC_SQLITE_STATIC}
  @Fsqlite3_libversion := @sqlite3_libversion;
  FVersionStr := TFDEncoder.Deco(Fsqlite3_libversion(), -1, ecANSI);
  @Fsqlite3_libversion_number := @sqlite3_libversion_number;
  FVersion := Fsqlite3_libversion_number();
  FVersion :=
    (FVersion div 1000000) * 100000000 +
    ((FVersion mod 1000000) div 1000) * 1000000 +
    (FVersion mod 1000) * 10000;
  @Fsqlite3_compileoption_used := @sqlite3_compileoption_used;
  @Fsqlite3_compileoption_get := @sqlite3_compileoption_get;

  @Fsqlite3_initialize := @sqlite3_initialize;
  @Fsqlite3_shutdown := @sqlite3_initialize;
  @Fsqlite3_config := @sqlite3_config;
  @Fsqlite3_close := @sqlite3_close;
  @Fsqlite3_errcode := @sqlite3_errcode;
  @Fsqlite3_errmsg := @sqlite3_errmsg16;
  @Fsqlite3_extended_result_codes := @sqlite3_extended_result_codes;
  @Fsqlite3_open := @sqlite3_open16;
  @Fsqlite3_open_v2 := @sqlite3_open_v2;
  @Fsqlite3_key := @sqlite3_key;
  @Fsqlite3_rekey := @sqlite3_rekey;
  @Fsqlite3_trace := @sqlite3_trace;
  @Fsqlite3_profile := @sqlite3_profile;
  @Fsqlite3_busy_timeout := @sqlite3_busy_timeout;
  @Fsqlite3_get_autocommit := @sqlite3_get_autocommit;
  @Fsqlite3_set_authorizer := @sqlite3_set_authorizer;
  @Fsqlite3_update_hook := @sqlite3_update_hook;
  @Fsqlite3_limit := @sqlite3_limit;
  @Fsqlite3_changes := @sqlite3_changes;
  @Fsqlite3_total_changes := @sqlite3_total_changes;
  @Fsqlite3_interrupt := @sqlite3_interrupt;
  @Fsqlite3_last_insert_rowid := @sqlite3_last_insert_rowid;
  @Fsqlite3_db_status := @sqlite3_db_status;
  @Fsqlite3_exec := @sqlite3_exec;
  @Fsqlite3_enable_shared_cache := @sqlite3_enable_shared_cache;
  @Fsqlite3_release_memory := @sqlite3_release_memory;
  @Fsqlite3_soft_heap_limit := @sqlite3_soft_heap_limit;
  @Fsqlite3_malloc := @sqlite3_malloc;
  @Fsqlite3_memory_used := @sqlite3_memory_used;
  @Fsqlite3_memory_highwater := @sqlite3_memory_highwater;
  @Fsqlite3_status := @sqlite3_status;
  @Fsqlite3_prepare := @sqlite3_prepare16_v2;
  @Fsqlite3_finalize := @sqlite3_finalize;
  @Fsqlite3_step := @sqlite3_step;
  @Fsqlite3_reset := @sqlite3_reset;
  @Fsqlite3_stmt_status := @sqlite3_stmt_status;
  @Fsqlite3_column_count := @sqlite3_column_count;
  @Fsqlite3_column_type := @sqlite3_column_type;
  @Fsqlite3_column_name := @sqlite3_column_name16;
  @Fsqlite3_column_database_name := @sqlite3_column_database_name16;
  @Fsqlite3_column_table_name := @sqlite3_column_table_name16;
  @Fsqlite3_column_origin_name := @sqlite3_column_origin_name16;
  @Fsqlite3_table_column_metadata := @sqlite3_table_column_metadata;
  @Fsqlite3_column_decltype := @sqlite3_column_decltype16;
  @Fsqlite3_column_blob := @sqlite3_column_blob;
  @Fsqlite3_column_double := @sqlite3_column_double;
  @Fsqlite3_column_int64 := @sqlite3_column_int64;
  @Fsqlite3_column_text := @sqlite3_column_text16;
  @Fsqlite3_column_bytes_row := @sqlite3_column_bytes;
  @Fsqlite3_column_bytes := @sqlite3_column_bytes16;
  @Fsqlite3_clear_bindings := @sqlite3_clear_bindings;
  @Fsqlite3_bind_parameter_count := @sqlite3_bind_parameter_count;
  @Fsqlite3_bind_parameter_index := @sqlite3_bind_parameter_index;
  @Fsqlite3_bind_parameter_name := @sqlite3_bind_parameter_name;
  @Fsqlite3_bind_blob := @sqlite3_bind_blob;
  @Fsqlite3_bind_blob64 := @sqlite3_bind_blob64;
  @Fsqlite3_bind_double := @sqlite3_bind_double;
  @Fsqlite3_bind_int64 := @sqlite3_bind_int64;
  @Fsqlite3_bind_null := @sqlite3_bind_null;
  @Fsqlite3_bind_text := @sqlite3_bind_text16;
  @Fsqlite3_bind_text64 := @sqlite3_bind_text64;
  @Fsqlite3_bind_value := @sqlite3_bind_value;
  @Fsqlite3_bind_zeroblob := @sqlite3_bind_zeroblob;
  @Fsqlite3_value_type := @sqlite3_value_type;
  @Fsqlite3_value_blob := @sqlite3_value_blob;
  @Fsqlite3_value_bytes := @sqlite3_value_bytes16;
  @Fsqlite3_value_double := @sqlite3_value_double;
  @Fsqlite3_value_int64 := @sqlite3_value_int64;
  @Fsqlite3_value_text := @sqlite3_value_text16;
  @Fsqlite3_result_blob := @sqlite3_result_blob;
  @Fsqlite3_result_blob64 := @sqlite3_result_blob64;
  @Fsqlite3_result_double := @sqlite3_result_double;
  @Fsqlite3_result_error := @sqlite3_result_error16;
  @Fsqlite3_result_error_code := @sqlite3_result_error_code;
  @Fsqlite3_result_zeroblob := @sqlite3_result_zeroblob;
  @Fsqlite3_result_int64 := @sqlite3_result_int64;
  @Fsqlite3_result_null := @sqlite3_result_null;
  @Fsqlite3_result_text := @sqlite3_result_text16;
  @Fsqlite3_result_text64 := @sqlite3_result_text64;
  @Fsqlite3_create_collation := @sqlite3_create_collation16;
  @Fsqlite3_create_function := @sqlite3_create_function16;
  @Fsqlite3_user_data := @sqlite3_user_data;
  @Gsqlite3_user_data := @Fsqlite3_user_data;
  @Fsqlite3_enable_load_extension := @sqlite3_enable_load_extension;
  @Fsqlite3_load_extension := @sqlite3_load_extension;
  @Fsqlite3_free := @sqlite3_free;
  @Fsqlite3_progress_handler := @sqlite3_progress_handler;
  @Fsqlite3_declare_vtab := @sqlite3_declare_vtab;
  @Fsqlite3_create_module := @sqlite3_create_module;
  @Fsqlite3_create_module_v2 := @sqlite3_create_module_v2;
  @Fsqlite3_vfs_find := @sqlite3_vfs_find;
  @Fsqlite3_vfs_register := @sqlite3_vfs_register;
  @Fsqlite3_vfs_unregister := @sqlite3_vfs_unregister;
  @Fsqlite3_backup_init := @sqlite3_backup_init;
  @Fsqlite3_backup_step := @sqlite3_backup_step;
  @Fsqlite3_backup_finish := @sqlite3_backup_finish;
  @Fsqlite3_backup_remaining := @sqlite3_backup_remaining;
  @Fsqlite3_backup_pagecount := @sqlite3_backup_pagecount;
  @Fsqlite3_wal_hook := @sqlite3_wal_hook;
  @Fsqlite3_wal_autocheckpoint := @sqlite3_wal_autocheckpoint;
  @Fsqlite3_wal_checkpoint := @sqlite3_wal_checkpoint;
  @Fsqlite3_rtree_geometry_callback := @sqlite3_rtree_geometry_callback;
  @Fsqlite3_rtree_query_callback := @sqlite3_rtree_query_callback;
  @Fsqlite3_blob_open := @sqlite3_blob_open;
  @Fsqlite3_blob_close := @sqlite3_blob_close;
  @Fsqlite3_blob_bytes := @sqlite3_blob_bytes;
  @Fsqlite3_blob_read := @sqlite3_blob_read;
  @Fsqlite3_blob_write := @sqlite3_blob_write;
  @Fsqlite3_vtab_config := @sqlite3_vtab_config;
  @Fsqlite3_vtab_on_conflict := @sqlite3_vtab_on_conflict;

{$ELSE}

  @Fsqlite3_libversion := GetSQLiteProcAddress(ssqlite3_libversion);
  @Fsqlite3_libversion_number := GetSQLiteProcAddress(ssqlite3_libversion_number);
  if Assigned(Fsqlite3_libversion_number) then begin
    FVersion := Fsqlite3_libversion_number();
    FVersion :=
      (FVersion div 1000000) * 100000000 +
      ((FVersion mod 1000000) div 1000) * 1000000 +
      (FVersion mod 1000) * 10000;
  end
  else
    FVersion := svSQLite030600;
  @Fsqlite3_compileoption_used := GetSQLiteProcAddress(ssqlite3_compileoption_used, False, 0, False);
  @Fsqlite3_compileoption_get := GetSQLiteProcAddress(ssqlite3_compileoption_get, False, 0, False);

  if Version >= svSQLite030600 then begin
    @Fsqlite3_initialize := GetSQLiteProcAddress(ssqlite3_initialize);
    @Fsqlite3_shutdown := GetSQLiteProcAddress(ssqlite3_initialize);
    @Fsqlite3_config := GetSQLiteProcAddress(ssqlite3_config);
  end
  else begin
    @Fsqlite3_initialize := nil;
    @Fsqlite3_shutdown := nil;
    @Fsqlite3_config := nil;
  end;
  @Fsqlite3_close := GetSQLiteProcAddress(ssqlite3_close);
  @Fsqlite3_errcode := GetSQLiteProcAddress(ssqlite3_errcode);
  @Fsqlite3_errmsg := GetSQLiteProcAddress(ssqlite3_errmsg, True);
  if Version >= svSQLite030605 then
    @Fsqlite3_extended_result_codes := GetSQLiteProcAddress(ssqlite3_extended_result_codes)
  else
    @Fsqlite3_extended_result_codes := nil;
  @Fsqlite3_open := GetSQLiteProcAddress(ssqlite3_open, True);
  if Version >= svSQLite030500 then
    @Fsqlite3_open_v2 := GetSQLiteProcAddress(ssqlite3_open_v2)
  else
    @Fsqlite3_open_v2 := nil;
  @Fsqlite3_key := GetSQLiteProcAddress(ssqlite3_key, False, 0, False);
  @Fsqlite3_rekey := GetSQLiteProcAddress(ssqlite3_rekey, False, 0, False);
  @Fsqlite3_trace := GetSQLiteProcAddress(ssqlite3_trace);
  @Fsqlite3_profile := GetSQLiteProcAddress(ssqlite3_profile);
  @Fsqlite3_busy_timeout := GetSQLiteProcAddress(ssqlite3_busy_timeout);
  @Fsqlite3_get_autocommit := GetSQLiteProcAddress(ssqlite3_get_autocommit);
  @Fsqlite3_set_authorizer := GetSQLiteProcAddress(ssqlite3_set_authorizer);
  @Fsqlite3_update_hook := GetSQLiteProcAddress(ssqlite3_update_hook);
  if Version >= svSQLite030508 then
    @Fsqlite3_limit := GetSQLiteProcAddress(ssqlite3_limit)
  else
    @Fsqlite3_limit := nil;
  @Fsqlite3_changes := GetSQLiteProcAddress(ssqlite3_changes);
  @Fsqlite3_total_changes := GetSQLiteProcAddress(ssqlite3_total_changes);
  @Fsqlite3_interrupt := GetSQLiteProcAddress(ssqlite3_interrupt);
  @Fsqlite3_last_insert_rowid := GetSQLiteProcAddress(ssqlite3_last_insert_rowid);
  if Version >= svSQLite030601 then
    @Fsqlite3_db_status := GetSQLiteProcAddress(ssqlite3_db_status)
  else
    @Fsqlite3_db_status := nil;
  @Fsqlite3_exec := GetSQLiteProcAddress(ssqlite3_exec);
  @Fsqlite3_enable_shared_cache := GetSQLiteProcAddress(ssqlite3_enable_shared_cache);
  @Fsqlite3_malloc := GetSQLiteProcAddress(ssqlite3_malloc, False, 0, False);
  if Version >= svSQLite030500 then begin
    @Fsqlite3_release_memory := GetSQLiteProcAddress(ssqlite3_release_memory);
    @Fsqlite3_soft_heap_limit := GetSQLiteProcAddress(ssqlite3_soft_heap_limit);
    @Fsqlite3_memory_used := GetSQLiteProcAddress(ssqlite3_memory_used);
    @Fsqlite3_memory_highwater := GetSQLiteProcAddress(ssqlite3_memory_highwater);
  end
  else begin
    @Fsqlite3_release_memory := nil;
    @Fsqlite3_soft_heap_limit := nil;
    @Fsqlite3_memory_used := nil;
    @Fsqlite3_memory_highwater := nil;
  end;
  if Version >= svSQLite030600 then
    @Fsqlite3_status := GetSQLiteProcAddress(ssqlite3_status)
  else
    @Fsqlite3_status := nil;
  if Version >= svSQLite030313 then
    @Fsqlite3_prepare := GetSQLiteProcAddress(ssqlite3_prepare, True, 2)
  else
    @Fsqlite3_prepare := GetSQLiteProcAddress(ssqlite3_prepare, True);
  @Fsqlite3_finalize := GetSQLiteProcAddress(ssqlite3_finalize);
  @Fsqlite3_step := GetSQLiteProcAddress(ssqlite3_step);
  @Fsqlite3_reset := GetSQLiteProcAddress(ssqlite3_reset);
  if Version >= svSQLite030604 then
    @Fsqlite3_stmt_status := GetSQLiteProcAddress(ssqlite3_stmt_status)
  else
    @Fsqlite3_stmt_status := nil;
  @Fsqlite3_column_count := GetSQLiteProcAddress(ssqlite3_column_count);
  @Fsqlite3_column_type := GetSQLiteProcAddress(ssqlite3_column_type);
  @Fsqlite3_column_name := GetSQLiteProcAddress(ssqlite3_column_name, True);
  if Version >= svSQLite030401 then begin
    @Fsqlite3_column_database_name := GetSQLiteProcAddress(ssqlite3_column_database_name, True, 0, False);
    @Fsqlite3_column_table_name := GetSQLiteProcAddress(ssqlite3_column_table_name, True, 0, False);
    @Fsqlite3_column_origin_name := GetSQLiteProcAddress(ssqlite3_column_origin_name, True, 0, False);
    @Fsqlite3_table_column_metadata := GetSQLiteProcAddress(ssqlite3_table_column_metadata, False, 0, False);
  end
  else begin
    @Fsqlite3_column_database_name := nil;
    @Fsqlite3_column_table_name := nil;
    @Fsqlite3_column_origin_name := nil;
    @Fsqlite3_table_column_metadata := nil;
  end;
  @Fsqlite3_column_decltype := GetSQLiteProcAddress(ssqlite3_column_decltype, True);
  @Fsqlite3_column_blob := GetSQLiteProcAddress(ssqlite3_column_blob);
  @Fsqlite3_column_double := GetSQLiteProcAddress(ssqlite3_column_double);
  @Fsqlite3_column_int64 := GetSQLiteProcAddress(ssqlite3_column_int64);
  @Fsqlite3_column_text := GetSQLiteProcAddress(ssqlite3_column_text, True);
  @Fsqlite3_column_bytes_row := GetSQLiteProcAddress(ssqlite3_column_bytes);
  @Fsqlite3_column_bytes := GetSQLiteProcAddress(ssqlite3_column_bytes, True);
  if Version >= svSQLite030313 then
    @Fsqlite3_clear_bindings := GetSQLiteProcAddress(ssqlite3_clear_bindings)
  else
    @Fsqlite3_clear_bindings := nil;
  @Fsqlite3_bind_parameter_count := GetSQLiteProcAddress(ssqlite3_bind_parameter_count);
  @Fsqlite3_bind_parameter_index := GetSQLiteProcAddress(ssqlite3_bind_parameter_index);
  @Fsqlite3_bind_parameter_name := GetSQLiteProcAddress(ssqlite3_bind_parameter_name);
  @Fsqlite3_bind_blob := GetSQLiteProcAddress(ssqlite3_bind_blob);
  if Version >= svSQLite030807 then
    @Fsqlite3_bind_blob64 := GetSQLiteProcAddress(ssqlite3_bind_blob64)
  else
    @Fsqlite3_bind_blob64 := nil;
  @Fsqlite3_bind_double := GetSQLiteProcAddress(ssqlite3_bind_double);
  @Fsqlite3_bind_int64 := GetSQLiteProcAddress(ssqlite3_bind_int64);
  @Fsqlite3_bind_null := GetSQLiteProcAddress(ssqlite3_bind_null);
  @Fsqlite3_bind_text := GetSQLiteProcAddress(ssqlite3_bind_text, True);
  if Version >= svSQLite030807 then
    @Fsqlite3_bind_text64 := GetSQLiteProcAddress(ssqlite3_bind_text64)
  else
    @Fsqlite3_bind_text64 := nil;
  @Fsqlite3_bind_value := GetSQLiteProcAddress(ssqlite3_bind_value, False, 0, False);
  if Version >= svSQLite030500 then
    @Fsqlite3_bind_zeroblob := GetSQLiteProcAddress(ssqlite3_bind_zeroblob)
  else
    @Fsqlite3_bind_zeroblob := nil;
  @Fsqlite3_value_type := GetSQLiteProcAddress(ssqlite3_value_type);
  @Fsqlite3_value_blob := GetSQLiteProcAddress(ssqlite3_value_blob);
  @Fsqlite3_value_bytes := GetSQLiteProcAddress(ssqlite3_value_bytes, True);
  @Fsqlite3_value_double := GetSQLiteProcAddress(ssqlite3_value_double);
  @Fsqlite3_value_int64 := GetSQLiteProcAddress(ssqlite3_value_int64);
  @Fsqlite3_value_text := GetSQLiteProcAddress(ssqlite3_value_text, True);
  @Fsqlite3_result_blob := GetSQLiteProcAddress(ssqlite3_result_blob);
  if Version >= svSQLite030807 then
    @Fsqlite3_result_blob64 := GetSQLiteProcAddress(ssqlite3_result_blob64)
  else
    @Fsqlite3_result_blob64 := nil;
  @Fsqlite3_result_double := GetSQLiteProcAddress(ssqlite3_result_double);
  @Fsqlite3_result_error := GetSQLiteProcAddress(ssqlite3_result_error, True);
  if Version >= svSQLite030508 then begin
    @Fsqlite3_result_error_code := GetSQLiteProcAddress(ssqlite3_result_error_code);
    @Fsqlite3_result_zeroblob := GetSQLiteProcAddress(ssqlite3_result_zeroblob);
  end
  else begin
    @Fsqlite3_result_error_code := nil;
    @Fsqlite3_result_zeroblob := nil;
  end;
  @Fsqlite3_result_int64 := GetSQLiteProcAddress(ssqlite3_result_int64);
  @Fsqlite3_result_null := GetSQLiteProcAddress(ssqlite3_result_null);
  @Fsqlite3_result_text := GetSQLiteProcAddress(ssqlite3_result_text, True);
  if Version >= svSQLite030807 then
    @Fsqlite3_result_text64 := GetSQLiteProcAddress(ssqlite3_result_text64)
  else
    @Fsqlite3_result_text64 := nil;
  @Fsqlite3_create_collation := GetSQLiteProcAddress(ssqlite3_create_collation, True);
  @Fsqlite3_create_function := GetSQLiteProcAddress(ssqlite3_create_function, True);
  @Fsqlite3_user_data := GetSQLiteProcAddress(ssqlite3_user_data);
  @Gsqlite3_user_data := @Fsqlite3_user_data;
  @Fsqlite3_enable_load_extension := GetSQLiteProcAddress(ssqlite3_enable_load_extension, False, 0, False);
  @Fsqlite3_load_extension := GetSQLiteProcAddress(ssqlite3_load_extension, False, 0, False);
  @Fsqlite3_free := GetSQLiteProcAddress(ssqlite3_free);
  @Fsqlite3_progress_handler := GetSQLiteProcAddress(ssqlite3_progress_handler);
  @Fsqlite3_declare_vtab := GetSQLiteProcAddress(ssqlite3_declare_vtab);
  @Fsqlite3_create_module := GetSQLiteProcAddress(ssqlite3_create_module);
  @Fsqlite3_create_module_v2 := GetSQLiteProcAddress(ssqlite3_create_module_v2);
  if Version >= svSQLite030500 then begin
    @Fsqlite3_vfs_find := GetSQLiteProcAddress(ssqlite3_vfs_find);
    @Fsqlite3_vfs_register := GetSQLiteProcAddress(ssqlite3_vfs_register);
    @Fsqlite3_vfs_unregister := GetSQLiteProcAddress(ssqlite3_vfs_unregister);
  end
  else begin
    @Fsqlite3_vfs_find := nil;
    @Fsqlite3_vfs_register := nil;
    @Fsqlite3_vfs_unregister := nil;
  end;
  if Version >= svSQLite030611 then begin
    @Fsqlite3_backup_init := GetSQLiteProcAddress(ssqlite3_backup_init);
    @Fsqlite3_backup_step := GetSQLiteProcAddress(ssqlite3_backup_step);
    @Fsqlite3_backup_finish := GetSQLiteProcAddress(ssqlite3_backup_finish);
    @Fsqlite3_backup_remaining := GetSQLiteProcAddress(ssqlite3_backup_remaining);
    @Fsqlite3_backup_pagecount := GetSQLiteProcAddress(ssqlite3_backup_pagecount);
  end
  else begin
    @Fsqlite3_backup_init := nil;
    @Fsqlite3_backup_step := nil;
    @Fsqlite3_backup_finish := nil;
    @Fsqlite3_backup_remaining := nil;
    @Fsqlite3_backup_pagecount := nil;
  end;
  if Version >= svSQLite030700 then begin
    @Fsqlite3_wal_hook := GetSQLiteProcAddress(ssqlite3_wal_hook);
    @Fsqlite3_wal_autocheckpoint := GetSQLiteProcAddress(ssqlite3_wal_autocheckpoint);
    @Fsqlite3_wal_checkpoint := GetSQLiteProcAddress(ssqlite3_wal_checkpoint);
  end
  else begin
    @Fsqlite3_wal_hook := nil;
    @Fsqlite3_wal_autocheckpoint := nil;
    @Fsqlite3_wal_checkpoint := nil;
  end;
  @Fsqlite3_rtree_geometry_callback := GetSQLiteProcAddress(ssqlite3_rtree_geometry_callback, False, 0, False);
  @Fsqlite3_rtree_query_callback := GetSQLiteProcAddress(ssqlite3_rtree_query_callback, False, 0, False);
  if Version >= svSQLite030400 then begin
    @Fsqlite3_blob_open := GetSQLiteProcAddress(ssqlite3_blob_open);
    @Fsqlite3_blob_close := GetSQLiteProcAddress(ssqlite3_blob_close);
    @Fsqlite3_blob_bytes := GetSQLiteProcAddress(ssqlite3_blob_bytes);
    @Fsqlite3_blob_read := GetSQLiteProcAddress(ssqlite3_blob_read);
    @Fsqlite3_blob_write := GetSQLiteProcAddress(ssqlite3_blob_write);
  end
  else begin
    @Fsqlite3_blob_open := nil;
    @Fsqlite3_blob_close := nil;
    @Fsqlite3_blob_bytes := nil;
    @Fsqlite3_blob_read := nil;
    @Fsqlite3_blob_write := nil;
  end;
  if Version >= svSQLite030707 then begin
    @Fsqlite3_vtab_config := GetSQLiteProcAddress(ssqlite3_vtab_config);
    @Fsqlite3_vtab_on_conflict := GetSQLiteProcAddress(ssqlite3_vtab_on_conflict);
  end
  else begin
    @Fsqlite3_vtab_config := nil;
    @Fsqlite3_vtab_on_conflict := nil;
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteLib.Check(ACode: Integer);
var
  iMainCode, iExtCode: Integer;
begin
  if ACode = SQLITE_OK then
    Exit;
  iMainCode := ACode and $FF;
  iExtCode := (ACode and $FFFF) shr 8;
  if (iMainCode <> SQLITE_ROW) and (iMainCode <> SQLITE_DONE) then
    FDException(OwningObj, [S_FD_LPhys, S_FD_SQLiteId, 'sqlite3'],
      er_FD_SQLiteInitFailed, [iMainCode, iExtCode]);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteLib.SoftHeapLimit(AAmount: Integer);
begin
  if Version >= svSQLite030500 then
    Fsqlite3_soft_heap_limit(AAmount);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteLib.ReleaseMemory(AAmount: Integer);
begin
  if Version >= svSQLite030500 then
    Fsqlite3_release_memory(AAmount);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteLib.InstallExtensions(ADatabase: TSQLiteDatabase);
var
  i: Integer;
begin
  FLock.Enter;
  try
    for i := 0 to FExtensions.Count - 1 do
      TSQLiteExtension(FExtensions[i]).InternalInstall(ADatabase);
  finally
    FLock.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteLib.InstallDatabases(AExtension: TSQLiteExtension);
var
  i: Integer;
begin
  FLock.Enter;
  try
    for i := 0 to FDatabases.Count - 1 do
      AExtension.InternalInstall(TSQLiteDatabase(FDatabases[i]));
  finally
    FLock.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteLib.DeinstallExtensions(ADatabase: TSQLiteDatabase);
var
  i: Integer;
begin
  FLock.Enter;
  try
    while ADatabase.FExtensionInstances.Count > 0 do
      FDFree(TSQLiteExtensionInstance(ADatabase.FExtensionInstances[0]));
    for i := 0 to FExtensions.Count - 1 do
      TSQLiteExtension(FExtensions[i]).InternalDeinstall(ADatabase);
  finally
    FLock.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteLib.DeinstallDatabases(AExtension: TSQLiteExtension);
var
  i: Integer;
begin
  FLock.Enter;
  try
    for i := 0 to FDatabases.Count - 1 do
      AExtension.InternalDeinstall(TSQLiteDatabase(FDatabases[i]));
  finally
    FLock.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteLib.InstallModules(ADatabase: TSQLiteDatabase);
var
  i: Integer;
  oMan: TSQLiteExtensionManager;
begin
  oMan := FDExtensionManager();
  for i := 0 to oMan.FModules.Count - 1 do
    TSQLiteVModuleClass(oMan.FModules.Ptrs[i]).Create(oMan.FModules[i], ADatabase);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteLib.DeinstallModules(ADatabase: TSQLiteDatabase);
begin
  while ADatabase.FVModules.Count > 0 do
    FDFree(TSQLiteVModule(ADatabase.FVModules[0]));
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteLib.AddDatabase(ADatabase: TSQLiteDatabase);
begin
  FLock.Enter;
  try
    FDatabases.Add(ADatabase);
  finally
    FLock.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteLib.RemoveDatabase(ADatabase: TSQLiteDatabase);
begin
  FLock.Enter;
  try
    FDatabases.Remove(ADatabase);
    if ADatabase = FLastDatabase then begin
      FLastDatabase := nil;
      FLastDBHandle := nil;
    end;
  finally
    FLock.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
function TSQLiteLib.dbH2dbObj(db: psqlite3): TSQLiteDatabase;
var
  i: Integer;
begin
  Result := nil;
  FLock.Enter;
  try
    if (FLastDBHandle = db) and (FLastDatabase <> nil) then begin
      Result := FLastDatabase;
      Exit;
    end;
    for i := 0 to FDatabases.Count - 1 do
      if TSQLiteDatabase(FDatabases[i]).Handle = db then begin
        Result := TSQLiteDatabase(FDatabases[i]);
        Break;
      end;
    FLastDatabase := Result;
    FLastDBHandle := db;
  finally
    FLock.Leave;
  end;
  if Result = nil then
    FDException(OwningObj, [S_FD_LPhys, S_FD_SQLiteId, 'sqlite3'],
      er_FD_SQLiteDBNotFound, [db]);
end;

{-------------------------------------------------------------------------------}
{ ESQLiteNativeException                                                        }
{-------------------------------------------------------------------------------}
constructor ESQLiteNativeException.Create(ACode: Integer; AOwner: TSQLiteHandle;
  AMsg: String = '');
var
  sMsg, sLCMsg, sErr, sObjName: String;
{$IFDEF FireDAC_SQLITE_STATIC}
  pEncError: PFDAnsiString;
  iEncLen,
  iEncError: Integer;
{$ENDIF}
  eKind: TFDCommandExceptionKind;
  i1, i2, iCmdOffset: Integer;
  sSQL: String;
  iADCode,
  iMainCode: Integer;
{$IFDEF FireDAC_MONITOR}
  iExtCode: Integer;
{$ENDIF}
  oDB: TSQLiteDatabase;
  oStmt: TSQLiteStatement;
begin
  iADCode := er_FD_SQLiteGeneral;
  iMainCode := ACode and $FF;
{$IFDEF FireDAC_MONITOR}
  iExtCode := (ACode and $FFFF) shr 8;
{$ENDIF}
  oDB := AOwner.Database;
  eKind := ekOther;
  sObjName := '';
  iCmdOffset := -1;
  if AMsg <> '' then
    sMsg := AMsg
{$IFDEF FireDAC_SQLITE_STATIC}
  else if ad_sqlite3GetEncryptionError(oDB.Handle, pEncError, iEncLen, iEncError) = SQLITE_ERROR then begin
    sMsg := oDB.Encoder.Decode(pEncError, iEncLen, ecANSI);
    eKind := ekUserPwdInvalid;
    iADCode := iEncError;
  end
{$ENDIF}
  else
    sMsg := oDB.APIStrToDlpStr(oDB.Lib.Fsqlite3_errmsg(oDB.Handle));
  sLCMsg := LowerCase(sMsg);
  if Pos('[FireDAC]', sMsg) > 0 then
    sErr := sMsg
  else
    sErr := FDExceptionLayers([S_FD_LPhys, S_FD_SQLiteId]) + ' ERROR: ' + sMsg;
  inherited Create(iADCode, sErr);
  case iMainCode of
  SQLITE_ERROR:
    if Pos('no such', sLCMsg) = 1 then begin
      eKind := ekObjNotExists;
      i1 := Pos(':', sLCMsg);
      if i1 <> 0 then
        sObjName := Trim(Copy(sMsg, i1 + 1, MAXINT));
    end
    else if (Pos(': syntax error', sLCMsg) <> 0) and (AOwner is TSQLiteStatement) then begin
      i1 := Pos('near "', sLCMsg);
      i2 := Pos('"', sLCMsg, i1 + 6);
      if (i1 <> 0) and (i1 <> 0) then begin
        oStmt := TSQLiteStatement(AOwner);
        SetString(sSQL, PChar(oStmt.FCmdCurr), oStmt.FCmdTailLen div SizeOf(Char));
        iCmdOffset := Pos(AdjustLineBreaks(Copy(sMsg, i1 + 6, i2 - i1 - 6), tlbsCRLF), sSQL) +
          (oStmt.FCmdCurr - PByte(oStmt.FCmdText)) div SizeOf(Char);
      end;
    end;
  SQLITE_CONSTRAINT:
    begin
      i1 := Pos(' may not be null', sLCMsg);
      if i1 <> 0 then
        sObjName := Copy(sMsg, 1, i1 - 1)
      else if Pos('foreign key constraint failed', sLCMsg) <> 0 then
        eKind := ekFKViolated
      else begin
        i1 := Pos(' is not unique', sLCMsg);
        if i1 = 0 then
          i1 := Pos(' are not unique', sLCMsg);
        if i1 <> 0 then begin
          eKind := ekUKViolated;
          sObjName := Copy(sMsg, 1, i1 - 1);
        end;
        if i1 = 0 then begin
          i1 := Pos('unique constraint failed: ', sLCMsg);
          if i1 <> 0 then begin
            eKind := ekUKViolated;
            sObjName := Copy(sMsg, i1 + 26, MaxInt);
          end;
        end;
        if i1 = 0 then begin
          i1 := Pos('primary key must be unique', sLCMsg);
          if i1 <> 0 then
            eKind := ekUKViolated;
        end;
      end;
    end;
  SQLITE_ABORT,
  SQLITE_INTERRUPT:
    eKind := ekCmdAborted;
  SQLITE_BUSY,
  SQLITE_LOCKED:
    begin
      eKind := ekRecordLocked;
      i1 := Pos(':', sLCMsg);
      if i1 <> 0 then
        sObjName := Copy(sMsg, i1 + 1, MAXINT);
    end;
  end;
  AppendError(1, ACode, sMsg, sObjName, eKind, iCmdOffset, -1);
{$IFDEF FireDAC_MONITOR}
  if AOwner.Tracing then
    AOwner.Trace(ekError, esProgress, Message,
      ['maincode', iMainCode, 'extcode', iExtCode]);
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
{ TSQLiteHandle                                                                 }
{-------------------------------------------------------------------------------}
constructor TSQLiteHandle.Create;
begin
  inherited Create;
  FOwnHandle := True;
end;

{-------------------------------------------------------------------------------}
constructor TSQLiteHandle.CreateUsingHandle(AHandle: psqlite3);
begin
  inherited Create;
  FHandle := AHandle;
  FOwnHandle := False;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteHandle.Check(ACode: Integer);
begin
  if (ACode <> SQLITE_OK) and
     (ACode and $FF <> SQLITE_ROW) and (ACode and $FF <> SQLITE_DONE) then
    FDException(OwningObj, ESQLiteNativeException.Create(ACode, Self)
                {$IFDEF FireDAC_Monitor}, Tracing {$ENDIF});
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TSQLiteHandle.GetTracing: Boolean;
begin
  Result := (Database <> nil) and Database.Tracing;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteHandle.Trace(const AMsg: String; const AArgs: array of const);
begin
  if Tracing then
    Database.Monitor.Notify(ekVendor, esProgress, OwningObj, AMsg, AArgs);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteHandle.Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
  const AMsg: String; const AArgs: array of const);
begin
  if Tracing then
    Database.Monitor.Notify(AKind, AStep, OwningObj, AMsg, AArgs);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TSQLiteDatabase                                                               }
{-------------------------------------------------------------------------------}
constructor TSQLiteDatabase.Create(ALib: TSQLiteLib; AOwningObj: TObject
  {$IFDEF FireDAC_Monitor}; const AMonitor: IFDMoniClient {$ENDIF});
begin
  inherited Create;
  Init(ALib, AOwningObj {$IFDEF FireDAC_Monitor}, AMonitor {$ENDIF});
end;

{-------------------------------------------------------------------------------}
constructor TSQLiteDatabase.CreateUsingHandle(ALib: TSQLiteLib;
  Asqlite3: psqlite3; AOwningObj: TObject
  {$IFDEF FireDAC_Monitor}; const AMonitor: IFDMoniClient {$ENDIF});
begin
  inherited CreateUsingHandle(Asqlite3);
  Init(ALib, AOwningObj {$IFDEF FireDAC_Monitor}, AMonitor {$ENDIF});
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.Init(ALib: TSQLiteLib; AOwningObj: TObject
  {$IFDEF FireDAC_Monitor}; const AMonitor: IFDMoniClient {$ENDIF});
begin
  FLib := ALib;
  FLib.AddDatabase(Self);
  FOwningObj := AOwningObj;
  FDatabase := Self;
{$IFDEF FireDAC_Monitor}
  FMonitor := AMonitor;
{$ENDIF}
  FBuffer := TFDBuffer.Create;
  FEncoder := TFDEncoder.Create(FBuffer);
  FEncoder.Encoding := ecUTF16;
  FExtensionInstances := TFDObjList.Create;
  FExtensions := TFDStringList.Create;
  FVModules := TFDObjList.Create;
  FVTabs := TFDStringList.Create(dupIgnore, True, False);
  FSQLHandlerList := TInterfaceList.Create;
  FDateTimeFormat := etString;
  FProgressNOpers := 100;
  FAutoCheckpoint := 1000;
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteDatabase.Destroy;
begin
  if Handle <> nil then
    Close;
  FLib.RemoveDatabase(Self);
  FDFreeAndNil(FVTabs);
  FDFreeAndNil(FVModules);
  FDFreeAndNil(FExtensions);
  FDFreeAndNil(FExtensionInstances);
  FDFreeAndNil(FEncoder);
  FDFreeAndNil(FBuffer);
  FDFreeAndNil(FSQLHandlerList);
{$IFDEF FireDAC_MONITOR}
  FMonitor := nil;
{$ENDIF}
  FOwningObj := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TSQLiteDatabase.APIStrToDlpStr(AStr: PByte): String;
begin
  if AStr = nil then
    Result := ''
  else
    Result := Encoder.Decode(AStr, -1);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.Open(const AFilename: String; AMode: TSQLiteDatabaseMode;
  ASharedCache: TSQLiteSharedCache);
const
  aModes: array[TSQLiteDatabaseMode] of Integer = (
    SQLITE_OPEN_READWRITE or SQLITE_OPEN_CREATE,
    SQLITE_OPEN_READWRITE,
    SQLITE_OPEN_READONLY);
  aCaches: array[TSQLiteSharedCache] of Integer = (
    {$IFNDEF FireDAC_SQLITE_STATIC} SQLITE_OPEN_SHAREDCACHE {$ELSE} 0 {$ENDIF},
    SQLITE_OPEN_PRIVATECACHE,
    SQLITE_OPEN_SHAREDCACHE);
var
  pFileName: PByte;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_open_v2, ['filename', AFilename, 'mode',
      aModes[AMode] or aCaches[ASharedCache]]);
  end;

  procedure Trace2;
  begin
    Trace(ssqlite3_open, ['filename', AFilename]);
  end;
{$ENDIF}

begin
  try
    if Assigned(Lib.Fsqlite3_open_v2) then begin
{$IFDEF FireDAC_MONITOR}
      if Tracing then Trace1;
{$ENDIF}
      pFileName := PByte(Encoder.Encode(AFilename, ecUTF8));
      Check(Lib.Fsqlite3_open_v2(PUtf8(pFileName), FHandle,
        aModes[AMode] or aCaches[ASharedCache], nil));
    end
    else begin
{$IFDEF FireDAC_MONITOR}
      if Tracing then Trace2;
{$ENDIF}
      pFileName := PByte(Encoder.Encode(AFilename));
      Check(Lib.Fsqlite3_open(pFileName, FHandle));
    end;
{$IFDEF FireDAC_MONITOR}
    UpdateTracing;
{$ENDIF}
    if Assigned(Lib.Fsqlite3_extended_result_codes) then
      Check(Lib.Fsqlite3_extended_result_codes(Handle, 1));
    FLib.InstallExtensions(Self);
    FLib.InstallModules(Self);
    InstallExternalExtensions;
  except
    Close;
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.Key(const AKey: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_key, ['db', Handle, 'key', '*****']);
  end;
{$ENDIF}

var
  sKey: TFDByteString;
begin
  if Assigned(Lib.Fsqlite3_key) then begin
    sKey := Encoder.Encode(AKey, ecUTF8);
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(Lib.Fsqlite3_key(Handle, PByte(sKey), Encoder.EncodedLength(sKey, ecUTF8)));
  end
  else
    FDCapabilityNotSupported(nil, [S_FD_LPhys, S_FD_SQLiteId, 'sqlite3']);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.ReKey(const AKey: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_rekey, ['db', Handle, 'key', '*****']);
  end;
{$ENDIF}

var
  sKey: TFDByteString;
begin
  if Assigned(Lib.Fsqlite3_rekey) then begin
    sKey := Encoder.Encode(AKey, ecUTF8);
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(Lib.Fsqlite3_rekey(Handle, PByte(sKey), Encoder.EncodedLength(sKey, ecUTF8)));
  end
  else
    FDCapabilityNotSupported(nil, [S_FD_LPhys, S_FD_SQLiteId, 'sqlite3']);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.Close;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_close, ['db', Handle]);
  end;
{$ENDIF}

begin
  if Handle = nil then
    Exit;
  if FOwnHandle then begin
    FLib.DeinstallExtensions(Self);
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(Lib.Fsqlite3_close(Handle));
  end;
  // destroy modules after closing Handle
  // otherwise AV is raised in sqlite3_create_module_v2
  FLib.DeinstallModules(Self);
  FHandle := nil;
end;

{-------------------------------------------------------------------------------}
function TSQLiteDatabase.IsVTab(const ATabName, AColName: String; out ANotNull,
  AInPK, AAutoInc: Boolean): Boolean;
var
  i: Integer;
begin
  Result := FVTabs.Find(AnsiUpperCase(ATabName), i);
  if Result then
    TSQLiteVTable(FVTabs.Objects[i]).DescribeColumn(AColName, ANotNull, AInPK, AAutoInc);
end;

{-------------------------------------------------------------------------------}
class procedure TSQLiteDatabase.ParseObjName(const AObjName: String; var ASchema, AName: String);

  function Unquote(const AName: String): String;
  begin
    if (AName <> '') and (
        (AName[1] = '''') and (AName[Length(AName)] = '''') or
        (AName[1] = '"') and (AName[Length(AName)] = '"') or
        (AName[1] = '[') and (AName[Length(AName)] = ']') or
        (AName[1] = '`') and (AName[Length(AName)] = '`')) then
      Result := Copy(AName, 2, Length(AName) - 2)
    else
      Result := AName;
  end;

var
  i: Integer;
begin
  i := Pos('.', AObjName);
  if i = 0 then begin
    ASchema := '';
    AName := Unquote(AObjName);
  end
  else begin
    ASchema := Unquote(Copy(AObjName, 1, i - 1));
    AName := Unquote(Copy(AObjName, i + 1, MAXINT));
  end;
end;

{-------------------------------------------------------------------------------}
function TSQLiteDatabase.DoGetTable(const AObjName: String): Boolean;
var
  i: Integer;
  sSchema, sName: String;
begin
  Result := True;
  ParseObjName(AObjName, sSchema, sName);
  for i := 0 to SQLHandlerList.Count - 1 do
    if IFDPhysSQLHandler(SQLHandlerList[i]).GetDataSet(sSchema, sName) then begin
      Result := False;
      Exit;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.Interrupt;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_interrupt, ['db', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Lib.Fsqlite3_interrupt(Handle);
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
procedure FDsqlite3_trace(userdata: Pointer; zSql: PUtf8); cdecl;
begin
  TSQLiteDatabase(userdata).Trace('trace', ['SQL', zSql]);
end;

{-------------------------------------------------------------------------------}
procedure FDsqlite3_profile(userdata: Pointer; zSql: PUtf8; time: sqlite3_uint64); cdecl;
begin
  TSQLiteDatabase(userdata).Trace('profile', ['SQL', zSql, 'time', time div 1000000]);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.SetTracing(AValue: Boolean);
begin
  if Tracing <> AValue then begin
    FTracing := AValue;
    UpdateTracing;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.UpdateTracing;
begin
  if Handle <> nil then
    if Tracing then begin
      Lib.Fsqlite3_trace(Handle, @FDsqlite3_trace, Self);
      Lib.Fsqlite3_profile(Handle, @FDsqlite3_profile, Self);
    end
    else begin
      Lib.Fsqlite3_trace(Handle, nil, nil);
      Lib.Fsqlite3_profile(Handle, nil, nil);
    end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.SetBusyTimeout(const AValue: Integer);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_busy_timeout, ['db', Handle, 'ms', AValue]);
  end;
{$ENDIF}

begin
  if FBusyTimeout <> AValue then begin
    FBusyTimeout := AValue;
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(Lib.Fsqlite3_busy_timeout(Handle, AValue));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.EnableExtensions(AValue: Boolean);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_enable_load_extension, ['db', Handle, 'onoff', AValue]);
  end;
{$ENDIF}

begin
  if Assigned(Lib.Fsqlite3_enable_load_extension) then begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(Lib.Fsqlite3_enable_load_extension(Handle, Integer(AValue)));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.LoadExtension(const AExtension, AEntry: String);
var
  sPath, sExt, sMsg: String;
  sBEntry, sBExt: TFDByteString;
  pExt, pEntry, pMsg: PByte;
  iCode: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_load_extension, ['db', Handle, 'zFile', sExt, 'zProc', AEntry]);
  end;
{$ENDIF}

begin
  if (AExtension = '') or not Assigned(Lib.Fsqlite3_load_extension) then
    Exit;
  sMsg := '';
  sPath := FDNormPath(ExtractFilePath(Lib.DLLName));
  sExt := AExtension;
  if ExtractFileExt(sExt) = '' then
    sExt := sExt + '.dll';
  if (ExtractFilePath(sExt) = '') and FileExists(sPath + sExt) then
    sExt := sPath + sExt;

  sBExt := Encoder.Encode(sExt, ecANSI);
  pExt := PByte(sBExt);
  sBEntry := Encoder.Encode(AEntry, ecANSI);
  if Encoder.EncodedLength(sBEntry, ecANSI) = 0 then
    pEntry := nil
  else
    pEntry := PByte(sBEntry);
  pMsg := nil;

{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  iCode := Lib.Fsqlite3_load_extension(Handle, pExt, pEntry, pMsg);

  if pMsg <> nil then begin
    sMsg := Encoder.Decode(pMsg, -1, ecANSI);
    Lib.Fsqlite3_free(pMsg);
  end;
  if iCode <> SQLITE_OK then
    FDException(OwningObj, ESQLiteNativeException.Create(iCode, Self, sMsg)
                {$IFDEF FireDAC_Monitor}, Tracing {$ENDIF});
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.msg2putf8(const AMsg: String; var ApMsg: Pointer);
var
  sMsg: TFDByteString;
  iLen: LongWord;
begin
  sMsg := Encoder.Encode(AMsg, ecUTF8);
  iLen := Encoder.EncodedLength(sMsg, ecUTF8);
  ApMsg := FLib.Fsqlite3_malloc(iLen + 1);
  if iLen > 0 then
    Move(PByte(sMsg)^, ApMsg^, iLen);
  (PByte(ApMsg) + iLen)^ := 0;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.InstallExternalExtensions;
var
  i: Integer;
begin
  // Extensions are disabled
  if (FExtensions.Count = 0) or
     (FExtensions.Count = 1) and (CompareText(FExtensions[0], S_FD_False) = 0) then
    Exit;

  // Just enable extensions
  EnableExtensions(True);
  if (FExtensions.Count = 1) and (CompareText(FExtensions[0], S_FD_True) = 0) then
    Exit;

  // Load specified extensions
  try
    for i := 0 to FExtensions.Count - 1 do
      LoadExtension(FExtensions.KeyNames[i], FExtensions.ValueFromIndex[i]);
  finally
    // and disable extensions
    EnableExtensions(False);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.SetExtensions(const AValue: TStrings);
begin
  FExtensions.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
function TSQLiteDatabase.GetInTransaction: Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_get_autocommit, ['db', Handle, 'Result', Result]);
  end;
{$ENDIF}

begin
  Result := Lib.Fsqlite3_get_autocommit(Handle) = 0;
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TSQLiteDatabase.DoAuthorize(code: Integer;
  zArg1, zArg2, zArg3, zArg4: PUtf8): Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace('authorized', ['code', code, 'zArg1', zArg1, 'zArg2', zArg2,
      'zArg3', zArg3, 'zArg4', zArg4, 'Result', Result]);
  end;
{$ENDIF}

var
  sArg1, sArg2, sArg3, sArg4: String;
begin
  sArg1 := Encoder.Decode(zArg1, -1, ecUTF8);
  sArg2 := Encoder.Decode(zArg2, -1, ecUTF8);
  sArg3 := Encoder.Decode(zArg3, -1, ecUTF8);
  sArg4 := Encoder.Decode(zArg4, -1, ecUTF8);
  try
    Result := SQLITE_OK;
    OnAutorize(Self, code, sArg1, sArg2, sArg3, sArg4, Result);
  except
    FDHandleException;
    Result := SQLITE_DENY;
  end;
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function FDsqlite3_authorize(userdata: Pointer; code: Integer;
  zArg1, zArg2, zArg3, zArg4: PUtf8): Integer; cdecl;
begin
  Result := TSQLiteDatabase(userdata).DoAuthorize(code, zArg1, zArg2, zArg3, zArg4);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.SetOnAuthorize(const AValue: TSQLiteDatabaseAuthorizeEvent);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_set_authorizer, ['db', Handle, 'xAuth', 'FDsqlite3_authorize']);
  end;

  procedure Trace2;
  begin
    Trace(ssqlite3_set_authorizer, ['db', Handle, 'xAuth', 'nil']);
  end;
{$ENDIF}

begin
  ASSERT(Handle <> nil);
  FOnAuthorize := AValue;
  if Assigned(FOnAuthorize) then begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(Lib.Fsqlite3_set_authorizer(Handle, FDsqlite3_authorize, Self));
  end
  else begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace2;
{$ENDIF}
    Check(Lib.Fsqlite3_set_authorizer(Handle, nil, nil));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.DoUpdate(oper: Integer;
  zDb, zTable: PUtf8; rowid: sqlite3_int64);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace('updated', ['oper', oper, 'zDb', zDb, 'zTable', zTable,
      'rowid', rowid]);
  end;
{$ENDIF}

var
  sDB, sTable: String;
begin
  sDB := Encoder.Decode(zDb, -1, ecUTF8);
  sTable := Encoder.Decode(zTable, -1, ecUTF8);
  try
    OnUpdate(Self, oper, sDB, sTable, rowid);
  except
    FDHandleException;
  end;
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure FDsqlite3_update(userdata: Pointer; oper: Integer;
  zDb, zTable: PUtf8; rowid: sqlite3_int64); cdecl;
begin
  TSQLiteDatabase(userdata).DoUpdate(oper, zDb, zTable, rowid);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.SetOnUpdate(const AValue: TSQLiteDatabaseUpdateEvent);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_update_hook, ['db', Handle, 'callback', 'FDsqlite3_update']);
  end;

  procedure Trace2;
  begin
    Trace(ssqlite3_update_hook, ['db', Handle, 'callback', 'nil']);
  end;
{$ENDIF}

begin
  ASSERT(Handle <> nil);
  FOnUpdate := AValue;
  if Assigned(FOnUpdate) then begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Lib.Fsqlite3_update_hook(Handle, FDsqlite3_update, Self);
  end
  else begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace2;
{$ENDIF}
    Lib.Fsqlite3_update_hook(Handle, nil, nil);
  end;
end;

{-------------------------------------------------------------------------------}
function TSQLiteDatabase.DoProgress: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace('progress', ['cancel', Result]);
  end;
{$ENDIF}

var
  lCancel: Boolean;
begin
  lCancel := False;
  try
    OnProgress(Self, lCancel);
  except
    FDHandleException;
  end;
  if lCancel then
    Result := 1
  else
    Result := 0;
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function FDsqlite3_progress(userdata: Pointer): Integer; cdecl;
begin
  Result := TSQLiteDatabase(userdata).DoProgress();
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.SetOnProgress(const AValue: TSQLiteDatabaseProgressEvent);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_progress_handler, ['db', Handle, 'nOpers', ProgressNOpers,
      'callback', 'FDsqlite3_progress']);
  end;

  procedure Trace2;
  begin
    Trace(ssqlite3_progress_handler, ['db', Handle, 'nOpers', 0, 'callback', 'nil']);
  end;
{$ENDIF}

begin
  ASSERT(Handle <> nil);
  FOnProgress := AValue;
  if Assigned(FOnProgress) then begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Lib.Fsqlite3_progress_handler(Handle, ProgressNOpers, FDsqlite3_progress, Self);
  end
  else begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace2;
{$ENDIF}
    Lib.Fsqlite3_progress_handler(Handle, 0, nil, nil);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.SetProgressNOpers(const AValue: Integer);
begin
  if FProgressNOpers <> AValue then begin
    FProgressNOpers := AValue;
    if Assigned(FOnProgress) then
      SetOnProgress(FOnProgress);
  end;
end;

{-------------------------------------------------------------------------------}
function TSQLiteDatabase.GetTotalChanges: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_total_changes, ['db', Handle, 'Result', Result]);
  end;
{$ENDIF}

begin
  Result := Lib.Fsqlite3_total_changes(Handle);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TSQLiteDatabase.GetLastInsertRowid: sqlite3_int64;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_last_insert_rowid, ['db', Handle, 'Result', Result]);
  end;
{$ENDIF}

begin
  Result := Lib.Fsqlite3_last_insert_rowid(Handle);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.SetLastAutoGenValue(const AValue: Int64);
begin
  FLastAutoGenValue := AValue;
end;

{-------------------------------------------------------------------------------}
function TSQLiteDatabase.GetLastAutoGenValue: Int64;
begin
  if FLastAutoGenValue > 0 then begin
    Result := FLastAutoGenValue;
    FLastAutoGenValue := 0;
  end
  else
    Result := LastInsertRowid;
end;

{-------------------------------------------------------------------------------}
function TSQLiteDatabase.DescribeColumn(const ADBName, ATabName, AColName: String;
  out AType, ACollation: String; out ANotNull, AInPK, AAutoInc: Boolean;
  ARaiseError: Boolean = True): Boolean;
var
  sDBName, sTabName, sColName: TFDByteString;
  pDataType, pCollSeq: PUtf8;
  iCode, iNotNull, iPrimaryKey, iAutoInc: Integer;
begin
  if Assigned(Lib.Fsqlite3_table_column_metadata) then begin
    sDBName := Encoder.Encode(ADBName, ecUTF8);
    sTabName := Encoder.Encode(ATabName, ecUTF8);
    sColName := Encoder.Encode(AColName, ecUTF8);

    iCode := Lib.Fsqlite3_table_column_metadata(Handle, PUtf8(PByte(sDBName)),
      PUtf8(PByte(sTabName)), PUtf8(PByte(sColName)), pDataType,
      pCollSeq, iNotNull, iPrimaryKey, iAutoInc);
    Result := (iCode = SQLITE_OK);
    if Result then begin
      AType := Encoder.Decode(pDataType, -1, ecUTF8);
      ACollation := Encoder.Decode(pCollSeq, -1, ecUTF8);
      if not IsVTab(ATabName, AColName, ANotNull, AInPK, AAutoInc) then begin
        ANotNull := iNotNull <> 0;
        AInPK := iPrimaryKey <> 0;
        AAutoInc := iAutoInc <> 0;
      end;
    end
    else if ARaiseError then
      Check(iCode);
  end
  else
    Result := False;
  if not Result then begin
    AType := '';
    ACollation := '';
    ANotNull := False;
    AInPK := False;
    AAutoInc := False;
  end;
end;

{-------------------------------------------------------------------------------}
function TSQLiteDatabase.GetCacheSize: Integer;
begin
{$IFDEF FireDAC_SQLITE_STATIC}
  Result := ad_sqlite3GetCacheSize(Handle);
{$ELSE}
  Result := 0;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TSQLiteDatabase.GetCharacterSet: String;
begin
{$IFDEF FireDAC_SQLITE_STATIC}
  case ad_sqlite3GetEncoding(Handle) of
  SQLITE_UTF16NATIVE,
  SQLITE_UTF16:       Result := 'UTF16';
  SQLITE_UTF8:        Result := 'UTF8';
  SQLITE_UTF16LE:     Result := 'UTF16-LE';
  SQLITE_UTF16BE:     Result := 'UTF16-BE';
  else                Result := '<unknown>';
  end;
{$ELSE}
  Result := '<unknown>';
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TSQLiteDatabase.GetEncryption: String;
{$IFDEF FireDAC_SQLITE_STATIC}
var
  pName: PFDAnsiString;
  iLen: Integer;
{$ENDIF}
begin
{$IFDEF FireDAC_SQLITE_STATIC}
  if ad_sqlite3GetEncryptionMode(Handle, pName, iLen) = SQLITE_OK then
    Result := Encoder.Decode(pName, iLen, ecANSI)
  else
{$ENDIF}
    Result := '<unencrypted>';
end;

{-------------------------------------------------------------------------------}
function TSQLiteDatabase.DoWal(name: PByte; nPages: Integer): Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace('wal', ['name', name, 'nPages', nPages]);
  end;
{$ENDIF}

begin
  try
    OnWal(Self, Encoder.Decode(name, -1, ecANSI), nPages);
    Result := SQLITE_OK;
  except
    FDHandleException;
    Result := SQLITE_ERROR;
  end;
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function FDsqlite3_wal(userdata: Pointer; db: psqlite3; name: PByte;
  nPages: Integer): Integer; cdecl;
begin
  Result := TSQLiteDatabase(userdata).DoWal(name, nPages);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.SetOnWal(const AValue: TSQLiteDatabaseWalEvent);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_wal_hook, ['db', Handle, 'callback', 'FDsqlite3_wal']);
  end;

  procedure Trace2;
  begin
    Trace(ssqlite3_wal_hook, ['db', Handle, 'callback', 'nil']);
  end;
{$ENDIF}

begin
  ASSERT(Handle <> nil);
  FOnWal := AValue;
  if Assigned(FOnWal) then begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Lib.Fsqlite3_wal_hook(Handle, FDsqlite3_wal, Self);
  end
  else begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace2;
{$ENDIF}
    Lib.Fsqlite3_wal_hook(Handle, nil, nil);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.SetAutoCheckpoint(const AValue: Integer);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_wal_autocheckpoint, ['db', Handle, 'N', AValue]);
  end;
{$ENDIF}

begin
  if FAutoCheckpoint <> AValue then begin
    FAutoCheckpoint := AValue;
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Check(FLib.Fsqlite3_wal_autocheckpoint(Handle, AValue));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.Checkpoint(const ADb: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_wal_checkpoint, ['db', Handle, 'name', ADb]);
  end;
{$ENDIF}

var
  sDB: TFDByteString;
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  sDB := Encoder.Encode(ADb, ecANSI);
  Check(FLib.Fsqlite3_wal_checkpoint(Handle, PFDAnsiString(PByte(sDb))));
end;

{-------------------------------------------------------------------------------}
function TSQLiteDatabase.GetLimits(AId: Integer): Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_limit, ['db', Handle, 'id', AId, 'result', Result]);
  end;
{$ENDIF}

begin
  if Assigned(FLib.Fsqlite3_limit) then begin
    Result := FLib.Fsqlite3_limit(Handle, AId, -1);
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
  end
  else
    Result := -1;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteDatabase.SetLimits(AId: Integer; const AValue: Integer);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_limit, ['db', Handle, 'id', AId, 'newVal', AValue]);
  end;
{$ENDIF}

begin
  if Assigned(FLib.Fsqlite3_limit) then begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    FLib.Fsqlite3_limit(Handle, AId, AValue);
  end;
end;

{-------------------------------------------------------------------------------}
{ TSQLiteExtension                                                              }
{-------------------------------------------------------------------------------}
constructor TSQLiteExtension.Create(ALib: TSQLiteLib);
begin
  inherited Create;
  FLib := ALib;
  Lib.FExtensions.Add(Self);
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteExtension.Destroy;
begin
  DeinstallAll;
  Lib.FExtensions.Remove(Self);
  FLib := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
class procedure TSQLiteExtension.Register(ALib: TSQLiteLib);
begin
  Create(ALib);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteExtension.InternalDeinstall(ADatabase: TSQLiteDatabase);
var
  i: Integer;
begin
  Lib.FLock.Enter;
  try
    for i := ADatabase.FExtensionInstances.Count - 1 downto 0 do
      if TSQLiteExtensionInstance(ADatabase.FExtensionInstances[i]).Database = ADatabase then
        FDFree(TSQLiteExtensionInstance(ADatabase.FExtensionInstances[i]));
  finally
    Lib.FLock.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteExtension.InstallAll;
begin
  FLib.InstallDatabases(Self);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteExtension.DeinstallAll;
begin
  FLib.DeinstallDatabases(Self);
end;

{-------------------------------------------------------------------------------}
{ TSQLiteExtensionInstance                                                      }
{-------------------------------------------------------------------------------}
constructor TSQLiteExtensionInstance.Create(ADB: TSQLiteDatabase;
  AExt: TSQLiteExtension);
begin
  inherited Create;
  FDatabase := ADB;
  FExtension := AExt;
  FDatabase.FExtensionInstances.Add(Self);
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteExtensionInstance.Destroy;
begin
  FDatabase.FExtensionInstances.Remove(Self);
  FDatabase := nil;
  FExtension := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
{ TSQLiteExtensionManager                                                       }
{-------------------------------------------------------------------------------}
constructor TSQLiteExtensionManager.Create;
begin
  inherited Create;
  FModules := TFDStringList.Create;
  FExtensions := TFDClassList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteExtensionManager.Destroy;
begin
  FDFreeAndNil(FModules);
  FDFreeAndNil(FExtensions);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteExtensionManager.AddModule(const AName: String;
  AClass: TSQLiteVModuleClass);
begin
  FModules.AddPtr(AName, AClass);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteExtensionManager.AddExtension(
  const AClasses: array of TSQLiteExtensionClass);
var
  i: Integer;
begin
  for i := Low(AClasses) to High(AClasses) do
    FExtensions.Add(AClasses[i]);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteExtensionManager.RegisterAll(ALib: TSQLiteLib);
var
  i: Integer;
begin
  for i := 0 to FExtensions.Count - 1 do
    TSQLiteExtensionClass(FExtensions[i]).Register(ALib);
end;

{-------------------------------------------------------------------------------}
{ TSQLiteCollation                                                              }
{-------------------------------------------------------------------------------}
function FDsqlite3_compare(userdata: Pointer; len1: Integer;
  str1: Pointer {utf8/utf16}; len2: Integer; str2: Pointer {utf8/utf16}): Integer; cdecl;
begin
  Result := TSQLiteCollation(userdata).Compare(len1, str1, len2, str2);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteCollation.InternalInstall(ADatabase: TSQLiteDatabase);

{$IFDEF FireDAC_Monitor}
  procedure Trace1;
  begin
    ADatabase.Trace(ssqlite3_create_collation, ['db', ADatabase.Handle,
      'zName', Name, 'eTextRep', Encoding, 'callback', 'FDsqlite3_compare']);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_Monitor}
  if ADatabase.Tracing then Trace1;
{$ENDIF}
  ADatabase.Check(Lib.Fsqlite3_create_collation(ADatabase.Handle,
    PByte(ADatabase.Encoder.Encode(Name + #0)), Encoding,
    Self, FDsqlite3_compare));
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteCollation.InternalDeinstall(ADatabase: TSQLiteDatabase);

{$IFDEF FireDAC_Monitor}
  procedure Trace1;
  begin
    ADatabase.Trace(ssqlite3_create_collation, ['db', ADatabase.Handle,
      'zName', Name, 'eTextRep', Encoding, 'callback', 'nil']);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_Monitor}
  if ADatabase.Tracing then Trace1;
{$ENDIF}
  ADatabase.Check(Lib.Fsqlite3_create_collation(ADatabase.Handle,
    PByte(ADatabase.Encoder.Encode(Name + #0)), Encoding,
    Self, nil));
end;

{-------------------------------------------------------------------------------}
function TSQLiteCollation.Compare(len1: Integer; str1: Pointer; len2: Integer;
  str2: Pointer): Integer;
begin
  Result := 0;
  if Assigned(FOnCompare) then
    FOnCompare(FOwningObj, len1, str1, len2, str2, Result)
  else
    ASSERT(False);
end;

{-------------------------------------------------------------------------------}
{ TSQLiteCollationCompareString                                                 }
{-------------------------------------------------------------------------------}
constructor TSQLiteCollationCompareString.Create(ALib: TSQLiteLib);
begin
  inherited Create(ALib);
  FEncoding := SQLITE_UTF16;
  FLocaleID := TLocaleID(LOCALE_USER_DEFAULT);
  FFlags := 0;
end;

{-------------------------------------------------------------------------------}
function TSQLiteCollationCompareString.GetLocaleID: TLocaleID;
begin
  Result := FLocaleID;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteCollationCompareString.SetLocaleID(const AValue: TLocaleID);
begin
  FLocaleID := AValue;
end;

{-------------------------------------------------------------------------------}
function TSQLiteCollationCompareString.Compare(len1: Integer; str1: Pointer;
  len2: Integer; str2: Pointer): Integer;
{$IFDEF MACOS}
var
  StringRef1: CFStringRef;
  StringRef2: CFStringRef;
{$ENDIF}
{$IFDEF ANDROID}
var
  eErrorCode: UErrorCode;
  pColl: PUCollator;
  p, p2: Pointer;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  case CompareStringW(LocaleID, Flags,
                      PWideChar(str1), len1 div SizeOf(WideChar),
                      PWideChar(str2), len2 div SizeOf(WideChar)) of
  CSTR_LESS_THAN:    Result := -1;
  CSTR_EQUAL:        Result := 0;
  CSTR_GREATER_THAN: Result := 1;
  else               Result := 0;
  end;
{$ENDIF}
{$IFDEF MACOS}
  StringRef1 := CFStringCreateWithCharacters(kCFAllocatorDefault, str1,
    len1 div SizeOf(WideChar));
  StringRef2 := CFStringCreateWithCharacters(kCFAllocatorDefault, str2,
    len2 div SizeOf(WideChar));
  if (StringRef1 <> nil) and (StringRef2 <> nil) then
    Result := CFStringCompareWithOptionsAndLocale(StringRef1, StringRef2,
      CFRangeMake(0, len1 div SizeOf(WideChar)), Flags, LocaleID)
  else
    Result := -1;
  if StringRef1 <> nil then
    CFRelease(StringRef1);
  if StringRef2 <> nil then
    CFRelease(StringRef2);
{$ENDIF}
{$IFDEF ANDROID}
  Result := -1;
  len1 := len1 div SizeOf(WideChar);
  len2 := len2 div SizeOf(WideChar);

  if Flags <> 0 then begin
    GetMem(p, (len1 + 1) * SizeOf(WideChar));

    eErrorCode := U_ZERO_ERROR;
    u_strToUpper(p, len1 + 1, str1, len1, LocaleID, eErrorCode);

    if eErrorCode = U_ZERO_ERROR then begin
      GetMem(p2, (len2 + 1) * SizeOf(WideChar));
      u_strToUpper(p2, len2 + 1, str2, len2, LocaleID, eErrorCode);
    end;

    if eErrorCode = U_ZERO_ERROR then begin
      pColl := ucol_open(LocaleID, eErrorCode);
      if pColl <> nil then begin
        Result := Integer(ucol_strcoll(pColl, p, len1, p2, len2));
        ucol_close(pColl);
      end;
    end;

    FreeMem(p);
    FreeMem(p2);
  end
  else if eErrorCode = U_ZERO_ERROR then begin
    pColl := ucol_open(LocaleID, eErrorCode);
    if pColl <> nil then begin
      Result := Integer(ucol_strcoll(pColl, str1, len1, str2, len2));
      ucol_close(pColl);
    end;
  end;
{$ENDIF}
{$IFDEF LINUX}
  Result := -1;
                                                                              
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
{ TSQLiteBLOB                                                                   }
{-------------------------------------------------------------------------------}
constructor TSQLiteBLOB.Create(ADB: TSQLiteDatabase; const ADBAlias, ATable,
  AColumn: String; ARowID: sqlite3_int64; AReadWrite: Boolean);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_blob_open, ['db', ADB.Handle, 'zDb', ADBAlias, 'zTable',
      ATable, 'zColumn', AColumn, 'iRow', ARowID, 'flags', AReadWrite]);
  end;
{$ENDIF}

var
  sDBAlias, sTabName, sColName: TFDByteString;
  pDBAlias: PByte;
begin
  inherited Create;
  FLib := ADB.Lib;
  FDatabase := ADB;
  if not Assigned(Lib.Fsqlite3_blob_open) then
    FDCapabilityNotSupported(nil, [S_FD_LPhys, S_FD_SQLiteId, 'sqlite3']);
  if ADBAlias = '' then
    pDBAlias := nil
  else begin
    sDBAlias := Database.Encoder.Encode(ADBAlias, ecUTF8);
    pDBAlias := PByte(sDBAlias);
  end;
  sTabName := Database.Encoder.Encode(ATable, ecUTF8);
  sColName := Database.Encoder.Encode(AColumn, ecUTF8);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Database.Check(Lib.Fsqlite3_blob_open(ADB.Handle, PUtf8(pDBAlias),
    PUtf8(PByte(sTabName)), PUtf8(PByte(sColName)),
    ARowID, Integer(AReadWrite), FHandle));
  FPosition := 0;
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteBLOB.Destroy;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_blob_close, ['blob', Handle]);
  end;
{$ENDIF}

var
  iErrCode: Integer;
begin
  if Handle <> nil then begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    iErrCode := Lib.Fsqlite3_blob_close(Handle);
    FHandle := nil;
    Database.Check(iErrCode);
  end;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TSQLiteBLOB.GetSize: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_blob_bytes, ['blob', Handle, 'Result', Result]);
  end;
{$ENDIF}

begin
  Result := Lib.Fsqlite3_blob_bytes(Handle);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteBLOB.Read(var AData; ASize: Integer);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_blob_read, ['blob', Handle, 'Z', @AData, 'N', ASize, 'iOffset', Position]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Database.Check(Lib.Fsqlite3_blob_read(Handle, @AData, ASize, Position));
  Inc(FPosition, ASize);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteBLOB.Write(const AData; ASize: Integer);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_blob_write, ['blob', Handle, 'Z', @AData, 'N', ASize, 'iOffset', Position]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Database.Check(Lib.Fsqlite3_blob_write(Handle, @AData, ASize, Position));
  Inc(FPosition, ASize);
end;

{-------------------------------------------------------------------------------}
{ TSQLiteValueDef                                                               }
{-------------------------------------------------------------------------------}
constructor TSQLiteValueDef.CreateForColumn(AStmt: TSQLiteStatement; AIndex: Integer);
var
  pColName, pTabName, pDBName: PByte;
  sType: String;
  oLib: TSQLiteLib;
  oDB: TSQLiteDatabase;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FStmt.Trace('sqlite3_column_xxx', [
      'stmt', FStmt.Handle, '@type', C_IntTypeNames[FIntDataType], 'name', FName,
      'db_name', FDBName, 'tab_name', FTabName, 'orig_name', FColName,
      'decltype', FTypeName, 'collseq', FCollationName, 'NotNull', FNotNull,
      'InPK', FInPrimaryKey, 'AutoInc', FAutoInc]);
  end;
{$ENDIF}

begin
  inherited Create;
  FIndex := AIndex;
  FStmt := AStmt;
  oDb := FStmt.Database;
  oLib := FStmt.Lib;
  FName := oDB.APIStrToDlpStr(oLib.Fsqlite3_column_name(AStmt.Handle, AIndex));
  FTypeName := oDB.APIStrToDlpStr(oLib.Fsqlite3_column_decltype(AStmt.Handle, AIndex));
  FIntDataType := oLib.Fsqlite3_column_type(AStmt.Handle, AIndex);
  if (FTypeName = '') and (FIntDataType <> SQLITE_NULL) then
    case FIntDataType of
    SQLITE_INTEGER: FTypeName := 'INT64';
    SQLITE_FLOAT:   FTypeName := 'REAL';
    SQLITE_TEXT:    FTypeName := 'NVARCHAR(' + IntToStr(FStmt.MaxStringSize) + ')';
    SQLITE_BLOB:    FTypeName := 'BLOB';
    end;

  FDBName := '';
  FTabName := '';
  FColName := '';
  FNotNull := False;
  FInPrimaryKey := False;
  FAutoInc := False;
  FCollationName := '';

  if Assigned(oLib.Fsqlite3_column_database_name) then begin
    pDBName := oLib.Fsqlite3_column_database_name(AStmt.Handle, AIndex);
    FDBName := oDB.APIStrToDlpStr(pDBName);

    pTabName := oLib.Fsqlite3_column_table_name(AStmt.Handle, AIndex);
    FTabName := oDB.APIStrToDlpStr(pTabName);

    pColName := oLib.Fsqlite3_column_origin_name(AStmt.Handle, AIndex);
    FColName := oDB.APIStrToDlpStr(pColName);

    if FStmt.UseColumnMetadata and
       (pColName <> nil) or (pTabName <> nil) or (pDBName <> nil) then
      oDB.DescribeColumn(FDBName, FTabName, FColName, sType, FCollationName,
        FNotNull, FInPrimaryKey, FAutoInc);
  end;
{$IFDEF FireDAC_MONITOR}
  if FStmt.Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
constructor TSQLiteValueDef.CreateForParam(AStmt: TSQLiteStatement;
  AIndex: Integer; ADummy: Integer);
var
  pUtf8Name: Pointer;
  oLib: TSQLiteLib;
  oDB: TSQLiteDatabase;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FStmt.Trace('sqlite3_bind_parameter_name', ['stmt', FStmt.Handle, 'name', FName]);
  end;
{$ENDIF}

begin
  inherited Create;
  FIndex := AIndex;
  FStmt := AStmt;
  oDb := FStmt.Database;
  oLib := FStmt.Lib;
  pUtf8Name := oLib.Fsqlite3_bind_parameter_name(AStmt.Handle, AIndex + 1);
  if pUtf8Name <> nil then
    FName := oDb.Encoder.Decode(pUtf8Name, -1, ecUTF8);
{$IFDEF FireDAC_MONITOR}
  if FStmt.Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
{ TSQLiteValue                                                                  }
{-------------------------------------------------------------------------------}
constructor TSQLiteValue.Create(ADatabase: TSQLiteDatabase);
begin
  inherited Create;
  FDatabase := ADatabase;
end;

{-------------------------------------------------------------------------------}
function TSQLiteValue.InternalGetData(var AValue: Pointer; var ASize: Integer;
  var AIntDataType: Integer): Boolean;
begin
  AValue := nil;
  ASize := 0;
  Result := False;
  ASSERT(False);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteValue.InternalSetData(AValue: Pointer; ASize: Integer;
  AIntDataType: Integer);
begin
  ASSERT(False);
end;

{-------------------------------------------------------------------------------}
function TSQLiteValue.GetData(var AValue: Pointer; var ASize: Integer;
  AByRef: Boolean = False; AExtDataType: TSQLiteExtDataType = etUnknown): Boolean;
var
  pVal: Pointer;
  iSize: Integer;
  iType: Integer;
  wYear, wMonth, wDay, wHour, wMin, wSec, wwMSec: Word;
  lwMSec: Cardinal;
  dVal: Double;
  iVal: Int64;
  aBuff: array[0..15] of Byte;

  function ParseDate: Boolean;
  begin
    if ((PChar(pVal) + 4)^ = '-') and ((PChar(pVal) + 7)^ = '-') then begin
      FDStr2Int(PChar(pVal),     4, @wYear, SizeOf(Word), True);
      FDStr2Int(PChar(pVal) + 5, 2, @wMonth, SizeOf(Word), True);
      FDStr2Int(PChar(pVal) + 8, 2, @wDay, SizeOf(Word), True);
      Dec(iSize, 10);
      Result := True;
    end
    else if ((PChar(pVal) + 2)^ = '.') and ((PChar(pVal) + 5)^ = '.') then begin
      FDStr2Int(PChar(pVal),     2, @wDay, SizeOf(Word), True);
      FDStr2Int(PChar(pVal) + 3, 2, @wMonth, SizeOf(Word), True);
      FDStr2Int(PChar(pVal) + 6, 4, @wYear, SizeOf(Word), True);
      Dec(iSize, 10);
      Result := True;
    end
    else
      Result := False;
  end;

  function ParseTime: Boolean;
  var
    iMSecSize: Integer;
  begin
    if (PChar(pVal) + 2)^ = ':' then begin
      // HH:MM:[SS[.FFF]] or HH:MM:[SS[.FF]] or HH:MM:[SS[.F]]
      Result := True;
      FDStr2Int(PChar(pVal),     2, @wHour, SizeOf(Word), True);
      FDStr2Int(PChar(pVal) + 3, 2, @wMin, SizeOf(Word), True);
      if (PChar(pVal) + 5)^ = ':' then begin
        FDStr2Int(PChar(pVal) + 6, 2, @wSec, SizeOf(Word), True);
        Dec(iSize, 8);
        if (PChar(pVal) + 8)^ = '.' then begin
          iMSecSize := iSize - 1;
          // Limit fractional part by maximum 3 digits to fit into MSec
          if iMSecSize > 3 then
            iMSecSize := 3;
          FDStr2Int(PChar(pVal) + 9, iMSecSize, @lwMSec, SizeOf(Cardinal), True);
        end;
      end;
    end
    else
      Result := False;
  end;

  function ParseDouble: Boolean;
  var
    pFS: PFDFormatSettings;
    E: Extended;
  begin
    pFS := @GCachedNumFS;
    pFS^.DecimalSeparator := '.';
    Result := TextToFloat(PChar(pVal), E, fvExtended, pFS^);
    if Result then
      dVal := E;
  end;

begin
  if AExtDataType = etUnknown then
    AExtDataType := ExtDataType;
  iType := C_EDT2IDT[AExtDataType];
  // for int's and float's pVal must be set to buffer
  pVal := @aBuff[0];
  Result := InternalGetData(pVal, iSize, iType);
  if (pVal = nil) and (iSize = 0) then begin
    if AByRef then
      AValue := nil;
    ASize := 0;
  end
  else
    case AExtDataType of
    etString:
      if Database.Encoder.Encoding = ecANSI then begin
        ASize := iSize;
        AValue := pVal;
      end
      else begin
        if AByRef then
          AValue := nil;
        ASize := Database.Encoder.Decode(pVal, iSize, AValue, ecANSI);
      end;
    etUString:
      if Database.Encoder.Encoding = ecUTF16 then begin
        ASize := iSize;
        AValue := pVal;
      end
      else begin
        if AByRef then
          AValue := nil;
        ASize := Database.Encoder.Decode(pVal, iSize, AValue, ecUTF16);
      end;
    etInteger:
      begin
        ASize := iSize;
        if AByRef then
          AValue := pVal
        else
          PInt64(AValue)^ := PInt64(pVal)^;
      end;
    etDouble:
      begin
        ASize := iSize;
        if AByRef then
          AValue := pVal
        else
          PDouble(AValue)^ := PDouble(pVal)^;
      end;
    etNumber:
      if AByRef then begin
        AValue := pVal;
        ASize := iSize;
      end
      else begin
        case iType of
        SQLITE_TEXT,
        SQLITE_BLOB:
          FDStr2BCD(PChar(pVal), iSize, PBcd(AValue)^, '.');
        SQLITE_INTEGER:
          FDDouble2BCD(PInt64(pVal)^, PBcd(AValue)^);
        SQLITE_FLOAT:
          FDDouble2BCD(PDouble(pVal)^, PBcd(AValue)^);
        end;
        ASize := SizeOf(TBcd);
      end;
    etCurrency:
      if AByRef then begin
        AValue := pVal;
        ASize := iSize;
      end
      else begin
        case iType of
        SQLITE_TEXT,
        SQLITE_BLOB:
          FDStr2Curr(PChar(pVal), iSize, PCurrency(AValue)^, '.');
        SQLITE_INTEGER:
          PCurrency(AValue)^ := PInt64(pVal)^;
        SQLITE_FLOAT:
          PCurrency(AValue)^ := PDouble(pVal)^;
        end;
        ASize := SizeOf(Currency);
      end;
    etBlob:
      begin
        ASize := iSize;
        if AByRef then
          AValue := pVal
        else
          Move(pVal^, AValue^, ASize);
      end;
    etBoolean:
      if AByRef then begin
        AValue := pVal;
        ASize := iSize;
      end
      else begin
        case iType of
        SQLITE_TEXT,
        SQLITE_BLOB:
          PWordBool(AValue)^ := FDInSet(PChar(pVal)^, ['1', 'y', 'Y', 't', 'T']) or
            (StrIComp(PChar(pVal), PChar('yes')) = 0) or (StrIComp(PChar(pVal), PChar('on')) = 0);
        SQLITE_INTEGER:
          PWordBool(AValue)^ := PInt64(pVal)^ <> 0;
        SQLITE_FLOAT:
          PWordBool(AValue)^ := PDouble(pVal)^ <> 0;
        end;
        ASize := SizeOf(WordBool);
      end;
    etDate:
      if AByRef then begin
        AValue := pVal;
        ASize := iSize;
      end
      else begin
        wYear := 0;
        wMonth := 0;
        wDay := 0;
        case iType of
        SQLITE_TEXT,
        SQLITE_BLOB:
          if ParseDate then
            // nothing
          else if ParseDouble then
            j2date(Trunc(dVal * MSecsPerDay + 0.5), wYear, wMonth, wDay);
        SQLITE_INTEGER,
        SQLITE_FLOAT:
          begin
            if iType = SQLITE_INTEGER then
              dVal := PInt64(pVal)^
            else
              dVal := PDouble(pVal)^;
            if Database.DateTimeFormat = etDateTime then
              DecodeDate(dVal, wYear, wMonth, wDay)
            else
              j2date(Trunc(dVal * MSecsPerDay + 0.5), wYear, wMonth, wDay);
          end;
        end;
        if (wYear <> 0) and (wMonth <> 0) and (wDay <> 0) then
          PInteger(AValue)^ := FDDateTime2Date(EncodeDate(wYear, wMonth, wDay))
        else begin
          PInteger(AValue)^ := 0;
          Result := False;
        end;
        ASize := SizeOf(Integer);
      end;
    etTime:
      if AByRef then begin
        AValue := pVal;
        ASize := iSize;
      end
      else begin
        wHour := $FF;
        wMin := 0;
        wSec := 0;
        lwMSec := 0;
        case iType of
        SQLITE_TEXT,
        SQLITE_BLOB:
          if ParseTime then
            // nothing
          else if ParseDouble then
            j2time(Trunc(dVal * MSecsPerDay + 0.5), wHour, wMin, wSec, lwMSec);
        SQLITE_INTEGER,
        SQLITE_FLOAT:
          begin
            if iType = SQLITE_INTEGER then
              dVal := PInt64(pVal)^
            else
              dVal := PDouble(pVal)^;
            if Database.DateTimeFormat = etDateTime then begin
              DecodeTime(dVal, wHour, wMin, wSec, wwMSec);
              lwMSec := wwMSec;
            end
            else
              j2time(Trunc(dVal * MSecsPerDay + 0.5), wHour, wMin, wSec, lwMSec);
          end;
        end;
        if wHour <> $FF then
          PInteger(AValue)^ := FDDateTime2Time(EncodeTime(wHour, wMin, wSec, lwMSec))
        else begin
          PInteger(AValue)^ := 0;
          Result := False;
        end;
        ASize := SizeOf(Integer);
      end;
    etDateTime:
      if AByRef then begin
        AValue := pVal;
        ASize := iSize;
      end
      else begin
        wYear := 0;
        wMonth := 0;
        wDay := 0;
        wHour := 0;
        wMin := 0;
        wSec := 0;
        lwMSec := 0;
        case iType of
        SQLITE_TEXT,
        SQLITE_BLOB:
          if ParseDate then begin
            if iSize > 0 then begin
              PChar(pVal) := PChar(pVal) + 10;
              while (PChar(pVal)^ = ' ') or (PChar(pVal)^ = 'T') or (PChar(pVal)^ = 't') do
                PChar(pVal) := PChar(pVal) + 1;
              Dec(iSize, 1);
              ParseTime;
            end;
          end
          else if ParseDouble then begin
            iVal := Trunc(dVal * MSecsPerDay + 0.5);
            j2date(iVal, wYear, wMonth, wDay);
            j2time(iVal, wHour, wMin, wSec, lwMSec);
          end;
        SQLITE_INTEGER,
        SQLITE_FLOAT:
          begin
            if iType = SQLITE_INTEGER then
              dVal := PInt64(pVal)^
            else
              dVal := PDouble(pVal)^;
            if Database.DateTimeFormat = etDateTime then begin
              DecodeDate(dVal, wYear, wMonth, wDay);
              DecodeTime(dVal, wHour, wMin, wSec, wwMSec);
              lwMSec := wwMSec;
            end
            else begin
              iVal := Trunc(dVal * MSecsPerDay + 0.5);
              j2date(iVal, wYear, wMonth, wDay);
              j2time(iVal, wHour, wMin, wSec, lwMSec);
            end;
          end;
        end;
        if (wYear <> 0) and (wMonth <> 0) and (wDay <> 0) then begin
          PSQLTimeStamp(AValue)^.Year := wYear;
          PSQLTimeStamp(AValue)^.Month := wMonth;
          PSQLTimeStamp(AValue)^.Day := wDay;
          PSQLTimeStamp(AValue)^.Hour := wHour;
          PSQLTimeStamp(AValue)^.Minute := wMin;
          PSQLTimeStamp(AValue)^.Second := wSec;
          PSQLTimeStamp(AValue)^.Fractions := lwMSec;
        end
        else begin
          FillChar(PSQLTimeStamp(AValue)^, SizeOf(TSQLTimeStamp), 0);
          Result := False;
        end;
        ASize := SizeOf(TSQLTimeStamp);
      end;
    end;
end;

{-------------------------------------------------------------------------------}
function TSQLiteValue.GetIsNull: Boolean;
var
  pVal: Pointer;
  iSize: Integer;
  iType: Integer;
begin
  iType := SQLITE_NULL;
  pVal := nil;
  Result := not InternalGetData(pVal, iSize, iType);
end;

{-------------------------------------------------------------------------------}
function TSQLiteValue.GetAnsiString: TFDAnsiString;
var
  pVal: Pointer;
  iSize: Integer;
begin
  Result := '';
  if GetData(pVal, iSize, True, etUString) then
    Result := TFDAnsiString(Database.Encoder.Decode(pVal, iSize, ecUTF16));
end;

{-------------------------------------------------------------------------------}
function TSQLiteValue.GetWideString: UnicodeString;
var
  pVal: Pointer;
  iSize: Integer;
begin
  Result := '';
  if GetData(pVal, iSize, True, etUString) then
    SetString(Result, PWideChar(pVal), iSize);
end;

{-------------------------------------------------------------------------------}
function TSQLiteValue.GetAsString: String;
begin
  Result := AsWideString;
end;

{-------------------------------------------------------------------------------}
function TSQLiteValue.GetBoolean: WordBool;
var
  pVal: Pointer;
  iSize: Integer;
begin
  Result := False;
  pVal := @Result;
  GetData(pVal, iSize, False, etBoolean);
end;

{-------------------------------------------------------------------------------}
function TSQLiteValue.GetCurrency: Currency;
var
  pVal: Pointer;
  iSize: Integer;
begin
  Result := 0.0;
  pVal := @Result;
  GetData(pVal, iSize, False, etCurrency);
end;

{-------------------------------------------------------------------------------}
function TSQLiteValue.GetDate: TDateTime;
var
  pVal: Pointer;
  iSize: Integer;
  iVal: Integer;
begin
  Result := 0.0;
  pVal := @iVal;
  if GetData(pVal, iSize, False, etDate) then
    Result := FDDate2DateTime(iVal);
end;

{-------------------------------------------------------------------------------}
function TSQLiteValue.GetTime: TDateTime;
var
  pVal: Pointer;
  iSize: Integer;
  iVal: Integer;
begin
  Result := 0.0;
  pVal := @iVal;
  if GetData(pVal, iSize, False, etTime) then
    Result := FDTime2DateTime(iVal);
end;

{-------------------------------------------------------------------------------}
function TSQLiteValue.GetDateTime: TDateTime;
var
  pVal: Pointer;
  iSize: Integer;
  rVal: TSQLTimeStamp;
begin
  Result := 0.0;
  pVal := @rVal;
  if GetData(pVal, iSize, False, etDateTime) then
    Result := SQLTimeStampToDateTime(rVal);
end;

{-------------------------------------------------------------------------------}
function TSQLiteValue.GetFloat: Double;
var
  pVal: Pointer;
  iSize: Integer;
begin
  Result := 0.0;
  pVal := @Result;
  GetData(pVal, iSize, False, etDouble);
end;

{-------------------------------------------------------------------------------}
function TSQLiteValue.GetInteger: Int64;
var
  pVal: Pointer;
  iSize: Integer;
begin
  Result := 0;
  pVal := @Result;
  GetData(pVal, iSize, False, etInteger);
end;

{-------------------------------------------------------------------------------}
function TSQLiteValue.GetNumber: TBcd;
var
  pVal: Pointer;
  iSize: Integer;
begin
  Result := NullBcd;
  pVal := @Result;
  GetData(pVal, iSize, False, etNumber);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteValue.SetData(AValue: Pointer; ASize: Integer;
  AExtDataType: TSQLiteExtDataType = etUnknown);
const
  SDateFmt: String = '%.4d-%.2d-%.2d';
  STimeFmt: String = '%.2d:%.2d:%.2d.%.3d';
  SDateTimeFmt: String = '%.4d-%.2d-%.2d %.2d:%.2d:%.2d.%.3d';
var
  pVal: Pointer;
  iSize: Integer;
  iType: Integer;
  lDate, lTime: Boolean;
  rTS: TSQLTimeStamp;
  pTS: PSQLTimeStamp;
begin
  if AExtDataType = etUnknown then
    AExtDataType := ExtDataType;
  iType := C_EDT2IDT[AExtDataType];
  if (AValue = nil) and (ASize = 0) then begin
    pVal := nil;
    iSize := 0;
  end
  else
    case AExtDataType of
    etString:
      if Database.Encoder.Encoding = ecANSI then begin
        iSize := ASize;
        pVal := AValue;
      end
      else begin
        pVal := nil;
        iSize := Database.Encoder.Encode(AValue, ASize, pVal, ecANSI);
      end;
    etUString:
      if Database.Encoder.Encoding = ecUTF16 then begin
        iSize := ASize;
        pVal := AValue;
      end
      else begin
        pVal := nil;
        iSize := Database.Encoder.Encode(AValue, ASize, pVal, ecUTF16);
      end;
    etNumber:
      begin
        pVal := Database.Buffer.Check(C_FD_MaxFixedSize);
        FDBCD2Str(PChar(pVal), iSize, PBcd(AValue)^, '.');
        iType := SQLITE_TEXT;
      end;
    etCurrency:
      begin
        pVal := Database.Buffer.Check(C_FD_MaxFixedSize);
        FDCurr2Str(PChar(pVal), iSize, PCurrency(AValue)^, '.');
        iType := SQLITE_TEXT;
      end;
    etBoolean:
      begin
        pVal := Database.Buffer.Check(C_FD_MaxFixedSize);
        if PWordBool(AValue)^ then
          PInt64(pVal)^ := 1
        else
          PInt64(pVal)^ := 0;
        iSize := SizeOf(Int64);
        iType := SQLITE_INTEGER;
      end;
    etDate:
      begin
        pVal := Database.Buffer.Check(C_FD_MaxFixedSize);
        case Database.DateTimeFormat of
        etString:
          begin
            rTS := FDDate2SQLTimeStamp(PInteger(AValue)^);
            iSize := WideFormatBuf(PChar(pVal)^, C_FD_MaxFixedSize div SizeOf(Char),
              PChar(SDateFmt)^, Length(SDateFmt), [rTS.Year, rTS.Month, rTS.Day]);
            iType := SQLITE_TEXT;
          end;
        etInteger:
          begin
            rTS := FDDate2SQLTimeStamp(PInteger(AValue)^);
            iSize := SizeOf(Double);
            PDouble(pVal)^ := date2j(rTS.Year, rTS.Month, rTS.Day) / MSecsPerDay;
            iType := SQLITE_FLOAT;
          end;
        etDateTime:
          begin
            iSize := SizeOf(Double);
            PDouble(pVal)^ := FDDate2DateTime(PInteger(AValue)^);
            iType := SQLITE_FLOAT;
          end;
        end;
      end;
    etTime:
      begin
        pVal := Database.Buffer.Check(C_FD_MaxFixedSize);
        case Database.DateTimeFormat of
        etString:
          begin
            rTS := FDTime2SQLTimeStamp(PInteger(AValue)^);
            iSize := WideFormatBuf(PChar(pVal)^, C_FD_MaxFixedSize div SizeOf(Char),
              PChar(STimeFmt)^, Length(STimeFmt), [rTS.Hour, rTS.Minute, rTS.Second, rTS.Fractions]);
            iType := SQLITE_TEXT;
          end;
        etInteger:
          begin
            rTS := FDTime2SQLTimeStamp(PInteger(AValue)^);
            iSize := SizeOf(Double);
            PDouble(pVal)^ := (C_TimeBase + time2j(rTS.Hour, rTS.Minute,
              rTS.Second, rTS.Fractions)) / MSecsPerDay;
            iType := SQLITE_FLOAT;
          end;
        etDateTime:
          begin
            iSize := SizeOf(Double);
            PDouble(pVal)^ := FDTime2DateTime(PInteger(AValue)^);
            iType := SQLITE_FLOAT;
          end;
        end;
      end;
    etDateTime:
      begin
        pTS := PSQLTimeStamp(AValue);
        lDate := (pTS^.Year <> 0) or (pTS^.Month <> 0) or (pTS^.Day <> 0);
        lTime := (pTS^.Hour <> 0) or (pTS^.Minute <> 0) or (pTS^.Second <> 0) or
          (pTS^.Fractions <> 0);
        if not lDate and not ltime then begin
          pVal := nil;
          iSize := 0;
        end
        else begin
          pVal := Database.Buffer.Check(C_FD_MaxFixedSize);
          case Database.DateTimeFormat of
          etString:
            begin
              if lDate and not lTime then
                iSize := WideFormatBuf(PChar(pVal)^, C_FD_MaxFixedSize div SizeOf(Char),
                  PChar(SDateFmt)^, Length(SDateFmt), [pTS^.Year, pTS^.Month, pTS^.Day])
              else if not lDate and lTime then
                iSize := WideFormatBuf(PChar(pVal)^, C_FD_MaxFixedSize div SizeOf(Char),
                  PChar(STimeFmt)^, Length(STimeFmt), [pTS^.Hour, pTS^.Minute, pTS^.Second, pTS^.Fractions])
              else
                iSize := WideFormatBuf(PChar(pVal)^, C_FD_MaxFixedSize div SizeOf(Char),
                  PChar(SDateTimeFmt)^, Length(SDateTimeFmt), [pTS^.Year, pTS^.Month, pTS^.Day,
                    pTS^.Hour, pTS^.Minute, pTS^.Second, pTS^.Fractions]);
              iType := SQLITE_TEXT;
            end;
          etInteger:
            begin
              iSize := SizeOf(Double);
              if lDate then
                PDouble(pVal)^ := date2j(pTS^.Year, pTS^.Month, pTS^.Day) / MSecsPerDay
              else
                PDouble(pVal)^ := C_TimeBase / MSecsPerDay;
              if lTime then
                PDouble(pVal)^ := PDouble(pVal)^ + time2j(pTS^.Hour, pTS^.Minute,
                  pTS^.Second, pTS^.Fractions) / MSecsPerDay;
              iType := SQLITE_FLOAT;
            end;
          etDateTime:
            begin
              iSize := SizeOf(Double);
              PDouble(pVal)^ := SQLTimeStampToDateTime(PSQLTimeStamp(AValue)^);
              iType := SQLITE_FLOAT;
            end;
          end;
        end;
      end;
    etInteger,
    etDouble,
    etBlob:
      begin
        pVal := AValue;
        iSize := ASize;
      end;
    end;
  InternalSetData(pVal, iSize, iType);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteValue.Clear;
begin
  SetData(nil, 0);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteValue.SetAnsiString(const AValue: TFDAnsiString);
var
  sb: TFDByteString;
begin
  sb := Database.Encoder.Encode(String(AValue), ecANSI);
  SetData(PByte(sb), Database.Encoder.EncodedLength(sb, ecANSI), etString);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteValue.SetWideString(const AValue: UnicodeString);
begin
  SetData(PWideChar(AValue), Length(AValue), etUString);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteValue.SetAsString(const AValue: String);
begin
  AsWideString := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteValue.SetBoolean(const AValue: WordBool);
begin
  SetData(@AValue, SizeOf(AValue), etBoolean);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteValue.SetCurrency(const AValue: Currency);
begin
  SetData(@AValue, SizeOf(AValue), etCurrency);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteValue.SetDate(const AValue: TDateTime);
var
  iDate: Integer;
begin
  iDate := FDDateTime2Date(AValue);
  SetData(@iDate, SizeOf(iDate), etDate);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteValue.SetTime(const AValue: TDateTime);
var
  iTime: Integer;
begin
  iTime := FDDateTime2Time(AValue);
  SetData(@iTime, SizeOf(iTime), etTime);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteValue.SetDateTime(const AValue: TDateTime);
var
  rDT: TSQLTimeStamp;
begin
  rDT := DateTimeToSQLTimeStamp(AValue);
  SetData(@rDT, SizeOf(rDT), etDateTime);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteValue.SetFloat(const AValue: Double);
begin
  SetData(@AValue, SizeOf(AValue), etDouble);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteValue.SetInteger(const AValue: Int64);
begin
  SetData(@AValue, SizeOf(AValue), etInteger);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteValue.SetNumber(const AValue: TBcd);
begin
  SetData(@AValue, SizeOf(AValue), etNumber);
end;

{-------------------------------------------------------------------------------}
{ TSQLiteStmtVar                                                                }
{-------------------------------------------------------------------------------}
constructor TSQLiteStmtVar.Create(AVars: TSQLiteVariables);
begin
  inherited Create(AVars.FStmt.Database);
  FStmt := AVars.FStmt;
  FIndex := AVars.FList.Add(Self);
end;

{-------------------------------------------------------------------------------}
{ TSQLiteBind                                                                   }
{-------------------------------------------------------------------------------}
procedure TSQLiteBind.InternalSetData(AValue: Pointer; ASize: Integer;
  AIntDataType: Integer);
var
  iInd: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FStmt.Trace(ssqlite3_bind_zeroblob, ['stmt', FStmt.Handle, 'iCol', iInd,
      'ASize', ASize]);
  end;

  procedure Trace2;
  begin
    FStmt.Trace(ssqlite3_bind_null, ['stmt', FStmt.Handle, 'iCol', iInd]);
  end;

  procedure Trace3;
  begin
    FStmt.Trace(ssqlite3_bind_blob, ['stmt', FStmt.Handle, 'iCol', iInd,
      'bytes', ASize]);
  end;

  procedure Trace4;
  begin
    FStmt.Trace(ssqlite3_bind_double, ['stmt', FStmt.Handle, 'iCol', iInd,
      'value', PDouble(AValue)^]);
  end;

  procedure Trace5;
  begin
    FStmt.Trace(ssqlite3_bind_int64, ['stmt', FStmt.Handle, 'iCol', iInd,
      'value', PInt64(AValue)^]);
  end;

  procedure Trace6;
  begin
    FStmt.Trace(ssqlite3_bind_text, ['stmt', FStmt.Handle, 'iCol', iInd,
      'ASize', ASize]);
  end;
{$ENDIF}

begin
  iInd := Index + 1;
  if (AValue = nil) or (AIntDataType = SQLITE_NULL) then
    if (AIntDataType = SQLITE_BLOB) and (ASize <> 0) then begin
{$IFDEF FireDAC_MONITOR}
      if FStmt.Tracing then Trace1;
{$ENDIF}
      FStmt.Check(FStmt.Lib.Fsqlite3_bind_zeroblob(FStmt.Handle, iInd, ASize));
    end
    else begin
{$IFDEF FireDAC_MONITOR}
      if FStmt.Tracing then Trace2;
{$ENDIF}
      FStmt.Check(FStmt.Lib.Fsqlite3_bind_null(FStmt.Handle, iInd));
    end
  else
    case AIntDataType of
    SQLITE_BLOB:
      begin
{$IFDEF FireDAC_MONITOR}
        if FStmt.Tracing then Trace3;
{$ENDIF}
        FStmt.Check(FStmt.Lib.Fsqlite3_bind_blob(FStmt.Handle, iInd, AValue,
          ASize, SQLITE_TRANSIENT));
      end;
    SQLITE_FLOAT:
      begin
{$IFDEF FireDAC_MONITOR}
        if FStmt.Tracing then Trace4;
{$ENDIF}
        FStmt.Check(FStmt.Lib.Fsqlite3_bind_double(FStmt.Handle, iInd, PDouble(AValue)^));
      end;
    SQLITE_INTEGER:
      begin
{$IFDEF FireDAC_MONITOR}
        if FStmt.Tracing then Trace5;
{$ENDIF}
        FStmt.Check(FStmt.Lib.Fsqlite3_bind_int64(FStmt.Handle, iInd, PInt64(AValue)^));
      end;
    SQLITE_TEXT:
      begin
        if FStmt.StrsTrim then
          while (ASize > 0) and (PChar(AValue)[ASize - 1] <= ' ') do
            Dec(ASize);
        if FStmt.StrsEmpty2Null and (ASize = 0) then
          InternalSetData(nil, 0, AIntDataType)
        else begin
{$IFDEF FireDAC_MONITOR}
          if FStmt.Tracing then Trace6;
{$ENDIF}
          FStmt.Check(FStmt.Lib.Fsqlite3_bind_text(FStmt.Handle, iInd, PByte(AValue),
            ASize * SizeOf(Char), SQLITE_TRANSIENT));
        end;
      end;
    end;
end;

{-------------------------------------------------------------------------------}
{ TSQLiteColumn                                                                 }
{-------------------------------------------------------------------------------}
function TSQLiteColumn.InternalGetData(var AValue: Pointer; var ASize: Integer;
  var AIntDataType: Integer): Boolean;
var
  iType: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FStmt.Trace(ssqlite3_column_type, ['stmt', FStmt.Handle, 'iCol', Index,
      '@Result', C_IntTypeNames[iType]]);
  end;

  procedure Trace2;
  begin
    FStmt.Trace(ssqlite3_column_blob, ['stmt', FStmt.Handle, 'iCol', Index,
      'bytes', ASize]);
  end;

  procedure Trace3;
  begin
    FStmt.Trace(ssqlite3_column_double, ['stmt', FStmt.Handle, 'iCol', Index,
      'AValue^', PDouble(AValue)^]);
  end;

  procedure Trace4;
  begin
    FStmt.Trace(ssqlite3_column_int64, ['stmt', FStmt.Handle, 'iCol', Index,
      'AValue^', PInt64(AValue)^]);
  end;

  procedure Trace5;
  begin
    FStmt.Trace(ssqlite3_column_text, ['stmt', FStmt.Handle, 'iCol', Index,
      'bytes', ASize]);
  end;
{$ENDIF}

begin
  // This call is needed to get, is the column value NULL or else
  iType := FStmt.Lib.Fsqlite3_column_type(FStmt.Handle, Index);
{$IFDEF FireDAC_MONITOR}
  if FStmt.Tracing then Trace1;
{$ENDIF}
  if iType = SQLITE_NULL then begin
    AValue := nil;
    ASize := 0;
    Result := False;
  end
  else begin
    Result := True;
    if AIntDataType = SQLITE_NULL then
      AIntDataType := iType;
    if AValue <> nil then
      case AIntDataType of
      SQLITE_BLOB:
        begin
          AValue := FStmt.Lib.Fsqlite3_column_blob(FStmt.Handle, Index);
          ASize := FStmt.Lib.Fsqlite3_column_bytes_row(FStmt.Handle, Index);
{$IFDEF FireDAC_MONITOR}
          if FStmt.Tracing then Trace2;
{$ENDIF}
        end;
      SQLITE_FLOAT:
        begin
          PDouble(AValue)^ := FStmt.Lib.Fsqlite3_column_double(FStmt.Handle, Index);
          ASize := SizeOf(Double);
{$IFDEF FireDAC_MONITOR}
          if FStmt.Tracing then Trace3;
{$ENDIF}
        end;
      SQLITE_INTEGER:
        begin
          PInt64(AValue)^ := FStmt.Lib.Fsqlite3_column_int64(FStmt.Handle, Index);
          ASize := SizeOf(Int64);
{$IFDEF FireDAC_MONITOR}
          if FStmt.Tracing then Trace4;
{$ENDIF}
        end;
      SQLITE_TEXT:
        begin
          AValue := FStmt.Lib.Fsqlite3_column_text(FStmt.Handle, Index);
          ASize := FStmt.Lib.Fsqlite3_column_bytes(FStmt.Handle, Index) div SizeOf(Char);
{$IFDEF FireDAC_MONITOR}
          if FStmt.Tracing then Trace5;
{$ENDIF}
          if FStmt.StrsTrim then
            while (ASize > 0) and (PChar(AValue)[ASize - 1] <= ' ') do
              Dec(ASize);
          if (ASize = 0) and FStmt.StrsEmpty2Null then begin
            AValue := nil;
            ASize := 0;
            Result := False;
          end
        end;
      end;
  end;
end;

{-------------------------------------------------------------------------------}
{ TSQLiteVariables                                                              }
{-------------------------------------------------------------------------------}
constructor TSQLiteVariables.Create(AStmt: TSQLiteStatement);
begin
  inherited Create;
  FStmt := AStmt;
  FList := TFDObjList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteVariables.Destroy;
begin
  Clear;
  FDFreeAndNil(FList);
  FStmt := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVariables.Add(AVar: TSQLiteStmtVar);
begin
  FList.Add(AVar);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVariables.Clear(ASize: Integer);
var
  i: Integer;
begin
  for i := FList.Count - 1 downto ASize do
    FDFree(TSQLiteStmtVar(FList[i]));
  FList.Count := ASize;
end;

{-------------------------------------------------------------------------------}
function TSQLiteVariables.GetItems(AIndex: Integer): TSQLiteStmtVar;
begin
  Result := TSQLiteStmtVar(FList[AIndex]);
end;

{-------------------------------------------------------------------------------}
function TSQLiteVariables.GetCount: Integer;
begin
  Result := FList.Count;
end;

{-------------------------------------------------------------------------------}
{ TSQLiteStatement                                                              }
{-------------------------------------------------------------------------------}
constructor TSQLiteStatement.Create(ADB: TSQLiteDatabase; AOwningObj: TObject = nil);
begin
  inherited Create;
  FLib := ADB.Lib;
  FDatabase := ADB;
  FOwningObj := AOwningObj;
  FState := ssInactive;
  FParams := TSQLiteVariables.Create(Self);
  FColumns := TSQLiteVariables.Create(Self);
  FUseColumnMetadata := True;
  FStrsTrim := True;
  FStrsEmpty2Null := True;
  FMaxStringSize := C_FD_DefMaxStrSize;
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteStatement.Destroy;
begin
  if Handle <> nil then
    Unprepare;
  FDFreeAndNil(FParams);
  FDFreeAndNil(FColumns);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteStatement.PrepareBase;
var
  iCode: Integer;
  iRetries: Integer;
  iPrevExc: NativeUInt;
  lDone: Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  var
    s: String;
    i: Integer;
  begin
    i := FCmdTail - FCmdCurr;
    if (i = 0) or (i > FCmdTailLen) then
      i := FCmdTailLen;
    s := Database.Encoder.Decode(FCmdCurr, i div SizeOf(Char));
    Trace(ssqlite3_prepare + '16_v2', ['db', Database.Handle, 'zSql', s]);
  end;

  procedure Trace2;
  begin
    Trace(ssqlite3_bind_parameter_count, ['stmt', Handle, 'Result', FParamDefsCount]);
  end;

  procedure Trace3;
  begin
    Trace(ssqlite3_column_count, ['stmt', Handle, 'Result', FColumnDefsCount]);
  end;
{$ENDIF}

begin
  // See http://www.da-soft.com/forums/anydac-general-english/invalid-floating-point-operation-on-opening-query.html#19067
  // To avoid Invalid Floating Point Operation exception with SQLite
  iPrevExc := FDDisableFPExc;
  Database.FCurStatement := Self;
  try
    repeat
      lDone := True;
      FCmdTail := nil;
      FLastStepError := SQLITE_OK;
      for iRetries := 1 to 2 do begin
        iCode := Lib.Fsqlite3_prepare(Database.Handle, FCmdCurr, FCmdTailLen + 1,
          FHandle, FCmdTail);
        if iCode <> SQLITE_SCHEMA then
          Break;
      end;
{$IFDEF FireDAC_MONITOR}
      if Tracing then Trace1;
{$ENDIF}
      try
        Check(iCode);
      except
        on E: ESQLiteNativeException do begin
          if (E.Kind = ekObjNotExists) and (Pos('no such table', E.Message) <> 0) then
            lDone := Database.DoGetTable(E.Errors[0].ObjName);
          if lDone then
            raise;
        end;
      end;
    until lDone;
    if Handle <> nil then begin
      FState := ssPrepared;
      Dec(FCmdTailLen, FCmdTail - FCmdCurr);
      if FCmdTailLen < 0 then
        FCmdTailLen := 0;
      while (FCmdTailLen > 0) and (FCmdTail^ <= Byte(' ')) do begin
        Inc(FCmdTail);
        Dec(FCmdTailLen);
      end;
      Inc(FBaseParamIndex, FParamDefsCount);
      FParamDefsCount := Lib.Fsqlite3_bind_parameter_count(Handle);
{$IFDEF FireDAC_MONITOR}
      if Tracing then Trace2;
{$ENDIF}
      FColumnDefsCount := Lib.Fsqlite3_column_count(Handle);
{$IFDEF FireDAC_MONITOR}
      if Tracing then Trace3;
{$ENDIF}
    end
    else begin
      FCmdTailLen := 0;
      FParamDefsCount := 0;
      FColumnDefsCount := 0;
    end;
  finally
    Database.FCurStatement := nil;
    FDResetFPExc(iPrevExc);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteStatement.Prepare(const ACmd: String);
begin
  FCmdText := Database.Encoder.Encode(ACmd);
  Prepare;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteStatement.Prepare;
begin
  FCmdCurr := PByte(FCmdText);
  FCmdTailLen := Database.Encoder.EncodedLength(FCmdText);
  FBaseParamIndex := 0;
  FParamDefsCount := 0;
  FColumnDefsCount := 0;
  PrepareBase;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteStatement.Unprepare;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_finalize, ['stmt', Handle]);
  end;
{$ENDIF}

var
  iCode: Integer;
begin
  if Handle = nil then
    Exit;
  try
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    iCode := Lib.Fsqlite3_finalize(Handle);
    if iCode <> FLastStepError then
      Check(iCode);
  finally
    FHandle := nil;
    FState := ssInactive;
    FLastStepError := SQLITE_OK;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteStatement.Reset;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_reset, ['stmt', Handle]);
  end;
{$ENDIF}

var
  iCode: Integer;
begin
  if FState in [ssExecuted, ssFirstFetch, ssNextFetch, ssEOF] then begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    iCode := Lib.Fsqlite3_reset(Handle);
    if iCode <> FLastStepError then
      Check(iCode);
    FState := ssPrepared;
    FLastStepError := SQLITE_OK;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteStatement.Rewind;
begin
  Reset;
  if not FirstCommand then begin
    Unprepare;
    Prepare;
    FState := ssRewinded;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteStatement.ExecuteBase;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_step, ['stmt', Handle]);
  end;

  procedure Trace2;
  begin
    Trace(ssqlite3_reset, ['stmt', Handle]);
  end;
{$ENDIF}

var
  iCode: Integer;
begin
  Database.FCurStatement := Self;
  try
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    iCode := Lib.Fsqlite3_step(Handle);
    FLastStepError := iCode;
    case iCode and $FF of
    SQLITE_OK:
      if FState in [ssFirstFetch, ssNextFetch] then
        FState := ssEOF;
    SQLITE_DONE:
      if FState in [ssFirstFetch, ssNextFetch] then
        FState := ssEOF
      else
        FState := ssExecuted;
    SQLITE_ROW:
      if FState = ssFirstFetch then
        FState := ssNextFetch
      else if FState in [ssPrepared, ssRewinded] then
        FState := ssFirstFetch;
    else
{$IFDEF FireDAC_MONITOR}
      if Tracing then Trace2;
{$ENDIF}
      iCode := Lib.Fsqlite3_reset(Handle);
      if FState in [ssFirstFetch, ssNextFetch] then
        FState := ssEOF;
      FLastStepError := iCode;
      Check(iCode);
    end;
  finally
    Database.FCurStatement := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteStatement.Execute;
begin
  ExecuteBase;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteStatement.Clear;
begin
  if (Handle <> nil) and Assigned(Lib.Fsqlite3_clear_bindings) then
    Check(Lib.Fsqlite3_clear_bindings(Handle));
end;

{-------------------------------------------------------------------------------}
function TSQLiteStatement.Fetch: Boolean;
begin
  case State of
  ssFirstFetch:
    begin
      FState := ssNextFetch;
      Result := True;
    end;
  ssNextFetch:
    begin
      ExecuteBase;
      Result := State = ssNextFetch;
    end;
  else
    Result := False;
  end;
end;

{-------------------------------------------------------------------------------}
function TSQLiteStatement.FirstCommand: Boolean;
begin
  Result := FCmdCurr = PByte(FCmdText);
end;

{-------------------------------------------------------------------------------}
function TSQLiteStatement.MoreCommands: Boolean;
begin
  Result := FCmdTailLen > 0;
end;

{-------------------------------------------------------------------------------}
function TSQLiteStatement.PrepareNextCommand: Boolean;
begin
  Unprepare;
  while MoreCommands and (Handle = nil) do begin
    FCmdCurr := FCmdTail;
    PrepareBase;
  end;
  Result := (Handle <> nil);
end;

{-------------------------------------------------------------------------------}
function TSQLiteStatement.GetChanges: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_changes, ['db', Database.Handle, 'Result', Result]);
  end;
{$ENDIF}

begin
  if ColumnDefsCount > 0 then
    Result := 0
  else begin
    Result := Lib.Fsqlite3_changes(Database.Handle);
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
  end;
end;

{-------------------------------------------------------------------------------}
function TSQLiteStatement.GetColumnDefs(AIndex: Integer): TSQLiteValueDef;
begin
  Result := TSQLiteValueDef.CreateForColumn(Self, AIndex);
end;

{-------------------------------------------------------------------------------}
function TSQLiteStatement.GetParamDefs(AIndex: Integer): TSQLiteValueDef;
begin
  Result := TSQLiteValueDef.CreateForParam(Self, AIndex, 0);
end;

{-------------------------------------------------------------------------------}
function TSQLiteStatement.GetIsDrop: Boolean;

  function HasKW(const ASQL, AKW: String): Boolean;
  var
    i: Integer;
  begin
    i := Pos(AKW, ASQL);
    Result := (i > 0) and
      ((i = 1) or FDInSet(ASQL[i - 1], [' ', #13, #10, #9, '(', ')'])) and
      ((i + Length(AKW) - 1 = Length(ASQL)) or FDInSet(ASQL[i + Length(AKW)], [' ', #13, #10, #9, '(', ')']));
  end;

var
  sSQL: String;
begin
  sSQL := UpperCase(Database.Encoder.Decode(FCmdText));
  Result := HasKW(sSQL, 'DROP') and HasKW(sSQL, 'TABLE');
end;

{-------------------------------------------------------------------------------}
{ TSQLiteInput                                                                  }
{-------------------------------------------------------------------------------}
procedure TSQLiteInput.SetHandle(const AValue: psqlite3_value);
begin
  FHandle := AValue;
  FIntDataType := Database.Lib.Fsqlite3_value_type(Handle);
end;

{-------------------------------------------------------------------------------}
function TSQLiteInput.InternalGetData(var AValue: Pointer; var ASize: Integer;
  var AIntDataType: Integer): Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace2;
  begin
    Database.Trace(ssqlite3_value_blob, ['value', FHandle, 'bytes', ASize]);
  end;

  procedure Trace3;
  begin
    Database.Trace(ssqlite3_value_double, ['value', FHandle, 'Result', PDouble(AValue)^]);
  end;

  procedure Trace4;
  begin
    Database.Trace(ssqlite3_value_int64, ['value', FHandle, 'Result', PInt64(AValue)^]);
  end;

  procedure Trace5;
  begin
    Database.Trace(ssqlite3_value_text, ['stmt', FHandle, 'bytes', ASize]);
  end;
{$ENDIF}

begin
  if FIntDataType = SQLITE_NULL then
    Result := False
  else begin
    Result := True;
    if AIntDataType = SQLITE_NULL then
      AIntDataType := FIntDataType;
    if AValue <> nil then
      case AIntDataType of
      SQLITE_BLOB:
        begin
          AValue := Database.Lib.Fsqlite3_value_blob(FHandle);
          ASize := Database.Lib.Fsqlite3_value_bytes(FHandle);
{$IFDEF FireDAC_MONITOR}
          if Database.Tracing then Trace2;
{$ENDIF}
        end;
      SQLITE_FLOAT:
        begin
          PDouble(AValue)^ := Database.Lib.Fsqlite3_value_double(FHandle);
          ASize := SizeOf(Double);
{$IFDEF FireDAC_MONITOR}
          if Database.Tracing then Trace3;
{$ENDIF}
        end;
      SQLITE_INTEGER:
        begin
          PInt64(AValue)^ := Database.Lib.Fsqlite3_value_int64(FHandle);
          ASize := SizeOf(Int64);
{$IFDEF FireDAC_MONITOR}
          if Database.Tracing then Trace4;
{$ENDIF}
        end;
      SQLITE_TEXT:
        begin
          ASize := Database.Lib.Fsqlite3_value_bytes(FHandle) div SizeOf(Char);
          AValue := Database.Lib.Fsqlite3_value_text(FHandle);
{$IFDEF FireDAC_MONITOR}
          if Database.Tracing then Trace5;
{$ENDIF}
        end;
      end;
  end;
end;

{-------------------------------------------------------------------------------}
{ TSQLiteInputs                                                                 }
{-------------------------------------------------------------------------------}
constructor TSQLiteInputs.Create;
begin
  inherited Create;
  FList := TFDObjList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteInputs.Destroy;
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    FDFree(TSQLiteInput(FList[i]));
  FDFreeAndNil(FList);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TSQLiteInputs.GetCount: Integer;
begin
  Result := FList.Count;
end;

{-------------------------------------------------------------------------------}
function TSQLiteInputs.GetItems(AIndex: Integer): TSQLiteInput;
begin
  Result := TSQLiteInput(FList[AIndex]);
end;

{-------------------------------------------------------------------------------}
{ TSQLiteOutput                                                                 }
{-------------------------------------------------------------------------------}
function TSQLiteOutput.InternalGetData(var AValue: Pointer; var ASize,
  AIntDataType: Integer): Boolean;
begin
  Result := False;
  // SQLite does not support reading of the custom function result value
  FDCapabilityNotSupported(nil, [S_FD_LPhys, S_FD_SQLiteId, 'sqlite3']);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteOutput.InternalSetData(AValue: Pointer; ASize: Integer;
  AIntDataType: Integer);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Database.Trace(ssqlite3_result_zeroblob, ['context', Handle, 'ASize', ASize]);
  end;

  procedure Trace2;
  begin
    Database.Trace(ssqlite3_result_null, ['context', Handle]);
  end;

  procedure Trace3;
  begin
    Database.Trace(ssqlite3_result_blob, ['context', Handle, 'bytes', ASize]);
  end;

  procedure Trace4;
  begin
    Database.Trace(ssqlite3_result_double, ['context', Handle, 'value', PDouble(AValue)^]);
  end;

  procedure Trace5;
  begin
    Database.Trace(ssqlite3_result_int64, ['context', Handle, 'value', PInt64(AValue)^]);
  end;

  procedure Trace6;
  begin
    Database.Trace(ssqlite3_result_text, ['context', Handle, 'ASize', ASize]);
  end;
{$ENDIF}

begin
  if (AValue = nil) or (AIntDataType = SQLITE_NULL) then
    if (AIntDataType = SQLITE_BLOB) and (ASize <> 0) and
       Assigned(Database.Lib.Fsqlite3_result_zeroblob) then begin
{$IFDEF FireDAC_MONITOR}
      if Database.Tracing then Trace1;
{$ENDIF}
      Database.Lib.Fsqlite3_result_zeroblob(Handle, ASize);
    end
    else begin
{$IFDEF FireDAC_MONITOR}
      if Database.Tracing then Trace2;
{$ENDIF}
      Database.Lib.Fsqlite3_result_null(Handle);
    end
  else
    case AIntDataType of
    SQLITE_BLOB:
      begin
{$IFDEF FireDAC_MONITOR}
        if Database.Tracing then Trace3;
{$ENDIF}
        Database.Lib.Fsqlite3_result_blob(Handle, AValue, ASize, SQLITE_TRANSIENT);
      end;
    SQLITE_FLOAT:
      begin
{$IFDEF FireDAC_MONITOR}
        if Database.Tracing then Trace4;
{$ENDIF}
        Database.Lib.Fsqlite3_result_double(Handle, PDouble(AValue)^);
      end;
    SQLITE_INTEGER:
      begin
{$IFDEF FireDAC_MONITOR}
        if Database.Tracing then Trace5;
{$ENDIF}
        Database.Lib.Fsqlite3_result_int64(Handle, PInt64(AValue)^);
      end;
    SQLITE_TEXT:
      begin
{$IFDEF FireDAC_MONITOR}
        if Database.Tracing then Trace6;
{$ENDIF}
        Database.Lib.Fsqlite3_result_text(Handle, PByte(AValue),
          ASize * SizeOf(Char), SQLITE_TRANSIENT);
      end;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteOutput.SetErrorCode(const AValue: Integer);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Database.Trace(ssqlite3_result_error_code, ['context', Handle, 'code', AValue]);
  end;
{$ENDIF}

begin
  FErrorCode := AValue;
  if Assigned(Database.Lib.Fsqlite3_result_error_code) then begin
{$IFDEF FireDAC_MONITOR}
    if Database.Tracing then Trace1;
{$ENDIF}
    Database.Lib.Fsqlite3_result_error_code(Handle, AValue);
  end
  else
    ErrorText := Format('user function error [%d]', [AValue]);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteOutput.SetErrorText(const AValue: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Database.Trace(ssqlite3_result_error, ['context', Handle, 'msg', AValue]);
  end;
{$ENDIF}

var
  sb: TFDByteString;
begin
  FErrorText := AValue;
  sb := Database.Encoder.Encode(AValue);
{$IFDEF FireDAC_MONITOR}
  if Database.Tracing then Trace1;
{$ENDIF}
  Database.Lib.Fsqlite3_result_error(Handle, PByte(sb), Database.Encoder.EncodedLength(sb));
end;

{-------------------------------------------------------------------------------}
{ TSQLiteFunction                                                               }
{-------------------------------------------------------------------------------}
procedure TSQLiteFunction.InternalInstall(ADatabase: TSQLiteDatabase);
begin
  TSQLiteFunctionInstance.Create(ADatabase, Self);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteFunction.DoCalculate(AData: TSQLiteFunctionInstance);
begin
  if Assigned(FOnCalculate) then
    FOnCalculate(AData, AData.Inputs, AData.Output, AData.FUserData);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteFunction.DoFinalize(AData: TSQLiteFunctionInstance);
begin
  if Assigned(FOnFinalize) then
    FOnFinalize(AData, AData.FUserData);
end;

{-------------------------------------------------------------------------------}
{ TSQLiteFunctionInstance                                                       }
{-------------------------------------------------------------------------------}
procedure FDsqlite3_func(context: psqlite3_context; nargs: Integer;
  args: ppsqlite3_value); cdecl;
begin
  TSQLiteFunctionInstance(Gsqlite3_user_data(context)).DoCalculate(context, nargs, args);
end;

{-------------------------------------------------------------------------------}
procedure FDsqlite3_final(context: psqlite3_context); cdecl;
begin
  TSQLiteFunctionInstance(Gsqlite3_user_data(context)).DoFinalize(context);
end;

{-------------------------------------------------------------------------------}
constructor TSQLiteFunctionInstance.Create(ADB: TSQLiteDatabase;
  AFunc: TSQLiteFunction);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Database.Trace(ssqlite3_create_function, ['db', Database.Handle,
      'zFunctionName', Func.Name, 'nArg', Func.FArgs,
      'xFunc', '<func>', 'xStep', nil, 'xFinal', nil]);
  end;

  procedure Trace2;
  begin
    Database.Trace(ssqlite3_create_function, ['db', Database.Handle,
      'zFunctionName', Func.Name, 'nArg', Func.FArgs,
      'xFunc', nil, 'xStep', '<step>', 'xFinal', '<final>']);
  end;
{$ENDIF}

var
  i: Integer;
  iTextRep: Integer;
begin
  inherited Create(ADB, AFunc);
  FInputs := TSQLiteInputs.Create;
  for i := 1 to Func.Args do
    FInputs.FList.Add(TSQLiteInput.Create(Database));
  FOutput := TSQLiteOutput.Create(Database);
  iTextRep := SQLITE_UTF16;
  if AFunc.Deterministic and (Database.Lib.Version >= svSQLite030803) then
    iTextRep := iTextRep or SQLITE_DETERMINISTIC;
  if Func.Aggregate then begin
{$IFDEF FireDAC_MONITOR}
    if Database.Tracing then Trace1;
{$ENDIF}
    Database.Check(Database.Lib.Fsqlite3_create_function(Database.Handle,
      PByte(Database.Encoder.Encode(Func.Name)), Func.Args,
      iTextRep, Self, nil, FDsqlite3_func, FDsqlite3_final));
  end
  else begin
{$IFDEF FireDAC_MONITOR}
    if Database.Tracing then Trace2;
{$ENDIF}
    Database.Check(Database.Lib.Fsqlite3_create_function(Database.Handle,
      PByte(Database.Encoder.Encode(Func.Name)), Func.Args,
      iTextRep, Self, FDsqlite3_func, nil, nil));
  end;
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteFunctionInstance.Destroy;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Database.Trace(ssqlite3_create_function, ['db', Database.Handle,
      'zFunctionName', Func.Name, 'nArg', Func.FArgs,
      'xFunc', 'nil', 'xStep', 'nil', 'xFinal', 'nil']);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Database.Tracing then Trace1;
{$ENDIF}
  Database.Check(Database.Lib.Fsqlite3_create_function(Database.Handle,
    PByte(Database.Encoder.Encode(Func.Name)), Func.Args,
    SQLITE_UTF16, Self, nil, nil, nil));
  FDFreeAndNil(FInputs);
  FDFreeAndNil(FOutput);
  FDFreeAndNil(FUserData);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TSQLiteFunctionInstance.GetFunc: TSQLiteFunction;
begin
  Result := TSQLiteFunction(Extension);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteFunctionInstance.DoCalculate(context: psqlite3_context;
  nargs: Integer; args: ppsqlite3_value);
var
  i: Integer;
  pVal: ppsqlite3_value;
begin
  FOutput.Handle := context;
  pVal := args;
  for i := 0 to FInputs.Count - 1 do begin
    if i < nargs then
      FInputs[i].Handle := pVal^
    else
      FInputs[i].Handle := nil;
    pVal := ppsqlite3_value(NativeUInt(pVal) + SizeOf(psqlite3_value));
  end;
  try
    Func.DoCalculate(Self);
  except
    on E: Exception do
      FOutput.ErrorText := E.Message;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteFunctionInstance.DoFinalize(context: psqlite3_context);
begin
  Func.DoFinalize(Self);
end;

{-------------------------------------------------------------------------------}
{ TSQLiteExpressionFunction                                                     }
{-------------------------------------------------------------------------------}
constructor TSQLiteExpressionFunction.CreateExpr(ALib: TSQLiteLib;
  ADesc: TFDExpressionFunctionDesc; AArgs: Integer);
begin
  inherited Create(ALib);
  FDesc := ADesc;
  Name := FDesc.Name;
  // FireDAC.Stan.ExprFuncs registers following functions. Their names are
  // reserved words in SQLite. FireDAC.Phys.SQLiteMeta knows about '_'.
  if (CompareText(Name, 'left') = 0) or
     (CompareText(Name, 'right') = 0) or
     (CompareText(Name, 'insert') = 0) then
    Name := Name + '_';
  Args := AArgs;
end;

{-------------------------------------------------------------------------------}
class procedure TSQLiteExpressionFunction.Register(ALib: TSQLiteLib);
const
  CStdFuncs: array [0..27] of String = ('time', 'date', 'abs', 'coalesce', 'glob',
    'ifnull', 'hex', 'last_insert_rowid', 'length', 'like', 'load_extension', 'lower',
    'ltrim', 'max', 'min', 'nullif', 'quote', 'random', 'randomblob', 'replace',
    'round', 'rtrim', 'sqlite_version', 'substr', 'trim', 'typeof', 'upper',
    'zeroblob');
var
  i, j: Integer;
  oDesc: TFDExpressionFunctionDesc;
  lIgnore: Boolean;
  oFunc: TSQLiteExpressionFunction;
begin
  for i := 0 to FDExpressionManager().FunctionCount - 1 do begin
    oDesc := FDExpressionManager().Functions[i];
                                                                  
    if (oDesc.ScopeKind in [ckUnknown, ckConst]) and (oDesc.ArgMax <> MAXINT) then begin
      lIgnore := False;
                                                                                                         
      for j := Low(CStdFuncs) to High(CStdFuncs) do
        if CompareText(CStdFuncs[j], oDesc.Name) = 0 then begin
          lIgnore := True;
          Break;
        end;
      if not lIgnore then
        for j := oDesc.ArgMin to oDesc.ArgMax do begin
          oFunc := TSQLiteExpressionFunction.CreateExpr(ALib, oDesc, j);
          oFunc.Deterministic := not (oDesc.ScopeKind in [ckField, ckAgg]);
        end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteExpressionFunction.InternalInstall(ADatabase: TSQLiteDatabase);
begin
  TSQLiteExpressionFunctionInstance.Create(ADatabase, Self);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteExpressionFunction.DoCalculate(AData: TSQLiteFunctionInstance);
begin
  TSQLiteExpressionFunctionInstance(AData).InternalCalculate();
  inherited DoCalculate(AData);
end;

{-------------------------------------------------------------------------------}
{ TSQLiteExpressionFunctionInstance                                             }
{-------------------------------------------------------------------------------}
constructor TSQLiteExpressionFunctionInstance.Create(ADatabase: TSQLiteDatabase;
  AFunc: TSQLiteFunction);
begin
  inherited Create(ADatabase, AFunc);
  SetLength(FFuncArgs, TSQLiteExpressionFunction(AFunc).Args);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteExpressionFunctionInstance.InternalCalculate;
var
  i: Integer;
  V: Variant;
  oIn: TSQLiteInput;
begin
  for i := 0 to Inputs.Count - 1 do begin
    oIn := Inputs[i];
    if oIn.IsNull then
      FFuncArgs[i] := Null
    else
      case TSQLiteExpressionFunction(Func).FDesc.ArgTypeFamiles[i + 1] of
      C_FD_FAny:
        case oIn.IntDataType of
        SQLITE_BLOB:    FFuncArgs[i] := oIn.AsAnsiString;
        SQLITE_FLOAT:   FFuncArgs[i] := oIn.AsFloat;
        SQLITE_INTEGER: FFuncArgs[i] := oIn.AsInteger;
        SQLITE_TEXT:    FFuncArgs[i] := oIn.AsWideString;
        end;
      C_FD_FAnsi:  FFuncArgs[i] := oIn.AsAnsiString;
      C_FD_FUni:   FFuncArgs[i] := oIn.AsWideString;
      C_FD_FStr:   FFuncArgs[i] := oIn.AsWideString;
      C_FD_FDate:  FFuncArgs[i] := oIn.AsDateTime;
      C_FD_FInt:   FFuncArgs[i] := oIn.AsInteger;
      C_FD_FFloat: FFuncArgs[i] := oIn.AsFloat;
      C_FD_FNum:   FFuncArgs[i] := VarFMTBcdCreate(oIn.AsNumber)
      end;
  end;
  V := TFDExpressionFunction(TSQLiteExpressionFunction(Func).FDesc.Call)(FFuncArgs);
  if VarIsNull(V) then
    Output.Clear
  else
    case VarType(V) and varTypeMask of
    varSmallint,
    varInteger,
    varByte,
    varShortInt,
    varWord,
    varLongWord,
    varInt64,
    varUInt64,
    varBoolean:  Output.AsInteger := V;
    varSingle,
    varDouble:   Output.AsFloat := V;
    varCurrency: Output.AsCurrency := V;
    varDate:     Output.AsDateTime := V;
    varOleStr,
    varUString,
    varVariant:  Output.AsWideString := V;
    varString:   Output.AsAnsiString := TFDAnsiString(V);
    else
      if VarIsFMTBcd(V) then
        Output.AsNumber := VarToBcd(V)
      else if VarIsSQLTimeStamp(V) then
        Output.AsDateTime := SQLTimeStampToDateTime(VarToSQLTimeStamp(V))
      else
        ASSERT(False);
    end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysSQLiteLastAutoGenFunc                                                  }
{-------------------------------------------------------------------------------}
constructor TFDPhysSQLiteLastAutoGenFunc.Create(ALib: TSQLiteLib);
begin
  inherited Create(ALib);
  Name := 'LAST_INSERT_AUTOGEN';
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysSQLiteLastAutoGenFunc.DoCalculate(AData: TSQLiteFunctionInstance);
begin
  AData.Output.AsInteger := AData.Database.LastAutoGenValue;
end;

{-------------------------------------------------------------------------------}
{ TSQLiteRTree                                                                  }
{ http://www.sqlite.org/src/doc/trunk/src/test_rtree.c                          }
{-------------------------------------------------------------------------------}
function TSQLiteRTree.DoCalculate(AData: TSQLiteRTreeData): Boolean;
begin
  Result := False;
  if Assigned(FOnCalculate) then
    FOnCalculate(AData, AData.Params, AData.Columns, Result);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteRTree.DoFinalize(AData: TSQLiteRTreeData);
begin
  if Assigned(FOnFinalize) then
    FOnFinalize(AData, AData.FUserData);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteRTree.InternalInstall(ADatabase: TSQLiteDatabase);
begin
  TSQLiteRTreeInstance.Create(ADatabase, Self);
end;

{-------------------------------------------------------------------------------}
{ TSQLiteRTreeInstance                                                          }
{-------------------------------------------------------------------------------}
function FDsqlite3_rtree_xGeom(geom: psqlite3_rtree_geometry; nCoord: Integer;
  aCoord: psqlite3_rtree_dbl; var pRes: Integer): Integer; cdecl;
begin
  Result := TSQLiteRTreeInstance(geom^.pContext).DoCalculate(geom, nCoord, aCoord, pRes);
end;

{-------------------------------------------------------------------------------}
procedure FDsqlite3_rtree_xDelUser(userdata: Pointer); cdecl;
begin
  TSQLiteRTreeData(userdata).RTreeInst.DoFinalize(TSQLiteRTreeData(userdata));
end;

{-------------------------------------------------------------------------------}
constructor TSQLiteRTreeInstance.Create(ADB: TSQLiteDatabase;
  ARTree: TSQLiteRTree);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Database.Trace(ssqlite3_rtree_geometry_callback, ['db', Database.Handle,
      'zGeom', RTree.Name, 'xGeom', '<func>']);
  end;
{$ENDIF}

begin
  inherited Create(ADB, ARTree);
  if not Assigned(Database.Lib.Fsqlite3_rtree_geometry_callback) then
    FDCapabilityNotSupported(nil, [S_FD_LPhys, S_FD_SQLiteId, 'sqlite3']);
{$IFDEF FireDAC_MONITOR}
  if Database.Tracing then Trace1;
{$ENDIF}
  Database.Check(Database.Lib.Fsqlite3_rtree_geometry_callback(Database.Handle,
    PByte(Database.Encoder.Encode(RTree.Name, ecUTF8)), FDsqlite3_rtree_xGeom, Self));
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteRTreeInstance.Destroy;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Database.Trace(ssqlite3_rtree_geometry_callback, ['db', Database.Handle,
      'zGeom', RTree.Name, 'xGeom', 'nil']);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Database.Tracing then Trace1;
{$ENDIF}
  // sqlite3_rtree_geometry_callback with NIL callback returns SQLITE_MISUSE.
  // So, just call sqlite3_create_function, which is called internaly by
  // sqlite3_rtree_geometry_callback.
  Database.Check(Database.Lib.Fsqlite3_create_function(Database.Handle,
    PByte(Database.Encoder.Encode(RTree.Name)), -1,
    SQLITE_UTF16, Self, nil, nil, nil));
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TSQLiteRTreeInstance.GetRTree: TSQLiteRTree;
begin
  Result := TSQLiteRTree(Extension);
end;

{-------------------------------------------------------------------------------}
function TSQLiteRTreeInstance.DoCalculate(geom: psqlite3_rtree_geometry; nCoord: Integer;
  aCoord: psqlite3_rtree_dbl; var pRes: Integer): Integer;
var
  i: Integer;
begin
  pRes := 0;
  try
    if geom^.pUser = nil then begin
      geom^.pUser := TSQLiteRTreeData.Create;
      TSQLiteRTreeData(geom^.pUser).FRTreeInst := Self;
      SetLength(TSQLiteRTreeData(geom^.pUser).FParams, geom^.nParam);
      for i := 0 to geom^.nParam - 1 do
        TSQLiteRTreeData(geom^.pUser).FParams[i] := psqlite3_rtree_dbl(
          PByte(geom^.aParam) + SizeOf(sqlite3_rtree_dbl) * i)^;
      geom^.xDelUser := @FDsqlite3_rtree_xDelUser;
      SetLength(TSQLiteRTreeData(geom^.pUser).FColumns, nCoord);
    end;
    for i := 0 to nCoord - 1 do
      TSQLiteRTreeData(geom^.pUser).FColumns[i] := psqlite3_rtree_dbl(
        PByte(aCoord) + SizeOf(sqlite3_rtree_dbl) * i)^;
    if RTree.DoCalculate(TSQLiteRTreeData(geom^.pUser)) then
      pRes := 1;
    Result := SQLITE_OK;
  except
    Result := SQLITE_ERROR;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteRTreeInstance.DoFinalize(AData: TSQLiteRTreeData);
begin
  try
    RTree.DoFinalize(AData);
  except
    // nothing
  end;
  FDFree(AData);
end;

{-------------------------------------------------------------------------------}
{ TSQLiteBackup                                                                 }
{-------------------------------------------------------------------------------}
constructor TSQLiteBackup.Create(ALib: TSQLiteLib; ADestDatabase: TSQLiteDatabase);
begin
  inherited Create;
  FLib := Alib;
  FDatabase := ADestDatabase;
  FPagesPerStep := -1;
  FSourceDBName := 'MAIN';
  FDestinationDBName := 'MAIN';
  FWaitForLocks := True;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteBackup.Init;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_backup_init, ['pDest', DestinationDatabase.Handle, 'zDestName',
      DestinationDBName, 'pSource', SourceDatabase.Handle, 'zSourceName', SourceDBName]);
  end;
{$ENDIF}

var
  sDestDB, sSrcDB: TFDByteString;
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  sDestDB := TFDEncoder.Enco(DestinationDBName, ecANSI);
  sSrcDB := TFDEncoder.Enco(SourceDBName, ecANSI);
  FHandle := Lib.Fsqlite3_backup_init(
    DestinationDatabase.Handle, PByte(sDestDB),
    SourceDatabase.Handle, PByte(sSrcDB));
  if Handle = nil then
    Check(Lib.Fsqlite3_errcode(DestinationDatabase.Handle));
end;

{-------------------------------------------------------------------------------}
function TSQLiteBackup.Step: Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_backup_step, ['p', Handle, 'nPage', PagesPerStep]);
  end;
{$ENDIF}

var
  iRes,
  iMainCode: Integer;
  iStartTime: Cardinal;
begin
  Result := False;
  iStartTime := TThread.GetTickCount;
  repeat
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    iRes := Lib.Fsqlite3_backup_step(Handle, PagesPerStep);
    iMainCode := iRes and $FF;
    case iMainCode of
    SQLITE_DONE:
      Result := True;
    SQLITE_OK:
      ;
    SQLITE_BUSY,
    SQLITE_LOCKED:
      if WaitForLocks and not FDTimeout(iStartTime, SourceDatabase.BusyTimeout) then
        Sleep(250)
      else
        Break;
    end;
  until not (iMainCode in [SQLITE_BUSY, SQLITE_LOCKED]);
  if not (iMainCode in [SQLITE_DONE, SQLITE_OK]) then
    // When error text is 'not an error', then do not raise exception.
    // sqlite3_backup_finish will set a correct error message. So, lets
    // Finish will raise a well formed exception.
    if FDestinationDatabase.APIStrToDlpStr(
        FDestinationDatabase.Lib.Fsqlite3_errmsg(FDestinationDatabase.Handle)) <> 'not an error' then
      FDestinationDatabase.Check(iRes)
    else
      Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteBackup.Finish;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ssqlite3_backup_finish, ['p', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(Lib.Fsqlite3_backup_finish(Handle));
end;

{-------------------------------------------------------------------------------}
function TSQLiteBackup.GetPageCount: Integer;
begin
  Result := Lib.Fsqlite3_backup_pagecount(Handle);
end;

{-------------------------------------------------------------------------------}
function TSQLiteBackup.GetRemaining: Integer;
begin
  Result := Lib.Fsqlite3_backup_remaining(Handle);
end;

{-------------------------------------------------------------------------------}
{ Virtual Table support                                                         }
{-------------------------------------------------------------------------------}
function FDxCreate(db: psqlite3; pAux: Pointer; argc: Integer; argv: PPUtf8;
  var ppVTab: psqlite3_vtab; var pzErr: PUtf8): Integer; cdecl;
var
  oMod: TSQLiteVModule;
begin
  oMod := TSQLiteVModule(pAux);
  oMod.FResult := SQLITE_OK;
  oMod.xCreateConnect(db, argc, argv, ppVTab, pzErr, False);
  Result := oMod.FResult;
end;

{-------------------------------------------------------------------------------}
function FDxConnect(db: psqlite3; pAux: Pointer; argc: Integer; argv: PPUtf8;
  var ppVTab: psqlite3_vtab; var pzErr: PUtf8): Integer; cdecl;
var
  oMod: TSQLiteVModule;
begin
  oMod := TSQLiteVModule(pAux);
  oMod.FResult := SQLITE_OK;
  oMod.xCreateConnect(db, argc, argv, ppVTab, pzErr, True);
  Result := oMod.FResult;
end;

{-------------------------------------------------------------------------------}
function FDxDisconnect(pVTab: psqlite3_vtab): Integer; cdecl;
begin
  Result := SQLITE_OK;
  try
    if PFDsqlite3_vtab(pVTab)^.pFDTable <> nil then
      PFDsqlite3_vtab(pVTab)^.pFDTable.xDisconnect(pVTab);
  except
    Result := SQLITE_ERROR;
  end;
end;

{-------------------------------------------------------------------------------}
function FDxDestroy(pVTab: psqlite3_vtab): Integer; cdecl;
begin
  Result := SQLITE_OK;
  try
    if PFDsqlite3_vtab(pVTab)^.pFDTable <> nil then
      PFDsqlite3_vtab(pVTab)^.pFDTable.xDestroy(pVTab);
  except
    Result := SQLITE_ERROR;
  end;
end;

{-------------------------------------------------------------------------------}
function FDxRename(pVTab: psqlite3_vtab; zNew: PUtf8): Integer; cdecl;
var
  oTab: TSQLiteVTable;
begin
  oTab := PFDsqlite3_vtab(pVTab)^.pFDTable;
  oTab.FResult := SQLITE_OK;
  oTab.xRename(pVTab, zNew);
  Result := oTab.FResult;
end;

{-------------------------------------------------------------------------------}
function FDxSync(pVTab: psqlite3_vtab): Integer; cdecl;
var
  oTab: TSQLiteVTable;
begin
  oTab := PFDsqlite3_vtab(pVTab)^.pFDTable;
  oTab.FResult := SQLITE_OK;
  oTab.xSync(pVTab);
  Result := oTab.FResult;
end;

{-------------------------------------------------------------------------------}
function FDxBegin(pVTab: psqlite3_vtab): Integer; cdecl;
var
  oTab: TSQLiteVTable;
begin
  oTab := PFDsqlite3_vtab(pVTab)^.pFDTable;
  oTab.FResult := SQLITE_OK;
  oTab.xBegin(pVTab);
  Result := oTab.FResult;
end;

{-------------------------------------------------------------------------------}
function FDxCommit(pVTab: psqlite3_vtab): Integer; cdecl;
var
  oTab: TSQLiteVTable;
begin
  oTab := PFDsqlite3_vtab(pVTab)^.pFDTable;
  oTab.FResult := SQLITE_OK;
  oTab.xCommit(pVTab);
  Result := oTab.FResult;
end;

{-------------------------------------------------------------------------------}
function FDxRollback(pVTab: psqlite3_vtab): Integer; cdecl;
var
  oTab: TSQLiteVTable;
begin
  oTab := PFDsqlite3_vtab(pVTab)^.pFDTable;
  oTab.FResult := SQLITE_OK;
  oTab.xRollback(pVTab);
  Result := oTab.FResult;
end;

{-------------------------------------------------------------------------------}
function FDxSavepoint(pVTab: psqlite3_vtab; p: Integer): Integer; cdecl;
var
  oTab: TSQLiteVTable;
begin
  oTab := PFDsqlite3_vtab(pVTab)^.pFDTable;
  oTab.FResult := SQLITE_OK;
  oTab.xSavepoint(pVTab, p);
  Result := oTab.FResult;
end;

{-------------------------------------------------------------------------------}
function FDxRelease(pVTab: psqlite3_vtab; p: Integer): Integer; cdecl;
var
  oTab: TSQLiteVTable;
begin
  oTab := PFDsqlite3_vtab(pVTab)^.pFDTable;
  oTab.FResult := SQLITE_OK;
  oTab.xRelease(pVTab, p);
  Result := oTab.FResult;
end;

{-------------------------------------------------------------------------------}
function FDxRollbackTo(pVTab: psqlite3_vtab; p: Integer): Integer; cdecl;
var
  oTab: TSQLiteVTable;
begin
  oTab := PFDsqlite3_vtab(pVTab)^.pFDTable;
  oTab.FResult := SQLITE_OK;
  oTab.xRollbackTo(pVTab, p);
  Result := oTab.FResult;
end;

{-------------------------------------------------------------------------------}
function FDxFindFunction(pVTab: psqlite3_vtab; nArg: Integer; zName: PUtf8;
  var pxFunc: Tsqlite3_func_callback; var ppArg: Pointer): Integer; cdecl;
begin
  Result := PFDsqlite3_vtab(pVTab)^.pFDTable.xFindFunction(pVTab, nArg, zName,
    pxFunc, ppArg);
end;

{-------------------------------------------------------------------------------}
function FDxBestIndex(pVTab: psqlite3_vtab; info: psqlite3_index_info): Integer; cdecl;
var
  oTab: TSQLiteVTable;
begin
  oTab := PFDsqlite3_vtab(pVTab)^.pFDTable;
  oTab.FResult := SQLITE_OK;
  oTab.xBestIndex(pVTab, info);
  Result := oTab.FResult;
end;

{-------------------------------------------------------------------------------}
function FDxUpdate(pVTab: psqlite3_vtab; nArg: Integer; apArgs: ppsqlite3_value;
  var rowid: sqlite3_int64): Integer; cdecl;
var
  oTab: TSQLiteVTable;
begin
  oTab := PFDsqlite3_vtab(pVTab)^.pFDTable;
  oTab.FResult := SQLITE_OK;
  oTab.xUpdate(pVTab, nArg, apArgs, rowid);
  Result := oTab.FResult;
end;

{-------------------------------------------------------------------------------}
function FDxOpen(pVTab: psqlite3_vtab; var ppCursor: psqlite3_vtab_cursor): Integer; cdecl;
var
  oTab: TSQLiteVTable;
begin
  oTab := PFDsqlite3_vtab(pVTab)^.pFDTable;
  oTab.FResult := SQLITE_OK;
  oTab.xOpen(pVTab, ppCursor);
  Result := oTab.FResult;
end;

{-------------------------------------------------------------------------------}
function FDxClose(cursor: psqlite3_vtab_cursor): Integer; cdecl;
begin
  Result := SQLITE_OK;
  try
    if PFDsqlite3_vtab_cursor(cursor)^.pFDCursor <> nil then
      PFDsqlite3_vtab_cursor(cursor)^.pFDCursor.FTable.xClose(cursor);
  except
    Result := SQLITE_ERROR;
  end;
end;

{-------------------------------------------------------------------------------}
function FDxFilter(cursor: psqlite3_vtab_cursor; idxNum: Integer; idxStr: PUtf8;
  argc: Integer; argv: ppsqlite3_value): Integer; cdecl;
var
  oCrs: TSQLiteVCursor;
begin
  oCrs := PFDsqlite3_vtab_cursor(cursor)^.pFDCursor;
  oCrs.FResult := SQLITE_OK;
  oCrs.xFilter(cursor, idxNum, idxStr, argc, argv);
  Result := oCrs.FResult;
end;

{-------------------------------------------------------------------------------}
function FDxNext(cursor: psqlite3_vtab_cursor): Integer; cdecl;
var
  oCrs: TSQLiteVCursor;
begin
  oCrs := PFDsqlite3_vtab_cursor(cursor)^.pFDCursor;
  oCrs.FResult := SQLITE_OK;
  oCrs.xNext(cursor);
  Result := oCrs.FResult;
end;

{-------------------------------------------------------------------------------}
function FDxEof(cursor: psqlite3_vtab_cursor): Integer; cdecl;
begin
  Result := PFDsqlite3_vtab_cursor(cursor)^.pFDCursor.xEof(cursor);
end;

{-------------------------------------------------------------------------------}
function FDxColumn(cursor: psqlite3_vtab_cursor; context: psqlite3_context;
  index: Integer): Integer; cdecl;
var
  oCrs: TSQLiteVCursor;
begin
  oCrs := PFDsqlite3_vtab_cursor(cursor)^.pFDCursor;
  oCrs.FResult := SQLITE_OK;
  oCrs.xColumn(cursor, context, index);
  Result := oCrs.FResult;
end;

{-------------------------------------------------------------------------------}
function FDxRowid(cursor: psqlite3_vtab_cursor; var pRowid: sqlite3_int64): Integer; cdecl;
var
  oCrs: TSQLiteVCursor;
begin
  oCrs := PFDsqlite3_vtab_cursor(cursor)^.pFDCursor;
  oCrs.FResult := SQLITE_OK;
  oCrs.xRowid(cursor, pRowid);
  Result := oCrs.FResult;
end;

{-------------------------------------------------------------------------------}
{ TSQLiteVObject                                                                }
{-------------------------------------------------------------------------------}
function TSQLiteVObject.SafeCallException(ExceptObject: TObject;
  ExceptAddr: Pointer): HResult;
var
  oEx: Exception;
begin
  FResult := SQLITE_ERROR;
  oEx := Exception(ExceptObject);
  if oEx is ESQLiteNativeException then
    FResult := ESQLiteNativeException(oEx).Errors[0].ErrorCode
  else if oEx is EFDDBEngineException then
    case EFDDBEngineException(oEx).Kind of
    ekRecordLocked: FResult := SQLITE_LOCKED;
    ekUKViolated,
    ekFKViolated:   FResult := SQLITE_CONSTRAINT;
    ekCmdAborted:   FResult := SQLITE_INTERRUPT;
    end
  else if oEx is EFDException then
    case EFDException(oEx).FDCode of
    er_FD_RecLocked:    FResult := SQLITE_LOCKED;
    er_FD_CheckViolated,
    er_FD_DuplicateRows,
    er_FD_NoMasterRow,
    er_FD_HasChildRows: FResult := SQLITE_CONSTRAINT;
    end;
  Error(Exception(ExceptObject).Message);
  Result := E_SQLITE_VTAB_RES;
end;

{-------------------------------------------------------------------------------}
{ TSQLiteVModule                                                                }
{-------------------------------------------------------------------------------}
constructor TSQLiteVModule.Create(const AName: String; ADatabase: TSQLiteDatabase);
begin
  inherited Create;
  FDatabase := ADatabase;
  FDatabase.FVModules.Add(Self);
  FLib := FDatabase.FLib;

  FModule.iVersion := 2;
  FModule.xCreate := @FDxCreate;
  FModule.xConnect := @FDxConnect;
  FModule.xBestIndex := @FDxBestIndex;
  FModule.xDisconnect := @FDxDisconnect;
  FModule.xDestroy := @FDxDestroy;
  FModule.xOpen := @FDxOpen;
  FModule.xClose := @FDxClose;
  FModule.xFilter := @FDxFilter;
  FModule.xNext := @FDxNext;
  FModule.xEof := @FDxEof;
  FModule.xColumn := @FDxColumn;
  FModule.xRowid := @FDxRowid;
  FModule.xUpdate := @FDxUpdate;
  FModule.xBegin := @FDxBegin;
  FModule.xSync := @FDxSync;
  FModule.xCommit := @FDxCommit;
  FModule.xRollback := @FDxRollback;
  FModule.xFindFunction := @FDxFindFunction;
  FModule.xRename := @FDxRename;
  FModule.xSavepoint := @FDxSavepoint;
  FModule.xRelease := @FDxRelease;
  FModule.xRollbackTo := @FDxRollbackTo;

  FDatabase.Check(FDatabase.FLib.Fsqlite3_create_module(FDatabase.Handle,
    PUtf8(FDatabase.Encoder.Encode(AName, ecUTF8)), @FModule, Self));
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteVModule.Destroy;
begin
  FDatabase.FVModules.Remove(Self);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TSQLiteVModule.BuildCreateTableStr(ADatabase: TSQLiteDatabase;
  const ACols: array of TSQLiteVColDef): String;
const
  C_HIDDEN: array [Boolean] of String = ('', ' HIDDEN');
  C_COLON: array [Boolean] of String = ('', ', ');
var
  i: Integer;
  oDef: TSQLiteVColDef;
begin
  ASSERT(Length(ACols) > 0);
  Result := 'CREATE TABLE V(';
  for i := Low(ACols) to High(ACols) do begin
    oDef := ACols[i];
    Result := Result + '[' + oDef.FName + '] ' + oDef.FDataType +
      C_HIDDEN[oDef.FHidden] + C_COLON[i <> High(ACols)];
  end;
  Result := Result + ')';
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVModule.xCreateConnect(db: psqlite3; argc: Integer; argv: PPUtf8;
  var ppVTab: psqlite3_vtab; var pzErr: PUtf8; const AConnect: Boolean);
const
  C_DummyTabSQL = 'CREATE TABLE V(x CHAR(1))';
var
  aArgs: TSQLiteVArgs;
  i: Integer;
  oTab: TSQLiteVTable;
  oCols: TSQLiteVColDefs;
  sDeclareTab: String;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FDatabase.Trace(ssqlite3_declare_vtab, ['zCreateTable', C_DummyTabSQL]);
  end;

  procedure Trace2;
  begin
    FDatabase.Trace(ssqlite3_declare_vtab, ['zCreateTable', sDeclareTab]);
  end;
{$ENDIF}

begin
  oTab := nil;
  ppVTab := nil;
  oCols := nil;
  FDatabase := FLib.dbH2dbObj(db);
  try
    SetLength(aArgs, argc);
    for i := 0 to argc - 1 do begin
      aArgs[i] := FDatabase.Encoder.Decode(argv^, -1, ecUTF8);
      argv := PPUtf8(NativeUInt(argv) + SizeOf(PUtf8));
    end;
    try
      if not AConnect then
        oTab := VTabCreate(aArgs)
      else
        oTab := VTabConnect(aArgs);
    except
      on E: EFDException do
        if (E.FDCode = er_FD_SQLiteVTabDSNotFoundOrEmpty) and
           (FDatabase.CurStatement <> nil) and FDatabase.CurStatement.IsDrop then begin
          // DROP TABLE for non existing dataset will lead to "dataset not found".
          // Instead provide a dummy VTable.
          FDummyVTab.pFDModule := Self;
{$IFDEF FireDAC_MONITOR}
          if FDatabase.Tracing then Trace1;
{$ENDIF}
          FDatabase.Check(FLib.Fsqlite3_declare_vtab(db,
            PUtf8(FDatabase.Encoder.Encode(C_DummyTabSQL, ecUTF8))));
          ppVTab := @FDummyVTab;
        end
        else
          raise;
    end;
    if ppVTab = nil then begin
      oTab.FrTab.pFDModule := Self;
      oTab.FrTab.pFDTable := oTab;
      // +2 for ROWID's
      oCols := oTab.DescribeColumns;
      oTab.AllocColumns(Length(oCols) + 2);
      sDeclareTab := BuildCreateTableStr(FDatabase, oCols);
{$IFDEF FireDAC_MONITOR}
      if FDatabase.Tracing then Trace2;
{$ENDIF}
      FDatabase.Check(FLib.Fsqlite3_declare_vtab(db,
        PUtf8(FDatabase.Encoder.Encode(sDeclareTab, ecUTF8))));
      if Assigned(FLib.Fsqlite3_vtab_config) then
        FDatabase.Check(FLib.Fsqlite3_vtab_config(db,
          SQLITE_VTAB_CONSTRAINT_SUPPORT, 1));
      ppVTab := @oTab.FrTab;
    end;
  except
    on E: Exception do begin
      FDFree(oTab);
      FDatabase.msg2putf8(E.Message, Pointer(pzErr));
      raise;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVModule.Error(const AMsg: String);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
{ TSQLiteVTableDef                                                              }
{-------------------------------------------------------------------------------}
constructor TSQLiteVTableDef.Create(ADatabase: TSQLiteDatabase);
begin
  inherited Create;
  FDatabase := ADatabase;
  FInputs := TSQLiteInputs.Create;
  FOutputs := TFDObjList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteVTableDef.Destroy;
begin
  AllocColumns(0);
  FDFreeAndNil(FOutputs);
  FDFreeAndNil(FInputs);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTableDef.AllocColumns(const ACount: Integer);
var
  i: Integer;
begin
  if FInputs.Count > ACount then
    for i := FInputs.Count - 1 downto ACount do begin
      FDFree(TSQLiteOutput(FOutputs[i]));
      FDFree(FInputs[i]);
    end
  else
    for i := FInputs.Count to ACount - 1 do begin
      FInputs.FList.Add(TSQLiteInput.Create(FDatabase));
      FOutputs.Add(TSQLiteOutput.Create(FDatabase));
    end;
  FOutputs.Count := ACount;
  FInputs.FList.Count := ACount;
end;

{-------------------------------------------------------------------------------}
function TSQLiteVTableDef.GetColsIN(AIndex: Integer): TSQLiteInput;
begin
  ASSERT(FInputs.Count > 0);
  Result := FInputs[AIndex];
end;

{-------------------------------------------------------------------------------}
function TSQLiteVTableDef.GetColsOUT(AIndex: Integer): TSQLiteOutput;
begin
  ASSERT(FOutputs.Count > 0);
  Result := TSQLiteOutput(FOutputs[AIndex]);
end;

{-------------------------------------------------------------------------------}
function TSQLiteVTableDef.GetCount: Integer;
begin
  ASSERT(FInputs.Count > 0);
  Result := FInputs.Count;
end;

{-------------------------------------------------------------------------------}
{ TSQLiteVTable                                                                 }
{-------------------------------------------------------------------------------}
constructor TSQLiteVTable.Create(AModule: TSQLiteVModule; const AName: String);
begin
  inherited Create(AModule.Database);
  FModule := AModule;
  FName := AName;
  FDatabase.FVTabs.AddObject(FName, Self);
  FCursors := TFDObjList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteVTable.Destroy;
var
  i: Integer;
begin
  i := FDatabase.FVTabs.IndexOfObject(Self);
  if i >= 0 then
    FDatabase.FVTabs.Delete(i);
  SetLength(FConstraints, 0);
  SetLength(FOrderBys, 0);
  FDFreeAndNil(FCursors);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.CloseCursors;
var
  i: Integer;
  oCrs: TSQLiteVCursor;
begin
  for i := 0 to FCursors.Count - 1 do begin
    oCrs := TSQLiteVCursor(FCursors[i]);
    oCrs.FActive := False;
    VTabClose(oCrs);
    oCrs.FTable := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.Error(const AMsg: String);
begin
  if FrTab.pVTab.zErrMsg <> nil then
    FrTab.pFDModule.FLib.Fsqlite3_free(FrTab.pVTab.zErrMsg);
  FDatabase.msg2putf8(AMsg, Pointer(FrTab.pVTab.zErrMsg));
end;

{-------------------------------------------------------------------------------}
function TSQLiteVTable.GetColsIN(AIndex: Integer): TSQLiteInput;
begin
  // skip ROWID's
  Result := inherited GetColsIN(AIndex + 2);
end;

{-------------------------------------------------------------------------------}
function TSQLiteVTable.GetCount: Integer;
begin
  // skip ROWID's
  Result := inherited GetCount() - 2;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.AllocColumns(const ACount: Integer);
begin
  inherited AllocColumns(ACount);
  // Pre-allocate constraints and order by's to get perf gains
  SetLength(FConstraints, ACount);
  SetLength(FOrderBys, ACount);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.xDisconnect(pVTab: psqlite3_vtab);
begin
  try
    VTabDisconnect();
  finally
    FDFree(Self);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.xDestroy(pVTab: psqlite3_vtab);
begin
  try
    CloseCursors;
    VTabDestroy();
  finally
    FDFree(Self);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.xRename(pVTab: psqlite3_vtab; znew: PUtf8);
begin
  VTabRename(FDatabase.Encoder.Decode(znew, -1, ecUTF8));
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.xSync(pVTab: psqlite3_vtab);
begin
  VTabSync;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.xBegin(pVTab: psqlite3_vtab);
begin
  VTabBegin;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.xCommit(pVTab: psqlite3_vtab);
begin
  VTabCommit;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.xRollback(pVTab: psqlite3_vtab);
begin
  VTabRollback;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.xSavepoint(pVTab: psqlite3_vtab; p: Integer);
begin
  VTabSavepoint(p);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.xRelease(pVTab: psqlite3_vtab; p: Integer);
begin
  VTabRelease(p);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.xRollbackTo(pVTab: psqlite3_vtab; p: Integer);
begin
  VTabRollbackTo(p);
end;

{-------------------------------------------------------------------------------}
function TSQLiteVTable.xFindFunction(pVTab: psqlite3_vtab; nArg: Integer;
  zName: PUtf8; var pxFunc: Tsqlite3_func_callback; var ppArg: Pointer): Integer;
var
  sName: String;
begin
  try
    sName := FDatabase.Encoder.Decode(zName, -1, ecUTF8);
    if not VTabFindFunction(nArg, sName, pxFunc, ppArg) then
      Result := SQLITE_FALSE
    else
      Result := SQLITE_TRUE;
  except
    Result := SQLITE_FALSE;
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.xBestIndex(pVTab: psqlite3_vtab;
  info: psqlite3_index_info);
var
  pConstr: psqlite3_index_constraint;
  pOrderBy: psqlite3_index_orderby;
  pConstrUsage: psqlite3_index_constraint_usage;
  i, iNum: Integer;
  sStr: String;
  lOrdered, lFiltered: Boolean;
  rCost: Double;
begin
  // dynamically increase arrays if needed
  if Length(FConstraints) < info^.nConstraint then
    SetLength(FConstraints, info^.nConstraint);
  if Length(FOrderBys) < info^.nOrderBy then
    SetLength(FOrderBys, info^.nOrderBy);
  pConstr := info^.aConstraint;
  pOrderBy := info^.aOrderBy;
  for i := 0 to Length(FConstraints) - 1 do begin
    FConstraints[i].FColumn := C_FD_SQLiteUndefRowid;
    FConstraints[i].FArgvIndex := 0;
    FConstraints[i].FOmit := False;
    if i < info^.nConstraint then begin
      if pConstr^.usable = SQLITE_TRUE then begin
        // if iColumn = -1 - then we get constr. for rowid
        FConstraints[i].FColumn := pConstr^.iColumn;
        case pConstr^.op of
        SQLITE_INDEX_CONSTRAINT_EQ:    FConstraints[i].FOp := coEqual;
        SQLITE_INDEX_CONSTRAINT_GT:    FConstraints[i].FOp := coGreater;
        SQLITE_INDEX_CONSTRAINT_LE:    FConstraints[i].FOp := coLessOrEqual;
        SQLITE_INDEX_CONSTRAINT_LT:    FConstraints[i].FOp := coLess;
        SQLITE_INDEX_CONSTRAINT_GE:    FConstraints[i].FOp := coGreaterOrEqual;
        SQLITE_INDEX_CONSTRAINT_MATCH: FConstraints[i].FOp := coMatch;
        end;
      end;
      pConstr := psqlite3_index_constraint(NativeUInt(pConstr) +
        SizeOf(sqlite3_index_constraint));
    end;
  end;
  for i := 0 to Length(FOrderBys) - 1 do
    if i < info^.nOrderBy then begin
      FOrderBys[i].FColumn := pOrderBy^.iColumn;
      FOrderBys[i].FDesc := pOrderBy^.desc = SQLITE_TRUE;
      pOrderBy := psqlite3_index_orderby(NativeUInt(pOrderBy) +
        SizeOf(sqlite3_index_orderby));
    end
    else
      FOrderBys[i].FColumn := C_FD_SQLiteUndefRowid;
  VTabBestIndex(iNum, sStr, lOrdered, lFiltered, rCost);
  if lOrdered or lFiltered then begin
    pConstrUsage := info^.aConstraintUsage;
    for i := 0 to Length(FConstraints) - 1 do
      if i < info^.nConstraint then begin
        pConstrUsage^.argvIndex := FConstraints[i].FArgvIndex;
        if FConstraints[i].FOmit then
          pConstrUsage^.omit := SQLITE_TRUE
        else
          pConstrUsage^.omit := SQLITE_FALSE;
        pConstrUsage := psqlite3_index_constraint_usage(NativeUInt(pConstrUsage) +
          SizeOf(sqlite3_index_constraint_usage));
      end
      else
        Break;
    info^.idxNum := iNum;
    if not ((sStr = '') and (info^.idxStr = nil)) then begin
      FDatabase.msg2putf8(sStr, Pointer(info^.idxStr));
      info^.needToFreeIdxStr := SQLITE_TRUE;
    end;
    if lOrdered then
      info^.orderByConsumed := SQLITE_TRUE
    else
      info^.orderByConsumed := SQLITE_FALSE;
    info^.estimatedCost := rCost;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.xUpdate(pVTab: psqlite3_vtab; nArg: Integer;
  apArgs: ppsqlite3_value; var rowid: sqlite3_int64);
const
  SQLITE_DEL = 1;
var
  pVal: ppsqlite3_value;
  lInsert: Boolean;
  iUpdRowid, iNewRowid: sqlite3_int64;
  i: Integer;
begin
  lInsert := False;
  iNewRowid := C_FD_SQLiteUndefRowid;
  iUpdRowid := C_FD_SQLiteUndefRowid;
  if nArg = SQLITE_DEL then begin
    FInputs[0].Handle := apArgs^;
    VTabDelete(FInputs[0].AsInteger);
  end
  else begin
    pVal := apArgs;
    for i := 0 to nArg - 1 do begin
      FInputs[i].Handle := pVal^;
      if i = 0 then begin
        lInsert := FInputs[i].IntDataType = SQLITE_NULL;
        // rowid
        if not lInsert then
          iUpdRowid := FInputs[i].AsInteger;
      end
      else if i = 1 then begin
        if FInputs[i].IntDataType <> SQLITE_NULL then
          // rowid to update to
          iNewRowid := FInputs[i].AsInteger;
      end;
      pVal := ppsqlite3_value(NativeUInt(pVal) + SizeOf(psqlite3_value));
    end;
    if lInsert then begin
      VTabInsert(iNewRowid, Assigned(FDatabase.Lib.Fsqlite3_vtab_on_conflict) and
        (FDatabase.Lib.Fsqlite3_vtab_on_conflict(FDatabase.Handle) = SQLITE_REPLACE));
      // return rowid only after INSERT
      rowid := iNewRowid;
    end
    else
      VTabUpdate(iUpdRowid, iNewRowid);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.xOpen(pVTab: psqlite3_vtab;
  var ppCursor: psqlite3_vtab_cursor);
var
  oCursor: TSQLiteVCursor;
begin
  oCursor := nil;
  try
    oCursor := VTabOpen();
    oCursor.FrCursor.pFDModule := FrTab.pFDModule;
    oCursor.FrCursor.pFDTable := Self;
    oCursor.FrCursor.pFDCursor := oCursor;
    oCursor.AllocColumns(Count);
    ppCursor := @oCursor.FrCursor;
  except
    on E: EDatabaseError do begin
      FDFree(oCursor);
      FResult := SQLITE_ERROR;
      Error(E.Message);
    end
    else begin
      FDFree(oCursor);
      raise;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.xClose(cursor: psqlite3_vtab_cursor);
var
  oCursor: TSQLiteVCursor;
begin
  oCursor := PFDsqlite3_vtab_cursor(cursor)^.pFDCursor;
  try
    if oCursor.FActive then begin
      oCursor.FActive := False;
      VTabClose(oCursor);
    end;
  finally
    PFDsqlite3_vtab_cursor(cursor)^.pFDCursor := nil;
    FDFree(oCursor);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVTable.VTabClose(ACursor: TSQLiteVCursor);
begin
  ACursor.VTabClose();
end;

{-------------------------------------------------------------------------------}
{ TSQLiteVCursor                                                                }
{-------------------------------------------------------------------------------}
constructor TSQLiteVCursor.Create(ATable: TSQLiteVTable);
begin
  inherited Create(ATable.FDatabase);
  FTable := ATable;
  FTable.FCursors.Add(Self);
  FActive := True;
end;

{-------------------------------------------------------------------------------}
destructor TSQLiteVCursor.Destroy;
begin
  if FTable <> nil then begin
    FTable.FCursors.Remove(Self);
    FTable := nil;
  end;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVCursor.Error(const AMsg: String);
begin
  FTable.Error(AMsg);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVCursor.xColumn(cursor: psqlite3_vtab_cursor;
  context: psqlite3_context; index: Integer);
begin
  ColsOUT[index].Handle := context;
  VTabColumn(index);
end;

{-------------------------------------------------------------------------------}
function TSQLiteVCursor.xEof(cursor: psqlite3_vtab_cursor): Integer;
begin
  try
    if VTabEof then
      Result := SQLITE_TRUE
    else
      Result := SQLITE_FALSE;
  except
    Result := SQLITE_FALSE;
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVCursor.xFilter(cursor: psqlite3_vtab_cursor; idxNum: Integer;
  idxStr: PUtf8; argc: Integer; argv: ppsqlite3_value);
var
  pVal: ppsqlite3_value;
  i: Integer;
  sIdxStr: String;
begin
  pVal := argv;
  // in some cases there case be lots of conditions for same column
  if argc > Count then
    AllocColumns(argc);
  for i := 0 to argc - 1 do begin
    ColsIN[i].Handle := pVal^;
    pVal := ppsqlite3_value(NativeUInt(pVal) + SizeOf(psqlite3_value));
  end;
  sIdxStr := FDatabase.Encoder.Decode(idxStr, -1, ecUTF8);
  if sIdxStr = #0 then
    sIdxStr := '';
  VTabFilter(idxNum, sIdxStr);
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVCursor.xNext(cursor: psqlite3_vtab_cursor);
begin
  VTabNext;
end;

{-------------------------------------------------------------------------------}
procedure TSQLiteVCursor.xRowid(cursor: psqlite3_vtab_cursor;
  var pRowid: sqlite3_int64);
begin
                                                       
  VTabRowid(pRowid);
end;

{-------------------------------------------------------------------------------}
function SQLiteNativeExceptionLoad(const AStorage: IFDStanStorage): TObject;
begin
  Result := ESQLiteNativeException.Create;
  ESQLiteNativeException(Result).LoadFromStorage(AStorage);
end;

initialization
  FDStorageManager().RegisterClass(ESQLiteNativeException, 'SQLiteNativeException',
    @SQLiteNativeExceptionLoad, @FDExceptionSave);
  FDExtensionManager().AddExtension([TSQLiteExpressionFunction, TFDPhysSQLiteLastAutoGenFunc]);

finalization
  FDFreeAndNil(GExtensionManager);

end.
