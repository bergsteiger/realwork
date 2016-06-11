{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.DBXDb2MetaDataReader;

interface

uses
  Data.DBXCommonTable,
  Data.DBXMetaDataReader,
  Data.DBXPlatform;

type
  TDBXDb2MetaDataReader = class(TDBXBaseMetaDataReader)
  public
    function FetchCatalogs: TDBXTable; override;
    function FetchColumnConstraints(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable; override;
    function FetchPackages(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable; override;
    function FetchPackageProcedures(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ProcedureType: string): TDBXTable; override;
    function FetchPackageProcedureParameters(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ParameterName: string): TDBXTable; override;
    function FetchPackageSources(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable; override;
    function FetchUsers: TDBXTable; override;
  protected
    function AreSchemasSupported: Boolean; override;
    function GetProductName: string; override;
    function GetTableType: string; override;
    function GetViewType: string; override;
    function GetSystemTableType: string; override;
    function GetSqlProcedureQuoteChar: string; override;
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
    function GetSqlForSynonyms: string; override;
    function GetSqlForProcedures: string; override;
    function GetSqlForProcedureSources: string; override;
    function GetSqlForProcedureParameters: string; override;
    function GetSqlForRoles: string; override;
    function GetVersion: string; override;
    function GetDataTypeDescriptions: TDBXDataTypeDescriptionArray; override;
    function GetReservedWords: TDBXStringArray; override;
  end;

implementation

uses
  Data.DBXCommon,
  Data.DBXMetaDataNames;

function TDBXDb2MetaDataReader.AreSchemasSupported: Boolean;
begin
  Result := True;
end;

function TDBXDb2MetaDataReader.GetProductName: string;
begin
  Result := 'Db2';
end;

function TDBXDb2MetaDataReader.GetTableType: string;
begin
  Result := 'T';
end;

function TDBXDb2MetaDataReader.GetViewType: string;
begin
  Result := 'V';
end;

function TDBXDb2MetaDataReader.GetSystemTableType: string;
begin
  Result := 'T';
end;

function TDBXDb2MetaDataReader.GetSqlProcedureQuoteChar: string;
begin
  Result := '';
end;

function TDBXDb2MetaDataReader.IsSetRowSizeSupported: Boolean;
begin
  Result := True;
end;

function TDBXDb2MetaDataReader.IsParameterMetadataSupported: Boolean;
begin
  Result := True;
end;

function TDBXDb2MetaDataReader.FetchCatalogs: TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateCatalogsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Catalogs, Columns);
end;

function TDBXDb2MetaDataReader.GetSqlForSchemas: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), SCHEMANAME FROM SYSCAT.SCHEMATA ORDER BY 1';
end;

function TDBXDb2MetaDataReader.GetSqlForTables: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), TABSCHEMA, TABNAME, CASE WHEN TABSCHEMA IN (''SYSIBM'',''SYSCAT'',''SYSSTAT'') THEN ''SYSTEM '' ELSE '''' END || CASE TYPE WHEN ''T'' THEN ''TABLE'' ELSE ''VIEW'' END ' +
            'FROM SYSCAT.TABLES ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(TABSCHEMA) = LOWER(CAST(:SCHEMA_NAME AS VARCHAR(128))) OR (:SCHEMA_NAME IS NULL)) AND (TABNAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            ' AND (TYPE IN (''T'',''V'')) ' +
            ' AND (TYPE=CASE WHEN TABSCHEMA IN (''SYSIBM'',''SYSCAT'',''SYSSTAT'') THEN CAST(:SYSTEM_TABLES AS VARCHAR(12)) ELSE CAST(:TABLES AS VARCHAR(12)) END OR TYPE=CASE WHEN TABSCHEMA IN (''SYSIBM'',''SYSCAT'',''SYSSTAT'') THEN CAST(:SYSTEM_VIEWS AS VARCHAR(12)) ELSE CAST(:' + 'VIEWS AS VARCHAR(12)) END) ' +
            'ORDER BY 2,3';
end;

function TDBXDb2MetaDataReader.GetSqlForViews: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), VIEWSCHEMA, VIEWNAME, TEXT ' +
            'FROM SYSCAT.VIEWS ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (VIEWSCHEMA = :SCHEMA_NAME OR (:SCHEMA_NAME IS NULL)) AND (VIEWNAME = :VIEW_NAME OR (:VIEW_NAME IS NULL)) ' +
            'ORDER BY 2,3';
end;

function TDBXDb2MetaDataReader.GetSqlForColumns: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), TABSCHEMA, TABNAME, COLNAME, TYPENAME, LENGTH, SCALE, COLNO+1, DEFAULT, CASE WHEN NULLS=''Y'' THEN 1 ELSE 0 END, CASE WHEN IDENTITY=''Y'' THEN 1 ELSE 0 END, CAST(NULL AS INTEGER) ' +
            'FROM SYSCAT.COLUMNS ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(TABSCHEMA) = LOWER(CAST(:SCHEMA_NAME AS VARCHAR(128))) OR (:SCHEMA_NAME IS NULL)) AND (TABNAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            'ORDER BY 2, 3, COLNO';
end;

function TDBXDb2MetaDataReader.FetchColumnConstraints(const CatalogName: string; const SchemaName: string; const TableName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateColumnConstraintsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.ColumnConstraints, Columns);
end;

function TDBXDb2MetaDataReader.GetSqlForIndexes: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), TABSCHEMA, TABNAME, INDNAME, CASE WHEN USER_DEFINED=1 THEN CAST(NULL AS VARCHAR(1)) ELSE INDNAME END, CASE WHEN UNIQUERULE=''P'' THEN 1 ELSE 0 END, CASE WHEN UNIQUERULE=''D'' THEN 0 ELSE 1 END, 1 ' +
            'FROM SYSCAT.INDEXES ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(TABSCHEMA) = LOWER(CAST(:SCHEMA_NAME AS VARCHAR(128))) OR (:SCHEMA_NAME IS NULL)) AND (TABNAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            'ORDER BY 2, 3, 4';
end;

function TDBXDb2MetaDataReader.GetSqlForIndexColumns: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), I.TABSCHEMA, I.TABNAME, I.INDNAME, C.COLNAME, C.COLSEQ, CASE WHEN COLORDER=''A'' THEN 1 WHEN COLORDER=''D'' THEN 0 ELSE CAST (NULL AS INTEGER) END ' +
            'FROM SYSCAT.INDEXES I, SYSCAT.INDEXCOLUSE C ' +
            'WHERE I.INDSCHEMA = C.INDSCHEMA AND I.INDNAME = C.INDNAME ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(I.TABSCHEMA) = LOWER(CAST(:SCHEMA_NAME AS VARCHAR(128))) OR (:SCHEMA_NAME IS NULL)) AND (I.TABNAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (I.INDNAME = :INDEX_NAME OR (:INDEX_NAME IS NULL)) ' +
            'ORDER BY 2, 3, 4, 6';
end;

function TDBXDb2MetaDataReader.GetSqlForForeignKeys: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), TABSCHEMA, TABNAME, CONSTNAME ' +
            'FROM SYSCAT.REFERENCES ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(TABSCHEMA) = LOWER(CAST(:SCHEMA_NAME AS VARCHAR(128))) OR (:SCHEMA_NAME IS NULL)) AND (TABNAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) ' +
            'ORDER BY 2,3,4';
end;

function TDBXDb2MetaDataReader.GetSqlForForeignKeyColumns: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), FK.TABSCHEMA, FK.TABNAME, FK.CONSTNAME, FC.COLNAME, CAST(NULL AS VARCHAR(1)), FK.REFTABSCHEMA, FK.REFTABNAME, FK.REFKEYNAME, PC.COLNAME, FC.COLSEQ ' +
            'FROM SYSCAT.REFERENCES FK, SYSCAT.KEYCOLUSE FC, SYSCAT.KEYCOLUSE PC ' +
            'WHERE  FK.TABSCHEMA = FC.TABSCHEMA ' +
            ' AND   FK.TABNAME = FC.TABNAME ' +
            ' AND   FK.CONSTNAME = FC.CONSTNAME ' +
            ' AND   FK.REFTABSCHEMA = PC.TABSCHEMA ' +
            ' AND   FK.REFTABNAME = PC.TABNAME ' +
            ' AND   FK.REFKEYNAME = PC.CONSTNAME ' +
            ' AND   FC.COLSEQ = PC.COLSEQ ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(FK.TABSCHEMA) = LOWER(CAST(:SCHEMA_NAME AS VARCHAR(128))) OR (:SCHEMA_NAME IS NULL)) AND (FK.TABNAME = :TABLE_NAME OR (:TABLE_NAME IS NULL)) AND (FK.CONSTNAME = :FOREIGN_KEY_NAME OR (:FOREIGN_KEY_NAME IS NU' + 'LL)) ' +
            ' AND (1<2 OR (:PRIMARY_CATALOG_NAME IS NULL)) AND (LOWER(FK.REFTABSCHEMA) = LOWER(CAST(:PRIMARY_SCHEMA_NAME AS VARCHAR(128))) OR (:PRIMARY_SCHEMA_NAME IS NULL)) AND (FK.REFTABNAME = :PRIMARY_TABLE_NAME OR (:PRIMARY_TABLE_NAME IS NULL)) AND (FK.REFKEYNAME ' + '= :PRIMARY_KEY_NAME OR (:PRIMARY_KEY_NAME IS NULL)) ' +
            'ORDER BY 2,3,4,FC.COLSEQ';
end;

function TDBXDb2MetaDataReader.GetSqlForSynonyms: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), TABSCHEMA, TABNAME, CAST(NULL AS VARCHAR(1)), BASE_TABSCHEMA, BASE_TABNAME ' +
            'FROM SYSCAT.TABLES ' +
            'WHERE  TYPE = ''A'' ' +
            ' AND (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(TABSCHEMA) = LOWER(CAST(:SCHEMA_NAME AS VARCHAR(128))) OR (:SCHEMA_NAME IS NULL)) AND (TABNAME = :SYNONYM_NAME OR (:SYNONYM_NAME IS NULL)) ' +
            'ORDER BY 2,3';
end;

function TDBXDb2MetaDataReader.GetSqlForProcedures: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), ROUTINESCHEMA, ROUTINENAME, CASE WHEN ROUTINETYPE=''P'' THEN ''PROCEDURE'' ELSE ''FUNCTION'' END ' +
            'FROM SYSCAT.ROUTINES ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(ROUTINESCHEMA) = LOWER(CAST(:SCHEMA_NAME AS VARCHAR(128))) OR (:SCHEMA_NAME IS NULL)) AND (ROUTINENAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) AND ((CASE WHEN ROUTINETYPE=''P'' THEN ''PROCEDURE'' ELSE ' + '''METHOD'' END) = :PROCEDURE_TYPE OR (:PROCEDURE_TYPE IS NULL)) ' +
            'ORDER BY 2,3';
