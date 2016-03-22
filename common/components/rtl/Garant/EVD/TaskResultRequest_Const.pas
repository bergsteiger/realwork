unit TaskResultRequest_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/TaskResultRequest_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::TaskResultRequest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега TaskResultRequest .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typTaskResultRequest: TaskResultRequestTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_TaskResultRequest : TaskResultRequestTag = nil;

// start class TaskResultRequestTag

function k2_typTaskResultRequest: TaskResultRequestTag;
begin
 if (g_TaskResultRequest = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_TaskResultRequest := TevdTasksSchema(Tk2TypeTable.GetInstance).t_TaskResultRequest;
 end;//g_TaskResultRequest = nil
 Result := g_TaskResultRequest;
end;

end.