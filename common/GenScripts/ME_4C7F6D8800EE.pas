unit DiffOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\DiffOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Diff_Form
;

type
 TDiffOptionsForm = {abstract} class(TDiffForm)
  public
   {$If NOT Defined(NoVCM)}
   procedure Print; override;
    {* Печать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintDialog; override;
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ToMSWord; override;
    {* Экспорт в Word }
 end;//TDiffOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
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

{$If NOT Defined(NoVCM)}
procedure TDiffOptionsForm.Print;
 {* Печать }
//#UC START# *49521D8E0295_4C7F6D8800EE_var*
//#UC END# *49521D8E0295_4C7F6D8800EE_var*
begin
//#UC START# *49521D8E0295_4C7F6D8800EE_impl*
 !!! Needs to be implemented !!!
//#UC END# *49521D8E0295_4C7F6D8800EE_impl*
end;//TDiffOptionsForm.Print
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TDiffOptionsForm.PrintDialog;
 {* Печать... }
//#UC START# *495220DE0298_4C7F6D8800EE_var*
//#UC END# *495220DE0298_4C7F6D8800EE_var*
begin
//#UC START# *495220DE0298_4C7F6D8800EE_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220DE0298_4C7F6D8800EE_impl*
end;//TDiffOptionsForm.PrintDialog
{$IfEnd} // NOT Defined(NoVCM)

procedure TDiffOptionsForm.ToMSWord;
 {* Экспорт в Word }
//#UC START# *495238EB0160_4C7F6D8800EE_var*
//#UC END# *495238EB0160_4C7F6D8800EE_var*
begin
//#UC START# *495238EB0160_4C7F6D8800EE_impl*
 !!! Needs to be implemented !!!
//#UC END# *495238EB0160_4C7F6D8800EE_impl*
end;//TDiffOptionsForm.ToMSWord

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TDiffOptionsForm);
 {* Регистрация DiffOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
