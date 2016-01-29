unit alcuSpyForm;
{$DEFINE dfs}
{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface
uses
  Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dt_Types, ComCtrls, vtDialogs, ExtCtrls, Grids,
  RXSplit, Menus,
  ImgList, CustomizeDlg,
  alcuTypes, ddServerTask,
  alcuPusa, ddProgressObj, alcuCommandsManager,
  ActnList, OvcBase,
  l3InterfacedComponent, {XPMan,} ActnMenus, ToolWin, ActnMan,
  ActnCtrls, XPStyleActnCtrls, vtStatusBar, IdBaseComponent,
  IdAntiFreezeBase, IdAntiFreeze, jclSvcCtrl, CoolTrayIcon,
  daTypes,
  dt_UserTypes, mxOneInstance, CsProcessTask, CsTaskTypes, csCommandsTypes;

type
  TalcuSpyForm = class(TForm)
    actAbout: TAction;
    actAutoLogoff: TAction;
    actBuildTextIndex: TAction;
    actCheckFreeSpace: TAction;
    actCheckTables: TAction;
    actCheckTexts: TAction;
    actCheckTextSize: TAction;
    actClearLocks: TAction;
    actCompileDictionaries: TAction;
    actConfig: TAction;
    actConfigService: TAction;
    actContinueService: TAction;
    actDailyUpdate: TAction;
    actDeleteTask: TAction;
    actEmailNotify: TAction;
    actExit: TAction;
    actFamilyBackup: TAction;
    actFindComputer: TAction;
    actFullBackup: TAction;
    actGardocBridge: TAction;
    ActionManager1: TActionManager;
    Actions: TActionList;
    actIsDeltaReady: TAction;
    ActiveUserList: TListBox;
    actLoadDelta: TAction;
    actLoadEQ: TAction;
    actLoadKW: TAction;
    actLockBase: TAction;
    actLogMessages: TAction;
    actMakeDelta: TAction;
    actMakeLoadDelta: TAction;
    actPauseService: TAction;
    actPauseTask: TAction;
    actPreventiveUpdate: TAction;
    actRefresh: TAction;
    actRestartService: TAction;
    actRestoreFamily: TAction;
    actRunTask: TAction;
    actSendMessage: TAction;
    actSetHighestPriority: TAction;
    actSetHighPriority: TAction;
    actSetLowestPriority: TAction;
    actSetLowPriority: TAction;
    actSetNormalPriority: TAction;
    actStack2Log: TAction;
    actStartService: TAction;
    actStopNGoall: TAction;
    actStopNGoAnnoExport: TAction;
    actStopNGoExport: TAction;
    actStopNGoImport: TAction;
    actStopService: TAction;
    actSwitchToRealBase: TAction;
    actSwitchToTempBase: TAction;
    actTune: TAction;
    actUndoRestore: TAction;
    actUnlockBase: TAction;
    actUpdateDictEntryIndex: TAction;
    actUpdateHeaderIndex: TAction;
    actUpdateIndex: TAction;
    actUpdateTables: TAction;
    actUpdateText: TAction;
    actUserInfo: TAction;
    actWeeklyUpdate: TAction;
    IdAntiFreeze1: TIdAntiFreeze;
    ImageList1: TImageList;
    Logo: TImage;
    MainMenu1: TMainMenu;
    menuBase: TMenuItem;
    menuDeleteTask: TMenuItem;
    menuFile: TMenuItem;
    menuPriority: TMenuItem;
    menuStopAndGoAll: TMenuItem;
    menuTaskList: TPopupMenu;
    menuTasks: TMenuItem;
    menuTools: TMenuItem;
    menuUtils: TMenuItem;
    N1: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N2: TMenuItem;
    N20: TMenuItem;
    N22: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N3: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    N39: TMenuItem;
    N4: TMenuItem;
    N40: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    N44: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    N48: TMenuItem;
    N49: TMenuItem;
    N5: TMenuItem;
    N50: TMenuItem;
    N51: TMenuItem;
    N52: TMenuItem;
    N53: TMenuItem;
    N54: TMenuItem;
    N55: TMenuItem;
    N56: TMenuItem;
    N57: TMenuItem;
    N58: TMenuItem;
    N59: TMenuItem;
    N60: TMenuItem;
    N61: TMenuItem;
    N62: TMenuItem;
    N63: TMenuItem;
    N64: TMenuItem;
    N65: TMenuItem;
    N66: TMenuItem;
    N67: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    PingTimer: TTimer;
    Query: TTabSheet;
    StatusBar: TvtStatusBar;
    TaskListView: TListView;
    Users: TTabSheet;
    UsersAndQuery: TPageControl;
    actInstallService: TAction;
    actUninstallService: TAction;
    N6: TMenuItem;
    N13: TMenuItem;
    actUpdateService: TAction;
    N21: TMenuItem;
    actConvert2Service: TAction;
    N23: TMenuItem;
    TrayImages: TImageList;
    TrayIcon: TCoolTrayIcon;
    TrayPopup: TPopupMenu;
    N24: TMenuItem;
    N41: TMenuItem;
    N47: TMenuItem;
    N68: TMenuItem;
    N69: TMenuItem;
    N70: TMenuItem;
    mxOneInstance1: TmxOneInstance;
    ServerMenu: TMenuItem;
    procedure actAboutExecute(Sender: TObject);
    procedure actAutoLogoffExecute(Sender: TObject);
    procedure actBackupUpdate(Sender: TObject);
    procedure actConfigServiceExecute(Sender: TObject);
    procedure actContinueServiceExecute(Sender: TObject);
    procedure actEQClassesExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure ActionsUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actLockBaseExecute(Sender: TObject);
    procedure actLogMessagesExecute(Sender: TObject);
    procedure actPauseServiceExecute(Sender: TObject);
    procedure actRestartServiceExecute(Sender: TObject);
    procedure actSendMessageExecute(Sender: TObject);
    procedure actSetPriorityExecute(Sender: TObject);
    procedure actStartServiceExecute(Sender: TObject);
    procedure actStopNGoallExecute(Sender: TObject);
    procedure actStopNGoAutoClassExecute(Sender: TObject);
    procedure actStopNGoQueryExecute(Sender: TObject);
    procedure actStopServiceExecute(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure dxBarButton26Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure itemCheckBaseClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure PingTimerTimer(Sender: TObject);
    procedure RefreshButtonClick(Sender: TObject);
    procedure TaskListViewChange(Sender: TObject; Item: TListItem; Change:
            TItemChange);
    procedure TaskListViewInfoTip(Sender: TObject; Item: TListItem;
      var InfoTip: String);
    procedure TaskListViewSelectItem(Sender: TObject; Item: TListItem;
            Selected: Boolean);
    procedure UsersAndQueryChange(Sender: TObject);
    procedure actUninstallServiceExecute(Sender: TObject);
    procedure actInstallServiceExecute(Sender: TObject);
    procedure actUpdateServiceExecute(Sender: TObject);
    procedure actConvert2ServiceExecute(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure N70Click(Sender: TObject);
    procedure mxOneInstance1InstanceExists(Sender: TObject);
 private
    f_AutoServer: TalcuPusa;
    f_ServiceStatus: TJclServiceState;
    procedure AddMenuItem(aCommand: TalcuCommand);
    procedure AppIdle(Sender: TObject; var Done: Boolean);
    procedure CheckActions(const Enable: Boolean = True);
    procedure CreateServer;
    function CurrentTask: TddProcessTask;
    procedure FileProc(aState: Byte; aValue: Integer; const aMsg: string);
    function HTLongProc(aState : TdaProcessState): Boolean;
    procedure ServerStatus(Sender: TObject);
    procedure SetAction(aAction: TAction; aCommand: TcsCommands; aEnabled: Boolean
        = True; aVisible: Boolean = True);
    procedure SetItemPriorityImage(aTask: TddTaskItem; aItem: TListItem);
    procedure SetItemStatusImage(aStatus: TcsTaskStatus; aItem: TListItem);
    procedure SetStatus(Value: TalcuStatus; QueryLen: Integer);
    procedure ShowHideMainForm;
    procedure StartPing;
    procedure StopPing;
    procedure Task2Item(aTask: TddProcessTask; aItem: TListItem);
    procedure TaskListChanged(Sender: TObject);
    procedure TotalProc(aState: Byte; aValue: Integer; const aMsg: string);
    procedure UpdateActions(ServiceStatus: TJclServiceState);
    procedure UpdateService;
    procedure UpdateTaskList;
    procedure UpdateUserLIst;
    function UserItemIndex: Integer;
    procedure UserListUpdated(theUser: TArchiUser; aActive: Boolean);
  protected
    procedure CheckResult(State: Boolean; const SuccessMsg, FaultMsg: string);
  end;

var
 PusaForm: TalcuSpyForm;

implementation

{$R *.DFM}

Uses
  afwFacade,
  ht_Const, ddUtils, l3IniFile, PrevInst,
  l3Base,  dt_Const, l3String, l3Types, l3Filer,
  l3Stream, SysUtils, l3ExceptionsLog,
  m0Const,m0AddTyp, mgConst, DateUtils, Types,
  stDate, stDateSt, l3FileUtils, alcuLockMessageDlg,
  alcuMailserver, alcuMessageDlg,
  alcuConfig, ddAppConfig, ddScheduler,
  alcuSMSDialog, Math,
  FileCtrl,
  alcuStrings,
  ddAboutDlg, csUserRequestManager, ddProcessDlg, StrUtils,
  ddIniStorage, rxDialogs;


const
  colPriority   = 0;
  colStatus     = 1;
  colDate       = 2;
  colParams     = 3;

  captionText = '"Архивариус". Сервер Автоматизации';


procedure TalcuSpyForm.actAboutExecute(Sender: TObject);
var
 l_Text: String;
 l_Bitmap: TBitmap;
begin
 { TODO 1 -oДудко -cРефакторинг : Это должно приезжать с сервера }
 ddAboutDialog(l_Text, Logo.Picture.Bitmap);
end;

procedure TalcuSpyForm.actAutoLogoffExecute(Sender: TObject);
var
  Res: Integer;
begin
  Res:= alcuMsgDialog(rsDannayaoperaciyaotklitVSEHpolzov, mtConfirmation, [mbYes, mbYesToAll, mbNo], 0);
  { TODO 1 -oДудко -cРефакторинг : Восстановить или выбросить }
  (*
  if Res =  mrYes then
   f_AutoServer.LogoffUsers(True, TArchiUser(ActiveUserList.Items.Objects[UserItemIndex]))
  else
  if Res =  mrYesToAll then
   f_AutoServer.LogoffUsers(True);
  *)
end;

procedure TalcuSpyForm.actBackupUpdate(Sender: TObject);
begin
(*
   { Уточнение того, можно ли выполнять действия }
  actFamilyBackup.Enabled:= ActiveUserList.Count = 0;
  actRestoreFamily.Enabled:= ActiveUserList.Count = 0;
  actCheckTables.Enabled:= ActiveUserList.Count = 0;
  actCheckTexts.Enabled:= ActiveUserList.Count = 0;
  actLoadKW.Enabled:= ActiveUserList.Count = 0;
  actUpdateTables.Enabled:= ActiveUserList.Count = 0;
  actUpdateIndex.Enabled:= ActiveUserList.Count = 0;
  actLoadDelta.Enabled:= ActiveUserList.Count = 0;
*)
end;

procedure TalcuSpyForm.actConfigServiceExecute(Sender: TObject);
begin
 StopPing;
 f_AutoServer.ConfigService;
 StartPing;
end;

procedure TalcuSpyForm.actContinueServiceExecute(Sender: TObject);
begin
 f_AutoServer.ContinueService;
end;

procedure TalcuSpyForm.actEQClassesExecute(Sender: TObject);
begin
  with OpenDialog1 do
  begin
   if Execute then
//    f_AutoServer.DoLoadEQClasses(FileName);
{ TODO 1 -oДудко -cРефакторинг : Восстановить или выбросить }
  end;
end;

procedure TalcuSpyForm.actExitExecute(Sender: TObject);
begin
 Close;
end;

procedure TalcuSpyForm.ActionsUpdate(Action: TBasicAction; var Handled:
        Boolean);
begin
 Handled:= true;
 // CheckActions(True);
 if f_ServiceStatus <> f_AutoServer.ServiceStatus then
 begin
  f_ServiceStatus:= f_AutoServer.ServiceStatus;
  UpdateActions(f_ServiceStatus);
 end;
 actInstallService.Enabled:= not f_AutoServer.ServiceInstalled;
 actUninstallService.Enabled:= f_AutoServer.ServiceInstalled;
end;

procedure TalcuSpyForm.actLockBaseExecute(Sender: TObject);
var
  l_DateStart, l_DateEnd: TDateTime;
begin
(*
  with TLockMessageDialog.Create(Application) do
  try
   if Execute then
   begin
    l_DateStart:= dtpStartLockDate.Date;
    ReplaceTime(l_DateStart, dtpStartLockTime.Time);
    l_DateEnd:= dtpLockDate.Date;
    ReplaceTime(l_DateEnd, dtpLockTime.Time);
    f_AutoServer.LockBase(comboMessage.Text, l_DateStart, l_DateEnd);
   end;
  finally
   Free;
  end;
*)
{ TODO 2 -oДудко -cРефакторинг : Восстановить или выбросить }
end;

procedure TalcuSpyForm.actLogMessagesExecute(Sender: TObject);
begin
(*
 f_AutoServer.LogMessages:= not f_AutoServer.LogMessages;
 actLogMessages.Checked := f_AutoServer.LogMessages;
*)
{ TODO 1 -oДудко -cРефакторинг : Восстановить или выбросить }
end;

procedure TalcuSpyForm.actPauseServiceExecute(Sender: TObject);
begin
 CheckResult(f_AutoServer.PauseService, 'Служба приостановлена', 'Не удалось перевести службу в паузу');
end;

procedure TalcuSpyForm.actRestartServiceExecute(Sender: TObject);
begin
 f_AutoServer.StopService;
 f_AutoServer.StartService;
end;

procedure TalcuSpyForm.actSendMessageExecute(Sender: TObject);
var
  S: string;
  l_ToAll: Boolean;
  l_Lock: Boolean;
  l_LockDateTime, l_StartLock: TDateTime;
  l_User: TArchiUser;
begin
 l_User:= TArchiUser(ActiveUserList.Items.Objects[UserItemIndex]);
 if GetUserMessage(l_User.UserName, S, l_ToAll, l_Lock, l_LockDateTime, l_StartLock) then
 begin
  if l_ToAll then
   l_User := nil;
  //f_AutoServer.SendMessage(l_User, S, l_Lock, l_StartLock, l_LockDateTime);
  { TODO 1 -oДудко -cРефакторинг : Восстановить или выбросить }
 end;
end;

procedure TalcuSpyForm.actSetPriorityExecute(Sender: TObject);
var
 l_Priority : Integer;
begin
  case (Sender as TAction).Tag of
   0: l_Priority := dd_tpHighest; // Высший
   1: l_Priority := dd_tpHigh; // Высокий
   3: l_Priority := dd_tpLow; // Низкий
   4: l_Priority := dd_tpLowest; // Низший
   5: l_Priority := dd_tpDead; // запретить выполнение
   6: l_Priority := dd_tpDead; // запретить выполнение
  else
   l_Priority := dd_tpNormal; // Нормальный
  end;
 CurrentTask.Priority := l_Priority;
end;

procedure TalcuSpyForm.actStartServiceExecute(Sender: TObject);
begin
 StopPing;
 CheckResult(f_AutoServer.StartService, 'Служба успешно запущена', 'Не удалось запустить службу');
 StartPing;
end;

procedure TalcuSpyForm.actStopNGoallExecute(Sender: TObject);
begin

 f_AutoServer.TaskExecutionEnabled:= not f_AutoServer.TaskExecutionEnabled;
 actStopNGoAll.Checked := f_AutoServer.TaskExecutionEnabled;

{ TODO 1 -oДудко -cРефакторинг : Восстановить или выбросить }
end;

procedure TalcuSpyForm.actStopNGoAutoClassExecute(Sender: TObject);
begin
// f_AutoServer.AutoClassEnabled := not f_AutoServer.AutoClassEnabled;
// actStopNGoExport.Checked:= f_AutoServer.AutoClassEnabled;
{ TODO 1 -oДудко -cРефакторинг : Восстановить или выбросить }
end;

procedure TalcuSpyForm.actStopNGoQueryExecute(Sender: TObject);
begin
  CurrentTask.Enabled:= not CurrentTask.Enabled;
end;

procedure TalcuSpyForm.actStopServiceExecute(Sender: TObject);
begin
 StopPing;
 CheckResult(f_AutoServer.StopService, 'Служба успешно остановлена', 'Не удалось остановить службу');
 StartPing;
end;

procedure TalcuSpyForm.AppIdle(Sender: TObject; var Done: Boolean);
begin
 Done:= True;
end;

procedure TalcuSpyForm.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TalcuSpyForm.CheckActions(const Enable: Boolean = True);
var
 l_TPEnabled, l_UPEnabled: Boolean;
begin
 // переключение действий в зависимости от активной закладки
 { TODO : Нужно учитывать доступность команды на сервере }
 if Enable then
 begin
  (*
  l_TPEnabled := (TaskListView.Items.Count > 0) and
                 (UsersAndQuery.ActivePage = Query) and
                 (TaskListView.ItemIndex <> -1);
  l_UPEnabled := (ActiveUserList.Items.Count > 0) and
                 (UsersAndQuery.ActivePage = Users) and
                 (ActiveUserList.ItemIndex <> -1);
   Actions.State:= asNormal;
   actFamilyBackup.Enabled:= ActiveUserList.Items.Count = 0;
   actRestoreFamily.Enabled:= ActiveUserList.Items.Count = 0;
   actCheckTables.Enabled:= ActiveUserList.Items.Count = 0;
   actCheckTexts.Enabled:= ActiveUserList.Items.Count = 0;
   actDailyUpdate.Enabled:= ActiveUserList.Items.Count = 0;
   actLoadKW.Enabled:= ActiveUserList.Items.Count = 0;
   actUpdateTables.Enabled:= ActiveUserList.Items.Count = 0;
   actUpdateIndex.Enabled:= ActiveUserList.Items.Count = 0;
   actMakeDelta.Enabled:= ActiveUserList.Items.Count = 0;
   actLoadDelta.Enabled:= ActiveUserList.Items.Count = 0;
   actFullBackup.Enabled:= ActiveUserList.Items.Count = 0;
   actSendMessage.Enabled:= l_UPEnabled;
   actAutoLogoff.Enabled:= l_UPEnabled;
   actUserInfo.Enabled := l_UPEnabled;

   actDeleteTask.Enabled := l_TPEnabled and (CurrentTask.Status in [dd_tsRun, dd_tsQuery, dd_tsFrozen, dd_tsDelivery]);
   actRunTask.Enabled := l_TPEnabled and (CurrentTask.Status in [dd_tsQuery, dd_tsFrozen]);
   //actRefresh.Enabled:= True;
   actUpdateHeaderIndex.Enabled:= ActiveUserList.Items.Count = 0;
   actLoadEQ.Enabled:= ActiveUserList.Items.Count = 0;
  if f_AutoServer <> nil then
  begin
   actStopNGoAll.Checked:= f_AutoServer.TaskExecutionEnabled;
   actStopNGoExport.Checked := f_AutoServer.ExportEnabled;
   actStopNGoImport.Checked := f_AutoServer.ImportEnabled;
   actStopNGoAnnoExport.Checked := f_AutoServer.AnnoExportEnabled;

   if f_AutoServer.IsBaseLocked then
   begin
    actLockBase.Checked:= True;
    actLockBase.Enabled:= False;
    actUnLockBase.Checked:= False;
    actUnLockBase.Enabled:= True;
   end
   else
   begin
    actLockBase.Checked:= False;
    actLockBase.Enabled:= True;
    actUnLockBase.Checked:= True;
    actUnLockBase.Enabled:= False;
   end;
  end;
  *)
   (*
   if not ddAppConfiguration.AsBoolean[SAutoPipeServerForm_IsLocalBase] then
   begin
    actSwitchToTempBase.Checked:= False;
    actSwitchToTempBase.Enabled:= True;
    actSwitchToRealBase.Checked:= True;
    actSwitchToRealBase.Enabled:= False;
   end
   else
   begin
    actSwitchToTempBase.Checked:= True;
    actSwitchToTempBase.Enabled:= False;
    actSwitchToRealBase.Checked:= False;
    actSwitchToRealBase.Enabled:= True;
   end;
   actSwitchToTempBase.Caption:= Format(rsVremennayabaza ,
                                          [ddAppConfiguration.AsString[SAutoPipeServerForm_LocalBasePath]]);
   actSwitchToRealBase.Caption:= Format(rsPostoyannayabaza ,
                                         [ddAppConfiguration.AsString[SAutoPipeServerForm_UNCBasePath]]);
   *)
 end;

{ TODO 1 -oДудко -cРефакторинг : Восстановить или выбросить }
end;

procedure TalcuSpyForm.CreateServer;
var
 l_Check: Boolean;
begin
 f_AutoServer:= TalcuPusa.Create(nil);
 f_AutoServer.OnServerStatus:= ServerStatus;
 f_AutoServer.OnUserListUpdated:= UserListUpdated;
 f_AutoServer.OnTaskListChanged:= TaskListChanged;
 PingTimer.Interval := ddAppConfiguration.AsInteger['UpdateInterval']*1000;
end;

function TalcuSpyForm.CurrentTask: TddProcessTask;
begin
 Result := TddProcessTask(TaskListView.Items[TaskListView.ItemIndex].Data);
end;

procedure TalcuSpyForm.dxBarButton26Click(Sender: TObject);
begin
 { TODO 1 -oДудко -cРефакторинг : Восстановить или выбросить }
 //f_AutoServer.DoEveryWeekUpdate(True);
end;

procedure TalcuSpyForm.FileProc(aState: Byte; aValue: Integer; const aMsg: string);
begin
  Application.ProcessMessages;
end;

procedure TalcuSpyForm.FormCreate(Sender: TObject);
var
 l_Dlg: TvtCurtainMsg;
begin
 l_Dlg:= vtShowCurtainMessage(l3CStr('Инициализация приложения. Пожалуйста, подождите.'));
 try
  l3System.Str2Log(FormatDateTime(rsSessiyazaputshenaDdMmYyyyvHhNn, Now));
  l3System.Str2Log(GetProgramVersion);
  StopPing;
  actClearLocks.Visible:= False;
  actUserInfo.Visible := False;
  actFindComputer.Visible := False;
  {$IFDEF alcuMoscow}
  f_Version:= GetProgramVersion;
  {$else}
  // отключить пункты меню
  actLogMessages.Visible := False;
  actGardocBridge.Visible:= False;
  {$ENDIF}

  UsersAndQuery.ActivePage:= Users;
  menuPriority.Enabled:= False;

  actRunTask.Enabled:= False;
  actPauseTask.Enabled:= False;
  actDeleteTask.Enabled:= False;
  actSetHighestPriority.Enabled := False;
  actSetHighPriority.Enabled := False;
  actSetLowestPriority.Enabled := False;
  actSetLowPriority.Enabled := False;
  actSetNormalPriority.Enabled := False;

  f_ServiceStatus:= ssUnknown;

  CreateServer;
  Application.ProcessMessages;
  UpdateActions(f_ServiceStatus);
  Application.ProcessMessages;
  if f_AutoServer.PingServer then
  begin
   Application.ProcessMessages;
   Application.OnIdle := AppIdle;
   ActiveControl:= ActiveUserList;
   StartPing;
  end
  else
  begin
   vtCloseCurtainMessage(l_Dlg);
   alcuMsgDialog(Format('Ошибка инициализации приложения: %s', [f_AutoServer.LastError]), mtError, [mbOk], 0);
  end;
 finally
  vtCloseCurtainMessage(l_Dlg);
 end;
end;

procedure TalcuSpyForm.FormDestroy(Sender: TObject);
begin
  l3Free(f_AutoServer);
  l3System.Str2Log(FormatDateTime(rsSessiyaostanovlenaDDMMYYYYvHhNn, Now));
end;

function TalcuSpyForm.HTLongProc(aState : TdaProcessState): Boolean;
begin
  Result:= False;
  Application.ProcessMessages;
end;

procedure TalcuSpyForm.itemCheckBaseClick(Sender: TObject);
begin
  { Verify }
  f_AutoServer.CommandsManager.ExecuteCommand(Sender);
{ TODO 1 -oДудко -cРефакторинг : Восстановить или выбросить }
end;

procedure TalcuSpyForm.N3Click(Sender: TObject);
begin
 StopPing;
 try
  if ddAppConfiguration.ShowNodeDialog('General') then
  begin

  end;
 finally
  StartPing;
 end
end;

procedure TalcuSpyForm.PingTimerTimer(Sender: TObject);
begin
 if f_AutoServer <> nil then
  with f_AutoServer do
  begin
   if PingServer then
   begin
    if ServerRunning and (not IsConnected) then
    begin
     PingTimer.Enabled:= False;
     alcuMsgDialog('Не удалось подключиться к службе. Проверьте параметр "Порт сервера"', mtWarning, [mbOk], 0);
     actConfig.Execute;
     PingTimer.Enabled:= True;
    end
   end
   else
   begin
    alcuMsgDialog(f_AutoServer.LastError, mtError, [mbOk], 0);
    StopPing;
   end
  end;
 Application.ProcessMessages;
end;

procedure TalcuSpyForm.RefreshButtonClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
   if UsersAndQuery.ActivePage = Users then
    UpdateUserLIst
   else
   if UsersAndQuery.ActivePage = Query then
   begin
    UpdateTaskList
   end;
  finally
   Screen.Cursor := crDefault;
  end;
end;

procedure TalcuSpyForm.ServerStatus(Sender: TObject);
var
 l_Hint: String;
 l_Icon: Integer;
begin
 if f_ServiceStatus <> f_AutoServer.ServiceStatus then
 begin
  f_ServiceStatus:= f_AutoServer.ServiceStatus;
  UpdateActions(f_ServiceStatus);
  case f_AutoServer.ServiceStatus of
   ssUnknown:
    begin
     l_Hint:= 'Статус Сервера Автоматизации Архивариуса неизвестен';
     l_Icon:= 0;
    end;         // Just fill the value 0
   ssStopped:
    begin
     l_Hint:= 'Сервер Автоматизации Архивариуса остановлен';
     l_Icon:= 2;
    end;            // SERVICE_STOPPED
   ssStartPending:    // SERVICE_START_PENDING
    begin
    end;
   ssStopPending:     // SERVICE_STOP_PENDING
    begin
    end;
   ssRunning:         // SERVICE_RUNNING
    begin
     l_Hint:= 'Сервер Автоматизации Архивариуса работает';
     l_Icon:= 1;
    end;
   ssContinuePending: // SERVICE_CONTINUE_PENDING
    begin
    end;
   ssPausePending:    // SERVICE_PAUSE_PENDING
    begin
    end;
   ssPaused:
    begin
     l_Hint:= 'Сервер Автоматизации Архивариуса приостановлен';
     l_Icon:= 0;
    end;
  end; // f_AutoServer.ServiceStatus
  TrayIcon.IconIndex:= l_Icon;
  TrayIcon.Hint:= l_Hint;
 end;
end;

procedure TalcuSpyForm.SetAction(aAction: TAction; aCommand: TcsCommands;
    aEnabled: Boolean = True; aVisible: Boolean = True);
var
 l_Action: TcsCommand;
begin
 if f_AutoServer.CommandsManager.CommandExists(ord(aCommand), l_Action) then
 begin
  aAction.OnExecute:= l_Action.OnExecute;
  aAction.Caption:= l_Action.Caption;
  aAction.Tag := l_Action.CommandID;
 end;
 aAction.Enabled:= aEnabled;
 aAction.Visible:= aVisible;
end;

procedure TalcuSpyForm.SetItemPriorityImage(aTask: TddTaskItem; aItem:
    TListItem);
begin
  if aTask.Priority = dd_tpHighest then
   aItem.SubItemImages[colPriority]:= 5
  else
   if InRange(aTask.Priority, Succ(dd_tpHighest), dd_tpHigh) then
    aItem.SubItemImages[colPriority]:= 6
   else
    if InRange(aTask.Priority, Succ(dd_tpHigh), dd_tpNormal) then
     aItem.SubItemImages[colPriority]:= -1
    else
     if InRange(aTask.Priority, Succ(dd_tpNormal), dd_tpLow) then
      aItem.SubItemImages[colPriority]:= 7
     else
      aItem.SubItemImages[colPriority]:= 8;
end;

procedure TalcuSpyForm.SetItemStatusImage(aStatus: TcsTaskStatus; aItem: TListItem);
begin
  case aStatus of
   cs_tsQuery     : aItem.SubItemImages[colStatus] := 15;
   cs_tsDone      : aItem.SubItemImages[colStatus] := 17;
   cs_tsRun,
   cs_AsyncRun    : aItem.SubItemImages[colStatus] := 9;//21;
   cs_tsDeleted   : aItem.SubItemImages[colStatus] := 16;
   cs_tsFrozen    : aItem.SubItemImages[colStatus] := 19;
   cs_tsError,
   cs_tsAsyncError: aItem.SubItemImages[colStatus] := 18;
   cs_tsReadyToDelivery : aItem.SubItemImages[colStatus] := 21;
  end; // case aStatus;
end;

procedure TalcuSpyForm.SetStatus(Value: TalcuStatus; QueryLen: Integer);
begin
(*
  case Value of
    dd_apsIdle:
      begin
       StatusBar.Panels[0].Text:= rsOzhidaniezadaniy;
       {$IFDEF DFS}
         with StatusBar.Panels[1] do
         begin
           PanelType:= sptNormal;
           GaugeAttrs.Position:= 0;
           Text:= '';
         end;
         with StatusBar.Panels[0] do
         begin
           PanelType:= sptNormal;
           GaugeAttrs.Position:= 0;
         end;
        {$ENDIF}
        Caption:= CaptionText;
      end;
    dd_apsChecking:
      begin
        StatusBar.Panels[0].Text:= rsPoiskoeredi;
        StatusBar.Panels[1].Text:= '';
      end;
    dd_apsImport:
      begin
        StatusBar.Panels[0].Text:= rsIdetimport;
        Caption:= rsImport + f_AutoServer.CurrentUserName + rs+ CaptionText;
      end;
    dd_apsExport:
      begin
       StatusBar.Panels[0].Text:= rsPodgotovkaeksporta;
       Caption:= rsEksport + f_AutoServer.CurrentUserName+ rs+ CaptionText;
      end;
    dd_apsAutoClass:
     begin
       StatusBar.Panels[0].Text:= rsPodgotovkaavtoklassifikacii;
       Caption:= rsAvtoklassifikaciya + f_AutoServer.CurrentUserName+ rs+ CaptionText;
     end;
    dd_apsFound:
      begin
        StatusBar.Panels[0].Text:= rsPoiskoeredi;
        StatusBar.Panels[1].Text:= Format(rsnaydeno, [QueryLen]);
      end;
    dd_apsSendMessage:
      begin
        StatusBar.Panels[0].Text:= rsFormirovaniesoobtsheniya;
        StatusBar.Panels[1].Text:= '';
      end;
    dd_apsCheckTextBase:
      begin
        StatusBar.Panels[0].Text:= rsProverkatekstovoybazy;
        StatusBar.Panels[1].Text:= '';
      end;
    dd_apsBackup:
      begin
        StatusBar.Panels[0].Text:= rsSozdaniekopiibazy;
        StatusBar.Panels[1].Text:= '';
      end;
    dd_apsUndoBackup:
      begin
        StatusBar.Panels[0].Text:= rsVosstanovleniebazy;
        StatusBar.Panels[1].Text:= '';
      end;
    dd_apsFullBackup:
      begin
        StatusBar.Panels[0].Text:= rsSozdaniepolnoykopiibazy;
        StatusBar.Panels[1].Text:= '';
      end;
    dd_apsUndoFullBackup:
      begin
        StatusBar.Panels[0].Text:= rsVosstanovleniepolnoybazy;
        StatusBar.Panels[1].Text:= '';
      end;
    dd_apsLoadKW:
      begin
        StatusBar.Panels[0].Text:= rsZagruzkafaylaklevyhslov;
        StatusBar.Panels[1].Text:= '';
      end;
    dd_apsLoadNSRC:
      begin
        StatusBar.Panels[0].Text:= rsZagruzkaNSRCfaylov;
        StatusBar.Panels[1].Text:= '';
      end;
    dd_apsLoadDelta:
      begin
        StatusBar.Panels[0].Text:= rsZagruzkaDelty;
        StatusBar.Panels[1].Text:= '';
      end;
    dd_apsIndexHeaders:
      begin
        StatusBar.Panels[0].Text:= rsIndeksaciyanazvaniydokumentov;
        StatusBar.Panels[1].Text:= '';
      end;
    else
      begin
        StatusBar.Panels[0].Text:= TddAutoPipeStatusNames[Value];
        StatusBar.Panels[1].Text:= '';
      end;
  end; { case Value }
  //if Value <> dd_apsStartBaseEngine then
  // CheckActions(Value = dd_apsIdle);
  StatusBar.Panels[2].Text:= Format(rsOered, [QueryLen]);
*)
  Application.ProcessMessages;
end;

procedure TalcuSpyForm.StartPing;
begin
 PingTimer.Enabled:= True;
end;

procedure TalcuSpyForm.StopPing;
begin
 PingTimer.Enabled:= False;
end;

procedure TalcuSpyForm.Task2Item(aTask: TddProcessTask; aItem: TListItem);
var
 l_UserName: ShortString;
 l_ActFlag: Byte;
 l_User: TArchiUser;
begin
  // aitem.Caption:= IntToStr(Succ(aTask.Index));
  case aTask.TaskType of
   cs_ttImport: aItem.ImageIndex:= 11;//aitem.Caption:= rsimport1;
   cs_ttAnnoExport, cs_ttAExportDoc, cs_ttAExportAnno, cs_ttAnoncedExport,
   cs_ttExport: aItem.ImageIndex:= 12;//aitem.Caption:= rseksport1;
   cs_ttAutoClass: aItem.ImageIndex:= 13;//aitem.Caption:= rsklassifikaciya;
  else
   aItem.ImageIndex := -1;
  end;
  aitem.Data:= aTask;
  with aitem.SubItems do
  begin
   l_User:= nil; //UserRequestManager.Users[aTask.UserID];
   if l_User <> nil then
    l_UserName:= l_User.UserName
   else
    l_UserName:= Format('Пользователь №%d', [aTask.UserID]);
   aItem.caption:= l_UserName;// имя пользователя
   Add('');
   SetItemPriorityImage(aTask, aItem);
   Add('');
   SetItemStatusImage(aTask.Status, aItem);
   Add(FormatDateTime(rsDdMmYyHhNn, aTask.Date));
   Add(atask.Description);
  end; // with item.SubItems
end;

procedure TalcuSpyForm.TaskListChanged(Sender: TObject);
var
 i, l_Index: Integer;
 item: TListItem;
 l_Status: TcsTaskStatus;
 l_ACount: Integer;
begin
(*
  l_Index:= TaskListView.ItemIndex;
  l_ACount := 0;//TaskProcessor.ActiveTaskListCount;
  Query.Caption:= Format(rsZadaniya, [l_ACount, UserRequestManager.TaskList.Count]);
  item:= TaskListView.FindData(0, theTask, True, False);
  if item = nil then
  begin
   item:= TaskListView.Items.Insert(0);
   Task2Item(theTask, item);
  end // item = nil
  else
  begin
   SetItemPriorityImage(theTask, Item);
   SetItemStatusImage(theTask.Status, Item);
   l_Status:= theTask.Status;
   actRunTask.Enabled:= (l_Status in [cs_tsQuery, cs_tsFrozen]){ and f_AutoServer.TaskEnabled[TddProcessTask(Item.Data).TaskID]};
   actPauseTask.Enabled:= l_Status in [cs_tsRun];
   actDeleteTask.Enabled:= l_Status in [cs_tsQuery, cs_tsFrozen, cs_tsRun];
  end; // item <> nil
*)
  Application.ProcessMessages;
end;

procedure TalcuSpyForm.TaskListViewChange(Sender: TObject; Item: TListItem;
        Change: TItemChange);
begin
 menuPriority.Enabled:= (TaskListView.Items.Count > 0) and (TaskListView.ItemIndex <> -1);
end;

procedure TalcuSpyForm.TaskListViewInfoTip(Sender: TObject;
  Item: TListItem; var InfoTip: String);
begin
 InfoTip := TddProcessTask(Item.Data).Comment;
end;

procedure TalcuSpyForm.TaskListViewSelectItem(Sender: TObject; Item: TListItem;
        Selected: Boolean);
var
  l_Status: TcsTaskStatus;
  l_Priority : Integer;
begin
  if Selected then
  begin
   l_Status:= TddProcessTask(Item.Data).Status;
   l_Priority := TddProcessTask(Item.Data).Priority;
   actRunTask.Enabled:= (l_Status in [cs_tsQuery, cs_tsFrozen]){ and f_AutoServer.TaskEnabled[TddProcessTask(Item.Data).TaskID]};
   actPauseTask.Enabled:= l_Status in [cs_tsRun];
   actDeleteTask.Enabled:= l_Status in [cs_tsQuery, cs_tsFrozen, cs_tsRun];
   actSetHighestPriority.Enabled := (l_Status in [cs_tsQuery, cs_tsFrozen, cs_tsRun])
                                     and (l_Priority <> dd_tpHighest);
   actSetHighPriority.Enabled := (l_Status in [cs_tsQuery, cs_tsFrozen, cs_tsRun])
                                     and (l_Priority <> dd_tpHigh);
   actSetLowestPriority.Enabled := (l_Status in [cs_tsQuery, cs_tsFrozen, cs_tsRun])
                                     and (l_Priority <> dd_tpLowest);
   actSetLowPriority.Enabled := (l_Status in [cs_tsQuery, cs_tsFrozen, cs_tsRun])
                                     and (l_Priority <> dd_tpLow);
   actSetNormalPriority.Enabled := (l_Status in [cs_tsQuery, cs_tsFrozen, cs_tsRun])
                                     and (l_Priority <> dd_tpNormal);
  end
  else
  begin
   actSetHighestPriority.Enabled := False;
   actSetHighPriority.Enabled := False;
   actSetLowestPriority.Enabled := False;
   actSetLowPriority.Enabled := False;
   actSetNormalPriority.Enabled := False;
  end;
end;

procedure TalcuSpyForm.TotalProc(aState: Byte; aValue: Integer; const aMsg: string);
begin
(*
  case aState of
   0: begin
       {$IFDEF DFS}
       with StatusBar.Panels[0] do
       begin
        PanelType:= sptGauge;
        GaugeAttrs.Position:= 0;
       end;
       {$ENDIF}
       f_Total:= aValue;
       StatusBar.Panels[0].Text:= aMsg;
      end;
   1:
    with StatusBar.Panels[0] do
    begin
     {$IFDEF DFS}
     try
      if aValue <= f_Total then
       GaugeAttrs.Position:= MulDiv(aValue, 100, f_Total)
      else
       GaugeAttrs.Position:= 100;
     except
      GaugeAttrs.Position:= 100;
     end;
     {$ENDIF}
     if (aMsg <> '') and (Pos('/', aMsg) = 0) then
      Text:= aMsg
     else
      Text:= Format(rsiz, [aValue, f_Total]);
    end;
   2:
     with StatusBar.Panels[0] do
     begin
     {$IFDEF DFS}
      PanelType:= sptNormal;
      GaugeAttrs.Position:= 0;
     {$ENDIF}
      Text:= '';
     end;
  end;
*)
{ TODO 1 -oДудко -cРефакторинг : Восстановить или выбросить }
 afw.ProcessMessages;
end;

procedure TalcuSpyForm.UpdateActions(ServiceStatus: TJclServiceState);
var
 l_Enabled: Boolean;
 i: Integer;
begin
 // Управление службой
 SetAction(actStartService, acmdStart, ServiceStatus in [ssStopped]);
 SetAction(actStopService, acmdStop, ServiceStatus in [ssRunning, ssPaused]);
 SetAction(actPauseService, acmdPause, ServiceStatus in [ssRunning]);
 SetAction(actContinueService, acmdContinue, ServiceStatus in [ssPaused]);
 SetAction(actRestartService, acmdRestart, ServiceStatus in [ssRunning, ssPaused]);


 l_Enabled:= ServiceStatus in [ssRunning];
 // информация
 actRefresh.Enabled:= l_Enabled;
 actInstallService.Enabled:= not f_AutoServer.ServiceInstalled;
 actUninstallService.Enabled:= f_AutoServer.ServiceInstalled;

 // Включаем-выключаем пункты меню
 menuTasks.Enabled:= l_Enabled;
 menuBase.Enabled:= l_Enabled;
 menuUtils.Enabled:= l_Enabled;
 menuTools.Enabled:= l_Enabled;

 // Управление сервером
 SetAction(actStopNGoall, acmdStopAndGoAll, f_AutoServer.CommandsManager.CommandEnabled[acmdStopAndGoAll]);
 SetAction(actDeleteTask, acmdDeleteTask, f_AutoServer.CommandsManager.CommandEnabled[acmdDeleteTask]);
 SetAction(actSendMessage, acmdSendMessage, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdsendMessage]);
 SetAction(actAutoLogoff, acmdAutoLogoff, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdAutoLogoff]);
 SetAction(actCheckTables, acmdCheckTables, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdCheckTables]);
 SetAction(actUpdateTables, acmdUpdateTables, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdUpdateTables]);
 SetAction(actLockBase, acmdLockBase, l_Enabled and not f_AutoServer.IsBaseLocked, f_AutoServer.CommandsManager.CommandEnabled[acmdLockBase]);
 SetAction(actUnlockBase, acmdUnlockBase, l_Enabled and f_AutoServer.IsBaseLocked, f_AutoServer.CommandsManager.CommandEnabled[acmdUnLockBase]);
 actLockBase.Checked:= f_AutoServer.IsBaseLocked;
 actUnLockBase.Checked:= not f_AutoServer.IsBaseLocked;
 SetAction(actCompileDictionaries, acmdCompileDictionaries, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdCompileDictionaries]);
 SetAction(actUpdateText, acmdUpdateText, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdUpdateText]);
 SetAction(actBuildTextIndex, acmdBuildTextIndex, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdBuildTextIndex]);


 SetAction(actCheckFreeSpace, acmdCheckFreeSpace, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdCheckFreeSpace]);
 SetAction(actCheckTexts, acmdCheckTexts, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdCheckTexts]);
 SetAction(actDailyUpdate, acmdDoEverydayUpdate, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdDoEverydayUpdate]);
 SetAction(actDeleteTask, acmdDeleteTask, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdDeleteTask]);
 SetAction(actEmailNotify, acmdEmailNotify, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdEmailNotify]);
 SetAction(actFamilyBackup, acmdFamilyBackup, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdFamilyBackup]);
 SetAction(actFullBackup, acmdFullBackup, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdFullBackup]);
 SetAction(actGardocBridge, acmdGardocBridge, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdGardocBridge]);
 SetAction(actIsDeltaReady, acmdIsDeltaReady, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdIsDeltaReady]);
 SetAction(actLoadDelta, acmdLoadDelta, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdLoadDelta]);
 SetAction(actLoadEQ, acmdLoadEQ, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdLoadEQ]);
 SetAction(actLoadKW, acmdLoadKW, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdLoadKW]);
 SetAction(actLogMessages, acmdLogMessages, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdLogMessages]);
 SetAction(actMakeDelta, acmdMakeDelta, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdMakeDelta]);
 SetAction(actMakeLoadDelta, acmdMakeLoadDelta, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdMakeLoadDelta]);
 SetAction(actPauseTask, acmdPauseTask, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdPauseTask]);
 SetAction(actPreventiveUpdate, acmdPreventiveUpdate, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdPreventiveUpdate]);
 SetAction(actRefresh, acmdRefresh, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdRefresh]);
 SetAction(actRestoreFamily, acmdRestoreFamily, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdRestoreFamily]);
 SetAction(actRunTask, acmdRunTask, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdRunTask]);
 SetAction(actSetHighestPriority, acmdSetHighestPriority, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdSetHighestPriority]);
 SetAction(actSetHighPriority, acmdSetHighPriority, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdSetHighPriority]);
 SetAction(actSetLowestPriority, acmdSetLowestPriority, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdSetLowestPriority]);
 SetAction(actSetLowPriority, acmdSetLowPriority, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdSetLowPriority]);
 SetAction(actSetNormalPriority, acmdSetNormalPriority, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdSetNormalPriority]);
 SetAction(actStopNGoAnnoExport, acmdStopNGoAnnoExport, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdStopNGoAnnoExport]);
 SetAction(actStopNGoExport, acmdStopNGoExport, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdStopNGoExport]);
 SetAction(actStopNGoImport, acmdStopNGoImport, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdStopNGoImport]);
 SetAction(actSwitchToRealBase, acmdSwitchToRealBase, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdSwitchToRealBase]);
 SetAction(actSwitchToTempBase, acmdSwitchToTempBase, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdSwitchToTempBase]);
 SetAction(actUndoRestore, acmdUndoRestore, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdUndoRestore]);
 SetAction(actUpdateDictEntryIndex, acmdUpdateDictEntryIndex, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdUpdateDictEntryIndex]);
 SetAction(actUpdateHeaderIndex, acmdUpdateHeaderIndex, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdUpdateHeaderIndex]);
 SetAction(actUpdateIndex, acmdUpdateIndex, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdUpdateIndex]);
 SetAction(actUserInfo, acmdUserInfo, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdUserInfo]);
 SetAction(actWeeklyUpdate, acmdWeeklyUpdate, l_Enabled, f_AutoServer.CommandsManager.CommandEnabled[acmdWeeklyUpdate]);




 //
 actStopNGoAll.Checked:= f_AutoServer.TaskExecutionEnabled;
 actStopNGoExport.Checked := f_AutoServer.ExportEnabled;
 actStopNGoImport.Checked := f_AutoServer.ImportEnabled;
 actStopNGoAnnoExport.Checked := f_AutoServer.AnnoExportEnabled;
 // Добавляем сервеные команды, если они есть
 UserRequestManager.FillServerMenu(ServerMenu);
