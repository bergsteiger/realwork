unit NOT_FINISHED_alcuRelCorrector;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuRelCorrector.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "alcuRelCorrector" MUID: (530356D90066)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , csImport
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuRelPublishTask = class(TcsImportTaskItem)
 end;//TalcuRelPublishTask
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , alcuRelPublishTaskResult
;
{$IfEnd} // Defined(ServerTasks)

end.
