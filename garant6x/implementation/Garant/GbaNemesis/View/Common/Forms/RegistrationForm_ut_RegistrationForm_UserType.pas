unit RegistrationForm_ut_RegistrationForm_UserType;
 {* Регистрация }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\RegistrationForm_ut_RegistrationForm_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_RegistrationForm" MUID: (D488F1933FE9)

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
 {* Константы для типа формы ut_RegistrationForm }
 ut_RegistrationFormName = 'ut_RegistrationForm';
  {* Строковый идентификатор пользовательского типа "Регистрация" }
 ut_RegistrationForm = TvcmUserType(0);
  {* Регистрация }
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
 Tkw_FormUserType_ut_RegistrationForm = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_RegistrationForm }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_RegistrationForm
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_RegistrationForm.GetInteger: Integer;
begin
 Result := ut_RegistrationForm;
end;//Tkw_FormUserType_ut_RegistrationForm.GetInteger

class function Tkw_FormUserType_ut_RegistrationForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_RegistrationForm';
end;//Tkw_FormUserType_ut_RegistrationForm.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_RegistrationForm.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_RegistrationForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
