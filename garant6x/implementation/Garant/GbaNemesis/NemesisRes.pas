unit NemesisRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/NemesisRes.pas"
// Начат: 26.08.2009 16:17
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMApplication::Class>> F1::Nemesis::Nemesis
//
// [$90440042]
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
  PrimNemesisRes,
  Classes {a},
  vcmInterfaces {a},
  vcmExternalInterfaces {a},
  CompareEditions_FormDefinitions_Controls,
  DocumentUnit,
  eeInterfaces,
  EditionsInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx,
  PrimLeftEdition_utLeftEdition_UserType,
  PrimRightEdition_utRightEdition_UserType,
  PrimEditionsContainer_utEditionsContainer_UserType
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  bsTypesNew
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If defined(Nemesis)}
  ,
  nscEditor
  {$IfEnd} //Nemesis
  ,
  vtPanel,
  vtFocusLabel
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  ,
  vtSizeablePanel,
  vtProportionalPanel,
  Common_FormDefinitions_Controls,
  DocumentInterfaces,
  DocumentAndListInterfaces,
  DocumentUserTypes_dftDocument_UserType,
  WorkWithDocumentInterfaces,
  BaloonWarningUserTypes_WarnJuror_UserType,
  BaloonWarningUserTypes_WarnPreActive_UserType,
  BaloonWarningUserTypes_WarnIsAbolished_UserType,
  BaloonWarningUserTypes_WarnOnControl_UserType,
  BaloonWarningUserTypes_WarnInactualDocument_UserType,
  BaloonWarningUserTypes_WarnTimeMachineOn_UserType,
  BaloonWarningUserTypes_WarnRedaction_UserType,
  BaloonWarningUserTypes_WarnTimeMachineWarning_UserType,
  BaloonWarningUserTypes_WarnTimeMachineException_UserType,
  fsAbstractDocument,
  DocumentWithFlashUserTypes_dwftMain_UserType,
  DocInfoInterfaces,
  DocumentDomainInterfaces
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  NavigationInterfaces,
  nsLogEvent,
  PresentationInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmContainerForm
  {$IfEnd} //not NoVCM
  ,
  eeSubPanel,
  vtScrollBar
  {$If defined(Nemesis)}
  ,
  nscReminder
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscRemindersLine
  {$IfEnd} //Nemesis
  ,
  nscTreeViewWithAdapterDragDrop
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  vtLister
  {$If defined(Nemesis)}
  ,
  nscTasksPanelView
  {$IfEnd} //Nemesis
  
  {$If not defined(NoImageEn)}
  ,
  imageenview
  {$IfEnd} //not NoImageEn
  
  {$If not defined(NoImageEn)}
  ,
  imageenio
  {$IfEnd} //not NoImageEn
  
  {$If not defined(NoImageEn)}
  ,
  imageenproc
  {$IfEnd} //not NoImageEn
  ,
  eeMemoWithEditOperations
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel,
  vtCheckBox,
  vtDblClickDateEdit,
  vtButton,
  vtRadioButton,
  BaseTypesUnit,
  DynamicTreeUnit,
  l3Interfaces,
  l3TreeInterfaces,
  bsTypes,
  DictionInterfaces,
  CommonDictionInterfaces,
  DocumentUserTypes_dftDictEntry_UserType,
  DocumentUserTypes_dftDictSubEntry_UserType,
  AttributesUserTypes_fDocAttribute_UserType,
  PrimDiction_utDiction_UserType,
  BaseDocumentWithAttributesInterfaces,
  DictionContainerUserTypes_slqtDiction_UserType,
  PrimChild_cutForDiction_UserType,
  F1Like_FormDefinitions_Controls,
  InternetAgentInterfaces,
  FoldersInterfaces,
  PrimFolders_utFolders_UserType,
  PrimFoldersTree_utFoldersTree_UserType,
  PrimFoldersElementInfo_utFoldersProperty_UserType,
  BaseTreeSupportUnit,
  FoldersUnit,
  nsFormCoordinates,
  FoldersDomainInterfaces,
  nsTypes
  {$If defined(Nemesis)}
  ,
  nscComboBoxWithReadOnly
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  vcmModule
  {$IfEnd} //not NoVCM
  ,
  l3PureMixIns,
  DocumentUserTypes_dftDocSynchroView_UserType,
  DocumentUserTypes_dftRelatedSynchroView_UserType,
  DocumentUserTypes_dftAnnotationSynchroView_UserType,
  ListUserTypes_lftNone_UserType,
  ListUserTypes_lftSimilarDocumentsSynchroView_UserType,
  ListUserTypes_lftCorrespondentsSynchroForm_UserType,
  ListUserTypes_lftRespondentsSynchroForm_UserType,
  ListUserTypes_lftUserCRList1_SynchorForm_UserType,
  ListUserTypes_lftUserCRList2_SynchorForm_UserType,
  ListInfoUserTypes_liListInfo_UserType,
  AttributesUserTypes_fAttributeSynchroView_UserType,
  SynchroViewUserTypes_svSynchroView_UserType,
  DocumentWithFlashUserTypes_dwftSynchro_UserType,
  FiltersUserTypes_utFilters_UserType,
  WorkWithListInterfaces,
  BaloonWarningUserTypes_remListModified_UserType,
  BaloonWarningUserTypes_remListFiltered_UserType,
  BaloonWarningUserTypes_remTimeMachineWarning_UserType,
  ListAnalizeUserTypes_Analize_UserType,
  bsOpenListInfo,
  PrimPrimListInterfaces,
  nscDocumentListTreeView
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  ,
  eeTreeView,
  AutoreferatInterfaces,
  DocumentUserTypes_dftAutoreferat_UserType,
  PrimNewsLine_nltMain_UserType,
  DocumentUserTypes_dftAutoreferatAfterSearch_UserType,
  MonitoringUnit,
  PrimMonitorings_Module,
  l3ProtoObject,
  f1StartupCompletedService,
  nscTreeViewForNewsLine,
  l3MessageID,
  SearchUnit,
  Messages,
  PostingOrder_FormDefinitions_Controls,
  ConsultationDomainInterfaces,
  ConsultationInterfaces,
  PrimSaveLoadUserTypes_slqtConsult_UserType,
  PrimQueryCard_utqcSendConsultation_UserType,
  Search_FormDefinitions_Controls,
  ConsultingUnit,
  DocumentUserTypes_dftConsultation_UserType,
  ListUserTypes_lftConsultation_UserType,
  PrimConsultationMark_utcmMain_UserType,
  vtGroupBox,
  SimpleListInterfaces,
  FiltersUnit,
  ChatInterfaces,
  ChatTypes
  {$If defined(Nemesis)}
  ,
  nscChatMemo
  {$IfEnd} //Nemesis
  ,
  WorkJournalInterfaces,
  SearchInterfaces,
  ConfigInterfaces,
  l3PrinterInterfaces,
  l3Tree_TLB,
  UnderControlUnit,
  AdapterFacade,
  ElPopBtn
  {$If not defined(NoVCL)}
  ,
  ComCtrls
  {$IfEnd} //not NoVCL
  ,
  DocumentUserTypes_dftTips_UserType,
  PrimCommonDiction_utTips_UserType,
  DayTipsInterfaces,
  DocumentUserTypes_dftMedDictEntry_UserType,
  PrimCommonDiction_utMedicDiction_UserType,
  DictionContainerUserTypes_slqtMedicDiction_UserType,
  MedicInterfaces,
  DocumentUserTypes_dftMedicFirm_UserType,
  ListUserTypes_lftProducedDrugs_UserType,
  DocumentUserTypes_dftDrug_UserType,
  ListUserTypes_lftDrugInternationalNameSynonyms_UserType,
  ContentsUserTypes_utDrugContents_UserType,
  DocumentUserTypes_dftDrugSynchroView_UserType,
  ListUserTypes_lftDrugList_UserType,
  ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType,
  PrimMedicListSynchroView_mlsfDrugList_UserType,
  DocumentUserTypes_dftMedicFirmSynchroView_UserType,
  ListUserTypes_lftProducedDrugsSynchroForm_UserType,
  PrimMedicListSynchroView_mlsfMedicFirm_UserType,
  PrimMedicFirmList_mflMain_UserType,
  InpharmInterfaces,
  InpharmMainMenu_ut_mmmMain_UserType
  {$If defined(Nemesis)}
  ,
  nscHideField
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTreeViewHotTruck
  {$IfEnd} //Nemesis
  ,
  MainMenuUnit,
  nscSimpleEditor
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  vtComboBoxQS,
  vtColorBox,
  eeEditorWithoutOperations
  {$If defined(Nemesis)}
  ,
  nscFocusLabel
  {$IfEnd} //Nemesis
  ,
  PrimBaseSearchInterfaces,
  BaseSearchInterfaces
  {$If defined(Nemesis)}
  ,
  nscLister
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTreeComboWithHistoryAndOperations
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVGScene)}
  ,
  vg_controls
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_listbox
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_objects
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_scene
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_layouts
  {$IfEnd} //not NoVGScene
  ,
  ChangesBetweenEditionsInterfaces,
  PrimChangesBetweenEditons_DocumentChanges_UserType,
  QueryCardInterfaces,
  DynamicDocListUnit,
  PrimSaveLoadUserTypes_slqtKW_UserType,
  PrimAttributeSelect_utSingleSearch_UserType,
  PrimTreeAttributeSelect_astNone_UserType,
  PrimTreeAttributeFirstLevel_flSituation_UserType,
  PrimSelectedAttributes_utSelectedAttributes_UserType,
  SearchLite_FormDefinitions_Controls,
  PrimSaveLoadUserTypes_slqtFilters_UserType,
  nsQueryInterfaces,
  DocumentUserTypes_dftAACContentsLeft_UserType,
  DocumentUserTypes_dftAACContentsRight_UserType,
  AACContainerPrim_AACContentsContainer_UserType,
  AACContainerPrim_AACContainer_UserType,
  DocumentUserTypes_dftAACLeft_UserType,
  DocumentUserTypes_dftAACRight_UserType,
  nscSimpleEditorForDialogs,
  vcmMainForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
TNemesisRes = {final} class(TPrimNemesisRes)
 {* [$90440042] }
