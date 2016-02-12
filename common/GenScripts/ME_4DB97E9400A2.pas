unit BaloonWarningUserTypes_remTimeMachineWarning_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_remTimeMachineWarning_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_remListFiltered_UserType
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы remTimeMachineWarning }
 remTimeMachineWarningName = 'remTimeMachineWarning';
  {* Строковый идентификатор пользовательского типа "" }
 remTimeMachineWarning = TvcmUserType(remListFiltered + 1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_remTimeMachineWarning = {final} class(TtfwInteger)
  {* Слово словаря для типа формы remTimeMachineWarning }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_remTimeMachineWarning
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_remTimeMachineWarning.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::remTimeMachineWarning';
end;//Tkw_FormUserType_remTimeMachineWarning.GetWordNameForRegister

function Tkw_FormUserType_remTimeMachineWarning.GetInteger: Integer;
begin
 Result := remTimeMachineWarning;
end;//Tkw_FormUserType_remTimeMachineWarning.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_remTimeMachineWarning.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_remTimeMachineWarning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
