unit moCommon;
 {* ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moCommon.pas"
// ���������: "VCMFormsPack"
// ������� ������: "Common" MUID: (4A8EC7F80245)
// ��� ����: "Tmo_Common"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimF1Common_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_Common = {final} class(TPrimF1CommonModule)
  {* ���� }
 end;//Tmo_Common
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsDataExchangeRealization
 {$If NOT Defined(NoVCM)}
 , vcmModulesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 , Common_F1CommonServices_Contracts
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Common, '����'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'ComplectInfo', '���������� � ���������', False, mod_opcode_CommonService_ComplectInfo));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'LetterToDevelopers', '������ �������������', True, mod_opcode_CommonService_LetterToDevelopers));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'OpenInformation', '���������� ����������', False, mod_opcode_CommonService_OpenInformation));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'OpenIntranet', '', False, mod_opcode_CommonService_OpenIntranet));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'OpenMainMenuByButton', '�������� ���� ������� ������', False, mod_opcode_CommonService_OpenMainMenuByButton));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'OpenMainMenuNew', '�������� ����', True, mod_opcode_CommonService_OpenMainMenuNew));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'OpenRubricator', '�������� ���������', False, mod_opcode_CommonService_OpenRubricator));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'PageSetup', '��������� ��������...', False, mod_opcode_CommonService_PageSetup));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'ShowEULA', '������� �������������', False, mod_opcode_CommonService_ShowEULA));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'TasksPanel', '������ �����', False, mod_opcode_CommonService_TasksPanel));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Common, 'get_navigator', '���� (�������)', True, mod_opcode_CommonService_get_navigator));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
