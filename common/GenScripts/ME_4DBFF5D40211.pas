unit BaloonWarningUserTypes_remOnlineDead_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_remOnlineDead_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_remUnreadConsultations_UserType
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы remOnlineDead }
 remOnlineDeadName = 'remOnlineDead';
  {* Строковый идентификатор пользовательского типа "" }
 remOnlineDead = TvcmUserType(remUnreadConsultations + 1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_remOnlineDead = {final} class(TtfwInteger)
  {* Слово словаря для типа формы remOnlineDead }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_remOnlineDead
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_remOnlineDead.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::remOnlineDead';
end;//Tkw_FormUserType_remOnlineDead.GetWordNameForRegister

function Tkw_FormUserType_remOnlineDead.GetInteger: Integer;
begin
 Result := remOnlineDead;
end;//Tkw_FormUserType_remOnlineDead.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_remOnlineDead.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_remOnlineDead }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
