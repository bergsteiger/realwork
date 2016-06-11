{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.DBXSybaseASAMetaDataReader;

interface

uses
  Data.DBXCommon,
  Data.DBXCommonTable,
  Data.DBXMetaDataNames,
  Data.DBXMetaDataReader,
  Data.DBXPlatform;

type
  
  /// <summary>  TDBXSybaseASACustomMetaDataReader contains custom code for Adaptive Server Anywhere.
  /// </summary>
  TDBXSybaseASACustomMetaDataReader = class(TDBXBaseMetaDataReader)
  public
    type
            
      /// <summary>  TDBXSybaseASAForeignKeyColumnsCursor is a filter for a cursor providing foreign key columns.
      /// </summary>
      /// <remarks>  In Adaptive Server Anywhere version 9.* and earlier the primary key columns were not included
      ///   in the SYSIXCOL system table. Instead each column in the primary key has a flag set in the
      ///   SYSCOLUMN system table. The ordinal value of each foreign key column referencing a primary key
      ///   is simply not maintained. This filter will assign reasonable values to the ordinal column.
      /// </remarks>
      TDBXSybaseASAForeignKeyColumnsCursor = class(TDBXCustomMetaDataTable)
      public
        destructor Destroy; override;
        function Next: Boolean; override;
      protected
        constructor Create(const Provider: TDBXSybaseASACustomMetaDataReader; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable);
        function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
      private
        FSchemaName: string;
        FPrevSchemaName: string;
        FTableName: string;
        FPrevTableName: string;
        FIndexId: Int64;
        FPrevIndexId: Int64;
        FRunningOrdinal: Integer;
        FOrdinalValue: TDBXWritableValue;
      private
        const ForeignkeyColumnIndexIndicator = TDBXForeignKeyColumnsIndex.Last + 1;
        const NullIndexId = -1;
      end;

  public
    
    /// <summary>  Overrides the implementation in TDBXBaseMetaDataProvider.
    /// </summary>
    /// <remarks>  A custom filter is added to correct the Ordinal column which could not be correctly expressed in SQL.
    /// </remarks>
    /// <seealso cref="TDBXSybaseASAForeignKeyColumnsCursor"/>
    function FetchForeignKeyColumns(const Catalog: string; const Schema: string; const Table: string; const ForeignKeyName: string; const PrimaryCatalog: string; const PrimarySchema: string; const PrimaryTable: string; const PrimaryKeyName: string): TDBXTable; override;
    protected
      procedure SetContext(const Context: TDBXProviderContext); override;
    private
      FVendorLibPath: string;
      FSupportsNLSDataType: Boolean;
      FIsServerCharsetUTF8: Boolean;
      FIsCharUnicode: Boolean;
    public
      property VendorLibPath : string read FVendorLibPath;
      property SupportsNLSDataType: Boolean read FSupportsNLSDataType;
      property IsServerCharsetUTF8: Boolean read FIsServerCharsetUTF8;
      property IsCharUnicode: Boolean read FIsCharUnicode;
      property DefaultCharSetUnicode: Boolean read FIsServerCharsetUTF8;
    private
      const VendorLibPathPropertyName = 'VendorLibPath';
      const SupportsNLSDataTypePropertyName = 'SupportsNLSDataType';
      const IsServerCharsetUTF8PropertyName = 'IsServerCharsetUTF8';
      const IsCharUnicodePropertyName = 'IsCharUnicode';
      const UnicodeEncodingPropertyName = 'UnicodeEncoding';
  end;

  TDBXSybaseASAMetaDataReader = class(TDBXSybaseASACustomMetaDataReader)
  public
    function FetchCatalogs: TDBXTable; override;
    function FetchColumnConstraints(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable; override;
    function FetchSynonyms(const CatalogName: string; const SchemaName: string; const SynonymName: string): TDBXTable; override;
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
    function GetSystemViewType: string; override;
    function IsLowerCaseIdentifiersSupported: Boolean; override;
    function IsSetRowSizeSupported: Boolean; override;
    function IsUpperCaseIdentifiersSupported: Boolean; override;
    function GetSqlForSchemas: string; override;
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
    function GetDataTypeDescriptions: TDBXDataTypeDescriptionArray; override;
    function GetReservedWords: TDBXStringArray; override;
  end;

implementation

uses
  System.SysUtils;

function TDBXSybaseASACustomMetaDataReader.FetchForeignKeyColumns(const Catalog: string; const Schema: string; const Table: string; const ForeignKeyName: string; const PrimaryCatalog: string; const PrimarySchema: string; const PrimaryTable: string; const PrimaryKeyName: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  if CompareVersion(TDBXVersion.FVersion10) >= 0 then
    Result := inherited FetchForeignKeyColumns(Catalog, Schema, Table, ForeignKeyName, PrimaryCatalog, PrimarySchema, PrimaryTable, PrimaryKeyName)
  else 
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
    Result := TDBXSybaseASACustomMetaDataReader.TDBXSybaseASAForeignKeyColumnsCursor.Create(self, Columns, Cursor);
  end;
end;

constructor TDBXSybaseASACustomMetaDataReader.TDBXSybaseASAForeignKeyColumnsCursor.Create(const Provider: TDBXSybaseASACustomMetaDataReader; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable);
begin
  inherited Create(Provider.Context, TDBXMetaDataCollectionName.ForeignKeyColumns, Columns, Cursor);
  FSchemaName := NullString;
  FTableName := NullString;
  FIndexId := NullIndexId;
end;

destructor TDBXSybaseASACustomMetaDataReader.TDBXSybaseASAForeignKeyColumnsCursor.Destroy;
begin
  FreeAndNil(FOrdinalValue);
  inherited Destroy;
end;

function TDBXSybaseASACustomMetaDataReader.TDBXSybaseASAForeignKeyColumnsCursor.Next: Boolean;
begin
  if not FCursor.Next then
    Exit(False);
  if FOrdinalValue = nil then
    FOrdinalValue := TDBXWritableValue(TDBXValue.CreateValue(TDBXValueType(inherited GetWritableValue(TDBXForeignKeyColumnsIndex.Ordinal).ValueType.Clone())));
  FPrevSchemaName := FSchemaName;
  FPrevTableName := FTableName;
  FPrevIndexId := FIndexId;
  FSchemaName := inherited GetWritableValue(TDBXForeignKeyColumnsIndex.SchemaName).AsString;
  FTableName := inherited GetWritableValue(TDBXForeignKeyColumnsIndex.TableName).AsString;
  if FCursor.Value[ForeignkeyColumnIndexIndicator].IsNull then
    FIndexId := NullIndexId
  else 
    FIndexId := FCursor.Value[ForeignkeyColumnIndexIndicator].AsInt64;
  if (FSchemaName = FPrevSchemaName) and (FTableName = FPrevTableName) and (FIndexId = FPrevIndexId) then
    IncrAfter(FRunningOrdinal)
  else 
    FRunningOrdinal := 1;
  if FIndexId <> NullIndexId then
    FOrdinalValue.AsInt32 := FRunningOrdinal
  else 
    FOrdinalValue.SetNull;
  Result := True;
end;

function TDBXSybaseASACustomMetaDataReader.TDBXSybaseASAForeignKeyColumnsCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  if Ordinal = TDBXForeignKeyColumnsIndex.Ordinal then
    Exit(FOrdinalValue);
  Result := inherited GetWritableValue(Ordinal);
end;

procedure TDBXSybaseASACustomMetaDataReader.SetContext(const Context: TDBXProviderContext);
begin
  inherited SetContext(Context);
  FVendorLibPath := Context.GetVendorProperty(VendorLibPathPropertyName);
  FSupportsNLSDataType := (Context.GetVendorProperty(SupportsNLSDataTypePropertyName) = 'true');
  FIsServerCharsetUTF8 := (Context.GetVendorProperty(IsServerCharsetUTF8PropertyName) = 'true');
  FIsCharUnicode := (Context.GetVendorProperty(IsCharUnicodePropertyName) = 'true');
end;

function TDBXSybaseASAMetaDataReader.AreSchemasSupported: Boolean;
begin
  Result := True;
end;

function TDBXSybaseASAMetaDataReader.GetProductName: string;
begin
  Result := 'Adaptive Server Anywhere';
end;

function TDBXSybaseASAMetaDataReader.GetTableType: string;
begin
  Result := 'BASE';
end;

function TDBXSybaseASAMetaDataReader.GetViewType: string;
begin
  Result := 'VIEW';
end;

function TDBXSybaseASAMetaDataReader.GetSystemTableType: string;
begin
  Result := 'BASE';
end;

function TDBXSybaseASAMetaDataReader.GetSystemViewType: string;
begin
  Result := 'VIEW';
end;

function TDBXSybaseASAMetaDataReader.IsLowerCaseIdentifiersSupported: Boolean;
begin
  Result := True;
end;

function TDBXSybaseASAMetaDataReader.IsSetRowSizeSupported: Boolean;
begin
  Result := True;
end;

function TDBXSybaseASAMetaDataReader.IsUpperCaseIdentifiersSupported: Boolean;
begin
  Result := True;
end;

function TDBXSybaseASAMetaDataReader.FetchCatalogs: TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateCatalogsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Catalogs, Columns);
end;

function TDBXSybaseASAMetaDataReader.GetSqlForSchemas: string;
begin
  Result := 'SELECT DB_NAME(), NAME FROM SYS.SYSUSERLIST WHERE RESOURCEAUTH=''Y'' ORDER BY 1, 2';
end;

function TDBXSybaseASAMetaDataReader.GetSqlForTables: string;
begin
  Result := 'SELECT DB_NAME(), USER_NAME(CREATOR), TABLE_NAME, CASE WHEN USER_NAME(CREATOR) = ''SYS'' OR USER_NAME(CREATOR) = ''rs_systabgroup'' THEN ''SYSTEM '' ELSE '''' END || CASE TABLE_TYPE WHEN ''BASE'' THEN ''TABLE'' ELSE ''VIEW'' END ' +
            'FROM SYS.SYSTABLE ' +
            'WHERE TABLE_TYPE IN (''BASE'',''VIEW'') ' +
            ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(CREATOR) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            ' AND (TABLE_TYPE=CASE WHEN USER_NAME(CREATOR) = ''SYS'' OR USER_NAME(CREATOR) = ''rs_systabgroup'' THEN :SYSTEM_TABLES ELSE :TABLES END OR TABLE_TYPE=CASE WHEN USER_NAME(CREATOR) = ''SYS'' OR USER_NAME(CREATOR) = ''rs_systabgroup'' THEN :SYSTEM_VIEWS ELSE :VIEWS ' + 'END) ' +
            'ORDER BY 1,2,3';
end;

function TDBXSybaseASAMetaDataReader.GetSqlForViews: string;
begin
  Result := 'SELECT DB_NAME(), VCREATOR, VIEWNAME, VIEWTEXT ' +
            'FROM SYS.SYSVIEWS ' +
            'WHERE (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (VCREATOR = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (VIEWNAME = :VIEW_NAME OR (:VIEW_NAME IS NULL)) ' +
            'ORDER BY 1,2,3';
end;

function TDBXSybaseASAMetaDataReader.GetSqlForColumns: string;
begin
  Result := 'SELECT DB_NAME(), USER_NAME(T.CREATOR), T.TABLE_NAME, C.COLUMN_NAME, D.DOMAIN_NAME, C.WIDTH, C.SCALE, C.COLUMN_ID, CASE WHEN C."DEFAULT" = ''autoincrement'' THEN NULL ELSE C."DEFAULT" END, CASE WHEN C.NULLS=''Y'' THEN 1 ELSE 0 END, CASE WHEN C."DEFAULT"=''auto' + 'increment'' THEN 1 ELSE 0 END, NULL ' +
            'FROM SYS.SYSCOLUMN C, SYS.SYSTABLE T, SYS.SYSDOMAIN D ' +
            'WHERE C.TABLE_ID=T.TABLE_ID AND C.DOMAIN_ID=D.DOMAIN_ID ' +
            ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(T.CREATOR) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (T.TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            'ORDER BY 1,2,3,C.COLUMN_ID';
end;

function TDBXSybaseASAMetaDataReader.FetchColumnConstraints(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateColumnConstraintsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.ColumnConstraints, Columns);
end;

function TDBXSybaseASAMetaDataReader.GetSqlForIndexes: string;
var
  CurrentVersion: string;
begin
  CurrentVersion := Version;
  if CurrentVersion >= '10.00.0000' then
    Result := 'SELECT DB_NAME(), USER_NAME(T.CREATOR), T.TABLE_NAME, I.INDEX_NAME, C.CONSTRAINT_NAME, CASE I.INDEX_CATEGORY WHEN 1 THEN 1 ELSE 0 END, CASE WHEN I."UNIQUE" IN (1,2) THEN 1 ELSE 0 END, 1 ' +
              'FROM SYS.SYSIDX I JOIN SYS.SYSTAB T ON I.TABLE_ID=T.TABLE_ID LEFT OUTER JOIN SYS.SYSCONSTRAINT C ON C.TABLE_OBJECT_ID=T.OBJECT_ID AND C.REF_OBJECT_ID=I.OBJECT_ID ' +
              'WHERE I.TABLE_ID=T.TABLE_ID AND I.INDEX_CATEGORY IN (1,3) ' +
              ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(T.CREATOR) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (T.TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
              'ORDER BY 1,2,3,4'
  else 
    Result := 'SELECT DB_NAME(), USER_NAME(T.CREATOR), T.TABLE_NAME, I.INDEX_NAME, C.CONSTRAINT_NAME, 0, CASE WHEN I."UNIQUE" IN (''Y'',''U'') THEN 1 ELSE 0 END, 1 ' +
              'FROM SYS.SYSINDEX I LEFT OUTER JOIN SYS.SYSCONSTRAINT C ON C.TABLE_ID=I.TABLE_ID AND C.INDEX_ID=I.INDEX_ID, SYS.SYSTABLE T ' +
              'WHERE I.TABLE_ID=T.TABLE_ID ' +
              ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(T.CREATOR) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (T.TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
              'UNION ALL ' +
              'SELECT DB_NAME(), USER_NAME(T.CREATOR), T.TABLE_NAME, C.CONSTRAINT_NAME, C.CONSTRAINT_NAME, 1, 1, 1 ' +
              'FROM SYS.SYSCONSTRAINT C, SYS.SYSTABLE T ' +
              'WHERE C.TABLE_ID=T.TABLE_ID AND C.CONSTRAINT_TYPE=''P'' ' +
              ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(T.CREATOR) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (T.TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
              'ORDER BY 1,2,3,4';
end;

function TDBXSybaseASAMetaDataReader.GetSqlForIndexColumns: string;
var
  CurrentVersion: string;
begin
  CurrentVersion := Version;
  if CurrentVersion >= '10.00.0000' then
    Result := 'SELECT DB_NAME(), USER_NAME(T.CREATOR), T.TABLE_NAME, I.INDEX_NAME, C.COLUMN_NAME, IC.SEQUENCE+1, CASE WHEN IC."ORDER"=''A'' THEN 1 ELSE 0 END ' +
              'FROM SYS.SYSIDXCOL IC, SYS.SYSIDX I, SYS.SYSTABCOL C, SYS.SYSTAB T ' +
              'WHERE IC.TABLE_ID=I.TABLE_ID AND IC.INDEX_ID=I.INDEX_ID AND IC.TABLE_ID=T.TABLE_ID AND C.COLUMN_ID=IC.COLUMN_ID AND C.TABLE_ID=T.TABLE_ID  AND I.INDEX_CATEGORY IN (1,3) ' +
              ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(T.CREATOR) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (T.TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (I.INDEX_NAME = :INDEX_NAME OR (:INDEX_NAME IS NULL)) ' +
              'ORDER BY 1,2,3,4,6'
  else 
    Result := 'SELECT DB_NAME(), USER_NAME(T.CREATOR), T.TABLE_NAME, I.INDEX_NAME, C.COLUMN_NAME, IC.SEQUENCE+1, CASE WHEN IC."ORDER"=''A'' THEN 1 ELSE 0 END ' +
              'FROM SYS.SYSIXCOL IC, SYS.SYSINDEX I, SYS.SYSCOLUMN C, SYS.SYSTABLE T ' +
              'WHERE IC.TABLE_ID=I.TABLE_ID AND IC.INDEX_ID=I.INDEX_ID AND IC.TABLE_ID=T.TABLE_ID AND C.COLUMN_ID=IC.COLUMN_ID AND C.TABLE_ID=T.TABLE_ID ' +
              ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(T.CREATOR) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (T.TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (I.INDEX_NAME = :INDEX_NAME OR (:INDEX_NAME IS NULL)) ' +
              'UNION ALL ' +
              'SELECT DB_NAME(), USER_NAME(T.CREATOR), T.TABLE_NAME, SC.CONSTRAINT_NAME, C.COLUMN_NAME, C.COLUMN_ID, 1 ' +
              'FROM SYS.SYSCOLUMN C, SYS.SYSTABLE T, SYS.SYSCONSTRAINT SC ' +
              'WHERE C.TABLE_ID=T.TABLE_ID AND T.TABLE_ID=SC.TABLE_ID AND SC.CONSTRAINT_TYPE=''P'' AND C.PKEY=''Y'' ' +
              ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(T.CREATOR) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (T.TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (SC.CONSTRAINT_NAME = :INDEX_NAME OR (:INDEX_NAME IS NULL)) ' +
              'ORDER BY 1,2,3,4,6';
end;

function TDBXSybaseASAMetaDataReader.GetSqlForForeignKeys: string;
var
  CurrentVersion: string;
begin
  CurrentVersion := Version;
  if CurrentVersion >= '10.00.0000' then
    Result := 'SELECT DB_NAME(), USER_NAME(FT.CREATOR), FT.TABLE_NAME, COALESCE(FKC.CONSTRAINT_NAME,FI.INDEX_NAME) ' +
              'FROM SYS.SYSFKEY FK ' +
              '  JOIN SYS.SYSTABLE FT ON FK.FOREIGN_TABLE_ID=FT.TABLE_ID ' +
              '  JOIN SYS.SYSIDX FI ON FK.FOREIGN_TABLE_ID=FI.TABLE_ID AND FK.FOREIGN_INDEX_ID=FI.INDEX_ID ' +
              '  LEFT JOIN SYS.SYSCONSTRAINT FKC ON FT.OBJECT_ID=FKC.TABLE_OBJECT_ID AND FI.OBJECT_ID=FKC.REF_OBJECT_ID ' +
              'WHERE (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(FT.CREATOR) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (FT.TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
              'ORDER BY 1,2,3,4'
  else 
    Result := 'SELECT DB_NAME(), USER_NAME(FT.CREATOR), FT.TABLE_NAME, FK.ROLE ' +
              'FROM SYS.SYSFOREIGNKEY FK, SYS.SYSTABLE FT ' +
              'WHERE FK.FOREIGN_TABLE_ID=FT.TABLE_ID ' +
              ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(FT.CREATOR) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (FT.TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
              'ORDER BY 1,2,3,4';
end;

function TDBXSybaseASAMetaDataReader.GetSqlForForeignKeyColumns: string;
var
  CurrentVersion: string;
begin
  CurrentVersion := Version;
  if CurrentVersion >= '10.00.0000' then
    Result := 'SELECT DB_NAME(), USER_NAME(FT.CREATOR), FT.TABLE_NAME, COALESCE(FKC.CONSTRAINT_NAME,FI.INDEX_NAME), FC.COLUMN_NAME, DB_NAME(), USER_NAME(PT.CREATOR), PT.TABLE_NAME, COALESCE(PKC.CONSTRAINT_NAME,PI.INDEX_NAME), PC.COLUMN_NAME, FIC.SEQUENCE+1 ' +
              'FROM SYS.SYSFKEY FK ' +
              '  JOIN SYS.SYSTABLE FT ON FK.FOREIGN_TABLE_ID=FT.TABLE_ID ' +
              '  JOIN SYS.SYSTABLE PT ON FK.PRIMARY_TABLE_ID=PT.TABLE_ID ' +
              '  JOIN SYS.SYSIDX FI ON FK.FOREIGN_TABLE_ID=FI.TABLE_ID AND FK.FOREIGN_INDEX_ID=FI.INDEX_ID ' +
              '  JOIN SYS.SYSIDX PI ON FK.PRIMARY_TABLE_ID=PI.TABLE_ID AND FK.PRIMARY_INDEX_ID=PI.INDEX_ID ' +
              '  JOIN SYS.SYSIDXCOL FIC ON FI.TABLE_ID=FIC.TABLE_ID AND FI.INDEX_ID=FIC.INDEX_ID ' +
              '  JOIN SYS.SYSIDXCOL PIC ON PI.TABLE_ID=PIC.TABLE_ID AND PI.INDEX_ID=PIC.INDEX_ID AND PIC.SEQUENCE=FIC.SEQUENCE ' +
              '  JOIN SYS.SYSCOLUMN FC ON FIC.TABLE_ID=FC.TABLE_ID AND FIC.COLUMN_ID=FC.COLUMN_ID ' +
              '  JOIN SYS.SYSCOLUMN PC ON PIC.TABLE_ID=PC.TABLE_ID AND PIC.COLUMN_ID=PC.COLUMN_ID ' +
              '  LEFT JOIN SYS.SYSCONSTRAINT FKC ON FT.OBJECT_ID=FKC.TABLE_OBJECT_ID AND FI.OBJECT_ID=FKC.REF_OBJECT_ID ' +
              '  LEFT JOIN SYS.SYSCONSTRAINT PKC ON PT.OBJECT_ID=PKC.TABLE_OBJECT_ID AND PI.OBJECT_ID=PKC.REF_OBJECT_ID ' +
              'WHERE (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(FT.CREATOR) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (FT.TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (COALESCE(FKC.CONSTRAINT_NAME,FI.INDEX_NAME) = :FOREIGN_KEY_NA' + 'ME OR (:FOREIGN_KEY_NAME IS NULL)) ' +
              ' AND  (DB_NAME() = :PRIMARY_CATALOG_NAME OR (:PRIMARY_CATALOG_NAME IS NULL)) AND (USER_NAME(PT.CREATOR) = :PRIMARY_SCHEMA_NAME OR (:PRIMARY_SCHEMA_NAME IS NULL)) AND (PT.TABLE_NAME = :PRIMARY_TABLE_NAME OR (:PRIMARY_TABLE_NAME IS NULL)) AND (COALESCE(PKC.' + 'CONSTRAINT_NAME,PI.INDEX_NAME) = :PRIMARY_KEY_NAME OR (:PRIMARY_KEY_NAME IS NULL)) ' +
              'ORDER BY 1,2,3,4,11'
  else 
    Result := 'SELECT DB_NAME(), USER_NAME(FT.CREATOR), FT.TABLE_NAME, FK.ROLE, FC.COLUMN_NAME, DB_NAME(), USER_NAME(PT.CREATOR), PT.TABLE_NAME, COALESCE(I.INDEX_NAME,C.CONSTRAINT_NAME), PC.COLUMN_NAME, COALESCE(IC.SEQUENCE+1,PC.COLUMN_ID), I.INDEX_ID ' +
              'FROM SYS.SYSFKCOL FKC ' +
              '  JOIN SYS.SYSFOREIGNKEY FK ON FKC.FOREIGN_TABLE_ID=FK.FOREIGN_TABLE_ID AND FKC.FOREIGN_KEY_ID=FK.FOREIGN_KEY_ID ' +
              '  JOIN SYS.SYSTABLE FT ON FK.FOREIGN_TABLE_ID=FT.TABLE_ID ' +
              '  JOIN SYS.SYSCOLUMN FC ON FT.TABLE_ID=FC.TABLE_ID AND FKC.FOREIGN_COLUMN_ID=FC.COLUMN_ID ' +
              '  JOIN SYS.SYSTABLE PT ON FK.PRIMARY_TABLE_ID=PT.TABLE_ID ' +
              '  JOIN SYS.SYSCOLUMN PC ON PT.TABLE_ID=PC.TABLE_ID AND FKC.PRIMARY_COLUMN_ID=PC.COLUMN_ID ' +
              '  LEFT OUTER JOIN SYS.SYSIXCOL IC ON FK.PRIMARY_TABLE_ID=IC.TABLE_ID AND FK.PRIMARY_INDEX_ID=IC.INDEX_ID AND PC.COLUMN_ID=IC.COLUMN_ID ' +
              '  LEFT OUTER JOIN SYS.SYSINDEX I ON FK.PRIMARY_TABLE_ID=I.TABLE_ID AND FK.PRIMARY_INDEX_ID=I.INDEX_ID ' +
              '  LEFT OUTER JOIN SYS.SYSCONSTRAINT C ON FK.PRIMARY_TABLE_ID=C.TABLE_ID AND C.CONSTRAINT_TYPE=''P'' ' +
              'WHERE (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(FT.CREATOR) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (FT.TABLE_NAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (FK.ROLE = :FOREIGN_KEY_NAME OR (:FOREIGN_KEY_NAME IS NULL)) ' +
              ' AND  (DB_NAME() = :PRIMARY_CATALOG_NAME OR (:PRIMARY_CATALOG_NAME IS NULL)) AND (USER_NAME(PT.CREATOR) = :PRIMARY_SCHEMA_NAME OR (:PRIMARY_SCHEMA_NAME IS NULL)) AND (PT.TABLE_NAME = :PRIMARY_TABLE_NAME OR (:PRIMARY_TABLE_NAME IS NULL)) AND (COALESCE(I.IN' + 'DEX_NAME,C.CONSTRAINT_NAME) = :PRIMARY_KEY_NAME OR (:PRIMARY_KEY_NAME IS NULL)) ' +
              'ORDER BY 1,2,3,4,11';
end;

function TDBXSybaseASAMetaDataReader.FetchSynonyms(const CatalogName: string; const SchemaName: string; const SynonymName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateSynonymsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Synonyms, Columns);
end;

function TDBXSybaseASAMetaDataReader.GetSqlForProcedures: string;
begin
  Result := 'SELECT DB_NAME(), USER_NAME(CREATOR), PROC_NAME, ''PROCEDURE'' ' +
            'FROM SYS.SYSPROCEDURE ' +
            'WHERE (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(CREATOR) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (PROC_NAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) AND (''PROCEDURE'' = :PROCEDURE_TYPE OR (:PROCEDURE_TYPE IS NULL)) ' +
            'ORDER BY 1,2,3';
end;

function TDBXSybaseASAMetaDataReader.GetSqlForProcedureSources: string;
begin
  Result := 'SELECT DB_NAME(), USER_NAME(CREATOR), PROC_NAME, ''PROCEDURE'', PROC_DEFN, NULL ' +
            'FROM SYS.SYSPROCEDURE ' +
            'WHERE (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(CREATOR) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (PROC_NAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) ' +
            'ORDER BY 1,2,3';
end;

function TDBXSybaseASAMetaDataReader.GetSqlForProcedureParameters: string;
begin
  Result := 'SELECT DB_NAME(), USER_NAME(P.CREATOR), P.PROC_NAME, C.PARM_NAME, CASE WHEN PARM_TYPE>0 THEN ''RESULT'' WHEN PARM_MODE_IN=''Y'' AND PARM_MODE_OUT=''Y'' THEN ''INOUT'' WHEN PARM_MODE_OUT=''Y'' THEN ''OUT'' ELSE ''IN'' END, D.DOMAIN_NAME, C.WIDTH, C.SCALE, C.PARM_ID, C."' + 'DEFAULT", 1 ' +
            'FROM SYS.SYSPROCEDURE P, SYS.SYSPROCPARM C, SYS.SYSDOMAIN D ' +
            'WHERE P.PROC_ID = C.PROC_ID AND C.DOMAIN_ID=D.DOMAIN_ID ' +
            ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(P.CREATOR) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (P.PROC_NAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) AND (C.PARM_NAME = :PARAMETER_NAME OR (:PARAMETER_NAME IS NULL' + ')) ' +
            'ORDER BY 1,2,3,C.PARM_ID';
end;

function TDBXSybaseASAMetaDataReader.FetchPackages(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackagesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Packages, Columns);
end;

function TDBXSybaseASAMetaDataReader.FetchPackageProcedures(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ProcedureType: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProceduresColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageProcedures, Columns);
end;

function TDBXSybaseASAMetaDataReader.FetchPackageProcedureParameters(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ParameterName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProcedureParametersColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageProcedureParameters, Columns);
end;

function TDBXSybaseASAMetaDataReader.FetchPackageSources(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageSourcesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageSources, Columns);
end;

function TDBXSybaseASAMetaDataReader.GetSqlForUsers: string;
begin
  Result := 'SELECT NAME FROM SYS.SYSUSERLIST WHERE USER_GROUP=''N'' ORDER BY 1';
end;

function TDBXSybaseASAMetaDataReader.GetSqlForRoles: string;
begin
  Result := 'SELECT NAME FROM SYS.SYSUSERLIST WHERE USER_GROUP=''Y'' AND NAME <> ''PUBLIC'' ORDER BY 1';
end;

function TDBXSybaseASAMetaDataReader.GetDataTypeDescriptions: TDBXDataTypeDescriptionArray;
var
  Types: TDBXDataTypeDescriptionArray;
begin
  SetLength(Types,23);
  Types[0] := TDBXDataTypeDescription.Create('bigint', TDBXDataTypes.Int64Type, 19, 'bigint', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[1] := TDBXDataTypeDescription.Create('binary', TDBXDataTypes.BytesType, 32767, 'binary({0})', 'Precision', -1, -1, '0x', NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[2] := TDBXDataTypeDescription.Create('bit', TDBXDataTypes.BooleanType, 1, 'bit', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Searchable);
  if IsCharUnicode then
    Types[3] := TDBXDataTypeDescription.Create('char', TDBXDataTypes.WideStringType, 8191, 'char({0})', 'Precision', -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.CaseSensitive or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.Unicode)
  else
    Types[3] := TDBXDataTypeDescription.Create('char', TDBXDataTypes.AnsiStringType, 32767, 'char({0})', 'Precision', -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.CaseSensitive or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[4] := TDBXDataTypeDescription.Create('nchar', TDBXDataTypes.WideStringType, 8191, 'nchar({0})', 'Precision', -1, -1, '''', '''', NullString, '10.00.0000', TDBXTypeFlag.CaseSensitive or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.Unicode);
  Types[5] := TDBXDataTypeDescription.Create('date', TDBXDataTypes.DateType, 4, 'date', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[6] := TDBXDataTypeDescription.Create('decimal', TDBXDataTypes.BcdType, 38, 'decimal({0}, {1})', 'Precision,Scale', 38, 0, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[7] := TDBXDataTypeDescription.Create('double', TDBXDataTypes.DoubleType, 53, 'double', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[8] := TDBXDataTypeDescription.Create('float', TDBXDataTypes.SingleType, 48, 'float({0})', 'Precision', -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[9] := TDBXDataTypeDescription.Create('integer', TDBXDataTypes.Int32Type, 10, 'integer', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[10] := TDBXDataTypeDescription.Create('long binary', TDBXDataTypes.BlobType, 2147483647, 'long binary', NullString, -1, -1, '0x', NullString, NullString, NullString, TDBXTypeFlag.Long or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  if IsCharUnicode then
    Types[11] := TDBXDataTypeDescription.Create('long varchar', TDBXDataTypes.WideStringType, 2147483647, 'long varchar', NullString, -1, -1, '0x', NullString, NullString, NullString, TDBXTypeFlag.Long or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.Unicode)
  else
    Types[11] := TDBXDataTypeDescription.Create('long varchar', TDBXDataTypes.AnsiStringType, 2147483647, 'long varchar', NullString, -1, -1, '0x', NullString, NullString, NullString, TDBXTypeFlag.Long or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[12] := TDBXDataTypeDescription.Create('long nvarchar', TDBXDataTypes.WideStringType, 2147483647, 'long nvarchar', NullString, -1, -1, '0x', NullString, NullString, '10.00.0000', TDBXTypeFlag.Long or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.Unicode);
  Types[13] := TDBXDataTypeDescription.Create('numeric', TDBXDataTypes.BcdType, 38, 'numeric({0}, {1})', 'Precision,Scale', 38, 0, NullString, NullString, NullString, NullString, TDBXTypeFlag.AutoIncrementable or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[14] := TDBXDataTypeDescription.Create('smallint', TDBXDataTypes.Int16Type, 5, 'smallint', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[15] := TDBXDataTypeDescription.Create('time', TDBXDataTypes.TimeType, 8, 'time', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[16] := TDBXDataTypeDescription.Create('timestamp', TDBXDataTypes.TimeStampType, 8, 'timestamp', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[17] := TDBXDataTypeDescription.Create('tinyint', TDBXDataTypes.UInt8Type, 1, 'tinyint', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.Unsigned);
  Types[18] := TDBXDataTypeDescription.Create('varbinary', TDBXDataTypes.VarBytesType, 32767, 'varbinary({0})', 'Precision', -1, -1, '0x', NullString, NullString, NullString, TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  if IsCharUnicode then
    Types[19] := TDBXDataTypeDescription.Create('varchar', TDBXDataTypes.WideStringType, 8191, 'varchar({0})', 'Precision', -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.Unicode)
  else
    Types[19] := TDBXDataTypeDescription.Create('varchar', TDBXDataTypes.AnsiStringType, 32767, 'varchar({0})', 'Precision', -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[20] := TDBXDataTypeDescription.Create('nvarchar', TDBXDataTypes.WideStringType, 8191, 'nvarchar({0})', 'Precision', -1, -1, '''', '''', NullString, '10.00.0000', TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.Unicode);
  Types[21] := TDBXDataTypeDescription.Create('xml', TDBXDataTypes.WideStringType,  2147483647, 'xml', NullString, -1, -1, '0x', NullString, NullString, NullString, TDBXTypeFlag.Long or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[22] := TDBXDataTypeDescription.Create('TIMESTAMP WITH TIME ZONE', TDBXDataTypes.TimeStampOffsetType, 34, 'TIMESTAMP({0} WITH TIME ZONE)', 'Precision', -1, -1, '{ts ''', '''}', NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.LiteralSupported);
//  Types[22] := TDBXDataTypeDescription.Create('uniqueidentifierstr', TDBXDataTypes.AnsiStringType, 36,    'char({0})', 'Precision', -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.CaseSensitive or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Result := Types;
end;

function TDBXSybaseASAMetaDataReader.GetReservedWords: TDBXStringArray;
var
  Words: TDBXStringArray;
begin
  SetLength(Words,223);
  Words[0] := 'add';
  Words[1] := 'all';
  Words[2] := 'alter';
  Words[3] := 'and';
  Words[4] := 'any';
  Words[5] := 'as';
  Words[6] := 'asc';
  Words[7] := 'backup';
  Words[8] := 'begin';
  Words[9] := 'between';
  Words[10] := 'bigint';
  Words[11] := 'binary';
  Words[12] := 'bit';
  Words[13] := 'bottom';
  Words[14] := 'break';
  Words[15] := 'by';
  Words[16] := 'call';
  Words[17] := 'capability';
  Words[18] := 'cascade';
  Words[19] := 'case';
  Words[20] := 'cast';
  Words[21] := 'char';
  Words[22] := 'char_convert';
  Words[23] := 'character';
  Words[24] := 'check';
  Words[25] := 'checkpoint';
  Words[26] := 'close';
  Words[27] := 'comment';
  Words[28] := 'commit';
  Words[29] := 'connect';
  Words[30] := 'constraint';
  Words[31] := 'contains';
  Words[32] := 'continue';
  Words[33] := 'convert';
  Words[34] := 'create';
  Words[35] := 'cross';
  Words[36] := 'cube';
  Words[37] := 'current';
  Words[38] := 'current_timestamp';
  Words[39] := 'current_user';
  Words[40] := 'cursor';
  Words[41] := 'date';
  Words[42] := 'dbspace';
  Words[43] := 'deallocate';
  Words[44] := 'dec';
  Words[45] := 'decimal';
  Words[46] := 'declare';
  Words[47] := 'default';
  Words[48] := 'delete';
  Words[49] := 'deleting';
  Words[50] := 'desc';
  Words[51] := 'distinct';
  Words[52] := 'do';
  Words[53] := 'double';
  Words[54] := 'drop';
  Words[55] := 'dynamic';
  Words[56] := 'else';
  Words[57] := 'elseif';
  Words[58] := 'encrypted';
  Words[59] := 'end';
  Words[60] := 'endif';
  Words[61] := 'escape';
  Words[62] := 'except';
  Words[63] := 'exception';
  Words[64] := 'exec';
  Words[65] := 'execute';
  Words[66] := 'existing';
  Words[67] := 'exists';
  Words[68] := 'externlogin';
  Words[69] := 'fetch';
  Words[70] := 'first';
  Words[71] := 'float';
  Words[72] := 'for';
  Words[73] := 'force';
  Words[74] := 'foreign';
  Words[75] := 'forward';
  Words[76] := 'from';
  Words[77] := 'full';
  Words[78] := 'goto';
  Words[79] := 'grant';
  Words[80] := 'group';
  Words[81] := 'having';
  Words[82] := 'holdlock';
  Words[83] := 'identified';
  Words[84] := 'if';
  Words[85] := 'in';
  Words[86] := 'index';
  Words[87] := 'index_lparen';
  Words[88] := 'inner';
  Words[89] := 'inout';
  Words[90] := 'insensitive';
  Words[91] := 'insert';
  Words[92] := 'inserting';
  Words[93] := 'install';
  Words[94] := 'instead';
  Words[95] := 'int';
  Words[96] := 'integer';
  Words[97] := 'integrated';
  Words[98] := 'intersect';
  Words[99] := 'into';
  Words[100] := 'iq';
  Words[101] := 'is';
  Words[102] := 'isolation';
  Words[103] := 'join';
  Words[104] := 'key';
  Words[105] := 'lateral';
  Words[106] := 'left';
  Words[107] := 'like';
  Words[108] := 'lock';
  Words[109] := 'login';
  Words[110] := 'long';
  Words[111] := 'match';
  Words[112] := 'membership';
  Words[113] := 'message';
  Words[114] := 'mode';
  Words[115] := 'modify';
  Words[116] := 'natural';
  Words[117] := 'new';
  Words[118] := 'no';
  Words[119] := 'noholdlock';
  Words[120] := 'not';
  Words[121] := 'notify';
  Words[122] := 'null';
  Words[123] := 'numeric';
  Words[124] := 'of';
  Words[125] := 'off';
  Words[126] := 'on';
  Words[127] := 'open';
  Words[128] := 'option';
  Words[129] := 'options';
  Words[130] := 'or';
  Words[131] := 'order';
  Words[132] := 'others';
  Words[133] := 'out';
  Words[134] := 'outer';
  Words[135] := 'over';
  Words[136] := 'passthrough';
  Words[137] := 'precision';
  Words[138] := 'prepare';
  Words[139] := 'primary';
  Words[140] := 'print';
  Words[141] := 'privileges';
  Words[142] := 'proc';
  Words[143] := 'procedure';
  Words[144] := 'publication';
  Words[145] := 'raiserror';
  Words[146] := 'readtext';
  Words[147] := 'real';
  Words[148] := 'reference';
  Words[149] := 'references';
  Words[150] := 'release';
  Words[151] := 'remote';
  Words[152] := 'remove';
  Words[153] := 'rename';
  Words[154] := 'reorganize';
  Words[155] := 'resource';
  Words[156] := 'restore';
  Words[157] := 'restrict';
  Words[158] := 'return';
  Words[159] := 'revoke';
  Words[160] := 'right';
  Words[161] := 'rollback';
  Words[162] := 'rollup';
  Words[163] := 'save';
  Words[164] := 'savepoint';
  Words[165] := 'scroll';
  Words[166] := 'select';
  Words[167] := 'sensitive';
  Words[168] := 'session';
  Words[169] := 'set';
  Words[170] := 'setuser';
  Words[171] := 'share';
  Words[172] := 'smallint';
  Words[173] := 'some';
  Words[174] := 'sqlcode';
  Words[175] := 'sqlstate';
  Words[176] := 'start';
  Words[177] := 'stop';
  Words[178] := 'subtrans';
  Words[179] := 'subtransaction';
  Words[180] := 'synchronize';
  Words[181] := 'syntax_error';
  Words[182] := 'table';
  Words[183] := 'temporary';
  Words[184] := 'then';
  Words[185] := 'time';
  Words[186] := 'timestamp';
  Words[187] := 'tinyint';
  Words[188] := 'to';
  Words[189] := 'top';
  Words[190] := 'tran';
  Words[191] := 'trigger';
  Words[192] := 'truncate';
  Words[193] := 'tsequal';
  Words[194] := 'unbounded';
  Words[195] := 'union';
  Words[196] := 'unique';
  Words[197] := 'unknown';
  Words[198] := 'unsigned';
  Words[199] := 'update';
  Words[200] := 'updating';
  Words[201] := 'user';
  Words[202] := 'using';
  Words[203] := 'validate';
  Words[204] := 'values';
  Words[205] := 'varbinary';
  Words[206] := 'varchar';
  Words[207] := 'variable';
  Words[208] := 'varying';
  Words[209] := 'view';
  Words[210] := 'wait';
  Words[211] := 'waitfor';
  Words[212] := 'when';
  Words[213] := 'where';
  Words[214] := 'while';
  Words[215] := 'window';
  Words[216] := 'with';
  Words[217] := 'with_cube';
  Words[218] := 'with_lparen';
  Words[219] := 'with_rollup';
  Words[220] := 'within';
  Words[221] := 'work';
  Words[222] := 'writetext';
  Result := Words;
end;

end.

