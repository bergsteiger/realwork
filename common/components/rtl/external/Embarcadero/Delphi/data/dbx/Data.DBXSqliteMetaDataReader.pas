{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXSqliteMetaDataReader;

interface

uses
  Data.DbxCommon, Data.DBXCommonTable, Data.DBXMetaDataReader, Data.DBXPlatform;

type
  TDBXSqliteCustomMetaDataReader = class(TDBXBaseMetaDataReader)
  protected
    function GetDataTypeDescriptions: TDBXDataTypeDescriptionArray; override;
    function GetProductName: string; override;
    function GetReservedWords: TDBXStringArray; override;
    function GetSqlForIndexes: string; override;
    function GetSqlForTables: string; override;
    function GetSqlForViews: string; override;
    function IsLowerCaseIdentifiersSupported: Boolean; override;
    function IsNestedTransactionsSupported: Boolean; override;
  public
    function FetchCatalogs: TDBXTable; override;
    function FetchColumnConstraints(const Catalog: string; const Schema: string; const Table: string): TDBXTable; override;
    function FetchColumns(const Catalog: string; const Schema: string; const Table: string): TDBXTable; override;
    function FetchForeignKeyColumns(const Catalog: string; const Schema: string; const Table: string; const ForeignKeyName: string; const PrimaryCatalog: string; const PrimarySchema: string; const PrimaryTable: string; const PrimaryKeyName: string): TDBXTable; override;
    function FetchForeignKeys(const Catalog: string; const Schema: string; const Table: string): TDBXTable; override;
    function FetchIndexColumns(const Catalog: string; const Schema: string; const Table: string; const Index: string): TDBXTable; override;
    function FetchPackageProcedureParameters(const Catalog: string; const Schema: string; const PackageName: string; const ProcedureName: string; const ParameterName: string): TDBXTable; override;
    function FetchPackageProcedures(const Catalog: string; const Schema: string; const PackageName: string; const ProcedureName: string; const ProcedureType: string): TDBXTable; override;
    function FetchPackages(const Catalog: string; const Schema: string; const PackageName: string): TDBXTable; override;
    function FetchPackageSources(const Catalog: string; const Schema: string; const PackageName: string): TDBXTable; override;
    function FetchProcedureParameters(const Catalog: string; const Schema: string; const Proc: string; const Parameter: string): TDBXTable; override;
    function FetchProcedures(const Catalog: string; const Schema: string; const ProcedureName: string; const ProcedureType: string): TDBXTable; override;
    function FetchProcedureSources(const Catalog: string; const Schema: string; const Proc: string): TDBXTable; override;
    function FetchRoles: TDBXTable; override;
    function FetchSchemas(const Catalog: string): TDBXTable; override;
    function FetchSynonyms(const Catalog: string; const Schema: string; const Synonym: string): TDBXTable; override;
    function FetchUsers: TDBXTable; override;
  end;

  TDBXSqliteMetaDataReader = class(TDBXSqliteCustomMetaDataReader)
  end;

  TDBXSqliteColumnsTableCursor = class(TDBXColumnsTableCursor)
  private
    FDataTypesRow: TDBXSingleValueRow;
  protected
    function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
  public
    constructor Create(const Reader: TDBXBaseMetaDataReader; const CheckBase: Boolean; const Cursor: TDBXTable);
    destructor Destroy; override;
    function Next: Boolean; override;
  end;

implementation

uses
  Data.DbxCommonResStrs, Data.DBXDBReaders, Data.DBXMetaDataCommandFactory,
  Data.DbxMetaDataNames, Data.DbxSqlite, Data.DBXSqlScanner, System.Sqlite, System.SysUtils;

const
  RefIndex = 20;
  ForeignIndex = 21;
  OnIndex = 22;
  CollateIndex = 23;
  AscIndex = 24;
  DescIndex = 25;
  IndexToken = 26;
  TableToken = 27;
  PrimaryToken = 28;
  ConstraintToken = 29;

function TDBXSqliteCustomMetaDataReader.GetDataTypeDescriptions: TDBXDataTypeDescriptionArray;
var
  Types: TDBXDataTypeDescriptionArray;
begin
  SetLength(Types, 4);
  Types[0] := TDBXDataTypeDescription.Create('INTEGER', TDBXDataTypes.Int64Type, 10, 'INTEGER', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.AutoIncrementable or TDBXTypeFlag.FixedLength or TDBXTypeFlag.FixedPrecisionScale or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[1] := TDBXDataTypeDescription.Create('REAL', TDBXDataTypes.DoubleType, 53, 'REAL', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.FixedLength or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable);
  Types[2] := TDBXDataTypeDescription.Create('TEXT', TDBXDataTypes.BlobType, 2147483647, 'TEXT', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.BestMatch or TDBXTypeFlag.LongOption or TDBXTypeFlag.Nullable or TDBXTypeFlag.Searchable or TDBXTypeFlag.Unicode or TDBXTypeFlag.StringOption);
  Types[3] := TDBXDataTypeDescription.Create('BLOB', TDBXDataTypes.BlobType, 2147483647, 'BLOB', NullString, -1, -1, NullString, NullString, NullString, NullString, TDBXTypeFlag.Long or TDBXTypeFlag.Nullable or TDBXTypeFlag.SearchableWithLike);
  Result := Types;
end;

function TDBXSqliteCustomMetaDataReader.GetProductName: string;
begin
  Result := 'Sqlite';
end;

function TDBXSqliteCustomMetaDataReader.GetReservedWords: TDBXStringArray;
var
  Words: TDBXStringArray;
begin
  SetLength(Words, 121);
  Words[0] := 'ABORT';
  Words[1] := 'ACTION';
  Words[2] := 'ADD';
  Words[3] := 'AFTER';
  Words[4] := 'ALL';
  Words[5] := 'ALTER';
  Words[6] := 'ANALYZE';
  Words[7] := 'AND';
  Words[8] := 'AS';
  Words[9] := 'ASC';
  Words[10] := 'ATTACH';
  Words[11] := 'AUTOINCREMENT';
  Words[12] := 'BEFORE';
  Words[13] := 'BEGIN';
  Words[14] := 'BETWEEN';
  Words[15] := 'BY';
  Words[16] := 'CASCADE';
  Words[17] := 'CASE';
  Words[18] := 'CAST';
  Words[19] := 'CHECK';
  Words[20] := 'COLLATE';
  Words[21] := 'COLUMN';
  Words[22] := 'COMMIT';
  Words[23] := 'CONFLICT';
  Words[24] := 'CONSTRAINT';
  Words[25] := 'CREATE';
  Words[26] := 'CROSS';
  Words[27] := 'CURRENT_DATE';
  Words[28] := 'CURRENT_TIME';
  Words[29] := 'CURRENT_TIMESTAMP';
  Words[30] := 'DATABASE';
  Words[31] := 'DEFAULT';
  Words[32] := 'DEFERRABLE';
  Words[33] := 'DEFERRED';
  Words[34] := 'DELETE';
  Words[35] := 'DESC';
  Words[36] := 'DETACH';
  Words[37] := 'DISTINCT';
  Words[38] := 'DROP';
  Words[39] := 'EACH';
  Words[40] := 'ELSE';
  Words[41] := 'END';
  Words[42] := 'ESCAPE';
  Words[43] := 'EXCEPT';
  Words[44] := 'EXCLUSIVE';
  Words[45] := 'EXISTS';
  Words[46] := 'EXPLAIN';
  Words[47] := 'FAIL';
  Words[48] := 'FOR';
  Words[49] := 'FOREIGN';
  Words[50] := 'FROM';
  Words[51] := 'FULL';
  Words[52] := 'GLOB';
  Words[53] := 'GROUP';
  Words[54] := 'HAVING';
  Words[55] := 'IF';
  Words[56] := 'IGNORE';
  Words[57] := 'IMMEDIATE';
  Words[58] := 'IN';
  Words[59] := 'INDEX';
  Words[60] := 'INDEXED';
  Words[61] := 'INITIALLY';
  Words[62] := 'INNER';
  Words[63] := 'INSERT';
  Words[64] := 'INSTEAD';
  Words[65] := 'INTERSECT';
  Words[66] := 'INTO';
  Words[67] := 'IS';
  Words[68] := 'ISNULL';
  Words[69] := 'JOIN';
  Words[70] := 'KEY';
  Words[71] := 'LEFT';
  Words[72] := 'LIKE';
  Words[73] := 'LIMIT';
  Words[74] := 'MATCH';
  Words[75] := 'NATURAL';
  Words[76] := 'NO';
  Words[77] := 'NOT';
  Words[78] := 'NOTNULL';
  Words[79] := 'NULL';
  Words[80] := 'OF';
  Words[81] := 'OFFSET';
  Words[82] := 'ON';
  Words[83] := 'OR';
  Words[84] := 'ORDER';
  Words[85] := 'OUTER';
  Words[86] := 'PLAN';
  Words[87] := 'PRAGMA';
  Words[88] := 'PRIMARY';
  Words[89] := 'QUERY';
  Words[90] := 'RAISE';
  Words[91] := 'REFERENCES';
  Words[92] := 'REGEXP';
  Words[93] := 'REINDEX';
  Words[94] := 'RELEASE';
  Words[95] := 'RENAME';
  Words[96] := 'REPLACE';
  Words[97] := 'RESTRICT';
  Words[98] := 'RIGHT';
  Words[99] := 'ROLLBACK';
  Words[100] := 'ROW';
  Words[101] := 'SAVEPOINT';
  Words[102] := 'SELECT';
  Words[103] := 'SET';
  Words[104] := 'TABLE';
  Words[105] := 'TEMP';
  Words[106] := 'TEMPORARY';
  Words[107] := 'THEN';
  Words[108] := 'TO';
  Words[109] := 'TRANSACTION';
  Words[110] := 'TRIGGER';
  Words[111] := 'UNION';
  Words[112] := 'UNIQUE';
  Words[113] := 'UPDATE';
  Words[114] := 'USING';
  Words[115] := 'VACUUM';
  Words[116] := 'VALUES';
  Words[117] := 'VIEW';
  Words[118] := 'VIRTUAL';
  Words[119] := 'WHEN';
  Words[120] := 'WHERE';
  Result := Words;
end;

function TDBXSqliteCustomMetaDataReader.GetSqlForIndexes: string;
begin
  Result := 'select NULL, NULL, tbl_name, name, NULL, NULL, NULL from sqlite_master where type = ''index'' and (tbl_name = :TABLE_NAME OR (:TABLE_NAME IS NULL))';
end;

function TDBXSqliteCustomMetaDataReader.GetSqlForTables: string;
begin
  Result := 'select NULL, NULL, name, NULL from sqlite_master where ((type = ''table'' and :TABLES = ''TABLE'') OR (type = ''view'' and :VIEWS = ''VIEW'')) and (name = :TABLE_NAME OR (:TABLE_NAME IS NULL))';
end;

function TDBXSqliteCustomMetaDataReader.GetSqlForViews: string;
begin
  Result := 'select NULL, NULL, name, sql from sqlite_master where type = ''view'' and (name = :VIEW_NAME OR (:VIEW_NAME IS NULL))';
end;

function TDBXSqliteCustomMetaDataReader.IsLowerCaseIdentifiersSupported: Boolean;
begin
  Result := True;
end;

function TDBXSqliteCustomMetaDataReader.IsNestedTransactionsSupported: Boolean;
begin
  Result := True;
end;

function TDBXSqliteCustomMetaDataReader.FetchCatalogs: TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateCatalogsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Catalogs, Columns);
end;

function TDBXSqliteCustomMetaDataReader.FetchColumnConstraints(const Catalog: string; const Schema: string; const Table: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateColumnConstraintsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.ColumnConstraints, Columns);
end;

function TDBXSqliteCustomMetaDataReader.FetchColumns(const Catalog: string; const Schema: string; const Table: string): TDBXTable;
  function GetPrecision(DataType: Integer; DataTypeName: string): Integer;
  var
    Pos1, Pos2: Integer;
  begin
    case DataType of
      SQLITE_INTEGER: Result := SizeOf(Int64);
      SQLITE_FLOAT: Result := SizeOf(Double);
      SQLITE_BLOB: Result := 0;
      SQLITE_TEXT:
        begin
          Pos1 := DataTypeName.IndexOf('(');
          if Pos1 > -1 then
          begin
            Pos2 := DataTypeName.IndexOf(')');
            Result := StrToInt(DataTypeName.Substring(Pos1+1, Pos2-Pos1-1));
          end
          else
            Result := 1;
        end
    else
      Result := 1;
    end;
  end;

  function GetDbxDataType(DataType: Integer): Integer;
  begin
    case DataType of
      SQLITE_INTEGER: Result := TDBXDataTypes.Int64Type;
      SQLITE_FLOAT: Result := TDBXDataTypes.DoubleType;
    else
      Result := TDBXDataTypes.BlobType;
    end;
  end;
var
  LConnection: TDBXSqliteConnection;
  LCommand: TDBXSqliteCommand;
  LReader: TDBXSqliteReader;
  Columns, TableColumns: TDBXValueTypeArray;
  ColType, I, NumCols: Integer;
  MemTable: TDBXMemoryTable;
  DBXContext: TDBXContext;
  Cursor: TDBXTable;
  DataTypePtrUni: MarshaledString;
  ColumnName: string;
{$IF not (DEFINED(CPUARM) and DEFINED(IOS))}
  DbName, TableName: string;
  Autoinc, ErrorCode, NotNull, PrimaryKey: Integer;
  CollationSeqPtr, DataTypePtr: MarshaledAString;
{$ENDIF not (CPUARM and IOS)}
begin
  Result := nil;
  Columns := TDBXMetaDataCollectionColumns.CreateColumnsColumns;
  if Table = '' then
    Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Columns, Columns)
  else
  begin
    if Assigned(Context) then
    begin
      LConnection := TDBXSqliteConnection(TDBXDataExpressProviderContext(Context).Connection);
      if Assigned(LConnection) then
      begin
        DBXContext := TDBXContext.Create;
        try
          LCommand := TDBXSqliteCommand.Create(DBXContext, LConnection);
          try
            LCommand.Text := 'select * from ' + Table + ' LIMIT 1';
            LReader := TDBXSqliteReader(LCommand.ExecuteQuery);
            LReader.Next;
            try
              MemTable := TDBXMemoryTable.Create;
              try
                TableColumns := TDBXMetaDataCollectionColumns.CreateColumnsColumns;
                MemTable.Columns := TableColumns;
                NumCols := sqlite3_column_count(LCommand.StatementHandle);
                MemTable.Insert; //Dummy Row
                for I := 0 to NumCols - 1 do
                begin
                  MemTable.Insert;
{$IF not (DEFINED(CPUARM) and DEFINED(IOS))}
                  if LConnection.GetVendorProperty('ColumnMetaDataSupported') = 'True' then
                  begin
                    DbName := sqlite3_column_database_name16(LCommand.StatementHandle, I);
                    TableName := sqlite3_column_table_name16(LCommand.StatementHandle, I);
                    ColumnName := sqlite3_column_origin_name16(LCommand.StatementHandle, I);
                    ColType := sqlite3_column_type(LCommand.StatementHandle, I);
                    ErrorCode := sqlite3_table_column_metadata(LConnection.ConnectionHandle,
                                                               MarshaledAString(Utf8Encode(DbName)),
                                                               MarshaledAString(Utf8Encode(TableName)),
                                                               MarshaledAString(Utf8Encode(ColumnName)),
                                                               DataTypePtr,
                                                               CollationSeqPtr,
                                                               NotNull,
                                                               PrimaryKey,
                                                               Autoinc);
                    CheckError(ErrorCode, LConnection.ConnectionHandle, DBXContext);
                    MemTable.Value[2].AsString := TableName;
                    MemTable.Value[3].AsString := ColumnName;
                    MemTable.Value[4].AsString := string(DataTypePtr);
                    MemTable.Value[5].AsInt32 := GetPrecision(ColType, string(DataTypePtr));
                    MemTable.Value[7].AsInt32 := I;
                    MemTable.Value[9].AsBoolean := NotNull = 0;
                    MemTable.Value[10].AsBoolean := Autoinc <> 0;
                    MemTable.Value[12].AsInt32 := GetDbxDataType(ColType);
                  end
                  else
{$ENDIF not (CPUARM and IOS)}
                  begin
                    ColumnName := sqlite3_column_name16(LCommand.StatementHandle, I);
                    DataTypePtrUni := sqlite3_column_decltype16(LCommand.StatementHandle, I);
                    ColType := sqlite3_column_type(LCommand.StatementHandle, I);
                    MemTable.Value[2].AsString := Table;
                    MemTable.Value[3].AsString := ColumnName;
                    MemTable.Value[4].AsString := DataTypePtrUni;
                    MemTable.Value[5].AsInt32 := GetPrecision(ColType, DataTypePtrUni);
                    MemTable.Value[7].AsInt32 := I;
                    MemTable.Value[9].AsBoolean := True;
                    MemTable.Value[10].AsBoolean := False;
                    MemTable.Value[12].AsInt32 := GetDbxDataType(ColType);
                  end;
                end;
                MemTable.First;
                Cursor := TDBXStringTrimTable.CreateTrimTableIfNeeded(MemTable);
                Cursor := TDBXCustomMetaDataTable.Create(GetContext, TDBXMetaDataCollectionName.Columns, Columns, Cursor);
                Result := TDBXSqliteColumnsTableCursor.Create(Self, False, Cursor);
              except
                MemTable.Free;
                raise;
              end;
            finally
              LReader.Free;
            end;
          finally
            LCommand.Free;
          end;
        finally
          DBXContext.Free;
        end;
      end;
    end;
  end;
