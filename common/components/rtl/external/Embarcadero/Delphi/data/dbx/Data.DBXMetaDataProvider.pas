{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXMetaDataProvider;

interface

uses
  System.Generics.Collections,
  Data.DBXCommon,
  Data.DBXCommonTable,
  Data.DBXMetaDataReader,
  Data.DBXMetaDataWriter,
  Data.DBXTypedTableStorage;

type
  TDBXMetaDataColumn = class;
  TDBXMetaDataTable = class;
  TDBXSqlExecution = class;
  TDBXMetaDataColumnArray = array of TDBXMetaDataColumn;

  TDBXMetaDataColumn = class
  private
    FColumnIndex: Integer;
    FColumnName: string;
    FDefaultValue: string;
    FDataType: Integer;
    FPrecision: Int64;
    FScale: Integer;
    FMaxInline: Integer;
    FUnsigned: Boolean;
    FAutoIncrement: Boolean;
    FNullable: Boolean;
    FFixedLength: Boolean;
    FUnicodeString: Boolean;
    FBlob: Boolean;
    [Weak]FColumnStorage: TDBXColumnsTableStorage;
    FTypeName: string;
    procedure SetAutoIncrement(const Value: Boolean);
    procedure SetBlob(const Value: Boolean);
    procedure SetColumnName(const Value: string);
    procedure SetDefaultValue(const Value: string);
    procedure SetFixedLength(const Value: Boolean);
    procedure SetMaxInline(const Value: Integer);
    procedure SetNullable(const Value: Boolean);
    procedure SetDataType(const Value: Integer);
    procedure SetPrecision(const Value: Int64);
    procedure SetScale(const Value: Integer);
    procedure SetUnicodeString(const Value: Boolean);
    procedure SetUnsigned(const Value: Boolean);
    procedure SetTypeName(const Value: string);
  public
    constructor Create; overload;
    constructor Create(const Column: TDBXMetaDataColumn); overload;
    procedure CopyColumnPropertyToTableStorage(const AColumnIndex: Integer; const ANewValue: Variant);
    procedure CopyColumnToTableStorage(const Columns: TDBXColumnsTableStorage);
    property TypeName: string read FTypeName write SetTypeName;
    property AutoIncrement: Boolean read FAutoIncrement write SetAutoIncrement;
    property ColumnName: string read FColumnName write SetColumnName;
    property DefaultValue: string read FDefaultValue write SetDefaultValue;
    property FixedLength: Boolean read FFixedLength write SetFixedLength;
    property MaxInline: Integer read FMaxInline write SetMaxInline;
    property Nullable: Boolean read FNullable write SetNullable;
    property Long: Boolean read FBlob write SetBlob;
    property Precision: Int64 read FPrecision write SetPrecision;
    property Scale: Integer read FScale write SetScale;
    property DataType: Integer read FDataType write SetDataType;
    property UnicodeString: Boolean read FUnicodeString write SetUnicodeString;
    property Unsigned: Boolean read FUnsigned write SetUnsigned;
  end;

  TDBXInt8Column = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string);
  end;

  TDBXInt64Column = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string);
  end;

  TDBXInt32Column = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string);
  end;

  TDBXInt16Column = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string);
  end;

  TDBXDoubleColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string);
  end;

  TDBXDecimalColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string; const InPrecision: Integer; const InScale: Integer);
  end;

  TDBXDateColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string);
  end;

  TDBXBooleanColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string);
  end;

  TDBXBinaryLongColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const Name: string);
  end;

  TDBXBinaryColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string; const InPrecision: Integer);
  end;

  TDBXAnsiVarCharColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const Name: string; const InPrecision: Integer);
  end;

  TDBXAnsiLongColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const Name: string);
  end;

  TDBXAnsiCharColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const Name: string; const InPrecision: Integer);
  end;

  TDBXMetaDataForeignKey = class
  private
    FForeignkey: TDBXForeignKeysTableStorage;
    FColumns: TDBXForeignKeyColumnsTableStorage;
    FPrimaryCatalogName: string;
    FPrimarySchemaName: string;
    FPrimaryTableName: string;
    FColumnCount: Integer;
  protected
    function GetForeignKeyColumnsStorage: TDBXForeignKeyColumnsTableStorage;
    function GetCatalogName: string;
    procedure SetCatalogName(const CatalogName: string);
    function GetSchemaName: string;
    procedure SetSchemaName(const SchemaName: string);
    function GetTableName: string;
    procedure SetTableName(const TableName: string);
    function GetForeignKeyName: string;
    procedure SetForeignKeyName(const ForeignKeyName: string);
  public
    constructor Create; overload;
    destructor Destroy; override;
    constructor Create(const InForeignTableName: string; const InPrimaryTableName: string; const InForeignKeyName: string; References: array of string); overload;
    procedure AddReference(const ColumnName: string; const ColumnNameInPrimaryTable: string);
    property ForeignKeysStorage: TDBXForeignKeysTableStorage read FForeignkey;
    property ForeignKeyColumnsStorage: TDBXForeignKeyColumnsTableStorage read GetForeignKeyColumnsStorage;
    property CatalogName: string read GetCatalogName write SetCatalogName;
    property SchemaName: string read GetSchemaName write SetSchemaName;
    property TableName: string read GetTableName write SetTableName;
    property ForeignKeyName: string read GetForeignKeyName write SetForeignKeyName;
    property PrimaryCatalogName: string read FPrimaryCatalogName write FPrimaryCatalogName;
    property PrimarySchemaName: string read FPrimarySchemaName write FPrimarySchemaName;
    property PrimaryTableName: string read FPrimaryTableName write FPrimaryTableName;
  end;

  TDBXMetaDataIndex = class
  private
    FIndexes: TDBXIndexesTableStorage;
    FColumns: TDBXIndexColumnsTableStorage;
    FColumnCount: Integer;
  protected
    function GetCatalogName: string;
    procedure SetCatalogName(const CatalogName: string);
    function GetSchemaName: string;
    procedure SetSchemaName(const SchemaName: string);
    function GetTableName: string;
    procedure SetTableName(const TableName: string);
    function GetIndexName: string;
    procedure SetIndexName(const IndexName: string);
    function IsUnique: Boolean;
    procedure SetUnique(const Unique: Boolean);
  public
    constructor Create; overload;
    destructor Destroy; override;
    constructor Create(const InTableName: string; const InIndexName: string; Columns: array of string); overload;
    procedure AddColumn(const ColumnName: string); overload;
    procedure AddColumn(const ColumnName: string; const Ascending: Boolean); overload;
    property IndexesStorage: TDBXIndexesTableStorage read FIndexes;
    property IndexColumnsStorage: TDBXIndexColumnsTableStorage read FColumns;
    property CatalogName: string read GetCatalogName write SetCatalogName;
    property SchemaName: string read GetSchemaName write SetSchemaName;
    property TableName: string read GetTableName write SetTableName;
    property IndexName: string read GetIndexName write SetIndexName;
    property Unique: Boolean read IsUnique write SetUnique;
  end;

  TDBXMetaDataProvider = class
  private
    FWriter: TDBXMetaDataWriter;
    FExecuter: TDBXSqlExecution;
  protected
    procedure SetWriter(const Writer: TDBXMetaDataWriter); virtual;
    function GetWriter: TDBXMetaDataWriter; virtual;
    function GetVendor: string;
    function GetDatabaseProduct: string;
    function GetDatabaseVersion: string;
    function GetIdentifierQuotePrefix: string;
    function GetIdentifierQuoteSuffix: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AlterTable(const Table: TDBXMetaDataTable);
    function CheckColumnSupported(const Column: TDBXMetaDataColumn): Boolean;
    procedure Execute(const Sql: string);
    procedure CreateTable(const Table: TDBXMetaDataTable);
    procedure CreateTableWithIndex(const Table: TDBXMetaDataTable; const Index: TDBXMetaDataIndex);
    function DropTable(const SchemaName: string; const TableName: string): Boolean; overload;
    function DropTable(const TableName: string): Boolean; overload;
    procedure CreatePrimaryKey(const Index: TDBXMetaDataIndex);
    procedure CreateUniqueIndex(const Index: TDBXMetaDataIndex);
    procedure CreateIndex(const Index: TDBXMetaDataIndex);
    function DropIndex(const TableName: string; const IndexName: string): Boolean; overload;
    function DropIndex(const SchemaName: string; const TableName: string; const IndexName: string): Boolean; overload;
    procedure CreateForeignKey(const Foreignkey: TDBXMetaDataForeignKey);
    function DropForeignKey(const TableName: string; const ForeignKey: string): Boolean; overload;
    function DropForeignKey(const SchemaName: string; const TableName: string; const ForeignKey: string): Boolean; overload;
    function QuoteIdentifierIfNeeded(const Identifier: string): string;
    function GetCollection(const MetaDataCommand: string): TDBXTable;
    procedure ToMemoryStorage(const Table: TDBXDelegateTable);
    function MakeCreateTableSql(const Table: TDBXTablesTableStorage; const Columns: TDBXColumnsTableStorage): string;
    function MakeCreateTableSqlWithIndex(const Table: TDBXTablesTableStorage; const Columns: TDBXColumnsTableStorage; const Indexes: TDBXIndexesTableStorage; const IndexColumns: TDBXIndexColumnsTableStorage): string;
    function MakeAlterTableSql(const Table: TDBXTablesTableStorage; const Columns: TDBXColumnsTableStorage): string; overload;
    function MakeDropTableSql(const Table: TDBXTablesTableStorage): string;
    function MakeCreateIndexSql(const Indexes: TDBXIndexesTableStorage; const Columns: TDBXIndexColumnsTableStorage): string;
    function MakeDropIndexSql(const Indexes: TDBXIndexesTableStorage): string;
    function MakeCreateForeignKeySql(const ForeignKeys: TDBXForeignKeysTableStorage; const Columns: TDBXForeignKeyColumnsTableStorage): string;
    function MakeDropForeignKeySql(const ForeignKey: TDBXForeignKeysTableStorage): string;
    function MakeAlterTableSql(const Indexes: TDBXIndexesTableStorage; const Columns: TDBXIndexColumnsTableStorage): string; overload;
    function IsCatalogsSupported: Boolean;
    function IsSchemasSupported: Boolean;
    function IsMultipleStatementsSupported: Boolean;
    function IsDescendingIndexSupported: Boolean;
    function IsDescendingIndexColumnsSupported: Boolean;
    function IsMixedDDLAndDMLSupported: Boolean;
    function IsDDLTransactionsSupported: Boolean;
    property Vendor: string read GetVendor;
    property DatabaseProduct: string read GetDatabaseProduct;
    property DatabaseVersion: string read GetDatabaseVersion;
    property IdentifierQuotePrefix: string read GetIdentifierQuotePrefix;
    property IdentifierQuoteSuffix: string read GetIdentifierQuoteSuffix;
    property Writer: TDBXMetaDataWriter read GetWriter;
  end;

  TDBXMetaDataTable = class
  private
    FTable: TDBXTablesTableStorage;
    FColumns: TDBXColumnsTableStorage;
    FColumnCount: Integer;
    FMetaDataColumns: TObjectList<TDBXMetaDataColumn>;
    procedure UpdateColumnOrdinals;
  protected
    function GetCatalogName: string;
    procedure SetCatalogName(const CatalogName: string);
    function GetSchemaName: string;
    procedure SetSchemaName(const SchemaName: string);
    function GetTableName: string;
    procedure SetTableName(const TableName: string);
  public
    constructor Create; overload;
    constructor Create(const AReader: TDBXReader); overload;
    destructor Destroy; override;
    procedure AddColumn(const Column: TDBXMetaDataColumn);
    procedure InsertColumn(const Column: TDBXMetaDataColumn; const Ordinal: Integer);
    procedure RemoveColumn(const Column: TDBXMetaDataColumn);
    function GetColumn(const Ordinal: Integer): TDBXMetaDataColumn;
    property TableStorage: TDBXTablesTableStorage read FTable;
    property ColumnsStorage: TDBXColumnsTableStorage read FColumns;
    property CatalogName: string read GetCatalogName write SetCatalogName;
    property SchemaName: string read GetSchemaName write SetSchemaName;
    property TableName: string read GetTableName write SetTableName;
  end;

  TDBXObjectColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string);
  end;

  TDBXProductNames = class
  public
    const DatasnapProduct = 'Datasnap';
    const Db2_Product = 'Db2';
    const FirebirdProduct = 'Firebird';
    const InformixProduct = 'Informix Dynamic Server';
    const InterbaseProduct = 'InterBase';
    const MsSqlProduct = 'Microsoft SQL Server';
    const MySqlProduct = 'MySQL';
    const OdbcProduct = 'Odbc';
    const OracleProduct = 'Oracle';
    const SqliteProduct = 'Sqlite';
    const SybaseAsaProduct = 'Adaptive Server Anywhere';
    const SybaseAseProduct = 'Sybase SQL Server';
  end;

  TDBXSingleColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string);
  end;

  TDBXSqlExecution = class
  private
    [Weak]FContext: TDBXProviderContext;
  public
    constructor Create(const Writer: TDBXMetaDataWriter);
    procedure Execute(const Sql: string); virtual;
  end;

  TDBXTimeColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string);
  end;

  TDBXTimestampColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string);
  end;

  TDBXUInt16Column = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string);
  end;

  TDBXUInt32Column = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string);
  end;

  TDBXUInt64Column = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string);
  end;

  TDBXUInt8Column = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string);
  end;

  TDBXUnicodeCharColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const Name: string; const InPrecision: Integer);
  end;

  TDBXUnicodeLongColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const Name: string);
  end;

  TDBXUnicodeVarCharColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string; const InPrecision: Integer);
  end;

  TDBXVarBinaryColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const InName: string; const InPrecision: Integer);
  end;

  TDBXWideVarCharColumn = class(TDBXMetaDataColumn)
  public
    constructor Create(const Name: string; const InPrecision: Integer);
  end;

