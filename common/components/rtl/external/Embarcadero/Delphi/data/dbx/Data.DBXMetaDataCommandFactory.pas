{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXMetaDataCommandFactory;

interface

uses
  Data.DBXCommon,
  Data.DBXPlatform,
  Data.DBXSqlScanner,
  Data.DBXCommonTable,
  Data.DBXMetaDataReader
;

type
  TDBXMetaDataCommandFactory = class(TDBXCommandFactory)
  public
    class procedure RegisterMetaDataCommandFactory(const ObjectClass: TClass); static;
    class procedure UnRegisterMetaDataCommandFactory(const ObjectClass: TClass); static;
    function CreateCommand(DbxContext: TDBXContext; Connection: TDBXConnection;
      MorphicCommand: TDBXCommand): TDBXCommand; override;
    function CreateMetaDataReader: TDBXMetaDataReader; virtual; abstract;
    function GetProductName: string; virtual;
  end;

  TDBXDataExpressProviderContext = class(TDBXProviderContext)
  protected
    [Weak]FConnection: TDBXConnection;
    FScanner: TDBXSqlScanner;
    FParameterMarker: string;
    FMarkerIncludedInParameterName: Boolean;
    FUseAnsiStrings: Boolean;
    FRemoveIsNull: Boolean;
  private
//  procedure BindParametersByName(Command: TDBXCommand; ParameterNames: TDBXStringArray; ParameterValues: TDBXStringArray);
    procedure BindParametersByOrdinal(Command: TDBXCommand; ParameterNames: TDBXStringArray; ParameterValues: TDBXStringArray);
    function FindParameterByName(const ParameterName: string; ParameterNames: TDBXStringArray): Integer;
  public
    constructor Create;
    destructor Destroy; override;
    function GetPlatformTypeName(const DataType: Integer;
      const IsUnsigned: Boolean): string; override;
    function ExecuteQuery(const Sql: string;
      const ParameterNames: TDBXStringArray;
      const ParameterValues: TDBXStringArray): TDBXTable; override;
    function CreateTableStorage(const CollectionName: string;
      const Columns: TDBXValueTypeArray): TDBXTable; override;
    function CreateRowStorage(const CollectionName: string;
      const Columns: TDBXValueTypeArray): TDBXTableRow; override;
    procedure StartTransaction; override;
    procedure StartSerializedTransaction; override;
    procedure Commit; override;
    procedure Rollback; override;
    function GetVendorProperty(const name: string): string; override;
  protected
    function GetSqlParameterMarker: string;
    function GetMarkerIncludedInParameterName: Boolean;
  public
    property SqlParameterMarker: string read FParameterMarker;
    property IsMarkerIncludedInParameterName: Boolean read FMarkerIncludedInParameterName;
    property Connection: TDBXConnection read FConnection write FConnection;
    property UseAnsiStrings: Boolean read FUseAnsiStrings write FUseAnsiStrings;
    property RemoveIsNull: Boolean read FRemoveIsNull write FRemoveIsNull;
  end;

  TDBXMetaDataCommand = class(TDBXCommand)
  public
    constructor Create(DBXContext: TDBXContext; MorphicCommand: TDBXCommand; Provider: TDBXMetaDataReader);
    destructor Destroy; override;
  protected
    procedure SetRowSetSize(const RowSetSize: Int64); override;
    procedure SetMaxBlobSize(const MaxBlobSize: Int64); override;
    function  GetRowsAffected: Int64; override;

    function  DerivedGetNextReader: TDBXReader; override;
    procedure DerivedOpen; override;
    procedure DerivedClose; override;
    procedure DerivedPrepare; override;
    function  DerivedExecuteQuery: TDBXReader; override;
    procedure DerivedExecuteUpdate; override;
  private
    function  CreateValueType(Name: string; DataType: Integer; Size: Integer): TDBXValueType;
    function  FetchDatabaseColumns: TDBXTable;
  private
    FQueryCommand: TDBXCommand;
    [Weak]FReader: TDBXMetaDataReader;
  end;

  TDBXReaderTableStorage = class(TDBXRowTable)
  private
    FLastNext: Boolean;
    FCommand: TDBXCommand;
    FReader: TDBXReader;
    FColumns: TDBXValueTypeArray;
    FNextCalled: Boolean;
  public
    constructor Create(Command: TDBXCommand; Reader: TDBXReader);
    destructor Destroy; override;
    function GetOrdinal(const ColumnName: string): Integer; override;
    function First: Boolean; override;
    function Next: Boolean; override;
    function InBounds: Boolean; override;
    procedure Close; override;
  protected
    function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
    function GetColumns: TDBXValueTypeArray; override;
    function GetStorage: TObject; override;
    function GetCommand: TObject; override;
  end;

implementation

uses
  Data.DBXClassRegistry,
  System.SysUtils,
  Data.DBXCommonResStrs
;

const
  ParameterQuote = '"';
  DatabaseCollectionName = 'Database';

  QuoteCharOrdinal = 0;
  ProcedureQuoteCharOrdinal = 1;
  MaxCommandsOrdinal = 2;
  SupportsTransactionsOrdinal = 3;
  SupportsNestedTransactionsOrdinal = 4;
  SupportsRowSetSizeOrdinal = 5;
  ProductVersionOrdinal = 6;
  ProductNameOrdinal = 7;
  QuotePrefixOrdinal = 8;
  QuoteSuffixOrdinal = 9;
  SupportsLowerCaseIdentifiersOrdinal = 10;
  SupportsUpperCaseIdentifiersOrdinal = 11;
  SupportsSPReturnCode = 12;
  SupportsParameterMetadata = 13;
  SupportsCatalogFunctions = 14;
  SupportsCatalogs = 15;
  SupportsSchemas = 16;
  DatabaseColumnCount = 17;

type
  TDBXMetaDataDbxReader = class;
  TDatabaseCursor = class;
  TDBXMetaDataRow = class;

  TDBXMetaDataDbxReader = class(TDBXReader)
  public
    constructor Create(DBXContext: TDBXContext; Row: TDBXMetaDataRow; Cursor: TDBXTable);
    destructor Destroy; override;
  protected
    function  DerivedNext: Boolean; override;
    procedure DerivedClose; override;
    function  GetByteReader: TDBXByteReader; override;
  private
    FByteReader:  TDBXReaderByteReader;
    function MapToDBXType(ColumnType: Integer): Integer;
  private
    FCursor: TDBXTable;
  end;

  TDatabaseCursor = class(TDBXCustomMetaDataTable)
  private
    FDatabaseRow: TDBXSingleValueRow;
  public
    constructor Create(Columns: TDBXValueTypeArray; Provider: TDBXMetaDataReader; TypeNames: TDBXPlatformTypeNames);
    function  Next: Boolean; override;
    destructor Destroy; override;
  protected
    function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
  private
    FReader: TDBXMetaDataReader;
    FRow: Integer;
  end;

  TDBXMetaDataRow = class(TDBXRow)
  protected
    constructor Create(DBXContext: TDBXContext; Row: TDBXTableRow);
  protected
    procedure GetWideString(DbxValue: TDBXWideStringValue; var WideStringBuilder: TDBXWideStringBuilder; var IsNull: LongBool); override;
    procedure GetBoolean(DbxValue: TDBXBooleanValue; var Value: LongBool; var IsNull: LongBool); override;
    procedure GetUInt8(DbxValue: TDBXUInt8Value; var Value: Byte; var IsNull: LongBool); override;
    procedure GetInt8(DbxValue: TDBXInt8Value; var Value: ShortInt; var IsNull: LongBool); override;
    procedure GetUInt16(DbxValue: TDBXUInt16Value; var Value: Word; var IsNull: LongBool); override;
    procedure GetInt16(DbxValue: TDBXInt16Value; var Value: SmallInt; var IsNull: LongBool); override;
    procedure GetInt32(DbxValue: TDBXInt32Value; var Value: TInt32; var IsNull: LongBool); override;
    procedure GetInt64(DbxValue: TDBXInt64Value; var Value: Int64; var IsNull: LongBool); override;
  private
    FRow: TDBXTableRow;
  end;


function TDBXMetaDataCommandFactory.GetProductName: string;
begin
  Result := '';
end;

class procedure TDBXMetaDataCommandFactory.RegisterMetaDataCommandFactory(const ObjectClass: TClass);
var
  ClassRegistry: TClassRegistry;
  ClassName: string;
begin
  ClassRegistry := TClassRegistry.GetClassRegistry;
  ClassName := ObjectClass.ClassName;
  if not ClassRegistry.HasClass(ClassName) then
    ClassRegistry.RegisterClass(ClassName, ObjectClass); { Do not resource }
end;

class procedure TDBXMetaDataCommandFactory.UnRegisterMetaDataCommandFactory(
  const ObjectClass: TClass);
var
  ClassName: string;
begin
  ClassName := ObjectClass.ClassName;
  TClassRegistry.GetClassRegistry.UnRegisterClass(ClassName);
end;

function TDBXMetaDataCommandFactory.CreateCommand(DbxContext: TDBXContext;
  Connection: TDBXConnection; MorphicCommand: TDBXCommand): TDBXCommand;
var
  Reader: TDBXMetaDataReader;
  ProviderContext: TDBXDataExpressProviderContext;
  ProductName: string;
begin
  ProductName := GetProductName;
  if (ProductName = '') or (ProductName = Connection.ProductName) then
  begin
    Reader := TDBXMetaDataReader(TDBXDriverHelp.GetMetaDataReader(Connection));
    if Reader = nil then
    begin
      Reader := CreateMetaDataReader;
      ProviderContext := TDBXDataExpressProviderContext.Create;
      ProviderContext.Connection := Connection;
      ProviderContext.UseAnsiStrings := TDBXProviderContext.UseAnsiString(Reader.ProductName);
      ProviderContext.RemoveIsNull := True;
      Reader.Context := ProviderContext;
      Reader.Version := TDBXConnection(Connection).ProductVersion;
      TDBXDriverHelp.SetMetaDataReader(Connection, Reader);
    end;
    Result := TDBXMetaDataCommand.Create(DBXContext, MorphicCommand, Reader);
  end else
    Result := nil;
end;

constructor TDBXDataExpressProviderContext.Create;
begin
  inherited Create;
end;

destructor TDBXDataExpressProviderContext.Destroy;
begin
  FreeAndNil(FScanner);
  inherited Destroy;
end;

function TDBXDataExpressProviderContext.GetPlatformTypeName(const DataType: Integer; const IsUnsigned: Boolean): string;
begin
  case DataType of
    TDBXDataTypes.Uint8Type:
      Result := 'Byte';
    TDBXDataTypes.Int8Type:
      Result := 'ShortInt';
    TDBXDataTypes.UInt16Type:
      Result := 'Word';
    TDBXDataTypes.Int16Type:
      Result := 'SmallInt';
    TDBXDataTypes.UInt32Type,
    TDBXDataTypes.Int32Type:
      Result := 'TInt32';
    TDBXDataTypes.UInt64Type,
    TDBXDataTypes.Int64Type:
      Result := 'Int64';
    TDBXDataTypes.BooleanType:
      Result := 'Boolean';
    TDBXDataTypes.DateType:
      Result := 'TDBXDate';
    TDBXDataTypes.TimeType:
      Result := 'TDBXTime';
    TDBXDataTypes.TimeStampType:
      Result := 'TSQLTimeStamp';
    TDBXDataTypes.IntervalType:
      Result := 'TSQLTimeStamp';
    TDBXDataTypes.TimeStampOffsetType:
      Result := 'TSQLTimeStampOffset';
    TDBXDataTypes.WideStringType:
      Result := 'String';
    TDBXDataTypes.AnsiStringType:
      Result := 'AnsiString';
    TDBXDataTypes.BcdType:
      Result := 'TBcd';
    TDBXDataTypes.SingleType:
      Result := 'Single';
    TDBXDataTypes.DoubleType:
      Result := 'Double';
    TDBXDataTypes.BlobType,
    TDBXDataTypes.BytesType,
    TDBXDataTypes.VarBytesType:
      Result := 'TBytes';
    TDBXDataTypes.ObjectType:
      Result := 'TObject';
    else
      raise Exception.Create(SUnknownDataType);
  end;
end;

function TDBXDataExpressProviderContext.GetSqlParameterMarker: string;
begin
  Result := FParameterMarker;
end;

function TDBXDataExpressProviderContext.GetMarkerIncludedInParameterName: Boolean;
begin
  Result := FMarkerIncludedInParameterName;
end;

function TDBXDataExpressProviderContext.ExecuteQuery(const Sql: string; const ParameterNames: TDBXStringArray; const ParameterValues: TDBXStringArray): TDBXTable;
var
  Reader: TDBXReader;
  Command: TDBXCommand;
begin
  Command := FConnection.CreateCommand;
  Command.Text := Sql;
  try
    if ParameterValues <> nil then
    begin
      BindParametersByOrdinal(Command, ParameterNames, ParameterValues);
    end;
    Reader := Command.ExecuteQuery;
    if Reader = nil then
      Result := nil
    else
    begin
      Result := TDBXStringTrimTable.CreateTrimTableIfNeeded(TDBXReaderTableStorage.Create(Command,Reader));
      // When the Result is freed, this Command will be freed.
      //
      Command := nil;
    end;
  finally
    FreeAndNil(Command);
  end;
end;

function TDBXDataExpressProviderContext.CreateTableStorage(const CollectionName: string; const Columns: TDBXValueTypeArray): TDBXTable;
begin
  Result := nil;
end;

function TDBXDataExpressProviderContext.CreateRowStorage(const CollectionName: string; const Columns: TDBXValueTypeArray): TDBXTableRow;
begin
  Result := nil;
end;

procedure TDBXDataExpressProviderContext.StartTransaction;
begin
end;

procedure TDBXDataExpressProviderContext.StartSerializedTransaction;
begin
end;

procedure TDBXDataExpressProviderContext.Commit;
begin
end;

procedure TDBXDataExpressProviderContext.Rollback;
begin
end;

function TDBXDataExpressProviderContext.GetVendorProperty(const name: string): string;
begin
  Result := FConnection.GetVendorProperty(name);
end;

{
procedure TDBXDataExpressProviderContext.BindParametersByName(Command: TDBXCommand; ParameterNames: TDBXStringArray; ParameterValues: TDBXStringArray);
var
  Parameters: TDBXParameterList;
  Parameter: TDBXParameter;
  Index: Integer;
begin
  Parameters := Command.Parameters;
  for Index := Low(ParameterValues) to High(ParameterValues) do
  begin
    Parameter := Command.CreateParameter;
    Parameter.DataType := TDBXDataTypes.WideStringType;
    Parameter.Name := ParameterNames[Index];
    if ParameterValues[Index] = NullString then
      Parameter.Value.SetNull
    else
      Parameter.Value.SetWideString(ParameterValues[Index]);
    Parameters.AddParameter(Parameter);
  end;
end;
}

procedure TDBXDataExpressProviderContext.BindParametersByOrdinal(Command: TDBXCommand; ParameterNames: TDBXStringArray; ParameterValues: TDBXStringArray);
const
  KeywordIS = 'IS';      { Do not localize }
  KeywordNULL = 'NULL';  { Do not localize }
  SqlTrueValue = '1=1';  { Do not localize }
  SqlFalseValue = '1=2'; { Do not localize }
  DummyValue = 'A';      { Do not localize }
  TokenIS = 1;
  TokenNULL = 2;
var
  Count, EndPos, Index, ParameterIndex, StartPos, Token: Integer;
  Parameters: TDBXParameterList;
  Parameter: TDBXParameter;
  Buffer: TStringBuilder;
  Params: array of Integer;
  NullWasRemoved: Boolean;
begin
  Count := 0;
  StartPos := 1;
  Buffer := nil;
  if FScanner = nil then
  begin
    FScanner := TDBXSqlScanner.Create('','','');
    FScanner.RegisterId(KeywordIS, TokenIS);
    FScanner.RegisterId(KeywordNULL, TokenNULL);
  end;
  FScanner.Init(Command.Text);
  Token := FScanner.NextToken;
  while Token <> TDBXSqlScanner.TokenEos do
  begin
    if (Token <> TDBXSqlScanner.TokenSymbol) or (FScanner.Symbol <> ':') then
      Token := FScanner.NextToken
    else
    begin
      EndPos := FScanner.NextIndex;
      Token := FScanner.NextToken;
      if Token = TDBXSqlScanner.TokenId then
      begin
        if Buffer = nil then
        begin
          Buffer := TStringBuilder.Create(Command.Text.Length);
          SetLength(Params,Length(ParameterNames)*3);
        end;
        Buffer.Append(Command.Text.Substring(StartPos - 1, EndPos - StartPos));
        StartPos := FScanner.NextIndex+1;
        ParameterIndex := FindParameterByName(FScanner.Id, ParameterNames);

        NullWasRemoved := False;
        if RemoveIsNull then
        begin
          if (FScanner.LookAtNextToken = TokenIS) then
          begin
            FScanner.NextToken;
            if FScanner.LookAtNextToken = TokenNull then
            begin
              FScanner.NextToken;
              StartPos := FScanner.NextIndex+1;
              NullWasRemoved := True;
              if ParameterValues[ParameterIndex] = NullString then
                Buffer.Append(SqlTrueValue)
              else
                Buffer.Append(SqlFalseValue)
            end;
          end;
        end;

        if not NullWasRemoved then
        begin
          Buffer.Append('?');

          if Length(Params) <= Count then
            SetLength(Params, Count+2);
          Params[Count] := ParameterIndex;
          Inc(Count);
        end;
      end;
    end;
  end;
  if Buffer <> nil then
  begin
    Buffer.Append(Command.Text.Substring(StartPos - 1, Command.Text.Length - StartPos + 1));
    Command.Text := Buffer.ToString;
    Parameters := Command.Parameters;
    Parameters.ClearParameters;
    for Index := 0 to Count - 1 do
    begin
      ParameterIndex := Params[Index];
      Parameter := Command.CreateParameter;

      if UseAnsiStrings then
        Parameter.DataType := TDBXDataTypes.AnsiStringType
      else
        Parameter.DataType := TDBXDataTypes.WideStringType;

      if RemoveIsNull and (ParameterValues[ParameterIndex] = NullString) then
        ParameterValues[ParameterIndex] := DummyValue;
      if (ParameterValues[ParameterIndex] = NullString) then
        Parameter.Value.SetNull
{$IFNDEF NEXTGEN}
      else if UseAnsiStrings then
        Parameter.Value.SetAnsiString(AnsiString(ParameterValues[ParameterIndex]))
{$ENDIF !NEXTGEN}
      else
        Parameter.Value.SetString(ParameterValues[ParameterIndex]);

      Parameters.AddParameter(Parameter);
    end;
    Buffer.Free;
    Params := nil;
  end;
end;

function TDBXDataExpressProviderContext.FindParameterByName(const ParameterName: string; ParameterNames: TDBXStringArray): Integer;
var
  Index: Integer;
  Found: Boolean;
begin
  Index := High(ParameterNames);
  Found := False;
  while not Found and (Index >= Low(ParameterNames)) do
  begin
    if ParameterNames[Index] = ParameterName then
      Found := True
    else
      Dec(Index);
  end;
  if not Found then
    raise Exception.Create('ParameterName not found: '+ParameterName);
  Result := Index;
end;

constructor TDBXMetaDataCommand.Create(DBXContext: TDBXContext; MorphicCommand: TDBXCommand; Provider: TDBXMetaDataReader);
begin
  inherited Create(DBXContext);
  FQueryCommand := nil;
  FReader := Provider;
end;

destructor TDBXMetaDataCommand.Destroy;
begin
  FreeAndNil(FQueryCommand);
  inherited Destroy;
end;

procedure TDBXMetaDataCommand.SetRowSetSize(const RowSetSize: Int64);
begin
                 
end;

procedure TDBXMetaDataCommand.SetMaxBlobSize(const MaxBlobSize: Int64);
begin
                 
end;

function  TDBXMetaDataCommand.GetRowsAffected: Int64;
begin
                 
  Result := 0;
end;

function TDBXMetaDataCommand.DerivedGetNextReader: TDBXReader;
begin
  Result := nil;
end;

procedure TDBXMetaDataCommand.DerivedOpen;
begin

end;

function TDBXMetaDataCommand.CreateValueType(Name: string; DataType,
  Size: Integer): TDBXValueType;
begin
  Result            := TDBXValueType.Create;
  Result.Name       := Name;
  Result.DataType   := DataType;
  Result.Size       := Size;
end;

procedure TDBXMetaDataCommand.DerivedClose;
begin

end;

procedure TDBXMetaDataCommand.DerivedPrepare;
begin

end;

function TDBXMetaDataCommand.DerivedExecuteQuery: TDBXReader;
var
  Table: TDBXTable;
  Row: TDBXMetaDataRow;
begin
  Table := FReader.FetchCollection(Text);
  if Table = nil then
    Table := FetchDatabaseColumns
  else
  begin
    if FQueryCommand <> nil then
      FreeAndNil(FQueryCommand);
    FQueryCommand := TDBXCommand(Table.Command);
  end;
  Row := TDBXMetaDataRow.Create(FDBXContext,Table);
  Result := TDBXMetaDataDbxReader.Create(FDBXContext,Row,Table);
end;

procedure TDBXMetaDataCommand.DerivedExecuteUpdate;
begin

end;

function TDBXMetaDataCommand.FetchDatabaseColumns: TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns, DatabaseColumnCount);
  Columns[QuoteCharOrdinal]                    := CreateValueType(TDBXMetaDatabaseColumnNames.QuoteChar,                    TDBXDataTypes.WideStringType, 2);
  Columns[ProcedureQuoteCharOrdinal]           := CreateValueType(TDBXMetaDatabaseColumnNames.ProcedureQuoteChar,           TDBXDataTypes.WideStringType, 2);
  Columns[SupportsTransactionsOrdinal]         := CreateValueType(TDBXMetaDatabaseColumnNames.SupportsTransactions,         TDBXDataTypes.BooleanType, 1);
  Columns[SupportsNestedTransactionsOrdinal]   := CreateValueType(TDBXMetaDatabaseColumnNames.SupportsNestedTransactions,   TDBXDataTypes.BooleanType, 1);
  Columns[MaxCommandsOrdinal]                  := CreateValueType(TDBXMetaDatabaseColumnNames.MaxCommands,                  TDBXDataTypes.Int32Type,     4);
  Columns[SupportsRowSetSizeOrdinal]           := CreateValueType(TDBXMetaDatabaseColumnNames.SupportsRowSetSize,           TDBXDataTypes.BooleanType, 1);
  // Sybase ASE/ASA, and Informix return values much larger than 20.
  //
  Columns[ProductVersionOrdinal]               := CreateValueType(TDBXMetaDatabaseColumnNames.ProductVersion,               TDBXDataTypes.WideStringType, 128);
  Columns[ProductNameOrdinal]                  := CreateValueType(TDBXMetaDatabaseColumnNames.ProductName,                  TDBXDataTypes.WideStringType, 128);
  Columns[QuotePrefixOrdinal]                  := CreateValueType(TDBXMetaDatabaseColumnNames.QuotePrefix,                  TDBXDataTypes.WideStringType, 2);
  Columns[QuoteSuffixOrdinal]                  := CreateValueType(TDBXMetaDatabaseColumnNames.QuoteSuffix,                  TDBXDataTypes.WideStringType, 2);
  Columns[SupportsLowerCaseIdentifiersOrdinal] := CreateValueType(TDBXMetaDatabaseColumnNames.SupportsLowerCaseIdentifiers, TDBXDataTypes.BooleanType, 1);
  Columns[SupportsUpperCaseIdentifiersOrdinal] := CreateValueType(TDBXMetaDatabaseColumnNames.SupportsUpperCaseIdentifiers, TDBXDataTypes.BooleanType, 1);
  Columns[SupportsSPReturnCode]                := CreateValueType(TDBXMetaDatabaseColumnNames.SupportsSPReturnCode, TDBXDataTypes.BooleanType, 1);
  Columns[SupportsParameterMetadata]           := CreateValueType(TDBXMetaDatabaseColumnNames.SupportsParameterMetadata, TDBXDataTypes.BooleanType, 1);
  Columns[SupportsCatalogFunctions]            := CreateValueType(TDBXMetaDatabaseColumnNames.SupportsCatalogFunctions, TDBXDataTypes.BooleanType, 1);
  Columns[SupportsCatalogs]                    := CreateValueType(TDBXMetaDatabaseColumnNames.SupportsCatalogs, TDBXDataTypes.BooleanType, 1);
  Columns[SupportsSchemas]                     := CreateValueType(TDBXMetaDatabaseColumnNames.SupportsSchemas, TDBXDataTypes.BooleanType, 1);
  Result := TDatabaseCursor.Create(Columns,FReader,FReader.Context);
