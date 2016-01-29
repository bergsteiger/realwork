unit NOT_FINISHED_alcuTaskManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Server"
// Модуль: "w:/archi/source/projects/PipeInAuto/Server/NOT_FINISHED_alcuTaskManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$AutoPipeServer$Garant::Server::Server::alcuTaskManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  ,
  ddServerTaskManagerPrim,
  l3MultiThreadSortedIntegerList
  {$If defined(AppServerSide) AND defined(ServerTasks)}
  ,
  alcuServerAsyncExecutionInterfaces
  {$IfEnd} //AppServerSide AND ServerTasks
  
  {$If defined(AppServerSide) AND defined(ServerTasks)}
  ,
  alcuSubmitterWorkPool
  {$IfEnd} //AppServerSide AND ServerTasks
  ,
  alcuBaseEngineHolder
  {$If defined(ServerTasks)}
  ,
  alcuDeliveryInterfaces
  {$IfEnd} //ServerTasks
  
  {$If defined(ServerTasks)}
  ,
  alcuDetachedExecutorPool
  {$IfEnd} //ServerTasks
  
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  csTaskTypes
  {$IfEnd} //not Nemesis
  
  ;

type
 TddServerTaskManager = class(TddServerTaskManagerPrim {$If defined(AppServerSide) AND defined(ServerTasks)}, IalcuAsyncTaskFinishedNotifier{$IfEnd} //AppServerSide AND ServerTasks
  {$If defined(ServerTasks)}, IalcuTaskFinisher{$IfEnd} //ServerTasks
 )
 private
 // private fields
   f_DetachedExecutorPool : TalcuDetachedExecutorPool;
   f_MonitorUsers : Tl3MultiThreadSortedIntegerList;
   f_PrivateMonitorUsers : Tl3MultiThreadSortedIntegerList;
   f_WorkPool : TalcuSubmitterWorkPool;
   f_BaseEngineHolder : TalcuBaseEngineHolder;
 protected
 // realized methods
   procedure DoTaskChanged(aTask: TddTaskItem;
     aStatus: TcsTaskStatus); override;
   {$If defined(AppServerSide) AND defined(ServerTasks)}
   procedure TaskFinished(const aTask: TddProcessTask);
   {$IfEnd} //AppServerSide AND ServerTasks
   {$If defined(ServerTasks)}
   procedure TaskDone(aTask: TddProcessTask);
   {$IfEnd} //ServerTasks
 protected
 // protected methods
    {$If defined(AppServerSide) AND defined(InsiderTest)}
   procedure SimulateTaskDone(aTask: TddProcessTask); virtual;
     {* имитирует отправку результата пользователю после выполнения задания }
    {$IfEnd} //AppServerSide AND InsiderTest
    {$If defined(AppServerSide) AND defined(InsiderTest)}
   procedure BeforeSaveQuery; virtual;
     {* Сигнатура метода BeforeSaveQuery }
    {$IfEnd} //AppServerSide AND InsiderTest
    {$If defined(AppServerSide) AND defined(InsiderTest)}
   function NeedRaiseInProcessQuery: Boolean; virtual;
    {$IfEnd} //AppServerSide AND InsiderTest
 end;//TddServerTaskManager
{$IfEnd} //AppServerSide

implementation

