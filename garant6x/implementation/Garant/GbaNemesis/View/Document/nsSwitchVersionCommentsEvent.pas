unit nsSwitchVersionCommentsEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/nsSwitchVersionCommentsEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Работа с документом и списком документов::Document::View::Document::TnsSwitchVersionCommentsEvent
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
 TnsSwitchVersionCommentsEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(State: Boolean);
 end;//TnsSwitchVersionCommentsEvent
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

// start class TnsSwitchVersionCommentsEvent

class procedure TnsSwitchVersionCommentsEvent.Log(State: Boolean);
//#UC START# *4B0E6ED502E0_4B0E6EAD01D9_var*
const
 cMap: array [Boolean] of Cardinal = (0, 1);
var
 l_Data: InsLogEventData;
//#UC END# *4B0E6ED502E0_4B0E6EAD01D9_var*
begin
//#UC START# *4B0E6ED502E0_4B0E6EAD01D9_impl*
 l_Data := MakeParamsList;
 l_Data.AddULong(cMap[State]);
 GetLogger.AddEvent(LE_SWITCH_VERSION_COMMENTS, l_Data);
//#UC END# *4B0E6ED502E0_4B0E6EAD01D9_impl*
end;//TnsSwitchVersionCommentsEvent.Log

{$IfEnd} //not Admin AND not Monitorings

end.