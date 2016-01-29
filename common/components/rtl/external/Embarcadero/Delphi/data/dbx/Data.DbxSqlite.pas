{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


{$HPPEMIT '#pragma link "Data.DbxSqlite"'}    {Do not Localize}
unit Data.DbxSqlite;

interface

uses
  Data.DBXCommon, Data.DBXCommonResStrs, Data.DBXPlatform, Data.FMTBcd, Data.SqlTimSt,
  System.Classes, System.Sqlite, System.SysUtils;

{$IFDEF WIN32}
{$HPPEMIT ''}
{$HPPEMIT '#ifndef USEPACKAGES'}
{$HPPEMIT '/* automatically link to sqlite3.lib */'}
{$HPPEMIT '#pragma link "sqlite3.lib"'}
{$HPPEMIT '#endif'}
{$HPPEMIT ''}
{$ENDIF WIN32}

{$IFDEF WIN64}
{$HPPEMIT ''}
{$HPPEMIT '#ifndef USEPACKAGES'}
{$HPPEMIT '/* automatically link to sqlite3.a */'}
{$HPPEMIT '#pragma link "sqlite3.a"'}
{$HPPEMIT '#endif'}
{$HPPEMIT ''}
{$ENDIF WIN64}

{$IF DEFINED(MACOS) or DEFINED(IOS)}
{$HPPEMIT ''}
{$HPPEMIT '#ifndef USEPACKAGES'}
{$HPPEMIT '/* automatically link to libsqlite3.dylib */'}
{$HPPEMIT '#pragma link "libsqlite3.dylib"'}
{$HPPEMIT '#endif'}
{$HPPEMIT ''}
{$ENDIF MACOS or IOS}

type
  TDBXSqliteProperties = class(TDBXProperties)
  public
    constructor Create(DBXContext: TDBXContext); override;
  end;

  TDBXSqliteDriverLoader = class(TDBXDriverLoader)
  public
    constructor Create; override;
    function Load(DriverDef: TDBXDriverDef): TDBXDriver; override;
  end;

  TDBXSqliteDriver = class(TDBXDriver)
  private
    function CreateSqliteCommand(DbxContext: TDBXContext; Connection: TDBXConnection;
      MorphicCommand: TDBXCommand): TDBXCommand;
  protected
    procedure Close; override;
    function CreateConnection(ConnectionBuilder: TDBXConnectionBuilder): TDBXConnection; override;
  public
    constructor Create(DriverDef: TDBXDriverDef); override;
    procedure GetDriverPropertyNames(List: TStrings); override;
    function GetDriverVersion: string; override;
  end;

  TDBXSqliteConnection = class(TDBXConnection)
  private
    FConnectionHandle: sqlite3;
    FTransactionId: Integer;
    FLibraryHandle: HModule;
  protected
    procedure Commit(const InTransaction: TDBXTransaction); override;
    function CreateAndBeginTransaction(const Isolation: TDBXIsolation): TDBXTransaction; override;
    procedure DerivedClose; override;
    procedure DerivedGetCommands(const CommandType: string;
      const List: TStrings); override;
    procedure DerivedGetCommandTypes(const List: TStrings); override;
    procedure DerivedOpen; override;
    function GetProductName: string; override;
    function GetProductVersion: string; override;
    procedure Rollback(const InTransaction: TDBXTransaction); override;
  public
    constructor Create(ConnectionBuilder:  TDBXConnectionBuilder);
    destructor Destroy; override;
    function GetVendorProperty(const Name: string): string; override;
    property ConnectionHandle: sqlite3 read FConnectionHandle;
  end;

  TDBXSqliteRow = class;

  TDBXSqliteCommand = class(TDBXCommand)
  private
    FRowsAffected: Integer;
    [Weak]FParameterRow: TDBXSqliteRow;
    [Weak]FSqliteConnection: TDBXSqliteConnection;
    FStatementHandle: sqlite3_stmt;
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
    procedure SetText(const Value: string); override;
  public
    constructor Create(DBXContext: TDBXContext; SqliteConnection: TDBXSqliteConnection);
    destructor Destroy; override;
    property StatementHandle: sqlite3_stmt read FStatementHandle;
  end;

  TDBXSqliteRow = class(TDBXRow)
  private
    [Weak]FSqliteConnection: TDBXSqliteConnection;
    FStatementHandle: sqlite3_stmt;
  protected
{$IFNDEF NEXTGEN}
    procedure GetAnsiString(DbxValue: TDBXAnsiStringValue;
      var AnsiStringBuilder: TDBXAnsiStringBuilder; var IsNull: LongBool); override;
{$ENDIF !NEXTGEN}
    procedure GetBcd(DbxValue: TDBXBcdValue; var Value: TBcd; var IsNull: LongBool); override;
    procedure GetBoolean(DbxValue: TDBXBooleanValue; var Value: LongBool; var IsNull: LongBool); override;
    procedure GetByteLength(DbxValue: TDBXByteArrayValue; var ByteLength: Int64; var IsNull: LongBool); override;
    procedure GetBytes(DbxValue: TDBXByteArrayValue; Offset: Int64; const Buffer: TArray<Byte>; BufferOffset, Length: Int64; var ReturnLength: Int64; var IsNull: LongBool); override;
    procedure GetDate(DbxValue: TDBXDateValue; var Value: TDBXDate; var IsNull: LongBool); override;
    procedure GetDouble(DbxValue: TDBXDoubleValue; var Value: Double;
      var IsNull: LongBool); override;
    procedure GetInt8(DbxValue: TDBXInt8Value; var Value: ShortInt;
      var IsNull: LongBool); override;
    procedure GetInt16(DbxValue: TDBXInt16Value; var Value: SmallInt;
      var IsNull: LongBool); override;
    procedure GetInt32(DbxValue: TDBXInt32Value; var Value: TInt32;
      var IsNull: LongBool); override;
    procedure GetInt64(DbxValue: TDBXInt64Value; var Value: Int64;
      var IsNull: LongBool); override;
    procedure GetSingle(DbxValue: TDBXSingleValue; var Value: Single;
      var IsNull: LongBool); override;
    procedure GetTime(DbxValue: TDBXTimeValue; var Value: TDBXTime; var IsNull: LongBool); override;
    procedure GetTimeStamp(DbxValue: TDBXTimeStampValue; var Value: TSQLTimeStamp; var IsNull: LongBool); override;
    procedure GetTimeStampOffset(DbxValue: TDBXTimeStampOffsetValue; var Value: TSQLTimeStampOffset; var IsNull: LongBool); override;
    procedure GetUInt8(DbxValue: TDBXUInt8Value; var Value: Byte;
      var IsNull: LongBool); override;
    procedure GetUInt16(DbxValue: TDBXUInt16Value; var Value: Word;
      var IsNull: LongBool); override;
    procedure GetWideString(DbxValue: TDBXWideStringValue;
      var WideStringBuilder: TDBXWideStringBuilder; var IsNull: LongBool); overload; override;
{$IFNDEF NEXTGEN}
    procedure SetAnsiString(DbxValue: TDBXAnsiStringValue; const Value: AnsiString); override;
{$ENDIF !NEXTGEN}
    procedure SetBoolean(DbxValue: TDBXBooleanValue; Value: Boolean); override;
    procedure SetDouble(DbxValue: TDBXDoubleValue; Value: Double); override;
    procedure SetDynamicBytes(DbxValue: TDBXValue; Offset: Int64; const Buffer: TArray<Byte>;
                              BufferOffset: Int64; Length: Int64); override;
    procedure SetInt8(DbxValue: TDBXInt8Value; Value: ShortInt); override;
    procedure SetInt16(DbxValue: TDBXInt16Value; Value: SmallInt); override;
    procedure SetInt32(DbxValue: TDBXInt32Value; Value: TInt32); override;
    procedure SetInt64(DbxValue: TDBXInt64Value; Value: Int64); override;
    procedure SetNull(DbxValue: TDBXValue); override;
    procedure SetSingle(DbxValue: TDBXSingleValue; Value: Single); override;
{$IFNDEF NEXTGEN}
    procedure SetString(DbxValue: TDBXAnsiStringValue; const Value: AnsiString); override;
{$ELSE}
    procedure SetString(DbxValue: TDBXAnsiStringValue; const Value: string); override;
{$ENDIF}
    procedure SetUInt8(DbxValue: TDBXUInt8Value; Value: Byte); override;
    procedure SetUInt16(DbxValue: TDBXUInt16Value; Value: Word); override;
    procedure SetValueType(ValueType: TDBXValueType); override;
    procedure SetWideString(DbxValue: TDBXWideStringValue; const Value: string); override;
  public
    constructor Create(DBXContext: TDBXContext; Connection: TDBXSqliteConnection; StatementHandle: sqlite3_stmt);
  end;

  TDBXSqliteByteReader = class(TDBXByteReader)
  private
    [Weak]FSqliteConnection: TDBXSqliteConnection;
    FStatementHandle: sqlite3_stmt;
  protected
    constructor Create(DBXContext: TDBXContext; Connection: TDBXSqliteConnection; StatementHandle: sqlite3_stmt);
  public
{$IFNDEF NEXTGEN}
    procedure GetAnsiString(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
{$ENDIF !NEXTGEN}
    procedure GetBcd(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetByteLength(Ordinal: TInt32; var Length: Int64; var IsNull: LongBool); override;
    function  GetBytes(Ordinal: TInt32; Offset: Int64; const Value: TArray<Byte>;
      ValueOffset, Length: Int64; var IsNull: LongBool): Int64; override;
    procedure GetDate(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetDouble(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetInt8(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetInt16(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetInt32(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetInt64(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetSingle(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetTime(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetTimeStamp(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetTimeStampOffset(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetUInt8(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetUInt16(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetWideString(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
  end;

  TDBXSqliteReader = class(TDBXReader)
  private
    [Weak]FSqliteConnection: TDBXSqliteConnection;
    FStatementHandle: sqlite3_stmt;
  protected
    constructor Create(DBXContext: TDBXContext; Connection: TDBXSqliteConnection;
      StatementHandle: sqlite3_stmt; ByteReader: TDBXSqliteByteReader; NumCols: Integer);
    procedure DerivedClose; override;
    function DerivedNext: Boolean; override;
  end;

  TDBXSqliteTransaction = class(TDBXTransaction)
  private
    FId: Integer;
  public
    constructor Create(Connection: TDBXConnection; TransactionId: Integer);
  end;

procedure CheckError(ErrorCode: Integer; DbConnection: sqlite3; DBXContext: TDBXContext);

{$IFNDEF MSWINDOWS}
var
  sqlite3_column_origin_name16: function(Statement: sqlite3_stmt; ColumnNum: Integer): PChar; cdecl = nil;
  sqlite3_column_database_name16: function(Statement: sqlite3_stmt; ColumnNum: Integer): PChar; cdecl = nil;
  sqlite3_column_table_name16: function(Statement: sqlite3_stmt; ColumnNum: Integer): PChar; cdecl = nil;
  sqlite3_table_column_metadata: function(db: sqlite3; zDbName, zTableName, zColumnName: MarshaledAString;
                                          out pzDataType, pzCollSeq: MarshaledAString; out pNotNull,
                                          pPrimaryKey, pAutoinc: Integer): Integer; cdecl = nil;
{$ENDIF !MSWINDOWS}

implementation

uses
  Data.DbxSqliteMetaData, Data.DbxSqliteReadOnlyMetaData, Data.DbxSqliteResStrs
{$IFDEF MACOS}
  , Macapi.CoreFoundation
{$ENDIF MACOS}
;

const
  sDriverName = 'Sqlite';

  trace_sqlite3_bind_blob = 'sqlite3_bind_blob';
  trace_sqlite3_bind_double = 'sqlite3_bind_double';
  trace_sqlite3_bind_int = 'sqlite3_bind_int';
  trace_sqlite3_bind_int64 = 'sqlite3_bind_int64';
  trace_sqlite3_bind_null = 'sqlite3_bind_null';
  trace_sqlite3_bind_text = 'sqlite3_bind_text';
  trace_sqlite3_bind_text16 = 'sqlite3_bind_text16';
  trace_sqlite3_changes = 'sqlite3_changes';
  trace_sqlite3_close = 'sqlite3_close';
  trace_sqlite3_column_blob = 'sqlite3_column_blob';
  trace_sqlite3_column_bytes16 = 'sqlite3_column_bytes16';
  trace_sqlite3_column_count = 'sqlite3_column_count';
  trace_sqlite3_column_database_name16 = 'sqlite3_column_database_name16';
  trace_sqlite3_column_decltype16 = 'sqlite3_column_decltype16';
  trace_sqlite3_column_double = 'sqlite3_column_double';
  trace_sqlite3_column_int = 'sqlite3_column_int';
  trace_sqlite3_column_int64 = 'sqlite3_column_int64';
  trace_sqlite3_column_origin_name16 = 'sqlite3_column_origin_name16';
  trace_sqlite3_column_table_name16 = 'sqlite3_column_table_name16';
  trace_sqlite3_column_text = 'sqlite3_column_text';
  trace_sqlite3_column_text16 = 'sqlite3_column_text16';
  trace_sqlite3_column_type = 'sqlite3_column_type';
  trace_sqlite3_errmsg16 = 'sqlite3_errmsg16';
  trace_sqlite3_finalize = 'sqlite3_finalize';
  trace_sqlite3_libversion = 'sqlite3_libversion';
  trace_sqlite3_open_v2 = 'sqlite3_open_v2';
  trace_sqlite3_open16 = 'sqlite3_open16';
  trace_sqlite3_prepare16_v2 = 'sqlite3_prepare16_v2';
  trace_sqlite3_reset = 'sqlite3_reset';
  trace_sqlite3_step = 'sqlite3_step';
  trace_sqlite3_table_column_metadata = 'sqlite3_table_column_metadata';


procedure CheckError(ErrorCode: Integer; DbConnection: sqlite3; DBXContext: TDBXContext);
var
  ErrorMessage: string;
  LContext: TDBXContext;
begin
  if (ErrorCode <> SQLITE_OK) and (ErrorCode <> SQLITE_ROW) and (ErrorCode <> SQLITE_DONE) then
  begin
    ErrorMessage := sqlite3_errmsg16(DbConnection);
    if Assigned(DBXContext) then
      DBXContext.Error(ErrorCode, ErrorMessage)
    else
    begin
      LContext := TDBXContext.Create;
      LContext.Error(ErrorCode, ErrorMessage);
    end;
  end;
end;

{ TDBXSqliteProperties }

constructor TDBXSqliteProperties.Create(DBXContext: TDBXContext);
begin
  inherited Create(DBXContext);
  Values[TDBXPropertyNames.DriverUnit] := 'Data.DbxSqlite';
  Values[TDBXPropertyNames.DriverPackageLoader] := 'TDBXSqliteDriverLoader,DBXSqliteDriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.MetaDataPackageLoader] := 'TDBXSqliteMetaDataCommandFactory,DbxSqliteDriver' + PackageVersion + '.bpl';
  Values['FailIfMissing'] := 'True';
end;

{ TDBXSqliteDriverLoader }

constructor TDBXSqliteDriverLoader.Create;
const
  SQLITE_LOADER_NAME = 'TDBXSqliteDriverLoader';
begin
  inherited Create;
  FLoaderName := SQLITE_LOADER_NAME;
end;

function TDBXSqliteDriverLoader.Load(DriverDef: TDBXDriverDef): TDBXDriver;
begin
  Result := TDBXSqliteDriver.Create(DriverDef);
end;

{ TDBXSqliteDriver }

function TDBXSqliteDriver.CreateSqliteCommand(DbxContext: TDBXContext; Connection: TDBXConnection; MorphicCommand: TDBXCommand): TDBXCommand;
begin
  Result := TDBXSqliteCommand.Create(DbxContext, TDBXSqliteConnection(Connection));
end;

procedure TDBXSqliteDriver.Close;
begin
  inherited;
end;

function TDBXSqliteDriver.CreateConnection(ConnectionBuilder: TDBXConnectionBuilder): TDBXConnection;
begin
  Result := TDBXSqliteConnection.Create(ConnectionBuilder);
end;

constructor TDBXSqliteDriver.Create(DriverDef: TDBXDriverDef);
var
  Props: TDBXSqliteProperties;
  I, Index: Integer;
begin
  Props := TDBXSqliteProperties.Create(DriverDef.FDBXContext);
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
  rpr;
  // '' makes this the default command factory.
  AddCommandFactory('', CreateSqliteCommand);
  InitDriverProperties(Props);
  if (DriverProperties = nil) or not DriverProperties.GetBoolean(TDBXPropertyNames.AutoUnloadDriver) then
    CacheUntilFinalization;
end;

procedure TDBXSqliteDriver.GetDriverPropertyNames(List: TStrings);
begin
  List.Add(TDBXPropertyNames.DriverUnit);
  List.Add(TDBXPropertyNames.DriverPackageLoader);
  List.Add(TDBXPropertyNames.MetaDataPackageLoader);
end;

function TDBXSqliteDriver.GetDriverVersion: string;
begin
  Result := DBXVersion40;
end;

{ TDBXSqliteConnection }

procedure TDBXSqliteConnection.Commit(const InTransaction: TDBXTransaction);
var
  Command: TDBXCommand;
  CommandStr: string;
begin
  Command := CreateCommand;
  try
    CommandStr := 'RELEASE SAVEPOINT TRANS' + IntToStr(TDBXSqliteTransaction(InTransaction).FId);
    Command.Text := CommandStr;
    Command.CommandType := TDBXCommandTypes.DbxSQL;
    FDBXContext.Trace(0, CommandStr);
    Command.ExecuteUpdate;
  finally
    Command.Free;
  end;
end;

function TDBXSqliteConnection.CreateAndBeginTransaction(const Isolation: TDBXIsolation): TDBXTransaction;
var
  Command: TDBXCommand;
  CommandStr: string;
begin
  Inc(FTransactionId);
  Command := CreateCommand;
  try
    CommandStr := 'SAVEPOINT TRANS' + IntToStr(FTransactionId);
    Command.Text := CommandStr;
    Command.CommandType := TDBXCommandTypes.DbxSQL;
    FDBXContext.Trace(0, CommandStr);
    Command.ExecuteUpdate;
  finally
    Command.Free;
  end;
  Result := TDBXSqliteTransaction.Create(Self, FTransactionId);
end;

procedure TDBXSqliteConnection.DerivedClose;
var
  ErrorCode: Integer;
begin
  if Assigned(FConnectionHandle) then
  begin
    FDBXContext.Trace(0, trace_sqlite3_close);
    ErrorCode := sqlite3_close(FConnectionHandle);
    CheckError(ErrorCode, FConnectionHandle, FDBXContext);
  end;
end;

procedure TDBXSqliteConnection.DerivedGetCommands(const CommandType: string; const List: TStrings);
begin
end;

procedure TDBXSqliteConnection.DerivedGetCommandTypes(const List: TStrings);
begin
end;

procedure TDBXSqliteConnection.DerivedOpen;
{$IFNDEF MSWINDOWS}
  procedure LoadColumnMetaDataSymbols;
  begin
    if (@sqlite3_column_origin_name16 = nil) or (@sqlite3_column_database_name16 = nil) or
       (@sqlite3_column_table_name16 = nil) or (@sqlite3_table_column_metadata = nil) then
    begin
      FLibraryHandle := LoadLibrary(MarshaledString(sqlite3dll));
      sqlite3_column_origin_name16 := GetProcAddress(FLibraryHandle, 'sqlite3_column_origin_name16');
      sqlite3_column_database_name16 := GetProcAddress(FLibraryHandle, 'sqlite3_column_database_name16');
      sqlite3_column_table_name16 := GetProcAddress(FLibraryHandle, 'sqlite3_column_table_name16');
      sqlite3_table_column_metadata := GetProcAddress(FLibraryHandle, 'sqlite3_table_column_metadata');
      if (@sqlite3_column_origin_name16 = nil) or (@sqlite3_column_database_name16 = nil) or
         (@sqlite3_column_table_name16 = nil) or (@sqlite3_table_column_metadata = nil) then
        raise Exception.Create(SColumnMetaDataNotSupported);
    end;
  end;
{$ENDIF !MSWINDOWS}
var
  DatabaseName: string;
  ErrorCode: Integer;
begin
  if ConnectionProperties.Values['ColumnMetaDataSupported'] = '' then
{$IFDEF MSWINDOWS}
    ConnectionProperties.Values['ColumnMetaDataSupported'] := 'True';
{$ENDIF}
{$IFDEF MACOS}
    ConnectionProperties.Values['ColumnMetaDataSupported'] := 'False';
{$ENDIF}
  DatabaseName := FConnectionProperties.Values[TDBXPropertyNames.Database];
  try
    if string.Compare(FConnectionProperties.Values['FailIfMissing'], 'True', True) = 0 then
      ErrorCode := sqlite3_open_v2(MarshaledAString(Utf8Encode(DatabaseName)), FConnectionHandle, SQLITE_OPEN_READWRITE, nil)
    else
      ErrorCode := sqlite3_open16(PChar(DatabaseName), FConnectionHandle);
  except
    raise Exception.Create(SLibraryNotFound);
  end;
  CheckError(ErrorCode, FConnectionHandle, FDBXContext);
{$IFNDEF MSWINDOWS}
  if string.Compare(ConnectionProperties.Values['ColumnMetaDataSupported'], 'True', True) = 0 then
    LoadColumnMetaDataSymbols;
{$ENDIF !MSWINDOWS}
end;

function TDBXSqliteConnection.GetProductName: string;
const
  ProductName = 'Sqlite';
begin
  Result := ProductName;
end;

function TDBXSqliteConnection.GetProductVersion: string;
begin
  Result := string(sqlite3_libversion);
end;

procedure TDBXSqliteConnection.Rollback(const InTransaction: TDBXTransaction);
var
  Command: TDBXCommand;
  CommandStr: string;
begin
  Command := CreateCommand;
  try
    CommandStr := 'ROLLBACK TO TRANS' + IntToStr(TDBXSqliteTransaction(InTransaction).FId);
    Command.Text := CommandStr;
    Command.CommandType := TDBXCommandTypes.DbxSQL;
    FDBXContext.Trace(0, CommandStr);
    Command.ExecuteUpdate;
  finally
    Command.Free;
  end;
end;

constructor TDBXSqliteConnection.Create(ConnectionBuilder:  TDBXConnectionBuilder);
begin
  inherited Create(ConnectionBuilder);
  FTransactionId := 0;
  FLibraryHandle := HModule(0);
end;

destructor TDBXSqliteConnection.Destroy;
begin
{$IFNDEF MSWINDOWS}
  FreeLibrary(FLibraryHandle);
{$ENDIF !MSWINDOWS}
  inherited Destroy;
end;

function TDBXSqliteConnection.GetVendorProperty(const Name: string): string;
begin
  if Name = 'ColumnMetaDataSupported' then
    Result := FConnectionProperties['ColumnMetaDataSupported']
  else if Name = 'DriverDataTypes' then
    Result := '{18,0},{7,0},{3,23},{3,32}'
  else
    Result := '';
end;

{ TDBXSqliteCommand }

function TDBXSqliteCommand.CreateParameterRow: TDBXRow;
var
  LParameterRow: TDBXSqliteRow;
begin
  LParameterRow := TDBXSqliteRow.Create(FDBXContext, FSqliteConnection, FStatementHandle);
  FParameterRow := LParameterRow;
  Result := LParameterRow;
end;

procedure TDBXSqliteCommand.DerivedClose;
var
  ErrorCode: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_finalize);
  ErrorCode := sqlite3_finalize(FStatementHandle);
  FStatementHandle := nil;
  CheckError(ErrorCode, FSqliteConnection.ConnectionHandle, FDBXContext);
end;

function TDBXSqliteCommand.DerivedExecuteQuery: TDBXReader;
var
  ErrorCode, NumCols: Integer;
  ByteReader: TDBXSqliteByteReader;
begin
  FDBXContext.Trace(0, Text);
  Result := nil;
  FDBXContext.Trace(0, trace_sqlite3_step);
  ErrorCode := sqlite3_step(FStatementHandle);
  CheckError(ErrorCode, FSqliteConnection.ConnectionHandle, FDBXContext);
  FDBXContext.Trace(0, trace_sqlite3_changes);
  FRowsAffected := sqlite3_changes(FSqliteConnection.ConnectionHandle);
  FDBXContext.Trace(0, trace_sqlite3_column_count);
  NumCols := sqlite3_column_count(FStatementHandle);
  if NumCols > 0 then
  begin
    ByteReader := TDBXSqliteByteReader.Create(FDBXContext, FSqliteConnection, FStatementHandle);
    Result := TDBXSqliteReader.Create(FDBXContext, FSqliteConnection, FStatementHandle, ByteReader, NumCols);
  end;
  FDBXContext.Trace(0, trace_sqlite3_reset);
  ErrorCode := sqlite3_reset(FStatementHandle);
  CheckError(ErrorCode, FSqliteConnection.ConnectionHandle, FDBXContext);
end;

procedure TDBXSqliteCommand.DerivedExecuteUpdate;
var
  ErrorCode: Integer;
begin
  FDBXContext.Trace(0, Text);
  FDBXContext.Trace(0, trace_sqlite3_step);
  ErrorCode := sqlite3_step(FStatementHandle);
  try
    CheckError(ErrorCode, FSqliteConnection.ConnectionHandle, FDBXContext);
  finally
    FDBXContext.Trace(0, trace_sqlite3_reset);
    ErrorCode := sqlite3_reset(FStatementHandle);
    CheckError(ErrorCode, FSqliteConnection.ConnectionHandle, FDBXContext);
  end;
  FDBXContext.Trace(0, trace_sqlite3_changes);
  FRowsAffected := sqlite3_changes(FSqliteConnection.ConnectionHandle);
end;

function TDBXSqliteCommand.DerivedGetNextReader: TDBXReader;
begin
  Result := nil;
end;

procedure TDBXSqliteCommand.DerivedOpen;
var
  ErrorCode: Integer;
  Dummy: PChar;
begin
  Dummy := nil;
  FDBXContext.Trace(0, trace_sqlite3_prepare16_v2);
  ErrorCode := sqlite3_prepare16_v2(FSqliteConnection.ConnectionHandle, PChar(Text), Text.Length * SizeOf(Char), FStatementHandle, Dummy);
  CheckError(ErrorCode, FSqliteConnection.ConnectionHandle, FDBXContext);
end;

procedure TDBXSqliteCommand.DerivedPrepare;
begin
  inherited;
end;

function TDBXSqliteCommand.GetRowsAffected: Int64;
begin
  Result := FRowsAffected;
end;

procedure TDBXSqliteCommand.SetMaxBlobSize(const MaxBlobSize: Int64);
begin
  inherited;
end;

procedure TDBXSqliteCommand.SetRowSetSize(const RowSetSize: Int64);
begin
  inherited;
end;

procedure TDBXSqliteCommand.SetText(const Value: string);
begin
  Close;
  inherited;
end;

constructor TDBXSqliteCommand.Create(DBXContext: TDBXContext; SqliteConnection: TDBXSqliteConnection);
begin
  inherited Create(DbxContext);
  FSqliteConnection := SqliteConnection;
  FStatementHandle := nil;
  FParameterRow := nil;
  FRowsAffected := 0;
end;

destructor TDBXSqliteCommand.Destroy;
begin
  Close;
  inherited Destroy;
end;

{ TDBXSqliteRow }

{$IFNDEF NEXTGEN}
procedure TDBXSqliteRow.GetAnsiString(DbxValue: TDBXAnsiStringValue;
  var AnsiStringBuilder: TDBXAnsiStringBuilder; var IsNull: LongBool);
var
  AnsiStr: AnsiString;
  AnsiStrLen, ColType: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, DBXValue.ValueType.Ordinal);
  FDBXContext.Trace(0, trace_sqlite3_column_text);
  AnsiStr := sqlite3_column_text(FStatementHandle, DBXValue.ValueType.Ordinal);
  AnsiStrLen := Length(AnsiStr)+1;
  if AnsiStrLen > 1 then
  begin
    TDBXPlatform.ResizeStringBuilder(AnsiStringBuilder, AnsiStrLen);
    TDBXPlatform.CopyStringToBuilder(AnsiStr, AnsiStrLen, AnsiStringBuilder);
    IsNull := False;
  end
  else
  begin
    if ColType = SQLITE_NULL then
      IsNull := True
    else
    begin
      TDBXPlatform.ResizeStringBuilder(AnsiStringBuilder, AnsiStrLen);
      AnsiStringBuilder[0] := #0;
      IsNull := False;
    end;
  end;
end;
{$ENDIF !NEXTGEN}

procedure TDBXSqliteRow.GetBcd(DbxValue: TDBXBcdValue; var Value: TBcd; var IsNull: LongBool);
begin
  inherited;
end;

procedure TDBXSqliteRow.GetBoolean(DbxValue: TDBXBooleanValue; var Value: LongBool; var IsNull: LongBool);
var
  ColType, ColValue: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, DBXValue.ValueType.Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_int);
    ColValue := sqlite3_column_int(FStatementHandle, DBXValue.ValueType.Ordinal);
    Value := ColValue <> 0;
    IsNull := False;
  end;
end;

procedure TDBXSqliteRow.GetByteLength(DbxValue: TDBXByteArrayValue; var ByteLength: Int64; var IsNull: LongBool);
var
  ColType, NumBytes: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, DBXValue.ValueType.Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_bytes16);
    NumBytes := sqlite3_column_bytes16(FStatementHandle, DBXValue.ValueType.Ordinal);
    ByteLength := NumBytes;
    IsNull := False;
  end;
end;

procedure TDBXSqliteRow.GetBytes(DbxValue: TDBXByteArrayValue; Offset: Int64; const Buffer: TArray<Byte>;
  BufferOffset, Length: Int64; var ReturnLength: Int64; var IsNull: LongBool);
var
  ColType, NumBytes: Integer;
  Blob: Pointer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, DBXValue.ValueType.Ordinal);
  if ColType = SQLITE_NULL then
  begin
    ReturnLength := 0;
    IsNull := True
  end
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_blob);
    Blob := sqlite3_column_blob(FStatementHandle, DBXValue.ValueType.Ordinal);
    FDBXContext.Trace(0, trace_sqlite3_column_bytes16);
    NumBytes := sqlite3_column_bytes16(FStatementHandle, DBXValue.ValueType.Ordinal);
    if NumBytes <= Length then
    begin
      Move(Blob^, Buffer[BufferOffset], NumBytes);
      ReturnLength := NumBytes;
    end
    else
    begin
      Move(Blob^, Buffer[BufferOffset], Length);
      ReturnLength := Length;
    end;
    IsNull := False;
  end;
end;

procedure TDBXSqliteRow.GetDate(DbxValue: TDBXDateValue; var Value: TDBXDate; var IsNull: LongBool);
begin
  inherited;
end;

procedure TDBXSqliteRow.GetDouble(DbxValue: TDBXDoubleValue; var Value: Double;
  var IsNull: LongBool);
var
  ColType: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, DBXValue.ValueType.Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_double);
    Value := sqlite3_column_double(FStatementHandle, DbxValue.ValueType.Ordinal);
    IsNull := False;
  end;
end;

procedure TDBXSqliteRow.GetInt8(DbxValue: TDBXInt8Value; var Value: ShortInt;
  var IsNull: LongBool);
var
  ColType: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, DBXValue.ValueType.Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_int);
    Value := sqlite3_column_int(FStatementHandle, DBXValue.ValueType.Ordinal);
    IsNull := False;
  end;
end;

procedure TDBXSqliteRow.GetInt16(DbxValue: TDBXInt16Value; var Value: SmallInt;
  var IsNull: LongBool);
var
  ColType: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, DBXValue.ValueType.Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_int);
    Value := sqlite3_column_int(FStatementHandle, DBXValue.ValueType.Ordinal);
    IsNull := False;
  end;
end;

procedure TDBXSqliteRow.GetInt32(DbxValue: TDBXInt32Value; var Value: TInt32;
  var IsNull: LongBool);
var
  ColType: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, DBXValue.ValueType.Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_int);
    Value := sqlite3_column_int(FStatementHandle, DBXValue.ValueType.Ordinal);
    IsNull := False;
  end;
end;

procedure TDBXSqliteRow.GetInt64(DbxValue: TDBXInt64Value; var Value: Int64;
  var IsNull: LongBool);
var
  ColType: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, DBXValue.ValueType.Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_int64);
    Value := sqlite3_column_int64(FStatementHandle, DBXValue.ValueType.Ordinal);
    IsNull := False;
  end;
end;

procedure TDBXSqliteRow.GetSingle(DbxValue: TDBXSingleValue; var Value: Single;
  var IsNull: LongBool);
var
  ColType: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, DBXValue.ValueType.Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_double);
    Value := sqlite3_column_double(FStatementHandle, DbxValue.ValueType.Ordinal);
    IsNull := False;
  end;
end;

procedure TDBXSqliteRow.GetTime(DbxValue: TDBXTimeValue; var Value: TDBXTime; var IsNull: LongBool);
begin
  inherited;
end;

procedure TDBXSqliteRow.GetTimeStamp(DbxValue: TDBXTimeStampValue; var Value: TSQLTimeStamp; var IsNull: LongBool);
begin
  inherited;
end;

procedure TDBXSqliteRow.GetTimeStampOffset(DbxValue: TDBXTimeStampOffsetValue; var Value: TSQLTimeStampOffset;
  var IsNull: LongBool);
begin
  inherited;
end;

procedure TDBXSqliteRow.GetUInt8(DbxValue: TDBXUInt8Value; var Value: Byte;
  var IsNull: LongBool);
var
  ColType: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, DBXValue.ValueType.Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_int);
    Value := sqlite3_column_int(FStatementHandle, DBXValue.ValueType.Ordinal);
    IsNull := False;
  end;
end;

procedure TDBXSqliteRow.GetUInt16(DbxValue: TDBXUInt16Value; var Value: Word;
  var IsNull: LongBool);
var
  ColType: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, DBXValue.ValueType.Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_int);
    Value := sqlite3_column_int(FStatementHandle, DBXValue.ValueType.Ordinal);
    IsNull := False;
  end;
end;

procedure TDBXSqliteRow.GetWideString(DbxValue: TDBXWideStringValue;
  var WideStringBuilder: TDBXWideStringBuilder; var IsNull: LongBool);
var
  Str: string;
  ColType, StrLen: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, DBXValue.ValueType.Ordinal);
  FDBXContext.Trace(0, trace_sqlite3_column_text16);
  Str := sqlite3_column_text16(FStatementHandle, DBXValue.ValueType.Ordinal);
  StrLen := Str.Length+1;
  if StrLen > 1 then
  begin
    TDBXPlatform.ResizeWideStringBuilder(WideStringBuilder, StrLen * SizeOf(Char));
    TDBXPlatform.CopyWideStringToBuilder(Str, StrLen * SizeOf(Char), WideStringBuilder);
    IsNull := False;
  end
  else
  begin
    if ColType = SQLITE_NULL then
      IsNull := True
    else
    begin
      TDBXPlatform.ResizeWideStringBuilder(WideStringBuilder, StrLen * SizeOf(Char));
      WideStringBuilder[0] := #0;
      IsNull := False;
    end;
  end;
end;

{$IFNDEF NEXTGEN}
procedure TDBXSqliteRow.SetAnsiString(DbxValue: TDBXAnsiStringValue; const Value: AnsiString);
begin
  SetString(DbxValue, Value);
end;
{$ENDIF !NEXTGEN}

procedure TDBXSqliteRow.SetBoolean(DbxValue: TDBXBooleanValue; Value: Boolean);
var
  ErrorCode: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_bind_int);
  ErrorCode := sqlite3_bind_int(FStatementHandle, DbxValue.ValueType.Ordinal+1, Integer(Value));
  CheckError(ErrorCode, FSqliteConnection.FConnectionHandle, FDBXContext);
