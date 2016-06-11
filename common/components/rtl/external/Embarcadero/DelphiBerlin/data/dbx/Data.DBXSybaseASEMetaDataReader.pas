{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.DBXSybaseASEMetaDataReader;

interface

uses
  Data.DBXCommon,
  Data.DBXCommonTable,
  Data.DBXMetaDataNames,
  Data.DBXMetaDataReader,
  Data.DBXPlatform;

type
  
  /// <summary>  TDBXAseCustomMetaDataReader contains custom code for Adaptive Server Enterprise.
  /// </summary>
  TDBXSybaseASECustomMetaDataReader = class abstract(TDBXBaseMetaDataReader)
  public
    type
            
      /// <summary>  TDBXSybaseASEForeignKeyColumnsCursor is a filter for a cursor providing foreign key columns.
      /// </summary>
      /// <remarks>  In Adaptive Server Enterprise all the columns of a foreign key relation are given in one row
      ///   of the sysreferences system table.
      ///   This filter will extract them into a separate rows as expected by the foreign key metadata collection.
      ///   Also note: there is a hard limit of 16 sub queries in this database. That is why the foreign key
      ///   columns and the primary key columns are split into 2 queries.
      /// </remarks>
      TDBXSybaseASEForeignKeyColumnsCursor = class(TDBXCustomMetaDataTable)
      public
        destructor Destroy; override;
        function Next: Boolean; override;
      protected
        constructor Create(const Provider: TDBXSybaseASECustomMetaDataReader; const Columns: TDBXValueTypeArray; const Cursor1: TDBXTable; const Cursor2: TDBXTable);
        function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
      private
        FCursor2: TDBXTable;
        FKeyIndex: Integer;
        FKeyColumnCount: Integer;
        FRow: TDBXSingleValueRow;
      private
        const OrdinalKeyColumnCount = TDBXForeignKeyColumnsIndex.Ordinal;
        const OrdinalFirstColumn = TDBXForeignKeyColumnsIndex.Last + 1;
      end;

  public
    
    /// <summary>  Overrides the implementation in TDBXBaseMetaDataProvider.
    /// </summary>
    /// <remarks>  A custom filter is added to extract the column names into separate rows.
    /// </remarks>
    /// <seealso cref="TDBXSybaseAseForeignKeyColumnsCursor"/>
    function FetchForeignKeyColumns(const Catalog: string; const Schema: string; const Table: string; const ForeignKeyName: string; const PrimaryCatalog: string; const PrimarySchema: string; const PrimaryTable: string; const PrimaryKeyName: string): TDBXTable; override;
  protected
    
    /// <summary>  Second part of the foreign key column SQL query.
    /// </summary>
    /// <remarks>  A concrete super class of TDBXSybaseASECustomMetaDataReader must implement this
    ///   property and supply a query that includes the column names of the table being referenced.
    /// </remarks>
    function GetSqlForForeignKeyColumnsPart2: string; virtual; abstract;
  protected
    
    /// <summary>  Second part of the foreign key column SQL query.
    /// </summary>
    /// <remarks>  A concrete super class of TDBXSybaseASECustomMetaDataReader must implement this
    ///   property and supply a query that includes the column names of the table being referenced.
    /// </remarks>
    property SqlForForeignKeyColumnsPart2: string read GetSqlForForeignKeyColumnsPart2;
  end;

  TDBXSybaseASEMetaDataReader = class(TDBXSybaseASECustomMetaDataReader)
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
    function IsLowerCaseIdentifiersSupported: Boolean; override;
    function IsUpperCaseIdentifiersSupported: Boolean; override;
    function IsNestedTransactionsSupported: Boolean; override;
    function GetSqlIdentifierQuoteChar: string; override;
    function GetSqlProcedureQuoteChar: string; override;
    function GetSqlIdentifierQuotePrefix: string; override;
    function GetSqlIdentifierQuoteSuffix: string; override;
    function IsSetRowSizeSupported: Boolean; override;
    function IsParameterMetadataSupported: Boolean; override;
    function GetSqlForSchemas: string; override;
    function GetSqlForTables: string; override;
    function GetSqlForViews: string; override;
    function GetSqlForColumns: string; override;
    function GetSqlForIndexes: string; override;
    function GetSqlForIndexColumns: string; override;
    function GetSqlForForeignKeys: string; override;
    function GetSqlForForeignKeyColumns: string; override;
    function GetSqlForForeignKeyColumnsPart2: string; override;
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

function TDBXSybaseASECustomMetaDataReader.FetchForeignKeyColumns(const Catalog: string; const Schema: string; const Table: string; const ForeignKeyName: string; const PrimaryCatalog: string; const PrimarySchema: string; const PrimaryTable: string; const PrimaryKeyName: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor1, Cursor2: TDBXTable;
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
  Cursor1 := Context.ExecuteQuery(SqlForForeignKeyColumns, ParameterNames, ParameterValues);
  Cursor2 := Context.ExecuteQuery(SqlForForeignKeyColumnsPart2, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateForeignKeyColumnsColumns;
  Result := TDBXSybaseASECustomMetaDataReader.TDBXSybaseASEForeignKeyColumnsCursor.Create(self, Columns, Cursor1, Cursor2);
end;

constructor TDBXSybaseASECustomMetaDataReader.TDBXSybaseASEForeignKeyColumnsCursor.Create(const Provider: TDBXSybaseASECustomMetaDataReader; const Columns: TDBXValueTypeArray; const Cursor1: TDBXTable; const Cursor2: TDBXTable);
begin
  inherited Create(Provider.Context, TDBXMetaDataCollectionName.ForeignKeyColumns, Columns, Cursor1);
  self.FCursor2 := Cursor2;
  FRow := TDBXSingleValueRow.Create;
  FRow.Columns := CopyColumns;
end;

destructor TDBXSybaseASECustomMetaDataReader.TDBXSybaseASEForeignKeyColumnsCursor.Destroy;
begin
  FreeAndNil(FRow);
  FreeAndNil(FCursor2);
  inherited Destroy;
end;

function TDBXSybaseASECustomMetaDataReader.TDBXSybaseASEForeignKeyColumnsCursor.Next: Boolean;
begin
  repeat
    IncrAfter(FKeyIndex);
    if FKeyIndex >= FKeyColumnCount then
    begin
      if not inherited Next then
        Exit(False);
      if not FCursor2.Next then
        Exit(False);
      FKeyIndex := 0;
      FKeyColumnCount := FCursor.Value[OrdinalKeyColumnCount].AsInt32;
    end;
  until FKeyIndex < FKeyColumnCount;
  if FCursor.Value[OrdinalFirstColumn + FKeyIndex].IsNull then
    FRow.Value[TDBXForeignKeyColumnsIndex.ColumnName].SetNull
  else 
    FRow.Value[TDBXForeignKeyColumnsIndex.ColumnName].AsString := FCursor.Value[OrdinalFirstColumn + FKeyIndex].AsString;
  if FCursor2.Value[OrdinalFirstColumn + FKeyIndex].IsNull then
    FRow.Value[TDBXForeignKeyColumnsIndex.PrimaryColumnName].SetNull
  else 
    FRow.Value[TDBXForeignKeyColumnsIndex.PrimaryColumnName].AsString := FCursor2.Value[OrdinalFirstColumn + FKeyIndex].AsString;
  FRow.Value[TDBXForeignKeyColumnsIndex.Ordinal].AsInt32 := FKeyIndex + 1;
  Result := True;
end;

function TDBXSybaseASECustomMetaDataReader.TDBXSybaseASEForeignKeyColumnsCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  case Ordinal of
    TDBXForeignKeyColumnsIndex.ColumnName,
    TDBXForeignKeyColumnsIndex.PrimaryColumnName,
    TDBXForeignKeyColumnsIndex.Ordinal:
      Exit(FRow.Value[Ordinal]);
  end;
  Result := inherited GetWritableValue(Ordinal);
end;

function TDBXSybaseASEMetaDataReader.AreSchemasSupported: Boolean;
begin
  Result := True;
end;

function TDBXSybaseASEMetaDataReader.GetProductName: string;
begin
  Result := 'Sybase SQL Server';
end;

function TDBXSybaseASEMetaDataReader.GetTableType: string;
begin
  Result := 'U';
end;

function TDBXSybaseASEMetaDataReader.GetViewType: string;
begin
  Result := 'V';
end;

function TDBXSybaseASEMetaDataReader.GetSystemTableType: string;
begin
  Result := 'S';
end;

function TDBXSybaseASEMetaDataReader.IsLowerCaseIdentifiersSupported: Boolean;
begin
  Result := True;
end;

function TDBXSybaseASEMetaDataReader.IsUpperCaseIdentifiersSupported: Boolean;
begin
  Result := True;
end;

function TDBXSybaseASEMetaDataReader.IsNestedTransactionsSupported: Boolean;
begin
  Result := True;
end;

function TDBXSybaseASEMetaDataReader.GetSqlIdentifierQuoteChar: string;
begin
  Result := '';
end;

function TDBXSybaseASEMetaDataReader.GetSqlProcedureQuoteChar: string;
begin
  Result := '';
end;

function TDBXSybaseASEMetaDataReader.GetSqlIdentifierQuotePrefix: string;
begin
  Result := '';
end;

function TDBXSybaseASEMetaDataReader.GetSqlIdentifierQuoteSuffix: string;
begin
  Result := '';
end;

function TDBXSybaseASEMetaDataReader.IsSetRowSizeSupported: Boolean;
begin
  Result := True;
end;

function TDBXSybaseASEMetaDataReader.IsParameterMetadataSupported: Boolean;
begin
  Result := True;
end;

function TDBXSybaseASEMetaDataReader.FetchCatalogs: TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateCatalogsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Catalogs, Columns);
end;

function TDBXSybaseASEMetaDataReader.GetSqlForSchemas: string;
begin
  Result := 'SELECT DISTINCT DB_NAME(), USER_NAME(uid) ' +
            'FROM  dbo.sysobjects ' +
            'WHERE type IN (''U'', ''V'', ''S'', ''P'', ''FN'', ''IF'', ''TF'') ' +
            'ORDER BY 1, 2';
end;

function TDBXSybaseASEMetaDataReader.GetSqlForTables: string;
begin
  Result := 'SELECT DB_NAME(), USER_NAME(uid), name, CASE WHEN type=''U'' THEN ''TABLE'' WHEN type=''V'' THEN ''VIEW'' ELSE ''SYSTEM TABLE'' END ' +
            'FROM  dbo.sysobjects ' +
            'WHERE type IN (''U'', ''V'', ''S'') ' +
            ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(uid) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (name = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            ' AND  (type = :TABLES OR type = :VIEWS OR type = :SYSTEM_TABLES) ' +
            'ORDER BY 1, 2, 3';
end;

function TDBXSybaseASEMetaDataReader.GetSqlForViews: string;
begin
  Result := 'SELECT DB_NAME(), USER_NAME(uid), name, text, colid AS SOURCE_LINE_NUMBER ' +
            'FROM dbo.sysobjects o, dbo.syscomments c ' +
            'WHERE o.id = c.id AND type = ''V'' ' +
            ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(uid) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (name = :VIEW_NAME OR (:VIEW_NAME IS NULL)) ' +
            'ORDER BY 1,2,3,5';
end;

function TDBXSybaseASEMetaDataReader.GetSqlForColumns: string;
begin
  Result := 'SELECT DB_NAME(), USER_NAME(o.uid), o.name, c.name, CASE WHEN t.name=''float'' THEN ''double precision'' ELSE t.name END, COALESCE(c.prec,c.length), c.scale, c.colid, CASE WHEN com.text LIKE ''DEFAULT  %'' THEN SUBSTRING(com.text,10,CHAR_LENGTH(com.text)-9) ELS' + 'E com.text END, c.status & 8, c.status & 128, NULL ' +
            'FROM dbo.sysobjects o INNER JOIN dbo.syscolumns c ON o.id=c.id INNER JOIN dbo.systypes t ON c.usertype = t.usertype LEFT OUTER JOIN dbo.syscomments com ON cdefault=com.id ' +
            'WHERE o.type IN (''U'',''V'',''S'') ' +
            ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(o.uid) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (o.name = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            'ORDER BY 1, 2, 3, c.colid';
end;

function TDBXSybaseASEMetaDataReader.FetchColumnConstraints(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateColumnConstraintsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.ColumnConstraints, Columns);
end;

function TDBXSybaseASEMetaDataReader.GetSqlForIndexes: string;
begin
  Result := 'SELECT DB_NAME(), USER_NAME(o.uid), o.name, i.name, CASE WHEN status&2 > 0 THEN i.name ELSE NULL END, status&2048, status&2, 1 ' +
            'FROM dbo.sysobjects o, dbo.sysindexes i ' +
            'WHERE o.type IN (''U'',''S'') AND i.id = o.id and keycnt <> 0 ' +
            ' AND (DB_NAME() = :CATALOG_NAME or (:CATALOG_NAME IS NULL)) AND (USER_NAME(o.uid) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (o.name = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            'ORDER BY 1, 2, 3, 4';
end;

function TDBXSybaseASEMetaDataReader.GetSqlForIndexColumns: string;
begin
  Result := 'SELECT DB_NAME(), USER_NAME(o.uid), o.name, i.name, index_col(o.name, i.indid, cn.id, o.uid), cn.id, CASE WHEN index_colorder(o.name, i.indid, cn.id, o.uid) = ''ASC'' THEN 1 ELSE 0 END ' +
            'FROM dbo.sysobjects o, dbo.sysindexes i, dbo.sysobjects cn ' +
            'WHERE o.type IN (''U'',''S'') AND i.id = o.id AND cn.id > 0 AND cn.id <= i.keycnt - CASE WHEN i.indid=1 THEN 0 ELSE 1 END ' +
            ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(o.uid) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (o.name = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (i.name = :INDEX_NAME OR (:INDEX_NAME IS NULL)) ' +
            'ORDER BY 1, 2, 3, 4, 6';
end;

function TDBXSybaseASEMetaDataReader.GetSqlForForeignKeys: string;
begin
  Result := 'SELECT DB_NAME(), USER_NAME(ft.uid), ft.name, fk.name ' +
            'FROM dbo.sysreferences r, dbo.sysobjects fk, dbo.sysobjects ft ' +
            'WHERE r.tableid=ft.id AND r.constrid=fk.id ' +
            ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(ft.uid) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (ft.name = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            'ORDER BY 1, 2, 3, 4';
end;

function TDBXSybaseASEMetaDataReader.GetSqlForForeignKeyColumns: string;
begin
  Result := 'SELECT DB_NAME(), USER_NAME(ft.uid), ft.name, fk.name, NULL, DB_NAME(), USER_NAME(pt.uid), pt.name, pi.name, NULL, r.keycnt, ' +
            '   CASE WHEN r.fokey1=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=ft.id AND c.colid=r.fokey1) END, ' +
            '   CASE WHEN r.fokey2=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=ft.id AND c.colid=r.fokey2) END, ' +
            '   CASE WHEN r.fokey3=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=ft.id AND c.colid=r.fokey3) END, ' +
            '   CASE WHEN r.fokey4=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=ft.id AND c.colid=r.fokey4) END, ' +
            '   CASE WHEN r.fokey5=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=ft.id AND c.colid=r.fokey5) END, ' +
            '   CASE WHEN r.fokey6=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=ft.id AND c.colid=r.fokey6) END, ' +
            '   CASE WHEN r.fokey7=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=ft.id AND c.colid=r.fokey7) END, ' +
            '   CASE WHEN r.fokey8=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=ft.id AND c.colid=r.fokey8) END, ' +
            '   CASE WHEN r.fokey9=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=ft.id AND c.colid=r.fokey9) END, ' +
            '   CASE WHEN r.fokey10=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=ft.id AND c.colid=r.fokey10) END, ' +
            '   CASE WHEN r.fokey11=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=ft.id AND c.colid=r.fokey11) END, ' +
            '   CASE WHEN r.fokey12=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=ft.id AND c.colid=r.fokey12) END, ' +
            '   CASE WHEN r.fokey13=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=ft.id AND c.colid=r.fokey13) END, ' +
            '   CASE WHEN r.fokey14=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=ft.id AND c.colid=r.fokey14) END, ' +
            '   CASE WHEN r.fokey15=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=ft.id AND c.colid=r.fokey15) END, ' +
            '   CASE WHEN r.fokey16=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=ft.id AND c.colid=r.fokey16) END ' +
            'FROM dbo.sysreferences r, dbo.sysobjects fk, dbo.sysobjects ft, dbo.sysobjects pt, dbo.sysindexes pi ' +
            'WHERE r.tableid=ft.id AND r.constrid=fk.id AND r.reftabid=pt.id AND r.reftabid=pi.id AND r.indexid=pi.indid ' +
            ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(ft.uid) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (ft.name = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (fk.name = :FOREIGN_KEY_NAME OR (:FOREIGN_KEY_NAME IS NULL)) ' +
            ' AND (DB_NAME() = :PRIMARY_CATALOG_NAME OR (:PRIMARY_CATALOG_NAME IS NULL)) AND (USER_NAME(pt.uid) = :PRIMARY_SCHEMA_NAME OR (:PRIMARY_SCHEMA_NAME IS NULL)) AND (pt.name = :PRIMARY_TABLE_NAME OR (:PRIMARY_TABLE_NAME IS NULL)) AND (pi.name = :PRIMARY_KEY_N' + 'AME OR (:PRIMARY_KEY_NAME IS NULL)) ' +
            'ORDER BY 1, 2, 3, 4';
end;

function TDBXSybaseASEMetaDataReader.GetSqlForForeignKeyColumnsPart2: string;
begin
  Result := 'SELECT DB_NAME(), USER_NAME(ft.uid), ft.name, fk.name, NULL, DB_NAME(), USER_NAME(pt.uid), pt.name, pi.name, NULL, r.keycnt, ' +
            '   CASE WHEN r.refkey1=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=pt.id AND c.colid=r.refkey1) END, ' +
            '   CASE WHEN r.refkey2=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=pt.id AND c.colid=r.refkey2) END, ' +
            '   CASE WHEN r.refkey3=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=pt.id AND c.colid=r.refkey3) END, ' +
            '   CASE WHEN r.refkey4=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=pt.id AND c.colid=r.refkey4) END, ' +
            '   CASE WHEN r.refkey5=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=pt.id AND c.colid=r.refkey5) END, ' +
            '   CASE WHEN r.refkey6=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=pt.id AND c.colid=r.refkey6) END, ' +
            '   CASE WHEN r.refkey7=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=pt.id AND c.colid=r.refkey7) END, ' +
            '   CASE WHEN r.refkey8=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=pt.id AND c.colid=r.refkey8) END, ' +
            '   CASE WHEN r.refkey9=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=pt.id AND c.colid=r.refkey9) END, ' +
            '   CASE WHEN r.refkey10=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=pt.id AND c.colid=r.refkey10) END, ' +
            '   CASE WHEN r.refkey11=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=pt.id AND c.colid=r.refkey11) END, ' +
            '   CASE WHEN r.refkey12=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=pt.id AND c.colid=r.refkey12) END, ' +
            '   CASE WHEN r.refkey13=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=pt.id AND c.colid=r.refkey13) END, ' +
            '   CASE WHEN r.refkey14=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=pt.id AND c.colid=r.refkey14) END, ' +
            '   CASE WHEN r.refkey15=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=pt.id AND c.colid=r.refkey15) END, ' +
            '   CASE WHEN r.refkey16=0 THEN NULL ELSE (SELECT c.name from dbo.syscolumns c where c.id=pt.id AND c.colid=r.refkey16) END ' +
            'FROM dbo.sysreferences r, dbo.sysobjects fk, dbo.sysobjects ft, dbo.sysobjects pt, dbo.sysindexes pi ' +
            'WHERE r.tableid=ft.id AND r.constrid=fk.id AND r.reftabid=pt.id AND r.reftabid=pi.id AND r.indexid=pi.indid ' +
            ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(ft.uid) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (ft.name = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (fk.name = :FOREIGN_KEY_NAME OR (:FOREIGN_KEY_NAME IS NULL)) ' +
            ' AND (DB_NAME() = :PRIMARY_CATALOG_NAME OR (:PRIMARY_CATALOG_NAME IS NULL)) AND (USER_NAME(pt.uid) = :PRIMARY_SCHEMA_NAME OR (:PRIMARY_SCHEMA_NAME IS NULL)) AND (pt.name = :PRIMARY_TABLE_NAME OR (:PRIMARY_TABLE_NAME IS NULL)) AND (pi.name = :PRIMARY_KEY_N' + 'AME OR (:PRIMARY_KEY_NAME IS NULL)) ' +
            'ORDER BY 1, 2, 3, 4';
end;

function TDBXSybaseASEMetaDataReader.FetchSynonyms(const CatalogName: string; const SchemaName: string; const SynonymName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateSynonymsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Synonyms, Columns);
end;

function TDBXSybaseASEMetaDataReader.GetSqlForProcedures: string;
begin
  Result := 'SELECT DB_NAME(), USER_NAME(uid), name, CASE WHEN type=''F'' THEN ''FUNCTION'' ELSE ''PROCEDURE'' END ' +
            'FROM dbo.sysobjects ' +
            'WHERE type in (''P'', ''F'', ''XP'') ' +
            ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(uid) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (name = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) AND (CASE WHEN type=''F'' THEN ''FUNCTION'' ELSE ''PROCEDURE'' END = :PROCEDURE_T' + 'YPE OR (:PROCEDURE_TYPE IS NULL)) ' +
            'ORDER BY 1,2,3';
end;

function TDBXSybaseASEMetaDataReader.GetSqlForProcedureSources: string;
begin
  Result := 'SELECT DB_NAME(), USER_NAME(uid), name, CASE WHEN type=''F'' THEN ''FUNCTION'' ELSE ''PROCEDURE'' END, text, NULL, colid AS SOURCE_LINE_NUMBER ' +
            'FROM dbo.sysobjects o, dbo.syscomments c ' +
            'WHERE o.id = c.id AND type IN (''P'',''F'',''XP'') ' +
            ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(o.uid) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (o.name = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) ' +
            'ORDER BY 1,2,3,colid';
end;

function TDBXSybaseASEMetaDataReader.GetSqlForProcedureParameters: string;
begin
  Result := 'SELECT DB_NAME(), USER_NAME(o.uid), o.name, c.name, case c.status2 when 2 then ''OUT'' else ''IN'' end, CASE WHEN t.name=''float'' THEN ''double precision'' ELSE t.name END, COALESCE(c.prec,c.length), c.scale, c.colid, 1 ' +
            'FROM dbo.sysobjects o, dbo.syscolumns c, dbo.systypes t ' +
            'WHERE o.id = c.id AND o.type IN (''P'',''F'',''XP'') AND t.usertype = c.usertype ' +
            ' AND (DB_NAME() = :CATALOG_NAME OR (:CATALOG_NAME IS NULL)) AND (USER_NAME(o.uid) = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (o.name = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) AND (c.name = :PARAMETER_NAME OR (:PARAMETER_NAME IS NULL)) ' +
            'ORDER BY 1,2,3,c.colid';
end;

function TDBXSybaseASEMetaDataReader.FetchPackages(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackagesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Packages, Columns);
end;

function TDBXSybaseASEMetaDataReader.FetchPackageProcedures(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ProcedureType: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProceduresColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageProcedures, Columns);
end;

function TDBXSybaseASEMetaDataReader.FetchPackageProcedureParameters(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ParameterName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProcedureParametersColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageProcedureParameters, Columns);
end;

function TDBXSybaseASEMetaDataReader.FetchPackageSources(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageSourcesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageSources, Columns);
end;

function TDBXSybaseASEMetaDataReader.GetSqlForUsers: string;
begin
  Result := 'SELECT name FROM dbo.sysusers WHERE uid > 0 AND suid >= -1';
end;

function TDBXSybaseASEMetaDataReader.GetSqlForRoles: string;
begin
  Result := 'SELECT name FROM dbo.sysusers WHERE suid < -10';
end;

function TDBXSybaseASEMetaDataReader.GetDataTypeDescriptions: TDBXDataTypeDescriptionArray;
var
  Types: TDBXDataTypeDescriptionArray;
begin
  SetLength(Types,29);
  Types[0] := TDBXDataTypeDescription.Create('binary', TDBXDataTypes.BytesType, 1960, 'binary({0})', 'Precision', -1, -1, '0x', NullString, '12.04.9999', NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[1] := TDBXDataTypeDescription.Create('binary', TDBXDataTypes.BytesType, 7960, 'binary({0})', 'Precision', -1, -1, '0x', NullString, NullString, '12.05.0000', TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[2] := TDBXDataTypeDescription.Create('bit', TDBXDataTypes.BooleanType, 1, 'bit', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Searchable);
  Types[3] := TDBXDataTypeDescription.Create('char', TDBXDataTypes.AnsiStringType, 1960, 'char({0})', 'Precision', -1, -1, '''', '''', '12.04.9999', NullString, TDBXTypeFlag.CaseSensitive or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[4] := TDBXDataTypeDescription.Create('char', TDBXDataTypes.AnsiStringType, 7960, 'char({0})', 'Precision', -1, -1, '''', '''', NullString, '12.05.0000', TDBXTypeFlag.CaseSensitive or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[5] := TDBXDataTypeDescription.Create('datetime', TDBXDataTypes.TimeStampType, 23, 'datetime', NullString, -1, -1, '{ts ''', '''}', NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[6] := TDBXDataTypeDescription.Create('decimal', TDBXDataTypes.BcdType, 38, 'decimal({0}, {1})', 'Precision,Scale', 38, 0, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[7] := TDBXDataTypeDescription.Create('double precision', TDBXDataTypes.DoubleType, 53, 'double precision', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[8] := TDBXDataTypeDescription.Create('image', TDBXDataTypes.BlobType, 2147483647, 'image', NullString, -1, -1, '0x', NullString, NullString, NullString, TDBXTypeFlag.Long or TDBXTypeFlag.Nullable);
  Types[9] := TDBXDataTypeDescription.Create('int', TDBXDataTypes.Int32Type, 10, 'int', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[10] := TDBXDataTypeDescription.Create('money', TDBXDataTypes.BcdType, 19, 'money', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[11] := TDBXDataTypeDescription.Create('numeric', TDBXDataTypes.BcdType, 38, 'numeric({0}, {1})', 'Precision,Scale', 38, 0, NullString, NullString, NullString, NullString, TDBXTypeFlag.AutoIncrementable or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[12] := TDBXDataTypeDescription.Create('unichar', TDBXDataTypes.WideStringType, 960, 'unichar({0})', 'Precision', -1, -1, 'N''', '''', '12.04.9999', NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.Unicode);
  Types[13] := TDBXDataTypeDescription.Create('unichar', TDBXDataTypes.WideStringType, 3960, 'unichar({0})', 'Precision', -1, -1, 'N''', '''', NullString, '12.05.0000', TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.Unicode);
  Types[14] := TDBXDataTypeDescription.Create('univarchar', TDBXDataTypes.WideStringType, 960, 'univarchar({0})', 'Precision', -1, -1, 'N''', '''', '12.04.9999', NullString, TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.Unicode);
  Types[15] := TDBXDataTypeDescription.Create('univarchar', TDBXDataTypes.WideStringType, 3960, 'univarchar({0})', 'Precision', -1, -1, 'N''', '''', NullString, '12.05.0000', TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike or TDBXTypeFlag.Unicode);
  Types[16] := TDBXDataTypeDescription.Create('real', TDBXDataTypes.SingleType, 7, 'real', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[17] := TDBXDataTypeDescription.Create('smalldatetime', TDBXDataTypes.TimeStampType, 16, 'smalldatetime', NullString, -1, -1, '{ts ''', '''}', NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[18] := TDBXDataTypeDescription.Create('smallint', TDBXDataTypes.Int16Type, 5, 'smallint', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[19] := TDBXDataTypeDescription.Create('smallmoney', TDBXDataTypes.BcdType, 10, 'smallmoney', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[20] := TDBXDataTypeDescription.Create('sysname', TDBXDataTypes.AnsiStringType, 30, 'sysname', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.CaseSensitive or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[21] := TDBXDataTypeDescription.Create('text', TDBXDataTypes.AnsiStringType, 2147483647, 'text', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.Long or TDBXTypeFlag.Nullable);
  Types[22] := TDBXDataTypeDescription.Create('unitext', TDBXDataTypes.WideStringType, 1073741823, 'unitext', NullString, -1, -1, '''', '''', NullString, '15.00.0000', TDBXTypeFlag.Long or TDBXTypeFlag.Nullable or TDBXTypeFlag.Unicode);
  Types[23] := TDBXDataTypeDescription.Create('timestamp', TDBXDataTypes.BytesType, 8, 'timestamp', NullString, -1, -1, '0x', NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Searchable);
  Types[24] := TDBXDataTypeDescription.Create('tinyint', TDBXDataTypes.UInt8Type, 3, 'tinyint', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.Unsigned);
  Types[25] := TDBXDataTypeDescription.Create('varbinary', TDBXDataTypes.VarBytesType, 1960, 'varbinary({0})', 'Precision', -1, -1, '0x', NullString, '12.04.9999', NullString, TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[26] := TDBXDataTypeDescription.Create('varbinary', TDBXDataTypes.VarBytesType, 7960, 'varbinary({0})', 'Precision', -1, -1, '0x', NullString, NullString, '12.05.0000', TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[27] := TDBXDataTypeDescription.Create('varchar', TDBXDataTypes.AnsiStringType, 1960, 'varchar({0})', 'Precision', -1, -1, '''', '''', '12.04.9999', NullString, TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[28] := TDBXDataTypeDescription.Create('varchar', TDBXDataTypes.AnsiStringType, 7960, 'varchar({0})', 'Precision', -1, -1, '''', '''', NullString, '12.05.0000', TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Result := Types;
end;

function TDBXSybaseASEMetaDataReader.GetReservedWords: TDBXStringArray;
var
  Words: TDBXStringArray;
begin
  SetLength(Words,322);
  Words[0] := 'absolute';
  Words[1] := 'action';
  Words[2] := 'add';
  Words[3] := 'all';
  Words[4] := 'allocate';
  Words[5] := 'alter';
  Words[6] := 'and';
  Words[7] := 'any';
  Words[8] := 'are';
  Words[9] := 'arith_overflow';
  Words[10] := 'as';
  Words[11] := 'asc';
  Words[12] := 'assertion';
  Words[13] := 'at';
  Words[14] := 'authorization';
  Words[15] := 'avg';
  Words[16] := 'begin';
  Words[17] := 'between';
  Words[18] := 'bit';
  Words[19] := 'bit_length';
  Words[20] := 'both';
  Words[21] := 'break';
  Words[22] := 'browse';
  Words[23] := 'bulk';
  Words[24] := 'by';
  Words[25] := 'cascade';
  Words[26] := 'cascaded';
  Words[27] := 'case';
  Words[28] := 'cast';
  Words[29] := 'catalog';
  Words[30] := 'char';
  Words[31] := 'char_convert';
  Words[32] := 'char_length';
  Words[33] := 'character';
  Words[34] := 'character_length';
  Words[35] := 'check';
  Words[36] := 'checkpoint';
  Words[37] := 'close';
  Words[38] := 'clustered';
  Words[39] := 'coalesce';
  Words[40] := 'collate';
  Words[41] := 'collation';
  Words[42] := 'column';
  Words[43] := 'commit';
  Words[44] := 'compute';
  Words[45] := 'confirm';
  Words[46] := 'connect';
  Words[47] := 'connection';
  Words[48] := 'constraint';
  Words[49] := 'constraints';
  Words[50] := 'continue';
  Words[51] := 'controlrow';
  Words[52] := 'convert';
  Words[53] := 'corresponding';
  Words[54] := 'count';
  Words[55] := 'create';
  Words[56] := 'cross';
  Words[57] := 'current';
  Words[58] := 'current_date';
  Words[59] := 'current_time';
  Words[60] := 'current_timestamp';
  Words[61] := 'current_user';
  Words[62] := 'cursor';
  Words[63] := 'database';
  Words[64] := 'date';
  Words[65] := 'day';
  Words[66] := 'dbcc';
  Words[67] := 'deallocate';
  Words[68] := 'dec';
  Words[69] := 'decimal';
  Words[70] := 'declare';
  Words[71] := 'default';
  Words[72] := 'deferrable';
  Words[73] := 'deferred';
  Words[74] := 'delete';
  Words[75] := 'desc';
  Words[76] := 'describe';
  Words[77] := 'descriptor';
  Words[78] := 'deterministic';
  Words[79] := 'diagnostics';
  Words[80] := 'disconnect';
  Words[81] := 'disk';
  Words[82] := 'distinct';
  Words[83] := 'domain';
  Words[84] := 'double';
  Words[85] := 'drop';
  Words[86] := 'dummy';
  Words[87] := 'dump';
  Words[88] := 'else';
  Words[89] := 'end';
  Words[90] := 'end-exec';
  Words[91] := 'endtran';
  Words[92] := 'errlvl';
  Words[93] := 'errordata';
  Words[94] := 'errorexit';
  Words[95] := 'escape';
  Words[96] := 'except';
  Words[97] := 'exception';
  Words[98] := 'exclusive';
  Words[99] := 'exec';
  Words[100] := 'execute';
  Words[101] := 'exists';
  Words[102] := 'exit';
  Words[103] := 'exp_row_size';
  Words[104] := 'external';
  Words[105] := 'extract';
  Words[106] := 'false';
  Words[107] := 'fetch';
  Words[108] := 'fillfactor';
  Words[109] := 'first';
  Words[110] := 'float';
  Words[111] := 'for';
  Words[112] := 'foreign';
  Words[113] := 'found';
  Words[114] := 'from';
  Words[115] := 'full';
  Words[116] := 'func';
  Words[117] := 'get';
  Words[118] := 'global';
  Words[119] := 'go';
  Words[120] := 'goto';
  Words[121] := 'grant';
  Words[122] := 'group';
  Words[123] := 'having';
  Words[124] := 'holdlock';
  Words[125] := 'hour';
  Words[126] := 'identity';
  Words[127] := 'identity_gap';
  Words[128] := 'identity_insert';
  Words[129] := 'identity_start';
  Words[130] := 'if';
  Words[131] := 'immediate';
  Words[132] := 'in';
  Words[133] := 'index';
  Words[134] := 'indicator';
  Words[135] := 'initially';
  Words[136] := 'inner';
  Words[137] := 'inout';
  Words[138] := 'input';
  Words[139] := 'insensitive';
  Words[140] := 'insert';
  Words[141] := 'install';
  Words[142] := 'int';
  Words[143] := 'integer';
  Words[144] := 'intersect';
  Words[145] := 'interval';
  Words[146] := 'into';
  Words[147] := 'is';
  Words[148] := 'isolation';
  Words[149] := 'jar';
  Words[150] := 'join';
  Words[151] := 'key';
  Words[152] := 'kill';
  Words[153] := 'language';
  Words[154] := 'last';
  Words[155] := 'leading';
  Words[156] := 'left';
  Words[157] := 'level';
  Words[158] := 'like';
  Words[159] := 'lineno';
  Words[160] := 'load';
  Words[161] := 'local';
  Words[162] := 'lock';
  Words[163] := 'lower';
  Words[164] := 'match';
  Words[165] := 'max';
  Words[166] := 'max_rows_per_page';
  Words[167] := 'min';
  Words[168] := 'minute';
  Words[169] := 'mirror';
  Words[170] := 'mirrorexit';
  Words[171] := 'modify';
  Words[172] := 'module';
  Words[173] := 'month';
  Words[174] := 'names';
  Words[175] := 'national';
  Words[176] := 'natural';
  Words[177] := 'nchar';
  Words[178] := 'new';
  Words[179] := 'next';
  Words[180] := 'no';
  Words[181] := 'noholdlock';
  Words[182] := 'nonclustered';
  Words[183] := 'not';
  Words[184] := 'null';
  Words[185] := 'nullif';
  Words[186] := 'numeric';
  Words[187] := 'numeric_truncation';
  Words[188] := 'octet_length';
  Words[189] := 'of';
  Words[190] := 'off';
  Words[191] := 'offsets';
  Words[192] := 'on';
  Words[193] := 'once';
  Words[194] := 'online';
  Words[195] := 'only';
  Words[196] := 'open';
  Words[197] := 'option';
  Words[198] := 'or';
  Words[199] := 'order';
  Words[200] := 'out';
  Words[201] := 'outer';
  Words[202] := 'output';
  Words[203] := 'over';
  Words[204] := 'overlaps';
  Words[205] := 'pad';
  Words[206] := 'partial';
  Words[207] := 'partition';
  Words[208] := 'perm';
  Words[209] := 'permanent';
  Words[210] := 'plan';
  Words[211] := 'position';
  Words[212] := 'precision';
  Words[213] := 'prepare';
  Words[214] := 'preserve';
  Words[215] := 'primary';
  Words[216] := 'print';
  Words[217] := 'prior';
  Words[218] := 'privileges';
  Words[219] := 'proc';
  Words[220] := 'procedure';
  Words[221] := 'processexit';
  Words[222] := 'proxy_table';
  Words[223] := 'public';
  Words[224] := 'quiesce';
  Words[225] := 'raiserror';
  Words[226] := 'read';
  Words[227] := 'readpast';
  Words[228] := 'readtext';
  Words[229] := 'real';
  Words[230] := 'reconfigure';
  Words[231] := 'references remove';
  Words[232] := 'relative';
  Words[233] := 'reorg';
  Words[234] := 'replace';
  Words[235] := 'replication';
  Words[236] := 'reservepagegap';
  Words[237] := 'restrict';
  Words[238] := 'return';
  Words[239] := 'returns';
  Words[240] := 'revoke';
  Words[241] := 'right';
  Words[242] := 'role';
  Words[243] := 'rollback';
  Words[244] := 'rowcount';
  Words[245] := 'rows';
  Words[246] := 'rule';
  Words[247] := 'save';
  Words[248] := 'schema';
  Words[249] := 'scroll';
  Words[250] := 'second';
  Words[251] := 'section';
  Words[252] := 'select';
  Words[253] := 'session_user';
  Words[254] := 'set';
  Words[255] := 'setuser';
  Words[256] := 'shared';
  Words[257] := 'shutdown';
  Words[258] := 'size';
  Words[259] := 'smallint';
  Words[260] := 'some';
  Words[261] := 'space';
  Words[262] := 'sql';
  Words[263] := 'sqlcode';
  Words[264] := 'sqlerror';
  Words[265] := 'sqlstate';
  Words[266] := 'statistics';
  Words[267] := 'stringsize';
  Words[268] := 'stripe';
  Words[269] := 'substring';
  Words[270] := 'sum';
  Words[271] := 'syb_identity';
  Words[272] := 'syb_restree';
  Words[273] := 'syb_terminate';
  Words[274] := 'system_user';
  Words[275] := 'table';
  Words[276] := 'temp';
  Words[277] := 'temporary';
  Words[278] := 'textsize';
  Words[279] := 'then';
  Words[280] := 'time';
  Words[281] := 'timestamp';
  Words[282] := 'timezone_hour';
  Words[283] := 'timezone_minute';
  Words[284] := 'to';
  Words[285] := 'trailing';
  Words[286] := 'tran';
  Words[287] := 'transaction';
  Words[288] := 'translate';
  Words[289] := 'translation';
  Words[290] := 'trigger';
  Words[291] := 'trim';
  Words[292] := 'true';
  Words[293] := 'truncate';
  Words[294] := 'tsequal';
  Words[295] := 'union';
  Words[296] := 'unique';
  Words[297] := 'unknown';
  Words[298] := 'unpartition';
  Words[299] := 'update';
  Words[300] := 'upper';
  Words[301] := 'usage';
  Words[302] := 'use';
  Words[303] := 'user';
  Words[304] := 'user_option';
  Words[305] := 'using';
  Words[306] := 'value';
  Words[307] := 'values';
  Words[308] := 'varchar';
  Words[309] := 'varying';
  Words[310] := 'view';
  Words[311] := 'waitfor';
  Words[312] := 'when';
  Words[313] := 'whenever';
  Words[314] := 'where';
  Words[315] := 'while';
  Words[316] := 'with';
  Words[317] := 'work';
  Words[318] := 'write';
  Words[319] := 'writetext';
  Words[320] := 'year';
  Words[321] := 'zone';
  Result := Words;
end;

end.

