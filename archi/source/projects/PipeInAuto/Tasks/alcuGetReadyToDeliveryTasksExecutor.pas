unit alcuGetReadyToDeliveryTasksExecutor;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuGetReadyToDeliveryTasksExecutor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuGetReadyToDeliveryTasksExecutor" MUID: (5465D93A0165)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuExecutorWithTaskList
 {$If NOT Defined(Nemesis)}
 , ncsMessageInterfaces
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(AppServerSide)}
 , alcuTaskList
 {$IfEnd} // Defined(AppServerSide)
;

type
 TalcuGetReadyToDeliveryTasksExecutor = class(TalcuExecutorWithTaskList{$If NOT Defined(Nemesis)}
 , IncsExecutor
 {$IfEnd} // NOT Defined(Nemesis)
 )
  protected
   {$If NOT Defined(Nemesis)}
   procedure Execute(const aContext: TncsExecuteContext);
   {$IfEnd} // NOT Defined(Nemesis)
  public
   class function Make(aTaskList: TalcuTaskList): IncsExecutor; reintroduce;
 end;//TalcuGetReadyToDeliveryTasksExecutor
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , ncsGetReadyToDeliveryTasks
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsGetReadyToDeliveryTasksReply
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsCommon
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 {$If Defined(AppServerSide)}
 , alcuTaskListBase
 {$IfEnd} // Defined(AppServerSide)
 {$If NOT Defined(Nemesis)}
 , csTaskTypes
 {$IfEnd} // NOT Defined(Nemesis)
;

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
end;//TalcuGetReadyToDeliveryTasksExecutor.Make

{$If NOT Defined(Nemesis)}
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
{$IfEnd} // NOT Defined(Nemesis)

{$IfEnd} // Defined(ServerTasks)
end.