protected
   procedure RegisterFormSetFactories; override;
   class procedure RegisterModules(aMain: TvcmMainForm); override;
   procedure Loaded; override;
 public
 // modules operations
   class procedure MakeCompareEditions(const aDoc: IDocument;
     const aPara: IeeLeafPara;
     aEditionForCompare: Integer;
     const aDocumentForReturn: TnsDocumentForReturnInfo;
     const aContainer: IvcmContainer = nil); overload;
     {* Создаёт представление прецедента "Сравнение редакций" }
   class procedure MakeCompareEditions(const aDoc: IDocument;
     const aPara: IeeLeafPara;
     const aContainer: IvcmContainer = nil); overload;
   class procedure MakeCompareEditions(const aLeft: IDocument;
     const aRight: IDocument;
     const aPara: IeeLeafPara;
     const aContainer: IvcmContainer = nil); overload;
   class procedure MakeCompareEditions(const aDoc: IDocument;
     const aPara: IeeLeafPara;
     aEditionForCompare: Integer;
     const aContainer: IvcmContainer = nil); overload;
   class procedure MakeCompareEditions(const aLeft: IDocument;
     const aRight: IDocument;
     const aParaForPositionning: IeeLeafPara;
     const aDocumentForReturn: IDocument;
     const aParaForReturn: IeeLeafPara;
     const aContainer: IvcmContainer = nil); overload;
   class procedure MakeCompareEditions(const aLeft: IDocument;
     const aRight: IDocument;
     const aPosition: TbsDocPos;
     const aDocumentForReturn: IDocument;
     const aParaForReturn: IeeLeafPara;
     const aContainer: IvcmContainer = nil); overload;
   class procedure OpenDocument(const aDocInfo: IdeDocInfo;
     const aContainer: IvcmContainer);
     {* Открывает документ }
   class function OpenEntityAsDocument(const anEntity: IUnknown;
     const aContainer: IvcmContainer): IDocument;
   class function SafeOpenDocument(const aBaseEntity: IUnknown): IDocument;
   class procedure OpenDocumentWithCheck(const aDocInfo: IdeDocInfo;
     const aContainer: IvcmContainer);
   class function OpenExternalObject(const aContainer: IvcmContainer;
     const aData: InsLinkedObjectData): IvcmEntityForm;
   class function OpenPicture(const aContainer: IvcmContainer;
     const aData: InsLinkedObjectData): IvcmEntityForm;
   class function OpenPictureInfo(const aContainer: IvcmContainer;
     const aData: InsLinkedObjectDescription): IvcmEntityForm;
   class function OpenTurnOnTimeMachine(const anIntf: InsTurnOnTimeMachine): IvcmEntityForm;
   class function OpenEditionsListModal(const anEditionsHolder: IsdsEditionsHolder;
     const anAggregate: IvcmAggregate): IvcmEntityForm;
   class function MakeBaloonForm(aCaller: TvcmContainerForm;
     aUserType: TvcmEffectiveUserType;
     const aWarning: IdsWarning): IvcmEntityForm;
   class function DocumentShowChangesInfoSetting: Boolean;
     {* Метод для получения значения настройки "Показывать историю изменений в документе" }
   class procedure WriteDocumentShowChangesInfoSetting(aValue: Boolean);
     {* Метод для записи значения настройки "Показывать историю изменений в документе" }
   class procedure OpenTermByContext(const aContext: Il3CString;
     aLanguage: TbsLanguage);
     {* Открывает термин по подстроке }
   class procedure OpenDictionary(const aDocInfo: IdeDocInfo;
     const aContainer: IvcmContainer);
     {* Открывает толковый словарь }
   class procedure MakeInternetAgent(const anURL: Il3CString;
     const aContainer: IvcmContainer);
     {* Создаёт область вывода Интернет-агента }
   class function OpenFolders(const aContainer: IvcmContainer;
     aCanCreate: Boolean): IvcmEntityForm;
   class procedure CloseFolders(const aContainer: IvcmContainer);
   class procedure TryOpenConsultationAnswer(const aContainer: IvcmContainer);
   class procedure RefreshStructure(const aNode: INode;
     aStatus: TNotifyStatus);
   class function EditInfoOpen(aIsNewFolder: Boolean;
     const aNode: IeeNode;
     const aCoords: InsFormCoordinates): Integer;
   class procedure LoadOpen(const aForm: IvcmEntityForm;
     const aData: InsFolderFilterInfo);
   class procedure SelectOpen(const aForm: IvcmEntityForm;
     const aFilterInfo: InsFolderFilterInfo;
     const aCaption: TvcmStringID);
   class procedure SelectOpenWithOperation(const aForm: IvcmEntityForm;
     const aFilterInfo: InsFolderFilterInfo;
     const aCaption: TvcmStringID;
     anOp: TListLogicOperation);
   class procedure SelectOpenWithUserData(const aForm: IvcmEntityForm;
     const aFilterInfo: InsFolderFilterInfo;
     const aCaption: TvcmStringID;
     const aUserData: IUnknown);
   class function SaveOpen(const aForm: IvcmEntityForm;
     const aFilterInfo: InsFolderFilterInfo;
     anElementType: TFoldersElementType;
     const anEntity: IEntityBase;
     aSaveAs: Boolean): Integer;
   class procedure MakeListAnalizer(const aTree: Il3SimpleTree);
   class procedure OpenList(const aList: IdeList;
     const aContainer: IvcmContainer);
     {* Открывает список в указанном контейнере }
   class procedure OpenListWithReplace(const aList: IdeList;
     const aContainer: IvcmContainer);
     {* Открывает список в указанном контейнере. БЕЗ сохранения в историю. [$164601301] }
   class procedure OpenAutoreferat(const aDoc: IDocument;
     const aContainer: IvcmContainer);
     {* Открывает автореферат }
   class procedure OpenAutoreferatAfterSearch(const aList: IMonitoringList;
     const aContainer: IvcmContainer);
   class function OpenNewsLine: IvcmEntityForm;
   class function OpenPostingOrder(const aQuery: IQuery;
     const aContainer: IvcmContainer = nil): IvcmEntityForm;
   class procedure SavePostingList;
   class procedure CheckHistory;
     {* пробуем возвратиться по истории, если активна форма предварительного просмотра }
   class function StartOpen(const aContainer: IvcmContainer;
     aNewTab: Boolean): IvcmEntityForm;
   class procedure SavePostList;
     {* Сохранить индивидуальные ленты в файл }
   class function CanSavePostList: Boolean;
     {* Можно ли сохранить индивидуальные ленты в файл }
   class procedure GiveMarkOnConsultation(const aNode: Il3SimpleNode);
   class procedure OpenSendConsultation(const aQuery: IQuery);
   class procedure OpenEntityAsConsultation(const aCons: IUnknown;
     const aContainer: IvcmContainer);
   class procedure OpenConsultation(const aCons: IbsConsultation;
     const aContainer: IvcmContainer);
   class procedure FiltersOpen(const aData: IucpFilters);
   class procedure OldSchoolFiltersOpen(const anAggregate: IvcmAggregate;
     const aContainer: IvcmContainer;
     anOwner: TComponent);
   class function CreateFilter(const aQuery: IQuery): Integer;
   class procedure RenameFilter(const aFilter: IFilterFromQuery);
   class function MakeChatDispatcher: IbsChatDispatcher;
   class function OpenChatWindow(anUID: TbsUserID;
     const aName: Il3CString): IvcmEntityForm;
   class function OpenAddUserDialog: IvcmEntityForm;
   class function OpenHistoryWindow(anUID: TbsUserID;
     const aName: Il3CString): IvcmEntityForm;
   class function MakeWorkJournal: IbsWorkJournal;
   class function MakeProgressIndicator(const aProgress: InsProgressIndicator;
     const aCaption: Il3CString;
     aMaxCount: Integer): IvcmEntityForm;
   class procedure CloseNavigator(const aContainer: IvcmContainer);
   class procedure CloseTasksPanel(const aContainer: IvcmContainer);
   class procedure FromPrinterSettings(const aPrinter: Il3Printer);
     {* Считать настройки из принтера }
   class procedure ToPrinterSettings(const aPrinter: Il3Printer);
     {* Записать настройки в принтер }
   class procedure About;
     {* Выводит диалог "О программе" }
   class procedure ApplicationActivate;
   class procedure OpenRubricatorOnStart(const aContainer: IvcmContainer);
   class procedure OpenNewDocs(const aContainer: IvcmContainer);
   class procedure GetNavigator(const anAggregate: IvcmAggregate;
     const aContainer: IvcmContainer);
     {* Меню (вкладка) }
   class procedure OpenTasksPanel(const aContainer: IvcmContainer);
   class procedure AddDocumentToControl(const aDocument: IDocument);
     {* Поставить документ на контроль }
   class procedure AddToControl(const aControllable: IControllable);
     {* Поставить объект на контроль }
   class procedure DeleteDocumentFromControl(const aDocument: IDocument);
     {* Снять документ с контроля }
   class procedure DeleteFromControl(const aControllable: IControllable);
     {* Снять объект с контроля }
   class function IsUnderControl(const aDoc: IDocument): Boolean;
     {* Находится ли документ на контроле }
   class function IsCurEditionActual(const aState: IDocumentState): Boolean; overload;
   class function IsCurEditionActual(const aDocument: IDocument): Boolean; overload;
   class function GetCurEditionDate(const aDocument: IDocument): AdapterDate;
   class function OpenTurnOffTimeMachine(const anIntf: InsTurnOffTimeMachine): IvcmEntityForm;
   class procedure OpenTip(const aDocInfo: IdeDocInfo;
     const aContainer: IvcmContainer);
     {* Открывает совет дня }
   class function ShowDayTipsAtStartup: IvcmEntityForm;
   class procedure OpenMedicDiction(const aDocInfo: IdeDocInfo;
     const aContainer: IvcmContainer);
   class procedure OpenMedicFirmDocument(const aDocInfo: IdeDocInfo;
     const aContainer: IvcmContainer);
   class procedure OpenDrugDocument(const aDocInfo: IdeDocInfo;
     const aContainer: IvcmContainer);
   class procedure OpenDrugList(const aList: IdeList;
     const aContainer: IvcmContainer);
   class procedure MedicFirms(const aContainer: IvcmContainer);
   class procedure OpenInpharmMainMenu(const aContainer: IvcmContainer);
   class procedure OpenDrugListIfNeeded(const aContainer: IvcmContainer);
   class function OpenRubricator(const aNode: Il3SimpleNode;
     const aRootToKeep: INodeBase;
     const aMenuSectionItemToKeep: ISectionItem;
     aNeedsSheet: Boolean;
     const anAggregate: IvcmAggregate;
     const aContainer: IvcmContainer): IvcmEntityForm;
   class function OpenStyleEditorAsModal(const aData: InsStyleTableSettingsInfo): Integer;
   class procedure CloseConfList(const aContainer: IvcmContainer);
     {* Закрыть список конфигураций }
   class function LoadSettings(const anAggregate: IvcmAggregate;
     const aData: InsConfigSettingsInfo): IvcmEntityForm;
     {* Открыть настройки }
   class procedure OpenConfList(const aContainer: IvcmContainer);
   class procedure OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
   class function MainMenuChangeableMainMenuTypeSetting: Integer;
     {* Метод для получения значения настройки "Тип изменяемой части основного меню" }
   class procedure WriteMainMenuChangeableMainMenuTypeSetting(aValue: Integer);
     {* Метод для записи значения настройки "Тип изменяемой части основного меню" }
   class procedure TryAnotherBaseSearch(const aContainer: IvcmContainer;
     const aProcessor: InsBaseSearchResultProcessor;
     TryFullList: Boolean = False);
   class procedure OpenBaseSearch(OpenKind: TnsBaseSearchOpenKind;
     const aQuery: IQuery);
   class function MakeBaseSearchWindow(const aContainer: IvcmContainer;
     const aData: InsBaseSearcherWindowData;
     aZoneType: TvcmZoneType): IvcmEntityForm;
   class procedure BaseSearchCheckFragmentsCount(const aContainer: IvcmContainer);
   class procedure CheckBaseSearchDataReady(const aContainer: IvcmContainer);
   class procedure BaseSearchCheckFindBack(const aContainer: IvcmContainer);
   class function MakeBaseSearchCard(const aContainer: IvcmContainer): IvcmEntityForm;
   class procedure CloseUnderControl(const aContainer: IvcmContainer);
   class procedure OpenUnderControl(const aContainer: IvcmContainer);
   class procedure BuildUnderControlList(const aContainer: IvcmContainer);
   class procedure AddControlledObject(const aData: IControllable);
   class procedure DeleteControlledObject(const aData: IControllable);
   class procedure MarkControlledAsOpen(const aData: IControllable);
   class procedure DropChangeStatusToOpened(const aForm: IvcmEntityForm);
   class procedure ViewChangedFragments(const aLeft: IDocument;
     const aRight: IDocument);
   class procedure ViewChangedFragmentsForPrevEdition(const aDocument: IDocument);
     {* Просмотр изменёных фрагментов в сравнении с предыдущей редакцией }
   class function OpenLegislationReview(const aQuery: IQuery): IvcmEntityForm;
     {* открыть Обзор изменений законодательства }
   class function OpenFiltersForm(const aData: IdeFilter): IvcmEntityForm;
     {* Открывает форму фильтров }
   class procedure MakeNewFilter(aListType: TbsListType);
     {* Вызывает форму создания нового фильтра }
   class procedure InpharmSearch(const aQuery: IQuery;
     const aList: IDynList;
     const aContainer: IvcmContainer);
     {* Поиск лекарственных средств }
   class procedure PublishSourceSearch(const aQuery: IQuery;
     const aList: IDynList);
   class function DateQuery(const aCaller: IvcmEntityForm;
     const aData: IqaDateReqDataHolder): IvcmEntityForm;
   class procedure OpenKeyWord(const aQuery: IQuery;
     const aContainer: IvcmContainer);
     {* открыть ППС }
   class procedure EditFilter(const aFilter: IdeFilter;
     anItemIndex: Integer);
     {* Редактироваить фильтр }
   class procedure AttributeSearch(const aQuery: IQuery;
     const aList: IDynList;
     const aContainer: IvcmContainer);
   class procedure OpenTaxesPublishSearch(const aPublishSearchTag: Il3CString);
     {* СМИ по налогам и бухучёту }
   class procedure OpenSituationCard(const aQuery: IQuery);
     {* открыть ППС 6.х }
   class procedure OpenOldSituationCard(const aQuery: IQuery;
     const aContainer: IvcmContainer);
     {* открыть ППС 5.х }
   class procedure OpenPharmPublishSearch;
     {* Сигнатура метода OpenPharmPublishSearch }
   class procedure OpenPharmLegislationReview;
     {* Сигнатура метода OpenPharmLegislationReview }
   class procedure MakeAAC(const aDocInfo: IdeDocInfo;
     const aContainer: IvcmContainer);
     {* Создаёт сборку для документа ААК }
   class procedure MakeAACContents(const aDocInfo: IdeDocInfo;
     const aContainer: IvcmContainer);
     {* Создаёт сборку для документа ОГЛАВЛЕНИЯ ААК }
 public
 // operations codes
   class function opcode_Document_ShowJurorComments : TvcmOpID;
     { Документ -> Показать/скрыть комментарии ГАРАНТа }
   class function opcode_Document_ShowUserComments : TvcmOpID;
     { Документ -> Показать/скрыть мои комментарии }
   class function opcode_Document_ShowVersionComments : TvcmOpID;
     { Документ -> Включить/выключить информацию об изменениях документа }
   class function opcode_Finder_GotoPara : TvcmOpID;
     { Инструмент для поиска -> Перейти к параграфу по номеру }
   class function opcode_Finder_DisableForceDrawFocusRect : TvcmOpID;
     { Инструмент для поиска -> Запрещает рисование фокусной рамки }
   class function opcode_File_Print : TvcmOpID;
     { Файл -> Печать }
   class function opcode_File_PrintDialog : TvcmOpID;
     { Файл -> Печать... }
   class function opcode_File_PrintPreview : TvcmOpID;
     { Файл -> Предварительный просмотр }
   class function opcode_File_Save : TvcmOpID;
     { Файл -> Сохранить }
   class function opcode_Document_OpenEditionLocalLink : TvcmOpID;
     {  -> Переход по локальной ссылке на редакцию }
   class function opcode_ControlCenter_Refresh : TvcmOpID;
     {  ->  }
   class function opcode_Document_SetPosition : TvcmOpID;
     {  ->  }
   class function opcode_HyperLink_Open : TvcmOpID;
     { Гиперссылка ->  }
   class function opcode_HyperLink_OpenNewWindow : TvcmOpID;
     { Гиперссылка ->  }
   class function opcode_HyperLink_NextHyperLink : TvcmOpID;
     { Гиперссылка ->  }
   class function opcode_HyperLink_PrevHyperLink : TvcmOpID;
     { Гиперссылка ->  }
   class function opcode_HyperLink_OpenInNewTab : TvcmOpID;
     { Гиперссылка ->  }
   class function opcode_HyperLink_OpenScriptHyperLink : TvcmOpID;
     { Гиперссылка ->  }
   class function opcode_HyperLink_NavigateInternetHyperlink : TvcmOpID;
     { Гиперссылка -> Перейти по гиперссылке }
   class function opcode_HyperLink_Delete : TvcmOpID;
     { Гиперссылка ->  }
   class function opcode_RightEdition_ReturnToDocument : TvcmOpID;
     { Текущая редакция -> Вернуться в текст документа }
   class function opcode_RightEdition_SetFocusToText : TvcmOpID;
     { Текущая редакция -> Устанавливает фокус тексту }
   class function opcode_RightEdition_IsCurrentPara : TvcmOpID;
     { Текущая редакция -> Является ли параграф текущим }
   class function opcode_Document_GetParaForPositionning : TvcmOpID;
     {  ->  }
   class function opcode_Edition_PrevChange : TvcmOpID;
     { Редакция -> Предыдущее изменение }
   class function opcode_Edition_NextChange : TvcmOpID;
     { Редакция -> Следующее изменение }
   class function opcode_Edition_ReturnToDocument : TvcmOpID;
     { Редакция -> Вернуться в текст документа }
   class function opcode_Document_ViewChangedFragments : TvcmOpID;
     { Документ -> Обзор изменений документа }
   class function opcode_Redactions_OpenRedactionListFrmAct : TvcmOpID;
     {  -> Список редакций }
   class function opcode_Redactions_RedactionOnID : TvcmOpID;
     {  ->  }
   class function opcode_Redactions_ActualRedaction : TvcmOpID;
     {  ->  }
   class function opcode_Redactions_PrevRedaction : TvcmOpID;
     {  ->  }
   class function opcode_Redactions_NextRedaction : TvcmOpID;
     {  ->  }
   class function opcode_Scalable_ChangeScale : TvcmOpID;
     { Масштабируемый объект -> Изменить масштаб }
   class function opcode_Scalable_CanChangeScale : TvcmOpID;
     { Масштабируемый объект -> Масштабирование запрещено }
   class function mod_opcode_InternetAgent_InternetAgent : TvcmMOpID;
     { Модуль для [Интернет-агента|$144575249] -> Новости онлайн }
   class function opcode_Result_Cancel : TvcmOpID;
     { Результат диалога -> Отмена }
   class function opcode_FoldersControl_EditElement : TvcmOpID;
     { Управление папками -> Начать редактирование элемента }
   class function opcode_FoldersControl_DeleteElement : TvcmOpID;
     { Управление папками -> Удалить элемент }
   class function opcode_Result_Ok : TvcmOpID;
     { Результат диалога -> OK }
   class function opcode_AdditionInfo_Show : TvcmOpID;
     {  ->  }
   class function opcode_AdditionInfo_Hide : TvcmOpID;
     {  ->  }
   class function opcode_AdditionInfo_SetCaption : TvcmOpID;
     {  ->  }
   class function opcode_AdditionInfo_Close : TvcmOpID;
     {  ->  }
   class function opcode_Switcher_BecomeActive : TvcmOpID;
     {  ->  }
   class function opcode_ResultExt_Ok : TvcmOpID;
     {  -> OK }
   class function opcode_ResultExt_Append : TvcmOpID;
     {  -> Добавить }
   class function opcode_ResultExt_Cancel : TvcmOpID;
     {  -> Отмена }
   class function opcode_FolderElement_SetState : TvcmOpID;
     {  ->  }
   class function opcode_Tree_ExpandAll : TvcmOpID;
     { Дерево -> Развернуть все }
   class function opcode_Tree_CollapseAll : TvcmOpID;
     { Дерево -> Свернуть все }
   class function opcode_Tree_Wrap : TvcmOpID;
     { Дерево -> Перенос по словам }
   class function opcode_FolderElement_InternalEditByFoldersNode : TvcmOpID;
     { Элемент папок -> Редактирование элемента }
   class function opcode_FolderElement_InternalDelete : TvcmOpID;
     { Элемент папок -> Удаляет элемент папок }
   class function opcode_FolderElement_InternalEdit : TvcmOpID;
     { Элемент папок ->  }
   class function opcode_FolderElement_DisableFilter : TvcmOpID;
     { Элемент папок ->  }
   class function opcode_SavedQuery_SetFilterState : TvcmOpID;
     {  ->  }
   class function opcode_Folders_SetCurrent : TvcmOpID;
     {  ->  }
   class function opcode_Folders_FiltrateByFilterInfo : TvcmOpID;
     {  ->  }
   class function opcode_Folders_TryOpenConsultationAnswer : TvcmOpID;
     {  ->  }
   class function opcode_Folders_OpenMyConsultations : TvcmOpID;
     {  ->  }
   class function opcode_Folders_SetInfoContent : TvcmOpID;
     {  ->  }
   class function opcode_FolderElement_GetState : TvcmOpID;
     { Элемент папок -> Возвращает статус элемента }
   class function opcode_FolderElement_SetLoadInfo : TvcmOpID;
     { Элемент папок -> Устанавливает параметры элемента }
   class function opcode_FolderElement_SetContent : TvcmOpID;
     { Элемент папок -> SetContent }
   class function opcode_FolderElement_SetSaveInfo : TvcmOpID;
     { Элемент папок ->  }
   class function opcode_FolderElement_ResetModificationOnDelete : TvcmOpID;
     { Элемент папок ->  }
   class function opcode_FolderElement_SetFocus : TvcmOpID;
     { Элемент папок ->  }
   class function opcode_FolderElement_Redraw : TvcmOpID;
     { Элемент папок ->  }
   class function opcode_FolderElement_DisableSecurityPage : TvcmOpID;
     { Элемент папок ->  }
   class function opcode_UsersRights_UpdateRights : TvcmOpID;
     {  ->  }
   class function opcode_UsersRights_FolderShareChanged : TvcmOpID;
     {  ->  }
   class function opcode_Result_ExternalOk : TvcmOpID;
     {  ->  }
   class function opcode_Loadable_Load : TvcmOpID;
     { Это первый кандидат на превращение в Facet. Который нужно вызвать вот тут:
f_RequestingForm.Entity.Operation(op_Loadable_Load, l_Params).Done -> Коллеги, кто может описать этот метод? }
   class function opcode_Document_SetActive : TvcmOpID;
     {  ->  }
   class function opcode_Document_ExportBlock : TvcmOpID;
     {  ->  }
   class function opcode_Document_GetCurrentPosition : TvcmOpID;
     {  ->  }
   class function opcode_Document_SelectBlock : TvcmOpID;
     {  ->  }
   class function opcode_Document_CopyBlock : TvcmOpID;
     {  ->  }
   class function opcode_Document_PrintBlock : TvcmOpID;
     {  ->  }
   class function opcode_Document_PrintDialogBlock : TvcmOpID;
     {  ->  }
   class function opcode_Document_PreviewBlock : TvcmOpID;
     {  ->  }
   class function opcode_Document_ShowRespondentListToPart : TvcmOpID;
     {  ->  }
   class function opcode_Document_ShowCorrespondentListToPart : TvcmOpID;
     {  ->  }
   class function opcode_Document_ModifyBookmarkNotify : TvcmOpID;
     {  ->  }
   class function opcode_Document_AddBookmarkFromContents : TvcmOpID;
     {  ->  }
   class function opcode_Document_OpenNotSureTopic : TvcmOpID;
     {  ->  }
   class function opcode_Document_GotoPara : TvcmOpID;
     {  ->  }
   class function mod_opcode_Folders_MyInformation : TvcmMOpID;
     {  -> Моя информация }
   class function mod_opcode_Folders_MyConsultations : TvcmMOpID;
     {  -> Мои консультации }
   class function mod_opcode_Folders_UnderControlOpenFrmAct : TvcmMOpID;
     {  -> Документы на контроле }
   class function mod_opcode_Folders_OpenFrmAct : TvcmMOpID;
     {  -> Мои документы }
   class function opcode_List_SetNewContent : TvcmOpID;
     {  ->  }
   class function opcode_Result_OkExt : TvcmOpID;
     { Результат диалога -> OK }
   class function mod_opcode_Chat_OpenContactList : TvcmMOpID;
     {  ->  }
   class function mod_opcode_WorkJournal_OpenJournal : TvcmMOpID;
     {  ->  }
   class function opcode_DateInterval_OpenInt : TvcmOpID;
     {  ->  }
   class function opcode_Form_RequestClose : TvcmOpID;
     {  ->  }
   class function mod_opcode_Monitorings_OpenNewsLine : TvcmMOpID;
     {  -> Новостная лента }
   class function mod_opcode_Monitorings_OpenLegislationReview : TvcmMOpID;
     {  -> Обзор изменений законодательства }
   class function opcode_SearchSupport_ActivatePostingsListForm : TvcmOpID;
     {  ->  }
   class function mod_opcode_Common_ComplectInfo : TvcmMOpID;
     { "Общий" только для F1 -> Информация о комплекте }
   class function mod_opcode_Common_PageSetup : TvcmMOpID;
     { "Общий" только для F1 -> Настройка страницы... }
   class function mod_opcode_Common_ShowEULA : TvcmMOpID;
     { "Общий" только для F1 -> Условия использования }
   class function mod_opcode_Common_OpenMainMenuByButton : TvcmMOpID;
     { "Общий" только для F1 -> Основное меню системы ГАРАНТ }
   class function mod_opcode_Common_OpenMainMenuNew : TvcmMOpID;
     { "Общий" только для F1 -> Основное меню }
   class function mod_opcode_Common_TasksPanel : TvcmMOpID;
     { "Общий" только для F1 -> Панель задач }
   class function mod_opcode_Common_LetterToDevelopers : TvcmMOpID;
     { "Общий" только для F1 -> Письмо разработчикам }
   class function opcode_Navigator_SetCurrent : TvcmOpID;
     {  ->  }
   class function mod_opcode_Common_OpenRubricator : TvcmMOpID;
     { "Общий" только для F1 -> Правовой навигатор }
   class function mod_opcode_Common_OpenInformation : TvcmMOpID;
     { "Общий" только для F1 -> Справочная информация }
   class function mod_opcode_Common_get_navigator : TvcmMOpID;
     { "Общий" только для F1 -> Меню (вкладка) }
   class function mod_opcode_Common_OpenIntranet : TvcmMOpID;
     { "Общий" только для F1 ->  }
   class function opcode_PrintParams_UpdatePrinter : TvcmOpID;
     {  ->  }
   class function opcode_Rubricator_SetListRoot : TvcmOpID;
     {  ->  }
   class function opcode_Rubricator_InitListRoot : TvcmOpID;
     {  ->  }
   class function opcode_Rubricator_Synchronize : TvcmOpID;
     {  ->  }
   class function opcode_Rubricator_GetRoot : TvcmOpID;
     {  ->  }
   class function opcode_Document_GetAttributesFrmAct : TvcmOpID;
     { Документ -> Информация о документе }
   class function opcode_Document_OpenCorrespondentList : TvcmOpID;
     { Документ -> Коллеги, это что? }
   class function opcode_Document_OpenRespondentList : TvcmOpID;
     { Документ -> Коллеги, это что? }
   class function opcode_Document_GetRelatedDocFrmAct : TvcmOpID;
     { Документ -> Справка к документу }
   class function opcode_Document_GetCorrespondentList : TvcmOpID;
     { Документ -> Ссылки на документ }
   class function opcode_Document_GetRespondentList : TvcmOpID;
     { Документ -> Ссылки из документа }
   class function opcode_Document_AttributesCanBeClosed : TvcmOpID;
     { Документ -> Это кандидат на перенос в Facet или что-то подобное }
   class function opcode_Document_CommonDocumentOpenNewWindow : TvcmOpID;
     { Документ -> Что это? }
   class function opcode_Document_GetCorrespondentListExFrmAct : TvcmOpID;
     { Документ -> Ссылки на документ (вид информации) }
   class function opcode_Document_GetRespondentListExFrmAct : TvcmOpID;
     { Документ -> Ссылки из документа (вид информации) }
   class function opcode_Document_CommonDocumentOpenNewTab : TvcmOpID;
     { Документ ->  }
   class function opcode_Document_DocumentIsUseful : TvcmOpID;
     { Документ -> Нравится }
   class function opcode_Document_DocumentIsUseless : TvcmOpID;
     { Документ -> Не нравится }
   class function opcode_Document_PrevDocumentInList : TvcmOpID;
     { Документ -> Предыдущий документ в списке }
   class function opcode_Document_NextDocumentInList : TvcmOpID;
     { Документ -> Следующий документ в списке }
   class function opcode_Document_ReturnToList : TvcmOpID;
     { Документ -> Вернуться в списк }
   class function opcode_Document_CompareEditions : TvcmOpID;
     { Документ -> Сравнение редакций }
   class function opcode_System_TimeMachineStateChange : TvcmOpID;
     {  ->  }
   class function opcode_Document_FindExplanation : TvcmOpID;
     { Документ -> Найти толкование }
   class function opcode_TimeMachine_TimeMachineOnOffNew : TvcmOpID;
     {  -> Включить Машину времени }
   class function opcode_TimeMachine_TimeMachineOnOff : TvcmOpID;
     {  ->  }
   class function opcode_TimeMachine_TimeMachineOffAndReset : TvcmOpID;
     {  ->  }
   class function opcode_DocumentBlockHeader_UserCR1 : TvcmOpID;
     { Пункт оглавления - Заголовок документ -> Пользовательские ссылки на документ (ссылки из документа) 1 }
   class function opcode_DocumentBlockHeader_UserCR2 : TvcmOpID;
     { Пункт оглавления - Заголовок документ -> Пользовательские ссылки на документ (ссылки из документа) 2 }
   class function opcode_DocumentBlockHeader_GetTypedCorrespondentList : TvcmOpID;
     { Пункт оглавления - Заголовок документ ->  }
   class function opcode_DocumentBlockHeader_AddBookmark : TvcmOpID;
     { Пункт оглавления - Заголовок документ ->  }
   class function opcode_DocumentBlockHeader_ToMSWord : TvcmOpID;
     { Пункт оглавления - Заголовок документ ->  }
   class function opcode_DocumentBlockHeader_Print : TvcmOpID;
     { Пункт оглавления - Заголовок документ ->  }
   class function opcode_DocumentBlockHeader_PrintDialog : TvcmOpID;
     { Пункт оглавления - Заголовок документ ->  }
   class function opcode_Text_AddUserComment : TvcmOpID;
     {  ->  }
   class function opcode_Text_DeleteBookmark : TvcmOpID;
     {  ->  }
   class function opcode_Text_EditBookmark : TvcmOpID;
     {  ->  }
   class function opcode_Text_AddBookmark : TvcmOpID;
     {  ->  }
   class function opcode_Text_OpenNewWindow : TvcmOpID;
     {  ->  }
   class function opcode_DocumentSubPanel_UpdateSubPanel : TvcmOpID;
     {  ->  }
   class function opcode_BaseSearchPresentationHolder_GetBaseSearchPresentation : TvcmOpID;
     {  ->  }
   class function opcode_Switcher_SetFirstPageActive : TvcmOpID;
     { Сущность для управления закладками формы-контейнера ->  }
   class function opcode_AACTextContainer_GetVScrollBar : TvcmOpID;
     {  ->  }
   class function opcode_AACTextContainer_SetJumpTo : TvcmOpID;
     {  ->  }
   class function opcode_Editions_SetCurrent : TvcmOpID;
     { Редакции -> Установить текущую }
   class function opcode_Contents_SetCurrent : TvcmOpID;
     { Структура документа ->  }
   class function opcode_Contents_MoveCurrent : TvcmOpID;
     { Структура документа ->  }
   class function opcode_Contents_HasUserComments : TvcmOpID;
     { Структура документа -> Есть ли в оглавление пользовательские комментарии }
   class function opcode_Contents_HasBookmarks : TvcmOpID;
     { Структура документа -> Есть ли в оглавлении закладки }
   class function opcode_Contents_ToggleContentsVisibility : TvcmOpID;
     { Структура документа -> Переключает видимость ПЛАВАЮЩЕГО окна оглавления, возвращает true если переключение удалось }
   class function opcode_Contents_IsContentsVisible : TvcmOpID;
     { Структура документа -> Возвращает состояние видимости ПЛАВАЮЩЕГО окна оглавления }
   class function opcode_ContentsValidator_IsDocumentAdornmentsChanged : TvcmOpID;
     { http://mdp.garant.ru/pages/viewpage.action?pageId=259891063 ->  }
   class function opcode_Comment_Changed : TvcmOpID;
     {  ->  }
   class function opcode_Picture_InitNewContent : TvcmOpID;
     { Картинка ->  }
   class function mod_opcode_Document_OpenDocOnNumber : TvcmMOpID;
     { Работа с документом -> Открыть документ по номеру }
   class function opcode_Warning_BecomeActive : TvcmOpID;
     {  ->  }
   class function opcode_Warning_SwitchActive : TvcmOpID;
     {  ->  }
   class function opcode_SynchroView_BecomeActive : TvcmOpID;
     {  ->  }
   class function opcode_List_GetDeList : TvcmOpID;
     {  ->  }
   class function opcode_List_SetCurrentVisible : TvcmOpID;
     {  ->  }
   class function opcode_List_SwitchToFullList : TvcmOpID;
     {  -> Построить полный список }
   class function opcode_List_GetDsList : TvcmOpID;
     {  ->  }
   class function opcode_Filterable_Add : TvcmOpID;
     {  ->  }
   class function opcode_Filterable_Delete : TvcmOpID;
     {  ->  }
   class function opcode_Filterable_ClearAll : TvcmOpID;
     {  ->  }
   class function opcode_Filterable_Refresh : TvcmOpID;
     {  ->  }
   class function opcode_Filterable_GetListType : TvcmOpID;
     {  ->  }
   class function opcode_Selection_Analize : TvcmOpID;
     { Выделенные элементы -> Анализ списка... }
   class function opcode_LocalList_SearchInList : TvcmOpID;
     { Список (контекстные операции) -> Искать по реквизитам в текущем списке }
   class function opcode_Filters_FiltersListOpen : TvcmOpID;
     {  -> Фильтры (вкладка) }
   class function opcode_List_Sort : TvcmOpID;
     { Список -> Сортировать список }
   class function opcode_Filters_InternalClear : TvcmOpID;
     {  ->  }
   class function opcode_CRList_SetType : TvcmOpID;
     {  ->  }
   class function opcode_Filter_Activate : TvcmOpID;
     {  -> Применить фильтр }
   class function opcode_Filter_ActivateNode : TvcmOpID;
     {  ->  }
   class function opcode_ListInfo_BecomeActive : TvcmOpID;
     {  ->  }
   class function opcode_Filters_DeselectAll : TvcmOpID;
     {  ->  }
   class function mod_opcode_Diction_OpenDict : TvcmMOpID;
     { Толковый словарь -> Толковый словарь }
   class function opcode_Query_ClearAll : TvcmOpID;
     {  ->  }
   class function opcode_Query_SetList : TvcmOpID;
     {  ->  }
   class function opcode_Query_GetList : TvcmOpID;
     {  ->  }
   class function opcode_SearchParameters_IsQueryEmpty : TvcmOpID;
     { SearchParameters ->  }
   class function opcode_SearchParameters_GetQuery : TvcmOpID;
     { SearchParameters ->  }
   class function opcode_SearchParameters_IsQuerySaved : TvcmOpID;
     { SearchParameters ->  }
   class function opcode_SearchParameters_SetQuery : TvcmOpID;
     { SearchParameters ->  }
   class function opcode_SearchParameters_ClearQuery : TvcmOpID;
     { SearchParameters ->  }
   class function opcode_SearchParameter_QueryNotSaved : TvcmOpID;
     {  ->  }
   class function opcode_SearchParameter_ClearMistakes : TvcmOpID;
     {  ->  }
   class function opcode_SearchParameter_QuerySaved : TvcmOpID;
     {  ->  }
   class function opcode_Attribute_DefaultAction : TvcmOpID;
     {  ->  }
   class function opcode_Attribute_LogicOr : TvcmOpID;
     {  ->  }
   class function opcode_Attribute_LogicAnd : TvcmOpID;
     {  ->  }
   class function opcode_Attribute_LogicNot : TvcmOpID;
     {  ->  }
   class function opcode_Attribute_LogicOrShortcut : TvcmOpID;
     {  ->  }
   class function mod_opcode_Tips_ShowDayTips : TvcmMOpID;
     {  ->  }
   class function mod_opcode_Inpharm_MedicDiction : TvcmMOpID;
     {  -> Словарь медицинских терминов }
   class function mod_opcode_Inpharm_MedicFirms : TvcmMOpID;
     {  -> Фармацевтические фирмы }
   class function mod_opcode_Inpharm_DrugList : TvcmMOpID;
     {  -> Список выпускаемых препаратов }
   class function mod_opcode_Inpharm_MedicMainMenu : TvcmMOpID;
     {  -> Основное меню ИнФарм }
   class function opcode_StyleEditor_ReloadStyleTable : TvcmOpID;
     {  ->  }
   class function opcode_StyleEditor_RestoreStyleTable : TvcmOpID;
     {  ->  }
   class function opcode_StyleEditor_SaveStyleTable : TvcmOpID;
     {  ->  }
   class function opcode_StyleEditor_SetNewContent : TvcmOpID;
     {  ->  }
   class function opcode_StyleEditor_ReloadStylesTree : TvcmOpID;
     { StyleEditor$ReloadStylesTree -> ReloadStylesTree }
   class function mod_opcode_Settings_OpenStyleEditorAsModal : TvcmMOpID;
     {  -> Редактор стилей... }
   class function mod_opcode_Settings_AutoLogin : TvcmMOpID;
     {  -> Автоматический вход в систему }
   class function mod_opcode_Settings_SelectConfig : TvcmMOpID;
     {  -> Выбор конфигурации }
   class function mod_opcode_Settings_OpenConfList : TvcmMOpID;
     {  -> Список конфигураций }
   class function mod_opcode_Settings_LoadActiveSettings : TvcmMOpID;
     {  -> Настройка конфигурации... }
   class function mod_opcode_Settings_UserProperties : TvcmMOpID;
     {  -> Изменить мои регистрационные данные... }
   class function opcode_Filters_GetSelected : TvcmOpID;
     {  ->  }
   class function mod_opcode_DocumentListFromFile_OpenDocumentListFromFile : TvcmMOpID;
     { Список документов из файла -> Открыть список документов из файла }
   class function mod_opcode_Search_PublishSourceSearch : TvcmMOpID;
     { Поиск ->  }
   class function mod_opcode_Search_InpharmSearch : TvcmMOpID;
     { Поиск -> Поиск лекарственных средств }
   class function mod_opcode_Search_StartENO : TvcmMOpID;
     { Поиск ->  }
   class function mod_opcode_Search_DocumentsWithoutClass : TvcmMOpID;
     { Поиск ->  }
   class function mod_opcode_Search_DocumentsWithoutIncluded : TvcmMOpID;
     { Поиск ->  }
   class function mod_opcode_Search_DocumentsWithoutKey : TvcmMOpID;
     { Поиск ->  }
   class function mod_opcode_Search_BaseSearch : TvcmMOpID;
     { Поиск ->  }
   class function mod_opcode_Search_OpenConsult : TvcmMOpID;
     { Поиск ->  }
   class function mod_opcode_Search_AllSearch : TvcmMOpID;
     { Поиск -> Поиск }
   class function opcode_ContextParams_ContextChanged : TvcmOpID;
     {  ->  }
   class function mod_opcode_Search_OpenKeyWordSearch : TvcmMOpID;
     { Поиск -> Поиск по ситуации }
   class function mod_opcode_Search_AttributeSearch : TvcmMOpID;
     { Поиск -> Поиск по реквизитам }
   class function opcode_AttributeTree_SetParent : TvcmOpID;
     {  ->  }
   class function opcode_AttributeTree_ExtSetRoot : TvcmOpID;
     {  ->  }
   class function opcode_AttributeTree_SetRoot : TvcmOpID;
     {  ->  }
   class function opcode_AttributeTree_ExternalCharPressed : TvcmOpID;
     { AttributeTree ->  }
   class function opcode_AttributeTree_SetCurrent : TvcmOpID;
     { AttributeTree ->  }
   class function opcode_AttributeTree_DropAllLogicSelection : TvcmOpID;
     { AttributeTree ->  }
   class function opcode_AttributeTree_Invalidate : TvcmOpID;
     { AttributeTree ->  }
   class function opcode_AttributeTree_DropLogicSelection : TvcmOpID;
     { AttributeTree ->  }
   class function opcode_AttributeTree_LoadQuery : TvcmOpID;
     { AttributeTree ->  }
   class function opcode_AttributeTree_SetOneLevelCurrent : TvcmOpID;
     { AttributeTree ->  }
   class function opcode_AttributeTree_AddNodeIfEmpty : TvcmOpID;
     { AttributeTree ->  }
   class function mod_opcode_CommonPost_SavePostList : TvcmMOpID;
     { Новостная лента -> Экспортировать все индивидуальные ленты в файл }
end;//TNemesisRes
TvcmApplicationRef = TNemesisRes;
 {* Ссылка на приложение для DesignTime редакторов }

{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  moCompareEditions,
  moInternetAgent,
  moFolders,
  moChat,
  moWorkJournal,
  moMonitorings,
  moCommon,
  moDocument,
  moList,
  moDiction,
  moTips,
  moInpharm,
  moRubricator,
  moSettings,
  moMainMenu,
  moConsultations,
  moBaseSearch,
  moFilters,
  moUnderControl,
  moDocumentListFromFile,
  moChangesBetweenEditions,
  moSearch,
  moAAC,
  moCommonPost,
  evExtFormat
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  BaseEditions_Module,
  Base_Operations_View_Controls,
  Search_Strange_Controls,
  CompareEditions_Controls,
  Base_Operations_Editions_Controls,
  Base_Operations_F1Specific_Controls
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Text_Controls
  {$IfEnd} //not NoVCM
  ,
  Base_Operations_Strange_Controls,
  Common_Strange_Controls,
  PrimInternetAgent_Module,
  Search_ScalingSupport_Controls,
  PrimFolders_Module
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  Folders_Result_Controls,
  Folders_Strange_Controls
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  ,
  BaseChat_Module,
  Base_Operations_Chat_Controls
  {$If not defined(NoVCM)}
  ,
  OfficeLike_ResultEx_Controls
  {$IfEnd} //not NoVCM
  ,
  BaseWorkJournal_Module,
  WorkJournal_Strange_Controls,
  Autoreferat_InternalOperations_Controls,
  PostingOrder_Strange_Controls,
  PrimF1Common_Module,
  Common_Rubricator_Controls,
  Document_Module,
  Hypertext_Controls_Controls,
  Document_Strange_Controls,
  Document_F1Lite_Controls,
  F1Like_InternalOperations_Controls,
  Base_Operations_AAC_Controls,
  LegalDomain_DocumentNotifications_Controls,
  List_Module,
  WorkWithList_ListOperations_Controls,
  WorkWithList_StatusBar_Controls,
  Diction_Module,
  Diction_Strange_Controls,
  SearchLite_Strange_Controls,
  DayTips_Module,
  Inpharm_Module,
  Inpharm_Strange_Controls,
  Rubricator_Module,
  Rubricator_Strange_Controls,
  Settings_Module,
  Settings_Strange_Controls,
  MainMenu_Module,
  Consultation_Module,
  BaseSearch_Module,
  BaseSearch_Controls,
  Filters_Module,
  Filters_Strange_Controls,
  UnderControl_Module,
  UnderControl_Strange_Controls,
  PrimDocumentListFromFile_Module,
  ChangesBetweenEditions_Module,
  Search_Module,
  AACPrim_Module,
  CommonPost_Module,
  fsCompareEditions,
  fsInternetAgent,
  fsFolders,
  fsAutoreferat,
  fsAutoreferatAfterSearch,
  fsDocument,
  fsDocumentWithFlash,
  fsList,
  fsDiction,
  fsTips,
  fsMedicDiction,
  fsMedicFirmDocument,
  fsDrugDocument,
  fsDrugList,
  fsMedicFirmList,
  fsInpharmMainMenu,
  fsSendConsultation,
  fsConsultation,
  fsViewChangedFragments,
  fsSituationSearch,
  fsSituationFilter,
  fsAACContents,
  fsAAC
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TNemesisRes

procedure TNemesisRes.RegisterFormSetFactories;
begin
 inherited;
 RegisterFormSetFactory(Tfs_CompareEditions);
 RegisterFormSetFactory(Tfs_InternetAgent);
 RegisterFormSetFactory(Tfs_Folders);
 RegisterFormSetFactory(Tfs_Autoreferat);
 RegisterFormSetFactory(Tfs_AutoreferatAfterSearch);
 RegisterFormSetFactory(Tfs_Document);
 RegisterFormSetFactory(Tfs_DocumentWithFlash);
 RegisterFormSetFactory(Tfs_List);
 RegisterFormSetFactory(Tfs_Diction);
 RegisterFormSetFactory(Tfs_Tips);
 RegisterFormSetFactory(Tfs_MedicDiction);
 RegisterFormSetFactory(Tfs_MedicFirmDocument);
 RegisterFormSetFactory(Tfs_DrugDocument);
 RegisterFormSetFactory(Tfs_DrugList);
 RegisterFormSetFactory(Tfs_MedicFirmList);
 RegisterFormSetFactory(Tfs_InpharmMainMenu);
 RegisterFormSetFactory(Tfs_SendConsultation);
 RegisterFormSetFactory(Tfs_Consultation);
 RegisterFormSetFactory(Tfs_ViewChangedFragments);
 RegisterFormSetFactory(Tfs_SituationSearch);
 RegisterFormSetFactory(Tfs_SituationFilter);
 RegisterFormSetFactory(Tfs_AACContents);
 RegisterFormSetFactory(Tfs_AAC);
end;

class procedure TNemesisRes.RegisterModules(aMain: TvcmMainForm);
begin
 inherited;
 aMain.RegisterModule(Tmo_CompareEditions);
 aMain.RegisterModule(Tmo_InternetAgent);
 aMain.RegisterModule(Tmo_Folders);
 aMain.RegisterModule(Tmo_Chat);
 aMain.RegisterModule(Tmo_WorkJournal);
 aMain.RegisterModule(Tmo_Monitorings);
 aMain.RegisterModule(Tmo_Common);
 aMain.RegisterModule(Tmo_Document);
 aMain.RegisterModule(Tmo_List);
 aMain.RegisterModule(Tmo_Diction);
 aMain.RegisterModule(Tmo_Tips);
 aMain.RegisterModule(Tmo_Inpharm);
 aMain.RegisterModule(Tmo_Rubricator);
 aMain.RegisterModule(Tmo_Settings);
 aMain.RegisterModule(Tmo_MainMenu);
 aMain.RegisterModule(Tmo_Consultations);
 aMain.RegisterModule(Tmo_BaseSearch);
 aMain.RegisterModule(Tmo_Filters);
 aMain.RegisterModule(Tmo_UnderControl);
 aMain.RegisterModule(Tmo_DocumentListFromFile);
 aMain.RegisterModule(Tmo_ChangesBetweenEditions);
 aMain.RegisterModule(Tmo_Search);
 aMain.RegisterModule(Tmo_AAC);
 aMain.RegisterModule(Tmo_CommonPost);
end;

var
 g_opcode_Document_ShowJurorComments : TvcmOpID;
 g_opcode_Document_ShowUserComments : TvcmOpID;
 g_opcode_Document_ShowVersionComments : TvcmOpID;
 g_opcode_Finder_GotoPara : TvcmOpID;
 g_opcode_Finder_DisableForceDrawFocusRect : TvcmOpID;
 g_opcode_File_Print : TvcmOpID;
 g_opcode_File_PrintDialog : TvcmOpID;
 g_opcode_File_PrintPreview : TvcmOpID;
 g_opcode_File_Save : TvcmOpID;
 g_opcode_Document_OpenEditionLocalLink : TvcmOpID;
 g_opcode_ControlCenter_Refresh : TvcmOpID;
 g_opcode_Document_SetPosition : TvcmOpID;
 g_opcode_HyperLink_Open : TvcmOpID;
 g_opcode_HyperLink_OpenNewWindow : TvcmOpID;
 g_opcode_HyperLink_NextHyperLink : TvcmOpID;
 g_opcode_HyperLink_PrevHyperLink : TvcmOpID;
 g_opcode_HyperLink_OpenInNewTab : TvcmOpID;
 g_opcode_HyperLink_OpenScriptHyperLink : TvcmOpID;
 g_opcode_HyperLink_NavigateInternetHyperlink : TvcmOpID;
 g_opcode_HyperLink_Delete : TvcmOpID;
 g_opcode_RightEdition_ReturnToDocument : TvcmOpID;
 g_opcode_RightEdition_SetFocusToText : TvcmOpID;
 g_opcode_RightEdition_IsCurrentPara : TvcmOpID;
 g_opcode_Document_GetParaForPositionning : TvcmOpID;
 g_opcode_Edition_PrevChange : TvcmOpID;
 g_opcode_Edition_NextChange : TvcmOpID;
 g_opcode_Edition_ReturnToDocument : TvcmOpID;
 g_opcode_Document_ViewChangedFragments : TvcmOpID;
 g_opcode_Redactions_OpenRedactionListFrmAct : TvcmOpID;
 g_opcode_Redactions_RedactionOnID : TvcmOpID;
 g_opcode_Redactions_ActualRedaction : TvcmOpID;
 g_opcode_Redactions_PrevRedaction : TvcmOpID;
 g_opcode_Redactions_NextRedaction : TvcmOpID;
 g_opcode_Scalable_ChangeScale : TvcmOpID;
 g_opcode_Scalable_CanChangeScale : TvcmOpID;
 g_module_opcode_InternetAgent_InternetAgent : TvcmMOpID;
 g_opcode_Result_Cancel : TvcmOpID;
 g_opcode_FoldersControl_EditElement : TvcmOpID;
 g_opcode_FoldersControl_DeleteElement : TvcmOpID;
 g_opcode_Result_Ok : TvcmOpID;
 g_opcode_AdditionInfo_Show : TvcmOpID;
 g_opcode_AdditionInfo_Hide : TvcmOpID;
 g_opcode_AdditionInfo_SetCaption : TvcmOpID;
 g_opcode_AdditionInfo_Close : TvcmOpID;
 g_opcode_Switcher_BecomeActive : TvcmOpID;
 g_opcode_ResultExt_Ok : TvcmOpID;
 g_opcode_ResultExt_Append : TvcmOpID;
 g_opcode_ResultExt_Cancel : TvcmOpID;
 g_opcode_FolderElement_SetState : TvcmOpID;
 g_opcode_Tree_ExpandAll : TvcmOpID;
 g_opcode_Tree_CollapseAll : TvcmOpID;
 g_opcode_Tree_Wrap : TvcmOpID;
 g_opcode_FolderElement_InternalEditByFoldersNode : TvcmOpID;
 g_opcode_FolderElement_InternalDelete : TvcmOpID;
 g_opcode_FolderElement_InternalEdit : TvcmOpID;
 g_opcode_FolderElement_DisableFilter : TvcmOpID;
 g_opcode_SavedQuery_SetFilterState : TvcmOpID;
 g_opcode_Folders_SetCurrent : TvcmOpID;
 g_opcode_Folders_FiltrateByFilterInfo : TvcmOpID;
 g_opcode_Folders_TryOpenConsultationAnswer : TvcmOpID;
 g_opcode_Folders_OpenMyConsultations : TvcmOpID;
 g_opcode_Folders_SetInfoContent : TvcmOpID;
 g_opcode_FolderElement_GetState : TvcmOpID;
 g_opcode_FolderElement_SetLoadInfo : TvcmOpID;
 g_opcode_FolderElement_SetContent : TvcmOpID;
 g_opcode_FolderElement_SetSaveInfo : TvcmOpID;
 g_opcode_FolderElement_ResetModificationOnDelete : TvcmOpID;
 g_opcode_FolderElement_SetFocus : TvcmOpID;
 g_opcode_FolderElement_Redraw : TvcmOpID;
 g_opcode_FolderElement_DisableSecurityPage : TvcmOpID;
 g_opcode_UsersRights_UpdateRights : TvcmOpID;
 g_opcode_UsersRights_FolderShareChanged : TvcmOpID;
 g_opcode_Result_ExternalOk : TvcmOpID;
 g_opcode_Loadable_Load : TvcmOpID;
 g_opcode_Document_SetActive : TvcmOpID;
 g_opcode_Document_ExportBlock : TvcmOpID;
 g_opcode_Document_GetCurrentPosition : TvcmOpID;
 g_opcode_Document_SelectBlock : TvcmOpID;
 g_opcode_Document_CopyBlock : TvcmOpID;
 g_opcode_Document_PrintBlock : TvcmOpID;
 g_opcode_Document_PrintDialogBlock : TvcmOpID;
 g_opcode_Document_PreviewBlock : TvcmOpID;
 g_opcode_Document_ShowRespondentListToPart : TvcmOpID;
 g_opcode_Document_ShowCorrespondentListToPart : TvcmOpID;
 g_opcode_Document_ModifyBookmarkNotify : TvcmOpID;
 g_opcode_Document_AddBookmarkFromContents : TvcmOpID;
 g_opcode_Document_OpenNotSureTopic : TvcmOpID;
 g_opcode_Document_GotoPara : TvcmOpID;
 g_module_opcode_Folders_MyInformation : TvcmMOpID;
 g_module_opcode_Folders_MyConsultations : TvcmMOpID;
 g_module_opcode_Folders_UnderControlOpenFrmAct : TvcmMOpID;
 g_module_opcode_Folders_OpenFrmAct : TvcmMOpID;
 g_opcode_List_SetNewContent : TvcmOpID;
 g_opcode_Result_OkExt : TvcmOpID;
 g_module_opcode_Chat_OpenContactList : TvcmMOpID;
 g_module_opcode_WorkJournal_OpenJournal : TvcmMOpID;
 g_opcode_DateInterval_OpenInt : TvcmOpID;
 g_opcode_Form_RequestClose : TvcmOpID;
 g_module_opcode_Monitorings_OpenNewsLine : TvcmMOpID;
 g_module_opcode_Monitorings_OpenLegislationReview : TvcmMOpID;
 g_opcode_SearchSupport_ActivatePostingsListForm : TvcmOpID;
 g_module_opcode_Common_ComplectInfo : TvcmMOpID;
 g_module_opcode_Common_PageSetup : TvcmMOpID;
 g_module_opcode_Common_ShowEULA : TvcmMOpID;
 g_module_opcode_Common_OpenMainMenuByButton : TvcmMOpID;
 g_module_opcode_Common_OpenMainMenuNew : TvcmMOpID;
 g_module_opcode_Common_TasksPanel : TvcmMOpID;
 g_module_opcode_Common_LetterToDevelopers : TvcmMOpID;
 g_opcode_Navigator_SetCurrent : TvcmOpID;
 g_module_opcode_Common_OpenRubricator : TvcmMOpID;
 g_module_opcode_Common_OpenInformation : TvcmMOpID;
 g_module_opcode_Common_get_navigator : TvcmMOpID;
 g_module_opcode_Common_OpenIntranet : TvcmMOpID;
 g_opcode_PrintParams_UpdatePrinter : TvcmOpID;
 g_opcode_Rubricator_SetListRoot : TvcmOpID;
 g_opcode_Rubricator_InitListRoot : TvcmOpID;
 g_opcode_Rubricator_Synchronize : TvcmOpID;
 g_opcode_Rubricator_GetRoot : TvcmOpID;
 g_opcode_Document_GetAttributesFrmAct : TvcmOpID;
 g_opcode_Document_OpenCorrespondentList : TvcmOpID;
 g_opcode_Document_OpenRespondentList : TvcmOpID;
 g_opcode_Document_GetRelatedDocFrmAct : TvcmOpID;
 g_opcode_Document_GetCorrespondentList : TvcmOpID;
 g_opcode_Document_GetRespondentList : TvcmOpID;
 g_opcode_Document_AttributesCanBeClosed : TvcmOpID;
 g_opcode_Document_CommonDocumentOpenNewWindow : TvcmOpID;
 g_opcode_Document_GetCorrespondentListExFrmAct : TvcmOpID;
 g_opcode_Document_GetRespondentListExFrmAct : TvcmOpID;
 g_opcode_Document_CommonDocumentOpenNewTab : TvcmOpID;
 g_opcode_Document_DocumentIsUseful : TvcmOpID;
 g_opcode_Document_DocumentIsUseless : TvcmOpID;
 g_opcode_Document_PrevDocumentInList : TvcmOpID;
 g_opcode_Document_NextDocumentInList : TvcmOpID;
 g_opcode_Document_ReturnToList : TvcmOpID;
 g_opcode_Document_CompareEditions : TvcmOpID;
 g_opcode_System_TimeMachineStateChange : TvcmOpID;
 g_opcode_Document_FindExplanation : TvcmOpID;
 g_opcode_TimeMachine_TimeMachineOnOffNew : TvcmOpID;
 g_opcode_TimeMachine_TimeMachineOnOff : TvcmOpID;
 g_opcode_TimeMachine_TimeMachineOffAndReset : TvcmOpID;
 g_opcode_DocumentBlockHeader_UserCR1 : TvcmOpID;
 g_opcode_DocumentBlockHeader_UserCR2 : TvcmOpID;
 g_opcode_DocumentBlockHeader_GetTypedCorrespondentList : TvcmOpID;
 g_opcode_DocumentBlockHeader_AddBookmark : TvcmOpID;
 g_opcode_DocumentBlockHeader_ToMSWord : TvcmOpID;
 g_opcode_DocumentBlockHeader_Print : TvcmOpID;
 g_opcode_DocumentBlockHeader_PrintDialog : TvcmOpID;
 g_opcode_Text_AddUserComment : TvcmOpID;
 g_opcode_Text_DeleteBookmark : TvcmOpID;
 g_opcode_Text_EditBookmark : TvcmOpID;
 g_opcode_Text_AddBookmark : TvcmOpID;
 g_opcode_Text_OpenNewWindow : TvcmOpID;
 g_opcode_DocumentSubPanel_UpdateSubPanel : TvcmOpID;
 g_opcode_BaseSearchPresentationHolder_GetBaseSearchPresentation : TvcmOpID;
 g_opcode_Switcher_SetFirstPageActive : TvcmOpID;
 g_opcode_AACTextContainer_GetVScrollBar : TvcmOpID;
 g_opcode_AACTextContainer_SetJumpTo : TvcmOpID;
 g_opcode_Editions_SetCurrent : TvcmOpID;
 g_opcode_Contents_SetCurrent : TvcmOpID;
 g_opcode_Contents_MoveCurrent : TvcmOpID;
 g_opcode_Contents_HasUserComments : TvcmOpID;
 g_opcode_Contents_HasBookmarks : TvcmOpID;
 g_opcode_Contents_ToggleContentsVisibility : TvcmOpID;
 g_opcode_Contents_IsContentsVisible : TvcmOpID;
 g_opcode_ContentsValidator_IsDocumentAdornmentsChanged : TvcmOpID;
 g_opcode_Comment_Changed : TvcmOpID;
 g_opcode_Picture_InitNewContent : TvcmOpID;
 g_module_opcode_Document_OpenDocOnNumber : TvcmMOpID;
 g_opcode_Warning_BecomeActive : TvcmOpID;
 g_opcode_Warning_SwitchActive : TvcmOpID;
 g_opcode_SynchroView_BecomeActive : TvcmOpID;
 g_opcode_List_GetDeList : TvcmOpID;
 g_opcode_List_SetCurrentVisible : TvcmOpID;
 g_opcode_List_SwitchToFullList : TvcmOpID;
 g_opcode_List_GetDsList : TvcmOpID;
 g_opcode_Filterable_Add : TvcmOpID;
 g_opcode_Filterable_Delete : TvcmOpID;
 g_opcode_Filterable_ClearAll : TvcmOpID;
 g_opcode_Filterable_Refresh : TvcmOpID;
 g_opcode_Filterable_GetListType : TvcmOpID;
 g_opcode_Selection_Analize : TvcmOpID;
 g_opcode_LocalList_SearchInList : TvcmOpID;
 g_opcode_Filters_FiltersListOpen : TvcmOpID;
 g_opcode_List_Sort : TvcmOpID;
 g_opcode_Filters_InternalClear : TvcmOpID;
 g_opcode_CRList_SetType : TvcmOpID;
 g_opcode_Filter_Activate : TvcmOpID;
 g_opcode_Filter_ActivateNode : TvcmOpID;
 g_opcode_ListInfo_BecomeActive : TvcmOpID;
 g_opcode_Filters_DeselectAll : TvcmOpID;
 g_module_opcode_Diction_OpenDict : TvcmMOpID;
 g_opcode_Query_ClearAll : TvcmOpID;
 g_opcode_Query_SetList : TvcmOpID;
 g_opcode_Query_GetList : TvcmOpID;
 g_opcode_SearchParameters_IsQueryEmpty : TvcmOpID;
 g_opcode_SearchParameters_GetQuery : TvcmOpID;
 g_opcode_SearchParameters_IsQuerySaved : TvcmOpID;
 g_opcode_SearchParameters_SetQuery : TvcmOpID;
 g_opcode_SearchParameters_ClearQuery : TvcmOpID;
 g_opcode_SearchParameter_QueryNotSaved : TvcmOpID;
 g_opcode_SearchParameter_ClearMistakes : TvcmOpID;
 g_opcode_SearchParameter_QuerySaved : TvcmOpID;
 g_opcode_Attribute_DefaultAction : TvcmOpID;
 g_opcode_Attribute_LogicOr : TvcmOpID;
 g_opcode_Attribute_LogicAnd : TvcmOpID;
 g_opcode_Attribute_LogicNot : TvcmOpID;
 g_opcode_Attribute_LogicOrShortcut : TvcmOpID;
 g_module_opcode_Tips_ShowDayTips : TvcmMOpID;
 g_module_opcode_Inpharm_MedicDiction : TvcmMOpID;
 g_module_opcode_Inpharm_MedicFirms : TvcmMOpID;
 g_module_opcode_Inpharm_DrugList : TvcmMOpID;
 g_module_opcode_Inpharm_MedicMainMenu : TvcmMOpID;
 g_opcode_StyleEditor_ReloadStyleTable : TvcmOpID;
 g_opcode_StyleEditor_RestoreStyleTable : TvcmOpID;
 g_opcode_StyleEditor_SaveStyleTable : TvcmOpID;
 g_opcode_StyleEditor_SetNewContent : TvcmOpID;
 g_opcode_StyleEditor_ReloadStylesTree : TvcmOpID;
 g_module_opcode_Settings_OpenStyleEditorAsModal : TvcmMOpID;
 g_module_opcode_Settings_AutoLogin : TvcmMOpID;
 g_module_opcode_Settings_SelectConfig : TvcmMOpID;
 g_module_opcode_Settings_OpenConfList : TvcmMOpID;
 g_module_opcode_Settings_LoadActiveSettings : TvcmMOpID;
 g_module_opcode_Settings_UserProperties : TvcmMOpID;
 g_opcode_Filters_GetSelected : TvcmOpID;
 g_module_opcode_DocumentListFromFile_OpenDocumentListFromFile : TvcmMOpID;
 g_module_opcode_Search_PublishSourceSearch : TvcmMOpID;
 g_module_opcode_Search_InpharmSearch : TvcmMOpID;
 g_module_opcode_Search_StartENO : TvcmMOpID;
 g_module_opcode_Search_DocumentsWithoutClass : TvcmMOpID;
 g_module_opcode_Search_DocumentsWithoutIncluded : TvcmMOpID;
 g_module_opcode_Search_DocumentsWithoutKey : TvcmMOpID;
 g_module_opcode_Search_BaseSearch : TvcmMOpID;
 g_module_opcode_Search_OpenConsult : TvcmMOpID;
 g_module_opcode_Search_AllSearch : TvcmMOpID;
 g_opcode_ContextParams_ContextChanged : TvcmOpID;
 g_module_opcode_Search_OpenKeyWordSearch : TvcmMOpID;
 g_module_opcode_Search_AttributeSearch : TvcmMOpID;
 g_opcode_AttributeTree_SetParent : TvcmOpID;
 g_opcode_AttributeTree_ExtSetRoot : TvcmOpID;
 g_opcode_AttributeTree_SetRoot : TvcmOpID;
 g_opcode_AttributeTree_ExternalCharPressed : TvcmOpID;
 g_opcode_AttributeTree_SetCurrent : TvcmOpID;
 g_opcode_AttributeTree_DropAllLogicSelection : TvcmOpID;
 g_opcode_AttributeTree_Invalidate : TvcmOpID;
 g_opcode_AttributeTree_DropLogicSelection : TvcmOpID;
 g_opcode_AttributeTree_LoadQuery : TvcmOpID;
 g_opcode_AttributeTree_SetOneLevelCurrent : TvcmOpID;
 g_opcode_AttributeTree_AddNodeIfEmpty : TvcmOpID;
 g_module_opcode_CommonPost_SavePostList : TvcmMOpID;

procedure TNemesisRes.Loaded;
begin
 inherited;
 PublishModule(Tmo_CompareEditions, 'Сравнение редакций');
 PublishModule(Tmo_InternetAgent, 'Интернет-агент');
 PublishModule(Tmo_Folders, 'Папки');
 PublishModule(Tmo_Chat, 'Чат');
 PublishModule(Tmo_WorkJournal, 'Журнал работы');
 PublishModule(Tmo_Monitorings, 'Мониторинги');
 PublishModule(Tmo_Common, 'Окна');
 PublishModule(Tmo_Document, 'Документ');
 PublishModule(Tmo_List, 'Список');
 PublishModule(Tmo_Diction, 'Толковый словарь');
 PublishModule(Tmo_Tips, 'Совет дня');
 PublishModule(Tmo_Inpharm, 'Инфарм');
 PublishModule(Tmo_Rubricator, 'Правовой навигатор');
 PublishModule(Tmo_Settings, 'Установки');
 PublishModule(Tmo_MainMenu, 'Основное меню');
 PublishModule(Tmo_Consultations, 'Консультации');
 PublishModule(Tmo_BaseSearch, 'Базовый поиск');
 PublishModule(Tmo_Filters, 'Фильтры');
 PublishModule(Tmo_UnderControl, 'Документы на контроле');
 PublishModule(Tmo_DocumentListFromFile, 'Список документов из файла');
 PublishModule(Tmo_ChangesBetweenEditions, 'Просмотр только измененных фрагментов');
 PublishModule(Tmo_Search, 'Поиск');
 PublishModule(Tmo_AAC, 'Актуальная аналитика');
 PublishModule(Tmo_CommonPost, 'Файл');
 g_opcode_Document_ShowJurorComments :=
  PublishOperation(en_Document,
                    op_ShowJurorComments,
                    en_capDocument,
                    op_capShowJurorComments);
  with PublishOperationState(en_Document, op_ShowJurorComments, 'Hide') do
  begin
   st_user_Document_ShowJurorComments_Hide := StateIndex;
   Caption := 'Скрыть комментарии ГАРАНТа';
   Checked := true;
  end;//with PublishOperationState(en_Document, op_ShowJurorComments, 'Hide')
  with PublishOperationState(en_Document, op_ShowJurorComments, 'Show') do
  begin
   st_user_Document_ShowJurorComments_Show := StateIndex;
   Caption := 'Показать комментарии ГАРАНТа';
  end;//with PublishOperationState(en_Document, op_ShowJurorComments, 'Show')
 g_opcode_Document_ShowUserComments :=
  PublishOperation(en_Document,
                    op_ShowUserComments,
                    en_capDocument,
                    op_capShowUserComments);
  with PublishOperationState(en_Document, op_ShowUserComments, 'Hide') do
  begin
   st_user_Document_ShowUserComments_Hide := StateIndex;
   Caption := 'Скрыть мои комментарии';
   Checked := true;
  end;//with PublishOperationState(en_Document, op_ShowUserComments, 'Hide')
  with PublishOperationState(en_Document, op_ShowUserComments, 'Show') do
  begin
   st_user_Document_ShowUserComments_Show := StateIndex;
   Caption := 'Показать мои комментарии';
  end;//with PublishOperationState(en_Document, op_ShowUserComments, 'Show')
 PublishOperation(en_Document,
                    op_ShowTechComments,
                    en_capDocument,
                    op_capShowTechComments);
  with PublishOperationState(en_Document, op_ShowTechComments, 'Hide') do
  begin
   st_user_Document_ShowTechComments_Hide := StateIndex;
   Checked := true;
  end;//with PublishOperationState(en_Document, op_ShowTechComments, 'Hide')
  with PublishOperationState(en_Document, op_ShowTechComments, 'Show') do
  begin
   st_user_Document_ShowTechComments_Show := StateIndex;
  end;//with PublishOperationState(en_Document, op_ShowTechComments, 'Show')
 g_opcode_Document_ShowVersionComments :=
  PublishOperation(en_Document,
                    op_ShowVersionComments,
                    en_capDocument,
                    op_capShowVersionComments);
  with PublishOperationState(en_Document, op_ShowVersionComments, 'Hide') do
  begin
   st_user_Document_ShowVersionComments_Hide := StateIndex;
   Caption := 'Выключить информацию об изменениях документа';
   Checked := true;
  end;//with PublishOperationState(en_Document, op_ShowVersionComments, 'Hide')
  with PublishOperationState(en_Document, op_ShowVersionComments, 'Show') do
  begin
   st_user_Document_ShowVersionComments_Show := StateIndex;
   Caption := 'Включить информацию об изменениях документа';
  end;//with PublishOperationState(en_Document, op_ShowVersionComments, 'Show')
 PublishOperation(en_Document,
                    op_ShowCommentsGroup,
                    en_capDocument,
                    op_capShowCommentsGroup);
 PublishOperation(en_SubPanelSettings,
                    op_ShowSpecial,
                    en_capSubPanelSettings,
                    op_capShowSpecial);
 PublishOperation(en_SubPanelSettings,
                    op_ShowInfo,
                    en_capSubPanelSettings,
                    op_capShowInfo);
 g_opcode_Finder_GotoPara :=
  PublishInternalOperation(en_Finder,
                    op_GotoPara,
                    en_capFinder,
                    op_capGotoPara);
 g_opcode_Finder_DisableForceDrawFocusRect :=
  PublishInternalOperation(en_Finder,
                    op_DisableForceDrawFocusRect,
                    en_capFinder,
                    op_capDisableForceDrawFocusRect);
 PublishOperation(en_File,
                    op_ToMSWord,
                    en_capFile,
                    op_capToMSWord);
 PublishOperation(en_File,
                    op_SendMailAsAttachment,
                    en_capFile,
                    op_capSendMailAsAttachment, true);
 g_opcode_File_Print :=
  PublishOperation(en_File,
                    op_Print,
                    en_capFile,
                    op_capPrint);
 g_opcode_File_PrintDialog :=
  PublishOperation(en_File,
                    op_PrintDialog,
                    en_capFile,
                    op_capPrintDialog);
 g_opcode_File_PrintPreview :=
  PublishOperation(en_File,
                    op_PrintPreview,
                    en_capFile,
                    op_capPrintPreview);
 g_opcode_File_Save :=
  PublishOperation(en_File,
                    op_Save,
                    en_capFile,
                    op_capSave);
 g_opcode_Document_OpenEditionLocalLink :=
  PublishInternalOperation(en_Document,
                    op_OpenEditionLocalLink,
                    en_capDocument,
                    op_capOpenEditionLocalLink);
 PublishOperation(en_Edit,
                    op_Copy,
                    en_capEdit,
                    op_capCopy);
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Copy, 'AttributesCopy') do
  begin
   st_user_Edit_Copy_AttributesCopy := StateIndex;
   Caption := 'Копировать все атрибуты документа в буфер обмена';
  end;//with PublishOperationState(en_Edit, op_Copy, 'AttributesCopy')
 {$IfEnd} //not NoVCM
 PublishOperation(en_Edit,
                    op_Cut,
                    en_capEdit,
                    op_capCut);
 PublishOperation(en_Edit,
                    op_FindContext,
                    en_capEdit,
                    op_capFindContext);
 PublishOperation(en_Edit,
                    op_FindNext,
                    en_capEdit,
                    op_capFindNext);
 PublishOperation(en_Edit,
                    op_Paste,
                    en_capEdit,
                    op_capPaste);
 PublishOperation(en_Edit,
                    op_Undo,
                    en_capEdit,
                    op_capUndo);
 PublishOperation(en_Edit,
                    op_Redo,
                    en_capEdit,
                    op_capRedo);
 PublishOperation(en_Edit,
                    op_SelectAll,
                    en_capEdit,
                    op_capSelectAll);
 PublishOperation(en_Edit,
                    op_Deselect,
                    en_capEdit,
                    op_capDeselect);
 PublishOperation(en_Edit,
                    op_FindPrev,
                    en_capEdit,
                    op_capFindPrev);
 g_opcode_ControlCenter_Refresh :=
  PublishInternalOperation(en_ControlCenter,
                    op_Refresh,
                    en_capControlCenter,
                    op_capRefresh);
 g_opcode_Document_SetPosition :=
  PublishInternalOperation(en_Document,
                    op_SetPosition,
                    en_capDocument,
                    op_capSetPosition);
 g_opcode_HyperLink_Open :=
  PublishOperation(en_HyperLink,
                    op_Open,
                    en_capHyperLink,
                    op_capOpen);
 g_opcode_HyperLink_OpenNewWindow :=
  PublishOperation(en_HyperLink,
                    op_OpenNewWindow,
                    en_capHyperLink,
                    op_capOpenNewWindow);
 g_opcode_HyperLink_NextHyperLink :=
  PublishOperation(en_HyperLink,
                    op_NextHyperLink,
                    en_capHyperLink,
                    op_capNextHyperLink);
 g_opcode_HyperLink_PrevHyperLink :=
  PublishOperation(en_HyperLink,
                    op_PrevHyperLink,
                    en_capHyperLink,
                    op_capPrevHyperLink);
 g_opcode_HyperLink_OpenInNewTab :=
  PublishOperation(en_HyperLink,
                    op_OpenInNewTab,
                    en_capHyperLink,
                    op_capOpenInNewTab);
 g_opcode_HyperLink_OpenScriptHyperLink :=
  PublishOperation(en_HyperLink,
                    op_OpenScriptHyperLink,
                    en_capHyperLink,
                    op_capOpenScriptHyperLink);
 g_opcode_HyperLink_NavigateInternetHyperlink :=
  PublishOperation(en_HyperLink,
                    op_NavigateInternetHyperlink,
                    en_capHyperLink,
                    op_capNavigateInternetHyperlink);
 g_opcode_HyperLink_Delete :=
  PublishOperation(en_HyperLink,
                    op_Delete,
                    en_capHyperLink,
                    op_capDelete, true);
 g_opcode_RightEdition_ReturnToDocument :=
  PublishInternalOperation(en_RightEdition,
                    op_ReturnToDocument,
                    en_capRightEdition,
                    op_capReturnToDocument);
 g_opcode_RightEdition_SetFocusToText :=
  PublishInternalOperation(en_RightEdition,
                    op_SetFocusToText,
                    en_capRightEdition,
                    op_capSetFocusToText);
 g_opcode_RightEdition_IsCurrentPara :=
  PublishInternalOperation(en_RightEdition,
                    op_IsCurrentPara,
                    en_capRightEdition,
                    op_capIsCurrentPara);
 g_opcode_Document_GetParaForPositionning :=
  PublishInternalOperation(en_Document,
                    op_GetParaForPositionning,
                    en_capDocument,
                    op_capGetParaForPositionning);
 g_opcode_Edition_PrevChange :=
  PublishOperation(en_Edition,
                    op_PrevChange,
                    en_capEdition,
                    op_capPrevChange);
 g_opcode_Edition_NextChange :=
  PublishOperation(en_Edition,
                    op_NextChange,
                    en_capEdition,
                    op_capNextChange);
 g_opcode_Edition_ReturnToDocument :=
  PublishOperation(en_Edition,
                    op_ReturnToDocument,
                    en_capEdition,
                    op_capReturnToDocument);
 g_opcode_Document_ViewChangedFragments :=
  PublishOperation(en_Document,
                    op_ViewChangedFragments,
                    en_capDocument,
                    op_capViewChangedFragments);
 g_opcode_Redactions_OpenRedactionListFrmAct :=
  PublishOperation(en_Redactions,
                    op_OpenRedactionListFrmAct,
                    en_capRedactions,
                    op_capOpenRedactionListFrmAct);
  with PublishOperationState(en_Redactions, op_OpenRedactionListFrmAct, 'ChooseAnotherEditions') do
  begin
   st_user_Redactions_OpenRedactionListFrmAct_ChooseAnotherEditions := StateIndex;
   Caption := 'Выбрать другие редакции';
  end;//with PublishOperationState(en_Redactions, op_OpenRedactionListFrmAct, 'ChooseAnotherEditions')
 g_opcode_Redactions_RedactionOnID :=
  PublishInternalOperation(en_Redactions,
                    op_RedactionOnID,
                    en_capRedactions,
                    op_capRedactionOnID);
 g_opcode_Redactions_ActualRedaction :=
  PublishOperation(en_Redactions,
                    op_ActualRedaction,
                    en_capRedactions,
                    op_capActualRedaction);
 g_opcode_Redactions_PrevRedaction :=
  PublishOperation(en_Redactions,
                    op_PrevRedaction,
                    en_capRedactions,
                    op_capPrevRedaction);
 g_opcode_Redactions_NextRedaction :=
  PublishOperation(en_Redactions,
                    op_NextRedaction,
                    en_capRedactions,
                    op_capNextRedaction);
 PublishOperation(en_Edit,
                    op_Delete,
                    en_capEdit,
                    op_capDelete);
 {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'Controlled') do
  begin
   st_user_Edit_Delete_Controlled := StateIndex;
   Caption := 'Снять с контроля';
  end;//with PublishOperationState(en_Edit, op_Delete, 'Controlled')
 {$IfEnd} //not Admin AND not Monitorings AND not NoVCM
 {$If defined(Admin) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'User') do
  begin
   st_user_Edit_Delete_User := StateIndex;
   Caption := 'Удалить пользователя';
   ImageIndex := 149;
  end;//with PublishOperationState(en_Edit, op_Delete, 'User')
 {$IfEnd} //Admin AND not NoVCM
 {$If defined(Admin) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'MultiUsers') do
  begin
   st_user_Edit_Delete_MultiUsers := StateIndex;
   Caption := 'Удалить выделенных пользователей';
   ImageIndex := 149;
  end;//with PublishOperationState(en_Edit, op_Delete, 'MultiUsers')
 {$IfEnd} //Admin AND not NoVCM
 {$If defined(Admin) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'Group') do
  begin
   st_user_Edit_Delete_Group := StateIndex;
   Caption := 'Удалить группу';
   ImageIndex := 193;
  end;//with PublishOperationState(en_Edit, op_Delete, 'Group')
 {$IfEnd} //Admin AND not NoVCM
 {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'Contact') do
  begin
   st_user_Edit_Delete_Contact := StateIndex;
   Caption := 'Удалить пользователя';
  end;//with PublishOperationState(en_Edit, op_Delete, 'Contact')
 {$IfEnd} //not Admin AND not Monitorings AND not NoVCM
 g_opcode_Scalable_ChangeScale :=
  PublishInternalOperation(en_Scalable,
                    op_ChangeScale,
                    en_capScalable,
                    op_capChangeScale);
 g_opcode_Scalable_CanChangeScale :=
  PublishInternalOperation(en_Scalable,
                    op_CanChangeScale,
                    en_capScalable,
                    op_capCanChangeScale);
 g_module_opcode_InternetAgent_InternetAgent := 
  PublishModuleOperation(Tmo_InternetAgent, 'InternetAgent', 'Новости онлайн');
 g_opcode_Result_Cancel :=
  PublishOperation(en_Result,
                    op_Cancel,
                    en_capResult,
                    op_capCancel);
 g_opcode_FoldersControl_EditElement :=
  PublishInternalOperation(en_FoldersControl,
                    op_EditElement,
                    en_capFoldersControl,
                    op_capEditElement);
 g_opcode_FoldersControl_DeleteElement :=
  PublishInternalOperation(en_FoldersControl,
                    op_DeleteElement,
                    en_capFoldersControl,
                    op_capDeleteElement);
 g_opcode_Result_Ok :=
  PublishOperation(en_Result,
                    op_Ok,
                    en_capResult,
                    op_capOk);
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'Search') do
  begin
   st_user_Result_Ok_Search := StateIndex;
   Caption := 'Искать';
   Hint := 'Провести поиск по выбранным параметрам';
  end;//with PublishOperationState(en_Result, op_Ok, 'Search')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'Print') do
  begin
   st_user_Result_Ok_Print := StateIndex;
   Caption := 'Печать';
   ImageIndex := 3;
  end;//with PublishOperationState(en_Result, op_Ok, 'Print')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'AttributesSelect') do
  begin
   st_user_Result_Ok_AttributesSelect := StateIndex;
   Caption := 'Подтвердить выбор элементов';
  end;//with PublishOperationState(en_Result, op_Ok, 'AttributesSelect')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'ConsultationMark') do
  begin
   st_user_Result_Ok_ConsultationMark := StateIndex;
   Caption := 'Оценить';
  end;//with PublishOperationState(en_Result, op_Ok, 'ConsultationMark')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'Analize') do
  begin
   st_user_Result_Ok_Analize := StateIndex;
   Caption := 'Построить';
  end;//with PublishOperationState(en_Result, op_Ok, 'Analize')
 {$IfEnd} //not NoVCM
 PublishOperation(en_Result,
                    op_Append,
                    en_capResult,
                    op_capAppend);
 g_opcode_AdditionInfo_Show :=
  PublishInternalOperation(en_AdditionInfo,
                    op_Show,
                    en_capAdditionInfo,
                    op_capShow);
 g_opcode_AdditionInfo_Hide :=
  PublishInternalOperation(en_AdditionInfo,
                    op_Hide,
                    en_capAdditionInfo,
                    op_capHide);
 g_opcode_AdditionInfo_SetCaption :=
  PublishInternalOperation(en_AdditionInfo,
                    op_SetCaption,
                    en_capAdditionInfo,
                    op_capSetCaption);
 g_opcode_AdditionInfo_Close :=
  PublishInternalOperation(en_AdditionInfo,
                    op_Close,
                    en_capAdditionInfo,
                    op_capClose);
 g_opcode_Switcher_BecomeActive :=
  PublishInternalOperation(en_Switcher,
                    op_BecomeActive,
                    en_capSwitcher,
                    op_capBecomeActive);
 g_opcode_ResultExt_Ok :=
  PublishOperation(en_ResultExt,
                    op_Ok,
                    en_capResultExt,
                    op_capOk);
  with PublishOperationState(en_ResultExt, op_Ok, 'None') do
  begin
   st_user_ResultExt_Ok_None := StateIndex;
   Hint := 'Подтвердить выбор';
   Enabled := false;
  end;//with PublishOperationState(en_ResultExt, op_Ok, 'None')
  with PublishOperationState(en_ResultExt, op_Ok, 'NewFolder') do
  begin
   st_user_ResultExt_Ok_NewFolder := StateIndex;
   Hint := 'Создать папку';
  end;//with PublishOperationState(en_ResultExt, op_Ok, 'NewFolder')
  with PublishOperationState(en_ResultExt, op_Ok, 'Edit') do
  begin
   st_user_ResultExt_Ok_Edit := StateIndex;
   Hint := 'Сохранить отредактированные параметры';
  end;//with PublishOperationState(en_ResultExt, op_Ok, 'Edit')
  with PublishOperationState(en_ResultExt, op_Ok, 'Load') do
  begin
   st_user_ResultExt_Ok_Load := StateIndex;
   Caption := 'Загрузить';
   Hint := 'Загрузить выбранный элемент';
  end;//with PublishOperationState(en_ResultExt, op_Ok, 'Load')
  with PublishOperationState(en_ResultExt, op_Ok, 'Select') do
  begin
   st_user_ResultExt_Ok_Select := StateIndex;
   Hint := 'Подтвердить выбор элемента';
  end;//with PublishOperationState(en_ResultExt, op_Ok, 'Select')
  with PublishOperationState(en_ResultExt, op_Ok, 'FolderSave') do
  begin
   st_user_ResultExt_Ok_FolderSave := StateIndex;
   Caption := 'Сохранить';
   Hint := 'Сохранить элемент в текущую папку';
   ImageIndex := 22;
  end;//with PublishOperationState(en_ResultExt, op_Ok, 'FolderSave')
 g_opcode_ResultExt_Append :=
  PublishOperation(en_ResultExt,
                    op_Append,
                    en_capResultExt,
                    op_capAppend);
  with PublishOperationState(en_ResultExt, op_Append, 'Bookmark') do
  begin
   st_user_ResultExt_Append_Bookmark := StateIndex;
   Hint := 'Добавить новую закладку к содержанию сохраненного ранее объекта';
  end;//with PublishOperationState(en_ResultExt, op_Append, 'Bookmark')
  with PublishOperationState(en_ResultExt, op_Append, 'List') do
  begin
   st_user_ResultExt_Append_List := StateIndex;
   Hint := 'Добавить новый список к содержанию сохраненного ранее объекта';
  end;//with PublishOperationState(en_ResultExt, op_Append, 'List')
  with PublishOperationState(en_ResultExt, op_Append, 'Query') do
  begin
   st_user_ResultExt_Append_Query := StateIndex;
   Hint := 'Добавить новый запрос к содержанию сохраненного ранее объекта';
  end;//with PublishOperationState(en_ResultExt, op_Append, 'Query')
 g_opcode_ResultExt_Cancel :=
  PublishOperation(en_ResultExt,
                    op_Cancel,
                    en_capResultExt,
                    op_capCancel);
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Cancel, 'Close') do
  begin
   st_user_Result_Cancel_Close := StateIndex;
   Caption := 'Закрыть';
  end;//with PublishOperationState(en_Result, op_Cancel, 'Close')
 {$IfEnd} //not NoVCM
 g_opcode_FolderElement_SetState :=
  PublishInternalOperation(en_FolderElement,
                    op_SetState,
                    en_capFolderElement,
                    op_capSetState);
 g_opcode_Tree_ExpandAll :=
  PublishOperation(en_Tree,
                    op_ExpandAll,
                    en_capTree,
                    op_capExpandAll);
 g_opcode_Tree_CollapseAll :=
  PublishOperation(en_Tree,
                    op_CollapseAll,
                    en_capTree,
                    op_capCollapseAll);
 g_opcode_Tree_Wrap :=
  PublishOperation(en_Tree,
                    op_Wrap,
                    en_capTree,
                    op_capWrap);
 PublishOperation(en_SavedQuery,
                    op_OpenQuery,
                    en_capSavedQuery,
                    op_capOpenQuery);
 PublishOperation(en_SavedQuery,
                    op_ExecuteQuery,
                    en_capSavedQuery,
                    op_capExecuteQuery);
 PublishOperation(en_Folders,
                    op_Filtrate,
                    en_capFolders,
                    op_capFiltrate);
 PublishOperation(en_Folder,
                    op_New,
                    en_capFolder,
                    op_capNew);
 PublishOperation(en_Folder,
                    op_AddToControl,
                    en_capFolder,
                    op_capAddToControl);
 PublishOperation(en_Folder,
                    op_DelFromControl,
                    en_capFolder,
                    op_capDelFromControl);
 PublishOperation(en_Folder,
                    op_SetShare,
                    en_capFolder,
                    op_capSetShare);
 PublishOperation(en_Folder,
                    op_ExportToXML,
                    en_capFolder,
                    op_capExportToXML);
 PublishOperation(en_Folder,
                    op_ImportFromXML,
                    en_capFolder,
                    op_capImportFromXML);
 PublishOperation(en_FolderElement,
                    op_Edit,
                    en_capFolderElement,
                    op_capEdit);
 PublishOperation(en_FolderElement,
                    op_EditExt,
                    en_capFolderElement,
                    op_capEditExt);
 PublishOperation(en_FolderElement,
                    op_Open,
                    en_capFolderElement,
                    op_capOpen);
 PublishOperation(en_FolderElement,
                    op_OpenNewWindow,
                    en_capFolderElement,
                    op_capOpenNewWindow);
 PublishOperation(en_FolderElement,
                    op_ControlStatus,
                    en_capFolderElement,
                    op_capControlStatus);
 PublishOperation(en_FolderElement,
                    op_ExportForIntegration,
                    en_capFolderElement,
                    op_capExportForIntegration);
 PublishOperation(en_SavedQuery,
                    op_CreateFilter,
                    en_capSavedQuery,
                    op_capCreateFilter);
 PublishOperation(en_Consultation,
                    op_Open,
                    en_capConsultation,
                    op_capOpen);
 PublishOperation(en_Consultation,
                    op_GiveMark,
                    en_capConsultation,
                    op_capGiveMark);
 PublishOperation(en_Consultation,
                    op_ShowConsultationInfo,
                    en_capConsultation,
                    op_capShowConsultationInfo);
 PublishOperation(en_Consultation,
                    op_ImportConsultation,
                    en_capConsultation,
                    op_capImportConsultation);
 g_opcode_FolderElement_InternalEditByFoldersNode :=
  PublishInternalOperation(en_FolderElement,
                    op_InternalEditByFoldersNode,
                    en_capFolderElement,
                    op_capInternalEditByFoldersNode);
 g_opcode_FolderElement_InternalDelete :=
  PublishInternalOperation(en_FolderElement,
                    op_InternalDelete,
                    en_capFolderElement,
                    op_capInternalDelete);
 g_opcode_FolderElement_InternalEdit :=
  PublishInternalOperation(en_FolderElement,
                    op_InternalEdit,
                    en_capFolderElement,
                    op_capInternalEdit);
 g_opcode_FolderElement_DisableFilter :=
  PublishInternalOperation(en_FolderElement,
                    op_DisableFilter,
                    en_capFolderElement,
                    op_capDisableFilter);
 g_opcode_SavedQuery_SetFilterState :=
  PublishInternalOperation(en_SavedQuery,
                    op_SetFilterState,
                    en_capSavedQuery,
                    op_capSetFilterState);
 g_opcode_Folders_SetCurrent :=
  PublishInternalOperation(en_Folders,
                    op_SetCurrent,
                    en_capFolders,
                    op_capSetCurrent);
 g_opcode_Folders_FiltrateByFilterInfo :=
  PublishInternalOperation(en_Folders,
                    op_FiltrateByFilterInfo,
                    en_capFolders,
                    op_capFiltrateByFilterInfo);
 g_opcode_Folders_TryOpenConsultationAnswer :=
  PublishInternalOperation(en_Folders,
                    op_TryOpenConsultationAnswer,
                    en_capFolders,
                    op_capTryOpenConsultationAnswer);
 g_opcode_Folders_OpenMyConsultations :=
  PublishInternalOperation(en_Folders,
                    op_OpenMyConsultations,
                    en_capFolders,
                    op_capOpenMyConsultations);
 g_opcode_Folders_SetInfoContent :=
  PublishInternalOperation(en_Folders,
                    op_SetInfoContent,
                    en_capFolders,
                    op_capSetInfoContent);
 g_opcode_FolderElement_GetState :=
  PublishInternalOperation(en_FolderElement,
                    op_GetState,
                    en_capFolderElement,
                    op_capGetState);
 g_opcode_FolderElement_SetLoadInfo :=
  PublishInternalOperation(en_FolderElement,
                    op_SetLoadInfo,
                    en_capFolderElement,
                    op_capSetLoadInfo);
 g_opcode_FolderElement_SetContent :=
  PublishInternalOperation(en_FolderElement,
                    op_SetContent,
                    en_capFolderElement,
                    op_capSetContent);
 g_opcode_FolderElement_SetSaveInfo :=
  PublishInternalOperation(en_FolderElement,
                    op_SetSaveInfo,
                    en_capFolderElement,
                    op_capSetSaveInfo);
 g_opcode_FolderElement_ResetModificationOnDelete :=
  PublishInternalOperation(en_FolderElement,
                    op_ResetModificationOnDelete,
                    en_capFolderElement,
                    op_capResetModificationOnDelete);
 g_opcode_FolderElement_SetFocus :=
  PublishInternalOperation(en_FolderElement,
                    op_SetFocus,
                    en_capFolderElement,
                    op_capSetFocus);
 g_opcode_FolderElement_Redraw :=
  PublishInternalOperation(en_FolderElement,
                    op_Redraw,
                    en_capFolderElement,
                    op_capRedraw);
 g_opcode_FolderElement_DisableSecurityPage :=
  PublishInternalOperation(en_FolderElement,
                    op_DisableSecurityPage,
                    en_capFolderElement,
                    op_capDisableSecurityPage);
 g_opcode_UsersRights_UpdateRights :=
  PublishInternalOperation(en_UsersRights,
                    op_UpdateRights,
                    en_capUsersRights,
                    op_capUpdateRights);
 g_opcode_UsersRights_FolderShareChanged :=
  PublishInternalOperation(en_UsersRights,
                    op_FolderShareChanged,
                    en_capUsersRights,
                    op_capFolderShareChanged);
 g_opcode_Result_ExternalOk :=
  PublishInternalOperation(en_Result,
                    op_ExternalOk,
                    en_capResult,
                    op_capExternalOk);
 g_opcode_Loadable_Load :=
  PublishInternalOperation(en_Loadable,
                    op_Load,
                    en_capLoadable,
                    op_capLoad);
 g_opcode_Document_SetActive :=
  PublishInternalOperation(en_Document,
                    op_SetActive,
                    en_capDocument,
                    op_capSetActive);
 g_opcode_Document_ExportBlock :=
  PublishInternalOperation(en_Document,
                    op_ExportBlock,
                    en_capDocument,
                    op_capExportBlock);
 g_opcode_Document_GetCurrentPosition :=
  PublishInternalOperation(en_Document,
                    op_GetCurrentPosition,
                    en_capDocument,
                    op_capGetCurrentPosition);
 g_opcode_Document_SelectBlock :=
  PublishInternalOperation(en_Document,
                    op_SelectBlock,
                    en_capDocument,
                    op_capSelectBlock);
 g_opcode_Document_CopyBlock :=
  PublishInternalOperation(en_Document,
                    op_CopyBlock,
                    en_capDocument,
                    op_capCopyBlock);
 g_opcode_Document_PrintBlock :=
  PublishInternalOperation(en_Document,
                    op_PrintBlock,
                    en_capDocument,
                    op_capPrintBlock);
 g_opcode_Document_PrintDialogBlock :=
  PublishInternalOperation(en_Document,
                    op_PrintDialogBlock,
                    en_capDocument,
                    op_capPrintDialogBlock);
 g_opcode_Document_PreviewBlock :=
  PublishInternalOperation(en_Document,
                    op_PreviewBlock,
                    en_capDocument,
                    op_capPreviewBlock);
 g_opcode_Document_ShowRespondentListToPart :=
  PublishInternalOperation(en_Document,
                    op_ShowRespondentListToPart,
                    en_capDocument,
                    op_capShowRespondentListToPart);
 g_opcode_Document_ShowCorrespondentListToPart :=
  PublishInternalOperation(en_Document,
                    op_ShowCorrespondentListToPart,
                    en_capDocument,
                    op_capShowCorrespondentListToPart);
 g_opcode_Document_ModifyBookmarkNotify :=
  PublishInternalOperation(en_Document,
                    op_ModifyBookmarkNotify,
                    en_capDocument,
                    op_capModifyBookmarkNotify);
 g_opcode_Document_AddBookmarkFromContents :=
  PublishInternalOperation(en_Document,
                    op_AddBookmarkFromContents,
                    en_capDocument,
                    op_capAddBookmarkFromContents);
 g_opcode_Document_OpenNotSureTopic :=
  PublishInternalOperation(en_Document,
                    op_OpenNotSureTopic,
                    en_capDocument,
                    op_capOpenNotSureTopic);
 g_opcode_Document_GotoPara :=
  PublishInternalOperation(en_Document,
                    op_GotoPara,
                    en_capDocument,
                    op_capGotoPara);
 g_module_opcode_Folders_MyInformation := 
  PublishModuleOperation(Tmo_Folders, 'MyInformation', 'Моя информация');
 g_module_opcode_Folders_MyConsultations := 
  PublishModuleOperation(Tmo_Folders, 'MyConsultations', 'Мои консультации');
 g_module_opcode_Folders_UnderControlOpenFrmAct := 
  PublishModuleOperation(Tmo_Folders, 'UnderControlOpenFrmAct', 'Документы на контроле');
 g_module_opcode_Folders_OpenFrmAct := 
  PublishModuleOperation(Tmo_Folders, 'OpenFrmAct', 'Мои документы');
 g_opcode_List_SetNewContent :=
  PublishInternalOperation(en_List,
                    op_SetNewContent,
                    en_capList,
                    op_capSetNewContent);
 PublishOperation(en_Chat,
                    op_History,
                    en_capChat,
                    op_capHistory);
 PublishOperation(en_Chat,
                    op_UserFilter,
                    en_capChat,
                    op_capUserFilter);
 PublishOperation(en_Chat,
                    op_OpenChatWindow,
                    en_capChat,
                    op_capOpenChatWindow);
 PublishOperation(en_Chat,
                    op_Add,
                    en_capChat,
                    op_capAdd);
 g_opcode_Result_OkExt :=
  PublishOperation(en_Result,
                    op_OkExt,
                    en_capResult,
                    op_capOkExt);
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'Search') do
  begin
   st_user_Result_OkExt_Search := StateIndex;
   Caption := 'Искать';
   Hint := 'Провести поиск по выбранным параметрам';
  end;//with PublishOperationState(en_Result, op_OkExt, 'Search')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'Save') do
  begin
   st_user_Result_OkExt_Save := StateIndex;
   Caption := 'Сохранить';
   Hint := 'Сохранить';
  end;//with PublishOperationState(en_Result, op_OkExt, 'Save')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'AttributesSelect') do
  begin
   st_user_Result_OkExt_AttributesSelect := StateIndex;
  end;//with PublishOperationState(en_Result, op_OkExt, 'AttributesSelect')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'Consult') do
  begin
   st_user_Result_OkExt_Consult := StateIndex;
   Caption := 'Отправить запрос';
   ImageIndex := 154;
  end;//with PublishOperationState(en_Result, op_OkExt, 'Consult')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'Chat') do
  begin
   st_user_Result_OkExt_Chat := StateIndex;
   Caption := 'Отправить (Ctrl+Enter)';
  end;//with PublishOperationState(en_Result, op_OkExt, 'Chat')
 {$IfEnd} //not NoVCM
 {$If not defined(Monitorings) AND not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'SaveAndSend') do
  begin
   st_user_Result_OkExt_SaveAndSend := StateIndex;
   Caption := 'Сохранить и отправить';
   Hint := 'Сохранить и отправить';
  end;//with PublishOperationState(en_Result, op_OkExt, 'SaveAndSend')
 {$IfEnd} //not Monitorings AND not NoVCM
 PublishOperation(en_Chat,
                    op_ClearHistory,
                    en_capChat,
                    op_capClearHistory);
 g_module_opcode_Chat_OpenContactList := 
  PublishModuleOperation(Tmo_Chat, 'OpenContactList', '');
 PublishOperation(en_Journal,
                    op_Clear,
                    en_capJournal,
                    op_capClear);
 g_module_opcode_WorkJournal_OpenJournal := 
  PublishModuleOperation(Tmo_WorkJournal, 'OpenJournal', '');
 PublishOperation(en_NewsThemes,
                    op_SelectCurrent,
                    en_capNewsThemes,
                    op_capSelectCurrent);
 PublishOperation(en_DateInterval,
                    op_Open,
                    en_capDateInterval,
                    op_capOpen);
 g_opcode_DateInterval_OpenInt :=
  PublishInternalOperation(en_DateInterval,
                    op_OpenInt,
                    en_capDateInterval,
                    op_capOpenInt);
 g_opcode_Form_RequestClose :=
  PublishInternalOperation(en_Form,
                    op_RequestClose,
                    en_capForm,
                    op_capRequestClose);
 g_module_opcode_Monitorings_OpenNewsLine := 
  PublishModuleOperation(Tmo_Monitorings, 'OpenNewsLine', 'Новостная лента');
 g_module_opcode_Monitorings_OpenLegislationReview := 
  PublishModuleOperation(Tmo_Monitorings, 'OpenLegislationReview', 'Обзор изменений законодательства');
 g_opcode_SearchSupport_ActivatePostingsListForm :=
  PublishInternalOperation(en_SearchSupport,
                    op_ActivatePostingsListForm,
                    en_capSearchSupport,
                    op_capActivatePostingsListForm);
 g_module_opcode_Common_ComplectInfo := 
  PublishModuleOperation(Tmo_Common, 'ComplectInfo', 'Информация о комплекте');
 g_module_opcode_Common_PageSetup := 
  PublishModuleOperation(Tmo_Common, 'PageSetup', 'Настройка страницы...');
 g_module_opcode_Common_ShowEULA := 
  PublishModuleOperation(Tmo_Common, 'ShowEULA', 'Условия использования');
 g_module_opcode_Common_OpenMainMenuByButton := 
  PublishModuleOperation(Tmo_Common, 'OpenMainMenuByButton', 'Основное меню системы ГАРАНТ');
 g_module_opcode_Common_OpenMainMenuNew := 
  PublishModuleOperation(Tmo_Common, 'OpenMainMenuNew', 'Основное меню', true);
 PublishOperation(en_Fake,
                    op_Fake,
                    en_capFake,
                    op_capFake);
 g_module_opcode_Common_TasksPanel := 
  PublishModuleOperation(Tmo_Common, 'TasksPanel', 'Панель задач');
 g_module_opcode_Common_LetterToDevelopers := 
  PublishModuleOperation(Tmo_Common, 'LetterToDevelopers', 'Письмо разработчикам', true);
 PublishOperation(en_NavigatorElement,
                    op_Info,
                    en_capNavigatorElement,
                    op_capInfo);
 PublishOperation(en_NavigatorElement,
                    op_Execute,
                    en_capNavigatorElement,
                    op_capExecute);
 g_opcode_Navigator_SetCurrent :=
  PublishInternalOperation(en_Navigator,
                    op_SetCurrent,
                    en_capNavigator,
                    op_capSetCurrent);
 g_module_opcode_Common_OpenRubricator := 
  PublishModuleOperation(Tmo_Common, 'OpenRubricator', 'Правовой навигатор');
 g_module_opcode_Common_OpenInformation := 
  PublishModuleOperation(Tmo_Common, 'OpenInformation', 'Справочная информация');
 g_module_opcode_Common_get_navigator := 
  PublishModuleOperation(Tmo_Common, 'get_navigator', 'Меню (вкладка)', true);
 g_module_opcode_Common_OpenIntranet := 
  PublishModuleOperation(Tmo_Common, 'OpenIntranet', '');
 g_opcode_PrintParams_UpdatePrinter :=
  PublishInternalOperation(en_PrintParams,
                    op_UpdatePrinter,
                    en_capPrintParams,
                    op_capUpdatePrinter);
 g_opcode_Rubricator_SetListRoot :=
  PublishInternalOperation(en_Rubricator,
                    op_SetListRoot,
                    en_capRubricator,
                    op_capSetListRoot);
 g_opcode_Rubricator_InitListRoot :=
  PublishInternalOperation(en_Rubricator,
                    op_InitListRoot,
                    en_capRubricator,
                    op_capInitListRoot);
 g_opcode_Rubricator_Synchronize :=
  PublishInternalOperation(en_Rubricator,
                    op_Synchronize,
                    en_capRubricator,
                    op_capSynchronize);
 g_opcode_Rubricator_GetRoot :=
  PublishInternalOperation(en_Rubricator,
                    op_GetRoot,
                    en_capRubricator,
                    op_capGetRoot);
 PublishOperation(en_File,
                    op_SaveToFolder,
                    en_capFile,
                    op_capSaveToFolder);
 PublishOperation(en_File,
                    op_LoadFromFolder,
                    en_capFile,
                    op_capLoadFromFolder);
 g_opcode_Document_GetAttributesFrmAct :=
  PublishOperation(en_Document,
                    op_GetAttributesFrmAct,
                    en_capDocument,
                    op_capGetAttributesFrmAct);
  with PublishOperationState(en_Document, op_GetAttributesFrmAct, 'Picture') do
  begin
   st_user_Document_GetAttributesFrmAct_Picture := StateIndex;
   Caption := 'Информация о картинке';
  end;//with PublishOperationState(en_Document, op_GetAttributesFrmAct, 'Picture')
 g_opcode_Document_OpenCorrespondentList :=
  PublishInternalOperation(en_Document,
                    op_OpenCorrespondentList,
                    en_capDocument,
                    op_capOpenCorrespondentList);
 g_opcode_Document_OpenRespondentList :=
  PublishInternalOperation(en_Document,
                    op_OpenRespondentList,
                    en_capDocument,
                    op_capOpenRespondentList);
 g_opcode_Document_GetRelatedDocFrmAct :=
  PublishOperation(en_Document,
                    op_GetRelatedDocFrmAct,
                    en_capDocument,
                    op_capGetRelatedDocFrmAct);
 g_opcode_Document_GetCorrespondentList :=
  PublishOperation(en_Document,
                    op_GetCorrespondentList,
                    en_capDocument,
                    op_capGetCorrespondentList);
 g_opcode_Document_GetRespondentList :=
  PublishOperation(en_Document,
                    op_GetRespondentList,
                    en_capDocument,
                    op_capGetRespondentList);
 g_opcode_Document_AttributesCanBeClosed :=
  PublishInternalOperation(en_Document,
                    op_AttributesCanBeClosed,
                    en_capDocument,
                    op_capAttributesCanBeClosed);
 g_opcode_Document_CommonDocumentOpenNewWindow :=
  PublishInternalOperation(en_Document,
                    op_CommonDocumentOpenNewWindow,
                    en_capDocument,
                    op_capCommonDocumentOpenNewWindow);
 g_opcode_Document_GetCorrespondentListExFrmAct :=
  PublishOperation(en_Document,
                    op_GetCorrespondentListExFrmAct,
                    en_capDocument,
                    op_capGetCorrespondentListExFrmAct);
 g_opcode_Document_GetRespondentListExFrmAct :=
  PublishOperation(en_Document,
                    op_GetRespondentListExFrmAct,
                    en_capDocument,
                    op_capGetRespondentListExFrmAct);
 g_opcode_Document_CommonDocumentOpenNewTab :=
  PublishInternalOperation(en_Document,
                    op_CommonDocumentOpenNewTab,
                    en_capDocument,
                    op_capCommonDocumentOpenNewTab);
 g_opcode_Document_DocumentIsUseful :=
  PublishOperation(en_Document,
                    op_DocumentIsUseful,
                    en_capDocument,
                    op_capDocumentIsUseful);
 g_opcode_Document_DocumentIsUseless :=
  PublishOperation(en_Document,
                    op_DocumentIsUseless,
                    en_capDocument,
                    op_capDocumentIsUseless);
 g_opcode_Document_PrevDocumentInList :=
  PublishOperation(en_Document,
                    op_PrevDocumentInList,
                    en_capDocument,
                    op_capPrevDocumentInList);
 g_opcode_Document_NextDocumentInList :=
  PublishOperation(en_Document,
                    op_NextDocumentInList,
                    en_capDocument,
                    op_capNextDocumentInList);
 g_opcode_Document_ReturnToList :=
  PublishOperation(en_Document,
                    op_ReturnToList,
                    en_capDocument,
                    op_capReturnToList);
 PublishOperation(en_Document,
                    op_AddToControl,
                    en_capDocument,
                    op_capAddToControl);
  with PublishOperationState(en_Document, op_AddToControl, 'RemoveFromControl') do
  begin
   st_user_Document_AddToControl_RemoveFromControl := StateIndex;
   Caption := 'Снять с контроля';
   Checked := true;
  end;//with PublishOperationState(en_Document, op_AddToControl, 'RemoveFromControl')
 PublishOperation(en_Document,
                    op_UserCR1,
                    en_capDocument,
                    op_capUserCR1);
  with PublishOperationState(en_Document, op_UserCR1, 'Corr') do
  begin
   st_user_Document_UserCR1_Corr := StateIndex;
   ImageIndex := 18;
  end;//with PublishOperationState(en_Document, op_UserCR1, 'Corr')
 PublishOperation(en_Document,
                    op_UserCR2,
                    en_capDocument,
                    op_capUserCR2);
  with PublishOperationState(en_Document, op_UserCR2, 'Corr') do
  begin
   st_user_Document_UserCR2_Corr := StateIndex;
   ImageIndex := 18;
  end;//with PublishOperationState(en_Document, op_UserCR2, 'Corr')
 PublishOperation(en_Document,
                    op_AddBookmark,
                    en_capDocument,
                    op_capAddBookmark);
 PublishOperation(en_Document,
                    op_GetGraphicImage,
                    en_capDocument,
                    op_capGetGraphicImage);
 PublishOperation(en_File,
                    op_MakeHyperlinkToDocument,
                    en_capFile,
                    op_capMakeHyperlinkToDocument);
 PublishOperation(en_Text,
                    op_MakeHyperlinkToDocument,
                    en_capText,
                    op_capMakeHyperlinkToDocument);
 PublishOperation(en_Document,
                    op_MakeHyperlinkToDocument,
                    en_capDocument,
                    op_capMakeHyperlinkToDocument);
 PublishOperation(en_Openable,
                    op_OpenInNewWindow,
                    en_capOpenable,
                    op_capOpenInNewWindow);
 PublishOperation(en_SubPanelSettings,
                    op_Show,
                    en_capSubPanelSettings,
                    op_capShow);
 PublishOperation(en_Reminder,
                    op_RemWarnJuror,
                    en_capReminder,
                    op_capRemWarnJuror);
 PublishOperation(en_Reminder,
                    op_RemWarnTimeMachineOn,
                    en_capReminder,
                    op_capRemWarnTimeMachineOn);
 PublishOperation(en_Reminder,
                    op_RemWarnRedaction,
                    en_capReminder,
                    op_capRemWarnRedaction);
 PublishOperation(en_Reminder,
                    op_RemWarnOnControl,
                    en_capReminder,
                    op_capRemWarnOnControl);
 PublishOperation(en_Reminder,
                    op_RemWarnIsAbolished,
                    en_capReminder,
                    op_capRemWarnIsAbolished);
 PublishOperation(en_Reminder,
                    op_RemWarnTimeMachineException,
                    en_capReminder,
                    op_capRemWarnTimeMachineException);
 PublishOperation(en_Reminder,
                    op_RemWarnPreActive,
                    en_capReminder,
                    op_capRemWarnPreActive);
 PublishOperation(en_Reminder,
                    op_RemWarnTimeMachineWarning,
                    en_capReminder,
                    op_capRemWarnTimeMachineWarning);
 PublishOperation(en_Reminder,
                    op_ViewInactualDocument,
                    en_capReminder,
                    op_capViewInactualDocument);
 PublishOperation(en_Document,
                    op_ChangesButton,
                    en_capDocument,
                    op_capChangesButton);
 PublishOperation(en_SubsPanel,
                    op_CopySubNumber,
                    en_capSubsPanel,
                    op_capCopySubNumber);
 PublishOperation(en_SubPanelSettings,
                    op_ShowByShortCut,
                    en_capSubPanelSettings,
                    op_capShowByShortCut);
 g_opcode_Document_CompareEditions :=
  PublishOperation(en_Document,
                    op_CompareEditions,
                    en_capDocument,
                    op_capCompareEditions);
  with PublishOperationState(en_Document, op_CompareEditions, 'ShowChanges') do
  begin
   st_user_Document_CompareEditions_ShowChanges := StateIndex;
   Caption := 'Показать изменения';
  end;//with PublishOperationState(en_Document, op_CompareEditions, 'ShowChanges')
 g_opcode_System_TimeMachineStateChange :=
  PublishInternalOperation(en_System,
                    op_TimeMachineStateChange,
                    en_capSystem,
                    op_capTimeMachineStateChange, true);
 g_opcode_Document_FindExplanation :=
  PublishInternalOperation(en_Document,
                    op_FindExplanation,
                    en_capDocument,
                    op_capFindExplanation);
 PublishOperation(en_Selection,
                    op_InsertHyperlink,
                    en_capSelection,
                    op_capInsertHyperlink, true);
  with PublishOperationState(en_Selection, op_InsertHyperlink, 'ModifyLink', true) do
  begin
   st_user_Selection_InsertHyperlink_ModifyLink := StateIndex;
   Caption := 'Изменить ссылку...';
  end;//with PublishOperationState(en_Selection, op_InsertHyperlink, 'ModifyLink', true)
 PublishOperation(en_Selection,
                    op_FindInDict,
                    en_capSelection,
                    op_capFindInDict);
 g_opcode_TimeMachine_TimeMachineOnOffNew :=
  PublishOperation(en_TimeMachine,
                    op_TimeMachineOnOffNew,
                    en_capTimeMachine,
                    op_capTimeMachineOnOffNew);
  with PublishOperationState(en_TimeMachine, op_TimeMachineOnOffNew, 'MachineOn') do
  begin
   st_user_TimeMachine_TimeMachineOnOffNew_MachineOn := StateIndex;
  end;//with PublishOperationState(en_TimeMachine, op_TimeMachineOnOffNew, 'MachineOn')
  with PublishOperationState(en_TimeMachine, op_TimeMachineOnOffNew, 'MachineOff') do
  begin
   st_user_TimeMachine_TimeMachineOnOffNew_MachineOff := StateIndex;
   Caption := 'Выключить Машину времени/Изменить дату';
   ImageIndex := 110;
  end;//with PublishOperationState(en_TimeMachine, op_TimeMachineOnOffNew, 'MachineOff')
 g_opcode_TimeMachine_TimeMachineOnOff :=
  PublishInternalOperation(en_TimeMachine,
                    op_TimeMachineOnOff,
                    en_capTimeMachine,
                    op_capTimeMachineOnOff);
 g_opcode_TimeMachine_TimeMachineOffAndReset :=
  PublishInternalOperation(en_TimeMachine,
                    op_TimeMachineOffAndReset,
                    en_capTimeMachine,
                    op_capTimeMachineOffAndReset);
 PublishOperation(en_Edit,
                    op_ToggleFoundWords,
                    en_capEdit,
                    op_capToggleFoundWords);
 PublishOperation(en_DocumentBlock,
                    op_GetTypedCorrespondentList,
                    en_capDocumentBlock,
                    op_capGetTypedCorrespondentList);
  with PublishOperationState(en_DocumentBlock, op_GetTypedCorrespondentList, 'InText') do
  begin
   st_user_DocumentBlock_GetTypedCorrespondentList_InText := StateIndex;
   Caption := 'Ссылки на фрагмент:';
  end;//with PublishOperationState(en_DocumentBlock, op_GetTypedCorrespondentList, 'InText')
 PublishOperation(en_DocumentBlock,
                    op_PrintPreview,
                    en_capDocumentBlock,
                    op_capPrintPreview);
 PublishOperation(en_DocumentBlock,
                    op_Select,
                    en_capDocumentBlock,
                    op_capSelect);
 PublishOperation(en_DocumentBlock,
                    op_GetSimilarDocsToBlock,
                    en_capDocumentBlock,
                    op_capGetSimilarDocsToBlock);
 PublishOperation(en_DocumentBlock,
                    op_GetCorrespondentList,
                    en_capDocumentBlock,
                    op_capGetCorrespondentList);
 PublishOperation(en_DocumentBlock,
                    op_GetRespondentList,
                    en_capDocumentBlock,
                    op_capGetRespondentList);
 PublishOperation(en_DocumentBlock,
                    op_GetTypedRespondentList,
                    en_capDocumentBlock,
                    op_capGetTypedRespondentList);
 PublishOperation(en_DocumentBlock,
                    op_ToMSWord,
                    en_capDocumentBlock,
                    op_capToMSWord);
 PublishOperation(en_DocumentBlock,
                    op_PrintDialog,
                    en_capDocumentBlock,
                    op_capPrintDialog);
 PublishOperation(en_DocumentBlock,
                    op_Copy,
                    en_capDocumentBlock,
                    op_capCopy);
 PublishOperation(en_DocumentBlock,
                    op_Print,
                    en_capDocumentBlock,
                    op_capPrint);
 PublishOperation(en_Document,
                    op_GetAnnotationDocFrmAct,
                    en_capDocument,
                    op_capGetAnnotationDocFrmAct);
 PublishOperation(en_Document,
                    op_SimilarDocuments,
                    en_capDocument,
                    op_capSimilarDocuments);
 g_opcode_DocumentBlockHeader_UserCR1 :=
  PublishOperation(en_DocumentBlockHeader,
                    op_UserCR1,
                    en_capDocumentBlockHeader,
                    op_capUserCR1);
  with PublishOperationState(en_DocumentBlockHeader, op_UserCR1, 'Corr') do
  begin
   st_user_DocumentBlockHeader_UserCR1_Corr := StateIndex;
   ImageIndex := 18;
  end;//with PublishOperationState(en_DocumentBlockHeader, op_UserCR1, 'Corr')
 g_opcode_DocumentBlockHeader_UserCR2 :=
  PublishOperation(en_DocumentBlockHeader,
                    op_UserCR2,
                    en_capDocumentBlockHeader,
                    op_capUserCR2);
  with PublishOperationState(en_DocumentBlockHeader, op_UserCR2, 'Corr') do
  begin
   st_user_DocumentBlockHeader_UserCR2_Corr := StateIndex;
   ImageIndex := 18;
  end;//with PublishOperationState(en_DocumentBlockHeader, op_UserCR2, 'Corr')
 g_opcode_DocumentBlockHeader_GetTypedCorrespondentList :=
  PublishOperation(en_DocumentBlockHeader,
                    op_GetTypedCorrespondentList,
                    en_capDocumentBlockHeader,
                    op_capGetTypedCorrespondentList);
 g_opcode_DocumentBlockHeader_AddBookmark :=
  PublishOperation(en_DocumentBlockHeader,
                    op_AddBookmark,
                    en_capDocumentBlockHeader,
                    op_capAddBookmark);
 g_opcode_DocumentBlockHeader_ToMSWord :=
  PublishOperation(en_DocumentBlockHeader,
                    op_ToMSWord,
                    en_capDocumentBlockHeader,
                    op_capToMSWord);
 g_opcode_DocumentBlockHeader_Print :=
  PublishOperation(en_DocumentBlockHeader,
                    op_Print,
                    en_capDocumentBlockHeader,
                    op_capPrint);
 g_opcode_DocumentBlockHeader_PrintDialog :=
  PublishOperation(en_DocumentBlockHeader,
                    op_PrintDialog,
                    en_capDocumentBlockHeader,
                    op_capPrintDialog);
 PublishOperation(en_Text,
                    op_AddToControl,
                    en_capText,
                    op_capAddToControl);
  with PublishOperationState(en_Text, op_AddToControl, 'RemoveFromControl') do
  begin
   st_user_Text_AddToControl_RemoveFromControl := StateIndex;
   Caption := 'Снять с контроля';
   Checked := true;
  end;//with PublishOperationState(en_Text, op_AddToControl, 'RemoveFromControl')
 PublishOperation(en_Selection,
                    op_ShowCorrespondentListToPart,
                    en_capSelection,
                    op_capShowCorrespondentListToPart);
 PublishOperation(en_Selection,
                    op_ShowRespondentListToPart,
                    en_capSelection,
                    op_capShowRespondentListToPart);
 PublishOperation(en_WarnOnControl,
                    op_ClearStatusSettings,
                    en_capWarnOnControl,
                    op_capClearStatusSettings);
 PublishOperation(en_WarnOnControl,
                    op_ShowChanges,
                    en_capWarnOnControl,
                    op_capShowChanges);
 PublishOperation(en_WarnOnControl,
                    op_ClearStatus,
                    en_capWarnOnControl,
                    op_capClearStatus);
 PublishOperation(en_TasksPanel,
                    op_TimeMachineOnOff,
                    en_capTasksPanel,
                    op_capTimeMachineOnOff);
  with PublishOperationState(en_TasksPanel, op_TimeMachineOnOff, 'On') do
  begin
   st_user_TasksPanel_TimeMachineOnOff_On := StateIndex;
   Caption := 'Включить Машину времени';
   ImageIndex := 111;
  end;//with PublishOperationState(en_TasksPanel, op_TimeMachineOnOff, 'On')
  with PublishOperationState(en_TasksPanel, op_TimeMachineOnOff, 'Off') do
  begin
   st_user_TasksPanel_TimeMachineOnOff_Off := StateIndex;
   Caption := 'Выключить Машину времени';
  end;//with PublishOperationState(en_TasksPanel, op_TimeMachineOnOff, 'Off')
 PublishOperation(en_Document,
                    op_OpenContentsFrmAct,
                    en_capDocument,
                    op_capOpenContentsFrmAct);
  with PublishOperationState(en_Document, op_OpenContentsFrmAct, 'Drug') do
  begin
   st_user_Document_OpenContentsFrmAct_Drug := StateIndex;
   Caption := 'Структура препарата';
  end;//with PublishOperationState(en_Document, op_OpenContentsFrmAct, 'Drug')
 PublishOperation(en_Document,
                    op_ShowDocumentPicture,
                    en_capDocument,
                    op_capShowDocumentPicture);
 PublishOperation(en_Document,
                    op_DocumentSynchroOpenWindow,
                    en_capDocument,
                    op_capDocumentSynchroOpenWindow, true);
 PublishOperation(en_Document,
                    op_DocumentSynchroOpenNewWindow,
                    en_capDocument,
                    op_capDocumentSynchroOpenNewWindow, true);
 PublishOperation(en_Document,
                    op_DictListOpenFrmAct,
                    en_capDocument,
                    op_capDictListOpenFrmAct);
 PublishOperation(en_Document,
                    op_GotoBookmark,
                    en_capDocument,
                    op_capGotoBookmark);
 PublishOperation(en_Document,
                    op_LiteratureListForDictionary,
                    en_capDocument,
                    op_capLiteratureListForDictionary);
 PublishOperation(en_Document,
                    op_OpenProducedDrugList,
                    en_capDocument,
                    op_capOpenProducedDrugList);
 PublishOperation(en_Document,
                    op_OpenSimilarDrugList,
                    en_capDocument,
                    op_capOpenSimilarDrugList);
 PublishOperation(en_ExternalObject,
                    op_Open,
                    en_capExternalObject,
                    op_capOpen);
 PublishOperation(en_ExternalObject,
                    op_Save,
                    en_capExternalObject,
                    op_capSave);
 PublishOperation(en_WarnRedaction,
                    op_ShowInfo,
                    en_capWarnRedaction,
                    op_capShowInfo, true);
  with PublishOperationState(en_WarnRedaction, op_ShowInfo, 'Hide', true) do
  begin
   st_user_WarnRedaction_ShowInfo_Hide := StateIndex;
   Caption := 'Скрыть текст предупреждения';
  end;//with PublishOperationState(en_WarnRedaction, op_ShowInfo, 'Hide', true)
 PublishOperation(en_WarnRedaction,
                    op_OpenActualRedaction,
                    en_capWarnRedaction,
                    op_capOpenActualRedaction, true);
 PublishOperation(en_WarnTimeMachine,
                    op_ShowInfo,
                    en_capWarnTimeMachine,
                    op_capShowInfo);
  with PublishOperationState(en_WarnTimeMachine, op_ShowInfo, 'Hide') do
  begin
   st_user_WarnTimeMachine_ShowInfo_Hide := StateIndex;
   Caption := 'Скрыть текст предупреждения';
  end;//with PublishOperationState(en_WarnTimeMachine, op_ShowInfo, 'Hide')
 PublishOperation(en_WarnTimeMachine,
                    op_TimeMachineOnOffNew,
                    en_capWarnTimeMachine,
                    op_capTimeMachineOnOffNew);
  with PublishOperationState(en_WarnTimeMachine, op_TimeMachineOnOffNew, 'MachineOn') do
  begin
   st_user_WarnTimeMachine_TimeMachineOnOffNew_MachineOn := StateIndex;
   Caption := 'Включить Машину времени';
   ImageIndex := 111;
  end;//with PublishOperationState(en_WarnTimeMachine, op_TimeMachineOnOffNew, 'MachineOn')
  with PublishOperationState(en_WarnTimeMachine, op_TimeMachineOnOffNew, 'MachineOff') do
  begin
   st_user_WarnTimeMachine_TimeMachineOnOffNew_MachineOff := StateIndex;
   Caption := 'Выключить Машину времени/Изменить дату';
  end;//with PublishOperationState(en_WarnTimeMachine, op_TimeMachineOnOffNew, 'MachineOff')
 PublishOperation(en_WarnJuror,
                    op_ShowInfo,
                    en_capWarnJuror,
                    op_capShowInfo, true);
  with PublishOperationState(en_WarnJuror, op_ShowInfo, 'Hide', true) do
  begin
   st_user_WarnJuror_ShowInfo_Hide := StateIndex;
   Caption := 'Скрыть текст предупреждения';
  end;//with PublishOperationState(en_WarnJuror, op_ShowInfo, 'Hide', true)
 PublishOperation(en_BookmarkIcon,
                    op_Delete,
                    en_capBookmarkIcon,
                    op_capDelete);
 PublishOperation(en_BookmarkIcon,
                    op_Edit,
                    en_capBookmarkIcon,
                    op_capEdit);
 PublishOperation(en_UserCommentIcon,
                    op_HideShow,
                    en_capUserCommentIcon,
                    op_capHideShow);
  with PublishOperationState(en_UserCommentIcon, op_HideShow, 'GarantHidden') do
  begin
   st_user_UserCommentIcon_HideShow_GarantHidden := StateIndex;
   Caption := 'Показать комментарии ГАРАНТа';
   ImageIndex := 207;
  end;//with PublishOperationState(en_UserCommentIcon, op_HideShow, 'GarantHidden')
  with PublishOperationState(en_UserCommentIcon, op_HideShow, 'GarantShown') do
  begin
   st_user_UserCommentIcon_HideShow_GarantShown := StateIndex;
   Caption := 'Скрыть комментарии ГАРАНТа';
   ImageIndex := 207;
  end;//with PublishOperationState(en_UserCommentIcon, op_HideShow, 'GarantShown')
  with PublishOperationState(en_UserCommentIcon, op_HideShow, 'UserShown') do
  begin
   st_user_UserCommentIcon_HideShow_UserShown := StateIndex;
   Caption := 'Скрыть мои комментарии';
   ImageIndex := 50;
  end;//with PublishOperationState(en_UserCommentIcon, op_HideShow, 'UserShown')
  with PublishOperationState(en_UserCommentIcon, op_HideShow, 'UserHidden') do
  begin
   st_user_UserCommentIcon_HideShow_UserHidden := StateIndex;
   Caption := 'Показать мои комментарии';
   ImageIndex := 50;
  end;//with PublishOperationState(en_UserCommentIcon, op_HideShow, 'UserHidden')
  with PublishOperationState(en_UserCommentIcon, op_HideShow, 'Invisible') do
  begin
   st_user_UserCommentIcon_HideShow_Invisible := StateIndex;
   Visible := false;
  end;//with PublishOperationState(en_UserCommentIcon, op_HideShow, 'Invisible')
  with PublishOperationState(en_UserCommentIcon, op_HideShow, 'VersionShown') do
  begin
   st_user_UserCommentIcon_HideShow_VersionShown := StateIndex;
   Caption := 'Выключить информацию об изменениях документа';
   ImageIndex := 206;
  end;//with PublishOperationState(en_UserCommentIcon, op_HideShow, 'VersionShown')
  with PublishOperationState(en_UserCommentIcon, op_HideShow, 'VersionHidden') do
  begin
   st_user_UserCommentIcon_HideShow_VersionHidden := StateIndex;
   Caption := 'Включить информацию об изменениях документа';
   ImageIndex := 206;
  end;//with PublishOperationState(en_UserCommentIcon, op_HideShow, 'VersionHidden')
 PublishOperation(en_UserCommentIcon,
                    op_Delete,
                    en_capUserCommentIcon,
                    op_capDelete);
 PublishOperation(en_UserComment,
                    op_Delete,
                    en_capUserComment,
                    op_capDelete);
 g_opcode_Text_AddUserComment :=
  PublishOperation(en_Text,
                    op_AddUserComment,
                    en_capText,
                    op_capAddUserComment);
 g_opcode_Text_DeleteBookmark :=
  PublishOperation(en_Text,
                    op_DeleteBookmark,
                    en_capText,
                    op_capDeleteBookmark);
 g_opcode_Text_EditBookmark :=
  PublishOperation(en_Text,
                    op_EditBookmark,
                    en_capText,
                    op_capEditBookmark);
 g_opcode_Text_AddBookmark :=
  PublishOperation(en_Text,
                    op_AddBookmark,
                    en_capText,
                    op_capAddBookmark);
 g_opcode_Text_OpenNewWindow :=
  PublishOperation(en_Text,
                    op_OpenNewWindow,
                    en_capText,
                    op_capOpenNewWindow);
 g_opcode_DocumentSubPanel_UpdateSubPanel :=
  PublishInternalOperation(en_DocumentSubPanel,
                    op_UpdateSubPanel,
                    en_capDocumentSubPanel,
                    op_capUpdateSubPanel);
 PublishOperation(en_DocumentBlockBookmarks,
                    op_AddBookmark,
                    en_capDocumentBlockBookmarks,
                    op_capAddBookmark);
 PublishOperation(en_IntranetSourcePoint,
                    op_GoToIntranet,
                    en_capIntranetSourcePoint,
                    op_capGoToIntranet);
 PublishOperation(en_Picture,
                    op_Open,
                    en_capPicture,
                    op_capOpen);
 PublishOperation(en_Picture,
                    op_OpenNewWindow,
                    en_capPicture,
                    op_capOpenNewWindow);
 PublishOperation(en_Picture,
                    op_OpenNewTab,
                    en_capPicture,
                    op_capOpenNewTab);
 g_opcode_BaseSearchPresentationHolder_GetBaseSearchPresentation :=
  PublishInternalOperation(en_BaseSearchPresentationHolder,
                    op_GetBaseSearchPresentation,
                    en_capBaseSearchPresentationHolder,
                    op_capGetBaseSearchPresentation);
 PublishOperation(en_Text,
                    op_SelectWord,
                    en_capText,
                    op_capSelectWord);
 PublishOperation(en_Text,
                    op_SelectPara,
                    en_capText,
                    op_capSelectPara);
 g_opcode_Switcher_SetFirstPageActive :=
  PublishInternalOperation(en_Switcher,
                    op_SetFirstPageActive,
                    en_capSwitcher,
                    op_capSetFirstPageActive);
 g_opcode_AACTextContainer_GetVScrollBar :=
  PublishInternalOperation(en_AACTextContainer,
                    op_GetVScrollBar,
                    en_capAACTextContainer,
                    op_capGetVScrollBar);
 g_opcode_AACTextContainer_SetJumpTo :=
  PublishInternalOperation(en_AACTextContainer,
                    op_SetJumpTo,
                    en_capAACTextContainer,
                    op_capSetJumpTo);
 PublishOperation(en_Table,
                    op_Insert,
                    en_capTable,
                    op_capInsert);
 PublishOperation(en_Table,
                    op_InsertRow,
                    en_capTable,
                    op_capInsertRow);
 PublishOperation(en_Table,
                    op_DeleteRow,
                    en_capTable,
                    op_capDeleteRow);
 PublishOperation(en_Table,
                    op_InsertColumn,
                    en_capTable,
                    op_capInsertColumn);
 PublishOperation(en_Table,
                    op_DeleteColumn,
                    en_capTable,
                    op_capDeleteColumn);
 PublishOperation(en_Font,
                    op_Bold,
                    en_capFont,
                    op_capBold);
 PublishOperation(en_Font,
                    op_Italic,
                    en_capFont,
                    op_capItalic);
 PublishOperation(en_Font,
                    op_Underline,
                    en_capFont,
                    op_capUnderline);
 PublishOperation(en_Font,
                    op_Strikeout,
                    en_capFont,
                    op_capStrikeout);
 PublishOperation(en_Edition,
                    op_OpenNewWindow,
                    en_capEdition,
                    op_capOpenNewWindow);
 PublishOperation(en_Edition,
                    op_OpenNewTab,
                    en_capEdition,
                    op_capOpenNewTab);
 g_opcode_Editions_SetCurrent :=
  PublishInternalOperation(en_Editions,
                    op_SetCurrent,
                    en_capEditions,
                    op_capSetCurrent);
 PublishOperation(en_Editions,
                    op_DoCompareEditions,
                    en_capEditions,
                    op_capDoCompareEditions);
 SetOperationImageIndex(
                    en_Editions,
                    op_DoCompareEditions,
                    200);
 PublishOperation(en_Editions,
                    op_BuildChangedFragments,
                    en_capEditions,
                    op_capBuildChangedFragments);
 SetOperationImageIndex(
                    en_Editions,
                    op_BuildChangedFragments,
                    205);
 g_opcode_Contents_SetCurrent :=
  PublishInternalOperation(en_Contents,
                    op_SetCurrent,
                    en_capContents,
                    op_capSetCurrent);
 g_opcode_Contents_MoveCurrent :=
  PublishInternalOperation(en_Contents,
                    op_MoveCurrent,
                    en_capContents,
                    op_capMoveCurrent);
 g_opcode_Contents_HasUserComments :=
  PublishInternalOperation(en_Contents,
                    op_HasUserComments,
                    en_capContents,
                    op_capHasUserComments);
 g_opcode_Contents_HasBookmarks :=
  PublishInternalOperation(en_Contents,
                    op_HasBookmarks,
                    en_capContents,
                    op_capHasBookmarks);
 g_opcode_Contents_ToggleContentsVisibility :=
  PublishInternalOperation(en_Contents,
                    op_ToggleContentsVisibility,
                    en_capContents,
                    op_capToggleContentsVisibility);
 g_opcode_Contents_IsContentsVisible :=
  PublishInternalOperation(en_Contents,
                    op_IsContentsVisible,
                    en_capContents,
                    op_capIsContentsVisible);
 g_opcode_ContentsValidator_IsDocumentAdornmentsChanged :=
  PublishInternalOperation(en_ContentsValidator,
                    op_IsDocumentAdornmentsChanged,
                    en_capContentsValidator,
                    op_capIsDocumentAdornmentsChanged);
 g_opcode_Comment_Changed :=
  PublishInternalOperation(en_Comment,
                    op_Changed,
                    en_capComment,
                    op_capChanged);
 PublishOperation(en_Picture,
                    op_Resize,
                    en_capPicture,
                    op_capResize);
 PublishOperation(en_Picture,
                    op_Enlarge,
                    en_capPicture,
                    op_capEnlarge);
 PublishOperation(en_Picture,
                    op_Shrink,
                    en_capPicture,
                    op_capShrink);
 PublishOperation(en_Picture,
                    op_ActualSize,
                    en_capPicture,
                    op_capActualSize);
 PublishOperation(en_Picture,
                    op_FitInWIndow,
                    en_capPicture,
                    op_capFitInWIndow);
 g_opcode_Picture_InitNewContent :=
  PublishInternalOperation(en_Picture,
                    op_InitNewContent,
                    en_capPicture,
                    op_capInitNewContent);
 g_module_opcode_Document_OpenDocOnNumber := 
  PublishModuleOperation(Tmo_Document, 'OpenDocOnNumber', 'Открыть документ по номеру');
 g_opcode_Warning_BecomeActive :=
  PublishInternalOperation(en_Warning,
                    op_BecomeActive,
                    en_capWarning,
                    op_capBecomeActive);
 g_opcode_Warning_SwitchActive :=
  PublishInternalOperation(en_Warning,
                    op_SwitchActive,
                    en_capWarning,
                    op_capSwitchActive);
 PublishOperation(en_Warning,
                    op_TimeMachineOffAndReset,
                    en_capWarning,
                    op_capTimeMachineOffAndReset);
 PublishOperation(en_Warning,
                    op_ActualRedaction,
                    en_capWarning,
                    op_capActualRedaction);
 PublishOperation(en_Warning,
                    op_TimeMachineOff,
                    en_capWarning,
                    op_capTimeMachineOff);
 PublishOperation(en_Attribute,
                    op_Copy,
                    en_capAttribute,
                    op_capCopy);
 PublishOperation(en_SynchroView,
                    op_ShowText,
                    en_capSynchroView,
                    op_capShowText, true);
 PublishOperation(en_SynchroView,
                    op_Annotation,
                    en_capSynchroView,
                    op_capAnnotation);
 PublishOperation(en_SynchroView,
                    op_ShowAttributes,
                    en_capSynchroView,
                    op_capShowAttributes, true);
 PublishOperation(en_SynchroView,
                    op_ShowRelated,
                    en_capSynchroView,
                    op_capShowRelated, true);
 PublishOperation(en_SynchroView,
                    op_ShowUserCRList1,
                    en_capSynchroView,
                    op_capShowUserCRList1, true);
 PublishOperation(en_SynchroView,
                    op_ShowUserCRList2,
                    en_capSynchroView,
                    op_capShowUserCRList2, true);
 PublishOperation(en_SynchroView,
                    op_SimilarDocuments,
                    en_capSynchroView,
                    op_capSimilarDocuments);
 g_opcode_SynchroView_BecomeActive :=
  PublishInternalOperation(en_SynchroView,
                    op_BecomeActive,
                    en_capSynchroView,
                    op_capBecomeActive);
 g_opcode_List_GetDeList :=
  PublishInternalOperation(en_List,
                    op_GetDeList,
                    en_capList,
                    op_capGetDeList);
 g_opcode_List_SetCurrentVisible :=
  PublishInternalOperation(en_List,
                    op_SetCurrentVisible,
                    en_capList,
                    op_capSetCurrentVisible);
 g_opcode_List_SwitchToFullList :=
  PublishOperation(en_List,
                    op_SwitchToFullList,
                    en_capList,
                    op_capSwitchToFullList);
 g_opcode_List_GetDsList :=
  PublishInternalOperation(en_List,
                    op_GetDsList,
                    en_capList,
                    op_capGetDsList);
 PublishOperation(en_Document,
                    op_Open,
                    en_capDocument,
                    op_capOpen);
 PublishOperation(en_Document,
                    op_OpenInNewTab,
                    en_capDocument,
                    op_capOpenInNewTab);
 PublishOperation(en_Document,
                    op_OpenNewWindow,
                    en_capDocument,
                    op_capOpenNewWindow);
 PublishOperation(en_Document,
                    op_PrintDialog,
                    en_capDocument,
                    op_capPrintDialog);
 PublishOperation(en_Document,
                    op_PrintPreview,
                    en_capDocument,
                    op_capPrintPreview);
 PublishOperation(en_Document,
                    op_Save,
                    en_capDocument,
                    op_capSave);
 PublishOperation(en_Document,
                    op_Print,
                    en_capDocument,
                    op_capPrint);
 PublishOperation(en_WarnListFiltered,
                    op_ClearAll,
                    en_capWarnListFiltered,
                    op_capClearAll);
 PublishOperation(en_Reminder,
                    op_RemListModified,
                    en_capReminder,
                    op_capRemListModified);
 PublishOperation(en_Reminder,
                    op_RemListFiltered,
                    en_capReminder,
                    op_capRemListFiltered);
 PublishOperation(en_Reminder,
                    op_RemListTimeMachineWarning,
                    en_capReminder,
                    op_capRemListTimeMachineWarning);
 PublishOperation(en_List,
                    op_WorkWithList,
                    en_capList,
                    op_capWorkWithList);
 PublishOperation(en_DocumentInList,
                    op_OpenDocumentInNewTab,
                    en_capDocumentInList,
                    op_capOpenDocumentInNewTab);
 PublishOperation(en_DocumentInList,
                    op_OpenDocumentInNewWindow,
                    en_capDocumentInList,
                    op_capOpenDocumentInNewWindow);
 PublishOperation(en_SelectedDocuments,
                    op_AddToControl,
                    en_capSelectedDocuments,
                    op_capAddToControl);
  with PublishOperationState(en_SelectedDocuments, op_AddToControl, 'RemoveFromControl') do
  begin
   st_user_SelectedDocuments_AddToControl_RemoveFromControl := StateIndex;
   Caption := 'Снять с контроля';
   Checked := true;
  end;//with PublishOperationState(en_SelectedDocuments, op_AddToControl, 'RemoveFromControl')
 PublishOperation(en_SelectedDocuments,
                    op_MakeHyperlinkToDocument,
                    en_capSelectedDocuments,
                    op_capMakeHyperlinkToDocument);
 g_opcode_Filterable_Add :=
  PublishInternalOperation(en_Filterable,
                    op_Add,
                    en_capFilterable,
                    op_capAdd);
 g_opcode_Filterable_Delete :=
  PublishInternalOperation(en_Filterable,
                    op_Delete,
                    en_capFilterable,
                    op_capDelete);
 g_opcode_Filterable_ClearAll :=
  PublishInternalOperation(en_Filterable,
                    op_ClearAll,
                    en_capFilterable,
                    op_capClearAll);
 g_opcode_Filterable_Refresh :=
  PublishInternalOperation(en_Filterable,
                    op_Refresh,
                    en_capFilterable,
                    op_capRefresh);
 g_opcode_Filterable_GetListType :=
  PublishInternalOperation(en_Filterable,
                    op_GetListType,
                    en_capFilterable,
                    op_capGetListType);
 g_opcode_Selection_Analize :=
  PublishOperation(en_Selection,
                    op_Analize,
                    en_capSelection,
                    op_capAnalize);
 PublishOperation(en_Selection,
                    op_CopyToNewList,
                    en_capSelection,
                    op_capCopyToNewList);
 g_opcode_LocalList_SearchInList :=
  PublishOperation(en_LocalList,
                    op_SearchInList,
                    en_capLocalList,
                    op_capSearchInList);
 PublishOperation(en_LocalList,
                    op_PublishSourceSearchInList,
                    en_capLocalList,
                    op_capPublishSourceSearchInList);
 PublishOperation(en_LocalList,
                    op_Open,
                    en_capLocalList,
                    op_capOpen);
 PublishOperation(en_LocalList,
                    op_SearchDrugInList,
                    en_capLocalList,
                    op_capSearchDrugInList);
 PublishOperation(en_LocalList,
                    op_OpenNewWindow,
                    en_capLocalList,
                    op_capOpenNewWindow);
 g_opcode_Filters_FiltersListOpen :=
  PublishOperation(en_Filters,
                    op_FiltersListOpen,
                    en_capFilters,
                    op_capFiltersListOpen);
 PublishOperation(en_List,
                    op_SortDirection,
                    en_capList,
                    op_capSortDirection);
  with PublishOperationState(en_List, op_SortDirection, 'Ascending') do
  begin
   st_user_List_SortDirection_Ascending := StateIndex;
   Caption := 'Отсортировано по возрастанию';
   Hint := 'Отсортировано по возрастанию значений';
  end;//with PublishOperationState(en_List, op_SortDirection, 'Ascending')
  with PublishOperationState(en_List, op_SortDirection, 'Descending') do
  begin
   st_user_List_SortDirection_Descending := StateIndex;
   Caption := 'Отсортировано по убыванию';
   Hint := 'Отсортировано по убыванию значений';
   ImageIndex := 14;
  end;//with PublishOperationState(en_List, op_SortDirection, 'Descending')
 g_opcode_List_Sort :=
  PublishOperation(en_List,
                    op_Sort,
                    en_capList,
                    op_capSort);
 PublishOperation(en_List,
                    op_AnalizeList,
                    en_capList,
                    op_capAnalizeList);
 PublishOperation(en_List,
                    op_SortForReminders,
                    en_capList,
                    op_capSortForReminders);
 PublishOperation(en_List,
                    op_SortDirectionForReminders,
                    en_capList,
                    op_capSortDirectionForReminders);
  with PublishOperationState(en_List, op_SortDirectionForReminders, 'Ascending') do
  begin
   st_user_List_SortDirectionForReminders_Ascending := StateIndex;
   Caption := 'Отсортировано по возрастанию';
  end;//with PublishOperationState(en_List, op_SortDirectionForReminders, 'Ascending')
  with PublishOperationState(en_List, op_SortDirectionForReminders, 'Descending') do
  begin
   st_user_List_SortDirectionForReminders_Descending := StateIndex;
   Caption := 'Отсортировано по убыванию';
   ImageIndex := 14;
  end;//with PublishOperationState(en_List, op_SortDirectionForReminders, 'Descending')
 PublishOperation(en_List,
                    op_OrAnotherListForReminders,
                    en_capList,
                    op_capOrAnotherListForReminders);
 PublishOperation(en_List,
                    op_AndAnotherListForReminders,
                    en_capList,
                    op_capAndAnotherListForReminders);
 PublishOperation(en_List,
                    op_AndNotAnotherListForReminders,
                    en_capList,
                    op_capAndNotAnotherListForReminders);
 PublishOperation(en_List,
                    op_SpecifyListForReminders,
                    en_capList,
                    op_capSpecifyListForReminders);
 PublishOperation(en_List,
                    op_ListInfo,
                    en_capList,
                    op_capListInfo);
 PublishOperation(en_List,
                    op_SpecifyList,
                    en_capList,
                    op_capSpecifyList);
 PublishOperation(en_List,
                    op_ExportToXML,
                    en_capList,
                    op_capExportToXML);
 PublishOperation(en_List,
                    op_OrAnotherList,
                    en_capList,
                    op_capOrAnotherList);
 PublishOperation(en_List,
                    op_AndAnotherList,
                    en_capList,
                    op_capAndAnotherList);
 PublishOperation(en_List,
                    op_AndNotAnotherList,
                    en_capList,
                    op_capAndNotAnotherList);
 PublishOperation(en_List,
                    op_Analize,
                    en_capList,
                    op_capAnalize);
 PublishOperation(en_Filters,
                    op_FiltersList,
                    en_capFilters,
                    op_capFiltersList);
 PublishOperation(en_Filters,
                    op_Clear,
                    en_capFilters,
                    op_capClear);
 g_opcode_Filters_InternalClear :=
  PublishInternalOperation(en_Filters,
                    op_InternalClear,
                    en_capFilters,
                    op_capInternalClear);
 g_opcode_CRList_SetType :=
  PublishOperation(en_CRList,
                    op_SetType,
                    en_capCRList,
                    op_capSetType, true);
 g_opcode_Filter_Activate :=
  PublishOperation(en_Filter,
                    op_Activate,
                    en_capFilter,
                    op_capActivate);
  with PublishOperationState(en_Filter, op_Activate, 'Deactivate') do
  begin
   st_user_Filter_Activate_Deactivate := StateIndex;
   Caption := 'Отменить фильтр';
   Checked := true;
  end;//with PublishOperationState(en_Filter, op_Activate, 'Deactivate')
 g_opcode_Filter_ActivateNode :=
  PublishInternalOperation(en_Filter,
                    op_ActivateNode,
                    en_capFilter,
                    op_capActivateNode);
 g_opcode_ListInfo_BecomeActive :=
  PublishInternalOperation(en_ListInfo,
                    op_BecomeActive,
                    en_capListInfo,
                    op_capBecomeActive);
 g_opcode_Filters_DeselectAll :=
  PublishInternalOperation(en_Filters,
                    op_DeselectAll,
                    en_capFilters,
                    op_capDeselectAll);
 PublishOperation(en_Lang,
                    op_Russian,
                    en_capLang,
                    op_capRussian);
 PublishOperation(en_Lang,
                    op_English,
                    en_capLang,
                    op_capEnglish);
 PublishOperation(en_Lang,
                    op_French,
                    en_capLang,
                    op_capFrench);
 PublishOperation(en_Lang,
                    op_Deutch,
                    en_capLang,
                    op_capDeutch);
 PublishOperation(en_Lang,
                    op_Italian,
                    en_capLang,
                    op_capItalian);
 PublishOperation(en_Lang,
                    op_Spanish,
                    en_capLang,
                    op_capSpanish);
 g_module_opcode_Diction_OpenDict := 
  PublishModuleOperation(Tmo_Diction, 'OpenDict', 'Толковый словарь');
 g_opcode_Query_ClearAll :=
  PublishInternalOperation(en_Query,
                    op_ClearAll,
                    en_capQuery,
                    op_capClearAll);
 g_opcode_Query_SetList :=
  PublishInternalOperation(en_Query,
                    op_SetList,
                    en_capQuery,
                    op_capSetList);
 g_opcode_Query_GetList :=
  PublishInternalOperation(en_Query,
                    op_GetList,
                    en_capQuery,
                    op_capGetList);
 PublishOperation(en_Result,
                    op_ClearAll,
                    en_capResult,
                    op_capClearAll);
 PublishOperation(en_Query,
                    op_GetOldQuery,
                    en_capQuery,
                    op_capGetOldQuery);
 PublishOperation(en_Query,
                    op_SearchType,
                    en_capQuery,
                    op_capSearchType);
 PublishOperation(en_LogicOperation,
                    op_LogicOr,
                    en_capLogicOperation,
                    op_capLogicOr);
 PublishOperation(en_LogicOperation,
                    op_LogicAnd,
                    en_capLogicOperation,
                    op_capLogicAnd);
 PublishOperation(en_LogicOperation,
                    op_LogicNot,
                    en_capLogicOperation,
                    op_capLogicNot);
 g_opcode_SearchParameters_IsQueryEmpty :=
  PublishInternalOperation(en_SearchParameters,
                    op_IsQueryEmpty,
                    en_capSearchParameters,
                    op_capIsQueryEmpty);
 g_opcode_SearchParameters_GetQuery :=
  PublishInternalOperation(en_SearchParameters,
                    op_GetQuery,
                    en_capSearchParameters,
                    op_capGetQuery);
 g_opcode_SearchParameters_IsQuerySaved :=
  PublishInternalOperation(en_SearchParameters,
                    op_IsQuerySaved,
                    en_capSearchParameters,
                    op_capIsQuerySaved);
 g_opcode_SearchParameters_SetQuery :=
  PublishInternalOperation(en_SearchParameters,
                    op_SetQuery,
                    en_capSearchParameters,
                    op_capSetQuery);
 g_opcode_SearchParameters_ClearQuery :=
  PublishInternalOperation(en_SearchParameters,
                    op_ClearQuery,
                    en_capSearchParameters,
                    op_capClearQuery);
 g_opcode_SearchParameter_QueryNotSaved :=
  PublishInternalOperation(en_SearchParameter,
                    op_QueryNotSaved,
                    en_capSearchParameter,
                    op_capQueryNotSaved);
 g_opcode_SearchParameter_ClearMistakes :=
  PublishInternalOperation(en_SearchParameter,
                    op_ClearMistakes,
                    en_capSearchParameter,
                    op_capClearMistakes);
 g_opcode_SearchParameter_QuerySaved :=
  PublishInternalOperation(en_SearchParameter,
                    op_QuerySaved,
                    en_capSearchParameter,
                    op_capQuerySaved);
 g_opcode_Attribute_DefaultAction :=
  PublishInternalOperation(en_Attribute,
                    op_DefaultAction,
                    en_capAttribute,
                    op_capDefaultAction);
 g_opcode_Attribute_LogicOr :=
  PublishOperation(en_Attribute,
                    op_LogicOr,
                    en_capAttribute,
                    op_capLogicOr);
 g_opcode_Attribute_LogicAnd :=
  PublishOperation(en_Attribute,
                    op_LogicAnd,
                    en_capAttribute,
                    op_capLogicAnd);
 g_opcode_Attribute_LogicNot :=
  PublishOperation(en_Attribute,
                    op_LogicNot,
                    en_capAttribute,
                    op_capLogicNot);
 g_opcode_Attribute_LogicOrShortcut :=
  PublishOperation(en_Attribute,
                    op_LogicOrShortcut,
                    en_capAttribute,
                    op_capLogicOrShortcut);
 g_module_opcode_Tips_ShowDayTips := 
  PublishModuleOperation(Tmo_Tips, 'ShowDayTips', '');
 PublishOperation(en_MedicFirmList,
                    op_CountryFilter,
                    en_capMedicFirmList,
                    op_capCountryFilter);
 PublishOperation(en_MedicListSynchroView,
                    op_OpenDocument,
                    en_capMedicListSynchroView,
                    op_capOpenDocument);
  with PublishOperationState(en_MedicListSynchroView, op_OpenDocument, 'Drug') do
  begin
   st_user_MedicListSynchroView_OpenDocument_Drug := StateIndex;
   Caption := 'Описание препарата';
  end;//with PublishOperationState(en_MedicListSynchroView, op_OpenDocument, 'Drug')
  with PublishOperationState(en_MedicListSynchroView, op_OpenDocument, 'MedicFirm') do
  begin
   st_user_MedicListSynchroView_OpenDocument_MedicFirm := StateIndex;
   Caption := 'Описание фирмы';
  end;//with PublishOperationState(en_MedicListSynchroView, op_OpenDocument, 'MedicFirm')
 PublishOperation(en_MedicListSynchroView,
                    op_OpenList,
                    en_capMedicListSynchroView,
                    op_capOpenList);
  with PublishOperationState(en_MedicListSynchroView, op_OpenList, 'Drug') do
  begin
   st_user_MedicListSynchroView_OpenList_Drug := StateIndex;
   Caption := 'Препараты-синонимы';
   Hint := 'Список препаратов-синонимов по международному названию';
   ImageIndex := 181;
  end;//with PublishOperationState(en_MedicListSynchroView, op_OpenList, 'Drug')
  with PublishOperationState(en_MedicListSynchroView, op_OpenList, 'MedicFirm') do
  begin
   st_user_MedicListSynchroView_OpenList_MedicFirm := StateIndex;
   Caption := 'Производимые препараты';
   Hint := 'Список производимых препаратов';
   ImageIndex := 183;
  end;//with PublishOperationState(en_MedicListSynchroView, op_OpenList, 'MedicFirm')
 PublishOperation(en_MedicListSynchroView,
                    op_OpenAttributesForm,
                    en_capMedicListSynchroView,
                    op_capOpenAttributesForm);
 g_module_opcode_Inpharm_MedicDiction := 
  PublishModuleOperation(Tmo_Inpharm, 'MedicDiction', 'Словарь медицинских терминов');
 g_module_opcode_Inpharm_MedicFirms := 
  PublishModuleOperation(Tmo_Inpharm, 'MedicFirms', 'Фармацевтические фирмы');
 g_module_opcode_Inpharm_DrugList := 
  PublishModuleOperation(Tmo_Inpharm, 'DrugList', 'Список выпускаемых препаратов');
 g_module_opcode_Inpharm_MedicMainMenu := 
  PublishModuleOperation(Tmo_Inpharm, 'MedicMainMenu', 'Основное меню ИнФарм');
 PublishOperation(en_Rubric,
                    op_Execute,
                    en_capRubric,
                    op_capExecute);
 PublishOperation(en_Result,
                    op_Restore,
                    en_capResult,
                    op_capRestore);
 PublishOperation(en_Result,
                    op_SaveAsDefault,
                    en_capResult,
                    op_capSaveAsDefault);
 g_opcode_StyleEditor_ReloadStyleTable :=
  PublishInternalOperation(en_StyleEditor,
                    op_ReloadStyleTable,
                    en_capStyleEditor,
                    op_capReloadStyleTable);
 g_opcode_StyleEditor_RestoreStyleTable :=
  PublishInternalOperation(en_StyleEditor,
                    op_RestoreStyleTable,
                    en_capStyleEditor,
                    op_capRestoreStyleTable);
 g_opcode_StyleEditor_SaveStyleTable :=
  PublishInternalOperation(en_StyleEditor,
                    op_SaveStyleTable,
                    en_capStyleEditor,
                    op_capSaveStyleTable);
 g_opcode_StyleEditor_SetNewContent :=
  PublishInternalOperation(en_StyleEditor,
                    op_SetNewContent,
                    en_capStyleEditor,
                    op_capSetNewContent);
 g_opcode_StyleEditor_ReloadStylesTree :=
  PublishInternalOperation(en_StyleEditor,
                    op_ReloadStylesTree,
                    en_capStyleEditor,
                    op_capReloadStylesTree);
 PublishOperation(en_PopupMenu,
                    op_DoActive,
                    en_capPopupMenu,
                    op_capDoActive);
 PublishOperation(en_PopupMenu,
                    op_Modify,
                    en_capPopupMenu,
                    op_capModify);
 PublishOperation(en_PopupMenu,
                    op_CopyConfig,
                    en_capPopupMenu,
                    op_capCopyConfig);
 PublishOperation(en_PopupMenu,
                    op_ConfInfo,
                    en_capPopupMenu,
                    op_capConfInfo);
 PublishOperation(en_PopupMenu,
                    op_RestoreAllSettings,
                    en_capPopupMenu,
                    op_capRestoreAllSettings);
 PublishOperation(en_PopupMenu,
                    op_RestoreConf,
                    en_capPopupMenu,
                    op_capRestoreConf);
 PublishOperation(en_PopupMenu,
                    op_SaveAsDefaultConf,
                    en_capPopupMenu,
                    op_capSaveAsDefaultConf);
 PublishOperation(en_Result,
                    op_RestoreConf,
                    en_capResult,
                    op_capRestoreConf);
 PublishOperation(en_Result,
                    op_SaveAsDefaultConf,
                    en_capResult,
                    op_capSaveAsDefaultConf);
 PublishOperation(en_Result,
                    op_RestoreAllSettings,
                    en_capResult,
                    op_capRestoreAllSettings);
 g_module_opcode_Settings_OpenStyleEditorAsModal := 
  PublishModuleOperation(Tmo_Settings, 'OpenStyleEditorAsModal', 'Редактор стилей...');
 g_module_opcode_Settings_AutoLogin := 
  PublishModuleOperation(Tmo_Settings, 'AutoLogin', 'Автоматический вход в систему');
 g_module_opcode_Settings_SelectConfig := 
  PublishModuleOperation(Tmo_Settings, 'SelectConfig', 'Выбор конфигурации');
 g_module_opcode_Settings_OpenConfList := 
  PublishModuleOperation(Tmo_Settings, 'OpenConfList', 'Список конфигураций');
 g_module_opcode_Settings_LoadActiveSettings := 
  PublishModuleOperation(Tmo_Settings, 'LoadActiveSettings', 'Настройка конфигурации...');
 g_module_opcode_Settings_UserProperties := 
  PublishModuleOperation(Tmo_Settings, 'UserProperties', 'Изменить мои регистрационные данные...');
 PublishOperation(en_EnclosedForms,
                    op_CloseChild,
                    en_capEnclosedForms,
                    op_capCloseChild);
 PublishOperation(en_Filters,
                    op_New,
                    en_capFilters,
                    op_capNew);
 PublishOperation(en_Filters,
                    op_Refresh,
                    en_capFilters,
                    op_capRefresh);
 PublishOperation(en_Filter,
                    op_Edit,
                    en_capFilter,
                    op_capEdit);
 PublishOperation(en_Filter,
                    op_PersistentFilter,
                    en_capFilter,
                    op_capPersistentFilter);
 PublishOperation(en_Filter,
                    op_RenameFilter,
                    en_capFilter,
                    op_capRenameFilter);
 g_opcode_Filters_GetSelected :=
  PublishInternalOperation(en_Filters,
                    op_GetSelected,
                    en_capFilters,
                    op_capGetSelected);
 PublishOperation(en_Filter,
                    op_CreateFilter,
                    en_capFilter,
                    op_capCreateFilter);
 PublishOperation(en_ControlCenter,
                    op_Add,
                    en_capControlCenter,
                    op_capAdd);
 PublishOperation(en_ControlCenter,
                    op_CreateList,
                    en_capControlCenter,
                    op_capCreateList);
 PublishOperation(en_ControlCenter,
                    op_Sort,
                    en_capControlCenter,
                    op_capSort);
 PublishOperation(en_ControlCenter,
                    op_ClearAllStatus,
                    en_capControlCenter,
                    op_capClearAllStatus);
 PublishOperation(en_ControledObject,
                    op_Open,
                    en_capControledObject,
                    op_capOpen);
 PublishOperation(en_ControledObject,
                    op_ClearStatus,
                    en_capControledObject,
                    op_capClearStatus);
 PublishOperation(en_Document,
                    op_ShowChanges,
                    en_capDocument,
                    op_capShowChanges);
 g_module_opcode_DocumentListFromFile_OpenDocumentListFromFile := 
  PublishModuleOperation(Tmo_DocumentListFromFile, 'OpenDocumentListFromFile', 'Открыть список документов из файла');
 g_module_opcode_Search_PublishSourceSearch := 
  PublishModuleOperation(Tmo_Search, 'PublishSourceSearch', '');
 g_module_opcode_Search_InpharmSearch := 
  PublishModuleOperation(Tmo_Search, 'InpharmSearch', 'Поиск лекарственных средств');
 g_module_opcode_Search_StartENO := 
  PublishModuleOperation(Tmo_Search, 'StartENO', '');
 g_module_opcode_Search_DocumentsWithoutClass := 
  PublishModuleOperation(Tmo_Search, 'DocumentsWithoutClass', '');
 g_module_opcode_Search_DocumentsWithoutIncluded := 
  PublishModuleOperation(Tmo_Search, 'DocumentsWithoutIncluded', '');
 g_module_opcode_Search_DocumentsWithoutKey := 
  PublishModuleOperation(Tmo_Search, 'DocumentsWithoutKey', '');
 g_module_opcode_Search_BaseSearch := 
  PublishModuleOperation(Tmo_Search, 'BaseSearch', '');
 g_module_opcode_Search_OpenConsult := 
  PublishModuleOperation(Tmo_Search, 'OpenConsult', '');
 g_module_opcode_Search_AllSearch := 
  PublishModuleOperation(Tmo_Search, 'AllSearch', 'Поиск');
 g_opcode_ContextParams_ContextChanged :=
  PublishInternalOperation(en_ContextParams,
                    op_ContextChanged,
                    en_capContextParams,
                    op_capContextChanged);
 g_module_opcode_Search_OpenKeyWordSearch := 
  PublishModuleOperation(Tmo_Search, 'OpenKeyWordSearch', 'Поиск по ситуации');
 g_module_opcode_Search_AttributeSearch := 
  PublishModuleOperation(Tmo_Search, 'AttributeSearch', 'Поиск по реквизитам');
 g_opcode_AttributeTree_SetParent :=
  PublishInternalOperation(en_AttributeTree,
                    op_SetParent,
                    en_capAttributeTree,
                    op_capSetParent);
 g_opcode_AttributeTree_ExtSetRoot :=
  PublishInternalOperation(en_AttributeTree,
                    op_ExtSetRoot,
                    en_capAttributeTree,
                    op_capExtSetRoot);
 g_opcode_AttributeTree_SetRoot :=
  PublishInternalOperation(en_AttributeTree,
                    op_SetRoot,
                    en_capAttributeTree,
                    op_capSetRoot);
 g_opcode_AttributeTree_ExternalCharPressed :=
  PublishInternalOperation(en_AttributeTree,
                    op_ExternalCharPressed,
                    en_capAttributeTree,
                    op_capExternalCharPressed);
 g_opcode_AttributeTree_SetCurrent :=
  PublishInternalOperation(en_AttributeTree,
                    op_SetCurrent,
                    en_capAttributeTree,
                    op_capSetCurrent);
 g_opcode_AttributeTree_DropAllLogicSelection :=
  PublishInternalOperation(en_AttributeTree,
                    op_DropAllLogicSelection,
                    en_capAttributeTree,
                    op_capDropAllLogicSelection);
 g_opcode_AttributeTree_Invalidate :=
  PublishInternalOperation(en_AttributeTree,
                    op_Invalidate,
                    en_capAttributeTree,
                    op_capInvalidate);
 g_opcode_AttributeTree_DropLogicSelection :=
  PublishInternalOperation(en_AttributeTree,
                    op_DropLogicSelection,
                    en_capAttributeTree,
                    op_capDropLogicSelection);
 g_opcode_AttributeTree_LoadQuery :=
  PublishInternalOperation(en_AttributeTree,
                    op_LoadQuery,
                    en_capAttributeTree,
                    op_capLoadQuery);
 g_opcode_AttributeTree_SetOneLevelCurrent :=
  PublishInternalOperation(en_AttributeTree,
                    op_SetOneLevelCurrent,
                    en_capAttributeTree,
                    op_capSetOneLevelCurrent);
 g_opcode_AttributeTree_AddNodeIfEmpty :=
  PublishInternalOperation(en_AttributeTree,
                    op_AddNodeIfEmpty,
                    en_capAttributeTree,
                    op_capAddNodeIfEmpty);
 PublishOperation(en_PostingToolBar,
                    op_ptNewTheme,
                    en_capPostingToolBar,
                    op_capptNewTheme, true);
 PublishOperation(en_PostingToolBar,
                    op_ptEditPosting,
                    en_capPostingToolBar,
                    op_capptEditPosting, true);
 PublishOperation(en_PostingToolBar,
                    op_ptDeletePosting,
                    en_capPostingToolBar,
                    op_capptDeletePosting, true);
 PublishOperation(en_PostingToolBar,
                    op_SavePostList,
                    en_capPostingToolBar,
                    op_capSavePostList);
 PublishOperation(en_PostingToolBar,
                    op_ExportSelected,
                    en_capPostingToolBar,
                    op_capExportSelected);
 g_module_opcode_CommonPost_SavePostList := 
  PublishModuleOperation(Tmo_CommonPost, 'SavePostList', 'Экспортировать все индивидуальные ленты в файл');
