unit kw_Inpharm_opMedicFirms;
 {* Слово словаря для вызова операции модуля Inpharm.MedicFirms (Инфарм Фармацевтические фирмы) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\kw_Inpharm_opMedicFirms.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Inpharm_opMedicFirms" MUID: (0035FE551F6A)

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
 Tkw_Inpharm_opMedicFirms = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Inpharm.MedicFirms (Инфарм Фармацевтические фирмы) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Inpharm_opMedicFirms

class function Tkw_Inpharm_opMedicFirms.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Инфарм_Фармацевтические_фирмы';
end;//Tkw_Inpharm_opMedicFirms.GetWordNameForRegister

class function Tkw_Inpharm_opMedicFirms.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Inpharm_MedicFirms;
end;//Tkw_Inpharm_opMedicFirms.GetModuleOperationCode

initialization
 Tkw_Inpharm_opMedicFirms.RegisterInEngine;
 {* Регистрация Tkw_Inpharm_opMedicFirms }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
