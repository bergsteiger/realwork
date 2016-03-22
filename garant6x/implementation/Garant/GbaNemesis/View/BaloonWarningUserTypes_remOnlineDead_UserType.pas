unit BaloonWarningUserTypes_remOnlineDead_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_remOnlineDead_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "remOnlineDead" MUID: (4DBFF5D40211)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_remUnreadConsultations_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_remOnlineDead = {final} class(TtfwInteger)
  {* Слово словаря для типа формы remOnlineDead }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_remOnlineDead
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_remOnlineDead.GetInteger: Integer;
begin
 Result := remOnlineDead;
end;//Tkw_FormUserType_remOnlineDead.GetInteger

class function Tkw_FormUserType_remOnlineDead.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::remOnlineDead';
end;//Tkw_FormUserType_remOnlineDead.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_remOnlineDead.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_remOnlineDead }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
