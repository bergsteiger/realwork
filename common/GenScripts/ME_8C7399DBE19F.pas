unit kw_Inpharm_opMedicDiction;
 {* Слово словаря для вызова операции модуля Inpharm.MedicDiction$Op (Инфарм Словарь медицинских терминов) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\kw_Inpharm_opMedicDiction.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Inpharm_opMedicDiction" MUID: (8C7399DBE19F)

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
 Tkw_Inpharm_opMedicDiction = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Inpharm.MedicDiction$Op (Инфарм Словарь медицинских терминов) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Inpharm_opMedicDiction

class function Tkw_Inpharm_opMedicDiction.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Инфарм_Словарь_медицинских_терминов';
end;//Tkw_Inpharm_opMedicDiction.GetWordNameForRegister

class function Tkw_Inpharm_opMedicDiction.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Inpharm_MedicDiction;
end;//Tkw_Inpharm_opMedicDiction.GetModuleOperationCode

initialization
 Tkw_Inpharm_opMedicDiction.RegisterInEngine;
 {* Регистрация Tkw_Inpharm_opMedicDiction }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