end;

procedure TDBXSqliteRow.SetDouble(DbxValue: TDBXDoubleValue; Value: Double);
var
  ErrorCode: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_bind_double);
  ErrorCode := sqlite3_bind_double(FStatementHandle, DbxValue.ValueType.Ordinal+1, Value);
  CheckError(ErrorCode, FSqliteConnection.FConnectionHandle, FDBXContext);
end;

procedure TDBXSqliteRow.SetDynamicBytes(DbxValue: TDBXValue; Offset: Int64; const Buffer: TArray<Byte>;
  BufferOffset: Int64; Length: Int64);
var
  ErrorCode: Integer;
  M: TMarshaller;
begin
  if DBXValue.ValueType.SubType = TDBXSubDataTypes.MemoSubType then
  begin
    FDBXContext.Trace(0, trace_sqlite3_bind_text);
    ErrorCode := sqlite3_bind_text(FStatementHandle, DbxValue.ValueType.Ordinal+1,
                                   M.AsAnsi(TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(Buffer))).ToPointer,
                                   System.Length(Buffer), TBindDestructor(SQLITE_STATIC));
    CheckError(ErrorCode, FSqliteConnection.FConnectionHandle, FDBXContext);
  end
  else if DBXValue.ValueType.SubType = TDBXSubDataTypes.WideMemoSubType then
  begin
    FDBXContext.Trace(0, trace_sqlite3_bind_text16);
    ErrorCode := sqlite3_bind_text16(FStatementHandle, DbxValue.ValueType.Ordinal+1,
                                     @Buffer[0], System.Length(Buffer), TBindDestructor(SQLITE_STATIC));
    CheckError(ErrorCode, FSqliteConnection.FConnectionHandle, FDBXContext);
  end
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_bind_blob);
    ErrorCode := sqlite3_bind_blob(FStatementHandle, DBXValue.ValueType.Ordinal+1,
                                   @Buffer[BufferOffset], Length, TBindDestructor(SQLITE_STATIC));
    CheckError(ErrorCode, FSqliteConnection.FConnectionHandle, FDBXContext);
  end;
