unit NOT_COMPLETED_alcuAnnotationTask;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_COMPLETED_alcuAnnotationTask.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuAnnotationTask" MUID: (531705AC001C)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , csAnnotationTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuAnnotationTask = class({$If NOT Defined(Nemesis)}
 TcsAnnotationTask
 {$IfEnd} // NOT Defined(Nemesis)
 )
 end;//TalcuAnnotationTask
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , alcuAnnotationTaskResult
;

{$If NOT Defined(Nemesis)}
{$IfEnd} // NOT Defined(Nemesis)
{$IfEnd} // Defined(ServerTasks)
end.
