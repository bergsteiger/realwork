unit kw_ToolbarMenu_opCustomize;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/common/components/gui/Garant/VCM/View/ToolbarMenu/kw_ToolbarMenu_opCustomize.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi Operations::VCMCustomization::View::ToolbarMenu::Tkw_ToolbarMenu_opCustomize
//
// Слово словаря для вызова операции модуля ToolbarMenu.Customize (Настройка системы Настройка...)
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
 Tkw_ToolbarMenu_opCustomize = {final scriptword} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля ToolbarMenu.Customize (Настройка системы Настройка...) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_ToolbarMenu_opCustomize
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class Tkw_ToolbarMenu_opCustomize

class function Tkw_ToolbarMenu_opCustomize.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'моп::Настройка_системы_Настройка...';
end;//Tkw_ToolbarMenu_opCustomize.GetWordNameForRegister

class function Tkw_ToolbarMenu_opCustomize.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_ToolbarMenu_Customize;
end;//Tkw_ToolbarMenu_opCustomize.GetModuleOperationCode

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_ToolbarMenu_opCustomize
 Tkw_ToolbarMenu_opCustomize.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.