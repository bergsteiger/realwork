unit nsOpenDocumentFromLinkEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsOpenDocumentFromLinkEvent.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
 , DocumentInterfaces
;

type
 TnsOpenDocumentFromLinkEvent = class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IdeDocInfo); virtual;
 end;//TnsOpenDocumentFromLinkEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , bsTypesNew
 , nsLogEventData
 , nsLogManager
 , LoggingUnit
 , LoggingWrapperInterfaces
;

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
