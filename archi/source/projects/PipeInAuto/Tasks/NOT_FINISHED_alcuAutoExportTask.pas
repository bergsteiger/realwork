unit NOT_FINISHED_alcuAutoExportTask;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuAutoExportTask.pas"
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
 //#UC START# *5317054100F1impl_uses*
 //#UC END# *5317054100F1impl_uses*
;
{$IfEnd} // Defined(ServerTasks)

end.
