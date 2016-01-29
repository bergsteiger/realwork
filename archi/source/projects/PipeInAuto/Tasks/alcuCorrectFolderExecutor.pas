unit alcuCorrectFolderExecutor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuCorrectFolderExecutor.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::ResultDelivery::TalcuCorrectFolderExecutor
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
 TalcuCorrectFolderExecutor = class(TalcuExecutorWithTaskList {$If not defined(Nemesis)}, IncsExecutor{$IfEnd} //not Nemesis
 )
 protected
 // realized methods
   {$If not defined(Nemesis)}
   procedure Execute(const aContext: TncsExecuteContext);
   {$IfEnd} //not Nemesis
 public
 // public methods
   class function Make(aTaskList: TalcuTaskList): IncsExecutor; reintroduce;
     {* Сигнатура фабрики TalcuCorrectFolderExecutor.Make }
 end;//TalcuCorrectFolderExecutor
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  SysUtils
  {$If not defined(Nemesis)}
  ,
  ncsCorrectFolder
  {$IfEnd} //not Nemesis
  
  {$If defined(AppServerSide) AND defined(ServerTasks)}
  ,
  alcuTaskListBase
  {$IfEnd} //AppServerSide AND ServerTasks
  
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  csExport
  {$IfEnd} //not Nemesis
  ,
  l3Base
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuCorrectFolderExecutor

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
end;

{$If not defined(Nemesis)}
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
{$IfEnd} //not Nemesis

{$IfEnd} //ServerTasks

end.