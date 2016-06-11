{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{              FireDAC Informix metadata                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.InfxMeta;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.Meta, FireDAC.Phys.SQLGenerator;

type
  TFDPhysInfxMetadata = class (TFDPhysConnectionMetadata)
  private
    FTxSupported: Boolean;
  protected
    function GetKind: TFDRDBMSKind; override;
    function GetIdentityInsertSupported: Boolean; override;
    function GetCatalogSeparator: Char; override;
    function GetGeneratorSupported: Boolean; override;
    function GetTxSupported: Boolean; override;
    function GetTxSavepoints: Boolean; override;
    function GetEventSupported: Boolean; override;
    function GetEventKinds: String; override;
    function GetParamNameMaxLength: Integer; override;
    function GetNameParts: TFDPhysNameParts; override;
    function GetNameDefLowCaseParts: TFDPhysNameParts; override;
    function GetNameCaseSensParts: TFDPhysNameParts; override;
    function GetDefValuesSupported: TFDPhysDefaultValues; override;
    function GetSelectOptions: TFDPhysSelectOptions; override;
    function GetAsyncAbortSupported: Boolean; override;
    function GetAsyncNativeTimeout: Boolean; override;
    function GetArrayExecMode: TFDPhysArrayExecMode; override;
    function GetLimitOptions: TFDPhysLimitOptions; override;
    function GetColumnOriginProvided: Boolean; override;
    function InternalEscapeBoolean(const AStr: String): String; override;
    function InternalEscapeDate(const AStr: String): String; override;
    function InternalEscapeDateTime(const AStr: String): String; override;
    function InternalEscapeFloat(const AStr: String): String; override;
    function InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String; override;
    function InternalEscapeTime(const AStr: String): String; override;
    function InternalGetSQLCommandKind(const ATokens: TStrings): TFDPhysCommandKind; override;
  public
    constructor Create(const AConnectionObj: TFDPhysConnection;
      AServerVersion, AClientVersion: TFDVersion; const ACSVKeywords: String;
      AIsUnicode, ATxSupported: Boolean);
  end;

  TFDPhysInfxCommandGenerator = class(TFDPhysCommandGenerator)
  protected
    function GetIdentity(ASessionScope: Boolean): String; override;
    function GetReadGenerator(const AName, AAlias: String;
      ANextValue, AFullSelect: Boolean): String; override;
    function GetSingleRowTable: String; override;
    function GetRowId(var AAlias: String): String; override;
    function GetPessimisticLock: String; override;
    function GetSavepoint(const AName: String): String; override;
    function GetRollbackToSavepoint(const AName: String): String; override;
    function GetCommitSavepoint(const AName: String): String; override;
    function GetCall(const AName: String): String; override;
    function GetLimitSelect(const ASQL: String; ASkip, ARows: Integer): String; override;
    function GetColumnType(AColumn: TFDDatSColumn): String; override;
  end;

implementation

uses
  System.SysUtils,
  FireDAC.Stan.Consts, FireDAC.Stan.Util;

{-------------------------------------------------------------------------------}
{ TFDPhysInfxMetadata                                                           }
{-------------------------------------------------------------------------------}
constructor TFDPhysInfxMetadata.Create(const AConnectionObj: TFDPhysConnection;
  AServerVersion, AClientVersion: TFDVersion; const ACSVKeywords: String;
  AIsUnicode, ATxSupported: Boolean);
begin
  inherited Create(AConnectionObj, AServerVersion, AClientVersion, AIsUnicode);
  if ACSVKeywords <> '' then
    FKeywords.CommaText := ACSVKeywords;
  FTxSupported := ATxSupported;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.Informix;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetIdentityInsertSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetNameCaseSensParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetNameDefLowCaseParts: TFDPhysNameParts;
begin
  Result := [npCatalog, npSchema, npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetParamNameMaxLength: Integer;
begin
  Result := 128;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetNameParts: TFDPhysNameParts;
begin
  Result := [npCatalog, npSchema, npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetCatalogSeparator: Char;
begin
  Result := ':';
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetTxSupported: Boolean;
begin
  Result := FTxSupported;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetTxSavepoints: Boolean;
begin
  Result := FTxSupported;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetEventSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetEventKinds: String;
begin
  Result := S_FD_EventKind_Infx_DBMS_ALERT;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetGeneratorSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetDefValuesSupported: TFDPhysDefaultValues;
begin
  Result := dvNone;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetSelectOptions: TFDPhysSelectOptions;
begin
  Result := [soInlineView];
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetAsyncAbortSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetAsyncNativeTimeout: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetArrayExecMode: TFDPhysArrayExecMode;
begin
  Result := aeCollectAllErrors;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetLimitOptions: TFDPhysLimitOptions;
begin
  Result := [loSkip, loRows];
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.GetColumnOriginProvided: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.InternalEscapeBoolean(const AStr: String): String;
begin
  if CompareText(AStr, S_FD_True) = 0 then
    Result := '''t'''
  else
    Result := '''f''';
  Result := 'CAST(' + Result + ' AS BOOLEAN)';
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.InternalEscapeDate(const AStr: String): String;
begin
  Result := 'DATE(' + InternalEscapeDateTime(AStr) + ')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.InternalEscapeDateTime(const AStr: String): String;
begin
  if Pos(':', AStr) = 0 then
    Result := 'TO_DATE(' + AnsiQuotedStr(AStr + ' 00:00:00', '''')
  else
    Result := 'TO_DATE(' + AnsiQuotedStr(AStr, '''');
  Result := Result + ', ''%Y-%m-%d %H:%M:%S'')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.InternalEscapeTime(const AStr: String): String;
begin
  Result := 'TO_DATE(' + AnsiQuotedStr(AStr, '''') + ', ''%T'')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.InternalEscapeFloat(const AStr: String): String;
begin
  Result := AStr;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String;
var
  sName: String;
  A1, A2, A3, A4: String;
  rSeq: TFDPhysEscapeData;

  function AddArgs: string;
  begin
    Result := '(' + AddEscapeSequenceArgs(ASeq) + ')';
  end;

begin
  sName := ASeq.FName;
  if Length(ASeq.FArgs) >= 1 then begin
    A1 := ASeq.FArgs[0];
    if Length(ASeq.FArgs) >= 2 then begin
      A2 := ASeq.FArgs[1];
      if Length(ASeq.FArgs) >= 3 then
        A3 := ASeq.FArgs[2];
        if Length(ASeq.FArgs) >= 4 then
          A4 := ASeq.FArgs[3];
    end;
  end;

  case ASeq.FFunc of
  // the same
  // char
  efASCII,
  efCHAR_LENGTH,
  efCONCAT,
  efLEFT,
  efLENGTH,
  efLTRIM,
  efOCTET_LENGTH,
  efREPLACE,
  efRIGHT,
  efRTRIM,
  efSPACE,
  // numeric
  efACOS,
  efASIN,
  efATAN,
  efATAN2,
  efABS,
  efCOS,
  efDEGREES,
  efEXP,
  efFLOOR,
  efLOG10,
  efMOD,
  efRADIANS,
  efROUND,
  efSIN,
  efSQRT,
  efTAN,
  // date and time
  efMONTH,
  efYEAR:        Result := sName + AddArgs;
  // character
  efCHAR:        Result := 'CHR' + AddArgs;
  efBIT_LENGTH:  Result := '(OCTET_LENGTH(' + A1 + ') * 8)';
  efINSERT:      Result := '(SUBSTR(' + A1 + ', 1, (' + A2 + ') - 1) || ' + A4 +
                  ' || SUBSTR(' + A1 + ', (' + A2 + ' + ' + A3 + ')))';
  efLCASE:       Result := 'LOWER' + AddArgs;
  efLOCATE:      Result := 'INSTR(' + A2 + ', ' + A1 + ', ' + A3 + ')';
  efPOSITION:    Result := 'INSTR(' + A2 + ', ' + A1 + ')';
  efREPEAT:      Result := 'RPAD(' + A1 + ', (' + A2 + ') * LENGTH(' + A1 + '), ' + A1 + ')';
  efSUBSTRING:   Result := 'SUBSTR' + AddArgs;
  efUCASE:       Result := 'UPPER' + AddArgs;
  // numeric
  efCEILING:     Result := 'CEIL' + AddArgs;
  efCOT:         Result := '(1 / TAN(' + A1 + '))';
  efLOG:         Result := 'LOGN' + AddArgs;
  efPOWER:       Result := 'POW' + AddArgs;
  efSIGN:        Result := 'CASE WHEN ' + A1 + ' > 0 THEN 1 WHEN ' + A1 + ' < 0 THEN -1 ELSE 0 END';
  efTRUNCATE:    Result := 'TRUNC' + AddArgs;
  efPI:          Result := S_FD_Pi;
  efRANDOM:      Result := 'dbms_random_random()';
  // date and time
  efCURDATE:     Result := 'CURRENT YEAR TO DAY';
  efCURTIME:     Result := 'CURRENT HOUR TO FRACTION';
  efDAYNAME:     Result := 'TO_CHAR(' + A1 + ', ''%A'')';
  efDAYOFMONTH:  Result := 'DAY' + AddArgs;
  efDAYOFWEEK:   Result := '(WEEKDAY(' + A1 + ') + 1)';
  efDAYOFYEAR:   Result := '(DATE(' + A1 + ') - MDY(1, 1, YEAR(' + A1 + ')) + 1)';
  efHOUR:        Result := 'TO_NUMBER(TO_CHAR(' + A1 + ', ''%H''))';
  efMINUTE:      Result := 'TO_NUMBER(TO_CHAR(' + A1 + ', ''%M''))';
  efMONTHNAME:   Result := 'TO_CHAR(' + A1 + ', ''%B'')';
  efQUARTER:     Result := 'TRUNC(MONTH(' + A1 + ') / 3 + 1)';
  efSECOND:      Result := 'TO_NUMBER(TO_CHAR(' + A1 + ', ''%S''))';
  efNOW:         Result := 'CURRENT';
  efEXTRACT:
    begin
      rSeq.FKind := eskFunction;
      A1 := UpperCase(FDUnquote(Trim(A1), ''''));
      if A1 = 'DAY' then
        A1 := 'DAYOFMONTH';
      rSeq.FName := A1;
      SetLength(rSeq.FArgs, 1);
      rSeq.FArgs[0] := ASeq.FArgs[1];
      EscapeFuncToID(rSeq);
      Result := InternalEscapeFunction(rSeq);
    end;
  efTIMESTAMPADD:
    begin
      A1 := UpperCase(FDUnquote(Trim(A1), ''''));
      if A1 = 'YEAR' then
        Result := 'ADD_MONTHS(' + A3 + ', 12 * (' + A2 + '))'
      else if A1 = 'MONTH' then
        Result := 'ADD_MONTHS(' + A3 + ', ' + A2 + ')'
      else if A1 = 'WEEK' then
        Result := '(' + A3 + ' + INTERVAL (' + IntToStr(StrToInt(A2) * 7) + ') DAY TO DAY)'
      else if A1 = 'DAY' then
        Result := '(' + A3 + ' + INTERVAL (' + A2 + ') DAY TO DAY)'
      else if A1 = 'HOUR' then
        Result := '(' + A3 + ' + INTERVAL (' + A2 + ') HOUR TO HOUR)'
      else if A1 = 'MINUTE' then
        Result := '(' + A3 + ' + INTERVAL (' + A2 + ') MINUTE TO MINUTE)'
      else if A1 = 'SECOND' then
        Result := '(' + A3 + ' + INTERVAL (' + A2 + ') SECOND TO SECOND)'
      else if A1 = 'FRAC_SECOND' then
        Result := '(' + A3 + ' + INTERVAL (' + A2 + ') FRACTION TO FRACTION)'
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
        Result := 'TRUNC((DATE(' + A3 + ') - DATE(' + A2 + ')) / 7)'
      else if A1 = 'DAY' then
        Result := '(DATE(' + A3 + ') - DATE(' + A2 + '))'
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
  // system
  efCATALOG:     Result := 'DBINFO(''dbname'')';
  efSCHEMA:      Result := 'USER';
  efIFNULL:      Result := 'NVL' + AddArgs;
  efIF:          Result := 'CASE WHEN ' + A1 + ' THEN ' + A2 + ' ELSE ' + A3 + ' END';
  efDECODE:      Result := sName + AddArgs;
  // convert
  efCONVERT:
    begin
      A2 := UpperCase(FDUnquote(Trim(A2), ''''));
      if (A2 = 'LONGVARCHAR') or (A2 = 'WLONGVARCHAR') then
        A2 := 'LVARCHAR'
      else if A2 = 'WCHAR' then
        A2 := 'NCHAR'
      else if A2 = 'WVARCHAR' then
        A2 := 'NVARCHAR'
      else if (A2 = 'TIMESTAMP') or (A2 = 'DATETIME') then
        A2 := 'DATETIME YEAR TO FRACTION'
      else if A2 = 'DATE' then
        A2 := 'DATETIME YEAR TO DAY'
      else if A2 = 'TIME' then
        A2 := 'DATETIME HOUR TO FRACTION'
      else if A2 = 'DOUBLE' then
        A2 := 'DOUBLE PRECISION'
      else if A2 = 'TINYINT' then
        A2 := 'SMALLINT'
      else if A2 = 'SMALLINT' then
        A2 := 'INTEGER'
      else if (A2 = 'VARBINARY') or (A2 = 'BINARY') or (A2 = 'LONGVARBINARY') then
        A2 := 'BYTE'
      else if not ((A2 = 'NUMERIC') or (A2 = 'DECIMAL') or
                   (A2 = 'REAL') or (A2 = 'FLOAT') or (A2 = 'BIGINT') or
                   (A2 = 'CHAR') or (A2 = 'VARCHAR') or (A2 = 'INTEGER')) then
        UnsupportedEscape(ASeq);
      Result := 'CAST(' + A1 + ' AS ' + A2 + ')';
    end;
  else
    UnsupportedEscape(ASeq);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxMetadata.InternalGetSQLCommandKind(
  const ATokens: TStrings): TFDPhysCommandKind;
var
  sToken: String;
begin
  sToken := ATokens[0];
  if sToken = 'EXECUTE' then
    Result := skExecute
  else if sToken = 'BEGIN' then
    Result := skStartTransaction
  else
    Result := inherited InternalGetSQLCommandKind(ATokens);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysInfxCommandGenerator                                                   }
{-------------------------------------------------------------------------------}
function TFDPhysInfxCommandGenerator.GetIdentity(ASessionScope: Boolean): String;
begin
  Result := 'DBINFO(''sqlca.sqlerrd1'')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxCommandGenerator.GetReadGenerator(const AName,
  AAlias: String; ANextValue, AFullSelect: Boolean): String;
begin
  if AName <> '' then begin
    Result := AName;
    if ANextValue then
      Result := Result + '.NEXTVAL'
    else
      Result := Result + '.CURRVAL';
  end
  else
    Result := GetIdentity(True);
  if AAlias <> '' then
    Result := Result + ' ' + AAlias;
  if AFullSelect then
    Result := 'SELECT ' + Result + BRK + 'FROM ' + GetSingleRowTable;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxCommandGenerator.GetSingleRowTable: String;
begin
  Result := 'SYSMASTER:"informix".SYSDUAL';
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxCommandGenerator.GetRowId(var AAlias: String): String;
begin
  Result := 'ROWID';
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxCommandGenerator.GetPessimisticLock: String;
var
  lNeedFrom: Boolean;
begin
  Result := Result + 'SELECT ' + GetSelectList(True, False, lNeedFrom) + BRK +
    'FROM ' + GetFrom + BRK + 'WHERE ' + GetWhere(False, True, False) + BRK +
    'FOR UPDATE';
  FCommandKind := skSelectForLock;
  ASSERT(lNeedFrom);
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxCommandGenerator.GetSavepoint(const AName: String): String;
begin
  Result := 'SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxCommandGenerator.GetRollbackToSavepoint(const AName: String): String;
begin
  Result := 'ROLLBACK TO SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxCommandGenerator.GetCommitSavepoint(const AName: String): String;
begin
  Result := 'RELEASE SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxCommandGenerator.GetCall(const AName: String): String;
begin
  Result := 'EXECUTE PROCEDURE ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxCommandGenerator.GetLimitSelect(const ASQL: String;
  ASkip, ARows: Integer): String;

  function GetLimit: String;
  begin
    if (ASkip > 0) and (ARows + ASkip <> MAXINT) then
      Result := 'SKIP ' + IntToStr(ASkip) + ' FIRST ' + IntToStr(ARows)
    else if ASkip > 0 then
      Result := 'SKIP ' + IntToStr(ASkip)
    else if ARows >= 0 then
      Result := 'FIRST ' + IntToStr(ARows)
    else
      Result := '';
  end;

var
  s: String;
begin
  // SKIP N FIRST M
  if (ASkip + ARows <> MAXINT) and
     (CompareText(Copy(ASQL, 1, 6), 'SELECT') = 0) and
     (CompareText(Copy(ASQL, 1, 11), 'SELECT SKIP') <> 0) and
     (CompareText(Copy(ASQL, 1, 12), 'SELECT FIRST') <> 0) and
     (CompareText(Copy(ASQL, 1, 12), 'SELECT LIMIT') <> 0) then begin
    s := UpperCase(ASQL);
    // Informix: does not support FIRST 0 and returns "syntax error"
    if ARows = 0 then
      Result := 'SELECT * FROM (' + BRK + ASQL + BRK + ') A' + BRK + 'WHERE 0 = 1'
    else if HasKW(s, 'UNION') or HasKW(s, 'MINUS') or HasKW(s, 'INTERSECT') or HasKW(s, 'EXCEPT') then
      Result := 'SELECT ' + GetLimit + ' * FROM (' + BRK + ASQL + BRK + ') A'
    else if CompareText(Copy(ASQL, 1, 15), 'SELECT DISTINCT') = 0 then
      Result := 'SELECT ' + GetLimit + ' DISTINCT ' + Copy(ASQL, 16, MAXINT)
    else
      Result := 'SELECT ' + GetLimit + Copy(ASQL, 7, MAXINT);
  end
  else
    Result := ASQL;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxCommandGenerator.GetColumnType(AColumn: TFDDatSColumn): String;
begin
  if caAutoInc in AColumn.ActualAttributes then begin
    if AColumn.DataType in [dtSByte, dtInt16, dtInt32, dtByte, dtUInt16] then
      Result := 'SERIAL'
    else
      Result := 'SERIAL8';
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
    Result := 'INT8';
  dtSingle:
    Result := 'SMALLFLOAT';
  dtDouble,
  dtExtended:
    Result := 'FLOAT';
  dtCurrency:
    Result := 'MONEY' + GetColumnDim(-1, AColumn.Precision, AColumn.Scale, -1, 18, 4);
  dtBCD,
  dtFmtBCD:
    Result := 'DECIMAL' + GetColumnDim(-1, AColumn.Precision, AColumn.Scale, -1,
      FOptions.FormatOptions.MaxBcdPrecision, FOptions.FormatOptions.MaxBcdScale);
  dtDateTime,
  dtDateTimeStamp:
    Result := 'DATETIME YEAR TO FRACTION';
  dtTime:
    Result := 'DATETIME HOUR TO FRACTION';
  dtDate:
    Result := 'DATE';
  dtTimeIntervalYM:
    Result := 'INTERVAL YEAR TO MONTH';
  dtTimeIntervalFull,
  dtTimeIntervalDS:
    Result := 'INTERVAL DAY TO FRACTION';
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
  dtByteString,
  dtBlob:
    Result := 'BYTE';
  dtMemo,
  dtWideMemo,
  dtXML:
    Result := 'TEXT';
  dtHMemo,
  dtWideHMemo:
    Result := 'CLOB';
  dtHBlob,
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
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterRDBMSKind(TFDRDBMSKinds.Informix, S_FD_Infx_RDBMS);

end.
