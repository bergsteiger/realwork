{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                FireDAC Teradata driver                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Phys.TData;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Error,
  FireDAC.Phys, FireDAC.Phys.ODBCCli, FireDAC.Phys.ODBCWrapper, FireDAC.Phys.ODBCBase;

type
  ETDataNativeException = class;
  TFDPhysTDataDriverLink = class;

  /// <summary> ETDataNativeException class representing a Teradata driver exception.
  ///  Use this class to handle Teradata driver specific exception. </summary>
  ETDataNativeException = class(EODBCNativeException)
  public
    function AppendError(AHandle: TODBCHandle; ARecNum: SQLSmallint;
      const ASQLState: String; ANativeError: SQLInteger; const ADiagMessage,
      AResultMessage, ACommandText, AObject: String;
      AKind: TFDCommandExceptionKind; ACmdOffset, ARowIndex: Integer): TFDDBError; override;
  end;

  /// <summary> Use the TFDPhysTDataDriverLink component to link the Teradata driver
  ///  to an application and to set it up. Generally, it is enough to include the
  ///  FireDAC.Phys.TData unit in your application uses clause. </summary>
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidLinux64)]
  TFDPhysTDataDriverLink = class(TFDPhysODBCBaseDriverLink)
  protected
    function GetBaseDriverID: String; override;
  end;

{-------------------------------------------------------------------------------}
implementation

uses
  System.SysUtils, System.Variants, Data.DB,
  FireDAC.Stan.Consts, FireDAC.Stan.Util, FireDAC.Stan.Param, FireDAC.Stan.Option,
  FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys.SQLGenerator, FireDAC.Phys.TDataMeta,
    FireDAC.Phys.TDataDef;

const
  C_CharSets = 'ASCII;UTF8;UTF16;LATIN1252_0A;LATIN9_0A;LATIN1_0A;KANJISJIS_0S;' +
    'KANJIEUC_0U;TCHBIG5_1R0;SCHGB2312_1T0;HANGULKSC5601_2R4';
  C_Teradata = 'Teradata';
  C_ANSI = 'ANSI';

type
  TFDPhysTDataDriver = class;
  TFDPhysTDataConnection = class;
  TFDPhysTDataCommand = class;

  TFDPhysTDataDriver = class(TFDPhysODBCDriverBase)
  protected
    class function GetBaseDriverID: String; override;
    class function GetBaseDriverDesc: String; override;
    class function GetRDBMSKind: TFDRDBMSKind; override;
    class function GetConnectionDefParamsClass: TFDConnectionDefParamsClass; override;
    procedure InternalLoad; override;
    function InternalCreateConnection(AConnHost: TFDPhysConnectionHost): TFDPhysConnection; override;
    procedure GetODBCConnectStringKeywords(AKeywords: TStrings); override;
    function BuildODBCConnectString(const AConnectionDef: IFDStanConnectionDef): String; override;
    function GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable; override;
  end;

  TFDPhysTDataConnection = class(TFDPhysODBCConnectionBase)
  private
    FExtendedMetadata: Boolean;
    FSessionMode: TFDTDataSessionMode;
    function QueryValue(const ASQL: String): String;
    procedure UpdateCurrentSchema;
  protected
    function InternalCreateCommand: TFDPhysCommand; override;
    function InternalCreateCommandGenerator(const ACommand:
      IFDPhysCommand): TFDPhysCommandGenerator; override;
    function InternalCreateMetadata: TObject; override;
    procedure GetStrsMaxSizes(AStrDataType: SQLSmallint; AFixedLen: Boolean;
      out ACharSize, AByteSize: Integer); override;
    function GetExceptionClass: EODBCNativeExceptionClass; override;
    procedure InternalConnect; override;
    procedure InternalSetMeta; override;
    procedure InternalChangePassword(const AUserName, AOldPassword,
      ANewPassword: String); override;
  end;

  TFDPhysTDataCommand = class(TFDPhysODBCCommand)
  private
    FAGKR: Integer;
    procedure DoExtendedDescribe;
    procedure DoINTODescribe;
  protected
    // TFDPhysODBCCommand
    procedure CreateDescribeInfos; override;
    // TFDPhysCommand
    function InternalUseStandardMetadata: Boolean; override;
    procedure InternalPrepare; override;
    procedure InternalExecute(ATimes, AOffset: Integer; var ACount: TFDCounter); override;
    function InternalOpen: Boolean; override;
  end;

