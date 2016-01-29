unit FTPBrowser_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/FTPBrowser_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::FTPBrowser
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега FTPBrowser .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrServerName: Integer;

function k2_attrPort: Integer;

function k2_attrLogin: Integer;

function k2_attrPassword: Integer;

function k2_attrPassiveMode: Integer;

function k2_attrRemoteFolder: Integer;

function k2_attrLogTitle: Integer;

function k2_typFTPBrowser: FTPBrowserTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_FTPBrowser : FTPBrowserTag = nil;

// start class FTPBrowserTag

function k2_typFTPBrowser: FTPBrowserTag;
begin
 if (g_FTPBrowser = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_FTPBrowser := TevdTasksSchema(Tk2TypeTable.GetInstance).t_FTPBrowser;
 end;//g_FTPBrowser = nil
 Result := g_FTPBrowser;
end;
var
 g_k2_attrServerName: Integer = -1;

function k2_attrServerName: Integer;
begin
 if (g_k2_attrServerName = -1) then
  g_k2_attrServerName :=  Tk2Attributes.Instance.CheckIDByName('ServerName');
 Result := g_k2_attrServerName;
end;

var
 g_k2_attrPort: Integer = -1;

function k2_attrPort: Integer;
begin
 if (g_k2_attrPort = -1) then
  g_k2_attrPort :=  Tk2Attributes.Instance.CheckIDByName('Port');
 Result := g_k2_attrPort;
end;

var
 g_k2_attrLogin: Integer = -1;

function k2_attrLogin: Integer;
begin
 if (g_k2_attrLogin = -1) then
  g_k2_attrLogin :=  Tk2Attributes.Instance.CheckIDByName('Login');
 Result := g_k2_attrLogin;
end;

var
 g_k2_attrPassword: Integer = -1;

function k2_attrPassword: Integer;
begin
 if (g_k2_attrPassword = -1) then
  g_k2_attrPassword :=  Tk2Attributes.Instance.CheckIDByName('Password');
 Result := g_k2_attrPassword;
end;

var
 g_k2_attrPassiveMode: Integer = -1;

function k2_attrPassiveMode: Integer;
begin
 if (g_k2_attrPassiveMode = -1) then
  g_k2_attrPassiveMode :=  Tk2Attributes.Instance.CheckIDByName('PassiveMode');
 Result := g_k2_attrPassiveMode;
end;

var
 g_k2_attrRemoteFolder: Integer = -1;

function k2_attrRemoteFolder: Integer;
begin
 if (g_k2_attrRemoteFolder = -1) then
  g_k2_attrRemoteFolder :=  Tk2Attributes.Instance.CheckIDByName('RemoteFolder');
 Result := g_k2_attrRemoteFolder;
end;

var
 g_k2_attrLogTitle: Integer = -1;

function k2_attrLogTitle: Integer;
begin
 if (g_k2_attrLogTitle = -1) then
  g_k2_attrLogTitle :=  Tk2Attributes.Instance.CheckIDByName('LogTitle');
 Result := g_k2_attrLogTitle;
end;


end.