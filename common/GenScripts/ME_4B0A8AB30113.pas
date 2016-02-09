unit nsSearchInDocumentEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsSearchInDocumentEvent.pas"
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
 TnsSearchInDocumentEvent = class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument;
    const aContext: Il3CString);
 end;//TnsSearchInDocumentEvent
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
;

class procedure TnsSearchInDocumentEvent.Log(const aDoc: IDocument;
 const aContext: Il3CString);
//#UC START# *4B0A8AF000C9_4B0A8AB30113_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0A8AF000C9_4B0A8AB30113_var*
begin
//#UC START# *4B0A8AF000C9_4B0A8AB30113_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 l_Data.AddString(nsAStr(aContext).S);
 GetLogger.AddEvent(LE_SEARCH_IN_DOCUMENT, l_Data);
//#UC END# *4B0A8AF000C9_4B0A8AB30113_impl*
end;//TnsSearchInDocumentEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
