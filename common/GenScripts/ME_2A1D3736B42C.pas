unit SelfInfo_ut_SelfInfo_UserType;
 {* Регистрационные данные }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\SelfInfo_ut_SelfInfo_UserType.pas"
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
 {* Константы для типа формы ut_SelfInfo }
 ut_SelfInfoName = 'ut_SelfInfo';
  {* Строковый идентификатор пользовательского типа "Регистрационные данные" }
 ut_SelfInfo = TvcmUserType(0);
  {* Регистрационные данные }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_SelfInfo = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_SelfInfo }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_SelfInfo
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_SelfInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_SelfInfo';
end;//Tkw_FormUserType_ut_SelfInfo.GetWordNameForRegister

function Tkw_FormUserType_ut_SelfInfo.GetInteger: Integer;
begin
 Result := ut_SelfInfo;
end;//Tkw_FormUserType_ut_SelfInfo.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_SelfInfo.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_SelfInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
