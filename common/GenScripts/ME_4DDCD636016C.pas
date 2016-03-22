unit PrimChangesBetweenEditons_Form;
 {* Изменения в документе }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\Forms\PrimChangesBetweenEditons_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimChangesBetweenEditons" MUID: (4DDCD636016C)
// Имя типа: "TPrimChangesBetweenEditonsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseSearchInterfaces
 , Base_Operations_Editions_Controls
 , ChangesBetweenEditionsInterfaces
 , nevTools
 , DocumentUnit
 , l3Variant
 , eeInterfaces
 , evCustomEditorWindow
 , bsTypesNew
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , NavigationInterfaces
 , Base_Operations_View_Controls
 , Search_Strange_Controls
 , nevBase
 , ExternalOperationUnit
 , DocumentInterfaces
 , nevGUIInterfaces
 , afwInterfaces
 , nevNavigation
 , afwNavigation
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Specific_Controls
 , DocumentAndListInterfaces
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3BaseStream
 , nsTypes
 , k2CustomFileGenerator
 , k2TagGen
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimBaseSearchInterfaces
 , Common_Strange_Controls
 , Base_Operations_Strange_Controls
 , evdTypes
;

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
 TPrimChangesBetweenEditonsForm = class(_HyperlinkOperations_, InsBaseSearchPresentation)
  {* Изменения в документе }
  private
   ViewArea: IdsChangesBetweenEditions;
  private
   procedure MakeDocumentContainer(aSender: TObject;
    var aMade: InevDocumentContainer);
   procedure TextSourceDocumentChanged(aSender: TObject;
    anOldDocument: Tl3Tag;
    aNewDocument: Tl3Tag);
  protected
   function Document: IDocument;
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
    aPointType: TDocumentPositionType = bsTypesNew.dptSub); override;
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
   function DocumentForSearch: IDocument; override;
   function Get_NeedSaveActiveClassBeforeSearch: Boolean;
   procedure OpenRedactionGlobalLink(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour); override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   function ContinueSearchInWholeBase: Boolean; override;
   function GetRedactionOnLeftEdition: Integer; override;
  public
   function Document_SetPosition_Execute(aPointID: Cardinal;
    aPointType: TDocumentPositionType = bsTypesNew.dptSub;
    aUserType: Integer = 0): Boolean;
   procedure Document_SetPosition(const aParams: IvcmExecuteParamsPrim);
   procedure Edition_ReturnToDocument_Test(const aParams: IvcmTestParamsPrim);
    {* Вернуться в текст документа }
   procedure Edition_ReturnToDocument_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Вернуться в текст документа }
   procedure Document_GetParaForPositionning_Test(const aParams: IvcmTestParamsPrim);
   function Document_GetParaForPositionning_Execute: IeeLeafPara;
   procedure Document_GetParaForPositionning(const aParams: IvcmExecuteParamsPrim);
 end;//TPrimChangesBetweenEditonsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If Defined(Nemesis)}
 , nscStatusBarOperationDef
 {$IfEnd} // Defined(Nemesis)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , UnderControlUnit
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , DataAdapter
 , DocumentRes
 , vtUtils
 , evdStyles
 , k2Tags
 , BitmapPara_Const
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsHyperLinkProcessor
 , deDocInfo
 , nsOpenUtils
 , nsConst
 , afwFacade
 , nsTabbedContainerUtils
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , nsHyperlinkProcessorTypes
 , SysUtils
 {$If Defined(Nemesis)}
 , nscStatusBarOperationDefsList
 {$IfEnd} // Defined(Nemesis)
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
 , evTypes
 , Classes
 , nsQuestions
 , nsExternalObjectModelPart
 , eeInterfacesEx
 {$If Defined(Nemesis)}
 , eePara
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , eeParaTools
 {$IfEnd} // Defined(Nemesis)
 , evdBlockNameAdder
 , nsDocumentTools
 , PresentationInterfaces
 , nsExternalObjectPrim
 , bsUtils
 , l3Stream
 , l3Types
 , nsToMSWordOp
 , l3String
 , bsDocumentContextSearcher
 , nsSearchInDocumentEvent
 , BaseTypesUnit
 , nsSearchInDocumentDoneEvent
 , nsSearchInDocumentNextEvent
 , nsSearchInDocumentPrevEvent
 , nsSearchWindowManager
 {$If Defined(Nemesis)}
 , f1TextStyle_Const
 {$IfEnd} // Defined(Nemesis)
 , TextSegment_Const
 , StyledLeafPara_Const
 {$If Defined(k2ForEditor)}
 , evSegLst
 {$IfEnd} // Defined(k2ForEditor)
 , evCustomEditor
 , evEditorWithOperations
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки DocumentChangesLocalConstants }
 str_DocumentChangesCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentChangesCaption'; rValue : 'Изменения в документе');
  {* Заголовок пользовательского типа "Изменения в документе" }
 {* Локализуемые строки Local }
 str_CompareRedactionOperationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CompareRedactionOperationCaption'; rValue : 'Сравнить полные тексты редакций');
  {* 'Сравнить полные тексты редакций' }
 str_ReturnToDocumentOperationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ReturnToDocumentOperationCaption'; rValue : 'Вернуться в текст документа');
  {* 'Вернуться в текст документа' }

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

