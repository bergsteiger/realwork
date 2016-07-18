unit moDocumentListFromFile;
 {* ������ ���������� �� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moDocumentListFromFile.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "DocumentListFromFile" MUID: (4DA44B030054)
// ��� ����: "Tmo_DocumentListFromFile"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDocumentListFromFile_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_DocumentListFromFile = {final} class(TPrimDocumentListFromFileModule)
  {* ������ ���������� �� ����� }
 end;//Tmo_DocumentListFromFile

var g_module_opcode_DocumentListFromFile_OpenDocumentListFromFile: TvcmMOPID = (rMoID : -1; rOpID : -1);
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_DocumentListFromFile, '������ ���������� �� �����'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_DocumentListFromFile, 'OpenDocumentListFromFile', '������� ������ ���������� �� �����', False, g_module_opcode_DocumentListFromFile_OpenDocumentListFromFile));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
