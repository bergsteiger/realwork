{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{       FireDAC PostgreSQL API wrapping classes         }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.PGWrapper;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  System.Classes, System.SysUtils, System.Math, Data.FmtBCD,
  FireDAC.Stan.Intf, FireDAC.Stan.Error, FireDAC.Stan.Option, FireDAC.Stan.Util,
  FireDAC.Phys.PGCli;

type
  TPgLib = class;
  TPgObject = class;
  TFDPgError = class;
  EPgNativeException = class;
  TPgEnv = class;
  TPgMember = class;
  TPgType = class;
  TPgTypesManager = class;
  TPgConnection = class;
  TPgVariable = class;
  TPgVariableClass = class of TPgVariable;
  TPgVariables = class;
  TPgParam = class;
  TPgParams = class;
  TPgField = class;
  TPgFields = class;
  TPgStatement = class;
  TPgLargeObject = class;
  TPgLargeObjectStream = class;

  TPgBrand = (pbRegular, pbEnterprise);

  TPgLib = class(TFDLibrary)
  private
    FBrand: TPgBrand;

  protected
    procedure LoadEntries; override;

  public
    FPQconnectdb: TPQconnectdb;
    FPQfinish: TPQfinish;
    FPQreset: TPQreset;
    FPQserverVersion: TPQserverVersion;
    FPQprotocolVersion: TPQprotocolVersion;
    FPQstatus: TPQstatus;
    FPQerrorMessage: TPQerrorMessage;
    FPQparameterStatus: TPQparameterStatus;
    FPQtransactionStatus: TPQtransactionStatus;
    FPQsetClientEncoding: TPQsetClientEncoding;
    FPQclientEncoding: TPQclientEncoding;
    Fpg_encoding_to_char: Tpg_encoding_to_char;

    FPQexec: TPQexec;
    FPQexecParams: TPQexecParams;
    FPQprepare: TPQprepare;
    FPQexecPrepared: TPQexecPrepared;

    FPQresultStatus: TPQresultStatus;
    FPQresultErrorMessage: TPQresultErrorMessage;
    FPQresultErrorField: TPQresultErrorField;

    FPQclear: TPQresultStatus;
    FPQntuples: TPQntuples;
    FPQnfields: TPQnfields;

    FPQfname: TPQfname;
    FPQftable: TPQftable;
    FPQftablecol: TPQftablecol;
    FPQfformat: TPQfformat;
    FPQftype: TPQftype;
    FPQfmod: TPQfmod;
    FPQfsize: TPQfsize;

    FPQgetvalue: TPQgetvalue;
    FPQgetisnull: TPQgetisnull;
    FPQgetlength: TPQgetlength;

    FPQnparams: TPQnparams;
    FPQparamtype: TPQparamtype;

    FPQcmdStatus: TPQcmdStatus;
    FPQoidValue: TPQoidValue;
    FPQoidStatus: TPQoidStatus;
    FPQcmdTuples: TPQcmdTuples;

    FPQsetNoticeReceiver: TPQsetNoticeReceiver;

    FPQgetCancel: TPQgetCancel;
    FPQfreeCancel: TPQfreeCancel;
    FPQcancel: TPQcancel;

    FPQputCopyData: TPQputCopyData;
    FPQputCopyEnd: TPQputCopyEnd;

    //lo support
    Flo_creat: Tlo_creat;
    Flo_open: Tlo_open;
    Flo_write: Tlo_write;
    Flo_read: Tlo_read;
    Flo_lseek: Tlo_lseek;
    Flo_tell: Tlo_tell;
    Flo_close: Tlo_close;
    Flo_unlink: Tlo_unlink;
    Flo_truncate: Tlo_truncate;

    FPQgetResult: TPQgetResult;

    FPQnotifies: TPQnotifies;
    FPQfreemem: TPQfreemem;
    FPQconsumeInput: TPQconsumeInput;
    FPQsocket: TPQsocket;

    FPQexecBulkPrepared: TPQexecBulkPrepared;

    constructor Create(AOwningObj: TObject = nil);
    procedure Load(const AVendorHome, AVendorLib: String);
    property Brand: TPgBrand read FBrand;
  end;

  TPgObject = class(TObject)
  private
    FEnv: TPgEnv;
    [weak] FOwningObj: TObject;

    function GetLib: TPgLib; inline;
  protected
    procedure DoError(const AMessage: String; AStatus: Integer);
  public
    constructor Create(AEnv: TPgEnv; AOwningObj: TObject);

    property Env: TPgEnv read FEnv;
    property Lib: TPgLib read GetLib;
    property OwningObj: TObject read FOwningObj;
  end;

  TFDPgError = class(TFDDBError)
  private
    FSeverity: String;
    FErrorCode: String;
    FDetailedMessage: String;
    FHint: String;
    FPosition: Integer;
    FInternalPosition: Integer;
    FInternalQuery: String;
    FContext: String;
    FSchemaName: String;
    FTableName: String;
    FColumnName: String;
    FTypeName: String;
    FConstraintName: String;
    FSourceFile: String;
    FSourceLine: Integer;
    FSourceFunction: String;
  protected
    procedure Assign(ASrc: TFDDBError); override;
    procedure LoadFromStorage(const AStorage: IFDStanStorage); override;
    procedure SaveToStorage(const AStorage: IFDStanStorage); override;
  public
    property Severity: String read FSeverity;
    property ErrorCode: String read FErrorCode;
    property DetailedMessage: String read FDetailedMessage;
    property Hint: String read FHint;
    property Position: Integer read FPosition;
    property InternalPosition: Integer read FInternalPosition;
    property InternalQuery: String read FInternalQuery;
    property Context: String read  FContext;
    property SchemaName: String read FSchemaName;
    property TableName: String read FTableName;
    property ColumnName: String read FColumnName;
    property TypeName: String read FTypeName;
    property ConstraintName: String read FConstraintName;
    property SourceFile: String read FSourceFile;
    property SourceLine: Integer read FSourceLine;
    property SourceFunction: String read FSourceFunction;
  end;

  EPgNativeException = class(EFDDBEngineException)
  private
    function GetErrors(AIndex: Integer): TFDPgError;
  protected
    function GetErrorClass: TFDDBErrorClass; override;
  public
    function AppendError(const ADetailedMessage: String): TFDDBError; overload;
    function AppendError(const ASeverity, AErrorCode, AMessage, ADetailedMessage,
      AHint: String; APosition, AInternalPosition: Integer; const AInternalQuery,
      AContext, ASchemaName, ATableName, AColumnName, ATypeName, AConstraintName,
      ASourceFile: String; ASourceLine: Integer; const ASourceFunction: String): TFDDBError; overload;
    /// <summary> Use the Errors property to get access to an error item from
    ///  the collection of errors, associated with this exception object. </summary>
    property Errors[Index: Integer]: TFDPgError read GetErrors; default;
  end;

  TPgEnv = class(TObject)
  private
    FLib: TPgLib;
    [weak] FOwningObj: TObject;
{$IFDEF FireDAC_MONITOR}
    FMonitor: IFDMoniClient;
    FTracing: Boolean;
    function GetTracing: Boolean;
{$ENDIF}
  public
    constructor Create(ALib: TPgLib; AOwningObj: TObject);
{$IFDEF FireDAC_MONITOR}
    procedure Trace(const AMsg: String; const AArgs: array of const); overload;
    procedure Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
      const AMsg: String; const AArgs: array of const); overload;
    property Tracing: Boolean read FTracing write FTracing;
    property Monitor: IFDMoniClient read FMonitor write FMonitor;
{$ENDIF}
    property Lib: TPgLib read FLib;
    property OwningObj: TObject read FOwningObj;
  end;

  TPgMember = class(TObject)
  private
    FName: String;
    FOid: Oid;
    FRef: TPgType;
    FLen: Integer;
    FPrec: Integer;
    FScale: Integer;
    FAttrs: TFDDataAttributes;
  public
    constructor Create;
    property Name: String read FName;
    property TypeOid: Oid read FOid;
    property TypeRef: TPgType read FRef;
    property Len: Integer read FLen;
    property Prec: Integer read FPrec;
    property Scale: Integer read FScale;
    property Attrs: TFDDataAttributes read FAttrs;
  end;

  TPgTypeAttrs = set of (paString, paFixed, paBlob, paOID, paArray,
    paRecord, paEnum, paRange, paCast);
  TPgMembers = array of TPgMember;
  TPgEnums = array of String;

  TPgType = class(TObject)
  private
    FId: Oid;
    FName: String;
    FFixedLen: Integer;
    FFDSize: Integer;
    FPgSize: Integer;
    FAttrs: TPgTypeAttrs;
    FMembers: TPgMembers;
    FEnums: TFDStringList;
    function GetIsFlatFixedArray: Boolean;
    function GetEnums: TFDStringList;
  public
    destructor Destroy; override;
    function DumpType: String;
    function GetEnumValue(AOid: Oid): String;

    property Id: Oid read FId;
    property Name: String read FName;
    property FixedLen: Integer read FFixedLen;
    //
    property PGSize: Integer read FPGSize;
    property FDSize: Integer read FFDSize;
    property Attrs: TPgTypeAttrs read FAttrs;
    property Members: TPgMembers read FMembers;
    property IsFlatFixedArray: Boolean read GetIsFlatFixedArray;
    property Enums: TFDStringList read GetEnums;
  end;

  TPgTypesManager = class(TObject)
  private
    [weak] FConnection: TPgConnection;
    FTypes: TFDObjList;
    FLastType: TPgType;
                                                                       
    procedure DescribeError(const AId, AReason: String);
    function AddBase(AId: OID; const AName: String; AFixedLen, APGSize,
      AFDSize: Integer; AAttrs: TPgTypeAttrs): TPgType;
    function AddArray(AId: OID; const AName: String; ABaseOid: OID;
      AFixedLen: Integer = 0): TPgType;
    function FindType(AId: OID; AExact: Boolean): Integer;
    procedure AddType(AType: TPgType);
    function Describe(AOid: OID): TPgType;
    procedure Connected;
    function GetTypes(AOid: OID): TPgType;
    function GetArrays(AMemberOid: OID): TPgType;
  public
    constructor Create(AConnection: TPgConnection);
    destructor Destroy; override;
    class procedure GetDefaults(ATypeOid: Oid; out ALen, APrec, AScale: Integer); static;
    class procedure DecodeModifier(ATypeOid: Oid; AModifier: Integer;
      out ALen, APrec, AScale: Integer); static;
    function TypeByName(const AName: String): TPgType;
    property Types[AOid: OID]: TPgType read GetTypes;
    property Arrays[AMemberOid: OID]: TPgType read GetArrays;
  end;

  TPgConnectionNotifyEvent = procedure (const AName: String;
    AProcID: Integer; const AParameter: String) of object;

  TPgConnection = class(TPgObject)
  private
    FOwnHandle: Boolean;
    FBuffer: TFDBuffer;
    FEncoder: TFDEncoder;
    FNotices: EPgNativeException;
    FPStmtIDCounter: PInteger;
    FDefaultNoticeReceiver: TPQnoticeReceiver;
    FTypesManager: TPgTypesManager;
    FIntegerDateTimes: Integer;
    FServerVersion: TFDVersion;
    FLastInsertOid: Oid;
    FOnNotify: TPgConnectionNotifyEvent;
    FTimeZoneOffset: Integer;
    FUnknownFormat: OID;
    procedure Check;
    procedure ReadResultError(AHandle: PPGresult; AException: EPgNativeException);
    procedure CheckResult(AHandle: PPGresult; AOwningObj: TObject);
    procedure ClearNotices;
    procedure DoNoticeReceive(AHandle: PPGresult);
    function GetParameterStatus(const AParam: String): String;
    function GetTransactionStatus: Integer;
    function GetServerVersion: TFDVersion;
    function GetSERVER_VERSION: String;
    function GetClientEncoding: String;
    procedure SetClientEncoding(const AValue: String);
    function GenerateName: String;
    function GetSERVER_ENCODING: String;
    function GetCLIENT_ENCODING: String;
    function GetIS_SUPERUSER: String;
    function GetSESSION_AUTHORIZATION: String;
    function GetDATESTYLE: String;
    function GetINTEGER_DATETIMES: String;
    function GetTIMEZONE: String;
    function GetSTANDARD_CONFORMING_STRINGS: String;
    function GetIntegerDateTimes: Boolean;
  public
    FHandle: PPGconn;
    FStmtIDCounter: Integer;
    constructor Create(AEnv: TPgEnv; AOwningObj: TObject);
    constructor CreateUsingHandle(AEnv: TPgEnv; AHandle: PPGconn;
      APStmtIDCounter: PInteger; AOwningObj: TObject);
    destructor Destroy; override;
    procedure Connect(const AConnStr: String);
    procedure Disconnect;
    procedure ExecuteQuery(ASQL: String);
    procedure Abort;
    function CheckForInput: Boolean;
    function ReadNotifies(out AName: String; out AProcID: Integer;
      out AParameter: String): Boolean;
    // R/O
    property TypesManager: TPgTypesManager read FTypesManager;
    property Encoder: TFDEncoder read FEncoder;
    property Notices: EPgNativeException read FNotices;
    property LastInsertOid: Oid read FLastInsertOid;
    // server info
    property ServerVersion: TFDVersion read GetServerVersion;
    property TransactionStatus: Integer read GetTransactionStatus;
    property IntegerDateTimes: Boolean read GetIntegerDateTimes;
    // parameter status
    property SERVER_VERSION: String read GetSERVER_VERSION;
    property SERVER_ENCODING: String read GetSERVER_ENCODING;
    property CLIENT_ENCODING: String read GetCLIENT_ENCODING;
    property IS_SUPERUSER: String read GetIS_SUPERUSER;
    property SESSION_AUTHORIZATION: String read GetSESSION_AUTHORIZATION;
    property DATESTYLE: String read GetDATESTYLE;
    property INTEGER_DATETIMES: String read GetINTEGER_DATETIMES;
    property TIMEZONE: String read GetTIMEZONE;
    property STANDARD_CONFORMING_STRINGS: String read GetSTANDARD_CONFORMING_STRINGS;
    // R/W
    property ClientEncoding: String read GetClientEncoding write SetClientEncoding;
    property TimeZoneOffset: Integer read FTimeZoneOffset write FTimeZoneOffset default 0;
    property UnknownFormat: OID read FUnknownFormat write FUnknownFormat default 0;
    property OnNotify: TPgConnectionNotifyEvent read FOnNotify write FOnNotify;
  end;

  TPgVariable = class(TObject)
  private
    [weak] FOwner: TPgVariables;
    [weak] FStatement: TPgStatement;
    FIndex: Integer;
    FTypeOid: Oid;
    FTypeRef: TPgType;
    FFormat: Integer;
    FEncoding: TFDEncoding;
    FDumpLabel: String;
    function Pg2FDData(AType: TPgType; ASource: Pointer; ASourceLen: Integer;
      var ADest: Pointer; var ADestLen: LongWord; AByRef: Boolean): Boolean;
    function FD2PgData(AType: TPgType; ASource: Pointer; ASourceLen: Integer;
      var ADest: Pointer; var ADestLen: LongWord; var ADestFormat: Integer;
      AByRef: Boolean): Boolean;
    procedure CheckArrayBounds(AValue, ALBound, AHBound: Integer);
{$IFDEF FireDAC_MONITOR}
    function DumpSQLDataType: String;
    function DumpFDValue(ABuffer: Pointer; ALen: Integer): String;
{$ENDIF}
  protected
    procedure SetTypeOid(AValue: Oid); virtual;
    procedure AllocBuffer(ASize: LongWord); virtual;
    function GetDumpLabel: String; virtual;
  public
    constructor Create(AOwner: TPgVariables); virtual;
    property Statement: TPgStatement read FStatement;
    property Owner: TPgVariables read FOwner;
    property TypeRef: TPgType read FTypeRef;
    property TypeOid: Oid read FTypeOid write SetTypeOid;
    property DumpLabel: String read GetDumpLabel write FDumpLabel;
    property Encoding: TFDEncoding read FEncoding write FEncoding;
  end;

  TPgVariables = class(TObject)
  private
    FList: TFDObjList;
    {[weak]} FStatement: TPgStatement;
    function Add: TPgVariable;
    function GetCount: Integer; inline;
  protected
    function GetVariableClass: TPgVariableClass; virtual; abstract;
    procedure SetCount(AValue: Integer); virtual;
  public
    constructor Create(AOwner: TPgStatement); overload;
    destructor Destroy; override;
    property Count: Integer read GetCount write SetCount;
    property Statement: TPgStatement read FStatement;
  end;

  TPgParam = class(TPgVariable)
  private
    FSize: LongWord;      // string size
    FBufferSize: LongWord;
    FDataSize: LongWord;  // data size
    FValueSize: LongWord; // size of current value
    FBuffer: Pointer;
    FValueRef: Pointer;
    FIsNull: Boolean;
    FHBound, FLBound: Integer;
    FArrayIndex: Integer;
    procedure SetArrayIndex(AValue: Integer);
    procedure FreeBuffer;
    procedure CheckBuffer;
    procedure PackBuffer;
{$IFDEF FireDAC_MONITOR}
    function DumpValue: String;
{$ENDIF}
  protected
    procedure SetTypeOid(AValue: Oid); override;
    procedure AllocBuffer(ASize: LongWord); override;
  public
    constructor Create(AOwner: TPgVariables); override;
    destructor Destroy; override;
    procedure SetData(ApData: Pointer; ALen: LongWord; AByRef: Boolean = False);
    procedure SetArrayBounds(ALBound, AHBound: Integer);
    property Size: LongWord read FSize write FSize;
    property ArrayIndex: Integer read FArrayIndex write SetArrayIndex;
  end;

  TPgParams = class(TPgVariables)
  private
    FValueTypes: POid;
    FValueRefs: PPointer;
    FValueLengths: PInteger;
    FValueFormats: PInteger;
    function GetItems(AIndex: Integer): TPgParam;
  protected
    function GetVariableClass: TPgVariableClass; override;
    procedure SetCount(AValue: Integer); override;
    function GetValueTypes: Pointer;
    function GetValueRefs: Pointer;
    function GetValueLengths: Pointer;
    function GetValueFormats: Pointer;
  public
    property Items[Index: Integer]: TPgParam read GetItems; default;
  end;

  TPgField = class(TPgVariable)
  private
    FName: String;
    FTableOid: Oid;
    FTableCol: Integer;
    FLen: Integer;
    FPrec: Integer;
    FScale: Integer;
    FArrayIndex: Integer;
    FFields: TPgFields;
    function GetPgData(out APgData: Pointer; out APgDataLen: Integer): Boolean;
    procedure GetArrayInfo(ApData: Pointer; out ALBound, AHBound: Integer;
      out AClosed: Boolean; out ApFirstElem: Pointer);
    procedure SetArrayIndex(const AValue: Integer);
    function GetParentField: TPgField; inline;
    procedure SetDefaults;
  protected
    procedure SetTypeOid(AValue: Oid); override;
    function GetDumpLabel: String; override;
{$IFDEF FireDAC_MONITOR}
    function DumpValue: String;
{$ENDIF}
  public
    constructor Create(AOwner: TPgVariables); override;
    destructor Destroy; override;
    function GetData(var ApData: Pointer; var ALen: LongWord; AByRef: Boolean): Boolean; overload;
    function GetData(ApData: Pointer; var ALen: LongWord): Boolean; overload; inline;
    function GetData(ApData: Pointer): Boolean; overload; inline;
    function GetAsString: String;
    function GetArrayBounds(out ALBound, AHBound: Integer; out AClosed: Boolean): Boolean;
    // R/O
    property Name: String read FName;
    property TableCol: Integer read FTableCol;
    property TableOid: Oid read FTableOid;
    property Len: Integer read FLen;
    property Prec: Integer read FPrec;
    property Scale: Integer read FScale;
    property Fields: TPgFields read FFields;
    property ParentField: TPgField read GetParentField;
    // R/W
    property ArrayIndex: Integer read FArrayIndex write SetArrayIndex;
  end;

  TPgFields = class(TPgVariables)
  private
    [weak] FParentField: TPgField;
    FPgData: Pointer;
    FPgDataLen: Integer;
    function GetItems(AIndex: Integer): TPgField;
  protected
    function GetVariableClass: TPgVariableClass; override;
  public
    constructor Create(AOwner: TPgField); overload;
    property Items[Index: Integer]: TPgField read GetItems; default;
    property PgData: Pointer read FPgData;
    property PgDataLen: Integer read FPgDataLen;
    property ParentField: TPgField read FParentField;
  end;

  TPgStatement = class(TPgObject)
  private
    FConnection: TPgConnection;
    FCursorName: String;
    FStmtName: String;
    FRowsetStmtName: String;
    FParams: TPgParams;
    FFields: TPgFields;
    FRowsAffected: Int64;
    FLastInsertOid: Oid;
    FSQLStmtType: String;
    FRowsSelected: Int64;
    FRowsetOffset: Int64;
    FCurrentRow: Int64;
    FEOF: Boolean;
    FClosed: Boolean;
    FLastRowset: Boolean;
    FStrsTrim: Boolean;
    FStrsEmpty2Null: Boolean;
    FRowsetSize: Integer;
    FWithHold: Boolean;
    FResultFormat: Integer;
    procedure Check(AHandle: PPGresult);
    procedure GetResultInfo;
    procedure GetNextRowset;
    procedure Reset;
    procedure Clear;
    function InternalPrepare(const ASQL: String; AUseParams: Boolean): String;
    procedure InternalExecute(const AStmtName: String; AnParams: Integer;
      AParamValues: Pointer; AParamLengths, AParamFormats: PInteger;
      AResultFormat: Integer); overload;
    procedure InternalExecute(AResultFormat: Integer); overload;
    procedure InternalUnprepare(var AStmtName: String);
    procedure InternalExecuteDirect(const ASQL: String; AResultFormat: Integer);
{$IFDEF FireDAC_MONITOR}
    procedure DumpInVars;
    procedure DumpOutVars;
    procedure GetStmtName(out AName, AValue: String);
{$ENDIF}
  public
    FHandle: PPGresult;
    constructor Create(AConnection: TPgConnection; AOwningObj: TObject);
    destructor Destroy; override;
    procedure PrepareSQL(const ASQL: String);
    procedure PrepareCursor(const ACursorName: String);
    procedure DescribeFields;
    procedure Execute;
    procedure ExecuteDirect(const ASQL: String);
    function Fetch: Boolean;
    procedure Unprepare;
    procedure Close;
    // R/O
    property Connection: TPgConnection read FConnection;
    property Params: TPgParams read FParams;
    property Fields: TPgFields read FFields;
    property SQLStmtType: String read FSQLStmtType;
    property RowsAffected: Int64 read FRowsAffected;
    property RowsSelected: Int64 read FRowsSelected;
    property LastInsertOid: Oid read FLastInsertOid;
    property Eof: Boolean read FEOF;
    property Closed: Boolean read FClosed;
    property ResultFormat: Integer read FResultFormat;
    // R/W state
    property CurrentRow: Int64 read FCurrentRow write FCurrentRow;
    // R/W options
    property StrsTrim: Boolean read FStrsTrim write FStrsTrim;
    property StrsEmpty2Null: Boolean read FStrsEmpty2Null write FStrsEmpty2Null;
    property RowsetSize: Integer read FRowsetSize write FRowsetSize;
    property WithHold: Boolean read FWithHold write FWithHold;
  end;

  TPgLargeObject = class(TPgObject)
  private
    FConnection: TPgConnection;
    FPosition: Integer;
    FIsOpen: Boolean;
    FMode: TFDStreamMode;
    function GetLen: Integer;
    procedure SetLen(const AValue: Integer);
    procedure Error(const AOperation: String; AStatus: Integer);
    procedure CheckReadWrite;
    function Mode2PGMode: Integer;
  public
    FObjOid: Oid;
    FObjHandle: Integer;

    constructor Create(AConnection: TPgConnection; AMode: TFDStreamMode;
      AOwningObj: TObject); overload;
    constructor Create(AConnection: TPgConnection; AMode: TFDStreamMode;
      AOwningObj: TObject; AObjOid: Oid); overload;
    destructor Destroy; override;

    procedure CreateObj;
    procedure Open;
    procedure Close(AIgnoreErrors: Boolean);
    procedure UnLink;
    function Seek(AOffset: Integer; ASeekOrigin: Word): Integer;
    function Read(ABuff: PByte; ABuffLen: Integer): Integer;
    function Write(ABuff: PByte; ABuffLen: Integer): Integer;

    property IsOpen: Boolean read FIsOpen;
    property Mode: TFDStreamMode read FMode;
    property Connection: TPgConnection read FConnection;
    property Len: Integer read GetLen write SetLen;
  end;

  TPgLargeObjectStream = class(TStream)
  private
    FLargeObject: TPgLargeObject;
  protected
    procedure SetSize(const NewSize: Int64); override;
  public
    constructor Create(ALargeObject: TPgLargeObject);
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
    property LargeObject: TPgLargeObject read FLargeObject;
  end;

