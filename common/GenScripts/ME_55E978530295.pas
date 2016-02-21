unit NOT_FINISHED_alcuMdpSyncDicts;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuMdpSyncDicts.pas"
// Стереотип: "SimpleClass"

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
 TalcuMdpSyncDicts = class(TcsMdpSyncDicts)
 end;//TalcuMdpSyncDicts
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(ServerTasks)

end.
