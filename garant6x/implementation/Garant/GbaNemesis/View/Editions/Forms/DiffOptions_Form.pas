unit DiffOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\DiffOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "DiffOptions" MUID: (4C7F6D8800EE)
// Имя типа: "TDiffOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Diff_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TDiffOptionsForm = {abstract} class(TDiffForm)
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TDiffOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Specific_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , DataAdapter
 , Base_Operations_View_Controls
 , Base_Operations_F1Services_Contracts
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
 , nsSaveDialogExecutor
 , l3BatchService
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
 //#UC START# *4C7F6D8800EEimpl_uses*
 //#UC END# *4C7F6D8800EEimpl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TDiffOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  ShowInContextMenu(en_File, op_Print, False);
  ShowInToolbar(en_File, op_Print, False);
  ShowInContextMenu(en_File, op_PrintDialog, False);
  ShowInToolbar(en_File, op_PrintDialog, True);
  ShowInContextMenu(en_File, op_ToMSWord, False);
  ShowInToolbar(en_File, op_ToMSWord, True);
 end;//with Entities.Entities
end;//TDiffOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TDiffOptionsForm);
 {* Регистрация DiffOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
