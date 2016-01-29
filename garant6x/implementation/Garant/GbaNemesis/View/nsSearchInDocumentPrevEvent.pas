unit nsSearchInDocumentPrevEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsSearchInDocumentPrevEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::Base Forms::TnsSearchInDocumentPrevEvent
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
  l3Interfaces,
  nsLogEvent
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsSearchInDocumentPrevEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aDoc: IDocument;
    const aContext: Il3CString);
 end;//TnsSearchInDocumentPrevEvent
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  LoggingUnit,
  nsTypes,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsSearchInDocumentPrevEvent

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

{$IfEnd} //not Admin AND not Monitorings

end.