implementation

uses
  Data.DBXCommonResStrs,
  Data.DBXPlatform,
  Data.DBXMetaDataNames,
  Data.DBXTableFactory,
  System.SysUtils;

constructor TDBXMetaDataColumn.Create;
begin
  inherited Create;
  FNullable := True;
  FColumnIndex := -1;
end;

constructor TDBXMetaDataColumn.Create(const Column: TDBXMetaDataColumn);
begin
  inherited Create;
  FColumnIndex := -1;
  self.FColumnName := Column.FColumnName;
  self.FDefaultValue := Column.FDefaultValue;
  self.FDataType := Column.FDataType;
  self.FPrecision := Column.FPrecision;
  self.FScale := Column.FScale;
  self.FMaxInline := Column.FMaxInline;
  self.FUnsigned := Column.FUnsigned;
  self.FAutoIncrement := Column.FAutoIncrement;
  self.FNullable := Column.FNullable;
  self.FFixedLength := Column.FFixedLength;
  self.FUnicodeString := Column.FUnicodeString;
  self.FBlob := Column.FBlob;
end;

procedure TDBXMetaDataColumn.SetAutoIncrement(const Value: Boolean);
begin
  CopyColumnPropertyToTableStorage(TDBXColumnsIndex.IsAutoIncrement, Value);
  FAutoIncrement := Value;
