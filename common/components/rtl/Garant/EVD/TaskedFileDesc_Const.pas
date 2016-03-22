unit TaskedFileDesc_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/TaskedFileDesc_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::TaskedFileDesc
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега TaskedFileDesc .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrTaskID: Integer;

function k2_attrCopiedSize: Integer;

function k2_typTaskedFileDesc: TaskedFileDescTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_TaskedFileDesc : TaskedFileDescTag = nil;

// start class TaskedFileDescTag

function k2_typTaskedFileDesc: TaskedFileDescTag;
begin
 if (g_TaskedFileDesc = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_TaskedFileDesc := TevdTasksSchema(Tk2TypeTable.GetInstance).t_TaskedFileDesc;
 end;//g_TaskedFileDesc = nil
 Result := g_TaskedFileDesc;
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
 g_k2_attrCopiedSize: Integer = -1;

function k2_attrCopiedSize: Integer;
begin
 if (g_k2_attrCopiedSize = -1) then
  g_k2_attrCopiedSize :=  Tk2Attributes.Instance.CheckIDByName('CopiedSize');
 Result := g_k2_attrCopiedSize;
end;


end.