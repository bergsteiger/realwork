unit NOT_FINISHED_ddCaseCodeMaker;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_ddCaseCodeMaker.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddCaseCodeMaker" MUID: (5305A7410332)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , ddCaseCodeTaskPrim
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TddCaseCodeTask = class(TddCaseCodeTaskPrim)
 end;//TddCaseCodeTask
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(ServerTasks)

end.
