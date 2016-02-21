unit nsSwitchVersionCommentsEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\nsSwitchVersionCommentsEvent.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
;

type
 TnsSwitchVersionCommentsEvent = class(TnsLogEvent)
  public
   class procedure Log(State: Boolean);
 end;//TnsSwitchVersionCommentsEvent
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

class procedure TnsSwitchVersionCommentsEvent.Log(State: Boolean);
//#UC START# *4B0E6ED502E0_4B0E6EAD01D9_var*
const
 cMap: array [Boolean] of Cardinal = (0, 1);
var
 l_Data: InsLogEventData;
//#UC END# *4B0E6ED502E0_4B0E6EAD01D9_var*
begin
//#UC START# *4B0E6ED502E0_4B0E6EAD01D9_impl*
 l_Data := MakeParamsList;
 l_Data.AddULong(cMap[State]);
 GetLogger.AddEvent(LE_SWITCH_VERSION_COMMENTS, l_Data);
//#UC END# *4B0E6ED502E0_4B0E6EAD01D9_impl*
end;//TnsSwitchVersionCommentsEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
