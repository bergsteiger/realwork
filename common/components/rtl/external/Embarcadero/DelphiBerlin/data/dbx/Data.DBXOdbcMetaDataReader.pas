{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.DBXOdbcMetaDataReader;

interface

uses
  System.Classes,
  Data.DBXCommon,
  Data.DBXCommonTable,
  Data.DBXMetaDataNames,
  Data.DBXMetaDataReader,
  Data.DBXOdbc,
  Data.DBXPlatform,
  System.SysUtils;

type
  /// <summary>  TDBXOdbcCustomMetaDataReader contains custom code for Odbc.
  /// </summary>
  /// <remarks>  This class handles data types and type mapping for table columns and
  ///   procedure parameters.
  /// </remarks>
  TDBXOdbcCustomMetaDataReader = class(TDBXBaseMetaDataReader)
  private
    FAlltypes: TDBXDataTypeDescriptionArray;
  public
    destructor Destroy; override;
  end;

  TDBXOdbcMetaDataReader = class(TDBXOdbcCustomMetaDataReader)
  private
    FConnectionHandle: OdbcHandle;
    FOdbcConnection: TDBXOdbcConnection;
    FDataTypeDescriptions: TDBXDataTypeDescriptionArray;
    FIndexKeyword: Word;
    //Value of 0 indicates no limit or unknown
    FMaxConcurrentActivities: Word;
    FReservedWords: TStrings;
    FCatalogsSupported: Boolean;
    FSchemasSupported: Boolean;
    FSupportsMultipleTransactions: Boolean;
    FSqlIdentifierQuoteChar: string;
    FSqlIdentifierCase: Word;
    FSupportsParameterMetaData: Boolean;
    FTransactionCapable: Word;
    FInitialized: Boolean;

    procedure CheckInitialized;
    procedure CheckResult(ReturnValue: SmallInt);
    procedure Init;
    procedure SetDataTypeDescriptions;
    procedure SetReservedWords(Buffer: TArray<Byte>);
    function SqlTablesInvocation(CommandText, Catalog, Schema, TableName, TableType: string): TDBXTable;
  protected
    function AreCatalogFunctionsSupported: Boolean; override;
    function AreCatalogsSupported: Boolean; override;
    function AreSchemasSupported: Boolean; override;
    function GetDataTypeDescriptions: TDBXDataTypeDescriptionArray; override;
    function GetProductName: string; override;
    function GetReservedWords: TDBXStringArray; override;
    function GetSqlIdentifierQuoteChar: string; override;
    function GetSqlIdentifierQuotePrefix: string; override;
    function GetSqlIdentifierQuoteSuffix: string; override;
    function GetSqlProcedureQuoteChar: string; override;
    function IsDescendingIndexSupported: Boolean; override;
    function IsLowerCaseIdentifiersSupported: Boolean; override;
    function IsMultipleCommandsSupported: Boolean; override;
    function IsNestedTransactionsSupported: Boolean; override;
    function IsParameterMetadataSupported: Boolean; override;
    function IsQuotedIdentifiersSupported: Boolean; override;
    function IsSetRowSizeSupported: Boolean; override;
    function IsTransactionsSupported: Boolean; override;
    function IsUpperCaseIdentifiersSupported: Boolean; override;
    procedure PopulateDataTypes(const Hash: TDBXObjectStore; const Types: TDBXArrayList; const Descr: TDBXDataTypeDescriptionArray); override;
  public
    constructor Create; overload;
    constructor Create(OdbcConnection: TDBXOdbcConnection); overload;
    destructor Destroy; override;
    function FetchCatalogs: TDBXTable; override;
    function FetchColumns(const Catalog: string; const Schema: string; const Table: string): TDBXTable; override;
    function FetchForeignKeyColumns(const Catalog: string; const Schema: string; const Table: string; const ForeignKeyName: string; const PrimaryCatalog: string; const PrimarySchema: string; const PrimaryTable: string; const PrimaryKeyName: string): TDBXTable; override;
    function FetchForeignKeys(const Catalog: string; const Schema: string; const Table: string): TDBXTable; override;
    function FetchIndexColumns(const Catalog: string; const Schema: string; const Table: string; const Index: string): TDBXTable; override;
    function FetchIndexes(const Catalog: string; const Schema: string; const Table: string): TDBXTable; override;
    function FetchPackageProcedureParameters(const Catalog: string; const Schema: string; const PackageName: string; const ProcedureName: string; const ParameterName: string): TDBXTable; override;
    function FetchPackageProcedures(const Catalog: string; const Schema: string; const PackageName: string; const ProcedureName: string; const ProcedureType: string): TDBXTable; override;
    function FetchPackages(const Catalog: string; const Schema: string; const PackageName: string): TDBXTable; override;
    function FetchPackageSources(const Catalog: string; const Schema: string; const PackageName: string): TDBXTable; override;
    function FetchProcedures(const Catalog: string; const Schema: string; const ProcedureName: string; const ProcedureType: string): TDBXTable; override;
    function FetchProcedureParameters(const Catalog: string; const Schema: string; const Proc: string; const Parameter: string): TDBXTable; override;
    function FetchProcedureSources(const Catalog: string; const Schema: string; const Proc: string): TDBXTable; override;
    function FetchRoles: TDBXTable; override;
    function FetchSchemas(const Catalog: string): TDBXTable; override;
    function FetchSynonyms(const Catalog: string; const Schema: string; const Synonym: string): TDBXTable; override;
    function FetchTables(const Catalog: string; const Schema: string; const TableName: string; const TableType: string): TDBXTable; override;
    function FetchUsers: TDBXTable; override;
    function FetchViews(const Catalog: string; const Schema: string; const View: string): TDBXTable; override;
  end;

  TDBXOdbcColumnsTableCursor = class(TDBXColumnsTableCursor)
  private
    FDataTypesRow: TDBXSingleValueRow;
  protected
    function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
  public
    constructor Create(const Reader: TDBXBaseMetaDataReader; const CheckBase: Boolean; const Cursor: TDBXTable);
    destructor Destroy; override;
    function Next: Boolean; override;
  end;

  TDBXOdbcProcedureParametersIndex = class
  public
    const CatalogName = 0;
    const SchemaName = 1;
    const TableName = 2;
    const ColumnName = 3;
    const Mode = 4;
    const SqlDataType = 5;
    const TypeName = 6;
    const ColumnSize = 7;
    const BufferLength = 8;
    const Scale = 9;
    const NumPrecRadix = 10;
    const IsNullable = 11;
    const Remarks = 12;
    const ColumnDef = 13;
    const DescSqlDataType = 14;
    const SqlDatetimeSub = 15;
    const CharOctetLength = 16;
    const Ordinal = 17;
    const IsNullableChar = 18;
    const DbxDataType = 19;
    const ParameterMode = 20;
    const IsFixedLength = 21;
    const Last = 21;
  end;

  TDBXOdbcColumnsIndex = class
  public
    const CatalogName = 0;
    const SchemaName = 1;
    const TableName = 2;
    const ColumnName = 3;
    const SqlDataType = 4;
    const TypeName = 5;
    const ColumnSize = 6;
    const BufferLength = 7;
    const Scale = 8;
    const NumPrecRadix = 9;
    const IsNullable = 10;
    const Remarks = 11;
    const ColumnDef = 12;
    const DescSqlDataType = 13;
    const SqlDatetimeSub = 14;
    const CharOctetLength = 15;
    const Ordinal = 16;
    const IsNullableChar = 17;
    const Last = 17;
  end;

implementation

uses
  Data.DBXCommonResStrs, Data.DBXMetaDataCommandFactory, System.Odbc;

destructor TDBXOdbcCustomMetaDataReader.Destroy;
begin
  FreeObjectArray(TDBXFreeArray(FAlltypes));
  inherited Destroy;
end;

procedure TDBXOdbcMetaDataReader.CheckInitialized;
begin
  if not FInitialized then
    Init;
end;

procedure TDBXOdbcMetaDataReader.CheckResult(ReturnValue: SmallInt);
var
  Context: TDBXContext;
begin
  if (ReturnValue <> SQL_SUCCESS) and (ReturnValue <> SQL_SUCCESS_WITH_INFO) then
  begin
    Context := TDBXContext.Create;
    try
      OdbcRaiseError(Context, ReturnValue, SQL_HANDLE_DBC, FConnectionHandle);
    finally
      Context.Free;
    end;
  end;
end;

procedure TDBXOdbcMetaDataReader.Init;
var
  ErrorCode, ReturnLength: SmallInt;
  Buffer: TArray<Byte>;
begin
  if not Assigned(FOdbcConnection) then
  begin
    FOdbcConnection := TDBXOdbcConnection(TDBXDataExpressProviderContext(Self.Context).Connection);
    FConnectionHandle := FOdbcConnection.ConnectionHandle;
  end;
  //(Character + null) * SizeOf(Char)
  SetLength(Buffer, 4);
  ErrorCode := SQLGetInfo(FConnectionHandle, SQL_IDENTIFIER_QUOTE_CHAR,
                          SQLPOINTER(@Buffer[0]), Length(Buffer), ReturnLength);
  CheckResult(ErrorCode);
  FSqlIdentifierQuoteChar := TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(Buffer)).Trim;
  ErrorCode := SQLGetInfo(FConnectionHandle, SQL_DESCRIBE_PARAMETER,
                          SQLPOINTER(@Buffer[0]), Length(Buffer), ReturnLength);
  CheckResult(ErrorCode);
  if PChar(@Buffer[0])^ = 'Y' then
    FSupportsParameterMetaData := True
  else
    FSupportsParameterMetaData := False;

  ErrorCode := SQLGetInfo(FConnectionHandle, SQL_MULTIPLE_ACTIVE_TXN,
                          SQLPOINTER(@Buffer[0]), Length(Buffer), ReturnLength);
  CheckResult(ErrorCode);
  if PChar(@Buffer[0])^ = 'Y' then
    FSupportsMultipleTransactions := True
  else
    FSupportsMultipleTransactions := False;

  ErrorCode := SQLGetInfo(FConnectionHandle, SQL_CATALOG_NAME,
                          SQLPOINTER(@Buffer[0]), Length(Buffer), ReturnLength);
  CheckResult(ErrorCode);
  if PChar(@Buffer[0])^ = 'Y' then
    FCatalogsSupported := True
  else
    FCatalogsSupported := False;

  ErrorCode := SQLGetInfo(FConnectionHandle, SQL_INDEX_KEYWORDS,
                          SQLPOINTER(@Buffer[0]), Length(Buffer), ReturnLength);
  CheckResult(ErrorCode);
  FIndexKeyword := PWord(@Buffer[0])^;

  ErrorCode := SQLGetInfo(FConnectionHandle, SQL_CREATE_SCHEMA,
                          SQLPOINTER(@Buffer[0]), Length(Buffer), ReturnLength);
  CheckResult(ErrorCode);

  if (PInteger(@Buffer[0])^ and SQL_CS_CREATE_SCHEMA) = SQL_CS_CREATE_SCHEMA then
    FSchemasSupported := True
  else
    FSchemasSupported := False;

  SetLength(Buffer, SizeOf(Word));
  ErrorCode := SQLGetInfo(FConnectionHandle, SQL_IDENTIFIER_CASE,
                          SQLPOINTER(@Buffer[0]), Length(Buffer), ReturnLength);
  CheckResult(ErrorCode);
  FSqlIdentifierCase := PWord(@Buffer[0])^;

  ErrorCode := SQLGetInfo(FConnectionHandle, SQL_MAX_CONCURRENT_ACTIVITIES,
                          SQLPOINTER(@Buffer[0]), Length(Buffer), ReturnLength);
  CheckResult(ErrorCode);
  FMaxConcurrentActivities := PWord(@Buffer[0])^;
  ErrorCode := SQLGetInfo(FConnectionHandle, SQL_TXN_CAPABLE,
                          SQLPOINTER(@Buffer[0]), Length(Buffer), ReturnLength);
  CheckResult(ErrorCode);
  FTransactionCapable := PWord(@Buffer[0])^;

  ErrorCode := SQLGetInfo(FConnectionHandle, SQL_KEYWORDS,
                          SQLPOINTER(@Buffer[0]), 2, ReturnLength);
  CheckResult(ErrorCode);
  SetLength(Buffer, (ReturnLength+1)*SizeOf(Char));
  ErrorCode := SQLGetInfo(FConnectionHandle, SQL_KEYWORDS,
                          SQLPOINTER(@Buffer[0]), Length(Buffer), ReturnLength);
  CheckResult(ErrorCode);
  SetReservedWords(Buffer);

  SetDataTypeDescriptions;
  FInitialized := True;
