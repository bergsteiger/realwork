unit alcuMdpSyncParamUtils;

{ $Id: alcuMdpSyncParamUtils.pas,v 1.1 2016/05/30 12:14:56 fireton Exp $ }

interface

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

{$If defined(AppServerSide)}
uses
 csMdpSyncPrim;

procedure SetupMdpSyncParams(const aSync: TcsMdpSyncPrim);

{$IfEnd defined(AppServerSide)}

implementation

{$If defined(AppServerSide)}
uses
 ddAppConfig;

procedure SetupMdpSyncParams(const aSync: TcsMdpSyncPrim);
begin
 with ddAppConfiguration do
 begin
  aSync.SyncURL := asString['dsURL'];
  aSync.UseProxy := asBoolean['dsUseProxy'];
  aSync.ProxyServer := asString['dsProxyServer'];
  aSync.ProxyPort := asInteger['dsProxyPort'];
  aSync.ProxyLogin := asString['dsProxyLogin'];
  aSync.ProxyPassword := asString['dsProxyPassword'];
 end;
end;

{$IfEnd defined(AppServerSide)}

end.