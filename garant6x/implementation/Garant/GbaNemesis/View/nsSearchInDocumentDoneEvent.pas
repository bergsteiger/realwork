unit nsSearchInDocumentDoneEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsSearchInDocumentDoneEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::Base Forms::TnsSearchInDocumentDoneEvent
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
 TnsSearchInDocumentDoneEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aDoc: IDocument;
    const aContext: Il3CString;
    aFoundCount: Integer);
 end;//TnsSearchInDocumentDoneEvent
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

// start class TnsSearchInDocumentDoneEvent

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

{$IfEnd} //not Admin AND not Monitorings

end.