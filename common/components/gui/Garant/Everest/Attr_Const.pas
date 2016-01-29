unit Attr_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/Attr_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::Attr
//
// Атрибут тега
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Attr - "Атрибут тега".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idAttr = 125;

function k2_typAttr: AttrTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Attr : AttrTag = nil;

// start class AttrTag

function k2_typAttr: AttrTag;
begin
 if (g_Attr = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Attr := TevNativeSchema(Tk2TypeTable.GetInstance).t_Attr;
 end;//g_Attr = nil
 Result := g_Attr;
end;

end.