end;

procedure TalcuSpyForm.UpdateTaskList;
var
 i: Integer;
 l_Task: TddProcessTask;
 item: TListItem;
begin
  // Запросить полный список заданий
 TaskListView.Clear;
 f_AutoServer.UpdateTaskList;
 for i:= 0 to Pred(f_AutoServer.TaskListCount) do
 begin
  l_Task:= f_AutoServer.TaskByIndex[i];
  item:= TaskListView.Items.Insert(0);
  Task2Item(l_Task, Item);
 end; // for i;
end;

procedure TalcuSpyForm.UpdateUserLIst;
begin
  ActiveUserList.Items.Clear;
  f_AutoServer.UpdateUserList;
  CheckActions;
  Users.Caption:= Format(rsPolzovateli, [ActiveUserList.Items.Count]);
end;

function TalcuSpyForm.UserItemIndex: Integer;
begin
  Result := ActiveUserList.ItemIndex;
end;

procedure TalcuSpyForm.UserListUpdated(theUser: TArchiUser; aActive: Boolean);
var
  l_NowString: string;
begin
  DateTimeToString(l_NowString, rsDdMmmYyyyHhNn, Now);
  if Active then
  begin
    if ActiveUserList.Items.IndexOf(theUser.UserName) = -1 then
      ActiveUserList.Items.Add(theUser.UserName)
    else
    begin
      l3System.Msg2Log('(?) <- %s', [theUser.UserName]);
    end;
    l3System.Msg2Log('-> %s', [theUser.UserName]);
  end
  else
  begin
    ActiveUserList.Items.Delete(ActiveUserList.Items.IndexOf(theUser.UserName));
    l3System.Msg2Log('<- %s', [theUser.UserName]);
  end;
  Users.Caption:= Format(rsPolzovateli, [ActiveUserList.Items.Count]);
  actSendMessage.Enabled := ActiveUserList.Items.Count > 0;
