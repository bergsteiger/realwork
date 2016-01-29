unit TagName_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/TagName_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::TagName
//
// Имя тега
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега TagName - "Имя тега".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idTagName = 124;

function k2_typTagName: TagNameTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_TagName : TagNameTag = nil;

// start class TagNameTag

function k2_typTagName: TagNameTag;
begin
 if (g_TagName = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_TagName := TevNativeSchema(Tk2TypeTable.GetInstance).t_TagName;
 end;//g_TagName = nil
 Result := g_TagName;
end;

end.