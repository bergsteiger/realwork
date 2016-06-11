{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                FireDAC Oracle metadata                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.OracleMeta;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.Meta, FireDAC.Phys.SQLGenerator;

type
  TFDPhysOraMetadata = class (TFDPhysConnectionMetadata)
  protected
    function GetKind: TFDRDBMSKind; override;
    function GetTxSavepoints: Boolean; override;
    function GetEventSupported: Boolean; override;
    function GetEventKinds: String; override;
    function GetGeneratorSupported: Boolean; override;
    function GetIdentitySupported: Boolean; override;
    function GetIdentityInsertSupported: Boolean; override;
    function GetIdentityInWhere: Boolean; override;
    function GetParamNameMaxLength: Integer; override;
    function GetNameParts: TFDPhysNameParts; override;
    function GetNameCaseSensParts: TFDPhysNameParts; override;
    function GetNameDefLowCaseParts: TFDPhysNameParts; override;
    function GetInsertHBlobMode: TFDPhysInsertHBlobMode; override;
    function GetNamedParamMark: TFDPhysParamMark; override;
    function GetInlineRefresh: Boolean; override;
    function GetSelectOptions: TFDPhysSelectOptions; override;
    function GetAsyncAbortSupported: Boolean; override;
    function GetLockNoWait: Boolean; override;
    function GetDefValuesSupported: TFDPhysDefaultValues; override;
    function GetLineSeparator: TFDTextEndOfLine; override;
    function GetLimitOptions: TFDPhysLimitOptions; override;
    function GetNullLocations: TFDPhysNullLocations; override;
    function GetColumnOriginProvided: Boolean; override;
    function InternalEscapeBoolean(const AStr: String): String; override;
    function InternalEscapeDate(const AStr: String): String; override;
    function InternalEscapeDateTime(const AStr: String): String; override;
    function InternalEscapeFloat(const AStr: String): String; override;
    function InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String; override;
    function InternalEscapeTime(const AStr: String): String; override;
    function InternalEscapeInto(const AStr: String): String; override;
    function InternalGetSQLCommandKind(const ATokens: TStrings): TFDPhysCommandKind; override;
  public
    constructor Create(const AConnection: TFDPhysConnection;
      AServerVersion, AClientVersion: TFDVersion; AIsUnicode: Boolean);
  end;

  TFDPhysOraCommandGenerator = class(TFDPhysCommandGenerator)
  private
    FUseDBAViews: Boolean;
  protected
    function GetInlineRefresh(const AStmt: String;
      ARequest: TFDUpdateRequest): String; override;
    function GetPessimisticLock: String; override;
    function GetSavepoint(const AName: String): String; override;
    function GetRollbackToSavepoint(const AName: String): String; override;
    function GetReadGenerator(const AName, AAlias: String;
      ANextValue, AFullSelect: Boolean): String; override;
    function GetSingleRowTable: String; override;
    function GetRowId(var AAlias: String): String; override;
    function GetCall(const AName: String): String; override;
    function GetStoredProcCall(const ACatalog, ASchema, APackage, AProc: String;
      ASPUsage: TFDPhysCommandKind): String; override;
    function GetSelectMetaInfo(AKind: TFDPhysMetaInfoKind; const ACatalog,
      ASchema, ABaseObject, AObject, AWildcard: String;
      AObjectScopes: TFDPhysObjectScopes; ATableKinds: TFDPhysTableKinds;
      AOverload: Word): String; override;
    function GetLimitSelect(const ASQL: String; ASkip, ARows: Integer): String; override;
    function GetColumnType(AColumn: TFDDatSColumn): String; override;
    function GetCreateGenerator(const AName: String): String; override;
    function GetDropGenerator(const AName: String): String; override;
    function GetCreateIdentityTrigger: String; override;
  public
    constructor Create(const ACommand: IFDPhysCommand; AUseDBAViews: Boolean); overload;
    constructor Create(const AConnection: IFDPhysConnection; AUseDBAViews: Boolean); overload;
  end;

implementation

uses
  System.SysUtils, Data.DB,
  FireDAC.Stan.Consts, FireDAC.Stan.Util, FireDAC.Stan.Param;

{-------------------------------------------------------------------------------}
{ TFDPhysOraMetadata                                                            }
{-------------------------------------------------------------------------------}
constructor TFDPhysOraMetadata.Create(const AConnection: TFDPhysConnection;
  AServerVersion, AClientVersion: TFDVersion; AIsUnicode: Boolean);
begin
  inherited Create(AConnection, AServerVersion, AClientVersion, AIsUnicode);
  FKeywords.CommaText :=
    // Oracle 10g reserved words
    'ACCESS,ELSE,MODIFY,START,' +
    'ADD,EXCLUSIVE,NOAUDIT,SELECT,' +
    'ALL,EXISTS,NOCOMPRESS,SESSION,' +
    'ALTER,FILE,NOT,SET,' +
    'AND,FLOAT,NOTFOUND,SHARE,' +
    'ANY,FOR,NOWAIT,SIZE,' +
    'ARRAYLEN,FROM,NULL,SMALLINT,' +
    'AS,GRANT,NUMBER,SQLBUF,' +
    'ASC,GROUP,OF,SUCCESSFUL,' +
    'AUDIT,HAVING,OFFLINE,SYNONYM,' +
    'BETWEEN,IDENTIFIED,ON,SYSDATE,' +
    'BY,IMMEDIATE,ONLINE,TABLE,' +
    'CHAR,IN,OPTION,THEN,' +
    'CHECK,INCREMENT,OR,TO,' +
    'CLUSTER,INDEX,ORDER,TRIGGER,' +
    'COLUMN,INITIAL,PCTFREE,UID,' +
    'COMMENT,INSERT,PRIOR,UNION,' +
    'COMPRESS,INTEGER,PRIVILEGES,UNIQUE,' +
    'CONNECT,INTERSECT,PUBLIC,UPDATE,' +
    'CREATE,INTO,RAW,USER,' +
    'CURRENT,IS,RENAME,VALIDATE,' +
    'DATE,LEVEL,RESOURCE,VALUES,' +
    'DECIMAL,LIKE,REVOKE,VARCHAR,' +
    'DEFAULT,LOCK,ROW,VARCHAR2,' +
    'DELETE,LONG,ROWID,VIEW,' +
    'DESC,MAXEXTENTS,ROWLABEL,WHENEVER,' +
    'DISTINCT,MINUS,ROWNUM,WHERE,' +
    'DROP,MODE,ROWS,WITH,' +
    // Oracle 10g key words
    'ADMIN,CURSOR,FOUND,MOUNT,' +
    'AFTER,CYCLE,FUNCTION,NEXT,' +
    'ALLOCATE,DATABASE,GO,NEW,' +
    'ANALYZE,DATAFILE,GOTO,NOARCHIVELOG,' +
    'ARCHIVE,DBA,GROUPS,NOCACHE,' +
    'ARCHIVELOG,DEC,INCLUDING,NOCYCLE,' +
    'AUTHORIZATION,DECLARE,INDICATOR,NOMAXVALUE,' +
    'AVG,DISABLE,INITRANS,NOMINVALUE,' +
    'BACKUP,DISMOUNT,INSTANCE,NONE,' +
    'BEGIN,DOUBLE,INT,NOORDER,' +
    'BECOME,DUMP,KEY,NORESETLOGS,' +
    'BEFORE,EACH,LANGUAGE,NORMAL,' +
    'BLOCK,ENABLE,LAYER,NOSORT,' +
    'BODY,END,LINK,NUMERIC,' +
    'CACHE,ESCAPE,LISTS,OFF,' +
    'CANCEL,EVENTS,LOGFILE,OLD,' +
    'CASCADE,EXCEPT,MANAGE,ONLY,' +
    'CHANGE,EXCEPTIONS,MANUAL,OPEN,' +
    'CHARACTER,EXEC,MAX,OPTIMAL,' +
    'CHECKPOINT,EXPLAIN,MAXDATAFILES,OWN,' +
    'CLOSE,EXECUTE,MAXINSTANCES,PACKAGE,' +
    'COBOL,EXTENT,MAXLOGFILES,PARALLEL,' +
    'COMMIT,EXTERNALLY,MAXLOGHISTORY,PCTINCREASE ,' +
    'COMPILE,FETCH,MAXLOGMEMBERS,PCTUSED ,' +
    'CONSTRAINT,FLUSH,MAXTRANS,PLAN ,' +
    'CONSTRAINTS,FREELIST,MAXVALUE,PLI ,' +
    'CONTENTS,FREELISTS,MIN,PRECISION ,' +
    'CONTINUE,FORCE,MINEXTENTS,PRIMARY ,' +
    'CONTROLFILE,FOREIGN,MINVALUE,PRIVATE ,' +
    'COUNT,FORTRAN,MODULE,PROCEDURE ,' +
    'PROFILE,SAVEPOINT,SQLSTATE,TRACING ,' +
    'QUOTA,SCHEMA,STATEMENT_ID,TRANSACTION ,' +
    'READ,SCN,STATISTICS,TRIGGERS ,' +
    'REAL,SECTION,STOP,TRUNCATE ,' +
    'RECOVER,SEGMENT,STORAGE,UNDER ,' +
    'REFERENCES,SEQUENCE,SUM,UNLIMITED ,' +
    'REFERENCING,SHARED,SWITCH,UNTIL ,' +
    'RESETLOGS,SNAPSHOT,SYSTEM,USE ,' +
    'RESTRICTED,SOME,TABLES,USING ,' +
    'REUSE,SORT,TABLESPACE,WHEN ,' +
    'ROLE,SQL,TEMPORARY,WRITE ,' +
    'ROLES,SQLCODE,THREAD,WORK,' +
    'ROLLBACK,SQLERROR,TIME   ,' +
    // Oracle 10g PL/SQL reserved words
    'ABORT,BETWEEN,CRASH,DIGITS,' +
    'ACCEPT,BINARY_INTEGER,CREATE,DISPOSE,' +
    'ACCESS,BODY,CURRENT,DISTINCT,' +
    'ADD,BOOLEAN,CURRVAL,DO,' +
    'ALL,BY,CURSOR,DROP,' +
    'ALTER,CASE,DATABASE,ELSE,' +
    'AND,CHAR,DATA_BASE,ELSIF,' +
    'ANY,CHAR_BASE,DATE,END,' +
    'ARRAY,CHECK,DBA,ENTRY,' +
    'ARRAYLEN,CLOSE,DEBUGOFF,EXCEPTION,' +
    'AS,CLUSTER,DEBUGON,EXCEPTION_INIT,' +
    'ASC,CLUSTERS,DECLARE,EXISTS,' +
    'ASSERT,COLAUTH,DECIMAL,EXIT,' +
    'ASSIGN,COLUMNS,DEFAULT,FALSE,' +
    'AT,COMMIT,DEFINITION,FETCH,' +
    'AUTHORIZATION,COMPRESS,DELAY,FLOAT,' +
    'AVG,CONNECT,DELETE,FOR,' +
    'BASE_TABLE,CONSTANT,DELTA,FORM,' +
    'BEGIN,COUNT,DESC,FROM,' +
    'FUNCTION,NEW,RELEASE,SUM ,' +
    'GENERIC,NEXTVAL,REMR,TABAUTH ,' +
    'GOTO,NOCOMPRESS,RENAME,TABLE ,' +
    'GRANT,NOT,RESOURCE,TABLES ,' +
    'GROUP,NULL,RETURN,TASK ,' +
    'HAVING,NUMBER,REVERSE,TERMINATE ,' +
    'IDENTIFIED,NUMBER_BASE,REVOKE,THEN,' +
    'IF,OF,ROLLBACK,TO,' +
    'IN,ON,ROWID,TRUE,' +
    'INDEX,OPEN,ROWLABEL,TYPE,' +
    'INDEXES,OPTION,ROWNUM,UNION,' +
    'INDICATOR,OR,ROWTYPE,UNIQUE,' +
    'INSERT,ORDER,RUN,UPDATE,' +
    'INTEGER,OTHERS,SAVEPOINT,USE,' +
    'INTERSECT,OUT,SCHEMA,VALUES,' +
    'INTO,PACKAGE,SELECT,VARCHAR,' +
    'IS,PARTITION,SEPARATE,VARCHAR2,' +
    'LEVEL,PCTFREE,SET,VARIANCE,' +
    'LIKE,POSITIVE,SIZE,VIEW,' +
    'LIMITED,PRAGMA,SMALLINT,VIEWS,' +
    'LOOP,PRIOR,SPACE,WHEN,' +
    'MAX,PRIVATE,SQL,WHERE,' +
    'MIN,PROCEDURE,SQLCODE,WHILE,' +
    'MINUS,PUBLIC,SQLERRM,WITH,' +
    'MLSLABEL,RAISE,START,WORK,' +
    'MOD,RANGE,STATEMENT,XOR,' +
    'MODE,REAL,STDDEV,' +
    'NATURAL,RECORD,SUBTYPE';
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.Oracle;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetNameCaseSensParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetNameDefLowCaseParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetParamNameMaxLength: Integer;
begin
  Result := 30;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetNameParts: TFDPhysNameParts;
begin
  Result := [npSchema, npDBLink, npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetNamedParamMark: TFDPhysParamMark;
begin
  Result := prName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetTxSavepoints: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetEventSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetEventKinds: String;
begin
  Result := S_FD_EventKind_Oracle_DBMS_ALERT + ';' + S_FD_EventKind_Oracle_DBMS_PIPE;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetGeneratorSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetIdentitySupported: Boolean;
begin
  Result := (GetServerVersion >= cvOracle120000) and
            (GetClientVersion >= cvOracle120000);
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetIdentityInsertSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetIdentityInWhere: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetInsertHBlobMode: TFDPhysInsertHBlobMode;
begin
  if (GetClientVersion >= cvOracle81000) or
     (GetClientVersion < cvOracle80000) then
    Result := hmInInsert
  else
    Result := hmSetAfterReturning;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetInlineRefresh: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetSelectOptions: TFDPhysSelectOptions;
begin
  Result := [soInlineView];
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetLockNoWait: Boolean;
begin
  Result := True;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysOraMetadata.GetAsyncAbortSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetDefValuesSupported: TFDPhysDefaultValues;
begin
  if GetServerVersion >= cvOracle90000 then
    Result := dvDef
  else
    Result := dvNone;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetLineSeparator: TFDTextEndOfLine;
begin
  Result := elPosix;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetLimitOptions: TFDPhysLimitOptions;
begin
  Result := [loSkip, loRows];
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetNullLocations: TFDPhysNullLocations;
begin
  Result := [nlAscLast, nlDescFirst];
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.GetColumnOriginProvided: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.InternalEscapeBoolean(
  const AStr: String): String;
begin
  if CompareText(AStr, S_FD_True) = 0 then
    Result := '1'
  else
    Result := '0';
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.InternalEscapeDate(const AStr: String): String;
begin
  Result := 'TO_DATE(' + AnsiQuotedStr(AStr, '''') + ', ''YYYY-MM-DD'')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.InternalEscapeDateTime(const AStr: String): String;
begin
  Result := 'TO_DATE(' + AnsiQuotedStr(AStr, '''') + ', ''YYYY-MM-DD HH24:MI:SS'')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.InternalEscapeTime(const AStr: String): String;
begin
  Result := 'TO_DATE(' + AnsiQuotedStr('1900-01-01' + AStr, '''') + ', ''YYYY-MM-DD HH24:MI:SS'')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.InternalEscapeFloat(const AStr: String): String;
begin
  Result := 'TO_NUMBER(' + AnsiQuotedStr(AStr, '''') + ')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.InternalEscapeInto(const AStr: String): String;
begin
  Result := 'INTO ' + AStr;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String;
var
  sName: String;
  A1, A2, A3, A4: String;
  rSeq: TFDPhysEscapeData;

  function AddArgs: string;
  begin
    if Length(ASeq.FArgs) > 0 then
      Result := '(' + AddEscapeSequenceArgs(ASeq) + ')';
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
  // the same
  efASCII,
  efLTRIM,
  efREPLACE,
  efRTRIM,
  efABS,
  efACOS,
  efASIN,
  efATAN,
  efCOS,
  efEXP,
  efFLOOR,
  efMOD,
  efPOWER,
  efROUND,
  efSIGN,
  efSIN,
  efSQRT,
  efTAN,
  efDECODE:      Result := sName + AddArgs;
  // character
  efBIT_LENGTH:  Result := '(LENGTHB(' + A1 + ') * 8)';
  efCHAR:        Result := 'CHR' + AddArgs;
  efCHAR_LENGTH: Result := 'LENGTH' + AddArgs;
  efCONCAT:      Result := '(' + A1 + ' || ' + A2 + ')';
  efINSERT:      Result := '(SUBSTR(' + A1 + ', 1, (' + A2 + ') - 1) || ' + A4 +
                    ' || SUBSTR(' + A1 + ', (' + A2 + ' + ' + A3 + ')))';
  efLCASE:       Result := 'LOWER' + AddArgs;
  efLEFT:        Result := 'SUBSTR(' + A1 + ', 1, ' + A2 + ')';
  efLENGTH:      Result := 'LENGTH(RTRIM(' + A1 + '))';
  efLOCATE:
    begin
      Result := 'INSTR(' + A2 + ', ' + A1;
      if Length(ASeq.FArgs) = 3 then
        Result := Result + ', ' + A3;
      Result := Result + ')'
    end;
  efOCTET_LENGTH:Result := 'LENGTHB' + AddArgs;
  efPOSITION:    Result := 'INSTR(' + A2 + ', ' + A1 + ')';
  efREPEAT:      Result := 'RPAD(' + A1 + ', (' + A2 + ') * LENGTH(' + A1 + '), ' + A1 + ')';
  efRIGHT:       Result := 'SUBSTR(' + A1 + ', LENGTH(' + A1 + ') + 1 - (' + A2 + '))';
  efSPACE:       Result := 'RPAD('' '', ' + A1 + ')';
  efSUBSTRING:   Result := 'SUBSTR' + AddArgs;
  efUCASE:       Result := 'UPPER' + AddArgs;
  // numeric
  efCEILING:     Result := 'CEIL' + AddArgs;
  efDEGREES:     Result := '(180 * (' + A1 + ') / ' + S_FD_Pi  + ')';
  efLOG:         Result := 'LN' + AddArgs;
  efLOG10:       Result := 'LOG(10, ' + A1 + ')';
  efPI:          Result := S_FD_Pi;
  efRADIANS:     Result := '((' + A1 + ') / 180 * ' + S_FD_Pi + ')';
  efRANDOM:
    if GetServerVersion >= cvOracle90000 then
      Result := 'DBMS_RANDOM.VALUE'
    else
      Result := 'MOD(TRUNC((SYSDATE - TRUNC(SYSDATE)) * 60 * 60 * 24), 1000)';
  efTRUNCATE:    Result := 'TRUNC' + AddArgs;
  // date and time
  efCURDATE:     Result := 'TRUNC(SYSDATE)';
  efCURTIME:     Result := '(TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') + (SYSDATE - TRUNC(SYSDATE)))';
  efNOW:         Result := 'SYSDATE';
  efDAYNAME:     Result := 'RTRIM(TO_CHAR(' + A1 + ', ''DAY''))';
  efDAYOFMONTH:  Result := 'TO_NUMBER(TO_CHAR(' + A1 + ', ''DD''))';
  efDAYOFWEEK:   Result := 'TO_NUMBER(TO_CHAR(' + A1 + ', ''D''))';
  efDAYOFYEAR:   Result := 'TO_NUMBER(TO_CHAR(' + A1 + ', ''DDD''))';
  efEXTRACT:
    begin
      rSeq.FKind := eskFunction;
      if A1[1] = '''' then
        A1 := Copy(A1, 2, Length(A1) - 2);
      A1 := UpperCase(A1);
      if A1 = 'DAY' then
        A1 := 'DAYOFMONTH';
      rSeq.FName := A1;
      SetLength(rSeq.FArgs, 1);
      rSeq.FArgs[0] := ASeq.FArgs[1];
      EscapeFuncToID(rSeq);
      Result := InternalEscapeFunction(rSeq);
    end;
  efHOUR:        Result := 'TO_NUMBER(TO_CHAR(' + A1 + ', ''HH24''))';
  efMINUTE:      Result := 'TO_NUMBER(TO_CHAR(' + A1 + ', ''MI''))';
  efMONTH:       Result := 'TO_NUMBER(TO_CHAR(' + A1 + ', ''MM''))';
  efMONTHNAME:   Result := 'RTRIM(TO_CHAR(' + A1 + ', ''MONTH''))';
  efQUARTER:     Result := 'TO_NUMBER(TO_CHAR(' + A1 + ', ''Q''))';
  efSECOND:      Result := 'TO_NUMBER(TO_CHAR(' + A1 + ', ''SS''))';
  efTIMESTAMPADD:
    begin
      A1 := UpperCase(FDUnquote(Trim(A1), ''''));
      if A1 = 'YEAR' then
        Result := 'ADD_MONTHS(' + A3 + ', 12 * (' + A2 + '))'
      else if A1 = 'MONTH' then
        Result := 'ADD_MONTHS(' + A3 + ', ' + A2 + ')'
      else if A1 = 'WEEK' then
        Result := '(' + A3 + ' + 7 * (' + A2 + '))'
      else if A1 = 'DAY' then
        Result := '(' + A3 + ' + ' + A2 + ')'
      else if A1 = 'HOUR' then
        Result := '(' + A3 + ' + (' + A2 + ') / 24.0)'
      else if A1 = 'MINUTE' then
        Result := '(' + A3 + ' + (' + A2 + ') / (24.0 * 60.0))'
      else if A1 = 'SECOND' then
        Result := '(' + A3 + ' + (' + A2 + ') / (24.0 * 60.0 * 60.0))'
      else if A1 = 'FRAC_SECOND' then
        Result := '(' + A3 + ' + (' + A2 + ') / (24.0 * 60.0 * 60.0 * 1000000))'
      else
        UnsupportedEscape(ASeq);
    end;
  efTIMESTAMPDIFF:
    begin
      A1 := UpperCase(FDUnquote(Trim(A1), ''''));
      if A1 = 'YEAR' then
        Result := 'TRUNC(MONTHS_BETWEEN(' + A3 + ', ' + A2 + ') / 12)'
      else if A1 = 'MONTH' then
        Result := 'MONTHS_BETWEEN(' + A3 + ', ' + A2 + ')'
      else if A1 = 'WEEK' then
        Result := 'TRUNC(((' + A3 + ') - (' + A2 + ')) / 7)'
      else if A1 = 'DAY' then
        Result := '((' + A3 + ') - (' + A2 + '))'
      else if A1 = 'HOUR' then
        Result := 'TRUNC(((' + A3 + ') - (' + A2 + ')) * 24.0)'
      else if A1 = 'MINUTE' then
        Result := 'TRUNC(((' + A3 + ') - (' + A2 + ')) * (24.0 * 60.0))'
      else if A1 = 'SECOND' then
        Result := 'TRUNC(((' + A3 + ') - (' + A2 + ')) * (24.0 * 60.0 * 60.0))'
      else if A1 = 'FRAC_SECOND' then
        Result := 'TRUNC(((' + A3 + ') - (' + A2 + ')) * (24.0 * 60.0 * 60.0 * 1000000.0))'
      else
        UnsupportedEscape(ASeq);
    end;
  efWEEK:        Result := 'TO_NUMBER(TO_CHAR(' + A1 + ', ''WW''))';
  efYEAR:        Result := 'TO_NUMBER(TO_CHAR(' + A1 + ', ''YYYY''))';
  // system
  efCATALOG:     Result := '''''';
  efSCHEMA:
    if GetServerVersion < cvOracle81500 then
      Result := 'USER'
    else
      Result := 'SYS_CONTEXT(''USERENV'', ''CURRENT_SCHEMA'')';
  efIFNULL:      Result := 'NVL' + AddArgs;
  efIF:
    if GetServerVersion >= cvOracle90000 then
      Result := 'CASE WHEN ' + A1 + ' THEN ' + A2 + ' ELSE ' + A3 + ' END'
    else
      UnsupportedEscape(ASeq);
  // convert
  efCONVERT:
    begin
      A2 := UpperCase(FDUnquote(Trim(A2), ''''));
      if (A2 = 'CHAR') or (A2 = 'LONGVARCHAR') or (A2 = 'VARCHAR') then
        Result := 'TO_CHAR(' + A1 + ')'
      else if (A2 = 'WCHAR') or (A2 = 'WLONGVARCHAR') or (A2 = 'WVARCHAR') then
        Result := 'TO_NCHAR(' + A1 + ')'
      else if (A2 = 'DATE') then
        if GetServerVersion >= cvOracle90000 then
          Result := 'TRUNC(CAST(' + A1 + ' AS DATE))'
        else
          Result := 'TRUNC(TO_DATE(' + A1 + '))'
      else if (A2 = 'DATETIME') then
        if GetServerVersion >= cvOracle90000 then
          Result := 'CAST(' + A1 + ' AS DATE)'
        else
          Result := 'TO_DATE(' + A1 + ')'
      else if (A2 = 'TIME') then
        if GetServerVersion >= cvOracle90000 then
          Result := '(TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') + (CAST(' + A1 + ' AS DATE) - TRUNC(CAST(' + A1 + ' AS DATE))))'
        else
          Result := '(TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') + (TO_DATE(' + A1 + ') - TRUNC(TO_DATE(' + A1 + '))))'
      else if (A2 = 'DECIMAL') or (A2 = 'DOUBLE') or (A2 = 'FLOAT') or
              (A2 = 'NUMERIC') or (A2 = 'REAL') then
        Result := 'TO_NUMBER(' + A1 + ')'
      else if (A2 = 'INTEGER') or (A2 = 'SMALLINT') or (A2 = 'TINYINT') or
              (A2 = 'BIGINT') then
        Result := 'TRUNC(TO_NUMBER(' + A1 + '))'
      else
        UnsupportedEscape(ASeq);
    end;
  else
    // unsupported ATAN2, COT
    UnsupportedEscape(ASeq);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraMetadata.InternalGetSQLCommandKind(
  const ATokens: TStrings): TFDPhysCommandKind;
