unit k2Color_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2Color_Const.pas"
// Начат: 17.07.1998 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi Low Level::K2::Standard::k2Native::Color
//
// Цвет
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Color - "Цвет".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Native_Schema
  ;

function k2_typColor: ColorAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Color : ColorAtom = nil;

// start class ColorAtom

function k2_typColor: ColorAtom;
begin
 if (g_Color = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2NativeSchema);
  g_Color := Tk2NativeSchema(Tk2TypeTable.GetInstance).t_Color;
 end;//g_Color = nil
 Result := g_Color;
end;

end.