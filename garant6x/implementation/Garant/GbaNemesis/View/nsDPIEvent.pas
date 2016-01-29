unit nsDPIEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsDPIEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::Events::TnsDPIEvent
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
 TnsDPIEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(aDPI: Cardinal);
 end;//TnsDPIEvent
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

// start class TnsDPIEvent

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

{$IfEnd} //not Admin AND not Monitorings

end.