end;

// modules operations

class procedure TNemesisRes.MakeCompareEditions(const aDoc: IDocument;
  const aPara: IeeLeafPara;
  aEditionForCompare: Integer;
  const aDocumentForReturn: TnsDocumentForReturnInfo;
  const aContainer: IvcmContainer = nil);
begin
 TBaseEditionsModule.MakeCompareEditions(aDoc, aPara, aEditionForCompare, aDocumentForReturn, aContainer);
end;

class procedure TNemesisRes.MakeCompareEditions(const aDoc: IDocument;
  const aPara: IeeLeafPara;
  const aContainer: IvcmContainer = nil);
begin
 TBaseEditionsModule.MakeCompareEditions(aDoc, aPara, aContainer);
end;

class procedure TNemesisRes.MakeCompareEditions(const aLeft: IDocument;
  const aRight: IDocument;
  const aPara: IeeLeafPara;
  const aContainer: IvcmContainer = nil);
begin
 TBaseEditionsModule.MakeCompareEditions(aLeft, aRight, aPara, aContainer);
end;

class procedure TNemesisRes.MakeCompareEditions(const aDoc: IDocument;
  const aPara: IeeLeafPara;
  aEditionForCompare: Integer;
  const aContainer: IvcmContainer = nil);
begin
 TBaseEditionsModule.MakeCompareEditions(aDoc, aPara, aEditionForCompare, aContainer);
