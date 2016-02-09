unit nsTryingToOpenMissingDocumentFromLinkEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsTryingToOpenMissingDocumentFromLinkEvent.pas"
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
 TnsTryingToOpenMissingDocumentFromLinkEvent = class(TnsLogEvent)
  public
   class procedure Log(const aTopic: TTopic);
 end;//TnsTryingToOpenMissingDocumentFromLinkEvent
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
