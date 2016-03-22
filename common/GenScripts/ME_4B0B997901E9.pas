unit nsExportToFileEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsExportToFileEvent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsExportToFileEvent" MUID: (4B0B997901E9)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
 , DocumentUnit
;

type
 TnsExportToFileEvent = class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument);
 end;//TnsExportToFileEvent
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

class procedure TnsExportToFileEvent.Log(const aDoc: IDocument);
//#UC START# *4B0B99960016_4B0B997901E9_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0B99960016_4B0B997901E9_var*
begin
//#UC START# *4B0B99960016_4B0B997901E9_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(LE_EXPORT_TO_FILE, l_Data);
//#UC END# *4B0B99960016_4B0B997901E9_impl*
end;//TnsExportToFileEvent.Log
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
