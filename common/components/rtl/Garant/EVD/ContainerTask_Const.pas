unit ContainerTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/ContainerTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::ContainerTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега ContainerTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typContainerTask_TasksList: ContainerTask_TasksList_Tag;

function k2_attrTasksList: Integer;

function k2_attrParallelExecutionMode: Integer;
function k2_typContainerTask: ContainerTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ContainerTask : ContainerTaskTag = nil;

// start class ContainerTaskTag

function k2_typContainerTask: ContainerTaskTag;
begin
 if (g_ContainerTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ContainerTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ContainerTask;
 end;//g_ContainerTask = nil
 Result := g_ContainerTask;
end;
var
 g_k2_attrTasksList: Integer = -1;

function k2_attrTasksList: Integer;
begin
 if (g_k2_attrTasksList = -1) then
  g_k2_attrTasksList :=  Tk2Attributes.Instance.CheckIDByName('TasksList');
 Result := g_k2_attrTasksList;
end;

var
 g_k2_attrParallelExecutionMode: Integer = -1;

function k2_attrParallelExecutionMode: Integer;
begin
 if (g_k2_attrParallelExecutionMode = -1) then
  g_k2_attrParallelExecutionMode :=  Tk2Attributes.Instance.CheckIDByName('ParallelExecutionMode');
 Result := g_k2_attrParallelExecutionMode;
end;


var
 g_ContainerTask_TasksList : ContainerTask_TasksList_Tag = nil;

// start class TasksList

function k2_typContainerTask_TasksList: ContainerTask_TasksList_Tag;
begin
 if (g_ContainerTask_TasksList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ContainerTask_TasksList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ContainerTask_TasksList;
 end;//g_ContainerTask = nil
 Result := g_ContainerTask_TasksList;
end;


end.