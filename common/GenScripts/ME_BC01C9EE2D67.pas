unit kw_Common_opTasksPanel;
 {* Слово словаря для вызова операции модуля Common.TasksPanel$Op (Окна Панель задач) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\kw_Common_opTasksPanel.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Common_opTasksPanel" MUID: (BC01C9EE2D67)

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
 Tkw_Common_opTasksPanel = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Common.TasksPanel$Op (Окна Панель задач) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Common_opTasksPanel

class function Tkw_Common_opTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Окна_Панель_задач';
end;//Tkw_Common_opTasksPanel.GetWordNameForRegister

class function Tkw_Common_opTasksPanel.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Common_TasksPanel;
end;//Tkw_Common_opTasksPanel.GetModuleOperationCode

initialization
 Tkw_Common_opTasksPanel.RegisterInEngine;
 {* Регистрация Tkw_Common_opTasksPanel }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