var
  sToken: String;
begin
  sToken := ATokens[0];
  if sToken = 'ALTER' then
    if (ATokens.Count = 1) or
       (ATokens.Count = 2) and (ATokens[1] = 'SESSION') or
       (ATokens.Count = 3) and (ATokens[2] = 'SET') then
      Result := skNotResolved
    else if (ATokens.Count = 4) and (ATokens[3] = 'CURRENT_SCHEMA') then
      Result := skSetSchema
    else
      Result := skAlter
  else if (sToken = 'DECLARE') or (sToken = 'BEGIN') then
    Result := skExecute
  else if sToken = 'SET' then
    if ATokens.Count = 1 then
      Result := skNotResolved
    else if ATokens[1] = 'TRANSACTION' then
      Result := skStartTransaction
    else
      Result := inherited InternalGetSQLCommandKind(ATokens)
  else
    Result := inherited InternalGetSQLCommandKind(ATokens);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysOraCommandGenerator                                                    }
{-------------------------------------------------------------------------------}
constructor TFDPhysOraCommandGenerator.Create(const ACommand: IFDPhysCommand;
  AUseDBAViews: Boolean);
begin
  inherited Create(ACommand);
  FUseDBAViews := AUseDBAViews;
end;

{-------------------------------------------------------------------------------}
constructor TFDPhysOraCommandGenerator.Create(
  const AConnection: IFDPhysConnection; AUseDBAViews: Boolean);
