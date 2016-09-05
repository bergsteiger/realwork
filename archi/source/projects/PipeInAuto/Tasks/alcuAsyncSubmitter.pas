unit alcuAsyncSubmitter;
 {* Асинхронно посылает с сервера запросы на выполнение утилите. }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuAsyncSubmitter.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "alcuAsyncSubmitter" MUID: (53C900CA012E)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
uses
 l3IntfUses
 , l3Base
 , l3ProtoObject
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 , daTypes
 , alcuServerAsyncExecutionInterfaces
 , alcuAsyncTaskFinishedNotifierList
;

type
 PalcuSubmitterWorkThread = ^TalcuSubmitterWorkThread;

 TalcuWorkThreadContainer = class(Tl3ThreadContainer)
  private
   f_TaskFileName: AnsiString;
   f_ServerHostName: AnsiString;
   f_UserName: AnsiString;
   f_Password: AnsiString;
   f_ServerPort: Integer;
   f_ExitCode: Cardinal;
    {* Чем процесс завершился }
  protected
   procedure SubmitTask(const aTaskFile: AnsiString);
   procedure DoExecute; override;
    {* основная процедура нити. Для перекрытия в потомках }
  public
   constructor Create(const anHostName: AnsiString;
    aPort: Integer;
    const aUserName: AnsiString;
    const aPassword: AnsiString); reintroduce;
   class function AssistantFileName: AnsiString;
  public
   property ExitCode: Cardinal
    read f_ExitCode;
    {* Чем процесс завершился }
 end;//TalcuWorkThreadContainer

 TalcuSubmitterWorkThread = class(Tl3ProtoObject{$If NOT Defined(Nemesis)}
 , IcsExternalTaskAbortProcessor
 {$IfEnd} // NOT Defined(Nemesis)
 )
  private
   f_Thread: TalcuWorkThreadContainer;
   f_FinishNotifierList: TalcuAsyncTaskFinishedNotifierList;
   f_TaskFileName: AnsiString;
   f_SubmitGuard: Integer;
   f_CheckExecutionGuard: Integer;
   f_UserID: TdaUserID;
   f_ActiveTask: TddProcessTask;
   f_Manager: IalcuAsyncSubmitterManager;
   f_Active: Boolean;
    {* Можно ли отцеплять утилиту }
  private
   procedure NotifySubscribers;
  protected
   {$If NOT Defined(Nemesis)}
   function ProcessAbort(const aTask: TddProcessTask): Boolean;
    {* Если успешно абортировала задачу вернет True. Тогда штатная обработка обключается }
   {$IfEnd} // NOT Defined(Nemesis)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(aUserID: TdaUserID;
    const aManager: IalcuAsyncSubmitterManager); reintroduce;
   function SubmitTask(const aTask: TddProcessTask): Boolean;
   procedure CheckExecution(const aServices: IcsRunTaskServices);
    {* Проверить что процесс завершился и освободиться по необходимости }
   procedure RegisterNotifier(const aNotifier: IalcuAsyncTaskFinishedNotifier);
   procedure UnRegisterNotifier(const aNotifier: IalcuAsyncTaskFinishedNotifier);
   class function AssistantExists: Boolean;
   function StillRunning(CountAbortingTask: Boolean): Boolean;
  protected
   property UserID: TdaUserID
    read f_UserID;
   property ActiveTask: TddProcessTask
    read f_ActiveTask;
   property Manager: IalcuAsyncSubmitterManager
    read f_Manager;
  public
   property Active: Boolean
    read f_Active
    write f_Active;
    {* Можно ли отцеплять утилиту }
 end;//TalcuSubmitterWorkThread
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

implementation

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
uses
 l3ImplUses
 , Windows
 , SysUtils
 , l3Base64
 {$If NOT Defined(Nemesis)}
 , csTaskTypes
 {$IfEnd} // NOT Defined(Nemesis)
 , Classes
 , l3Stream
 , l3Types
 , l3FileUtils
 , l3Interlocked
 //#UC START# *53C900CA012Eimpl_uses*
 //#UC END# *53C900CA012Eimpl_uses*
;

constructor TalcuWorkThreadContainer.Create(const anHostName: AnsiString;
 aPort: Integer;
 const aUserName: AnsiString;
 const aPassword: AnsiString);
