unit kw_ToolbarMenu_opFasten;
 {* Слово словаря для вызова операции модуля ToolbarMenu.Fasten (Настройка системы Закрепить панели инструментов) }

// Модуль: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\kw_ToolbarMenu_opFasten.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_ToolbarMenu_opFasten" MUID: (9E97CDBDD43D)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwModuleOperationWord
 , vcmExternalInterfaces
 , StdRes
;

type
 Tkw_ToolbarMenu_opFasten = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля ToolbarMenu.Fasten (Настройка системы Закрепить панели инструментов) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_ToolbarMenu_opFasten

class function Tkw_ToolbarMenu_opFasten.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Настройка_системы_Закрепить_панели_инструментов';
end;//Tkw_ToolbarMenu_opFasten.GetWordNameForRegister

class function Tkw_ToolbarMenu_opFasten.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_ToolbarMenu_Fasten;
end;//Tkw_ToolbarMenu_opFasten.GetModuleOperationCode

initialization
 Tkw_ToolbarMenu_opFasten.RegisterInEngine;
 {* Регистрация Tkw_ToolbarMenu_opFasten }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
