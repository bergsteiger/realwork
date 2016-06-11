{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{          FireDAC InterBase/Firebird metadata          }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.IBMeta;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Consts, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.Meta, FireDAC.Phys.SQLGenerator;

const
  csIDNone = 0;
  csIDOctets = 1;
  csIDUnicodeFSS = 3;
  csIDFBUtf8 = 4;
  csIDUnicodeBE = 8;
  csIDIBUtf8 = 59;
  csIDUnicodeLE = 64;

type
  TFDPhysIBBrand = (ibInterbase, ibFirebird, ibYaffil);

  IFDPhysIBConnectionMetadata = interface (IUnknown)
    ['{898D228C-56E3-4D34-9AA4-B1DC613CE57A}']
    // private
    function GetBrand: TFDPhysIBBrand;
    function GetDialect: Integer;
    // public
    property Brand: TFDPhysIBBrand read GetBrand;
    property Dialect: Integer read GetDialect;
  end;

  TFDPhysIBMetadata = class (TFDPhysConnectionMetadata, IFDPhysIBConnectionMetadata)
  private
    FBrand: TFDPhysIBBrand;
    FDialect: Integer;
  protected
    // IFDPhysConnectionMetadata
    function GetKind: TFDRDBMSKind; override;
    function GetTxMultiple: Boolean; override;
    function GetTxSavepoints: Boolean; override;
    function GetEventSupported: Boolean; override;
    function GetEventKinds: String; override;
    function GetGeneratorSupported: Boolean; override;
    function GetTruncateSupported: Boolean; override;
    function GetIdentitySupported: Boolean; override;
    function GetIdentityInsertSupported: Boolean; override;
    function GetParamNameMaxLength: Integer; override;
    function GetNameParts: TFDPhysNameParts; override;
    function GetNameQuotedCaseSensParts: TFDPhysNameParts; override;
    function GetNameCaseSensParts: TFDPhysNameParts; override;
    function GetNameDefLowCaseParts: TFDPhysNameParts; override;
    function GetNameQuoteChar(AQuote: TFDPhysNameQuoteLevel; ASide: TFDPhysNameQuoteSide): Char; override;
    function GetInlineRefresh: Boolean; override;
    function GetSelectOptions: TFDPhysSelectOptions; override;
    function GetAsyncAbortSupported: Boolean; override;
    function GetLineSeparator: TFDTextEndOfLine; override;
    function GetLockNoWait: Boolean; override;
    function GetDefValuesSupported: TFDPhysDefaultValues; override;
    function GetArrayExecMode: TFDPhysArrayExecMode; override;
    function GetLimitOptions: TFDPhysLimitOptions; override;
    function GetNullLocations: TFDPhysNullLocations; override;
    procedure DefineMetadataStructure(ATable: TFDDatSTable; AKind: TFDPhysMetaInfoKind); override;
    function GetResultSetFields(const ASQLKey: String): TFDDatSView; override;
    function InternalEscapeBoolean(const AStr: String): String; override;
    function InternalEscapeDate(const AStr: String): String; override;
    function InternalEscapeDateTime(const AStr: String): String; override;
    function InternalEscapeFloat(const AStr: String): String; override;
    function InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String; override;
    function InternalEscapeTime(const AStr: String): String; override;
    function InternalGetSQLCommandKind(const ATokens: TStrings): TFDPhysCommandKind; override;
    // IFDPhysIBConnectionMetadata
    function GetBrand: TFDPhysIBBrand;
    function GetDialect: Integer;
  public
    constructor Create(const AConnection: TFDPhysConnection;
      ABrand: TFDPhysIBBrand; AServerVersion, AClientVersion: TFDVersion;
      ADialect: Integer; AIsUnicode: Boolean);
  end;

  TFDPhysIBCommandGenerator = class(TFDPhysCommandGenerator)
  private
    FIDUTF8: Integer;
    FEncoding: TFDEncoding;
  protected
    function GetInlineRefresh(const AStmt: String;
      ARequest: TFDUpdateRequest): String; override;
    function GetPessimisticLock: String; override;
    function GetSavepoint(const AName: String): String; override;
    function GetRollbackToSavepoint(const AName: String): String; override;
    function GetCommitSavepoint(const AName: String): String; override;
    function GetReadGenerator(const AName, AAlias: String;
      ANextValue, AFullSelect: Boolean): String; override;
    function GetSingleRowTable: String; override;
    function GetRowId(var AAlias: String): String; override;
    function GetCall(const AName: String): String; override;
    function GetStoredProcCall(const ACatalog, ASchema, APackage, AProc: String;
      ASPUsage: TFDPhysCommandKind): String; override;
    function GetSelectMetaInfo(AKind: TFDPhysMetaInfoKind;
      const ACatalog, ASchema, ABaseObject, AObject, AWildcard: String;
      AObjectScopes: TFDPhysObjectScopes; ATableKinds: TFDPhysTableKinds;
      AOverload: Word): String; override;
    function GetLimitSelect(const ASQL: String; ASkip, ARows: Integer): String; override;
    function GetCountSelect(const ASQL: String): String; override;
    function GetColumnType(AColumn: TFDDatSColumn): String; override;
    function GetCreateGenerator(const AName: String): String; override;
    function GetDropGenerator(const AName: String): String; override;
    function GetCreateIdentityTrigger: String; override;
    function GetMerge(AAction: TFDPhysMergeAction): String; override;
  public
    constructor Create(const ACommand: IFDPhysCommand; AIDUTF8: Integer;
      AEncoding: TFDEncoding); overload;
    constructor Create(const AConnection: IFDPhysConnection; AIDUTF8: Integer;
      AEncoding: TFDEncoding);  overload;
  end;

implementation

uses
  System.SysUtils, Data.DB,
  FireDAC.Stan.Util, FireDAC.Stan.Param, FireDAC.Stan.Error;

{-------------------------------------------------------------------------------}
{ TFDPhysIBMetadata                                                             }
{-------------------------------------------------------------------------------}
constructor TFDPhysIBMetadata.Create(const AConnection: TFDPhysConnection;
  ABrand: TFDPhysIBBrand; AServerVersion, AClientVersion: TFDVersion;
  ADialect: Integer; AIsUnicode: Boolean);
var
  sKwds: String;
begin
  inherited Create(AConnection, AServerVersion, AClientVersion, AIsUnicode);
  FBrand := ABrand;
  FDialect := ADialect;
  // IB 2007
  sKwds :=
    'ACTION,ACTIVE,ADD,ADMIN,' +
    'AFTER,ALL,ALTER,AND,' +
    'ANY,AS,ASC,ASCENDING,' +
    'AT,AUTO,AUTODDL,AVG,' +
    'BASED,BASENAME,BASE_NAME,BEFORE,' +
    'BEGIN,BETWEEN,BLOB,BLOBEDIT,' +
    'BOOLEAN,BUFFER,BY,CACHE,' +
    'CASCADE,CAST,CHAR,CHARACTER,' +
    'CHARACTER_LENGTH,CHAR_LENGTH,CHECK,CHECK_POINT_LEN,' +
    'CHECK_POINT_LENGTH,COLLATE,COLLATION,COLUMN,' +
    'COMMIT,COMMITTED,COMPILETIME,COMPUTED,' +
    'CLOSE,CONDITIONAL,CONNECT,CONSTRAINT,' +
    'CONTAINING,CONTINUE,COUNT,CREATE,' +
    'CSTRING,CURRENT,CURRENT_DATE,CURRENT_TIME,' +
    'CURRENT_TIMESTAMP,CURSOR,DATABASE,DATE,' +
    'DAY,DEBUG,DEC,' +
    'DECIMAL,DECLARE,DEFAULT,DELETE,' +
    'DESC,DESCENDING,DESCRIBE,DESCRIPTOR,' +
    'DISCONNECT,DISPLAY,DISTINCT,DO,' +
    'DOMAIN,DOUBLE,DROP,ECHO,' +
    'EDIT,ELSE,END,ENTRY_POINT,' +
    'ESCAPE,EVENT,EXCEPTION,EXECUTE,' +
    'EXISTS,EXIT,EXTERN,EXTERNAL,' +
    'EXTRACT,FALSE,FETCH,FILE,' +
    'FILTER,FLOAT,FOR,FOREIGN,' +
    'FOUND,FREE_IT,FROM,FULL,' +
    'FUNCTION,GDSCODE,GENERATOR,GEN_ID,' +
    'GLOBAL,GOTO,GRANT,GROUP,' +
    'GROUP_COMMIT_WAIT,GROUP_COMMIT_WAIT_TIME,HAVING,HELP,' +
    'HOUR,IF,IMMEDIATE,IN,' +
    'INACTIVE,INDEX,INDICATOR,INIT,' +
    'INNER,INPUT,INPUT_TYPE,INSERT,' +
    'INT,INTEGER,INTO,IS,' +
    'ISOLATION,ISQL,JOIN,KEY,' +
    'LC_MESSAGES,LC_TYPE,LEFT,LENGTH,' +
    'LEV,LEVEL,LIKE,LOGFILE,' +
    'LOG_BUFFER_SIZE,LOG_BUF_SIZE,LONG,MANUAL,' +
    'MAX,MAXIMUM,MAXIMUM_SEGMENT,MAX_SEGMENT,' +
    'MERGE,MESSAGE,MIN,MINIMUM,' +
    'MINUTE,MODULE_NAME,MONTH,NAMES,' +
    'NATIONAL,NATURAL,NCHAR,NO,' +
    'NOAUTO,NOT,NULL,NUMERIC,' +
    'NUM_LOG_BUFS,NUM_LOG_BUFFERS,OCTET_LENGTH,OF,' +
    'ON,ONLY,OPEN,OPTION,' +
    'OR,ORDER,OUTER,OUTPUT,' +
    'OUTPUT_TYPE,OVERFLOW,PAGE,PAGELENGTH,' +
    'PAGES,PAGE_SIZE,PARAMETER,PASSWORD,' +
    'PERCENT,PLAN,POSITION,POST_EVENT,' +
    'PRECISION,PREPARE,PRESERVE,PROCEDURE,' +
    'PROTECTED,PRIMARY,PRIVILEGES,PUBLIC,' +
    'QUIT,RAW_PARTITIONS,READ,' +
    'REAL,RECORD_VERSION,REFERENCES,RELEASE,' +
    'RESERV,RESERVING,RESTRICT,RETAIN,' +
    'RETURN,RETURNING_VALUES,RETURNS,REVOKE,' +
    'RIGHT,ROLE,ROLLBACK,ROWS,' +
    'RUNTIME,SCHEMA,SECOND,SEGMENT,' +
    'SELECT,SET,SHADOW,SHARED,' +
    'SHELL,SHOW,SINGULAR,SIZE,' +
    'SMALLINT,SNAPSHOT,SOME,SORT,' +
    'SQLCODE,SQLERROR,SQLWARNING,STABILITY,' +
    'STARTING,STARTS,STATEMENT,STATIC,' +
    'STATISTICS,SUB_TYPE,SUM,SUSPEND,' +
    'TABLE,TEMPORARY,TERMINATOR,THEN,' +
    'TIES,TIME,TIMESTAMP,TO,' +
    'TRANSACTION,TRANSLATE,TRANSLATION,TRIGGER,' +
    'TRIM,TRUE,TYPE,UNCOMMITTED,' +
    'UNION,UNIQUE,UNKNOWN,UPDATE,' +
    'UPPER,USER,USING,VALUE,' +
    'VALUES,VARCHAR,VARIABLE,VARYING,' +
    'VERSION,VIEW,WAIT,WEEKDAY,' +
    'WHEN,WHENEVER,WHERE,WHILE,' +
    'WITH,WORK,WRITE,YEAR,' +
    'WEEKDAY,YEARDAY';
  if FBrand = ibFirebird then begin
    sKwds := sKwds + ',' +
      // Firebird 1.0
      'CURRENT_USER,CURRENT_ROLE,BREAK,DESCRIPTOR,FIRST,RECREATE,SKIP,' +
      'SUBSTRING,' +
      // Firebird 1.5
      'CURRENT_CONNECTION,CURRENT_TRANSACTION,BIGINT,CASE,RELEASE,' +
      'ROW_COUNT,SAVEPOINT,COALESCE,DELETING,INSERTING,LAST,LEAVE,' +
      'LOCK,NULLIF,NULLS,STATEMENT,UPDATING,USING,BREAK,DESCRIPTOR,' +
      'FIRST,SKIP,SUBSTRING,' +
      // Firebird 2.0
      'BIT_LENGTH,BOTH,CHAR_LENGTH,CHARACTER_LENGTH,CLOSE,CROSS,FETCH,' +
      'LEADING,LOWER,OCTET_LENGTH,OPEN,ROWS,TRAILING,TRIM,USING,BACKUP,' +
      'BLOCK,COLLATION,COMMENT,DIFFERENCE,IIF,NEXT,SCALAR_ARRAY,SEQUENCE,' +
      'RESTART,RETURNING,ACTION,CASCADE,FREE_IT,RESTRICT,ROLE,TYPE,' +
      'WEEKDAY,YEARDAY,BASENAME,CACHE,CHECK_POINT_LEN,GROUP_COMMIT_WAIT,' +
      'LOGFILE,LOG_BUF_SIZE,NUM_LOG_BUFS,RAW_PARTITIONS,' +
      // Firebird 2.1
      'CONNECT,DISCONNECT,GLOBAL,INSENSITIVE,RECURSIVE,SENSITIVE,START,' +
      'ABS,ACCENT,ACOS,ALWAYS,ASCII_CHAR,ASCII_VAL,ASIN,ATAN,ATAN2,BIN_AND,' +
      'BIN_OR,BIN_SHL,BIN_SHR,BIN_XOR,CEIL,CEILING,COS,COSH,COT,DATEADD,' +
      'DATEDIFF,DECODE,EXP,FLOOR,GEN_UUID,GENERATED,HASH,LIST,LN,LOG,LOG10,' +
      'LPAD,MATCHED,MATCHING,MAXVALUE,MILLISECOND,MINVALUE,MOD,OVERLAY,PFD,' +
      'PI,PLACING,POWER,PRESERVE,RAND,REPLACE,REVERSE,ROUND,RPAD,SIGN,SIN,' +
      'SINH,SPACE,SQRT,TAN,TANH,TEMPORARY,TRUNC,WEEK,' +
      // Firebird 2.5
      'SIMILAR,AUTONOMOUS,BIN_NOT,CALLER,CHAR_TO_UUID,COMMON,DATA,FIRSTNAME,' +
      'GRANTED,LASTNAME,MIDDLENAME,MAPPING,OS_NAME,SOURCE,TWO_PHASE,UUID_TO_CHAR';
  end;
  FKeywords.CommaText := sKwds;
  ConfigQuoteChars;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetKind: TFDRDBMSKind;
begin
  if FBrand = ibFirebird then
    Result := TFDRDBMSKinds.Firebird
  else
    Result := TFDRDBMSKinds.Interbase;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetNameCaseSensParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetNameDefLowCaseParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetParamNameMaxLength: Integer;
begin
  Result := 256;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetNameParts: TFDPhysNameParts;
begin
  Result := [npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetNameQuotedCaseSensParts: TFDPhysNameParts;
begin
  if FDialect >= 3 then
    Result := [npBaseObject, npObject]
  else
    Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetNameQuoteChar(AQuote: TFDPhysNameQuoteLevel;
  ASide: TFDPhysNameQuoteSide): Char;
begin
  if (FDialect >= 3) and (AQuote = ncDefault) then
    Result := '"'
  else
    Result := #0;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetTxMultiple: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetTxSavepoints: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetEventSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetEventKinds: String;
begin
  Result := S_FD_EventKind_IB_Events;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetGeneratorSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetTruncateSupported: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetIdentitySupported: Boolean;
begin
  Result := (FBrand = ibFirebird) and
    (FConnectionObj.ConnectionDef.AsBoolean[S_FD_ConnParam_Common_ExtendedMetadata] or
     (GetServerVersion >= ivFB030000));
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetIdentityInsertSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetInlineRefresh: Boolean;
begin
  Result := (FBrand = ibFirebird) and (GetServerVersion >= ivFB020100);
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetSelectOptions: TFDPhysSelectOptions;
begin
  if (FBrand = ibFirebird) or
     (FBrand = ibInterbase) and (GetServerVersion >= ivIB120100) then
    Result := [soInlineView]
  else
    Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetLockNoWait: Boolean;
begin
  Result := True;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysIBMetadata.GetAsyncAbortSupported: Boolean;
begin
  Result :=
    (FBrand = ibInterbase) and (GetServerVersion >= ivIB070000) or
    (FBrand = ibFirebird) and (GetServerVersion >= ivFB020500);
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetLineSeparator: TFDTextEndOfLine;
begin
  Result := elPosix;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetDefValuesSupported: TFDPhysDefaultValues;
begin
  if (FBrand = ibFirebird) and (GetServerVersion >= ivFB020100) then
    Result := dvDefVals
  else
    Result := dvNone;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetArrayExecMode: TFDPhysArrayExecMode;
begin
  if (FBrand = ibFirebird) and (GetServerVersion >= ivFB020100) then
    Result := aeOnErrorUndoAll
  else
    Result := aeUpToFirstError;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetLimitOptions: TFDPhysLimitOptions;
begin
  if (FBrand in [ibFirebird, ibYaffil]) and (GetServerVersion >= ivFB020000) or
     (FBrand = ibInterbase) then
    Result := [loSkip, loRows]
  else
    Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetNullLocations: TFDPhysNullLocations;
begin
  case FBrand of
  ibYaffil:
    Result := [nlAscLast, nlDescLast];
  ibFirebird:
    if GetServerVersion < ivFB020000 then
      Result := [nlAscLast, nlDescLast]
    else
      Result := [nlAscFirst, nlDescLast];
  ibInterbase:
    if GetServerVersion < ivIB070500 then
      Result := [nlAscLast, nlDescLast]
    else
      Result := [nlAscFirst, nlDescLast];
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetBrand: TFDPhysIBBrand;
begin
  Result := FBrand;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetDialect: Integer;
begin
  Result := FDialect;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysIBMetadata.DefineMetadataStructure(ATable: TFDDatSTable;
  AKind: TFDPhysMetaInfoKind);
begin
  inherited DefineMetadataStructure(ATable, AKind);
  case AKind of
  mkResultSetFields:
    begin
      AddMetadataCol(ATable, 'TABLE_NAME',     dtWideString);
      AddMetadataCol(ATable, 'COLUMN_NAME',    dtWideString);
      AddMetadataCol(ATable, 'DOMAIN_NAME',    dtWideString);
      AddMetadataCol(ATable, 'IN_PKEY',        dtInt16);
      AddMetadataCol(ATable, 'GENERATOR_NAME', dtWideString);
      AddMetadataCol(ATable, 'ISCOMPUTED',     dtInt16);
      AddMetadataCol(ATable, 'HASDEFAULT',     dtInt16);
      if (FBrand = ibFirebird) and (GetServerVersion >= ivFB030000) then
        AddMetadataCol(ATable, 'IDENT_TYPE',   dtInt16);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.GetResultSetFields(const ASQLKey: String): TFDDatSView;
begin
  Result := inherited GetResultSetFields(ASQLKey);
  Result.Mechanisms.AddSort('TABLE_NAME;COLUMN_NAME');
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.InternalEscapeBoolean(const AStr: String): String;
begin
  if CompareText(AStr, S_FD_True) = 0 then
    Result := '1'
  else
    Result := '0';
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.InternalEscapeDate(const AStr: String): String;
begin
  Result := 'CAST(' + AnsiQuotedStr(AStr, '''') + ' AS DATE)';
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.InternalEscapeDateTime(const AStr: String): String;
begin
  Result := 'CAST(' + AnsiQuotedStr(AStr, '''') + ' AS TIMESTAMP)';
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.InternalEscapeTime(const AStr: String): String;
begin
  Result := 'CAST(' + AnsiQuotedStr(AStr, '''') + ' AS TIME)';
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.InternalEscapeFloat(const AStr: String): String;
begin
  Result := 'CAST(' + AnsiQuotedStr(AStr, '''') + ' AS NUMERIC(18,6))';
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String;
var
  sName, A1, A2, A3, A4: String;

  function AddArgs: string;
  begin
    Result := '(';
    if Length(ASeq.FArgs) > 0 then
      Result := Result + AddEscapeSequenceArgs(ASeq);
    Result := Result + ')';
  end;

  procedure DoFB21;
  var
    i: Integer;
  begin
    case ASeq.FFunc of
    // numeric
    efDEGREES:     Result := '(180 * (' + A1 + ') / PI())';
    efLOG:         Result := 'LN' + AddArgs;
    efRADIANS:     Result := '((' + A1 + ') / 180 * PI())';
    efRANDOM:
      begin
        Result := 'RAND()';
        if Length(ASeq.FArgs) = 1 then
          Result := '(' + Result + ' * (' + A1 + '))';
      end;
    efROUND:
      begin
        Result := sName + '(' + A1;
        if Length(ASeq.FArgs) = 1 then
          Result := Result + ', 0'
        else
          Result := Result + ', ' + A2;
        Result := Result + ')';
      end;
    efTRUNCATE:    Result := 'TRUNC' + AddArgs;
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
    efASCII:       Result := 'ASCII_VAL' + AddArgs;
    efCHAR:        Result := 'ASCII_CHAR' + AddArgs;
    efCONCAT:      Result := '(' + A1 + ' || ' + A2 + ')';
    efINSERT:      Result := '(SUBSTRING(' + A1 + ' FROM 1 FOR (' + A2 + ') - 1) || ' + A4 +
                      ' || SUBSTRING(' + A1 + ' FROM (' + A2 + ' + ' + A3 + ')))';
    efLCASE:       Result := 'LOWER' + AddArgs;
    efLENGTH:      Result := 'CHAR_LENGTH(' + A1 + ')';
    efLOCATE,
    efPOSITION:
      begin
        if Length(ASeq.FArgs) >= 3 then
          UnsupportedEscape(ASeq);
        Result := 'POSITION(' + A1 + ' IN ' + A2 + ')';
      end;
    efLTRIM:       Result := 'TRIM(LEADING '' '' FROM ' + A1 + ')';
    efREPEAT:      Result := 'RPAD(' + A1 + ', (' + A2 + ') * CHAR_LENGTH(' + A1 + '), ' + A1 + ')';
    efRTRIM:       Result := 'TRIM(TRAILING '' '' FROM ' + A1 + ')';
    efSPACE:       Result := 'RPAD('' '', ' + A1 + ')';
    efUCASE:       Result := 'UPPER' + AddArgs;
    efBIT_LENGTH,
    efCHAR_LENGTH,
    efLEFT,
    efOCTET_LENGTH,
    efREPLACE,
    efRIGHT:       Result := sName + AddArgs;
    efSUBSTRING:
      begin
        Result := sName + '(' + A1 + ' FROM ' + A2;
        if Length(ASeq.FArgs) >= 3 then
          Result := Result + ' FOR ' + A3;
        Result := Result + ')';
      end;

    // system
    efCATALOG:     Result := '''''';
    efSCHEMA:      Result := '''''';
    efIFNULL:      Result := 'COALESCE(' + A1 + ', ' + A2 + ')';
    efIF:          Result := 'IIF' + AddArgs;
    efDECODE:      Result := sName + AddArgs;

    // convert
    efCONVERT:
      begin
        A2 := UpperCase(Trim(A2));
        if A2 = 'DATETIME' then
          A2 := 'TIMESTAMP'
        else if Copy(A2, 1, 9) = 'VARBINARY' then
          A2 := 'VARCHAR' + Copy(A2, 10, MAXINT) + ' CHARACTER SET OCTETS'
        else if Copy(A2, 1, 6) = 'BINARY' then
          A2 := 'CHAR' + Copy(A2, 7, MAXINT) + ' CHARACTER SET OCTETS';
        Result := 'CAST(' + A1 + ' AS ' + A2 + ')';
      end;

    // date and time
    efCURDATE:     Result := 'CURRENT_DATE';
    efCURTIME:     Result := 'CURRENT_TIME';
    efNOW:         Result := 'CURRENT_TIMESTAMP';
    efDAYNAME:
      begin
        Result := 'TRIM(TRAILING FROM CASE EXTRACT(WEEKDAY FROM ' + A1 + ')';
        for i := 1 to 7 do
          Result := Result + ' WHEN ' + IntToStr(i - 1) + ' THEN ''' +
            AnsiUpperCase(FormatSettings.LongDayNames[i]) + '''';
        Result := Result + ' END)';
      end;
    efDAYOFMONTH:  Result := 'EXTRACT(DAY FROM ' + A1 + ')';
    efDAYOFWEEK:   Result := '(EXTRACT(WEEKDAY FROM ' + A1 + ') + 1)';
    efDAYOFYEAR:   Result := '(EXTRACT(YEARDAY FROM ' + A1 + ') + 1)';
    efEXTRACT:     Result := sName + '(' + FDUnquote(A1, '''') + ' FROM ' + A2 + ')';
    efHOUR:        Result := 'EXTRACT(HOUR FROM ' + A1 + ')';
    efMINUTE:      Result := 'EXTRACT(MINUTE FROM ' + A1 + ')';
    efMONTH:       Result := 'EXTRACT(MONTH FROM ' + A1 + ')';
    efMONTHNAME:
      begin
        Result := 'TRIM(TRAILING FROM CASE EXTRACT(MONTH FROM ' + A1 + ')';
        for i := 1 to 12 do
          Result := Result + ' WHEN ' + IntToStr(i) + ' THEN ''' +
            AnsiUpperCase(FormatSettings.LongMonthNames[i]) + '''';
        Result := Result + ' END)';
      end;
    efQUARTER:     Result := '(TRUNC((EXTRACT(MONTH FROM ' + A1 + ') - 1) / 3) + 1)';
    efSECOND:      Result := 'EXTRACT(SECOND FROM ' + A1 + ')';
    efTIMESTAMPADD:
      begin
        A1 := UpperCase(FDUnquote(Trim(A1), ''''));
        if A1 = 'FRAC_SECOND' then
          Result := 'DATEADD(MILLISECOND, (' + A2 + ') / 1000, ' + A3 + ')'
        else if A1 = 'WEEK' then
          Result := 'DATEADD(DAY, 7 * (' + A2 + '), ' + A3 + ')'
        else if A1 = 'QUARTER' then
          Result := 'DATEADD(MONTH, 3 * (' + A2 + '), ' + A3 + ')'
        else
          Result := 'DATEADD(' + A1 + ', ' + A2 + ', ' + A3 + ')';
      end;
    efTIMESTAMPDIFF:
      begin
        A1 := UpperCase(FDUnquote(Trim(A1), ''''));
        if A1 = 'FRAC_SECOND' then
          Result := 'TRUNC(DATEDIFF(MILLISECOND, ' + A2 + ', ' + A3 + ') * 1000)'
        else if A1 = 'WEEK' then
          Result := 'TRUNC(DATEDIFF(DAY, ' + A2 + ', ' + A3 + ') / 7)'
        else if A1 = 'QUARTER' then
          Result := 'TRUNC(DATEDIFF(MONTH, ' + A2 + ', ' + A3 + ') / 3)'
        else
          Result := 'DATEDIFF(' + A1 + ', ' + A2 + ', ' + A3 + ')';
      end;
    efWEEK:        Result := 'TRUNC((EXTRACT(YEARDAY FROM ' + A1 +
      ') - EXTRACT(WEEKDAY FROM ' + A1 + ' - 1) + 7) / 7) + 1';
    efYEAR:        Result := 'EXTRACT(YEAR FROM ' + A1 + ')';
    else
      UnsupportedEscape(ASeq);
    end;
  end;

  procedure DoIB;
  var
    i: Integer;
    s1, s2: String;
  begin
    case ASeq.FFunc of
    // numeric
    efDEGREES:     Result := '(180 * (' + A1 + ') / PI())';
    efLOG:         Result := 'LN' + AddArgs;
    efRADIANS:     Result := '((' + A1 + ') / 180 * PI())';
    efRANDOM:      Result := 'RAND';
    efROUND:       Result := 'CASE WHEN ABS(CEILING(' + A1 + ') - FLOOR(' + A1 + ')) <= 0.5 THEN FLOOR(' + A1 + ') ELSE CEILING(' + A1 + ') END';
    efTRUNCATE:    Result := 'FLOOR' + AddArgs;
    efABS,
    efACOS,
    efASIN,
    efATAN,
    efATAN2,
    efCEILING,
    efCOS,
    efCOT,
    efFLOOR,
    efLOG10,
    efMOD,
    efPI,
    efSIGN,
    efSIN,
    efSQRT,
    efTAN:         Result := sName + AddArgs;

    // character
    efASCII:       Result := 'ASCII_VAL' + AddArgs;
    efBIT_LENGTH:  Result := '(STRLEN(' + A1 + ') * 8)';
    efCHAR:        Result := 'ASCII_CHAR' + AddArgs;
    efCONCAT:      Result := '(' + A1 + ' || ' + A2 + ')';
    efINSERT:
      begin
        s1 := 'SUBSTR(' + A1 + ', 1, ' + A2 + ' - 1)';
        s1 := 'CASE WHEN ' + s1 + ' IS NULL THEN CAST('''' AS VARCHAR(1)) ELSE ' + s1 + ' END';
        s2 := 'SUBSTR(' + A1 + ', ' + A2 + ' + ' + A3 + ', STRLEN(' + A1 + '))';
        s2 := 'CASE WHEN ' + s2 + ' IS NULL THEN CAST('''' AS VARCHAR(1)) ELSE ' + s2 + ' END';
        Result := '(' + s1 + ' || ' + A4 + ' || ' + s2 + ')';
      end;
    efLCASE:       Result := 'LOWER' + AddArgs;
    efLEFT:        Result := 'SUBSTR(' + A1 + ', 1, ' + A2 + ')';
    efLENGTH,
    efCHAR_LENGTH,
    efOCTET_LENGTH: Result := 'STRLEN(' + A1 + ')';
    efLOCATE,
    efPOSITION:
      begin
        if Length(ASeq.FArgs) >= 3 then
          UnsupportedEscape(ASeq);
        Result := 'LOCATE(' + A1 + ', ' + A2 + ')';
      end;
    efRIGHT:       Result := 'SUBSTR(' + A1 + ', STRLEN(' + A1 + ') + 1 - ' + A2 + ', STRLEN(' + A1 + '))';
    efSPACE:       Result := 'CAST('' '' AS CHAR(' + A1 + '))';
    efSUBSTRING:   Result := 'SUBSTR(' + A1 + ', ' + A2 + ', ' + A2 + ' + ' + A3 + ' - 1)';
    efLTRIM,
    efRTRIM:       Result := sName + AddArgs;
    efUCASE:       Result := 'UPPER' + AddArgs;

    // system
    efCATALOG:     Result := '''''';
    efSCHEMA:      Result := '''''';
    efIFNULL:      Result := 'COALESCE(' + A1 + ', ' + A2 + ')';
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
        if A2 = 'DATETIME' then
          A2 := 'TIMESTAMP'
        else if Copy(A2, 1, 9) = 'VARBINARY' then
          A2 := 'VARCHAR' + Copy(A2, 10, MAXINT) + ' CHARACTER SET OCTETS'
        else if Copy(A2, 1, 6) = 'BINARY' then
          A2 := 'CHAR' + Copy(A2, 7, MAXINT) + ' CHARACTER SET OCTETS';
        Result := 'CAST(' + A1 + ' AS ' + A2 + ')';
      end;

    // date and time
    efCURDATE:     Result := 'CURRENT_DATE';
    efCURTIME:     Result := 'CURRENT_TIME';
    efNOW:         Result := 'CURRENT_TIMESTAMP';
    efDAYNAME:
      begin
        Result := 'CASE EXTRACT(WEEKDAY FROM ' + A1 + ')';
        for i := 1 to 7 do
          Result := Result + ' WHEN ' + IntToStr(i - 1) + ' THEN ''' +
            AnsiUpperCase(FormatSettings.LongDayNames[i]) + '''';
        Result := Result + ' ELSE '''' END';
      end;
    efDAYOFMONTH:  Result := 'EXTRACT(DAY FROM ' + A1 + ')';
    efDAYOFWEEK:   Result := '(EXTRACT(WEEKDAY FROM ' + A1 + ') + 1)';
    efDAYOFYEAR:   Result := '(EXTRACT(YEARDAY FROM ' + A1 + ') + 1)';
    efEXTRACT:     Result := sName + '(' + FDUnquote(A1, '''') + ' FROM ' + A2 + ')';
    efHOUR:        Result := 'EXTRACT(HOUR FROM ' + A1 + ')';
    efMINUTE:      Result := 'EXTRACT(MINUTE FROM ' + A1 + ')';
    efMONTH:       Result := 'EXTRACT(MONTH FROM ' + A1 + ')';
    efMONTHNAME:
      begin
        Result := 'CASE EXTRACT(MONTH FROM ' + A1 + ')';
        for i := 1 to 12 do
          Result := Result + ' WHEN ' + IntToStr(i) + ' THEN ''' +
            AnsiUpperCase(FormatSettings.LongMonthNames[i]) + '''';
        Result := Result + ' ELSE '''' END';
      end;
    efQUARTER:     Result := '(FLOOR((EXTRACT(MONTH FROM ' + A1 + ') - 1) / 3) + 1)';
    efSECOND:      Result := 'EXTRACT(SECOND FROM ' + A1 + ')';
    efTIMESTAMPADD:
      begin
        A1 := UpperCase(FDUnquote(Trim(A1), ''''));
        if A1 = 'WEEK' then
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
          // YEAR, MONTH
          UnsupportedEscape(ASeq);
      end;
    efTIMESTAMPDIFF:
      begin
        A1 := UpperCase(FDUnquote(Trim(A1), ''''));
        if A1 = 'WEEK' then
          Result := 'FLOOR(((' + A3 + ') - (' + A2 + ')) / 7)'
        else if A1 = 'DAY' then
          Result := 'FLOOR((' + A3 + ') - (' + A2 + '))'
        else if A1 = 'HOUR' then
          Result := 'FLOOR(((' + A3 + ') - (' + A2 + ')) * 24.0)'
        else if A1 = 'MINUTE' then
          Result := 'FLOOR(((' + A3 + ') - (' + A2 + ')) * (24.0 * 60.0))'
        else if A1 = 'SECOND' then
          Result := 'FLOOR(((' + A3 + ') - (' + A2 + ')) * (24.0 * 60.0 * 60.0))'
        else if A1 = 'FRAC_SECOND' then
          Result := 'FLOOR(((' + A3 + ') - (' + A2 + ')) * (24.0 * 60.0 * 60.0 * 1000000.0))'
        else
          // YEAR, MONTH
          UnsupportedEscape(ASeq);
      end;
    efWEEK:        Result := 'FLOOR((EXTRACT(YEARDAY FROM ' + A1 +
      ') - EXTRACT(WEEKDAY FROM ' + A1 + ' - 1) + 7) / 7) + 1';
    efYEAR:        Result := 'EXTRACT(YEAR FROM ' + A1 + ')';
    else
      // Numeric: efEXP, efPOWER
      // String: efREPEAT, efREPLACE
      UnsupportedEscape(ASeq);
    end;
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
  if (FBrand = ibFirebird) and (GetServerVersion >= ivFB020100) then
    DoFB21
  else
    DoIB;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBMetadata.InternalGetSQLCommandKind(
  const ATokens: TStrings): TFDPhysCommandKind;
var
  sToken: String;
begin
  sToken := ATokens[0];
  if sToken = 'EXECUTE' then
    Result := skExecute
  else if sToken = 'SET' then
    if ATokens.Count = 1 then
      Result := skNotResolved
    else if ATokens[1] = 'TRANSACTION' then
      Result := skStartTransaction
    else
      Result := skSet
  else if sToken = 'DECLARE' then
    Result := skCreate
  else if sToken = 'UPDATE' then
    if ATokens.Count < 3 then
      Result := skNotResolved
    else if (ATokens[1] = 'OR') and (ATokens[2] = 'INSERT') then
      Result := skMerge
    else
      Result := skUpdate
  else
    Result := inherited InternalGetSQLCommandKind(ATokens);
  if (Result in [skInsert, skMerge, skUpdate, skDelete]) and (ATokens.Count = 2) and
     (ATokens[1] = 'RETURNING') then
    Result := skSelectForLock;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysIBCommandGenerator                                                     }
{-------------------------------------------------------------------------------}
constructor TFDPhysIBCommandGenerator.Create(const ACommand: IFDPhysCommand;
  AIDUTF8: Integer; AEncoding: TFDEncoding);
begin
  inherited Create(ACommand);
  FIDUTF8 := AIDUTF8;
  FEncoding := AEncoding;
end;

{-------------------------------------------------------------------------------}
constructor TFDPhysIBCommandGenerator.Create(const AConnection: IFDPhysConnection;
  AIDUTF8: Integer; AEncoding: TFDEncoding);
begin
  inherited Create(AConnection);
  FIDUTF8 := AIDUTF8;
  FEncoding := AEncoding;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBCommandGenerator.GetInlineRefresh(const AStmt: String;
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
function TFDPhysIBCommandGenerator.GetPessimisticLock: String;
var
  lNeedFrom: Boolean;
  oIBConnMeta: IFDPhysIBConnectionMetadata;
begin
  lNeedFrom := False;
  Result := 'SELECT ' + GetSelectList(True, False, lNeedFrom) + BRK +
    'FROM ' + GetFrom + BRK + 'WHERE ' + GetWhere(False, True, False) + BRK +
    'FOR UPDATE';
  Supports(FConnMeta, IFDPhysIBConnectionMetadata, oIBConnMeta);
  if (oIBConnMeta.Brand = ibFirebird) and (FConnMeta.ServerVersion >= ivFB010500) then
    Result := Result + ' WITH LOCK';
  FCommandKind := skSelectForLock;
  ASSERT(lNeedFrom);
  // WAIT / NOWAIT is controlled through transaction
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBCommandGenerator.GetSavepoint(const AName: String): String;
begin
  Result := 'SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBCommandGenerator.GetRollbackToSavepoint(const AName: String): String;
begin
  Result := 'ROLLBACK TO SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBCommandGenerator.GetCommitSavepoint(const AName: String): String;
begin
  Result := 'RELEASE SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBCommandGenerator.GetReadGenerator(const AName, AAlias: String;
  ANextValue, AFullSelect: Boolean): String;
begin
  if ANextValue then
    Result := 'GEN_ID(' + AName + ', 1)'
  else
    Result := 'GEN_ID(' + AName + ', 0)';
  if AAlias <> '' then
    Result := Result + ' ' + AAlias;
  if AFullSelect then
    Result := 'SELECT ' + Result + BRK + 'FROM ' + GetSingleRowTable;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBCommandGenerator.GetSingleRowTable: String;
begin
  Result := 'RDB$DATABASE';
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBCommandGenerator.GetRowId(var AAlias: String): String;
begin
  Result := 'RDB$DB_KEY';
  AAlias := 'DB_KEY';
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBCommandGenerator.GetCall(const AName: String): String;
begin
  Result := 'EXECUTE PROCEDURE ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBCommandGenerator.GetStoredProcCall(const ACatalog, ASchema,
  APackage, AProc: String; ASPUsage: TFDPhysCommandKind): String;
var
  i: Integer;
  sInPar: String;
  oParam: TFDParam;
  lHasOutput: Boolean;
  lIsFunc: Boolean;
  rName: TFDPhysParsedName;
  sProc: String;
begin
  sInPar := '';
  lHasOutput := False;
  lIsFunc := False;
  if FParams.Count > 0 then begin
    for i := 0 to FParams.Count - 1 do begin
      oParam := FParams[i];
      if oParam.ParamType in [ptUnknown, ptInput, ptInputOutput] then begin
        if sInPar <> '' then
          sInPar := sInPar + ', ';
        sInPar := sInPar + '?';
      end;
      if oParam.ParamType in [ptOutput, ptInputOutput, ptResult] then
        lHasOutput := True;
      if oParam.ParamType = ptResult then
        lIsFunc := True;
    end;
  end;
  if FCommandKind = skStoredProc then
    if (ASPUsage = skStoredProcWithCrs) and lHasOutput then
      FCommandKind := skStoredProcWithCrs
    else
      FCommandKind := skStoredProcNoCrs;

  rName.FCatalog := ACatalog;
  rName.FSchema := ASchema;
  rName.FBaseObject := APackage;
  rName.FObject := AProc;
  sProc := FConnMeta.EncodeObjName(rName, FCommand, [eoQuote, eoNormalize]);

  if lIsFunc then begin
    Result := 'SELECT ' + sProc;
    if sInPar <> '' then
      Result := Result + '(' + sInPar + ')';
    Result := Result + ' AS Result FROM RDB$DATABASE';
  end
  else if FCommandKind = skStoredProcWithCrs then begin
    Result := 'SELECT * FROM ' + sProc;
    if sInPar <> '' then
      Result := Result + '(' + sInPar + ')';
  end
  else begin
    Result := 'EXECUTE PROCEDURE ' + sProc;
    if sInPar <> '' then begin
      Result := Result + ' ' + sInPar;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBCommandGenerator.GetSelectMetaInfo(AKind: TFDPhysMetaInfoKind;
  const ACatalog, ASchema, ABaseObject, AObject, AWildcard: String;
  AObjectScopes: TFDPhysObjectScopes; ATableKinds: TFDPhysTableKinds;
  AOverload: Word): String;
var
  lWasWhere: Boolean;
  sScope, sKinds: String;
  oIBConnMeta: IFDPhysIBConnectionMetadata;

  function NVL(const AField, AValue: String; AIntField: Boolean): String;
  begin
    if (oIBConnMeta.Brand = ibInterbase) and ((FConnMeta.ServerVersion < ivIB070500) or not AIntField) then
      Result := AField
    else
      Result := 'COALESCE(' + AField + ', ' + AValue + ')';
  end;

  procedure AddWhere(const ACond: String; const AParam: String = '');
  var
    oParam: TFDParam;
  begin
    if lWasWhere then
      Result := Result + ' AND ' + ACond
    else begin
      Result := Result + ' WHERE ' + ACond;
      lWasWhere := True;
    end;
    if AParam <> '' then begin
      oParam := GetParams.Add;
      oParam.Name := AParam;
      oParam.DataType := ftString;
      oParam.Size := 70;
    end;
  end;

  procedure AddTopScope(AWithOwner: Boolean);
  begin
    if AObjectScopes <> [osMy, osSystem, osOther] then begin
      sScope := '';
      if osMy in AObjectScopes then begin
        sScope := sScope + '(RDB$SYSTEM_FLAG IS NULL OR RDB$SYSTEM_FLAG = 0) ';
        if AWithOwner then
          sScope := sScope + 'AND ' + NVL('RDB$OWNER_NAME', '''''', False) + ' = USER ';
        sScope := sScope + 'OR ';
      end;
      if osSystem in AObjectScopes then
        sScope := sScope + '(RDB$SYSTEM_FLAG IS NOT NULL AND RDB$SYSTEM_FLAG > 0) OR ';
      if (osOther in AObjectScopes) and (AWithOwner or not (osMy in AObjectScopes)) then begin
        sScope := sScope + '(RDB$SYSTEM_FLAG IS NULL OR RDB$SYSTEM_FLAG = 0) ';
        if AWithOwner then
          sScope := sScope + 'AND ' + NVL('RDB$OWNER_NAME', '''''', False) + ' <> USER ';
        sScope := sScope + 'OR ';
      end;
      if sScope <> '' then
        AddWhere('(' + Copy(sScope, 1, Length(sScope) - 4) + ')');
    end;
  end;

  function EncodeDataType(const AField, ASubField, AScaleField, ACharsetField,
    ADomainField: String): String;

    function DT2Str(AType: TFDDataType): String;
    begin
      Result := IntToStr(Integer(AType));
    end;

    function EncodeScale(AType: TFDDataType; ACurrency: Boolean): String;
    begin
      if ACurrency then
        Result :=
          'CASE' +
          ' WHEN ' + AScaleField + ' < -4 THEN ' + DT2Str(dtFmtBCD) +
          ' WHEN ' + AScaleField + ' < 0 THEN ' + DT2Str(dtBCD) +
          ' ELSE ' + DT2Str(AType) +
          ' END'
      else
        Result :=
          'CASE' +
          ' WHEN ' + AScaleField + ' < 0 THEN ' + DT2Str(dtFmtBCD) +
          ' ELSE ' + DT2Str(AType) +
          ' END';
    end;

    function EncodeStrType: String;
    begin
      Result :=
        'CASE ' + ACharsetField +
        ' WHEN ' + IntToStr(csIDNone) + ' THEN ' + DT2Str(dtAnsiString) +
        ' WHEN ' + IntToStr(csIDOctets) + ' THEN ' + DT2Str(dtByteString) +
        ' WHEN ' + IntToStr(csIDUnicodeFSS) + ' THEN ' + DT2Str(dtWideString);
      if oIBConnMeta.Brand = ibInterbase then
        Result := Result +
        ' WHEN ' + IntToStr(csIDUnicodeBE) + ' THEN ' + DT2Str(dtWideString) +
        ' WHEN ' + IntToStr(csIDUnicodeLE) + ' THEN ' + DT2Str(dtWideString);
      if FIDUTF8 <> 0 then
        Result := Result +
        ' WHEN ' + IntToStr(FIDUTF8) + ' THEN ' + DT2Str(dtWideString);
      Result := Result +
        ' ELSE ' + DT2Str(dtAnsiString) +
        ' END';
    end;

  begin
    Result :=
      'CASE WHEN ' + ADomainField + ' LIKE ''%BOOL%'' THEN ' + DT2Str(dtBoolean) +
      ' ELSE ' +
        'CASE ' + AField +
        ' WHEN 7 THEN ' + EncodeScale(dtInt16, True) +
        ' WHEN 8 THEN ' + EncodeScale(dtInt32, True) +
        ' WHEN 9 THEN ' + EncodeScale(dtInt64, False) +
        ' WHEN 10 THEN ' + DT2Str(dtSingle) +
        ' WHEN 11 THEN ' + DT2Str(dtDouble) +
        ' WHEN 12 THEN ' + DT2Str(dtDate) +
        ' WHEN 13 THEN ' + DT2Str(dtTime) +
        ' WHEN 14 THEN ' + EncodeStrType() +
        ' WHEN 16 THEN ' + EncodeScale(dtInt64, False) +
        ' WHEN 17 THEN ' + DT2Str(dtBoolean) +
        ' WHEN 23 THEN ' + DT2Str(dtBoolean) +
        ' WHEN 27 THEN ' + DT2Str(dtDouble) +
        ' WHEN 35 THEN ' + DT2Str(dtDateTimeStamp) +
        ' WHEN 37 THEN ' + EncodeStrType() +
        ' WHEN 40 THEN ' + EncodeStrType() +
        ' WHEN 45 THEN ' + DT2Str(dtBlob) +
        ' WHEN 261 THEN ' +
           'CASE ' + ASubField;
      if FEncoding = ecUTF8 then
        Result := Result +
           ' WHEN 1 THEN ' + DT2Str(dtWideMemo)
      else
        Result := Result +
           ' WHEN 1 THEN ' + DT2Str(dtMemo);
      Result := Result +
           ' ELSE ' + DT2Str(dtBlob) +
           ' END ' +
        ' ELSE ' + DT2Str(dtUnknown) +
        ' END' +
      ' END';
  end;

  function EncodeTypeName(const AField, ASubField, AScaleField, ADomainField,
    AIdentField: String): String;

    function EncodeNumType(const AIntType: String): String;
    begin
      Result :=
        'CASE' +
        ' WHEN ' + AScaleField + ' = 0 THEN ''' + AIntType + '''' +
        ' WHEN ' + AScaleField + ' < 0 THEN ''DECIMAL''' +
        ' END';
    end;

  begin
    Result :=
      'CASE WHEN ' + ADomainField + ' LIKE ''%BOOL%'' THEN ''BOOLEAN''' +
      ' ELSE ' +
        'CASE ' + AField +
        ' WHEN 7 THEN ' + EncodeNumType('SMALLINT') +
        ' WHEN 8 THEN ' + EncodeNumType('INTEGER') +
        ' WHEN 9 THEN ' + EncodeNumType('NUMERIC') +
        ' WHEN 10 THEN ''FLOAT''' +
        ' WHEN 11 THEN ''DOUBLE PRECISION''' +
        ' WHEN 12 THEN ''DATE''' +
        ' WHEN 13 THEN ''TIME''' +
        ' WHEN 14 THEN ''CHAR''' +
        ' WHEN 16 THEN ''NUMERIC''' +
        ' WHEN 17 THEN ''BOOLEAN''' +
        ' WHEN 23 THEN ''BOOLEAN''' +
        ' WHEN 27 THEN ''DOUBLE PRECISION''' +
        ' WHEN 35 THEN ''TIMESTAMP''' +
        ' WHEN 37 THEN ''VARCHAR''' +
        ' WHEN 40 THEN ''VARCHAR''' +
        ' WHEN 45 THEN ''BLOB''' +
        ' WHEN 261 THEN ''BLOB SUB_TYPE '' || CAST(' + ASubField + ' AS INTEGER)' +
        ' END' +
      ' END';

    if (oIBConnMeta.Brand = ibFirebird) and (FConnMeta.ServerVersion >= ivFB030000) and
       (AIdentField <> '') then
      Result := Result +
        ' || CASE' +
        ' WHEN ' + AIdentField + ' >= 1 THEN '' GENERATED BY DEFAULT AS IDENTITY''' +
        ' ELSE ''''' +
        ' END';
  end;

  function EncodeScope(const ASysFlagName, AOwnerName: String): String;
  begin
    Result :=
      'CASE ' + ASysFlagName;
    if (oIBConnMeta.Brand = ibInterbase) or (AOwnerName = '') then
      Result := Result +
      ' WHEN 0 THEN ' + IntToStr(Integer(osMy)) +
      ' ELSE ' +  IntToStr(Integer(osSystem))
    else
      Result := Result +
      ' WHEN 0 THEN ' +
        'CASE ' + AOwnerName +
        ' WHEN USER THEN ' + IntToStr(Integer(osMy)) +
        ' ELSE ' + IntToStr(Integer(osOther)) +
        ' END' +
      ' ELSE ' +  IntToStr(Integer(osSystem));
    Result := Result +
      ' END';
  end;

  function EncodeAttrs(const ATypeFieldName, ACompFieldName, ADefFieldName,
    ANullFieldName, AIdentField: String): String;

    function Attrs2Str(AAttrs: TFDDataAttributes): String;
    begin
      if AKind <> mkTableFields then
        Exclude(AAttrs, caBase);
      Result := IntToStr(PWord(@AAttrs)^);
    end;

  begin
    Result :=
      '(CASE ' + ATypeFieldName +
      ' WHEN 7 THEN ' + Attrs2Str([caBase, caSearchable]) +
      ' WHEN 8 THEN ' + Attrs2Str([caBase, caSearchable]) +
      ' WHEN 9 THEN ' + Attrs2Str([caBase, caSearchable]) +
      ' WHEN 10 THEN ' + Attrs2Str([caBase, caSearchable]) +
      ' WHEN 11 THEN ' + Attrs2Str([caBase, caSearchable]) +
      ' WHEN 12 THEN ' + Attrs2Str([caBase, caSearchable]) +
      ' WHEN 13 THEN ' + Attrs2Str([caBase, caSearchable]) +
      ' WHEN 14 THEN ' + Attrs2Str([caBase, caSearchable, caFixedLen]) +
      ' WHEN 16 THEN ' + Attrs2Str([caBase, caSearchable]) +
      ' WHEN 17 THEN ' + Attrs2Str([caBase, caSearchable]) +
      ' WHEN 23 THEN ' + Attrs2Str([caBase, caSearchable]) +
      ' WHEN 27 THEN ' + Attrs2Str([caBase, caSearchable]) +
      ' WHEN 35 THEN ' + Attrs2Str([caBase, caSearchable]) +
      ' WHEN 37 THEN ' + Attrs2Str([caBase, caSearchable]) +
      ' WHEN 40 THEN ' + Attrs2Str([caBase, caSearchable]) +
      ' WHEN 45 THEN ' + Attrs2Str([caBase, caSearchable]) +
      ' WHEN 261 THEN ' + Attrs2Str([caBase, caBlobData]) +
      ' END + ' +

      'CASE ' +
      ' WHEN ' + ACompFieldName + ' IS NOT NULL THEN ' + Attrs2Str([caCalculated, caReadOnly]) +
      ' ELSE 0' +
      ' END + ' +

      'CASE ' +
      ' WHEN ' + ADefFieldName + ' IS NOT NULL THEN ' + Attrs2Str([caDefault]) +
      ' ELSE 0' +
      ' END + ' +

      'CASE ' +
      ' WHEN ' + ANullFieldName + ' IS NULL THEN ' + Attrs2Str([caAllowNull]) +
      ' ELSE 0' +
      ' END';

    if (oIBConnMeta.Brand = ibFirebird) and (FConnMeta.ServerVersion >= ivFB030000) and
       (AIdentField <> '') then
      Result := Result +
        ' + CASE' +
        ' WHEN ' + AIdentField + ' >= 1 THEN ' + Attrs2Str([caAutoInc]) +
        ' ELSE 0' +
        ' END';

    Result := Result + ')';
  end;

  function EncodeRTrim(const AValue: String): String;
  begin
    if (oIBConnMeta.Brand = ibFirebird) and (FConnMeta.ServerVersion >= ivFB020100) then
      Result := 'TRIM(TRAILING '' '' FROM ' + AValue + ')'
    else
      Result := 'RTRIM(' + AValue + ')';
  end;

begin
  Result := '';
  lWasWhere := False;
  Supports(FConnMeta, IFDPhysIBConnectionMetadata, oIBConnMeta);

  case AKind of
  mkCatalogs:
    ;

  mkSchemas:
    ;

  mkTables:
    begin
      Result := 'SELECT CAST(NULL AS NUMERIC) AS RECNO, ' +
        'CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, ' +
        'CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, ' +
        'RDB$RELATION_NAME AS TABLE_NAME, ';
      if (oIBConnMeta.Brand = ibInterbase) and (FConnMeta.ServerVersion < ivIB070500) then
        Result := Result +
          'RDB$VIEW_BLR AS TABLE_TYPE, ' +
          'RDB$SYSTEM_FLAG AS TABLE_SCOPE '
      else
        Result := Result +
          'CASE' +
          ' WHEN RDB$VIEW_BLR IS NULL THEN ' +
            'CASE ' + NVL('RDB$FLAGS', '0', True) +
            ' WHEN 0 THEN ' + IntToStr(Integer(tkTable)) +
            ' WHEN 1 THEN ' + IntToStr(Integer(tkTable)) +
            ' WHEN 2 THEN ' + IntToStr(Integer(tkTempTable)) +
            ' WHEN 8 THEN ' + IntToStr(Integer(tkTempTable)) +
            ' WHEN 16 THEN ' + IntToStr(Integer(tkTempTable)) +
            ' END' +
          ' ELSE ' + IntToStr(Integer(tkView)) +
          ' END AS TABLE_TYPE, ' +
          EncodeScope(NVL('RDB$SYSTEM_FLAG', '0', True), NVL('RDB$OWNER_NAME', '''''', False)) + ' AS TABLE_SCOPE ';
      Result := Result +
        'FROM RDB$RELATIONS';
      sKinds := '';
      if tkTable in ATableKinds then
        sKinds := sKinds + NVL('RDB$FLAGS', '0', True) + ' IN (0, 1) AND RDB$VIEW_BLR IS NULL OR ';
      if tkView in ATableKinds then
        sKinds := sKinds + 'RDB$VIEW_BLR IS NOT NULL OR ';
      if tkTempTable in ATableKinds then
        sKinds := sKinds + NVL('RDB$FLAGS', '0', True) + ' IN (2, 8, 16) AND RDB$VIEW_BLR IS NULL OR ';
      if sKinds <> '' then
        AddWhere('(' + Copy(sKinds, 1, Length(sKinds) - 4) + ')');
      if AWildcard <> '' then
        AddWhere(EncodeRTrim('RDB$RELATION_NAME') + ' LIKE ?', 'WIL');
      AddTopScope(True);
      Result := Result + ' ORDER BY 4';
    end;

  mkTableFields:
    begin
      Result := 'SELECT CAST(NULL AS NUMERIC) AS RECNO, ' +
        'CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, ' +
        'CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, ' +
        'RF.RDB$RELATION_NAME AS TABLE_NAME, ' +
        'RF.RDB$FIELD_NAME AS COLUMN_NAME, ' +
        'RF.RDB$FIELD_POSITION + 1 AS COLUMN_POSITION, ';
      if (oIBConnMeta.Brand = ibInterbase) and (FConnMeta.ServerVersion < ivIB070500) then
        Result := Result +
          'F.RDB$FIELD_TYPE AS COLUMN_DATATYPE, ' +
          ''''' AS COLUMN_TYPENAME, ' +
          '1 AS COLUMN_ATTRIBUTES, '
      else
        Result := Result +
          EncodeDataType('F.RDB$FIELD_TYPE', 'F.RDB$FIELD_SUB_TYPE', 'F.RDB$FIELD_SCALE',
                         'F.RDB$CHARACTER_SET_ID', 'RF.RDB$FIELD_SOURCE') + ' AS COLUMN_DATATYPE, ' +
          EncodeTypeName('F.RDB$FIELD_TYPE', 'F.RDB$FIELD_SUB_TYPE', 'F.RDB$FIELD_SCALE',
                         'RF.RDB$FIELD_SOURCE', 'RF.RDB$IDENTITY_TYPE') + ' AS COLUMN_TYPENAME, ' +
          EncodeAttrs('F.RDB$FIELD_TYPE', 'F.RDB$COMPUTED_BLR', 'RF.RDB$DEFAULT_VALUE',
                      'RF.RDB$NULL_FLAG', 'RF.RDB$IDENTITY_TYPE') + ' AS COLUMN_ATTRIBUTES, ';
      Result := Result +
        'F.RDB$FIELD_PRECISION AS COLUMN_PRECISION, ' +
        '- F.RDB$FIELD_SCALE AS COLUMN_SCALE, ' +
        'F.RDB$CHARACTER_LENGTH AS COLUMN_LENGTH ' +
        'FROM RDB$RELATION_FIELDS RF LEFT JOIN RDB$FIELDS F ON RF.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME';
      AddWhere('RF.RDB$RELATION_NAME = ?', 'OBJ');
      if AWildcard <> '' then
        AddWhere(EncodeRTrim('RF.RDB$FIELD_NAME') + ' LIKE ?', 'WIL');
      Result := Result + ' ORDER BY 6';
    end;

  mkIndexes:
    begin
      Result := 'SELECT CAST(NULL AS NUMERIC) AS RECNO, ' +
        'CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, ' +
        'CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, ' +
        'I.RDB$RELATION_NAME AS TABLE_NAME, ' +
        'I.RDB$INDEX_NAME AS INDEX_NAME, ' +
        'C.RDB$CONSTRAINT_NAME AS CONSTRAINT_NAME, ';
      if (oIBConnMeta.Brand = ibInterbase) and (FConnMeta.ServerVersion < ivIB070500) then
        Result := Result +
          'I.RDB$UNIQUE_FLAG AS INDEX_TYPE '
      else
        Result := Result +
          'CASE' +
          ' WHEN I.RDB$UNIQUE_FLAG IS NULL OR I.RDB$UNIQUE_FLAG = 0 THEN ' + IntToStr(Integer(ikNonUnique)) +
          ' WHEN I.RDB$UNIQUE_FLAG = 1 THEN ' +
            'CASE ' +
            ' WHEN C.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' THEN ' + IntToStr(Integer(ikPrimaryKey)) +
            ' ELSE ' + IntToStr(Integer(ikUnique)) +
            ' END' +
          ' END AS INDEX_TYPE ';
      Result := Result +
        'FROM RDB$INDICES I LEFT OUTER JOIN RDB$RELATION_CONSTRAINTS C ON ' +
        ' I.RDB$RELATION_NAME = C.RDB$RELATION_NAME AND I.RDB$INDEX_NAME = C.RDB$INDEX_NAME';
      if (oIBConnMeta.Brand = ibInterbase) and (FConnMeta.ServerVersion < ivIB070500) then
        Result := Result +
          ' AND C.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY''';
      AddWhere('I.RDB$RELATION_NAME = ?', 'OBJ');
      if AWildcard <> '' then
        AddWhere(EncodeRTrim('I.RDB$INDEX_NAME') + ' LIKE ?', 'WIL');
      Result := Result + ' ORDER BY 7 DESC, 5 ASC';
    end;

  mkIndexFields:
    begin
      Result := 'SELECT CAST(NULL AS NUMERIC) AS RECNO, ' +
        'CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, ' +
        'CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, ' +
        'I.RDB$RELATION_NAME AS TABLE_NAME, ' +
        'I.RDB$INDEX_NAME AS INDEX_NAME, ' +
        'S.RDB$FIELD_NAME AS COLUMN_NAME, ' +
        'S.RDB$FIELD_POSITION + 1 AS COLUMN_POSITION, ' +
        'CASE WHEN I.RDB$INDEX_TYPE = 1 THEN ''D'' ELSE ''A'' END AS SORT_ORDER, ' +
        'CAST(NULL AS VARCHAR(67)) AS FILTER_ ' +
        'FROM RDB$INDICES I LEFT JOIN RDB$INDEX_SEGMENTS S ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME';
      AddWhere('I.RDB$RELATION_NAME = ?', 'BAS');
      AddWhere('I.RDB$INDEX_NAME = ?', 'OBJ');
      if AWildcard <> '' then
        AddWhere(EncodeRTrim('S.RDB$FIELD_NAME') + ' LIKE ?', 'WIL');
      Result := Result + ' ORDER BY 7';
    end;

  mkPrimaryKey:
    begin
      Result := 'SELECT CAST(NULL AS NUMERIC) AS RECNO, ' +
        'CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, ' +
        'CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, ' +
        'RDB$RELATION_NAME AS TABLE_NAME, ' +
        'RDB$INDEX_NAME AS INDEX_NAME, ' +
        'RDB$CONSTRAINT_NAME AS CONSTRAINT_NAME, ' +
        IntToStr(Integer(ikPrimaryKey)) + ' AS INDEX_TYPE ' +
        'FROM RDB$RELATION_CONSTRAINTS';
      AddWhere('RDB$CONSTRAINT_TYPE = ''PRIMARY KEY''');
      AddWhere('RDB$RELATION_NAME = ?', 'OBJ');
      if AWildcard <> '' then
        AddWhere(EncodeRTrim('RDB$INDEX_NAME') + ' LIKE ?', 'WIL');
      Result := Result + ' ORDER BY 5';
    end;

  mkPrimaryKeyFields:
    begin
      Result := 'SELECT CAST(NULL AS NUMERIC) AS RECNO, ' +
        'CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, ' +
        'CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, ' +
        'C.RDB$RELATION_NAME AS TABLE_NAME, ' +
        'C.RDB$INDEX_NAME AS INDEX_NAME, ' +
        'S.RDB$FIELD_NAME AS COLUMN_NAME, ' +
        'S.RDB$FIELD_POSITION + 1 AS COLUMN_POSITION, ' +
        '''A'' AS SORT_ORDER, ' +
        'CAST(NULL AS VARCHAR(67)) AS FILTER_ ' +
        'FROM RDB$RELATION_CONSTRAINTS C LEFT JOIN RDB$INDEX_SEGMENTS S ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME';
      AddWhere('C.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY''');
      AddWhere('C.RDB$RELATION_NAME = ?', 'BAS');
      if AWildcard <> '' then
        AddWhere(EncodeRTrim('S.RDB$FIELD_NAME') + ' LIKE ?', 'WIL');
      Result := Result + ' ORDER BY 7';
    end;

  mkForeignKeys:
    begin
      Result := 'SELECT CAST(NULL AS NUMERIC) AS RECNO, ' +
        'CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, ' +
        'CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, ' +
        'FK.RDB$RELATION_NAME AS TABLE_NAME, ' +
        'FK.RDB$CONSTRAINT_NAME AS FKEY_NAME, ' +
        'CAST(NULL AS VARCHAR(67)) AS PKEY_CATALOG_NAME, ' +
        'CAST(NULL AS VARCHAR(67)) AS PKEY_SCHEMA_NAME, ' +
        'PK.RDB$RELATION_NAME AS PKEY_TABLE_NAME, ';
      if (oIBConnMeta.Brand = ibInterbase) and (FConnMeta.ServerVersion < ivIB070500) then
        Result := Result +
          'R.RDB$DELETE_RULE AS DELETE_RULE, ' +
          'R.RDB$UPDATE_RULE AS UPDATE_RULE '
      else
        Result := Result +
          'CASE R.RDB$DELETE_RULE'+
          ' WHEN ''RESTRICT'' THEN ' + IntToStr(Integer(ckRestrict)) +
          ' WHEN ''NO ACTION'' THEN ' + IntToStr(Integer(ckNone)) +
          ' WHEN ''CASCADE'' THEN ' + IntToStr(Integer(ckCascade)) +
          ' WHEN ''SET NULL'' THEN ' + IntToStr(Integer(ckSetNull)) +
          ' WHEN ''SET DEFAULT'' THEN ' + IntToStr(Integer(ckSetDefault)) +
          ' END AS DELETE_RULE, ' +
          'CASE R.RDB$UPDATE_RULE' +
          ' WHEN ''RESTRICT'' THEN ' + IntToStr(Integer(ckRestrict)) +
          ' WHEN ''NO ACTION'' THEN ' + IntToStr(Integer(ckNone)) +
          ' WHEN ''CASCADE'' THEN ' + IntToStr(Integer(ckCascade)) +
          ' WHEN ''SET NULL'' THEN ' + IntToStr(Integer(ckSetNull)) +
          ' WHEN ''SET DEFAULT'' THEN ' + IntToStr(Integer(ckSetDefault)) +
          ' END AS UPDATE_RULE ';
      Result := Result +
        'FROM RDB$RELATION_CONSTRAINTS FK LEFT JOIN RDB$REF_CONSTRAINTS R ON FK.RDB$CONSTRAINT_NAME = R.RDB$CONSTRAINT_NAME ' +
                                         'LEFT JOIN RDB$RELATION_CONSTRAINTS PK ON R.RDB$CONST_NAME_UQ = PK.RDB$CONSTRAINT_NAME';
      AddWhere('FK.RDB$CONSTRAINT_TYPE = ''FOREIGN KEY''');
      AddWhere('FK.RDB$RELATION_NAME = ?', 'OBJ');
      if AWildcard <> '' then
        AddWhere(EncodeRTrim('FK.RDB$CONSTRAINT_NAME') + ' LIKE ?', 'WIL');
      Result := Result + ' ORDER BY 5';
    end;

  mkForeignKeyFields:
    begin
      Result := 'SELECT CAST(NULL AS NUMERIC) AS RECNO, ' +
        'CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, ' +
        'CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, ' +
        'FK.RDB$RELATION_NAME AS TABLE_NAME, ' +
        'FK.RDB$CONSTRAINT_NAME AS FKEY_NAME, ' +
        'FK_F.RDB$FIELD_NAME AS COLUMN_NAME, ' +
        'PK_F.RDB$FIELD_NAME AS PKEY_COLUMN_NAME, ' +
        'FK_F.RDB$FIELD_POSITION + 1 AS COLUMN_POSITION ' +
        'FROM RDB$RELATION_CONSTRAINTS FK LEFT JOIN RDB$REF_CONSTRAINTS R ON FK.RDB$CONSTRAINT_NAME = R.RDB$CONSTRAINT_NAME ' +
                                         'LEFT JOIN RDB$RELATION_CONSTRAINTS PK ON R.RDB$CONST_NAME_UQ = PK.RDB$CONSTRAINT_NAME ' +
                                         'LEFT JOIN RDB$INDEX_SEGMENTS FK_F ON FK.RDB$INDEX_NAME = FK_F.RDB$INDEX_NAME ' +
                                         'LEFT JOIN RDB$INDEX_SEGMENTS PK_F ON PK.RDB$INDEX_NAME = PK_F.RDB$INDEX_NAME AND' +
                                         '  FK_F.RDB$FIELD_POSITION = PK_F.RDB$FIELD_POSITION';
      AddWhere('FK.RDB$RELATION_NAME = ?', 'BAS');
      AddWhere('FK.RDB$CONSTRAINT_NAME = ?', 'OBJ');
      if AWildcard <> '' then
        AddWhere(EncodeRTrim('FK_F.RDB$FIELD_NAME') + ' LIKE ?', 'WIL');
      Result := Result + ' ORDER BY 8';
    end;

  mkPackages:
    if (oIBConnMeta.Brand = ibFirebird) and (FConnMeta.ServerVersion >= ivFB030000) then begin
      Result := 'SELECT CAST(NULL AS NUMERIC) AS RECNO, ' +
        'CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, ' +
        'CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, ' +
        'RDB$PACKAGE_NAME AS PACKAGE_NAME, ' +
        EncodeScope(NVL('RDB$SYSTEM_FLAG', '0', True), NVL('RDB$OWNER_NAME', '''''', False)) + ' AS PACKAGE_SCOPE ' +
        'FROM RDB$PACKAGES';
      AddTopScope(True);
      if AWildcard <> '' then
        AddWhere(EncodeRTrim('RDB$PACKAGE_NAME') + ' LIKE ?', 'WIL');
      Result := Result + ' ORDER BY 4';
    end
    else
      Result := '';

  mkProcs:
    begin
      Result := 'SELECT CAST(NULL AS NUMERIC) AS RECNO, ' +
        'CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, ' +
        'CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, ';
      if (oIBConnMeta.Brand = ibFirebird) and (FConnMeta.ServerVersion >= ivFB030000) then
        Result := Result +
          'RDB$PACKAGE_NAME AS PACK_NAME, '
      else
        Result := Result +
          'CAST(NULL AS VARCHAR(67)) AS PACK_NAME, ';
      Result := Result +
        'RDB$PROCEDURE_NAME AS PROC_NAME, ' +
        'CAST(NULL AS NUMERIC) AS OVERLOAD, ' +
        IntToStr(Integer(pkProcedure)) + ' AS PROC_TYPE, ';
      if (oIBConnMeta.Brand = ibInterbase) and (FConnMeta.ServerVersion < ivIB070500) then
        Result := Result +
          'RDB$SYSTEM_FLAG AS PROC_SCOPE, '
      else
        Result := Result +
          EncodeScope(NVL('RDB$SYSTEM_FLAG', '0', True), NVL('RDB$OWNER_NAME', '''''', False)) + ' AS PROC_SCOPE, ';
      Result := Result +
        'RDB$PROCEDURE_INPUTS AS IN_PARAMS, ' +
        'RDB$PROCEDURE_OUTPUTS AS OUT_PARAMS ' +
        'FROM RDB$PROCEDURES';
      if (oIBConnMeta.Brand = ibFirebird) and (FConnMeta.ServerVersion >= ivFB030000) then
        if ABaseObject <> '' then
          AddWhere('RDB$PACKAGE_NAME = ?', 'BAS')
        else
          AddWhere('RDB$PACKAGE_NAME IS NULL');
      AddTopScope(True);
      if AWildcard <> '' then
        AddWhere(EncodeRTrim('RDB$PROCEDURE_NAME') + ' LIKE ?', 'WIL');

      if (oIBConnMeta.Brand = ibFirebird) and (FConnMeta.ServerVersion >= ivFB030000) then begin
        lWasWhere := False;
        Result := Result + ' UNION ALL ' +
          'SELECT CAST(NULL AS NUMERIC) AS RECNO, ' +
          'CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, ' +
          'CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, ' +
          'RDB$PACKAGE_NAME AS PACK_NAME, ' +
          'RDB$FUNCTION_NAME AS PROC_NAME, ' +
          'CAST(NULL AS NUMERIC) AS OVERLOAD, ' +
          IntToStr(Integer(pkFunction)) + ' AS PROC_TYPE, ' +
          EncodeScope(NVL('RDB$SYSTEM_FLAG', '0', True), NVL('RDB$OWNER_NAME', '''''', False)) + ' AS PROC_SCOPE, ' +
          'CAST(NULL AS NUMERIC) AS IN_PARAMS, ' +
          'CAST(NULL AS NUMERIC) AS OUT_PARAMS ' +
          'FROM RDB$FUNCTIONS';
        if ABaseObject <> '' then
          AddWhere('RDB$PACKAGE_NAME = ?', 'BAS')
        else
          AddWhere('RDB$PACKAGE_NAME IS NULL');
        AddTopScope(True);
        if AWildcard <> '' then
          AddWhere(EncodeRTrim('RDB$FUNCTION_NAME') + ' LIKE ?', 'WIL');
      end;

      Result := Result + ' ORDER BY 5';
    end;

  mkProcArgs:
    begin
      Result := 'SELECT CAST(NULL AS NUMERIC) AS RECNO, ' +
        'CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, ' +
        'CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, ';
      if (oIBConnMeta.Brand = ibFirebird) and (FConnMeta.ServerVersion >= ivFB030000) then
        Result := Result +
          'P.RDB$PACKAGE_NAME AS PACK_NAME, '
      else
        Result := Result +
          'CAST(NULL AS VARCHAR(67)) AS PACK_NAME, ';
      Result := Result +
        'P.RDB$PROCEDURE_NAME AS PROC_NAME, ' +
        'CAST(NULL AS NUMERIC) AS OVERLOAD, ' +
        'P.RDB$PARAMETER_NAME AS PARAM_NAME, ' +
        'P.RDB$PARAMETER_NUMBER + 1 AS PARAM_POSITION, ' +
        'P.RDB$PARAMETER_TYPE + 1 AS PARAM_TYPE, ';
      if (oIBConnMeta.Brand = ibInterbase) and (FConnMeta.ServerVersion < ivIB070500) then
        Result := Result +
          'F.RDB$FIELD_TYPE AS PARAM_DATATYPE, ' +
          ''''' AS PARAM_TYPENAME, ' +
          '1 AS PARAM_ATTRIBUTES, '
      else
        Result := Result +
          EncodeDataType('F.RDB$FIELD_TYPE', 'F.RDB$FIELD_SUB_TYPE', 'F.RDB$FIELD_SCALE',
                         'F.RDB$CHARACTER_SET_ID', 'P.RDB$FIELD_SOURCE') + ' AS PARAM_DATATYPE, ' +
          EncodeTypeName('F.RDB$FIELD_TYPE', 'F.RDB$FIELD_SUB_TYPE', 'F.RDB$FIELD_SCALE',
                         'P.RDB$FIELD_SOURCE', '') + ' AS PARAM_TYPENAME, ' +
          EncodeAttrs('F.RDB$FIELD_TYPE', 'F.RDB$COMPUTED_SOURCE', 'F.RDB$DEFAULT_SOURCE',
                      'F.RDB$NULL_FLAG', '') + ' AS PARAM_ATTRIBUTES, ';
      Result := Result +
        'F.RDB$FIELD_PRECISION AS PARAM_PRECISION, ' +
        '- F.RDB$FIELD_SCALE AS PARAM_SCALE, ' +
        'F.RDB$CHARACTER_LENGTH AS PARAM_LENGTH ' +
        'FROM RDB$PROCEDURE_PARAMETERS P LEFT JOIN RDB$FIELDS F ON P.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME';
      if (oIBConnMeta.Brand = ibFirebird) and (FConnMeta.ServerVersion >= ivFB030000) then
        if ABaseObject <> '' then
          AddWhere('P.RDB$PACKAGE_NAME = ?', 'BAS')
        else
          AddWhere('P.RDB$PACKAGE_NAME IS NULL');
      AddWhere('P.RDB$PROCEDURE_NAME = ?', 'OBJ');
      if AWildcard <> '' then
        AddWhere(EncodeRTrim('P.RDB$PARAMETER_NAME') + ' LIKE ?', 'WIL');

      if (oIBConnMeta.Brand = ibFirebird) and (FConnMeta.ServerVersion >= ivFB030000) then begin
        lWasWhere := False;
        Result := Result + ' UNION ALL ' +
          'SELECT CAST(NULL AS NUMERIC) AS RECNO, ' +
          'CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, ' +
          'CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, ' +
          'P.RDB$PACKAGE_NAME AS PACK_NAME, ' +
          'P.RDB$FUNCTION_NAME AS PROC_NAME, ' +
          'CAST(NULL AS NUMERIC) AS OVERLOAD, ' +
          'CASE WHEN P.RDB$ARGUMENT_POSITION = 0 THEN ''Result'' ELSE P.RDB$ARGUMENT_NAME END AS PARAM_NAME, ' +
          'P.RDB$ARGUMENT_POSITION + 1 AS PARAM_POSITION, ' +
          'CASE WHEN P.RDB$ARGUMENT_POSITION = 0 THEN 4 ELSE 1 END AS PARAM_TYPE, ' +
          EncodeDataType('F.RDB$FIELD_TYPE', 'F.RDB$FIELD_SUB_TYPE', 'F.RDB$FIELD_SCALE',
                         'F.RDB$CHARACTER_SET_ID', 'P.RDB$FIELD_SOURCE') + ' AS PARAM_DATATYPE, ' +
          EncodeTypeName('F.RDB$FIELD_TYPE', 'F.RDB$FIELD_SUB_TYPE', 'F.RDB$FIELD_SCALE',
                         'P.RDB$FIELD_SOURCE', '') + ' AS PARAM_TYPENAME, ' +
          EncodeAttrs('F.RDB$FIELD_TYPE', 'F.RDB$COMPUTED_SOURCE', 'F.RDB$DEFAULT_SOURCE',
                      'F.RDB$NULL_FLAG', '') + ' AS PARAM_ATTRIBUTES, ' +
          'F.RDB$FIELD_PRECISION AS PARAM_PRECISION, ' +
          '- F.RDB$FIELD_SCALE AS PARAM_SCALE, ' +
          'F.RDB$CHARACTER_LENGTH AS PARAM_LENGTH ' +
          'FROM RDB$FUNCTION_ARGUMENTS P LEFT JOIN RDB$FIELDS F ON P.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME';
        if ABaseObject <> '' then
          AddWhere('P.RDB$PACKAGE_NAME = ?', 'BAS')
        else
          AddWhere('P.RDB$PACKAGE_NAME IS NULL');
        AddWhere('P.RDB$FUNCTION_NAME = ?', 'OBJ');
        if AWildcard <> '' then
          AddWhere(EncodeRTrim('P.RDB$ARGUMENT_NAME') + ' LIKE ?', 'WIL');
      end;

      Result := Result + ' ORDER BY 9, 8';
    end;

  mkGenerators:
    begin
      Result := 'SELECT CAST(NULL AS NUMERIC) AS RECNO, ' +
        'CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, ' +
        'CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, ' +
        'RDB$GENERATOR_NAME AS GENERATOR_NAME, ';
      if (oIBConnMeta.Brand = ibInterbase) and (FConnMeta.ServerVersion < ivIB070500) then
        Result := Result +
          'RDB$SYSTEM_FLAG AS GENERATOR_SCOPE '
      else
        Result := Result +
          EncodeScope(NVL('RDB$SYSTEM_FLAG', '0', True), '') + ' AS GENERATOR_SCOPE ';
      Result := Result +
        'FROM RDB$GENERATORS';
      AddTopScope(False);
      if (oIBConnMeta.Brand = ibFirebird) and (FConnMeta.ServerVersion >= ivFB030000) then
        AddWhere('RDB$SYSTEM_FLAG <> 6');
      if AWildcard <> '' then
        AddWhere(EncodeRTrim('RDB$GENERATOR_NAME') + ' LIKE ?', 'WIL');
      Result := Result + ' ORDER BY 4';
    end;

  mkResultSetFields:
    begin
      Result :=
        'SELECT CAST(NULL AS NUMERIC) AS RECNO, CAST(' + QuotedStr(AObject) + ' AS VARCHAR(1024)) AS RESULTSET_KEY, ' +
          'RF.RDB$RELATION_NAME AS TABLE_NAME, RF.RDB$FIELD_NAME AS COLUMN_NAME, RF.RDB$FIELD_SOURCE AS DOMAIN_NAME, ' +
          'S.RDB$FIELD_POSITION AS IN_PKEY, G1.RDB$DEPENDED_ON_NAME AS GENERATOR_NAME, ';
      if (oIBConnMeta.Brand = ibInterbase) and (FConnMeta.ServerVersion < ivIB070500) then
        Result := Result +
          'F.RDB$COMPUTED_SOURCE AS ISCOMPUTED, ' +
          'RF.RDB$DEFAULT_SOURCE AS HASDEFAULT'
      else
        Result := Result +
          'CASE WHEN F.RDB$COMPUTED_SOURCE IS NULL THEN 0 ELSE 1 END AS ISCOMPUTED, ' +
          'CASE WHEN RF.RDB$DEFAULT_SOURCE IS NULL THEN 0 ELSE 1 END AS HASDEFAULT';
      if (oIBConnMeta.Brand = ibFirebird) and (FConnMeta.ServerVersion >= ivFB030000) then
        Result := Result +
          ', RF.RDB$IDENTITY_TYPE AS IDENT_TYPE';
      Result := Result +
        ' FROM RDB$RELATION_FIELDS RF ' +
          'LEFT JOIN RDB$FIELDS F ON ' +
            'RF.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME ' +
          'LEFT OUTER JOIN RDB$RELATION_CONSTRAINTS C ON ' +
            'RF.RDB$RELATION_NAME = C.RDB$RELATION_NAME AND C.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' ' +
          'LEFT OUTER JOIN RDB$INDEX_SEGMENTS S ON ' +
            'RF.RDB$FIELD_NAME = S.RDB$FIELD_NAME AND C.RDB$INDEX_NAME = S.RDB$INDEX_NAME ' +
          'LEFT OUTER JOIN RDB$DEPENDENCIES C1 ON ' +
            'C1.RDB$DEPENDED_ON_NAME = RF.RDB$RELATION_NAME AND C1.RDB$FIELD_NAME = RF.RDB$FIELD_NAME AND ' +
            'C1.RDB$DEPENDENT_TYPE = 2 AND C1.RDB$DEPENDED_ON_TYPE = 0 ' +
          'LEFT OUTER JOIN RDB$DEPENDENCIES G1 ON G1.RDB$DEPENDENT_NAME = C1.RDB$DEPENDENT_NAME AND EXISTS ( ' +
            'SELECT 1 ' +
            'FROM RDB$DEPENDENCIES G ' +
            'WHERE G.RDB$DEPENDENT_NAME = G1.RDB$DEPENDENT_NAME ' +
            'GROUP BY G.RDB$DEPENDENT_NAME, G.RDB$DEPENDENT_TYPE ' +
            'HAVING COUNT(*) = 2 ' +
          ') AND G1.RDB$DEPENDENT_TYPE = 2 AND G1.RDB$DEPENDED_ON_TYPE = ';
      if oIBConnMeta.Brand = ibInterbase then
        Result := Result + '11'
      else
        Result := Result + '14';
      if Pos(',', AObject) = 0 then
        AddWhere('RF.RDB$RELATION_NAME = ?', 'OBJ')
      else
        AddWhere('RF.RDB$RELATION_NAME IN (' + AObject + ')');
    end;

  mkTableTypeFields:
    ;

  else
    Result := '';
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBCommandGenerator.GetLimitSelect(const ASQL: String;
  ASkip, ARows: Integer): String;
var
  oIBConnMeta: IFDPhysIBConnectionMetadata;
begin
  Supports(FConnMeta, IFDPhysIBConnectionMetadata, oIBConnMeta);
  if (oIBConnMeta.Brand in [ibFirebird, ibYaffil]) and (FConnMeta.ServerVersion >= ivFB020000) or
     (oIBConnMeta.Brand = ibInterbase) then
    if ASkip > 0 then
      Result := ASQL + BRK + 'ROWS ' + IntToStr(ASkip + 1) + ' TO ' + IntToStr(ASkip + ARows)
    else if ARows >= 0 then
      Result := ASQL + BRK + 'ROWS ' + IntToStr(ARows)
    else
      Result := ASQL
  else
    Result := ASQL;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBCommandGenerator.GetCountSelect(const ASQL: String): String;
var
  oIBConnMeta: IFDPhysIBConnectionMetadata;
begin
  Supports(FConnMeta, IFDPhysIBConnectionMetadata, oIBConnMeta);
  if not ((oIBConnMeta.Brand = ibFirebird) or
          (oIBConnMeta.Brand = ibInterbase) and (FConnMeta.ServerVersion >= ivIB120100)) then
    FDCapabilityNotSupported(Self, [S_FD_LPhys, S_FD_IBId]);
  Result := inherited GetCountSelect(ASQL);
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBCommandGenerator.GetColumnType(AColumn: TFDDatSColumn): String;
var
  oIBConnMeta: IFDPhysIBConnectionMetadata;
begin
  case AColumn.DataType of
  dtBoolean:
    begin
      Supports(FConnMeta, IFDPhysIBConnectionMetadata, oIBConnMeta);
      if (oIBConnMeta.Brand = ibFirebird) and (FConnMeta.ServerVersion >= ivFB030000) or
         (oIBConnMeta.Brand = ibInterbase) and (FConnMeta.ServerVersion >= ivIB090000) then
        Result := 'BOOLEAN'
      else
        Result := 'SMALLINT';
    end;
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
    Result := 'INT64';
  dtSingle:
    Result := 'FLOAT';
  dtDouble,
  dtExtended:
    Result := 'DOUBLE PRECISION';
  dtCurrency:
    Result := 'DECIMAL' + GetColumnDim(-1, AColumn.Precision, AColumn.Scale, -1, 18, 4);
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
  dtAnsiString,
  dtWideString,
  dtByteString:
    begin
      if caFixedLen in AColumn.ActualAttributes then
        Result := 'CHAR'
      else
        Result := 'VARCHAR';
      Result := Result + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1);
      case AColumn.DataType of
      dtWideString: Result := Result + ' CHARACTER SET UNICODE_FSS';
      dtByteString: Result := Result + ' CHARACTER SET OCTETS';
      end;
    end;
  dtBlob,
  dtHBlob,
  dtHBFile:
    Result := 'BLOB(2000,0)';
  dtMemo,
  dtWideMemo,
  dtXML,
  dtHMemo,
  dtWideHMemo:
    Result := 'BLOB(2000,1)';
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
  if Result <> '' then
    if caAutoInc in AColumn.ActualAttributes then begin
      Supports(FConnMeta, IFDPhysIBConnectionMetadata, oIBConnMeta);
      if (oIBConnMeta.Brand = ibFirebird) and (FConnMeta.ServerVersion >= ivFB030000) then
        Result := Result + ' GENERATED BY DEFAULT AS IDENTITY'
      else
        FFlags := FFlags + [gfCreateIdentityTrigger, gfCreateIdentityGenerator];
    end
    else if caExpr in AColumn.ActualAttributes then
      Result := Result + ' COMPUTED BY (' + AColumn.Expression + ')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBCommandGenerator.GetCreateGenerator(const AName: String): String;
var
  rName: TFDPhysParsedName;
begin
  rName.FCatalog := '';
  rName.FSchema := '';
  rName.FBaseObject := '';
  rName.FObject := AName;
  Result := 'CREATE GENERATOR ' + FConnMeta.EncodeObjName(rName, nil, [eoQuote, eoNormalize]);
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBCommandGenerator.GetDropGenerator(const AName: String): String;
var
  rName: TFDPhysParsedName;
begin
  rName.FCatalog := '';
  rName.FSchema := '';
  rName.FBaseObject := '';
  rName.FObject := AName;
  Result := 'DROP GENERATOR ' + FConnMeta.EncodeObjName(rName, nil, [eoQuote, eoNormalize]);
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBCommandGenerator.GetCreateIdentityTrigger: String;
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
        Result := IND + 'IF (NEW.' + sCol + ' IS NULL) THEN' + BRK +
                  IND + 'BEGIN' + BRK +
                  IND + IND + 'NEW.' + sCol + ' = GEN_ID(' + sGen + ', 1);' + BRK +
                  IND + 'END' + BRK;
      end;
    end;
  end;
  if Result <> '' then begin
    sTab := GetFrom;
    FConnMeta.DecodeObjName(sTab, rName, nil, [doUnquote]);
    rName.FObject := 'TR_' + rName.FObject + '_BI';
    Result := 'CREATE TRIGGER ' + FConnMeta.EncodeObjName(rName, nil, [eoQuote, eoNormalize]) + ' FOR ' + sTab + BRK +
      'ACTIVE BEFORE INSERT POSITION 0' + BRK +
      'AS' + BRK +
      'BEGIN' + BRK +
      Result +
      'END' + BRK;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBCommandGenerator.GetMerge(AAction: TFDPhysMergeAction): String;
var
  oIBConnMeta: IFDPhysIBConnectionMetadata;
begin
  Supports(FConnMeta, IFDPhysIBConnectionMetadata, oIBConnMeta);
  if not ((oIBConnMeta.Brand = ibFirebird) and (FConnMeta.ServerVersion >= ivFB020100)) then
    FDCapabilityNotSupported(Self, [S_FD_LPhys]);
  Result := inherited GetMerge(AAction);
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterRDBMSKind(TFDRDBMSKinds.Interbase, S_FD_IB_RDBMS);
  FDPhysManager().RegisterRDBMSKind(TFDRDBMSKinds.Firebird, S_FD_FB_RDBMS);

end.
