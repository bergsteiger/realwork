unit moDocument;
 {* �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moDocument.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "Document" MUID: (4A7714BC0212)
// ��� ����: "Tmo_Document"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Document_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_Document = {final} class(TDocumentModule)
  {* �������� }
 end;//Tmo_Document

var g_module_opcode_Document_OpenDocOnNumber: TvcmMOPID = (rMoID : -1; rOpID : -1);
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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Document, '��������'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Document, 'OpenDocOnNumber', '������� �������� �� ������', False, g_module_opcode_Document_OpenDocOnNumber));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
