unit NOT_COMPLETED_alcuAutoExportTask;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_COMPLETED_alcuAutoExportTask.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuAutoExportTask" MUID: (5317054100F1)

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
