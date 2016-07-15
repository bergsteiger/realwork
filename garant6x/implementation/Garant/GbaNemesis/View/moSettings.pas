unit moSettings;
 {* ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moSettings.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "Settings" MUID: (4AA79F3C03BE)
// ��� ����: "Tmo_Settings"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Settings_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_Settings = {final} class(TSettingsModule)
  {* ��������� }
 end;//Tmo_Settings

var g_module_opcode_Settings_OpenStyleEditorAsModal: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Settings_AutoLogin: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Settings_SelectConfig: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Settings_OpenConfList: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Settings_LoadActiveSettings: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Settings_UserProperties: TvcmMOPID = (rMoID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModulesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Settings, '���������'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'OpenStyleEditorAsModal', '�������� ������...', False, g_module_opcode_Settings_OpenStyleEditorAsModal));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'AutoLogin', '�������������� ���� � �������', False, g_module_opcode_Settings_AutoLogin));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'SelectConfig', '����� ������������', False, g_module_opcode_Settings_SelectConfig));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'OpenConfList', '������ ������������', False, g_module_opcode_Settings_OpenConfList));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'LoadActiveSettings', '��������� ������������...', False, g_module_opcode_Settings_LoadActiveSettings));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'UserProperties', '�������� ��� ��������������� ������...', False, g_module_opcode_Settings_UserProperties));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
