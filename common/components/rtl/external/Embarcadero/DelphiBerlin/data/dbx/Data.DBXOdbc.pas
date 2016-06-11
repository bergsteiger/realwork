{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DbxOdbc;

interface

uses System.Classes, System.JSON, Data.DBXCommon,
  Data.DBXPlatform, Data.FmtBcd, System.Odbc, Data.SqlTimSt, System.SysUtils
{$IFNDEF POSIX}
  , Winapi.Windows
{$ENDIF}
;

{$IFDEF WIN32}
{$HPPEMIT ''}
{$HPPEMIT '#ifndef USEPACKAGES'}
{$HPPEMIT '/* automatically link to odbc32.lib */'}
{$HPPEMIT '#pragma link "odbc32.lib"'}
{$HPPEMIT '#endif'}
{$HPPEMIT ''}
{$ENDIF WIN32}

type
  OdbcHandle = Pointer;

  TDBXOdbcProperties = class(TDBXProperties)
  public
    constructor Create(DBXContext: TDBXContext); override;
  end;

  TDBXOdbcDriver = class(TDBXDriver)
  private
    FEnvironmentHandle: OdbcHandle;

    procedure CheckResult(ReturnValue: SmallInt);
    function CreateOdbcCommand(DbxContext: TDBXContext;
      Connection: TDBXConnection; MorphicCommand: TDBXCommand): TDBXCommand;
  protected
    procedure Close; override;
    function CreateConnection(ConnectionBuilder: TDBXConnectionBuilder): TDBXConnection; override;
    procedure LoadDriver(DBXContext: TDBXContext);
  public
    constructor Create(DriverDef: TDBXDriverDef); overload; override;
    destructor Destroy; override;
    procedure GetDriverPropertyNames(List: TStrings); override;
    function GetDriverVersion: string; override;
  end;

  TDBXOdbcCommand = class;

  TDBXOdbcConnection = class(TDBXConnection)
  private
    FEnvironmentHandle: OdbcHandle;
    FConnectionHandle: OdbcHandle;
    FTransactionId: Integer;

    procedure CheckResult(ReturnValue: SmallInt);
  protected
    function CreateAndBeginTransaction(const Isolation: TDBXIsolation): TDBXTransaction; override;
    procedure Commit(const InTransaction: TDBXTransaction); override;
    procedure DerivedClose; override;
    procedure DerivedGetCommands(const CommandType: string;
      const List: TStrings); override;
    procedure DerivedGetCommandTypes(const List: TStrings); override;
    procedure DerivedOpen; override;
    function GetDatabaseMetaData: TDBXDatabaseMetaData; override;
    function GetProductName: string; override;
    function GetProductVersion: string; override;
    procedure Rollback(const InTransaction: TDBXTransaction); override;
  public
    constructor Create(ConnectionBuilder: TDBXConnectionBuilder;
      EnvironmentHandle, ConnectionHandle: OdbcHandle);
    function CreateOdbcCommand: TDBXOdbcCommand; virtual;
    destructor Destroy; override;
    function GetVendorProperty(const Name: string): string; override;
    property ConnectionHandle: OdbcHandle read FConnectionHandle;
    property DatabaseMetaData: TDBXDatabaseMetaData read GetDatabaseMetaData;
    property EnvironmentHandle: OdbcHandle read FEnvironmentHandle;
  end;

  //Forward declaration
  TDBXOdbcRow = class;

  TDBXOdbcCommand = class(TDBXCommand)
  private
    FEnvironmentHandle: OdbcHandle;
    FConnectionHandle: OdbcHandle;
    FCommandHandle: OdbcHandle;
    FOdbcConnection: TDBXOdbcConnection;
    FRowsAffected: Int64;
    FRowSetSize: Int64;
    FParameterRow: TDBXOdbcRow;

    procedure BindParameters;
    procedure CheckResult(ReturnValue: SmallInt);
    procedure CheckResultConnHandle(ReturnValue: SmallInt);
    procedure ExecuteCatalogFunction;
    function GetNumberOfColumns: Int64;
    function IsFunction: Boolean;
    procedure PutBlobs;
    procedure SetParameterValues;
    procedure SetRowsAffected;
  protected
    function CreateParameterRow: TDBXRow; override;
    procedure DerivedClose; override;
    function DerivedExecuteQuery: TDBXReader; override;
    procedure DerivedExecuteUpdate; override;
    function DerivedGetNextReader: TDBXReader; override;
    procedure DerivedOpen; override;
    procedure DerivedPrepare; override;
    function GetRowsAffected: Int64; override;
    procedure SetMaxBlobSize(const MaxBlobSize: Int64); override;
    procedure SetRowSetSize(const RowSetSize: Int64); override;
  public
    constructor Create(DBXContext: TDBXContext; OdbcConnection: TDBXOdbcConnection);
    destructor Destroy; override;
  end;

  TDBXOdbcByteReader = class(TDBXByteReader)
  private
    FEnvironmentHandle: OdbcHandle;
    FConnectionHandle: OdbcHandle;
    FCommandHandle: OdbcHandle;

    function CalculateOffset(ColNum: Integer): Int64;
    procedure CheckResult(ReturnValue: SmallInt);
  protected
    FRow: TDBXOdbcRow;
    constructor Create(DBXContext: TDBXContext; EnvironmentHandle, ConnectionHandle, CommandHandle: OdbcHandle);
  public
    destructor Destroy; override;
    procedure GetAnsiString(Ordinal: TInt32; const Value: TArray<Byte>;
      Offset: TInt32; var IsNull: LongBool); override;
    procedure GetWideString(Ordinal: TInt32; const Value: TArray<Byte>;
      Offset: TInt32; var IsNull: LongBool); override;
    procedure GetUInt8(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetInt8(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); overload; override;
    procedure GetUInt16(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetInt16(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetInt32(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetInt64(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetSingle(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetDouble(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetBcd(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetTimeStamp(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetTimeStampOffset(Ordinal: TInt32; const Value: TArray<Byte>;
      Offset: TInt32; var IsNull: LongBool); override;
    procedure GetTime(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetDate(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32;
      var IsNull: LongBool); override;
    procedure GetByteLength(Ordinal: TInt32; var Length: Int64;
      var IsNull: LongBool); override;
    function GetBytes(Ordinal: TInt32; Offset: Int64; const Value: TArray<Byte>;
      ValueOffset: Int64; Length: Int64; var IsNull: LongBool): Int64; override;
  end;

  TDBXOdbcReader = class(TDBXReader)
  private
    FEnvironmentHandle: OdbcHandle;
    FConnectionHandle: OdbcHandle;
    FCommandHandle: OdbcHandle;

    procedure CheckResult(ReturnValue: SmallInt);
    function CreateColumn(Ordinal: Word): TDBXWritableValue;
  protected
    constructor Create(DBXContext: TDBXContext; EnvironmentHandle, ConnectionHandle, CommandHandle: OdbcHandle;
                       ByteReader: TDBXOdbcByteReader; NumCols, RowSetSize: Int64);
    procedure DerivedClose; override;
    function DerivedNext: Boolean; override;
    //Override this if you want to create custom mappings
    procedure SetTypeInfo(Column: TDBXValueType; const SQLDataType: SmallInt); virtual;
  end;

  TDBXOdbcDriverLoader = class(TDBXDriverLoader)
  public
    constructor Create; override;
    function Load(DriverDef: TDBXDriverDef): TDBXDriver; override;
  end;

  TDBXOdbcBlockMgr = class
  private
    FBuffer: TArray<Byte>;
    FCurrentRec: Int64;
    FRecCount: Int64;
    FRowLength: Int64;
    FRowsFetched: Int64;
  public
    constructor Create(RowLength, RowCount: Int64);
    destructor Destroy; override;
    procedure Next;
    procedure Reset;
    property Buffer: TArray<Byte> read FBuffer;
    property CurrentRecord: Int64 read FCurrentRec;
    property RowLength: Int64 read FRowLength;
    property RowsFetched: Int64 read FRowsFetched;
  end;

  TDBXOdbcRow = class(TDBXRow)
  private
    FBlock: TDBXOdbcBlockMgr;
    FColumnTypes: array of SmallInt;
    FCommandHandle: OdbcHandle;
    FConnectionHandle: OdbcHandle;
    FEnvironmentHandle: OdbcHandle;
    FIndicatorSize: Integer;
    FOffsets: array of Int64;

    function CalculateOffset(ColNum: Integer): Int64;
  protected
    procedure GetAnsiString(DbxValue: TDBXAnsiStringValue;
      var AnsiStringBuilder: TDBXAnsiStringBuilder; var IsNull: LongBool); override;
    procedure GetWideString(DbxValue: TDBXWideStringValue;
      var WideStringBuilder: TDBXWideStringBuilder; var IsNull: LongBool); overload; override;
    procedure GetBoolean(DbxValue: TDBXBooleanValue; var Value: LongBool;
      var IsNull: LongBool); override;
    procedure GetUInt8(DbxValue: TDBXUInt8Value; var Value: Byte;
      var IsNull: LongBool); override;
    procedure GetInt8(DbxValue: TDBXInt8Value; var Value: ShortInt;
      var IsNull: LongBool); override;
    procedure GetUInt16(DbxValue: TDBXUInt16Value; var Value: Word;
      var IsNull: LongBool); override;
    procedure GetInt16(DbxValue: TDBXInt16Value; var Value: SmallInt;
      var IsNull: LongBool); override;
    procedure GetInt32(DbxValue: TDBXInt32Value; var Value: TInt32;
      var IsNull: LongBool); override;
    procedure GetInt64(DbxValue: TDBXInt64Value; var Value: Int64;
      var IsNull: LongBool); override;
    procedure GetSingle(DbxValue: TDBXSingleValue; var Value: Single;
      var IsNull: LongBool); override;
    procedure GetDouble(DbxValue: TDBXDoubleValue; var Value: Double;
      var IsNull: LongBool); override;
    procedure GetBcd(DbxValue: TDBXBcdValue; var Value: TBcd;
      var IsNull: LongBool); override;
    procedure GetDate(DbxValue: TDBXDateValue; var Value: TDBXDate;
      var IsNull: LongBool); override;
    procedure GetTime(DbxValue: TDBXTimeValue; var Value: TDBXTime;
      var IsNull: LongBool); override;
    procedure GetTimeStamp(DbxValue: TDBXTimeStampValue;
      var Value: TSQLTimeStamp; var IsNull: LongBool); override;
    procedure GetTimeStampOffset(DbxValue: TDBXTimeStampOffsetValue;
      var Value: TSQLTimeStampOffset; var IsNull: LongBool); override;
    procedure GetBytes(DbxValue: TDBXByteArrayValue; Offset: Int64;
      const Buffer: TArray<Byte>; BufferOffset: Int64; Length: Int64;
      var ReturnLength: Int64; var IsNull: LongBool); override;
    procedure GetByteLength(DbxValue: TDBXByteArrayValue; var ByteLength: Int64;
      var IsNull: LongBool); override;
    procedure SetNull(DbxValue: TDBXValue); override;
    procedure SetString(DbxValue: TDBXAnsiStringValue; const Value: AnsiString); override;
    procedure SetWideString(DbxValue: TDBXWideStringValue;
      const Value: string); override;
    procedure SetAnsiString(DbxValue: TDBXAnsiStringValue;
      const Value: AnsiString); override;
    procedure SetUInt8(DbxValue: TDBXUInt8Value; Value: Byte); override;
    procedure SetInt8(DbxValue: TDBXInt8Value; Value: ShortInt); override;
    procedure SetUInt16(DbxValue: TDBXUInt16Value; Value: Word); override;
    procedure SetInt16(DbxValue: TDBXInt16Value; Value: SmallInt); override;
    procedure SetInt32(DbxValue: TDBXInt32Value; Value: TInt32); override;
    procedure SetInt64(DbxValue: TDBXInt64Value; Value: Int64); override;
    procedure SetSingle(DbxValue: TDBXSingleValue; Value: Single); override;
    procedure SetDouble(DbxValue: TDBXDoubleValue; Value: Double); override;
    procedure SetBCD(DbxValue: TDBXBcdValue; var Value: TBcd); override;
    procedure SetDate(DbxValue: TDBXDateValue; Value: TDBXDate); override;
    procedure SetTime(DbxValue: TDBXTimeValue; Value: TDBXTime); override;
    procedure SetTimestamp(DbxValue: TDBXTimeStampValue;
      var Value: TSQLTimeStamp); override;
    procedure SetDynamicBytes(DbxValue: TDBXValue; Offset: Int64;
      const Buffer: TArray<Byte>; BufferOffset: Int64; Length: Int64); override;
    procedure SetValueType(ValueType: TDBXValueType); override;
    procedure GetStream(DbxValue: TDBXStreamValue; var Stream: TStream;
      var IsNull: LongBool); overload; override;
    procedure SetAnsiMemo(DbxValue: TDBXAnsiMemoValue; const Value: AnsiString); override;
    procedure SetWideMemo(DbxValue: TDBXWideMemoValue;
      const Value: string); override;
    procedure SetBoolean(DbxValue: TDBXBooleanValue; Value: Boolean); override;
    procedure GetLength(DbxValue: TDBXValue; var ByteLength: Int64;
      var IsNull: LongBool); override;
  public
    constructor Create(DBXContext: TDBXContext; EnvironmentHandle, ConnectionHandle, CommandHandle: OdbcHandle);
    destructor Destroy; override;
  end;

  TDBXOdbcTransaction = class(TDBXTransaction)
  private
    FId: Integer;
  public
    constructor Create(Connection: TDBXConnection; IsolationLevel: TDBXIsolation; TransactionId: Integer);
  end;

procedure OdbcRaiseError(DBXContext: TDBXContext; ReturnValue, HandleType: SmallInt; Handle: OdbcHandle);

implementation

uses
  System.DateUtils, Data.DBXCommonResStrs, Data.DbxOdbcMetaData, Data.DbxOdbcReadOnlyMetaData,
  Data.DbxOdbcResStrs, System.Math;

const
  sDriverName = 'ODBC';
{$IFDEF MSWINDOWS}
  sVendorLib = 'odbc32.dll';
{$ENDIF}
{$IFDEF MACOS}
  sVendorLib = '/usr/lib/libiodbc.dylib';
{$ENDIF}

  trace_SQLAllocHandle = 'SQLAllocHandle';
  trace_SQLBindCol = 'SQLBindCol';
  trace_SQLBindParameter = 'SQLBindParameter';
  trace_SQLColumns = 'SQLColumns';
  trace_SQLConnect = 'SQLConnect';
  trace_SQLDescribeCol = 'SQLDescribeCol';
  trace_SQLDisconnect = 'SQLDisconnect';
  trace_SQLDriverConnect = 'SQLDriverConnect';
  trace_SQLEndTran = 'SQLEndTran';
  trace_SQLExecDirect = 'SQLExecDirect';
  trace_SQLExecute = 'SQLExecute';
  trace_SQLFetchScroll = 'SQLFetchScroll';
  trace_SQLForeignKeys = 'SQLForeignKeys';
  trace_SQLFreeHandle = 'SQLFreeHandle';
  trace_SQLFreeStmt = 'SQLFreeStmt';
  trace_SQLGetData = 'SQLGetData';
  trace_SQLGetDiagRec = 'SQLGetDiagRec';
  trace_SQLGetInfo = 'SQLGetInfo';
  trace_SQLGetTypeInfo = 'SQLGetTypeInfo';
  trace_SQLNativeSql = 'SQLNativeSql';
  trace_SQLNumResultCols = 'SQLNumResultCols';
  trace_SQLParamData = 'SQLParamData';
  trace_SQLPrepare = 'SQLPrepare';
  trace_SQLProcedureColumns = 'SQLProcedureColumns';
  trace_SQLProcedures = 'SQLProcedures';
  trace_SQLPutData = 'SQLPutData';
  trace_SQLRowCount = 'SQLRowCount';
  trace_SQLSetConnectAttr = 'SQLSetConnectAttr';
  trace_SQLSetEnvAttr = 'SQLSetEnvAttr';
  trace_SQLSetStmtAttr = 'SQLSetStmtAttr';
  trace_SQLStatistics = 'SQLStatistics';
  trace_SQLTables = 'SQLTables';


function GetTypeSize(DataType: TDBXType): Int64;
begin
  case DataType of
    TDBXDataTypes.DateType: Result := SizeOf(SQL_DATE_STRUCT);
    TDBXDataTypes.Int16Type, TDBXDataTypes.BooleanType: Result := SizeOf(SmallInt);
    TDBXDataTypes.Int32Type:
      Result := SizeOf(Integer);
    TDBXDataTypes.DoubleType: Result := SizeOf(Double);
    TDBXDataTypes.TimeType: Result := SizeOf(SQL_TIME_STRUCT);
    TDBXDataTypes.UInt16Type: Result := SizeOf(Word);
    TDBXDataTypes.UInt32Type: Result := SizeOf(LongWord);
    TDBXDataTypes.Int64Type: Result := SizeOf(Int64);
    TDBXDataTypes.UInt64Type: Result := SizeOf(UInt64);
    TDBXDataTypes.TimeStampType: Result := SizeOf(SQL_TIMESTAMP_STRUCT);
    TDBXDataTypes.SingleType: Result := SizeOf(Single);
    TDBXDataTypes.Int8Type: Result := SizeOf(ShortInt);
    TDBXDataTypes.UInt8Type: Result := SizeOf(Byte);
    else
      Result := 1;
  end;
end;

procedure OdbcRaiseError(DBXContext: TDBXContext; ReturnValue, HandleType: SmallInt; Handle: OdbcHandle);
var
  SqlState, MessageText: TArray<Byte>;
  NativeError: Integer;
  ActualLength, BufLen: SmallInt;
begin
  case ReturnValue of
    SQL_ERROR, SQL_SUCCESS_WITH_INFO:
      begin
        //5 character SQLSTATE code and terminating NULL
        SetLength(SqlState, 6*SizeOf(Char));
        //We will return the first status record.  If users wish to retrieve
        //additional status records they can handle the exception and make additional
        //calls to SQLGetDiagRec.
        SQLGetDiagRec(HandleType, Handle, 1, PChar(@SqlState[0]), NativeError,
                      nil, 0, ActualLength);
        //Number of characters + null terminator
        BufLen := (ActualLength+1) * SizeOf(Char);
        SetLength(MessageText, BufLen);
        SQLGetDiagRec(HandleType, Handle, 1, PChar(@SqlState[0]),
                      NativeError, PChar(@MessageText[0]), BufLen, ActualLength);
        DBXContext.Error(ReturnValue, PChar(MessageText));
      end;
    SQL_INVALID_HANDLE: DBXContext.Error(ReturnValue, SInvalidHandle);
  end;
end;

procedure TDBXOdbcDriver.CheckResult(ReturnValue: SmallInt);
begin
  if (ReturnValue <> SQL_SUCCESS) and (ReturnValue <> SQL_SUCCESS_WITH_INFO) then
    OdbcRaiseError(FDBXContext, ReturnValue, SQL_HANDLE_ENV, FEnvironmentHandle);
end;

function TDBXOdbcDriver.CreateOdbcCommand(DbxContext: TDBXContext;
  Connection: TDBXConnection; MorphicCommand: TDBXCommand): TDBXCommand;
begin
  Result := TDBXOdbcCommand.Create(DbxContext, TDBXOdbcConnection(Connection));
end;

procedure TDBXOdbcDriver.Close;
begin
  inherited;
end;

function TDBXOdbcDriver.CreateConnection(ConnectionBuilder: TDBXConnectionBuilder): TDBXConnection;
var
  ConnectionHandle: OdbcHandle;
  ErrorCode:  SmallInt;
begin
  LoadDriver(ConnectionBuilder.DbxContext);
  if not Assigned(FEnvironmentHandle) then
  begin
    ErrorCode := SQLAllocHandle(SQL_HANDLE_ENV, SQLHANDLE(SQL_NULL_HANDLE), SQLHANDLE(FEnvironmentHandle));
    CheckResult(ErrorCode);
    ErrorCode := SQLSetEnvAttr(FEnvironmentHandle, SQL_ATTR_ODBC_VERSION, SQLPOINTER(SQL_OV_ODBC3), 0);
    CheckResult(ErrorCode);
  end;
  ErrorCode := SQLAllocHandle(SQL_HANDLE_DBC, FEnvironmentHandle, SQLHANDLE(ConnectionHandle));
  CheckResult(ErrorCode);
  Result := TDBXOdbcConnection.Create(ConnectionBuilder, FEnvironmentHandle, ConnectionHandle);
end;

procedure TDBXOdbcDriver.LoadDriver(DBXContext: TDBXContext);
begin
  FDBXContext := DBXContext;
end;

constructor TDBXOdbcDriver.Create(DriverDef: TDBXDriverDef);
var
  Props: TDBXOdbcProperties;
  I, Index: Integer;
begin
  Props := TDBXOdbcProperties.Create(DriverDef.FDBXContext);
  if DriverDef.FDriverProperties <> nil then
  begin
    for I := 0 to DriverDef.FDriverProperties.Count - 1 do
    begin
      Index := Props.Properties.IndexOfName(DriverDef.FDriverProperties.Properties.Names[I]);
      if Index > -1 then
        Props.Properties.Strings[Index] := DriverDef.FDriverProperties.Properties.Strings[I];
    end;
    Props.AddUniqueProperties(DriverDef.FDriverProperties.Properties);
    DriverDef.FDriverProperties.AddUniqueProperties(Props.Properties);
  end;
  inherited Create(DriverDef);
  rcs;
  FEnvironmentHandle := nil;
  // '' makes this the default command factory.
  AddCommandFactory('', CreateOdbcCommand);
  InitDriverProperties(Props);
  if (DriverProperties = nil) or not DriverProperties.GetBoolean(TDBXPropertyNames.AutoUnloadDriver) then
    CacheUntilFinalization;
end;

destructor TDBXOdbcDriver.Destroy;
var
  ErrorCode:  SmallInt;
begin
  if Assigned(FEnvironmentHandle) then
  begin
    ErrorCode := SQLFreeHandle(SQL_HANDLE_ENV, FEnvironmentHandle);
    CheckResult(ErrorCode);
  end;
  FEnvironmentHandle := nil;
  inherited Destroy;
end;

procedure TDBXOdbcDriver.GetDriverPropertyNames(List: TStrings);
begin
  List.Add(TDBXPropertyNames.DriverUnit);
  List.Add(TDBXPropertyNames.DriverPackageLoader);
  List.Add(TDBXPropertyNames.MetaDataPackageLoader);
end;

function TDBXOdbcDriver.GetDriverVersion: string;
begin
  Result := DBXVersion40;
end;

procedure TDBXOdbcConnection.CheckResult(ReturnValue: SmallInt);
begin
  if (ReturnValue <> SQL_SUCCESS) and (ReturnValue <> SQL_SUCCESS_WITH_INFO) then
    OdbcRaiseError(FDBXContext, ReturnValue, SQL_HANDLE_DBC, FConnectionHandle);
end;

function TDBXOdbcConnection.CreateAndBeginTransaction(const Isolation: TDBXIsolation): TDBXTransaction;
var
  ErrorCode: SmallInt;
begin
  Inc(FTransactionId);
  FDBXContext.Trace(0, trace_SQLSetConnectAttr);
  ErrorCode := SQLSetConnectAttr(FConnectionHandle, SQL_ATTR_AUTOCOMMIT, SQLPOINTER(SQL_AUTOCOMMIT_OFF), 0);
  CheckResult(ErrorCode);
  Result := TDBXOdbcTransaction.Create(Self, Isolation, FTransactionId);
end;

procedure TDBXOdbcConnection.Commit(const InTransaction: TDBXTransaction);
var
  ErrorCode: SmallInt;
begin
  FDBXContext.Trace(0, trace_SQLEndTran);
  ErrorCode :=  SQLEndTran(SQL_HANDLE_DBC, FConnectionHandle, SQL_COMMIT);
  CheckResult(ErrorCode);
  Dec(FTransactionId);
  if FTransactionId = 0 then
  begin
    FDBXContext.Trace(0, trace_SQLSetConnectAttr);
    ErrorCode := SQLSetConnectAttr(FConnectionHandle, SQL_ATTR_AUTOCOMMIT, SQLPOINTER(SQL_AUTOCOMMIT_ON), 0);
    CheckResult(ErrorCode);
  end;
end;

procedure TDBXOdbcConnection.DerivedClose;
var
  ErrorCode: SmallInt;
begin
  if Assigned(FConnectionHandle) then
  begin
    FDBXContext.Trace(0, trace_SQLDisconnect);
    ErrorCode := SQLDisconnect(FConnectionHandle);
    CheckResult(ErrorCode);
  end;
end;

procedure TDBXOdbcConnection.DerivedGetCommands(const CommandType: string; const List: TStrings);
begin
end;

procedure TDBXOdbcConnection.DerivedGetCommandTypes(const List: TStrings);
begin
end;

procedure TDBXOdbcConnection.DerivedOpen;
var
  DataSourceName, UserName, Password, ConnectionString, IsolationLevel: string;
  ErrorCode, BufLen: SmallInt;
  Isolation: LongWord;
begin
  DataSourceName := FConnectionProperties.Values[TDBXPropertyNames.Database];
  UserName := FConnectionProperties.Values[TDBXPropertyNames.UserName];
  Password := FConnectionProperties.Values[TDBXPropertyNames.Password];
  ConnectionString := FConnectionProperties.Values[TDBXPropertyNames.ConnectionString];
  if ConnectionString <> '' then
{$IFDEF MSWINDOWS}
    ErrorCode := SQLDriverConnect(FConnectionHandle, 0, PChar(@ConnectionString[Low(ConnectionString)]),
                                               ConnectionString.Length, nil, 0, BufLen, SQL_DRIVER_NOPROMPT)
{$ELSE}
    ErrorCode := SQLDriverConnect(FConnectionHandle, nil, PChar(@ConnectionString[Low(ConnectionString)]),
                                               ConnectionString.Length, nil, 0, BufLen, SQL_DRIVER_NOPROMPT)
{$ENDIF}
  else
  begin
    ErrorCode := 0;
    if DataSourceName = '' then
      FDBXContext.Error(1, SInvalidDataSource)
    else if UserName = '' then
      FDBXContext.Error(1, SInvalidUser)
    else if Password = '' then
      ErrorCode := SQLConnect(FConnectionHandle, PChar(@DataSourceName[Low(DataSourceName)]), DataSourceName.Length,
                              PChar(@UserName[Low(UserName)]), UserName.Length, nil, 0)
    else
      ErrorCode := SQLConnect(FConnectionHandle, PChar(@DataSourceName[Low(DataSourceName)]), DataSourceName.Length,
                              PChar(@UserName[Low(UserName)]), UserName.Length, PChar(@Password[Low(Password)]), Password.Length);
  end;
  CheckResult(ErrorCode);
  IsolationLevel := FConnectionProperties.Values[TDBXPropertyNames.IsolationLevel].ToLower;
  if IsolationLevel = 'repeatableread' then
    Isolation := SQL_TXN_REPEATABLE_READ
  else if IsolationLevel = 'dirtyread' then
    Isolation := SQL_TXN_READ_UNCOMMITTED
  else if IsolationLevel = 'serializable' then
    Isolation := SQL_TXN_SERIALIZABLE
  else
    Isolation := SQL_TXN_READ_COMMITTED;
  ErrorCode := SQLSetConnectAttr(FConnectionHandle, SQL_ATTR_TXN_ISOLATION, SqlPointer(Isolation), 0);
  CheckResult(ErrorCode);
end;

function TDBXOdbcConnection.GetDatabaseMetaData: TDBXDatabaseMetaData;
begin
  Result := inherited GetDatabaseMetaData;
end;

function TDBXOdbcConnection.GetProductName: string;
var
  ActualLength, BufLen, ErrorCode: SmallInt;
  ProductName: TArray<Byte>;
begin
  Result := '';
  FDBXContext.Trace(0, trace_SQLGetInfo);
  ErrorCode := SQLGetInfo(FConnectionHandle, SQL_DBMS_NAME, nil, 0, ActualLength);
  CheckResult(ErrorCode);
  BufLen := (ActualLength+1) * SizeOf(Char);
  SetLength(ProductName, BufLen);
  FDBXContext.Trace(0, trace_SQLGetInfo);
  ErrorCode := SQLGetInfo(FConnectionHandle, SQL_DBMS_NAME, SQLPointer(@ProductName[0]), BufLen, ActualLength);
  CheckResult(ErrorCode);
  Result := TDBXPlatform.BytesToWideStr(ProductName);
end;

function TDBXOdbcConnection.GetProductVersion: string;
var
  ActualLength, ErrorCode: SmallInt;
  Version: TArray<Byte>;
begin
  Result := '';
  //The version is of the form ##.##.####
  SetLength(Version, 11*SizeOf(Char));
  ErrorCode := SQLGetInfo(FConnectionHandle, SQL_DBMS_VER, SQLPointer(@Version[0]), 11*SizeOf(Char), ActualLength);
  CheckResult(ErrorCode);
  Result := TDBXPlatform.BytesToWideStr(Version);
end;

procedure TDBXOdbcConnection.Rollback(const InTransaction: TDBXTransaction);
var
  ErrorCode: SmallInt;
begin
  FDBXContext.Trace(0, trace_SQLEndTran);
  ErrorCode :=  SQLEndTran(SQL_HANDLE_DBC, FConnectionHandle, SQL_ROLLBACK);
  CheckResult(ErrorCode);
  Dec(FTransactionId);
  if FTransactionId = 0 then
  begin
    FDBXContext.Trace(0, trace_SQLSetConnectAttr);
    ErrorCode := SQLSetConnectAttr(FConnectionHandle, SQL_ATTR_AUTOCOMMIT, SQLPOINTER(SQL_AUTOCOMMIT_ON), 0);
    CheckResult(ErrorCode);
  end;
end;

constructor TDBXOdbcConnection.Create(ConnectionBuilder: TDBXConnectionBuilder;
      EnvironmentHandle, ConnectionHandle: OdbcHandle);
begin
  inherited Create(ConnectionBuilder);
  FEnvironmentHandle := EnvironmentHandle;
  FConnectionHandle := ConnectionHandle;
  FTransactionId := 0;
end;

function TDBXOdbcConnection.CreateOdbcCommand: TDBXOdbcCommand;
begin
  Result := TDBXOdbcCommand.Create(FDBXContext, Self);
end;

destructor TDBXOdbcConnection.Destroy;
begin
  if Assigned(FConnectionHandle) then
    FDBXContext.Trace(0, trace_SQLFreeHandle);
  inherited Destroy;
  if Assigned(FConnectionHandle) then
    CheckResult(SQLFreeHandle(SQL_HANDLE_DBC, FConnectionHandle));
end;

function TDBXOdbcConnection.GetVendorProperty(const Name: string): string;
begin
  if Name = 'DriverName' then
    Result := 'Odbc'
  else
    Result := '';
end;

function GetCDataTypeFromDbxType(DataType, SubType: SmallInt): SmallInt;
begin
  case DataType of
    TDBXDataTypes.DateType: Result := SQL_C_DATE;
    TDBXDataTypes.BlobType:
      begin
        case SubType of
          TDBXSubDataTypes.MemoSubType: Result := SQL_C_CHAR;
          TDBXSubDataTypes.WideMemoSubType: Result := SQL_C_WCHAR;
          else
            Result := SQL_C_BINARY;
        end;
      end;
    TDBXDataTypes.BooleanType: Result := SQL_C_BIT;
    TDBXDataTypes.Int16Type: Result := SQL_C_SHORT;
    TDBXDataTypes.Int32Type: Result := SQL_C_LONG;
    TDBXDataTypes.DoubleType, TDBXDataTypes.SingleType: Result := SQL_C_DOUBLE;
    TDBXDataTypes.BytesType, TDBXDataTypes.VarBytesType, TDBXDataTypes.BinaryBlobType:
      Result := SQL_C_BINARY;
    TDBXDataTypes.TimeType: Result := SQL_C_TIME;
    TDBXDataTypes.DateTimeType: Result := SQL_C_TIMESTAMP;
    TDBXDataTypes.UInt16Type: Result := SQL_C_USHORT;
    TDBXDataTypes.UInt32Type: Result := SQL_C_ULONG;
    TDBXDataTypes.Int64Type: Result := SQL_C_SBIGINT;
    TDBXDataTypes.UInt64Type: Result := SQL_C_UBIGINT;
    TDBXDataTypes.TimeStampType: Result := SQL_C_TIMESTAMP;
    TDBXDataTypes.WideStringType: Result := SQL_C_WCHAR;
    TDBXDataTypes.Int8Type: Result := SQL_C_STINYINT;
    TDBXDataTypes.UInt8Type: Result := SQL_C_UTINYINT;
    else
      Result := SQL_C_CHAR;
  end;
end;

function GetSqlDataTypeFromDbxType(DataType, SubType: SmallInt): SmallInt;
begin
  case DataType of
    TDBXDataTypes.AnsiStringType:
      begin
        case SubType of
          TDBXSubDataTypes.FixedSubType: Result := SQL_CHAR;
          else
            Result := SQL_VARCHAR;
        end;
      end;
    TDBXDataTypes.DateType: Result := SQL_TYPE_DATE;
    TDBXDataTypes.BlobType:
      begin
        case SubType of
          TDBXSubDataTypes.MemoSubType: Result := SQL_LONGVARCHAR;
          TDBXSubDataTypes.WideMemoSubType: Result := SQL_WLONGVARCHAR;
          else
            Result := SQL_LONGVARBINARY;
        end;
      end;
    TDBXDataTypes.BooleanType: Result := SQL_BIT;
    TDBXDataTypes.Int16Type: Result := SQL_SMALLINT;
    TDBXDataTypes.Int32Type: Result := SQL_INTEGER;
    TDBXDataTypes.DoubleType: Result := SQL_DOUBLE;
    TDBXDataTypes.BcdType: Result := SQL_NUMERIC;
    TDBXDataTypes.BytesType: Result := SQL_BINARY;
    TDBXDataTypes.TimeType: Result := SQL_TYPE_TIME;
    TDBXDataTypes.VarBytesType: Result := SQL_VARBINARY;
    TDBXDataTypes.Int64Type: Result := SQL_BIGINT;
    TDBXDataTypes.TimeStampType: Result := SQL_TYPE_TIMESTAMP;
    TDBXDataTypes.WideStringType:
      begin
        case SubType of
          TDBXSubDataTypes.FixedSubType: Result := SQL_WCHAR;
          else
            Result := SQL_WVARCHAR;
        end;
      end;
    TDBXDataTypes.SingleType: Result := SQL_REAL;
    TDBXDataTypes.Int8Type: Result := SQL_TINYINT;
    TDBXDataTypes.BinaryBlobType: Result := SQL_LONGVARBINARY;
    else
      Result := SQL_CHAR;
  end;
end;

procedure TDBXOdbcCommand.BindParameters;
  function GetOdbcParameterDirection(DbxParamDirection: Word): Word;
  begin
    case DBXParamDirection of
      TDBXParameterDirections.InParameter: Result := SQL_PARAM_INPUT;
      TDBXParameterDirections.OutParameter, TDBXParameterDirections.ReturnParameter:
        Result := SQL_PARAM_OUTPUT;
      TDBXParameterDirections.InOutParameter: Result := SQL_PARAM_INPUT_OUTPUT;
      else
        Result := SQL_PARAM_TYPE_UNKNOWN;
    end;
  end;
var
  I: Integer;
  ErrorCode: SmallInt;
  Size: SQLULEN;
  BufLength: Int64;
  LNull: SQLLEN;
begin
  LNull := SQL_NULL_DATA;
  if not Assigned(FParameterRow) then
    CreateParameterRow;
  SetLength(FParameterRow.FOffsets, FParameters.Count);
  BufLength := 0;
  for I := 0 to FParameters.Count - 1 do
  begin
    FParameterRow.FOffsets[I] := BufLength;
    case FParameters[I].DataType of
      TDBXDataTypes.BlobType:
        begin
          if (FParameters[I].ParameterDirection = TDBXParameterDirections.InParameter) or
             (FParameters[I].ParameterDirection = TDBXParameterDirections.InOutParameter) then
            BufLength := BufLength + SizeOf(Integer) + FParameterRow.FIndicatorSize
          else
            BufLength := BufLength + FParameters[I].Precision + FParameterRow.FIndicatorSize;
        end;
      //Do not include the null terminator for string types
      TDBXDataTypes.AnsiStringType:
        begin
          if (FParameters[I].ParameterDirection = TDBXParameterDirections.InParameter) or
             (FParameters[I].ParameterDirection = TDBXParameterDirections.InOutParameter) then
          begin
            if FParameters[I].Size > 0 then
              BufLength := BufLength + FParameters[I].Size - SizeOf(AnsiChar) + FParameterRow.FIndicatorSize
            else
              BufLength := BufLength + FParameterRow.FIndicatorSize;
          end
          else
            BufLength := BufLength + FParameters[I].Precision + FParameterRow.FIndicatorSize;
        end;
        TDBXDataTypes.WideStringType:
          begin
            if (FParameters[I].ParameterDirection = TDBXParameterDirections.InParameter) or
               (FParameters[I].ParameterDirection = TDBXParameterDirections.InOutParameter) then
            begin
              if FParameters[I].Size > 0 then
                BufLength := BufLength + FParameters[I].Size - SizeOf(Char) + FParameterRow.FIndicatorSize
              else
                BufLength := BufLength + FParameterRow.FIndicatorSize;
            end
            else
              BufLength := BufLength + (FParameters[I].Precision * SizeOf(Char)) + FParameterRow.FIndicatorSize;
          end;
        TDBXDataTypes.BcdType:
          begin
            FParameters[I].Precision := FParameters[I].Value.AsBcd.Precision;
            FParameters[I].Scale := FParameters[I].Value.AsBcd.SignSpecialPlaces;
            FParameters[I].Size := FParameters[I].Value.AsString.Length + SizeOf(AnsiChar);
            BufLength := BufLength + FParameters[I].Size - SizeOf(AnsiChar) + FParameterRow.FIndicatorSize;
          end;
        TDBXDataTypes.BytesType, TDBXDataTypes.VarBytesType:
          begin
            if (FParameters[I].ParameterDirection = TDBXParameterDirections.InParameter) or
               (FParameters[I].ParameterDirection = TDBXParameterDirections.InOutParameter) then
            begin
              if FParameters[I].Size > 0 then
                BufLength := BufLength + FParameters[I].Size + FParameterRow.FIndicatorSize
              else
                BufLength := BufLength + FParameterRow.FIndicatorSize;
            end
            else
              BufLength := BufLength + (FParameters[I].Precision * SizeOf(Char)) + FParameterRow.FIndicatorSize;
          end
    else
      BufLength := BufLength + GetTypeSize(FParameters[I].DataType) + FParameterRow.FIndicatorSize;
    end;
  end;
  if Assigned(FParameterRow.FBlock) then
    FParameterRow.FBlock.Free;
  FParameterRow.FBlock := TDBXOdbcBlockMgr.Create(BufLength, 1);
  for I := 0 to FParameters.Count - 1 do
  begin
    FDBXContext.Trace(0, trace_SQLBindParameter);
    case FParameters[I].DataType of
      TDBXDataTypes.BlobType:
        begin
          if (FParameters[I].ParameterDirection = TDBXParameterDirections.InParameter) or
             (FParameters[I].ParameterDirection = TDBXParameterDirections.InOutParameter) then
            ErrorCode := SQLBindParameter(FCommandHandle, I+1, GetOdbcParameterDirection(FParameters[I].ParameterDirection),
                                          GetCDataTypeFromDbxType(FParameters[I].DataType, FParameters[I].SubType),
                                          GetSqlDataTypeFromDbxType(FParameters[I].DataType, FParameters[I].SubType),
                                          FParameters[I].Precision, FParameters[I].Scale,
                                          SQLPOINTER(I), SizeOf(Integer),
                                          PSqlLen(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]+SizeOf(Integer)]))
          else
            ErrorCode := SQLBindParameter(FCommandHandle, I+1, GetOdbcParameterDirection(FParameters[I].ParameterDirection),
                                          GetCDataTypeFromDbxType(FParameters[I].DataType, FParameters[I].SubType),
                                          GetSqlDataTypeFromDbxType(FParameters[I].DataType, FParameters[I].SubType),
                                          FParameters[I].Precision, FParameters[I].Scale,
                                          SQLPOINTER(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]]),
                                          FParameters[I].Precision,
                                          PSqlLen(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]+FParameters[I].Precision]));
        end;
      TDBXDataTypes.AnsiStringType:
        begin
          if (FParameters[I].ParameterDirection = TDBXParameterDirections.InParameter) or
             (FParameters[I].ParameterDirection = TDBXParameterDirections.InOutParameter) then
          begin
            if FParameters[I].Precision <= 0 then
              if FParameters[I].Size > 0 then
                FParameters[I].Precision := FParameters[I].Size - SizeOf(AnsiChar)
              else
                FParameters[I].Precision := 0;
            if FParameters[I].Size > 0 then
              ErrorCode := SQLBindParameter(FCommandHandle, I+1, GetOdbcParameterDirection(FParameters[I].ParameterDirection),
                                            SQL_C_CHAR,
                                            GetSqlDataTypeFromDbxType(FParameters[I].DataType, FParameters[I].SubType),
                                            FParameters[I].Precision, FParameters[I].Scale,
                                            SQLPOINTER(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]]),
                                            FParameters[I].Size-SizeOf(AnsiChar),
                                            PSqlLen(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]+FParameters[I].Size-SizeOf(AnsiChar)]))
            else
              ErrorCode := SQLBindParameter(FCommandHandle, I+1, GetOdbcParameterDirection(FParameters[I].ParameterDirection),
                                            SQL_C_CHAR,
                                            GetSqlDataTypeFromDbxType(FParameters[I].DataType, FParameters[I].SubType),
                                            FParameters[I].Precision, FParameters[I].Scale,
                                            nil,
                                            0,
                                            PSqlLen(@LNull));
          end
          else
            ErrorCode := SQLBindParameter(FCommandHandle, I+1, GetOdbcParameterDirection(FParameters[I].ParameterDirection),
                                          SQL_C_CHAR,
                                          GetSqlDataTypeFromDbxType(FParameters[I].DataType, FParameters[I].SubType),
                                          FParameters[I].Precision, FParameters[I].Scale,
                                          SQLPOINTER(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]]),
                                          FParameters[I].Precision,
                                          PSqlLen(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]+FParameters[I].Precision]));
        end;
      TDBXDataTypes.WideStringType:
        begin
          if (FParameters[I].ParameterDirection = TDBXParameterDirections.InParameter) or
             (FParameters[I].ParameterDirection = TDBXParameterDirections.InOutParameter) then
          begin
            if FParameters[I].Precision <= 0 then
              if FParameters[I].Size > 1 then
                FParameters[I].Precision := FParameters[I].Size - SizeOf(Char)
              else
                FParameters[I].Precision := 0;
            if FParameters[I].Size > 0 then
              ErrorCode := SQLBindParameter(FCommandHandle, I+1, GetOdbcParameterDirection(FParameters[I].ParameterDirection),
                                            SQL_C_WCHAR,
                                            GetSqlDataTypeFromDbxType(FParameters[I].DataType, FParameters[I].SubType),
                                            FParameters[I].Precision, FParameters[I].Scale,
                                            SQLPOINTER(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]]),
                                            FParameters[I].Size-SizeOf(Char),
                                            PSqlLen(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]+FParameters[I].Size-SizeOf(Char)]))
            else
              ErrorCode := SQLBindParameter(FCommandHandle, I+1, GetOdbcParameterDirection(FParameters[I].ParameterDirection),
                                            SQL_C_WCHAR,
                                            GetSqlDataTypeFromDbxType(FParameters[I].DataType, FParameters[I].SubType),
                                            FParameters[I].Precision, FParameters[I].Scale,
                                            nil,
                                            0,
                                            PSqlLen(@LNull));
          end
          else
            ErrorCode := SQLBindParameter(FCommandHandle, I+1, GetOdbcParameterDirection(FParameters[I].ParameterDirection),
                                          SQL_C_WCHAR,
                                          GetSqlDataTypeFromDbxType(FParameters[I].DataType, FParameters[I].SubType),
                                          FParameters[I].Precision, FParameters[I].Scale,
                                          SQLPOINTER(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]]),
                                          FParameters[I].Precision*SizeOf(Char),
                                          PSqlLen(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]+FParameters[I].Precision*SizeOf(Char)]));
        end;
      TDBXDataTypes.BcdType:
        begin
          if FParameters[I].Precision <= 0 then
            if FParameters[I].Size >= 0 then
              FParameters[I].Precision := FParameters[I].Size
            else
              FParameters[I].Precision := 0;
          Size := FParameters[I].Value.AsString.Length;
          ErrorCode := SQLBindParameter(FCommandHandle, I+1, GetOdbcParameterDirection(FParameters[I].ParameterDirection),
                                        GetCDataTypeFromDbxType(FParameters[I].DataType, FParameters[I].SubType),
                                        GetSqlDataTypeFromDbxType(FParameters[I].DataType, FParameters[I].SubType),
                                        FParameters[I].Precision, FParameters[I].Scale,
                                        SQLPOINTER(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]]),
                                        Size,
                                        PSqlLen(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]+Size]));
        end;
      TDBXDataTypes.BytesType, TDBXDataTypes.VarBytesType:
        begin
          if (FParameters[I].ParameterDirection = TDBXParameterDirections.InParameter) or
             (FParameters[I].ParameterDirection = TDBXParameterDirections.InOutParameter) then
          begin
            if FParameters[I].Precision <= 0 then
              if FParameters[I].Size >= 0 then
                FParameters[I].Precision := FParameters[I].Size
              else
                FParameters[I].Precision := 0;
            if FParameters[I].Size > 0 then
              ErrorCode := SQLBindParameter(FCommandHandle, I+1, GetOdbcParameterDirection(FParameters[I].ParameterDirection),
                                            SQL_C_WCHAR,
                                            GetSqlDataTypeFromDbxType(FParameters[I].DataType, FParameters[I].SubType),
                                            FParameters[I].Precision, FParameters[I].Scale,
                                            SQLPOINTER(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]]),
                                            FParameters[I].Size,
                                            PSqlLen(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]+FParameters[I].Size]))
            else
              ErrorCode := SQLBindParameter(FCommandHandle, I+1, GetOdbcParameterDirection(FParameters[I].ParameterDirection),
                                            SQL_C_WCHAR,
                                            GetSqlDataTypeFromDbxType(FParameters[I].DataType, FParameters[I].SubType),
                                            FParameters[I].Precision, FParameters[I].Scale,
                                            nil,
                                            0,
                                            PSqlLen(@LNull));
          end
          else
            ErrorCode := SQLBindParameter(FCommandHandle, I+1, GetOdbcParameterDirection(FParameters[I].ParameterDirection),
                                          SQL_C_WCHAR,
                                          GetSqlDataTypeFromDbxType(FParameters[I].DataType, FParameters[I].SubType),
                                          FParameters[I].Precision, FParameters[I].Scale,
                                          SQLPOINTER(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]]),
                                          FParameters[I].Precision*SizeOf(Char),
                                          PSqlLen(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]+FParameters[I].Precision*SizeOf(Char)]));
        end
    else
    begin
      if FParameters[I].Precision <= 0 then
        if FParameters[I].Size >= 0 then
          FParameters[I].Precision := FParameters[I].Size
        else
          FParameters[I].Precision := 0;
      Size := GetTypeSize(FParameters[I].DataType);
      ErrorCode := SQLBindParameter(FCommandHandle, I+1, GetOdbcParameterDirection(FParameters[I].ParameterDirection),
                                    GetCDataTypeFromDbxType(FParameters[I].DataType, FParameters[I].SubType),
                                    GetSqlDataTypeFromDbxType(FParameters[I].DataType, FParameters[I].SubType),
                                    FParameters[I].Precision, FParameters[I].Scale,
                                    SQLPOINTER(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]]),
                                    Size,
                                    PSqlLen(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]+Size]));
    end;
    end;
    CheckResult(ErrorCode);
  end;