end;

procedure TDBXOdbcMetaDataReader.SetDataTypeDescriptions;
  function GetDbxDataType(SQLDataType: SmallInt; var SubType: SmallInt): SmallInt;
  begin
    SubType := 0;
    case SQLDataType of
      SQL_CHAR:
        begin
          Result := TDBXDataTypes.AnsiStringType;
          SubType := TDBXSubDataTypes.FixedSubType;
        end;
      SQL_VARCHAR: Result := TDBXDataTypes.AnsiStringType;
      SQL_LONGVARCHAR:
        begin
          Result := TDBXDataTypes.BlobType;
          SubType := TDBXSubDataTypes.MemoSubType;
        end;
      SQL_WCHAR:
        begin
          Result := TDBXDataTypes.WideStringType;
          SubType := TDBXSubDataTypes.FixedSubType;
        end;
      SQL_WVARCHAR: Result := TDBXDataTypes.WideStringType;
      SQL_WLONGVARCHAR:
        begin
          Result := TDBXDataTypes.BlobType;
          SubType := TDBXSubDataTypes.WideMemoSubType;
        end;
      SQL_DECIMAL, SQL_NUMERIC: Result := TDBXDataTypes.BcdType;
      SQL_SMALLINT: Result := TDBXDataTypes.Int16Type;
      SQL_INTEGER: Result := TDBXDataTypes.Int32Type;
      SQL_REAL: Result := TDBXDataTypes.SingleType;
      SQL_DOUBLE, SQL_FLOAT: Result := TDBXDataTypes.DoubleType;
      SQL_BIT: Result := TDBXDataTypes.BooleanType;
      SQL_TINYINT: Result := TDBXDataTypes.Int8Type;
      SQL_BIGINT: Result := TDBXDataTypes.Int64Type;
      SQL_BINARY: Result := TDBXDataTypes.BytesType;
      SQL_VARBINARY: Result := TDBXDataTypes.VarBytesType;
      SQL_LONGVARBINARY:
        begin
          Result := TDBXDataTypes.BlobType;
          SubType := TDBXSubDataTypes.BinarySubType;
        end;
      SQL_TYPE_DATE: Result := TDBXDataTypes.DateType;
      SQL_TYPE_TIME: Result := TDBXDataTypes.TimeType;
      SQL_TYPE_TIMESTAMP: Result := TDBXDataTypes.TimeStampType;
      SQL_TYPE_NULL: Result := TDBXDataTypes.UnknownType;
      else //We will treat unknown data types as strings
        Result := TDBXDataTypes.AnsiStringType;
    end;
  end;

  function GetCreateParams(CreateParamsCol: string): string;
  begin
    Result := StringReplace(CreateParamsCol, 'max ', '', [rfReplaceAll, rfIgnoreCase]);
    Result := StringReplace(Result, 'max,', '', [rfReplaceAll, rfIgnoreCase]);
    Result := StringReplace(Result, 'length', 'Precision', [rfReplaceAll, rfIgnoreCase]);
  end;
