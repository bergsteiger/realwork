unit csLogin_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csLogin_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csLogin
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csLogin .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrServerHost: Integer;

function k2_attrLogin: Integer;

function k2_attrPassword: Integer;

function k2_attrServerPort: Integer;

function k2_typcsLogin: csLoginTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csLogin : csLoginTag = nil;

// start class csLoginTag

function k2_typcsLogin: csLoginTag;
begin
 if (g_csLogin = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csLogin := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csLogin;
 end;//g_csLogin = nil
 Result := g_csLogin;
end;
var
 g_k2_attrServerHost: Integer = -1;

function k2_attrServerHost: Integer;
begin
 if (g_k2_attrServerHost = -1) then
  g_k2_attrServerHost :=  Tk2Attributes.Instance.CheckIDByName('ServerHost');
 Result := g_k2_attrServerHost;
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
 g_k2_attrServerPort: Integer = -1;

function k2_attrServerPort: Integer;
begin
 if (g_k2_attrServerPort = -1) then
  g_k2_attrServerPort :=  Tk2Attributes.Instance.CheckIDByName('ServerPort');
 Result := g_k2_attrServerPort;
end;


end.