end;

procedure TDBXOdbcCommand.CheckResult(ReturnValue: SmallInt);
begin
  if (ReturnValue <> SQL_SUCCESS) and (ReturnValue <> SQL_SUCCESS_WITH_INFO) then
    OdbcRaiseError(FDBXContext, ReturnValue, SQL_HANDLE_STMT, FCommandHandle);
end;

procedure TDBXOdbcCommand.CheckResultConnHandle(ReturnValue: SmallInt);
begin
  if (ReturnValue <> SQL_SUCCESS) and (ReturnValue <> SQL_SUCCESS_WITH_INFO) then
    OdbcRaiseError(FDBXContext, ReturnValue, SQL_HANDLE_DBC, FConnectionHandle);
end;

procedure TDBXOdbcCommand.ExecuteCatalogFunction;
var
  ErrorCode: SmallInt;
  Catalog, Schema, Table, ProcName, TableType: string;
begin
  if Text = 'GetIndexes' then
  begin
    Table := Parameters[0].Value.AsString;
    FDBXContext.Trace(0, trace_SQLStatistics);
    if Table <> '' then
      ErrorCode := SQLStatistics(FCommandHandle, nil, 0, nil, 0,
                                 PChar(@Table[Low(Table)]), Table.Length, SQL_INDEX_ALL, SQL_QUICK)
    else
      ErrorCode := SQLStatistics(FCommandHandle, nil, 0, nil, 0, nil, 0,
                                 SQL_INDEX_ALL, SQL_QUICK);
  end
  else if Text = 'GetDataTypes' then
  begin
    FDBXContext.Trace(0, trace_SQLGetTypeInfo);
    ErrorCode := SQLGetTypeInfo(FCommandHandle, SQL_ALL_TYPES);
  end
  else if Text = 'GetCatalogs' then
  begin
    Catalog := SQL_ALL_CATALOGS;
    Schema := '';
    Table := '';
    FDBXContext.Trace(0, trace_SQLTables);
    ErrorCode := SQLTables(FCommandHandle, PChar(@Catalog[Low(Catalog)]), Catalog.Length,
                           PChar(@Schema), 0, PChar(@Table), 0, nil, 0);
  end
  else if Text = 'GetSchemas' then
  begin
    Catalog := '';
    Schema := SQL_ALL_SCHEMAS;
    Table := '';
    FDBXContext.Trace(0, trace_SQLTables);
    ErrorCode := SQLTables(FCommandHandle, PChar(@Catalog), 0, PChar(@Schema[Low(Schema)]), Schema.Length,
                           PChar(@Table), 0, nil, 0);
  end
  else if Text = 'GetTables' then
  begin
    TableType := 'TABLE';
    Table := Parameters[0].Value.AsString;
    FDBXContext.Trace(0, trace_SQLTables);
    if Table <> '' then
      ErrorCode := SQLTables(FCommandHandle, nil, 0, nil, 0,
                             PChar(@Table[Low(Table)]), Table.Length, nil, 0)
    else
      ErrorCode := SQLTables(FCommandHandle, nil, 0, nil, 0, nil, 0,
                             PChar(@TableType[Low(TableType)]), TableType.Length);
  end
  else if Text = 'GetViews' then
  begin
    TableType := 'VIEW';
    FDBXContext.Trace(0, trace_SQLTables);
    ErrorCode := SQLTables(FCommandHandle, nil, 0, nil, 0, nil, 0,
                           PChar(@TableType[Low(TableType)]), TableType.Length);
  end
  else if Text = 'GetSynonyms' then
  begin
    TableType := 'SYNONYM';
    FDBXContext.Trace(0, trace_SQLTables);
    ErrorCode := SQLTables(FCommandHandle, nil, 0, nil, 0, nil, 0,
                           PChar(@TableType[Low(TableType)]), TableType.Length);
  end
  else if Text = 'GetColumns' then
  begin
    Table := Parameters[0].Value.AsString;
    FDBXContext.Trace(0, trace_SQLColumns);
    if Table <> '' then
      ErrorCode := SQLColumns(FCommandHandle, nil, 0, nil, 0,
                              PChar(@Table[Low(Table)]), Table.Length, nil, 0)
    else
      ErrorCode := SQLColumns(FCommandHandle, nil, 0, nil, 0, nil, 0, nil, 0);
  end
  else if Text = 'GetForeignKeys' then
  begin
    Table := Parameters[0].Value.AsString;
    FDBXContext.Trace(0, trace_SQLForeignKeys);
    if Table <> '' then
      ErrorCode := SQLForeignKeys(FCommandHandle, nil, 0, nil, 0, nil, 0,
                                  nil, 0, nil, 0, PChar(@Table[Low(Table)]), Table.Length)
    else
    begin
      FDBXContext.Error(1, SForeignKeyMetadata);
      ErrorCode := 0;
    end;
  end
  else if Text = 'GetProcedures' then
  begin
    FDBXContext.Trace(0, trace_SQLProcedures);
    ErrorCode := SQLProcedures(FCommandHandle, nil, 0, nil, 0, nil, 0);
  end
  else if Text = 'GetProcedureParameters' then
  begin
    Schema := '%';
    ProcName := Parameters[0].Value.AsString;
    FDBXContext.Trace(0, trace_SQLProcedureColumns);
    if ProcName <> '' then
      ErrorCode := SQLProcedureColumns(FCommandHandle, nil, 0, PChar(@Schema[Low(Schema)]), Schema.Length,
                                       PChar(@ProcName[Low(ProcName)]), ProcName.Length, nil, 0)
    else
      ErrorCode := SQLProcedureColumns(FCommandHandle, nil, 0, PChar(@Schema[Low(Schema)]), Schema.Length,
                                       nil, 0, nil, 0);
  end
  else
    ErrorCode := 0;
  CheckResult(ErrorCode);
