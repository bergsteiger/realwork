unit NOT_FINISHED_alcuAACImport;

// ������: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuAACImport.pas"
// ���������: "SimpleClass"
// ������� ������: "TalcuAACImport" MUID: (53E48B8D038E)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks) AND Defined(AAC)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , csAACImport
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuAACImport = class({$If NOT Defined(Nemesis)}
 TcsAACImport
 {$IfEnd} // NOT Defined(Nemesis)
 )
 end;//TalcuAACImport
{$IfEnd} // Defined(ServerTasks) AND Defined(AAC)

implementation

{$If Defined(ServerTasks) AND Defined(AAC)}
uses
 l3ImplUses
 , alcuAACImportTaskResult
;

{$If NOT Defined(Nemesis)}
{$IfEnd} // NOT Defined(Nemesis)
{$IfEnd} // Defined(ServerTasks) AND Defined(AAC)
end.
