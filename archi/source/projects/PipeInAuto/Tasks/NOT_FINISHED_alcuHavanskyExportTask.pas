unit NOT_FINISHED_alcuHavanskyExportTask;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuHavanskyExportTask.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuHavanskyExportTask" MUID: (530355CF0057)

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
 TalcuHavanskyExportTask = class({$If Defined(HavanskyExport)}
 TalcuHavanskyExportTaskPrim
 {$IfEnd} // Defined(HavanskyExport)
 )
 end;//TalcuHavanskyExportTask
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 //#UC START# *530355CF0057impl_uses*
 //#UC END# *530355CF0057impl_uses*
;

{$If Defined(HavanskyExport)}
{$IfEnd} // Defined(HavanskyExport)
{$IfEnd} // Defined(ServerTasks)
end.
