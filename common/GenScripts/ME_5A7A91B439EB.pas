unit kw_ToolbarMenu_opAvailableOperations;
 {* Слово словаря для вызова операции модуля ToolbarMenu.AvailableOperations (Настройка системы Доступные операции...) }

// Модуль: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\kw_ToolbarMenu_opAvailableOperations.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_ToolbarMenu_opAvailableOperations" MUID: (5A7A91B439EB)

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
 Tkw_ToolbarMenu_opAvailableOperations = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля ToolbarMenu.AvailableOperations (Настройка системы Доступные операции...) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_ToolbarMenu_opAvailableOperations

class function Tkw_ToolbarMenu_opAvailableOperations.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Настройка_системы_Доступные_операции...';
end;//Tkw_ToolbarMenu_opAvailableOperations.GetWordNameForRegister

class function Tkw_ToolbarMenu_opAvailableOperations.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_ToolbarMenu_AvailableOperations;
end;//Tkw_ToolbarMenu_opAvailableOperations.GetModuleOperationCode

initialization
 Tkw_ToolbarMenu_opAvailableOperations.RegisterInEngine;
 {* Регистрация Tkw_ToolbarMenu_opAvailableOperations }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
