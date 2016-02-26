unit NOT_FINISHED_alcuAutoExportTask;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuAutoExportTask.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuAutoExportTaskPrim
;

type
 TalcuAutoExportTask = class(TalcuAutoExportTaskPrim)
 end;//TalcuAutoExportTask
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , alcuAutoExportTaskResult
;
{$IfEnd} // Defined(ServerTasks)

end.