end;

function TDBXOdbcCommand.IsFunction: Boolean;
var
  ErrorCode, ProcedureType: SmallInt;
  ProcName: string;
  MetaDataCommand: TDBXOdbcCommand;
  MetaDataByteReader: TDBXOdbcByteReader;
  MetaDataReader: TDBXOdbcReader;
begin
  Result := False;
  MetaDataCommand := TDBXOdbcCommand.Create(FDBXContext, FOdbcConnection);
  try
    MetaDataCommand.Open;
    ProcName := StringReplace(Text,FOdbcConnection.GetDatabaseMetaData.QuoteChar,'',[rfReplaceAll]);
    FDBXContext.Trace(0, trace_SQLProcedures);
    if ProcName <> '' then
      ErrorCode := SQLProcedures(MetaDataCommand.FCommandHandle, nil, 0,
                                 nil, 0, PChar(@ProcName[Low(ProcName)]), ProcName.Length)
    else
      ErrorCode := SQLProcedures(MetaDataCommand.FCommandHandle, nil, 0,
                                 nil, 0, nil, 0);
    MetaDataCommand.CheckResult(ErrorCode);
    MetaDataByteReader := TDBXOdbcByteReader.Create(FDBXContext, FEnvironmentHandle, FConnectionHandle, MetaDataCommand.FCommandHandle);
    MetaDataReader := TDBXOdbcReader.Create(FDBXContext, FEnvironmentHandle, FConnectionHandle, MetaDataCommand.FCommandHandle, MetaDataByteReader, 8, FRowSetSize);
    try
      MetaDataReader.Next;
      ProcedureType := MetaDataReader.Values[7].AsInt32;
    finally
      FreeAndNil(MetaDataReader);
    end;
  finally
    FreeAndNil(MetaDataCommand);
  end;
  if ProcedureType = SQL_PT_FUNCTION then
    Result := True;
