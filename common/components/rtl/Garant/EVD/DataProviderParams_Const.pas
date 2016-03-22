unit DataProviderParams_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/DataProviderParams_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::DataProviderParams
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега DataProviderParams .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrLogin: Integer;

function k2_attrPassword: Integer;

function k2_attrDocStoragePath: Integer;

function k2_attrDocImagePath: Integer;

function k2_attrHomeDirPath: Integer;

function k2_attrDocBaseVersion: Integer;

function k2_attrAdminBaseVersion: Integer;

function k2_typDataProviderParams: DataProviderParamsTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DataProviderParams : DataProviderParamsTag = nil;

// start class DataProviderParamsTag

function k2_typDataProviderParams: DataProviderParamsTag;
begin
 if (g_DataProviderParams = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_DataProviderParams := TevdTasksSchema(Tk2TypeTable.GetInstance).t_DataProviderParams;
 end;//g_DataProviderParams = nil
 Result := g_DataProviderParams;
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
 g_k2_attrDocStoragePath: Integer = -1;

function k2_attrDocStoragePath: Integer;
begin
 if (g_k2_attrDocStoragePath = -1) then
  g_k2_attrDocStoragePath :=  Tk2Attributes.Instance.CheckIDByName('DocStoragePath');
 Result := g_k2_attrDocStoragePath;
end;

var
 g_k2_attrDocImagePath: Integer = -1;

function k2_attrDocImagePath: Integer;
begin
 if (g_k2_attrDocImagePath = -1) then
  g_k2_attrDocImagePath :=  Tk2Attributes.Instance.CheckIDByName('DocImagePath');
 Result := g_k2_attrDocImagePath;
end;

var
 g_k2_attrHomeDirPath: Integer = -1;

function k2_attrHomeDirPath: Integer;
begin
 if (g_k2_attrHomeDirPath = -1) then
  g_k2_attrHomeDirPath :=  Tk2Attributes.Instance.CheckIDByName('HomeDirPath');
 Result := g_k2_attrHomeDirPath;
end;

var
 g_k2_attrDocBaseVersion: Integer = -1;

function k2_attrDocBaseVersion: Integer;
begin
 if (g_k2_attrDocBaseVersion = -1) then
  g_k2_attrDocBaseVersion :=  Tk2Attributes.Instance.CheckIDByName('DocBaseVersion');
 Result := g_k2_attrDocBaseVersion;
end;

var
 g_k2_attrAdminBaseVersion: Integer = -1;

function k2_attrAdminBaseVersion: Integer;
begin
 if (g_k2_attrAdminBaseVersion = -1) then
  g_k2_attrAdminBaseVersion :=  Tk2Attributes.Instance.CheckIDByName('AdminBaseVersion');
 Result := g_k2_attrAdminBaseVersion;
end;


end.