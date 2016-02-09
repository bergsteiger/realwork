unit nsForwardEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsForwardEvent.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
;

type
 TnsForwardEvent = class(TnsLogEvent)
  public
   class procedure Log;
 end;//TnsForwardEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , LoggingUnit
 , nsLogEventData
 , nsLogManager
 , LoggingWrapperInterfaces
;

class procedure TnsForwardEvent.Log;
//#UC START# *4B14E63700DE_4B14E5FB019B_var*
//#UC END# *4B14E63700DE_4B14E5FB019B_var*
begin
//#UC START# *4B14E63700DE_4B14E5FB019B_impl*
 GetLogger.AddEvent(LE_FORWARD, MakeParamsList);
//#UC END# *4B14E63700DE_4B14E5FB019B_impl*
end;//TnsForwardEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
