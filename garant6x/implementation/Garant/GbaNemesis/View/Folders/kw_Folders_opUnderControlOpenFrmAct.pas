unit kw_Folders_opUnderControlOpenFrmAct;
 {* Слово словаря для вызова операции модуля Folders.UnderControlOpenFrmAct (Папки Документы на контроле) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\kw_Folders_opUnderControlOpenFrmAct.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Folders_opUnderControlOpenFrmAct" MUID: (5F4AF867A6B8)

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
 Tkw_Folders_opUnderControlOpenFrmAct = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Folders.UnderControlOpenFrmAct (Папки Документы на контроле) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Folders_opUnderControlOpenFrmAct

class function Tkw_Folders_opUnderControlOpenFrmAct.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Папки_Документы_на_контроле';
end;//Tkw_Folders_opUnderControlOpenFrmAct.GetWordNameForRegister

class function Tkw_Folders_opUnderControlOpenFrmAct.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Folders_UnderControlOpenFrmAct;
end;//Tkw_Folders_opUnderControlOpenFrmAct.GetModuleOperationCode

initialization
 Tkw_Folders_opUnderControlOpenFrmAct.RegisterInEngine;
 {* Регистрация Tkw_Folders_opUnderControlOpenFrmAct }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