end;

procedure TDBXSqliteRow.SetInt8(DbxValue: TDBXInt8Value; Value: ShortInt);
var
  ErrorCode: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_bind_int);
  ErrorCode := sqlite3_bind_int(FStatementHandle, DbxValue.ValueType.Ordinal+1, Value);
  CheckError(ErrorCode, FSqliteConnection.FConnectionHandle, FDBXContext);
end;

procedure TDBXSqliteRow.SetInt16(DbxValue: TDBXInt16Value; Value: SmallInt);
var
  ErrorCode: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_bind_int);
  ErrorCode := sqlite3_bind_int(FStatementHandle, DbxValue.ValueType.Ordinal+1, Value);
  CheckError(ErrorCode, FSqliteConnection.FConnectionHandle, FDBXContext);
end;

procedure TDBXSqliteRow.SetInt32(DbxValue: TDBXInt32Value; Value: TInt32);
var
  ErrorCode: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_bind_int);
  ErrorCode := sqlite3_bind_int(FStatementHandle, DbxValue.ValueType.Ordinal+1, Value);
  CheckError(ErrorCode, FSqliteConnection.FConnectionHandle, FDBXContext);
end;

procedure TDBXSqliteRow.SetInt64(DbxValue: TDBXInt64Value; Value: Int64);
var
  ErrorCode: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_bind_int64);
  ErrorCode := sqlite3_bind_int64(FStatementHandle, DbxValue.ValueType.Ordinal+1, Value);
  CheckError(ErrorCode, FSqliteConnection.FConnectionHandle, FDBXContext);
