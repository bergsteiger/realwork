unit alcuSubmitterWorkPool;
 {* Коллекция служебно-рабочих пользователей }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuSubmitterWorkPool.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
uses
 l3IntfUses
 , l3ProtoObject
 , alcuServerAsyncExecutionInterfaces
 , alcuSubmitterWorkThreadList
 , alcuAsyncTaskFinishedNotifierList
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuSubmitterWorkPool = class(Tl3ProtoObject, IalcuAsyncTaskFinishedNotifier)
  {* Коллекция служебно-рабочих пользователей }
  private
   f_LockSubmitTaskCounter: Integer;
   f_List: TalcuSubmitterWorkThreadList;
   f_FinishNotifierList: TalcuAsyncTaskFinishedNotifierList;
   f_SubmitGuard: Integer;
   f_HasWorkThreads: Boolean;
    {* Поле для свойства HasWorkThreads }
   f_WorkThreadCount: integer;
    {* Поле для свойства WorkThreadCount }
   f_Manager: IalcuAsyncSubmitterManager;
    {* Поле для свойства Manager }
  private
   procedure NotifySubscribers(const aTask: TddProcessTask);
  protected
   procedure pm_SetWorkThreadCount(aValue: integer);
   procedure TaskFinished(const aTask: TddProcessTask);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aManager: IalcuAsyncSubmitterManager); reintroduce;
   function SubmitTask(const aTask: TddProcessTask): Boolean;
   procedure CheckExecution(const aServices: IcsRunTaskServices);
   function HasRunningTask(const aServices: IcsRunTaskServices): Boolean;
   procedure RegisterNotifier(const aNotifier: IalcuAsyncTaskFinishedNotifier);
   procedure UnRegisterNotifier(const aNotifier: IalcuAsyncTaskFinishedNotifier);
   function AllowSubmitTask: Boolean;
   procedure LockSubmitTask;
   procedure UnLockSubmitTask;
  protected
   property Manager: IalcuAsyncSubmitterManager
    read f_Manager;
  public
   property HasWorkThreads: Boolean
    read f_HasWorkThreads;
   property WorkThreadCount: integer
    read f_WorkThreadCount
    write pm_SetWorkThreadCount;
 end;//TalcuSubmitterWorkPool
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

implementation

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
uses
 l3ImplUses
 , alcuAsyncSubmitter
 , l3Types
 , l3Base
 , Windows
 {$If NOT Defined(Nemesis)}
 , dt_User
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 , daInterfaces
 {$If NOT Defined(Nemesis)}
 , csTaskTypes
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Interlocked
;

procedure TalcuSubmitterWorkPool.pm_SetWorkThreadCount(aValue: integer);
//#UC START# *5416C3670067_53CDF9FE006Bset_var*

 function DoDeactivate(aThread: PalcuSubmitterWorkThread; Index: Long): Bool;
 begin
   Result := True;
   aThread.Active := False;
 end;

var
  l_IDX: Integer;
  l_UserIDX: Cardinal;
  l_NeedRefillUserList: Boolean;
  l_Thread: TalcuSubmitterWorkThread;
//#UC END# *5416C3670067_53CDF9FE006Bset_var*
begin
//#UC START# *5416C3670067_53CDF9FE006Bset_impl*

 if not TalcuSubmitterWorkThread.AssistantExists then
 begin
  l3System.Msg2Log('Утилита alcuTaskExecutor.exe не найдена. Асинхронное выполнение задач отключено.');
  aValue := 0;
 end;
 if aValue <> f_WorkThreadCount then
 begin
  f_WorkThreadCount := aValue;
  f_HasWorkThreads := WorkThreadCount > 0;
  f_List.IterateAllF(l3L2IA(@DoDeactivate));

  l_NeedRefillUserList := False;
  for l_UserIDX := usFirstWorkUser downto usFirstWorkUser - (WorkThreadCount - 1) do
  begin
   if not UserManager.IsUserExists(l_UserIDX) then
   begin
    UserManager.AddUserID(l_UserIDX, Format('Служебный пользователь %d', [usFirstWorkUser - l_UserIDX + 1]), Format('%s%.8x', [Chr(3), l_UserIDX]), '', 1);
    l_NeedRefillUserList := True;
   end;
  end;
  if l_NeedRefillUserList then
   UserManager.MakeFullUsersList;

  l_UserIDX := usFirstWorkUser;
  for l_IDX := 0 to WorkThreadCount - 1 do
  begin
   if l_IDX < f_List.Count then
    f_List.Items[l_IDX].Active := True
   else
   begin
    l_Thread := TalcuSubmitterWorkThread.Create(l_UserIDX, Manager);
    try
     l_Thread.RegisterNotifier(Self);
     f_List.Add(l_Thread);
    finally
     FreeAndNil(l_Thread);
    end;
   end;
   Dec(l_UserIDX);
  end;

  if HasWorkThreads then
   l3System.Msg2Log('Асинхронное выполнение задач включено (%d утилит).', [WorkThreadCount])
  else
   l3System.Msg2Log('Асинхронное выполнение задач отключено.');
 end;
