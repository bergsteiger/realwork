unit SchedulerProxyTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/SchedulerProxyTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::SchedulerProxyTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега SchedulerProxyTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrSchedulerTaskType: Integer;

function k2_typSchedulerProxyTask: SchedulerProxyTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_SchedulerProxyTask : SchedulerProxyTaskTag = nil;

// start class SchedulerProxyTaskTag

function k2_typSchedulerProxyTask: SchedulerProxyTaskTag;
begin
 if (g_SchedulerProxyTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_SchedulerProxyTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_SchedulerProxyTask;
 end;//g_SchedulerProxyTask = nil
 Result := g_SchedulerProxyTask;
end;
var
 g_k2_attrSchedulerTaskType: Integer = -1;

function k2_attrSchedulerTaskType: Integer;
begin
 if (g_k2_attrSchedulerTaskType = -1) then
  g_k2_attrSchedulerTaskType :=  Tk2Attributes.Instance.CheckIDByName('SchedulerTaskType');
 Result := g_k2_attrSchedulerTaskType;
end;


end.