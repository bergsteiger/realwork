unit nsFindContextInListEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\List\nsFindContextInListEvent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsFindContextInListEvent" MUID: (4B0BDF4E022E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
 , DynamicDocListUnit
 , l3Interfaces
;

type
 TnsFindContextInListEvent = class(TnsLogEvent)
  public
   class procedure Log(const aList: IDynList;
    const aContext: Il3CString);
 end;//TnsFindContextInListEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , LoggingUnit
 , nsTypes
 , nsLogEventData
 , nsLogManager
 , LoggingWrapperInterfaces
 //#UC START# *4B0BDF4E022Eimpl_uses*
 //#UC END# *4B0BDF4E022Eimpl_uses*
;

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
