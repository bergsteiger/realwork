unit PrimSettings_cutSettings_UserType;
 {* Настройка конфигурации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimSettings_cutSettings_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "cutSettings" MUID: (4C6D0A3801F3)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы cutSettings }
 cutSettingsName = 'cutSettings';
  {* Строковый идентификатор пользовательского типа "Настройка конфигурации" }
 cutSettings = TvcmUserType(0);
  {* Настройка конфигурации }
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
 Tkw_FormUserType_cutSettings = {final} class(TtfwInteger)
  {* Слово словаря для типа формы cutSettings }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_cutSettings
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_cutSettings.GetInteger: Integer;
begin
 Result := cutSettings;
end;//Tkw_FormUserType_cutSettings.GetInteger

class function Tkw_FormUserType_cutSettings.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::cutSettings';
end;//Tkw_FormUserType_cutSettings.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cutSettings.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_cutSettings }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
