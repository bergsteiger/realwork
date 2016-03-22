unit mdpSyncDicts_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/mdpSyncDicts_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::mdpSyncDicts
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега mdpSyncDicts .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrSyncFolderMask: Integer;

function k2_attrGuardName: Integer;

function k2_attrSyncURL: Integer;

function k2_attrUseProxy: Integer;

function k2_attrProxyServer: Integer;

function k2_attrProxyPort: Integer;

function k2_attrProxyLogin: Integer;

function k2_attrProxyPassword: Integer;

function k2_typmdpSyncDicts: mdpSyncDictsTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_mdpSyncDicts : mdpSyncDictsTag = nil;

// start class mdpSyncDictsTag

function k2_typmdpSyncDicts: mdpSyncDictsTag;
begin
 if (g_mdpSyncDicts = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_mdpSyncDicts := TevdTasksSchema(Tk2TypeTable.GetInstance).t_mdpSyncDicts;
 end;//g_mdpSyncDicts = nil
 Result := g_mdpSyncDicts;
end;
var
 g_k2_attrSyncFolderMask: Integer = -1;

function k2_attrSyncFolderMask: Integer;
begin
 if (g_k2_attrSyncFolderMask = -1) then
  g_k2_attrSyncFolderMask :=  Tk2Attributes.Instance.CheckIDByName('SyncFolderMask');
 Result := g_k2_attrSyncFolderMask;
end;

var
 g_k2_attrGuardName: Integer = -1;

function k2_attrGuardName: Integer;
begin
 if (g_k2_attrGuardName = -1) then
  g_k2_attrGuardName :=  Tk2Attributes.Instance.CheckIDByName('GuardName');
 Result := g_k2_attrGuardName;
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