const
  TYPE_NAME_COL = 0;
  DATA_TYPE_COL = 1;
  COLUMN_SIZE_COL = 2;
  LITERAL_PREFIX_COL = 3;
  LITERAL_SUFFIX_COL = 4;
  CREATE_PARAMS_COL = 5;
  NULLABLE_COL = 6;
  CASE_SENSITIVE_COL = 7;
  SEARCHABLE_COL = 8;
  UNSIGNED_ATTRIBUTE_COL = 9;
  FIXED_PREC_SCALE_COL = 10;
  AUTO_UNIQUE_VALUE_COL = 11;
  LOCAL_TYPE_NAME_COL = 12;
  MINIMUM_SCALE_COL = 13;
  MAXIMUM_SCALE_COL = 14;
  SQL_DATA_TYPE_COL = 15;
  SQL_DATETIME_SUB_COL = 16;
  NUM_PREC_RADIX_COL = 17;
  INTERVAL_PRECISION_COL = 18;
var
  Command: TDBXOdbcCommand;
  Reader: TDBXReader;
  ArrayLength, DataTypeCount: Integer;
  CreateFormat, CreateParams, LiteralPrefix, LiteralSuffix, MaxVersion, MinVersion, TypeName: string;
  DataType, Flags, MaxScale, MinScale: Integer;
  SubType: SmallInt;
  ColumnSize: Int64;
begin
  ArrayLength := 20;
  SetLength(FDataTypeDescriptions, ArrayLength);
  DataTypeCount := 0;
  Command := FOdbcConnection.CreateOdbcCommand;
  try
    Command.CommandType := TDBXCommandTypes.DbxMetaData;
    Command.Text := 'GetDataTypes';
    Command.RowSetSize := 1;
    Reader := Command.ExecuteQuery;
    try
      while Reader.Next do
      begin
        if DataTypeCount >= ArrayLength then
        begin
          ArrayLength := ArrayLength + 20;
          SetLength(FDataTypeDescriptions, ArrayLength);
        end;
        Flags := 0;
        TypeName := Reader.Value[TYPE_NAME_COL].AsString;
        DataType := GetDbxDataType(Reader.Value[DATA_TYPE_COL].AsInt32, SubType);
        if SubType = TDBXSubDataTypes.FixedSubType then
          Flags := Flags or TDBXTypeFlag.FixedLength;
        ColumnSize := Reader.Value[COLUMN_SIZE_COL].AsInt64;
        CreateFormat := TypeName;
        //We use the Precision column in the typed table storage for length
        CreateParams := GetCreateParams(Reader.Value[CREATE_PARAMS_COL].AsString);
        if CreateParams <> '' then
        begin
          CreateFormat := CreateFormat + '({0}';
          if CreateParams.IndexOf(',') <> -1 then
            CreateFormat := CreateFormat + ', {1}';
          CreateFormat := CreateFormat + ')';
        end;
        MaxScale := Reader.Value[MAXIMUM_SCALE_COL].AsInt32;
        //Some ODBC drivers do not return MaxScale and use the maximum precision instead
        if (MaxScale = 0) and (DataType = TDBXDataTypes.BcdType) then
          MaxScale := Reader.Value[COLUMN_SIZE_COL].AsInt32;
        MinScale := Reader.Value[MINIMUM_SCALE_COL].AsInt32;
        LiteralPrefix := Reader.Value[LITERAL_PREFIX_COL].AsString;
        LiteralSuffix := Reader.Value[LITERAL_SUFFIX_COL].AsString;
        MaxVersion := '';
        MinVersion := '';

        if Reader.Value[AUTO_UNIQUE_VALUE_COL].AsInt32 = SQL_TRUE then
          Flags := Flags or TDBXTypeFlag.AutoIncrementable;
        if Reader.Value[CASE_SENSITIVE_COL].AsInt32 = SQL_TRUE then
          Flags := Flags or TDBXTypeFlag.CaseSensitive;
        if Reader.Value[FIXED_PREC_SCALE_COL].AsInt32 = SQL_TRUE then
          Flags := Flags or TDBXTypeFlag.FixedPrecisionScale;
        if Reader.Value[NULLABLE_COL].AsInt32 = SQL_NULLABLE then
          Flags := Flags or TDBXTypeFlag.Nullable;
        if (Reader.Value[SEARCHABLE_COL].AsInt32 = SQL_PRED_BASIC) or (Reader.Value[SEARCHABLE_COL].AsInt32 = SQL_SEARCHABLE) then
          Flags := Flags or TDBXTypeFlag.Searchable;
        if (Reader.Value[SEARCHABLE_COL].AsInt32 = SQL_PRED_CHAR) or (Reader.Value[SEARCHABLE_COL].AsInt32 = SQL_SEARCHABLE) then
          Flags := Flags or TDBXTypeFlag.SearchableWithLike;
        if Reader.Value[UNSIGNED_ATTRIBUTE_COL].AsInt32 = SQL_TRUE then
          Flags := Flags or TDBXTypeFlag.Unsigned;
        if (DataType = TDBXDataTypes.WideStringType) or ((DataType = TDBXDataTypes.BlobType) and (SubType = TDBXSubDataTypes.WideMemoSubType)) then
          Flags := Flags or TDBXTypeFlag.Unicode;
        if DataType = TDBXDataTypes.BlobType then
          Flags := Flags or TDBXTypeFlag.Long;

        FDataTypeDescriptions[DataTypeCount] := TDBXDataTypeDescription.Create(TypeName, DataType, ColumnSize, CreateFormat, CreateParams, MaxScale, MinScale, LiteralPrefix, LiteralSuffix, MaxVersion, MinVersion, Flags);
        Inc(DataTypeCount);
      end;
      SetLength(FDataTypeDescriptions, DataTypeCount);
    finally
      Reader.Free;
    end;
  finally
    Command.Free
  end;
end;

procedure TDBXOdbcMetaDataReader.SetReservedWords(Buffer: TArray<Byte>);
var
  TempStr: string;
begin
  TempStr := TMarshal.ReadStringAsUnicode(TPtrWrapper.Create(Buffer)).Trim;
  FReservedWords := TStringList.Create;
  FReservedWords.Delimiter := ',';
  FReservedWords.DelimitedText := TempStr;
  //Some ODBC drivers do not return a list of reserved words so at least return the
  //words that are reserved for use in ODBC function calls.
  if FReservedWords.DelimitedText.Length = 0 then
    FReservedWords.DelimitedText := SQL_ODBC_KEYWORDS;
