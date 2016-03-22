unit AutoSpellTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/AutoSpellTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::AutoSpellTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега AutoSpellTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typAutoSpellTask: AutoSpellTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AutoSpellTask : AutoSpellTaskTag = nil;

// start class AutoSpellTaskTag

function k2_typAutoSpellTask: AutoSpellTaskTag;
begin
 if (g_AutoSpellTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AutoSpellTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AutoSpellTask;
 end;//g_AutoSpellTask = nil
 Result := g_AutoSpellTask;
end;

end.