end;

{ TDatabaseCursor }

constructor TDatabaseCursor.Create(Columns: TDBXValueTypeArray; Provider: TDBXMetaDataReader; TypeNames: TDBXPlatformTypeNames);
begin
  inherited Create(TypeNames, DatabaseCollectionName, Columns, nil);
  FReader := Provider;
  FDatabaseRow := TDBXSingleValueRow.Create;
  FDatabaseRow.Columns := CopyColumns();
end;

destructor TDatabaseCursor.Destroy;
begin
  FreeAndNil(FDatabaseRow);
  inherited;
end;

function TDatabaseCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  Result := FDatabaseRow.Value[Ordinal];
end;

function TDatabaseCursor.Next: Boolean;
begin
  if FRow < 2 then
    Inc(FRow);
  Result := (FRow = 1);
  FDatabaseRow.Value[QuoteCharOrdinal].SetWideString(FReader.SqlIdentifierQuoteChar);
  FDatabaseRow.Value[ProcedureQuoteCharOrdinal].SetWideString(FReader.SqlProcedureQuoteChar);
  FDatabaseRow.Value[ProductVersionOrdinal].SetWideString(FReader.Version);
  FDatabaseRow.Value[ProductNameOrdinal].SetWideString(FReader.ProductName);
  FDatabaseRow.Value[QuotePrefixOrdinal].SetWideString(FReader.SqlIdentifierQuotePrefix);
  FDatabaseRow.Value[QuoteSuffixOrdinal].SetWideString(FReader.SqlIdentifierQuoteSuffix);

  FDatabaseRow.Value[SupportsTransactionsOrdinal].SetBoolean(FReader.TransactionsSupported);
  FDatabaseRow.Value[SupportsNestedTransactionsOrdinal].SetBoolean(FReader.NestedTransactionsSupported);
  FDatabaseRow.Value[SupportsRowSetSizeOrdinal].SetBoolean(FReader.SetRowSizeSupported);
  FDatabaseRow.Value[SupportsLowerCaseIdentifiersOrdinal].SetBoolean(FReader.LowerCaseIdentifiersSupported);
  FDatabaseRow.Value[SupportsUpperCaseIdentifiersOrdinal].SetBoolean(FReader.UpperCaseIdentifiersSupported);
  FDatabaseRow.Value[SupportsSPReturnCode].SetBoolean(FReader.SPReturnCodeSupported);
  FDatabaseRow.Value[SupportsParameterMetadata].SetBoolean(FReader.ParameterMetadataSupported);
  FDatabaseRow.Value[SupportsCatalogFunctions].SetBoolean(FReader.CatalogFunctionsSupported);
  FDatabaseRow.Value[SupportsCatalogs].SetBoolean(FReader.CatalogsSupported);
  FDatabaseRow.Value[SupportsSchemas].SetBoolean(FReader.SchemasSupported);
  if FReader.MultipleCommandsSupported then
    FDatabaseRow.Value[MaxCommandsOrdinal].SetInt32(0)
  else
    FDatabaseRow.Value[MaxCommandsOrdinal].SetInt32(1);