procedure j2date(const AValue: Int64; out AYear, AMonth, ADay: Word);
procedure dtInt2time(AValue: Int64; out AHour, AMin, ASec: Word; out AFsec: Cardinal);
procedure dtDbl2time(AValue: Double; out AHour, AMin, ASec: Word; out AFsec: Cardinal);
function date2j(AYear, AMonth, ADay: Word): Int64;
function time2IntT(const AHour, AMin, ASec: Word; const AFsec: Cardinal): Int64;
function time2DblT(const AHour, AMin, ASec: Word; const AFsec: Cardinal): Double;
procedure GetPgNumeric(ASource: Pointer; out ADest: TBcd);
procedure GetPgMoney(ASource: Pointer; ASourceLen: Integer; out ADest: Currency);
procedure SetPgNumeric(const ASource: TBcd; ADest: Pointer; out ADestLen: LongWord);
procedure SetPgMoney(const ASource: Currency; ADest: Pointer; ADestLen: LongWord);

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.WinSock,
{$ENDIF}
{$IFDEF UNIX}
  sockets, netdb,
{$ENDIF}
  Data.SqlTimSt,
  FireDAC.Stan.SQLTimeInt, FireDAC.Stan.Consts;

const
  sPQconnectdb: String = 'PQconnectdb';
  sPQfinish: String = 'PQfinish';
  sPQserverVersion: String = 'PQserverVersion';
  sPQprotocolVersion: String = 'PQprotocolVersion';
  sPQstatus: String = 'PQstatus';
  sPQerrorMessage: String = 'PQerrorMessage';
  sPQparameterStatus: String = 'PQparameterStatus';
  sPQtransactionStatus: String = 'PQtransactionStatus';
  sPQsetClientEncoding: String = 'PQsetClientEncoding';
  sPQclientEncoding: String = 'PQclientEncoding';
  spg_encoding_to_char: String = 'pg_encoding_to_char';

  sPQexec: String = 'PQexec';
  sPQexecParams: String = 'PQexecParams';
  sPQprepare: String = 'PQprepare';
  sPQexecPrepared: String = 'PQexecPrepared';

  sPQresultStatus: String = 'PQresultStatus';
  sPQresultErrorMessage: String = 'PQresultErrorMessage';
  sPQresultErrorField: String = 'PQresultErrorField';

  sPQclear: String = 'PQclear';
  sPQntuples: String = 'PQntuples';
  sPQnfields: String = 'PQnfields';
  sPQfname: String = 'PQfname';
  sPQftable: String = 'PQftable';
  sPQftablecol: String = 'PQftablecol';
  sPQfformat: String = 'PQfformat';
  sPQftype: String = 'PQftype';
  sPQfmod: String  = 'PQfmod';
  sPQfsize: String = 'PQfsize';

  sPQgetisnull: String = 'PQgetisnull';
  sPQgetlength: String = 'PQgetlength';
  sPQgetvalue: String = 'PQgetvalue';


  sPQnparams: String = 'PQnparams';
  sPQparamtype: String = 'PQparamtype';

  sPQcmdStatus: String = 'PQcmdStatus';
  sPQoidValue: String = 'PQoidValue';
  sPQoidStatus: String = 'PQoidStatus';
  sPQcmdTuples: String = 'PQcmdTuples';

  sPQsetNoticeReceiver: String = 'PQsetNoticeReceiver';

  sPQgetCancel: String = 'PQgetCancel';
  sPQfreeCancel: String = 'PQfreeCancel';
  sPQcancel: String = 'PQcancel';

  sPQputCopyData: String = 'PQputCopyData';
  sPQputCopyEnd: String = 'PQputCopyEnd';

  slo_creat: String = 'lo_creat';
  slo_open: String = 'lo_open';
  slo_write: String = 'lo_write';
  slo_read: String = 'lo_read';
  slo_lseek: String = 'lo_lseek';
  slo_tell: String = 'lo_tell';
  slo_close: String = 'lo_close';
  slo_unlink: String = 'lo_unlink';
  slo_truncate: String = 'lo_truncate';

  sPQgetResult: String = 'PQgetResult';

  sPQnotifies: String = 'PQnotifies';
  sPQfreemem: String = 'PQfreemem';
  sPQconsumeInput: String = 'PQconsumeInput';
  sPQsocket: String = 'PQsocket';

  sPQprepareOut: String = 'PQprepareOut';

  sPQexecBulkPrepared: String = 'PQexecBulkPrepared';

  max_string_size = 4000;
  cancel_buf_size = 255;

  pg_base_date = 36526;   // 01.01.2000
  MinDateTime = -657434;  // 01/01/0100 12:00:00.000 AM
  MaxDateTime = 2958466;  // 12/31/9999 11:59:59.999 PM
  McSecsPerSec = 1000000;
  McSecsPerDay = Int64(SecsPerDay) * McSecsPerSec;
  McSecsPerHour = Int64(SecsPerHour) * McSecsPerSec;
  McSecsPerMin = Int64(SecsPerMin) * McSecsPerSec;

type
  TPgTimeStampBuf = array [0..7] of Byte;
  TPgTimeIntervalBuf = array [0..7 + 4 + 4] of Byte;

{-------------------------------------------------------------------------------}
{ TPgLib                                                                        }
{-------------------------------------------------------------------------------}
constructor TPgLib.Create(AOwningObj: TObject);
begin
  inherited Create(S_FD_PGId, AOwningObj);
end;

{-------------------------------------------------------------------------------}
procedure TPgLib.Load(const AVendorHome, AVendorLib: String);
{$IFNDEF FireDAC_PGSQL_STATIC}
const
  C_PgDll: String = 'libpq' + C_FD_DLLExt;
var
  sDLLName: String;
{$ENDIF}
begin
{$IFNDEF FireDAC_PGSQL_STATIC}
  sDLLName := AVendorHome;
  if sDLLName <> '' then
    sDLLName := FDNormPath(FDNormPath(sDLLName) + C_FD_DLLFolder);
  if AVendorLib <> '' then
    sDLLName := sDLLName + AVendorLib
  else
    sDLLName := sDLLName + C_PgDll;
  inherited Load([sDLLName], True);
{$ELSE}
  LoadEntries;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TPgLib.LoadEntries;
begin
{$IFDEF FireDAC_PGSQL_STATIC}
  FBrand := pbRegular;

  FPQconnectdb := @PQconnectdb;
  FPQfinish := @PQfinish;
  FPQserverVersion := @PQserverVersion;
  FPQprotocolVersion := @PQprotocolVersion;         // not used, not in 8.1 ?

  FPQstatus := @PQstatus;
  FPQerrorMessage := @PQerrorMessage;
  FPQparameterStatus := @PQparameterStatus;
  FPQtransactionStatus := @PQtransactionStatus;
  FPQsetClientEncoding := @PQsetClientEncoding;
  FPQclientEncoding := @PQclientEncoding;
  Fpg_encoding_to_char := @pg_encoding_to_char;

  FPQexec := @PQexec;
  FPQexecParams := @PQexecParams;

  FPQprepare := @PQprepare;                         // in 8.0
  FPQexecPrepared := @PQexecPrepared;

  FPQresultStatus := @PQresultStatus;
  FPQresultErrorMessage := @PQresultErrorMessage;   // not used
  FPQresultErrorField := @PQresultErrorField;

  FPQclear := @PQclear;
  FPQntuples := @PQntuples;
  FPQnfields := @PQnfields;

  FPQfname := @PQfname;
  FPQftable := @PQftable;
  FPQftablecol := @PQftablecol;
  FPQfformat := @PQfformat;
  FPQftype := @PQftype;
  FPQfmod := @PQfmod;
  FPQfsize := @PQfsize;                             // not used

  FPQgetvalue := @PQgetvalue;
  FPQgetisnull := @PQgetisnull;
  FPQgetlength := @PQgetlength;

  FPQnparams := @PQnparams;                         // not used, not in 8.1 ?
  FPQparamtype := @PQparamtype;                     // not used, not in 8.1 ?

  FPQcmdStatus := @PQcmdStatus;

  // FPQoidValue, FPQoidStatus, FPQcmdTuples since version 8.0 cas be used for
  // execute statements id ()
  FPQoidValue := @PQoidValue;
  FPQoidStatus := @PQoidStatus;                     // not used
  FPQcmdTuples := @PQcmdTuples;

  FPQsetNoticeReceiver := @PQsetNoticeReceiver;

  FPQgetCancel := @PQgetCancel;
  FPQfreeCancel := @PQfreeCancel;
  FPQcancel := @PQcancel;

  FPQputCopyData := @PQputCopyData;                 // not used
  FPQputCopyEnd := @PQputCopyEnd;                   // not used

  Flo_creat := @lo_creat;
  Flo_open := @lo_open;
  Flo_write := @lo_write;
  Flo_read := @lo_read;
  Flo_lseek := @lo_lseek;
  Flo_tell := @lo_tell;                             // not used
  Flo_close := @lo_close;
  Flo_unlink := @lo_unlink;
  Flo_truncate = @lo_truncate;

  FPQgetResult := @PQgetResult;                     // not used

  FPQnotifies := @PQnotifies;
  FPQfreemem := @PQfreemem;
  FPQconsumeInput := @PQconsumeInput;
  FPQsocket := @PQsocket;

  FPQexecBulkPrepared := nil;

 {$ELSE}

  if GetProc(sPQprepareOut, False) = nil then
    FBrand := pbRegular
  else
    FBrand := pbEnterprise;

  FPQconnectdb := GetProc(sPQconnectdb);
  FPQfinish := GetProc(sPQfinish);
  FPQserverVersion := GetProc(sPQserverVersion, False);      // not used, not in 7.4
  FPQprotocolVersion := GetProc(sPQprotocolVersion, False);  // not used, not in 8.1

  FPQstatus := GetProc(sPQstatus);
  FPQerrorMessage := GetProc(sPQerrorMessage);
  FPQparameterStatus := GetProc(sPQparameterStatus);
  FPQtransactionStatus := GetProc(sPQtransactionStatus);
  FPQsetClientEncoding := GetProc(sPQsetClientEncoding);
  FPQclientEncoding := GetProc(sPQclientEncoding);
  Fpg_encoding_to_char := GetProc(spg_encoding_to_char);

  FPQexec := GetProc(sPQexec);
  FPQexecParams := GetProc(sPQexecParams, False);

  FPQprepare := GetProc(sPQprepare, False);                  // in 8.0
  FPQexecPrepared := GetProc(sPQexecPrepared);

  FPQresultStatus := GetProc(sPQresultStatus);
  FPQresultErrorMessage := GetProc(sPQresultErrorMessage);   // not used
  FPQresultErrorField := GetProc(sPQresultErrorField);

  FPQclear := GetProc(sPQclear);
  FPQntuples := GetProc(sPQntuples);
  FPQnfields := GetProc(sPQnfields);

  FPQfname := GetProc(sPQfname);
  FPQftable := GetProc(sPQftable);
  FPQftablecol := GetProc(sPQftablecol);
  FPQfformat := GetProc(sPQfformat);
  FPQftype := GetProc(sPQftype);
  FPQfmod := GetProc(sPQfmod);
  FPQfsize := GetProc(sPQfsize);                             // not used

  FPQgetvalue := GetProc(sPQgetvalue);
  FPQgetisnull := GetProc(sPQgetisnull);
  FPQgetlength := GetProc(sPQgetlength);

  FPQnparams := GetProc(sPQnparams, False);                  // not used, not in 8.1 ?
  FPQparamtype := GetProc(sPQparamtype, False);              // not used, not in 8.1 ?

  FPQcmdStatus := GetProc(sPQcmdStatus);

  // FPQoidValue, FPQoidStatus, FPQcmdTuples since version 8.0 can be used
  // to execute statements id ()
  FPQoidValue := GetProc(sPQoidValue);
  FPQoidStatus := GetProc(sPQoidStatus);                     // not used
  FPQcmdTuples := GetProc(sPQcmdTuples);

  FPQsetNoticeReceiver := GetProc(sPQsetNoticeReceiver);

  FPQgetCancel := GetProc(sPQgetCancel, False);
  FPQfreeCancel := GetProc(sPQfreeCancel, False);
  FPQcancel := GetProc(sPQcancel, False);

  FPQputCopyData := GetProc(sPQputCopyData);                 // not used
  FPQputCopyEnd := GetProc(sPQputCopyEnd);                   // not used

  Flo_creat := GetProc(slo_creat);
  Flo_open := GetProc(slo_open);
  Flo_write := GetProc(slo_write);
  Flo_read := GetProc(slo_read);
  Flo_lseek := GetProc(slo_lseek);
  Flo_tell := GetProc(slo_tell);                             // not used
  Flo_close := GetProc(slo_close);
  Flo_unlink := GetProc(slo_unlink);
  Flo_truncate := GetProc(slo_truncate, False);

  FPQgetResult := GetProc(sPQgetResult);                     // not used

  FPQnotifies := GetProc(sPQnotifies);
  FPQfreemem := GetProc(sPQfreemem);
  FPQconsumeInput := GetProc(sPQconsumeInput);
  FPQsocket := GetProc(sPQsocket);

  if FBrand = pbEnterprise then begin
    FPQexecBulkPrepared := GetProc(sPQexecBulkPrepared);
  end
  else begin
    FPQexecBulkPrepared := nil;
  end;
{$ENDIF}

{$IFDEF POSIX}
  if Assigned(FPQprepare) then
    FVersion := svPGSQL080100
  else
    FVersion := svPGSQL070300;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
{ TFDPgError                                                                    }
{-------------------------------------------------------------------------------}
procedure TFDPgError.Assign(ASrc: TFDDBError);
begin
  inherited Assign(ASrc);
  if ASrc is TFDPgError then begin
    FSeverity := TFDPgError(ASrc).FSeverity;
    FErrorCode := TFDPgError(ASrc).FErrorCode;
    FDetailedMessage := TFDPgError(ASrc).FDetailedMessage;
    FHint := TFDPgError(ASrc).FHint;
    FPosition := TFDPgError(ASrc).FPosition;
    FInternalPosition := TFDPgError(ASrc).FInternalPosition;
    FInternalQuery := TFDPgError(ASrc).FSeverity;
    FContext := TFDPgError(ASrc).FSeverity;
    FSchemaName := TFDPgError(ASrc).FSchemaName;
    FTableName := TFDPgError(ASrc).FTableName;
    FColumnName := TFDPgError(ASrc).FColumnName;
    FTypeName := TFDPgError(ASrc).FTypeName;
    FConstraintName := TFDPgError(ASrc).FConstraintName;
    FSourceFile := TFDPgError(ASrc).FSeverity;
    FSourceLine := TFDPgError(ASrc).FSourceLine;    
    FSourceFunction := TFDPgError(ASrc).FSeverity;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPgError.LoadFromStorage(const AStorage: IFDStanStorage);
begin
  inherited LoadFromStorage(AStorage);
  FSeverity := AStorage.ReadString('Severity', '');
  FErrorCode := AStorage.ReadString('ErrorCode', '');
  FDetailedMessage := AStorage.ReadString('DetailedMessage', '');
  FHint := AStorage.ReadString('Hint', '');
  FPosition := AStorage.ReadInteger('Position', 0);
  FInternalPosition := AStorage.ReadInteger('InternalPosition', 0);
  FInternalQuery := AStorage.ReadString('InternalQuery', '');
  FContext := AStorage.ReadString('Context', '');
  FSchemaName := AStorage.ReadString('SchemaName', '');
  FTableName := AStorage.ReadString('TableName', '');
  FColumnName := AStorage.ReadString('ColumnName', '');
  FTypeName := AStorage.ReadString('TypeName', '');
  FConstraintName := AStorage.ReadString('ConstraintName', '');
  FSourceFile := AStorage.ReadString('SourceFile', '');
  FSourceLine := AStorage.ReadInteger('SourceLine', 0);
  FSourceFunction := AStorage.ReadString('SourceFunction', '');
end;

{-------------------------------------------------------------------------------}
procedure TFDPgError.SaveToStorage(const AStorage: IFDStanStorage);
begin
  inherited SaveToStorage(AStorage);
  AStorage.WriteString('Severity', FSeverity, '');
  AStorage.WriteString('ErrorCode', FErrorCode, '');
  AStorage.WriteString('DetailedMessage', FDetailedMessage, '');
  AStorage.WriteString('Hint', FHint, '');
  AStorage.WriteInteger('Position', FPosition, 0);
  AStorage.WriteInteger('InternalPosition', FInternalPosition, 0);
  AStorage.WriteString('InternalQuery', FInternalQuery, '');
  AStorage.WriteString('Context', FContext, '');
  AStorage.WriteString('SchemaName', FSchemaName, '');
  AStorage.WriteString('TableName', FTableName, '');
  AStorage.WriteString('ColumnName', FColumnName, '');
  AStorage.WriteString('TypeName', FTypeName, '');
  AStorage.WriteString('ConstraintName', FConstraintName, '');
  AStorage.WriteString('SourceFile', FSourceFile, '');
  AStorage.WriteInteger('SourceLine', FSourceLine, 0);    
  AStorage.WriteString('SourceFunction', FSourceFunction, '');
end;

{-------------------------------------------------------------------------------}
{ EPgNativeException                                                            }
{-------------------------------------------------------------------------------}
function EPgNativeException.AppendError(const ADetailedMessage: String): TFDDBError;
var
  eKind: TFDCommandExceptionKind;
  sSeverity: String;
  sMessage, sLCMessage: String;
  iSep: Integer;
begin
  iSep := Pos(':', ADetailedMessage);
  if iSep > 0 then
    sSeverity := Copy(ADetailedMessage, 1, iSep - 1)
  else
    sSeverity := '';

  if (sSeverity = 'ERROR') or (sSeverity = 'FATAL') then
    sMessage := Trim(Copy(ADetailedMessage, iSep + 1, Length(ADetailedMessage) - iSep))
  else
    sMessage := ADetailedMessage;
  sLCMessage := LowerCase(sMessage);

  if FDStrLike(sLCMessage, 'role "%" does not exist') or
     FDStrLike(sLCMessage, 'password authentication failed for user "%"') then
    eKind := ekUserPwdInvalid
  else if (Pos('connection refused', sLCMessage) <> 0) or
          (Pos('could not connect to server', sLCMessage) <> 0) then
    eKind := ekServerGone
  else
    eKind := ekOther;

  Result := inherited AppendError(1, 0, sMessage, '', eKind, -1, -1);
  TFDPgError(Result).FSeverity := sSeverity;

  Message := Message + ' ' + TFDPgError(Result).Message;
end;

{-------------------------------------------------------------------------------}
function EPgNativeException.AppendError(const ASeverity, AErrorCode, AMessage,
  ADetailedMessage, AHint: String; APosition, AInternalPosition: Integer;
  const AInternalQuery, AContext, ASchemaName, ATableName, AColumnName,
  ATypeName, AConstraintName, ASourceFile: String; ASourceLine: Integer;
  const ASourceFunction: String): TFDDBError;
