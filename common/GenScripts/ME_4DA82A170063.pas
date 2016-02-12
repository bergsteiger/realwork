unit BaloonWarningUserTypes_WarnTimeMachineWarning_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnTimeMachineWarning_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnRedaction_UserType
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы WarnTimeMachineWarning }
 WarnTimeMachineWarningName = 'WarnTimeMachineWarning';
  {* Строковый идентификатор пользовательского типа "" }
 WarnTimeMachineWarning = TvcmUserType(WarnRedaction + 1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnTimeMachineWarning = {final} class(TtfwInteger)
  {* Слово словаря для типа формы WarnTimeMachineWarning }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_WarnTimeMachineWarning
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_WarnTimeMachineWarning.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::WarnTimeMachineWarning';
end;//Tkw_FormUserType_WarnTimeMachineWarning.GetWordNameForRegister

function Tkw_FormUserType_WarnTimeMachineWarning.GetInteger: Integer;
begin
 Result := WarnTimeMachineWarning;
end;//Tkw_FormUserType_WarnTimeMachineWarning.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnTimeMachineWarning.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_WarnTimeMachineWarning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