//#UC END# *5416C3670067_53CDF9FE006Bset_impl*
end;//TalcuSubmitterWorkPool.pm_SetWorkThreadCount

constructor TalcuSubmitterWorkPool.Create(const aManager: IalcuAsyncSubmitterManager);
//#UC START# *53CDFAF10205_53CDF9FE006B_var*
//#UC END# *53CDFAF10205_53CDF9FE006B_var*
begin
//#UC START# *53CDFAF10205_53CDF9FE006B_impl*
 inherited Create;
 f_List := TalcuSubmitterWorkThreadList.Make;
 f_Manager := aManager;
 f_FinishNotifierList := TalcuAsyncTaskFinishedNotifierList.Make;
//#UC END# *53CDFAF10205_53CDF9FE006B_impl*
end;//TalcuSubmitterWorkPool.Create

procedure TalcuSubmitterWorkPool.NotifySubscribers(const aTask: TddProcessTask);
//#UC START# *53D0E7D8019F_53CDF9FE006B_var*
 function DoIt(aNotifier: PalcuAsyncTaskFinishedNotifier; Index: Long): Bool;
 begin
   aNotifier.TaskFinished(aTask);
   Result := True;
 end;
//#UC END# *53D0E7D8019F_53CDF9FE006B_var*
begin
//#UC START# *53D0E7D8019F_53CDF9FE006B_impl*
 f_FinishNotifierList.IterateAllF(l3L2IA(@DoIt))
//#UC END# *53D0E7D8019F_53CDF9FE006B_impl*
end;//TalcuSubmitterWorkPool.NotifySubscribers

function TalcuSubmitterWorkPool.SubmitTask(const aTask: TddProcessTask): Boolean;
//#UC START# *53CDFABD0075_53CDF9FE006B_var*
var
 l_Result: Boolean;

 function DoIt(aThread: PalcuSubmitterWorkThread; Index: Long): Bool;
 begin
   l_Result := aThread.SubmitTask(aTask);
   Result := not l_Result;
 end;

//#UC END# *53CDFABD0075_53CDF9FE006B_var*
begin
//#UC START# *53CDFABD0075_53CDF9FE006B_impl*
 l3InterlockedIncrement(f_SubmitGuard);
 try
  if aTask.Status = cs_tsAsyncRun then
  begin
   Result := True;
   Exit;
  end;
  if f_SubmitGuard <> 1 then
  begin
   Result := False;
   Exit;
  end;
  l_Result := False;
  if aTask.Status <> cs_tsQuery then
   l3System.Msg2Log('ALERT! В очередь ставиться задача %s с неподходящим статусом', [aTask.Description]);
  if AllowSubmitTask then
   f_List.IterateAllF(l3L2IA(@DoIt));
  Result := l_Result;
 finally
  l3InterlockedDecrement(f_SubmitGuard);
 end;
//#UC END# *53CDFABD0075_53CDF9FE006B_impl*
end;//TalcuSubmitterWorkPool.SubmitTask

procedure TalcuSubmitterWorkPool.CheckExecution(const aServices: IcsRunTaskServices);
//#UC START# *53CDFADC00B4_53CDF9FE006B_var*

 function DoIt(aThread: PalcuSubmitterWorkThread; Index: Long): Bool;
 begin
   Result := True;
   aThread.CheckExecution(aServices);
 end;

//#UC END# *53CDFADC00B4_53CDF9FE006B_var*
begin
//#UC START# *53CDFADC00B4_53CDF9FE006B_impl*
 if f_SubmitGuard = 0 then
  f_List.IterateAllF(l3L2IA(@DoIt));
//#UC END# *53CDFADC00B4_53CDF9FE006B_impl*
end;//TalcuSubmitterWorkPool.CheckExecution

function TalcuSubmitterWorkPool.HasRunningTask(const aServices: IcsRunTaskServices): Boolean;
//#UC START# *53CF9B060043_53CDF9FE006B_var*

