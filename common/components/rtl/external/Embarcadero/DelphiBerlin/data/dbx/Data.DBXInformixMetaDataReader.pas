{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.DBXInformixMetaDataReader;

interface

uses
  Data.DBXCommon,
  Data.DBXCommonTable,
  Data.DBXMetaDataReader,
  Data.DBXPlatform,
  Data.DBXSqlScanner,
  System.SysUtils;

type
  
  /// <summary>  TDBXInformixCustomMetaDataReader contains custom code for Informix.
  /// </summary>
  /// <remarks>  This class handles data types and column names for indices and foreign keys.
  /// </remarks>
  TDBXInformixCustomMetaDataReader = class(TDBXBaseMetaDataReader)
  public
    type

      /// <summary>  TDBXInformixColumnsCursor is a filter for a cursor providing table columns.
      /// </summary>
      /// <remarks>  In Informix the type, precision and scale are all encoded in the system tables.
      ///   This filter also normalizes the default value.
      /// </remarks>
            
      /// <summary>  TDBXInformixColumnsCursor is a filter for a cursor providing table columns.
      /// </summary>
      /// <remarks>  In Informix the type, precision and scale are all encoded in the system tables.
      ///   This filter also normalizes the default value.
      /// </remarks>
      TDBXInformixColumnsCursor = class(TDBXCustomMetaDataTable)
      public
        destructor Destroy; override;
        function Next: Boolean; override;
      protected
        constructor Create(const Reader: TDBXInformixCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable);
        function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
      private
        procedure ReadTypeInformation;
        function ComputeTypeName: string;
        function ComputePrecision: Integer;
        function HasScale: Boolean;
        function ComputeScale: Integer;
        function ComputeNullable: Boolean;
        function ComputeAutoIncrement: Boolean;
        function ComputeDefaultValue: string;
        function ComputeTypeQualifier: string;
        function GetQualifier(const FieldQualifier: Integer): string;
        function ComputeLiteralValue: string;
      private
        FReader: TDBXInformixCustomMetaDataReader;
        FColType: SmallInt;
        FColLength: SmallInt;
        FDefaultType: string;
        FDefaultValue: string;
        FExtendedName: string;
        FRow: TDBXSingleValueRow;
      private
        const ColumnsCatalogName = 0;
        const ColumnsSchemaName = 1;
        const ColumnsTableName = 2;
        const ColumnsColumnName = 3;
        const ColumnsColtype = 4;
        const ColumnsXname = 5;
        const ColumnsCollength = 6;
        const ColumnsOrdinal = 7;
        const ColumnsDefaultType = 8;
        const ColumnsDefaultValue = 9;
      end;
            
      /// <summary>  TDBXInformixIndexColumnsCursor is a filter for a cursor providing index columns.
      /// </summary>
      /// <remarks>  In Informix all the columns of an index are given in one row
      ///   of the SYSINDEXES system table.
      ///   This filter will extract them into a separate rows as expected by the index columns metadata collection.
      /// </remarks>
      TDBXInformixIndexColumnsCursor = class(TDBXCustomMetaDataTable)
      public
        destructor Destroy; override;
        function Next: Boolean; override;
      protected
        constructor Create(const Provider: TDBXInformixCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable);
        function FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer; override;
        function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
      private
        function IndexOfColumnName(const KeyIndex: Integer): Integer;
      private
        FKeyIndex: Integer;
        FRow: TDBXSingleValueRow;
      private
        const KeyCount = 16;
        const DefaultColumnSize = 256;
      end;
            
      /// <summary>  TDBXInformixForeignKeyColumnsCursor is a filter for a cursor providing foreign key columns.
      /// </summary>
      /// <remarks>  In Informix all the columns of a foreign key relation are given in 2 rows
      ///   of the SYSINDEXES system table (one row for the foreign key columns and one row for the
      ///   columns being referenced.)
      ///   This filter will extract them into a separate rows as expected by the foreign key metadata collection.
      /// </remarks>
      TDBXInformixForeignKeyColumnsCursor = class(TDBXCustomMetaDataTable)
      public
        destructor Destroy; override;
        function Next: Boolean; override;
      protected
        constructor Create(const Reader: TDBXInformixCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable);
        function FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer; override;
        function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
      private
        function IndexOfForeignKeyColumnName(const KeyIndex: Integer): Integer;
        function IndexOfPrimaryKeyColumnName(const KeyIndex: Integer): Integer;
      public
        FRow: TDBXSingleValueRow;
      private
        FKeyIndex: Integer;
      private
        const KeyCount = 16;
        const DefaultColumnSize = 256;
      end;

      TInformixParameter = class
      public
        FName: string;
        FTypeName: string;
        FMode: string;
        FDataType: TDBXDataTypeDescription;
        FOrdinal: Integer;
        FPrecision: Integer;
        FScale: Integer;
        FPrecisionParsed: Boolean;
      end;

      TDBXInformixProcedureParametersCursor = class(TDBXCustomMetaDataTable)
      public
        constructor Create(const Reader: TDBXInformixCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Parameter: string; const Cursor: TDBXTable);
        destructor Destroy; override;
        procedure Close; override;
        function Next: Boolean; override;
      protected
        function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
      private
        procedure SetValues;
        procedure ComputeParams;
      private
        FReader: TDBXInformixCustomMetaDataReader;
        FParameterName: string;
        FParameterIndex: Integer;
        FParams: TDBXArrayList;
        FParameter: TDBXInformixCustomMetaDataReader.TInformixParameter;
        FCursor: TDBXTable;
        FBuffer: TStringBuilder;
        FBeforeEnd: Boolean;
        FBeforeFirst: Boolean;
        FProcedureType: string;
        FIsCatalogNameNull: Boolean;
        FIsSchemaNameNull: Boolean;
        FIsProcedureNameNull: Boolean;
        FCatalogName: string;
        FSchemaName: string;
        FProcedureName: string;
        FRow: TDBXSingleValueRow;
      private
        const LineNumberOrdinal = 6;
      end;

  public
    destructor Destroy; override;
    
    /// <summary>  Overrides the implementation in TDBXBaseMetaDataReader.
    /// </summary>
    /// <remarks>  A custom filter is added to extract the type information for each column.
    /// </remarks>
    /// <seealso cref="TDBXInformixColumnsCursor"/>
    function FetchColumns(const Catalog: string; const Schema: string; const Table: string): TDBXTable; override;
    
    /// <summary>  Overrides the implementation in TDBXBaseMetaDataReader.
    /// </summary>
    /// <remarks>  A custom filter is added to extract the column names into separate rows.
    /// </remarks>
    /// <seealso cref="TDBXInformixIndexColumnsCursor"/>
    function FetchIndexColumns(const Catalog: string; const Schema: string; const Table: string; const Index: string): TDBXTable; override;
    
    /// <summary>  Overrides the implementation in TDBXBaseMetaDataReader.
    /// </summary>
    /// <remarks>  A custom filter is added to extract the column names into separate rows.
    /// </remarks>
    /// <seealso cref="TDBXInformixForeignKeyColumnsCursor"/>
    function FetchForeignKeyColumns(const Catalog: string; const Schema: string; const Table: string; const ForeignKeyName: string; const PrimaryCatalog: string; const PrimarySchema: string; const PrimaryTable: string; const PrimaryKeyName: string): TDBXTable; override;
    function FetchProcedureParameters(const Catalog: string; const Schema: string; const Proc: string; const Parameter: string): TDBXTable; override;
  protected
    procedure SetContext(const Context: TDBXProviderContext); override;
    function GetSqlIdentifierQuotePrefix: string; override;
    function GetSqlIdentifierQuoteSuffix: string; override;
    function GetSqlIdentifierQuoteChar: string; override;
    function GetDataTypeDescriptions: TDBXDataTypeDescriptionArray; override;
    function GetAllDataTypes: TDBXDataTypeDescriptionArray;
  private
    procedure InitScanner;
    procedure ParseProcedure(const Definition: string; const aType: string; const Params: TDBXArrayList);
    function ParseType(const InToken: Integer; const Param: TDBXInformixCustomMetaDataReader.TInformixParameter): Integer;
    function ParsePrecision(const Param: TDBXInformixCustomMetaDataReader.TInformixParameter): Integer;
    function ToInt(const Value: string): Integer;
  protected
    FScanner: TDBXSqlScanner;
  private
    FAlltypes: TDBXDataTypeDescriptionArray;
    FQuoteChar: string;
  private
    property AllDataTypes: TDBXDataTypeDescriptionArray read GetAllDataTypes;
  private
    const CharType = 0;
    const SmallintType = 1;
    const IntegerType = 2;
    const FloatType = 3;
    const SmallfloatType = 4;
    const DecimalType = 5;
    const SerialType = 6;
    const DateType = 7;
    const MoneyType = 8;
    const DatetimeType = 10;
    const ByteType = 11;
    const TextType = 12;
    const VarcharType = 13;
    const IntervalType = 14;
    const NcharType = 15;
    const NvarcharType = 16;
    const Int8_Type = 17;
    const Serial8_Type = 18;
    const LvarcharType = 19;
    const BooleanType = 20;
    const TypesCount = 21;
    const NullType = 9;
    const SetType = 19;
    const MultisetType = 20;
    const ListType = 21;
    const UnnamedRowType = 22;
    const VarOpaqueType = 40;
    const FixedOpaqueType = 41;
    const NullTypeFlag = 256;
    const CharTypename = 'CHAR';
    const VarcharTypename = 'VARCHAR';
    const LvarcharTypename = 'LVARCHAR';
    const NcharTypename = 'NCHAR';
    const NvarcharTypename = 'NVARCHAR';
    const SmallintTypename = 'SMALLINT';
    const IntegerTypename = 'INTEGER';
    const Int8_Typename = 'INT8';
    const FloatTypename = 'FLOAT';
    const SmallfloatTypename = 'SMALLFLOAT';
    const DecimalTypename = 'DECIMAL';
    const SerialTypename = 'SERIAL';
    const Serial8_Typename = 'SERIAL8';
    const DateTypename = 'DATE';
    const DatetimeTypename = 'DATETIME';
    const IntervalTypename = 'INTERVAL';
    const MoneyTypename = 'MONEY';
    const ByteTypename = 'BYTE';
    const TextTypename = 'TEXT';
    const BooleanTypename = 'BOOLEAN';
    const Create = 'CREATE';
    const Returning = 'RETURNING';
    const cIn = 'IN';
    const cOut = 'OUT';
    const Inout = 'INOUT';
    const Like = 'LIKE';
    const References = 'REFERENCES';
    const IntType = 'INT';
    const DecType = 'DEC';
    const BigintType = 'BIGINT';
    const Character = 'CHARACTER';
    const Varying = 'VARYING';
    const RealType = 'REAL';
    const DoubleType = 'DOUBLE';
    const Precision = 'PRECISION';
    const Numeric = 'NUMERIC';
    const Default = 'DEFAULT';
    const QuoteCharacterEnabled = 'QuoteCharEnabled';
    const TokenCreate = 51;
    const TokenProcedure = 52;
    const TokenFunction = 53;
    const TokenReturning = 54;
    const TokenOut = 55;
    const TokenInout = 56;
    const TokenLike = 57;
    const TokenReferences = 58;
    const TokenInt = 59;
    const TokenDec = 60;
    const TokenBigint = 61;
    const TokenCharacter = 62;
    const TokenVarying = 63;
    const TokenReal = 64;
    const TokenDouble = 65;
    const TokenPrecision = 66;
    const TokenNumeric = 67;
    const TokenDefault = 68;
  end;

  TDBXInformixMetaDataReader = class(TDBXInformixCustomMetaDataReader)
  public
    function FetchCatalogs: TDBXTable; override;
    function FetchColumnConstraints(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable; override;
    function FetchPackages(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable; override;
    function FetchPackageProcedures(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ProcedureType: string): TDBXTable; override;
    function FetchPackageProcedureParameters(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ParameterName: string): TDBXTable; override;
    function FetchPackageSources(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable; override;
  protected
    function AreSchemasSupported: Boolean; override;
    function GetProductName: string; override;
    function GetTableType: string; override;
    function GetViewType: string; override;
    function GetSystemTableType: string; override;
    function GetSynonymType: string; override;
    function IsLowerCaseIdentifiersSupported: Boolean; override;
    function IsUpperCaseIdentifiersSupported: Boolean; override;
    function GetSqlForSchemas: string; override;
    function GetSqlForTables: string; override;
    function GetSqlForViews: string; override;
    function GetSqlForColumns: string; override;
    function GetSqlForIndexes: string; override;
    function GetSqlForIndexColumns: string; override;
    function GetSqlForForeignKeys: string; override;
    function GetSqlForForeignKeyColumns: string; override;
    function GetSqlForSynonyms: string; override;
    function GetSqlForProcedures: string; override;
    function GetSqlForProcedureSources: string; override;
    function GetSqlForUsers: string; override;
    function GetSqlForRoles: string; override;
    function GetReservedWords: TDBXStringArray; override;
  end;

implementation

uses
  Data.DBXMetaDataNames;

destructor TDBXInformixCustomMetaDataReader.Destroy;
begin
  FreeObjectArray(TDBXFreeArray(FAlltypes));
  FreeAndNil(FScanner);
  inherited Destroy;
end;

procedure TDBXInformixCustomMetaDataReader.SetContext(const Context: TDBXProviderContext);
begin
  inherited SetContext(Context);
//  defaultCharSetIsUnicode = context.getVendorProperty(DEFAULT_CHARSET_IS_UNICODE).equals("true");
  FQuoteChar := C_Conditional((Context.GetVendorProperty(QuoteCharacterEnabled) = 'true'), '"', '');
end;

function TDBXInformixCustomMetaDataReader.GetSqlIdentifierQuotePrefix: string;
begin
  Result := FQuoteChar;
end;

function TDBXInformixCustomMetaDataReader.GetSqlIdentifierQuoteSuffix: string;
begin
  Result := FQuoteChar;
end;

function TDBXInformixCustomMetaDataReader.GetSqlIdentifierQuoteChar: string;
begin
  Result := FQuoteChar;
end;

function TDBXInformixCustomMetaDataReader.GetDataTypeDescriptions: TDBXDataTypeDescriptionArray;
var
  Index, TargetIndex: Integer;
  DataTypes: TDBXDataTypeDescriptionArray;
begin
  AllDataTypes;
  TargetIndex := 0;
  for Index := 0 to Length(FAlltypes) - 1 do
  begin
    if FAlltypes[Index] <> nil then
      IncrAfter(TargetIndex);
  end;
  SetLength(DataTypes,TargetIndex);
  TargetIndex := 0;
  for Index := 0 to Length(FAlltypes) - 1 do
  begin
    if FAlltypes[Index] <> nil then
    begin
      DataTypes[TargetIndex] := TDBXDataTypeDescription.Create(FAlltypes[Index]);
      IncrAfter(TargetIndex);
    end;
  end;
  Result := DataTypes;
end;

function TDBXInformixCustomMetaDataReader.GetAllDataTypes: TDBXDataTypeDescriptionArray;
var
  Newtypes: TDBXDataTypeDescriptionArray;
begin
  if FAlltypes = nil then
  begin
    SetLength(Newtypes,TypesCount);
    Newtypes[CharType] := TDBXDataTypeDescription.Create(CharTypename, TDBXDataTypes.AnsiStringType, 32767, 'CHAR({0})', 'Precision', -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.Unsigned);
    Newtypes[VarcharType] := TDBXDataTypeDescription.Create(VarcharTypename, TDBXDataTypes.AnsiStringType, 254, 'VARCHAR({0})', 'Precision', -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.Unsigned);
    Newtypes[NcharType] := TDBXDataTypeDescription.Create(NcharTypename, TDBXDataTypes.WideStringType, 32767, 'NCHAR({0})', 'Precision', -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.Unsigned);
    Newtypes[NvarcharType] := TDBXDataTypeDescription.Create(NvarcharTypename, TDBXDataTypes.WideStringType, 254, 'NVARCHAR({0})', 'Precision', -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.Unsigned);
    Newtypes[SmallintType] := TDBXDataTypeDescription.Create(SmallintTypename, TDBXDataTypes.Int16Type, 5, 'SMALLINT', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
    Newtypes[IntegerType] := TDBXDataTypeDescription.Create(IntegerTypename, TDBXDataTypes.Int32Type, 10, 'INTEGER', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
    Newtypes[Int8_Type] := TDBXDataTypeDescription.Create(Int8_Typename, TDBXDataTypes.Int64Type, 19, 'INT8', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
    Newtypes[FloatType] := TDBXDataTypeDescription.Create(FloatTypename, TDBXDataTypes.DoubleType, 14, 'FLOAT', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
    Newtypes[SmallfloatType] := TDBXDataTypeDescription.Create(SmallfloatTypename, TDBXDataTypes.SingleType, 7, 'SMALLFLOAT', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
    Newtypes[DecimalType] := TDBXDataTypeDescription.Create(DecimalTypename, TDBXDataTypes.DoubleType, 14, 'DECIMAL({0}, {1})', 'Precision, Scale', -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
    Newtypes[SerialType] := TDBXDataTypeDescription.Create(SerialTypename, TDBXDataTypes.Int32Type, 10, 'SERIAL', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Searchable);
    Newtypes[Serial8_Type] := TDBXDataTypeDescription.Create(Serial8_Typename, TDBXDataTypes.Int64Type, 19, 'SERIAL8', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Searchable);
    Newtypes[DateType] := TDBXDataTypeDescription.Create(DateTypename, TDBXDataTypes.DateType, 10, 'DATE', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
    Newtypes[DatetimeType] := TDBXDataTypeDescription.Create(DatetimeTypename, TDBXDataTypes.TimeStampType, 11, 'DATETIME YEAR TO FRACTION', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
//      newtypes[INTERVAL_TYPE] = new DataTypeDescription(INTERVAL_TYPENAME, DataTypes.INTERVAL_TYPE, 11L, "INTERVAL", null, -1, -1, null, null, null, null, TypeFlag.BEST_MATCH | TypeFlag.NULLABLE | TypeFlag.SEARCHABLE);
    Newtypes[MoneyType] := TDBXDataTypeDescription.Create(MoneyTypename, TDBXDataTypes.BcdType, 32, 'MONEY({0},{1})', 'Precision, Scale', 32, 0, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
    Newtypes[ByteType] := TDBXDataTypeDescription.Create(ByteTypename, TDBXDataTypes.BlobType, 2147483647, 'BYTE', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Long or TDBXTypeFlag.Nullable);
    Newtypes[TextType] := TDBXDataTypeDescription.Create(TextTypename, TDBXDataTypes.AnsiStringType, 2147483647, 'TEXT', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.Long or TDBXTypeFlag.Nullable);
    Newtypes[LvarcharType] := TDBXDataTypeDescription.Create(LvarcharTypename, TDBXDataTypes.AnsiStringType, 32739, 'LVARCHAR({0})', 'Precision', -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.Unsigned);
    Newtypes[BooleanType] := TDBXDataTypeDescription.Create(BooleanTypename, TDBXDataTypes.BooleanType, 1, 'BOOLEAN', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.Unsigned);
    FAlltypes := Newtypes;
  end;
  Result := FAlltypes;
end;

function TDBXInformixCustomMetaDataReader.FetchColumns(const Catalog: string; const Schema: string; const Table: string): TDBXTable;
var
  ParameterNames: TDBXStringArray;
  ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  SetLength(ParameterNames,3);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.TableName;
  SetLength(ParameterValues,3);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := Table;
  Cursor := Context.ExecuteQuery(SqlForColumns, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateColumnsColumns;
  Cursor := TDBXInformixCustomMetaDataReader.TDBXInformixColumnsCursor.Create(self, Columns, Cursor);
  Result := TDBXColumnsTableCursor.Create(self, False, Cursor);
end;

function TDBXInformixCustomMetaDataReader.FetchIndexColumns(const Catalog: string; const Schema: string; const Table: string; const Index: string): TDBXTable;
var
  ParameterNames: TDBXStringArray;
  ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  SetLength(ParameterNames,4);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.TableName;
  ParameterNames[3] := TDBXParameterName.IndexName;
  SetLength(ParameterValues,4);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := Table;
  ParameterValues[3] := Index;
  Cursor := Context.ExecuteQuery(SqlForIndexColumns, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateIndexColumnsColumns;
  Result := TDBXInformixCustomMetaDataReader.TDBXInformixIndexColumnsCursor.Create(self, Columns, Cursor);
end;

function TDBXInformixCustomMetaDataReader.FetchForeignKeyColumns(const Catalog: string; const Schema: string; const Table: string; const ForeignKeyName: string; const PrimaryCatalog: string; const PrimarySchema: string; const PrimaryTable: string; const PrimaryKeyName: string): TDBXTable;
var
  ParameterNames: TDBXStringArray;
  ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  SetLength(ParameterNames,8);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.TableName;
  ParameterNames[3] := TDBXParameterName.ForeignKeyName;
  ParameterNames[4] := TDBXParameterName.PrimaryCatalogName;
  ParameterNames[5] := TDBXParameterName.PrimarySchemaName;
  ParameterNames[6] := TDBXParameterName.PrimaryTableName;
  ParameterNames[7] := TDBXParameterName.PrimaryKeyName;
  SetLength(ParameterValues,8);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := Table;
  ParameterValues[3] := ForeignKeyName;
  ParameterValues[4] := PrimaryCatalog;
  ParameterValues[5] := PrimarySchema;
  ParameterValues[6] := PrimaryTable;
  ParameterValues[7] := PrimaryKeyName;
  Cursor := Context.ExecuteQuery(SqlForForeignKeyColumns, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateForeignKeyColumnsColumns;
  Result := TDBXInformixCustomMetaDataReader.TDBXInformixForeignKeyColumnsCursor.Create(self, Columns, Cursor);
end;

function TDBXInformixCustomMetaDataReader.FetchProcedureParameters(const Catalog: string; const Schema: string; const Proc: string; const Parameter: string): TDBXTable;
var
  ParameterNames: TDBXStringArray;
  ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  AllDataTypes;
  SetLength(ParameterNames,3);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.ProcedureName;
  SetLength(ParameterValues,3);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := Proc;
  Cursor := Context.ExecuteQuery(SqlForProcedureSources, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateProcedureParametersColumns;
  Result := TDBXInformixCustomMetaDataReader.TDBXInformixProcedureParametersCursor.Create(self, Columns, Parameter, Cursor);
end;

procedure TDBXInformixCustomMetaDataReader.InitScanner;
var
  Scan: TDBXSqlScanner;
begin
  if FScanner = nil then
  begin
    Scan := TDBXSqlScanner.Create(SqlIdentifierQuoteChar, SqlIdentifierQuotePrefix, SqlIdentifierQuoteSuffix);
    Scan.RegisterId(Create, TokenCreate);
    Scan.RegisterId(TDBXProcedureType.ProcedureType, TokenProcedure);
    Scan.RegisterId(TDBXProcedureType.FunctionType, TokenFunction);
    Scan.RegisterId(Returning, TokenReturning);
    Scan.RegisterId(cOut, TokenOut);
    Scan.RegisterId(Inout, TokenInout);
    Scan.RegisterId(Like, TokenLike);
    Scan.RegisterId(References, TokenReferences);
    Scan.RegisterId(IntType, TokenInt);
    Scan.RegisterId(DecType, TokenDec);
    Scan.RegisterId(BigintType, TokenBigint);
    Scan.RegisterId(Character, TokenCharacter);
    Scan.RegisterId(Varying, TokenVarying);
    Scan.RegisterId(RealType, TokenReal);
    Scan.RegisterId(DoubleType, TokenDouble);
    Scan.RegisterId(Precision, TokenPrecision);
    Scan.RegisterId(Numeric, TokenNumeric);
    Scan.RegisterId(Default, TokenDefault);
    Scan.RegisterId(CharTypename, CharType);
    Scan.RegisterId(VarcharTypename, VarcharType);
    Scan.RegisterId(NcharTypename, NcharType);
    Scan.RegisterId(NvarcharTypename, NvarcharType);
    Scan.RegisterId(SmallintTypename, SmallintType);
    Scan.RegisterId(IntegerTypename, IntegerType);
    Scan.RegisterId(Int8_Typename, Int8_Type);
    Scan.RegisterId(FloatTypename, FloatType);
    Scan.RegisterId(SmallfloatTypename, SmallfloatType);
    Scan.RegisterId(DecimalTypename, DecimalType);
    Scan.RegisterId(SerialTypename, SerialType);
    Scan.RegisterId(Serial8_Typename, Serial8_Type);
    Scan.RegisterId(DateTypename, DateType);
    Scan.RegisterId(DatetimeTypename, DatetimeType);
    Scan.RegisterId(IntervalTypename, IntervalType);
    Scan.RegisterId(MoneyTypename, MoneyType);
    Scan.RegisterId(ByteTypename, ByteType);
    Scan.RegisterId(TextTypename, TextType);
    FScanner := Scan;
  end;
end;

//  CREATE PROCEDURE varchar_20_echo_informix( IN_PARAM VARCHAR(20) ) RETURNING VARCHAR(20)  ; RETURN IN_PARAM;END PROCEDURE;
//  create dba function informix.assign(informix.stat) returns informix.stat external name '(stat_assign)' language C not variant;
//  create dba procedure sqlj.unregisterJUDTfuncs(varchar(255)) external name 'informix.jvp.dbapplet.impl.JarHandler.unregisterJUDTfuncs(java.lang.String)' language java end procedure;
// -- cast from text to clob
//  create function informix.texttoclob(references text)
//      returns informix.clob
//      external name '(bytetoblob)'
//      language c not variant;
//   ---
//   ---        Register builtin java UDRs for Krakatoa
//   ---
//
//   create dba procedure sqlj.registerJUDTfuncs(varchar(255)) external name
//    'informix.jvp.dbapplet.impl.JarHandler.registerJUDTfuncs(java.lang.String)'
//  language java end procedure;
procedure TDBXInformixCustomMetaDataReader.ParseProcedure(const Definition: string; const aType: string; const Params: TDBXArrayList);
var
  ReturnType: TDBXInformixCustomMetaDataReader.TInformixParameter;
  Ordinal: Integer;
  Token: Integer;
  Param: TDBXInformixCustomMetaDataReader.TInformixParameter;
begin
  Params.Clear;
  ReturnType := nil;
//    Not yet: These return values will be returned in a result set.
//             Hold on until SqlExpr can deal with them.
//    if (type.equals(ProcedureType.FUNCTION_TYPE)) {
//      returnType = new InformixParameter();
//      returnType.name = "RETURN_VALUE";
//      returnType.mode = "RESULT";
//      returnType.ordinal = 0;
//      params.add(returnType);
//    }
  InitScanner;
  FScanner.Init(Definition);
  Ordinal := 1;
  Token := TDBXSqlScanner.TokenId;
  while Token <> TDBXSqlScanner.TokenOpenParen do
    Token := FScanner.NextToken;
  Token := TDBXSqlScanner.TokenComma;
  while Token = TDBXSqlScanner.TokenComma do
  begin
    Param := TDBXInformixCustomMetaDataReader.TInformixParameter.Create;
    Param.FMode := cIn;
    Token := FScanner.NextToken;
    if (Token = TokenOut) or (Token = TokenInout) then
    begin
      Param.FMode := FScanner.Id;
      Token := FScanner.NextToken;
    end;
    if Token = TDBXSqlScanner.TokenId then
    begin
      Param.FName := FScanner.Id;
      Token := FScanner.NextToken;
    end
    else 
      Param.FName := 'P' + IntToStr(Ordinal);
    Param.FOrdinal := Ordinal;
    Token := ParseType(Token, Param);
    Params.Add(Param);
    IncrAfter(Ordinal);
  end;

  Token := FScanner.NextToken;
  if (ReturnType <> nil) and (Token = TokenReturning) then
  begin
    Token := FScanner.NextToken;
    ParseType(Token, ReturnType);
  end;
end;

function TDBXInformixCustomMetaDataReader.ParseType(const InToken: Integer; const Param: TDBXInformixCustomMetaDataReader.TInformixParameter): Integer;
var
  Token: Integer;
  DottedName: Boolean;
begin
  Token := InToken;
  DottedName := False;
  Param.FTypeName := FScanner.Id;
  case Token of
    TokenInt:
      begin
        Param.FTypeName := IntegerTypename;
        Token := IntegerType;
      end;
    TokenBigint:
      begin
        Param.FTypeName := Int8_Typename;
        Token := Int8_Type;
      end;
    TokenDec,
    TokenNumeric:
      begin
        Param.FTypeName := DecimalTypename;
        Token := DecimalType;
      end;
    TokenReal:
      begin
        Param.FTypeName := SmallfloatTypename;
        Token := SmallfloatType;
      end;
    TokenDouble:
      begin
        Token := FScanner.LookAtNextToken;
        if Token = TokenPrecision then
        begin
          FScanner.NextToken;
          Param.FTypeName := FloatTypename;
          Param.FPrecision := 14;
          Token := FloatType;
        end;
      end;
    TokenCharacter:
      begin
        Token := FScanner.LookAtNextToken;
        if Token <> TokenVarying then
        begin
          Param.FTypeName := CharTypename;
          Token := CharType;
        end
        else 
        begin
          FScanner.NextToken;
          Param.FTypeName := VarcharTypename;
          Token := VarcharType;
        end;
      end;
    TokenDefault,
    TDBXSqlScanner.TokenPeriod,
    TDBXSqlScanner.TokenComma,
    TDBXSqlScanner.TokenCloseParen,
    TDBXSqlScanner.TokenSemicolon,
    TDBXSqlScanner.TokenEos:
      begin
        Param.FTypeName := Param.FName;
        Param.FName := 'P' + IntToStr(Param.FOrdinal);
        if Token = TDBXSqlScanner.TokenPeriod then
        begin
          DottedName := True;
          Param.FTypeName := Param.FTypeName + '.';
        end
        else if Token <> TokenDefault then
          Exit(Token);
      end;
  end;
  if (Token >= CharType) and (Token < TypesCount) then
    Param.FDataType := FAlltypes[Token];
  Token := FScanner.LookAtNextToken;
  if Token = TDBXSqlScanner.TokenPeriod then
    DottedName := True;
  while True do
  begin
    Token := FScanner.NextToken;
    case Token of
      TDBXSqlScanner.TokenSemicolon,
      TDBXSqlScanner.TokenEos,
      TDBXSqlScanner.TokenComma,
      TDBXSqlScanner.TokenCloseParen:
        Exit(Token);
      TDBXSqlScanner.TokenOpenParen:
        begin
          DottedName := False;
          ParsePrecision(Param);
        end;
      TDBXSqlScanner.TokenPeriod:
        if DottedName then
          Param.FTypeName := Param.FTypeName + '.';
      else
        if DottedName and ((Token = TDBXSqlScanner.TokenId) or (Token >= 0)) then
          Param.FTypeName := Param.FTypeName + FScanner.Id
        else 
          DottedName := False;
    end;
  end;
end;

function TDBXInformixCustomMetaDataReader.ParsePrecision(const Param: TDBXInformixCustomMetaDataReader.TInformixParameter): Integer;
var
  Token: Integer;
begin
  Token := FScanner.NextToken;
  if not Param.FPrecisionParsed then
  begin
    Param.FPrecisionParsed := True;
    if Token = TDBXSqlScanner.TokenNumber then
    begin
      Param.FPrecision := ToInt(FScanner.Id);
      Token := FScanner.NextToken;
      if Token = TDBXSqlScanner.TokenComma then
      begin
        Token := FScanner.NextToken;
        if Token = TDBXSqlScanner.TokenNumber then
        begin
          Param.FScale := ToInt(FScanner.Id);
          Token := FScanner.NextToken;
        end;
      end;
    end;
  end;
  while Token <> TDBXSqlScanner.TokenCloseParen do
    Token := FScanner.NextToken;
  Result := FScanner.NextToken;
end;

function TDBXInformixCustomMetaDataReader.ToInt(const Value: string): Integer;
begin
  try
    Result := StrToInt(Value);
  except
    on Ex: Exception do
      Result := -1;
  end;
end;

constructor TDBXInformixCustomMetaDataReader.TDBXInformixColumnsCursor.Create(const Reader: TDBXInformixCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable);
begin
  inherited Create(Reader.Context, TDBXMetaDataCollectionName.Columns, Columns, Cursor);
  self.FReader := Reader;
  FRow := TDBXSingleValueRow.Create;
  FRow.Columns := CopyColumns;
end;

destructor TDBXInformixCustomMetaDataReader.TDBXInformixColumnsCursor.Destroy;
begin
  FreeAndNil(FRow);
  inherited Destroy;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixColumnsCursor.Next: Boolean;
var
  ReturnValue: Boolean;
begin
  FColType := Low(SmallInt);
  ReturnValue := inherited Next;
  if ReturnValue then
  begin
    FRow.Value[TDBXColumnsIndex.TypeName].AsString := ComputeTypeName;
    FRow.Value[TDBXColumnsIndex.DefaultValue].AsString := ComputeDefaultValue;
    FRow.Value[TDBXColumnsIndex.Precision].AsInt64 := ComputePrecision;
    if HasScale then
      FRow.Value[TDBXColumnsIndex.Scale].AsInt32 := ComputeScale
    else 
    begin
      FRow.Value[TDBXColumnsIndex.Scale].AsInt32 := ComputeScale;
      FRow.Value[TDBXColumnsIndex.Scale].SetNull;
    end;
    FRow.Value[TDBXColumnsIndex.IsNullable].AsBoolean := ComputeNullable;
    FRow.Value[TDBXColumnsIndex.IsAutoIncrement].AsBoolean := ComputeAutoIncrement;
  end;
  Result := ReturnValue;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixColumnsCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  case Ordinal of
    TDBXColumnsIndex.TypeName,
    TDBXColumnsIndex.DefaultValue,
    TDBXColumnsIndex.Precision,
    TDBXColumnsIndex.Scale,
    TDBXColumnsIndex.IsNullable,
    TDBXColumnsIndex.IsAutoIncrement:
      Exit(FRow.Value[Ordinal]);
  end;
  Result := inherited GetWritableValue(Ordinal);
end;

procedure TDBXInformixCustomMetaDataReader.TDBXInformixColumnsCursor.ReadTypeInformation;
begin
  if FColType = Low(SmallInt) then
  begin
    FColType := FCursor.Value[ColumnsColtype].AsInt16;
    FColLength := FCursor.Value[ColumnsCollength].AsInt16;
    FDefaultType := GetAsString(FCursor, ColumnsDefaultType, NullString);
    FDefaultValue := GetAsString(FCursor, ColumnsDefaultValue, NullString);
    FExtendedName := GetAsString(FCursor, ColumnsXname, NullString);
    if not FDefaultValue.IsEmpty then
      FDefaultValue := FDefaultValue.Trim;
  end;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixColumnsCursor.ComputeTypeName: string;
var
  Types: TDBXDataTypeDescriptionArray;
  DataType: Integer;
  TypeName: string;
begin
  ReadTypeInformation;
  Types := FReader.AllDataTypes;
  DataType := FColType and 255;
  if (DataType >= CharType) and (DataType <= Serial8_Type) and (DataType <> NullType) then
    Exit(Types[DataType].TypeName);
  TypeName := 'UNKNOWN';
  case DataType of
    NullType:
      TypeName := 'NULL';
    DatetimeType:
      TypeName := 'DATETIME';
    IntervalType:
      TypeName := 'INTERVAL';
    SetType:
      TypeName := 'SET';
    MultisetType:
      TypeName := 'MULTISET';
    ListType:
      TypeName := 'LIST';
    else
      if not FExtendedName.IsEmpty then
        TypeName := FExtendedName;
  end;
  Result := TypeName;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixColumnsCursor.ComputePrecision: Integer;
var
  DataType: Integer;
  Precision: Integer;
begin
  ReadTypeInformation;
  DataType := FColType and 255;
  Precision := FColLength and 65535;
  case DataType of
    VarcharType,
    NvarcharType:
      Precision := FColLength and 255;
    DatetimeType,
    IntervalType,
    MoneyType,
    DecimalType:
      Precision := Precision div 256;
  end;
  Result := Precision;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixColumnsCursor.HasScale: Boolean;
var
  DataType: Integer;
begin
  ReadTypeInformation;
  DataType := FColType and 255;
  case DataType of
    MoneyType,
    DecimalType:
      Result := True;
    else
      Result := False;
  end;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixColumnsCursor.ComputeScale: Integer;
var
  DataType: Integer;
  Scale: Integer;
begin
  ReadTypeInformation;
  DataType := FColType and 255;
  Scale := 0;
  case DataType of
    MoneyType,
    DecimalType:
      Scale := FColLength and 255;
  end;
  Result := Scale;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixColumnsCursor.ComputeNullable: Boolean;
begin
  Result := (FColType and NullTypeFlag) = 0;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixColumnsCursor.ComputeAutoIncrement: Boolean;
var
  DataType: Integer;
begin
  DataType := FColType and 255;
  case DataType of
    SerialType,
    Serial8_Type:
      Exit(True);
  end;
  Result := False;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixColumnsCursor.ComputeDefaultValue: string;
var
  LType: WideChar;
begin
  ReadTypeInformation;
  LType := 'Z';
  if (not FDefaultType.IsEmpty) and (FDefaultType.Length > 0) then
    LType := FDefaultType.Chars[0];
  case LType of
    'C':
      FDefaultValue := 'CURRENT ' + ComputeTypeQualifier;
    'N':
      FDefaultValue := 'NULL';
    'T':
      FDefaultValue := 'TODAY';
    'U':
      FDefaultValue := 'USER';
    'L':
      if not FDefaultValue.IsEmpty then
        FDefaultValue := ComputeLiteralValue;
    'S':
      FDefaultValue := 'DBSERVERNAME';
    else
      FDefaultValue := NullString;
  end;
  Result := FDefaultValue;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixColumnsCursor.ComputeTypeQualifier: string;
var
  DataType: Integer;
  Qualifier: string;
  Qualifier1: Integer;
  Qualifier2: Integer;
begin
  DataType := FColType and 255;
  Qualifier := NullString;
  if (DataType = DatetimeType) or (DataType = IntervalType) then
  begin
    Qualifier1 := (FColLength and 15) div 16;
    Qualifier2 := FColLength and 15;
    Qualifier := GetQualifier(Qualifier1);
    Qualifier := Qualifier + ' TO ';
    Qualifier := Qualifier + GetQualifier(Qualifier2);
  end;
  Result := Qualifier;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixColumnsCursor.GetQualifier(const FieldQualifier: Integer): string;
var
  Qualifier: string;
begin
  Qualifier := NullString;
  case FieldQualifier of
    0:
      Qualifier := 'YEAR';
    2:
      Qualifier := 'MONTH';
    4:
      Qualifier := 'DAY';
    6:
      Qualifier := 'HOUR';
    8:
      Qualifier := 'MINUTE';
    10:
      Qualifier := 'SECOND';
    else
      if FieldQualifier >= 11 then
      begin
        Qualifier := 'FRACTION(';
        Qualifier := Qualifier + IntToStr(FieldQualifier - 10);
        Qualifier := Qualifier + ')';
      end;
  end;
  Result := Qualifier;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixColumnsCursor.ComputeLiteralValue: string;
var
  ComputedDefaultValue: string;
  DataType, Index: Integer;
  Types: TDBXDataTypeDescriptionArray;
begin
  ComputedDefaultValue := FDefaultValue;
  DataType := FColType and 255;
  case DataType of
    CharType,
    NcharType,
    VarcharType,
    NvarcharType:
      ComputedDefaultValue := '''' + ComputedDefaultValue + '''';
    else
      begin
        Index := ComputedDefaultValue.IndexOf(' ');
        if Index < 0 then
          ComputedDefaultValue := NullString
        else 
        begin
          ComputedDefaultValue := ComputedDefaultValue.Substring(Index + 1, ComputedDefaultValue.Length - (Index + 1));
          ComputedDefaultValue := ComputedDefaultValue.Trim;
          case DataType of
            DateType,
            VarOpaqueType,
            FixedOpaqueType:
              ComputedDefaultValue := '''' + ComputedDefaultValue + '''';
            DatetimeType,
            IntervalType:
              begin
                Types := FReader.AllDataTypes;
                ComputedDefaultValue := Types[DataType].TypeName + ' (' + ComputedDefaultValue + ') ' + ComputeTypeQualifier;
              end;
          end;
        end;
      end;
  end;
  Result := ComputedDefaultValue;
end;

constructor TDBXInformixCustomMetaDataReader.TDBXInformixIndexColumnsCursor.Create(const Provider: TDBXInformixCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable);
begin
  inherited Create(Provider.Context, TDBXMetaDataCollectionName.IndexColumns, Columns, Cursor);
  FKeyIndex := KeyCount;
  FRow := TDBXSingleValueRow.Create;
  FRow.Columns := CopyColumns;
end;

destructor TDBXInformixCustomMetaDataReader.TDBXInformixIndexColumnsCursor.Destroy;
begin
  FreeAndNil(FRow);
  inherited Destroy;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixIndexColumnsCursor.FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer;
begin
  case Ordinal of
    TDBXIndexColumnsIndex.ColumnName:
      Result := DefaultColumnSize;
    else
      Result := inherited FindStringSize(Ordinal, SourceColumns);
  end;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixIndexColumnsCursor.IndexOfColumnName(const KeyIndex: Integer): Integer;
begin
  Result := TDBXIndexColumnsIndex.ColumnName + 2 * KeyIndex + 1;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixIndexColumnsCursor.Next: Boolean;
begin
  repeat
    IncrAfter(FKeyIndex);
    if FKeyIndex >= KeyCount then
    begin
      if not inherited Next then
        Exit(False);
      FKeyIndex := 0;
    end;
    if FCursor.Value[IndexOfColumnName(FKeyIndex)].IsNull then
      FKeyIndex := KeyCount;
  until FKeyIndex < KeyCount;
  if FCursor.Value[IndexOfColumnName(FKeyIndex)].IsNull then
    FRow.Value[TDBXIndexColumnsIndex.ColumnName].SetNull
  else 
    FRow.Value[TDBXIndexColumnsIndex.ColumnName].AsString := FCursor.Value[IndexOfColumnName(FKeyIndex)].AsString;
  FRow.Value[TDBXIndexColumnsIndex.Ordinal].AsInt32 := FKeyIndex + 1;
  FRow.Value[TDBXIndexColumnsIndex.IsAscending].AsBoolean := (FCursor.Value[IndexOfColumnName(FKeyIndex) - 1].AsInt32) >= 0;
  Result := True;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixIndexColumnsCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  case Ordinal of
    TDBXIndexColumnsIndex.ColumnName,
    TDBXIndexColumnsIndex.Ordinal,
    TDBXIndexColumnsIndex.IsAscending:
      Exit(FRow.Value[Ordinal]);
  end;
  Result := inherited GetWritableValue(Ordinal);
end;

constructor TDBXInformixCustomMetaDataReader.TDBXInformixForeignKeyColumnsCursor.Create(const Reader: TDBXInformixCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable);
begin
  inherited Create(Reader.Context, TDBXMetaDataCollectionName.ForeignKeyColumns, Columns, Cursor);
  FKeyIndex := KeyCount;
  FRow := TDBXSingleValueRow.Create;
  FRow.Columns := CopyColumns;
end;

destructor TDBXInformixCustomMetaDataReader.TDBXInformixForeignKeyColumnsCursor.Destroy;
begin
  FreeAndNil(FRow);
  inherited Destroy;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixForeignKeyColumnsCursor.FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer;
begin
  case Ordinal of
    TDBXForeignKeyColumnsIndex.ColumnName,
    TDBXForeignKeyColumnsIndex.PrimaryColumnName:
      Result := DefaultColumnSize;
    else
      Result := inherited FindStringSize(Ordinal, SourceColumns);
  end;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixForeignKeyColumnsCursor.IndexOfForeignKeyColumnName(const KeyIndex: Integer): Integer;
begin
  Result := TDBXForeignKeyColumnsIndex.PrimaryColumnName + 2 * KeyIndex;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixForeignKeyColumnsCursor.IndexOfPrimaryKeyColumnName(const KeyIndex: Integer): Integer;
begin
  Result := TDBXForeignKeyColumnsIndex.PrimaryColumnName + 2 * KeyIndex + 1;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixForeignKeyColumnsCursor.Next: Boolean;
begin
  repeat
    IncrAfter(FKeyIndex);
    if FKeyIndex >= KeyCount then
    begin
      if not inherited Next then
        Exit(False);
      FKeyIndex := 0;
    end;
    if FCursor.Value[IndexOfForeignKeyColumnName(FKeyIndex)].IsNull then
      FKeyIndex := KeyCount;
  until FKeyIndex <> KeyCount;
  FRow.Value[TDBXForeignKeyColumnsIndex.ColumnName].SetValue(FCursor.Value[IndexOfForeignKeyColumnName(FKeyIndex)]);
  FRow.Value[TDBXForeignKeyColumnsIndex.PrimaryColumnName].SetValue(FCursor.Value[IndexOfPrimaryKeyColumnName(FKeyIndex)]);
  FRow.Value[TDBXForeignKeyColumnsIndex.Ordinal].AsInt32 := FKeyIndex + 1;
  Result := True;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixForeignKeyColumnsCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  case Ordinal of
    TDBXForeignKeyColumnsIndex.ColumnName,
    TDBXForeignKeyColumnsIndex.PrimaryColumnName,
    TDBXForeignKeyColumnsIndex.Ordinal:
      Exit(FRow.Value[Ordinal]);
  end;
  Result := inherited GetWritableValue(Ordinal);
end;

constructor TDBXInformixCustomMetaDataReader.TDBXInformixProcedureParametersCursor.Create(const Reader: TDBXInformixCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Parameter: string; const Cursor: TDBXTable);
begin
  inherited Create(Reader.Context, TDBXMetaDataCollectionName.ProcedureParameters, Columns, nil);
  self.FReader := Reader;
  self.FParameterName := Parameter;
  self.FParams := TDBXArrayList.Create;
  self.FCursor := Cursor;
  self.FBuffer := TStringBuilder.Create;
  self.FBeforeFirst := True;
  FRow := TDBXSingleValueRow.Create;
  FRow.Columns := CopyColumns;
end;

destructor TDBXInformixCustomMetaDataReader.TDBXInformixProcedureParametersCursor.Destroy;
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
  FreeAndNil(FBuffer);
  FreeAndNil(FParams);
  FreeAndNil(FRow);
  inherited Destroy;
end;

procedure TDBXInformixCustomMetaDataReader.TDBXInformixProcedureParametersCursor.Close;
begin
  if FCursor <> nil then
    FCursor.Close;
  FreeAndNil(FCursor);
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixProcedureParametersCursor.Next: Boolean;
var
  LineNumber: Integer;
  PrevLineNumber: Integer;
begin
  if FCursor = nil then
    Exit(False);
  IncrAfter(FParameterIndex);
  while True do
  begin
    while FParameterIndex < FParams.Count do
    begin
      FParameter := TDBXInformixCustomMetaDataReader.TInformixParameter(FParams[FParameterIndex]);
      if (FParameterName.IsEmpty) or (FParameterName = FParameter.FName) then
      begin
        SetValues;
        Exit(True);
      end;
      IncrAfter(FParameterIndex);
    end;
    FBuffer.Length := 0;
    if FBeforeFirst then
    begin
      FBeforeEnd := FCursor.Next;
      FBeforeFirst := False;
    end;
    if not FBeforeEnd then
    begin
      FCursor.Close;
      FreeAndNil(FCursor);
      Exit(False);
    end;
    LineNumber := FCursor.Value[LineNumberOrdinal].AsInt32;
    PrevLineNumber := LineNumber - 1;
    FProcedureType := FCursor.Value[TDBXProcedureSourcesIndex.ProcedureType].AsString;
    FIsCatalogNameNull := FCursor.Value[TDBXProcedureParametersIndex.CatalogName].IsNull;
    FIsSchemaNameNull := FCursor.Value[TDBXProcedureParametersIndex.SchemaName].IsNull;
    FIsProcedureNameNull := FCursor.Value[TDBXProcedureParametersIndex.ProcedureName].IsNull;
    if not FIsCatalogNameNull then
      FCatalogName := FCursor.Value[TDBXProcedureParametersIndex.CatalogName].AsString;
    if not FIsSchemaNameNull then
      FSchemaName := FCursor.Value[TDBXProcedureParametersIndex.SchemaName].AsString;
    if not FIsProcedureNameNull then
      FProcedureName := FCursor.Value[TDBXProcedureParametersIndex.ProcedureName].AsString;
    while FBeforeEnd and (LineNumber > PrevLineNumber) do
    begin
      FBuffer.Append(FCursor.Value[TDBXProcedureSourcesIndex.Definition].AsString);
      FBeforeEnd := FCursor.Next;
      if FBeforeEnd then
      begin
        PrevLineNumber := LineNumber;
        LineNumber := FCursor.Value[LineNumberOrdinal].AsInt32;
      end;
    end;
    ComputeParams;
  end;
end;

procedure TDBXInformixCustomMetaDataReader.TDBXInformixProcedureParametersCursor.SetValues;
var
  Ordinal: Integer;
begin
  if FParameter = nil then
    for Ordinal := 0 to Length(FColumns) - 1 do
      FRow.Value[Ordinal].SetNull
  else 
  begin
    if FIsCatalogNameNull then
      FRow.Value[TDBXProcedureParametersIndex.CatalogName].SetNull
    else 
      FRow.Value[TDBXProcedureParametersIndex.CatalogName].AsString := FCatalogName;
    if FIsSchemaNameNull then
      FRow.Value[TDBXProcedureParametersIndex.SchemaName].SetNull
    else 
      FRow.Value[TDBXProcedureParametersIndex.SchemaName].AsString := FSchemaName;
    if FIsProcedureNameNull then
      FRow.Value[TDBXProcedureParametersIndex.ProcedureName].SetNull
    else 
      FRow.Value[TDBXProcedureParametersIndex.ProcedureName].AsString := FProcedureName;
    if FParameter.FName.IsEmpty then
      FRow.Value[TDBXProcedureParametersIndex.ParameterName].SetNull
    else 
      FRow.Value[TDBXProcedureParametersIndex.ParameterName].AsString := FParameter.FName;
    if FParameter.FMode.IsEmpty then
      FRow.Value[TDBXProcedureParametersIndex.ParameterMode].SetNull
    else 
      FRow.Value[TDBXProcedureParametersIndex.ParameterMode].AsString := FParameter.FMode;
    if FParameter.FTypeName.IsEmpty then
      FRow.Value[TDBXProcedureParametersIndex.TypeName].SetNull
    else 
      FRow.Value[TDBXProcedureParametersIndex.TypeName].AsString := FParameter.FTypeName;
    if FParameter.FDataType = nil then
    begin
      FRow.Value[TDBXProcedureParametersIndex.IsFixedLength].SetNull;
      FRow.Value[TDBXProcedureParametersIndex.IsUnicode].SetNull;
      FRow.Value[TDBXProcedureParametersIndex.IsLong].SetNull;
      FRow.Value[TDBXProcedureParametersIndex.IsUnsigned].SetNull;
      FRow.Value[TDBXProcedureParametersIndex.DbxDataType].SetNull;
    end
    else 
    begin
      FRow.Value[TDBXProcedureParametersIndex.IsFixedLength].AsBoolean := FParameter.FDataType.FixedLength;
      FRow.Value[TDBXProcedureParametersIndex.IsUnicode].AsBoolean := FParameter.FDataType.Unicode;
      FRow.Value[TDBXProcedureParametersIndex.IsLong].AsBoolean := FParameter.FDataType.Long;
      FRow.Value[TDBXProcedureParametersIndex.IsUnsigned].AsBoolean := FParameter.FDataType.Unsigned;
      FRow.Value[TDBXProcedureParametersIndex.DbxDataType].AsInt32 := FParameter.FDataType.DbxDataType;
    end;
    FRow.Value[TDBXProcedureParametersIndex.Precision].AsInt64 := FParameter.FPrecision;
    FRow.Value[TDBXProcedureParametersIndex.Scale].AsInt32 := FParameter.FScale;
    FRow.Value[TDBXProcedureParametersIndex.Ordinal].AsInt32 := FParameter.FOrdinal;
    FRow.Value[TDBXProcedureParametersIndex.IsNullable].AsBoolean := True;
  end;
end;

function TDBXInformixCustomMetaDataReader.TDBXInformixProcedureParametersCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  Result := FRow.Value[Ordinal];
end;

procedure TDBXInformixCustomMetaDataReader.TDBXInformixProcedureParametersCursor.ComputeParams;
var
  SqlCreateProcedure: string;
  ProcedureType: string;
begin
  SqlCreateProcedure := FBuffer.ToString;
  ProcedureType := self.FProcedureType;
  FReader.ParseProcedure(SqlCreateProcedure, ProcedureType, FParams);
  FParameterIndex := 0;
end;

function TDBXInformixMetaDataReader.AreSchemasSupported: Boolean;
begin
  Result := True;
end;

function TDBXInformixMetaDataReader.GetProductName: string;
begin
  Result := 'Informix Dynamic Server';
end;

function TDBXInformixMetaDataReader.GetTableType: string;
begin
  Result := 'T';
end;

function TDBXInformixMetaDataReader.GetViewType: string;
begin
  Result := 'V';
end;

function TDBXInformixMetaDataReader.GetSystemTableType: string;
begin
  Result := 'T';
end;

function TDBXInformixMetaDataReader.GetSynonymType: string;
begin
  Result := 'S';
end;

function TDBXInformixMetaDataReader.IsLowerCaseIdentifiersSupported: Boolean;
begin
  Result := True;
end;

function TDBXInformixMetaDataReader.IsUpperCaseIdentifiersSupported: Boolean;
begin
  Result := False;
end;

function TDBXInformixMetaDataReader.FetchCatalogs: TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateCatalogsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Catalogs, Columns);
end;

function TDBXInformixMetaDataReader.GetSqlForSchemas: string;
begin
  Result := 'SELECT DISTINCT CAST(NULL AS VARCHAR(1)), OWNER ' +
            'FROM INFORMIX.SYSTABLES ' +
            'WHERE NCOLS > 0 ' +
            'UNION ' +
            'SELECT CAST(NULL AS VARCHAR(1)), USERNAME ' +
            'FROM INFORMIX.SYSUSERS ' +
            'ORDER BY 1';
end;

function TDBXInformixMetaDataReader.GetSqlForTables: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(10)), OWNER, TABNAME, CASE WHEN SUBSTRING(TABNAME FROM 1 FOR 3) = ''sys'' AND OWNER = ''informix'' THEN CASE TABTYPE WHEN ''V'' THEN ''SYSTEM VIEW'' ELSE ''SYSTEM TABLE'' END ELSE CASE TABTYPE WHEN ''V'' THEN ''VIEW'' ELSE ''TABLE'' END END ' +
            'FROM INFORMIX.SYSTABLES ' +
            'WHERE NCOLS > 0 ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (OWNER = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (TABNAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            ' AND  ((TABTYPE = CASE WHEN SUBSTRING(TABNAME FROM 1 FOR 3) = ''sys'' AND OWNER = ''informix'' THEN :SYSTEM_TABLES ELSE :TABLES END) OR (TABTYPE = CASE WHEN SUBSTRING(TABNAME FROM 1 FOR 3) = ''sys'' AND OWNER = ''informix'' THEN :SYSTEM_VIEWS ELSE :VIEWS END) OR ' + '(TABTYPE = :SYNONYMS)) ' +
            'ORDER BY 2, 3';
end;

function TDBXInformixMetaDataReader.GetSqlForViews: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), T.OWNER, T.TABNAME, V.VIEWTEXT, V.SEQNO AS SOURCE_LINE_NUMBER ' +
            'FROM INFORMIX.SYSTABLES T, INFORMIX.SYSVIEWS V ' +
            'WHERE V.TABID=T.TABID ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (T.OWNER = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (T.TABNAME = :VIEW_NAME OR (:VIEW_NAME IS NULL)) ' +
            'ORDER BY 2, 3, 5';
end;

function TDBXInformixMetaDataReader.GetSqlForColumns: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(10)), T.OWNER, T.TABNAME, C.COLNAME, C.COLTYPE, UPPER(X.NAME), C.COLLENGTH, C.COLNO, D.TYPE, D.DEFAULT, 0, CAST(NULL AS INTEGER) ' +
            'FROM INFORMIX.SYSCOLUMNS C, INFORMIX.SYSTABLES T, OUTER INFORMIX.SYSDEFAULTS D, OUTER INFORMIX.SYSXTDTYPES X ' +
            'WHERE C.TABID=T.TABID AND D.TABID=T.TABID AND C.COLNO=D.COLNO AND C.EXTENDED_ID=X.EXTENDED_ID ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (T.OWNER = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (T.TABNAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            'ORDER BY 2, 3, C.COLNO';
end;

function TDBXInformixMetaDataReader.FetchColumnConstraints(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateColumnConstraintsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.ColumnConstraints, Columns);
end;

function TDBXInformixMetaDataReader.GetSqlForIndexes: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), T.OWNER, T.TABNAME, NVL(C.CONSTRNAME,I.IDXNAME), C.CONSTRNAME, CASE WHEN C.CONSTRTYPE=''P'' THEN 1 ELSE 0 END, I.IDXTYPE IN (''u'',''U''), 1 ' +
            'FROM INFORMIX.SYSTABLES T JOIN INFORMIX.SYSINDEXES I ON I.TABID=T.TABID LEFT JOIN INFORMIX.SYSCONSTRAINTS C ON C.TABID=I.TABID AND C.IDXNAME=I.IDXNAME AND C.CONSTRTYPE IN (''P'',''U'') ' +
            'WHERE SUBSTR(NVL(C.CONSTRNAME,I.IDXNAME),1,1) <> '' '' ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (T.OWNER = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (T.TABNAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            'ORDER BY 1, 2, 3, 4';
end;

function TDBXInformixMetaDataReader.GetSqlForIndexColumns: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), T.OWNER, T.TABNAME, NVL(C.CONSTRNAME,I.IDXNAME), ' +
            '  I.PART1, C1.COLNAME, ' +
            '  I.PART2, C2.COLNAME, ' +
            '  I.PART3, C3.COLNAME, ' +
            '  I.PART4, C4.COLNAME, ' +
            '  I.PART5, C5.COLNAME, ' +
            '  I.PART6, C6.COLNAME, ' +
            '  I.PART7, C7.COLNAME, ' +
            '  I.PART8, C8.COLNAME, ' +
            '  I.PART9, C9.COLNAME, ' +
            '  I.PART10, C10.COLNAME, ' +
            '  I.PART11, C11.COLNAME, ' +
            '  I.PART12, C12.COLNAME, ' +
            '  I.PART13, C13.COLNAME, ' +
            '  I.PART14, C14.COLNAME, ' +
            '  I.PART15, C15.COLNAME, ' +
            '  I.PART16, C16.COLNAME ' +
            'FROM INFORMIX.SYSTABLES T JOIN INFORMIX.SYSINDEXES I ON I.TABID=T.TABID LEFT JOIN INFORMIX.SYSCONSTRAINTS C ON C.TABID=I.TABID AND C.IDXNAME=I.IDXNAME AND C.CONSTRTYPE IN (''P'',''U'') ' +
            '  LEFT JOIN INFORMIX.SYSCOLUMNS C1 ON C1.TABID=I.TABID AND C1.COLNO=ABS(I.PART1) ' +
            '  LEFT JOIN INFORMIX.SYSCOLUMNS C2 ON C2.TABID=I.TABID AND C2.COLNO=ABS(I.PART2) ' +
            '  LEFT JOIN INFORMIX.SYSCOLUMNS C3 ON C3.TABID=I.TABID AND C3.COLNO=ABS(I.PART3) ' +
            '  LEFT JOIN INFORMIX.SYSCOLUMNS C4 ON C4.TABID=I.TABID AND C4.COLNO=ABS(I.PART4) ' +
            '  LEFT JOIN INFORMIX.SYSCOLUMNS C5 ON C5.TABID=I.TABID AND C5.COLNO=ABS(I.PART5) ' +
            '  LEFT JOIN INFORMIX.SYSCOLUMNS C6 ON C6.TABID=I.TABID AND C6.COLNO=ABS(I.PART6) ' +
            '  LEFT JOIN INFORMIX.SYSCOLUMNS C7 ON C7.TABID=I.TABID AND C7.COLNO=ABS(I.PART7) ' +
            '  LEFT JOIN INFORMIX.SYSCOLUMNS C8 ON C8.TABID=I.TABID AND C8.COLNO=ABS(I.PART8) ' +
            '  LEFT JOIN INFORMIX.SYSCOLUMNS C9 ON C9.TABID=I.TABID AND C9.COLNO=ABS(I.PART9) ' +
            '  LEFT JOIN INFORMIX.SYSCOLUMNS C10 ON C10.TABID=I.TABID AND C10.COLNO=ABS(I.PART10) ' +
            '  LEFT JOIN INFORMIX.SYSCOLUMNS C11 ON C11.TABID=I.TABID AND C11.COLNO=ABS(I.PART11) ' +
            '  LEFT JOIN INFORMIX.SYSCOLUMNS C12 ON C12.TABID=I.TABID AND C12.COLNO=ABS(I.PART12) ' +
            '  LEFT JOIN INFORMIX.SYSCOLUMNS C13 ON C13.TABID=I.TABID AND C13.COLNO=ABS(I.PART13) ' +
            '  LEFT JOIN INFORMIX.SYSCOLUMNS C14 ON C14.TABID=I.TABID AND C14.COLNO=ABS(I.PART14) ' +
            '  LEFT JOIN INFORMIX.SYSCOLUMNS C15 ON C15.TABID=I.TABID AND C15.COLNO=ABS(I.PART15) ' +
            '  LEFT JOIN INFORMIX.SYSCOLUMNS C16 ON C16.TABID=I.TABID AND C16.COLNO=ABS(I.PART16) ' +
            'WHERE SUBSTR(NVL(C.CONSTRNAME,I.IDXNAME),1,1) <> '' '' ' +
            '  AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (T.OWNER = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (T.TABNAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (NVL(C.CONSTRNAME,I.IDXNAME) = :INDEX_NAME OR (:INDEX_NAME IS NULL)) ' +
            'ORDER BY 1, 2, 3, 4';
end;

function TDBXInformixMetaDataReader.GetSqlForForeignKeys: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(10)), FT.OWNER, FT.TABNAME, FC.CONSTRNAME ' +
            'FROM INFORMIX.SYSCONSTRAINTS FC, INFORMIX.SYSTABLES FT ' +
            'WHERE FC.TABID=FT.TABID AND FC.CONSTRTYPE=''R'' ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (FT.OWNER = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (FT.TABNAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            'ORDER BY 2, 3, 4';
end;

function TDBXInformixMetaDataReader.GetSqlForForeignKeyColumns: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), FT.OWNER, FT.TABNAME, FC.CONSTRNAME, CAST(NULL AS VARCHAR(1)), CAST(NULL AS VARCHAR(1)), PT.OWNER, PT.TABNAME, PC.CONSTRNAME, ' +
            '  FC1.COLNAME, PC1.COLNAME, ' +
            '  FC2.COLNAME, PC2.COLNAME, ' +
            '  FC3.COLNAME, PC3.COLNAME, ' +
            '  FC4.COLNAME, PC4.COLNAME, ' +
            '  FC5.COLNAME, PC5.COLNAME, ' +
            '  FC6.COLNAME, PC6.COLNAME, ' +
            '  FC7.COLNAME, PC7.COLNAME, ' +
            '  FC8.COLNAME, PC8.COLNAME, ' +
            '  FC9.COLNAME, PC9.COLNAME, ' +
            '  FC10.COLNAME, PC10.COLNAME, ' +
            '  FC11.COLNAME, PC11.COLNAME, ' +
            '  FC12.COLNAME, PC12.COLNAME, ' +
            '  FC13.COLNAME, PC13.COLNAME, ' +
            '  FC14.COLNAME, PC14.COLNAME, ' +
            '  FC15.COLNAME, PC15.COLNAME, ' +
            '  FC16.COLNAME, PC16.COLNAME ' +
            'FROM INFORMIX.SYSREFERENCES R, INFORMIX.SYSCONSTRAINTS FC, INFORMIX.SYSTABLES FT, INFORMIX.SYSINDEXES FI, INFORMIX.SYSCONSTRAINTS PC, INFORMIX.SYSINDEXES PI, INFORMIX.SYSTABLES PT, ' +
            '  OUTER INFORMIX.SYSCOLUMNS FC1, OUTER INFORMIX.SYSCOLUMNS PC1, ' +
            '  OUTER INFORMIX.SYSCOLUMNS FC2, OUTER INFORMIX.SYSCOLUMNS PC2, ' +
            '  OUTER INFORMIX.SYSCOLUMNS FC3, OUTER INFORMIX.SYSCOLUMNS PC3, ' +
            '  OUTER INFORMIX.SYSCOLUMNS FC4, OUTER INFORMIX.SYSCOLUMNS PC4, ' +
            '  OUTER INFORMIX.SYSCOLUMNS FC5, OUTER INFORMIX.SYSCOLUMNS PC5, ' +
            '  OUTER INFORMIX.SYSCOLUMNS FC6, OUTER INFORMIX.SYSCOLUMNS PC6, ' +
            '  OUTER INFORMIX.SYSCOLUMNS FC7, OUTER INFORMIX.SYSCOLUMNS PC7, ' +
            '  OUTER INFORMIX.SYSCOLUMNS FC8, OUTER INFORMIX.SYSCOLUMNS PC8, ' +
            '  OUTER INFORMIX.SYSCOLUMNS FC9, OUTER INFORMIX.SYSCOLUMNS PC9, ' +
            '  OUTER INFORMIX.SYSCOLUMNS FC10, OUTER INFORMIX.SYSCOLUMNS PC10, ' +
            '  OUTER INFORMIX.SYSCOLUMNS FC11, OUTER INFORMIX.SYSCOLUMNS PC11, ' +
            '  OUTER INFORMIX.SYSCOLUMNS FC12, OUTER INFORMIX.SYSCOLUMNS PC12, ' +
            '  OUTER INFORMIX.SYSCOLUMNS FC13, OUTER INFORMIX.SYSCOLUMNS PC13, ' +
            '  OUTER INFORMIX.SYSCOLUMNS FC14, OUTER INFORMIX.SYSCOLUMNS PC14, ' +
            '  OUTER INFORMIX.SYSCOLUMNS FC15, OUTER INFORMIX.SYSCOLUMNS PC15, ' +
            '  OUTER INFORMIX.SYSCOLUMNS FC16, OUTER INFORMIX.SYSCOLUMNS PC16 ' +
            'WHERE R.CONSTRID=FC.CONSTRID AND FC.TABID=FT.TABID AND FI.TABID=FC.TABID AND FI.IDXNAME=FC.IDXNAME AND R.PRIMARY=PC.CONSTRID AND PC.TABID=PI.TABID AND PC.IDXNAME=PI.IDXNAME AND PT.TABID=PI.TABID ' +
            '  AND FC1.TABID=FI.TABID AND FC1.COLNO=ABS(FI.PART1) AND PC1.TABID=PI.TABID AND PC1.COLNO=ABS(PI.PART1) ' +
            '  AND FC2.TABID=FI.TABID AND FC2.COLNO=ABS(FI.PART2) AND PC2.TABID=PI.TABID AND PC2.COLNO=ABS(PI.PART2) ' +
            '  AND FC3.TABID=FI.TABID AND FC3.COLNO=ABS(FI.PART3) AND PC3.TABID=PI.TABID AND PC3.COLNO=ABS(PI.PART3) ' +
            '  AND FC4.TABID=FI.TABID AND FC4.COLNO=ABS(FI.PART4) AND PC4.TABID=PI.TABID AND PC4.COLNO=ABS(PI.PART4) ' +
            '  AND FC5.TABID=FI.TABID AND FC5.COLNO=ABS(FI.PART5) AND PC5.TABID=PI.TABID AND PC5.COLNO=ABS(PI.PART5) ' +
            '  AND FC6.TABID=FI.TABID AND FC6.COLNO=ABS(FI.PART6) AND PC6.TABID=PI.TABID AND PC6.COLNO=ABS(PI.PART6) ' +
            '  AND FC7.TABID=FI.TABID AND FC7.COLNO=ABS(FI.PART7) AND PC7.TABID=PI.TABID AND PC7.COLNO=ABS(PI.PART7) ' +
            '  AND FC8.TABID=FI.TABID AND FC8.COLNO=ABS(FI.PART8) AND PC8.TABID=PI.TABID AND PC8.COLNO=ABS(PI.PART8) ' +
            '  AND FC9.TABID=FI.TABID AND FC9.COLNO=ABS(FI.PART9) AND PC9.TABID=PI.TABID AND PC9.COLNO=ABS(PI.PART9) ' +
            '  AND FC10.TABID=FI.TABID AND FC10.COLNO=ABS(FI.PART10) AND PC10.TABID=PI.TABID AND PC10.COLNO=ABS(PI.PART10) ' +
            '  AND FC11.TABID=FI.TABID AND FC11.COLNO=ABS(FI.PART11) AND PC11.TABID=PI.TABID AND PC11.COLNO=ABS(PI.PART11) ' +
            '  AND FC12.TABID=FI.TABID AND FC12.COLNO=ABS(FI.PART12) AND PC12.TABID=PI.TABID AND PC12.COLNO=ABS(PI.PART12) ' +
            '  AND FC13.TABID=FI.TABID AND FC13.COLNO=ABS(FI.PART13) AND PC13.TABID=PI.TABID AND PC13.COLNO=ABS(PI.PART13) ' +
            '  AND FC14.TABID=FI.TABID AND FC14.COLNO=ABS(FI.PART14) AND PC14.TABID=PI.TABID AND PC14.COLNO=ABS(PI.PART14) ' +
            '  AND FC15.TABID=FI.TABID AND FC15.COLNO=ABS(FI.PART15) AND PC15.TABID=PI.TABID AND PC15.COLNO=ABS(PI.PART15) ' +
            '  AND FC16.TABID=FI.TABID AND FC16.COLNO=ABS(FI.PART16) AND PC16.TABID=PI.TABID AND PC16.COLNO=ABS(PI.PART16) ' +
            '  AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (FT.OWNER = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (FT.TABNAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (FC.CONSTRNAME = :FOREIGN_KEY_NAME OR (:FOREIGN_KEY_NAME IS NULL)) ' +
            '  AND (1<2 OR (:PRIMARY_CATALOG_NAME IS NULL)) AND (PT.OWNER = :PRIMARY_SCHEMA_NAME OR (:PRIMARY_SCHEMA_NAME IS NULL)) AND (PT.TABNAME = :PRIMARY_TABLE_NAME OR (:PRIMARY_TABLE_NAME IS NULL)) AND (PC.CONSTRNAME = :PRIMARY_KEY_NAME OR (:PRIMARY_KEY_NAME IS ' + 'NULL)) ' +
            'ORDER BY 2, 3, 4';
end;

function TDBXInformixMetaDataReader.GetSqlForSynonyms: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), SN.OWNER, SN.TABNAME, CAST(NULL AS VARCHAR(1)), T.OWNER, T.TABNAME ' +
            'FROM INFORMIX.SYSSYNTABLE S, INFORMIX.SYSTABLES SN, INFORMIX.SYSTABLES T ' +
            'WHERE S.TABID=SN.TABID AND S.BTABID=T.TABID ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (SN.OWNER = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (SN.TABNAME = :SYNONYM_NAME OR (:SYNONYM_NAME IS NULL)) ' +
            'ORDER BY 2, 3';
end;

function TDBXInformixMetaDataReader.GetSqlForProcedures: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), OWNER, PROCNAME, CASE WHEN ISPROC=''t'' THEN ''PROCEDURE'' ELSE ''FUNCTION'' END ' +
            'FROM INFORMIX.SYSPROCEDURES ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (OWNER = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (PROCNAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) AND ((CASE WHEN ISPROC=''t'' THEN ''PROCEDURE'' ELSE ''FUNCTION'' END) = :PROCEDURE_TYPE OR (:PROCEDURE_TYP' + 'E IS NULL)) ' +
            'ORDER BY 2, 3';
end;

function TDBXInformixMetaDataReader.GetSqlForProcedureSources: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), P.OWNER, P.PROCNAME, CASE WHEN P.ISPROC=''t'' THEN ''PROCEDURE'' ELSE ''FUNCTION'' END, B.DATA, CAST(NULL AS VARCHAR(1)), B.SEQNO AS SOURCE_LINE_NUMBER, B.PROCID ' +
            'FROM INFORMIX.SYSPROCEDURES P, INFORMIX.SYSPROCBODY B ' +
            'WHERE P.PROCID=B.PROCID AND B.DATAKEY=''T'' ' +
            ' AND (1<2 OR (1<2 OR (:CATALOG_NAME IS NULL))) AND (OWNER = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (PROCNAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) ' +
            'ORDER BY 2, 3, 8, 7';
end;

function TDBXInformixMetaDataReader.FetchPackages(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackagesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Packages, Columns);
end;

function TDBXInformixMetaDataReader.FetchPackageProcedures(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ProcedureType: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProceduresColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageProcedures, Columns);
end;

function TDBXInformixMetaDataReader.FetchPackageProcedureParameters(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ParameterName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProcedureParametersColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageProcedureParameters, Columns);
end;

function TDBXInformixMetaDataReader.FetchPackageSources(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageSourcesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageSources, Columns);
end;

function TDBXInformixMetaDataReader.GetSqlForUsers: string;
begin
  Result := 'SELECT USERNAME FROM INFORMIX.SYSUSERS WHERE USERTYPE <> ''G'' ORDER BY 1';
end;

function TDBXInformixMetaDataReader.GetSqlForRoles: string;
begin
  Result := 'SELECT USERNAME FROM INFORMIX.SYSUSERS WHERE USERTYPE = ''G'' ORDER BY 1';
end;

function TDBXInformixMetaDataReader.GetReservedWords: TDBXStringArray;
var
  Words: TDBXStringArray;
begin
  SetLength(Words,506);
  Words[0] := 'ABSOLUTE';
  Words[1] := 'ACCESS';
  Words[2] := 'ACCESS_METHOD';
  Words[3] := 'ACTIVE';
  Words[4] := 'ADD';
  Words[5] := 'AFTER';
  Words[6] := 'AGGREGATE';
  Words[7] := 'ALIGNMENT';
  Words[8] := 'ALL';
  Words[9] := 'ALL_ROWS';
  Words[10] := 'ALLOCATE';
  Words[11] := 'ALTER';
  Words[12] := 'AND';
  Words[13] := 'ANSI';
  Words[14] := 'ANY';
  Words[15] := 'APPEND';
  Words[16] := 'AS';
  Words[17] := 'ASC';
  Words[18] := 'AT';
  Words[19] := 'ATTACH';
  Words[20] := 'AUDIT';
  Words[21] := 'AUTHORIZATION';
  Words[22] := 'AUTO';
  Words[23] := 'AUTOFREE';
  Words[24] := 'AVG';
  Words[25] := 'AVOID_EXECUTE';
  Words[26] := 'AVOID_SUBQF';
  Words[27] := 'BEFORE';
  Words[28] := 'BEGIN';
  Words[29] := 'BETWEEN';
  Words[30] := 'BINARY';
  Words[31] := 'BOOLEAN';
  Words[32] := 'BOTH';
  Words[33] := 'BUFFERED';
  Words[34] := 'BUILTIN';
  Words[35] := 'BY';
  Words[36] := 'BYTE';
  Words[37] := 'CACHE';
  Words[38] := 'CALL';
  Words[39] := 'CANNOTHASH';
  Words[40] := 'CARDINALITY';
  Words[41] := 'CASCADE';
  Words[42] := 'CASE';
  Words[43] := 'CAST';
  Words[44] := 'CHAR';
  Words[45] := 'CHAR_LENGTH';
  Words[46] := 'CHARACTER';
  Words[47] := 'CHARACTER_LENGTH';
  Words[48] := 'CHECK';
  Words[49] := 'CLASS';
  Words[50] := 'CLIENT';
  Words[51] := 'CLOSE';
  Words[52] := 'CLUSTER';
  Words[53] := 'CLUSTERSIZE';
  Words[54] := 'COARSE';
  Words[55] := 'COBOL';
  Words[56] := 'CODESET';
  Words[57] := 'COLLATION';
  Words[58] := 'COLLECTION';
  Words[59] := 'COLUMN';
  Words[60] := 'COMMIT';
  Words[61] := 'COMMITTED';
  Words[62] := 'COMMUTATOR';
  Words[63] := 'CONCURRENT';
  Words[64] := 'CONNECT';
  Words[65] := 'CONNECTION';
  Words[66] := 'CONST';
  Words[67] := 'CONSTRAINT';
  Words[68] := 'CONSTRAINTS';
  Words[69] := 'CONSTRUCTOR';
  Words[70] := 'CONTINUE';
  Words[71] := 'COPY';
  Words[72] := 'COSTFUNC';
  Words[73] := 'COUNT';
  Words[74] := 'CRCOLS';
  Words[75] := 'CREATE';
  Words[76] := 'CROSS';
  Words[77] := 'CURRENT';
  Words[78] := 'CURRENT_ROLE';
  Words[79] := 'CURSOR';
  Words[80] := 'CYCLE';
  Words[81] := 'DATABASE';
  Words[82] := 'DATAFILES';
  Words[83] := 'DATASKIP';
  Words[84] := 'DATE';
  Words[85] := 'DATETIME';
  Words[86] := 'DAY';
  Words[87] := 'DBA';
  Words[88] := 'DBDATE';
  Words[89] := 'DBPASSWORD';
  Words[90] := 'DBSERVERNAME';
  Words[91] := 'DEALLOCATE';
  Words[92] := 'DEBUG';
  Words[93] := 'DEC';
  Words[94] := 'DEC_T';
  Words[95] := 'DECIMAL';
  Words[96] := 'DECLARE';
  Words[97] := 'DECODE';
  Words[98] := 'DEFAULT';
  Words[99] := 'DEFAULT_ROLE';
  Words[100] := 'DEFERRED';
  Words[101] := 'DEFERRED_PREPARE';
  Words[102] := 'DEFINE';
  Words[103] := 'DELAY';
  Words[104] := 'DELETE';
  Words[105] := 'DELIMITER';
  Words[106] := 'DELUXE';
  Words[107] := 'DEREF';
  Words[108] := 'DESC';
  Words[109] := 'DESCRIBE';
  Words[110] := 'DESCRIPTOR';
  Words[111] := 'DETACH';
  Words[112] := 'DIAGNOSTICS';
  Words[113] := 'DIRECTIVES';
  Words[114] := 'DIRTY';
  Words[115] := 'DISABLED';
  Words[116] := 'DISCONNECT';
  Words[117] := 'DISTINCT';
  Words[118] := 'DISTRIBUTEBINARY';
  Words[119] := 'DISTRIBUTESREFERENCES';
  Words[120] := 'DISTRIBUTIONS';
  Words[121] := 'DOCUMENT';
  Words[122] := 'DOMAIN';
  Words[123] := 'DONOTDISTRIBUTE';
  Words[124] := 'DORMANT';
  Words[125] := 'DOUBLE';
  Words[126] := 'DROP';
  Words[127] := 'DTIME_T';
  Words[128] := 'EACH';
  Words[129] := 'ELIF';
  Words[130] := 'ELSE';
  Words[131] := 'ENABLED';
  Words[132] := 'ENCRYPTION';
  Words[133] := 'END';
  Words[134] := 'ENUM';
  Words[135] := 'ENVIRONMENT';
  Words[136] := 'ERROR';
  Words[137] := 'ESCAPE';
  Words[138] := 'EXCEPTION';
  Words[139] := 'EXCLUSIVE';
  Words[140] := 'EXEC';
  Words[141] := 'EXECUTE';
  Words[142] := 'EXECUTEANYWHERE';
  Words[143] := 'EXISTS';
  Words[144] := 'EXIT';
  Words[145] := 'EXPLAIN';
  Words[146] := 'EXPLICIT';
  Words[147] := 'EXPRESS';
  Words[148] := 'EXPRESSION';
  Words[149] := 'EXTEND';
  Words[150] := 'EXTENT';
  Words[151] := 'EXTERNAL';
  Words[152] := 'FALSE';
  Words[153] := 'FAR';
  Words[154] := 'FETCH';
  Words[155] := 'FILE';
  Words[156] := 'FILLFACTOR';
  Words[157] := 'FILTERING';
  Words[158] := 'FIRST';
  Words[159] := 'FIRST_ROWS';
  Words[160] := 'FIXCHAR';
  Words[161] := 'FIXED';
  Words[162] := 'FLOAT';
  Words[163] := 'FLUSH';
  Words[164] := 'FOR';
  Words[165] := 'FOREACH';
  Words[166] := 'FOREIGN';
  Words[167] := 'FORMAT';
  Words[168] := 'FORTRAN';
  Words[169] := 'FOUND';
  Words[170] := 'FRACTION';
  Words[171] := 'FRAGMENT';
  Words[172] := 'FREE';
  Words[173] := 'FROM';
  Words[174] := 'FULL';
  Words[175] := 'FUNCTION';
  Words[176] := 'GENERAL';
  Words[177] := 'GET';
  Words[178] := 'GK';
  Words[179] := 'GLOBAL';
  Words[180] := 'GO';
  Words[181] := 'GOTO';
  Words[182] := 'GRANT';
  Words[183] := 'GROUP';
  Words[184] := 'HANDLESNULLS';
  Words[185] := 'HASH';
  Words[186] := 'HAVING';
  Words[187] := 'HIGH';
  Words[188] := 'HINT';
  Words[189] := 'HOLD';
  Words[190] := 'HOUR';
  Words[191] := 'HYBRID';
  Words[192] := 'IF';
  Words[193] := 'IFX_INT8_T';
  Words[194] := 'IFX_LO_CREATE_SPEC_T';
  Words[195] := 'IFX_LO_STAT_T';
  Words[196] := 'IMMEDIATE';
  Words[197] := 'IMPLICIT';
  Words[198] := 'IN';
  Words[199] := 'INACTIVE';
  Words[200] := 'INCREMENT';
  Words[201] := 'INDEX';
  Words[202] := 'INDEXES';
  Words[203] := 'INDICATOR';
  Words[204] := 'INIT';
  Words[205] := 'INITCAP';
  Words[206] := 'INLINE';
  Words[207] := 'INNER';
  Words[208] := 'INOUT';
  Words[209] := 'INSERT';
  Words[210] := 'INSTEAD';
  Words[211] := 'INT';
  Words[212] := 'INT8';
  Words[213] := 'INTEG';
  Words[214] := 'INTEGER';
  Words[215] := 'INTERNAL';
  Words[216] := 'INTERNALLENGTH';
  Words[217] := 'INTERVAL';
  Words[218] := 'INTO';
  Words[219] := 'INTRVL_T';
  Words[220] := 'IS';
  Words[221] := 'ISCANONICAL';
  Words[222] := 'ISOLATION';
  Words[223] := 'ITEM';
  Words[224] := 'ITERATOR';
  Words[225] := 'JOIN';
  Words[226] := 'KEEP';
  Words[227] := 'KEY';
  Words[228] := 'LABELEQ';
  Words[229] := 'LABELGE';
  Words[230] := 'LABELGLB';
  Words[231] := 'LABELGT';
  Words[232] := 'LABELLE';
  Words[233] := 'LABELLT';
  Words[234] := 'LABELLUB';
  Words[235] := 'LABELTOSTRING';
  Words[236] := 'LANGUAGE';
  Words[237] := 'LAST';
  Words[238] := 'LEADING';
  Words[239] := 'LEFT';
  Words[240] := 'LET';
  Words[241] := 'LEVEL';
  Words[242] := 'LIKE';
  Words[243] := 'LIMIT';
  Words[244] := 'LIST';
  Words[245] := 'LISTING';
  Words[246] := 'LOAD';
  Words[247] := 'LOC_T';
  Words[248] := 'LOCAL';
  Words[249] := 'LOCATOR';
  Words[250] := 'LOCK';
  Words[251] := 'LOCKS';
  Words[252] := 'LOG';
  Words[253] := 'LONG';
  Words[254] := 'LOW';
  Words[255] := 'LOWER';
  Words[256] := 'LVARCHAR';
  Words[257] := 'MATCHES';
  Words[258] := 'MAX';
  Words[259] := 'MAXERRORS';
  Words[260] := 'MAXLEN';
  Words[261] := 'MAXVALUE';
  Words[262] := 'MDY';
  Words[263] := 'MEDIAN';
  Words[264] := 'MEDIUM';
  Words[265] := 'MEMORY_RESIDENT';
  Words[266] := 'MIDDLE';
  Words[267] := 'MIN';
  Words[268] := 'MINUTE';
  Words[269] := 'MINVALUE';
  Words[270] := 'MODE';
  Words[271] := 'MODERATE';
  Words[272] := 'MODIFY';
  Words[273] := 'MODULE';
  Words[274] := 'MONEY';
  Words[275] := 'MONTH';
  Words[276] := 'MOUNTING';
  Words[277] := 'MULTISET';
  Words[278] := 'NAME';
  Words[279] := 'NCHAR';
  Words[280] := 'NEGATOR';
  Words[281] := 'NEW';
  Words[282] := 'NEXT';
  Words[283] := 'NO';
  Words[284] := 'NOCACHE';
  Words[285] := 'NOCYCLE';
  Words[286] := 'NOMAXVALUE';
  Words[287] := 'NOMIGRATE';
  Words[288] := 'NOMINVALUE';
  Words[289] := 'NON_RESIDENT';
  Words[290] := 'NONE';
  Words[291] := 'NOORDERNORMAL';
  Words[292] := 'NOT';
  Words[293] := 'NOTEMPLATEARG';
  Words[294] := 'NULL';
  Words[295] := 'NUMERIC';
  Words[296] := 'NVARCHAR';
  Words[297] := 'NVL';
  Words[298] := 'OCTET_LENGTH';
  Words[299] := 'OF';
  Words[300] := 'OFF';
  Words[301] := 'OLD';
  Words[302] := 'ON';
  Words[303] := 'ONLINE';
  Words[304] := 'ONLY';
  Words[305] := 'OPAQUE';
  Words[306] := 'OPCLASS';
  Words[307] := 'OPEN';
  Words[308] := 'OPERATIONAL';
  Words[309] := 'OPTCOMPIND';
  Words[310] := 'OPTICAL';
  Words[311] := 'OPTIMIZATION';
  Words[312] := 'OPTION';
  Words[313] := 'OR';
  Words[314] := 'ORDER';
  Words[315] := 'OUT';
  Words[316] := 'OUTER';
  Words[317] := 'OUTPUT';
  Words[318] := 'PAGE';
  Words[319] := 'PARALLELIZABLE';
  Words[320] := 'PARAMETER';
  Words[321] := 'PARTITION';
  Words[322] := 'PASCAL';
  Words[323] := 'PASSEDBYVALUE';
  Words[324] := 'PASSWORD';
  Words[325] := 'PDQPRIORITY';
  Words[326] := 'PERCALL_COST';
  Words[327] := 'PLI';
  Words[328] := 'PLOAD';
  Words[329] := 'PRECISION';
  Words[330] := 'PREPARE';
  Words[331] := 'PREVIOUS';
  Words[332] := 'PRIMARY';
  Words[333] := 'PRIOR';
  Words[334] := 'PRIVATE';
  Words[335] := 'PRIVILEGES';
  Words[336] := 'PROCEDURE';
  Words[337] := 'PUBLIC';
  Words[338] := 'PUT';
  Words[339] := 'RAISE';
  Words[340] := 'RANGE';
  Words[341] := 'RAW';
  Words[342] := 'READ';
  Words[343] := 'REAL';
  Words[344] := 'RECORDEND';
  Words[345] := 'REF';
  Words[346] := 'REFERENCES';
  Words[347] := 'REFERENCING';
  Words[348] := 'REGISTER';
  Words[349] := 'REJECTFILE';
  Words[350] := 'RELATIVE';
  Words[351] := 'RELEASE';
  Words[352] := 'REMAINDER';
  Words[353] := 'RENAME';
  Words[354] := 'REOPTIMIZATION';
  Words[355] := 'REPEATABLE';
  Words[356] := 'REPLICATION';
  Words[357] := 'RESERVE';
  Words[358] := 'RESOLUTION';
  Words[359] := 'RESOURCE';
  Words[360] := 'RESTART';
  Words[361] := 'RESTRICT';
  Words[362] := 'RESUME';
  Words[363] := 'RETAIN';
  Words[364] := 'RETURN';
  Words[365] := 'RETURNING';
  Words[366] := 'RETURNS';
  Words[367] := 'REUSE';
  Words[368] := 'REVOKE';
  Words[369] := 'RIGHT';
  Words[370] := 'ROBIN';
  Words[371] := 'ROLE';
  Words[372] := 'ROLLBACK';
  Words[373] := 'ROLLFORWARD';
  Words[374] := 'ROUND';
  Words[375] := 'ROUTINE';
  Words[376] := 'ROW';
  Words[377] := 'ROWID';
  Words[378] := 'ROWIDS';
  Words[379] := 'ROWS';
  Words[380] := 'SAMEAS';
  Words[381] := 'SAMPLES';
  Words[382] := 'SAVE';
  Words[383] := 'SCHEDULE';
  Words[384] := 'SCHEMA';
  Words[385] := 'SCRATCH';
  Words[386] := 'SCROLL';
  Words[387] := 'SECOND';
  Words[388] := 'SECONDARY';
  Words[389] := 'SECTION';
  Words[390] := 'SELCONST';
  Words[391] := 'SELECT';
  Words[392] := 'SELFUNC';
  Words[393] := 'SEQUENCE';
  Words[394] := 'SERIAL';
  Words[395] := 'SERIAL8';
  Words[396] := 'SERIALIZABLE';
  Words[397] := 'SERVERUUID';
  Words[398] := 'SESSION';
  Words[399] := 'SET';
  Words[400] := 'SHARE';
  Words[401] := 'SHORT';
  Words[402] := 'SIGNED';
  Words[403] := 'SITENAME';
  Words[404] := 'SIZE';
  Words[405] := 'SKALL';
  Words[406] := 'SKINHIBIT';
  Words[407] := 'SKIP';
  Words[408] := 'SKSHOW';
  Words[409] := 'SMALLFLOAT';
  Words[410] := 'SMALLINT';
  Words[411] := 'SOME';
  Words[412] := 'SPECIFIC';
  Words[413] := 'SQL';
  Words[414] := 'SQLCODE';
  Words[415] := 'SQLCONTEXT';
  Words[416] := 'SQLERROR';
  Words[417] := 'SQLSTATE';
  Words[418] := 'SQLWARNING';
  Words[419] := 'STABILITY';
  Words[420] := 'STACK';
  Words[421] := 'STANDARD';
  Words[422] := 'START';
  Words[423] := 'STATIC';
  Words[424] := 'STATISTICS';
  Words[425] := 'STDEV';
  Words[426] := 'STEP';
  Words[427] := 'STOP';
  Words[428] := 'STORAGE';
  Words[429] := 'STRATEGIES';
  Words[430] := 'STRING';
  Words[431] := 'STRINGTOLABEL';
  Words[432] := 'STRUCT';
  Words[433] := 'STYLE';
  Words[434] := 'SUBSTR';
  Words[435] := 'SUBSTRING';
  Words[436] := 'SUM';
  Words[437] := 'SUPPORT';
  Words[438] := 'SYNC';
  Words[439] := 'SYNONYM';
  Words[440] := 'SYSTEM';
  Words[441] := 'TABLE';
  Words[442] := 'TEMP';
  Words[443] := 'TEMPLATE';
  Words[444] := 'TEST';
  Words[445] := 'TEXT';
  Words[446] := 'THEN';
  Words[447] := 'TIME';
  Words[448] := 'TIMEOUT';
  Words[449] := 'TO';
  Words[450] := 'TODAY';
  Words[451] := 'TRACE';
  Words[452] := 'TRAILING';
  Words[453] := 'TRANSACTION';
  Words[454] := 'TRIGGER';
  Words[455] := 'TRIGGERS';
  Words[456] := 'TRIM';
  Words[457] := 'TRUE';
  Words[458] := 'TRUNCATE';
  Words[459] := 'TYPE';
  Words[460] := 'TYPEDEF';
  Words[461] := 'TYPEID';
  Words[462] := 'TYPENAME';
  Words[463] := 'TYPEOF';
  Words[464] := 'UNCOMMITTED';
  Words[465] := 'UNDER';
  Words[466] := 'UNION';
  Words[467] := 'UNIQUE';
  Words[468] := 'UNITS';
  Words[469] := 'UNKNOWN';
  Words[470] := 'UNLOAD';
  Words[471] := 'UNLOCK';
  Words[472] := 'UNSIGNED';
  Words[473] := 'UPDATE';
  Words[474] := 'UPPER';
  Words[475] := 'USAGE';
  Words[476] := 'USE_SUBQF';
  Words[477] := 'USER';
  Words[478] := 'USING';
  Words[479] := 'VALUE';
  Words[480] := 'VALUES';
  Words[481] := 'VAR';
  Words[482] := 'VARCHAR';
  Words[483] := 'VARIABLE';
  Words[484] := 'VARIANCE';
  Words[485] := 'VARIANT';
  Words[486] := 'VARYING';
  Words[487] := 'VIEW';
  Words[488] := 'VIOLATIONS';
  Words[489] := 'VOID';
  Words[490] := 'VOLATILE';
  Words[491] := 'WAIT';
  Words[492] := 'WARNING';
  Words[493] := 'WHEN';
  Words[494] := 'WHENEVER';
  Words[495] := 'WHERE';
  Words[496] := 'WHILE';
  Words[497] := 'WITH';
  Words[498] := 'WITHOUT';
  Words[499] := 'WORK';
  Words[500] := 'WRITE';
  Words[501] := 'XADATASOURCE';
  Words[502] := 'XID';
  Words[503] := 'XLOAD';
  Words[504] := 'XUNLOAD';
  Words[505] := 'YEAR';
  Result := Words;
end;

end.

