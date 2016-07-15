unit NemesisRes;
 {* [$90440042] }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\NemesisRes.pas"
// Стереотип: "VCMApplication"
// Элемент модели: "Nemesis" MUID: (4A9527D40146)
// Имя типа: "TNemesisRes"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimNemesisRes
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , ChatInterfaces
 , WorkJournalInterfaces
 , AdapterFacade
 , DocumentUnit
 , eeInterfaces
 , EditionsInterfaces
 , bsTypesNew
 , l3Interfaces
 , BaseTreeSupportUnit
 , FoldersUnit
 , nsFormCoordinates
 , FoldersDomainInterfaces
 , nsTypes
 , BaseTypesUnit
 , ChatTypes
 , MonitoringUnit
 , SearchInterfaces
 , l3PrinterInterfaces
 , UnderControlUnit
 , PresentationInterfaces
 , DocumentInterfaces
 , DocumentDomainInterfaces
 , DocumentAndListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 , l3TreeInterfaces
 , PrimPrimListInterfaces
 , bsTypes
 , DynamicTreeUnit
 , MainMenuUnit
 , ConfigInterfaces
 , SearchUnit
 , ConsultationDomainInterfaces
 , PrimBaseSearchInterfaces
 , BaseSearchInterfaces
 , SimpleListInterfaces
 , Classes
 , FiltersUnit
 , DynamicDocListUnit
 , nsQueryInterfaces
;

type
 TNemesisRes = {final} class(TPrimNemesisRes)
  {* [$90440042] }
  public
   class function mod_opcode_InternetAgent_InternetAgent: TvcmMOPID;
   class function mod_opcode_Folders_MyInformation: TvcmMOPID;
   class function mod_opcode_Folders_MyConsultations: TvcmMOPID;
   class function mod_opcode_Folders_UnderControlOpenFrmAct: TvcmMOPID;
   class function mod_opcode_Folders_OpenFrmAct: TvcmMOPID;
   class function mod_opcode_Chat_OpenContactList: TvcmMOPID;
   class function mod_opcode_WorkJournal_OpenJournal: TvcmMOPID;
   class function mod_opcode_Monitorings_OpenNewsLine: TvcmMOPID;
   class function mod_opcode_Monitorings_OpenLegislationReview: TvcmMOPID;
   class function mod_opcode_Common_ComplectInfo: TvcmMOPID;
   class function mod_opcode_Common_PageSetup: TvcmMOPID;
   class function mod_opcode_Common_ShowEULA: TvcmMOPID;
   class function mod_opcode_Common_OpenMainMenuByButton: TvcmMOPID;
   class function mod_opcode_Common_OpenMainMenuNew: TvcmMOPID;
   class function mod_opcode_Common_TasksPanel: TvcmMOPID;
   class function mod_opcode_Common_LetterToDevelopers: TvcmMOPID;
   class function mod_opcode_Common_OpenRubricator: TvcmMOPID;
   class function mod_opcode_Common_OpenInformation: TvcmMOPID;
   class function mod_opcode_Common_get_navigator: TvcmMOPID;
   class function mod_opcode_Common_OpenIntranet: TvcmMOPID;
   class function mod_opcode_Document_OpenDocOnNumber: TvcmMOPID;
   class function mod_opcode_Diction_OpenDict: TvcmMOPID;
   class function mod_opcode_Tips_ShowDayTips: TvcmMOPID;
   class function mod_opcode_Inpharm_MedicDiction: TvcmMOPID;
   class function mod_opcode_Inpharm_MedicFirms: TvcmMOPID;
   class function mod_opcode_Inpharm_DrugList: TvcmMOPID;
   class function mod_opcode_Inpharm_MedicMainMenu: TvcmMOPID;
   class function mod_opcode_Settings_OpenStyleEditorAsModal: TvcmMOPID;
   class function mod_opcode_Settings_AutoLogin: TvcmMOPID;
   class function mod_opcode_Settings_SelectConfig: TvcmMOPID;
   class function mod_opcode_Settings_OpenConfList: TvcmMOPID;
   class function mod_opcode_Settings_LoadActiveSettings: TvcmMOPID;
   class function mod_opcode_Settings_UserProperties: TvcmMOPID;
   class function mod_opcode_DocumentListFromFile_OpenDocumentListFromFile: TvcmMOPID;
   class function mod_opcode_Search_PublishSourceSearch: TvcmMOPID;
   class function mod_opcode_Search_InpharmSearch: TvcmMOPID;
   class function mod_opcode_Search_StartENO: TvcmMOPID;
   class function mod_opcode_Search_DocumentsWithoutClass: TvcmMOPID;
   class function mod_opcode_Search_DocumentsWithoutIncluded: TvcmMOPID;
   class function mod_opcode_Search_DocumentsWithoutKey: TvcmMOPID;
   class function mod_opcode_Search_BaseSearch: TvcmMOPID;
   class function mod_opcode_Search_OpenConsult: TvcmMOPID;
   class function mod_opcode_Search_AllSearch: TvcmMOPID;
   class function mod_opcode_Search_OpenKeyWordSearch: TvcmMOPID;
   class function mod_opcode_Search_AttributeSearch: TvcmMOPID;
   class function mod_opcode_CommonPost_SavePostList: TvcmMOPID;
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
   class function MakeChatDispatcher: IbsChatDispatcher;
   class function OpenChatWindow(anUID: TbsUserID;
    const aName: Il3CString): IvcmEntityForm;
   class function OpenAddUserDialog: IvcmEntityForm;
   class function OpenHistoryWindow(anUID: TbsUserID;
    const aName: Il3CString): IvcmEntityForm;
   class function MakeWorkJournal: IbsWorkJournal;
   class procedure OpenAutoreferat(const aDoc: IDocument;
    const aContainer: IvcmContainer);
   class procedure OpenAutoreferatAfterSearch(const aList: IMonitoringList;
    const aContainer: IvcmContainer);
   class function OpenNewsLine(aDenyNewTab: Boolean): IvcmEntityForm;
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
   class procedure MakeListAnalizer(const aTree: Il3SimpleTree);
   class procedure OpenList(const aList: IdeList;
    const aContainer: IvcmContainer);
    {* Открывает список в указанном контейнере }
   class procedure OpenListWithReplace(const aList: IdeList;
    const aContainer: IvcmContainer);
    {* Открывает список в указанном контейнере. БЕЗ сохранения в историю. [$164601301] }
   class procedure OpenTermByContext(const aContext: Il3CString;
    aLanguage: TbsLanguage);
    {* Открывает термин по подстроке }
   class procedure OpenDictionary(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* Открывает толковый словарь }
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
   class procedure GiveMarkOnConsultation(const aNode: Il3SimpleNode);
   class procedure OpenSendConsultation(const aQuery: IQuery);
   class procedure OpenEntityAsConsultation(const aCons: IUnknown;
    const aContainer: IvcmContainer);
   class procedure OpenConsultation(const aCons: IbsConsultation;
    const aContainer: IvcmContainer);
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
   class procedure FiltersOpen(const aData: IucpFilters);
   class procedure OldSchoolFiltersOpen(const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer;
    anOwner: TComponent);
   class function CreateFilter(const aQuery: IQuery): Integer;
   class procedure RenameFilter(const aFilter: IFilterFromQuery);
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
   class procedure OpenPharmLegislationReview;
   class procedure MakeAAC(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* Создаёт сборку для документа ААК }
   class procedure MakeAACContents(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* Создаёт сборку для документа ОГЛАВЛЕНИЯ ААК }
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
 end;//TNemesisRes
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , moCompareEditions
 , moInternetAgent
 , moFolders
 , moChat
 , moWorkJournal
 , moMonitorings
 , moCommon
 , moDocument
 , moList
 , moDiction
 , moTips
 , moInpharm
 , moRubricator
 , moSettings
 , moMainMenu
 , moConsultations
 , moBaseSearch
 , moFilters
 , moUnderControl
 , moDocumentListFromFile
 , moChangesBetweenEditions
 , moSearch
 , moAAC
 , moCommonPost
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngineEX
 {$IfEnd} // NOT Defined(NoScripts)
 , BaseEditions_Module
 , PrimInternetAgent_Module
 , PrimFolders_Module
 , BaseChat_Module
 , BaseWorkJournal_Module
 , PrimMonitorings_Module
 , PrimF1Common_Module
 , Document_Module
 , List_Module
 , Diction_Module
 , DayTips_Module
 , Inpharm_Module
 , Rubricator_Module
 , Settings_Module
 , MainMenu_Module
 , Consultation_Module
 , BaseSearch_Module
 , Filters_Module
 , UnderControl_Module
 , PrimDocumentListFromFile_Module
 , ChangesBetweenEditions_Module
 , Search_Module
 , AACPrim_Module
 , CommonPost_Module
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , evExtFormat
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4A9527D40146impl_uses*
 //#UC END# *4A9527D40146impl_uses*
