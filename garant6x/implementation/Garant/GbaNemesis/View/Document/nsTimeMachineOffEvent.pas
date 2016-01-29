unit nsTimeMachineOffEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/nsTimeMachineOffEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Работа с документом и списком документов::Document::View::Document::TnsTimeMachineOffEvent
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  nsLogEvent
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsTimeMachineOffEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aDoc: IDocument);
 end;//TnsTimeMachineOffEvent
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  LoggingUnit,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsTimeMachineOffEvent

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

{$IfEnd} //not Admin AND not Monitorings

end.