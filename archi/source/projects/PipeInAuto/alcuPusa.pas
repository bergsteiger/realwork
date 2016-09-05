unit alcuPusa;
{ Панель управления Сервером Архивариуса }

interface

uses
 Classes, SysUtils,
 l3Base, l3ObjectRefList,
 csClientCommandsManager, alcuTypes,
 csClient, csNotification, CsDataPipe, ddServerTask, csProcessTask,
 jclSvcCtrl;


type
 TalcuPusa = class(Tl3Base)
 private
  f_Client: TCsClient;
  f_CommandsManager: TcsClientCommandsManager;
  f_IsBaseLocked: Boolean;
  f_LastError: string;
  f_OnServerStatus: TNotifyEvent;
  f_OnTaskListChanged: TTaskListRefreshEvent;
  f_OnUserListUpdated: TddUserListNotify;
  f_Service: TJclNtService;
  f_ServiceManager: TJclSCManager;
  f_TickCount: Integer;
  procedure ClearServerInfo;
  function Connect: Boolean;
  procedure CreateConfig;
  procedure CreateManager;
  procedure DestroyConfig;
  procedure DestroyManager;
  procedure Disconnect;
  function FindService: Boolean;
  procedure GetAllLine(aPipe: TcsDataPipe);
  function GetAnnoExportEnabled: Boolean;
  function GetAutoClassEnabled: Boolean;
  function GetExportEnabled: Boolean;
  function GetImportEnabled: Boolean;
  procedure GetServerInfo;
  function OnNotif(aNotificationType: TCsNotificationType; aNumber: Integer; const aText: string): Boolean;
  function pm_GetEnableQueryProcessing: Boolean;
  function pm_GetIsConnected: Boolean;
  function pm_GetServerRunning: Boolean;
  function pm_GetServiceInstalled: Boolean;
  function pm_GetServiceStatus: TJclServiceState;
  function pm_GetTaskByIndex(Index: Integer): TddProcessTask;
  function pm_GetTaskListCount: Integer;
  procedure pm_SetEnableQueryProcessing(const aValue: Boolean);
  procedure pm_SetIsBaseLocked(const aValue: Boolean);
  procedure SetAnnoExportEnabled(const Value: Boolean);
  procedure SetAutoClassEnabled(const Value: Boolean);
  procedure SetExportEnabled(const Value: Boolean);
  procedure SetImportEnabled(const Value: Boolean);
  function Timeout: Integer;
  procedure WorkE(E: Exception);
  procedure _ReadBaseStatus(aPipe: TcsDataPipe);
 protected
  procedure Cleanup; override;
  procedure ClearCommands;
  function GetTaskByIndex(Index: Integer): TddProcessTask;
 public
  constructor Create(aOwner: TObject); override;
  procedure ConfigService;
  procedure ContinueService;
  procedure GetServerCommands;
  function InstallService: Boolean;
  function PauseService: Boolean;
  function PingServer: Boolean;
  procedure RestartManager;
  function StartService: Boolean;
  function StopService: Boolean;
  function UninstallService: Boolean;
  procedure UpdateTaskList;
  procedure UpdateUserList;
  procedure UpdateActiveUserList;
  procedure UpdateBaseStatus;
  property AnnoExportEnabled: Boolean read GetAnnoExportEnabled write SetAnnoExportEnabled;
  property AutoClassEnabled: Boolean read GetAutoClassEnabled write SetAutoClassEnabled;
  property CommandsManager: TcsClientCommandsManager read f_CommandsManager;
  property EnableQueryProcessing: Boolean
   read pm_GetEnableQueryProcessing
   write pm_SetEnableQueryProcessing;
  property ExportEnabled: Boolean read GetExportEnabled write SetExportEnabled;
  property ImportEnabled: Boolean read GetImportEnabled write SetImportEnabled;
  property IsBaseLocked: Boolean read f_IsBaseLocked write pm_SetIsBaseLocked;
  property IsConnected: Boolean read pm_GetIsConnected;
  property LastError: string read f_LastError;
  property ServerRunning: Boolean read pm_GetServerRunning;
  property ServiceInstalled: Boolean read pm_GetServiceInstalled;
  property ServiceStatus: TJclServiceState read pm_GetServiceStatus;
  property TaskByIndex[Index: Integer]: TddProcessTask read pm_GetTaskByIndex;
  property TaskListCount: Integer read pm_GetTaskListCount;
  property OnServerStatus: TNotifyEvent
   read f_OnServerStatus
   write f_OnServerStatus;
  property OnTaskListChanged: TTaskListRefreshEvent read f_OnTaskListChanged write f_OnTaskListChanged;
  property OnUserListUpdated: TddUserListNotify read f_OnUserListUpdated write f_OnUserListUpdated;
 end;

