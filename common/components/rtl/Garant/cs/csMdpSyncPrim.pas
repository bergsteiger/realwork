unit csMdpSyncPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csMdpSyncPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMdpSyncPrim" MUID: (574C16470035)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
;

type
 TcsMdpSyncPrim = class(TddProcessTask)
  protected
   function pm_GetSyncURL: AnsiString;
   procedure pm_SetSyncURL(const aValue: AnsiString);
   function pm_GetUseProxy: Boolean;
   procedure pm_SetUseProxy(aValue: Boolean);
   function pm_GetProxyServer: AnsiString;
   procedure pm_SetProxyServer(const aValue: AnsiString);
   function pm_GetProxyPort: Integer;
   procedure pm_SetProxyPort(aValue: Integer);
   function pm_GetProxyLogin: AnsiString;
   procedure pm_SetProxyLogin(const aValue: AnsiString);
   function pm_GetProxyPassword: AnsiString;
   procedure pm_SetProxyPassword(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property SyncURL: AnsiString
    read pm_GetSyncURL
    write pm_SetSyncURL;
   property UseProxy: Boolean
    read pm_GetUseProxy
    write pm_SetUseProxy;
   property ProxyServer: AnsiString
    read pm_GetProxyServer
    write pm_SetProxyServer;
   property ProxyPort: Integer
    read pm_GetProxyPort
    write pm_SetProxyPort;
   property ProxyLogin: AnsiString
    read pm_GetProxyLogin
    write pm_SetProxyLogin;
   property ProxyPassword: AnsiString
    read pm_GetProxyPassword
    write pm_SetProxyPassword;
 end;//TcsMdpSyncPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , mdpSync_Const
;

function TcsMdpSyncPrim.pm_GetSyncURL: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrSyncURL]);
end;//TcsMdpSyncPrim.pm_GetSyncURL

procedure TcsMdpSyncPrim.pm_SetSyncURL(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrSyncURL, nil] := (aValue);
end;//TcsMdpSyncPrim.pm_SetSyncURL

function TcsMdpSyncPrim.pm_GetUseProxy: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrUseProxy]);
end;//TcsMdpSyncPrim.pm_GetUseProxy

procedure TcsMdpSyncPrim.pm_SetUseProxy(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrUseProxy, nil] := (aValue);
end;//TcsMdpSyncPrim.pm_SetUseProxy

function TcsMdpSyncPrim.pm_GetProxyServer: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrProxyServer]);
end;//TcsMdpSyncPrim.pm_GetProxyServer

procedure TcsMdpSyncPrim.pm_SetProxyServer(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrProxyServer, nil] := (aValue);
end;//TcsMdpSyncPrim.pm_SetProxyServer

function TcsMdpSyncPrim.pm_GetProxyPort: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrProxyPort]);
end;//TcsMdpSyncPrim.pm_GetProxyPort

procedure TcsMdpSyncPrim.pm_SetProxyPort(aValue: Integer);
begin
 TaggedData.IntW[k2_attrProxyPort, nil] := (aValue);
end;//TcsMdpSyncPrim.pm_SetProxyPort

function TcsMdpSyncPrim.pm_GetProxyLogin: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrProxyLogin]);
end;//TcsMdpSyncPrim.pm_GetProxyLogin

procedure TcsMdpSyncPrim.pm_SetProxyLogin(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrProxyLogin, nil] := (aValue);
end;//TcsMdpSyncPrim.pm_SetProxyLogin

function TcsMdpSyncPrim.pm_GetProxyPassword: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrProxyPassword]);
end;//TcsMdpSyncPrim.pm_GetProxyPassword

procedure TcsMdpSyncPrim.pm_SetProxyPassword(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrProxyPassword, nil] := (aValue);
end;//TcsMdpSyncPrim.pm_SetProxyPassword

class function TcsMdpSyncPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typmdpSync;
end;//TcsMdpSyncPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
