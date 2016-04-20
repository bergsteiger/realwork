unit kw_Settings_opUserProperties;
 {* Слово словаря для вызова операции модуля Settings.UserProperties (Установки Изменить мои регистрационные данные...) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\kw_Settings_opUserProperties.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Settings_opUserProperties" MUID: (08C8B06C1F0E)

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
 Tkw_Settings_opUserProperties = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Settings.UserProperties (Установки Изменить мои регистрационные данные...) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Settings_opUserProperties

class function Tkw_Settings_opUserProperties.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Установки_Изменить_мои_регистрационные_данные...';
end;//Tkw_Settings_opUserProperties.GetWordNameForRegister

class function Tkw_Settings_opUserProperties.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Settings_UserProperties;
end;//Tkw_Settings_opUserProperties.GetModuleOperationCode

initialization
 Tkw_Settings_opUserProperties.RegisterInEngine;
 {* Регистрация Tkw_Settings_opUserProperties }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
