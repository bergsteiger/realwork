unit NOT_FINISHED_alcuRegionImportTask;

// ������: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuRegionImportTask.pas"
// ���������: "SimpleClass"

{$Include alcuDefine.inc}

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
;
{$IfEnd} // Defined(ServerTasks)

end.
