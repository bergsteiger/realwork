unit alcuTaskProgressExecutor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuTaskProgressExecutor.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::ResultDelivery::TalcuTaskProgressExecutor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(ServerTasks)}
uses
  Classes
  {$If defined(AppServerSide) AND defined(ServerTasks)}
  ,
  alcuTaskList
  {$IfEnd} //AppServerSide AND ServerTasks
  
  {$If not defined(Nemesis)}
  ,
  ncsMessageInterfaces
  {$IfEnd} //not Nemesis
  ,
  alcuExecutorWithTaskList
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuTaskProgressExecutor = class(TalcuExecutorWithTaskList {$If not defined(Nemesis)}, IncsExecutor{$IfEnd} //not Nemesis
 )
 protected
 // realized methods
   {$If not defined(Nemesis)}
   procedure Execute(const aContext: TncsExecuteContext);
   {$IfEnd} //not Nemesis
 public
 // public methods
   class function Make(aTaskList: TalcuTaskList): IncsExecutor; reintroduce;
     {* Сигнатура фабрики TalcuTaskProgressExecutor.Make }
 end;//TalcuTaskProgressExecutor
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  SysUtils
  {$If defined(AppServerSide) AND defined(ServerTasks)}
  ,
  alcuTaskListBase
  {$IfEnd} //AppServerSide AND ServerTasks
  
  {$If not defined(Nemesis)}
  ,
  ncsTaskProgress
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  ,
  Messages,
  Windows
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuTaskProgressExecutor

class function TalcuTaskProgressExecutor.Make(aTaskList: TalcuTaskList): IncsExecutor;
var
 l_Inst : TalcuTaskProgressExecutor;
begin
 l_Inst := Create(aTaskList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

{$If not defined(Nemesis)}
procedure TalcuTaskProgressExecutor.Execute(const aContext: TncsExecuteContext);
//#UC START# *54607DDC0159_54748E8A0085_var*
var
 l_Message: TncsTaskProgress;

 function DoProcess(anItem: TddProcessTask): Boolean;
 begin
  anItem.SetProgress(l_Message.Percent, l_Message.Description);
 end;

//#UC END# *54607DDC0159_54748E8A0085_var*
begin
//#UC START# *54607DDC0159_54748E8A0085_impl*
 l_Message := (aContext.rMessage as TncsTaskProgress);
 TaskList.ForOneByIDF(L2AlcuTasksIteratorForOneByIDFAction(@DoProcess), l_Message.TaskID);
 PostThreadMessage(MainThreadID, WM_NULL, 0, 0);
//#UC END# *54607DDC0159_54748E8A0085_impl*
end;//TalcuTaskProgressExecutor.Execute
{$IfEnd} //not Nemesis

{$IfEnd} //ServerTasks

end.