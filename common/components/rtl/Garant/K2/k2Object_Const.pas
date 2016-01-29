unit k2Object_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2Object_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi::K2::CoreTypes::k2Core::Object
//
// Базовый класс
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Object - "Базовый класс".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Core_Schema
  ;

function k2_typObject: ObjectAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Object : ObjectAtom = nil;

// start class ObjectAtom

function k2_typObject: ObjectAtom;
begin
 if (g_Object = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2CoreSchema);
  g_Object := Tk2CoreSchema(Tk2TypeTable.GetInstance).t_Object;
 end;//g_Object = nil
 Result := g_Object;
end;

end.