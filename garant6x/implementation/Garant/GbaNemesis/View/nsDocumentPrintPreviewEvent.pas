unit nsDocumentPrintPreviewEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsDocumentPrintPreviewEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::Base Forms::TnsDocumentPrintPreviewEvent
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
 TnsDocumentPrintPreviewEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aDoc: IDocument);
 end;//TnsDocumentPrintPreviewEvent
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

// start class TnsDocumentPrintPreviewEvent

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

{$IfEnd} //not Admin AND not Monitorings

end.