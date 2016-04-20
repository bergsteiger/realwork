unit kw_Monitorings_opOpenNewsLine;
 {* Слово словаря для вызова операции модуля Monitorings.OpenNewsLine (Мониторинги Новостная лента) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\kw_Monitorings_opOpenNewsLine.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Monitorings_opOpenNewsLine" MUID: (9EC9D4649A50)

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
 Tkw_Monitorings_opOpenNewsLine = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Monitorings.OpenNewsLine (Мониторинги Новостная лента) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Monitorings_opOpenNewsLine

class function Tkw_Monitorings_opOpenNewsLine.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Мониторинги_Новостная_лента';
end;//Tkw_Monitorings_opOpenNewsLine.GetWordNameForRegister

class function Tkw_Monitorings_opOpenNewsLine.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Monitorings_OpenNewsLine;
end;//Tkw_Monitorings_opOpenNewsLine.GetModuleOperationCode

initialization
 Tkw_Monitorings_opOpenNewsLine.RegisterInEngine;
 {* Регистрация Tkw_Monitorings_opOpenNewsLine }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
