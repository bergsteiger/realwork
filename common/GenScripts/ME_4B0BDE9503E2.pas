unit nsListSortEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\List\nsListSortEvent.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
 , DynamicDocListUnit
 , bsTypes
;

type
 TnsListSortEvent = class(TnsLogEvent)
  public
   class procedure Log(const aList: IDynList;
    SortOrder: TbsSortOrder;
    SortType: TbsSortType);
 end;//TnsListSortEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , LoggingUnit
 , nsLogEventData
 , nsLogManager
 , LoggingWrapperInterfaces
;

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
