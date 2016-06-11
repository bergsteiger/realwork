{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.DBXOracleMetaDataReader;

interface

uses
  Data.DBXCommon,
  Data.DBXCommonTable,
  Data.DBXMetaDataNames,
  Data.DBXMetaDataReader,
  Data.DBXPlatform;

type
  
  /// <summary>  TDBXOracleCustomMetaDataReader contains custom code for Orcale.
  /// </summary>
  /// <remarks>  This class handles default values.
  /// </remarks>
  TDBXOracleCustomMetaDataReader = class(TDBXBaseMetaDataReader)
  public
    type
            
      /// <summary>  TDBXOracleColumnsCursor is a filter for a cursor providing table columns.
      /// </summary>
      /// <remarks>  In Oracle the default value is kept in a LONG data type. Oracle does not allow SQL
      ///   operations like TRIM() on LONG values.
      ///   This filter will trim the default values.
      /// </remarks>
      TDBXOracleColumnsCursor = class(TDBXCustomMetaDataTable)
      public
        destructor Destroy; override;
        function Next: Boolean; override;
      protected
        constructor Create(const Provider: TDBXOracleCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable);
        function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
      public
        FDefaultValue: TDBXWritableValue;
      end;
            
      /// <summary>  TDBXOracleIndexColumnsCursor is a filter for a cursor providing index columns.
      /// </summary>
      /// <remarks>  In Oracle indexes can be created from expressions, therefore there are no column
      ///   names specified for each index.
      ///   This filter tries to extract the column name from an index expression.
      /// </remarks>
      TDBXOracleIndexColumnsCursor = class(TDBXCustomMetaDataTable)
      public
        destructor Destroy; override;
        function Next: Boolean; override;
      protected
        constructor Create(const Provider: TDBXOracleCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable);
        function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
      private
        function ComputeColumnName: string;
      private
        FNameValue: TDBXWritableValue;
      private
        const ColumnExpressionOrdinal = TDBXIndexColumnsIndex.Last + 1;
        const ColumnExpressionNullOrdinal = TDBXIndexColumnsIndex.Last + 2;
      end;

  public
    
    /// <summary>  Overrides the implementation in TDBXBaseMetaDataReader.
    /// </summary>
    /// <remarks>  A custom filter is added to trim the default values.
    /// </remarks>
    /// <seealso cref="TDBXOracleColumnsCursor"/>
    function FetchColumns(const Catalog: string; const Schema: string; const Table: string): TDBXTable; override;
    
    /// <summary>  Overrides the implementation in TDBXBaseMetaDataProvider.
    /// </summary>
    /// <remarks>  A custom filter is added to retrieve the column names.
    /// </remarks>
    /// <seealso cref="TDBXOracleColumnsCursor"/>
    function FetchIndexColumns(const Catalog: string; const Schema: string; const Table: string; const Index: string): TDBXTable; override;
  protected
    procedure PopulateDataTypes(const Hash: TDBXObjectStore; const Types: TDBXArrayList; const Descr: TDBXDataTypeDescriptionArray); override;
    function GetDataTypeDescriptions: TDBXDataTypeDescriptionArray; override;
  end;

  TDBXOracleMetaDataReader = class(TDBXOracleCustomMetaDataReader)
  public
    function FetchCatalogs: TDBXTable; override;
    function FetchColumnConstraints(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable; override;
  protected
    function AreSchemasSupported: Boolean; override;
    function GetProductName: string; override;
    function IsNestedTransactionsSupported: Boolean; override;
    function IsSetRowSizeSupported: Boolean; override;
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
    function GetSqlForProcedureParameters: string; override;
    function GetSqlForPackages: string; override;
    function GetSqlForPackageSources: string; override;
    function GetSqlForPackageProcedures: string; override;
    function GetSqlForPackageProcedureParameters: string; override;
    function GetSqlForUsers: string; override;
    function GetSqlForRoles: string; override;
    function GetReservedWords: TDBXStringArray; override;
  end;

implementation

uses
  System.SysUtils;

procedure TDBXOracleCustomMetaDataReader.PopulateDataTypes(const Hash: TDBXObjectStore; const Types: TDBXArrayList; const Descr: TDBXDataTypeDescriptionArray);
var
  Def: TDBXDataTypeDescription;
begin
  inherited PopulateDataTypes(Hash, Types, Descr);
  Def := TDBXDataTypeDescription.Create('REF CURSOR', TDBXDataTypes.CursorType, 0, NullString, NullString, 0, 0, NullString, NullString, NullString, NullString, 0);
  Hash[Def.TypeName] := Def;
  Def := TDBXDataTypeDescription.Create('PL/SQL BOOLEAN', TDBXDataTypes.BooleanType, 0, NullString, NullString, 0, 0, NullString, NullString, NullString, NullString, 0);
  Hash[Def.TypeName] := Def;
  Def := TDBXDataTypeDescription.Create('BINARY_INTEGER', TDBXDataTypes.Int32Type, 0, NullString, NullString, 0, 0, NullString, NullString, NullString, NullString, 0);
  Hash[Def.TypeName] := Def;
end;

function TDBXOracleCustomMetaDataReader.GetDataTypeDescriptions: TDBXDataTypeDescriptionArray;
var
  Types: TDBXDataTypeDescriptionArray;
begin
  SetLength(Types,22);
  Types[0] := TDBXDataTypeDescription.Create('BFILE', TDBXDataTypes.BlobType, 4294967296, 'BFILE', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.Long or TDBXTypeFlag.Nullable);
  Types[1] := TDBXDataTypeDescription.Create('BLOB', TDBXDataTypes.BlobType, 4294967296, 'BLOB', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.Long or TDBXTypeFlag.Nullable);
  Types[2] := TDBXDataTypeDescription.Create('CHAR', TDBXDataTypes.WideStringType, 2000, 'CHAR({0})', 'Precision', -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.CaseSensitive or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.LiteralSupported);
  Types[3] := TDBXDataTypeDescription.Create('CLOB', TDBXDataTypes.WideStringType, 4294967296, 'CLOB', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.CaseSensitive or TDBXTypeFlag.Long or TDBXTypeFlag.Nullable);
  Types[4] := TDBXDataTypeDescription.Create('DATE', TDBXDataTypes.TimeStampType, 19, 'DATE', NullString, -1, -1, 'TO_DATE(''', ''',''YYYY-MM-DD HH24:MI:SS'')', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.LiteralSupported);
  Types[5] := TDBXDataTypeDescription.Create('FLOAT', TDBXDataTypes.BcdType, 126, 'FLOAT({0})', 'Precision', -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.LiteralSupported);
  Types[6] := TDBXDataTypeDescription.Create('BINARY_FLOAT', TDBXDataTypes.SingleType, 7, 'BINARY_FLOAT', NullString, -1, -1, '', '', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.LiteralSupported);
  Types[7] := TDBXDataTypeDescription.Create('BINARY_DOUBLE', TDBXDataTypes.DoubleType, 53, 'BINARY_DOUBLE', NullString, -1, -1, '', '', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.LiteralSupported);
  Types[8] := TDBXDataTypeDescription.Create('INTERVAL DAY TO SECOND', TDBXDataTypes.IntervalType, 0, 'INTERVAL DAY({0}) TO SECOND({1})', 'Precision,Scale', -1, -1, 'TO_DSINTERVAL(''', ''')', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.LiteralSupported);
  Types[9] := TDBXDataTypeDescription.Create('INTERVAL YEAR TO MONTH', TDBXDataTypes.IntervalType, 0, 'INTERVAL YEAR({0}) TO MONTH', 'Precision', -1, -1, 'TO_YMINTERVAL(''', ''')', NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.LiteralSupported);
  Types[10] := TDBXDataTypeDescription.Create('LONG', TDBXDataTypes.WideStringType, 2147483647, 'LONG', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.Long);
  Types[11] := TDBXDataTypeDescription.Create('LONG RAW', TDBXDataTypes.BytesType, 2147483647, 'LONG RAW', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.Long or TDBXTypeFlag.Nullable);
  Types[12] := TDBXDataTypeDescription.Create('NCHAR', TDBXDataTypes.WideStringType, 2000, 'NCHAR({0})', 'Precision', -1, -1, 'N''', '''', NullString, NullString, TDBXTypeFlag.CaseSensitive or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.LiteralSupported or TDBXTypeFlag.Unicode);
  Types[13] := TDBXDataTypeDescription.Create('NCLOB', TDBXDataTypes.WideStringType, 4294967296, 'NCLOB', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.CaseSensitive or TDBXTypeFlag.Long or TDBXTypeFlag.Nullable or TDBXTypeFlag.Unicode);
  Types[14] := TDBXDataTypeDescription.Create('NUMBER', TDBXDataTypes.BcdType, 38, 'NUMBER({0},{1})', 'Precision,Scale', 127, -84, '', '', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.LiteralSupported);
  Types[15] := TDBXDataTypeDescription.Create('NVARCHAR2', TDBXDataTypes.WideStringType, 4000, 'NVARCHAR2({0})', 'Precision', -1, -1, 'N''', '''', NullString, NullString, TDBXTypeFlag.CaseSensitive or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.LiteralSupported or TDBXTypeFlag.Unicode);
  Types[16] := TDBXDataTypeDescription.Create('RAW', TDBXDataTypes.BytesType, 2000, 'RAW({0})', 'Precision', -1, -1, 'HEXTORAW(''', ''')', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.LiteralSupported);
  Types[17] := TDBXDataTypeDescription.Create('TIMESTAMP', TDBXDataTypes.TimeStampType, 27, 'TIMESTAMP({0})', 'Precision', -1, -1, 'TO_TIMESTAMP(''', ''',''YYYY-MM-DD HH24:MI:SS.FF'')', NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.LiteralSupported);
  Types[18] := TDBXDataTypeDescription.Create('TIMESTAMP WITH LOCAL TIME ZONE', TDBXDataTypes.TimeStampType, 27, 'TIMESTAMP({0} WITH LOCAL TIME ZONE)', 'Precision', -1, -1, 'TO_TIMESTAMP_TZ(''', ''',''YYYY-MM-DD HH24:MI:SS.FF'')', NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.LiteralSupported);
  Types[19] := TDBXDataTypeDescription.Create('TIMESTAMP WITH TIME ZONE', TDBXDataTypes.TimeStampType, 34, 'TIMESTAMP({0} WITH TIME ZONE)', 'Precision', -1, -1, 'TO_TIMESTAMP_TZ(''', ''',''YYYY-MM-DD HH24:MI:SS.FF TZH:TZM'')', NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.LiteralSupported);
  Types[20] := TDBXDataTypeDescription.Create('VARCHAR2', TDBXDataTypes.WideStringType, 4000, 'VARCHAR2({0})', 'Precision', -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.LiteralSupported);
  Types[21] := TDBXDataTypeDescription.Create('XMLTYPE', TDBXDataTypes.WideStringType, 4000, 'XMLTYPE', NullString, -1, -1, '', '', NullString, NullString, TDBXTypeFlag.LiteralSupported);
  Result := Types;
end;

function TDBXOracleCustomMetaDataReader.FetchColumns(const Catalog: string; const Schema: string; const Table: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
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
  Result := TDBXColumnsTableCursor.Create(self, False, TDBXOracleCustomMetaDataReader.TDBXOracleColumnsCursor.Create(self, Columns, Cursor));
end;

function TDBXOracleCustomMetaDataReader.FetchIndexColumns(const Catalog: string; const Schema: string; const Table: string; const Index: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
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
  Result := TDBXOracleCustomMetaDataReader.TDBXOracleIndexColumnsCursor.Create(self, Columns, Cursor);
end;

constructor TDBXOracleCustomMetaDataReader.TDBXOracleColumnsCursor.Create(const Provider: TDBXOracleCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable);
begin
  inherited Create(Provider.Context, TDBXMetaDataCollectionName.Columns, Columns, Cursor);
end;

destructor TDBXOracleCustomMetaDataReader.TDBXOracleColumnsCursor.Destroy;
begin
  FreeAndNil(FDefaultValue);
  inherited Destroy;
end;

function TDBXOracleCustomMetaDataReader.TDBXOracleColumnsCursor.Next: Boolean;
begin
  if inherited Next then
  begin
    if FDefaultValue = nil then
      FDefaultValue := TDBXWritableValue(TDBXValue.CreateValue(TDBXValueType(inherited GetWritableValue(TDBXColumnsIndex.DefaultValue).ValueType.Clone())));
    FDefaultValue.AsString := Trim(inherited GetWritableValue(TDBXColumnsIndex.DefaultValue).AsString);
    Exit(True);
  end;
  if FDefaultValue <> nil then
    FDefaultValue.SetNull;
  Result := False;
end;

function TDBXOracleCustomMetaDataReader.TDBXOracleColumnsCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  if Ordinal = TDBXColumnsIndex.DefaultValue then
    Exit(FDefaultValue);
  Result := inherited GetWritableValue(Ordinal);
end;

constructor TDBXOracleCustomMetaDataReader.TDBXOracleIndexColumnsCursor.Create(const Provider: TDBXOracleCustomMetaDataReader; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable);
begin
  inherited Create(Provider.Context, TDBXMetaDataCollectionName.IndexColumns, Columns, Cursor);
end;

destructor TDBXOracleCustomMetaDataReader.TDBXOracleIndexColumnsCursor.Destroy;
begin
  FreeAndNil(FNameValue);
  inherited Destroy;
end;

function TDBXOracleCustomMetaDataReader.TDBXOracleIndexColumnsCursor.Next: Boolean;
begin
  if inherited Next then
  begin
    if FNameValue = nil then
      FNameValue := TDBXWritableValue(TDBXValue.CreateValue(TDBXValueType(inherited GetWritableValue(TDBXIndexColumnsIndex.ColumnName).ValueType.Clone())));
    FNameValue.AsString := ComputeColumnName;
    Exit(True);
  end;
  if FNameValue <> nil then
    FNameValue.SetNull;
  Result := False;
end;

function TDBXOracleCustomMetaDataReader.TDBXOracleIndexColumnsCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  if Ordinal = TDBXIndexColumnsIndex.ColumnName then
    Exit(FNameValue);
  Result := inherited GetWritableValue(Ordinal);
end;

function TDBXOracleCustomMetaDataReader.TDBXOracleIndexColumnsCursor.ComputeColumnName: string;
var
  Expression: string;
begin
  Expression := NullString;
  if FCursor.Value[ColumnExpressionNullOrdinal].AsInt32 <> 0 then
    Exit(inherited GetWritableValue(TDBXIndexColumnsIndex.ColumnName).AsString)
  else 
  begin
    Expression := FCursor.Value[ColumnExpressionOrdinal].AsString;
    if (not Expression.IsEmpty) and (Expression.Length > 0) then
    begin
      if (Expression.Length > 2) and (Expression.Chars[0] = '"') and (Expression.Chars[Expression.Length - 1] = '"') and (Expression.IndexOf(' ') < 0) then
        Expression := Expression.Substring(1, Expression.Length - 2);
    end;
  end;
  Result := Expression;
end;

function TDBXOracleMetaDataReader.AreSchemasSupported;
begin
  Result := True;
end;

function TDBXOracleMetaDataReader.GetProductName: string;
begin
  Result := 'Oracle';
end;

function TDBXOracleMetaDataReader.IsNestedTransactionsSupported: Boolean;
begin
  Result := True;
end;

function TDBXOracleMetaDataReader.IsSetRowSizeSupported: Boolean;
begin
  Result := True;
end;

function TDBXOracleMetaDataReader.FetchCatalogs: TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateCatalogsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Catalogs, Columns);
end;

function TDBXOracleMetaDataReader.GetSqlForSchemas: string;
begin
  Result := 'SELECT DISTINCT NULL, OWNER ' +
            'FROM ALL_OBJECTS ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) ' +
            'ORDER BY 1';
end;

function TDBXOracleMetaDataReader.GetSqlForTables: string;
begin
  Result := 'SELECT /*+ NO_EXPAND */ NULL, OWNER, OBJECT_NAME, CASE WHEN OWNER IN (''SYS'',''SYSTEM'',''CTXSYS'',''DMSYS'',''EXFSYS'',''OLAPSYS'',''ORDSYS'',''MDSYS'',''WKSYS'',''WK_TEST'',''WMSYS'',''XDB'') THEN ''SYSTEM '' ELSE '''' END || OBJECT_TYPE ' +
            'FROM ALL_OBJECTS ' +
            'WHERE OBJECT_TYPE IN (''VIEW'',''TABLE'',''SYNONYM'') ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(OWNER) = LOWER(:SCHEMA_NAME) OR (:SCHEMA_NAME IS NULL)) AND (OBJECT_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            ' AND ((CASE WHEN OWNER IN (''SYS'',''SYSTEM'',''CTXSYS'',''DMSYS'',''EXFSYS'',''OLAPSYS'',''ORDSYS'',''MDSYS'',''WKSYS'',''WK_TEST'',''WMSYS'',''XDB'') THEN ''SYSTEM '' ELSE '''' END) || OBJECT_TYPE IN (:TABLES,:VIEWS,:SYSTEM_TABLES,:SYSTEM_VIEWS,:SYNONYMS)) ' +
            'ORDER BY 2, 3';
end;

function TDBXOracleMetaDataReader.GetSqlForViews: string;
begin
  Result := 'SELECT NULL, OWNER, VIEW_NAME, TEXT ' +
            'FROM SYS.ALL_VIEWS ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(OWNER) = LOWER(:SCHEMA_NAME) OR (:SCHEMA_NAME IS NULL)) AND (VIEW_NAME = :VIEW_NAME OR (:VIEW_NAME IS NULL)) ' +
            'ORDER BY 2, 3';
end;

function TDBXOracleMetaDataReader.GetSqlForColumns: string;
begin
  Result := 'SELECT NULL, OWNER, TABLE_NAME, COLUMN_NAME, DATA_TYPE, COALESCE(DATA_PRECISION,CHAR_COL_DECL_LENGTH,DATA_LENGTH), DATA_SCALE, COLUMN_ID, DATA_DEFAULT, DECODE(NULLABLE,''Y'',1,''YES'',1,0), 0, NULL ' +
            'FROM SYS.ALL_TAB_COLUMNS ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(OWNER) = LOWER(:SCHEMA_NAME) OR (:SCHEMA_NAME IS NULL)) AND (TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            'ORDER BY 2, 3, COLUMN_ID';
end;

function TDBXOracleMetaDataReader.FetchColumnConstraints(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateColumnConstraintsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.ColumnConstraints, Columns);
end;

function TDBXOracleMetaDataReader.GetSqlForIndexes: string;
begin
  Result := 'SELECT NULL, I.TABLE_OWNER, I.TABLE_NAME, I.INDEX_NAME, C.CONSTRAINT_NAME, CASE WHEN C.CONSTRAINT_TYPE = ''P'' THEN 1 ELSE 0 END, CASE WHEN I.UNIQUENESS = ''UNIQUE'' THEN 1 ELSE 0 END, 1 ' +
            'FROM SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C ' +
            'WHERE I.TABLE_OWNER=C.OWNER(+) AND I.INDEX_NAME=C.INDEX_NAME(+) AND I.TABLE_NAME=C.TABLE_NAME(+) ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(I.TABLE_OWNER) = LOWER(:SCHEMA_NAME) OR (:SCHEMA_NAME IS NULL)) AND (I.TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            'ORDER BY 2, 3, 4';
end;

function TDBXOracleMetaDataReader.GetSqlForIndexColumns: string;
begin
  Result := 'SELECT NULL, C.TABLE_OWNER, C.TABLE_NAME, C.INDEX_NAME, C.COLUMN_NAME, C.COLUMN_POSITION, CASE WHEN C.DESCEND = ''DESC'' THEN 0 ELSE 1 END, E.COLUMN_EXPRESSION, CASE WHEN E.COLUMN_EXPRESSION IS NULL THEN 1 ELSE 0 END ' +
            'FROM ALL_IND_COLUMNS C, ALL_IND_EXPRESSIONS E ' +
            'WHERE C.INDEX_OWNER=E.INDEX_OWNER(+) AND C.INDEX_NAME=E.INDEX_NAME(+) AND C.COLUMN_POSITION=E.COLUMN_POSITION(+) ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(C.TABLE_OWNER) = LOWER(:SCHEMA_NAME) OR (:SCHEMA_NAME IS NULL)) AND (C.TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (C.INDEX_NAME = :INDEX_NAME OR (:INDEX_NAME IS NULL)) ' +
            'ORDER BY 2, 3, 4, 6';
end;

function TDBXOracleMetaDataReader.GetSqlForForeignKeys: string;
begin
  Result := 'SELECT NULL, OWNER, TABLE_NAME, CONSTRAINT_NAME ' +
            'FROM ALL_CONSTRAINTS ' +
            'WHERE CONSTRAINT_TYPE = ''R'' ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(OWNER) = LOWER(:SCHEMA_NAME) OR (:SCHEMA_NAME IS NULL)) AND (TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            'ORDER BY 2, 3, 4';
end;

function TDBXOracleMetaDataReader.GetSqlForForeignKeyColumns: string;
begin
  Result := 'SELECT NULL, FC.OWNER, FC.TABLE_NAME, FC.CONSTRAINT_NAME, FC.COLUMN_NAME, NULL, PC.OWNER, PC.TABLE_NAME, PC.CONSTRAINT_NAME, PC.COLUMN_NAME, FC.POSITION ' +
            'FROM ALL_CONS_COLUMNS FC, ALL_CONSTRAINTS F, ALL_CONSTRAINTS P, ALL_CONS_COLUMNS PC ' +
            'WHERE F.CONSTRAINT_TYPE = ''R'' ' +
            ' AND F.OWNER=FC.OWNER AND F.TABLE_NAME=FC.TABLE_NAME AND F.CONSTRAINT_NAME=FC.CONSTRAINT_NAME ' +
            ' AND F.R_OWNER=P.OWNER AND F.R_CONSTRAINT_NAME=P.CONSTRAINT_NAME ' +
            ' AND P.OWNER=PC.OWNER AND P.TABLE_NAME=PC.TABLE_NAME AND P.CONSTRAINT_NAME=PC.CONSTRAINT_NAME ' +
            ' AND FC.POSITION=PC.POSITION ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(FC.OWNER) = LOWER(:SCHEMA_NAME) OR (:SCHEMA_NAME IS NULL)) AND (FC.TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (FC.CONSTRAINT_NAME = :FOREIGN_KEY_NAME OR (:FOREIGN_KEY_NAME IS NULL)) ' +
            ' AND (1<2 OR (:PRIMARY_CATALOG_NAME IS NULL)) AND (LOWER(PC.OWNER) = LOWER(:PRIMARY_SCHEMA_NAME) OR (:PRIMARY_SCHEMA_NAME IS NULL)) AND (PC.TABLE_NAME = :PRIMARY_TABLE_NAME OR (:PRIMARY_TABLE_NAME IS NULL)) AND (PC.CONSTRAINT_NAME = :PRIMARY_KEY_NAME OR (' + ':PRIMARY_KEY_NAME IS NULL)) ' +
            'ORDER BY 2, 3, 4, FC.POSITION';
end;

function TDBXOracleMetaDataReader.GetSqlForSynonyms: string;
begin
  Result := 'SELECT NULL, OWNER, SYNONYM_NAME, NULL, TABLE_OWNER, TABLE_NAME ' +
            'FROM ALL_SYNONYMS ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(OWNER) = LOWER(:SCHEMA_NAME) OR (:SCHEMA_NAME IS NULL)) AND (SYNONYM_NAME = :SYNONYM_NAME OR (:SYNONYM_NAME IS NULL)) ' +
            'ORDER BY 2,3';
end;

function TDBXOracleMetaDataReader.GetSqlForProcedures: string;
begin
  Result := 'SELECT NULL, OWNER, OBJECT_NAME, OBJECT_TYPE ' +
            'FROM ALL_OBJECTS ' +
            'WHERE OBJECT_TYPE IN (''FUNCTION'',''PROCEDURE'') ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(OWNER) = LOWER(:SCHEMA_NAME) OR (:SCHEMA_NAME IS NULL)) AND (OBJECT_NAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) AND (OBJECT_TYPE = :PROCEDURE_TYPE OR (:PROCEDURE_TYPE IS NULL)) ' +
            'ORDER BY 2,3';
end;

function TDBXOracleMetaDataReader.GetSqlForProcedureSources: string;
begin
  Result := 'SELECT NULL, OWNER, NAME, TYPE, TEXT, NULL, LINE AS SOURCE_LINE_NUMBER ' +
            'FROM ALL_SOURCE S ' +
            'WHERE TYPE IN (''FUNCTION'',''PROCEDURE'') ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(OWNER) = LOWER(:SCHEMA_NAME) OR (:SCHEMA_NAME IS NULL)) AND (NAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) ' +
            'ORDER BY OWNER,NAME,LINE';
end;

function TDBXOracleMetaDataReader.GetSqlForProcedureParameters: string;
begin
  Result := 'SELECT NULL, OWNER, OBJECT_NAME, ARGUMENT_NAME, CASE WHEN POSITION=0 THEN ''RESULT'' WHEN IN_OUT=''IN/OUT'' THEN ''INOUT'' ELSE IN_OUT END, DATA_TYPE, NULL, NULL, POSITION, 1 ' +
            'FROM ALL_ARGUMENTS ' +
            'WHERE PACKAGE_NAME IS NULL AND DATA_LEVEL=0 AND DATA_TYPE IS NOT NULL ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(OWNER) = LOWER(:SCHEMA_NAME) OR (:SCHEMA_NAME IS NULL)) AND (OBJECT_NAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) AND (ARGUMENT_NAME = :PARAMETER_NAME OR (:PARAMETER_NAME IS NULL)) ' +
            'ORDER BY OWNER,OBJECT_NAME,POSITION';
end;

function TDBXOracleMetaDataReader.GetSqlForPackages: string;
begin
  Result := 'SELECT NULL, OWNER, OBJECT_NAME ' +
            'FROM ALL_OBJECTS ' +
            'WHERE OBJECT_TYPE IN (''PACKAGE'') ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(OWNER) = LOWER(:SCHEMA_NAME) OR (:SCHEMA_NAME IS NULL)) AND (OBJECT_NAME = :PACKAGE_NAME OR (:PACKAGE_NAME IS NULL)) ' +
            'ORDER BY 2,3';
end;

function TDBXOracleMetaDataReader.GetSqlForPackageSources: string;
begin
  Result := 'SELECT NULL, OWNER, NAME, TEXT, LINE AS SOURCE_LINE_NUMBER ' +
            'FROM ALL_SOURCE S ' +
            'WHERE TYPE IN (''PACKAGE'') ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(OWNER) = LOWER(:SCHEMA_NAME) OR (:SCHEMA_NAME IS NULL)) AND (NAME = :PACKAGE_NAME OR (:PACKAGE_NAME IS NULL)) ' +
            'ORDER BY OWNER,NAME,LINE';
end;

function TDBXOracleMetaDataReader.GetSqlForPackageProcedures: string;
begin
  Result := 'SELECT NULL, OWNER, PACKAGE_NAME, OBJECT_NAME, CASE WHEN MIN(POSITION)=0 THEN ''FUNCTION'' ELSE ''PROCEDURE'' END ' +
            'FROM ALL_ARGUMENTS ' +
            'WHERE PACKAGE_NAME IS NOT NULL ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(OWNER) = LOWER(:SCHEMA_NAME) OR (:SCHEMA_NAME IS NULL)) AND (PACKAGE_NAME = :PACKAGE_NAME OR (:PACKAGE_NAME IS NULL)) AND (OBJECT_NAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) ' +
            'GROUP BY OWNER, PACKAGE_NAME, OBJECT_NAME ' +
            'HAVING (CASE WHEN MIN(POSITION)=0 THEN ''FUNCTION'' ELSE ''PROCEDURE'' END = :PROCEDURE_TYPE OR (:PROCEDURE_TYPE IS NULL))';
end;

function TDBXOracleMetaDataReader.GetSqlForPackageProcedureParameters: string;
begin
  Result := 'SELECT NULL, OWNER, PACKAGE_NAME, OBJECT_NAME, ARGUMENT_NAME, CASE WHEN POSITION=0 THEN ''RESULT'' WHEN IN_OUT=''IN/OUT'' THEN ''INOUT'' ELSE IN_OUT END, DATA_TYPE, NULL, NULL, POSITION, 1 ' +
            'FROM ALL_ARGUMENTS ' +
            'WHERE PACKAGE_NAME IS NOT NULL AND DATA_LEVEL=0 AND DATA_TYPE IS NOT NULL ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(OWNER) = LOWER(:SCHEMA_NAME) OR (:SCHEMA_NAME IS NULL)) AND (PACKAGE_NAME = :PACKAGE_NAME OR (:PACKAGE_NAME IS NULL)) AND (OBJECT_NAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) AND (ARGUMENT_NAME = :P' + 'ARAMETER_NAME OR (:PARAMETER_NAME IS NULL)) ' +
            'ORDER BY OWNER,PACKAGE_NAME,OBJECT_NAME,POSITION';
end;

function TDBXOracleMetaDataReader.GetSqlForUsers: string;
begin
  Result := 'SELECT USERNAME FROM ALL_USERS ORDER BY 1';
end;

function TDBXOracleMetaDataReader.GetSqlForRoles: string;
begin
  Result := 'SELECT ROLE FROM SESSION_ROLES ORDER BY 1';
end;

function TDBXOracleMetaDataReader.GetReservedWords: TDBXStringArray;
var
  Words: TDBXStringArray;
begin
  SetLength(Words,80);
  Words[0] := 'ALL';
  Words[1] := 'ALTER';
  Words[2] := 'AND';
  Words[3] := 'ANY';
  Words[4] := 'AS';
  Words[5] := 'ASC';
  Words[6] := 'BETWEEN';
  Words[7] := 'BY';
  Words[8] := 'CHAR';
  Words[9] := 'CHECK';
  Words[10] := 'CLUSTER';
  Words[11] := 'COMPRESS';
  Words[12] := 'CONNECT';
  Words[13] := 'CREATE';
  Words[14] := 'DATE';
  Words[15] := 'DECIMAL';
  Words[16] := 'DEFAULT';
  Words[17] := 'DELETE';
  Words[18] := 'DESC';
  Words[19] := 'DISTINCT';
  Words[20] := 'DROP';
  Words[21] := 'ELSE';
  Words[22] := 'EXCLUSIVE';
  Words[23] := 'EXISTS';
  Words[24] := 'FLOAT';
  Words[25] := 'FOR';
  Words[26] := 'FROM';
  Words[27] := 'GRANT';
  Words[28] := 'GROUP';
  Words[29] := 'HAVING';
  Words[30] := 'IDENTIFIED';
  Words[31] := 'IN';
  Words[32] := 'INDEX';
  Words[33] := 'INSERT';
  Words[34] := 'INTEGER';
  Words[35] := 'INTERSECT';
  Words[36] := 'INTO';
  Words[37] := 'IS';
  Words[38] := 'LIKE';
  Words[39] := 'LOCK';
  Words[40] := 'LONG';
  Words[41] := 'MINUS';
  Words[42] := 'MODE';
  Words[43] := 'NOCOMPRESS';
  Words[44] := 'NOT';
  Words[45] := 'NOWAIT';
  Words[46] := 'NULL';
  Words[47] := 'NUMBER';
  Words[48] := 'OF';
  Words[49] := 'ON';
  Words[50] := 'OPTION';
  Words[51] := 'OR';
  Words[52] := 'ORDER';
  Words[53] := 'PCTFREE';
  Words[54] := 'PRIOR';
  Words[55] := 'PUBLIC';
  Words[56] := 'RAW';
  Words[57] := 'RENAME';
  Words[58] := 'RESOURCE';
  Words[59] := 'REVOKE';
  Words[60] := 'SELECT';
  Words[61] := 'SET';
  Words[62] := 'SHARE';
  Words[63] := 'SIZE';
  Words[64] := 'SMALLINT';
  Words[65] := 'START';
  Words[66] := 'SYNONYM';
  Words[67] := 'TABLE';
  Words[68] := 'THEN';
  Words[69] := 'TO';
  Words[70] := 'TRIGGER';
  Words[71] := 'UNION';
  Words[72] := 'UNIQUE';
  Words[73] := 'UPDATE';
  Words[74] := 'VALUES';
  Words[75] := 'VARCHAR';
  Words[76] := 'VARCHAR2';
  Words[77] := 'VIEW';
  Words[78] := 'WHERE';
  Words[79] := 'WITH';
  Result := Words;
end;

end.

