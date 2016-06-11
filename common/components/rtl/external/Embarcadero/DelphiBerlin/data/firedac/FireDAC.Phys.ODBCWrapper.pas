{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{           FireDAC ODBC API wrapping classes           }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.ODBCWrapper;

interface

uses
  System.Classes, Data.FMTBcd,
  FireDAC.Stan.Intf, FireDAC.Stan.Error, FireDAC.Stan.Util,
  FireDAC.Phys.ODBCCli;

type
  TFDODBCNativeError = class;
  EODBCNativeException = class;
  EODBCNativeExceptionClass = class of EODBCNativeException;
  TODBCLib = class;
  TODBCLibClass = class of TODBCLib;
  TODBCHandle = class;
  TODBCEnvironment = class;
  TODBCConnection = class;
  TODBCSelectItem = class;
  TODBCVariable = class;
  TODBCParameter = class;
  TODBCLongDataStream = class;
  TODBCColumn = class;
  TODBCVariableList = class;
  TODBCPageBuffer = class;
  TODBCStatementBase = class;
  TODBCCommandStatement = class;
  TODBCMetaInfoStatement = class;

  TODBCParseErrorEvent = procedure (AHandle: TODBCHandle; ARecNum: SQLSmallint;
    const ASQLState: String; ANativeError: SQLInteger; const ADiagMessage: String;
    const ACommandText: String; var AObj: String; var AKind: TFDCommandExceptionKind;
    var ACmdOffset: Integer) of object;
  TODBCGetMaxSizesEvent = procedure (AStrDataType: SQLSmallint; AFixedLen: Boolean;
    out ACharSize, AByteSize: Integer) of object;

  TFDODBCNativeError = class(TFDDBError)
  private
    FSQLState: String;
    FDiagMessage: String;
  protected
    procedure Assign(ASrc: TFDDBError); override;
    procedure LoadFromStorage(const AStorage: IFDStanStorage); override;
    procedure SaveToStorage(const AStorage: IFDStanStorage); override;
  public
    property SQLState: String read FSQLState;
    property DiagMessage: String read FDiagMessage;
  end;

  EODBCNativeException = class(EFDDBEngineException)
  private
    function GetErrors(AIndex: Integer): TFDODBCNativeError;
  protected
    function GetErrorClass: TFDDBErrorClass; override;
  public
    constructor Create(AStatus: SQLReturn; AOwner: TODBCHandle); overload; virtual;
    function AppendError(AHandle: TODBCHandle; ARecNum: SQLSmallint;
      const ASQLState: String; ANativeError: SQLInteger; const ADiagMessage,
      AResultMessage, ACommandText, AObject: String; AKind: TFDCommandExceptionKind;
      ACmdOffset, ARowIndex: Integer): TFDDBError; virtual;
    property Errors[Index: Integer]: TFDODBCNativeError read GetErrors; default;
  end;

{$IFDEF FireDAC_MONITOR}
  TODBCTracer = class(TThread)
  private
    FMonitor: IFDMoniClient;
    FLib: TODBCLib;
  {$IFDEF MSWINDOWS}
    FLockOutput: Integer;
  {$ENDIF}
    FEncoder: TFDEncoder;
  protected
    procedure Execute; override;
  public
    constructor Create(const AMonitor: IFDMoniClient; ALib: TODBCLib);
    destructor Destroy; override;
  end;
{$ENDIF}

  TODBCLib = class(TFDLibrary)
  private
{$IFDEF FireDAC_MONITOR}
    FTracer: TODBCTracer;
    FTraceClients: TFDObjList;
    FTracing: Boolean;
{$ENDIF}
    FhCPLib: THandle;
    function GetTRACE: Boolean;
    function GetTRACEFILE: string;
    procedure SetTRACE(AValue: Boolean);
    procedure SetTRACEFILE(const AValue: string);
  protected
    function GetODBCTextProcAddress(const AProcName: String; ARequired: Boolean = True): Pointer;
    procedure LoadLibrary(const ADLLNames: array of String; ARequired: Boolean); override;
    procedure LoadEntries; override;
  public
    SQLAllocHandle: TSQLAllocHandle;
    SQLBindCol: TSQLBindCol;
    SQLBindParameter: TSQLBindParameter;
    SQLCancel: TSQLCancel;
    SQLColAttribute: TSQLColAttribute;
    SQLColAttributeInt: TSQLColAttributeInt;
    SQLColAttributeString: TSQLColAttributeString;
    SQLColumns: TSQLColumns;
    SQLConnect: TSQLConnect;
    SQLDataSources: TSQLDataSources;
    SQLDescribeCol: TSQLDescribeCol;
    SQLDescribeParam: TSQLDescribeParam;
    SQLDisconnect: TSQLDisconnect;
    SQLDriverConnect: TSQLDriverConnect;
    SQLBrowseConnect: TSQLBrowseConnect;
    SQLDrivers: TSQLDrivers;
    SQLEndTran: TSQLEndTran;
    SQLExecDirect: TSQLExecDirect;
    SQLExecute: TSQLExecute;
    SQLFetch: TSQLFetch;
    SQLForeignKeys: TSQLForeignKeys;
    SQLFreeHandle: TSQLFreeHandle;
    SQLFreeStmt: TSQLFreeStmt;
    SQLGetConnectAttr: TSQLGetConnectAttr;
    SQLGetCursorName: TSQLGetCursorName;
    SQLGetData: TSQLGetData;
    SQLGetDescField: TSQLGetDescField;
    SQLGetDescRec: TSQLGetDescRec;
    SQLGetDiagRec: TSQLGetDiagRec;
    SQLGetDiagField: TSQLGetDiagField;
    SQLGetEnvAttr: TSQLGetEnvAttr;
    SQLGetFunctions: TSQLGetFunctions;
    SQLGetInfo: TSQLGetInfo;
    SQLGetInfoSQLLen: TSQLGetInfoSQLLen;
    SQLGetInfoInt: TSQLGetInfoInt;
    SQLGetInfoSmallint: TSQLGetInfoSmallint;
    SQLGetInfoString: TSQLGetInfoString;
    SQLGetStmtAttr: TSQLGetStmtAttr;
    SQLGetTypeInfo: TSQLGetTypeInfo;
    SQLMoreResults: TSQLMoreResults;
    SQLNumParams: TSQLNumParams;
    SQLNumResultCols: TSQLNumResultCols;
    SQLParamData: TSQLParamData;
    SQLPrepare: TSQLPrepare;
    SQLPrimaryKeys: TSQLPrimaryKeys;
    SQLProcedureColumns: TSQLProcedureColumns;
    SQLProcedures: TSQLProcedures;
    SQLPutData: TSQLPutData;
    SQLRowCount: TSQLRowCount;
    SQLSetConnectAttr: TSQLSetConnectAttr;
    SQLSetCursorName: TSQLSetCursorName;
    SQLSetDescField: TSQLSetDescField;
    SQLSetDescRec: TSQLSetDescRec;
    SQLSetEnvAttr: TSQLSetEnvAttr;
    SQLSetPos: TSQLSetPos;
    SQLSetStmtAttr: TSQLSetStmtAttr;
    SQLSpecialColumns: TSQLSpecialColumns;
    SQLStatistics: TSQLStatistics;
    SQLTablePrivileges: TSQLTablePrivileges;
    SQLTables: TSQLTables;
    // ODBCCP
    SQLConfigDataSource: TSQLConfigDataSource;
    SQLInstallerError: TSQLInstallerError;
    constructor Create(AOwningObj: TObject = nil);
    destructor Destroy; override;
    procedure Load(const AHome, ALib: String);
    procedure Unload; override;
    class function Allocate(const AHome, ALib: String; AOwningObj: TObject = nil): TODBCLib;
    class procedure Release(ALib: TODBCLib);
    class function DecorateKeyValue(const AValue: String): String;
    // Properties
{$IFDEF FireDAC_MONITOR}
    property Tracing: Boolean read FTracing;
    procedure ActivateTracing(const AMonitor: IFDMoniClient; AClient: TObject);
    procedure DeactivateTracing(AClient: TObject);
{$ENDIF}
    // ODBC
    property TRACE: Boolean read GetTRACE write SetTRACE;
    property TRACEFILE: string read GetTRACEFILE write SetTRACEFILE;
  end;

  TODBCHandle = class(TObject)
  private
    FHandle: SQLHandle;
    FHandleType: SQLSmallint;
    FOwnHandle: Boolean;
    FODBCLib: TODBCLib;
    FOwner: TODBCHandle;
    [weak] FOwningObj: TObject;
    FIgnoreErrors: Boolean;
    function GetConnection: TODBCConnection;
    procedure ProcessError(AStatus: SQLReturn);
{$IFDEF FireDAC_MONITOR}
    function GetTracing: Boolean;
{$ENDIF}
  protected
    procedure GetNonStrAttribute(AAttr: SQLInteger; ApValue: SQLPointer); virtual;
    procedure GetStrAttribute(AAttr: SQLInteger; out AValue: String); virtual;
    function GetCharAttribute(AAttr: SQLInteger): string;
    function GetIntAttribute(AAttr: SQLInteger): SQLInteger;
    function GetPSQLPAttribute(AAttr: SQLInteger): SQLPointer;
    function GetPUIntAttribute(AAttr: SQLInteger): PSQLUInteger;
    function GetPUSmIntAttribute(AAttr: SQLInteger): PSQLUSmallint;
    function GetUIntAttribute(AAttr: SQLInteger): SQLUInteger;
    function GetUSmIntAttribute(AAttr: SQLInteger): SQLUSmallint;
    function GetPtrAttribute(AAttr: SQLInteger): Pointer;
    function GetSQLLenAttribute(AAttr: SQLInteger): SQLLen;
    function GetSQLULenAttribute(AAttr: SQLInteger): SQLULen;
    function GetPSQLULenAttribute(AAttr: SQLInteger): PSQLULen;
    procedure SetAttribute(AAttr: SQLInteger; ApValue: SQLPointer; AType: SQLInteger); virtual;
    procedure SetPtrAttribute(AAttr: SQLInteger; AValue: Pointer);
    procedure SetCharAttribute(AAttr: SQLInteger; const AValue: String);
    procedure SetIntAttribute(AAttr: SQLInteger; AValue: SQLInteger);
    procedure SetPUIntAttribute(AAttr: SQLInteger; AValue: PSQLUInteger);
    procedure SetPUSmIntAttribute(AAttr: SQLInteger; AValue: PSQLUSmallint);
    procedure SetUIntAttribute(AAttr: SQLInteger; AValue: SQLUInteger);
    procedure SetUSmIntAttribute(AAttr: SQLInteger; AValue: SQLUSmallint);
    procedure SetSQLLenAttribute(AAttr: SQLInteger; AValue: SQLLen);
    procedure SetSQLULenAttribute(AAttr: SQLInteger; AValue: SQLULen);
    procedure SetPSQLULenAttribute(AAttr: SQLInteger; AValue: PSQLULen);
    procedure AllocHandle;
    procedure FreeHandle;
{$IFDEF FireDAC_MONITOR}
    procedure Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
      const AMsg: String; const AArgs: array of const);
    property Tracing: Boolean read GetTracing;
{$ENDIF}
    procedure FilterServerOuput(AConn: TODBCConnection; AExc: EODBCNativeException);
  public
    constructor Create;
    constructor CreateUsingHandle(AHandle: SQLHandle);
    destructor Destroy; override;
    procedure Check(AStatus: SQLReturn);
    property Handle: SQLHandle read FHandle;
    property HandleType: SQLSmallint read FHandleType;
    property IgnoreErrors: Boolean read FIgnoreErrors write FIgnoreErrors;
    property Lib: TODBCLib read FODBCLib;
    property Connection: TODBCConnection read GetConnection;
    property Owner: TODBCHandle read FOwner;
    property OwningObj: TObject read FOwningObj;
  end;

  TODBCEnvironment = class(TODBCHandle)
  private
    function DoDrivers(ADirection: SQLUSmallint; out ADriverDesc: String;
      out ADriverAttr: String): Boolean;
    function DoDSNs(ADirection: SQLUSmallint; out AServerName: String;
      out ADescription: String): Boolean;
  protected
    procedure GetNonStrAttribute(AAttr: SQLInteger; ApValue: SQLPointer); override;
    procedure GetStrAttribute(AAttr: SQLInteger; out AValue: String); override;
    procedure SetAttribute(AAttr: SQLInteger; ApValue: SQLPointer; AType: SQLInteger); override;
  public
    constructor Create(ALib: TODBCLib; AOwningObj: TObject = nil; AODBCVer: SQLUInteger = SQL_OV_ODBC3_80);
    constructor CreateUsingHandle(ALib: TODBCLib; AHandle: SQLHEnv; AOwningObj: TObject = nil);
    destructor Destroy; override;
    function DriverFirst(out ADriverDesc: String; out ADriverAttr: String): Boolean;
    function DriverNext(out ADriverDesc: String; out ADriverAttr: String): Boolean;
    function DSNFirst(out AServerName: String; out ADescription: String): Boolean;
    function DSNNext(out AServerName: String; out ADescription: String): Boolean;
    procedure GetDrivers(AList: TStrings; ADecorate: Boolean = False);
    procedure GetDSNs(AList: TStrings; AWithDescription: Boolean = False; ADecorate: Boolean = False);
    // Properties
    // ODBC
    property CONNECTION_POOLING: SQLUInteger index SQL_ATTR_CONNECTION_POOLING read GetUIntAttribute write SetUIntAttribute;
    property CP_MATCH: SQLUInteger index SQL_ATTR_CP_MATCH read GetUIntAttribute write SetUIntAttribute;
    property ODBC_VERSION: SQLUInteger index SQL_ATTR_ODBC_VERSION read GetUIntAttribute write SetUIntAttribute;
    property OUTPUT_NTS: SQLInteger index SQL_ATTR_OUTPUT_NTS read GetIntAttribute write SetIntAttribute;
    // Data Direct extensions
    property APP_UNICODE_TYPE: SQLInteger index SQL_ATTR_APP_UNICODE_TYPE read GetIntAttribute write SetIntAttribute;
  end;

  TODBCDriverKind = (dkOther, dkSQLSrv, dkSQLNC, dkSQLOdbc, dkFreeTDS, dkSQLSrvOther,
    dkDB2, dkMySQL, dkOracleOra, dkOracleMS, dkOracleOther, dkMSAccessJet,
    dkMSAccessACE, dkFirebird, dkInterbase, dkSQLAnywhere, dkSQLite, dkPostgreSQL,
    dkAdvantage, dkNexusDB, dkSybaseASE, dkInformix, dkPWMicroFocus, dkDBF,
    dkSQLBase, dkElevateDB, dkDBISAM, dkSolidDB, dkCache, dkTeradata, dkPervasive,
    dkDB2_400);
  TODBCConnection = class(TODBCHandle)
  private
    FEncoder: TFDEncoder;
    FInfo: EODBCNativeException;
    FOnParseError: TODBCParseErrorEvent;
    FOnGetMaxSizes: TODBCGetMaxSizesEvent;
    FRdbmsKind: TFDRDBMSKind;
    FDriverKind: TODBCDriverKind;
    FConnected: Boolean;
    FDecimalSepPar: Char;
    FDecimalSepCol: Char;
    FLastCommandText: String;
    FExceptionClass: EODBCNativeExceptionClass;
    FTransID: LongWord;
    FMaxColumnNameLen: SQLUSmallint;
    FDriverVersion: TFDVersion;
    FDriverODBCVersion: TFDVersion;
    FDriverEnvVersion: TFDVersion;
    FMSSQLVariantBinary: Boolean;
{$IFDEF FireDAC_MONITOR}
    FTracing: Boolean;
    function GetTracing: Boolean;
{$ENDIF}
    function GetInfoOptionSmInt(AInfoType: Integer): SQLUSmallint; inline;
    function GetInfoOptionUInt(AInfoType: Integer): SQLUInteger; inline;
    function GetInfoOptionULen(AInfoType: Integer): SQLULen; inline;
    function GetInfoOptionStr(AInfoType: Integer): String; inline;
    function GetKeywords: string;
    function GetInfoBase(AInfoType: SQLUSmallint;
      var AInfoValue: String): SQLReturn;
    procedure AfterConnect;
    procedure EndTran(AType: SQLSmallint);
    function GetIsolation: SQLInteger;
    procedure SetIsolation(const AValue: SQLInteger);
  protected
    procedure GetNonStrAttribute(AAttr: SQLInteger; ApValue: SQLPointer); override;
    procedure GetStrAttribute(AAttr: SQLInteger; out AValue: String); override;
    procedure SetAttribute(AAttr: SQLInteger; ApValue: SQLPointer; AType: SQLInteger); override;
    procedure GetInfo(AInfoType: SQLUSmallint; var AInfoValue: String); overload;
{$IFDEF FireDAC_64}
    procedure GetInfo(AInfoType: SQLUSmallint; var AInfoValue: SQLULen); overload;
{$ENDIF}
    procedure GetInfo(AInfoType: SQLUSmallint; var AInfoValue: SQLUInteger); overload;
    procedure GetInfo(AInfoType: SQLUSmallint; var AInfoValue: SQLUSmallint); overload;
    procedure ClearInfo;
  public
    constructor Create(AOwner: TODBCEnvironment; AOwningObj: TObject = nil);
    constructor CreateUsingHandle(AOwner: TODBCEnvironment; AHandle: SQLHDbc;
      AOwningObj: TObject = nil);
    destructor Destroy; override;
    function DriverConnect(const AConnString: String;
      ADriverCompletion: SQLUSmallint; AParentWnd: SQLHWnd): String;
    function Connect(const AConnString: String): String;
    procedure Disconnect;
    function GetFunctions(AFuncID: SQLUSmallint): SQLUSmallint;
    function EncodeName(const ACat, ASch, AObj: String): String;
    procedure ListServers(const AConnString: String; AList: TStrings);
    procedure Commit;
    procedure Rollback;
    procedure StartTransaction;
    // RW
    property RdbmsKind: TFDRDBMSKind read FRdbmsKind write FRdbmsKind;
    property DecimalSepCol: Char read FDecimalSepCol write FDecimalSepCol;
    property DecimalSepPar: Char read FDecimalSepPar write FDecimalSepPar;
    property MSSQLVariantBinary: Boolean read FMSSQLVariantBinary write FMSSQLVariantBinary;
    property TransID: LongWord read FTransID write FTransID;
    property ExceptionClass: EODBCNativeExceptionClass read FExceptionClass write FExceptionClass;
    property Info: EODBCNativeException read FInfo write FInfo;
{$IFDEF FireDAC_MONITOR}
    property Tracing: Boolean read GetTracing write FTracing;
{$ENDIF}
    // RO
    property Encoder: TFDEncoder read FEncoder;
    property Connected: Boolean read FConnected;
    property LastCommandText: String read FLastCommandText;
    property DriverKind: TODBCDriverKind read FDriverKind;
    property DriverVersion: TFDVersion read FDriverVersion;
    property DriverODBCVersion: TFDVersion read FDriverODBCVersion;
    property DriverEnvVersion: TFDVersion read FDriverEnvVersion;
    // ODBC attributes ----------
    property ACCESS_MODE: SQLUInteger index SQL_ATTR_ACCESS_MODE read GetUIntAttribute write SetUIntAttribute;
    property AUTOCOMMIT: SQLUInteger index SQL_ATTR_AUTOCOMMIT read GetUIntAttribute write SetUIntAttribute;
    property CONCURRENCY: SQLInteger index SQL_CONCURRENCY read GetIntAttribute write SetIntAttribute;
    property CURRENT_CATALOG: string index SQL_ATTR_CURRENT_CATALOG read GetCharAttribute write SetCharAttribute;
    property CURSOR_TYPE: SQLInteger index SQL_CURSOR_TYPE read GetIntAttribute write SetIntAttribute;
    property LOGIN_TIMEOUT: SQLUInteger index SQL_ATTR_LOGIN_TIMEOUT read GetUIntAttribute write SetUIntAttribute;
    property TXN_ISOLATION: SQLInteger read GetIsolation write SetIsolation;
    // MSSQL ----------
    property SS_PRESERVE_CURSORS: SQLUInteger index SQL_COPT_SS_PRESERVE_CURSORS read GetUIntAttribute write SetUIntAttribute;
    property SS_OLDPWD: string index SQL_COPT_SS_OLDPWD read GetCharAttribute write SetCharAttribute;
    property SS_BROWSE_CONNECT: SQLUInteger index SQL_COPT_SS_BROWSE_CONNECT read GetUIntAttribute write SetUIntAttribute;
    // ASA ----------
    property REGISTER_MESSAGE_CALLBACK: Pointer index SA_REGISTER_MESSAGE_CALLBACK read GetPtrAttribute write SetPtrAttribute;
    // DB2 ----------
    property LONGDATA_COMPAT: SQLUSmallint index SQL_ATTR_LONGDATA_COMPAT read GetUSmIntAttribute write SetUSmIntAttribute;
    property MAPCHAR: SQLUSmallint index SQL_ATTR_MAPCHAR read GetUSmIntAttribute write SetUSmIntAttribute;
    property DESCRIBE_OUTPUT_LEVEL: Integer index SQL_ATTR_DESCRIBE_OUTPUT_LEVEL read GetIntAttribute write SetIntAttribute;
    property USE_TRUSTED_CONTEXT: SQLUInteger index SQL_ATTR_USE_TRUSTED_CONTEXT read GetUIntAttribute write SetUIntAttribute;
    // Informix ----------
    property INFX_LO_AUTOMATIC: SQLUInteger index SQL_INFX_ATTR_LO_AUTOMATIC read GetUIntAttribute write SetUIntAttribute;
    property INFX_ODBC_TYPES_ONLY: SQLUInteger index SQL_INFX_ATTR_ODBC_TYPES_ONLY read GetUIntAttribute write SetUIntAttribute;
    property INFX_DEFAULT_UDT_FETCH_TYPE: SQLUInteger index SQL_INFX_ATTR_DEFAULT_UDT_FETCH_TYPE read GetUIntAttribute write SetUIntAttribute;
    property INFX_IDSISAMERRMSG: SQLUInteger index SQL_INFX_ATTR_IDSISAMERRMSG read GetUIntAttribute write SetUIntAttribute;
    // ODBC info ----------
    property CATALOG_USAGE: SQLUInteger index SQL_CATALOG_USAGE read GetInfoOptionUInt;
    property CATALOG_NAME_SEPARATOR: String index SQL_CATALOG_NAME_SEPARATOR read GetInfoOptionStr;
    property CATALOG_LOCATION: SQLUSmallint index SQL_CATALOG_LOCATION read GetInfoOptionSmInt;
    property CATALOG_TERM: String index SQL_CATALOG_TERM read GetInfoOptionStr;
    property DRIVER_HENV: SQLULen index SQL_DRIVER_HENV read GetInfoOptionULen;
    property FILE_USAGE: SQLUSmallint index SQL_FILE_USAGE read GetInfoOptionSmInt;
    property GETDATA_EXTENSIONS: SQLUInteger index SQL_GETDATA_EXTENSIONS read GetInfoOptionUInt;
    property IDENTIFIER_CASE: SQLUSmallint index SQL_IDENTIFIER_CASE read GetInfoOptionSmInt;
    property IDENTIFIER_QUOTE_CHAR: string index SQL_IDENTIFIER_QUOTE_CHAR read GetInfoOptionStr;
    property QUOTED_IDENTIFIER_CASE: SQLUSmallint index SQL_QUOTED_IDENTIFIER_CASE read GetInfoOptionSmInt;
    property MAX_CATALOG_NAME_LEN: SQLUSmallint index SQL_MAX_CATALOG_NAME_LEN read GetInfoOptionSmInt;
    property MAX_SCHEMA_NAME_LEN: SQLUSmallint index SQL_MAX_SCHEMA_NAME_LEN read GetInfoOptionSmInt;
    property MAX_TABLE_NAME_LEN: SQLUSmallint index SQL_MAX_TABLE_NAME_LEN read GetInfoOptionSmInt;
    // Renamed from MAX_COLUMN_NAME_LEN to MAX_COL_NAME_LEN to avoid conflict with C++Builder
    // with MAX_COLUMN_NAME_LEN defined in shlobj.h
    property MAX_COL_NAME_LEN: SQLUSmallint read FMaxColumnNameLen;
    property MAX_CONCURRENT_ACTIVITIES: SQLUSmallint index SQL_MAX_CONCURRENT_ACTIVITIES read GetInfoOptionSmInt;
    property MAX_IDENTIFIER_LEN: SQLUSmallint index SQL_MAX_IDENTIFIER_LEN read GetInfoOptionSmInt;
    property MAX_ROW_SIZE: SQLUSmallint index SQL_MAX_ROW_SIZE read GetInfoOptionSmInt;
    property MULTIPLE_ACTIVE_TXN: String index SQL_MULTIPLE_ACTIVE_TXN read GetInfoOptionStr;
    property SCHEMA_USAGE: SQLUInteger index SQL_SCHEMA_USAGE read GetInfoOptionUInt;
    property TXN_CAPABLE: SQLUSmallint index SQL_TXN_CAPABLE read GetInfoOptionSmInt;
    property TXN_ISOLATION_OPTION: SQLUInteger index SQL_TXN_ISOLATION_OPTION read GetInfoOptionUInt;
    property DM_VER: string index SQL_DM_VER read GetInfoOptionStr;
    property DM_ODBC_VER: string index SQL_ODBC_VER read GetInfoOptionStr;
    property DBMS_NAME: string index SQL_DBMS_NAME read GetInfoOptionStr;
    property DBMS_VER: string index SQL_DBMS_VER read GetInfoOptionStr;
    property DRIVER_NAME: string index SQL_DRIVER_NAME read GetInfoOptionStr;
    property DRIVER_VER: string index SQL_DRIVER_VER read GetInfoOptionStr;
    property DRIVER_ODBC_VER: string index SQL_DRIVER_ODBC_VER read GetInfoOptionStr;
    property INTERFACE_CONFORMANCE: SQLUInteger index SQL_ODBC_INTERFACE_CONFORMANCE read GetInfoOptionUInt;
    property API_CONFORMANCE: SQLUInteger  index SQL_ODBC_API_CONFORMANCE read GetInfoOptionUInt;
    property PARAM_ARRAY_ROW_COUNTS: SQLUInteger index SQL_PARAM_ARRAY_ROW_COUNTS read GetInfoOptionUInt;
    property PARAM_ARRAY_SELECTS: SQLUInteger index SQL_PARAM_ARRAY_SELECTS read GetInfoOptionUInt;
    property KEYWORDS: string read GetKeywords;
    property USER_NAME: string index SQL_USER_NAME read GetInfoOptionStr;
    property DATABASE_NAME: string index SQL_DATABASE_NAME read GetInfoOptionStr;
    property CURSOR_COMMIT_BEHAVIOR: SQLUSmallint index SQL_CURSOR_COMMIT_BEHAVIOR read GetInfoOptionSmInt;
    property CURSOR_ROLLBACK_BEHAVIOR: SQLUSmallint index SQL_CURSOR_ROLLBACK_BEHAVIOR read GetInfoOptionSmInt;
    property NULL_COLLATION: SQLUSmallint index SQL_NULL_COLLATION read GetInfoOptionSmInt;
    // Events
    property OnParseError: TODBCParseErrorEvent read FOnParseError write FOnParseError;
    property OnGetMaxSizes: TODBCGetMaxSizesEvent read FOnGetMaxSizes write FOnGetMaxSizes;
  end;

  TODBCSelectItem = class(TObject)
  private
    FColumnSize: SQLULen;
    FName: string;
    FNullable: SQLSmallint;
    FPosition: SQLSmallint;
    FScale: SQLSmallint;
    FSQLDataType: SQLSmallint;
    FStmt: TODBCStatementBase;
    function GetStrAttr(AIndex: Integer): String;
    function GetIntAttr(AIndex: Integer): SQLInteger;
    function GetIntAttrSilent(AIndex: Integer): SQLInteger;
    function GetSmallintAttr(AIndex: Integer): SQLSmallint;
    function GetSmallintAttrSilent(AIndex: Integer): SQLSmallint;
    function GetIsFixedLen: Boolean;
    function GetROWVER: SQLLen;
  public
    constructor Create(AOwner: TODBCStatementBase; AColNum: SQLSmallint);
    property AUTO_UNIQUE_VALUE: SQLInteger index SQL_DESC_AUTO_UNIQUE_VALUE read GetIntAttr;
    property ColumnSize: SQLULen read FColumnSize;
    property FIXED_PREC_SCALE: SQLInteger index SQL_DESC_FIXED_PREC_SCALE read GetIntAttr;
    property IsFixedLen: Boolean read GetIsFixedLen;
    property Name: String read FName;
    property NULLABLE: SQLSmallint read FNullable;
    property Position: SQLSmallint read FPosition;
    property ROWVER: SQLLen read GetROWVER;
    property Scale: SQLSmallint read FScale;
    property SEARCHABLE: SQLInteger index SQL_DESC_SEARCHABLE read GetIntAttr;
    property SQLDataType: SQLSmallint read FSQLDataType;
    property UNSIGNED: SQLInteger index SQL_DESC_UNSIGNED read GetIntAttr;
    property UPDATABLE: SQLInteger index SQL_DESC_UPDATABLE read GetIntAttr;
    property BASE_CATALOG_NAME: String index SQL_DESC_CATALOG_NAME read GetStrAttr;
    property BASE_SCHEMA_NAME: String index SQL_DESC_SCHEMA_NAME read GetStrAttr;
    property BASE_TABLE_NAME: String index SQL_DESC_BASE_TABLE_NAME read GetStrAttr;
    property BASE_COLUMN_NAME: String index SQL_DESC_BASE_COLUMN_NAME read GetStrAttr;
    property DATETIME_INTERVAL_PRECISION: SQLInteger index SQL_DESC_DATETIME_INTERVAL_PRECISION read GetIntAttrSilent;
    property DATETIME_INTERVAL_CODE: SQLSmallint index SQL_DESC_DATETIME_INTERVAL_CODE read GetSmallintAttrSilent;
    property PRECISION: SQLSmallint index SQL_DESC_PRECISION read GetSmallintAttr;
    property TYPE_NAME: String index SQL_DESC_TYPE_NAME read GetStrAttr;
    // MSSQL ----------
    // MSSQL 2005 & XML
    property XML_SCHEMACOLLECTION_CATALOG_NAME: String index SQL_CA_SS_XML_SCHEMACOLLECTION_CATALOG_NAME read GetStrAttr;
    property XML_SCHEMACOLLECTION_SCHEMA_NAME: String index SQL_CA_SS_XML_SCHEMACOLLECTION_SCHEMA_NAME read GetStrAttr;
    property XML_SCHEMACOLLECTION_NAME: String index SQL_CA_SS_XML_SCHEMACOLLECTION_NAME read GetStrAttr;
    // MSSQL 2005 & UDT
    property UDT_CATALOG_NAME: String index SQL_CA_SS_UDT_CATALOG_NAME read GetStrAttr;
    property UDT_SCHEMA_NAME: String index SQL_CA_SS_UDT_SCHEMA_NAME read GetStrAttr;
    property UDT_TYPE_NAME: String index SQL_CA_SS_UDT_TYPE_NAME read GetStrAttr;
    property UDT_ASSEMBLY_TYPE_NAME: String index SQL_CA_SS_UDT_ASSEMBLY_TYPE_NAME read GetStrAttr;
  end;

  TODBCVariable = class(TObject)
  private
    FCDataType: SQLSmallint;
    FColumnSize: SQLULen;
    FDataSize: SQLLen;
    FLastDataSize: SQLLen;
    FLocalBuffer: SQLPointer;
    FLocalBufIndicator: PSQLLen;
    FParamType: SQLSmallint;
    FPosition: SQLSmallint;
    FName: String;
    FScale: SQLInteger;
    FSQLDataType: SQLSmallint;
    FCVariantSbType: SQLSmallint;
    [weak] FList: TODBCVariableList;
    FForceLongData: Boolean;
    FLongData: Boolean;
    FBinded: Boolean;
    FStreamed: Boolean;
    FFlagsUpdated: Boolean;
    FForceLateBinding: Boolean;
    FLateBinding: Boolean;
    FIsParameter: Boolean;
    FIsCurrency: Boolean;
    FMSAccBoolean: Boolean;
    FMSSQLVariantBinary: Boolean;
    FDataReader: IUnknown;
{$IFDEF FireDAC_MONITOR}
    FDumpLabel: String;
{$ENDIF}
    function GetConnection: TODBCConnection; inline;
    function GetStatement: TODBCStatementBase; inline;
    function GetDumpLabel: String;
    function CalcDataSize(AColumnSize: SQLULen): SQLLen;
    procedure VarTypeUnsup(ACType: SQLSmallint);
    procedure SetCDataType(const AValue: SQLSmallint);
    procedure SetDataSize(const AValue: SQLLen);
    procedure SetSQLDataType(const AValue: SQLSmallint);
    procedure SetForceLongData(const AValue: Boolean);
    procedure SetForceLateBinding(const AValue: Boolean);
    function AllocLongData(AIndex: SQLULen; ASize: SQLLen): PSQLPointer;
    procedure FreeLongData(AIndex: SQLULen);
    function GetAsStrings(AIndex: SQLULen): String;
    procedure SetColumnSize(const AValue: SQLULen);
    procedure SetBindAttributes(ADescKind: SQLInteger);
  protected
    function GetDataInd(AIndex: SQLULen; out ApData: SQLPointer;
      out ApInd: PSQLLen): PSQLPointer;
    function GetDataPtr(AIndex: SQLULen; out ApData: SQLPointer;
      out ASize: SQLLen; out ApInd: PSQLLen): PSQLPointer;
    procedure InternalBind; virtual; abstract;
    function GetDecimalSeparator: Char; virtual; abstract;
    class function GetDescriptorType: SQLSmallint; virtual; abstract;
    property LocalBuffer: SQLPointer read FLocalBuffer write FLocalBuffer;
    property LocalBufIndicator: PSQLLen read FLocalBufIndicator
      write FLocalBufIndicator;
  public
    constructor Create;
    destructor Destroy; override;
    procedure UpdateFlags;
    procedure ResetFlagsUpdated;
    procedure Bind;
    function GetData(AIndex: SQLULen; var ApData: SQLPointer;
      var ASize: SQLLen; AByRef: Boolean = False): Boolean;
    procedure SetData(AIndex: SQLULen; ApData: SQLPointer;
      ASize: SQLLen);
    procedure SetDataReader(AIndex: SQLULen; ApData: SQLPointer);
{$IFDEF FireDAC_MONITOR}
    function DumpValue(AIndex: SQLULen; var ASize: SQLLen): String; overload;
    function DumpValue(AIndex: SQLULen): String; overload;
    function DumpCDataType: String;
    function DumpParamType: String;
{$ENDIF}
    // properties
    // RO
    property Connection: TODBCConnection read GetConnection;
    property Statement: TODBCStatementBase read GetStatement;
    property Binded: Boolean read FBinded;
    property IsParameter: Boolean read FIsParameter;
    property ParamType: SQLSmallint read FParamType;
    property LongData: Boolean read FLongData;
    property LateBinding: Boolean read FLateBinding;
    property DecimalSeparator: Char read GetDecimalSeparator;
    property DescriptorType: SQLSmallint read GetDescriptorType;
    property IsCurrency: Boolean read FIsCurrency;
    property AsStrings[AIndex: SQLULen]: String read GetAsStrings;
    property DataReader: IUnknown read FDataReader;
    // RW
    property SQLDataType: SQLSmallint read FSQLDataType write SetSQLDataType;
    property CDataType: SQLSmallint read FCDataType write SetCDataType;
    property DataSize: SQLLen read FDataSize write SetDataSize;
    property ColumnSize: SQLULen read FColumnSize write SetColumnSize;
    property Scale: SQLInteger read FScale write FScale;
    property CVariantSbType: SQLSmallint read FCVariantSbType write FCVariantSbType;
    property Position: SQLSmallint read FPosition write FPosition;
    property ForceLongData: Boolean read FForceLongData write SetForceLongData;
    property ForceLateBinding: Boolean read FForceLateBinding write SetForceLateBinding;
    property Streamed: Boolean read FStreamed write FStreamed;
    property MSAccBoolean: Boolean read FMSAccBoolean write FMSAccBoolean;
    property MSSQLVariantBinary: Boolean read FMSSQLVariantBinary write FMSSQLVariantBinary;
    property Name: String read FName write FName;
{$IFDEF FireDAC_MONITOR}
    property DumpLabel: String read GetDumpLabel write FDumpLabel;
{$ENDIF}
  end;

  TODBCParameter = class(TODBCVariable)
  private
    FColumnList: TODBCVariableList;
    FDataTypeName: String;
    procedure SetParamType(const AValue: SQLSmallint);
    function GetColumnList: TODBCVariableList;
  protected
    procedure InternalBind; override;
    function GetDecimalSeparator: Char; override;
    class function GetDescriptorType: SQLSmallint; override;
  public
    constructor Create;
    destructor Destroy; override;
    property ParamType write SetParamType;
    property ColumnList: TODBCVariableList read GetColumnList;
    property DataTypeName: String read FDataTypeName write FDataTypeName;
  end;

  TODBCLongDataStream = class(TStream)
  private
    FParam: TODBCParameter;
    FMode: TFDStreamMode;
    FPosition: SQLLen;
    FState: Integer;
    FSize: SQLLen;
    procedure CheckMode(AMode: TFDStreamMode; const AMsg: String);
    function GetStmt: TODBCCommandStatement;
  protected
    function GetSize: Int64; override;
  public
    constructor Create(AParam: TODBCParameter; AMode: TFDStreamMode);
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
    property Param: TODBCParameter read FParam;
    property Stmt: TODBCCommandStatement read GetStmt;
  end;

  TODBCColumn = class(TODBCVariable)
  protected
    procedure InternalBind; override;
    function GetDecimalSeparator: Char; override;
    class function GetDescriptorType: SQLSmallint; override;
  public
    constructor Create;
  end;

  TODBCVariableList = class(TObject)
  private
    FList: TFDObjList;
    [weak] FOwner: TODBCStatementBase;
    FParameters: Boolean;
    FBuffer: TODBCPageBuffer;
    FHasLateBindedVars: Boolean;
    FChildList: Boolean;
    function GetCount: Integer;
    function GetItems(AIndex: Integer): TODBCVariable;
    procedure Rebind(AFixedLenOnly: Boolean = False);
    procedure UpdateHasLateBindedVars;
  public
    constructor Create(AOwner: TODBCStatementBase; AParams, AChildList: Boolean);
    destructor Destroy; override;
    function Add(AVar: TODBCVariable): TODBCVariable;
    procedure Bind(ARowCount: SQLULen; AFixedLenOnly: Boolean);
    function FindByToken(ApToken: SQLPointer): TODBCVariable;
    procedure Clear;
    procedure ResetDataReaders;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TODBCVariable read GetItems; default;
    property Owner: TODBCStatementBase read FOwner;
    property Parameters: Boolean read FParameters;
    property HasLateBindedVars: Boolean read FHasLateBindedVars;
    property ChildList: Boolean read FChildList;
  end;

  TODBCPageBuffer = class(TObject)
  private
    FIsAllocated: Boolean;
    FRowCount: SQLULen;
    FRowsProcessed: SQLULen;
    FRowStatusArr: array of SQLUSmallint;
    FRowOperationArr: array of SQLUSmallint;
    FVariableList: TODBCVariableList;
    FShifted: SQLLen;
    function GetPageSize: SQLULen;
    function GetRowSize: SQLULen;
    function GetRowStatusArr(AIndex: SQLULen): SQLUSmallint;
    function GetRowOperationArr(AIndex: SQLULen): SQLUSmallint;
  protected
    procedure SetStmtAttributes;
    procedure AllocBuffers;
    procedure FreeBuffers;
    procedure GetDataPtr(AVar: TODBCVariable; AIndex: SQLULen;
      out ApData: SQLPointer; out ApInd: PSQLLen);
    procedure ShiftBuffersPtr(ARowCount: SQLLen);
    procedure UnShift;
    procedure SetOperationRange(ARowCount, AOffset: SQLULen);
  public
    constructor Create(AVarList: TODBCVariableList);
    destructor Destroy; override;
    property Shifted: SQLLen read FShifted;
    property PageSize: SQLULen read GetPageSize;
    property RowCount: SQLULen read FRowCount;
    property RowSize: SQLULen read GetRowSize;
    property RowsProcessed: SQLULen read FRowsProcessed;
    property RowStatusArr[AIndex: SQLULen]: SQLUSmallint read GetRowStatusArr;
    property RowOperationArr[AIndex: SQLULen]: SQLUSmallint read GetRowOperationArr;
  end;

  TODBCStatementBase = class(TODBCHandle)
  private
    FColumnList: TODBCVariableList;
    FMaxStringSize: SQLUInteger;
    FStrsTrim: Boolean;
    FStrsEmpty2Null: Boolean;
    FExecuted: Boolean;
    FNoMoreResults: Boolean;
    FResultCols: SQLSmallint;
    FPieceBuffLen: SQLInteger;
    FMoneySupported: Boolean;
    FQueryTimeout: SQLULen;
    function GetLongVarPiece(AVar: TODBCVariable; ApData: SQLPointer;
      ASize: SQLLen; ApInd: PSQLLen): SQLReturn; overload;
    function GetLongVarPiece(AVar: TODBCVariable; AIndex: Integer;
      ASize: SQLLen): SQLReturn; overload;
    function GetLongVarFinished(ASize: SQLLen; ARet: SQLReturn; AInd: SQLLen): Boolean;
    procedure GetLongVar(AVar: TODBCVariable; AIndex: Integer);
    procedure FetchLateBindedColumns(AIndex: SQLULen);
    function GetCursorName: String;
    procedure SetCursorName(const AValue: String);
{$IFDEF FireDAC_MONITOR}
    procedure DumpColumns(ARows: SQLULen; AEof: Boolean);
{$ENDIF}
    function GetSQLLenDiag(ARecNo, ADiagID: Integer): SQLLen;
    function GetIntDiag(ARecNo, ADiagID: Integer): SQLInteger;
    function GetStrDiag(ARecNo, ADiagID: Integer): String;
    function GetUSmallIntDiag(ARecNo, ADiagID: Integer): SQLUSmallint;
    procedure SetQueryTimeout(const AValue: SQLULen);
    function GetQueryTimeout: SQLULen;
  protected
    procedure ColAttributeInt(AColNum, AFieldId: SQLUSmallint;
      var AAttr: SQLLen);
    procedure ColAttributeIntSilent(AColNum, AFieldId: SQLUSmallint;
      var AAttr: SQLLen);
    procedure ColAttributeSmallint(AColNum, AFieldId: SQLUSmallint;
      var AAttr: SQLSmallint);
    procedure ColAttributeSmallintSilent(AColNum, AFieldId: SQLUSmallint;
      var AAttr: SQLSmallint);
    procedure ColAttributeString(AColNum, AFieldId: SQLUSmallint;
      var AAttr: String);
    procedure GetNonStrAttribute(AAttr: SQLInteger; ApValue: SQLPointer); override;
    procedure GetStrAttribute(AAttr: SQLInteger; out AValue: String); override;
    procedure SetAttribute(AAttr: SQLInteger; ApValue: SQLPointer; AType: SQLInteger); override;
  public
    constructor Create(AOwner: TODBCConnection; AOwningObj: TObject = nil);
    destructor Destroy; override;
    function NumResultCols: SQLSmallint;
    function ResultColsExists: Boolean;
    procedure BindColumns(ARowCount: SQLULen);
    procedure UnbindColumns;
    function AddCol(APos, ASQLType, ACType: SQLSmallint; ALen: SQLULen = MAXINT): TODBCColumn;
    function Fetch(ARowCount: SQLLen = SQL_NULL_DATA): SQLULen;
    function MoreResults: Boolean;
    procedure Cancel;
    procedure Close;
    procedure Unprepare; virtual;
    // properties
    property ColumnList: TODBCVariableList read FColumnList;
    property Executed: Boolean read FExecuted;
    property NoMoreResults: Boolean read FNoMoreResults;
    // FireDAC
    property MaxStringSize: SQLUInteger read FMaxStringSize write FMaxStringSize;
    property StrsTrim: Boolean read FStrsTrim write FStrsTrim;
    property StrsEmpty2Null: Boolean read FStrsEmpty2Null write FStrsEmpty2Null;
    property PieceBuffLen: SQLInteger read FPieceBuffLen write FPieceBuffLen;
    property MoneySupported: Boolean read FMoneySupported write FMoneySupported;
    // ODBC ----------
    property CURSOR_TYPE: SQLULen index SQL_ATTR_CURSOR_TYPE read GetSQLULenAttribute write SetSQLULenAttribute;
    property CURSOR_NAME: String read GetCursorName write SetCursorName;
    property CONCURRENCY: SQLULen index SQL_ATTR_CONCURRENCY read GetSQLULenAttribute write SetSQLULenAttribute;
    property IMP_PARAM_DESC: SQLPointer index SQL_ATTR_IMP_PARAM_DESC read GetPSQLPAttribute;
    property MAX_ROWS: SQLULen index SQL_ATTR_MAX_ROWS read GetSQLULenAttribute write SetSQLULenAttribute;
    property NOSCAN: SQLULen index SQL_ATTR_NOSCAN read GetSQLULenAttribute write SetSQLULenAttribute;
    property QUERY_TIMEOUT: SQLULen read GetQueryTimeout write SetQueryTimeout;
    property ROWS_FETCHED_PTR: PSQLULen index SQL_ATTR_ROWS_FETCHED_PTR read GetPSQLULenAttribute write SetPSQLULenAttribute;
    property ROW_ARRAY_SIZE: SQLULen index SQL_ATTR_ROW_ARRAY_SIZE read GetSQLULenAttribute write SetSQLULenAttribute;
    property ROW_BIND_TYPE: SQLULen index SQL_ATTR_ROW_BIND_TYPE read GetSQLULenAttribute write SetSQLULenAttribute;
    property ROW_STATUS_PTR: PSQLUSmallint index SQL_ATTR_ROW_STATUS_PTR read GetPUSmIntAttribute write SetPUSmIntAttribute;
    property ROW_OPERATION_PTR: PSQLUSmallint index SQL_ATTR_ROW_OPERATION_PTR read GetPUSmIntAttribute write SetPUSmIntAttribute;
    // MSSQL ----------
    property SS_NOCOUNT_STATUS: SQLLen index SQL_SOPT_SS_NOCOUNT_STATUS read GetSQLLenAttribute write SetSQLLenAttribute;
    property SS_CURSOR_OPTIONS: SQLLen index SQL_SOPT_SS_CURSOR_OPTIONS read GetSQLLenAttribute write SetSQLLenAttribute;
    // MSSQL 2005 & Query Notification
    property SS_QUERYNOTIFICATION_TIMEOUT: SQLLen index SQL_SOPT_SS_QUERYNOTIFICATION_TIMEOUT read GetSQLLenAttribute write SetSQLLenAttribute;
    property SS_QUERYNOTIFICATION_MSGTEXT: String index SQL_SOPT_SS_QUERYNOTIFICATION_MSGTEXT read GetCharAttribute write SetCharAttribute;
    property SS_QUERYNOTIFICATION_OPTIONS: String index SQL_SOPT_SS_QUERYNOTIFICATION_OPTIONS read GetCharAttribute write SetCharAttribute;
    // Informix ----------
    property INFX_LO_AUTOMATIC: SQLUInteger index SQL_INFX_ATTR_LO_AUTOMATIC read GetUIntAttribute write SetUIntAttribute;
    property INFX_ODBC_TYPES_ONLY: SQLUInteger index SQL_INFX_ATTR_ODBC_TYPES_ONLY read GetUIntAttribute write SetUIntAttribute;
    property INFX_DEFAULT_UDT_FETCH_TYPE: SQLUInteger index SQL_INFX_ATTR_DEFAULT_UDT_FETCH_TYPE read GetUIntAttribute write SetUIntAttribute;
    // Teradata
    property TDATA_AGKR: SQLUInteger index SQL_ATTR_AGKR read GetUIntAttribute write SetUIntAttribute;
    // Diagnostic ----------
    property DIAG_SQLSTATE[ARecNo: Integer]: String index SQL_DIAG_SQLSTATE read GetStrDiag;
    property DIAG_ROW_NUMBER[ARecNo: Integer]: SQLLen index SQL_DIAG_ROW_NUMBER read GetSQLLenDiag;
    property DIAG_COLUMN_NUMBER[ARecNo: Integer]: SQLInteger index SQL_DIAG_COLUMN_NUMBER read GetIntDiag;
    // MSSQL
    property DIAG_SS_LINE[ARecNo: Integer]: SQLUSmallint index SQL_DIAG_SS_LINE read GetUSmallIntDiag;
    property DIAG_SS_MSGSTATE[ARecNo: Integer]: SQLInteger index SQL_DIAG_SS_MSGSTATE read GetIntDiag;
    property DIAG_SS_SEVERITY[ARecNo: Integer]: SQLInteger index SQL_DIAG_SS_SEVERITY read GetIntDiag;
    property DIAG_SS_PROCNAME[ARecNo: Integer]: String index SQL_DIAG_SS_PROCNAME read GetStrDiag;
    property DIAG_SS_SRVNAME[ARecNo: Integer]: String index SQL_DIAG_SS_SRVNAME read GetStrDiag;
