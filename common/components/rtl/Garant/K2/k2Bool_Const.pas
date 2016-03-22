unit k2Bool_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2Bool_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi Low Level::K2::CoreTypes::k2Core::Bool
//
// Логическое значение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Bool - "Логическое значение".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Core_Schema
  ;

function k2_typBool: BoolAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Bool : BoolAtom = nil;

// start class BoolAtom

function k2_typBool: BoolAtom;
begin
 if (g_Bool = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2CoreSchema);
  g_Bool := Tk2CoreSchema(Tk2TypeTable.GetInstance).t_Bool;
 end;//g_Bool = nil
 Result := g_Bool;
end;

end.