end;

procedure TDBXSqliteRow.SetNull(DbxValue: TDBXValue);
var
  ErrorCode: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_bind_null);
  ErrorCode := sqlite3_bind_null(FStatementHandle, DbxValue.ValueType.Ordinal+1);
  CheckError(ErrorCode, FSqliteConnection.FConnectionHandle, FDBXContext);
end;

procedure TDBXSqliteRow.SetSingle(DbxValue: TDBXSingleValue; Value: Single);
var
  ErrorCode: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_bind_double);
  ErrorCode := sqlite3_bind_double(FStatementHandle, DbxValue.ValueType.Ordinal+1, Value);
  CheckError(ErrorCode, FSqliteConnection.FConnectionHandle, FDBXContext);
end;

{$IFNDEF NEXTGEN}
procedure TDBXSqliteRow.SetString(DbxValue: TDBXAnsiStringValue; const Value: AnsiString);
var
  ErrorCode: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_bind_text);
  ErrorCode := sqlite3_bind_text(FStatementHandle, DbxValue.ValueType.Ordinal+1,
                                 MarshaledAString(Value), Length(Value), TBindDestructor(SQLITE_STATIC));
  CheckError(ErrorCode, FSqliteConnection.FConnectionHandle, FDBXContext);
end;
{$ELSE}
procedure TDBXSqliteRow.SetString(DbxValue: TDBXAnsiStringValue; const Value: string);
var
  ErrorCode: Integer;
  M: TMarshaller;
