unit csMdpSyncStages;

// Модуль: "w:\common\components\rtl\Garant\cs\csMdpSyncStages.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMdpSyncStages" MUID: (573D91050026)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
;

type
 TcsMdpSyncStages = class(TddProcessTask)
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
 end;//TcsMdpSyncStages
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , mdpSyncStages_Const
;

function TcsMdpSyncStages.pm_GetSyncURL: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrSyncURL]);
end;//TcsMdpSyncStages.pm_GetSyncURL

procedure TcsMdpSyncStages.pm_SetSyncURL(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrSyncURL, nil] := (aValue);
end;//TcsMdpSyncStages.pm_SetSyncURL

function TcsMdpSyncStages.pm_GetUseProxy: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrUseProxy]);
end;//TcsMdpSyncStages.pm_GetUseProxy

procedure TcsMdpSyncStages.pm_SetUseProxy(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrUseProxy, nil] := (aValue);
end;//TcsMdpSyncStages.pm_SetUseProxy

function TcsMdpSyncStages.pm_GetProxyServer: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrProxyServer]);
end;//TcsMdpSyncStages.pm_GetProxyServer

procedure TcsMdpSyncStages.pm_SetProxyServer(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrProxyServer, nil] := (aValue);
end;//TcsMdpSyncStages.pm_SetProxyServer

function TcsMdpSyncStages.pm_GetProxyPort: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrProxyPort]);
end;//TcsMdpSyncStages.pm_GetProxyPort

procedure TcsMdpSyncStages.pm_SetProxyPort(aValue: Integer);
begin
 TaggedData.IntW[k2_attrProxyPort, nil] := (aValue);
end;//TcsMdpSyncStages.pm_SetProxyPort

function TcsMdpSyncStages.pm_GetProxyLogin: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrProxyLogin]);
end;//TcsMdpSyncStages.pm_GetProxyLogin

procedure TcsMdpSyncStages.pm_SetProxyLogin(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrProxyLogin, nil] := (aValue);
end;//TcsMdpSyncStages.pm_SetProxyLogin

function TcsMdpSyncStages.pm_GetProxyPassword: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrProxyPassword]);
end;//TcsMdpSyncStages.pm_GetProxyPassword

procedure TcsMdpSyncStages.pm_SetProxyPassword(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrProxyPassword, nil] := (aValue);
end;//TcsMdpSyncStages.pm_SetProxyPassword

class function TcsMdpSyncStages.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typmdpSyncStages;
end;//TcsMdpSyncStages.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