;

class function TNemesisRes.mod_opcode_InternetAgent_InternetAgent: TvcmMOPID;
begin
 Result := g_module_opcode_InternetAgent_InternetAgent;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_InternetAgent_InternetAgent

class function TNemesisRes.mod_opcode_Folders_MyInformation: TvcmMOPID;
begin
 Result := g_module_opcode_Folders_MyInformation;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Folders_MyInformation

class function TNemesisRes.mod_opcode_Folders_MyConsultations: TvcmMOPID;
begin
 Result := g_module_opcode_Folders_MyConsultations;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Folders_MyConsultations

class function TNemesisRes.mod_opcode_Folders_UnderControlOpenFrmAct: TvcmMOPID;
begin
 Result := g_module_opcode_Folders_UnderControlOpenFrmAct;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Folders_UnderControlOpenFrmAct

class function TNemesisRes.mod_opcode_Folders_OpenFrmAct: TvcmMOPID;
begin
 Result := g_module_opcode_Folders_OpenFrmAct;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Folders_OpenFrmAct

class function TNemesisRes.mod_opcode_Chat_OpenContactList: TvcmMOPID;
begin
 Result := g_module_opcode_Chat_OpenContactList;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Chat_OpenContactList

class function TNemesisRes.mod_opcode_WorkJournal_OpenJournal: TvcmMOPID;
begin
 Result := g_module_opcode_WorkJournal_OpenJournal;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_WorkJournal_OpenJournal

class function TNemesisRes.mod_opcode_Monitorings_OpenNewsLine: TvcmMOPID;
begin
 Result := g_module_opcode_Monitorings_OpenNewsLine;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Monitorings_OpenNewsLine

class function TNemesisRes.mod_opcode_Monitorings_OpenLegislationReview: TvcmMOPID;
begin
 Result := g_module_opcode_Monitorings_OpenLegislationReview;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Monitorings_OpenLegislationReview

class function TNemesisRes.mod_opcode_Common_ComplectInfo: TvcmMOPID;
begin
 Result := g_module_opcode_Common_ComplectInfo;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Common_ComplectInfo

class function TNemesisRes.mod_opcode_Common_PageSetup: TvcmMOPID;
begin
 Result := g_module_opcode_Common_PageSetup;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Common_PageSetup

class function TNemesisRes.mod_opcode_Common_ShowEULA: TvcmMOPID;
begin
 Result := g_module_opcode_Common_ShowEULA;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Common_ShowEULA

class function TNemesisRes.mod_opcode_Common_OpenMainMenuByButton: TvcmMOPID;
begin
 Result := g_module_opcode_Common_OpenMainMenuByButton;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Common_OpenMainMenuByButton

class function TNemesisRes.mod_opcode_Common_OpenMainMenuNew: TvcmMOPID;
begin
 Result := g_module_opcode_Common_OpenMainMenuNew;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Common_OpenMainMenuNew

class function TNemesisRes.mod_opcode_Common_TasksPanel: TvcmMOPID;
begin
 Result := g_module_opcode_Common_TasksPanel;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Common_TasksPanel

class function TNemesisRes.mod_opcode_Common_LetterToDevelopers: TvcmMOPID;
begin
 Result := g_module_opcode_Common_LetterToDevelopers;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Common_LetterToDevelopers

class function TNemesisRes.mod_opcode_Common_OpenRubricator: TvcmMOPID;
begin
 Result := g_module_opcode_Common_OpenRubricator;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Common_OpenRubricator

class function TNemesisRes.mod_opcode_Common_OpenInformation: TvcmMOPID;
begin
 Result := g_module_opcode_Common_OpenInformation;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Common_OpenInformation

class function TNemesisRes.mod_opcode_Common_get_navigator: TvcmMOPID;
begin
 Result := g_module_opcode_Common_get_navigator;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Common_get_navigator

