unit kw_Inpharm_opMedicMainMenu;
 {* Слово словаря для вызова операции модуля Inpharm.MedicMainMenu$Op (Инфарм Основное меню ИнФарм) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\kw_Inpharm_opMedicMainMenu.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Inpharm_opMedicMainMenu" MUID: (F85B9444EAAD)

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
 Tkw_Inpharm_opMedicMainMenu = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Inpharm.MedicMainMenu$Op (Инфарм Основное меню ИнФарм) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Inpharm_opMedicMainMenu

class function Tkw_Inpharm_opMedicMainMenu.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Инфарм_Основное_меню_ИнФарм';
end;//Tkw_Inpharm_opMedicMainMenu.GetWordNameForRegister

class function Tkw_Inpharm_opMedicMainMenu.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Inpharm_MedicMainMenu;
end;//Tkw_Inpharm_opMedicMainMenu.GetModuleOperationCode

initialization
 Tkw_Inpharm_opMedicMainMenu.RegisterInEngine;
 {* Регистрация Tkw_Inpharm_opMedicMainMenu }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
