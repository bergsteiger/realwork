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
 , Base_Operations_F1Services_Contracts
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Settings, '���������'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'AutoLogin', '�������������� ���� � �������', False, mod_opcode_SettingsService_AutoLogin));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'LoadActiveSettings', '��������� ������������...', False, mod_opcode_SettingsService_LoadActiveSettings));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'OpenConfList', '������ ������������', False, mod_opcode_SettingsService_OpenConfList));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'OpenStyleEditorAsModal', '�������� ������...', False, mod_opcode_SettingsService_OpenStyleEditorAsModal));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'SelectConfig', '����� ������������', False, mod_opcode_SettingsService_SelectConfig));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Settings, 'UserProperties', '�������� ��� ��������������� ������...', False, mod_opcode_SettingsService_UserProperties));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