end;

class procedure TNemesisRes.MakeCompareEditions(const aLeft: IDocument;
  const aRight: IDocument;
  const aParaForPositionning: IeeLeafPara;
  const aDocumentForReturn: IDocument;
  const aParaForReturn: IeeLeafPara;
  const aContainer: IvcmContainer = nil);
begin
 TBaseEditionsModule.MakeCompareEditions(aLeft, aRight, aParaForPositionning, aDocumentForReturn, aParaForReturn, aContainer);
end;

class procedure TNemesisRes.MakeCompareEditions(const aLeft: IDocument;
  const aRight: IDocument;
  const aPosition: TbsDocPos;
  const aDocumentForReturn: IDocument;
  const aParaForReturn: IeeLeafPara;
  const aContainer: IvcmContainer = nil);
begin
 TBaseEditionsModule.MakeCompareEditions(aLeft, aRight, aPosition, aDocumentForReturn, aParaForReturn, aContainer);
end;

class procedure TNemesisRes.OpenDocument(const aDocInfo: IdeDocInfo;
  const aContainer: IvcmContainer);
begin
 TDocumentModule.OpenDocument(aDocInfo, aContainer);
end;

class function TNemesisRes.OpenEntityAsDocument(const anEntity: IUnknown;
  const aContainer: IvcmContainer): IDocument;
