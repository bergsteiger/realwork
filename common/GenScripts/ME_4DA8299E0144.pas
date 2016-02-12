unit BaloonWarningUserTypes_WarnTimeMachineOn_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnTimeMachineOn_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnInactualDocument_UserType
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы WarnTimeMachineOn }
 WarnTimeMachineOnName = 'WarnTimeMachineOn';
  {* Строковый идентификатор пользовательского типа "" }
 WarnTimeMachineOn = TvcmUserType(WarnInactualDocument + 1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnTimeMachineOn = {final} class(TtfwInteger)
  {* Слово словаря для типа формы WarnTimeMachineOn }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_WarnTimeMachineOn
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_WarnTimeMachineOn.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::WarnTimeMachineOn';
end;//Tkw_FormUserType_WarnTimeMachineOn.GetWordNameForRegister

function Tkw_FormUserType_WarnTimeMachineOn.GetInteger: Integer;
begin
 Result := WarnTimeMachineOn;
end;//Tkw_FormUserType_WarnTimeMachineOn.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnTimeMachineOn.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_WarnTimeMachineOn }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
