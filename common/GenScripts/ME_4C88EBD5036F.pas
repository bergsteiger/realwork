unit PrimAdmin_utAdmin_UserType;
 {* Администрирование пользователей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimAdmin_utAdmin_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If Defined(Admin)}
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
 {* Константы для типа формы utAdmin }
 utAdminName = 'utAdmin';
  {* Строковый идентификатор пользовательского типа "Администрирование пользователей" }
 utAdmin = TvcmUserType(0);
  {* Администрирование пользователей }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utAdmin = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utAdmin }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utAdmin
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utAdmin.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utAdmin';
end;//Tkw_FormUserType_utAdmin.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utAdmin.GetInteger: Integer;
begin
 Result := utAdmin;
end;//Tkw_FormUserType_utAdmin.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utAdmin.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utAdmin }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
