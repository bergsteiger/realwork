unit moTasksPanelMenu;
 {* ��������� ������ ����� }

// ������: "w:\common\components\gui\Garant\VCM\View\TasksPanel\moTasksPanelMenu.pas"
// ���������: "VCMFormsPack"
// ������� ������: "TasksPanelMenu" MUID: (4C8DE85601C4)
// ��� ����: "Tmo_TasksPanelMenu"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimTasksPanelMenu_Module
 , vcmExternalInterfaces
 , vcmModule
;

type
 Tmo_TasksPanelMenu = {final} class(TPrimTasksPanelMenuModule)
  {* ��������� ������ ����� }
 end;//Tmo_TasksPanelMenu
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmModulesForRegister
 , vcmModuleOperationsForRegister
 , VCMCustomization_Customization_Contracts
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_TasksPanelMenu, '��������� ������ �����'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_TasksPanelMenu, 'Customize', '���������...', False, g_module_opcode_TaskPanelService_Customize));
{$IfEnd} // NOT Defined(NoVCM)

end.
