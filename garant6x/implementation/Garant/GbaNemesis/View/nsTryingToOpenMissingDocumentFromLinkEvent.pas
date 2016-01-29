unit nsTryingToOpenMissingDocumentFromLinkEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsTryingToOpenMissingDocumentFromLinkEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::Navigation::TnsTryingToOpenMissingDocumentFromLinkEvent
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
 TnsTryingToOpenMissingDocumentFromLinkEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aTopic: TTopic);
 end;//TnsTryingToOpenMissingDocumentFromLinkEvent
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsLogEventData,
  nsLogManager,
  LoggingUnit,
  LoggingWrapperInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsTryingToOpenMissingDocumentFromLinkEvent

class procedure TnsTryingToOpenMissingDocumentFromLinkEvent.Log(const aTopic: TTopic);
//#UC START# *527CD1EB017C_527CD1B702B4_var*
var
 l_Data: InsLogEventData;
//#UC END# *527CD1EB017C_527CD1B702B4_var*
begin
//#UC START# *527CD1EB017C_527CD1B702B4_impl*
 l_Data := MakeParamsList;
 with aTopic do
 begin
  l_Data.AddULong(Longword(rPid.rObjectId));
  l_Data.AddULong(Longword(rPid.rClassId));
  l_Data.AddULong(Longword(rPosition.rPoint));
  l_Data.AddULong(Longword(rPosition.rType));
 end;
 GetLogger.AddEvent(LE_DOCUMENT_NOT_EXIST, l_Data);
//#UC END# *527CD1EB017C_527CD1B702B4_impl*
end;//TnsTryingToOpenMissingDocumentFromLinkEvent.Log

{$IfEnd} //not Admin AND not Monitorings

end.