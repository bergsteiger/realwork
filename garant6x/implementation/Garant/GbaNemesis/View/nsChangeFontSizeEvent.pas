unit nsChangeFontSizeEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsChangeFontSizeEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::Events::TnsChangeFontSizeEvent
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
 TnsChangeFontSizeEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(aInc: Boolean;
    aSize: Cardinal);
 end;//TnsChangeFontSizeEvent
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

// start class TnsChangeFontSizeEvent

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

{$IfEnd} //not Admin AND not Monitorings

end.