end;

function TDBXSqliteCustomMetaDataReader.FetchForeignKeyColumns(const Catalog: string; const Schema: string; const Table: string; const ForeignKeyName: string; const PrimaryCatalog: string; const PrimarySchema: string; const PrimaryTable: string; const PrimaryKeyName: string): TDBXTable;
  procedure Scan(Scanner: TDBXSqlScanner; MemTable: TDBXMemoryTable);
  var
    FKNum, I, LookAheadToken, NumCols, SavedIndex, Token: Integer;
    ColumnNames: array of string;
    ParentTableName: string;
  begin
    Token := 0;
    SavedIndex := 0;
    FKNum := 1;
    NumCols := 0;
    while Token <> TDBXSqlScanner.TokenEos do
    begin
      Token := Scanner.NextToken;
      if Token = RefIndex then
      begin
        MemTable.Insert;
        MemTable.Value[2].AsString := Table;
        MemTable.Value[3].AsString := 'FK' + IntToStr(FKNum);
        Inc(FKNum);
        Scanner.Init(Scanner.SqlQuery, SavedIndex);
        Scanner.NextToken;
        MemTable.Value[4].AsString := Scanner.Id;
        Scanner.NextToken;
        Scanner.NextToken;
        MemTable.Value[7].AsString := Scanner.Id;
        Scanner.NextToken;
        Scanner.NextToken;
        MemTable.Value[9].AsString := Scanner.Id;
      end
      else if Token = ForeignIndex then
      begin
        Scanner.NextToken;
        Scanner.NextToken;
        SavedIndex := Scanner.NextIndex;
        Token := Scanner.NextToken;
        //Get a count of columns in the composite key
        while Token <> TDBXSqlScanner.TokenCloseParen do
        begin
          if Token <> TDBXSqlScanner.TokenComma then
            Inc(NumCols);
          Token := Scanner.NextToken;
        end;
        SetLength(ColumnNames, NumCols);
        Scanner.Init(Scanner.SqlQuery, SavedIndex);
        //Columns that make up foreign key
        for I := 0 to NumCols - 1 do
        begin
          Scanner.NextToken;
          ColumnNames[I] := Scanner.Id;
          Scanner.NextToken;
        end;
        Scanner.NextToken;
        Scanner.NextToken;
        ParentTableName := Scanner.Id;
        Scanner.NextToken;
        for I := 0 to NumCols - 1 do
        begin
          MemTable.Insert;
          MemTable.Value[2].AsString := Table;
          MemTable.Value[3].AsString := 'FK' + IntToStr(FKNum);
          MemTable.Value[4].AsString := ColumnNames[I];
          MemTable.Value[7].AsString := ParentTableName;
          Scanner.NextToken;
          MemTable.Value[9].AsString := Scanner.Id;
          Scanner.NextToken;
        end;
        Inc(FKNum);
        NumCols := 0;
      end;
      LookAheadToken := Scanner.LookAtNextToken;
      if LookAheadToken <> 20 then
        SavedIndex := Scanner.NextIndex;
    end;
  end;