end;

function TDBXOdbcCommand.GetNumberOfColumns: Int64;
var
  ErrorCode, NumCols: SmallInt;
begin
  FDBXContext.Trace(0, trace_SQLNumResultCols);
  ErrorCode := SQLNumResultCols(FCommandHandle, NumCols);
  CheckResult(ErrorCode);
  Result := NumCols;
end;

procedure TDBXOdbcCommand.PutBlobs;
var
  ErrorCode: SmallInt;
  I: Integer;
  Size: Int64;
  Bytes, ValuePtrBuffer: TArray<Byte>;
begin
  SetLength(ValuePtrBuffer, SizeOf(NativeInt));
  for I := 0 to FParameters.Count - 1 do
  begin
    if (FParameters[I].DataType = TDBXDataTypes.BlobType) and
       ((FParameters[I].ParameterDirection = TDBXParameterDirections.InParameter) or
       (FParameters[I].ParameterDirection = TDBXParameterDirections.InOutParameter)) and
       not (FParameters[I].Value.IsNull) then
    begin
      Size := FParameters[I].Value.GetValueSize;
      SetLength(Bytes, Size);
      FParameters[I].Value.GetBytes(0, Bytes, 0, Size);
      FDBXContext.Trace(0, trace_SQLPutData);
      ErrorCode := SQLPutData(FCommandHandle, SQLPOINTER(@Bytes[0]), Size);
      CheckResult(ErrorCode);
      FDBXContext.Trace(0, trace_SQLParamData);
      ErrorCode := SQLParamData(FCommandHandle, SQLPOINTER(@ValuePtrBuffer[0]));
      CheckResult(ErrorCode);
    end;
  end;
