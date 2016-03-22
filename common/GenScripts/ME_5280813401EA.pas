unit nsSearchInDocumentDoneEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsSearchInDocumentDoneEvent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsSearchInDocumentDoneEvent" MUID: (5280813401EA)

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
 TnsSearchInDocumentDoneEvent = class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument;
    const aContext: Il3CString;
    aFoundCount: Integer);
 end;//TnsSearchInDocumentDoneEvent
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

class procedure TnsSearchInDocumentDoneEvent.Log(const aDoc: IDocument;
 const aContext: Il3CString;
 aFoundCount: Integer);
//#UC START# *528081740164_5280813401EA_var*
var
 l_Data: InsLogEventData;
//#UC END# *528081740164_5280813401EA_var*
begin
//#UC START# *528081740164_5280813401EA_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 l_Data.AddString(nsAStr(aContext).S);
 l_Data.AddULong(LongWord(aFoundCount));
 GetLogger.AddEvent(LE_SEARCH_IN_DOCUMENT_DONE, l_Data);
//#UC END# *528081740164_5280813401EA_impl*
end;//TnsSearchInDocumentDoneEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