end;

function TDBXOdbcMetaDataReader.SqlTablesInvocation(CommandText, Catalog, Schema, TableName, TableType: string): TDBXTable;
  function GetMetaDataCollectionName(CommandText: string): string;
  begin
    if CommandText = 'GetCatalogs' then
      Result := TDBXMetaDataCollectionName.Catalogs
    else if CommandText = 'GetSchemas' then
      Result := TDBXMetaDataCollectionName.Schemas
    else if CommandText = 'GetSynonyms' then
      Result := TDBXMetaDataCollectionName.Synonyms
    else if CommandText = 'GetTables' then
      Result := TDBXMetaDataCollectionName.Tables
    else if CommandText = 'GetViews' then
      Result := TDBXMetaDataCollectionName.Views;
  end;
var
  Command: TDBXOdbcCommand;
  Reader: TDBXReader;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
  TableNameParam: TDBXParameter;
begin
  CheckInitialized;
  Command := FOdbcConnection.CreateOdbcCommand;
  try
    Command.CommandType := TDBXCommandTypes.DbxMetaData;
    if TableType = 'VIEW' then
      Command.Text := 'GetViews'
    else
      Command.Text := CommandText;
    Command.RowSetSize := 1;
    TableNameParam := Command.CreateParameter;
    TableNameParam.DataType := TDBXDataTypes.WideStringType;
    Command.Parameters.AddParameter(TableNameParam);
    Command.Parameters[0].Value.SetWideString(TableName);
    Reader := Command.ExecuteQuery;
    if Reader = nil then
      Result := nil
    else
    begin
      Cursor := TDBXStringTrimTable.CreateTrimTableIfNeeded(TDBXReaderTableStorage.Create(Command, Reader));
      // When the Result is freed, this Command will be freed.
      Command := nil;
      SetLength(Columns, 5);
      Columns[0] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXTablesColumns.CatalogName, 'TABLE_CAT', TDBXDataTypes.WideStringType);
      Columns[1] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXTablesColumns.SchemaName, 'TABLE_SCHEM', TDBXDataTypes.WideStringType);
      Columns[2] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXTablesColumns.TableName, 'TABLE_NAME', TDBXDataTypes.WideStringType);
      Columns[3] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXTablesColumns.TableType, 'TABLE_TYPE', TDBXDataTypes.WideStringType);
      Columns[4] := TDBXMetaDataCollectionColumns.CreateValueType('Remarks', 'REMARKS', TDBXDataTypes.WideStringType);
      Result := TDBXCustomMetaDataTable.Create(GetContext, GetMetaDataCollectionName(CommandText), Columns, Cursor);
    end;
  finally
    Command.Free;
  end;
end;

function TDBXOdbcMetaDataReader.AreCatalogFunctionsSupported;
begin
  Result := True;
end;

function TDBXOdbcMetaDataReader.AreCatalogsSupported: Boolean;
begin
  CheckInitialized;
  Result := FCatalogsSupported;
end;

function TDBXOdbcMetaDataReader.AreSchemasSupported: Boolean;
begin
  CheckInitialized;
  Result := FSchemasSupported;
end;

function TDBXOdbcMetaDataReader.GetDataTypeDescriptions: TDBXDataTypeDescriptionArray;
begin
  CheckInitialized;
  Result := FDataTypeDescriptions;
end;

function TDBXOdbcMetaDataReader.GetProductName: string;
begin
  Result := 'Odbc';
end;

function TDBXOdbcMetaDataReader.GetReservedWords: TDBXStringArray;
begin
  CheckInitialized;
  Result := TDBXStringArray(FReservedWords.ToStringArray);
end;

function TDBXOdbcMetaDataReader.GetSqlIdentifierQuoteChar: string;
begin
  CheckInitialized;
  Result := FSqlIdentifierQuoteChar;
end;

function TDBXOdbcMetaDataReader.GetSqlIdentifierQuotePrefix: string;
begin
  CheckInitialized;
  Result := FSqlIdentifierQuoteChar;
end;

function TDBXOdbcMetaDataReader.GetSqlIdentifierQuoteSuffix: string;
begin
  CheckInitialized;
  Result := FSqlIdentifierQuoteChar;
end;

function TDBXOdbcMetaDataReader.GetSqlProcedureQuoteChar: string;
begin
  CheckInitialized;
  Result := FSqlIdentifierQuoteChar;
end;

function TDBXOdbcMetaDataReader.IsDescendingIndexSupported: Boolean;
begin
  CheckInitialized;
  if (FIndexKeyword = SQL_IK_DESC) or (FIndexKeyword = SQL_IK_ALL) then
    Result := True
  else
    Result := False;
end;

function TDBXOdbcMetaDataReader.IsLowerCaseIdentifiersSupported: Boolean;
begin
  CheckInitialized;
  if FSqlIdentifierCase = SQL_IC_LOWER then
    Result := True
  else
    Result := False;
end;

function TDBXOdbcMetaDataReader.IsMultipleCommandsSupported: Boolean;
begin
  CheckInitialized;
  if FMaxConcurrentActivities <> 1 then
    Result := True
  else
    Result := False;
end;

function TDBXOdbcMetaDataReader.IsNestedTransactionsSupported: Boolean;
begin
  CheckInitialized;
  Result := FSupportsMultipleTransactions;
end;

function TDBXOdbcMetaDatareader.IsParameterMetadataSupported: Boolean;
begin
  CheckInitialized;
  Result := FSupportsParameterMetaData;
end;

function TDBXOdbcMetaDataReader.IsQuotedIdentifiersSupported: Boolean;
begin
  CheckInitialized;
  if FSqlIdentifierQuoteChar = '' then
    Result := False
  else
    Result := True;
end;

function TDBXOdbcMetaDataReader.IsSetRowSizeSupported: Boolean;
begin
  CheckInitialized;
  Result := True;
end;

function TDBXOdbcMetaDataReader.IsTransactionsSupported: Boolean;
begin
  CheckInitialized;
  if FTransactionCapable = SQL_TC_NONE then
    Result := False
  else
    Result := True;
end;

function TDBXOdbcMetaDataReader.IsUpperCaseIdentifiersSupported: Boolean;
begin
  CheckInitialized;
  if FSqlIdentifierCase = SQL_IC_UPPER then
    Result := True
  else
    Result := False
end;

procedure TDBXOdbcMetaDataReader.PopulateDataTypes(const Hash: TDBXObjectStore; const Types: TDBXArrayList; const Descr: TDBXDataTypeDescriptionArray);
var
  Index: Integer;
  DataType: TDBXDataTypeDescription;
  TypeName: string;
begin
  for Index := 0 to Length(Descr) - 1 do
  begin
    DataType := Descr[Index];
    if DataType <> nil then
    begin
      TypeName := DataType.TypeName;
      if (not Hash.ContainsKey(TypeName)) then
      begin
        Hash[TypeName] := DataType;
        Types.Add(DataType);
      end
      else
        Descr[Index].Free;
      Descr[Index] := nil;
    end;
  end;
end;

constructor TDBXOdbcMetaDataReader.Create;
begin
  inherited Create;
  FInitialized := False;
end;

