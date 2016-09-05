unit PrimList_Form;
 {* Список документов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\PrimList_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimList" MUID: (497DDB2B001B)
// Имя типа: "TPrimListForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseSearchInterfaces
 , PresentationInterfaces
 , Search_Strange_Controls
 , Base_Operations_Strange_Controls
 , Common_Strange_Controls
 , WorkWithList_StatusBar_Controls
 , WorkWithList_ListOperations_Controls
 , TreeInterfaces
 , DocumentAndListInterfaces
 , WorkWithListInterfaces
 , SimpleListInterfaces
 , L10nInterfaces
 , l3Interfaces
 , FoldersDomainInterfaces
 , vtPanel
 , DocumentUnit
 , afwInterfaces
 , bsTypes
 , nscDocumentListTreeView
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , vtStyledFocusLabel
 , l3TreeInterfaces
 , FiltersUnit
 , DocumentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DynamicTreeUnit
 , PreviewInterfaces
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , eeInterfaces
 , PrimPrimListInterfaces
 , PrimBaseSearchInterfaces
 , l3Core
 , nsTypes
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , Hypertext_Controls_Controls
 , nsLogEvent
 , DynamicDocListUnit
 , bsInterfaces
 , l3ProtoObject
 , l3StringIDEx
;

const
 {* Локализуемые строки DocumentListHintConst }
 str_lntAAC: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntAAC'; rValue : 'Энциклопедия решений');
  {* 'Энциклопедия решений' }
 str_lntBlock: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntBlock'; rValue : 'Вхождение в документе');
  {* 'Вхождение в документе' }
 str_lntDocActive: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntDocActive'; rValue : 'Действующий документ');
  {* 'Действующий документ' }
 str_lntDocPreActive: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntDocPreActive'; rValue : 'Не вступивший в силу документ');
  {* 'Не вступивший в силу документ' }
 str_lntDocAbolished: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntDocAbolished'; rValue : 'Утративший силу документ');
  {* 'Утративший силу документ' }
 str_lntRedaction: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntRedaction'; rValue : 'Редакция документа');
  {* 'Редакция документа' }
 str_lntRedactions: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntRedactions'; rValue : 'Редакции документа');
  {* 'Редакции документа' }
 str_lntDrugAnnuled: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntDrugAnnuled'; rValue : 'Аннулированный препарат');
  {* 'Аннулированный препарат' }
 str_lntDrugNarcotic: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntDrugNarcotic'; rValue : 'Особый контроль');
  {* 'Особый контроль' }
 str_lntDrugNoAnnuledNoNarcoric: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntDrugNoAnnuledNoNarcoric'; rValue : 'Действующий препарат');
  {* 'Действующий препарат' }
 str_lntFormAnnuled: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntFormAnnuled'; rValue : 'Аннулированная форма препарата');
  {* 'Аннулированная форма препарата' }
 str_lntFormRussianImportant: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntFormRussianImportant'; rValue : 'Жизненноважная форма препарата российского производства');
  {* 'Жизненноважная форма препарата российского производства' }
 str_lntFormNoRussianImportant: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntFormNoRussianImportant'; rValue : 'Жизненноважная форма препарата импортного производства');
  {* 'Жизненноважная форма препарата импортного производства' }
 str_lntFormRussianNoImportant: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntFormRussianNoImportant'; rValue : 'Форма препарата российского производства');
  {* 'Форма препарата российского производства' }
 str_lntFormNoRussianNoImportant: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntFormNoRussianNoImportant'; rValue : 'Действующая форма препарата');
  {* 'Действующая форма препарата' }
 c_SelectionMap: array [Boolean] of Integer = (0, 1);

type
 TnsDeleteFromListEvent = class(TnsLogEvent)
  public
   class procedure Log(const aList: IDynList);
 end;//TnsDeleteFromListEvent

 TnsListExportToFileEvent = class(TnsLogEvent)
  public
   class procedure Log(const aList: IDynList;
    aCount: Cardinal;
    aSelection: Boolean;
    aTarget: TnsSaveDialogListTarget);
 end;//TnsListExportToFileEvent

 TnsListPrintPreviewEvent = class(TnsLogEvent)
  public
   class procedure Log(const aList: IDynList;
    aCount: Cardinal;
    aSelection: Boolean);
 end;//TnsListPrintPreviewEvent

 TnsListExportToWordEvent = class(TnsLogEvent)
  public
   class procedure Log(const aList: IDynList;
    aCount: Cardinal;
    aSelection: Boolean);
 end;//TnsListExportToWordEvent

 TnsSendListByEmailEvent = {final} class(TnsLogEvent)
  public
   class procedure Log(const aList: IDynList;
    aCount: Cardinal;
    aSelection: Boolean);
 end;//TnsSendListByEmailEvent

 TnsViewSameDocumentsEvent = class(TnsLogEvent)
  private
   class procedure Log(const aDoc: IDocument;
    aCount: Cardinal); virtual;
 end;//TnsViewSameDocumentsEvent

 TPrimListFormStateOption = (
  lfoContextFilterState
  , lfoTopItemIndex
  , lfoCurrentIndex
  , lfoTreeStructState
  , lfoInner
 );//TPrimListFormStateOption

 TPrimListFormStateOptions = set of TPrimListFormStateOption;

 IPrimListFormState = interface(IvcmBase)
  ['{05608760-BE05-4CBD-B87E-A50CB768DCA8}']
  function pm_GetInnerState: IvcmBase;
  function pm_GetContextFilterState: IUnknown;
  function pm_GetTreeStructState: InsTreeStructState;
  function pm_GetTopItemIndex: Integer;
  function pm_GetCurrentIndex: Integer;
  function pm_GetOptions: TPrimListFormStateOptions;
  function pm_GetWasFiltered: Boolean;
  property InnerState: IvcmBase
   read pm_GetInnerState;
  property ContextFilterState: IUnknown
   read pm_GetContextFilterState;
  property TreeStructState: InsTreeStructState
   read pm_GetTreeStructState;
  property TopItemIndex: Integer
   read pm_GetTopItemIndex;
  property CurrentIndex: Integer
   read pm_GetCurrentIndex;
  property Options: TPrimListFormStateOptions
   read pm_GetOptions;
  property WasFiltered: Boolean
   read pm_GetWasFiltered;
 end;//IPrimListFormState

 _afwApplicationDataUpdate_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 TPrimListFormState = class(_afwApplicationDataUpdate_, IPrimListFormState)
  private
   f_InnerState: IvcmBase;
   f_ContextFilterState: IUnknown;
   f_TreeStructState: InsTreeStructState;
   f_TopItemIndex: Integer;
   f_Options: TPrimListFormStateOptions;
   f_CurrentIndex: Integer;
   f_WasFiltered: Boolean;
  protected
   function pm_GetInnerState: IvcmBase;
   function pm_GetContextFilterState: IUnknown;
   function pm_GetTreeStructState: InsTreeStructState;
   function pm_GetTopItemIndex: Integer;
   function pm_GetOptions: TPrimListFormStateOptions;
   function pm_GetCurrentIndex: Integer;
   function pm_GetWasFiltered: Boolean;
   procedure FinishDataUpdate; override;
  public
   constructor Create(const aInnerState: IvcmBase;
    const aContextFilterState: IUnknown;
    const aTreeStructState: InsTreeStructState;
    aTopItemIndex: Integer;
    aCurrentIndex: Integer;
    aOptions: TPrimListFormStateOptions;
    aWasFiltered: Boolean); reintroduce;
   class function Make(const aInnerState: IvcmBase;
    const aContextFilterState: IUnknown;
    const aTreeStructState: InsTreeStructState;
    aTopItemIndex: Integer;
    aCurrentIndex: Integer;
    aOptions: TPrimListFormStateOptions;
    aWasFiltered: Boolean): IPrimListFormState; reintroduce;
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; override;
    {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
 end;//TPrimListFormState

 _ListUserTypes_Parent_ = TvcmContainerForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes.imp.pas}
 _evStyleTableListener_Parent_ = _ListUserTypes_;
 {$Include w:\common\components\gui\Garant\Everest\evStyleTableListener.imp.pas}
 _PageControlNotification_Parent_ = _evStyleTableListener_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PageControlNotification.imp.pas}
 _BaseDocument_Parent_ = _PageControlNotification_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas}
 _StatusBarItems_Parent_ = _BaseDocument_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}
 _BaseSearchPresentation_Parent_ = _StatusBarItems_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentation.imp.pas}
 _HyperlinkToDocumentProducer_Parent_ = _BaseSearchPresentation_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\LinksToGarant\HyperlinkToDocumentProducer.imp.pas}
 TPrimListForm = {abstract} class(_HyperlinkToDocumentProducer_, InsContextSearcher, InsBaseSearchPresentation, InsBaseSearchVisibleWatcher, InsTurnOffTimeMachine)
  {* Список документов }
  private
   f_AllowCallCurrentChangedOnTest: Boolean;
   f_SearchContext: Il3CString;
   f_WasFiltered: Boolean;
    {* Флаг, что список был отфильтрован. Нужен, чтобы не показывать ссылку "Продолжить поиск..." }
   f_ListPanel: TvtPanel;
   f_CanSwithToFullList: Boolean;
   f_tvList: TnscDocumentListTreeView;
   f_cfList: TnscContextFilter;
   f_ExSearchPanel: TvtPanel;
   f_ExSearchLabel: TvtStyledFocusLabel;
    {* Продолжить поиск в онлайн-архивах ГАРАНТа }
  protected
   dsSimpleTree: IdsSimpleTree;
   dsList: IdsList;
   dsDocumentList: IdsDocumentList;
   sdsList: IsdsList;
    {* Список }
   BaseSearchSupportQuery: IucbBaseSearchSupportQuery;
   WarningLocker: InsWarningLocker;
   f_SearchArea: TnsSearchArea;
   f_SearchWindowVisible: Boolean;
   ucpFilters: IucpFilters;
   f_SortTypeMap: InsIntegerValueMap;
   f_NeedDropCRList: Boolean;
  private
   function IsFilterActive(const aFilter: IFilterFromQuery): Boolean;
   function GetAsDocument(const aNode: INodeBase): IDocument;
   procedure cfListChange(Sender: TObject);
   procedure cfListWrongContext(Sender: TObject);
   procedure tvListCountChanged(Sender: TObject;
    NewCount: Integer);
   procedure tvListAfterFirstPaint(Sender: TObject);
   procedure tvListCurrentIndexChanged(aNew: Integer;
    anOld: Integer);
   function tvListGetItemIconHint(Sender: TObject;
    Index: Integer): Il3CString;
   procedure tvListMakeTreeSource(out theTree: Il3SimpleTree);
   function tvListGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure tvListActionElement(Sender: TObject;
    Index: Integer);
   procedure tvListCurrentChanged(Sender: TObject;
    NewCurrent: Integer;
    OldCurrent: Integer);
   procedure tvListTreeChanged(aSender: TObject;
    const anOldTree: Il3SimpleTree;
    const aNewTree: Il3SimpleTree);
   procedure tvListRootChanged(aSender: TObject;
    const anOldRoot: IeeNode;
    const aNewRoot: IeeNode);
   procedure tvListSelectCountChanged(aSender: TObject;
    anOldCount: Integer;
    aNewCount: Integer);
   procedure tvListFormatStatusInfo(aSender: TObject;
    var Info: Il3CString;
    aCurrent: Integer;
    aCount: Integer;
    aSelected: Integer);
   procedure tvListNewCharPressed(aChar: AnsiChar);
   procedure tvListCheckFocusedInPaint(aSender: TObject;
    var aFocused: Boolean);
   procedure tvListFooterClick(Sender: TObject);
   function tvListGetNodeType(anIndex: Integer): TbsListNodeType;
   procedure CallCurrentChanged;
   procedure ExSearchLabelClick(Sender: TObject);
  protected
   function pm_GetNoMoreThanOneSelected: Boolean;
   function pm_GetOnlyOneSelected: Boolean;
   function HasSelected: Boolean;
   procedure SelectionOpsTest(const aParams: IvcmTestParamsPrim);
   procedure StatusParamsShow;
   procedure OpenCurrentList(const aContainer: IvcmContainer);
    {* открыть текущий список }
   procedure AddSelectedToControl(aOnlySet: Boolean);
   procedure ListOpsWithTrialModeTest(const aParams: IvcmTestParamsPrim);
   function MakePreview(WithTexts: Boolean): IafwComplexDocumentPreview;
   procedure SaveList(InitialSaveTitles: Boolean;
    MinSelectedCount: Integer = 2);
   procedure SaveDialogCanClose(Sender: TObject;
    var CanClose: Boolean);
   function ApproxExportCount(aUseSelection: Boolean): Integer;
   function CalcSaveListKind(aTitles: Boolean = True): TbsSaveListKind;
   procedure ListopPrintTest(const aParams: IvcmTestParamsPrim);
   function CreateListName(aHasSelection: Boolean = False): Il3CString;
   procedure OpenInNewWindow;
    {* открывает список в текущем окне }
   function ForbidOpForDocumentSchema(const aParams: IvcmTestParamsPrim): Boolean;
    {* запретить операцию для документа схемы }
   procedure DocumentOpsWithTrialModeTest(const aParams: IvcmTestParamsPrim);
   procedure DocumentOpsTest(const aParams: IvcmTestParamsPrim);
   procedure UpdateFooter;
   function HasContextFiltration: Boolean;
   procedure InitNewContainerBaseSearch(const aContainer: IvcmContainer;
    aOpenKind: TvcmMainFormOpenKind);
   procedure CheckExSearchPanelVisibility; virtual;
   procedure ShowEditorOrList(const aTree: Il3SimpleTree); virtual; abstract;
   function ApplyFilter(const aFilter: IFilterFromQuery;
    aAdd: Boolean = False): Boolean; virtual; abstract;
   function IsListEmpty: Boolean; virtual; abstract;
   function HasCurrent: Boolean;
   procedure DeleteSelectionFromList;
   procedure ClearFilters;
   procedure DoSwitchToFullList;
   procedure ListOpsTest(const aParams: IvcmTestParamsPrim);
   procedure QueryMaximized; virtual; abstract;
   procedure QueryOpen; virtual; abstract;
   procedure SaveToFolders(aOperation: Integer = 0); virtual; abstract;
   function MakeFilterInfo(aType: TnsFolderFilter): InsFolderFilterInfo; virtual; abstract;
   procedure ResetSaveToFolderOperations; virtual; abstract;
   function CheckValidSortTypes(aSortType: TbsValidSortTypes): Boolean; virtual; abstract;
   procedure LftRespondentsSynchroFormQueryMaximized(aSender: TObject); override;
    {* Обработчик события lftRespondentsSynchroForm.OnQueryMaximized }
   procedure LftRToPartQueryOpen(aSender: TObject); override;
    {* Обработчик события lftRToPart.OnQueryOpen }
   procedure LftCorrespondentsSynchroFormQueryOpen(aSender: TObject); override;
    {* Обработчик события lftCorrespondentsSynchroForm.OnQueryOpen }
   procedure LftUserCR2QueryOpen(aSender: TObject); override;
    {* Обработчик события lftUserCR2.OnQueryOpen }
   procedure LftSimilarDocumentsQueryOpen(aSender: TObject); override;
    {* Обработчик события lftSimilarDocuments.OnQueryOpen }
   procedure LftSimilarDocumentsQueryMaximized(aSender: TObject); override;
    {* Обработчик события lftSimilarDocuments.OnQueryMaximized }
   function pm_GetArea: TnsSearchArea;
   procedure pm_SetArea(aValue: TnsSearchArea);
   function Kind: TnsBaseSearchKind;
   function Find(const aContext: InsBaseSearchContextProvider;
    const aProcessor: InsBaseSearchResultProcessor): Boolean;
   function AllowSearchInTitles: Boolean;
   function IsLocalSearchArea: Boolean;
   procedure ContextChanged(const aNewContext: Il3CString);
   function IsLocalDataReady: Boolean;
   function WindowRequired: Boolean;
   function WindowCloseable: Boolean;
   function CanCloseWindow: Boolean;
   function IsQueryCard: Boolean;
   function TreatSuccessSearchAsManualOpen: Boolean;
   function AutoActivateWindow: Boolean;
   procedure VisibleChanged(aNewVisible: Boolean);
   procedure DoTabActivate; override;
    {* Реакция на переключение вкладки }
   procedure GotoActualRedaction;
    {* выключить и перейти в актуальную редакцию }
   procedure StayInCurrentRedaction;
    {* выключить и остаться в текущей редакции }
   procedure ChangeDate(aDate: RtlDateTime);
    {* изменить }
   function Get_DisableOps: TnsTurnOffTimeMachineOperations;
   function FindBack(const aContext: InsBaseSearchContextProvider;
    const aProcessor: InsBaseSearchResultProcessor): Boolean;
    {* Искать назад }
   function FindBackSupported: Boolean;
   function FindBackEnabled: Boolean;
   function FragmentsCountSuffix: Il3CString;
   {$If NOT Defined(DesignTimeLibrary)}
   procedure DoStyleTableChanged; override;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure FillList(const aList: InscStatusBarItemDefsList); override;
    {* Заполняет список операций. Для перекрытия в потомках }
   function AllowPrompts: Boolean;
   function PromptsInfo: LongWord;
   function Get_ContainerForBaseSearch: TnsContainerForBaseSearchInfo;
   function Get_VisibleWatcher: InsBaseSearchVisibleWatcher;
   function Get_ContextSearcher: InsContextSearcher;
   procedure LftUserCRList2SynchorFormQueryOpen(aSender: TObject); override;
    {* Обработчик события lftUserCRList2_SynchorForm.OnQueryOpen }
   function SwitchToTextIfPossible: Boolean;
   function pm_GetHyperlinkDocID: Integer; override;
   function pm_GetHyperlinkDocumentName: Il3CString; override;
   function Get_NeedSaveActiveClassBeforeSearch: Boolean;
   procedure LftUserCRList1SynchorFormQueryMaximized(aSender: TObject); override;
    {* Обработчик события lftUserCRList1_SynchorForm.OnQueryMaximized }
   procedure LftProducedDrugsQueryClose(aSender: TObject); override;
    {* Обработчик события lftProducedDrugs.OnQueryClose }
   function IsSearchLocked: Boolean;
   procedure LftUserCR2QueryClose(aSender: TObject); override;
    {* Обработчик события lftUserCR2.OnQueryClose }
   procedure LftConsultationQueryOpen(aSender: TObject); override;
    {* Обработчик события lftConsultation.OnQueryOpen }
   procedure LftRespondentQueryMaximized(aSender: TObject); override;
    {* Обработчик события lftRespondent.OnQueryMaximized }
   procedure LftUserCR1QueryOpen(aSender: TObject); override;
    {* Обработчик события lftUserCR1.OnQueryOpen }
   procedure LftProducedDrugsQueryMaximized(aSender: TObject); override;
    {* Обработчик события lftProducedDrugs.OnQueryMaximized }
   procedure LftRespondentQueryClose(aSender: TObject); override;
    {* Обработчик события lftRespondent.OnQueryClose }
   procedure LftUserCR2QueryMaximized(aSender: TObject); override;
    {* Обработчик события lftUserCR2.OnQueryMaximized }
   procedure LftSimilarDocumentsSynchroViewQueryMaximized(aSender: TObject); override;
    {* Обработчик события lftSimilarDocumentsSynchroView.OnQueryMaximized }
   procedure LftCorrespondentQueryOpen(aSender: TObject); override;
    {* Обработчик события lftCorrespondent.OnQueryOpen }
   procedure LftCorrespondentsSynchroFormQueryMaximized(aSender: TObject); override;
    {* Обработчик события lftCorrespondentsSynchroForm.OnQueryMaximized }
   procedure LftUserCR1QueryMaximized(aSender: TObject); override;
    {* Обработчик события lftUserCR1.OnQueryMaximized }
   procedure LftUserCR1QueryClose(aSender: TObject); override;
    {* Обработчик события lftUserCR1.OnQueryClose }
   procedure LftDrugInternationalNameSynonymsQueryClose(aSender: TObject); override;
    {* Обработчик события lftDrugInternationalNameSynonyms.OnQueryClose }
   procedure LftSynchroViewQueryOpen(aSender: TObject); override;
    {* Обработчик события lftSynchroView.OnQueryOpen }
   procedure LftDrugInternationalNameSynonymsQueryOpen(aSender: TObject); override;
    {* Обработчик события lftDrugInternationalNameSynonyms.OnQueryOpen }
   procedure LftConsultationQueryClose(aSender: TObject); override;
    {* Обработчик события lftConsultation.OnQueryClose }
   procedure LftRToPartQueryMaximized(aSender: TObject); override;
    {* Обработчик события lftRToPart.OnQueryMaximized }
   procedure LftSimilarDocumentsQueryClose(aSender: TObject); override;
    {* Обработчик события lftSimilarDocuments.OnQueryClose }
   procedure LftSimilarDocumentsToFragmentQueryMaximized(aSender: TObject); override;
    {* Обработчик события lftSimilarDocumentsToFragment.OnQueryMaximized }
   procedure LftRespondentQueryOpen(aSender: TObject); override;
    {* Обработчик события lftRespondent.OnQueryOpen }
   procedure LftCorrespondentQueryMaximized(aSender: TObject); override;
    {* Обработчик события lftCorrespondent.OnQueryMaximized }
   procedure LftSimilarDocumentsToFragmentQueryOpen(aSender: TObject); override;
    {* Обработчик события lftSimilarDocumentsToFragment.OnQueryOpen }
   procedure LftProducedDrugsSynchroFormQueryOpen(aSender: TObject); override;
    {* Обработчик события lftProducedDrugsSynchroForm.OnQueryOpen }
   procedure LftConsultationQueryMaximized(aSender: TObject); override;
    {* Обработчик события lftConsultation.OnQueryMaximized }
   procedure LftCorrespondentQueryClose(aSender: TObject); override;
    {* Обработчик события lftCorrespondent.OnQueryClose }
   procedure LftSynchroViewQueryMaximized(aSender: TObject); override;
    {* Обработчик события lftSynchroView.OnQueryMaximized }
   procedure LftRespondentsSynchroFormQueryOpen(aSender: TObject); override;
    {* Обработчик события lftRespondentsSynchroForm.OnQueryOpen }
   procedure LftUserCRList2SynchorFormQueryMaximized(aSender: TObject); override;
    {* Обработчик события lftUserCRList2_SynchorForm.OnQueryMaximized }
   procedure LftUserCRList1SynchorFormQueryOpen(aSender: TObject); override;
    {* Обработчик события lftUserCRList1_SynchorForm.OnQueryOpen }
   procedure LftSimilarDocumentsSynchroViewQueryOpen(aSender: TObject); override;
    {* Обработчик события lftSimilarDocumentsSynchroView.OnQueryOpen }
   procedure LftProducedDrugsQueryOpen(aSender: TObject); override;
    {* Обработчик события lftProducedDrugs.OnQueryOpen }
   procedure LftDrugInternationalNameSynonymsQueryMaximized(aSender: TObject); override;
    {* Обработчик события lftDrugInternationalNameSynonyms.OnQueryMaximized }
   procedure LftSimilarDocumentsToFragmentQueryClose(aSender: TObject); override;
    {* Обработчик события lftSimilarDocumentsToFragment.OnQueryClose }
   procedure LftDrugInternationalNameSynonymsSynchroFormQueryOpen(aSender: TObject); override;
    {* Обработчик события lftDrugInternationalNameSynonymsSynchroForm.OnQueryOpen }
   procedure LftDrugInternationalNameSynonymsSynchroFormQueryMaximized(aSender: TObject); override;
    {* Обработчик события lftDrugInternationalNameSynonymsSynchroForm.OnQueryMaximized }
   procedure LftProducedDrugsSynchroFormQueryMaximized(aSender: TObject); override;
    {* Обработчик события lftProducedDrugsSynchroForm.OnQueryMaximized }
   procedure LftCToPartQueryMaximized(aSender: TObject); override;
    {* Обработчик события lftCToPart.OnQueryMaximized }
   procedure LftCToPartQueryOpen(aSender: TObject); override;
    {* Обработчик события lftCToPart.OnQueryOpen }
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
    {* Сохраняет состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType;
    aClone: Boolean): Boolean; override;
    {* Загружает состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   function NeedsStatusBarItems: Boolean; override;
    {* Определяет, что операции в статусной строке таки надо публиковать }
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PageActive; override;
   {$IfEnd} // NOT Defined(NoVCM)
   function NeedMakeHyperlinkToDocument: Boolean; override;
   {$If NOT Defined(NoVCM)}
   function IsAcceptable(aDataUpdate: Boolean): Boolean; override;
    {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function NeedLoadFormStateForClone(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure OpenDocument(const aDoc: IdeDocInfo;
    const aCont: IvcmContainer;
    aNeedReturnFocus: Boolean);
   {$If NOT Defined(NoVCM)}
   procedure Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_FindContext_Test(const aParams: IvcmTestParamsPrim);
    {* Поиск }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_FindContext_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Поиск }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure File_SaveToFolder_Test(const aParams: IvcmTestParamsPrim);
    {* Сохранить в папки }
   procedure File_SaveToFolder_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Сохранить в папки }
   procedure File_LoadFromFolder_Test(const aParams: IvcmTestParamsPrim);
    {* Загрузить из папок }
   procedure File_LoadFromFolder_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Загрузить из папок }
   procedure Document_AddToControl_Test(const aParams: IvcmTestParamsPrim);
    {* Поставить на контроль }
   procedure Document_AddToControl_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Поставить на контроль }
   procedure Document_AddToControl_GetState(var State: TvcmOperationStateIndex);
    {* Поставить на контроль }
   procedure Document_GetAttributesFrmAct_Test(const aParams: IvcmTestParamsPrim);
    {* Информация о документе }
   procedure Document_GetAttributesFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Информация о документе }
   function Loadable_Load_Execute(const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = LLO_NONE): Boolean;
    {* Коллеги, кто может описать этот метод? }
   procedure Loadable_Load(const aParams: IvcmExecuteParams);
    {* Коллеги, кто может описать этот метод? }
   procedure Document_GetRelatedDocFrmAct_Test(const aParams: IvcmTestParamsPrim);
    {* Справка к документу }
   procedure Document_GetRelatedDocFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Справка к документу }
   {$If NOT Defined(NoVCM)}
   procedure Edit_Undo_Test(const aParams: IvcmTestParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Undo_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Redo_Test(const aParams: IvcmTestParamsPrim);
    {* Возврат }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Redo_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Возврат }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Deselect_Test(const aParams: IvcmTestParamsPrim);
    {* Снять выделение }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Deselect_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Снять выделение }
   {$IfEnd} // NOT Defined(NoVCM)
   function SupportDisabled: Boolean;
   function Filterable_Add_Execute(const aFilter: IFilterFromQuery): Boolean;
   procedure Filterable_Add(const aParams: IvcmExecuteParams);
   function Filterable_Delete_Execute(const aFilter: IFilterFromQuery): Boolean;
   procedure Filterable_Delete(const aParams: IvcmExecuteParams);
   function List_GetDeList_Execute: IdeList;
   procedure List_GetDeList(const aParams: IvcmExecuteParams);
   procedure Filterable_ClearAll_Execute;
   procedure Filterable_ClearAll(const aParams: IvcmExecuteParams);
   function Filterable_Refresh_Execute: Boolean;
   procedure Filterable_Refresh(const aParams: IvcmExecuteParams);
   procedure TimeMachine_TimeMachineOffAndReset_Test(const aParams: IvcmTestParamsPrim);
   procedure TimeMachine_TimeMachineOffAndReset_Execute;
   procedure TimeMachine_TimeMachineOffAndReset(const aParams: IvcmExecuteParams);
   procedure List_SetCurrentVisible_Execute;
   procedure List_SetCurrentVisible(const aParams: IvcmExecuteParams);
   procedure TimeMachine_TimeMachineOnOffNew_Test(const aParams: IvcmTestParamsPrim);
    {* Включить Машину времени }
   procedure TimeMachine_TimeMachineOnOffNew_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Включить Машину времени }
   procedure TimeMachine_TimeMachineOnOffNew_GetState(var State: TvcmOperationStateIndex);
    {* Включить Машину времени }
   procedure List_SwitchToFullList_Test(const aParams: IvcmTestParamsPrim);
    {* Построить полный список }
   procedure List_SwitchToFullList_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Построить полный список }
   procedure List_ListInfo_Test(const aParams: IvcmTestParamsPrim);
   procedure List_ListInfo_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure List_Sort_Test(const aParams: IvcmTestParamsPrim);
   procedure List_Sort_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure List_SortDirection_Test(const aParams: IvcmTestParamsPrim);
   procedure List_SortDirection_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure List_SortDirection_GetState(var State: TvcmOperationStateIndex);
   procedure List_SpecifyList_Test(const aParams: IvcmTestParamsPrim);
   procedure List_SpecifyList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure List_ExportToXML_Test(const aParams: IvcmTestParamsPrim);
   procedure List_ExportToXML_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Filters_FiltersList_Test(const aParams: IvcmTestParamsPrim);
   procedure Filters_FiltersList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure LocalList_PublishSourceSearchInList_Test(const aParams: IvcmTestParamsPrim);
    {* Искать по источнику опубликования в текущем списке }
   procedure LocalList_PublishSourceSearchInList_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Искать по источнику опубликования в текущем списке }
   procedure LocalList_Open_Test(const aParams: IvcmTestParamsPrim);
   procedure LocalList_Open_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure LocalList_SearchDrugInList_Test(const aParams: IvcmTestParamsPrim);
   procedure LocalList_SearchDrugInList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Document_GetAnnotationDocFrmAct_Test(const aParams: IvcmTestParamsPrim);
   procedure Document_GetAnnotationDocFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Document_SimilarDocuments_Test(const aParams: IvcmTestParamsPrim);
   procedure Document_SimilarDocuments_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure CRList_SetType_Test(const aParams: IvcmTestParamsPrim);
   procedure CRList_SetType_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Document_GetGraphicImage_Test(const aParams: IvcmTestParamsPrim);
   procedure Document_GetGraphicImage_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure LocalList_OpenNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Открыть текущий список в новом окне }
   procedure Selection_CopyToNewList_Test(const aParams: IvcmTestParamsPrim);
   procedure Selection_CopyToNewList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Filters_Clear_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Selection_Analize_Test(const aParams: IvcmTestParamsPrim);
    {* Анализ списка... }
   procedure Selection_Analize_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Анализ списка... }
   procedure LocalList_SearchInList_Test(const aParams: IvcmTestParamsPrim);
    {* Искать по реквизитам в текущем списке }
   procedure LocalList_SearchInList_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Искать по реквизитам в текущем списке }
   procedure Filters_FiltersListOpen_Test(const aParams: IvcmTestParamsPrim);
    {* Фильтры (вкладка) }
   procedure Filters_FiltersListOpen_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Фильтры (вкладка) }
   procedure Filters_InternalClear_Execute;
   procedure Filters_InternalClear(const aParams: IvcmExecuteParams);
   function Filterable_GetListType_Execute: TbsListType;
   procedure Filterable_GetListType(const aParams: IvcmExecuteParams);
   function List_GetDsList_Execute: IdsList;
   procedure List_GetDsList(const aParams: IvcmExecuteParams);
   procedure List_Analize_Test(const aParams: IvcmTestParamsPrim);
    {* Анализ списка }
   procedure List_Analize_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Анализ списка }
   procedure List_AnalizeList_Test(const aParams: IvcmTestParamsPrim);
    {* Анализ списка... }
   procedure List_AnalizeList_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Анализ списка... }
   procedure List_SortForReminders_Test(const aParams: IvcmTestParamsPrim);
    {* Сортировать список }
   procedure List_SortForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Сортировать список }
   procedure List_SortDirectionForReminders_Test(const aParams: IvcmTestParamsPrim);
    {* Установить направление сортировки }
   procedure List_SortDirectionForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Установить направление сортировки }
   procedure List_SortDirectionForReminders_GetState(var State: TvcmOperationStateIndex);
    {* Установить направление сортировки }
   procedure List_SpecifyListForReminders_Test(const aParams: IvcmTestParamsPrim);
   procedure List_SpecifyListForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
  private
   property OnlyOneSelected: Boolean
    read pm_GetOnlyOneSelected;
  protected
   property CanSwithToFullList: Boolean
    read f_CanSwithToFullList
    write f_CanSwithToFullList;
   property NoMoreThanOneSelected: Boolean
    read pm_GetNoMoreThanOneSelected;
  public
   property ListPanel: TvtPanel
    read f_ListPanel;
   property tvList: TnscDocumentListTreeView
    read f_tvList;
   property cfList: TnscContextFilter
    read f_cfList;
   property ExSearchPanel: TvtPanel
    read f_ExSearchPanel;
   property ExSearchLabel: TvtStyledFocusLabel
    read f_ExSearchLabel;
    {* Продолжить поиск в онлайн-архивах ГАРАНТа }
 end;//TPrimListForm

