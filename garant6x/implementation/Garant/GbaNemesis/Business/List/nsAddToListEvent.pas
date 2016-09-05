unit nsAddToListEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\List\nsAddToListEvent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsAddToListEvent" MUID: (4B0A7FAF0270)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
 , DynamicDocListUnit
;

type
 TnsAddToListEvent = class(TnsLogEvent)
  public
   class procedure Log(const aList: IDynList);
 end;//TnsAddToListEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , LoggingUnit
 , nsLogEventData
 , nsLogManager
 , LoggingWrapperInterfaces
 //#UC START# *4B0A7FAF0270impl_uses*
 //#UC END# *4B0A7FAF0270impl_uses*
;

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
