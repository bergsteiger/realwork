unit NOT_COMPLETED_alcuAnoncedExport;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_COMPLETED_alcuAnoncedExport.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuAnoncedExport" MUID: (5305ABFD00F1)

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