begin
  inherited Create(AConnection);
  FUseDBAViews := AUseDBAViews;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraCommandGenerator.GetInlineRefresh(const AStmt: String;
  ARequest: TFDUpdateRequest): String;
begin
  Result := AStmt + GetReturning(ARequest, True);
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraCommandGenerator.GetPessimisticLock: String;
var
  lNeedFrom: Boolean;
begin
  Result := 'SELECT ' + GetSelectList(True, False, lNeedFrom) + BRK +
    'FROM ' + GetFrom + BRK + 'WHERE ' + GetWhere(False, True, False) + BRK +
    'FOR UPDATE';
  FCommandKind := skSelectForLock;
  ASSERT(lNeedFrom);
  if not FOptions.UpdateOptions.LockWait then
    Result := Result + ' NOWAIT';
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraCommandGenerator.GetSavepoint(const AName: String): String;
begin
  Result := 'SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraCommandGenerator.GetRollbackToSavepoint(const AName: String): String;
begin
  Result := 'ROLLBACK TO SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraCommandGenerator.GetReadGenerator(const AName, AAlias: String;
  ANextValue, AFullSelect: Boolean): String;
begin
  Result := AName;
  if ANextValue then
    Result := Result + '.NEXTVAL'
  else
    Result := Result + '.CURRVAL';
  if AAlias <> '' then
    Result := Result + ' ' + AAlias;
  if AFullSelect then
    Result := 'SELECT ' + Result + BRK + 'FROM ' + GetSingleRowTable;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraCommandGenerator.GetSingleRowTable: String;
