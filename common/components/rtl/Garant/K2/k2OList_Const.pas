unit k2OList_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2OList_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::K2::CoreTypes::k2Core::OList
//
// Список объектов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега OList - "Список объектов".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Core_Schema
  ;

function k2_typOList: OListTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_OList : OListTag = nil;

// start class OListTag

function k2_typOList: OListTag;
begin
 if (g_OList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2CoreSchema);
  g_OList := Tk2CoreSchema(Tk2TypeTable.GetInstance).t_OList;
 end;//g_OList = nil
 Result := g_OList;
end;

end.