//#UC START# *53CCF6F70264_53C9011903D6_var*
//#UC END# *53CCF6F70264_53C9011903D6_var*
begin
//#UC START# *53CCF6F70264_53C9011903D6_impl*
 inherited Create;
 f_ServerHostName := anHostName;
 f_UserName := aUserName;
 f_Password := aPassword;
 f_ServerPort := aPort;
 f_ExitCode := cs_arsSuccess;
//#UC END# *53CCF6F70264_53C9011903D6_impl*
end;//TalcuWorkThreadContainer.Create

procedure TalcuWorkThreadContainer.SubmitTask(const aTaskFile: AnsiString);
//#UC START# *53C917C30155_53C9011903D6_var*
//#UC END# *53C917C30155_53C9011903D6_var*
begin
//#UC START# *53C917C30155_53C9011903D6_impl*
  Assert(Suspended);
  f_TaskFileName := aTaskFile;
  Suspended := False;
//#UC END# *53C917C30155_53C9011903D6_impl*
end;//TalcuWorkThreadContainer.SubmitTask

class function TalcuWorkThreadContainer.AssistantFileName: AnsiString;
//#UC START# *540475CA0270_53C9011903D6_var*
//#UC END# *540475CA0270_53C9011903D6_var*
begin
//#UC START# *540475CA0270_53C9011903D6_impl*
 Result := Format('%salcuTaskExecutor.exe', [ExtractFilePath(ParamStr(0))]);
//#UC END# *540475CA0270_53C9011903D6_impl*
end;//TalcuWorkThreadContainer.AssistantFileName

procedure TalcuWorkThreadContainer.DoExecute;
 {* основная процедура нити. Для перекрытия в потомках }
//#UC START# *4911B69E037D_53C9011903D6_var*
var
  l_StartupInfo: TStartupInfo;
  l_ProcessInfo: TProcessInformation;
  l_ExeFile: String;
