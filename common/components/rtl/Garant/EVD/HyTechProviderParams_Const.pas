unit HyTechProviderParams_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/HyTechProviderParams_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::HyTechProviderParams
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега HyTechProviderParams .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrStationName: Integer;

function k2_attrTablePath: Integer;

function k2_attrTmpDirPath: Integer;

function k2_attrLockPath: Integer;

function k2_typHyTechProviderParams: HyTechProviderParamsTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_HyTechProviderParams : HyTechProviderParamsTag = nil;

// start class HyTechProviderParamsTag

function k2_typHyTechProviderParams: HyTechProviderParamsTag;
begin
 if (g_HyTechProviderParams = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_HyTechProviderParams := TevdTasksSchema(Tk2TypeTable.GetInstance).t_HyTechProviderParams;
 end;//g_HyTechProviderParams = nil
 Result := g_HyTechProviderParams;
end;
var
 g_k2_attrStationName: Integer = -1;

function k2_attrStationName: Integer;
begin
 if (g_k2_attrStationName = -1) then
  g_k2_attrStationName :=  Tk2Attributes.Instance.CheckIDByName('StationName');
 Result := g_k2_attrStationName;
end;

var
 g_k2_attrTablePath: Integer = -1;

function k2_attrTablePath: Integer;
begin
 if (g_k2_attrTablePath = -1) then
  g_k2_attrTablePath :=  Tk2Attributes.Instance.CheckIDByName('TablePath');
 Result := g_k2_attrTablePath;
end;

var
 g_k2_attrTmpDirPath: Integer = -1;

function k2_attrTmpDirPath: Integer;
begin
 if (g_k2_attrTmpDirPath = -1) then
  g_k2_attrTmpDirPath :=  Tk2Attributes.Instance.CheckIDByName('TmpDirPath');
 Result := g_k2_attrTmpDirPath;
end;

var
 g_k2_attrLockPath: Integer = -1;

function k2_attrLockPath: Integer;
begin
 if (g_k2_attrLockPath = -1) then
  g_k2_attrLockPath :=  Tk2Attributes.Instance.CheckIDByName('LockPath');
 Result := g_k2_attrLockPath;
end;


end.