unit PrimChangesBetweenEditons_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ChangesBetweenEditons/Forms/PrimChangesBetweenEditons_Form.pas"
// Начат: 25.05.2011 14:13
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Пользовательские сервисы::ChangesBetweenEditions::View::ChangesBetweenEditons::PrimChangesBetweenEditons
//
// Изменения в документе
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
  DocumentUnit,
  nevTools
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  Base_Operations_Editions_Controls,
  BaseSearchInterfaces,
  l3StringIDEx,
  ChangesBetweenEditionsInterfaces
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  l3Variant,
  eeInterfaces,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  Base_Operations_View_Controls,
  Search_Strange_Controls,
  nevBase,
  evCustomEditorWindow,
  ExternalOperationUnit,
  afwInterfaces,
  nevGUIInterfaces,
  afwNavigation,
  nevNavigation,
  NavigationInterfaces,
  DocumentInterfaces,
  bsTypesNew
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  l3Interfaces,
  l3InternalInterfaces,
  k2TagGen,
  k2CustomFileGenerator,
  l3BaseStream,
  DocumentAndListInterfaces
  {$If defined(Nemesis)}
  ,
  nscEditor
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  ,
  Base_Operations_F1Specific_Controls
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  ,
  nsTypes,
  Base_Operations_Strange_Controls,
  Common_Strange_Controls
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Text_Controls
  {$IfEnd} //not NoVCM
  ,
  PrimBaseSearchInterfaces,
  evdTypes,
  PrimChangesBetweenEditons_DocumentChanges_UserType
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _WorkWithRedactions_Parent_ = TvcmEntityForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\WorkWithRedactions.imp.pas}
 _DocumentPresentation_Parent_ = _WorkWithRedactions_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentPresentation.imp.pas}
 _TextWithComments_Parent_ = _DocumentPresentation_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\TextWithComments.imp.pas}
 _HyperlinkProcessorWithOwnLocalLink_Parent_ = _TextWithComments_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\HyperlinkProcessorWithOwnLocalLink.imp.pas}
 _StatusBarItems_Parent_ = _HyperlinkProcessorWithOwnLocalLink_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}
 _BaseSearchPresentation_Parent_ = _StatusBarItems_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentation.imp.pas}
 _BaseTextOperations_Parent_ = _BaseSearchPresentation_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseTextOperations.imp.pas}
 _DocumentBaseSearcher_Parent_ = _BaseTextOperations_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentBaseSearcher.imp.pas}
 _HyperlinkProcessorForDocumentCompare_Parent_ = _DocumentBaseSearcher_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\HyperlinkProcessorForDocumentCompare.imp.pas}
 _EditionsListCaller_Parent_ = _HyperlinkProcessorForDocumentCompare_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\EditionsListCaller.imp.pas}
 _HyperlinkOperations_Parent_ = _EditionsListCaller_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\HyperlinkOperations.imp.pas}
 TPrimChangesBetweenEditonsForm = {form} class(_HyperlinkOperations_, InsBaseSearchPresentation)
  {* Изменения в документе }
 private
 // private fields
   ViewArea : IdsChangesBetweenEditions;
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure MakeDocumentContainer(aSender: TObject;
     var aMade: InevDocumentContainer);
   procedure TextSourceDocumentChanged(aSender: TObject;
     anOldDocument: Tl3Tag;
     aNewDocument: Tl3Tag);
 protected
 // realized methods
   function WindowRequired: Boolean;
   function WindowCloseable: Boolean;
   function CanCloseWindow: Boolean;
   function IsQueryCard: Boolean;
   function TreatSuccessSearchAsManualOpen: Boolean;
   function AutoActivateWindow: Boolean;
   function DocumentIsValid: Boolean; override;
     {* Есть ли документ, готовый к работе }
   function RedactionCurrentPara: IeeLeafPara; override;
     {* Текущий параграф редакции для синхронизации с окном сравннения редакций }
   procedure GotoPoint(aPointID: Cardinal;
    aPointType: TDocumentPositionType = dptSub); override;
     {* Переход на точку в документе }
   function HyperlinkDocument: IDocument; override;
     {* Документ ИЗ которого ведёт ссылка }
   function pm_GetHyperlinkText: TevCustomEditorWindow; override;
   function CanBeChanged: Boolean; override;
     {* Может ли документ быть изменён }
   function IsFloating: Boolean; override;
     {* Форма плавающая }
   function pm_GetTextWithComments: TevCustomEditorWindow; override;
   procedure FillList(const aList: InscStatusBarItemDefsList); override;
     {* Заполняет список операций. Для перекрытия в потомках }
   function Get_ContainerForBaseSearch: TnsContainerForBaseSearchInfo;
   function Get_ContextSearcher: InsContextSearcher;
   function DocumentForExport: IDocument; override;
   function pm_GetHasDoc: Boolean; override;
   function IsDrug: Boolean; override;
   function Document_SetPosition_Execute(aPointID: Cardinal;
    aPointType: TDocumentPositionType = dptSub;
    aUserType: Integer = 0): Boolean;
   procedure Document_SetPosition(const aParams: IvcmExecuteParams);
   procedure Edition_ReturnToDocument_Test(const aParams: IvcmTestParamsPrim);
     {* Вернуться в текст документа }
   procedure Edition_ReturnToDocument_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Вернуться в текст документа }
   function DocumentForSearch: IDocument; override;
   procedure Document_GetParaForPositionning_Test(const aParams: IvcmTestParamsPrim);
   function Document_GetParaForPositionning_Execute: IeeLeafPara;
   procedure Document_GetParaForPositionning(const aParams: IvcmExecuteParams);
   function Get_NeedSaveActiveClassBeforeSearch: Boolean;
   procedure OpenRedactionGlobalLink(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour); override;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   function ContinueSearchInWholeBase: Boolean; override;
   function GetRedactionOnLeftEdition: Integer; override;
 protected
 // protected methods
   function Document: IDocument;
 end;//TPrimChangesBetweenEditonsForm

 TvcmEntityFormRef = TPrimChangesBetweenEditonsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If defined(Nemesis)}
  ,
  nscStatusBarOperationDef
  {$IfEnd} //Nemesis
  ,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  UnderControlUnit
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  DataAdapter,
  DocumentRes,
  vtUtils,
  evdStyles,
  k2Tags,
  BitmapPara_Const,
  nsConst,
  afwFacade,
  SysUtils
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  nsHyperLinkProcessor,
  deDocInfo,
  nsOpenUtils,
  nsTabbedContainerUtils
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  nsHyperlinkProcessorTypes
  {$If defined(Nemesis)}
  ,
  nscStatusBarOperationDefsList
  {$IfEnd} //Nemesis
  ,
  l3Base,
  l3InterfacesMisc,
  nsBaseSearchService,
  evdBlockNameAdder,
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
  evTypes,
  nsQuestions,
  nsExternalObjectModelPart,
  eeInterfacesEx
  {$If defined(Nemesis)}
  ,
  eePara
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  eeParaTools
  {$IfEnd} //Nemesis
  ,
  bsDocumentContextSearcher,
  nsSearchInDocumentEvent,
  BaseTypesUnit,
  nsSearchInDocumentDoneEvent,
  nsSearchInDocumentNextEvent,
  nsSearchInDocumentPrevEvent,
  nsSearchWindowManager
  {$If defined(Nemesis)}
  ,
  f1TextStyle_Const
  {$IfEnd} //Nemesis
  ,
  TextSegment_Const,
  StyledLeafPara_Const
  {$If defined(k2ForEditor)}
  ,
  evSegLst
  {$IfEnd} //k2ForEditor
  ,
  evCustomEditor,
  evEditorWithOperations
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TPrimChangesBetweenEditonsForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\WorkWithRedactions.imp.pas}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentPresentation.imp.pas}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\TextWithComments.imp.pas}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\HyperlinkProcessorWithOwnLocalLink.imp.pas}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentation.imp.pas}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseTextOperations.imp.pas}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentBaseSearcher.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\HyperlinkProcessorForDocumentCompare.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\EditionsListCaller.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\HyperlinkOperations.imp.pas}

