{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{              FireDAC MS Access metadata               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.MSAccMeta;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys.Meta, FireDAC.Phys.SQLGenerator, FireDAC.Phys;

type
  TFDPhysMSAccMetadata = class (TFDPhysConnectionMetadata)
  protected
    function GetKind: TFDRDBMSKind; override;
    function GetParamNameMaxLength: Integer; override;
    function GetNameParts: TFDPhysNameParts; override;
    function GetNameQuotedCaseSensParts: TFDPhysNameParts; override;
    function GetNameCaseSensParts: TFDPhysNameParts; override;
    function GetNameDefLowCaseParts: TFDPhysNameParts; override;
    function GetNameQuoteChar(AQuote: TFDPhysNameQuoteLevel; ASide: TFDPhysNameQuoteSide): Char; override;
    function GetTruncateSupported: Boolean; override;
    function GetIdentityInsertSupported: Boolean; override;
    function GetIdentityInWhere: Boolean; override;
    function GetDefValuesSupported: TFDPhysDefaultValues; override;
    function GetAsyncAbortSupported: Boolean; override;
    function GetSelectOptions: TFDPhysSelectOptions; override;
    function InternalEscapeBoolean(const AStr: String): String; override;
    function InternalEscapeDate(const AStr: String): String; override;
    function InternalEscapeDateTime(const AStr: String): String; override;
    function InternalEscapeFloat(const AStr: String): String; override;
    function InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String; override;
    function InternalEscapeTime(const AStr: String): String; override;
    function InternalEscapeEscape(AEscape: Char; const AStr: String): String; override;
    function InternalGetSQLCommandKind(const ATokens: TStrings): TFDPhysCommandKind; override;
    function IsNameValid(const AName: String): Boolean; override;
  public
    constructor Create(const AConnectionObj: TFDPhysConnection;
      AServerVersion, AClientVersion: TFDVersion; const ACSVKeywords: String);
  end;

  TFDPhysMSAccCommandGenerator = class(TFDPhysCommandGenerator)
  protected
    function GetIdentity(ASessionScope: Boolean): String; override;
    function GetColumnType(AColumn: TFDDatSColumn): String; override;
  end;

implementation

uses
  System.SysUtils,
  FireDAC.Stan.Consts, FireDAC.Stan.Util, FireDAC.Stan.Option;

{-------------------------------------------------------------------------------}
{ TFDPhysMSAccMetadata                                                          }
{-------------------------------------------------------------------------------}
constructor TFDPhysMSAccMetadata.Create(const AConnectionObj: TFDPhysConnection;
  AServerVersion, AClientVersion: TFDVersion; const ACSVKeywords: String);
begin
  inherited Create(AConnectionObj, AServerVersion, AClientVersion, True);
  if ACSVKeywords <> '' then
    FKeywords.CommaText := ACSVKeywords + ',PASSWORD';
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.GetKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.MSAccess;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.GetNameQuotedCaseSensParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.GetNameCaseSensParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.GetNameDefLowCaseParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.GetParamNameMaxLength: Integer;
begin
  Result := 30;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.GetNameParts: TFDPhysNameParts;
begin
  Result := [npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.GetNameQuoteChar(AQuote: TFDPhysNameQuoteLevel;
  ASide: TFDPhysNameQuoteSide): Char;
begin
  Result := #0;
  case AQuote of
  ncDefault:
    if ASide = nsLeft then
      Result := '['
    else
      Result := ']';
  ncSecond:
    Result := '"';
  ncThird:
    Result := '`';
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.GetTruncateSupported: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.GetIdentityInsertSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.GetIdentityInWhere: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.GetDefValuesSupported: TFDPhysDefaultValues;
begin
  Result := dvDefVals;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.GetAsyncAbortSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.GetSelectOptions: TFDPhysSelectOptions;
begin
  Result := [soWithoutFrom];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.InternalEscapeBoolean(const AStr: String): String;
begin
  Result := AStr;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.InternalEscapeDate(const AStr: String): String;
begin
  Result := 'DATEVALUE(' + AnsiQuotedStr(AStr, '''') + ')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.InternalEscapeDateTime(const AStr: String): String;
begin
  Result := 'CDATE(' + AnsiQuotedStr(AStr, '''') + ')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.InternalEscapeTime(const AStr: String): String;
begin
  Result := 'TIMEVALUE(' + AnsiQuotedStr(AStr, '''') + ')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.InternalEscapeFloat(const AStr: String): String;
begin
  Result := AStr;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String;
var
  i: Integer;
  sEnd: String;
  A1, A2, A3, A4: String;

  function Intv2Acc(AIntv: String): String;
  begin
    AIntv := UpperCase(FDUnquote(Trim(AIntv), ''''));
    if AIntv = 'YEAR' then
      Result := '''yyyy'''
    else if AIntv = 'QUARTER' then
      Result := '''Q'''
    else if AIntv = 'MONTH' then
      Result := '''m'''
    else if AIntv = 'WEEK' then
      Result := '''ww'''
    else if AIntv = 'DAY' then
      Result := '''d'''
    else if AIntv = 'HOUR' then
      Result := '''H'''
    else if AIntv = 'MINUTE' then
      Result := '''N'''
    else if AIntv = 'SECOND' then
      Result := '''S'''
    else
      UnsupportedEscape(ASeq);
  end;

begin
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
  // char
  efASCII,
  efCHAR,
  efLEFT,
  efLTRIM,
  efREPEAT,
  efRIGHT,
  efRTRIM,
  efSPACE,
  efSUBSTRING,
  efCONCAT,
  efLCASE,
  efLOCATE,
  efUCASE,
  // numeric
  efACOS,
  efASIN,
  efATAN,
  efABS,
  efCEILING,
  efCOS,
  efCOT,
  efEXP,
  efFLOOR,
  efLOG,
  efMOD,
  efPOWER,
  efROUND,
  efSIGN,
  efSIN,
  efSQRT,
  efTAN,
  efRANDOM,
  efATAN2,
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
  efWEEK,
  efYEAR:         Result := '{fn ' + ASeq.FName + '(' + AddEscapeSequenceArgs(ASeq) + ')}';
  // system
  efIFNULL:       Result := 'IIF(' + A1 + ' IS NULL, ' + A2 + ', ' + A1 + ')';
  efIF:           Result := 'IIF(' + AddEscapeSequenceArgs(ASeq) + ')';
  efDECODE:
    begin
      i := 1;
      sEnd := '';
      Result := '';
      while i <= Length(ASeq.FArgs) - 2 do begin
        if i > 1 then
          Result := Result + ', ';
        Result := Result + 'IIF(' + A1 + ' = ' + ASeq.FArgs[i] +
          ', ' + ASeq.FArgs[i + 1];
        sEnd := sEnd + ')';
        Inc(i, 2);
      end;
      if i = Length(ASeq.FArgs) - 1 then begin
        if i > 1 then
          Result := Result + ', ';
        Result := Result + ASeq.FArgs[i];
      end;
      Result := Result + sEnd;
    end;
  // char
  efPOSITION:     Result := 'INSTR(1, ' + A2 + ', ' + A1 + ')';
  efBIT_LENGTH:   Result := '(LEN(' + A1 + ') * 8)';
  efCHAR_LENGTH,
  efLENGTH,
  efOCTET_LENGTH: Result := 'LEN(' + A1 + ')';
  efINSERT:       Result := 'MID(' + A1 + ', 1, ' + A2 + '- 1) & ' + A4 +
                    '& MID(' + A1 + ', (' + A2 + ') + (' + A3 + '), LEN(' + A1 + '))';
  efREPLACE:      Result := 'REPLACE(' + AddEscapeSequenceArgs(ASeq) + ')';
  // date and time
  efEXTRACT:      Result := 'DATEPART(' + Intv2Acc(A1) + ', ' + A2 + ')';
  efTIMESTAMPADD: Result := 'DATEADD(' + Intv2Acc(A1) + ', ' + A2 + ', ' + A3 + ')';
  efTIMESTAMPDIFF:Result := 'DATEDIFF(' + Intv2Acc(A1) + ', ' + A2 + ', ' + A3 + ')';
  // system
  efCATALOG:      Result := '{fn DATABASE()}';
  efSCHEMA:       Result := '{fn USER()';
  // numeric
  efPI:           Result := S_FD_Pi;
  efDEGREES:      Result := '(180 * (' + A1 + ') / ' + S_FD_Pi + ')';
  efRADIANS:      Result := '(' + S_FD_Pi + ' * (' + A1 + ') / 180)';
  efTRUNCATE:     Result := 'INT(' + A1 + ')';
  efLOG10:        Result := '(LOG(' + A1 + ') / LOG(10))';
  // convert
  efCONVERT:
    begin
      A2 := Trim(UpperCase(A2));
      if A2[1] = '''' then
        A2 := Copy(A2, 2, Length(A2) - 2);
      if A2 = 'CHAR' then
        A2 := 'VARCHAR';
      Result := '{fn CONVERT(' + A1 + ', SQL_' + A2 + ')}';
    end;
  else
    UnsupportedEscape(ASeq);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.InternalEscapeEscape(AEscape: Char;
  const AStr: String): String;
var
  i: Integer;
begin
  Result := AStr;
  i := 1;
  while i <= Length(Result) do
    if Result[i] = AEscape then begin
      Result := Copy(Result, 1, i - 1) + '[' + Result[i + 1] + ']' +
        Copy(Result, i + 2, Length(Result));
      Inc(i, 3);
    end
    else
      Inc(i);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccMetadata.InternalGetSQLCommandKind(
  const ATokens: TStrings): TFDPhysCommandKind;
var
  sToken: String;
begin
  sToken := ATokens[0];
  if sToken = 'BEGIN' then
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
function TFDPhysMSAccMetadata.IsNameValid(const AName: String): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 1 to Length(AName) do
    if not ((i = 1) and FDInSet(AName[i], ['a' .. 'z', 'A' .. 'Z', '_']) or
            (i > 1) and FDInSet(AName[i], ['a' .. 'z', 'A' .. 'Z', '0' .. '9', '_', '$'])) then begin
      Result := False;
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysMSAccCommandGenerator                                                  }
{-------------------------------------------------------------------------------}
function TFDPhysMSAccCommandGenerator.GetIdentity(ASessionScope: Boolean): String;
begin
  Result := '@@IDENTITY';
end;

{-------------------------------------------------------------------------------}
// http://msdn.microsoft.com/en-us/library/bb177899%28v=office.12%29.aspx
// http://msdn.microsoft.com/en-us/library/bb208866(v=office.12).aspx
function TFDPhysMSAccCommandGenerator.GetColumnType(AColumn: TFDDatSColumn): String;
begin
  if caAutoInc in AColumn.ActualAttributes then begin
    Result := 'COUNTER';
    Exit;
  end;
  case AColumn.DataType of
  dtBoolean:
    Result := 'BIT';
  dtSByte,
  dtInt16:
    Result := 'SMALLINT';
  dtInt32,
  dtUInt16:
    Result := 'INTEGER';
  dtInt64,
  dtUInt32,
  dtUInt64:
    Result := 'DECIMAL';
  dtByte:
    Result := 'TINYINT';
  dtSingle:
    Result := 'REAL';
  dtDouble,
  dtExtended:
    Result := 'FLOAT';
  dtCurrency:
    Result := 'MONEY';
  dtBCD,
  dtFmtBCD:
    Result := 'DECIMAL' + GetColumnDim(-1, AColumn.Precision, AColumn.Scale, -1,
      FOptions.FormatOptions.MaxBcdPrecision, FOptions.FormatOptions.MaxBcdScale);
  dtDateTime,
  dtTime,
  dtDate,
  dtDateTimeStamp:
    Result := 'DATETIME';
  dtAnsiString,
  dtWideString:
    if (caFixedLen in AColumn.ActualAttributes) and (AColumn.Size <= 255) then
      Result := 'CHAR' + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1)
    else
      Result := 'TEXT';
  dtByteString:
    Result := 'BINARY' + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1);
  dtBlob,
  dtHBlob,
  dtHBFile:
    Result := 'IMAGE';
  dtMemo,
  dtWideMemo,
  dtXML,
  dtHMemo,
  dtWideHMemo:
    Result := 'TEXT';
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
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterRDBMSKind(TFDRDBMSKinds.MSAccess, S_FD_MSAcc_RDBMS);

end.
