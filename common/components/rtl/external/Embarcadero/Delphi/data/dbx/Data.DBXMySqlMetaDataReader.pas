{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXMySqlMetaDataReader;

interface

uses
  Data.DBXCommon,
  Data.DBXCommonTable,
  Data.DBXMetaDataNames,
  Data.DBXMetaDataReader,
  Data.DBXPlatform,
  Data.DBXSqlScanner;

type
  
  /// <summary>  TDBXMySqlCustomMetaDataReader contains custom code for MySQL.
  /// </summary>
  /// <remarks>  For MySQL version 4 and earlier the output of SHOW commands are filtered
  ///   into metadata schema table structures.
  ///   For MySQL version 5 and up the system views are filtered for MySQL specifics.
  /// </remarks>
  TDBXMySqlCustomMetaDataReader = class(TDBXBaseMetaDataReader)
  public
    type
      /// <summary> TMySqlColumnType holds a data type definition.
      /// </summary>
      TMySqlColumnType = class
      public
        FDataType: string;
        FPrecision: Integer;
        FScale: Integer;
        FUnsigned: Boolean;
        FUnicode: Boolean;
        FNotnull: Boolean;
      end;

      TMySqlParameter = class(TDBXMySqlCustomMetaDataReader.TMySqlColumnType)
      public
        FName: string;
        FMode: string;
        FOrdinal: Integer;
      end;

      TMySqlForeignKey = class
      public
        constructor Create;
        destructor Destroy; override;
        procedure Reset; virtual;
      public
        FConstraintName: string;
        FKeyColumns: TDBXStringList;
        FReferencedTableName: string;
        FReferencedColumns: TDBXStringList;
      end;
            
      /// <summary>  TDBXMySql4TablesCursor is a filter for a cursor providing tables.
      /// </summary>
      /// <remarks>  This filter takes the output from "SHOW TABLES" and transforms it into a Tables schema table.
      /// </remarks>
      TDBXMySql4TablesCursor = class(TDBXCustomMetaDataTable)
      public
        destructor Destroy; override;
      protected
        constructor Create(const Reader: TDBXMySqlCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable);
        function FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer; override;
        function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
      public
        FTableValue: TDBXWritableValue;
        FNullValue: TDBXWritableValue;
      private
        const ShowTablesTableNameOrdinal = 0;
      end;
            
      /// <summary>  TDBXMySqlColumnsTableCursor provides IsUnicode based on the character
      ///   set of the column.
      /// </summary>
      TDBXMySqlColumnsTableCursor = class(TDBXColumnsTableCursor)
      public
        constructor Create(const Reader: TDBXMySqlCustomMetaDataReader; const Version5: Boolean; const Original: TDBXTable; const Sanitized: TDBXTable);
        destructor Destroy; override;
        function Next: Boolean; override;
      protected
        function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
      public
        FRow: TDBXSingleValueRow;
      private
        FOriginal: TDBXTable;
        FVersion5: Boolean;
      private
        const MysqlIsUnicode = TDBXColumnsIndex.DbxDataType;
        const MysqlIsUnsigned = TDBXColumnsIndex.DbxDataType + 1;
      end;

      /// <summary>  TDBXMySql4ColumnsCursor is a filter for a cursor providing table columns.
      /// </summary>
      /// <remarks>  This filter takes the output from "SHOW COLUMNS FROM [tablename]" and transforms it into a Columns schema table.
      /// </remarks>
      TDBXMySql4ColumnsCursor = class(TDBXCustomMetaDataTable)
      public
        destructor Destroy; override;
        procedure Close; override;
        function Next: Boolean; override;
      protected
        constructor Create(const Reader: TDBXMySqlCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Sql: string; const TableName: string);
        function FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer; override;
        function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
      private
        function InitNextCursor: Boolean;
        function ComputeDefaultValue: string;
        function ComputeAutoIncrement: Boolean;
        function ComputeNullable: Boolean;
      private
        FReader: TDBXMySqlCustomMetaDataReader;
        FTables: TDBXStringList;
        FTableIndex: Integer;
        FSql: string;
        FTableName: string;
        FColumnNumber: Integer;
        FColumnType: TDBXMySqlCustomMetaDataReader.TMySqlColumnType;
        FRow: TDBXSingleValueRow;
      private
        const ShowColumnsFieldOrdinal = 0;
        const ShowColumnsTypeOrdinal = 1;
        const ShowColumnsNullOrdinal = 2;
        const ShowColumnsKeyOrdinal = 3;
        const ShowColumnsDefaultOrdinal = 4;
        const ShowColumnsExtraOrdinal = 5;
      end;
            
      /// <summary>  TDBXMySql4IndexesCursor is a filter for a cursor providing indexes.
      /// </summary>
      /// <remarks>  This filter takes the output from "SHOW INDEX FROM [tablename]" and transforms it into a Indexes schema table.
      /// </remarks>
      TDBXMySql4IndexesCursor = class(TDBXCustomMetaDataTable)
      public
        destructor Destroy; override;
        procedure Close; override;
        function Next: Boolean; override;
      protected
        constructor Create(const Reader: TDBXMySqlCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Sql: string; const TableName: string);
        function FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer; override;
        function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
      private
        function InitNextCursor: Boolean;
        function ComputeConstraintName: string;
      private
        FReader: TDBXMySqlCustomMetaDataReader;
        FTables: TDBXStringList;
        FTableIndex: Integer;
        FSql: string;
        FTableName: string;
        FUniqueIndex: Boolean;
        FIndexName: string;
        FPrevIndexName: string;
        FPrevTableName: string;
        FRow: TDBXSingleValueRow;
      private
        const ShowIndexTableOrdinal = 0;
        const ShowIndexNonUniqueOrdinal = 1;
        const ShowIndexKeyNameOrdinal = 2;
        const ShowIndexSeqInIndexOrdinal = 3;
        const ShowIndexColumnNameOrdinal = 4;
        const ShowIndexCollationOrdinal = 5;
        const ShowIndexCardinalityOrdinal = 6;
        const ShowIndexSubPartOrdinal = 7;
        const ShowIndexPackedOrdinal = 8;
        const ShowIndexNullOrdinal = 9;
        const ShowIndexIndexTypeOrdinal = 10;
        const ShowIndexCommentOrdinal = 11;
      end;
            
      /// <summary>  TDBXMySql4IndexColumnsCursor is a filter for a cursor providing index columns.
      /// </summary>
      /// <remarks>  This filter takes the output from "SHOW INDEX FROM [tablename]" and transforms it into a IndexColumns schema table.
      /// </remarks>
      TDBXMySql4IndexColumnsCursor = class(TDBXCustomMetaDataTable)
      public
        destructor Destroy; override;
        procedure Close; override;
        function Next: Boolean; override;
      protected
        constructor Create(const Reader: TDBXMySqlCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Sql: string; const TableName: string; const IndexName: string);
        function FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer; override;
        function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
      private
        function InitNextCursor: Boolean;
      private
        FReader: TDBXMySqlCustomMetaDataReader;
        FTables: TDBXStringList;
        FTableIndex: Integer;
        FSql: string;
        FWantedIndexName: string;
        FTableName: string;
        FIndexName: string;
        FRow: TDBXSingleValueRow;
      private
        const ShowIndexTableOrdinal = 0;
        const ShowIndexNonUniqueOrdinal = 1;
        const ShowIndexKeyNameOrdinal = 2;
        const ShowIndexSeqInIndexOrdinal = 3;
        const ShowIndexColumnNameOrdinal = 4;
        const ShowIndexCollationOrdinal = 5;
        const ShowIndexCardinalityOrdinal = 6;
        const ShowIndexSubPartOrdinal = 7;
        const ShowIndexPackedOrdinal = 8;
        const ShowIndexNullOrdinal = 9;
        const ShowIndexIndexTypeOrdinal = 10;
        const ShowIndexCommentOrdinal = 11;
      end;

      /// <summary>  TDBXMySql4ForeignKeyCursor is a filter for a cursor providing foreign keys.
      /// </summary>
      /// <remarks>  This filter takes the output from "SHOW CREATE TABLE [tablename]" and transforms it into a ForeignKey schema table.
      /// </remarks>
      TDBXMySql4ForeignKeyCursor = class(TDBXCustomMetaDataTable)
      public
        destructor Destroy; override;
        procedure Close; override;
        function Next: Boolean; override;
      protected
        constructor Create(const Reader: TDBXMySqlCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Sql: string; const TableName: string);
        function FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer; override;
        function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
      private
        function InitNextCursor: Boolean;
      public
        FKey: TDBXMySqlCustomMetaDataReader.TMySqlForeignKey;
        FRow: TDBXSingleValueRow;
      private
        FReader: TDBXMySqlCustomMetaDataReader;
        FTables: TDBXStringList;
        FTableIndex: Integer;
        FSql: string;
        FTableName: string;
        FSqlCreateTable: string;
        FParseIndex: Integer;
      private
        const ShowCreateTableSqlOrdinal = 1;
      end;

      /// <summary>  TDBXMySql4ForeignKeyColumnsCursor is a filter for a cursor providing foreign key columns.
      /// </summary>
      /// <remarks>  This filter takes the output from "SHOW CREATE TABLE [tablename]" and transforms it into a ForeignKeyColumns schema table.
      /// </remarks>
      TDBXMySql4ForeignKeyColumnsCursor = class(TDBXCustomMetaDataTable)
      public
        destructor Destroy; override;
        procedure Close; override;
        function Next: Boolean; override;
      protected
        constructor Create(const Reader: TDBXMySqlCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Sql: string; const TableName: string; const ForeignKeyName: string; const PrimaryTableName: string; const PrimaryKeyName: string);
        function FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer; override;
        function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
      private
        function InitNextCursor: Boolean;
        procedure SetValues;
      public
        FKey: TDBXMySqlCustomMetaDataReader.TMySqlForeignKey;
      private
        FReader: TDBXMySqlCustomMetaDataReader;
        FTables: TDBXStringList;
        FTableIndex: Integer;
        FSql: string;
        FTableName: string;
        FForeignKeyName: string;
        FPrimaryTableName: string;
        FPrimaryKeyName: string;
        FSqlCreateTable: string;
        FParseIndex: Integer;
        FKeyIndex: Integer;
        FRow: TDBXSingleValueRow;
      private
        const ShowCreateTableSqlOrdinal = 1;
      end;

      /// <summary>  TDBXMySqlProcedureSourcesCursor is a filter for a cursor providing procedure sources.
      /// </summary>
      /// <remarks>  This filter takes the output from "SHOW CREATE PROCEDURE <procname>" and transforms it into a ProcedureSources schema table.
      /// </remarks>
      TDBXMySqlProcedureSourcesCursor = class(TDBXCustomMetaDataTable)
      public
        destructor Destroy; override;
        procedure Close; override;
        function Next: Boolean; override;
      protected
        constructor Create(const Reader: TDBXMySqlCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Sql: string; const SchemaName: string; const ProcedureName: string);
        function FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer; override;
        function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
      private
        function InitNextCursor: Boolean;
        function ComputeDefinition: string;
        function ComputeDefiner: string;
      private
        FReader: TDBXMySqlCustomMetaDataReader;
        FProcedures: TDBXStringList;
        FProcedureTypes: TDBXStringList;
        FProcedureIndex: Integer;
        FSql: string;
        FProcedureName: string;
        FProcedureType: string;
        FDefiner: string;
        FRow: TDBXSingleValueRow;
      private
        const ShowCreateProcedureSqlOrdinal = 2;
        const DefinerString = 'DEFINER=';
      end;

      TDBXMySqlProcedureParametersCursor = class(TDBXCustomMetaDataTable)
      public
        destructor Destroy; override;
        procedure Close; override;
        function Next: Boolean; override;
      protected
        constructor Create(const Reader: TDBXMySqlCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Sql: string; const SchemaName: string; const ProcedureName: string; const ParameterName: string);
        function FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer; override;
        function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
      private
        function InitNextCursor: Boolean;
        procedure SetValues;
        procedure ComputeParams;
      private
        FReader: TDBXMySqlCustomMetaDataReader;
        FProcedures: TDBXStringList;
        FProcedureTypes: TDBXStringList;
        FProcedureIndex: Integer;
        FParameterIndex: Integer;
        FSql: string;
        FProcedureName: string;
        FParameterName: string;
        FProcedureType: string;
        FDefiner: string;
        FParams: TDBXArrayList;
        FParameter: TDBXMySqlCustomMetaDataReader.TMySqlParameter;
        FRow: TDBXSingleValueRow;
      private
        const ShowCreateProcedureSqlOrdinal = 2;
        const DefinerString = 'DEFINER=';
      end;

  public
    destructor Destroy; override;
    
    /// <summary>  Overrides the implementation in TDBXBaseMetaDataReader.
    /// </summary>
    /// <remarks>  Allthough MySQL does not support schemas, catalogs are reported as schemas
    ///   in MySQL version 5.
    /// </remarks>
    function FetchSchemas(const Catalog: string): TDBXTable; override;
    
    /// <summary>  Overrides the implementation in TDBXBaseMetaDataReader.
    /// </summary>
    /// <remarks>  Use a special filter for MySQL 4 to convert output from "SHOW TABLES".
    /// </remarks>
    function FetchTables(const Catalog: string; const Schema: string; const TableName: string; const TableType: string): TDBXTable; override;
    
    /// <summary>  Overrides the implementation in TDBXBaseMetaDataReader.
    /// </summary>
    /// <remarks>  Note: views did not exist in MySQL prior to version 5.
    /// </remarks>
    function FetchViews(const Catalog: string; const Schema: string; const View: string): TDBXTable; override;
    
    /// <summary>  Overrides the implementation in TDBXBaseMetaDataReader.
    /// </summary>
    /// <remarks>  Use a special filter for MySQL 4 to convert output from "SHOW COLUMNS FROM [tablename]".
    /// </remarks>
    /// <seealso cref="TDBXMySql4ColumnsCursor"/>
    function FetchColumns(const Catalog: string; const Schema: string; const Table: string): TDBXTable; override;
    
    /// <summary>  Overrides the implementation in TDBXBaseMetaDataReader.
    /// </summary>
    /// <remarks>  Use a special filter for MySQL 4 to convert output from "SHOW INDEX FROM [tablename]".
    /// </remarks>
    /// <seealso cref="TDBXMySql4IndexesCursor"/>
    function FetchIndexes(const Catalog: string; const Schema: string; const Table: string): TDBXTable; override;
    
    /// <summary>  Overrides the implementation in TDBXBaseMetaDataReader.
    /// </summary>
    /// <remarks>  Use a special filter for MySQL 4 to convert output from "SHOW INDEX FROM [tablename]".
    /// </remarks>
    /// <seealso cref="TDBXMySql4IndexColumnsCursor"/>
    function FetchIndexColumns(const Catalog: string; const Schema: string; const Table: string; const Index: string): TDBXTable; override;
    function FetchForeignKeys(const Catalog: string; const Schema: string; const Table: string): TDBXTable; override;
    function FetchForeignKeyColumns(const Catalog: string; const Schema: string; const Table: string; const ForeignKeyName: string; const PrimaryCatalog: string; const PrimarySchema: string; const PrimaryTable: string; const PrimaryKeyName: string): TDBXTable; override;
    function FetchProcedures(const Catalog: string; const Schema: string; const ProcedureName: string; const ProcType: string): TDBXTable; override;
    function FetchProcedureSources(const Catalog: string; const Schema: string; const Proc: string): TDBXTable; override;
    function FetchProcedureParameters(const Catalog: string; const Schema: string; const Proc: string; const Parameter: string): TDBXTable; override;
    function FetchUsers: TDBXTable; override;
  protected
    procedure SetContext(const Context: TDBXProviderContext); override;
    function IsDefaultCharSetUnicode: Boolean; virtual;
    procedure PopulateDataTypes(const Hash: TDBXObjectStore; const Types: TDBXArrayList; const Descr: TDBXDataTypeDescriptionArray); override;
    function GetDataTypeDescriptions: TDBXDataTypeDescriptionArray; override;
    function GetTables: TDBXStringList;
    function FindDataType(const TypeName: string): Integer; virtual;
  private
    procedure InitScanner;
    procedure GetProcedures(const SchemaName: string; const ProcedureName: string; const Procedures: TDBXStringList; const ProcedureTypes: TDBXStringList);
    function ParseProcedureDefiner(const Definition: string): string;
    procedure ParseProcedure(const Definition: string; const aType: string; const Params: TDBXArrayList);
    function ParseType(const Definition: string; const aType: TDBXMySqlCustomMetaDataReader.TMySqlColumnType): Integer;
    function ReplaceIdentifier(const Sql: string; const ParameterName: string; const ActualValue: string; const MakeQuotes: Boolean): string;
    function ToInt(const Value: string): Integer;
    function ParseIdList(const Scanner: TDBXSqlScanner; const List: TDBXStringList): Boolean;
    function ParseForeignKey(const Scanner: TDBXSqlScanner; const ForeignKey: TDBXMySqlCustomMetaDataReader.TMySqlForeignKey): Boolean;
    function ParseCreateTableForNextForeignKey(const Sql: string; const InStartIndex: Integer; const Key: TDBXMySqlCustomMetaDataReader.TMySqlForeignKey): Integer;
  protected
    FScanner: TDBXSqlScanner;
  private
    FDefaultCharSetIsUnicode: Boolean;
  public
    property DefaultCharSetUnicode: Boolean read IsDefaultCharSetUnicode;
  private
    property Tables: TDBXStringList read GetTables;
  private
    const DefaultCharsetIsUnicode = 'UnicodeEncoding';
    const YForYes = 'Y';
    const AForAscending = 'A';
    const FAuto_increment = 'auto_increment';
    const IntegerType = 'integer';
    const IntType = 'int';
    const DecimalType = 'decimal';
    const DecType = 'dec';
    const Table = 'TABLE';
    const Constraint = 'CONSTRAINT';
    const Foreign = 'FOREIGN';
    const Key = 'KEY';
    const References = 'REFERENCES';
    const Quote = '''';
    const FYear = 'year';
    const CurrentTimestamp = 'CURRENT_TIMESTAMP';
    const Primary = 'PRIMARY';
    const Proc = 'PROCEDURE';
    const cFunction = 'FUNCTION';
    const cBegin = 'BEGIN';
    const cCreate = 'CREATE';
    const Definer = 'DEFINER';
    const Returns = 'RETURNS';
    const Character = 'CHARACTER';
    const cSet = 'SET';
    const Utf8 = 'utf8';
    const cIn = 'IN';
    const cOut = 'OUT';
    const Inout = 'INOUT';
    const Unsigned = 'UNSIGNED';
    const cNot = 'NOT';
    const NullSpec = 'NULL';
    const Binary = 'BINARY';
    const Varbinary = 'VARBINARY';
    const DefaultVarcharPrecision = 128;
    const TokenProcedure = 1;
    const TokenFunction = 2;
    const TokenReturns = 3;
    const TokenBegin = 4;
    const TokenIn = 5;
    const TokenOut = 6;
    const TokenInout = 7;
    const TokenCharacter = 8;
    const TokenSet = 9;
    const TokenUtf8 = 10;
    const TokenUnsigned = 11;
    const TokenCreate = 12;
    const TokenDefiner = 13;
    const TokenNot = 14;
    const TokenNull = 15;
    const TokenBinary = 16;
  end;

  TDBXMySqlMetaDataReader = class(TDBXMySqlCustomMetaDataReader)
  public
    function FetchCatalogs: TDBXTable; override;
    function FetchSchemas(const CatalogName: string): TDBXTable; override;
    function FetchColumnConstraints(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable; override;
    function FetchSynonyms(const CatalogName: string; const SchemaName: string; const SynonymName: string): TDBXTable; override;
    function FetchPackages(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable; override;
    function FetchPackageProcedures(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ProcedureType: string): TDBXTable; override;
    function FetchPackageProcedureParameters(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ParameterName: string): TDBXTable; override;
    function FetchPackageSources(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable; override;
    function FetchRoles: TDBXTable; override;
  protected
    function GetProductName: string; override;
    function GetSqlIdentifierQuotePrefix: string; override;
    function GetSqlIdentifierQuoteSuffix: string; override;
    function GetSqlIdentifierQuoteChar: string; override;
    function GetTableType: string; override;
    function IsDescendingIndexColumnsSupported: Boolean; override;
    function IsLowerCaseIdentifiersSupported: Boolean; override;
    function IsUpperCaseIdentifiersSupported: Boolean; override;
    function IsMultipleCommandsSupported: Boolean; override;
    function GetSqlForTables: string; override;
    function GetSqlForViews: string; override;
    function GetSqlForColumns: string; override;
    function GetSqlForIndexes: string; override;
    function GetSqlForIndexColumns: string; override;
    function GetSqlForForeignKeys: string; override;
    function GetSqlForForeignKeyColumns: string; override;
    function GetSqlForProcedures: string; override;
    function GetSqlForProcedureSources: string; override;
    function GetSqlForProcedureParameters: string; override;
    function GetSqlForUsers: string; override;
    function GetReservedWords: TDBXStringArray; override;
  end;

implementation

uses
  Data.DBXMetaDataUtil,
  System.SysUtils
{$IFDEF MACOS}
  , Macapi.CoreFoundation
{$ENDIF MACOS}
;

destructor TDBXMySqlCustomMetaDataReader.Destroy;
begin
  FreeAndNil(FScanner);
  inherited Destroy;
end;

procedure TDBXMySqlCustomMetaDataReader.SetContext(const Context: TDBXProviderContext);
begin
  inherited SetContext(Context);
  FDefaultCharSetIsUnicode := (Context.GetVendorProperty(DefaultCharsetIsUnicode) = 'true');
end;

function TDBXMySqlCustomMetaDataReader.IsDefaultCharSetUnicode: Boolean;
begin
  Result := FDefaultCharSetIsUnicode;
end;

procedure TDBXMySqlCustomMetaDataReader.PopulateDataTypes(const Hash: TDBXObjectStore; const Types: TDBXArrayList; const Descr: TDBXDataTypeDescriptionArray);
var
  Index: Integer;
  DataType: TDBXDataTypeDescription;
begin
  if FDefaultCharSetIsUnicode or (CompareVersion(TDBXVersion.FMySQL5) >= 0) then
    for Index := 0 to Length(Descr) - 1 do
    begin
      DataType := Descr[Index];
      if (DataType.DbxDataType = TDBXDataTypes.AnsiStringType) or (DataType.DbxDataType = TDBXDataTypes.WideStringType) then
        DataType.UnicodeOptionSupported := True;
    end;
  inherited PopulateDataTypes(Hash, Types, Descr);
end;

function TDBXMySqlCustomMetaDataReader.GetDataTypeDescriptions: TDBXDataTypeDescriptionArray;
var
  StringType: Integer;
  Types: TDBXDataTypeDescriptionArray;
begin
  StringType := TDBXDataTypes.AnsiStringType;
  if FDefaultCharSetIsUnicode then
    StringType := TDBXDataTypes.WideStringType;
  SetLength(Types,32);
  Types[0] := TDBXDataTypeDescription.Create('tinyint', TDBXDataTypes.Int8Type, 3, 'tinyint', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.AutoIncrementable or TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.UnsignedOption);
  Types[1] := TDBXDataTypeDescription.Create('smallint', TDBXDataTypes.Int16Type, 5, 'smallint', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.AutoIncrementable or TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.UnsignedOption);
  Types[2] := TDBXDataTypeDescription.Create('int', TDBXDataTypes.Int32Type, 10, 'int', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.AutoIncrementable or TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.UnsignedOption);
  Types[3] := TDBXDataTypeDescription.Create('mediumint', TDBXDataTypes.Int64Type, 19, 'mediumint', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.AutoIncrementable or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.UnsignedOption);
  Types[4] := TDBXDataTypeDescription.Create('bigint', TDBXDataTypes.Int64Type, 19, 'bigint', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.AutoIncrementable or TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.UnsignedOption);
  Types[5] := TDBXDataTypeDescription.Create('float', TDBXDataTypes.SingleType, 23, 'float', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[6] := TDBXDataTypeDescription.Create('double', TDBXDataTypes.DoubleType, 53, 'double', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[7] := TDBXDataTypeDescription.Create('decimal', TDBXDataTypes.BcdType, 64, 'decimal({0}, {1})', 'Precision, Scale', 64, 0, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[8] := TDBXDataTypeDescription.Create('numeric', TDBXDataTypes.BcdType, 64, 'numeric({0}, {1})', 'Precision, Scale', 64, 0, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[9] := TDBXDataTypeDescription.Create('timestamp', TDBXDataTypes.TimeStampType, 4, 'timestamp', NullString, -1, -1, '{ts ''', '''}', NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Searchable or TDBXTypeFlag.ConcurrencyType);
  Types[10] := TDBXDataTypeDescription.Create('datetime', TDBXDataTypes.TimeStampType, 8, 'datetime', NullString, -1, -1, '{ts ''', '''}', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[11] := TDBXDataTypeDescription.Create('date', TDBXDataTypes.DateType, 3, 'date', NullString, -1, -1, '{ts ''', '''}', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[12] := TDBXDataTypeDescription.Create('time', TDBXDataTypes.TimeType, 3, 'time', NullString, -1, -1, '{ts ''', '''}', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[13] := TDBXDataTypeDescription.Create('year', TDBXDataTypes.Int32Type, 1, 'year', NullString, -1, -1, '{ts ''', '''}', NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[14] := TDBXDataTypeDescription.Create('binary', TDBXDataTypes.BytesType, 255, 'binary({0})', 'Precision', -1, -1, '0x', NullString, NullString, '05.00.0000', TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[15] := TDBXDataTypeDescription.Create('varbinary', TDBXDataTypes.VarBytesType, 254, 'varbinary({0})', 'Precision', -1, -1, '0x', NullString, '05.00.0002', NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[16] := TDBXDataTypeDescription.Create('varbinary', TDBXDataTypes.VarBytesType, 65533, 'varbinary({0})', 'Precision', -1, -1, '0x', NullString, NullString, '05.00.0003', TDBXTypeFlag.BestMatch or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[17] := TDBXDataTypeDescription.Create('char', StringType, 255, 'char({0})', 'Precision', -1, -1, '''', '''', NullString, '05.00.0000', TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[18] := TDBXDataTypeDescription.Create('varchar', StringType, 254, 'varchar({0})', 'Precision', -1, -1, '''', '''', '05.00.0002', NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[19] := TDBXDataTypeDescription.Create('varchar', StringType, 65533, 'varchar({0})', 'Precision', -1, -1, '''', '''', NullString, '05.00.0003', TDBXTypeFlag.BestMatch or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[20] := TDBXDataTypeDescription.Create('tinytext', StringType, 254, 'tinytext', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Long or TDBXTypeFlag.Nullable or TDBXTypeFlag.SearchableWithLike);
  Types[21] := TDBXDataTypeDescription.Create('text', StringType, 65533, 'text', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Long or TDBXTypeFlag.Nullable or TDBXTypeFlag.SearchableWithLike);
  Types[22] := TDBXDataTypeDescription.Create('mediumtext', StringType, 16777212, 'mediumtext', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.Long or TDBXTypeFlag.Nullable or TDBXTypeFlag.SearchableWithLike);
  Types[23] := TDBXDataTypeDescription.Create('longtext', StringType, 4294967291, 'longtext', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Long or TDBXTypeFlag.Nullable or TDBXTypeFlag.SearchableWithLike);
  Types[24] := TDBXDataTypeDescription.Create('tinyblob', TDBXDataTypes.BlobType, 254, 'tinyblob', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Long or TDBXTypeFlag.Nullable);
  Types[25] := TDBXDataTypeDescription.Create('blob', TDBXDataTypes.BlobType, 65533, 'blob', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Long or TDBXTypeFlag.Nullable);
  Types[26] := TDBXDataTypeDescription.Create('mediumblob', TDBXDataTypes.BlobType, 16777212, 'mediumblob', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.Long or TDBXTypeFlag.Nullable);
  Types[27] := TDBXDataTypeDescription.Create('longblob', TDBXDataTypes.BlobType, 4294967291, 'longblob', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Long or TDBXTypeFlag.Nullable);
  Types[28] := TDBXDataTypeDescription.Create('bool', TDBXDataTypes.BooleanType, 1, 'bool', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Long or TDBXTypeFlag.Nullable);
  Types[29] := TDBXDataTypeDescription.Create('enum', StringType, 65535, 'enum', NullString, -1, -1, '''', '''', NullString, '05.00.0003', TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[30] := TDBXDataTypeDescription.Create('set', StringType, 64, 'set', NullString, -1, -1, '''', '''', NullString, '05.00.0003', TDBXTypeFlag.CaseSensitive or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[31] := TDBXDataTypeDescription.Create('bit', TDBXDataTypes.VarBytesType, 8, 'bit({0})', 'Precision', -1, -1, NullString, NullString, NullString, '05.00.0003', TDBXTypeFlag.BestMatch or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Result := Types;
end;

function TDBXMySqlCustomMetaDataReader.FetchSchemas(const Catalog: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  if CompareVersion(TDBXVersion.FMySQL5) >= 0 then
    Result := inherited FetchSchemas(Catalog)
  else 
  begin
    Columns := TDBXMetaDataCollectionColumns.CreateSchemasColumns;
    Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Schemas, Columns);
  end;
end;

function TDBXMySqlCustomMetaDataReader.FetchTables(const Catalog: string; const Schema: string; const TableName: string; const TableType: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
  Sql: string;
  Cursor: TDBXTable;
begin
  if CompareVersion(TDBXVersion.FMySQL5) >= 0 then
    Exit(inherited FetchTables(Catalog, Schema, TableName, TableType));
  Columns := TDBXMetaDataCollectionColumns.CreateTablesColumns;
  if (not TableType.IsEmpty) and (TableType.IndexOf(Table) < 0) then
    Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Tables, Columns)
  else 
  begin
    Sql := SqlForTables;
    if not TableName.IsEmpty then
      Sql := Sql + ' like ''' + TableName + '''';
    Cursor := Context.ExecuteQuery(Sql, nil, nil);
    Result := TDBXMySqlCustomMetaDataReader.TDBXMySql4TablesCursor.Create(self, Columns, Cursor);
  end;
end;

function TDBXMySqlCustomMetaDataReader.FetchViews(const Catalog: string; const Schema: string; const View: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  if CompareVersion(TDBXVersion.FMySQL5) >= 0 then
    Result := inherited FetchViews(Catalog, Schema, View)
  else 
  begin
    Columns := TDBXMetaDataCollectionColumns.CreateViewsColumns;
    Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Views, Columns);
  end;
end;

function TDBXMySqlCustomMetaDataReader.FetchColumns(const Catalog: string; const Schema: string; const Table: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
  ParameterNames, ParameterValues: TDBXStringArray;
  Original, Original4, Sanitized: TDBXTable;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateColumnsColumns;
  if CompareVersion(TDBXVersion.FMySQL5) >= 0 then
  begin
    SetLength(ParameterNames,3);
    ParameterNames[0] := TDBXParameterName.CatalogName;
    ParameterNames[1] := TDBXParameterName.SchemaName;
    ParameterNames[2] := TDBXParameterName.TableName;
    SetLength(ParameterValues,3);
    ParameterValues[0] := Catalog;
    ParameterValues[1] := Schema;
    ParameterValues[2] := Table;
    Original := Context.ExecuteQuery(SqlForColumns, ParameterNames, ParameterValues);
    Sanitized := TDBXCustomMetaDataTable.Create(Context, TDBXMetaDataCollectionName.Columns, Columns, Original);
    Result := TDBXMySqlCustomMetaDataReader.TDBXMySqlColumnsTableCursor.Create(Self, True, Original, Sanitized);
  end
  else
  begin
    Original4 := TDBXMySqlCustomMetaDataReader.TDBXMySql4ColumnsCursor.Create(Self, Columns, SqlForColumns, Table);
    Result := TDBXMySqlCustomMetaDataReader.TDBXMySqlColumnsTableCursor.Create(Self, False, Original4, Original4);
  end;
end;

function TDBXMySqlCustomMetaDataReader.FetchIndexes(const Catalog: string; const Schema: string; const Table: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  if CompareVersion(TDBXVersion.FMySQL5) >= 0 then
    Exit(inherited FetchIndexes(Catalog, Schema, Table));
  Columns := TDBXMetaDataCollectionColumns.CreateIndexesColumns;
  Result := TDBXMySqlCustomMetaDataReader.TDBXMySql4IndexesCursor.Create(self, Columns, SqlForIndexes, Table);
end;

function TDBXMySqlCustomMetaDataReader.FetchIndexColumns(const Catalog: string; const Schema: string; const Table: string; const Index: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  if CompareVersion(TDBXVersion.FMySQL5) >= 0 then
    Exit(inherited FetchIndexColumns(Catalog, Schema, Table, Index));
  Columns := TDBXMetaDataCollectionColumns.CreateIndexColumnsColumns;
  Result := TDBXMySqlCustomMetaDataReader.TDBXMySql4IndexColumnsCursor.Create(self, Columns, SqlForIndexColumns, Table, Index);
end;

function TDBXMySqlCustomMetaDataReader.FetchForeignKeys(const Catalog: string; const Schema: string; const Table: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  if CompareVersion(TDBXVersion.FMySQL5) >= 0 then
    Exit(inherited FetchForeignKeys(Catalog, Schema, Table));
  Columns := TDBXMetaDataCollectionColumns.CreateForeignKeysColumns;
  Result := TDBXMySqlCustomMetaDataReader.TDBXMySql4ForeignKeyCursor.Create(self, Columns, SqlForForeignKeys, Table);
end;

function TDBXMySqlCustomMetaDataReader.FetchForeignKeyColumns(const Catalog: string; const Schema: string; const Table: string; const ForeignKeyName: string; const PrimaryCatalog: string; const PrimarySchema: string; const PrimaryTable: string; const PrimaryKeyName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  if CompareVersion(TDBXVersion.FMySQL5_0_6) >= 0 then
    Exit(inherited FetchForeignKeyColumns(Catalog, Schema, Table, ForeignKeyName, PrimaryCatalog, PrimarySchema, PrimaryTable, PrimaryKeyName));
  Columns := TDBXMetaDataCollectionColumns.CreateForeignKeyColumnsColumns;
  Result := TDBXMySqlCustomMetaDataReader.TDBXMySql4ForeignKeyColumnsCursor.Create(self, Columns, SqlForForeignKeys, Table, ForeignKeyName, PrimaryTable, PrimaryKeyName);
end;

function TDBXMySqlCustomMetaDataReader.FetchProcedures(const Catalog: string; const Schema: string; const ProcedureName: string; const ProcType: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  if CompareVersion(TDBXVersion.FMySQL5_0_6) >= 0 then
    Result := inherited FetchProcedures(Catalog, Schema, ProcedureName, ProcType)
  else 
  begin
    Columns := TDBXMetaDataCollectionColumns.CreateProceduresColumns;
    Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Procedures, Columns);
  end;
end;

function TDBXMySqlCustomMetaDataReader.FetchProcedureSources(const Catalog: string; const Schema: string; const Proc: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateProcedureSourcesColumns;
  if CompareVersion(TDBXVersion.FMySQL5_0_6) >= 0 then
    Result := TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureSourcesCursor.Create(self, Columns, SqlForProcedureSources, Schema, Proc)
  else 
    Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.ProcedureSources, Columns);
end;

function TDBXMySqlCustomMetaDataReader.FetchProcedureParameters(const Catalog: string; const Schema: string; const Proc: string; const Parameter: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateProcedureParametersColumns;
  if CompareVersion(TDBXVersion.FMySQL5_0_6) >= 0 then
    Result := TDBXColumnsTableCursor.Create(self, True, TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureParametersCursor.Create(self, Columns, SqlForProcedureSources, Schema, Proc, Parameter))
  else 
    Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.ProcedureParameters, Columns);
end;

function TDBXMySqlCustomMetaDataReader.FetchUsers: TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  if CompareVersion(TDBXVersion.FMySQL5) >= 0 then
    Result := inherited FetchUsers
  else 
  begin
    Columns := TDBXMetaDataCollectionColumns.CreateUsersColumns;
    Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Users, Columns);
  end;
end;

procedure TDBXMySqlCustomMetaDataReader.InitScanner;
var
  Scan: TDBXSqlScanner;
begin
  if FScanner = nil then
  begin
    Scan := TDBXSqlScanner.Create(SqlIdentifierQuoteChar, SqlIdentifierQuotePrefix, SqlIdentifierQuoteSuffix);
    Scan.RegisterId(Proc, TokenProcedure);
    Scan.RegisterId(cFunction, TokenFunction);
    Scan.RegisterId(Returns, TokenReturns);
    Scan.RegisterId(cBegin, TokenBegin);
    Scan.RegisterId(cIn, TokenIn);
    Scan.RegisterId(cOut, TokenOut);
    Scan.RegisterId(Inout, TokenInout);
    Scan.RegisterId(Character, TokenCharacter);
    Scan.RegisterId(cSet, TokenSet);
    Scan.RegisterId(Utf8, TokenUtf8);
    Scan.RegisterId(Unsigned, TokenUnsigned);
    Scan.RegisterId(cCreate, TokenCreate);
    Scan.RegisterId(Definer, TokenDefiner);
    Scan.RegisterId(cNot, TokenNot);
    Scan.RegisterId(NullSpec, TokenNull);
    Scan.RegisterId(Binary, TokenBinary);
    FScanner := Scan;
  end;
end;

procedure TDBXMySqlCustomMetaDataReader.GetProcedures(const SchemaName: string; const ProcedureName: string; const Procedures: TDBXStringList; const ProcedureTypes: TDBXStringList);
var
  Cursor: TDBXTable;
begin
  Cursor := FetchProcedures(NullString, SchemaName, ProcedureName, NullString);
  while Cursor.Next do
  begin
    Procedures.Add(Cursor.Value[TDBXProceduresIndex.ProcedureName].AsString);
    ProcedureTypes.Add(Cursor.Value[TDBXProceduresIndex.ProcedureType].AsString);
  end;
  Cursor.Close;
  Cursor.Free;
end;

// CREATE DEFINER=`barney`@`%` FUNCTION `f1`(param1 INT) RETURNS int(11) begin   return param1+1; end
// CREATE DEFINER=`barney`@`%` PROCEDURE `simpleproc`(OUT param1 INT) begin   select count(*) into param1 from joal_t1; end
function TDBXMySqlCustomMetaDataReader.ParseProcedureDefiner(const Definition: string): string;
var
  Definer: string;
  Token: Integer;
begin
  InitScanner;
  FScanner.Init(Definition);
  Definer := NullString;
  Token := FScanner.NextToken;
  if Token = TokenCreate then
  begin
    Token := FScanner.NextToken;
    if Token = TokenDefiner then
    begin
      Token := FScanner.NextToken;
      if (Token = TDBXSqlScanner.TokenSymbol) and (FScanner.Symbol = '=') then
      begin
        Token := FScanner.NextToken;
        if Token = TDBXSqlScanner.TokenId then
          Definer := FScanner.Id;
      end;
    end;
  end;
  Result := Definer;
end;

procedure TDBXMySqlCustomMetaDataReader.ParseProcedure(const Definition: string; const aType: string; const Params: TDBXArrayList);
var
  ReturnType: TDBXMySqlCustomMetaDataReader.TMySqlParameter;
  Ordinal: Integer;
  Token: Integer;
  Param: TDBXMySqlCustomMetaDataReader.TMySqlParameter;
begin
  Params.Clear;
  ReturnType := nil;
  if (aType = cFunction) then
  begin
    ReturnType := TDBXMySqlCustomMetaDataReader.TMySqlParameter.Create;
    ReturnType.FName := 'RETURN_VALUE';
    ReturnType.FMode := 'RESULT';
    ReturnType.FOrdinal := 0;
    Params.Add(ReturnType);
  end;
  InitScanner;
  FScanner.Init(Definition);
  Ordinal := 1;
  Token := TDBXSqlScanner.TokenId;
  while Token <> TDBXSqlScanner.TokenOpenParen do
    Token := FScanner.NextToken;
  Token := TDBXSqlScanner.TokenComma;
  while Token = TDBXSqlScanner.TokenComma do
  begin
    Param := TDBXMySqlCustomMetaDataReader.TMySqlParameter.Create;
    Param.FMode := cIn;
    Token := FScanner.NextToken;
    if (Token = TokenIn) or (Token = TokenOut) or (Token = TokenInout) then
    begin
      Param.FMode := FScanner.Id;
      FScanner.NextToken;
    end;
    ;
    Param.FName := FScanner.Id;
    Param.FOrdinal := Ordinal;
    Token := ParseType(NullString, Param);
    Params.Add(Param);
    IncrAfter(Ordinal);
  end;
  ;
  Token := FScanner.NextToken;
  if (ReturnType <> nil) and (Token = TokenReturns) then
    ParseType(NullString, ReturnType);
end;

function TDBXMySqlCustomMetaDataReader.ParseType(const Definition: string; const aType: TDBXMySqlCustomMetaDataReader.TMySqlColumnType): Integer;
var
  Token: Integer;
begin
  if not Definition.IsEmpty then
  begin
    InitScanner;
    FScanner.Init(Definition);
  end;
  FScanner.NextToken;
  aType.FDataType := FScanner.Id.ToLower;
  aType.FPrecision := 0;
  aType.FScale := 0;
  aType.FUnsigned := False;
  aType.FUnicode := False;
  aType.FNotnull := False;
  if (aType.FDataType = IntegerType) then
    aType.FDataType := IntType;
  if (aType.FDataType = DecType) then
    aType.FDataType := DecimalType;
  Token := FScanner.NextToken;
  if Token = TDBXSqlScanner.TokenOpenParen then
  begin
    Token := FScanner.NextToken;
    if Token = TDBXSqlScanner.TokenNumber then
    begin
      aType.FPrecision := ToInt(FScanner.Id);
      Token := FScanner.NextToken;
      if Token = TDBXSqlScanner.TokenComma then
      begin
        Token := FScanner.NextToken;
        if Token = TDBXSqlScanner.TokenNumber then
        begin
          aType.FScale := ToInt(FScanner.Id);
          Token := FScanner.NextToken;
        end;
      end;
    end;
    while Token <> TDBXSqlScanner.TokenCloseParen do
      Token := FScanner.NextToken;
    Token := FScanner.NextToken;
  end;
  while True do
  begin
    case Token of
      TokenBegin,
      TDBXSqlScanner.TokenEos,
      TDBXSqlScanner.TokenComma:
        Exit(Token);
      TokenUnsigned:
        aType.FUnsigned := True;
      TokenUtf8:
        aType.FUnicode := True;
      TokenBinary:
        if (aType.FDataType = 'varchar') then
          aType.FDataType := Varbinary.ToLower
        else if (aType.FDataType = 'char') then
          aType.FDataType := Binary.ToLower;
      TokenNot:
        begin
          Token := FScanner.NextToken;
          if Token = TokenNull then
            aType.FNotnull := False
          else if (Token = TDBXSqlScanner.TokenComma) or (Token = TokenBegin) then
            Exit(Token);
        end;
    end;
    Token := FScanner.NextToken;
  end;
end;

function TDBXMySqlCustomMetaDataReader.GetTables: TDBXStringList;
var
  Cursor: TDBXTable;
  Tables: TDBXStringList;
begin
  Cursor := Context.ExecuteQuery(SqlForTables, nil, nil);
  Tables := TDBXStringList.Create;
  while Cursor.Next do
    Tables.Add(Cursor.Value[0].AsString);
  Cursor.Close;
  Cursor.Free;
  Result := Tables;
end;

function TDBXMySqlCustomMetaDataReader.FindDataType(const TypeName: string): Integer;
var
  Hash: TDBXObjectStore;
  DataType: TDBXDataTypeDescription;
begin
  Hash := DataTypeHash;
  DataType := TDBXDataTypeDescription(Hash[TypeName]);
  if DataType <> nil then
    Result := DataType.DbxDataType
  else 
    Result := TDBXDataTypes.UnknownType;
end;

function TDBXMySqlCustomMetaDataReader.ReplaceIdentifier(const Sql: string; const ParameterName: string; const ActualValue: string; const MakeQuotes: Boolean): string;
var
  ParameterStart, ParameterEnd: Integer;
  Value: string;
begin
  ParameterStart := Sql.LastIndexOf(ParameterName);
  ParameterEnd := ParameterStart + ParameterName.Length;
  Value := Sql;
  if (ParameterStart > 0) and (Sql.Chars[ParameterStart-1] = SqlDefaultParameterMarker.Chars[0]) then
  begin
    Dec(ParameterStart);
    Value := ActualValue;
    if MakeQuotes then
      Value := TDBXMetaDataUtil.QuoteIdentifier(Value, SqlIdentifierQuoteChar, SqlIdentifierQuotePrefix, SqlIdentifierQuoteSuffix);
    Value := Sql.SubString(0, ParameterStart) + Value + Sql.SubString(ParameterEnd, Sql.Length - ParameterEnd);
  end;
  Result := Value;
end;

function TDBXMySqlCustomMetaDataReader.ToInt(const Value: string): Integer;
begin
  try
    Result := StrToInt(Value);
  except
    on Ex: Exception do
      Result := -1;
  end;
end;

function TDBXMySqlCustomMetaDataReader.ParseIdList(const Scanner: TDBXSqlScanner; const List: TDBXStringList): Boolean;
var
  Token: Integer;
begin
  Token := Scanner.NextToken;
  if Token <> TDBXSqlScanner.TokenOpenParen then
    Exit(False);
  Token := Scanner.NextToken;
  if Token <> TDBXSqlScanner.TokenId then
    Exit(False);
  List.Add(Scanner.Id);
  Token := Scanner.NextToken;
  while Token = TDBXSqlScanner.TokenComma do
  begin
    Token := Scanner.NextToken;
    if Token <> TDBXSqlScanner.TokenId then
      Exit(False);
    List.Add(Scanner.Id);
    Token := Scanner.NextToken;
  end;
  if Token <> TDBXSqlScanner.TokenCloseParen then
    Exit(False);
  Result := True;
end;

function TDBXMySqlCustomMetaDataReader.ParseForeignKey(const Scanner: TDBXSqlScanner; const ForeignKey: TDBXMySqlCustomMetaDataReader.TMySqlForeignKey): Boolean;
var
  Token: Integer;
begin
  Scanner.NextToken;
  if not Scanner.IsKeyword(Constraint) then
    Exit(False);
  Token := Scanner.NextToken;
  if Token <> TDBXSqlScanner.TokenId then
    Exit(False);
  ForeignKey.FConstraintName := Scanner.Id;
  Scanner.NextToken;
  if not Scanner.IsKeyword(Foreign) then
    Exit(False);
  Scanner.NextToken;
  if not Scanner.IsKeyword(Key) then
    Exit(False);
  if not ParseIdList(Scanner, ForeignKey.FKeyColumns) then
    Exit(False);
  Scanner.NextToken;
  if not Scanner.IsKeyword(References) then
    Exit(False);
  Token := Scanner.NextToken;
  if Token <> TDBXSqlScanner.TokenId then
    Exit(False);
  ForeignKey.FReferencedTableName := Scanner.Id;
  Result := ParseIdList(Scanner, ForeignKey.FReferencedColumns);
end;

function TDBXMySqlCustomMetaDataReader.ParseCreateTableForNextForeignKey(const Sql: string; const InStartIndex: Integer; const Key: TDBXMySqlCustomMetaDataReader.TMySqlForeignKey): Integer;
var
  StartIndex: Integer;
  Index: Integer;
begin
  StartIndex := InStartIndex;
  Index := Sql.IndexOf(Constraint, StartIndex);
  InitScanner;
  while Index > 0 do
  begin
    StartIndex := Index + Constraint.Length;
    FScanner.Init(Sql, Index);
    Key.Reset;
    if ParseForeignKey(FScanner, Key) then
    begin
      FreeAndNil(FScanner);
      Exit(StartIndex);
    end;
    Index := Sql.IndexOf(Constraint, StartIndex);
  end;
  FreeAndNil(FScanner);
  Result := -1;
end;

constructor TDBXMySqlCustomMetaDataReader.TMySqlForeignKey.Create;
begin
  inherited Create;
  FKeyColumns := TDBXStringList.Create;
  FReferencedColumns := TDBXStringList.Create;
end;

destructor TDBXMySqlCustomMetaDataReader.TMySqlForeignKey.Destroy;
begin
  FreeAndNil(FKeyColumns);
  FreeAndNil(FReferencedColumns);
  inherited Destroy;
end;

procedure TDBXMySqlCustomMetaDataReader.TMySqlForeignKey.Reset;
begin
  FConstraintName := NullString;
  FKeyColumns.Clear;
  FReferencedColumns.Clear;
end;

constructor TDBXMySqlCustomMetaDataReader.TDBXMySql4TablesCursor.Create(const Reader: TDBXMySqlCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable);
begin
  inherited Create(Reader.Context, TDBXMetaDataCollectionName.Tables, Columns, Cursor);
  FNullValue := TDBXWritableValue(TDBXValue.CreateValue(TDBXValueType(Columns[TDBXTablesIndex.TableType].Clone())));
  FNullValue.SetNull;
  FTableValue := TDBXWritableValue(TDBXValue.CreateValue(TDBXValueType(Columns[TDBXTablesIndex.TableType].Clone())));
  FTableValue.AsString := Table;
end;

destructor TDBXMySqlCustomMetaDataReader.TDBXMySql4TablesCursor.Destroy;
begin
  FreeAndNil(FTableValue);
  FreeAndNil(FNullValue);
  inherited Destroy;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4TablesCursor.FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer;
begin
  case Ordinal of
    TDBXTablesIndex.TableName:
      Result := SourceColumns[ShowTablesTableNameOrdinal].Size;
    else
      Result := DefaultVarcharPrecision;
  end;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4TablesCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  if Ordinal = TDBXTablesIndex.TableName then
    Exit(inherited GetWritableValue(ShowTablesTableNameOrdinal));
  if Ordinal = TDBXTablesIndex.TableType then
    Exit(FTableValue);
  Result := FNullValue;
end;

constructor TDBXMySqlCustomMetaDataReader.TDBXMySqlColumnsTableCursor.Create(const Reader: TDBXMySqlCustomMetaDataReader; const Version5: Boolean; const Original: TDBXTable; const Sanitized: TDBXTable);
begin
  inherited Create(Reader, False, Sanitized);
  self.FOriginal := Original;
  self.FVersion5 := Version5;
  FRow := TDBXSingleValueRow.Create;
  FRow.Columns := CopyColumns;
end;

destructor TDBXMySqlCustomMetaDataReader.TDBXMySqlColumnsTableCursor.Destroy;
begin
  FreeAndNil(FRow);
  inherited Destroy;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySqlColumnsTableCursor.Next: Boolean;
var
  ReturnValue: Boolean;
  Value: TDBXWritableValue;
  IsUnsigned: Boolean;
  DataType: Integer;
begin
  ReturnValue := inherited Next;
  if ReturnValue then
  begin
    Value := FRow.Value[TDBXColumnsIndex.IsUnicode];
    if FVersion5 then
      Value.SetBoolean((FOriginal.Value[MysqlIsUnicode].AsString = Utf8))
    else 
      Value.AsBoolean := False;
    Value := FRow.Value[TDBXColumnsIndex.IsUnsigned];
    if FVersion5 then
      IsUnsigned := FOriginal.Value[MysqlIsUnsigned].AsBoolean
    else 
      IsUnsigned := FOriginal.Value[TDBXColumnsIndex.IsUnsigned].GetBoolean;
    Value.AsBoolean := IsUnsigned;
    DataType := inherited GetWritableValue(TDBXColumnsIndex.DbxDataType).AsInt32;
    if IsUnsigned then
      case DataType of
        TDBXDataTypes.Int8Type:
          DataType := TDBXDataTypes.UInt8Type;
        TDBXDataTypes.Int16Type:
          DataType := TDBXDataTypes.UInt16Type;
        TDBXDataTypes.Int32Type:
          DataType := TDBXDataTypes.UInt32Type;
        TDBXDataTypes.Int64Type:
          DataType := TDBXDataTypes.UInt64Type;
      end;
    FRow.Value[TDBXColumnsIndex.DbxDataType].AsInt32 := DataType;
  end;
  Result := ReturnValue;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySqlColumnsTableCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  case Ordinal of
    TDBXColumnsIndex.IsUnicode,
    TDBXColumnsIndex.IsUnsigned,
    TDBXColumnsIndex.DbxDataType:
      Exit(FRow.Value[Ordinal]);
  end;
  Result := inherited GetWritableValue(Ordinal);
end;

constructor TDBXMySqlCustomMetaDataReader.TDBXMySql4ColumnsCursor.Create(const Reader: TDBXMySqlCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Sql: string; const TableName: string);
begin
  inherited Create(Reader.Context, TDBXMetaDataCollectionName.Columns, Columns, nil);
  FReader := Reader;
  FSql := Sql;
  FTableName := TableName;
  if TableName.IsEmpty then
  begin
    FTables := Reader.Tables;
    FTableIndex := -1;
  end;
  FColumnType := TDBXMySqlCustomMetaDataReader.TMySqlColumnType.Create;
  InitNextCursor;
  FRow := TDBXSingleValueRow.Create;
  FRow.Columns := CopyColumns;
end;

destructor TDBXMySqlCustomMetaDataReader.TDBXMySql4ColumnsCursor.Destroy;
begin
  Close;
  FreeAndNil(FRow);
  inherited Destroy;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4ColumnsCursor.FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer;
begin
  case Ordinal of
    TDBXColumnsIndex.ColumnName:
      Result := SourceColumns[ShowColumnsFieldOrdinal].Size;
    TDBXColumnsIndex.DefaultValue:
      Result := SourceColumns[ShowColumnsDefaultOrdinal].Size;
    else
      Result := DefaultVarcharPrecision;
  end;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4ColumnsCursor.InitNextCursor: Boolean;
var
  Query: string;
begin
  if FTables <> nil then
  begin
    IncrAfter(FTableIndex);
    if FTableIndex >= FTables.Count then
      Exit(False);
    FTableName := string(FTables[FTableIndex]);
  end;
  Query := FReader.ReplaceIdentifier(FSql, TDBXParameterName.TableName, FTableName, True);
  try
    FCursor := FReader.Context.ExecuteQuery(Query, nil, nil);
  except
    on Ex: Exception do
      FCursor := nil;
  end;
  FColumnNumber := 0;
  Result := (FCursor <> nil);
end;

procedure TDBXMySqlCustomMetaDataReader.TDBXMySql4ColumnsCursor.Close;
begin
  if FCursor <> nil then
    FCursor.Close;
  FreeAndNil(FCursor);
  FreeAndNil(FTables);
  FreeAndNil(FColumnType);
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4ColumnsCursor.Next: Boolean;
begin
  if FCursor = nil then
    Exit(False);
  while not FCursor.Next do
  begin
    FCursor.Close;
    FCursor.Free;
    FCursor := nil;
    if (FTables = nil) or not InitNextCursor then
      Exit(False);
  end;
  IncrAfter(FColumnNumber);
  FReader.ParseType(FCursor.Value[ShowColumnsTypeOrdinal].AsString, FColumnType);
  FRow.Value[TDBXColumnsIndex.CatalogName].SetNull;
  FRow.Value[TDBXColumnsIndex.SchemaName].SetNull;
  FRow.Value[TDBXColumnsIndex.TableName].AsString := FTableName;
  FRow.Value[TDBXColumnsIndex.ColumnName].AsString := FCursor.Value[ShowColumnsFieldOrdinal].AsString;
  FRow.Value[TDBXColumnsIndex.DefaultValue].AsString := ComputeDefaultValue;
  FRow.Value[TDBXColumnsIndex.TypeName].AsString := FColumnType.FDataType;
  FRow.Value[TDBXColumnsIndex.Ordinal].AsInt32 := FColumnNumber;
  FRow.Value[TDBXColumnsIndex.Precision].AsInt64 := FColumnType.FPrecision;
  FRow.Value[TDBXColumnsIndex.Scale].AsInt32 := FColumnType.FScale;
  FRow.Value[TDBXColumnsIndex.IsAutoIncrement].AsBoolean := ComputeAutoIncrement;
  FRow.Value[TDBXColumnsIndex.IsNullable].AsBoolean := ComputeNullable;
  FRow.Value[TDBXColumnsIndex.IsUnsigned].AsBoolean := FColumnType.FUnsigned;
  FRow.Value[TDBXColumnsIndex.IsUnicode].AsBoolean := False;
  Result := True;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4ColumnsCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  case Ordinal of
    TDBXColumnsIndex.CatalogName,
    TDBXColumnsIndex.SchemaName,
    TDBXColumnsIndex.TableName,
    TDBXColumnsIndex.ColumnName,
    TDBXColumnsIndex.DefaultValue,
    TDBXColumnsIndex.TypeName,
    TDBXColumnsIndex.Ordinal,
    TDBXColumnsIndex.Precision,
    TDBXColumnsIndex.Scale,
    TDBXColumnsIndex.IsAutoIncrement,
    TDBXColumnsIndex.IsNullable,
    TDBXColumnsIndex.IsUnsigned,
    TDBXColumnsIndex.IsUnicode:
      Exit(FRow.Value[Ordinal]);
  end;
  Result := inherited GetWritableValue(Ordinal);
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4ColumnsCursor.ComputeDefaultValue: string;
var
  DefaultValue: string;
  DataType: Integer;
begin
  DefaultValue := NullString;
  if not FCursor.Value[ShowColumnsDefaultOrdinal].IsNull then
    DefaultValue := FCursor.Value[ShowColumnsDefaultOrdinal].AsString;
  if (not DefaultValue.IsEmpty) and not (DefaultValue = CurrentTimestamp) then
  begin
    if DefaultValue.Length = 0 then
      DefaultValue := NullString
    else 
    begin
      DataType := FReader.FindDataType(FColumnType.FDataType);
      case DataType of
        TDBXDataTypes.Int32Type:
          if (FColumnType.FDataType = FYear) then
            DefaultValue := Quote + DefaultValue + Quote;
        TDBXDataTypes.WideStringType,
        TDBXDataTypes.AnsiStringType,
        TDBXDataTypes.TimeStampType,
        TDBXDataTypes.TimeType,
        TDBXDataTypes.DateType:
          DefaultValue := Quote + DefaultValue + Quote;
      end;
    end;
  end;
  Result := DefaultValue;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4ColumnsCursor.ComputeAutoIncrement: Boolean;
begin
  Result := not FCursor.Value[ShowColumnsExtraOrdinal].IsNull and (FCursor.Value[ShowColumnsExtraOrdinal].AsString.IndexOf(FAuto_increment) >= 0);
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4ColumnsCursor.ComputeNullable: Boolean;
begin
  Result := not FCursor.Value[ShowColumnsNullOrdinal].IsNull and (YForYes = FCursor.Value[ShowColumnsNullOrdinal].AsString);
end;

constructor TDBXMySqlCustomMetaDataReader.TDBXMySql4IndexesCursor.Create(const Reader: TDBXMySqlCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Sql: string; const TableName: string);
begin
  inherited Create(Reader.Context, TDBXMetaDataCollectionName.Indexes, Columns, nil);
  FReader := Reader;
  FSql := Sql;
  FTableName := TableName;
  if TableName.IsEmpty then
  begin
    FTables := Reader.Tables;
    FTableIndex := -1;
  end;
  InitNextCursor;
  FRow := TDBXSingleValueRow.Create;
  FRow.Columns := CopyColumns;
end;

destructor TDBXMySqlCustomMetaDataReader.TDBXMySql4IndexesCursor.Destroy;
begin
  Close;
  inherited Destroy;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4IndexesCursor.FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer;
begin
  case Ordinal of
    TDBXIndexesIndex.IndexName,
    TDBXIndexesIndex.ConstraintName:
      Result := SourceColumns[ShowIndexKeyNameOrdinal].Size;
    else
      Result := DefaultVarcharPrecision;
  end;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4IndexesCursor.InitNextCursor: Boolean;
var
  Query: string;
begin
  if FTables <> nil then
  begin
    IncrAfter(FTableIndex);
    if FTableIndex >= FTables.Count then
      Exit(False);
    FTableName := string(FTables[FTableIndex]);
  end;
  Query := FReader.ReplaceIdentifier(FSql, TDBXParameterName.TableName, FTableName, True);
  try
    FCursor := FReader.Context.ExecuteQuery(Query, nil, nil);
  except
    on Ex: Exception do
      FCursor := nil;
  end;
  Result := (FCursor <> nil);
end;

procedure TDBXMySqlCustomMetaDataReader.TDBXMySql4IndexesCursor.Close;
begin
  if FCursor <> nil then
    FCursor.Close;
  FreeAndNil(FCursor);
  FreeAndNil(FTables);
  FreeAndNil(FRow);
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4IndexesCursor.Next: Boolean;
begin
  if FCursor = nil then
    Exit(False);
  FPrevTableName := FTableName;
  FPrevIndexName := FIndexName;
  repeat
    while not FCursor.Next do
    begin
      FCursor.Close;
      FCursor.Free;
      FCursor := nil;
      if (FTables = nil) or not InitNextCursor then
        Exit(False);
    end;
    FUniqueIndex := not FCursor.Value[ShowIndexNonUniqueOrdinal].IsNull and not FCursor.Value[ShowIndexNonUniqueOrdinal].AsBoolean;
    FIndexName := FCursor.Value[ShowIndexKeyNameOrdinal].AsString;
  until not ((FTableName = FPrevTableName) and (FIndexName = FPrevIndexName));
  FRow.Value[TDBXIndexesIndex.CatalogName].SetNull;
  FRow.Value[TDBXIndexesIndex.SchemaName].SetNull;
  if not FUniqueIndex then
    FRow.Value[TDBXIndexesIndex.ConstraintName].SetNull
  else 
    FRow.Value[TDBXIndexesIndex.ConstraintName].AsString := ComputeConstraintName;
  FRow.Value[TDBXIndexesIndex.TableName].AsString := FTableName;
  FRow.Value[TDBXIndexesIndex.IndexName].AsString := FIndexName;
  FRow.Value[TDBXIndexesIndex.IsPrimary].AsBoolean := FUniqueIndex and (Primary = FIndexName);
  FRow.Value[TDBXIndexesIndex.IsUnique].AsBoolean := FUniqueIndex;
  FRow.Value[TDBXIndexesIndex.IsAscending].AsBoolean := True;
  Result := True;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4IndexesCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  case Ordinal of
    TDBXIndexesIndex.CatalogName,
    TDBXIndexesIndex.SchemaName,
    TDBXIndexesIndex.ConstraintName,
    TDBXIndexesIndex.TableName,
    TDBXIndexesIndex.IndexName,
    TDBXIndexesIndex.IsPrimary,
    TDBXIndexesIndex.IsUnique,
    TDBXIndexesIndex.IsAscending:
      Exit(FRow.Value[Ordinal]);
  end;
  Result := inherited GetWritableValue(Ordinal);
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4IndexesCursor.ComputeConstraintName: string;
var
  ConstraintName: string;
begin
  ConstraintName := NullString;
  if FUniqueIndex then
    ConstraintName := FIndexName;
  Result := ConstraintName;
end;

constructor TDBXMySqlCustomMetaDataReader.TDBXMySql4IndexColumnsCursor.Create(const Reader: TDBXMySqlCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Sql: string; const TableName: string; const IndexName: string);
begin
  inherited Create(Reader.Context, TDBXMetaDataCollectionName.IndexColumns, Columns, nil);
  FReader := Reader;
  FSql := Sql;
  FTableName := TableName;
  FWantedIndexName := IndexName;
  if TableName.IsEmpty then
  begin
    FTables := Reader.Tables;
    FTableIndex := -1;
  end;
  InitNextCursor;
  FRow := TDBXSingleValueRow.Create;
  FRow.Columns := CopyColumns;
end;

destructor TDBXMySqlCustomMetaDataReader.TDBXMySql4IndexColumnsCursor.Destroy;
begin
  Close;
  FreeAndNil(FRow);
  inherited Destroy;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4IndexColumnsCursor.FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer;
begin
  case Ordinal of
    TDBXIndexColumnsIndex.IndexName:
      Result := SourceColumns[ShowIndexKeyNameOrdinal].Size;
    TDBXIndexColumnsIndex.ColumnName:
      Result := SourceColumns[ShowIndexColumnNameOrdinal].Size;
    else
      Result := DefaultVarcharPrecision;
  end;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4IndexColumnsCursor.InitNextCursor: Boolean;
var
  Query: string;
begin
  if FTables <> nil then
  begin
    IncrAfter(FTableIndex);
    if FTableIndex >= FTables.Count then
      Exit(False);
    FTableName := string(FTables[FTableIndex]);
  end;
  Query := FReader.ReplaceIdentifier(FSql, TDBXParameterName.TableName, FTableName, True);
  try
    FCursor := FReader.Context.ExecuteQuery(Query, nil, nil);
  except
    on Ex: Exception do
      FCursor := nil;
  end;
  Result := (FCursor <> nil);
end;

procedure TDBXMySqlCustomMetaDataReader.TDBXMySql4IndexColumnsCursor.Close;
begin
  if FCursor <> nil then
    FCursor.Close;
  FreeAndNil(FCursor);
  FreeAndNil(FTables);
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4IndexColumnsCursor.Next: Boolean;
begin
  if FCursor = nil then
    Exit(False);
  repeat
    while not FCursor.Next do
    begin
      FCursor.Close;
      FreeAndNil(FCursor);
      if (FTables = nil) or not InitNextCursor then
        Exit(False);
    end;
    FIndexName := FCursor.Value[ShowIndexKeyNameOrdinal].AsString;
  until (FWantedIndexName.IsEmpty or (FWantedIndexName = FIndexName));
  FRow.Value[TDBXIndexColumnsIndex.CatalogName].SetNull;
  FRow.Value[TDBXIndexColumnsIndex.SchemaName].SetNull;
  FRow.Value[TDBXIndexColumnsIndex.TableName].AsString := FTableName;
  FRow.Value[TDBXIndexColumnsIndex.IndexName].AsString := FIndexName;
  FRow.Value[TDBXIndexColumnsIndex.ColumnName].AsString := FCursor.Value[ShowIndexColumnNameOrdinal].AsString;
  FRow.Value[TDBXIndexColumnsIndex.Ordinal].AsInt32 := FCursor.Value[ShowIndexSeqInIndexOrdinal].AsInt32;
  FRow.Value[TDBXIndexColumnsIndex.IsAscending].AsBoolean := True;
  Result := True;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4IndexColumnsCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  case Ordinal of
    TDBXIndexColumnsIndex.CatalogName,
    TDBXIndexColumnsIndex.SchemaName,
    TDBXIndexColumnsIndex.TableName,
    TDBXIndexColumnsIndex.IndexName,
    TDBXIndexColumnsIndex.ColumnName,
    TDBXIndexColumnsIndex.Ordinal,
    TDBXIndexColumnsIndex.IsAscending:
      Exit(FRow.Value[Ordinal]);
  end;
  Result := inherited GetWritableValue(Ordinal);
end;

constructor TDBXMySqlCustomMetaDataReader.TDBXMySql4ForeignKeyCursor.Create(const Reader: TDBXMySqlCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Sql: string; const TableName: string);
begin
  FKey := TDBXMySqlCustomMetaDataReader.TMySqlForeignKey.Create;
  inherited Create(Reader.Context, TDBXMetaDataCollectionName.ForeignKeys, Columns, nil);
  FReader := Reader;
  FSql := Sql;
  FTableName := TableName;
  if TableName.IsEmpty then
  begin
    FTables := Reader.Tables;
    FTableIndex := -1;
  end;
  InitNextCursor;
  FRow := TDBXSingleValueRow.Create;
  FRow.Columns := CopyColumns;
end;

destructor TDBXMySqlCustomMetaDataReader.TDBXMySql4ForeignKeyCursor.Destroy;
begin
  Close;
  FreeAndNil(FRow);
  inherited Destroy;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4ForeignKeyCursor.FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer;
begin
  Result := DefaultVarcharPrecision;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4ForeignKeyCursor.InitNextCursor: Boolean;
var
  Query: string;
begin
  if FTables <> nil then
  begin
    IncrAfter(FTableIndex);
    if FTableIndex >= FTables.Count then
      Exit(False);
    FTableName := string(FTables[FTableIndex]);
  end;
  Query := FReader.ReplaceIdentifier(FSql, TDBXParameterName.TableName, FTableName, True);
  try
    FCursor := FReader.Context.ExecuteQuery(Query, nil, nil);
  except
    on Ex: Exception do
      FCursor := nil;
  end;
  FParseIndex := -1;
  Result := (FCursor <> nil);
end;

procedure TDBXMySqlCustomMetaDataReader.TDBXMySql4ForeignKeyCursor.Close;
begin
  if FCursor <> nil then
    FCursor.Close;
  FreeAndNil(FCursor);
  FreeAndNil(FTables);
  FreeAndNil(FKey);
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4ForeignKeyCursor.Next: Boolean;
begin
  if FCursor = nil then
    Exit(False);
  repeat
    if FParseIndex < 0 then
    begin
      while not FCursor.Next do
      begin
        FCursor.Close;
        FCursor.Free;
        FCursor := nil;
        if (FTables = nil) or not InitNextCursor then
          Exit(False);
      end;
      FSqlCreateTable := FCursor.Value[ShowCreateTableSqlOrdinal].AsString;
      FParseIndex := 0;
    end;
    FParseIndex := FReader.ParseCreateTableForNextForeignKey(FSqlCreateTable, FParseIndex, FKey);
  until FParseIndex >= 0;
  FRow.Value[TDBXForeignKeysIndex.CatalogName].SetNull;
  FRow.Value[TDBXForeignKeysIndex.SchemaName].SetNull;
  FRow.Value[TDBXForeignKeysIndex.TableName].AsString := FTableName;
  FRow.Value[TDBXForeignKeysIndex.ForeignKeyName].AsString := FKey.FConstraintName;
  Result := True;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4ForeignKeyCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  case Ordinal of
    TDBXForeignKeysIndex.CatalogName,
    TDBXForeignKeysIndex.SchemaName,
    TDBXForeignKeysIndex.TableName,
    TDBXForeignKeysIndex.ForeignKeyName:
      Exit(FRow.Value[Ordinal]);
  end;
  Result := inherited GetWritableValue(Ordinal);
end;

constructor TDBXMySqlCustomMetaDataReader.TDBXMySql4ForeignKeyColumnsCursor.Create(const Reader: TDBXMySqlCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Sql: string; const TableName: string; const ForeignKeyName: string; const PrimaryTableName: string; const PrimaryKeyName: string);
begin
  FKey := TDBXMySqlCustomMetaDataReader.TMySqlForeignKey.Create;
  inherited Create(Reader.Context, TDBXMetaDataCollectionName.ForeignKeyColumns, Columns, nil);
  FReader := Reader;
  FSql := Sql;
  FTableName := TableName;
  FForeignKeyName := ForeignKeyName;
  FPrimaryTableName := PrimaryTableName;
  FPrimaryKeyName := PrimaryKeyName;
  if TableName.IsEmpty then
  begin
    FTables := Reader.Tables;
    FTableIndex := -1;
  end;
  InitNextCursor;
  FRow := TDBXSingleValueRow.Create;
  FRow.Columns := CopyColumns;
end;

destructor TDBXMySqlCustomMetaDataReader.TDBXMySql4ForeignKeyColumnsCursor.Destroy;
begin
  Close;
  FreeAndNil(FRow);
  inherited Destroy;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4ForeignKeyColumnsCursor.FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer;
begin
  Result := DefaultVarcharPrecision;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4ForeignKeyColumnsCursor.InitNextCursor: Boolean;
var
  Query: string;
begin
  if FTables <> nil then
  begin
    IncrAfter(FTableIndex);
    if FTableIndex >= FTables.Count then
      Exit(False);
    FTableName := string(FTables[FTableIndex]);
  end;
  Query := FReader.ReplaceIdentifier(FSql, TDBXParameterName.TableName, FTableName, True);
  try
    FCursor := FReader.Context.ExecuteQuery(Query, nil, nil);
  except
    on Ex: Exception do
      FCursor := nil;
  end;
  FParseIndex := -1;
  Result := (FCursor <> nil);
end;

procedure TDBXMySqlCustomMetaDataReader.TDBXMySql4ForeignKeyColumnsCursor.Close;
begin
  if FCursor <> nil then
    FCursor.Close;
  FreeAndNil(FCursor);
  FreeAndNil(FTables);
  FreeAndNil(FKey);
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4ForeignKeyColumnsCursor.Next: Boolean;
begin
  if FCursor = nil then
    Exit(False);
  IncrAfter(FKeyIndex);
  if FKeyIndex < FKey.FKeyColumns.Count then
  begin
    SetValues;
    Exit(True);
  end;
  repeat
    if FParseIndex < 0 then
    begin
      while not FCursor.Next do
      begin
        FCursor.Close;
        FreeAndNil(FCursor);
        if (FTables = nil) or not InitNextCursor then
          Exit(False);
      end;
      FSqlCreateTable := FCursor.Value[ShowCreateTableSqlOrdinal].AsString;
      FParseIndex := 0;
    end;
    FParseIndex := FReader.ParseCreateTableForNextForeignKey(FSqlCreateTable, FParseIndex, FKey);
  until ((FParseIndex >= 0) and (FKey.FKeyColumns.Count > 0) and (FForeignKeyName.IsEmpty or (FForeignKeyName = FKey.FConstraintName)) and (FPrimaryTableName.IsEmpty or (FPrimaryTableName = FKey.FReferencedTableName)));
  FKeyIndex := 0;
  SetValues;
  Result := True;
end;

procedure TDBXMySqlCustomMetaDataReader.TDBXMySql4ForeignKeyColumnsCursor.SetValues;
begin
  FRow.Value[TDBXForeignKeyColumnsIndex.CatalogName].SetNull;
  FRow.Value[TDBXForeignKeyColumnsIndex.SchemaName].SetNull;
  FRow.Value[TDBXForeignKeyColumnsIndex.PrimaryCatalogName].SetNull;
  FRow.Value[TDBXForeignKeyColumnsIndex.PrimarySchemaName].SetNull;
  FRow.Value[TDBXForeignKeyColumnsIndex.PrimaryKeyName].SetNull;
  FRow.Value[TDBXForeignKeyColumnsIndex.TableName].AsString := FTableName;
  FRow.Value[TDBXForeignKeyColumnsIndex.ForeignKeyName].AsString := FKey.FConstraintName;
  FRow.Value[TDBXForeignKeyColumnsIndex.PrimaryTableName].AsString := FKey.FReferencedTableName;
  FRow.Value[TDBXForeignKeyColumnsIndex.ColumnName].AsString := string(FKey.FKeyColumns[FKeyIndex]);
  FRow.Value[TDBXForeignKeyColumnsIndex.PrimaryColumnName].AsString := string(FKey.FReferencedColumns[FKeyIndex]);
  FRow.Value[TDBXForeignKeyColumnsIndex.Ordinal].AsInt32 := FKeyIndex + 1;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySql4ForeignKeyColumnsCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  case Ordinal of
    TDBXForeignKeyColumnsIndex.CatalogName,
    TDBXForeignKeyColumnsIndex.SchemaName,
    TDBXForeignKeyColumnsIndex.PrimaryCatalogName,
    TDBXForeignKeyColumnsIndex.PrimarySchemaName,
    TDBXForeignKeyColumnsIndex.PrimaryKeyName,
    TDBXForeignKeyColumnsIndex.TableName,
    TDBXForeignKeyColumnsIndex.ForeignKeyName,
    TDBXForeignKeyColumnsIndex.PrimaryTableName,
    TDBXForeignKeyColumnsIndex.ColumnName,
    TDBXForeignKeyColumnsIndex.PrimaryColumnName,
    TDBXForeignKeyColumnsIndex.Ordinal:
      Exit(FRow.Value[Ordinal]);
  end;
  Result := inherited GetWritableValue(Ordinal);
end;

constructor TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureSourcesCursor.Create(const Reader: TDBXMySqlCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Sql: string; const SchemaName: string; const ProcedureName: string);
begin
  inherited Create(Reader.Context, TDBXMetaDataCollectionName.ProcedureSources, Columns, nil);
  self.FReader := Reader;
  self.FSql := Sql;
  self.FProcedureName := ProcedureName;
  self.FProcedureType := Proc;
  self.FProcedures := TDBXStringList.Create;
  self.FProcedureTypes := TDBXStringList.Create;
  self.FReader.GetProcedures(SchemaName, ProcedureName, FProcedures, FProcedureTypes);
  self.FProcedureIndex := -1;
  InitNextCursor;
  FRow := TDBXSingleValueRow.Create;
  FRow.Columns := CopyColumns;
end;

destructor TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureSourcesCursor.Destroy;
begin
  Close;
  FreeAndNil(FRow);
  inherited Destroy;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureSourcesCursor.FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer;
begin
  Result := DefaultVarcharPrecision;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureSourcesCursor.InitNextCursor: Boolean;
var
  Query: string;
begin
  IncrAfter(FProcedureIndex);
  if FProcedureIndex >= FProcedures.Count then
    Exit(False);
  FProcedureName := string(FProcedures[FProcedureIndex]);
  FProcedureType := string(FProcedureTypes[FProcedureIndex]);
  Query := FSql;
  Query := FReader.ReplaceIdentifier(Query, TDBXParameterName.ProcedureName, FProcedureName, True);
  Query := FReader.ReplaceIdentifier(Query, TDBXParameterName.ProcedureType, FProcedureType, False);
  FCursor := FReader.Context.ExecuteQuery(Query, nil, nil);
  Result := True;
end;

procedure TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureSourcesCursor.Close;
begin
  if FCursor <> nil then
    FCursor.Close;
  FCursor.Free;
  FCursor := nil;
  FreeAndNil(FProcedures);
  FreeAndNil(FProcedureTypes);
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureSourcesCursor.Next: Boolean;
begin
  if FCursor = nil then
    Exit(False);
  while not FCursor.Next do
  begin
    FCursor.Close;
    FreeAndNil(FCursor);
    if not InitNextCursor then
      Exit(False);
  end;
  FDefiner := ComputeDefiner;
  FRow.Value[TDBXProcedureSourcesIndex.CatalogName].SetNull;
  FRow.Value[TDBXProcedureSourcesIndex.ExternalDefinition].SetNull;
  if FDefiner.IsEmpty then
    FRow.Value[TDBXProcedureSourcesIndex.SchemaName].SetNull
  else 
    FRow.Value[TDBXProcedureSourcesIndex.SchemaName].AsString := FDefiner;
  FRow.Value[TDBXProcedureSourcesIndex.ProcedureName].AsString := FProcedureName;
  FRow.Value[TDBXProcedureSourcesIndex.ProcedureType].AsString := FProcedureType;
  FRow.Value[TDBXProcedureSourcesIndex.Definition].AsString := ComputeDefinition;
  Result := True;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureSourcesCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  case Ordinal of
    TDBXProcedureSourcesIndex.CatalogName,
    TDBXProcedureSourcesIndex.ExternalDefinition,
    TDBXProcedureSourcesIndex.SchemaName,
    TDBXProcedureSourcesIndex.ProcedureName,
    TDBXProcedureSourcesIndex.ProcedureType,
    TDBXProcedureSourcesIndex.Definition:
      Exit(FRow.Value[Ordinal]);
  end;
  Result := inherited GetWritableValue(Ordinal);
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureSourcesCursor.ComputeDefinition: string;
var
  SqlCreateProcedure: string;
  Index: Integer;
begin
  SqlCreateProcedure := FCursor.Value[ShowCreateProcedureSqlOrdinal].AsString;
  Index := SqlCreateProcedure.IndexOf(FProcedureType);
  if Index >= 0 then
    SqlCreateProcedure := cCreate + '"' + SqlCreateProcedure.Substring(Index, SqlCreateProcedure.Length - Index);
  Result := SqlCreateProcedure;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureSourcesCursor.ComputeDefiner: string;
var
  Definer, SqlCreateProcedure: string;
  EndIndex, Index: Integer;
begin
  Definer := NullString;
  SqlCreateProcedure := FCursor.Value[ShowCreateProcedureSqlOrdinal].AsString;
  Index := SqlCreateProcedure.IndexOf(DefinerString);
  if Index >= 0 then
  begin
    Index := Index + DefinerString.Length + 1;
    EndIndex := SqlCreateProcedure.IndexOf(FReader.SqlIdentifierQuoteSuffix, Index);
    if EndIndex > 0 then
      Definer := SqlCreateProcedure.Substring(Index, EndIndex - Index);
  end;
  Result := Definer;
end;

constructor TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureParametersCursor.Create(const Reader: TDBXMySqlCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Sql: string; const SchemaName: string; const ProcedureName: string; const ParameterName: string);
begin
  inherited Create(Reader.Context, TDBXMetaDataCollectionName.ProcedureParameters, Columns, nil);
  self.FReader := Reader;
  self.FSql := Sql;
  self.FProcedureName := ProcedureName;
  self.FParameterName := ParameterName;
  self.FProcedureType := Proc;
  self.FProcedures := TDBXStringList.Create;
  self.FProcedureTypes := TDBXStringList.Create;
  self.FReader.GetProcedures(SchemaName, ProcedureName, FProcedures, FProcedureTypes);
  self.FProcedureIndex := -1;
  self.FParams := TDBXArrayList.Create;
  InitNextCursor;
  FRow := TDBXSingleValueRow.Create;
  FRow.Columns := CopyColumns;
end;

destructor TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureParametersCursor.Destroy;
var
  I: Integer;
begin
  Close;
  if FParams <> nil then
  begin
    for I := 0 to FParams.Count - 1 do
      FParams[I].Free;
    FParams.Clear;
  end;
  FreeAndNil(FParams);
  FreeAndNil(FRow);
  inherited Destroy;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureParametersCursor.FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer;
begin
  Result := DefaultVarcharPrecision;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureParametersCursor.InitNextCursor: Boolean;
var
  Query: string;
begin
  IncrAfter(FProcedureIndex);
  if FProcedureIndex >= FProcedures.Count then
    Exit(False);
  FProcedureName := string(FProcedures[FProcedureIndex]);
  FProcedureType := string(FProcedureTypes[FProcedureIndex]);
  Query := FSql;
  Query := FReader.ReplaceIdentifier(Query, TDBXParameterName.ProcedureName, FProcedureName, True);
  Query := FReader.ReplaceIdentifier(Query, TDBXParameterName.ProcedureType, FProcedureType, False);
  FCursor := FReader.Context.ExecuteQuery(Query, nil, nil);
  Result := True;
end;

procedure TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureParametersCursor.Close;
begin
  if FCursor <> nil then
    FCursor.Close;
  FreeAndNil(FCursor);
  FreeAndNil(FProcedures);
  FreeAndNil(FProcedureTypes);
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureParametersCursor.Next: Boolean;
begin
  if FCursor = nil then
    Exit(False);
  IncrAfter(FParameterIndex);
  while True do
  begin
    while FParameterIndex < FParams.Count do
    begin
      FParameter := TDBXMySqlCustomMetaDataReader.TMySqlParameter(FParams[FParameterIndex]);
      if FParameterName.IsEmpty or (FParameterName = FParameter.FName) then
      begin
        SetValues;
        Exit(True);
      end;
      IncrAfter(FParameterIndex);
    end;
    while not FCursor.Next do
    begin
      FCursor.Close;
      FreeAndNil(FCursor);
      if not InitNextCursor then
        Exit(False);
    end;
    ComputeParams;
  end;
end;

procedure TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureParametersCursor.SetValues;
begin
  FRow.Value[TDBXProcedureParametersIndex.SchemaName].SetNull;
  FRow.Value[TDBXProcedureParametersIndex.DbxDataType].SetNull;
  FRow.Value[TDBXProcedureParametersIndex.IsFixedLength].SetNull;
  FRow.Value[TDBXProcedureParametersIndex.IsLong].SetNull;
  if FDefiner.IsEmpty then
    FRow.Value[TDBXProcedureParametersIndex.CatalogName].SetNull
  else 
    FRow.Value[TDBXProcedureParametersIndex.CatalogName].AsString := FDefiner;
  FRow.Value[TDBXProcedureParametersIndex.ProcedureName].AsString := FProcedureName;
  FRow.Value[TDBXProcedureParametersIndex.ParameterName].AsString := FParameter.FName;
  FRow.Value[TDBXProcedureParametersIndex.ParameterMode].AsString := FParameter.FMode;
  FRow.Value[TDBXProcedureParametersIndex.TypeName].AsString := FParameter.FDataType;
  FRow.Value[TDBXProcedureParametersIndex.Precision].AsInt64 := FParameter.FPrecision;
  FRow.Value[TDBXProcedureParametersIndex.Scale].AsInt32 := FParameter.FScale;
  FRow.Value[TDBXProcedureParametersIndex.Ordinal].AsInt32 := FParameter.FOrdinal;
  FRow.Value[TDBXProcedureParametersIndex.IsNullable].AsBoolean := not FParameter.FNotnull;
  FRow.Value[TDBXProcedureParametersIndex.IsUnicode].AsBoolean := FParameter.FUnicode;
  FRow.Value[TDBXProcedureParametersIndex.IsUnsigned].AsBoolean := FParameter.FUnsigned;
end;

function TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureParametersCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  case Ordinal of
    TDBXProcedureParametersIndex.CatalogName,
    TDBXProcedureParametersIndex.SchemaName,
    TDBXProcedureParametersIndex.DbxDataType,
    TDBXProcedureParametersIndex.IsFixedLength,
    TDBXProcedureParametersIndex.IsLong,
    TDBXProcedureParametersIndex.ProcedureName,
    TDBXProcedureParametersIndex.ParameterName,
    TDBXProcedureParametersIndex.ParameterMode,
    TDBXProcedureParametersIndex.TypeName,
    TDBXProcedureParametersIndex.Precision,
    TDBXProcedureParametersIndex.Scale,
    TDBXProcedureParametersIndex.Ordinal,
    TDBXProcedureParametersIndex.IsNullable,
    TDBXProcedureParametersIndex.IsUnicode,
    TDBXProcedureParametersIndex.IsUnsigned:
      Exit(FRow.Value[Ordinal]);
  end;
  Result := inherited GetWritableValue(Ordinal);
end;

procedure TDBXMySqlCustomMetaDataReader.TDBXMySqlProcedureParametersCursor.ComputeParams;
var
  SqlCreateProcedure: string;
begin
  SqlCreateProcedure := FCursor.Value[ShowCreateProcedureSqlOrdinal].AsString;
  FDefiner := FReader.ParseProcedureDefiner(SqlCreateProcedure);
  FReader.ParseProcedure(SqlCreateProcedure, FProcedureType, FParams);
  FParameterIndex := 0;
end;

function TDBXMySqlMetaDataReader.GetProductName: string;
begin
  Result := 'MySQL';
end;

function TDBXMySqlMetaDataReader.GetSqlIdentifierQuotePrefix: string;
begin
  Result := '`';
end;

function TDBXMySqlMetaDataReader.GetSqlIdentifierQuoteSuffix: string;
begin
  Result := '`';
end;

function TDBXMySqlMetaDataReader.GetSqlIdentifierQuoteChar: string;
begin
  Result := '`';
end;

function TDBXMySqlMetaDataReader.GetTableType: string;
begin
  Result := 'BASE TABLE';
end;

function TDBXMySqlMetaDataReader.IsDescendingIndexColumnsSupported: Boolean;
begin
  Result := False;
end;

function TDBXMySqlMetaDataReader.IsLowerCaseIdentifiersSupported: Boolean;
begin
  Result := True;
end;

function TDBXMySqlMetaDataReader.IsUpperCaseIdentifiersSupported: Boolean;
begin
  Result := False;
end;

function TDBXMySqlMetaDataReader.IsMultipleCommandsSupported: Boolean;
begin
  Result := False;
end;

function TDBXMySqlMetaDataReader.FetchCatalogs: TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateCatalogsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Catalogs, Columns);
end;

function TDBXMySqlMetaDataReader.FetchSchemas(const CatalogName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateSchemasColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Schemas, Columns);
end;

function TDBXMySqlMetaDataReader.GetSqlForTables: string;
var
  CurrentVersion: string;
begin
  CurrentVersion := Version;
  if CurrentVersion >= '05.00.0000' then
    Result := 'SELECT TABLE_SCHEMA, CAST(NULL AS CHAR(1)), TABLE_NAME, CASE TABLE_TYPE WHEN ''BASE TABLE'' THEN ''TABLE'' ELSE TABLE_TYPE END ' +
              'FROM INFORMATION_SCHEMA.TABLES ' +
              'WHERE (TABLE_SCHEMA = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (1=1 OR :SCHEMA_NAME IS NULL) AND (TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (TABLE_TYPE IN (:TABLES,:VIEWS,:SYSTEM_VIEWS,:SYSTEM_TABLES)) ' +
              'ORDER BY 1,2,3'
  else 
    Result := 'SHOW TABLES';
end;

function TDBXMySqlMetaDataReader.GetSqlForViews: string;
var
  CurrentVersion: string;
begin
  CurrentVersion := Version;
  if CurrentVersion >= '05.00.0000' then
    Result := 'SELECT TABLE_SCHEMA, CAST(NULL AS CHAR(1)), TABLE_NAME, VIEW_DEFINITION ' +
              'FROM INFORMATION_SCHEMA.VIEWS ' +
              'WHERE (TABLE_SCHEMA = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (1=1 OR :SCHEMA_NAME IS NULL) AND (TABLE_NAME = :VIEW_NAME OR (:VIEW_NAME IS NULL)) ' +
              'ORDER BY 1,2,3'
  else 
    Result := 'EmptyTable';
end;

function TDBXMySqlMetaDataReader.GetSqlForColumns: string;
var
  CurrentVersion: string;
begin
  CurrentVersion := Version;
  if CurrentVersion >= '05.00.0000' then
    Result := 'SELECT TABLE_SCHEMA, CAST(NULL AS CHAR(1)), TABLE_NAME, COLUMN_NAME, DATA_TYPE, COALESCE(NUMERIC_PRECISION,CHARACTER_MAXIMUM_LENGTH), NUMERIC_SCALE, ORDINAL_POSITION, CAST(CASE WHEN COLUMN_DEFAULT IS NOT NULL AND COLUMN_DEFAULT <> ''CURRENT_TIMESTAMP'' AND ' + 'DATA_TYPE IN (''char'',''varchar'',''timestamp'',''datetime'',''date'',''time'',''year'') THEN CONCAT("''",COLUMN_DEFAULT,"''") ELSE COLUMN_DEFAULT END AS CHAR(255)), IS_NULLABLE=''YES'', LOCATE(''auto_increment'',EXTRA) > 0, -1, CHARACTER_SET_NAME, (LOCATE(''unsigned'',COLUMN' + '_TYPE) > 0) ' +
              'FROM INFORMATION_SCHEMA.COLUMNS ' +
              'WHERE (TABLE_SCHEMA = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (1=1 OR :SCHEMA_NAME IS NULL) AND (TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
              'ORDER BY 1,2,3,ORDINAL_POSITION'
  else 
    Result := 'SHOW COLUMNS FROM :TABLE_NAME';
end;

function TDBXMySqlMetaDataReader.FetchColumnConstraints(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateColumnConstraintsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.ColumnConstraints, Columns);
end;

function TDBXMySqlMetaDataReader.GetSqlForIndexes: string;
var
  CurrentVersion: string;
begin
  CurrentVersion := Version;
  if CurrentVersion >= '05.00.0000' then
    Result := 'SELECT TABLE_SCHEMA, CAST(NULL AS CHAR(1)), TABLE_NAME, INDEX_NAME, CASE WHEN NON_UNIQUE = 0 THEN INDEX_NAME ELSE NULL END, INDEX_NAME=''PRIMARY'', NON_UNIQUE=0, 1=1 ' +
              'FROM INFORMATION_SCHEMA.STATISTICS ' +
              'WHERE (TABLE_SCHEMA = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (1=1 OR :SCHEMA_NAME IS NULL) AND (TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
              'GROUP BY 1, 2, 3 ,4 ' +
              'ORDER BY 1, 2, 3, 4'
  else 
    Result := 'SHOW INDEX FROM :TABLE_NAME';
end;

function TDBXMySqlMetaDataReader.GetSqlForIndexColumns: string;
var
  CurrentVersion: string;
begin
  CurrentVersion := Version;
  if CurrentVersion >= '05.00.0000' then
    Result := 'SELECT TABLE_SCHEMA, CAST(NULL AS CHAR(1)), TABLE_NAME, INDEX_NAME, COLUMN_NAME, SEQ_IN_INDEX, COLLATION=''A'' ' +
              'FROM INFORMATION_SCHEMA.STATISTICS ' +
              'WHERE (TABLE_SCHEMA = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (1=1 OR :SCHEMA_NAME IS NULL) AND (TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (INDEX_NAME = :INDEX_NAME OR (:INDEX_NAME IS NULL)) ' +
              'ORDER BY 1, 2, 3, 4, SEQ_IN_INDEX'
  else 
    Result := 'SHOW INDEX FROM :TABLE_NAME';
end;

function TDBXMySqlMetaDataReader.GetSqlForForeignKeys: string;
var
  CurrentVersion: string;
begin
  CurrentVersion := Version;
  if CurrentVersion >= '05.00.0000' then
    Result := 'SELECT TABLE_SCHEMA, CAST(NULL AS CHAR(1)), TABLE_NAME, CONSTRAINT_NAME ' +
              'FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE ' +
              'WHERE POSITION_IN_UNIQUE_CONSTRAINT IS NOT NULL ' +
              ' AND (TABLE_SCHEMA = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (1=1 OR :SCHEMA_NAME IS NULL) AND (TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
              'GROUP BY 1,2,3,4 ' +
              'ORDER BY 1,2,3,4'
  else 
    Result := 'SHOW CREATE TABLE :TABLE_NAME';
end;

function TDBXMySqlMetaDataReader.GetSqlForForeignKeyColumns: string;
var
  CurrentVersion: string;
begin
  CurrentVersion := Version;
  if CurrentVersion >= '05.00.0006' then
    Result := 'SELECT TABLE_SCHEMA, CAST(NULL AS CHAR(1)), TABLE_NAME, CONSTRAINT_NAME, COLUMN_NAME, REFERENCED_TABLE_SCHEMA, CAST(NULL AS CHAR(1)), REFERENCED_TABLE_NAME, ''PRIMARY'', REFERENCED_COLUMN_NAME, ORDINAL_POSITION ' +
              'FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE ' +
              'WHERE POSITION_IN_UNIQUE_CONSTRAINT IS NOT NULL ' +
              ' AND (TABLE_SCHEMA = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (1=1 OR :SCHEMA_NAME IS NULL) AND (TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
              ' AND (REFERENCED_TABLE_SCHEMA = :PRIMARY_CATALOG_NAME OR (:PRIMARY_CATALOG_NAME IS NULL)) AND (1=1 OR (:PRIMARY_SCHEMA_NAME IS NULL)) AND (REFERENCED_TABLE_NAME = :PRIMARY_TABLE_NAME OR (:PRIMARY_TABLE_NAME IS NULL)) AND (''PRIMARY'' = :PRIMARY_KEY_NAME OR ' + '(:PRIMARY_KEY_NAME IS NULL)) ' +
              'ORDER BY 1,2,3,4,ORDINAL_POSITION'
  else 
    Result := 'SHOW CREATE TABLE :TABLE_NAME';
end;

function TDBXMySqlMetaDataReader.FetchSynonyms(const CatalogName: string; const SchemaName: string; const SynonymName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateSynonymsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Synonyms, Columns);
end;

function TDBXMySqlMetaDataReader.GetSqlForProcedures: string;
var
  CurrentVersion: string;
begin
  CurrentVersion := Version;
  if CurrentVersion >= '05.00.0006' then
    Result := 'SELECT ROUTINE_SCHEMA, NULL, ROUTINE_NAME, ROUTINE_TYPE ' +
              'FROM INFORMATION_SCHEMA.ROUTINES ' +
              'WHERE (ROUTINE_SCHEMA = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (1=1 OR (:SCHEMA_NAME IS NULL)) AND (ROUTINE_NAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) AND (ROUTINE_TYPE = ''PROCEDURE'') ' +
              'ORDER BY 1, 2, 3'
  else 
    Result := 'EmptyTable';
end;

function TDBXMySqlMetaDataReader.GetSqlForProcedureSources: string;
begin
  Result := 'SHOW CREATE :PROCEDURE_TYPE :PROCEDURE_NAME';
end;

function TDBXMySqlMetaDataReader.GetSqlForProcedureParameters: string;
begin
  Result := 'SHOW CREATE :PROCEDURE_TYPE :PROCEDURE_NAME';
end;

function TDBXMySqlMetaDataReader.FetchPackages(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackagesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Packages, Columns);
end;

function TDBXMySqlMetaDataReader.FetchPackageProcedures(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ProcedureType: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProceduresColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageProcedures, Columns);
end;

function TDBXMySqlMetaDataReader.FetchPackageProcedureParameters(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ParameterName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProcedureParametersColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageProcedureParameters, Columns);
end;

function TDBXMySqlMetaDataReader.FetchPackageSources(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageSourcesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageSources, Columns);
end;

function TDBXMySqlMetaDataReader.GetSqlForUsers: string;
var
  CurrentVersion: string;
begin
  CurrentVersion := Version;
  if CurrentVersion >= '05.00.0000' then
    Result := 'SELECT USER FROM MYSQL.USER'
  else 
    Result := 'EmptyTable';
end;

function TDBXMySqlMetaDataReader.FetchRoles: TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateRolesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Roles, Columns);
end;

function TDBXMySqlMetaDataReader.GetReservedWords: TDBXStringArray;
var
  Words: TDBXStringArray;
begin
  SetLength(Words,225);
  Words[0] := 'ADD';
  Words[1] := 'ALL';
  Words[2] := 'ALTER';
  Words[3] := 'ANALYZE';
  Words[4] := 'AND';
  Words[5] := 'AS';
  Words[6] := 'ASC';
  Words[7] := 'ASENSITIVE';
  Words[8] := 'BEFORE';
  Words[9] := 'BETWEEN';
  Words[10] := 'BIGINT';
  Words[11] := 'BINARY';
  Words[12] := 'BLOB';
  Words[13] := 'BOTH';
  Words[14] := 'BY';
  Words[15] := 'CALL';
  Words[16] := 'CASCADE';
  Words[17] := 'CASE';
  Words[18] := 'CHANGE';
  Words[19] := 'CHAR';
  Words[20] := 'CHARACTER';
  Words[21] := 'CHECK';
  Words[22] := 'COLLATE';
  Words[23] := 'COLUMN';
  Words[24] := 'CONDITION';
  Words[25] := 'CONNECTION';
  Words[26] := 'CONSTRAINT';
  Words[27] := 'CONTINUE';
  Words[28] := 'CONVERT';
  Words[29] := 'CREATE';
  Words[30] := 'CROSS';
  Words[31] := 'CURRENT_DATE';
  Words[32] := 'CURRENT_TIME';
  Words[33] := 'CURRENT_TIMESTAMP';
  Words[34] := 'CURRENT_USER';
  Words[35] := 'CURSOR';
  Words[36] := 'DATABASE';
  Words[37] := 'DATABASES';
  Words[38] := 'DAY_HOUR';
  Words[39] := 'DAY_MICROSECOND';
  Words[40] := 'DAY_MINUTE';
  Words[41] := 'DAY_SECOND';
  Words[42] := 'DEC';
  Words[43] := 'DECIMAL';
  Words[44] := 'DECLARE';
  Words[45] := 'DEFAULT';
  Words[46] := 'DELAYED';
  Words[47] := 'DELETE';
  Words[48] := 'DESC';
  Words[49] := 'DESCRIBE';
  Words[50] := 'DETERMINISTIC';
  Words[51] := 'DISTINCT';
  Words[52] := 'DISTINCTROW';
  Words[53] := 'DIV';
  Words[54] := 'DOUBLE';
  Words[55] := 'DROP';
  Words[56] := 'DUAL';
  Words[57] := 'EACH';
  Words[58] := 'ELSE';
  Words[59] := 'ELSEIF';
  Words[60] := 'ENCLOSED';
  Words[61] := 'ESCAPED';
  Words[62] := 'EXISTS';
  Words[63] := 'EXIT';
  Words[64] := 'EXPLAIN';
  Words[65] := 'FALSE';
  Words[66] := 'FETCH';
  Words[67] := 'FLOAT';
  Words[68] := 'FLOAT4';
  Words[69] := 'FLOAT8';
  Words[70] := 'FOR';
  Words[71] := 'FORCE';
  Words[72] := 'FOREIGN';
  Words[73] := 'FROM';
  Words[74] := 'FULLTEXT';
  Words[75] := 'GOTO';
  Words[76] := 'GRANT';
  Words[77] := 'GROUP';
  Words[78] := 'HAVING';
  Words[79] := 'HIGH_PRIORITY';
  Words[80] := 'HOUR_MICROSECOND';
  Words[81] := 'HOUR_MINUTE';
  Words[82] := 'HOUR_SECOND';
  Words[83] := 'IF';
  Words[84] := 'IGNORE';
  Words[85] := 'IN';
  Words[86] := 'INDEX';
  Words[87] := 'INFILE';
  Words[88] := 'INNER';
  Words[89] := 'INOUT';
  Words[90] := 'INSENSITIVE';
  Words[91] := 'INSERT';
  Words[92] := 'INT';
  Words[93] := 'INT1';
  Words[94] := 'INT2';
  Words[95] := 'INT3';
  Words[96] := 'INT4';
  Words[97] := 'INT8';
  Words[98] := 'INTEGER';
  Words[99] := 'INTERVAL';
  Words[100] := 'INTO';
  Words[101] := 'IS';
  Words[102] := 'ITERATE';
  Words[103] := 'JOIN';
  Words[104] := 'KEY';
  Words[105] := 'KEYS';
  Words[106] := 'KILL';
  Words[107] := 'LABEL';
  Words[108] := 'LEADING';
  Words[109] := 'LEAVE';
  Words[110] := 'LEFT';
  Words[111] := 'LIKE';
  Words[112] := 'LIMIT';
  Words[113] := 'LINES';
  Words[114] := 'LOAD';
  Words[115] := 'LOCALTIME';
  Words[116] := 'LOCALTIMESTAMP';
  Words[117] := 'LOCK';
  Words[118] := 'LONG';
  Words[119] := 'LONGBLOB';
  Words[120] := 'LONGTEXT';
  Words[121] := 'LOOP';
  Words[122] := 'LOW_PRIORITY';
  Words[123] := 'MATCH';
  Words[124] := 'MEDIUMBLOB';
  Words[125] := 'MEDIUMINT';
  Words[126] := 'MEDIUMTEXT';
  Words[127] := 'MIDDLEINT';
  Words[128] := 'MINUTE_MICROSECOND';
  Words[129] := 'MINUTE_SECOND';
  Words[130] := 'MOD';
  Words[131] := 'MODIFIES';
  Words[132] := 'NATURAL';
  Words[133] := 'NO_WRITE_TO_BINLOG';
  Words[134] := 'NOT';
  Words[135] := 'NULL';
  Words[136] := 'NUMERIC';
  Words[137] := 'ON';
  Words[138] := 'OPTIMIZE';
  Words[139] := 'OPTION';
  Words[140] := 'OPTIONALLY';
  Words[141] := 'OR';
  Words[142] := 'ORDER';
  Words[143] := 'OUT';
  Words[144] := 'OUTER';
  Words[145] := 'OUTFILE';
  Words[146] := 'PRECISION';
  Words[147] := 'PRIMARY';
  Words[148] := 'PROCEDURE';
  Words[149] := 'PURGE';
  Words[150] := 'RAID0';
  Words[151] := 'READ';
  Words[152] := 'READS';
  Words[153] := 'REAL';
  Words[154] := 'REFERENCES';
  Words[155] := 'REGEXP';
  Words[156] := 'RELEASE';
  Words[157] := 'RENAME';
  Words[158] := 'REPEAT';
  Words[159] := 'REPLACE';
  Words[160] := 'REQUIRE';
  Words[161] := 'RESTRICT';
  Words[162] := 'RETURN';
  Words[163] := 'REVOKE';
  Words[164] := 'RIGHT';
  Words[165] := 'RLIKE';
  Words[166] := 'SCHEMA';
  Words[167] := 'SCHEMAS';
  Words[168] := 'SECOND_MICROSECOND';
  Words[169] := 'SELECT';
  Words[170] := 'SENSITIVE';
  Words[171] := 'SEPARATOR';
  Words[172] := 'SET';
  Words[173] := 'SHOW';
  Words[174] := 'SMALLINT';
  Words[175] := 'SONAME';
  Words[176] := 'SPATIAL';
  Words[177] := 'SPECIFIC';
  Words[178] := 'SQL';
  Words[179] := 'SQL_BIG_RESULT';
  Words[180] := 'SQL_CALC_FOUND_ROWS';
  Words[181] := 'SQL_SMALL_RESULT';
  Words[182] := 'SQLEXCEPTION';
  Words[183] := 'SQLSTATE';
  Words[184] := 'SQLWARNING';
  Words[185] := 'SSL';
  Words[186] := 'STARTING';
  Words[187] := 'STRAIGHT_JOIN';
  Words[188] := 'TABLE';
  Words[189] := 'TERMINATED';
  Words[190] := 'THEN';
  Words[191] := 'TINYBLOB';
  Words[192] := 'TINYINT';
  Words[193] := 'TINYTEXT';
  Words[194] := 'TO';
  Words[195] := 'TRAILING';
  Words[196] := 'TRIGGER';
  Words[197] := 'TRUE';
  Words[198] := 'UNDO';
  Words[199] := 'UNION';
  Words[200] := 'UNIQUE';
  Words[201] := 'UNLOCK';
  Words[202] := 'UNSIGNED';
  Words[203] := 'UPDATE';
  Words[204] := 'UPGRADE';
  Words[205] := 'USAGE';
  Words[206] := 'USE';
  Words[207] := 'USING';
  Words[208] := 'UTC_DATE';
  Words[209] := 'UTC_TIME';
  Words[210] := 'UTC_TIMESTAMP';
  Words[211] := 'VALUES';
  Words[212] := 'VARBINARY';
  Words[213] := 'VARCHAR';
  Words[214] := 'VARCHARACTER';
  Words[215] := 'VARYING';
  Words[216] := 'WHEN';
  Words[217] := 'WHERE';
  Words[218] := 'WHILE';
  Words[219] := 'WITH';
  Words[220] := 'WRITE';
  Words[221] := 'X509';
  Words[222] := 'XOR';
  Words[223] := 'YEAR_MONTH';
  Words[224] := 'ZEROFILL';
  Result := Words;
end;

end.

