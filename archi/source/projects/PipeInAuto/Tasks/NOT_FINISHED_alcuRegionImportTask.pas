unit NOT_FINISHED_alcuRegionImportTask;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuRegionImportTask.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuRegionImportTask" MUID: (540867560194)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuRegionImportTaskPrim
;

type
 TalcuRegionImportTask = class(TalcuRegionImportTaskPrim)
 end;//TalcuRegionImportTask
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , alcuRegionImportTaskResult
 //#UC START# *540867560194impl_uses*
 //#UC END# *540867560194impl_uses*
;
{$IfEnd} // Defined(ServerTasks)

end.
