unit NOT_FINISHED_alcuHavanskyExportTask;

// ������: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuHavanskyExportTask.pas"
// ���������: "SimpleClass"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 {$If Defined(HavanskyExport)}
 , alcuHavanskyExportTaskPrim
 {$IfEnd} // Defined(HavanskyExport)
;

type
 TalcuHavanskyExportTask = class(TalcuHavanskyExportTaskPrim)
 end;//TalcuHavanskyExportTask
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
;

{$If Defined(HavanskyExport)}
{$IfEnd} // Defined(HavanskyExport)
{$IfEnd} // Defined(ServerTasks)
end.
