unit nsChangeFontSizeEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsChangeFontSizeEvent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsChangeFontSizeEvent" MUID: (4B0BAFB9012B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
;

type
 TnsChangeFontSizeEvent = class(TnsLogEvent)
  public
   class procedure Log(aInc: Boolean;
    aSize: Cardinal);
 end;//TnsChangeFontSizeEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , LoggingUnit
 , nsLogEventData
 , nsLogManager
 , LoggingWrapperInterfaces
 //#UC START# *4B0BAFB9012Bimpl_uses*
 //#UC END# *4B0BAFB9012Bimpl_uses*
;

class procedure TnsChangeFontSizeEvent.Log(aInc: Boolean;
 aSize: Cardinal);
//#UC START# *4B0BAFD30056_4B0BAFB9012B_var*
var
 l_Data: InsLogEventData;
const
 cMap: array [Boolean] of TLogEvent = (LE_DEC_FONT, LE_INC_FONT);
//#UC END# *4B0BAFD30056_4B0BAFB9012B_var*
begin
//#UC START# *4B0BAFD30056_4B0BAFB9012B_impl*
 l_Data := MakeParamsList;
 l_Data.AddULong(aSize);
 GetLogger.AddEvent(cMap[aInc], l_Data);
//#UC END# *4B0BAFD30056_4B0BAFB9012B_impl*
end;//TnsChangeFontSizeEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
