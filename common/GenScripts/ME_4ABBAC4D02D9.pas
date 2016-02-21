unit TasksPanel_Form;
 {* ������ ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\TasksPanel_Form.pas"
// ���������: "VCMFinalForm"

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
  {* ������ ����� }
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
 {* ����������� TasksPanel }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_TasksPanel.SetFactory(Ten_TasksPanel.Make);
 {* ����������� ������� ����� TasksPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
