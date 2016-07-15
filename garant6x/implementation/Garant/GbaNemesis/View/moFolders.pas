unit moFolders;
 {* ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moFolders.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "Folders" MUID: (4A96B6E00382)
// ��� ����: "Tmo_Folders"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFolders_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_Folders = {final} class(TPrimFoldersModule)
  {* ����� }
 end;//Tmo_Folders

var g_module_opcode_Folders_MyInformation: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Folders_MyConsultations: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Folders_UnderControlOpenFrmAct: TvcmMOPID = (rMoID : -1; rOpID : -1);
var g_module_opcode_Folders_OpenFrmAct: TvcmMOPID = (rMoID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , vcmModulesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Tmo_Folders);
 {* ����������� Folders }
{$IfEnd} // NOT Defined(NoScripts)
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Folders, '�����'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Folders, 'MyInformation', '��� ����������', False, g_module_opcode_Folders_MyInformation));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Folders, 'MyConsultations', '��� ������������', False, g_module_opcode_Folders_MyConsultations));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Folders, 'UnderControlOpenFrmAct', '��������� �� ��������', False, g_module_opcode_Folders_UnderControlOpenFrmAct));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Folders, 'OpenFrmAct', '��� ���������', False, g_module_opcode_Folders_OpenFrmAct));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
