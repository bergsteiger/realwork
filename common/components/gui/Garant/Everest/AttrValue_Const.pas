unit AttrValue_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/AttrValue_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::AttrValue
//
// Значение атрибута
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега AttrValue - "Значение атрибута".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idAttrValue = 127;

function k2_typAttrValue: AttrValueTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AttrValue : AttrValueTag = nil;

// start class AttrValueTag

function k2_typAttrValue: AttrValueTag;
begin
 if (g_AttrValue = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_AttrValue := TevNativeSchema(Tk2TypeTable.GetInstance).t_AttrValue;
 end;//g_AttrValue = nil
 Result := g_AttrValue;
end;

end.