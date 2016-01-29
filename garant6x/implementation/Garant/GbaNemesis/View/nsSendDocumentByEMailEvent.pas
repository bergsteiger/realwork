unit nsSendDocumentByEMailEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsSendDocumentByEMailEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::Base Forms::TnsSendDocumentByEMailEvent
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  nsLogEvent
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsSendDocumentByEMailEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aDoc: IDocument);
 end;//TnsSendDocumentByEMailEvent
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  LoggingUnit,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsSendDocumentByEMailEvent

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

{$IfEnd} //not Admin AND not Monitorings

end.