begin
 Result := TDocumentModule.OpenEntityAsDocument(anEntity, aContainer);
end;

class function TNemesisRes.SafeOpenDocument(const aBaseEntity: IUnknown): IDocument;
begin
 Result := TDocumentModule.SafeOpenDocument(aBaseEntity);
end;

class procedure TNemesisRes.OpenDocumentWithCheck(const aDocInfo: IdeDocInfo;
  const aContainer: IvcmContainer);
begin
 TDocumentModule.OpenDocumentWithCheck(aDocInfo, aContainer);
end;

class function TNemesisRes.OpenExternalObject(const aContainer: IvcmContainer;
  const aData: InsLinkedObjectData): IvcmEntityForm;
begin
 Result := TDocumentModule.OpenExternalObject(aContainer, aData);
end;

class function TNemesisRes.OpenPicture(const aContainer: IvcmContainer;
  const aData: InsLinkedObjectData): IvcmEntityForm;
begin
 Result := TDocumentModule.OpenPicture(aContainer, aData);
end;

class function TNemesisRes.OpenPictureInfo(const aContainer: IvcmContainer;
  const aData: InsLinkedObjectDescription): IvcmEntityForm;
begin
 Result := TDocumentModule.OpenPictureInfo(aContainer, aData);
end;

class function TNemesisRes.OpenTurnOnTimeMachine(const anIntf: InsTurnOnTimeMachine): IvcmEntityForm;
begin
 Result := TDocumentModule.OpenTurnOnTimeMachine(anIntf);
