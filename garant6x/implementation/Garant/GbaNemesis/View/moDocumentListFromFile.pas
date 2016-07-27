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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_DocumentListFromFile, '������ ���������� �� �����'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_DocumentListFromFile, 'OpenDocumentListFromFile', '������� ������ ���������� �� �����', False, mod_opcode_DocumentListFromFileService_OpenDocumentListFromFile));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
