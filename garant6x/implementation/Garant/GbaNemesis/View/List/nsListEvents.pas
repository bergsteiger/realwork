unit nsListEvents;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\nsListEvents.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsListEvents" MUID: (52A821F90360)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
 , DocumentUnit
 , DocumentInterfaces
;

type
 TnsOpenDocumentFromListEvent = class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument;
    aNumber: Integer;
    aRelevance: Integer;
    aSubBlock: Integer;
    aPara: Integer); overload;
   class procedure Log(const aDocInfo: IdeDocInfo); overload;
 end;//TnsOpenDocumentFromListEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , LoggingUnit
 , bsTypesNew
;

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
