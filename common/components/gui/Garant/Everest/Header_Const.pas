unit Header_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/Header_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::Header
//
// Верхний колонтитул
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Header - "Верхний колонтитул".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idHeader = 100;

function k2_typHeader: HeaderTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Header : HeaderTag = nil;

// start class HeaderTag

function k2_typHeader: HeaderTag;
begin
 if (g_Header = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Header := TevNativeSchema(Tk2TypeTable.GetInstance).t_Header;
 end;//g_Header = nil
 Result := g_Header;
end;

end.