//    property DIAG_SS_TABLE_COLUMN_NUMBER[ARecNo: Integer]: SQLInteger index SQL_DIAG_SS_TABLE_COLUMN_NUMBER read GetIntDiag;
//    property DIAG_SS_TABLE_ROW_NUMBER[ARecNo: Integer]: SQLInteger index SQL_DIAG_SS_TABLE_ROW_NUMBER read GetIntDiag;
    // Informix
    property DIAG_INFX_ISAM_ERROR[ARecNo: Integer]: SQLInteger index SQL_DIAG_ISAM_ERROR read GetIntDiag;
  end;

  TODBCCommandStatement = class(TODBCStatementBase)
  private
    FParamList: TODBCVariableList;
    FParamSetSupported: Boolean;
    [weak] FFocusedParam: TODBCParameter;
    FFocusedResult: SQLReturn;
    procedure PutBlobParam(AParam: TODBCParameter; AIndex: Integer);
    procedure PutTableParam(AParam: TODBCParameter; AIndex: Integer; AFirst: Boolean);
    procedure PutStreamParam(AParam: TODBCParameter; AIndex: Integer);
    function PutLongParams: SQLReturn;
    procedure GetStreamParam(AParam: TODBCParameter; AIndex: Integer);
    function GetLongParams: SQLReturn;
{$IFDEF FireDAC_MONITOR}
    procedure DumpParameters(AInput: Boolean; AOffset, ATimes: Integer);
{$ENDIF}
    function GetPARAMSET_SIZE: SQLULen;
    procedure SetPARAMSET_SIZE(const AValue: SQLULen);
  public
    constructor Create(AOwner: TODBCConnection; AOwningObj: TObject = nil);
    destructor Destroy; override;
    procedure BindParameters(ARowCount: SQLUInteger; AFixedLenOnly: Boolean);
    procedure UnbindParameters;
    procedure UpdateRowsAffected(var ACount: SQLLen);
    procedure Execute(ARowCount, AOffset: SQLUInteger; var ACount: SQLLen;
      AExact: Boolean; const AExecDirectCommand: String);
    procedure FlushLongData;
    procedure Open(ARowCount: SQLUInteger; const AExecDirectCommand: String);
    function NumParams: SQLSmallint;
    procedure Prepare(const ACommandText: String);
    procedure Unprepare; override;
    // Properties
    // FireDAC ----------
    property FocusedParam: TODBCParameter read FFocusedParam;
    property FocusedResult: SQLReturn read FFocusedResult;
    property ParamList: TODBCVariableList read FParamList;
    property ParamSetSupported: Boolean read FParamSetSupported write FParamSetSupported;
    // ODBC  ----------
    property PARAMSET_SIZE: SQLULen read GetPARAMSET_SIZE write SetPARAMSET_SIZE;
    property PARAMS_PROCESSED_PTR: PSQLULen index SQL_ATTR_PARAMS_PROCESSED_PTR read GetPSQLULenAttribute write SetPSQLULenAttribute;
    property PARAM_BIND_TYPE: SQLULen index SQL_ATTR_PARAM_BIND_TYPE read GetSQLULenAttribute write SetSQLULenAttribute;
    property PARAM_STATUS_PTR: PSQLUSmallint index SQL_ATTR_PARAM_STATUS_PTR read GetPUSmIntAttribute write SetPUSmIntAttribute;
    property PARAM_OPERATION_PTR: PSQLUSmallint index SQL_ATTR_PARAM_OPERATION_PTR read GetPUSmIntAttribute write SetPUSmIntAttribute;
    // DB2 ----------
    property PARAMOPT_ATOMIC: SQLInteger index SQL_ATTR_PARAMOPT_ATOMIC read GetIntAttribute write SetIntAttribute;
    // MSSQL ----------
    property SS_PARAM_FOCUS: SQLUInteger index SQL_SOPT_SS_PARAM_FOCUS read GetUIntAttribute write SetUIntAttribute;
  end;

  TODBCMetaInfoStatement = class(TODBCStatementBase)
  private
    FMode: Integer;
    FCatalog, FSchema, FObject: String;
    FColumn: String;
    FFKCatalog, FFKSchema, FFKTable: String;
    FIdentifierType: SQLUSmallint;
    FUnique: SQLUSmallint;
    FTableTypes: String;
  public
    procedure Columns(const ACatalog, ASchema, ATable, AColumn: String);
    procedure TypeColumns(const ACatalog, ASchema, ATable, AColumn: String);
    procedure ForeignKeys(const APKCatalog, APKSchema, APKTable, AFKCatalog,
      AFKSchema, AFKTable: String);
    procedure PrimaryKeys(const ACatalog, ASchema, ATable: String);
    procedure Procedures(const ACatalog, ASchema, AProc: String);
    procedure ProcedureColumns(const ACatalog, ASchema, AProc, AColumn: String);
    procedure SpecialColumns(const ACatalog, ASchema, ATable: String;
      AIdentifierType: SQLUSmallint);
    procedure Statistics(const ACatalog, ASchema, ATable: String; AUnique: SQLUSmallint);
    procedure Tables(const ACatalog, ASchema, ATable, ATableTypes: String);
    procedure Catalogs;
    procedure Schemas;
    procedure Execute;
    // MSSQL ----------
    property SS_NAME_SCOPE: SQLUInteger index SQL_SOPT_SS_NAME_SCOPE read GetUIntAttribute write SetUIntAttribute;
  end;

const
  C_DEF_NUM_PREC = 31;
  C_DEF_NUM_SCALE = 6;

procedure ODBCNumeric2BCD(const ANum: TSQLNumericRec; out ABcd: TBcd);
procedure ODBCBcd2Numeric(const ABcd: TBcd; out ANum: TSQLNumericRec);
procedure ODBCNumeric2Currency(const ANum: TSQLNumericRec; out ACurr: Currency);
procedure ODBCCurrency2Numeric(ACurr: Currency; out ANum: TSQLNumericRec);

{-------------------------------------------------------------------------------}
implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.SyncObjs, Data.SqlTimSt, System.DateUtils, Data.DB,
    System.Generics.Collections, System.Types,
  FireDAC.Stan.Consts, FireDAC.Stan.SQLTimeInt,
  FireDAC.Phys.Intf;

const
  CStateUndef = '<undef>';
  CErrorItemTextFmt = 'SQL state: %s. Native error: %d. Error message: ' + C_FD_EOL + '%s';
  CInfoItemTextFmt = 'SQL state: %s. Native code: %d. Message: ' + C_FD_EOL + '%s';

const
  C_RETURNED_STRING_MAXLEN = 1024;
  C_DRIVER_DESC_MAXLEN = 255;
  C_STRING_ATTR_MAXLEN = 255;
  C_DRIVER_ATTR_MAXLEN = 4000;
{$IFDEF FireDAC_MONITOR}
  C_BuffSize = 4096;
  C_PipeName: String = '\\.\pipe\fdodbc';
{$ENDIF}

var
  GODBCLib: TODBCLib = nil;
  GODBCLibClients: Integer = 0;
  GLock: TCriticalSection = nil;

{-------------------------------------------------------------------------------}
procedure ODBCSetLength(var AStr: String; ALen: Integer);
begin
  if ALen <= Length(AStr) then begin
    while (ALen > 0) and (AStr[ALen] = #0) do
      Dec(ALen);
    SetLength(AStr, ALen);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDODBCNativeError                                                            }
{-------------------------------------------------------------------------------}
procedure TFDODBCNativeError.Assign(ASrc: TFDDBError);
begin
  inherited Assign(ASrc);
  if ASrc is TFDODBCNativeError then begin
    FSQLState := TFDODBCNativeError(ASrc).FSQLState;
    FDiagMessage := TFDODBCNativeError(ASrc).FDiagMessage;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDODBCNativeError.LoadFromStorage(const AStorage: IFDStanStorage);
begin
  inherited LoadFromStorage(AStorage);
  FSQLState := AStorage.ReadString('SQLState', '');
  FDiagMessage := AStorage.ReadString('DiagMessage', '');
end;

{-------------------------------------------------------------------------------}
procedure TFDODBCNativeError.SaveToStorage(const AStorage: IFDStanStorage);
begin
  inherited SaveToStorage(AStorage);
  AStorage.WriteString('SQLState', SQLState, '');
  AStorage.WriteString('DiagMessage', DiagMessage, '');
end;

{-------------------------------------------------------------------------------}
{ EODBCNativeException                                                          }
{-------------------------------------------------------------------------------}
constructor EODBCNativeException.Create(AStatus: SQLReturn; AOwner: TODBCHandle);
var
  iRecNum: SQLSmallint;
  iDiagMesLen: SQLSmallint;
  iNativeError: SQLInteger;
  sDrv, sSQLState,
  sDiagMessage, sRetCode,
  sResultMes, sCmd: string;
  aDiagMesBuffer: array [0 .. SQL_MAX_MESSAGE_LENGTH] of SQLChar;
  eKind: TFDCommandExceptionKind;
  oHandle: TODBCHandle;
  oConn: TODBCConnection;
  iFDCode: Integer;
begin
  eKind := ekOther;
  iFDCode := er_FD_ODBCGeneral;
  case AStatus of
  SQL_SUCCESS:           sRetCode := 'SQL_SUCCESS';
  SQL_SUCCESS_WITH_INFO: sRetCode := 'SQL_SUCCESS_WITH_INFO';
  SQL_ERROR:             sRetCode := 'SQL_ERROR';
  SQL_INVALID_HANDLE:    sRetCode := 'SQL_INVALID_HANDLE';
  SQL_STILL_EXECUTING:   sRetCode := 'SQL_STILL_EXECUTING';
  SQL_NEED_DATA:         sRetCode := 'SQL_NEED_DATA';
  SQL_NO_DATA:
    begin
      sRetCode := 'SQL_NO_DATA';
      eKind := ekNoDataFound;
      iFDCode := er_FD_AccExactMismatch;
    end;
  SQL_PARAM_DATA_AVAILABLE:
    begin
      sRetCode := 'SQL_PARAM_DATA_AVAILABLE';
      eKind := ekTooManyRows;
      iFDCode := er_FD_AccExactMismatch;
    end;
  end;
  oConn := AOwner.Connection;
  if (oConn <> nil) and oConn.Connected then begin
    sDrv := '';
    oConn.GetInfoBase(SQL_DRIVER_NAME, sDrv);
    sCmd := oConn.LastCommandText;
  end
  else begin
    sDrv := 'CLI';
    sCmd := '';
  end;
  oHandle := AOwner;
  while (oHandle <> nil) and (oHandle.Handle = nil) do
    oHandle := oHandle.Owner;
  inherited Create(iFDCode,
    FDExceptionLayers([S_FD_LPhys, S_FD_ODBCId, sDrv]) + ' ' + sRetCode);
  if AStatus <> SQL_SUCCESS then begin
    SetLength(sSQLState, 5);
    iRecNum := 1;
    while True do begin
      iDiagMesLen := 0;
      iNativeError := 0;
      if not (oHandle.Lib.SQLGetDiagRec(oHandle.HandleType, oHandle.Handle,
          iRecNum, PSQLChar(sSQLState), iNativeError, @aDiagMesBuffer[0],
          SQL_MAX_MESSAGE_LENGTH, iDiagMesLen) in [SQL_SUCCESS, SQL_SUCCESS_WITH_INFO]) then
        Break;
      SetString(sDiagMessage, PChar(@aDiagMesBuffer[0]), iDiagMesLen);
      if sSQLState[1] = #0 then
        sSQLState := CStateUndef;
      if AStatus = SQL_SUCCESS_WITH_INFO then
        sResultMes := Format(CInfoItemTextFmt, [sSQLState, iNativeError, sDiagMessage])
      else
        sResultMes := Format(CErrorItemTextFmt, [sSQLState, iNativeError, sDiagMessage]);
      if iRecNum = 1 then
        Message := FDExceptionLayers([S_FD_LPhys, S_FD_ODBCId]) + sDiagMessage;
      AppendError(oHandle, iRecNum, sSQLState, iNativeError, sDiagMessage,
        sResultMes, sCmd, '', eKind, -1, -1);
{$IFDEF FireDAC_MONITOR}
      AOwner.Trace(ekError, esProgress, sDiagMessage,
        ['SQLState', sSQLState, 'NativeError', iNativeError, 'RecNum', iRecNum]);
{$ENDIF}
      Inc(iRecNum);
    end;
    if iRecNum = 1 then
      inherited AppendError(iRecNum, AStatus, sRetCode, '', eKind, -1, -1);
  end;
end;

{-------------------------------------------------------------------------------}
function EODBCNativeException.AppendError(AHandle: TODBCHandle;
  ARecNum: SQLSmallint; const ASQLState: String; ANativeError: SQLInteger;
  const ADiagMessage, AResultMessage, ACommandText, AObject: String;
  AKind: TFDCommandExceptionKind; ACmdOffset, ARowIndex: Integer): TFDDBError;
var
  oStmt: TODBCCommandStatement;
  oErr: TFDODBCNativeError;
  lPrevIgnoreErrors: Boolean;
  iRowNum: SQLInteger;
begin
  if AKind = ekOther then
    if ASQLState = 'HY008' then
      AKind := ekCmdAborted
    else if (ASQLState = 'HYT01') or (ASQLState = 'HYT00') then begin
      AKind := ekCmdAborted;
      FDCode := er_FD_StanTimeout;
      Message := FDGetErrorMessage(er_FD_StanTimeout, []);
    end
    else if (ASQLState = '08S01') or (ASQLState = '08S02') or
            (ASQLState = '08007') or (ASQLState = '08001') or
            (ASQLState = '08003') or (ASQLState = '08004') then
      AKind := ekServerGone
    else if (ASQLState = '07001') or (ASQLState = '07002') then
      AKind := ekInvalidParams;
  if (AHandle is TODBCCommandStatement) and (ARowIndex = -1) then begin
    oStmt := TODBCCommandStatement(AHandle);
    lPrevIgnoreErrors := oStmt.IgnoreErrors;
    oStmt.IgnoreErrors := True;
    try
      iRowNum := SQLInteger(oStmt.DIAG_ROW_NUMBER[ARecNum]);
      if (iRowNum <> SQL_NO_ROW_NUMBER) and (iRowNum <> SQL_ROW_NUMBER_UNKNOWN) then
        ARowIndex := iRowNum - 1
      else
        ARowIndex := -1;
    finally
      oStmt.IgnoreErrors := lPrevIgnoreErrors;
    end;
    if ARowIndex < 0 then
      ARowIndex := -1
    else if TODBCCommandStatement(AHandle).ParamList.FBuffer <> nil then
      Inc(ARowIndex, TODBCCommandStatement(AHandle).ParamList.FBuffer.Shifted);
  end;
  Result := inherited AppendError(ARecNum, ANativeError, AResultMessage, AObject,
    AKind, ACmdOffset, ARowIndex);
  oErr := TFDODBCNativeError(Result);
  oErr.FSQLState := ASQLState;
  oErr.FDiagMessage := ADiagMessage;
end;

{-------------------------------------------------------------------------------}
function EODBCNativeException.GetErrorClass: TFDDBErrorClass;
begin
  Result := TFDODBCNativeError;
end;