{-------------------------------------------------------------------------------}
{ ETDataNativeException                                                         }
{-------------------------------------------------------------------------------}
function ETDataNativeException.AppendError(AHandle: TODBCHandle;
  ARecNum: SQLSmallint; const ASQLState: String; ANativeError: SQLInteger;
  const ADiagMessage, AResultMessage, ACommandText, AObject: String;
  AKind: TFDCommandExceptionKind; ACmdOffset, ARowIndex: Integer): TFDDBError;
var
  sObj: String;

  procedure ExtractObjName1;
  var
    i1, i2: Integer;
  begin
    // first 'xxxx' - object name
    i1 := Pos('''', ADiagMessage);
    if i1 <> 0 then begin
      i2 := Pos('''', ADiagMessage, i1 + 1);
      if i2 <> 0 then
        sObj := Copy(ADiagMessage, i1 + 1, i2 - i1 - 1);
    end;
  end;

  procedure ExtractObjName2;
  var
    i: Integer;
  begin
    //  ... in 'xxxx' - object name
    i := Pos('in ', ADiagMessage);
    if i <> 0 then
      sObj := Copy(ADiagMessage, i + 3, Length(ADiagMessage));
  end;

begin
  // ekNoDataFound
  // ekTooManyRows
  // ekServerOutput
  // ekArrExecMalfunc

  sObj := AObject;
  case ANativeError of
  -3807,
  -5495:
    begin
      ExtractObjName1;
      AKind := ekObjNotExists;
    end;
  -8017:
    AKind := ekUserPwdInvalid;
  -3032:
    AKind := ekUserPwdExpired;
  -2802,
  -2803:
    begin
      ExtractObjName2;
      AKind := ekUKViolated;
    end;
  -2700,
  -3513:
    AKind := ekFKViolated;
  -2631,
  -7423:
    AKind := ekRecordLocked;
  -3939,
  -3812,
  -3813:
    // In some cases (eg N "?" markers and M TFDParam's, where N > M)
    // Teradata ODBC raises Access Violation.
    AKind := ekInvalidParams;
  end;
  Result := inherited AppendError(AHandle, ARecNum, ASQLState, ANativeError,
    ADiagMessage, AResultMessage, ACommandText, sObj, AKind, ACmdOffset, ARowIndex);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysTDataDriverLink                                                        }
{-------------------------------------------------------------------------------}
function TFDPhysTDataDriverLink.GetBaseDriverID: String;
begin
  Result := S_FD_TDataId;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysTDataDriver                                                            }
{-------------------------------------------------------------------------------}
class function TFDPhysTDataDriver.GetBaseDriverID: String;
begin
  Result := S_FD_TDataId;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysTDataDriver.GetBaseDriverDesc: String;
begin
  Result := 'Teradata';
end;

{-------------------------------------------------------------------------------}
class function TFDPhysTDataDriver.GetRDBMSKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.Teradata;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysTDataDriver.GetConnectionDefParamsClass: TFDConnectionDefParamsClass;
begin
  Result := TFDPhysTDataConnectionDefParams;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataDriver.InternalLoad;
begin
  inherited InternalLoad;
  if ODBCDriver = '' then
    ODBCDriver := FindBestDriver(['Teradata']);
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataDriver.InternalCreateConnection(
  AConnHost: TFDPhysConnectionHost): TFDPhysConnection;
begin
  Result := TFDPhysTDataConnection.Create(Self, AConnHost);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataDriver.GetODBCConnectStringKeywords(AKeywords: TStrings);
