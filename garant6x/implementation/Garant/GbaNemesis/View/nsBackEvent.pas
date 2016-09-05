unit nsBackEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsBackEvent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsBackEvent" MUID: (4B14E61701BC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
;

type
 TnsBackEvent = class(TnsLogEvent)
  public
   class procedure Log;
 end;//TnsBackEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , LoggingUnit
 , nsLogEventData
 , nsLogManager
 , LoggingWrapperInterfaces
 //#UC START# *4B14E61701BCimpl_uses*
 //#UC END# *4B14E61701BCimpl_uses*
;

class procedure TnsBackEvent.Log;
//#UC START# *4B14E64200BC_4B14E61701BC_var*
//#UC END# *4B14E64200BC_4B14E61701BC_var*
begin
//#UC START# *4B14E64200BC_4B14E61701BC_impl*
 GetLogger.AddEvent(LE_BACK, MakeParamsList);
//#UC END# *4B14E64200BC_4B14E61701BC_impl*
end;//TnsBackEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