begin
  Result := 'SYS.DUAL';
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraCommandGenerator.GetRowId(var AAlias: String): String;
begin
  Result := 'ROWID';
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraCommandGenerator.GetCall(const AName: String): String;
begin
  Result := 'BEGIN ' + AName;
  if Result[Length(Result)] <> ';' then
    Result := Result + ';';
  Result := Result + ' END;';
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraCommandGenerator.GetStoredProcCall(const ACatalog, ASchema,
  APackage, AProc: String; ASPUsage: TFDPhysCommandKind): String;
var
  i: Integer;
  oParam: TFDParam;
  rName: TFDPhysParsedName;
  lWasParam: Boolean;

  function BuildParamStr(AParam: TFDParam): String;
  var
    sName: String;
  begin
    sName := AParam.SQLName;
    if (FParams.BindMode = pbByName) and (AParam.ParamType <> ptResult) then
      Result := sName + ' => '
    else
      Result := '';
    Result := Result + ':' + sName;
  end;

begin
  Result := 'BEGIN ';
  for i := 0 to FParams.Count - 1 do
    if FParams[i].ParamType = ptResult then begin
      Result := Result + BuildParamStr(FParams[i]) + ' := ';
      Break;
    end;

  rName.FCatalog := ACatalog;
  rName.FSchema := ASchema;
  rName.FBaseObject := APackage;
  rName.FObject := AProc;
  Result := Result + FConnMeta.EncodeObjName(rName, FCommand, [eoQuote, eoNormalize]);

  lWasParam := False;
  for i := 0 to FParams.Count - 1 do begin
    case FParams.BindMode of
    pbByName:   oParam := FParams[i];
    pbByNumber: oParam := FParams.FindParam(i + 1);
    else        oParam := nil;
    end;
    if (oParam = nil) or (oParam.ParamType <> ptResult) then begin
      if lWasParam then
        Result := Result + ', '
      else begin
        Result := Result + '(';
        lWasParam := True;
      end;
      if oParam = nil then
        Result := Result + 'NULL'
      else
        Result := Result + BuildParamStr(oParam);
    end;
  end;

  if lWasParam then
    Result := Result + ')';
  Result := Result + '; END;';
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraCommandGenerator.GetSelectMetaInfo(AKind: TFDPhysMetaInfoKind;
  const ACatalog, ASchema, ABaseObject, AObject, AWildcard: String;
  AObjectScopes: TFDPhysObjectScopes; ATableKinds: TFDPhysTableKinds;
  AOverload: Word): String;