constructor TDBXOdbcMetaDataReader.Create(OdbcConnection: TDBXOdbcConnection);
begin
  inherited Create;
  FInitialized := False;
  FConnectionHandle := OdbcConnection.ConnectionHandle;
  FOdbcConnection := OdbcConnection;
  Init;
end;

destructor TDBXOdbcMetaDataReader.Destroy;
var
  I: Integer;
begin
  FConnectionHandle := nil;
  FOdbcConnection := nil;
  FReservedWords.Free;
  for I := 0 to Length(FDataTypeDescriptions) - 1 do
    FDataTypeDescriptions[I].Free;
  inherited Destroy;
end;

function TDBXOdbcMetaDataReader.FetchCatalogs: TDBXTable;
begin
  Result := SqlTablesInvocation('GetCatalogs', '', '', '', '');
end;

function TDBXOdbcMetaDataReader.FetchColumns(const Catalog: string; const Schema: string; const Table: string): TDBXTable;
var
  Command: TDBXOdbcCommand;
  TableParam: TDBXParameter;
  Reader: TDBXReader;
  Columns: TDBXValueTypeArray;
  Cursor: TDBXTable;
begin
  DataTypeHash;
  CheckInitialized;
  Command := FOdbcConnection.CreateOdbcCommand;
  try
    Command.CommandType := TDBXCommandTypes.DbxMetaData;
    Command.Text := 'GetColumns';
    Command.RowSetSize := 1;
    TableParam := Command.CreateParameter;
    TableParam.DataType := TDBXDataTypes.WideStringType;
    Command.Parameters.AddParameter(TableParam);
    Command.Parameters[0].Value.SetWideString(Table);
    Reader := Command.ExecuteQuery;
    if Reader = nil then
      Result := nil
    else
    begin
      Cursor := TDBXStringTrimTable.CreateTrimTableIfNeeded(TDBXReaderTableStorage.Create(Command, Reader));
      // When the Result is freed, this Command will be freed.
      Command := nil;
      SetLength(Columns, 18);
      Columns[0] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXColumnsColumns.CatalogName, 'TABLE_CAT', TDBXDataTypes.WideStringType);
      Columns[1] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXColumnsColumns.SchemaName, 'TABLE_SCHEM', TDBXDataTypes.WideStringType);
      Columns[2] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXColumnsColumns.TableName, 'TABLE_NAME', TDBXDataTypes.WideStringType);
      Columns[3] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXColumnsColumns.ColumnName, 'COLUMN_NAME', TDBXDataTypes.WideStringType);
      Columns[4] := TDBXMetaDataCollectionColumns.CreateValueType('DATA_TYPE', 'DATA_TYPE', TDBXDataTypes.Int16Type);
      Columns[5] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXColumnsColumns.TypeName, 'TYPE_NAME', TDBXDataTypes.WideStringType);
      Columns[6] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXColumnsColumns.Precision, 'COLUMN_SIZE', TDBXDataTypes.Int32Type);
      Columns[7] := TDBXMetaDataCollectionColumns.CreateValueType('BUFFER_LENGTH', 'BUFFER_LENGTH', TDBXDataTypes.Int32Type);
      Columns[8] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXColumnsColumns.Scale, 'DECIMAL_DIGITS', TDBXDataTypes.Int16Type);
      Columns[9] := TDBXMetaDataCollectionColumns.CreateValueType('NUM_PREC_RADIX', 'NUM_PREC_RADIX', TDBXDataTypes.Int16Type);
      Columns[10] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXColumnsColumns.IsNullable, 'NULLABLE', TDBXDataTypes.Int16Type);
      Columns[11] := TDBXMetaDataCollectionColumns.CreateValueType('REMARKS', 'REMARKS', TDBXDataTypes.WideStringType);
      Columns[12] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXColumnsColumns.DefaultValue, 'COLUMN_DEF', TDBXDataTypes.WideStringType);
      Columns[13] := TDBXMetaDataCollectionColumns.CreateValueType('SQL_DATA_TYPE', 'SQL_DATA_TYPE', TDBXDataTypes.Int16Type);
      Columns[14] := TDBXMetaDataCollectionColumns.CreateValueType('SQL_DATETIME_SUB', 'SQL_DATETIME_SUB', TDBXDataTypes.Int16Type);
      Columns[15] := TDBXMetaDataCollectionColumns.CreateValueType('CHAR_OCTET_LENGTH', 'CHAR_OCTET_LENGTH', TDBXDataTypes.Int32Type);
      Columns[16] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXColumnsColumns.Ordinal, 'ORDINAL_POSITION', TDBXDataTypes.Int32Type);
      Columns[17] := TDBXMetaDataCollectionColumns.CreateValueType('IS_NULLABLE', 'IS_NULLABLE', TDBXDataTypes.WideStringType);
      Cursor := TDBXCustomMetaDataTable.Create(GetContext, TDBXMetaDataCollectionName.Columns, Columns, Cursor);
      Result := TDBXOdbcColumnsTableCursor.Create(Self, False, Cursor);
    end;
  finally
    Command.Free;
  end;
end;

function TDBXOdbcMetaDataReader.FetchForeignKeyColumns(const Catalog: string; const Schema: string; const Table: string; const ForeignKeyName: string; const PrimaryCatalog: string; const PrimarySchema: string; const PrimaryTable: string; const PrimaryKeyName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  CheckInitialized;
  Columns := TDBXMetaDataCollectionColumns.CreateForeignKeyColumnsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.ForeignKeyColumns, Columns);
end;

function TDBXOdbcMetaDataReader.FetchForeignKeys(const Catalog: string; const Schema: string; const Table: string): TDBXTable;
var
  Command: TDBXOdbcCommand;
  TableParam: TDBXParameter;
  Reader: TDBXReader;
  Columns: TDBXValueTypeArray;
  Cursor: TDBXTable;
