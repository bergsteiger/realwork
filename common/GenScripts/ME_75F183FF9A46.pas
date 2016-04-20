unit kw_Settings_opLoadActiveSettings;
 {* Слово словаря для вызова операции модуля Settings.LoadActiveSettings (Установки Настройка конфигурации...) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\kw_Settings_opLoadActiveSettings.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Settings_opLoadActiveSettings" MUID: (75F183FF9A46)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , tfwModuleOperationWord
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

{$If NOT Defined(NoVCM)}
type
 Tkw_Settings_opLoadActiveSettings = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Settings.LoadActiveSettings (Установки Настройка конфигурации...) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Settings_opLoadActiveSettings

class function Tkw_Settings_opLoadActiveSettings.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Установки_Настройка_конфигурации...';
end;//Tkw_Settings_opLoadActiveSettings.GetWordNameForRegister

class function Tkw_Settings_opLoadActiveSettings.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Settings_LoadActiveSettings;
end;//Tkw_Settings_opLoadActiveSettings.GetModuleOperationCode

initialization
 Tkw_Settings_opLoadActiveSettings.RegisterInEngine;
 {* Регистрация Tkw_Settings_opLoadActiveSettings }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
