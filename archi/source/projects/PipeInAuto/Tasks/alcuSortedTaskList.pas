unit alcuSortedTaskList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuSortedTaskList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::TasksLists::TalcuSortedTaskList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide) AND defined(ServerTasks)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  ,
  alcuTaskListBase
  ;
{$IfEnd} //AppServerSide AND ServerTasks

{$If defined(AppServerSide) AND defined(ServerTasks)}
type
 TalcuSortedTaskList = class(TalcuTaskListBase)
 protected
 // overridden protected methods
   function NeedSort: Boolean; override;
 protected
 // protected methods
   procedure Add(anItem: TddProcessTask);
 public
 // public methods
   procedure Remove(anItem: TddProcessTask);
 end;//TalcuSortedTaskList
{$IfEnd} //AppServerSide AND ServerTasks

implementation

{$If defined(AppServerSide) AND defined(ServerTasks)}

// start class TalcuSortedTaskList

procedure TalcuSortedTaskList.Remove(anItem: TddProcessTask);
//#UC START# *53A046C20358_53A196B800AD_var*
//#UC END# *53A046C20358_53A196B800AD_var*
begin
//#UC START# *53A046C20358_53A196B800AD_impl*
 Lock;
 try
  Items.Remove(anItem);
 finally
  Unlock;
 end;//try..finally
//#UC END# *53A046C20358_53A196B800AD_impl*
end;//TalcuSortedTaskList.Remove

procedure TalcuSortedTaskList.Add(anItem: TddProcessTask);
//#UC START# *53A042AF001A_53A196B800AD_var*
//#UC END# *53A042AF001A_53A196B800AD_var*
begin
//#UC START# *53A042AF001A_53A196B800AD_impl*
 Changing;
 try
  Lock;
  try
   {anItem.TaskIndex := }Items.Add(anItem);
  finally
   Unlock;
  end;//try..finally
 finally
  Changed;
 end;
//#UC END# *53A042AF001A_53A196B800AD_impl*
end;//TalcuSortedTaskList.Add

function TalcuSortedTaskList.NeedSort: Boolean;
//#UC START# *53A196850107_53A196B800AD_var*
//#UC END# *53A196850107_53A196B800AD_var*
begin
//#UC START# *53A196850107_53A196B800AD_impl*
 Result := true;
//#UC END# *53A196850107_53A196B800AD_impl*
end;//TalcuSortedTaskList.NeedSort

{$IfEnd} //AppServerSide AND ServerTasks

end.