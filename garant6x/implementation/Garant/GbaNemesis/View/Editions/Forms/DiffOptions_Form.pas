unit DiffOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Editions/Forms/DiffOptions_Form.pas"
// Начат: 02.09.2010 13:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Пользовательские сервисы::CompareEditions::View::Editions::DiffOptions
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
  Diff_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TDiffOptionsForm = {abstract form} class(TDiffForm)
 protected
  procedure InitEntities; override;
 end;//TDiffOptionsForm

 TvcmEntityFormRef = TDiffOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
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
  Base_Operations_Editions_Controls,
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
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  ,
  Base_Operations_F1Specific_Controls
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TDiffOptionsForm

procedure TDiffOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  {$If not defined(NoVCM)}
  
  ShowInContextMenu(en_File, op_Print, false);
  ShowInToolbar(en_File, op_Print, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  
  ShowInContextMenu(en_File, op_PrintDialog, false);
  ShowInToolbar(en_File, op_PrintDialog, true);
  {$IfEnd} //not NoVCM

  
  ShowInContextMenu(en_File, op_ToMSWord, false);
  ShowInToolbar(en_File, op_ToMSWord, true);
 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация DiffOptions
 TtfwClassRef.Register(TDiffOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.