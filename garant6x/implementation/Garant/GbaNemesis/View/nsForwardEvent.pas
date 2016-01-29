unit nsForwardEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsForwardEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::Events::TnsForwardEvent
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
  nsLogEvent
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsForwardEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log;
 end;//TnsForwardEvent
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

// start class TnsForwardEvent

class procedure TnsForwardEvent.Log;
//#UC START# *4B14E63700DE_4B14E5FB019B_var*
//#UC END# *4B14E63700DE_4B14E5FB019B_var*
begin
//#UC START# *4B14E63700DE_4B14E5FB019B_impl*
 GetLogger.AddEvent(LE_FORWARD, MakeParamsList);
//#UC END# *4B14E63700DE_4B14E5FB019B_impl*
end;//TnsForwardEvent.Log

{$IfEnd} //not Admin AND not Monitorings

end.