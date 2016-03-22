unit ddServerBaseEngine;

interface

{$Include csDefine.inc}

uses
 CsDataPipe, CsServer, csCommon, daDataProviderParams,
 ddBaseEngine, daTypes;

type
 TServerBaseEngine = class(TBaseEngine)
 private
  f_CSServer: TCSServer;
  f_ServerHostName: String;
  f_ServerPort: Integer;
  f_AutolinkEnabled: Boolean;
  procedure ServerLoginExData(out aDataParams: TdaDataProviderParams; out TheFlags: TdaBaseFlags);
  procedure ServerGetIsBaseLocked(out theIsBaseLocked: Boolean);
  function _ReIndexTable(const aFileName: AnsiString): Boolean;
  function pm_GetBaseFlags: TdaBaseFlags;
  function CSCheckPassword(const aLoginName, aPassword: AnsiString;
    RequireAdminRights: Boolean; out theUserID: TCsClientID): Boolean;
 protected
  procedure CreateCommunications; override;
  function DoStart: Boolean; override;
  procedure DoStop; override;
  function pm_GetWorkWithServer: Boolean; override;
  function pm_GetServerHostName: AnsiString; override;
  function pm_GetServerPort: Integer; override;
 public
  constructor Make(const aDataParams: TdaDataProviderParams; const aServerHostName: AnsiString;
      aServerPort: Integer = 32100; AutolinkEnabled: Boolean = False);
  procedure cs_GetBaseStatus(aPipe: TCSDataPipe);
  procedure ReindexTables(aFamily: Integer);
  procedure RepairTable(const aTable: AnsiString);
    //
  function TablePass(const aTable: AnsiString): PAnsiChar;
  property CSServer: TCSServer read f_CSServer;
  property BaseFlags: TdaBaseFlags read pm_GetBaseFlags;
 end;

implementation

Uses
 dt_Serv, l3IniFile, l3Base, ddFileIterator, ht_dll, StrUtils, SysUtils,
 DT_UserConst, dt_User, htDataProviderParams, daDataProviderSuperFactory,
 m3StgMgr
 ;

const
  c_TablePass       = 'corvax';


constructor TServerBaseEngine.Make(const aDataParams: TdaDataProviderParams;
  const aServerHostName: string; aServerPort: Integer = 32100; AutolinkEnabled: Boolean = False);
begin
 Create(aDataParams);
 f_ServerHostName := aServerHostName;
 f_ServerPort := aServerPort;
 f_AutolinkEnabled := AutolinkEnabled;
end;

procedure TServerBaseEngine.CreateCommunications;
begin
 if CSServer = nil then
  f_CSServer := TCSServer.Create('', CSCheckPassword);
end;

procedure TServerBaseEngine.cs_GetBaseStatus(aPipe: TCSDataPipe);
var
 l_Msg: AnsiString;
begin
 Guard.Acquire;
 try
  aPipe.WriteSmallInt(SmallInt(Ord(IsbaseLocked(l_Msg))));
  aPIpe.WriteLn(l_Msg);
 finally
  Guard.Leave;
 end;
end;

function TServerBaseEngine.DoStart: Boolean;
begin
 TdaDataProviderSuperFactory.Instance.LoadDBVersion(DataParams);

// DocBaseVersion  := l_DocBaseVersion;
// AdminBaseVersion:= l_AdminBaseVersion;

 if not TdaDataProviderSuperFactory.Instance.IsParamsValid(DataParams) then
 begin
  Result := False;
  Exit;
 end;

 CreateDataProvider;
// CreateHtEx(StationName, (DataParams as ThtDataProviderParams).MakePathRec, DataParams.DocBaseVersion, DataParams.AdminBaseVersion, (DataParams as ThtDataProviderParams).AliasesList);
 if CSServer = nil then
  f_CSServer := TCSServer.Create('', CSCheckPassword);
 f_CSServer.OnLoginExData := ServerLoginExData;
 f_CSServer.OnGetIsBaseLocked := ServerGetIsBaseLocked;
 DataProvider.LoginAsServer;
 Result:= True;
