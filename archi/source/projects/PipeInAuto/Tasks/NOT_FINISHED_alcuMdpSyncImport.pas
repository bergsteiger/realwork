unit NOT_FINISHED_alcuMdpSyncImport;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuMdpSyncImport.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMdpSyncImport" MUID: (574C213703E2)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , csMdpSyncImport
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuMdpSyncImport = class({$If NOT Defined(Nemesis)}
 TcsMdpSyncImport
 {$IfEnd} // NOT Defined(Nemesis)
 )
 end;//TalcuMdpSyncImport
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , alcuMdpSyncParamUtils
 , alcuMdpImportSyncronizer
 //#UC START# *574C213703E2impl_uses*
 //#UC END# *574C213703E2impl_uses*
;

{$If NOT Defined(Nemesis)}
{$IfEnd} // NOT Defined(Nemesis)
{$IfEnd} // Defined(ServerTasks)
end.
