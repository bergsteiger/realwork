unit PrimLeftEdition_Form;
 {* Текущая редакция }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimLeftEdition_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DiffOptions_Form
 , EditionsInterfaces
 , l3Tree_TLB
 , DocumentUnit
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimLeftEditionForm = {abstract} class(TDiffOptionsForm)
  {* Текущая редакция }
  private
   : IdsLeftEdition;
  protected
   function EditionsChooseRoot: Il3Node; override;
   procedure DoEditionChanged(anEditionID: TRedactionID); override;
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimLeftEditionForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , CompareEditions_Controls
 , l3MessageID
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

const
 {* Локализуемые строки utLeftEditionLocalConstants }
 str_utLeftEditionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utLeftEditionCaption'; rValue : 'Предыдущая редакция');
  {* Заголовок пользовательского типа "Предыдущая редакция" }

function TPrimLeftEditionForm.EditionsChooseRoot: Il3Node;
//#UC START# *4B55ADAD0005_4A6D5A80013C_var*
//#UC END# *4B55ADAD0005_4A6D5A80013C_var*
begin
//#UC START# *4B55ADAD0005_4A6D5A80013C_impl*
 if (ViewArea <> nil) then
  Result := ViewArea.PrevEditions
 else
  Result := nil; 
//#UC END# *4B55ADAD0005_4A6D5A80013C_impl*
end;//TPrimLeftEditionForm.EditionsChooseRoot

procedure TPrimLeftEditionForm.DoEditionChanged(anEditionID: TRedactionID);
//#UC START# *4B55BB7F0172_4A6D5A80013C_var*
//#UC END# *4B55BB7F0172_4A6D5A80013C_var*
begin
//#UC START# *4B55BB7F0172_4A6D5A80013C_impl*
 if not f_InChoosenEditionChanged then
 begin
  f_InChoosenEditionChanged := true;
  try
   if (CompareEditions.EditionForCompare <> anEditionID) then
   begin
    Op_RightEdition_SetFocusToText.Call(Aggregate);
    CompareEditions.EditionForCompare := anEditionID;
   end;//CompareEditions.EditionForCompare <> anEditionID;
  finally
   f_InChoosenEditionChanged := false;
  end;//try..finally
 end;//not f_InChoosenEditionChanged
//#UC END# *4B55BB7F0172_4A6D5A80013C_impl*
end;//TPrimLeftEditionForm.DoEditionChanged

{$If NOT Defined(NoVCM)}
procedure TPrimLeftEditionForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_4A6D5A80013C_var*
//#UC END# *497469C90140_4A6D5A80013C_var*
begin
//#UC START# *497469C90140_4A6D5A80013C_impl*
 inherited;
 //UpdateEditionsChoose;
//#UC END# *497469C90140_4A6D5A80013C_impl*
end;//TPrimLeftEditionForm.NotifyDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimLeftEditionForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4A6D5A80013C_var*
//#UC END# *4A8E8F2E0195_4A6D5A80013C_var*
begin
//#UC START# *4A8E8F2E0195_4A6D5A80013C_impl*
 inherited;
(* with EditionChoose do
 begin
  OnEndTextPrint := EditionChanged;
 end;//with EditionChoose*)
//#UC END# *4A8E8F2E0195_4A6D5A80013C_impl*
end;//TPrimLeftEditionForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_utLeftEditionCaption.Init;
 {* Инициализация str_utLeftEditionCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimLeftEditionForm);
 {* Регистрация PrimLeftEdition }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
