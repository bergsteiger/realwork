unit kw_TasksPanelMenu_opCustomize;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/common/components/gui/Garant/VCM/View/TasksPanel/kw_TasksPanelMenu_opCustomize.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi Operations::VCMCustomization::View::TasksPanel::Tkw_TasksPanelMenu_opCustomize
//
// Слово словаря для вызова операции модуля TasksPanelMenu.Customize (Настройка панели задач
// Настройка...)
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
 Tkw_TasksPanelMenu_opCustomize = {final scriptword} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля TasksPanelMenu.Customize (Настройка панели задач Настройка...) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_TasksPanelMenu_opCustomize
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class Tkw_TasksPanelMenu_opCustomize

class function Tkw_TasksPanelMenu_opCustomize.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'моп::Настройка_панели_задач_Настройка...';
end;//Tkw_TasksPanelMenu_opCustomize.GetWordNameForRegister

class function Tkw_TasksPanelMenu_opCustomize.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_TasksPanelMenu_Customize;
end;//Tkw_TasksPanelMenu_opCustomize.GetModuleOperationCode

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_TasksPanelMenu_opCustomize
 Tkw_TasksPanelMenu_opCustomize.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.