unit kw_Settings_opAutoLogin;
 {* Слово словаря для вызова операции модуля Settings.AutoLogin (Установки Автоматический вход в систему) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\kw_Settings_opAutoLogin.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Settings_opAutoLogin" MUID: (AAA23B8FBC63)

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
 Tkw_Settings_opAutoLogin = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Settings.AutoLogin (Установки Автоматический вход в систему) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Settings_opAutoLogin

class function Tkw_Settings_opAutoLogin.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Установки_Автоматический_вход_в_систему';
end;//Tkw_Settings_opAutoLogin.GetWordNameForRegister

class function Tkw_Settings_opAutoLogin.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Settings_AutoLogin;
end;//Tkw_Settings_opAutoLogin.GetModuleOperationCode

initialization
 Tkw_Settings_opAutoLogin.RegisterInEngine;
 {* Регистрация Tkw_Settings_opAutoLogin }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