end;

procedure TDBXOdbcCommand.SetParameterValues;
var
  I: Integer;
  Size: Int64;
  TimeStamp: TSQLTimeStamp;
  Bytes: TArray<Byte>;
begin
  for I := 0 to FParameters.Count - 1 do
  begin
    if (FParameters[I].ParameterDirection = TDBXParameterDirections.InParameter) or
       ((FParameters[I].ParameterDirection = TDBXParameterDirections.InOutParameter)) then
    begin
      if FParameters[I].Value.IsNull then
        FParameterRow.SetNull(FParameters[I].Value)
      else
      begin
        case FParameters[I].DataType of
          TDBXDataTypes.AnsiStringType, TDBXDataTypes.BcdType:
            FParameterRow.SetString(TDBXAnsiStringValue(FParameters[I].Value), AnsiString(FParameters[I].Value.AsString));
          TDBXDataTypes.DateType:
            FParameterRow.SetDate(TDBXDateValue(FParameters[I].Value), FParameters[I].Value.AsDate);
          TDBXDataTypes.BlobType, TDBXDataTypes.BinaryBlobType:
            begin
              Size := FParameters[I].Value.GetValueSize;
              PInteger(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]+SizeOf(Integer)])^ := SQL_LEN_DATA_AT_EXEC(Size);
            end;
          TDBXDataTypes.Int16Type, TDBXDataTypes.BooleanType:
            FParameterRow.SetInt16(TDBXInt16Value(FParameters[I].Value), FParameters[I].Value.AsInt16);
          TDBXDataTypes.Int32Type:
            FParameterRow.SetInt32(TDBXInt32Value(FParameters[I].Value), FParameters[I].Value.AsInt32);
          TDBXDataTypes.DoubleType:
            FParameterRow.SetDouble(TDBXDoubleValue(FParameters[I].Value), FParameters[I].Value.AsDouble);
          TDBXDataTypes.BytesType, TDBXDataTypes.VarBytesType:
            begin
              Size := FParameters[I].Value.GetValueSize;
              SetLength(Bytes, Size);
              FParameters[I].Value.GetBytes(0, Bytes, 0, Size);
              FParameterRow.SetDynamicBytes(FParameters[I].Value, 0, Bytes, 0, Size);
            end;
          TDBXDataTypes.TimeType:
            FParameterRow.SetTime(TDBXTimeValue(FParameters[I].Value), FParameters[I].Value.AsTime);
          TDBXDataTypes.Int64Type:
            FParameterRow.SetInt64(TDBXInt64Value(FParameters[I].Value), FParameters[I].Value.AsInt64);
          TDBXDataTypes.TimeStampType:
            begin
              TimeStamp := FParameters[I].Value.AsTimeStamp;
              FParameterRow.SetTimestamp(TDBXTimeStampValue(FParameters[I].Value), TimeStamp);
            end;
          TDBXDataTypes.WideStringType:
            FParameterRow.SetWideString(TDBXWideStringValue(FParameters[I].Value), FParameters[I].Value.AsString);
          TDBXDataTypes.SingleType:
            FParameterRow.SetSingle(TDBXSingleValue(FParameters[I].Value), FParameters[I].Value.AsSingle);
          TDBXDataTypes.Int8Type:
            FParameterRow.SetInt8(TDBXInt8Value(FParameters[I].Value), FParameters[I].Value.AsInt8);
          else
            raise TDBXError.Create(TDBXErrorCodes.InvalidParameter, SDBXErrInvalidParameter);
        end;
      end;
    end
    else
    begin
      case FParameters[I].DataType of
        TDBXDataTypes.AnsiStringType, TDBXDataTypes.BlobType, TDBXDataTypes.BinaryBlobType:
          PInteger(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]+FParameters[I].Precision])^ := FParameters[I].Precision;
        TDBXDataTypes.BcdType: PInteger(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]+SizeOf(TBcd)])^ := SizeOf(TBcd);
        TDBXDataTypes.WideStringType: PInteger(@FParameterRow.FBlock.Buffer[FParameterRow.FOffsets[I]+FParameters[I].Precision*SizeOf(Char)])^ := FParameters[I].Precision*SizeOf(Char);
      end;
    end;
  end;
end;

procedure TDBXOdbcCommand.SetRowsAffected;
var
  ErrorCode: SmallInt;
  RowsAffected: SQLLEN;
begin
  FDBXContext.Trace(0, trace_SQLRowCount);
  ErrorCode := SQLRowCount(FCommandHandle, RowsAffected);
  CheckResult(ErrorCode);
  FRowsAffected := RowsAffected;
end;

function TDBXOdbcCommand.CreateParameterRow: TDBXRow;
begin
  FParameterRow := TDBXOdbcRow.Create(FDBXContext, FEnvironmentHandle, FConnectionHandle, FCommandHandle);
  Result := FParameterRow;
end;

procedure TDBXOdbcCommand.DerivedClose;
var
  ErrorCode: SmallInt;
begin
  FRowsAffected := 0;
  if Assigned(FCommandHandle) then
  begin
    FDBXContext.Trace(0, trace_SQLFreeHandle);
    ErrorCode := SQLFreeHandle(SQL_HANDLE_STMT, FCommandHandle);
    CheckResult(ErrorCode);
  end;
  FCommandHandle := nil;
end;

function TDBXOdbcCommand.DerivedExecuteQuery: TDBXReader;
var
  ErrorCode: SmallInt;
  ByteReader: TDBXOdbcByteReader;
  NumCols: Int64;
begin
  Result := nil;
  FDBXContext.Trace(0, Text);
  if CommandType = TDBXCommandTypes.DbxMetaData then
    ExecuteCatalogFunction
  else
  begin
    if Assigned(FParameters) and (FParameters.Count > 0) then
    begin
      BindParameters;
      SetParameterValues;
    end;
    if not isPrepared then
    begin
      FDBXContext.Trace(0, trace_SQLExecDirect);
      ErrorCode := SQLExecDirect(FCommandHandle, PChar(@Text[Low(Text)]), Text.Length);
    end
    else
    begin
      FDBXContext.Trace(0, trace_SQLExecute);
      ErrorCode := SQLExecute(FCommandHandle);
    end;
    if ErrorCode = SQL_NEED_DATA then
      PutBlobs
    else
      CheckResult(ErrorCode);
  end;
  SetRowsAffected;
  NumCols := GetNumberOfColumns;
  if NumCols > 0 then
  begin
    ByteReader := TDBXOdbcByteReader.Create(FDBXContext, FEnvironmentHandle, FConnectionHandle, FCommandHandle);
    Result := TDBXOdbcReader.Create(FDBXContext, FEnvironmentHandle, FConnectionHandle, FCommandHandle, ByteReader, NumCols, FRowSetSize);
  end;
end;

procedure TDBXOdbcCommand.DerivedExecuteUpdate;
var
  ErrorCode: SmallInt;
begin
  FDBXContext.Trace(0, Text);
  if Assigned(FParameters) and (FParameters.Count > 0) then
  begin
    BindParameters;
    SetParameterValues;
  end;
  if not isPrepared then
  begin
    FDBXContext.Trace(0, trace_SQLExecDirect);
    ErrorCode := SQLExecDirect(FCommandHandle, PChar(@Text[Low(Text)]), Text.Length);
  end
  else
  begin
    FDBXContext.Trace(0, trace_SQLExecute);
    ErrorCode := SQLExecute(FCommandHandle);
  end;
  if ErrorCode = SQL_NEED_DATA then
    PutBlobs
  else
    CheckResult(ErrorCode);
  SetRowsAffected;
end;

function TDBXOdbcCommand.DerivedGetNextReader: TDBXReader;
begin
  Result := nil;
end;

procedure TDBXOdbcCommand.DerivedOpen;
var
  ErrorCode: SmallInt;
begin
  FDBXContext.Trace(0, trace_SQLAllocHandle);
  ErrorCode := SQLAllocHandle(SQL_HANDLE_STMT, SQLHANDLE(FConnectionHandle), SQLHANDLE(FCommandHandle));
  CheckResult(ErrorCode);
  FDBXContext.Trace(0, trace_SQLSetStmtAttr);
  ErrorCode := SQLSetStmtAttr(FCommandHandle, SQL_ATTR_ROW_ARRAY_SIZE, SQLPOINTER(FRowSetSize), 0);
  CheckResult(ErrorCode);
end;

procedure TDBXOdbcCommand.DerivedPrepare;
var
  ErrorCode, NumParams: SmallInt;
  StoredProcText: string;
  I, NewLength, BufLength: Integer;
  NewText: TArray<Byte>;
begin
  if CommandType = TDBXCommandTypes.DbxStoredProcedure then
  begin
    NumParams := FParameters.Count;
    if IsFunction then
    begin
      StoredProcText := '{ ? = CALL ' + Text + '(';
      Dec(NumParams);
    end
    else
      StoredProcText := '{ CALL ' + Text + '(';
    for I := 1 to NumParams - 1 do
      StoredProcText := StoredProcText + '?, ';
    StoredProcText := StoredProcText + '?) }';
    //Some ODBC drivers do not support passing a null pointer to retrieve the length.
    SetLength(NewText, 4);
    FDBXContext.Trace(0, trace_SQLNativeSql);
    ErrorCode := SQLNativeSql(FConnectionHandle, PChar(@StoredProcText[Low(StoredProcText)]), StoredProcText.Length,
                              PChar(@NewText[0]), 2, NewLength);
    CheckResultConnHandle(ErrorCode);
    BufLength := (NewLength+1)*SizeOf(Char);
    SetLength(NewText, BufLength);
    FDBXContext.Trace(0, trace_SQLNativeSql);
    ErrorCode := SQLNativeSql(FConnectionHandle, PChar(@StoredProcText[Low(StoredProcText)]), StoredProcText.Length,
                              PChar(@NewText[0]), (BufLength+1) div SizeOf(Char), NewLength);
    CheckResultConnHandle(ErrorCode);
    FDBXContext.Trace(0, trace_SQLPrepare);
    ErrorCode := SQLPrepare(FCommandHandle, PChar(@StoredProcText[Low(StoredProcText)]), StoredProcText.Length);
  end
  else if CommandType = TDBXCommandTypes.DbxMetaData then
    //Do nothing
    ErrorCode := 0
  else
  begin
    FDBXContext.Trace(0, Text);
    FDBXContext.Trace(0, trace_SQLPrepare);
    ErrorCode := SQLPrepare(FCommandHandle, PChar(@Text[Low(Text)]), Text.Length);
  end;
  CheckResult(ErrorCode);
end;

function TDBXOdbcCommand.GetRowsAffected: Int64;
begin
  Result := FRowsAffected;
end;