var
  sKinds, sViewPrefix, sUserFunc: String;
  sCharLen, sUniCharLen, sUniVarCharLen: String;
  sIndexName, sOwnerName, sToChar: String;
  sIndexName2, sOwnerName2, sToChar2: String;
  lWasWhere: Boolean;
  oPar: TFDParam;

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
      oPar.Size := 50;
    end;
  end;

  procedure AddTopScope(AOwnerName: String);
  var
    sScope: String;
  begin
    if ASchema <> '' then
      AddWhere(AOwnerName + ' = ''' + ASchema + '''')
    else if AObjectScopes <> [osMy, osSystem, osOther] then begin
      sScope := '';
      if osMy in AObjectScopes then
        sScope := sScope + AOwnerName + ' = ' + sUserFunc + ' OR ';
      if osSystem in AObjectScopes then
        sScope := sScope + AOwnerName + ' IN (''SYS'', ''SYSTEM'', ''INFORMATION_SCHEMA'') OR ';
      if osOther in AObjectScopes then
        sScope := sScope + AOwnerName + ' NOT IN (''SYS'', ''SYSTEM'', ''INFORMATION_SCHEMA'', ' + sUserFunc + ') OR ';
      if sScope <> '' then
        AddWhere('(' + Copy(sScope, 1, Length(sScope) - 4) + ')');
    end;
  end;

  function EncodeDataType(const AFieldName: String): String;

    function DT2Str(AType: TFDDataType): String;
    begin
      Result := IntToStr(Integer(AType));
    end;

  begin
    Result := 'DECODE(' + AFieldName + ', ' +
      '''CHAR'', ' + DT2Str(dtAnsiString) + ', ' +
      '''VARCHAR'', ' + DT2Str(dtAnsiString) + ', ' +
      '''VARCHAR2'', ' + DT2Str(dtAnsiString) + ', ' +
      '''NCHAR'', ' + DT2Str(dtWideString) + ', ' +
      '''NCHAR VARYING'', ' + DT2Str(dtWideString) + ', ' +
      '''NVARCHAR2'', ' + DT2Str(dtWideString) + ', ' +
      '''NUMBER'', ' + DT2Str(dtFmtBCD) + ', ' +
      '''FLOAT'', ' + DT2Str(dtDouble) + ', ' +
      '''DATE'', ' + DT2Str(dtDateTime) + ', ' +
      '''RAW'', ' + DT2Str(dtByteString) + ', ' +
      '''LONG'', ' + DT2Str(dtMemo) + ', ' +
      '''LONG RAW'', ' + DT2Str(dtBlob) + ', ' +
      '''ROWID'', ' + DT2Str(dtAnsiString) + ', ' +
      '''UROWID'', ' + DT2Str(dtAnsiString) + ', ' +
      '''NCLOB'', ' + DT2Str(dtWideHMemo) + ', ' +
      '''CLOB'', ' + DT2Str(dtHMemo) + ', ' +
      '''BLOB'', ' + DT2Str(dtHBlob) + ', ' +
      '''BFILE'', ' + DT2Str(dtHBFile) + ', ' +
      '''CFILE'', ' + DT2Str(dtHBFile) + ', ' +
      '''NATIVE INTEGER'', ' + DT2Str(dtInt32) + ', ' +
      '''BINARY_INTEGER'', ' + DT2Str(dtInt32) + ', ' +
      '''REF CURSOR'', ' + DT2Str(dtCursorRef) + ', ' +
      '''PL/SQL BOOLEAN'', ' + DT2Str(dtBoolean) + ', ' +
      '''TIME'', ' + DT2Str(dtDateTimeStamp) + ', ' +
      '''TIME WITH TIME ZONE'', ' + DT2Str(dtDateTimeStamp) + ', ' +
      '''TIMESTAMP'', ' + DT2Str(dtDateTimeStamp) + ', ' +
      '''TIMESTAMP(1)'', ' + DT2Str(dtDateTimeStamp) + ', ' +
      '''TIMESTAMP(2)'', ' + DT2Str(dtDateTimeStamp) + ', ' +
      '''TIMESTAMP(3)'', ' + DT2Str(dtDateTimeStamp) + ', ' +
      '''TIMESTAMP(4)'', ' + DT2Str(dtDateTimeStamp) + ', ' +
      '''TIMESTAMP(5)'', ' + DT2Str(dtDateTimeStamp) + ', ' +
      '''TIMESTAMP(6)'', ' + DT2Str(dtDateTimeStamp) + ', ' +
      '''TIMESTAMP(7)'', ' + DT2Str(dtDateTimeStamp) + ', ' +
      '''TIMESTAMP(8)'', ' + DT2Str(dtDateTimeStamp) + ', ' +
      '''TIMESTAMP(9)'', ' + DT2Str(dtDateTimeStamp) + ', ' +
      '''TIMESTAMP WITH TIME ZONE'', ' + DT2Str(dtDateTimeStamp) + ', ' +
      '''TIMESTAMP WITH LOCAL TIME ZONE'', ' + DT2Str(dtDateTimeStamp) + ', ' +
      '''INTERVAL YEAR TO MONTH'', ' + DT2Str(dtTimeIntervalYM) + ', ' +
      '''INTERVAL DAY TO SECOND'', ' + DT2Str(dtTimeIntervalDS) + ', ' +
      '''BINARY_FLOAT'', ' + DT2Str(dtSingle) + ', ' +
      '''BINARY_DOUBLE'', ' + DT2Str(dtDouble) + ', ' +
      DT2Str(dtUnknown) + ')';
  end;

  function EncodeAttrs(const ATypeFieldName, ANullableFieldName,
    ADefaultLengthFieldName, AIdentityFieldName: String): String;

    function Attrs2Str(AAttrs: TFDDataAttributes): String;
    begin
      if AKind <> mkTableFields then
        Exclude(AAttrs, caBase);
      Result := IntToStr(PWord(@AAttrs)^);
    end;

  begin
    Result := 'DECODE(' + ATypeFieldName + ', ' +
      '''CHAR'', ' + Attrs2Str([caBase, caFixedLen, caSearchable]) + ', ' +
      '''VARCHAR'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''VARCHAR2'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''NCHAR'', ' + Attrs2Str([caBase, caFixedLen, caSearchable]) + ', ' +
      '''NCHAR VARYING'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''NVARCHAR2'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''NUMBER'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''FLOAT'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''DATE'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''RAW'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''LONG'', ' + Attrs2Str([caBase, caBlobData]) + ', ' +
      '''LONG RAW'', ' + Attrs2Str([caBase, caBlobData]) + ', ' +
      '''ROWID'', ' + Attrs2Str([caBase, caAllowNull, caFixedLen, caSearchable, caROWID]) + ', ' +
      '''UROWID'', ' + Attrs2Str([caBase, caAllowNull, caSearchable, caROWID]) + ', ' +
      '''NCLOB'', ' + Attrs2Str([caBase, caBlobData]) + ', ' +
      '''CLOB'', ' + Attrs2Str([caBase, caBlobData]) + ', ' +
      '''BLOB'', ' + Attrs2Str([caBase, caBlobData]) + ', ' +
      '''BFILE'', ' + Attrs2Str([caBase, caBlobData, caVolatile]) + ', ' +
      '''CFILE'', ' + Attrs2Str([caBase, caBlobData, caVolatile]) + ', ' +
      '''NATIVE INTEGER'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''BINARY_INTEGER'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''REF CURSOR'', ' + Attrs2Str([caAllowNull]) + ', ' +
      '''PL/SQL BOOLEAN'', ' + Attrs2Str([]) + ', ' +
      '''TIME'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''TIME WITH TIME ZONE'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''TIMESTAMP'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''TIMESTAMP WITH TIME ZONE'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''TIMESTAMP WITH LOCAL TIME ZONE'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''INTERVAL YEAR TO MONTH'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''INTERVAL DAY TO SECOND'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''BINARY_FLOAT'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      '''BINARY_DOUBLE'', ' + Attrs2Str([caBase, caSearchable]) + ', ' +
      Attrs2Str([caBase]) + ') + ';
    if ANullableFieldName <> '' then
      Result := Result + 'DECODE(' + ANullableFieldName +
        ', ''Y'', ' + Attrs2Str([caAllowNull]) + ', ' + Attrs2Str([]) + ')'
    else
      Result := Result + Attrs2Str([caAllowNull]);
    if ADefaultLengthFieldName <> '' then
      Result := Result + ' + DECODE(' + ADefaultLengthFieldName + ', NULL, ' +
        Attrs2Str([]) + ', ' + Attrs2Str([caDefault]) + ')';
    if (FConnMeta.ServerVersion >= cvOracle120000) and (AIdentityFieldName <> '') then
      Result := Result + ' + DECODE(' + AIdentityFieldName + ', ''YES'', ' +
        Attrs2Str([caAutoInc]) + ', 0)';
  end;

  function EncodeScope(const AOwnerFieldName: String): String;
  begin
    Result := 'DECODE(' + AOwnerFieldName + ', ' +
      sUserFunc + ', ' + IntToStr(Integer(osMy)) + ', ' +
      '''SYS'', ' +    IntToStr(Integer(osSystem)) + ', ' +
      '''SYSTEM'', ' + IntToStr(Integer(osSystem)) + ', ' +
      '''INFORMATION_SCHEMA'', ' + IntToStr(Integer(osSystem)) + ', ' +
                       IntToStr(Integer(osOther)) + ')';
  end;

  procedure GetLengthExpressions(var ACharLen, AUniCharLen, AUniVarCharLen: String);
  begin
    if FConnMeta.ServerVersion >= cvOracle90000 then begin
      ACharLen := 'CHAR_LENGTH';
      AUniCharLen := 'CHAR_LENGTH';
      AUniVarCharLen := 'CHAR_LENGTH';
    end
    else begin
      ACharLen := 'DATA_LENGTH';
      AUniCharLen := 'DATA_LENGTH';
      AUniVarCharLen := AUniCharLen;
    end;
  end;

  procedure GetIndexExpressions(var AIndexName, AOwnerName, AToChar: String;
    const AAlias: String);
  begin
    if FConnMeta.ServerVersion >= cvOracle90000 then begin
      AIndexName := AAlias + '.INDEX_NAME';
      AOwnerName := 'NVL(' + AAlias + '.INDEX_OWNER, ' + AAlias + '.OWNER)';
      AToChar := 'TO_CHAR(';
    end
    else begin
      AIndexName := AAlias + '.CONSTRAINT_NAME';
      AOwnerName := AAlias + '.OWNER';
      AToChar := '(';
    end;
  end;

  function GetOwner: String;
  begin
    if ASchema <> '' then
      Result := QuotedStr(ASchema)
    else
      Result := sUserFunc;
  end;

begin
  if FUseDBAViews then
    sViewPrefix := 'SYS.DBA'
  else
    sViewPrefix := 'SYS.ALL';
  if FConnMeta.ServerVersion < cvOracle81500 then
    sUserFunc := 'USER'
  else
    sUserFunc := 'SYS_CONTEXT(''USERENV'', ''CURRENT_SCHEMA'')';

  lWasWhere := False;
  case AKind of
  mkCatalogs:
    Result := '';
  mkSchemas:
    begin
      Result := 'SELECT TO_NUMBER(NULL) AS RECNO, TO_CHAR(NULL) AS CATALOG_NAME, ' +
        'USERNAME AS SCHEMA_NAME FROM ' + sViewPrefix + '_USERS';
      if AWildcard <> '' then
        AddWhere('USERNAME LIKE :WIL', 'WIL');
      Result := Result + ' ORDER BY 3';
    end;
  mkTables:
    begin
      sKinds := '';
      if (tkTable in ATableKinds) or (tkTempTable in ATableKinds) then
        sKinds := sKinds + '''TABLE'', ';
      if tkView in ATableKinds then
        sKinds := sKinds + '''VIEW'', ''MATERIALIZED VIEW'', ';
      if tkSynonym in ATableKinds then
        sKinds := sKinds + '''SYNONYM'', ';
      Result := 'SELECT TO_NUMBER(NULL) AS RECNO, TO_CHAR(NULL) AS CATALOG_NAME, ' +
        'OWNER AS SCHEMA_NAME, OBJECT_NAME AS TABLE_NAME, ' +
        'DECODE(TEMPORARY, ' +
            '''Y'', ' +       InttoStr(Integer(tkTempTable)) + ', ' +
          'DECODE(OBJECT_TYPE, ' +
            '''TABLE'', ' +   IntToStr(Integer(tkTable)) + ', ' +
            '''SYNONYM'', ' + IntToStr(Integer(tkSynonym)) + ', ' +
                              IntToStr(Integer(tkView)) + ')) AS TABLE_TYPE, ' +
        EncodeScope('OWNER') + ' AS TABLE_SCOPE ' +
        'FROM ' + sViewPrefix + '_OBJECTS';
      if sKinds <> '' then
        AddWhere('OBJECT_TYPE IN (' + Copy(sKinds, 1, Length(sKinds) - 2) + ')')
      else
        AddWhere('0 = 1');
      if AWildcard <> '' then
        AddWhere('OBJECT_NAME LIKE :WIL', 'WIL');
      AddTopScope('OWNER');
      if FConnMeta.ServerVersion >= cvOracle81500 then
        if not (tkTempTable in ATableKinds) then
          AddWhere('TEMPORARY = ''N''')
        else if ATableKinds = [tkTempTable] then
          AddWhere('TEMPORARY = ''Y''');
      if FConnMeta.ServerVersion >= cvOracle100000 then
        AddWhere('OBJECT_NAME NOT LIKE ''BIN$%''');
      Result := Result + ' ORDER BY 3, 4';
    end;
  mkTableFields:
    begin
      sCharLen := '';
      sUniCharLen := '';
      sUniVarCharLen := '';
      GetLengthExpressions(sCharLen, sUniCharLen, sUniVarCharLen);
      Result := 'SELECT TO_NUMBER(NULL) AS RECNO, TO_CHAR(NULL) AS CATALOG_NAME, ' +
        'OWNER AS SCHEMA_NAME, TABLE_NAME, COLUMN_NAME, ' +
        'COLUMN_ID AS COLUMN_POSITION, ' +
        EncodeDataType('DATA_TYPE') + ' AS COLUMN_DATATYPE, ' +
        'DECODE(DATA_TYPE_OWNER, NULL, DATA_TYPE, ''"'' || DATA_TYPE_OWNER || ''"."'' || DATA_TYPE || ''"'') AS COLUMN_TYPENAME, ' +
        EncodeAttrs('DATA_TYPE', 'NULLABLE', 'DEFAULT_LENGTH', 'IDENTITY_COLUMN') + ' AS COLUMN_ATTRIBUTES, ' +
        'LEAST(DATA_PRECISION, 38) AS COLUMN_PRECISION, GREATEST(DATA_SCALE, 0) AS COLUMN_SCALE, ' +
        'DECODE(DATA_TYPE, ''CHAR'', ' + sCharLen + ', ''VARCHAR'', ' + sCharLen + ', ' +
                          '''VARCHAR2'', ' + sCharLen + ', ''NCHAR'', ' + sUniCharLen + ', ' +
                          '''NCHAR VARYING'', ' + sUniVarCharLen + ', ''NVARCHAR2'', ' + sUniVarCharLen + ', ' +
                          '''RAW'', DATA_LENGTH, ''ROWID'', 18, NULL) AS COLUMN_LENGTH ' +
        'FROM ' + sViewPrefix + '_TAB_COLUMNS';
      AddWhere('OWNER = ' + GetOwner);
      AddWhere('TABLE_NAME = :OBJ', 'OBJ');
      if AWildcard <> '' then
        AddWhere('COLUMN_NAME LIKE :WIL', 'WIL');
      Result := Result + ' ORDER BY 6';
    end;
  mkIndexes:
    begin
      sIndexName := '';
      sOwnerName := '';
      sToChar := '';
      GetIndexExpressions(sIndexName, sOwnerName, sToChar, 'C');
      Result := 'SELECT TO_NUMBER(NULL) AS RECNO, TO_CHAR(NULL) AS CATALOG_NAME, ' +
        'I.OWNER AS SCHEMA_NAME, I.TABLE_NAME, I.INDEX_NAME, ';
      if FConnMeta.ServerVersion >= cvOracle81000 then
        Result := Result + sToChar + '(' +
            'SELECT C.CONSTRAINT_NAME ' +
            'FROM ' + sViewPrefix + '_CONSTRAINTS C ' +
            'WHERE ' + sOwnerName + ' = I.OWNER AND C.TABLE_NAME = I.TABLE_NAME AND ' +
                   sIndexName + ' = I.INDEX_NAME' +
          ')) AS CONSTRAINT_NAME, ' +
          'DECODE(UNIQUENESS, ' +
            '''NONUNIQUE'', ' + IntToStr(Integer(ikNonUnique)) + ', ' +
            '''UNIQUE'', ' +
              'NVL((SELECT DECODE(CONSTRAINT_TYPE, ' +
                '''P'', ' + IntToStr(Integer(ikPrimaryKey)) + ', ' +
                            IntToStr(Integer(ikUnique)) + ') ' +
                'FROM ' + sViewPrefix + '_CONSTRAINTS C ' +
                'WHERE ' + sOwnerName + ' = I.OWNER AND C.TABLE_NAME = I.TABLE_NAME AND ' +
                       sIndexName + ' = I.INDEX_NAME AND C.CONSTRAINT_TYPE = ''P''' +
              '), ' + IntToStr(Integer(ikUnique)) +
          ')) INDEX_TYPE '
      else
        Result := Result +
          'C.CONSTRAINT_NAME, ' +
          'DECODE(I.UNIQUENESS, ' +
            '''NONUNIQUE'', ' + IntToStr(Integer(ikNonUnique)) + ', ' +
            '''UNIQUE'', ' +
              'NVL(DECODE(C.CONSTRAINT_TYPE, ' +
                '''P'', ' + IntToStr(Integer(ikPrimaryKey)) + ', ' +
                            IntToStr(Integer(ikUnique)) +
              '), ' + IntToStr(Integer(ikUnique)) +
          ')) INDEX_TYPE ';
      Result := Result +
        'FROM ' + sViewPrefix + '_INDEXES I';
      if FConnMeta.ServerVersion < cvOracle81000 then
        Result := Result + ', ' + sViewPrefix + '_CONSTRAINTS C';
      AddWhere('I.TABLE_OWNER = ' + GetOwner);
      AddWhere('I.TABLE_NAME = :OBJ', 'OBJ');
      if FConnMeta.ServerVersion < cvOracle81000 then begin
        AddWhere('I.OWNER = C.OWNER (+)');
        AddWhere('I.INDEX_NAME = C.CONSTRAINT_NAME (+)');
      end;
      AddWhere('I.INDEX_TYPE <> ''LOB''');
      if AWildcard <> '' then
        AddWhere('I.INDEX_NAME LIKE :WIL', 'WIL');
      Result := Result + ' ORDER BY 7 DESC, 5 ASC';
    end;
  mkIndexFields:
    begin
      Result := 'SELECT TO_NUMBER(NULL) AS RECNO, TO_CHAR(NULL) AS CATALOG_NAME, ' +
        'C.INDEX_OWNER AS SCHEMA_NAME, C.TABLE_NAME, C.INDEX_NAME, ' +
        'SUBSTR(C.COLUMN_NAME, 1, 30) AS COLUMN_NAME, C.COLUMN_POSITION, ';
      if FConnMeta.ServerVersion >= cvOracle81500 then
        Result := Result + 'DECODE(C.DESCEND, ''ASC'', ''A'', ''D'') AS SORT_ORDER, '
      else
        Result := Result + '''A'' AS SORT_ORDER, ';
      Result := Result + 'TO_CHAR(NULL) AS FILTER, ';
      if FConnMeta.ServerVersion >= cvOracle81500 then
        Result := Result + 'E.COLUMN_EXPRESSION '
      else
        Result := Result + 'NULL AS COLUMN_EXPRESSION ';
      Result := Result +
        'FROM ' + sViewPrefix + '_IND_COLUMNS C';
      if FConnMeta.ServerVersion >= cvOracle81500 then
        Result := Result + ', ' + sViewPrefix + '_IND_EXPRESSIONS E';
      AddWhere('C.TABLE_OWNER = ' + GetOwner);
      AddWhere('C.TABLE_NAME = :BAS', 'BAS');
      AddWhere('C.INDEX_NAME = :OBJ', 'OBJ');
      if FConnMeta.ServerVersion >= cvOracle81500 then begin
        AddWhere('C.TABLE_OWNER = E.TABLE_OWNER (+)');
        AddWhere('C.TABLE_NAME = E.TABLE_NAME (+)');
        AddWhere('C.INDEX_OWNER = E.INDEX_OWNER (+)');
        AddWhere('C.INDEX_NAME = E.INDEX_NAME (+)');
        AddWhere('C.COLUMN_POSITION = E.COLUMN_POSITION (+)');
      end;
      if AWildcard <> '' then
        AddWhere('C.COLUMN_NAME LIKE :WIL', 'WIL');
      Result := Result + ' ORDER BY 7';
    end;
  mkPrimaryKey:
    begin
      sIndexName := '';
      sOwnerName := '';
      sToChar := '';
      GetIndexExpressions(sIndexName, sOwnerName, sToChar, 'C');
      Result := 'SELECT TO_NUMBER(NULL) AS RECNO, TO_CHAR(NULL) AS CATALOG_NAME, ' +
        sOwnerName + ' AS SCHEMA_NAME, C.TABLE_NAME, ' + sIndexName + ', C.CONSTRAINT_NAME, ' +
        IntToStr(Integer(ikPrimaryKey)) + ' AS INDEX_TYPE ' +
        'FROM ' + sViewPrefix + '_CONSTRAINTS C';
      AddWhere('C.CONSTRAINT_TYPE = ''P''');
      AddWhere(sOwnerName + ' = ' + GetOwner);
      AddWhere('C.TABLE_NAME = :OBJ', 'OBJ');
      if AWildcard <> '' then
        AddWhere('C.CONSTRAINT_NAME LIKE :WIL', 'WIL');
      Result := Result + ' ORDER BY 5';
    end;
  mkPrimaryKeyFields:
    begin
      sIndexName := '';
      sOwnerName := '';
      sToChar := '';
      GetIndexExpressions(sIndexName, sOwnerName, sToChar, 'C');
      Result := 'SELECT TO_NUMBER(NULL) AS RECNO, TO_CHAR(NULL) AS CATALOG_NAME, ' +
        'INDEX_OWNER AS SCHEMA_NAME, TABLE_NAME, INDEX_NAME, SUBSTR(COLUMN_NAME, 1, 30) AS COLUMN_NAME, ' +
        'COLUMN_POSITION, ';
      if FConnMeta.ServerVersion >= cvOracle81500 then
        Result := Result + 'DECODE(DESCEND, ''ASC'', ''A'', ''D'') AS SORT_ORDER, '
      else
        Result := Result + '''A'' AS SORT_ORDER, ';
      Result := Result +
        'TO_CHAR(NULL) AS FILTER ' +
        'FROM ' + sViewPrefix + '_IND_COLUMNS ' +
        'WHERE (INDEX_OWNER, INDEX_NAME, TABLE_OWNER, TABLE_NAME) = (' +
          'SELECT ' + sOwnerName + ', ' + sIndexName + ', ' + sOwnerName + ', C.TABLE_NAME ' +
          'FROM ' + sViewPrefix + '_CONSTRAINTS C';
      AddWhere('C.CONSTRAINT_TYPE = ''P''');
      AddWhere(sOwnerName + ' = ' + GetOwner);
      AddWhere('C.TABLE_NAME = :BAS)', 'BAS');
      if AWildcard <> '' then begin
        lWasWhere := False;
        AddWhere('COLUMN_NAME LIKE :WIL', 'WIL');
      end;
      Result := Result + ' ORDER BY 7';
    end;
  mkForeignKeys:
    begin
      sIndexName := '';
      sOwnerName := '';
      sToChar := '';
      GetIndexExpressions(sIndexName, sOwnerName, sToChar, 'C');
      sIndexName2 := '';
      sOwnerName2 := '';
      sToChar2 := '';
      GetIndexExpressions(sIndexName2, sOwnerName2, sToChar2, 'C2');
      Result := 'SELECT TO_NUMBER(NULL) AS RECNO, TO_CHAR(NULL) AS CATALOG_NAME, ' +
        sOwnerName + ' AS SCHEMA_NAME, C.TABLE_NAME, C.CONSTRAINT_NAME AS FKEY_NAME, ' +
        'TO_CHAR(NULL) AS PKEY_CATALOG_NAME, ' + sOwnerName2 + ' AS PKEY_SCHEMA_NAME, ' +
        'C2.TABLE_NAME AS PKEY_TABLE_NAME, '+
        'DECODE(C.DELETE_RULE, ''CASCADE'', ' + IntToStr(Integer(ckCascade)) +
          ', ''SET NULL'', ' + IntToStr(Integer(ckSetNull)) + ', ' + IntToStr(Integer(ckRestrict)) +
          ') AS DELETE_RULE, ' + IntToStr(Integer(ckRestrict)) + ' AS UPDATE_RULE ' +
        'FROM ' + sViewPrefix + '_CONSTRAINTS C, ' + sViewPrefix + '_CONSTRAINTS C2';
      AddWhere('C.R_OWNER = C2.OWNER');
      AddWhere('C.R_CONSTRAINT_NAME = C2.CONSTRAINT_NAME');
      AddWhere('C.CONSTRAINT_TYPE = ''R''');
      AddWhere('C.OWNER = ' + GetOwner);
      AddWhere('C.TABLE_NAME = :OBJ', 'OBJ');
      if AWildcard <> '' then
        AddWhere('C.CONSTRAINT_NAME LIKE :WIL', 'WIL');
      Result := Result + ' ORDER BY 5';
    end;
  mkForeignKeyFields:
    begin
      sIndexName := '';
      sOwnerName := '';
      sToChar := '';
      GetIndexExpressions(sIndexName, sOwnerName, sToChar, 'C');
      sIndexName2 := '';
      sOwnerName2 := '';
      sToChar2 := '';
      GetIndexExpressions(sIndexName2, sOwnerName2, sToChar2, 'C2');
      Result := 'SELECT TO_NUMBER(NULL) AS RECNO, TO_CHAR(NULL) AS CATALOG_NAME, ' +
        sOwnerName + ' AS SCHEMA_NAME, C.TABLE_NAME, C.CONSTRAINT_NAME AS FKEY_NAME, '+
        'L.COLUMN_NAME, L2.COLUMN_NAME AS PKEY_COLUMN_NAME, NVL(L.POSITION, 1) AS COLUMN_POSITION ' +
        'FROM ' + sViewPrefix + '_CONSTRAINTS C, ' + sViewPrefix + '_CONSTRAINTS C2, ' +
          sViewPrefix + '_CONS_COLUMNS L, ' + sViewPrefix + '_CONS_COLUMNS L2';
      AddWhere('C.R_OWNER = C2.OWNER');
      AddWhere('C.R_CONSTRAINT_NAME = C2.CONSTRAINT_NAME');
      AddWhere('C.CONSTRAINT_TYPE = ''R''');
      AddWhere('C.OWNER = L.OWNER');
      AddWhere('C.TABLE_NAME = L.TABLE_NAME');
      AddWhere('C.CONSTRAINT_NAME = L.CONSTRAINT_NAME');
      AddWhere('C2.OWNER = L2.OWNER');
      AddWhere('C2.TABLE_NAME = L2.TABLE_NAME');
      AddWhere('C2.CONSTRAINT_NAME = L2.CONSTRAINT_NAME');
      AddWhere('NVL(L.POSITION, 1) = NVL(L2.POSITION, 1)');
      AddWhere(sOwnerName + ' = ' + GetOwner);
      AddWhere('C.TABLE_NAME = :BAS', 'BAS');
      AddWhere('C.CONSTRAINT_NAME = :OBJ', 'OBJ');
      if AWildcard <> '' then
        AddWhere('C.COLUMN_NAME LIKE :WIL', 'WIL');
      Result := Result + ' ORDER BY 8';
    end;
  mkPackages:
    begin
      Result := 'SELECT TO_NUMBER(NULL) AS RECNO, TO_CHAR(NULL) AS CATALOG_NAME, ' +
        'OWNER AS SCHEMA_NAME, OBJECT_NAME AS PACKAGE_NAME, ' +
        EncodeScope('OWNER') + ' AS PACKAGE_SCOPE ' +
        'FROM ' + sViewPrefix + '_OBJECTS';
      AddWhere('OBJECT_TYPE = ''PACKAGE''');
      AddTopScope('OWNER');
      if AWildcard <> '' then
        AddWhere('OBJECT_NAME LIKE :WIL', 'WIL');
      Result := Result + ' ORDER BY 3, 4';
    end;
  mkProcs:
    begin
      if ABaseObject = '' then begin
        Result := 'SELECT TO_NUMBER(NULL) AS RECNO, TO_CHAR(NULL) AS CATALOG_NAME, ' +
          'OWNER AS SCHEMA_NAME, TO_CHAR(NULL) AS PACK_NAME, OBJECT_NAME AS PROC_NAME, ' +
          'TO_NUMBER(NULL) AS OVERLOAD, DECODE(OBJECT_TYPE, ' +
            '''FUNCTION'', ' + IntToStr(Integer(pkFunction)) + ', ' +
            '''PROCEDURE'', ' + IntToStr(Integer(pkProcedure)) + ') AS PROC_TYPE, ' +
          EncodeScope('OWNER') + ' AS PROC_SCOPE, TO_NUMBER(NULL) AS IN_PARAMS, ' +
          'TO_NUMBER(NULL) AS OUT_PARAMS ' +
          'FROM ' + sViewPrefix + '_OBJECTS';
        AddWhere('OBJECT_TYPE IN (''PROCEDURE'', ''FUNCTION'')');
        AddTopScope('OWNER');
        if AWildcard <> '' then
          AddWhere('OBJECT_NAME LIKE :WIL', 'WIL');
        Result := Result + ' ORDER BY 3, 5';
      end
      else begin
        Result := 'SELECT TO_NUMBER(NULL) AS RECNO, TO_CHAR(NULL) AS CATALOG_NAME, A.* ' +
          'FROM ( ' +
            'SELECT OWNER AS SCHEMA_NAME, PACKAGE_NAME AS PACK_NAME, OBJECT_NAME AS PROC_NAME, ' +
              'TO_NUMBER(OVERLOAD) AS OVERLOAD, DECODE(COUNT(DECODE(ARGUMENT_NAME, NULL, 1, NULL)), ' +
                '1, ' + IntToStr(Integer(pkFunction)) + ', ' +
                        IntToStr(Integer(pkProcedure)) + ') AS PROC_TYPE, ' +
              EncodeScope('OWNER') + ' AS PROC_SCOPE, ' +
              'COUNT(DECODE(IN_OUT, ''IN'', DECODE(DATA_TYPE, NULL, NULL, 1), ''IN/OUT'', 1, NULL)) AS IN_PARAMS, ' +
              'COUNT(DECODE(IN_OUT, ''OUT'', 1, ''IN/OUT'', 1, NULL)) AS OUT_PARAMS ' +
            'FROM ALL_ARGUMENTS';
        AddWhere('PACKAGE_NAME = :BAS', 'BAS');
        AddWhere('OWNER = ' + GetOwner);
        if AWildcard <> '' then
          AddWhere('OBJECT_NAME LIKE :WIL', 'WIL');
        AddWhere('DATA_LEVEL = 0');
        Result := Result +
            ' GROUP BY OWNER, PACKAGE_NAME, OBJECT_NAME, OVERLOAD ' +
          ') A ORDER BY 3, 4, 5, 6';
      end;
    end;
  mkProcArgs:
    begin
      sCharLen := '';
      sUniCharLen := '';
      sUniVarCharLen := '';
      GetLengthExpressions(sCharLen, sUniCharLen, sUniVarCharLen);
      Result := 'SELECT TO_NUMBER(NULL) AS RECNO, TO_CHAR(NULL) AS CATALOG_NAME, ' +
        'OWNER AS SCHEMA_NAME, PACKAGE_NAME AS PACK_NAME, ' +
        'OBJECT_NAME AS PROC_NAME, OVERLOAD, NVL(ARGUMENT_NAME, ''Result'') AS PARAM_NAME, ' +
        'POSITION AS PARAM_POSITION, ' +
        'DECODE(IN_OUT, ''IN'', 1, ''IN/OUT'', 3, ''OUT'', DECODE(ARGUMENT_NAME, NULL, 4, 2)) AS PARAM_TYPE, ' +
        EncodeDataType('DATA_TYPE') + ' AS PARAM_DATATYPE, ' +
        'DECODE(DATA_TYPE, ''UNDEFINED'', ''"'' || TYPE_OWNER || ''"."'' || TYPE_NAME || ' +
          'DECODE(TYPE_SUBNAME, NULL, '''', ''."'' || TYPE_SUBNAME || ''"''), DATA_TYPE) AS PARAM_TYPENAME, ' +
        EncodeAttrs('DATA_TYPE', '', '', '') + ' AS PARAM_ATTRIBUTES, ' +
        'LEAST(DATA_PRECISION, 38) AS PARAM_PRECISION, GREATEST(DATA_SCALE, 0) AS PARAM_SCALE, ' +
        'DECODE(DATA_TYPE, ''CHAR'', ' + sCharLen + ', ''VARCHAR'', ' + sCharLen + ', ' +
                          '''VARCHAR2'', ' + sCharLen + ', ''NCHAR'', ' + sUniCharLen + ', ' +
                          '''NCHAR VARYING'', ' + sUniVarCharLen + ', ''NVARCHAR2'', ' + sUniVarCharLen + ', ' +
                          '''RAW'', DATA_LENGTH, ''ROWID'', 18, NULL) AS PARAM_LENGTH ' +
        'FROM ALL_ARGUMENTS';
      if ABaseObject <> '' then
        AddWhere('PACKAGE_NAME = :BAS', 'BAS')
      else
        AddWhere('PACKAGE_NAME IS NULL');
      AddWhere('OWNER = ' + GetOwner);
      AddWhere('OBJECT_NAME = :OBJ', 'OBJ');
      if AWildcard <> '' then
        AddWhere('ARGUMENT_NAME LIKE :WIL', 'WIL');
      if AOverload <> 0 then begin
        AddWhere('OVERLOAD = :OVE', 'OVE');
        oPar := GetParams[GetParams.Count - 1];
        oPar.DataType := ftInteger;
        oPar.Size := 0;
      end
      else
        AddWhere('OVERLOAD IS NULL');
      AddWhere('DATA_LEVEL = 0');
      AddWhere('DATA_TYPE IS NOT NULL');
      Result := Result + ' ORDER BY 8';
    end;
  mkGenerators:
    begin
      Result := 'SELECT TO_NUMBER(NULL) AS RECNO, TO_CHAR(NULL) AS CATALOG_NAME, ' +
        'SEQUENCE_OWNER AS SCHEMA_NAME, SEQUENCE_NAME AS GENERATOR_NAME, ' +
        EncodeScope('SEQUENCE_OWNER') + ' AS GENERATOR_SCOPE ' +
        'FROM ' + sViewPrefix + '_SEQUENCES';
      if AWildcard <> '' then
        AddWhere('SEQUENCE_NAME LIKE :WIL', 'WIL');
      AddTopScope('SEQUENCE_OWNER');
      Result := Result + ' ORDER BY 3, 4';
    end;
  mkResultSetFields,
  mkTableTypeFields:
    Result := '';
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraCommandGenerator.GetLimitSelect(const ASQL: String;
  ASkip, ARows: Integer): String;
