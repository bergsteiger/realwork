unit DocumentWithFlash_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\DocumentWithFlash_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "DocumentWithFlash" MUID: (4989E67D00C0)
// ��� ����: "TDocumentWithFlashForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDocumentWithFlashOptions_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TDocumentWithFlashForm = {final} class(TPrimDocumentWithFlashOptionsForm, DocumentWithFlashFormDef)
   Entities : TvcmEntities;
 end;//TDocumentWithFlashForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , DocumentWithFlashKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_DocumentWithFlashForm.SetFactory(TDocumentWithFlashForm.Make);
 {* ����������� ������� ����� DocumentWithFlash }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TDocumentWithFlashForm);
 {* ����������� DocumentWithFlash }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
