unit StartupTips_ut_StartupTips_UserType;
 {* Совет дня }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\Forms\StartupTips_ut_StartupTips_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_StartupTips" MUID: (0F70FC525F19)

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
 {* Константы для типа формы ut_StartupTips }
 ut_StartupTipsName = 'ut_StartupTips';
  {* Строковый идентификатор пользовательского типа "Совет дня" }
 ut_StartupTips = TvcmUserType(0);
  {* Совет дня }
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
 Tkw_FormUserType_ut_StartupTips = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_StartupTips }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_StartupTips
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_StartupTips.GetInteger: Integer;
begin
 Result := ut_StartupTips;
end;//Tkw_FormUserType_ut_StartupTips.GetInteger

class function Tkw_FormUserType_ut_StartupTips.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_StartupTips';
end;//Tkw_FormUserType_ut_StartupTips.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_StartupTips.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_StartupTips }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
