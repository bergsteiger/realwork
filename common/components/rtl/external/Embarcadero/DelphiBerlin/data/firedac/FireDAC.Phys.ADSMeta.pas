{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{      FireDAC Advantage Database Server metadata       }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.ADSMeta;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.Meta, FireDAC.Phys.SQLGenerator;

type
  TFDPhysADSMetadata = class (TFDPhysConnectionMetadata)
  private
    FFreeConnection: Boolean;
  protected
    function GetKind: TFDRDBMSKind; override;
    function GetIsFileBased: Boolean; override;
    function GetTxSavepoints: Boolean; override;
    function GetTxNested: Boolean; override;
    function GetEventSupported: Boolean; override;
    function GetEventKinds: String; override;
    function GetTruncateSupported: Boolean; override;
    function GetParamNameMaxLength: Integer; override;
    function GetNameParts: TFDPhysNameParts; override;
    function GetNameCaseSensParts: TFDPhysNameParts; override;
    function GetNameDefLowCaseParts: TFDPhysNameParts; override;
    function GetNameQuoteChar(AQuote: TFDPhysNameQuoteLevel; ASide: TFDPhysNameQuoteSide): Char; override;
    function GetNamedParamMark: TFDPhysParamMark; override;
    function GetInlineRefresh: Boolean; override;
    function GetPositionedParamMark: TFDPhysParamMark; override;
    function GetSelectOptions: TFDPhysSelectOptions; override;
    function GetAsyncAbortSupported: Boolean; override;
    function GetAsyncNativeTimeout: Boolean; override;
    function GetDefValuesSupported: TFDPhysDefaultValues; override;
    function GetLockNoWait: Boolean; override;
    function GetNameQuotedCaseSensParts: TFDPhysNameParts; override;
    function GetArrayExecMode: TFDPhysArrayExecMode; override;
    function GetLimitOptions: TFDPhysLimitOptions; override;
    function GetColumnOriginProvided: Boolean; override;
    function InternalEscapeDate(const AStr: String): String; override;
    function InternalEscapeDateTime(const AStr: String): String; override;
    function InternalEscapeFloat(const AStr: String): String; override;
    function InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String; override;
    function InternalEscapeTime(const AStr: String): String; override;
    function InternalGetSQLCommandKind(const ATokens: TStrings): TFDPhysCommandKind; override;
  public
    constructor Create(const AConnectionObj: TFDPhysConnection;
      AServerVersion, AClientVerison: TFDVersion; AFreeConn: Boolean);
  end;

  TFDPhysADSCommandGenerator = class(TFDPhysCommandGenerator)
  protected
    function GetSingleRowTable: String; override;
    function GetRowId(var AAlias: String): String; override;
    function GetInlineRefresh(const AStmt: String; ARequest: TFDUpdateRequest): String; override;
    function GetIdentity(ASessionScope: Boolean): String; override;
    function GetPessimisticLock: String; override;
    function GetCall(const AName: String): String; override;
    function GetSavepoint(const AName: String): String; override;
    function GetRollbackToSavepoint(const AName: String): String; override;
    function GetStoredProcCall(const ACatalog, ASchema, APackage, AProc: String;
      ASPUsage: TFDPhysCommandKind): String; override;
    function GetSelectMetaInfo(AKind: TFDPhysMetaInfoKind; const ACatalog,
      ASchema, ABaseObject, AObject, AWildcard: String;
      AObjectScopes: TFDPhysObjectScopes; ATableKinds: TFDPhysTableKinds;
      AOverload: Word): String; override;
    function GetLimitSelect(const ASQL: String; ASkip, ARows: Integer): String; override;
    function GetColumnType(AColumn: TFDDatSColumn): String; override;
    function GetMerge(AAction: TFDPhysMergeAction): String; override;
  end;

implementation

uses
  System.SysUtils, Data.DB,
  FireDAC.Stan.Consts, FireDAC.Stan.Util, FireDAC.Stan.Param;

const
  // Copied from FireDAC.Phys.ADSCli
  ADS_MAX_OBJECT_NAME = 200;      // maximum length of DD object name
  ADS_MAX_FIELD_NAME = 128;

{-------------------------------------------------------------------------------}
{ TFDPhysADSMetadata                                                            }
{-------------------------------------------------------------------------------}
constructor TFDPhysADSMetadata.Create(const AConnectionObj: TFDPhysConnection;
  AServerVersion, AClientVerison: TFDVersion; AFreeConn: Boolean);
begin
  inherited Create(AConnectionObj, AServerVersion, AClientVerison, False);
  FKeywords.CommaText := 'ADD,ALL,ALTER,AND,ANY,AS,ASC,AT,AVG,BEGIN,BETWEEN,' +
    'BY,CASE,CAST,CLOSE,COLUMN,COMMIT,CONSTRAINT,COUNT,CREATE,CURSOR,' +
    'DECLARE,DEFAULT,DELETE,DESC,DISTINCT,DROP,ELSE,END,ESCAPE,EXECUTE,' +
    'EXISTS,FALSE,FETCH,FOR,FROM,FULL,FUNCTION,GRANT,GROUP,HAVING,IN,' +
    'INDEX,INNER,INSERT,INTO,IS,JOIN,KEY,LEFT,LIKE,MAX,MERGE,MIN,NOT,NULL,' +
    'OF,ON,OPEN,OR,ORDER,OUTER,OUTPUT,PRIMARY,PROCEDURE,RETURN,RETURNS,' +
    'REVOKE,RIGHT,ROLLBACK,SAVEPOINT,SELECT,SET,SQL,SUM,TABLE,THEN,TO,' +
    'TRANSACTION,TRUE,UNION,UNIQUE,UPDATE,USER,USING,VALUES,VIEW,WHEN,WHERE,WORK';
  FFreeConnection := AFreeConn;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.Advantage;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetIsFileBased: Boolean;
begin
  Result := FFreeConnection;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetNameQuotedCaseSensParts: TFDPhysNameParts;
begin
  Result := [npCatalog];
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetNameCaseSensParts: TFDPhysNameParts;
begin
  Result := [npCatalog];
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetNameDefLowCaseParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetParamNameMaxLength: Integer;
begin
  Result := ADS_MAX_FIELD_NAME;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetNameParts: TFDPhysNameParts;
begin
  Result := [npCatalog, npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetNameQuoteChar(AQuote: TFDPhysNameQuoteLevel;
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
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetNamedParamMark: TFDPhysParamMark;
begin
  Result := prName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetPositionedParamMark: TFDPhysParamMark;
begin
  Result := prQMark;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetTxSavepoints: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetTxNested: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetEventSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetEventKinds: String;
begin
  Result := S_FD_EventKind_ADS_Events;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetInlineRefresh: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetTruncateSupported: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetDefValuesSupported: TFDPhysDefaultValues;
begin
  if GetServerVersion >= caADS12 then
    Result := dvDefVals
  else
    Result := dvDef;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetLockNoWait: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetSelectOptions: TFDPhysSelectOptions;
begin
  if GetServerVersion >= caADS10 then
    Result := [soWithoutFrom, soInlineView]
  else
    Result := [soWithoutFrom];
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysADSMetadata.GetAsyncAbortSupported: Boolean;
begin
  Result := True;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysADSMetadata.GetAsyncNativeTimeout: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetArrayExecMode: TFDPhysArrayExecMode;
begin
  Result := aeUpToFirstError;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetLimitOptions: TFDPhysLimitOptions;
begin
  if GetServerVersion >= caADS10 then
    Result := [loSkip, loRows]
  else
    Result := [loRows];
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.GetColumnOriginProvided: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.InternalEscapeDate(const AStr: String): String;
begin
  Result := 'CAST(' + AnsiQuotedStr(AStr, '''') + ' AS SQL_DATE)';
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.InternalEscapeDateTime(const AStr: String): String;
begin
  Result := 'CAST(' + AnsiQuotedStr(AStr, '''') + ' AS SQL_TIMESTAMP)';
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.InternalEscapeTime(const AStr: String): String;
begin
  Result := 'CAST(' + AnsiQuotedStr(AStr, '''') + ' AS SQL_TIME)';
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.InternalEscapeFloat(const AStr: String): String;
begin
  Result := 'CAST(' + AnsiQuotedStr(AStr, '''') + ' AS SQL_DOUBLE)';
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String;
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
  efASCII,
  efBIT_LENGTH,
  efCHAR_LENGTH,
  efCONCAT,
  efCHAR,
  efINSERT,
  efLCASE,
  efLEFT,
  efLENGTH,
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
  efWEEK,
  efYEAR:
    Result := sName + AddArgs;

  // char:
  efPOSITION:
    Result := sName + '(' + A1 + ' IN ' + A2 + ')';
  // numeric
  efRANDOM:      Result := 'RAND' + AddArgs;
  efROUND,
  efTRUNCATE:
    if A2 = '' then
      Result := sName + '(' + A1 + ', 0)'
    else
      Result := sName + AddArgs;
  // date and time
  efEXTRACT:
    begin
      A1 := UpperCase(FDUnquote(Trim(A1), ''''));
      Result := sName + '(' + A1 + ' FROM ' + A2 + ')';
    end;
  efTIMESTAMPADD:
    begin
      A1 := UpperCase(FDUnquote(Trim(A1), ''''));
      if A1 = 'FRAC_SECOND' then
        A2 := '(' + A2 + ' / 1000)';
      Result := sName + '(SQL_TSI_' + A1 + ', ' + A2 + ', ' + A3 + ')';
    end;
  efTIMESTAMPDIFF:
    begin
      A1 := UpperCase(FDUnquote(Trim(A1), ''''));
      Result := sName + '(SQL_TSI_' + A1 + ', ' + A2 + ', ' + A3 + ')';
      if A1 = 'FRAC_SECOND' then
        Result := '(CAST(' + Result + ' AS SQL_NUMERIC(20,0)) * 1000)';
    end;
  // system
  efCATALOG:     Result := 'DATABASE()';
  efSCHEMA:      Result := '''''';
  efIF:          Result := 'IIF' + AddArgs;
  efIFNULL:
    begin
      A1 := UpperCase(Trim(A1));
      if A1 = 'NULL' then
        Result := A2
      else
        Result := sName + AddArgs;
    end;
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
      if A2 = 'DATETIME' then
        A2 := 'TIMESTAMP';
      Result := sName + '(' + A1 + ', SQL_' + A2 + ')';
    end;
  else
    UnsupportedEscape(ASeq);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSMetadata.InternalGetSQLCommandKind(
  const ATokens: TStrings): TFDPhysCommandKind;
var
  sToken: String;
begin
  sToken := ATokens[0];
  if sToken = 'DECLARE' then
    Result := skExecute
  else if sToken = 'BEGIN' then
    if ATokens.Count = 1 then
      Result := skNotResolved
    else if (ATokens[1] = 'TRAN') or (ATokens[1] = 'TRANSACTION') then
      Result := skStartTransaction
    else
      Result := inherited InternalGetSQLCommandKind(ATokens)
  else if sToken = 'SHOW' then
    if ATokens.Count = 1 then
      Result := skNotResolved
    else if ATokens[1] = 'PLAN' then
      Result := skSelect
    else
      Result := inherited InternalGetSQLCommandKind(ATokens)
  else if sToken = 'EXECUTE' then
    if ATokens.Count < 3 then
      Result := skNotResolved
    else if ATokens[1] = 'PROCEDURE' then begin
      if Copy(ATokens[2], 1, 7) = 'SP_DROP' then
        Result := skDrop
      else if Copy(ATokens[2], 1, 9) = 'SP_CREATE' then
        Result := skCreate
      else if Copy(ATokens[2], 1, 9) = 'SP_MODIFY' then
        Result := skAlter
      else
        Result := skExecute;
    end
    else
      Result := skExecute
  else
    Result := inherited InternalGetSQLCommandKind(ATokens);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysADSCommandGenerator                                                    }
{-------------------------------------------------------------------------------}
function TFDPhysADSCommandGenerator.GetInlineRefresh(const AStmt: String;
  ARequest: TFDUpdateRequest): String;
begin
  Result := GenerateSelect(False);
  if Result <> '' then
    Result := AStmt + ';' + BRK + Result
  else
    Result := AStmt;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommandGenerator.GetIdentity(ASessionScope: Boolean): String;
begin
  if ASessionScope then
    Result := 'LASTAUTOINC(CONNECTION)'
  else
    Result := 'LASTAUTOINC(STATEMENT)';
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommandGenerator.GetSingleRowTable: String;
begin
  Result := 'SYSTEM.IOTA';
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommandGenerator.GetRowId(var AAlias: String): String;
begin
  Result := 'ROWID';
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommandGenerator.GetPessimisticLock: String;
var
  lNeedFrom: Boolean;
begin
  Result := Result + 'SELECT ' + GetSelectList(True, False, lNeedFrom) +
    ' FROM ' + GetFrom + ' WHERE ' + GetWhere(False, True, False);
  FCommandKind := skSelectForLock;
  ASSERT(lNeedFrom);
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommandGenerator.GetSavepoint(const AName: String): String;
begin
  Result := 'SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommandGenerator.GetRollbackToSavepoint(const AName: String): String;
begin
  Result := 'ROLLBACK TO SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommandGenerator.GetCall(const AName: String): String;
begin
  Result := 'EXECUTE PROCEDURE ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommandGenerator.GetStoredProcCall(const ACatalog, ASchema,
  APackage, AProc: String; ASPUsage: TFDPhysCommandKind): String;
var
  i: Integer;
  sInPar: String;
  oParam: TFDParam;
  lHasOutput, lHasResult: Boolean;
  rName: TFDPhysParsedName;
  sProc: String;
begin
  sInPar := '';
  lHasOutput := False;
  lHasResult := False;
  for i := 0 to FParams.Count - 1 do begin
    oParam := FParams[i];
    if oParam.ParamType in [ptUnknown, ptInput, ptInputOutput] then begin
      if sInPar <> '' then
        sInPar := sInPar + ', ';
      sInPar := sInPar + ':' + oParam.SQLName;
    end;
    if oParam.ParamType in [ptOutput, ptInputOutput] then
      lHasOutput := True
    else if oParam.ParamType = ptResult then
      lHasResult := True;
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

  if lHasResult then
    Result := 'SELECT ' + sProc + '(' + sInPar + ') FROM ' + GetSingleRowTable
  else begin
    Result := 'EXECUTE PROCEDURE ' + sProc + '(' + sInPar + ')';
    if FCommandKind = skStoredProcWithCrs then
      Result := 'SELECT A.* FROM (' + Result + ') A';
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommandGenerator.GetSelectMetaInfo(AKind: TFDPhysMetaInfoKind;
  const ACatalog, ASchema, ABaseObject, AObject, AWildcard: String;
  AObjectScopes: TFDPhysObjectScopes; ATableKinds: TFDPhysTableKinds;
  AOverload: Word): String;
var
  lWasWhere: Boolean;
  sKinds: String;

  function AddParam(const AValue, AParam: String; ANull: Boolean = True): String;
  var
    oParam: TFDParam;
  begin
    if AValue <> '' then begin
      Result := ':' + AParam;
      oParam := GetParams.Add;
      oParam.Name := AParam;
      oParam.DataType := ftString;
      oParam.Size := ADS_MAX_OBJECT_NAME;
    end
    else if ANull then
      Result := 'NULL'
    else
      Result := '''''';
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
      oParam.Size := ADS_MAX_OBJECT_NAME;
    end;
  end;

  function EncodeDataType(const ATypeField, ALengthField, AScaleField: String): String;

    function DT2Str(AType: TFDDataType): String;
    begin
      Result := IntToStr(Integer(AType));
    end;

  begin
    Result :=
      'CASE' +
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
      ' WHEN ' + ATypeField + ' = ''GUID'' THEN ' + DT2Str(dtGUID) +
      ' ELSE ' + DT2Str(dtUnknown) +
      ' END';
  end;

  function EncodeAttrs(const ATypeField, ANullFieldName, ADefFieldName: String): String;

    function Attrs2Str(AAttrs: TFDDataAttributes): String;
    begin
      if AKind <> mkTableFields then
        Exclude(AAttrs, caBase);
      Result := IntToStr(PWord(@AAttrs)^);
    end;

  begin
    Result :=
      '(CASE' +
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
      ' + CASE' +
      ' WHEN (' + ADefFieldName + ' IS NOT NULL) AND (TRIM(' + ADefFieldName + ') <> '''') AND ' +
            '(TRIM(' + ADefFieldName + ') <> ''NULL'') THEN ' + Attrs2Str([caDefault]) +
      ' ELSE 0' +
      ' END';

    if ANullFieldName <> '' then
      Result := Result +
      ' + CASE' +
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
      'CASE' +
      ' WHEN ' + ATypeField + ' = ''CURDOUBLE'' THEN 15' +
      ' WHEN ' + ATypeField + ' = ''MONEY'' OR ' + ATypeField + ' = ''Money'' THEN 19' +
      ' WHEN ' + ATypeField + ' = ''NUMERIC'' OR ' + ATypeField + ' = ''Numeric'' THEN ' + APrecField +
      ' ELSE 0' +
      ' END';
  end;

  function EncodeScale(const ATypeField, AScaleField: String): String;
  begin
    Result :=
      'CASE' +
      ' WHEN ' + ATypeField + ' = ''CURDOUBLE'' THEN 4' +
      ' WHEN ' + ATypeField + ' = ''MONEY'' OR ' + ATypeField + ' = ''Money'' THEN 4' +
      ' WHEN ' + ATypeField + ' = ''NUMERIC'' OR ' + ATypeField + ' = ''Numeric'' THEN ' + AScaleField +
      ' ELSE 0' +
      ' END';
  end;

  function EncodeLength(const ATypeField, ALengthField: String): String;
  begin
    Result :=
      'CASE' +
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

  function EncodeRule(const ARuleField: String): String;
  begin
    Result :=
      'CASE' +
      ' WHEN ' + ARuleField + ' = 0 THEN ' + IntToStr(Integer(ckCascade)) +
      ' WHEN ' + ARuleField + ' = 2 THEN ' + IntToStr(Integer(ckSetNull)) +
      ' WHEN ' + ARuleField + ' = 3 THEN ' + IntToStr(Integer(ckRestrict)) +
      ' WHEN ' + ARuleField + ' = 4 THEN ' + IntToStr(Integer(ckSetDefault)) +
      ' ELSE ' + IntToStr(Integer(ckNone)) +
      ' END';
  end;

begin
  lWasWhere := False;
  Result := '';

  case AKind of
  mkCatalogs:
    begin
      Result := 'EXECUTE PROCEDURE sp_GetCatalogs()';
      if FConnMeta.ServerVersion >= caADS10 then
        Result := 'SELECT ROWNUM() AS RECNO, A.TABLE_CAT AS CATALOG_NAME ' +
                  'FROM (' + Result + ') A';
    end;

  mkSchemas:
    ;

  mkTables:
    begin
      if FConnMeta.ServerVersion >= caADS10 then
        Result := 'SELECT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
          'A.TABLE_CAT AS CATALOG_NAME, ' +
          'A.TABLE_SCHEM AS SCHEMA_NAME, ' +
          'A.TABLE_NAME, ' +
          'CASE' +
            ' WHEN A.TABLE_TYPE = ''TABLE'' THEN ' + IntToStr(Integer(tkTable)) +
            ' WHEN A.TABLE_TYPE = ''VIEW'' THEN ' + IntToStr(Integer(tkView)) +
            ' WHEN A.TABLE_TYPE = ''SYSTEM TABLE'' THEN ' + IntToStr(Integer(tkTable)) +
            ' WHEN A.TABLE_TYPE = ''LOCAL TEMPORARY'' THEN ' + IntToStr(Integer(tkLocalTable)) +
          ' END AS TABLE_TYPE, ' +
          'CASE' +
            ' WHEN A.TABLE_TYPE = ''SYSTEM TABLE'' THEN ' + IntToStr(Integer(osSystem)) +
            ' ELSE ' + IntToStr(Integer(osMy)) +
          ' END AS TABLE_SCOPE ' +
          'FROM (';
      Result := Result +
        'EXECUTE PROCEDURE sp_GetTables(' + AddParam(ACatalog, 'CAT', False) +
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
      Result := Result + ', ''' + Copy(sKinds, 1, Length(sKinds) - 1) + ''')';
      if FConnMeta.ServerVersion >= caADS10 then
        Result := Result + ') A' +
          ' ORDER BY 4';
    end;

  mkTableFields:
    begin
      if FConnMeta.ServerVersion >= caADS10 then
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
          'FROM (';
      Result := Result +
        'EXECUTE PROCEDURE sp_GetColumns(' + AddParam(ACatalog, 'CAT') +
            ', NULL, ' + AddParam(AObject, 'OBJ') + ', ' + AddParam(AWildcard, 'WIL') +
        ')';
      if FConnMeta.ServerVersion >= caADS10 then
        Result := Result + ') A' +
          ' ORDER BY 6';
    end;

  mkIndexes:
    if FConnMeta.ServerVersion >= caADS10 then begin
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
    end
    else
      Result := 'EXECUTE PROCEDURE sp_GetIndexInfo(' + AddParam(ACatalog, 'CAT') +
            ', NULL, ' + AddParam(AObject, 'OBJ') + ', False, True)';

  mkIndexFields:
    begin
      if FConnMeta.ServerVersion >= caADS10 then
        Result := 'SELECT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
          'A.TABLE_CAT AS CATALOG_NAME, ' +
          'A.TABLE_SCHEM AS SCHEMA_NAME, ' +
          'A.TABLE_NAME, ' +
          'A.INDEX_NAME, ' +
          'A.COLUMN_NAME, ' +
          'A.ORDINAL_POSITION AS COLUMN_POSITION, ' +
          'A.ASC_OR_DESC AS SORT_ORDER, ' +
          'A.FILTER_CONDITION AS FILTER ' +
          'FROM (';
      Result := Result +
        'EXECUTE PROCEDURE sp_GetIndexInfo(' + AddParam(ACatalog, 'CAT') +
          ', NULL, ' + AddParam(ABaseObject, 'BAS') + ', False, True)';
      if FConnMeta.ServerVersion >= caADS10 then begin
        Result := Result + ') A';
        AddWhere('A.INDEX_NAME = :OBJ', 'OBJ');
        if AWildcard <> '' then
          AddWhere('A.COLUMN_NAME LIKE :WIL', 'WIL');
        Result := Result + ' ORDER BY 7';
      end;
    end;

  mkPrimaryKey:
    begin
      if FConnMeta.ServerVersion >= caADS10 then
        Result := 'SELECT DISTINCT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
          'A.TABLE_CAT AS CATALOG_NAME, ' +
          'A.TABLE_SCHEM AS SCHEMA_NAME, ' +
          'A.TABLE_NAME, ' +
          'A.PK_NAME AS INDEX_NAME, ' +
          'A.PK_NAME AS CONSTRAINT_NAME, ' +
          IntToStr(Integer(ikPrimaryKey)) + ' AS INDEX_TYPE ' +
          'FROM (';
      Result := Result +
        'EXECUTE PROCEDURE sp_GetPrimaryKeys(' + AddParam(ACatalog, 'CAT') +
          ', NULL, ' + AddParam(AObject, 'OBJ') + ')';
      if FConnMeta.ServerVersion >= caADS10 then begin
        Result := Result + ') A';
        if AWildcard <> '' then
          AddWhere('A.PK_NAME LIKE :WIL', 'WIL');
        Result := Result + ' ORDER BY 5';
      end;
    end;

  mkPrimaryKeyFields:
    begin
      if FConnMeta.ServerVersion >= caADS10 then
        Result := 'SELECT DISTINCT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
          'A.TABLE_CAT AS CATALOG_NAME, ' +
          'A.TABLE_SCHEM AS SCHEMA_NAME, ' +
          'A.TABLE_NAME, ' +
          'A.PK_NAME AS INDEX_NAME, ' +
          'A.COLUMN_NAME AS COLUMN_NAME, ' +
          'A.KEY_SEQ + 1 AS COLUMN_POSITION, ' +
          '''A'' AS SORT_ORDER, ' +
          'CAST(NULL AS SQL_VARCHAR(50)) AS FILTER ' +
          'FROM (';
      Result := Result +
        'EXECUTE PROCEDURE sp_GetPrimaryKeys(' + AddParam(ACatalog, 'CAT') +
          ', NULL, ' + AddParam(ABaseObject, 'BAS') + ')';
      if FConnMeta.ServerVersion >= caADS10 then begin
        Result := Result + ') A';
        if AWildcard <> '' then
          AddWhere('A.COLUMN_NAME LIKE :WIL', 'WIL');
        Result := Result + ' ORDER BY 7';
      end;
    end;

  mkForeignKeys:
    begin
      if FConnMeta.ServerVersion >= caADS10 then
        Result := 'SELECT DISTINCT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
          'A.FKTABLE_CAT AS CATALOG_NAME, ' +
          'A.FKTABLE_SCHEM AS SCHEMA_NAME, ' +
          'A.FKTABLE_NAME, ' +
          'A.FK_NAME AS FKEY_NAME, ' +
          'A.PKTABLE_CAT AS PKEY_CATALOG_NAME, ' +
          'A.PKTABLE_SCHEM AS PKEY_SCHEMA_NAME, ' +
          'A.PKTABLE_NAME AS PKEY_TABLE_NAME, ' +
          EncodeRule('A.DELETE_RULE') + ' AS DELETE_RULE, ' +
          EncodeRule('A.UPDATE_RULE') + ' AS UPDATE_RULE ' +
          'FROM (';
      Result := Result +
        'EXECUTE PROCEDURE sp_GetImportedKeys(' + AddParam(ACatalog, 'CAT') +
          ', NULL, ' + AddParam(AObject, 'OBJ') + ')';
      if FConnMeta.ServerVersion >= caADS10 then begin
        Result := Result + ') A';
        if AWildcard <> '' then
          AddWhere('A.FK_NAME LIKE :WIL', 'WIL');
        Result := Result + ' ORDER BY 5';
      end;
    end;

  mkForeignKeyFields:
    begin
      if FConnMeta.ServerVersion >= caADS10 then
        Result := 'SELECT CAST(NULL AS SQL_INTEGER) AS RECNO, ' +
          'A.FKTABLE_CAT AS CATALOG_NAME, ' +
          'A.FKTABLE_SCHEM AS SCHEMA_NAME, ' +
          'A.FKTABLE_NAME, ' +
          'A.FK_NAME AS FKEY_NAME, ' +
          'A.FKCOLUMN_NAME AS COLUMN_NAME, ' +
          'A.PKCOLUMN_NAME AS PKEY_COLUMN_NAME, ' +
          'A.KEY_SEQ AS COLUMN_POSITION ' +
          'FROM (';
      Result := Result +
        'EXECUTE PROCEDURE sp_GetImportedKeys(' + AddParam(ACatalog, 'CAT') +
          ', NULL, ' + AddParam(ABaseObject, 'BAS') + ')';
      if FConnMeta.ServerVersion >= caADS10 then begin
        Result := Result + ') A';
        AddWhere('A.FK_NAME = :OBJ', 'OBJ');
        if AWildcard <> '' then
          AddWhere('A.FKCOLUMN_NAME LIKE :WIL', 'WIL');
        Result := Result + ' ORDER BY 8';
      end;
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
    if FConnMeta.ServerVersion >= caADS10 then begin
                                                       
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
    end
    else
      if ABaseObject = '' then
        Result := 'EXECUTE PROCEDURE sp_GetProcedures(' + AddParam(ACatalog, 'CAT') +
          ', NULL, NULL)'
      else
        Result := '';

  mkProcArgs:
                                               
    if ABaseObject <> '' then
      Result := ''
    else begin
      if FConnMeta.ServerVersion >= caADS10 then
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
          'FROM (';
      Result := Result +
        'EXECUTE PROCEDURE sp_GetProcedureColumns(' + AddParam(ACatalog, 'CAT') +
          ', NULL, ' + AddParam(AObject, 'OBJ') + ', NULL)';
      if FConnMeta.ServerVersion >= caADS10 then begin
        Result := Result + ') A';
        if AWildcard <> '' then
          AddWhere('A.COLUMN_NAME LIKE :WIL', 'WIL');
      end;
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
function TFDPhysADSCommandGenerator.GetLimitSelect(const ASQL: String;
  ASkip, ARows: Integer): String;
var
  s: String;
begin
  if (ASkip + ARows <> MAXINT) and
     (CompareText(Copy(ASQL, 1, 6), 'SELECT') = 0) and
     (CompareText(Copy(ASQL, 1, 10), 'SELECT TOP') <> 0) then begin
    Result := 'SELECT TOP ';
    s := UpperCase(ASQL);

    if FConnMeta.ServerVersion < caADS10 then begin
      Inc(ARows, ASkip);
      if GetSQLOrderByPos > 0 then
        if HasKW(s, 'UNION') or HasKW(s, 'MINUS') or HasKW(s, 'INTERSECT') or
           HasKW(s, 'EXCEPT') then
          Result := Result + IntToStr(ARows) +
            ' * FROM (' + BRK + Copy(ASQL, 1, GetSQLOrderByPos - 1) + BRK + ') A' + BRK +
            Copy(ASQL, GetSQLOrderByPos, MAXINT)
        else if CompareText(Copy(ASQL, 1, 15), 'SELECT DISTINCT') = 0 then
          Result := 'SELECT TOP ' + IntToStr(ARows) +
            ' DISTINCT ' + Copy(ASQL, 16, MAXINT)
        else
          Result := Result + IntToStr(ARows) +
            Copy(ASQL, 7, MAXINT)
      else
        if HasKW(s, 'UNION') or HasKW(s, 'MINUS') or HasKW(s, 'INTERSECT') or
           HasKW(s, 'EXCEPT') then
          Result := Result + IntToStr(ARows) +
            ' * FROM (' + BRK + ASQL + BRK + ') A'
        else if CompareText(Copy(ASQL, 1, 15), 'SELECT DISTINCT') = 0 then
          Result := 'SELECT TOP ' + IntToStr(ARows) +
            ' DISTINCT ' + Copy(ASQL, 16, MAXINT)
        else
          Result := Result + IntToStr(ARows) +
            Copy(ASQL, 7, MAXINT);
    end

    else begin
      if GetSQLOrderByPos > 0 then
        if HasKW(s, 'UNION') or HasKW(s, 'MINUS') or HasKW(s, 'INTERSECT') or
           HasKW(s, 'EXCEPT') then
          Result := Result + IntToStr(ARows) + ' START AT ' + IntToStr(ASkip + 1) +
            ' * FROM (' + BRK + Copy(ASQL, 1, GetSQLOrderByPos - 1) + BRK + ') A' + BRK +
            Copy(ASQL, GetSQLOrderByPos, MAXINT)
        else if CompareText(Copy(ASQL, 1, 15), 'SELECT DISTINCT') = 0 then
          Result := 'SELECT TOP ' + IntToStr(ARows) + ' START AT ' +
            IntToStr(ASkip + 1) + ' DISTINCT ' + Copy(ASQL, 16, MAXINT)
        else
          Result := Result + IntToStr(ARows) + ' START AT ' + IntToStr(ASkip + 1) +
            Copy(ASQL, 7, MAXINT)
      else
        if HasKW(s, 'UNION') or HasKW(s, 'MINUS') or HasKW(s, 'INTERSECT') or
           HasKW(s, 'EXCEPT') then
          Result := Result + IntToStr(ARows) + ' START AT ' + IntToStr(ASkip + 1) +
            ' * FROM (' + BRK + ASQL + BRK + ') A'
        else if CompareText(Copy(ASQL, 1, 15), 'SELECT DISTINCT') = 0 then
          Result := 'SELECT TOP ' + IntToStr(ARows) + ' START AT ' +
            IntToStr(ASkip + 1) + ' DISTINCT ' + Copy(ASQL, 16, MAXINT)
        else
          Result := Result + IntToStr(ARows) + ' START AT ' + IntToStr(ASkip + 1) +
            Copy(ASQL, 7, MAXINT);
    end;
  end
  else
    Result := ASQL;
end;

{-------------------------------------------------------------------------------}
                                                                    
function TFDPhysADSCommandGenerator.GetColumnType(AColumn: TFDDatSColumn): String;
var
  eAttrs: TFDDataAttributes;
begin
  eAttrs := AColumn.ActualAttributes;
  if [caAutoInc, caRowVersion] * eAttrs <> [] then begin
    if caAutoInc in AColumn.ActualAttributes then
      Result := 'AUTOINC'
    else if caRowVersion in AColumn.ActualAttributes then
      Result := 'ROWVERSION';
    Exit;
  end;
  case AColumn.DataType of
  dtBoolean:
    Result := 'LOGICAL';
  dtSByte,
  dtInt16,
  dtByte:
    Result := 'SHORTINT';
  dtInt32,
  dtUInt16:
    Result := 'INTEGER';
  dtInt64,
  dtUInt32,
  dtUInt64:
    Result := 'LONG';
  dtSingle,
  dtDouble,
  dtExtended:
    Result := 'DOUBLE';
  dtCurrency:
    Result := 'MONEY';
  dtBCD,
  dtFmtBCD:
    Result := 'NUMERIC' + GetColumnDim(-1, AColumn.Precision, AColumn.Scale, -1,
      FOptions.FormatOptions.MaxBcdPrecision, FOptions.FormatOptions.MaxBcdScale);
  dtTime:
    Result := 'TIME';
  dtDate:
    Result := 'DATE';
  dtDateTime,
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
        Result := 'RAW'
      else
        Result := 'VARBINARY';
      Result := Result + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1);
    end;
  dtBlob,
  dtHBlob,
  dtHBFile:
    Result := 'BINARY';
  dtMemo,
  dtHMemo:
    Result := 'MEMO';
  dtWideMemo,
  dtXML,
  dtWideHMemo:
    Result := 'NMEMO';
  dtGUID:
    if FConnMeta.ServerVersion >= caADS12 then
      Result := 'GUID'
    else
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
function TFDPhysADSCommandGenerator.GetMerge(AAction: TFDPhysMergeAction): String;

  function GetMatched: String;
  begin
    Result := 'WHEN MATCHED THEN UPDATE SET ' + GetUpdate();
  end;

  function GetNotMatched: String;
  begin
    Result := 'WHEN NOT MATCHED THEN INSERT ' + GetInsert('');
  end;

begin
  Result := 'MERGE INTO ' + GetFrom + BRK + ' ON ' + GetWhere(False, True, False) + BRK;
  case AAction of
  maInsertUpdate: Result := Result + GetNotMatched() + BRK + GetMatched();
  maInsertIgnore: Result := Result + GetNotMatched();
  end;
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterRDBMSKind(TFDRDBMSKinds.Advantage, S_FD_ADS_RDBMS);

end.
