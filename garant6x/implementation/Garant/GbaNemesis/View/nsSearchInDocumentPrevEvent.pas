unit nsSearchInDocumentPrevEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsSearchInDocumentPrevEvent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsSearchInDocumentPrevEvent" MUID: (5280A7050003)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
 , DocumentUnit
 , l3Interfaces
;

type
 TnsSearchInDocumentPrevEvent = class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument;
    const aContext: Il3CString);
 end;//TnsSearchInDocumentPrevEvent
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
 //#UC START# *5280A7050003impl_uses*
 //#UC END# *5280A7050003impl_uses*
;

class procedure TnsSearchInDocumentPrevEvent.Log(const aDoc: IDocument;
 const aContext: Il3CString);
//#UC START# *5280A7140235_5280A7050003_var*
var
 l_Data: InsLogEventData;
//#UC END# *5280A7140235_5280A7050003_var*
begin
//#UC START# *5280A7140235_5280A7050003_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 l_Data.AddString(nsAStr(aContext).S);
 GetLogger.AddEvent(LE_PREVIOUS_SEARCH_IN_DOCUMENT, l_Data);
//#UC END# *5280A7140235_5280A7050003_impl*
end;//TnsSearchInDocumentPrevEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
