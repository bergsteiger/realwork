unit NOT_FINISHED_alcuAutoSpell;

// ������: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuAutoSpell.pas"
// ���������: "UtilityPack"

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
 TalcuAutoSpellTask = class(TcsAutoSpellTask)
 end;//TalcuAutoSpellTask
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , alcuAutoSpellTaskResult
;
{$IfEnd} // Defined(ServerTasks)

end.
