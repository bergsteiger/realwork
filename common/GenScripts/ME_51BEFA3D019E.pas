unit nsSaveDocumentToFoldersEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\nsSaveDocumentToFoldersEvent.pas"
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
 TnsSaveDocumentToFoldersEvent = class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument);
 end;//TnsSaveDocumentToFoldersEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsLogEventData
 , nsLogManager
 , LoggingUnit
 , LoggingWrapperInterfaces
;

class procedure TnsSaveDocumentToFoldersEvent.Log(const aDoc: IDocument);
//#UC START# *51BEFAC50138_51BEFA3D019E_var*
var
 l_Data: InsLogEventData;
//#UC END# *51BEFAC50138_51BEFA3D019E_var*
begin
//#UC START# *51BEFAC50138_51BEFA3D019E_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(LE_SAVE_DOCUMENT_TO_FOLDERS, l_Data);
//#UC END# *51BEFAC50138_51BEFA3D019E_impl*
end;//TnsSaveDocumentToFoldersEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