end;

class function TNemesisRes.OpenEditionsListModal(const anEditionsHolder: IsdsEditionsHolder;
  const anAggregate: IvcmAggregate): IvcmEntityForm;
begin
 Result := TDocumentModule.OpenEditionsListModal(anEditionsHolder, anAggregate);
end;

class function TNemesisRes.MakeBaloonForm(aCaller: TvcmContainerForm;
  aUserType: TvcmEffectiveUserType;
  const aWarning: IdsWarning): IvcmEntityForm;
begin
 Result := TDocumentModule.MakeBaloonForm(aCaller, aUserType, aWarning);
end;

class function TNemesisRes.DocumentShowChangesInfoSetting: Boolean;
begin
 Result := TDocumentModule.DocumentShowChangesInfoSetting;
end;

class procedure TNemesisRes.WriteDocumentShowChangesInfoSetting(aValue: Boolean);
begin
 TDocumentModule.WriteDocumentShowChangesInfoSetting(aValue);
end;

class procedure TNemesisRes.OpenTermByContext(const aContext: Il3CString;
  aLanguage: TbsLanguage);
begin
 TDictionModule.OpenTermByContext(aContext, aLanguage);
end;

class procedure TNemesisRes.OpenDictionary(const aDocInfo: IdeDocInfo;
  const aContainer: IvcmContainer);