var
   { Локализуемые строки DocumentChangesLocalConstants }
  str_DocumentChangesCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentChangesCaption'; rValue : 'Изменения в документе');
   { Заголовок пользовательского типа "Изменения в документе" }

var
   { Локализуемые строки Local }
  str_CompareRedactionOperationCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CompareRedactionOperationCaption'; rValue : 'Сравнить полные тексты редакций');
   { 'Сравнить полные тексты редакций' }
  str_ReturnToDocumentOperationCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ReturnToDocumentOperationCaption'; rValue : 'Вернуться в текст документа');
   { 'Вернуться в текст документа' }

// start class TPrimChangesBetweenEditonsForm

procedure TPrimChangesBetweenEditonsForm.MakeDocumentContainer(aSender: TObject;
  var aMade: InevDocumentContainer);
//#UC START# *4DDD07AA02FD_4DDCD636016C_var*
//#UC END# *4DDD07AA02FD_4DDCD636016C_var*
begin
//#UC START# *4DDD07AA02FD_4DDCD636016C_impl*
 aMade := ViewArea.DocumentContainer;
//#UC END# *4DDD07AA02FD_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.MakeDocumentContainer

procedure TPrimChangesBetweenEditonsForm.TextSourceDocumentChanged(aSender: TObject;
  anOldDocument: Tl3Tag;
  aNewDocument: Tl3Tag);
