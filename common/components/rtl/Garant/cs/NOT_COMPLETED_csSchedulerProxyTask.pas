unit NOT_COMPLETED_csSchedulerProxyTask;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_COMPLETED_csSchedulerProxyTask.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsSchedulerProxyTask" MUID: (57065CCE0306)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
;

type
 TcsSchedulerProxyTask = class(TddProcessTask)
  protected
   function pm_GetSchedulerTaskType: Integer;
   procedure pm_SetSchedulerTaskType(aValue: Integer);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property SchedulerTaskType: Integer
    read pm_GetSchedulerTaskType
    write pm_SetSchedulerTaskType;
 end;//TcsSchedulerProxyTask
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SchedulerProxyTask_Const
;

function TcsSchedulerProxyTask.pm_GetSchedulerTaskType: Integer;
//#UC START# *FCA5EBB34665_57065CCE0306get_var*
//#UC END# *FCA5EBB34665_57065CCE0306get_var*
begin
//#UC START# *FCA5EBB34665_57065CCE0306get_impl*
 !!! Needs to be implemented !!!
//#UC END# *FCA5EBB34665_57065CCE0306get_impl*
end;//TcsSchedulerProxyTask.pm_GetSchedulerTaskType

procedure TcsSchedulerProxyTask.pm_SetSchedulerTaskType(aValue: Integer);
//#UC START# *FCA5EBB34665_57065CCE0306set_var*
//#UC END# *FCA5EBB34665_57065CCE0306set_var*
begin
//#UC START# *FCA5EBB34665_57065CCE0306set_impl*
 !!! Needs to be implemented !!!
//#UC END# *FCA5EBB34665_57065CCE0306set_impl*
end;//TcsSchedulerProxyTask.pm_SetSchedulerTaskType

class function TcsSchedulerProxyTask.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_57065CCE0306_var*
//#UC END# *53AC03EE01FD_57065CCE0306_var*
begin
//#UC START# *53AC03EE01FD_57065CCE0306_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_57065CCE0306_impl*
end;//TcsSchedulerProxyTask.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
