unit NOT_FINISHED_alcuAutoPipeServer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Server"
// Модуль: "w:/archi/source/projects/PipeInAuto/Server/NOT_FINISHED_alcuAutoPipeServer.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$AutoPipeServer$Garant::Server::Server::alcuAutoPipeServer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide)}
uses
  l3ProtoObject,
  alcuBaseEngineHolder
  {$If defined(AppServerSide) AND defined(MDPSyncIntegrated)}
  ,
  alcuDictChangeMDPSynchronizator
  {$IfEnd} //AppServerSide AND MDPSyncIntegrated
  
  {$If defined(AppServerSide) AND defined(MDPSyncIntegrated)}
  ,
  alcuMdpDocImporter
  {$IfEnd} //AppServerSide AND MDPSyncIntegrated
  
  ;

type
 TalcuServerPrim = class(Tl3ProtoObject)
 private
 // private fields
   f_DictWatcher : TalcuDictChangeMDPSynchronizator;
   f_BaseEngineHolder : TalcuBaseEngineHolder;
   f_MdpDocImporter : TalcuMdpDocImporter;
 end;//TalcuServerPrim
{$IfEnd} //AppServerSide

implementation

{$If defined(AppServerSide)}
uses
  alcuServerTaskManagerFactory
  ;

{$IfEnd} //AppServerSide
end.