{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{            FireDAC Nexus Database metadata            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.NexusMeta;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.Meta, FireDAC.Phys.SQLGenerator;

type
  TFDPhysNexusMetadata = class (TFDPhysConnectionMetadata)
  protected
    function GetKind: TFDRDBMSKind; override;
    function GetTxNested: Boolean; override;
    function GetTruncateSupported: Boolean; override;
    function GetParamNameMaxLength: Integer; override;
    function GetNameParts: TFDPhysNameParts; override;
    function GetNameCaseSensParts: TFDPhysNameParts; override;
    function GetNameDefLowCaseParts: TFDPhysNameParts; override;
    function GetNameQuoteChar(AQuote: TFDPhysNameQuoteLevel; ASide: TFDPhysNameQuoteSide): Char; override;
    function GetNamedParamMark: TFDPhysParamMark; override;
    function GetIdentityInsertSupported: Boolean; override;
    function GetInlineRefresh: Boolean; override;
    function GetPositionedParamMark: TFDPhysParamMark; override;
    function GetSelectOptions: TFDPhysSelectOptions; override;
    function GetAsyncAbortSupported: Boolean; override;
    function GetDefValuesSupported: TFDPhysDefaultValues; override;
    function GetNameQuotedCaseSensParts: TFDPhysNameParts; override;
    function GetLimitOptions: TFDPhysLimitOptions; override;
    function GetNullLocations: TFDPhysNullLocations; override;
    function InternalEscapeDate(const AStr: String): String; override;
    function InternalEscapeDateTime(const AStr: String): String; override;
    function InternalEscapeFloat(const AStr: String): String; override;
    function InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String; override;
    function InternalEscapeTime(const AStr: String): String; override;
    function InternalGetSQLCommandKind(const ATokens: TStrings): TFDPhysCommandKind; override;
  public
    constructor Create(const AConnectionObj: TFDPhysConnection;
      AServerVersion, AClientVerison: TFDVersion);
  end;

  TFDPhysNexusCommandGenerator = class(TFDPhysCommandGenerator)
  protected
    function GetInlineRefresh(const AStmt: String; ARequest: TFDUpdateRequest): String; override;
    function GetIdentity(ASessionScope: Boolean): String; override;
    function GetSingleRowTable: String; override;
    function GetCall(const AName: String): String; override;
    function GetStoredProcCall(const ACatalog, ASchema, APackage, AProc: String;
      ASPUsage: TFDPhysCommandKind): String; override;
    function GetSelectMetaInfo(AKind: TFDPhysMetaInfoKind; const ACatalog,
      ASchema, ABaseObject, AObject, AWildcard: String;
      AObjectScopes: TFDPhysObjectScopes; ATableKinds: TFDPhysTableKinds;
      AOverload: Word): String; override;
    function GetLimitSelect(const ASQL: String; ASkip, ARows: Integer): String; override;
  end;

implementation

uses
  System.SysUtils, Data.DB,
  FireDAC.Stan.Consts, FireDAC.Stan.Util, FireDAC.DatS, FireDAC.Stan.Param;

{-------------------------------------------------------------------------------}
{ TFDPhysNexusMetadata                                                          }
{-------------------------------------------------------------------------------}
constructor TFDPhysNexusMetadata.Create(const AConnectionObj: TFDPhysConnection;
  AServerVersion, AClientVerison: TFDVersion);
begin
  inherited Create(AConnectionObj, AServerVersion, AClientVerison, False);
  FKeywords.CommaText := 'ABS,ACHAR,ADD,ALL,ALTER,AND,ANY,AS,ASC,ASSERT,' +
    'ASTRING,AUTOINC,AVG,BETWEEN,BLOB,BLOCK,BLOCKSIZE,BOOL,' +
    'BOOLEAN,BOTH,BY,BYTE,BYTEARRAY,CASCADE,CASE,CAST,' +
    'CEILING,CHAR,CHARACTER,CHARACTER_LENGTH,CHAR_LENGTH,CHR,' +
    'COALESCE,COLUMN,COUNT,CREATE,CROSS,CURRENT_DATE,' +
    'CURRENT_TIME,CURRENT_TIMESTAMP,CURRENT_USER,DATE,DATETIME,' +
    'DAY,DEFAULT,DELETE,DESC,DISTINCT,DROP,DWORD,ELSE,' +
    'EMPTY,END,ESCAPE,EXISTS,EXP,EXTRACT,FALSE,FLOOR,FOR,' +
    'FROM,FULL,GROUP,GROW,GROWSIZE,HAVING,HOUR,IDENTITY,' +
    'IGNORE,IMAGE,IN,INDEX,INITIAL,INITIALSIZE,INNER,INSERT,' +
    'INT,INTEGER,INTERVAL,INTO,IS,JOIN,KANA,KEY,LARGEINT,' +
    'LEADING,LEFT,LIKE,LOCALE,LOG,LOWER,MATCH,MAX,MIN,' +
    'MINUTE,MONEY,MONTH,NATURAL,NCHAR,NOT,NULL,NULLIF,' +
    'NULLSTRING,NVARCHAR,ON,OR,ORDER,OUTER,PARTIAL,PERCENT,' +
    'POSITION,POWER,PRIMARY,RAND,REAL,RIGHT,ROUND,SECOND,' +
    'SELECT,SESSION_USER,SET,SHORTINT,SIZE,SMALLINT,SOME,' +
    'SORT,STRING,SUBSTRING,SUM,SYMBOLS,TABLE,TEXT,THEN,' +
    'TIME,TIMESTAMP,TINYINT,TO,TOP,TRAILING,TRIM,TRUE,' +
    'TYPE,UNION,UNIQUE,UNKNOWN,UPDATE,UPPER,USE,USER,' +
    'USING,VALUES,VARCHAR,WHEN,WHERE,WIDTH,WORD,YEAR';
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.GetKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.NexusDB;
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.GetNameQuotedCaseSensParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.GetNameCaseSensParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.GetNameDefLowCaseParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.GetParamNameMaxLength: Integer;
begin
  Result := 128;
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.GetNameParts: TFDPhysNameParts;
begin
  Result := [npSchema, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.GetNameQuoteChar(AQuote: TFDPhysNameQuoteLevel;
  ASide: TFDPhysNameQuoteSide): Char;
begin
  if AQuote = ncDefault then
    Result := '"'
  else
    Result := #0;
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.GetIdentityInsertSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.GetNamedParamMark: TFDPhysParamMark;
begin
  Result := prName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.GetPositionedParamMark: TFDPhysParamMark;
begin
  Result := prQMark;
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.GetSelectOptions: TFDPhysSelectOptions;
begin
  Result := [soWithoutFrom, soInlineView];
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.GetTxNested: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.GetInlineRefresh: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.GetTruncateSupported: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.GetDefValuesSupported: TFDPhysDefaultValues;
begin
  Result := dvDef;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysNexusMetadata.GetAsyncAbortSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.GetLimitOptions: TFDPhysLimitOptions;
begin
  Result := [loSkip, loRows];
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.GetNullLocations: TFDPhysNullLocations;
begin
  Result := [nlAscLast, nlDescLast];
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.InternalEscapeDate(const AStr: String): String;
begin
  Result := 'DATE ' + AnsiQuotedStr(AStr, '''');
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.InternalEscapeDateTime(const AStr: String): String;
begin
  Result := 'TIMESTAMP ' + AnsiQuotedStr(AStr, '''');
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.InternalEscapeTime(const AStr: String): String;
begin
  Result := 'TIME ' + AnsiQuotedStr(AStr, '''');
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.InternalEscapeFloat(const AStr: String): String;
begin
  Result := 'CAST(' + AnsiQuotedStr(AStr, '''') + ' AS DOUBLE)';
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String;
var
  sName: String;
  A1, A2, A3, A4: String;
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
  efCHAR_LENGTH,
  efOCTET_LENGTH,
  // numeric
  efABS,
  efATAN,
  efATAN2,
  efCEILING,
  efCOS,
  efEXP,
  efFLOOR,
  efMOD,
  efPOWER,
  efPI,
  efROUND,
  efSIN,
  efSQRT:
    Result := sName + AddArgs;

  // char:
  efASCII:       Result := 'ORD' + AddArgs;
  efBIT_LENGTH:  Result := '(OCTET_LENGTH(' + A1 + ') * 8)';
  efCHAR:        Result := 'CHR' + AddArgs;
  efCONCAT:      Result := '(' + A1 + ' || ' + A2 + ')';
  efINSERT:      Result := '(SUBSTR(' + A1 + ' FROM 1 (' + A2 + ') - 1) || ' + A4 +
                    ' || SUBSTR(' + A1 + ' FROM (' + A2 + ' + ' + A3 + ')))';
  efLCASE:       Result := 'LOWER' + AddArgs;
  efLEFT:        Result := 'SUBSTR(' + A1 + ' FROM 1 FOR ' + A2 + ')';
  efLENGTH:      Result := 'CHAR_LENGTH' + AddArgs;
  efLTRIM:       Result := 'TRIM(LEADING FROM ' + A1 + ')';
  efLOCATE,
  efPOSITION:    Result := 'POSITION(' + A1 + ' IN ' + A2 + ')';
  efRIGHT:       Result := 'SUBSTR(' + A1 + ' FROM CHAR_LENGTH(' + A1 + ') + 1 - (' + A2 + '))';
  efRTRIM:       Result := 'TRIM(TRAILING FROM ' + A1 + ')';
  efSUBSTRING:
    begin
      Result := 'SUBSTRING(' + A1 + ' FROM ' + A2;
      if Length(ASeq.FArgs) = 3 then
        Result := Result + ' FOR ' + A3;
      Result := Result + ')'
    end;
  efUCASE:       Result := 'UPPER' + AddArgs;

  // numeric
  efCOT:         Result := '(COS(' + A1 + ') / SIN(' + A1 + '))';
  efDEGREES:     Result := '(180 * (' + A1 + ') / ' + S_FD_Pi  + ')';
  efLOG:         Result := 'LN' + AddArgs;
  efLOG10:       Result := 'LOG(10, ' + A1 + ')';
  efRADIANS:     Result := '((' + A1 + ') / 180 * ' + S_FD_Pi + ')';
  efRANDOM:      Result := 'RAND' + AddArgs;
  efSIGN:        Result := 'CASE WHEN ' + A1 + ' > 0 THEN 1 WHEN ' + A1 + ' < 0 THEN -1 ELSE 0 END';
  efTAN:         Result := '(SIN(' + A1 + ') / COS(' + A1 + '))';
  efTRUNCATE:    Result := 'CAST(' + A1 + ' AS INTEGER)';

  // date and time
  efCURDATE:     Result := 'CURRENT_DATE';
  efCURTIME:     Result := 'CURRENT_TIME';
  efDAYOFMONTH:  Result := 'EXTRACT(DAY FROM ' + A1 + ')';
  efEXTRACT:
    begin
      A1 := UpperCase(FDUnquote(Trim(A1), ''''));
      Result := sName + '(' + A1 + ' FROM ' + A2 + ')';
    end;
  efHOUR:        Result := 'EXTRACT(HOUR FROM ' + A1 + ')';
  efMINUTE:      Result := 'EXTRACT(MINUTE FROM ' + A1 + ')';
  efMONTH:       Result := 'EXTRACT(MONTH FROM ' + A1 + ')';
  efNOW:         Result := 'CURRENT_TIMESTAMP';
  efQUARTER:     Result := '(FLOOR(EXTRACT(MONTH FROM ' + A1 + ') / 4) + 1)';
  efSECOND:      Result := 'EXTRACT(SECOND FROM ' + A1 + ')';
  efYEAR:        Result := 'EXTRACT(YEAR FROM ' + A1 + ')';

  // system
  efCATALOG:     Result := '''''';
  efIF:          Result := 'CASE WHEN ' + A1 + ' THEN ' + A2 + ' ELSE ' + A3 + ' END';
  efIFNULL:      Result := 'CASE WHEN ' + A1 + ' IS NULL THEN ' + A2 + ' ELSE ' + A1 + ' END';
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
  efCONVERT:
    begin
      A2 := UpperCase(FDUnquote(Trim(A2), ''''));
      Result := 'CAST(' + A1 + ' AS ' + A2 + ')';
    end;
  else
                       
    // efREPEAT, efREPLACE, efSPACE
    // efACOS, efASIN
    // efDAYNAME, efDAYOFWEEK, efDAYOFYEAR, efMONTHNAME, efWEEK,
    //   efTIMESTAMPADD, efTIMESTAMPDIFF
    // efSCHEMA
    UnsupportedEscape(ASeq);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusMetadata.InternalGetSQLCommandKind(
  const ATokens: TStrings): TFDPhysCommandKind;
var
  sToken: String;
begin
  sToken := ATokens[0];
  if (sToken = 'DECLARE') or (sToken = 'CALL') then
    Result := skExecute
  else if sToken = 'ASSERT' then
    Result := skAlter
  else if sToken = 'START' then
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
{ TFDPhysNexusCommandGenerator                                                  }
{-------------------------------------------------------------------------------}
function TFDPhysNexusCommandGenerator.GetInlineRefresh(const AStmt: String;
  ARequest: TFDUpdateRequest): String;
begin
  Result := GenerateSelect(False);
  if Result <> '' then
    Result := AStmt + ';' + BRK + Result
  else
    Result := AStmt;
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusCommandGenerator.GetIdentity(ASessionScope: Boolean): String;
begin
  Result := 'LASTAUTOINC';
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusCommandGenerator.GetSingleRowTable: String;
begin
  Result := '#DUMMY';
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusCommandGenerator.GetCall(const AName: String): String;
begin
  Result := 'CALL ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusCommandGenerator.GetStoredProcCall(const ACatalog, ASchema,
  APackage, AProc: String; ASPUsage: TFDPhysCommandKind): String;
begin
                     
//1) SP with input params -> CALL SP(:p1, ..., :pN)
//2) SP with output params -> as above
//3) SF with last SELECT -> CALL SF(:p1, ..., :pN) returns a cursor
//4) SF -> SELECT SF(:p1, ..., :pN)
//5) SF returning a table -> SELECT * FROM SF(:p1, ..., :pN)
end;

{-------------------------------------------------------------------------------}
function TFDPhysNexusCommandGenerator.GetSelectMetaInfo(AKind: TFDPhysMetaInfoKind;
  const ACatalog, ASchema, ABaseObject, AObject, AWildcard: String;
  AObjectScopes: TFDPhysObjectScopes; ATableKinds: TFDPhysTableKinds;
  AOverload: Word): String;
var
  lWasWhere: Boolean;
  sKinds: String;

  function AddParam(const AValue, AParam: String): String;
  var
    oPar: TFDParam;
  begin
    if AValue <> '' then begin
      Result := ':' + AParam;
      oPar := GetParams.Add;
      oPar.Name := AParam;
      oPar.DataType := ftString;
      oPar.Size := 128;
    end
    else
      Result := 'NULL';
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
      oPar.Size := 128;
    end;
  end;

  function EncodeDataType(const ATypeField, ALengthField, AScaleField: String): String;

    function DT2Str(AType: TFDDataType): String;
    begin
      Result := IntToStr(Integer(AType));
    end;

  begin
    Result :=
      'CASE ' +
      ' WHEN ' + ATypeField + ' = ''SHORT'' OR ' + ATypeField + ' = ''SHORTINT'' THEN ' + DT2Str(dtInt16) +
      ' WHEN ' + ATypeField + ' = ''INTEGER'' OR ' + ATypeField + ' = ''Integer'' THEN ' + DT2Str(dtInt32) +
      ' WHEN ' + ATypeField + ' = ''LONG'' THEN ' + DT2Str(dtInt64) +
      ' WHEN ' + ATypeField + ' = ''AUTOINC'' THEN ' + DT2Str(dtInt32) +
      ' WHEN ' + ATypeField + ' = ''ROWVERSION'' THEN ' + DT2Str(dtInt64) +
      ' WHEN ' + ATypeField + ' = ''DOUBLE'' THEN ' + DT2Str(dtDouble) +
      ' WHEN ' + ATypeField + ' = ''CURDOUBLE'' THEN ' + DT2Str(dtCurrency) +
      ' WHEN ' + ATypeField + ' = ''MONEY'' OR ' + ATypeField + ' = ''Money'' THEN ' + DT2Str(dtCurrency) +
      ' WHEN ' + ATypeField + ' = ''NUMERIC'' OR ' + ATypeField + ' = ''Numeric'' THEN ' +
          'CASE' +
          ' WHEN (' + ALengthField + ' - 2 > 18) OR (' + AScaleField + ' > 4) THEN ' + DT2Str(dtBCD) +
          ' ELSE ' + DT2Str(dtFmtBCD) +
          ' END' +
      ' WHEN ' + ATypeField + ' = ''CHAR'' OR ' + ATypeField + ' = ''CHARACTER'' THEN ' + DT2Str(dtAnsiString) +
      ' WHEN ' + ATypeField + ' = ''CICHAR'' OR ' + ATypeField + ' = ''CICHARACTER'' THEN ' + DT2Str(dtAnsiString) +
      ' WHEN ' + ATypeField + ' = ''VARCHAR'' OR ' + ATypeField + ' = ''VARCHARFOX'' THEN ' + DT2Str(dtAnsiString) +
      ' WHEN ' + ATypeField + ' = ''NCHAR'' THEN ' + DT2Str(dtWideString) +
      ' WHEN ' + ATypeField + ' = ''NVARCHAR'' THEN ' + DT2Str(dtWideString) +
      ' WHEN ' + ATypeField + ' = ''MEMO'' OR ' + ATypeField + ' = ''Memo'' THEN ' + DT2Str(dtMemo) +
      ' WHEN ' + ATypeField + ' = ''NMEMO'' THEN ' + DT2Str(dtWideMemo) +
      ' WHEN ' + ATypeField + ' = ''RAW'' THEN ' + DT2Str(dtByteString) +
      ' WHEN ' + ATypeField + ' = ''VARBINARY'' OR ' + ATypeField + ' = ''VARBINARYFOX'' THEN ' + DT2Str(dtByteString) +
      ' WHEN ' + ATypeField + ' = ''BINARY'' OR ' + ATypeField + ' = ''BLOB'' THEN ' + DT2Str(dtBlob) +
      ' WHEN ' + ATypeField + ' = ''IMAGE'' THEN ' + DT2Str(dtBlob) +
      ' WHEN ' + ATypeField + ' = ''DATE'' THEN ' + DT2Str(dtDate) +
      ' WHEN ' + ATypeField + ' = ''SHORTDATE'' THEN ' + DT2Str(dtDate) +
      ' WHEN ' + ATypeField + ' = ''TIME'' THEN ' + DT2Str(dtTime) +
      ' WHEN ' + ATypeField + ' = ''TIMESTAMP'' THEN ' + DT2Str(dtDateTimeStamp) +
      ' WHEN ' + ATypeField + ' = ''MODTIME'' THEN ' + DT2Str(dtDateTimeStamp) +
      ' WHEN ' + ATypeField + ' = ''LOGICAL'' THEN ' + DT2Str(dtBoolean) +
      ' ELSE ' + DT2Str(dtUnknown) +
      ' END';
  end;

  function EncodeAttrs(const ATypeField, ANullFieldName, ADefFieldName: String): String;

    function Attrs2Str(AAttrs: TFDDataAttributes): String;
    begin
      Result := IntToStr(PWord(@AAttrs)^);
    end;

  begin
    Result :=
      '(CASE ' +
      ' WHEN ' + ATypeField + ' = ''AUTOINC'' THEN ' + Attrs2Str([caBase, caSearchable, caAutoInc]) +
      ' WHEN ' + ATypeField + ' = ''ROWVERSION'' THEN ' + Attrs2Str([caBase, caSearchable, caRowVersion, caReadOnly]) +
      ' WHEN ' + ATypeField + ' = ''CHAR'' OR ' + ATypeField + ' = ''CHARACTER'' THEN ' + Attrs2Str([caBase, caSearchable, caFixedLen]) +
      ' WHEN ' + ATypeField + ' = ''CICHAR'' OR ' + ATypeField + ' = ''CICHARACTER'' THEN ' + Attrs2Str([caBase, caSearchable, caFixedLen]) +
      ' WHEN ' + ATypeField + ' = ''NCHAR'' THEN ' + Attrs2Str([caBase, caSearchable, caFixedLen]) +
      ' WHEN ' + ATypeField + ' = ''MEMO'' OR ' + ATypeField + ' = ''Memo'' THEN ' + Attrs2Str([caBase, caBlobData]) +
      ' WHEN ' + ATypeField + ' = ''NMEMO'' THEN ' + Attrs2Str([caBase, caBlobData]) +
      ' WHEN ' + ATypeField + ' = ''RAW'' THEN ' + Attrs2Str([caBase, caSearchable, caFixedLen]) +
      ' WHEN ' + ATypeField + ' = ''BINARY'' OR ' + ATypeField + ' = ''BLOB'' THEN ' + Attrs2Str([caBase, caBlobData]) +
      ' WHEN ' + ATypeField + ' = ''IMAGE'' THEN ' + Attrs2Str([caBase, caBlobData]) +
      ' ELSE ' + Attrs2Str([caBase, caSearchable]) +
      ' END';

    if ADefFieldName <> '' then
      Result := Result +
      ' + CASE ' +
      ' WHEN (' + ADefFieldName + ' IS NOT NULL) AND (TRIM(' + ADefFieldName + ') <> '''') AND ' +
            '(TRIM(' + ADefFieldName + ') <> ''NULL'') THEN ' + Attrs2Str([caDefault]) +
      ' ELSE 0' +
      ' END';

    if ANullFieldName <> '' then
      Result := Result +
      ' + CASE ' +
      ' WHEN (' + ANullFieldName + ' IS NOT NULL) AND (' + ANullFieldName + ' = 1) THEN ' + Attrs2Str([caAllowNull]) +
      ' ELSE 0' +
      ' END'
    else
      Result := Result +
      ' + ' + Attrs2Str([caAllowNull]);

    Result := Result + ')';
  end;

  function EncodePrec(const ATypeField, APrecField: String): String;
  begin
    Result :=
      'CASE ' +
      ' WHEN ' + ATypeField + ' = ''CURDOUBLE'' THEN 15' +
      ' WHEN ' + ATypeField + ' = ''MONEY'' OR ' + ATypeField + ' = ''Money'' THEN 19' +
      ' WHEN ' + ATypeField + ' = ''NUMERIC'' OR ' + ATypeField + ' = ''Numeric'' THEN ' + APrecField + ' - 2' +
      ' ELSE 0' +
      ' END';
  end;

  function EncodeScale(const ATypeField, AScaleField: String): String;
  begin
    Result :=
      'CASE ' +
      ' WHEN ' + ATypeField + ' = ''CURDOUBLE'' THEN 4' +
      ' WHEN ' + ATypeField + ' = ''MONEY'' OR ' + ATypeField + ' = ''Money'' THEN 4' +
      ' WHEN ' + ATypeField + ' = ''NUMERIC'' OR ' + ATypeField + ' = ''Numeric'' THEN ' + AScaleField +
      ' ELSE 0' +
      ' END';
  end;

  function EncodeLength(const ATypeField, ALengthField: String): String;
  begin
    Result :=
      'CASE ' +
      ' WHEN ' + ATypeField + ' = ''CHAR'' OR ' + ATypeField + ' = ''CHARACTER'' THEN ' + ALengthField +
      ' WHEN ' + ATypeField + ' = ''CICHAR'' OR ' + ATypeField + ' = ''CICHARACTER'' THEN ' + ALengthField +
      ' WHEN ' + ATypeField + ' = ''VARCHAR'' OR ' + ATypeField + ' = ''VARCHARFOX'' THEN ' + ALengthField +
      ' WHEN ' + ATypeField + ' = ''NCHAR'' THEN ' + ALengthField +
      ' WHEN ' + ATypeField + ' = ''NVARCHAR'' THEN ' + ALengthField +
      ' WHEN ' + ATypeField + ' = ''RAW'' THEN ' + ALengthField +
      ' WHEN ' + ATypeField + ' = ''VARBINARY'' OR ' + ATypeField + ' = ''VARBINARYFOX'' THEN ' + ALengthField +
      ' ELSE 0' +
      ' END';
  end;

begin
  lWasWhere := False;
  Result := '';

  case AKind of
  mkCatalogs:
    ;

  mkSchemas:
    Result := 'SELECT CAST(NULL AS SQL_INTEGER) AS RECNO, SCHEMA_NAME ' +
              'FROM #SCHEMAS';

                     
  mkTables:
    begin
      Result := 'SELECT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
        'A.TABLE_CAT AS CATALOG_NAME, ' +
        'A.TABLE_SCHEM AS SCHEMA_NAME, ' +
        'A.TABLE_NAME, ' +
        'CASE ' +
          ' WHEN A.TABLE_TYPE = ''TABLE'' THEN ' + IntToStr(Integer(tkTable)) +
          ' WHEN A.TABLE_TYPE = ''VIEW'' THEN ' + IntToStr(Integer(tkView)) +
          ' WHEN A.TABLE_TYPE = ''SYSTEM TABLE'' THEN ' + IntToStr(Integer(tkTable)) +
          ' WHEN A.TABLE_TYPE = ''LOCAL TEMPORARY'' THEN ' + IntToStr(Integer(tkLocalTable)) +
        ' END AS TABLE_TYPE, ' +
        'CASE ' +
          ' WHEN A.TABLE_TYPE = ''SYSTEM TABLE'' THEN ' + IntToStr(Integer(osSystem)) +
          ' ELSE ' + IntToStr(Integer(osMy)) +
        ' END AS TABLE_SCOPE ' +
        'FROM (EXECUTE PROCEDURE sp_GetTables(' + AddParam(ACatalog, 'CAT') +
          ', NULL, ' + AddParam(AWildcard, 'WIL');
      sKinds := '';
      if osMy in AObjectScopes then begin
        if tkTable in ATableKinds then
          sKinds := sKinds + 'TABLE;';
        if tkView in ATableKinds then
          sKinds := sKinds + 'VIEW;';
        if tkLocalTable in ATableKinds then
          sKinds := sKinds + 'LOCAL TEMPORARY;';
      end;
      if osSystem in AObjectScopes then
        if tkTable in ATableKinds then
          sKinds := sKinds + 'SYSTEM TABLE;';
      if sKinds = '' then
        sKinds := 'NONE;';
      Result := Result + ', ''' + Copy(sKinds, 1, Length(sKinds) - 1) + ''')) A' +
        ' ORDER BY 4';
    end;

  mkTableFields:
    begin
      Result := 'SELECT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
        'A.TABLE_CAT AS CATALOG_NAME, ' +
        'A.TABLE_SCHEM AS SCHEMA_NAME, ' +
        'A.TABLE_NAME, ' +
        'A.COLUMN_NAME, ' +
        'A.ORDINAL_POSITION AS COLUMN_POSITION, ' +
        EncodeDataType('A.TYPE_NAME', 'A.COLUMN_SIZE', 'A.DECIMAL_DIGITS') + ' AS COLUMN_DATATYPE, ' +
        'A.TYPE_NAME AS COLUMN_TYPENAME, ' +
        EncodeAttrs('A.TYPE_NAME', 'A.NULLABLE', 'A.COLUMN_DEF') + ' AS COLUMN_ATTRIBUTES, ' +
        EncodePrec('A.TYPE_NAME', 'A.COLUMN_SIZE') + ' AS COLUMN_PRECISION, ' +
        EncodeScale('A.TYPE_NAME', 'A.DECIMAL_DIGITS') + ' AS COLUMN_SCALE, ' +
        EncodeLength('A.TYPE_NAME', 'A.COLUMN_SIZE') + ' AS COLUMN_LENGTH ' +
        'FROM (EXECUTE PROCEDURE sp_GetColumns(' + AddParam(ACatalog, 'CAT') +
          ', NULL, ' + AddParam(AObject, 'OBJ') + ', ' + AddParam(AWildcard, 'WIL') +
        ')) A ORDER BY 6';
    end;

  mkIndexes:
    begin
      Result := 'SELECT DISTINCT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
        'A.TABLE_CAT AS CATALOG_NAME, ' +
        'A.TABLE_SCHEM AS SCHEMA_NAME, ' +
        'A.TABLE_NAME, ' +
        'A.INDEX_NAME, ' +
        'B.PK_NAME AS CONSTRAINT_NAME, ' +
        'CASE' +
        ' WHEN B.PK_NAME IS NOT NULL THEN 2' +
        ' WHEN NON_UNIQUE THEN 0' +
        ' ELSE 1 ' +
        'END AS INDEX_TYPE ' +
        'FROM (EXECUTE PROCEDURE sp_GetIndexInfo(' + AddParam(ACatalog, 'CAT') +
            ', NULL, ' + AddParam(AObject, 'OBJ') + ', False, True)) A ' +
        ' LEFT OUTER JOIN' +
        ' (EXECUTE PROCEDURE sp_GetPrimaryKeys(' + AddParam(ACatalog, 'CAT') +
            ', NULL, ' + AddParam(AObject, 'OBJ') + ')) B' +
        ' ON A.INDEX_NAME = B.PK_NAME ' +
        'WHERE A.TYPE <> 0';
      if AWildcard <> '' then
        Result := Result + ' AND A.INDEX_NAME LIKE ' + AddParam(AWildcard, 'WIL');
      Result := Result + ' ORDER BY 7 DESC, 5';
    end;

  mkIndexFields:
    begin
      Result := 'SELECT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
        'A.TABLE_CAT AS CATALOG_NAME, ' +
        'A.TABLE_SCHEM AS SCHEMA_NAME, ' +
        'A.TABLE_NAME, ' +
        'A.INDEX_NAME, ' +
        'A.COLUMN_NAME, ' +
        'A.ORDINAL_POSITION AS COLUMN_POSITION, ' +
        'A.ASC_OR_DESC AS SORT_ORDER, ' +
        'A.FILTER_CONDITION AS FILTER ' +
        'FROM (EXECUTE PROCEDURE sp_GetIndexInfo(' + AddParam(ACatalog, 'CAT') +
          ', NULL, ' + AddParam(ABaseObject, 'BAS') + ', False, True)) A';
      AddWhere('A.INDEX_NAME = :OBJ', 'OBJ');
      if AWildcard <> '' then
        AddWhere('A.COLUMN_NAME LIKE :WIL', 'WIL');
      Result := Result + ' ORDER BY 7';
    end;

  mkPrimaryKey:
    begin
      Result := 'SELECT DISTINCT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
        'A.TABLE_CAT AS CATALOG_NAME, ' +
        'A.TABLE_SCHEM AS SCHEMA_NAME, ' +
        'A.TABLE_NAME, ' +
        'A.PK_NAME AS INDEX_NAME, ' +
        'A.PK_NAME AS CONSTRAINT_NAME, ' +
        IntToStr(Integer(ikPrimaryKey)) + ' AS INDEX_TYPE ' +
        'FROM (EXECUTE PROCEDURE sp_GetPrimaryKeys(' + AddParam(ACatalog, 'CAT') +
          ', NULL, ' + AddParam(AObject, 'OBJ') + ')) A';
      if AWildcard <> '' then
        AddWhere('A.PK_NAME LIKE :WIL', 'WIL');
      Result := Result + ' ORDER BY 5';
    end;

  mkPrimaryKeyFields:
    begin
      Result := 'SELECT DISTINCT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
        'A.TABLE_CAT AS CATALOG_NAME, ' +
        'A.TABLE_SCHEM AS SCHEMA_NAME, ' +
        'A.TABLE_NAME, ' +
        'A.PK_NAME AS INDEX_NAME, ' +
        'A.COLUMN_NAME AS COLUMN_NAME, ' +
        'A.KEY_SEQ + 1 AS COLUMN_POSITION, ' +
        '''A'' AS SORT_ORDER, ' +
        'CAST(NULL AS SQL_VARCHAR(50)) AS FILTER ' +
        'FROM (EXECUTE PROCEDURE sp_GetPrimaryKeys(' + AddParam(ACatalog, 'CAT') +
          ', NULL, ' + AddParam(ABaseObject, 'BAS') + ')) A';
      if AWildcard <> '' then
        AddWhere('A.COLUMN_NAME LIKE :WIL', 'WIL');
      Result := Result + ' ORDER BY 7';
    end;

  mkForeignKeys:
    begin
      Result := 'SELECT DISTINCT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
        'A.TABLE_CAT AS CATALOG_NAME, ' +
        'A.TABLE_SCHEM AS SCHEMA_NAME, ' +
        'A.TABLE_NAME, ' +
        'A.FK_NAME AS FKEY_NAME, ' +
        'A.PKTABLE_CAT AS PKEY_CATALOG_NAME, ' +
        'A.PKTABLE_SCHEM AS PKEY_SCHEMA_NAME, ' +
        'A.PKTABLE_NAME AS PKEY_TABLE_NAME, ' +
        'A.DELETE_RULE AS DELETE_RULE, ' +
        'A.UPDATE_RULE AS UPDATE_RULE ' +
        'FROM (EXECUTE PROCEDURE sp_GetImportedKeys(' + AddParam(ACatalog, 'CAT') +
          ', NULL, ' + AddParam(AObject, 'OBJ') + ')) A';
      if AWildcard <> '' then
        AddWhere('A.FK_NAME LIKE :WIL', 'WIL');
      Result := Result + ' ORDER BY 5';
    end;

  mkForeignKeyFields:
    begin
      Result := 'SELECT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
        'A.TABLE_CAT AS CATALOG_NAME, ' +
        'A.TABLE_SCHEM AS SCHEMA_NAME, ' +
        'A.TABLE_NAME, ' +
        'A.FK_NAME AS FKEY_NAME, ' +
        'A.FKCOLUMN_NAME AS COLUMN_NAME, ' +
        'A.PKCOLUMN_NAME AS PKEY_COLUMN_NAME, ' +
        'A.KEY_SEQ AS COLUMN_POSITION ' +
        'FROM (EXECUTE PROCEDURE sp_GetImportedKeys(' + AddParam(ACatalog, 'CAT') +
          ', NULL, ' + AddParam(ABaseObject, 'BAS') + ')) A';
      AddWhere('A.FK_NAME = :OBJ', 'OBJ');
      if AWildcard <> '' then
        AddWhere('A.FKCOLUMN_NAME LIKE :WIL', 'WIL');
      Result := Result + ' ORDER BY 8';
    end;

  mkPackages:
    begin
      Result := 'SELECT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
        'CAST(NULL AS SQL_VARCHAR(200)) AS CATALOG_NAME, ' +
        'CAST(NULL AS SQL_VARCHAR(200)) AS SCHEMA_NAME, ' +
        'A.NAME AS PACKAGE_NAME, ' +
        IntToStr(Integer(osMy)) + ' AS PACKAGE_SCOPE ' +
        'FROM system.packages A ';
      if not (osMy in AObjectScopes) then
        AddWhere('0 = 1');
      if AWildcard <> '' then
        AddWhere('A.NAME LIKE :WIL', 'WIL');
      Result := Result + ' ORDER BY 4';
    end;

  mkProcs:
    begin
                                                         
      if ABaseObject = '' then begin
        Result := 'SELECT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
          'A.PROCEDURE_CAT AS CATALOG_NAME, ' +
          'A.PROCEDURE_SCHEM AS SCHEMA_NAME, ' +
          'CAST(NULL AS SQL_VARCHAR(200)) AS PACK_NAME, ' +
          'A.PROCEDURE_NAME AS PROC_NAME, ' +
          'CAST(NULL AS SQL_INTEGER) AS OVERLOAD, ' +
          IntToStr(Integer(pkProcedure)) + ' AS PROC_TYPE, ' +
          IntToStr(Integer(osMy)) + ' AS PROC_SCOPE, ' +
          'SUM(CASE WHEN B.COLUMN_TYPE IS NOT NULL AND B.COLUMN_TYPE = 1 THEN 1 ELSE 0 END) AS IN_PARAMS, ' +
          'SUM(CASE WHEN B.COLUMN_TYPE IS NOT NULL AND B.COLUMN_TYPE = 3 THEN 1 ELSE 0 END) AS OUT_PARAMS ' +
          'FROM (EXECUTE PROCEDURE sp_GetProcedures(' + AddParam(ACatalog, 'CAT') +
            ', NULL, NULL)) A ' +
          'LEFT OUTER JOIN ' +
          '(EXECUTE PROCEDURE sp_GetProcedureColumns(' + AddParam(ACatalog, 'CAT') +
            ', NULL, NULL, NULL)) B ' +
          'ON TRIM(A.PROCEDURE_CAT) = TRIM(B.PROCEDURE_CAT) AND ' +
            ' TRIM(A.PROCEDURE_SCHEM) = TRIM(B.PROCEDURE_SCHEM) AND ' +
            ' TRIM(A.PROCEDURE_NAME) = TRIM(B.PROCEDURE_NAME) ';
        if not (osMy in AObjectScopes) then
          AddWhere('0 = 1');
        if AWildcard <> '' then
          AddWhere('A.PROCEDURE_NAME LIKE :WIL', 'WIL');
        Result := Result +
          ' GROUP BY A.PROCEDURE_CAT, A.PROCEDURE_SCHEM, A.PROCEDURE_NAME ' +
          'UNION ALL ';
      end;
      Result := Result +
        'SELECT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
        'CAST(DATABASE() AS SQL_VARCHAR(200)) AS CATALOG_NAME, ' +
        'CAST(NULL AS SQL_VARCHAR(200)) AS SCHEMA_NAME, ' +
        'C.Package AS PACK_NAME, ' +
        'C.Name AS PROC_NAME, ' +
        'CAST(NULL AS SQL_INTEGER) AS OVERLOAD, ' +
        IntToStr(Integer(pkFunction)) + ' AS PROC_TYPE, ' +
        IntToStr(Integer(osMy)) + ' AS PROC_SCOPE, ' +
        '-1 AS IN_PARAMS, ' +
        '0 AS OUT_PARAMS ' +
        'FROM system.functions C';
      if ABaseObject = '' then
        AddWhere('C.Package IS NULL')
      else
        AddWhere('C.Package = :BAS', 'BAS');
      if not (osMy in AObjectScopes) then
        AddWhere('0 = 1');
      if AWildcard <> '' then
        AddWhere('C.Name LIKE :WIL', 'WIL');
      Result := Result +
        ' ORDER BY 4, 5';
    end;

  mkProcArgs:
                                                 
    if ABaseObject <> '' then
      Result := ''
    else begin
      Result := 'SELECT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
        'A.PROCEDURE_CAT AS CATALOG_NAME, ' +
        'A.PROCEDURE_SCHEM AS SCHEMA_NAME, ' +
        'CAST(NULL AS SQL_VARCHAR(200)) AS PACK_NAME, ' +
        'A.PROCEDURE_NAME AS PROC_NAME, ' +
        'CAST(NULL AS SQL_INTEGER) AS OVERLOAD, ' +
        'A.COLUMN_NAME AS PARAM_NAME, ' +
        'ROWNUM() AS PARAM_POSITION, ' +
        'CASE WHEN A.COLUMN_TYPE = 1 THEN ' + IntToStr(Integer(ptInput)) +
             'WHEN A.COLUMN_TYPE = 3 THEN ' + IntToStr(Integer(ptOutput)) + ' ELSE 0 END AS PARAM_TYPE, ' +
        EncodeDataType('A.TYPE_NAME', 'A.LENGTH', 'A.SCALE') + ' AS PARAM_DATATYPE, ' +
        'A.TYPE_NAME AS PARAM_TYPENAME, ' +
        EncodeAttrs('A.TYPE_NAME', '', '') + ' AS PARAM_ATTRIBUTES, ' +
        EncodePrec('A.TYPE_NAME', 'A.PRECISION') + ' AS PARAM_PRECISION, ' +
        EncodeScale('A.TYPE_NAME', 'A.SCALE') + ' AS PARAM_SCALE, ' +
        EncodeLength('A.TYPE_NAME', 'A.LENGTH') + ' AS PARAM_LENGTH ' +
        'FROM (EXECUTE PROCEDURE sp_GetProcedureColumns(' + AddParam(ACatalog, 'CAT') +
          ', NULL, ' + AddParam(AObject, 'OBJ') + ', NULL)) A';
      if AWildcard <> '' then
        AddWhere('A.COLUMN_NAME LIKE :WIL', 'WIL');
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
function TFDPhysNexusCommandGenerator.GetLimitSelect(const ASQL: String;
  ASkip, ARows: Integer): String;
begin
  if ASkip > 0 then
    Result := 'SELECT TOP ' + IntToStr(ARows) + ', ' + IntToStr(ASkip + 1) +
      ' A.* FROM (' + BRK + ASQL + BRK + ') A'
  else if ARows >= 0 then
    Result := 'SELECT TOP ' + IntToStr(ARows) +
      ' A.* FROM (' + BRK + ASQL + BRK + ') A'
  else
    Result := ASQL;
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterRDBMSKind(TFDRDBMSKinds.NexusDB, S_FD_Nexus_RDBMS);

end.
