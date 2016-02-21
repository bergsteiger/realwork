unit RememberPassword_ut_RememberPassword_UserType;
 {* Забыли пароль? }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\RememberPassword_ut_RememberPassword_UserType.pas"
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
 {* Константы для типа формы ut_RememberPassword }
 ut_RememberPasswordName = 'ut_RememberPassword';
  {* Строковый идентификатор пользовательского типа "Забыли пароль?" }
 ut_RememberPassword = TvcmUserType(0);
  {* Забыли пароль? }
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
 Tkw_FormUserType_ut_RememberPassword = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_RememberPassword }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_RememberPassword
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_RememberPassword.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_RememberPassword';
end;//Tkw_FormUserType_ut_RememberPassword.GetWordNameForRegister

function Tkw_FormUserType_ut_RememberPassword.GetInteger: Integer;
begin
 Result := ut_RememberPassword;
end;//Tkw_FormUserType_ut_RememberPassword.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_RememberPassword.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_RememberPassword }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
