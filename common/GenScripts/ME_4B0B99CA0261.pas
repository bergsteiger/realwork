unit nsExportToWordEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsExportToWordEvent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsExportToWordEvent" MUID: (4B0B99CA0261)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
 , DocumentUnit
;

type
 TnsExportToWordEvent = class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument;
    ForSelection: Boolean;
    IntoActive: Boolean);
 end;//TnsExportToWordEvent
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

class procedure TnsExportToWordEvent.Log(const aDoc: IDocument;
 ForSelection: Boolean;
 IntoActive: Boolean);
//#UC START# *4B0B99D901AD_4B0B99CA0261_var*
var
 l_Data: InsLogEventData;
const
 cMap: array [Boolean] of Integer = (0, 1); 
//#UC END# *4B0B99D901AD_4B0B99CA0261_var*
begin
//#UC START# *4B0B99D901AD_4B0B99CA0261_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 l_Data.AddULong(cMap[ForSelection]);
 l_Data.AddULong(cMap[IntoActive]);
 GetLogger.AddEvent(LE_EXPORT_TO_WORD, l_Data);
//#UC END# *4B0B99D901AD_4B0B99CA0261_impl*
end;//TnsExportToWordEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