//#UC START# *5228246A01D9_4DDCD636016C_var*
//#UC END# *5228246A01D9_4DDCD636016C_var*
begin
//#UC START# *5228246A01D9_4DDCD636016C_impl*
 TdmStdRes.CheckBaseSearchDataReady(NativeMainForm);
//#UC END# *5228246A01D9_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.TextSourceDocumentChanged

function TPrimChangesBetweenEditonsForm.Document: IDocument;
//#UC START# *4E8B2F9B02AF_4DDCD636016C_var*
//#UC END# *4E8B2F9B02AF_4DDCD636016C_var*
begin
//#UC START# *4E8B2F9B02AF_4DDCD636016C_impl*
 Result := ViewArea.RightEdition;
//#UC END# *4E8B2F9B02AF_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.Document

function TPrimChangesBetweenEditonsForm.WindowRequired: Boolean;
//#UC START# *496B4C41023E_4DDCD636016C_var*
//#UC END# *496B4C41023E_4DDCD636016C_var*
begin
//#UC START# *496B4C41023E_4DDCD636016C_impl*
 Result := False;
//#UC END# *496B4C41023E_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.WindowRequired

function TPrimChangesBetweenEditonsForm.WindowCloseable: Boolean;
//#UC START# *496B4C500246_4DDCD636016C_var*
//#UC END# *496B4C500246_4DDCD636016C_var*
begin
//#UC START# *496B4C500246_4DDCD636016C_impl*
 Result := True;
//#UC END# *496B4C500246_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.WindowCloseable

function TPrimChangesBetweenEditonsForm.CanCloseWindow: Boolean;
//#UC START# *496B4CA000B6_4DDCD636016C_var*
//#UC END# *496B4CA000B6_4DDCD636016C_var*
begin
//#UC START# *496B4CA000B6_4DDCD636016C_impl*
 Result := True;
//#UC END# *496B4CA000B6_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.CanCloseWindow

function TPrimChangesBetweenEditonsForm.IsQueryCard: Boolean;
//#UC START# *496B4CD9005F_4DDCD636016C_var*
//#UC END# *496B4CD9005F_4DDCD636016C_var*
begin
//#UC START# *496B4CD9005F_4DDCD636016C_impl*
 Result := False;
//#UC END# *496B4CD9005F_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.IsQueryCard

function TPrimChangesBetweenEditonsForm.TreatSuccessSearchAsManualOpen: Boolean;
//#UC START# *496B4CE30132_4DDCD636016C_var*
//#UC END# *496B4CE30132_4DDCD636016C_var*
begin
//#UC START# *496B4CE30132_4DDCD636016C_impl*
 Result := False;
//#UC END# *496B4CE30132_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.TreatSuccessSearchAsManualOpen

function TPrimChangesBetweenEditonsForm.AutoActivateWindow: Boolean;
//#UC START# *496B4CED0306_4DDCD636016C_var*
//#UC END# *496B4CED0306_4DDCD636016C_var*
begin
//#UC START# *496B4CED0306_4DDCD636016C_impl*
 Result := False;
