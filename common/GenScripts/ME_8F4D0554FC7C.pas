unit kw_Common_opShowEULA;
 {* Слово словаря для вызова операции модуля Common.ShowEULA (Окна Условия использования) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\kw_Common_opShowEULA.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Common_opShowEULA" MUID: (8F4D0554FC7C)

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
 Tkw_Common_opShowEULA = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Common.ShowEULA (Окна Условия использования) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Common_opShowEULA

class function Tkw_Common_opShowEULA.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Окна_Условия_использования';
end;//Tkw_Common_opShowEULA.GetWordNameForRegister

class function Tkw_Common_opShowEULA.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Common_ShowEULA;
end;//Tkw_Common_opShowEULA.GetModuleOperationCode

initialization
 Tkw_Common_opShowEULA.RegisterInEngine;
 {* Регистрация Tkw_Common_opShowEULA }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