var g_OverrideList: Integer = 0;
var g_SaveToFolders: Integer = 0;
var g_SaveToFoldersSelected: Integer = 0;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , ListUserTypes_lftNone_UserType
 , ListUserTypes_lftConsultation_UserType
 , ListUserTypes_lftDrugInternationalNameSynonyms_UserType
 , ListUserTypes_lftProducedDrugs_UserType
 , ListUserTypes_lftProducedDrugsSynchroForm_UserType
 , ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType
 , ListUserTypes_lftDrugList_UserType
 , ListUserTypes_lftRespondent_UserType
 , ListUserTypes_lftCorrespondent_UserType
 , ListUserTypes_lftSynchroView_UserType
 , ListUserTypes_lftCToPart_UserType
 , ListUserTypes_lftSimilarDocumentsSynchroView_UserType
 , ListUserTypes_lftCorrespondentsSynchroForm_UserType
 , ListUserTypes_lftRToPart_UserType
 , bsUtils
 , BaseTreeSupportUnit
 , nsUtils
 , BaseTypesUnit
 , nsOpenUtils
 , deList
 , nsListEvents
 , F1Like_InternalOperations_Controls
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , Math
 , nsTrialSupport
 , DataAdapter
 , vtSaveDialog
 , l3String
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Tree_TLB
 , afwFacade
 , nsFiltersContainer
 , nsConst
 , evdStyles
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3ControlsTypes
 , ListRes
 , nsExternalObjectModelPart
 , nsTabbedContainerUtils
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , Windows
 , nscDocumentHistory
 , vtLister
 , Graphics
 , IOUnit
 , nsSaveDialogExecutor
 , l3BatchService
 , ListUserTypes_lftUserCR1_UserType
 , ListUserTypes_lftUserCR2_UserType
 , ListUserTypes_lftSimilarDocuments_UserType
 , ListUserTypes_lftRespondentsSynchroForm_UserType
 , ListUserTypes_lftUserCRList1_SynchorForm_UserType
 , ListUserTypes_lftUserCRList2_SynchorForm_UserType
 , ListUserTypes_lftSimilarDocumentsToFragment_UserType
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , nsManagers
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , LoggingUnit
 , SysUtils
 {$If Defined(Nemesis)}
 , nscStatusBarOperationDefsList
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscStatusBarOperationDef
 {$IfEnd} // Defined(Nemesis)
 , l3Base
 , l3InterfacesMisc
 , nsBaseSearchService
 , evConstStringData
 , evdHyperlinkInfo
 , nsHyperlinkToDocumentProducerConst
 , afwNavigation
 , UnderControlUnit
 , l3Nodes
 , nsDocumentTools
 , nsExternalObjectPrim
 , nsSaveDialog
 , Printers
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *497DDB2B001Bimpl_uses*
 , Base_Operations_F1Services_Contracts
 , Common_F1CommonServices_Contracts
 //#UC END# *497DDB2B001Bimpl_uses*
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки Local }
 str_ListFooterCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListFooterCaption'; rValue : 'Полный список документов по запросу');
  {* 'Полный список документов по запросу' }

class procedure TnsDeleteFromListEvent.Log(const aList: IDynList);
//#UC START# *4B0A86E800FF_4B0A86AD0232_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0A86E800FF_4B0A86AD0232_var*
begin
//#UC START# *4B0A86E800FF_4B0A86AD0232_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aList);
 GetLogger.AddEvent(LE_DELETE_FROM_LIST, l_Data);
//#UC END# *4B0A86E800FF_4B0A86AD0232_impl*
end;//TnsDeleteFromListEvent.Log

class procedure TnsListExportToFileEvent.Log(const aList: IDynList;
 aCount: Cardinal;
 aSelection: Boolean;
 aTarget: TnsSaveDialogListTarget);
//#UC START# *4C46C48700C2_4C46C47002CA_var*
var
 l_Data: InsLogEventData;
const
 c_TypeMap: array [TnsSaveDialogListTarget] of Integer = (0, 1, 2);
//#UC END# *4C46C48700C2_4C46C47002CA_var*
begin
//#UC START# *4C46C48700C2_4C46C47002CA_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aList);
 l_Data.AddULong(aCount);
 l_Data.AddULong(c_SelectionMap[aSelection]);
 l_Data.AddULong(c_TypeMap[aTarget]);
 GetLogger.AddEvent(LE_LIST_EXPORT_TO_FILE, l_Data);
//#UC END# *4C46C48700C2_4C46C47002CA_impl*
end;//TnsListExportToFileEvent.Log

class procedure TnsListPrintPreviewEvent.Log(const aList: IDynList;
 aCount: Cardinal;
 aSelection: Boolean);
//#UC START# *4C46CAC40062_4C46CAB8035D_var*
var
 l_Data: InsLogEventData;
//#UC END# *4C46CAC40062_4C46CAB8035D_var*
begin
//#UC START# *4C46CAC40062_4C46CAB8035D_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aList);
 l_Data.AddULong(aCount);
 l_Data.AddULong(c_SelectionMap[aSelection]);
 GetLogger.AddEvent(LE_LIST_PRINT_PREVIEW, l_Data);
//#UC END# *4C46CAC40062_4C46CAB8035D_impl*
end;//TnsListPrintPreviewEvent.Log

class procedure TnsListExportToWordEvent.Log(const aList: IDynList;
 aCount: Cardinal;
 aSelection: Boolean);
//#UC START# *4C46CC6D02D6_4C46CC5C0104_var*
var
 l_Data: InsLogEventData;
//#UC END# *4C46CC6D02D6_4C46CC5C0104_var*
begin
//#UC START# *4C46CC6D02D6_4C46CC5C0104_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aList);
 l_Data.AddULong(aCount);
 l_Data.AddULong(c_SelectionMap[aSelection]);
 GetLogger.AddEvent(LE_LIST_EXPORT_TO_WORD, l_Data);
//#UC END# *4C46CC6D02D6_4C46CC5C0104_impl*
end;//TnsListExportToWordEvent.Log

class procedure TnsSendListByEmailEvent.Log(const aList: IDynList;
 aCount: Cardinal;
 aSelection: Boolean);
//#UC START# *4C46CD590073_4C46CD36024B_var*
var
 l_Data: InsLogEventData;
//#UC END# *4C46CD590073_4C46CD36024B_var*
begin
//#UC START# *4C46CD590073_4C46CD36024B_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aList);
 l_Data.AddULong(aCount);
 l_Data.AddULong(c_SelectionMap[aSelection]);
 GetLogger.AddEvent(LE_SEND_LIST_BY_EMAIL, l_Data);
//#UC END# *4C46CD590073_4C46CD36024B_impl*
end;//TnsSendListByEmailEvent.Log

class procedure TnsViewSameDocumentsEvent.Log(const aDoc: IDocument;
 aCount: Cardinal);
//#UC START# *4B0CF288004C_4B0CF2510084_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0CF288004C_4B0CF2510084_var*
begin
//#UC START# *4B0CF288004C_4B0CF2510084_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 l_Data.AddULong(aCount);
 GetLogger.AddEvent(LE_VIEW_SAME_DOCUMENTS, l_Data);
//#UC END# *4B0CF288004C_4B0CF2510084_impl*
end;//TnsViewSameDocumentsEvent.Log

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

constructor TPrimListFormState.Create(const aInnerState: IvcmBase;
 const aContextFilterState: IUnknown;
 const aTreeStructState: InsTreeStructState;
 aTopItemIndex: Integer;
 aCurrentIndex: Integer;
 aOptions: TPrimListFormStateOptions;
 aWasFiltered: Boolean);
//#UC START# *5677BAD7012E_5677B9280204_var*
//#UC END# *5677BAD7012E_5677B9280204_var*
begin
//#UC START# *5677BAD7012E_5677B9280204_impl*
 inherited Create;
 f_InnerState := aInnerState;
 f_ContextFilterState := aContextFilterState;
 f_TreeStructState := aTreeStructState;
 f_TopItemIndex := aTopItemIndex;
 f_CurrentIndex := aCurrentIndex;
 f_Options := aOptions;
 f_WasFiltered := aWasFiltered;
//#UC END# *5677BAD7012E_5677B9280204_impl*
end;//TPrimListFormState.Create

class function TPrimListFormState.Make(const aInnerState: IvcmBase;
 const aContextFilterState: IUnknown;
 const aTreeStructState: InsTreeStructState;
 aTopItemIndex: Integer;
 aCurrentIndex: Integer;
 aOptions: TPrimListFormStateOptions;
 aWasFiltered: Boolean): IPrimListFormState;
var
 l_Inst : TPrimListFormState;
begin
 l_Inst := Create(aInnerState, aContextFilterState, aTreeStructState, aTopItemIndex, aCurrentIndex, aOptions, aWasFiltered);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimListFormState.Make

function TPrimListFormState.pm_GetInnerState: IvcmBase;
//#UC START# *5677BA0B01C2_5677B9280204get_var*
//#UC END# *5677BA0B01C2_5677B9280204get_var*
begin
//#UC START# *5677BA0B01C2_5677B9280204get_impl*
 Result := f_InnerState;
//#UC END# *5677BA0B01C2_5677B9280204get_impl*
end;//TPrimListFormState.pm_GetInnerState

function TPrimListFormState.pm_GetContextFilterState: IUnknown;
//#UC START# *5677BA5B0133_5677B9280204get_var*
//#UC END# *5677BA5B0133_5677B9280204get_var*
begin
//#UC START# *5677BA5B0133_5677B9280204get_impl*
 Result := f_ContextFilterState;
//#UC END# *5677BA5B0133_5677B9280204get_impl*
end;//TPrimListFormState.pm_GetContextFilterState

function TPrimListFormState.pm_GetTreeStructState: InsTreeStructState;
//#UC START# *56A8ADEE0129_5677B9280204get_var*
//#UC END# *56A8ADEE0129_5677B9280204get_var*
begin
//#UC START# *56A8ADEE0129_5677B9280204get_impl*
 Result := f_TreeStructState; 
//#UC END# *56A8ADEE0129_5677B9280204get_impl*
end;//TPrimListFormState.pm_GetTreeStructState

function TPrimListFormState.pm_GetTopItemIndex: Integer;
//#UC START# *56A9C9980259_5677B9280204get_var*
//#UC END# *56A9C9980259_5677B9280204get_var*
begin
//#UC START# *56A9C9980259_5677B9280204get_impl*
 Result := f_TopItemIndex;
//#UC END# *56A9C9980259_5677B9280204get_impl*
end;//TPrimListFormState.pm_GetTopItemIndex

function TPrimListFormState.pm_GetOptions: TPrimListFormStateOptions;
//#UC START# *56A9DE4C03A0_5677B9280204get_var*
//#UC END# *56A9DE4C03A0_5677B9280204get_var*
begin
//#UC START# *56A9DE4C03A0_5677B9280204get_impl*
 Result := f_Options;
//#UC END# *56A9DE4C03A0_5677B9280204get_impl*
end;//TPrimListFormState.pm_GetOptions

function TPrimListFormState.pm_GetCurrentIndex: Integer;
//#UC START# *56E152870083_5677B9280204get_var*
//#UC END# *56E152870083_5677B9280204get_var*
begin
//#UC START# *56E152870083_5677B9280204get_impl*
 Result := f_CurrentIndex;
//#UC END# *56E152870083_5677B9280204get_impl*
end;//TPrimListFormState.pm_GetCurrentIndex

function TPrimListFormState.pm_GetWasFiltered: Boolean;
//#UC START# *5750305000AF_5677B9280204get_var*
//#UC END# *5750305000AF_5677B9280204get_var*
begin
//#UC START# *5750305000AF_5677B9280204get_impl*
 Result := f_WasFiltered;
//#UC END# *5750305000AF_5677B9280204get_impl*
end;//TPrimListFormState.pm_GetWasFiltered

function TPrimListFormState.QueryInterface(const IID: TGUID;
 out Obj): HResult;
 {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
//#UC START# *47A0AD3A01F7_5677B9280204_var*
//#UC END# *47A0AD3A01F7_5677B9280204_var*
begin
//#UC START# *47A0AD3A01F7_5677B9280204_impl*
 Result := inherited QueryInterface(IID, Obj);
//#UC END# *47A0AD3A01F7_5677B9280204_impl*
end;//TPrimListFormState.QueryInterface

procedure TPrimListFormState.FinishDataUpdate;
//#UC START# *47EA4E9002C6_5677B9280204_var*
//#UC END# *47EA4E9002C6_5677B9280204_var*
begin
//#UC START# *47EA4E9002C6_5677B9280204_impl*
 f_Options := [];
 f_TreeStructState := nil;
//#UC END# *47EA4E9002C6_5677B9280204_impl*
end;//TPrimListFormState.FinishDataUpdate

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\evStyleTableListener.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PageControlNotification.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas}

type _Instance_R_ = TPrimListForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentation.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\LinksToGarant\HyperlinkToDocumentProducer.imp.pas}

function TPrimListForm.pm_GetNoMoreThanOneSelected: Boolean;
//#UC START# *4C3AA8E0004C_497DDB2B001Bget_var*
//#UC END# *4C3AA8E0004C_497DDB2B001Bget_var*
begin
//#UC START# *4C3AA8E0004C_497DDB2B001Bget_impl*
 Result := tvList.TreeView.Tree.SelectedCount <= 1;
//#UC END# *4C3AA8E0004C_497DDB2B001Bget_impl*
end;//TPrimListForm.pm_GetNoMoreThanOneSelected

function TPrimListForm.pm_GetOnlyOneSelected: Boolean;
//#UC START# *4C3AAE7C00D0_497DDB2B001Bget_var*
//#UC END# *4C3AAE7C00D0_497DDB2B001Bget_var*
begin
//#UC START# *4C3AAE7C00D0_497DDB2B001Bget_impl*
 Result := tvList.TreeView.Tree.SelectedCount = 1;
//#UC END# *4C3AAE7C00D0_497DDB2B001Bget_impl*
end;//TPrimListForm.pm_GetOnlyOneSelected

function TPrimListForm.HasSelected: Boolean;
//#UC START# *4C341EE90370_497DDB2B001B_var*
//#UC END# *4C341EE90370_497DDB2B001B_var*
begin
//#UC START# *4C341EE90370_497DDB2B001B_impl*
 Result := tvList.TreeView.Tree.SelectedCount > 0;
//#UC END# *4C341EE90370_497DDB2B001B_impl*
end;//TPrimListForm.HasSelected

procedure TPrimListForm.SelectionOpsTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3440AB00A0_497DDB2B001B_var*
//#UC END# *4C3440AB00A0_497DDB2B001B_var*
begin
//#UC START# *4C3440AB00A0_497DDB2B001B_impl*
 if aParams.Control = tvList then
  aParams.Op.Flag[vcm_ofEnabled] := not IsListEmpty and HasSelected
 else
  if not aParams.CallControl then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C3440AB00A0_497DDB2B001B_impl*
end;//TPrimListForm.SelectionOpsTest

procedure TPrimListForm.StatusParamsShow;
//#UC START# *4C344155021B_497DDB2B001B_var*
//#UC END# *4C344155021B_497DDB2B001B_var*
begin
//#UC START# *4C344155021B_497DDB2B001B_impl*
 Dispatcher.UpdateStatus;
//#UC END# *4C344155021B_497DDB2B001B_impl*
end;//TPrimListForm.StatusParamsShow

function TPrimListForm.IsFilterActive(const aFilter: IFilterFromQuery): Boolean;
//#UC START# *4C37434901A0_497DDB2B001B_var*
//#UC END# *4C37434901A0_497DDB2B001B_var*
begin
//#UC START# *4C37434901A0_497DDB2B001B_impl*
 if Assigned(dsList) then
  Result := dsList.IsActiveFilter(aFilter)
 else
  Result := False;
//#UC END# *4C37434901A0_497DDB2B001B_impl*
end;//TPrimListForm.IsFilterActive

procedure TPrimListForm.OpenCurrentList(const aContainer: IvcmContainer);
 {* открыть текущий список }
//#UC START# *4C3A9EA80160_497DDB2B001B_var*
var
 l_List: IdeList;
//#UC END# *4C3A9EA80160_497DDB2B001B_var*
begin
//#UC START# *4C3A9EA80160_497DDB2B001B_impl*
 if Assigned(dsList) then
 begin
  l_List := dsList.NewList;
  if l_List <> nil then
  try
   TListService.Instance.OpenList(l_List, aContainer);
  finally
   l_List := nil;
  end;{try..finally}
 end;//if Assigned(dsDocumentList) then
//#UC END# *4C3A9EA80160_497DDB2B001B_impl*
end;//TPrimListForm.OpenCurrentList

procedure TPrimListForm.AddSelectedToControl(aOnlySet: Boolean);
//#UC START# *4C3AACCF01DC_497DDB2B001B_var*
var
 l_Tree: Il3ExpandedSimpleTree;

 function SetControlled(const aNode: Il3SimpleNode): Boolean;
 var
  l_Node: INodeBase;
  l_Document: IDocument;
  l_Controllable: IControllable;
 begin
  if Supports(aNode, INodeBase, l_Node) then
  try
   l_Document := GetAsDocument(l_Node);
   if Assigned(l_Document) and TCommonService.Instance.IsCurEditionActual(l_Document) and
      Supports(l_Document, IControllable, l_Controllable) then
   try
    if not l_Controllable.GetControlled then
     TCommonService.Instance.AddToControl(l_Controllable);
   finally
    l_Controllable := nil;
   end;
  finally
   l_Node := nil;
  end;
  Result := False;
 end;//SetControlled

var
 l_Count: Integer;
//#UC END# *4C3AACCF01DC_497DDB2B001B_var*
begin
//#UC START# *4C3AACCF01DC_497DDB2B001B_impl*
 l_Count := tvList.TreeView.Tree.SelectedCount;
 if Assigned(dsDocumentList) and
    (l_Count >= 1) then
 begin
  if (l_Count = 1) then
  begin
   if not dsDocumentList.IsUnderControl then
   begin
    dsDocumentList.AddToControl;
    Say(inf_SetDocToControl);
   end
   else //not dsDocumentList.IsUnderControl
    if Ask(qr_RemoveDocumentFromControl) then
     dsDocumentList.DelFromControl;
  end
  else // Выделено несколько элементов
   if Supports(tvList.TreeStruct, Il3ExpandedSimpleTree, l_Tree) then
   begin
    l_Tree.FlagIterateF(l3L2SNA(@SetControlled), FM_SELECTION);
    Say(inf_SetDocsToControl);
   end;
 end;
//#UC END# *4C3AACCF01DC_497DDB2B001B_impl*
end;//TPrimListForm.AddSelectedToControl

function TPrimListForm.GetAsDocument(const aNode: INodeBase): IDocument;
//#UC START# *4C3AB1450150_497DDB2B001B_var*
var
 l_BaseEntity: IEntityBase;
 l_ListEntry: IListEntryInfo;
//#UC END# *4C3AB1450150_497DDB2B001B_var*
begin
//#UC START# *4C3AB1450150_497DDB2B001B_impl*
 Result := nil;
 try
  aNode.GetEntity(l_BaseEntity);
  try
   if Supports(l_BaseEntity, IListEntryInfo, l_ListEntry) then
    try
     l_ListEntry.GetDoc(Result);
    finally
     l_ListEntry := nil;
    end;//try..finally
  finally
   l_BaseEntity := nil;
  end;//try..finally
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;//try..except
//#UC END# *4C3AB1450150_497DDB2B001B_impl*
end;//TPrimListForm.GetAsDocument

procedure TPrimListForm.ListOpsWithTrialModeTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4C46BD3E00FD_497DDB2B001B_var*
//#UC END# *4C46BD3E00FD_497DDB2B001B_var*
begin
//#UC START# *4C46BD3E00FD_497DDB2B001B_impl*
 ListOpsTest(aParams);
 nsDisableOperationInTrialMode(aParams);
//#UC END# *4C46BD3E00FD_497DDB2B001B_impl*
end;//TPrimListForm.ListOpsWithTrialModeTest

function TPrimListForm.MakePreview(WithTexts: Boolean): IafwComplexDocumentPreview;
var l_Node: Il3SimpleNode;
var l_Super: InsSuperComplexDocumentPreview;
//#UC START# *4C46BDD50220_497DDB2B001B_var*
//#UC END# *4C46BDD50220_497DDB2B001B_var*
begin
//#UC START# *4C46BDD50220_497DDB2B001B_impl*
 Result := nil;
 if Assigned(dsList) then
 begin
  with dsList do
   l_Super := MakeSuperPreview(bsListPrintOnlyFirstLevel(ListType), WithTexts);
  if (l_Super <> nil) and (l_Super.DocumentTitles <> nil) and (l_Super.DocumentTitles.Document <> nil) and
   Supports(tvList.TreeView.CurrentNode, Il3SimpleNode, l_Node) then
   l_Super.DocumentTitles.Document.SetCurrentPagePara(dsList.NodeId(l_Node));
  Result := l_Super;
 end;//if Assigned(dsDocumentList) then
//#UC END# *4C46BDD50220_497DDB2B001B_impl*
end;//TPrimListForm.MakePreview

procedure TPrimListForm.SaveList(InitialSaveTitles: Boolean;
 MinSelectedCount: Integer = 2);
//#UC START# *4C46BEFD00CB_497DDB2B001B_var*
var
 l_Stream     : IStream;
 l_Visualizer : IafwLongProcessVisualizer;
 l_Output: TnsGetGenOutputStruct;
 l_Saved: Boolean;
//#UC END# *4C46BEFD00CB_497DDB2B001B_var*
begin
//#UC START# *4C46BEFD00CB_497DDB2B001B_impl*
 if Assigned(dsList) and not dsList.IsListEmpty then
  try
   l_Stream := nil;
   with dmStdRes do begin
    if afw.Application.IsInternal then
     SaveDialog.DialogKind := ns_sdkListInternal
    else
     SaveDialog.DialogKind := ns_sdkList;

    if InitialSaveTitles then
     SaveDialog.SaveListTarget := ns_sdlkTitles
    else
     SaveDialog.SaveListTarget := ns_sdlkContents;
    SaveDialog.MergeChecked := False;
    SaveDialog.SelectedOnlyEnabled := tvList.TreeView.Tree.SelectedCount >= MinSelectedCount;
    SaveDialog.SelectedOnlyChecked := SaveDialog.SelectedOnlyEnabled;
    //l_PathName := dsList.ListName;
    l_Output := TnsGetGenOutputStruct_Create(dsList.ListName);
    if SaveDialog.SelectedOnlyChecked then
    begin
     if InitialSaveTitles then
      l_Output.rName := l3Fmt(vcmCStr(str_SaveSelectedListPrefix),[l_Output.rName])
     else
      l_Output.rName := l3Fmt(vcmCStr(str_ExportSelectedListPrefix),[l_Output.rName]);
    end;//if SaveDialog.SelectedOnlyChecked then
    SaveDialog.FileName := l3Str(nsPrepareFileName(l_Output.rName));
    SaveDialog.OnCanClose := SaveDialogCanClose;
    try
     if TnsSaveDialogExecutor.Instance.Call(SaveDialog) then
     begin
      if (SaveDialog.SaveListTarget = ns_sdlkTitles) and
         (SaveDialog.SelectedFileFormat = ns_ffXML) and
         defDataAdapter.ListXMLExportEnabled then
      begin
       dsList.SaveToFile(l3PCharLen(SaveDialog.FileName), SaveDialog.SelectedOnlyChecked);
       Exit;
      end;
      TnsListExportToFileEvent.Log(dsList.List, ApproxExportCount(SaveDialog.SelectedOnlyChecked),
        SaveDialog.SelectedOnlyChecked, SaveDialog.SaveListTarget);
      case SaveDialog.SaveListTarget of
       ns_sdlkTitles,
       ns_sdlkIdentifiers:
        begin
         l_Visualizer := bsMakeSaveVisualizer(vcmCStr(str_SaveListVisualizer));
         try
          l_Stream := dsList.ListAsText(CalcSaveListKind(SaveDialog.SaveListTarget = ns_sdlkTitles),
            SaveDialog.SelectedOnlyChecked);
          try
           //http://mdp.garant.ru/pages/viewpage.action?pageId=484813563
           Finalize(l_Output);
           l_Output := TnsGetGenOutputStruct_Create(nsCStr(SaveDialog.FileName));
           if not nsEvdStreamSaveAs(l_Stream,
                                    l_Output,
                                    SaveDialog.SelectedFileFormat,
                                    False) then
           begin
            l_Visualizer := nil;
            Say(err_CannotSave, [l_Output.rName]);
           end;
          finally
            l_Stream := nil;
          end;
         finally
          l_Visualizer := nil;
         end;
        end;
       ns_sdlkContents:
        begin
         afw.ProcessMessages;
         try
          l_Saved := True;
          l_Visualizer := bsMakeSaveVisualizer(vcmCStr(str_SaveDocumentsVisualizer));
          try
           if SaveDialog.MergeChecked then
            l_Saved := dsList.MergeDocuments(bsListPrintOnlyFirstLevel(dsList.ListType),
             SaveDialog.SelectedOnlyChecked, nsCStr(SaveDialog.FileName),
             SaveDialog.SelectedFileFormat, afw.Application.IsInternal)
           else
            l_Saved := dsList.ExportDocuments(bsListPrintOnlyFirstLevel(dsList.ListType),
             SaveDialog.SelectedOnlyChecked, nsCStr(ExtractFilePath(SaveDialog.FileName)),
             SaveDialog.SelectedFileFormat);
          finally
           l_Visualizer := nil;
          end;
           if not l_Saved then
          begin
           if SaveDialog.MergeChecked then
            DeleteFile(SaveDialog.FileName);
            Say(inf_ExportForThisDocumentsImpossible)
          end;
         except
          on ECannotSave do
           Say(err_ListSaveToFileError);
         end{try..except}
        end;
      end;
     end;
    finally
     SaveDialog.OnCanClose := nil;
     Dispatcher.UpdateStatus;
    end;
   end;
  except
   on E: Exception do
    l3System.Exception2Log(E);
  end;
