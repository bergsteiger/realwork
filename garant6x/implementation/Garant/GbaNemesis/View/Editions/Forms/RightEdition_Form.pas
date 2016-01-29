unit RightEdition_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Editions/Forms/RightEdition_Form.pas"
// Начат: 28.07.2009 13:10
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Пользовательские сервисы::CompareEditions::View::Editions::BaseEditions::RightEdition
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
  PrimRightEdition_Form,
  CompareEditions_FormDefinitions_Controls,
  vtPanel,
  vtFocusLabel
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  vtComboBoxQS
  {$If defined(Nemesis)}
  ,
  nscEditor
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  ,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  TRightEditionForm = {final form} class(TPrimRightEditionForm, RightEditionFormDef)
   {* Текущая редакция }
  Entities : TvcmEntities;
  Header: TvtPanel;
  pnLeft: TvtPanel;
  EditionLink: TvtFocusLabel;
  pnCaption: TvtPanel;
  end;//TRightEditionForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$R *.DFM}

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
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
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  RightEditionKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация RightEdition
 TtfwClassRef.Register(TRightEditionForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация фабрики формы RightEdition
 fm_RightEditionForm.SetFactory(TRightEditionForm.Make);
{$IfEnd} //not Admin AND not Monitorings

end.