var
  sErrorCodeClass: String;
  eKind: TFDCommandExceptionKind;
  sObj: String;
  oErr: TFDPgError;

  procedure ExtractObjName;
  var
    i1, i2: Integer;
  begin
    i2 := 0;
    while True do begin
      i1 := Pos('"', AMessage, i2 + 1);
      if i1 = 0 then
        Break;
      i2 := Pos('"', AMessage, i1 + 1);
      if i2 = 0 then
        Break;
      sObj := Copy(AMessage, i1 + 1, i2 - i1 - 1);
    end;
  end;

begin
  sObj := '';
  eKind := ekOther;  
  sErrorCodeClass := Copy(AErrorCode, 1, 2);

  if sErrorCodeClass = '02' then      // No Data Class
    eKind := ekNoDataFound
  else if AErrorCode = '40P01' then   // DEADLOCK DETECTED
    eKind := ekRecordLocked
  else if sErrorCodeClass = '23' then begin
    ExtractObjName;
    if AErrorCode = '23505' then      // UNIQUE VIOLATION
      eKind := ekUKViolated
    else if AErrorCode = '23503' then // FOREIGN KEY VIOLATION
      eKind := ekFKViolated;
  end
  else if sErrorCodeClass = '42' then begin
    ExtractObjName;
    if (aErrorCode = '42P01') or      // UNDEFINED TABLE
       (aErrorCode = '42703') or      // UNDEFINED COLUMN
       (aErrorCode = '42883') or      // UNDEFINED FUNCTION
       (aErrorCode = '42704') then    // UNDEFINED OBJECT
      eKind := ekObjNotExists
    else if aErrorCode = '42P02' then // UNDEFINED PARAMETER
      eKind := ekInvalidParams;
  end
  else if AErrorCode = '57014' then
    eKind := ekCmdAborted
  else if AErrorCode = '08P01' then
    eKind := ekInvalidParams
  else if (AErrorCode = '') or        // at least, when service is terminated,
                                      //   then error code is an empty string
          (aErrorCode = '08000') or   // CONNECTION EXCEPTION
          (aErrorCode = '08003') or   // CONNECTION DOES NOT EXIST
          (aErrorCode = '08006') or   // CONNECTION FAILURE
          (aErrorCode = '57P01') or   // ADMIN SHUTDOWN
          (aErrorCode = '57P02') or   // CRASH SHUTDOWN
          (aErrorCode = '57P03') then // CANNOT CONNECT NOW
    eKind := ekServerGone;

  Result := inherited AppendError(1, 0, AMessage, sObj, eKind, APosition, -1);

  oErr := TFDPgError(Result);
  oErr.FSeverity := ASeverity;
  oErr.FErrorCode := AErrorCode;
  oErr.FDetailedMessage := ADetailedMessage;
  oErr.FHint := AHint;
  oErr.FPosition := APosition;
  oErr.FInternalPosition := AInternalPosition;
  oErr.FInternalQuery := AInternalQuery;
  oErr.FContext := AContext;
  oErr.FSchemaName := ASchemaName;
  oErr.FTableName := ATableName;
  oErr.FColumnName := AColumnName;
  oErr.FTypeName := ATypeName;
  oErr.FConstraintName := AConstraintName;
  oErr.FSourceFile := ASourceFile;
  oErr.FSourceLine := ASourceLine;
  oErr.FSourceFunction := ASourceFunction;

  if AConstraintName <> '' then
    Result.ObjName := AConstraintName
  else if ATypeName <> '' then
    Result.ObjName := ATypeName
  else if AColumnName <> '' then
    Result.ObjName := AColumnName
  else if ATableName <> '' then
    Result.ObjName := ATableName;

  if ASeverity <> 'NOTICE' then begin
    Message := Message + ' ' + ASeverity + ': ' + TFDPgError(Result).Message;
    if ADetailedMessage <> '' then
      Message := Message + '.' + C_FD_EOL + ADetailedMessage;
    if AHint <> '' then
      Message := Message + '.' + C_FD_EOL + AHint;
  end;
end;

{-------------------------------------------------------------------------------}
function EPgNativeException.GetErrorClass: TFDDBErrorClass;
begin
  Result := TFDPgError;
end;

{-------------------------------------------------------------------------------}
function EPgNativeException.GetErrors(AIndex: Integer): TFDPgError;
begin
  Result := TFDPgError(inherited Errors[AIndex]);
end;

{-------------------------------------------------------------------------------}
{ TPgEnv                                                                        }
{-------------------------------------------------------------------------------}
constructor TPgEnv.Create(ALib: TPgLib; AOwningObj: TObject);
begin
  inherited Create;
  FLib := ALib;
  FOwningObj := AOwningObj;
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
function TPgEnv.GetTracing: Boolean;
begin
  Result := (FMonitor <> nil) and FMonitor.Tracing and FTracing;
end;

{-------------------------------------------------------------------------------}
procedure TPgEnv.Trace(const AMsg: String; const AArgs: array of const);
begin
  if GetTracing then
    FMonitor.Notify(ekVendor, esProgress, OwningObj, AMsg, AArgs);
end;

{-------------------------------------------------------------------------------}
procedure TPgEnv.Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
  const AMsg: String; const AArgs: array of const);
begin
  if GetTracing then
    FMonitor.Notify(AKind, AStep, OwningObj, AMsg, AArgs);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TPgObject                                                                     }
{-------------------------------------------------------------------------------}
constructor TPgObject.Create(AEnv: TPgEnv; AOwningObj: TObject);
begin
  inherited Create;
  FEnv := AEnv;
  FOwningObj := AOwningObj;
end;

{-------------------------------------------------------------------------------}
function TPgObject.GetLib: TPgLib;
begin
  Result := FEnv.Lib;
end;

{-------------------------------------------------------------------------------}
procedure TPgObject.DoError(const AMessage: String; AStatus: Integer);
var
  oEx: EPgNativeException;
begin
  oEx := EPgNativeException.Create(er_FD_PgGeneral,
    FDExceptionLayers([S_FD_LPhys, S_FD_PgId, 'libpq']));
  oEx.AppendError(AMessage);
{$IFDEF FireDAC_MONITOR}
  Env.Trace(ekError, esProgress, 'ERROR: ' + oEx[0].Message,
      ['Status', AStatus]);
{$ENDIF}
  FDException(OwningObj, oEx {$IFDEF FireDAC_Monitor}, Env.Tracing {$ENDIF});
end;

{-------------------------------------------------------------------------------}
{ TPgMember                                                                     }
{-------------------------------------------------------------------------------}
constructor TPgMember.Create;
begin
  inherited Create;
  FAttrs := [caAllowNull];
end;

{-------------------------------------------------------------------------------}
{ TPgType                                                                       }
{-------------------------------------------------------------------------------}
destructor TPgType.Destroy;
var
  i: Integer;
begin
  for i := 0 to Length(Members) - 1 do
    FDFree(Members[i]);
  FDFreeAndNil(FEnums);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TPgType.GetEnums: TFDStringList;
begin
  if FEnums = nil then
    FEnums := TFDStringList.Create;
  Result := FEnums;
end;

{-------------------------------------------------------------------------------}
function TPgType.DumpType: String;
begin
  if paArray in Attrs then begin
    Result := Members[0].TypeRef.DumpType;
    if (paFixed in Attrs) and (FixedLen > 0) then
      Result := Result + '[' + IntToStr(FixedLen) + ']'
    else
      Result := Result + '[]';
  end
  else
    Result := Name;
end;

{-------------------------------------------------------------------------------}
function TPgType.GetIsFlatFixedArray: Boolean;
begin
  Result :=
      ([paArray, paFixed] * Attrs = [paArray, paFixed]) and
      (Length(Members) = 1) and
      ([paArray, paRecord, paRange] * Members[0].TypeRef.Attrs = []);
end;

{-------------------------------------------------------------------------------}
function TPgType.GetEnumValue(AOid: Oid): String;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to FEnums.Count - 1 do
    if Oid(FEnums.Ints[i]) = AOid then begin
      Result := FEnums[i];
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
{ TPgTypesManager                                                               }
{-------------------------------------------------------------------------------}
constructor TPgTypesManager.Create(AConnection: TPgConnection);
begin
  inherited Create;
  FConnection := AConnection;
  FTypes := TFDObjList.Create;
  // pg_* - records, query the dictionary
  // _cstring - pseudo type
  // record - pseudo types
  // cstring, any*, trigger, internal, opaque - pseudo types
  // txid_snapshot - ?
  // ts*, gts*, reg* - ?

  AddBase(SQL_BOOL,       'bool',           0,  SizeOf(Byte),             SizeOf(WordBool),   []);
  AddBase(SQL_BYTEA,      'bytea',          0,  0,                        0,                  [paBlob]);
  AddBase(SQL_CHAR,       'char',           0,  0,                        0,                  [paString, paFixed]);
  AddBase(SQL_NAME,       'name',  NAMEMAXLEN,  0,                        0,                  [paString]);
  AddBase(SQL_INT8,       'int8',           0,  SizeOf(Int64),            SizeOf(Int64),      []);
  AddBase(SQL_INT2,       'int2',           0,  SizeOf(SmallInt),         SizeOf(SmallInt),   []);
  AddBase(SQL_INT4,       'int4',           0,  SizeOf(Integer),          SizeOf(Integer),    []);
  AddBase(SQL_REGPROC,    'regproc',        0,  SizeOf(Oid),              SizeOf(Oid),        [paOID]);
  AddBase(SQL_TEXT,       'text',           0,  0,                        0,                  [paBlob]);
  AddBase(SQL_OID,        'oid',            0,  SizeOf(Oid),              SizeOf(Oid),        [paOID]);
  AddBase(SQL_TID,        'tid',            0,  6,                        SizeOf(Int64),      [paOID]);
  AddBase(SQL_XID,        'xid',            0,  SizeOf(Oid),              SizeOf(Oid),        [paOID]);
  AddBase(SQL_CID,        'cid',            0,  SizeOf(Oid),              SizeOf(Oid),        [paOID]);
  AddBase(SQL_JSON,       'json',           0,  0,                        0,                  [paBlob, paCast]);
  AddBase(SQL_XML,        'xml',            0,  0,                        0,                  [paBlob]);
  AddBase(SQL_NODE_TREE,  'pg_node_tree',   0,  0,                        0,                  [paBlob]);
  AddBase(SQL_SMGR,       'smgr',           0,  SizeOf(Word),             SizeOf(Word),       []);
  AddBase(SQL_CIDR,       'cidr',           0,  20,                       20,                 [paString, paFixed]);
  AddBase(SQL_FLOAT4,     'float4',         0,  SizeOf(Single),           SizeOf(Single),     []);
  AddBase(SQL_FLOAT8,     'float8',         0,  SizeOf(Double),           SizeOf(Double),     []);
  AddBase(SQL_ABSTIME,    'abstime',        0,  SizeOf(Integer),          SizeOf(TSQLTimeStamp), []);
  AddBase(SQL_RELTIME,    'reltime',        0,  SizeOf(Integer),          SizeOf(TSQLTimeStamp), []);
  AddBase(SQL_TINTERVAL,  'tinterval',      0,  0,                        0,                  []);
  AddBase(SQL_UNKNOWN,    'unknown',        0,  0,                        0,                  [paString]);
  AddBase(SQL_CASH,       'money',          0,  0,                        SizeOf(Currency),   []);
  AddBase(SQL_MACADDR,    'macaddr',        0,  6,                        6,                  []);
  AddBase(SQL_INET,       'inet',           0,  20,                       20,                 [paString, paFixed]);
  AddBase(SQL_ACLITEM,    'aclitem',        0,  12,                       12,                 []);
  AddBase(SQL_BPCHAR,     'bpchar',         0,  0,                        0,                  [paString, paFixed]);
  AddBase(SQL_VARCHAR,    'varchar',        0,  0,                        0,                  [paString]);
  AddBase(SQL_DATE,       'date',           0,  SizeOf(Integer),          SizeOf(Integer),    []);
  AddBase(SQL_TIME,       'time',           0,  SizeOf(TPgTimeStampBuf),  SizeOf(Integer),    []);
  AddBase(SQL_TIMESTAMP,  'timestamp',      0,  SizeOf(TPgTimeStampBuf),  SizeOf(TSQLTimeStamp), []);
  AddBase(SQL_TIMESTAMPTZ,'timestamptz',    0,  SizeOf(TPgTimeStampBuf),  SizeOf(TSQLTimeStamp), []);
  AddBase(SQL_INTERVAL,   'interval',       0,  SizeOf(TPgTimeIntervalBuf),SizeOf(TFDSQLTimeInterval), []);
  AddBase(SQL_TIMETZ,     'timetz',         0,  SizeOf(TPgTimeStampBuf),  SizeOf(Integer),    []);
  AddBase(SQL_BIT,        'bit',            0,  0,                        0,                  [paString, paFixed]);
  AddBase(SQL_VARBIT,     'varbit',         0,  0,                        0,                  [paString]);
  AddBase(SQL_NUMERIC,    'numeric',        0,  8 + (MaxFMTBcdFractionSize div 4) * SizeOf(Word),
                                                                          SizeOf(TBcd),     []);
  AddBase(SQL_REFCURSOR,  'refcursor',      0,  0,                        0,                  [paString]);
  AddBase(SQL_REGPROCEDURE,'regprocedure',  0,  SizeOf(Oid),              SizeOf(Oid),        [paOID]);
  AddBase(SQL_REGOPER,    'regoper',        0,  SizeOf(Oid),              SizeOf(Oid),        [paOID]);
  AddBase(SQL_REGOPERATOR,'regoperator',    0,  SizeOf(Oid),              SizeOf(Oid),        [paOID]);
  AddBase(SQL_REGCLASS,   'regclass',       0,  SizeOf(Oid),              SizeOf(Oid),        [paOID]);
  AddBase(SQL_REGTYPE,    'regtype',        0,  SizeOf(Oid),              SizeOf(Oid),        [paOID]);
  AddBase(SQL_RECORD,     'record',         0,  0,                        0,                  [paRecord]);
  AddBase(SQL_ANY,        'any',            0,  0,                        0,                  [paString]);
  AddBase(SQL_VOID,       'void',           0,  0,                        0,                  [paString]);
  AddBase(SQL_UUID,       'uuid',           0,  SizeOf(TGUID),            SizeOf(TGUID),      []);
  AddBase(SQL_JSONB,      'jsonb',          0,  0,                        0,                  [paBlob, paCast]);

  AddArray(SQL_INT2VECTOR, 'int2vector',     SQL_INT2);
  AddArray(SQL_OIDVECTOR,  'oidvector',      SQL_OID);
  AddArray(199,            '_json',          SQL_JSON);
  AddArray(SQL_XML + 1,    '_xml',           SQL_XML);
  AddArray(SQL_POINT,      'point',          SQL_FLOAT8, 2);
  AddArray(SQL_LSEG,       'lseg',           SQL_POINT, 2);
  AddArray(SQL_PATH,       'path',           SQL_POINT);
  AddArray(SQL_BOX,        'box',            SQL_POINT, 2);
  AddArray(SQL_POLYGON,    'polygon',        SQL_POINT);
  AddArray(SQL_LINE,       'line',           SQL_FLOAT8, 4);
  AddArray(SQL_LINE + 1,   '_line',          SQL_LINE);
  AddArray(SQL_CIDR + 1,   '_cidr',          SQL_CIDR);
  AddArray(SQL_CIRCLE,     'circle',         SQL_FLOAT8, 3);
  AddArray(SQL_CIRCLE + 1, '_circle',        SQL_CIRCLE);
  AddArray(SQL_CASH + 1,   '_money',         SQL_CASH);
  AddArray(1000,           '_bool',          SQL_BOOL);
  AddArray(1001,           '_bytea',         SQL_BYTEA);
  AddArray(1002,           '_char',          SQL_CHAR);
  AddArray(1003,           '_name',          SQL_NAME);
  AddArray(1005,           '_int2',          SQL_INT2);
  AddArray(1006,           '_int2vector',    SQL_INT2VECTOR);
  AddArray(1007,           '_int4',          SQL_INT4);
  AddArray(1008,           '_regproc',       SQL_REGPROC);
  AddArray(1009,           '_text',          SQL_TEXT);
  AddArray(1010,           '_tid',           SQL_TID);
  AddArray(1011,           '_xid',           SQL_XID);
  AddArray(1012,           '_cid',           SQL_CID);
  AddArray(1013,           '_oidvector',     SQL_OIDVECTOR);
  AddArray(1014,           '_bpchar',        SQL_BPCHAR);
  AddArray(1015,           '_varchar',       SQL_VARCHAR);
  AddArray(1016,           '_int8',          SQL_INT8);
  AddArray(1017,           '_point',         SQL_POINT);
  AddArray(1018,           '_lseg',          SQL_LSEG);
  AddArray(1019,           '_path',          SQL_PATH);
  AddArray(1020,           '_box',           SQL_BOX);
  AddArray(1021,           '_float4',        SQL_FLOAT4);
  AddArray(1022,           '_float8',        SQL_FLOAT8);
  AddArray(1023,           '_abstime',       SQL_ABSTIME);
  AddArray(1024,           '_reltime',       SQL_RELTIME);
  AddArray(1025,           '_tinterval',     SQL_TINTERVAL);
  AddArray(1027,           '_polygon',       SQL_POLYGON);
  AddArray(1028,           '_oid',           SQL_OID);
  AddArray(1034,           '_aclitem',       1033);
  AddArray(1040,           '_macaddr',       SQL_MACADDR);
  AddArray(1041,           '_inet',          SQL_INET);
  AddArray(SQL_TIMESTAMP+1,'_timestamp',     SQL_TIMESTAMP);
  AddArray(1182,           '_date',          SQL_DATE);
  AddArray(1183,           '_time',          SQL_TIME);
  AddArray(SQL_TIMESTAMPTZ+1,'_timestamptz', SQL_TIMESTAMPTZ);
  AddArray(SQL_INTERVAL + 1,'_interval',     SQL_INTERVAL);
  AddArray(1231,           '_numeric',       SQL_NUMERIC);
  AddArray(SQL_TIMETZ + 1, '_timetz',        SQL_TIMETZ);
  AddArray(SQL_BIT + 1,    '_bit',           SQL_BIT);
  AddArray(SQL_VARBIT + 1, '_varbit',        SQL_VARBIT);
  AddArray(2201,           '_refcursor',     SQL_REFCURSOR);
  AddArray(2207,           '_regprocedure',  SQL_REGPROCEDURE);
  AddArray(2208,           '_regoper',       SQL_REGOPER);
  AddArray(2209,           '_regoperator',   SQL_REGOPERATOR);
  AddArray(2210,           '_regclass',      SQL_REGCLASS);
  AddArray(2211,           '_regtype',       SQL_REGTYPE);
  AddArray(SQL_ANY + 1,    'anyarray',       SQL_ANY);
  AddArray(2287,           '_record',        SQL_RECORD);
  AddArray(SQL_UUID + 1,   '_uuid',          SQL_UUID);
  AddArray(3807,           '_jsonb',         SQL_JSONB);
end;

{-------------------------------------------------------------------------------}
destructor TPgTypesManager.Destroy;
var
  i: Integer;
begin
  for i := 0 to FTypes.Count - 1 do
    FDFree(TPgType(FTypes[i]));
  FDFreeAndNil(FTypes);
  FConnection := nil;
  FLastType := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TPgTypesManager.DescribeError(const AId, AReason: String);
begin
  FDException(FConnection.OwningObj, [S_FD_LPhys, S_FD_PGId],
    er_FD_PgCannotDescribeType, [AId, AReason]);
end;

{-------------------------------------------------------------------------------}
class procedure TPgTypesManager.GetDefaults(ATypeOid: Oid; out ALen, APrec, AScale: Integer);
begin
  ALen := 0;
  APrec := 0;
  AScale := 0;
  case ATypeOid of
  SQL_CHAR,
  SQL_BPCHAR:  ALen := 1024;
  SQL_NAME:    ALen := NAMEMAXLEN;
  SQL_VARCHAR,
  SQL_ACLITEM: ALen := 8190;
  SQL_TEXT,
  SQL_JSON,
  SQL_JSONB,
  SQL_XML,
  SQL_NODE_TREE,
  SQL_BYTEA,
  SQL_ANY:     ALen := C_FD_DefMaxStrSize;
  SQL_MACADDR: ALen := 6;
  SQL_CIDR,
  SQL_INET:    ALen := 20;
  SQL_NUMERIC: APrec := 64;
  SQL_BIT,
  SQL_VARBIT:  ALen := 1024;
  SQL_TIME,
  SQL_TIMETZ,
  SQL_TIMESTAMP,
  SQL_TIMESTAMPTZ,
  SQL_INTERVAL: AScale := 0;
  end;
end;

{-------------------------------------------------------------------------------}
class procedure TPgTypesManager.DecodeModifier(ATypeOid: Oid; AModifier: Integer;
  out ALen, APrec, AScale: Integer);
begin
  case ATypeOid of
  SQL_CHAR,
  SQL_BPCHAR,
  SQL_NAME,
  SQL_VARCHAR,
  SQL_TEXT,
  SQL_JSON,
  SQL_JSONB,
  SQL_XML,
  SQL_NODE_TREE,
  SQL_BYTEA,
  SQL_ANY,
  SQL_ACLITEM,
  SQL_MACADDR,
  SQL_CIDR,
  SQL_INET:
    if AModifier >= VARHDRSZ then
      ALen := AModifier - VARHDRSZ;
  SQL_NUMERIC:
    if AModifier <> -1 then begin
      APrec := (AModifier - VARHDRSZ) shr 16 and $FFFF;
      AScale := (AModifier - VARHDRSZ) and $FFFF;
    end;
  SQL_BIT,
  SQL_VARBIT:
    if AModifier <> -1 then
      ALen := (AModifier + 7) div 8;
  SQL_TIME,
  SQL_TIMETZ,
  SQL_TIMESTAMP,
  SQL_TIMESTAMPTZ,
  SQL_INTERVAL:
    if AModifier <> -1 then
      AScale := AModifier;
  end;