begin
  FDBXContext.Trace(0, trace_sqlite3_bind_text);
  ErrorCode := sqlite3_bind_text(FStatementHandle, DbxValue.ValueType.Ordinal+1,
                                 M.AsUTF8(Value).ToPointer, Value.Length, TBindDestructor(SQLITE_STATIC));
  CheckError(ErrorCode, FSqliteConnection.FConnectionHandle, FDBXContext);
end;
{$ENDIF !NEXTGEN}

procedure TDBXSqliteRow.SetUInt8(DbxValue: TDBXUInt8Value; Value: Byte);
var
  ErrorCode: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_bind_int);
  ErrorCode := sqlite3_bind_int(FStatementHandle, DbxValue.ValueType.Ordinal+1, Value);
  CheckError(ErrorCode, FSqliteConnection.FConnectionHandle, FDBXContext);
end;

procedure TDBXSqliteRow.SetUInt16(DbxValue: TDBXUInt16Value; Value: Word);
var
  ErrorCode: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_bind_int);
  ErrorCode := sqlite3_bind_int(FStatementHandle, DbxValue.ValueType.Ordinal+1, Value);
  CheckError(ErrorCode, FSqliteConnection.FConnectionHandle, FDBXContext);
end;

procedure TDBXSqliteRow.SetValueType(ValueType: TDBXValueType);
begin
end;

