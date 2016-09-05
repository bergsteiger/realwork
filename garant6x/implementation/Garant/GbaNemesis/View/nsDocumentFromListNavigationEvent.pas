unit nsDocumentFromListNavigationEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsDocumentFromListNavigationEvent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsDocumentFromListNavigationEvent" MUID: (4B1658140144)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
 , DynamicDocListUnit
 , DocumentUnit
;

type
 TnsDocumentFromListNavigationEvent = class(TnsLogEvent)
  public
   class procedure Log(aNext: Boolean;
    const aList: IDynList;
    const aDoc: IDocument);
 end;//TnsDocumentFromListNavigationEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , LoggingUnit
 , nsLogEventData
 , nsLogManager
 , LoggingWrapperInterfaces
 //#UC START# *4B1658140144impl_uses*
 //#UC END# *4B1658140144impl_uses*
;

class procedure TnsDocumentFromListNavigationEvent.Log(aNext: Boolean;
 const aList: IDynList;
 const aDoc: IDocument);
//#UC START# *4B16583901B5_4B1658140144_var*
var
 l_Data: InsLogEventData;
const
 c_Event: array [Boolean] of TLogEvent = (
  LE_PREV_DOCUMENT,
  LE_NEXT_DOCUMENT
 );//c_Event
//#UC END# *4B16583901B5_4B1658140144_var*
begin
//#UC START# *4B16583901B5_4B1658140144_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aList);
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(c_Event[aNext], l_Data);
//#UC END# *4B16583901B5_4B1658140144_impl*
end;//TnsDocumentFromListNavigationEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
