unit alcuCorrectFolderExecutor;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuCorrectFolderExecutor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuCorrectFolderExecutor" MUID: (549AC018025D)

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
 TalcuCorrectFolderExecutor = class(TalcuExecutorWithTaskList{$If NOT Defined(Nemesis)}
 , IncsExecutor
 {$IfEnd} // NOT Defined(Nemesis)
 )
  protected
   {$If NOT Defined(Nemesis)}
   procedure Execute(const aContext: TncsExecuteContext);
   {$IfEnd} // NOT Defined(Nemesis)
  public
   class function Make(aTaskList: TalcuTaskList): IncsExecutor; reintroduce;
 end;//TalcuCorrectFolderExecutor
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , ncsCorrectFolder
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(AppServerSide)}
 , alcuTaskListBase
 {$IfEnd} // Defined(AppServerSide)
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csExport
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Base
 //#UC START# *549AC018025Dimpl_uses*
 //#UC END# *549AC018025Dimpl_uses*
;

class function TalcuCorrectFolderExecutor.Make(aTaskList: TalcuTaskList): IncsExecutor;
var
 l_Inst : TalcuCorrectFolderExecutor;
begin
 l_Inst := Create(aTaskList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TalcuCorrectFolderExecutor.Make

{$If NOT Defined(Nemesis)}
procedure TalcuCorrectFolderExecutor.Execute(const aContext: TncsExecuteContext);
//#UC START# *54607DDC0159_549AC018025D_var*
var
 l_Message: TncsCorrectFolder;

 function DoProcess(anItem: TddProcessTask): Boolean;
 var
  l_Task: TcsExport;
 begin
  Result := False;
  l_Task := anItem as TcsExport;
  l_Task.ExportDirectory := l_Message.NewFolder;
  l_Task.Description := l_Task.DefaultDescription;
 end;

//#UC END# *54607DDC0159_549AC018025D_var*
begin
//#UC START# *54607DDC0159_549AC018025D_impl*
 l_Message := aContext.rMessage as TncsCorrectFolder;
 if not TaskList.ForOneByIDF(L2AlcuTasksIteratorForOneByIDFAction(@DoProcess), l_Message.TaskID) then
  l3System.Msg2Log('Задача с идентификатором ' + l_Message.TaskID + ' не найдена');
 l3System.Msg2Log('Скорректирован каталог доставки');
//#UC END# *54607DDC0159_549AC018025D_impl*
end;//TalcuCorrectFolderExecutor.Execute
{$IfEnd} // NOT Defined(Nemesis)

{$IfEnd} // Defined(ServerTasks)
end.
