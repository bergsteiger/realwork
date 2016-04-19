unit kw_Common_OpenMainMenuNew;
 {* Слово словаря для вызова операции модуля Common.OpenMainMenuNew (Окна Основное меню) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\kw_Common_OpenMainMenuNew.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Common_OpenMainMenuNew" MUID: (34770F0004CA)

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
 Tkw_Common_OpenMainMenuNew = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Common.OpenMainMenuNew (Окна Основное меню) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Common_OpenMainMenuNew

class function Tkw_Common_OpenMainMenuNew.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Окна_Основное_меню';
end;//Tkw_Common_OpenMainMenuNew.GetWordNameForRegister

class function Tkw_Common_OpenMainMenuNew.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Common_OpenMainMenuNew;
end;//Tkw_Common_OpenMainMenuNew.GetModuleOperationCode

initialization
 Tkw_Common_OpenMainMenuNew.RegisterInEngine;
 {* Регистрация Tkw_Common_OpenMainMenuNew }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