end;

{-------------------------------------------------------------------------------}
function TPgTypesManager.FindType(AId: OID; AExact: Boolean): Integer;
var
  iFirstNo, iLastNo: Integer;
  iOid: Oid;
begin
  iFirstNo := 0;
  iLastNo := FTypes.Count - 1;
  while iFirstNo <= iLastNo do begin
    Result := (iFirstNo + iLastNo) div 2;
    iOid := TPgType(FTypes[Result]).Id;
    if AId < iOid then
      iLastNo := Result - 1
    else if AId > iOid then
      iFirstNo := Result + 1
    else
      Exit;
  end;
  if AExact then
    Result := -1
  else if iFirstNo >= FTypes.Count then
    Result := FTypes.Count
  else if iLastNo < 0 then
    Result := -1
  else begin
    Result := iLastNo;
    while (TPgType(FTypes[Result]).Id <= AId) and (Result < FTypes.Count) do
      Inc(Result);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgTypesManager.AddType(AType: TPgType);
var
  i: Integer;
begin
  i := FindType(AType.Id, False);
  FTypes.Insert(i, AType);
end;

{-------------------------------------------------------------------------------}
function TPgTypesManager.AddArray(AId: OID; const AName: String; ABaseOid: OID;
  AFixedLen: Integer): TPgType;
var
  oMbr: TPgMember;
begin
  Result := TPgType.Create;
  Result.FId := AId;
  Result.FName := AName;
  Result.FFixedLen := AFixedLen;
  Result.FPGSize := 0;
  Result.FFDSize := 0;
  Result.FAttrs := [paArray];
  if AFixedLen > 0 then
    Include(Result.FAttrs, paFixed);
  SetLength(Result.FMembers, 1);
  oMbr := TPgMember.Create;
  Result.FMembers[0] := oMbr;
  oMbr.FOid := ABaseOid;
  oMbr.FRef := Types[ABaseOid];
  AddType(Result);
end;

{-------------------------------------------------------------------------------}
function TPgTypesManager.AddBase(AId: OID; const AName: String; AFixedLen,
  APGSize, AFDSize: Integer; AAttrs: TPgTypeAttrs): TPgType;
begin
  Result := TPgType.Create;
  Result.FId := AId;
  Result.FName := AName;
  Result.FFixedLen := AFixedLen;
  Result.FPGSize := APGSize;
  Result.FFDSize := AFDSize;
  Result.FAttrs := AAttrs;
  Result.FMembers := nil;
  AddType(Result);
end;

{-------------------------------------------------------------------------------}
procedure TPgTypesManager.Connected;
var
  iCashSz: Integer;
begin
  if FConnection.ServerVersion >= svPGSQL080300 then
    iCashSz := SizeOf(Int64)
  else
    iCashSz := SizeOf(Integer);
  Types[SQL_CASH].FPgSize := iCashSz;
end;

{-------------------------------------------------------------------------------}
function TPgTypesManager.Describe(AOid: OID): TPgType;
var
  oStmt: TPgStatement;
  sId, sName, sType: String;
  iRelId, iElem, iArray, iBase: Oid;
  i, iMem, iNum, iTypeMod: Integer;
  lNotNull: WordBool;
  oMbr: TPgMember;
begin
  Result := nil;
  oStmt := TPgStatement.Create(FConnection, FConnection.OwningObj);
  try
    sId := IntToStr(AOid);
    oStmt.PrepareSQL('SELECT TYPNAME, TYPRELID, TYPELEM, TYPARRAY, TYPBASETYPE, TYPTYPE ' +
                     'FROM PG_CATALOG.PG_TYPE ' +
                     'WHERE OID = ' + sId);
    oStmt.Execute;
    oStmt.DescribeFields;
    if not oStmt.Fetch then
      DescribeError(sId, 'Type is not found');
    sName := oStmt.Fields[0].GetAsString;
    iRelId := 0;
    oStmt.Fields[1].GetData(@iRelId);
    iElem := 0;
    oStmt.Fields[2].GetData(@iElem);
    iArray := 0;
    oStmt.Fields[3].GetData(@iArray);
    iBase := 0;
    oStmt.Fields[4].GetData(@iBase);
    sType := oStmt.Fields[5].GetAsString;

    if iBase <> 0 then
      Result := GetTypes(iBase)
    else if (iRelId = 0) and (iElem = 0) and (sType <> 'e') and (sType <> 'r') then
      if FConnection.UnknownFormat = 0 then
        DescribeError(sId, 'Complex type must be an array, composite, enum or range type')
      else
        Result := GetTypes(FConnection.UnknownFormat);
    if Result <> nil then
      Exit;

    // array type
    if iElem <> 0 then
      Result := AddArray(AOid, sName, iElem)

    // enum type
    else if sType = 'e' then begin
      oStmt.Unprepare;
      oStmt.PrepareSQL('SELECT OID, ENUMLABEL ' +
                       'FROM PG_CATALOG.PG_ENUM ' +
                       'WHERE ENUMTYPID = ' + sId +
                       'ORDER BY OID');
      oStmt.Execute;
      oStmt.DescribeFields;

      Result := AddBase(AOid, sName, 0, 0, 0, [paString, paEnum]);

      while oStmt.Fetch do begin
        sName := oStmt.Fields[1].GetAsString;
        oStmt.Fields[0].GetData(@iElem);
        Result.Enums.AddInt(sName, iElem);
      end;
    end

    // range type
    else if sType = 'r' then begin
      oStmt.Unprepare;
      oStmt.PrepareSQL('SELECT RNGSUBTYPE ' +
                       'FROM PG_CATALOG.PG_RANGE ' +
                       'WHERE RNGTYPID = ' + sId);
      oStmt.Execute;
      oStmt.DescribeFields;
      oStmt.Fetch;
      oStmt.Fields[0].GetData(@iElem);

      Result := AddBase(AOid, sName, 0, 0, 0, [paRange]);
      SetLength(Result.FMembers, 3);

      oMbr := TPgMember.Create;
      Result.FMembers[0] := oMbr;
      oMbr.FName := 'lbound';
      oMbr.FOid := iElem;

      oMbr := TPgMember.Create;
      Result.FMembers[1] := oMbr;
      oMbr.FName := 'hbound';
      oMbr.FOid := iElem;

      oMbr := TPgMember.Create;
      Result.FMembers[2] := oMbr;
      oMbr.FName := 'flags';
      oMbr.FOid := SQL_INT4;

      for i := 0 to 2 do begin
        oMbr := Result.FMembers[i];
        GetDefaults(oMbr.FOid, oMbr.FLen, oMbr.FPrec, oMbr.FScale);
        oMbr.FRef := Types[oMbr.FOid];
        Include(oMbr.FAttrs, caReadOnly);
      end;
    end

    // composite type
    else begin
      oStmt.Unprepare;
      oStmt.PrepareSQL('SELECT ATTNAME, ATTTYPID, ATTNUM, ATTTYPMOD, ATTNOTNULL ' +
                       'FROM PG_CATALOG.PG_ATTRIBUTE ' +
                       'WHERE ATTRELID = ' + IntToStr(iRelId) + ' AND ATTNUM > 0 ' +
                       'ORDER BY ATTNUM');
      oStmt.Execute;
      oStmt.DescribeFields;

      Result := AddBase(AOid, sName, 0, 0, 0, [paRecord]);
      SetLength(Result.FMembers, oStmt.RowsSelected);
      for i := 0 to oStmt.RowsSelected - 1 do
        Result.FMembers[i] := TPgMember.Create;

      iMem := 0;
      while oStmt.Fetch do begin
        oMbr := Result.FMembers[iMem];
        oMbr.FName := oStmt.Fields[0].GetAsString;
        oStmt.Fields[1].GetData(@oMbr.FOid);
        oMbr.FRef := Types[oMbr.FOid];
        oStmt.Fields[2].GetData(@iNum);
        oStmt.Fields[3].GetData(@iTypeMod);
        oStmt.Fields[4].GetData(@lNotNull);
        oMbr.FAttrs := [];
        if not lNotNull then
          Include(oMbr.FAttrs, caAllowNull);
        if iNum <= 0 then
          Include(oMbr.FAttrs, caReadOnly);
        FConnection.TypesManager.DecodeModifier(oMbr.FOid, iTypeMod, oMbr.FLen,
          oMbr.FPrec, oMbr.FScale);
        Inc(iMem);
      end;
    end;

  finally
    FDFree(oStmt);
  end;
end;

{-------------------------------------------------------------------------------}
function TPgTypesManager.GetTypes(AOid: OID): TPgType;
var
  i: Integer;
begin
  if (FLastType = nil) or (FlastType.Id <> AOid) then begin
    i := FindType(AOid, True);
    if i <> -1 then
      FLastType := TPgType(FTypes[i])
    else
      FLastType := Describe(AOid);
  end;
  Result := FLastType;
end;

{-------------------------------------------------------------------------------}
function TPgTypesManager.TypeByName(const AName: String): TPgType;
var
  i: Integer;
  oStmt: TPgStatement;
  iTypeId: Oid;
