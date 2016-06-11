{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                FireDAC SQLite metadata                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.SQLiteMeta;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.Meta, FireDAC.Phys.SQLGenerator;

type
  TFDPhysSQLiteBrand = (sbSQLite, sbBDB);

  IFDPhysSQLiteConnectionMetadata = interface (IUnknown)
    ['{91D454A4-327D-4ED2-8EF5-3F77BFB5B619}']
    // private
    function GetBrand: TFDPhysSQLiteBrand;
    // public
    property Brand: TFDPhysSQLiteBrand read GetBrand;
  end;

  TFDPhysSQLiteMetadata = class (TFDPhysConnectionMetadata, IFDPhysSQLiteConnectionMetadata)
  private
    FBrand: TFDPhysSQLiteBrand;
    FColumnOriginProvided: Boolean;
  protected
    // IFDPhysConnectionMetadata
    function GetKind: TFDRDBMSKind; override;
    function GetTxSavepoints: Boolean; override;
    function GetEventSupported: Boolean; override;
    function GetEventKinds: String; override;
    function GetParamNameMaxLength: Integer; override;
    function GetNameParts: TFDPhysNameParts; override;
    function GetNameQuoteChar(AQuote: TFDPhysNameQuoteLevel; ASide: TFDPhysNameQuoteSide): Char; override;
    function GetNameQuotedCaseSensParts: TFDPhysNameParts; override;
    function GetNameQuotedCaseSens(const AName: String; APart: TFDPhysNamePart): Boolean; override;
    function GetNameCaseSensParts: TFDPhysNameParts; override;
    function GetNameDefLowCaseParts: TFDPhysNameParts; override;
    function GetIdentityInsertSupported: Boolean; override;
    function GetNamedParamMark: TFDPhysParamMark; override;
    function GetPositionedParamMark: TFDPhysParamMark; override;
    function GetSelectOptions: TFDPhysSelectOptions; override;
    function GetAsyncAbortSupported: Boolean; override;
    function GetArrayExecMode: TFDPhysArrayExecMode; override;
    function GetLimitOptions: TFDPhysLimitOptions; override;
    function GetDefValuesSupported: TFDPhysDefaultValues; override;
    function GetColumnOriginProvided: Boolean; override;
    function GetInlineRefresh: Boolean; override;
    function GetTruncateSupported: Boolean; override;
    function GetCreateTableOptions: TFDPhysCreateTableOptions; override;
    function InternalEscapeBoolean(const AStr: String): String; override;
    function InternalEscapeDate(const AStr: String): String; override;
    function InternalEscapeDateTime(const AStr: String): String; override;
    function InternalEscapeFloat(const AStr: String): String; override;
    function InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String; override;
    function InternalEscapeTime(const AStr: String): String; override;
    function InternalGetSQLCommandKind(const ATokens: TStrings): TFDPhysCommandKind; override;
    // IFDPhysSQLiteConnectionMetadata
    function GetBrand: TFDPhysSQLiteBrand;
  public
    constructor Create(const AConnection: TFDPhysConnection;
      ABrand: TFDPhysSQLiteBrand; AServerVersion, AClientVersion: TFDVersion;
      AIsUnicode, AColumnOriginProvided: Boolean);
  end;

  TFDPhysSQLiteCommandGenerator = class(TFDPhysCommandGenerator)
  protected
    function GetIdentity(ASessionScope: Boolean): String; override;
    function GetRowId(var AAlias: String): String; override;
    function GetReadGenerator(const AName, AAlias: String;
      ANextValue, AFullSelect: Boolean): String; override;
    function GetInlineRefresh(const AStmt: String;
      ARequest: TFDUpdateRequest): String; override;
    function GetCommitSavepoint(const AName: String): String; override;
    function GetRollbackToSavepoint(const AName: String): String; override;
    function GetSavepoint(const AName: String): String; override;
    function GetCall(const AName: String): String; override;
    function GetSelectMetaInfo(AKind: TFDPhysMetaInfoKind;
      const ACatalog, ASchema, ABaseObject, AObject, AWildcard: String;
      AObjectScopes: TFDPhysObjectScopes; ATableKinds: TFDPhysTableKinds;
      AOverload: Word): String; override;
    function GetLimitSelect(const ASQL: String; ASkip, ARows: Integer): String; override;
    function GetColumnType(AColumn: TFDDatSColumn): String; override;
    function GetMerge(AAction: TFDPhysMergeAction): String; override;
  end;

implementation

uses
  System.SysUtils,
  FireDAC.Stan.Consts, FireDAC.Stan.Util, FireDAC.Stan.Error;

{-------------------------------------------------------------------------------}
{ TFDPhysSQLiteMetadata                                                         }
{-------------------------------------------------------------------------------}
constructor TFDPhysSQLiteMetadata.Create(const AConnection: TFDPhysConnection;
  ABrand: TFDPhysSQLiteBrand; AServerVersion, AClientVersion: TFDVersion;
  AIsUnicode, AColumnOriginProvided: Boolean);
begin
  inherited Create(AConnection, AServerVersion, AClientVersion, AIsUnicode);
  FBrand := ABrand;
  FColumnOriginProvided := AColumnOriginProvided;
  FKeywords.CommaText :=
    'ABORT,ADD,AFTER,ALL,ALTER,ANALYZE,AND,AS,ASC,ATTACH,AUTOINCREMENT,BEFORE,' +
    'BEGIN,BETWEEN,BY,CASCADE,CASE,CAST,CHECK,COLLATE,COLUMN,COMMIT,CONFLICT,' +
    'CONSTRAINT,CREATE,CROSS,CURRENT_DATE,CURRENT_TIME,CURRENT_TIMESTAMP,DATABASE,' +
    'DEFAULT,DEFERRABLE,DEFERRED,DELETE,DESC,DETACH,DISTINCT,DROP,EACH,ELSE,END,' +
    'ESCAPE,EXCEPT,EXCLUSIVE,EXISTS,EXPLAIN,FAIL,FOR,FOREIGN,FROM,FULL,GLOB,GROUP,' +
    'HAVING,IF,IGNORE,IMMEDIATE,IN,INDEX,INITIALLY,INNER,INSERT,INSTEAD,INTERSECT,' +
    'INTO,IS,ISNULL,JOIN,KEY,LEFT,LIKE,LIMIT,MATCH,NATURAL,NOT,NOTNULL,NULL,OF,' +
    'OFFSET,ON,OR,ORDER,OUTER,PLAN,PRAGMA,PRIMARY,QUERY,RAISE,REFERENCES,REGEXP,' +
    'REINDEX,RENAME,REPLACE,RESTRICT,RIGHT,ROLLBACK,ROW,SELECT,SET,TABLE,TEMP,' +
    'TEMPORARY,THEN,TO,TRANSACTION,TRIGGER,UNION,UNIQUE,UPDATE,USING,VACUUM,' +
    'VALUES,VIEW,VIRTUAL,WHEN,WHERE';
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.SQLite;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetNameCaseSensParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetNameDefLowCaseParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetParamNameMaxLength: Integer;
begin
  Result := MAXINT;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetNameParts: TFDPhysNameParts;
begin
  Result := [npCatalog, npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetNameQuoteChar(AQuote: TFDPhysNameQuoteLevel;
  ASide: TFDPhysNameQuoteSide): Char;
begin
  Result := #0;
  case AQuote of
  ncDefault:
    Result := '"';
  ncSecond:
    if ASide = nsLeft then
      Result := '['
    else
      Result := ']';
  ncThird:
    Result := '`';
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetNameQuotedCaseSensParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetNameQuotedCaseSens(const AName: String;
  APart: TFDPhysNamePart): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 1 to Length(AName) do
    if not FDInSet(AName[i], ['a' .. 'z', 'A' .. 'Z', '0' .. '9',
                              '_', '$', '#', '"', '[', ']', '`']) then begin
      Result := True;
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetNamedParamMark: TFDPhysParamMark;
begin
  Result := prName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetPositionedParamMark: TFDPhysParamMark;
begin
  Result := prQNumber;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetTxSavepoints: Boolean;
begin
  Result := GetServerVersion >= svSQLite030608;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetEventSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetEventKinds: String;
begin
  Result := S_FD_EventKind_SQLite_Events;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetTruncateSupported: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetInlineRefresh: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetSelectOptions: TFDPhysSelectOptions;
begin
  Result := [soWithoutFrom, soInlineView];
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysSQLiteMetadata.GetAsyncAbortSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetDefValuesSupported: TFDPhysDefaultValues;
begin
  Result := dvDefVals;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetColumnOriginProvided: Boolean;
begin
  Result := FColumnOriginProvided;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetIdentityInsertSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetArrayExecMode: TFDPhysArrayExecMode;
begin
  if GetServerVersion >= svSQLite030711 then
    Result := aeOnErrorUndoAll
  else
    Result := aeUpToFirstError;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetLimitOptions: TFDPhysLimitOptions;
begin
  Result := [loSkip, loRows];
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetCreateTableOptions: TFDPhysCreateTableOptions;
begin
  Result := [ctDefaultFirst, ctNoAlterTableConstraint];
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.GetBrand: TFDPhysSQLiteBrand;
begin
  Result := FBrand;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.InternalEscapeBoolean(const AStr: String): String;
begin
  if CompareText(AStr, S_FD_True) = 0 then
    Result := '1'
  else
    Result := '0';
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.InternalEscapeDate(const AStr: String): String;
begin
  Result := AnsiQuotedStr(AStr, '''');
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.InternalEscapeDateTime(const AStr: String): String;
begin
  Result := AnsiQuotedStr(AStr, '''');
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.InternalEscapeTime(const AStr: String): String;
begin
  Result := AnsiQuotedStr(AStr, '''');
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.InternalEscapeFloat(const AStr: String): String;
begin
  Result := 'CAST(' + AnsiQuotedStr(AStr, '''') + ' AS REAL)';
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String;
var
  sName, A1, A2, A3: String;
  i: Integer;

  function AddArgs: string;
  begin
    Result := '(';
    if Length(ASeq.FArgs) > 0 then
      Result := Result + AddEscapeSequenceArgs(ASeq);
    Result := Result + ')';
  end;

  function Unquote(const AValue: String): String;
  begin
    Result := Trim(AValue);
    if Result[1] = '''' then
      Result := Copy(Result, 2, Length(Result) - 2);
  end;

begin
  sName := ASeq.FName;
  if Length(ASeq.FArgs) >= 1 then begin
    A1 := ASeq.FArgs[0];
    if Length(ASeq.FArgs) >= 2 then begin
      A2 := ASeq.FArgs[1];
      if Length(ASeq.FArgs) >= 3 then
        A3 := ASeq.FArgs[2];
    end;
  end;
  case ASeq.FFunc of
  // numeric
  efRANDOM:
    begin
      Result := '(ABS(RANDOM()) / 9223372036854775807)';
      if Length(ASeq.FArgs) = 1 then
        Result := '(' + Result + ' * (' + A1 + '))';
    end;
  efDEGREES,
  efRADIANS,
  efTRUNCATE,
  efLOG,
  efROUND,
  efABS,
  efACOS,
  efASIN,
  efATAN,
  efATAN2,
  efCEILING,
  efCOS,
  efCOT,
  efEXP,
  efFLOOR,
  efLOG10,
  efMOD,
  efPI,
  efPOWER,
  efSIGN,
  efSIN,
  efSQRT,
  efTAN:         Result := sName + AddArgs;

  // character
  efBIT_LENGTH:  Result := '(OCTET_LENGTH(' + A1 + ') * 8)';
  efASCII,
  efCHAR,
  efCONCAT,
  efLCASE,
  efLENGTH,
  efLOCATE,
  efPOSITION,
  efLTRIM,
  efREPEAT,
  efRTRIM,
  efSPACE,
  efUCASE,
  efCHAR_LENGTH,
  efOCTET_LENGTH,
  efREPLACE,
  efSUBSTRING:   Result := sName + AddArgs;

  // See comment in FireDAC.Phys.SQLiteWrapper, TSQLiteExpressionFunction.Create
  efINSERT,
  efLEFT,
  efRIGHT:       Result := sName + '_' + AddArgs;

  // system
  efCATALOG:     Result := '''MAIN''';
  efSCHEMA:      Result := '''''';
  efIFNULL:      Result := 'CASE WHEN ' + A1 + ' IS NULL THEN ' + A2 + ' ELSE ' + A1 + ' END';
  efIF:          Result := 'CASE WHEN ' + A1 + ' THEN ' + A2 + ' ELSE ' + A3 + ' END';
  efDECODE:
    begin
      Result := 'CASE ' + ASeq.FArgs[0];
      i := 1;
      while i < Length(ASeq.FArgs) - 1 do begin
        Result := Result + ' WHEN ' + ASeq.FArgs[i] + ' THEN ' + ASeq.FArgs[i + 1];
        Inc(i, 2);
      end;
      if i = Length(ASeq.FArgs) - 1 then
        Result := Result + ' ELSE ' + ASeq.FArgs[i];
      Result := Result + ' END';
    end;

  // convert
  efCONVERT:
    begin
      A2 := UpperCase(Trim(A2));
      if A2 = 'DATE' then
        Result := 'DATE(' + A1 + ')'
      else if A2 = 'TIME' then
        Result := 'TIME(' + A1 + ')'
      else if (A2 = 'DATETIME') or (A2 = 'TIMESTAMP') then
        Result := 'DATETIME(' + A1 + ')'
      else
        Result := 'CAST(' + A1 + ' AS ' + A2 + ')';
    end;

  // date and time
  efCURDATE:     Result := 'DATE(''NOW'')';
  efCURTIME:     Result := 'TIME(''NOW'')';
  efNOW:         Result := 'DATETIME(''NOW'')';
  efDAYNAME:
    begin
      Result := 'CASE STRFTIME(''%w'', ' + A1 + ')';
      for i := 1 to 7 do
        Result := Result + ' WHEN ''' + IntToStr(i mod 7) + ''' THEN ''' +
          AnsiUpperCase(FormatSettings.LongDayNames[i mod 7 + 1]) + '''';
      Result := Result + ' END';
    end;
  efDAYOFMONTH:  Result := 'CAST(STRFTIME(''%d'', ' + A1 + ') AS INT)';
  efDAYOFWEEK:   Result := '(STRFTIME(''%w'', ' + A1 + ') + 1)';
  efDAYOFYEAR:   Result := 'CAST(STRFTIME(''%j'', ' + A1 + ') AS INT)';
  efHOUR:        Result := 'CAST(STRFTIME(''%H'', ' + A1 + ') AS INT)';
  efMINUTE:      Result := 'CAST(STRFTIME(''%M'', ' + A1 + ') AS INT)';
  efMONTH:       Result := 'CAST(STRFTIME(''%m'', ' + A1 + ') AS INT)';
  efMONTHNAME:
    begin
      Result := 'CASE STRFTIME(''%m'', ' + A1 + ')';
      for i := 1 to 12 do
        Result := Result + ' WHEN ''' + Format('%.2d', [i]) + ''' THEN ''' +
          AnsiUpperCase(FormatSettings.LongMonthNames[i]) + '''';
      Result := Result + ' END';
    end;
  efSECOND:      Result := 'CAST(STRFTIME(''%S'', ' + A1 + ') AS INT)';
  efWEEK:        Result := '(STRFTIME(''%W'', ' + A1 + ') + 1)';
  efYEAR:        Result := 'CAST(STRFTIME(''%Y'', ' + A1 + ') AS INT)';

  efEXTRACT,
  efQUARTER,
  efTIMESTAMPADD,
  efTIMESTAMPDIFF:
                 Result := sName + AddArgs;
  else
    UnsupportedEscape(ASeq);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteMetadata.InternalGetSQLCommandKind(
  const ATokens: TStrings): TFDPhysCommandKind;
var
  sToken: String;
begin
  sToken := ATokens[0];
  if sToken = 'BEGIN' then
    Result := skStartTransaction
  else if sToken = 'END' then
    Result := skCommit
  else if sToken = 'EXPLAIN' then
    Result := skSelect
  else if sToken = 'REPLACE' then
    Result := skMerge
  else if sToken = 'UPDATE' then
    if ATokens.Count < 3 then
      Result := skNotResolved
    else if (ATokens[1] = 'OR') and (ATokens[2] = 'INSERT') then
      Result := skMerge
    else
      Result := skUpdate
  else if sToken = 'INSERT' then
    if (ATokens.Count = 1) or
       (ATokens.Count = 2) and (ATokens[1] = 'OR') then
      Result := skNotResolved
    else if (ATokens.Count = 3) and (ATokens[1] = 'OR') and (ATokens[2] = 'UPDATE') then
      Result := skMerge
    else
      Result := skInsert
  else if sToken = 'VALUES' then
    Result := skSelect
  else
    Result := inherited InternalGetSQLCommandKind(ATokens);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysSQLiteCommandGenerator                                                 }
{-------------------------------------------------------------------------------}
function TFDPhysSQLiteCommandGenerator.GetIdentity(ASessionScope: Boolean): String;
begin
  // LAST_INSERT_AUTOGEN is a custom function registered by FireDAC.Phys.SQLiteWrapper.
  // It returns last auto-inc value from a target dataset in LocalSQL mode, otherwise
  // redirects to LAST_INSERT_ROWID.
  Result := 'LAST_INSERT_AUTOGEN()';
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteCommandGenerator.GetRowId(var AAlias: String): String;
begin
  Result := 'ROWID';
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteCommandGenerator.GetReadGenerator(const AName,
  AAlias: String; ANextValue, AFullSelect: Boolean): String;
begin
  if ANextValue or (AName <> '') and not AFullSelect then
    FDCapabilityNotSupported(Self, [S_FD_LPhys]);
  if AName = '' then
    Result := inherited GetReadGenerator(AName, AAlias, ANextValue, AFullSelect)
  else begin
    Result := 'SELECT seq ';
    if AAlias <> '' then
      Result := Result + ' AS ' + AAlias;
    Result := Result + ' FROM sqlite_sequence WHERE name = ''' + AName + '''';
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteCommandGenerator.GetInlineRefresh(const AStmt: String;
  ARequest: TFDUpdateRequest): String;
begin
  Result := GenerateSelect(False);
  if Result <> '' then
    Result := AStmt + ';' + BRK + Result
  else
    Result := AStmt;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteCommandGenerator.GetCall(const AName: String): String;
begin
  Result := 'SELECT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteCommandGenerator.GetSavepoint(const AName: String): String;
begin
  Result := 'SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteCommandGenerator.GetCommitSavepoint(const AName: String): String;
begin
  Result := 'RELEASE SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteCommandGenerator.GetRollbackToSavepoint(const AName: String): String;
begin
  Result := 'ROLLBACK TO SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteCommandGenerator.GetSelectMetaInfo(AKind: TFDPhysMetaInfoKind;
  const ACatalog, ASchema, ABaseObject, AObject, AWildcard: String;
  AObjectScopes: TFDPhysObjectScopes; ATableKinds: TFDPhysTableKinds;
  AOverload: Word): String;
var
  lWasWhere: Boolean;
  sCat, sDatabase, sWhere, sScope: String;

  procedure AddWhere(const ACond: String);
  begin
    if lWasWhere then
      Result := Result + ' AND ' + ACond
    else begin
      Result := Result + ' WHERE ' + ACond;
      lWasWhere := True;
    end;
  end;

begin
  if (ACatalog <> '') and (CompareText(ACatalog, 'MAIN') <> 0) then begin
    sCat := ACatalog + '.';
    sDatabase := ACatalog;
  end
  else begin
    sCat := '';
    sDatabase := 'MAIN';
  end;
  lWasWhere := False;
  Result := '';
  case AKind of
  mkCatalogs:
    Result := 'PRAGMA database_list';
  mkSchemas:
    ;
  mkTables:
    begin
      if CompareText(ACatalog, 'TEMP') = 0 then
        sCat := '';
      Result := 'SELECT NULL AS RECNO, ''' + sDatabase + ''' AS CATALOG_NAME, ' +
        'NULL AS SCHEMA_NAME, tbl_name AS TABLE_NAME, ' +
        'CASE type ' +
          'WHEN ''table'' THEN ' +
            'CASE tmp '+
            'WHEN 0 THEN ' + IntToStr(Integer(tkTable)) +
            ' ELSE ' + IntToStr(Integer(tkTempTable)) +
            ' END ' +
          'WHEN ''view'' THEN ' + IntToStr(Integer(tkView)) +
        ' END AS TABLE_TYPE, ' +
        'CASE ' +
          'WHEN instr(tbl_name, ''sqlite_'')=1 THEN ' + IntToStr(Integer(osSystem)) +
          ' ELSE ' + IntToStr(Integer(osMy)) +
          ' END AS TABLE_SCOPE ' +
        'FROM (' +
          'SELECT t1.*, 0 AS tmp FROM ' + sCat + 'sqlite_master t1 ' +
          'UNION ALL ' +
          'SELECT t2.*, 1 AS tmp FROM sqlite_temp_master t2 ' +
          'UNION ALL ' +
          'SELECT ''table'', ''sqlite_master'', ''sqlite_master'', 0, null, 0 ' +
          'UNION ALL ' +
          'SELECT ''table'', ''sqlite_temp_master'', ''sqlite_temp_master'', 0, null, 1 ' +
        ')';
      sWhere := '';

      if CompareText(ACatalog, 'TEMP') = 0 then
        AddWhere('tmp = 1');

      if tkTable in ATableKinds then
        sWhere := sWhere + ' OR type = ''table'' AND tmp = 0';
      if tkTempTable in ATableKinds then
        sWhere := sWhere + ' OR type = ''table'' AND tmp = 1';
      if tkView in ATableKinds then
        sWhere := sWhere + ' OR type = ''view''';
      if ([tkSynonym, tkLocalTable] * ATableKinds <> []) or
         (ATableKinds = []) then
        sWhere := sWhere + ' OR 0 = 1';
      AddWhere('(' + Copy(sWhere, 5, MAXINT) + ')');

      if AObjectScopes * [osMy, osSystem] <> [osMy, osSystem] then begin
        sScope := '';
        if osMy in AObjectScopes then
          sScope := 'instr(tbl_name, ''sqlite_'')=0 OR ';
        if osSystem in AObjectScopes then
          sScope := 'instr(tbl_name, ''sqlite_'')=1 OR ';
        if sScope <> '' then
          AddWhere('(' + Copy(sScope, 1, Length(sScope) - 4) + ')');
      end;

      if AWildcard <> '' then
        AddWhere('tbl_name LIKE ''' + AWildcard + '''');
      Result := Result + ' ORDER BY UPPER(tbl_name)';
    end;
  mkTableFields,
  mkPrimaryKey:
    Result := 'PRAGMA ' + sCat + 'table_info("' + AObject + '")';
  mkPrimaryKeyFields:
    Result := 'PRAGMA ' + sCat + 'table_info("' + ABaseObject + '")';
  mkIndexes:
    Result := 'PRAGMA ' + sCat + 'index_list("' + AObject + '")';
  mkIndexFields:
    if FConnMeta.ServerVersion >= svSQLite030809 then
      Result := 'PRAGMA ' + sCat + 'index_xinfo("' + AObject + '")'
    else
      Result := 'PRAGMA ' + sCat + 'index_info("' + AObject + '")';
  mkForeignKeys:
    Result := 'PRAGMA ' + sCat + 'foreign_key_list("' + AObject + '")';
  mkForeignKeyFields:
    Result := 'PRAGMA ' + sCat + 'foreign_key_list("' + ABaseObject + '")';
  mkPackages,
  mkProcs,
  mkProcArgs,
  mkGenerators,
  mkResultSetFields,
  mkTableTypeFields:
    ;
  else
    Result := '';
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteCommandGenerator.GetLimitSelect(const ASQL: String;
  ASkip, ARows: Integer): String;
begin
  if (ASkip > 0) and (ARows + ASkip <> MAXINT) then
    Result := ASQL + BRK + 'LIMIT ' + IntToStr(ARows) + ' OFFSET ' + IntToStr(ASkip)
  else if ASkip > 0 then
    Result := ASQL + BRK + 'LIMIT -1 OFFSET ' + IntToStr(ASkip)
  else if ARows >= 0 then
    Result := ASQL + BRK + 'LIMIT ' + IntToStr(ARows)
  else
    Result := ASQL;
end;

{-------------------------------------------------------------------------------}
// http://docwiki.embarcadero.com/RADStudio/en/Using_SQLite_with_FireDAC#Mapping_SQLite_to_FireDAC_Data_Types
function TFDPhysSQLiteCommandGenerator.GetColumnType(AColumn: TFDDatSColumn): String;
begin
  if (caAutoInc in AColumn.ActualAttributes) and
     ((AColumn.DataType in [dtSByte, dtInt16, dtInt32, dtInt64, dtByte, dtUInt16, dtUInt32, dtUInt64]) or
      (AColumn.DataType in [dtBCD, dtFmtBCD, dtSingle, dtDouble, dtExtended]) and (AColumn.Scale = 0)) then begin
    // SQLite auto-incrementing column must be INTEGER PRIMARY KEY.
    // Otherwise syntax error is returned. Here PRIMARY KEY is optimistic,
    // but in most cases will work.
    Result := 'INTEGER PRIMARY KEY AUTOINCREMENT';
    Exit;
  end;
  case AColumn.DataType of
  dtBoolean:
    Result := 'BOOLEAN';
  dtSByte:
    Result := 'TINYINT';
  dtInt16:
    Result := 'SMALLINT';
  dtInt32:
    Result := 'INTEGER';
  dtInt64:
    Result := 'BIGINT';
  dtByte:
    Result := 'TINYINT UNSIGNED';
  dtUInt16:
    Result := 'SMALLINT UNSIGNED';
  dtUInt32:
    Result := 'INTEGER UNSIGNED';
  dtUInt64:
    Result := 'BIGINT UNSIGNED';
  dtSingle:
    Result := 'SINGLE';
  dtDouble,
  dtExtended:
    Result := 'DOUBLE';
  dtCurrency:
    Result := 'MONEY';
  dtBCD,
  dtFmtBCD:
    Result := 'NUMERIC' + GetColumnDim(-1, AColumn.Precision, AColumn.Scale, -1,
      FOptions.FormatOptions.MaxBcdPrecision, FOptions.FormatOptions.MaxBcdScale);
  dtDateTime:
    Result := 'DATETIME';
  dtTime:
    Result := 'TIME';
  dtDate:
    Result := 'DATE';
  dtDateTimeStamp:
    Result := 'TIMESTAMP';
  dtAnsiString:
    begin
      if caFixedLen in AColumn.ActualAttributes then
        Result := 'CHAR'
      else
        Result := 'VARCHAR';
      Result := Result + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1);
    end;
  dtWideString:
    begin
      if caFixedLen in AColumn.ActualAttributes then
        Result := 'NCHAR'
      else
        Result := 'NVARCHAR';
      Result := Result + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1);
    end;
  dtByteString:
    begin
      if caFixedLen in AColumn.ActualAttributes then
        Result := 'BINARY'
      else
        Result := 'VARBINARY';
      Result := Result + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1);
    end;
  dtBlob,
  dtHBlob,
  dtHBFile:
    Result := 'BLOB';
  dtMemo,
  dtHMemo:
    Result := 'MEMO';
  dtWideMemo,
  dtWideHMemo:
    Result := 'TEXT';
  dtXML:
    Result := 'XML';
  dtGUID:
    Result := 'GUID';
  dtUnknown,
  dtTimeIntervalFull,
  dtTimeIntervalYM,
  dtTimeIntervalDS,
  dtRowSetRef,
  dtCursorRef,
  dtRowRef,
  dtArrayRef,
  dtParentRowRef,
  dtObject:
    Result := '';
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysSQLiteCommandGenerator.GetMerge(AAction: TFDPhysMergeAction): String;
begin
  Result := '';
  case AAction of
  maInsertUpdate: Result := 'INSERT OR REPLACE INTO ' + GetFrom + BRK + GetInsert('');
  maInsertIgnore: Result := 'INSERT OR IGNORE INTO ' + GetFrom + BRK + GetInsert('');
  end;
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterRDBMSKind(TFDRDBMSKinds.SQLite, S_FD_SQLite_RDBMS);

end.
