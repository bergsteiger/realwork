unit NOT_FINISHED_alcuAnnotationTask;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuAnnotationTask.pas"
// Стереотип: "SimpleClass"

{$Include alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , csAnnotationTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuAnnotationTask = class(TcsAnnotationTask)
 end;//TalcuAnnotationTask
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , alcuAnnotationTaskResult
;
{$IfEnd} // Defined(ServerTasks)

end.
