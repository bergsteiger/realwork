unit nsOpenDocumentFromLinkEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsOpenDocumentFromLinkEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::Navigation::TnsOpenDocumentFromLinkEvent
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
  nsLogEvent,
  DocumentInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsOpenDocumentFromLinkEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aDoc: IdeDocInfo); virtual;
 end;//TnsOpenDocumentFromLinkEvent
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  bsTypesNew,
  nsLogEventData,
  nsLogManager,
  LoggingUnit,
  LoggingWrapperInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsOpenDocumentFromLinkEvent

class procedure TnsOpenDocumentFromLinkEvent.Log(const aDoc: IdeDocInfo);
//#UC START# *4B0A78550087_4B0A781302C3_var*
var
 l_Data: InsLogEventData;
 l_Sub, l_Para: Integer;
//#UC END# *4B0A78550087_4B0A781302C3_var*
begin
//#UC START# *4B0A78550087_4B0A781302C3_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc.Doc);

 if aDoc.Pos.rRefType = dptSub
  then l_Data.AddULong(aDoc.Pos.rPos)
  else l_Data.AddString('');

 if aDoc.Pos.rRefType = dptPara
  then l_Data.AddULong(aDoc.Pos.rPos)
  else l_Data.AddString('');

 GetLogger.AddEvent(LE_OPEN_DOCUMENT_FROM_LINK, l_Data);
//#UC END# *4B0A78550087_4B0A781302C3_impl*
end;//TnsOpenDocumentFromLinkEvent.Log

{$IfEnd} //not Admin AND not Monitorings

end.