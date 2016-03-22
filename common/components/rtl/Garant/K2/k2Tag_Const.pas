unit k2Tag_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2Tag_Const.pas"
// Начат: 17.07.1998 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi Low Level::K2::Standard::k2Native::Tag
//
// Класс с переменным набором свойств
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Tag - "Класс с переменным набором свойств".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Native_Schema
  ;

function k2_typTag: TagAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Tag : TagAtom = nil;

// start class TagAtom

function k2_typTag: TagAtom;
begin
 if (g_Tag = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2NativeSchema);
  g_Tag := Tk2NativeSchema(Tk2TypeTable.GetInstance).t_Tag;
 end;//g_Tag = nil
 Result := g_Tag;
end;

end.