end;

procedure TDBXMetaDataColumn.SetBlob(const Value: Boolean);
begin
  CopyColumnPropertyToTableStorage(TDBXColumnsIndex.IsLong, Value);
  FBlob := Value;
end;

procedure TDBXMetaDataColumn.SetColumnName(const Value: string);
begin
  CopyColumnPropertyToTableStorage(TDBXColumnsIndex.ColumnName, Value);
  FColumnName := Value;
end;

procedure TDBXMetaDataColumn.SetDataType(const Value: Integer);
begin
  CopyColumnPropertyToTableStorage(TDBXColumnsIndex.DbxDataType, Value);
  FDataType := Value;
end;

procedure TDBXMetaDataColumn.SetDefaultValue(const Value: string);
begin
  CopyColumnPropertyToTableStorage(TDBXColumnsIndex.DefaultValue, Value);
  FDefaultValue := Value;
end;

procedure TDBXMetaDataColumn.SetFixedLength(const Value: Boolean);
begin
  CopyColumnPropertyToTableStorage(TDBXColumnsIndex.IsFixedLength, Value);
  FFixedLength := Value;
end;

procedure TDBXMetaDataColumn.SetMaxInline(const Value: Integer);
begin
  CopyColumnPropertyToTableStorage(TDBXColumnsIndex.MaxInline, Value);
  FMaxInline := Value;
end;

procedure TDBXMetaDataColumn.SetNullable(const Value: Boolean);
begin
  CopyColumnPropertyToTableStorage(TDBXColumnsIndex.IsNullable, Value);
  FNullable := Value;
end;

procedure TDBXMetaDataColumn.SetPrecision(const Value: Int64);
begin
  CopyColumnPropertyToTableStorage(TDBXColumnsIndex.Precision, Value);
  FPrecision := Value;
end;

procedure TDBXMetaDataColumn.SetScale(const Value: Integer);
begin
  CopyColumnPropertyToTableStorage(TDBXColumnsIndex.Scale, Value);
  FScale := Value;
end;

procedure TDBXMetaDataColumn.SetTypeName(const Value: string);
begin
  CopyColumnPropertyToTableStorage(TDBXColumnsIndex.TypeName, Value);
  FTypeName := Value;
end;

procedure TDBXMetaDataColumn.SetUnicodeString(const Value: Boolean);
begin
  CopyColumnPropertyToTableStorage(TDBXColumnsIndex.IsUnicode, Value);
  FUnicodeString := Value;
end;

procedure TDBXMetaDataColumn.SetUnsigned(const Value: Boolean);
begin
  CopyColumnPropertyToTableStorage(TDBXColumnsIndex.IsUnsigned, Value);
  FUnsigned := Value;
end;

procedure TDBXMetaDataColumn.CopyColumnPropertyToTableStorage(
  const AColumnIndex: Integer; const ANewValue: Variant);
begin
  if FColumnStorage = nil then
    Exit;

  if FColumnStorage.FindStringKey(TDBXColumnsIndex.Ordinal, IntToStr(FColumnIndex)) then
  begin
    FColumnStorage.Edit;
    try
      case AColumnIndex of
        TDBXColumnsIndex.CatalogName: FColumnStorage.CatalogName := ANewValue;
        TDBXColumnsIndex.SchemaName: FColumnStorage.SchemaName := ANewValue;
        TDBXColumnsIndex.TableName: FColumnStorage.TableName := ANewValue;
        TDBXColumnsIndex.ColumnName: FColumnStorage.ColumnName := ANewValue;
        TDBXColumnsIndex.TypeName: FColumnStorage.TypeName := ANewValue;
        TDBXColumnsIndex.Precision: FColumnStorage.Precision := ANewValue;
        TDBXColumnsIndex.Scale: FColumnStorage.Scale := ANewValue;
        TDBXColumnsIndex.Ordinal: FColumnStorage.ColumnOrdinal := ANewValue;
        TDBXColumnsIndex.DefaultValue: FColumnStorage.DefaultValue := ANewValue;
        TDBXColumnsIndex.IsNullable: FColumnStorage.Nullable := ANewValue;
        TDBXColumnsIndex.IsAutoIncrement: FColumnStorage.AutoIncrement := ANewValue;
        TDBXColumnsIndex.MaxInline: FColumnStorage.MaxInline := ANewValue;
        TDBXColumnsIndex.DbxDataType: FColumnStorage.DbxDataType := ANewValue;
        TDBXColumnsIndex.IsFixedLength: FColumnStorage.FixedLength := ANewValue;
        TDBXColumnsIndex.IsUnicode: FColumnStorage.Unicode := ANewValue;
        TDBXColumnsIndex.IsLong: FColumnStorage.Long := ANewValue;
        TDBXColumnsIndex.IsUnsigned: FColumnStorage.Unsigned := ANewValue;
        else raise TDBXError.Create(Format(SUnexpectedIndex, [AColumnIndex]));
      end;
    finally
      FColumnStorage.Post;
    end;
  end;
