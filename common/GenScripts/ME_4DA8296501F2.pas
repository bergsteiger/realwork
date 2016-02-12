unit BaloonWarningUserTypes_WarnIsAbolished_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnIsAbolished_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnPreActive_UserType
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы WarnIsAbolished }
 WarnIsAbolishedName = 'WarnIsAbolished';
  {* Строковый идентификатор пользовательского типа "" }
 WarnIsAbolished = TvcmUserType(WarnPreActive + 1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnIsAbolished = {final} class(TtfwInteger)
  {* Слово словаря для типа формы WarnIsAbolished }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_WarnIsAbolished
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_WarnIsAbolished.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::WarnIsAbolished';
end;//Tkw_FormUserType_WarnIsAbolished.GetWordNameForRegister

function Tkw_FormUserType_WarnIsAbolished.GetInteger: Integer;
begin
 Result := WarnIsAbolished;
end;//Tkw_FormUserType_WarnIsAbolished.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnIsAbolished.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_WarnIsAbolished }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