begin
 TDictionModule.OpenDictionary(aDocInfo, aContainer);
end;

class procedure TNemesisRes.MakeInternetAgent(const anURL: Il3CString;
  const aContainer: IvcmContainer);
begin
 TPrimInternetAgentModule.MakeInternetAgent(anURL, aContainer);
end;

class function TNemesisRes.OpenFolders(const aContainer: IvcmContainer;
  aCanCreate: Boolean): IvcmEntityForm;
begin
 Result := TPrimFoldersModule.OpenFolders(aContainer, aCanCreate);
end;

class procedure TNemesisRes.CloseFolders(const aContainer: IvcmContainer);
begin
 TPrimFoldersModule.CloseFolders(aContainer);
end;

class procedure TNemesisRes.TryOpenConsultationAnswer(const aContainer: IvcmContainer);
begin
 TPrimFoldersModule.TryOpenConsultationAnswer(aContainer);
end;

class procedure TNemesisRes.RefreshStructure(const aNode: INode;
  aStatus: TNotifyStatus);
begin
 TPrimFoldersModule.RefreshStructure(aNode, aStatus);
end;

class function TNemesisRes.EditInfoOpen(aIsNewFolder: Boolean;
  const aNode: IeeNode;
  const aCoords: InsFormCoordinates): Integer;
begin
 Result := TPrimFoldersModule.EditInfoOpen(aIsNewFolder, aNode, aCoords);
end;

class procedure TNemesisRes.LoadOpen(const aForm: IvcmEntityForm;
  const aData: InsFolderFilterInfo);
begin
 TPrimFoldersModule.LoadOpen(aForm, aData);
end;

class procedure TNemesisRes.SelectOpen(const aForm: IvcmEntityForm;
  const aFilterInfo: InsFolderFilterInfo;
  const aCaption: TvcmStringID);
begin
 TPrimFoldersModule.SelectOpen(aForm, aFilterInfo, aCaption);
end;

class procedure TNemesisRes.SelectOpenWithOperation(const aForm: IvcmEntityForm;
  const aFilterInfo: InsFolderFilterInfo;
  const aCaption: TvcmStringID;
  anOp: TListLogicOperation);
begin
 TPrimFoldersModule.SelectOpenWithOperation(aForm, aFilterInfo, aCaption, anOp);
end;

class procedure TNemesisRes.SelectOpenWithUserData(const aForm: IvcmEntityForm;
  const aFilterInfo: InsFolderFilterInfo;
  const aCaption: TvcmStringID;
  const aUserData: IUnknown);
begin
 TPrimFoldersModule.SelectOpenWithUserData(aForm, aFilterInfo, aCaption, aUserData);
end;

class function TNemesisRes.SaveOpen(const aForm: IvcmEntityForm;
  const aFilterInfo: InsFolderFilterInfo;
  anElementType: TFoldersElementType;
  const anEntity: IEntityBase;
  aSaveAs: Boolean): Integer;
begin
 Result := TPrimFoldersModule.SaveOpen(aForm, aFilterInfo, anElementType, anEntity, aSaveAs);
end;

class procedure TNemesisRes.MakeListAnalizer(const aTree: Il3SimpleTree);
begin
 TListModule.MakeListAnalizer(aTree);
end;

class procedure TNemesisRes.OpenList(const aList: IdeList;
  const aContainer: IvcmContainer);
begin
 TListModule.OpenList(aList, aContainer);
end;

class procedure TNemesisRes.OpenListWithReplace(const aList: IdeList;
  const aContainer: IvcmContainer);
begin
 TListModule.OpenListWithReplace(aList, aContainer);
end;

class procedure TNemesisRes.OpenAutoreferat(const aDoc: IDocument;
  const aContainer: IvcmContainer);
begin
 TPrimMonitoringsModule.OpenAutoreferat(aDoc, aContainer);
end;

class procedure TNemesisRes.OpenAutoreferatAfterSearch(const aList: IMonitoringList;
  const aContainer: IvcmContainer);
begin
 TPrimMonitoringsModule.OpenAutoreferatAfterSearch(aList, aContainer);
end;

class function TNemesisRes.OpenNewsLine: IvcmEntityForm;
begin
 Result := TPrimMonitoringsModule.OpenNewsLine;
end;

class function TNemesisRes.OpenPostingOrder(const aQuery: IQuery;
  const aContainer: IvcmContainer = nil): IvcmEntityForm;
begin
 Result := TCommonPostModule.OpenPostingOrder(aQuery, aContainer);
end;

class procedure TNemesisRes.SavePostingList;
begin
 TCommonPostModule.SavePostingList;
end;

class procedure TNemesisRes.CheckHistory;
begin
 TCommonPostModule.CheckHistory;
end;

class function TNemesisRes.StartOpen(const aContainer: IvcmContainer;
  aNewTab: Boolean): IvcmEntityForm;
begin
 Result := TCommonPostModule.StartOpen(aContainer, aNewTab);
end;

class procedure TNemesisRes.SavePostList;
begin
 TCommonPostModule.SavePostList;
end;

class function TNemesisRes.CanSavePostList: Boolean;
begin
 Result := TCommonPostModule.CanSavePostList;
end;

class procedure TNemesisRes.GiveMarkOnConsultation(const aNode: Il3SimpleNode);
begin
 TConsultationModule.GiveMarkOnConsultation(aNode);
end;

class procedure TNemesisRes.OpenSendConsultation(const aQuery: IQuery);
begin
 TConsultationModule.OpenSendConsultation(aQuery);
end;

class procedure TNemesisRes.OpenEntityAsConsultation(const aCons: IUnknown;
  const aContainer: IvcmContainer);
begin
 TConsultationModule.OpenEntityAsConsultation(aCons, aContainer);
end;

class procedure TNemesisRes.OpenConsultation(const aCons: IbsConsultation;
  const aContainer: IvcmContainer);
begin
 TConsultationModule.OpenConsultation(aCons, aContainer);
end;

class procedure TNemesisRes.FiltersOpen(const aData: IucpFilters);
begin
 TFiltersModule.FiltersOpen(aData);
end;

class procedure TNemesisRes.OldSchoolFiltersOpen(const anAggregate: IvcmAggregate;
  const aContainer: IvcmContainer;
  anOwner: TComponent);
begin
 TFiltersModule.OldSchoolFiltersOpen(anAggregate, aContainer, anOwner);
end;

class function TNemesisRes.CreateFilter(const aQuery: IQuery): Integer;
begin
 Result := TFiltersModule.CreateFilter(aQuery);
end;

class procedure TNemesisRes.RenameFilter(const aFilter: IFilterFromQuery);
begin
 TFiltersModule.RenameFilter(aFilter);
end;

class function TNemesisRes.MakeChatDispatcher: IbsChatDispatcher;
begin
 Result := TBaseChatModule.MakeChatDispatcher;
end;

class function TNemesisRes.OpenChatWindow(anUID: TbsUserID;
  const aName: Il3CString): IvcmEntityForm;
begin
 Result := TBaseChatModule.OpenChatWindow(anUID, aName);
end;

class function TNemesisRes.OpenAddUserDialog: IvcmEntityForm;
begin
 Result := TBaseChatModule.OpenAddUserDialog;
end;

class function TNemesisRes.OpenHistoryWindow(anUID: TbsUserID;
  const aName: Il3CString): IvcmEntityForm;
begin
 Result := TBaseChatModule.OpenHistoryWindow(anUID, aName);
end;

class function TNemesisRes.MakeWorkJournal: IbsWorkJournal;
begin
 Result := TBaseWorkJournalModule.MakeWorkJournal;
end;

class function TNemesisRes.MakeProgressIndicator(const aProgress: InsProgressIndicator;
  const aCaption: Il3CString;
  aMaxCount: Integer): IvcmEntityForm;
begin
 Result := TPrimF1CommonModule.MakeProgressIndicator(aProgress, aCaption, aMaxCount);
end;

class procedure TNemesisRes.CloseNavigator(const aContainer: IvcmContainer);
begin
 TPrimF1CommonModule.CloseNavigator(aContainer);
end;

class procedure TNemesisRes.CloseTasksPanel(const aContainer: IvcmContainer);
begin
 TPrimF1CommonModule.CloseTasksPanel(aContainer);
end;

class procedure TNemesisRes.FromPrinterSettings(const aPrinter: Il3Printer);
begin
 TPrimF1CommonModule.FromPrinterSettings(aPrinter);
end;

class procedure TNemesisRes.ToPrinterSettings(const aPrinter: Il3Printer);
begin
 TPrimF1CommonModule.ToPrinterSettings(aPrinter);
end;

class procedure TNemesisRes.About;
begin
 TPrimF1CommonModule.About;
end;

class procedure TNemesisRes.ApplicationActivate;
begin
 TPrimF1CommonModule.ApplicationActivate;
end;

class procedure TNemesisRes.OpenRubricatorOnStart(const aContainer: IvcmContainer);
begin
 TPrimF1CommonModule.OpenRubricatorOnStart(aContainer);
end;

class procedure TNemesisRes.OpenNewDocs(const aContainer: IvcmContainer);
begin
 TPrimF1CommonModule.OpenNewDocs(aContainer);
end;

class procedure TNemesisRes.GetNavigator(const anAggregate: IvcmAggregate;
  const aContainer: IvcmContainer);
begin
 TPrimF1CommonModule.GetNavigator(anAggregate, aContainer);
end;

class procedure TNemesisRes.OpenTasksPanel(const aContainer: IvcmContainer);
begin
 TPrimF1CommonModule.OpenTasksPanel(aContainer);
end;

class procedure TNemesisRes.AddDocumentToControl(const aDocument: IDocument);
begin
 TPrimF1CommonModule.AddDocumentToControl(aDocument);
end;

class procedure TNemesisRes.AddToControl(const aControllable: IControllable);
begin
 TPrimF1CommonModule.AddToControl(aControllable);
end;

class procedure TNemesisRes.DeleteDocumentFromControl(const aDocument: IDocument);
begin
 TPrimF1CommonModule.DeleteDocumentFromControl(aDocument);
end;

class procedure TNemesisRes.DeleteFromControl(const aControllable: IControllable);
begin
 TPrimF1CommonModule.DeleteFromControl(aControllable);
end;

class function TNemesisRes.IsUnderControl(const aDoc: IDocument): Boolean;
begin
 Result := TPrimF1CommonModule.IsUnderControl(aDoc);
end;

class function TNemesisRes.IsCurEditionActual(const aState: IDocumentState): Boolean;
begin
 Result := TPrimF1CommonModule.IsCurEditionActual(aState);
end;

class function TNemesisRes.IsCurEditionActual(const aDocument: IDocument): Boolean;
begin
 Result := TPrimF1CommonModule.IsCurEditionActual(aDocument);
end;

class function TNemesisRes.GetCurEditionDate(const aDocument: IDocument): AdapterDate;
begin
 Result := TPrimF1CommonModule.GetCurEditionDate(aDocument);
end;

class function TNemesisRes.OpenTurnOffTimeMachine(const anIntf: InsTurnOffTimeMachine): IvcmEntityForm;
begin
 Result := TPrimF1CommonModule.OpenTurnOffTimeMachine(anIntf);
end;

class procedure TNemesisRes.OpenTip(const aDocInfo: IdeDocInfo;
  const aContainer: IvcmContainer);
begin
 TDayTipsModule.OpenTip(aDocInfo, aContainer);
end;

class function TNemesisRes.ShowDayTipsAtStartup: IvcmEntityForm;
begin
 Result := TDayTipsModule.ShowDayTipsAtStartup;
end;

class procedure TNemesisRes.OpenMedicDiction(const aDocInfo: IdeDocInfo;
  const aContainer: IvcmContainer);
begin
 TInpharmModule.OpenMedicDiction(aDocInfo, aContainer);
end;

class procedure TNemesisRes.OpenMedicFirmDocument(const aDocInfo: IdeDocInfo;
  const aContainer: IvcmContainer);
begin
 TInpharmModule.OpenMedicFirmDocument(aDocInfo, aContainer);
end;

class procedure TNemesisRes.OpenDrugDocument(const aDocInfo: IdeDocInfo;
  const aContainer: IvcmContainer);
begin
 TInpharmModule.OpenDrugDocument(aDocInfo, aContainer);
end;

class procedure TNemesisRes.OpenDrugList(const aList: IdeList;
  const aContainer: IvcmContainer);
begin
 TInpharmModule.OpenDrugList(aList, aContainer);
end;

class procedure TNemesisRes.MedicFirms(const aContainer: IvcmContainer);
begin
 TInpharmModule.MedicFirms(aContainer);
end;

class procedure TNemesisRes.OpenInpharmMainMenu(const aContainer: IvcmContainer);
begin
 TInpharmModule.OpenInpharmMainMenu(aContainer);
end;

class procedure TNemesisRes.OpenDrugListIfNeeded(const aContainer: IvcmContainer);
begin
 TInpharmModule.OpenDrugListIfNeeded(aContainer);
end;

class function TNemesisRes.OpenRubricator(const aNode: Il3SimpleNode;
  const aRootToKeep: INodeBase;
  const aMenuSectionItemToKeep: ISectionItem;
  aNeedsSheet: Boolean;
  const anAggregate: IvcmAggregate;
  const aContainer: IvcmContainer): IvcmEntityForm;
begin
 Result := TRubricatorModule.OpenRubricator(aNode, aRootToKeep, aMenuSectionItemToKeep, aNeedsSheet, anAggregate, aContainer);
end;

class function TNemesisRes.OpenStyleEditorAsModal(const aData: InsStyleTableSettingsInfo): Integer;
begin
 Result := TSettingsModule.OpenStyleEditorAsModal(aData);
end;

class procedure TNemesisRes.CloseConfList(const aContainer: IvcmContainer);
begin
 TSettingsModule.CloseConfList(aContainer);
end;

class function TNemesisRes.LoadSettings(const anAggregate: IvcmAggregate;
  const aData: InsConfigSettingsInfo): IvcmEntityForm;
begin
 Result := TSettingsModule.LoadSettings(anAggregate, aData);
end;

class procedure TNemesisRes.OpenConfList(const aContainer: IvcmContainer);
begin
 TSettingsModule.OpenConfList(aContainer);
end;

class procedure TNemesisRes.OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
begin
 TMainMenuModule.OpenMainMenuIfNeeded(aContainer);
end;

class function TNemesisRes.MainMenuChangeableMainMenuTypeSetting: Integer;
begin
 Result := TMainMenuModule.MainMenuChangeableMainMenuTypeSetting;
end;

class procedure TNemesisRes.WriteMainMenuChangeableMainMenuTypeSetting(aValue: Integer);
begin
 TMainMenuModule.WriteMainMenuChangeableMainMenuTypeSetting(aValue);
end;

class procedure TNemesisRes.TryAnotherBaseSearch(const aContainer: IvcmContainer;
  const aProcessor: InsBaseSearchResultProcessor;
  TryFullList: Boolean = False);
begin
 TBaseSearchModule.TryAnotherBaseSearch(aContainer, aProcessor, TryFullList);
end;

class procedure TNemesisRes.OpenBaseSearch(OpenKind: TnsBaseSearchOpenKind;
  const aQuery: IQuery);
begin
 TBaseSearchModule.OpenBaseSearch(OpenKind, aQuery);
end;

class function TNemesisRes.MakeBaseSearchWindow(const aContainer: IvcmContainer;
  const aData: InsBaseSearcherWindowData;
  aZoneType: TvcmZoneType): IvcmEntityForm;
begin
 Result := TBaseSearchModule.MakeBaseSearchWindow(aContainer, aData, aZoneType);
end;

class procedure TNemesisRes.BaseSearchCheckFragmentsCount(const aContainer: IvcmContainer);
begin
 TBaseSearchModule.BaseSearchCheckFragmentsCount(aContainer);
end;

class procedure TNemesisRes.CheckBaseSearchDataReady(const aContainer: IvcmContainer);
begin
 TBaseSearchModule.CheckBaseSearchDataReady(aContainer);
end;

class procedure TNemesisRes.BaseSearchCheckFindBack(const aContainer: IvcmContainer);
begin
 TBaseSearchModule.BaseSearchCheckFindBack(aContainer);
end;

class function TNemesisRes.MakeBaseSearchCard(const aContainer: IvcmContainer): IvcmEntityForm;
begin
 Result := TBaseSearchModule.MakeBaseSearchCard(aContainer);
end;

class procedure TNemesisRes.CloseUnderControl(const aContainer: IvcmContainer);
begin
 TUnderControlModule.CloseUnderControl(aContainer);
end;

class procedure TNemesisRes.OpenUnderControl(const aContainer: IvcmContainer);
begin
 TUnderControlModule.OpenUnderControl(aContainer);
end;

class procedure TNemesisRes.BuildUnderControlList(const aContainer: IvcmContainer);
begin
 TUnderControlModule.BuildUnderControlList(aContainer);
end;

class procedure TNemesisRes.AddControlledObject(const aData: IControllable);
begin
 TUnderControlModule.AddControlledObject(aData);
end;

class procedure TNemesisRes.DeleteControlledObject(const aData: IControllable);
begin
 TUnderControlModule.DeleteControlledObject(aData);
end;

class procedure TNemesisRes.MarkControlledAsOpen(const aData: IControllable);
begin
 TUnderControlModule.MarkControlledAsOpen(aData);
end;

class procedure TNemesisRes.DropChangeStatusToOpened(const aForm: IvcmEntityForm);
begin
 TUnderControlModule.DropChangeStatusToOpened(aForm);
end;

class procedure TNemesisRes.ViewChangedFragments(const aLeft: IDocument;
  const aRight: IDocument);
begin
 TChangesBetweenEditionsModule.ViewChangedFragments(aLeft, aRight);
end;

class procedure TNemesisRes.ViewChangedFragmentsForPrevEdition(const aDocument: IDocument);
begin
 TChangesBetweenEditionsModule.ViewChangedFragmentsForPrevEdition(aDocument);
end;

class function TNemesisRes.OpenLegislationReview(const aQuery: IQuery): IvcmEntityForm;
begin
 Result := TSearchModule.OpenLegislationReview(aQuery);
end;

class function TNemesisRes.OpenFiltersForm(const aData: IdeFilter): IvcmEntityForm;
begin
 Result := TSearchModule.OpenFiltersForm(aData);
end;

class procedure TNemesisRes.MakeNewFilter(aListType: TbsListType);
begin
 TSearchModule.MakeNewFilter(aListType);
end;

class procedure TNemesisRes.InpharmSearch(const aQuery: IQuery;
  const aList: IDynList;
  const aContainer: IvcmContainer);
begin
 TSearchModule.InpharmSearch(aQuery, aList, aContainer);
end;

class procedure TNemesisRes.PublishSourceSearch(const aQuery: IQuery;
  const aList: IDynList);
begin
 TSearchModule.PublishSourceSearch(aQuery, aList);
end;

class function TNemesisRes.DateQuery(const aCaller: IvcmEntityForm;
  const aData: IqaDateReqDataHolder): IvcmEntityForm;
begin
 Result := TSearchModule.DateQuery(aCaller, aData);
end;

class procedure TNemesisRes.OpenKeyWord(const aQuery: IQuery;
  const aContainer: IvcmContainer);
begin
 TSearchModule.OpenKeyWord(aQuery, aContainer);
end;

class procedure TNemesisRes.EditFilter(const aFilter: IdeFilter;
  anItemIndex: Integer);
begin
 TSearchModule.EditFilter(aFilter, anItemIndex);
end;

class procedure TNemesisRes.AttributeSearch(const aQuery: IQuery;
  const aList: IDynList;
  const aContainer: IvcmContainer);
begin
 TSearchModule.AttributeSearch(aQuery, aList, aContainer);
end;

class procedure TNemesisRes.OpenTaxesPublishSearch(const aPublishSearchTag: Il3CString);
begin
 TSearchModule.OpenTaxesPublishSearch(aPublishSearchTag);
end;

class procedure TNemesisRes.OpenSituationCard(const aQuery: IQuery);
begin
 TSearchModule.OpenSituationCard(aQuery);
end;

class procedure TNemesisRes.OpenOldSituationCard(const aQuery: IQuery;
  const aContainer: IvcmContainer);
begin
 TSearchModule.OpenOldSituationCard(aQuery, aContainer);
end;

class procedure TNemesisRes.OpenPharmPublishSearch;
begin
 TSearchModule.OpenPharmPublishSearch;
end;

class procedure TNemesisRes.OpenPharmLegislationReview;
begin
 TSearchModule.OpenPharmLegislationReview;
end;

class procedure TNemesisRes.MakeAAC(const aDocInfo: IdeDocInfo;
  const aContainer: IvcmContainer);
begin
 TAACPrimModule.MakeAAC(aDocInfo, aContainer);
end;

class procedure TNemesisRes.MakeAACContents(const aDocInfo: IdeDocInfo;
  const aContainer: IvcmContainer);
begin
 TAACPrimModule.MakeAACContents(aDocInfo, aContainer);
end;

// operations codes

