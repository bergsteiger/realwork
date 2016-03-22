unit k2Long_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2Long_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi Low Level::K2::CoreTypes::k2Core::Long
//
// Целое число
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Long - "Целое число".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Core_Schema
  ;

function k2_typLong: LongAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Long : LongAtom = nil;

// start class LongAtom

function k2_typLong: LongAtom;
begin
 if (g_Long = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2CoreSchema);
  g_Long := Tk2CoreSchema(Tk2TypeTable.GetInstance).t_Long;
 end;//g_Long = nil
 Result := g_Long;
end;

end.