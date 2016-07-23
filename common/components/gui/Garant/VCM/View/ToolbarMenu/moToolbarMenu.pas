unit moToolbarMenu;
 {* ��������� ������� }

// ������: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\moToolbarMenu.pas"
// ���������: "VCMFormsPack"
// ������� ������: "ToolbarMenu" MUID: (4C8E34280227)
// ��� ����: "Tmo_ToolbarMenu"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimToolbarMenu_Module
 , vcmExternalInterfaces
 , vcmModule
;

type
 Tmo_ToolbarMenu = {final} class(TPrimToolbarMenuModule)
  {* ��������� ������� }
 end;//Tmo_ToolbarMenu
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_ToolbarMenu, '��������� �������'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_ToolbarMenu, 'AvailableOperations', '��������� ��������...', False, g_module_opcode_ToolbarMenuService_AvailableOperations));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_ToolbarMenu, 'Customize', '���������...', False, g_module_opcode_ToolbarMenuService_Customize));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_ToolbarMenu, 'Fasten', '��������� ������ ������������', False, g_module_opcode_ToolbarMenuService_Fasten));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_ToolbarMenu, 'IconsSize', '������ ������', False, g_module_opcode_ToolbarMenuService_IconsSize));
{$IfEnd} // NOT Defined(NoVCM)

end.
