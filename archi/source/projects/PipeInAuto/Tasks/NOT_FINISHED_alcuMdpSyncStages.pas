unit NOT_FINISHED_alcuMdpSyncStages;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuMdpSyncStages.pas"
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
 , alcuMdpSyncParamUtils
 , alcuMdpStagesSyncronizer
 //#UC START# *573D9F0A01BBimpl_uses*
 //#UC END# *573D9F0A01BBimpl_uses*
;

{$If NOT Defined(Nemesis)}
{$IfEnd} // NOT Defined(Nemesis)
{$IfEnd} // Defined(ServerTasks)
end.