implementation

Uses
 csUserRequestManager, ddAppConfig,
 csQueryTypes,
 StrUtils, l3ObjectRefList1, ActnList, math, 
 alcuConfig, ddIniStorage, alcuStrings,
 Dialogs, WinSvc, ddConfigStorages, csTaskTypes;

constructor TalcuPusa.Create(aOwner: TObject);
begin
 inherited;
 CreateConfig;
 f_Client := TCsClient.Create;
 f_Client.OnNotification := OnNotif;
 UserRequestManager.CSClient:= f_Client;
 f_CommandsManager:= TcsClientCommandsManager.Create(nil);
 f_CommandsManager.CSClient:= f_Client;
 (*TODO: extracted code
 try
  f_ServiceManager:= TJclSCManager.Create(ddAppConfiguration.AsString['ServerName'], DefaultSCMDesiredAccess or SC_MANAGER_CREATE_SERVICE);
 except
  l3Free(f_ServiceManager);
  ddAppConfiguration.AsString['ServerName']:= '';
 end;
 *)
 CreateManager;
 f_TickCount:= 0;
end;

procedure TalcuPusa.Cleanup;
begin
 Disconnect;
 DestroyConfig;
 l3Free(f_CommandsManager);
 DestroyManager;
 inherited;
end;

procedure TalcuPusa.ClearCommands;
begin
 f_CommandsManager.ClearCommands;
end;

procedure TalcuPusa.ClearServerInfo;
begin
 // TODO -cMM: TalcuPusa.ClearServerInfo default body inserted
end;

procedure TalcuPusa.ConfigService;
var
 l_Storage: TddIniStorage;
 l_Config: TddAppConfiguration;
begin
 if ddAppConfiguration.AsString['ServerConfig'] <> '' then
 begin
  l_Storage:= TddIniStorage.Create(ddAppConfiguration.AsString['ServerConfig']);
  try
   l_Config:= CreateConfigEx(l_Storage);
   try
    l_Config.AutoSave:= False;
    if l_Config.ShowDialog('Настройки службы', True) then
     l_Config.Save;
   finally
    l3Free(l_Config);
   end;
  finally
   l3Free(l_Storage);
  end;
 end
 else
  alcuMsgDialog('Не указан путь к файлу конфигурации службы', mtError, [mbOk], 0);
end;

function TalcuPusa.Connect: Boolean;
begin
 if not f_Client.IsStarted then
 begin
  f_Client.Start(ddAppConfiguration.AsString['ServerName'], ddAppConfiguration.AsInteger['ServerPort']);
  if f_Client.IsStarted then
   GetServerCommands
  else
   ClearCommands;
 end;
 Result:= f_Client.IsStarted;
end;

procedure TalcuPusa.ContinueService;
begin
 f_Service.Continue(True);
end;

procedure TalcuPusa.CreateConfig;
begin
 ddAppConfiguration:= TddAppConfiguration.Create(nil);
 with ddAppConfiguration do
 begin
  AutoSize:= True;
  AutoSave:= True;
  FontName := 'Verdana';
  AddNode('General', 'Основные');
   AddStringItem('ServerName', 'Адрес сервера');
    Hint:= 'Адрес сервера';
    Required:= True;
   AddIntegerItem(l3CStr('ServerPort'), l3CStr('Порт сервера'), 32100);
    Hint:= 'Порт сервера';
    Required:= True;
   AddFileNameItem('ServiceFile', 'Файл службы');
    Required:= True;
    Hint:= 'файл с сервисом';
    Filter:= 'Исполняемые Файлы (*.exe)|*.exe';
   AddFileNameItem('ServerConfig', 'Настройки службы');
    Hint:= 'Файл, в котором хранятся настройки службы';
    Filter:= 'Файлы настроек (*.ini)|*.ini';
    Required:= True;
   AddIntegerItem(l3CStr('UpdateInterval'), l3CStr('Интервал обновления статуса службы|сек'), 5);
  CloseChild;
  Load;
 end;
end;

procedure TalcuPusa.CreateManager;
begin
 try
  f_ServiceManager:= TJclSCManager.Create(ddAppConfiguration.AsString['ServerName'], DefaultSCMDesiredAccess or SC_MANAGER_CREATE_SERVICE);
 except
  l3Free(f_ServiceManager);
  ddAppConfiguration.AsString['ServerName']:= '';
 end;
end;

procedure TalcuPusa.DestroyConfig;
begin
 if f_Client.IsStarted then
  f_Client.Stop;
 l3Free(f_Client);
 l3Free(ddAppConfiguration);