//#UC END# *4911B69E037D_53C9011903D6_var*
begin
//#UC START# *4911B69E037D_53C9011903D6_impl*
  f_ExitCode := cs_arsSuccess;
  l3FillChar(l_StartupInfo, SizeOf(l_StartupInfo));
  l_StartupInfo.cb := SizeOf(l_StartupInfo);
  l_StartupInfo.wShowWindow := SW_SHOW;
  l_ExeFile := Format('"%s" "%s" "%s" %d %s %s',
    [AssistantFileName,
     f_TaskFileName,
     f_ServerHostName,
     f_ServerPort,
     l3EncodeBase64(f_UserName),
     l3EncodeBase64(f_Password)]);
  if CreateProcess(nil,
                   PAnsiChar(l_ExeFile),
                   nil,
                   nil,
                   TRUE,
                   NORMAL_PRIORITY_CLASS,
                   nil,
                   nil,
                   l_StartupInfo,
                   l_ProcessInfo) then
  begin
    CloseHandle(l_ProcessInfo.hThread);
    WaitForSingleObject(l_ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(l_ProcessInfo.hProcess, f_ExitCode);
    CloseHandle(l_ProcessInfo.hProcess);
  end
  else
  begin
    f_ExitCode := cs_arsUtilityNotFound;
  end;
//#UC END# *4911B69E037D_53C9011903D6_impl*
end;//TalcuWorkThreadContainer.DoExecute

constructor TalcuSubmitterWorkThread.Create(aUserID: TdaUserID;
 const aManager: IalcuAsyncSubmitterManager);
//#UC START# *53CCF726039A_53C92B390005_var*
var
  l_UserName: AnsiString;
  l_Password: AnsiString;
//#UC END# *53CCF726039A_53C92B390005_var*
begin
//#UC START# *53CCF726039A_53C92B390005_impl*
 inherited Create;
 f_UserID := aUserID;
 Assert(Assigned(aManager));
 f_Manager := aManager;
 f_Manager.GetUserAccountByID(f_UserID, l_UserName, l_Password);
 f_Thread := TalcuWorkThreadContainer.Create(Manager.ServerHostName, Manager.ServerPort,
   l_UserName, l_Password);
 f_FinishNotifierList := TalcuAsyncTaskFinishedNotifierList.Make;
 f_Active := True;
//#UC END# *53CCF726039A_53C92B390005_impl*
end;//TalcuSubmitterWorkThread.Create

function TalcuSubmitterWorkThread.SubmitTask(const aTask: TddProcessTask): Boolean;
//#UC START# *53CCF77201EF_53C92B390005_var*
var
  l_Stream: TStream;
  l_ExportDir: String;
//#UC END# *53CCF77201EF_53C92B390005_var*
begin
//#UC START# *53CCF77201EF_53C92B390005_impl*
 l3InterlockedIncrement(f_SubmitGuard);
 try
  Result := (f_SubmitGuard = 1) and Active and Assigned(aTask) and (f_ActiveTask = nil) and not f_Manager.IsUserLogined(f_UserID);
  if Result then
  begin
   if (aTask.Status = cs_tsAsyncRun) then
     Exit;
   if Manager.EnterTaskExecution(aTask) then
   begin
     aTask.SetRefTo(f_ActiveTask);
     {$If not defined(Nemesis)}
     f_ActiveTask.RegisterAbortProcessor(Self);
     {$IfEnd not defined(Nemesis)}
     f_ActiveTask.RequestAsyncRun;
     f_TaskFileName := ChangeFileExt(l3GetTempFileName('alcuAssistant'), '.tsk');
     l_Stream := Tl3FileStream.Create(f_TaskFileName, l3_fmCreateReadWrite);
     try
      ActiveTask.SaveToEvd(l_Stream, nil{True});
     finally
      FreeAndNil(l_Stream);
     end;
     ActiveTask.RequestAsyncRun;
     f_Thread.SubmitTask(f_TaskFileName);
   end
   else
     Result := False;
  end;//Result
 finally
  l3InterlockedDecrement(f_SubmitGuard);
 end;
//#UC END# *53CCF77201EF_53C92B390005_impl*
end;//TalcuSubmitterWorkThread.SubmitTask

procedure TalcuSubmitterWorkThread.CheckExecution(const aServices: IcsRunTaskServices);
 {* Проверить что процесс завершился и освободиться по необходимости }
//#UC START# *53CDF9B0012E_53C92B390005_var*

 function lp_ErrorMessage: String;
 begin
  Result := Format('Ошибка. Exit code = %d. %s. См. лог alcuTaskExecutor.', [f_Thread.ExitCode, f_ActiveTask.TaskID]);
 end;

//#UC END# *53CDF9B0012E_53C92B390005_var*
begin
//#UC START# *53CDF9B0012E_53C92B390005_impl*
  if (f_CheckExecutionGuard = 0) and (f_SubmitGuard = 0) and Assigned(f_ActiveTask) and (f_ActiveTask.Status in [cs_tsAsyncRun, cs_tsFrozen, cs_tsFrozenRun, cs_tsDeleted, cs_tsAborting]) then
  begin
   l3InterlockedIncrement(f_CheckExecutionGuard);
   try
    if f_Thread.Suspended and (f_CheckExecutionGuard = 1) then
    begin
      case f_Thread.ExitCode of
        cs_arsSuccess: f_ActiveTask.RunSuccessfullyFinished(aServices);
        cs_arsAborted: f_ActiveTask.AsyncErrorIfRunning('Операция прервана');
        cs_arsUtilityNotFound: f_ActiveTask.AsyncErrorIfRunning('Не удалось запустить утилиту');
        cs_arsTaskUnregistered: f_ActiveTask.AsyncErrorIfRunning('Задача не заргестрирована для асинхронного выполнения');
      else
      begin
        if f_ActiveTask.IgnoreStrangeExitCode and ((f_Thread.ExitCode < 0) or (f_Thread.ExitCode > 100)) then
        begin
         f_ActiveTask.RunSuccessfullyFinished(aServices);
         l3System.Msg2Log(lp_ErrorMessage);
        end
        else
         f_ActiveTask.AsyncErrorIfRunning(lp_ErrorMessage);
      end;
      end;
      {$If not defined(Nemesis)}
      f_ActiveTask.UnRegisterAbortProcessor(Self);
      {$IfEnd not defined(Nemesis)}
      Manager.LeaveTaskExecution(ActiveTask);
      NotifySubscribers;
      f_ActiveTask.RunEnded(aServices);
      FreeAndNil(f_ActiveTask);
      DeleteFile(f_TaskFileName);
    end;
   finally
    l3InterlockedDecrement(f_CheckExecutionGuard);
   end;
  end;
//#UC END# *53CDF9B0012E_53C92B390005_impl*
end;//TalcuSubmitterWorkThread.CheckExecution

procedure TalcuSubmitterWorkThread.RegisterNotifier(const aNotifier: IalcuAsyncTaskFinishedNotifier);
//#UC START# *53D0E880001E_53C92B390005_var*
//#UC END# *53D0E880001E_53C92B390005_var*
begin
//#UC START# *53D0E880001E_53C92B390005_impl*
 f_FinishNotifierList.Add(aNotifier);
//#UC END# *53D0E880001E_53C92B390005_impl*
end;//TalcuSubmitterWorkThread.RegisterNotifier

procedure TalcuSubmitterWorkThread.UnRegisterNotifier(const aNotifier: IalcuAsyncTaskFinishedNotifier);
//#UC START# *53D0E88D0368_53C92B390005_var*
//#UC END# *53D0E88D0368_53C92B390005_var*
begin
//#UC START# *53D0E88D0368_53C92B390005_impl*
 f_FinishNotifierList.Remove(aNotifier);
//#UC END# *53D0E88D0368_53C92B390005_impl*
end;//TalcuSubmitterWorkThread.UnRegisterNotifier

procedure TalcuSubmitterWorkThread.NotifySubscribers;
//#UC START# *53D0E89C0113_53C92B390005_var*

 function DoIt(aNotifier: PalcuAsyncTaskFinishedNotifier; Index: Long): Bool;
 begin
   aNotifier.TaskFinished(f_ActiveTask);
   Result := True;
 end;

//#UC END# *53D0E89C0113_53C92B390005_var*
begin
//#UC START# *53D0E89C0113_53C92B390005_impl*
 if Assigned(f_ActiveTask) then
   f_FinishNotifierList.IterateAllF(l3L2IA(@DoIt))
//#UC END# *53D0E89C0113_53C92B390005_impl*
end;//TalcuSubmitterWorkThread.NotifySubscribers

class function TalcuSubmitterWorkThread.AssistantExists: Boolean;
//#UC START# *5404732A00CC_53C92B390005_var*
//#UC END# *5404732A00CC_53C92B390005_var*
begin
//#UC START# *5404732A00CC_53C92B390005_impl*
 Result := FileExists(TalcuWorkThreadContainer.AssistantFileName);
//#UC END# *5404732A00CC_53C92B390005_impl*
end;//TalcuSubmitterWorkThread.AssistantExists

function TalcuSubmitterWorkThread.StillRunning(CountAbortingTask: Boolean): Boolean;
//#UC START# *573EC2C80226_53C92B390005_var*
const
 cSet = [cs_tsAsyncRun, cs_tsFrozenRun, cs_tsDeleted];
//#UC END# *573EC2C80226_53C92B390005_var*
begin
//#UC START# *573EC2C80226_53C92B390005_impl*
 if CountAbortingTask then
  Result := Assigned(f_ActiveTask) and (ActiveTask.Status in (cSet + [cs_tsAborting]))
 else
  Result := Assigned(f_ActiveTask) and (ActiveTask.Status in cSet)
//#UC END# *573EC2C80226_53C92B390005_impl*
end;//TalcuSubmitterWorkThread.StillRunning

{$If NOT Defined(Nemesis)}
function TalcuSubmitterWorkThread.ProcessAbort(const aTask: TddProcessTask): Boolean;
 {* Если успешно абортировала задачу вернет True. Тогда штатная обработка обключается }
//#UC START# *53CF5E600196_53C92B390005_var*
//#UC END# *53CF5E600196_53C92B390005_var*
begin
//#UC START# *53CF5E600196_53C92B390005_impl*
  Manager.SendAbortNotification(f_UserID);
//#UC END# *53CF5E600196_53C92B390005_impl*
end;//TalcuSubmitterWorkThread.ProcessAbort
{$IfEnd} // NOT Defined(Nemesis)

procedure TalcuSubmitterWorkThread.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53C92B390005_var*
//#UC END# *479731C50290_53C92B390005_var*
begin
//#UC START# *479731C50290_53C92B390005_impl*
 FreeAndNil(f_Thread);
 FreeAndNil(f_ActiveTask);
 f_Manager := nil;
 FreeAndNil(f_FinishNotifierList);
 inherited Cleanup;
//#UC END# *479731C50290_53C92B390005_impl*
end;//TalcuSubmitterWorkThread.Cleanup

procedure TalcuSubmitterWorkThread.ClearFields;
begin
 f_Manager := nil;
 inherited;
end;//TalcuSubmitterWorkThread.ClearFields
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

end.