begin
  CheckInitialized;
  Command := FOdbcConnection.CreateOdbcCommand;
  try
    Command.CommandType := TDBXCommandTypes.DbxMetaData;
    Command.Text := 'GetForeignKeys';
    Command.RowSetSize := 1;
    TableParam := Command.CreateParameter;
    TableParam.DataType := TDBXDataTypes.WideStringType;
    Command.Parameters.AddParameter(TableParam);
    Command.Parameters[0].Value.SetWideString(Table);
    Reader := Command.ExecuteQuery;
    if Reader = nil then
      Result := nil
    else
    begin
      Cursor := TDBXStringTrimTable.CreateTrimTableIfNeeded(TDBXReaderTableStorage.Create(Command, Reader));
      // When the Result is freed, this Command will be freed.
      Command := nil;
      SetLength(Columns, 14);
      Columns[0] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXForeignKeyColumnsColumns.PrimaryCatalogName, 'PKTABLE_CAT', TDBXDataTypes.WideStringType);
      Columns[1] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXForeignKeyColumnsColumns.PrimarySchemaName, 'PKTABLE_SCHEM', TDBXDataTypes.WideStringType);
      Columns[2] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXForeignKeyColumnsColumns.TableName, 'PKTABLE_NAME', TDBXDataTypes.WideStringType);
      Columns[3] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXForeignKeyColumnsColumns.PrimaryColumnName, 'PKCOLUMN_NAME', TDBXDataTypes.WideStringType);
      Columns[4] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXForeignKeyColumnsColumns.CatalogName, 'FKTABLE_CAT', TDBXDataTypes.WideStringType);
      Columns[5] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXForeignKeyColumnsColumns.SchemaName, 'FKTABLE_SCHEM', TDBXDataTypes.WideStringType);
      Columns[6] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXForeignKeyColumnsColumns.TableName, 'FKTABLE_NAME', TDBXDataTypes.WideStringType);
      Columns[7] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXForeignKeyColumnsColumns.ColumnName, 'FKCOLUMN_NAME', TDBXDataTypes.WideStringType);
      Columns[8] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXForeignKeyColumnsColumns.Ordinal, 'KEY_SEQ', TDBXDataTypes.Int16Type);
      Columns[9] := TDBXMetaDataCollectionColumns.CreateValueType('UPDATE_RULE', 'UPDATE_RULE', TDBXDataTypes.Int16Type);
      Columns[10] := TDBXMetaDataCollectionColumns.CreateValueType('DELETE_RULE', 'DELETE_RULE', TDBXDataTypes.Int16Type);
      Columns[11] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXForeignKeyColumnsColumns.ForeignKeyName, 'FK_NAME', TDBXDataTypes.WideStringType);
      Columns[12] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXForeignKeyColumnsColumns.PrimaryKeyName, 'PK_NAME', TDBXDataTypes.WideStringType);
      Columns[13] := TDBXMetaDataCollectionColumns.CreateValueType('DEFERRABILITY', 'DEFERRABILITY', TDBXDataTypes.Int16Type);
      Result := TDBXCustomMetaDataTable.Create(GetContext, TDBXMetaDataCollectionName.ForeignKeys, Columns, Cursor);
    end;
  finally
    Command.Free;
  end;
end;

function TDBXOdbcMetaDataReader.FetchIndexColumns(const Catalog: string; const Schema: string; const Table: string; const Index: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  CheckInitialized;
  Columns := TDBXMetaDataCollectionColumns.CreateIndexColumnsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.IndexColumns, Columns);
end;

function TDBXOdbcMetaDataReader.FetchIndexes(const Catalog: string; const Schema: string; const Table: string): TDBXTable;
var
  Command: TDBXOdbcCommand;
  TableParam: TDBXParameter;
  Reader: TDBXReader;
  Columns: TDBXValueTypeArray;
  Cursor: TDBXTable;
begin
  CheckInitialized;
  Command := FOdbcConnection.CreateOdbcCommand;
  try
    Command.CommandType := TDBXCommandTypes.DbxMetaData;
    Command.Text := 'GetIndexes';
    Command.RowSetSize := 1;
    TableParam := Command.CreateParameter;
    TableParam.DataType := TDBXDataTypes.WideStringType;
    Command.Parameters.AddParameter(TableParam);
    Command.Parameters[0].Value.SetWideString(Table);
    Reader := Command.ExecuteQuery;
    if Reader = nil then
      Result := nil
    else
    begin
      Cursor := TDBXStringTrimTable.CreateTrimTableIfNeeded(TDBXReaderTableStorage.Create(Command, Reader));
      // When the Result is freed, this Command will be freed.
      Command := nil;
      SetLength(Columns, 13);
      Columns[0] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexesColumns.CatalogName, 'TABLE_CAT', TDBXDataTypes.WideStringType);
      Columns[1] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexesColumns.SchemaName, 'TABLE_SCHEM', TDBXDataTypes.WideStringType);
      Columns[2] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexesColumns.TableName, 'TABLE_NAME', TDBXDataTypes.WideStringType);
      Columns[3] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexesColumns.IsUnique, 'NON_UNIQUE', TDBXDataTypes.BooleanType);
      Columns[4] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexesColumns.IndexQualifier, 'INDEX_QUALIFIER', TDBXDataTypes.WideStringType);
      Columns[5] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexesColumns.IndexName, 'INDEX_NAME', TDBXDataTypes.WideStringType);
      Columns[6] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexesColumns.TypeName, 'Type', TDBXDataTypes.Int16Type);
      Columns[7] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexesColumns.OrdinalPosition, 'ORDINAL_POSITION', TDBXDataTypes.Int16Type);
      Columns[8] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexesColumns.ColumnName, 'COLUMN_NAME', TDBXDataTypes.WideStringType);
      Columns[9] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexesColumns.AscDesc, 'ASC_OR_DESC', TDBXDataTypes.WideStringType);
      Columns[10] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexesColumns.Cardinality, 'CARDINALITY', TDBXDataTypes.Int32Type);
      Columns[11] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexesColumns.Pages, 'PAGES', TDBXDataTypes.Int32Type);
      Columns[12] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexesColumns.FilterCondition, 'FILTER_CONDITION', TDBXDataTypes.WideStringType);
      Result := TDBXCustomMetaDataTable.Create(GetContext, TDBXMetaDataCollectionName.Indexes, Columns, Cursor);
    end;
  finally
    Command.Free;
  end;
end;

function TDBXOdbcMetaDataReader.FetchPackageProcedureParameters(const Catalog: string; const Schema: string; const PackageName: string; const ProcedureName: string; const ParameterName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  CheckInitialized;
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProcedureParametersColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageProcedureParameters, Columns);
end;

function TDBXOdbcMetaDataReader.FetchPackageProcedures(const Catalog: string; const Schema: string; const PackageName: string; const ProcedureName: string; const ProcedureType: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  CheckInitialized;
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProceduresColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageProcedures, Columns);
end;

function TDBXOdbcMetaDataReader.FetchPackages(const Catalog: string; const Schema: string; const PackageName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  CheckInitialized;
  Columns := TDBXMetaDataCollectionColumns.CreatePackagesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Packages, Columns);
end;

function TDBXOdbcMetaDataReader.FetchPackageSources(const Catalog: string; const Schema: string; const PackageName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  CheckInitialized;
  Columns := TDBXMetaDataCollectionColumns.CreatePackageSourcesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageSources, Columns);
end;

function TDBXOdbcMetaDataReader.FetchProcedures(const Catalog: string; const Schema: string; const ProcedureName: string; const ProcedureType: string): TDBXTable;
var
  Command: TDBXOdbcCommand;
  Reader: TDBXReader;
  Columns: TDBXValueTypeArray;
  Cursor: TDBXTable;
  ProcNameParam: TDBXParameter;