end;

procedure TalcuPusa.DestroyManager;
begin
 l3Free(f_ServiceManager);
end;

procedure TalcuPusa.Disconnect;
begin
 f_Client.Stop;
end;

function TalcuPusa.FindService: Boolean;
begin
 if f_LastError = '' then
 try
  f_Servicemanager.Refresh(True);
  f_Servicemanager.FindService(cServiceName, f_Service);
 except
  on E: Exception do
   WorkE(E);
 end;
 Result:= f_LastError = '';
end;

procedure TalcuPusa.GetAllLine(aPipe: TcsDataPipe);
begin
 // TODO -cMM: TalcuPusa.GetAllLine default body inserted
end;

function TalcuPusa.GetAnnoExportEnabled: Boolean;
begin
// Result := cs_ttAnnoExport in UserRequestManager.EnabledTasks;
end;

function TalcuPusa.GetAutoClassEnabled: Boolean;
begin
// Result := cs_ttAutoClass in UserRequestManager.EnabledTasks;
end;

function TalcuPusa.GetExportEnabled: Boolean;
begin
// Result := cs_ttExport in UserRequestManager.EnabledTasks;
end;

function TalcuPusa.GetImportEnabled: Boolean;
begin
// Result := cs_ttImport in UserRequestManager.EnabledTasks;
end;

procedure TalcuPusa.GetServerCommands;
begin
 f_Client.Exec(qtGetCommands, f_CommandsManager.LoadCommands);
end;

procedure TalcuPusa.GetServerInfo;
begin
 UpdateUserList;
 UpdateActiveUserList;
 UpdateTaskList;
 UpdateBaseStatus;
end;

function TalcuPusa.GetTaskByIndex(Index: Integer): TddProcessTask;
begin
(*
  if InRange(Index,  0, UserRequestManager.TaskList.Hi) then
   Result:= TddProcessTask(UserRequestManager.TaskList.Items[Index])
  else
*)   Result:= nil;
end;

function TalcuPusa.InstallService: Boolean;
begin
 if not ServiceInstalled then
 try
  f_Service:= f_ServiceManager.Install(cServiceName, cServiceDisplayName,
                                       ddAppConfiguration.AsString['ServiceFile'], 'Автоматизация процессов Архивариуса',
                                       [stWin32OwnProcess], sstAuto);
 except
  on E: Exception do
   f_LastError:= E.Message;
 end;
 Result:= ServiceInstalled;
end;

function TalcuPusa.OnNotif(aNotificationType: TCsNotificationType; aNumber: Integer; const aText: string): Boolean;
begin
 Result:= True;
end;

function TalcuPusa.PauseService: Boolean;
begin
 if ServerRunning then
 begin
  f_Service.Pause{(False);
  f_Service.WaitFor(ssPaused, Timeout)};
  f_Service.Refresh;
  Result:= f_Service.ServiceState = ssPaused;
 end
 else
  Result:= True;
end;

function TalcuPusa.PingServer: Boolean;
var
 l_State : TJclServiceState;
begin
 Result:= False;
 l_State:= ssUnknown;
 if (not ServiceInstalled) and (f_Servicemanager <> nil) then
 begin
  if not FindService then
   exit
 end
 else
  l_State:= f_Service.ServiceState;
 if ServiceInstalled then
 begin
  f_Service.Refresh;
  if (l_State <> f_Service.ServiceState) or (not IsConnected) then
  begin
   if f_Service.ServiceState = ssRunning then
   begin
    if Connect then
     GetServerInfo
    else
     ClearServerInfo;
   end; // f_Service.ServiceState = ssRunning
   if Assigned(f_OnServerStatus) then
    f_OnServerStatus(Self);
  end // l_State <> f_Service.ServiceState
  else
  if f_Service.ServiceState = ssRunning then
  begin
   inc(f_TickCount);
   if f_TickCount = 10 then
   begin
    UpdateActiveUserList;
    UpdateTaskList;
    f_TickCount:= 0;
   end;
  end;
 end; // f_Servicemanager.FindService(cServiceName, l_Service)
 Result:= True;
end;

function TalcuPusa.pm_GetEnableQueryProcessing: Boolean;
begin
 Result := False;//UserRequestManager.ExecuteEnabled;
end;

function TalcuPusa.pm_GetIsConnected: Boolean;
begin
 Result := f_Client.IsStarted;
end;

function TalcuPusa.pm_GetServerRunning: Boolean;
begin
 Result := (ServiceInstalled) and (f_Service.ServiceState = ssRunning);
end;

function TalcuPusa.pm_GetServiceInstalled: Boolean;
begin
 Result := (f_Service <> nil){ and (f_Service.Handle <> 0)};
