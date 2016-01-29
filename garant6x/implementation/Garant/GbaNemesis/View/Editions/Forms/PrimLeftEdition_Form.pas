unit PrimLeftEdition_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Editions/Forms/PrimLeftEdition_Form.pas"
// Начат: 27.07.2009 11:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Пользовательские сервисы::CompareEditions::View::Editions::PrimLeftEdition
//
// Текущая редакция
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  EditionsInterfaces,
  Diff_Form,
  l3StringIDEx,
  DiffOptions_Form
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  PrimLeftEdition_utLeftEdition_UserType
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  l3Tree_TLB,
  DocumentUnit,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimLeftEditionForm = {abstract form} class(TDiffOptionsForm)
  {* Текущая редакция }
 private
 // private fields
   ViewArea : IdsLeftEdition;
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure MakeControls; override;
 protected
 // realized methods
   function EditionsChooseRoot: Il3Node; override;
   procedure DoEditionChanged(anEditionID: TRedactionID); override;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 end;//TPrimLeftEditionForm

 TvcmEntityFormRef = TPrimLeftEditionForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  CompareEditions_Controls,
  Base_Operations_Editions_Controls,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  DataAdapter,
  Base_Operations_View_Controls,
  DocumentRes,
  vtUtils,
  evdStyles,
  k2Tags,
  BitmapPara_Const,
  BaseSearchInterfaces,
  SysUtils,
  l3Base,
  l3InterfacesMisc,
  nsBaseSearchService,
  vcmBase {a},
  evdBlockNameAdder,
  l3Variant,
  nsDocumentTools,
  Windows,
  PresentationInterfaces,
  nsExternalObjectPrim,
  bsUtils,
  l3Stream,
  l3Types,
  nsToMSWordOp,
  l3String,
  nsTrialSupport,
  FoldersDomainInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  ,
  Printers,
  nsExportToFileEvent,
  nsExportToWordEvent,
  nsSendDocumentByEMailEvent,
  nsDocumentPrintPreviewEvent,
  nsBaseTextOperationsConst,
  f1MultilinkResolver,
  l3Interfaces,
  evTypes,
  afwFacade
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  nsConst,
  nsQuestions,
  nsExternalObjectModelPart,
  bsDocumentContextSearcher,
  nsSearchInDocumentEvent,
  BaseTypesUnit,
  nsSearchInDocumentDoneEvent,
  nsSearchInDocumentNextEvent,
  nsSearchInDocumentPrevEvent,
  nsSearchWindowManager,
  Base_Operations_Strange_Controls,
  Common_FormDefinitions_Controls,
  evOp
  {$If defined(Nemesis)}
  ,
  f1TextStyle_Const
  {$IfEnd} //Nemesis
  ,
  TextSegment_Const,
  StyledLeafPara_Const,
  evCustomEditorWindow
  {$If defined(k2ForEditor)}
  ,
  evSegLst
  {$IfEnd} //k2ForEditor
  ,
  evdTypes,
  nevNavigation,
  eeInterfaces,
  nevTools,
  evCustomEditor,
  evEditorWithOperations
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки utLeftEditionLocalConstants }
  str_utLeftEditionCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utLeftEditionCaption'; rValue : 'Предыдущая редакция');
   { Заголовок пользовательского типа "Предыдущая редакция" }

// start class TPrimLeftEditionForm

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

{$If not defined(NoVCM)}
procedure TPrimLeftEditionForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_4A6D5A80013C_var*
//#UC END# *497469C90140_4A6D5A80013C_var*
begin
//#UC START# *497469C90140_4A6D5A80013C_impl*
 inherited;
 //UpdateEditionsChoose;
//#UC END# *497469C90140_4A6D5A80013C_impl*
end;//TPrimLeftEditionForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimLeftEditionForm.InitControls;
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
{$IfEnd} //not NoVCM

procedure TPrimLeftEditionForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  ViewArea := nil;
 end//aDsNew = nil
 else
 begin
  ViewArea := aDsNew As IdsLeftEdition;
 end;//aDsNew = nil
end;

procedure TPrimLeftEditionForm.MakeControls;
begin
 inherited;
 with AddUsertype(utLeftEditionName,
  str_utLeftEditionCaption,
  str_utLeftEditionCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utLeftEditionName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utLeftEditionCaption
 str_utLeftEditionCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimLeftEdition
 TtfwClassRef.Register(TPrimLeftEditionForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.