//#UC END# *4C46BEFD00CB_497DDB2B001B_impl*
end;//TPrimListForm.SaveList

procedure TPrimListForm.SaveDialogCanClose(Sender: TObject;
 var CanClose: Boolean);
//#UC START# *4C46C3D50130_497DDB2B001B_var*
//#UC END# *4C46C3D50130_497DDB2B001B_var*
begin
//#UC START# *4C46C3D50130_497DDB2B001B_impl*
 with Sender as TnsSaveDIalog do
 begin
  if (SaveListTarget = ns_sdlkContents) and (ApproxExportCount(SelectedOnlyChecked) > c_MaxDocumentInListLimit) then
   if not afw.Application.IsInternal or not afw.Settings.LoadBoolean(pi_List_ExportWORestrictions, dv_List_ExportWORestrictions) then
   begin
    CanClose := False;
    Say(war_TryToExportTooManyDocs, [c_MaxDocumentInListLimit]);
   end;
  if (SaveListTarget = ns_sdlkTitles) and (ApproxExportCount(SelectedOnlyChecked) > c_MaxTotalDocumentInListLimit) then
   if not afw.Application.IsInternal or not afw.Settings.LoadBoolean(pi_List_ExportWORestrictions, dv_List_ExportWORestrictions) then
   begin
    CanClose := False;
    Say(war_TryToExportTooManyTotalDocs, [c_MaxTotalDocumentInListLimit]);
   end;
 end; 
//#UC END# *4C46C3D50130_497DDB2B001B_impl*
end;//TPrimListForm.SaveDialogCanClose

function TPrimListForm.ApproxExportCount(aUseSelection: Boolean): Integer;
//#UC START# *4C46C40703A2_497DDB2B001B_var*
//#UC END# *4C46C40703A2_497DDB2B001B_var*
begin
//#UC START# *4C46C40703A2_497DDB2B001B_impl*
 if aUseSelection then
  Result := tvList.TreeView.Tree.SelectedCount
 else
  Result := tvList.TreeView.Tree.Root.ThisChildrenCount;
//#UC END# *4C46C40703A2_497DDB2B001B_impl*
end;//TPrimListForm.ApproxExportCount

function TPrimListForm.CalcSaveListKind(aTitles: Boolean = True): TbsSaveListKind;
//#UC START# *4C46C42C019B_497DDB2B001B_var*
//#UC END# *4C46C42C019B_497DDB2B001B_var*
begin
//#UC START# *4C46C42C019B_497DDB2B001B_impl*
 if aTitles then
 begin
  if bsListPrintOnlyFirstLevel(dsList.ListType) then
   Result := bs_slkTitlesFirstLevel
  else
   Result := bs_slkTitlesFullTree
 end
 else
  Result := bs_slkTitlesTopicNumbers
//#UC END# *4C46C42C019B_497DDB2B001B_impl*
end;//TPrimListForm.CalcSaveListKind

procedure TPrimListForm.ListopPrintTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4C46CA7A0020_497DDB2B001B_var*
//#UC END# *4C46CA7A0020_497DDB2B001B_var*
begin
//#UC START# *4C46CA7A0020_497DDB2B001B_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(dsList) and
  (Printer.Printers.Count > 0) and not dsList.IsListEmpty and
  HasCurrent;
//#UC END# *4C46CA7A0020_497DDB2B001B_impl*
end;//TPrimListForm.ListopPrintTest

function TPrimListForm.CreateListName(aHasSelection: Boolean = False): Il3CString;
//#UC START# *4C46CBBD0211_497DDB2B001B_var*
//#UC END# *4C46CBBD0211_497DDB2B001B_var*
begin
//#UC START# *4C46CBBD0211_497DDB2B001B_impl*
 Result := nil;
 if Assigned(dsList) then
 try
  Result := dsList.ListName;
  if aHasSelection then
   Result := vcmFmt(str_SaveSelectedListPrefix, [Result]);
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;//try..except
//#UC END# *4C46CBBD0211_497DDB2B001B_impl*
end;//TPrimListForm.CreateListName

procedure TPrimListForm.OpenInNewWindow;
 {* открывает список в текущем окне }
//#UC START# *4C46E91E0188_497DDB2B001B_var*
var
 l_Container: IvcmContainer;
//#UC END# *4C46E91E0188_497DDB2B001B_var*
begin
//#UC START# *4C46E91E0188_497DDB2B001B_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=414849606
 l_Container := nsNewWindow(NativeMainForm);
 if (l_Container <> nil) then
 try
  OpenCurrentList(l_Container);
 finally
  l_Container := nil;
 end;
//#UC END# *4C46E91E0188_497DDB2B001B_impl*
end;//TPrimListForm.OpenInNewWindow

function TPrimListForm.ForbidOpForDocumentSchema(const aParams: IvcmTestParamsPrim): Boolean;
 {* запретить операцию для документа схемы }
//#UC START# *4C5289B102E0_497DDB2B001B_var*
//#UC END# *4C5289B102E0_497DDB2B001B_var*
begin
//#UC START# *4C5289B102E0_497DDB2B001B_impl*
 Result := (sdsBaseDocument <> nil) AND (sdsBaseDocument.DocInfo <> nil) AND
           (sdsBaseDocument.DocInfo.Doc <> nil) AND
           (sdsBaseDocument.DocInfo.Doc.GetDocType = DT_FLASH);
 aParams.Op.Flag[vcm_ofEnabled] := not Result;
//#UC END# *4C5289B102E0_497DDB2B001B_impl*
end;//TPrimListForm.ForbidOpForDocumentSchema

procedure TPrimListForm.DocumentOpsWithTrialModeTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4C5289E9034B_497DDB2B001B_var*
//#UC END# *4C5289E9034B_497DDB2B001B_var*
begin
//#UC START# *4C5289E9034B_497DDB2B001B_impl*
 DocumentOpsTest(aParams);
 nsDisableOperationInTrialMode(aParams);
//#UC END# *4C5289E9034B_497DDB2B001B_impl*
end;//TPrimListForm.DocumentOpsWithTrialModeTest

procedure TPrimListForm.DocumentOpsTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4C528A1900DC_497DDB2B001B_var*

  function lp_IsValidDocument: Boolean;
  begin
   // Для докуменов вводится ограничение на выполняемые операции, для препаратов
   // ограничений на выполенние операции нет:
   if dsDocumentList <> nil then
    Result := dsDocumentList.IsDocument
   else
    Result := dsList <> nil;
  end;//lp_IsValidDocument

//#UC END# *4C528A1900DC_497DDB2B001B_var*
begin
//#UC START# *4C528A1900DC_497DDB2B001B_impl*
 with tvList.TreeView do
  aParams.Op.Flag[vcm_ofEnabled] := lp_IsValidDocument and
   NoMoreThanOneSelected and HasCurrent;
//#UC END# *4C528A1900DC_497DDB2B001B_impl*
end;//TPrimListForm.DocumentOpsTest

procedure TPrimListForm.cfListChange(Sender: TObject);
//#UC START# *4F7EEE6D030A_497DDB2B001B_var*
var
 l_Tree: Il3FilterableTree;
 l_Filtered: Il3SimpleTree;
 l_Node: Il3SimpleNode;
 l_NewNodeIndex: Integer;
//#UC END# *4F7EEE6D030A_497DDB2B001B_var*
begin
//#UC START# *4F7EEE6D030A_497DDB2B001B_impl*
 if Supports(tvList.TreeStruct, Il3FilterableTree, l_Tree) then
 try
  l_Node := tvList.GetCurrentNode;
  try
   l_Filtered := l_Tree.MakeFiltered(l_Tree.
                                     CloneFilters.
                                     SetContext(cfList.ActiveContext),
                                     l_Node,
                                     l_NewNodeIndex,
                                     True,
                                     cfList.NeedRefilterTree);
   if Assigned(l_Filtered) and (l_Filtered.CountView > 0) then
   begin
    tvList.TreeStruct := l_Filtered;
    if l_Node <> nil then
     tvList.GotoOnNode(l_Node);
   end;
  finally
   l_Node := nil;
  end;
 finally
  l_Tree := nil;
 end;
//#UC END# *4F7EEE6D030A_497DDB2B001B_impl*
end;//TPrimListForm.cfListChange

procedure TPrimListForm.cfListWrongContext(Sender: TObject);
//#UC START# *4F7EEEA2013D_497DDB2B001B_var*
//#UC END# *4F7EEEA2013D_497DDB2B001B_var*
begin
//#UC START# *4F7EEEA2013D_497DDB2B001B_impl*
 nsBeepWrongContext;
//#UC END# *4F7EEEA2013D_497DDB2B001B_impl*
end;//TPrimListForm.cfListWrongContext

procedure TPrimListForm.tvListCountChanged(Sender: TObject;
 NewCount: Integer);
//#UC START# *4F7EEEF800E8_497DDB2B001B_var*
//#UC END# *4F7EEEF800E8_497DDB2B001B_var*
begin
//#UC START# *4F7EEEF800E8_497DDB2B001B_impl*
 // Все элементы были удалены нужно показать сообщение:
 ShowEditorOrList(nil);
 Dispatcher.UpdateStatus;
// if Assigned(dsList) then
//  dsList.CurrentChanged(tvList.GetCurrentNode, False);
 CallCurrentChanged;
//#UC END# *4F7EEEF800E8_497DDB2B001B_impl*
end;//TPrimListForm.tvListCountChanged

procedure TPrimListForm.tvListAfterFirstPaint(Sender: TObject);
//#UC START# *4F7EEF230221_497DDB2B001B_var*
//#UC END# *4F7EEF230221_497DDB2B001B_var*
begin
//#UC START# *4F7EEF230221_497DDB2B001B_impl*
 {$IfDef vcmUseProfilers}
 if UserType = lftNone then
  ProfilersManager.ListAfterSearch.Finish;
 {$EndIf vcmUseProfilers}
//#UC END# *4F7EEF230221_497DDB2B001B_impl*
end;//TPrimListForm.tvListAfterFirstPaint

procedure TPrimListForm.tvListCurrentIndexChanged(aNew: Integer;
 anOld: Integer);
//#UC START# *4F7EEF450143_497DDB2B001B_var*
//#UC END# *4F7EEF450143_497DDB2B001B_var*
begin
//#UC START# *4F7EEF450143_497DDB2B001B_impl*
 Dispatcher.UpdateStatus;
//#UC END# *4F7EEF450143_497DDB2B001B_impl*
end;//TPrimListForm.tvListCurrentIndexChanged

function TPrimListForm.tvListGetItemIconHint(Sender: TObject;
 Index: Integer): Il3CString;
//#UC START# *4F7EEF8500A8_497DDB2B001B_var*
var
 l_NT: TbsListNodeType;
//#UC END# *4F7EEF8500A8_497DDB2B001B_var*
begin
//#UC START# *4F7EEF8500A8_497DDB2B001B_impl*
 Result := nil;
 if Assigned(dsList) then
 begin
  l_NT := dsList.ListNodeType(tvList.GetNode(Index));
  case l_NT of
   lntAAC: Result := vcmCStr(str_lntAAC);
   lntBlock: Result := vcmCStr(str_lntBlock);
   lntDocActive: Result := vcmCStr(str_lntDocActive);
   lntDocPreActive: Result := vcmCStr(str_lntDocPreActive);
   lntDocAbolished: Result := vcmCStr(str_lntDocAbolished);
   lntRedaction: Result := vcmCStr(str_lntRedaction);
   lntRedactions: Result := vcmCStr(str_lntRedactions);
   lntDrugAnnuled: Result := vcmCStr(str_lntDrugAnnuled);
   lntDrugNarcotic: Result := vcmCStr(str_lntDrugNarcotic);
   lntDrugNoAnnuledNoNarcoric: Result := vcmCStr(str_lntDrugNoAnnuledNoNarcoric);
   lntFormAnnuled: Result := vcmCStr(str_lntFormAnnuled);
   lntFormRussianImportant: Result := vcmCStr(str_lntFormRussianImportant);
   lntFormNoRussianImportant: Result := vcmCStr(str_lntFormNoRussianImportant);
   lntFormRussianNoImportant: Result := vcmCStr(str_lntFormRussianNoImportant);
   lntFormNoRussianNoImportant: Result := vcmCStr(str_lntFormNoRussianNoImportant);
  else
   Result := vcmCStr(str_Empty);
  end;
 end;
//#UC END# *4F7EEF8500A8_497DDB2B001B_impl*
end;//TPrimListForm.tvListGetItemIconHint

procedure TPrimListForm.tvListMakeTreeSource(out theTree: Il3SimpleTree);
//#UC START# *4F7EEFB001FD_497DDB2B001B_var*
var
 l_Node: INodeBase;
//#UC END# *4F7EEFB001FD_497DDB2B001B_var*
begin
//#UC START# *4F7EEFB001FD_497DDB2B001B_impl*
 if (dsSimpleTree <> nil) then
 begin
  theTree := dsSimpleTree.SimpleTree;
  if (theTree <> nil) then
  begin
   if Supports(theTree.RootNode, INodeBase, l_Node) then
    l_Node.SetAllFlag(FM_SELECTION, False);
   if (dsDocumentList <> nil) and dsDocumentList.IsSnippet then
    theTree.ExpandSubDir(nil, True, 0);
  end;//theTree <> nil
 end//dsSimpleTree <> nil
 else
  theTree := nil;
//#UC END# *4F7EEFB001FD_497DDB2B001B_impl*
end;//TPrimListForm.tvListMakeTreeSource

function TPrimListForm.tvListGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *4F7EEFD601CE_497DDB2B001B_var*
const
 cListNodeTypeImageIndex : array [TbsListNodeType] of Integer = (
  InfoIcon, // lntUnknown,
  SubIcon, // lntBlock
  DocIcon, // lntDocActive
  DocIcon + PreActiveOffset, // lntDocPreActive
  DocIcon + NoActiveOffset, // lntDocAbolished
  ExObjIcon, // lntExternalObject
  WWWIcon, // lntExternalLink
  RedactionIcon, // lntRedaction
  RedactionFolder, // lntRedactions
  DrugAnnuled, // lntDrugAnnuled,
  DrugNarcotic, // lntDrugNarcotic,
  DrugNoAnnuledNoNarcoric, // lntDrugNoAnnuledNoNarcoric,
  FormAnnuled, // lntFormAnnuled,
  FormRussianImportant, // lntFormRussianImportant,
  FormNoRussianImportant, // lntFormNoRussianImportant,
  FormRussianNoImportant, // lntFormRussianNoImportant,
  FormNoRussianNoImportant, // lntFormNoRussianNoImportant
  DocIcon,
  AACDocumentIcon
 );
//#UC END# *4F7EEFD601CE_497DDB2B001B_var*
begin
//#UC START# *4F7EEFD601CE_497DDB2B001B_impl*
 if Assigned(dsList) then
  Result := cListNodeTypeImageIndex[dsList.ListNodeType(tvList.GetNode(Index))]
 else
  Result := -1;
//#UC END# *4F7EEFD601CE_497DDB2B001B_impl*
end;//TPrimListForm.tvListGetItemImage

procedure TPrimListForm.tvListActionElement(Sender: TObject;
 Index: Integer);
//#UC START# *4F7EF0130083_497DDB2B001B_var*
var
 l_DataInfo: IdeDocInfo;
 l_Cont : IvcmContainer;
 l_OpenKind: TvcmMainFormOpenKind;
//#UC END# *4F7EF0130083_497DDB2B001B_var*
begin
//#UC START# *4F7EF0130083_497DDB2B001B_impl*
 if dsList <> nil then
 begin
  // Установить теекущий необходимо после удаления элементов из дерева.
  // Ситуация такая:
  // - удаляем элементы из дерева;
  // - обязательно обнуляем документ в бизнес объекте, потому, что если держать
  //   текущий и спросить INodeBase.IsSame, адаптеру будет плохо;
  // - событие CurrentChanged дереву не пришло, это возможно в случае если
  //   удалили все кроме текущего, см. описание (CQ: 20409);
  // - поэтому текущий устанавливаем здесь:
  //dsList.CurrentChanged(tvList.GetCurrentNode, False);
  CallCurrentChanged;
  if dsList.OpenDocument(l_DataInfo) then
  try
   Dispatcher.LockCursor;
   try
    l_OpenKind := nsDocumentsFromListOpenKind;
    l_Cont := nsOpenNewWindowTabbed(NativeMainForm, l_OpenKind);
    if (l_Cont = nil) then
     Exit;
    InitNewContainerBaseSearch(l_Cont, l_OpenKind);
    // - http://mdp.garant.ru/pages/viewpage.action?pageId=566792807
    OpenDocument(l_DataInfo, l_Cont, (l_OpenKind = vcm_okInNewTab));
   finally
    Dispatcher.UnlockCursor;
   end;//try..finally
  finally
   l_DataInfo := nil;
  end;//try..finally
 end;//if Assigned(dsDocumentList) then
//#UC END# *4F7EF0130083_497DDB2B001B_impl*
end;//TPrimListForm.tvListActionElement

procedure TPrimListForm.tvListCurrentChanged(Sender: TObject;
 NewCurrent: Integer;
 OldCurrent: Integer);
//#UC START# *4F7EF03501DF_497DDB2B001B_var*
//#UC END# *4F7EF03501DF_497DDB2B001B_var*
begin
//#UC START# *4F7EF03501DF_497DDB2B001B_impl*
 if (dsList <> nil) then
  dsList.CurrentChanged(tvList.GetCurrentNode);
//#UC END# *4F7EF03501DF_497DDB2B001B_impl*
end;//TPrimListForm.tvListCurrentChanged

procedure TPrimListForm.tvListTreeChanged(aSender: TObject;
 const anOldTree: Il3SimpleTree;
 const aNewTree: Il3SimpleTree);
//#UC START# *4F7EF07001DF_497DDB2B001B_var*
//#UC END# *4F7EF07001DF_497DDB2B001B_var*
begin
//#UC START# *4F7EF07001DF_497DDB2B001B_impl*
 ShowEditorOrList(aNewTree);
//#UC END# *4F7EF07001DF_497DDB2B001B_impl*
end;//TPrimListForm.tvListTreeChanged

procedure TPrimListForm.tvListRootChanged(aSender: TObject;
 const anOldRoot: IeeNode;
 const aNewRoot: IeeNode);
//#UC START# *4F7EF09F0325_497DDB2B001B_var*
//#UC END# *4F7EF09F0325_497DDB2B001B_var*
begin
//#UC START# *4F7EF09F0325_497DDB2B001B_impl*
 UpdateFooter;
//#UC END# *4F7EF09F0325_497DDB2B001B_impl*
end;//TPrimListForm.tvListRootChanged

procedure TPrimListForm.tvListSelectCountChanged(aSender: TObject;
 anOldCount: Integer;
 aNewCount: Integer);
//#UC START# *4F7EF0DC0246_497DDB2B001B_var*
//#UC END# *4F7EF0DC0246_497DDB2B001B_var*
begin
//#UC START# *4F7EF0DC0246_497DDB2B001B_impl*
 Dispatcher.UpdateStatus;
//#UC END# *4F7EF0DC0246_497DDB2B001B_impl*
end;//TPrimListForm.tvListSelectCountChanged

procedure TPrimListForm.tvListFormatStatusInfo(aSender: TObject;
 var Info: Il3CString;
 aCurrent: Integer;
 aCount: Integer;
 aSelected: Integer);
//#UC START# *4F7EF12300F6_497DDB2B001B_var*
var
 l_Count: Integer;
const
 c_Count = 100;
//#UC END# *4F7EF12300F6_497DDB2B001B_var*
begin
//#UC START# *4F7EF12300F6_497DDB2B001B_impl*
 if Assigned(dsDocumentList) then
 begin
  // Для списков отсортированных по релевантности, для внутренней версии,
  // показываем релевантность текущего элемента (CQ: OIT5-23059):
  if afw.Application.IsInternal and (dsDocumentList.SortType = ST_RELEVANCE) then
   Info := vcmFmt(str_ListStatusInfoWithRelevance, [aCurrent, aCount, aSelected, dsDocumentList.CurrentRelevance]);

  if dsDocumentList.IsShortList then
  begin
   l_Count := dsDocumentList.FullListCount;
   l_Count := l_Count - l_Count mod c_Count;
   if l_Count > 0
    then Info := l3LTrim(l3Cat([Info, vcmFmt(str_ApproxShortListCount, [l_Count])]))
    else Info := l3LTrim(l3Cat([Info, vcmFmt(str_ApproxShortListCountEx, [c_Count])]));
  end;
 end;
//#UC END# *4F7EF12300F6_497DDB2B001B_impl*
end;//TPrimListForm.tvListFormatStatusInfo

procedure TPrimListForm.tvListNewCharPressed(aChar: AnsiChar);
//#UC START# *4F7EF16A0086_497DDB2B001B_var*
//#UC END# *4F7EF16A0086_497DDB2B001B_var*
begin
//#UC START# *4F7EF16A0086_497DDB2B001B_impl*
 if HasContextFiltration then
  cfList.PressChar(aChar);
//#UC END# *4F7EF16A0086_497DDB2B001B_impl*
end;//TPrimListForm.tvListNewCharPressed

procedure TPrimListForm.tvListCheckFocusedInPaint(aSender: TObject;
 var aFocused: Boolean);
//#UC START# *4F7EF18C027D_497DDB2B001B_var*
//#UC END# *4F7EF18C027D_497DDB2B001B_var*
begin
//#UC START# *4F7EF18C027D_497DDB2B001B_impl*
 if not aFocused then
  aFocused := f_SearchWindowVisible;
//#UC END# *4F7EF18C027D_497DDB2B001B_impl*
end;//TPrimListForm.tvListCheckFocusedInPaint

procedure TPrimListForm.tvListFooterClick(Sender: TObject);
//#UC START# *4F7EF1C1030D_497DDB2B001B_var*
//#UC END# *4F7EF1C1030D_497DDB2B001B_var*
begin
//#UC START# *4F7EF1C1030D_497DDB2B001B_impl*
 DoSwitchToFullList;
//#UC END# *4F7EF1C1030D_497DDB2B001B_impl*
end;//TPrimListForm.tvListFooterClick

procedure TPrimListForm.UpdateFooter;
//#UC START# *4F7EF6430383_497DDB2B001B_var*
//#UC END# *4F7EF6430383_497DDB2B001B_var*
begin
//#UC START# *4F7EF6430383_497DDB2B001B_impl*
 tvList.FooterVisible := Assigned(dsDocumentList) and dsDocumentList.IsShortList;
 CanSwithToFullList := tvList.FooterVisible;
 Dispatcher.UpdateStatus;
//#UC END# *4F7EF6430383_497DDB2B001B_impl*
end;//TPrimListForm.UpdateFooter

function TPrimListForm.HasContextFiltration: Boolean;
//#UC START# *4F7EFAA2026F_497DDB2B001B_var*
//#UC END# *4F7EFAA2026F_497DDB2B001B_var*
begin
//#UC START# *4F7EFAA2026F_497DDB2B001B_impl*
 Result := UserType = lftDrugList;
//#UC END# *4F7EFAA2026F_497DDB2B001B_impl*
end;//TPrimListForm.HasContextFiltration

function TPrimListForm.tvListGetNodeType(anIndex: Integer): TbsListNodeType;
//#UC START# *51DC1AA10279_497DDB2B001B_var*
//#UC END# *51DC1AA10279_497DDB2B001B_var*
begin
//#UC START# *51DC1AA10279_497DDB2B001B_impl*
 Assert(Assigned(dsList));
 Result := dsList.ListNodeType(tvList.GetNode(anIndex));
//#UC END# *51DC1AA10279_497DDB2B001B_impl*
end;//TPrimListForm.tvListGetNodeType

procedure TPrimListForm.InitNewContainerBaseSearch(const aContainer: IvcmContainer;
 aOpenKind: TvcmMainFormOpenKind);
//#UC START# *543E272E0005_497DDB2B001B_var*
//#UC END# *543E272E0005_497DDB2B001B_var*
begin
//#UC START# *543E272E0005_497DDB2B001B_impl*
 Assert(aContainer <> nil);
 if (UserType = lftNone) and
    (aOpenKind in [vcm_okInNewWindow, vcm_okInNewTab]) and
    (dsDocumentList <> nil) and
    (dsDocumentList.OpenFrom in [lofBaseSearch, lofBaseSearchEx, lofAttributeSearch]) then
  if (not aContainer.AsForm.VCMClosing) then
   aContainer.InitFromPrevContainer(NativeMainForm, False);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=566792807,
 // http://mdp.garant.ru/pages/viewpage.action?pageId=567573990
//#UC END# *543E272E0005_497DDB2B001B_impl*
end;//TPrimListForm.InitNewContainerBaseSearch

procedure TPrimListForm.CallCurrentChanged;
//#UC START# *5527D24201E7_497DDB2B001B_var*
//#UC END# *5527D24201E7_497DDB2B001B_var*
begin
//#UC START# *5527D24201E7_497DDB2B001B_impl*
 if Assigned(dsList) then
 begin
  f_AllowCallCurrentChangedOnTest := False;
  dsList.CurrentChanged(tvList.GetCurrentNode, False);
 end;
//#UC END# *5527D24201E7_497DDB2B001B_impl*
end;//TPrimListForm.CallCurrentChanged

procedure TPrimListForm.ExSearchLabelClick(Sender: TObject);
//#UC START# *56F3F0580255_497DDB2B001B_var*
var
 l_Url: IString;
//#UC END# *56F3F0580255_497DDB2B001B_var*
begin
//#UC START# *56F3F0580255_497DDB2B001B_impl*
 Assert(Assigned(f_SearchContext));
 defDataAdapter.NativeAdapter.MakeDecisionsArchiveSupport.GetSearchServerUrl(nsIStr(f_SearchContext), l_Url);

 // Открываем по стандартному алгоритму; только во внешнем браузере
 // http://mdp.garant.ru/pages/viewpage.action?pageId=620851813
 nsDoShellExecute(nsCStr(l_Url), True, nil);
//#UC END# *56F3F0580255_497DDB2B001B_impl*
end;//TPrimListForm.ExSearchLabelClick

procedure TPrimListForm.CheckExSearchPanelVisibility;
//#UC START# *56F412F403C7_497DDB2B001B_var*
var
 l_BS: InsBaseSearcher;
