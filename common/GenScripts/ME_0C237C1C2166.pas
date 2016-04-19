unit kw_Folders_opMyConsultations;
 {* Слово словаря для вызова операции модуля Folders.MyConsultations (Папки Мои консультации) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\kw_Folders_opMyConsultations.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Folders_opMyConsultations" MUID: (0C237C1C2166)

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
 Tkw_Folders_opMyConsultations = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Folders.MyConsultations (Папки Мои консультации) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Folders_opMyConsultations

class function Tkw_Folders_opMyConsultations.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Папки_Мои_консультации';
end;//Tkw_Folders_opMyConsultations.GetWordNameForRegister

class function Tkw_Folders_opMyConsultations.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Folders_MyConsultations;
end;//Tkw_Folders_opMyConsultations.GetModuleOperationCode

initialization
 Tkw_Folders_opMyConsultations.RegisterInEngine;
 {* Регистрация Tkw_Folders_opMyConsultations }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