class function TNemesisRes.mod_opcode_Common_OpenIntranet: TvcmMOPID;
begin
 Result := g_module_opcode_Common_OpenIntranet;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Common_OpenIntranet

class function TNemesisRes.mod_opcode_Document_OpenDocOnNumber: TvcmMOPID;
begin
 Result := g_module_opcode_Document_OpenDocOnNumber;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Document_OpenDocOnNumber

class function TNemesisRes.mod_opcode_Diction_OpenDict: TvcmMOPID;
begin
 Result := g_module_opcode_Diction_OpenDict;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Diction_OpenDict

class function TNemesisRes.mod_opcode_Tips_ShowDayTips: TvcmMOPID;
begin
 Result := g_module_opcode_Tips_ShowDayTips;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Tips_ShowDayTips

class function TNemesisRes.mod_opcode_Inpharm_MedicDiction: TvcmMOPID;
begin
 Result := g_module_opcode_Inpharm_MedicDiction;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Inpharm_MedicDiction

class function TNemesisRes.mod_opcode_Inpharm_MedicFirms: TvcmMOPID;
begin
 Result := g_module_opcode_Inpharm_MedicFirms;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Inpharm_MedicFirms

class function TNemesisRes.mod_opcode_Inpharm_DrugList: TvcmMOPID;
begin
 Result := g_module_opcode_Inpharm_DrugList;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Inpharm_DrugList

class function TNemesisRes.mod_opcode_Inpharm_MedicMainMenu: TvcmMOPID;
begin
 Result := g_module_opcode_Inpharm_MedicMainMenu;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Inpharm_MedicMainMenu

class function TNemesisRes.mod_opcode_Settings_OpenStyleEditorAsModal: TvcmMOPID;
begin
 Result := g_module_opcode_Settings_OpenStyleEditorAsModal;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Settings_OpenStyleEditorAsModal

class function TNemesisRes.mod_opcode_Settings_AutoLogin: TvcmMOPID;
begin
 Result := g_module_opcode_Settings_AutoLogin;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Settings_AutoLogin

class function TNemesisRes.mod_opcode_Settings_SelectConfig: TvcmMOPID;
begin
 Result := g_module_opcode_Settings_SelectConfig;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Settings_SelectConfig

class function TNemesisRes.mod_opcode_Settings_OpenConfList: TvcmMOPID;
begin
 Result := g_module_opcode_Settings_OpenConfList;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Settings_OpenConfList

class function TNemesisRes.mod_opcode_Settings_LoadActiveSettings: TvcmMOPID;
begin
 Result := g_module_opcode_Settings_LoadActiveSettings;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Settings_LoadActiveSettings

class function TNemesisRes.mod_opcode_Settings_UserProperties: TvcmMOPID;
begin
 Result := g_module_opcode_Settings_UserProperties;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Settings_UserProperties

class function TNemesisRes.mod_opcode_DocumentListFromFile_OpenDocumentListFromFile: TvcmMOPID;
begin
 Result := g_module_opcode_DocumentListFromFile_OpenDocumentListFromFile;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_DocumentListFromFile_OpenDocumentListFromFile

class function TNemesisRes.mod_opcode_Search_PublishSourceSearch: TvcmMOPID;
begin
 Result := g_module_opcode_Search_PublishSourceSearch;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Search_PublishSourceSearch

class function TNemesisRes.mod_opcode_Search_InpharmSearch: TvcmMOPID;
begin
 Result := g_module_opcode_Search_InpharmSearch;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Search_InpharmSearch

class function TNemesisRes.mod_opcode_Search_StartENO: TvcmMOPID;
begin
 Result := g_module_opcode_Search_StartENO;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Search_StartENO

class function TNemesisRes.mod_opcode_Search_DocumentsWithoutClass: TvcmMOPID;
begin
 Result := g_module_opcode_Search_DocumentsWithoutClass;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Search_DocumentsWithoutClass

class function TNemesisRes.mod_opcode_Search_DocumentsWithoutIncluded: TvcmMOPID;
begin
 Result := g_module_opcode_Search_DocumentsWithoutIncluded;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Search_DocumentsWithoutIncluded

class function TNemesisRes.mod_opcode_Search_DocumentsWithoutKey: TvcmMOPID;
begin
 Result := g_module_opcode_Search_DocumentsWithoutKey;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Search_DocumentsWithoutKey

class function TNemesisRes.mod_opcode_Search_BaseSearch: TvcmMOPID;
begin
 Result := g_module_opcode_Search_BaseSearch;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Search_BaseSearch

class function TNemesisRes.mod_opcode_Search_OpenConsult: TvcmMOPID;
begin
 Result := g_module_opcode_Search_OpenConsult;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Search_OpenConsult

class function TNemesisRes.mod_opcode_Search_AllSearch: TvcmMOPID;
begin
 Result := g_module_opcode_Search_AllSearch;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Search_AllSearch

class function TNemesisRes.mod_opcode_Search_OpenKeyWordSearch: TvcmMOPID;
begin
 Result := g_module_opcode_Search_OpenKeyWordSearch;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Search_OpenKeyWordSearch

class function TNemesisRes.mod_opcode_Search_AttributeSearch: TvcmMOPID;
begin
 Result := g_module_opcode_Search_AttributeSearch;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_Search_AttributeSearch

class function TNemesisRes.mod_opcode_CommonPost_SavePostList: TvcmMOPID;
begin
 Result := g_module_opcode_CommonPost_SavePostList;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TNemesisRes.mod_opcode_CommonPost_SavePostList

class procedure TNemesisRes.MakeCompareEditions(const aDoc: IDocument;
 const aPara: IeeLeafPara;
 aEditionForCompare: Integer;
 const aDocumentForReturn: TnsDocumentForReturnInfo;
 const aContainer: IvcmContainer = nil);
 {* Создаёт представление прецедента "Сравнение редакций" }
begin
 TBaseEditionsModule.MakeCompareEditions(aDoc, aPara, aEditionForCompare, aDocumentForReturn, aContainer);
end;//TNemesisRes.MakeCompareEditions

class procedure TNemesisRes.MakeCompareEditions(const aDoc: IDocument;
 const aPara: IeeLeafPara;
 const aContainer: IvcmContainer = nil);
begin
 TBaseEditionsModule.MakeCompareEditions(aDoc, aPara, aContainer);
end;//TNemesisRes.MakeCompareEditions

class procedure TNemesisRes.MakeCompareEditions(const aLeft: IDocument;
 const aRight: IDocument;
 const aPara: IeeLeafPara;
 const aContainer: IvcmContainer = nil);