//#UC END# *56F412F403C7_497DDB2B001B_var*
begin
//#UC START# *56F412F403C7_497DDB2B001B_impl*
 l_BS := TnsBaseSearchService.Instance.GetBaseSearcher(As_IvcmEntityForm);

 if Assigned(dsList) and dsList.IsFiltered then
  f_WasFiltered := True;
 ExSearchPanel.Visible := not f_WasFiltered
                      and Assigned(l_BS)
                      and Assigned(l_BS.SearchWindow)
                      and l_BS.SearchWindow.Visible
                      and Assigned(dsDocumentList)
                      and (dsDocumentList.OpenFrom = lofBaseSearch)
                      and not dsDocumentList.IsChanged
                      and defDataAdapter.NativeAdapter.MakeDecisionsArchiveSupport.SearchServerAvailable;
//#UC END# *56F412F403C7_497DDB2B001B_impl*
end;//TPrimListForm.CheckExSearchPanelVisibility

function TPrimListForm.HasCurrent: Boolean;
//#UC START# *4AF846E90103_497DDB2B001B_var*
//#UC END# *4AF846E90103_497DDB2B001B_var*
begin
//#UC START# *4AF846E90103_497DDB2B001B_impl*
 Result := (tvList.TreeView.Current >= 0);
//#UC END# *4AF846E90103_497DDB2B001B_impl*
end;//TPrimListForm.HasCurrent

procedure TPrimListForm.OpenDocument(const aDoc: IdeDocInfo;
 const aCont: IvcmContainer;
 aNeedReturnFocus: Boolean);
//#UC START# *4B0A69100289_497DDB2B001B_var*

 function lp_IndexInParent: Integer;
 var
  l_Root : Il3SimpleNode;
  l_Node : Il3SimpleNode;
  l_Temp : Il3SimpleNode;
 begin
  l_Node := tvList.GetCurrentNode;
  try
   if Assigned(l_Node) and
     Supports(tvList.TreeStruct.RootNode, Il3SimpleNode, l_Root) then
    while Assigned(l_Node) and not l_Root.IsSame(l_Node.Parent) do
    begin
     l_Temp := l_Node.Parent;
     l_Node := l_Temp;
    end;
   if Assigned(l_Node) then
    Result := Succ(l_Node.IndexInParent)
   else
   begin
    Result := 0;
    Assert(False);
   end;//Assigned(l_Node)
  finally
   l_Node := nil;
  end;//try..finally
 end;//lp_IndexInParent

 procedure lp_MakeCurrentInfo(var aRelevance, aNumber, aSubBlock, aPara: Integer);
 var
  l_ListEntry: IListEntryInfo;
 begin//lp_MakeCurrentInfo
  l_ListEntry := bsListEntryInfo(tvList.GetCurrentNode);
  if l_ListEntry <> nil then
  try
   aRelevance := l_ListEntry.GetRelevance;
   aNumber := lp_IndexInParent;
   aSubBlock := -1;
   aPara := -1;
   case l_ListEntry.GetType of
    PT_SUB: aSubBlock := l_ListEntry.GetPosition;
    PT_PARA: aPara := l_ListEntry.GetPosition;
   end;                                       
  finally
   l_ListEntry := nil;
  end;//try..finally
 end;//lp_MakeCurrentInfo

 procedure lp_RegisterEvent;
 var
  l_Relevance: Integer;
  l_Number: Integer;
  l_SubBlock,
  l_Para: Integer;
 begin//lp_RegisterEvent
  if not (aDoc.Doc.GetDocType in [DT_AUTO_REFERAT]) then
  begin
   lp_MakeCurrentInfo(l_Relevance, l_Number, l_SubBlock, l_Para);
    // - информация о текущем.
   TnscDocumentHistory.Instance.AddDocument(aDoc.Doc.GetInternalId);
   if aDoc.Doc.GetDocType in [DT_DOCUMENT,
                              DT_FLASH,
                              DT_ACTUAL_ANALYTICS,
                              DT_ACTUAL_ANALYTICS_CONTENTS] then
    TnsOpenDocumentFromListEvent.Log(aDoc.Doc, l_Number, l_Relevance, l_SubBlock, l_Para);
  end;
 end;//lp_RegisterEvent

//#UC END# *4B0A69100289_497DDB2B001B_var*
begin
//#UC START# *4B0A69100289_497DDB2B001B_impl*
 ForceUpdateClassForHistory;
 lp_RegisterEvent;
 // - запишем событие.
 TDocumentService.Instance.OpenDocument(aDoc, aCont);
 // - откроем документ.
 if aNeedReturnFocus then
  if (tvList <> nil) and (not VCMClosing) and tvList.CanFocus then
   tvList.SetFocus;
//#UC END# *4B0A69100289_497DDB2B001B_impl*
end;//TPrimListForm.OpenDocument

procedure TPrimListForm.DeleteSelectionFromList;
//#UC START# *4B0A871E038F_497DDB2B001B_var*
//#UC END# *4B0A871E038F_497DDB2B001B_var*
begin
//#UC START# *4B0A871E038F_497DDB2B001B_impl*
  if (dsList <> nil) and not IsListEmpty and
   Ask(qr_DeleteListSelected) then
  begin
   dsList.DeleteNodes;
   TnsDeleteFromListEvent.Log(dsList.List);
  end;
//#UC END# *4B0A871E038F_497DDB2B001B_impl*
end;//TPrimListForm.DeleteSelectionFromList

procedure TPrimListForm.ClearFilters;
//#UC START# *4B557A1C00D1_497DDB2B001B_var*
//#UC END# *4B557A1C00D1_497DDB2B001B_var*
begin
//#UC START# *4B557A1C00D1_497DDB2B001B_impl*
 op_Filters_DeselectAll.Call(Aggregate);
 op_Filterable_ClearAll.Call(Self.As_IvcmEntityForm);
//#UC END# *4B557A1C00D1_497DDB2B001B_impl*
end;//TPrimListForm.ClearFilters

procedure TPrimListForm.DoSwitchToFullList;
//#UC START# *4B557C640258_497DDB2B001B_var*
//#UC END# *4B557C640258_497DDB2B001B_var*
begin
//#UC START# *4B557C640258_497DDB2B001B_impl*
 if Assigned(dsDocumentList) and dsDocumentList.IsShortList then
  TListService.Instance.OpenList(dsDocumentList.MakeFullList, NativeMainForm);
//#UC END# *4B557C640258_497DDB2B001B_impl*
end;//TPrimListForm.DoSwitchToFullList

procedure TPrimListForm.ListOpsTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4B5580C902B0_497DDB2B001B_var*
//#UC END# *4B5580C902B0_497DDB2B001B_var*
begin
//#UC START# *4B5580C902B0_497DDB2B001B_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(dsList) and
  not IsListEmpty and HasCurrent;
//#UC END# *4B5580C902B0_497DDB2B001B_impl*
end;//TPrimListForm.ListOpsTest

procedure TPrimListForm.LftRespondentsSynchroFormQueryMaximized(aSender: TObject);
 {* Обработчик события lftRespondentsSynchroForm.OnQueryMaximized }
//#UC START# *068F6EC47A8A_497DDB2B001B_var*
//#UC END# *068F6EC47A8A_497DDB2B001B_var*
begin
//#UC START# *068F6EC47A8A_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *068F6EC47A8A_497DDB2B001B_impl*
end;//TPrimListForm.LftRespondentsSynchroFormQueryMaximized

procedure TPrimListForm.LftRToPartQueryOpen(aSender: TObject);
 {* Обработчик события lftRToPart.OnQueryOpen }
//#UC START# *0984ADDC3D53_497DDB2B001B_var*
//#UC END# *0984ADDC3D53_497DDB2B001B_var*
begin
//#UC START# *0984ADDC3D53_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *0984ADDC3D53_497DDB2B001B_impl*
end;//TPrimListForm.LftRToPartQueryOpen

procedure TPrimListForm.LftCorrespondentsSynchroFormQueryOpen(aSender: TObject);
 {* Обработчик события lftCorrespondentsSynchroForm.OnQueryOpen }
//#UC START# *10133243E89D_497DDB2B001B_var*
//#UC END# *10133243E89D_497DDB2B001B_var*
begin
//#UC START# *10133243E89D_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *10133243E89D_497DDB2B001B_impl*
end;//TPrimListForm.LftCorrespondentsSynchroFormQueryOpen

procedure TPrimListForm.LftUserCR2QueryOpen(aSender: TObject);
 {* Обработчик события lftUserCR2.OnQueryOpen }
//#UC START# *1095984F87C1_497DDB2B001B_var*
//#UC END# *1095984F87C1_497DDB2B001B_var*
begin
//#UC START# *1095984F87C1_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *1095984F87C1_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCR2QueryOpen

procedure TPrimListForm.LftSimilarDocumentsQueryOpen(aSender: TObject);
 {* Обработчик события lftSimilarDocuments.OnQueryOpen }
//#UC START# *3D942CB394A8_497DDB2B001B_var*
//#UC END# *3D942CB394A8_497DDB2B001B_var*
begin
//#UC START# *3D942CB394A8_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *3D942CB394A8_497DDB2B001B_impl*
end;//TPrimListForm.LftSimilarDocumentsQueryOpen

procedure TPrimListForm.LftSimilarDocumentsQueryMaximized(aSender: TObject);
 {* Обработчик события lftSimilarDocuments.OnQueryMaximized }
//#UC START# *3E3ACC41CC2A_497DDB2B001B_var*
//#UC END# *3E3ACC41CC2A_497DDB2B001B_var*
begin
//#UC START# *3E3ACC41CC2A_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *3E3ACC41CC2A_497DDB2B001B_impl*
end;//TPrimListForm.LftSimilarDocumentsQueryMaximized

procedure TPrimListForm.Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
 {* Копировать }
//#UC START# *4951284902BD_497DDB2B001Btest_var*
//#UC END# *4951284902BD_497DDB2B001Btest_var*
begin
//#UC START# *4951284902BD_497DDB2B001Btest_impl*
 if (aParams.Control = tvList) then
 begin
  SelectionOpsTest(aParams);
  //nsDisableOperationInTrialMode(aParams);
 end//aParams.Control = tvList
 else
  if not aParams.CallControl then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4951284902BD_497DDB2B001Btest_impl*
end;//TPrimListForm.Edit_Copy_Test

procedure TPrimListForm.Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Копировать }
//#UC START# *4951284902BD_497DDB2B001Bexec_var*
//#UC END# *4951284902BD_497DDB2B001Bexec_var*
begin
//#UC START# *4951284902BD_497DDB2B001Bexec_impl*
 aParams.CallControl;
//#UC END# *4951284902BD_497DDB2B001Bexec_impl*
end;//TPrimListForm.Edit_Copy_Execute

procedure TPrimListForm.Edit_FindContext_Test(const aParams: IvcmTestParamsPrim);
 {* Поиск }
//#UC START# *49512B5D0009_497DDB2B001Btest_var*
//#UC END# *49512B5D0009_497DDB2B001Btest_var*
begin
//#UC START# *49512B5D0009_497DDB2B001Btest_impl*
 ListOpsTest(aParams);
 if (BaseSearchSupportQuery <> nil) and
    not BaseSearchSupportQuery.CanRunBaseSearch then
 begin
  aParams.Op.Flag[vcm_ofEnabled] := False;
  aParams.Op.Flag[vcm_ofVisible] := False;
 end;//BaseSearchSupportQuery <> nil
//#UC END# *49512B5D0009_497DDB2B001Btest_impl*
end;//TPrimListForm.Edit_FindContext_Test

procedure TPrimListForm.Edit_FindContext_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Поиск }
//#UC START# *49512B5D0009_497DDB2B001Bexec_var*
//#UC END# *49512B5D0009_497DDB2B001Bexec_var*
begin
//#UC START# *49512B5D0009_497DDB2B001Bexec_impl*
 TBaseSearchService.Instance.OpenBaseSearch(ns_bsokLocal, nil);
//#UC END# *49512B5D0009_497DDB2B001Bexec_impl*
end;//TPrimListForm.Edit_FindContext_Execute

function TPrimListForm.pm_GetArea: TnsSearchArea;
//#UC START# *49513239027A_497DDB2B001Bget_var*
//#UC END# *49513239027A_497DDB2B001Bget_var*
begin
//#UC START# *49513239027A_497DDB2B001Bget_impl*
 Result := f_SearchArea;
//#UC END# *49513239027A_497DDB2B001Bget_impl*
end;//TPrimListForm.pm_GetArea

procedure TPrimListForm.pm_SetArea(aValue: TnsSearchArea);
//#UC START# *49513239027A_497DDB2B001Bset_var*
//#UC END# *49513239027A_497DDB2B001Bset_var*
begin
//#UC START# *49513239027A_497DDB2B001Bset_impl*
 f_SearchArea := aValue;
//#UC END# *49513239027A_497DDB2B001Bset_impl*
end;//TPrimListForm.pm_SetArea

function TPrimListForm.Kind: TnsBaseSearchKind;
//#UC START# *4951325E03B6_497DDB2B001B_var*
//#UC END# *4951325E03B6_497DDB2B001B_var*
begin
//#UC START# *4951325E03B6_497DDB2B001B_impl*
 Result := ns_bskList;
//#UC END# *4951325E03B6_497DDB2B001B_impl*
end;//TPrimListForm.Kind

function TPrimListForm.Find(const aContext: InsBaseSearchContextProvider;
 const aProcessor: InsBaseSearchResultProcessor): Boolean;
//#UC START# *4951329202AB_497DDB2B001B_var*
//#UC END# *4951329202AB_497DDB2B001B_var*
begin
//#UC START# *4951329202AB_497DDB2B001B_impl*
 Result := False;
//#UC END# *4951329202AB_497DDB2B001B_impl*
end;//TPrimListForm.Find

function TPrimListForm.AllowSearchInTitles: Boolean;
//#UC START# *495132A703DF_497DDB2B001B_var*
//#UC END# *495132A703DF_497DDB2B001B_var*
begin
//#UC START# *495132A703DF_497DDB2B001B_impl*
 Result := True;
//#UC END# *495132A703DF_497DDB2B001B_impl*
end;//TPrimListForm.AllowSearchInTitles

function TPrimListForm.IsLocalSearchArea: Boolean;
//#UC START# *495132B70156_497DDB2B001B_var*
//#UC END# *495132B70156_497DDB2B001B_var*
begin
//#UC START# *495132B70156_497DDB2B001B_impl*
 Result := False;
//#UC END# *495132B70156_497DDB2B001B_impl*
end;//TPrimListForm.IsLocalSearchArea

procedure TPrimListForm.ContextChanged(const aNewContext: Il3CString);
//#UC START# *495132C20005_497DDB2B001B_var*
//#UC END# *495132C20005_497DDB2B001B_var*
begin
//#UC START# *495132C20005_497DDB2B001B_impl*
// Do nothing
//#UC END# *495132C20005_497DDB2B001B_impl*
end;//TPrimListForm.ContextChanged

function TPrimListForm.IsLocalDataReady: Boolean;
//#UC START# *495132CE010F_497DDB2B001B_var*
//#UC END# *495132CE010F_497DDB2B001B_var*
begin
//#UC START# *495132CE010F_497DDB2B001B_impl*
 Result := True;
//#UC END# *495132CE010F_497DDB2B001B_impl*
end;//TPrimListForm.IsLocalDataReady

function TPrimListForm.WindowRequired: Boolean;
//#UC START# *496B4C41023E_497DDB2B001B_var*
//#UC END# *496B4C41023E_497DDB2B001B_var*
begin
//#UC START# *496B4C41023E_497DDB2B001B_impl*
 Result := False;
//#UC END# *496B4C41023E_497DDB2B001B_impl*
end;//TPrimListForm.WindowRequired

function TPrimListForm.WindowCloseable: Boolean;
//#UC START# *496B4C500246_497DDB2B001B_var*
//#UC END# *496B4C500246_497DDB2B001B_var*
begin
//#UC START# *496B4C500246_497DDB2B001B_impl*
 Result := True;
//#UC END# *496B4C500246_497DDB2B001B_impl*
end;//TPrimListForm.WindowCloseable

function TPrimListForm.CanCloseWindow: Boolean;
//#UC START# *496B4CA000B6_497DDB2B001B_var*
//#UC END# *496B4CA000B6_497DDB2B001B_var*
begin
//#UC START# *496B4CA000B6_497DDB2B001B_impl*
 Result := True;
//#UC END# *496B4CA000B6_497DDB2B001B_impl*
end;//TPrimListForm.CanCloseWindow

function TPrimListForm.IsQueryCard: Boolean;
//#UC START# *496B4CD9005F_497DDB2B001B_var*
//#UC END# *496B4CD9005F_497DDB2B001B_var*
begin
//#UC START# *496B4CD9005F_497DDB2B001B_impl*
 Result := False;
//#UC END# *496B4CD9005F_497DDB2B001B_impl*
end;//TPrimListForm.IsQueryCard

function TPrimListForm.TreatSuccessSearchAsManualOpen: Boolean;
//#UC START# *496B4CE30132_497DDB2B001B_var*
//#UC END# *496B4CE30132_497DDB2B001B_var*
begin
//#UC START# *496B4CE30132_497DDB2B001B_impl*
 Result := False;
//#UC END# *496B4CE30132_497DDB2B001B_impl*
end;//TPrimListForm.TreatSuccessSearchAsManualOpen

function TPrimListForm.AutoActivateWindow: Boolean;
//#UC START# *496B4CED0306_497DDB2B001B_var*
//#UC END# *496B4CED0306_497DDB2B001B_var*
begin
//#UC START# *496B4CED0306_497DDB2B001B_impl*
 Result := False;
//#UC END# *496B4CED0306_497DDB2B001B_impl*
end;//TPrimListForm.AutoActivateWindow

procedure TPrimListForm.VisibleChanged(aNewVisible: Boolean);
//#UC START# *496B517202C5_497DDB2B001B_var*
//#UC END# *496B517202C5_497DDB2B001B_var*
begin
//#UC START# *496B517202C5_497DDB2B001B_impl*
 if (f_SearchWindowVisible <> aNewVisible) then
 begin
  f_SearchWindowVisible := aNewVisible;
  tvList.Invalidate;
  //tvList.Perform(msg_vtUpdateScroll, 0, 0);
  //CheckExSearchPanelVisibility;
 end;//f_SearchWindowVisible <> aNewVisible
//#UC END# *496B517202C5_497DDB2B001B_impl*
end;//TPrimListForm.VisibleChanged

procedure TPrimListForm.DoTabActivate;
 {* Реакция на переключение вкладки }
//#UC START# *497F16AC015A_497DDB2B001B_var*

 function lp_Document: IDocument;
 begin
  if (sdsBaseDocument <> nil) then
   Result := sdsBaseDocument.DocInfo.Doc
  else
   Result := nil
 end;//lp_Document

 function lp_DocumentCount: Cardinal;
 begin
  if (dsList <> nil) then
   Result := Cardinal(bsDocCount(dsList.List))
  else
   Result := 0;
 end;//lp_DocumentCount

//#UC END# *497F16AC015A_497DDB2B001B_var*
begin
//#UC START# *497F16AC015A_497DDB2B001B_impl*
 if (CurUserType <> nil) and
    (UserType in [lftSimilarDocuments]) then
  TnsViewSameDocumentsEvent.Log(lp_Document, lp_DocumentCount);
//#UC END# *497F16AC015A_497DDB2B001B_impl*
end;//TPrimListForm.DoTabActivate

procedure TPrimListForm.GotoActualRedaction;
 {* выключить и перейти в актуальную редакцию }
//#UC START# *49805EED0054_497DDB2B001B_var*
//#UC END# *49805EED0054_497DDB2B001B_var*
begin
//#UC START# *49805EED0054_497DDB2B001B_impl*
 DefDataAdapter.TimeMachine.SwitchOff
//#UC END# *49805EED0054_497DDB2B001B_impl*
end;//TPrimListForm.GotoActualRedaction

procedure TPrimListForm.StayInCurrentRedaction;
 {* выключить и остаться в текущей редакции }
//#UC START# *49805EFF013C_497DDB2B001B_var*
//#UC END# *49805EFF013C_497DDB2B001B_var*
begin
//#UC START# *49805EFF013C_497DDB2B001B_impl*
 Assert(False);
//#UC END# *49805EFF013C_497DDB2B001B_impl*
end;//TPrimListForm.StayInCurrentRedaction

procedure TPrimListForm.ChangeDate(aDate: RtlDateTime);
 {* изменить }
//#UC START# *49805F0D0221_497DDB2B001B_var*
//#UC END# *49805F0D0221_497DDB2B001B_var*
begin
//#UC START# *49805F0D0221_497DDB2B001B_impl*
 Assert(False);
//#UC END# *49805F0D0221_497DDB2B001B_impl*
end;//TPrimListForm.ChangeDate

function TPrimListForm.Get_DisableOps: TnsTurnOffTimeMachineOperations;
//#UC START# *49805F190314_497DDB2B001Bget_var*
//#UC END# *49805F190314_497DDB2B001Bget_var*
begin
//#UC START# *49805F190314_497DDB2B001Bget_impl*
 Result := [ns_offtmStayInCurrentRedaction, ns_offtmChangeDate];
  // - в списке доступно только выключение машины времени.
//#UC END# *49805F190314_497DDB2B001Bget_impl*
end;//TPrimListForm.Get_DisableOps

procedure TPrimListForm.File_SaveToFolder_Test(const aParams: IvcmTestParamsPrim);
 {* Сохранить в папки }
//#UC START# *49885D540232_497DDB2B001Btest_var*
//#UC END# *49885D540232_497DDB2B001Btest_var*
begin
//#UC START# *49885D540232_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not IsListEmpty;
 if aParams.Op.Flag[vcm_ofEnabled] then
 begin
  aParams.Op.Flag[vcm_ofEnabled] := True;
  with aParams.Op.SubItems do
  begin
   Clear;
   ResetSaveToFolderOperations;
   if (dsList <> nil) and dsList.IsSaved then
    g_OverrideList := Succ(Add(vcmCStr(str_ListSaveOverride)));
   if (dsList <> nil) and dsList.IsSaved or HasSelected then
    g_SaveToFolders := Succ(Add(vcmCStr(str_ListSaveAs)));
   if HasSelected then
    g_SaveToFoldersSelected := Succ(Add(vcmCStr(str_ListSaveSelectedDocuments)));
   // Действие по умолчанию Сохранить в мои документы
   if Count = 0 then
    g_SaveToFolders := 0;
  end;//with aParams.Op.SubItems do
 end;//if aParams.Op.Flag[vcm_ofEnabled] then
//#UC END# *49885D540232_497DDB2B001Btest_impl*
end;//TPrimListForm.File_SaveToFolder_Test

procedure TPrimListForm.File_SaveToFolder_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Сохранить в папки }
//#UC START# *49885D540232_497DDB2B001Bexec_var*
//#UC END# *49885D540232_497DDB2B001Bexec_var*
begin
//#UC START# *49885D540232_497DDB2B001Bexec_impl*
 // Сохраняем в папки весь список если нажали на кнопку или вызвали по
 // ShortCut-у или выполняем операцию выбранную в контекстном меню кнопки
 SaveToFolders(IfThen(aParams.ItemIndex <= 0,
                      IfThen(tvList.TreeView.Tree.SelectedCount > 1,
                             g_SaveToFoldersSelected,
                             g_SaveToFolders),
                      aParams.ItemIndex));
//#UC END# *49885D540232_497DDB2B001Bexec_impl*
end;//TPrimListForm.File_SaveToFolder_Execute

procedure TPrimListForm.File_LoadFromFolder_Test(const aParams: IvcmTestParamsPrim);
 {* Загрузить из папок }
//#UC START# *49885D59018D_497DDB2B001Btest_var*
//#UC END# *49885D59018D_497DDB2B001Btest_var*
begin
//#UC START# *49885D59018D_497DDB2B001Btest_impl*
 // - ничего не делаем
//#UC END# *49885D59018D_497DDB2B001Btest_impl*
end;//TPrimListForm.File_LoadFromFolder_Test

procedure TPrimListForm.File_LoadFromFolder_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Загрузить из папок }
//#UC START# *49885D59018D_497DDB2B001Bexec_var*
//#UC END# *49885D59018D_497DDB2B001Bexec_var*
begin
//#UC START# *49885D59018D_497DDB2B001Bexec_impl*
 // Выбор закладок
 TFoldersService.Instance.SelectOpen(Self.As_IvcmEntityForm,
                      MakeFilterInfo(ffList),
                      str_ListOpen);
//#UC END# *49885D59018D_497DDB2B001Bexec_impl*
end;//TPrimListForm.File_LoadFromFolder_Execute

procedure TPrimListForm.Document_AddToControl_Test(const aParams: IvcmTestParamsPrim);
 {* Поставить на контроль }
//#UC START# *498863B203D0_497DDB2B001Btest_var*
//#UC END# *498863B203D0_497DDB2B001Btest_var*
begin
//#UC START# *498863B203D0_497DDB2B001Btest_impl*
 if HasCurrent and f_AllowCallCurrentChangedOnTest then
  CallCurrentChanged;
 aParams.Op.Flag[vcm_ofEnabled] := HasCurrent
                               and Assigned(dsDocumentList)
                               and not dsDocumentList.IsListEmpty
                               and dsDocumentList.CanAddToControl;
//#UC END# *498863B203D0_497DDB2B001Btest_impl*
end;//TPrimListForm.Document_AddToControl_Test

procedure TPrimListForm.Document_AddToControl_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Поставить на контроль }
//#UC START# *498863B203D0_497DDB2B001Bexec_var*
//#UC END# *498863B203D0_497DDB2B001Bexec_var*
begin
//#UC START# *498863B203D0_497DDB2B001Bexec_impl*
 AddSelectedToControl(True);
//#UC END# *498863B203D0_497DDB2B001Bexec_impl*
end;//TPrimListForm.Document_AddToControl_Execute

procedure TPrimListForm.Document_AddToControl_GetState(var State: TvcmOperationStateIndex);
 {* Поставить на контроль }
//#UC START# *498863B203D0_497DDB2B001Bgetstate_var*
//#UC END# *498863B203D0_497DDB2B001Bgetstate_var*
begin
//#UC START# *498863B203D0_497DDB2B001Bgetstate_impl*
 if HasCurrent and OnlyOneSelected and Assigned(dsDocumentList) and dsDocumentList.IsUnderControl then
  State := st_user_Document_AddToControl_RemoveFromControl
 else
  State := vcm_DefaultOperationState;
//#UC END# *498863B203D0_497DDB2B001Bgetstate_impl*
end;//TPrimListForm.Document_AddToControl_GetState

procedure TPrimListForm.Document_GetAttributesFrmAct_Test(const aParams: IvcmTestParamsPrim);
 {* Информация о документе }
//#UC START# *498891640253_497DDB2B001Btest_var*
//#UC END# *498891640253_497DDB2B001Btest_var*
begin
//#UC START# *498891640253_497DDB2B001Btest_impl*
 with tvList.TreeView do
  aParams.Op.Flag[vcm_ofEnabled] := afw.Application.IsInternal and
                                    NoMoreThanOneSelected and
                                    HasCurrent and
                                    Assigned(dsList) and
                                    dsList.HasAttributes;
//#UC END# *498891640253_497DDB2B001Btest_impl*
end;//TPrimListForm.Document_GetAttributesFrmAct_Test

procedure TPrimListForm.Document_GetAttributesFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Информация о документе }
//#UC START# *498891640253_497DDB2B001Bexec_var*
//#UC END# *498891640253_497DDB2B001Bexec_var*
begin
//#UC START# *498891640253_497DDB2B001Bexec_impl*
 Op_SynchroView_BecomeActive.Call(Aggregate, ssfAttribute);
//#UC END# *498891640253_497DDB2B001Bexec_impl*
end;//TPrimListForm.Document_GetAttributesFrmAct_Execute

function TPrimListForm.Loadable_Load_Execute(const aNode: IeeNode;
 const aData: IUnknown;
 anOp: TListLogicOperation = LLO_NONE): Boolean;
 {* Коллеги, кто может описать этот метод? }
//#UC START# *49895A2102E8_497DDB2B001Bexec_var*

