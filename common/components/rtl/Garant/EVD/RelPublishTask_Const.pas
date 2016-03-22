unit RelPublishTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/RelPublishTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::RelPublishTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега RelPublishTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typRelPublishTask: RelPublishTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_RelPublishTask : RelPublishTaskTag = nil;

// start class RelPublishTaskTag

function k2_typRelPublishTask: RelPublishTaskTag;
begin
 if (g_RelPublishTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_RelPublishTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_RelPublishTask;
 end;//g_RelPublishTask = nil
 Result := g_RelPublishTask;
end;

end.