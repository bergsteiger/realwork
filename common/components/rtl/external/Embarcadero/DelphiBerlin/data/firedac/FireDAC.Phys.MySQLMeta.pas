{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                FireDAC MySQL metadata                 }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.MySQLMeta;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.Meta, FireDAC.Phys.SQLGenerator;

type
  TFDPhysMySQLNameModes = set of (nmCaseSens, nmDefLowerCase, nmDBApply);
  TFDPhysMySQLMetadata = class (TFDPhysConnectionMetadata)
  private
    FNameModes: TFDPhysMySQLNameModes;
    FNameDoubleQuote: Boolean;
  protected
    function GetKind: TFDRDBMSKind; override;
    function GetTxSavepoints: Boolean; override;
    function GetIdentityInsertSupported: Boolean; override;
    function GetParamNameMaxLength: Integer; override;
    function GetNameParts: TFDPhysNameParts; override;
    function GetNameQuotedCaseSensParts: TFDPhysNameParts; override;
    function GetNameCaseSensParts: TFDPhysNameParts; override;
    function GetNameDefLowCaseParts: TFDPhysNameParts; override;
    function GetNameQuoteChar(AQuote: TFDPhysNameQuoteLevel; ASide: TFDPhysNameQuoteSide): Char; override;
    function GetDefValuesSupported: TFDPhysDefaultValues; override;
    function GetArrayExecMode: TFDPhysArrayExecMode; override;
    function GetLimitOptions: TFDPhysLimitOptions; override;
    function GetSelectOptions: TFDPhysSelectOptions; override;
    function GetAsyncAbortSupported: Boolean; override;
    function GetServerCursorSupported: Boolean; override;
    function GetBackslashEscSupported: Boolean; override;
    function InternalEscapeBoolean(const AStr: String): String; override;
    function InternalEscapeDate(const AStr: String): String; override;
    function InternalEscapeDateTime(const AStr: String): String; override;
    function InternalEscapeFloat(const AStr: String): String; override;
    function InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String; override;
    function InternalEscapeTime(const AStr: String): String; override;
    function InternalEscapeEscape(AEscape: Char; const AStr: String): String; override;
    function InternalGetSQLCommandKind(const ATokens: TStrings): TFDPhysCommandKind; override;
  public
    constructor Create(const AConnection: TFDPhysConnection;
      ANameDoubleQuote: Boolean; AServerVersion, AClientVersion: TFDVersion;
      ANameModes: TFDPhysMySQLNameModes; AIsUnicode: Boolean);
  end;

  TFDPhysMySQLCommandGenerator = class(TFDPhysCommandGenerator)
  private
    FCurrentCatalog: String;
  protected
    function GetIdentity(ASessionScope: Boolean): String; override;
    function GetSingleRowTable: String; override;
    function GetPessimisticLock: String; override;
    function GetSavepoint(const AName: String): String; override;
    function GetRollbackToSavepoint(const AName: String): String; override;
    function GetCall(const AName: String): String; override;
    function GetStoredProcCall(const ACatalog, ASchema, APackage, AProc: String;
      ASPUsage: TFDPhysCommandKind): String; override;
    function GetSelectMetaInfo(AKind: TFDPhysMetaInfoKind; const ACatalog,
      ASchema, ABaseObject, AObject, AWildcard: String;
      AObjectScopes: TFDPhysObjectScopes; ATableKinds: TFDPhysTableKinds;
      AOverload: Word): String; override;
    function GetLimitSelect(const ASQL: String; ASkip, ARows: Integer): String; override;
    function GetColumnType(AColumn: TFDDatSColumn): String; override;
    function GetMerge(AAction: TFDPhysMergeAction): String; override;
  public
    constructor Create(const ACommand: IFDPhysCommand); overload;
    constructor Create(const AConnection: IFDPhysConnection); overload;
  end;

implementation

uses
  System.SysUtils, Data.DB,
  FireDAC.Stan.Consts, FireDAC.Stan.Util, FireDAC.Stan.Param, FireDAC.Stan.Option;

const
  // copied here from FireDAC.Phys.MySQLCli to remove dependency
  NAME_LEN = 64;

{-------------------------------------------------------------------------------}
{ TFDPhysMySQLMetadata                                                          }
{-------------------------------------------------------------------------------}
constructor TFDPhysMySQLMetadata.Create(const AConnection: TFDPhysConnection;
  ANameDoubleQuote: Boolean; AServerVersion, AClientVersion: TFDVersion;
  ANameModes: TFDPhysMySQLNameModes; AIsUnicode: Boolean);
var
  sKwd: String;
