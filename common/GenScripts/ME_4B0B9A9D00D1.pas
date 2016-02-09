unit nsDocumentPrintPreviewEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsDocumentPrintPreviewEvent.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
 , DocumentUnit
;

type
 TnsDocumentPrintPreviewEvent = class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument);
 end;//TnsDocumentPrintPreviewEvent
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

class procedure TnsDocumentPrintPreviewEvent.Log(const aDoc: IDocument);
//#UC START# *4B0B9AB201A9_4B0B9A9D00D1_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0B9AB201A9_4B0B9A9D00D1_var*
begin
//#UC START# *4B0B9AB201A9_4B0B9A9D00D1_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(LE_DOCUMENT_PRINT_PREVIEW, l_Data);
//#UC END# *4B0B9AB201A9_4B0B9A9D00D1_impl*
end;//TnsDocumentPrintPreviewEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
