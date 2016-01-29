unit nsPrimaryMonitorResolutionEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsPrimaryMonitorResolutionEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::Events::TnsPrimaryMonitorResolutionEvent
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
 TnsPrimaryMonitorResolutionEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(aWidth: Cardinal;
    aHeight: Cardinal);
 end;//TnsPrimaryMonitorResolutionEvent
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

// start class TnsPrimaryMonitorResolutionEvent

class procedure TnsPrimaryMonitorResolutionEvent.Log(aWidth: Cardinal;
  aHeight: Cardinal);
//#UC START# *4B0BB0510315_4B0BB046001B_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0BB0510315_4B0BB046001B_var*
begin
//#UC START# *4B0BB0510315_4B0BB046001B_impl*
 l_Data := MakeParamsList;
 l_Data.AddULong(aWidth);
 l_Data.AddULong(aHeight);
 GetLogger.AddEvent(LE_PRIMARY_MONITOR_RESOLUTION, l_Data);
//#UC END# *4B0BB0510315_4B0BB046001B_impl*
end;//TnsPrimaryMonitorResolutionEvent.Log

{$IfEnd} //not Admin AND not Monitorings

end.