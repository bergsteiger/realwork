unit kw_Common_opTasksPanel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/kw_Common_opTasksPanel.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Core::Common::View::Common::Tkw_Common_opTasksPanel
//
// Слово словаря для вызова операции модуля Common.TasksPanel$Op (Окна Панель задач)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  tfwModuleOperationWord
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts


implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
 Tkw_Common_opTasksPanel = {final scriptword} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Common.TasksPanel$Op (Окна Панель задач) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   {$If not defined(NoScripts) AND not defined(NoVCM)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts AND not NoVCM
 end;//Tkw_Common_opTasksPanel
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_Common_opTasksPanel

class function Tkw_Common_opTasksPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'моп::Окна_Панель_задач';
end;//Tkw_Common_opTasksPanel.GetWordNameForRegister

{$If not defined(NoScripts) AND not defined(NoVCM)}
class function Tkw_Common_opTasksPanel.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_Common_TasksPanel;
end;//Tkw_Common_opTasksPanel.GetModuleOperationCode
{$IfEnd} //not NoScripts AND not NoVCM

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Common_opTasksPanel
 Tkw_Common_opTasksPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.