begin
  CheckInitialized;
  Command := FOdbcConnection.CreateOdbcCommand;
  try
    Command.CommandType := TDBXCommandTypes.DbxMetaData;
    Command.Text := 'GetProcedures';
    Command.RowSetSize := 1;
    ProcNameParam := Command.CreateParameter;
    ProcNameParam.DataType := TDBXDataTypes.WideStringType;
    Command.Parameters.AddParameter(ProcNameParam);
    Command.Parameters[0].Value.SetWideString(ProcedureName);
    Reader := Command.ExecuteQuery;
    if Reader = nil then
      Result := nil
    else
    begin
      Cursor := TDBXStringTrimTable.CreateTrimTableIfNeeded(TDBXReaderTableStorage.Create(Command, Reader));
      // When the Result is freed, this Command will be freed.
      Command := nil;
      SetLength(Columns, 8);
      Columns[0] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXProceduresColumns.CatalogName, 'PROCEDURE_CAT', TDBXDataTypes.WideStringType);
      Columns[1] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXProceduresColumns.SchemaName, 'PROCEDURE_SCHEM', TDBXDataTypes.WideStringType);
      Columns[2] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXProceduresColumns.ProcedureName, 'PROCEDURE_NAME', TDBXDataTypes.WideStringType);
      Columns[3] := TDBXMetaDataCollectionColumns.CreateValueType('NUM_INPUT_PARAMS', 'NUM_INPUT_PARAMS', TDBXDataTypes.Int32Type);
      Columns[4] := TDBXMetaDataCollectionColumns.CreateValueType('NUM_OUTPUT_PARAMS', 'NUM_OUTPUT_PARAMS', TDBXDataTypes.Int32Type);
      Columns[5] := TDBXMetaDataCollectionColumns.CreateValueType('NUM_RESULT_SETS', 'NUM_RESULT_SETS', TDBXDataTypes.Int32Type);
      Columns[6] := TDBXMetaDataCollectionColumns.CreateValueType('REMARKS', 'REMARKS', TDBXDataTypes.WideStringType);
      Columns[7] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXProceduresColumns.ProcedureType, 'PROCEDURE_TYPE', TDBXDataTypes.Int16Type);
      Result := TDBXCustomMetaDataTable.Create(GetContext, TDBXMetaDataCollectionName.Procedures, Columns, Cursor);
    end;
  finally
    Command.Free;
  end;
end;

function TDBXOdbcMetaDataReader.FetchProcedureParameters(const Catalog: string; const Schema: string; const Proc: string; const Parameter: string): TDBXTable;
var
  Command: TDBXOdbcCommand;
  ProcParam: TDBXParameter;
  Reader: TDBXReader;
  Columns: TDBXValueTypeArray;
  Cursor: TDBXTable;

  function GetProcName(OriginalName: string): string;
  var
    LStr: string;
  begin
    Result := OriginalName;
    if OriginalName.Chars[0] <> Self.SqlIdentifierQuoteChar.Chars[0] then
    begin
      if IsLowerCaseIdentifiersSupported then
      begin
        LStr := OriginalName.ToLower;
        if LStr <> OriginalName then
          Result := AnsiQuotedStr(OriginalName, Self.SqlIdentifierQuoteChar.Chars[0])
      end
      else if IsUpperCaseIdentifiersSupported then
      begin
        LStr := OriginalName.ToUpper;
        if LStr <> OriginalName then
          Result := AnsiQuotedStr(OriginalName, Self.SqlIdentifierQuoteChar.Chars[0])
      end
    end;
  end;

begin
  CheckInitialized;
  Command := FOdbcConnection.CreateOdbcCommand;
  try
    Command.CommandType := TDBXCommandTypes.DbxMetaData;
    Command.Text := 'GetProcedureParameters';
    Command.RowSetSize := 1;
    ProcParam := Command.CreateParameter;
    ProcParam.DataType := TDBXDataTypes.WideStringType;
    Command.Parameters.AddParameter(ProcParam);
    Command.Parameters[0].Value.SetWideString(GetProcName(Proc));
    Reader := Command.ExecuteQuery;
    if Reader = nil then
      Result := nil
    else
    begin
      Cursor := TDBXStringTrimTable.CreateTrimTableIfNeeded(TDBXReaderTableStorage.Create(Command, Reader));
      // When the Result is freed, this Command will be freed.
      Command := nil;
      SetLength(Columns, 22);
      Columns[0] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXProcedureParametersColumns.CatalogName, 'PROCEDURE_CAT', TDBXDataTypes.WideStringType);
      Columns[1] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXProcedureParametersColumns.SchemaName, 'PROCEDURE_SCHEM', TDBXDataTypes.WideStringType);
      Columns[2] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXProcedureParametersColumns.ProcedureName, 'PROCEDURE_NAME', TDBXDataTypes.WideStringType);
      Columns[3] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXProcedureParametersColumns.ParameterName, 'COLUMN_NAME', TDBXDataTypes.WideStringType);
      Columns[4] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXProcedureParametersColumns.ParameterMode, 'COLUMN_TYPE', TDBXDataTypes.Int16Type);
      Columns[5] := TDBXMetaDataCollectionColumns.CreateValueType('DATA_TYPE', 'DATA_TYPE', TDBXDataTypes.Int16Type);
      Columns[6] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXProcedureParametersColumns.TypeName, 'TYPE_NAME', TDBXDataTypes.WideStringType);
      Columns[7] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXProcedureParametersColumns.Precision, 'COLUMN_SIZE', TDBXDataTypes.Int32Type);
      Columns[8] := TDBXMetaDataCollectionColumns.CreateValueType('BUFFER_LENGTH', 'BUFFER_LENGTH', TDBXDataTypes.Int32Type);
      Columns[9] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXProcedureParametersColumns.Scale, 'DECIMAL_DIGITS', TDBXDataTypes.Int16Type);
      Columns[10] := TDBXMetaDataCollectionColumns.CreateValueType('NUM_PREC_RADIX', 'NUM_PREC_RADIX', TDBXDataTypes.Int16Type);
      Columns[11] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXProcedureParametersColumns.IsNullable, 'NULLABLE', TDBXDataTypes.Int16Type);
      Columns[12] := TDBXMetaDataCollectionColumns.CreateValueType('REMARKS', 'REMARKS', TDBXDataTypes.WideStringType);
      Columns[13] := TDBXMetaDataCollectionColumns.CreateValueType('COLUMN_DEF', 'COLUMN_DEF', TDBXDataTypes.WideStringType);
      Columns[14] := TDBXMetaDataCollectionColumns.CreateValueType('SQL_DATA_TYPE', 'SQL_DATA_TYPE', TDBXDataTypes.Int16Type);
      Columns[15] := TDBXMetaDataCollectionColumns.CreateValueType('SQL_DATETIME_SUB', 'SQL_DATETIME_SUB', TDBXDataTypes.Int16Type);
      Columns[16] := TDBXMetaDataCollectionColumns.CreateValueType('CHAR_OCTET_LENGTH', 'CHAR_OCTET_LENGTH', TDBXDataTypes.Int32Type);
      Columns[17] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXProcedureParametersColumns.Ordinal, 'ORDINAL_POSITION', TDBXDataTypes.Int32Type);
      Columns[18] := TDBXMetaDataCollectionColumns.CreateValueType('IS_NULLABLE', 'IS_NULLABLE', TDBXDataTypes.WideStringType);
      Columns[19] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXProcedureParametersColumns.DbxDataType, SDbxDataType, TDBXDataTypes.Int32Type, True);
      Columns[20] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXProcedureParametersColumns.ParameterMode, SParameterMode, TDBXDataTypes.WideStringType, True);
      Columns[21] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXProcedureParametersColumns.IsFixedLength, SIsFixedLength, TDBXDataTypes.BooleanType, True);
      Cursor := TDBXCustomMetaDataTable.Create(GetContext, TDBXMetaDataCollectionName.ProcedureParameters, Columns, Cursor);
      Result := TDBXOdbcColumnsTableCursor.Create(Self, False, Cursor);
    end;
  finally
    Command.Free;
  end;
end;

function TDBXOdbcMetaDataReader.FetchProcedureSources(const Catalog: string; const Schema: string; const Proc: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  CheckInitialized;
  Columns := TDBXMetaDataCollectionColumns.CreateProcedureSourcesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.ProcedureSources, Columns);
end;