begin
 TBaseEditionsModule.MakeCompareEditions(aLeft, aRight, aPara, aContainer);
end;//TNemesisRes.MakeCompareEditions

class procedure TNemesisRes.MakeCompareEditions(const aDoc: IDocument;
 const aPara: IeeLeafPara;
 aEditionForCompare: Integer;
 const aContainer: IvcmContainer = nil);
begin
 TBaseEditionsModule.MakeCompareEditions(aDoc, aPara, aEditionForCompare, aContainer);
end;//TNemesisRes.MakeCompareEditions

class procedure TNemesisRes.MakeCompareEditions(const aLeft: IDocument;
 const aRight: IDocument;
 const aParaForPositionning: IeeLeafPara;
 const aDocumentForReturn: IDocument;
 const aParaForReturn: IeeLeafPara;
 const aContainer: IvcmContainer = nil);
begin
 TBaseEditionsModule.MakeCompareEditions(aLeft, aRight, aParaForPositionning, aDocumentForReturn, aParaForReturn, aContainer);
end;//TNemesisRes.MakeCompareEditions

class procedure TNemesisRes.MakeCompareEditions(const aLeft: IDocument;
 const aRight: IDocument;
 const aPosition: TbsDocPos;
 const aDocumentForReturn: IDocument;
 const aParaForReturn: IeeLeafPara;
 const aContainer: IvcmContainer = nil);
begin
 TBaseEditionsModule.MakeCompareEditions(aLeft, aRight, aPosition, aDocumentForReturn, aParaForReturn, aContainer);
end;//TNemesisRes.MakeCompareEditions

class procedure TNemesisRes.MakeInternetAgent(const anURL: Il3CString;
 const aContainer: IvcmContainer);
 {* Создаёт область вывода Интернет-агента }
begin
 TPrimInternetAgentModule.MakeInternetAgent(anURL, aContainer);
end;//TNemesisRes.MakeInternetAgent

class function TNemesisRes.OpenFolders(const aContainer: IvcmContainer;
 aCanCreate: Boolean): IvcmEntityForm;
begin
 Result := TPrimFoldersModule.OpenFolders(aContainer, aCanCreate);
end;//TNemesisRes.OpenFolders

class procedure TNemesisRes.CloseFolders(const aContainer: IvcmContainer);
begin
 TPrimFoldersModule.CloseFolders(aContainer);
end;//TNemesisRes.CloseFolders

class procedure TNemesisRes.TryOpenConsultationAnswer(const aContainer: IvcmContainer);
begin
 TPrimFoldersModule.TryOpenConsultationAnswer(aContainer);
end;//TNemesisRes.TryOpenConsultationAnswer

class procedure TNemesisRes.RefreshStructure(const aNode: INode;
 aStatus: TNotifyStatus);
begin
 TPrimFoldersModule.RefreshStructure(aNode, aStatus);
end;//TNemesisRes.RefreshStructure

class function TNemesisRes.EditInfoOpen(aIsNewFolder: Boolean;
 const aNode: IeeNode;
 const aCoords: InsFormCoordinates): Integer;
begin
 Result := TPrimFoldersModule.EditInfoOpen(aIsNewFolder, aNode, aCoords);
end;//TNemesisRes.EditInfoOpen

class procedure TNemesisRes.LoadOpen(const aForm: IvcmEntityForm;
 const aData: InsFolderFilterInfo);
begin
 TPrimFoldersModule.LoadOpen(aForm, aData);
end;//TNemesisRes.LoadOpen

class procedure TNemesisRes.SelectOpen(const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 const aCaption: TvcmStringID);
begin
 TPrimFoldersModule.SelectOpen(aForm, aFilterInfo, aCaption);
end;//TNemesisRes.SelectOpen

class procedure TNemesisRes.SelectOpenWithOperation(const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 const aCaption: TvcmStringID;
 anOp: TListLogicOperation);
begin
 TPrimFoldersModule.SelectOpenWithOperation(aForm, aFilterInfo, aCaption, anOp);
end;//TNemesisRes.SelectOpenWithOperation

class procedure TNemesisRes.SelectOpenWithUserData(const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 const aCaption: TvcmStringID;
 const aUserData: IUnknown);
begin
 TPrimFoldersModule.SelectOpenWithUserData(aForm, aFilterInfo, aCaption, aUserData);
end;//TNemesisRes.SelectOpenWithUserData

class function TNemesisRes.SaveOpen(const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 anElementType: TFoldersElementType;
 const anEntity: IEntityBase;
 aSaveAs: Boolean): Integer;
begin
 Result := TPrimFoldersModule.SaveOpen(aForm, aFilterInfo, anElementType, anEntity, aSaveAs);
end;//TNemesisRes.SaveOpen

class function TNemesisRes.MakeChatDispatcher: IbsChatDispatcher;
begin
 Result := TBaseChatModule.MakeChatDispatcher;
end;//TNemesisRes.MakeChatDispatcher

class function TNemesisRes.OpenChatWindow(anUID: TbsUserID;
 const aName: Il3CString): IvcmEntityForm;
begin
 Result := TBaseChatModule.OpenChatWindow(anUID, aName);
end;//TNemesisRes.OpenChatWindow

class function TNemesisRes.OpenAddUserDialog: IvcmEntityForm;
begin
 Result := TBaseChatModule.OpenAddUserDialog;
end;//TNemesisRes.OpenAddUserDialog

class function TNemesisRes.OpenHistoryWindow(anUID: TbsUserID;
 const aName: Il3CString): IvcmEntityForm;
begin
 Result := TBaseChatModule.OpenHistoryWindow(anUID, aName);
end;//TNemesisRes.OpenHistoryWindow

class function TNemesisRes.MakeWorkJournal: IbsWorkJournal;
begin
 Result := TBaseWorkJournalModule.MakeWorkJournal;
end;//TNemesisRes.MakeWorkJournal

class procedure TNemesisRes.OpenAutoreferat(const aDoc: IDocument;
 const aContainer: IvcmContainer);
begin
 TPrimMonitoringsModule.OpenAutoreferat(aDoc, aContainer);
end;//TNemesisRes.OpenAutoreferat

class procedure TNemesisRes.OpenAutoreferatAfterSearch(const aList: IMonitoringList;
 const aContainer: IvcmContainer);
begin
 TPrimMonitoringsModule.OpenAutoreferatAfterSearch(aList, aContainer);