const
  Ref = 'REFERENCES';
  Foreign = 'FOREIGN';
var
  Columns, TableColumns: TDBXValueTypeArray;
  DBXContext: TDBXContext;
  LConnection: TDBXSqliteConnection;
  LCommand: TDBXSqliteCommand;
  LReader: TDBXSqliteReader;
  MemTable: TDBXMemoryTable;
  Scanner: TDBXSqlScanner;
  Cursor: TDBXTable;
begin
  Result := nil;
  Columns := TDBXMetaDataCollectionColumns.CreateForeignKeyColumnsColumns;
  if Table = '' then
    Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.ForeignKeyColumns, Columns)
  else
  begin
    if Assigned(Context) then
    begin
      LConnection := TDBXSqliteConnection(TDBXDataExpressProviderContext(Context).Connection);
      if Assigned(LConnection) then
      begin
        DBXContext := TDBXContext.Create;
        try
          LCommand := TDBXSqliteCommand.Create(DBXContext, LConnection);
          try
            LCommand.Text := 'select sql from sqlite_master where name = ''' + Table + '''';
            LReader := TDBXSqliteReader(LCommand.ExecuteQuery);
            try
              MemTable := TDBXMemoryTable.Create;
              try
                TableColumns := TDBXMetaDataCollectionColumns.CreateForeignKeyColumnsColumns;
                MemTable.Columns := TableColumns;
                Scanner := TDBXSqlScanner.Create(GetSqlIdentifierQuoteChar, GetSqlIdentifierQuotePrefix, GetSqlIdentifierQuoteSuffix);
                try
                  Scanner.RegisterId(Ref, RefIndex);
                  Scanner.RegisterId(Foreign, ForeignIndex);
                  LReader.Next;
                  Scanner.Init(LReader.Value[0].AsString);
                  MemTable.Insert; //Dummy Row
                  Scan(Scanner, MemTable);
                finally
                  Scanner.Free;
                end;
                MemTable.First;
                Cursor := TDBXStringTrimTable.CreateTrimTableIfNeeded(MemTable);
                Cursor := TDBXCustomMetaDataTable.Create(GetContext, TDBXMetaDataCollectionName.ForeignKeyColumns, Columns, Cursor);
                Result := TDBXSqliteColumnsTableCursor.Create(Self, False, Cursor);
              except
                MemTable.Free;
                raise;
              end;
            finally
              LReader.Free;
            end;
          finally
            LCommand.Free;
          end;
        finally
          DBXContext.Free;
        end;
      end;
    end;
  end;
end;

function TDBXSqliteCustomMetaDataReader.FetchForeignKeys(const Catalog: string; const Schema: string; const Table: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateForeignKeysColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.ForeignKeys, Columns);
end;

function TDBXSqliteCustomMetaDataReader.FetchIndexColumns(const Catalog: string; const Schema: string; const Table: string; const Index: string): TDBXTable;
  procedure Scan(Scanner: TDBXSqlScanner; MemTable: TDBXMemoryTable);
  var
    Token, Ordinal: Integer;
    TableName, ColumnName, IndexName: string;
    IsAscending, IsDescending: Boolean;
  begin
    Ordinal := 0;
    Scanner.NextToken;
    Token := Scanner.NextToken;
    while Token <> TDBXSqlScanner.TokenEos do
    begin
      if Token = IndexToken then
      begin
        while Token <> OnIndex do
          Token := Scanner.NextToken;
        Scanner.NextToken;
        TableName := Scanner.Id;
        Token := Scanner.NextToken;
        while (Token <> TDBXSqlScanner.TokenEos) and (Token <> TDBXSqlScanner.TokenCloseParen) do
        begin
          MemTable.Insert;
          Scanner.NextToken;
          MemTable.Value[2].AsString := TableName;
          MemTable.Value[3].AsString := Table;
          MemTable.Value[4].AsString := Scanner.Id;
          MemTable.Value[5].AsInt32 := Ordinal;
          Inc(Ordinal);
          Token := Scanner.NextToken;
          if Token = CollateIndex then
          begin
            Scanner.NextToken;
            MemTable.Value[8].AsString := Scanner.Id;
            Token := Scanner.NextToken;
          end;

          if Token = AscIndex then
          begin
            MemTable.Value[6].AsBoolean := True;
            MemTable.Value[7].AsBoolean := False;
            Token := Scanner.NextToken;
          end
          else if Token = DescIndex then
          begin
            MemTable.Value[6].AsBoolean := False;
            MemTable.Value[7].AsBoolean := True;
            Token := Scanner.NextToken;
          end
          else
          begin
            MemTable.Value[6].AsBoolean := False;
            MemTable.Value[7].AsBoolean := False;
          end;
        end;
      end
      else if Token = TableToken then
      begin
        Token := Scanner.LookAtNextToken;
        while Token <> TDBXSqlScanner.TokenOpenParen do
        begin
          Scanner.NextToken;
          TableName := Scanner.Id;
          Token := Scanner.LookAtNextToken;
        end;
        Token := Scanner.NextToken;
        while (Token <> TDBXSqlScanner.TokenCloseParen) and (Token <> TDBXSqlScanner.TokenEos) do
        begin
          Scanner.NextToken;
          ColumnName := Scanner.Id;
          IndexName := '';
          IsAscending := False;
          IsDescending := False;
          Token := Scanner.NextToken;
          while (Token <> TDBXSqlScanner.TokenComma) and (Token <> TDBXSqlScanner.TokenCloseParen) and (Token <> TDBXSqlScanner.TokenEos) do
          begin
            if Token = ConstraintToken then
            begin
              Scanner.NextToken;
              IndexName := Scanner.Id;
              Token := Scanner.NextToken;
            end
            else if Token = PrimaryToken then
            begin
              Scanner.NextToken;
              Token := Scanner.NextToken;
              if Token = AscIndex then
                IsAscending := True
              else if Token = DescIndex then
                IsDescending := True;
              MemTable.Insert;
              MemTable.Value[2].AsString := TableName;
              MemTable.Value[3].AsString := IndexName;
              MemTable.Value[4].AsString := ColumnName;
              MemTable.Value[5].AsInt32 := Ordinal;
              Inc(Ordinal);
              MemTable.Value[6].AsBoolean := IsAscending;
              MemTable.Value[7].AsBoolean := IsDescending;
            end
            else
              Token := Scanner.NextToken;
          end;
        end;
      end;
      Token := Scanner.NextToken;
    end;
  end;
const
  OnConst = 'ON';
  Collate = 'COLLATE';
  Asc = 'ASC';
  Desc = 'DESC';
  IndexConst = 'INDEX';
  TableConst = 'TABLE';
  PrimaryConst = 'PRIMARY';
  ConstraintConst = 'CONSTRAINT';
var
  Columns, TableColumns: TDBXValueTypeArray;
  DBXContext: TDBXContext;
  LConnection: TDBXSqliteConnection;
  LCommand: TDBXSqliteCommand;
  LReader: TDBXSqliteReader;
  MemTable: TDBXMemoryTable;
  I: Integer;
  Scanner: TDBXSqlScanner;
  Cursor: TDBXTable;
begin
  Result := nil;
  if Table = '' then
  begin
    Columns := TDBXMetaDataCollectionColumns.CreateIndexColumnsColumns;
    Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.IndexColumns, Columns);
  end
  else
  begin
    if Assigned(Context) then
    begin
      LConnection := TDBXSqliteConnection(TDBXDataExpressProviderContext(Context).Connection);
      if Assigned(LConnection) then
      begin
        DBXContext := TDBXContext.Create;
        try
          LCommand := TDBXSqliteCommand.Create(DBXContext, LConnection);
          try
            LCommand.Text := 'select sql from sqlite_master where name = ''' + Table + ''' collate nocase';
            LReader := TDBXSqliteReader(LCommand.ExecuteQuery);
            try
              SetLength(Columns, 9);
              Columns[0] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexColumnsColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
              Columns[1] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexColumnsColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
              Columns[2] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexColumnsColumns.TableName, STableName, TDBXDataTypes.WideStringType);
              Columns[3] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexColumnsColumns.IndexName, SIndexName, TDBXDataTypes.WideStringType);
              Columns[4] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexColumnsColumns.ColumnName, SColumnName, TDBXDataTypes.WideStringType);
              Columns[5] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexColumnsColumns.Ordinal, SOrdinal, TDBXDataTypes.Int32Type);
              Columns[6] := TDBXMetaDataCollectionColumns.CreateValueType(TDBXIndexColumnsColumns.IsAscending, SIsAscending, TDBXDataTypes.BooleanType);
              Columns[7] := TDBXMetaDataCollectionColumns.CreateValueType('IsDescending', 'Descending', TDBXDataTypes.BooleanType, True);
              Columns[8] := TDBXMetaDataCollectionColumns.CreateValueType('CollationName', 'Collation Name', TDBXDataTypes.WideStringType, True);

              MemTable := TDBXMemoryTable.Create;
              try
                SetLength(TableColumns, Length(Columns));
                for I := 0 to Length(Columns) - 1 do
                  TableColumns[I] := Columns[I].Clone;
                MemTable.Columns := TableColumns;
                Scanner := TDBXSqlScanner.Create(GetSqlIdentifierQuoteChar, GetSqlIdentifierQuotePrefix, GetSqlIdentifierQuoteSuffix);
                try
                  Scanner.RegisterId(OnConst, OnIndex);
                  Scanner.RegisterId(Collate, CollateIndex);
                  Scanner.RegisterId(Asc, AscIndex);
                  Scanner.RegisterId(Desc, DescIndex);
                  Scanner.RegisterId(IndexConst, IndexToken);
                  Scanner.RegisterId(TableConst, TableToken);
                  Scanner.RegisterId(PrimaryConst, PrimaryToken);
                  Scanner.RegisterId(ConstraintConst, ConstraintToken);
                  LReader.Next;
                  Scanner.Init(LReader.Value[0].AsString);
                  MemTable.Insert; //Dummy Row
                  Scan(Scanner, MemTable);
                finally
                  Scanner.Free;
                end;
                MemTable.First;
                Cursor := TDBXStringTrimTable.CreateTrimTableIfNeeded(MemTable);
                Cursor := TDBXCustomMetaDataTable.Create(GetContext, TDBXMetaDataCollectionName.IndexColumns, Columns, Cursor);
                Result := TDBXSqliteColumnsTableCursor.Create(Self, False, Cursor);
              except
                MemTable.Free;
                raise;
              end;
            finally
              LReader.Free;
            end;
          finally
            LCommand.Free;
          end;
        finally
          DBXContext.Free;
        end;
      end;
    end;
  end;
end;

function TDBXSqliteCustomMetaDataReader.FetchPackageProcedureParameters(const Catalog: string; const Schema: string; const PackageName: string; const ProcedureName: string; const ParameterName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProcedureParametersColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageProcedureParameters, Columns);
end;

function TDBXSqliteCustomMetaDataReader.FetchPackageProcedures(const Catalog: string; const Schema: string; const PackageName: string; const ProcedureName: string; const ProcedureType: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProceduresColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageProcedures, Columns);
end;

function TDBXSqliteCustomMetaDataReader.FetchPackages(const Catalog: string; const Schema: string; const PackageName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackagesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Packages, Columns);
end;

function TDBXSqliteCustomMetaDataReader.FetchPackageSources(const Catalog: string; const Schema: string; const PackageName: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreatePackageSourcesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.PackageSources, Columns);
end;

function TDBXSqliteCustomMetaDataReader.FetchProcedureParameters(const Catalog: string; const Schema: string; const Proc: string; const Parameter: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateProcedureParametersColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.ProcedureParameters, Columns);
end;

function TDBXSqliteCustomMetaDataReader.FetchProcedures(const Catalog: string; const Schema: string; const ProcedureName: string; const ProcedureType: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateProceduresColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Procedures, Columns);
end;

function TDBXSqliteCustomMetaDataReader.FetchProcedureSources(const Catalog: string; const Schema: string; const Proc: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateProcedureSourcesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.ProcedureSources, Columns);
end;

function TDBXSqliteCustomMetaDataReader.FetchRoles: TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateRolesColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Roles, Columns);
end;

function TDBXSqliteCustomMetaDataReader.FetchSchemas(const Catalog: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateSchemasColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Schemas, Columns);
end;

function TDBXSqliteCustomMetaDataReader.FetchSynonyms(const Catalog: string; const Schema: string; const Synonym: string): TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateSynonymsColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Synonyms, Columns);
end;

function TDBXSqliteCustomMetaDataReader.FetchUsers: TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateUsersColumns;
  Result := TDBXEmptyTableCursor.Create(TDBXMetaDataCollectionName.Users, Columns);
end;

{ TDBXSqliteColumnsTableCursor }

function TDBXSqliteColumnsTableCursor.GetWritableValue(
  const Ordinal: Integer): TDBXWritableValue;
begin
  Result := FTable.Value[Ordinal];
end;

constructor TDBXSqliteColumnsTableCursor.Create(const Reader: TDBXBaseMetaDataReader;
  const CheckBase: Boolean; const Cursor: TDBXTable);
const
  DbxDataTypeIndex = 7;
var
  DataTypeColumns: TDBXValueTypeArray;
  Ordinal: Integer;
begin
  inherited Create;
  Table := Cursor;
  FDataTypeHash := Reader.DataTypeHash;
  FReader := Reader;
  FCheckBase := CheckBase;
  if DBXTableName = TDBXMetaDataCollectionName.Columns then
  begin
    FOrdinalOffset := 0;
    FOrdinalTypeName := 2;
    SetLength(DataTypeColumns, 1);
    for Ordinal := 0 to Length(DataTypeColumns) - 1 do
      DataTypeColumns[Ordinal] := TDBXValueType(Cursor.Columns[Ordinal + DbxDataTypeIndex].Clone);

    FDataTypesRow := TDBXSingleValueRow.Create;
    FDataTypesRow.Columns := DataTypeColumns;
  end;
end;

destructor TDBXSqliteColumnsTableCursor.Destroy;
begin
  if DBXTableName = TDBXMetaDataCollectionName.Columns then
    FDataTypesRow.Free;
  inherited Destroy;
end;

function TDBXSqliteColumnsTableCursor.Next: Boolean;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FTable.Next;
  if ReturnValue and (DBXTableName = TDBXMetaDataCollectionName.Columns) then
    FDataType := TDBXDataTypeDescription(FDataTypeHash[FTable.Value[FOrdinalTypeName].AsString]);
  Result := ReturnValue;
end;

end.
