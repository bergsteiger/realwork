unit Task_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/Task_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::Task
//
// Задание
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Task - "Задание".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typTask_TaskType: Task_TaskType_Tag;

function k2_attrTaskType: Integer;

function k2_attrPriority: Integer;

function k2_attrVersion: Integer;

function k2_attrTaskID: Integer;

function k2_attrDate: Integer;

function k2_attrUser: Integer;

function k2_attrDescription: Integer;

function k2_attrTaskFolder: Integer;
function k2_typTask: TaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Task : TaskTag = nil;

// start class TaskTag

function k2_typTask: TaskTag;
begin
 if (g_Task = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_Task := TevdTasksSchema(Tk2TypeTable.GetInstance).t_Task;
 end;//g_Task = nil
 Result := g_Task;
end;
var
 g_k2_attrTaskType: Integer = -1;

function k2_attrTaskType: Integer;
begin
 if (g_k2_attrTaskType = -1) then
  g_k2_attrTaskType :=  Tk2Attributes.Instance.CheckIDByName('TaskType');
 Result := g_k2_attrTaskType;
end;

var
 g_k2_attrPriority: Integer = -1;

function k2_attrPriority: Integer;
begin
 if (g_k2_attrPriority = -1) then
  g_k2_attrPriority :=  Tk2Attributes.Instance.CheckIDByName('Priority');
 Result := g_k2_attrPriority;
end;

var
 g_k2_attrVersion: Integer = -1;

function k2_attrVersion: Integer;
begin
 if (g_k2_attrVersion = -1) then
  g_k2_attrVersion :=  Tk2Attributes.Instance.CheckIDByName('Version');
 Result := g_k2_attrVersion;
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
 g_k2_attrDate: Integer = -1;

function k2_attrDate: Integer;
begin
 if (g_k2_attrDate = -1) then
  g_k2_attrDate :=  Tk2Attributes.Instance.CheckIDByName('Date');
 Result := g_k2_attrDate;
end;

var
 g_k2_attrUser: Integer = -1;

function k2_attrUser: Integer;
begin
 if (g_k2_attrUser = -1) then
  g_k2_attrUser :=  Tk2Attributes.Instance.CheckIDByName('User');
 Result := g_k2_attrUser;
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
 g_k2_attrTaskFolder: Integer = -1;

function k2_attrTaskFolder: Integer;
begin
 if (g_k2_attrTaskFolder = -1) then
  g_k2_attrTaskFolder :=  Tk2Attributes.Instance.CheckIDByName('TaskFolder');
 Result := g_k2_attrTaskFolder;
end;


var
 g_Task_TaskType : Task_TaskType_Tag = nil;

// start class TaskType

function k2_typTask_TaskType: Task_TaskType_Tag;
begin
 if (g_Task_TaskType = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_Task_TaskType := TevdTasksSchema(Tk2TypeTable.GetInstance).t_Task_TaskType;
 end;//g_Task = nil
 Result := g_Task_TaskType;
end;


end.