var
  l_Result: Boolean;

 function DoIt(aThread: PalcuSubmitterWorkThread; Index: Long): Bool;
 begin
   aThread.CheckExecution(aServices);
   if aThread.StillRunning then
     l_Result := True;
   Result := not l_Result;
 end;

//#UC END# *53CF9B060043_53CDF9FE006B_var*
begin
//#UC START# *53CF9B060043_53CDF9FE006B_impl*
 l_Result := False;
 f_List.IterateAllF(l3L2IA(@DoIt));
 Result := l_Result;
//#UC END# *53CF9B060043_53CDF9FE006B_impl*
end;//TalcuSubmitterWorkPool.HasRunningTask

procedure TalcuSubmitterWorkPool.RegisterNotifier(const aNotifier: IalcuAsyncTaskFinishedNotifier);
//#UC START# *53D0E39102B2_53CDF9FE006B_var*
//#UC END# *53D0E39102B2_53CDF9FE006B_var*
begin
//#UC START# *53D0E39102B2_53CDF9FE006B_impl*
 f_FinishNotifierList.Add(aNotifier);
//#UC END# *53D0E39102B2_53CDF9FE006B_impl*
end;//TalcuSubmitterWorkPool.RegisterNotifier

procedure TalcuSubmitterWorkPool.UnRegisterNotifier(const aNotifier: IalcuAsyncTaskFinishedNotifier);
//#UC START# *53D0E3AE025B_53CDF9FE006B_var*
//#UC END# *53D0E3AE025B_53CDF9FE006B_var*
begin
//#UC START# *53D0E3AE025B_53CDF9FE006B_impl*
 f_FinishNotifierList.Remove(aNotifier);
//#UC END# *53D0E3AE025B_53CDF9FE006B_impl*
end;//TalcuSubmitterWorkPool.UnRegisterNotifier

function TalcuSubmitterWorkPool.AllowSubmitTask: Boolean;
//#UC START# *541173D101EC_53CDF9FE006B_var*
//#UC END# *541173D101EC_53CDF9FE006B_var*
begin
//#UC START# *541173D101EC_53CDF9FE006B_impl*
 Result := f_LockSubmitTaskCounter = 0;
//#UC END# *541173D101EC_53CDF9FE006B_impl*
end;//TalcuSubmitterWorkPool.AllowSubmitTask

procedure TalcuSubmitterWorkPool.LockSubmitTask;
//#UC START# *541173EF01F8_53CDF9FE006B_var*
//#UC END# *541173EF01F8_53CDF9FE006B_var*
begin
//#UC START# *541173EF01F8_53CDF9FE006B_impl*
 Inc(f_LockSubmitTaskCounter);
//#UC END# *541173EF01F8_53CDF9FE006B_impl*
end;//TalcuSubmitterWorkPool.LockSubmitTask

procedure TalcuSubmitterWorkPool.UnLockSubmitTask;
//#UC START# *541174030002_53CDF9FE006B_var*
//#UC END# *541174030002_53CDF9FE006B_var*
begin
//#UC START# *541174030002_53CDF9FE006B_impl*
 if f_LockSubmitTaskCounter > 0 then
  Dec(f_LockSubmitTaskCounter);
//#UC END# *541174030002_53CDF9FE006B_impl*
end;//TalcuSubmitterWorkPool.UnLockSubmitTask

procedure TalcuSubmitterWorkPool.TaskFinished(const aTask: TddProcessTask);
//#UC START# *53D0E2CD0227_53CDF9FE006B_var*
//#UC END# *53D0E2CD0227_53CDF9FE006B_var*
begin
//#UC START# *53D0E2CD0227_53CDF9FE006B_impl*
 NotifySubscribers(aTask);
//#UC END# *53D0E2CD0227_53CDF9FE006B_impl*
end;//TalcuSubmitterWorkPool.TaskFinished

procedure TalcuSubmitterWorkPool.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53CDF9FE006B_var*
//#UC END# *479731C50290_53CDF9FE006B_var*
begin
//#UC START# *479731C50290_53CDF9FE006B_impl*
 FreeAndNil(f_List);
 FreeAndNil(f_FinishNotifierList);
 inherited;
//#UC END# *479731C50290_53CDF9FE006B_impl*
end;//TalcuSubmitterWorkPool.Cleanup

procedure TalcuSubmitterWorkPool.ClearFields;
begin
 f_Manager := nil;
 inherited;
end;//TalcuSubmitterWorkPool.ClearFields
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

end.
