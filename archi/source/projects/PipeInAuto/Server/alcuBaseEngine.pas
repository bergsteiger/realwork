unit alcuBaseEngine;

interface

uses
 ddServerBaseEngine, CsActiveClients, daInterfaces,

 csClientInfo
 ;

type
 TalcuBaseEngine = class(TServerBaseEngine)
 private
  function _WriteName(aClient: TcsClientInfo): Boolean;
  function _CloseSession(aClient: TcsClientInfo): Boolean;
 public
  function IsBaseFree(out aMessage: String): Boolean;
  procedure LogoffUsers(theUser: IdaArchiUser);
  procedure LogoffUsersEx(theUser: IdaArchiUser);
  procedure UpdateUserlist;
  function HasActiveUsers: Boolean;
 end;

implementation

uses l3base, alcuStrings, daDataProvider, StrUtils, CsCommon, SysUtils, CsNotifier, CsNotification,
 alcuUtils, l3ShellUtils;

function TalcuBaseEngine.IsBaseFree(out aMessage: String): Boolean;
var
  i: Integer;
begin
  Result := False;
  l3System.Msg2Log('* ��������� ������ �������������');
  UpdateUserList;
  if CSServer.ActiveClients.ClientsCount > 0 then
  begin
   l3System.Msg2Log('* ���� ������������ �� ����, �������� ���������');
   LogoffUsers(nil);
   l3System.Msg2Log('* ��������� ������ �������������');
   UpdateUserList;
   if CSServer.ActiveClients.ClientsCount = 0 then
    Result:= True
   else
   begin
    l3System.Msg2Log(SalcuAutoPipeServer_Zabytyepol_zovateli);
    CSServer.ActiveClients.IterateClients(_WriteName);
   end;
  end
  else
   Result:= True;
  if Result then
  begin
   l3System.Msg2Log('* ����� ����');
   Result:= GlobalDataProvider.LockAll;
   l3System.Msg2Log('* ����������� ����');
   GlobalDataProvider.UnLockAll;
  end; // Result
  aMessage:= IfThen(Result, '���� ��������', '�� ������� �������� �������� ��� �����');
end;

procedure TalcuBaseEngine.LogoffUsers(theUser: IdaArchiUser);
var
 l_UserID: TCsClientId;
begin
 if CSServer.ActiveClients.ClientsCount > 0 then
 begin
  if theUser = nil then
  begin
   l3System.Msg2Log(SysUtils.Format(SalcuAutoPipeServer_Otklyueniepol_zovateley, [CSServer.ActiveClients.ClientsCount]));
   CSServer.ActiveClients.IterateClients(_WriteName);
   l_UserID:= c_AllClients;
  end
  else
  begin
   l3System.Msg2Log(SalcuAutoPipeServer_Otklyueniepol_zovatelya);
   _WriteName(CSServer.ActiveClients.ClientInfoOf(theUser.ID));
   l_UserID:= theUser.ID;
  end;
  CSServer.Notifier.SendNotify(l_UserID, ntAutoLogoff, 0, '');
 end; // f_BaseEngine.CSServer.ActiveClients.ClientsCount > 0
end;

procedure TalcuBaseEngine.LogoffUsersEx(theUser: IdaArchiUser);
begin
 if CSServer.ActiveClients.ClientsCount > 0 then
 begin
  if theUser = nil then
   CSServer.ActiveClients.IterateClients(_CloseSession)
  else
   _CloseSession(CSServer.ActiveClients.ClientInfoOf(theUser.ID));
 end; // f_BaseEngine.CSServer.ActiveClients.ClientsCount > 0
end;

procedure TalcuBaseEngine.UpdateUserlist;
begin
 CSServer.AllloginRequest;
 CSServer.ActiveClients.Pack;
end;

function TalcuBaseEngine._WriteName(aClient: TcsClientInfo): Boolean;
begin
 Result := False;
 l3System.Msg2Log(UserNameByID(aClient.ClientID, aClient.ListenIp, aClient.LoginName));
end;

function TalcuBaseEngine._CloseSession(aClient: TcsClientInfo): Boolean;
begin
 Result := False;
 FileExecuteWait('net', Format('net session \\%s /delete', [aClient.ListenIp]), '', esHidden);
end;

function TalcuBaseEngine.HasActiveUsers: Boolean;
begin
 UpdateUserList;
 Result := CSServer.ActiveClients.ClientsCount > 0;
end;

end.
