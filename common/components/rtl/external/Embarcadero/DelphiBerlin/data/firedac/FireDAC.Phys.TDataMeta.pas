{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{              FireDAC Teradata metadata                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.TDataMeta;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Consts,
  FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.Meta, FireDAC.Phys.SQLGenerator;

type
  TFDTDataSessionMode = (tmTeradata, tmANSI);

  /// <summary> IFDPhysTDataConnectionMetadata interface provides FireDAC Teradata
  ///  driver specific metadata extension. </summary>
  IFDPhysTDataConnectionMetadata = interface (IUnknown)
    ['{CB231063-11DB-4E0D-A8FF-C25795997A1C}']
    // private
    function GetSessionMode: TFDTDataSessionMode;
    // public
    property SessionMode: TFDTDataSessionMode read GetSessionMode;
  end;

  /// <summary> TFDPhysTDataMetadata class implements FireDAC Teradata
  ///  driver specific metadata provider. </summary>
  TFDPhysTDataMetadata = class (TFDPhysConnectionMetadata, IFDPhysTDataConnectionMetadata)
  private
    FColumnOriginProvided: Boolean;
    FSessionMode: TFDTDataSessionMode;
  protected
    // IFDPhysConnectionMetadata
    function GetKind: TFDRDBMSKind; override;
    function GetTxAtomic: Boolean; override;
    function GetIdentityInsertSupported: Boolean; override;
    function GetInlineRefresh: Boolean; override;
    function GetIdentityInWhere: Boolean; override;
    function GetParamNameMaxLength: Integer; override;
    function GetNameParts: TFDPhysNameParts; override;
    function GetNameQuotedCaseSensParts: TFDPhysNameParts; override;
    function GetDefValuesSupported: TFDPhysDefaultValues; override;
    function GetSelectOptions: TFDPhysSelectOptions; override;
    function GetAsyncAbortSupported: Boolean; override;
    function GetAsyncNativeTimeout: Boolean; override;
    function GetArrayExecMode: TFDPhysArrayExecMode; override;
    function GetColumnOriginProvided: Boolean; override;
    procedure DefineMetadataStructure(ATable: TFDDatSTable;
      AKind: TFDPhysMetaInfoKind); override;
    function GetResultSetFields(const ASQLKey: String): TFDDatSView; override;
    function InternalEscapeBoolean(const AStr: String): String; override;
    function InternalEscapeDate(const AStr: String): String; override;
    function InternalEscapeDateTime(const AStr: String): String; override;
    function InternalEscapeFloat(const AStr: String): String; override;
    function InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String; override;
    function InternalEscapeTime(const AStr: String): String; override;
    function InternalGetSQLCommandKind(const ATokens: TStrings): TFDPhysCommandKind; override;
    // IFDPhysTDataConnectionMetadata
    function GetSessionMode: TFDTDataSessionMode;
  public
    constructor Create(const AConnectionObj: TFDPhysConnection;
      AServerVersion, AClientVersion: TFDVersion; const ACSVKeywords: String;
      AColumnOriginProvided: Boolean; ASessionMode: TFDTDataSessionMode);
  end;

  /// <summary> TFDPhysTDataCommandGenerator class implements FireDAC Teradata
  ///  driver specific SQL command generator. </summary>
  TFDPhysTDataCommandGenerator = class(TFDPhysCommandGenerator)
  protected
    function GetInlineRefresh(const AStmt: String; ARequest: TFDUpdateRequest): String; override;
    function GetPessimisticLock: String; override;
    function GetTruncate: String; override;
    function GetCall(const AName: String): String; override;
    function GetSelectMetaInfo(AKind: TFDPhysMetaInfoKind;
      const ACatalog, ASchema, ABaseObject, AObject, AWildcard: String;
      AObjectScopes: TFDPhysObjectScopes; ATableKinds: TFDPhysTableKinds;
      AOverload: Word): String; override;
    function GetLimitSelect(const ASQL: String; ASkip, ARows: Integer): String; override;
    function GetColumnType(AColumn: TFDDatSColumn): String; override;
    function GetColumnDef(AColumn: TFDDatSColumn): String; override;
    function GetCreateTable(const ATab, ACols: String): String; override;
    function GetMerge(AAction: TFDPhysMergeAction): String; override;
  end;

const
  C_FD_TDataINTO: String = '/*' + C_FD_SysNamePrefix + 'INTO';

implementation

uses
  System.SysUtils, Data.DB,
  FireDAC.Stan.Util, FireDAC.Stan.Param;

{-------------------------------------------------------------------------------}
{ TFDPhysTDataMetadata                                                          }
{-------------------------------------------------------------------------------}
constructor TFDPhysTDataMetadata.Create(const AConnectionObj: TFDPhysConnection;
  AServerVersion, AClientVersion: TFDVersion; const ACSVKeywords: String;
  AColumnOriginProvided: Boolean; ASessionMode: TFDTDataSessionMode);
begin
  inherited Create(AConnectionObj, AServerVersion, AClientVersion, True);
  if ACSVKeywords <> '' then
    FKeywords.CommaText := ACSVKeywords;
  FColumnOriginProvided := AColumnOriginProvided;
  FSessionMode := ASessionMode;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.GetKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.Teradata;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.GetTxAtomic: Boolean;
begin
  Result := FSessionMode = tmTeradata;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.GetIdentityInsertSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.GetInlineRefresh: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.GetIdentityInWhere: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.GetParamNameMaxLength: Integer;
begin
  if GetServerVersion >= tvTData1410 then
    Result := 128
  else
    Result := 30;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.GetNameParts: TFDPhysNameParts;
begin
  Result := [npSchema, npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.GetNameQuotedCaseSensParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.GetDefValuesSupported: TFDPhysDefaultValues;
begin
  Result := dvDefVals;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.GetSelectOptions: TFDPhysSelectOptions;
begin
  Result := [soWithoutFrom, soInlineView];
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.GetAsyncAbortSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.GetAsyncNativeTimeout: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.GetArrayExecMode: TFDPhysArrayExecMode;
begin
  Result := aeOnErrorUndoAll;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.GetColumnOriginProvided: Boolean;
begin
  Result := FColumnOriginProvided;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.GetSessionMode: TFDTDataSessionMode;
begin
  Result := FSessionMode;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataMetadata.DefineMetadataStructure(ATable: TFDDatSTable;
  AKind: TFDPhysMetaInfoKind);
begin
  inherited DefineMetadataStructure(ATable, AKind);
  case AKind of
  mkResultSetFields:
    begin
      AddMetadataCol(ATable, 'TABLE_NAME',     dtWideString);
      AddMetadataCol(ATable, 'COLUMN_NAME',    dtWideString);
      AddMetadataCol(ATable, 'ISIDENTITY',     dtSByte);
      AddMetadataCol(ATable, 'HASDEFAULT',     dtSByte);
      AddMetadataCol(ATable, 'IN_PKEY',        dtSByte);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.GetResultSetFields(const ASQLKey: String): TFDDatSView;
begin
  Result := inherited GetResultSetFields(ASQLKey);
  Result.Mechanisms.AddSort('TABLE_NAME;COLUMN_NAME');
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.InternalEscapeBoolean(const AStr: String): String;
begin
  if CompareText(AStr, S_FD_True) = 0 then
    Result := '1'
  else
    Result := '0';
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.InternalEscapeDate(const AStr: String): String;
begin
  Result := 'TO_DATE(' + AnsiQuotedStr(AStr, '''') + ', ''YYYY-MM-DD'')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.InternalEscapeDateTime(const AStr: String): String;
begin
  Result := 'TO_DATE(' + AnsiQuotedStr(AStr, '''') + ', ''YYYY-MM-DD HH24:MI:SS'')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.InternalEscapeTime(const AStr: String): String;
begin
  Result := 'TIME ' + AnsiQuotedStr(AStr, '''');
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.InternalEscapeFloat(const AStr: String): String;
begin
  Result := 'TO_NUMBER(' + AnsiQuotedStr(AStr, '''') + ')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String;
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
  efLENGTH,
  efOCTET_LENGTH,
  // numeric
  efACOS,
  efASIN,
  efATAN,
  efATAN2,
  efABS,
  efCOS,
  efDEGREES,
  efEXP,
  efRADIANS,
  efSIN,
  efSQRT,
  efTAN:         Result := sName + AddArgs;
  // character
  efBIT_LENGTH:  Result := '(OCTET_LENGTH(' + A1 + ') * 8)';
  efCHAR:        Result := 'CHR' + AddArgs;
  efCONCAT:      Result := '((' + A1 + ') || (' + A2 + '))';
  efINSERT:      Result := '(SUBSTRING(' + A1 + ' FROM 1 FOR (' + A2 + ') - 1) || ' + A4 +
                  ' || SUBSTRING(' + A1 + ' FROM (' + A2 + ' + ' + A3 + ')))';
  efLCASE:       Result := 'LOWER' + AddArgs;
  efLEFT:        Result := 'SUBSTRING(' + A1 + ' FROM 1 FOR ' + A2 + ')';
  efPOSITION,
  efLOCATE:
    begin
      if Length(ASeq.FArgs) >= 3 then
        UnsupportedEscape(ASeq);
      Result := 'POSITION(' + A1 + ' IN ' + A2 + ')';
    end;
  efLTRIM:       Result := 'TRIM(LEADING FROM ' + A1 + ')';
  efREPEAT:      Result := 'CASE ' +
    ' WHEN ' + A2 + ' = 1 THEN ' + A1 +
    ' WHEN ' + A2 + ' = 2 THEN ' + A1 + ' || ' + A1 +
    ' WHEN ' + A2 + ' = 3 THEN ' + A1 + ' || ' + A1 + ' || ' + A1 +
    ' WHEN ' + A2 + ' = 4 THEN ' + A1 + ' || ' + A1 + ' || ' + A1 + ' || ' + A1 +
    ' WHEN ' + A2 + ' = 5 THEN ' + A1 + ' || ' + A1 + ' || ' + A1 + ' || ' + A1 + ' || ' + A1 +
    ' WHEN ' + A2 + ' = 6 THEN ' + A1 + ' || ' + A1 + ' || ' + A1 + ' || ' + A1 + ' || ' + A1 + ' || ' + A1 +
    ' WHEN ' + A2 + ' = 7 THEN ' + A1 + ' || ' + A1 + ' || ' + A1 + ' || ' + A1 + ' || ' + A1 + ' || ' + A1 + ' || ' + A1 +
    ' WHEN ' + A2 + ' = 8 THEN ' + A1 + ' || ' + A1 + ' || ' + A1 + ' || ' + A1 + ' || ' + A1 + ' || ' + A1 + ' || ' + A1 + ' || ' + A1 +
    ' ELSE '''' END';
  efREPLACE:     Result := 'OREPLACE' + AddArgs;
  efRIGHT:       Result := 'SUBSTRING(' + A1 + ' FROM LENGTH(' + A1 + ') + 1 - (' + A2 + '))';
  efRTRIM:       Result := 'TRIM(TRAILING FROM ' + A1 + ')';
  efSPACE:       Result := 'SUBSTR(''                                                  '', 1, ' + A1 + ')';
  efSUBSTRING:   Result := 'SUBSTR' + AddArgs;
  efUCASE:       Result := 'UPPER' + AddArgs;
  // numeric
  efCEILING:
    if GetServerVersion >= tvTData1400 then
      Result := 'CEIL' + AddArgs
    else
      UnsupportedEscape(ASeq);
  efCOT:         Result := '(1 / TAN(' + A1 + '))';
  efFLOOR:
    if GetServerVersion >= tvTData1400 then
      Result := 'FLOOR' + AddArgs
    else
      UnsupportedEscape(ASeq);
  efLOG:         Result := 'LN' + AddArgs;
  efLOG10:       Result := 'LOG' + AddArgs;
  efMOD:         Result := '((' + A1 + ') MOD (' + A2 + '))';
  efPOWER:       Result := '((' + A1 + ') ** (' + A2 + '))';
  efSIGN:        Result := 'CASE WHEN ' + A1 + ' > 0 THEN 1 WHEN ' + A1 + ' < 0 THEN -1 ELSE 0 END';
  efPI:          Result := S_FD_Pi;
  efRANDOM:      Result := 'RANDOM(0, 2147483647)';
  efROUND:
    if GetServerVersion >= tvTData1400 then
      Result := 'ROUND' + AddArgs
    else
      Result := 'CAST(' + A1 + ', DECIMAL(18, ' + A2 + ')';
  efTRUNCATE:    Result := 'TRUNC' + AddArgs;
  // date and time
  efCURDATE:     Result := 'CURRENT_DATE';
  efCURTIME:     Result := 'CURRENT_TIME';
  efDAYNAME:     Result := 'CAST(CAST(' + A1 + ' AS FORMAT''E4'') AS VARCHAR(10))';
  efDAYOFMONTH:  Result := 'EXTRACT(DAY FROM ' + A1 + ')';
  efDAYOFWEEK:   Result := '(((' + A1 + ') - DATE ''1900-01-01'' + 2) MOD 7)';
  efDAYOFYEAR:   Result := '((' + A1 + ') - CAST(TRIM(EXTRACT(YEAR FROM ' + A1 + ')) || ''/01/01'' AS DATE FORMAT ''YYYY/MM/DD'') + 1)';
  efEXTRACT:     Result := 'EXTRACT(' + UpperCase(FDUnquote(Trim(A1), '''')) + ' FROM ' + A2 + ')';
  efHOUR:        Result := 'EXTRACT(HOUR FROM ' + A1 + ')';
  efMINUTE:      Result := 'EXTRACT(MINUTE FROM ' + A1 + ')';
  efMONTH:       Result := 'EXTRACT(MONTH FROM ' + A1 + ')';
  efMONTHNAME:   Result := 'CAST(CAST(' + A1 + ' AS FORMAT''M4'') AS VARCHAR(10))';
  efNOW:         Result := 'CURRENT_TIMESTAMP';
  efQUARTER:     Result := 'CAST(EXTRACT(MONTH FROM ' + A1 + ') / 3 + 1 AS INTEGER)';
  efSECOND:      Result := 'EXTRACT(SECOND FROM ' + A1 + ')';
  efYEAR:        Result := 'EXTRACT(YEAR FROM ' + A1 + ')';
  efTIMESTAMPADD:
    begin
      A1 := UpperCase(FDUnquote(Trim(A1), ''''));
      A2 := Trim(A2);
      if A1 = 'YEAR' then
        Result := 'ADD_MONTHS(' + A3 + ', 12 * (' + A2 + '))'
      else if A1 = 'MONTH' then
        Result := 'ADD_MONTHS(' + A3 + ', ' + A2 + ')'
      else if A1 = 'WEEK' then
        Result := '(' + A3 + ' + INTERVAL ''' + IntToStr(StrToInt(A2) * 7) + ''' DAY)'
      else if A1 = 'DAY' then
        Result := '(' + A3 + ' + INTERVAL ''' + A2 + ''' DAY)'
      else if A1 = 'HOUR' then
        Result := '(' + A3 + ' + INTERVAL ''' + A2 + ''' HOUR)'
      else if A1 = 'MINUTE' then
        Result := '(' + A3 + ' + INTERVAL ''' + A2 + ''' MINUTE)'
      else if A1 = 'SECOND' then
        Result := '(' + A3 + ' + INTERVAL ''' + A2 + ''' SECOND)'
      else if A1 = 'FRAC_SECOND' then
        Result := '(' + A3 + ' + INTERVAL ''' + A2 + ''' FRACTION)'
      else
        UnsupportedEscape(ASeq);
    end;
  efTIMESTAMPDIFF:
    begin
      A1 := UpperCase(FDUnquote(Trim(A1), ''''));
      if A1 = 'YEAR' then
        Result := 'CAST(((' + A3 + ') - (' + A2 + ') YEAR(4)) AS INTEGER)'
      else if A1 = 'MONTH' then
        Result := 'CAST(((' + A3 + ') - (' + A2 + ') MONTH(3)) AS INTEGER)'
      else if A1 = 'WEEK' then
        Result := 'CAST(((' + A3 + ') - (' + A2 + ')) / 7 AS INTEGER)'
      else if A1 = 'DAY' then
        Result := 'CAST((' + A3 + ') - (' + A2 + ') AS INTEGER)'
      else if A1 = 'HOUR' then
        Result := 'CAST(((' + A3 + ') - (' + A2 + ')) * 24.0 AS INTEGER)'
      else if A1 = 'MINUTE' then
        Result := 'CAST(((' + A3 + ') - (' + A2 + ')) * (24.0 * 60.0) AS INTEGER)'
      else if A1 = 'SECOND' then
        Result := 'CAST(((' + A3 + ') - (' + A2 + ')) * (24.0 * 60.0 * 60.0) AS INTEGER)'
      else if A1 = 'FRAC_SECOND' then
        Result := 'CAST(((' + A3 + ') - (' + A2 + ')) * (24.0 * 60.0 * 60.0 * 1000000.0) AS INTEGER)'
      else
        UnsupportedEscape(ASeq);
    end;
  // system
  efCATALOG:     Result := '''''';
  efSCHEMA:      Result := 'USER';
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
      A2 := UpperCase(FDUnquote(Trim(A2), ''''));
      if A2 = 'BIT' then
        A2 := 'BYTEINT'
      else if A2 = 'BIGINT' then
        A2 := 'INTEGER'
      else if A2 = 'BINARY' then
        A2 := 'BYTE'
      else if A2 = 'GUID' then
        A2 := 'CHAR(38)'
      else if A2 = 'LONGVARBINARY' then
        A2 := 'VARBYTE'
      else if A2 = 'LONGVARCHAR' then
        A2 := 'LONG VARCHAR'
      else if A2 = 'VARBINARY' then
        A2 := 'VARBYTE'
      else if A2 = 'WCHAR' then
        A2 := 'CHAR CHARACTER SET UNICODE'
      else if A2 = 'WLONGVARCHAR' then
        A2 := 'LONG VARCHAR CHARACTER SET UNICODE'
      else if A2 = 'WVARCHAR' then
        A2 := 'VARCHAR CHARACTER SET UNICODE'
      else if A2 = 'DATETIME' then
        A2 := 'TIMESTAMP';
      Result := 'CAST(' + A1 + ' AS ' + A2 + ')';
    end;
  else
    UnsupportedEscape(ASeq);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataMetadata.InternalGetSQLCommandKind(
  const ATokens: TStrings): TFDPhysCommandKind;
var
  sToken: String;
begin
  sToken := ATokens[0];
  if (sToken = 'CALL') or (sToken = 'EXECUTE') then
    Result := skExecute
  else if sToken = 'BEGIN' then
    if ATokens.Count = 1 then
      Result := skNotResolved
    else if ATokens[1] = 'TRANSACTION' then
      Result := skStartTransaction
    else
      Result := skOther
  else if sToken = 'BT' then
    Result := skStartTransaction
  else if sToken = 'END' then
    if ATokens.Count = 1 then
      Result := skNotResolved
    else if ATokens[1] = 'TRANSACTION' then
      Result := skCommit
    else
      Result := skOther
  else if sToken = 'ET' then
    Result := skCommit
  else if sToken = 'ABORT' then
    Result := skRollback
  else if sToken = 'DATABASE' then
    Result := skSetSchema
  else if (sToken = 'SHOW') or (sToken = 'HELP') or (sToken = 'SEL') or
          (sToken = 'EXPLAIN') then
    Result := skSelect
  else if sToken = 'LOCKING' then
    Result := skSelectForLock
  else if (sToken = 'REPLACE') or (sToken = 'MODIFY') then
    Result := skAlter
  else if sToken = 'DEL' then
    Result := skDelete
  else
    Result := inherited InternalGetSQLCommandKind(ATokens);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysTDataCommandGenerator                                                  }
{-------------------------------------------------------------------------------}
function TFDPhysTDataCommandGenerator.GetInlineRefresh(const AStmt: String;
  ARequest: TFDUpdateRequest): String;
var
  sRet, sCol: String;
  oView: TFDDatSView;
  oCols: TFDDatSColumnList;
  oRow: TFDDatSRow;
  oCol: TFDDatSColumn;
  i, j: Integer;
  rName: TFDPhysParsedName;
  lFound, lIdentity: Boolean;
begin
  lFound := False;
  lIdentity := True;
  sRet := '';
  oCols := FTable.Columns;
  FConnMeta.DecodeObjName(GetFrom(), rName, nil, [doUnquote, doNormalize]);
  oView := FConnMeta.GetResultSetFields(rName.FObject);
  try
    oView.Sort := 'RECNO';
    for i := 0 to oView.Rows.Count - 1 do begin
      oRow := oView.Rows[i];
      sCol := '';
      for j := 0 to oCols.Count - 1 do begin
        oCol := oCols[j];
        if ColumnStorable(oCol) and ColumnReqRefresh(ARequest, oCol) and
           (CompareText(FConnMeta.UnQuoteObjName(oCol.OriginTabName), oRow.GetData('TABLE_NAME')) = 0) and
           (CompareText(FConnMeta.UnQuoteObjName(oCol.OriginColName), oRow.GetData('COLUMN_NAME')) = 0) then begin
          lFound := True;
          if not (caAutoInc in oCol.ActualAttributes) then
            lIdentity := False;
          sCol := oCol.SourceName;
          Break;
        end;
      end;
      if sRet <> '' then
        sRet := sRet + ';';
      sRet := sRet + sCol;
    end;
  finally
    FDClearMetaView(oView, FOptions.FetchOptions);
  end;
  Result := AStmt;
  if lFound then begin
    Result := Result + BRK + C_FD_TDataINTO + ' ';
    if lIdentity then
      Result := Result + '# '
    else
      Result := Result + '* ';
    Result := Result + sRet + '*/';
    FCommandKind := skSelectForLock;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataCommandGenerator.GetPessimisticLock: String;
var
  lNeedFrom: Boolean;
begin
  Result := 'LOCKING ROW FOR WRITE ';
  if not FOptions.UpdateOptions.LockWait then
    Result := Result + 'MODE NOWAIT ';
  Result := Result + BRK + 'SELECT ' + GetSelectList(True, False, lNeedFrom) + BRK +
    'FROM ' + GetFrom + BRK + 'WHERE ' + GetWhere(False, True, False);
  FCommandKind := skSelectForLock;
  ASSERT(lNeedFrom);
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataCommandGenerator.GetTruncate: String;
begin
  Result := 'DELETE FROM ' + GetFrom + ' ALL';
  FCommandKind := skDelete;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataCommandGenerator.GetCall(const AName: String): String;
begin
  Result := 'CALL ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataCommandGenerator.GetSelectMetaInfo(AKind: TFDPhysMetaInfoKind;
  const ACatalog, ASchema, ABaseObject, AObject, AWildcard: String;
  AObjectScopes: TFDPhysObjectScopes; ATableKinds: TFDPhysTableKinds;
  AOverload: Word): String;
var
  oParam: TFDParam;
  oTDataConnMeta: IFDPhysTDataConnectionMetadata;
begin
  case AKind of
  mkResultSetFields:
    begin
      Supports(FConnMeta, IFDPhysTDataConnectionMetadata, oTDataConnMeta);
      Result := 'SELECT CAST(NULL AS INTEGER) AS RECNO, UPPER(TRIM(TRAILING FROM C.TableName)) AS RESULTSET_KEY, ' +
        'TRIM(TRAILING FROM C.TableName) AS TABLE_NAME, TRIM(TRAILING FROM C.ColumnName) AS COLUMN_NAME, ' +
        'CASE WHEN C.IdColType = ''GA'' OR C.IdColType = ''GD'' THEN 1 ELSE 0 END AS ISIDENTITY, ' +
        'CASE WHEN C.DefaultValue IS NOT NULL THEN 1 ELSE 0 END AS HASDEFAULT, ' +
        'CASE WHEN I.ColumnPosition IS NOT NULL THEN 1 ELSE 0 END AS IN_PKEY ' +
      'FROM DBC.ColumnsX C LEFT OUTER JOIN DBC.IndicesX I ON ' +
        'C.DatabaseName = I.DatabaseName AND ' +
        'C.TableName = I.TableName AND ' +
        'C.ColumnName = I.ColumnName AND ' +
        'I.IndexType = ''K'' ' +
      'WHERE ';
      if oTDataConnMeta.SessionMode = tmTeradata then
        Result := Result + 'C.DatabaseName = DATABASE AND C.TableName = ? '
      else
        Result := Result + 'UPPER(C.DatabaseName) = UPPER(DATABASE) AND UPPER(C.TableName) = UPPER(?) ';
      Result := Result + 'ORDER BY C.ColumnID';
      oParam := GetParams.Add;
      oParam.Name := 'OBJ';
      oParam.DataType := ftString;
      oParam.Size := 128;
    end;
  else
    Result := inherited GetSelectMetaInfo(AKind, ACatalog, ASchema, ABaseObject, 
      AObject, AWildcard, AObjectScopes, ATableKinds, AOverload);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataCommandGenerator.GetLimitSelect(const ASQL: String;
  ASkip, ARows: Integer): String;
var
  s: String;
begin
  if (ASkip + ARows <> MAXINT) and
     (CompareText(Copy(ASQL, 1, 6), 'SELECT') = 0) and
     (CompareText(Copy(ASQL, 1, 10), 'SELECT TOP') <> 0) then begin
    Result := 'SELECT TOP ';
    s := UpperCase(ASQL);
    // Teradata: does not support TOP 0 and returns "syntax error"
    if ARows = 0 then
      Result := 'SELECT * FROM (' + BRK + ASQL + BRK + ') A' + BRK + 'WHERE 0 = 1'
    else if HasKW(s, 'UNION') or HasKW(s, 'MINUS') or HasKW(s, 'INTERSECT') or
       HasKW(s, 'EXCEPT') or HasKW(s, 'DISTINCT') then
      if GetSQLOrderByPos > 0 then
        Result := Result + IntToStr(ASkip + ARows) + ' * FROM (' + BRK +
          Copy(ASQL, 1, GetSQLOrderByPos - 1) + BRK + ') A' + BRK +
          Copy(ASQL, GetSQLOrderByPos, MAXINT)
      else
        Result := Result + IntToStr(ASkip + ARows) + ' * FROM (' + BRK +
          ASQL + BRK + ') A'
    else
      Result := Result + IntToStr(ASkip + ARows) + Copy(ASQL, 7, MAXINT);
  end
  else
    Result := ASQL;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataCommandGenerator.GetColumnType(AColumn: TFDDatSColumn): String;
begin
  case AColumn.DataType of
  dtBoolean:
    Result := 'BYTEINT';
  dtSByte:
    Result := 'BYTEINT';
  dtInt16,
  dtByte:
    Result := 'SMALLINT';
  dtInt32,
  dtUInt16:
    Result := 'INTEGER';
  dtUInt32:
    Result := 'DECIMAL(10, 0)';
  dtInt64:
    Result := 'DECIMAL(19, 0)';
  dtUInt64:
    Result := 'DECIMAL(20, 0)';
  dtSingle,
  dtDouble,
  dtExtended:
    Result := 'FLOAT';
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
  dtTimeIntervalYM:
    Result := 'INTERVAL YEAR TO MONTH';
  dtTimeIntervalFull,
  dtTimeIntervalDS:
    Result := 'INTERVAL DAY TO SECOND';
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
        Result := 'CHAR'
      else
        Result := 'VARCHAR';
      Result := Result + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1) +
        ' CHARACTER SET UNICODE';
    end;
  dtByteString:
    begin
      if caFixedLen in AColumn.ActualAttributes then
        Result := 'BYTE'
      else
        Result := 'VARBYTE';
      Result := Result + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1);
    end;
  dtBlob,
  dtHBlob,
  dtHBFile:
    Result := 'BLOB';
  dtMemo,
  dtHMemo:
    Result := 'CLOB';
  dtWideMemo,
  dtWideHMemo:
    Result := 'CLOB CHARACTER SET UNICODE';
  dtXML:
    if FConnMeta.ServerVersion >= tvTData1300 then
      Result := 'XML'
    else
      Result := 'CLOB CHARACTER SET UNICODE';
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
function TFDPhysTDataCommandGenerator.GetColumnDef(AColumn: TFDDatSColumn): String;
begin
  Result := inherited GetColumnDef(AColumn);
  if (Result <> '') and (caAutoInc in AColumn.ActualAttributes) then
    Result := Result + ' GENERATED BY DEFAULT AS IDENTITY (START WITH 1 INCREMENT BY 1 NO CYCLE)';
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataCommandGenerator.GetCreateTable(const ATab, ACols: String): String;
begin
  Result := 'CREATE MULTISET TABLE ' + ATab + ' (' + BRK + ACols + BRK + ')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataCommandGenerator.GetMerge(AAction: TFDPhysMergeAction): String;
begin
  case AAction of
  maInsertUpdate: Result := GenerateUpdate() + BRK + 'ELSE ' + GenerateInsert();
  maInsertIgnore: Result := inherited GetMerge(AAction);
  end;
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterRDBMSKind(TFDRDBMSKinds.Teradata, S_FD_TData_RDBMS);

end.