var
  sSQL: String;
begin
  sSQL := UpperCase(ASQL);
  // Without that ORA-2287 (Sequence number is not allowed here) will be raised
  // on fetching a generator from the DApt manager.
  if (Pos('NEXTVAL', sSQL) = 0) and (Pos('CURRVAL', sSQL) = 0) then
    if (ASkip > 0) and (ARows + ASkip <> MAXINT) then
      Result := 'SELECT T.* FROM (SELECT T.*, ROWNUM ' + C_FD_SysColumnPrefix +
        'rn FROM (' + ASQL + ') T WHERE ROWNUM <= ' + IntToStr(ASkip + ARows) +
        ') T WHERE T.' + C_FD_SysColumnPrefix + 'rn > ' + IntToStr(ASkip)
    else if ASkip > 0 then
      Result := 'SELECT T.* FROM (SELECT T.*, ROWNUM ' + C_FD_SysColumnPrefix +
        'rn FROM (' + ASQL + ') T) T WHERE T.' + C_FD_SysColumnPrefix + 'rn > ' +
        IntToStr(ASkip)
    else if ARows >= 0 then
      Result := 'SELECT * FROM (' + BRK + ASQL + BRK + ') WHERE ROWNUM <= ' +
        IntToStr(ARows)
    else
      Result := ASQL
  else
    Result := ASQL;
