unit NOT_COMPLETED_csMdpSyncStages;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_COMPLETED_csMdpSyncStages.pas"
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
//#UC START# *CC118E08EE6E_573D91050026get_var*
//#UC END# *CC118E08EE6E_573D91050026get_var*
begin
//#UC START# *CC118E08EE6E_573D91050026get_impl*
 !!! Needs to be implemented !!!
//#UC END# *CC118E08EE6E_573D91050026get_impl*
end;//TcsMdpSyncStages.pm_GetSyncURL

procedure TcsMdpSyncStages.pm_SetSyncURL(const aValue: AnsiString);
//#UC START# *CC118E08EE6E_573D91050026set_var*
//#UC END# *CC118E08EE6E_573D91050026set_var*
begin
//#UC START# *CC118E08EE6E_573D91050026set_impl*
 !!! Needs to be implemented !!!
//#UC END# *CC118E08EE6E_573D91050026set_impl*
end;//TcsMdpSyncStages.pm_SetSyncURL

function TcsMdpSyncStages.pm_GetUseProxy: Boolean;
//#UC START# *208CD8F25DD2_573D91050026get_var*
//#UC END# *208CD8F25DD2_573D91050026get_var*
begin
//#UC START# *208CD8F25DD2_573D91050026get_impl*
 !!! Needs to be implemented !!!
//#UC END# *208CD8F25DD2_573D91050026get_impl*
end;//TcsMdpSyncStages.pm_GetUseProxy

procedure TcsMdpSyncStages.pm_SetUseProxy(aValue: Boolean);
//#UC START# *208CD8F25DD2_573D91050026set_var*
//#UC END# *208CD8F25DD2_573D91050026set_var*
begin
//#UC START# *208CD8F25DD2_573D91050026set_impl*
 !!! Needs to be implemented !!!
//#UC END# *208CD8F25DD2_573D91050026set_impl*
end;//TcsMdpSyncStages.pm_SetUseProxy

function TcsMdpSyncStages.pm_GetProxyServer: AnsiString;
//#UC START# *DA8AD1F82E27_573D91050026get_var*
//#UC END# *DA8AD1F82E27_573D91050026get_var*
begin
//#UC START# *DA8AD1F82E27_573D91050026get_impl*
 !!! Needs to be implemented !!!
//#UC END# *DA8AD1F82E27_573D91050026get_impl*
end;//TcsMdpSyncStages.pm_GetProxyServer

procedure TcsMdpSyncStages.pm_SetProxyServer(const aValue: AnsiString);
//#UC START# *DA8AD1F82E27_573D91050026set_var*
//#UC END# *DA8AD1F82E27_573D91050026set_var*
begin
//#UC START# *DA8AD1F82E27_573D91050026set_impl*
 !!! Needs to be implemented !!!
//#UC END# *DA8AD1F82E27_573D91050026set_impl*
end;//TcsMdpSyncStages.pm_SetProxyServer

function TcsMdpSyncStages.pm_GetProxyPort: Integer;
//#UC START# *E08132B9D011_573D91050026get_var*
//#UC END# *E08132B9D011_573D91050026get_var*
begin
//#UC START# *E08132B9D011_573D91050026get_impl*
 !!! Needs to be implemented !!!
//#UC END# *E08132B9D011_573D91050026get_impl*
end;//TcsMdpSyncStages.pm_GetProxyPort

procedure TcsMdpSyncStages.pm_SetProxyPort(aValue: Integer);
//#UC START# *E08132B9D011_573D91050026set_var*
//#UC END# *E08132B9D011_573D91050026set_var*
begin
//#UC START# *E08132B9D011_573D91050026set_impl*
 !!! Needs to be implemented !!!
//#UC END# *E08132B9D011_573D91050026set_impl*
end;//TcsMdpSyncStages.pm_SetProxyPort

function TcsMdpSyncStages.pm_GetProxyLogin: AnsiString;
//#UC START# *37A4D4235A07_573D91050026get_var*
//#UC END# *37A4D4235A07_573D91050026get_var*
begin
//#UC START# *37A4D4235A07_573D91050026get_impl*
 !!! Needs to be implemented !!!
//#UC END# *37A4D4235A07_573D91050026get_impl*
end;//TcsMdpSyncStages.pm_GetProxyLogin

procedure TcsMdpSyncStages.pm_SetProxyLogin(const aValue: AnsiString);
//#UC START# *37A4D4235A07_573D91050026set_var*
//#UC END# *37A4D4235A07_573D91050026set_var*
begin
//#UC START# *37A4D4235A07_573D91050026set_impl*
 !!! Needs to be implemented !!!
//#UC END# *37A4D4235A07_573D91050026set_impl*
end;//TcsMdpSyncStages.pm_SetProxyLogin

function TcsMdpSyncStages.pm_GetProxyPassword: AnsiString;
//#UC START# *2F88442EEF51_573D91050026get_var*
//#UC END# *2F88442EEF51_573D91050026get_var*
begin
//#UC START# *2F88442EEF51_573D91050026get_impl*
 !!! Needs to be implemented !!!
//#UC END# *2F88442EEF51_573D91050026get_impl*
end;//TcsMdpSyncStages.pm_GetProxyPassword

procedure TcsMdpSyncStages.pm_SetProxyPassword(const aValue: AnsiString);
//#UC START# *2F88442EEF51_573D91050026set_var*
//#UC END# *2F88442EEF51_573D91050026set_var*
begin
//#UC START# *2F88442EEF51_573D91050026set_impl*
 !!! Needs to be implemented !!!
//#UC END# *2F88442EEF51_573D91050026set_impl*
end;//TcsMdpSyncStages.pm_SetProxyPassword

class function TcsMdpSyncStages.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_573D91050026_var*
//#UC END# *53AC03EE01FD_573D91050026_var*
begin
//#UC START# *53AC03EE01FD_573D91050026_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_573D91050026_impl*
end;//TcsMdpSyncStages.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
