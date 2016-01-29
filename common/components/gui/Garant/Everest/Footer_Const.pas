unit Footer_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/Footer_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::Footer
//
// Нижний колонтитул
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Footer - "Нижний колонтитул".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idFooter = 101;

function k2_typFooter: FooterTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Footer : FooterTag = nil;

// start class FooterTag

function k2_typFooter: FooterTag;
begin
 if (g_Footer = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Footer := TevNativeSchema(Tk2TypeTable.GetInstance).t_Footer;
 end;//g_Footer = nil
 Result := g_Footer;
end;

end.