procedure TDBXSqliteRow.SetWideString(DbxValue: TDBXWideStringValue; const Value: string);
var
  ErrorCode: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_bind_text16);
  ErrorCode := sqlite3_bind_text16(FStatementHandle, DbxValue.ValueType.Ordinal+1,
                                   PChar(Value), Value.Length * SizeOf(Char), TBindDestructor(SQLITE_STATIC));
  CheckError(ErrorCode, FSqliteConnection.FConnectionHandle, FDBXContext);
end;

constructor TDBXSqliteRow.Create(DBXContext: TDBXContext; Connection: TDBXSqliteConnection; StatementHandle: Pointer);
begin
  inherited Create(DBXContext);
  FSqliteConnection := Connection;
  FStatementHandle := StatementHandle;
end;

{ TDBXSqliteByteReader }

constructor TDBXSqliteByteReader.Create(DBXContext: TDBXContext;
  Connection: TDBXSqliteConnection; StatementHandle: sqlite3_stmt);
begin
  inherited Create(DBXContext);
  FSqliteConnection := Connection;
  FStatementHandle := StatementHandle;
end;

{$IFNDEF NEXTGEN}
procedure TDBXSqliteByteReader.GetAnsiString(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ColType: Integer;
  Data: MarshaledAString;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_text);
    Data := sqlite3_column_text(FStatementHandle, Ordinal);
    //User can potentially declare a field as varchar(prec) but store values
    //longer than prec as Sqlite does not respect the restriction
    if (Length(Data)+1) <= Length(Value) then
      Move(Data^, Value[0], Length(Data)+1)
    else
      Move(Data^, Value[0], Length(Value));
    IsNull := False;
  end;