end;

function TDBXDb2MetaDataReader.GetSqlForProcedureSources: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), ROUTINESCHEMA, ROUTINENAME, CASE WHEN ROUTINETYPE=''P'' THEN ''PROCEDURE'' ELSE ''FUNCTION'' END, TEXT, CAST(NULL AS VARCHAR(1)) ' +
            'FROM SYSCAT.ROUTINES ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(ROUTINESCHEMA) = LOWER(CAST(:SCHEMA_NAME AS VARCHAR(128))) OR (:SCHEMA_NAME IS NULL)) AND (ROUTINENAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) ' +
            'ORDER BY 2,3';
end;

function TDBXDb2MetaDataReader.GetSqlForProcedureParameters: string;
begin
  Result := 'SELECT CAST(NULL AS VARCHAR(1)), ROUTINESCHEMA, ROUTINENAME, PARMNAME, CASE WHEN ROWTYPE=''P'' THEN ''IN'' WHEN ROWTYPE=''O'' THEN ''OUT'' WHEN ROWTYPE=''B'' THEN ''INOUT'' ELSE ''RESULT'' END, TYPENAME, LENGTH, SCALE, ORDINAL, 1 ' +
            'FROM SYSCAT.ROUTINEPARMS ' +
            'WHERE (1<2 OR (:CATALOG_NAME IS NULL)) AND (LOWER(ROUTINESCHEMA) = LOWER(CAST(:SCHEMA_NAME AS VARCHAR(128))) OR (:SCHEMA_NAME IS NULL)) AND (ROUTINENAME = :PROCEDURE_NAME OR (:PROCEDURE_NAME IS NULL)) AND (PARMNAME = :PARAMETER_NAME OR (:PARAMETER_NAME IS' + ' NULL)) ' +
            'ORDER BY 2,3,ORDINAL';
