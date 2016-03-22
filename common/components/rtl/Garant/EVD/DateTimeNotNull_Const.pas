unit DateTimeNotNull_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/DateTimeNotNull_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::DateTimeNotNull
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега DateTimeNotNull .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typDateTimeNotNull: DateTimeNotNullTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DateTimeNotNull : DateTimeNotNullTag = nil;

// start class DateTimeNotNullTag

function k2_typDateTimeNotNull: DateTimeNotNullTag;
begin
 if (g_DateTimeNotNull = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_DateTimeNotNull := TevdTasksSchema(Tk2TypeTable.GetInstance).t_DateTimeNotNull;
 end;//g_DateTimeNotNull = nil
 Result := g_DateTimeNotNull;
end;

end.