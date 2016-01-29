unit alcuGetReadyToDeliveryTasksExecutor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuGetReadyToDeliveryTasksExecutor.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::ResultDelivery::TalcuGetReadyToDeliveryTasksExecutor
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
 TalcuGetReadyToDeliveryTasksExecutor = class(TalcuExecutorWithTaskList {$If not defined(Nemesis)}, IncsExecutor{$IfEnd} //not Nemesis
 )
 protected
 // realized methods
   {$If not defined(Nemesis)}
   procedure Execute(const aContext: TncsExecuteContext);
   {$IfEnd} //not Nemesis
 public
 // public methods
   class function Make(aTaskList: TalcuTaskList): IncsExecutor; reintroduce;
     {* Сигнатура фабрики TalcuGetReadyToDeliveryTasksExecutor.Make }
 end;//TalcuGetReadyToDeliveryTasksExecutor
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  SysUtils
  {$If not defined(Nemesis)}
  ,
  ncsGetReadyToDeliveryTasks
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  ncsGetReadyToDeliveryTasksReply
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  CsCommon
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  
  {$If defined(AppServerSide) AND defined(ServerTasks)}
  ,
  alcuTaskListBase
  {$IfEnd} //AppServerSide AND ServerTasks
  
  {$If not defined(Nemesis)}
  ,
  csTaskTypes
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuGetReadyToDeliveryTasksExecutor

class function TalcuGetReadyToDeliveryTasksExecutor.Make(aTaskList: TalcuTaskList): IncsExecutor;
var
 l_Inst : TalcuGetReadyToDeliveryTasksExecutor;
begin
 l_Inst := Create(aTaskList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

{$If not defined(Nemesis)}
procedure TalcuGetReadyToDeliveryTasksExecutor.Execute(const aContext: TncsExecuteContext);
//#UC START# *54607DDC0159_5465D93A0165_var*
var
 l_Reply: TncsGetReadyToDeliveryTasksReply;
 l_UserID: TCsClientId;

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  if (anItem.Status = cs_tsReadyToDelivery) and (anItem.UserID = l_UserID) then
   l_Reply.TasksIDList.Add(anItem.TaskID);
 end;

//#UC END# *54607DDC0159_5465D93A0165_var*
begin
//#UC START# *54607DDC0159_5465D93A0165_impl*
 l_Reply := TncsGetReadyToDeliveryTasksReply.Create(aContext.rMessage);
 try
  l_UserID := (aContext.rMessage as TncsGetReadyToDeliveryTasks).UserID;
  aContext.rTransporter.ClientID := l_UserID;
  TaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
  aContext.rTransporter.Send(l_Reply);
 finally
  FreeAndNil(l_Reply);
 end;
//#UC END# *54607DDC0159_5465D93A0165_impl*
end;//TalcuGetReadyToDeliveryTasksExecutor.Execute
{$IfEnd} //not Nemesis

{$IfEnd} //ServerTasks

end.