{-------------------------------------------------------------------------------}
function EODBCNativeException.GetErrors(AIndex: Integer): TFDODBCNativeError;
begin
  Result := inherited Errors[AIndex] as TFDODBCNativeError;
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
{ TODBCTracer                                                                   }
{-------------------------------------------------------------------------------}
{$WARNINGS OFF}
constructor TODBCTracer.Create(const AMonitor: IFDMoniClient; ALib: TODBCLib);
begin
  {$IFDEF MSWINDOWS}
  inherited Create(True);
  FreeOnTerminate := True;
  FMonitor := AMonitor;
  FLib := ALib;
  ALib.FTracer := Self;
  FEncoder := TFDEncoder.Create(nil);
  FEncoder.Encoding := ecANSI;
  Resume;
  Sleep(200);
  Inc(FLockOutput);
  try
    ALib.TRACEFILE := C_PipeName;
    ALib.TRACE := True;
    if ALib.TRACE then
      ALib.FTracing := True;
  finally
    Dec(FLockOutput);
  end;
  {$ELSE}
  FDCapabilityNotSupported(nil, [S_FD_LPhys, S_FD_ODBCId]);
  {$ENDIF}
end;
{$WARNINGS ON}

{-------------------------------------------------------------------------------}
destructor TODBCTracer.Destroy;
begin
  FDFreeAndNil(FEncoder);
  FLib.FTracer := nil;
  FLib.FTracing := False;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
  {$IFDEF MSWINDOWS}
procedure TODBCTracer.Execute;
var
  hPipe: THandle;
  dwTotalBytesAvail: DWORD;
  dwBytesRead: DWORD;
  aBuff: array [0 .. C_BuffSize - 1] of Byte;
  sMsg: String;
  i, iLen: Cardinal;
  pStr: PChar;
  pMsg: PChar;

  procedure NotifyError;
  begin
    if not Terminated then
      FMonitor.Notify(ekError, esProgress, FLib.OwningObj,
        'ODBC tracer failed: ' + FDLastSystemErrorMsg, []);
  end;