begin
  inherited Create(AConnection, AServerVersion, AClientVersion, AIsUnicode);
  FNameModes := ANameModes;
  FNameDoubleQuote := ANameDoubleQuote;
  sKwd :=
    'ADD,ALL,ALTER,' +
    'ANALYZE,AND,AS,' +
    'ASC,ASENSITIVE,BEFORE,' +
    'BETWEEN,BIGINT,BINARY,' +
    'BLOB,BOTH,BY,' +
    'CALL,CASCADE,CASE,' +
    'CHANGE,CHAR,CHARACTER,' +
    'CHECK,COLLATE,COLUMN,' +
    'CONDITION,CONNECTION,CONSTRAINT,' +
    'CONTINUE,CONVERT,CREATE,' +
    'CROSS,CURRENT_DATE,CURRENT_TIME,' +
    'CURRENT_TIMESTAMP,CURRENT_USER,CURSOR,' +
    'DATABASE,DATABASES,DAY_HOUR,' +
    'DAY_MICROSECOND,DAY_MINUTE,DAY_SECOND,' +
    'DEC,DECIMAL,DECLARE,' +
    'DEFAULT,DELAYED,DELETE,' +
    'DESC,DESCRIBE,DETERMINISTIC,' +
    'DISTINCT,DISTINCTROW,DIV,' +
    'DOUBLE,DROP,DUAL,' +
    'EACH,ELSE,ELSEIF,' +
    'ENCLOSED,ESCAPED,EXISTS,' +
    'EXIT,EXPLAIN,FALSE,' +
    'FETCH,FLOAT,FLOAT4,' +
    'FLOAT8,FOR,FORCE,' +
    'FOREIGN,FROM,FULLTEXT,' +
    'GRANT,GROUP,HAVING,' +
    'HIGH_PRIORITY,HOUR_MICROSECOND,HOUR_MINUTE,' +
    'HOUR_SECOND,IF,IGNORE,' +
    'IN,INDEX,INFILE,' +
    'INNER,INOUT,INSENSITIVE,' +
    'INSERT,INT,INT1,' +
    'INT2,INT3,INT4,' +
    'INT8 INTEGER,INTERVAL,' +
    'INTO,IS,ITERATE,' +
    'JOIN,KEY,KEYS,' +
    'KILL,LEADING,LEAVE,' +
    'LEFT,LIKE,LIMIT,' +
    'LINES,LOAD,LOCALTIME,' +
    'LOCALTIMESTAMP,LOCK,LONG,' +
    'LONGBLOB,LONGTEXT,LOOP,' +
    'LOW_PRIORITY,MATCH,MEDIUMBLOB,' +
    'MEDIUMINT,MEDIUMTEXT,MIDDLEINT,' +
    'MINUTE_MICROSECOND,MINUTE_SECOND,MOD,' +
    'MODIFIES,NATURAL,NOT,' +
    'NO_WRITE_TO_BINLOG,NULL,NUMERIC,' +
    'ON,OPTIMIZE,OPTION,' +
    'OPTIONALLY,OR,ORDER,' +
    'OUT,OUTER,OUTFILE,' +
    'PRECISION,PRIMARY,PROCEDURE,' +
    'PURGE,RAID0,READ,' +
    'READS,REAL,REFERENCES,' +
    'REGEXP,RELEASE,RENAME,' +
    'REPEAT,REPLACE,REQUIRE,' +
    'RESTRICT,RETURN,REVOKE,' +
    'RIGHT,RLIKE,SCHEMA,' +
    'SCHEMAS,SECOND_MICROSECOND,SELECT,' +
    'SENSITIVE,SEPARATOR,SET,' +
    'SHOW,SMALLINT,SONAME,' +
    'SPATIAL,SPECIFIC,SQL,' +
    'SQLEXCEPTION,SQLSTATE,SQLWARNING,' +
    'SQL_BIG_RESULT,SQL_CALC_FOUND_ROWS,SQL_SMALL_RESULT,' +
    'SSL,STARTING,STRAIGHT_JOIN,' +
    'TABLE,TERMINATED,THEN,' +
    'TINYBLOB,TINYINT,TINYTEXT,' +
    'TO,TRAILING,TRIGGER,' +
    'TRUE,UNDO,UNION,' +
    'UNIQUE,UNLOCK,UNSIGNED,' +
    'UPDATE,USAGE,USE,' +
    'UPGRADE,' +
    'USING,UTC_DATE,UTC_TIME,' +
    'UTC_TIMESTAMP,VALUES,VARBINARY,' +
    'VARCHAR,VARCHARACTER,VARYING,' +
    'WHEN,WHERE,WHILE,' +
    'WITH,WRITE,' +
    'XOR,YEAR_MONTH,ZEROFILL';
  if (AServerVersion = 0) or (AServerVersion >= mvMySQL050100) then
    sKwd := sKwd +
      ',ACCESSIBLE,LINEAR,MASTER_SSL_VERIFY_SERVER_CERT,' +
      'RANGE,READ_ONLY,READ_WRITE';
  if (AServerVersion = 0) or (AServerVersion >= mvMySQL050500) then
    sKwd := sKwd +
      ',GENERAL,IGNORE_SERVER_IDS,MASTER_HEARTBEAT_PERIOD,' +
      'MAXVALUE,RESIGNAL,SIGNAL,' +
      'SLOW';
  if (AServerVersion = 0) or (AServerVersion >= mvMySQL050600) then
    sKwd := sKwd +
      ',CURRENT,CURSOR_NAME,DATA,' +
      'DATAFILE,DATE,DATETIME,' +
      'DAY,DEFAULT_AUTH,DEFINER,' +
      'DELAY_KEY_WRITE,DES_KEY_FILE,DIAGNOSTICS,' +
      'DIRECTORY,DISABLE,DISCARD,' +
      'DISK,DUMPFILE,DUPLICATE,' +
      'DYNAMIC,ENABLE,ENDS,' +
      'ENGINE,ENGINES,ENUM,' +
      'ERROR,ERRORS,ESCAPE,' +
      'EVENT,EVENTS,EVERY,' +
      'EXCHANGE,EXPANSION,EXTENDED,' +
      'EXTENT_SIZE,FAST,FAULTS,' +
      'FILE,FIRST,FIXED,' +
      'FOUND,FULL,FUNCTION,' +
      'GEOMETRY,GEOMETRYCOLLECTION,GET,' +
      'GET_FORMAT,GLOBAL,GRANTS,' +
      'HASH,HOSTS,HOUR,' +
      'IDENTIFIED,IMPORT,INDEXES,' +
      'INITIAL_SIZE,INSERT_METHOD,INVOKER,' +
      'IO,IO_THREAD,IPC,' +
      'ISOLATION,ISSUER,KEY_BLOCK_SIZE,' +
      'LAST,LEAVES,LESS,' +
      'LEVEL,LINESTRING,LIST,' +
      'LOCAL,LOCKS,LOGFILE,' +
      'LOGS,MASTER,MASTER_BIND,' +
      'MASTER_CONNECT_RETRY,MASTER_DELAY,MASTER_HOST,' +
      'MASTER_LOG_FILE,MASTER_LOG_POS,MASTER_PASSWORD,' +
      'MASTER_PORT,MASTER_RETRY_COUNT,MASTER_SERVER_ID,' +
      'MASTER_SSL,MASTER_SSL_CA,MASTER_SSL_CAPATH,' +
      'MASTER_SSL_CERT,MASTER_SSL_CIPHER,MASTER_SSL_CRL,' +
      'MASTER_SSL_CRLPATH,MASTER_SSL_KEY,MASTER_USER,' +
      'MAX_CONNECTIONS_PER_HOUR,MAX_QUERIES_PER_HOUR,MAX_ROWS,' +
      'MAX_SIZE,MAX_UPDATES_PER_HOUR,MAX_USER_CONNECTIONS,' +
      'MEDIUM,MEMORY,MERGE,' +
      'MESSAGE_TEXT,MICROSECOND,MIGRATE,' +
      'MINUTE,MIN_ROWS,MODE,' +
      'MODIFY,MONTH,MULTILINESTRING,' +
      'MULTIPOINT,MULTIPOLYGON,MUTEX,' +
      'MYSQL_ERRNO,NAME,NAMES,' +
      'NATIONAL,NCHAR,NDB,' +
      'NDBCLUSTER,NEW,NEXT,' +
      'NODEGROUP,NONE,NO_WAIT,' +
      'NUMBER,NVARCHAR,OFFSET,' +
      'OLD_PASSWORD,ONE,ONE_SHOT,' +
      'PACK_KEYS,PAGE,PARTIAL,' +
      'PARTITION,PARTITIONING,PARTITIONS,' +
      'PASSWORD,PHASE,PLUGIN,' +
      'PLUGINS,PLUGIN_DIR,POINT,' +
      'POLYGON,PRESERVE,PREV,' +
      'PRIVILEGES,PROCESSLIST,PROFILE,' +
      'PROFILES,PROXY,QUARTER,' +
      'QUERY,QUICK,READ_ONLY,' +
      'REBUILD,RECOVER,REDOFILE,' +
      'REDO_BUFFER_SIZE,REDUNDANT,RELAY,' +
      'RELAYLOG,RELAY_LOG_FILE,RELAY_LOG_POS,' +
      'RELAY_THREAD,RELOAD,REORGANIZE,' +
      'REPEATABLE,REPLICATION,RESUME,' +
      'RETURNED_SQLSTATE,RETURNS,REVERSE,' +
      'ROLLUP,ROUTINE,ROW,' +
      'ROWS,ROW_COUNT,ROW_FORMAT,' +
      'RTREE,SCHEDULE,SCHEMA_NAME,' +
      'SECOND,SERIAL,SERIALIZABLE,' +
      'SESSION,SHARE,SHUTDOWN,' +
      'SIMPLE,SNAPSHOT,SOUNDS,' +
      'SOURCE,SQL_BUFFER_RESULT,SQL_CACHE,' +
      'SQL_NO_CACHE,SQL_THREAD,SQL_TSI_DAY,' +
      'SQL_TSI_HOUR,SQL_TSI_MINUTE,SQL_TSI_MONTH,' +
      'SQL_TSI_QUARTER,SQL_TSI_SECOND,SQL_TSI_WEEK,' +
      'SQL_TSI_YEAR,STARTS,STATUS,' +
      'STORAGE,STRING,SUBCLASS_ORIGIN,' +
      'SUBJECT,SUBPARTITION,SUBPARTITIONS,' +
      'SUPER,SUSPEND,SWAPS,' +
      'SWITCHES,TABLES,TABLESPACE,' +
      'TABLE_CHECKSUM,TABLE_NAME,TEMPORARY,' +
      'TEMPTABLE,TEXT,THAN,' +
      'TIME,TIMESTAMP,TIMESTAMPADD,' +
      'TIMESTAMPDIFF,TRANSACTION,TRIGGERS,' +
      'TYPE,TYPES,UNCOMMITTED,' +
      'UNDEFINED,UNDOFILE,UNDO_BUFFER_SIZE,' +
      'UNKNOWN,UNTIL,USER,' +
      'USER_RESOURCES,USE_FRM,VALUE,' +
      'VARIABLES,VIEW,WAIT,' +
      'WARNINGS,WEEK,WEIGHT_STRING,' +
      'WORK,X509,XML,' +
      'YEAR';
  FKeywords.CommaText := sKwd;
  ConfigQuoteChars;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.GetKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.MySQL;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.GetNameQuotedCaseSensParts: TFDPhysNameParts;