//#UC END# *496B4CED0306_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.AutoActivateWindow

function TPrimChangesBetweenEditonsForm.DocumentIsValid: Boolean;
//#UC START# *4A7C0E1A005C_4DDCD636016C_var*
//#UC END# *4A7C0E1A005C_4DDCD636016C_var*
begin
//#UC START# *4A7C0E1A005C_4DDCD636016C_impl*
 Result := TextSource.HasDocument;
//#UC END# *4A7C0E1A005C_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.DocumentIsValid

function TPrimChangesBetweenEditonsForm.RedactionCurrentPara: IeeLeafPara;
//#UC START# *4A7FCEA9025D_4DDCD636016C_var*
//#UC END# *4A7FCEA9025D_4DDCD636016C_var*
begin
//#UC START# *4A7FCEA9025D_4DDCD636016C_impl*
 Result := GetParaForPositionning;
//#UC END# *4A7FCEA9025D_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.RedactionCurrentPara

procedure TPrimChangesBetweenEditonsForm.GotoPoint(aPointID: Cardinal;
  aPointType: TDocumentPositionType = dptSub);
//#UC START# *4A8164E801AE_4DDCD636016C_var*
var
 l_Sub : IevSub;
//#UC END# *4A8164E801AE_4DDCD636016C_var*
begin
//#UC START# *4A8164E801AE_4DDCD636016C_impl*
 Case aPointType of
  dptSub :
  begin
   l_Sub := TextSource.DocumentContainer.SubList.Sub[aPointID];
   if (l_Sub <> nil) and
      l_Sub.Exists then
    l_Sub.Select(Text.Selection);
  end;//dptSub
  else
   Assert(false);
 end;//Case aPointType
//#UC END# *4A8164E801AE_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.GotoPoint

function TPrimChangesBetweenEditonsForm.HyperlinkDocument: IDocument;
//#UC START# *4A8168BB0217_4DDCD636016C_var*
//#UC END# *4A8168BB0217_4DDCD636016C_var*
begin
//#UC START# *4A8168BB0217_4DDCD636016C_impl*
 Result := ViewArea.RightEdition;
//#UC END# *4A8168BB0217_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.HyperlinkDocument

function TPrimChangesBetweenEditonsForm.pm_GetHyperlinkText: TevCustomEditorWindow;
//#UC START# *4A82BC390036_4DDCD636016Cget_var*
//#UC END# *4A82BC390036_4DDCD636016Cget_var*
begin
//#UC START# *4A82BC390036_4DDCD636016Cget_impl*
 Result := Text;
//#UC END# *4A82BC390036_4DDCD636016Cget_impl*
end;//TPrimChangesBetweenEditonsForm.pm_GetHyperlinkText

function TPrimChangesBetweenEditonsForm.CanBeChanged: Boolean;
//#UC START# *4A8931130363_4DDCD636016C_var*
//#UC END# *4A8931130363_4DDCD636016C_var*
begin
//#UC START# *4A8931130363_4DDCD636016C_impl*
 Result := false;
//#UC END# *4A8931130363_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.CanBeChanged

function TPrimChangesBetweenEditonsForm.IsFloating: Boolean;
//#UC START# *4A8A9DB0001A_4DDCD636016C_var*
//#UC END# *4A8A9DB0001A_4DDCD636016C_var*
begin
//#UC START# *4A8A9DB0001A_4DDCD636016C_impl*
 Result := false;
//#UC END# *4A8A9DB0001A_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.IsFloating

function TPrimChangesBetweenEditonsForm.pm_GetTextWithComments: TevCustomEditorWindow;
//#UC START# *4A8AAD450084_4DDCD636016Cget_var*
//#UC END# *4A8AAD450084_4DDCD636016Cget_var*
begin
//#UC START# *4A8AAD450084_4DDCD636016Cget_impl*
 Result := Text;
//#UC END# *4A8AAD450084_4DDCD636016Cget_impl*
end;//TPrimChangesBetweenEditonsForm.pm_GetTextWithComments