begin
  for i := 0 to FTypes.Count - 1 do
    if CompareText(TPgType(FTypes[i]).Name, AName) = 0 then
      Exit(TPgType(FTypes[i]));

  oStmt := TPgStatement.Create(FConnection, FConnection.OwningObj);
  try
    oStmt.PrepareSQL('SELECT OID ' +
                     'FROM PG_CATALOG.PG_TYPE ' +
                     'WHERE LOWER(TYPNAME) = ''' + LowerCase(AName) + '''');
    oStmt.Execute;
    oStmt.DescribeFields;
    if not oStmt.Fetch then
      DescribeError(AName, 'Type is not found');
    iTypeId := 0;
    oStmt.Fields[0].GetData(@iTypeId);
    Result := Describe(iTypeId);
  finally
    FDFree(oStmt);
  end;
end;

{-------------------------------------------------------------------------------}
function TPgTypesManager.GetArrays(AMemberOid: OID): TPgType;
var
  i: Integer;
  oType: TPgType;
begin
  GetTypes(AMemberOid);
  Result := nil;
  for i := 0 to FTypes.Count - 1 do begin
    oType := TPgType(FTypes[i]);
    if (paArray in oType.Attrs) and (oType.Members[0].TypeOid = AMemberOid) then begin
      Result := oType;
      Exit;
    end;
  end;
  if Result = nil then
    DescribeError(IntToStr(AMemberOid), 'Array type of specified member is not found');
end;

{-------------------------------------------------------------------------------}
{ TPgConnection                                                                 }
{-------------------------------------------------------------------------------}
constructor TPgConnection.Create(AEnv: TPgEnv; AOwningObj: TObject);
begin
  inherited Create(AEnv, AOwningObj);
  FOwnHandle := True;
  FBuffer := TFDBuffer.Create;
  FEncoder := TFDEncoder.Create(FBuffer);
  FTypesManager := TPgTypesManager.Create(Self);
  FPStmtIDCounter := @FStmtIDCounter;
end;

{-------------------------------------------------------------------------------}
constructor TPgConnection.CreateUsingHandle(AEnv: TPgEnv; AHandle: PPGconn;
  APStmtIDCounter: PInteger; AOwningObj: TObject);
begin
  inherited Create(AEnv, AOwningObj);
  FOwnHandle := False;
  FHandle := AHandle;
  FBuffer := TFDBuffer.Create;
  FEncoder := TFDEncoder.Create(FBuffer);
  FTypesManager := TPgTypesManager.Create(Self);
  FPStmtIDCounter := APStmtIDCounter;
end;

{-------------------------------------------------------------------------------}
destructor TPgConnection.Destroy;
begin
  if FHandle <> nil then
    Disconnect;
  FDFreeAndNil(FEncoder);
  FDFreeAndNil(FBuffer);
  FDFreeAndNil(FTypesManager);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
// this function checks connection state and retrieves connection error
procedure TPgConnection.Check;

  procedure Error;
  begin
    DoError(Encoder.Decode(Lib.FPQerrorMessage(FHandle), -1), Lib.FPQstatus(FHandle));
  end;

begin
  if Lib.FPQstatus(FHandle) = CONNECTION_OK then
    Exit;
  Error;
end;

{-------------------------------------------------------------------------------}
function TPgConnection.CheckForInput: Boolean;
{$IFDEF MSWINDOWS}
var
  iSock: Integer;
  rReadFD: TFDSet;
  rTime: TTimeVal;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  iSock := Lib.FPQsocket(FHandle);
  if iSock < 0 then begin
    Result := False;
    Exit;
  end;

  FD_ZERO(rReadFD);
  FD_SET(iSock, rReadFD);
  rTime.tv_sec := 0;
  rTime.tv_usec := 100000;
  Result := (select(iSock + 1, @rReadFD, nil, nil, @rTime) <> SOCKET_ERROR) and
            FD_ISSET(iSock, rReadFD);
  if Result then
{$ENDIF}
{$IFDEF POSIX}
  Sleep(5);
  Result := True;
{$ENDIF}
    if Lib.FPQconsumeInput(FHandle) = 0 then
      Check;
end;

{-------------------------------------------------------------------------------}
function TPgConnection.ReadNotifies(out AName: String;
  out AProcID: Integer; out AParameter: String): Boolean;
var
  pEvent: PPGnotify;
begin
  pEvent := Lib.FPQnotifies(FHandle);
  if pEvent <> nil then begin
    AName := Encoder.Decode(pEvent^.relname, -1, ecANSI);
    AProcID := pEvent^.be_pid;
    AParameter := Encoder.Decode(pEvent^.extra, -1, ecANSI);
    Lib.FPQfreemem(pEvent);
    Result := True;
  end
  else
    Result := False;
end;

{-------------------------------------------------------------------------------}
procedure TPgConnection.ReadResultError(AHandle: PPGresult; AException: EPgNativeException);
begin
  AException.AppendError(
    Encoder.Decode(Lib.FPQresultErrorField(AHandle, PG_DIAG_SEVERITY), -1),
    Encoder.Decode(Lib.FPQresultErrorField(AHandle, PG_DIAG_SQLSTATE), -1),
    Encoder.Decode(Lib.FPQresultErrorField(AHandle, PG_DIAG_MESSAGE_PRIMARY), -1),
    Encoder.Decode(Lib.FPQresultErrorField(AHandle, PG_DIAG_MESSAGE_DETAIL), -1),
    Encoder.Decode(Lib.FPQresultErrorField(AHandle, PG_DIAG_MESSAGE_HINT), -1),
    StrToIntDef(Encoder.Decode(Lib.FPQresultErrorField(AHandle, PG_DIAG_STATEMENT_POSITION), -1), 0),
    StrToIntDef(Encoder.Decode(Lib.FPQresultErrorField(AHandle, PG_DIAG_INTERNAL_POSITION), -1), 0),
    Encoder.Decode(Lib.FPQresultErrorField(AHandle, PG_DIAG_INTERNAL_QUERY), -1),
    Encoder.Decode(Lib.FPQresultErrorField(AHandle, PG_DIAG_CONTEXT), -1),
    Encoder.Decode(Lib.FPQresultErrorField(AHandle, PG_DIAG_SCHEMA_NAME), -1),
    Encoder.Decode(Lib.FPQresultErrorField(AHandle, PG_DIAG_TABLE_NAME), -1),
    Encoder.Decode(Lib.FPQresultErrorField(AHandle, PG_DIAG_COLUMN_NAME), -1),
    Encoder.Decode(Lib.FPQresultErrorField(AHandle, PG_DIAG_DATATYPE_NAME), -1),
    Encoder.Decode(Lib.FPQresultErrorField(AHandle, PG_DIAG_CONSTRAINT_NAME), -1),
    Encoder.Decode(Lib.FPQresultErrorField(AHandle, PG_DIAG_SOURCE_FILE), -1),
    StrToIntDef(Encoder.Decode(Lib.FPQresultErrorField(AHandle, PG_DIAG_SOURCE_LINE), -1), 0),
    Encoder.Decode(Lib.FPQresultErrorField(AHandle, PG_DIAG_SOURCE_FUNCTION), -1)
  );
end;

{-------------------------------------------------------------------------------}
// call this function to check result state and get server info
procedure TPgConnection.CheckResult(AHandle: PPGresult; AOwningObj: TObject);
var
  iStatus: Integer;

  procedure Error;
  var
    oEx: EPgNativeException;
  begin
    oEx := EPgNativeException.Create(er_FD_PgGeneral,
      FDExceptionLayers([S_FD_LPhys, S_FD_PgId, 'libpq']));
    ReadResultError(AHandle, oEx);
{$IFDEF FireDAC_MONITOR}
    Env.Trace(ekError, esProgress, 'ERROR: ' + oEx[0].Message, ['Status', iStatus]);
{$ENDIF}
    FDException(AOwningObj, oEx {$IFDEF FireDAC_Monitor}, Env.Tracing {$ENDIF});
  end;

begin
  if AHandle = nil then
    Check
  else begin
    iStatus := Lib.FPQresultStatus(AHandle);
    if iStatus in [PGRES_COMMAND_OK, PGRES_TUPLES_OK, PGRES_COPY_IN] then
      Exit;
    Error;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgConnection.ClearNotices;
begin
  FDFreeAndNil(FNotices);
end;

{-------------------------------------------------------------------------------}
procedure TPgConnection.DoNoticeReceive(AHandle: PPGresult);
begin
  if FNotices = nil then
    FNotices := EPgNativeException.Create(er_FD_PgGeneral,
      FDExceptionLayers([S_FD_LPhys, S_FD_PgId, 'libpq']));
  ReadResultError(AHandle, FNotices);
end;

{-------------------------------------------------------------------------------}
procedure PQnoticeReciever(Aarg: Pointer; Ares: PPGresult); cdecl;
begin
  TPgConnection(Aarg).DoNoticeReceive(Ares);
end;

{-------------------------------------------------------------------------------}
procedure TPgConnection.Connect(const AConnStr: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  var
    sConnStr: String;
    i1, i2: Integer;
  begin
    sConnStr := AConnStr;
    i1 := Pos('password=', LowerCase(sConnStr));
    if i1 <> 0 then begin
      i2 := Pos(' ', sConnStr, i1);
      if i2 = 0 then
        i2 := Length(sConnStr) + 1;
      sConnStr := Copy(sConnStr, 1, i1 + 8) + '***' + Copy(sConnStr, i2, Length(sConnStr));
    end;
    Env.Trace(sPQconnectdb, ['@ConnInfo', sConnStr, 'Result', FHandle]);
  end;
{$ENDIF}

var
  sConnStr: TFDByteString;
begin
  FIntegerDateTimes := MAXINT;
  FServerVersion := 0;
  try
    sConnStr := Encoder.Encode(AConnStr, ecUTF8);
    FHandle := Lib.FPQconnectdb(PFDAnsiString(PByte(sConnStr)));
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    Check;
    // Register notice receiver
    if FOwnHandle then
      FDefaultNoticeReceiver := Lib.FPQsetNoticeReceiver(FHandle, PQnoticeReciever, Self);
    FTypesManager.Connected;
  except
    Disconnect;
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgConnection.Disconnect;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sPQfinish, ['ppgconn', FHandle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  ClearNotices;
  if (FHandle = nil) or not FOwnHandle then
    Exit;
  Lib.FPQfinish(FHandle);
  FHandle := nil;
end;

{-------------------------------------------------------------------------------}
function TPgConnection.GetParameterStatus(const AParam: String): String;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sPQparameterStatus, ['conn', FHandle, 'ParamName', AParam, 'Result', Result]);
  end;
{$ENDIF}

var
  sParam: TFDByteString;
begin
  sParam := FEncoder.Encode(AParam, ecANSI);
  Result := FEncoder.Decode(Lib.FPQparameterStatus(FHandle, PFDAnsiString(PByte(sParam))), -1);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TPgConnection.GetTransactionStatus: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sPQtransactionStatus, ['conn', FHandle, 'Result', Result]);
  end;
{$ENDIF}

begin
  Result := Lib.FPQtransactionStatus(FHandle);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TPgConnection.GetServerVersion: TFDVersion;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sPQserverVersion, ['conn', FHandle, 'Result', FServerVersion]);
  end;
{$ENDIF}

begin
  if FServerVersion = 0 then
    if Assigned(Lib.FPQserverVersion) then begin
      FServerVersion := TFDVersion(Lib.FPQserverVersion(FHandle)) * 10000;
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then Trace1;
{$ENDIF}
      Check;
    end
    else
      FServerVersion := FDVerStr2Int(SERVER_VERSION);
  Result := FServerVersion;
end;

{-------------------------------------------------------------------------------}
function TPgConnection.GetSERVER_VERSION: String;
begin
  Result := GetParameterStatus('server_version');
end;

{-------------------------------------------------------------------------------}
function TPgConnection.GetSERVER_ENCODING: String;
begin
  Result := GetParameterStatus('server_encoding');
end;

{-------------------------------------------------------------------------------}
function TPgConnection.GetCLIENT_ENCODING: String;
begin
  Result := GetParameterStatus('client_encoding');
end;

{-------------------------------------------------------------------------------}
function TPgConnection.GetIS_SUPERUSER: String;
begin
  Result := GetParameterStatus('is_superuser');
end;

{-------------------------------------------------------------------------------}
function TPgConnection.GetSESSION_AUTHORIZATION: String;
begin
  Result := GetParameterStatus('session_authorization');
end;

{-------------------------------------------------------------------------------}
function TPgConnection.GetDATESTYLE: String;
begin
  Result := GetParameterStatus('DateStyle');
end;

{-------------------------------------------------------------------------------}
function TPgConnection.GetTIMEZONE: String;
begin
  Result := GetParameterStatus('TimeZone');
end;

{-------------------------------------------------------------------------------}
function TPgConnection.GetINTEGER_DATETIMES: String;
begin
  Result := GetParameterStatus('integer_datetimes');
end;

{-------------------------------------------------------------------------------}
function TPgConnection.GetIntegerDateTimes: Boolean;
begin
  if FIntegerDateTimes = MAXINT then
    FIntegerDateTimes := CompareText(INTEGER_DATETIMES, 'on');
  Result := FIntegerDateTimes = 0;
end;

{-------------------------------------------------------------------------------}
function TPgConnection.GetSTANDARD_CONFORMING_STRINGS: String;
begin
  Result := GetParameterStatus('standard_conforming_strings');
end;

{-------------------------------------------------------------------------------}
procedure TPgConnection.ExecuteQuery(ASQL: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sPQexec, ['ppgconn', FHandle, 'sql', ASQL]);
  end;
{$ENDIF}

var
  hResult: PPGresult;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  ClearNotices;
  hResult := Lib.FPQexec(FHandle, PByte(Encoder.Encode(ASQL)));
  try
    CheckResult(hResult, OwningObj);
  finally
    Lib.FPQclear(hResult);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgConnection.Abort;
var
  pCancel: PPGcancel;
  iCancelRes: Integer; 

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sPQcancel, ['conn', FHandle, 'FPQcancel', pCancel]);
  end;
{$ENDIF}

begin
  if not Assigned(Lib.FPQgetCancel) then
    Exit;
  pCancel := Lib.FPQgetCancel(FHandle);
  try
    FBuffer.Check(cancel_buf_size);
    iCancelRes := Lib.FPQcancel(pCancel, FBuffer.FBuffer, cancel_buf_size);
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    if iCancelRes = 0 then
      DoError(Encoder.Decode(PByte(FBuffer.FBuffer), -1), Lib.FPQstatus(FHandle));
  finally
    Lib.FPQfreeCancel(pCancel);
  end;
end;

{-------------------------------------------------------------------------------}
function TPgConnection.GetClientEncoding: String;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sPQClientEncoding, ['conn', FHandle, 'Result', Result]);
  end;
{$ENDIF}

begin
  Result := Encoder.Decode(PByte(Lib.Fpg_encoding_to_char(
    Lib.FPQclientEncoding(FHandle))), -1);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TPgConnection.SetClientEncoding(const AValue: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sPQsetClientEncoding, ['conn', FHandle, 'encoding', AValue]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Lib.FPQsetClientEncoding(FHandle, PFDAnsiString(PByte(Encoder.Encode(AValue))));
  Check;
end;

{-------------------------------------------------------------------------------}
function TPgConnection.GenerateName: String;
begin
  Inc(FPStmtIDCounter^);
  Result := Format('%dSTM', [FPStmtIDCounter^]);
end;

{-------------------------------------------------------------------------------}
{ Data conversion                                                               }
{-------------------------------------------------------------------------------}
procedure MoveRotate(ASrc, ADest: Pointer; ALen: Cardinal);
var
  pSrc, pDest: PByte;
begin
  pSrc := ASrc;
  pDest := PByte(ADest) + ALen - 1;
  while ALen > 0 do begin
    pDest^ := pSrc^;
    Inc(pSrc);
    Dec(pDest);
    Dec(ALen);
  end;
end;

{-------------------------------------------------------------------------------}
function ReadWord(ABuffer: Pointer; AOffset: Cardinal = 0): Word;
begin
  MoveRotate(Pointer(NativeUInt(ABuffer) + AOffset), @Result, SizeOf(Result));
end;

{-------------------------------------------------------------------------------}
procedure WriteWord(ABuffer: Pointer; AOffset: Cardinal; AValue: Word);
begin
  MoveRotate(@AValue, Pointer(NativeUInt(ABuffer) + AOffset), SizeOf(AValue));
end;

{-------------------------------------------------------------------------------}
function ReadInteger(ABuffer: Pointer; AOffset: Cardinal = 0): Integer;
begin
  MoveRotate(Pointer(NativeUInt(ABuffer) + AOffset), @Result, SizeOf(Result));
end;

{-------------------------------------------------------------------------------}
procedure WriteInteger(ABuffer: Pointer; AOffset: Cardinal; AValue: Integer);
begin
  MoveRotate(@AValue, Pointer(NativeUInt(ABuffer) + AOffset), SizeOf(AValue));
end;

{-------------------------------------------------------------------------------}
procedure j2date(const AValue: Int64; out AYear, AMonth, ADay: Word);
var
  julian, quad, extra: Cardinal;
  y: Integer;
begin
  julian := AValue;
  julian := julian + 32044;
  quad := julian div 146097;
  extra := (julian - quad * 146097) * 4 + 3;
  julian := julian + 60 + quad * 3 + extra div 146097;
  quad := julian div 1461;
  julian := julian - quad * 1461;
  y := julian * 4 div 1461;
  if y <> 0 then
    julian := (julian + 305) mod 365
  else
    julian := (julian + 306) mod 366;
  julian := julian + 123;
  y := y + Integer(quad * 4);
  AYear := y - 4800;
  quad := julian * 2141 div 65536;
  ADay := julian - 7834 * quad div 256;
  AMonth := (quad + 10) mod 12 + 1;
end;

{-------------------------------------------------------------------------------}
procedure dtInt2time(AValue: Int64; out AHour, AMin, ASec: Word; out AFsec: Cardinal);
begin
  AHour := AValue div McSecsPerHour;
  AValue := AValue - Int64(AHour) * Int64(McSecsPerHour);
  AMin := AValue div McSecsPerMin;
  AValue := AValue - Int64(AMin) * Int64(McSecsPerMin);
  ASec := AValue div McSecsPerSec;
  AFsec := (AValue - Int64(ASec) * Int64(McSecsPerSec)) div MSecsPerSec;
end;

{-------------------------------------------------------------------------------}
procedure dtDbl2time(AValue: Double; out AHour, AMin, ASec: Word; out AFsec: Cardinal);
begin
  AHour := Trunc(AValue / SecsPerHour);
  AValue := AValue - AHour * SecsPerHour;
  AMin := Trunc(AValue / SecsPerMin);
  AValue := AValue - AMin * SecsPerMin;
  ASec := Trunc(AValue);
  AFsec := Trunc((AValue - ASec) * MSecsPerSec);
end;

{-------------------------------------------------------------------------------}
function date2j(AYear, AMonth, ADay: Word): Int64;
var
  iCentury: Integer;
begin
  if AMonth > 2 then begin
    AMonth := AMonth + 1;
    AYear := AYear + 4800;
  end
  else begin
    AMonth := AMonth + 13;
    AYear := AYear + 4799;
  end;
  iCentury := AYear div 100;
  Result := AYear * 365 - 32167;
  Result := Result + AYear div 4 - iCentury + iCentury div 4;
  Result := Result + 7834 * AMonth div 256 + ADay;
end;

{-------------------------------------------------------------------------------}
function time2IntT(const AHour, AMin, ASec: Word; const AFsec: Cardinal): Int64;
begin
  Result := ((AHour * MinsPerHour + AMin) * SecsPerMin + ASec) * MSecsPerSec + AFsec;
end;

{-------------------------------------------------------------------------------}
function time2DblT(const AHour, AMin, ASec: Word; const AFsec: Cardinal): Double;
begin
  Result := (AHour * MinsPerHour + AMin) * SecsPerMin + ASec + AFsec / MSecsPerSec;
end;

{-------------------------------------------------------------------------------}
procedure GetPgNumeric(ASource: Pointer; out ADest: TBcd);
var
  iWordCount: Integer;
  iOrder: Integer;
  iAbsOrder: Integer;
  iSign: Integer;
  iFOffset: Integer;
  i, j: Integer;
  iPrec: Integer;
  iScale: Integer;
  iDelta: Integer;
  wWord: Word;
  bHb, bLb: Byte;
  bDec: array[1..4] of Byte;
begin
  FillChar(ADest, SizeOf(TBcd), 0);

  iWordCount := ReadWord(ASource);
  iOrder := SmallInt(ReadWord(ASource, 2));
  iSign := ReadWord(ASource, 4);

  if (iWordCount = 0) and (iSign = 0) or          // zero
     (iSign <> 0) and (iSign <> $4000) then begin // NaN
    ADest.Precision := 10;
    ADest.SignSpecialPlaces := 2;
    Exit;
  end;

  if iOrder < 0 then begin
    iAbsOrder := -iOrder;
    iFOffset := (-iOrder - 1) * 2;
  end
  else begin
    iAbsOrder := iOrder;
    iFOffset := 0;
  end;

  iPrec := 0;
  iScale := 0;
  if iWordCount <= iAbsOrder then begin
    iDelta := (iAbsOrder - iWordCount + 1) * 4;
    Inc(iPrec, iDelta);
    if iOrder < 0 then
      Inc(iScale, iDelta);
  end
  else if iOrder < -1 then begin
    iDelta := (iAbsOrder - 1) * 4;
    Inc(iPrec, iDelta);
    Inc(iScale, iDelta);
  end;

  for i := 0 to iWordCount - 1 do begin
    wWord := ReadWord(ASource, 8 + i * 2);

    bHb := wWord div 100;
    bLb := wWord mod 100;

    bDec[1] := bHb div 10;
    bDec[2] := bHb mod 10;
    bDec[3] := bLb div 10;
    bDec[4] := bLb mod 10;

    ADest.Fraction[i * 2 + iFOffset] := (bDec[1] shl 4) or bDec[2];
    ADest.Fraction[i * 2 + 1 + iFOffset] := (bDec[3] shl 4) or bDec[4];

    // fraction part
    if i > iOrder then begin
      Inc(iPrec, 4);
      Inc(iScale, 4);
    end
    else
      Inc(iPrec, 4);
  end;

  // trim trailing zeros
  if iScale <> 0 then
    for j := 4 downto 1 do
      if bDec[j] = 0 then begin
        Dec(iPrec);
        if iScale <> 0 then
          Dec(iScale);
      end
      else
        Break;

  // precision must be at least 1
  if iPrec = 0 then
    iPrec := 1;

  ADest.Precision := iPrec;
  ADest.SignSpecialPlaces := iScale;
  if iSign = $4000 then
    ADest.SignSpecialPlaces := ADest.SignSpecialPlaces or $80;
end;

{-------------------------------------------------------------------------------}
procedure GetPgMoney(ASource: Pointer; ASourceLen: Integer; out ADest: Currency);
var
  aMoney: array[0..7] of Byte;
begin
  MoveRotate(ASource, @aMoney[0], ASourceLen);
  if ASourceLen = SizeOf(Integer) then
    ADest := PInteger(@aMoney[0])^ / 100
  else if ASourceLen = SizeOf(Int64) then
    ADest := PInt64(@aMoney[0])^ / 100
  else
    ASSERT(False);
end;

{-------------------------------------------------------------------------------}
procedure SetPgNumeric(const ASource: TBcd; ADest: Pointer; out ADestLen: LongWord);
const
  MaxWords = MaxFMTBcdFractionSize div 4;
  MulTable: array[0..3] of Integer = (1000, 100, 10, 1);
var
  i: Integer;
  iWordInd: Integer;
  iDigitInd: Integer;
  iDigit: Integer;
  iPrec: Integer;
  iScale: Integer;
  iLast: Integer;
  iOrder: Integer;
  lNegative: Boolean;
  HasDigit: Boolean;
  aWords: array[0..MaxWords - 1] of Word;
begin
  FillChar(aWords[0], MaxWords * SizeOf(Word), 0);

  lNegative := ASource.SignSpecialPlaces and (1 shl 7) <> 0;
  iScale := ASource.SignSpecialPlaces and 63;
  iPrec := ASource.Precision - iScale;
  iLast := iPrec + iScale - 1;
  iWordInd := 0;
  iOrder := 0;
  HasDigit := False;

  iDigitInd := 4 - iPrec mod 4;
  if iDigitInd = 4 then
    iDigitInd := 0;

  for i := 0 to iLast do begin
    iDigit := ASource.Fraction[i div 2];
    case i mod 2 of
      0: iDigit := iDigit shr 4;
      1: iDigit := iDigit and 15;
    end;
    if iDigit <> 0 then
      HasDigit := True;
    aWords[iWordInd] := aWords[iWordInd] + iDigit * MulTable[iDigitInd];

    Inc(iDigitInd);
    if iDigitInd = 4 then begin
      iDigitInd := 0;

      if (aWords[iWordInd] <> 0) or HasDigit then begin
        if i < iLast then
          Inc(iWordInd);
        if i < iPrec then
          Inc(iOrder);
      end
      else if i >= iPrec - 1 then
        Dec(iOrder);
    end;
  end;

  if HasDigit then begin
    if (iOrder >= 0) or (iScale - iLast = 1) and (iOrder < 0) then
      Dec(iOrder);
    Inc(iWordInd);
  end
  else begin
    iWordInd := 0;
    iOrder := 0;
    lNegative := False;
    iScale := 0;
  end;

  WriteWord(ADest, 0, Word(iWordInd));
  WriteWord(ADest, 2, Word(iOrder));
  if lNegative then
    WriteWord(ADest, 4, $4000)
  else
    WriteWord(ADest, 4, 0);
  WriteWord(ADest, 6, Word(iScale));
  for i := 0 to iWordInd - 1 do
    WriteWord(ADest, 8 + i * 2, aWords[i]);

  ADestLen := (4 + iWordInd) * SizeOf(Word);
end;

{-------------------------------------------------------------------------------}
procedure SetPgMoney(const ASource: Currency; ADest: Pointer; ADestLen: LongWord);
var
  aMoney: array[0..7] of Byte;
begin
  if ADestLen = SizeOf(Integer) then
    PInteger(@aMoney[0])^ := Integer(Trunc(ASource * 100))
  else if ADestLen = SizeOf(Int64) then
    PInt64(@aMoney[0])^ := Int64(Trunc(ASource * 100))
  else
    ASSERT(False);
  MoveRotate(@aMoney[0], ADest, ADestLen);
end;

{-------------------------------------------------------------------------------}
{ TPgVariable                                                                   }
{-------------------------------------------------------------------------------}
constructor TPgVariable.Create(AOwner: TPgVariables);
begin
  inherited Create;
  FOwner := AOwner;
  FStatement := AOwner.FStatement;
end;

{-------------------------------------------------------------------------------}
procedure TPgVariable.CheckArrayBounds(AValue, ALBound, AHBound: Integer);
begin
  if AValue <> -1 then begin
    if (TypeRef = nil) or not (paArray in TypeRef.Attrs) then
      FDException(Statement.OwningObj, [S_FD_LPhys, S_FD_PGId],
        er_FD_PgIsNotArray, [DumpLabel]);
    if (AValue < ALBound) or (AValue > AHBound) then
      FDException(Statement.OwningObj, [S_FD_LPhys, S_FD_PGId],
        er_FD_PgArrIndexOutOfBound, [DumpLabel, AValue, ALBound, AHBound]);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgVariable.SetTypeOid(AValue: Oid);
begin
  if FTypeOid <> AValue then begin
    FTypeRef := Statement.FConnection.TypesManager.Types[AValue];
    FTypeOid := FTypeRef.Id;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgVariable.AllocBuffer(ASize: LongWord);
begin
  ASSERT(False);
end;

{-------------------------------------------------------------------------------}
function TPgVariable.Pg2FDData(AType: TPgType; ASource: Pointer; ASourceLen: Integer; 
  var ADest: Pointer; var ADestLen: LongWord; AByRef: Boolean): Boolean;
var
  iId: Oid;
  pWC: Pointer;

  procedure GetPgDate(ASource: Pointer; out ADest: Integer);
  var
    iDays: Integer;
  begin
    MoveRotate(ASource, @iDays, SizeOf(iDays));
    iDays := pg_base_date + iDays;
    if iDays < MinDateTime then
      iDays := MinDateTime;
    if iDays > MaxDateTime then
      iDays := MaxDateTime;
    ADest := iDays + DateDelta;
  end;

  procedure GetPgTime(ASource: Pointer; out ADest: Integer);
  var
    aSeconds: TPgTimeStampBuf;
  begin
    MoveRotate(ASource, @aSeconds, SizeOf(aSeconds));
    if Statement.FConnection.IntegerDateTimes then
      ADest := PInt64(@aSeconds)^ div MSecsPerSec
    else
      ADest := Trunc(PDouble(@aSeconds)^ * MSecsPerSec);
  end;

  procedure GetPgTimeStamp(ASource: Pointer; out ADest: TSQLTimeStamp;
    ATimeZoneOffset: Integer);
  var
    iDate, iTime: Int64;
    dDate, dTime: Double;
  begin
    if Statement.FConnection.IntegerDateTimes then begin
      ASSERT(SizeOf(TPgTimeStampBuf) = SizeOf(iTime));
      MoveRotate(ASource, @iTime, SizeOf(TPgTimeStampBuf));
      if iTime = C_FD_MaxInt64 then begin
        ADest.Year := 9999;
        ADest.Month := 12;
        ADest.Day := 31;
        ADest.Hour := 23;
        ADest.Minute := 59;
        ADest.Second := 59;
        ADest.Fractions := 999;
      end
      else if iTime = C_FD_MinInt64 then begin
        ADest.Year := 1;
        ADest.Month := 12;
        ADest.Day := 31;
        ADest.Hour := 23;
        ADest.Minute := 59;
        ADest.Second := 59;
        ADest.Fractions := 999;
      end
      else begin
        if ATimeZoneOffset <> 0 then
          iTime := iTime + ATimeZoneOffset * McSecsPerHour;
        iDate := iTime div McSecsPerDay;
        iTime := iTime mod McSecsPerDay;
        if iTime < 0 then begin
          iTime := iTime + McSecsPerDay;
          iDate := iDate - 1;
        end;
        iDate := iDate + POSTGRES_EPOCH_JDATE;
        j2date(iDate, Word(ADest.Year), ADest.Month, ADest.Day);
        dtInt2time(iTime, ADest.Hour, ADest.Minute, ADest.Second, ADest.Fractions);
      end;
    end
    else begin
      ASSERT(SizeOf(TPgTimeStampBuf) = SizeOf(dTime));
      MoveRotate(ASource, @dTime, SizeOf(TPgTimeStampBuf));
      if ATimeZoneOffset <> 0 then
        dTime := dTime + ATimeZoneOffset * SecsPerHour;
                                        
      if dTime < 0 then
        dDate := Ceil(dTime / SecsPerDay)
      else
        dDate := Floor(dTime / SecsPerDay);
      if dDate <> 0 then
        dTime := dTime - Round(dDate * SecsPerDay);
      if dTime < 0 then begin
        dTime := dTime + SecsPerDay;
        dDate := dDate - 1;
      end;
      dDate := dDate + POSTGRES_EPOCH_JDATE;
      j2date(Trunc(dDate), Word(ADest.Year), ADest.Month, ADest.Day);
      dtDbl2time(dTime, ADest.Hour, ADest.Minute, ADest.Second, ADest.Fractions);
    end;
  end;

  procedure GetPgRelTime(ASource: Pointer; out ADest: TSQLTimeStamp);

    procedure FMODULO(var t: Double; q: Word; const u: Double);
    begin
      if t < 0 then
        q := Ceil(t / u)
      else
        q := Floor(t / u);
      if q <> 0 then
        t := t - Round(q * u);
    end;

  var
    dTime: Double;
  begin
    dTime := PInteger(ASource)^;
    FMODULO(dTime, ADest.Year, SecsPerDay * 356.25);
    FMODULO(dTime, ADest.Month, SecsPerDay * 30);
    FMODULO(dTime, ADest.Day, SecsPerDay);
    FMODULO(dTime, ADest.Hour, SecsPerHour);
    FMODULO(dTime, ADest.Minute, SecsPerMin);
    FMODULO(dTime, ADest.Second, 1);
    ADest.Fractions := 0;
  end;

  procedure GetPgInterval(ASource: Pointer; out ADest: TFDSQLTimeInterval);
  var
    pBuff: TPgTimeStampBuf;
    dSeconds: Double;
    iDays: Integer;
    iMonths: Integer;
    iTmp: Integer;
  begin
    if Statement.FConnection.IntegerDateTimes then begin
      MoveRotate(ASource, @pBuff, SizeOf(dSeconds));
      dSeconds := PInt64(@pBuff)^ / McSecsPerSec;
    end
    else
      MoveRotate(ASource, @dSeconds, SizeOf(dSeconds));

    MoveRotate(Pointer(NativeUInt(ASource) + 8), @iDays, SizeOf(iDays));
    MoveRotate(Pointer(NativeUInt(ASource) + 12), @iMonths, SizeOf(iMonths));

    FillChar(ADest, SizeOf(ADest), 0);
    if iMonths <> 0 then begin
      ADest.Years := Abs(iMonths) div 12;
      ADest.Months := Abs(iMonths) mod 12;
      if iMonths >= 0 then
        ADest.Sign := 1
      else
        ADest.Sign := -1;
      ADest.Kind := itYear2Month;
    end
    else begin
      if iDays <> 0 then begin
        ADest.Days := Abs(iDays);
        if iDays >= 0 then
          ADest.Sign := 1
        else
          ADest.Sign := -1;
        ADest.Kind := itDay;
      end;
      if dSeconds <> 0 then begin
        iTmp := Abs(Trunc(dSeconds));
        ADest.Hours := iTmp div SecsPerHour;
        iTmp := iTmp mod SecsPerHour;
        ADest.Minutes := iTmp div SecsPerMin;
        ADest.Seconds := iTmp mod SecsPerMin;
        ADest.Fractions := Abs(Trunc(Frac(dSeconds) * McSecsPerSec));
        if ADest.Kind = itUnknown then begin
          if dSeconds >= 0 then
            ADest.Sign := 1
          else
            ADest.Sign := -1;
          ADest.Kind := itHour2Second;
        end
        else
          ADest.Kind := itDay2Second;
      end;
    end;
  end;

begin
  Result := True;

  ADestLen := AType.FDSize;
  if ADestLen = 0 then
    ADestLen := ASourceLen;

  if (ADest = nil) and
     (AType.Attrs * [paString, paBlob] = []) then
    Exit;

  if paEnum in AType.Attrs then
    iId := SQL_VARCHAR
  else
    iId := AType.Id;

  case iId of
  SQL_INT2,
  SQL_INT4,
  SQL_INT8,
  SQL_OID,
  SQL_TID,
  SQL_XID,
  SQL_CID,
  SQL_REGPROC,
  SQL_REGPROCEDURE,
  SQL_REGOPER,
  SQL_REGOPERATOR,
  SQL_REGCLASS,
  SQL_REGTYPE,
  SQL_FLOAT4,
  SQL_FLOAT8,
  SQL_SMGR:
    MoveRotate(ASource, ADest, ADestLen);
  SQL_CASH:
    GetPgMoney(ASource, ADestLen, PCurrency(ADest)^);
  SQL_NAME,
  SQL_CHAR,
  SQL_BPCHAR,
  SQL_VARCHAR,
  SQL_TEXT,
  SQL_JSON,
  SQL_JSONB,
  SQL_XML,
  SQL_NODE_TREE,
  SQL_REFCURSOR,
  SQL_UNKNOWN,
  SQL_ACLITEM,
  SQL_VOID:
    begin
      if iId = SQL_JSONB then begin
        if PByte(ASource)^ <> JSONB_VER then begin
          ADest := nil;
          ADestLen := 0;
          Exit(False);
        end;
        Inc(PByte(ASource));
        Dec(ADestLen);
        Dec(ASourceLen);
      end;
      case Statement.FConnection.Encoder.Encoding of
      ecANSI:
        begin
          if (paFixed in AType.Attrs) and Statement.StrsTrim then
            while (ADestLen > 0) and (PFDAnsiString(ASource)[ADestLen - 1] = TFDAnsiChar(' ')) do
              Dec(ADestLen);
          if (ADestLen = 0) and Statement.StrsEmpty2Null then begin
            Result := False;
            if AByRef then
              ADest := nil;
          end
          else if AByRef then
            ADest := ASource
          else if ADest <> nil then
            Move(PFDAnsiString(ASource)^, PFDAnsiString(ADest)^, ADestLen * SizeOf(TFDAnsiChar));
        end;
      ecUTF8:
        begin
          pWC := nil;
          ADestLen := Statement.FConnection.Encoder.Decode(ASource, ASourceLen, pWC, ecUTF16);
          ASource := pWC;
          if (paFixed in AType.Attrs) and Statement.StrsTrim then
            while (ADestLen > 0) and (PWideChar(ASource)[ADestLen - 1] = ' ') do
              Dec(ADestLen);
          if (ADestLen = 0) and Statement.StrsEmpty2Null then begin
            Result := False;
            if AByRef then
              ADest := nil;
          end
          else if AByRef then
            ADest := ASource
          else if ADest <> nil then
            Move(PWideChar(ASource)^, PWideChar(ADest)^, ADestLen * SizeOf(WideChar));
        end;
      end;
    end;
  SQL_BYTEA,
  SQL_ANY,
  SQL_MACADDR,
  SQL_CIDR,
  SQL_INET:
    if AByRef then
      ADest := ASource
    else
      Move(ASource^, ADest^, ADestLen);
  SQL_BIT,
  SQL_VARBIT:
    begin
      MoveRotate(ASource, @ADestLen, SizeOf(ADestLen));
      ADestLen := (ADestLen + 7) div 8;
      if AByRef then
        ADest := Pointer(NativeUInt(ASource) + SizeOf(Integer))
      else
        Move(Pointer(NativeUInt(ASource) + SizeOf(Integer))^, ADest^, ADestLen);
    end;
  SQL_DATE:
    GetPgDate(ASource, PInteger(ADest)^);
  SQL_TIME,
  SQL_TIMETZ:
    GetPgTime(ASource, PInteger(ADest)^);
  SQL_TIMESTAMP:
    GetPgTimeStamp(ASource, PSQLTimeStamp(ADest)^, 0);
  SQL_TIMESTAMPTZ:
    GetPgTimeStamp(ASource, PSQLTimeStamp(ADest)^, Statement.Connection.TimeZoneOffset);
  SQL_RELTIME:
    GetPgRelTime(ASource, PSQLTimeStamp(ADest)^);
  SQL_ABSTIME:
                                              
    Result := False;
  SQL_INTERVAL:
    GetPgInterval(ASource, PFDSQLTimeInterval(ADest)^);
  SQL_NUMERIC:
    GetPgNumeric(ASource, PBcd(ADest)^);
  SQL_BOOL:
    PWordBool(ADest)^ := WordBool(PByte(ASource)^);
  SQL_UUID:
    PGUID(ADest)^ := PGUID(ASource)^;
  else
    ASSERT(False);
  end;
end;

{-------------------------------------------------------------------------------}
function TPgVariable.FD2PgData(AType: TPgType; ASource: Pointer; ASourceLen: Integer; 
  var ADest: Pointer; var ADestLen: LongWord; var ADestFormat: Integer;
  AByRef: Boolean): Boolean;
var
  iByteLen: LongWord;
  pRes: Pointer;

  procedure ErrorDataTooLarge(AMax, AActual: LongWord);
  begin
    FDException(Statement.OwningObj, [S_FD_LPhys, S_FD_PGId],
      er_FD_AccDataToLarge, [DumpLabel, AMax, AActual]);
  end;

  procedure SetPgDate(const ASource: Integer; ADest: Pointer);
  var
    iDays: Integer;
  begin
    iDays := ASource - DateDelta - pg_base_date;
    MoveRotate(@iDays, ADest, SizeOf(Integer));
  end;

  procedure SetPgTime(const ASource: Integer; ADest: Pointer);
  var
    pSeconds: TPgTimeStampBuf;
  begin
    if Statement.FConnection.IntegerDateTimes then
      PInt64(@pSeconds)^ := Int64(ASource) * MSecsPerSec
    else
      PDouble(@pSeconds)^ := ASource / MSecsPerSec;
    MoveRotate(@pSeconds, ADest, SizeOf(TPgTimeStampBuf));
  end;

  procedure SetPgTimeStamp(const ASource: TSQLTimeStamp; ADest: Pointer);
  var
    iDate, iTime: Int64;
    dDate, dTime: Double;
  begin
    if Statement.FConnection.IntegerDateTimes then begin
      ASSERT(SizeOf(TPgTimeStampBuf) = SizeOf(iTime));
      iDate := date2j(ASource.Year, ASource.Month, ASource.Day) - POSTGRES_EPOCH_JDATE;
      iTime := time2IntT(ASource.Hour, ASource.Minute, ASource.Second, ASource.Fractions);
      iTime := (iDate * MSecsPerDay + iTime) * MSecsPerSec;
      MoveRotate(@iTime, ADest, SizeOf(iTime));
    end
    else begin
      ASSERT(SizeOf(TPgTimeStampBuf) = SizeOf(dTime));
      dDate := date2j(ASource.Year, ASource.Month, ASource.Day) - POSTGRES_EPOCH_JDATE;
      dTime := time2DblT(ASource.Hour, ASource.Minute, ASource.Second, ASource.Fractions);
      dTime := dDate * SecsPerDay + dTime;
      MoveRotate(@dTime, ADest, SizeOf(dTime));
    end;
  end;

  procedure SetPgInterval(const ASource: TFDSQLTimeInterval; ADest: Pointer);
  var
    dSeconds: Double;
    iDays: Integer;
    iMonths: Integer;
    iTime: Int64;
  begin
    iMonths := 0;
    iDays := 0;
    dSeconds := 0;
    if ASource.Kind in [itYear, itMonth, itYear2Month] then
      iMonths := ASource.Months + ASource.Years * 12;
    if ASource.Kind in [itDay, itDay2Hour, itDay2Minute, itDay2Second] then
      iDays := ASource.Days;
    if ASource.Kind in [itHour, itMinute, itSecond, itDay2Hour, itDay2Minute,
                        itDay2Second, itHour2Minute, itHour2Second, itMinute2Second] then
      dSeconds := ASource.Hours * SecsPerHour + ASource.Minutes * SecsPerMin +
        ASource.Seconds + ASource.Fractions / McSecsPerSec;
    if ASource.Sign < 0 then
      if iMonths <> 0 then
        iMonths := -iMonths
      else if iDays <> 0 then
        iDays := -iDays
      else if dSeconds <> 0 then
        dSeconds := -dSeconds;

    if Statement.FConnection.IntegerDateTimes then begin
                                                                                
      iTime := Trunc(dSeconds * McSecsPerSec);
      MoveRotate(@iTime, ADest, SizeOf(iTime));
    end
    else
      MoveRotate(@dSeconds, ADest, SizeOf(dSeconds));

    MoveRotate(@iDays, Pointer(NativeUInt(ADest) + 8), SizeOf(iDays));
    MoveRotate(@iMonths, Pointer(NativeUInt(ADest) + 12), SizeOf(iMonths));
  end;

begin
  Result := not ((ASource = nil) and (ASourceLen = 0));
  if not Result then
    Exit;

  ADestFormat := 1;
  case AType.Id of
  SQL_INT2,
  SQL_INT4,
  SQL_INT8,
  SQL_OID,
  SQL_TID,
  SQL_XID,
  SQL_CID,
  SQL_REGPROC,
  SQL_REGPROCEDURE,
  SQL_REGOPER,
  SQL_REGOPERATOR,
  SQL_REGCLASS,
  SQL_REGTYPE,
  SQL_FLOAT4,
  SQL_FLOAT8,
  SQL_SMGR:
    begin
      ASSERT(ASourceLen = Integer(ADestLen));
      MoveRotate(ASource, ADest, ADestLen);
    end;
  SQL_CASH:
    SetPgMoney(PCurrency(ASource)^, ADest, ASourceLen);
  SQL_NAME,
  SQL_CHAR,
  SQL_BPCHAR,
  SQL_VARCHAR,
  SQL_UNKNOWN,
  SQL_ACLITEM:
    begin
      if (paFixed in AType.Attrs) and Statement.StrsTrim then
        if FEncoding = ecUTF16 then
          while (ASourceLen > 0) and (PWideChar(ASource)[ASourceLen - 1] = ' ') do
            Dec(ASourceLen)
        else
          while (ASourceLen > 0) and (PFDAnsiString(ASource)[ASourceLen - 1] = TFDAnsiChar(' ')) do
            Dec(ASourceLen);
      if Statement.StrsEmpty2Null and (ASourceLen = 0) then
        Result := False;
      if Result then begin
        if (FEncoding = ecANSI) and (Statement.FConnection.Encoder.Encoding = ecANSI) then begin
          iByteLen := ASourceLen * SizeOf(TFDAnsiChar);
          Move(ASource^, ADest^, iByteLen);
        end
        else begin
          pRes := nil;
          iByteLen := Statement.FConnection.Encoder.Encode(ASource, ASourceLen, pRes, FEncoding);
          if iByteLen > ADestLen then
            ErrorDataTooLarge(ADestLen, iByteLen);
          Move(pRes^, ADest^, iByteLen);
        end;
      end
      else
        iByteLen := 0;
      ADestLen := iByteLen;
    end;
  SQL_DATE:
    SetPgDate(PInteger(ASource)^, ADest);
  SQL_TIME,
  SQL_TIMETZ:
    SetPgTime(PInteger(ASource)^, ADest);
  SQL_TIMESTAMP,
  SQL_TIMESTAMPTZ:
    SetPgTimeStamp(PSQLTimeStamp(ASource)^, ADest);
  SQL_INTERVAL:
    SetPgInterval(PFDSQLTimeInterval(ASource)^, ADest);
  SQL_TEXT,
  SQL_JSON,
  SQL_XML,
  SQL_NODE_TREE:
    if (FEncoding = ecANSI) and (Statement.FConnection.Encoder.Encoding = ecANSI) then begin
      ADestLen := ASourceLen * SizeOf(TFDAnsiChar);
      if AByRef then
        ADest := ASource
      else begin
        AllocBuffer(ADestLen);
        Move(ASource^, ADest^, ADestLen);
      end;
    end
    else begin
      pRes := nil;
      iByteLen := Statement.FConnection.Encoder.Encode(ASource, ASourceLen, pRes, FEncoding);
      AllocBuffer(iByteLen);
      Move(pRes^, ADest^, iByteLen);
      ADestLen := iByteLen;
    end;
  SQL_JSONB:
    if (FEncoding = ecANSI) and (Statement.FConnection.Encoder.Encoding = ecANSI) then begin
      ADestLen := (ASourceLen + 1) * SizeOf(TFDAnsiChar);
      if AByRef then
        ADest := ASource
      else begin
        AllocBuffer(ADestLen);
        PByte(ADest)^ := JSONB_VER;
        Move(ASource^, (PByte(ADest) + 1)^, ADestLen - 1);
      end;
    end
    else begin
      pRes := nil;
      iByteLen := Statement.FConnection.Encoder.Encode(ASource, ASourceLen, pRes, FEncoding) + 1;
      AllocBuffer(iByteLen);
      PByte(ADest)^ := JSONB_VER;
      Move(pRes^, (PByte(ADest) + 1)^, iByteLen - 1);
      ADestLen := iByteLen;
    end;
  SQL_BYTEA,
  SQL_ANY,
  SQL_MACADDR,
  SQL_CIDR,
  SQL_INET,
  SQL_BIT,
  SQL_VARBIT:
    begin
      ADestLen := ASourceLen;
      if AByRef then
        ADest := ASource
      else begin
        AllocBuffer(ADestLen);
        Move(ASource^, ADest^, ADestLen);
      end;
    end;
  SQL_NUMERIC:
    SetPgNumeric(PBcd(ASource)^, ADest, ADestLen);
  SQL_BOOL:
    PByte(ADest)^ := Byte(PWordBool(ASource)^);
  SQL_UUID:
    PGUID(ADest)^ := PGUID(ASource)^;
  else
    ASSERT(False);
  end;
end;

{-------------------------------------------------------------------------------}
function TPgVariable.GetDumpLabel: String;
begin
  if FDumpLabel <> '' then
    Result := FDumpLabel
  else
    Result := '';
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
function TPgVariable.DumpSQLDataType: String;
begin
  Result := TypeRef.DumpType;
end;

{-------------------------------------------------------------------------------}
function TPgVariable.DumpFDValue(ABuffer: Pointer; ALen: Integer): String;
var
  aBuff: array [0 .. 127] of Char;
begin
  if (ABuffer = nil) and (ALen = 0) then
    Result := 'NULL'
  else
    case FTypeOid of
    SQL_INT2,
    SQL_SMGR:
      Result := IntToStr(PSmallInt(ABuffer)^);
    SQL_INT4:
      Result := IntToStr(PInteger(ABuffer)^);
    SQL_OID,
    SQL_TID,
    SQL_XID,
    SQL_CID,
    SQL_REGPROC,
    SQL_REGPROCEDURE,
    SQL_REGOPER,
    SQL_REGOPERATOR,
    SQL_REGCLASS,
    SQL_REGTYPE:
      Result := Format('%u', [POid(ABuffer)^]);
    SQL_INT8:
      Result := IntToStr(PInt64(ABuffer)^);
    SQL_FLOAT4:
      Result := FloatToStr(PSingle(ABuffer)^);
    SQL_FLOAT8:
      Result := FloatToStr(PDouble(ABuffer)^);
    SQL_CASH:
      Result := CurrToStr(PCurrency(ABuffer)^);
    SQL_NAME,
    SQL_CHAR,
    SQL_BPCHAR,
    SQL_VARCHAR,
    SQL_TEXT,
    SQL_JSON,
    SQL_JSONB,
    SQL_XML,
    SQL_NODE_TREE,
    SQL_REFCURSOR,
    SQL_UNKNOWN,
    SQL_ACLITEM:
      if Statement.FConnection.Encoder.Encoding = ecANSI then
        if ALen > 1024 then
          Result := '(truncated at 1024) ''' +
            Statement.FConnection.Encoder.Decode(ABuffer, 1024, ecANSI) + ' ...'''
        else
          Result := '''' +
            Statement.FConnection.Encoder.Decode(ABuffer, ALen, ecANSI) + ''''
      else
        if ALen > 1024 then begin
          SetString(Result, PWideChar(ABuffer), 1024);
          Result := '(truncated at 1024) ''' + Result + ' ...''';
        end
        else begin
          SetString(Result, PWideChar(ABuffer), ALen);
          Result := '''' + Result + '''';
        end;
    SQL_BYTEA,
    SQL_ANY,
    SQL_MACADDR,
    SQL_CIDR,
    SQL_INET,
    SQL_BIT,
    SQL_VARBIT:
      if ALen > 512 then
        Result := '(truncated at 512) ' + FDBin2Hex(ABuffer, 512) + ' ...'
      else
        Result := FDBin2Hex(ABuffer, ALen);
    SQL_DATE:
      Result := DateToStr(FDDate2DateTime(PInteger(ABuffer)^));
    SQL_TIME,
    SQL_TIMETZ:
      Result := TimeToStr(FDTime2DateTime(PInteger(ABuffer)^));
    SQL_TIMESTAMP,
    SQL_TIMESTAMPTZ,
    SQL_RELTIME,
    SQL_ABSTIME:
      Result := DateTimeToStr(SQLTimeStampToDateTime(PSQLTimeStamp(ABuffer)^));
    SQL_INTERVAL:
      Result := FDSQLTimeInterval2Str(PFDSQLTimeInterval(ABuffer)^);
    SQL_NUMERIC:
      begin
        FDBCD2Str(aBuff, ALen, PBcd(ABuffer)^, FormatSettings.DecimalSeparator);
        SetString(Result, aBuff, ALen);
      end;
    SQL_BOOL:
      Result := S_FD_Bools[PWordBool(ABuffer)^];
    SQL_UUID:
      Result := GUIDToString(PGUID(ABuffer)^);
    else
      ASSERT(False);
      Result := '';
    end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TPgVariables                                                                  }
{-------------------------------------------------------------------------------}
constructor TPgVariables.Create(AOwner: TPgStatement);
begin
  inherited Create;
  FStatement := AOwner;
  FList := TFDObjList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TPgVariables.Destroy;
