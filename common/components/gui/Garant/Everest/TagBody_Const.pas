unit TagBody_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/TagBody_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::TagBody
//
// Тело тега
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега TagBody - "Тело тега".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idTagBody = 128;

function k2_typTagBody: TagBodyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_TagBody : TagBodyTag = nil;

// start class TagBodyTag

function k2_typTagBody: TagBodyTag;
begin
 if (g_TagBody = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_TagBody := TevNativeSchema(Tk2TypeTable.GetInstance).t_TagBody;
 end;//g_TagBody = nil
 Result := g_TagBody;
end;

end.