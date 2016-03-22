unit BaloonWarningUserTypes_WarnPreActive_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnPreActive_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "WarnPreActive" MUID: (4DA82956005C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnJuror_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы WarnPreActive }
 WarnPreActiveName = 'WarnPreActive';
  {* Строковый идентификатор пользовательского типа "" }
 WarnPreActive = TvcmUserType(WarnJuror + 1);
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
 Tkw_FormUserType_WarnPreActive = {final} class(TtfwInteger)
  {* Слово словаря для типа формы WarnPreActive }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_WarnPreActive
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_WarnPreActive.GetInteger: Integer;
begin
 Result := WarnPreActive;
end;//Tkw_FormUserType_WarnPreActive.GetInteger

class function Tkw_FormUserType_WarnPreActive.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::WarnPreActive';
end;//Tkw_FormUserType_WarnPreActive.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnPreActive.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_WarnPreActive }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