procedure TPrimChangesBetweenEditonsForm.FillList(const aList: InscStatusBarItemDefsList);
//#UC START# *4A8E5E4702C6_4DDCD636016C_var*
//#UC END# *4A8E5E4702C6_4DDCD636016C_var*
begin
//#UC START# *4A8E5E4702C6_4DDCD636016C_impl*
 with aList do
 begin
  Add(TnscStatusBarOperationDef.MakeS(TdmStdRes.opcode_Document_CompareEditions, True, str_CompareRedactionOperationCaption, true, false, 2000, nsc_ttkNone));
  Add(TnscStatusBarOperationDef.MakeSDefaultCaption(TdmStdRes.opcode_Redactions_OpenRedactionListFrmAct, true, false, 2000, nsc_ttkNone));
  Add(TnscStatusBarOperationDef.MakeS(TdmStdRes.opcode_Edition_ReturnToDocument, True, str_ReturnToDocumentOperationCaption, true, false, 2000, nsc_ttkNone));
 end;//with aList
//#UC END# *4A8E5E4702C6_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.FillList

function TPrimChangesBetweenEditonsForm.Get_ContainerForBaseSearch: TnsContainerForBaseSearchInfo;
//#UC START# *4ACA195801CB_4DDCD636016Cget_var*
//#UC END# *4ACA195801CB_4DDCD636016Cget_var*
begin
//#UC START# *4ACA195801CB_4DDCD636016Cget_impl*
 Result.rContainer := nil;
 Result.rZone := vcm_ztAny;
//#UC END# *4ACA195801CB_4DDCD636016Cget_impl*
end;//TPrimChangesBetweenEditonsForm.Get_ContainerForBaseSearch

function TPrimChangesBetweenEditonsForm.Get_ContextSearcher: InsContextSearcher;
//#UC START# *4AD6EAA3034A_4DDCD636016Cget_var*
//#UC END# *4AD6EAA3034A_4DDCD636016Cget_var*
begin
//#UC START# *4AD6EAA3034A_4DDCD636016Cget_impl*
 Result := Self;
//#UC END# *4AD6EAA3034A_4DDCD636016Cget_impl*
end;//TPrimChangesBetweenEditonsForm.Get_ContextSearcher

function TPrimChangesBetweenEditonsForm.DocumentForExport: IDocument;
//#UC START# *4AE1B48A0120_4DDCD636016C_var*
//#UC END# *4AE1B48A0120_4DDCD636016C_var*
begin
//#UC START# *4AE1B48A0120_4DDCD636016C_impl*
 Result := ViewArea.RightEdition;
//#UC END# *4AE1B48A0120_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.DocumentForExport

function TPrimChangesBetweenEditonsForm.pm_GetHasDoc: Boolean;
//#UC START# *4AE1C7A8016C_4DDCD636016Cget_var*
//#UC END# *4AE1C7A8016C_4DDCD636016Cget_var*
begin
//#UC START# *4AE1C7A8016C_4DDCD636016Cget_impl*
 Result := TextSource.HasDocument;
//#UC END# *4AE1C7A8016C_4DDCD636016Cget_impl*
end;//TPrimChangesBetweenEditonsForm.pm_GetHasDoc

function TPrimChangesBetweenEditonsForm.IsDrug: Boolean;
//#UC START# *4AE1C9890311_4DDCD636016C_var*
//#UC END# *4AE1C9890311_4DDCD636016C_var*
begin
//#UC START# *4AE1C9890311_4DDCD636016C_impl*
 Result := false;
//#UC END# *4AE1C9890311_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.IsDrug

function TPrimChangesBetweenEditonsForm.Document_SetPosition_Execute(aPointID: Cardinal;
  aPointType: TDocumentPositionType = dptSub;
  aUserType: Integer = 0): Boolean;
//#UC START# *4AE9D38A02DA_4DDCD636016Cexec_var*
//#UC END# *4AE9D38A02DA_4DDCD636016Cexec_var*
begin
//#UC START# *4AE9D38A02DA_4DDCD636016Cexec_impl*
 GotoPoint(aPointID, aPointType);
 Result := true;
//#UC END# *4AE9D38A02DA_4DDCD636016Cexec_impl*
end;//TPrimChangesBetweenEditonsForm.Document_SetPosition_Execute

