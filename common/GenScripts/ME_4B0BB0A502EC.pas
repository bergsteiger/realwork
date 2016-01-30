unit nsDPIEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsDPIEvent.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
;

type
 TnsDPIEvent = class(TnsLogEvent)
  public
   class procedure Log(aDPI: Cardinal);
 end;//TnsDPIEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , LoggingUnit
;

class procedure TnsDPIEvent.Log(aDPI: Cardinal);
//#UC START# *4B0BB0B9003D_4B0BB0A502EC_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0BB0B9003D_4B0BB0A502EC_var*
begin
//#UC START# *4B0BB0B9003D_4B0BB0A502EC_impl*
 l_Data := MakeParamsList;
 l_Data.AddULong(aDPI);
 GetLogger.AddEvent(LE_DPI, l_Data);
//#UC END# *4B0BB0B9003D_4B0BB0A502EC_impl*
end;//TnsDPIEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
