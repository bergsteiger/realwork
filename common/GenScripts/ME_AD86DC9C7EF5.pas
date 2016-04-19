unit kw_WorkJournal_opOpenJournal;
 {* Слово словаря для вызова операции модуля WorkJournal.OpenJournal (Журнал работы) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\kw_WorkJournal_opOpenJournal.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_WorkJournal_opOpenJournal" MUID: (AD86DC9C7EF5)

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
 Tkw_WorkJournal_opOpenJournal = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля WorkJournal.OpenJournal (Журнал работы) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_WorkJournal_opOpenJournal

class function Tkw_WorkJournal_opOpenJournal.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Журнал_работы_OpenJournal';
end;//Tkw_WorkJournal_opOpenJournal.GetWordNameForRegister

class function Tkw_WorkJournal_opOpenJournal.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_WorkJournal_OpenJournal;
end;//Tkw_WorkJournal_opOpenJournal.GetModuleOperationCode

initialization
 Tkw_WorkJournal_opOpenJournal.RegisterInEngine;
 {* Регистрация Tkw_WorkJournal_opOpenJournal }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