end;

function TDBXDb2MetaDataReader.FetchPackages(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackagesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Packages, Columns);
end;

function TDBXDb2MetaDataReader.FetchPackageProcedures(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ProcedureType: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProceduresColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageProcedures, Columns);
end;

function TDBXDb2MetaDataReader.FetchPackageProcedureParameters(const CatalogName: string; const SchemaName: string; const PackageName: string; const ProcedureName: string; const ParameterName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProcedureParametersColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageProcedureParameters, Columns);
end;

function TDBXDb2MetaDataReader.FetchPackageSources(const CatalogName: string; const SchemaName: string; const PackageName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageSourcesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageSources, Columns);
end;

function TDBXDb2MetaDataReader.FetchUsers: TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateUsersColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Users, Columns);
end;

function TDBXDb2MetaDataReader.GetSqlForRoles: string;
begin
  Result := 'SELECT NGNAME FROM SYSCAT.NODEGROUPS';
end;

function TDBXDb2MetaDataReader.GetVersion: string;
begin
  Result := 'SELECT FIRST 1 DBINFO(''version'',''major'')||''.''||DBINFO(''version'',''minor'')||''.''||DBINFO(''version'',''level'') FROM SYSTABLES';
end;

function TDBXDb2MetaDataReader.GetDataTypeDescriptions: TDBXDataTypeDescriptionArray;
var
  Types: TDBXDataTypeDescriptionArray;
