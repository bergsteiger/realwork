unit csTaskProgress_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csTaskProgress_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::csTaskProgress
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csTaskProgress .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrTaskID: Integer;

function k2_attrDescription: Integer;

function k2_attrPercent: Integer;

function k2_typcsTaskProgress: csTaskProgressTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csTaskProgress : csTaskProgressTag = nil;

// start class csTaskProgressTag

function k2_typcsTaskProgress: csTaskProgressTag;
begin
 if (g_csTaskProgress = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csTaskProgress := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csTaskProgress;
 end;//g_csTaskProgress = nil
 Result := g_csTaskProgress;
end;
var
 g_k2_attrTaskID: Integer = -1;

function k2_attrTaskID: Integer;
begin
 if (g_k2_attrTaskID = -1) then
  g_k2_attrTaskID :=  Tk2Attributes.Instance.CheckIDByName('TaskID');
 Result := g_k2_attrTaskID;
end;

var
 g_k2_attrDescription: Integer = -1;

function k2_attrDescription: Integer;
begin
 if (g_k2_attrDescription = -1) then
  g_k2_attrDescription :=  Tk2Attributes.Instance.CheckIDByName('Description');
 Result := g_k2_attrDescription;
end;

var
 g_k2_attrPercent: Integer = -1;

function k2_attrPercent: Integer;
begin
 if (g_k2_attrPercent = -1) then
  g_k2_attrPercent :=  Tk2Attributes.Instance.CheckIDByName('Percent');
 Result := g_k2_attrPercent;
end;


end.