unit nsBackEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsBackEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::Events::TnsBackEvent
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
 TnsBackEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log;
 end;//TnsBackEvent
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

// start class TnsBackEvent

class procedure TnsBackEvent.Log;
//#UC START# *4B14E64200BC_4B14E61701BC_var*
//#UC END# *4B14E64200BC_4B14E61701BC_var*
begin
//#UC START# *4B14E64200BC_4B14E61701BC_impl*
 GetLogger.AddEvent(LE_BACK, MakeParamsList);
//#UC END# *4B14E64200BC_4B14E61701BC_impl*
end;//TnsBackEvent.Log

{$IfEnd} //not Admin AND not Monitorings

end.