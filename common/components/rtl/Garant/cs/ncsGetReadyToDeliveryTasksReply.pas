unit ncsGetReadyToDeliveryTasksReply;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsGetReadyToDeliveryTasksReply.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsGetReadyToDeliveryTasksReply" MUID: (54645E0D0246)

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
 //#UC START# *54645E0D0246impl_uses*
 //#UC END# *54645E0D0246impl_uses*
;

function TncsGetReadyToDeliveryTasksReply.pm_GetTasksIDList: TasksIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TTasksIDListHelper.Make(TaggedData.cAtom(k2_attrTasksIDList));
end;//TncsGetReadyToDeliveryTasksReply.pm_GetTasksIDList

class function TncsGetReadyToDeliveryTasksReply.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsGetReadyToDeliveryTasksReply;
end;//TncsGetReadyToDeliveryTasksReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
