unit StyleEditorFont_ut_StyleEditorFont_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/StyleEditorFont_ut_StyleEditorFont_UserType.pas"
// Начат: 09.09.2009 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Основные прецеденты::Settings::View::Settings::Settings::StyleEditorFont::ut_StyleEditorFont
//
// Параметры шрифта
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
    { Константы для типа формы ut_StyleEditorFont }
   ut_StyleEditorFontName = 'ut_StyleEditorFont';
    { Строковый идентификатор пользовательского типа "Параметры шрифта" }
   ut_StyleEditorFont = TvcmUserType(0);
    { Параметры шрифта }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_StyleEditorFont = {final scriptword} class(TtfwInteger)
    {* Слово словаря для типа формы ut_StyleEditorFont }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_StyleEditorFont
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_StyleEditorFont

class function Tkw_FormUserType_ut_StyleEditorFont.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_StyleEditorFont';
end;//Tkw_FormUserType_ut_StyleEditorFont.GetWordNameForRegister

function Tkw_FormUserType_ut_StyleEditorFont.GetInteger: Integer;
 {-}
begin
 Result := ut_StyleEditorFont;
end;//Tkw_FormUserType_ut_StyleEditorFont.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_ut_StyleEditorFont
 Tkw_FormUserType_ut_StyleEditorFont.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.