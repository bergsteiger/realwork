unit NOT_FINISHED_alcuRegionAutoExportTask;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuRegionAutoExportTask.pas"
// Стереотип: "SimpleClass"

{$Include alcuDefine.inc}

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
;
{$IfEnd} // Defined(ServerTasks)

end.
