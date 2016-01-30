unit nsPrimaryMonitorResolutionEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsPrimaryMonitorResolutionEvent.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
;

type
 TnsPrimaryMonitorResolutionEvent = class(TnsLogEvent)
  public
   class procedure Log(aWidth: Cardinal;
    aHeight: Cardinal);
 end;//TnsPrimaryMonitorResolutionEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , LoggingUnit
;

class procedure TnsPrimaryMonitorResolutionEvent.Log(aWidth: Cardinal;
 aHeight: Cardinal);
//#UC START# *4B0BB0510315_4B0BB046001B_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0BB0510315_4B0BB046001B_var*
begin
//#UC START# *4B0BB0510315_4B0BB046001B_impl*
 l_Data := MakeParamsList;
 l_Data.AddULong(aWidth);
 l_Data.AddULong(aHeight);
 GetLogger.AddEvent(LE_PRIMARY_MONITOR_RESOLUTION, l_Data);
//#UC END# *4B0BB0510315_4B0BB046001B_impl*
end;//TnsPrimaryMonitorResolutionEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