end;

{ TDBXMetaDataDbxReader }

constructor TDBXMetaDataDbxReader.Create(DBXContext: TDBXContext; Row: TDBXMetaDataRow; Cursor: TDBXTable);
var
  Ordinal: Integer;
  Column, ValueType: TDBXValueType;
  Values: TDBXValueArray;
begin
  inherited Create(DBXContext, Row, nil);
  FCursor := Cursor;
  SetLength(Values, Length(Cursor.Columns));
  for Ordinal := Low(Values) to High(Values) do
  begin
    Column                   := Cursor.Columns[Ordinal];
    ValueType                := TDBXDriverHelp.CreateTDBXValueType(DBXContext,Row);
    ValueType.DataType       := MapToDBXType(Column.DataType);
    ValueType.SubType        := TDBXDataTypes.UnknownType;
    ValueType.Ordinal        := Ordinal;
    ValueType.Scale          := 0;
    ValueType.Size           := Column.Size;
    ValueType.Name           := Column.Name;
    if (ValueType.DataType = TDBXDataTypes.WideStringType) then
    begin
      if ValueType.Size = 0 then
        ValueType.Size        := 256;
      if ValueType.Precision = 0 then
        ValueType.Precision   := ValueType.Size;
      ValueType.Size := ValueType.Size + 2; // Allow space for the zero terminator.
    end;
    ValueType.ValueTypeFlags := TDBXValueTypeFlags.Nullable or TDBXValueTypeFlags.ReadOnly;
    Values[Ordinal] := TDBXValue.CreateValue(FDBXContext, ValueType, FDbxRow, true);
  end;
  SetValues(Values);
