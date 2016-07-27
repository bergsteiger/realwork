unit LeftEdition_Form;
 {* Предыдущая редакция }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\LeftEdition_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "LeftEdition" MUID: (4A6EC02E00EA)
// Имя типа: "TLeftEditionForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimLeftEdition_Form
 , CompareEditions_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
 , vtPanel
 , vtFocusLabel
;

type
 TLeftEditionForm = {final} class(TPrimLeftEditionForm, LeftEditionFormDef)
  {* Предыдущая редакция }
   Entities : TvcmEntities;
   Header : TvtPanel;
   pnLeft : TvtPanel;
   EditionLink : TvtFocusLabel;
   pnCaption : TvtPanel;
 end;//TLeftEditionForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , LeftEditionKeywordsPack
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
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
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
 , nsSaveDialogExecutor
 , l3BatchService
 , Base_Operations_F1Services_Contracts
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
 fm_LeftEditionForm.SetFactory(TLeftEditionForm.Make);
 {* Регистрация фабрики формы LeftEdition }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TLeftEditionForm);
 {* Регистрация LeftEdition }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
