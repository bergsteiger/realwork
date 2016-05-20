unit TasksPanel_Form;
 {* Панель задач }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\TasksPanel_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "TasksPanel" MUID: (4ABBAC4D02D9)
// Имя типа: "Ten_TasksPanel"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimTasksPanel_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Ten_TasksPanel = {final} class(TPrimTasksPanelForm, TasksPanelFormDef)
  {* Панель задач }
   Entities : TvcmEntities;
 end;//Ten_TasksPanel
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TasksPanelKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_TasksPanel);
 {* Регистрация TasksPanel }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_TasksPanel.SetFactory(Ten_TasksPanel.Make);
 {* Регистрация фабрики формы TasksPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
