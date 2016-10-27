unit StyleEditorFont_ut_StyleEditorFont_UserType;
 {* Параметры шрифта }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorFont_ut_StyleEditorFont_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_StyleEditorFont" MUID: (43C9F2187122)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки ut_StyleEditorFontLocalConstants }
 str_ut_StyleEditorFontCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_StyleEditorFontCaption'; rValue : 'Параметры шрифта');
  {* Заголовок пользовательского типа "Параметры шрифта" }
 {* Константы для типа формы ut_StyleEditorFont }
 ut_StyleEditorFontName = 'ut_StyleEditorFont';
  {* Строковый идентификатор пользовательского типа "Параметры шрифта" }
 ut_StyleEditorFont = TvcmUserType(0);
  {* Параметры шрифта }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_StyleEditorFont = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_StyleEditorFont }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_StyleEditorFont
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_StyleEditorFont.GetInteger: Integer;
begin
 Result := ut_StyleEditorFont;
end;//Tkw_FormUserType_ut_StyleEditorFont.GetInteger

class function Tkw_FormUserType_ut_StyleEditorFont.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_StyleEditorFont';
end;//Tkw_FormUserType_ut_StyleEditorFont.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_StyleEditorFontCaption.Init;
 {* Инициализация str_ut_StyleEditorFontCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_StyleEditorFont.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_StyleEditorFont }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
