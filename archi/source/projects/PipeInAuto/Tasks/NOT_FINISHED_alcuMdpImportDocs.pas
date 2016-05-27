unit NOT_FINISHED_alcuMdpImportDocs;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuMdpImportDocs.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMdpImportDocs" MUID: (55EEC72501BF)

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
 TalcuMdpImportDocs = class({$If NOT Defined(Nemesis)}
 TcsMdpImportDocs
 {$IfEnd} // NOT Defined(Nemesis)
 )
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