end;

procedure TalcuSpyForm.UsersAndQueryChange(Sender: TObject);
begin
  { TODO -oNarry -cРазвитие : Здесь переключать события в зависимости от активной закладки }

  if UsersAndQuery.ActivePage = Users then
  begin
   menuPriority.Enabled:= False;
  end
  else
  begin
   menuPriority.Enabled:= (TaskListView.Items.Count > 0) and (TaskListView.ItemIndex <> -1);
  end;
  CheckActions();
end;

procedure TalcuSpyForm.actUninstallServiceExecute(Sender: TObject);
begin
 StopPing;
 CheckResult(f_AutoServer.UninstallService, 'Служба удалена', 'Не удалось удалить службу');
 StartPing;
end;

procedure TalcuSpyForm.actInstallServiceExecute(Sender: TObject);
begin
 StopPing;
 CheckResult(f_AutoServer.InstallService, 'Служба успешно установлена', 'Не удалось установить службу');
 StartPing;
end;

procedure TalcuSpyForm.actUpdateServiceExecute(Sender: TObject);
begin
 UpdateService;
end;

procedure TalcuSpyForm.CheckResult(State: Boolean; const SuccessMsg, FaultMsg: string);
var
 l_Msg: String;
 l_DlgType: TMsgDlgType;