var
 l_List   : IDynList;

 function lp_OpenList: Boolean;
 begin
  Result := (anOp = LLO_NONE);
  if Result then
  begin
    Assert(Assigned(l_List));
    nsOpenList(l_List, NativeMainForm);
  end//Result
 end;

 procedure lp_ApplyLogicOperation;
 begin
  if Assigned(dsList) then
   try
    // Неверный тип списка:
    if dsList.List.GetContentType <> l_List.GetContentType then
    begin
     Say(inf_UncompatibleObjectType);
     Loadable_Load_Execute := false;
     Exit;
    end;//if dsList.List.GetContentType <> l_List.GetContentType then
    // Выполним логическую операцию
    if dsList.ApplyLogicOperation(l_List, anOp) then
    begin
     if dsList.AllDocumentFiltered then
      ShowEditorOrList(nil)
     // Обновим дерево:
     else
      with tvList do
      begin
       Changing;
       try
        TreeStruct := dsList.SimpleTree;
       finally
        Changed;
       end;//try..finally
      end;//with tvList do
    end;//dsList.ApplyLogicOperation
   except
    on EEmptyResult do
    begin
     Say(war_EmptyList);
     Loadable_Load_Execute := false;
    end;//on EEmptyResult do
   end//except
  else
   Assert(false, 'Непонятно, что хотели от этой операции');
 end;

var
 l_FolderNode : INode;
 l_Object : IUnknown;
//#UC END# *49895A2102E8_497DDB2B001Bexec_var*
begin
//#UC START# *49895A2102E8_497DDB2B001Bexec_impl*
 Result := true;
 if Supports(aNode, INode, l_FolderNode) then
 try
  try
   l_FolderNode.Open(l_Object);
   try
    Supports(l_Object, IDynList, l_List);
    try
     if not lp_OpenList then
      lp_ApplyLogicOperation;
    finally
     l_List := nil;
    end;//try..finally
   finally
    l_Object := nil;
   end;//try..finally
  except
   on ECanNotFindData do
   begin
    nsSayAdapterObjectMissing(Self, l_FolderNode);
    Result := false;
   end;//on ECanNotFindData do
  end;//try..except
 finally
  l_FolderNode := nil;
 end;//try..finally
//#UC END# *49895A2102E8_497DDB2B001Bexec_impl*
end;//TPrimListForm.Loadable_Load_Execute

procedure TPrimListForm.Loadable_Load(const aParams: IvcmExecuteParams);
 {* Коллеги, кто может описать этот метод? }
begin
 with ILoadable_Load_Params(aParams.Data) do
  ResultValue := Self.Loadable_Load_Execute(Node, Data, nOp);
end;//TPrimListForm.Loadable_Load

procedure TPrimListForm.Document_GetRelatedDocFrmAct_Test(const aParams: IvcmTestParamsPrim);
 {* Справка к документу }
//#UC START# *498993C801DC_497DDB2B001Btest_var*
//#UC END# *498993C801DC_497DDB2B001Btest_var*
begin
//#UC START# *498993C801DC_497DDB2B001Btest_impl*
 with tvList.TreeView do
  aParams.Op.Flag[vcm_ofEnabled] := NoMoreThanOneSelected and HasCurrent and
   Assigned(dsDocumentList) and dsDocumentList.HasRelatedDoc;
//#UC END# *498993C801DC_497DDB2B001Btest_impl*
end;//TPrimListForm.Document_GetRelatedDocFrmAct_Test

procedure TPrimListForm.Document_GetRelatedDocFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Справка к документу }
//#UC START# *498993C801DC_497DDB2B001Bexec_var*
//#UC END# *498993C801DC_497DDB2B001Bexec_var*
begin
//#UC START# *498993C801DC_497DDB2B001Bexec_impl*
 Op_SynchroView_BecomeActive.Call(Aggregate, ssfRelated);
//#UC END# *498993C801DC_497DDB2B001Bexec_impl*
end;//TPrimListForm.Document_GetRelatedDocFrmAct_Execute

procedure TPrimListForm.Edit_Undo_Test(const aParams: IvcmTestParamsPrim);
 {* Отмена }
//#UC START# *49EDFCA2006D_497DDB2B001Btest_var*
//#UC END# *49EDFCA2006D_497DDB2B001Btest_var*
begin
//#UC START# *49EDFCA2006D_497DDB2B001Btest_impl*
 if aParams.Control = tvList then
  aParams.Op.Flag[vcm_ofEnabled] := false
 else
 if not aParams.CallControl then
  aParams.Op.Flag[vcm_ofEnabled] := false;
//#UC END# *49EDFCA2006D_497DDB2B001Btest_impl*
end;//TPrimListForm.Edit_Undo_Test

procedure TPrimListForm.Edit_Undo_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *49EDFCA2006D_497DDB2B001Bexec_var*
//#UC END# *49EDFCA2006D_497DDB2B001Bexec_var*
begin
//#UC START# *49EDFCA2006D_497DDB2B001Bexec_impl*
 aParams.CallControl;
//#UC END# *49EDFCA2006D_497DDB2B001Bexec_impl*
end;//TPrimListForm.Edit_Undo_Execute

procedure TPrimListForm.Edit_Redo_Test(const aParams: IvcmTestParamsPrim);
 {* Возврат }
//#UC START# *49EDFCB100BC_497DDB2B001Btest_var*
//#UC END# *49EDFCB100BC_497DDB2B001Btest_var*
begin
//#UC START# *49EDFCB100BC_497DDB2B001Btest_impl*
 if aParams.Control = tvList then
  aParams.Op.Flag[vcm_ofEnabled] := false
 else
 if not aParams.CallControl then
  aParams.Op.Flag[vcm_ofEnabled] := false;
//#UC END# *49EDFCB100BC_497DDB2B001Btest_impl*
end;//TPrimListForm.Edit_Redo_Test

procedure TPrimListForm.Edit_Redo_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Возврат }
//#UC START# *49EDFCB100BC_497DDB2B001Bexec_var*
//#UC END# *49EDFCB100BC_497DDB2B001Bexec_var*
begin
//#UC START# *49EDFCB100BC_497DDB2B001Bexec_impl*
 aParams.CallControl;
//#UC END# *49EDFCB100BC_497DDB2B001Bexec_impl*
end;//TPrimListForm.Edit_Redo_Execute

procedure TPrimListForm.Edit_Deselect_Test(const aParams: IvcmTestParamsPrim);
 {* Снять выделение }
//#UC START# *49EE01BC022E_497DDB2B001Btest_var*
//#UC END# *49EE01BC022E_497DDB2B001Btest_var*
begin
//#UC START# *49EE01BC022E_497DDB2B001Btest_impl*
 if aParams.Control = tvList then
  aParams.Op.Flag[vcm_ofEnabled] := tvList.TreeView.Tree.SelectedCount > 1
 else
  if not aParams.CallControl then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *49EE01BC022E_497DDB2B001Btest_impl*
end;//TPrimListForm.Edit_Deselect_Test

procedure TPrimListForm.Edit_Deselect_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Снять выделение }
//#UC START# *49EE01BC022E_497DDB2B001Bexec_var*
//#UC END# *49EE01BC022E_497DDB2B001Bexec_var*
begin
//#UC START# *49EE01BC022E_497DDB2B001Bexec_impl*
 if (aParams.Control = tvList) then
 begin
  with tvList, tvList.TreeView do
  begin
   TreeStruct.Changing;
   try
    vlbDeselectAllItems;
    Tree.SetFlagMask(CurrentNode, nfSelected, ee_sbSelect);
   finally
    TreeStruct.Changed{Ex(l3_NotChangeCountView)};
   end;//try..finally
  end;//with tvList, tvList.TreeView
  StatusParamsShow;
 end//aParams.Control = tvList
 else
  aParams.CallControl;
//#UC END# *49EE01BC022E_497DDB2B001Bexec_impl*
end;//TPrimListForm.Edit_Deselect_Execute

function TPrimListForm.FindBack(const aContext: InsBaseSearchContextProvider;
 const aProcessor: InsBaseSearchResultProcessor): Boolean;
 {* Искать назад }
//#UC START# *49FEA325027E_497DDB2B001B_var*
//#UC END# *49FEA325027E_497DDB2B001B_var*
begin
//#UC START# *49FEA325027E_497DDB2B001B_impl*
 Result := False;
//#UC END# *49FEA325027E_497DDB2B001B_impl*
end;//TPrimListForm.FindBack

function TPrimListForm.FindBackSupported: Boolean;
//#UC START# *49FEB37C02FB_497DDB2B001B_var*
//#UC END# *49FEB37C02FB_497DDB2B001B_var*
begin
//#UC START# *49FEB37C02FB_497DDB2B001B_impl*
 Result := False;
//#UC END# *49FEB37C02FB_497DDB2B001B_impl*
end;//TPrimListForm.FindBackSupported

function TPrimListForm.FindBackEnabled: Boolean;
//#UC START# *49FEB3960023_497DDB2B001B_var*
//#UC END# *49FEB3960023_497DDB2B001B_var*
begin
//#UC START# *49FEB3960023_497DDB2B001B_impl*
 Result := False;
//#UC END# *49FEB3960023_497DDB2B001B_impl*
end;//TPrimListForm.FindBackEnabled

function TPrimListForm.FragmentsCountSuffix: Il3CString;
//#UC START# *49FFD8230333_497DDB2B001B_var*
//#UC END# *49FFD8230333_497DDB2B001B_var*
begin
//#UC START# *49FFD8230333_497DDB2B001B_impl*
 Result := nil;
//#UC END# *49FFD8230333_497DDB2B001B_impl*
end;//TPrimListForm.FragmentsCountSuffix

{$If NOT Defined(DesignTimeLibrary)}
procedure TPrimListForm.DoStyleTableChanged;
//#UC START# *4A485B710126_497DDB2B001B_var*
//#UC END# *4A485B710126_497DDB2B001B_var*
begin
//#UC START# *4A485B710126_497DDB2B001B_impl*
 IafwStyleTableSpy(ExSearchLabel).StyleTableChanged;

 with ExSearchLabel do
 begin
  Left := ExSearchPanel.ClientWidth - 15 - Width;
  ExSearchPanel.Height := Height + 5;
 end;
//#UC END# *4A485B710126_497DDB2B001B_impl*
end;//TPrimListForm.DoStyleTableChanged
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TPrimListForm.FillList(const aList: InscStatusBarItemDefsList);
 {* Заполняет список операций. Для перекрытия в потомках }
//#UC START# *4A8E5E4702C6_497DDB2B001B_var*
//#UC END# *4A8E5E4702C6_497DDB2B001B_var*
begin
//#UC START# *4A8E5E4702C6_497DDB2B001B_impl*
 with aList do
 begin
  (*
  Add(TnscStatusBarOperationDef.MakeS(opcode_Selection_Analize, True));
  *)
  // http://mdp.garant.ru/pages/viewpage.action?pageId=274825697&focusedCommentId=276540205#comment-276540205
 end;//with aList
//#UC END# *4A8E5E4702C6_497DDB2B001B_impl*
end;//TPrimListForm.FillList

function TPrimListForm.AllowPrompts: Boolean;
//#UC START# *4AA4E63900F9_497DDB2B001B_var*
//#UC END# *4AA4E63900F9_497DDB2B001B_var*
begin
//#UC START# *4AA4E63900F9_497DDB2B001B_impl*
 Result := f_SearchArea = ns_saEveryWere;
//#UC END# *4AA4E63900F9_497DDB2B001B_impl*
end;//TPrimListForm.AllowPrompts

function TPrimListForm.PromptsInfo: LongWord;
//#UC START# *4AA4E64E0395_497DDB2B001B_var*
//#UC END# *4AA4E64E0395_497DDB2B001B_var*
begin
//#UC START# *4AA4E64E0395_497DDB2B001B_impl*
 Result := 0;
//#UC END# *4AA4E64E0395_497DDB2B001B_impl*
end;//TPrimListForm.PromptsInfo

function TPrimListForm.SupportDisabled: Boolean;
//#UC START# *4ACA17770179_497DDB2B001B_var*
//#UC END# *4ACA17770179_497DDB2B001B_var*
begin
//#UC START# *4ACA17770179_497DDB2B001B_impl*
 Result := UserType in [lftDrugList,
                        lftDrugInternationalNameSynonyms,
                        lftProducedDrugs,
                        lftProducedDrugsSynchroForm];
//#UC END# *4ACA17770179_497DDB2B001B_impl*
end;//TPrimListForm.SupportDisabled

function TPrimListForm.Get_ContainerForBaseSearch: TnsContainerForBaseSearchInfo;
//#UC START# *4ACA195801CB_497DDB2B001Bget_var*
//#UC END# *4ACA195801CB_497DDB2B001Bget_var*
begin
//#UC START# *4ACA195801CB_497DDB2B001Bget_impl*
 Result.rContainer := nil;
 Result.rZone := vcm_ztAny;
//#UC END# *4ACA195801CB_497DDB2B001Bget_impl*
end;//TPrimListForm.Get_ContainerForBaseSearch

function TPrimListForm.Get_VisibleWatcher: InsBaseSearchVisibleWatcher;
//#UC START# *4AD608860210_497DDB2B001Bget_var*
//#UC END# *4AD608860210_497DDB2B001Bget_var*
begin
//#UC START# *4AD608860210_497DDB2B001Bget_impl*
 Result := Self;
//#UC END# *4AD608860210_497DDB2B001Bget_impl*
end;//TPrimListForm.Get_VisibleWatcher

function TPrimListForm.Get_ContextSearcher: InsContextSearcher;
//#UC START# *4AD6EAA3034A_497DDB2B001Bget_var*
//#UC END# *4AD6EAA3034A_497DDB2B001Bget_var*
begin
//#UC START# *4AD6EAA3034A_497DDB2B001Bget_impl*
 Result := Self;
//#UC END# *4AD6EAA3034A_497DDB2B001Bget_impl*
end;//TPrimListForm.Get_ContextSearcher

procedure TPrimListForm.LftUserCRList2SynchorFormQueryOpen(aSender: TObject);
 {* Обработчик события lftUserCRList2_SynchorForm.OnQueryOpen }
//#UC START# *4AE19D392515_497DDB2B001B_var*
//#UC END# *4AE19D392515_497DDB2B001B_var*
begin
//#UC START# *4AE19D392515_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *4AE19D392515_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCRList2SynchorFormQueryOpen

function TPrimListForm.Filterable_Add_Execute(const aFilter: IFilterFromQuery): Boolean;
//#UC START# *4AEF0BF70306_497DDB2B001Bexec_var*
//#UC END# *4AEF0BF70306_497DDB2B001Bexec_var*
begin
//#UC START# *4AEF0BF70306_497DDB2B001Bexec_impl*
 Result := ApplyFilter(aFilter, true)
//#UC END# *4AEF0BF70306_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filterable_Add_Execute

procedure TPrimListForm.Filterable_Add(const aParams: IvcmExecuteParams);
begin
 with IFilterable_Add_Params(aParams.Data) do
  ResultValue := Self.Filterable_Add_Execute(Filter);
end;//TPrimListForm.Filterable_Add

function TPrimListForm.Filterable_Delete_Execute(const aFilter: IFilterFromQuery): Boolean;
//#UC START# *4AEF0D1A01C3_497DDB2B001Bexec_var*
//#UC END# *4AEF0D1A01C3_497DDB2B001Bexec_var*
begin
//#UC START# *4AEF0D1A01C3_497DDB2B001Bexec_impl*
 Result := (dsList <> nil) AND ApplyFilter(aFilter, false)
//#UC END# *4AEF0D1A01C3_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filterable_Delete_Execute

procedure TPrimListForm.Filterable_Delete(const aParams: IvcmExecuteParams);
begin
 with IFilterable_Delete_Params(aParams.Data) do
  ResultValue := Self.Filterable_Delete_Execute(Filter);
end;//TPrimListForm.Filterable_Delete

function TPrimListForm.List_GetDeList_Execute: IdeList;
//#UC START# *4AEF28330397_497DDB2B001Bexec_var*
//#UC END# *4AEF28330397_497DDB2B001Bexec_var*
begin
//#UC START# *4AEF28330397_497DDB2B001Bexec_impl*
 if not Assigned(dsList) then
  Result := nil
 else
 if not IsListEmpty then
  Result := TdeList.Make(dsList.List)
 else
  Result := nil;
//#UC END# *4AEF28330397_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_GetDeList_Execute

procedure TPrimListForm.List_GetDeList(const aParams: IvcmExecuteParams);
begin
 with IList_GetDeList_Params(aParams.Data) do
  ResultValue := Self.List_GetDeList_Execute;
end;//TPrimListForm.List_GetDeList

procedure TPrimListForm.Filterable_ClearAll_Execute;
//#UC START# *4AF80DB80383_497DDB2B001Bexec_var*
var
 l_AllDocumentFiltered: Boolean;
//#UC END# *4AF80DB80383_497DDB2B001Bexec_var*
begin
//#UC START# *4AF80DB80383_497DDB2B001Bexec_impl*
 if dsList <> nil then
 begin
  l_AllDocumentFiltered := dsList.AllDocumentFiltered;
  if dsList.ClearFilters then
  begin
   // Если все документы были отфильтрованны, то нужно показать дерево:
   if l_AllDocumentFiltered then
    ShowEditorOrList(nil);
   tvList.TreeStruct := nil;
   tvList.TreeStruct;   //mdp.garant.ru/pages/viewpage.action?pageId=627386747
  end;//if dsList.ClearFilters then
 end;//if dsList <> nil then
//#UC END# *4AF80DB80383_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filterable_ClearAll_Execute

procedure TPrimListForm.Filterable_ClearAll(const aParams: IvcmExecuteParams);
begin
 Self.Filterable_ClearAll_Execute;
end;//TPrimListForm.Filterable_ClearAll

function TPrimListForm.Filterable_Refresh_Execute: Boolean;
//#UC START# *4AF810230307_497DDB2B001Bexec_var*
//#UC END# *4AF810230307_497DDB2B001Bexec_var*
begin
//#UC START# *4AF810230307_497DDB2B001Bexec_impl*
 Result := true;
 if Assigned(dsList) and dsList.RefreshFilters then
  tvList.TreeStruct := nil
 else
  Result := false;
//#UC END# *4AF810230307_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filterable_Refresh_Execute

procedure TPrimListForm.Filterable_Refresh(const aParams: IvcmExecuteParams);
begin
 with IFilterable_Refresh_Params(aParams.Data) do
  ResultValue := Self.Filterable_Refresh_Execute;
end;//TPrimListForm.Filterable_Refresh

procedure TPrimListForm.TimeMachine_TimeMachineOffAndReset_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AF83BEB0393_497DDB2B001Btest_var*
//#UC END# *4AF83BEB0393_497DDB2B001Btest_var*
begin
//#UC START# *4AF83BEB0393_497DDB2B001Btest_impl*
 with aParams do
 begin
  Op.Flag[vcm_ofEnabled] := Assigned(dsDocumentList) and dsDocumentList.IsTimeMachineEnable and
   defDataAdapter.TimeMachine.IsOn;
  if Op.Flag[vcm_ofEnabled] then
   Op.Flag[vcm_ofChecked] := defDataAdapter.TimeMachine.IsOn;
 end;//with aParams do
//#UC END# *4AF83BEB0393_497DDB2B001Btest_impl*
end;//TPrimListForm.TimeMachine_TimeMachineOffAndReset_Test

procedure TPrimListForm.TimeMachine_TimeMachineOffAndReset_Execute;
//#UC START# *4AF83BEB0393_497DDB2B001Bexec_var*
//#UC END# *4AF83BEB0393_497DDB2B001Bexec_var*
begin
//#UC START# *4AF83BEB0393_497DDB2B001Bexec_impl*
 defDataAdapter.TimeMachine.SwitchOff;
//#UC END# *4AF83BEB0393_497DDB2B001Bexec_impl*
end;//TPrimListForm.TimeMachine_TimeMachineOffAndReset_Execute

procedure TPrimListForm.TimeMachine_TimeMachineOffAndReset(const aParams: IvcmExecuteParams);
begin
 Self.TimeMachine_TimeMachineOffAndReset_Execute;
end;//TPrimListForm.TimeMachine_TimeMachineOffAndReset

procedure TPrimListForm.List_SetCurrentVisible_Execute;
//#UC START# *4AF84789038B_497DDB2B001Bexec_var*
//#UC END# *4AF84789038B_497DDB2B001Bexec_var*
begin
//#UC START# *4AF84789038B_497DDB2B001Bexec_impl*
 if HasCurrent then
  with tvList, TreeView do
   vlbMakeItemVisible(Current);
//#UC END# *4AF84789038B_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_SetCurrentVisible_Execute

procedure TPrimListForm.List_SetCurrentVisible(const aParams: IvcmExecuteParams);
begin
 Self.List_SetCurrentVisible_Execute;
end;//TPrimListForm.List_SetCurrentVisible

procedure TPrimListForm.TimeMachine_TimeMachineOnOffNew_Test(const aParams: IvcmTestParamsPrim);
 {* Включить Машину времени }
//#UC START# *4B261EC80086_497DDB2B001Btest_var*
//#UC END# *4B261EC80086_497DDB2B001Btest_var*
begin
//#UC START# *4B261EC80086_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(dsList) and
  dsList.IsTimeMachineEnable and DefDataAdapter.TimeMachine.IsOn;
//#UC END# *4B261EC80086_497DDB2B001Btest_impl*
end;//TPrimListForm.TimeMachine_TimeMachineOnOffNew_Test

procedure TPrimListForm.TimeMachine_TimeMachineOnOffNew_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Включить Машину времени }
//#UC START# *4B261EC80086_497DDB2B001Bexec_var*
//#UC END# *4B261EC80086_497DDB2B001Bexec_var*
begin
//#UC START# *4B261EC80086_497DDB2B001Bexec_impl*
 TCommonService.Instance.OpenTurnOffTimeMachine(InsTurnOffTimeMachine(Self));
//#UC END# *4B261EC80086_497DDB2B001Bexec_impl*
end;//TPrimListForm.TimeMachine_TimeMachineOnOffNew_Execute

procedure TPrimListForm.TimeMachine_TimeMachineOnOffNew_GetState(var State: TvcmOperationStateIndex);
 {* Включить Машину времени }
//#UC START# *4B261EC80086_497DDB2B001Bgetstate_var*
//#UC END# *4B261EC80086_497DDB2B001Bgetstate_var*
begin
//#UC START# *4B261EC80086_497DDB2B001Bgetstate_impl*
 if not defDataAdapter.TimeMachine.IsOn then
  State := st_user_TimeMachine_TimeMachineOnOffNew_MachineOn
 else
  State := st_user_TimeMachine_TimeMachineOnOffNew_MachineOff;
//#UC END# *4B261EC80086_497DDB2B001Bgetstate_impl*
end;//TPrimListForm.TimeMachine_TimeMachineOnOffNew_GetState

function TPrimListForm.SwitchToTextIfPossible: Boolean;
//#UC START# *4B263ADE02E0_497DDB2B001B_var*
//#UC END# *4B263ADE02E0_497DDB2B001B_var*
begin
//#UC START# *4B263ADE02E0_497DDB2B001B_impl*
 Result := False;
//#UC END# *4B263ADE02E0_497DDB2B001B_impl*
end;//TPrimListForm.SwitchToTextIfPossible

procedure TPrimListForm.List_SwitchToFullList_Test(const aParams: IvcmTestParamsPrim);
 {* Построить полный список }
//#UC START# *4B556F56016B_497DDB2B001Btest_var*
//#UC END# *4B556F56016B_497DDB2B001Btest_var*
begin
//#UC START# *4B556F56016B_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CanSwithToFullList;
 aParams.Op.Flag[vcm_ofVisible] := CanSwithToFullList;
//#UC END# *4B556F56016B_497DDB2B001Btest_impl*
end;//TPrimListForm.List_SwitchToFullList_Test

procedure TPrimListForm.List_SwitchToFullList_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Построить полный список }
//#UC START# *4B556F56016B_497DDB2B001Bexec_var*
//#UC END# *4B556F56016B_497DDB2B001Bexec_var*
begin
//#UC START# *4B556F56016B_497DDB2B001Bexec_impl*
 DoSwitchToFullList;
//#UC END# *4B556F56016B_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_SwitchToFullList_Execute

procedure TPrimListForm.List_ListInfo_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3716AC02AC_497DDB2B001Btest_var*
//#UC END# *4C3716AC02AC_497DDB2B001Btest_var*
begin
//#UC START# *4C3716AC02AC_497DDB2B001Btest_impl*
// aParams.Op.Flag[vcm_ofVisible] := (aParams.Control <> tvList);
 aParams.Op.Flag[vcm_ofEnabled] := (dsList <> nil) and
  not IsListEmpty and (dsList.IsMain);
//#UC END# *4C3716AC02AC_497DDB2B001Btest_impl*
end;//TPrimListForm.List_ListInfo_Test

procedure TPrimListForm.List_ListInfo_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3716AC02AC_497DDB2B001Bexec_var*
//#UC END# *4C3716AC02AC_497DDB2B001Bexec_var*
begin
//#UC START# *4C3716AC02AC_497DDB2B001Bexec_impl*
 op_ListInfo_BecomeActive.Call(Aggregate);
//#UC END# *4C3716AC02AC_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_ListInfo_Execute

procedure TPrimListForm.List_Sort_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3716C50005_497DDB2B001Btest_var*
var
 l_Strings: IvcmStrings;
 l_StringSource: InsStringsSource;
 l_Res: Boolean;
//#UC END# *4C3716C50005_497DDB2B001Btest_var*
begin
//#UC START# *4C3716C50005_497DDB2B001Btest_impl*
// aParams.Op.Flag[vcm_ofVisible] := (aParams.Control <> tvList);
 // http://mdp.garant.ru/pages/viewpage.action?pageId=476813620
 if (tvList.TreeView.Current < 0) or ((dsDocumentList = nil) or
  (dsDocumentList.IsListEmpty)) or
   ((aParams.Control = nil) {or (aParams.Control = tvList)}) then
   aParams.Op.Flag[vcm_ofEnabled] := False
 else
 begin
  if Assigned(dsDocumentList) then
  begin
   aParams.Op.Flag[vcm_ofEnabled] := True;
   l_Res := CheckValidSortTypes(dsDocumentList.ValidSortTypes);
   l_Strings := aParams.Op.SubItems;
   try
    if (l_Strings <> nil) and
       (l_Res or (l_Strings.Count = 0) or (l_Strings.Count <> f_SortTypeMap.MapSize)) and
       Supports(f_SortTypeMap, InsStringsSource, l_StringSource) then
    try
     l_StringSource.FillStrings(l_Strings);
    finally
     l_StringSource := nil;
    end;//try..finally
   finally
    l_Strings := nil;
   end;//try..finally
   aParams.Op.SelectedString := f_SortTypeMap.ValueToDisplayName(Ord(dsDocumentList.SortType));
  end;//if Assigned(dsDocumentList) then
 end;//if tvList.TreeView.Current < 0 then
//#UC END# *4C3716C50005_497DDB2B001Btest_impl*
end;//TPrimListForm.List_Sort_Test

procedure TPrimListForm.List_Sort_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3716C50005_497DDB2B001Bexec_var*
var
 l_SortType : TbsSortType;
 l_NewTree  : Il3SimpleTree;
//#UC END# *4C3716C50005_497DDB2B001Bexec_var*
begin
//#UC START# *4C3716C50005_497DDB2B001Bexec_impl*
 if Assigned(dsDocumentList) then
  with dsDocumentList do
  begin
   CheckValidSortTypes(dsDocumentList.ValidSortTypes);
   l_SortType := TbsSortType(f_SortTypeMap.DisplayNameToValue(aParams.SelectedString));
   if (l_SortType <> SortType) then
    with tvList do
    begin
     l_NewTree := ChangeSortType(TreeStruct,
                                 GetCurrentNode,
                                 l_SortType);
     if Assigned(l_NewTree) then
      ReplaceTreeStructForceAsSame(l_NewTree);
     // Сделаем текущий видимым
     tvList.MakeItemVisible(Current);
    end;//with tvList do
  end;//with dsDocumentList do
//#UC END# *4C3716C50005_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_Sort_Execute

procedure TPrimListForm.List_SortDirection_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3716D1012E_497DDB2B001Btest_var*
//#UC END# *4C3716D1012E_497DDB2B001Btest_var*
begin
//#UC START# *4C3716D1012E_497DDB2B001Btest_impl*
 //http://mdp.garant.ru/pages/viewpage.action?pageId=476813620
 aParams.Op.Flag[vcm_ofEnabled] := (HasCurrent and Assigned(dsDocumentList)) and
  (not dsDocumentList.IsListEmpty) and (aParams.Control <> nil) {and (aParams.Control <> tvList)};