function TDBXOdbcMetaDataReader.FetchRoles: TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  CheckInitialized;
  Columns := TDBXMetaDataCollectionColumns.CreateRolesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Roles, Columns);
end;

function TDBXOdbcMetaDataReader.FetchSchemas(const Catalog: string): TDBXTable;
begin
  Result := SqlTablesInvocation('GetSchemas', Catalog, '', '', '');
end;

function TDBXOdbcMetaDataReader.FetchSynonyms(const Catalog: string; const Schema: string; const Synonym: string): TDBXTable;
begin
  Result := SqlTablesInvocation('GetSynonyms', Catalog, Schema, Synonym, '');
end;

function TDBXOdbcMetaDataReader.FetchTables(const Catalog: string; const Schema: string; const TableName: string; const TableType: string): TDBXTable;
begin
  Result := SqlTablesInvocation('GetTables', Catalog, Schema, TableName, TableType);
end;

function TDBXOdbcMetaDataReader.FetchUsers: TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  CheckInitialized;
  Columns := TDBXMetaDataCollectionColumns.CreateUsersColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Users, Columns);
end;

function TDBXOdbcMetaDataReader.FetchViews(const Catalog: string; const Schema: string; const View: string): TDBXTable;
begin
  Result := SqlTablesInvocation('GetViews', Catalog, Schema, View, '');
end;

{ TDBXOdbcColumnsTableCursor }

function TDBXOdbcColumnsTableCursor.GetWritableValue(
  const Ordinal: Integer): TDBXWritableValue;
begin
  if DBXTableName = TDBXMetaDataCollectionName.ProcedureParameters then
  begin
    if Ordinal + FOrdinalOffset >= TDBXOdbcProcedureParametersIndex.DbxDataType then
      Result := FDataTypesRow.Value[Ordinal - (TDBXOdbcProcedureParametersIndex.DbxDataType - FOrdinalOffset)]
    else
      Result := FTable.Value[Ordinal];
  end
  else
    Result := FTable.Value[Ordinal];
end;

constructor TDBXOdbcColumnsTableCursor.Create(const Reader: TDBXBaseMetaDataReader; const CheckBase: Boolean; const Cursor: TDBXTable);
var
  DataTypeColumns: TDBXValueTypeArray;
  Ordinal: Integer;
begin
  inherited Create;
  Table := Cursor;
  FDataTypeHash := Reader.DataTypeHash;
  FReader := Reader;
  FCheckBase := CheckBase;
  FOrdinalOffset := 0;
  FOrdinalTypeName := TDBXOdbcProcedureParametersIndex.TypeName;
  if (DBXTableName = TDBXMetaDataCollectionName.ProcedureParameters) then
  begin
    FOrdinalOffset := 0;
    SetLength(DataTypeColumns, TDBXOdbcProcedureParametersIndex.Last - TDBXOdbcProcedureParametersIndex.DbxDataType + 1);
    for Ordinal := 0 to Length(DataTypeColumns) - 1 do
      DataTypeColumns[Ordinal] := TDBXValueType(Cursor.Columns[Ordinal + TDBXOdbcProcedureParametersIndex.DbxDataType - FOrdinalOffset].Clone());
  end
  else
    SetLength(DataTypeColumns, 0);
  FDataTypesRow := TDBXSingleValueRow.Create;
  FDataTypesRow.Columns := DataTypeColumns;
end;

destructor TDBXOdbcColumnsTableCursor.Destroy;
begin
  FreeAndNil(FDataTypesRow);
  inherited Destroy;
end;

function TDBXOdbcColumnsTableCursor.Next: Boolean;
  function GetModeString(ColumnType: SmallInt): string;
  begin
    case ColumnType of
      SQL_PARAM_INPUT: Result := 'IN';
      SQL_PARAM_INPUT_OUTPUT: Result := 'INOUT';
      SQL_PARAM_OUTPUT: Result := 'OUT';
      SQL_RETURN_VALUE: Result := 'RETURN';
      SQL_RESULT_COL:  Result := 'RESULT';
      else
        Result := 'UNKNOWN';
    end;
  end;

  function GetDataType(SQLType: Integer): TDBXType;
  begin
    case SQLType of
      SQL_CHAR, SQL_VARCHAR:
        Result := TDBXDataTypes.AnsiStringType;
      SQL_LONGVARCHAR, SQL_WLONGVARCHAR, SQL_LONGVARBINARY:
        Result := TDBXDataTypes.BlobType;
      SQL_WCHAR, SQL_WVARCHAR:
        Result := TDBXDataTypes.WideStringType;
      SQL_DECIMAL, SQL_NUMERIC:
        Result := TDBXDataTypes.BcdType;
      SQL_SMALLINT:
        Result := TDBXDataTypes.Int16Type;
      SQL_INTEGER:
        Result := TDBXDataTypes.Int32Type;
      SQL_REAL:
        Result := TDBXDataTypes.SingleType;
      SQL_DOUBLE, SQL_FLOAT:
        Result := TDBXDataTypes.DoubleType;
      SQL_BIT:
        Result := TDBXDataTypes.BooleanType;
      SQL_TINYINT:
        Result := TDBXDataTypes.Int8Type;
      SQL_BIGINT:
        Result := TDBXDataTypes.Int64Type;
      SQL_BINARY:
        Result := TDBXDataTypes.BytesType;
      SQL_VARBINARY:
        Result := TDBXDataTypes.VarBytesType;
      SQL_TYPE_DATE:
        Result := TDBXDataTypes.DateType;
      SQL_TYPE_TIME:
        Result := TDBXDataTypes.TimeType;
      SQL_TYPE_TIMESTAMP:
        Result := TDBXDataTypes.TimeStampType;
      SQL_TYPE_NULL:
        Result := TDBXDataTypes.UnknownType;
      else //We will treat unknown data types as strings
        Result := TDBXDataTypes.AnsiStringType;
    end;
  end;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FTable.Next;
  if ReturnValue then
  begin
    FDataType := TDBXDataTypeDescription(FDataTypeHash[FTable.Value[FOrdinalTypeName].AsString]);
    if DBXTableName = TDBXMetaDataCollectionName.ProcedureParameters then
    begin
      if FDataType = nil then
      begin
        FDataTypesRow.Value[0].AsInt32 := GetDataType(FTable.Value[TDBXOdbcProcedureParametersIndex.SqlDataType].AsInt32);
        FDataTypesRow.Value[TDBXOdbcProcedureParametersIndex.ParameterMode - TDBXOdbcProcedureParametersIndex.DbxDataType].AsString := 'IN';
        FDataTypesRow.Value[TDBXOdbcProcedureParametersIndex.IsFixedLength - TDBXOdbcProcedureParametersIndex.DbxDataType].AsBoolean := False;
      end
      else
      begin
        FDataTypesRow.Value[0].AsInt32 := FDataType.DbxDataType;
        FDataTypesRow.Value[TDBXOdbcProcedureParametersIndex.ParameterMode - TDBXOdbcProcedureParametersIndex.DbxDataType].AsString := GetModeString(FTable.Value[TDBXOdbcProcedureParametersIndex.Mode].AsInt16);
        FDataTypesRow.Value[TDBXOdbcProcedureParametersIndex.IsFixedLength - TDBXOdbcProcedureParametersIndex.DbxDataType].AsBoolean := FDataType.FixedLength;
      end;
    end;
  end;
  Result := ReturnValue;
end;

end.



