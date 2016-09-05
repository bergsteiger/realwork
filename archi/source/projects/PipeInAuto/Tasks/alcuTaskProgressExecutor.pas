unit alcuTaskProgressExecutor;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuTaskProgressExecutor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuTaskProgressExecutor" MUID: (54748E8A0085)

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
 TalcuTaskProgressExecutor = class(TalcuExecutorWithTaskList{$If NOT Defined(Nemesis)}
 , IncsExecutor
 {$IfEnd} // NOT Defined(Nemesis)
 )
  protected
   {$If NOT Defined(Nemesis)}
   procedure Execute(const aContext: TncsExecuteContext);
   {$IfEnd} // NOT Defined(Nemesis)
  public
   class function Make(aTaskList: TalcuTaskList): IncsExecutor; reintroduce;
 end;//TalcuTaskProgressExecutor
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 {$If Defined(AppServerSide)}
 , alcuTaskListBase
 {$IfEnd} // Defined(AppServerSide)
 {$If NOT Defined(Nemesis)}
 , ncsTaskProgress
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 , Messages
 , Windows
 //#UC START# *54748E8A0085impl_uses*
 //#UC END# *54748E8A0085impl_uses*
;

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
end;//TalcuTaskProgressExecutor.Make

{$If NOT Defined(Nemesis)}
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
{$IfEnd} // NOT Defined(Nemesis)

{$IfEnd} // Defined(ServerTasks)
end.