procedure TPrimChangesBetweenEditonsForm.MakeDocumentContainer(aSender: TObject;
 var aMade: InevDocumentContainer);
//#UC START# *4DDD07AA02FD_4DDCD636016C_var*
//#UC END# *4DDD07AA02FD_4DDCD636016C_var*
begin
//#UC START# *4DDD07AA02FD_4DDCD636016C_impl*
 aMade := ViewArea.DocumentContainer;
//#UC END# *4DDD07AA02FD_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.MakeDocumentContainer

function TPrimChangesBetweenEditonsForm.Document: IDocument;
//#UC START# *4E8B2F9B02AF_4DDCD636016C_var*
//#UC END# *4E8B2F9B02AF_4DDCD636016C_var*
begin
//#UC START# *4E8B2F9B02AF_4DDCD636016C_impl*
 Result := ViewArea.RightEdition;
//#UC END# *4E8B2F9B02AF_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.Document

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
 {* Есть ли документ, готовый к работе }
//#UC START# *4A7C0E1A005C_4DDCD636016C_var*
//#UC END# *4A7C0E1A005C_4DDCD636016C_var*
begin
//#UC START# *4A7C0E1A005C_4DDCD636016C_impl*
 Result := TextSource.HasDocument;
//#UC END# *4A7C0E1A005C_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.DocumentIsValid

function TPrimChangesBetweenEditonsForm.RedactionCurrentPara: IeeLeafPara;
 {* Текущий параграф редакции для синхронизации с окном сравннения редакций }
//#UC START# *4A7FCEA9025D_4DDCD636016C_var*
//#UC END# *4A7FCEA9025D_4DDCD636016C_var*
begin
//#UC START# *4A7FCEA9025D_4DDCD636016C_impl*
 Result := GetParaForPositionning;
//#UC END# *4A7FCEA9025D_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.RedactionCurrentPara

procedure TPrimChangesBetweenEditonsForm.GotoPoint(aPointID: Cardinal;
 aPointType: TDocumentPositionType = bsTypesNew.dptSub);
 {* Переход на точку в документе }
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
 {* Документ ИЗ которого ведёт ссылка }
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
 {* Может ли документ быть изменён }
//#UC START# *4A8931130363_4DDCD636016C_var*
//#UC END# *4A8931130363_4DDCD636016C_var*
begin
//#UC START# *4A8931130363_4DDCD636016C_impl*
 Result := false;
//#UC END# *4A8931130363_4DDCD636016C_impl*
end;//TPrimChangesBetweenEditonsForm.CanBeChanged

function TPrimChangesBetweenEditonsForm.IsFloating: Boolean;
 {* Форма плавающая }
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
 {* Заполняет список операций. Для перекрытия в потомках }
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
 aPointType: TDocumentPositionType = bsTypesNew.dptSub;
 aUserType: Integer = 0): Boolean;
//#UC START# *4AE9D38A02DA_4DDCD636016Cexec_var*
//#UC END# *4AE9D38A02DA_4DDCD636016Cexec_var*
begin
//#UC START# *4AE9D38A02DA_4DDCD636016Cexec_impl*
 GotoPoint(aPointID, aPointType);
 Result := true;
//#UC END# *4AE9D38A02DA_4DDCD636016Cexec_impl*
end;//TPrimChangesBetweenEditonsForm.Document_SetPosition_Execute

procedure TPrimChangesBetweenEditonsForm.Document_SetPosition(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IDocument_SetPosition_Params) do
  ResultValue := Self.Document_SetPosition_Execute(PointID, PointType, UserType);
end;//TPrimChangesBetweenEditonsForm.Document_SetPosition

procedure TPrimChangesBetweenEditonsForm.Edition_ReturnToDocument_Test(const aParams: IvcmTestParamsPrim);
 {* Вернуться в текст документа }
//#UC START# *4B1E37CE00C1_4DDCD636016Ctest_var*
//#UC END# *4B1E37CE00C1_4DDCD636016Ctest_var*
begin
//#UC START# *4B1E37CE00C1_4DDCD636016Ctest_impl*
 // - ничего не делаем
//#UC END# *4B1E37CE00C1_4DDCD636016Ctest_impl*
end;//TPrimChangesBetweenEditonsForm.Edition_ReturnToDocument_Test

procedure TPrimChangesBetweenEditonsForm.Edition_ReturnToDocument_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Вернуться в текст документа }
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

procedure TPrimChangesBetweenEditonsForm.Document_GetParaForPositionning(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IDocument_GetParaForPositionning_Params) do
  ResultValue := Self.Document_GetParaForPositionning_Execute;
end;//TPrimChangesBetweenEditonsForm.Document_GetParaForPositionning

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

procedure TPrimChangesBetweenEditonsForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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

initialization
 str_DocumentChangesCaption.Init;
 {* Инициализация str_DocumentChangesCaption }
 str_CompareRedactionOperationCaption.Init;
 {* Инициализация str_CompareRedactionOperationCaption }
 str_ReturnToDocumentOperationCaption.Init;
 {* Инициализация str_ReturnToDocumentOperationCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimChangesBetweenEditonsForm);
 {* Регистрация PrimChangesBetweenEditons }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