begin
  hPipe := CreateNamedPipe(PChar(C_PipeName), PIPE_ACCESS_INBOUND,
    PIPE_TYPE_BYTE or PIPE_READMODE_BYTE or PIPE_WAIT, 1,
    C_BuffSize, C_BuffSize, INFINITE, nil);
  if hPipe = INVALID_HANDLE_VALUE then begin
    NotifyError;
    Exit;
  end;
  if not ConnectNamedPipe(hPipe, nil) then begin
    NotifyError;
    CloseHandle(hPipe);
    Exit;
  end;
  try
    while not Terminated and FMonitor.Tracing do begin
      dwTotalBytesAvail := 0;
      dwBytesRead := 0;
      if not PeekNamedPipe(hPipe, nil, 0, nil, @dwTotalBytesAvail, nil) or
         (dwTotalBytesAvail > 0) and
           not ReadFile(hPipe, aBuff, C_BuffSize, dwBytesRead, nil) and
           (GetLastError <> ERROR_MORE_DATA) then begin
        NotifyError;
        Terminate;
      end
      else if (dwTotalBytesAvail > 0) and (dwBytesRead > 0) then begin
        if FLockOutput = 0 then begin
          pMsg := nil;
          iLen := Cardinal(FEncoder.Decode(@aBuff, dwBytesRead, Pointer(pMsg)));
          i := 0;
          while (i < iLen) and ((pMsg[i] = #13) or (pMsg[i] = #10)) do
            Inc(i);
          // cut app name, thread id, etc from ODBC trace message
          pStr := StrPos(pMsg + i, PChar(#9'ENTER '));
          if pStr <> nil then begin
            Inc(pStr);
            iLen := iLen - i - Cardinal(pStr - (pMsg + i));
          end
          else begin
            pStr := StrPos(pMsg + i, PChar(#9'EXIT '));
            if pStr <> nil then begin
              Inc(pStr);
              iLen := iLen - i - Cardinal(pStr - (pMsg + i));
            end
            else begin
              pStr := pMsg + i;
              iLen := iLen - i;
            end;
          end;
          SetString(sMsg, pStr, iLen);
          FMonitor.Notify(ekVendor, esProgress, FLib.OwningObj, sMsg, []);
        end;
      end
      else if dwTotalBytesAvail = 0 then
        Sleep(1);
    end;
  finally
    FMonitor := nil;
    DisconnectNamedPipe(hPipe);
    CloseHandle(hPipe);
  end;
end;
  {$ELSE}
procedure TODBCTracer.Execute;
begin
                                               
end;
  {$ENDIF}
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TODBCLib                                                                      }
{-------------------------------------------------------------------------------}
constructor TODBCLib.Create(AOwningObj: TObject = nil);
begin
  inherited Create(S_FD_ODBCId, AOwningObj);
{$IFDEF FireDAC_MONITOR}
  FTraceClients := TFDObjList.Create;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
destructor TODBCLib.Destroy;
begin
{$IFDEF FireDAC_MONITOR}
  DeactivateTracing(nil);
  FDFreeAndNil(FTraceClients);
{$ENDIF}
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TODBCLib.Load(const AHome, ALib: String);
var
  sDllName: String;
begin
  if ALib = '' then
    sDllName := C_ODBC
  else
    sDllName := ALib;
  if AHome <> '' then
    sDllName := FDNormPath(AHome) + sDllName;
  inherited Load([sDllName], True);
end;

{-------------------------------------------------------------------------------}
procedure TODBCLib.Unload;
begin
  inherited Unload;
  if FhCPLib <> 0 then begin
    FreeLibrary(FhCPLib);
    FhCPLib := 0;
  end;
end;

{-------------------------------------------------------------------------------}
class function TODBCLib.Allocate(const AHome, ALib: String; AOwningObj: TObject): TODBCLib;
begin
  if GLock <> nil then
    GLock.Enter;
  try
    Inc(GODBCLibClients);
    if GODBCLibClients = 1 then begin
      GODBCLib := TODBCLib.Create(AOwningObj);
      GODBCLib.Load(AHome, ALib);
    end;
    Result := GODBCLib;
  finally
    if GLock <> nil then
      GLock.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
class procedure TODBCLib.Release(ALib: TODBCLib);
begin
  if GLock <> nil then
    GLock.Enter;
  try
    if (ALib = GODBCLib) and (GODBCLibClients > 0) then begin
      Dec(GODBCLibClients);
      if GODBCLibClients = 0 then
        FDFreeAndNil(GODBCLib);
    end;
  finally
    if GLock <> nil then
      GLock.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCLib.GetODBCTextProcAddress(const AProcName: String; ARequired: Boolean = True): Pointer;
begin
  Result := GetProc(AProcName + 'W', ARequired);
end;

{-------------------------------------------------------------------------------}
function TODBCLib.GetTRACE: Boolean;
var
  iStringLen: SQLInteger;
  iValue: SQLUInteger;
begin
  iStringLen := 0;
  SQLGetConnectAttr(nil, SQL_ATTR_TRACE, @iValue, 0, iStringLen);
  Result := iValue = SQL_TRUE;
end;

{-------------------------------------------------------------------------------}
function TODBCLib.GetTRACEFILE: string;
var
  iStringLen: SQLInteger;
begin
  SetLength(Result, SQL_MAX_MESSAGE_LENGTH);
  iStringLen := 0;
  SQLGetConnectAttr(nil, SQL_ATTR_TRACEFILE, PChar(Result), SQL_MAX_MESSAGE_LENGTH,
    iStringLen);
  SetLength(Result, iStringLen);
end;

{-------------------------------------------------------------------------------}
procedure TODBCLib.LoadLibrary(const ADLLNames: array of String; ARequired: Boolean);
begin
  inherited LoadLibrary(ADLLNames, ARequired);
  FhCPLib := SafeLoadLibrary(C_ODBCCP);
end;

{-------------------------------------------------------------------------------}
procedure TODBCLib.LoadEntries;
var
  hPrev: THandle;
begin
  @SQLAllocHandle        := GetProc('SQLAllocHandle');
  @SQLBindCol            := GetProc('SQLBindCol');
  @SQLBindParameter      := GetProc('SQLBindParameter');
  @SQLCancel             := GetProc('SQLCancel');
  @SQLColAttribute       := GetODBCTextProcAddress('SQLColAttribute');
  @SQLColAttributeString := @SQLColAttribute;
  @SQLColAttributeInt    := @SQLColAttribute;
  @SQLColumns            := GetODBCTextProcAddress('SQLColumns');
  @SQLDataSources        := GetODBCTextProcAddress('SQLDataSources', False);
  @SQLDescribeCol        := GetODBCTextProcAddress('SQLDescribeCol');
  @SQLDisconnect         := GetProc('SQLDisconnect');
  @SQLDescribeParam      := GetProc('SQLDescribeParam');
  @SQLDriverConnect      := GetODBCTextProcAddress('SQLDriverConnect');
  @SQLBrowseConnect      := GetODBCTextProcAddress('SQLBrowseConnect');
  @SQLDrivers            := GetODBCTextProcAddress('SQLDrivers', False);
  @SQLEndTran            := GetProc('SQLEndTran');
  @SQLExecDirect         := GetODBCTextProcAddress('SQLExecDirect');
  @SQLExecute            := GetProc('SQLExecute');
  @SQLFetch              := GetProc('SQLFetch');
  @SQLForeignKeys        := GetODBCTextProcAddress('SQLForeignKeys');
  @SQLFreeHandle         := GetProc('SQLFreeHandle');
  @SQLFreeStmt           := GetProc('SQLFreeStmt');
  @SQLGetConnectAttr     := GetODBCTextProcAddress('SQLGetConnectAttr');
  @SQLGetCursorName      := GetODBCTextProcAddress('SQLGetCursorName');
  @SQLGetData            := GetProc('SQLGetData');
  @SQLGetDescField       := GetODBCTextProcAddress('SQLGetDescField');
  @SQLGetDescRec         := GetODBCTextProcAddress('SQLGetDescRec');
  @SQLGetDiagRec         := GetODBCTextProcAddress('SQLGetDiagRec');
  @SQLGetDiagField       := GetODBCTextProcAddress('SQLGetDiagField');
  @SQLGetEnvAttr         := GetProc('SQLGetEnvAttr');
  @SQLGetFunctions       := GetProc('SQLGetFunctions');
  @SQLGetInfo            := GetODBCTextProcAddress('SQLGetInfo');
  @SQLGetInfoString      := @SQLGetInfo;
  @SQLGetInfoSmallint    := @SQLGetInfo;
  @SQLGetInfoInt         := @SQLGetInfo;
  @SQLGetInfoSQLLen      := @SQLGetInfo;
  @SQLGetStmtAttr        := GetODBCTextProcAddress('SQLGetStmtAttr');
  @SQLGetTypeInfo        := GetODBCTextProcAddress('SQLGetTypeInfo');
  @SQLMoreResults        := GetProc('SQLMoreResults');
  @SQLNumParams          := GetProc('SQLNumParams');
  @SQLNumResultCols      := GetProc('SQLNumResultCols');
  @SQLParamData          := GetProc('SQLParamData');
  @SQLPrepare            := GetODBCTextProcAddress('SQLPrepare');
  @SQLPrimaryKeys        := GetODBCTextProcAddress('SQLPrimaryKeys');
  @SQLProcedureColumns   := GetODBCTextProcAddress('SQLProcedureColumns');
  @SQLProcedures         := GetODBCTextProcAddress('SQLProcedures');
  @SQLPutData            := GetProc('SQLPutData');
  @SQLRowCount           := GetProc('SQLRowCount');
  @SQLSetConnectAttr     := GetODBCTextProcAddress('SQLSetConnectAttr');
  @SQLSetCursorName      := GetODBCTextProcAddress('SQLSetCursorName');
  @SQLSetDescField       := GetODBCTextProcAddress('SQLSetDescField');
  @SQLSetDescRec         := GetProc('SQLSetDescRec');
  @SQLSetEnvAttr         := GetProc('SQLSetEnvAttr');
  @SQLSetPos             := GetProc('SQLSetPos');
  @SQLSetStmtAttr        := GetODBCTextProcAddress('SQLSetStmtAttr');
  @SQLSpecialColumns     := GetODBCTextProcAddress('SQLSpecialColumns');
  @SQLStatistics         := GetODBCTextProcAddress('SQLStatistics');
  @SQLTablePrivileges    := GetODBCTextProcAddress('SQLTablePrivileges');
  @SQLTables             := GetODBCTextProcAddress('SQLTables');
  // ODBCCP
  hPrev := FhDLL;
  FhDLL := FhCPLib;
  try
    // Some ODBC managers may not export these entries (eg, Data Direct
    // ODBC manager on Linux)
    @SQLConfigDataSource := GetODBCTextProcAddress('SQLConfigDataSource' {$IFDEF POSIX}, False {$ENDIF});
    @SQLInstallerError   := GetODBCTextProcAddress('SQLInstallerError' {$IFDEF POSIX}, False {$ENDIF});
  finally
    FhDLL := hPrev;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCLib.SetTRACE(AValue: Boolean);
begin
  SQLSetConnectAttr(nil, SQL_ATTR_TRACE, SQLPointer(NativeUInt(AValue)), SQL_IS_INTEGER);
end;

{-------------------------------------------------------------------------------}
procedure TODBCLib.SetTRACEFILE(const AValue: string);
begin
  SQLSetConnectAttr(nil, SQL_ATTR_TRACEFILE, PChar(AValue), SQL_NTS);
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
procedure TODBCLib.ActivateTracing(const AMonitor: IFDMoniClient; AClient: TObject);
begin
  if GLock <> nil then
    GLock.Enter;
  try
    if FTraceClients.IndexOf(AClient) = -1 then
      FTraceClients.Add(AClient);
    if (FTraceClients.Count > 0) and (FTracer = nil) then
      TODBCTracer.Create(AMonitor, Self);
  finally
    if GLock <> nil then
      GLock.Release;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCLib.DeactivateTracing(AClient: TObject);
begin
  if GLock <> nil then
    GLock.Enter;
  try
    if AClient = nil then
      FTraceClients.Clear
    else
      FTraceClients.Remove(AClient);
    if (FTraceClients.Count = 0) and (FTracer <> nil) then begin
      FTracer.Terminate;
      TRACE := False;
      Sleep(200);
    end;
  finally
    if GLock <> nil then
      GLock.Release;
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TODBCLib.DecorateKeyValue(const AValue: String): String;
var
  i: Integer;
begin
  Result := AValue;
  for i := 1 to Length(Result) do
    if Pos(Result[i], '[]{}(),;?*=!@') <> 0 then begin
      Result := '{' + Result + '}';
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
{ TODBCHandle                                                                   }
{-------------------------------------------------------------------------------}
constructor TODBCHandle.Create;
begin
  inherited Create;
  FOwner := nil;
  FHandleType := 0;
  FHandle := SQL_NULL_HDBC;
  FODBCLib := nil;
  FOwnHandle := True;
end;

{-------------------------------------------------------------------------------}
constructor TODBCHandle.CreateUsingHandle(AHandle: SQLHandle);
begin
  inherited Create;
  FOwner := nil;
  FHandleType := 0;
  FHandle := AHandle;
  FODBCLib := nil;
  FOwnHandle := False;
end;

{-------------------------------------------------------------------------------}
destructor TODBCHandle.Destroy;
begin
  if FHandle <> SQL_NULL_HANDLE then
    FreeHandle;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TODBCHandle.GetConnection: TODBCConnection;
var
  oHndl: TODBCHandle;
begin
  oHndl := Self;
  while (oHndl <> nil) and not (oHndl is TODBCConnection) do
    oHndl := oHndl.Owner;
  Result := TODBCConnection(oHndl);
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.AllocHandle;
var
  InputHandle: SQLHandle;
begin
  ASSERT(FHandle = nil);
  if FOwner <> nil then
    InputHandle := FOwner.Handle
  else
    InputHandle := SQL_NULL_HANDLE;
  Check(Lib.SQLAllocHandle(FHandleType, InputHandle, FHandle));
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.FilterServerOuput(AConn: TODBCConnection; AExc: EODBCNativeException);
var
  i: Integer;
begin
  i := 0;
  while i <= AExc.ErrorCount - 1 do
    if AExc.Errors[i].Kind = ekServerOutput then begin
      if AConn.FInfo = nil then
        AConn.FInfo := EODBCNativeException.Create(SQL_SUCCESS, Self);
      AConn.FInfo.Append(AExc.Errors[i]);
      AExc.Remove(AExc.Errors[i]);
    end
    else
      Inc(i);
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.ProcessError(AStatus: SQLReturn);
var
  oConn: TODBCConnection;
  oExc: EODBCNativeException;
begin
  FIgnoreErrors := True;
  try
    oConn := Connection;
    case AStatus of
    SQL_SUCCESS_WITH_INFO:
      if oConn <> nil then begin
        oExc := oConn.ExceptionClass.Create(AStatus, Self);
        if (oConn.DriverKind in [dkSQLSrv, dkSQLNC, dkSQLOdbc, dkFreeTDS, dkSQLSrvOther]) and (
            // MSSQL:
            // if "The statement has been terminated" and few error items,
            // then most probable batch has been terminated due to errors
            (oExc.ErrorCount > 1) and (oExc.Errors[oExc.ErrorCount - 1].ErrorCode = 3621) or
            // if severity level is greater than or equal to 11, then it is error
            (Self is TODBCStatementBase) and (TODBCStatementBase(Self).DIAG_SS_SEVERITY[1] >= 11)
            // if "Duplicate key was ignored", then severity is 16, not 10 as described in BOL
           ) and not ((oExc.ErrorCount >= 1) and (oExc.Errors[0].ErrorCode = 3604)) then begin
          FilterServerOuput(oConn, oExc);
          FDException(OwningObj, oExc {$IFDEF FireDAC_Monitor}, oConn.Tracing {$ENDIF});
        end
        else if (oConn.DriverKind in [dkDB2, dkDB2_400]) and
            // DB2:
            // SQL0803N  One or more values in the INSERT statement, UPDATE statement,
            // or foreign key update caused by a DELETE statement are not valid because
            // the primary key, unique constraint or unique index identified ....
            (oExc.ErrorCount = 1) and (oExc.Errors[0].ErrorCode = -803) then
          FDException(OwningObj, oExc {$IFDEF FireDAC_Monitor}, oConn.Tracing {$ENDIF})
        else if (oConn.DriverKind = dkInformix) and (oExc.ErrorCount >= 1) and (
            // Informix:
            // most errors are reported as SQL_SUCCESS_WITH_INFO
            // 01 - warning class
            (Copy(oExc.Errors[0].SQLState, 1, 2) <> '01') and
            // IM - warning class
            (Copy(oExc.Errors[0].SQLState, 1, 2) <> 'IM') and
            // empty SQL State - real SQL_SUCCESS_WITH_INFO
            (oExc.Errors[0].SQLState <> '')) then
          FDException(OwningObj, oExc {$IFDEF FireDAC_Monitor}, oConn.Tracing {$ENDIF})
        else begin
          if oConn.FInfo <> nil then begin
            oConn.FInfo.Merge(oExc, oConn.FInfo.ErrorCount);
            FDFree(oExc);
          end
          else
            oConn.FInfo := oExc;
        end;
      end;
    SQL_NEED_DATA,
    SQL_INVALID_HANDLE,
    SQL_STILL_EXECUTING,
    SQL_ERROR,
    SQL_NO_DATA,
    SQL_PARAM_DATA_AVAILABLE:
      begin
        if oConn <> nil then begin
          oExc := oConn.ExceptionClass.Create(AStatus, Self);
          FilterServerOuput(oConn, oExc);
        end
        else
          oExc := EODBCNativeException.Create(AStatus, Self);
        FDException(OwningObj, oExc
          {$IFDEF FireDAC_Monitor}, (oConn <> nil) and oConn.Tracing {$ENDIF});
      end;
    end;
  finally
    FIgnoreErrors := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.Check(AStatus: SQLReturn);
begin
  if (AStatus <> SQL_SUCCESS) and not FIgnoreErrors then
    ProcessError(AStatus);
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.FreeHandle;
begin
  if FOwnHandle then
    Check(Lib.SQLFreeHandle(FHandleType, FHandle));
  FHandle := SQL_NULL_HANDLE;
end;

{-------------------------------------------------------------------------------}
function TODBCHandle.GetCharAttribute(AAttr: SQLInteger): string;
begin
  GetStrAttribute(AAttr, Result);
end;

{-------------------------------------------------------------------------------}
function TODBCHandle.GetIntAttribute(AAttr: SQLInteger): SQLInteger;
begin
  GetNonStrAttribute(AAttr, @Result);
end;

{-------------------------------------------------------------------------------}
function TODBCHandle.GetPSQLPAttribute(AAttr: SQLInteger): SQLPointer;
begin
  Result := nil;
  GetNonStrAttribute(AAttr, Result);
end;

{-------------------------------------------------------------------------------}
function TODBCHandle.GetPUIntAttribute(AAttr: SQLInteger): PSQLUInteger;
begin
  Result := nil;
  GetNonStrAttribute(AAttr, Result);
end;

{-------------------------------------------------------------------------------}
function TODBCHandle.GetPUSmIntAttribute(AAttr: SQLInteger): PSQLUSmallint;
begin
  Result := nil;
  GetNonStrAttribute(AAttr, Result);
end;

{-------------------------------------------------------------------------------}
function TODBCHandle.GetUIntAttribute(AAttr: SQLInteger): SQLUInteger;
begin
  GetNonStrAttribute(AAttr, @Result);
end;

{-------------------------------------------------------------------------------}
function TODBCHandle.GetUSmIntAttribute(AAttr: SQLInteger): SQLUSmallint;
begin
  GetNonStrAttribute(AAttr, @Result);
end;

{-------------------------------------------------------------------------------}
function TODBCHandle.GetSQLLenAttribute(AAttr: SQLInteger): SQLLen;
begin
  GetNonStrAttribute(AAttr, @Result);
end;

{-------------------------------------------------------------------------------}
function TODBCHandle.GetSQLULenAttribute(AAttr: SQLInteger): SQLULen;
begin
  GetNonStrAttribute(AAttr, @Result);
end;

{-------------------------------------------------------------------------------}
function TODBCHandle.GetPSQLULenAttribute(AAttr: SQLInteger): PSQLULen;
begin
  Result := nil;
  GetNonStrAttribute(AAttr, Result);
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.GetNonStrAttribute(AAttr: SQLInteger; ApValue: SQLPointer);
begin
  ASSERT(False);
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.GetStrAttribute(AAttr: SQLInteger; out AValue: String);
begin
  ASSERT(False);
end;

{-------------------------------------------------------------------------------}
function TODBCHandle.GetPtrAttribute(AAttr: SQLInteger): Pointer;
begin
  Result := nil;
  GetNonStrAttribute(AAttr, @Result);
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.SetCharAttribute(AAttr: SQLInteger; const AValue: String);
const
  C_Null: SQLChar = #0;
var
  pCh: PSQLChar;
begin
  if AValue = '' then
    pCh := @c_null
  else
    pCh := PSQLChar(AValue);
  SetAttribute(AAttr, pCh, SQL_NTS);
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.SetIntAttribute(AAttr: SQLInteger; AValue: SQLInteger);
begin
  SetAttribute(AAttr, PSQLInteger(AValue), SQL_IS_INTEGER);
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.SetPUIntAttribute(AAttr: SQLInteger; AValue: PSQLUInteger);
begin
  SetAttribute(AAttr, AValue, SQL_IS_POINTER);
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.SetPUSmIntAttribute(AAttr: SQLInteger; AValue: PSQLUSmallint);
begin
  SetAttribute(AAttr, AValue, SQL_IS_POINTER);
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.SetUIntAttribute(AAttr: SQLInteger; AValue: SQLUInteger);
begin
  SetAttribute(AAttr, PSQLUInteger(AValue), SQL_IS_UINTEGER);
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.SetUSmIntAttribute(AAttr: SQLInteger; AValue: SQLUSmallint);
begin
  SetAttribute(AAttr, PSQLUSmallint(AValue), SQL_IS_USMALLINT);
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.SetSQLLenAttribute(AAttr: SQLInteger; AValue: SQLLen);
begin
  SetAttribute(AAttr, PSQLLen(AValue), SQL_IS_INTEGER);
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.SetSQLULenAttribute(AAttr: SQLInteger; AValue: SQLULen);
begin
  SetAttribute(AAttr, PSQLULen(AValue), SQL_IS_UINTEGER);
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.SetPSQLULenAttribute(AAttr: SQLInteger; AValue: PSQLULen);
begin
  SetAttribute(AAttr, AValue, SQL_IS_POINTER);
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.SetPtrAttribute(AAttr: SQLInteger; AValue: Pointer);
begin
  SetAttribute(AAttr, AValue, SQL_IS_POINTER);
end;

{-------------------------------------------------------------------------------}
procedure TODBCHandle.SetAttribute(AAttr: SQLInteger; ApValue: SQLPointer; AType: SQLInteger);
begin
  ASSERT(False);
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
procedure TODBCHandle.Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
  const AMsg: String; const AArgs: array of const);
begin
  if Tracing then
    Lib.FTracer.FMonitor.Notify(AKind, AStep, OwningObj, AMsg, AArgs);
end;

{-------------------------------------------------------------------------------}
function TODBCHandle.GetTracing: Boolean;
begin
  Result := (Self <> nil) and Lib.Tracing and (Lib.FTracer <> nil) and
    (Lib.FTracer.FMonitor <> nil);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TODBCEnvironment                                                              }
{-------------------------------------------------------------------------------}
constructor TODBCEnvironment.Create(ALib: TODBCLib; AOwningObj: TObject;
  AODBCVer: SQLUInteger);
begin
  inherited Create;
  FOwningObj := AOwningObj;
  FHandleType := SQL_HANDLE_ENV;
  FODBCLib := ALib;
  AllocHandle;
  if AODBCVer = SQL_OV_ODBC3_80 then begin
    if Lib.SQLSetEnvAttr(FHandle, SQL_ATTR_ODBC_VERSION,
        PSQLUInteger(SQL_OV_ODBC3_80), SQL_IS_UINTEGER) = SQL_ERROR then
      ODBC_VERSION := SQL_OV_ODBC3;
  end
  else
    ODBC_VERSION := AODBCVer;
{$IFDEF POSIX}
  APP_UNICODE_TYPE := SQL_DD_CP_UTF16;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
constructor TODBCEnvironment.CreateUsingHandle(ALib: TODBCLib;
  AHandle: SQLHEnv; AOwningObj: TObject);
begin
  inherited CreateUsingHandle(AHandle);
  FOwningObj := AOwningObj;
  FHandleType := SQL_HANDLE_ENV;
  FODBCLib := ALib;
end;

{-------------------------------------------------------------------------------}
destructor TODBCEnvironment.Destroy;
begin
  // Required to fix the issue:
  // http://www.da-soft.com/forums/anydac-general-english/anydac-informix-sql-error.html#21498
  IgnoreErrors := True;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TODBCEnvironment.GetNonStrAttribute(AAttr: SQLInteger; ApValue: SQLPointer);
var
  iStringLen: SQLInteger;
begin
  iStringLen := 0;
  Check(Lib.SQLGetEnvAttr(FHandle, AAttr, ApValue, 0, iStringLen));
end;

{-------------------------------------------------------------------------------}
procedure TODBCEnvironment.GetStrAttribute(AAttr: SQLInteger; out AValue: String);
begin
  FDCapabilityNotSupported(Self, [S_FD_LPhys, S_FD_ODBCId]);
end;

{-------------------------------------------------------------------------------}
procedure TODBCEnvironment.SetAttribute(AAttr: SQLInteger; ApValue: SQLPointer;
  AType: SQLInteger);
begin
  Check(Lib.SQLSetEnvAttr(FHandle, AAttr, ApValue, 0));
end;

{-------------------------------------------------------------------------------}
function TODBCEnvironment.DoDrivers(ADirection: SQLUSmallint; out ADriverDesc: String;
  out ADriverAttr: String): Boolean;
var
  iDriverDescLen: SQLSmallint;
  iDriverAttrLen: SQLSmallint;
  iRet: SQLReturn;
begin
  if not Assigned(Lib.SQLDrivers) then begin
    Result := False;
    Exit;
  end;
  SetLength(ADriverDesc, C_DRIVER_DESC_MAXLEN);
  SetLength(ADriverAttr, C_DRIVER_ATTR_MAXLEN);
  iDriverDescLen := 0;
  iDriverAttrLen := 0;
  iRet := Lib.SQLDrivers(FHandle, ADirection, PSQLChar(ADriverDesc),
    C_DRIVER_DESC_MAXLEN, iDriverDescLen, PSQLChar(ADriverAttr),
    C_DRIVER_ATTR_MAXLEN, iDriverAttrLen);
  if iRet = SQL_NO_DATA then
    Result := False
  else begin
    Check(iRet);
    Result := True;
  end;
  SetLength(ADriverDesc, iDriverDescLen);
  SetLength(ADriverAttr, iDriverAttrLen);
end;

{-------------------------------------------------------------------------------}
function TODBCEnvironment.DriverFirst(out ADriverDesc: String;
  out ADriverAttr: String): Boolean;
begin
  Result := DoDrivers(SQL_FETCH_FIRST, ADriverDesc, ADriverAttr);
end;

{-------------------------------------------------------------------------------}
function TODBCEnvironment.DriverNext(out ADriverDesc: String;
  out ADriverAttr: String): Boolean;
begin
  Result := DoDrivers(SQL_FETCH_NEXT, ADriverDesc, ADriverAttr);
end;

{-------------------------------------------------------------------------------}
function TODBCEnvironment.DoDSNs(ADirection: SQLUSmallint; out AServerName,
  ADescription: String): Boolean;
var
  iServerNameLen: SQLSmallint;
  iDescriptionLen: SQLSmallint;
  iRet: SQLReturn;
begin
  if not Assigned(Lib.SQLDataSources) then begin
    Result := False;
    Exit;
  end;
  SetLength(AServerName, SQL_MAX_DSN_LENGTH);
  SetLength(ADescription, C_DRIVER_DESC_MAXLEN);
  iServerNameLen := 0;
  iDescriptionLen := 0;
  iRet := Lib.SQLDataSources(FHandle, ADirection, PSQLChar(AServerName),
    SQL_MAX_DSN_LENGTH, iServerNameLen, PSQLChar(ADescription),
    C_DRIVER_DESC_MAXLEN, iDescriptionLen);
  if iRet = SQL_NO_DATA then
    Result := False
  else begin
    Check(iRet);
    Result := True;
  end;
  SetLength(AServerName, iServerNameLen);
  SetLength(ADescription, iDescriptionLen);
end;

{-------------------------------------------------------------------------------}
function TODBCEnvironment.DSNFirst(out AServerName, ADescription: String): Boolean;
begin
  Result := DoDSNs(SQL_FETCH_FIRST, AServerName, ADescription);
end;

{-------------------------------------------------------------------------------}
function TODBCEnvironment.DSNNext(out AServerName, ADescription: String): Boolean;
begin
  Result := DoDSNs(SQL_FETCH_NEXT, AServerName, ADescription);
end;

{-------------------------------------------------------------------------------}
procedure TODBCEnvironment.GetDrivers(AList: TStrings; ADecorate: Boolean = False);
var
  sDriver, sAttr: String;
  oStrs: TFDStringList;
  i: Integer;
begin
  AList.BeginUpdate;
  oStrs := TFDStringList.Create;
  try
    AList.Clear;
    if DriverFirst(sDriver, sAttr) then
      repeat
        oStrs.Add(sDriver);
      until not DriverNext(sDriver, sAttr);
    oStrs.Sort;
    if ADecorate then
      for i := 0 to oStrs.Count - 1 do
        oStrs[i] := TODBCLib.DecorateKeyValue(oStrs[i]);
    AList.SetStrings(oStrs);
  finally
    FDFree(oStrs);
    AList.EndUpdate;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCEnvironment.GetDSNs(AList: TStrings; AWithDescription: Boolean = False;
  ADecorate: Boolean = False);
var
  sDSN, sDesc: String;
  oStrs: TFDStringList;
  i: Integer;
begin
  AList.BeginUpdate;
  oStrs := TFDStringList.Create;
  try
    AList.Clear;
    if DSNFirst(sDSN, sDesc) then
      repeat
        if AWithDescription then
          sDSN := sDSN + '=' + sDesc;
        oStrs.Add(sDSN);
      until not DSNNext(sDSN, sDesc);
    oStrs.Sort;
    if ADecorate then
      for i := 0 to oStrs.Count - 1 do
        oStrs[i] := TODBCLib.DecorateKeyValue(oStrs[i]);
    AList.SetStrings(oStrs);
  finally
    FDFree(oStrs);
    AList.EndUpdate;
  end;
end;

{-------------------------------------------------------------------------------}
{ TODBCConnection                                                               }
{-------------------------------------------------------------------------------}
constructor TODBCConnection.Create(AOwner: TODBCEnvironment; AOwningObj: TObject);
begin
  ASSERT(AOwner <> nil);
  inherited Create;
  FExceptionClass := EODBCNativeException;
  FOwner := AOwner;
  FOwningObj := AOwningObj;
  FHandleType := SQL_HANDLE_DBC;
  FODBCLib := FOwner.Lib;
  FDecimalSepPar := '.';
  FDecimalSepCol := '.';
  FEncoder := TFDEncoder.Create(nil);
  FEncoder.Encoding := ecANSI;
  AllocHandle;
end;

{-------------------------------------------------------------------------------}
constructor TODBCConnection.CreateUsingHandle(AOwner: TODBCEnvironment;
  AHandle: SQLHDbc; AOwningObj: TObject);
begin
  ASSERT(AOwner <> nil);
  inherited CreateUsingHandle(AHandle);
  FExceptionClass := EODBCNativeException;
  FOwner := AOwner;
  FOwningObj := AOwningObj;
  FHandleType := SQL_HANDLE_DBC;
  FODBCLib := FOwner.Lib;
  FDecimalSepPar := '.';
  FDecimalSepCol := '.';
  FEncoder := TFDEncoder.Create(nil);
  FEncoder.Encoding := ecANSI;
  AfterConnect;
end;

{-------------------------------------------------------------------------------}
destructor TODBCConnection.Destroy;
begin
  // Required to fix the issue:
  // http://www.da-soft.com/forums/anydac-general-english/anydac-informix-sql-error.html#21498
  IgnoreErrors := True;
  if Connected then
    Disconnect;
  ClearInfo;
  FDFreeAndNil(FEncoder);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TODBCConnection.ClearInfo;
begin
  FDFreeAndNil(FInfo);
end;

{-------------------------------------------------------------------------------}
procedure TODBCConnection.AfterConnect;
var
  sDrv, sDbms: string;
  iEnvVer: SQLUInteger;

  function Match(const AName: String): Boolean;
  begin
    Result := Copy(sDrv, 1, Length(AName)) = AName;
  end;

begin
  sDrv := UpperCase(DRIVER_NAME);
  sDbms := UpperCase(DBMS_NAME);

  FDriverKind := dkOther;
  FRdbmsKind := TFDRDBMSKinds.Other;

  if Match('SQLSRV') then
    FDriverKind := dkSQLSrv
  else if Match('SQLNCLI') then
    FDriverKind := dkSQLNC
  else if Match('MSODBCSQL') or Match('LIBMSODBCSQL') then
    FDriverKind := dkSQLOdbc
  else if Match('LIBTDSODBC') then
    FDriverKind := dkFreeTDS
  else if Match('IVSS') or Match('IVMSSS') or Match('PBSS') or
          ((Copy(sDrv, 1, 3) = 'NTL') and (sDrv[5] = 'M')) then
    FDriverKind := dkSQLSrvOther
  else if Match('CWBODBC') then
    FDriverKind := dkDB2_400
  else if Match('DB2CLI') or Match('LIBDB2') or Match('IVDB2') or Match('PBDB2') or
          // IBM DB2 ODBC driver has a bug and returns ODBC_VER instead of DRIVER_NAME
          (Copy(sDbms, 1, 3) = 'DB2') then
    FDriverKind := dkDB2
  else if Match('MYODBC') then
    FDriverKind := dkMySQL
  else if Match('SQORA') then
    FDriverKind := dkOracleOra
  else if Match('MSORCL') then
    FDriverKind := dkOracleMS
  else if Match('IVOR') or Match('PBOR') then
    FDriverKind := dkOracleOther
  else if Match('ODBCJT') and (sDbms = 'ACCESS') then
    FDriverKind := dkMSAccessJet
  else if Match('ACEODBC') and (sDbms = 'ACCESS') then
    FDriverKind := dkMSAccessACE
  else if Match('ODBCFB') then
    FDriverKind := dkFirebird
  else if Match('IB') then
    FDriverKind := dkInterbase
  else if Match('SQL ANYWHERE') or Match('DBODBC') and (sDbms <> 'DBISAM') or Match('WOD') then
    FDriverKind := dkSQLAnywhere
  else if Match('SQLITEODBC') then
    FDriverKind := dkSQLite
  else if Match('PSQLODBC') then
    FDriverKind := dkPostgreSQL
  else if Match('ADSODBC') then
    FDriverKind := dkAdvantage
  else if Match('NXODBCDRIVER') then
    FDriverKind := dkNexusDB
  else if Match('ADAPTIVE SERVER ENTERPRISE') or Match('SYODASE') or Match('SYSYBNT') then
    FDriverKind := dkSybaseASE
  else if Match('ICLI') then
    FDriverKind := dkInformix
  else if Match('PWDRMF') then
    FDriverKind := dkPWMicroFocus
  else if Match('ODBCJT') and (sDbms = 'DBASE') then
    FDriverKind := dkDBF
  else if Match('SQLBASEODBC') then
    FDriverKind := dkSQLBase
  else if Match('EDBODBC') then
    FDriverKind := dkElevateDB
  else if Match('DBODBC') and (sDbms = 'DBISAM') then
    FDriverKind := dkDBISAM
  else if Match('SOC') or Match('SAC') then
    FDriverKind := dkSolidDB
  else if Match('CACHEODBC') then
    FDriverKind := dkCache
  else if Match('TDATA') then
    FDriverKind := dkTeradata
  else if Match('W3ODBCCI') then
    FDriverKind := dkPervasive;

  case DriverKind of
  dkSQLSrv,
  dkSQLNC,
  dkSQLOdbc,
  dkFreeTDS,
  dkSQLSrvOther:
    FRdbmsKind := TFDRDBMSKinds.MSSQL;
  dkDB2,
  dkDB2_400:
    FRdbmsKind := TFDRDBMSKinds.DB2;
  dkMySQL:
    FRdbmsKind := TFDRDBMSKinds.MySQL;
  dkOracleOra,
  dkOracleMS,
  dkOracleOther:
    FRdbmsKind := TFDRDBMSKinds.Oracle;
  dkMSAccessJet,
  dkMSAccessACE:
    FRdbmsKind := TFDRDBMSKinds.MSAccess;
  dkInterbase:
    FRdbmsKind := TFDRDBMSKinds.Interbase;
  dkFirebird:
    FRdbmsKind := TFDRDBMSKinds.Firebird;
  dkSQLAnywhere:
    FRdbmsKind := TFDRDBMSKinds.SQLAnywhere;
  dkSQLite:
    FRdbmsKind := TFDRDBMSKinds.SQLite;
  dkPostgreSQL:
    FRdbmsKind := TFDRDBMSKinds.PostgreSQL;
  dkAdvantage:
    FRdbmsKind := TFDRDBMSKinds.Advantage;
  dkNexusDB:
    FRdbmsKind := TFDRDBMSKinds.NexusDB;
  dkInformix:
    FRdbmsKind := TFDRDBMSKinds.Informix;
  dkTeradata:
    FRdbmsKind := TFDRDBMSKinds.Teradata;
  end;

  FMaxColumnNameLen := GetInfoOptionSmInt(SQL_MAX_COLUMN_NAME_LEN);
  FDriverVersion := FDVerStr2Int(DRIVER_VER);
  FDriverODBCVersion := FDVerStr2Int(DRIVER_ODBC_VER);
  iEnvVer := TODBCEnvironment(Owner).ODBC_VERSION;
  if (iEnvVer >= SQL_OV_ODBC3_80) and (FDriverODBCVersion >= ovODBC38) then
    FDriverEnvVersion := ovODBC38
  else if (iEnvVer >= SQL_OV_ODBC3) and (FDriverODBCVersion >= ovODBC3) then
    FDriverEnvVersion := ovODBC3
  else
    FDriverEnvVersion := ovODBC2;
end;

{-------------------------------------------------------------------------------}
function TODBCConnection.Connect(const AConnString: String): String;
begin
  Result := DriverConnect(AConnString, SQL_DRIVER_NOPROMPT, 0);
end;

{-------------------------------------------------------------------------------}
function TODBCConnection.DriverConnect(const AConnString: String;
  ADriverCompletion: SQLUSmallint; AParentWnd: SQLHWnd): String;
var
  iOutConnStrLen: SQLSmallint;
{$IFDEF FireDAC_MONITOR}
  s: String;
  i1, i2: Integer;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then begin
    s := AConnString;
    i1 := Pos('PWD=', UpperCase(s));
    if i1 <> 0 then begin
      i2 := Pos(';', s, i1);
      if i2 = 0 then
        i2 := Length(s) + 1;
      Inc(i1, 4);
      while i1 < i2 do begin
        s[i1] := '*';
        Inc(i1);
      end;
    end;
    Trace(ekVendor, esProgress, 'SQLDriverConnect', ['szConnStr', s]);
  end;
{$ENDIF}
  SetLength(Result, C_RETURNED_STRING_MAXLEN);
  FillChar(Result[1], C_RETURNED_STRING_MAXLEN * SizeOf(Char), 0);
  iOutConnStrLen := 0;
  Check(Lib.SQLDriverConnect(FHandle, AParentWnd, PSQLChar(AConnString), SQL_NTS,
    PSQLChar(Result), C_RETURNED_STRING_MAXLEN, iOutConnStrLen, ADriverCompletion));
  FConnected := True;
  AfterConnect;
  ODBCSetLength(Result, iOutConnStrLen);
end;

{-------------------------------------------------------------------------------}
procedure TODBCConnection.Disconnect;
begin
  FConnected := False;
  Check(Lib.SQLDisconnect(FHandle));
end;

{-------------------------------------------------------------------------------}
procedure TODBCConnection.ListServers(const AConnString: String; AList: TStrings);
var
  iOutConnStrLen: SQLSmallint;
  sOutStr, sSrv: String;
  i1, i2, i: Integer;
  rFmt: TFDParseFmtSettings;
begin
  AList.BeginUpdate;
  try
    AList.Clear;
    SetLength(sOutStr, C_RETURNED_STRING_MAXLEN);
    FillChar(sOutStr[1], C_RETURNED_STRING_MAXLEN * SizeOf(Char), 0);
    if (Lib.SQLBrowseConnect(Handle, PSQLChar(AConnString), SQL_NTS,
                             PSQLChar(sOutStr), C_RETURNED_STRING_MAXLEN,
                             iOutConnStrLen)) <> SQL_NEED_DATA then

      Exit;
    if C_RETURNED_STRING_MAXLEN < iOutConnStrLen then begin
      SetLength(sOutStr, iOutConnStrLen + 1);
      if (Lib.SQLBrowseConnect(Handle, PSQLChar(AConnString), SQL_NTS,
                               PSQLChar(sOutStr), C_RETURNED_STRING_MAXLEN,
                               iOutConnStrLen)) <> SQL_NEED_DATA then
        Exit;
    end;
    ODBCSetLength(sOutStr, iOutConnStrLen);
    i1 := Pos('{', sOutStr);
    i2 := Pos('}', sOutStr, i1 + 1);
    if (i1 <> 0) and (i2 <> 0) then
      sOutStr := Copy(sOutstr, i1 + 1, i2 - i1 - 1);
    rFmt.FDelimiter := ',';
    rFmt.FQuote := #0;
    rFmt.FQuote1 := '{';
    rFmt.FQuote2 := '}';
    i := 1;
    while i <= Length(sOutStr) do begin
      sSrv := FDExtractFieldName(sOutStr, i, rFmt);
      i1 := Pos(';', sSrv);
      if i1 > 0 then
        sSrv := Copy(sSrv, 1, i1 - 1);
      if AList.IndexOf(sSrv) = -1 then
        AList.Add(sSrv);
    end;
  finally
    AList.EndUpdate;
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCConnection.GetFunctions(AFuncID: SQLUSmallint): SQLUSmallint;
begin
  Result := 0;
  Check(Lib.SQLGetFunctions(FHandle, AFuncID, Result));
end;

{-------------------------------------------------------------------------------}
procedure TODBCConnection.GetInfo(AInfoType: SQLUSmallint; var AInfoValue: String);
begin
  Check(GetInfoBase(AInfoType, AInfoValue));
end;

{-------------------------------------------------------------------------------}
function TODBCConnection.GetInfoBase(AInfoType: SQLUSmallint; var AInfoValue: String): SQLReturn;
var
  iInfoLength: SQLSmallint;
begin
  if Length(AInfoValue) < C_RETURNED_STRING_MAXLEN then
    SetLength(AInfoValue, C_RETURNED_STRING_MAXLEN);
  iInfoLength := 0;
  Result := Lib.SQLGetInfoString(FHandle, AInfoType, PSQLChar(AInfoValue),
    SQLSmallint(Length(AInfoValue)) * SizeOf(Char), iInfoLength);
  ODBCSetLength(AInfoValue, iInfoLength div SizeOf(Char));
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_64}
procedure TODBCConnection.GetInfo(AInfoType: SQLUSmallint; var AInfoValue: SQLULen);
begin
  AInfoValue := 0;
  Check(Lib.SQLGetInfoSQLLen(FHandle, AInfoType, AInfoValue, SQLSmallint(SizeOf(AInfoValue)), nil));
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
procedure TODBCConnection.GetInfo(AInfoType: SQLUSmallint; var AInfoValue: SQLUInteger);
begin
  AInfoValue := 0;
  Check(Lib.SQLGetInfoInt(FHandle, AInfoType, AInfoValue, SQLSmallint(SizeOf(AInfoValue)), nil));
end;

{-------------------------------------------------------------------------------}
procedure TODBCConnection.GetInfo(AInfoType: SQLUSmallint; var AInfoValue: SQLUSmallint);
var
  iValue: SQLUInteger;
begin
  iValue := 0;
  AInfoValue := 0;
  Check(Lib.SQLGetInfoInt(FHandle, AInfoType, iValue, SQLSmallint(SizeOf(AInfoValue)), nil));
  AInfoValue := SQLUSmallint(iValue);
end;

{-------------------------------------------------------------------------------}
function TODBCConnection.GetInfoOptionSmInt(AInfoType: Integer): SQLUSmallint;
begin
  GetInfo(SQLUSmallint(AInfoType), Result);
end;

{-------------------------------------------------------------------------------}
function TODBCConnection.GetInfoOptionUInt(AInfoType: Integer): SQLUInteger;
begin
  GetInfo(SQLUSmallint(AInfoType), Result);
end;

{-------------------------------------------------------------------------------}
function TODBCConnection.GetInfoOptionULen(AInfoType: Integer): SQLULen;
begin
  GetInfo(SQLUSmallint(AInfoType), Result);
end;

{-------------------------------------------------------------------------------}
function TODBCConnection.GetInfoOptionStr(AInfoType: Integer): string;
begin
  GetInfo(SQLUSmallint(AInfoType), Result);
end;

{-------------------------------------------------------------------------------}
function TODBCConnection.GetKeywords: string;
const
  C_DefKeywords =
    'ABSOLUTE,IS,ACTION,ISOLATION,ADA,JOIN,ADD,KEY,' +
    'ALL,LANGUAGE,ALLOCATE,LAST,ALTER,LEADING,AND,LEFT,' +
    'ANY,LEVEL,ARE,LIKE,AS,LOCAL,ASC,LOWER,ASSERTION,MATCH,' +
    'AT,MAX,AUTHORIZATION,MIN,AVG,MINUTE,BEGIN,MODULE,' +
    'BETWEEN,MONTH,BIT,NAMES,BIT_LENGTH,NATIONAL,BOTH,NATURAL,' +
    'BY,NCHAR,CASCADE,NEXT,CASCADED,NO,CASE,NONE,CAST,NOT,' +
    'CATALOG,NULL,CHAR,NULLIF,CHAR_LENGTH,NUMERIC,' +
    'CHARACTER,OCTET_LENGTH,CHARACTER_LENGTH,OF,CHECK,ON,' +
    'CLOSE,ONLY,COALESCE,OPEN,COLLATE,OPTION,COLLATION,OR,' +
    'COLUMN,ORDER,COMMIT,OUTER,CONNECT,OUTPUT,CONNECTION,OVERLAPS,' +
    'CONSTRAINT,PFD,CONSTRAINTS,PARTIAL,CONTINUE,PASCAL,' +
    'CONVERT,POSITION,CORRESPONDING,PRECISION,COUNT,PREPARE,' +
    'CREATE,PRESERVE,CROSS,PRIMARY,CURRENT,PRIOR,N,' +
    'CURRENT_DATE,PRIVILEGES,CURRENT_TIME,PROCEDURE,' +
    'CURRENT_TIMESTAMP,PUBLIC,CURRENT_USER,READ,CURSOR,REAL,' +
    'DATE,REFERENCES,DAY,RELATIVE,DEALLOCATE,RESTRICT,' +
    'DEC,REVOKE,DECIMAL,RIGHT,DECLARE,ROLLBACK,DEFAULT,ROWS,' +
    'DEFERRABLE,SCHEMA,DEFERRED,SCROLL,DELETE,SECOND,' +
    'DESC,SECTION,DESCRIBE,SELECT,DESCRIPTOR,SESSION,' +
    'DIAGNOSTICS,SESSION_USER,DISCONNECT,SET,DISTINCT,SIZE,' +
    'DOMAIN,SMALLINT,DOUBLE,SOME,DROP,SPACE,ELSE,SQL,' +
    'END,SQLCA,END-EXEC,SQLCODE,ESCAPE,SQLERROR,EXCEPT,SQLSTATE,' +
    'EXCEPTION,SQLWARNING,EXEC,SUBSTRING,EXECUTE,SUM,' +
    'EXISTS,SYSTEM_USER,EXTERNAL,TABLE,EXTRACT,TEMPORARY,' +
    'FALSE,THEN,FETCH,TIME,FIRST,TIMESTAMP,FLOAT,TIMEZONE_HOUR,' +
    'FOR,TIMEZONE_MINUTE,FOREIGN,TO,FORTRAN,TRAILING,' +
    'FOUND,TRANSACTION,FROM,TRANSLATE,FULL,TRANSLATION,' +
    'GET,TRIM,GLOBAL,TRUE,GO,UNION,GOTO,UNIQUE,GRANT,UNKNOWN,' +
    'GROUP,UPDATE,HAVING,UPPER,HOUR,USAGE,IDENTITY,USER,' +
    'IMMEDIATE,USING,IN,VALUE,INCLUDE,VALUES,INDEX,VARCHAR,' +
    'INDICATOR,VARYING,INITIALLY,VIEW,INNER,WHEN,INPUT,WHENEVER,' +
    'INSENSITIVE,WHERE,INSERT,WITH,INT,WORK,INTEGER,WRITE,' +
    'INTERSECT,YEAR,INTERVAL,ZONE,INTO,';
  C_MSAccAdditionalKeywords =
    ',LONGTEXT,MEMO,MONEY,NOTE,NUMBER,' +
    'OLEOBJECT,OWNERACCESS,PARAMETERS,' +
    'PERCENT,PIVOT,SHORT,SINGLE,SINGLEFLOAT,' +
    'STDEV,STDEVP,STRING,TABLEID,TEXT,TOP,' +
    'TRANSFORM,UNSIGNEDBYTE,VAR,VARBINARY,' +
    'VARP,YESNO';
begin
  // Informix: on 3.70.TC5DE SQL_KEYWORDS leads to AV
  if DriverKind = dkInformix then
    Result := C_DefKeywords
  else begin
    // ASA: "div" in next SetLength is needed to avoid SQL_ERROR on
    // "SQL Anywhere 11" driver in Unicode mode.
    SetLength(Result, $3FFF div SizeOf(Char));
    GetInfo(SQLUSmallint(SQL_KEYWORDS), Result);
    Result := C_DefKeywords + Result;
  end;
  // MSAcc: The following is a workaround for the Access 2007 driver,
  // which truncates the key word list.
  if (DriverKind in [dkMSAccessJet, dkMSAccessACE]) and (Pos(',TEXT,', Result) = 0) then
    Result := Result + C_MSAccAdditionalKeywords;
end;

{-------------------------------------------------------------------------------}
procedure TODBCConnection.GetNonStrAttribute(AAttr: SQLInteger; ApValue: SQLPointer);
var
  iStringLen: SQLInteger;
begin
  iStringLen := 0;
  Check(Lib.SQLGetConnectAttr(FHandle, AAttr, ApValue, 0, iStringLen));
end;

{-------------------------------------------------------------------------------}
procedure TODBCConnection.GetStrAttribute(AAttr: SQLInteger; out AValue: String);
var
  iStringLen: SQLInteger;
begin
  SetLength(AValue, SQL_MAX_MESSAGE_LENGTH);
  iStringLen := 0;
  Check(Lib.SQLGetConnectAttr(FHandle, AAttr, PChar(AValue),
    SQL_MAX_MESSAGE_LENGTH * SizeOf(Char), iStringLen));
  ODBCSetLength(AValue, iStringLen div SizeOf(Char));
end;

{-------------------------------------------------------------------------------}
procedure TODBCConnection.SetAttribute(AAttr: SQLInteger; ApValue: SQLPointer;
  AType: SQLInteger);
begin
  if ((AType = 0) or (AType = SQL_NTS)) and (ApValue <> nil) then
    AType := StrLen(PChar(ApValue)) * SizeOf(Char);
  Check(Lib.SQLSetConnectAttr(FHandle, AAttr, ApValue, AType));
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
function TODBCConnection.GetTracing: Boolean;
begin
  Result := FTracing and inherited GetTracing;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
function TODBCConnection.EncodeName(const ACat, ASch, AObj: String): String;
var
  sQuote: String;
begin
  sQuote := IDENTIFIER_QUOTE_CHAR;
  Result := '';
  if ((CATALOG_USAGE and SQL_CU_DML_STATEMENTS) <> 0) and
     (CATALOG_LOCATION = SQL_CL_START) then
    if ACat <> '' then
      Result := sQuote + ACat + sQuote + CATALOG_NAME_SEPARATOR;
  if (SCHEMA_USAGE and SQL_SU_DML_STATEMENTS) <> 0 then
    if ASch <> '' then
      Result := Result + sQuote + ASch + sQuote + '.';
  Result := Result + sQuote + AObj + sQuote;
  if ((CATALOG_USAGE and SQL_CU_DML_STATEMENTS) <> 0) and
     (CATALOG_LOCATION = SQL_CL_END) then
    if ACat <> '' then
      Result := CATALOG_NAME_SEPARATOR + sQuote + ACat + sQuote;
end;

{-------------------------------------------------------------------------------}
procedure TODBCConnection.EndTran(AType: SQLSmallint);
begin
  Check(Lib.SQLEndTran(HandleType, Handle, AType));
end;

{-------------------------------------------------------------------------------}
procedure TODBCConnection.Commit;
begin
  EndTran(SQL_COMMIT);
end;

{-------------------------------------------------------------------------------}
procedure TODBCConnection.Rollback;
begin
  EndTran(SQL_ROLLBACK);
end;

{-------------------------------------------------------------------------------}
procedure TODBCConnection.StartTransaction;
begin
  AUTOCOMMIT := SQL_AUTOCOMMIT_OFF;
end;

{-------------------------------------------------------------------------------}
function TODBCConnection.GetIsolation: SQLInteger;
begin
  if DriverKind in [dkSQLNC, dkSQLOdbc] then
    Result := GetIntAttribute(SQL_COPT_SS_TXN_ISOLATION)
  else
    Result := GetIntAttribute(SQL_ATTR_TXN_ISOLATION);
end;

{-------------------------------------------------------------------------------}
procedure TODBCConnection.SetIsolation(const AValue: SQLInteger);
begin
  if DriverKind in [dkSQLNC, dkSQLOdbc] then
    SetIntAttribute(SQL_COPT_SS_TXN_ISOLATION, AValue)
  else
    SetIntAttribute(SQL_ATTR_TXN_ISOLATION, AValue);
end;

{-------------------------------------------------------------------------------}
{ TODBCSelectItem                                                               }
{-------------------------------------------------------------------------------}
constructor TODBCSelectItem.Create(AOwner: TODBCStatementBase; AColNum: SQLSmallint);
var
  iNameLen: SQLSmallint;
  iColMaxLen: SQLUSmallint;
begin
  inherited Create;
  FStmt := AOwner;
  FPosition := AColNum;
  iColMaxLen := FStmt.Connection.MAX_COL_NAME_LEN;
  // FIPS Intermediate level conformant value
  if iColMaxLen < 128 then
    iColMaxLen := 128;
  SetLength(FName, iColMaxLen);
  iNameLen := 0;
  FStmt.Check(FStmt.Lib.SQLDescribeCol(FStmt.FHandle, FPosition, PSQLChar(FName),
    iColMaxLen, iNameLen, FSQLDataType, FColumnSize, FScale, FNullable));
  ODBCSetLength(FName, iNameLen);

  case FStmt.Connection.DriverKind of
  dkSQLNC,
  dkSQLOdbc,
  dkFreeTDS,
  dkSQLSrvOther:
    if (FColumnSize = SQL_SS_LENGTH_UNLIMITED) and
       ((SQLDataType = SQL_VARCHAR) or (SQLDataType = SQL_VARBINARY) or
        (SQLDataType = SQL_WVARCHAR) or (SQLDataType = SQL_SS_XML) or
        (SQLDataType = SQL_SS_UDT)) then
      FColumnSize := MAXINT;
  dkMSAccessJet,
  dkMSAccessACE:
    // MSAccess: workaround for http://support.microsoft.com/kb/941877
    if (FColumnSize = 2147483598) and
       ((SQLDataType = SQL_VARCHAR) or (SQLDataType = SQL_VARBINARY) or
        (SQLDataType = SQL_WVARCHAR)) then
      FColumnSize := 255;
  end;

  if (SQLDataType >= SQL_INTERVAL_YEAR) and
     (SQLDataType <= SQL_INTERVAL_MINUTE_TO_SECOND) then begin
    FColumnSize := DATETIME_INTERVAL_PRECISION;
    FScale := PRECISION;
  end;

  if ((SQLDataType = SQL_DECIMAL) or (SQLDataType = SQL_NUMERIC)) and
     (FScale > FColumnSize) then
    FScale := FColumnSize;
end;

{-------------------------------------------------------------------------------}
function TODBCSelectItem.GetStrAttr(AIndex: Integer): String;
begin
  Result := '';
  FStmt.ColAttributeString(FPosition, AIndex, Result);
end;

{-------------------------------------------------------------------------------}
function TODBCSelectItem.GetIntAttr(AIndex: Integer): SQLInteger;
var
  iVal: SQLLen;
begin
  iVal := 0;
  FStmt.ColAttributeInt(FPosition, AIndex, iVal);
  Result := iVal;
end;

{-------------------------------------------------------------------------------}
function TODBCSelectItem.GetIntAttrSilent(AIndex: Integer): SQLInteger;
var
  iVal: SQLLen;
begin
  iVal := 0;
  FStmt.ColAttributeIntSilent(FPosition, AIndex, iVal);
  Result := iVal;
end;

{-------------------------------------------------------------------------------}
function TODBCSelectItem.GetSmallintAttr(AIndex: Integer): SQLSmallint;
begin
  Result := 0;
  FStmt.ColAttributeSmallint(FPosition, AIndex, Result);
end;

{-------------------------------------------------------------------------------}
function TODBCSelectItem.GetSmallintAttrSilent(AIndex: Integer): SQLSmallint;
begin
  Result := 0;
  FStmt.ColAttributeSmallintSilent(FPosition, AIndex, Result);
end;

{-------------------------------------------------------------------------------}
function TODBCSelectItem.GetIsFixedLen: Boolean;
begin
  case SQLDataType of
  SQL_CHAR,
  SQL_WCHAR,
  SQL_GUID,
  SQL_BINARY,
  SQL_GRAPHIC:
    Result := True
  else
    Result := False;
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCSelectItem.GetROWVER: SQLLen;
begin
  Result := SQL_FALSE;
  if FStmt.Lib.SQLColAttributeInt(FStmt.FHandle, FPosition, SQL_DESC_ROWVER, nil,
                                  0, nil, Result) <> SQL_SUCCESS then
    Result := SQL_FALSE;
end;

{-------------------------------------------------------------------------------}
{ General data type conversion                                                  }
{-------------------------------------------------------------------------------}
procedure ODBCNumeric2BCD(const ANum: TSQLNumericRec; out ABcd: TBcd);
var
  i, j, iNum, iBcd: integer;
  iRem, iTmp: word;
  aVal: array [0..SQL_MAX_NUMERIC_LEN - 1] of Byte;
begin
  FillChar(ABcd, SizeOf(ABcd), 0);
  iNum := SQL_MAX_NUMERIC_LEN - 1;

  // check for 0
  while (iNum >= 0) and (ANum.val[iNum] = 0) do
    Dec(iNum);
  if iNum < 0 then begin
    ABcd.Precision := 10;
    ABcd.SignSpecialPlaces := 2;
    Exit;
  end;

  // fill fraction
  Move(ANum.val[0], aVal[0], iNum + 1);
  iBcd := SizeOfFraction - 1;
  while iNum >= 0 do begin
    iRem := 0;
    for i := iNum downto 0 do begin
      iTmp := (Byte(aVal[i]) + iRem);
      aVal[i] := iTmp div 100;
      iRem := (iTmp mod 100) shl 8;
    end;
    ABcd.Fraction[iBcd] := (iRem shr 8) mod 10 + ((iRem shr 8) div 10) shl 4;
    Dec(iBcd);
    if aVal[iNum] = 0 then
      Dec(iNum);
  end;

  // setup bcd
  if ANum.sign = 0 then
    ABcd.SignSpecialPlaces := (1 shl 7) + ANum.scale
  else
    ABcd.SignSpecialPlaces := (0 shl 7) + ANum.scale;
  ABcd.Precision := ANum.precision;

  // normalize fraction
  i := SizeOfFraction - 1 - (ANum.precision div 2);
  if i >= 0 then begin
    if ANum.scale > ANum.precision then begin
      Dec(i, (ANum.scale - ANum.precision + 1) div 2);
      Inc(ABcd.Precision, ANum.scale - ANum.precision);
    end;
    j := i;
    if (ABcd.Precision mod 2) = 1 then begin
      while i < SizeOfFraction - 1 do begin
        ABcd.Fraction[i - j] := (ABcd.Fraction[i] and $0F) shl 4 + ABcd.Fraction[i + 1] shr 4;
        Inc(i);
      end;
      ABcd.Fraction[i - j] := (ABcd.Fraction[i] and $0F) shl 4;
    end
    else
      Move(ABcd.Fraction[i + 1], ABcd.Fraction[i - j], SizeOfFraction - 1 - i);
    FillChar(ABcd.Fraction[SizeOfFraction - j], j, 0);
  end;
end;

{-------------------------------------------------------------------------------}
procedure ODBCBcd2Numeric(const ABcd: TBcd; out ANum: TSQLNumericRec);
const
  MaxWords = SQL_MAX_NUMERIC_LEN div SizeOf(Cardinal);
var
  i, j, k: Integer;
  iMulDer: Integer;
  iNibble: Integer;
  iDev, iVal: Int64;
  aMul: array [0..MaxWords - 1] of Cardinal;
  aVal: array [0..MaxWords - 1] of Cardinal;
  iMulSize: Integer;
  iValSize: Integer;
begin
  FillChar(ANum, SizeOf(TSQLNumericRec), 0);

  iMulSize := 1;
  iValSize := 1;
  aMul[0] := 1;
  FillChar(aVal[0], MaxWords * SizeOf(Cardinal), 0);

  k := (ABcd.Precision div 2);
  if (ABcd.Precision mod 2) = 0 then
    Dec(k);

  for i := k downto 0 do begin
    iMulDer := 100;
    if i = k then begin
      if (ABcd.Precision mod 2) = 0 then
        iNibble := ABcd.Fraction[i] and 15 + (ABcd.Fraction[i] shr 4) * 10
      else begin
        iNibble := ABcd.Fraction[i] shr 4;
        iMulDer := 10;
      end;
    end
    else
      iNibble := ABcd.Fraction[i] and 15 + (ABcd.Fraction[i] shr 4) * 10;

    iDev := 0;
    iValSize := iMulSize;
    for j := 0 to iValSize - 1 do begin
      iVal := aVal[j] + Int64(aMul[j]) * Int64(iNibble) + iDev;
      aVal[j] := Cardinal(iVal and $FFFFFFFF);
      iDev := iVal shr 32;
    end;
    if iDev <> 0 then begin
      aVal[iValSize] := iDev;
      Inc(iValSize);
    end;
    if i > 0 then begin
      iDev := 0;
      for j := 0 to iMulSize - 1 do begin
        iVal := Int64(aMul[j]) * Int64(iMulDer) + iDev;
        aMul[j] := Cardinal(iVal and $FFFFFFFF);
        iDev := iVal shr 32;
      end;
      if iDev <> 0 then begin
        aMul[iMulSize] := iDev;
        Inc(iMulSize);
      end;
    end;
  end;
  Move(aVal[0], ANum.Val[0], iValSize * SizeOf(Cardinal));
  ANum.precision := ABcd.Precision;
  ANum.scale := ABcd.SignSpecialPlaces and $3F;
  ANum.sign := Byte(ABcd.SignSpecialPlaces and (1 shl 7) = 0);
end;

{-------------------------------------------------------------------------------}
procedure ODBCNumeric2Currency(const ANum: TSQLNumericRec; out ACurr: Currency);
var
  iNum: integer;
begin
  iNum := SQL_MAX_NUMERIC_LEN - 1;

  // check for 0
  while (iNum >= 0) and (ANum.val[iNum] = 0) do
    Dec(iNum);
  if iNum < 0 then begin
    ACurr := 0.0;
    Exit;
  end;
  ASSERT(iNum < SizeOf(Int64));

  ACurr := PCurrency(PInt64(@ANum.val[0]))^;
  if ANum.scale < 4 then
    ACurr := ACurr * C_FD_ScaleFactor[4 - ANum.scale]
  else if ANum.scale > 4 then
    ACurr := ACurr / C_FD_ScaleFactor[ANum.scale - 4];
  if ANum.sign = 0 then
    ACurr := - ACurr;
end;

{-------------------------------------------------------------------------------}
procedure ODBCCurrency2Numeric(ACurr: Currency; out ANum: TSQLNumericRec);
begin
  ANum.precision := 19;
  ANum.scale := 4;
  if ACurr < 0 then begin
    ANum.sign := 0;
    ACurr := -ACurr;
  end
  else
    ANum.sign := 1;
  Move(ACurr, ANum.val[0], SizeOf(Currency));
  FillChar(ANum.val[SizeOf(Currency)], SQL_MAX_NUMERIC_LEN - SizeOf(Currency), 0);
end;

{-------------------------------------------------------------------------------}
{ TODBCVariable                                                                 }
{-------------------------------------------------------------------------------}
constructor TODBCVariable.Create;
begin
  inherited Create;
  FSQLDataType := SQL_UNKNOWN_TYPE;
  FCDataType := SQL_UNKNOWN_TYPE;
  FPosition := -1;
  FDataSize := SQL_NULL_DATA;
  FBinded := False;
end;

{-------------------------------------------------------------------------------}
destructor TODBCVariable.Destroy;
begin
  FList := nil;
  FDataReader := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TODBCVariable.GetConnection: TODBCConnection;
begin
  Result := TODBCConnection(FList.FOwner.FOwner);
end;

{-------------------------------------------------------------------------------}
function TODBCVariable.GetStatement: TODBCStatementBase;
begin
  Result := TODBCStatementBase(FList.FOwner);
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariable.SetCDataType(const AValue: SQLSmallint);
begin
  if FCDataType <> AValue then begin
    FCDataType := AValue;
    FFlagsUpdated := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariable.SetDataSize(const AValue: SQLLen);
begin
  if FDataSize <> AValue then begin
    FDataSize := AValue;
    FFlagsUpdated := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariable.SetColumnSize(const AValue: SQLULen);
begin
  if FColumnSize <> AValue then begin
    FColumnSize := AValue;
    FFlagsUpdated := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariable.SetSQLDataType(const AValue: SQLSmallint);
begin
  if SQLDataType <> AValue then begin
    FSQLDataType := AValue;
    FFlagsUpdated := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariable.SetForceLongData(const AValue: Boolean);
begin
  if AValue <> FForceLongData then begin
    FForceLongData := AValue;
    if AValue then begin
      FLongData := True;
      FLateBinding := True;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariable.SetForceLateBinding(const AValue: Boolean);
begin
  if AValue <> FForceLateBinding then begin
    FForceLateBinding := AValue;
    if AValue then
      FLateBinding := True;
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCVariable.GetDataInd(AIndex: SQLULen; out ApData: SQLPointer;
  out ApInd: PSQLLen): PSQLPointer;
begin
  ASSERT((FList <> nil) and (FList.FBuffer <> nil));
  FList.FBuffer.GetDataPtr(Self, AIndex, SQLPointer(Result), ApInd);
  ASSERT(Result <> nil);
  if LongData then
    ApData := Result^
  else
    ApData := Result;
end;

{-------------------------------------------------------------------------------}
function TODBCVariable.GetDataPtr(AIndex: SQLULen; out ApData: SQLPointer;
  out ASize: SQLLen; out ApInd: PSQLLen): PSQLPointer;
begin
  ASSERT((FList <> nil) and (FList.FBuffer <> nil));
  FList.FBuffer.GetDataPtr(Self, AIndex, SQLPointer(Result), ApInd);
  ASSERT(Result <> nil);
  if LongData then
    ApData := Result^
  else
    ApData := Result;
  if (ApInd^ = SQL_NULL_DATA) or (ApInd^ = SQL_NO_TOTAL) then
    ASize := 0
  else
    ASize := ApInd^;
  if LongData then
    // This is a workaround for Sybase ASE, which for BLOB input params
    // does not support SQL_LEN_DATA_AT_EXEC macro and resets indicator
    // to SQL_DATA_AT_EXEC value.
    if ASize = SQL_DATA_AT_EXEC then
      ASize := FLastDataSize
    else begin
      ASSERT((ASize <= SQL_LEN_DATA_AT_EXEC_OFFSET) or (ASize >= 0));
      if ApData = nil then
        ASize := 0
      else if ASize <= SQL_LEN_DATA_AT_EXEC_OFFSET then
        ASize := SQL_LEN_DATA_AT_EXEC_OFFSET - ASize;
    end;
  ASSERT((SQLDataType <> SQL_SS_TABLE) and (
           not LongData and (ASize >= 0) or
           LongData and (ASize >= 0) or (ASize = SQL_LEN_DATA_AT_EXEC_OFFSET - SQL_DATA_AT_EXEC)
         ) or
         (SQLDataType = SQL_SS_TABLE) and (
           (ASize = 0) or (ASize = SQL_LEN_DATA_AT_EXEC_OFFSET - SQL_DATA_AT_EXEC)
         ));
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariable.Bind;
begin
  UpdateFlags;
  ASSERT((FList <> nil) and (FList.FBuffer <> nil) and FList.FBuffer.FIsAllocated);
  InternalBind;
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariable.SetBindAttributes(ADescKind: SQLInteger);
var
  hAD: SQLHDesc;
  iTmp: Integer;
  oConn: TODBCConnection;
  oStmt: TODBCStatementBase;
begin
  oConn := Connection;
  if (oConn.DriverODBCVersion < ovODBC3) or
     (oConn.DriverKind in [dkElevateDB, dkFreeTDS, dkCache]) then
    Exit;
  oStmt := Statement;
  case CDataType of
  SQL_C_NUMERIC:
    begin
      oStmt.Check(oStmt.Lib.SQLGetStmtAttr(oStmt.FHandle, ADescKind, @hAD, 0, iTmp));
      oStmt.Check(oStmt.Lib.SQLSetDescField(hAD, Position, SQL_DESC_CONCISE_TYPE,
        SQLPointer(CDataType), SQL_IS_SMALLINT));
      oStmt.Check(oStmt.Lib.SQLSetDescField(hAD, Position, SQL_DESC_PRECISION,
        SQLPointer(ColumnSize), SQL_IS_INTEGER));
      oStmt.Check(oStmt.Lib.SQLSetDescField(hAD, Position, SQL_DESC_SCALE,
        SQLPointer(Scale), SQL_IS_SMALLINT));
      if (ADescKind = SQL_ATTR_APP_PARAM_DESC) and not LongData or
         (ADescKind = SQL_ATTR_APP_ROW_DESC) and FBinded then
        // MSSQL: if SQL_DESC_DATA_PTR is NOT set, then SQLExecute gives
        // "Invalid string or buffer length"
        oStmt.Check(oStmt.Lib.SQLSetDescField(hAD, Position, SQL_DESC_DATA_PTR,
          LocalBuffer, SQL_IS_POINTER));
    end;
  SQL_C_INTERVAL_YEAR ..
  SQL_C_INTERVAL_MINUTE_TO_SECOND:
    begin
      oStmt.Check(oStmt.Lib.SQLGetStmtAttr(oStmt.FHandle, ADescKind, @hAD, 0, iTmp));
      oStmt.Check(oStmt.Lib.SQLSetDescField(hAD, Position, SQL_DESC_CONCISE_TYPE,
        SQLPointer(CDataType), SQL_IS_SMALLINT));
      oStmt.Check(oStmt.Lib.SQLSetDescField(hAD, Position, SQL_DESC_DATETIME_INTERVAL_PRECISION,
        SQLPointer(ColumnSize), SQL_IS_INTEGER));
      oStmt.Check(oStmt.Lib.SQLSetDescField(hAD, Position, SQL_DESC_PRECISION,
        SQLPointer(Scale), SQL_IS_SMALLINT));
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariable.VarTypeUnsup(ACType: SQLSmallint);
begin
  FDException(Statement.OwningObj, [S_FD_LPhys, S_FD_ODBCId],
    er_FD_OdbcVarDataTypeUnsup, [GetDumpLabel, ACType]);
end;

{-------------------------------------------------------------------------------}
function TODBCVariable.GetData(AIndex: SQLULen; var ApData: SQLPointer;
  var ASize: SQLLen; AByRef: Boolean = False): Boolean;
var
  pData: SQLPointer;
  pInd: PSQLLen;
  pText: SQLPointer;
  pTail: SQLPointer;
  pTime2: PSQLSSTime2Struct;
  pDate: PSQLDateStruct;
  pTime: PSQLTimeStruct;
  pInt: PFDSQLTimeInterval;
begin
  GetDataPtr(AIndex, pData, ASize, pInd);
  if (pInd^ = SQL_NULL_DATA) or (pData = nil) then begin
    Result := False;
    ASize := 0;
    if AByRef then
      ApData := nil;
  end
  else begin
    if pInd^ = SQL_NO_TOTAL then
      ASize := 0;
    Result := True;
    case CDataType of
    SQL_C_STINYINT,
    SQL_C_UTINYINT,
    SQL_C_TINYINT:
      if AByRef then
        ApData := pData
      else if ApData <> nil then
        PSQLByte(ApData)^ := PSQLByte(pData)^;
    SQL_C_SSHORT,
    SQL_C_USHORT,
    SQL_C_SHORT:
      if AByRef then
        ApData := pData
      else if ApData <> nil then
        PSQLSmallint(ApData)^ := PSQLSmallint(pData)^;
    SQL_C_SLONG,
    SQL_C_ULONG,
    SQL_C_LONG:
      if AByRef then
        ApData := pData
      else if ApData <> nil then
        PSQLInteger(ApData)^ := PSQLInteger(pData)^;
    SQL_C_SBIGINT,
    SQL_C_UBIGINT:
      if AByRef then
        ApData := pData
      else if ApData <> nil then
        PSQLBigInt(ApData)^ := PSQLBigInt(pData)^;
    SQL_C_BIT:
      if AByRef then
        ApData := pData
      else begin
        ASize := SizeOf(WordBool);
        if not AByRef and (ApData <> nil) then
          PWordBool(ApData)^ := (PSQLByte(pData)^ <> 0);
      end;
    SQL_C_FLOAT:
      if AByRef then
        ApData := pData
      else if ApData <> nil then
        PSQLReal(ApData)^ := PSQLReal(pData)^;
    SQL_C_DOUBLE:
      if AByRef then
        ApData := pData
      else if ApData <> nil then
        PSQLDouble(ApData)^ := PSQLDouble(pData)^;
    SQL_C_NUMERIC:
      if AByRef then
        ApData := pData
      else if ApData <> nil then begin
        if IsCurrency then begin
          ODBCNumeric2Currency(PSQLNumericRec(pData)^, PCurrency(ApData)^);
          ASize := SizeOf(Currency);
        end
        else begin
          ODBCNumeric2BCD(PSQLNumericRec(pData)^, PBcd(ApData)^);
          ASize := SizeOf(TBcd);
        end;
      end;
    SQL_C_BINARY:
      begin
        case SQLDataType of
        SQL_SS_TIME2:
          if AByRef then
            ApData := pData
          else if ApData <> nil then begin
            pTime2 := PSQLSSTime2Struct(pData);
            PInteger(ApData)^ := (pTime2^.Second + pTime2^.Minute * 60 +
              pTime2^.Hour * 3600) * 1000 + pTime2^.Fraction div 1000000;
            ASize := SizeOf(Integer);
          end;
        else
          begin
            if (SQLDataType = SQL_BINARY) and Statement.StrsTrim then begin
              pTail := PFDAnsiString(pData) + ASize - 1;
              while (ASize > 0) and (PByte(pTail)^ = 0) do begin
                Dec(ASize);
                Dec(PFDAnsiString(pTail));
              end;
            end;
            if (ASize = 0) and Statement.StrsEmpty2Null then begin
              Result := False;
              ASize := 0;
              if AByRef then
                ApData := nil;
            end
            else if AByRef then
              ApData := pData
            else if ApData <> nil then begin
              Move(PSQLByte(pData)^, PSQLByte(ApData)^, ASize);
              if (SQLDataType = SQL_BINARY) and (ASize < DataSize) then
                FillChar((PFDAnsiString(ApData) + ASize)^, DataSize - ASize, 0);
            end;
          end;
        end;
      end;
    SQL_C_CHAR:
      begin
        if ASize = SQL_NTS then
          ASize := FDAnsiStrLen(PFDAnsiString(pData));
        case SQLDataType of
        SQL_NUMERIC,
        SQL_DECIMAL:
          if AByRef then
            ApData := pData
          else if ApData <> nil then begin
            pText := nil;
            ASize := Connection.FEncoder.Decode(pData, ASize, pText);
            if IsCurrency then begin
              FDStr2Curr(PChar(pText), ASize, PCurrency(ApData)^, DecimalSeparator);
              ASize := SizeOf(Currency);
            end
            else begin
              FDStr2BCD(PChar(pText), ASize, PBcd(ApData)^, DecimalSeparator);
              ASize := SizeOf(TBcd);
            end;
          end;
        else
          begin
            if (SQLDataType = SQL_CHAR) and Statement.StrsTrim then begin
              pTail := PFDAnsiString(pData) + ASize - 1;
              while (ASize > 0) and (PFDAnsiString(pTail)^ = TFDAnsiChar(' ')) do begin
                Dec(ASize);
                Dec(PFDAnsiString(pTail));
              end;
            end;
            if (ASize = 0) and Statement.StrsEmpty2Null then begin
              Result := False;
              ASize := 0;
              if AByRef then
                ApData := nil;
            end
            else if AByRef then
              ApData := pData
            else if ApData <> nil then begin
              Move(PFDAnsiString(pData)^, PFDAnsiString(ApData)^, ASize * SizeOf(TFDAnsiChar));
              if (SQLDataType = SQL_CHAR) and (ASize * SizeOf(TFDAnsiChar) < DataSize) then
                FillChar((PFDAnsiString(ApData) + ASize)^, DataSize - ASize * SizeOf(TFDAnsiChar), 0);
            end;
          end;
        end;
      end;
    SQL_C_WCHAR:
      begin
        if ASize = SQL_NTS then
          ASize := StrLen(PWideChar(pData))
        else
          ASize := ASize div SizeOf(WideChar);
        if ((SQLDataType = SQL_WCHAR) or (SQLDataType = SQL_GRAPHIC)) and Statement.StrsTrim then begin
          pTail := PWideChar(pData) + ASize - 1;
          while (ASize > 0) and (PWideChar(pTail)^ = ' ') do begin
            Dec(ASize);
            Dec(PWideChar(pTail));
          end;
        end
        else if ((SQLDataType = SQL_XML) or
                 (SQLDataType = SQL_SS_XML) or
                 (SQLDataType = SQL_TD_XML) or (SQLDataType = SQL_TD_JSON) or (SQLDataType = SQL_TD_WJSON)) and
                (PWideChar(pData)^ = #$FEFF) then begin
          Inc(PWideChar(pData));
          Dec(ASize);
        end;
        if (ASize = 0) and Statement.StrsEmpty2Null then begin
          Result := False;
          ASize := 0;
          if AByRef then
            ApData := nil;
        end
        else if AByRef then
          ApData := pData
        else if ApData <> nil then begin
          Move(PWideChar(pData)^, PWideChar(ApData)^, ASize * SizeOf(WideChar));
          if ((SQLDataType = SQL_WCHAR) or (SQLDataType = SQL_GRAPHIC)) and (ASize * SizeOf(WideChar) < DataSize) then
            FillChar((PWideChar(ApData) + ASize)^, DataSize - ASize * SizeOf(WideChar), 0);
        end;
      end;
    SQL_C_TYPE_DATE,
    SQL_C_DATE:
      if AByRef then
        ApData := pData
      else if ApData <> nil then begin
        pDate := PSQLDateStruct(pData);
        PInteger(ApData)^ := Integer(Trunc(EncodeDate(pDate^.Year,
          pDate^.Month, pDate^.Day) + DateDelta));
        ASize := SizeOf(Integer);
      end;
    SQL_C_TYPE_TIME,
    SQL_C_TIME:
      if AByRef then
        ApData := pData
      else if ApData <> nil then begin
        pTime := PSQLTimeStruct(pData);
        PInteger(ApData)^ := (pTime^.Second + pTime^.Minute * 60 + pTime^.Hour * 3600) * 1000;
        ASize := SizeOf(Integer);
      end;
    SQL_C_TYPE_TIMESTAMP,
    SQL_C_TIMESTAMP:
      if AByRef then
        ApData := pData
      else if ApData <> nil then begin
        // The layout of the TODBCTimeStamp and TSQLTimeStamp is the same
        PODBCTimeStamp(ApData)^ := PODBCTimeStamp(pData)^;
        PSQLTimeStamp(ApData)^.Fractions := PSQLTimeStamp(ApData)^.Fractions div 1000000;
        // Informix ODBC driver returns DATETIME HOUR TO MINUTE (or other
        // time-only precision) with Date=(1200,1,1). For BDE / Delphi RTL
        // compatibility set Date part to TDateTime(0).
        if (Statement.Connection.DriverKind = dkInformix) and
           (PSQLTimeStamp(ApData)^.Year = 1200) and
           (PSQLTimeStamp(ApData)^.Month = 1) and
           (PSQLTimeStamp(ApData)^.Day = 1) then begin
          PSQLTimeStamp(ApData)^.Year := 1899;
          PSQLTimeStamp(ApData)^.Month := 12;
          PSQLTimeStamp(ApData)^.Day := 30;
        end;
      end;
    SQL_C_INTERVAL_YEAR ..
    SQL_C_INTERVAL_MINUTE_TO_SECOND:
      if AByRef then
        ApData := pData
      else if ApData <> nil then begin
        pInt := PFDSQLTimeInterval(ApData);
        if PSQLInterval(pData)^.Interval_sign = SQL_TRUE then
          pInt^.Sign := -1
        else
          pInt^.Sign := 1;
        pInt^.Kind := TFDSQLTimeIntervalKind(PSQLInterval(pData)^.Interval_type);
        case PSQLInterval(pData)^.Interval_type of
        SQL_IS_YEAR,
        SQL_IS_MONTH,
        SQL_IS_YEAR_TO_MONTH:
          begin
            pInt^.Years := PSQLInterval(pData)^.YearMonth.Year;
            pInt^.Months := PSQLInterval(pData)^.YearMonth.Month;
          end;
        SQL_IS_DAY,
        SQL_IS_HOUR,
        SQL_IS_MINUTE,
        SQL_IS_SECOND,
        SQL_IS_DAY_TO_HOUR,
        SQL_IS_DAY_TO_MINUTE,
        SQL_IS_DAY_TO_SECOND,
        SQL_IS_HOUR_TO_MINUTE,
        SQL_IS_HOUR_TO_SECOND,
        SQL_IS_MINUTE_TO_SECOND:
          begin
            pInt^.Days := PSQLInterval(pData)^.DaySecond.Day;
            pInt^.Hours := PSQLInterval(pData)^.DaySecond.Hour;
            pInt^.Minutes := PSQLInterval(pData)^.DaySecond.Minute;
            pInt^.Seconds := PSQLInterval(pData)^.DaySecond.Second;
            pInt^.Fractions := PSQLInterval(pData)^.DaySecond.Fraction;
          end;
        else
          ASSERT(False);
        end;
        ASize := SizeOf(TFDSQLTimeInterval);
      end;
    SQL_C_GUID:
      if AByRef then
        ApData := pData
      else if ApData <> nil then
        PGUID(ApData)^ := PGUID(pData)^;
    else
      VarTypeUnsup(CDataType);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCVariable.GetAsStrings(AIndex: SQLULen): String;
var
  pVal: SQLPointer;
  iSz: SQLLen;
begin
  Result := '';
  pVal := nil;
  iSz := 0;
  if GetData(AIndex, pVal, iSz, True) then
    case CDataType of
    SQL_C_CHAR:
      Result := Connection.FEncoder.Decode(pVal, iSz, ecANSI);
    SQL_C_WCHAR:
      Result := Connection.FEncoder.Decode(pVal, iSz, ecUTF16);
    else
      ASSERT(False);
    end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariable.SetData(AIndex: SQLULen; ApData: SQLPointer; ASize: SQLLen);
var
  pData: SQLPointer;
  pInd: PSQLLen;
  iSize: SQLLen;
  iLen: Integer;
  iYear, iMonth, iDay: Word;
  iSeconds: Cardinal;
  lIsNull: WordBool;
  pTime2: PSQLSSTime2Struct;
  pDate: PSQLDateStruct;
  pTime: PSQLTimeStruct;
  pInt: PFDSQLTimeInterval;
  aBuff: array[0..255] of Byte;
  rBcd: TBcd;

  procedure ErrorDataTooLarge(AMax: SQLLen; AActual: Integer);
  begin
    FDException(Statement.OwningObj, [S_FD_LPhys, S_FD_ODBCId],
      er_FD_AccDataToLarge, [GetDumpLabel, AMax, AActual]);
  end;

begin
  if LongData and IsParameter then
    if (ParamType in [SQL_PARAM_INPUT_OUTPUT, SQL_PARAM_OUTPUT,
                      SQL_PARAM_INPUT_OUTPUT_STREAM, SQL_PARAM_OUTPUT_STREAM]) and
       (ASize < DataSize) and (DataSize <> MaxInt) then
      AllocLongData(AIndex, DataSize)
    else
      AllocLongData(AIndex, ASize);

  GetDataPtr(AIndex, pData, iSize, pInd);
  if ApData = nil then begin
    lIsNull := True;
    iSize := SQL_NULL_DATA;
  end
  else
    lIsNull := False;
  case CDataType of
  SQL_C_STINYINT,
  SQL_C_UTINYINT,
  SQL_C_TINYINT:
    if lIsNull then
      PSQLByte(pData)^ := 0
    else begin
      PSQLByte(pData)^ := PSQLByte(ApData)^;
      iSize := SizeOf(SQLByte);
    end;
  SQL_C_SSHORT,
  SQL_C_USHORT,
  SQL_C_SHORT:
    if lIsNull then
      PSQLSmallint(pData)^ := 0
    else begin
      if MSAccBoolean and (PSQLSmallint(ApData)^ <> 0) then
        PSQLSmallint(pData)^ := -1
      else
        PSQLSmallint(pData)^ := PSQLSmallint(ApData)^;
      iSize := SizeOf(SQLSmallint);
    end;
  SQL_C_SLONG,
  SQL_C_ULONG,
  SQL_C_LONG:
    if lIsNull then
      PSQLInteger(pData)^ := 0
    else begin
      PSQLInteger(pData)^ := PSQLInteger(ApData)^;
      iSize := SizeOf(SQLInteger);
    end;
  SQL_C_SBIGINT,
  SQL_C_UBIGINT:
    if lIsNull then
      PSQLBigInt(pData)^ := 0
    else begin
      PSQLBigInt(pData)^ := PSQLBigInt(ApData)^;
      iSize := SizeOf(SQLBigInt);
    end;
  SQL_C_BIT:
    if lIsNull then
      PSQLByte(pData)^ := 0
    else begin
      PSQLByte(pData)^ := SQLByte(PWordBool(ApData)^ = True);
      iSize := SizeOf(SQLByte);
    end;
  SQL_C_FLOAT:
    if lIsNull then
      PSQLReal(pData)^ := 0.0
    else begin
      PSQLReal(pData)^ := PSQLReal(ApData)^;
      iSize := SizeOf(SQLReal);
    end;
  SQL_C_DOUBLE:
    if lIsNull then
      PSQLDouble(pData)^ := 0.0
    else begin
      PSQLDouble(pData)^ := PSQLDouble(ApData)^;
      iSize := SizeOf(SQLDouble);
    end;
  SQL_C_NUMERIC:
    if lIsNull then
      FillChar(PSQLNumericRec(pData)^, SizeOf(TSQLNumericRec), 0)
    else begin
      if IsCurrency then
        ODBCCurrency2Numeric(PCurrency(ApData)^, PSQLNumericRec(pData)^)
      else begin
        if Connection.DriverKind = dkTeradata then begin
          NormalizeBcd(PBcd(ApData)^, rBcd, ColumnSize, Scale);
          ApData := @rBcd;
        end;
        ODBCBCD2Numeric(PBcd(ApData)^, PSQLNumericRec(pData)^);
      end;
      iSize := SizeOf(TSQLNumericRec);
    end;
  SQL_C_BINARY:
    if SQLDataType = SQL_SS_TIME2 then begin
      if lIsNull then
        FillChar(PSQLSSTime2Struct(pData)^, SizeOf(TSQLSSTime2Struct), 0)
      else begin
        iSeconds := PCardinal(ApData)^ div 1000;
        pTime2 := PSQLSSTime2Struct(pData);
        pTime2^.Hour     := SQLUSmallint(iSeconds div 3600);
        pTime2^.Minute   := SQLUSmallint((iSeconds div 60) mod 60);
        pTime2^.Second   := SQLUSmallint(iSeconds mod 60);
        pTime2^.Fraction := SQLUInteger(PCardinal(ApData)^ mod 1000 * 1000000);
        iSize := SizeOf(TSQLSSTime2Struct);
      end;
    end
    else begin
      if lIsNull then begin
        if DataSize <> MAXINT then
          FillChar(PSQLByte(pData)^, DataSize, 0);
      end
      else begin
        iSize := ASize;
        if (SQLDataType = SQL_BINARY) and Statement.StrsTrim then
          while (iSize > 0) and (PByte(ApData)[iSize - 1] = 0) do
            Dec(iSize);
        if Statement.StrsEmpty2Null and (iSize = 0) then
          iSize := SQL_NULL_DATA
        else
          Move(PSQLByte(ApData)^, PSQLByte(pData)^, iSize);
      end;
    end;
  SQL_C_CHAR:
    case SQLDataType of
    SQL_NUMERIC,
    SQL_DECIMAL:
      if lIsNull then begin
        if DataSize > 1 then
          PFDAnsiString(pData)[0] := TFDAnsiChar('0');
        if DataSize > 2 then
          PFDAnsiString(pData)[1] := TFDAnsiChar(DecimalSeparator);
        if DataSize > 3 then begin
          PFDAnsiString(pData)[2] := TFDAnsiChar('0');
          PFDAnsiString(pData)[3] := TFDAnsiChar(#0);
        end
        else
          PFDAnsiString(pData)[DataSize - 1] := TFDAnsiChar(#0);
      end
      else begin
        if IsCurrency then
          FDCurr2Str(PChar(@aBuff[0]), iLen, PCurrency(ApData)^, DecimalSeparator)
        else
          FDBCD2Str(PChar(@aBuff[0]), iLen, PBcd(ApData)^, DecimalSeparator);
        iSize := Connection.FEncoder.Encode(PChar(@aBuff[0]), iLen, pData) *
          SizeOf(TFDAnsiChar);
        // add one for #0
        if DataSize < iSize + 1 then
          ErrorDataTooLarge(DataSize, iSize + 1);
      end;
    else
      if lIsNull then begin
        if DataSize <> MAXINT then
          FillChar(PFDAnsiString(pData)^, DataSize * SizeOf(TFDAnsiChar), 0);
      end
      else begin
        if ASize = SQL_NTS then
          iSize := FDAnsiStrLen(PFDAnsiString(ApData))
        else
          iSize := ASize;
        if (iSize * SizeOf(TFDAnsiChar) > DataSize) and not LongData then
          ErrorDataTooLarge(DataSize, iSize);
        if (SQLDataType = SQL_CHAR) and Statement.StrsTrim then
          while (iSize > 0) and (PFDAnsiString(ApData)[iSize - 1] = TFDAnsiChar(' ')) do
            Dec(iSize);
        if Statement.StrsEmpty2Null and (iSize = 0) then
          iSize := SQL_NULL_DATA
        else begin
          Move(PFDAnsiString(ApData)^, PFDAnsiString(pData)^, iSize * SizeOf(TFDAnsiChar));
          iSize := iSize * SizeOf(TFDAnsiChar);
        end;
      end;
    end;
  SQL_C_WCHAR:
    if lIsNull then begin
      if DataSize <> MAXINT then
        FillChar(PWideChar(pData)^, DataSize, 0);
    end
    else begin
      if ASize = SQL_NTS then
        iSize := StrLen(PWideChar(ApData))
      else
        iSize := ASize;
      if (iSize * SizeOf(WideChar) > DataSize) and not LongData then
        ErrorDataTooLarge(DataSize, iSize * SizeOf(WideChar));
      if ((SQLDataType = SQL_WCHAR) or (SQLDataType = SQL_GRAPHIC)) and Statement.StrsTrim then
        while (iSize > 0) and (PWideChar(ApData)[iSize - 1] = ' ') do
          Dec(iSize);
      if Statement.StrsEmpty2Null and (iSize = 0) then
        iSize := SQL_NULL_DATA
      else begin
        Move(PWideChar(ApData)^, PWideChar(pData)^, iSize * SizeOf(WideChar));
        iSize := iSize * SizeOf(WideChar);
      end;
    end;
  SQL_C_TYPE_DATE,
  SQL_C_DATE:
    if lIsNull then
      FillChar(PSQLDateStruct(pData)^, SizeOf(TSQLDateStruct), 0)
    else begin
      iYear := 0;
      iMonth := 0;
      iDay := 0;
      DecodeDate(PInteger(ApData)^ - DateDelta, iYear, iMonth, iDay);
      pDate := PSQLDateStruct(pData);
      pDate^.Year  := iYear;
      pDate^.Month := iMonth;
      pDate^.Day   := iDay;
      iSize := SizeOf(TSQLDateStruct);
    end;
  SQL_C_TYPE_TIME,
  SQL_C_TIME:
    if lIsNull then
      FillChar(PSQLTimeStruct(pData)^, SizeOf(TSQLTimeStruct), 0)
    else begin
      iSeconds := Cardinal(PInteger(ApData)^ div 1000);
      pTime := PSQLTimeStruct(pData);
      pTime^.Hour   := SQLUSmallint(iSeconds div 3600);
      pTime^.Minute := SQLUSmallint((iSeconds div 60) mod 60);
      pTime^.Second := SQLUSmallint(iSeconds mod 60);
      iSize := SizeOf(TSQLTimeStruct);
    end;
  SQL_C_TYPE_TIMESTAMP,
  SQL_C_TIMESTAMP:
    if lIsNull then
      FillChar(PODBCTimeStamp(pData)^, SizeOf(TSQLTimeStamp), 0)
    else begin
      // The layout of the TODBCTimeStamp and TSQLTimeStamp is the same
      PODBCTimeStamp(pData)^ := PODBCTimeStamp(ApData)^;
      PODBCTimeStamp(pData)^.Fraction := PODBCTimeStamp(pData)^.Fraction * 1000000;
      iSize := SizeOf(TODBCTimeStamp);
    end;
  SQL_C_INTERVAL_YEAR ..
  SQL_C_INTERVAL_MINUTE_TO_SECOND:
    begin
      FillChar(PSQLInterval(pData)^, SizeOf(TSQLInterval), 0);
      if not lIsNull then begin
        pInt := PFDSQLTimeInterval(ApData);
        if pInt^.Sign < 0 then
          PSQLInterval(pData)^.Interval_sign := SQL_TRUE
        else
          PSQLInterval(pData)^.Interval_sign := SQL_FALSE;
        PSQLInterval(pData)^.Interval_type := SQLInteger(pInt^.Kind);
        case PSQLInterval(pData)^.Interval_type of
        SQL_IS_YEAR,
        SQL_IS_MONTH,
        SQL_IS_YEAR_TO_MONTH:
          begin
            PSQLInterval(pData)^.YearMonth.Year := pInt^.Years;
            PSQLInterval(pData)^.YearMonth.Month := pInt^.Months;
          end;
        SQL_IS_DAY,
        SQL_IS_HOUR,
        SQL_IS_MINUTE,
        SQL_IS_SECOND,
        SQL_IS_DAY_TO_HOUR,
        SQL_IS_DAY_TO_MINUTE,
        SQL_IS_DAY_TO_SECOND,
        SQL_IS_HOUR_TO_MINUTE,
        SQL_IS_HOUR_TO_SECOND,
        SQL_IS_MINUTE_TO_SECOND:
          begin
            PSQLInterval(pData)^.DaySecond.Day := pInt^.Days;
            PSQLInterval(pData)^.DaySecond.Hour := pInt^.Hours;
            PSQLInterval(pData)^.DaySecond.Minute := pInt^.Minutes;
            PSQLInterval(pData)^.DaySecond.Second := pInt^.Seconds;
            PSQLInterval(pData)^.DaySecond.Fraction := pInt^.Fractions * 1000000;
          end;
        else
          ASSERT(False);
        end;
        iSize := SizeOf(TSQLInterval);
      end;
    end;
  SQL_C_GUID:
    if lIsNull then
      FillChar(PSQLGUID(pData)^, SizeOf(TSQLGUID), 0)
    else begin
      PGUID(pData)^ := PGUID(ApData)^;
      iSize := SizeOf(TSQLGUID);
    end;
  else
    VarTypeUnsup(CDataType);
  end;

  FLastDataSize := iSize;
  FDataReader := nil;
  if not LongData or
     (IsParameter and (ParamType in [SQL_PARAM_INPUT_OUTPUT, SQL_PARAM_OUTPUT,
                                     SQL_PARAM_INPUT_OUTPUT_STREAM, SQL_PARAM_OUTPUT_STREAM])) then
    pInd^ := iSize
  else if iSize <> SQL_NULL_DATA then
    pInd^ := SQL_LEN_DATA_AT_EXEC(iSize)
  else
    pInd^ := SQL_NULL_DATA;
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariable.SetDataReader(AIndex: SQLULen; ApData : SQLPointer);
var
  pData: SQLPointer;
  pInd: PSQLLen;
  iSize: SQLLen;
begin
  if not ((CDataType = SQL_C_CHAR) or (CDataType = SQL_C_WCHAR) or (CDataType = SQL_C_BINARY) or
          (CDataType = SQL_C_DEFAULT) and (SQLDataType = SQL_SS_TABLE)) then
    VarTypeUnsup(CDataType);

  try
    GetDataPtr(AIndex, pData, iSize, pInd);
    FLastDataSize := 0;
    if ApData = nil then begin
      FDataReader := nil;
      pInd^ := SQL_NULL_DATA;
    end
    else begin
      FDataReader := PUnknown(ApData)^;
      pInd^ := SQL_DATA_AT_EXEC;
    end;
  finally
    PUnknown(ApData)^ := nil;
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCVariable.AllocLongData(AIndex: SQLULen; ASize: SQLLen): PSQLPointer;
var
  pBuffer: SQLPointer;
  pInd: PSQLLen;
begin
  ASSERT(LongData);
  if CDataType = SQL_C_WCHAR then
    ASize := ASize * SizeOf(WideChar);
  Result := GetDataInd(AIndex, pBuffer, pInd);
  if pBuffer = nil then
    GetMem(Result^, ASize)
  else
    ReallocMem(Result^, ASize);
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariable.FreeLongData(AIndex: SQLULen);
var
  pBuffer: SQLPointer;
  ppBuffer: PSQLPointer;
  pInd: PSQLLen;
begin
  ASSERT(LongData);
  ppBuffer := GetDataInd(AIndex, pBuffer, pInd);
  if pBuffer <> nil then begin
    FreeMem(pBuffer);
    ppBuffer^ := nil;
  end;
  pInd^ := SQL_NULL_DATA;
end;

{-------------------------------------------------------------------------------}
function TODBCVariable.CalcDataSize(AColumnSize: SQLULen): SQLLen;
begin
  case CDataType of
  SQL_C_SLONG,
  SQL_C_ULONG,
  SQL_C_LONG:
    Result := SizeOf(SQLInteger);
  SQL_C_SBIGINT,
  SQL_C_UBIGINT:
    Result := SizeOf(SQLBigInt);
  SQL_C_BIT,
  SQL_C_TINYINT,
  SQL_C_STINYINT,
  SQL_C_UTINYINT:
    Result := SizeOf(SQLByte);
  SQL_C_SHORT,
  SQL_C_SSHORT,
  SQL_C_USHORT:
    Result := SizeOf(SQLSmallint);
  SQL_C_CHAR:
    if AColumnSize = MAXINT then
      Result := MAXINT
    else begin
      case SQLDataType of
      SQL_DECIMAL,
      SQL_NUMERIC:
        if AColumnSize = 0 then
          Result := C_FD_DefNumericSize
        else
          Result := AColumnSize + 2;
      SQL_CHAR,
      SQL_VARCHAR:
        if AColumnSize = 0 then
          Result := C_FD_DefStrSize
        else
          Result := AColumnSize;
      else
        if ParamType = SQL_PARAM_INPUT then
          Result := C_FD_DefLongSize
        else
          Result := C_FD_DefStrSize;
      end;
      if (Result <> C_FD_DefLongSize * SizeOf(TFDAnsiChar)) and
         (Result < High(SQLLen) - SizeOf(TFDAnsiChar)) then
        Inc(Result, SizeOf(TFDAnsiChar));
    end;
  SQL_C_WCHAR:
    if AColumnSize = MAXINT then
      Result := MAXINT
    else begin
      case SQLDataType of
      SQL_WCHAR,
      SQL_WVARCHAR,
      SQL_GRAPHIC,
      SQL_VARGRAPHIC,
      SQL_LONGVARGRAPHIC:
        if AColumnSize = 0 then
          Result := C_FD_DefStrSize
        else
          Result := AColumnSize;
      else
        if ParamType = SQL_PARAM_INPUT then
          Result := C_FD_DefLongSize
        else
          Result := C_FD_DefStrSize;
      end;
      Result := Result * SizeOf(SQLWChar);
      if (Result <> C_FD_DefLongSize * SizeOf(SQLWChar)) and
         (Result < High(SQLLen) - SizeOf(WideChar)) then
        Inc(Result, SizeOf(WideChar));
    end;
  SQL_C_FLOAT:
    Result := SizeOf(SQLReal);
  SQL_C_DOUBLE:
    Result := SizeOf(SQLDouble);
  SQL_C_NUMERIC:
    Result := SizeOf(TSQLNumericRec);
  SQL_C_GUID:
    Result := SizeOf(TSQLGUID);
  SQL_C_BINARY:
    if SQLDataType = SQL_SS_TIME2 then
      Result := SizeOf(TSQLSSTime2Struct)
    else if AColumnSize = MAXINT then
      Result := MAXINT
    else
      case SQLDataType of
      SQL_BINARY,
      SQL_VARBINARY:
        if AColumnSize = 0 then
          Result := C_FD_DefStrSize
        else
          Result := AColumnSize;
      else
        if ParamType = SQL_PARAM_INPUT then
          Result := C_FD_DefLongSize
        else
          Result := C_FD_DefStrSize;
      end;
  SQL_C_DATE,
  SQL_C_TYPE_DATE:
    Result := SizeOf(SQL_DATE_STRUCT);
  SQL_C_TIME,
  SQL_C_TYPE_TIME:
    Result := SizeOf(SQL_TIME_STRUCT);
  SQL_C_TYPE_TIMESTAMP,
  SQL_C_TIMESTAMP:
    Result := SizeOf(SQL_TIMESTAMP_STRUCT);
  SQL_C_INTERVAL_YEAR..
  SQL_C_INTERVAL_MINUTE_TO_SECOND:
    Result := SizeOf(TSQLInterval);
  else
    Result := 0;
    VarTypeUnsup(CDataType);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariable.UpdateFlags;
var
  iMaxCharSize, iMaxByteSize: Integer;
  lPrecUndef: Boolean;
  oConn: TODBCConnection;
begin
                             
                                                                                 
                                                                                                    
                                        
  if FFlagsUpdated then
    Exit;

  FIsCurrency := False;

  if SQLDataType = SQL_SS_VARIANT then
    // MSSQL: see comment in TODBCStatementBase.GetLongVarPiece
    FMSSQLVariantBinary := Connection.MSSQLVariantBinary and
      (Connection.DriverKind <> dkSQLOdbc)
  else if (SQLDataType = SQL_CHAR) or (SQLDataType = SQL_VARCHAR) or
     (SQLDataType = SQL_BINARY) or (SQLDataType = SQL_VARBINARY) or
     (SQLDataType = SQL_WVARCHAR) or (SQLDataType = SQL_WCHAR) or
     (SQLDataType = SQL_GRAPHIC) or (SQLDataType = SQL_VARGRAPHIC) or
     (SQLDataType = SQL_LONGVARGRAPHIC) or (SQLDataType = SQL_SS_XML) then begin
    ASSERT((FList <> nil) and (Statement <> nil));
    if FColumnSize > 0 then
      FDataSize := CalcDataSize(FColumnSize);
    oConn := Connection;
    if Assigned(oConn.OnGetMaxSizes) and (FColumnSize <> MAXINT) then begin
      iMaxCharSize := 0;
      iMaxByteSize := 0;
      oConn.OnGetMaxSizes(CDataType,
        (SQLDataType = SQL_CHAR) or (SQLDataType = SQL_WCHAR) or
        (SQLDataType = SQL_GRAPHIC) or (SQLDataType = SQL_BINARY),
        iMaxCharSize, iMaxByteSize);
      if (iMaxCharSize > 0) and ((FColumnSize <= 0) or (FColumnSize > iMaxCharSize)) then
        FColumnSize := iMaxCharSize;
      if (iMaxByteSize > 0) and ((FDataSize <= 0) or (FDataSize > iMaxByteSize)) then
        if CDataType = SQL_C_CHAR then
          FDataSize := iMaxByteSize + SizeOf(SQLChar)
        else if CDataType = SQL_C_WCHAR then
          FDataSize := iMaxByteSize + SizeOf(SQLWChar)
        else
          FDataSize := iMaxByteSize;
    end;
    if FColumnSize = 0 then begin
      FColumnSize := C_FD_DefStrSize;
      // MS JET DBF driver supports only up to 254 characters
      if (oConn.DriverKind = dkDBF) and (FColumnSize > 254) then
        FColumnSize := 254;
      FDataSize := CalcDataSize(FColumnSize);
    end;
  end

  else if (CDataType = SQL_C_TYPE_TIMESTAMP) or (CDataType = SQL_C_TIMESTAMP) then begin
    FColumnSize := 23;
    FScale := 3;
    FDataSize := CalcDataSize(FColumnSize);
  end

  else if CDataType = SQL_C_TYPE_DATE then begin
    FColumnSize := 10;
    FScale := 0;
    FDataSize := CalcDataSize(FColumnSize);
  end

  else if (CDataType >= SQL_C_INTERVAL_YEAR) and (CDataType <= SQL_C_INTERVAL_MINUTE_TO_SECOND) then begin
    // leading interval precision
    FColumnSize := 5;
    // interval second fraction precision
    FScale := 3;
    FDataSize := CalcDataSize(FColumnSize);
  end

  else if (SQLDataType = SQL_NUMERIC) or (SQLDataType = SQL_DECIMAL) then begin
    lPrecUndef := FColumnSize = 0;
    if lPrecUndef then
      FColumnSize := C_FD_DefNumericSize;
    if (FScale = 0) and IsParameter and
       ((Connection.DriverKind <> dkSybaseASE) or lPrecUndef) then begin
      if FColumnSize < C_FD_DefNumericSize then
        FColumnSize := FColumnSize + C_DEF_NUM_SCALE;
      FScale := C_DEF_NUM_SCALE;
    end;
    FDataSize := CalcDataSize(FColumnSize);
    FIsCurrency := ((ColumnSize = 19) or (ColumnSize = 10)) and (Scale = 4) and
      Statement.MoneySupported;
  end

  else if ((ParamType = SQL_PARAM_OUTPUT) or (ParamType = SQL_PARAM_OUTPUT_STREAM)) and (
      (SQLDataType = SQL_LONGVARCHAR) or (SQLDataType = SQL_WLONGVARCHAR) or
        (SQLDataType = SQL_LONGVARBINARY) or
      (SQLDataType = SQL_INFX_UDT_BLOB) or (SQLDataType = SQL_INFX_UDT_CLOB)) then begin
    FDataSize := 8000;
    FColumnSize := FDataSize;
    if SQLDataType = SQL_WLONGVARCHAR then
      FColumnSize := FColumnSize div SizeOf(SQLWChar);
  end

  else if SQLDataType = SQL_SS_TABLE then begin
    FScale := 0;
    FColumnSize := 1;
    FDataSize := 0;
  end

  else
    FDataSize := CalcDataSize(FColumnSize);

  FLongData := ForceLongData;
  if not LongData then
    case CDataType of
    SQL_C_CHAR,
    SQL_C_WCHAR,
    SQL_C_BINARY:
      case SQLDataType of
      SQL_LONGVARCHAR,
      SQL_WLONGVARCHAR,
      SQL_LONGVARBINARY,
      SQL_DBCLOB,
      SQL_XML,
      SQL_BLOB,
      SQL_CLOB,
      SQL_SS_VARIANT,
      SQL_SS_UDT,
      SQL_INFX_UDT_BLOB,
      SQL_INFX_UDT_CLOB,
      SQL_TD_XML,
      SQL_TD_JSON,
      SQL_TD_WJSON:
        FLongData := True;
      SQL_CHAR,
      SQL_VARCHAR:
        FLongData := (DataSize = MAXINT) or
          not IsParameter and (DataSize > Statement.MaxStringSize + SizeOf(SQLChar));
      SQL_BINARY,
      SQL_VARBINARY:
        FLongData := (DataSize = MAXINT) or
          not IsParameter and (DataSize > Statement.MaxStringSize);
      SQL_WCHAR,
      SQL_WVARCHAR,
      SQL_GRAPHIC,
      SQL_VARGRAPHIC,
      SQL_LONGVARGRAPHIC,
      SQL_SS_XML:
        FLongData := (DataSize = MAXINT) or
          not IsParameter and (DataSize > Statement.MaxStringSize + SizeOf(SQLWChar));
      end;
    SQL_C_DEFAULT:
      case SQLDataType of
      SQL_SS_TABLE:
        FLongData := True;
      end;
    end;

  if LongData and (Connection.DriverEnvVersion >= ovODBC38) then
    case FParamType of
    SQL_PARAM_INPUT_OUTPUT: FParamType := SQL_PARAM_INPUT_OUTPUT_STREAM;
    SQL_PARAM_OUTPUT:       FParamType := SQL_PARAM_OUTPUT_STREAM;
    end;

  FLateBinding := LongData or FForceLateBinding;
  ResetFlagsUpdated;
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariable.ResetFlagsUpdated;
begin
  FFlagsUpdated := True;
end;

{-------------------------------------------------------------------------------}
function TODBCVariable.GetDumpLabel: string;
begin
{$IFDEF FireDAC_MONITOR}
  if FDumpLabel <> '' then
    Result := FDumpLabel
  else
{$ENDIF}
  if Name <> '' then
    Result := Name
  else
    Result := Format('#%d', [Position]);
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
function TODBCVariable.DumpValue(AIndex: SQLULen; var ASize: SQLLen): String;
const
  C_IntNames: array [SQL_IS_UNKNOWN .. SQL_IS_MINUTE_TO_SECOND] of String = ('', 'y',
    'mo', 'd', 'h', 'mi', 's', 'y-mo', 'd-h', 'd-mi', 'd-s', 'h-mi', 'h-s', 'mi-s');
var
  pData: SQLPointer;
  rBCD: TBcd;
  iLen: Integer;
  aBuff: array [0 .. 127] of Char;
  pTime2: PSQLSSTime2Struct;
  pDate: PSQLDateStruct;
  pTime: PSQLTimeStruct;
  pTS: PODBCTimeStamp;
  pInt: PSQLInterval;
begin
  pData := nil;
  if not GetData(AIndex, pData, ASize, True) then
    Result := 'NULL'
  else begin
    case CDataType of
    SQL_C_UTINYINT:
      Result := Format('%u', [SQLByte(pData^)]);
    SQL_C_STINYINT,
    SQL_C_TINYINT:
      Result := Format('%d', [SQLSChar(pData^)]);
    SQL_C_USHORT:
      Result := Format('%u', [SQLUSmallint(pData^)]);
    SQL_C_SSHORT,
    SQL_C_SHORT:
      Result := Format('%d', [SQLSmallint(pData^)]);
    SQL_C_ULONG:
      Result := Format('%u', [SQLUInteger(pData^)]);
    SQL_C_SLONG,
    SQL_C_LONG:
      Result := Format('%d', [SQLInteger(pData^)]);
    SQL_C_UBIGINT:
      Result := Format('%u', [SQLUBigInt(pData^)]);
    SQL_C_SBIGINT:
      Result := Format('%d', [SQLBigInt(pData^)]);
    SQL_C_BIT:
      if PSQLByte(pData)^ <> 0 then
        Result := S_FD_True
      else
        Result := S_FD_False;
    SQL_C_FLOAT:
      Result := Format('%f', [SQLReal(pData^)]);
    SQL_C_DOUBLE:
      Result := Format('%f', [SQLDouble(pData^)]);
    SQL_C_NUMERIC:
      begin
        ODBCNumeric2BCD(PSQLNumericRec(pData)^, rBCD);
        FDBCD2Str(aBuff, iLen, rBCD, Char(DecimalSeparator));
        SetString(Result, aBuff, iLen);
      end;
    SQL_C_BINARY:
      if SQLDataType = SQL_SS_TIME2 then begin
        pTime2 := PSQLSSTime2Struct(pData);
        Result := Format('%.2d:%.2d:%.2d.%.3u', [pTime2^.Hour, pTime2^.Minute,
          pTime2^.Second, pTime2^.Fraction]);
      end
      else if ASize > 512 then
        Result := '(truncated at 512) ' + FDBin2Hex(pData, 512) + ' ...'
      else
        Result := FDBin2Hex(pData, ASize);
    SQL_C_CHAR:
      if ASize > 1024 then
        Result := '(truncated at 1024) ''' +
          Connection.FEncoder.Decode(pData, 1024, ecANSI) + ' ...'''
      else
        Result := '''' + Connection.FEncoder.Decode(pData, ASize, ecANSI) + '''';
    SQL_C_WCHAR:
      if ASize > 1024 then begin
        SetString(Result, PWideChar(pData), 1024);
        Result := '(truncated at 1024) ''' + Result + ' ...''';
      end
      else begin
        SetString(Result, PWideChar(pData), ASize);
        Result := '''' + Result + '''';
      end;
    SQL_C_TYPE_DATE,
    SQL_C_DATE:
      begin
        pDate := PSQLDateStruct(pData);
        Result := Format('%.4d-%.2d-%.2d', [pDate^.Year, pDate^.Month, pDate^.Day]);
      end;
    SQL_C_TYPE_TIME,
    SQL_C_TIME:
      begin
        pTime := PSQLTimeStruct(pData);
        Result := Format('%.2d:%.2d:%.2d', [pTime^.Hour, pTime^.Minute, pTime^.Second]);
      end;
    SQL_C_TYPE_TIMESTAMP,
    SQL_C_TIMESTAMP:
      begin
        pTS := PODBCTimeStamp(pData);
        Result := Format('%.4d-%.2d-%.2d %.2d:%.2d:%.2d.%.3d', [pTS^.Year,
          pTS^.Month, pTS^.Day, pTS^.Hour, pTS^.Minute, pTS^.Second, pTS^.Fraction]);
      end;
    SQL_C_INTERVAL_YEAR..
    SQL_C_INTERVAL_MINUTE_TO_SECOND:
      begin
        pInt := PSQLInterval(pData);
        case pInt^.Interval_type of
        SQL_IS_YEAR,
        SQL_IS_MONTH,
        SQL_IS_YEAR_TO_MONTH:
          Result := Format('%d-%d', [pInt^.YearMonth.Year, pInt^.YearMonth.Month]);
        SQL_IS_DAY,
        SQL_IS_HOUR,
        SQL_IS_MINUTE,
        SQL_IS_SECOND,
        SQL_IS_DAY_TO_HOUR,
        SQL_IS_DAY_TO_MINUTE,
        SQL_IS_DAY_TO_SECOND,
        SQL_IS_HOUR_TO_MINUTE,
        SQL_IS_HOUR_TO_SECOND,
        SQL_IS_MINUTE_TO_SECOND:
          Result := Format('%d %d:%d:%d.%d', [pInt^.DaySecond.Day, pInt^.DaySecond.Hour,
            pInt^.DaySecond.Minute, pInt^.DaySecond.Second, pInt^.DaySecond.Fraction]);
        else
          ASSERT(False);
        end;
        if pInt^.Interval_sign = SQL_TRUE then
          Result := '-' + Result;
        Result := Result + ' ' + C_IntNames[pInt^.Interval_type];
      end;
    SQL_C_GUID:
        Result := GUIDToString(PSQLGUID(pData)^);
    else
      Result := Format('<unsupported data type [%d]>', [CDataType]);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCVariable.DumpValue(AIndex: SQLULen): String;
var
  iSize: SQLLen;
begin
  Result := DumpValue(AIndex, iSize);
end;

{-------------------------------------------------------------------------------}
function TODBCVariable.DumpCDataType: String;
begin
  case CDataType of
  SQL_C_STINYINT:       Result := 'STINYINT';
  SQL_C_UTINYINT:       Result := 'UTINYINT';
  SQL_C_TINYINT:        Result := 'TINYINT';
  SQL_C_SSHORT:         Result := 'SSHORT';
  SQL_C_USHORT:         Result := 'USHORT';
  SQL_C_SHORT:          Result := 'SHORT';
  SQL_C_SLONG:          Result := 'SLONG';
  SQL_C_ULONG:          Result := 'ULONG';
  SQL_C_LONG:           Result := 'LONG';
  SQL_C_SBIGINT:        Result := 'SBIGINT';
  SQL_C_UBIGINT:        Result := 'UBIGINT';
  SQL_C_BIT:            Result := 'BIT';
  SQL_C_FLOAT:          Result := 'FLOAT';
  SQL_C_DOUBLE:         Result := 'DOUBLE';
  SQL_C_NUMERIC:        Result := 'NUMERIC';
  SQL_C_BINARY:         Result := 'BINARY';
  SQL_C_CHAR:           Result := 'CHAR';
  SQL_C_WCHAR:          Result := 'WCHAR';
  SQL_C_TYPE_DATE:      Result := 'TYPE_DATE';
  SQL_C_DATE:           Result := 'DATE';
  SQL_C_TYPE_TIME:      Result := 'TYPE_TIME';
  SQL_C_TIME:           Result := 'TIME';
  SQL_C_TYPE_TIMESTAMP: Result := 'TYPE_TIMESTAMP';
  SQL_C_TIMESTAMP:      Result := 'TIMESTAMP';
  SQL_C_GUID:           Result := 'GUID';
  SQL_C_INTERVAL_YEAR:             Result := 'INTERVAL_YEAR';
  SQL_C_INTERVAL_MONTH:            Result := 'INTERVAL_MONTH';
  SQL_C_INTERVAL_DAY:              Result := 'INTERVAL_DAY';
  SQL_C_INTERVAL_HOUR:             Result := 'INTERVAL_HOUR';
  SQL_C_INTERVAL_MINUTE:           Result := 'INTERVAL_MINUTE';
  SQL_C_INTERVAL_SECOND:           Result := 'INTERVAL_SECOND';
  SQL_C_INTERVAL_YEAR_TO_MONTH:    Result := 'INTERVAL_YEAR_TO_MONTH';
  SQL_C_INTERVAL_DAY_TO_HOUR:      Result := 'INTERVAL_DAY_TO_HOUR';
  SQL_C_INTERVAL_DAY_TO_MINUTE:    Result := 'INTERVAL_DAY_TO_MINUTE';
  SQL_C_INTERVAL_DAY_TO_SECOND:    Result := 'INTERVAL_DAY_TO_SECOND';
  SQL_C_INTERVAL_HOUR_TO_MINUTE:   Result := 'INTERVAL_HOUR_TO_MINUTE';
  SQL_C_INTERVAL_HOUR_TO_SECOND:   Result := 'INTERVAL_HOUR_TO_SECOND';
  SQL_C_INTERVAL_MINUTE_TO_SECOND: Result := 'INTERVAL_MINUTE_TO_SECOND';
  else                  Result := '#' + IntToStr(CDataType);
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCVariable.DumpParamType: String;
begin
  case ParamType of
  SQL_PARAM_TYPE_UNKNOWN:        Result := 'UNKNOWN';
  SQL_PARAM_INPUT:               Result := 'INPUT';
  SQL_PARAM_INPUT_OUTPUT:        Result := 'INPUT_OUTPUT';
  SQL_PARAM_INPUT_OUTPUT_STREAM: Result := 'PARAM_INPUT_OUTPUT_STREAM';
  SQL_PARAM_OUTPUT:              Result := 'OUTPUT';
  SQL_PARAM_OUTPUT_STREAM:       Result := 'PARAM_OUTPUT_STREAM';
  SQL_RETURN_VALUE:              Result := 'RETURN_VALUE';
  SQL_RESULT_COL:                Result := 'RESULT_COL';
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TODBCParameter                                                                }
{-------------------------------------------------------------------------------}
constructor TODBCParameter.Create;
begin
  inherited Create;
  FIsParameter := True;
  FParamType := SQL_PARAM_INPUT;
end;

{-------------------------------------------------------------------------------}
destructor TODBCParameter.Destroy;
begin
  FDFreeAndNil(FColumnList);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TODBCParameter.GetColumnList: TODBCVariableList;
begin
  if FColumnList = nil then begin
    ASSERT((Statement <> nil) and (Statement is TODBCCommandStatement));
    FColumnList := TODBCVariableList.Create(TODBCCommandStatement(Statement), True, True);
  end;
  Result := FColumnList;
end;

{-------------------------------------------------------------------------------}
procedure TODBCParameter.InternalBind;
var
  oConn: TODBCConnection;
  oStmt: TODBCCommandStatement;
  iColSize: SQLULen;
  pToken: SQLPointer;
  iTokenSize: SQLLen;
begin
  if SQLDataType = SQL_REFCURSOR then
    Exit;
  oStmt := Statement as TODBCCommandStatement;
  FBinded := False;
  if not LongData then begin
    FBinded := True;
    oStmt.Check(oStmt.Lib.SQLBindParameter(oStmt.Handle, Position, ParamType,
      CDataType, SQLDataType, ColumnSize, Scale, LocalBuffer, DataSize,
      LocalBufIndicator));
  end
  else if SQLDataType = SQL_SS_TABLE then begin
    FBinded := True;
    if DataTypeName <> '' then begin
      pToken := PWideChar(DataTypeName);
      iTokenSize := Length(DataTypeName) * SizeOf(WideChar);
    end
    else begin
      pToken := SQLPointer(Position);
      iTokenSize := 0;
    end;
    oStmt.Check(oStmt.Lib.SQLBindParameter(oStmt.Handle, Position, ParamType,
      CDataType, SQLDataType, ColumnSize, Scale, pToken, iTokenSize, LocalBufIndicator));
  end
  else begin
    oConn := Connection;
    if (oConn.DriverKind in [dkSQLNC, dkSQLOdbc]) and (oConn.DriverVersion >= svMSSQL2005) then
      iColSize := 0
    else if oConn.DriverKind = dkTeradata then
                                                                        
      if CDataType = SQL_C_WCHAR then
        iColSize := 2097088000 div 2
      else
        iColSize := 2097088000
    else
      if CDataType = SQL_C_WCHAR then
        iColSize := MAXINT div 2
      else
        iColSize := MAXINT;
    if (ParamType = SQL_PARAM_INPUT_OUTPUT_STREAM) or (ParamType = SQL_PARAM_OUTPUT_STREAM) or
       (ParamType = SQL_PARAM_INPUT) then begin
      FBinded := True;
      if FList.ChildList then
        pToken := Self
      else
        pToken := SQLPointer(Position);
      oStmt.Check(oStmt.Lib.SQLBindParameter(oStmt.Handle, Position, ParamType,
        CDataType, SQLDataType, iColSize, 0, pToken, 0, LocalBufIndicator));
    end
    else if PSQLPointer(LocalBuffer)^ <> nil then begin
      FBinded := True;
      oStmt.Check(oStmt.Lib.SQLBindParameter(oStmt.Handle, Position, ParamType,
        CDataType, SQLDataType, iColSize, 0, PSQLPointer(LocalBuffer)^, 0,
        LocalBufIndicator));
    end;
  end;
  if FBinded then begin
    SetBindAttributes(SQL_ATTR_APP_PARAM_DESC);
    if (FColumnList <> nil) and (FColumnList.Count > 0) then begin
      oStmt.SS_PARAM_FOCUS := Position;
      try
        FColumnList.Bind(1, True);
      finally
        oStmt.SS_PARAM_FOCUS := 0;
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCParameter.GetDecimalSeparator: Char;
begin
  Result := Connection.DecimalSepPar;
end;

{-------------------------------------------------------------------------------}
class function TODBCParameter.GetDescriptorType: SQLSmallint;
begin
  Result := SQL_APD_TYPE;
end;

{-------------------------------------------------------------------------------}
procedure TODBCParameter.SetParamType(const AValue: SQLSmallint);
begin
  if FParamType <> AValue then begin
    ASSERT(AValue <> SQL_RESULT_COL);
    FParamType := AValue;
    FFlagsUpdated := False;
  end;
end;

{-------------------------------------------------------------------------------}
{ TODBCColumn                                                                   }
{-------------------------------------------------------------------------------}
constructor TODBCColumn.Create;
begin
  inherited Create;
  FIsParameter := False;
  FParamType := SQL_RESULT_COL;
end;

{-------------------------------------------------------------------------------}
procedure TODBCColumn.InternalBind;
var
  oStmt: TODBCStatementBase;
begin
  oStmt := Statement;
  FBinded := False;
  if not LateBinding then begin
    FBinded := True;
    oStmt.Check(oStmt.Lib.SQLBindCol(oStmt.Handle, Position, CDataType,
      LocalBuffer, DataSize, LocalBufIndicator));
  end;
  SetBindAttributes(SQL_ATTR_APP_ROW_DESC);
end;

{-------------------------------------------------------------------------------}
function TODBCColumn.GetDecimalSeparator: Char;
begin
  Result := Connection.DecimalSepCol;
end;

{-------------------------------------------------------------------------------}
class function TODBCColumn.GetDescriptorType: SQLSmallint;
begin
  Result := SQL_ARD_TYPE;
end;

{-------------------------------------------------------------------------------}
{ TODBCVariableList                                                             }
{-------------------------------------------------------------------------------}
constructor TODBCVariableList.Create(AOwner: TODBCStatementBase; AParams, AChildList: Boolean);
begin
  ASSERT(AOwner <> nil);
  inherited Create;
  FList := TFDObjList.Create;
  FOwner := AOwner;
  FParameters := AParams;
  FChildList := AChildList;
end;

{-------------------------------------------------------------------------------}
destructor TODBCVariableList.Destroy;
begin
  Clear;
  FDFreeAndNil(FList);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariableList.Bind(ARowCount: SQLULen; AFixedLenOnly: Boolean);
begin
  ASSERT(Count > 0);
  if FBuffer = nil then
    FBuffer := TODBCPageBuffer.Create(Self);
  if (FBuffer.RowCount <> ARowCount) or not FBuffer.FIsAllocated then begin
    if FBuffer.FIsAllocated then
      FBuffer.FreeBuffers;
    FBuffer.FRowCount := ARowCount;
    FBuffer.AllocBuffers;
    Rebind(AFixedLenOnly);
    UpdateHasLateBindedVars;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariableList.Rebind(AFixedLenOnly: Boolean = False);
var
  i: Integer;
  oVar: TODBCVariable;
begin
  for i := 0 to Count - 1 do begin
    oVar := Items[i];
    if not (AFixedLenOnly and ((oVar.CDataType = SQL_C_CHAR) or
       (oVar.CDataType = SQL_C_WCHAR) or (oVar.CDataType = SQL_C_BINARY))) or
       (oVar.ParamType in [SQL_PARAM_INPUT, SQL_PARAM_INPUT_OUTPUT, SQL_PARAM_INPUT_OUTPUT_STREAM]) then
      oVar.Bind;
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCVariableList.Add(AVar: TODBCVariable): TODBCVariable;
begin
  ASSERT(Parameters and (AVar is TODBCParameter) or
         not Parameters and (AVar is TODBCColumn));
  Result := AVar;
  FList.Add(AVar);
  AVar.FList := Self;
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariableList.Clear;
var
  i: Integer;
begin
  // Do not use FreeAndNil here, because destructor will call methods
  // checking that FBuffer reference is not nil
  if FBuffer <> nil then begin
    FDFree(FBuffer);
    FBuffer := nil;
  end;
  for i := 0 to FList.Count - 1 do
    FDFree(TODBCVariable(FList[i]));
  FList.Clear;
end;

{-------------------------------------------------------------------------------}
function TODBCVariableList.GetCount: Integer;
begin
  Result := FList.Count;
end;

{-------------------------------------------------------------------------------}
function TODBCVariableList.GetItems(AIndex: Integer): TODBCVariable;
begin
  Result := TODBCVariable(FList[AIndex]);
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariableList.UpdateHasLateBindedVars;
var
  i: Integer;
begin
  FHasLateBindedVars := False;
  for i := 0 to Count - 1 do
    if Items[i].LateBinding then begin
      FHasLateBindedVars := True;
      Exit;
    end;
end;

{-------------------------------------------------------------------------------}
function TODBCVariableList.FindByToken(ApToken: SQLPointer): TODBCVariable;
var
  i: Integer;
  oVar: TODBCVariable;
  oPar: TODBCParameter;
begin
  if NativeUInt(ApToken) < $FFFF then
    Result := Items[NativeUInt(ApToken) - 1]
  else begin
    Result := nil;
    for i := 0 to Count - 1 do begin
      oVar := Items[i];
      if oVar = ApToken then
        Result := oVar
      else if oVar.IsParameter then begin
        oPar := TODBCParameter(oVar);
        if (oPar.DataTypeName <> '') and
           (StrLIComp(PChar(ApToken), PChar(oPar.DataTypeName), Length(oPar.DataTypeName)) = 0) then
          Result := oVar
        else if oPar.FColumnList <> nil then
          Result := oPar.FColumnList.FindByToken(ApToken)
      end;
      if Result <> nil then
        Break;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCVariableList.ResetDataReaders;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Items[i].FDataReader := nil;
end;

{-------------------------------------------------------------------------------}
{ TODBCPageBuffer                                                               }
{-------------------------------------------------------------------------------}
// ODBC column-wise page buffer. Row-wise binding is not used due to:
// - less stable than column-wise binding
// - less performant than column-wise binding

constructor TODBCPageBuffer.Create(AVarList: TODBCVariableList);
begin
  ASSERT(AVarList <> nil);
  inherited Create;
  FVariableList := AVarList;
  AVarList.FBuffer := Self;
  FRowCount := 1;
end;

{-------------------------------------------------------------------------------}
destructor TODBCPageBuffer.Destroy;
begin
  if FIsAllocated then
    FreeBuffers;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TODBCPageBuffer.AllocBuffers;
var
  i: Integer;
  pLocal: Pointer;
  oVar: TODBCVariable;
begin
  ASSERT(not FIsAllocated);
  FIsAllocated := True;
  if not FVariableList.ChildList then
    SetStmtAttributes;
  for i := 0 to FVariableList.Count - 1 do begin
    oVar := FVariableList[i];
    oVar.UpdateFlags;
    if oVar.LongData then begin
      GetMem(pLocal, SizeOf(Pointer) * RowCount);
      FillChar(pLocal^, SizeOf(Pointer) * RowCount, 0);
    end
    else
      GetMem(pLocal, oVar.DataSize * RowCount);
    oVar.LocalBuffer := pLocal;
    GetMem(pLocal, SizeOf(SQLLen) * RowCount);
    FillChar(pLocal^, SizeOf(SQLLen) * RowCount, $FF);
    oVar.LocalBufIndicator := pLocal;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCPageBuffer.FreeBuffers;
var
  i: Integer;
  j: SQLUInteger;
  oVar: TODBCVariable;
begin
  // Workaround for AV in ODBC drivers at reexecuting / unpreparing:
  // Advantage: clear ROWS_FETCHED_PTR
  // Teradata: clear ROW_STATUS_PTR
  if not FVariableList.Parameters then begin
    FVariableList.Owner.ROWS_FETCHED_PTR := nil;
    FVariableList.Owner.ROW_STATUS_PTR := nil;
  end;
  ASSERT(FIsAllocated and (FVariableList.FBuffer = Self));
  try
    for i := 0 to FVariableList.Count - 1 do begin
      oVar := FVariableList[i];
      if oVar.LongData then
        for j := 0 to FRowCount - 1 do
          oVar.FreeLongData(j);
      if oVar.LocalBuffer <> nil then begin
        FreeMem(oVar.LocalBuffer);
        oVar.LocalBuffer := nil;
      end;
      if oVar.LocalBufIndicator <> nil then begin
        FreeMem(oVar.LocalBufIndicator);
        oVar.LocalBufIndicator := nil;
      end;
    end;
  finally
    FIsAllocated := False;
    FRowCount := 1;
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCPageBuffer.GetPageSize: SQLULen;
begin
  Result := RowSize * RowCount;
end;

{-------------------------------------------------------------------------------}
function TODBCPageBuffer.GetRowSize: SQLULen;
var
  i: Integer;
  oVar: TODBCVariable;
begin
  Result := 0;
  for i := 0 to FVariableList.Count - 1 do begin
    oVar := FVariableList[i];
    if not oVar.LongData then
      Inc(Result, oVar.DataSize + SizeOf(SQLLen))
    else
      Inc(Result, SizeOf(Pointer) + SizeOf(SQLLen));
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCPageBuffer.GetRowStatusArr(AIndex: SQLULen): SQLUSmallint;
begin
  ASSERT((AIndex < FRowCount) and (AIndex < Length(FRowStatusArr)));
  Result := FRowStatusArr[AIndex];
end;

{-------------------------------------------------------------------------------}
function TODBCPageBuffer.GetRowOperationArr(AIndex: SQLULen): SQLUSmallint;
begin
  ASSERT((AIndex < FRowCount) and (AIndex < Length(FRowOperationArr)));
  Result := FRowOperationArr[AIndex];
end;

{-------------------------------------------------------------------------------}
procedure TODBCPageBuffer.SetStmtAttributes;
var
  oCmd: TODBCCommandStatement;
  oStmt: TODBCStatementBase;
  lPrevIgnoreErrors: Boolean;
begin
  // Some old ODBC drivers (AcuODBC v5) return "optional feature is not
  // implemented" on setting SQL_ATTR_ROW_BIND_TYPE. SQL_BIND_BY_COLUMN
  // is the default value, so just ignore error.
  oStmt := FVariableList.Owner;
  lPrevIgnoreErrors := oStmt.IgnoreErrors;
  oStmt.IgnoreErrors := True;
  try
    oStmt.ROW_BIND_TYPE := SQL_BIND_BY_COLUMN;
  finally
    oStmt.IgnoreErrors := lPrevIgnoreErrors;
  end;
  if FVariableList.Parameters then begin
    oCmd := oStmt as TODBCCommandStatement;
    if oCmd.ParamSetSupported then begin
      // +1 is a workaround for AV on fetching using Parkway Micro Focus ODBC driver
      SetLength(FRowStatusArr, FRowCount + 1);
      oCmd.PARAMSET_SIZE := FRowCount;
      oCmd.PARAM_STATUS_PTR := @FRowStatusArr[0];
      oCmd.PARAMS_PROCESSED_PTR := @FRowsProcessed;
    end;
  end
  else begin
    // +1 is a workaround for AV on fetching using Parkway Micro Focus ODBC driver
    SetLength(FRowStatusArr, FRowCount + 1);
    oStmt.ROW_ARRAY_SIZE := FRowCount;
    oStmt.ROW_STATUS_PTR := @FRowStatusArr[0];
    oStmt.ROWS_FETCHED_PTR := @FRowsProcessed;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCPageBuffer.GetDataPtr(AVar: TODBCVariable; AIndex: SQLULen;
  out ApData: SQLPointer; out ApInd: PSQLLen);
begin
  ASSERT((AVar.LocalBuffer <> nil) and (AIndex < FRowCount));
  if AVar.LongData then
    ApData := SQLPointer(NativeInt(AVar.LocalBuffer) + AIndex * SizeOf(Pointer))
  else
    ApData := SQLPointer(NativeInt(AVar.LocalBuffer) + AIndex * AVar.DataSize);
  ApInd := PSQLLen(NativeInt(AVar.LocalBufIndicator) + AIndex * SizeOf(SQLLen));
end;

{-------------------------------------------------------------------------------}
procedure TODBCPageBuffer.ShiftBuffersPtr(ARowCount: SQLLen);
var
  i: Integer;
  oVar: TODBCVariable;
begin
  for i := 0 to FVariableList.Count - 1 do begin
    oVar := FVariableList[i];
    // Cast to NativeInt to avoid "Integer overflow" on x64.
    // Casting to NativeUInt leads to "Integer overflow" on x32.
    if not oVar.LongData then
      Inc(NativeInt(oVar.FLocalBuffer), oVar.DataSize * ARowCount)
    else
      Inc(NativeInt(oVar.FLocalBuffer), SizeOf(SQLPointer) * ARowCount);
    Inc(NativeInt(oVar.FLocalBufIndicator), SizeOf(SQLLen) * ARowCount);
  end;
  FShifted := FShifted + ARowCount;
  FVariableList.Rebind;
end;

{-------------------------------------------------------------------------------}
procedure TODBCPageBuffer.UnShift;
begin
  if Shifted <> 0 then
    ShiftBuffersPtr(-Shifted);
end;

{-------------------------------------------------------------------------------}
procedure TODBCPageBuffer.SetOperationRange(ARowCount, AOffset: SQLULen);
var
  i: SQLUInteger;
begin
  ASSERT((AOffset >= 0) and (AOffset < FRowCount));
  ASSERT((ARowCount >= 1) and (ARowCount <= FRowCount));
  ASSERT(AOffset < ARowCount);
  for i := 0 to AOffset - 1 do
    FRowOperationArr[i] := SQL_PARAM_IGNORE;
  for i := AOffset to ARowCount - 1 do
    FRowOperationArr[i] := SQL_PARAM_PROCEED;
  for i := ARowCount to FRowCount - 1  do
    FRowOperationArr[i] := SQL_PARAM_IGNORE;
end;

{-------------------------------------------------------------------------------}
{ TODBCStatementBase                                                            }
{-------------------------------------------------------------------------------}
constructor TODBCStatementBase.Create(AOwner: TODBCConnection; AOwningObj: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  FOwningObj := AOwningObj;
  FHandleType := SQL_HANDLE_STMT;
  FODBCLib := FOwner.Lib;
  AllocHandle;
  FColumnList := TODBCVariableList.Create(Self, False, False);
  FMaxStringSize := C_FD_DefMaxStrSize;
  FStrsTrim := False;
  FStrsEmpty2Null := True;
  FPieceBuffLen := C_FD_DefPieceBuffLen;
end;

{-------------------------------------------------------------------------------}
destructor TODBCStatementBase.Destroy;
begin
  // Required to fix the issue:
  // http://www.da-soft.com/forums/anydac-general-english/native-mssql-ping-problem-after-connection-is-broken-2.html
  IgnoreErrors := True;
  Unprepare;
  FDFreeAndNil(FColumnList);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.ColAttributeInt(AColNum: SQLUSmallint;
  AFieldId: SQLUSmallint; var AAttr: SQLLen);
begin
  Check(Lib.SQLColAttributeInt(FHandle, AColNum, AFieldId, nil, 0, nil, AAttr));
end;

{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.ColAttributeIntSilent(AColNum, AFieldId: SQLUSmallint;
  var AAttr: SQLLen);
var
  iRet: SQLReturn;
begin
  iRet := Lib.SQLColAttributeInt(FHandle, AColNum, AFieldId, nil, 0, nil, AAttr);
  if not ((iRet = SQL_SUCCESS) or (iRet = SQL_SUCCESS_WITH_INFO)) then
    AAttr := 0;
end;

{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.ColAttributeSmallint(AColNum, AFieldId: SQLUSmallint;
  var AAttr: SQLSmallint);
begin
  Check(Lib.SQLColAttribute(FHandle, AColNum, AFieldId, nil, 0, nil, @AAttr));
end;

{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.ColAttributeSmallintSilent(AColNum, AFieldId: SQLUSmallint;
  var AAttr: SQLSmallint);
var
  iRet: SQLReturn;
begin
  iRet := Lib.SQLColAttribute(FHandle, AColNum, AFieldId, nil, 0, nil, @AAttr);
  if not ((iRet = SQL_SUCCESS) or (iRet = SQL_SUCCESS_WITH_INFO)) then
    AAttr := 0;
end;

{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.ColAttributeString(AColNum, AFieldId: SQLUSmallint;
  var AAttr: String);
var
  iStringLen: SQLSmallint;
begin
  SetLength(AAttr, C_STRING_ATTR_MAXLEN);
  iStringLen := 0;
  Check(Lib.SQLColAttributeString(FHandle, AColNum, AFieldId, SQLPointer(AAttr),
    C_STRING_ATTR_MAXLEN * SizeOf(Char), iStringLen, nil));
  ODBCSetLength(AAttr, iStringLen div SizeOf(Char));
end;

{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.GetNonStrAttribute(AAttr: SQLInteger; ApValue: SQLPointer);
var
  iStringLen: SQLInteger;
begin
  iStringLen := 0;
  Check(Lib.SQLGetStmtAttr(FHandle, AAttr, ApValue, 0, iStringLen));
end;

{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.GetStrAttribute(AAttr: SQLInteger; out AValue: String);
var
  iStringLen: SQLInteger;
begin
  SetLength(AValue, SQL_MAX_MESSAGE_LENGTH);
  iStringLen := 0;
  Check(Lib.SQLGetStmtAttr(FHandle, AAttr, PChar(AValue),
    SQL_MAX_MESSAGE_LENGTH * SizeOf(Char), iStringLen));
  ODBCSetLength(AValue, iStringLen div SizeOf(Char));
end;

{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.SetAttribute(AAttr: SQLInteger; ApValue: SQLPointer;
  AType: SQLInteger);
begin
  if ((AType = 0) or (AType = SQL_NTS)) and (ApValue <> nil) then
    AType := StrLen(PChar(ApValue)) * SizeOf(Char);
  Check(Lib.SQLSetStmtAttr(FHandle, AAttr, ApValue, AType));
end;

{-------------------------------------------------------------------------------}
function TODBCStatementBase.GetSQLLenDiag(ARecNo, ADiagID: Integer): SQLLen;
var
  iLen: SQLSmallint;
  iRet: SQLReturn;
begin
  iLen := 0;
  Result := 0;
  iRet := Lib.SQLGetDiagField(FHandleType, FHandle, SQLSmallint(ARecNo),
    SQLSmallint(ADiagID), @Result, SQL_IS_INTEGER, iLen);
  if (iRet <> SQL_SUCCESS) and (iRet <> SQL_NO_DATA) then
    Check(iRet);
end;

{-------------------------------------------------------------------------------}
function TODBCStatementBase.GetIntDiag(ARecNo, ADiagID: Integer): SQLInteger;
var
  iLen: SQLSmallint;
  iRet: SQLReturn;
begin
  iLen := 0;
  Result := 0;
  iRet := Lib.SQLGetDiagField(FHandleType, FHandle, SQLSmallint(ARecNo),
    SQLSmallint(ADiagID), @Result, SQL_IS_INTEGER, iLen);
  if (iRet <> SQL_SUCCESS) and (iRet <> SQL_NO_DATA) then
    Check(iRet);
end;

{-------------------------------------------------------------------------------}
function TODBCStatementBase.GetStrDiag(ARecNo, ADiagID: Integer): String;
var
  aBuff: array [0 .. SQL_MAX_MESSAGE_LENGTH] of Char;
  iLen: SQLSmallint;
  iRet: SQLReturn;
begin
  iLen := 0;
  Result := '';
  iRet := Lib.SQLGetDiagField(FHandleType, FHandle, SQLSmallint(ARecNo),
    SQLSmallint(ADiagID), @aBuff[0], SQL_MAX_MESSAGE_LENGTH, iLen);
  if (iRet <> SQL_SUCCESS) and (iRet <> SQL_NO_DATA) then
    Check(iRet)
  else
    SetString(Result, aBuff, iLen div SizeOf(Char));
end;

{-------------------------------------------------------------------------------}
function TODBCStatementBase.GetUSmallIntDiag(ARecNo, ADiagID: Integer): SQLUSmallint;
var
  iLen: SQLSmallint;
  iRet: SQLReturn;
begin
  iLen := 0;
  Result := 0;
  iRet := Lib.SQLGetDiagField(FHandleType, FHandle, SQLSmallint(ARecNo),
    SQLSmallint(ADiagID), @Result, SQL_IS_USMALLINT, iLen);
  if (iRet <> SQL_SUCCESS) and (iRet <> SQL_NO_DATA) then
    Check(iRet);
end;

{-------------------------------------------------------------------------------}
function TODBCStatementBase.GetCursorName: String;
var
  iBufferLen: SQLSmallint;
  iStringLen: SQLSmallint;
begin
  iBufferLen := Connection.GetInfoOptionSmInt(SQL_MAX_CURSOR_NAME_LEN);
  // FIPS Intermediate level conformant value
  if iBufferLen = 0 then
    iBufferLen := 128;
  SetLength(Result, iBufferLen);
  iStringLen := 0;
  if Lib.SQLGetCursorName(FHandle, PSQLChar(Result), iBufferLen, iStringLen) = SQL_SUCCESS then
    ODBCSetLength(Result, iStringLen)
  else
    Result := '';
end;

{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.SetCursorName(const AValue: String);
begin
  Check(Lib.SQLSetCursorName(FHandle, PSQLChar(AValue), SQLSmallint(Length(AValue))));
end;

{-------------------------------------------------------------------------------}
function TODBCStatementBase.GetQueryTimeout: SQLULen;
begin
  FQueryTimeout := GetSQLULenAttribute(SQL_ATTR_QUERY_TIMEOUT);
  Result := FQueryTimeout;
end;

{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.SetQueryTimeout(const AValue: SQLULen);
begin
  if FQueryTimeout <> AValue then begin
    FQueryTimeout := AValue;
    SetSQLULenAttribute(SQL_ATTR_QUERY_TIMEOUT, AValue);
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCStatementBase.NumResultCols: SQLSmallint;
begin
  if FResultCols = -1 then begin
    FResultCols := 0;
    Check(Lib.SQLNumResultCols(FHandle, FResultCols));
  end;
  Result := FResultCols;
end;

{-------------------------------------------------------------------------------}
function TODBCStatementBase.ResultColsExists: Boolean;
begin
  if FResultCols = -1 then begin
    FResultCols := 0;
    Result := Lib.SQLNumResultCols(FHandle, FResultCols) = SQL_SUCCESS;
  end
  else
    Result := True;
  Result := Result and (FResultCols > 0);
end;

{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.BindColumns(ARowCount: SQLULen);
begin
  FColumnList.Bind(ARowCount, False);
end;

{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.UnbindColumns;
begin
  if (FColumnList <> nil) and (FColumnList.Count > 0) then begin
    FColumnList.Clear;
    Check(Lib.SQLFreeStmt(FHandle, SQL_UNBIND));
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCStatementBase.AddCol(APos, ASQLType, ACType: SQLSmallint;
  ALen: SQLULen): TODBCColumn;
begin
  Result := TODBCColumn(ColumnList.Add(TODBCColumn.Create));
  if ALen <> MAXINT then
    Result.ColumnSize := ALen;
  Result.SQLDataType := ASQLType;
  Result.CDataType := ACType;
  Result.Position := APos;
end;

{-------------------------------------------------------------------------------}
function TODBCStatementBase.GetLongVarPiece(AVar: TODBCVariable;
  ApData: SQLPointer; ASize: SQLLen; ApInd: PSQLLen): SQLReturn;
var
  iDataType: SQLSmallint;
  oBuffer: TODBCPageBuffer;
  iPrevRows: SQLULen;
begin
  // The SQLGetData call to the Oracle ODBC driver modifies a value of
  // a variable pointed by the ROWS_FETCHED_PTR. But the Fetch method
  // expects the number of fetched rows. So, preserve the value.
  oBuffer := AVar.FList.FBuffer;
  iPrevRows := oBuffer.RowsProcessed;
  try
    if AVar.CDataType = SQL_C_NUMERIC then
      iDataType := AVar.DescriptorType
    else if AVar.MSSQLVariantBinary then
      if (AVar.FCVariantSbType = 0) or (ASize = 0) then
        iDataType := AVar.CDataType
      else if AVar.FCVariantSbType = SQL_C_NUMERIC then
        iDataType := SQL_C_CHAR
      else
        iDataType := AVar.FCVariantSbType
    else
      iDataType := AVar.CDataType;
    // MSSQL: SQL Server ODBC Driver 11 fails to fetch SQL_VARIANT when
    // TargetValue=nil or BufferLength=0, and returns HY008 (Win) / HY009 (UIX).
    Result := Lib.SQLGetData(FHandle, AVar.Position, iDataType, ApData, ASize, ApInd);
    if (Result <> SQL_NO_DATA) and
       (Result <> SQL_SUCCESS_WITH_INFO) and
       (Result <> SQL_SUCCESS) then
      Check(Result);
  finally
    oBuffer.FRowsProcessed := iPrevRows;
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCStatementBase.GetLongVarPiece(AVar: TODBCVariable;
  AIndex: Integer; ASize: SQLLen): SQLReturn;
var
  pData: SQLPointer;
  pInd: PSQLLen;
begin
  AVar.GetDataInd(AIndex, pData, pInd);
  Result := GetLongVarPiece(AVar, pData, ASize, pInd);
end;

{-------------------------------------------------------------------------------}
function TODBCStatementBase.GetLongVarFinished(ASize: SQLLen; ARet: SQLReturn;
  AInd: SQLLen): Boolean;
begin
  Result :=
    (ARet = SQL_NO_DATA) or
    (AInd = SQL_NULL_DATA) or
    ((AInd <= ASize) and (AInd >= 0) and (ARet <> SQL_SUCCESS_WITH_INFO));
end;

{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.GetLongVar(AVar: TODBCVariable; AIndex: Integer);
var
  lGetAll: Boolean;
  pBuffer: SQLPointer;
  ppBuffer: PSQLPointer;
  pInd: PSQLLen;
  iCurSize, iFetchSize, iBufferLen, iZeroBytes, iVarType: SQLLen;
  iIteration: SQLInteger;
  iDummy: Word;
  iRet: SQLReturn;
begin
  // MS SQL Server VARIANT data type fetching
  if AVar.MSSQLVariantBinary then begin
    ppBuffer := AVar.GetDataPtr(AIndex, pBuffer, iCurSize, pInd);
    ppBuffer^ := @iDummy;
    GetLongVarPiece(AVar, AIndex, 0);
    ppBuffer^ := pBuffer;
    if pInd^ <> SQL_NULL_DATA then begin
      iVarType := 0;
      ColAttributeIntSilent(AVar.Position, SQL_CA_SS_VARIANT_TYPE, iVarType);
      AVar.FCVariantSbType := iVarType;
      if iVarType = SQL_NUMERIC then
        Inc(pInd^, 2);
      if iCurSize < pInd^ then
        AVar.AllocLongData(AIndex, pInd^);
      GetLongVarPiece(AVar, AIndex, pInd^);
    end;
  end

  // BLOB data
  else if AVar.LongData then begin
    case AVar.CDataType of
    SQL_C_CHAR:   iZeroBytes := SizeOf(TFDAnsiChar);
    SQL_C_WCHAR:  iZeroBytes := SizeOf(WideChar);
    else          iZeroBytes := 0;
    end;

    AVar.GetDataPtr(AIndex, pBuffer, iCurSize, pInd);
    iIteration := 0;
    iCurSize := 0;
    iFetchSize := FPieceBuffLen;
    iBufferLen := iFetchSize;
    ppBuffer := AVar.AllocLongData(AIndex, iBufferLen);
    pBuffer := ppBuffer^;

    try
      try
        repeat

          Inc(iIteration);
          iRet := GetLongVarPiece(AVar, AIndex, iFetchSize);
          lGetAll := GetLongVarFinished(iFetchSize, iRet, pInd^);

          if not lGetAll then begin
            Inc(iCurSize, iFetchSize - iZeroBytes);
            iFetchSize := iBufferLen;
            if iBufferLen <= $3FFFFFFF then
              iBufferLen := iBufferLen * 2
            else
              Inc(iBufferLen, $6400000); // 100Mb
            ppBuffer^ := pBuffer;
            ppBuffer := AVar.AllocLongData(AIndex, iBufferLen);
            pBuffer := ppBuffer^;
            ppBuffer^ := SQLPointer(NativeInt(ppBuffer^) +
              (iBufferLen - iFetchSize - iZeroBytes * iIteration));
          end;
        until lGetAll;

      finally
        ppBuffer^ := pBuffer;
      end;

      if pInd^ = SQL_NULL_DATA then
        AVar.FreeLongData(AIndex)
      else begin
        Inc(pInd^, iCurSize);
        AVar.AllocLongData(AIndex, pInd^);
      end;

    except
      on E: EODBCNativeException do begin
        AVar.FreeLongData(AIndex);
        raise;
      end;
    end;
  end

  // other late binding data
  else
    GetLongVarPiece(AVar, AIndex, AVar.DataSize);
end;

{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.FetchLateBindedColumns(AIndex: SQLULen);
var
  i: Integer;
  oVar: TODBCVariable;
  oBuffer: TODBCPageBuffer;
begin
  oBuffer := FColumnList.FBuffer;
  for i := 0 to FColumnList.Count - 1 do begin
    oVar := FColumnList[i];
    if oVar.LateBinding then begin

      // set result set position
      if oBuffer.RowsProcessed > 1 then
        Check(Lib.SQLSetPos(FHandle, AIndex + 1, SQL_POSITION, SQL_LOCK_NO_CHANGE));

      GetLongVar(oVar, AIndex);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCStatementBase.Fetch(ARowCount: SQLLen = SQL_NULL_DATA): SQLULen;
var
  iRet: SQLReturn;
  iLastFetched: SQLLen;
  iRow: SQLUInteger;
  oBuffer: TODBCPageBuffer;
begin
  ASSERT(ARowCount <= $FFFF);
  TODBCConnection(Owner).ClearInfo;
  if (ColumnList.FBuffer = nil) and (ColumnList.Count > 0) then
    BindColumns(ARowCount);
  oBuffer := FColumnList.FBuffer;
  ASSERT((oBuffer <> nil) and (oBuffer.Shifted = 0));

  Result := 0;
  iLastFetched := 0;
  iRow := 0;
  try

    repeat
      if iLastFetched > 0 then
        oBuffer.ShiftBuffersPtr(iLastFetched);

      iRet := Lib.SQLFetch(FHandle);
      if iRet = SQL_NO_DATA then
        iLastFetched := 0
      else begin
        Check(iRet);
        // RowsProcessed = 0 - this is a MySQL driver bug
        // RowsProcessed = 1 - 1 row fetched only - immediatelly GetLongVarPiece,
        // if RDBMS table contains only 1 row - we will exit from the cycle in the next
        // iteration after iRet = SQL_NO_DATA
        if (oBuffer.RowsProcessed in [0, 1]) or (oBuffer.RowCount = 1) then begin
          iLastFetched := 1;
          if FColumnList.HasLateBindedVars then
            FetchLateBindedColumns(iRow);
        end
        else
          iLastFetched := oBuffer.RowsProcessed;
      end;
      Inc(Result, iLastFetched);
      Inc(iRow);
    until (ARowCount = SQL_NULL_DATA) or (Result = ARowCount) or (iLastFetched = 0) or
          (oBuffer.RowsProcessed > 1) or (oBuffer.RowCount = Result);

  finally
    oBuffer.UnShift;
  end;

  if oBuffer.RowsProcessed in [0, 1] then begin
    if Result > 0 then
      oBuffer.FRowsProcessed := Result;
  end
  else if (Result > 0) and FColumnList.HasLateBindedVars then
    for iRow := 0 to SQLUSmallint(Result - 1) do
      FetchLateBindedColumns(iRow);
{$IFDEF FireDAC_MONITOR}
  if Tracing then
    DumpColumns(Result, ARowCount <> Result);
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TODBCStatementBase.MoreResults: Boolean;
var
  iRes: SQLReturn;
begin
  Result := False;
  if FNoMoreResults then
    Exit;
  iRes := Lib.SQLMoreResults(FHandle);
  case iRes of
  SQL_SUCCESS:
    begin
      Result := True;
      FResultCols := -1;
    end;
  SQL_SUCCESS_WITH_INFO:
    begin
      Result := True;
      FResultCols := -1;
      Check(iRes);
    end;
  SQL_NO_DATA,
  // ASA: SQLMoreResults cannot return SQL_NEED_DATA, but ASA driver
  // returns. It seems, it is a bug in the ODBC driver.
  SQL_NEED_DATA:
    begin
      FNoMoreResults := True;
      FResultCols := 0;
    end;
  else
    FNoMoreResults := True;
    FResultCols := 0;
    Check(iRes);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.Cancel;
begin
  Check(Lib.SQLCancel(FHandle));
end;

{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.Close;
begin
  if FExecuted then begin
    FExecuted := False;
    FNoMoreResults := True;
    FResultCols := -1;
    Check(Lib.SQLFreeStmt(FHandle, SQL_CLOSE));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.Unprepare;
begin
  TODBCConnection(Owner).ClearInfo;
  try
    Close;
  finally
    UnbindColumns;
  end;
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
procedure TODBCStatementBase.DumpColumns(ARows: SQLULen; AEof: Boolean);
var
  i, n: Integer;
  j: SQLUInteger;
  iLen: SQLLen;
  sVal: String;
  oVar: TODBCVariable;
begin
  if Tracing and (ARows > 0) then begin
    for j := 0 to ARows - 1 do begin
      n := 1;
      Trace(ekCmdDataOut, esStart, 'Fetched', ['Row', j]);
      for i := 0 to FColumnList.Count - 1 do begin
        oVar := FColumnList.Items[i];
        iLen := 0;
        sVal := oVar.DumpValue(j, iLen);
        Trace(ekCmdDataOut, esProgress, 'Column',
          [String('N'), n, '@Type', oVar.DumpCDataType,
           'Size', oVar.ColumnSize, 'Len', iLen, '@Data', sVal]);
        Inc(n);
      end;
      Trace(ekCmdDataOut, esEnd, 'Fetched', ['Row', j]);
    end;
    if AEof then
      Trace(ekCmdDataOut, esProgress, 'EOF', []);
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TODBCCommandStatement                                                         }
{-------------------------------------------------------------------------------}
constructor TODBCCommandStatement.Create(AOwner: TODBCConnection; AOwningObj: TObject);
begin
  inherited Create(AOwner, AOwningObj);
  FParamList := TODBCVariableList.Create(Self, True, False);
end;

{-------------------------------------------------------------------------------}
destructor TODBCCommandStatement.Destroy;
begin
  inherited Destroy;
  FDFreeAndNil(FParamList);
end;

{-------------------------------------------------------------------------------}
function TODBCCommandStatement.GetPARAMSET_SIZE: SQLULen;
var
  iLen: SQLInteger;
begin
  iLen := 0;
  if Lib.SQLGetStmtAttr(FHandle, SQL_ATTR_PARAMSET_SIZE, @Result, 0, iLen) <> SQL_SUCCESS then
    Result := 1;
end;

{-------------------------------------------------------------------------------}
procedure TODBCCommandStatement.SetPARAMSET_SIZE(const AValue: SQLULen);
begin
  Lib.SQLSetStmtAttr(FHandle, SQL_ATTR_PARAMSET_SIZE, PSQLUInteger(AValue), 0);
end;

{-------------------------------------------------------------------------------}
procedure TODBCCommandStatement.BindParameters(ARowCount: SQLUInteger; AFixedLenOnly: Boolean);
begin
  ParamList.Bind(ARowCount, AFixedLenOnly);
end;

{-------------------------------------------------------------------------------}
procedure TODBCCommandStatement.UnbindParameters;
begin
  if (ParamList <> nil) and (ParamList.Count > 0) then begin
    ParamList.Clear;
    Check(Lib.SQLFreeStmt(Handle, SQL_RESET_PARAMS));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCCommandStatement.PutBlobParam(AParam: TODBCParameter; AIndex: Integer);
var
  pInd: PSQLLen;
  pData: SQLPointer;
  iSize: SQLLen;
begin
  AParam.GetDataPtr(AIndex, pData, iSize, pInd);
  if pInd^ = SQL_NULL_DATA then
    iSize := SQL_NULL_DATA;
  // SQLPutData(..., nil, 0) raises "invalid string or buffer length".
  // So, set pData to a not nil value.
  if (pData = nil) and ((iSize = 0) or (iSize = SQL_NULL_DATA)) then
    pData := @pData;
  Check(Lib.SQLPutData(FHandle, pData, iSize));
end;

{-------------------------------------------------------------------------------}
procedure TODBCCommandStatement.PutTableParam(AParam: TODBCParameter; AIndex: Integer; AFirst: Boolean);
var
  oReader: IFDPhysDataSetParamReader;
  i: Integer;
  pBuff: Pointer;
  iLen: LongWord;
begin
  oReader := AParam.DataReader as IFDPhysDataSetParamReader;
  if (oReader = nil) or
     AFirst and not oReader.Reset or
     not AFirst and not oReader.Next then
    Check(Lib.SQLPutData(FHandle, nil, 0))
  else begin
    for i := 0 to AParam.ColumnList.Count - 1 do begin
      pBuff := nil;
      iLen := 0;
      oReader.GetData(i, pBuff, 0, iLen, False);
      AParam.ColumnList[i].SetData(0, pBuff, iLen);
    end;
    Check(Lib.SQLPutData(FHandle, SQLPointer(1), 1));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TODBCCommandStatement.PutStreamParam(AParam: TODBCParameter; AIndex: Integer);
var
  oReader: IParamStreamObject;
  oStr: TStream;
  oBuff: TFDBuffer;
  iLen: SQLLen;
  lNull: Boolean;
begin
  lNull := True;
  oReader := AParam.DataReader as IParamStreamObject;
  if oReader <> nil then begin
    oStr := oReader.GetStream(False);
    if oStr <> nil then begin
      lNull := False;
      oStr.Position := 0;
      oBuff := Connection.Encoder.Buffer;
      oBuff.Check(C_FD_DefPieceBuffLen);
      repeat
        iLen := oStr.Read(oBuff.Ptr^, oBuff.Size);
        Check(Lib.SQLPutData(FHandle, oBuff.Ptr, iLen));
      until iLen <> SQLLen(oBuff.Size);
    end;
  end;
  if lNull then
    Check(Lib.SQLPutData(FHandle, nil, 0));
end;

{-------------------------------------------------------------------------------}
function TODBCCommandStatement.PutLongParams: SQLReturn;
var
  pParamNum: SQLPointer;
  oPar: TODBCParameter;
  iCurNum: SQLSmallint;
  lFirst: Boolean;
  iIndex: Integer;
begin
  iCurNum := -1;
  oPar := nil;
  lFirst := True;
  FFocusedParam := nil;
  iIndex := 0;
  repeat
    pParamNum := nil;
    Result := Lib.SQLParamData(FHandle, pParamNum);
    // Teradata: SQLParamData after last BLOB parameter returns "invalid cursor state"
    if (TODBCConnection(Owner).DriverKind = dkTeradata) and
       (Result = SQL_ERROR) and (DIAG_SQLSTATE[1] = '24000') then
      Result := SQL_SUCCESS
    else if Result = SQL_NEED_DATA then begin
      // MSSQL: subsequent SQLParamData calls for TVP return pParamNum=nil
      if pParamNum <> nil then
        oPar := ParamList.FindByToken(pParamNum) as TODBCParameter;
      ASSERT(oPar <> nil);
      if (oPar.SQLDataType <> SQL_SS_TABLE) and not oPar.FList.ChildList then begin
        if iCurNum >= oPar.Position then
          Inc(iIndex);
        iCurNum := oPar.Position;
      end;
      if oPar.SQLDataType = SQL_SS_TABLE then
        PutTableParam(oPar, iIndex, lFirst)
      else if oPar.Streamed then begin
        FFocusedParam := oPar;
        FFocusedResult := Result;
      end
      else if oPar.DataReader <> nil then
        PutStreamParam(oPar, iIndex)
      else
        PutBlobParam(oPar, iIndex);
    end;
    lFirst := False;
  until (Result <> SQL_NEED_DATA) or (FocusedParam <> nil);
end;

{-------------------------------------------------------------------------------}
procedure TODBCCommandStatement.GetStreamParam(AParam: TODBCParameter; AIndex: Integer);
var
  oReader: IParamStreamObject;
  oStr: TStream;
  oBuff: TFDBuffer;
  pBuffer: SQLPointer;
  ppBuffer: PSQLPointer;
  pInd: PSQLLen;
  iSize, iZeroBytes: SQLLen;
  iRet: SQLReturn;
  lGetAll: Boolean;
begin
  oReader := AParam.DataReader as IParamStreamObject;
  if oReader <> nil then begin
    oStr := oReader.GetStream(False);
    if oStr <> nil then begin
      case AParam.CDataType of
      SQL_C_CHAR:   iZeroBytes := SizeOf(TFDAnsiChar);
      SQL_C_WCHAR:  iZeroBytes := SizeOf(WideChar);
      else          iZeroBytes := 0;
      end;

      oStr.Position := 0;
      oBuff := Connection.Encoder.Buffer;
      oBuff.Check(C_FD_DefPieceBuffLen);
      ppBuffer := AParam.GetDataPtr(AIndex, pBuffer, iSize, pInd);
      ppBuffer^ := oBuff.Ptr;

      try
        repeat

          iRet := GetLongVarPiece(AParam, AIndex, oBuff.Size);
          lGetAll :=
            (iRet = SQL_NO_DATA) or
            (pInd^ = SQL_NULL_DATA) or
            ((pInd^ <= SQLLen(oBuff.Size)) and (pInd^ >= 0) and (iRet <> SQL_SUCCESS_WITH_INFO));
          if not lGetAll then
            oStr.Write(oBuff.Ptr^, SQLLen(oBuff.Size) - iZeroBytes);
        until lGetAll;

      finally
        ppBuffer^ := pBuffer;
      end;

      if pInd^ <> SQL_NULL_DATA then
        oStr.Write(oBuff.Ptr^, pInd^);
      oStr.Size := oStr.Position;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCCommandStatement.GetLongParams: SQLReturn;
var
  pParamNum: SQLPointer;
  oPar: TODBCParameter;
  iCurNum: SQLSmallint;
  iIndex: Integer;
begin
  iCurNum := -1;
  oPar := nil;
  FFocusedParam := nil;
  iIndex := 0;
  repeat
    pParamNum := nil;
    Result := Lib.SQLParamData(FHandle, pParamNum);
    if Result = SQL_PARAM_DATA_AVAILABLE then begin
      if pParamNum <> nil then
        oPar := ParamList.FindByToken(pParamNum) as TODBCParameter;
      ASSERT(oPar <> nil);
      if (oPar.SQLDataType <> SQL_SS_TABLE) and not oPar.FList.ChildList then begin
        if iCurNum >= oPar.Position then
          Inc(iIndex);
        iCurNum := oPar.Position;
      end;
      if oPar.SQLDataType = SQL_SS_TABLE then
        ASSERT(oPar.SQLDataType <> SQL_SS_TABLE)
      else if oPar.Streamed then begin
        FFocusedParam := oPar;
        FFocusedResult := Result;
      end
      else if oPar.DataReader <> nil then
        GetStreamParam(oPar, iIndex)
      else
        GetLongVar(oPar, iIndex);
    end;
  until (Result <> SQL_PARAM_DATA_AVAILABLE) or (FocusedParam <> nil);
end;

{-------------------------------------------------------------------------------}
procedure TODBCCommandStatement.FlushLongData;
var
  iRet: SQLReturn;
begin
  iRet := SQL_NEED_DATA;
  repeat
    if iRet = SQL_NEED_DATA then
      iRet := PutLongParams();
    if iRet = SQL_PARAM_DATA_AVAILABLE then
      iRet := GetLongParams();
  until not ((iRet = SQL_PARAM_DATA_AVAILABLE) or (iRet = SQL_NEED_DATA));
  if iRet <> SQL_NO_DATA then
    Check(iRet);
end;

{-------------------------------------------------------------------------------}
procedure TODBCCommandStatement.UpdateRowsAffected(var ACount: SQLLen);
begin
  ACount := -1;
  // MSSQL: if SET NOCOUNT ON, then there is no count
  if not (TODBCConnection(Owner).DriverKind in [dkSQLSrv, dkSQLNC, dkSQLOdbc]) or
     (SS_NOCOUNT_STATUS <> SQL_NC_ON) then
    Lib.SQLRowCount(FHandle, ACount);
end;

{-------------------------------------------------------------------------------}
procedure TODBCCommandStatement.Execute(ARowCount, AOffset: SQLUInteger;
  var ACount: SQLLen; AExact: Boolean; const AExecDirectCommand: String);
var
  i: Integer;
  iTimes: SQLUInteger;
  iRet: SQLReturn;
  oBuffer: TODBCPageBuffer;
  lCheck: Boolean;

  procedure AdjustRowsAffected(var ACount: SQLLen);
  var
    i: Integer;
    iRet2: SQLReturn;
    iRes: SQLLen;
  begin
    // if RowCount > 1, then we have array execution. In this case
    // ACount must be the count of succesfully executed array items.
    if (ARowCount > 1) and (oBuffer <> nil) then begin
      iRes := 0;

      // MSSQL: When single record to be processed, FRowStatusArr is not filled
      if (TODBCConnection(Owner).DriverKind in [dkSQLSrv, dkSQLNC, dkSQLOdbc]) and
         (iTimes = 1) then begin
        if (oBuffer.RowsProcessed = 1) and (
             (iRet = SQL_SUCCESS_WITH_INFO) and (DIAG_SS_SEVERITY[1] < 11) or
             (iRet = SQL_SUCCESS)
           ) then
          iRes := 1
      end

      // otherwise count error in row status array
      else if oBuffer.RowsProcessed <> 0 then begin
        for i := 0 to ARowCount - oBuffer.Shifted - 1 do
          case oBuffer.FRowStatusArr[i] of
          SQL_PARAM_SUCCESS,
          SQL_INFX_PARAM_SUCCESS:
            Inc(iRes);
          SQL_PARAM_SUCCESS_WITH_INFO:
            // DB2: returns SQL_PARAM_SUCCESS_WITH_INFO for failed items
            if not (TODBCConnection(Owner).DriverKind in [dkDB2, dkDB2_400]) then
              Inc(iRes);
          end;
      end;
    end

    // MSSQL: if SET NOCOUNT ON, then there is no count
    else if not ((iRet = SQL_PARAM_DATA_AVAILABLE) or (iRet = SQL_NEED_DATA)) and
            (TODBCConnection(Owner).DriverKind in [dkSQLSrv, dkSQLNC, dkSQLOdbc]) and
            (SS_NOCOUNT_STATUS = SQL_NC_ON) then
      iRes := -1

    // Teradata: if execution failed, then no rows changed and
    // SQLRowCount returns "Function sequence error".
    else if ((iRet = SQL_ERROR) or (iRet = SQL_NO_DATA)) and
            (TODBCConnection(Owner).DriverKind = dkTeradata) then
      iRes := 0

    else begin
      iRes := -1;
      iRet2 := Lib.SQLRowCount(FHandle, iRes);
      // MSAccess: SQLExecute may be successful, but SQLRowCount returns
      // "Function sequence error". Then, most probable, there was SQLCancel call.
      if TODBCConnection(Owner).DriverKind in [dkMSAccessJet, dkMSAccessACE] then
        if (iRet2 = SQL_ERROR) and
           (iRet in [SQL_NEED_DATA, SQL_SUCCESS_WITH_INFO, SQL_SUCCESS]) and
           (DIAG_SQLSTATE[1] = 'HY010') then
          try
            Check(iRet2);
          except
            on E: EODBCNativeException do begin
              E.Errors[0].Kind := ekCmdAborted;
              raise;
            end;
          end;
    end;

    if iRes = -1 then
      ACount := -1
    else if ACount >= 0 then
      Inc(ACount, iRes);
  end;

  procedure AdjustRowIndex(E: EODBCNativeException);
  var
    i, j: Integer;
  begin
    if (oBuffer <> nil) and (E.ErrorCount > 0) and (E[0].RowIndex = -1) then
      if iTimes > 1 then begin
        j := 0;
        for i := 0 to ARowCount - oBuffer.Shifted - 1 do
          case oBuffer.FRowStatusArr[i] of
          SQL_PARAM_ERROR,
          SQL_PARAM_SUCCESS_WITH_INFO:
            begin
              E[j].RowIndex := oBuffer.Shifted + i;
              Inc(j);
              if j = E.ErrorCount then
                Break;
            end;
          SQL_PARAM_UNUSED,
          SQL_PARAM_DIAG_UNAVAILABLE:
            Break;
          end;
      end
      else
        for i := 0 to E.ErrorCount - 1 do
          if E[i].RowIndex = -1 then
            E[i].RowIndex := oBuffer.Shifted;
  end;

begin
  TODBCConnection(Owner).ClearInfo;

  FExecuted := True;
  FResultCols := -1;
  FNoMoreResults := True;
  ACount := 0;
  iTimes := ARowCount - AOffset;

  if ParamList.Count > 0 then begin
    BindParameters(ARowCount, True);
    oBuffer := ParamList.FBuffer;
    if AOffset > 0 then begin
      oBuffer.ShiftBuffersPtr(AOffset);
      PARAMSET_SIZE := iTimes;
    end;
    if TODBCConnection(Owner).DriverKind = dkFreeTDS then
      for i := 0 to ARowCount - oBuffer.Shifted - 1 do
        oBuffer.FRowStatusArr[i] := SQL_PARAM_DIAG_UNAVAILABLE;
{$IFDEF FireDAC_MONITOR}
    if Tracing then
      DumpParameters(True, AOffset, iTimes);
{$ENDIF}
  end
  else
    oBuffer := nil;

  try
    if AExecDirectCommand = '' then
      iRet := Lib.SQLExecute(FHandle)
    else
      iRet := Lib.SQLExecDirect(FHandle, PSQLChar(AExecDirectCommand), SQL_NTS);

    try
      try
        if iRet = SQL_NEED_DATA then
          iRet := PutLongParams();
        if iRet = SQL_PARAM_DATA_AVAILABLE then
          iRet := GetLongParams();
        case iRet of
        SQL_NEED_DATA:
          lCheck := (FocusedParam = nil);
        SQL_NO_DATA:
          lCheck := AExact or (iTimes > 1);
        SQL_PARAM_DATA_AVAILABLE:
          lCheck := (FocusedParam = nil) and (AExact or (iTimes > 1));
        else
          lCheck := True;
        end;
        if lCheck then
          Check(iRet);
      except
        on E: EODBCNativeException do begin
          AdjustRowIndex(E);
          raise;
        end;
      end;
    finally
      AdjustRowsAffected(ACount);
    end;

{$IFDEF FireDAC_MONITOR}
    if ParamList.Count > 0 then
      if Tracing then
        DumpParameters(False, AOffset, iTimes);
{$ENDIF}

  finally
    if (oBuffer <> nil) and (AOffset > 0) then begin
      oBuffer.UnShift;
      PARAMSET_SIZE := ARowCount;
    end;
    ParamList.ResetDataReaders;
  end;

  FNoMoreResults := False;
end;

{-------------------------------------------------------------------------------}
procedure TODBCCommandStatement.Open(ARowCount: SQLUInteger; const AExecDirectCommand: String);
var
  iCnt: SQLLen;
begin
  iCnt := 0;
  Execute(ARowCount, 0, iCnt, False, AExecDirectCommand);
end;

{-------------------------------------------------------------------------------}
function TODBCCommandStatement.NumParams: SQLSmallint;
begin
  Result := 0;
  Check(Lib.SQLNumParams(FHandle, Result));
end;

{-------------------------------------------------------------------------------}
procedure TODBCCommandStatement.Prepare(const ACommandText: String);
begin
  TODBCConnection(Owner).ClearInfo;
  TODBCConnection(Owner).FLastCommandText := ACommandText;
  Check(Lib.SQLPrepare(FHandle, PSQLChar(ACommandText), SQL_NTS));
end;

{-------------------------------------------------------------------------------}
procedure TODBCCommandStatement.Unprepare;
begin
  inherited Unprepare;
  UnbindParameters;
  TODBCConnection(Owner).FLastCommandText := '';
  FExecuted := False;
  FNoMoreResults := True;
  FResultCols := -1;
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
procedure TODBCCommandStatement.DumpParameters(AInput: Boolean; AOffset, ATimes: Integer);
var
  i, j, n: Integer;
  sVal: String;
  iLen: SQLLen;
  oVar: TODBCVariable;
begin
  if Tracing then begin
    n := 1;
    for i := 0 to ParamList.Count - 1 do begin
      oVar := ParamList.Items[i];
      case oVar.ParamType of
      SQL_PARAM_TYPE_UNKNOWN,
      SQL_RESULT_COL:
        Continue;
      SQL_PARAM_INPUT:
        if not AInput then
          Continue;
      SQL_PARAM_INPUT_OUTPUT,
      SQL_PARAM_INPUT_OUTPUT_STREAM:
        ;
      SQL_PARAM_OUTPUT,
      SQL_PARAM_OUTPUT_STREAM,
      SQL_RETURN_VALUE:
        if AInput then
          Continue;
      end;
      iLen := 0;
      sVal := oVar.DumpValue(0, iLen);
      Trace(ekCmdDataIn, esProgress, 'Param',
        [String('N'), n, 'Name', oVar.DumpLabel, '@Mode', oVar.DumpParamType,
         '@Type', oVar.DumpCDataType, 'Size', oVar.ColumnSize, 'Len', iLen,
         '@Data(' + IntToStr(AOffset) + ')', sVal]);
      for j := 1 to ATimes - 1 do begin
        sVal := oVar.DumpValue(j, iLen);
        Trace(ekCmdDataIn, esProgress, '  ... Data', ['I', AOffset + j, 'L', iLen, '@V', sVal]);
      end;
      Inc(n);
    end;
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TODBCLongDataStream
{-------------------------------------------------------------------------------}
constructor TODBCLongDataStream.Create(AParam: TODBCParameter; AMode: TFDStreamMode);
begin
  inherited Create;
  FParam := AParam;
  FMode := AMode;
  FState := -1;
  FSize := -1;
end;

{-------------------------------------------------------------------------------}
function TODBCLongDataStream.GetStmt: TODBCCommandStatement;
begin
  Result := Param.Statement as TODBCCommandStatement;
end;

{-------------------------------------------------------------------------------}
procedure TODBCLongDataStream.CheckMode(AMode: TFDStreamMode; const AMsg: String);
var
  oStmt: TODBCCommandStatement;
  pParamNum: SQLPointer;
  iRet: SQLReturn;
  oPar: TODBCParameter;

  procedure Error;
  begin
    FDException(oStmt.OwningObj, [S_FD_LPhys, S_FD_ODBCId],
      er_FD_OdbcLongDataStream, [AMsg, Param.GetDumpLabel]);
  end;

begin
  if FMode <> AMode then
    Error;
  if FState = -1 then begin
    FState := 0;
    oStmt := Stmt;
    if oStmt.FocusedParam = Param then begin
      iRet := oStmt.FocusedResult;
      oPar := oStmt.FocusedParam;
    end
    else begin
      pParamNum := nil;
      oPar := nil;
      oStmt.FFocusedParam := nil;
      iRet := oStmt.Lib.SQLParamData(oStmt.FHandle, pParamNum);
      if ((iRet = SQL_NEED_DATA) or (iRet = SQL_PARAM_DATA_AVAILABLE)) and (pParamNum <> nil) then
        oPar := oStmt.ParamList.FindByToken(pParamNum) as TODBCParameter;
    end;
    if (oPar <> Param) or
       (iRet = SQL_NEED_DATA) and (FMode <> smOpenWrite) or
       (iRet = SQL_PARAM_DATA_AVAILABLE) and (FMode <> smOpenRead) then
      Error;
  end;
end;

{-------------------------------------------------------------------------------}
function TODBCLongDataStream.Read(var Buffer; Count: Longint): Longint;
var
  iInd: SQLLen;
  iRet: SQLReturn;
  oStmt: TODBCCommandStatement;
begin
  CheckMode(smOpenRead, 'read from');
  if FState = 1 then begin
    Result := 0;
    Exit;
  end;
  oStmt := Stmt;
  iRet := oStmt.GetLongVarPiece(Param, SQLPointer(@Buffer), SQLLen(Count), @iInd);
  if oStmt.GetLongVarFinished(SQLLen(Count), iRet, iInd) then
    FState := 1;
  if FSize = -1 then
    if iInd = SQL_NO_TOTAL then
      FSize := -2
    else if iInd = SQL_NULL_DATA then
      FSize := 0
    else
      FSize := iInd;
  if (iRet = SQL_NO_DATA) or (iInd = SQL_NULL_DATA) then
    Result := 0
  else if iRet = SQL_SUCCESS then
    Result := iInd
  else // SQL_SUCCESS_WITH_INFO
    Result := Count;
  Inc(FPosition, Result);
end;

{-------------------------------------------------------------------------------}
function TODBCLongDataStream.Write(const Buffer; Count: Longint): Longint;
var
  oStmt: TODBCCommandStatement;
begin
  CheckMode(smOpenWrite, 'write to');
  oStmt := Stmt;
  oStmt.Check(oStmt.Lib.SQLPutData(oStmt.FHandle, SQLPointer(@Buffer), SQLLen(Count)));
  Inc(FPosition, Count);
  Result := Count;
end;

{-------------------------------------------------------------------------------}
function TODBCLongDataStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
var
  lError: Boolean;
begin
  case Origin of
  soBeginning: lError := Offset <> FPosition;
  soCurrent:   lError := Offset <> 0;
  soEnd:       lError := True;
  else         lError := False;
  end;
  if lError then
    CheckMode(smOpenReadWrite, 'seek');
  Result := FPosition;
end;

{-------------------------------------------------------------------------------}
function TODBCLongDataStream.GetSize: Int64;
begin
  Result := -1;
  case FMode of
  smOpenRead:
    if FSize >= 0 then
      Result := FSize;
  smOpenWrite:
    Result := FPosition;
  end;
end;

{-------------------------------------------------------------------------------}
{ TODBCMetaInfoStatement                                                        }
{-------------------------------------------------------------------------------}
procedure TODBCMetaInfoStatement.Columns(const ACatalog, ASchema, ATable, AColumn: String);
begin
  FMode := 0;
  FExecuted := False;
  FNoMoreResults := False;
  FResultCols := -1;
  FCatalog := ACatalog;
  FSchema := ASchema;
  FObject := ATable;
  FColumn := AColumn;
end;

{-------------------------------------------------------------------------------}
procedure TODBCMetaInfoStatement.TypeColumns(const ACatalog, ASchema, ATable, AColumn: String);
begin
  FMode := 10;
  FExecuted := False;
  FNoMoreResults := False;
  FResultCols := -1;
  FCatalog := ACatalog;
  FSchema := ASchema;
  FObject := ATable;
  FColumn := AColumn;
end;

{-------------------------------------------------------------------------------}
procedure TODBCMetaInfoStatement.ForeignKeys(const APKCatalog, APKSchema, APKTable,
  AFKCatalog, AFKSchema, AFKTable: String);
begin
  FMode := 1;
  FExecuted := False;
  FNoMoreResults := False;
  FResultCols := -1;
  FCatalog := APKCatalog;
  FSchema := APKSchema;
  FObject := APKTable;
  FFKCatalog := AFKCatalog;
  FFKSchema := AFKSchema;
  FFKTable := AFKTable;
end;

{-------------------------------------------------------------------------------}
procedure TODBCMetaInfoStatement.PrimaryKeys(const ACatalog, ASchema, ATable: String);
begin
  FMode := 2;
  FExecuted := False;
  FNoMoreResults := False;
  FResultCols := -1;
  FCatalog := ACatalog;
  FSchema := ASchema;
  FObject := ATable;
end;

{-------------------------------------------------------------------------------}
procedure TODBCMetaInfoStatement.Procedures(const ACatalog, ASchema, AProc: String);
begin
  FMode := 3;
  FExecuted := False;
  FNoMoreResults := False;
  FResultCols := -1;
  FCatalog := ACatalog;
  FSchema := ASchema;
  FObject := AProc;
end;

{-------------------------------------------------------------------------------}
procedure TODBCMetaInfoStatement.ProcedureColumns(const ACatalog, ASchema,
  AProc, AColumn: String);
begin
  FMode := 4;
  FExecuted := False;
  FNoMoreResults := False;
  FResultCols := -1;
  FCatalog := ACatalog;
  FSchema := ASchema;
  FObject := AProc;
  FColumn := AColumn;
end;

{-------------------------------------------------------------------------------}
procedure TODBCMetaInfoStatement.SpecialColumns(const ACatalog, ASchema,
  ATable: String; AIdentifierType: SQLUSmallint);
begin
  FMode := 5;
  FExecuted := False;
  FNoMoreResults := False;
  FResultCols := -1;
  FCatalog := ACatalog;
  FSchema := ASchema;
  FObject := ATable;
  FIdentifierType := AIdentifierType;
end;

{-------------------------------------------------------------------------------}
procedure TODBCMetaInfoStatement.Statistics(const ACatalog, ASchema, ATable: String;
  AUnique: SQLUSmallint);
begin
  FMode := 6;
  FExecuted := False;
  FNoMoreResults := False;
  FResultCols := -1;
  FCatalog := ACatalog;
  FSchema := ASchema;
  FObject := ATable;
  FUnique := AUnique;
end;

{-------------------------------------------------------------------------------}
procedure TODBCMetaInfoStatement.Tables(const ACatalog, ASchema, ATable,
  ATableTypes: String);
begin
  FMode := 7;
  FExecuted := False;
  FNoMoreResults := False;
  FResultCols := -1;
  FCatalog := ACatalog;
  FSchema := ASchema;
  FObject := ATable;
  FTableTypes := ATableTypes;
end;

{-------------------------------------------------------------------------------}
procedure TODBCMetaInfoStatement.Catalogs;
begin
  FMode := 8;
  FExecuted := False;
  FNoMoreResults := False;
  FResultCols := -1;
end;

{-------------------------------------------------------------------------------}
procedure TODBCMetaInfoStatement.Schemas;
begin
  FMode := 9;
  FExecuted := False;
  FNoMoreResults := False;
  FResultCols := -1;
end;

{-------------------------------------------------------------------------------}
procedure TODBCMetaInfoStatement.Execute;
const
   SQL_ALL_CATALOGS: String = '%';
   SQL_ALL_SCHEMAS: String = '%';
   EmptyStr: String = #0;

   function Str2P(const AStr: String): PSQLChar;
   begin
     if AStr = '' then
       Result := nil
     else
       Result := PSQLChar(AStr);
   end;

begin
  TODBCConnection(Owner).ClearInfo;
  case FMode of
  0: Check(Lib.SQLColumns(FHandle, Str2P(FCatalog), SQLSmallint(Length(FCatalog)),
           Str2P(FSchema), SQLSmallint(Length(FSchema)), Str2P(FObject),
           SQLSmallint(Length(FObject)), Str2P(FColumn), SQLSmallint(Length(FColumn))));
  1: Check(Lib.SQLForeignKeys(FHandle, Str2P(FCatalog), SQLSmallint(Length(FCatalog)),
           Str2P(FSchema), SQLSmallint(Length(FSchema)), Str2P(FObject),
           SQLSmallint(Length(FObject)), Str2P(FFKCatalog), SQLSmallint(Length(FFKCatalog)),
           Str2P(FFKSchema), SQLSmallint(Length(FFKSchema)), Str2P(FFKTable),
           SQLSmallint(Length(FFKTable))));
  2: Check(Lib.SQLPrimaryKeys(FHandle, Str2P(FCatalog), SQLSmallint(Length(FCatalog)),
           Str2P(FSchema), SQLSmallint(Length(FSchema)), Str2P(FObject),
           SQLSmallint(Length(FObject))));
  3: Check(Lib.SQLProcedures(FHandle, Str2P(FCatalog), SQLSmallint(Length(FCatalog)),
           Str2P(FSchema), SQLSmallint(Length(FSchema)), Str2P(FObject),
           SQLSmallint(Length(FObject))));
  4: Check(Lib.SQLProcedureColumns(FHandle, Str2P(FCatalog), SQLSmallint(Length(FCatalog)),
           Str2P(FSchema), SQLSmallint(Length(FSchema)), Str2P(FObject),
           SQLSmallint(Length(FObject)), Str2P(FColumn), SQLSmallint(Length(FColumn))));
  5: Check(Lib.SQLSpecialColumns(FHandle, FIdentifierType, Str2P(FCatalog),
           SQLSmallint(Length(FCatalog)), Str2P(FSchema), SQLSmallint(Length(FSchema)),
           Str2P(FObject), SQLSmallint(Length(FObject)), SQL_SCOPE_CURROW, SQL_NO_NULLS));
  6: Check(Lib.SQLStatistics(FHandle, Str2P(FCatalog), SQLSmallint(Length(FCatalog)),
           Str2P(FSchema), SQLSmallint(Length(FSchema)), Str2P(FObject),
           SQLSmallint(Length(FObject)), FUnique, SQL_QUICK));
  7: Check(Lib.SQLTables(FHandle, Str2P(FCatalog), SQLSmallint(Length(FCatalog)),
           Str2P(FSchema), SQLSmallint(Length(FSchema)), Str2P(FObject),
           SQLSmallint(Length(FObject)), Str2P(FTableTypes), SQLSmallint(Length(FTableTypes))));
  8: Check(Lib.SQLTables(FHandle, Str2P(SQL_ALL_CATALOGS), SQLSmallint(Length(SQL_ALL_CATALOGS)),
           PSQLChar(EmptyStr), SQL_NTS, PSQLChar(EmptyStr), SQL_NTS, PSQLChar(EmptyStr), SQL_NTS));
  9: Check(Lib.SQLTables(FHandle, PSQLChar(EmptyStr), SQL_NTS,
           Str2P(SQL_ALL_SCHEMAS), SQLSmallint(Length(SQL_ALL_SCHEMAS)),
           PSQLChar(EmptyStr), SQL_NTS, PSQLChar(EmptyStr), SQL_NTS));
  10:
    begin
      if TODBCConnection(Owner).DriverKind in [dkSQLNC, dkSQLOdbc] then
        SS_NAME_SCOPE := SQL_SS_NAME_SCOPE_TABLE_TYPE;
      Check(Lib.SQLColumns(FHandle, Str2P(FCatalog), SQLSmallint(Length(FCatalog)),
        Str2P(FSchema), SQLSmallint(Length(FSchema)), Str2P(FObject),
        SQLSmallint(Length(FObject)), Str2P(FColumn), SQLSmallint(Length(FColumn))));
    end;
  end;
  FExecuted := True;
  FNoMoreResults := True;
  FResultCols := -1;
end;

{-------------------------------------------------------------------------------}
function ODBCNativeExceptionLoad(const AStorage: IFDStanStorage): TObject;
begin
  Result := EODBCNativeException.Create;
  EODBCNativeException(Result).LoadFromStorage(AStorage);
end;

{-------------------------------------------------------------------------------}
initialization
  GLock := TCriticalSection.Create;
  FDStorageManager().RegisterClass(EODBCNativeException, 'ODBCNativeException',
    @ODBCNativeExceptionLoad, @FDExceptionSave);

finalization
  FDFreeAndNil(GLock);

end.