end;

destructor TDBXMetaDataDbxReader.Destroy;
begin
  FreeAndNil(FByteReader);
  FreeAndNil(FCursor);
  inherited Destroy;
end;

function TDBXMetaDataDbxReader.MapToDBXType(ColumnType: Integer): Integer;
begin
  Result := ColumnType;
end;

function  TDBXMetaDataDbxReader.DerivedNext: Boolean;
begin
  if FCursor = nil then
    Result := False
  else
  begin
    Result := FCursor.Next;
    if not Result then
    begin
      FCursor.Close;
      FreeAndNil(FCursor);
    end;
  end;
end;

function TDBXMetaDataDbxReader.GetByteReader: TDBXByteReader;
begin
  if FByteReader = nil then
    FByteReader := TDBXReaderByteReader.Create(FDbxContext, Self);
  Result := FByteReader;
end;

procedure TDBXMetaDataDbxReader.DerivedClose;
begin
  if FCursor <> nil then
  begin
    FCursor.Close;
    FreeAndNil(FCursor);
  end;
end;

{ TDBXMetaDataRow }

constructor TDBXMetaDataRow.Create(DBXContext: TDBXContext; Row: TDBXTableRow);
begin
  inherited Create(DBXContext);
  FRow := Row;
end;

procedure TDBXMetaDataRow.GetWideString(DbxValue: TDBXWideStringValue; var WideStringBuilder: TDBXWideStringBuilder; var IsNull: LongBool);
var
  Ordinal, SourceSize: Integer;
  Source: string;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FRow.Value[Ordinal].IsNull;
  if not IsNull then
  begin
    Source := FRow.Value[Ordinal].AsString;
    SourceSize := Source.Length;
    if SourceSize >= DbxValue.ValueType.Size then
      TDBXPlatform.ResizeWideStringBuilder(WideStringBuilder, SourceSize + 2);
    TDBXPlatform.CopyWideStringToBuilder(Source, SourceSize + 2, WideStringBuilder);
  end;