{$If defined(AppServerSide)}
uses
  alcuAsyncSubmitterManager
  {$If defined(ServerTasks)}
  ,
  alcuGetReadyToDeliveryTasksExecutor
  {$IfEnd} //ServerTasks
  
  {$If defined(ServerTasks)}
  ,
  alcuGetTaskDescriptionExecutor
  {$IfEnd} //ServerTasks
  
  {$If defined(ServerTasks)}
  ,
  alcuTaskProgressExecutor
  {$IfEnd} //ServerTasks
  
  {$If defined(ServerTasks)}
  ,
  alcuDeliveryResultExecutor
  {$IfEnd} //ServerTasks
  
  {$If defined(ServerTasks)}
  ,
  alcuGetFilePartExecutor
  {$IfEnd} //ServerTasks
  
  {$If defined(ServerTasks)}
  ,
  alcuSendTaskExecutor
  {$IfEnd} //ServerTasks
  
  {$If defined(ServerTasks)}
  ,
  alcuCorrectFolderExecutor
  {$IfEnd} //ServerTasks
  
  {$If defined(ServerTasks)}
  ,
  alcuDetachedExecutor
  {$IfEnd} //ServerTasks
  ,
  alcuProcessingEnabledService
  {$If defined(AppServerSide) AND defined(ServerTasks)}
  ,
  alcuTaskList
  {$IfEnd} //AppServerSide AND ServerTasks
  
  {$If defined(AppServerSide) AND defined(ServerTasks)}
  ,
  alcuNotSortedTaskList
  {$IfEnd} //AppServerSide AND ServerTasks
  
  ;

// start class TddServerTaskManager

{$If defined(AppServerSide) AND defined(InsiderTest)}
procedure TddServerTaskManager.SimulateTaskDone(aTask: TddProcessTask);
//#UC START# *52F8EDDA037F_52F8E80D00A5_var*
//#UC END# *52F8EDDA037F_52F8E80D00A5_var*
begin
//#UC START# *52F8EDDA037F_52F8E80D00A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52F8EDDA037F_52F8E80D00A5_impl*
end;//TddServerTaskManager.SimulateTaskDone
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
procedure TddServerTaskManager.BeforeSaveQuery;
//#UC START# *52F8EDF703C0_52F8E80D00A5_var*
//#UC END# *52F8EDF703C0_52F8E80D00A5_var*
begin
//#UC START# *52F8EDF703C0_52F8E80D00A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52F8EDF703C0_52F8E80D00A5_impl*
end;//TddServerTaskManager.BeforeSaveQuery
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
function TddServerTaskManager.NeedRaiseInProcessQuery: Boolean;
//#UC START# *52F8F0990208_52F8E80D00A5_var*
//#UC END# *52F8F0990208_52F8E80D00A5_var*
begin
//#UC START# *52F8F0990208_52F8E80D00A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52F8F0990208_52F8E80D00A5_impl*
end;//TddServerTaskManager.NeedRaiseInProcessQuery
{$IfEnd} //AppServerSide AND InsiderTest

procedure TddServerTaskManager.DoTaskChanged(aTask: TddTaskItem;
  aStatus: TcsTaskStatus);
//#UC START# *5385C616025E_52F8E80D00A5_var*
//#UC END# *5385C616025E_52F8E80D00A5_var*
begin
//#UC START# *5385C616025E_52F8E80D00A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *5385C616025E_52F8E80D00A5_impl*
end;//TddServerTaskManager.DoTaskChanged

{$If defined(AppServerSide) AND defined(ServerTasks)}
procedure TddServerTaskManager.TaskFinished(const aTask: TddProcessTask);
//#UC START# *53D0E2CD0227_52F8E80D00A5_var*
//#UC END# *53D0E2CD0227_52F8E80D00A5_var*
begin
//#UC START# *53D0E2CD0227_52F8E80D00A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *53D0E2CD0227_52F8E80D00A5_impl*
end;//TddServerTaskManager.TaskFinished
{$IfEnd} //AppServerSide AND ServerTasks

{$If defined(ServerTasks)}
procedure TddServerTaskManager.TaskDone(aTask: TddProcessTask);
//#UC START# *5475AFAA017A_52F8E80D00A5_var*
//#UC END# *5475AFAA017A_52F8E80D00A5_var*
begin
//#UC START# *5475AFAA017A_52F8E80D00A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *5475AFAA017A_52F8E80D00A5_impl*
end;//TddServerTaskManager.TaskDone
{$IfEnd} //ServerTasks
{$IfEnd} //AppServerSide

end.