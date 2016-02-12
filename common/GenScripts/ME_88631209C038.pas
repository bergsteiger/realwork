unit EULA_ut_EULA_UserType;
 {* Условия использования }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\EULA_ut_EULA_UserType.pas"
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
 {* Константы для типа формы ut_EULA }
 ut_EULAName = 'ut_EULA';
  {* Строковый идентификатор пользовательского типа "Условия использования" }
 ut_EULA = TvcmUserType(0);
  {* Условия использования }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_EULA = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_EULA }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_EULA
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_EULA.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_EULA';
end;//Tkw_FormUserType_ut_EULA.GetWordNameForRegister

function Tkw_FormUserType_ut_EULA.GetInteger: Integer;
begin
 Result := ut_EULA;
end;//Tkw_FormUserType_ut_EULA.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_EULA.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_EULA }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
