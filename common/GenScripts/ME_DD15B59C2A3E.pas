unit kw_ToolbarMenu_opCustomize;
 {* Слово словаря для вызова операции модуля ToolbarMenu.Customize (Настройка системы Настройка...) }

// Модуль: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\kw_ToolbarMenu_opCustomize.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_ToolbarMenu_opCustomize" MUID: (DD15B59C2A3E)

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
 Tkw_ToolbarMenu_opCustomize = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля ToolbarMenu.Customize (Настройка системы Настройка...) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_ToolbarMenu_opCustomize

class function Tkw_ToolbarMenu_opCustomize.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Настройка_системы_Настройка...';
end;//Tkw_ToolbarMenu_opCustomize.GetWordNameForRegister

class function Tkw_ToolbarMenu_opCustomize.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_ToolbarMenu_Customize;
end;//Tkw_ToolbarMenu_opCustomize.GetModuleOperationCode

initialization
 Tkw_ToolbarMenu_opCustomize.RegisterInEngine;
 {* Регистрация Tkw_ToolbarMenu_opCustomize }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
