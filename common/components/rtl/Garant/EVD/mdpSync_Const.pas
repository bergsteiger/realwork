unit mdpSync_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/mdpSync_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::mdpSync
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега mdpSync .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrSyncURL: Integer;

function k2_attrUseProxy: Integer;

function k2_attrProxyServer: Integer;

function k2_attrProxyPort: Integer;

function k2_attrProxyLogin: Integer;

function k2_attrProxyPassword: Integer;

function k2_typmdpSync: mdpSyncTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_mdpSync : mdpSyncTag = nil;

// start class mdpSyncTag

function k2_typmdpSync: mdpSyncTag;
begin
 if (g_mdpSync = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_mdpSync := TevdTasksSchema(Tk2TypeTable.GetInstance).t_mdpSync;
 end;//g_mdpSync = nil
 Result := g_mdpSync;
end;
var
 g_k2_attrSyncURL: Integer = -1;

function k2_attrSyncURL: Integer;
begin
 if (g_k2_attrSyncURL = -1) then
  g_k2_attrSyncURL :=  Tk2Attributes.Instance.CheckIDByName('SyncURL');
 Result := g_k2_attrSyncURL;
end;

var
 g_k2_attrUseProxy: Integer = -1;

function k2_attrUseProxy: Integer;
begin
 if (g_k2_attrUseProxy = -1) then
  g_k2_attrUseProxy :=  Tk2Attributes.Instance.CheckIDByName('UseProxy');
 Result := g_k2_attrUseProxy;
end;

var
 g_k2_attrProxyServer: Integer = -1;

function k2_attrProxyServer: Integer;
begin
 if (g_k2_attrProxyServer = -1) then
  g_k2_attrProxyServer :=  Tk2Attributes.Instance.CheckIDByName('ProxyServer');
 Result := g_k2_attrProxyServer;
end;

var
 g_k2_attrProxyPort: Integer = -1;

function k2_attrProxyPort: Integer;
begin
 if (g_k2_attrProxyPort = -1) then
  g_k2_attrProxyPort :=  Tk2Attributes.Instance.CheckIDByName('ProxyPort');
 Result := g_k2_attrProxyPort;
end;

var
 g_k2_attrProxyLogin: Integer = -1;

function k2_attrProxyLogin: Integer;
begin
 if (g_k2_attrProxyLogin = -1) then
  g_k2_attrProxyLogin :=  Tk2Attributes.Instance.CheckIDByName('ProxyLogin');
 Result := g_k2_attrProxyLogin;
end;

var
 g_k2_attrProxyPassword: Integer = -1;

function k2_attrProxyPassword: Integer;
begin
 if (g_k2_attrProxyPassword = -1) then
  g_k2_attrProxyPassword :=  Tk2Attributes.Instance.CheckIDByName('ProxyPassword');
 Result := g_k2_attrProxyPassword;
end;


end.