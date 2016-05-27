unit RightEdition_Form;
 {* ������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\RightEdition_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "RightEdition" MUID: (4A6EC062005F)
// ��� ����: "TRightEditionForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimRightEdition_Form
 , CompareEditions_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
 , vtPanel
 , vtFocusLabel
;

type
 TRightEditionForm = {final} class(TPrimRightEditionForm, RightEditionFormDef)
  {* ������� �������� }
   Entities : TvcmEntities;
   Header : TvtPanel;
   pnLeft : TvtPanel;
   EditionLink : TvtFocusLabel;
   pnCaption : TvtPanel;
 end;//TRightEditionForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , RightEditionKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , DataAdapter
 , Base_Operations_View_Controls
 , BaseSearchInterfaces
 , SysUtils
 , l3Base
 , l3InterfacesMisc
 , nsBaseSearchService
 , nsTrialSupport
 , FoldersDomainInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , Printers
 , nsExportToFileEvent
 , nsExportToWordEvent
 , nsSendDocumentByEMailEvent
 , nsDocumentPrintPreviewEvent
 , nsBaseTextOperationsConst
 , f1MultilinkResolver
 , Windows
 , l3Interfaces
 , evTypes
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , afwFacade
 , Classes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsConst
 , nsQuestions
 , nsExternalObjectModelPart
 , l3DialogService
 , bsDocumentContextSearcher
 , nsSearchInDocumentEvent
 , BaseTypesUnit
 , nsSearchInDocumentDoneEvent
 , nsSearchInDocumentNextEvent
 , nsSearchInDocumentPrevEvent
 , nsSearchWindowManager
 , l3String
 , Base_Operations_Strange_Controls
 , Common_FormDefinitions_Controls
 , nevNavigation
 , eeInterfaces
 , nevTools
 , evCustomEditor
 , evEditorWithOperations
;

{$R *.DFM}

initialization
 fm_RightEditionForm.SetFactory(TRightEditionForm.Make);
 {* ����������� ������� ����� RightEdition }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TRightEditionForm);
 {* ����������� RightEdition }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
