{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXMetaDataWriter;

interface

uses
  Data.DBXCommon,
  Data.DBXCommonTable,
  Data.DBXMetaDataReader,
  Data.DBXPlatform,
  System.SysUtils;

type
  TDBXAlterTableOperation = class
  public
    const NoSupport = 0;
    const RenameTable = 1;
    const RenameTableTo = 2;
    const DropColumn = 4;
    const AddColumn = 8;
    const AddColumnWithPosition = 16;
    const ChangeDefaultValue = 32;
    const DropDefaultValue = 64;
    const SetNullable = 128;
    const DropNullable = 256;
    const ChangeColumnType = 512;
    const AddAutoincrement = 1024;
    const DropAutoincrement = 2048;
    const ChangeColumnPosition = 4096;
    const RenameColumn = 8192;
    const FullAlterSupport = 16383;
  end;

  TDBXMetaDataWriter = class abstract
  public
    procedure Open; virtual; abstract;
    procedure MakeSqlCreate(const Buffer: TStringBuilder; const Item: TDBXTableRow; const Parts: TDBXTable); overload; virtual; abstract;
    procedure MakeSqlCreate(const Buffer: TStringBuilder;
      const TableItem: TDBXTableRow; const TableParts: TDBXTable;
      const ViewItem: TDBXTableRow; const ViewParts: TDBXTable;
      const SynonymItem: TDBXTableRow; const SynonymParts: TDBXTable;
      const IndexesItem: TDBXTableRow; const IndexesParts: TDBXTable;
      const ForeignKeysItem: TDBXTableRow; const ForeignKeysParts: TDBXTable); overload; virtual; abstract;
    procedure MakeSqlAlter(const Buffer: TStringBuilder; const Item: TDBXTableRow; const Parts: TDBXTable); virtual; abstract;
    procedure MakeSqlDrop(const Buffer: TStringBuilder; const Item: TDBXTableRow); virtual; abstract;
    procedure MakeSqlIdentifier(const Buffer: TStringBuilder; const Identifier: string); virtual; abstract;
    function CheckColumnSupported(const Column: TDBXTableRow): Boolean; virtual; abstract;
    function GetSqlQuotedIdentifier(const UnquotedIdentifier: string): string; virtual; abstract;
    function GetSqlUnQuotedIdentifier(const QuotedIdentifier: string): string; virtual; abstract;
  protected
    procedure SetContext(const Context: TDBXProviderContext); virtual; abstract;
    function GetContext: TDBXProviderContext; virtual; abstract;
    function GetMetaDataReader: TDBXMetaDataReader; virtual; abstract;
    function GetSqlRenameTable: string; virtual; abstract;
    function GetSqlAutoIncrementInserts: string; virtual; abstract;
    function GetSqlAutoIncrementKeyword: string; virtual; abstract;
    function GetSqlKeyGeneratedIndexName: string; virtual; abstract;
    function GetAlterTableSupport: Integer; virtual; abstract;
    function IsCatalogsSupported: Boolean; virtual; abstract;
    function IsSchemasSupported: Boolean; virtual; abstract;
    function IsMultipleStatementsSupported: Boolean; virtual; abstract;
    function IsIndexNamesGlobal: Boolean; virtual; abstract;
    function IsDescendingIndexConstraintsSupported: Boolean; virtual; abstract;
    function IsSerializedIsolationSupported: Boolean; virtual; abstract;
    function IsDDLTransactionsSupported: Boolean; virtual; abstract;
    function IsMixed_DDL_DML_Supported: Boolean; virtual; abstract;
  public
    property Context: TDBXProviderContext read GetContext write SetContext;
    property MetaDataReader: TDBXMetaDataReader read GetMetaDataReader;
    property SqlRenameTable: string read GetSqlRenameTable;
    property SqlAutoIncrementInserts: string read GetSqlAutoIncrementInserts;
    property SqlAutoIncrementKeyword: string read GetSqlAutoIncrementKeyword;
    property SqlKeyGeneratedIndexName: string read GetSqlKeyGeneratedIndexName;
    property AlterTableSupport: Integer read GetAlterTableSupport;
    property CatalogsSupported: Boolean read IsCatalogsSupported;
    property SchemasSupported: Boolean read IsSchemasSupported;
    property MultipleStatementsSupported: Boolean read IsMultipleStatementsSupported;
    property IndexNamesGlobal: Boolean read IsIndexNamesGlobal;
    property DescendingIndexConstraintsSupported: Boolean read IsDescendingIndexConstraintsSupported;
    property SerializedIsolationSupported: Boolean read IsSerializedIsolationSupported;
    property DDLTransactionsSupported: Boolean read IsDDLTransactionsSupported;
    property Mixed_DDL_DML_Supported: Boolean read IsMixed_DDL_DML_Supported;
  end;

  TDBXBaseMetaDataWriter = class(TDBXMetaDataWriter)
  public
    procedure Open; override;
    destructor Destroy; override;
    procedure MakeSqlCreate(const Buffer: TStringBuilder; const Item: TDBXTableRow; const Parts: TDBXTable); overload; override;
    procedure MakeSqlCreate(const Buffer: TStringBuilder;
      const TableItem: TDBXTableRow; const TableParts: TDBXTable;
      const ViewItem: TDBXTableRow; const ViewParts: TDBXTable;
      const SynonymItem: TDBXTableRow; const SynonymParts: TDBXTable;
      const IndexesItem: TDBXTableRow; const IndexesParts: TDBXTable;
      const ForeignKeysItem: TDBXTableRow; const ForeignKeysParts: TDBXTable); overload; override;
    procedure MakeSqlAlter(const Buffer: TStringBuilder; const Item: TDBXTableRow; const Parts: TDBXTable); override;
    procedure MakeSqlDrop(const Buffer: TStringBuilder; const Item: TDBXTableRow); override;
    function CheckColumnSupported(const Column: TDBXTableRow): Boolean; override;
    function GetSqlQuotedIdentifier(const UnquotedIdentifier: string): string; override;
    function GetSqlUnQuotedIdentifier(const QuotedIdentifier: string): string; override;
    procedure MakeSqlIdentifier(const Buffer: TStringBuilder; const Identifier: string); override;
  protected
    procedure SetContext(const Context: TDBXProviderContext); override;
    function GetContext: TDBXProviderContext; override;
    function GetMetaDataReader: TDBXMetaDataReader; override;
    function IsCatalogsSupported: Boolean; override;
    function IsSchemasSupported: Boolean; override;
    function IsMultipleStatementsSupported: Boolean; override;
    function IsIndexNamesGlobal: Boolean; override;
    function IsDescendingIndexConstraintsSupported: Boolean; override;
    function IsSerializedIsolationSupported: Boolean; override;
    function IsDDLTransactionsSupported: Boolean; override;
    function IsMixed_DDL_DML_Supported: Boolean; override;
    function GetAlterTableSupport: Integer; override;
    function GetSqlAutoIncrementKeyword: string; override;
    function GetSqlKeyGeneratedIndexName: string; override;
    function GetSqlAutoIncrementInserts: string; override;
    function GetSqlRenameTable: string; override;
    procedure MakeSqlObjectName(const Buffer: TStringBuilder; const CatalogName: string; const SchemaName: string; const ObjectName: string); virtual;
    procedure MakeSqlNullable(const Buffer: TStringBuilder; const Column: TDBXTableRow); virtual;
    procedure MakeSqlDataType(const Buffer: TStringBuilder; const TypeName: string; const ColumnRow: TDBXTableRow); overload; virtual;
    procedure MakeSqlDataType(const Buffer: TStringBuilder; const DataType: TDBXDataTypeDescription; const ColumnRow: TDBXTableRow; const Overrides: TDBXInt32s); overload; virtual;
    function FindDataType(const InTypeName: string; const ColumnRow: TDBXTableRow; const Overrides: TDBXInt32s): TDBXDataTypeDescription; virtual;
    function FindTypeName(const ColumnRow: TDBXTableRow; const Overrides: TDBXInt32s; const FailIfNotFound: Boolean): string; virtual;
    function FindSimpleColumnTypeMatch(const ColumnRow: TDBXTableRow; const FailIfNotFound: Boolean): string; virtual;
    function FindBooleanTypeName(const ColumnRow: TDBXTableRow; const Overrides: TDBXInt32s; const FailIfNotFound: Boolean): string; virtual;
    function FindStringOrBinaryTypeName(const ColumnRow: TDBXTableRow; const FailIfNotFound: Boolean): string; virtual;
    function FindIntegerTypeName(const ColumnRow: TDBXTableRow; const Overrides: TDBXInt32s; const FailIfNotFound: Boolean): string; virtual;
    function FindDecimalTypeName(const ColumnRow: TDBXTableRow; const FailIfNotFound: Boolean): string; virtual;
    function FindFloatTypeName(const ColumnRow: TDBXTableRow; const Overrides: TDBXInt32s; const FailIfNotFound: Boolean): string; virtual;
    function FindDateTimeTypeName(const ColumnRow: TDBXTableRow; const FailIfNotFound: Boolean): string; virtual;
    procedure MakeSqlColumnTypeCast(const Buffer: TStringBuilder; const Column: TDBXTable); virtual;
    function CanCreateIndexAsKey(const Index: TDBXTableRow; const IndexColumns: TDBXTable): Boolean; virtual;
    procedure MakeSqlCreateIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow; const IndexColumns: TDBXTable); virtual;
    procedure MakeSqlDropIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow); virtual;
    procedure MakeSqlCreateKey(const Buffer: TStringBuilder; const Index: TDBXTableRow; const IndexColumns: TDBXTable); virtual;
    procedure MakeSqlConstraintName(const Buffer: TStringBuilder; const Constraint: TDBXTableRow);
    procedure MakeSqlAlterTablePrefix(const Buffer: TStringBuilder; const Item: TDBXTableRow); virtual;
    procedure MakeSqlCreateIndexColumnList(const Buffer: TStringBuilder; const IndexColumns: TDBXTable); virtual;
    procedure MakeSqlDropSecondaryIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow); virtual;
    procedure MakeSqlForeignKeySyntax(const Buffer: TStringBuilder; const ForeignKey: TDBXTableRow; const ForeignKeyColumns: TDBXTable);
    procedure MakeSqlCreateForeignKey(const Buffer: TStringBuilder; const ForeignKey: TDBXTableRow; const ForeignKeyColumns: TDBXTable); virtual;
    procedure MakeSqlDropForeignKey(const Buffer: TStringBuilder; const ForeignKey: TDBXTableRow); virtual;
  private
    procedure MakeSqlCreateTable(const Buffer: TStringBuilder; const Table: TDBXTableRow; const Columns: TDBXTable);
    procedure MakeSqlCreateTableWithIndex(const Buffer: TStringBuilder; const Table: TDBXTableRow; const Columns: TDBXTable; const Index: TDBXTableRow; const IndexColumns: TDBXTable);
    procedure MakeSqlAlterTable(const Buffer: TStringBuilder; const Table: TDBXTableRow; const Columns: TDBXTable);
    function SupportedTableAlteration(const Operation: Integer): Boolean;
    function MakeSqlFullAlterTable(const Buffer: TStringBuilder; const Table: TDBXTableRow; const Columns: TDBXTable): Boolean;
    function MakeSqlTableRename(const Buffer: TStringBuilder; const CatalogName: string; const SchemaName: string; const TableName: string; const OldCatalogName: string; const OldSchemaName: string; const OldTableName: string): Boolean; overload;
    function MakeSqlColumnRename(const Buffer: TStringBuilder; const ColumnName: string; const CatalogName: string; const SchemaName: string; const TableName: string; const OldColumnName: string): Boolean;
    procedure MakeSqlColumnDefinition(const Buffer: TStringBuilder; const Column: TDBXTableRow);
    procedure MakeSqlDefaultValue(const Buffer: TStringBuilder; const DefaultValue: string; const TypeName: string);
    function RemoveMarkersForNullValues(const InFormat: string; const Values: TDBXStringArray): string;
    function ErrorTypeNameNotFound(const ColumnRow: TDBXTableRow): Exception;
    function CalcPrecisionColumnType(const ColumnType: Integer; const UnsignedOption: Boolean): Integer;
    function CalcDecimalPrecision(const ColumnType: Integer): Integer;
    function CalcBinaryPrecision(const ColumnType: Integer): Integer;
    function IsSignedInteger(const ColumnType: Integer): Boolean;
    function GetDefaultFloatPrecision(const ColumnType: Integer): Integer;
    function AddToExternalStatements(const InExternalStatements: TStringBuilder; const Buffer: TStringBuilder; const StartPosition: Integer): TStringBuilder;
    function IsValidSqlIdentifier(const Identifier: string): Boolean;
    function IsReservedWord(const Identifier: string): Boolean;
    function IsLetter(const Ch: WideChar; const UpperOK: Boolean; const LowerOK: Boolean): Boolean;
    function IsDigit(const Ch: WideChar): Boolean;
    procedure MakeSqlTableReplacement(const Buffer: TStringBuilder; const Table: TDBXTableRow; const Columns: TDBXTable);
    function CopyColumns(const ColumnTable: TDBXTable): TDBXTable;
    function CopyTable(const Table: TDBXTableRow; const TempTableName: string): TDBXTable;
    function ComputeColumnMap(const Columns: TDBXTable): TDBXProperties;
    function GetDefaults(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable;
    function GetIndexes(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable;
    function GetIndexColumns(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable;
    function GetForeignKeyColumns(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable;
    procedure RemoveForeignKeyGeneratedIndexes(const Table: TDBXTableRow; const Indexes: TDBXTable; const IndexColumns: TDBXTable; const ForeignKeyColumns: TDBXTable);
    procedure DropAllConstraints(const Buffer: TStringBuilder; const Defaults: TDBXTable; const Indexes: TDBXTable; const ForeignKeys: TDBXTable);
    procedure CreateTempOutputTable(const Buffer: TStringBuilder; const Table: TDBXTableRow; const Columns: TDBXTable; const TempTableName: string);
    procedure SetIdentityInsert(const Buffer: TStringBuilder; const CatalogName: string; const SchemaName: string; const TableName: string; const bOn: Boolean);
    function CheckForAutoIncrement(const Columns: TDBXTable): Boolean;
    procedure InsertValuesFromOldTable(const Buffer: TStringBuilder; const Table: TDBXTableRow; const Columns: TDBXTable; const TempTableName: string);
    procedure MakeSqlDropTable(const Buffer: TStringBuilder; const Table: TDBXTableRow);
    procedure ReplaceParameter(const Buffer: TStringBuilder; const Start: Integer; const InParameter: string; const Replacement: string);
    procedure MakeSqlTableRename(const Buffer: TStringBuilder; const CatalogName: string; const SchemaName: string; const TableName: string; const NewTableName: string); overload;
    procedure CopyRow(const Source: TDBXTableRow; const Target: TDBXTable; const Columns: Integer);
    function Compare(const Table: TDBXTable; const InStart: Integer; const Row: TDBXTableRow; const InRowStart: Integer; const Columns: Integer): Boolean;
    function SameConstraint(const Table: TDBXTable; const Row: TDBXTableRow; const Columns: Integer): Boolean;
    procedure MapTable(const Item: TDBXTable; const Table: TDBXTableRow);
    function MapColumn(const Parts: TDBXTable; const Table: TDBXTableRow; const ColumnMap: TDBXProperties; const ColIndex: Integer; const IdColumns: Integer; const DroppedColumn: string): string;
    procedure CreateConstraints(const Buffer: TStringBuilder; const Columns: TDBXValueTypeArray; const Constraints: TDBXTable; const ConstraintColumns: TDBXTable; const CollectionName: string; const IdColumns: Integer; const ItemColumns: Integer; const PartColumns: Integer; const Table: TDBXTableRow; const ColumnMap: TDBXProperties; const ColIndex1: Integer; const ColIndex2: Integer);
    procedure CreateIndices(const Buffer: TStringBuilder; const Table: TDBXTableRow; const Indexes: TDBXTable; const IndexColumns: TDBXTable; const ColumnMap: TDBXProperties);
    procedure CreateForeignKeys(const Buffer: TStringBuilder; const Table: TDBXTableRow; const ForeignKeyColumns: TDBXTable; const ColumnMap: TDBXProperties);
    procedure MakeSqlCreateSecondaryIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow; const IndexColumns: TDBXTable);
    procedure MakeSqlCreateConstraint(const Buffer: TStringBuilder; const Constraint: TDBXTableRow);
    procedure MakeSqlDropConstraint(const Buffer: TStringBuilder; const Constraint: TDBXTableRow);
    procedure MakeSqlCreateView(const Buffer: TStringBuilder; const View: TDBXTableRow; const Columns: TDBXTable);
    procedure MakeSqlAlterView(const Buffer: TStringBuilder; const View: TDBXTableRow; const Columns: TDBXTable);
    procedure MakeSqlDropView(const Buffer: TStringBuilder; const View: TDBXTableRow);
    procedure MakeSqlCreateSynonym(const Buffer: TStringBuilder; const Synonym: TDBXTableRow; const Columns: TDBXTable);
    procedure MakeSqlAlterSynonym(const Buffer: TStringBuilder; const Synonym: TDBXTableRow; const Columns: TDBXTable);
    procedure MakeSqlDropSynonym(const Buffer: TStringBuilder; const Synonym: TDBXTableRow);
  protected
    [Weak]FContext: TDBXProviderContext;
    FReader: TDBXBaseMetaDataReader;
    FReservedWords: TDBXTable;
  private
    const Requirement = 1000;
    const Desireable = 100;
    const TieBreaker1 = 1;
    const TieBreaker2 = 2;
    const TieBreaker3 = 4;
    const TieBreaker4 = 8;
    const TieBreaker5 = 16;
    const TieBreaker6 = 32;
  end;

  TDBXSQL = class
  public
    const Add = 'ADD';
    const Alter = 'ALTER';
    const cAs = 'AS';
    const Binary = 'BINARY';
    const Cast = 'CAST';
    const Char = 'CHAR';
    const CloseBrace = '}';
    const CloseParen = ')';
    const Colon = ':';
    const Column = 'COLUMN';
    const Comma = ',';
    const Constraint = 'CONSTRAINT';
    const Convert = 'CONVERT';
    const Create = 'CREATE';
    const CurrentTimestamp = 'CURRENT_TIMESTAMP';
    const Date = 'DATE';
    const Datetime = 'DATETIME';
    const Decimal = 'DECIMAL';
    const Default = 'DEFAULT';
    const Descending = 'DESC';
    const Dot = '.';
    const DoubleQuote = '"';
    const Drop = 'DROP';
    const Empty = '';
    const cFor = 'FOR';
    const Foreign = 'FOREIGN';
    const From = 'FROM';
    const cFunction = 'FUNCTION';
    const Index = 'INDEX';
    const Insert = 'INSERT';
    const Into = 'INTO';
    const Key = 'KEY';
    const LineComment = '//';
    const Makedate = 'MAKEDATE';
    const Nl = #$a;
    const cNot = 'NOT';
    const Nullable = 'NULL';
    const Off = 'OFF';
    const cOn = 'ON';
    const OpenBrace = '{';
    const OpenParen = '(';
    const Position = 'POSITION';
    const Primary = 'PRIMARY';
    const Proc = 'PROCEDURE';
    const Quote = '''';
    const References = 'REFERENCES';
    const Rename = 'RENAME';
    const Result = 'RESULT';
    const Returns = 'RETURNS';
    const Select = 'SELECT';
    const Semicolon = ';';
    const cSet = 'SET';
    const Signed = 'SIGNED';
    const Space = ' ';
    const Spacing = '  ';
    const Synonym = 'SYNONYM';
    const Table = 'TABLE';
    const Temp = 'TEMP_';
    const Time = 'TIME';
    const cTo = 'TO';
    const cType = 'TYPE';
    const FYear = 'year';
    const Unique = 'UNIQUE';
    const View = 'VIEW';
  end;

implementation

uses
  Data.DBXMetaDataNames,
  Data.DBXMetaDataUtil,
  System.StrUtils,
  Data.DBXCommonResStrs
{$IFDEF MACOS}
  , Macapi.CoreFoundation
{$ENDIF MACOS}
;

procedure TDBXBaseMetaDataWriter.Open;
begin
end;

destructor TDBXBaseMetaDataWriter.Destroy;
begin
  FreeAndNil(FReservedWords);
  FreeAndNil(FReader);
  inherited Destroy;
end;

procedure TDBXBaseMetaDataWriter.SetContext(const Context: TDBXProviderContext);
begin
  FContext := Context;
  if FReader <> nil then
    FReader.Context := Context;
end;

function TDBXBaseMetaDataWriter.GetContext: TDBXProviderContext;
begin
  Result := FContext;
end;

function TDBXBaseMetaDataWriter.GetMetaDataReader: TDBXMetaDataReader;
begin
  Result := FReader;
end;

procedure TDBXBaseMetaDataWriter.MakeSqlCreate(const Buffer: TStringBuilder; const Item: TDBXTableRow; const Parts: TDBXTable);
var
  CollectionName: string;
begin
  CollectionName := Item.DBXTableName;
  if (CollectionName = TDBXMetaDataCollectionName.Tables) then
    MakeSqlCreateTable(Buffer, Item, Parts)
  else if (CollectionName = TDBXMetaDataCollectionName.Views) then
    MakeSqlCreateView(Buffer, Item, Parts)
  else if (CollectionName = TDBXMetaDataCollectionName.Synonyms) then
    MakeSqlCreateSynonym(Buffer, Item, Parts)
  else if (CollectionName = TDBXMetaDataCollectionName.Indexes) then
    MakeSqlCreateIndex(Buffer, Item, Parts)
  else if (CollectionName = TDBXMetaDataCollectionName.ForeignKeys) then
    MakeSqlCreateForeignKey(Buffer, Item, Parts)
  else
    raise Exception.Create(SUnsupportedOperation);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlCreate(const Buffer: TStringBuilder;
  const TableItem: TDBXTableRow; const TableParts: TDBXTable;
  const ViewItem: TDBXTableRow; const ViewParts: TDBXTable;
  const SynonymItem: TDBXTableRow; const SynonymParts: TDBXTable;
  const IndexesItem: TDBXTableRow; const IndexesParts: TDBXTable;
  const ForeignKeysItem: TDBXTableRow; const ForeignKeysParts: TDBXTable);

  function CollectionName(Item: TDBXTableRow): string;
  begin
    Result := Item.DBXTableName;
  end;
begin
  if (TableItem <> nil) and (CollectionName(TableItem) = TDBXMetaDataCollectionName.Tables) then
  begin
    if (IndexesItem <> nil) and (CollectionName(IndexesItem) = TDBXMetaDataCollectionName.Indexes) then
      MakeSqlCreateTableWithIndex(Buffer, TableItem, TableParts, IndexesItem, IndexesParts)
    else
      MakeSqlCreate(Buffer, TableItem, TableParts);
  end
  else if (IndexesItem <> nil) and (CollectionName(IndexesItem) = TDBXMetaDataCollectionName.Indexes) then
    MakeSqlCreate(Buffer, IndexesItem, IndexesParts);

  if ViewItem <> nil then
    MakeSqlCreate(Buffer, ViewItem, ViewParts);
  if SynonymItem <> nil then
    MakeSqlCreate(Buffer, SynonymItem, SynonymParts);
  if ForeignKeysItem <> nil then
    MakeSqlCreate(Buffer, ForeignKeysItem, ForeignKeysParts);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlAlter(const Buffer: TStringBuilder; const Item: TDBXTableRow; const Parts: TDBXTable);
var
  CollectionName: string;
begin
  CollectionName := Item.DBXTableName;
  if (CollectionName = TDBXMetaDataCollectionName.Tables) then
    MakeSqlAlterTable(Buffer, Item, Parts)
  else if (CollectionName = TDBXMetaDataCollectionName.Views) then
    MakeSqlAlterView(Buffer, Item, Parts)
  else if (CollectionName = TDBXMetaDataCollectionName.Synonyms) then
    MakeSqlAlterSynonym(Buffer, Item, Parts)
  else if (CollectionName = TDBXMetaDataCollectionName.Indexes) then
  begin
    MakeSqlDropIndex(Buffer, Item.OriginalRow);
    MakeSqlCreateIndex(Buffer, Item, Parts);
  end
  else if (CollectionName = TDBXMetaDataCollectionName.ForeignKeys) then
  begin
    MakeSqlDropForeignKey(Buffer, Item.OriginalRow);
    MakeSqlCreateForeignKey(Buffer, Item, Parts);
  end
  else 
    raise Exception.Create(SUnsupportedOperation);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlDrop(const Buffer: TStringBuilder; const Item: TDBXTableRow);
var
  CollectionName: string;
begin
  CollectionName := Item.DBXTableName;
  if (CollectionName = TDBXMetaDataCollectionName.Tables) then
    MakeSqlDropTable(Buffer, Item)
  else if (CollectionName = TDBXMetaDataCollectionName.Views) then
    MakeSqlDropView(Buffer, Item)
  else if (CollectionName = TDBXMetaDataCollectionName.Synonyms) then
    MakeSqlDropSynonym(Buffer, Item)
  else if (CollectionName = TDBXMetaDataCollectionName.Indexes) then
    MakeSqlDropIndex(Buffer, Item)
  else if (CollectionName = TDBXMetaDataCollectionName.ForeignKeys) then
    MakeSqlDropForeignKey(Buffer, Item)
  else
    raise Exception.Create(SUnsupportedOperation);
end;

function TDBXBaseMetaDataWriter.CheckColumnSupported(const Column: TDBXTableRow): Boolean;
begin
  Result := (not FindTypeName(Column, nil, False).IsEmpty);
end;

function TDBXBaseMetaDataWriter.IsCatalogsSupported: Boolean;
begin
  Result := False;
end;

function TDBXBaseMetaDataWriter.IsSchemasSupported: Boolean;
begin
  Result := True;
end;

function TDBXBaseMetaDataWriter.IsMultipleStatementsSupported: Boolean;
begin
  Result := False;
end;

function TDBXBaseMetaDataWriter.IsIndexNamesGlobal: Boolean;
begin
  Result := False;
end;

function TDBXBaseMetaDataWriter.IsDescendingIndexConstraintsSupported: Boolean;
begin
  Result := True;
end;

function TDBXBaseMetaDataWriter.IsSerializedIsolationSupported: Boolean;
begin
  Result := True;
end;

function TDBXBaseMetaDataWriter.IsDDLTransactionsSupported: Boolean;
begin
  Result := True;
end;

function TDBXBaseMetaDataWriter.IsMixed_DDL_DML_Supported: Boolean;
begin
  Result := True;
end;

function TDBXBaseMetaDataWriter.GetAlterTableSupport: Integer;
begin
  Result := TDBXAlterTableOperation.NoSupport;
end;

function TDBXBaseMetaDataWriter.GetSqlAutoIncrementKeyword: string;
begin
  Result := NullString;
end;

function TDBXBaseMetaDataWriter.GetSqlKeyGeneratedIndexName: string;
begin
  Result := NullString;
end;

function TDBXBaseMetaDataWriter.GetSqlQuotedIdentifier(const UnquotedIdentifier: string): string;
begin
  Result := TDBXMetaDataUtil.QuoteIdentifier(UnquotedIdentifier, FReader.SqlIdentifierQuoteChar, FReader.SqlIdentifierQuotePrefix, FReader.SqlIdentifierQuoteSuffix);
end;

function TDBXBaseMetaDataWriter.GetSqlUnQuotedIdentifier(const QuotedIdentifier: string): string;
begin
  Result := TDBXMetaDataUtil.UnquotedIdentifier(QuotedIdentifier, FReader.SqlIdentifierQuoteChar, FReader.SqlIdentifierQuotePrefix, FReader.SqlIdentifierQuoteSuffix);
end;

function TDBXBaseMetaDataWriter.GetSqlAutoIncrementInserts: string;
begin
  Result := NullString;
end;

function TDBXBaseMetaDataWriter.GetSqlRenameTable: string;
begin
  Result := NullString;
end;

procedure TDBXBaseMetaDataWriter.MakeSqlCreateTable(const Buffer: TStringBuilder; const Table: TDBXTableRow; const Columns: TDBXTable);
var
  Separator: string;
  SecondSeparator: string;
  CurrentColumns: TDBXTable;
begin
  Buffer.Append(TDBXSQL.Create);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.Table);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlObjectName(Buffer, Table.Value[TDBXTablesIndex.CatalogName].GetWideString(NullString), Table.Value[TDBXTablesIndex.SchemaName].GetWideString(NullString), Table.Value[TDBXTablesIndex.TableName].GetWideString(NullString));
  Buffer.Append(TDBXSQL.OpenParen);
  Separator := TDBXSQL.Nl + TDBXSQL.Spacing;
  SecondSeparator := TDBXSQL.Comma + TDBXSQL.Nl + TDBXSQL.Spacing;
  CurrentColumns := Columns.CreateTableView(TDBXColumnsColumns.Ordinal);
  CurrentColumns.First;
  while CurrentColumns.InBounds do
  begin
    Buffer.Append(Separator);
    MakeSqlColumnDefinition(Buffer, CurrentColumns);
    Separator := SecondSeparator;
    CurrentColumns.Next;
  end;
  FreeAndNil(CurrentColumns);
  Buffer.Append(TDBXSQL.CloseParen);
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlCreateTableWithIndex(
  const Buffer: TStringBuilder; const Table: TDBXTableRow;
  const Columns: TDBXTable; const Index: TDBXTableRow;
  const IndexColumns: TDBXTable);
var
  Separator: string;
  SecondSeparator: string;
  CurrentColumns: TDBXTable;
  LPrimary: Boolean;
  LIndexName: string;
begin
  LPrimary := Index.Value[TDBXIndexesIndex.IsPrimary].GetBoolean(False);
  LIndexName := IndexColumns.Value[TDBXIndexColumnsIndex.ColumnName].GetString;
  Buffer.Append(TDBXSQL.Create);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.Table);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlObjectName(Buffer, Table.Value[TDBXTablesIndex.CatalogName].GetWideString(NullString), Table.Value[TDBXTablesIndex.SchemaName].GetWideString(NullString), Table.Value[TDBXTablesIndex.TableName].GetWideString(NullString));
  Buffer.Append(TDBXSQL.OpenParen);
  Separator := TDBXSQL.Nl + TDBXSQL.Spacing;
  SecondSeparator := TDBXSQL.Comma + TDBXSQL.Nl + TDBXSQL.Spacing;
  CurrentColumns := Columns.CreateTableView(TDBXColumnsColumns.Ordinal);
  CurrentColumns.First;
  while CurrentColumns.InBounds do
  begin
    Buffer.Append(Separator);
    MakeSqlColumnDefinition(Buffer, CurrentColumns);
    if LPrimary and (CurrentColumns.Value[TDBXColumnsIndex.ColumnName].GetString = LIndexName) then
    begin
      Buffer.Append(TDBXSQL.Space);
      Buffer.Append(TDBXSQL.Primary);
      Buffer.Append(TDBXSQL.Space);
      Buffer.Append(TDBXSQL.Key);
    end;
    Separator := SecondSeparator;
    CurrentColumns.Next;
  end;
  FreeAndNil(CurrentColumns);
  Buffer.Append(TDBXSQL.CloseParen);
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlAlterTable(const Buffer: TStringBuilder; const Table: TDBXTableRow; const Columns: TDBXTable);
var
  Original: TDBXTableRow;
  CatalogName: string;
  SchemaName: string;
  TableName: string;
  ColumnMap: TDBXProperties;
  Defaults: TDBXTable;
  ForeignKeyColumns: TDBXTable;
  Indexes: TDBXTable;
  IndexColumns: TDBXTable;
  UseTransaction: Boolean;
  FullAlterTable: Boolean;
  Marker: Integer;
begin
                                                                                         
//      Blackfish, MSSQL, and ASA.
  Original := Table.OriginalRow;
  CatalogName := Original.Value[TDBXTablesIndex.CatalogName].GetWideString(NullString);
  SchemaName := Original.Value[TDBXTablesIndex.SchemaName].GetWideString(NullString);
  TableName := Original.Value[TDBXTablesIndex.TableName].GetWideString(NullString);
  ColumnMap := ComputeColumnMap(Columns);
  Defaults := GetDefaults(CatalogName, SchemaName, TableName);
  ForeignKeyColumns := GetForeignKeyColumns(CatalogName, SchemaName, TableName);
  UseTransaction := SerializedIsolationSupported;
  if UseTransaction then
    FContext.StartSerializedTransaction;
  try
    Indexes := GetIndexes(CatalogName, SchemaName, TableName);
    IndexColumns := GetIndexColumns(CatalogName, SchemaName, TableName);
    if UseTransaction then
      FContext.Commit;
    UseTransaction := False;
  finally
    if UseTransaction then
      FContext.Rollback;
  end;
  RemoveForeignKeyGeneratedIndexes(Table, Indexes, IndexColumns, ForeignKeyColumns);
  DropAllConstraints(Buffer, Defaults, Indexes, ForeignKeyColumns);
  Buffer.Append(TDBXSQL.Nl);
  FullAlterTable := (AlterTableSupport <> TDBXAlterTableOperation.NoSupport);
  if FullAlterTable then
  begin
    Marker := Buffer.Length;
    FullAlterTable := MakeSqlFullAlterTable(Buffer, Table, Columns);
    if not FullAlterTable then
      Buffer.Length := Marker;
  end;
  if not FullAlterTable then
    MakeSqlTableReplacement(Buffer, Table, Columns);
  Buffer.Append(TDBXSQL.Nl);
  CreateIndices(Buffer, Table, Indexes, IndexColumns, ColumnMap);
  CreateForeignKeys(Buffer, Table, ForeignKeyColumns, ColumnMap);
  FreeAndNil(Indexes);
  FreeAndNil(IndexColumns);
  FreeAndNil(Defaults);
  FreeAndNil(ForeignKeyColumns);
  FreeAndNil(ColumnMap);
end;

function TDBXBaseMetaDataWriter.SupportedTableAlteration(const Operation: Integer): Boolean;
var
  Support: Integer;
begin
  Support := AlterTableSupport;
  Result := ((Support and Operation) = Operation);
end;

function TDBXBaseMetaDataWriter.MakeSqlFullAlterTable(const Buffer: TStringBuilder; const Table: TDBXTableRow; const Columns: TDBXTable): Boolean;
var
  MarkerA, MarkerAlterTableFirst, MarkerAlterTableStart, MarkerB, MarkerChangeColumnFirstChange, MarkerChangeColumnStart: Integer;
  LInline: Boolean;
  Original, OriginalTable: TDBXTableRow;
  ExternalStatements: TStringBuilder;
  AutoIncrementWord, DefaultValue, SecondSeparator, Separator: string;
  Deleted, Inserted, Modified: TDBXTable;
begin
  OriginalTable := Table.OriginalRow;
  ExternalStatements := nil;
  MarkerAlterTableStart := Buffer.Length;
  MakeSqlAlterTablePrefix(Buffer, OriginalTable);
  MarkerAlterTableFirst := Buffer.Length;
  Separator := TDBXSQL.Nl + TDBXSQL.Spacing;
  SecondSeparator := TDBXSQL.Comma + TDBXSQL.Nl + TDBXSQL.Spacing;
  Deleted := Columns.DeletedRows;
  Deleted.First;
  while Deleted.InBounds do
  begin
    if SupportedTableAlteration(TDBXAlterTableOperation.DropColumn) then
    begin
      Buffer.Append(Separator);
      Buffer.Append(TDBXSQL.Drop);
  //      buffer.append(SQL.SPACE);    Not supported by Interbase
  //      buffer.append(SQL.COLUMN);
      Buffer.Append(TDBXSQL.Space);
      MakeSqlIdentifier(Buffer, Deleted.Value[TDBXColumnsIndex.ColumnName].GetWideString(NullString));
      Separator := SecondSeparator;
    end;
    Deleted.Next;
  end;
  Deleted.Close;
  Inserted := Columns.InsertedRows;
  Inserted.First;
  while Inserted.InBounds do
  begin
    if SupportedTableAlteration(TDBXAlterTableOperation.AddColumn) then
    begin
      Buffer.Append(Separator);
      Buffer.Append(TDBXSQL.Add);
  //      buffer.append(SQL.SPACE);   Not supported by Interbase
  //      buffer.append(SQL.COLUMN);
      Buffer.Append(TDBXSQL.Space);
      MakeSqlColumnDefinition(Buffer, Inserted);
      if not Inserted.Value[TDBXColumnsIndex.Ordinal].IsNull then
      begin
        if SupportedTableAlteration(TDBXAlterTableOperation.AddColumnWithPosition) then
        begin
          Buffer.Append(TDBXSQL.Space);
          Buffer.Append(TDBXSQL.Position);
          Buffer.Append(TDBXSQL.Space);
          Buffer.Append(Inserted.Value[TDBXColumnsIndex.Ordinal].AsInt32);
        end;
      end;
      Separator := SecondSeparator;
    end;
    Inserted.Next;
  end;
  Inserted.Close;
  Modified := Columns.UpdatedRows;
  Modified.First;
  while Modified.InBounds do
  begin
    MarkerChangeColumnStart := Buffer.Length;
    Buffer.Append(Separator);
    Buffer.Append(TDBXSQL.Alter);
    Buffer.Append(TDBXSQL.Space);
    Buffer.Append(TDBXSQL.Column);
    Buffer.Append(TDBXSQL.Space);
    Original := Modified.OriginalRow;
    MakeSqlIdentifier(Buffer, Original.Value[TDBXColumnsIndex.ColumnName].AsString);
    MarkerChangeColumnFirstChange := Buffer.Length;
    if not (Modified.Value[TDBXColumnsIndex.TypeName].EqualsValue(Original.Value[TDBXColumnsIndex.TypeName]) and Modified.Value[TDBXColumnsIndex.Precision].EqualsValue(Original.Value[TDBXColumnsIndex.Precision]) and Modified.Value[TDBXColumnsIndex.Scale].EqualsValue(Original.Value[TDBXColumnsIndex.Scale])) then
    begin
      if SupportedTableAlteration(TDBXAlterTableOperation.ChangeColumnType) then
      begin
        Buffer.Append(TDBXSQL.Space);
        Buffer.Append(TDBXSQL.cType);
        Buffer.Append(TDBXSQL.Space);
        MakeSqlDataType(Buffer, Modified.Value[TDBXColumnsIndex.TypeName].AsString, Modified);
      end;
    end;
    if not Modified.Value[TDBXColumnsIndex.DefaultValue].EqualsValue(Original.Value[TDBXColumnsIndex.DefaultValue]) then
    begin
      DefaultValue := Modified.Value[TDBXColumnsIndex.DefaultValue].GetWideString(NullString);
      if (DefaultValue.IsEmpty) or (DefaultValue.Length = 0) then
      begin
        if SupportedTableAlteration(TDBXAlterTableOperation.DropDefaultValue) then
        begin
          Buffer.Append(TDBXSQL.Space);
          Buffer.Append(TDBXSQL.Drop);
          Buffer.Append(TDBXSQL.Space);
          Buffer.Append(TDBXSQL.Default);
        end;
      end
      else 
      begin
        if SupportedTableAlteration(TDBXAlterTableOperation.ChangeDefaultValue) then
        begin
          Buffer.Append(TDBXSQL.Space);
          Buffer.Append(TDBXSQL.cSet);
          Buffer.Append(TDBXSQL.Space);
          MakeSqlDefaultValue(Buffer, DefaultValue, Modified.Value[TDBXColumnsIndex.TypeName].GetWideString(NullString));
        end;
      end;
    end;
    if not Modified.Value[TDBXColumnsIndex.IsNullable].EqualsValue(Original.Value[TDBXColumnsIndex.IsNullable]) then
    begin
      if not Modified.Value[TDBXColumnsIndex.IsNullable].GetBoolean(True) then
      begin
        if SupportedTableAlteration(TDBXAlterTableOperation.DropNullable) then
        begin
          Buffer.Append(TDBXSQL.Space);
          Buffer.Append(TDBXSQL.cNot);
          Buffer.Append(TDBXSQL.Space);
          Buffer.Append(TDBXSQL.Nullable);
        end;
      end
      else 
      begin
        if SupportedTableAlteration(TDBXAlterTableOperation.SetNullable) then
        begin
          Buffer.Append(TDBXSQL.Space);
          Buffer.Append(TDBXSQL.Nullable);
        end;
      end;
    end;
    if not Modified.Value[TDBXColumnsIndex.IsAutoIncrement].EqualsValue(Original.Value[TDBXColumnsIndex.IsAutoIncrement]) then
    begin
      AutoIncrementWord := SqlAutoIncrementKeyword;
      if (not AutoIncrementWord.IsEmpty) and (AutoIncrementWord.Length > 0) then
      begin
        if Modified.Value[TDBXColumnsIndex.IsAutoIncrement].GetBoolean(False) then
        begin
          if SupportedTableAlteration(TDBXAlterTableOperation.AddAutoincrement) then
          begin
            Buffer.Append(TDBXSQL.Space);
            Buffer.Append(AutoIncrementWord);
          end;
        end
        else 
        begin
          if SupportedTableAlteration(TDBXAlterTableOperation.DropAutoincrement) then
          begin
            Buffer.Append(TDBXSQL.Space);
            Buffer.Append(TDBXSQL.Drop);
            Buffer.Append(TDBXSQL.Space);
            Buffer.Append(AutoIncrementWord);
          end;
        end;
      end;
    end;
    if not Modified.Value[TDBXColumnsIndex.Ordinal].EqualsValue(Original.Value[TDBXColumnsIndex.Ordinal]) then
    begin
      if SupportedTableAlteration(TDBXAlterTableOperation.ChangeColumnPosition) then
      begin
        Buffer.Append(TDBXSQL.Space);
        Buffer.Append(TDBXSQL.Position);
        Buffer.Append(TDBXSQL.Space);
        Buffer.Append(Modified.Value[TDBXColumnsIndex.Ordinal].AsInt32);
      end;
    end;
    if not Modified.Value[TDBXColumnsIndex.ColumnName].EqualsValue(Original.Value[TDBXColumnsIndex.ColumnName]) then
    begin
      if SupportedTableAlteration(TDBXAlterTableOperation.RenameColumn) then
      begin
        MarkerA := Buffer.Length;
        Buffer.Append(TDBXSQL.Space);
        MarkerB := Buffer.Length;
        LInline := MakeSqlColumnRename(Buffer, Modified.Value[TDBXColumnsIndex.ColumnName].GetWideString(NullString), OriginalTable.Value[TDBXTablesIndex.CatalogName].GetWideString(NullString), OriginalTable.Value[TDBXTablesIndex.SchemaName].GetWideString(NullString), OriginalTable.Value[TDBXTablesIndex.TableName].GetWideString(NullString), Original.Value[TDBXColumnsIndex.ColumnName].GetWideString(NullString));
        if not LInline then
        begin
          ExternalStatements := AddToExternalStatements(ExternalStatements, Buffer, MarkerB);
          Buffer.Length := MarkerA;
        end;
      end;
    end;
    if MarkerChangeColumnFirstChange = Buffer.Length then
      Buffer.Length := MarkerChangeColumnStart
    else 
      Separator := SecondSeparator;
    Modified.Next;
  end;
  Modified.Close;
  if not (Table.Value[TDBXTablesIndex.CatalogName].EqualsValue(OriginalTable.Value[TDBXTablesIndex.CatalogName]) and Table.Value[TDBXTablesIndex.SchemaName].EqualsValue(OriginalTable.Value[TDBXTablesIndex.SchemaName]) and Table.Value[TDBXTablesIndex.TableName].EqualsValue(OriginalTable.Value[TDBXTablesIndex.TableName])) then
  begin
    if SupportedTableAlteration(TDBXAlterTableOperation.RenameTable) or SupportedTableAlteration(TDBXAlterTableOperation.RenameTableTo) then
    begin
      MarkerA := Buffer.Length;
      Buffer.Append(Separator);
      MarkerB := Buffer.Length;
      LInline := MakeSqlTableRename(Buffer, Table.Value[TDBXTablesIndex.CatalogName].GetWideString(NullString), Table.Value[TDBXTablesIndex.SchemaName].GetWideString(NullString), Table.Value[TDBXTablesIndex.TableName].GetWideString(NullString), OriginalTable.Value[TDBXTablesIndex.CatalogName].GetWideString(NullString), OriginalTable.Value[TDBXTablesIndex.SchemaName].GetWideString(NullString), OriginalTable.Value[TDBXTablesIndex.TableName].GetWideString(NullString));
      if LInline then
        Separator := SecondSeparator
      else
      begin
        ExternalStatements := AddToExternalStatements(ExternalStatements, Buffer, MarkerB);
        Buffer.Length := MarkerA;
      end;
    end;
  end;
  if MarkerAlterTableFirst = Buffer.Length then
    Buffer.Length := MarkerAlterTableStart;
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
  if ExternalStatements <> nil then
    Buffer.Append(ExternalStatements);
  Result := True;
end;

function TDBXBaseMetaDataWriter.MakeSqlTableRename(const Buffer: TStringBuilder; const CatalogName: string; const SchemaName: string; const TableName: string; const OldCatalogName: string; const OldSchemaName: string; const OldTableName: string): Boolean;
begin
  Buffer.Append(TDBXSQL.Rename);
  if SupportedTableAlteration(TDBXAlterTableOperation.RenameTableTo) then
  begin
    Buffer.Append(TDBXSQL.Space);
    Buffer.Append(TDBXSQL.cTo);
  end;
  Buffer.Append(TDBXSQL.Space);
  MakeSqlObjectName(Buffer, CatalogName, SchemaName, TableName);
  Result := True;
end;

function TDBXBaseMetaDataWriter.MakeSqlColumnRename(const Buffer: TStringBuilder; const ColumnName: string; const CatalogName: string; const SchemaName: string; const TableName: string; const OldColumnName: string): Boolean;
begin
  Buffer.Append(TDBXSQL.cTo);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlIdentifier(Buffer, ColumnName);
  Result := True;
end;

procedure TDBXBaseMetaDataWriter.MakeSqlObjectName(const Buffer: TStringBuilder; const CatalogName: string; const SchemaName: string; const ObjectName: string);
var
  Dot: string;
begin
  Dot := TDBXSQL.Empty;
  if (not CatalogName.IsEmpty) and CatalogsSupported then
  begin
    MakeSqlIdentifier(Buffer, CatalogName);
    Dot := TDBXSQL.Dot;
  end;
  if (not SchemaName.IsEmpty) and SchemasSupported then
  begin
    Buffer.Append(Dot);
    MakeSqlIdentifier(Buffer, SchemaName);
    Dot := TDBXSQL.Dot;
  end;
  Buffer.Append(Dot);
  MakeSqlIdentifier(Buffer, ObjectName);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlIdentifier(const Buffer: TStringBuilder; const Identifier: string);
begin
  if FReader.QuotedIdentifiersSupported then
  begin
    if not IsValidSqlIdentifier(Identifier) or IsReservedWord(Identifier) then
    begin
      Buffer.Append(GetSqlQuotedIdentifier(Identifier));
      Exit;
    end;
  end;
  Buffer.Append(Identifier);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlColumnDefinition(const Buffer: TStringBuilder; const Column: TDBXTableRow);
var
  AutoIncrementWord: string;
begin
  MakeSqlIdentifier(Buffer, Column.Value[TDBXColumnsIndex.ColumnName].GetWideString(NullString));
  Buffer.Append(TDBXSQL.Space);
  MakeSqlDataType(Buffer, Column.Value[TDBXColumnsIndex.TypeName].GetWideString(NullString), Column);
  MakeSqlDefaultValue(Buffer, Column.Value[TDBXColumnsIndex.DefaultValue].GetWideString(NullString), Column.Value[TDBXColumnsIndex.TypeName].GetWideString(NullString));
  if Column.Value[TDBXColumnsIndex.IsAutoIncrement].GetBoolean(False) then
  begin
    AutoIncrementWord := SqlAutoIncrementKeyword;
    if (not AutoIncrementWord.IsEmpty) and (AutoIncrementWord.Length > 0) then
    begin
      Buffer.Append(TDBXSQL.Space);
      Buffer.Append(AutoIncrementWord);
    end;
  end;
  MakeSqlNullable(Buffer, Column);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlNullable(const Buffer: TStringBuilder; const Column: TDBXTableRow);
begin
  if not Column.Value[TDBXColumnsIndex.IsNullable].GetBoolean(True) then
  begin
    Buffer.Append(TDBXSQL.Space);
    Buffer.Append(TDBXSQL.cNot);
    Buffer.Append(TDBXSQL.Space);
    Buffer.Append(TDBXSQL.Nullable);
  end;
end;

procedure TDBXBaseMetaDataWriter.MakeSqlDefaultValue(const Buffer: TStringBuilder; const DefaultValue: string; const TypeName: string);
begin
  if (not DefaultValue.IsEmpty) and (DefaultValue.Length > 0) then
  begin
    Buffer.Append(TDBXSQL.Space);
    Buffer.Append(TDBXSQL.Default);
    Buffer.Append(TDBXSQL.Space);
    Buffer.Append(DefaultValue);
  end;
end;

function TDBXBaseMetaDataWriter.RemoveMarkersForNullValues(const InFormat: string; const Values: TDBXStringArray): string;
var
  Found, Index: Integer;
  Format, SearchFor: string;
begin
  SearchFor := NullString;
  Format := InFormat;
  for Index := Length(Values) - 1 downto 1 do
  begin
    if Values[Index].IsEmpty then
    begin
      SearchFor := TDBXSQL.Comma + TDBXSQL.OpenBrace + IntToStr(Index) + TDBXSQL.CloseBrace;
      Found := Format.IndexOf(SearchFor);
      if Found > 0 then
        Format := Format.Substring(0, Found) + Format.Substring(Found + SearchFor.Length, Format.Length - Found - SearchFor.Length);
    end;
    Break;
  end;
  if Values[0].IsEmpty then
  begin
    SearchFor := TDBXSQL.OpenParen + TDBXSQL.OpenBrace + IntToStr(0) + TDBXSQL.CloseBrace + TDBXSQL.CloseParen;
    Found := Format.IndexOf(SearchFor);
    if Found > 0 then
      Format := Format.Substring(0, Found) + Format.Substring(Found + SearchFor.Length, Format.Length - Found - SearchFor.Length);
  end;
  Result := Format;
end;

procedure TDBXBaseMetaDataWriter.MakeSqlDataType(const Buffer: TStringBuilder; const TypeName: string; const ColumnRow: TDBXTableRow);
var
  Overrides: TDBXInt32s;
  DataType: TDBXDataTypeDescription;
begin
  SetLength(Overrides,2);
  Overrides[0] := -1;
  Overrides[1] := -1;
  DataType := FindDataType(TypeName, ColumnRow, Overrides);
  MakeSqlDataType(Buffer, DataType, ColumnRow, Overrides);
  Overrides := nil;
end;

procedure TDBXBaseMetaDataWriter.MakeSqlDataType(const Buffer: TStringBuilder; const DataType: TDBXDataTypeDescription; const ColumnRow: TDBXTableRow; const Overrides: TDBXInt32s);
var
  ColumnName, FormatString, FormattedType, Params: string;
  Index, Override, ParameterCount, ParameterIndex: Integer;
  Tokenizer: TDBXTokenizer;
  Values: TDBXStringArray;
begin
  FormattedType := NullString;
  Params := DataType.CreateParameters;
  FormatString := DataType.CreateFormat;
  if (Params.IsEmpty) or (Params.Length = 0) then
    FormattedType := FormatString
  else 
  begin
    ParameterCount := 0;
    Tokenizer := TDBXTokenizer.Create(Params, TDBXSQL.Comma + TDBXSQL.Space);
    while Tokenizer.HasMoreTokens do
    begin
      Tokenizer.NextToken;
      Inc(ParameterCount);
    end;
    SetLength(Values,ParameterCount);
    Tokenizer.Free;
    Tokenizer := TDBXTokenizer.Create(Params, TDBXSQL.Comma + TDBXSQL.Space);
    ParameterIndex := 0;
    while Tokenizer.HasMoreTokens do
    begin
      ColumnName := Tokenizer.NextToken;
      Index := ColumnRow.GetOrdinal(ColumnName);
      if Index < 0 then
        raise TDBXMetaDataError.Create(Format(SUnknownColumnName, [DataType.TypeName,ColumnName]));
      Override := -1;
      case Index of
        TDBXColumnsIndex.Precision:
          Override := Overrides[0];
        TDBXColumnsIndex.Scale:
          Override := Overrides[1];
      end;
      if Override < 0 then
        Values[ParameterIndex] := ColumnRow.Value[Index].AsString
      else 
        Values[ParameterIndex] := IntToStr(Override);
      Inc(ParameterIndex);
    end;
    Tokenizer.Free;
    FormatString := RemoveMarkersForNullValues(FormatString, Values);
    FormattedType := FormatMessage(FormatString, Values);
  end;
  Buffer.Append(FormattedType);
end;

function TDBXBaseMetaDataWriter.ErrorTypeNameNotFound(const ColumnRow: TDBXTableRow): Exception;
var
  Product: string;
  ColumnName: string;
  ColumnType: Integer;
  IsUnsigned: Boolean;
begin
  Product := FReader.ProductName;
  ColumnName := ColumnRow.Value[TDBXColumnsIndex.ColumnName].GetWideString('');
  ColumnType := ColumnRow.Value[TDBXColumnsIndex.DbxDataType].AsInt32;
  IsUnsigned := ColumnRow.Value[TDBXColumnsIndex.IsUnsigned].GetBoolean;
  Result := TDBXMetaDataError.Create(Format(STypeNotFound, [Product,ColumnName,FContext.GetPlatformTypeName(ColumnType, IsUnsigned)]));
end;

function TDBXBaseMetaDataWriter.FindDataType(const InTypeName: string; const ColumnRow: TDBXTableRow; const Overrides: TDBXInt32s): TDBXDataTypeDescription;
var
  TypeName: string;
  DataTypes: TDBXObjectStore;
  DataType: TDBXDataTypeDescription;
begin
  TypeName := InTypeName;
  if TypeName.IsEmpty then
    TypeName := FindTypeName(ColumnRow, Overrides, True);
  if TypeName.IsEmpty then
    raise ErrorTypeNameNotFound(ColumnRow);
  DataTypes := FReader.DataTypeHash;
  DataType := TDBXDataTypeDescription(DataTypes[TypeName]);
  if DataType = nil then
    raise TDBXMetaDataError.Create(Format(STypeNameNotFound, [TypeName]));
  Result := DataType;
end;

function TDBXBaseMetaDataWriter.FindTypeName(const ColumnRow: TDBXTableRow; const Overrides: TDBXInt32s; const FailIfNotFound: Boolean): string;
var
  ColumnType: Integer;
begin
  ColumnType := ColumnRow.Value[TDBXColumnsIndex.DbxDataType].AsInt32;
  case ColumnType of
    TDBXDataTypes.AnsiStringType,
    TDBXDataTypes.WideStringType:
      Result := FindStringOrBinaryTypeName(ColumnRow, FailIfNotFound);
    TDBXDataTypes.Int8Type,
    TDBXDataTypes.Int16Type,
    TDBXDataTypes.Int32Type,
    TDBXDataTypes.Int64Type,
    TDBXDataTypes.UInt8Type,
    TDBXDataTypes.UInt16Type,
    TDBXDataTypes.UInt32Type,
    TDBXDataTypes.UInt64Type:
      Result := FindIntegerTypeName(ColumnRow, Overrides, FailIfNotFound);
    TDBXDataTypes.BcdType:
      Result := FindDecimalTypeName(ColumnRow, FailIfNotFound);
    TDBXDataTypes.SingleType,
    TDBXDataTypes.DoubleType:
      Result := FindFloatTypeName(ColumnRow, Overrides, FailIfNotFound);
    TDBXDataTypes.DateType,
    TDBXDataTypes.TimeType,
    TDBXDataTypes.TimeStampType,
    TDBXDataTypes.TimeStampOffsetType:
      Result := FindDateTimeTypeName(ColumnRow, FailIfNotFound);
    TDBXDataTypes.BlobType,
    TDBXDataTypes.BytesType,
    TDBXDataTypes.VarBytesType:
      Result := FindStringOrBinaryTypeName(ColumnRow, FailIfNotFound);
    TDBXDataTypes.BooleanType:
      Result := FindBooleanTypeName(ColumnRow, Overrides, FailIfNotFound);
    TDBXDataTypes.ObjectType:
      Result := FindSimpleColumnTypeMatch(ColumnRow, FailIfNotFound);
    else
      Result := NullString;
  end;
end;

function TDBXBaseMetaDataWriter.FindSimpleColumnTypeMatch(const ColumnRow: TDBXTableRow; const FailIfNotFound: Boolean): string;
var
  WantedColumnType: Integer;
  BestScore: Integer;
  BestTypeName: string;
  DataTypes: TDBXArrayList;
  Index: Integer;
  DataType: TDBXDataTypeDescription;
  Score: Integer;
  Product: string;
  ColumnName: string;
begin
  WantedColumnType := ColumnRow.Value[TDBXColumnsIndex.DbxDataType].AsInt32;
  BestScore := -1;
  BestTypeName := NullString;
  DataTypes := FReader.DataTypes;
  for index := 0 to DataTypes.Count - 1 do
  begin
    DataType := TDBXDataTypeDescription(DataTypes[Index]);
    Score := 0;
    if DataType.DbxDataType = WantedColumnType then
    begin
      Score := Score + Requirement;
      if DataType.BestMatch then
        Score := Score + TieBreaker1;
      if Score > BestScore then
      begin
        BestScore := Score;
        BestTypeName := DataType.TypeName;
      end;
    end;
  end;
  if BestScore >= Requirement then
    Exit(BestTypeName)
  else if not FailIfNotFound then
    Exit(NullString);
  Product := FReader.ProductName;
  ColumnName := ColumnRow.Value[TDBXColumnsIndex.ColumnName].GetWideString('');
  raise TDBXMetaDataError.Create(Format(STypeNotFound, [Product,ColumnName,FContext.GetPlatformTypeName(WantedColumnType, False)]));
end;

function TDBXBaseMetaDataWriter.FindBooleanTypeName(const ColumnRow: TDBXTableRow; const Overrides: TDBXInt32s; const FailIfNotFound: Boolean): string;
var
  BestScore: Integer;
  BestTypeName: string;
  DataTypes: TDBXArrayList;
  Index: Integer;
  DataType: TDBXDataTypeDescription;
  ActualColumnType: Integer;
  Score: Integer;
  Product: string;
  ColumnName: string;
begin
  BestScore := -1;
  BestTypeName := NullString;
  DataTypes := FReader.DataTypes;
  for index := 0 to DataTypes.Count - 1 do
  begin
    DataType := TDBXDataTypeDescription(DataTypes[Index]);
    ActualColumnType := DataType.DbxDataType;
    Score := -1;
    case ActualColumnType of
      TDBXDataTypes.BooleanType:
        Exit(DataType.TypeName);
      TDBXDataTypes.AnsiStringType:
        Score := 2 * Desireable;
      TDBXDataTypes.WideStringType:
        Score := Desireable;
    end;
    if (Score > 0) and ColumnRow.Value[TDBXColumnsIndex.IsFixedLength].GetBoolean then
      Score := Score + TieBreaker1;
    if Score > BestScore then
    begin
      BestScore := Score;
      BestTypeName := DataType.TypeName;
    end;
  end;
  if BestScore > 0 then
  begin
    Overrides[0] := 1;
    Exit(BestTypeName);
  end
  else if not FailIfNotFound then
    Exit(NullString);
  Product := FReader.ProductName;
  ColumnName := ColumnRow.Value[TDBXColumnsIndex.ColumnName].GetWideString('');
  raise TDBXMetaDataError.Create(Format(STypeNotFound, [Product,ColumnName,FContext.GetPlatformTypeName(TDBXDataTypes.BooleanType, False)]));
end;

function TDBXBaseMetaDataWriter.FindStringOrBinaryTypeName(const ColumnRow: TDBXTableRow; const FailIfNotFound: Boolean): string;
var
  WantedColumnType: Integer;
  WantedStringType: Boolean;
  UnicodeRequired: Boolean;
  UnicodeNotDesired: Boolean;
  BlobRequired: Boolean;
  BlobForbidden: Boolean;
  FixedLengthDesired: Boolean;
  VariableLengthDesired: Boolean;
  PrecisionRequired: Integer;
  BestScore: Integer;
  BestTypeName: string;
  BestColumnSize: Int64;
  BestIsUnicode: Boolean;
  DataTypes: TDBXArrayList;
  Index: Integer;
  DataType: TDBXDataTypeDescription;
  ActualColumnType: Integer;
  ActualStringType: Boolean;
  Score: Integer;
  Product: string;
  ColumnName: string;
begin
  WantedColumnType := ColumnRow.Value[TDBXColumnsIndex.DbxDataType].AsInt32;
  WantedStringType := ((WantedColumnType = TDBXDataTypes.AnsiStringType) or (WantedColumnType = TDBXDataTypes.WideStringType));
  UnicodeRequired := ColumnRow.Value[TDBXColumnsIndex.IsUnicode].GetBoolean(False);
  UnicodeNotDesired := not ColumnRow.Value[TDBXColumnsIndex.IsUnicode].GetBoolean(True);
  BlobRequired := ColumnRow.Value[TDBXColumnsIndex.IsLong].GetBoolean(False);
  BlobForbidden := not ColumnRow.Value[TDBXColumnsIndex.IsLong].GetBoolean(True);
  FixedLengthDesired := ColumnRow.Value[TDBXColumnsIndex.IsFixedLength].GetBoolean(False);
  VariableLengthDesired := not ColumnRow.Value[TDBXColumnsIndex.IsFixedLength].GetBoolean(True);
  PrecisionRequired := ColumnRow.Value[TDBXColumnsIndex.Precision].GetInt64(-1);
  if not WantedStringType then
  begin
    UnicodeRequired := False;
    UnicodeNotDesired := False;
  end;
  BestScore := -1;
  BestTypeName := NullString;
  BestColumnSize := -1;
  BestIsUnicode := False;
  DataTypes := FReader.DataTypes;
  for index := 0 to DataTypes.Count - 1 do
  begin
    DataType := TDBXDataTypeDescription(DataTypes[Index]);
    ActualColumnType := DataType.DbxDataType;
    ActualStringType := ((ActualColumnType = TDBXDataTypes.AnsiStringType) or (ActualColumnType = TDBXDataTypes.WideStringType));
    case ActualColumnType of
      TDBXDataTypes.BlobType,
      TDBXDataTypes.BytesType,
      TDBXDataTypes.VarBytesType,
      TDBXDataTypes.AnsiStringType,
      TDBXDataTypes.WideStringType:
        if (WantedStringType = ActualStringType) or (WantedStringType and DataType.StringOptionSupported) then
        begin
          Score := 0;
          if DataType.ColumnSize >= PrecisionRequired then
            Score := Score + Requirement;
          if DataType.Unicode or DataType.UnicodeOptionSupported or not UnicodeRequired then
            Score := Score + Requirement;
          if DataType.Long or DataType.LongOptionSupported or not BlobRequired then
            Score := Score + Requirement;
          if not DataType.Long or not BlobForbidden then
            Score := Score + Requirement;
          if DataType.FixedLength and FixedLengthDesired then
            Score := Score + Desireable;
          if not DataType.Unicode or not UnicodeNotDesired then
            Score := Score + Desireable;
          if not DataType.FixedLength and VariableLengthDesired then
            Score := Score + Desireable;
          if not DataType.Long then
            Score := Score + TieBreaker5;
          if DataType.Unicode then
            Score := Score + TieBreaker4;
          if not DataType.FixedLength then
            Score := Score + TieBreaker3;
          if DataType.BestMatch then
            Score := Score + TieBreaker2;
          if DataType.ColumnSize < BestColumnSize then
            Score := Score + TieBreaker1;
          if Score > BestScore then
          begin
            BestScore := Score;
            BestTypeName := DataType.TypeName;
            BestColumnSize := DataType.ColumnSize;
            BestIsUnicode := DataType.Unicode;
          end;
        end;
    end;
  end;
  if BestScore >= 4 * Requirement then
    Exit(BestTypeName)
  else if not FailIfNotFound then
    Exit(NullString);
  Product := FReader.ProductName;
  ColumnName := ColumnRow.Value[TDBXColumnsIndex.ColumnName].GetWideString('');
  if BestScore < 0 then
    raise TDBXMetaDataError.Create(Format(STypeNotFound, [Product,ColumnName,FContext.GetPlatformTypeName(WantedColumnType, False)]));
  if BestColumnSize < PrecisionRequired then
    raise TDBXMetaDataError.Create(Format(SCannotHoldWantedPrecision, [Product,ColumnName,BestTypeName,IntToStr(BestColumnSize),IntToStr(PrecisionRequired)]));
  if not BestIsUnicode and UnicodeRequired then
    raise TDBXMetaDataError.Create(Format(SCannotHoldUnicodeChars, [Product,ColumnName,BestTypeName]));
  if BlobRequired then
    raise TDBXMetaDataError.Create(Format(SNoBlobTypeFound, [Product,ColumnName,FContext.GetPlatformTypeName(WantedColumnType, False)]))
  else 
    raise TDBXMetaDataError.Create(Format(STypeNotFound, [Product,ColumnName,FContext.GetPlatformTypeName(WantedColumnType, False)]));
end;

function TDBXBaseMetaDataWriter.CalcPrecisionColumnType(const ColumnType: Integer; const UnsignedOption: Boolean): Integer;
begin
  if not UnsignedOption then
    Exit(ColumnType);
  case ColumnType of
    TDBXDataTypes.Int8Type:
      Result := TDBXDataTypes.UInt8Type;
    TDBXDataTypes.Int16Type:
      Result := TDBXDataTypes.UInt16Type;
    TDBXDataTypes.Int32Type:
      Result := TDBXDataTypes.UInt32Type;
    TDBXDataTypes.Int64Type:
      Result := TDBXDataTypes.UInt64Type;
    else
      Result := ColumnType;
  end;
end;

function TDBXBaseMetaDataWriter.CalcDecimalPrecision(const ColumnType: Integer): Integer;
begin
  case ColumnType of
    TDBXDataTypes.Int8Type,
    TDBXDataTypes.UInt8Type:
      Result := 3;
    TDBXDataTypes.Int16Type,
    TDBXDataTypes.UInt16Type:
      Result := 5;
    TDBXDataTypes.Int32Type,
    TDBXDataTypes.UInt32Type:
      Result := 10;
    TDBXDataTypes.Int64Type:
      Result := 19;
    TDBXDataTypes.UInt64Type:
      Result := 20;
    else
      Result := 0;
  end;
end;

function TDBXBaseMetaDataWriter.CalcBinaryPrecision(const ColumnType: Integer): Integer;
begin
  case ColumnType of
    TDBXDataTypes.Int8Type:
      Result := 7;
    TDBXDataTypes.UInt8Type:
      Result := 8;
    TDBXDataTypes.Int16Type:
      Result := 15;
    TDBXDataTypes.UInt16Type:
      Result := 16;
    TDBXDataTypes.Int32Type:
      Result := 31;
    TDBXDataTypes.UInt32Type:
      Result := 32;
    TDBXDataTypes.Int64Type:
      Result := 63;
    TDBXDataTypes.UInt64Type:
      Result := 64;
    else
      Result := 0;
  end;
end;

function TDBXBaseMetaDataWriter.IsSignedInteger(const ColumnType: Integer): Boolean;
begin
  case ColumnType of
    TDBXDataTypes.Int8Type,
    TDBXDataTypes.Int16Type,
    TDBXDataTypes.Int32Type,
    TDBXDataTypes.Int64Type:
      Result := True;
    else
      Result := False;
  end;
end;

function TDBXBaseMetaDataWriter.FindIntegerTypeName(const ColumnRow: TDBXTableRow; const Overrides: TDBXInt32s; const FailIfNotFound: Boolean): string;
var
  ColumnType: Integer;
  RequiredBinaryPrecision: Integer;
  RequiredDecimalPrecision: Integer;
  SignedRequired: Boolean;
  AutoIncrementRequired: Boolean;
  BestScore: Integer;
  BestType: Integer;
  BestTypeName: string;
  BestIsAutoIncrementable: Boolean;
  BestIsSigned: Boolean;
  DataTypes: TDBXArrayList;
  Score: Integer;
  ActualColumnType: Integer;
  ActualBinaryPrecision: Integer;
  ActualDecimalPrecision: Integer;
  Index: Integer;
  DataType: TDBXDataTypeDescription;
  PrecisionColumnType: Integer;
  Product: string;
  ColumnName: string;
begin
  ColumnType := ColumnRow.Value[TDBXColumnsIndex.DbxDataType].AsInt32;
  RequiredBinaryPrecision := CalcBinaryPrecision(ColumnType);
  RequiredDecimalPrecision := CalcDecimalPrecision(ColumnType);
  SignedRequired := IsSignedInteger(ColumnType);
  AutoIncrementRequired := ColumnRow.Value[TDBXColumnsIndex.IsAutoIncrement].GetBoolean(False);
  BestScore := -1;
  BestType := TDBXDataTypes.UnknownType;
  BestTypeName := NullString;
  BestIsAutoIncrementable := False;
  BestIsSigned := False;
  DataTypes := FReader.DataTypes;
  for index := 0 to DataTypes.Count - 1 do
  begin
    DataType := TDBXDataTypeDescription(DataTypes[Index]);
    ActualColumnType := DataType.DbxDataType;
    case ActualColumnType of
      TDBXDataTypes.Int8Type,
      TDBXDataTypes.UInt8Type,
      TDBXDataTypes.Int16Type,
      TDBXDataTypes.UInt16Type,
      TDBXDataTypes.Int32Type,
      TDBXDataTypes.UInt32Type,
      TDBXDataTypes.Int64Type,
      TDBXDataTypes.UInt64Type,
      TDBXDataTypes.BcdType:
        begin
          Score := 0;
          if ActualColumnType = TDBXDataTypes.BcdType then
          begin
            ActualBinaryPrecision := 128;
            ActualDecimalPrecision := Integer(DataType.ColumnSize);
          end
          else 
          begin
            PrecisionColumnType := CalcPrecisionColumnType(ActualColumnType, DataType.UnsignedOptionSupported);
            ActualBinaryPrecision := CalcBinaryPrecision(PrecisionColumnType);
            ActualDecimalPrecision := CalcDecimalPrecision(PrecisionColumnType);
          end;
          if ActualBinaryPrecision >= RequiredBinaryPrecision then
            Score := Score + Requirement + 128 - (ActualBinaryPrecision - RequiredBinaryPrecision);
          if ActualDecimalPrecision >= RequiredDecimalPrecision then
            Score := Score + Requirement;
          if DataType.AutoIncrementable or not AutoIncrementRequired then
            Score := Score + Requirement;
          if not DataType.Unsigned or not SignedRequired then
            Score := Score + Requirement;
          if DataType.BestMatch then
            Score := Score + Desireable;
          if Score > BestScore then
          begin
            BestScore := Score;
            BestType := ActualColumnType;
            BestTypeName := DataType.TypeName;
            BestIsAutoIncrementable := DataType.AutoIncrementable;
            BestIsSigned := not DataType.Unsigned;
          end;
        end;
    end;
  end;
  if BestScore >= 4 * Requirement then
  begin
    if (BestType = TDBXDataTypes.BcdType) and (Overrides <> nil) then
    begin
      Overrides[0] := RequiredDecimalPrecision;
      Overrides[1] := 0;
    end;
    Exit(BestTypeName);
  end
  else if not FailIfNotFound then
    Exit(NullString);
  Product := FReader.ProductName;
  ColumnName := ColumnRow.Value[TDBXColumnsIndex.ColumnName].GetWideString('');
  if BestScore < 0 then
    raise ErrorTypeNameNotFound(ColumnRow);
  if not BestIsAutoIncrementable and AutoIncrementRequired then
    raise TDBXMetaDataError.Create(Format(SCannotBeUsedForAutoIncrement, [Product,ColumnName,BestTypeName]));
  if not BestIsSigned and SignedRequired then
    raise TDBXMetaDataError.Create(Format(SNoSignedTypeFound, [Product,ColumnName,BestTypeName]))
  else 
    raise TDBXMetaDataError.Create(Format(SNoTypeWithEnoughPrecision, [Product,ColumnName,BestTypeName]));
end;

function TDBXBaseMetaDataWriter.FindDecimalTypeName(const ColumnRow: TDBXTableRow; const FailIfNotFound: Boolean): string;
var
  PrecisionRequired: Integer;
  ScaleRequired: Integer;
  AutoIncrementRequired: Boolean;
  BestScore: Integer;
  BestTypeName: string;
  BestColumnSize: Int64;
  BestMaxScale: Integer;
  DataTypes: TDBXArrayList;
  Index: Integer;
  DataType: TDBXDataTypeDescription;
  Score: Integer;
  ColumnName: string;
  Product: string;
begin
  PrecisionRequired := ColumnRow.Value[TDBXColumnsIndex.Precision].GetInt64(-1);
  ScaleRequired := ColumnRow.Value[TDBXColumnsIndex.Scale].GetInt32(-1);
  AutoIncrementRequired := ColumnRow.Value[TDBXColumnsIndex.IsAutoIncrement].GetBoolean(False);
  BestScore := -1;
  BestTypeName := NullString;
  BestColumnSize := -1;
  BestMaxScale := -1;
  DataTypes := FReader.DataTypes;
  for index := 0 to DataTypes.Count - 1 do
  begin
    DataType := TDBXDataTypeDescription(DataTypes[Index]);
    if DataType.DbxDataType = TDBXDataTypes.BcdType then
    begin
      Score := 0;
      if DataType.ColumnSize >= PrecisionRequired then
        Score := Score + Requirement + TieBreaker3;
      if DataType.MaximumScale >= ScaleRequired then
        Score := Score + Requirement + TieBreaker2;
      if DataType.AutoIncrementable or not AutoIncrementRequired then
        Score := Score + Requirement;
      if DataType.BestMatch then
        Score := Score + TieBreaker1;
      if Score > BestScore then
      begin
        BestScore := Score;
        BestTypeName := DataType.TypeName;
        BestColumnSize := DataType.ColumnSize;
        BestMaxScale := DataType.MaximumScale;
      end;
    end;
  end;
  if BestScore >= 3 * Requirement then
    Exit(BestTypeName)
  else if not FailIfNotFound then
    Exit(NullString);
  ColumnName := ColumnRow.Value[TDBXColumnsIndex.ColumnName].GetWideString('');
  if BestScore < 0 then
    raise ErrorTypeNameNotFound(ColumnRow);
  Product := FReader.ProductName;
  if BestColumnSize < PrecisionRequired then
    raise TDBXMetaDataError.Create(Format(SCannotHoldWantedPrecision, [Product,ColumnName,BestTypeName,IntToStr(BestColumnSize),IntToStr(PrecisionRequired)]));
  if BestMaxScale < ScaleRequired then
    raise TDBXMetaDataError.Create(Format(SCannotHoldWantedScale, [Product,ColumnName,BestTypeName,IntToStr(BestMaxScale),IntToStr(ScaleRequired)]))
  else
    raise TDBXMetaDataError.Create(Format(SCannotBeUsedForAutoIncrement, [Product,BestTypeName,ColumnName]));
end;

function TDBXBaseMetaDataWriter.GetDefaultFloatPrecision(const ColumnType: Integer): Integer;
begin
  case ColumnType of
    TDBXDataTypes.SingleType:
      Result := 24;
    TDBXDataTypes.DoubleType:
      Result := 53;
    else
      Result := 0;
  end;
end;

function TDBXBaseMetaDataWriter.FindFloatTypeName(const ColumnRow: TDBXTableRow; const Overrides: TDBXInt32s; const FailIfNotFound: Boolean): string;
var
  ActualColumnType, BestScore, Index, PrecisionRequired, Score, WantedColumnType: Integer;
  BestTypeName, ColumnName, Product: string;
  BestColumnSize: Int64;
  BestPrecisionNeeded, PrecisionNeeded: Boolean;
  DataTypes: TDBXArrayList;
  DataType: TDBXDataTypeDescription;
begin
  WantedColumnType := ColumnRow.Value[TDBXColumnsIndex.DbxDataType].AsInt32;
  PrecisionRequired := GetDefaultFloatPrecision(WantedColumnType);
  BestScore := -1;
  BestTypeName := NullString;
  BestColumnSize := -1;
  BestPrecisionNeeded := False;
  DataTypes := FReader.DataTypes;
  for Index := 0 to DataTypes.Count - 1 do
  begin
    DataType := TDBXDataTypeDescription(DataTypes[Index]);
    ActualColumnType := DataType.DbxDataType;
    case ActualColumnType of
      TDBXDataTypes.SingleType,
      TDBXDataTypes.DoubleType:
        begin
          Score := 0;
          PrecisionNeeded := (DataType.CreateParameters.Length > 0);
          if PrecisionNeeded then
          begin
            if DataType.ColumnSize >= PrecisionRequired then
              Score := Score + Requirement;
          end
          else 
          begin
            if ActualColumnType = WantedColumnType then
              Score := Score + Requirement + TieBreaker2;
          end;
          if DataType.BestMatch then
            Score := Score + TieBreaker1;
          if Score > BestScore then
          begin
            BestScore := Score;
            BestTypeName := DataType.TypeName;
            BestColumnSize := DataType.ColumnSize;
            BestPrecisionNeeded := PrecisionNeeded;
          end;
        end;
    end;
  end;
  if BestScore >= Requirement then
  begin
    if BestPrecisionNeeded then
    begin
      if ColumnRow.Value[TDBXColumnsIndex.Precision].IsNull or (ColumnRow.Value[TDBXColumnsIndex.Precision].AsInt64 < PrecisionRequired) then
      begin
        if Overrides <> nil then
          Overrides[0] := PrecisionRequired;
      end;
    end;
    Exit(BestTypeName);
  end
  else if not FailIfNotFound then
    Exit(NullString);
  ColumnName := ColumnRow.Value[TDBXColumnsIndex.ColumnName].GetWideString('');
  Product := FReader.ProductName;
  if BestScore < 0 then
    raise ErrorTypeNameNotFound(ColumnRow)
  else 
    raise TDBXMetaDataError.Create(string.Format(SCannotHoldWantedPrecision, [Product,ColumnName,BestTypeName,IntToStr(BestColumnSize),IntToStr(PrecisionRequired)]));
end;

function TDBXBaseMetaDataWriter.FindDateTimeTypeName(const ColumnRow: TDBXTableRow; const FailIfNotFound: Boolean): string;
var
  BestScore, ColumnType, Index, Score, WantedColumnType: Integer;
  BestTypeName: string;
  DataTypes: TDBXArrayList;
  DataType: TDBXDataTypeDescription;
begin
  WantedColumnType := ColumnRow.Value[TDBXColumnsIndex.DbxDataType].AsInt32;
  BestScore := -1;
  BestTypeName := NullString;
  DataTypes := FReader.DataTypes;
  for Index := 0 to DataTypes.Count - 1 do
  begin
    DataType := TDBXDataTypeDescription(DataTypes[Index]);
    ColumnType := DataType.DbxDataType;
    case ColumnType of
      TDBXDataTypes.DateType,
      TDBXDataTypes.TimeType,
      TDBXDataTypes.TimeStampType,
      TDBXDataTypes.TimeStampOffsetType:
        begin
          Score := 0;
          if WantedColumnType = ColumnType then
            Score := Requirement + Desireable
          else if ColumnType = TDBXDataTypes.TimeStampType then
            Score := Requirement;
          if DataType.BestMatch then
            Score := Score + TieBreaker1;
          if Score > BestScore then
          begin
            BestScore := Score;
            BestTypeName := DataType.TypeName;
          end;
        end;
    end;
  end;
  if BestScore >= Requirement then
    Exit(BestTypeName)
  else if not FailIfNotFound then
    Exit(NullString);
  raise ErrorTypeNameNotFound(ColumnRow);
end;

function TDBXBaseMetaDataWriter.AddToExternalStatements(const InExternalStatements: TStringBuilder; const Buffer: TStringBuilder; const StartPosition: Integer): TStringBuilder;
var
  ExternalStatements: TStringBuilder;
begin
  ExternalStatements := InExternalStatements;
  if ExternalStatements = nil then
    ExternalStatements := TStringBuilder.Create;
  ExternalStatements.Append(Buffer.ToString(StartPosition, Buffer.Length - StartPosition));
  Result := ExternalStatements;
end;

function TDBXBaseMetaDataWriter.IsValidSqlIdentifier(const Identifier: string): Boolean;
var
  UpperOK: Boolean;
  LowerOK: Boolean;
  Index: Integer;
  Ch: WideChar;
begin
  UpperOK := FReader.UpperCaseIdentifiersSupported;
  LowerOK := FReader.LowerCaseIdentifiersSupported;

  //Check if the identifier is already quoted!
  if (Identifier <> '') and Identifier.StartsWith(FReader.SqlIdentifierQuotePrefix) and
     Identifier.EndsWith(FReader.SqlIdentifierQuoteSuffix) then
    Exit(True);

  if (Identifier = '') or not IsLetter(Identifier.Chars[0], UpperOK, LowerOK) then
    Exit(False);
  for Index := 0 to Identifier.Length - 2 do
  begin
    Ch := Identifier.Chars[1+Index];
    if not IsLetter(Ch, UpperOK, LowerOK) and not IsDigit(Ch) and (Ch <> '_') then
      Exit(False);
  end;
  Result := True;
end;

function TDBXBaseMetaDataWriter.IsReservedWord(const Identifier: string): Boolean;
var
  LReservedWordsTable: TDBXTable;
begin
  if FReservedWords = nil then
  begin
    LReservedWordsTable := FReader.FetchReservedWords;
    FReservedWords := FReader.MakeStorage(LReservedWordsTable);
  end;
  Result := FReservedWords.FindStringKey(TDBXReservedWordsIndex.ReservedWord, Identifier);
end;

function TDBXBaseMetaDataWriter.IsLetter(const Ch: WideChar; const UpperOK: Boolean; const LowerOK: Boolean): Boolean;
begin
  if (Ch >= 'A') and (Ch <= 'Z') then
    Exit(UpperOK);
  if (Ch >= 'a') and (Ch <= 'z') then
    Exit(LowerOK);
  Result := False;
end;

function TDBXBaseMetaDataWriter.IsDigit(const Ch: WideChar): Boolean;
begin
  Result := ((Ch >= '0') and (Ch <= '9'));
end;

procedure TDBXBaseMetaDataWriter.MakeSqlTableReplacement(const Buffer: TStringBuilder; const Table: TDBXTableRow; const Columns: TDBXTable);
var
  OriginalTable: TDBXTableRow;
  TableRename: Boolean;
  NewCatalogName, NewSchemaName, NewTableName, TempTableName: string;
  NewColumns, NewTable: TDBXTable;
begin
  OriginalTable := Table.OriginalRow;
  TableRename := not (Table.Value[TDBXTablesIndex.CatalogName].EqualsValue(OriginalTable.Value[TDBXTablesIndex.CatalogName]) and Table.Value[TDBXTablesIndex.SchemaName].EqualsValue(OriginalTable.Value[TDBXTablesIndex.SchemaName]) and Table.Value[TDBXTablesIndex.TableName].EqualsValue(OriginalTable.Value[TDBXTablesIndex.TableName]));
  NewCatalogName := Table.Value[TDBXTablesIndex.CatalogName].GetWideString(NullString);
  NewSchemaName := Table.Value[TDBXTablesIndex.SchemaName].GetWideString(NullString);
  NewTableName := Table.Value[TDBXTablesIndex.TableName].GetWideString(NullString);
  TempTableName := C_Conditional(TableRename, NewTableName, TDBXSQL.Temp + NewTableName);
  Buffer.Append(TDBXSQL.Nl);
  CreateTempOutputTable(Buffer, Table, Columns, TempTableName);
  Buffer.Append(TDBXSQL.Nl);
  InsertValuesFromOldTable(Buffer, Table, Columns, TempTableName);
  Buffer.Append(TDBXSQL.Nl);
  MakeSqlDropTable(Buffer, OriginalTable);
  if not TableRename then
  begin
    if not SqlRenameTable.IsEmpty then
      MakeSqlTableRename(Buffer, NewCatalogName, NewSchemaName, TempTableName, NewTableName)
    else 
    begin
      NewTable := CopyTable(Table, TempTableName);
      NewColumns := CopyColumns(Columns);
      Buffer.Append(TDBXSQL.Nl);
      CreateTempOutputTable(Buffer, NewTable, NewColumns, NewTableName);
      Buffer.Append(TDBXSQL.Nl);
      InsertValuesFromOldTable(Buffer, NewTable, NewColumns, NewTableName);
      Buffer.Append(TDBXSQL.Nl);
      MakeSqlDropTable(Buffer, NewTable.OriginalRow);
    end;
  end;
end;

function TDBXBaseMetaDataWriter.CopyColumns(const ColumnTable: TDBXTable): TDBXTable;
var
  Columns: TDBXValueTypeArray;
  TableCopy: TDBXTable;
  Cursor: TDBXTable;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateColumnsColumns;
  TableCopy := FContext.CreateTableStorage(TDBXMetaDataCollectionName.Columns, Columns);
  Cursor := ColumnTable.CreateTableView(TDBXColumnsColumns.Ordinal);
  TableCopy.CopyFrom(Cursor);
  TableCopy.AcceptChanges;
  FreeAndNil(Cursor);
  Result := TableCopy;
end;

function TDBXBaseMetaDataWriter.CopyTable(const Table: TDBXTableRow; const TempTableName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
  TableCopy: TDBXTable;
  NewTableName: string;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateTablesColumns;
  TableCopy := FContext.CreateTableStorage(TDBXMetaDataCollectionName.Tables, Columns);
  TableCopy.Insert;
  CopyRow(Table, TableCopy, Length(Columns));
  NewTableName := TableCopy.Value[TDBXTablesIndex.TableName].GetWideString(NullString);
  TableCopy.Value[TDBXTablesIndex.TableName].AsString := TempTableName;
  TableCopy.Post;
  TableCopy.AcceptChanges;
  TableCopy.Value[TDBXTablesIndex.TableName].AsString := NewTableName;
  Result := TableCopy;
end;

function TDBXBaseMetaDataWriter.ComputeColumnMap(const Columns: TDBXTable): TDBXProperties;
var
  Map: TDBXProperties;
  Current: TDBXTable;
  Original: TDBXTableRow;
begin
  Map := TDBXProperties.Create;
  Current := Columns.CreateTableView(NullString);
  Current.First;
  while Current.InBounds do
  begin
    Original := Current.OriginalRow;
    if Original <> nil then
      Map[Original.Value[TDBXColumnsIndex.ColumnName].AsString] := Current.Value[TDBXColumnsIndex.ColumnName].AsString;
    Current.Next;
  end;
  FreeAndNil(Current);
  Result := Map;
end;

function TDBXBaseMetaDataWriter.GetDefaults(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable;
var
  LColumnConstraintsTable: TDBXTable;
begin
  LColumnConstraintsTable := FReader.FetchColumnConstraints(CatalogName, SchemaName, TableName);
  Result := FReader.MakeStorage(LColumnConstraintsTable);
end;

function TDBXBaseMetaDataWriter.GetIndexes(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable;
var
  LIndexesTable: TDBXTable;
begin
  LIndexesTable := FReader.FetchIndexes(CatalogName, SchemaName, TableName);
  Result := FReader.MakeStorage(LIndexesTable);
end;

function TDBXBaseMetaDataWriter.GetIndexColumns(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable;
var
  LIndexColumnsTable: TDBXTable;
begin
  LIndexColumnsTable := FReader.FetchIndexColumns(CatalogName, SchemaName, TableName, NullString);
  Result := FReader.MakeStorage(LIndexColumnsTable);
end;

function TDBXBaseMetaDataWriter.GetForeignKeyColumns(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable;
var
  LForeignKeyColumnsTable, ForeignKeyColumns, ImportedKeyColumns: TDBXTable;
begin
  LForeignKeyColumnsTable := FReader.FetchForeignKeyColumns(CatalogName, SchemaName, TableName, NullString, NullString, NullString, NullString, NullString);
  ForeignKeyColumns := FReader.MakeStorage(LForeignKeyColumnsTable);
  ImportedKeyColumns := FReader.FetchForeignKeyColumns(NullString, NullString, NullString, NullString, CatalogName, SchemaName, TableName, NullString);
  ForeignKeyColumns.CopyFrom(ImportedKeyColumns);
  ImportedKeyColumns.Close;
  ImportedKeyColumns.Free;
  ForeignKeyColumns.AcceptChanges;
  Result := ForeignKeyColumns;
end;

procedure TDBXBaseMetaDataWriter.RemoveForeignKeyGeneratedIndexes(const Table: TDBXTableRow; const Indexes: TDBXTable; const IndexColumns: TDBXTable; const ForeignKeyColumns: TDBXTable);
var
  GeneratedIndexName, Name: string;
  Original: TDBXTableRow;
  ConstraintNames, IndexNames: TDBXStringList;
begin
  GeneratedIndexName := SqlKeyGeneratedIndexName;
  if not GeneratedIndexName.IsEmpty then
  begin
    ConstraintNames := nil;
    IndexNames := nil;
    try
      Original := Table.OriginalRow;
      ForeignKeyColumns.First;
      ConstraintNames := TDBXStringList.Create;
      while ForeignKeyColumns.InBounds do
      begin
        if Compare(ForeignKeyColumns, TDBXForeignKeyColumnsIndex.CatalogName, Original, TDBXTablesIndex.CatalogName, (TDBXTablesIndex.TableName - TDBXTablesIndex.CatalogName) + 1) and (ForeignKeyColumns.Value[TDBXForeignKeyColumnsIndex.Ordinal].AsInt32 = 1) then
          ConstraintNames.Add(ForeignKeyColumns.Value[TDBXForeignKeyColumnsIndex.ForeignKeyName].GetWideString(TDBXSQL.Empty) + GeneratedIndexName);
        ForeignKeyColumns.Next;
      end;
      Indexes.First;
      IndexNames := TDBXStringList.Create;
      while Indexes.InBounds do
      begin
        Name := Indexes.Value[TDBXIndexesIndex.ConstraintName].GetWideString(NullString);
        if Name.IsEmpty then
          Name := Indexes.Value[TDBXIndexesIndex.IndexName].GetWideString(NullString);
        if Name.EndsWith(GeneratedIndexName) and (ConstraintNames.IndexOf(Name) >= 0) then
        begin
          IndexNames.Add(Indexes.Value[TDBXIndexesIndex.IndexName].GetWideString(TDBXSQL.Empty));
          Indexes.DeleteRow;
        end;
        Indexes.Next;
      end;
      Indexes.AcceptChanges;
      IndexColumns.First;
      while IndexColumns.InBounds do
      begin
        Name := IndexColumns.Value[TDBXIndexColumnsIndex.IndexName].GetWideString(TDBXSQL.Empty);
        if Name.EndsWith(GeneratedIndexName) and (IndexNames.IndexOf(Name) >= 0) then
          IndexColumns.DeleteRow;
        IndexColumns.Next;
      end;
    finally
      IndexNames.Free;
      ConstraintNames.Free;
    end;
    IndexColumns.AcceptChanges;
  end;
end;

procedure TDBXBaseMetaDataWriter.DropAllConstraints(const Buffer: TStringBuilder; const Defaults: TDBXTable; const Indexes: TDBXTable; const ForeignKeys: TDBXTable);
begin
  if Defaults <> nil then
  begin
    Defaults.First;
    while Defaults.InBounds do
    begin
      MakeSqlDropConstraint(Buffer, Defaults);
      Defaults.Next;
    end;
  end;
  ForeignKeys.First;
  while ForeignKeys.InBounds do
  begin
    if ForeignKeys.Value[TDBXForeignKeyColumnsIndex.Ordinal].GetInt32(0) = 1 then
      MakeSqlDropForeignKey(Buffer, ForeignKeys);
    ForeignKeys.Next;
  end;
  Indexes.First;
  while Indexes.InBounds do
  begin
    MakeSqlDropIndex(Buffer, Indexes);
    Indexes.Next;
  end;
end;

procedure TDBXBaseMetaDataWriter.CreateTempOutputTable(const Buffer: TStringBuilder; const Table: TDBXTableRow; const Columns: TDBXTable; const TempTableName: string);
var
  TempStorage: TDBXTable;
begin
  TempStorage := FContext.CreateTableStorage(TDBXMetaDataCollectionName.Tables, TDBXMetaDataCollectionColumns.CreateTablesColumns);
  TempStorage.First;
  TempStorage.Insert;
  TempStorage.Value[TDBXTablesIndex.CatalogName].SetValue(Table.Value[TDBXTablesIndex.CatalogName]);
  TempStorage.Value[TDBXTablesIndex.SchemaName].SetValue(Table.Value[TDBXTablesIndex.SchemaName]);
  TempStorage.Value[TDBXTablesIndex.TableName].AsString := TempTableName;
  TempStorage.Post;
  MakeSqlCreate(Buffer, TempStorage, Columns);
  FreeAndNil(TempStorage);
end;

procedure TDBXBaseMetaDataWriter.SetIdentityInsert(const Buffer: TStringBuilder; const CatalogName: string; const SchemaName: string; const TableName: string; const bOn: Boolean);
var
  AutoIncrementInserts: string;
begin
  AutoIncrementInserts := SqlAutoIncrementInserts;
  if not AutoIncrementInserts.IsEmpty then
  begin
    Buffer.Append(TDBXSQL.cSet);
    Buffer.Append(TDBXSQL.Space);
    Buffer.Append(AutoIncrementInserts);
    Buffer.Append(TDBXSQL.Space);
    MakeSqlObjectName(Buffer, CatalogName, SchemaName, TableName);
    Buffer.Append(TDBXSQL.Space);
    Buffer.Append(C_Conditional(bOn, TDBXSQL.cOn, TDBXSQL.Off));
    Buffer.Append(TDBXSQL.Semicolon);
    Buffer.Append(TDBXSQL.Nl);
  end;
end;

function TDBXBaseMetaDataWriter.CheckForAutoIncrement(const Columns: TDBXTable): Boolean;
begin
  Columns.First;
  while Columns.InBounds do
  begin
    if Columns.Value[TDBXColumnsIndex.IsAutoIncrement].GetBoolean(False) then
      Exit(True);
    Columns.Next;
  end;
  Result := False;
end;

procedure TDBXBaseMetaDataWriter.InsertValuesFromOldTable(const Buffer: TStringBuilder; const Table: TDBXTableRow; const Columns: TDBXTable; const TempTableName: string);
var
  CurrentColumns: TDBXTable;
  OriginalTable: TDBXTableRow;
  OldCatalogName: string;
  OldSchemaName: string;
  OldTableName: string;
  NewCatalogName: string;
  NewSchemaName: string;
  HasAutoIncrementColumn: Boolean;
  Original: TDBXTableRow;
  Comma: string;
begin
  CurrentColumns := Columns.CreateTableView(TDBXColumnsColumns.Ordinal);
  OriginalTable := Table.OriginalRow;
  OldCatalogName := OriginalTable.Value[TDBXTablesIndex.CatalogName].GetWideString(NullString);
  OldSchemaName := OriginalTable.Value[TDBXTablesIndex.SchemaName].GetWideString(NullString);
  OldTableName := OriginalTable.Value[TDBXTablesIndex.TableName].GetWideString(NullString);
  NewCatalogName := Table.Value[TDBXTablesIndex.CatalogName].GetWideString(NullString);
  NewSchemaName := Table.Value[TDBXTablesIndex.SchemaName].GetWideString(NullString);
  HasAutoIncrementColumn := CheckForAutoIncrement(CurrentColumns);
  if HasAutoIncrementColumn then
    SetIdentityInsert(Buffer, NewCatalogName, NewSchemaName, TempTableName, True);
  Buffer.Append(TDBXSQL.Insert);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.Into);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlObjectName(Buffer, NewCatalogName, NewSchemaName, TempTableName);
  Buffer.Append(TDBXSQL.OpenParen);
  Comma := TDBXSQL.Empty;
  CurrentColumns.First;
  while CurrentColumns.InBounds do
  begin
    Original := CurrentColumns.OriginalRow;
    if Original <> nil then
    begin
      Buffer.Append(Comma);
      Comma := TDBXSQL.Comma;
      MakeSqlIdentifier(Buffer, CurrentColumns.Value[TDBXColumnsIndex.ColumnName].GetWideString(NullString));
    end;
    CurrentColumns.Next;
  end;
  Buffer.Append(TDBXSQL.CloseParen);
  Buffer.Append(TDBXSQL.Nl);
  Buffer.Append(TDBXSQL.Spacing);
  Buffer.Append(TDBXSQL.Select);
  Buffer.Append(TDBXSQL.Space);
  CurrentColumns.First;
  Comma := TDBXSQL.Empty;
  while CurrentColumns.InBounds do
  begin
    Original := CurrentColumns.OriginalRow;
    if Original <> nil then
    begin
      Buffer.Append(Comma);
      Comma := TDBXSQL.Comma;
      if CurrentColumns.Value[TDBXColumnsIndex.TypeName].EqualsValue(Original.Value[TDBXColumnsIndex.TypeName]) and CurrentColumns.Value[TDBXColumnsIndex.Precision].EqualsValue(Original.Value[TDBXColumnsIndex.Precision]) and CurrentColumns.Value[TDBXColumnsIndex.Scale].EqualsValue(Original.Value[TDBXColumnsIndex.Scale]) then
        MakeSqlIdentifier(Buffer, Original.Value[TDBXColumnsIndex.ColumnName].GetWideString(NullString))
      else 
        MakeSqlColumnTypeCast(Buffer, CurrentColumns);
    end;
    CurrentColumns.Next;
  end;
  FreeAndNil(CurrentColumns);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.From);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlObjectName(Buffer, OldCatalogName, OldSchemaName, OldTableName);
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
  if HasAutoIncrementColumn then
    SetIdentityInsert(Buffer, NewCatalogName, NewSchemaName, TempTableName, False);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlColumnTypeCast(const Buffer: TStringBuilder; const Column: TDBXTable);
var
  Original: TDBXTableRow;
begin
  Original := Column.OriginalRow;
  Buffer.Append(TDBXSQL.Cast);
  Buffer.Append(TDBXSQL.OpenParen);
  MakeSqlIdentifier(Buffer, Original.Value[TDBXColumnsIndex.ColumnName].GetWideString(NullString));
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.cAs);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlDataType(Buffer, Column.Value[TDBXColumnsIndex.TypeName].AsString, Column);
  Buffer.Append(TDBXSQL.CloseParen);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlDropTable(const Buffer: TStringBuilder; const Table: TDBXTableRow);
begin
  Buffer.Append(TDBXSQL.Drop);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.Table);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlObjectName(Buffer, Table.Value[TDBXTablesIndex.CatalogName].GetWideString(NullString), Table.Value[TDBXTablesIndex.SchemaName].GetWideString(NullString), Table.Value[TDBXTablesIndex.TableName].GetWideString(NullString));
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

procedure TDBXBaseMetaDataWriter.ReplaceParameter(const Buffer: TStringBuilder; const Start: Integer; const InParameter: string; const Replacement: string);
var
  Marker, Parameter: string;
begin
  Parameter := InParameter;
  Marker := FReader.SqlDefaultParameterMarker;
  Parameter := Marker + Parameter;
  if Replacement.IsEmpty or (Replacement.Length = 0) then
    Parameter := Parameter + TDBXSQL.Dot;
  Buffer.Replace(Parameter,Replacement,Start,Buffer.Length-Start);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlTableRename(const Buffer: TStringBuilder; const CatalogName: string; const SchemaName: string; const TableName: string; const NewTableName: string);
var
  Start: Integer;
begin
  Start := Buffer.Length;
  Buffer.Append(SqlRenameTable);
  ReplaceParameter(Buffer, Start, TDBXParameterName.CatalogName, CatalogName);
  ReplaceParameter(Buffer, Start, TDBXParameterName.SchemaName, SchemaName);
  ReplaceParameter(Buffer, Start, TDBXParameterName.TableName, TableName);
  ReplaceParameter(Buffer, Start, TDBXParameterName.NewSchemaName, SchemaName);
  ReplaceParameter(Buffer, Start, TDBXParameterName.NewTableName, NewTableName);
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

procedure TDBXBaseMetaDataWriter.CopyRow(const Source: TDBXTableRow; const Target: TDBXTable; const Columns: Integer);
var
  Ordinal: Integer;
begin
  for Ordinal := 0 to Columns - 1 do
    Target.Value[Ordinal].SetValue(Source.Value[Ordinal]);
end;

function TDBXBaseMetaDataWriter.Compare(const Table: TDBXTable; const InStart: Integer; const Row: TDBXTableRow; const InRowStart: Integer; const Columns: Integer): Boolean;
var
  Start: Integer;
  RowStart: Integer;
  Index: Integer;
begin
  Start := InStart;
  RowStart := InRowStart;
  for index := 0 to Columns - 1 do
  begin
    if not Row.Value[RowStart].IsNull and not Table.Value[Start].EqualsValue(Row.Value[RowStart]) then
      Exit(False);
    IncrAfter(Start);
    IncrAfter(RowStart);
  end;
  Result := True;
end;

function TDBXBaseMetaDataWriter.SameConstraint(const Table: TDBXTable; const Row: TDBXTableRow; const Columns: Integer): Boolean;
var
  Ordinal: Integer;
begin
  for Ordinal := 0 to Columns - 1 do
  begin
    if not Table.Value[Ordinal].EqualsValue(Row.Value[Ordinal]) then
      Exit(False);
  end;
  Result := True;
end;

procedure TDBXBaseMetaDataWriter.MapTable(const Item: TDBXTable; const Table: TDBXTableRow);
var
  Original: TDBXTableRow;
begin
  Original := Table.OriginalRow;
  if Compare(Item, TDBXIndexesIndex.CatalogName, Original, TDBXTablesIndex.CatalogName, TDBXTablesIndex.TableName - TDBXTablesIndex.CatalogName + 1) then
  begin
    Item.Value[TDBXTablesIndex.CatalogName].SetValue(Table.Value[TDBXTablesIndex.CatalogName]);
    Item.Value[TDBXTablesIndex.SchemaName].SetValue(Table.Value[TDBXTablesIndex.SchemaName]);
    Item.Value[TDBXTablesIndex.TableName].SetValue(Table.Value[TDBXTablesIndex.TableName]);
  end;
end;

function TDBXBaseMetaDataWriter.MapColumn(const Parts: TDBXTable; const Table: TDBXTableRow; const ColumnMap: TDBXProperties; const ColIndex: Integer; const IdColumns: Integer; const DroppedColumn: string): string;
var
  Original: TDBXTableRow;
  ColumnName, MappedName: string;
begin
  if (DroppedColumn.IsEmpty) and (ColIndex >= 0) then
  begin
    Original := Table.OriginalRow;
    if Compare(Parts, ColIndex - IdColumns, Original, TDBXTablesIndex.CatalogName, TDBXTablesIndex.TableName - TDBXTablesIndex.CatalogName + 1) then
    begin
      ColumnName := Parts.Value[ColIndex].AsString;
      MappedName := ColumnMap[ColumnName];
      if MappedName.IsEmpty then
        Exit(ColumnName);
      Parts.Value[ColIndex].SetWideString(MappedName);
      Parts.Value[ColIndex - IdColumns + TDBXTablesIndex.CatalogName].SetValue(Table.Value[TDBXTablesIndex.CatalogName]);
      Parts.Value[ColIndex - IdColumns + TDBXTablesIndex.SchemaName].SetValue(Table.Value[TDBXTablesIndex.SchemaName]);
      Parts.Value[ColIndex - IdColumns + TDBXTablesIndex.TableName].SetValue(Table.Value[TDBXTablesIndex.TableName]);
    end;
  end;
  Result := DroppedColumn;
end;

procedure TDBXBaseMetaDataWriter.CreateConstraints(const Buffer: TStringBuilder; const Columns: TDBXValueTypeArray; const Constraints: TDBXTable; const ConstraintColumns: TDBXTable; const CollectionName: string; const IdColumns: Integer; const ItemColumns: Integer; const PartColumns: Integer; const Table: TDBXTableRow; const ColumnMap: TDBXProperties; const ColIndex1: Integer; const ColIndex2: Integer);
var
  Item, ItemSource, Parts: TDBXTable;
  DroppedColumn: string;
  MoreColumns, MoreItems: Boolean;
begin
  Item := nil;
  Parts := nil;
  try
    Item := FContext.CreateTableStorage(CollectionName, Columns);
    DroppedColumn := NullString;
    Item.First;
    Item.Insert;
    Item.Post;
    MoreItems := True;
    ItemSource := ConstraintColumns;
    if Constraints <> nil then
    begin
      ItemSource := Constraints;
      MoreItems := Constraints.First;
    end;
    MoreColumns := ConstraintColumns.First;
    Parts := FContext.CreateTableStorage(ConstraintColumns.DBXTableName, ConstraintColumns.CopyColumns);
    while MoreColumns and MoreItems do
    begin
      CopyRow(ItemSource, Item, ItemColumns);
      Parts.Clear;
      while MoreColumns and SameConstraint(ConstraintColumns, Item, IdColumns) do
      begin
        Parts.First;
        Parts.Insert;
        CopyRow(ConstraintColumns, Parts, PartColumns);
        DroppedColumn := MapColumn(Parts, Table, ColumnMap, ColIndex1, IdColumns, DroppedColumn);
        DroppedColumn := MapColumn(Parts, Table, ColumnMap, ColIndex2, IdColumns, DroppedColumn);
        Parts.Post;
        MoreColumns := ConstraintColumns.Next;
      end;
      if Constraints <> nil then
        MoreItems := Constraints.Next;
      if DroppedColumn.IsEmpty then
      begin
        MapTable(Item, Table);
        MakeSqlCreate(Buffer, Item, Parts);
      end
      else
      begin
        Buffer.Append(TDBXSQL.LineComment);
        Buffer.Append(TDBXSQL.Space);
        Buffer.Append(string.Format(SCannotRecreateConstraint, [Item.Value[IdColumns - 1].AsString,DroppedColumn]));
        Buffer.Append(TDBXSQL.Nl);
        DroppedColumn := NullString;
      end;
    end;
  finally
    Parts.Free;
    Item.Free;
  end;
end;

procedure TDBXBaseMetaDataWriter.CreateIndices(const Buffer: TStringBuilder; const Table: TDBXTableRow; const Indexes: TDBXTable; const IndexColumns: TDBXTable; const ColumnMap: TDBXProperties);
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateIndexesColumns;
  CreateConstraints(Buffer, Columns, Indexes, IndexColumns, TDBXMetaDataCollectionName.Indexes, TDBXIndexesIndex.IndexName + 1, TDBXIndexesIndex.IsUnique + 1, TDBXIndexColumnsIndex.IsAscending + 1, Table, ColumnMap, TDBXIndexColumnsIndex.ColumnName, -1);
end;

procedure TDBXBaseMetaDataWriter.CreateForeignKeys(const Buffer: TStringBuilder; const Table: TDBXTableRow; const ForeignKeyColumns: TDBXTable; const ColumnMap: TDBXProperties);
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateForeignKeysColumns;
  CreateConstraints(Buffer, Columns, nil, ForeignKeyColumns, TDBXMetaDataCollectionName.ForeignKeys, TDBXForeignKeysIndex.ForeignKeyName + 1, TDBXForeignKeysIndex.ForeignKeyName + 1, TDBXForeignKeyColumnsIndex.Ordinal + 1, Table, ColumnMap, TDBXForeignKeyColumnsIndex.ColumnName, TDBXForeignKeyColumnsIndex.PrimaryColumnName);
end;

function TDBXBaseMetaDataWriter.CanCreateIndexAsKey(const Index: TDBXTableRow; const IndexColumns: TDBXTable): Boolean;
begin
  if not DescendingIndexConstraintsSupported and (IndexColumns <> nil) then
  begin
    IndexColumns.First;
    while IndexColumns.InBounds do
    begin
      if not IndexColumns.Value[TDBXIndexColumnsIndex.IsAscending].GetBoolean(True) then
        Exit(False);
      IndexColumns.Next;
    end;
  end;
  if not Index.Value[TDBXIndexesIndex.IsPrimary].GetBoolean(False) and not Index.Value[TDBXIndexesIndex.IsUnique].GetBoolean(False) then
    Exit(False);
  Result := True;
end;

procedure TDBXBaseMetaDataWriter.MakeSqlCreateIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow; const IndexColumns: TDBXTable);
begin
  if CanCreateIndexAsKey(Index, IndexColumns) then
    MakeSqlCreateKey(Buffer, Index, IndexColumns)
  else 
    MakeSqlCreateSecondaryIndex(Buffer, Index, IndexColumns);
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlDropIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow);
begin
  if not Index.Value[TDBXIndexesIndex.ConstraintName].IsNull then
    MakeSqlDropConstraint(Buffer, Index)
  else 
    MakeSqlDropSecondaryIndex(Buffer, Index);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlCreateKey(const Buffer: TStringBuilder; const Index: TDBXTableRow; const IndexColumns: TDBXTable);
begin
  MakeSqlCreateConstraint(Buffer, Index);
  if Index.Value[TDBXIndexesIndex.IsPrimary].GetBoolean(False) then
  begin
    Buffer.Append(TDBXSQL.Primary);
    Buffer.Append(TDBXSQL.Space);
    Buffer.Append(TDBXSQL.Key);
  end
  else 
    Buffer.Append(TDBXSQL.Unique);
  MakeSqlCreateIndexColumnList(Buffer, IndexColumns);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlCreateSecondaryIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow; const IndexColumns: TDBXTable);
begin
  Buffer.Append(TDBXSQL.Create);
  Buffer.Append(TDBXSQL.Space);
  if Index.Value[TDBXIndexesIndex.IsUnique].GetBoolean(False) or Index.Value[TDBXIndexesIndex.IsPrimary].GetBoolean(False) then
  begin
    Buffer.Append(TDBXSQL.Unique);
    Buffer.Append(TDBXSQL.Space);
  end;
  if FReader.DescendingIndexSupported and not Index.Value[TDBXIndexesIndex.IsAscending].GetBoolean(True) then
  begin
    Buffer.Append(TDBXSQL.Descending);
    Buffer.Append(TDBXSQL.Space);
  end;
  Buffer.Append(TDBXSQL.Index);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlIdentifier(Buffer, Index.Value[TDBXIndexesIndex.IndexName].GetWideString(NullString));
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.cOn);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlObjectName(Buffer, Index.Value[TDBXIndexesIndex.CatalogName].GetWideString(NullString), Index.Value[TDBXIndexesIndex.SchemaName].GetWideString(NullString), Index.Value[TDBXIndexesIndex.TableName].GetWideString(NullString));
  MakeSqlCreateIndexColumnList(Buffer, IndexColumns);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlCreateConstraint(const Buffer: TStringBuilder; const Constraint: TDBXTableRow);
begin
  MakeSqlAlterTablePrefix(Buffer, Constraint);
  Buffer.Append(TDBXSQL.Add);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlConstraintName(Buffer, Constraint);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlConstraintName(const Buffer: TStringBuilder; const Constraint: TDBXTableRow);
var
  ConstraintName: string;
begin
  ConstraintName := NullString;
  if (Constraint.DBXTableName = TDBXMetaDataCollectionName.Indexes) then
    ConstraintName := Constraint.Value[TDBXIndexesIndex.ConstraintName].GetWideString(NullString);
  if ConstraintName.IsEmpty then
    ConstraintName := Constraint.Value[TDBXForeignKeysIndex.ForeignKeyName].AsString;
  if (not ConstraintName.IsEmpty) and (ConstraintName.Length > 0) then
  begin
    Buffer.Append(TDBXSQL.Constraint);
    Buffer.Append(TDBXSQL.Space);
    MakeSqlIdentifier(Buffer, ConstraintName);
    Buffer.Append(TDBXSQL.Space);
  end;
end;

procedure TDBXBaseMetaDataWriter.MakeSqlAlterTablePrefix(const Buffer: TStringBuilder; const Item: TDBXTableRow);
begin
  Buffer.Append(TDBXSQL.Alter);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.Table);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlObjectName(Buffer, Item.Value[TDBXForeignKeysIndex.CatalogName].GetWideString(NullString), Item.Value[TDBXForeignKeysIndex.SchemaName].GetWideString(NullString), Item.Value[TDBXForeignKeysIndex.TableName].GetWideString(NullString));
  Buffer.Append(TDBXSQL.Space);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlDropConstraint(const Buffer: TStringBuilder; const Constraint: TDBXTableRow);
var
  ConstraintName: string;
begin
  MakeSqlAlterTablePrefix(Buffer, Constraint);
  ConstraintName := NullString;
  if (Constraint.DBXTableName = TDBXMetaDataCollectionName.Indexes) then
    ConstraintName := Constraint.Value[TDBXIndexesIndex.ConstraintName].GetWideString(NullString);
  if ConstraintName.IsEmpty then
    ConstraintName := Constraint.Value[TDBXForeignKeysIndex.ForeignKeyName].AsString;
  Buffer.Append(TDBXSQL.Drop);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.Constraint);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlIdentifier(Buffer, ConstraintName);
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlCreateIndexColumnList(const Buffer: TStringBuilder; const IndexColumns: TDBXTable);
var
  Columns: TDBXTable;
  Comma: string;
begin
  Buffer.Append(TDBXSQL.Nl);
  Buffer.Append(TDBXSQL.Spacing);
  Buffer.Append(TDBXSQL.OpenParen);
  Columns := IndexColumns.CreateTableView(TDBXIndexColumnsColumns.Ordinal);
  Columns.First;
  Comma := TDBXSQL.Empty;
  while Columns.InBounds do
  begin
    Buffer.Append(Comma);
    Comma := TDBXSQL.Comma + TDBXSQL.Space;
    MakeSqlIdentifier(Buffer, Columns.Value[TDBXIndexColumnsIndex.ColumnName].GetWideString(NullString));
    if FReader.DescendingIndexColumnsSupported and not Columns.Value[TDBXIndexColumnsIndex.IsAscending].GetBoolean(True) then
    begin
      Buffer.Append(TDBXSQL.Space);
      Buffer.Append(TDBXSQL.Descending);
    end;
    Columns.Next;
  end;
  FreeAndNil(Columns);
  Buffer.Append(TDBXSQL.CloseParen);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlDropSecondaryIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow);
begin
  Buffer.Append(TDBXSQL.Drop);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.Index);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlIdentifier(Buffer, Index.Value[TDBXIndexesIndex.IndexName].GetWideString(NullString));
  if not IndexNamesGlobal then
  begin
    Buffer.Append(TDBXSQL.Space);
    Buffer.Append(TDBXSQL.cOn);
    Buffer.Append(TDBXSQL.Space);
    MakeSqlObjectName(Buffer, Index.Value[TDBXIndexesIndex.CatalogName].GetWideString(NullString), Index.Value[TDBXIndexesIndex.SchemaName].GetWideString(NullString), Index.Value[TDBXIndexesIndex.TableName].GetWideString(NullString));
  end;
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlForeignKeySyntax(const Buffer: TStringBuilder; const ForeignKey: TDBXTableRow; const ForeignKeyColumns: TDBXTable);
var
  Columns: TDBXTable;
  Comma: string;
begin
  Buffer.Append(TDBXSQL.Foreign);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.Key);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.OpenParen);
  Columns := ForeignKeyColumns.CreateTableView(TDBXForeignKeyColumnsColumns.Ordinal);
  Columns.First;
  Comma := TDBXSQL.Empty;
  while Columns.InBounds do
  begin
    Buffer.Append(Comma);
    Comma := TDBXSQL.Comma + TDBXSQL.Space;
    MakeSqlIdentifier(Buffer, Columns.Value[TDBXForeignKeyColumnsIndex.ColumnName].GetWideString(NullString));
    Columns.Next;
  end;
  Buffer.Append(TDBXSQL.CloseParen);
  Columns.First;
  Buffer.Append(TDBXSQL.Nl);
  Buffer.Append(TDBXSQL.Spacing);
  Buffer.Append(TDBXSQL.References);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlObjectName(Buffer, Columns.Value[TDBXForeignKeyColumnsIndex.PrimaryCatalogName].GetWideString(NullString), Columns.Value[TDBXForeignKeyColumnsIndex.PrimarySchemaName].GetWideString(NullString), Columns.Value[TDBXForeignKeyColumnsIndex.PrimaryTableName].GetWideString(NullString));
  Buffer.Append(TDBXSQL.OpenParen);
  Columns.First;
  Comma := TDBXSQL.Empty;
  while Columns.InBounds do
  begin
    Buffer.Append(Comma);
    Comma := TDBXSQL.Comma + TDBXSQL.Space;
    MakeSqlIdentifier(Buffer, Columns.Value[TDBXForeignKeyColumnsIndex.PrimaryColumnName].GetWideString(NullString));
    Columns.Next;
  end;
  Buffer.Append(TDBXSQL.CloseParen);
  FreeAndNil(Columns);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlCreateForeignKey(const Buffer: TStringBuilder; const ForeignKey: TDBXTableRow; const ForeignKeyColumns: TDBXTable);
begin
  MakeSqlCreateConstraint(Buffer, ForeignKey);
  MakeSqlForeignKeySyntax(Buffer, ForeignKey, ForeignKeyColumns);
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlDropForeignKey(const Buffer: TStringBuilder; const ForeignKey: TDBXTableRow);
begin
  MakeSqlDropConstraint(Buffer, ForeignKey);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlCreateView(const Buffer: TStringBuilder; const View: TDBXTableRow; const Columns: TDBXTable);
begin
  Buffer.Append(View.Value[TDBXViewsIndex.Definition].GetWideString(NullString));
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlAlterView(const Buffer: TStringBuilder; const View: TDBXTableRow; const Columns: TDBXTable);
var
  Definition: string;
begin
  Definition := View.Value[TDBXViewsIndex.Definition].GetWideString(NullString);
  Definition := Definition.Trim;
  if (Definition.Length < TDBXSQL.Create.Length) or not (Definition.Substring(0, TDBXSQL.Create.Length).ToUpper = TDBXSQL.Create) then
    raise TDBXMetaDataError.Create(SWrongViewDefinition);
  Buffer.Append(TDBXSQL.Alter);
  Buffer.Append(Definition.Substring(TDBXSQL.Create.Length, Definition.Length - TDBXSQL.Create.Length));
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlDropView(const Buffer: TStringBuilder; const View: TDBXTableRow);
begin
  Buffer.Append(TDBXSQL.Drop);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.View);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlObjectName(Buffer, View.Value[TDBXViewsIndex.CatalogName].AsString, View.Value[TDBXViewsIndex.SchemaName].AsString, View.Value[TDBXViewsIndex.ViewName].AsString);
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlCreateSynonym(const Buffer: TStringBuilder; const Synonym: TDBXTableRow; const Columns: TDBXTable);
begin
  Buffer.Append(TDBXSQL.Create);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.Synonym);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlObjectName(Buffer, Synonym.Value[TDBXSynonymsIndex.CatalogName].GetWideString(NullString), Synonym.Value[TDBXSynonymsIndex.SchemaName].GetWideString(NullString), Synonym.Value[TDBXSynonymsIndex.SynonymName].GetWideString(NullString));
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.cFor);
  MakeSqlObjectName(Buffer, Synonym.Value[TDBXSynonymsIndex.TableCatalogName].GetWideString(NullString), Synonym.Value[TDBXSynonymsIndex.TableSchemaName].GetWideString(NullString), Synonym.Value[TDBXSynonymsIndex.TableName].GetWideString(NullString));
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlAlterSynonym(const Buffer: TStringBuilder; const Synonym: TDBXTableRow; const Columns: TDBXTable);
begin
  MakeSqlDropSynonym(Buffer, Synonym);
  MakeSqlCreateSynonym(Buffer, Synonym, Columns);
end;

procedure TDBXBaseMetaDataWriter.MakeSqlDropSynonym(const Buffer: TStringBuilder; const Synonym: TDBXTableRow);
begin
  Buffer.Append(TDBXSQL.Drop);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.Synonym);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlObjectName(Buffer, Synonym.Value[TDBXSynonymsIndex.CatalogName].GetWideString(NullString), Synonym.Value[TDBXSynonymsIndex.SchemaName].GetWideString(NullString), Synonym.Value[TDBXSynonymsIndex.SynonymName].GetWideString(NullString));
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

end.