procedure TDBXOdbcCommand.SetMaxBlobSize(const MaxBlobSize: Int64);
begin

end;

procedure TDBXOdbcCommand.SetRowSetSize(const RowSetSize: Int64);
begin
  FRowSetSize := RowSetSize;
end;

constructor TDBXOdbcCommand.Create(DBXContext: TDBXContext; OdbcConnection: TDBXOdbcConnection);
begin
  inherited Create(DbxContext);
  FEnvironmentHandle := OdbcConnection.EnvironmentHandle;
  FConnectionHandle := OdbcConnection.ConnectionHandle;
  FOdbcConnection := OdbcConnection;
  FCommandHandle := nil;
  FRowsAffected := 0;
  FParameterRow := nil;
  FRowSetSize := 20;
end;

destructor TDBXOdbcCommand.Destroy;
begin
  Close;
  FConnectionHandle := nil;
  FEnvironmentHandle := nil;
  FParameterRow := nil;
  FOdbcConnection := nil;
  inherited Destroy;
end;

function TDBXOdbcByteReader.CalculateOffset(ColNum: Integer): Int64;
begin
  Result := FRow.FOffsets[ColNum] + (FRow.FBlock.CurrentRecord - 1) * FRow.FBlock.RowLength;
end;

procedure TDBXOdbcByteReader.CheckResult(ReturnValue: SmallInt);
begin
  if (ReturnValue <> SQL_SUCCESS) and (ReturnValue <> SQL_SUCCESS_WITH_INFO) then
    OdbcRaiseError(FDBXContext, ReturnValue, SQL_HANDLE_STMT, FCommandHandle);
end;

constructor TDBXOdbcByteReader.Create(DBXContext: TDBXContext; EnvironmentHandle, ConnectionHandle, CommandHandle: OdbcHandle);
begin
  inherited Create(DBXContext);
  FEnvironmentHandle := EnvironmentHandle;
  FConnectionHandle := ConnectionHandle;
  FCommandHandle := CommandHandle;
  FRow := TDBXOdbcRow.Create(DBXContext, FEnvironmentHandle, FConnectionHandle, FCommandHandle);
end;

destructor TDBXOdbcByteReader.Destroy;
begin
  FCommandHandle := nil;
  FConnectionHandle := nil;
  FEnvironmentHandle := nil;
  //FRow is shared with TDBXOdbcReader which will free it
  FRow := nil;
  inherited Destroy;
end;

