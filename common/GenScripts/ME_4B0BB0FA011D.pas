unit nsFontSizeEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsFontSizeEvent.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
;

type
 TnsFontSizeEvent = class(TnsLogEvent)
  public
   class procedure Log(aSize: Cardinal); virtual;
 end;//TnsFontSizeEvent
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

class procedure TnsFontSizeEvent.Log(aSize: Cardinal);
//#UC START# *4B0BB10A02E7_4B0BB0FA011D_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0BB10A02E7_4B0BB0FA011D_var*
begin
//#UC START# *4B0BB10A02E7_4B0BB0FA011D_impl*
 l_Data := MakeParamsList;
 l_Data.AddULong(aSize);
 GetLogger.AddEvent(LE_FONT_SIZE, l_Data);
//#UC END# *4B0BB10A02E7_4B0BB0FA011D_impl*
end;//TnsFontSizeEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