//#UC END# *4C3716D1012E_497DDB2B001Btest_impl*
end;//TPrimListForm.List_SortDirection_Test

procedure TPrimListForm.List_SortDirection_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3716D1012E_497DDB2B001Bexec_var*
var
 l_newTree : Il3SimpleTree;
//#UC END# *4C3716D1012E_497DDB2B001Bexec_var*
begin
//#UC START# *4C3716D1012E_497DDB2B001Bexec_impl*
 if Assigned(dsDocumentList) then
  with tvList do
  begin
   l_newTree := dsDocumentList.ChangeSortOrder(TreeStruct, GetCurrentNode);
   if Assigned(l_NewTree) then
   begin
    Changing;
    try
     TreeStruct := l_NewTree;
    finally
     Changed;
    end;//try..finally
   end; //if Assigned(l_NewTree) then
  end; //with tvList do
//#UC END# *4C3716D1012E_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_SortDirection_Execute

procedure TPrimListForm.List_SortDirection_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4C3716D1012E_497DDB2B001Bgetstate_var*
//#UC END# *4C3716D1012E_497DDB2B001Bgetstate_var*
begin
//#UC START# *4C3716D1012E_497DDB2B001Bgetstate_impl*
 if HasCurrent and Assigned(dsDocumentList) then
  if dsDocumentList.SortOrder = SO_ASCENDING then
   State := st_user_List_SortDirection_Ascending
  else
   State := st_user_List_SortDirection_Descending
 else
  State := vcm_DefaultOperationState;
//#UC END# *4C3716D1012E_497DDB2B001Bgetstate_impl*
end;//TPrimListForm.List_SortDirection_GetState

procedure TPrimListForm.List_SpecifyList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3716E20109_497DDB2B001Btest_var*
//#UC END# *4C3716E20109_497DDB2B001Btest_var*
begin
//#UC START# *4C3716E20109_497DDB2B001Btest_impl*
 ListOpsTest(aParams);
 if (aParams.Control = nil) {OR (tvList = aParams.Control)} then
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C3716E20109_497DDB2B001Btest_impl*
end;//TPrimListForm.List_SpecifyList_Test

procedure TPrimListForm.List_SpecifyList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3716E20109_497DDB2B001Bexec_var*
//#UC END# *4C3716E20109_497DDB2B001Bexec_var*
begin
//#UC START# *4C3716E20109_497DDB2B001Bexec_impl*
 if (dsList.ListType = bs_ltDocument) then
  TBaseSearchService.Instance.OpenBaseSearch(ns_bsokSpecify, nil)
 else
  TSearchService.Instance.InpharmSearch(nil, dsList.List, nil);
//#UC END# *4C3716E20109_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_SpecifyList_Execute

procedure TPrimListForm.List_ExportToXML_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3716EF02DF_497DDB2B001Btest_var*
//#UC END# *4C3716EF02DF_497DDB2B001Btest_var*
begin
//#UC START# *4C3716EF02DF_497DDB2B001Btest_impl*
 with aParams.Op.SubItems do
  if Count = 0 then
  begin
   Add(vcmCStr(str_WholeListCaption));
   Add(vcmCStr(str_SelectedDocumentsCaption));
  end;//if Count = 0 then
 aParams.Op.Flag[vcm_ofEnabled] := (not IsListEmpty and defDataAdapter.
  ListXMLExportEnabled);
//#UC END# *4C3716EF02DF_497DDB2B001Btest_impl*
end;//TPrimListForm.List_ExportToXML_Test

procedure TPrimListForm.List_ExportToXML_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3716EF02DF_497DDB2B001Bexec_var*
var
 l_SaveDialog : TvtSaveDialog;
//#UC END# *4C3716EF02DF_497DDB2B001Bexec_var*
begin
//#UC START# *4C3716EF02DF_497DDB2B001Bexec_impl*
 if Assigned(dsList) then
 begin
  l_SaveDialog := TvtSaveDialog.Create(Self);
  try
   with l_SaveDialog do
   begin
    Options := Options + [ofOverwritePrompt, ofPathMustExist];
    Filter := vcmConstString(str_XMLFileFilter);
    DefaultExt := vcmConstString(str_XMLFileExtension);
    FileName := ChangeFileExt(l3PStr(nsMyDocumentFolder(dsList.ListName, '.' + DefaultExt)), '');
    if Execute then
    try
     dsList.SaveToFile(l3PCharLen(FileName), (aParams.ItemIndex = 2));
    except
     on ECannotSave do
      Say(err_ListSaveToFileError);
    end;{try..except}
   end;//with l_SaveDialog do
  finally
   FreeAndNil(l_SaveDialog);
  end;{try..finally}
 end;//if Assigned(dsDocumentList) then
//#UC END# *4C3716EF02DF_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_ExportToXML_Execute

procedure TPrimListForm.Filters_FiltersList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3740FA02D7_497DDB2B001Btest_var*

 procedure lp_MakeTree;
 var
  l_List : IvcmNodes;
  l_Node : Il3SimpleNode;
 begin
  l_List := aParams.Op.SubNodes;
  if (l_List <> nil) then
  begin
   l_List.ShowRoot := false;
   //if (l_List.Count = 0) then
   l_List.Clear;
   begin
    l_Node := TnsFiltersContainer.Instance.Filters[dsList.ListType].Tree.RootNode;
    if (l_Node <> nil) then
     l_List.Add(l_Node);
   end;//if (l_List <> nil) then
  end;//if (l_List <> nil) and
 end;//lp_MakeTree

//#UC END# *4C3740FA02D7_497DDB2B001Btest_var*
begin
//#UC START# *4C3740FA02D7_497DDB2B001Btest_impl*
 with aParams do
 begin
  Op.Flag[vcm_ofEnabled] := Assigned(dsList) and (dsList.IsMain);
  if Op.Flag[vcm_ofEnabled] then
   lp_MakeTree;
 end;//with aParams do
//#UC END# *4C3740FA02D7_497DDB2B001Btest_impl*
end;//TPrimListForm.Filters_FiltersList_Test

procedure TPrimListForm.Filters_FiltersList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3740FA02D7_497DDB2B001Bexec_var*
var
 l_Node: Il3Node;
 l_Filter: IFilterFromQuery;
//#UC END# *4C3740FA02D7_497DDB2B001Bexec_var*
begin
//#UC START# *4C3740FA02D7_497DDB2B001Bexec_impl*
 if Supports(aParams.CurrentNode, Il3Node, l_Node) then
  try
   if not op_Filter_ActivateNode.Call(Aggregate, l_Node) then
   begin
    if Supports(l_Node, IFilterFromQuery, l_Filter) then
    try
     ApplyFilter(l_Filter, not IsFilterActive(l_Filter));
    finally
     l_Filter := nil;
    end;//try..finally
   end;//not op_Filter_ActivateNode.Call(Aggregate, l_Node As IeeNode)
  finally
   l_Node := nil;
  end;//try..finally
//#UC END# *4C3740FA02D7_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filters_FiltersList_Execute

procedure TPrimListForm.LocalList_PublishSourceSearchInList_Test(const aParams: IvcmTestParamsPrim);
 {* Искать по источнику опубликования в текущем списке }
//#UC START# *4C3A96BD0239_497DDB2B001Btest_var*
//#UC END# *4C3A96BD0239_497DDB2B001Btest_var*
begin
//#UC START# *4C3A96BD0239_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := defDataAdapter.IsExists_PublishSourceTag and
  Assigned(dsDocumentList) and not dsDocumentList.IsListEmpty and HasCurrent;
//#UC END# *4C3A96BD0239_497DDB2B001Btest_impl*
end;//TPrimListForm.LocalList_PublishSourceSearchInList_Test

procedure TPrimListForm.LocalList_PublishSourceSearchInList_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Искать по источнику опубликования в текущем списке }
//#UC START# *4C3A96BD0239_497DDB2B001Bexec_var*
//#UC END# *4C3A96BD0239_497DDB2B001Bexec_var*
begin
//#UC START# *4C3A96BD0239_497DDB2B001Bexec_impl*
 TSearchService.Instance.PublishSourceSearch(nil, dsList.List);
//#UC END# *4C3A96BD0239_497DDB2B001Bexec_impl*
end;//TPrimListForm.LocalList_PublishSourceSearchInList_Execute

procedure TPrimListForm.LocalList_Open_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3A971300DA_497DDB2B001Btest_var*
//#UC END# *4C3A971300DA_497DDB2B001Btest_var*
begin
//#UC START# *4C3A971300DA_497DDB2B001Btest_impl*
 if IsListEmpty then
  aParams.Op.Flag[vcm_ofEnabled] := False
 else
  aParams.Op.Flag[vcm_ofEnabled] := True;
//#UC END# *4C3A971300DA_497DDB2B001Btest_impl*
end;//TPrimListForm.LocalList_Open_Test

procedure TPrimListForm.LocalList_Open_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3A971300DA_497DDB2B001Bexec_var*
//#UC END# *4C3A971300DA_497DDB2B001Bexec_var*
begin
//#UC START# *4C3A971300DA_497DDB2B001Bexec_impl*
 OpenCurrentList(NativeMainForm);
//#UC END# *4C3A971300DA_497DDB2B001Bexec_impl*
end;//TPrimListForm.LocalList_Open_Execute

procedure TPrimListForm.LocalList_SearchDrugInList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3A97210318_497DDB2B001Btest_var*
//#UC END# *4C3A97210318_497DDB2B001Btest_var*
begin
//#UC START# *4C3A97210318_497DDB2B001Btest_impl*
 // - ничего не делаем
//#UC END# *4C3A97210318_497DDB2B001Btest_impl*
end;//TPrimListForm.LocalList_SearchDrugInList_Test

procedure TPrimListForm.LocalList_SearchDrugInList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3A97210318_497DDB2B001Bexec_var*
//#UC END# *4C3A97210318_497DDB2B001Bexec_var*
begin
//#UC START# *4C3A97210318_497DDB2B001Bexec_impl*
 TSearchService.Instance.InpharmSearch(nil, dsList.List, nil);
//#UC END# *4C3A97210318_497DDB2B001Bexec_impl*
end;//TPrimListForm.LocalList_SearchDrugInList_Execute

procedure TPrimListForm.Document_GetAnnotationDocFrmAct_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3AA77E00A3_497DDB2B001Btest_var*
//#UC END# *4C3AA77E00A3_497DDB2B001Btest_var*
begin
//#UC START# *4C3AA77E00A3_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := NoMoreThanOneSelected and HasCurrent and
  (dsDocumentList <> nil) and (dsDocumentList.HasAnnotation);
//#UC END# *4C3AA77E00A3_497DDB2B001Btest_impl*
end;//TPrimListForm.Document_GetAnnotationDocFrmAct_Test

procedure TPrimListForm.Document_GetAnnotationDocFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3AA77E00A3_497DDB2B001Bexec_var*
//#UC END# *4C3AA77E00A3_497DDB2B001Bexec_var*
begin
//#UC START# *4C3AA77E00A3_497DDB2B001Bexec_impl*
 Op_SynchroView_BecomeActive.Call(Aggregate, ssfAnnotation);
//#UC END# *4C3AA77E00A3_497DDB2B001Bexec_impl*
end;//TPrimListForm.Document_GetAnnotationDocFrmAct_Execute

procedure TPrimListForm.Document_SimilarDocuments_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3AA78E024D_497DDB2B001Btest_var*
//#UC END# *4C3AA78E024D_497DDB2B001Btest_var*
begin
//#UC START# *4C3AA78E024D_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := NoMoreThanOneSelected and HasCurrent and
  (dsDocumentList <> nil) and (dsDocumentList.HasSimilarDocuments);
//#UC END# *4C3AA78E024D_497DDB2B001Btest_impl*
end;//TPrimListForm.Document_SimilarDocuments_Test

procedure TPrimListForm.Document_SimilarDocuments_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3AA78E024D_497DDB2B001Bexec_var*
//#UC END# *4C3AA78E024D_497DDB2B001Bexec_var*
begin
//#UC START# *4C3AA78E024D_497DDB2B001Bexec_impl*
 op_SynchroView_BecomeActive.Call(Aggregate, ssfSimilarDocuments);
//#UC END# *4C3AA78E024D_497DDB2B001Bexec_impl*
end;//TPrimListForm.Document_SimilarDocuments_Execute

procedure TPrimListForm.CRList_SetType_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3AA94D0041_497DDB2B001Btest_var*
var
 l_List : IvcmNodes;
//#UC END# *4C3AA94D0041_497DDB2B001Btest_var*
begin
//#UC START# *4C3AA94D0041_497DDB2B001Btest_impl*
 if Assigned(dsDocumentList) then
 begin
  with aParams do
  begin
   l_List := Op.SubNodes;
   if (l_List <> nil) then
   begin
    with l_List do
    begin
     ShowRoot := false;
     if f_NeedDropCRList or ((l_List.count = 0) and Assigned(dsDocumentList.CRTypeNode)) then
     begin
      Clear;
      f_NeedDropCRList := false;
      if Assigned(dsDocumentList.CRTypeRoot) then
        Add(dsDocumentList.CRTypeRoot);
     end;//if f_NeedDropCRList then
     if Assigned(dsDocumentList.CRTypeNode) then
     begin
      Current := dsDocumentList.CRTypeNode;
      Op.SelectedString := nsCStr(dsDocumentList.CRTypeNode.Text);
     end
     else
      Op.Flag[vcm_ofEnabled] := False;
    end;//with l_List do
   end;//l_List <> nil
  end;//with aParams
 end;//if Assigned(dsDocumentList) then
//#UC END# *4C3AA94D0041_497DDB2B001Btest_impl*
end;//TPrimListForm.CRList_SetType_Test

procedure TPrimListForm.CRList_SetType_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3AA94D0041_497DDB2B001Bexec_var*
var
 l_Node   : Il3Node;
 l_Locker : InsWarningLocker;
//#UC END# *4C3AA94D0041_497DDB2B001Bexec_var*
begin
//#UC START# *4C3AA94D0041_497DDB2B001Bexec_impl*
 if Supports(aParams.CurrentNode, Il3Node, l_Node) and Assigned(dsDocumentList) then
 begin
  if Dispatcher.InOp and not Dispatcher.InOp(true) then
   l_Locker := WarningLocker
  else
   l_Locker := nil;
  if Assigned(l_Locker) then
   l_Locker.LockWarning;
  try
   dsDocumentList.ChangeCRType(l_Node);
  finally
   if Assigned(l_Locker) then
    l_Locker.UnLockWarning;
  end;//try..finally
 end;//Supports(aParams.CurrentNode, Il3Node, l_Node) and Assigned(dsDocumentList)
//#UC END# *4C3AA94D0041_497DDB2B001Bexec_impl*
end;//TPrimListForm.CRList_SetType_Execute

procedure TPrimListForm.Document_GetGraphicImage_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3C77CC012A_497DDB2B001Btest_var*
//#UC END# *4C3C77CC012A_497DDB2B001Btest_var*
begin
//#UC START# *4C3C77CC012A_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C3C77CC012A_497DDB2B001Btest_impl*
end;//TPrimListForm.Document_GetGraphicImage_Test

procedure TPrimListForm.Document_GetGraphicImage_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3C77CC012A_497DDB2B001Bexec_var*
//#UC END# *4C3C77CC012A_497DDB2B001Bexec_var*
begin
//#UC START# *4C3C77CC012A_497DDB2B001Bexec_impl*
 Assert(false);
//#UC END# *4C3C77CC012A_497DDB2B001Bexec_impl*
end;//TPrimListForm.Document_GetGraphicImage_Execute

procedure TPrimListForm.LocalList_OpenNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Открыть текущий список в новом окне }
//#UC START# *4C46E7160275_497DDB2B001Bexec_var*
//#UC END# *4C46E7160275_497DDB2B001Bexec_var*
begin
//#UC START# *4C46E7160275_497DDB2B001Bexec_impl*
 OpenInNewWindow;
//#UC END# *4C46E7160275_497DDB2B001Bexec_impl*
end;//TPrimListForm.LocalList_OpenNewWindow_Execute

procedure TPrimListForm.Selection_CopyToNewList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C46EB11016B_497DDB2B001Btest_var*
//#UC END# *4C46EB11016B_497DDB2B001Btest_var*
begin
//#UC START# *4C46EB11016B_497DDB2B001Btest_impl*
 SelectionOpsTest(aParams);
//#UC END# *4C46EB11016B_497DDB2B001Btest_impl*
end;//TPrimListForm.Selection_CopyToNewList_Test

procedure TPrimListForm.Selection_CopyToNewList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C46EB11016B_497DDB2B001Bexec_var*
var
 l_Data   : IdeList;
 l_Cont : IvcmContainer;
//#UC END# *4C46EB11016B_497DDB2B001Bexec_var*
begin
//#UC START# *4C46EB11016B_497DDB2B001Bexec_impl*
 if Assigned(dsList) then
 begin
  l_Data := dsList.OpenListFromSelectedNodes;
  if Assigned(l_Data) then
  try
   l_Cont := nsOpenNewWindowTabbed(NativeMainForm);
   // http://mdp.garant.ru/pages/viewpage.action?pageId=414849606
   if (l_Cont <> nil) then
   try
    TListService.Instance.OpenList(l_Data, l_Cont);
   finally
    l_Cont := nil;
   end;//try..finally
  finally
   l_Data := nil;
  end;{try..finally}
 end;//if Assigned(dsDocumentList) then
//#UC END# *4C46EB11016B_497DDB2B001Bexec_impl*
end;//TPrimListForm.Selection_CopyToNewList_Execute

procedure TPrimListForm.Filters_Clear_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C52AA040095_497DDB2B001Bexec_var*
//#UC END# *4C52AA040095_497DDB2B001Bexec_var*
begin
//#UC START# *4C52AA040095_497DDB2B001Bexec_impl*
 ClearFilters;
//#UC END# *4C52AA040095_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filters_Clear_Execute

procedure TPrimListForm.Selection_Analize_Test(const aParams: IvcmTestParamsPrim);
 {* Анализ списка... }
//#UC START# *4C8103FB02FD_497DDB2B001Btest_var*
//#UC END# *4C8103FB02FD_497DDB2B001Btest_var*
begin
//#UC START# *4C8103FB02FD_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not IsListEmpty and
  {(tvList.TreeView.Tree.SelectedCount = 1) and}
  // http://mdp.garant.ru/pages/viewpage.action?pageId=253662765&focusedCommentId=253663972#comment-253663972
  Assigned(dsDocumentList) and dsDocumentList.CanAnalize;
//#UC END# *4C8103FB02FD_497DDB2B001Btest_impl*
end;//TPrimListForm.Selection_Analize_Test

procedure TPrimListForm.Selection_Analize_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Анализ списка... }
//#UC START# *4C8103FB02FD_497DDB2B001Bexec_var*
//#UC END# *4C8103FB02FD_497DDB2B001Bexec_var*
begin
//#UC START# *4C8103FB02FD_497DDB2B001Bexec_impl*
 if Assigned(dsDocumentList) then
  TListService.Instance.MakeListAnalizer(dsDocumentList.MakeAnalizeTree);
//#UC END# *4C8103FB02FD_497DDB2B001Bexec_impl*
end;//TPrimListForm.Selection_Analize_Execute

procedure TPrimListForm.LocalList_SearchInList_Test(const aParams: IvcmTestParamsPrim);
 {* Искать по реквизитам в текущем списке }
//#UC START# *4C810A2702D9_497DDB2B001Btest_var*
//#UC END# *4C810A2702D9_497DDB2B001Btest_var*
begin
//#UC START# *4C810A2702D9_497DDB2B001Btest_impl*
 ListOpsTest(aParams);
//#UC END# *4C810A2702D9_497DDB2B001Btest_impl*
end;//TPrimListForm.LocalList_SearchInList_Test

procedure TPrimListForm.LocalList_SearchInList_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Искать по реквизитам в текущем списке }
//#UC START# *4C810A2702D9_497DDB2B001Bexec_var*
//#UC END# *4C810A2702D9_497DDB2B001Bexec_var*
begin
//#UC START# *4C810A2702D9_497DDB2B001Bexec_impl*
 TSearchService.Instance.AttributeSearch(nil, dsList.List, nil);
//#UC END# *4C810A2702D9_497DDB2B001Bexec_impl*
end;//TPrimListForm.LocalList_SearchInList_Execute

procedure TPrimListForm.Filters_FiltersListOpen_Test(const aParams: IvcmTestParamsPrim);
 {* Фильтры (вкладка) }
//#UC START# *4C81191003E5_497DDB2B001Btest_var*
//#UC END# *4C81191003E5_497DDB2B001Btest_var*
begin
//#UC START# *4C81191003E5_497DDB2B001Btest_impl*
 // Do nothing
//#UC END# *4C81191003E5_497DDB2B001Btest_impl*
end;//TPrimListForm.Filters_FiltersListOpen_Test

procedure TPrimListForm.Filters_FiltersListOpen_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Фильтры (вкладка) }
//#UC START# *4C81191003E5_497DDB2B001Bexec_var*
//#UC END# *4C81191003E5_497DDB2B001Bexec_var*
begin
//#UC START# *4C81191003E5_497DDB2B001Bexec_impl*
 if (ucpFilters = nil) then
  TFiltersService.Instance.OldSchoolFiltersOpen(Aggregate, nil, Self)
 else
  TFiltersService.Instance.FiltersOpen(ucpFilters);
//#UC END# *4C81191003E5_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filters_FiltersListOpen_Execute

function TPrimListForm.pm_GetHyperlinkDocID: Integer;
//#UC START# *4CDD19B503B1_497DDB2B001Bget_var*
//#UC END# *4CDD19B503B1_497DDB2B001Bget_var*
begin
//#UC START# *4CDD19B503B1_497DDB2B001Bget_impl*
 if (sdsBaseDocument = nil) then
  Result := 0
 else
  try
   if (sdsBaseDocument.DocInfo = nil) OR
      (sdsBaseDocument.DocInfo.Doc = nil) then
    Result := 0
   else
    Result := sdsBaseDocument.DocInfo.Doc.GetInternalId + c_InternalDocShift;
  except
   on ECanNotFindData do
    Result := 0;
  end;//try..except
//#UC END# *4CDD19B503B1_497DDB2B001Bget_impl*
end;//TPrimListForm.pm_GetHyperlinkDocID

function TPrimListForm.pm_GetHyperlinkDocumentName: Il3CString;
//#UC START# *4CDD1A02013D_497DDB2B001Bget_var*
//#UC END# *4CDD1A02013D_497DDB2B001Bget_var*
begin
//#UC START# *4CDD1A02013D_497DDB2B001Bget_impl*
 if (sdsBaseDocument = nil) then
  Result := nil
 else
  Result := sdsBaseDocument.DocInfo.DocName;
//#UC END# *4CDD1A02013D_497DDB2B001Bget_impl*
end;//TPrimListForm.pm_GetHyperlinkDocumentName

procedure TPrimListForm.Filters_InternalClear_Execute;
//#UC START# *4DBA95ED03B7_497DDB2B001Bexec_var*
//#UC END# *4DBA95ED03B7_497DDB2B001Bexec_var*
begin
//#UC START# *4DBA95ED03B7_497DDB2B001Bexec_impl*
 ClearFilters;
//#UC END# *4DBA95ED03B7_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filters_InternalClear_Execute

procedure TPrimListForm.Filters_InternalClear(const aParams: IvcmExecuteParams);
begin
 Self.Filters_InternalClear_Execute;
end;//TPrimListForm.Filters_InternalClear

function TPrimListForm.Get_NeedSaveActiveClassBeforeSearch: Boolean;
//#UC START# *4F1D607E0027_497DDB2B001Bget_var*
//#UC END# *4F1D607E0027_497DDB2B001Bget_var*
begin
//#UC START# *4F1D607E0027_497DDB2B001Bget_impl*
 Result := true;
//#UC END# *4F1D607E0027_497DDB2B001Bget_impl*
end;//TPrimListForm.Get_NeedSaveActiveClassBeforeSearch

function TPrimListForm.Filterable_GetListType_Execute: TbsListType;
//#UC START# *4F99403A00A5_497DDB2B001Bexec_var*
//#UC END# *4F99403A00A5_497DDB2B001Bexec_var*
begin
//#UC START# *4F99403A00A5_497DDB2B001Bexec_impl*
 if (dsList <> nil) then
  Result := dsList.ListType
 else
  Result := bs_ltNone;
//#UC END# *4F99403A00A5_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filterable_GetListType_Execute

procedure TPrimListForm.Filterable_GetListType(const aParams: IvcmExecuteParams);
begin
 with IFilterable_GetListType_Params(aParams.Data) do
  ResultValue := Self.Filterable_GetListType_Execute;
end;//TPrimListForm.Filterable_GetListType

function TPrimListForm.List_GetDsList_Execute: IdsList;
//#UC START# *4FE83BFC039C_497DDB2B001Bexec_var*
//#UC END# *4FE83BFC039C_497DDB2B001Bexec_var*
begin
//#UC START# *4FE83BFC039C_497DDB2B001Bexec_impl*
 Result := dsList;
//#UC END# *4FE83BFC039C_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_GetDsList_Execute

procedure TPrimListForm.List_GetDsList(const aParams: IvcmExecuteParams);
begin
 with IList_GetDsList_Params(aParams.Data) do
  ResultValue := Self.List_GetDsList_Execute;
end;//TPrimListForm.List_GetDsList

procedure TPrimListForm.LftUserCRList1SynchorFormQueryMaximized(aSender: TObject);
 {* Обработчик события lftUserCRList1_SynchorForm.OnQueryMaximized }
//#UC START# *536B8B1C39F1_497DDB2B001B_var*
//#UC END# *536B8B1C39F1_497DDB2B001B_var*
begin
//#UC START# *536B8B1C39F1_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *536B8B1C39F1_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCRList1SynchorFormQueryMaximized

procedure TPrimListForm.List_Analize_Test(const aParams: IvcmTestParamsPrim);
 {* Анализ списка }
//#UC START# *53DB376C0239_497DDB2B001Btest_var*
//#UC END# *53DB376C0239_497DDB2B001Btest_var*
begin
//#UC START# *53DB376C0239_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not IsListEmpty and
  {(tvList.TreeView.Tree.SelectedCount = 1) and}
  // http://mdp.garant.ru/pages/viewpage.action?pageId=253662765&focusedCommentId=253663972#comment-253663972
  Assigned(dsDocumentList) and dsDocumentList.CanAnalize and (aParams.Control = tvList);
//#UC END# *53DB376C0239_497DDB2B001Btest_impl*
end;//TPrimListForm.List_Analize_Test

procedure TPrimListForm.List_Analize_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Анализ списка }
//#UC START# *53DB376C0239_497DDB2B001Bexec_var*
//#UC END# *53DB376C0239_497DDB2B001Bexec_var*
begin
//#UC START# *53DB376C0239_497DDB2B001Bexec_impl*
 if Assigned(dsDocumentList) then
  TListService.Instance.MakeListAnalizer(dsDocumentList.MakeAnalizeTree);
//#UC END# *53DB376C0239_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_Analize_Execute

procedure TPrimListForm.List_AnalizeList_Test(const aParams: IvcmTestParamsPrim);
 {* Анализ списка... }
//#UC START# *53FF40030272_497DDB2B001Btest_var*
//#UC END# *53FF40030272_497DDB2B001Btest_var*
begin
//#UC START# *53FF40030272_497DDB2B001Btest_impl*
 List_Analize_Test(aParams);
//#UC END# *53FF40030272_497DDB2B001Btest_impl*
end;//TPrimListForm.List_AnalizeList_Test

procedure TPrimListForm.List_AnalizeList_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Анализ списка... }
//#UC START# *53FF40030272_497DDB2B001Bexec_var*
//#UC END# *53FF40030272_497DDB2B001Bexec_var*
begin
//#UC START# *53FF40030272_497DDB2B001Bexec_impl*
 List_Analize_Execute(aParams);
//#UC END# *53FF40030272_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_AnalizeList_Execute

procedure TPrimListForm.List_SortForReminders_Test(const aParams: IvcmTestParamsPrim);
 {* Сортировать список }
//#UC START# *545B93FE00D1_497DDB2B001Btest_var*
//#UC END# *545B93FE00D1_497DDB2B001Btest_var*
begin
//#UC START# *545B93FE00D1_497DDB2B001Btest_impl*
 List_Sort_Test(aParams);
 if (aParams.Control = tvList) then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *545B93FE00D1_497DDB2B001Btest_impl*