end;

{-------------------------------------------------------------------------------}
// http://docs.oracle.com/cd/B28359_01/server.111/b28318/datatype.htm
function TFDPhysOraCommandGenerator.GetColumnType(AColumn: TFDDatSColumn): String;
var
  eAttrs: TFDDataAttributes;
begin
  eAttrs := AColumn.ActualAttributes;
  if caROWID in eAttrs then begin
    Result := 'ROWID';
    Exit;
  end;
  case AColumn.DataType of
  dtBoolean:
    Result := 'NUMBER(1, 0)';
  dtSByte:
    Result := 'NUMBER(3, 0)';
  dtInt16:
    Result := 'NUMBER(5, 0)';
  dtInt32:
    Result := 'NUMBER(10, 0)';
  dtInt64:
    Result := 'NUMBER(19, 0)';
  dtByte:
    Result := 'NUMBER(3, 0)';
  dtUInt16:
    Result := 'NUMBER(5, 0)';
  dtUInt32:
    Result := 'NUMBER(10, 0)';
  dtUInt64:
    Result := 'NUMBER(20, 0)';
  dtSingle:
    if FConnMeta.ServerVersion < cvOracle100000 then
      Result := 'NUMBER(*, 8)'
    else
      Result := 'BINARY_FLOAT';
  dtDouble,
  dtExtended:
    if FConnMeta.ServerVersion < cvOracle100000 then
      Result := 'NUMBER(*, 16)'
    else
      Result := 'BINARY_DOUBLE';
  dtCurrency:
    Result := 'NUMBER' + GetColumnDim(-1, AColumn.Precision, AColumn.Scale, -1, 18, 4);
  dtBCD,
  dtFmtBCD:
    Result := 'NUMBER' + GetColumnDim(-1, AColumn.Precision, AColumn.Scale, -1,
      FOptions.FormatOptions.MaxBcdPrecision, FOptions.FormatOptions.MaxBcdScale);
  dtDateTime,
  dtTime,
  dtDate:
    Result := 'DATE';
  dtDateTimeStamp:
    Result := 'TIMESTAMP';
  dtTimeIntervalYM:
    Result := 'INTERVAL YEAR TO MONTH';
  dtTimeIntervalFull,
  dtTimeIntervalDS:
    Result := 'INTERVAL DAY TO SECOND';
  dtAnsiString:
    begin
      if (caFixedLen in AColumn.ActualAttributes) and (AColumn.Size <= 2000) then
        Result := 'CHAR'
      else
        Result := 'VARCHAR';
      Result := Result + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1);
    end;
  dtWideString:
    begin
      if (caFixedLen in AColumn.ActualAttributes) and (AColumn.Size <= 2000) then
        Result := 'NCHAR'
      else
        Result := 'NVARCHAR';
      Result := Result + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1);
    end;
  dtByteString:
    Result := 'RAW';
  dtBlob:
    Result := 'LONG RAW';
  dtMemo:
    Result := 'LONG';
  dtWideMemo:
    Result := 'NCLOB';
  dtXML:
    Result := 'XML';
  dtHBlob:
    Result := 'BLOB';
  dtHMemo:
    Result := 'CBLOB';
  dtWideHMemo:
    Result := 'NCBLOB';
  dtHBFile:
    Result := 'BLOB';
  dtGUID:
    Result := 'CHAR(38)';
  dtUnknown,
  dtRowSetRef,
  dtCursorRef,
  dtRowRef,
  dtArrayRef,
  dtParentRowRef,
  dtObject:
    Result := '';
  end;
  if Result <> '' then
    if caAutoInc in AColumn.ActualAttributes then
      if FConnMeta.ServerVersion >= cvOracle120000 then
        Result := Result + ' GENERATED BY DEFAULT AS IDENTITY'
      else
        FFlags := FFlags + [gfCreateIdentityTrigger, gfCreateIdentityGenerator]
    else if caExpr in AColumn.ActualAttributes then
      if FConnMeta.ServerVersion >= cvOracle110000 then
        Result := Result + ' GENERATED ALWAYS AS (' + AColumn.Expression + ') VIRTUAL';
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraCommandGenerator.GetCreateGenerator(const AName: String): String;
var
  rName: TFDPhysParsedName;
