unit moDocument;
 {* �������� }

// ������: "w:\common\components\SandBox\VCM\View\moDocument.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "Document" MUID: (5216340000E6)
// ��� ����: "Tmo_Document"

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

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

implementation

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

end.
