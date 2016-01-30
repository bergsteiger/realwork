unit StyleEditorFont_ut_StyleEditorFont_UserType;
 {* Параметры шрифта }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorFont_ut_StyleEditorFont_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
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
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_StyleEditorFont = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_StyleEditorFont }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_StyleEditorFont
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_StyleEditorFont.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_StyleEditorFont';
end;//Tkw_FormUserType_ut_StyleEditorFont.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_StyleEditorFont.GetInteger: Integer;
begin
 Result := ut_StyleEditorFont;
end;//Tkw_FormUserType_ut_StyleEditorFont.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_StyleEditorFont.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_StyleEditorFont }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