begin
  rName.FCatalog := '';
  rName.FSchema := '';
  rName.FBaseObject := '';
  rName.FObject := AName;
  Result := 'CREATE SEQUENCE ' + FConnMeta.EncodeObjName(rName, nil, [eoQuote, eoNormalize]);
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraCommandGenerator.GetDropGenerator(const AName: String): String;
var
  rName: TFDPhysParsedName;
begin
  rName.FCatalog := '';
  rName.FSchema := '';
  rName.FBaseObject := '';
  rName.FObject := AName;
  Result := 'DROP SEQUENCE ' + FConnMeta.EncodeObjName(rName, nil, [eoQuote, eoNormalize]);
end;

{-------------------------------------------------------------------------------}
function TFDPhysOraCommandGenerator.GetCreateIdentityTrigger: String;
var
  i: Integer;
  oCols: TFDDatSColumnList;
  oCol: TFDDatSColumn;
  sGen, sCol, sTab: String;
  rName: TFDPhysParsedName;
begin
  oCols := FTable.Columns;
  for i := 0 to oCols.Count - 1 do begin
    oCol := oCols[i];
    if ColumnStorable(oCol) and (caAutoInc in oCol.ActualAttributes) then begin
      sGen := ColumnGenerator(oCol);
      if sGen <> '' then begin
        rName.FCatalog := '';
        rName.FSchema := '';
        rName.FBaseObject := '';
        rName.FObject := sGen;
        sGen := FConnMeta.EncodeObjName(rName, nil, [eoQuote, eoNormalize]);
        sCol := GetColumn('', -1, oCol);
        Result := IND + 'IF :NEW.' + sCol + ' IS NULL THEN' + BRK +
                  IND + IND + 'SELECT ' + sGen + '.NEXTVAL INTO :NEW.' + sCol + ' FROM SYS.DUAL;' + BRK +
                  IND + 'END IF;' + BRK;
      end;
    end;
  end;
  if Result <> '' then begin
    sTab := GetFrom;
    FConnMeta.DecodeObjName(sTab, rName, nil, [doUnquote]);
    rName.FObject := 'TR_' + rName.FObject + '_BI';
    Result := 'CREATE TRIGGER ' + FConnMeta.EncodeObjName(rName, nil, [eoQuote, eoNormalize]) + BRK +
      'BEFORE INSERT ON ' + sTab + ' FOR EACH ROW ' + BRK +
      'BEGIN' + BRK +
      Result +
      'END;' + BRK;
  end;
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterRDBMSKind(TFDRDBMSKinds.Oracle, S_FD_Ora_RDBMS);

end.
