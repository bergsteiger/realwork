unit CompInfo_ut_CompInfo_UserType;
 {* Информация о комплекте }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\CompInfo_ut_CompInfo_UserType.pas"
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
 {* Константы для типа формы ut_CompInfo }
 ut_CompInfoName = 'ut_CompInfo';
  {* Строковый идентификатор пользовательского типа "Информация о комплекте" }
 ut_CompInfo = TvcmUserType(0);
  {* Информация о комплекте }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_CompInfo = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_CompInfo }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_CompInfo
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_CompInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_CompInfo';
end;//Tkw_FormUserType_ut_CompInfo.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_CompInfo.GetInteger: Integer;
begin
 Result := ut_CompInfo;
end;//Tkw_FormUserType_ut_CompInfo.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_CompInfo.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_CompInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