procedure TPrimChangesBetweenEditonsForm.Document_SetPosition(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IDocument_SetPosition_Params) do
  ResultValue := Document_SetPosition_Execute(PointID, PointType, UserType);
end;

procedure TPrimChangesBetweenEditonsForm.Edition_ReturnToDocument_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4B1E37CE00C1_4DDCD636016Ctest_var*
//#UC END# *4B1E37CE00C1_4DDCD636016Ctest_var*
begin
//#UC START# *4B1E37CE00C1_4DDCD636016Ctest_impl*
 // - ничего не делаем
//#UC END# *4B1E37CE00C1_4DDCD636016Ctest_impl*
end;//TPrimChangesBetweenEditonsForm.Edition_ReturnToDocument_Test

procedure TPrimChangesBetweenEditonsForm.Edition_ReturnToDocument_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4B1E37CE00C1_4DDCD636016Cexec_var*
//#UC END# *4B1E37CE00C1_4DDCD636016Cexec_var*
begin
//#UC START# *4B1E37CE00C1_4DDCD636016Cexec_impl*
 TdmStdRes.OpenDocument(TdeDocInfo.Make(Document,
                                        TbsDocPos_P(GetParaForPositionning)),
                        nil);
//#UC END# *4B1E37CE00C1_4DDCD636016Cexec_impl*
end;//TPrimChangesBetweenEditonsForm.Edition_ReturnToDocument_Execute

function TPrimChangesBetweenEditonsForm.DocumentForSearch: IDocument;
//#UC START# *4B4EF0A200BD_4DDCD636016C_var*
//#UC END# *4B4EF0A200BD_4DDCD636016C_var*
begin
//#UC START# *4B4EF0A200BD_4DDCD636016C_impl*
 Result := ViewArea.RightEdition;
//#UC END# *4B4EF0A200BD_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.DocumentForSearch

procedure TPrimChangesBetweenEditonsForm.Document_GetParaForPositionning_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4B506F4D0196_4DDCD636016Ctest_var*
//#UC END# *4B506F4D0196_4DDCD636016Ctest_var*
begin
//#UC START# *4B506F4D0196_4DDCD636016Ctest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := true;
//#UC END# *4B506F4D0196_4DDCD636016Ctest_impl*
end;//TPrimChangesBetweenEditonsForm.Document_GetParaForPositionning_Test

function TPrimChangesBetweenEditonsForm.Document_GetParaForPositionning_Execute: IeeLeafPara;
//#UC START# *4B506F4D0196_4DDCD636016Cexec_var*
//#UC END# *4B506F4D0196_4DDCD636016Cexec_var*
begin
//#UC START# *4B506F4D0196_4DDCD636016Cexec_impl*
 Result := GetParaForPositionning;
//#UC END# *4B506F4D0196_4DDCD636016Cexec_impl*
end;//TPrimChangesBetweenEditonsForm.Document_GetParaForPositionning_Execute

procedure TPrimChangesBetweenEditonsForm.Document_GetParaForPositionning(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IDocument_GetParaForPositionning_Params) do
  ResultValue := Document_GetParaForPositionning_Execute;
end;

function TPrimChangesBetweenEditonsForm.Get_NeedSaveActiveClassBeforeSearch: Boolean;
//#UC START# *4F1D607E0027_4DDCD636016Cget_var*
//#UC END# *4F1D607E0027_4DDCD636016Cget_var*
begin
//#UC START# *4F1D607E0027_4DDCD636016Cget_impl*
 Result := false;
 // - тут вообще говоря зависит от того - локальный поиск или глобальный
//#UC END# *4F1D607E0027_4DDCD636016Cget_impl*
end;//TPrimChangesBetweenEditonsForm.Get_NeedSaveActiveClassBeforeSearch

procedure TPrimChangesBetweenEditonsForm.OpenRedactionGlobalLink(const aDocument: IDocument;
  aSub: Cardinal;
  aBehaviour: TbsProcessHyperLinkBehaviour);
//#UC START# *53A303BE03A8_4DDCD636016C_var*
//#UC END# *53A303BE03A8_4DDCD636016C_var*
begin
//#UC START# *53A303BE03A8_4DDCD636016C_impl*
 Assert(False, '513615258');
