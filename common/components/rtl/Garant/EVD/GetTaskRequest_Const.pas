unit GetTaskRequest_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/GetTaskRequest_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::GetTaskRequest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега GetTaskRequest .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typGetTaskRequest: GetTaskRequestTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_GetTaskRequest : GetTaskRequestTag = nil;

// start class GetTaskRequestTag

function k2_typGetTaskRequest: GetTaskRequestTag;
begin
 if (g_GetTaskRequest = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_GetTaskRequest := TevdTasksSchema(Tk2TypeTable.GetInstance).t_GetTaskRequest;
 end;//g_GetTaskRequest = nil
 Result := g_GetTaskRequest;
end;

end.