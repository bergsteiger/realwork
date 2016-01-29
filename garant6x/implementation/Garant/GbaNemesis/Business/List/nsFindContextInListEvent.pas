unit nsFindContextInListEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/List/nsFindContextInListEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::ListDataSources::TnsFindContextInListEvent
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
  l3Interfaces,
  nsLogEvent
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsFindContextInListEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aList: IDynList;
    const aContext: Il3CString);
 end;//TnsFindContextInListEvent
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  LoggingUnit,
  nsTypes,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsFindContextInListEvent

class procedure TnsFindContextInListEvent.Log(const aList: IDynList;
  const aContext: Il3CString);
//#UC START# *4B0BDF9A02DD_4B0BDF4E022E_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0BDF9A02DD_4B0BDF4E022E_var*
begin
//#UC START# *4B0BDF9A02DD_4B0BDF4E022E_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aList);
 l_Data.AddString(nsAStr(aContext).S);
 GetLogger.AddEvent(LE_FIND_CONTEXT_IN_LIST, l_Data);
//#UC END# *4B0BDF9A02DD_4B0BDF4E022E_impl*
end;//TnsFindContextInListEvent.Log

{$IfEnd} //not Admin AND not Monitorings

end.