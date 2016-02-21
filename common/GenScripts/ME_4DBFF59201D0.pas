unit BaloonWarningUserTypes_remUnreadConsultations_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_remUnreadConsultations_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_remTimeMachineWarning_UserType
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы remUnreadConsultations }
 remUnreadConsultationsName = 'remUnreadConsultations';
  {* Строковый идентификатор пользовательского типа "" }
 remUnreadConsultations = TvcmUserType(remTimeMachineWarning + 1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_remUnreadConsultations = {final} class(TtfwInteger)
  {* Слово словаря для типа формы remUnreadConsultations }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_remUnreadConsultations
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_remUnreadConsultations.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::remUnreadConsultations';
end;//Tkw_FormUserType_remUnreadConsultations.GetWordNameForRegister

function Tkw_FormUserType_remUnreadConsultations.GetInteger: Integer;
begin
 Result := remUnreadConsultations;
end;//Tkw_FormUserType_remUnreadConsultations.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_remUnreadConsultations.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_remUnreadConsultations }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