begin
  Count := 0;
  FDFreeAndNil(FList);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TPgVariables.Add: TPgVariable;
begin
  Result := GetVariableClass.Create(Self);
  Result.FIndex := FList.Add(Result);
end;

{-------------------------------------------------------------------------------}
function TPgVariables.GetCount: Integer;
begin
  Result := FList.Count;
end;

{-------------------------------------------------------------------------------}
procedure TPgVariables.SetCount(AValue: Integer);
var
  i: Integer;
begin
  if AValue = FList.Count then
    Exit;
  if AValue < FList.Count then begin
    for i := FList.Count - 1 downto AValue do
      FDFree(TPgVariable(FList[i]));
    FList.Count := AValue;
  end
  else
    for i := FList.Count + 1 to AValue do
      Add;
end;

{-------------------------------------------------------------------------------}
{ TPgParam                                                                      }
{-------------------------------------------------------------------------------}
constructor TPgParam.Create(AOwner: TPgVariables);
begin
  inherited Create(AOwner);
  FArrayIndex := -1;
end;

{-------------------------------------------------------------------------------}
destructor TPgParam.Destroy;
begin
  FreeBuffer;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TPgParam.CheckBuffer;
var
  iDataSize: LongWord;
  iBufferSize: LongWord;
  oRef: TPgType;
  i: Integer;
begin
  oRef := TypeRef;
  if paArray in oRef.Attrs then
    oRef := oRef.Members[0].TypeRef;

  iDataSize := 0;
  if paString in oRef.Attrs then begin
    if FSize = 0 then
      FSize := max_string_size;
    case Statement.FConnection.FEncoder.Encoding of
    ecANSI:
      iDataSize := FSize * SizeOf(TFDAnsiChar);
    ecUTF8:
      iDataSize := FSize * C_FD_MaxUTF8Len;
    end;
  end
  else
    iDataSize := oRef.PGSize;

  if [paArray, paFixed] * TypeRef.Attrs = [paArray] then
    iBufferSize := ARRHDRSZ + (SizeOf(Integer) + iDataSize) * Cardinal(FHBound - FLBound + 1)
  else
    iBufferSize := iDataSize;

  if (FBuffer <> nil) and (iDataSize = FDataSize) and (iBufferSize = FBufferSize) then
    Exit;

  FDataSize := iDataSize;
  FBufferSize := iBufferSize;
                                                                                          
  AllocBuffer(FBufferSize);

  if [paArray, paFixed] * TypeRef.Attrs = [paArray] then begin
    WriteInteger(FValueRef,  0, 1);                          // dimensions
    WriteInteger(FValueRef,  4, 0);                          // offset to data (ignored)
    WriteInteger(FValueRef,  8, TypeRef.Members[0].TypeOid); // element type
    WriteInteger(FValueRef, 12, FHBound - FLBound + 1);      // number of elements
    WriteInteger(FValueRef, 16, FLBound);                    // index of first element
    for i := 0 to FHBound - FLBound do
      WriteInteger(FValueRef, ARRHDRSZ + (SizeOf(Integer) + FDataSize) * Cardinal(i), -1);
    FValueSize := ARRHDRSZ + (SizeOf(Integer) + FDataSize) * Cardinal(FHBound - FLBound + 1);
    FIsNull := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgParam.AllocBuffer(ASize: LongWord);
begin
  FreeBuffer;
  if ASize > 0 then
    GetMem(FBuffer, ASize);
  FValueRef := FBuffer;
end;

{-------------------------------------------------------------------------------}
procedure TPgParam.FreeBuffer;
begin
  if FBuffer = nil then
    Exit;
  FreeMem(FBuffer);
  if FBuffer = FValueRef then
    FValueRef := nil;
  FBuffer := nil;
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
function TPgParam.DumpValue: String;
var
  pBuf: Pointer;
  iLen: LongWord;
