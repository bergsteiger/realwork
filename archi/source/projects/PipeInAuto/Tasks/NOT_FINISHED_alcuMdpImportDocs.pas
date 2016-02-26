unit NOT_FINISHED_alcuMdpImportDocs;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuMdpImportDocs.pas"
// Стереотип: "SimpleClass"

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
{$IfEnd} // Defined(ServerTasks)

end.
