unit NOT_FINISHED_alcuAutoSpell;

// ������: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuAutoSpell.pas"
// ���������: "UtilityPack"
// ������� ������: "alcuAutoSpell" MUID: (53FD8188018E)

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
;
{$IfEnd} // Defined(ServerTasks)

end.
