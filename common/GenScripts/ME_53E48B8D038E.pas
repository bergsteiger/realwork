unit NOT_FINISHED_alcuAACImport;

// ������: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuAACImport.pas"
// ���������: "SimpleClass"

{$Include alcuDefine.inc}

interface

{$If Defined(ServerTasks) AND Defined(AAC)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , csAACImport
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuAACImport = class(TcsAACImport)
 end;//TalcuAACImport
{$IfEnd} // Defined(ServerTasks) AND Defined(AAC)

implementation

{$If Defined(ServerTasks) AND Defined(AAC)}
uses
 l3ImplUses
 , alcuAACImportTaskResult
;
{$IfEnd} // Defined(ServerTasks) AND Defined(AAC)

end.
