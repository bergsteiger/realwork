unit NOT_COMPLETED_alcuExport;

// ������: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_COMPLETED_alcuExport.pas"
// ���������: "SimpleClass"
// ������� ������: "TalcuExport" MUID: (530355800106)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , csExport
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuExport = class(TcsExport)
 end;//TalcuExport
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
;

{$If NOT Defined(Nemesis)}
{$IfEnd} // NOT Defined(Nemesis)
{$IfEnd} // Defined(ServerTasks)
end.