class function TNemesisRes.opcode_Document_ShowJurorComments : TvcmOpID;
begin
 Result := g_opcode_Document_ShowJurorComments;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_ShowUserComments : TvcmOpID;
begin
 Result := g_opcode_Document_ShowUserComments;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_ShowVersionComments : TvcmOpID;
begin
 Result := g_opcode_Document_ShowVersionComments;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Finder_GotoPara : TvcmOpID;
begin
 Result := g_opcode_Finder_GotoPara;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Finder_DisableForceDrawFocusRect : TvcmOpID;
begin
 Result := g_opcode_Finder_DisableForceDrawFocusRect;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_File_Print : TvcmOpID;
begin
 Result := g_opcode_File_Print;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_File_PrintDialog : TvcmOpID;
begin
 Result := g_opcode_File_PrintDialog;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_File_PrintPreview : TvcmOpID;
begin
 Result := g_opcode_File_PrintPreview;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_File_Save : TvcmOpID;
begin
 Result := g_opcode_File_Save;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_OpenEditionLocalLink : TvcmOpID;
begin
 Result := g_opcode_Document_OpenEditionLocalLink;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_ControlCenter_Refresh : TvcmOpID;
begin
 Result := g_opcode_ControlCenter_Refresh;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_SetPosition : TvcmOpID;
begin
 Result := g_opcode_Document_SetPosition;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_HyperLink_Open : TvcmOpID;
begin
 Result := g_opcode_HyperLink_Open;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_HyperLink_OpenNewWindow : TvcmOpID;
begin
 Result := g_opcode_HyperLink_OpenNewWindow;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_HyperLink_NextHyperLink : TvcmOpID;
begin
 Result := g_opcode_HyperLink_NextHyperLink;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_HyperLink_PrevHyperLink : TvcmOpID;
begin
 Result := g_opcode_HyperLink_PrevHyperLink;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_HyperLink_OpenInNewTab : TvcmOpID;
begin
 Result := g_opcode_HyperLink_OpenInNewTab;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_HyperLink_OpenScriptHyperLink : TvcmOpID;
begin
 Result := g_opcode_HyperLink_OpenScriptHyperLink;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_HyperLink_NavigateInternetHyperlink : TvcmOpID;
begin
 Result := g_opcode_HyperLink_NavigateInternetHyperlink;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_HyperLink_Delete : TvcmOpID;
begin
 Result := g_opcode_HyperLink_Delete;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_RightEdition_ReturnToDocument : TvcmOpID;
begin
 Result := g_opcode_RightEdition_ReturnToDocument;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_RightEdition_SetFocusToText : TvcmOpID;
begin
 Result := g_opcode_RightEdition_SetFocusToText;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_RightEdition_IsCurrentPara : TvcmOpID;
begin
 Result := g_opcode_RightEdition_IsCurrentPara;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_GetParaForPositionning : TvcmOpID;
begin
 Result := g_opcode_Document_GetParaForPositionning;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Edition_PrevChange : TvcmOpID;
begin
 Result := g_opcode_Edition_PrevChange;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Edition_NextChange : TvcmOpID;
begin
 Result := g_opcode_Edition_NextChange;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Edition_ReturnToDocument : TvcmOpID;
begin
 Result := g_opcode_Edition_ReturnToDocument;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_ViewChangedFragments : TvcmOpID;
begin
 Result := g_opcode_Document_ViewChangedFragments;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Redactions_OpenRedactionListFrmAct : TvcmOpID;
begin
 Result := g_opcode_Redactions_OpenRedactionListFrmAct;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Redactions_RedactionOnID : TvcmOpID;
begin
 Result := g_opcode_Redactions_RedactionOnID;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Redactions_ActualRedaction : TvcmOpID;
begin
 Result := g_opcode_Redactions_ActualRedaction;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Redactions_PrevRedaction : TvcmOpID;
begin
 Result := g_opcode_Redactions_PrevRedaction;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Redactions_NextRedaction : TvcmOpID;
begin
 Result := g_opcode_Redactions_NextRedaction;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Scalable_ChangeScale : TvcmOpID;
begin
 Result := g_opcode_Scalable_ChangeScale;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Scalable_CanChangeScale : TvcmOpID;
begin
 Result := g_opcode_Scalable_CanChangeScale;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_InternetAgent_InternetAgent : TvcmMOpID;
begin
 Result := g_module_opcode_InternetAgent_InternetAgent;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Result_Cancel : TvcmOpID;
begin
 Result := g_opcode_Result_Cancel;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_FoldersControl_EditElement : TvcmOpID;
begin
 Result := g_opcode_FoldersControl_EditElement;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_FoldersControl_DeleteElement : TvcmOpID;
begin
 Result := g_opcode_FoldersControl_DeleteElement;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Result_Ok : TvcmOpID;
begin
 Result := g_opcode_Result_Ok;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_AdditionInfo_Show : TvcmOpID;
begin
 Result := g_opcode_AdditionInfo_Show;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_AdditionInfo_Hide : TvcmOpID;
begin
 Result := g_opcode_AdditionInfo_Hide;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_AdditionInfo_SetCaption : TvcmOpID;
begin
 Result := g_opcode_AdditionInfo_SetCaption;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_AdditionInfo_Close : TvcmOpID;
begin
 Result := g_opcode_AdditionInfo_Close;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Switcher_BecomeActive : TvcmOpID;
begin
 Result := g_opcode_Switcher_BecomeActive;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_ResultExt_Ok : TvcmOpID;
begin
 Result := g_opcode_ResultExt_Ok;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_ResultExt_Append : TvcmOpID;
begin
 Result := g_opcode_ResultExt_Append;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_ResultExt_Cancel : TvcmOpID;
begin
 Result := g_opcode_ResultExt_Cancel;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_FolderElement_SetState : TvcmOpID;
begin
 Result := g_opcode_FolderElement_SetState;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Tree_ExpandAll : TvcmOpID;
begin
 Result := g_opcode_Tree_ExpandAll;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Tree_CollapseAll : TvcmOpID;
begin
 Result := g_opcode_Tree_CollapseAll;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Tree_Wrap : TvcmOpID;
begin
 Result := g_opcode_Tree_Wrap;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_FolderElement_InternalEditByFoldersNode : TvcmOpID;
begin
 Result := g_opcode_FolderElement_InternalEditByFoldersNode;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_FolderElement_InternalDelete : TvcmOpID;
begin
 Result := g_opcode_FolderElement_InternalDelete;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_FolderElement_InternalEdit : TvcmOpID;
begin
 Result := g_opcode_FolderElement_InternalEdit;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_FolderElement_DisableFilter : TvcmOpID;
begin
 Result := g_opcode_FolderElement_DisableFilter;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_SavedQuery_SetFilterState : TvcmOpID;
begin
 Result := g_opcode_SavedQuery_SetFilterState;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Folders_SetCurrent : TvcmOpID;
begin
 Result := g_opcode_Folders_SetCurrent;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Folders_FiltrateByFilterInfo : TvcmOpID;
begin
 Result := g_opcode_Folders_FiltrateByFilterInfo;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Folders_TryOpenConsultationAnswer : TvcmOpID;
begin
 Result := g_opcode_Folders_TryOpenConsultationAnswer;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Folders_OpenMyConsultations : TvcmOpID;
begin
 Result := g_opcode_Folders_OpenMyConsultations;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Folders_SetInfoContent : TvcmOpID;
begin
 Result := g_opcode_Folders_SetInfoContent;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_FolderElement_GetState : TvcmOpID;
begin
 Result := g_opcode_FolderElement_GetState;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_FolderElement_SetLoadInfo : TvcmOpID;
begin
 Result := g_opcode_FolderElement_SetLoadInfo;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_FolderElement_SetContent : TvcmOpID;
begin
 Result := g_opcode_FolderElement_SetContent;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_FolderElement_SetSaveInfo : TvcmOpID;
begin
 Result := g_opcode_FolderElement_SetSaveInfo;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_FolderElement_ResetModificationOnDelete : TvcmOpID;
begin
 Result := g_opcode_FolderElement_ResetModificationOnDelete;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_FolderElement_SetFocus : TvcmOpID;
begin
 Result := g_opcode_FolderElement_SetFocus;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_FolderElement_Redraw : TvcmOpID;
begin
 Result := g_opcode_FolderElement_Redraw;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_FolderElement_DisableSecurityPage : TvcmOpID;
begin
 Result := g_opcode_FolderElement_DisableSecurityPage;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_UsersRights_UpdateRights : TvcmOpID;
begin
 Result := g_opcode_UsersRights_UpdateRights;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_UsersRights_FolderShareChanged : TvcmOpID;
begin
 Result := g_opcode_UsersRights_FolderShareChanged;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Result_ExternalOk : TvcmOpID;
begin
 Result := g_opcode_Result_ExternalOk;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Loadable_Load : TvcmOpID;
begin
 Result := g_opcode_Loadable_Load;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_SetActive : TvcmOpID;
begin
 Result := g_opcode_Document_SetActive;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_ExportBlock : TvcmOpID;
begin
 Result := g_opcode_Document_ExportBlock;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_GetCurrentPosition : TvcmOpID;
begin
 Result := g_opcode_Document_GetCurrentPosition;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_SelectBlock : TvcmOpID;
begin
 Result := g_opcode_Document_SelectBlock;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_CopyBlock : TvcmOpID;
begin
 Result := g_opcode_Document_CopyBlock;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_PrintBlock : TvcmOpID;
begin
 Result := g_opcode_Document_PrintBlock;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_PrintDialogBlock : TvcmOpID;
begin
 Result := g_opcode_Document_PrintDialogBlock;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_PreviewBlock : TvcmOpID;
begin
 Result := g_opcode_Document_PreviewBlock;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_ShowRespondentListToPart : TvcmOpID;
begin
 Result := g_opcode_Document_ShowRespondentListToPart;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_ShowCorrespondentListToPart : TvcmOpID;
begin
 Result := g_opcode_Document_ShowCorrespondentListToPart;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_ModifyBookmarkNotify : TvcmOpID;
begin
 Result := g_opcode_Document_ModifyBookmarkNotify;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_AddBookmarkFromContents : TvcmOpID;
begin
 Result := g_opcode_Document_AddBookmarkFromContents;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_OpenNotSureTopic : TvcmOpID;
begin
 Result := g_opcode_Document_OpenNotSureTopic;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_GotoPara : TvcmOpID;
begin
 Result := g_opcode_Document_GotoPara;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Folders_MyInformation : TvcmMOpID;
begin
 Result := g_module_opcode_Folders_MyInformation;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Folders_MyConsultations : TvcmMOpID;
begin
 Result := g_module_opcode_Folders_MyConsultations;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Folders_UnderControlOpenFrmAct : TvcmMOpID;
begin
 Result := g_module_opcode_Folders_UnderControlOpenFrmAct;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Folders_OpenFrmAct : TvcmMOpID;
begin
 Result := g_module_opcode_Folders_OpenFrmAct;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_List_SetNewContent : TvcmOpID;
begin
 Result := g_opcode_List_SetNewContent;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Result_OkExt : TvcmOpID;
begin
 Result := g_opcode_Result_OkExt;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Chat_OpenContactList : TvcmMOpID;
begin
 Result := g_module_opcode_Chat_OpenContactList;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_WorkJournal_OpenJournal : TvcmMOpID;
begin
 Result := g_module_opcode_WorkJournal_OpenJournal;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_DateInterval_OpenInt : TvcmOpID;
begin
 Result := g_opcode_DateInterval_OpenInt;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Form_RequestClose : TvcmOpID;
begin
 Result := g_opcode_Form_RequestClose;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Monitorings_OpenNewsLine : TvcmMOpID;
begin
 Result := g_module_opcode_Monitorings_OpenNewsLine;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Monitorings_OpenLegislationReview : TvcmMOpID;
begin
 Result := g_module_opcode_Monitorings_OpenLegislationReview;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_SearchSupport_ActivatePostingsListForm : TvcmOpID;
begin
 Result := g_opcode_SearchSupport_ActivatePostingsListForm;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Common_ComplectInfo : TvcmMOpID;
begin
 Result := g_module_opcode_Common_ComplectInfo;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Common_PageSetup : TvcmMOpID;
begin
 Result := g_module_opcode_Common_PageSetup;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Common_ShowEULA : TvcmMOpID;
begin
 Result := g_module_opcode_Common_ShowEULA;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Common_OpenMainMenuByButton : TvcmMOpID;
begin
 Result := g_module_opcode_Common_OpenMainMenuByButton;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Common_OpenMainMenuNew : TvcmMOpID;
begin
 Result := g_module_opcode_Common_OpenMainMenuNew;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Common_TasksPanel : TvcmMOpID;
begin
 Result := g_module_opcode_Common_TasksPanel;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Common_LetterToDevelopers : TvcmMOpID;
begin
 Result := g_module_opcode_Common_LetterToDevelopers;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Navigator_SetCurrent : TvcmOpID;
begin
 Result := g_opcode_Navigator_SetCurrent;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Common_OpenRubricator : TvcmMOpID;
begin
 Result := g_module_opcode_Common_OpenRubricator;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Common_OpenInformation : TvcmMOpID;
begin
 Result := g_module_opcode_Common_OpenInformation;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Common_get_navigator : TvcmMOpID;
begin
 Result := g_module_opcode_Common_get_navigator;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Common_OpenIntranet : TvcmMOpID;
begin
 Result := g_module_opcode_Common_OpenIntranet;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_PrintParams_UpdatePrinter : TvcmOpID;
begin
 Result := g_opcode_PrintParams_UpdatePrinter;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Rubricator_SetListRoot : TvcmOpID;
begin
 Result := g_opcode_Rubricator_SetListRoot;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Rubricator_InitListRoot : TvcmOpID;
begin
 Result := g_opcode_Rubricator_InitListRoot;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Rubricator_Synchronize : TvcmOpID;
begin
 Result := g_opcode_Rubricator_Synchronize;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Rubricator_GetRoot : TvcmOpID;
begin
 Result := g_opcode_Rubricator_GetRoot;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_GetAttributesFrmAct : TvcmOpID;
begin
 Result := g_opcode_Document_GetAttributesFrmAct;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_OpenCorrespondentList : TvcmOpID;
begin
 Result := g_opcode_Document_OpenCorrespondentList;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_OpenRespondentList : TvcmOpID;
begin
 Result := g_opcode_Document_OpenRespondentList;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_GetRelatedDocFrmAct : TvcmOpID;
begin
 Result := g_opcode_Document_GetRelatedDocFrmAct;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_GetCorrespondentList : TvcmOpID;
begin
 Result := g_opcode_Document_GetCorrespondentList;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_GetRespondentList : TvcmOpID;
begin
 Result := g_opcode_Document_GetRespondentList;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_AttributesCanBeClosed : TvcmOpID;
begin
 Result := g_opcode_Document_AttributesCanBeClosed;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_CommonDocumentOpenNewWindow : TvcmOpID;
begin
 Result := g_opcode_Document_CommonDocumentOpenNewWindow;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_GetCorrespondentListExFrmAct : TvcmOpID;
begin
 Result := g_opcode_Document_GetCorrespondentListExFrmAct;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_GetRespondentListExFrmAct : TvcmOpID;
begin
 Result := g_opcode_Document_GetRespondentListExFrmAct;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_CommonDocumentOpenNewTab : TvcmOpID;
begin
 Result := g_opcode_Document_CommonDocumentOpenNewTab;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_DocumentIsUseful : TvcmOpID;
begin
 Result := g_opcode_Document_DocumentIsUseful;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_DocumentIsUseless : TvcmOpID;
begin
 Result := g_opcode_Document_DocumentIsUseless;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_PrevDocumentInList : TvcmOpID;
begin
 Result := g_opcode_Document_PrevDocumentInList;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_NextDocumentInList : TvcmOpID;
begin
 Result := g_opcode_Document_NextDocumentInList;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_ReturnToList : TvcmOpID;
begin
 Result := g_opcode_Document_ReturnToList;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_CompareEditions : TvcmOpID;
begin
 Result := g_opcode_Document_CompareEditions;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_System_TimeMachineStateChange : TvcmOpID;
begin
 Result := g_opcode_System_TimeMachineStateChange;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Document_FindExplanation : TvcmOpID;
begin
 Result := g_opcode_Document_FindExplanation;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_TimeMachine_TimeMachineOnOffNew : TvcmOpID;
begin
 Result := g_opcode_TimeMachine_TimeMachineOnOffNew;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_TimeMachine_TimeMachineOnOff : TvcmOpID;
begin
 Result := g_opcode_TimeMachine_TimeMachineOnOff;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_TimeMachine_TimeMachineOffAndReset : TvcmOpID;
begin
 Result := g_opcode_TimeMachine_TimeMachineOffAndReset;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_DocumentBlockHeader_UserCR1 : TvcmOpID;
begin
 Result := g_opcode_DocumentBlockHeader_UserCR1;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_DocumentBlockHeader_UserCR2 : TvcmOpID;
begin
 Result := g_opcode_DocumentBlockHeader_UserCR2;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_DocumentBlockHeader_GetTypedCorrespondentList : TvcmOpID;
begin
 Result := g_opcode_DocumentBlockHeader_GetTypedCorrespondentList;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_DocumentBlockHeader_AddBookmark : TvcmOpID;
begin
 Result := g_opcode_DocumentBlockHeader_AddBookmark;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_DocumentBlockHeader_ToMSWord : TvcmOpID;
begin
 Result := g_opcode_DocumentBlockHeader_ToMSWord;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_DocumentBlockHeader_Print : TvcmOpID;
begin
 Result := g_opcode_DocumentBlockHeader_Print;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_DocumentBlockHeader_PrintDialog : TvcmOpID;
begin
 Result := g_opcode_DocumentBlockHeader_PrintDialog;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Text_AddUserComment : TvcmOpID;
begin
 Result := g_opcode_Text_AddUserComment;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Text_DeleteBookmark : TvcmOpID;
begin
 Result := g_opcode_Text_DeleteBookmark;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Text_EditBookmark : TvcmOpID;
begin
 Result := g_opcode_Text_EditBookmark;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Text_AddBookmark : TvcmOpID;
begin
 Result := g_opcode_Text_AddBookmark;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Text_OpenNewWindow : TvcmOpID;
begin
 Result := g_opcode_Text_OpenNewWindow;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_DocumentSubPanel_UpdateSubPanel : TvcmOpID;
begin
 Result := g_opcode_DocumentSubPanel_UpdateSubPanel;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_BaseSearchPresentationHolder_GetBaseSearchPresentation : TvcmOpID;
begin
 Result := g_opcode_BaseSearchPresentationHolder_GetBaseSearchPresentation;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Switcher_SetFirstPageActive : TvcmOpID;
begin
 Result := g_opcode_Switcher_SetFirstPageActive;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_AACTextContainer_GetVScrollBar : TvcmOpID;
begin
 Result := g_opcode_AACTextContainer_GetVScrollBar;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_AACTextContainer_SetJumpTo : TvcmOpID;
begin
 Result := g_opcode_AACTextContainer_SetJumpTo;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Editions_SetCurrent : TvcmOpID;
begin
 Result := g_opcode_Editions_SetCurrent;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Contents_SetCurrent : TvcmOpID;
begin
 Result := g_opcode_Contents_SetCurrent;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Contents_MoveCurrent : TvcmOpID;
begin
 Result := g_opcode_Contents_MoveCurrent;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Contents_HasUserComments : TvcmOpID;
begin
 Result := g_opcode_Contents_HasUserComments;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Contents_HasBookmarks : TvcmOpID;
begin
 Result := g_opcode_Contents_HasBookmarks;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Contents_ToggleContentsVisibility : TvcmOpID;
begin
 Result := g_opcode_Contents_ToggleContentsVisibility;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Contents_IsContentsVisible : TvcmOpID;
begin
 Result := g_opcode_Contents_IsContentsVisible;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_ContentsValidator_IsDocumentAdornmentsChanged : TvcmOpID;
begin
 Result := g_opcode_ContentsValidator_IsDocumentAdornmentsChanged;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Comment_Changed : TvcmOpID;
begin
 Result := g_opcode_Comment_Changed;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Picture_InitNewContent : TvcmOpID;
begin
 Result := g_opcode_Picture_InitNewContent;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Document_OpenDocOnNumber : TvcmMOpID;
begin
 Result := g_module_opcode_Document_OpenDocOnNumber;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Warning_BecomeActive : TvcmOpID;
begin
 Result := g_opcode_Warning_BecomeActive;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Warning_SwitchActive : TvcmOpID;
begin
 Result := g_opcode_Warning_SwitchActive;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_SynchroView_BecomeActive : TvcmOpID;
begin
 Result := g_opcode_SynchroView_BecomeActive;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_List_GetDeList : TvcmOpID;
begin
 Result := g_opcode_List_GetDeList;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_List_SetCurrentVisible : TvcmOpID;
begin
 Result := g_opcode_List_SetCurrentVisible;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_List_SwitchToFullList : TvcmOpID;
begin
 Result := g_opcode_List_SwitchToFullList;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_List_GetDsList : TvcmOpID;
begin
 Result := g_opcode_List_GetDsList;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Filterable_Add : TvcmOpID;
begin
 Result := g_opcode_Filterable_Add;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Filterable_Delete : TvcmOpID;
begin
 Result := g_opcode_Filterable_Delete;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Filterable_ClearAll : TvcmOpID;
begin
 Result := g_opcode_Filterable_ClearAll;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Filterable_Refresh : TvcmOpID;
begin
 Result := g_opcode_Filterable_Refresh;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Filterable_GetListType : TvcmOpID;
begin
 Result := g_opcode_Filterable_GetListType;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Selection_Analize : TvcmOpID;
begin
 Result := g_opcode_Selection_Analize;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_LocalList_SearchInList : TvcmOpID;
begin
 Result := g_opcode_LocalList_SearchInList;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Filters_FiltersListOpen : TvcmOpID;
begin
 Result := g_opcode_Filters_FiltersListOpen;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_List_Sort : TvcmOpID;
begin
 Result := g_opcode_List_Sort;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Filters_InternalClear : TvcmOpID;
begin
 Result := g_opcode_Filters_InternalClear;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_CRList_SetType : TvcmOpID;
begin
 Result := g_opcode_CRList_SetType;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Filter_Activate : TvcmOpID;
begin
 Result := g_opcode_Filter_Activate;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Filter_ActivateNode : TvcmOpID;
begin
 Result := g_opcode_Filter_ActivateNode;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_ListInfo_BecomeActive : TvcmOpID;
begin
 Result := g_opcode_ListInfo_BecomeActive;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Filters_DeselectAll : TvcmOpID;
begin
 Result := g_opcode_Filters_DeselectAll;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Diction_OpenDict : TvcmMOpID;
begin
 Result := g_module_opcode_Diction_OpenDict;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Query_ClearAll : TvcmOpID;
begin
 Result := g_opcode_Query_ClearAll;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Query_SetList : TvcmOpID;
begin
 Result := g_opcode_Query_SetList;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Query_GetList : TvcmOpID;
begin
 Result := g_opcode_Query_GetList;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_SearchParameters_IsQueryEmpty : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_IsQueryEmpty;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_SearchParameters_GetQuery : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_GetQuery;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_SearchParameters_IsQuerySaved : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_IsQuerySaved;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_SearchParameters_SetQuery : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_SetQuery;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_SearchParameters_ClearQuery : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_ClearQuery;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_SearchParameter_QueryNotSaved : TvcmOpID;
begin
 Result := g_opcode_SearchParameter_QueryNotSaved;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_SearchParameter_ClearMistakes : TvcmOpID;
begin
 Result := g_opcode_SearchParameter_ClearMistakes;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_SearchParameter_QuerySaved : TvcmOpID;
begin
 Result := g_opcode_SearchParameter_QuerySaved;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Attribute_DefaultAction : TvcmOpID;
begin
 Result := g_opcode_Attribute_DefaultAction;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Attribute_LogicOr : TvcmOpID;
begin
 Result := g_opcode_Attribute_LogicOr;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Attribute_LogicAnd : TvcmOpID;
begin
 Result := g_opcode_Attribute_LogicAnd;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Attribute_LogicNot : TvcmOpID;
begin
 Result := g_opcode_Attribute_LogicNot;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Attribute_LogicOrShortcut : TvcmOpID;
begin
 Result := g_opcode_Attribute_LogicOrShortcut;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Tips_ShowDayTips : TvcmMOpID;
begin
 Result := g_module_opcode_Tips_ShowDayTips;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Inpharm_MedicDiction : TvcmMOpID;
begin
 Result := g_module_opcode_Inpharm_MedicDiction;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Inpharm_MedicFirms : TvcmMOpID;
begin
 Result := g_module_opcode_Inpharm_MedicFirms;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Inpharm_DrugList : TvcmMOpID;
begin
 Result := g_module_opcode_Inpharm_DrugList;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Inpharm_MedicMainMenu : TvcmMOpID;
begin
 Result := g_module_opcode_Inpharm_MedicMainMenu;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_StyleEditor_ReloadStyleTable : TvcmOpID;
begin
 Result := g_opcode_StyleEditor_ReloadStyleTable;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_StyleEditor_RestoreStyleTable : TvcmOpID;
begin
 Result := g_opcode_StyleEditor_RestoreStyleTable;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_StyleEditor_SaveStyleTable : TvcmOpID;
begin
 Result := g_opcode_StyleEditor_SaveStyleTable;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_StyleEditor_SetNewContent : TvcmOpID;
begin
 Result := g_opcode_StyleEditor_SetNewContent;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_StyleEditor_ReloadStylesTree : TvcmOpID;
begin
 Result := g_opcode_StyleEditor_ReloadStylesTree;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Settings_OpenStyleEditorAsModal : TvcmMOpID;
begin
 Result := g_module_opcode_Settings_OpenStyleEditorAsModal;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Settings_AutoLogin : TvcmMOpID;
begin
 Result := g_module_opcode_Settings_AutoLogin;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Settings_SelectConfig : TvcmMOpID;
begin
 Result := g_module_opcode_Settings_SelectConfig;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Settings_OpenConfList : TvcmMOpID;
begin
 Result := g_module_opcode_Settings_OpenConfList;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Settings_LoadActiveSettings : TvcmMOpID;
begin
 Result := g_module_opcode_Settings_LoadActiveSettings;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Settings_UserProperties : TvcmMOpID;
begin
 Result := g_module_opcode_Settings_UserProperties;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_Filters_GetSelected : TvcmOpID;
begin
 Result := g_opcode_Filters_GetSelected;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_DocumentListFromFile_OpenDocumentListFromFile : TvcmMOpID;
begin
 Result := g_module_opcode_DocumentListFromFile_OpenDocumentListFromFile;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Search_PublishSourceSearch : TvcmMOpID;
begin
 Result := g_module_opcode_Search_PublishSourceSearch;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Search_InpharmSearch : TvcmMOpID;
begin
 Result := g_module_opcode_Search_InpharmSearch;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Search_StartENO : TvcmMOpID;
begin
 Result := g_module_opcode_Search_StartENO;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Search_DocumentsWithoutClass : TvcmMOpID;
begin
 Result := g_module_opcode_Search_DocumentsWithoutClass;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Search_DocumentsWithoutIncluded : TvcmMOpID;
begin
 Result := g_module_opcode_Search_DocumentsWithoutIncluded;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Search_DocumentsWithoutKey : TvcmMOpID;
begin
 Result := g_module_opcode_Search_DocumentsWithoutKey;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Search_BaseSearch : TvcmMOpID;
begin
 Result := g_module_opcode_Search_BaseSearch;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Search_OpenConsult : TvcmMOpID;
begin
 Result := g_module_opcode_Search_OpenConsult;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Search_AllSearch : TvcmMOpID;
begin
 Result := g_module_opcode_Search_AllSearch;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_ContextParams_ContextChanged : TvcmOpID;
begin
 Result := g_opcode_ContextParams_ContextChanged;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Search_OpenKeyWordSearch : TvcmMOpID;
begin
 Result := g_module_opcode_Search_OpenKeyWordSearch;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_Search_AttributeSearch : TvcmMOpID;
begin
 Result := g_module_opcode_Search_AttributeSearch;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_AttributeTree_SetParent : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_SetParent;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_AttributeTree_ExtSetRoot : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_ExtSetRoot;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_AttributeTree_SetRoot : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_SetRoot;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_AttributeTree_ExternalCharPressed : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_ExternalCharPressed;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_AttributeTree_SetCurrent : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_SetCurrent;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_AttributeTree_DropAllLogicSelection : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_DropAllLogicSelection;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_AttributeTree_Invalidate : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_Invalidate;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_AttributeTree_DropLogicSelection : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_DropLogicSelection;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_AttributeTree_LoadQuery : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_LoadQuery;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_AttributeTree_SetOneLevelCurrent : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_SetOneLevelCurrent;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.opcode_AttributeTree_AddNodeIfEmpty : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_AddNodeIfEmpty;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TNemesisRes.mod_opcode_CommonPost_SavePostList : TvcmMOpID;
begin
 Result := g_module_opcode_CommonPost_SavePostList;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

{$IfEnd} //not Admin AND not Monitorings

end.