begin
                             
  pBuf := nil;
  iLen := 0;
  if (FValueRef <> nil) and not FIsNull then begin
    Pg2FDData(TypeRef, FValueRef, FValueSize, pBuf, iLen, True);
    if (pBuf = nil) and (iLen > 0) then begin
      pBuf := Statement.FConnection.FBuffer.Check(iLen);
      Pg2FDData(TypeRef, FValueRef, FValueSize, pBuf, iLen, False);
    end;
  end;
  Result := DumpFDValue(pBuf, iLen);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
procedure TPgParam.SetTypeOid(AValue: Oid);
begin
  if FTypeOid <> AValue then begin
    FreeBuffer;
    inherited SetTypeOid(AValue);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgParam.SetData(ApData: Pointer; ALen: LongWord; AByRef: Boolean);
var
  pItem, pVal: Pointer;
  iLen: LongWord;
  iIndex: Integer;
begin
  CheckBuffer;
  if FArrayIndex >= 0 then begin
    iIndex := FArrayIndex - FLBound;
    if paFixed in TypeRef.Attrs then begin
      iLen := FDataSize div LongWord(TypeRef.FixedLen);
      pVal := Pointer(NativeUInt(FValueRef) + iLen * LongWord(iIndex));
    end
    else begin
      pItem := Pointer(NativeUInt(FValueRef) + ARRHDRSZ +
        (SizeOf(Integer) + FDataSize) * LongWord(iIndex));
      pVal := Pointer(NativeUInt(pItem) + SizeOf(Integer));
      iLen := FDataSize;
      if (ApData = nil) and (ALen = 0) or
         not FD2PgData(FTypeRef.Members[0].TypeRef, ApData, ALen,
                       pVal, iLen, FFormat, False) then
        iLen := LongWord(-1);
      WriteInteger(pItem, 0, iLen);
    end;
  end
  else begin
    FValueSize := FDataSize;
    FIsNull := not FD2PgData(FTypeRef, ApData, ALen, FValueRef, FValueSize, FFormat, AByRef);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgParam.PackBuffer;
var
  pItem, pVal: Pointer;
  i: Integer;
  iLen: LongWord;
begin
  if not (paArray in TypeRef.Attrs) or (paFixed in TypeRef.Attrs) then
    Exit;
  FValueSize := ARRHDRSZ + (SizeOf(Integer) + FDataSize) *
    LongWord(FHBound - FLBound + 1);
  pItem := Pointer(NativeUInt(FValueRef) + ARRHDRSZ);
  for i := FLBound to FHBound do begin
    pVal := Pointer(NativeUInt(pItem) + SizeOf(Integer));
    iLen := ReadInteger(pItem, 0);
    if iLen < FDataSize then begin
      if i < FHBound then
        Move(Pointer(NativeUInt(pVal) + FDataSize)^,
             Pointer(NativeUInt(pVal) + iLen)^,
             (SizeOf(Integer) + FDataSize) * LongWord(FHBound - i));
      Dec(FValueSize, FDataSize - iLen);
    end;
    pItem := Pointer(NativeUInt(pVal) + iLen);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgParam.SetArrayBounds(ALBound, AHBound: Integer);
begin
  if (FLBound <> ALBound) or (FHBound <> AHBound) then begin
    CheckArrayBounds(ALBound, ALBound, AHBound);
    FreeBuffer;
    FLBound := ALBound;
    FHBound := AHBound;
    CheckBuffer;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgParam.SetArrayIndex(AValue: Integer);
begin
  if FArrayIndex <> AValue then begin
    CheckArrayBounds(AValue, FLBound, FHBound);
    FArrayIndex := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
{ TPgParams                                                                     }
{-------------------------------------------------------------------------------}
function TPgParams.GetVariableClass: TPgVariableClass;
begin
  Result := TPgParam;
end;

{-------------------------------------------------------------------------------}
procedure TPgParams.SetCount(AValue: Integer);
begin
  if AValue <> FList.Count then begin
    FreeMem(FValueRefs);
    FreeMem(FValueLengths);
    FreeMem(FValueFormats);
    FreeMem(FValueTypes);
    FValueRefs := nil;
    FValueLengths := nil;
    FValueFormats := nil;
    FValueTypes := nil;
  end;
  inherited SetCount(AValue);
end;

{-------------------------------------------------------------------------------}
function TPgParams.GetValueTypes: Pointer;
var
  i: Cardinal;
begin
  Result := nil;
  if Count = 0 then
    Exit;
  if FValueTypes = nil then
    GetMem(FValueTypes, Count * SizeOf(Oid));
  for i := 0 to Count - 1 do
    POid(NativeUInt(FValueTypes) + i * SizeOf(Oid))^ := Items[i].FTypeOid;
  Result := FValueTypes;
end;

{-------------------------------------------------------------------------------}
function TPgParams.GetValueRefs: Pointer;
var
  i: Cardinal;
  pRef: PPointer;
  oItem: TPgParam;
begin
  Result := nil;
  if Count = 0 then
    Exit;
  if FValueRefs = nil then
    GetMem(FValueRefs, Count * SizeOf(Pointer));
  for i := 0 to Count - 1 do begin
    pRef := PPointer(NativeUInt(FValueRefs) + i * SizeOf(Pointer));
    oItem := Items[i];
    if not oItem.FIsNull then begin
      oItem.PackBuffer;
      // AsWideMemo/AsMemo := '' will lead to FValueRef=nil
      if oItem.FValueRef = nil then
        pRef^ := pRef
      else
        pRef^ := oItem.FValueRef;
    end
    else
      pRef^ := nil;
  end;
  Result := FValueRefs;
end;

{-------------------------------------------------------------------------------}
function TPgParams.GetValueLengths: Pointer;
var
  i: Cardinal;
begin
  Result := nil;
  if Count = 0 then
    Exit;
  if FValueLengths = nil then
    GetMem(FValueLengths, Count * SizeOf(Integer));
  for i := 0 to Count - 1 do
    PInteger(NativeUInt(FValueLengths) + i * SizeOf(Integer))^ := Items[i].FValueSize;
  Result := FValueLengths;
end;

{-------------------------------------------------------------------------------}
function TPgParams.GetValueFormats: Pointer;
var
  i: Cardinal;
begin
  Result := nil;
  if Count = 0 then
    Exit;
  if FValueFormats = nil then
    GetMem(FValueFormats, Count * SizeOf(Integer));
  for i := 0 to Count - 1 do
    PInteger(NativeUInt(FValueFormats) + i * SizeOf(Integer))^ := Items[i].FFormat;
  Result := FValueFormats;
end;

{-------------------------------------------------------------------------------}
function TPgParams.GetItems(AIndex: Integer): TPgParam;
begin
  Result := TPgParam(FList.Items[AIndex]);
end;

{-------------------------------------------------------------------------------}
{ TPgField                                                                      }
{-------------------------------------------------------------------------------}
constructor TPgField.Create(AOwner: TPgVariables);
begin
  inherited Create(AOwner);
  FFormat := 1;
  FArrayIndex := -1;
  FFields := TPgFields.Create(Self);
end;

{-------------------------------------------------------------------------------}
destructor TPgField.Destroy;
begin
  FDFreeAndNil(FFields);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TPgField.SetTypeOid(AValue: Oid);
var
  oField: TPgField;
  oMember: TPgMember;
  i: Integer;
begin
  if FTypeOid <> AValue then begin
    inherited SetTypeOid(AValue);
    FFields.Count := Length(TypeRef.Members);
    for i := 0 to Length(TypeRef.Members) - 1 do begin
      oField := FFields[i];
      oMember := TypeRef.Members[i];
      oField.FName := oMember.Name;
      oField.FLen := oMember.Len;
      oField.FPrec := oMember.Prec;
      oField.FScale := oMember.Scale;
      oField.TypeOid := oMember.TypeOid;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgField.SetDefaults;
var
  i: Integer;
begin
  Statement.Connection.TypesManager.GetDefaults(FTypeOid, FLen, FPrec, FScale);
  for i := 0 to FFields.Count - 1 do
    FFields[i].SetDefaults;
end;

{-------------------------------------------------------------------------------}
function TPgField.GetParentField: TPgField;
begin
  Result := TPgFields(Owner).ParentField;
end;

{-------------------------------------------------------------------------------}
function TPgField.GetPgData(out APgData: Pointer; out APgDataLen: Integer): Boolean;
var
  iFlags, iIndex: Integer;
  pAttr: PPGresAttValue;
begin
  if ParentField <> nil then
    if TPgFields(Owner).PgData <> nil then begin
      APgDataLen := TPgFields(Owner).PgDataLen;
      APgData := TPgFields(Owner).PgData;
      Result := APgDataLen >= 0;
    end
    else if paRange in ParentField.TypeRef.Attrs then begin
      Result := ParentField.GetPgData(APgData, APgDataLen);
      if Result then
        case FIndex of
        0:
          begin
            iFlags := PByte(APgData)^;
            APgData := PByte(APgData) + SizeOf(Byte);
            if (RANGE_EMPTY or RANGE_LB_NULL or RANGE_LB_INF) and iFlags = 0 then begin
              // Get lbound
              APgDataLen := ReadInteger(APgData, 0);
              APgData := Pointer(NativeUInt(APgData) + SizeOf(Integer));
            end
            else
              Result := False;
          end;
        1:
          begin
            iFlags := PByte(APgData)^;
            APgData := PByte(APgData) + SizeOf(Byte);
            if (RANGE_EMPTY or RANGE_LB_NULL or RANGE_LB_INF) and iFlags = 0 then begin
              // Skip lbound
              APgDataLen := ReadInteger(APgData, 0);
              APgData := Pointer(NativeUInt(APgData) + SizeOf(Integer) + Cardinal(APgDataLen));
            end;
            if (RANGE_EMPTY or RANGE_UB_NULL or RANGE_UB_INF) and iFlags = 0 then begin
              // Get hbound
              APgDataLen := ReadInteger(APgData, 0);
              APgData := Pointer(NativeUInt(APgData) + SizeOf(Integer));
            end
            else
              Result := False;
          end;
        2:
          begin
            // Get flags as Int32
            iFlags := PByte(APgData)^;
            APgData := Statement.Connection.FBuffer.Check(SizeOf(Integer));
            MoveRotate(@iFlags, APgData, SizeOf(Integer));
            APgDataLen := SizeOf(Integer);
          end;
        end;
    end
    else begin
      Result := ParentField.GetPgData(APgData, APgDataLen) and
        (FIndex < ReadInteger(APgData, 0));
      if Result then begin
        APgData := Pointer(NativeUInt(APgData) + 4);
        iIndex := FIndex;
        while True do begin
          APgDataLen := ReadInteger(APgData, 4);
          APgData := Pointer(NativeUInt(APgData) + 8);
          Result := APgDataLen >= 0;
          if iIndex = 0 then
            Break;
          if Result then
            APgData := Pointer(NativeUInt(APgData) + Cardinal(APgDataLen));
          Dec(iIndex);
        end;
      end;
    end
  else begin
    pAttr := PPGresAttValue(NativeUInt(
      PPPGresAttValue(NativeUInt(PPGresult(Statement.FHandle)^.tuples) +
        SizeOf(PPPGresAttValue) * UInt64(Statement.FCurrentRow - Statement.FRowsetOffset))^));
    if Statement.Lib.Brand = pbEnterprise then
      pAttr := PPGresAttValue(NativeUInt(pAttr) + SizeOf(pgresAttValueEDB) * Cardinal(FIndex))
    else
      pAttr := PPGresAttValue(NativeUInt(pAttr) + SizeOf(pgresAttValue) * Cardinal(FIndex));
    Result := (pAttr^.len <> NULL_LEN) and (pAttr^.value <> nil);
    if Result then begin
      APgData := pAttr^.value;
      APgDataLen := pAttr^.len;
    end;
  end;
  if not Result then begin
    APgDataLen := 0;
    APgData := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgField.GetArrayInfo(ApData: Pointer; out ALBound, AHBound: Integer;
  out AClosed: Boolean; out ApFirstElem: Pointer);
var
  iDim, iDims: Integer;
  iOid: Oid;
begin
  if TypeOid = SQL_PATH then begin
    AClosed := PByte(ApData)^ <> 0;
    ALBound := 0;
    AHBound := ReadInteger(ApData, 1) - 1;
    ApFirstElem := Pointer(NativeUInt(ApData) + 5);
  end
  else if TypeOid = SQL_POLYGON then begin
    AClosed := False;
    ALBound := 0;
    AHBound := ReadInteger(ApData, 0) - 1;
    ApFirstElem := Pointer(NativeUInt(ApData) + 4);
  end
  else if paFixed in TypeRef.Attrs then begin
    AClosed := False;
    ALBound := 0;
    AHBound := TypeRef.FixedLen - 1;
    ApFirstElem := ApData;
  end
  else begin
    AClosed := False;
    iDims := ReadInteger(ApData, 0);
    if iDims = 0 then begin
      ALBound := 0;
      AHBound := -1;
    end
    else begin
      if iDims > 1 then
        FDException(Statement.OwningObj, [S_FD_LPhys, S_FD_PGId],
          er_FD_PgMultiDimArrNotSup, [DumpLabel, iDims]);
      iOid := Oid(ReadInteger(ApData, 8));
      if (Length(TypeRef.Members) <> 1) or
         ([paArray, paRecord, paRange] * TypeRef.Members[0].TypeRef.Attrs <> []) or
         (TypeRef.Id <> SQL_ANY + 1) and (iOid <> TypeRef.Members[0].TypeOid) then
        FDException(Statement.OwningObj, [S_FD_LPhys, S_FD_PGId],
          er_FD_PgUnsupArrValueTypeNotSup, [DumpLabel, iOid]);
      iDim := ReadInteger(ApData, 12);
      ALBound := ReadInteger(ApData, 16);
      AHBound := ALBound + iDim - 1;
      ApFirstElem := Pointer(NativeUInt(ApData) + ARRHDRSZ);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgField.SetArrayIndex(const AValue: Integer);
var
  pPgData: Pointer;
  iPgDataLen, iLBound, iHBound, iIndex: Integer;
  lClosed: Boolean;
begin
  if FArrayIndex <> AValue then begin
    if AValue >= 0 then begin
      if GetPgData(pPgData, iPgDataLen) then
        GetArrayInfo(pPgData, iLBound, iHBound, lClosed, pPgData)
      else begin
        iLBound := -1;
        iHBound := -1;
      end;
      CheckArrayBounds(FArrayIndex, iLBound, iHBound);
      iIndex := AValue - iLBound;
      if (TypeOid = SQL_PATH) or (TypeOid = SQL_POLYGON) then begin
        iPgDataLen := 16;
        pPgData := Pointer(NativeUInt(pPgData) + Cardinal(16 * iIndex));
      end
      else if paFixed in TypeRef.Attrs then begin
        iPgDataLen := iPgDataLen div TypeRef.FixedLen;
        pPgData := Pointer(NativeUInt(pPgData) + Cardinal(iPgDataLen * iIndex));
      end
      else
        while True do begin
          iPgDataLen := ReadInteger(pPgData, 0);
          pPgData := Pointer(NativeUInt(pPgData) + 4);
          if iIndex = 0 then
            Break;
          if iPgDataLen >= 0 then
            pPgData := Pointer(NativeUInt(pPgData) + Cardinal(iPgDataLen));
          Dec(iIndex);
        end;
    end
    else begin
      pPgData := nil;
      iPgDataLen := 0;
    end;
    FArrayIndex := AValue;
    Fields.FPgData := pPgData;
    Fields.FPgDataLen := iPgDataLen;
  end;
end;

{-------------------------------------------------------------------------------}
function TPgField.GetData(var ApData: Pointer; var ALen: LongWord;
  AByRef: Boolean): Boolean;
var
  pPgData: Pointer;
  iPgDataLen: Integer;
begin
  Result := GetPgData(pPgData, iPgDataLen);
  if Result then
    if iPgDataLen = -1 then
      Result := False
    else
      Result := Pg2FDData(TypeRef, pPgData, iPgDataLen, ApData, ALen, AByRef);
end;

{-------------------------------------------------------------------------------}
function TPgField.GetData(ApData: Pointer; var ALen: LongWord): Boolean;
begin
  Result := GetData(ApData, ALen, False);
end;

{-------------------------------------------------------------------------------}
function TPgField.GetData(ApData: Pointer): Boolean;
var
  iLen: LongWord;
begin
  iLen := 0;
  Result := GetData(ApData, iLen);
end;

{-------------------------------------------------------------------------------}
function TPgField.GetAsString: String;
var
  pData: Pointer;
  iLen: LongWord;
begin
  ASSERT([paString, paBlob] * TypeRef.Attrs <> []);
  pData := nil;
  iLen := 0;
  if not GetData(pData, iLen, True) then
    Result := ''
  else
    case Statement.FConnection.Encoder.Encoding of
    ecANSI:  Result := TFDEncoder.Deco(pData, iLen, ecANSI);
    ecUTF8,
    ecUTF16: Result := TFDEncoder.Deco(pData, iLen, ecUTF16);
    end;
end;

{-------------------------------------------------------------------------------}
function TPgField.GetArrayBounds(out ALBound, AHBound: Integer; out AClosed: Boolean): Boolean;
var
  pPgData: Pointer;
  iPgDataLen: Integer;
begin
  Result := False;
  if paArray in TypeRef.Attrs then begin
    Result := GetPgData(pPgData, iPgDataLen);
    if Result then
      GetArrayInfo(pPgData, ALBound, AHBound, AClosed, pPgData);
  end;
  if not Result then begin
    AClosed := False;
    ALBound := 0;
    AHBound := -1;
  end;
end;

{-------------------------------------------------------------------------------}
function TPgField.GetDumpLabel: String;
begin
  Result := inherited GetDumpLabel;
  if Result = '' then
    Result := FName;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TPgField.DumpValue: String;
var
  pBuf: Pointer;
  iLen: LongWord;
  iLBound, iHBound, i: Integer;
  lClosed: Boolean;
begin
  if paArray in TypeRef.Attrs then begin
    GetArrayBounds(iLBound, iHBound, lClosed);
    Result := '{';
    for i := iLBound to iHBound do begin
      if i > iLBound then
        Result := Result + ',';
      ArrayIndex := i;
      try
        Result := Result + Fields[0].DumpValue;
      finally
        ArrayIndex := -1;
      end;
    end;
    Result := Result + '}';
  end
  else if [paRecord, paRange] * TypeRef.Attrs <> [] then begin
    Result := '(';
    for i := 0 to Fields.Count - 1 do begin
      if i > 0 then
        Result := Result + ',';
      Result := Result + Fields[i].DumpValue;
    end;
    Result := Result + ')';
  end
  else begin
    pBuf := nil;
    iLen := 0;
    GetData(pBuf, iLen, True);
    if (pBuf = nil) and (iLen > 0) then begin
      Statement.FConnection.FBuffer.Check(iLen);
      pBuf := Statement.FConnection.FBuffer.FBuffer;
      GetData(pBuf, iLen);
    end;
    Result := DumpFDValue(pBuf, iLen);
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TPgFields                                                                     }
{-------------------------------------------------------------------------------}
constructor TPgFields.Create(AOwner: TPgField);
begin
  inherited Create(AOwner.Owner.Statement);
  FParentField := AOwner;
end;

{-------------------------------------------------------------------------------}
function TPgFields.GetVariableClass: TPgVariableClass;
begin
  Result := TPgField;
end;

{-------------------------------------------------------------------------------}
function TPgFields.GetItems(AIndex: Integer): TPgField;
begin
  Result := TPgField(FList.Items[AIndex]);
end;

{-------------------------------------------------------------------------------}
{ TPgStatement                                                                  }
{-------------------------------------------------------------------------------}
constructor TPgStatement.Create(AConnection: TPgConnection; AOwningObj: TObject);
begin
  inherited Create(AConnection.Env, AOwningObj);
  FConnection := AConnection;
  FParams := TPgParams.Create(Self);
  FFields := TPgFields.Create(Self);
end;

{-------------------------------------------------------------------------------}
destructor TPgStatement.Destroy;
begin
  Close;
  UnPrepare;
  FDFree(FParams);
  FDFree(FFields);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
procedure TPgStatement.GetStmtName(out AName, AValue: String);
begin
  if FStmtName <> '' then begin
    AName := 'stmtName';
    AValue := FStmtName;
  end
  else if FRowsetStmtName <> '' then begin
    AName := 'rowsetStmtName';
    AValue := FRowsetStmtName;
  end
  else if FCursorName <> '' then begin
    AName := 'crsName';
    AValue := FCursorName;
  end
  else begin
    AName := '<direct>';
    AValue := '';
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
procedure TPgStatement.Check(AHandle: PPGresult);
begin
  FConnection.CheckResult(AHandle, OwningObj);
end;

{-------------------------------------------------------------------------------}
procedure TPgStatement.Reset;
begin
  FCurrentRow := -1;
  FRowsSelected := 0;
  FRowsAffected := -1;
  FClosed := True;
  FEOF := True;
  FLastRowset := True;
  FResultFormat := 1;
  FFields.Count := 0;
end;

{-------------------------------------------------------------------------------}
procedure TPgStatement.Clear;
begin
  if FHandle <> nil then begin
    Lib.FPQclear(FHandle);
    FHandle := nil;
  end;
end;

{-------------------------------------------------------------------------------}
function TPgStatement.InternalPrepare(const ASQL: String; AUseParams: Boolean): String;

  procedure SQLPrepare(const AStmtName, ASQL: String);
  var
    i: Integer;
    sPrepSQLPrefix: String;