procedure TDBXOdbcByteReader.GetAnsiString(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
var
  ValueLength: Int64;
begin
  ValueLength := Length(Value);
  if PInteger(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+ValueLength])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    TDBXPlatform.CopyByteArray(FRow.FBlock.Buffer, CalculateOffset(Ordinal), Value, 0, ValueLength);
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcByteReader.GetWideString(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
var
  ValueLength: Int64;
begin
  ValueLength := Length(Value);
  if PInteger(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+ValueLength])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    TDBXPlatform.CopyByteArray(FRow.FBlock.Buffer, CalculateOffset(Ordinal), Value, 0, ValueLength);
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcByteReader.GetUInt8(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  if PInteger(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+SizeOf(Byte)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    TDBXPlatform.CopyByteArray(FRow.FBlock.Buffer, CalculateOffset(Ordinal), Value, 0, SizeOf(Byte));
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcByteReader.GetInt8(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  if PInteger(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+SizeOf(ShortInt)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    TDBXPlatform.CopyByteArray(FRow.FBlock.Buffer, CalculateOffset(Ordinal), Value, 0, SizeOf(ShortInt));
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcByteReader.GetUInt16(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  if PInteger(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+SizeOf(Word)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    TDBXPlatform.CopyByteArray(FRow.FBlock.Buffer, CalculateOffset(Ordinal), Value, 0, SizeOf(Word));
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcByteReader.GetInt16(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  if PInteger(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+SizeOf(SmallInt)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    TDBXPlatform.CopyByteArray(FRow.FBlock.Buffer, CalculateOffset(Ordinal), Value, 0, SizeOf(SmallInt));
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcByteReader.GetInt32(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  if PInteger(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+SizeOf(Int32)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    TDBXPlatform.CopyByteArray(FRow.FBlock.Buffer, CalculateOffset(Ordinal), Value, 0, SizeOf(Int32));
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcByteReader.GetInt64(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  if PInteger(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+SizeOf(Int64)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    TDBXPlatform.CopyByteArray(FRow.FBlock.Buffer, CalculateOffset(Ordinal), Value, 0, SizeOf(Int64));
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcByteReader.GetSingle(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  if PInteger(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+SizeOf(Single)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    TDBXPlatform.CopyByteArray(FRow.FBlock.Buffer, CalculateOffset(Ordinal), Value, 0, SizeOf(Single));
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcByteReader.GetDouble(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  if PInteger(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+SizeOf(Double)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    TDBXPlatform.CopyByteArray(FRow.FBlock.Buffer, CalculateOffset(Ordinal), Value, 0, SizeOf(Double));
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcByteReader.GetBcd(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
var
  BcdInBytes: TArray<Byte>;
begin
  if PInteger(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+SizeOf(TBCD)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    BcdInBytes := BcdToBytes(StrToBcd(string(AnsiString(PAnsiChar(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)])))));
    TDBXPlatform.CopyByteArray(BcdInBytes, 0, Value, 0, SizeOf(TBCD));
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcByteReader.GetTimeStamp(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  if PInteger(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+SizeOf(TSQLTimeStamp)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    TDBXPlatform.CopyByteArray(FRow.FBlock.Buffer, CalculateOffset(Ordinal), Value, 0, SizeOf(TSQLTimeStamp));
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcByteReader.GetTimeStampOffset(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
begin
  if PInteger(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+SizeOf(TSQLTimeStampOffset)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    TDBXPlatform.CopyByteArray(FRow.FBlock.Buffer, CalculateOffset(Ordinal), Value, 0, SizeOf(TSQLTimeStampOffset));
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcByteReader.GetTime(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
var
  Hour, Minute, Second: Word;
  Time: TDBXTime;
begin
  if PInteger(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+SizeOf(SQL_TIME_STRUCT)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    Hour := PWord(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)])^;
    Minute := PWord(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+SizeOf(Word)])^;
    Second := PWord(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+SizeOf(Word)+SizeOf(Word)])^;
    Time := (Hour * 60 + Minute) * MSecsPerSec * SecsPerMin + (Second * MSecsPerSec);
    TDBXPlatform.CopyInt32(Time, Value, 0);
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcByteReader.GetDate(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
var
  Year: SmallInt;
  Month, Day: Word;
  TimeStamp: TTimeStamp;
begin
  if PInteger(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+SizeOf(SQL_DATE_STRUCT)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    Year := PSmallInt(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)])^;
    Month := PWord(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+SizeOf(Word)])^;
    Day := PWord(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+SizeOf(Word)+SizeOf(Word)])^;
    TimeStamp := DateTimeToTimeStamp(EncodeDate(Year, Month, Day));
    TDBXPlatform.CopyInt32(TimeStamp.Date, Value, 0);
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcByteReader.GetByteLength(Ordinal: TInt32; var Length: Int64;
  var IsNull: LongBool);
var
  Buffer, Ind: TArray<Byte>;
  ErrorCode: SmallInt;
begin
  SetLength(Ind, SizeOf(Integer));
  SetLength(Buffer, 1);
  FDBXContext.Trace(0, trace_SQLGetData);
  ErrorCode := SQLGetData(FCommandHandle, Ordinal+1, GetCDataTypeFromDbxType(TDBXOdbcRow(FRow).FColumnTypes[Ordinal],0),
                          SQLPointer(@Buffer[0]), 0, PSqlLen(@Ind[0]));
  CheckResult(ErrorCode);
  if PSQLLEN(@Ind[0])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    Length := PSQLLEN(@Ind[0])^;
  end
  else
  begin
    IsNull := True;
    Length := 0;
  end;
end;

function TDBXOdbcByteReader.GetBytes(Ordinal: TInt32; Offset: Int64;
  const Value: TArray<Byte>; ValueOffset: Int64; Length: Int64;
  var IsNull: LongBool): Int64;
var
  ErrorCode: SmallInt;
  Buffer, Ind: TArray<Byte>;
begin
  SetLength(Ind, SizeOf(Integer));
  SetLength(Buffer, Length);
  case TDBXOdbcRow(FRow).FColumnTypes[Ordinal] of
    TDBXDataTypes.BlobType:
      begin
        FDBXContext.Trace(0, trace_SQLGetData);
        ErrorCode := SQLGetData(FCommandHandle, Ordinal+1, GetCDataTypeFromDbxType(TDBXOdbcRow(FRow).FColumnTypes[Ordinal], 0),
                                SQLPointer(@Buffer[0]), Length, PSqlLen(@Ind[0]));
        CheckResult(ErrorCode);
        if PSqlLen(@Ind[0])^ <> SQL_NULL_DATA then
        begin
          IsNull := False;
          Result := Min(Length, PSqlLen(@Ind[0])^);
          TDBXPlatform.CopyByteArray(FRow.FBlock.Buffer, 0, Value, ValueOffset, Result);
        end
        else
        begin
          IsNull := True;
          Result := 0;
        end;
      end;
    TDBXDataTypes.BytesType, TDBXDataTypes.VarBytesType:
      begin
        if PInteger(@FRow.FBlock.Buffer[CalculateOffset(Ordinal)+Length])^ <> SQL_NULL_DATA then
        begin
          IsNull := False;
          TDBXPlatform.CopyByteArray(FRow.FBlock.Buffer, CalculateOffset(Ordinal), Value, ValueOffset, Length);
          Result := Length;
        end
        else
        begin
          IsNull := True;
          Result := 0;
        end;
      end;
    else
      Result := 0;
  end;
end;

procedure TDBXOdbcReader.CheckResult(ReturnValue: SmallInt);
begin
  if (ReturnValue <> SQL_SUCCESS) and (ReturnValue <> SQL_SUCCESS_WITH_INFO) then
    OdbcRaiseError(FDBXContext, ReturnValue, SQL_HANDLE_STMT, FCommandHandle);
end;

function TDBXOdbcReader.CreateColumn(Ordinal: Word): TDBXWritableValue;
var
  ColumnName: TArray<Byte>;
  ActualLength, ErrorCode, NameLength, Nullable, Scale, SQLDataType: SmallInt;
  Precision: SQLULEN;
  Column: TDBXValueType;
begin
  //Some ODBC drivers will not return the correct value for the NameLength if passing a nil pointer for ColumnName
  //and some do not return the correct value for the NameLength if it exceeds the length
  //of the buffer that is passed in.
  SetLength(ColumnName, 64);
  FDBXContext.Trace(0, trace_SQLDescribeCol);
  ErrorCode := SQLDescribeCol(FCommandHandle, Ordinal+1, PChar(@ColumnName[0]), 32,
                              ActualLength, SQLDataType, Precision, Scale, Nullable);
  CheckResult(ErrorCode);
  NameLength := ActualLength+1;
  SetLength(ColumnName, NameLength*SizeOf(Char));
  FDBXContext.Trace(0, trace_SQLDescribeCol);
  ErrorCode := SQLDescribeCol(FCommandHandle, Ordinal+1, PChar(@ColumnName[0]), NameLength,
                              ActualLength, SQLDataType, Precision, Scale, Nullable);
  CheckResult(ErrorCode);
  Column := TDBXDriverHelp.CreateTDBXValueType(DBXContext);
  Column.Name := TDBXPlatform.BytesToWideStr(ColumnName);
  //Fallback as FieldDefs will require a name
  if Column.Name = '' then
    Column.Name := string.Format('COLUMN%d', [Ordinal+1]);
  Column.Ordinal := Ordinal;
  Column.Scale := Scale;
  Column.Precision := Precision;
  if Nullable = SQL_NULLABLE then
    Column.ValueTypeFlags := Column.ValueTypeFlags or TDBXValueTypeFlags.Nullable;
  SetTypeInfo(Column, SQLDataType);
  TDBXOdbcRow(FDbxRow).FColumnTypes[Ordinal] := Column.DataType;
  Result := TDBXValue.CreateValue(FDBXContext, Column, FDbxRow, True);
end;

constructor TDBXOdbcReader.Create(DBXContext: TDBXContext; EnvironmentHandle, ConnectionHandle, CommandHandle: OdbcHandle;
  ByteReader: TDBXOdbcByteReader; NumCols, RowSetSize: Int64);
var
  Values: TDBXWritableValueArray;
  I: Word;
  BufLength: Int64;
  ErrorCode: SmallInt;
begin
  inherited Create(DBXContext, ByteReader.FRow, ByteReader);
  FEnvironmentHandle := EnvironmentHandle;
  FConnectionHandle := ConnectionHandle;
  FCommandHandle := CommandHandle;
  SetLength(Values, NumCols);
  SetLength(ByteReader.FRow.FOffsets, NumCols);
  SetLength(ByteReader.FRow.FColumnTypes, NumCols);
  BufLength := 0;
  for I := 0 to High(Values) do
  begin
    Values[I] := CreateColumn(I);
    TDBXOdbcRow(FDbxRow).FOffsets[I] := BufLength;
    BufLength := BufLength + Values[I].ValueType.Size + TDBXOdbcRow(FDbxRow).FIndicatorSize;
  end;
  SetValues(Values);
  TDBXOdbcRow(FDbxRow).FBlock := TDBXOdbcBlockMgr.Create(BufLength, RowSetSize);
  FDBXContext.Trace(0, trace_SQLSetStmtAttr);
  ErrorCode := SQLSetStmtAttr(FCommandHandle, SQL_ATTR_ROW_BIND_TYPE, SQLPOINTER(BufLength), 0);
  CheckResult(ErrorCode);
  FDBXContext.Trace(0, trace_SQLSetStmtAttr);
  ErrorCode := SQLSetStmtAttr(FCommandHandle, SQL_ATTR_ROWS_FETCHED_PTR, SQLPOINTER(@ByteReader.FRow.FBlock.FRowsFetched), 0);
  CheckResult(ErrorCode);
  for I := 0 to High(Values) do
  begin
    //We do not bind columns which we may need to access with SQLGetData.  If we
    //support storing SQL_GETDATA_EXTENSIONS bitmask with metadata, we could bind
    //based on whether SQL_GD_BOUND is supported
    if Values[I].ValueType.DataType <> TDBXDataTypes.BlobType then
    begin
      FDBXContext.Trace(0, trace_SQLBindCol);
      ErrorCode := SQLBindCol(FCommandHandle, I+1, GetCDataTypeFromDbxType(Values[I].ValueType.DataType, Values[I].ValueType.SubType),
                              SQLPOINTER(@TDBXOdbcRow(FDbxRow).FBlock.Buffer[TDBXOdbcRow(FDbxRow).FOffsets[I]]),
                              Values[I].ValueType.Size,
                              PSqlLen(@TDBXOdbcRow(FDbxRow).FBlock.Buffer[TDBXOdbcRow(FDbxRow).FOffsets[I]+Values[I].ValueType.Size]));
      CheckResult(ErrorCode);
    end;
  end;
end;

procedure TDBXOdbcReader.DerivedClose;
var
  ErrorCode: SmallInt;
begin
  FDBXContext.Trace(0, trace_SQLFreeStmt);
  ErrorCode := SQLFreeStmt(FCommandHandle, SQL_CLOSE);
  CheckResult(ErrorCode);
end;

function TDBXOdbcReader.DerivedNext: Boolean;
var
  ErrorCode: SmallInt;
begin
  TDBXOdbcRow(FDbxRow).FBlock.Next;
  if (TDBXOdbcRow(FDbxRow).FBlock.CurrentRecord = 1) or
     (TDBXOdbcRow(FDbxRow).FBlock.CurrentRecord > TDBXOdbcRow(FDbxRow).FBlock.FRecCount) then
  begin
    FillChar(TDBXOdbcRow(FDbxRow).FBlock.FBuffer[0], Length(TDBXOdbcRow(FDbxRow).FBlock.Buffer), 0);
    FDBXContext.Trace(0, trace_SQLFetchScroll);
    ErrorCode := SQLFetchScroll(FCommandHandle, SQL_FETCH_NEXT, 0);
    if ErrorCode = SQL_NO_DATA then
      Result := False
    else
    begin
      CheckResult(ErrorCode);
      Result := True;
    end;
    if TDBXOdbcRow(FDbxRow).FBlock.CurrentRecord > TDBXOdbcRow(FDbxRow).FBlock.FRecCount then
      TDBXOdbcRow(FDbxRow).FBlock.Reset;
  end
  else
  begin
    if (TDBXOdbcRow(FDbxRow).FBlock.RowsFetched < TDBXOdbcRow(FDbxRow).FBlock.FRecCount) and
       (TDBXOdbcRow(FDbxRow).FBlock.CurrentRecord > TDBXOdbcRow(FDbxRow).FBlock.RowsFetched) then
      Result := False
    else
      Result := True;
  end;
end;

procedure TDBXOdbcReader.SetTypeInfo(Column: TDBXValueType; const SQLDataType: SmallInt);
begin
  case SQLDataType of
    SQL_CHAR:
      begin
        Column.DataType := TDBXDataTypes.AnsiStringType;
        Column.SubType := TDBXSubDataTypes.FixedSubType;
        Column.Size := Column.Precision + 1; //Null terminator
      end;
    SQL_VARCHAR:
      begin
        Column.DataType := TDBXDataTypes.AnsiStringType;
        Column.SubType := 0;
        Column.Size := Column.Precision + 1; //Null terminator
      end;
    SQL_LONGVARCHAR:
      begin
        Column.DataType := TDBXDataTypes.BlobType;
        Column.SubType := TDBXSubDataTypes.MemoSubType;
        Column.Precision := 1;
        Column.Size := 1;
      end;
    SQL_WCHAR:
      begin
        Column.DataType := TDBXDataTypes.WideStringType;
        Column.SubType := TDBXSubDataTypes.FixedSubType;
        Column.Size := (Column.Precision + 1) * SizeOf(Char);
      end;
    SQL_WVARCHAR:
      begin
        Column.DataType := TDBXDataTypes.WideStringType;
        Column.SubType := 0;
        Column.Size := (Column.Precision + 1) * SizeOf(Char);
      end;
    SQL_WLONGVARCHAR:
      begin
        Column.DataType := TDBXDataTypes.BlobType;
        Column.SubType := TDBXSubDataTypes.WideMemoSubType;
        Column.Precision := 1;
        Column.Size := 1;
      end;
    SQL_DECIMAL, SQL_NUMERIC:
      begin
        Column.DataType := TDBXDataTypes.BcdType;
        Column.SubType := 0;
        Column.Size := SizeOf(TBcd);
      end;
    SQL_SMALLINT:
      begin
        Column.DataType := TDBXDataTypes.Int16Type;
        Column.SubType := 0;
        Column.Precision := SizeOf(SmallInt);
        Column.Size := SizeOf(SmallInt);
      end;
    SQL_INTEGER:
      begin
        Column.DataType := TDBXDataTypes.Int32Type;
        Column.SubType := 0;
        Column.Precision := SizeOf(Integer);
        Column.Size := SizeOf(Integer);
      end;
    SQL_REAL:
      begin
        Column.DataType := TDBXDataTypes.SingleType;
        Column.SubType := 0;
        Column.Precision := SizeOf(Single);
        Column.Size := SizeOf(Single);
      end;
    SQL_DOUBLE, SQL_FLOAT:
      begin
        Column.DataType := TDBXDataTypes.DoubleType;
        Column.SubType := 0;
        Column.Precision := SizeOf(Double);
        Column.Size := SizeOf(Double);
      end;
    SQL_BIT:
      begin
        Column.DataType := TDBXDataTypes.BooleanType;
        Column.SubType := 0;
        Column.Precision := SizeOf(SmallInt);
        Column.Size := SizeOf(SmallInt);
      end;
    SQL_TINYINT:
      begin
        Column.DataType := TDBXDataTypes.Int8Type;
        Column.SubType := 0;
        Column.Precision := SizeOf(ShortInt);
        Column.Size := SizeOf(ShortInt);
      end;
    SQL_BIGINT:
      begin
        Column.DataType := TDBXDataTypes.Int64Type;
        Column.SubType := 0;
        Column.Precision := SizeOf(Int64);
        Column.Size := SizeOf(Int64);
      end;
    SQL_BINARY:
      begin
        Column.DataType := TDBXDataTypes.BytesType;
        Column.SubType := 0;
        Column.Size := Column.Precision;
      end;
    SQL_VARBINARY:
      begin
        Column.DataType := TDBXDataTypes.VarBytesType;
        Column.SubType := 0;
        Column.Size := Column.Precision + 2; //2 bytes size prefixed
      end;
    SQL_LONGVARBINARY:
      begin
        Column.DataType := TDBXDataTypes.BlobType;
        Column.SubType := TDBXSubDataTypes.BinarySubType;
        Column.Precision := 1;
        Column.Size := 1;
      end;
    SQL_TYPE_DATE:
      begin
        Column.DataType := TDBXDataTypes.DateType;
        Column.SubType := 0;
        Column.Size := SizeOf(SQL_DATE_STRUCT);
      end;
    SQL_TYPE_TIME:
      begin
        Column.DataType := TDBXDataTypes.TimeType;
        Column.SubType := 0;
        Column.Size := SizeOf(SQL_TIME_STRUCT);
      end;
    SQL_TYPE_TIMESTAMP:
      begin
        Column.DataType := TDBXDataTypes.TimeStampType;
        Column.SubType := 0;
        Column.Size := SizeOf(TSQLTimeStamp);
      end;
    SQL_TYPE_NULL:
      begin
        Column.DataType := TDBXDataTypes.UnknownType;
        Column.SubType := 0;
        Column.Size := 1;
      end
    else //We will treat unknown data types as strings
    begin
        Column.DataType := TDBXDataTypes.AnsiStringType;
        Column.SubType := 0;
        Column.Size := Column.Precision + 1; //Null terminator
    end;
  end;
end;

constructor TDBXOdbcDriverLoader.Create;
const
  ODBC_LOADER_NAME = 'TDBXOdbcDriverLoader';
begin
  inherited Create;
  FLoaderName := ODBC_LOADER_NAME;
end;

function TDBXOdbcDriverLoader.Load(DriverDef: TDBXDriverDef): TDBXDriver;
begin
  Result := TDBXOdbcDriver.Create(DriverDef);
end;

constructor TDBXOdbcBlockMgr.Create(RowLength, RowCount: Int64);
begin
  inherited Create;
  FCurrentRec := 0;
  FRowLength := RowLength;
  FRecCount := RowCount;
  SetLength(FBuffer, RowLength*RowCount);
end;

destructor TDBXOdbcBlockMgr.Destroy;
begin
  inherited Destroy;
end;

procedure TDBXOdbcBlockMgr.Next;
begin
  Inc(FCurrentRec);
end;

procedure TDBXOdbcBlockMgr.Reset;
begin
  FCurrentRec := 1;
end;

function TDBXOdbcRow.CalculateOffset(ColNum: Integer): Int64;
begin
  if FBlock.CurrentRecord > 0 then
    Result := FOffsets[ColNum] + (FBlock.CurrentRecord - 1) * FBlock.RowLength
  else
    Result := FOffsets[ColNum];
end;

procedure TDBXOdbcRow.GetAnsiString(DbxValue: TDBXAnsiStringValue;
  var AnsiStringBuilder: TDBXAnsiStringBuilder; var IsNull: LongBool);
begin
  if PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+DbxValue.ValueType.Precision])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    TDBXPlatform.ResizeStringBuilder(AnsiStringBuilder, DbxValue.ValueType.Precision+1);
    Move(FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)], AnsiStringBuilder[0], DBXValue.ValueType.Precision+1);
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcRow.GetWideString(DbxValue: TDBXWideStringValue;
  var WideStringBuilder: TDBXWideStringBuilder; var IsNull: LongBool);
begin
  if PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+DbxValue.ValueType.Precision*SizeOf(Char)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    TDBXPlatform.ResizeWideStringBuilder(WideStringBuilder, (DbxValue.ValueType.Precision+1)*SizeOf(Char));
    Move(FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)], WideStringBuilder[0], (DBXValue.ValueType.Precision+1)*SizeOf(Char));
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcRow.GetBoolean(DbxValue: TDBXBooleanValue;
  var Value: LongBool; var IsNull: LongBool);
begin
  if PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+SizeOf(LongBool)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    Value := PLongBool(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)])^;
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcRow.GetUInt8(DbxValue: TDBXUInt8Value; var Value: Byte;
  var IsNull: LongBool);
begin
  if PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+SizeOf(Byte)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    Value := PByte(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)])^;
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcRow.GetInt8(DbxValue: TDBXInt8Value; var Value: ShortInt;
  var IsNull: LongBool);
begin
  if PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+SizeOf(ShortInt)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    Value := PShortInt(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)])^;
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcRow.GetUInt16(DbxValue: TDBXUInt16Value; var Value: Word;
  var IsNull: LongBool);
begin
  if PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+SizeOf(Word)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    Value := PWord(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)])^;
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcRow.GetInt16(DbxValue: TDBXInt16Value; var Value: SmallInt;
  var IsNull: LongBool);
begin
  if PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+SizeOf(SmallInt)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    Value := PSmallInt(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)])^;
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcRow.GetInt32(DbxValue: TDBXInt32Value; var Value: TInt32;
  var IsNull: LongBool);
begin
  if PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+SizeOf(TInt32)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    Value := PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)])^;
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcRow.GetInt64(DbxValue: TDBXInt64Value; var Value: Int64;
  var IsNull: LongBool);
begin
  if PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+SizeOf(Int64)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    Value := PInt64(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)])^;
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcRow.GetSingle(DbxValue: TDBXSingleValue; var Value: Single;
  var IsNull: LongBool);
begin
  if PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+SizeOf(Single)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    Value := PSingle(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)])^;
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcRow.GetDouble(DbxValue: TDBXDoubleValue; var Value: Double;
  var IsNull: LongBool);
begin
  if PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+SizeOf(Double)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    Value := PDouble(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)])^;
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcRow.GetBcd(DbxValue: TDBXBcdValue; var Value: TBcd;
  var IsNull: LongBool);
begin
  if PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+DbxValue.ValueType.Size])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    Value := StrToBcd(string(AnsiString(PAnsiChar(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)]))));
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcRow.GetDate(DbxValue: TDBXDateValue; var Value: TDBXDate;
  var IsNull: LongBool);
var
  Year: SmallInt;
  Month, Day: Word;
  TimeStamp: TTimeStamp;
begin
  if PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+SizeOf(SQL_DATE_STRUCT)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    Year := PSmallInt(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)])^;
    Month := PWord(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+SizeOf(Word)])^;
    Day := PWord(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+SizeOf(Word)+SizeOf(Word)])^;
    TimeStamp := DateTimeToTimeStamp(EncodeDate(Year, Month, Day));
    Value := TimeStamp.Date;
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcRow.GetTime(DbxValue: TDBXTimeValue; var Value: TDBXTime;
  var IsNull: LongBool);
var
  Hour, Minute, Second: Word;