begin
 if State then
 begin
  l_Msg:= SuccessMsg;
  l_DlgType:= mtInformation;
 end
 else
 begin
  l_Msg:= FaultMsg;
  if f_AutoServer.LastError <> '' then
  begin
   l_Msg:= l_Msg + ': '#13#10 + f_AutoServer.LastError;
   l_DlgType:= mtError;
  end
  else
   l_DlgType:= mtWarning;
 end;
 alcuMsgDialog(l_Msg, l_DlgType, [mbOk], 0);
end;

procedure TalcuSpyForm.actConvert2ServiceExecute(Sender: TObject);
var
 l_Folder, l_File: String;
 l_Config: TddAppConfiguration;
 l_Storage: TddIniStorage;
begin
 { Начальная установка службы:
   1. Узнать у пользователя путь к папке с Парнем
   2. Скопировать инишник Парня в инишник службы
   3. Считать из инишника параметры сервер-порт и сохранить у себя
   4. Скопировать файл службы на сервер
   5. зарегистрировать службу
   6. Запустить службу
 }
 if SelectDirectory('Местоположение Парня', '', l_Folder) then
 begin
  l_File:= ConcatDirName(l_Folder, 'autopipeserver.ini');
  if FileExists(l_File) then
  begin
   l_Storage:= TddIniStorage.Create(l_File);
   try
    l_Config:= CreateConfigEx(l_Storage);
    try
     ddAppConfiguration.AsInteger['ServerPort']:= l_Config.AsInteger['ServerPort'];
     ddAppConfiguration.AsString['ServerName']:= l_Config.AsString['ServerName'];
    finally
     l3Free(l_Config);
    end;
   finally
    l3Free(l_Storage);
   end;
   CopyFile(l_File, ConcatDirName(l_Folder, 'archiService.ini'));
   ddAppConfiguration.AsString['ServerConfig']:= ConcatDirName(l_Folder, 'archiService.ini');
   ddAppConfiguration.AsString['ServerFile']:= ConcatDirName(l_Folder, 'archiService.exe');
  end; // FileExists(l_File)
  UpdateService;
 end; // SelectDirectory
