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
 TalcuRelPublishTask = class({$If NOT Defined(Nemesis)}
 TcsImportTaskItem
 {$IfEnd} // NOT Defined(Nemesis)
 )
 end;//TalcuRelPublishTask
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , alcuRelPublishTaskResult
 //#UC START# *530356D90066impl_uses*
 //#UC END# *530356D90066impl_uses*
;
{$IfEnd} // Defined(ServerTasks)

end.