end;//TNemesisRes.OpenAutoreferatAfterSearch

class function TNemesisRes.OpenNewsLine(aDenyNewTab: Boolean): IvcmEntityForm;
begin
 Result := TPrimMonitoringsModule.OpenNewsLine(aDenyNewTab);
end;//TNemesisRes.OpenNewsLine

class function TNemesisRes.MakeProgressIndicator(const aProgress: InsProgressIndicator;
 const aCaption: Il3CString;
 aMaxCount: Integer): IvcmEntityForm;
begin
 Result := TPrimF1CommonModule.MakeProgressIndicator(aProgress, aCaption, aMaxCount);
end;//TNemesisRes.MakeProgressIndicator

class procedure TNemesisRes.CloseNavigator(const aContainer: IvcmContainer);
begin
 TPrimF1CommonModule.CloseNavigator(aContainer);
end;//TNemesisRes.CloseNavigator

class procedure TNemesisRes.CloseTasksPanel(const aContainer: IvcmContainer);
begin
 TPrimF1CommonModule.CloseTasksPanel(aContainer);
end;//TNemesisRes.CloseTasksPanel

class procedure TNemesisRes.FromPrinterSettings(const aPrinter: Il3Printer);
 {* Считать настройки из принтера }
begin
 TPrimF1CommonModule.FromPrinterSettings(aPrinter);
end;//TNemesisRes.FromPrinterSettings

class procedure TNemesisRes.ToPrinterSettings(const aPrinter: Il3Printer);
 {* Записать настройки в принтер }
begin
 TPrimF1CommonModule.ToPrinterSettings(aPrinter);
end;//TNemesisRes.ToPrinterSettings

class procedure TNemesisRes.About;
 {* Выводит диалог "О программе" }
begin
 TPrimF1CommonModule.About;
end;//TNemesisRes.About

class procedure TNemesisRes.ApplicationActivate;
begin
 TPrimF1CommonModule.ApplicationActivate;
end;//TNemesisRes.ApplicationActivate

class procedure TNemesisRes.OpenRubricatorOnStart(const aContainer: IvcmContainer);
begin
 TPrimF1CommonModule.OpenRubricatorOnStart(aContainer);
end;//TNemesisRes.OpenRubricatorOnStart

class procedure TNemesisRes.OpenNewDocs(const aContainer: IvcmContainer);
begin
 TPrimF1CommonModule.OpenNewDocs(aContainer);
end;//TNemesisRes.OpenNewDocs

class procedure TNemesisRes.GetNavigator(const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer);
 {* Меню (вкладка) }
begin
 TPrimF1CommonModule.GetNavigator(anAggregate, aContainer);
end;//TNemesisRes.GetNavigator

class procedure TNemesisRes.OpenTasksPanel(const aContainer: IvcmContainer);
begin
 TPrimF1CommonModule.OpenTasksPanel(aContainer);
end;//TNemesisRes.OpenTasksPanel

class procedure TNemesisRes.AddDocumentToControl(const aDocument: IDocument);
 {* Поставить документ на контроль }
begin
 TPrimF1CommonModule.AddDocumentToControl(aDocument);
end;//TNemesisRes.AddDocumentToControl

class procedure TNemesisRes.AddToControl(const aControllable: IControllable);
 {* Поставить объект на контроль }
begin
 TPrimF1CommonModule.AddToControl(aControllable);
end;//TNemesisRes.AddToControl

class procedure TNemesisRes.DeleteDocumentFromControl(const aDocument: IDocument);
 {* Снять документ с контроля }
begin
 TPrimF1CommonModule.DeleteDocumentFromControl(aDocument);
end;//TNemesisRes.DeleteDocumentFromControl

class procedure TNemesisRes.DeleteFromControl(const aControllable: IControllable);
 {* Снять объект с контроля }
begin
 TPrimF1CommonModule.DeleteFromControl(aControllable);
end;//TNemesisRes.DeleteFromControl

class function TNemesisRes.IsUnderControl(const aDoc: IDocument): Boolean;
 {* Находится ли документ на контроле }
begin
 Result := TPrimF1CommonModule.IsUnderControl(aDoc);
end;//TNemesisRes.IsUnderControl

class function TNemesisRes.IsCurEditionActual(const aState: IDocumentState): Boolean;
begin
 Result := TPrimF1CommonModule.IsCurEditionActual(aState);
end;//TNemesisRes.IsCurEditionActual

class function TNemesisRes.IsCurEditionActual(const aDocument: IDocument): Boolean;
begin
 Result := TPrimF1CommonModule.IsCurEditionActual(aDocument);
end;//TNemesisRes.IsCurEditionActual

class function TNemesisRes.GetCurEditionDate(const aDocument: IDocument): AdapterDate;
begin
 Result := TPrimF1CommonModule.GetCurEditionDate(aDocument);
end;//TNemesisRes.GetCurEditionDate

class function TNemesisRes.OpenTurnOffTimeMachine(const anIntf: InsTurnOffTimeMachine): IvcmEntityForm;
begin
 Result := TPrimF1CommonModule.OpenTurnOffTimeMachine(anIntf);
end;//TNemesisRes.OpenTurnOffTimeMachine

class procedure TNemesisRes.OpenDocument(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* Открывает документ }
begin
 TDocumentModule.OpenDocument(aDocInfo, aContainer);
end;//TNemesisRes.OpenDocument

class function TNemesisRes.OpenEntityAsDocument(const anEntity: IUnknown;
 const aContainer: IvcmContainer): IDocument;
begin
 Result := TDocumentModule.OpenEntityAsDocument(anEntity, aContainer);
end;//TNemesisRes.OpenEntityAsDocument

class function TNemesisRes.SafeOpenDocument(const aBaseEntity: IUnknown): IDocument;
begin
 Result := TDocumentModule.SafeOpenDocument(aBaseEntity);
end;//TNemesisRes.SafeOpenDocument