end;
{$ENDIF !NEXTGEN}

procedure TDBXSqliteByteReader.GetBcd(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
begin
  inherited;
end;

procedure TDBXSqliteByteReader.GetByteLength(Ordinal: TInt32; var Length: Int64; var IsNull: LongBool);
var
  ColType, NumBytes: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_bytes16);
    NumBytes := sqlite3_column_bytes16(FStatementHandle, Ordinal);
    Length := NumBytes;
    IsNull := False;
  end;
end;

function TDBXSqliteByteReader.GetBytes(Ordinal: TInt32; Offset: Int64; const Value: TArray<Byte>;
  ValueOffset, Length: Int64; var IsNull: LongBool): Int64;
var
  ColType, NumBytes: Integer;
  Blob: Pointer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, Ordinal);
  if ColType = SQLITE_NULL then
  begin
    Result := 0;
    IsNull := True
  end
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_blob);
    Blob := sqlite3_column_blob(FStatementHandle, Ordinal);
    FDBXContext.Trace(0, trace_sqlite3_column_bytes16);
    NumBytes := sqlite3_column_bytes16(FStatementHandle, Ordinal);
    if NumBytes <= Length then
    begin
      Move(Blob^, Value[ValueOffset], NumBytes);
      Result := NumBytes;
    end
    else
    begin
      Move(Blob^, Value[ValueOffset], Length);
      Result := Length;
    end;
    IsNull := False;
  end;
end;