end;//TPrimListForm.List_SortForReminders_Test

procedure TPrimListForm.List_SortForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Сортировать список }
//#UC START# *545B93FE00D1_497DDB2B001Bexec_var*
//#UC END# *545B93FE00D1_497DDB2B001Bexec_var*
begin
//#UC START# *545B93FE00D1_497DDB2B001Bexec_impl*
 List_Sort_Execute(aParams);
//#UC END# *545B93FE00D1_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_SortForReminders_Execute

procedure TPrimListForm.List_SortDirectionForReminders_Test(const aParams: IvcmTestParamsPrim);
 {* Установить направление сортировки }
//#UC START# *545B9440035C_497DDB2B001Btest_var*
//#UC END# *545B9440035C_497DDB2B001Btest_var*
begin
//#UC START# *545B9440035C_497DDB2B001Btest_impl*
 List_SortDirection_Test(aParams);
 if (aParams.Control = tvList) then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *545B9440035C_497DDB2B001Btest_impl*
end;//TPrimListForm.List_SortDirectionForReminders_Test

procedure TPrimListForm.List_SortDirectionForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Установить направление сортировки }
//#UC START# *545B9440035C_497DDB2B001Bexec_var*
//#UC END# *545B9440035C_497DDB2B001Bexec_var*
begin
//#UC START# *545B9440035C_497DDB2B001Bexec_impl*
 List_SortDirection_Execute(aParams);
//#UC END# *545B9440035C_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_SortDirectionForReminders_Execute

procedure TPrimListForm.List_SortDirectionForReminders_GetState(var State: TvcmOperationStateIndex);
 {* Установить направление сортировки }
//#UC START# *545B9440035C_497DDB2B001Bgetstate_var*
//#UC END# *545B9440035C_497DDB2B001Bgetstate_var*
begin
//#UC START# *545B9440035C_497DDB2B001Bgetstate_impl*
 if HasCurrent and Assigned(dsDocumentList) then
  if dsDocumentList.SortOrder = SO_ASCENDING then
   State := st_user_List_SortDirectionForReminders_Ascending
  else
   State := st_user_List_SortDirectionForReminders_Descending
 else
  State := vcm_DefaultOperationState;
//#UC END# *545B9440035C_497DDB2B001Bgetstate_impl*
end;//TPrimListForm.List_SortDirectionForReminders_GetState

procedure TPrimListForm.List_SpecifyListForReminders_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *545B954A035E_497DDB2B001Btest_var*
//#UC END# *545B954A035E_497DDB2B001Btest_var*
begin
//#UC START# *545B954A035E_497DDB2B001Btest_impl*
 List_SpecifyList_Test(aParams);
 if (aParams.Control = tvList) then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *545B954A035E_497DDB2B001Btest_impl*
end;//TPrimListForm.List_SpecifyListForReminders_Test

procedure TPrimListForm.List_SpecifyListForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *545B954A035E_497DDB2B001Bexec_var*
//#UC END# *545B954A035E_497DDB2B001Bexec_var*
begin
//#UC START# *545B954A035E_497DDB2B001Bexec_impl*
 List_SpecifyList_Execute(aParams);
//#UC END# *545B954A035E_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_SpecifyListForReminders_Execute

procedure TPrimListForm.LftProducedDrugsQueryClose(aSender: TObject);
 {* Обработчик события lftProducedDrugs.OnQueryClose }
//#UC START# *5487A60000CE_497DDB2B001B_var*
//#UC END# *5487A60000CE_497DDB2B001B_var*
begin
//#UC START# *5487A60000CE_497DDB2B001B_impl*
 LftRespondentQueryClose(aSender);
//#UC END# *5487A60000CE_497DDB2B001B_impl*
end;//TPrimListForm.LftProducedDrugsQueryClose

function TPrimListForm.IsSearchLocked: Boolean;
//#UC START# *561641EE03D8_497DDB2B001B_var*
//#UC END# *561641EE03D8_497DDB2B001B_var*
begin
//#UC START# *561641EE03D8_497DDB2B001B_impl*
 Result := False;
//#UC END# *561641EE03D8_497DDB2B001B_impl*
end;//TPrimListForm.IsSearchLocked

procedure TPrimListForm.LftUserCR2QueryClose(aSender: TObject);
 {* Обработчик события lftUserCR2.OnQueryClose }
//#UC START# *5B815CDD8F87_497DDB2B001B_var*
//#UC END# *5B815CDD8F87_497DDB2B001B_var*
begin
//#UC START# *5B815CDD8F87_497DDB2B001B_impl*
 LftRespondentQueryClose(aSender);
//#UC END# *5B815CDD8F87_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCR2QueryClose

procedure TPrimListForm.LftConsultationQueryOpen(aSender: TObject);
 {* Обработчик события lftConsultation.OnQueryOpen }
//#UC START# *5E40E10FD4BD_497DDB2B001B_var*
//#UC END# *5E40E10FD4BD_497DDB2B001B_var*
begin
//#UC START# *5E40E10FD4BD_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *5E40E10FD4BD_497DDB2B001B_impl*
end;//TPrimListForm.LftConsultationQueryOpen

procedure TPrimListForm.LftRespondentQueryMaximized(aSender: TObject);
 {* Обработчик события lftRespondent.OnQueryMaximized }
//#UC START# *631A220E9075_497DDB2B001B_var*
//#UC END# *631A220E9075_497DDB2B001B_var*
begin
//#UC START# *631A220E9075_497DDB2B001B_impl*
 QueryMaximized;
//#UC END# *631A220E9075_497DDB2B001B_impl*
end;//TPrimListForm.LftRespondentQueryMaximized

procedure TPrimListForm.LftUserCR1QueryOpen(aSender: TObject);
 {* Обработчик события lftUserCR1.OnQueryOpen }
//#UC START# *63544B6D4A1B_497DDB2B001B_var*
//#UC END# *63544B6D4A1B_497DDB2B001B_var*
begin
//#UC START# *63544B6D4A1B_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *63544B6D4A1B_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCR1QueryOpen

procedure TPrimListForm.LftProducedDrugsQueryMaximized(aSender: TObject);
 {* Обработчик события lftProducedDrugs.OnQueryMaximized }
//#UC START# *66C365C924D6_497DDB2B001B_var*
//#UC END# *66C365C924D6_497DDB2B001B_var*
begin
//#UC START# *66C365C924D6_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *66C365C924D6_497DDB2B001B_impl*
end;//TPrimListForm.LftProducedDrugsQueryMaximized

procedure TPrimListForm.LftRespondentQueryClose(aSender: TObject);
 {* Обработчик события lftRespondent.OnQueryClose }
//#UC START# *6784C69651CE_497DDB2B001B_var*
//#UC END# *6784C69651CE_497DDB2B001B_var*
begin
//#UC START# *6784C69651CE_497DDB2B001B_impl*
 if UserType in [lftUserCR1,
                 lftUserCR2,
                 lftSimilarDocuments,
                 lftProducedDrugs,
                 lftDrugInternationalNameSynonyms] then
  op_Switcher_SetFirstPageActive.Call(Container)
 else
  SafeClose;
//#UC END# *6784C69651CE_497DDB2B001B_impl*
end;//TPrimListForm.LftRespondentQueryClose

procedure TPrimListForm.LftUserCR2QueryMaximized(aSender: TObject);
 {* Обработчик события lftUserCR2.OnQueryMaximized }
//#UC START# *68123CAC609E_497DDB2B001B_var*
//#UC END# *68123CAC609E_497DDB2B001B_var*
begin
//#UC START# *68123CAC609E_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *68123CAC609E_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCR2QueryMaximized

procedure TPrimListForm.LftSimilarDocumentsSynchroViewQueryMaximized(aSender: TObject);
 {* Обработчик события lftSimilarDocumentsSynchroView.OnQueryMaximized }
//#UC START# *7662726E4743_497DDB2B001B_var*
//#UC END# *7662726E4743_497DDB2B001B_var*
begin
//#UC START# *7662726E4743_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *7662726E4743_497DDB2B001B_impl*
end;//TPrimListForm.LftSimilarDocumentsSynchroViewQueryMaximized

procedure TPrimListForm.LftCorrespondentQueryOpen(aSender: TObject);
 {* Обработчик события lftCorrespondent.OnQueryOpen }
//#UC START# *7984D701603A_497DDB2B001B_var*
//#UC END# *7984D701603A_497DDB2B001B_var*
begin
//#UC START# *7984D701603A_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *7984D701603A_497DDB2B001B_impl*
end;//TPrimListForm.LftCorrespondentQueryOpen

procedure TPrimListForm.LftCorrespondentsSynchroFormQueryMaximized(aSender: TObject);
 {* Обработчик события lftCorrespondentsSynchroForm.OnQueryMaximized }
//#UC START# *79CA491C075A_497DDB2B001B_var*
//#UC END# *79CA491C075A_497DDB2B001B_var*
begin
//#UC START# *79CA491C075A_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *79CA491C075A_497DDB2B001B_impl*
end;//TPrimListForm.LftCorrespondentsSynchroFormQueryMaximized

procedure TPrimListForm.LftUserCR1QueryMaximized(aSender: TObject);
 {* Обработчик события lftUserCR1.OnQueryMaximized }
//#UC START# *79E93ABBEBFC_497DDB2B001B_var*
//#UC END# *79E93ABBEBFC_497DDB2B001B_var*
begin
//#UC START# *79E93ABBEBFC_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *79E93ABBEBFC_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCR1QueryMaximized

procedure TPrimListForm.LftUserCR1QueryClose(aSender: TObject);
 {* Обработчик события lftUserCR1.OnQueryClose }
//#UC START# *7C26AE9268E7_497DDB2B001B_var*
//#UC END# *7C26AE9268E7_497DDB2B001B_var*
begin
//#UC START# *7C26AE9268E7_497DDB2B001B_impl*
 LftRespondentQueryClose(aSender);
//#UC END# *7C26AE9268E7_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCR1QueryClose

procedure TPrimListForm.LftDrugInternationalNameSynonymsQueryClose(aSender: TObject);
 {* Обработчик события lftDrugInternationalNameSynonyms.OnQueryClose }
//#UC START# *7CA1B2391F94_497DDB2B001B_var*
//#UC END# *7CA1B2391F94_497DDB2B001B_var*
begin
//#UC START# *7CA1B2391F94_497DDB2B001B_impl*
 LftRespondentQueryClose(aSender);
//#UC END# *7CA1B2391F94_497DDB2B001B_impl*
end;//TPrimListForm.LftDrugInternationalNameSynonymsQueryClose

procedure TPrimListForm.LftSynchroViewQueryOpen(aSender: TObject);
 {* Обработчик события lftSynchroView.OnQueryOpen }
//#UC START# *7D78C9A85314_497DDB2B001B_var*
//#UC END# *7D78C9A85314_497DDB2B001B_var*
begin
//#UC START# *7D78C9A85314_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *7D78C9A85314_497DDB2B001B_impl*
end;//TPrimListForm.LftSynchroViewQueryOpen

procedure TPrimListForm.LftDrugInternationalNameSynonymsQueryOpen(aSender: TObject);
 {* Обработчик события lftDrugInternationalNameSynonyms.OnQueryOpen }
//#UC START# *8829BBB9E33F_497DDB2B001B_var*
//#UC END# *8829BBB9E33F_497DDB2B001B_var*
begin
//#UC START# *8829BBB9E33F_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *8829BBB9E33F_497DDB2B001B_impl*
end;//TPrimListForm.LftDrugInternationalNameSynonymsQueryOpen

procedure TPrimListForm.LftConsultationQueryClose(aSender: TObject);
 {* Обработчик события lftConsultation.OnQueryClose }
//#UC START# *89247CD8E38D_497DDB2B001B_var*
//#UC END# *89247CD8E38D_497DDB2B001B_var*
begin
//#UC START# *89247CD8E38D_497DDB2B001B_impl*
 op_Switcher_SetFirstPageActive.Call(Container);
//#UC END# *89247CD8E38D_497DDB2B001B_impl*
end;//TPrimListForm.LftConsultationQueryClose

procedure TPrimListForm.LftRToPartQueryMaximized(aSender: TObject);
 {* Обработчик события lftRToPart.OnQueryMaximized }
//#UC START# *910DF1C1598C_497DDB2B001B_var*
//#UC END# *910DF1C1598C_497DDB2B001B_var*
begin
//#UC START# *910DF1C1598C_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *910DF1C1598C_497DDB2B001B_impl*
end;//TPrimListForm.LftRToPartQueryMaximized

procedure TPrimListForm.LftSimilarDocumentsQueryClose(aSender: TObject);
 {* Обработчик события lftSimilarDocuments.OnQueryClose }
//#UC START# *9144562E25FB_497DDB2B001B_var*
//#UC END# *9144562E25FB_497DDB2B001B_var*
begin
//#UC START# *9144562E25FB_497DDB2B001B_impl*
 LftRespondentQueryClose(aSender);
//#UC END# *9144562E25FB_497DDB2B001B_impl*
end;//TPrimListForm.LftSimilarDocumentsQueryClose

procedure TPrimListForm.LftSimilarDocumentsToFragmentQueryMaximized(aSender: TObject);
 {* Обработчик события lftSimilarDocumentsToFragment.OnQueryMaximized }
//#UC START# *9CAFD9A7C3BD_497DDB2B001B_var*
//#UC END# *9CAFD9A7C3BD_497DDB2B001B_var*
begin
//#UC START# *9CAFD9A7C3BD_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *9CAFD9A7C3BD_497DDB2B001B_impl*
end;//TPrimListForm.LftSimilarDocumentsToFragmentQueryMaximized

procedure TPrimListForm.LftRespondentQueryOpen(aSender: TObject);
 {* Обработчик события lftRespondent.OnQueryOpen }
//#UC START# *9FBF6C4D3127_497DDB2B001B_var*
//#UC END# *9FBF6C4D3127_497DDB2B001B_var*
begin
//#UC START# *9FBF6C4D3127_497DDB2B001B_impl*
 QueryOpen;
//#UC END# *9FBF6C4D3127_497DDB2B001B_impl*
end;//TPrimListForm.LftRespondentQueryOpen

procedure TPrimListForm.LftCorrespondentQueryMaximized(aSender: TObject);
 {* Обработчик события lftCorrespondent.OnQueryMaximized }
//#UC START# *AC1A36740EA8_497DDB2B001B_var*
//#UC END# *AC1A36740EA8_497DDB2B001B_var*
begin
//#UC START# *AC1A36740EA8_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *AC1A36740EA8_497DDB2B001B_impl*
end;//TPrimListForm.LftCorrespondentQueryMaximized

procedure TPrimListForm.LftSimilarDocumentsToFragmentQueryOpen(aSender: TObject);
 {* Обработчик события lftSimilarDocumentsToFragment.OnQueryOpen }
//#UC START# *B3625EBE1EED_497DDB2B001B_var*
//#UC END# *B3625EBE1EED_497DDB2B001B_var*
begin
//#UC START# *B3625EBE1EED_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *B3625EBE1EED_497DDB2B001B_impl*
end;//TPrimListForm.LftSimilarDocumentsToFragmentQueryOpen

procedure TPrimListForm.LftProducedDrugsSynchroFormQueryOpen(aSender: TObject);
 {* Обработчик события lftProducedDrugsSynchroForm.OnQueryOpen }
//#UC START# *B74FCF7BEB24_497DDB2B001B_var*
//#UC END# *B74FCF7BEB24_497DDB2B001B_var*
begin
//#UC START# *B74FCF7BEB24_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *B74FCF7BEB24_497DDB2B001B_impl*
end;//TPrimListForm.LftProducedDrugsSynchroFormQueryOpen

procedure TPrimListForm.LftConsultationQueryMaximized(aSender: TObject);
 {* Обработчик события lftConsultation.OnQueryMaximized }
//#UC START# *B8F5E8ADF26A_497DDB2B001B_var*
//#UC END# *B8F5E8ADF26A_497DDB2B001B_var*
begin
//#UC START# *B8F5E8ADF26A_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *B8F5E8ADF26A_497DDB2B001B_impl*
end;//TPrimListForm.LftConsultationQueryMaximized

procedure TPrimListForm.LftCorrespondentQueryClose(aSender: TObject);
 {* Обработчик события lftCorrespondent.OnQueryClose }
//#UC START# *BAF9A43F64B1_497DDB2B001B_var*
//#UC END# *BAF9A43F64B1_497DDB2B001B_var*
begin
//#UC START# *BAF9A43F64B1_497DDB2B001B_impl*
 LftRespondentQueryClose(aSender);
//#UC END# *BAF9A43F64B1_497DDB2B001B_impl*
end;//TPrimListForm.LftCorrespondentQueryClose

procedure TPrimListForm.LftSynchroViewQueryMaximized(aSender: TObject);
 {* Обработчик события lftSynchroView.OnQueryMaximized }
//#UC START# *BC1EF73BE90E_497DDB2B001B_var*
//#UC END# *BC1EF73BE90E_497DDB2B001B_var*
begin
//#UC START# *BC1EF73BE90E_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *BC1EF73BE90E_497DDB2B001B_impl*
end;//TPrimListForm.LftSynchroViewQueryMaximized

procedure TPrimListForm.LftRespondentsSynchroFormQueryOpen(aSender: TObject);
 {* Обработчик события lftRespondentsSynchroForm.OnQueryOpen }
//#UC START# *C576738B9A98_497DDB2B001B_var*
//#UC END# *C576738B9A98_497DDB2B001B_var*
begin
//#UC START# *C576738B9A98_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *C576738B9A98_497DDB2B001B_impl*
end;//TPrimListForm.LftRespondentsSynchroFormQueryOpen

procedure TPrimListForm.LftUserCRList2SynchorFormQueryMaximized(aSender: TObject);
 {* Обработчик события lftUserCRList2_SynchorForm.OnQueryMaximized }
//#UC START# *D22B2108D1D7_497DDB2B001B_var*
//#UC END# *D22B2108D1D7_497DDB2B001B_var*
begin
//#UC START# *D22B2108D1D7_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *D22B2108D1D7_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCRList2SynchorFormQueryMaximized

procedure TPrimListForm.LftUserCRList1SynchorFormQueryOpen(aSender: TObject);
 {* Обработчик события lftUserCRList1_SynchorForm.OnQueryOpen }
//#UC START# *D51A85B5EA94_497DDB2B001B_var*
//#UC END# *D51A85B5EA94_497DDB2B001B_var*
begin
//#UC START# *D51A85B5EA94_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *D51A85B5EA94_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCRList1SynchorFormQueryOpen

procedure TPrimListForm.LftSimilarDocumentsSynchroViewQueryOpen(aSender: TObject);
 {* Обработчик события lftSimilarDocumentsSynchroView.OnQueryOpen }
//#UC START# *D7AA4578D2D1_497DDB2B001B_var*
//#UC END# *D7AA4578D2D1_497DDB2B001B_var*
begin
//#UC START# *D7AA4578D2D1_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *D7AA4578D2D1_497DDB2B001B_impl*
end;//TPrimListForm.LftSimilarDocumentsSynchroViewQueryOpen

procedure TPrimListForm.LftProducedDrugsQueryOpen(aSender: TObject);
 {* Обработчик события lftProducedDrugs.OnQueryOpen }
//#UC START# *DD3CF6B9A1FE_497DDB2B001B_var*
//#UC END# *DD3CF6B9A1FE_497DDB2B001B_var*
begin
//#UC START# *DD3CF6B9A1FE_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *DD3CF6B9A1FE_497DDB2B001B_impl*
end;//TPrimListForm.LftProducedDrugsQueryOpen

procedure TPrimListForm.LftDrugInternationalNameSynonymsQueryMaximized(aSender: TObject);
 {* Обработчик события lftDrugInternationalNameSynonyms.OnQueryMaximized }
//#UC START# *DF8DF3016AAE_497DDB2B001B_var*
//#UC END# *DF8DF3016AAE_497DDB2B001B_var*
begin
//#UC START# *DF8DF3016AAE_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *DF8DF3016AAE_497DDB2B001B_impl*
end;//TPrimListForm.LftDrugInternationalNameSynonymsQueryMaximized

procedure TPrimListForm.LftSimilarDocumentsToFragmentQueryClose(aSender: TObject);
 {* Обработчик события lftSimilarDocumentsToFragment.OnQueryClose }
//#UC START# *E15AA3CCAAFD_497DDB2B001B_var*
//#UC END# *E15AA3CCAAFD_497DDB2B001B_var*
begin
//#UC START# *E15AA3CCAAFD_497DDB2B001B_impl*
 LftRespondentQueryClose(aSender);
//#UC END# *E15AA3CCAAFD_497DDB2B001B_impl*
end;//TPrimListForm.LftSimilarDocumentsToFragmentQueryClose

procedure TPrimListForm.LftDrugInternationalNameSynonymsSynchroFormQueryOpen(aSender: TObject);
 {* Обработчик события lftDrugInternationalNameSynonymsSynchroForm.OnQueryOpen }
//#UC START# *E163385C2B4E_497DDB2B001B_var*
//#UC END# *E163385C2B4E_497DDB2B001B_var*
begin
//#UC START# *E163385C2B4E_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *E163385C2B4E_497DDB2B001B_impl*
end;//TPrimListForm.LftDrugInternationalNameSynonymsSynchroFormQueryOpen

procedure TPrimListForm.LftDrugInternationalNameSynonymsSynchroFormQueryMaximized(aSender: TObject);
 {* Обработчик события lftDrugInternationalNameSynonymsSynchroForm.OnQueryMaximized }
//#UC START# *F57A05E9D1E3_497DDB2B001B_var*
//#UC END# *F57A05E9D1E3_497DDB2B001B_var*
begin
//#UC START# *F57A05E9D1E3_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *F57A05E9D1E3_497DDB2B001B_impl*
end;//TPrimListForm.LftDrugInternationalNameSynonymsSynchroFormQueryMaximized

procedure TPrimListForm.LftProducedDrugsSynchroFormQueryMaximized(aSender: TObject);
 {* Обработчик события lftProducedDrugsSynchroForm.OnQueryMaximized }
//#UC START# *F8F8E6852550_497DDB2B001B_var*
//#UC END# *F8F8E6852550_497DDB2B001B_var*
begin
//#UC START# *F8F8E6852550_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *F8F8E6852550_497DDB2B001B_impl*
end;//TPrimListForm.LftProducedDrugsSynchroFormQueryMaximized

procedure TPrimListForm.LftCToPartQueryMaximized(aSender: TObject);
 {* Обработчик события lftCToPart.OnQueryMaximized }
//#UC START# *FA04A3642350_497DDB2B001B_var*
//#UC END# *FA04A3642350_497DDB2B001B_var*
begin
//#UC START# *FA04A3642350_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *FA04A3642350_497DDB2B001B_impl*
end;//TPrimListForm.LftCToPartQueryMaximized

procedure TPrimListForm.LftCToPartQueryOpen(aSender: TObject);
 {* Обработчик события lftCToPart.OnQueryOpen }
//#UC START# *FEE09FA84BC5_497DDB2B001B_var*
//#UC END# *FEE09FA84BC5_497DDB2B001B_var*
begin
//#UC START# *FEE09FA84BC5_497DDB2B001B_impl*
 LftCorrespondentQueryOpen(aSender);
//#UC END# *FEE09FA84BC5_497DDB2B001B_impl*
end;//TPrimListForm.LftCToPartQueryOpen

procedure TPrimListForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_497DDB2B001B_var*
//#UC END# *47EA4E9002C6_497DDB2B001B_var*
begin
//#UC START# *47EA4E9002C6_497DDB2B001B_impl*
 inherited;
 if not IsAcceptable(True) then
 begin 
  if vcmDispatcher.History.CanBack then
   vcmDispatcher.History.Back(True);
 end;
//#UC END# *47EA4E9002C6_497DDB2B001B_impl*
end;//TPrimListForm.FinishDataUpdate

procedure TPrimListForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_497DDB2B001B_var*
var
 l_BS: InsBaseSearcher;
//#UC END# *497469C90140_497DDB2B001B_var*
begin
//#UC START# *497469C90140_497DDB2B001B_impl*
 inherited;
 f_AllowCallCurrentChangedOnTest := True;
 if Assigned(aNew) then
 begin
  l_BS := TnsBaseSearchService.Instance.GetBaseSearcher(As_IvcmEntityForm);
  if Assigned(l_BS) and Assigned(l_BS.WindowData) then
   f_SearchContext := l_BS.WindowData.Context;
  CheckExSearchPanelVisibility;
 end;
 tvList.SelfDrawNodes := Assigned(dsDocumentList) and dsDocumentList.IsSnippet;
 if tvList.HandleAllocated then
  PostMessage(tvList.Handle, msg_vtInvalidateNCArea, 0, 0);
//#UC END# *497469C90140_497DDB2B001B_impl*
end;//TPrimListForm.NotifyDataSourceChanged

function TPrimListForm.DoSaveState(out theState: IvcmBase;
 aStateType: TvcmStateType;
 aForClone: Boolean): Boolean;
 {* Сохраняет состояние формы. Для перекрытия в потомках }
//#UC START# *49806ED503D5_497DDB2B001B_var*
var
 l_Current: Integer;
 l_TopIndex: Integer;
 l_InnerState: IvcmBase;
 l_cfState: IUnknown;
 l_cfStateMaker: IvcmState;
 l_TreeStructStateProvider: InsTreeStructStateProvider;
 l_TreeStructState: InsTreeStructState;
//#UC END# *49806ED503D5_497DDB2B001B_var*
begin
//#UC START# *49806ED503D5_497DDB2B001B_impl*
 l_Current := tvList.Current;
 l_TopIndex := tvList.TopIndex;
 theState := nil;
 l_InnerState := nil;
 l_TreeStructState := nil;
 Result := inherited DoSaveState(l_InnerState, aStateType, aForClone);
 if aForClone and tvList.IsTreeAssign then
 begin
  if Supports(tvList.TreeStruct, InsTreeStructStateProvider, l_TreeStructStateProvider) then
   l_TreeStructState := l_TreeStructStateProvider.MakeState;
   
  if Supports(cfList, IvcmState, l_cfStateMaker) then
   if l_cfStateMaker.SaveState(l_cfState, vcm_stContent) then
    theState := TPrimListFormState.Make(l_InnerState, l_cfState, l_TreeStructState,
      tvList.TopIndex, tvList.Current,
      [lfoContextFilterState, lfoTopItemIndex, lfoCurrentIndex,
      lfoTreeStructState, lfoInner], f_WasFiltered);
      
  if (theState = nil) then
   theState := TPrimListFormState.Make(l_InnerState, nil, nil, 0, 0, [lfoInner], f_WasFiltered);
 end
 else
  theState := TPrimListFormState.Make(l_InnerState, nil, nil, l_TopIndex,
   l_Current, [lfoInner, lfoTopItemIndex, lfoCurrentIndex], f_WasFiltered);
//#UC END# *49806ED503D5_497DDB2B001B_impl*
end;//TPrimListForm.DoSaveState

function TPrimListForm.DoLoadState(const aState: IvcmBase;
 aStateType: TvcmStateType;
 aClone: Boolean): Boolean;
 {* Загружает состояние формы. Для перекрытия в потомках }
//#UC START# *49807428008C_497DDB2B001B_var*
var
 l_TreeStruct: Il3SimpleTree;
 l_StateReceiver: IvcmState;
 l_State: IPrimListFormState;
 l_TreeStructState: InsTreeStructState;
 l_TreeStructStateConsumer: InsTreeStructStateConsumer;
 l_InnerState: IvcmBase;
 l_WasActive: Boolean;