end;

function TalcuPusa.pm_GetServiceStatus: TJclServiceState;
begin
 if ServiceInstalled then
  Result := f_Service.ServiceState
 else
  Result := ssUnknown;
end;

function TalcuPusa.pm_GetTaskByIndex(Index: Integer): TddProcessTask;
begin
(*
  if InRange(Index,  0, UserRequestManager.TaskList.Hi) then
   Result:= TddProcessTask(UserRequestManager.TaskList[Index])
  else
*)   Result:= nil;
end;

function TalcuPusa.pm_GetTaskListCount: Integer;
begin
 Result := 0//UserRequestManager.TaskList.Count;
end;

procedure TalcuPusa.pm_SetEnableQueryProcessing(const aValue: Boolean);
begin
 // TODO -cMM: TalcuPusa.pm_SetEnableQueryProcessing default body inserted
end;

procedure TalcuPusa.pm_SetIsBaseLocked(const aValue: Boolean);
begin
 f_IsBaseLocked := aValue;
 // Отправить команду на сервер
end;

procedure TalcuPusa.RestartManager;
begin
 DestroyManager;
 CreateManager;
end;

procedure TalcuPusa.SetAnnoExportEnabled(const Value: Boolean);
begin
end;

procedure TalcuPusa.SetAutoClassEnabled(const Value: Boolean);
begin
end;

procedure TalcuPusa.SetExportEnabled(const Value: Boolean);
begin
(*
 if Value then
  UserRequestManager.EnabledTasks := UserRequestManager.EnabledTasks + [cs_ttExport]
 else
  UserRequestManager.EnabledTasks := UserRequestManager.EnabledTasks - [cs_ttExport];
*)
end;

procedure TalcuPusa.SetImportEnabled(const Value: Boolean);
begin
end;

function TalcuPusa.StartService: Boolean;
begin
 if ServiceInstalled then
 begin
  f_LastError:= '';
  if not ServerRunning then
  try
   f_Service.Start{(False);
   f_Service.WaitFor(ssRunning, Timeout)};
   PingServer;
  except
   on E: Exception do
    f_LastError:= E.Message;
  end;
  Result:= f_Service.ServiceState = ssRunning;
 end
 else
  Result:= False;
end;

function TalcuPusa.StopService: Boolean;
begin
 if ServiceInstalled then
 begin
  f_LastError:= '';
  if ServerRunning then
  try
   f_Service.Stop{(False);
   f_Service.WaitFor(ssRunning, Timeout)};
   PingServer;
  except
   on E: Exception do
    f_LastError:= E.Message;
  end; // ServerRunning
  Result:= f_Service.ServiceState in [ssUnknown, ssStopped];
 end
 else
  Result:= True;
end;

function TalcuPusa.Timeout: Integer;
begin
 Result := 30*1000;
end;

function TalcuPusa.UninstallService: Boolean;
begin
 f_LastError:= '';
 Result:= False;
 if StopService then
  if ServiceInstalled then
  try
   f_Service.Delete;
   FindService;
   Result:= not ServiceInstalled;
  except
   on E: Exception do
    WorkE(E);
  end
  else
   Result:= True
 else
  Result:= False;
end;

procedure TalcuPusa.UpdateTaskList;
begin
 // Режим выполнения
 //UserRequestManager.GetexecuteStatus;
 // Очередь заданий
 //UserRequestManager.GetLine;
end;

procedure TalcuPusa.UpdateUserList;
begin
 // Список всех пользователей
 //UserRequestManager.RequestUsersList;
end;

procedure TalcuPusa.UpdateActiveUserList;
var
 i: Integer;
begin
 // Список активных пользователей
 (*
 UserRequestManager.RequestActiveUserList;
 if Assigned(f_OnUserListUpdated) then
  for i:= 0 to Pred(UserRequestManager.ActiveUsersCount) do
   f_OnUserListUpdated(UserRequestManager.ActiveUsers[i], True);
 *)  
end;

procedure TalcuPusa.UpdateBaseStatus;
begin
 if f_Client.IsStarted then
  f_Client.Exec(qtGetBaseStatus, _ReadBaseStatus);
end;

procedure TalcuPusa.WorkE(E: Exception);
begin
 f_LastError:= E.Message;
 l3System.Exception2Log(E);
end;

procedure TalcuPusa._ReadBaseStatus(aPipe: TcsDataPipe);
var
 l_Msg: String;
begin
 with aPipe do
 begin
  f_IsBaseLocked:= Boolean(ReadSmallInt);
  l_Msg:= ReadStr;
 end;
end;

end.


