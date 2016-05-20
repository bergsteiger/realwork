unit NOT_COMPLETED_alcuMdpSyncStages;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_COMPLETED_alcuMdpSyncStages.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMdpSyncStages" MUID: (573D9F0A01BB)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , csMdpSyncStages
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuMdpSyncStages = class({$If NOT Defined(Nemesis)}
 TcsMdpSyncStages
 {$IfEnd} // NOT Defined(Nemesis)
 )
 end;//TalcuMdpSyncStages
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
