unit NOT_COMPLETED_alcuMdpImportDocs;

// ������: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_COMPLETED_alcuMdpImportDocs.pas"
// ���������: "SimpleClass"
// ������� ������: "TalcuMdpImportDocs" MUID: (55EEC72501BF)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , csMdpImportDocs
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuMdpImportDocs = class(TcsMdpImportDocs)
 end;//TalcuMdpImportDocs
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
