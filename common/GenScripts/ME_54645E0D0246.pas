unit ncsGetReadyToDeliveryTasksReply;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsGetReadyToDeliveryTasksReply.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , evdTasksHelpers
 , k2Base
;

type
 TncsGetReadyToDeliveryTasksReply = class(TncsReply)
  protected
   function pm_GetTasksIDList: TasksIDListHelper;
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TasksIDList: TasksIDListHelper
    read pm_GetTasksIDList;
 end;//TncsGetReadyToDeliveryTasksReply
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csGetReadyToDeliveryTasksReply_Const
;

function TncsGetReadyToDeliveryTasksReply.pm_GetTasksIDList: TasksIDListHelper;
//#UC START# *DDB3B434FE0B_54645E0D0246get_var*
//#UC END# *DDB3B434FE0B_54645E0D0246get_var*
begin
//#UC START# *DDB3B434FE0B_54645E0D0246get_impl*
 !!! Needs to be implemented !!!
//#UC END# *DDB3B434FE0B_54645E0D0246get_impl*
end;//TncsGetReadyToDeliveryTasksReply.pm_GetTasksIDList

class function TncsGetReadyToDeliveryTasksReply.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_54645E0D0246_var*
//#UC END# *53AC03EE01FD_54645E0D0246_var*
begin
//#UC START# *53AC03EE01FD_54645E0D0246_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_54645E0D0246_impl*
end;//TncsGetReadyToDeliveryTasksReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
