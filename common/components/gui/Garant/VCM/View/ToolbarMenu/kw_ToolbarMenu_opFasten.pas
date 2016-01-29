unit kw_ToolbarMenu_opFasten;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/common/components/gui/Garant/VCM/View/ToolbarMenu/kw_ToolbarMenu_opFasten.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi Operations::VCMCustomization::View::ToolbarMenu::Tkw_ToolbarMenu_opFasten
//
// Слово словаря для вызова операции модуля ToolbarMenu.Fasten (Настройка системы Закрепить панели
// инструментов)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  tfwModuleOperationWord,
  vcmExternalInterfaces
  ;
{$IfEnd} //not NoScripts AND not NoVCM


implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  StdRes
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}
type
 Tkw_ToolbarMenu_opFasten = {final scriptword} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля ToolbarMenu.Fasten (Настройка системы Закрепить панели инструментов) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_ToolbarMenu_opFasten
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class Tkw_ToolbarMenu_opFasten

class function Tkw_ToolbarMenu_opFasten.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'моп::Настройка_системы_Закрепить_панели_инструментов';
end;//Tkw_ToolbarMenu_opFasten.GetWordNameForRegister

class function Tkw_ToolbarMenu_opFasten.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_ToolbarMenu_Fasten;
end;//Tkw_ToolbarMenu_opFasten.GetModuleOperationCode

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_ToolbarMenu_opFasten
 Tkw_ToolbarMenu_opFasten.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.