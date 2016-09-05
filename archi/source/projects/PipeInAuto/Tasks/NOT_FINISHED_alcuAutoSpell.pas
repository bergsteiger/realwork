unit NOT_FINISHED_alcuAutoSpell;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuAutoSpell.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "alcuAutoSpell" MUID: (53FD8188018E)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , csAutoSpell
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuAutoSpellTask = class({$If NOT Defined(Nemesis)}
 TcsAutoSpellTask
 {$IfEnd} // NOT Defined(Nemesis)
 )
 end;//TalcuAutoSpellTask
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , alcuAutoSpellTaskResult
 //#UC START# *53FD8188018Eimpl_uses*
 //#UC END# *53FD8188018Eimpl_uses*
;
{$IfEnd} // Defined(ServerTasks)

end.
