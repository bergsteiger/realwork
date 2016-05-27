unit csMdpSyncDicts;

// Модуль: "w:\common\components\rtl\Garant\cs\csMdpSyncDicts.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMdpSyncDicts" MUID: (55E9759603C8)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
;

type
 TcsMdpSyncDicts = class(TddProcessTask)
  protected
   function pm_GetSyncFolderMask: AnsiString;
   procedure pm_SetSyncFolderMask(const aValue: AnsiString);
   function pm_GetGuardName: AnsiString;
   procedure pm_SetGuardName(const aValue: AnsiString);
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
   property SyncFolderMask: AnsiString
    read pm_GetSyncFolderMask
    write pm_SetSyncFolderMask;
   property GuardName: AnsiString
    read pm_GetGuardName
    write pm_SetGuardName;
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
 end;//TcsMdpSyncDicts
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , mdpSyncDicts_Const
;

function TcsMdpSyncDicts.pm_GetSyncFolderMask: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrSyncFolderMask]);
end;//TcsMdpSyncDicts.pm_GetSyncFolderMask

procedure TcsMdpSyncDicts.pm_SetSyncFolderMask(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrSyncFolderMask, nil] := (aValue);
end;//TcsMdpSyncDicts.pm_SetSyncFolderMask

function TcsMdpSyncDicts.pm_GetGuardName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrGuardName]);
end;//TcsMdpSyncDicts.pm_GetGuardName

procedure TcsMdpSyncDicts.pm_SetGuardName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrGuardName, nil] := (aValue);
end;//TcsMdpSyncDicts.pm_SetGuardName

function TcsMdpSyncDicts.pm_GetSyncURL: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrSyncURL]);
end;//TcsMdpSyncDicts.pm_GetSyncURL

procedure TcsMdpSyncDicts.pm_SetSyncURL(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrSyncURL, nil] := (aValue);
end;//TcsMdpSyncDicts.pm_SetSyncURL

function TcsMdpSyncDicts.pm_GetUseProxy: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrUseProxy]);
end;//TcsMdpSyncDicts.pm_GetUseProxy

procedure TcsMdpSyncDicts.pm_SetUseProxy(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrUseProxy, nil] := (aValue);
end;//TcsMdpSyncDicts.pm_SetUseProxy

function TcsMdpSyncDicts.pm_GetProxyServer: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrProxyServer]);
end;//TcsMdpSyncDicts.pm_GetProxyServer

procedure TcsMdpSyncDicts.pm_SetProxyServer(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrProxyServer, nil] := (aValue);
end;//TcsMdpSyncDicts.pm_SetProxyServer

function TcsMdpSyncDicts.pm_GetProxyPort: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrProxyPort]);
end;//TcsMdpSyncDicts.pm_GetProxyPort

procedure TcsMdpSyncDicts.pm_SetProxyPort(aValue: Integer);
begin
 TaggedData.IntW[k2_attrProxyPort, nil] := (aValue);
end;//TcsMdpSyncDicts.pm_SetProxyPort

function TcsMdpSyncDicts.pm_GetProxyLogin: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrProxyLogin]);
end;//TcsMdpSyncDicts.pm_GetProxyLogin

procedure TcsMdpSyncDicts.pm_SetProxyLogin(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrProxyLogin, nil] := (aValue);
end;//TcsMdpSyncDicts.pm_SetProxyLogin

function TcsMdpSyncDicts.pm_GetProxyPassword: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrProxyPassword]);
end;//TcsMdpSyncDicts.pm_GetProxyPassword

procedure TcsMdpSyncDicts.pm_SetProxyPassword(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrProxyPassword, nil] := (aValue);
end;//TcsMdpSyncDicts.pm_SetProxyPassword

class function TcsMdpSyncDicts.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typmdpSyncDicts;
end;//TcsMdpSyncDicts.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
