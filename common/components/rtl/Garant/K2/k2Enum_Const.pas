unit k2Enum_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2Enum_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi Low Level::K2::CoreTypes::k2Core::Enum
//
// Перечислимый тип
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Enum - "Перечислимый тип".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Core_Schema
  ;

function k2_typEnum: EnumAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Enum : EnumAtom = nil;

// start class EnumAtom

function k2_typEnum: EnumAtom;
begin
 if (g_Enum = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2CoreSchema);
  g_Enum := Tk2CoreSchema(Tk2TypeTable.GetInstance).t_Enum;
 end;//g_Enum = nil
 Result := g_Enum;
end;

end.