end;

procedure TalcuSpyForm.AddMenuItem(aCommand: TalcuCommand);
begin
end;

procedure TalcuSpyForm.ShowHideMainForm;
begin
 if Application.MainForm.Visible then
  TrayIcon.HideMainForm
 else
  TrayIcon.ShowMainForm;
end;

procedure TalcuSpyForm.UpdateService;
var
 l_Dlg: TddProcessDialog;
 l_FileName: String;
begin
 if PromptForFileName(l_FileName, '*.exe') then
 begin
  l_Dlg:= MakeProcessDialog('Обновление службы',
           NewProcess('Остановка службы', -1,
           NewProcess('Удаление службы', -1,
           NewProcess('Копирование файла', 2,
           NewProcess('Установка службы', -1,
           NewProcess('Запуск службы', -1,
           nil))))));
  try
  // 1. Остановить службу
   l_Dlg.Start;
   f_AutoServer.StopService;
   l_Dlg.Finish();
  // 2. Отключить службу
   l_Dlg.Start;
   f_AutoServer.UninstallService;
   l_Dlg.Finish();
  // 3. Скопировать файл
   l_Dlg.Start;
   try
    CopyFile(l_FileName, ddAppConfiguration.AsString['ServiceFile']);
    l_Dlg.Update;
    CopyFile(ChangeFileExt(l_FileName, '.map'), ChangeFileExt(ddAppConfiguration.AsString['ServiceFile'], '.map'));
    l_Dlg.Finish();
   except
    l_Dlg.Abort;
   end;
  // 4. Установить службу
   l_Dlg.Start;
   f_AutoServer.InstallService;
   l_Dlg.Finish();
  // 5. Запустить службу
   l_Dlg.Start;
   f_AutoServer.StartService;
   l_Dlg.Finish;
  finally
   l3Free(l_Dlg);
  end;
 end;
end;

procedure TalcuSpyForm.TrayIconDblClick(Sender: TObject);
begin
 ShowHideMainForm;
end;

procedure TalcuSpyForm.N70Click(Sender: TObject);
begin
 ShowHideMainForm
end;

procedure TalcuSpyForm.mxOneInstance1InstanceExists(Sender: TObject);
begin
 //
end;

end.

