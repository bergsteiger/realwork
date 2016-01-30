unit WarningUserTypes_Warning_UserType;
 {* Предупреждение }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WarningUserTypes_Warning_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы Warning }
 WarningName = 'Warning';
  {* Строковый идентификатор пользовательского типа "Предупреждение" }
 Warning = TvcmUserType(0);
  {* Предупреждение }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_Warning = {final} class(TtfwInteger)
  {* Слово словаря для типа формы Warning }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_Warning
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_Warning.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::Warning';
end;//Tkw_FormUserType_Warning.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_Warning.GetInteger: Integer;
begin
 Result := Warning;
end;//Tkw_FormUserType_Warning.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_Warning.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_Warning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
