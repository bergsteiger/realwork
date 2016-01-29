unit Time_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/Time_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi::EVD::Standard::evdNative::Time
//
// Время
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Time - "Время".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_typTime: TimeAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Time : TimeAtom = nil;

// start class TimeAtom

function k2_typTime: TimeAtom;
begin
 if (g_Time = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Time := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Time;
 end;//g_Time = nil
 Result := g_Time;
end;

end.