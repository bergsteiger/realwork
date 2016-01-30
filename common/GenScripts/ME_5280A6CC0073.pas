unit nsSearchInDocumentNextEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsSearchInDocumentNextEvent.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
 , DocumentUnit
 , l3Interfaces
;

type
 TnsSearchInDocumentNextEvent = class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument;
    const aContext: Il3CString);
 end;//TnsSearchInDocumentNextEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , LoggingUnit
 , nsTypes
;

class procedure TnsSearchInDocumentNextEvent.Log(const aDoc: IDocument;
 const aContext: Il3CString);
//#UC START# *5280A6F5009C_5280A6CC0073_var*
var
 l_Data: InsLogEventData;
//#UC END# *5280A6F5009C_5280A6CC0073_var*
begin
//#UC START# *5280A6F5009C_5280A6CC0073_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 l_Data.AddString(nsAStr(aContext).S);
 GetLogger.AddEvent(LE_NEXT_SEARCH_IN_DOCUMENT, l_Data);
//#UC END# *5280A6F5009C_5280A6CC0073_impl*
end;//TnsSearchInDocumentNextEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
