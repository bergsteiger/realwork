unit AutolinkerTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/AutolinkerTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::AutolinkerTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега AutolinkerTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrClearLinksBeforeRun: Integer;

function k2_typAutolinkerTask: AutolinkerTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AutolinkerTask : AutolinkerTaskTag = nil;

// start class AutolinkerTaskTag

function k2_typAutolinkerTask: AutolinkerTaskTag;
begin
 if (g_AutolinkerTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AutolinkerTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AutolinkerTask;
 end;//g_AutolinkerTask = nil
 Result := g_AutolinkerTask;
end;
var
 g_k2_attrClearLinksBeforeRun: Integer = -1;

function k2_attrClearLinksBeforeRun: Integer;
begin
 if (g_k2_attrClearLinksBeforeRun = -1) then
  g_k2_attrClearLinksBeforeRun :=  Tk2Attributes.Instance.CheckIDByName('ClearLinksBeforeRun');
 Result := g_k2_attrClearLinksBeforeRun;
end;


end.