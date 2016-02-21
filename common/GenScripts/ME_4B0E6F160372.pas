unit nsTextTabActivateEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\nsTextTabActivateEvent.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
 , DocumentUnit
;

type
 TnsTextTabActivateKind = (
  ttakRelated
  , ttakAnnotation
 );//TnsTextTabActivateKind

 TnsTextTabActivateEvent = class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument;
    aKind: TnsTextTabActivateKind);
 end;//TnsTextTabActivateEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , LoggingUnit
 , nsLogEventData
 , nsLogManager
 , LoggingWrapperInterfaces
;

class procedure TnsTextTabActivateEvent.Log(const aDoc: IDocument;
 aKind: TnsTextTabActivateKind);
//#UC START# *4B0E700600BA_4B0E6F160372_var*
var
 l_Data: InsLogEventData;
const
  cMap: array [TnsTextTabActivateKind] of TLogEvent = (LE_OPEN_RELATED, LE_OPEN_ANNOTATION);
//#UC END# *4B0E700600BA_4B0E6F160372_var*
begin
//#UC START# *4B0E700600BA_4B0E6F160372_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(cMap[aKind], l_Data);
//#UC END# *4B0E700600BA_4B0E6F160372_impl*
end;//TnsTextTabActivateEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
