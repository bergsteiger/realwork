unit Logo_ut_Logo_UserType;
 {* Logo }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\Logo_ut_Logo_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

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
 {* Константы для типа формы ut_Logo }
 ut_LogoName = 'ut_Logo';
  {* Строковый идентификатор пользовательского типа "Logo" }
 ut_Logo = TvcmUserType(0);
  {* Logo }

implementation

uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_Logo = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_Logo }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_Logo
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_Logo.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_Logo';
end;//Tkw_FormUserType_ut_Logo.GetWordNameForRegister

function Tkw_FormUserType_ut_Logo.GetInteger: Integer;
begin
 Result := ut_Logo;
end;//Tkw_FormUserType_ut_Logo.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_Logo.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_Logo }
{$IfEnd} // NOT Defined(NoScripts)

end.
