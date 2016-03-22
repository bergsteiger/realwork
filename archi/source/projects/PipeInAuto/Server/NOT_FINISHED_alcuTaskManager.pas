unit NOT_FINISHED_alcuTaskManager;

// Модуль: "w:\archi\source\projects\PipeInAuto\Server\NOT_FINISHED_alcuTaskManager.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "alcuTaskManager" MUID: (52F8BE3100F5)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
 {$If Defined(ServerTasks)}
 , alcuServerAsyncExecutionInterfaces
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuDeliveryInterfaces
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 , ddServerTaskManagerPrim
 {$If Defined(ServerTasks)}
 , alcuDetachedExecutorPool
 {$IfEnd} // Defined(ServerTasks)
 , l3MultiThreadSortedIntegerList
 {$If Defined(ServerTasks)}
 , alcuSubmitterWorkPool
 {$IfEnd} // Defined(ServerTasks)
 , alcuBaseEngineHolder
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csTaskTypes
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TddServerTaskManager = class(TddServerTaskManagerPrim{$If Defined(ServerTasks)}
 , IalcuAsyncTaskFinishedNotifier
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , IalcuTaskFinisher
 {$IfEnd} // Defined(ServerTasks)
 )
  private
   f_DetachedExecutorPool: TalcuDetachedExecutorPool;
   f_MonitorUsers: Tl3MultiThreadSortedIntegerList;
   f_PrivateMonitorUsers: Tl3MultiThreadSortedIntegerList;
   f_WorkPool: TalcuSubmitterWorkPool;
   f_BaseEngineHolder: TalcuBaseEngineHolder;
  protected
   {$If Defined(InsiderTest)}
   procedure SimulateTaskDone(aTask: TddProcessTask); virtual;
    {* имитирует отправку результата пользователю после выполнения задания }
   {$IfEnd} // Defined(InsiderTest)
   {$If Defined(InsiderTest)}
   procedure BeforeSaveQuery; virtual;
   {$IfEnd} // Defined(InsiderTest)
   {$If Defined(InsiderTest)}
   function NeedRaiseInProcessQuery: Boolean; virtual;
   {$IfEnd} // Defined(InsiderTest)
   procedure DoTaskChanged(aTask: TddTaskItem;
    aStatus: TcsTaskStatus); override;
   {$If Defined(ServerTasks)}
   procedure TaskFinished(const aTask: TddProcessTask);
   {$IfEnd} // Defined(ServerTasks)
   {$If Defined(ServerTasks)}
   procedure TaskDone(aTask: TddProcessTask);
   {$IfEnd} // Defined(ServerTasks)
 end;//TddServerTaskManager
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
 {$If Defined(ServerTasks)}
 , alcuTaskList
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuNotSortedTaskList
 {$IfEnd} // Defined(ServerTasks)
 , alcuAsyncSubmitterManager
 {$If Defined(ServerTasks)}
 , alcuGetReadyToDeliveryTasksExecutor
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuGetTaskDescriptionExecutor
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuTaskProgressExecutor
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuDeliveryResultExecutor
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuGetFilePartExecutor
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuSendTaskExecutor
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuCorrectFolderExecutor
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuDetachedExecutor
 {$IfEnd} // Defined(ServerTasks)
 , alcuProcessingEnabledService
;

{$If Defined(InsiderTest)}
procedure TddServerTaskManager.SimulateTaskDone(aTask: TddProcessTask);
 {* имитирует отправку результата пользователю после выполнения задания }
//#UC START# *52F8EDDA037F_52F8E80D00A5_var*
//#UC END# *52F8EDDA037F_52F8E80D00A5_var*
begin
//#UC START# *52F8EDDA037F_52F8E80D00A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52F8EDDA037F_52F8E80D00A5_impl*
end;//TddServerTaskManager.SimulateTaskDone
{$IfEnd} // Defined(InsiderTest)

{$If Defined(InsiderTest)}
procedure TddServerTaskManager.BeforeSaveQuery;
//#UC START# *52F8EDF703C0_52F8E80D00A5_var*
//#UC END# *52F8EDF703C0_52F8E80D00A5_var*
begin
//#UC START# *52F8EDF703C0_52F8E80D00A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52F8EDF703C0_52F8E80D00A5_impl*
end;//TddServerTaskManager.BeforeSaveQuery
{$IfEnd} // Defined(InsiderTest)

{$If Defined(InsiderTest)}
function TddServerTaskManager.NeedRaiseInProcessQuery: Boolean;
//#UC START# *52F8F0990208_52F8E80D00A5_var*
//#UC END# *52F8F0990208_52F8E80D00A5_var*
begin
//#UC START# *52F8F0990208_52F8E80D00A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52F8F0990208_52F8E80D00A5_impl*
end;//TddServerTaskManager.NeedRaiseInProcessQuery
{$IfEnd} // Defined(InsiderTest)

procedure TddServerTaskManager.DoTaskChanged(aTask: TddTaskItem;
 aStatus: TcsTaskStatus);
//#UC START# *5385C616025E_52F8E80D00A5_var*
//#UC END# *5385C616025E_52F8E80D00A5_var*
begin
//#UC START# *5385C616025E_52F8E80D00A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *5385C616025E_52F8E80D00A5_impl*
end;//TddServerTaskManager.DoTaskChanged

{$If Defined(ServerTasks)}
procedure TddServerTaskManager.TaskFinished(const aTask: TddProcessTask);
//#UC START# *53D0E2CD0227_52F8E80D00A5_var*
//#UC END# *53D0E2CD0227_52F8E80D00A5_var*
begin
//#UC START# *53D0E2CD0227_52F8E80D00A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *53D0E2CD0227_52F8E80D00A5_impl*
end;//TddServerTaskManager.TaskFinished
{$IfEnd} // Defined(ServerTasks)

{$If Defined(ServerTasks)}
procedure TddServerTaskManager.TaskDone(aTask: TddProcessTask);
//#UC START# *5475AFAA017A_52F8E80D00A5_var*
//#UC END# *5475AFAA017A_52F8E80D00A5_var*
begin
//#UC START# *5475AFAA017A_52F8E80D00A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *5475AFAA017A_52F8E80D00A5_impl*
end;//TddServerTaskManager.TaskDone
{$IfEnd} // Defined(ServerTasks)

{$IfEnd} // Defined(AppServerSide)
end.
