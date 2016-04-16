unit NOT_COMPLETED_alcuMdpSyncDicts;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_COMPLETED_alcuMdpSyncDicts.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMdpSyncDicts" MUID: (55E978530295)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , csMdpSyncDicts
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuMdpSyncDicts = class({$If NOT Defined(Nemesis)}
 TcsMdpSyncDicts
 {$IfEnd} // NOT Defined(Nemesis)
 )
 end;//TalcuMdpSyncDicts
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