class procedure TNemesisRes.OpenDocumentWithCheck(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
begin
 TDocumentModule.OpenDocumentWithCheck(aDocInfo, aContainer);
end;//TNemesisRes.OpenDocumentWithCheck

class function TNemesisRes.OpenExternalObject(const aContainer: IvcmContainer;
 const aData: InsLinkedObjectData): IvcmEntityForm;
begin
 Result := TDocumentModule.OpenExternalObject(aContainer, aData);
end;//TNemesisRes.OpenExternalObject

class function TNemesisRes.OpenPicture(const aContainer: IvcmContainer;
 const aData: InsLinkedObjectData): IvcmEntityForm;
begin
 Result := TDocumentModule.OpenPicture(aContainer, aData);
end;//TNemesisRes.OpenPicture

class function TNemesisRes.OpenPictureInfo(const aContainer: IvcmContainer;
 const aData: InsLinkedObjectDescription): IvcmEntityForm;
begin
 Result := TDocumentModule.OpenPictureInfo(aContainer, aData);
end;//TNemesisRes.OpenPictureInfo

class function TNemesisRes.OpenTurnOnTimeMachine(const anIntf: InsTurnOnTimeMachine): IvcmEntityForm;
begin
 Result := TDocumentModule.OpenTurnOnTimeMachine(anIntf);
end;//TNemesisRes.OpenTurnOnTimeMachine

class function TNemesisRes.OpenEditionsListModal(const anEditionsHolder: IsdsEditionsHolder;
 const anAggregate: IvcmAggregate): IvcmEntityForm;
begin
 Result := TDocumentModule.OpenEditionsListModal(anEditionsHolder, anAggregate);
end;//TNemesisRes.OpenEditionsListModal

class function TNemesisRes.MakeBaloonForm(aCaller: TvcmContainerForm;
 aUserType: TvcmEffectiveUserType;
 const aWarning: IdsWarning): IvcmEntityForm;
begin
 Result := TDocumentModule.MakeBaloonForm(aCaller, aUserType, aWarning);
end;//TNemesisRes.MakeBaloonForm

class function TNemesisRes.DocumentShowChangesInfoSetting: Boolean;
 {* Метод для получения значения настройки "Показывать историю изменений в документе" }
begin
 Result := TDocumentModule.DocumentShowChangesInfoSetting;
end;//TNemesisRes.DocumentShowChangesInfoSetting

class procedure TNemesisRes.WriteDocumentShowChangesInfoSetting(aValue: Boolean);
 {* Метод для записи значения настройки "Показывать историю изменений в документе" }
begin
 TDocumentModule.WriteDocumentShowChangesInfoSetting(aValue);
end;//TNemesisRes.WriteDocumentShowChangesInfoSetting

class procedure TNemesisRes.MakeListAnalizer(const aTree: Il3SimpleTree);
begin
 TListModule.MakeListAnalizer(aTree);
end;//TNemesisRes.MakeListAnalizer

class procedure TNemesisRes.OpenList(const aList: IdeList;
 const aContainer: IvcmContainer);
 {* Открывает список в указанном контейнере }
begin
 TListModule.OpenList(aList, aContainer);
end;//TNemesisRes.OpenList

class procedure TNemesisRes.OpenListWithReplace(const aList: IdeList;
 const aContainer: IvcmContainer);
 {* Открывает список в указанном контейнере. БЕЗ сохранения в историю. [$164601301] }
begin
 TListModule.OpenListWithReplace(aList, aContainer);
end;//TNemesisRes.OpenListWithReplace

class procedure TNemesisRes.OpenTermByContext(const aContext: Il3CString;
 aLanguage: TbsLanguage);
 {* Открывает термин по подстроке }
begin
 TDictionModule.OpenTermByContext(aContext, aLanguage);
end;//TNemesisRes.OpenTermByContext

class procedure TNemesisRes.OpenDictionary(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* Открывает толковый словарь }
begin
 TDictionModule.OpenDictionary(aDocInfo, aContainer);
end;//TNemesisRes.OpenDictionary

class procedure TNemesisRes.OpenTip(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* Открывает совет дня }
begin
 TDayTipsModule.OpenTip(aDocInfo, aContainer);
end;//TNemesisRes.OpenTip

class function TNemesisRes.ShowDayTipsAtStartup: IvcmEntityForm;
begin
 Result := TDayTipsModule.ShowDayTipsAtStartup;
end;//TNemesisRes.ShowDayTipsAtStartup

class procedure TNemesisRes.OpenMedicDiction(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
begin
 TInpharmModule.OpenMedicDiction(aDocInfo, aContainer);
end;//TNemesisRes.OpenMedicDiction

class procedure TNemesisRes.OpenMedicFirmDocument(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
begin
 TInpharmModule.OpenMedicFirmDocument(aDocInfo, aContainer);
end;//TNemesisRes.OpenMedicFirmDocument

class procedure TNemesisRes.OpenDrugDocument(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
begin
 TInpharmModule.OpenDrugDocument(aDocInfo, aContainer);
end;//TNemesisRes.OpenDrugDocument

class procedure TNemesisRes.OpenDrugList(const aList: IdeList;
 const aContainer: IvcmContainer);
begin
 TInpharmModule.OpenDrugList(aList, aContainer);
end;//TNemesisRes.OpenDrugList

class procedure TNemesisRes.MedicFirms(const aContainer: IvcmContainer);
begin
 TInpharmModule.MedicFirms(aContainer);
end;//TNemesisRes.MedicFirms

class procedure TNemesisRes.OpenInpharmMainMenu(const aContainer: IvcmContainer);
begin
 TInpharmModule.OpenInpharmMainMenu(aContainer);
end;//TNemesisRes.OpenInpharmMainMenu

class procedure TNemesisRes.OpenDrugListIfNeeded(const aContainer: IvcmContainer);
begin
 TInpharmModule.OpenDrugListIfNeeded(aContainer);
end;//TNemesisRes.OpenDrugListIfNeeded

class function TNemesisRes.OpenRubricator(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem;
 aNeedsSheet: Boolean;
 const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer): IvcmEntityForm;
begin
 Result := TRubricatorModule.OpenRubricator(aNode, aRootToKeep, aMenuSectionItemToKeep, aNeedsSheet, anAggregate, aContainer);
end;//TNemesisRes.OpenRubricator

class function TNemesisRes.OpenStyleEditorAsModal(const aData: InsStyleTableSettingsInfo): Integer;
begin
 Result := TSettingsModule.OpenStyleEditorAsModal(aData);
end;//TNemesisRes.OpenStyleEditorAsModal

class procedure TNemesisRes.CloseConfList(const aContainer: IvcmContainer);
 {* Закрыть список конфигураций }
begin
 TSettingsModule.CloseConfList(aContainer);
end;//TNemesisRes.CloseConfList

class function TNemesisRes.LoadSettings(const anAggregate: IvcmAggregate;
 const aData: InsConfigSettingsInfo): IvcmEntityForm;
 {* Открыть настройки }
begin
 Result := TSettingsModule.LoadSettings(anAggregate, aData);
end;//TNemesisRes.LoadSettings

class procedure TNemesisRes.OpenConfList(const aContainer: IvcmContainer);
begin
 TSettingsModule.OpenConfList(aContainer);
end;//TNemesisRes.OpenConfList

class procedure TNemesisRes.OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
begin
 TMainMenuModule.OpenMainMenuIfNeeded(aContainer);
end;//TNemesisRes.OpenMainMenuIfNeeded

class function TNemesisRes.MainMenuChangeableMainMenuTypeSetting: Integer;
 {* Метод для получения значения настройки "Тип изменяемой части основного меню" }
begin
 Result := TMainMenuModule.MainMenuChangeableMainMenuTypeSetting;
end;//TNemesisRes.MainMenuChangeableMainMenuTypeSetting

class procedure TNemesisRes.WriteMainMenuChangeableMainMenuTypeSetting(aValue: Integer);
 {* Метод для записи значения настройки "Тип изменяемой части основного меню" }
begin
 TMainMenuModule.WriteMainMenuChangeableMainMenuTypeSetting(aValue);
end;//TNemesisRes.WriteMainMenuChangeableMainMenuTypeSetting

class procedure TNemesisRes.GiveMarkOnConsultation(const aNode: Il3SimpleNode);
begin
 TConsultationModule.GiveMarkOnConsultation(aNode);
end;//TNemesisRes.GiveMarkOnConsultation

class procedure TNemesisRes.OpenSendConsultation(const aQuery: IQuery);
begin
 TConsultationModule.OpenSendConsultation(aQuery);
end;//TNemesisRes.OpenSendConsultation

class procedure TNemesisRes.OpenEntityAsConsultation(const aCons: IUnknown;
 const aContainer: IvcmContainer);
begin
 TConsultationModule.OpenEntityAsConsultation(aCons, aContainer);
end;//TNemesisRes.OpenEntityAsConsultation

class procedure TNemesisRes.OpenConsultation(const aCons: IbsConsultation;
 const aContainer: IvcmContainer);
begin
 TConsultationModule.OpenConsultation(aCons, aContainer);
end;//TNemesisRes.OpenConsultation

class procedure TNemesisRes.TryAnotherBaseSearch(const aContainer: IvcmContainer;
 const aProcessor: InsBaseSearchResultProcessor;
 TryFullList: Boolean = False);
begin
 TBaseSearchModule.TryAnotherBaseSearch(aContainer, aProcessor, TryFullList);
end;//TNemesisRes.TryAnotherBaseSearch

class procedure TNemesisRes.OpenBaseSearch(OpenKind: TnsBaseSearchOpenKind;
 const aQuery: IQuery);
begin
 TBaseSearchModule.OpenBaseSearch(OpenKind, aQuery);
end;//TNemesisRes.OpenBaseSearch

class function TNemesisRes.MakeBaseSearchWindow(const aContainer: IvcmContainer;
 const aData: InsBaseSearcherWindowData;
 aZoneType: TvcmZoneType): IvcmEntityForm;
begin
 Result := TBaseSearchModule.MakeBaseSearchWindow(aContainer, aData, aZoneType);
end;//TNemesisRes.MakeBaseSearchWindow

class procedure TNemesisRes.BaseSearchCheckFragmentsCount(const aContainer: IvcmContainer);
begin
 TBaseSearchModule.BaseSearchCheckFragmentsCount(aContainer);
end;//TNemesisRes.BaseSearchCheckFragmentsCount

class procedure TNemesisRes.CheckBaseSearchDataReady(const aContainer: IvcmContainer);
begin
 TBaseSearchModule.CheckBaseSearchDataReady(aContainer);
end;//TNemesisRes.CheckBaseSearchDataReady

class procedure TNemesisRes.BaseSearchCheckFindBack(const aContainer: IvcmContainer);
begin
 TBaseSearchModule.BaseSearchCheckFindBack(aContainer);
end;//TNemesisRes.BaseSearchCheckFindBack

class function TNemesisRes.MakeBaseSearchCard(const aContainer: IvcmContainer): IvcmEntityForm;
begin
 Result := TBaseSearchModule.MakeBaseSearchCard(aContainer);
end;//TNemesisRes.MakeBaseSearchCard

class procedure TNemesisRes.FiltersOpen(const aData: IucpFilters);
begin
 TFiltersModule.FiltersOpen(aData);
end;//TNemesisRes.FiltersOpen

class procedure TNemesisRes.OldSchoolFiltersOpen(const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer;
 anOwner: TComponent);
begin
 TFiltersModule.OldSchoolFiltersOpen(anAggregate, aContainer, anOwner);
end;//TNemesisRes.OldSchoolFiltersOpen

class function TNemesisRes.CreateFilter(const aQuery: IQuery): Integer;
begin
 Result := TFiltersModule.CreateFilter(aQuery);
end;//TNemesisRes.CreateFilter

class procedure TNemesisRes.RenameFilter(const aFilter: IFilterFromQuery);
begin
 TFiltersModule.RenameFilter(aFilter);
end;//TNemesisRes.RenameFilter

class procedure TNemesisRes.CloseUnderControl(const aContainer: IvcmContainer);
begin
 TUnderControlModule.CloseUnderControl(aContainer);
end;//TNemesisRes.CloseUnderControl

class procedure TNemesisRes.OpenUnderControl(const aContainer: IvcmContainer);
begin
 TUnderControlModule.OpenUnderControl(aContainer);
end;//TNemesisRes.OpenUnderControl

class procedure TNemesisRes.BuildUnderControlList(const aContainer: IvcmContainer);
begin
 TUnderControlModule.BuildUnderControlList(aContainer);
end;//TNemesisRes.BuildUnderControlList

class procedure TNemesisRes.AddControlledObject(const aData: IControllable);
begin
 TUnderControlModule.AddControlledObject(aData);
end;//TNemesisRes.AddControlledObject

class procedure TNemesisRes.DeleteControlledObject(const aData: IControllable);
begin
 TUnderControlModule.DeleteControlledObject(aData);
end;//TNemesisRes.DeleteControlledObject

class procedure TNemesisRes.MarkControlledAsOpen(const aData: IControllable);
begin
 TUnderControlModule.MarkControlledAsOpen(aData);
end;//TNemesisRes.MarkControlledAsOpen

class procedure TNemesisRes.DropChangeStatusToOpened(const aForm: IvcmEntityForm);
begin
 TUnderControlModule.DropChangeStatusToOpened(aForm);
end;//TNemesisRes.DropChangeStatusToOpened

class procedure TNemesisRes.ViewChangedFragments(const aLeft: IDocument;
 const aRight: IDocument);
begin
 TChangesBetweenEditionsModule.ViewChangedFragments(aLeft, aRight);
end;//TNemesisRes.ViewChangedFragments

class procedure TNemesisRes.ViewChangedFragmentsForPrevEdition(const aDocument: IDocument);
 {* Просмотр изменёных фрагментов в сравнении с предыдущей редакцией }
begin
 TChangesBetweenEditionsModule.ViewChangedFragmentsForPrevEdition(aDocument);
end;//TNemesisRes.ViewChangedFragmentsForPrevEdition

class function TNemesisRes.OpenLegislationReview(const aQuery: IQuery): IvcmEntityForm;
 {* открыть Обзор изменений законодательства }
begin
 Result := TSearchModule.OpenLegislationReview(aQuery);
end;//TNemesisRes.OpenLegislationReview

class function TNemesisRes.OpenFiltersForm(const aData: IdeFilter): IvcmEntityForm;
 {* Открывает форму фильтров }
begin
 Result := TSearchModule.OpenFiltersForm(aData);
end;//TNemesisRes.OpenFiltersForm

class procedure TNemesisRes.MakeNewFilter(aListType: TbsListType);
 {* Вызывает форму создания нового фильтра }
begin
 TSearchModule.MakeNewFilter(aListType);
end;//TNemesisRes.MakeNewFilter

class procedure TNemesisRes.InpharmSearch(const aQuery: IQuery;
 const aList: IDynList;
 const aContainer: IvcmContainer);
 {* Поиск лекарственных средств }
begin
 TSearchModule.InpharmSearch(aQuery, aList, aContainer);
end;//TNemesisRes.InpharmSearch

class procedure TNemesisRes.PublishSourceSearch(const aQuery: IQuery;
 const aList: IDynList);
begin
 TSearchModule.PublishSourceSearch(aQuery, aList);
end;//TNemesisRes.PublishSourceSearch

class function TNemesisRes.DateQuery(const aCaller: IvcmEntityForm;
 const aData: IqaDateReqDataHolder): IvcmEntityForm;
begin
 Result := TSearchModule.DateQuery(aCaller, aData);
end;//TNemesisRes.DateQuery

class procedure TNemesisRes.OpenKeyWord(const aQuery: IQuery;
 const aContainer: IvcmContainer);
 {* открыть ППС }
begin
 TSearchModule.OpenKeyWord(aQuery, aContainer);
end;//TNemesisRes.OpenKeyWord

class procedure TNemesisRes.EditFilter(const aFilter: IdeFilter;
 anItemIndex: Integer);
 {* Редактироваить фильтр }
begin
 TSearchModule.EditFilter(aFilter, anItemIndex);
end;//TNemesisRes.EditFilter

class procedure TNemesisRes.AttributeSearch(const aQuery: IQuery;
 const aList: IDynList;
 const aContainer: IvcmContainer);
begin
 TSearchModule.AttributeSearch(aQuery, aList, aContainer);
end;//TNemesisRes.AttributeSearch

class procedure TNemesisRes.OpenTaxesPublishSearch(const aPublishSearchTag: Il3CString);
 {* СМИ по налогам и бухучёту }
begin
 TSearchModule.OpenTaxesPublishSearch(aPublishSearchTag);
end;//TNemesisRes.OpenTaxesPublishSearch

class procedure TNemesisRes.OpenSituationCard(const aQuery: IQuery);
 {* открыть ППС 6.х }
begin
 TSearchModule.OpenSituationCard(aQuery);
end;//TNemesisRes.OpenSituationCard

class procedure TNemesisRes.OpenOldSituationCard(const aQuery: IQuery;
 const aContainer: IvcmContainer);
 {* открыть ППС 5.х }
begin
 TSearchModule.OpenOldSituationCard(aQuery, aContainer);
end;//TNemesisRes.OpenOldSituationCard

class procedure TNemesisRes.OpenPharmPublishSearch;
begin
 TSearchModule.OpenPharmPublishSearch;
end;//TNemesisRes.OpenPharmPublishSearch

class procedure TNemesisRes.OpenPharmLegislationReview;
begin
 TSearchModule.OpenPharmLegislationReview;
end;//TNemesisRes.OpenPharmLegislationReview

class procedure TNemesisRes.MakeAAC(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* Создаёт сборку для документа ААК }
begin
 TAACPrimModule.MakeAAC(aDocInfo, aContainer);
end;//TNemesisRes.MakeAAC

class procedure TNemesisRes.MakeAACContents(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* Создаёт сборку для документа ОГЛАВЛЕНИЯ ААК }
begin
 TAACPrimModule.MakeAACContents(aDocInfo, aContainer);
end;//TNemesisRes.MakeAACContents

class function TNemesisRes.OpenPostingOrder(const aQuery: IQuery;
 const aContainer: IvcmContainer = nil): IvcmEntityForm;
begin
 Result := TCommonPostModule.OpenPostingOrder(aQuery, aContainer);
end;//TNemesisRes.OpenPostingOrder

class procedure TNemesisRes.SavePostingList;
begin
 TCommonPostModule.SavePostingList;
end;//TNemesisRes.SavePostingList

class procedure TNemesisRes.CheckHistory;
 {* пробуем возвратиться по истории, если активна форма предварительного просмотра }
begin
 TCommonPostModule.CheckHistory;
end;//TNemesisRes.CheckHistory

class function TNemesisRes.StartOpen(const aContainer: IvcmContainer;
 aNewTab: Boolean): IvcmEntityForm;
begin
 Result := TCommonPostModule.StartOpen(aContainer, aNewTab);
end;//TNemesisRes.StartOpen

class procedure TNemesisRes.SavePostList;
 {* Сохранить индивидуальные ленты в файл }
begin
 TCommonPostModule.SavePostList;
end;//TNemesisRes.SavePostList

class function TNemesisRes.CanSavePostList: Boolean;
 {* Можно ли сохранить индивидуальные ленты в файл }
begin
 Result := TCommonPostModule.CanSavePostList;
end;//TNemesisRes.CanSavePostList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