begin
  inherited GetODBCConnectStringKeywords(AKeywords);
  AKeywords.Add(S_FD_ConnParam_Common_Server + '=DBCNAME');
  AKeywords.Add(S_FD_ConnParam_Common_Database);
  AKeywords.Add(S_FD_ConnParam_Common_CharacterSet);
  AKeywords.Add(S_FD_ConnParam_Common_NewPassword + '=PWD2');
  AKeywords.Add(S_FD_ConnParam_Common_OSAuthent + '=UseIntegratedSecurity');
  AKeywords.Add(S_FD_ConnParam_TData_SessionMode);
  AKeywords.Add(S_FD_ConnParam_TData_Encrypt + '=UseDataEncryption');
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataDriver.BuildODBCConnectString(const AConnectionDef: IFDStanConnectionDef): String;
var
  s: String;
begin
  Result := inherited BuildODBCConnectString(AConnectionDef);
  if TFDPhysTDataConnectionDefParams(AConnectionDef.Params).ExtendedMetadata then
    s := S_FD_Yes
  else
    s := S_FD_No;
  Result := Result + ';EnableExtendedStmtInfo=' + s;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataDriver.GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable;
var
  oView: TFDDatSView;
begin
  Result := inherited GetConnParams(AKeys, AParams);
  oView := Result.Select('Name=''' + S_FD_ConnParam_Common_Database + '''');
  if oView.Rows.Count = 1 then begin
    oView.Rows[0].BeginEdit;
    oView.Rows[0].SetValues('LoginIndex', 4);
    oView.Rows[0].EndEdit;
  end;
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_Server, '@S', '', S_FD_ConnParam_Common_Server, 3]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_OSAuthent, '@Y', S_FD_No, S_FD_ConnParam_Common_OSAuthent, 2]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_CharacterSet, C_CharSets, 'ASCII', S_FD_ConnParam_Common_CharacterSet, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_TData_SessionMode, C_Teradata + ';' + C_ANSI, C_Teradata, S_FD_ConnParam_TData_SessionMode, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_TData_Encrypt, '@Y', S_FD_No, S_FD_ConnParam_TData_Encrypt, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_ExtendedMetadata, '@L', S_FD_False, S_FD_ConnParam_Common_ExtendedMetadata, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaDefSchema, '@S', '', S_FD_ConnParam_Common_MetaDefSchema, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaCurSchema, '@S', '', S_FD_ConnParam_Common_MetaCurSchema, -1]);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysTDataConnection                                                        }
{-------------------------------------------------------------------------------}
function TFDPhysTDataConnection.InternalCreateCommand: TFDPhysCommand;
begin
  Result := TFDPhysTDataCommand.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataConnection.InternalCreateCommandGenerator(
  const ACommand: IFDPhysCommand): TFDPhysCommandGenerator;
begin
  if ACommand <> nil then
    Result := TFDPhysTDataCommandGenerator.Create(ACommand)
  else
    Result := TFDPhysTDataCommandGenerator.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataConnection.InternalCreateMetadata: TObject;
var
  iSrvVer, iClntVer: TFDVersion;
begin
  GetVersions(iSrvVer, iClntVer);
  Result := TFDPhysTDataMetadata.Create(Self, iSrvVer, iClntVer, GetKeywords,
    FExtendedMetadata, FSessionMode);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataConnection.GetStrsMaxSizes(AStrDataType: SQLSmallint;
  AFixedLen: Boolean; out ACharSize, AByteSize: Integer);
begin
  // CHAR - 64000
  // CHAR CHARACTER SET UNICODE - 32000
  // VARCHAR - 64000
  // VARCHAR CHARACTER SET UNICODE - 32000
  // BYTE - 64000
  // VARBYTE - 64000
  case AStrDataType of
  SQL_C_CHAR,
  SQL_C_BINARY:
    begin
      AByteSize := 64000;
      ACharSize := AByteSize;
    end;
  SQL_C_WCHAR:
    begin
      AByteSize := 64000;
      ACharSize := AByteSize div SizeOf(SQLWChar);
    end;
  else
    FDCapabilityNotSupported(Self, [S_FD_LPhys, S_FD_TDataId]);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataConnection.GetExceptionClass: EODBCNativeExceptionClass;
begin
  Result := ETDataNativeException;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataConnection.InternalConnect;
var
  oPrevChanging: TNotifyEvent;
  oParams: TFDPhysTDataConnectionDefParams;
begin
  inherited InternalConnect;
  oParams := ConnectionDef.Params as TFDPhysTDataConnectionDefParams;
  if oParams.NewPassword <> '' then begin
    oPrevChanging := ConnectionDef.OnChanging;
    ConnectionDef.OnChanging := nil;
    oParams.Password := oParams.NewPassword;
    oParams.NewPassword := '';
    ConnectionDef.OnChanging := oPrevChanging;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataConnection.QueryValue(const ASQL: String): String;
var
  oStmt: TODBCCommandStatement;
  oCol1: TODBCColumn;
begin
  oStmt := TODBCCommandStatement.Create(ODBCConnection, Self);
  try
    oStmt.Open(1, ASQL);
    oCol1 := oStmt.AddCol(1, SQL_WVARCHAR, SQL_C_WCHAR, 128);
    oStmt.Fetch(1);
    Result := oCol1.AsStrings[0];
  finally
    FDFree(oStmt);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataConnection.InternalSetMeta;
var
  oPars: TFDPhysTDataConnectionDefParams;
begin
  inherited InternalSetMeta;
  oPars := TFDPhysTDataConnectionDefParams(ConnectionDef.Params);
  FExtendedMetadata := oPars.ExtendedMetadata;
  if FCurrentSchema = '' then
    UpdateCurrentSchema;
  if UpperCase(Trim(QueryValue('SELECT transaction_mode FROM dbc.SessionInfoV ' +
                               'WHERE SessionNo = SESSION'))) = 'T' then
    FSessionMode := tmTeradata
  else
    FSessionMode := tmANSI;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataConnection.UpdateCurrentSchema;
begin
  FCurrentSchema := QueryValue('SELECT DATABASE');
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataConnection.InternalChangePassword(const AUserName, AOldPassword,
  ANewPassword: String);
begin
  InternalExecuteDirect('MODIFY "' + AUserName + '" AS PASSWORD = "' + ANewPassword + '"', nil);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysTDataCommand                                                           }
{-------------------------------------------------------------------------------}
function TFDPhysTDataCommand.InternalUseStandardMetadata: Boolean;
begin
  Result := not TFDPhysTDataConnection(ODBCConnection).FExtendedMetadata;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataCommand.InternalPrepare;
var
  i: Integer;
begin
  FAGKR := SQL_AGKR_NO;
  if (GetMetaInfoKind = mkNone) and
     (GetCommandKind in [skSelect, skSelectForLock, skSelectForUnLock]) and
     ((StrLIComp(PChar(FDbCommandText), PChar('INSERT'), 6) = 0) or
      (StrLIComp(PChar(FDbCommandText), PChar('UPDATE'), 6) = 0) or
      (StrLIComp(PChar(FDbCommandText), PChar('UPSERT'), 6) = 0) or
      (StrLIComp(PChar(FDbCommandText), PChar('MERGE'), 5) = 0)) then begin
    i := Pos(C_FD_TDataINTO, FDbCommandText);
    if i <> 0 then begin
      Inc(i, Length(C_FD_TDataINTO));
      if StrLComp(PChar(FDbCommandText) + i - 1, PChar(' * '), 3) = 0 then
        FAGKR := SQL_AGKR_WHOLE_ROW
      else if StrLComp(PChar(FDbCommandText) + i - 1, PChar(' # '), 3) = 0 then
        FAGKR := SQL_AGKR_IDENTITY_COLUMN
      else
        FAGKR := SQL_AGKR_WHOLE_ROW;
    end;
  end;
  inherited InternalPrepare;
  if FAGKR <> SQL_AGKR_NO then
    ODBCStatement.TDATA_AGKR := FAGKR;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataCommand.DoINTODescribe;
var
  i1, i2, i3, i, j: Integer;
  sNames: String;
  pColInfo: PFDODBCColInfoRec;
begin
  i1 := Pos(C_FD_TDataINTO, FDbCommandText);
  if i1 > 0 then begin
    Inc(i1, Length(C_FD_TDataINTO));
    i2 := Pos('*/', FDbCommandText, i1);
    if i2 > 0 then begin
      i3 := Pos(' * ', FDbCommandText, i1);
      if i3 = 0 then
        i3 := Pos(' # ', FDbCommandText, i1);
      if i3 > 0 then
        Inc(i1, 3);
      sNames := Trim(Copy(FDbCommandText, i1, i2 - i1));
      j := 1;
      for i := 0 to Length(FColInfos) - 1 do begin
        pColInfo := @FColInfos[i];
        pColInfo^.FName := FDExtractFieldName(sNames, j);
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataCommand.DoExtendedDescribe;
var
  i, j, k: Integer;
  oTabs: TFDStringList;
  oConnMeta: IFDPhysConnectionMetadata;
  pColInfo: PFDODBCColInfoRec;
  oView: TFDDatSView;
  oRow: TFDDatSRow;
begin
  oTabs := TFDStringList.Create(dupIgnore, True, False);
  try
    for i := 0 to Length(FColInfos) - 1 do begin
      pColInfo := @FColInfos[i];
      if (pColInfo^.FOriginTabName <> '') and (pColInfo^.FOriginColName <> '') then
        if oTabs.IndexOf(pColInfo^.FOriginTabName) = -1 then
          oTabs.Add(pColInfo^.FOriginTabName);
    end;
    GetConnection.CreateMetadata(oConnMeta);
    for k := 0 to oTabs.Count - 1 do begin
      oView := oConnMeta.GetResultSetFields(UpperCase(oTabs[k]));
      try
        for i := 0 to Length(FColInfos) - 1 do begin
          pColInfo := @FColInfos[i];
          if (pColInfo^.FOriginTabName <> '') and (pColInfo^.FOriginColName <> '') then begin
            j := oView.Find([pColInfo^.FOriginTabName, pColInfo^.FOriginColName],
              'TABLE_NAME;COLUMN_NAME', []);
            if j <> -1 then begin
              oRow := oView.Rows[j];
              if oRow.ValueS['ISIDENTITY'] = 1 then begin
                Include(pColInfo^.FAttrs, caAutoInc);
                Include(pColInfo^.FAttrs, caAllowNull);
              end;
              if oRow.ValueS['HASDEFAULT'] = 1 then
                Include(pColInfo^.FAttrs, caDefault);
              if oRow.ValueS['IN_PKEY'] = 1 then
                pColInfo^.FInKey := True;
            end;
          end;
        end;
      finally
        FDClearMetaView(oView, FOptions.FetchOptions);
      end;
    end;
  finally
    FDFree(oTabs);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataCommand.CreateDescribeInfos;
begin
  inherited CreateDescribeInfos;
  if (GetMetaInfoKind = mkNone) and
     (fiMeta in FOptions.FetchOptions.Items) and
     TFDPhysTDataConnection(ODBCConnection).FExtendedMetadata then
    DoExtendedDescribe
  else if FAGKR <> SQL_AGKR_NO then
    DoINTODescribe;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataCommand.InternalExecute(ATimes, AOffset: Integer;
  var ACount: TFDCounter);
begin
  inherited InternalExecute(ATimes, AOffset, ACount);
  if GetCommandKind = skSetSchema then
    TFDPhysTDataConnection(ODBCConnection).UpdateCurrentSchema;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataCommand.InternalOpen: Boolean;
begin
  Result := inherited InternalOpen;
  if GetCommandKind = skSetSchema then
    TFDPhysTDataConnection(ODBCConnection).UpdateCurrentSchema;
end;

{-------------------------------------------------------------------------------}
function TDataNativeExceptionLoad(const AStorage: IFDStanStorage): TObject;
begin
  Result := ETDataNativeException.Create;
  ETDataNativeException(Result).LoadFromStorage(AStorage);
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterDriverClass(TFDPhysTDataDriver);
  FDStorageManager().RegisterClass(ETDataNativeException, 'TDataNativeException',
    @TDataNativeExceptionLoad, @FDExceptionSave);

end.
