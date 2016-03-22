unit k2Inch_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2Inch_Const.pas"
// Начат: 17.07.1998 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi Low Level::K2::Standard::k2Native::Inch
//
// Дюйм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Inch - "Дюйм".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Native_Schema
  ;

function k2_typInch: InchAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Inch : InchAtom = nil;

// start class InchAtom

function k2_typInch: InchAtom;
begin
 if (g_Inch = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2NativeSchema);
  g_Inch := Tk2NativeSchema(Tk2TypeTable.GetInstance).t_Inch;
 end;//g_Inch = nil
 Result := g_Inch;
end;

end.