begin
  Result := GetNameCaseSensParts;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.GetNameCaseSensParts: TFDPhysNameParts;
begin
  if nmCaseSens in FNameModes then begin
    Result := [npBaseObject, npObject];
    if nmDBApply in FNameModes then
      Include(Result, npCatalog);
  end
  else
    Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.GetNameDefLowCaseParts: TFDPhysNameParts;
begin
  if nmDefLowerCase in FNameModes then begin
    Result := [npBaseObject, npObject];
    if nmDBApply in FNameModes then
      Include(Result, npCatalog);
  end
  else
    Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.GetParamNameMaxLength: Integer;
begin
  Result := NAME_LEN;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.GetNameParts: TFDPhysNameParts;
begin
  Result := [npCatalog, npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.GetNameQuoteChar(AQuote: TFDPhysNameQuoteLevel;
  ASide: TFDPhysNameQuoteSide): Char;
begin
  Result := #0;
  case AQuote of
  ncDefault:
    Result := '`';
  ncSecond:
    if FNameDoubleQuote then
      Result := '"';
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.GetTxSavepoints: Boolean;
begin
  Result := (GetServerVersion >= mvMySQL040100);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.GetIdentityInsertSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.GetDefValuesSupported: TFDPhysDefaultValues;
begin
  if GetServerVersion >= mvMySQL040000 then
    Result := dvDef
  else
    Result := dvNone;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.GetArrayExecMode: TFDPhysArrayExecMode;
begin
  Result := aeOnErrorUndoAll;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.GetLimitOptions: TFDPhysLimitOptions;
begin
  Result := [loSkip, loRows];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.GetSelectOptions: TFDPhysSelectOptions;
begin
  Result := [soWithoutFrom, soInlineView];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.GetAsyncAbortSupported: Boolean;
begin
  Result := GetServerVersion >= mvMySQL050000;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.GetServerCursorSupported: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.GetBackslashEscSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.InternalEscapeBoolean(const AStr: String): String;
begin
  Result := FDUnquote(AStr, '''');
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.InternalEscapeDate(const AStr: String): String;
begin
  if GetServerVersion >= mvMySQL040000 then
    Result := 'CAST(' + AnsiQuotedStr(AStr, '''') + ' AS DATE)'
  else
    Result := AnsiQuotedStr(AStr, '''');
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.InternalEscapeDateTime(const AStr: String): String;
begin
  if GetServerVersion >= mvMySQL040000 then
    Result := 'CAST(' + AnsiQuotedStr(AStr, '''') + ' AS DATETIME)'
  else
    Result := AnsiQuotedStr(AStr, '''');
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.InternalEscapeTime(const AStr: String): String;
begin
  if GetServerVersion >= mvMySQL040000 then
    Result := 'CAST(' + AnsiQuotedStr(AStr, '''') + ' AS TIME)'
  else
    Result := AnsiQuotedStr(AStr, '''');
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.InternalEscapeFloat(const AStr: String): String;
begin
  Result := AStr;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String;
var
  sName: String;
  A1, A2, A3: String;
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
      if Length(ASeq.FArgs) >= 3 then
        A3 := ASeq.FArgs[2];
    end;
  end;
  case ASeq.FFunc of
  // the same
  // char
  efASCII,
  efCHAR_LENGTH,
  efCONCAT,
  efCHAR,
  efINSERT,
  efLCASE,
  efLEFT,
  efLTRIM,
  efLOCATE,
  efOCTET_LENGTH,
  efREPEAT,
  efREPLACE,
  efRIGHT,
  efRTRIM,
  efSPACE,
  efSUBSTRING,
  efUCASE,
  // numeric
  efACOS,
  efASIN,
  efATAN,
  efATAN2,
  efABS,
  efCEILING,
  efCOS,
  efCOT,
  efDEGREES,
  efEXP,
  efFLOOR,
  efLOG,
  efLOG10,
  efMOD,
  efPOWER,
  efPI,
  efRADIANS,
  efSIGN,
  efSIN,
  efSQRT,
  efTAN,
  // date and time
  efCURDATE,
  efCURTIME,
  efNOW,
  efDAYNAME,
  efDAYOFMONTH,
  efDAYOFWEEK,
  efDAYOFYEAR,
  efHOUR,
  efMINUTE,
  efMONTH,
  efMONTHNAME,
  efQUARTER,
  efSECOND,
  efYEAR,
  // system
  efIFNULL:
    Result := sName + AddArgs;
  // convert
  efCONVERT:
    if GetServerVersion >= mvMySQL040000 then
      Result := sName + AddArgs
    else
      Result := A1;
  // character
  efLENGTH:      Result := 'LENGTH(RTRIM(' + A1 + '))';
  efPOSITION:    Result := 'POSITION(' + A1 + ' IN ' + A2 + ')';
  efBIT_LENGTH:
    if GetServerVersion >= mvMySQL040000 then
      Result := sName + AddArgs
    else
      Result := '(LENGTH(' + A1 + ') * 8)';
  // numeric
  efRANDOM:      Result := 'RAND' + AddArgs;
  efROUND,
  efTRUNCATE:
    if A2 = '' then
      Result := sName + '(' + A1 + ', 0)'
    else
      Result := sName + AddArgs;
  // date and time
  efTIMESTAMPADD:
    if GetServerVersion >= mvMySQL050000 then begin
      ASeq.FArgs[0] := UpperCase(FDUnquote(Trim(A1), ''''));
      if (GetServerVersion >= mvMySQL050060) and (ASeq.FArgs[0] = 'FRAC_SECOND') then
        ASeq.FArgs[0] := 'MICROSECOND';
      Result := sName + AddArgs;
    end
    else begin
      A1 := UpperCase(FDUnquote(Trim(A1), ''''));
      if A1 = 'WEEK' then begin
        A1 := 'DAY';
        A2 := A2 + ' * 7';
      end;
      Result := 'DATE_ADD(' + A3 + ', INTERVAL ' + A2 + ' ' + A1 + ')';
    end;
  efTIMESTAMPDIFF:
    if GetServerVersion >= mvMySQL050000 then begin
      ASeq.FArgs[0] := UpperCase(FDUnquote(Trim(A1), ''''));
      if (GetServerVersion >= mvMySQL050060) and (ASeq.FArgs[0] = 'FRAC_SECOND') then
        ASeq.FArgs[0] := 'MICROSECOND';
      Result := sName + AddArgs;
    end
    else
      UnsupportedEscape(ASeq);
  efEXTRACT:
    begin
      A1 := UpperCase(FDUnquote(Trim(A1), ''''));
      Result := sName + '(' + A1 + ' FROM ' + A2 + ')';
    end;
  efWEEK:
    if GetServerVersion >= mvMySQL040000 then
      Result := '(WEEK(' + A1 + ') + 1)'
    else
      Result := sName + AddArgs;
  // system
  efCATALOG:     Result := 'DATABASE()';
  efSCHEMA:      Result := '''''';
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
  else
    UnsupportedEscape(ASeq);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.InternalEscapeEscape(AEscape: Char; const AStr: String): String;
begin
  Result := AStr + ' ESCAPE ''';
  if AEscape = '\' then
    Result := Result + '\\'''
  else
    Result := Result + AEscape + '''';
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLMetadata.InternalGetSQLCommandKind(
  const ATokens: TStrings): TFDPhysCommandKind;
var
  sToken: String;
begin
  sToken := ATokens[0];
  if sToken = 'SHOW' then
    Result := skSelect
  else if sToken = 'EXPLAIN' then
    Result := skSelect
  else if sToken = 'CALL' then
    Result := skExecute
  else if sToken = 'REPLACE' then
    Result := skMerge
  else if sToken = 'START' then
    if ATokens.Count = 1 then
      Result := skNotResolved
    else if ATokens[1] = 'TRANSACTION' then
      Result := skStartTransaction
    else
      Result := inherited InternalGetSQLCommandKind(ATokens)
  else if sToken = 'BEGIN' then
    Result := skStartTransaction
  else
    Result := inherited InternalGetSQLCommandKind(ATokens);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysMySQLCommandGenerator                                                  }
{-------------------------------------------------------------------------------}
constructor TFDPhysMySQLCommandGenerator.Create(const ACommand: IFDPhysCommand);
begin
  inherited Create(ACommand);
  FCurrentCatalog := ACommand.Connection.CurrentCatalog;
end;

{-------------------------------------------------------------------------------}
constructor TFDPhysMySQLCommandGenerator.Create(const AConnection: IFDPhysConnection);
begin
  inherited Create(AConnection);
  FCurrentCatalog := AConnection.CurrentCatalog;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommandGenerator.GetIdentity(ASessionScope: Boolean): String;
begin
  Result := 'LAST_INSERT_ID()';
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommandGenerator.GetSingleRowTable: String;
begin
  Result := 'DUAL';
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommandGenerator.GetPessimisticLock: String;
var
  lNeedFrom: Boolean;
begin
  // FOptions.UpdateOptions.LockWait is not used - MySQL always waits
  lNeedFrom := False;
  Result := 'SELECT ' + GetSelectList(True, False, lNeedFrom) + BRK +
    'FROM ' + GetFrom + BRK + 'WHERE ' + GetWhere(False, True, False) + BRK;
  if FOptions.UpdateOptions.LockPoint = lpImmediate then
    Result := Result + 'FOR UPDATE'
  else
    Result := Result + 'LOCK IN SHARE MODE';
  FCommandKind := skSelectForLock;
  ASSERT(lNeedFrom);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommandGenerator.GetSavepoint(const AName: String): String;
begin
  Result := 'SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommandGenerator.GetRollbackToSavepoint(const AName: String): String;
begin
  Result := 'ROLLBACK TO SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommandGenerator.GetCall(const AName: String): String;
begin
  Result := 'CALL ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommandGenerator.GetStoredProcCall(const ACatalog, ASchema,
  APackage, AProc: String; ASPUsage: TFDPhysCommandKind): String;
var
  i: Integer;
  oParam: TFDParam;
  rName: TFDPhysParsedName;
  sSET, sCALL, sSELECT, sFUNC, sName, sVar, sPar, sCast: String;
  lFunction: Boolean;
begin
  sSET := '';
  sCALL := '';
  sSELECT := '';
  sFUNC := '';
  lFunction := False;

  rName.FCatalog := ACatalog;
  rName.FSchema := ASchema;
  rName.FBaseObject := APackage;
  rName.FObject := AProc;
  sName := FConnMeta.EncodeObjName(rName, FCommand, [eoQuote, eoNormalize]);

  rName.FCatalog := '';
  rName.FSchema := '';
  rName.FBaseObject := '';

  for i := 0 to FParams.Count - 1 do begin
    case FParams.BindMode of
    pbByName:   oParam := FParams[i];
    pbByNumber: oParam := FParams.ParamByPosition(i + 1);
    else        oParam := nil;
    end;
    sVar := '@P' + IntToStr(i + 1);
    if oParam.ParamType in [ptUnknown, ptInput, ptInputOutput] then begin
      if sSET <> '' then
        sSET := sSET + ', ';
      sSET := sSET + sVar + ' = ?';
    end;

    if oParam.ParamType in [ptInputOutput, ptOutput] then begin
      if sSELECT <> '' then
        sSELECT := sSELECT + ', ';

      rName.FObject := oParam.SQLName;
      sPar := FConnMeta.EncodeObjName(rName, FCommand, [eoQuote, eoNormalize]);
      case oParam.DataType of
      ftSmallint, ftInteger, ftWord, ftAutoInc, ftLargeint
      , ftLongWord, ftShortint, ftByte:
        sCast := 'SIGNED';
      ftFloat, ftCurrency, ftBCD
      , ftFMTBcd
      , ftExtended
      , ftSingle:
        // On 5.1 CAST(123.456, DECIMAL) -> 123
        // On 5.0 -> 123.456
        if (FConnMeta.ServerVersion >= mvMySQL050100) and
           (oParam.Precision = 0) and (oParam.NumericScale = 0) then
          sCast := ''
        else begin
          sCast := 'DECIMAL';
          if (oParam.Precision <> 0) or (oParam.NumericScale <> 0) then begin
            sCast := sCast + '(';
            if oParam.Precision <> 0 then
              sCast := sCast + IntToStr(oParam.Precision)
            else
              sCast := sCast + IntToStr(65);
            if oParam.NumericScale <> 0 then
              sCast := sCast + ',' + IntToStr(oParam.NumericScale);
            sCast := sCast + ')';
          end;
        end;
      ftDate:
        sCast := 'DATE';
      ftTime:
        sCast := 'TIME';
      ftDateTime, ftTimeStamp:
        sCast := 'DATETIME';
      else
        sCast := '';
      end;
      if sCast <> '' then
        sSELECT := sSELECT + 'CAST(' + sVar + ' AS ' + sCast + ') AS ' + sPar
      else
        sSELECT := sSELECT + sVar + ' AS ' + sPar;
      if sFUNC = '' then
        sFUNC := sName + '(' + sVar
      else
        sFUNC := sFUNC + ', ' + sVar;
    end;
    if oParam.ParamType in [ptUnknown, ptInput] then
      if sFUNC = '' then
        sFUNC := sName + '(' + sVar
      else
        sFUNC := sFUNC + ', ' + sVar;
    if oParam.ParamType = ptResult then
      lFunction := True;
  end;

  if sFUNC = '' then
    sFUNC := sName + '()'
  else
    sFUNC := sFUNC + ')';

  if lFunction then begin
    if sSELECT <> '' then
      sSELECT := sFUNC + ' AS RESULT, ' + sSELECT
    else
      sSELECT := sFUNC + ' AS RESULT';
  end
  else
    sCALL := sFUNC;

  Result := '';
  if sSET <> '' then begin
    if Result <> '' then
      Result := Result + '; ';
    Result := Result + 'SET ' + sSET;
  end;
  if sCALL <> '' then begin
    if Result <> '' then
      Result := Result + '; ';
    Result := Result + 'CALL ' + sCALL;
  end;
  if sSELECT <> '' then begin
    if Result <> '' then
      Result := Result + '; ';
    Result := Result + 'SELECT ' + sSELECT;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommandGenerator.GetSelectMetaInfo(AKind: TFDPhysMetaInfoKind;
  const ACatalog, ASchema, ABaseObject, AObject, AWildcard: String;
  AObjectScopes: TFDPhysObjectScopes; ATableKinds: TFDPhysTableKinds;
  AOverload: Word): String;
var
  sName, sCatalog: String;
  lWasWhere: Boolean;

  function EncodeName: String;
  var
    rName: TFDPhysParsedName;
  begin
    rName.FCatalog := ACatalog;
    rName.FSchema := ASchema;
    if AKind in [mkIndexFields, mkPrimaryKeyFields, mkForeignKeyFields] then
      if ABaseObject <> '' then
        rName.FBaseObject := ABaseObject
      else
        rName.FBaseObject := AObject
    else
      rName.FObject := AObject;
    Result := FConnMeta.EncodeObjName(rName, FCommand, [eoQuote, eoNormalize]);
  end;

  function EncodeFKName: String;
  var
    rName: TFDPhysParsedName;
  begin
    rName.FCatalog := '';
    rName.FSchema := '';
    rName.FBaseObject := '';
    rName.FObject := AObject;
    Result := FConnMeta.EncodeObjName(rName, FCommand, [eoNormalize]);
  end;

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
  lWasWhere := False;
  Result := '';
  case AKind of
  mkCatalogs:
    begin
      Result := 'SHOW DATABASES';
      if AWildcard <> '' then
        Result := Result + ' LIKE ''' + AWildcard + '''';
    end;
  mkSchemas:
    ;
  mkTables:
    begin
      Result := 'SHOW ';
      if FConnMeta.ServerVersion >= mvMySQL050002 then
        Result := Result + 'FULL ';
      Result := Result + 'TABLES';
      if (ACatalog <> '') and (CompareText(ACatalog, FCurrentCatalog) <> 0) then
        Result := Result + ' IN ' + ACatalog;
      if AWildcard <> '' then
        Result := Result + ' LIKE ''' + AWildcard + '''';
    end;
  mkTableFields:
    begin
      Result := 'SHOW COLUMNS';
      if AWildcard <> '' then
        Result := Result + ' LIKE ''' + AWildcard + '''';
      Result := Result + ' FROM ' + EncodeName();
    end;
  mkIndexes,
  mkIndexFields,
  mkPrimaryKey,
  mkPrimaryKeyFields:
    begin
      Result := 'SHOW INDEX';
      if AWildcard <> '' then
        Result := Result + ' LIKE ''' + AWildcard + '''';
      Result := Result + ' FROM ' + EncodeName();
    end;
  mkForeignKeys,
  mkForeignKeyFields:
    if (FConnMeta.ServerVersion < mvMySQL032300) or
       ((FConnMeta.ServerVersion >= mvMySQL050000) and (FConnMeta.ServerVersion < mvMySQL050100)) then
      Result := ''
    else begin
      if ACatalog = '' then
        sCatalog := FCurrentCatalog
      else
        sCatalog := ACatalog;
      if FConnMeta.ServerVersion >= mvMySQL050100 then
        Result := inherited GetSelectMetaInfo(AKind, sCatalog, '', ABaseObject,
          AObject, AWildcard, AObjectScopes, ATableKinds, AOverload)
      else
        Result := 'SHOW TABLE STATUS FROM ' + sCatalog + ' LIKE ''' +
          EncodeFKName() + '''';
    end;
  mkPackages:
    ;
  mkProcs:
    if FConnMeta.ServerVersion < mvMySQL050000 then
      Result := ''
    else begin
      Result := 'SELECT CAST(NULL AS UNSIGNED) AS RECNO, ROUTINE_SCHEMA AS CATALOG_NAME, ' +
        'CAST(NULL AS CHAR(64)) AS SCHEMA_NAME, CAST(NULL AS CHAR(64)) AS PACK_NAME, ' +
        'ROUTINE_NAME AS PROC_NAME, CAST(NULL AS UNSIGNED) AS OVERLOAD, ' +
        'CASE ROUTINE_TYPE ' +
          'WHEN ''FUNCTION'' THEN ' + IntToStr(Integer(pkFunction)) +
          ' WHEN ''PROCEDURE'' THEN ' + IntToStr(Integer(pkProcedure)) + ' END AS PROC_TYPE, ' +
        'CASE LOWER(ROUTINE_SCHEMA) ' +
          'WHEN ''mysql'' THEN ' + IntToStr(Integer(osSystem)) +
          ' WHEN ''information_schema'' THEN ' + IntToStr(Integer(osSystem)) +
          ' WHEN ''' + LowerCase(FCurrentCatalog) + ''' THEN ' + IntToStr(Integer(osMy)) +
          ' ELSE ' + IntToStr(Integer(osOther)) + ' END AS PROC_SCOPE, ' +
        'CAST(NULL AS UNSIGNED) AS IN_PARAMS, CAST(NULL AS UNSIGNED) AS OUT_PARAMS ' +
        'FROM INFORMATION_SCHEMA.ROUTINES';
      if ACatalog <> '' then
        AddWhere('LOWER(ROUTINE_SCHEMA) = LOWER(''' + ACatalog + ''')');
      if AWildcard <> '' then
        AddWhere('ROUTINE_NAME LIKE ''' + AWildcard + '''');
      Result := Result + ' ORDER BY 3, 5';
    end;
  mkProcArgs:
    begin
      sName := EncodeName();
      Result := 'SHOW CREATE PROCEDURE ' + sName + ';' +
                'SHOW CREATE FUNCTION ' + sName;
    end;
  mkGenerators,
  mkResultSetFields,
  mkTableTypeFields:
    ;
  else
    Result := '';
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommandGenerator.GetLimitSelect(const ASQL: String;
  ASkip, ARows: Integer): String;
begin
  if ASkip > 0 then
    Result := ASQL + BRK + 'LIMIT ' + IntToStr(ASkip) + ', ' + IntToStr(ARows)
  else if ARows >= 0 then
    Result := ASQL + BRK + 'LIMIT ' + IntToStr(ARows)
  else
    Result := ASQL;
end;

{-------------------------------------------------------------------------------}
// http://dev.mysql.com/doc/refman/5.6/en/string-type-overview.html
function TFDPhysMySQLCommandGenerator.GetColumnType(AColumn: TFDDatSColumn): String;
begin
  case AColumn.DataType of
  dtBoolean:
    Result := 'BOOLEAN';
  dtSByte:
    Result := 'TINYINT';
  dtInt16:
    Result := 'SMALLINT';
  dtInt32:
    Result := 'INT';
  dtInt64:
    Result := 'BIGINT';
  dtByte:
    Result := 'TINYINT UNSIGNED';
  dtUInt16:
    Result := 'SMALLINT UNSIGNED';
  dtUInt32:
    Result := 'INT UNSIGNED';
  dtUInt64:
    Result := 'BIGINT UNSIGNED';
  dtSingle:
    Result := 'FLOAT';
  dtDouble,
  dtExtended:
    Result := 'DOUBLE';
  dtCurrency:
    Result := 'DECIMAL' + GetColumnDim(-1, AColumn.Precision, AColumn.Scale, -1, 18, 4);
  dtBCD,
  dtFmtBCD:
    Result := 'DECIMAL' + GetColumnDim(-1, AColumn.Precision, AColumn.Scale, -1,
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
      if (caFixedLen in AColumn.ActualAttributes) and (AColumn.Size <= 255) then
        Result := 'CHAR'
      else
        Result := 'VARCHAR';
      Result := Result + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1);
    end;
  dtWideString:
    begin
      if (caFixedLen in AColumn.ActualAttributes) and (AColumn.Size <= 255) then
        Result := 'NATIONAL CHAR'
      else
        Result := 'NATIONAL VARCHAR';
      Result := Result + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1);
    end;
  dtByteString:
    begin
      if (caFixedLen in AColumn.ActualAttributes) and (AColumn.Size <= 255) then
        Result := 'BINARY'
      else
        Result := 'VARBINARY';
      Result := Result + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1);
    end;
  dtBlob,
  dtHBlob,
  dtHBFile:
    Result := 'LONGBLOB';
  dtMemo,
  dtWideMemo,
  dtXML,
  dtHMemo,
  dtWideHMemo:
    Result := 'LONGTEXT';
  dtGUID:
    Result := 'CHAR(38)';
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
function TFDPhysMySQLCommandGenerator.GetMerge(AAction: TFDPhysMergeAction): String;
begin
  Result := '';
  case AAction of
  maInsertUpdate: Result := GenerateInsert() + BRK + 'ON DUPLICATE KEY UPDATE ' + GetUpdate();
  maInsertIgnore: Result := 'INSERT IGNORE INTO ' + GetFrom + BRK + GetInsert('');
  end;
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterRDBMSKind(TFDRDBMSKinds.MySQL, S_FD_MySQL_RDBMS);

end.
