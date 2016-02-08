unit nsTimeMachineOffEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\nsTimeMachineOffEvent.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
 , DocumentUnit
;

type
 TnsTimeMachineOffEvent = class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument);
 end;//TnsTimeMachineOffEvent
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

class procedure TnsTimeMachineOffEvent.Log(const aDoc: IDocument);
//#UC START# *4B1653E30155_4B1653D10039_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B1653E30155_4B1653D10039_var*
begin
//#UC START# *4B1653E30155_4B1653D10039_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(LE_TIME_MACHINE_OFF, l_Data);
//#UC END# *4B1653E30155_4B1653D10039_impl*
end;//TnsTimeMachineOffEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
