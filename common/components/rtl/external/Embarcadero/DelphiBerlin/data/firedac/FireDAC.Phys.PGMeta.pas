{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{               FireDAC PostgreSQL driver               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.PGMeta;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.Meta, FireDAC.Phys.SQLGenerator;

type
  TFDPhysPgMetadata = class(TFDPhysConnectionMetadata)
  private
    FColumnOriginProvided: Boolean;
    FUseMonthsBetween: Boolean;
    FBackslashEscSupported: Boolean;
  protected
    function GetKind: TFDRDBMSKind; override;

    function GetTxSavepoints: Boolean; override;
    function GetTxAtomic: Boolean; override;
    function GetEventSupported: Boolean; override;
    function GetEventKinds: String; override;
    function GetGeneratorSupported: Boolean; override;
    function GetIdentityInsertSupported: Boolean; override;
    function GetParamNameMaxLength: Integer; override;
    function GetNameParts: TFDPhysNameParts; override;
    function GetNameQuotedSupportedParts: TFDPhysNameParts; override;
    function GetNameQuotedCaseSensParts: TFDPhysNameParts; override;
    function GetNameCaseSensParts: TFDPhysNameParts; override;
    function GetNameDefLowCaseParts: TFDPhysNameParts; override;

    function GetInlineRefresh: Boolean; override;
    function GetLockNoWait: Boolean; override;

    function GetNamedParamMark: TFDPhysParamMark; override;
    function GetSelectOptions: TFDPhysSelectOptions; override;
    function GetAsyncAbortSupported: Boolean; override;
    function GetDefValuesSupported: TFDPhysDefaultValues; override;
    function GetArrayExecMode: TFDPhysArrayExecMode; override;
    function GetLimitOptions: TFDPhysLimitOptions; override;
    function GetNullLocations: TFDPhysNullLocations; override;
    function GetColumnOriginProvided: Boolean; override;
    function GetBackslashEscSupported: Boolean; override;

    procedure DefineMetadataStructure(ATable: TFDDatSTable; AKind: TFDPhysMetaInfoKind); override;
    function GetResultSetFields(const ASQLKey: String): TFDDatSView; override;

    function InternalEscapeBoolean(const AStr: String): String; override;
    function InternalEscapeDate(const AStr: String): String; override;
    function InternalEscapeDateTime(const AStr: String): String; override;
    function InternalEscapeFloat(const AStr: String): String; override;
    function InternalEscapeTime(const AStr: String): String; override;
    function InternalEscapeEscape(AEscape: Char; const AStr: String): String; override;
    function InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String; override;
    function InternalGetSQLCommandKind(const ATokens: TStrings): TFDPhysCommandKind; override;
  public
    constructor Create(const AConnection: TFDPhysConnection;
      AServerVersion, AClientVersion: TFDVersion; AIsUnicode: Boolean;
      AColumnOriginProvided, AUseMonthsBetween, ABackslashEscSupported: Boolean);
  end;

  TFDPhysPgCommandGenerator = class(TFDPhysCommandGenerator)
  protected
    function GetSubColumn(const AParentField, ASubField: String): String; override;
    function GetRowConstructor(const AValues: String; ARowCol: TFDDatSColumn): String; override;
    function GetCastColumn(const AValue: String; ACol: TFDDatSColumn): String; override;
    function GetInlineRefresh(const AStmt: String;
      ARequest: TFDUpdateRequest): String; override;
    function GetReadGenerator(const AName, AAlias: String;
      ANextValue, AFullSelect: Boolean): String; override;
    function GetPessimisticLock: String; override;
    function GetCommitSavepoint(const AName: String): String; override;
    function GetRollbackToSavepoint(const AName: String): String; override;
    function GetSavepoint(const AName: String): String; override;
    function GetCall(const AName: String): String; override;
    function GetStoredProcCall(const ACatalog, ASchema, APackage, AProc: String;
      ASPUsage: TFDPhysCommandKind): String; override;
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
  System.SysUtils, Data.DB,
  FireDAC.Stan.Consts, FireDAC.Stan.Util, FireDAC.Stan.Param, FireDAC.Stan.Error;

const
  // copied here from FireDAC.Phys.PGCli to remove dependency
  NAMEMAXLEN = 64;

  SQL_CHAR = 18;         // Internal
  SQL_NAME = 19;         // Internal
  SQL_UNKNOWN = 705;     // Internal
  SQL_INET = 869;        // Internal
  SQL_BPCHAR = 1042;
  SQL_VARCHAR = 1043;
  SQL_NUMERIC = 1700;

{-------------------------------------------------------------------------------}
{ TFDPhysPgMetadata                                                             }
{-------------------------------------------------------------------------------}
constructor TFDPhysPgMetadata.Create(const AConnection: TFDPhysConnection;
  AServerVersion, AClientVersion: TFDVersion; AIsUnicode: Boolean;
  AColumnOriginProvided, AUseMonthsBetween, ABackslashEscSupported: Boolean);
begin
  inherited Create(AConnection, AServerVersion, AClientVersion, AIsUnicode);
  FColumnOriginProvided := AColumnOriginProvided;
  FUseMonthsBetween := AUseMonthsBetween;
  FBackslashEscSupported := ABackslashEscSupported;
  FKeywords.CommaText :=
    'ABORT,ABSOLUTE,ACCESS,ACTION,ADD,ADMIN,AFTER,' +
    'AGGREGATE,ALL,ALSO,ALTER,ALWAYS,ANALYSE,ANALYZE,' +
    'AND,ANY,ARRAY,AS,ASC,ASSERTION,ASSIGNMENT,ASYMMETRIC,' +
    'AT,AUTHORIZATION,BACKWARD,BEFORE,BEGIN,BETWEEN,BIGINT,' +
    'BINARY,BIT,BOOLEAN,BOTH,BY,CACHE,CALLED,CASCADE,' +
    'CASCADED,CASE,CAST,CHAIN,CHAR,CHARACTER,CHARACTERISTICS,' +
    'CHECK,CHECKPOINT,CLASS,CLOSE,CLUSTER,COALESCE,COLLATE,' +
    'COLUMN,COMMENT,COMMIT,COMMITTED,CONCURRENTLY,CONFIGURATION,' +
    'CONNECTION,CONSTRAINT,CONSTRAINTS,CONTENT,CONVERSION,COPY,' +
    'COST,CREATE,CREATEDB,CREATEROLE,CREATEUSER,CROSS,CSV,' +
    'CURRENT,CURRENT_DATE,CURRENT_ROLE,CURRENT_TIME,CURRENT_TIMESTAMP,' +
    'CURRENT_USER,CURSOR,CYCLE,DATABASE,DAY,DEALLOCATE,DEC,' +
    'DECIMAL,DECLARE,DEFAULT,DEFAULTS,DEFERRABLE,DEFERRED,DEFINER,' +
    'DELETE,DELIMITER,DELIMITERS,DESC,DICTIONARY,DISABLE,DISCARD,' +
    'DISTINCT,DO,DOCUMENT,DOMAIN,DOUBLE,DROP,EACH,ELSE,' +
    'ENABLE,ENCODING,ENCRYPTED,END,ENUM,ESCAPE,EXCEPT,' +
    'EXCLUDING,EXCLUSIVE,EXECUTE,EXISTS,EXPLAIN,EXTERNAL,' +
    'EXTRACT,FALSE,FAMILY,FETCH,FIRST,FLOAT,FOR,FORCE,' +
    'FOREIGN,FORWARD,FREEZE,FROM,FULL,FUNCTION,GLOBAL,' +
    'GRANT,GRANTED,GREATEST,GROUP,HANDLER,HAVING,HEADER,' +
    'HOLD,HOUR,IF,ILIKE,IMMEDIATE,IMMUTABLE,IMPLICIT,' +
    'IN,INCLUDING,INCREMENT,INDEX,INDEXES,INHERIT,INHERITS,' +
    'INITIALLY,INNER,INOUT,INPUT,INSENSITIVE,INSERT,INSTEAD,' +
    'INT,INTEGER,INTERSECT,INTERVAL,INTO,INVOKER,IS,ISNULL,' +
    'ISOLATION,JOIN,KEY,LANCOMPILER,LANGUAGE,LARGE,LAST,' +
    'LEADING,LEAST,LEFT,LEVEL,LIKE,LIMIT,LISTEN,LOAD,' +
    'LOCAL,LOCALTIME,LOCALTIMESTAMP,LOCATION,LOCK,LOGIN,' +
    'MAPPING,MATCH,MAXVALUE,MINUTE,MINVALUE,MODE,MONTH,' +
    'MOVE,NATIONAL,NATURAL,NCHAR,NEW,NEXT,NO,' +
    'NOCREATEDB,NOCREATEROLE,NOCREATEUSER,NOINHERIT,NOLOGIN,' +
    'NONE,NOSUPERUSER,NOT,NOTHING,NOTIFY,NOTNULL,NOWAIT,' +
    'NULL,NULLIF,NULLS,NUMERIC,OBJECT,OF,OFF,OFFSET,OIDS,' +
    'OLD,ON,ONLY,OPERATOR,OPTION,OR,ORDER,OUT,OUTER,' +
    'OVERLAPS,OVERLAY,OWNED,OWNER,PARSER,PARTIAL,PASSWORD,' +
    'PLACING,PLANS,POSITION,PRECISION,PREPARE,PREPARED,PRESERVE,' +
    'PRIMARY,PRIOR,PRIVILEGES,PROCEDURAL,PROCEDURE,QUOTE,READ,' +
    'REAL,REASSIGN,RECHECK,REFERENCES,REINDEX,RELATIVE,RELEASE,' +
    'RENAME,REPEATABLE,REPLACE,REPLICA,RESET,RESTART,RESTRICT,' +
    'RETURNING,RETURNS,REVOKE,RIGHT,ROLE,ROLLBACK,ROW,ROWS,' +
    'RULE,SAVEPOINT,SCHEMA,SCROLL,SEARCH,SECOND,SECURITY,' +
    'SELECT,SEQUENCE,SERIALIZABLE,SESSION,SESSION_USER,SET,' +
    'SETOF,SHARE,SHOW,SIMILAR,SIMPLE,SMALLINT,SOME,STABLE,' +
    'STANDALONE,START,STATEMENT,STATISTICS,STDIN,STDOUT,' +
    'STORAGE,STRICT,STRIP,SUBSTRING,SUPERUSER,SYMMETRIC,SYSID,' +
    'SYSTEM,TABLE,TABLESPACE,TEMP,TEMPLATE,TEMPORARY,TEXT,' +
    'THEN,TIME,TIMESTAMP,TO,TRAILING,TRANSACTION,TREAT,' +
    'TRIGGER,TRIM,TRUE,TRUNCATE,TRUSTED,TYPE,UNCOMMITTED,' +
    'UNENCRYPTED,UNION,UNIQUE,UNKNOWN,UNLISTEN,UNTIL,UPDATE,' +
    'USER,USING,VACUUM,VALID,VALIDATOR,VALUE,VALUES,' +
    'VARCHAR,VARYING,VERBOSE,VERSION,VIEW,VOLATILE,WHEN,' +
    'WHERE,WHITESPACE,WITH,WITHOUT,WORK,WRITE,XML,' +
    'XMLATTRIBUTES,XMLCONCAT,XMLELEMENT,XMLFOREST,XMLPARSE,' +
    'XMLPI,XMLROOT,XMLSERIALIZE,YEAR,YES,ZONE';
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetKind: TFDRDBMSKind;
begin
   Result := TFDRDBMSKinds.PostgreSQL;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetTxSavepoints: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetTxAtomic: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetEventSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetEventKinds: String;
begin
  Result := S_FD_EventKind_PG_Events;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetGeneratorSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetIdentityInsertSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetParamNameMaxLength: Integer;
begin
  Result := NAMEMAXLEN;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetNameParts: TFDPhysNameParts;
begin
  Result := [npSchema, npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetNameQuotedSupportedParts: TFDPhysNameParts;
begin
  Result := [npCatalog, npSchema, npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetNameQuotedCaseSensParts: TFDPhysNameParts;
begin
  Result := [npCatalog, npSchema, npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetNameCaseSensParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetNameDefLowCaseParts: TFDPhysNameParts;
begin
  Result := [npCatalog, npSchema, npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetNamedParamMark: TFDPhysParamMark;
begin
  Result := prDollar;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetInlineRefresh: Boolean;
begin
  Result := GetServerVersion >= svPGSQL080200;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetLockNoWait: Boolean;
begin
  Result := GetServerVersion >= svPGSQL080100;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetSelectOptions: TFDPhysSelectOptions;
begin
  Result := [soWithoutFrom, soInlineView];
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetAsyncAbortSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetDefValuesSupported: TFDPhysDefaultValues;
begin
  Result := dvDefVals;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetArrayExecMode: TFDPhysArrayExecMode;
begin
  if GetServerVersion >= svPGSQL080100 then
    Result := aeOnErrorUndoAll
  else
    Result := aeUpToFirstError;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetLimitOptions: TFDPhysLimitOptions;
begin
  Result := [loSkip, loRows];
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetNullLocations: TFDPhysNullLocations;
begin
  Result := [nlAscLast, nlDescFirst];
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetColumnOriginProvided: Boolean;
begin
  Result := FColumnOriginProvided;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgMetadata.DefineMetadataStructure(ATable: TFDDatSTable;
  AKind: TFDPhysMetaInfoKind);
begin
  inherited DefineMetadataStructure(ATable, AKind);
  case AKind of
  mkResultSetFields:
    begin
      AddMetadataCol(ATable, 'ATTRELID',     dtUInt32);
      AddMetadataCol(ATable, 'ATTNUM',       dtInt16);
      AddMetadataCol(ATable, 'ATTNAME',      dtWideString);
      AddMetadataCol(ATable, 'ATTRS',        dtInt32);
      AddMetadataCol(ATable, 'INDISPRIMARY', dtBoolean);
      AddMetadataCol(ATable, 'TYPNAME',      dtWideString);
      AddMetadataCol(ATable, 'NSPNAME',      dtWideString);
      AddMetadataCol(ATable, 'RELNAME',      dtWideString);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetResultSetFields(const ASQLKey: String): TFDDatSView;
begin
  Result := inherited GetResultSetFields(ASQLKey);
  Result.Mechanisms.AddSort('ATTRELID;ATTNUM');
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.GetBackslashEscSupported: Boolean;
begin
  Result := FBackslashEscSupported;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.InternalEscapeBoolean(const AStr: String): String;
begin
  Result := AnsiQuotedStr(AStr, '''') + '::BOOLEAN';
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.InternalEscapeDate(const AStr: String): String;
begin
  Result := 'TO_DATE(' + AnsiQuotedStr(AStr, '''') + ', ''YYYY-MM-DD'')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.InternalEscapeTime(const AStr: String): String;
begin
  Result := AnsiQuotedStr(AStr, '''') + '::TIME'
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.InternalEscapeDateTime(const AStr: String): String;
begin
  Result := 'TO_TIMESTAMP(' + AnsiQuotedStr(AStr, '''') + ', ''YYYY-MM-DD HH24:MI:SS'')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.InternalEscapeFloat(const AStr: String): String;
begin
  Result := AnsiQuotedStr(AStr, '''') + '::FLOAT';
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.InternalEscapeEscape(AEscape: Char; const AStr: String): String;
var
  i: Integer;
begin
  if (AEscape = '\') and (GetServerVersion < svPGSQL090100) then begin
    Result := AStr;
    i := 1;
    while i <= Length(Result) do begin
      if Result[i] = '\' then begin
        Result := Copy(Result, 1, i) + '\' + Copy(Result, i + 1, Length(Result));
        Inc(i);
      end;
      Inc(i);
    end;
    Result := Result + ' ESCAPE ''\\''';
  end
  else
    Result := inherited InternalEscapeEscape(AEscape, AStr);
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String;
var
  sName: String;
  A1, A2, A3, A4: String;
  i: Integer;

  function AddArgs: string;
  begin
    Result := '(' + AddEscapeSequenceArgs(Aseq) + ')';
  end;
  
begin
  sName := ASeq.FName;
  if Length(ASeq.FArgs) >= 1 then begin
    A1 := ASeq.FArgs[0];
    if Length(ASeq.FArgs) >= 2 then begin
      A2 := ASeq.FArgs[1];
      if Length(ASeq.FArgs) >= 3 then begin
        A3 := ASeq.FArgs[2];
        if Length(ASeq.FArgs) >= 4 then
          A4 := ASeq.FArgs[3];
      end;
    end;
  end;

  case ASeq.FFunc of
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
    efASCII,
    efBIT_LENGTH,
    efCHAR_LENGTH,
    efOCTET_LENGTH,
    efREPEAT,
    efREPLACE:     Result := sName + AddArgs;
    efCHAR:        Result := 'CHR' + AddArgs;
    efLENGTH:      Result := 'CHAR_LENGTH' + AddArgs;
    efCONCAT:      Result := '(' + A1 + ' || ' + A2 + ')';
    efINSERT:      Result := '(SUBSTR(' + A1 + ', 1, (' + A2 + ') - 1) || ' + A4 +
                    ' || SUBSTR(' + A1 + ', (' + A2 + ' + ' + A3 + ')))';
    efLCASE:       Result := 'LOWER' + AddArgs;
    efLEFT:        Result := 'SUBSTR(' + A1 + ', 1, ' + A2 + ')';
    efLTRIM:       Result := 'TRIM(LEADING FROM ' + A1 + ')';
    efLOCATE,
    efPOSITION:
      begin
        if Length(ASeq.FArgs) >= 3 then
          UnsupportedEscape(ASeq);
        Result := 'STRPOS(' + A2 + ',' + A1 + ')';
      end;
    efRIGHT:       Result := 'SUBSTR(' + A1+ ', CHAR_LENGTH(' + A1 + ') + 1 - ' + A2 + ', CHAR_LENGTH(' + A1 + '))';
    efRTRIM:       Result := 'TRIM(TRAILING FROM ' + A1 + ')';
    efSPACE:       Result := 'RPAD('' '', ' + A1 + ')';
    efSUBSTRING:   Result := 'SUBSTR' + AddArgs;
    efUCASE:       Result := 'UPPER' + AddArgs;

    efABS,
    efACOS,
    efASIN,
    efATAN,
    efATAN2,
    efCOS,
    efCOT,
    efCEILING,
    efDEGREES,
    efEXP,
    efFLOOR,
    efMOD,
    efPI,
    efPOWER,
    efRADIANS,
    efRANDOM,
    efROUND,
    efSIGN,
    efSIN,
    efSQRT,
    efTAN:         Result := sName + AddArgs;
    efLOG:         Result := 'LN' + AddArgs;
    efLOG10:       Result := 'LOG(' + A1 + ')';
    efTRUNCATE:    Result := 'TRUNC' + AddArgs;

    efCURDATE :    Result := 'CURRENT_DATE';
    efCURTIME:     Result := 'CURRENT_TIME';
    efNOW:         Result := 'CURRENT_TIMESTAMP';
    efDAYNAME:     Result := 'RTRIM(TO_CHAR(' + A1 + ', ''DAY''))';
    efDAYOFMONTH:  Result := 'CAST(TO_CHAR(' + A1 + ', ''DD'') AS INTEGER)';
    efDAYOFWEEK:   Result := 'CAST(TO_CHAR(' + A1 + ', ''D'') AS INTEGER)';
    efDAYOFYEAR:   Result := 'CAST(TO_CHAR(' + A1 + ', ''DDD'') AS INTEGER)';
    efEXTRACT:
      begin
        A1 := UpperCase(FDUnquote(Trim(A1), ''''));
        Result := sName + '(' + A1 + ' FROM ' + A2 + ')';
      end;
    efHOUR:        Result := 'CAST(TO_CHAR(' + A1 + ', ''HH24'') AS INTEGER)';
    efMINUTE:      Result := 'CAST(TO_CHAR(' + A1 + ', ''MI'') AS INTEGER)';
    efMONTH:       Result := 'CAST(TO_CHAR(' + A1 + ', ''MM'') AS INTEGER)';
    efMONTHNAME:   Result := 'RTRIM(TO_CHAR(' + A1 + ', ''MONTH''))';
    efQUARTER:     Result := 'CAST(TO_CHAR(' + A1 + ', ''MM'') AS INTEGER)';
    efSECOND:      Result := 'CAST(TO_CHAR(' + A1 + ', ''SS'') AS INTEGER)';
    efTIMESTAMPADD:
      begin
        A1 := UpperCase(FDUnquote(Trim(A1), ''''));
        if A1 = 'FRAC_SECOND' then
          A1 := 'MICROSECONDS';
        Result := '(' + A3 + ' + CAST(CAST(' + A2 + ' AS VARCHAR) || ''' + A1 + ''' AS INTERVAL))';
      end;
    efTIMESTAMPDIFF:
      begin
        A1 := UpperCase(FDUnquote(Trim(A1), ''''));
        if (A1 = 'MONTH') and FUseMonthsBetween then
          Result := 'MONTHS_BETWEEN(' + A3 + ', ' + A2 + ')'
        else if A1 = 'WEEK' then
          Result := 'TRUNC((DATE_PART(''DAY'', CAST(' + A3 + ' AS TIMESTAMP)) - ' +
                           'DATE_PART(''DAY'', CAST(' + A2 + ' AS TIMESTAMP))) / 7)'
        else begin
          if A1 = 'FRAC_SECOND' then
            A1 := 'MICROSECONDS';
          Result := '(DATE_PART(''' + A1 + ''', CAST(' + A3 + ' AS TIMESTAMP)) - ' +
                     'DATE_PART(''' + A1 + ''', CAST(' + A2 + ' AS TIMESTAMP)))';
        end;
      end;
    efWEEK:        Result := 'CAST(TO_CHAR(' + A1 + ', ''WW'') AS INTEGER)';
    efYEAR:        Result := 'CAST(TO_CHAR(' + A1 + ', ''YYYY'') AS INTEGER)';

    // system
    efCATALOG:     Result := 'CURRENT_DATABASE()';
    efSCHEMA:      Result := 'CURRENT_SCHEMA()';
    efIFNULL:      Result := 'COALESCE' + AddArgs;
    efIF:          Result := 'CASE WHEN ' + A1 + ' THEN ' + A2 + ' ELSE ' + A3 + ' END';
    efCONVERT:
      begin
        A2 := UpperCase(FDUnquote(Trim(A2), ''''));
        if A2 = 'DATETIME' then
          A2 := 'TIMESTAMP';
        Result := 'CAST(' + A1 + ' AS ' + A2 + ')';
      end;
  else
    UnsupportedEscape(ASeq);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgMetadata.InternalGetSQLCommandKind(const ATokens: TStrings): TFDPhysCommandKind;
var
  sToken: String;
begin
  sToken := ATokens[0];
  if sToken = 'FETCH' then
    Result := skSelect
  else if sToken = 'SET' then
    if ATokens.Count = 1 then
      Result := skNotResolved
    else if ATokens[1] = 'SEARCH_PATH' then
      Result := skSetSchema
    else
      Result := skSet
  else if sToken = 'SHOW' then
    Result := skSelect
  else if sToken = 'EXPLAIN' then
    Result := skSelect
  else if sToken = 'START' then
    if ATokens.Count = 1 then
      Result := skNotResolved
    else if ATokens[1] = 'TRANSACTION' then
      Result := skStartTransaction
    else
      Result := inherited InternalGetSQLCommandKind(ATokens)
  else if sToken = 'BEGIN' then
    Result := skStartTransaction
  else if sToken = 'END' then
    Result := skCommit
  else if sToken = 'ABORT' then
    Result := skRollback
  else if sToken = 'DO' then
    Result := skExecute
  else
    Result := inherited InternalGetSQLCommandKind(ATokens);
  if (Result in [skInsert, skMerge, skUpdate, skDelete]) and (ATokens.Count = 2) and
     (ATokens[1] = 'RETURNING') then
    Result := skSelectForLock;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysPgMetadata                                                             }
{-------------------------------------------------------------------------------}
function TFDPhysPgCommandGenerator.GetSubColumn(const AParentField,
  ASubField: String): String;
begin
  if FCommandPart = cpWHERE then
    Result := '(' + AParentField + ').' + ASubField
  else
    Result := inherited GetSubColumn(AParentField, ASubField);
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommandGenerator.GetRowConstructor(const AValues: String;
  ARowCol: TFDDatSColumn): String;
begin
  Result := 'ROW(' + AValues + ')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommandGenerator.GetCastColumn(const AValue: String;
  ACol: TFDDatSColumn): String;
begin
  Result := AValue;
  if ACol.SourceDataTypeName <> '' then
    Result := Result + '::' + ACol.SourceDataTypeName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommandGenerator.GetInlineRefresh(const AStmt: String;
  ARequest: TFDUpdateRequest): String;
var
  sRet: String;
begin
  Result := AStmt;
  sRet := GetReturning(ARequest, False);
  if sRet <> '' then begin
    Result := Result + sRet;
    FCommandKind := skSelectForLock;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommandGenerator.GetPessimisticLock: String;
var
  lNeedFrom: Boolean;
begin
  lNeedFrom := False;
  Result := 'SELECT ' + GetSelectList(True, False, lNeedFrom) + BRK +
    'FROM ' + GetFrom + BRK + 'WHERE ' + GetWhere(False, True, False) + BRK +
    'FOR UPDATE';
  ASSERT(lNeedFrom);
  if not FOptions.UpdateOptions.LockWait then
    Result := Result + ' NOWAIT';
  FCommandKind := skSelectForLock;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommandGenerator.GetReadGenerator(const AName, AAlias: String;
  ANextValue, AFullSelect: Boolean): String;
begin
  if ANextValue then
    Result := 'NEXTVAL(''' + AName + ''')'
  else
    Result := 'CURRVAL(''' + AName + ''')';
  if AAlias <> '' then
    Result := Result + ' AS ' + AAlias;
  if AFullSelect then
    Result := 'SELECT ' + Result;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommandGenerator.GetSavepoint(const AName: String): String;
begin
  Result := 'SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommandGenerator.GetCommitSavepoint(const AName: String): String;
begin
  Result := 'RELEASE SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommandGenerator.GetRollbackToSavepoint(const AName: String): String;
begin
  Result := 'ROLLBACK TO SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommandGenerator.GetCall(const AName: String): String;
begin
  Result := 'SELECT NULL FROM ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommandGenerator.GetStoredProcCall(const ACatalog, ASchema,
  APackage, AProc: String; ASPUsage: TFDPhysCommandKind): String;
var
  i: Integer;
  oParam: TFDParam;
  sInPar: String;
  iInParIndex: Integer;
  rName: TFDPhysParsedName;
  lHasCrs, lFunc: Boolean;
begin
  iInParIndex := 1;
  sInPar := '';
  lHasCrs := False;
  lFunc := False;
  for i := 0 to FParams.Count - 1 do begin
    case FParams.BindMode of
    pbByName:   oParam := FParams[i];
    pbByNumber: oParam := FParams.FindParam(i + 1);
    else        oParam := nil;
    end;
    if oParam.DataType = ftCursor then
      lHasCrs := True
    else if oParam.ParamType = ptResult then
      lFunc := True;
    if oParam.ParamType in [ptUnknown, ptInput, ptInputOutput] then begin
      if sInPar <> '' then
        sInPar := sInPar + ', ';
      if (FParams.BindMode = pbByName) and (oParam.Name <> '') and
         (FConnMeta.ServerVersion >= svPGSQL090000) then
        sInPar := sInPar + oParam.Name + ' := ';
      sInPar := sInPar + '$' + IntToStr(iInParIndex);
      Inc(iInParIndex);
    end;
  end;

  // function returns void
  if FParams.Count = iInParIndex - 1 then begin
    if FCommandKind = skStoredProc then
      FCommandKind := skStoredProcNoCrs;
    // NULL to avoid problem with execution of a
    // void function in binary result format
    Result := 'SELECT NULL FROM ';
  end
  else begin
    if lHasCrs and (FCommandKind = skStoredProc) then
      FCommandKind := skStoredProcWithCrs
    else if lFunc then
      lFunc := FCommandKind in [skStoredProc, skStoredProcNoCrs];
    if lFunc then
      Result := 'SELECT '
    else
      Result := 'SELECT * FROM ';
  end;

  rName.FCatalog := ACatalog;
  rName.FSchema := ASchema;
  rName.FBaseObject := APackage;
  rName.FObject := AProc;
  Result := Result + FConnMeta.EncodeObjName(rName, FCommand, [eoQuote, eoNormalize]) +
    '(' + sInPar + ')';
  if lFunc then
    Result := Result + ' AS RESULT';
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommandGenerator.GetSelectMetaInfo(AKind: TFDPhysMetaInfoKind;
  const ACatalog, ASchema, ABaseObject, AObject, AWildcard: String;
  AObjectScopes: TFDPhysObjectScopes; ATableKinds: TFDPhysTableKinds;
  AOverload: Word): String;
var
  lWasWhere: Boolean;
  sSchemaName: String;
  sKinds: String;
  oPar: TFDParam;

  function Par: String;
  begin
    Result := '$' + IntToStr(GetParams.Count + 1);
  end;

  procedure AddWhere(const ACond: String; const AParam: String = '');
  var
    oPar: TFDParam;
  begin
    if lWasWhere then
      Result := Result + ' AND ' + ACond
    else begin
      Result := Result + ' WHERE ' + ACond;
      lWasWhere := True;
    end;
    if AParam <> '' then begin
      oPar := GetParams.Add;
      oPar.Name := AParam;
      oPar.DataType := ftString;
      oPar.Size := 70;
    end;
  end;

  function EscapeArrayToString(const AStr: String): String;
  var
    iPos: Integer;
    sAlias: String;
  begin
    iPos := Pos('.', AStr);
    if iPos > 0 then
      sAlias := Copy(AStr, iPos + 1, Length(AStr))
    else
      sAlias := AStr;
    Result := 'ARRAY_TO_STRING(' + AStr + ', '';'') AS ' + sAlias;
  end;

  procedure AddTopScope(const AOwnerName, AObjName: String);
  var
    sScope: String;
  begin
    if ASchema <> '' then
      AddWhere(AOwnerName + ' = ' + sSchemaName)
    else if AObjectScopes <> [osMy, osSystem, osOther] then begin
      sScope := '';
      if osMy in AObjectScopes then
        sScope := sScope + '(A.USENAME = USER) OR ';
      if osOther in AObjectScopes then
        sScope := sScope + '(A.USENAME <> USER) AND ' +
          'NOT ((N.NSPNAME = ''information_schema'') OR (N.NSPNAME = ''pg_catalog'') OR ' +
               '(N.NSPNAME = ''dbo'') OR (N.NSPNAME = ''sys'') OR ' +
               '(substr(' + AObjName + ', 1, 3) = ''pg_'')) OR ';
      if osSystem in AObjectScopes then
        sScope := sScope + '(N.NSPNAME = ''information_schema'') OR (N.NSPNAME = ''pg_catalog'') OR ' +
          '(substr(' + AObjName + ', 1, 3) = ''pg_'') OR ';
      if sScope <> '' then
        AddWhere('(' + Copy(sScope, 1, Length(sScope) - 4) + ')');
    end;
  end;

  function EncodeScope(const AObjName: String): String;
  begin
    Result :=
      'CASE' +
      ' WHEN (N.NSPNAME = ''information_schema'') OR (N.NSPNAME = ''pg_catalog'') OR ' +
            '(N.NSPNAME = ''dbo'') OR (N.NSPNAME = ''sys'') OR ' +
            '(SUBSTR(' + AObjName + ', 1, 3) = ''pg_'') THEN ' + IntToStr(Integer(osSystem)) +
      ' WHEN A.USENAME = USER THEN ' + IntToStr(Integer(osMy)) +
      ' ELSE ' + IntToStr(Integer(osOther)) + ' ' +
      'END::SMALLINT';
  end;

  function EncodeLength: String;
  begin
    Result := Format(
      'CASE' +
      ' WHEN A.ATTTYPID IN (%d, %d, %d, %d, %d) THEN A.ATTTYPMOD - 4' +
      ' WHEN A.ATTTYPID = %d THEN %d' +
      ' ELSE 0 ' +
      'END::INTEGER', [SQL_CHAR, SQL_BPCHAR, SQL_VARCHAR, SQL_NAME, SQL_INET,
                       SQL_UNKNOWN, GetOptions.FormatOptions.MaxStringSize]);
  end;

  function EncodePrecision(const ATypeName: String): String;
  begin
    Result := Format(
      'CASE' +
      ' WHEN (A.ATTTYPID IN (%d)) AND ' +
            '(UPPER(SUBSTRING(' + ATypeName + ' FROM 1 FOR 3)) <> ''INT'') AND ' +
            '(UPPER(SUBSTRING(' + ATypeName + ' FROM 1 FOR 5)) <> ''FLOAT'') AND ' +
            '(UPPER(SUBSTRING(' + ATypeName + ' FROM 1 FOR 4)) <> ''REAL'') THEN CEIL((A.ATTTYPMOD - 4) / 65536)' +
      ' ELSE 0 ' +
      'END::SMALLINT', [SQL_NUMERIC]);
  end;

  function EncodeScale: String;
  begin
    Result := Format(
      'CASE' +
      ' WHEN A.ATTTYPID IN (%d) THEN MOD(A.ATTTYPMOD - 4, 65536)' +
      ' ELSE 0 ' +
      'END::SMALLINT', [SQL_NUMERIC]);
  end;

  function EncodeAttrs(ABase: Boolean): String;

    function Attrs(AAttrs: TFDDataAttributes): String;
    begin
      Result := IntToStr(PWord(@AAttrs)^);
    end;

  begin
    Result := '(';
    if ABase then
      Result := Result + Attrs([caBase]) + ' + ';
    Result := Result +
      'CASE WHEN A.ATTNOTNULL THEN 0 ELSE ' + Attrs([caAllowNull]) + ' END + ' +
      'CASE WHEN A.ATTNUM > 0 THEN 0 ELSE ' + Attrs([caReadOnly]) + ' END + ' +
      'CASE WHEN UPPER(A.ATTNAME) = ''OID'' AND A.ATTNUM < 0 THEN ' + Attrs([caROWID]) + ' ELSE 0 END + ' +
      'CASE WHEN UPPER(SUBSTR(D.ADSRC, 1, 8)) = ''NEXTVAL('' THEN ' + Attrs([caAutoInc]) +
          ' WHEN D.ADBIN IS NOT NULL THEN ' + Attrs([caDefault]) + ' ELSE 0 END)::INTEGER';
  end;

begin
  if ASchema = '' then
    sSchemaName := 'CURRENT_SCHEMA()'
  else
    sSchemaName := QuotedStr(ASchema);
  Result := '';
  sKinds := '';
  lWasWhere := False;

  case AKind of
    mkCatalogs:
      begin
        Result := 'SELECT NULL::INTEGER AS RECNO, DATNAME AS CATALOG_NAME ' +
          'FROM PG_DATABASE WHERE DATISTEMPLATE = false';
        if AWildcard <> '' then
          AddWhere('DATNAME LIKE ' + Par(), 'WIL');
        Result := Result + ' ORDER BY 2';
      end;

    mkSchemas:
      begin
        Result := 'SELECT NULL::INTEGER AS RECNO, CURRENT_DATABASE() AS CATALOG_NAME, ' +
          'NSPNAME AS SCHEMA_NAME FROM PG_CATALOG.PG_NAMESPACE';
        if AWildcard <> '' then
          AddWhere('NSPNAME LIKE ' + Par(), 'WIL');
        Result := Result + ' ORDER BY 3';
      end;

    mkTables:
      begin
        Result := 'SELECT NULL::INTEGER AS RECNO, CURRENT_DATABASE() AS CATALOG_NAME, ' +
          'N.NSPNAME AS SCHEMA_NAME, C.RELNAME AS TABLE_NAME, ' +
          'CASE' +
          ' WHEN N.OID = pg_my_temp_schema() THEN ' + IntToStr(Integer(tkTempTable)) +
          ' WHEN C.RELKIND = ''r'' THEN ' + IntToStr(Integer(tkTable)) +
          ' WHEN C.RELKIND = ''v'' THEN ' + IntToStr(Integer(tkView)) +
          ' ELSE 0 ' +
          'END::INTEGER AS TABLE_TYPE, ' +
          EncodeScope('C.RELNAME') + ' AS TABLE_SCOPE ' +
          'FROM PG_CATALOG.PG_CLASS C ' +
          'INNER JOIN PG_CATALOG.PG_NAMESPACE N ON N.OID = C.RELNAMESPACE '+
          'INNER JOIN PG_CATALOG.PG_USER A ON C.RELOWNER = A.USESYSID ';
        sKinds := '';
        if (tkTable in ATableKinds) or (tkTempTable in ATableKinds) then
          sKinds := sKinds + '''r''';
        if tkView in ATableKinds then begin
          if sKinds <> '' then
            sKinds := sKinds + ',';
          sKinds := sKinds + '''v''';
        end;
        if sKinds <> '' then
          AddWhere('C.RELKIND IN (' + sKinds + ')')
        else
          AddWhere('0 = 1');
        if AWildcard <> '' then
          AddWhere('C.RELNAME LIKE ' + Par(), 'WIL');
        AddTopScope('N.NSPNAME', 'C.RELNAME');
        if not (tkTempTable in ATableKinds) then
          AddWhere('N.OID <> pg_my_temp_schema()')
        else if ATableKinds = [tkTempTable] then
          AddWhere('N.OID = pg_my_temp_schema()');
        Result := Result + ' ORDER BY 3, 4';
      end;

    mkTableFields:
      begin
        Result := 'SELECT NULL::INTEGER AS RECNO, CURRENT_DATABASE() AS CATALOG_NAME, ' +
          'N.NSPNAME AS SCHEMA_NAME, C.RELNAME AS TABLE_NAME, A.ATTNAME AS COLUMN_NAME, ' +
          'A.ATTNUM AS COLUMN_POSITION, A.ATTTYPID AS COLUMN_DATATYPE, T.TYPNAME AS COLUMN_TYPENAME, ' +
          EncodeAttrs(True) + ' AS COLUMN_ATTRIBUTES, ' +
          EncodePrecision('T.TYPNAME') + ' AS COLUMN_PRECISION, ' +
          EncodeScale + ' AS COLUMN_SCALE, ' +
          EncodeLength + ' AS COLUMN_LENGTH ' +
          'FROM PG_CATALOG.PG_CLASS C ' +
          'INNER JOIN PG_CATALOG.PG_NAMESPACE N ON N.OID = C.RELNAMESPACE ' +
          'INNER JOIN PG_CATALOG.PG_ATTRIBUTE A ON A.ATTRELID = C.OID ' +
          'INNER JOIN PG_CATALOG.PG_TYPE T ON A.ATTTYPID = T.OID ' +
          'LEFT JOIN PG_CATALOG.PG_ATTRDEF D ON D.ADNUM = A.ATTNUM AND D.ADRELID = C.OID ';
        AddWhere('A.ATTNUM > 0 AND NOT A.ATTISDROPPED');
        AddWhere('N.NSPNAME = ' + sSchemaName);
        AddWhere('C.RELNAME = ' + Par(), 'OBJ');
        if AWildcard <> '' then
          AddWhere('A.ATTNAME LIKE ' + Par(), 'WIL');
        Result := Result + ' ORDER BY 6';
      end;

    mkIndexes,
    mkPrimaryKey:
      begin
        Result := 'SELECT NULL::INTEGER AS RECNO, CURRENT_DATABASE() AS CATALOG_NAME,' +
          'N.NSPNAME AS SCHEMA_NAME, TC.RELNAME AS TABLE_NAME, IC.RELNAME AS INDEX_NAME,' +
          'CASE' +
          ' WHEN I.INDISPRIMARY OR I.INDISUNIQUE THEN IC.RELNAME' +
          ' ELSE NULL ' +
          'END::NAME AS PKEY_NAME, ' +
          'CASE ' +
          ' WHEN I.INDISPRIMARY THEN ' + IntToStr(Integer(ikPrimaryKey)) +
          ' WHEN I.INDISUNIQUE THEN ' + IntToStr(Integer(ikUnique)) +
          ' ELSE ' + IntToStr(Integer(ikNonUnique)) + ' ' +
          'END::INTEGER AS INDEX_TYPE ' +
          'FROM PG_CATALOG.PG_INDEX I ' +
          'INNER JOIN PG_CATALOG.PG_CLASS TC ON TC.OID = I.INDRELID ' +
          'INNER JOIN PG_CATALOG.PG_CLASS IC ON IC.OID = I.INDEXRELID ' +
          'INNER JOIN PG_CATALOG.PG_NAMESPACE N ON N.OID = TC.RELNAMESPACE ';
        AddWhere('NOT EXISTS(SELECT 1 FROM PG_CATALOG.PG_ATTRIBUTE A WHERE A.ATTRELID = I.INDRELID AND 0 = ANY(I.INDKEY))');
        AddWhere('N.NSPNAME = ' + sSchemaName);
        AddWhere('TC.RELNAME = ' + Par(), 'OBJ');
        if AWildcard <> '' then
          AddWhere('IC.RELNAME LIKE ' + Par(), 'WIL');
        if AKind = mkPrimaryKey then
          AddWhere('I.INDISPRIMARY');
        Result := Result + ' ORDER BY 7 DESC, 5 ASC';
      end;

    mkIndexFields,
    mkPrimaryKeyFields:
      begin
        Result := 'SELECT NULL::INTEGER AS RECNO, CURRENT_DATABASE() AS CATALOG_NAME, ' +
          'N.NSPNAME AS SCHEMA_NAME, TC.RELNAME AS TABLE_NAME, IC.RELNAME AS INDEX_NAME, ' +
          'A.ATTNAME AS COLUMN_NAME, A.ATTNUM AS COLUMN_POSITION, ''A''::VARCHAR(1) AS SORT_ORDER, ' +
          'NULL::VARCHAR(67) AS FILTER ' +
          'FROM PG_CATALOG.PG_INDEX I ' +
          'INNER JOIN PG_CATALOG.PG_CLASS TC ON TC.OID = I.INDRELID ' +
          'INNER JOIN PG_CATALOG.PG_CLASS IC ON IC.OID = I.INDEXRELID ' +
          'INNER JOIN PG_CATALOG.PG_NAMESPACE N ON N.OID = TC.RELNAMESPACE ' +
          'INNER JOIN PG_CATALOG.PG_ATTRIBUTE A ON A.ATTRELID = I.INDRELID AND A.ATTNUM = ANY(I.INDKEY) ';
        AddWhere('N.NSPNAME = ' + sSchemaName);
        AddWhere('TC.RELNAME = ' + Par(), 'BAS');
        if AKind = mkPrimaryKeyFields then
          AddWhere('I.INDISPRIMARY')
        else
          AddWhere('IC.RELNAME = ' + Par(), 'OBJ');
        if AWildcard <> '' then
          AddWhere('A.ATTNAME LIKE ' + Par(), 'WIL');
        Result := Result + ' ORDER BY position(trim(both from to_char(A.ATTNUM, ''99999'')) in ' +
          ' ''~'' || array_to_string(I.INDKEY, ''~'') || ''~'')';
      end;

    mkForeignKeys:
      begin
        Result := 'SELECT NULL::INTEGER AS RECNO, CURRENT_DATABASE() AS CATALOG_NAME, ' +
          'TN.NSPNAME AS SCHEMA_NAME, TT.RELNAME AS TABLE_NAME, C.CONNAME AS FKEY_NAME, ' +
          'CURRENT_DATABASE() AS PKEY_CATALOG_NAME, RN.NSPNAME AS PKEY_SCHEMA_NAME, ' +
          'RT.RELNAME AS PKEY_TABLE_NAME,' +
          'CASE' +
          ' WHEN C.CONFDELTYPE = ''r'' THEN ' + IntToStr(Integer(ckRestrict)) +
          ' WHEN C.CONFDELTYPE = ''a'' THEN ' + IntToStr(Integer(ckRestrict)) +
          ' WHEN C.CONFDELTYPE = ''c'' THEN ' + IntToStr(Integer(ckCascade)) +
          ' WHEN C.CONFDELTYPE = ''n'' THEN ' + IntToStr(Integer(ckSetNull)) +
          ' WHEN C.CONFDELTYPE = ''d'' THEN ' + IntToStr(Integer(ckSetDefault)) + ' ' +
          'END::INTEGER AS DELETE_RULE, ' +
          'CASE' +
          ' WHEN C.CONFUPDTYPE = ''r'' THEN ' + IntToStr(Integer(ckRestrict)) +
          ' WHEN C.CONFUPDTYPE = ''a'' THEN ' + IntToStr(Integer(ckRestrict)) +
          ' WHEN C.CONFUPDTYPE = ''c'' THEN ' + IntToStr(Integer(ckCascade)) +
          ' WHEN C.CONFUPDTYPE = ''n'' THEN ' + IntToStr(Integer(ckSetNull)) +
          ' WHEN C.CONFUPDTYPE = ''d'' THEN ' + IntToStr(Integer(ckSetDefault)) + ' ' +
          'END::INTEGER AS UPDATE_RULE ' +
          'FROM PG_CATALOG.PG_CONSTRAINT C ' +
          'INNER JOIN PG_CATALOG.PG_CLASS TT ON TT.OID = C.CONRELID ' +
          'INNER JOIN PG_CATALOG.PG_NAMESPACE TN ON TN.OID = TT.RELNAMESPACE ' +
          'INNER JOIN PG_CATALOG.PG_CLASS RT ON RT.OID = C.CONFRELID ' +
          'INNER JOIN PG_CATALOG.PG_NAMESPACE RN ON RN.OID = RT.RELNAMESPACE';
        AddWhere('C.CONTYPE = ''f''');
        AddWhere('TN.NSPNAME = ' + sSchemaName);
        AddWhere('TT.RELNAME = ' + Par(), 'OBJ');
        if AWildcard <> '' then
          AddWhere('C.CONNAME LIKE ' + Par(), 'WIL');
        Result := Result + ' ORDER BY 3, 5';
      end;

    mkForeignKeyFields:
      Result := inherited GetSelectMetaInfo(AKind, ACatalog, ASchema, ABaseObject,
        AObject, AWildcard, AObjectScopes, ATableKinds, AOverload);

    mkPackages:
      ;

    mkProcs:
      begin
        Result := 'SELECT NULL::INTEGER AS RECNO, CURRENT_DATABASE() AS CATALOG_NAME, ' +
          'N.NSPNAME AS SCHEMA_NAME, NULL::NAME AS PACK_NAME, P.PRONAME AS PROC_NAME, ' +
          '0 AS OVERLOAD, ' +
          IntToStr(Integer(pkFunction)) + ' AS PROC_TYPE, '+
          EncodeScope('P.PRONAME') + ' AS PROC_SCOPE, ' +
          'P.PRONARGS AS IN_PARAMS, ' +
          'CASE' +
          '  WHEN PROALLARGTYPES IS NULL THEN 0 ' +
          'ELSE ' +
          '  ARRAY_UPPER(P.PROALLARGTYPES, 1) - P.PRONARGS ' +
          'END AS OUT_PARAMS ' +
          'FROM PG_CATALOG.PG_PROC P ' +
          'INNER JOIN PG_CATALOG.PG_NAMESPACE N ON N.OID = P.PRONAMESPACE ' +
          'INNER JOIN PG_CATALOG.PG_USER A ON P.PROOWNER = A.USESYSID ';
        if AWildcard <> '' then
          AddWhere('P.PRONAME LIKE ' + Par(), 'WIL');
        AddTopScope('N.NSPNAME', 'P.PRONAME');
        Result := Result + ' ORDER BY 3, 5';
      end;

    mkProcArgs:
      begin
        Result := 'SELECT PRORETSET, PRORETTYPE,' +
          EscapeArrayToString('PROARGTYPES') + ',' +
          EscapeArrayToString('PROALLARGTYPES') + ',' +
          EscapeArrayToString('PROARGMODES') + ',' +
          EscapeArrayToString('PROARGNAMES') + ' ' +
          'FROM PG_CATALOG.PG_PROC P ' +
          'INNER JOIN PG_CATALOG.PG_NAMESPACE N ON N.OID = P.PRONAMESPACE ';
        AddWhere('N.NSPNAME = ' + sSchemaName);
        // TFDPhysPgSPDescriber.ReadProcArgs expects two parameters
        AddWhere('P.PRONAME = $1');
        Result := Result + ' OFFSET $2 LIMIT 1';
      end;

    mkGenerators:
      begin
        Result := 'SELECT NULL::INTEGER AS RECNO, CURRENT_DATABASE() AS TABLE_CATALOG, ' +
          'N.NSPNAME AS SEQUENCE_SCHEMA, C.RELNAME AS GENERATOR_NAME, ' +
          EncodeScope('C.RELNAME') + ' AS GENERATOR_SCOPE ' +
          'FROM PG_CATALOG.PG_CLASS C ' +
          'INNER JOIN PG_CATALOG.PG_NAMESPACE N ON N.OID = C.RELNAMESPACE ' +
          'INNER JOIN PG_CATALOG.PG_USER A ON C.RELOWNER = A.USESYSID ';
        AddWhere('C.RELKIND = ''S''');
        if AWildcard <> '' then
          AddWhere('C.RELNAME LIKE ' + Par(), 'WIL');
        AddTopScope('N.NSPNAME', 'C.RELNAME');
        Result := Result + ' ORDER BY 3, 4';
      end;

    mkResultSetFields:
      begin
        Result := 'SELECT NULL::INTEGER AS RECNO, ' + QuotedStr(AObject) + '::VARCHAR(1024) AS RESULTSET_KEY, ' +
            'A.ATTRELID, A.ATTNUM, A.ATTNAME, ' + EncodeAttrs(False) + ' AS ATTRS, I.INDISPRIMARY, T.TYPNAME, N.NSPNAME, C.RELNAME ' +
          'FROM PG_CATALOG.PG_ATTRIBUTE A ' +
            'INNER JOIN PG_CATALOG.PG_CLASS C ON C.OID = A.ATTRELID ' +
            'INNER JOIN PG_CATALOG.PG_NAMESPACE N ON N.OID = C.RELNAMESPACE ' +
            'INNER JOIN PG_CATALOG.PG_TYPE T ON T.OID = A.ATTTYPID ' +
            'LEFT JOIN PG_CATALOG.PG_INDEX I ON (I.INDRELID = A.ATTRELID) AND ' +
              '(A.ATTNUM = ANY(I.INDKEY)) AND I.INDISPRIMARY ' +
            'LEFT JOIN PG_CATALOG.PG_ATTRDEF D ON (D.ADNUM = A.ATTNUM) AND ' +
              '(D.ADRELID = A.ATTRELID) ';
        if Pos(',', AObject) = 0 then begin
          AddWhere('A.ATTRELID = ' + Par(), 'OBJ');
          oPar := GetParams[GetParams.Count - 1];
          oPar.DataType := ftInteger;
          oPar.Size := 0;
        end
        else
          AddWhere('A.ATTRELID IN (' + AObject + ')');
        AddWhere('(A.ATTNUM > 0)');
      end;

    mkTableTypeFields:
      ;
  else
    Result := '';
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommandGenerator.GetLimitSelect(const ASQL: String;
  ASkip, ARows: Integer): String;
begin
  if (ASkip > 0) and (ARows + ASkip <> MAXINT) then
    Result := ASQL + BRK + 'LIMIT ' + IntToStr(ARows) + ' OFFSET ' + IntToStr(ASkip)
  else if ASkip > 0 then
    Result := ASQL + BRK + 'LIMIT ALL OFFSET ' + IntToStr(ASkip)
  else if ARows >= 0 then
    Result := ASQL + BRK + 'LIMIT ' + IntToStr(ARows)
  else
    Result := ASQL;
end;

{-------------------------------------------------------------------------------}
// http://www.postgresql.org/docs/9.1/static/datatype.html
function TFDPhysPgCommandGenerator.GetColumnType(AColumn: TFDDatSColumn): String;
begin
  if caAutoInc in AColumn.ActualAttributes then begin
    if AColumn.DataType in [dtSByte, dtInt16, dtInt32, dtByte, dtUInt16] then
      Result := 'SERIAL'
    else
      Result := 'BIGSERIAL';
    Exit;
  end;
  case AColumn.DataType of
  dtBoolean:
    Result := 'BOOLEAN';
  dtSByte,
  dtInt16,
  dtByte:
    Result := 'SMALLINT';
  dtInt32,
  dtUInt16:
    Result := 'INTEGER';
  dtInt64,
  dtUInt32,
  dtUInt64:
    Result := 'BIGINT';
  dtSingle:
    Result := 'REAL';
  dtDouble,
  dtExtended:
    Result := 'DOUBLE PRECISION';
  dtCurrency:
    Result := 'MONEY';
  dtBCD,
  dtFmtBCD:
    Result := 'DECIMAL' + GetColumnDim(-1, AColumn.Precision, AColumn.Scale, -1,
      FOptions.FormatOptions.MaxBcdPrecision, FOptions.FormatOptions.MaxBcdScale);
  dtDateTime,
  dtDateTimeStamp:
    Result := 'TIMESTAMP';
  dtTime:
    Result := 'TIME';
  dtDate:
    Result := 'DATE';
  dtTimeIntervalYM:
    Result := 'INTERVAL YEAR TO MONTH';
  dtTimeIntervalFull,
  dtTimeIntervalDS:
    Result := 'INTERVAL DAY TO SECOND';
  dtAnsiString,
  dtWideString:
    begin
      if caFixedLen in AColumn.ActualAttributes then
        Result := 'CHAR'
      else
        Result := 'VARCHAR';
      Result := Result + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1);
    end;
  dtByteString,
  dtBlob:
    Result := 'BYTEA';
  dtMemo,
  dtWideMemo:
    Result := 'TEXT';
  dtXML:
    Result := 'XML';
  dtHBlob,
  dtHMemo,
  dtWideHMemo,
  dtHBFile:
    Result := 'BLOB';
  dtGUID:
    Result := '';
  dtUnknown,
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
function TFDPhysPgCommandGenerator.GetMerge(AAction: TFDPhysMergeAction): String;
var
  sKeys: String;
  i: Integer;
  oCol: TFDDatSColumn;
begin
  if FConnMeta.ServerVersion < svPGSQL090500 then
    FDCapabilityNotSupported(Self, [S_FD_LPhys]);

  sKeys := '';
  for i := 0 to FTable.Columns.Count - 1 do begin
    oCol := FTable.Columns[i];
    if ColumnStorable(oCol) and ColumnInKey(oCol) then begin
      if sKeys <> '' then
        sKeys := sKeys + ', ';
      sKeys := sKeys + GetColumn('', -1, oCol);
    end;
  end;
  if sKeys <> '' then
    sKeys := '(' + sKeys + ') ';

  Result := '';
  case AAction of
  maInsertUpdate: Result := GenerateInsert() + BRK + 'ON CONFLICT ' + sKeys + 'DO UPDATE SET ' + GetUpdate();
  maInsertIgnore: Result := GenerateInsert() + BRK + 'ON CONFLICT ' + sKeys + 'DO NOTHING';
  end;
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterRDBMSKind(TFDRDBMSKinds.PostgreSQL, S_FD_PG_RDBMS);

end.
