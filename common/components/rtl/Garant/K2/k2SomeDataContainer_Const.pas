unit k2SomeDataContainer_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2SomeDataContainer_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi::K2::CoreTypes::k2Core::SomeDataContainer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега SomeDataContainer .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Core_Schema
  ;

function k2_typSomeDataContainer: SomeDataContainerAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_SomeDataContainer : SomeDataContainerAtom = nil;

// start class SomeDataContainerAtom

function k2_typSomeDataContainer: SomeDataContainerAtom;
begin
 if (g_SomeDataContainer = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2CoreSchema);
  g_SomeDataContainer := Tk2CoreSchema(Tk2TypeTable.GetInstance).t_SomeDataContainer;
 end;//g_SomeDataContainer = nil
 Result := g_SomeDataContainer;
end;

end.