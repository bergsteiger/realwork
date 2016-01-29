unit nsFontSizeEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsFontSizeEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::Events::TnsFontSizeEvent
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
 TnsFontSizeEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(aSize: Cardinal); virtual;
 end;//TnsFontSizeEvent
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

// start class TnsFontSizeEvent

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

{$IfEnd} //not Admin AND not Monitorings

end.