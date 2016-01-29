unit nsListEvents;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/List/nsListEvents.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Работа с документом и списком документов::WorkWithList::View::List::nsListEvents
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
  nsLogEvent,
  DocumentInterfaces
  ;

type
 TnsOpenDocumentFromListEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aDoc: IDocument;
     aNumber: Integer;
     aRelevance: Integer;
     aSubBlock: Integer;
     aPara: Integer); overload; 
   class procedure Log(const aDocInfo: IdeDocInfo); overload; 
 end;//TnsOpenDocumentFromListEvent
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  LoggingUnit,
  bsTypesNew,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces
  ;

// start class TnsOpenDocumentFromListEvent

class procedure TnsOpenDocumentFromListEvent.Log(const aDoc: IDocument;
  aNumber: Integer;
  aRelevance: Integer;
  aSubBlock: Integer;
  aPara: Integer);
//#UC START# *52A826610281_4B0A69600050_var*
var
 l_Data: InsLogEventData;
//#UC END# *52A826610281_4B0A69600050_var*
begin
//#UC START# *52A826610281_4B0A69600050_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 if aSubBlock >= 0
  then l_Data.AddULong(aSubBlock)
  else l_Data.AddString('');
 if aPara >= 0
  then l_Data.AddULong(aPara)
  else l_Data.AddString('');
 l_Data.AddULong(aNumber);
 l_Data.AddULong(aRelevance);
 GetLogger.AddEvent(LE_OPEN_DOCUMENT_FROM_LIST, l_Data);
//#UC END# *52A826610281_4B0A69600050_impl*
end;//TnsOpenDocumentFromListEvent.Log

class procedure TnsOpenDocumentFromListEvent.Log(const aDocInfo: IdeDocInfo);
//#UC START# *52A826A80339_4B0A69600050_var*
var
 l_DocSub,
 l_Para: Integer;
//#UC END# *52A826A80339_4B0A69600050_var*
begin
//#UC START# *52A826A80339_4B0A69600050_impl*
 l_DocSub := -1;
 l_Para := -1;
 case aDocInfo.Pos.rRefType of
  dptSub: l_DocSub := aDocInfo.Pos.rPos;
  dptPara: l_Para := aDocInfo.Pos.rPos;
 end;
 Log(aDocInfo.Doc, 1, 0, l_DocSub, l_Para);
//#UC END# *52A826A80339_4B0A69600050_impl*
end;//TnsOpenDocumentFromListEvent.Log
{$IfEnd} //not Admin AND not Monitorings

end.