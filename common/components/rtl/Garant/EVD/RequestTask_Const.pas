unit RequestTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/RequestTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::RequestTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега RequestTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typRequestTask: RequestTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_RequestTask : RequestTaskTag = nil;

// start class RequestTaskTag

function k2_typRequestTask: RequestTaskTag;
begin
 if (g_RequestTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_RequestTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_RequestTask;
 end;//g_RequestTask = nil
 Result := g_RequestTask;
end;

end.