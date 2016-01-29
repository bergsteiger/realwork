unit AttrName_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/AttrName_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::AttrName
//
// Имя атрибута
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега AttrName - "Имя атрибута".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idAttrName = 126;

function k2_typAttrName: AttrNameTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AttrName : AttrNameTag = nil;

// start class AttrNameTag

function k2_typAttrName: AttrNameTag;
begin
 if (g_AttrName = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_AttrName := TevNativeSchema(Tk2TypeTable.GetInstance).t_AttrName;
 end;//g_AttrName = nil
 Result := g_AttrName;
end;

end.