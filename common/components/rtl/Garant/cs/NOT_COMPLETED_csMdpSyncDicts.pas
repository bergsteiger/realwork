unit NOT_COMPLETED_csMdpSyncDicts;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_COMPLETED_csMdpSyncDicts.pas"
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
//#UC START# *16FBD314D238_55E9759603C8get_var*
//#UC END# *16FBD314D238_55E9759603C8get_var*
begin
//#UC START# *16FBD314D238_55E9759603C8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *16FBD314D238_55E9759603C8get_impl*
end;//TcsMdpSyncDicts.pm_GetSyncFolderMask

procedure TcsMdpSyncDicts.pm_SetSyncFolderMask(const aValue: AnsiString);
//#UC START# *16FBD314D238_55E9759603C8set_var*
//#UC END# *16FBD314D238_55E9759603C8set_var*
begin
//#UC START# *16FBD314D238_55E9759603C8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *16FBD314D238_55E9759603C8set_impl*
end;//TcsMdpSyncDicts.pm_SetSyncFolderMask

function TcsMdpSyncDicts.pm_GetGuardName: AnsiString;
//#UC START# *D4FBD6A22E70_55E9759603C8get_var*
//#UC END# *D4FBD6A22E70_55E9759603C8get_var*
begin
//#UC START# *D4FBD6A22E70_55E9759603C8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *D4FBD6A22E70_55E9759603C8get_impl*
end;//TcsMdpSyncDicts.pm_GetGuardName

procedure TcsMdpSyncDicts.pm_SetGuardName(const aValue: AnsiString);
//#UC START# *D4FBD6A22E70_55E9759603C8set_var*
//#UC END# *D4FBD6A22E70_55E9759603C8set_var*
begin
//#UC START# *D4FBD6A22E70_55E9759603C8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *D4FBD6A22E70_55E9759603C8set_impl*
end;//TcsMdpSyncDicts.pm_SetGuardName

function TcsMdpSyncDicts.pm_GetSyncURL: AnsiString;
//#UC START# *9DF75D4438F1_55E9759603C8get_var*
//#UC END# *9DF75D4438F1_55E9759603C8get_var*
begin
//#UC START# *9DF75D4438F1_55E9759603C8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *9DF75D4438F1_55E9759603C8get_impl*
end;//TcsMdpSyncDicts.pm_GetSyncURL

procedure TcsMdpSyncDicts.pm_SetSyncURL(const aValue: AnsiString);
//#UC START# *9DF75D4438F1_55E9759603C8set_var*
//#UC END# *9DF75D4438F1_55E9759603C8set_var*
begin
//#UC START# *9DF75D4438F1_55E9759603C8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *9DF75D4438F1_55E9759603C8set_impl*
end;//TcsMdpSyncDicts.pm_SetSyncURL

function TcsMdpSyncDicts.pm_GetUseProxy: Boolean;
//#UC START# *D92CA5B3B8A7_55E9759603C8get_var*
//#UC END# *D92CA5B3B8A7_55E9759603C8get_var*
begin
//#UC START# *D92CA5B3B8A7_55E9759603C8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *D92CA5B3B8A7_55E9759603C8get_impl*
end;//TcsMdpSyncDicts.pm_GetUseProxy

procedure TcsMdpSyncDicts.pm_SetUseProxy(aValue: Boolean);
//#UC START# *D92CA5B3B8A7_55E9759603C8set_var*
//#UC END# *D92CA5B3B8A7_55E9759603C8set_var*
begin
//#UC START# *D92CA5B3B8A7_55E9759603C8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *D92CA5B3B8A7_55E9759603C8set_impl*
end;//TcsMdpSyncDicts.pm_SetUseProxy

function TcsMdpSyncDicts.pm_GetProxyServer: AnsiString;
//#UC START# *5C6536AC5DA7_55E9759603C8get_var*
//#UC END# *5C6536AC5DA7_55E9759603C8get_var*
begin
//#UC START# *5C6536AC5DA7_55E9759603C8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5C6536AC5DA7_55E9759603C8get_impl*
end;//TcsMdpSyncDicts.pm_GetProxyServer

procedure TcsMdpSyncDicts.pm_SetProxyServer(const aValue: AnsiString);
//#UC START# *5C6536AC5DA7_55E9759603C8set_var*
//#UC END# *5C6536AC5DA7_55E9759603C8set_var*
begin
//#UC START# *5C6536AC5DA7_55E9759603C8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *5C6536AC5DA7_55E9759603C8set_impl*
end;//TcsMdpSyncDicts.pm_SetProxyServer

function TcsMdpSyncDicts.pm_GetProxyPort: Integer;
//#UC START# *57AD1EB5E0FD_55E9759603C8get_var*
//#UC END# *57AD1EB5E0FD_55E9759603C8get_var*
begin
//#UC START# *57AD1EB5E0FD_55E9759603C8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *57AD1EB5E0FD_55E9759603C8get_impl*
end;//TcsMdpSyncDicts.pm_GetProxyPort

procedure TcsMdpSyncDicts.pm_SetProxyPort(aValue: Integer);
//#UC START# *57AD1EB5E0FD_55E9759603C8set_var*
//#UC END# *57AD1EB5E0FD_55E9759603C8set_var*
begin
//#UC START# *57AD1EB5E0FD_55E9759603C8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *57AD1EB5E0FD_55E9759603C8set_impl*
end;//TcsMdpSyncDicts.pm_SetProxyPort

function TcsMdpSyncDicts.pm_GetProxyLogin: AnsiString;
//#UC START# *D6864A19541F_55E9759603C8get_var*
//#UC END# *D6864A19541F_55E9759603C8get_var*
begin
//#UC START# *D6864A19541F_55E9759603C8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *D6864A19541F_55E9759603C8get_impl*
end;//TcsMdpSyncDicts.pm_GetProxyLogin

procedure TcsMdpSyncDicts.pm_SetProxyLogin(const aValue: AnsiString);
//#UC START# *D6864A19541F_55E9759603C8set_var*
//#UC END# *D6864A19541F_55E9759603C8set_var*
begin
//#UC START# *D6864A19541F_55E9759603C8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *D6864A19541F_55E9759603C8set_impl*
end;//TcsMdpSyncDicts.pm_SetProxyLogin

function TcsMdpSyncDicts.pm_GetProxyPassword: AnsiString;
//#UC START# *DF2F64FF9209_55E9759603C8get_var*
//#UC END# *DF2F64FF9209_55E9759603C8get_var*
begin
//#UC START# *DF2F64FF9209_55E9759603C8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *DF2F64FF9209_55E9759603C8get_impl*
end;//TcsMdpSyncDicts.pm_GetProxyPassword

procedure TcsMdpSyncDicts.pm_SetProxyPassword(const aValue: AnsiString);
//#UC START# *DF2F64FF9209_55E9759603C8set_var*
//#UC END# *DF2F64FF9209_55E9759603C8set_var*
begin
//#UC START# *DF2F64FF9209_55E9759603C8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *DF2F64FF9209_55E9759603C8set_impl*
end;//TcsMdpSyncDicts.pm_SetProxyPassword

class function TcsMdpSyncDicts.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_55E9759603C8_var*
//#UC END# *53AC03EE01FD_55E9759603C8_var*
begin
//#UC START# *53AC03EE01FD_55E9759603C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_55E9759603C8_impl*
end;//TcsMdpSyncDicts.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
