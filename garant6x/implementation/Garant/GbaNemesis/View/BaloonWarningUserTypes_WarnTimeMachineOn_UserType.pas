unit BaloonWarningUserTypes_WarnTimeMachineOn_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnTimeMachineOn_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "WarnTimeMachineOn" MUID: (4DA8299E0144)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnInactualDocument_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_WarnTimeMachineOn = {final} class(TtfwInteger)
  {* Слово словаря для типа формы WarnTimeMachineOn }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_WarnTimeMachineOn
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_WarnTimeMachineOn.GetInteger: Integer;
begin
 Result := WarnTimeMachineOn;
end;//Tkw_FormUserType_WarnTimeMachineOn.GetInteger

class function Tkw_FormUserType_WarnTimeMachineOn.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::WarnTimeMachineOn';
end;//Tkw_FormUserType_WarnTimeMachineOn.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnTimeMachineOn.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_WarnTimeMachineOn }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
