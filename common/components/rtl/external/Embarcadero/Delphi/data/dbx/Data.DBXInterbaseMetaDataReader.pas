{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXInterbaseMetaDataReader;

interface

uses
  Data.DBXCommon,
  Data.DBXCommonTable,
  Data.DBXMetaDataNames,
  Data.DBXMetaDataReader,
  Data.DBXPlatform;

type
  
  /// <summary>  TDBXInterbaseCustomMetaDataReader contains custom code for Interbase.
  /// </summary>
  /// <remarks>  This class handles data types and type mapping for table columns and
  ///   procedure parameters.
  /// </remarks>
  TDBXInterbaseCustomMetaDataReader = class(TDBXBaseMetaDataReader)
  public
    destructor Destroy; override;
    
    /// <summary>  Overrides the implementation in BaseMetaDataProvider.
    /// </summary>
    /// <remarks>  A custom filter is added to extract the type information for each column.
    /// </remarks>
    /// <seealso cref="TDBXInterbaseTypeFilterCursor"/>
    function FetchColumns(const Catalog: string; const Schema: string; const Table: string): TDBXTable; override;

    /// <summary>  Overrides the implementation in TDBXBaseMetaDataReader.
    /// </summary>
    /// <remarks>  A custom filter is added to extract the type information for each column.
    /// </remarks>
    /// <seealso cref="TDBXInterbaseTypeFilterCursor"/>
    function FetchProcedureParameters(const Catalog: string; const Schema: string; const Proc: string; const Parameter: string): TDBXTable; override;
  protected
    procedure SetContext(const Context: TDBXProviderContext); override;
    function IsDefaultCharSetUnicode: Boolean; virtual;
    function GetSqlIdentifierQuotePrefix: string; override;
    function GetSqlIdentifierQuoteSuffix: string; override;
    function GetSqlIdentifierQuoteChar: string; override;
    function GetDataTypeDescriptions: TDBXDataTypeDescriptionArray; override;
    function GetAllDataTypes: TDBXDataTypeDescriptionArray; virtual;
  public
    FDefaultCharSetIsUnicode: Boolean;
  private
    FAlltypes: TDBXDataTypeDescriptionArray;
    FQuoteChar: string;
  public
    property DefaultCharSetUnicode: Boolean read IsDefaultCharSetUnicode;
    property AllDataTypes: TDBXDataTypeDescriptionArray read GetAllDataTypes;
  public
    const CharType = 0;
    const VarcharType = 1;
    const IntegerType = 2;
    const SmallintType = 3;
    const FloatType = 4;
    const DoubleType = 5;
    const NumericType = 6;
    const DecimalType = 7;
    const DateType = 8;
    const TimeType = 9;
    const TimestampType = 10;
    const BlobType = 11;
    const BooleanType = 12;
    const DefaultCharset = 0;
    const CharsetUnicodeFss = 3;
    const CharsetSjis208 = 5;
    const CharsetEucj208 = 6;
  private
    const TypesCount = 13;
    const DefaultStringStart = 'DEFAULT ';
    const DefaultCharsetIsUnicode = 'UnicodeEncoding';
    const QuoteCharacterEnabled = 'QuoteCharEnabled';
    const ColumnsFieldType = TDBXColumnsIndex.TypeName;
    const ColumnsSubtype = TDBXColumnsIndex.DbxDataType;
    const ParametersFieldType = TDBXProcedureParametersIndex.TypeName;
    const ParametersSubtype = TDBXProcedureParametersIndex.DbxDataType;
  end;

  TDBXInterbaseMetaDataReader = class(TDBXInterbaseCustomMetaDataReader)
  public
    function FetchCatalogs: TDBXTable; override;
    function FetchSchemas(const CatalogName: string): TDBXTable; override;
    function FetchColumnConstraints(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable; override;
    function FetchSynonyms(const CatalogName: string; const SchemaName: string; const SynonymName: string): TDBXTable; override;
    function FetchPackages(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable; override;
    function FetchPackageProcedures(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ProcedureType: string): TDBXTable; override;
    function FetchPackageProcedureParameters(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ParameterName: string): TDBXTable; override;
    function FetchPackageSources(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable; override;
  protected
    function GetProductName: string; override;
    function IsDescendingIndexSupported: Boolean; override;
    function IsDescendingIndexColumnsSupported: Boolean; override;
    function IsNestedTransactionsSupported: Boolean; override;
    function IsParameterMetadataSupported: Boolean; override;
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
    function GetSqlForRoles: string; override;
    function GetReservedWords: TDBXStringArray; override;
  end;

  
  /// <summary>  TDBXInterbaseTypeFilterCursor is a filter for a cursor providing table columns and procedure parameters.
  /// </summary>
  /// <remarks>  In Interbase the typename and scale are all encoded in the system tables.
  ///   This filter also normalizes the default value.
  /// </remarks>
  TDBXInterbaseTypeFilterCursor = class(TDBXCustomMetaDataTable)
  public
    type
      Tibase_const = class
      public
        const FBlr_text = 14;
        const FBlr_text2 = 15;
        const FBlr_short = 7;
        const FBlr_long = 8;
        const FBlr_quad = 9;
        const FBlr_int64 = 16;
        const FBlr_float = 10;
        const FBlr_double = 27;
        const FBlr_d_float = 11;
        const FBlr_timestamp = 35;
        const FBlr_varying = 37;
        const FBlr_varying2 = 38;
        const FBlr_blob = 261;
        const FBlr_cstring = 40;
        const FBlr_cstring2 = 41;
        const FBlr_blob_id = 45;
        const FBlr_sql_date = 12;
        const FBlr_sql_time = 13;
        const FBlr_boolean_dtype = 17;
      end;

  public
    destructor Destroy; override;
    function Next: Boolean; override;
  protected
    /// <summary> Constructor for TDBXInterbaseTypeFilterCursor.
    /// </summary>
    /// <param name="provider">MetadataReader</param>
    /// <param name="MetadataCollectionName">Name of the collection</param>
    /// <param name="columns">ValueType[] The columns this cursor must generate.</param>
    /// <param name="cursor">DBXTable A cursor with the data from the database.</param>
    /// <param name="ordinalTypeName">int The ordinal where the computed typename should go.</param>
    /// <param name="ordinalFieldType">int The ordinal where the field type is found from the input cursor.</param>
    /// <param name="ordinalSubType">int The ordinal where the subtype is found from the input cursor.</param>
    /// <param name="ordinalScale">int The ordinal where the scale is found and corrected.</param>
    /// <param name="ordinalDefaultValue">int The ordinal where the default value is found and corrected. This value may be -1 which means do not correct default values.</param>
    constructor Create(const Provider: TDBXInterbaseCustomMetaDataReader; const MetadataCollectionName: string; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable; const OrdinalTypeName: Integer; const OrdinalFieldType: Integer; const OrdinalSubType: Integer; const OrdinalScale: Integer; const OrdinalDefaultValue: Integer);
    function FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer; override;
    function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
  private
    procedure ComputeDataType;
    function ComputeTypeName: string;
    function ComputeUnicode: Boolean;
    function ComputeDefaultValue: string;
    function GetIBType(const FieldType: SmallInt; const FieldSubType: SmallInt; const FieldScale: SmallInt): Integer;
  private
    [Weak]FCustomProvider: TDBXInterbaseCustomMetaDataReader;
    FOrdinalTypeName: Integer;
    FOrdinalFieldType: Integer;
    FOrdinalSubType: Integer;
    FOrdinalCharSet: Integer;
    FOrdinalScale: Integer;
    FOrdinalDefaultValue: Integer;
    [Weak]FDataType: TDBXDataTypeDescription;
    FRow: TDBXSingleValueRow;
  private
    const DefaultStringStart = 'DEFAULT ';
  end;

implementation

uses
  System.SysUtils;

destructor TDBXInterbaseCustomMetaDataReader.Destroy;
begin
  FreeObjectArray(TDBXFreeArray(FAlltypes));
  inherited Destroy;
end;

procedure TDBXInterbaseCustomMetaDataReader.SetContext(const Context: TDBXProviderContext);
begin
  inherited SetContext(Context);
  FDefaultCharSetIsUnicode := (Context.GetVendorProperty(DefaultCharsetIsUnicode) = 'true');
  FQuoteChar := C_Conditional((Context.GetVendorProperty(QuoteCharacterEnabled) = 'true'), '"', '');
end;

function TDBXInterbaseCustomMetaDataReader.IsDefaultCharSetUnicode: Boolean;
begin
  Result := FDefaultCharSetIsUnicode;
end;

function TDBXInterbaseCustomMetaDataReader.GetSqlIdentifierQuotePrefix: string;
begin
  Result := FQuoteChar;
end;

function TDBXInterbaseCustomMetaDataReader.GetSqlIdentifierQuoteSuffix: string;
begin
  Result := FQuoteChar;
end;

function TDBXInterbaseCustomMetaDataReader.GetSqlIdentifierQuoteChar: string;
begin
  Result := FQuoteChar;
end;

function TDBXInterbaseCustomMetaDataReader.GetDataTypeDescriptions: TDBXDataTypeDescriptionArray;
var
  DataTypes: TDBXDataTypeDescriptionArray;
  Index: Integer;
begin
  AllDataTypes;
  SetLength(DataTypes,Length(FAlltypes));
  for Index := 0 to Length(DataTypes) - 1 do
    DataTypes[Index] := TDBXDataTypeDescription.Create(FAlltypes[Index]);
  Result := DataTypes;
end;

function TDBXInterbaseCustomMetaDataReader.GetAllDataTypes: TDBXDataTypeDescriptionArray;
var
  Newtypes: TDBXDataTypeDescriptionArray;
  StringType: Integer;
begin
  if FAlltypes = nil then
  begin
    SetLength(Newtypes,TypesCount);
    StringType := TDBXDataTypes.AnsiStringType;
    if FDefaultCharSetIsUnicode then
      StringType := TDBXDataTypes.WideStringType;
    Newtypes[CharType] := TDBXDataTypeDescription.Create('CHAR', StringType, 32768, 'CHAR({0})', 'Precision', -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.Unsigned or TDBXTypeFlag.UnicodeOption);
    Newtypes[VarcharType] := TDBXDataTypeDescription.Create('VARCHAR', StringType, 32678, 'VARCHAR({0})', 'Precision', -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.Unsigned or TDBXTypeFlag.UnicodeOption);
    Newtypes[IntegerType] := TDBXDataTypeDescription.Create('INTEGER', TDBXDataTypes.Int32Type, 10, 'INTEGER', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
    Newtypes[SmallintType] := TDBXDataTypeDescription.Create('SMALLINT', TDBXDataTypes.Int16Type, 5, 'SMALLINT', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
    Newtypes[FloatType] := TDBXDataTypeDescription.Create('FLOAT', TDBXDataTypes.SingleType, 53, 'FLOAT({0})', 'Precision', -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
    Newtypes[DoubleType] := TDBXDataTypeDescription.Create('DOUBLE PRECISION', TDBXDataTypes.DoubleType, 53, 'DOUBLE PRECISION', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
    Newtypes[NumericType] := TDBXDataTypeDescription.Create('NUMERIC', TDBXDataTypes.BcdType, 18, 'NUMERIC({0}, {1})', 'Precision, Scale', 18, 0, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
    Newtypes[DecimalType] := TDBXDataTypeDescription.Create('DECIMAL', TDBXDataTypes.BcdType, 18, 'DECIMAL({0}, {1})', 'Precision, Scale', 18, 0, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.Unsigned);
    Newtypes[DateType] := TDBXDataTypeDescription.Create('DATE', TDBXDataTypes.DateType, 0, 'DATE', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
    Newtypes[TimeType] := TDBXDataTypeDescription.Create('TIME', TDBXDataTypes.TimeType, 0, 'TIME', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
    Newtypes[TimestampType] := TDBXDataTypeDescription.Create('TIMESTAMP', TDBXDataTypes.TimeStampType, 0, 'TIMESTAMP', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
    Newtypes[BlobType] := TDBXDataTypeDescription.Create('BLOB', TDBXDataTypes.BlobType, 2147483647, 'BLOB', 'Precision', -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Long or TDBXTypeFlag.Nullable or TDBXTypeFlag.Unsigned or TDBXTypeFlag.StringOption or TDBXTypeFlag.UnicodeOption);
    Newtypes[BooleanType] := TDBXDataTypeDescription.Create('BOOLEAN', TDBXDataTypes.BooleanType, 1, 'BOOLEAN', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.Unsigned);
    FAlltypes := Newtypes;
  end;
  Result := FAlltypes;
end;

function TDBXInterbaseCustomMetaDataReader.FetchColumns(const Catalog: string; const Schema: string; const Table: string): TDBXTable;
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
  Result := TDBXInterbaseTypeFilterCursor.Create(self, TDBXMetaDataCollectionName.Columns, Columns, Cursor, TDBXColumnsIndex.TypeName, ColumnsFieldType, ColumnsSubtype, TDBXColumnsIndex.Scale, TDBXColumnsIndex.DefaultValue);
end;

function TDBXInterbaseCustomMetaDataReader.FetchProcedureParameters(const Catalog: string; const Schema: string; const Proc: string; const Parameter: string): TDBXTable;
var
  ParameterNames: TDBXStringArray;
  ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  SetLength(ParameterNames,4);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.ProcedureName;
  ParameterNames[3] := TDBXParameterName.ParameterName;
  SetLength(ParameterValues,4);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := Proc;
  ParameterValues[3] := Parameter;
  Cursor := Context.ExecuteQuery(SqlForProcedureParameters, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateProcedureParametersColumns;
  Result := TDBXInterbaseTypeFilterCursor.Create(self, TDBXMetaDataCollectionName.ProcedureParameters, Columns, Cursor, TDBXProcedureParametersIndex.TypeName, ParametersFieldType, ParametersSubtype, TDBXProcedureParametersIndex.Scale, -1);
end;

function TDBXInterbaseMetaDataReader.GetProductName: string;
begin
  Result := 'InterBase';
end;

function TDBXInterbaseMetaDataReader.IsDescendingIndexSupported: Boolean;
begin
  Result := True;
end;

function TDBXInterbaseMetaDataReader.IsDescendingIndexColumnsSupported: Boolean;
begin
  Result := False;
end;

function TDBXInterbaseMetaDataReader.IsNestedTransactionsSupported: Boolean;
begin
  Result := True;
end;

function TDBXInterbaseMetaDataReader.IsParameterMetadataSupported: Boolean;
begin
  Result := True;
end;

function TDBXInterbaseMetaDataReader.FetchCatalogs: TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateCatalogsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Catalogs, Columns);
end;

function TDBXInterbaseMetaDataReader.FetchSchemas(const CatalogName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateSchemasColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Schemas, Columns);
end;

function TDBXInterbaseMetaDataReader.GetSqlForTables: string;
begin
  Result := 'SELECT NULL, NULL, RDB$RELATION_NAME, CASE WHEN RDB$SYSTEM_FLAG > 0 THEN ''SYSTEM TABLE'' WHEN RDB$VIEW_SOURCE IS NOT NULL THEN ''VIEW'' ELSE ''TABLE'' END AS TABLE_TYPE ' +
            'FROM RDB$RELATIONS ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (1<2 OR (:SCHEMA_NAME IS NULL)) AND (RDB$RELATION_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            ' AND ((RDB$SYSTEM_FLAG > 0 AND :SYSTEM_TABLES=''SYSTEM TABLE'') OR (RDB$VIEW_SOURCE IS NOT NULL AND :VIEWS=''VIEW'') OR (RDB$SYSTEM_FLAG = 0 AND RDB$VIEW_SOURCE IS NULL AND :TABLES=''TABLE'')) ' +
            'ORDER BY 3';
end;

function TDBXInterbaseMetaDataReader.GetSqlForViews: string;
begin
  Result := 'SELECT NULL, NULL, RDB$RELATION_NAME, RDB$VIEW_SOURCE ' +
            'FROM RDB$RELATIONS ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (1<2 OR (:SCHEMA_NAME IS NULL)) AND (RDB$RELATION_NAME = :VIEW_NAME OR (:VIEW_NAME IS NULL)) AND (RDB$VIEW_SOURCE IS NOT NULL) ' +
            'ORDER BY 3';
end;

function TDBXInterbaseMetaDataReader.GetSqlForColumns: string;
begin
  Result := 'SELECT NULL, NULL, RF.RDB$RELATION_NAME, RF.RDB$FIELD_NAME, F.RDB$FIELD_TYPE, COALESCE(F.RDB$FIELD_PRECISION,F.RDB$CHARACTER_LENGTH,F.RDB$FIELD_LENGTH), F.RDB$FIELD_SCALE, RF.RDB$FIELD_POSITION+1, RF.RDB$DEFAULT_SOURCE, CASE WHEN RF.RDB$NULL_FLAG=1 THEN 0' + ' ELSE 1 END, 0, NULL, F.RDB$FIELD_SUB_TYPE, F.RDB$CHARACTER_SET_ID ' +
            'FROM RDB$RELATION_FIELDS RF, RDB$FIELDS F ' +
            'WHERE (RF.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME) ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (1<2 OR (:SCHEMA_NAME IS NULL)) AND (RF.RDB$RELATION_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            'ORDER BY 3, RF.RDB$FIELD_POSITION';
end;

function TDBXInterbaseMetaDataReader.FetchColumnConstraints(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateColumnConstraintsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.ColumnConstraints, Columns);
end;

function TDBXInterbaseMetaDataReader.GetSqlForIndexes: string;
begin
  Result := 'SELECT NULL, NULL, I.RDB$RELATION_NAME, CASE WHEN C.RDB$CONSTRAINT_NAME IS NULL THEN I.RDB$INDEX_NAME ELSE C.RDB$CONSTRAINT_NAME END, C.RDB$CONSTRAINT_NAME, CASE WHEN C.RDB$CONSTRAINT_TYPE=''PRIMARY KEY'' THEN 1 ELSE 0 END, COALESCE(I.RDB$UNIQUE_FLAG,0), CO' + 'ALESCE(1-I.RDB$INDEX_TYPE,1) ' +
            'FROM RDB$INDICES I LEFT OUTER JOIN RDB$RELATION_CONSTRAINTS C ON I.RDB$INDEX_NAME = C.RDB$INDEX_NAME ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (1<2 OR (:SCHEMA_NAME IS NULL)) AND (I.RDB$RELATION_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            'ORDER BY 3, 4';
end;

function TDBXInterbaseMetaDataReader.GetSqlForIndexColumns: string;
begin
  Result := 'SELECT NULL, NULL, I.RDB$RELATION_NAME, CASE WHEN C.RDB$CONSTRAINT_NAME IS NULL THEN I.RDB$INDEX_NAME ELSE C.RDB$CONSTRAINT_NAME END, S.RDB$FIELD_NAME, S.RDB$FIELD_POSITION+1, 1 ' +
            'FROM RDB$INDICES I LEFT OUTER JOIN RDB$RELATION_CONSTRAINTS C ON I.RDB$INDEX_NAME = C.RDB$INDEX_NAME, RDB$INDEX_SEGMENTS S ' +
            'WHERE I.RDB$INDEX_NAME = S.RDB$INDEX_NAME ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (1<2 OR (:SCHEMA_NAME IS NULL)) AND (I.RDB$RELATION_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (CASE WHEN C.RDB$CONSTRAINT_NAME IS NULL THEN I.RDB$INDEX_NAME ELSE C.RDB$CONSTRAINT_NAME END = :INDEX_NAME OR (' + ':INDEX_NAME IS NULL)) ' +
            'ORDER BY 3, 4, 6';
end;

function TDBXInterbaseMetaDataReader.GetSqlForForeignKeys: string;
begin
  Result := 'SELECT NULL, NULL, FK.RDB$RELATION_NAME, FK.RDB$CONSTRAINT_NAME ' +
            'FROM RDB$RELATION_CONSTRAINTS FK ' +
            'WHERE  FK.RDB$CONSTRAINT_TYPE = ''FOREIGN KEY'' ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (1<2 OR (:SCHEMA_NAME IS NULL)) AND (FK.RDB$RELATION_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            'ORDER BY 3,4';
end;

function TDBXInterbaseMetaDataReader.GetSqlForForeignKeyColumns: string;
begin
  Result := 'SELECT NULL, NULL, FK.RDB$RELATION_NAME, FK.RDB$CONSTRAINT_NAME, ISF.RDB$FIELD_NAME, NULL, NULL, PK.RDB$RELATION_NAME, PK.RDB$CONSTRAINT_NAME, ISP.RDB$FIELD_NAME, ISP.RDB$FIELD_POSITION + 1 ' +
            'FROM RDB$RELATION_CONSTRAINTS PK, RDB$RELATION_CONSTRAINTS FK, RDB$REF_CONSTRAINTS FRC, RDB$REF_CONSTRAINTS PRC, RDB$INDEX_SEGMENTS ISP, RDB$INDEX_SEGMENTS ISF ' +
            'WHERE  FK.RDB$CONSTRAINT_TYPE = ''FOREIGN KEY'' ' +
            ' AND   FK.RDB$CONSTRAINT_NAME = FRC.RDB$CONSTRAINT_NAME ' +
            ' AND   FRC.RDB$CONST_NAME_UQ = PK.RDB$CONSTRAINT_NAME ' +
            ' AND   PK.RDB$INDEX_NAME = ISP.RDB$INDEX_NAME ' +
            ' AND   ISF.RDB$INDEX_NAME = FK.RDB$INDEX_NAME ' +
            ' AND   ISP.RDB$FIELD_POSITION = ISF.RDB$FIELD_POSITION ' +
            ' AND   PRC.RDB$CONSTRAINT_NAME = FK.RDB$CONSTRAINT_NAME ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (1<2 OR (:SCHEMA_NAME IS NULL)) AND (FK.RDB$RELATION_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (FK.RDB$CONSTRAINT_NAME = :FOREIGN_KEY_NAME OR (:FOREIGN_KEY_NAME IS NULL)) ' +
            ' AND (1<2 OR (:PRIMARY_CATALOG_NAME IS NULL)) AND (1<2 OR (:PRIMARY_SCHEMA_NAME IS NULL)) AND (PK.RDB$RELATION_NAME = :PRIMARY_TABLE_NAME OR (:PRIMARY_TABLE_NAME IS NULL)) AND (PK.RDB$CONSTRAINT_NAME = :PRIMARY_KEY_NAME OR (:PRIMARY_KEY_NAME IS NULL)) ' +
            'ORDER BY 3,4,ISP.RDB$FIELD_POSITION';
end;

function TDBXInterbaseMetaDataReader.FetchSynonyms(const CatalogName: string; const SchemaName: string; const SynonymName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateSynonymsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Synonyms, Columns);
end;

function TDBXInterbaseMetaDataReader.GetSqlForProcedures: string;
begin
  Result := 'SELECT NULL, NULL, RDB$PROCEDURE_NAME, CAST(''PROCEDURE'' AS VARCHAR(10)) ' +
            'FROM RDB$PROCEDURES ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (1<2 OR (:SCHEMA_NAME IS NULL)) AND (RDB$PROCEDURE_NAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) AND (CAST(''PROCEDURE'' AS VARCHAR(10)) = :PROCEDURE_TYPE OR (:PROCEDURE_TYPE IS NULL)) ' +
            'UNION ALL ' +
            'SELECT NULL, NULL, RDB$FUNCTION_NAME, CAST(''FUNCTION'' AS VARCHAR(10)) ' +
            'FROM RDB$FUNCTIONS ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (1<2 OR (:SCHEMA_NAME IS NULL)) AND (RDB$FUNCTION_NAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) AND (CAST(''FUNCTION'' AS VARCHAR(10)) = :PROCEDURE_TYPE OR (:PROCEDURE_TYPE IS NULL)) ' +
            'ORDER BY 3';
end;

function TDBXInterbaseMetaDataReader.GetSqlForProcedureSources: string;
begin
  Result := 'SELECT NULL, NULL, RDB$PROCEDURE_NAME, ''PROCEDURE'', RDB$PROCEDURE_SOURCE, NULL ' +
            'FROM RDB$PROCEDURES ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (1<2 OR (:SCHEMA_NAME IS NULL)) AND (RDB$PROCEDURE_NAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) ' +
            'ORDER BY 3';
end;

function TDBXInterbaseMetaDataReader.GetSqlForProcedureParameters: string;
begin
  Result := 'SELECT NULL, NULL, P.RDB$PROCEDURE_NAME, P.RDB$PARAMETER_NAME, CASE ' +
              'WHEN P.RDB$PARAMETER_TYPE > 0 THEN CAST(''OUT'' AS CHAR(6)) ELSE CAST(''IN'' AS CHAR(6)) END, ' +
              'C.RDB$FIELD_TYPE, COALESCE(C.RDB$FIELD_PRECISION,C.RDB$CHARACTER_LENGTH,C.RDB$FIELD_LENGTH), ' +
              'C.RDB$FIELD_SCALE, CAST(P.RDB$PARAMETER_NUMBER+1 AS SMALLINT), CAST(COALESCE(1-C.RDB$NULL_FLAG,1) AS INTEGER), ' +
              'C.RDB$FIELD_SUB_TYPE, C.RDB$CHARACTER_SET_ID ' +
            'FROM RDB$PROCEDURE_PARAMETERS P, RDB$FIELDS C ' +
            'WHERE P.RDB$FIELD_SOURCE = C.RDB$FIELD_NAME ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (1<2 OR (:SCHEMA_NAME IS NULL)) AND (P.RDB$PROCEDURE_NAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) AND (P.RDB$PARAMETER_NAME = :PARAMETER_NAME OR (:PARAMETER_NAME IS NULL)) ' +
            'ORDER BY 5, 9';
end;

function TDBXInterbaseMetaDataReader.FetchPackages(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackagesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Packages, Columns);
end;

function TDBXInterbaseMetaDataReader.FetchPackageProcedures(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ProcedureType: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProceduresColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageProcedures, Columns);
end;

function TDBXInterbaseMetaDataReader.FetchPackageProcedureParameters(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ParameterName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProcedureParametersColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageProcedureParameters, Columns);
end;

function TDBXInterbaseMetaDataReader.FetchPackageSources(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageSourcesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageSources, Columns);
end;

function TDBXInterbaseMetaDataReader.GetSqlForUsers: string;
begin
  Result := 'SELECT RDB$USER_NAME FROM RDB$USERS ORDER BY 1';
end;

function TDBXInterbaseMetaDataReader.GetSqlForRoles: string;
begin
  Result := 'SELECT RDB$ROLE_NAME FROM RDB$ROLES ORDER BY 1';
end;

function TDBXInterbaseMetaDataReader.GetReservedWords: TDBXStringArray;
var
  Words: TDBXStringArray;
begin
  SetLength(Words,289);
  Words[0] := 'ACTION';
  Words[1] := 'ACTIVE';
  Words[2] := 'ADD';
  Words[3] := 'ADMIN';
  Words[4] := 'AFTER';
  Words[5] := 'ALL';
  Words[6] := 'ALTER';
  Words[7] := 'AND';
  Words[8] := 'ANY';
  Words[9] := 'AS';
  Words[10] := 'ASC';
  Words[11] := 'ASCENDING';
  Words[12] := 'AT';
  Words[13] := 'AUTO';
  Words[14] := 'AUTODDL';
  Words[15] := 'AVG';
  Words[16] := 'BASED';
  Words[17] := 'BASENAME';
  Words[18] := 'BASE_NAME';
  Words[19] := 'BEFORE';
  Words[20] := 'BEGIN';
  Words[21] := 'BETWEEN';
  Words[22] := 'BLOB';
  Words[23] := 'BLOBEDIT';
  Words[24] := 'BOOLEAN';
  Words[25] := 'BUFFER';
  Words[26] := 'BY';
  Words[27] := 'CACHE';
  Words[28] := 'CASCADE';
  Words[29] := 'CAST';
  Words[30] := 'CHAR';
  Words[31] := 'CHARACTER';
  Words[32] := 'CHARACTER_LENGTH';
  Words[33] := 'CHAR_LENGTH';
  Words[34] := 'CHECK';
  Words[35] := 'CHECK_POINT_LEN';
  Words[36] := 'CHECK_POINT_LENGTH';
  Words[37] := 'COLLATE';
  Words[38] := 'COLLATION';
  Words[39] := 'COLUMN';
  Words[40] := 'COMMIT';
  Words[41] := 'COMMITTED';
  Words[42] := 'COMPILETIME';
  Words[43] := 'COMPUTED';
  Words[44] := 'CLOSE';
  Words[45] := 'CONDITIONAL';
  Words[46] := 'CONNECT';
  Words[47] := 'CONSTRAINT';
  Words[48] := 'CONTAINING';
  Words[49] := 'CONTINUE';
  Words[50] := 'COUNT';
  Words[51] := 'CREATE';
  Words[52] := 'CSTRING';
  Words[53] := 'CURRENT';
  Words[54] := 'CURRENT_DATE';
  Words[55] := 'CURRENT_TIME';
  Words[56] := 'CURRENT_TIMESTAMP';
  Words[57] := 'CURSOR';
  Words[58] := 'DATABASE';
  Words[59] := 'DATE';
  Words[60] := 'DAY';
  Words[61] := 'DB_KEY';
  Words[62] := 'DEBUG';
  Words[63] := 'DEC';
  Words[64] := 'DECIMAL';
  Words[65] := 'DECLARE';
  Words[66] := 'DEFAULT';
  Words[67] := 'DELETE';
  Words[68] := 'DESC';
  Words[69] := 'DESCENDING';
  Words[70] := 'DESCRIBE';
  Words[71] := 'DESCRIPTOR';
  Words[72] := 'DISCONNECT';
  Words[73] := 'DISPLAY';
  Words[74] := 'DISTINCT';
  Words[75] := 'DO';
  Words[76] := 'DOMAIN';
  Words[77] := 'DOUBLE';
  Words[78] := 'DROP';
  Words[79] := 'ECHO';
  Words[80] := 'EDIT';
  Words[81] := 'ELSE';
  Words[82] := 'END';
  Words[83] := 'ENTRY_POINT';
  Words[84] := 'ESCAPE';
  Words[85] := 'EVENT';
  Words[86] := 'EXCEPTION';
  Words[87] := 'EXECUTE';
  Words[88] := 'EXISTS';
  Words[89] := 'EXIT';
  Words[90] := 'EXTERN';
  Words[91] := 'EXTERNAL';
  Words[92] := 'EXTRACT';
  Words[93] := 'FALSE';
  Words[94] := 'FETCH';
  Words[95] := 'FILE';
  Words[96] := 'FILTER';
  Words[97] := 'FLOAT';
  Words[98] := 'FOR';
  Words[99] := 'FOREIGN';
  Words[100] := 'FOUND';
  Words[101] := 'FREE_IT';
  Words[102] := 'FROM';
  Words[103] := 'FULL';
  Words[104] := 'FUNCTION';
  Words[105] := 'GDSCODE';
  Words[106] := 'GENERATOR';
  Words[107] := 'GEN_ID';
  Words[108] := 'GLOBAL';
  Words[109] := 'GOTO';
  Words[110] := 'GRANT';
  Words[111] := 'GROUP';
  Words[112] := 'GROUP_COMMIT_WAIT';
  Words[113] := 'GROUP_COMMIT_WAIT_TIME';
  Words[114] := 'HAVING';
  Words[115] := 'HELP';
  Words[116] := 'HOUR';
  Words[117] := 'IF';
  Words[118] := 'IMMEDIATE';
  Words[119] := 'IN';
  Words[120] := 'INACTIVE';
  Words[121] := 'INDEX';
  Words[122] := 'INDICATOR';
  Words[123] := 'INIT';
  Words[124] := 'INNER';
  Words[125] := 'INPUT';
  Words[126] := 'INPUT_TYPE';
  Words[127] := 'INSERT';
  Words[128] := 'INT';
  Words[129] := 'INTEGER';
  Words[130] := 'INTO';
  Words[131] := 'IS';
  Words[132] := 'ISOLATION';
  Words[133] := 'ISQL';
  Words[134] := 'JOIN';
  Words[135] := 'KEY';
  Words[136] := 'LC_MESSAGES';
  Words[137] := 'LC_TYPE';
  Words[138] := 'LEFT';
  Words[139] := 'LENGTH';
  Words[140] := 'LEV';
  Words[141] := 'LEVEL';
  Words[142] := 'LIKE';
  Words[143] := 'LOGFILE';
  Words[144] := 'LOG_BUFFER_SIZE';
  Words[145] := 'LOG_BUF_SIZE';
  Words[146] := 'LONG';
  Words[147] := 'MANUAL';
  Words[148] := 'MAX';
  Words[149] := 'MAXIMUM';
  Words[150] := 'MAXIMUM_SEGMENT';
  Words[151] := 'MAX_SEGMENT';
  Words[152] := 'MERGE';
  Words[153] := 'MESSAGE';
  Words[154] := 'MIN';
  Words[155] := 'MINIMUM';
  Words[156] := 'MINUTE';
  Words[157] := 'MODULE_NAME';
  Words[158] := 'MONTH';
  Words[159] := 'NAMES';
  Words[160] := 'NATIONAL';
  Words[161] := 'NATURAL';
  Words[162] := 'NCHAR';
  Words[163] := 'NO';
  Words[164] := 'NOAUTO';
  Words[165] := 'NOT';
  Words[166] := 'NULL';
  Words[167] := 'NUMERIC';
  Words[168] := 'NUM_LOG_BUFS';
  Words[169] := 'NUM_LOG_BUFFERS';
  Words[170] := 'OCTET_LENGTH';
  Words[171] := 'OF';
  Words[172] := 'ON';
  Words[173] := 'ONLY';
  Words[174] := 'OPEN';
  Words[175] := 'OPTION';
  Words[176] := 'OR';
  Words[177] := 'ORDER';
  Words[178] := 'OUTER';
  Words[179] := 'OUTPUT';
  Words[180] := 'OUTPUT_TYPE';
  Words[181] := 'OVERFLOW';
  Words[182] := 'PAGE';
  Words[183] := 'PAGELENGTH';
  Words[184] := 'PAGES';
  Words[185] := 'PAGE_SIZE';
  Words[186] := 'PARAMETER';
  Words[187] := 'PASSWORD';
  Words[188] := 'PERCENT';
  Words[189] := 'PLAN';
  Words[190] := 'POSITION';
  Words[191] := 'POST_EVENT';
  Words[192] := 'PRECISION';
  Words[193] := 'PREPARE';
  Words[194] := 'PRESERVE';
  Words[195] := 'PROCEDURE';
  Words[196] := 'PROTECTED';
  Words[197] := 'PRIMARY';
  Words[198] := 'PRIVILEGES';
  Words[199] := 'PUBLIC';
  Words[200] := 'QUIT';
  Words[201] := 'RAW_PARTITIONS';
  Words[202] := 'RDB$DB_KEY';
  Words[203] := 'READ';
  Words[204] := 'REAL';
  Words[205] := 'RECORD_VERSION';
  Words[206] := 'REFERENCES';
  Words[207] := 'RELEASE';
  Words[208] := 'RESERV';
  Words[209] := 'RESERVING';
  Words[210] := 'RESTRICT';
  Words[211] := 'RETAIN';
  Words[212] := 'RETURN';
  Words[213] := 'RETURNING_VALUES';
  Words[214] := 'RETURNS';
  Words[215] := 'REVOKE';
  Words[216] := 'RIGHT';
  Words[217] := 'ROLE';
  Words[218] := 'ROLLBACK';
  Words[219] := 'ROWS';
  Words[220] := 'RUNTIME';
  Words[221] := 'SCHEMA';
  Words[222] := 'SECOND';
  Words[223] := 'SEGMENT';
  Words[224] := 'SELECT';
  Words[225] := 'SET';
  Words[226] := 'SHADOW';
  Words[227] := 'SHARED';
  Words[228] := 'SHELL';
  Words[229] := 'SHOW';
  Words[230] := 'SINGULAR';
  Words[231] := 'SIZE';
  Words[232] := 'SMALLINT';
  Words[233] := 'SNAPSHOT';
  Words[234] := 'SOME';
  Words[235] := 'SORT';
  Words[236] := 'SQLCODE';
  Words[237] := 'SQLERROR';
  Words[238] := 'SQLWARNING';
  Words[239] := 'STABILITY';
  Words[240] := 'STARTING';
  Words[241] := 'STARTS';
  Words[242] := 'STATEMENT';
  Words[243] := 'STATIC';
  Words[244] := 'STATISTICS';
  Words[245] := 'SUB_TYPE';
  Words[246] := 'SUM';
  Words[247] := 'SUSPEND';
  Words[248] := 'TABLE';
  Words[249] := 'TEMPORARY';
  Words[250] := 'TERMINATOR';
  Words[251] := 'THEN';
  Words[252] := 'TIES';
  Words[253] := 'TIME';
  Words[254] := 'TIMESTAMP';
  Words[255] := 'TO';
  Words[256] := 'TRANSACTION';
  Words[257] := 'TRANSLATE';
  Words[258] := 'TRANSLATION';
  Words[259] := 'TRIGGER';
  Words[260] := 'TRIM';
  Words[261] := 'TRUE';
  Words[262] := 'TYPE';
  Words[263] := 'UNCOMMITTED';
  Words[264] := 'UNION';
  Words[265] := 'UNIQUE';
  Words[266] := 'UNKNOWN';
  Words[267] := 'UPDATE';
  Words[268] := 'UPPER';
  Words[269] := 'USER';
  Words[270] := 'USING';
  Words[271] := 'VALUE';
  Words[272] := 'VALUES';
  Words[273] := 'VARCHAR';
  Words[274] := 'VARIABLE';
  Words[275] := 'VARYING';
  Words[276] := 'VERSION';
  Words[277] := 'VIEW';
  Words[278] := 'WAIT';
  Words[279] := 'WEEKDAY';
  Words[280] := 'WHEN';
  Words[281] := 'WHENEVER';
  Words[282] := 'WHERE';
  Words[283] := 'WHILE';
  Words[284] := 'WITH';
  Words[285] := 'WORK';
  Words[286] := 'WRITE';
  Words[287] := 'YEAR';
  Words[288] := 'YEARDAY';
  Result := Words;
end;

constructor TDBXInterbaseTypeFilterCursor.Create(const Provider: TDBXInterbaseCustomMetaDataReader; const MetadataCollectionName: string; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable; const OrdinalTypeName: Integer; const OrdinalFieldType: Integer; const OrdinalSubType: Integer; const OrdinalScale: Integer; const OrdinalDefaultValue: Integer);
begin
  inherited Create(Provider.Context, MetadataCollectionName, Columns, Cursor);
  FCustomProvider := Provider;
  FOrdinalTypeName := OrdinalTypeName;
  FOrdinalFieldType := OrdinalFieldType;
  FOrdinalSubType := OrdinalSubType;
  FOrdinalCharSet := OrdinalSubType + 1;
  FOrdinalScale := OrdinalScale;
  FOrdinalDefaultValue := OrdinalDefaultValue;
  FRow := TDBXSingleValueRow.Create;
  FRow.Columns := CopyColumns;
end;

destructor TDBXInterbaseTypeFilterCursor.Destroy;
begin
  FreeAndNil(FRow);
  inherited Destroy;
end;

function TDBXInterbaseTypeFilterCursor.FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer;
begin
  if Ordinal = FOrdinalTypeName then
    Result := 'DOUBLE PRECISION'.Length * 2
  else 
    Result := inherited FindStringSize(Ordinal, SourceColumns);
end;

function TDBXInterbaseTypeFilterCursor.Next: Boolean;
var
  Ordinal: Integer;
begin
  FDataType := nil;
  if not inherited Next then
    Exit(False);
  ComputeDataType;
  if FDataType = nil then
  begin
    FRow.Value[FOrdinalTypeName].SetNull;
    for Ordinal := FOrdinalSubType to Length(FColumns) - 1 do
      FRow.Value[Ordinal].SetNull;
  end
  else 
  begin
    FRow.Value[FOrdinalTypeName].AsString := ComputeTypeName;
    FRow.Value[FOrdinalSubType].AsInt32 := FDataType.DbxDataType;
    FRow.Value[TDBXColumnsIndex.IsFixedLength + FOrdinalSubType - TDBXColumnsIndex.DbxDataType].AsBoolean := FDataType.FixedLength;
    FRow.Value[TDBXColumnsIndex.IsUnicode + FOrdinalSubType - TDBXColumnsIndex.DbxDataType].AsBoolean := ComputeUnicode;
    FRow.Value[TDBXColumnsIndex.IsLong + FOrdinalSubType - TDBXColumnsIndex.DbxDataType].AsBoolean := FDataType.Long;
    FRow.Value[TDBXColumnsIndex.IsUnsigned + FOrdinalSubType - TDBXColumnsIndex.DbxDataType].AsBoolean := FDataType.Unsigned;
  end;
  if FOrdinalDefaultValue >= 0 then
    FRow.Value[FOrdinalDefaultValue].AsString := ComputeDefaultValue;
  FRow.Value[FOrdinalScale].AsInt32 := Abs(FCursor.Value[FOrdinalScale].AsInt32);
  Result := True;
end;

function TDBXInterbaseTypeFilterCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  if (Ordinal >= FOrdinalSubType) or (Ordinal = FOrdinalTypeName) or (Ordinal = FOrdinalDefaultValue) or (Ordinal = FOrdinalScale) or (Ordinal = FOrdinalSubType) or (Ordinal = FOrdinalFieldType) then
    Exit(FRow.Value[Ordinal]);
  Result := inherited GetWritableValue(Ordinal);
end;

procedure TDBXInterbaseTypeFilterCursor.ComputeDataType;
var
  FieldType, Scale, SubType: SmallInt;
  LType: Integer;
  Types: TDBXDataTypeDescriptionArray;
begin
  FieldType := FCursor.Value[FOrdinalFieldType].AsInt16;
  SubType := FCursor.Value[FOrdinalSubType].AsInt16;
  Scale := FCursor.Value[FOrdinalScale].AsInt16;
  LType := GetIBType(FieldType, SubType, Scale);
  Types := FCustomProvider.AllDataTypes;
  if (LType >= 0) and (LType < Length(Types)) then
    FDataType := Types[LType];
end;

function TDBXInterbaseTypeFilterCursor.ComputeTypeName: string;
var
  SubType: SmallInt;
begin
  if FDataType.DbxDataType <> TDBXDataTypes.BlobType then
    Exit(FDataType.TypeName);
  SubType := FCursor.Value[FOrdinalSubType].AsInt16;
  Result := 'BLOB SUB_TYPE ' + IntToStr(SubType);
end;

function TDBXInterbaseTypeFilterCursor.ComputeUnicode: Boolean;
var
  CharSet: SmallInt;
begin
  if FCursor.Value[FOrdinalCharSet].IsNull then
    Exit(False);
  CharSet := FCursor.Value[FOrdinalCharSet].AsInt16;
  case CharSet of
    TDBXInterbaseCustomMetaDataReader.DefaultCharset:
      Result := FCustomProvider.FDefaultCharSetIsUnicode;
    TDBXInterbaseCustomMetaDataReader.CharsetUnicodeFss,
    TDBXInterbaseCustomMetaDataReader.CharsetSjis208,
    TDBXInterbaseCustomMetaDataReader.CharsetEucj208:
      Result := True;
    else
      Result := False;
  end;
end;

function TDBXInterbaseTypeFilterCursor.ComputeDefaultValue: string;
var
  DefaultValue: string;
begin
  DefaultValue := NullString;
  if not FCursor.Value[FOrdinalDefaultValue].IsNull then
  begin
    DefaultValue := FCursor.Value[FOrdinalDefaultValue].AsString.Trim;
    if DefaultValue.StartsWith(DefaultStringStart) then
      DefaultValue := DefaultValue.Substring(DefaultStringStart.Length, DefaultValue.Length - DefaultStringStart.Length);
  end;
  Result := DefaultValue;
end;

function TDBXInterbaseTypeFilterCursor.GetIBType(const FieldType: SmallInt; const FieldSubType: SmallInt; const FieldScale: SmallInt): Integer;
begin
// CJL-IB6 -- Decimal/int64 types possible
  if FieldScale < 0 then
    case FieldType of
      TDBXInterbaseTypeFilterCursor.Tibase_const.FBlr_short:
        Exit(TDBXInterbaseCustomMetaDataReader.NumericType);
      TDBXInterbaseTypeFilterCursor.Tibase_const.FBlr_long:
        if FieldSubType = 2 then
          Exit(TDBXInterbaseCustomMetaDataReader.DecimalType)
        else 
          Exit(TDBXInterbaseCustomMetaDataReader.NumericType);
      TDBXInterbaseTypeFilterCursor.Tibase_const.FBlr_int64:
        if FieldSubType = 2 then
          Exit(TDBXInterbaseCustomMetaDataReader.DecimalType)
        else 
          Exit(TDBXInterbaseCustomMetaDataReader.NumericType);
      TDBXInterbaseTypeFilterCursor.Tibase_const.FBlr_double:
        Exit(TDBXInterbaseCustomMetaDataReader.NumericType);
      else
    end;
// CJL-IB6 -- end
  case FieldType of
    TDBXInterbaseTypeFilterCursor.Tibase_const.FBlr_short:
      Result := TDBXInterbaseCustomMetaDataReader.SmallintType;
    TDBXInterbaseTypeFilterCursor.Tibase_const.FBlr_long:
      Result := TDBXInterbaseCustomMetaDataReader.IntegerType;
    TDBXInterbaseTypeFilterCursor.Tibase_const.FBlr_double,
    TDBXInterbaseTypeFilterCursor.Tibase_const.FBlr_d_float:
      Result := TDBXInterbaseCustomMetaDataReader.DoubleType;
    TDBXInterbaseTypeFilterCursor.Tibase_const.FBlr_float:
      Result := TDBXInterbaseCustomMetaDataReader.FloatType;
    TDBXInterbaseTypeFilterCursor.Tibase_const.FBlr_text:
      Result := TDBXInterbaseCustomMetaDataReader.CharType;
    TDBXInterbaseTypeFilterCursor.Tibase_const.FBlr_varying:
      Result := TDBXInterbaseCustomMetaDataReader.VarcharType;
    TDBXInterbaseTypeFilterCursor.Tibase_const.FBlr_timestamp:
      Result := TDBXInterbaseCustomMetaDataReader.TimestampType;
    TDBXInterbaseTypeFilterCursor.Tibase_const.FBlr_sql_time:
      Result := TDBXInterbaseCustomMetaDataReader.TimeType;
    TDBXInterbaseTypeFilterCursor.Tibase_const.FBlr_sql_date:
      Result := TDBXInterbaseCustomMetaDataReader.DateType;
    TDBXInterbaseTypeFilterCursor.Tibase_const.FBlr_int64:
      if FieldSubType = 2 then
        Result := TDBXInterbaseCustomMetaDataReader.DecimalType
      else 
        Result := TDBXInterbaseCustomMetaDataReader.NumericType;
    261:
      Result := TDBXInterbaseCustomMetaDataReader.BlobType;
    9:
      Result := -1;
    TDBXInterbaseTypeFilterCursor.Tibase_const.FBlr_boolean_dtype:
      Result := TDBXInterbaseCustomMetaDataReader.BooleanType;
    else
      Result := -1;
  end;
end;
// CJL-IB6 added types
// CJL-IB6 end

end.