begin
  if PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+SizeOf(SQL_TIME_STRUCT)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    Hour := PWord(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)])^;
    Minute := PWord(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+SizeOf(Word)])^;
    Second := PWord(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+SizeOf(Word)+SizeOf(Word)])^;
    Value := (Hour * 60 + Minute) * MSecsPerSec * SecsPerMin + (Second * MSecsPerSec);
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcRow.GetTimeStamp(DbxValue: TDBXTimeStampValue;
  var Value: TSQLTimeStamp; var IsNull: LongBool);
begin
  if PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+SizeOf(TSQLTimeStamp)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    Value := PSQLTimeStamp(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)])^;
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcRow.GetTimeStampOffset(DbxValue: TDBXTimeStampOffsetValue;
  var Value: TSQLTimeStampOffset; var IsNull: LongBool);
begin
  if PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+SizeOf(TSQLTimeStampOffset)])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    Value := PSQLTimeStampOffset(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)])^;
  end
  else
    IsNull := True;
end;

procedure TDBXOdbcRow.GetBytes(DbxValue: TDBXByteArrayValue; Offset: Int64;
  const Buffer: TArray<Byte>; BufferOffset: Int64; Length: Int64;
  var ReturnLength: Int64; var IsNull: LongBool);
begin
  if PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+DBXValue.ValueType.Precision])^ <> SQL_NULL_DATA then
  begin
    IsNull := False;
    ReturnLength := PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+DBXValue.ValueType.Precision])^;
    if ReturnLength < Length then
      TDBXPlatform.CopyByteArray(FBlock.Buffer, CalculateOffset(DbxValue.ValueType.Ordinal), Buffer, BufferOffset, ReturnLength)
    else
      TDBXPlatform.CopyByteArray(FBlock.Buffer, CalculateOffset(DbxValue.ValueType.Ordinal), Buffer, BufferOffset, Length);
  end
  else
  begin
    IsNull := True;
    ReturnLength := 0;
  end;
end;

procedure TDBXOdbcRow.GetByteLength(DbxValue: TDBXByteArrayValue;
  var ByteLength: Int64; var IsNull: LongBool);
begin
  ByteLength := PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+DBXValue.ValueType.Precision])^;
  if ByteLength = 0 then
    IsNull := True;
end;

procedure TDBXOdbcRow.SetNull(DbxValue: TDBXValue);
begin
  if Assigned(FBlock) then
  begin
    case DbxValue.ValueType.DataType of
      TDBXDataTypes.BlobType, TDBXDataTypes.AnsiStringType, TDBXDataTypes.WideStringType,
      TDBXDataTypes.BcdType:
        PInteger(@FBlock.Buffer[FOffsets[DbxValue.ValueType.Ordinal]+DBXValue.ValueType.Size])^ := SQL_NULL_DATA;
      else
        PInteger(@FBlock.Buffer[FOffsets[DbxValue.ValueType.Ordinal]+GetTypeSize(DbxValue.ValueType.DataType)])^ := SQL_NULL_DATA;
    end;
  end;
end;

procedure TDBXOdbcRow.SetString(DbxValue: TDBXAnsiStringValue;
  const Value: AnsiString);
begin
  if Assigned(FBlock) then
  begin
    PInteger(@FBlock.Buffer[FOffsets[DbxValue.ValueType.Ordinal]+DbxValue.ValueType.Size-SizeOf(AnsiChar)])^ := DbxValue.ValueType.Size-SizeOf(AnsiChar);
    TDBXPlatform.CopyByteArray(TDBXPlatform.AnsiStrToBytes(Value), 0, FBlock.Buffer, FOffsets[DbxValue.ValueType.Ordinal], DbxValue.ValueType.Size-SizeOf(AnsiChar));
  end;
end;

procedure TDBXOdbcRow.SetWideString(DbxValue: TDBXWideStringValue;
  const Value: string);
begin
  if Assigned(FBlock) then
  begin
    PInteger(@FBlock.Buffer[FOffsets[DbxValue.ValueType.Ordinal]+DbxValue.ValueType.Size-SizeOf(Char)])^ := DbxValue.ValueType.Size-SizeOf(Char);
    TDBXPlatform.CopyByteArray(TDBXPlatform.WideStrToBytes(Value), 0, FBlock.Buffer, FOffsets[DbxValue.ValueType.Ordinal], DbxValue.ValueType.Size-SizeOf(Char));
  end;
end;

procedure TDBXOdbcRow.SetAnsiString(DbxValue: TDBXAnsiStringValue;
  const Value: AnsiString);
begin
  if Assigned(FBlock) then
    SetString(DbxValue, Value);
end;

procedure TDBXOdbcRow.SetUInt8(DbxValue: TDBXUInt8Value; Value: Byte);
begin
  if Assigned(FBlock) then
    TDBXPlatform.CopyInt8(Value, FBlock.Buffer, FOffsets[DbxValue.ValueType.Ordinal]);
end;

procedure TDBXOdbcRow.SetInt8(DbxValue: TDBXInt8Value; Value: ShortInt);
begin
  if Assigned(FBlock) then
    TDBXPlatform.CopyInt8(Value, FBlock.Buffer, FOffsets[DbxValue.ValueType.Ordinal]);
end;

procedure TDBXOdbcRow.SetUInt16(DbxValue: TDBXUInt16Value; Value: Word);
begin
  if Assigned(FBlock) then
    TDBXPlatform.CopyInt16(Value, FBlock.Buffer, FOffsets[DbxValue.ValueType.Ordinal]);
end;

procedure TDBXOdbcRow.SetInt16(DbxValue: TDBXInt16Value; Value: SmallInt);
begin
  if Assigned(FBlock) then
    TDBXPlatform.CopyInt16(Value, FBlock.Buffer, FOffsets[DbxValue.ValueType.Ordinal]);
end;

procedure TDBXOdbcRow.SetInt32(DbxValue: TDBXInt32Value; Value: TInt32);
begin
  if Assigned(FBlock) then
    TDBXPlatform.CopyInt32(Value, FBlock.Buffer, FOffsets[DbxValue.ValueType.Ordinal]);
end;

procedure TDBXOdbcRow.SetInt64(DbxValue: TDBXInt64Value; Value: Int64);
begin
  if Assigned(FBlock) then
    TDBXPlatform.CopyInt64(Value, FBlock.Buffer, FOffsets[DbxValue.ValueType.Ordinal]);
end;

procedure TDBXOdbcRow.SetSingle(DbxValue: TDBXSingleValue; Value: Single);
begin
  if Assigned(FBlock) then
    TDBXPlatform.CopyInt32(TDBXPlatform.SingleToInt32Bits(Value), FBlock.Buffer, FOffsets[DbxValue.ValueType.Ordinal]);
end;

procedure TDBXOdbcRow.SetDouble(DbxValue: TDBXDoubleValue; Value: Double);
begin
  if Assigned(FBlock) then
    TDBXPlatform.CopyInt64(TDBXPlatform.DoubleToInt64Bits(Value), FBlock.Buffer, FOffsets[DbxValue.ValueType.Ordinal]);
end;

procedure TDBXOdbcRow.SetBCD(DbxValue: TDBXBcdValue; var Value: TBcd);
var
  BcdInBytes: TArray<Byte>;
begin
  if Assigned(FBlock) then
  begin
    PInteger(@FBlock.Buffer[FOffsets[DbxValue.ValueType.Ordinal]+SizeOf(TBcd)])^ := SizeOf(TBcd);
    BcdInBytes := BcdToBytes(Value);
    TDBXPlatform.CopyByteArray(BcdInBytes, 0, FBlock.Buffer, FOffsets[DbxValue.ValueType.Ordinal], Length(BcdInBytes));
  end;
end;

procedure TDBXOdbcRow.SetDate(DbxValue: TDBXDateValue; Value: TDBXDate);
var
  TimeStamp: TTimeStamp;
  Year, Month, Day: Word;
begin
  if Assigned(FBlock) then
  begin
    TimeStamp.Time := 0;
    TimeStamp.Date := Value;
    DecodeDate(TimeStampToDateTime(TimeStamp), Year, Month, Day);
    PWord(@FBlock.Buffer[FOffsets[DbxValue.ValueType.Ordinal]])^ := Year;
    PWord(@FBlock.Buffer[FOffsets[DbxValue.ValueType.Ordinal]+SizeOf(Word)])^ := Month;
    PWord(@FBlock.Buffer[FOffsets[DbxValue.ValueType.Ordinal]+SizeOf(Word)+SizeOf(Word)])^ := Day;
  end;
end;

procedure TDBXOdbcRow.SetTime(DbxValue: TDBXTimeValue; Value: TDBXTime);
var
  TimeStamp: TTimeStamp;
  Hour, Minute, Second, MSec: Word;
begin
  if Assigned(FBlock) then
  begin
    TimeStamp.Date := 1;
    TimeStamp.Time := Value;
    //SQL_TIME_STRUCT does not support milliseconds
    DecodeTime(TimeStampToDateTime(TimeStamp), Hour, Minute, Second, MSec);
    PWord(@FBlock.Buffer[FOffsets[DbxValue.ValueType.Ordinal]])^ := Hour;
    PWord(@FBlock.Buffer[FOffsets[DbxValue.ValueType.Ordinal]+SizeOf(Word)])^ := Minute;
    PWord(@FBlock.Buffer[FOffsets[DbxValue.ValueType.Ordinal]+SizeOf(Word)+SizeOf(Word)])^ := Second;
  end;
end;

procedure TDBXOdbcRow.SetTimestamp(DbxValue: TDBXTimeStampValue;
  var Value: TSQLTimeStamp);
begin
  if Assigned(FBlock) then
    TDBXPlatform.CopySqlTimeStamp(Value, FBlock.Buffer, FOffsets[DbxValue.ValueType.Ordinal]);
end;

procedure TDBXOdbcRow.SetDynamicBytes(DbxValue: TDBXValue; Offset: Int64;
  const Buffer: TArray<Byte>; BufferOffset: Int64; Length: Int64);
begin
  if Assigned(FBlock) then
    TDBXPlatform.CopyByteArray(Buffer, BufferOffset, FBlock.Buffer, FOffsets[DbxValue.ValueType.Ordinal], Length);
end;

procedure TDBXOdbcRow.SetValueType(ValueType: TDBXValueType);
begin
end;

procedure TDBXOdbcRow.GetStream(DbxValue: TDBXStreamValue; var Stream: TStream;
  var IsNull: LongBool);
var
  ByteLength, ReturnLength: Int64;
  ByteBuffer: TArray<Byte>;
begin
  GetLength(DbxValue, ByteLength, IsNull);
  if not IsNull then
  begin
    SetLength(ByteBuffer, ByteLength);
    GetBytes(DbxValue, 0, ByteBuffer, 0, ByteLength, ReturnLength, IsNull);
    Stream := TBytesStream.Create(ByteBuffer);
  end;
end;

procedure TDBXOdbcRow.SetAnsiMemo(DbxValue: TDBXAnsiMemoValue;
  const Value: AnsiString);
begin
  SetDynamicBytes(DbxValue, 0, TDBXPlatform.AnsiStrToBytes(Value), 0, Length(Value));
end;

procedure TDBXOdbcRow.SetWideMemo(DbxValue: TDBXWideMemoValue;
  const Value: string);
begin
  SetDynamicBytes(DbxValue, 0, TDBXPlatform.WideStrToBytes(Value), 0, Value.Length*SizeOf(Char));
end;

procedure TDBXOdbcRow.SetBoolean(DbxValue: TDBXBooleanValue; Value: Boolean);
begin
  if Assigned(FBlock) then
    TDBXPlatform.CopyInt16(SmallInt(Value), FBlock.Buffer, FOffsets[DbxValue.ValueType.Ordinal]);
end;

procedure TDBXOdbcRow.GetLength(DbxValue: TDBXValue; var ByteLength: Int64;
  var IsNull: LongBool);
begin
  ByteLength := PInteger(@FBlock.Buffer[CalculateOffset(DbxValue.ValueType.Ordinal)+DBXValue.ValueType.Precision])^;
  if ByteLength = 0 then
    IsNull := True;
end;

constructor TDBXOdbcRow.Create(DBXContext: TDBXContext; EnvironmentHandle, ConnectionHandle, CommandHandle: OdbcHandle);
begin
  inherited Create(DBXContext);
  FEnvironmentHandle := EnvironmentHandle;
  FConnectionHandle := ConnectionHandle;
  FCommandHandle := CommandHandle;
  FIndicatorSize := SizeOf(SQLLEN);
end;

destructor TDBXOdbcRow.Destroy;
begin
  FBlock.Free;
  SetLength(FOffsets, 0);
  SetLength(FColumnTypes, 0);
  inherited Destroy;
end;

constructor TDBXOdbcTransaction.Create(Connection: TDBXConnection; IsolationLevel: TDBXIsolation; TransactionId: Integer);
begin
  inherited Create(Connection);
  FIsolationLevel := IsolationLevel;
  FId := TransactionId;
end;

{ TDBXOdbcProperties }

constructor TDBXOdbcProperties.Create(DBXContext: TDBXContext);
begin
  inherited Create(DBXContext);
  Values[TDBXPropertyNames.DriverUnit] := 'Data.DbxOdbc';
  Values[TDBXPropertyNames.DriverPackageLoader] := 'TDBXOdbcDriverLoader,DBXOdbcDriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.MetaDataPackageLoader] := 'TDBXOdbcMetaDataCommandFactory,DbxOdbcDriver' + PackageVersion + '.bpl';

  Values[TDBXPropertyNames.IsolationLevel] := 'ReadCommitted';
  Values['RowSetSize'] := '20';
end;

initialization
  TDBXDriverRegistry.RegisterDriverClass(sDriverName, TDBXOdbcDriver);
finalization
  TDBXDriverRegistry.UnloadDriver(sDriverName);

end.
