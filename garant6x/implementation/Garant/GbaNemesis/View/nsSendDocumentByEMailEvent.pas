unit nsSendDocumentByEMailEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsSendDocumentByEMailEvent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsSendDocumentByEMailEvent" MUID: (4B0B9A490271)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
 , DocumentUnit
;

type
 TnsSendDocumentByEMailEvent = class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument);
 end;//TnsSendDocumentByEMailEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , LoggingUnit
 , nsLogEventData
 , nsLogManager
 , LoggingWrapperInterfaces
 //#UC START# *4B0B9A490271impl_uses*
 //#UC END# *4B0B9A490271impl_uses*
;

class procedure TnsSendDocumentByEMailEvent.Log(const aDoc: IDocument);
//#UC START# *4B0B9A6603E7_4B0B9A490271_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0B9A6603E7_4B0B9A490271_var*
begin
//#UC START# *4B0B9A6603E7_4B0B9A490271_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(LE_SEND_DOCUMENT_BY_EMAIL, l_Data);
//#UC END# *4B0B9A6603E7_4B0B9A490271_impl*
end;//TnsSendDocumentByEMailEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