//#UC END# *49807428008C_497DDB2B001B_var*
begin
//#UC START# *49807428008C_497DDB2B001B_impl*
 if (UserType = lftDrugList) and (aStateType = vcm_stContent) then
 begin
  if Supports(aState, IPrimListFormState, l_State) then
  begin
   l_InnerState := l_State.InnerState;
   if (l_State.ContextFilterState <> nil) then
   begin
    if Supports(cfList, IvcmState, l_StateReceiver) then
    begin
     // Всё ниженаписанное выглядит ужасно, но проблема в том, что
     // в TnscContextFilter написано много какого-то странного кода,
     // трогать который страшно
     // http://mdp.garant.ru/pages/viewpage.action?pageId=609593354

     tvList.TreeStruct;
     // - Иначе TreeStruct получится при отрисовке и контекстный фильтр зачем-то
     // затрёт свой контекст
     if (lfoContextFilterState in l_State.Options) then
     begin
      cfList.BeginAssignState;
      l_StateReceiver.LoadState(l_State.ContextFilterState, aStateType, aClone);
      l_WasActive := cfList.Active;
      cfList.Active := False;
      // - если будет Active - контекст почему-то будет считаться неверным
      // и его покрасят в красный цвет
      cfList.EndAssignState;
      cfList.Active := l_WasActive;
     end;
    end;
    Result := True;
   end
   else
    Result := inherited DoLoadState(l_InnerState, aStateType, aClone);
  end
  else
   Assert(False)
 end
 else
 begin
  l_InnerState := aState;
  if (not (aClone and (UserType in [lftUserCR1, lftUserCR2]) and (not IsActiveInParent))) then
   if Supports(aState, IPrimListFormState, l_State) then
   begin
    l_TreeStruct := tvList.TreeStruct;
    try
     Result := inherited DoLoadState(l_InnerState, aStateType, aClone);
     l_InnerState := l_State.InnerState;
     if (lfoCurrentIndex in l_State.Options) then
      tvList.Current := l_State.CurrentIndex;
     if (lfoTreeStructState in l_State.Options) then
      if Supports(l_TreeStruct, InsTreeStructStateConsumer, l_TreeStructStateConsumer) then
       l_TreeStructStateConsumer.AssignState(l_State.TreeStructState);
     if (lfoTopItemIndex in l_State.Options) then
      tvList.TopIndex := l_State.TopItemIndex;
     f_WasFiltered := l_State.WasFiltered;
     Exit;
    finally
     l_TreeStruct := nil;
    end;
   end;
  Result := inherited DoLoadState(l_InnerState, aStateType, aClone);
 end;
//#UC END# *49807428008C_497DDB2B001B_impl*
end;//TPrimListForm.DoLoadState

function TPrimListForm.NeedsStatusBarItems: Boolean;
 {* Определяет, что операции в статусной строке таки надо публиковать }
//#UC START# *4A8E5CEC021F_497DDB2B001B_var*
//#UC END# *4A8E5CEC021F_497DDB2B001B_var*
begin
//#UC START# *4A8E5CEC021F_497DDB2B001B_impl*
 Result := (UserType = lftNone);
//#UC END# *4A8E5CEC021F_497DDB2B001B_impl*
end;//TPrimListForm.NeedsStatusBarItems

procedure TPrimListForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_497DDB2B001B_var*
//#UC END# *4A8E8F2E0195_497DDB2B001B_var*
begin
//#UC START# *4A8E8F2E0195_497DDB2B001B_impl*
 inherited;
 ActiveControl := tvList;
 tvList.NonTrackScroll := true;
 tvList.StyleId := ev_saTxtNormalANSI;
 with ListPanel do
 begin
  Left := 0;
  Top := 0;
  Width := 399;
  Height := 493;
  Align := alClient;
  BevelOuter := bvNone;
  TabOrder := 0;
 end;//with ListPanel
 with cfList do
 begin
  Left := 0;
  Top := 0;
  Width := 399;
  Height := 35;
  ImageIndex := 77;
  ContextFilterTarget := tvList;
  OnChange := cfListChange;
  OnWrongContext := cfListWrongContext;
 end;
 with tvList do
 begin
  Left := 0;
  Top := 35;
  Width := 399;
  Height := 458;
  OnCountChanged := tvListCountChanged;
  OnAfterFirstPaint := tvListAfterFirstPaint;
  OnCurrentIndexChanged := tvListCurrentIndexChanged;
  Align := alClient;
  BorderStyle := bsNone;
  TabOrder := 0;
  MultiSelect := True;
  MultiStrokeItem := True;
  ActionElementMode := l3_amSecondSingleClick;
  NeedStatus := True;
  OnGetItemIconHint := tvListGetItemIconHint;
  OnMakeTreeSource := tvListMakeTreeSource;
  OnGetItemImage := tvListGetItemImage;
  OnActionElement := tvListActionElement;
  OnCurrentChanged := tvListCurrentChanged;
  OnTreeChanged := tvListTreeChanged;
  OnRootChanged := tvListRootChanged;
  OnSelectCountChanged := tvListSelectCountChanged;
  OnFormatStatusInfo := tvListFormatStatusInfo;
  OnNewCharPressed := tvListNewCharPressed;
  OnCheckFocusedInPaint := tvListCheckFocusedInPaint;
  OnGetNodeType := TvListGetNodeType;
  DragAndDropSupported := True;
  FooterCaption := str_ListFooterCaption.AsStr;
  OnFooterClick := tvListFooterClick;
  SettingId := 'stidListTree';
  InterRowMultiplier := 2;             
  OpenChipColor := $ADADAD; //414849886 
  OpenChipBorderColor := $ADADAD;
 end;
 with ExSearchPanel do
 begin
  Align := alTop;
  Color := clWhite;
  BorderStyle := bsNone;
  BevelOuter := bvNone;
 end;
 with ExSearchLabel do
 begin
  AutoWidth := True;
  Anchors := [akTop, akRight];
  Cursor := crHandPoint;
  Top := 0;
  Left := ExSearchPanel.ClientWidth - 15 - Width;
  OnClick := ExSearchLabelClick;
  ExSearchPanel.Height := Height + 5;
 end;
 StyleTableChanged;
//#UC END# *4A8E8F2E0195_497DDB2B001B_impl*
end;//TPrimListForm.InitControls

procedure TPrimListForm.PageActive;
//#UC START# *4C52E8030278_497DDB2B001B_var*
//#UC END# *4C52E8030278_497DDB2B001B_var*
begin
//#UC START# *4C52E8030278_497DDB2B001B_impl*
 if (dsList <> nil) then
  dsList.CurrentChanged(tvList.GetCurrentNode);
//#UC END# *4C52E8030278_497DDB2B001B_impl*
end;//TPrimListForm.PageActive

function TPrimListForm.NeedMakeHyperlinkToDocument: Boolean;
//#UC START# *53EB17EF0306_497DDB2B001B_var*
//#UC END# *53EB17EF0306_497DDB2B001B_var*
begin
//#UC START# *53EB17EF0306_497DDB2B001B_impl*
 Result := NoMoreThanOneSelected AND (not IsListEmpty);
//#UC END# *53EB17EF0306_497DDB2B001B_impl*
end;//TPrimListForm.NeedMakeHyperlinkToDocument

function TPrimListForm.IsAcceptable(aDataUpdate: Boolean): Boolean;
 {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
//#UC START# *55127A5401DE_497DDB2B001B_var*
//#UC END# *55127A5401DE_497DDB2B001B_var*
begin
//#UC START# *55127A5401DE_497DDB2B001B_impl*
 case UserType of
  lftDrugList: Result := dsList.IsDataAvailable;
 else
  Result := True;
 end;
//#UC END# *55127A5401DE_497DDB2B001B_impl*
end;//TPrimListForm.IsAcceptable

function TPrimListForm.NeedLoadFormStateForClone(const aState: IvcmBase;
 aStateType: TvcmStateType): Boolean;
//#UC START# *561CB1350027_497DDB2B001B_var*
//#UC END# *561CB1350027_497DDB2B001B_var*
begin
//#UC START# *561CB1350027_497DDB2B001B_impl*
 Result := False;
//#UC END# *561CB1350027_497DDB2B001B_impl*
end;//TPrimListForm.NeedLoadFormStateForClone

procedure TPrimListForm.ClearFields;
begin
 f_SortTypeMap := nil;
 f_SearchContext := nil;
 inherited;
end;//TPrimListForm.ClearFields

procedure TPrimListForm.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
begin
 inherited;
 if (aNew = nil) then
 begin
  dsSimpleTree := nil;
  dsList := nil;
  dsDocumentList := nil;
  sdsList := nil;
  BaseSearchSupportQuery := nil;
  WarningLocker := nil;
  ucpFilters := nil;
 end//aNew = nil
 else
 begin
  Supports(aNew, IdsSimpleTree, dsSimpleTree);
  Supports(aNew, IdsList, dsList);
  Supports(aNew, IdsDocumentList, dsDocumentList);
  aNew.CastUCC(IsdsList, sdsList);
  Supports(aNew, IucbBaseSearchSupportQuery, BaseSearchSupportQuery);
  aNew.CastUCC(InsWarningLocker, WarningLocker);
  aNew.CastUCC(IucpFilters, ucpFilters);
 end;//aNew = nil
end;//TPrimListForm.SignalDataSourceChanged

procedure TPrimListForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_File, nil);
  PublishFormEntity(en_Document, nil);
  PublishFormEntity(en_Loadable, nil);
  PublishFormEntity(en_Filterable, nil);
  PublishFormEntity(en_List, nil);
  PublishFormEntity(en_TimeMachine, nil);
  PublishFormEntity(en_Selection, nil);
  PublishFormEntity(en_LocalList, nil);
  PublishFormEntity(en_Filters, nil);
  PublishFormEntity(en_CRList, nil);
  PublishFormEntity(en_DocumentInList, nil);
  PublishFormEntity(en_SelectedDocuments, nil);
  MakeEntitySupportedByControl(en_Edit, tvList);
  MakeEntitySupportedByControl(en_File, tvList);
  MakeEntitySupportedByControl(en_List, tvList);
  MakeEntitySupportedByControl(en_Selection, tvList);
  MakeEntitySupportedByControl(en_LocalList, tvList);
  MakeEntitySupportedByControl(en_Document, tvList);
  MakeEntitySupportedByControl(en_DocumentInList, tvList);
  MakeEntitySupportedByControl(en_SelectedDocuments, tvList);
  PublishOp(en_Edit, op_Copy, Edit_Copy_Execute, Edit_Copy_Test, nil);
  PublishOp(en_Edit, op_FindContext, Edit_FindContext_Execute, Edit_FindContext_Test, nil);
  PublishOp(en_File, op_SaveToFolder, File_SaveToFolder_Execute, File_SaveToFolder_Test, nil);
  PublishOp(en_File, op_LoadFromFolder, File_LoadFromFolder_Execute, File_LoadFromFolder_Test, nil);
  PublishOp(en_Document, op_AddToControl, Document_AddToControl_Execute, Document_AddToControl_Test, Document_AddToControl_GetState);
  PublishOp(en_Document, op_GetAttributesFrmAct, Document_GetAttributesFrmAct_Execute, Document_GetAttributesFrmAct_Test, nil);
  PublishOpWithResult(en_Loadable, op_Load, Loadable_Load, nil, nil);
  PublishOp(en_Document, op_GetRelatedDocFrmAct, Document_GetRelatedDocFrmAct_Execute, Document_GetRelatedDocFrmAct_Test, nil);
  PublishOp(en_Edit, op_Undo, Edit_Undo_Execute, Edit_Undo_Test, nil);
  PublishOp(en_Edit, op_Redo, Edit_Redo_Execute, Edit_Redo_Test, nil);
  PublishOp(en_Edit, op_Deselect, Edit_Deselect_Execute, Edit_Deselect_Test, nil);
  PublishOpWithResult(en_Filterable, op_Add, Filterable_Add, nil, nil);
  PublishOpWithResult(en_Filterable, op_Delete, Filterable_Delete, nil, nil);
  PublishOpWithResult(en_List, op_GetDeList, List_GetDeList, nil, nil);
  PublishOpWithResult(en_Filterable, op_ClearAll, Filterable_ClearAll, nil, nil);
  PublishOpWithResult(en_Filterable, op_Refresh, Filterable_Refresh, nil, nil);
  PublishOpWithResult(en_TimeMachine, op_TimeMachineOffAndReset, TimeMachine_TimeMachineOffAndReset, TimeMachine_TimeMachineOffAndReset_Test, nil);
  PublishOpWithResult(en_List, op_SetCurrentVisible, List_SetCurrentVisible, nil, nil);
  PublishOp(en_TimeMachine, op_TimeMachineOnOffNew, TimeMachine_TimeMachineOnOffNew_Execute, TimeMachine_TimeMachineOnOffNew_Test, TimeMachine_TimeMachineOnOffNew_GetState);
  PublishOp(en_List, op_SwitchToFullList, List_SwitchToFullList_Execute, List_SwitchToFullList_Test, nil);
  PublishOp(en_List, op_ListInfo, List_ListInfo_Execute, List_ListInfo_Test, nil);
  ShowInContextMenu(en_List, op_ListInfo, True);
  PublishOp(en_List, op_Sort, List_Sort_Execute, List_Sort_Test, nil);
  ShowInContextMenu(en_List, op_Sort, True);
  PublishOp(en_List, op_SortDirection, List_SortDirection_Execute, List_SortDirection_Test, List_SortDirection_GetState);
  ShowInContextMenu(en_List, op_SortDirection, True);
  PublishOp(en_List, op_SpecifyList, List_SpecifyList_Execute, List_SpecifyList_Test, nil);
  ShowInContextMenu(en_List, op_SpecifyList, True);
  PublishOp(en_List, op_ExportToXML, List_ExportToXML_Execute, List_ExportToXML_Test, nil);
  ShowInContextMenu(en_List, op_ExportToXML, True);
  PublishOp(en_Filters, op_FiltersList, Filters_FiltersList_Execute, Filters_FiltersList_Test, nil);
  PublishOp(en_LocalList, op_PublishSourceSearchInList, LocalList_PublishSourceSearchInList_Execute, LocalList_PublishSourceSearchInList_Test, nil);
  ShowInContextMenu(en_LocalList, op_PublishSourceSearchInList, True);
  ShowInToolbar(en_LocalList, op_PublishSourceSearchInList, True);
  PublishOp(en_LocalList, op_Open, LocalList_Open_Execute, LocalList_Open_Test, nil);
  ShowInContextMenu(en_LocalList, op_Open, False);
  PublishOp(en_LocalList, op_SearchDrugInList, LocalList_SearchDrugInList_Execute, LocalList_SearchDrugInList_Test, nil);
  ShowInContextMenu(en_LocalList, op_SearchDrugInList, True);
  ShowInToolbar(en_LocalList, op_SearchDrugInList, True);
  PublishOp(en_Document, op_GetAnnotationDocFrmAct, Document_GetAnnotationDocFrmAct_Execute, Document_GetAnnotationDocFrmAct_Test, nil);
  PublishOp(en_Document, op_SimilarDocuments, Document_SimilarDocuments_Execute, Document_SimilarDocuments_Test, nil);
  PublishOp(en_CRList, op_SetType, CRList_SetType_Execute, CRList_SetType_Test, nil, true);
  PublishOp(en_Document, op_GetGraphicImage, Document_GetGraphicImage_Execute, Document_GetGraphicImage_Test, nil);
  PublishOp(en_LocalList, op_OpenNewWindow, LocalList_OpenNewWindow_Execute, nil, nil);
  ShowInContextMenu(en_LocalList, op_OpenNewWindow, True);
  PublishOp(en_Selection, op_CopyToNewList, Selection_CopyToNewList_Execute, Selection_CopyToNewList_Test, nil);
  ShowInContextMenu(en_Selection, op_CopyToNewList, True);
  PublishOp(en_Filters, op_Clear, Filters_Clear_Execute, nil, nil);
  ShowInContextMenu(en_Filters, op_Clear, False);
  ShowInToolbar(en_Filters, op_Clear, False);
  PublishOp(en_Selection, op_Analize, Selection_Analize_Execute, Selection_Analize_Test, nil);
  PublishOp(en_LocalList, op_SearchInList, LocalList_SearchInList_Execute, LocalList_SearchInList_Test, nil);
  ShowInContextMenu(en_LocalList, op_SearchInList, True);
  ShowInToolbar(en_LocalList, op_SearchInList, True);
  PublishOp(en_Filters, op_FiltersListOpen, Filters_FiltersListOpen_Execute, Filters_FiltersListOpen_Test, nil);
  PublishOpWithResult(en_Filters, op_InternalClear, Filters_InternalClear, nil, nil);
  PublishOpWithResult(en_Filterable, op_GetListType, Filterable_GetListType, nil, nil);
  PublishOpWithResult(en_List, op_GetDsList, List_GetDsList, nil, nil);
  PublishOp(en_List, op_Analize, List_Analize_Execute, List_Analize_Test, nil);
  ShowInContextMenu(en_List, op_Analize, True);
  PublishOp(en_List, op_AnalizeList, List_AnalizeList_Execute, List_AnalizeList_Test, nil);
  PublishOp(en_List, op_SortForReminders, List_SortForReminders_Execute, List_SortForReminders_Test, nil);
  ShowInContextMenu(en_List, op_SortForReminders, True);
  ShowInToolbar(en_List, op_SortForReminders, False);
  ContextMenuWeight(en_List, op_SortForReminders, 20);
  PublishOp(en_List, op_SortDirectionForReminders, List_SortDirectionForReminders_Execute, List_SortDirectionForReminders_Test, List_SortDirectionForReminders_GetState);
  ContextMenuWeight(en_List, op_SortDirectionForReminders, 30);
  PublishOp(en_List, op_SpecifyListForReminders, List_SpecifyListForReminders_Execute, List_SpecifyListForReminders_Test, nil);
  ShowInContextMenu(en_List, op_SpecifyListForReminders, True);
  ShowInToolbar(en_List, op_SpecifyListForReminders, False);
  ContextMenuWeight(en_List, op_SpecifyListForReminders, 70);
 end;//with Entities.Entities
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_List, op_ExportToXML, False);
 AddUserTypeExclude(lftProducedDrugsName, en_List, op_ExportToXML, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_List, op_ExportToXML, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_List, op_ExportToXML, False);
 AddUserTypeExclude(lftDrugListName, en_Edit, op_FindContext, False);
 AddUserTypeExclude(lftDrugListName, en_Document, op_AddToControl, False);
 AddUserTypeExclude(lftDrugListName, en_List, op_Sort, False);
 AddUserTypeExclude(lftDrugListName, en_List, op_SortDirection, False);
 AddUserTypeExclude(lftDrugListName, en_List, op_SpecifyList, False);
 AddUserTypeExclude(lftDrugListName, en_LocalList, op_PublishSourceSearchInList, False);
 AddUserTypeExclude(lftDrugListName, en_Document, op_GetAnnotationDocFrmAct, False);
 AddUserTypeExclude(lftDrugListName, en_Document, op_SimilarDocuments, False);
 AddUserTypeExclude(lftDrugListName, en_LocalList, op_SearchInList, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Edit, op_FindContext, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Document, op_AddToControl, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_List, op_Sort, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_List, op_SortDirection, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_List, op_SpecifyList, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_LocalList, op_PublishSourceSearchInList, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Document, op_GetAnnotationDocFrmAct, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Document, op_SimilarDocuments, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_LocalList, op_SearchInList, False);
 AddUserTypeExclude(lftProducedDrugsName, en_Edit, op_FindContext, False);
 AddUserTypeExclude(lftProducedDrugsName, en_Document, op_AddToControl, False);
 AddUserTypeExclude(lftProducedDrugsName, en_List, op_Sort, False);
 AddUserTypeExclude(lftProducedDrugsName, en_List, op_SortDirection, False);
 AddUserTypeExclude(lftProducedDrugsName, en_List, op_SpecifyList, False);
 AddUserTypeExclude(lftProducedDrugsName, en_LocalList, op_PublishSourceSearchInList, False);
 AddUserTypeExclude(lftProducedDrugsName, en_Document, op_GetAnnotationDocFrmAct, False);
 AddUserTypeExclude(lftProducedDrugsName, en_Document, op_SimilarDocuments, False);
 AddUserTypeExclude(lftProducedDrugsName, en_LocalList, op_SearchInList, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Edit, op_FindContext, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Document, op_AddToControl, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_List, op_Sort, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_List, op_SortDirection, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_List, op_SpecifyList, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_LocalList, op_PublishSourceSearchInList, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Document, op_GetAnnotationDocFrmAct, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Document, op_SimilarDocuments, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_LocalList, op_SearchInList, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Edit, op_FindContext, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Document, op_AddToControl, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_List, op_Sort, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_List, op_SortDirection, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_List, op_SpecifyList, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_LocalList, op_PublishSourceSearchInList, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Document, op_GetAnnotationDocFrmAct, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Document, op_SimilarDocuments, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_LocalList, op_SearchInList, False);
 AddUserTypeExclude(lftNoneName, en_LocalList, op_Open, False);
 AddUserTypeExclude(lftRespondentName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftCorrespondentName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftSynchroViewName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftCToPartName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftUserCR1Name, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftUserCR2Name, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftConsultationName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftSimilarDocumentsName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftDrugListName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftProducedDrugsName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftRToPartName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_TimeMachine, op_TimeMachineOffAndReset, False);
 AddUserTypeExclude(lftRespondentName, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftCorrespondentName, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftSynchroViewName, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftCToPartName, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftUserCR1Name, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftUserCR2Name, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftSimilarDocumentsName, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftDrugListName, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftProducedDrugsName, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftRToPartName, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_List, op_SetCurrentVisible, False);
 AddUserTypeExclude(lftRespondentName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftCorrespondentName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftSynchroViewName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftCToPartName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftUserCR1Name, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftUserCR2Name, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftConsultationName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftSimilarDocumentsName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftDrugListName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftProducedDrugsName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftRToPartName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_List, op_ListInfo, False);
 AddUserTypeExclude(lftRespondentName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftCorrespondentName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftSynchroViewName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftCToPartName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftUserCR1Name, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftUserCR2Name, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftSimilarDocumentsName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftProducedDrugsName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftRToPartName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(lftRespondentName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftCorrespondentName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftSynchroViewName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftCToPartName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftUserCR1Name, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftUserCR2Name, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftSimilarDocumentsName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftDrugListName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftProducedDrugsName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftRToPartName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(lftRespondentName, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftRespondentName, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftRespondentName, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftCorrespondentName, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftCorrespondentName, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftCorrespondentName, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftSynchroViewName, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftSynchroViewName, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftSynchroViewName, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftCToPartName, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftCToPartName, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftCToPartName, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftUserCR1Name, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftUserCR1Name, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftUserCR1Name, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftUserCR2Name, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftUserCR2Name, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftUserCR2Name, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftSimilarDocumentsName, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftSimilarDocumentsName, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftSimilarDocumentsName, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftProducedDrugsName, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftProducedDrugsName, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftProducedDrugsName, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftRToPartName, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftRToPartName, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftRToPartName, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_Filters, op_FiltersList, False);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_Filters, op_Clear, False);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_Filters, op_InternalClear, False);
 AddUserTypeExclude(lftNoneName, en_LocalList, op_SearchDrugInList, False);
 AddUserTypeExclude(lftRespondentName, en_LocalList, op_SearchDrugInList, False);
 AddUserTypeExclude(lftCorrespondentName, en_LocalList, op_SearchDrugInList, False);
 AddUserTypeExclude(lftSynchroViewName, en_LocalList, op_SearchDrugInList, False);
 AddUserTypeExclude(lftCToPartName, en_LocalList, op_SearchDrugInList, False);
 AddUserTypeExclude(lftUserCR1Name, en_LocalList, op_SearchDrugInList, False);
 AddUserTypeExclude(lftUserCR2Name, en_LocalList, op_SearchDrugInList, False);
 AddUserTypeExclude(lftConsultationName, en_LocalList, op_SearchDrugInList, False);
 AddUserTypeExclude(lftSimilarDocumentsName, en_LocalList, op_SearchDrugInList, False);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_LocalList, op_SearchDrugInList, False);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_LocalList, op_SearchDrugInList, False);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_LocalList, op_SearchDrugInList, False);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_LocalList, op_SearchDrugInList, False);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_LocalList, op_SearchDrugInList, False);
 AddUserTypeExclude(lftRToPartName, en_LocalList, op_SearchDrugInList, False);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_LocalList, op_SearchDrugInList, False);
 AddUserTypeExclude(lftRespondentName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftCorrespondentName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftSynchroViewName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftCToPartName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftUserCR1Name, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftUserCR2Name, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftConsultationName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftSimilarDocumentsName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftDrugListName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftProducedDrugsName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftRToPartName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_Selection, op_Analize, False);
 AddUserTypeExclude(lftRespondentName, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftRespondentName, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftCorrespondentName, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftCorrespondentName, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftSynchroViewName, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftSynchroViewName, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftCToPartName, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftCToPartName, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftUserCR1Name, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftUserCR1Name, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftUserCR2Name, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftUserCR2Name, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftConsultationName, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftConsultationName, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftSimilarDocumentsName, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftSimilarDocumentsName, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftProducedDrugsName, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftProducedDrugsName, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftRToPartName, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftRToPartName, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_Document, op_GetAttributesFrmAct, False);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_Document, op_GetRelatedDocFrmAct, False);
 AddUserTypeExclude(lftNoneName, en_CRList, op_SetType, True);
 AddUserTypeExclude(lftUserCR1Name, en_CRList, op_SetType, True);
 AddUserTypeExclude(lftUserCR2Name, en_CRList, op_SetType, True);
 AddUserTypeExclude(lftConsultationName, en_CRList, op_SetType, True);
 AddUserTypeExclude(lftSimilarDocumentsName, en_CRList, op_SetType, True);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_CRList, op_SetType, True);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_CRList, op_SetType, True);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_CRList, op_SetType, True);
 AddUserTypeExclude(lftDrugListName, en_CRList, op_SetType, True);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_CRList, op_SetType, True);
 AddUserTypeExclude(lftProducedDrugsName, en_CRList, op_SetType, True);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_CRList, op_SetType, True);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_CRList, op_SetType, True);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_CRList, op_SetType, True);
end;//TPrimListForm.InitEntities

procedure TPrimListForm.MakeControls;
begin
 inherited;
 f_ListPanel := TvtPanel.Create(Self);
 f_ListPanel.Name := 'ListPanel';
 f_ListPanel.Parent := Self;
 f_tvList := TnscDocumentListTreeView.Create(Self);
 f_tvList.Name := 'tvList';
 f_tvList.Parent := ListPanel;
 f_cfList := TnscContextFilter.Create(Self);
 f_cfList.Name := 'cfList';
 f_cfList.Parent := ListPanel;
 f_ExSearchPanel := TvtPanel.Create(Self);
 f_ExSearchPanel.Name := 'ExSearchPanel';
 f_ExSearchPanel.Parent := ListPanel;
 f_ExSearchLabel := TvtStyledFocusLabel.Create(Self);
 f_ExSearchLabel.Name := 'ExSearchLabel';
 f_ExSearchLabel.Parent := ExSearchPanel;
 f_ExSearchLabel.Caption := 'Продолжить поиск в онлайн-архивах ГАРАНТа';
end;//TPrimListForm.MakeControls

initialization
 str_ListFooterCaption.Init;
 {* Инициализация str_ListFooterCaption }
 str_lntAAC.Init;
 {* Инициализация str_lntAAC }
 str_lntBlock.Init;
 {* Инициализация str_lntBlock }
 str_lntDocActive.Init;
 {* Инициализация str_lntDocActive }
 str_lntDocPreActive.Init;
 {* Инициализация str_lntDocPreActive }
 str_lntDocAbolished.Init;
 {* Инициализация str_lntDocAbolished }
 str_lntRedaction.Init;
 {* Инициализация str_lntRedaction }
 str_lntRedactions.Init;
 {* Инициализация str_lntRedactions }
 str_lntDrugAnnuled.Init;
 {* Инициализация str_lntDrugAnnuled }
 str_lntDrugNarcotic.Init;
 {* Инициализация str_lntDrugNarcotic }
 str_lntDrugNoAnnuledNoNarcoric.Init;
 {* Инициализация str_lntDrugNoAnnuledNoNarcoric }
 str_lntFormAnnuled.Init;
 {* Инициализация str_lntFormAnnuled }
 str_lntFormRussianImportant.Init;
 {* Инициализация str_lntFormRussianImportant }
 str_lntFormNoRussianImportant.Init;
 {* Инициализация str_lntFormNoRussianImportant }
 str_lntFormRussianNoImportant.Init;
 {* Инициализация str_lntFormRussianNoImportant }
 str_lntFormNoRussianNoImportant.Init;
 {* Инициализация str_lntFormNoRussianNoImportant }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimListForm);
 {* Регистрация PrimList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
