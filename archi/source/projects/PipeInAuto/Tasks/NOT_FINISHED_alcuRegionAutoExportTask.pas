unit NOT_FINISHED_alcuRegionAutoExportTask;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuRegionAutoExportTask.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuRegionAutoExportTask" MUID: (5404675C01D2)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuRegionAutoExportTaskPrim
;

type
 TalcuRegionAutoExportTask = class(TalcuRegionAutoExportTaskPrim)
 end;//TalcuRegionAutoExportTask
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , alcuFTPBrowser
 , alcuFTPBrowserParams
 //#UC START# *5404675C01D2impl_uses*
 //#UC END# *5404675C01D2impl_uses*
;
{$IfEnd} // Defined(ServerTasks)

end.
