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

var g_module_opcode_ToolbarMenu_Customize: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_ToolbarMenu_AvailableOperations: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_ToolbarMenu_IconsSize: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_ToolbarMenu_Fasten: TvcmMOPID = (rMoID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmModulesForRegister
 , vcmModuleOperationsForRegister
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_ToolbarMenu, '��������� �������'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_ToolbarMenu, 'Customize', '���������...', False, g_module_opcode_ToolbarMenu_Customize));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_ToolbarMenu, 'AvailableOperations', '��������� ��������...', False, g_module_opcode_ToolbarMenu_AvailableOperations));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_ToolbarMenu, 'IconsSize', '������ ������', False, g_module_opcode_ToolbarMenu_IconsSize));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_ToolbarMenu, 'Fasten', '��������� ������ ������������', False, g_module_opcode_ToolbarMenu_Fasten));
{$IfEnd} // NOT Defined(NoVCM)

end.
