unit alcuSortedTaskList;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuSortedTaskList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuSortedTaskList" MUID: (53A196B800AD)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
uses
 l3IntfUses
 , alcuTaskListBase
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuSortedTaskList = class(TalcuTaskListBase)
  protected
   procedure Add(anItem: TddProcessTask);
   function NeedSort: Boolean; override;
  public
   procedure Remove(anItem: TddProcessTask);
 end;//TalcuSortedTaskList
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

implementation

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
uses
 l3ImplUses
;

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
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

end.
