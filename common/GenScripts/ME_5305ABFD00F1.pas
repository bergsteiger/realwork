unit NOT_FINISHED_alcuAnoncedExport;

// ������: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuAnoncedExport.pas"
// ���������: "SimpleClass"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuExport
 , alcuAnoncedExportPrim
;

type
 TalcuAnoncedExport = class(TalcuExportTalcuAnoncedExportPrim)
 end;//TalcuAnoncedExport
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(ServerTasks)

end.
