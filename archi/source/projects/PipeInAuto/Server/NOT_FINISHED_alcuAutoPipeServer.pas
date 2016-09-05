unit NOT_FINISHED_alcuAutoPipeServer;

// ������: "w:\archi\source\projects\PipeInAuto\Server\NOT_FINISHED_alcuAutoPipeServer.pas"
// ���������: "UtilityPack"
// ������� ������: "alcuAutoPipeServer" MUID: (52F8C95A006E)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
 , l3ProtoObject
 {$If Defined(MDPSyncIntegrated)}
 , alcuDictChangeMDPSynchronizator
 {$IfEnd} // Defined(MDPSyncIntegrated)
 , alcuBaseEngineHolder
 {$If Defined(MDPSyncIntegrated)}
 , alcuMdpDocImporter
 {$IfEnd} // Defined(MDPSyncIntegrated)
;

type
 TalcuServerPrim = class(Tl3ProtoObject)
  private
   f_DictWatcher: TalcuDictChangeMDPSynchronizator;
   f_BaseEngineHolder: TalcuBaseEngineHolder;
   f_MdpDocImporter: TalcuMdpDocImporter;
 end;//TalcuServerPrim
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
 , alcuServerTaskManagerFactory
 {$If Defined(ServerTasks)}
 , alcuMdpSyncStages
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuMdpSyncImport
 {$IfEnd} // Defined(ServerTasks)
 //#UC START# *52F8C95A006Eimpl_uses*
 //#UC END# *52F8C95A006Eimpl_uses*
;
{$IfEnd} // Defined(AppServerSide)

end.
