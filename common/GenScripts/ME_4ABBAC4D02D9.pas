unit TasksPanel_Form;
 {* Панель задач }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\TasksPanel_Form.pas"
// Стереотип: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimTasksPanel_Form
 , Common_FormDefinitions_Controls
;

type
 Ten_TasksPanel = {final} class(TPrimTasksPanelForm, TasksPanelFormDef)
  {* Панель задач }
 end;//Ten_TasksPanel
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TasksPanelKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_TasksPanel);
 {* Регистрация TasksPanel }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_TasksPanel.SetFactory(Ten_TasksPanel.Make);
 {* Регистрация фабрики формы TasksPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
