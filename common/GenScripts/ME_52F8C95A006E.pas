unit NOT_FINISHED_alcuAutoPipeServer;

// Модуль: "w:\archi\source\projects\PipeInAuto\Server\NOT_FINISHED_alcuAutoPipeServer.pas"
// Стереотип: "UtilityPack"

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
;
{$IfEnd} // Defined(AppServerSide)

end.
