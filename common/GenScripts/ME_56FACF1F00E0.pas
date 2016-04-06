unit PrimMainMenuWithProfNews_utMainMenuWithProfNews_UserType;
 {* Основное меню }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\PrimMainMenuWithProfNews_utMainMenuWithProfNews_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utMainMenuWithProfNews" MUID: (56FACF1F00E0)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы utMainMenuWithProfNews }
 utMainMenuWithProfNewsName = 'utMainMenuWithProfNews';
  {* Строковый идентификатор пользовательского типа "Основное меню" }
 utMainMenuWithProfNews = TvcmUserType(0);
  {* Основное меню }
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
 Tkw_FormUserType_utMainMenuWithProfNews = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utMainMenuWithProfNews }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utMainMenuWithProfNews
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utMainMenuWithProfNews.GetInteger: Integer;
begin
 Result := utMainMenuWithProfNews;
end;//Tkw_FormUserType_utMainMenuWithProfNews.GetInteger

class function Tkw_FormUserType_utMainMenuWithProfNews.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utMainMenuWithProfNews';
end;//Tkw_FormUserType_utMainMenuWithProfNews.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utMainMenuWithProfNews.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utMainMenuWithProfNews }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
