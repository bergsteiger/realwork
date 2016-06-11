{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{               FireDAC IBM DB2 metadata                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.DB2Meta;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys.Meta, FireDAC.Phys.SQLGenerator, FireDAC.Phys;

type
  TFDPhysDb2Metadata = class (TFDPhysConnectionMetadata)
  private
    FColumnOriginProvided: Boolean;
    FTxSupported: Boolean;
  protected
    function GetKind: TFDRDBMSKind; override;
    function GetTxSupported: Boolean; override;
    function GetTxSavepoints: Boolean; override;
    function GetEventSupported: Boolean; override;
    function GetEventKinds: String; override;
    function GetParamNameMaxLength: Integer; override;
    function GetNameParts: TFDPhysNameParts; override;
    function GetNameDefLowCaseParts: TFDPhysNameParts; override;
    function GetNameCaseSensParts: TFDPhysNameParts; override;
    function GetInlineRefresh: Boolean; override;
    function GetTruncateSupported: Boolean; override;
    function GetDefValuesSupported: TFDPhysDefaultValues; override;
    function GetSelectOptions: TFDPhysSelectOptions; override;
    function GetAsyncAbortSupported: Boolean; override;
    function GetArrayExecMode: TFDPhysArrayExecMode; override;
    function GetCreateTableOptions: TFDPhysCreateTableOptions; override;
    function GetBackslashEscSupported: Boolean; override;
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
      AColumnOriginProvided, ATxSupported: Boolean);
  end;

  TFDPhysDb2CommandGenerator = class(TFDPhysCommandGenerator)
  private
    function GetDB2Returning(const AStmt: String; ARequest: TFDUpdateRequest): String;
  protected
    function GetInlineRefresh(const AStmt: String;
      ARequest: TFDUpdateRequest): String; override;
    function GetIdentity(ASessionScope: Boolean): String; override;
    function GetSingleRowTable: String; override;
    function GetPessimisticLock: String; override;
    function GetSavepoint(const AName: String): String; override;
    function GetRollbackToSavepoint(const AName: String): String; override;
    function GetCommitSavepoint(const AName: String): String; override;
    function GetCall(const AName: String): String; override;
    function GetLimitSelect(const ASQL: String; ASkip, ARows: Integer): String; override;
    function GetColumnType(AColumn: TFDDatSColumn): String; override;
    function GetColumnDef(AColumn: TFDDatSColumn): String; override;
  end;

implementation

uses
  System.SysUtils,
  FireDAC.Stan.Consts, FireDAC.Stan.Util;

{-------------------------------------------------------------------------------}
{ TFDPhysDb2Metadata                                                            }
{-------------------------------------------------------------------------------}
constructor TFDPhysDb2Metadata.Create(const AConnectionObj: TFDPhysConnection;
  AServerVersion, AClientVersion: TFDVersion; const ACSVKeywords: String;
  AColumnOriginProvided, ATxSupported: Boolean);
begin
  inherited Create(AConnectionObj, AServerVersion, AClientVersion, False);
  if ACSVKeywords <> '' then
    FKeywords.CommaText := ACSVKeywords;
  FColumnOriginProvided := AColumnOriginProvided;
  FTxSupported := ATxSupported;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.DB2;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetNameCaseSensParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetNameDefLowCaseParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetParamNameMaxLength: Integer;
begin
  Result := 128;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetNameParts: TFDPhysNameParts;
begin
  Result := [npSchema, npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetInlineRefresh: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetTxSupported: Boolean;
begin
  Result := FTxSupported;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetTxSavepoints: Boolean;
begin
  Result := FTxSupported;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetEventSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetEventKinds: String;
begin
  Result := S_FD_EventKind_DB2_DBMS_ALERT + ';' + S_FD_EventKind_DB2_DBMS_PIPE;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetTruncateSupported: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetDefValuesSupported: TFDPhysDefaultValues;
begin
  Result := dvDef;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetSelectOptions: TFDPhysSelectOptions;
begin
  Result := [soInlineView];
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetAsyncAbortSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetArrayExecMode: TFDPhysArrayExecMode;
begin
  Result := aeCollectAllErrors;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetCreateTableOptions: TFDPhysCreateTableOptions;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetBackslashEscSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.GetColumnOriginProvided: Boolean;
begin
  Result := FColumnOriginProvided;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.InternalEscapeBoolean(const AStr: String): String;
begin
  if CompareText(AStr, S_FD_True) = 0 then
    Result := '1'
  else
    Result := '0';
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.InternalEscapeDate(const AStr: String): String;
begin
  Result := 'DATE(' + AnsiQuotedStr(AStr, '''') + ')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.InternalEscapeDateTime(const AStr: String): String;
begin
  if Pos(':', AStr) = 0 then
    Result := 'TIMESTAMP(' + AnsiQuotedStr(AStr + ' 00:00:00', '''') + ')'
  else
    Result := 'TIMESTAMP(' + AnsiQuotedStr(AStr, '''') + ')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.InternalEscapeTime(const AStr: String): String;
begin
  Result := 'TIME(''' + AStr + ''')';
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.InternalEscapeFloat(const AStr: String): String;
begin
  Result := AStr;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String;
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
  efCONCAT,
  efINSERT,
  efLEFT,
  efLENGTH,
  efLCASE,
  efLOCATE,
  efLTRIM,
  efREPLACE,
  efREPEAT,
  efRIGHT,
  efRTRIM,
  efSPACE,
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
  efRADIANS,
  efSIGN,
  efSIN,
  efSQRT,
  efTAN,
  // date and time
  efDAYNAME,
  efDAYOFWEEK,
  efDAYOFYEAR,
  efHOUR,
  efMINUTE,
  efMONTH,
  efMONTHNAME,
  efQUARTER,
  efSECOND,
  efWEEK,
  efYEAR:        Result := sName + AddArgs;
  // character
  efCHAR:        Result := 'CHR' + AddArgs;
  efBIT_LENGTH:  Result := '(LENGTH(' + A1 + ') * 8)';
  efCHAR_LENGTH: Result := 'LENGTH' + AddArgs;
  efOCTET_LENGTH:Result := 'LENGTH' + AddArgs;
  efPOSITION:    Result := 'POSSTR(' + A2 + ', ' + A1 + ')';
  efSUBSTRING:   Result := 'SUBSTR' + AddArgs;
  // numeric
  efTRUNCATE:    Result := sName + '(' + A1 + ', 0)';
  efPI:          Result := S_FD_Pi;
  efRANDOM:      Result := 'RAND' + AddArgs;
  efROUND:
    if A2 = '' then
      Result := sName + '(' + A1 + ', 0)'
    else
      Result := sName + AddArgs;
  // date and time
  efCURDATE:     Result := 'CURRENT_DATE';
  efCURTIME:     Result := 'CURRENT_TIME';
  efNOW:         Result := 'CURRENT_TIMESTAMP';
  efDAYOFMONTH:  Result := 'DAY' + AddArgs;
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
      if A1 = 'QUARTER' then begin
        A2 := '((' + A2 + ') * 3)';
        A1 := 'MONTH';
      end
      else if A1 = 'WEEK' then begin
        A2 := '((' + A2 + ') * 7)';
        A1 := 'DAY';
      end
      else if A1 = 'FRAC_SECOND' then
        A1 := 'MICROSECOND';
      Result := '((' + A3 + ') + (' + A2 + ') ' + A1 + ')';
    end;
  efTIMESTAMPDIFF:
    begin
      A1 := UpperCase(FDUnquote(Trim(A1), ''''));
      if A1 = 'YEAR' then
        Result := '256'
      else if A1 = 'QUARTER' then
        Result := '128'
      else if A1 = 'MONTH' then
        Result := '64'
      else if A1 = 'WEEK' then
        Result := '32'
      else if A1 = 'DAY' then
        Result := '16'
      else if A1 = 'HOUR' then
        Result := '8'
      else if A1 = 'MINUTE' then
        Result := '4'
      else if A1 = 'SECOND' then
        Result := '2'
      else if A1 = 'FRAC_SECOND' then
        Result := '1'
      else
        UnsupportedEscape(ASeq);
      Result := 'TIMESTAMPDIFF(' + Result + ', CHAR(TIMESTAMP(' + A3 + ') - TIMESTAMP(' + A2 + ')))';
    end;
  // system
  efCATALOG:     Result := '''''';
  efSCHEMA:      Result := 'CURRENT_SCHEMA';
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
      if (A2 = 'LONGVARCHAR') or (A2 = 'WLONGVARCHAR') then
        A2 := 'LONG_VARCHAR'
      else if A2 = 'WCHAR' then
        A2 := 'CHAR'
      else if A2 = 'WVARCHAR' then
        A2 := 'VARCHAR'
      else if A2 = 'DATETIME' then
        A2 := 'TIMESTAMP'
      else if A2 = 'NUMERIC' then
        A2 := 'DECIMAL'
      else if A2 = 'TINYINT' then
        A2 := 'SMALLINT'
      else if (A2 = 'VARBINARY') or (A2 = 'BINARY') or (A2 = 'LONGVARBINARY') then
        A2 := 'BLOB'
      else if not ((A2 = 'BIGINT') or (A2 = 'CHAR') or (A2 = 'INTEGER') or
                   (A2 = 'NUMERIC') or (A2 = 'REAL') or (A2 = 'SMALLINT') or
                   (A2 = 'DATE') or (A2 = 'TIME') or (A2 = 'TIMESTAMP') or
                   (A2 = 'VARCHAR') or (A2 = 'DECIMAL') or (A2 = 'DOUBLE') or
                   (A2 = 'FLOAT')) then
        UnsupportedEscape(ASeq);
      Result := A2 + '(' + A1 + ')';
    end;
  else
    UnsupportedEscape(ASeq);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2Metadata.InternalGetSQLCommandKind(
  const ATokens: TStrings): TFDPhysCommandKind;
var
  sToken: String;
begin
  sToken := ATokens[0];
  if sToken = 'CALL' then
    Result := skExecute
  else if sToken = 'SET' then
    if (ATokens.Count = 1) or
       (ATokens.Count = 2) and (ATokens[1] = 'CURRENT') then
      Result := skNotResolved
    else if (ATokens.Count = 2) and (ATokens[1] = 'SCHEMA') or
            (ATokens.Count = 3) and (ATokens[2] = 'SCHEMA') then
      Result := skSetSchema
    else
      Result := skSet
  else
    Result := inherited InternalGetSQLCommandKind(ATokens);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysDb2CommandGenerator                                                    }
{-------------------------------------------------------------------------------}
function TFDPhysDb2CommandGenerator.GetDB2Returning(const AStmt: String;
  ARequest: TFDUpdateRequest): String;
var
  s: String;
  i: Integer;
  oCols: TFDDatSColumnList;
  oCol: TFDDatSColumn;
begin
  s := '';
  oCols := FTable.Columns;
  for i := 0 to oCols.Count - 1 do begin
    oCol := oCols[i];
    if ColumnStorable(oCol) and ColumnReqRefresh(ARequest, oCol) then begin
      if s <> '' then
        s := s + ', ';
      s := s + GetColumn('', -1, oCols[i]);
    end;
  end;
  if s <> '' then begin
    Result := 'SELECT ' + s + ' FROM FINAL TABLE (' + AStmt + ')';
    FCommandKind := skSelect;
  end
  else
    Result := AStmt;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2CommandGenerator.GetInlineRefresh(const AStmt: String;
  ARequest: TFDUpdateRequest): String;
begin
  Result := GetDB2Returning(AStmt, ARequest);
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2CommandGenerator.GetIdentity(ASessionScope: Boolean): String;
begin
  Result := 'IDENTITY_VAL_LOCAL()';
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2CommandGenerator.GetSingleRowTable: String;
begin
  Result := 'SYSIBM.SYSDUMMY1';
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2CommandGenerator.GetPessimisticLock: String;
var
  lNeedFrom: Boolean;
begin
  Result := 'SELECT ' + GetSelectList(True, False, lNeedFrom) + BRK +
    'FROM ' + GetFrom + BRK + 'WHERE ' + GetWhere(False, True, False) + BRK +
    'FOR UPDATE';
  FCommandKind := skSelectForLock;
  ASSERT(lNeedFrom);
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2CommandGenerator.GetSavepoint(const AName: String): String;
begin
  Result := 'SAVEPOINT ' + AName + ' ON ROLLBACK RETAIN CURSORS';
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2CommandGenerator.GetRollbackToSavepoint(const AName: String): String;
begin
  Result := 'ROLLBACK TO SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2CommandGenerator.GetCommitSavepoint(const AName: String): String;
begin
  Result := 'RELEASE SAVEPOINT ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2CommandGenerator.GetCall(const AName: String): String;
begin
  Result := 'CALL ' + AName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2CommandGenerator.GetLimitSelect(const ASQL: String;
  ASkip, ARows: Integer): String;
begin
  if ASkip + ARows <> MAXINT then
    // DB2: does not support FETCH FIRST 0 ROWS ONLY and returns
    // "The numeric literal 0 is not valid because its value is out of range"
    if ARows = 0 then
      Result := 'SELECT * FROM (' + BRK + ASQL + BRK + ') A' + BRK + 'WHERE 0 = 1'
    else
      Result := ASQL + BRK + 'FETCH FIRST ' + IntToStr(ASkip + ARows) + ' ROWS ONLY'
  else
    Result := ASQL;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDb2CommandGenerator.GetColumnType(AColumn: TFDDatSColumn): String;
begin
  case AColumn.DataType of
  dtBoolean,
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
    Result := 'DOUBLE';
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
  dtAnsiString:
    begin
      if (caFixedLen in AColumn.ActualAttributes) and (AColumn.Size <= 254) then
        Result := 'CHAR'
      else if AColumn.Size <= 4000 then
        Result := 'VARCHAR'
      else
        Result := 'LONG VARCHAR';
      Result := Result + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1);
    end;
  dtWideString:
    begin
      if (caFixedLen in AColumn.ActualAttributes) and (AColumn.Size <= 127) then
        Result := 'GRAPHIC'
      else
        Result := 'VARGRAPHIC';
      Result := Result + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1);
    end;
  dtByteString:
    begin
      if (caFixedLen in AColumn.ActualAttributes) and (AColumn.Size <= 254) then
        Result := 'CHAR'
      else if AColumn.Size <= 4000 then
        Result := 'VARCHAR'
      else
        Result := 'LONG VARCHAR';
      Result := Result + ' FOR BIT DATA' + GetColumnDim(AColumn.Size, -1, -1, -1, -1, -1);
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
    Result := 'DBCLOB';
  dtXML:
    Result := 'XML';
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
function TFDPhysDb2CommandGenerator.GetColumnDef(AColumn: TFDDatSColumn): String;
begin
  Result := inherited GetColumnDef(AColumn);
  if (Result <> '') and (caAutoInc in AColumn.ActualAttributes) then
    Result := Result + ' GENERATED BY DEFAULT AS IDENTITY';
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterRDBMSKind(TFDRDBMSKinds.DB2, S_FD_DB2_RDBMS);

end.
