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
 , Base_Operations_F1Services_Contracts
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Tmo_Folders);
 {* ����������� Folders }
{$IfEnd} // NOT Defined(NoScripts)
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Folders, '�����'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Folders, 'MyConsultations', '��� ������������', False, mod_opcode_FoldersService_MyConsultations));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Folders, 'MyInformation', '��� ����������', False, mod_opcode_FoldersService_MyInformation));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Folders, 'OpenFrmAct', '��� ���������', False, mod_opcode_FoldersService_OpenFrmAct));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Folders, 'UnderControlOpenFrmAct', '��������� �� ��������', False, mod_opcode_FoldersService_UnderControlOpenFrmAct));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