begin
  SetLength(Types,14);
  Types[0] := TDBXDataTypeDescription.Create('SMALLINT', TDBXDataTypes.Int16Type, 5, 'SMALLINT', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.AutoIncrementable or TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[1] := TDBXDataTypeDescription.Create('INTEGER', TDBXDataTypes.Int32Type, 10, 'INTEGER', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.AutoIncrementable or TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[2] := TDBXDataTypeDescription.Create('BIGINT', TDBXDataTypes.Int64Type, 19, 'BIGINT', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.AutoIncrementable or TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[3] := TDBXDataTypeDescription.Create('REAL', TDBXDataTypes.SingleType, 7, 'REAL', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[4] := TDBXDataTypeDescription.Create('DOUBLE', TDBXDataTypes.DoubleType, 53, 'DOUBLE', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[5] := TDBXDataTypeDescription.Create('DECIMAL', TDBXDataTypes.BcdType, 38, 'DECIMAL({0}, {1})', 'Precision, Scale', 38, 0, NullString, NullString, NullString, NullString, TDBXTypeFlag.AutoIncrementable or TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[6] := TDBXDataTypeDescription.Create('CHARACTER', TDBXDataTypes.AnsiStringType, 4000, 'CHARACTER({0})', 'Precision', -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[7] := TDBXDataTypeDescription.Create('VARCHAR', TDBXDataTypes.AnsiStringType, 4000, 'VARCHAR({0})', 'Precision', -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.SearchableWithLike);
  Types[8] := TDBXDataTypeDescription.Create('LONG VARCHAR', TDBXDataTypes.AnsiStringType, 32700, 'LONG VARCHAR', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.Long or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[9] := TDBXDataTypeDescription.Create('BLOB', TDBXDataTypes.BlobType, 2147483647, 'BLOB', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.Long or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[10] := TDBXDataTypeDescription.Create('CLOB', TDBXDataTypes.BlobType, 2147483647, 'CLOB', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.Long or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.StringOption);
  Types[11] := TDBXDataTypeDescription.Create('DATE', TDBXDataTypes.DateType, 4, 'DATE', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[12] := TDBXDataTypeDescription.Create('TIME', TDBXDataTypes.TimeType, 3, 'TIME', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[13] := TDBXDataTypeDescription.Create('TIMESTAMP', TDBXDataTypes.TimeStampType, 10, 'TIMESTAMP', NullString, -1, -1, '''', '''', NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Result := Types;
end;

function TDBXDb2MetaDataReader.GetReservedWords: TDBXStringArray;
var
  Words: TDBXStringArray;
begin
  SetLength(Words,310);
  Words[0] := 'ADD';
  Words[1] := 'AFTER';
  Words[2] := 'ALIAS';
  Words[3] := 'ALL';
  Words[4] := 'ALLOCATE';
  Words[5] := 'ALLOW';
  Words[6] := 'ALTER';
  Words[7] := 'AND';
  Words[8] := 'ANY';
  Words[9] := 'APPLICATION';
  Words[10] := 'AS';
  Words[11] := 'ASSOCIATE';
  Words[12] := 'ASUTIME';
  Words[13] := 'AUDIT';
  Words[14] := 'AUTHORIZATION';
  Words[15] := 'AUX';
  Words[16] := 'AUXILIARY';
  Words[17] := 'BEFORE';
  Words[18] := 'BEGIN';
  Words[19] := 'BETWEEN';
  Words[20] := 'BINARY';
  Words[21] := 'BUFFERPOOL';
  Words[22] := 'BY';
  Words[23] := 'CACHE';
  Words[24] := 'CALL';
  Words[25] := 'CALLED';
  Words[26] := 'CAPTURE';
  Words[27] := 'CARDINALITY';
  Words[28] := 'CASCADED';
  Words[29] := 'CASE';
  Words[30] := 'CAST';
  Words[31] := 'CCSID';
  Words[32] := 'CHAR';
  Words[33] := 'CHARACTER';
  Words[34] := 'CHECK';
  Words[35] := 'CLOSE';
  Words[36] := 'CLUSTER';
  Words[37] := 'COLLECTION';
  Words[38] := 'COLLID';
  Words[39] := 'COLUMN';
  Words[40] := 'COMMENT';
  Words[41] := 'COMMIT';
  Words[42] := 'CONCAT';
  Words[43] := 'CONDITION';
  Words[44] := 'CONNECT';
  Words[45] := 'CONNECTION';
  Words[46] := 'CONSTRAINT';
  Words[47] := 'CONTAINS';
  Words[48] := 'CONTINUE';
  Words[49] := 'COUNT';
  Words[50] := 'COUNT_BIG';
  Words[51] := 'CREATE';
  Words[52] := 'CROSS';
  Words[53] := 'CURRENT';
  Words[54] := 'CURRENT_DATE';
  Words[55] := 'CURRENT_LC_CTYPE';
  Words[56] := 'CURRENT_PATH';
  Words[57] := 'CURRENT_SERVER';
  Words[58] := 'CURRENT_TIME';
  Words[59] := 'CURRENT_TIMESTAMP';
  Words[60] := 'CURRENT_TIMEZONE';
  Words[61] := 'CURRENT_USER';
  Words[62] := 'CURSOR';
  Words[63] := 'CYCLE';
  Words[64] := 'DATA';
  Words[65] := 'DATABASE';
  Words[66] := 'DAY';
  Words[67] := 'DAYS';
  Words[68] := 'DB2GENERAL';
  Words[69] := 'DB2GENRL';
  Words[70] := 'DB2SQL';
  Words[71] := 'DBINFO';
  Words[72] := 'DECLARE';
  Words[73] := 'DEFAULT';
  Words[74] := 'DEFAULTS';
  Words[75] := 'DEFINITION';
  Words[76] := 'DELETE';
  Words[77] := 'DESCRIPTOR';
  Words[78] := 'DETERMINISTIC';
  Words[79] := 'DISALLOW';
  Words[80] := 'DISCONNECT';
  Words[81] := 'DISTINCT';
  Words[82] := 'DO';
  Words[83] := 'DOUBLE';
  Words[84] := 'DROP';
  Words[85] := 'DSNHATTR';
  Words[86] := 'DSSIZE';
  Words[87] := 'DYNAMIC';
  Words[88] := 'EACH';
  Words[89] := 'EDITPROC';
  Words[90] := 'ELSE';
  Words[91] := 'ELSEIF';
  Words[92] := 'ENCODING';
  Words[93] := 'END-EXEC';
  Words[94] := 'END-EXEC1';
  Words[95] := 'END';
  Words[96] := 'ERASE';
  Words[97] := 'ESCAPE';
  Words[98] := 'EXCEPT';
  Words[99] := 'EXCEPTION';
  Words[100] := 'EXCLUDING';
  Words[101] := 'EXECUTE';
  Words[102] := 'EXISTS';
  Words[103] := 'EXIT';
  Words[104] := 'EXTERNAL';
  Words[105] := 'FENCED';
  Words[106] := 'FETCH';
  Words[107] := 'FIELDPROC';
  Words[108] := 'FILE';
  Words[109] := 'FINAL';
  Words[110] := 'FOR';
  Words[111] := 'FOREIGN';
  Words[112] := 'FREE';
  Words[113] := 'FROM';
  Words[114] := 'FULL';
  Words[115] := 'FUNCTION';
  Words[116] := 'GENERAL';
  Words[117] := 'GENERATED';
  Words[118] := 'GET';
  Words[119] := 'GLOBAL';
  Words[120] := 'GO';
  Words[121] := 'GOTO';
  Words[122] := 'GRANT';
  Words[123] := 'GRAPHIC';
  Words[124] := 'GROUP';
  Words[125] := 'HANDLER';
  Words[126] := 'HAVING';
  Words[127] := 'HOLD';
  Words[128] := 'HOUR';
  Words[129] := 'HOURS';
  Words[130] := 'IDENTITY';
  Words[131] := 'IF';
  Words[132] := 'IMMEDIATE';
  Words[133] := 'IN';
  Words[134] := 'INCLUDING';
  Words[135] := 'INCREMENT';
  Words[136] := 'INDEX';
  Words[137] := 'INDICATOR';
  Words[138] := 'INHERIT';
  Words[139] := 'INNER';
  Words[140] := 'INOUT';
  Words[141] := 'INSENSITIVE';
  Words[142] := 'INSERT';
  Words[143] := 'INTEGRITY';
  Words[144] := 'INTO';
  Words[145] := 'IS';
  Words[146] := 'ISOBID';
  Words[147] := 'ISOLATION';
  Words[148] := 'ITERATE';
  Words[149] := 'JAR';
  Words[150] := 'JAVA';
  Words[151] := 'JOIN';
  Words[152] := 'KEY';
  Words[153] := 'LABEL';
  Words[154] := 'LANGUAGE';
  Words[155] := 'LC_CTYPE';
  Words[156] := 'LEAVE';
  Words[157] := 'LEFT';
  Words[158] := 'LIKE';
  Words[159] := 'LINKTYPE';
  Words[160] := 'LOCAL';
  Words[161] := 'LOCALE';
  Words[162] := 'LOCATOR';
  Words[163] := 'LOCATORS';
  Words[164] := 'LOCK';
  Words[165] := 'LOCKMAX';
  Words[166] := 'LOCKSIZE';
  Words[167] := 'LONG';
  Words[168] := 'LOOP';
  Words[169] := 'MAXVALUE';
  Words[170] := 'MICROSECOND';
  Words[171] := 'MICROSECONDS';
  Words[172] := 'MINUTE';
  Words[173] := 'MINUTES';
  Words[174] := 'MINVALUE';
  Words[175] := 'MODE';
  Words[176] := 'MODIFIES';
  Words[177] := 'MONTH';
  Words[178] := 'MONTHS';
  Words[179] := 'NEW';
  Words[180] := 'NEW_TABLE';
  Words[181] := 'NO';
  Words[182] := 'NOCACHE';
  Words[183] := 'NOCYCLE';
  Words[184] := 'NODENAME';
  Words[185] := 'NODENUMBER';
  Words[186] := 'NOMAXVALUE';
  Words[187] := 'NOMINVALUE';
  Words[188] := 'NOORDER';
  Words[189] := 'NOT';
  Words[190] := 'NULL';
  Words[191] := 'NULLS';
  Words[192] := 'NUMPARTS';
  Words[193] := 'OBID';
  Words[194] := 'OF';
  Words[195] := 'OLD';
  Words[196] := 'OLD_TABLE';
  Words[197] := 'ON';
  Words[198] := 'OPEN';
  Words[199] := 'OPTIMIZATION';
  Words[200] := 'OPTIMIZE';
  Words[201] := 'OPTION';
  Words[202] := 'OR';
  Words[203] := 'ORDER';
  Words[204] := 'OUT';
  Words[205] := 'OUTER';
  Words[206] := 'OVERRIDING';
  Words[207] := 'PACKAGE';
  Words[208] := 'PARAMETER';
  Words[209] := 'PART';
  Words[210] := 'PARTITION';
  Words[211] := 'PATH';
  Words[212] := 'PIECESIZE';
  Words[213] := 'PLAN';
  Words[214] := 'POSITION';
  Words[215] := 'PRECISION';
  Words[216] := 'PREPARE';
  Words[217] := 'PRIMARY';
  Words[218] := 'PRIQTY';
  Words[219] := 'PRIVILEGES';
  Words[220] := 'PROCEDURE';
  Words[221] := 'PROGRAM';
  Words[222] := 'PSID';
  Words[223] := 'QUERYNO';
  Words[224] := 'READ';
  Words[225] := 'READS';
  Words[226] := 'RECOVERY';
  Words[227] := 'REFERENCES';
  Words[228] := 'REFERENCING';
  Words[229] := 'RELEASE';
  Words[230] := 'RENAME';
  Words[231] := 'REPEAT';
  Words[232] := 'RESET';
  Words[233] := 'RESIGNAL';
  Words[234] := 'RESTART';
  Words[235] := 'RESTRICT';
  Words[236] := 'RESULT';
  Words[237] := 'RESULT_SET_LOCATOR';
  Words[238] := 'RETURN';
  Words[239] := 'RETURNS';
  Words[240] := 'REVOKE';
  Words[241] := 'RIGHT';
  Words[242] := 'ROLLBACK';
  Words[243] := 'ROUTINE';
  Words[244] := 'ROW';
  Words[245] := 'ROWS';
  Words[246] := 'RRN';
  Words[247] := 'RUN';
  Words[248] := 'SAVEPOINT';
  Words[249] := 'SCHEMA';
  Words[250] := 'SCRATCHPAD';
  Words[251] := 'SECOND';
  Words[252] := 'SECONDS';
  Words[253] := 'SECQTY';
  Words[254] := 'SECURITY';
  Words[255] := 'SELECT';
  Words[256] := 'SENSITIVE';
  Words[257] := 'SET';
  Words[258] := 'SIGNAL';
  Words[259] := 'SIMPLE';
  Words[260] := 'SOME';
  Words[261] := 'SOURCE';
  Words[262] := 'SPECIFIC';
  Words[263] := 'SQL';
  Words[264] := 'SQLID';
  Words[265] := 'STANDARD';
  Words[266] := 'START';
  Words[267] := 'STATIC';
  Words[268] := 'STAY';
  Words[269] := 'STOGROUP';
  Words[270] := 'STORES';
  Words[271] := 'STYLE';
  Words[272] := 'SUBPAGES';
  Words[273] := 'SUBSTRING';
  Words[274] := 'SYNONYM';
  Words[275] := 'SYSFUN';
  Words[276] := 'SYSIBM';
  Words[277] := 'SYSPROC';
  Words[278] := 'SYSTEM';
  Words[279] := 'TABLE';
  Words[280] := 'TABLESPACE';
  Words[281] := 'THEN';
  Words[282] := 'TO';
  Words[283] := 'TRANSACTION';
  Words[284] := 'TRIGGER';
  Words[285] := 'TRIM';
  Words[286] := 'TYPE';
  Words[287] := 'UNDO';
  Words[288] := 'UNION';
  Words[289] := 'UNIQUE';
  Words[290] := 'UNTIL';
  Words[291] := 'UPDATE';
  Words[292] := 'USAGE';
  Words[293] := 'USER';
  Words[294] := 'USING';
  Words[295] := 'VALIDPROC';
  Words[296] := 'VALUES';
  Words[297] := 'VARIABLE';
  Words[298] := 'VARIANT';
  Words[299] := 'VCAT';
  Words[300] := 'VIEW';
  Words[301] := 'VOLUMES';
  Words[302] := 'WHEN';
  Words[303] := 'WHERE';
  Words[304] := 'WHILE';
  Words[305] := 'WITH';
  Words[306] := 'WLM';
  Words[307] := 'WRITE';
  Words[308] := 'YEAR';
  Words[309] := 'YEARS';
  Result := Words;
end;

end.