procedure TDBXSqliteByteReader.GetDate(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
begin
  inherited;
end;

procedure TDBXSqliteByteReader.GetDouble(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ColType: Integer;
  Data: Double;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_double);
    Data := sqlite3_column_double(FStatementHandle, Ordinal);
    TDBXPlatform.CopyInt64(TDBXPlatform.DoubleToInt64Bits(Data), Value, Offset);
    IsNull := False;
  end;
end;

procedure TDBXSqliteByteReader.GetInt8(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ColType: Integer;
  Data: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_int);
    Data := sqlite3_column_int(FStatementHandle, Ordinal);
    TDBXPlatform.CopyInt8(Data, Value, Offset);
    IsNull := False;
  end;
end;

procedure TDBXSqliteByteReader.GetInt16(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ColType: Integer;
  Data: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_int);
    Data := sqlite3_column_int(FStatementHandle, Ordinal);
    TDBXPlatform.CopyInt16(Data, Value, Offset);
    IsNull := False;
  end;
end;

procedure TDBXSqliteByteReader.GetInt32(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ColType: Integer;
  Data: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_int);
    Data := sqlite3_column_int(FStatementHandle, Ordinal);
    TDBXPlatform.CopyInt32(Data, Value, Offset);
    IsNull := False;
  end;
end;

procedure TDBXSqliteByteReader.GetInt64(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ColType: Integer;
  Data: Int64;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_int64);
    Data := sqlite3_column_int64(FStatementHandle, Ordinal);
    TDBXPlatform.CopyInt64(Data, Value, Offset);
    IsNull := False;
  end;
end;

procedure TDBXSqliteByteReader.GetSingle(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ColType: Integer;
  Data: Double;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_double);
    Data := sqlite3_column_double(FStatementHandle, Ordinal);
    TDBXPlatform.CopyInt32(TDBXPlatform.SingleToInt32Bits(Data), Value, Offset);
    IsNull := False;
  end;
end;

procedure TDBXSqliteByteReader.GetTime(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
begin
  inherited;
end;

procedure TDBXSqliteByteReader.GetTimeStamp(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
begin
  inherited;
end;

procedure TDBXSqliteByteReader.GetTimeStampOffset(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
begin
  inherited;
end;

procedure TDBXSqliteByteReader.GetUInt8(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ColType: Integer;
  Data: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_int);
    Data := sqlite3_column_int(FStatementHandle, Ordinal);
    TDBXPlatform.CopyUInt8(Data, Value, Offset);
    IsNull := False;
  end;
end;

procedure TDBXSqliteByteReader.GetUInt16(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ColType: Integer;
  Data: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_int);
    Data := sqlite3_column_int(FStatementHandle, Ordinal);
    TDBXPlatform.CopyUInt16(Data, Value, Offset);
    IsNull := False;
  end;
end;

procedure TDBXSqliteByteReader.GetWideString(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ColType: Integer;
  Data: MarshaledString;
begin
  FDBXContext.Trace(0, trace_sqlite3_column_type);
  ColType := sqlite3_column_type(FStatementHandle, Ordinal);
  if ColType = SQLITE_NULL then
    IsNull := True
  else
  begin
    FDBXContext.Trace(0, trace_sqlite3_column_text16);
    Data := sqlite3_column_text16(FStatementHandle, Ordinal);
    //User can potentially declare a field as varchar(prec) but store values
    //longer than prec as Sqlite does not respect the restriction
    if ((Length(Data)+1)*SizeOf(Char)) <= Length(Value) then
      Move(Data^, Value[0], (Length(Data)+1)*SizeOf(Char))
    else
      Move(Data^, Value[0], Length(Value));
    IsNull := False;
  end;
end;

{ TDBXSqliteReader }

constructor TDBXSqliteReader.Create(DBXContext: TDBXContext;
  Connection: TDBXSqliteConnection; StatementHandle: sqlite3_stmt;
  ByteReader: TDBXSqliteByteReader; NumCols: Integer);

  procedure SetupTypeInfo(Column: TDBXValueType; DataType: Integer);
  begin
    case DataType of
      SQLITE_INTEGER:
      begin
        Column.DataType := TDBXDataTypes.Int64Type;
        Column.Size := SizeOf(Int64);
      end;
      SQLITE_FLOAT:
      begin
        Column.DataType := TDBXDataTypes.DoubleType;
        Column.Size := SizeOf(Double);
      end;
      SQLITE_BLOB:
      begin
        Column.DataType := TDBXDataTypes.BlobType;
        Column.SubType := TDBXSubDataTypes.BinarySubType;
        Column.Precision := 1;
      end;
      SQLITE_TEXT, SQLITE_NULL:
      begin
        Column.DataType := TDBXDataTypes.BlobType;
        Column.SubType := TDBXDataTypes.WideMemoSubType;
        Column.Precision := 1;
        Column.Size := 1;
      end;
    else
      DBXContext.Error(1, Format(STypeNotSupported, [IntToStr(DataType)]));
    end;
  end;

  procedure SetupTextInfo(Column: TDBXValueType; DataType: string);
  var
    Pos1, Pos2, Precision: Integer;
  begin
    Pos1 := DataType.IndexOf('(');
    if Pos1 > -1 then
    begin
      Pos2 := DataType.IndexOf(')');
      Precision := StrToInt(DataType.Substring(Pos1+1, Pos2-Pos1-1));
      Column.DataType := TDBXDataTypes.WideStringType;
      Column.Precision := Precision;
      Column.Size := Precision;
    end
    else
    begin
      Column.DataType := TDBXDataTypes.BlobType;
      Column.SubType := TDBXDataTypes.WideMemoSubType;
      Column.Precision := 1;
      Column.Size := 1;
    end
  end;
var
  Values: TDBXWritableValueArray;
  ColType, I: Integer;
  Column: TDBXValueType;
  DataTypePtrUni: MarshaledString;
{$IF not (DEFINED(CPUARM) and DEFINED(IOS))}
  Autoinc, ErrorCode, NotNull, PrimaryKey: Integer;
  ColumnName, DbName, TableName: string;
  CollationSeqPtr, DataTypePtr: MarshaledAString;
{$ENDIF not (CPUARM and IOS)}
begin
  inherited Create(DBXContext, TDBXSqliteRow.Create(DBXContext, Connection, StatementHandle), ByteReader);
  FSqliteConnection := Connection;
  FStatementHandle := StatementHandle;
  SetLength(Values, NumCols);
  for I := 0 to High(Values) do
  begin
    Column := TDBXDriverHelp.CreateTDBXValueType(DBXContext);
    Column.Ordinal := I;
{$IF not (DEFINED(CPUARM) and DEFINED(IOS))}
    if Connection.GetVendorProperty('ColumnMetaDataSupported') = 'True' then
    begin
      FDBXContext.Trace(0, trace_sqlite3_column_origin_name16);
      ColumnName := sqlite3_column_origin_name16(StatementHandle, I);
      if ColumnName <> '' then
      begin
        FDBXContext.Trace(0, trace_sqlite3_column_database_name16);
        DbName := sqlite3_column_database_name16(StatementHandle, I);
        FDBXContext.Trace(0, trace_sqlite3_column_table_name16);
        TableName := sqlite3_column_table_name16(StatementHandle, I);
        FDBXContext.Trace(0, trace_sqlite3_column_type);
        ColType := sqlite3_column_type(StatementHandle, I);
        FDBXContext.Trace(0, trace_sqlite3_table_column_metadata);
        ErrorCode := sqlite3_table_column_metadata(Connection.ConnectionHandle, MarshaledAString(Utf8Encode(DbName)),
                                                   MarshaledAString(Utf8Encode(TableName)), MarshaledAString(Utf8Encode(ColumnName)),
                                                   DataTypePtr, CollationSeqPtr,
                                                   NotNull, PrimaryKey, Autoinc);
        CheckError(ErrorCode, Connection.FConnectionHandle, DBXContext);
        if (NotNull = 0) and (PrimaryKey = 0) then
          Column.ValueTypeFlags := Column.ValueTypeFlags or TDBXValueTypeFlags.Nullable;
        if Autoinc = 1 then
          Column.ValueTypeFlags := Column.ValueTypeFlags or TDBXValueTypeFlags.AutoIncrement;
        if ColType = SQLITE_TEXT then
          SetupTextInfo(Column, TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(DataTypePtr)))
        else
          SetupTypeInfo(Column, ColType);
      end
      else
      begin
        ColumnName := 'Column' + IntToStr(I);
        SetupTypeInfo(Column, SQLITE_NULL);
      end;
      Column.Name := ColumnName;
    end
    else
{$ENDIF not (CPUARM and IOS)}
    begin
      Column.ValueTypeFlags := Column.ValueTypeFlags or TDBXValueTypeFlags.Nullable;
      Column.Name := sqlite3_column_name16(StatementHandle, I);
      FDBXContext.Trace(0, trace_sqlite3_column_type);
      ColType := sqlite3_column_type(StatementHandle, I);
      if ColType = SQLITE_TEXT then
      begin
        FDBXContext.Trace(0, trace_sqlite3_column_decltype16);
        DataTypePtrUni := sqlite3_column_decltype16(StatementHandle, I);
        SetupTextInfo(Column, TMarshal.ReadStringAsUnicode(TPtrWrapper.Create(DataTypePtrUni)));
      end
      else
        SetupTypeInfo(Column, ColType);
    end;
    Values[I] := TDBXValue.CreateValue(FDBXContext, Column, FDbxRow, true);
  end;
  SetValues(Values);
end;

procedure TDBXSqliteReader.DerivedClose;
var
  ErrorCode: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_reset);
  ErrorCode := sqlite3_reset(FStatementHandle);
  CheckError(ErrorCode, FSqliteConnection.ConnectionHandle, FDBXContext);
end;

function TDBXSqliteReader.DerivedNext: Boolean;
var
  ErrorCode: Integer;
begin
  FDBXContext.Trace(0, trace_sqlite3_step);
  ErrorCode := sqlite3_step(FStatementHandle);
  CheckError(ErrorCode, FSqliteConnection.ConnectionHandle, FDBXContext);
  if ErrorCode = SQLITE_ROW then
    Result := True
  else
    Result := False;
end;

{ TDBXSqliteTransaction }

constructor TDBXSqliteTransaction.Create(Connection: TDBXConnection;
  TransactionId: Integer);
begin
  inherited Create(Connection);
  FId := TransactionId;
end;

initialization
  TDBXDriverRegistry.RegisterDriverClass(sDriverName, TDBXSqliteDriver);
end.
