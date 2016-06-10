unit AutoPipeServerForm;
{$DEFINE dfs}
{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface
uses
  Windows, Messages, Classes, Graphics, Controls, Forms, alcuMsgDlg,
  StdCtrls, dt_Types, ComCtrls, vtDialogs, ExtCtrls, Grids,
  Menus, RXSplit,
  ImgList, CustomizeDlg,
  alcuTypes, ddServerTask,
  alcuAutoPipeServer, ddProgressObj,
  ActnList, OvcBase,
  {$IFDEF TrayIcon}
  CoolTrayIcon,
  {$ENDIF}
  l3InterfacedComponent, dt_User, ActnMenus, ToolWin, ActnMan,
  ActnCtrls, XPStyleActnCtrls, vtStatusBar, IdBaseComponent,
  daTypes, daInterfaces,
  Dialogs, IdAntiFreezeBase, IdAntiFreeze, csTaskTypes, csProcessTask,
  alcuShowMessage, alcuServer, SPHTMLHelp, vtLabel;

type
  TArchiServerForm = class(TForm)
    actAutoLogoff: TAction;
    actBuildTextIndex: TAction;
    actCheckFreeSpace: TAction;
    actCheckTables: TAction;
    actCheckTexts: TAction;
    actCheckTextSize: TAction;
    actClearLocks: TAction;
    actConfig: TAction;
    actDailyUpdate: TAction;
    actDeleteTask: TAction;
    actEmailNotify: TAction;
    actFamilyBackup: TAction;
    actFindComputer: TAction;
    actFullBackup: TAction;
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
    actPauseTask: TAction;
    actPreventiveUpdate: TAction;
    actRefresh: TAction;
    actRestoreFamily: TAction;
    actRunTask: TAction;
    actSendMessage: TAction;
    actSetHighestPriority: TAction;
    actSetHighPriority: TAction;
    actSetLowestPriority: TAction;
    actSetLowPriority: TAction;
    actSetNormalPriority: TAction;
    actStack2Log: TAction;
    actStopNGoall: TAction;
    actStopNGoAnnoExport: TAction;
    actStopNGoExport: TAction;
    actStopNGoImport: TAction;
    actSwitchToRealBase: TAction;
    actSwitchToTempBase: TAction;
    actTune: TAction;
    actUndoRestore: TAction;
    actUnlockBase: TAction;
    actUpdateDictEntryIndex: TAction;
    actUpdateHeaderIndex: TAction;
    actUpdateIndex: TAction;
    actUpdateTables: TAction;
    actUserInfo: TAction;
    actWeeklyUpdate: TAction;
    f_CloseTimer: TTimer;
    ImageList1: TImageList;
    listLog: TListBox;
    menuTaskList: TPopupMenu;
    N1: TMenuItem;
    N17: TMenuItem;
    N22: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N7: TMenuItem;
    N9: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Query: TTabSheet;
    RxSplitter1: TRxSplitter;
    StatusBar: TvtStatusBar;
    TaskListView: TListView;
    Users: TTabSheet;
    UsersAndQuery: TPageControl;
    actExit: TAction;
    MainMenu1: TMainMenu;
    menuFile: TMenuItem;
    N3: TMenuItem;
    menuTasks: TMenuItem;
    menuUtils: TMenuItem;
    menuTools: TMenuItem;
    N8: TMenuItem;
    N11: TMenuItem;
    menuPriority: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N13: TMenuItem;
    N21: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N29: TMenuItem;
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
    N40: TMenuItem;
    N41: TMenuItem;
    N42: TMenuItem;
    actAbout: TAction;
    N43: TMenuItem;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    N44: TMenuItem;
    Msg: TMenuItem;
    N46: TMenuItem;
    N47: TMenuItem;
    N48: TMenuItem;
    N49: TMenuItem;
    N50: TMenuItem;
    N51: TMenuItem;
    actUpdateText: TAction;
    N52: TMenuItem;
    N53: TMenuItem;
    N10: TMenuItem;
    N54: TMenuItem;
    N55: TMenuItem;
    N56: TMenuItem;
    N12: TMenuItem;
    N57: TMenuItem;
    N58: TMenuItem;
    N59: TMenuItem;
    N60: TMenuItem;
    IdAntiFreeze1: TIdAntiFreeze;
    N61: TMenuItem;
    actHelp: TAction;
    N62: TMenuItem;
    Timer1: TTimer;
    actApplyDMFile: TAction;
    N63: TMenuItem;
    actACInfo: TAction;
    N64: TMenuItem;
    N65: TMenuItem;
    actRestart: TAction;
    N45: TMenuItem;
    actLoadAKResults: TAction;
    N28: TMenuItem;
    N66: TMenuItem;
    actCalcCaseCode: TAction;
    N67: TMenuItem;
    N68: TMenuItem;
    N69: TMenuItem;
    actQueryCalculator: TAction;
    N70: TMenuItem;
    actImportManualAAC: TAction;
    actImportAAC: TAction;
    N71: TMenuItem;
    N72: TMenuItem;
    N73: TMenuItem;
    actExportDelta: TAction;
    actSet20005sub: TAction;
    N74: TMenuItem;
    actHavansky: TAction;
    N76: TMenuItem;
    actAutoExport: TAction;
    N77: TMenuItem;
    pnlShutdown: TvtLabel;
    actCopyVariablePartToBackup: TAction;
    actCopyVariablePartFromBackup: TAction;
    N75: TMenuItem;
    N78: TMenuItem;
    actSortByPriority: TAction;
    actSortByStatus: TAction;
    actSortByUser: TAction;
    N79: TMenuItem;
    N80: TMenuItem;
    N81: TMenuItem;
    N82: TMenuItem;
    actSortByDate: TAction;
    N83: TMenuItem;
    lblSMTPStatus: TvtLabel;
    N84: TMenuItem;
    menuCommands: TMenuItem;
    actPack: TAction;
    menuDelOldTasks: TMenuItem;
    menuScheduler: TMenuItem;
    actStopNGoResetAll: TAction;
    N85: TMenuItem;
    N86: TMenuItem;
    actSchedulerDump: TAction;
    Schedulerdump1: TMenuItem;
    actTasksDump: TAction;
    asksdump1: TMenuItem;
    actCommitImgCache: TAction;
    N87: TMenuItem;
    procedure actImportAACExecute(Sender: TObject);
    procedure actAbortExecute(Sender: TObject);
    procedure actAutoLogoffExecute(Sender: TObject);
    procedure actBackupUpdate(Sender: TObject);
    procedure actBuildTextIndexExecute(Sender: TObject);
    procedure actCheckFreeSpaceExecute(Sender: TObject);
    procedure actCheckTextExecute(Sender: TObject);
    procedure actDailyUpdateExecute(Sender: TObject);
    procedure actDeleteTaskExecute(Sender: TObject);
    procedure actEmailNotifyExecute(Sender: TObject);
    procedure actEQClassesExecute(Sender: TObject);
    procedure actFullBackupExecute(Sender: TObject);
    procedure ActionsUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actIsDeltaReadyExecute(Sender: TObject);
    procedure actLoadDeltaExecute(Sender: TObject);
    procedure actLockBaseExecute(Sender: TObject);
    procedure actLogMessagesExecute(Sender: TObject);
    procedure actMakeDeltaExecute(Sender: TObject);
    procedure actMakeLoadDeltaExecute(Sender: TObject);
    procedure actPauseTaskExecute(Sender: TObject);
    procedure actPreventiveUpdateExecute(Sender: TObject);
    procedure actRunTaskExecute(Sender: TObject);
    procedure actSendMessageExecute(Sender: TObject);
    procedure actSetPriorityExecute(Sender: TObject);
    procedure actStack2LogExecute(Sender: TObject);
    procedure actStopNGoallExecute(Sender: TObject);
    procedure actStopNGoAnnoExportExecute(Sender: TObject);
    procedure actStopNGoAutoClassExecute(Sender: TObject);
    procedure actStopNGoExportExecute(Sender: TObject);
    procedure actStopNGoImportExecute(Sender: TObject);
    procedure actStopNGoQueryExecute(Sender: TObject);
    procedure actSwitchToRealBaseExecute(Sender: TObject);
    procedure actSwitchToTempBaseExecute(Sender: TObject);
    procedure actTuningExecute(Sender: TObject);
    procedure actUndoRestoreExecute(Sender: TObject);
    procedure actUnlockBaseExecute(Sender: TObject);
    procedure actUpdateDictEntryIndexExecute(Sender: TObject);
    procedure actUpdateHeaderIndexExecute(Sender: TObject);
    procedure dxBarButton26Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure itemCheckBaseClick(Sender: TObject);
    procedure itemKWImportClick(Sender: TObject);
    procedure itemMakeBackupClick(Sender: TObject);
    procedure itemUndoBackupClick(Sender: TObject);
    procedure itemUpdateIndexClick(Sender: TObject);
    procedure itemUpdateTablesClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure RefreshButtonClick(Sender: TObject);
    procedure TaskListViewChange(Sender: TObject; Item: TListItem; Change:
            TItemChange);
    procedure TaskListViewInfoTip(Sender: TObject; Item: TListItem;
      var InfoTip: String);
    procedure TaskListViewSelectItem(Sender: TObject; Item: TListItem;
            Selected: Boolean);
    procedure UsersAndQueryChange(Sender: TObject);
    procedure _CloseTimer(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actUpdateTextExecute(Sender: TObject);
    procedure actWeeklyUpdateExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actApplyDMFileExecute(Sender: TObject);
    procedure actACInfoExecute(Sender: TObject);
    procedure actAutoExportExecute(Sender: TObject);
    procedure actCalcCaseCodeExecute(Sender: TObject);
    procedure actCommitImgCacheExecute(Sender: TObject);
    procedure actExportDeltaExecute(Sender: TObject);
    procedure actHavanskyExecute(Sender: TObject);
    procedure actLoadAKResultsExecute(Sender: TObject);
    procedure actManualImportAACExecute(Sender: TObject);
    procedure actQueryCalculatorExecute(Sender: TObject);
    procedure actRestartExecute(Sender: TObject);
    procedure actSet20005subExecute(Sender: TObject);
    procedure CoolTrayIcon1DblClick(Sender: TObject);
    procedure CoolTrayIcon1MinimizeToTray(Sender: TObject);
    procedure actCopyVariablePartToBackupExecute(Sender: TObject);
    procedure actCopyVariablePartFromBackupExecute(Sender: TObject);
    procedure TaskListViewCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure actSortByPriorityExecute(Sender: TObject);
    procedure actSortByStatusExecute(Sender: TObject);
    procedure actSortByUserExecute(Sender: TObject);
    procedure actSortByDateExecute(Sender: TObject);
    procedure lblSMTPStatusClick(Sender: TObject);
    procedure menuDelOldTasksClick(Sender: TObject);
    procedure actStopNGoResetAllExecute(Sender: TObject);
    procedure actSchedulerDumpExecute(Sender: TObject);
    procedure actTasksDumpExecute(Sender: TObject);
 private
    CancelAutoImport: Boolean;
    f_AutoServer: TalcuServer;
    f_FileProcError: Boolean;
    f_ManualClose: Boolean;
    f_MaxPos: LongInt;
    f_SMSIndex: Integer;
    f_SMSMessage: string;
    f_Total: LongInt;
    f_Updated: Boolean;
    f_Version: string;
    {$IFDEF TrayIcon}
    f_TrayIcon: TCoolTrayIcon;
    {$ENDIF}
    f_CompareKind: TcsTaskCompareKind;
    procedure CheckActions(const Enable: Boolean = True); // установка Enable(true/false) для Action
    procedure CreateTrayIcon;
    function CurrentTask: TddProcessTask;
    procedure DelayClose;
    procedure FileProc(aState: Byte; aValue: Integer; const aMsg: string);
    function ServerLongProc(aState : TdaProcessState): Boolean;
    procedure SetItemPriorityImage(aTask: TddTaskItem; aItem: TListItem);
    procedure SetItemStatusImage(aStatus: TcsTaskStatus; aItem: TListItem);
    procedure SetItemProgress(aTask: TddProcessTask; aItem: TListItem);
    procedure SetStatus(Value: TalcuStatus{; QueryLen: Integer});
    procedure StartUpIdle(Sender: TObject; var Done: Boolean);
    procedure StopAutoImport;
    procedure Task2Item(aTask: TddProcessTask; aItem: TListItem);
    procedure TaskListChanged(theTask: TddProcessTask);
    procedure TotalProc(aState: Byte; aValue: Integer; const aMsg: string);
    procedure WMQueryEndSession(var Msg: TWMQueryEndSession); message WM_QUERYENDSESSION;
    procedure UpdateTaskList; // полностью обновить список задач
    procedure UpdateUserLIst;
    function UserItemIndex: Integer;
    procedure UserListUpdated(theUser: IdaArchiUser; Active: Boolean);
    procedure YeldProc(Sender: TObject);
    procedure pm_SetCompareKind(const Value: TcsTaskCompareKind);
    procedure DoProcessMessages;
    procedure DoSmtpStatusChanged(Sender: TObject);
    procedure UpdateSMTPStatus;
    procedure UpdateSchedulerMenu;
    procedure ExecuteSchedulrTask(Sender: TObject);
 protected
    procedure WndProc(var Message: TMessage); override;
 public
    function EnableRestart: Boolean;
    property CompareKind: TcsTaskCompareKind read f_CompareKind write pm_SetCompareKind;
(*    property AutoServer: TalcuServerPrim read f_AutoServer; // для обращения из теста, процедуры DoIt*)
  end;

var
 ArchiServerForm: TArchiServerForm;

implementation

{$R *.DFM}

Uses
  TypInfo,
  afwFacade,
  ddUtils, l3IniFile, PrevInst,
  l3Base,  dt_Const, l3String, l3Types, l3Filer,
  l3Stream, SysUtils, l3ExceptionsLog, l3Utils,
  DateUtils, Types,
  daDataProvider,
  stDate, stDateSt, l3FileUtils,
  alcuMailserver, IdSSLOpenSSL, alcuUtils, alcuMessageDlg,
  alcuConfig, ddAppConfig, Dt_IndexSupport, ddAppConfigTypes,
  ddScheduler, ddCalendarEvents,
  alcuSMSDialog, Math,
  FileCtrl,
  alcuStrings,
  ddAboutDlg, StrUtils, alcuStat, csExport
  {$IFDEF Debug}
  , dt_Mail, dt_Sab, l3LongintList, alcuSpellChecker,
  m3StorageElementIDList, m3StorageInterfaces
  {$ENDIF}
  {$IFDEF HavanskyExport}
  , alcuHavanskyExportTask
  {$ENDIF}
 {$If defined(ManualSet20005Sub)}
  , alcuCourtDecisionSubChecker
  , csCourtDecisionSabCheckerParams
 {$IfEnd defined(ManualSet20005Sub)}
  , alcuAutoClassifier, ddAppConfigUtils, ddAppConfigStrings,
  alcuConfigTypes, ddAppConfigConst, DT_AskList, L3Bits, Dt_Query, ddAppConfigDataAdapters,
  alcuRegionAutoExportTask, dt_UserConst, BaseSupport,
  alcuTaskManager,
  afwAnswer,
  alcuTaskListBase,
  alcuCloseQueryDlg,
  l3BatchService
  ;


const
  colPriority   = 0;
  colStatus     = 1;
  colDate       = 2;
  colParams     = 3;
  colProgress   = 4;

  captionText = 'Сервер Автоматизации. "Архивариус"';

  cs_tsCanRunStatuses = [cs_tsQuery, cs_tsFrozen];
  cs_tsCanPauseStatuses = [cs_tsQuery, cs_tsFrozen];
  cs_tsCanChangePriotiryStatuses = [cs_tsQuery, cs_tsFrozen, cs_tsRun, cs_tsAsyncRun];

var
 msg_UpdateStatus: THandle = 0; 

procedure TArchiServerForm.actImportAACExecute(Sender: TObject);
var
 l_Folder: String;
 l_N: TddAppConfigNode;
begin
{$IFDEF AAC}
 l_Folder:= ddAppConfiguration.AsString['lcSourceFolder'];
 l_N:= MakeNode('Folder', 'Импорт "сырых" постановлений', True,
                MakeFolderName('Укажите папку с файлами', l_Folder));
 try
  if ExecuteNodeDialog(l_N) then
   f_AutoServer.UpdateAAC(l_N.Items[0].StringValue, False)
 finally
  FreeAndNil(l_N);
 end;
{$ENDIF}
end;

procedure TArchiServerForm.actAbortExecute(Sender: TObject);
begin
  f_AutoServer.DeleteTask(CurrentTask);
end;

procedure TArchiServerForm.actAutoLogoffExecute(Sender: TObject);
var
  Res: Integer;
begin
  Res:= alcuMsgDialog(rsDannayaoperaciyaotklitVSEHpolzov, mtConfirmation, [mbYes, mbYesToAll, mbNo], 0);
  if Res =  mrYes then
   f_AutoServer.LogoffUsers(True, IdaArchiUser(Pointer(ActiveUserList.Items.Objects[UserItemIndex])))
  else
  if Res =  mrYesToAll then
   f_AutoServer.LogoffUsers(True);
end;

procedure TArchiServerForm.actBackupUpdate(Sender: TObject);
begin
   { Уточнение того, можно ли выполнять действия }
  actFamilyBackup.Enabled:= ActiveUserList.Count = 0;
  actRestoreFamily.Enabled:= ActiveUserList.Count = 0;
  actCheckTables.Enabled:= ActiveUserList.Count = 0;
  actCheckTexts.Enabled:= ActiveUserList.Count = 0;
  actLoadKW.Enabled:= ActiveUserList.Count = 0;
  actUpdateTables.Enabled:= ActiveUserList.Count = 0;
  actUpdateIndex.Enabled:= ActiveUserList.Count = 0;
  actLoadDelta.Enabled:= ActiveUserList.Count = 0;
end;

procedure TArchiServerForm.actBuildTextIndexExecute(Sender: TObject);
begin
  f_AutoServer.DoBuildTextIndex;
end;

procedure TArchiServerForm.actCheckFreeSpaceExecute(Sender: TObject);
begin
 f_AutoServer.CheckFreeSpace(True);
end;

procedure TArchiServerForm.actCheckTextExecute(Sender: TObject);
begin
 {$IFDEF OldIndex}
  if not f_AutoServer.CheckTextBase then
   ShowMsg(rsumenyadlyavasplohayanovostvperem);
 {$ENDIF}
end;

procedure TArchiServerForm.actDailyUpdateExecute(Sender: TObject);
begin
 if f_AutoServer.DoEveryDayUpdate(true) = strRequestDelay then
  alcuShowMsg('Ежедневное обновление не может быть запущено - выполняется другая задача');
end;

procedure TArchiServerForm.actDeleteTaskExecute(Sender: TObject);
begin
 f_AutoServer.DeleteTask(CurrentTask);
 UpdateTaskList;
end;

procedure TArchiServerForm.actEmailNotifyExecute(Sender: TObject);
begin
 { Отправить письмо  }
 f_AutoServer.SendEmailNotify;
end;

procedure TArchiServerForm.actEQClassesExecute(Sender: TObject);
begin
  with OpenDialog1 do
  begin
   if Execute then
    f_AutoServer.DoLoadEQClasses(FileName);
  end;
end;

procedure TArchiServerForm.actFullBackupExecute(Sender: TObject);
var
 l_Folder: String;
begin
 if SelectDirectory(l_Folder, [sdAllowCreate, sdPerformCreate, sdPrompt], 0) then
  f_AutoServer.DoMakeFullBackup(ConcatDirName(l_Folder,
                                          StDateToDateString(SAutoPipeServerForm_YyyyMmDd, CurrentDate, True)));
end;

procedure TArchiServerForm.ActionsUpdate(Action: TBasicAction; var Handled:
        Boolean);
begin
  Handled:= true;
  CheckActions(True);
end;

procedure TArchiServerForm.actIsDeltaReadyExecute(Sender: TObject);
begin
 if f_AutoServer.CheckDeltaReady then
  alcuShowMsg(SAutoPipeServerForm_VsegotovodlyapostroeniyaDel_ty)
 else
  alcuShowMsg(SAutoPipeServerForm_ishodnyedannyedlyapostroeniyaDel);
end;

procedure TArchiServerForm.actLoadDeltaExecute(Sender: TObject);
begin
 // только импорт
 with f_AutoServer do
 begin
  LockBase('Ручной импорт еженедельной разницы документов');
  try
   LoadDeltaFiles;
  finally
   UnlockBase;
  end;
 end;
end;

procedure TArchiServerForm.actLockBaseExecute(Sender: TObject);
var
 l_Msg: String;
 l_DateStart, l_DateEnd: TDateTime;
begin
 if GetLockBaseMessage(l_Msg, l_DateStart, l_DateEnd) then
  f_AutoServer.LockBase(l_Msg, l_DateStart, l_DateEnd);
end;

procedure TArchiServerForm.actLogMessagesExecute(Sender: TObject);
begin
 f_AutoServer.LogMessages:= not f_AutoServer.LogMessages;
 actLogMessages.Checked := f_AutoServer.LogMessages;
end;

procedure TArchiServerForm.actMakeDeltaExecute(Sender: TObject);
begin
  { Make Delta }
  if not f_AutoServer.DoPrepareDelta then
   alcuShowMsg(rsVovremyapodgotovkiDeltyproizolao)
  else
   alcuShowMsg('Дельта успешно подготовлена');
end;

procedure TArchiServerForm.actMakeLoadDeltaExecute(Sender: TObject);
begin
 f_AutoServer.MakeAndLoadDelta(True);
end;

procedure TArchiServerForm.actPauseTaskExecute(Sender: TObject);
begin
 f_AutoServer.StopAndGoQuery(CurrentTask);
end;

procedure TArchiServerForm.actPreventiveUpdateExecute(Sender: TObject);
begin
 f_AutoServer.DoPreventiveUpdate(True);
end;

procedure TArchiServerForm.actRunTaskExecute(Sender: TObject);
begin
 f_AutoServer.StopAndGoQuery(CurrentTask);
end;

procedure TArchiServerForm.actSendMessageExecute(Sender: TObject);
var
  S: string;
  l_ToAll: Boolean;
  l_Lock: Boolean;
  l_LockDateTime, l_StartLock: TDateTime;
  l_User: IdaArchiUser;
begin
 l_User:= IdaArchiUser(Pointer(ActiveUserList.Items.Objects[UserItemIndex]));
 l_ToAll:= False;
 l_Lock:= False;
 if GetUserMessage(l_User.UserName, S, l_ToAll, l_Lock, l_LockDateTime, l_StartLock) then
 begin
  if l_ToAll then
   l_User := nil;
  f_AutoServer.SendMessage(l_User, S, l_Lock, l_StartLock, l_LockDateTime);
 end;
end;

procedure TArchiServerForm.actSetPriorityExecute(Sender: TObject);
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

procedure TArchiServerForm.actStack2LogExecute(Sender: TObject);
begin
 l3System.Stack2Log('Состояние сервера:');
end;

procedure TArchiServerForm.actStopNGoallExecute(Sender: TObject);
begin
 f_AutoServer.TaskExecutionEnabled:= not f_AutoServer.TaskExecutionEnabled;
 actStopNGoAll.Checked := f_AutoServer.TaskExecutionEnabled;
end;

procedure TArchiServerForm.actStopNGoAnnoExportExecute(Sender: TObject);
begin
 f_AutoServer.AnnoExportEnabled := not f_AutoServer.AnnoExportEnabled;
 actStopNGoExport.Checked:= f_AutoServer.AnnoExportEnabled;
end;

procedure TArchiServerForm.actStopNGoAutoClassExecute(Sender: TObject);
begin
 f_AutoServer.AutoClassEnabled := not f_AutoServer.AutoClassEnabled;
 actStopNGoExport.Checked:= f_AutoServer.AutoClassEnabled;
end;

procedure TArchiServerForm.actStopNGoExportExecute(Sender: TObject);
begin
 f_AutoServer.ExportEnabled := not f_AutoServer.ExportEnabled;
 actStopNGoExport.Checked:= f_AutoServer.ExportEnabled;
end;

procedure TArchiServerForm.actStopNGoImportExecute(Sender: TObject);
begin
 f_AutoServer.ImportEnabled := not f_AutoServer.ImportEnabled;
 actStopNGoExport.Checked:= f_AutoServer.ImportEnabled;
end;

procedure TArchiServerForm.actStopNGoQueryExecute(Sender: TObject);
begin
  CurrentTask.Enabled:= not CurrentTask.Enabled;
end;

procedure TArchiServerForm.actSwitchToRealBaseExecute(Sender: TObject);
begin
  f_AutoServer.SwitchToRealBase;
end;

procedure TArchiServerForm.actSwitchToTempBaseExecute(Sender: TObject);
begin
  f_AutoServer.SwitchToTemporaryBase;
end;

procedure TArchiServerForm.actTuningExecute(Sender: TObject);
begin
  {}
end;

procedure TArchiServerForm.actUndoRestoreExecute(Sender: TObject);
begin
  f_AutoServer.UndoRestoreBackup;
end;

procedure TArchiServerForm.actUnlockBaseExecute(Sender: TObject);
begin
  f_AutoServer.UnlockBase;
end;

procedure TArchiServerForm.actUpdateDictEntryIndexExecute(Sender: TObject);
begin
 f_AutoServer.DoUpdateDictEntryIndex;
end;

procedure TArchiServerForm.actUpdateHeaderIndexExecute(Sender: TObject);
begin
  f_AutoServer.DoUpdateHeaderIndex;
end;

procedure TArchiServerForm.CheckActions(const Enable: Boolean = True);
var
 l_TPEnabled, l_UPEnabled: Boolean;
 l_IDX: Integer;
begin
 if Enable and not f_AutoServer.IsShutdowning then
 begin
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
   actSchedulerDump.Enabled := l3System.MessageLevel = l3_msgLevel10;
   actSchedulerDump.Visible := l3System.MessageLevel = l3_msgLevel10;
   actTasksDump.Enabled := l3System.MessageLevel = l3_msgLevel10;
   actTasksDump.Visible := l3System.MessageLevel = l3_msgLevel10;

   actDeleteTask.Enabled := l_TPEnabled and (CurrentTask.Status in cs_tsCanDeleteStatuses);
   actRunTask.Enabled := l_TPEnabled and (CurrentTask.Status in cs_tsCanRunStatuses);
   actRefresh.Enabled:= True;// UsersAndQuery.ActivePage = Query;
   actUpdateHeaderIndex.Enabled:= ActiveUserList.Items.Count = 0;
   actLoadEQ.Enabled:= ActiveUserList.Items.Count = 0;
   actStopNGoAll.Checked:= f_AutoServer.TaskExecutionEnabled;
   actStopNGoExport.Checked := f_AutoServer.ExportEnabled;
   actStopNGoImport.Checked := f_AutoServer.ImportEnabled;
   actStopNGoAnnoExport.Checked := f_AutoServer.AnnoExportEnabled;
   actCommitImgCache.Enabled := f_AutoServer.IsImgCacheCommitable and (ActiveUserList.Count = 0);
(*
   actRunTask.Enabled:= False;
   actPauseTask.Enabled:= False;
   actDeleteTask.Enabled:= False;
*)
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

  actSortByPriority.Checked := CompareKind = cs_tckByPriority;
  actSortByStatus.Checked := CompareKind = cs_tckByStatus;
  actSortByUser.Checked := CompareKind = cs_tckByUser;
  actSortByDate.Checked := CompareKind = cs_tckByDate;
 end
 else
  for l_IDX := 0 to Actions.ActionCount - 1 do
   if (Actions[l_IDX] is TCustomAction) then
    TCustomAction(Actions[l_IDX]).Enabled := False;
end;

function TArchiServerForm.CurrentTask: TddProcessTask;
begin
 Result := TddProcessTask(TaskListView.Items[TaskListView.ItemIndex].Data);
end;

procedure TArchiServerForm.DelayClose;
begin
 f_CloseTimer.Enabled := True;
end;

procedure TArchiServerForm.dxBarButton26Click(Sender: TObject);
begin
 f_AutoServer.DoEveryWeekUpdate(True);
end;

function TArchiServerForm.EnableRestart: Boolean;
begin
 if (ParamCount > 0) and (AnsiCompareText('/restart', ParamStr(1)) = 0) then
  Result := not GotoPrevInst
 else
  Result := True;
end;

procedure TArchiServerForm.FileProc(aState: Byte; aValue: Integer; const aMsg: string);
begin
 try
  case aState of
   0: begin
       f_FileProcError:= False;
       with StatusBar.Panels[1] do
       begin
        {$IFDEF DFS}
        PanelType:= sptGauge;
        GaugeAttrs.Position:= 0;
        if avalue < 0 then
         GaugeAttrs.Style:= gsIndeterminate2
        else
         GaugeAttrs.Style:= gsPercent;
        {$ENDIF}
        Text:= aMsg;
       end;
       f_MaxPos:= aValue;
      end;

   1:{$IFDEF DFS}
    with StatusBar.Panels[1] do
    begin
     PanelType:= sptGauge;
     if avalue < 0 then
      GaugeAttrs.Style:= gsIndeterminate2
     else
     begin
      GaugeAttrs.Style:= gsPercent;
      if (f_MaxPos > 100) or (aValue > 100) then
       GaugeAttrs.Position:= Min(100, MulDiv(aValue, 100, f_MaxPos))
      else
       GaugeAttrs.Position:= aValue;
     end;
     if aMsg <> '' then
      Text:= aMsg;
    end;
    {$ELSE}
     StatusBar.Panels[1].Text:= Format(rsiz, [aValue, f_MaxPos]);
    {$ENDIF}
   2:
     with StatusBar.Panels[1] do
     begin
     {$IFDEF DFS}
      PanelType:= sptNormal;
      GaugeAttrs.Position:= 0;
     {$ENDIF}
      Text:= '';
     end;
  end;
 except
  if not f_FileProcError then
  begin
   f_FileProcError:= True;
   l3System.Stack2Log(Format('FileProc State: %d, Value: %d', [aState, aValue]));
  end; // not f_FileProcError
 end;
 DoProcessMessages;
end;

procedure TArchiServerForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
 l_CanClose : Boolean;
 l_DialogResult: Integer;
 l_Dlg: TalcuCloseQueryDlgForm;
begin
 l_DialogResult := mrNo;
 if f_ManualClose then
  if f_AutoServer.TaskProcessor.ExecutingTask(False) then
  begin
   l_Dlg := TalcuCloseQueryDlgForm.Create(nil);
   try
    l_DialogResult := l_Dlg.ShowModal;
    l_CanClose := l_DialogResult <> mrCancel;
   finally
    FreeAndNil(l_Dlg);
   end;
  end
  else
   l_CanClose := alcuMsgDialog(SAutoPipeServerForm_ConfirmExit, mtConfirmation, [mbYes, mbNo], 0) = mrYes
 else
  l_CanClose := True;
 if l_CanClose then
 begin
  case l_DialogResult of
    mrYes: f_AutoServer.InitiateShutdownWithWait;
    mrNo: f_AutoServer.InitiateShutdownWithAbort;
  end;
  CanClose := f_AutoServer.CanCloseWithWait;
  ddAppConfiguration.AsBoolean['LegalShutdown']:= CanClose;
  if not CanClose then
  begin
   pnlShutdown.Visible := f_AutoServer.IsShutdowning;
   CheckActions(False);
   DelayClose;
  end;
 end // Application.MessageBox
 else
  CanClose := False;
end;

procedure TArchiServerForm.FormCreate(Sender: TObject);
var
 l_Check: Boolean;
begin
 repeat
 until EnableRestart;
 alcuMail.OnSMTPErrorStatusChanged := DoSmtpStatusChanged;
 f_CompareKind := cs_tckByDate;
 CreateTrayIcon;
 f_ManualClose := True;
 actClearLocks.Visible:= False;
 actUserInfo.Visible := False;
 actFindComputer.Visible := False;
 if FileExists(ChangeFileExt(application.exename,'.hlp')) then
  Application.HelpFile:= ChangeFileExt(application.exename,'.hlp');
 actHelp.Enabled:= Application.HelpFile <> '';
 {$IFDEF ManualSet20005Sub}
 actSet20005sub.Visible:= True;
 {$ELSE}
 actSet20005sub.Visible:= False;
 {$ENDIF}
 {$IFDEF Region}
 // отключить пункты меню
 f_Version:= GetProgramVersion + 'R.';
 actLoadAKResults.Visible:= False;
 {$else}
 f_Version:= GetProgramVersion;
  {$IFDEF Debug}
  f_Version:= f_Version + 'DEBUG';
  {$ENDIF debug}
 {$ENDIF}
 {$IFNDEF UserQuery}
 actQueryCalculator.Visible:= False;
 {$ENDIF}
 {$IFDEF AAC}
 f_Version:= f_Version + 'ААС';
 actCalcCaseCode.Visible:= True;
 actImportManualAAC.Visible:= True;
 actImportAAC.Visible:= True;
 {$ELSE}
 actCalcCaseCode.Visible:= False;
 actImportManualAAC.Visible:= False;
 actImportAAC.Visible:= False;
 {$ENDIF}
 {$IFNDEF EveryWeek}
 N6.Visible:= False;
 actLoadDelta.Visible:= False;
 actIsDeltaReady.Visible:= False;
 actMakeDelta.Visible:= False;
 actMakeLoadDelta.Visible:= False;
 actWeeklyUpdate.Visible:= False;
 {$ENDIF}
 {$IFNDEF Prime}
 actStopNGoAnnoExport.Visible:= False;
 {$ENDIF}
 {$IFNDEF AutoClass}
 N28.Visible:= False;
 N58.Visible:= False;
 actLoadAKResults.Visible:= False;
 actACInfo.Visible:= False;
 {$ENDIF}
 {$IFNDEF ManualExchangeDocs}
 actExportDelta.Visible:= False;
 actExportDelta.Enabled:= False;
 {$ENDIF}
 {$IFDEF HavanskyExport}
 actHavansky.Visible:= True;
 {$ENDIF}


 l3System.Str2Log(FormatDateTime(rsSessiyazaputshenaDdMmYyyyvHhNn, Now));
 l3System.Str2Log(f_Version);

   f_Updated:= False;
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
   { Инициализация списка }
   f_AutoServer:= TalcuServer.Instance;
   try
    f_AutoServer.Initialize;
    if not ddAppConfiguration.AsBoolean['LegalShutdown'] then
     l_Check:= alcuMsgDialog('Предыдущая сессия завершилась некорректно. Проверить базу на наличие ошибок?', mtWarning, [mbYes, mbNo], 0) = mrYes
    else
     l_Check := False;
    ddAppConfiguration.AsBoolean['LegalShutdown']:= False;
    f_AutoServer.OnStatusChanged  := SetStatus;
    f_AutoServer.OnUserListUpdated:= UserListUpdated;
    f_AutoServer.OnServerLongProc  := ServerLongProc;
    f_AutoServer.FileProc    := FileProc;
    f_AutoServer.TotalProc   := TotalProc;
    f_AutoServer.OnYeld      := YeldProc;
    f_AutoServer.CheckAtStartup := l_Check;
    f_AutoServer.MainForm := Self;
    f_AutoServer.TaskProcessor.OnTaskListChanged:= TaskListChanged;
    if f_AutoServer.Start then
     Application.OnIdle:= StartUpIdle
    else
     { Инициализация не прошла, нужно закрывать приложение }
     Application.Terminate;
   except
    on E: Exception do
    begin
     l3System.Exception2Log(E);
     alcuShowMsg(E.Message);
     if not (E is EIdOSSLCouldNotLoadSSLLibrary) then
      f_AutoServer.ExecuteConfigDialog;
     Application.Terminate;
    end;
   end;
  DoProcessMessages;
  ActiveControl:= ActiveUserList;
end;

procedure TArchiServerForm.FormDestroy(Sender: TObject);
begin
  alcuMail.OnSMTPErrorStatusChanged := nil;
  {$IfDef InsiderTest}
  if Tl3BatchService.Instance.IsBatchMode then
   ddAppConfiguration.AsBoolean['LegalShutdown'] := true;
  {$EndIf InsiderTest}
  f_AutoServer.ShutDown;
  //l3Free(f_AutoServer);
  //l3System.Str2Log(FormatDateTime(rsSessiyaostanovlenaDDMMYYYYvHhNn, Now));
end;

function TArchiServerForm.ServerLongProc(aState : TdaProcessState): Boolean;
begin
(*
  case aState of
    da_psStart  : ledWaiting.Color := lcYellow;
    da_psCurrent: ledWaiting.Color := lcYellow;
    da_psEnd    : ledWaiting.Color := lcRed;
  end; { case aState }
*)
  Result:= False;
 DoProcessMessages;
end;

procedure TArchiServerForm.itemCheckBaseClick(Sender: TObject);
begin
  { Verify }
  f_AutoServer.CheckBases(True);
end;

procedure TArchiServerForm.itemKWImportClick(Sender: TObject);
begin
  f_AutoServer.DoLoadKW;
end;

procedure TArchiServerForm.itemMakeBackupClick(Sender: TObject);
begin
  f_AutoServer.DoMakeFamilyBackUp;
end;

procedure TArchiServerForm.itemUndoBackupClick(Sender: TObject);
begin
  f_AutoServer.UndoMakeBackup(True);
end;

procedure TArchiServerForm.itemUpdateIndexClick(Sender: TObject);
begin
  f_AutoServer.DoUpdateIndex(True, True);
end;

procedure TArchiServerForm.itemUpdateTablesClick(Sender: TObject);
begin
   { Update }
  f_AutoServer.DoUpdate(True);
end;

procedure TArchiServerForm.N3Click(Sender: TObject);
begin
 if f_AutoServer.ExecuteConfigDialog then
 begin
  UpdateSchedulerMenu;
  CheckActions;
 end;
end;

procedure TArchiServerForm.RefreshButtonClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  FileProc(0, -1, 'Проверка наличия пользователей');
  try
   if UsersAndQuery.ActivePage = Users then
    UpdateUserLIst
   else
   if UsersAndQuery.ActivePage = Query then
   begin
    UpdateTaskList
   end;
  finally
   FileProc(2, 0, '');
   Screen.Cursor := crDefault;
  end;
end;

procedure TArchiServerForm.SetItemPriorityImage(aTask: TddTaskItem; aItem:
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

procedure TArchiServerForm.SetItemStatusImage(aStatus: TcsTaskStatus; aItem: TListItem);
begin
  case aStatus of
   cs_tsQuery     : aItem.SubItemImages[colStatus] := 15;
   cs_tsDone      : aItem.SubItemImages[colStatus] := 17;
   cs_tsRun,
   cs_tsAsyncRun  : aItem.SubItemImages[colStatus] := 9;//21;
   cs_tsDeleted   : aItem.SubItemImages[colStatus] := 16;
   cs_tsFrozenRun,
   cs_tsFrozen    : aItem.SubItemImages[colStatus] := 19;
   cs_tsAborting,
   cs_tsError,
   cs_tsAsyncError: aItem.SubItemImages[colStatus] := 18;
   cs_tsReadyToDelivery,
   cs_tsDelivering : aItem.SubItemImages[colStatus] := 21;
  else
   aItem.SubItemImages[colStatus] := -1;
  end; // case aStatus;
end;

procedure TArchiServerForm.SetStatus(Value: TalcuStatus{; QueryLen: Integer});
var
 QueryLen : Integer;
begin
 QueryLen := 0;
  StatusBar.Panels[0].Text:= TalcuStatusNames[Value];
  StatusBar.Panels[1].Text:= '';
  case Value of
    dd_apsIdle:
      begin
       //StatusBar.Panels[0].Text:= rsOzhidaniezadaniy;
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
    (*
    dd_apsChecking:
      begin
        StatusBar.Panels[0].Text:= rsPoiskoeredi;
        StatusBar.Panels[1].Text:= '';
      end;
    *)
    dd_apsImport:
      begin
      //  StatusBar.Panels[0].Text:= rsIdetimport;
        Caption:= rsImport + f_AutoServer.CurrentUserName + rs+ CaptionText;
      end;
    dd_apsExport:
      begin
       //StatusBar.Panels[0].Text:= rsPodgotovkaeksporta;
       Caption:= rsEksport + f_AutoServer.CurrentUserName+ rs+ CaptionText;
      end;
    dd_apsAutoClass:
     begin
       //StatusBar.Panels[0].Text:= rsPodgotovkaavtoklassifikacii;
       Caption:= rsAvtoklassifikaciya + f_AutoServer.CurrentUserName+ rs+ CaptionText;
     end;
    dd_apsFound:
      begin
        //StatusBar.Panels[0].Text:= rsPoiskoeredi;
        StatusBar.Panels[1].Text:= Format(rsnaydeno, [QueryLen]);
      end;
    (*
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
        StatusBar.Panels[0].Text:= TalcuStatusNames[Value];
        StatusBar.Panels[1].Text:= '';
      end;
    *)
  end; { case Value }
  //if Value <> dd_apsStartBaseEngine then
  // CheckActions(Value = dd_apsIdle);
  {$IFDEF TrayIcon}
  f_TrayIcon.Hint:= StatusBar.Panels[0].Text;
  {$ENDIF}
  StatusBar.Panels[2].Text:= Format(rsOered, [QueryLen]);
 DoProcessMessages;
end;

procedure TArchiServerForm.StartUpIdle(Sender: TObject; var Done: Boolean);
begin
  Application.OnIdle:= nil;
  CancelAutoImport:= False;
  (*
  ledWaiting.Visible:= True;
  ledWaiting.Lit := true;
  *)
  // Загружаем сохраненные задания
  f_AutoServer.ChecksSetup;
  UpdateTaskList;
  f_AutoServer.Actions.UpdateServerMenu(menuCommands);
  UpdateSchedulerMenu;
end;

procedure TArchiServerForm.StopAutoImport;
begin
  CancelAutoImport:= True;
end;

procedure TArchiServerForm.Task2Item(aTask: TddProcessTask; aItem: TListItem);
var
  l_UserName: ShortString;
  l_ActFlag: Byte;
  l_User: IdaArchiUser;
begin
  // aitem.Caption:= IntToStr(Succ(aTask.Index));
  aItem.ImageIndex:= GetTaskImageIndex(aTask);
  aitem.Data:= aTask;
  with aitem.SubItems do
  begin
   l_User:= GlobalDataProvider.UserManager.UserByID(aTask.UserID);
   if l_User = nil then
    l_UserName := rsInkognito
   else
    l_UserName := l_User.UserName;
   l_UserName := l_UserName + ' (' + IntToStr(aTask.UserID) + ')';
   aItem.caption:= l_UserName;// имя пользователя
   Add('');
   SetItemPriorityImage(aTask, aItem);
   Add('');
   SetItemStatusImage(aTask.Status, aItem);
   Add(FormatDateTime({rsDdMmYyHhNn}'dd/mm/yy hh:nn:ss', aTask.Date));
   Add(atask.Description);
   Add('');
   SetItemProgress(aTask, aItem);
   Add(atask.TaskID);
  end; // with item.SubItems
end;

procedure TArchiServerForm.TaskListChanged(theTask: TddProcessTask);
var
// i{, l_Index}: Integer;
 item: TListItem;
 l_Status: TcsTaskStatus;
 l_ACount: Integer;
begin
  //l_Index:= TaskListView.ItemIndex;
  l_ACount := f_AutoServer.TaskProcessor.ActiveTaskList.Count;
  Query.Caption:= Format(rsZadaniya, [l_ACount, f_AutoServer.TaskProcessor.TaskList.Count]);
  if theTask = nil then
  begin
   UpdateTaskList;
   Exit;
  end;
  item:= TaskListView.FindData(0, theTask, True, False);
  if (item = nil) then
  begin
   if not f_AutoServer.TaskProcessor.TaskList.Has(theTask) then
    Exit;
   item:= TaskListView.Items.Insert(0);
   Assert(TaskListView.Items.Count > 0);
   Task2Item(theTask, item);
  end//item = nil
  else
  begin
   SetItemPriorityImage(theTask, Item);
   SetItemStatusImage(theTask.Status, Item);
   SetItemProgress(theTask, Item);
   if Item.SubItems[colParams] <> theTask.Description then
    Item.SubItems[colParams] := theTask.Description;
   l_Status:= theTask.Status;
   actRunTask.Enabled:= (l_Status in cs_tsCanRunStatuses) and f_AutoServer.TaskEnabled[{TddProcessTask(Item.Data)}theTask.TaskID];
   actPauseTask.Enabled:= l_Status in cs_tsCanPauseStatuses;
   actDeleteTask.Enabled:= l_Status in cs_tsCanDeleteStatuses;
  end;//item = nil
  TaskListView.AlphaSort;
 DoProcessMessages;
end;

procedure TArchiServerForm.TaskListViewChange(Sender: TObject; Item: TListItem;
        Change: TItemChange);
begin
 menuPriority.Enabled:= (TaskListView.Items.Count > 0) and (TaskListView.ItemIndex <> -1);
end;

procedure TArchiServerForm.TaskListViewInfoTip(Sender: TObject;
  Item: TListItem; var InfoTip: String);
begin
 InfoTip := TddProcessTask(Item.Data).Comment;
 if TddProcessTask(Item.Data).Status in cs_tsRunningStatuses then
   InfoTip := InfoTip + #13#10 + TddProcessTask(Item.Data).RunComment;
end;

procedure TArchiServerForm.TaskListViewSelectItem(Sender: TObject; Item: TListItem;
        Selected: Boolean);
var
  l_Status: TcsTaskStatus;
  l_Priority : Integer;
begin
  if Selected then
  begin
   l_Status:= TddProcessTask(Item.Data).Status;
   l_Priority := TddProcessTask(Item.Data).Priority;
   actRunTask.Enabled:= (l_Status in cs_tsCanRunStatuses) and f_AutoServer.TaskEnabled[TddProcessTask(Item.Data).TaskID];
   actPauseTask.Enabled:= l_Status in cs_tsCanPauseStatuses;
   actDeleteTask.Enabled:= l_Status in cs_tsCanDeleteStatuses;
   actSetHighestPriority.Enabled := (l_Status in cs_tsCanChangePriotiryStatuses)
                                     and (l_Priority <> dd_tpHighest);
   actSetHighPriority.Enabled := (l_Status in cs_tsCanChangePriotiryStatuses)
                                     and (l_Priority <> dd_tpHigh);
   actSetLowestPriority.Enabled := (l_Status in cs_tsCanChangePriotiryStatuses)
                                     and (l_Priority <> dd_tpLowest);
   actSetLowPriority.Enabled := (l_Status in cs_tsCanChangePriotiryStatuses)
                                     and (l_Priority <> dd_tpLow);
   actSetNormalPriority.Enabled := (l_Status in cs_tsCanChangePriotiryStatuses)
                                     and (l_Priority <> dd_tpNormal);
  end
  else
  begin
(*
   actStopNGoQuery.Checked:= f_AutoServer.TaskEnabled[ShortString(Item.Data^)];
   actStopNGoQuery.Enabled:= l_Status in [cs_tsQuery, cs_tsFrozen];
*)
   actSetHighestPriority.Enabled := False;
   actSetHighPriority.Enabled := False;
   actSetLowestPriority.Enabled := False;
   actSetLowPriority.Enabled := False;
   actSetNormalPriority.Enabled := False;
  end;
end;

procedure TArchiServerForm.TotalProc(aState: Byte; aValue: Integer; const aMsg: string);
begin
 try
  case aState of
   0:begin
       with StatusBar.Panels[0] do
       begin
        {$IFDEF DFS}
        PanelType:= sptGauge;
        GaugeAttrs.Position:= 0;
        if avalue < 0 then
         GaugeAttrs.Style:= gsIndeterminate2
        else
         GaugeAttrs.Style:= gsPercent;
        {$ENDIF}
        Text:= aMsg;
       end;
       f_Total:= aValue;
      end;
   1:
    with StatusBar.Panels[0] do
    begin
     {$IFDEF DFS}
     PanelType:= sptGauge;
     if avalue < 0 then
      GaugeAttrs.Style:= gsIndeterminate2
     else
     begin
      GaugeAttrs.Style:= gsPercent;
      if (f_Total > 100) or (aValue > 100) then
       GaugeAttrs.Position:= Min(100, MulDiv(aValue, 100, f_Total))
      else
       GaugeAttrs.Position:= aValue;
     end;
     {$ENDIF}
     if aMsg <> '' then
      Text:= aMsg;
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
 except
  on E: Exception do
   l3System.Msg2Log('%s >> TotalProc State: %d,  Value: %d,  f_Total: %d', [E.ClassName, aState, aValue, f_Total], alcuMessageLevel);
 end;
 DoProcessMessages;
end;

procedure TArchiServerForm.UpdateTaskList;

 function DoIt(anItem: TddProcessTask): Boolean;
 var
  item: TListItem;
 begin
  Result := true;
  item := TaskListView.Items.Insert(0);
  Task2Item(anItem, Item);
 end;

var
 l_ACount : Integer;
begin
  // Запросить полный список заданий
  l_ACount := f_AutoServer.TaskProcessor.ActiveTaskList.Count;
  Query.Caption:= Format(rsZadaniya, [l_ACount, f_AutoServer.TaskProcessor.TaskList.Count]);
  TaskListView.Items.BeginUpdate;
  try
   TaskListView.Clear;
   f_AutoServer.TaskProcessor.TaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
   TaskListView.AlphaSort;
  finally
   TaskListView.Items.EndUpdate;
  end;
end;

procedure TArchiServerForm.UpdateUserLIst;
begin
  ActiveUserList.Items.Clear;
  f_AutoServer.UpdateUserList;
  listLog.Items.Clear;
  CheckActions;
  Users.Caption:= Format(rsPolzovateli, [ActiveUserList.Items.Count]);
end;

function TArchiServerForm.UserItemIndex: Integer;
begin
  Result := ActiveUserList.ItemIndex;
end;

procedure TArchiServerForm.UserListUpdated(theUser: IdaArchiUser; Active: Boolean);
var
  l_NowString: string;
begin
  DateTimeToString(l_NowString, rsDdMmmYyyyHhNn, Now);
  if Active then
  begin
    if ActiveUserList.Items.IndexOf(theUser.UserName) = -1 then
      ActiveUserList.Items.AddObject(theUser.UserName, Pointer(theUser))
    else
    begin
      ListLog.Items.Add(Format(rs1, [theUser.UserName]));
      l3System.Msg2Log('(?) <- %s', [theUser.UserName], alcuMessageLevel);
    end;
    ListLog.Items.Add(Format('%s -> %s', [l_NowString, theUser.UserName]));
    l3System.Msg2Log('-> %s', [theUser.UserName], alcuMessageLevel);
  end
  else
  begin
    ActiveUserList.Items.Delete(ActiveUserList.Items.IndexOf(theUser.UserName));
    ListLog.Items.Add(Format('%s <- %s', [l_NowString, theUser.UserName]));
    l3System.Msg2Log('<- %s', [theUser.UserName], alcuMessageLevel);
  end;
  Users.Caption:= Format(rsPolzovateli, [ActiveUserList.Items.Count]);
  actSendMessage.Enabled := ActiveUserList.Items.Count > 0;
end;

procedure TArchiServerForm.UsersAndQueryChange(Sender: TObject);
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

procedure TArchiServerForm._CloseTimer(Sender: TObject);
begin
 f_CloseTimer.Enabled := False;
 f_ManualClose := False;
 if f_AutoServer.CanCloseWithWait then
  Close
 else
  f_CloseTimer.Enabled := True;
end;

procedure TArchiServerForm.actExitExecute(Sender: TObject);
begin
 Close;
end;

procedure TArchiServerForm.actAboutExecute(Sender: TObject);
var
 l_Text: String;
begin
 {$If Defined(Region)}
 l_Text:= 'Региональная версия'#10;
 {$ELSEIF Defined(SBRF)}
 l_Text:= 'Версия для СБ РФ'#10;
 {$ELSEIF Defined(LUK)}
 l_Text:= 'Версия для ЛУКойл'#10;
 {$ELSEIF Defined(AAC)}
 l_Text:= 'Версия для обработки Постановлений Арбитражных Апелляционных судов'#10;
 {$ELSEIF Defined(SGC)}
 l_Text:= 'Версия для Стройгазконсалтинг'#10;
 {$ELSE}
 l_Text:= 'Версия для НПП Гарант-Сервис'#10;
 {$IFEND}
 l_Text:= l_Text  + FullConfigFeature + #10 + f_AutoServer.BaseDescription
 {$IFDEF Autoclass}
 + #10'Модуль автоклассификации документов'
 {$ENDIF}
 + #10'Поддержка формата NSRC+'
 ;

 ddAboutDialog(l_Text);
end;

procedure TArchiServerForm.actUpdateTextExecute(Sender: TObject);
begin
 f_AutoServer.DoUpdateIndex(True, False);
end;

procedure TArchiServerForm.actWeeklyUpdateExecute(Sender: TObject);
begin
 if f_AutoServer.DoEveryWeekUpdate(true) = drDelayed then
  alcuShowMsg('Импорт дельты не может быть запущен - выполняется другая задача');
end;

procedure TArchiServerForm.WMQueryEndSession(var Msg: TWMQueryEndSession);
var
 l_Msg: String;
begin
 f_ManualClose:= False;
 l_Msg := 'Операционная система или текущая сессия завершает свою работу.';
 alcuMail.SendEmailNotify(eventSystemShutdown, True, l_Msg, f_AutoServer.Status);
 f_AutoServer.LogoffUsers(False);
 Msg.Result:= 1;
 l3System.Msg2Log(l_Msg);
 //Windows.PostMessage(Application.MainForm.Handle, wm_Close, 0, 0);
end;

procedure TArchiServerForm.actHelpExecute(Sender: TObject);
begin
 Application.HelpCommand(HELP_FINDER, 0);
end;

procedure TArchiServerForm.actApplyDMFileExecute(Sender: TObject);
var
 l_FileName: String;
begin
 if PromptForFileName(l_FileName, 'Файлы изменений (*.dm)|*.dm|Все файлы (*.*)|*.*', '.dm',
                      'Укажите файл с изменениями словарей') then
  f_AutoServer.ApplyDictionaryModifyFile(l_FileName, True);
end;

procedure TArchiServerForm.actACInfoExecute(Sender: TObject);
var
 l_List: TStrings;
begin
  l_List:= TStringList.Create;
  try
   CollectAutoClassInfo(l_List);
   alcuMail.SendEmail(ddAppConfiguration.AsString['ac_iemail'], l_LIst.Text,'Информация о комплексе АК'{, False, 'c:\need cyr.txt'});
  finally
   l_List.Free;
  end;
end;

procedure TArchiServerForm.actAutoExportExecute(Sender: TObject);
begin
 f_AutoServer.DoAutomaticExport;
end;

procedure TArchiServerForm.actCalcCaseCodeExecute(Sender: TObject);
begin
 f_AutoServer.TaskProcessor.MakeCaseCodeGenerateTask;
end;

procedure TArchiServerForm.actCommitImgCacheExecute(Sender: TObject);
begin
 f_AutoServer.DoCommitImgCache;
end;

procedure TArchiServerForm.actExportDeltaExecute(Sender: TObject);
{$IFDEF ManualExchangeDocs}
var
 l_N: TddAppConfigNode;
 l_Item: TddVisualConfigItem;
 i: Integer;
 l_Task: TalcuRegionAutoExportTask;
{$ENDIF}
begin
 {$IFDEF ManualExchangeDocs}
 l_Item:= TddComboBoxConfigItem.Create('RegionList', 'Список потребителей', ddEmptyIntValue);
  for i:= 0 to TddSimpleListDataAdapter(ddAppConfiguration.AsObject['regDestinations']).Count-1 do
   TddComboBoxConfigItem(l_Item).AddMapValue(TddSimpleListDataAdapter(ddAppConfiguration.AsObject['regDestinations']).Values[i, 'Caption'].AsString, i);

  // Выбрать регион, задать даты, сформировать задачу
  // Неплохо было бы задавать дату компиляции автоматом
  l_N:= MakeNode('Delta', 'Экспорт дельты документов', False,
         MakeCustomItem(l_Item,  // Список регионов
         MakeDate('Текущая дата', Now,
         MakeDate('Дата компиляции', Now,
         MakeDate('Дата версии', Now,
         nil)))));
  try
   if ExecuteNodeDialog(l_N) then
   begin
    l_Task:= TalcuRegionAutoExportTask.Create(usServerService);
    try
     l_Task.RegionIndex:= l_N.Items[0].IntegerValue;
     l_Task.Description:= Format('Экспорт документов  для %s',
                     [TddSimpleListDataAdapter(ddAppConfiguration.AsObject['regDestinations']).Values[l_Task.RegionIndex, 'Caption'].AsString]);
     l_Task.Today:= l_N.Items[1].DateTimeValue;
     l_Task.CompileDate:= l_N.Items[2].DateTimeValue;
     l_Task.VersionDate:= l_N.Items[3].DateTimeValue;
     f_AutoServer.TaskProcessor.AddActiveTask(l_Task);
    finally
     l3Free(l_Task);
    end;
   end; // ExecuteNodeDialog
  finally
   FreeAndNil(l_N);
  end;
 {$ENDIF}
end;

procedure TArchiServerForm.actHavanskyExecute(Sender: TObject);
{$IFDEF HavanskyExport}
var
 l_Task: TcsExport;
{$ENDIF}
begin
 {$IFDEF HavanskyExport}
 l_Task:= TalcuHavanskyExportTask.Create;
 try
  f_AutoServer.TaskProcessor.AddActiveTask(l_Task);
 finally
  FreeAndNil(L_Task);
 end;
 {$ENDIF}
end;

procedure TArchiServerForm.actLoadAKResultsExecute(Sender: TObject);
var
 l_Folder: String;
begin
 if SelectDirectory('Укажите папку с результатами АК', ExtractFilePath(Application.ExeName), l_Folder) then
 begin
  if LoadResults(l_Folder, ExtractFileName(ddAppConfiguration.AsString['ac_FileName'])) then
   alcuShowMsg('Расстановка классов завершена')
  else
   alcuShowMsg('В указанной папке результаты АК не найдены');
 end;
end;

procedure TArchiServerForm.actManualImportAACExecute(Sender: TObject);
{$IFDEF AAC}
var
 l_Folder: String;
 l_N: TddAppConfigNode;
{$ENDIF}
begin
{$IFDEF AAC}
 l_Folder:= ddAppConfiguration.AsString['lcSourceFolder'];
 l_N:= MakeNode('Folder', 'Импорт подготовленных постановлений', True,
                MakeFolderName('Укажите папку с файлами', l_Folder));
 try
  if ExecuteNodeDialog(l_N) then
   f_AutoServer.UpdateAAC(l_N.Items[0].StringValue, True)
 finally
  FreeAndNil(l_N);
 end;
{$ENDIF}
end;

procedure TArchiServerForm.actQueryCalculatorExecute(Sender: TObject);
var
 l_N: TddAppConfigNode;
 l_I: TddCheckListConfigItem;
 l_QList: TQueryList; 
 i: Integer;
 l_Caption: String;
 l_Q: TdtOrQuery;
 l_SQ: TdtQuery;
 l_Selected: Integer;
begin
 l_QList:= TQueryList.make;
 try
  l_QList.QueriesPath:= ddAppConfiguration.AsString['sqFolder'];
  l_QLIst.LoadAsksList;
  l_N:= TddAppConfigNode.Create('QueryCalc', 'Калькулятор запросов');
  try
   l_N.AddItem(TddStringConfigItem.Make('Caption', 'Новый запрос'));
   l_I:= TddCheckListConfigItem.Create('QueryList', 'Сложением запросов', ddEmptyIntValue);
   for i:= 0 to l_QList.Hi do
    l_I.Add(l_QList[i].Name);
   l_N.AddItem(l_I);
   if ExecuteNodeDialog(l_N) then
   begin
    l_Q:= TdtOrQuery.Create();
    try
     l_Selected:= l_N.AsInteger['QueryList'];
     l_Caption:= '';
     for i:= 0 to l_QList.Hi do
     begin
      if l3TestBit(l_Selected, i) then
      begin
       if l_Caption <> '' then
        l_Caption:= l_Caption + ', ';
       l_Caption:= l_Caption + l_QList[i].Name;
       l_SQ:= l_QList[i].MakeQuery;
       try
        l_Q.AddQuery(l_SQ);
       finally
        FreeAndNil(l_SQ);
       end; // try..finally
      end; // l3TestBit(l_Selected, i)
     end; // for i
     l_QList.SaveQuery(IfThen(L_N.AsString['Caption']  = '', l_Caption, L_N.AsString['Caption']), l_Q);
    finally
     FreeAndNil(l_Q);
    end;
   end;
  finally
   FreeAndNil(l_N);
  end;
 finally
  FreeAndNil(l_QList);
 end;
end;

procedure TArchiServerForm.actRestartExecute(Sender: TObject);
begin
 l3System.Msg2Log('Перезапуск приложения');
 ddAppConfiguration.AsBoolean['LegalShutdown']:= True;
 l3System.ShowObjectsWindow:= False;
 RestartApplication('/restart');
end;

procedure TArchiServerForm.actSet20005subExecute(Sender: TObject);
{$IFDEF ManualSet20005Sub}
var
{$IFDEF AAC}
 l_FileName: String;
{$ENDIF}
 l_Params: TcsCourtDecisionSabCheckerParams;
{$ENDIF ManualSet20005Sub}
begin
 {$IFDEF ManualSet20005Sub}
 l_Params := MakeCourtDecisionSabCheckerParams;
 try
 {$IFDEF AAC}
  l_FileName:= '';
  if PromptForFileName(l_FileName, 'Файлы списка (*.lst)|*.lst|Все файлы (*.*)|*.*', '*.lst', 'Выберите файл со списком докумнтов') then
   TalcuCourtDecisionSubChecker.CheckInList(l_Params, l_FileName)
  else
  {$ENDIF AAC}
  if IsPositiveResult(alcuMsgDialog('Вы уверены, что хотите начать расстановку меток?', mtConfirmation, [mbYes, mbNo], 0)) then
  begin
   f_AutoServer.TaskProcessor.LockProcessing;
   try
    f_AutoServer.DisableProcessing;
    try
     TalcuCourtDecisionSubChecker.CheckByDate(l_Params);
     {$IFNDEF Region}
     ddAppConfiguration.AsDateTime['CD_FromDate']:= l_Params.LastUpdateDate;
     ddAppConfiguration.Save;
     {$ENDIF Region}
    finally
     f_AutoServer.EnableProcessing;
    end;
   finally
    f_AutoServer.TaskProcessor.UnLockProcessing;
   end;
  end;
 finally
  FreeAndNil(l_Params);
 end;
{$ENDIF ManualSet20005Sub}
end;

procedure TArchiServerForm.CoolTrayIcon1DblClick(Sender: TObject);
begin
 {$IFDEF TrayIcon}
 f_TrayIcon.ShowMainForm;
 f_TrayIcon.IconVisible:= False;
 {$ENDIF}
end;

procedure TArchiServerForm.CoolTrayIcon1MinimizeToTray(Sender: TObject);
begin
 {$IFDEF TrayIcon}
  f_TrayIcon.IconVisible:= True;
 {$ENDIF}
end;

procedure TArchiServerForm.CreateTrayIcon;
begin
{$IFDEF TrayIcon}
 f_TrayIcon:= TCoolTrayIcon.Create(Self);
 with f_TrayIcon do
 begin
  Icon:= Application.Icon;
  MinimizeToTray:= True;
  OnDblClick:= CoolTrayIcon1DblClick;
  OnMinimizeToTray:= CoolTrayIcon1MinimizeToTray;
 end;
{$ENDIF}
end;

procedure TArchiServerForm.YeldProc(Sender: TObject);
begin
 DoProcessMessages;
end;

procedure TArchiServerForm.SetItemProgress(aTask: TddProcessTask;
  aItem: TListItem);
begin
  if aTask.Status in cs_tsStatusesWithProgress then
   aItem.SubItems[colProgress] := IntToStr(aTask.RunProgress)
  else
   aItem.SubItems[colProgress] := '';
end;

procedure TArchiServerForm.actCopyVariablePartToBackupExecute(
  Sender: TObject);
begin
 if f_AutoServer.CopyVersionToBackup = strRequestDelay then
  alcuShowMsg('Копирование версии не может быть запущено - выполняется другая задача');
end;

procedure TArchiServerForm.actCopyVariablePartFromBackupExecute(
  Sender: TObject);
begin
 if f_AutoServer.CopyBackupToVersion = strRequestDelay then
  alcuShowMsg('Копирование версии не может быть запущено - выполняется другая задача');
end;

procedure TArchiServerForm.pm_SetCompareKind(
  const Value: TcsTaskCompareKind);
begin
 if f_CompareKind <> Value then
 begin
  f_CompareKind := Value;
  TaskListView.AlphaSort;
 end;
end;

procedure TArchiServerForm.TaskListViewCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
 l_Task1, l_Task2: TddProcessTask;
begin
 l_Task1 := TObject(Item1.Data) As TddProcessTask;
 l_Task2 := TObject(Item2.Data) As TddProcessTask;
 Compare := CompareTaskByKind(CompareKind, l_Task1, Item1.Caption, l_Task2, Item2.Caption);
end;

procedure TArchiServerForm.actSortByPriorityExecute(Sender: TObject);
begin
 CompareKind := cs_tckByPriority;
end;

procedure TArchiServerForm.actSortByStatusExecute(Sender: TObject);
begin
 CompareKind := cs_tckByStatus;
end;

procedure TArchiServerForm.actSortByUserExecute(Sender: TObject);
begin
 CompareKind := cs_tckByUser;
end;

procedure TArchiServerForm.actSortByDateExecute(Sender: TObject);
begin
 CompareKind := cs_tckByDate;
end;

procedure TArchiServerForm.DoProcessMessages;
begin
 If not GetCurrentThreadID = MainThreadID then
  l3System.Stack2Log('WARNING - ProcessMessages in secodary thread');
// afw.ProcessMessages;
 Application.ProcessMessages;
end;

procedure TArchiServerForm.DoSmtpStatusChanged(Sender: TObject);
begin
 if not GetCurrentThreadID = MainThreadID then
  UpdateSMTPStatus
 else
  PostMessage(Handle, msg_UpdateStatus, 0, 0);
end;

procedure TArchiServerForm.UpdateSMTPStatus;
begin
 if alcuMail.SMTPHasError then
  lblSMTPStatus.Caption := Format('Проблемы с почтой: %s', [alcuMail.SMTPStatusErrorMessage])
 else
  lblSMTPStatus.Caption := '';
 lblSMTPStatus.Visible := alcuMail.SMTPHasError;
end;

procedure TArchiServerForm.lblSMTPStatusClick(Sender: TObject);
begin
 alcuMail.CheckUnsendedMail;
end;

procedure TArchiServerForm.WndProc(var Message: TMessage);
begin
  if Message.Msg = msg_UpdateStatus then
   UpdateSMTPStatus
  else
   inherited;
end;

procedure TArchiServerForm.menuDelOldTasksClick(Sender: TObject);
begin
 f_AutoServer.ReportMemoryUsage;
 l3System.Msg2Log('Packing tasklist');
 f_AutoServer.TaskProcessor.TaskList.PackUnimportant(0);
 UpdateTaskList;
 f_AutoServer.ReportMemoryUsage;
 l3System.Msg2Log('Compacting Heap');
 HeapCompact(GetProcessHeap, 0);
 f_AutoServer.ReportMemoryUsage;
end;

procedure TArchiServerForm.UpdateSchedulerMenu;
var
 l_MenuItem: TMenuItem;
 l_IDX: Integer;
begin
 menuScheduler.Clear;
 for l_IDX := 0 to f_AutoServer.Scheduler.Count - 1 do
  if not f_AutoServer.Scheduler.Tasks[l_IDX].Deleted then
  begin
   l_MenuItem := TMenuItem.Create(Application);
   l_MenuItem.Tag := f_AutoServer.Scheduler.Tasks[l_IDX].UID;
   l_MenuItem.Caption := Format('%s: %s', [ddCalendarEventArray[f_AutoServer.Scheduler.Tasks[l_IDX].TaskType].Caption, f_AutoServer.Scheduler.Tasks[l_IDX].Caption]);
   l_MenuItem.OnClick := ExecuteSchedulrTask;
   menuScheduler.Add(l_MenuItem);
  end;
end;

procedure TArchiServerForm.ExecuteSchedulrTask(Sender: TObject);
begin
 if f_AutoServer.Scheduler.ScheduleEnabled then
  f_AutoServer.Scheduler.ManualExecuteTask(f_AutoServer.Scheduler.GetTaskByUID((Sender as TMenuItem).Tag));
end;

procedure TArchiServerForm.actStopNGoResetAllExecute(Sender: TObject);
begin
 f_AutoServer.TaskProcessor.EnabledTaskTypes := alcuAllTaskTypes;
end;

procedure TArchiServerForm.actSchedulerDumpExecute(Sender: TObject);
var
 l_Str: String;
 l_IDX: Integer;
 l_Now: TDateTime;

 procedure lp_ProcessTask(aTask: TddSchedulerTask);
 begin
  l_Str := Format('%s %s: %s', [l_Str, ddCalendarEventArray[aTask.TaskType].Caption, aTask.Caption]);
  if aTask.Deleted then
   l_Str := l_Str + ' DELETED';
  l_Str := l_Str + #13#10;
  l_Str := Format('%s   %s'#13#10, [l_Str, GetEnumName(TypeInfo(TddSchedulerTaskPeriodicity), Ord(aTask.Periodicity))]);
  l_Str := Format('%s   Date = %s'#13#10, [l_Str, FormatDateTime('dd/mm/yyyy hh:nn:ss', aTask.TaskDate)]);
  l_Str := Format('%s   Time = %s'#13#10, [l_Str, FormatDateTime('dd/mm/yyyy hh:nn:ss', aTask.TaskTime)]);
  l_Str := Format('%s   NetRun = %s'#13#10, [l_Str, FormatDateTime('dd/mm/yyyy hh:nn:ss', aTask.FullDateTime[l_Now])]);
 end;

begin
  l_Now := Now;
  l_Str := '';
  for l_IDX := 0 to f_AutoServer.Scheduler.Count - 1 do
   lp_ProcessTask(f_AutoServer.Scheduler.Tasks[l_IDX]);
  vtShowMemoBox('Scheduler dump', l_Str);
end;

procedure TArchiServerForm.actTasksDumpExecute(Sender: TObject);

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := True;
  l3System.Msg2Log('TASK - %s (%s) %s', [anItem.TaskID, anItem.Description, GetEnumName(TypeInfo(TcsTaskStatus), Ord(anItem.Status))]);
 end;

begin
 l3System.Stack2Log('CRASH DUMP');
 f_AutoServer.TaskProcessor.ActiveTaskList.ForEachF(L2alcuTasksIteratorForEachFAction(@DoIt));
end;

initialization
 msg_UpdateStatus := RegisterWindowMessage(PChar(l3CreateStringGUID));

end.