{$IFDEF FireDAC_MONITOR}
    procedure Trace1;
    begin
      Env.Trace('PREPARE', ['ppgconn', FConnection.FHandle,
        'stmtname', AStmtName, 'sql', ASQL]);
    end;
{$ENDIF}

  begin
    sPrepSQLPrefix := 'PREPARE "' + AStmtName + '"';
    if AUseParams and (FParams.Count > 0) then begin
      sPrepSQLPrefix := sPrepSQLPrefix + ' (';
      for i := 0 to FParams.Count - 1 do begin
        if i > 0 then
          sPrepSQLPrefix := sPrepSQLPrefix + ', ';
        if FParams[i].TypeRef = nil then
          sPrepSQLPrefix := sPrepSQLPrefix + 'unknown'
        else
          sPrepSQLPrefix := sPrepSQLPrefix + FParams[i].TypeRef.DumpType;
      end;
      sPrepSQLPrefix := sPrepSQLPrefix + ')';
    end;
    sPrepSQLPrefix := sPrepSQLPrefix + ' AS ';
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    FConnection.ExecuteQuery(sPrepSQLPrefix + ASQL);
  end;

  procedure LibPrepare(const AStmtName, ASQL: String);
  var
    hPrepare: PPgresult;
    sSQL, sStmtName: TFDByteString;
    iPars: Integer;
    pValTypes: Pointer;

{$IFDEF FireDAC_MONITOR}
    procedure Trace1;
    begin
      Env.Trace(sPQprepare, ['ppgconn', FConnection.FHandle,
        'stmtname', AStmtName, 'sql', ASQL, 'nParams', iPars]);
    end;
{$ENDIF}

  begin
    sSQL := FConnection.Encoder.Encode(ASQL);
    sStmtName := FConnection.Encoder.Encode(AStmtName);
    if AUseParams then begin
      iPars := FParams.Count;
      pValTypes := FParams.GetValueTypes;
    end
    else begin
      iPars := 0;
      pValTypes := nil;
    end;
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}

    hPrepare := Lib.FPQprepare(FConnection.FHandle, PFDAnsiString(PByte(sStmtName)),
      PByte(PByte(sSQL)), iPars, pValTypes);
    try
      Check(hPrepare);
    finally
      Lib.FPQclear(hPrepare);
    end;
  end;

begin
  Result := FConnection.GenerateName;
  // libpq version < 8
  if not Assigned(Lib.FPQprepare) then
    SQLPrepare(Result, ASQL)
  else
    LibPrepare(Result, ASQL);
end;

{-------------------------------------------------------------------------------}
procedure TPgStatement.PrepareSQL(const ASQL: String);
const
  C_HOLD: array [Boolean] of String = (' ', ' WITH HOLD ');
begin
  Reset;
  try
    if ((CompareText(Copy(ASQL, 1, 6), 'SELECT') = 0) or
        (CompareText(Copy(ASQL, 1, 4), 'WITH') = 0)) and
       (RowsetSize > 0) and Assigned(Lib.FPQprepare) then begin
      FCursorName := FConnection.GenerateName;
      FStmtName := InternalPrepare('DECLARE "' + FCursorName + '" CURSOR' +
        C_HOLD[WithHold] + 'FOR ' + ASQL, True);
      FRowsetStmtName := InternalPrepare('FETCH FORWARD ' + IntToStr(RowsetSize) +
        ' FROM "' + FCursorName + '"', False);
    end
    else begin
      FCursorName := '';
      FStmtName := InternalPrepare(ASQL, True);
      FRowsetStmtName := '';
    end;
  except
    Unprepare;
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgStatement.PrepareCursor(const ACursorName: String);
begin
  Reset;
  try
    FCursorName := ACursorName;
    if RowsetSize > 0 then begin
      FRowsetStmtName := InternalPrepare('FETCH FORWARD ' + IntToStr(RowsetSize) +
        ' FROM "' + FCursorName + '"', False);
      FStmtName := '';
    end
    else begin
      FRowsetStmtName := '';
      FStmtName := InternalPrepare('FETCH ALL FROM "' + FCursorName + '"', False);
    end;
  except
    Unprepare;
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgStatement.DescribeFields;
var
  i, iModifier: Integer;
  oFld: TPgField;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  var
    sName: String;
    sVal: String;
  begin
    GetStmtName(sName, sVal);
    Env.Trace('DescribeFields', ['ppgconn', FConnection.FHandle, sName, sVal,
      'nFields', FFields.Count]);
  end;
{$ENDIF}

begin
  FFields.Count := Lib.FPQnfields(FHandle);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  for i := 0 to FFields.Count - 1 do begin
    oFld := FFields[i];
    oFld.FName := FConnection.Encoder.Decode(Lib.FPQfname(FHandle, i), -1);
    oFld.TypeOid := Lib.FPQftype(FHandle, i);
    oFld.FTableOid := Lib.FPQftable(FHandle, i);
    oFld.FTableCol := Lib.FPQftablecol(FHandle, i);
    iModifier := Lib.FPQfmod(FHandle, i);
    oFld.SetDefaults;
    if [paArray, paRecord, paRange] * oFld.TypeRef.Attrs = [] then
      FConnection.TypesManager.DecodeModifier(oFld.FTypeOid, iModifier,
        oFld.FLen, oFld.FPrec, oFld.FScale);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgStatement.GetResultInfo;
var
  iPos: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sPQcmdStatus, ['ppgresult', FHandle, 'stmttype', SQLStmtType,
      'rowsaffected', RowsAffected, 'oid', LastInsertOid]);
  end;

  procedure Trace2;
  begin
    Env.Trace(sPQntuples, ['ppgresult', FHandle, 'rowsselected', RowsSelected]);
  end;
{$ENDIF}

begin
  // retrieve result information
  // status string may contain LastInsertOid and RowsAffected information
  FSQLStmtType := FConnection.Encoder.Decode(Lib.FPQcmdStatus(FHandle), -1);
  iPos := Pos(' ', SQLStmtType);
  if iPos > 0 then
    Delete(FSQLStmtType, iPos, Length(SQLStmtType) - iPos + 1);

  FRowsAffected := StrToIntDef(FConnection.Encoder.Decode(Lib.FPQcmdTuples(FHandle), -1), 0);

  // FPQoidValue returns InvalidOid if table was created without Oids
  FLastInsertOid := Lib.FPQoidValue(FHandle);
  FConnection.FLastInsertOid := LastInsertOid;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}

  // records count
  FRowsSelected := Lib.FPQntuples(FHandle);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace2;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TPgStatement.InternalExecute(const AStmtName: String; AnParams: Integer;
  AParamValues: Pointer; AParamLengths: PInteger; AParamFormats: PInteger;
  AResultFormat: Integer);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sPQexecPrepared, ['ppgconn', FConnection.FHandle,
      'stmtname', AStmtName, 'nParams', AnParams, 'resultFormat', ResultFormat]);
  end;
{$ENDIF}

var
  sStmtName: TFDByteString;
begin
  Clear;
  FResultFormat := AResultFormat;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  sStmtName := FConnection.Encoder.Encode(AStmtName);
  FHandle := Lib.FPQexecPrepared(FConnection.FHandle, PFDAnsiString(PByte(sStmtName)),
    AnParams, AParamValues, AParamLengths, AParamFormats, AResultFormat);
  Check(FHandle);
end;

{-------------------------------------------------------------------------------}
procedure TPgStatement.InternalExecute(AResultFormat: Integer);
var
  pValueRefs: Pointer;
begin
  Reset;
  FConnection.ClearNotices;

{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then DumpInVars;
{$ENDIF}

  if FStmtName <> '' then
    try
      pValueRefs := FParams.GetValueRefs;
      InternalExecute(FStmtName, FParams.Count, pValueRefs,
        FParams.GetValueLengths, FParams.GetValueFormats, AResultFormat);
    finally
      GetResultInfo;
    end;

  GetNextRowset;
  FEOF := False;
  FClosed := False;
  FLastRowset := False;
end;

{-------------------------------------------------------------------------------}
procedure TPgStatement.Execute;
begin
  try
    InternalExecute(1);
  except
    on E: EPgNativeException do
      if (TFDPgError(E[0]).ErrorCode = '42883') and
         (TFDPgError(E[0]).Message = 'no binary output function available for type void') then
        InternalExecute(0)
      else
        raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgStatement.InternalExecuteDirect(const ASQL: String; AResultFormat: Integer);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sPQexec, ['ppgconn', FConnection.FHandle, 'sql', ASQL]);
  end;

  procedure Trace2;
  begin
    Env.Trace(sPQexecParams, ['ppgconn', FConnection.FHandle, 'sql', ASQL,
      'nParams', FParams.Count, 'resultFormat', ResultFormat]);
  end;
{$ENDIF}

var
  pValueRefs: Pointer;
begin
  Reset;
  FConnection.ClearNotices;

  Clear;
  try
    if FParams.Count = 0 then begin
      FResultFormat := 0;
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then
        Trace1;
{$ENDIF}
      FHandle := Lib.FPQexec(FConnection.FHandle, PByte(
        FConnection.Encoder.Encode(ASQL)));
    end
    else begin
      FResultFormat := AResultFormat;
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then begin
        DumpInVars;
        Trace2;
      end;
{$ENDIF}
      pValueRefs := FParams.GetValueRefs;
      FHandle := Lib.FPQexecParams(FConnection.FHandle, PByte(
        FConnection.Encoder.Encode(ASQL)), FParams.Count, FParams.GetValueTypes,
        pValueRefs, FParams.GetValueLengths, FParams.GetValueFormats,
        AResultFormat);
    end;
    Check(FHandle);
  finally
    GetResultInfo;
  end;

  GetNextRowset;
  FEOF := False;
  FClosed := False;
  FLastRowset := False;
end;

{-------------------------------------------------------------------------------}
procedure TPgStatement.ExecuteDirect(const ASQL: String);
begin
  try
    InternalExecuteDirect(ASQL, 1);
  except
    on E: EPgNativeException do
      if (TFDPgError(E[0]).ErrorCode = '42883') and
         (TFDPgError(E[0]).Message = 'no binary output function available for type void') then
        InternalExecuteDirect(ASQL, 0)
      else
        raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgStatement.GetNextRowset;
var
  iRows: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sPQntuples, ['ppgresult', FHandle, 'rowsselected', iRows]);
  end;
{$ENDIF}

begin
  if FRowsetStmtName = '' then
    Exit;
  try
    InternalExecute(FRowsetStmtName, 0, nil, nil, nil, 1);
  except
    FLastRowset := True;
    FEOF := True;
    raise;
  end;

  iRows := Lib.FPQntuples(FHandle);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}

  FRowsetOffset := RowsSelected;
  FRowsSelected := RowsSelected + iRows;
  FLastRowset := iRows < RowsetSize;
end;

{-------------------------------------------------------------------------------}
function TPgStatement.Fetch: Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  var
    sName: String;
    sVal: String;
  begin
    GetStmtName(sName, sVal);
    Env.Trace('FETCH', ['ppgresult', FHandle, sName, sVal]);
  end;

  procedure Trace2;
  begin
    Env.Trace(ekCmdDataOut, esProgress, 'EOF', []);
  end;
{$ENDIF}

begin
  if EOF then begin
    Result := False;
    Exit;
  end;

{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Inc(FCurrentRow);
  if not FLastRowset and (FCurrentRow = RowsSelected) and (RowsSelected > 0) then
    GetNextRowset;

  FEOF := FCurrentRow = RowsSelected;
  Result := not EOF;

  if EOF then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace2;
{$ENDIF}
    Close;
  end
{$IFDEF FireDAC_MONITOR}
  else
    if Env.Tracing then DumpOutVars;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TPgStatement.Close;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  var
    sName: String;
    sVal: String;
  begin
    GetStmtName(sName, sVal);
    Env.Trace(sPQclear, ['ppgresult', FHandle, sName, sVal]);
  end;
{$ENDIF}

begin
  if Closed then
    Exit;
  try
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    Clear;

    FClosed := True;
    FEOF := True;
    FLastRowset := True;

    if (FCursorName <> '') and
       not (FConnection.TransactionStatus in [PQTRANS_INERROR, PQTRANS_UNKNOWN]) then
      FConnection.ExecuteQuery('CLOSE "' + FCursorName + '"');
  except
    on E: EPgNativeException do
      if E.Kind <> ekServerGone then
        raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgStatement.InternalUnprepare(var AStmtName: String);
var
  sTmpStmtName: String;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace('DEALLOCATE', ['ppgconn', FConnection.FHandle,
      'stmtname', sTmpStmtName]);
  end;
{$ENDIF}

begin
  if AStmtName = '' then
    Exit;
  try
    sTmpStmtName := AStmtName;
    AStmtName := '';

    if not (FConnection.TransactionStatus in [PQTRANS_INERROR, PQTRANS_UNKNOWN]) then begin
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then Trace1;
{$ENDIF}
      FConnection.ExecuteQuery('DEALLOCATE "' + sTmpStmtName + '"');
    end;
  except
    on E: EPgNativeException do
      if E.Kind <> ekServerGone then
        raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgStatement.Unprepare;
begin
  FCursorName := '';
  InternalUnPrepare(FStmtName);
  InternalUnPrepare(FRowsetStmtName);
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
procedure TPgStatement.DumpInVars;
var
  i: Integer;
  oPar: TPgParam;
begin
  if Env.Tracing and (FParams.Count > 0) then begin
    Env.Trace(ekCmdDataIn, esStart, 'Sent', []);
    for i := 0 to FParams.Count - 1 do begin
      oPar := FParams[i];
      Env.Trace(ekCmdDataIn, esProgress, 'Var',
        [String('N'), i, 'Name', oPar.DumpLabel, '@Type', oPar.DumpSQLDataType,
         'Size', oPar.Size, '@Data(0)', oPar.DumpValue]);
    end;
    Env.Trace(ekCmdDataIn, esEnd, 'Sent', []);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgStatement.DumpOutVars;
var
  i: Integer;
  oFld: TPgField;
begin
  if Env.Tracing and (FFields.Count > 0) then begin
    Env.Trace(ekCmdDataOut, esStart, 'Fetched', []);
    for i := 0 to FFields.Count - 1 do begin
      oFld := FFields[i];
      Env.Trace(ekCmdDataOut, esProgress, 'Field',
        [String('N'), i, 'Name', oFld.DumpLabel, '@Type', oFld.DumpSQLDataType,
         'Prec', oFld.Prec, 'Scale', oFld.Scale, 'Size', oFld.Len, '@Data', oFld.DumpValue]);
    end;
    Env.Trace(ekCmdDataOut, esEnd, 'Fetched', []);
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TPgLargeObject                                                                }
{-------------------------------------------------------------------------------}
constructor TPgLargeObject.Create(AConnection: TPgConnection; AMode: TFDStreamMode;
  AOwningObj: TObject);
begin
  inherited Create(AConnection.Env, AOwningObj);
  FConnection := AConnection;
  FMode := AMode;
end;

{-------------------------------------------------------------------------------}
constructor TPgLargeObject.Create(AConnection: TPgConnection; AMode: TFDStreamMode;
  AOwningObj: TObject; AObjOid: Oid);
begin
  Create(AConnection, AMode, AOwningObj);
  FObjOid := AObjOid;
end;

{-------------------------------------------------------------------------------}
destructor TPgLargeObject.Destroy;
begin
  if IsOpen then
    Close(True);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TPgLargeObject.Mode2PGMode: Integer;
begin
  case Mode of
  smOpenRead:      Result := INV_READ;
  smOpenWrite:     Result := INV_WRITE;
  smOpenReadWrite: Result := INV_READ or INV_WRITE;
  else             begin Result := 0; ASSERT(False); end;
  end;
end;

{-------------------------------------------------------------------------------}
function TPgLargeObject.GetLen: Integer;
var
  iPosition: Integer;
begin
  iPosition := FPosition;
  Result := Seek(0, soFromEnd);
  Seek(iPosition, soFromBeginning);
end;

{-------------------------------------------------------------------------------}
procedure TPgLargeObject.SetLen(const AValue: Integer);
var
  iResult: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(slo_truncate, ['conn', FConnection.FHandle, 'objoid', FObjOid,
      'len', AValue, 'Result', iResult]);
  end;
{$ENDIF}

begin
  ASSERT(IsOpen);
  CheckReadWrite;
  if Assigned(Lib.Flo_truncate) then begin
    iResult := Lib.Flo_truncate(FConnection.FHandle, FObjHandle, AValue);
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    if iResult < 0 then
      Error('truncate', iResult);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TPgLargeObject.Error(const AOperation: String; AStatus: Integer);
var
  sMsg: String;
begin
  sMsg := FConnection.Encoder.Decode(Lib.FPQerrorMessage(FConnection.FHandle), -1);
  if sMsg = '' then
    sMsg := 'cannot ' + AOperation + ' large object';
  DoError(sMsg, AStatus);
end;

{-------------------------------------------------------------------------------}
procedure TPgLargeObject.CheckReadWrite;
begin
  if Mode = smOpenRead then
    Error('write read-only', -1);
end;

{-------------------------------------------------------------------------------}
procedure TPgLargeObject.CreateObj;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(slo_creat, ['conn', FConnection.FHandle, 'objoid', FObjOid]);
  end;
{$ENDIF}

begin
  FObjOid := Lib.Flo_creat(FConnection.FHandle, Mode2PGMode());
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if FObjOid = InvalidOid then
    Error('create', FObjOid);
end;

{-------------------------------------------------------------------------------}
procedure TPgLargeObject.Open;
var
  iMode: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(slo_open, ['conn', FConnection.FHandle, 'objoid', FObjOid,
      'mode', iMode, 'objhandle', FObjHandle]);
  end;
{$ENDIF}

begin
  ASSERT(not IsOpen);
  iMode := Mode2PGMode();
  FObjHandle := Lib.Flo_open(FConnection.FHandle, FObjOid, iMode);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if FObjHandle < 0 then
    Error('open', FObjHandle);
  FIsOpen := True;
end;

{-------------------------------------------------------------------------------}
procedure TPgLargeObject.Close(AIgnoreErrors: Boolean);
var
  iResult: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(slo_close, ['conn', FConnection.FHandle, 'objoid', FObjOid,
      'objhandle', FObjHandle, 'Result', iResult]);
  end;
{$ENDIF}

begin
  ASSERT(IsOpen);
  iResult := Lib.Flo_close(FConnection.FHandle, FObjHandle);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if (iResult < 0) and not AIgnoreErrors then
    Error('close', iResult);
  FIsOpen := False;
  FPosition := 0;
  FObjHandle := 0;
end;

{-------------------------------------------------------------------------------}
procedure TPgLargeObject.UnLink;
var
  iResult: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(slo_unlink, ['conn', FConnection.FHandle,
      'objoid', FObjOid, 'Result', iResult]);
  end;
{$ENDIF}

begin
  ASSERT(FObjHandle = 0);
  CheckReadWrite;
  iResult := Lib.Flo_unlink(FConnection.FHandle, FObjOid);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if iResult < 0 then
    Error('unlink', iResult);
end;

{-------------------------------------------------------------------------------}
function TPgLargeObject.Seek(AOffset: Integer; ASeekOrigin: Word): Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(slo_lseek, ['conn', FConnection.FHandle, 'objoid', FObjOid,
      'objhandle', FObjHandle, 'offset', AOffset, 'seekorigin', ASeekOrigin,
      'Result', Result]);
  end;
{$ENDIF}

begin
  Result := Lib.Flo_lseek(FConnection.FHandle, FObjHandle, AOffset, ASeekOrigin);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if Result < 0 then
    Error('lseek', Result);
  FPosition := Result;
end;

{-------------------------------------------------------------------------------}
function TPgLargeObject.Read(ABuff: PByte; ABuffLen: Integer): Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(slo_read, ['conn', FConnection.FHandle, 'objoid', FObjOid,
      'objhandle', FObjHandle, 'buflen', ABuffLen, 'Result', Result]);
  end;
{$ENDIF}

begin
  ASSERT(IsOpen);
  Result := Lib.Flo_read(FConnection.FHandle, FObjHandle, ABuff, ABuffLen);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if Result < 0 then
    Error('read', Result);
  Inc(FPosition, Result);
end;

{-------------------------------------------------------------------------------}
function TPgLargeObject.Write(ABuff: PByte; ABuffLen: Integer): Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(slo_write, ['conn', FConnection.FHandle, 'objoid', FObjOid,
      'objhandle', FObjHandle, 'buflen', ABuffLen, 'Result', Result]);
  end;
{$ENDIF}

begin
  ASSERT(IsOpen);
  CheckReadWrite;
  Result := Lib.Flo_write(FConnection.FHandle, FObjHandle, ABuff, ABuffLen);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if Result < 0 then
    Error('write', Result);
  Inc(FPosition, Result);
end;

{-------------------------------------------------------------------------------}
{ TPgLargeObjectStream                                                          }
{-------------------------------------------------------------------------------}
constructor TPgLargeObjectStream.Create(ALargeObject: TPgLargeObject);
begin
  inherited Create;
  FLargeObject := ALargeObject;
end;

{-------------------------------------------------------------------------------}
destructor TPgLargeObjectStream.Destroy;
begin
  FDFreeAndNil(FLargeObject);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TPgLargeObjectStream.Read(var Buffer; Count: Longint): Longint;
begin
  Result := FLargeObject.Read(PByte(@Buffer), Count);
end;

{-------------------------------------------------------------------------------}
function TPgLargeObjectStream.Write(const Buffer; Count: Longint): Longint;
begin
  Result := FLargeObject.Write(PByte(@Buffer), Count);
end;

{-------------------------------------------------------------------------------}
function TPgLargeObjectStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  Result := FLargeObject.Seek(Offset, Word(Origin));
end;

{-------------------------------------------------------------------------------}
procedure TPgLargeObjectStream.SetSize(const NewSize: Int64);
begin
  FLargeObject.Len := NewSize;
end;

{-------------------------------------------------------------------------------}
function PgNativeExceptionLoad(const AStorage: IFDStanStorage): TObject;
begin
  Result := EPgNativeException.Create;
  EPgNativeException(Result).LoadFromStorage(AStorage);
end;

{-------------------------------------------------------------------------------}
initialization
  FDStorageManager().RegisterClass(EPgNativeException, 'PgNativeException',
    @PgNativeExceptionLoad, @FDExceptionSave);

end.

