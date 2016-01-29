unit nsListSortEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/List/nsListSortEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::ListDataSources::TnsListSortEvent
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
  bsTypes,
  nsLogEvent
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsListSortEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aList: IDynList;
    SortOrder: TbsSortOrder;
    SortType: TbsSortType);
 end;//TnsListSortEvent
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

// start class TnsListSortEvent

class procedure TnsListSortEvent.Log(const aList: IDynList;
  SortOrder: TbsSortOrder;
  SortType: TbsSortType);
//#UC START# *4B0BDF0A03E2_4B0BDE9503E2_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0BDF0A03E2_4B0BDE9503E2_var*
begin
//#UC START# *4B0BDF0A03E2_4B0BDE9503E2_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aList);
 l_Data.AddULong(Ord(SortOrder));
 l_Data.AddULong(Ord(SortType));
 GetLogger.AddEvent(LE_LIST_SORT, l_Data);
//#UC END# *4B0BDF0A03E2_4B0BDE9503E2_impl*
end;//TnsListSortEvent.Log

{$IfEnd} //not Admin AND not Monitorings

end.