//#UC END# *53A303BE03A8_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.OpenRedactionGlobalLink

{$If not defined(NoVCM)}
procedure TPrimChangesBetweenEditonsForm.InitControls;
//#UC START# *4A8E8F2E0195_4DDCD636016C_var*
//#UC END# *4A8E8F2E0195_4DDCD636016C_var*
begin
//#UC START# *4A8E8F2E0195_4DDCD636016C_impl*
 inherited;
 with TextSource do
 begin
  OnMakeDocumentContainer := Self.MakeDocumentContainer;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=460265789
  OnDocumentChanged := TextSourceDocumentChanged;
  //OnDocumentChanged := Self.DocumentTextChanged;
 end;
 with Text do
 begin
  //ProvideOperationTypes := ProvideOperationTypes - [potPrint];
  Align := alClient;
  ShowComments := true;
  ShowVersionComments := true;
//  ShowComments := false;
//  ShowVersionComments := false;
  ShowUserComments := false;
  ShowTechComments := false;
  //OnVScroll := Self.VScroll;
  //OnParaChange := Self.ParaChange;
  {$IfOpt D+}
  ShowDocumentParts := true;
  {$EndIf}
  AllowRubberTables := nev_rtmFitToWindow;
  IsStaticText := true;
 end;//with Text
//#UC END# *4A8E8F2E0195_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.InitControls
{$IfEnd} //not NoVCM

function TPrimChangesBetweenEditonsForm.ContinueSearchInWholeBase: Boolean;
//#UC START# *4B4EF0D2016A_4DDCD636016C_var*
//#UC END# *4B4EF0D2016A_4DDCD636016C_var*
begin
//#UC START# *4B4EF0D2016A_4DDCD636016C_impl*
 Result := False;
//#UC END# *4B4EF0D2016A_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.ContinueSearchInWholeBase

function TPrimChangesBetweenEditonsForm.GetRedactionOnLeftEdition: Integer;
//#UC START# *4F2BEF740060_4DDCD636016C_var*
var
 l_LeftState : IDocumentState;
 l_LeftEdition : IDocument;
//#UC END# *4F2BEF740060_4DDCD636016C_var*
begin
//#UC START# *4F2BEF740060_4DDCD636016C_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=333548940
 Result := -1;
 l_LeftEdition := ViewArea.LeftEdition;
 Assert(l_LeftEdition <> nil);
 if (l_LeftEdition <> nil) then
 begin
  l_LeftEdition.GetCurrentState(l_LeftState);
  Result := l_LeftState.Redaction;
 end;//l_LeftEdition <> nil
//#UC END# *4F2BEF740060_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.GetRedactionOnLeftEdition

procedure TPrimChangesBetweenEditonsForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  ViewArea := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IdsChangesBetweenEditions, ViewArea);
 end;//aDsNew = nil
end;

procedure TPrimChangesBetweenEditonsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Document, nil);
  PublishFormEntity(en_Edition, nil);
  ContextMenuWeight(en_HyperLink, -5);
  PublishOpWithResult(en_Document, op_SetPosition, Document_SetPosition, nil, nil);
  PublishOp(en_Edition, op_ReturnToDocument, Edition_ReturnToDocument_Execute, Edition_ReturnToDocument_Test, nil);
  PublishOpWithResult(en_Document, op_GetParaForPositionning, Document_GetParaForPositionning, Document_GetParaForPositionning_Test, nil);{$If not defined(NoVCM)}
  
  ShowInContextMenu(en_File, op_Print, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  
  ShowInContextMenu(en_File, op_PrintDialog, true);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

procedure TPrimChangesBetweenEditonsForm.MakeControls;
begin
 inherited;
 with AddUsertype(DocumentChangesName,
  str_DocumentChangesCaption,
  str_DocumentChangesCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(DocumentChangesName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_DocumentChangesCaption
 str_DocumentChangesCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_CompareRedactionOperationCaption
 str_CompareRedactionOperationCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_ReturnToDocumentOperationCaption
 str_ReturnToDocumentOperationCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimChangesBetweenEditons
 TtfwClassRef.Register(TPrimChangesBetweenEditonsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.