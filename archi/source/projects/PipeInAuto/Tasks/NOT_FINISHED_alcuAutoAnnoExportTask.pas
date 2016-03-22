unit NOT_FINISHED_alcuAutoAnnoExportTask;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuAutoAnnoExportTask.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuAutoAnnoExportTask" MUID: (53F59F6F0341)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuAutoAnnoExportTaskPrim
;

type
 TalcuAutoAnnoExportTask = class(TalcuAutoAnnoExportTaskPrim)
  protected
   {$If NOT Defined(Nemesis)}
   function GetDescription: AnsiString; override;
   {$IfEnd} // NOT Defined(Nemesis)
 end;//TalcuAutoAnnoExportTask
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
;

{$If NOT Defined(Nemesis)}
function TalcuAutoAnnoExportTask.GetDescription: AnsiString;
//#UC START# *53FB28170339_53F59F6F0341_var*
//#UC END# *53FB28170339_53F59F6F0341_var*
begin
//#UC START# *53FB28170339_53F59F6F0341_impl*
 !!! Needs to be implemented !!!
//#UC END# *53FB28170339_53F59F6F0341_impl*
end;//TalcuAutoAnnoExportTask.GetDescription
{$IfEnd} // NOT Defined(Nemesis)

{$IfEnd} // Defined(ServerTasks)
end.