end;

procedure TDBXMetaDataRow.GetBoolean(DbxValue: TDBXBooleanValue; var Value: LongBool; var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FRow.Value[Ordinal].IsNull;
  if not IsNull then
    Value := FRow.Value[Ordinal].AsBoolean
  else
    Value := False;
end;

procedure TDBXMetaDataRow.GetInt16(DbxValue: TDBXInt16Value; var Value: SmallInt; var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FRow.Value[Ordinal].IsNull;
  if not IsNull then
    Value := FRow.Value[Ordinal].AsInt16
  else
    Value := 0;
end;

procedure TDBXMetaDataRow.GetInt32(DbxValue: TDBXInt32Value; var Value: TInt32; var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FRow.Value[Ordinal].IsNull;
  if not IsNull then
    Value := FRow.Value[Ordinal].AsInt32
  else
    Value := 0;
end;

procedure TDBXMetaDataRow.GetInt64(DbxValue: TDBXInt64Value; var Value: Int64; var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FRow.Value[Ordinal].IsNull;
  if not IsNull then
    Value := FRow.Value[Ordinal].AsInt64
  else
    Value := 0;
end;

procedure TDBXMetaDataRow.GetInt8(DbxValue: TDBXInt8Value; var Value: ShortInt;
  var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FRow.Value[Ordinal].IsNull;
  if not IsNull then
    Value := FRow.Value[Ordinal].AsInt8
  else
    Value := 0;
end;

procedure TDBXMetaDataRow.GetUInt16(DbxValue: TDBXUInt16Value; var Value: Word;
  var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FRow.Value[Ordinal].IsNull;
  if not IsNull then
    Value := FRow.Value[Ordinal].AsUInt16
  else
    Value := 0;
end;

procedure TDBXMetaDataRow.GetUInt8(DbxValue: TDBXUInt8Value; var Value: Byte;
  var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FRow.Value[Ordinal].IsNull;
  if not IsNull then
    Value := FRow.Value[Ordinal].AsUInt8
  else
    Value := 0;
end;

constructor TDBXReaderTableStorage.Create(Command: TDBXCommand; Reader: TDBXReader);
begin
  inherited Create(nil, nil);
  FCommand := Command;
  FReader := Reader;
end;

destructor TDBXReaderTableStorage.Destroy;
begin
  Close;
  FreeObjectArray(TDBXFreeArray(FColumns));
  inherited Destroy;
end;

function TDBXReaderTableStorage.GetCommand: TObject;
begin
  Result := FCommand;
  FCommand := nil;
end;

function TDBXReaderTableStorage.GetOrdinal(
  const ColumnName: string): Integer;
begin
  Result := FReader.GetOrdinal(ColumnName);
end;

function TDBXReaderTableStorage.First: Boolean;
begin
  if FNextCalled then
    raise Exception.Create(SUnsupportedOperation);
  Result := True;
end;

function TDBXReaderTableStorage.Next: Boolean;
begin
  FNextCalled := True;
  Result := FReader.Next;
  FLastNext := Result;
end;

function TDBXReaderTableStorage.InBounds: Boolean;
begin
  if not FNextCalled then
    Next;
  Result := FLastNext;
end;

procedure TDBXReaderTableStorage.Close;
begin
  FreeAndNil(FReader);
  FreeAndNil(FCommand);
end;

function TDBXReaderTableStorage.GetColumns: TDBXValueTypeArray;
var
  Ordinal: Integer;
  ValueType: TDBXValueType;
begin
  if FColumns = nil then
  begin
    SetLength(FColumns, FReader.ColumnCount);
    for Ordinal := Low(FColumns) to High(FColumns) do
    begin
      ValueType := FReader.ValueType[Ordinal];
      FColumns[Ordinal] := TDBXValueType.Create;
      FColumns[Ordinal].Name      := ValueType.Name;
      FColumns[Ordinal].DisplayName   := ValueType.DisplayName;
      FColumns[Ordinal].DataType  := ValueType.DataType;
      FColumns[Ordinal].SubType  := ValueType.SubType;
      FColumns[Ordinal].Size      := ValueType.Size;
      FColumns[Ordinal].Precision := ValueType.Precision;
    end;
  end;
  Result := FColumns;
end;

function TDBXReaderTableStorage.GetStorage: TObject;
begin
  Result := FReader;
end;

function TDBXReaderTableStorage.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  Result := TDBXWritableValue(FReader.Value[Ordinal]);
end;

end.