end;

procedure TDBXMetaDataColumn.CopyColumnToTableStorage(const Columns: TDBXColumnsTableStorage);
begin
  Columns.ColumnName := FColumnName;
  Columns.Precision := FPrecision;
  Columns.Scale := FScale;
  Columns.DefaultValue := FDefaultValue;
  Columns.Long := FBlob;
  Columns.Nullable := FNullable;
  Columns.AutoIncrement := FAutoIncrement;
  Columns.MaxInline := FMaxInline;
  Columns.DbxDataType := FDataType;
  Columns.FixedLength := FFixedLength;
  Columns.Unicode := FUnicodeString;
  Columns.Unsigned := FUnsigned;
end;

constructor TDBXInt8Column.Create(const InName: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.Int8Type;
  ColumnName := InName;
end;

constructor TDBXInt64Column.Create(const InName: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.Int64Type;
  ColumnName := InName;
end;

constructor TDBXInt32Column.Create(const InName: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.Int32Type;
  ColumnName := InName;
end;

constructor TDBXInt16Column.Create(const InName: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.Int16Type;
  ColumnName := InName;
end;

constructor TDBXDoubleColumn.Create(const InName: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.DoubleType;
  ColumnName := InName;
end;

constructor TDBXDecimalColumn.Create(const InName: string; const InPrecision: Integer; const InScale: Integer);
begin
  inherited Create;
  DataType := TDBXDataTypes.BcdType;
  ColumnName := InName;
  Precision := InPrecision;
  Scale := InScale;
end;

constructor TDBXDateColumn.Create(const InName: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.DateType;
  ColumnName := InName;
end;

constructor TDBXBooleanColumn.Create(const InName: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.BooleanType;
  ColumnName := InName;
end;

constructor TDBXBinaryLongColumn.Create(const Name: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.BlobType;
  Long := True;
  ColumnName := Name;
  Precision := 80000;
end;

constructor TDBXBinaryColumn.Create(const InName: string; const InPrecision: Integer);
begin
  inherited Create;
  DataType := TDBXDataTypes.BytesType;
  FixedLength := True;
  ColumnName := InName;
  Precision := InPrecision;
  FixedLength := True;
end;

constructor TDBXAnsiVarCharColumn.Create(const Name: string; const InPrecision: Integer);
begin
  inherited Create;
  DataType := TDBXDataTypes.AnsiStringType;
  Long := False;
  FixedLength := False;
  ColumnName := Name;
  Precision := InPrecision;
end;

constructor TDBXAnsiLongColumn.Create(const Name: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.AnsiStringType;
  Long := True;
  ColumnName := Name;
  Precision := 80000;
end;

constructor TDBXAnsiCharColumn.Create(const Name: string; const InPrecision: Integer);
begin
  inherited Create;
  DataType := TDBXDataTypes.AnsiStringType;
  Long := False;
  FixedLength := True;
  ColumnName := Name;
  Precision := InPrecision;
end;

constructor TDBXMetaDataForeignKey.Create;
begin
  inherited Create;
  FForeignkey := TDBXForeignKeysTableStorage.Create;
  FColumns := TDBXForeignKeyColumnsTableStorage.Create;
  FForeignkey.Insert;
  FForeignkey.Post;
end;

destructor TDBXMetaDataForeignKey.Destroy;
begin
  FreeAndNil(FForeignkey);
  FreeAndNil(FColumns);
  inherited Destroy;
end;

constructor TDBXMetaDataForeignKey.Create(const InForeignTableName: string; const InPrimaryTableName: string;
  const InForeignKeyName: string; References: array of string);
var
  Index: Integer;
begin
  Create;
  TableName := InForeignTableName;
  PrimaryTableName := InPrimaryTableName;
  ForeignKeyName := InForeignKeyName;
  Index := 0;
  while Index < Length(References) do
  begin
    AddReference(References[Index], References[Index + 1]);
    Index := Index + 2;
  end;
end;

function TDBXMetaDataForeignKey.GetForeignKeyColumnsStorage: TDBXForeignKeyColumnsTableStorage;
begin
  FColumns.First;
  while FColumns.InBounds do
  begin
    FColumns.PrimaryCatalogName := FPrimaryCatalogName;
    FColumns.PrimarySchemaName := FPrimarySchemaName;
    FColumns.PrimaryTableName := FPrimaryTableName;
    FColumns.Next;
  end;
  Result := FColumns;
end;

function TDBXMetaDataForeignKey.GetCatalogName: string;
begin
  Result := FForeignkey.CatalogName;
end;

procedure TDBXMetaDataForeignKey.SetCatalogName(const CatalogName: string);
begin
  FForeignkey.CatalogName := CatalogName;
end;

function TDBXMetaDataForeignKey.GetSchemaName: string;
begin
  Result := FForeignkey.SchemaName;
end;

procedure TDBXMetaDataForeignKey.SetSchemaName(const SchemaName: string);
begin
  FForeignkey.SchemaName := SchemaName;
end;

function TDBXMetaDataForeignKey.GetTableName: string;
begin
  Result := FForeignkey.TableName;
end;

procedure TDBXMetaDataForeignKey.SetTableName(const TableName: string);
begin
  FForeignkey.TableName := TableName;
end;

function TDBXMetaDataForeignKey.GetForeignKeyName: string;
begin
  Result := FForeignkey.ForeignKeyName;
end;

procedure TDBXMetaDataForeignKey.SetForeignKeyName(const ForeignKeyName: string);
begin
  FForeignkey.ForeignKeyName := ForeignKeyName;
end;

procedure TDBXMetaDataForeignKey.AddReference(const ColumnName: string; const ColumnNameInPrimaryTable: string);
begin
  IncrAfter(FColumnCount);
  FColumns.Insert;
  FColumns.ColumnOrdinal := FColumnCount;
  FColumns.ColumnName := ColumnName;
  FColumns.PrimaryColumnName := ColumnNameInPrimaryTable;
  FColumns.Post;
end;

constructor TDBXMetaDataIndex.Create;
begin
  inherited Create;
  FIndexes := TDBXIndexesTableStorage.Create;
  FColumns := TDBXIndexColumnsTableStorage.Create;
  FIndexes.Insert;
  FIndexes.Post;
end;

destructor TDBXMetaDataIndex.Destroy;
begin
  FreeAndNil(FIndexes);
  FreeAndNil(FColumns);
  inherited Destroy;
end;

constructor TDBXMetaDataIndex.Create(const InTableName: string; const InIndexName: string;
  Columns: array of string);
var
  Index: Integer;
begin
  Create;
  TableName := InTableName;
  IndexName := InIndexName;
  for Index := 0 to Length(Columns) - 1 do
    AddColumn(Columns[Index]);
end;

function TDBXMetaDataIndex.GetCatalogName: string;
begin
  Result := FIndexes.CatalogName;
end;

procedure TDBXMetaDataIndex.SetCatalogName(const CatalogName: string);
begin
  FIndexes.CatalogName := CatalogName;
end;

function TDBXMetaDataIndex.GetSchemaName: string;
begin
  Result := FIndexes.SchemaName;
end;

procedure TDBXMetaDataIndex.SetSchemaName(const SchemaName: string);
begin
  FIndexes.SchemaName := SchemaName;
end;

function TDBXMetaDataIndex.GetTableName: string;
begin
  Result := FIndexes.TableName;
end;

procedure TDBXMetaDataIndex.SetTableName(const TableName: string);
begin
  FIndexes.TableName := TableName;
end;

function TDBXMetaDataIndex.GetIndexName: string;
begin
  Result := FIndexes.IndexName;
end;

procedure TDBXMetaDataIndex.SetIndexName(const IndexName: string);
begin
  FIndexes.IndexName := IndexName;
end;

function TDBXMetaDataIndex.IsUnique: Boolean;
begin
  Result := FIndexes.Unique;
end;

procedure TDBXMetaDataIndex.SetUnique(const Unique: Boolean);
begin
  FIndexes.Unique := Unique;
end;

procedure TDBXMetaDataIndex.AddColumn(const ColumnName: string);
begin
  AddColumn(ColumnName, True);
end;

procedure TDBXMetaDataIndex.AddColumn(const ColumnName: string; const Ascending: Boolean);
begin
  IncrAfter(FColumnCount);
  FColumns.Insert;
  FColumns.ColumnOrdinal := FColumnCount;
  FColumns.ColumnName := ColumnName;
  FColumns.Ascending := Ascending;
  FColumns.Post;
end;

constructor TDBXMetaDataProvider.Create;
begin
  inherited Create;
end;

destructor TDBXMetaDataProvider.Destroy;
begin
  FreeAndNil(FExecuter);
  FreeAndNil(FWriter);
  inherited Destroy;
end;

procedure TDBXMetaDataProvider.AlterTable(const Table: TDBXMetaDataTable);
var
  Sql: string;
begin
  Sql := MakeAlterTableSql(Table.TableStorage, Table.ColumnsStorage);
  FExecuter.Execute(Sql);
end;

procedure TDBXMetaDataProvider.SetWriter(const Writer: TDBXMetaDataWriter);
begin
  self.FWriter := Writer;
  self.FExecuter := TDBXSqlExecution.Create(Writer);
end;

function TDBXMetaDataProvider.GetWriter: TDBXMetaDataWriter;
begin
  Result := self.FWriter;
end;

function TDBXMetaDataProvider.GetVendor: string;
begin
  Result := FWriter.MetaDataReader.ProductName;
end;

function TDBXMetaDataProvider.CheckColumnSupported(const Column: TDBXMetaDataColumn): Boolean;
var
  Storage: TDBXColumnsTableStorage;
  Supported: Boolean;
begin
  Storage := TDBXColumnsTableStorage.Create;
  try
    Storage.Insert;
    Column.CopyColumnToTableStorage(Storage);
    Storage.Post;
    Supported := FWriter.CheckColumnSupported(Storage);
  finally
    FreeAndNil(Storage);
  end;
  Result := Supported;
end;

procedure TDBXMetaDataProvider.Execute(const Sql: string);
begin
  FExecuter.Execute(Sql);
end;

procedure TDBXMetaDataProvider.CreateTable(const Table: TDBXMetaDataTable);
var
  Sql: string;
begin
  Sql := MakeCreateTableSql(Table.TableStorage, Table.ColumnsStorage);
  FExecuter.Execute(Sql);
end;

procedure TDBXMetaDataProvider.CreateTableWithIndex(
  const Table: TDBXMetaDataTable; const Index: TDBXMetaDataIndex);
var
  Sql: string;
begin
  Sql := MakeCreateTableSqlWithIndex(Table.TableStorage, Table.ColumnsStorage, Index.IndexesStorage, Index.IndexColumnsStorage);
  FExecuter.Execute(Sql);
end;

function TDBXMetaDataProvider.DropTable(const SchemaName: string; const TableName: string): Boolean;
var
  Storage: TDBXTable;
  Builder: TStringBuilder;
  Success: Boolean;
  Tables: TDBXTablesTableStorage;
  Sql: string;
begin
  Builder := TStringBuilder.Create;
  try
    Success := False;
    Builder.Append('GetTables ');
    if not SchemaName.IsEmpty then
    begin
      FWriter.MakeSqlIdentifier(Builder, SchemaName);
      Builder.Append('.');
    end;
    FWriter.MakeSqlIdentifier(Builder, TableName);
    Storage := GetCollection(Builder.ToString);
    try
      Tables := TDBXTablesTableStorage(Storage);
      ToMemoryStorage(Tables);
      if Tables.First and not Tables.Next then
      begin
        if Tables.First then
        begin
          Sql := MakeDropTableSql(Tables);
          Execute(Sql);
          Success := True;
        end;
      end;
      Result := Success;
    finally
      Storage.Free;
    end;
  finally
    Builder.Free;
  end;
end;

function TDBXMetaDataProvider.DropTable(const TableName: string): Boolean;
begin
  Result := DropTable(NullString, TableName);
end;

procedure TDBXMetaDataProvider.CreatePrimaryKey(const Index: TDBXMetaDataIndex);
var
  Indexes: TDBXIndexesTableStorage;
begin
  Index.Unique := True;
  Indexes := Index.IndexesStorage;
  Indexes.Primary := True;
  CreateIndex(Index);
end;

procedure TDBXMetaDataProvider.CreateUniqueIndex(const Index: TDBXMetaDataIndex);
begin
  Index.Unique := True;
  CreateIndex(Index);
end;

procedure TDBXMetaDataProvider.CreateIndex(const Index: TDBXMetaDataIndex);
var
  Sql: string;
begin
  Sql := MakeCreateIndexSql(Index.IndexesStorage, Index.IndexColumnsStorage);
  FExecuter.Execute(Sql);
end;

function TDBXMetaDataProvider.DropIndex(const TableName: string; const IndexName: string): Boolean;
begin
  Result := DropIndex(NullString, TableName, IndexName);
end;

function TDBXMetaDataProvider.DropIndex(const SchemaName: string; const TableName: string; const IndexName: string): Boolean;
var
  Storage: TDBXTable;
  Builder: TStringBuilder;
  Success: Boolean;
  Indexes: TDBXIndexesTableStorage;
  Sql: string;
begin
  Builder := TStringBuilder.Create;
  try
    Success := False;
    Builder.Append('GetIndexes ');
    if not SchemaName.IsEmpty then
    begin
      FWriter.MakeSqlIdentifier(Builder, SchemaName);
      Builder.Append('.');
    end;
    FWriter.MakeSqlIdentifier(Builder, TableName);
    Storage := GetCollection(Builder.ToString);
    try
      Indexes := TDBXIndexesTableStorage(Storage);
      ToMemoryStorage(Indexes);
      Indexes.First;
      while Indexes.InBounds do
      begin
        if (not IndexName.IsEmpty) and (IndexName = Indexes.IndexName) then
        begin
          Sql := MakeDropIndexSql(Indexes);
          Execute(Sql);
          Success := True;
        end;
        Indexes.Next;
      end;
      Result := Success;
    finally
      Storage.Free;
    end;
  finally
    Builder.Free;
  end;
end;

procedure TDBXMetaDataProvider.CreateForeignKey(const Foreignkey: TDBXMetaDataForeignKey);
var
  Sql: string;
begin
  Sql := MakeCreateForeignKeySql(Foreignkey.ForeignKeysStorage, Foreignkey.ForeignKeyColumnsStorage);
  FExecuter.Execute(Sql);
end;

function TDBXMetaDataProvider.DropForeignKey(const TableName: string; const ForeignKey: string): Boolean;
begin
  Result := DropForeignKey(NullString, TableName, ForeignKey);
end;

function TDBXMetaDataProvider.DropForeignKey(const SchemaName: string; const TableName: string; const ForeignKey: string): Boolean;
var
  Storage: TDBXTable;
  Builder: TStringBuilder;
  Success: Boolean;
  ForeignKeys: TDBXForeignKeysTableStorage;
  Sql: string;
begin
  Builder := TStringBuilder.Create;
  try
    Success := False;
    Builder.Append('GetForeignKeys ');
    if not SchemaName.IsEmpty then
    begin
      FWriter.MakeSqlIdentifier(Builder, SchemaName);
      Builder.Append('.');
    end;
    FWriter.MakeSqlIdentifier(Builder, TableName);
    Storage := GetCollection(Builder.ToString);
    try
      ForeignKeys := TDBXForeignKeysTableStorage(Storage);
      ToMemoryStorage(ForeignKeys);
      if (not ForeignKey.IsEmpty) or (ForeignKeys.First and not ForeignKeys.Next) then
      begin
        ForeignKeys.First;
        while ForeignKeys.InBounds do
        begin
          if (ForeignKey.IsEmpty) or (ForeignKey = ForeignKeys.ForeignKeyName) then
          begin
            Sql := MakeDropForeignKeySql(ForeignKeys);
            Execute(Sql);
            Success := True;
          end;
          ForeignKeys.Next;
        end;
      end;
      Result := Success;
    finally
      Storage.Free;
    end;
  finally
    Builder.Free;
  end;
end;

function TDBXMetaDataProvider.QuoteIdentifierIfNeeded(const Identifier: string): string;
var
  Builder: TStringBuilder;
  Id: string;
begin
  Builder := TStringBuilder.Create;
  try
    FWriter.MakeSqlIdentifier(Builder, Identifier);
    Id := Builder.ToString;
  finally
    FreeAndNil(Builder);
  end;
  Result := Id;
end;

function TDBXMetaDataProvider.GetCollection(const MetaDataCommand: string): TDBXTable;
var
  Table: TDBXTable;
  Name: string;
begin
  Table := FWriter.MetaDataReader.FetchCollection(MetaDataCommand);
  if Table = nil then
    Exit(nil);
  Name := Table.DBXTableName;
  if (Name = TDBXMetaDataCollectionName.DataTypes) then
    Exit(TDBXDataTypesTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.Catalogs) then
    Exit(TDBXCatalogsTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.Schemas) then
    Exit(TDBXSchemasTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.Tables) then
    Exit(TDBXTablesTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.Views) then
    Exit(TDBXViewsTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.Synonyms) then
    Exit(TDBXSynonymsTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.Columns) then
    Exit(TDBXColumnsTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.Indexes) then
    Exit(TDBXIndexesTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.IndexColumns) then
    Exit(TDBXIndexColumnsTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.ForeignKeys) then
    Exit(TDBXForeignKeysTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.ForeignKeyColumns) then
    Exit(TDBXForeignKeyColumnsTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.Procedures) then
    Exit(TDBXProceduresTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.ProcedureSources) then
    Exit(TDBXProcedureSourcesTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.ProcedureParameters) then
    Exit(TDBXProcedureParametersTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.Packages) then
    Exit(TDBXPackagesTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.PackageSources) then
    Exit(TDBXPackageSourcesTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.Users) then
    Exit(TDBXUsersTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.Roles) then
    Exit(TDBXRolesTableStorage.Create(Table));
  if (Name = TDBXMetaDataCollectionName.ReservedWords) then
    Exit(TDBXReservedWordsTableStorage.Create(Table));
  Result := nil;
end;

procedure TDBXMetaDataProvider.ToMemoryStorage(const Table: TDBXDelegateTable);
var
  Storage: TDBXTable;
begin
  if Table.Storage = nil then
  begin
    Storage := TDBXTableFactory.CreateDBXTable;
    Storage.DBXTableName := Table.DBXTableName;
    Storage.Columns := Table.CopyColumns;
    Storage.CopyFrom(Table);
    Storage.AcceptChanges;
    Storage := Table.ReplaceStorage(Storage);
    Storage.Close;
    FreeAndNil(Storage);
  end;
end;

function TDBXMetaDataProvider.MakeCreateTableSql(const Table: TDBXTablesTableStorage; const Columns: TDBXColumnsTableStorage): string;
var
  Builder: TStringBuilder;
  Sql: string;
begin
  Builder := TStringBuilder.Create;
  try
    FWriter.MakeSqlCreate(Builder, Table, Columns);
    Sql := Builder.ToString;
  finally
    FreeAndNil(Builder);
  end;
  Result := Sql;
end;

function TDBXMetaDataProvider.MakeCreateTableSqlWithIndex(
  const Table: TDBXTablesTableStorage; const Columns: TDBXColumnsTableStorage;
  const Indexes: TDBXIndexesTableStorage;
  const IndexColumns: TDBXIndexColumnsTableStorage): string;
var
  Builder: TStringBuilder;
  Sql: string;
begin
  Builder := TStringBuilder.Create;
  try
    FWriter.MakeSqlCreate(Builder, Table, Columns, nil, nil, nil, nil, Indexes, IndexColumns, nil, nil);
    Sql := Builder.ToString;
  finally
    FreeAndNil(Builder);
  end;
  Result := Sql;
end;

function TDBXMetaDataProvider.MakeAlterTableSql(const Table: TDBXTablesTableStorage; const Columns: TDBXColumnsTableStorage): string;
var
  Builder: TStringBuilder;
  Sql: string;
begin
  Builder := TStringBuilder.Create;
  try
    FWriter.MakeSqlAlter(Builder, Table, Columns);
    Sql := Builder.ToString;
  finally
    FreeAndNil(Builder);
  end;
  Result := Sql;
end;

function TDBXMetaDataProvider.MakeDropTableSql(const Table: TDBXTablesTableStorage): string;
var
  Builder: TStringBuilder;
  Sql: string;
begin
  Builder := TStringBuilder.Create;
  try
    FWriter.MakeSqlDrop(Builder, Table);
    Sql := Builder.ToString;
  finally
    FreeAndNil(Builder);
  end;
  Result := Sql;
end;

function TDBXMetaDataProvider.MakeCreateIndexSql(const Indexes: TDBXIndexesTableStorage; const Columns: TDBXIndexColumnsTableStorage): string;
var
  Builder: TStringBuilder;
  Sql: string;
begin
  Builder := TStringBuilder.Create;
  try
    FWriter.MakeSqlCreate(Builder, Indexes, Columns);
    Sql := Builder.ToString;
  finally
    FreeAndNil(Builder);
  end;
  Result := Sql;
end;

function TDBXMetaDataProvider.MakeDropIndexSql(const Indexes: TDBXIndexesTableStorage): string;
var
  Builder: TStringBuilder;
  Sql: string;
begin
  Builder := TStringBuilder.Create;
  try
    FWriter.MakeSqlDrop(Builder, Indexes);
    Sql := Builder.ToString;
  finally
    FreeAndNil(Builder);
  end;
  Result := Sql;
end;

function TDBXMetaDataProvider.MakeCreateForeignKeySql(const ForeignKeys: TDBXForeignKeysTableStorage; const Columns: TDBXForeignKeyColumnsTableStorage): string;
var
  Builder: TStringBuilder;
  Sql: string;
begin
  Builder := TStringBuilder.Create;
  try
    FWriter.MakeSqlCreate(Builder, ForeignKeys, Columns);
    Sql := Builder.ToString;
  finally
    FreeAndNil(Builder);
  end;
  Result := Sql;
end;

function TDBXMetaDataProvider.MakeDropForeignKeySql(const ForeignKey: TDBXForeignKeysTableStorage): string;
var
  Builder: TStringBuilder;
  Sql: string;
begin
  Builder := TStringBuilder.Create;
  try
    FWriter.MakeSqlDrop(Builder, ForeignKey);
    Sql := Builder.ToString;
  finally
    FreeAndNil(Builder);
  end;
  Result := Sql;
end;

function TDBXMetaDataProvider.MakeAlterTableSql(const Indexes: TDBXIndexesTableStorage; const Columns: TDBXIndexColumnsTableStorage): string;
var
  Builder: TStringBuilder;
  Sql: string;
begin
  Builder := TStringBuilder.Create;
  try
    FWriter.MakeSqlAlter(Builder, Indexes, Columns);
    Sql := Builder.ToString;
  finally
    FreeAndNil(Builder);
  end;
  Result := Sql;
end;

function TDBXMetaDataProvider.GetDatabaseProduct: string;
begin
  Result := FWriter.MetaDataReader.ProductName;
end;

function TDBXMetaDataProvider.GetDatabaseVersion: string;
begin
  Result := FWriter.MetaDataReader.Version;
end;

function TDBXMetaDataProvider.GetIdentifierQuotePrefix: string;
begin
  Result := FWriter.MetaDataReader.SqlIdentifierQuotePrefix;
end;

function TDBXMetaDataProvider.GetIdentifierQuoteSuffix: string;
begin
  Result := FWriter.MetaDataReader.SqlIdentifierQuoteSuffix;
end;

function TDBXMetaDataProvider.IsCatalogsSupported: Boolean;
begin
  Result := FWriter.CatalogsSupported;
end;

function TDBXMetaDataProvider.IsSchemasSupported: Boolean;
begin
  Result := FWriter.SchemasSupported;
end;

function TDBXMetaDataProvider.IsMultipleStatementsSupported: Boolean;
begin
  Result := FWriter.MultipleStatementsSupported;
end;

function TDBXMetaDataProvider.IsDescendingIndexSupported: Boolean;
begin
  Result := FWriter.MetaDataReader.DescendingIndexSupported;
end;

function TDBXMetaDataProvider.IsDescendingIndexColumnsSupported: Boolean;
begin
  Result := FWriter.MetaDataReader.DescendingIndexColumnsSupported;
end;

function TDBXMetaDataProvider.IsMixedDDLAndDMLSupported: Boolean;
begin
  Result := FWriter.Mixed_DDL_DML_Supported;
end;

function TDBXMetaDataProvider.IsDDLTransactionsSupported: Boolean;
begin
  Result := FWriter.DDLTransactionsSupported;
end;

constructor TDBXMetaDataTable.Create;
begin
  inherited Create;
  FTable := TDBXTablesTableStorage.Create;
  FColumns := TDBXColumnsTableStorage.Create;
  FMetaDataColumns := TObjectList<TDBXMetaDataColumn>.Create;
  FTable.Insert;
  FTable.Post;
  FTable.AcceptChanges;
end;

constructor TDBXMetaDataTable.Create(const AReader: TDBXReader);
var
  LColumn: TDBXMetaDataColumn;
  I: Integer;
begin
  Create;
  ColumnsStorage.CopyFrom(AReader);
  if ColumnsStorage.First then
  begin
    I := 1;
    repeat
      TableName := ColumnsStorage.TableName;
      SchemaName := ColumnsStorage.SchemaName;
      CatalogName := ColumnsStorage.CatalogName;
      LColumn := TDBXMetaDataColumn.Create;
      try
        LColumn.ColumnName := ColumnsStorage.ColumnName;
        LColumn.DataType := ColumnsStorage.DbxDataType;
        LColumn.Unsigned := ColumnsStorage.Unsigned;
        LColumn.DefaultValue := ColumnsStorage.DefaultValue;
        LColumn.AutoIncrement := ColumnsStorage.AutoIncrement;
        LColumn.MaxInline := ColumnsStorage.MaxInline;
        LColumn.Nullable := ColumnsStorage.Nullable;
        LColumn.Precision := ColumnsStorage.Precision;
        LColumn.FixedLength := ColumnsStorage.FixedLength;
        LColumn.Scale := ColumnsStorage.Scale;
        LColumn.Long := ColumnsStorage.Long;
        LColumn.UnicodeString := ColumnsStorage.Unicode;
        LColumn.FColumnStorage := ColumnsStorage;
        LColumn.FColumnIndex := I;
        Inc(I);
        FMetaDataColumns.Add(LColumn);
      except
        LColumn.Free;
        raise;
      end;
    until not ColumnsStorage.Next;
  end;
  ColumnsStorage.AcceptChanges;
end;

destructor TDBXMetaDataTable.Destroy;
begin
  FMetaDataColumns.Free;
  FreeAndNil(FTable);
  FreeAndNil(FColumns);
  inherited Destroy;
end;

function TDBXMetaDataTable.GetCatalogName: string;
begin
  Result := FTable.CatalogName;
end;

procedure TDBXMetaDataTable.SetCatalogName(const CatalogName: string);
begin
  FTable.CatalogName := CatalogName;
end;

function TDBXMetaDataTable.GetSchemaName: string;
begin
  Result := FTable.SchemaName;
end;

procedure TDBXMetaDataTable.SetSchemaName(const SchemaName: string);
begin
  FTable.SchemaName := SchemaName;
end;

function TDBXMetaDataTable.GetTableName: string;
begin
  Result := FTable.TableName;
end;

procedure TDBXMetaDataTable.SetTableName(const TableName: string);
begin
  FTable.TableName := TableName;
end;

procedure TDBXMetaDataTable.UpdateColumnOrdinals;
var
  LColumn: TDBXMetaDataColumn;
begin
  for LColumn in FMetaDataColumns do
    LColumn.FColumnIndex := FMetaDataColumns.IndexOf(LColumn)+1; // 1-based index used in TDBXColumnsColumn.Ordinal
end;

procedure TDBXMetaDataTable.InsertColumn(const Column: TDBXMetaDataColumn; const Ordinal: Integer);
begin
  Column.FColumnStorage := FColumns;

  FColumns.Insert(Ordinal);
  Inc(FColumnCount);
  FColumns.ColumnOrdinal := FColumnCount;
  Column.CopyColumnToTableStorage(FColumns);
  FColumns.Post;

  FMetaDataColumns.Insert(Ordinal, Column);
  UpdateColumnOrdinals;
end;

procedure TDBXMetaDataTable.RemoveColumn(const Column: TDBXMetaDataColumn);
begin
  if FMetaDataColumns.Contains(Column) then
  begin
    FColumns.DeleteRow(FMetaDataColumns.IndexOf(Column));
    FMetaDataColumns.Remove(Column);
    UpdateColumnOrdinals;
  end;
end;

procedure TDBXMetaDataTable.AddColumn(const Column: TDBXMetaDataColumn);
begin
  InsertColumn(Column, FMetaDataColumns.Count);
end;

function TDBXMetaDataTable.GetColumn(const Ordinal: Integer): TDBXMetaDataColumn;
begin
  if FMetaDataColumns = nil then
    Exit(nil);
  if FMetaDataColumns.Count > Ordinal then
    Result := FMetaDataColumns.Items[Ordinal]
  else
    Result := nil;
end;

constructor TDBXObjectColumn.Create(const InName: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.ObjectType;
  ColumnName := InName;
end;

constructor TDBXSingleColumn.Create(const InName: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.SingleType;
  ColumnName := InName;
end;

constructor TDBXSqlExecution.Create(const Writer: TDBXMetaDataWriter);
begin
  inherited Create;
  FContext := Writer.Context;
end;

procedure TDBXSqlExecution.Execute(const Sql: string);
var
  Statement: string;
  Index, Start: Integer;
  Storage: TDBXTable;
begin
  Statement := NullString;
  Start := 0;
  Index := Sql.IndexOf(';');
  while Index >= 0 do
  begin
    Statement := Sql.Substring(Start, Index - Start);
    Statement := Statement.Trim;
    if Statement.Length > 0 then
    begin
      Storage := FContext.ExecuteQuery(Statement, nil, nil);
      Storage.Free;
    end;
    Start := Index + 1;
    Index := Sql.IndexOf(';', Start);
  end;
  Statement := Sql.Substring(Start, Sql.Length - Start);
  Statement := Statement.Trim;
  if Statement.Length > 0 then
    FContext.ExecuteQuery(Statement, nil, nil);
end;

constructor TDBXTimeColumn.Create(const InName: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.TimeType;
  ColumnName := InName;
end;

constructor TDBXTimestampColumn.Create(const InName: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.TimeStampType;
  ColumnName := InName;
end;

constructor TDBXUInt16Column.Create(const InName: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.UInt16Type;
  ColumnName := InName;
  Unsigned := True;
end;

constructor TDBXUInt32Column.Create(const InName: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.UInt32Type;
  ColumnName := InName;
  Unsigned := True;
end;

constructor TDBXUInt64Column.Create(const InName: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.UInt64Type;
  ColumnName := InName;
  Unsigned := True;
end;

constructor TDBXUInt8Column.Create(const InName: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.UInt8Type;
  ColumnName := InName;
  Unsigned := True;
end;

constructor TDBXUnicodeCharColumn.Create(const Name: string; const InPrecision: Integer);
begin
  inherited Create;
  DataType := TDBXDataTypes.WideStringType;
  Long := False;
  FixedLength := True;
  ColumnName := Name;
  UnicodeString := True;
  Precision := InPrecision;
end;

constructor TDBXUnicodeLongColumn.Create(const Name: string);
begin
  inherited Create;
  DataType := TDBXDataTypes.WideStringType;
  Long := True;
  UnicodeString := True;
  ColumnName := Name;
  Precision := 80000;
end;

constructor TDBXUnicodeVarCharColumn.Create(const InName: string; const InPrecision: Integer);
begin
  inherited Create;
  DataType := TDBXDataTypes.WideStringType;
  Long := False;
  FixedLength := False;
  ColumnName := InName;
  UnicodeString := True;
  Precision := InPrecision;
end;

constructor TDBXVarBinaryColumn.Create(const InName: string; const InPrecision: Integer);
begin
  inherited Create;
  DataType := TDBXDataTypes.VarBytesType;
  ColumnName := InName;
  Precision := InPrecision;
end;

constructor TDBXWideVarCharColumn.Create(const Name: string; const InPrecision: Integer);
begin
  inherited Create;
  DataType := TDBXDataTypes.WideStringType;
  Long := False;
  FixedLength := False;
  ColumnName := Name;
  Precision := InPrecision;
end;

end.
