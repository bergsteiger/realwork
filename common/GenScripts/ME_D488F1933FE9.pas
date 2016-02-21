unit RegistrationForm_ut_RegistrationForm_UserType;
 {* Регистрация }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\RegistrationForm_ut_RegistrationForm_UserType.pas"
// Стереотип: "UserType"

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

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_RegistrationForm = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_RegistrationForm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_RegistrationForm
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_RegistrationForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_RegistrationForm';
end;//Tkw_FormUserType_ut_RegistrationForm.GetWordNameForRegister

function Tkw_FormUserType_ut_RegistrationForm.GetInteger: Integer;
begin
 Result := ut_RegistrationForm;
end;//Tkw_FormUserType_ut_RegistrationForm.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_RegistrationForm.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_RegistrationForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