end;

function TServerBaseEngine.CSCheckPassword(const aLoginName: AnsiString;
  const aPassword: AnsiString; RequireAdminRights: Boolean; out theUserID: TCsClientID): Boolean;
begin
 Result := UserManager.CSCheckPassword(aLoginName, aPassword, RequireAdminRights, theUserID);
end;

procedure TServerBaseEngine.DoStop;
begin
 DestroyDataProvider;
 l3Free(f_CSServer)
end;

procedure TServerBaseEngine.ReindexTables(aFamily: Integer);
begin
 // *.htb
 with TddFileIterator.Create do
 try
  FileMask:= '*.htb';
  Directory:= GetFamilyPath(aFamily);
  LoadFiles;
  Stop;
  IterateFiles(_ReIndexTable);
  Start;
 finally
  Free;
 end;

end;

procedure TServerBaseEngine.RepairTable(const aTable: AnsiString);
var
 l_WrongRecords: Integer;
 l_Pass: PAnsiChar;
begin
 l_Pass := TablePass(aTable);
 l_WrongRecords := htRepairTable(PAnsiChar(aTable), l_Pass, l_Pass);
 htUpdateTable(PAnsiChar(aTable), l_Pass, l_Pass, True, False);
 htRepairTableLog(PAnsiChar(aTable), l_Pass, l_Pass, 0);
 //if l_WrongRecords > 0 then
 // Log(Format('Из таблицы %s вычищено %d поврежденных записей.', [aTable, l_WrongRecords]));
end;

procedure TServerBaseEngine.ServerLoginExData(out aDataParams: TdaDataProviderParams; out TheFlags: TdaBaseFlags);
begin
 aDataParams := DataParams;
 theFlags := BaseFlags;
end;

function TServerBaseEngine.TablePass(const aTable: AnsiString): PAnsiChar;
var
 l_Mode: Integer;
 l_Success: Boolean;
 l_TableName: AnsiString;
begin
 try
  l_Success := htTableHeadPswd(PAnsiChar(aTable), l_Mode) = 0;
 except
  l_Success := false;
 end;
 if l_Success then
 begin
  if l_Mode > 0 then
   Result := PAnsiChar(c_TablePass+#0)
  else
   Result := nil;
 end
 else
 begin
  l_TableName := AnsiUpperCase(ChangeFileExt(ExtractFileName(aTable), ''));
  if (l_TableName = 'ACCESS') or (l_TableName = 'PASS') or (l_TableName = 'BB_LOG') then
   Result := PAnsiChar(c_TablePass+#0)
  else
   Result := nil;
 end;
end;

function TServerBaseEngine._ReIndexTable(const aFileName: AnsiString): Boolean;
var
 l_Pass: PAnsiChar;
begin
 l_Pass := TablePass(aFileName);
 Result:= htUpdateTable(PAnsiChar(aFileName), l_Pass, l_Pass, True, True) = 0;
end;

function TServerBaseEngine.pm_GetBaseFlags: TdaBaseFlags;
begin
 Result := [];
 {$IFDEF AAC}
 Include(Result, bfAAC);
 {$ENDIF AAC}
 if f_AutolinkEnabled then
  Include(Result, bfAutoLink);
end;

procedure TServerBaseEngine.ServerGetIsBaseLocked(
  out theIsBaseLocked: Boolean);
begin
 theIsBaseLocked := IsBaseLocked;
end;

function TServerBaseEngine.pm_GetWorkWithServer: Boolean;
begin
 Result := True;
end;

function TServerBaseEngine.pm_GetServerHostName: AnsiString;
begin
 Result := f_ServerHostName;
end;

function TServerBaseEngine.pm_GetServerPort: Integer;
begin
 Result := f_ServerPort;
end;

end.
