unit BaloonWarningUserTypes_WarnOnControl_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnOnControl_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnIsAbolished_UserType
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы WarnOnControl }
 WarnOnControlName = 'WarnOnControl';
  {* Строковый идентификатор пользовательского типа "" }
 WarnOnControl = TvcmUserType(WarnIsAbolished + 1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnOnControl = {final} class(TtfwInteger)
  {* Слово словаря для типа формы WarnOnControl }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_WarnOnControl
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_WarnOnControl.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::WarnOnControl';
end;//Tkw_FormUserType_WarnOnControl.GetWordNameForRegister

function Tkw_FormUserType_WarnOnControl.GetInteger: Integer;
begin
 Result := WarnOnControl;
end;//Tkw_FormUserType_WarnOnControl.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnOnControl.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_WarnOnControl }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
