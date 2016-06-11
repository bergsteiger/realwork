{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{       FireDAC Adaptive Server Anywhere metadata       }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.ASAMeta;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys.Meta, FireDAC.Phys.SQLGenerator, FireDAC.Phys;

type
  TFDPhysASAMetadata = class (TFDPhysConnectionMetadata)
  protected
    function GetKind: TFDRDBMSKind; override;
    function GetTxSavepoints: Boolean; override;
    function GetEventKinds: String; override;
    function GetEventSupported: Boolean; override;
    function GetParamNameMaxLength: Integer; override;
    function GetNameParts: TFDPhysNameParts; override;
    function GetNameQuotedCaseSensParts: TFDPhysNameParts; override;
    function GetNameCaseSensParts: TFDPhysNameParts; override;
    function GetNameDefLowCaseParts: TFDPhysNameParts; override;
    function GetIdentityInsertSupported: Boolean; override;
    function GetDefValuesSupported: TFDPhysDefaultValues; override;
    function GetAsyncAbortSupported: Boolean; override;
    function GetLimitOptions: TFDPhysLimitOptions; override;
    function GetSelectOptions: TFDPhysSelectOptions; override;
    function GetBackslashEscSupported: Boolean; override;
    function InternalEscapeBoolean(const AStr: String): String; override;
    function InternalEscapeDate(const AStr: String): String; override;
    function InternalEscapeDateTime(const AStr: String): String; override;
    function InternalEscapeFloat(const AStr: String): String; override;
    function InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String; override;
    function InternalEscapeTime(const AStr: String): String; override;
    function InternalGetSQLCommandKind(const ATokens: TStrings): TFDPhysCommandKind; override;
  public
    constructor Create(const AConnectionObj: TFDPhysConnection;
      AServerVersion, AClientVerison: TFDVersion; const ACSVKeywords: String);
  end;

  TFDPhysASACommandGenerator = class(TFDPhysCommandGenerator)
  protected
    function GetIdentity(ASessionScope: Boolean): String; override;
    function GetPessimisticLock: String; override;
    function GetSavepoint(const AName: String): String; override;
    function GetRollbackToSavepoint(const AName: String): String; override;
    function GetCall(const AName: String): String; override;
    function GetLimitSelect(const ASQL: String; ASkip, ARows: Integer): String; override;
    function GetColumnType(AColumn: TFDDatSColumn): String; override;
    function GetMerge(AAction: TFDPhysMergeAction): String; override;
  end;

implementation

uses
  System.SysUtils,
  FireDAC.Stan.Consts, FireDAC.Stan.Util;

{-------------------------------------------------------------------------------}
{ TFDPhysOraMetadata                                                            }
{-------------------------------------------------------------------------------}
constructor TFDPhysASAMetadata.Create(const AConnectionObj: TFDPhysConnection;
  AServerVersion, AClientVerison: TFDVersion; const ACSVKeywords: String);
var
  i: Integer;
begin
  inherited Create(AConnectionObj, AServerVersion, AClientVerison, False);
  if ACSVKeywords <> '' then begin
    FKeywords.CommaText := ACSVKeywords;
    // Early ASA ODBC drivers erroneously return 'DBA' as a keyword.
    // But really it is not a keyword and may be used as identifier.
    i := FKeywords.IndexOf('dba');
    if i >= 0 then
      FKeywords.Delete(i);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.GetKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.SQLAnywhere;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.GetNameQuotedCaseSensParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.GetNameCaseSensParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.GetNameDefLowCaseParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.GetParamNameMaxLength: Integer;
begin
  Result := 128;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.GetNameParts: TFDPhysNameParts;
begin
  Result := [npSchema, npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.GetTxSavepoints: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.GetEventSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.GetEventKinds: String;
begin
  Result := S_FD_EventKind_ASA_Events;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.GetIdentityInsertSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.GetDefValuesSupported: TFDPhysDefaultValues;
begin
  Result := dvDef;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.GetAsyncAbortSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.GetLimitOptions: TFDPhysLimitOptions;
begin
  if GetServerVersion >= cvSybaseASA9 then
    Result := [loSkip, loRows]
  else
    Result := [loRows];
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.GetSelectOptions: TFDPhysSelectOptions;
begin
  Result := [soWithoutFrom, soInlineView];
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.GetBackslashEscSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.InternalEscapeBoolean(const AStr: String): String;
begin
  if CompareText(AStr, S_FD_True) = 0 then
    Result := '1'
  else
    Result := '0';
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.InternalEscapeDate(const AStr: String): String;
begin
  Result := 'CONVERT(DATETIME, ' + AnsiQuotedStr(AStr, '''') + ', 20)';
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.InternalEscapeDateTime(const AStr: String): String;
begin
  Result := 'CONVERT(DATETIME, ' + AnsiQuotedStr(AStr, '''') + ', 20)';
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.InternalEscapeTime(const AStr: String): String;
begin
  Result := 'CONVERT(DATETIME, ' + AnsiQuotedStr(AStr, '''') + ', 114)';
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.InternalEscapeFloat(const AStr: String): String;
begin
  Result := AStr;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String;
var
  sName: String;
  A1, A2, A3: String;
  rSeq: TFDPhysEscapeData;
  i: Integer;

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
    end;
  end;
  case ASeq.FFunc of
  // the same
  // char
  efASCII,
  efCHAR,
  efLEFT,
  efLTRIM,
  efREPLACE,
  efRIGHT,
  efRTRIM,
  efSPACE,
  efSUBSTRING,
  // numeric
  efACOS,
  efASIN,
  efATAN,
  efABS,
  efCEILING,
  efCOS,
  efCOT,
  efDEGREES,
  efEXP,
  efFLOOR,
  efLOG,
  efLOG10,
  efPOWER,
  efPI,
  efSIGN,
  efSIN,
  efSQRT,
  efTAN:         Result := sName + AddArgs;
  // character
  efBIT_LENGTH:  Result := '(LENGTH(' + A1 + ') * 8)';
  efCHAR_LENGTH: Result := 'LENGTH' + AddArgs;
  efCONCAT:      Result := '(' + A1 + ' + ' + A2 + ')';
  efINSERT:      Result := 'STUFF' + AddArgs;
  efLCASE:       Result := 'LOWER' + AddArgs;
  efLENGTH:      Result := 'LENGTH(RTRIM(' + A1 + '))';
  efLOCATE:
    begin
      Result := 'LOCATE(' + A2 + ', ' + A1;
      if A3 <> '' then
        Result := Result + ', ' + A3;
      Result := Result + ')';
    end;
  efOCTET_LENGTH:Result := 'LENGTH' + AddArgs;
  efPOSITION:    Result := 'CHARINDEX' + AddArgs;
  efREPEAT:      Result := 'REPLICATE' + AddArgs;
  efUCASE:       Result := 'UPPER' + AddArgs;
  // numeric
  efRANDOM:      Result := 'RAND' + AddArgs;
  efTRUNCATE:    Result := 'CAST(' + A1 + ' AS BIGINT)';
  efATAN2:       Result := 'ATN2' + AddArgs;
  efMOD:         Result := 'MOD' + AddArgs;
  efROUND:
    if A2 = '' then
      Result := sName + '(' + A1 + ', 0)'
    else
      Result := sName + AddArgs;
  efRADIANS:
    Result := sName + '(' + A1 + ' + 0.0)';
  // date and time
  efCURDATE,
  efCURTIME,
  efNOW:         Result := 'GETDATE()';
  efDAYNAME:     Result := 'DATENAME(WEEKDAY, ' + A1 + ')';
  efDAYOFMONTH:  Result := 'DATEPART(DAY, ' + A1 + ')';
  efDAYOFWEEK:   Result := 'DATEPART(WEEKDAY, ' + A1 + ')';
  efDAYOFYEAR:   Result := 'DATEPART(DAYOFYEAR, ' + A1 + ')';
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
  efHOUR:        Result := 'DATEPART(HOUR, ' + A1 + ')';
  efMINUTE:      Result := 'DATEPART(MINUTE, ' + A1 + ')';
  efMONTH:       Result := 'DATEPART(MONTH, ' + A1 + ')';
  efMONTHNAME:   Result := 'DATENAME(MONTH, ' + A1 + ')';
  efQUARTER:     Result := 'DATEPART(QUARTER, ' + A1 + ')';
  efSECOND:      Result := 'DATEPART(SECOND, ' + A1 + ')';
  efTIMESTAMPADD:
    begin
      A1 := UpperCase(FDUnquote(Trim(A1), ''''));
      if A1 = 'FRAC_SECOND' then begin
        A1 := 'MILLISECOND';
        A2 := '(' + A2 + ' / 1000)';
      end;
      ASeq.FArgs[0] := A1;
      ASeq.FArgs[1] := A2;
      Result := 'DATEADD' + AddArgs;
    end;
  efTIMESTAMPDIFF:
    begin
      A1 := UpperCase(FDUnquote(Trim(A1), ''''));
      if A1 = 'FRAC_SECOND' then
        A1 := 'MILLISECOND';
      ASeq.FArgs[0] := A1;
      Result := 'DATEDIFF' + AddArgs;
      if A1 = 'MILLISECOND' then
        Result := '(' + Result + ' * 1000.0)';
    end;
  efWEEK:        Result := 'DATEPART(WEEK, ' + A1 + ')';
  efYEAR:        Result := 'DATEPART(YEAR, ' + A1 + ')';
  // system
  efCATALOG:     Result := 'DB_NAME()';
  efSCHEMA:      Result := 'CURRENT_USER()';
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
    Result := 'CONVERT(' + A2 + ', ' + A1 + ')';
  else
    UnsupportedEscape(ASeq);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAMetadata.InternalGetSQLCommandKind(
  const ATokens: TStrings): TFDPhysCommandKind;
var
  sToken: String;
begin
  sToken := ATokens[0];
  if sToken = 'CALL' then
    Result := skExecute
  else if sToken = 'BEGIN' then
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
{ TFDPhysASACommandGenerator                                                    }
{-------------------------------------------------------------------------------}
function TFDPhysASACommandGenerator.GetIdentity(ASessionScope: Boolean): String;
begin
  Result := '@@IDENTITY';
end;

{-------------------------------------------------------------------------------}
function TFDPhysASACommandGenerator.GetPessimisticLock: String;
var
  lNeedFrom: Boolean;
begin
  Result := 'BEGIN ';
  if FOptions.UpdateOptions.LockWait then
    Result := Result + 'SET TEMPORARY OPTION BLOCKING_TIMEOUT = 0; '
  else
    Result := Result + 'SET TEMPORARY OPTION BLOCKING_TIMEOUT = 1000; ';
  Result := Result + 'SELECT ' + GetSelectList(True, False, lNeedFrom) +
    ' FROM ' + GetFrom + ' WHERE ' + GetWhere(False, True, False) + ' FOR UPDATE BY LOCK; ';
  Result := Result + 'SET TEMPORARY OPTION BLOCKING_TIMEOUT =; ' +
    'EXCEPTION WHEN OTHERS THEN SET TEMPORARY OPTION BLOCKING_TIMEOUT =; RESIGNAL; END';
  FCommandKind := skSelectForLock;
  ASSERT(lNeedFrom);
end;

{-------------------------------------------------------------------------------}
function TFDPhysASACommandGenerator.GetSavepoint(const AName: String): String;
begin
  Result := 'SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASACommandGenerator.GetRollbackToSavepoint(const AName: String): String;
begin
  Result := 'ROLLBACK TO SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASACommandGenerator.GetCall(const AName: String): String;
begin
  Result := 'CALL ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASACommandGenerator.GetLimitSelect(const ASQL: String;
  ASkip, ARows: Integer): String;
var
  s: String;
begin
  if (FConnMeta.ServerVersion >= cvSybaseASA9) and (ASkip > 0) and (ARows <> 0) and
     (CompareText(Copy(ASQL, 1, 6), 'SELECT') = 0) and
     (CompareText(Copy(ASQL, 1, 10), 'SELECT TOP') <> 0) then begin
    Result := 'SELECT TOP ';
    s := UpperCase(ASQL);
    if HasKW(s, 'UNION') or HasKW(s, 'MINUS') or HasKW(s, 'INTERSECT') or
       HasKW(s, 'EXCEPT') then
      Result := Result + IntToStr(ARows) + ' START AT ' + IntToStr(ASkip + 1) +
        ' * FROM (' + BRK + ASQL + BRK + ') A'
    else if CompareText(Copy(ASQL, 1, 15), 'SELECT DISTINCT') = 0 then
      Result := 'SELECT DISTINCT TOP ' + IntToStr(ARows) + ' START AT ' + IntToStr(ASkip + 1) +
        Copy(ASQL, 16, MAXINT)
    else
      Result := Result + IntToStr(ARows) + ' START AT ' + IntToStr(ASkip + 1) +
        Copy(ASQL, 7, MAXINT);
  end
  else
    Result := inherited GetLimitSelect(ASQL, ASkip, ARows);
end;

{-------------------------------------------------------------------------------}
function TFDPhysASACommandGenerator.GetColumnType(AColumn: TFDDatSColumn): String;
begin
  case AColumn.DataType of
  dtBoolean:
    Result := 'BIT';
  dtSByte:
    Result := 'TINYINT';
  dtInt16:
    Result := 'SMALLINT';
  dtInt32:
    Result := 'INTEGER';
  dtInt64:
    Result := 'BIGINT';
  dtByte:
    Result := 'UNSIGNED TINYINT';
  dtUInt16:
    Result := 'UNSIGNED SMALLINT';
  dtUInt32:
    Result := 'UNSIGNED INTEGER';
  dtUInt64:
    Result := 'UNSIGNED BIGINT';
  dtSingle:
    Result := 'REAL';
  dtDouble,
  dtExtended:
    Result := 'DOUBLE';
  dtCurrency:
    Result := 'MONEY';
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
    Result := 'LONG BINARY';
  dtMemo,
  dtHMemo:
    Result := 'LONG VARCHAR';
  dtWideMemo,
  dtWideHMemo:
    Result := 'LONG NVARCHAR';
  dtXML:
    Result := 'XML';
  dtGUID:
    Result := 'UNIQUEIDENTIFIER';
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
    if caAutoInc in AColumn.ActualAttributes then
      Result := Result + ' IDENTITY'
    else if caExpr in AColumn.ActualAttributes then
      Result := Result + ' COMPUTE(' + AColumn.Expression + ')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysASACommandGenerator.GetMerge(AAction: TFDPhysMergeAction): String;
begin
  Result := '';
  case AAction of
  maInsertUpdate: Result := 'INSERT INTO ' + GetFrom + BRK + GetInsert('ON EXISTING UPDATE');
  maInsertIgnore: Result := 'INSERT INTO ' + GetFrom + BRK + GetInsert('ON EXISTING SKIP');
  end;
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterRDBMSKind(TFDRDBMSKinds.SQLAnywhere, S_FD_ASA_RDBMS);

end.
