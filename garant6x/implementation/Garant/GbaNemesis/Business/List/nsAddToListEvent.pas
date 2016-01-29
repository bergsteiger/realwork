unit nsAddToListEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/List/nsAddToListEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::ListDataSources::TnsAddToListEvent
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
  DynamicDocListUnit,
  nsLogEvent
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsAddToListEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aList: IDynList);
 end;//TnsAddToListEvent
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

// start class TnsAddToListEvent

class procedure TnsAddToListEvent.Log(const aList: IDynList);
//#UC START# *4B0A7FEC0294_4B0A7FAF0270_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0A7FEC0294_4B0A7FAF0270_var*
begin
//#UC START# *4B0A7FEC0294_4B0A7FAF0270_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aList);
 GetLogger.AddEvent(LE_ADD_TO_LIST, l_Data);
//#UC END# *4B0A7FEC0294_4B0A7FAF0270_impl*
end;//TnsAddToListEvent.Log

{$IfEnd} //not Admin AND not Monitorings

end.