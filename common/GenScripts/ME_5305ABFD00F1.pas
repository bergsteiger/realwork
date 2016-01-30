unit NOT_FINISHED_alcuAnoncedExport;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuAnoncedExport.pas"
// Стереотип: "SimpleClass"

{$Include alcuDefine.inc}

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
