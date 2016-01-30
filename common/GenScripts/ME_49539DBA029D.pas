unit ExText_Form;
 {* Форма документа, работающая с IdsDocument и другими вариантами контроллеров области ввода }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\ExText_Form.pas"
// Стереотип: "VCMContainer"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Common_Strange_Controls
 , Search_Strange_Controls
 , Document_Strange_Controls
 , Base_Operations_Strange_Controls
 , Document_F1Lite_Controls
 , Base_Operations_Editions_Controls
 , l3TabbedContainersDispatcher
 , DocumentAndListInterfaces
 , DictionInterfacesPrim
 , InpharmInterfaces
 , ConsultationDomainInterfaces
 , L10nInterfaces
 , WorkWithDocumentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
 , bsTypes
 , l3TreeInterfaces
 , DocumentUnit
 , nsTypes
 , AdapterFacade
 , eeInterfaces
 , nevNavigation
 , l3Interfaces
 , Windows
 , l3Variant
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , nevContainers
 , evCustomEditorWindow
 , BaseSearchInterfaces
 , ExternalOperationUnit
 , bsTypesNew
 , NavigationInterfaces
 , DocumentInterfaces
 , Messages
 , afwInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , eeSubPanel
 , vtScrollBar
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , bsInterfaces
 , Base_Operations_F1Specific_Controls
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
 , l3BaseStream
 , k2CustomFileGenerator
 , k2TagGen
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimBaseSearchInterfaces
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , PresentationInterfaces
 , l3Core
 , Base_Operations_View_Controls
 , nevGUIInterfaces
 , afwNavigation
 , nevBase
 , l3LongintList
 , nsFoundBlocksList
 , DocInfoInterfaces
 , UnderControlUnit
 , BaseDocumentWithAttributesInterfaces
 , UnderControlInterfaces
 , Hypertext_Controls_Controls
 , evdTypes
 , l3StringIDEx
 , DocumentUserTypes_dftRelatedDoc_UserType
 , DocumentUserTypes_dftAnnotation_UserType
 , DocumentUserTypes_dftRelatedSynchroView_UserType
 , DocumentUserTypes_dftDictSubEntry_UserType
 , DocumentUserTypes_dftConsultation_UserType
 , DocumentUserTypes_dftTranslation_UserType
 , DocumentUserTypes_dftChronology_UserType
 , DocumentUserTypes_dftAutoreferatAfterSearch_UserType
 , DocumentUserTypes_dftTips_UserType
 , DocumentUserTypes_dftAutoreferat_UserType
 , DocumentUserTypes_dftMedicFirmSynchroView_UserType
 , DocumentUserTypes_dftDrugSynchroView_UserType
 , DocumentUserTypes_dftDocSynchroView_UserType
 , DocumentUserTypes_dftAnnotationSynchroView_UserType
 , DocumentUserTypes_dftNone_UserType
 , DocumentUserTypes_dftDocument_UserType
 , DocumentUserTypes_dftAACLeft_UserType
 , DocumentUserTypes_dftAACRight_UserType
 , DocumentUserTypes_dftAACContentsLeft_UserType
 , DocumentUserTypes_dftAACContentsRight_UserType
 , DocumentUserTypes_dftDrug_UserType
 , DocumentUserTypes_dftDictEntry_UserType
 , DocumentUserTypes_dftMedDictEntry_UserType
 , DocumentUserTypes_dftMedicFirm_UserType
 , evSubWaiter
 , l3ProtoObject
;

const
 {* Локализуемые строки LocalForChangedFragments }
 str_ViewChangesOpName: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ViewChangesOpName'; rValue : 'Обзор изменений документа');
  {* 'Обзор изменений документа' }

type
 IExTextFormState = interface(IvcmBase)
  ['{BE5E5BDA-BD9E-4C35-86E5-EA717CAA2E11}']
  function pm_GetInnerState: IvcmBase;
  function pm_GetNeedShowUserComments: Boolean;
  function Get_eeSubIdForTypedCorrespondentList: Integer;
  function pm_GetNeedShowComments: Boolean;
  function pm_GetNeedShowVersionComments: Boolean;
  property InnerState: IvcmBase
   read pm_GetInnerState;
  property NeedShowUserComments: Boolean
   read pm_GetNeedShowUserComments;
  property eeSubIdForTypedCorrespondentList: Integer
   read Get_eeSubIdForTypedCorrespondentList;
  property NeedShowComments: Boolean
   read pm_GetNeedShowComments;
  property NeedShowVersionComments: Boolean
   read pm_GetNeedShowVersionComments;
 end;//IExTextFormState

 TExTextFormState = class(Tl3ProtoObject, IExTextFormState)
  private
   f_InnerState: IvcmBase;
   f_NeedShowUserComments: Boolean;
   f_eeSubIdForTypedCorrespondentList: Integer;
   f_NeedShowComments: Boolean;
   f_NeedShowVersionComments: Boolean;
  protected
   function pm_GetInnerState: IvcmBase;
   function pm_GetNeedShowUserComments: Boolean;
   function Get_eeSubIdForTypedCorrespondentList: Integer;
   function pm_GetNeedShowComments: Boolean;
   function pm_GetNeedShowVersionComments: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aInnerState: IvcmBase;
    aNeedShowUserComments: Boolean;
    aNeedShowComments: Boolean;
    aNeedShowVersionComments: Boolean;
    aEeSubIdForTypedCorrespondentList: Integer); reintroduce;
   class function Make(const aInnerState: IvcmBase;
    aNeedShowUserComments: Boolean;
    aNeedShowComments: Boolean;
    aNeedShowVersionComments: Boolean;
    aEeSubIdForTypedCorrespondentList: Integer): IExTextFormState; reintroduce;
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; override;
 end;//TExTextFormState

 {$Include SearcheableText.imp.pas}
 _PageControlNotification_Parent_ = _SearcheableText_;
 {$Include PageControlNotification.imp.pas}
 _TurnOnTimeMachine_Parent_ = _PageControlNotification_;
 {$Include TurnOnTimeMachine.imp.pas}
 _TurnOffTimeMachine_Parent_ = _TurnOnTimeMachine_;
 {$Include TurnOffTimeMachine.imp.pas}
 _WorkWithRedactions_Parent_ = _TurnOffTimeMachine_;
 {$Include WorkWithRedactions.imp.pas}
 _DocumentPresentation_Parent_ = _WorkWithRedactions_;
 {$Include DocumentPresentation.imp.pas}
 _HyperlinkProcessor_Parent_ = _DocumentPresentation_;
 {$Include HyperlinkProcessor.imp.pas}
 _TextWithComments_Parent_ = _HyperlinkProcessor_;
 {$Include TextWithComments.imp.pas}
 _DocumentUserTypes_Parent_ = _TextWithComments_;
 {$Include DocumentUserTypes.imp.pas}
 _BlockSelector_Parent_ = _DocumentUserTypes_;
 {$Include BlockSelector.imp.pas}
 _CommonForTextAndFlashOperations_Parent_ = _BlockSelector_;
 {$Include CommonForTextAndFlashOperations.imp.pas}
 _HyperlinkOperations_Parent_ = _CommonForTextAndFlashOperations_;
 {$Include HyperlinkOperations.imp.pas}
 _vcmChromeLikeTabCaptionProvider_Parent_ = _HyperlinkOperations_;
 {$Include vcmChromeLikeTabCaptionProvider.imp.pas}
 _vcmChromeLikeTabIconUpdater_Parent_ = _vcmChromeLikeTabCaptionProvider_;
 {$Include vcmChromeLikeTabIconUpdater.imp.pas}
 TExTextForm = class(_vcmChromeLikeTabIconUpdater_, Il3SelectedTabDependent)
  {* Форма документа, работающая с IdsDocument и другими вариантами контроллеров области ввода }
  private
   f_NeedAnnoingCheck: Boolean;
   f_InGoToInternet: Boolean;
   f_TabCaption: IvcmCString;
   f_DocumentLoaded: Boolean;
   f_eeSubIdForTypedCorrespondentList: Integer;
   {$If Defined(nsTest)}
   f_NeedShowIntranetWarningHack: Boolean;
    {* Поле для свойства NeedShowIntranetWarningHack }
   {$IfEnd} // Defined(nsTest)
  protected
   DocumentWithContents: IucbDocumentWithContents;
   DictionDocument: IdsDictionDocument;
    {* Документ толкового словаря. Может быть nil }
   MedicFirmDocument: IdsMedicFirmDocument;
    {* Документ мед. фирмы. Может быть nil }
   DrugDocument: IdsDrugDocument;
    {* Документ-препарат. Может быть nil }
   Consultation: IsdsConsultation;
   dsConsultation: IdsConsultation;
   f_ControlMap: InsStringValueMap;
   f_LastBookmarkIndex: Integer;
   f_RecallCreateTOCTree: IdeSimpleTree;
   f_HyperlinkCallStatus: Boolean;
   AAC: IsdsAAC;
  private
   procedure DoFindInDict;
   procedure DoFocusViaMouseSet(aSender: TObject);
   procedure TextSourceTOCCreated(aSender: TObject;
    const aTOC: Il3SimpleTree);
   procedure TextSourceMakeDocumentContainer(Sender: TObject;
    var aMade: InevDocumentContainer);
   procedure TextSourceDocumentChanged(aSender: TObject;
    anOldDocument: Tl3Tag;
    aNewDocument: Tl3Tag);
   procedure OnHistoryState(Sender: TObject;
    var IsLast: Boolean);
   procedure GoToIntranetPrim(aNeedCheck: Boolean);
   procedure SetFocusToTextInAAC;
   function GetCorrespondentListTest: Boolean;
   function GetRespondentListTest: Boolean;
   procedure CheckLinkedWindows;
    {* Синхронизирует положения связанных окон }
   procedure DoHyperlinkNavigate(Sender: TObject);
   procedure DoTextZOrderChanging(aSender: TObject;
    var aCanChangeZOrder: Boolean);
   function HasVisibleBookmarks(const aBookmarks: IeeSubList): Boolean;
   procedure ExcludeRootSub(const aParams: IvcmTestParamsPrim);
   function MakePositionListBySub(aSubID: Integer): IPositionList;
   procedure CheckIsDocumentSub(const aParams: IvcmTestParamsPrim);
   function ExtractRangeFromSubPanel(const aParams: IvcmExecuteParams): InevRange;
   function MakeCaption(const aDocument: IDocument;
    aShort: Boolean): Il3CString;
   procedure UpdateDocumentCaption(const aDocument: IDocument);
   procedure OpenDocumentInNewContainer(aOpenKind: TvcmMainFormOpenKind);
  protected
   function CheckParamForUserType(aUserType: Integer): Boolean;
   procedure DisableOperation(const aParams: IvcmTestParamsPrim);
   procedure CRToPartTest(const aParams: IvcmTestParamsPrim;
    aCRType: TlstCRType);
    {* общий обработчик для СКР к части }
   procedure CRToPartExecute(const aParams: IvcmExecuteParamsPrim;
    aCRType: TlstCRType);
    {* общий обработчик для СКР к части }
   procedure TurnOnTimeMachine(const aDate: Il3CString);
    {* включить машину времени на дату }
   procedure OpenContents(aMode: TnsContentsOpenMode);
   function FiltrateTOCTree(const aTOC: Il3SimpleTree;
    NeedFiltrate: Boolean = True): Il3SimpleTree;
   procedure ShowWarningPage(SwitchActivity: Boolean;
    anOffset: TnsWarningSub = DocumentAndListInterfaces.cNoneWarningSub);
   function GetVisibleBookmarksCount(const aBookmarks: IeeSubList): Integer;
   function GetVisibleBookmark(const aBookmarks: IeeSubList;
    anIndex: Integer = 0): IeeSub;
   procedure EditBookmark(anID: Integer); overload;
   function NeedShowIntranetWarning: Boolean;
   procedure GoToIntranet; overload;
   procedure CheckForcedQueryForIntranet;
   procedure RequiestCheckForcedQueryForInternet;
   procedure UpdateSubPanelDescription;
   procedure InvalidateDataSources;
    {* синхронизирует новый источник данных с запомненными источниками данных }
   procedure UpdateTechComment;
   procedure CreateTOC(const aTOC: IdeSimpleTree); virtual; abstract;
   procedure LoadFromSettings;
    {* применить настройки к форме }
   procedure ShowSubNumbers;
   procedure DoSettingsChanged;
    {* вызывается в случае изменения\замены настроек. }
   function GetCurrentCaption: Il3CString;
   function GetCurrentImage: Integer;
   procedure CorrespondentsToSubTest(const aParams: IvcmTestParamsPrim);
   function ExtractSubFromSubPanel(const aTarget: IUnknown): IeeSub;
   procedure OpenPicture(const aPara: IeePara;
    const aPicture: IeePicture;
    aOpenKind: TvcmMainFormOpenKind = vcmInterfaces.vcm_okInCurrentTab);
   function LeafParaUnderCursor: IeePara;
   procedure MakePositionList;
   procedure SetFocusToText;
   function GetNeedsStatusBarItems: Boolean;
   function NeedShowTOC: Boolean;
    {* Нужно ли показывать оглавление }
   function ExtractRangeFromList(const aList: InevFlatSubsList): InevRange;
   function ExtractRangeFromSub(aID: Integer;
    aLayerID: Integer): InevRange;
   function IsPictureUnderCursor: Boolean;
   procedure ChangePositionByDataSource;
    {* изменить позицию в документе на основе информации источника данных }
   function OpenCRList(aKind: TlstCRType;
    const aType: Il3SimpleNode;
    ReConvertNode: Boolean): Boolean;
    {* Открыть список корреспондентов/респондентов }
   procedure TypedCRToPartTest(const aParams: IvcmTestParamsPrim;
    aCRType: TlstCRType);
   procedure GetCorrespondentListEx(aParamsIndex: Integer;
    const aChoosedNode: Il3SimpleNode);
    {* Коллеги, это что? }
   procedure OpenCRListToPart(aCRType: TlstCRType;
    const aType: Il3SimpleNode;
    const aPositionList: IPositionList = nil);
   procedure GetRespondentListEx(aParamsIndex: Integer;
    const aChoosedNode: Il3SimpleNode);
   procedure SynchronizeWithRedationsForm;
   procedure ReloadRedaction(aChangeType: TnsChangeRedactionType;
    aRedaction: TRedactionID = 0); overload; virtual; abstract;
   function ReloadRedaction(const aDate: AdapterDate): Boolean; overload; virtual; abstract;
   procedure SetActualRedaction; virtual; abstract;
   function ExtractRangeFromContents(const aData: IUnknown;
    aUserType: Integer): InevRange; virtual; abstract;
   procedure ExportBlock(const aRange: InevRange;
    ToActiveWindow: Boolean); overload; virtual; abstract;
   procedure SelectBlock(const aRange: InevRange); overload; virtual; abstract;
   procedure CopyBlock(const aRange: InevRange); overload; virtual; abstract;
   procedure PrintBlock(const aRange: InevRange); overload; virtual; abstract;
   procedure PrintDialogBlock(const aRange: InevRange); overload; virtual; abstract;
   procedure PreviewBlock(const aRange: InevRange); overload; virtual; abstract;
   function FindBookmarkInText(const aBookmark: IBookmark;
    out aSub: IeeSub): Boolean; virtual; abstract;
   procedure InitHyperLink(const aHyperLink: IevHyperlink;
    const aBaseEntity: IUnknown); virtual; abstract;
   function EnableRedactionOps(const aParams: IvcmTestParamsPrim): Boolean; virtual; abstract;
   procedure OpenInWindow(aNew: Boolean = True); virtual; abstract;
   procedure DoSwitchToFirstTab;
   procedure OpenRedactionList;
   procedure dftMedicFirmSynchroViewQueryMaximized(aSender: TObject); override;
    {* Обработчик события dftMedicFirmSynchroView.OnQueryMaximized }
   procedure dftTranslationQueryMaximized(aSender: TObject); override;
    {* Обработчик события dftTranslation.OnQueryMaximized }
   procedure DoTabActivate; override;
    {* Реакция на переключение вкладки }
   procedure SetBookmark; override;
    {* Устанавливает закладку на текущее место текущего документа }
   function CanAddBookmark: Boolean; override;
    {* Можно ли сейчас добавлять закладку }
   function DocumentIsValid: Boolean; override;
    {* Есть ли документ, готовый к работе }
   function RedactionCurrentPara: IeeLeafPara; override;
    {* Текущий параграф редакции для синхронизации с окном сравннения редакций }
   function DoProcessExternalOperation(const anOperation: IExternalOperation): Boolean; override;
    {* Обработчик внешней операции }
   procedure GotoPoint(aPointID: Cardinal;
    aPointType: TDocumentPositionType = bsTypesNew.dptSub); override;
    {* Переход на точку в документе }
   procedure OpenRedactionLocalLink(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour); override;
    {* Открывает локальную ссылку на другую редакцию }
   function HyperlinkDocument: IDocument; override;
    {* Документ ИЗ которого ведёт ссылка }
   function pm_GetHyperlinkText: TevCustomEditorWindow; override;
   function CanBeChanged: Boolean; override;
    {* Может ли документ быть изменён }
   function IsFloating: Boolean; override;
    {* Форма плавающая }
   function pm_GetTextWithComments: TevCustomEditorWindow; override;
   function NeedGotoNeighbours: Boolean; override;
    {* Надо ли переходить на соседей блока }
   procedure OpenRedactionGlobalLink(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour); override;
   procedure TabBecomeActive;
   procedure TabBecomeInactive;
   procedure dftDrugSynchroViewQueryOpen(aSender: TObject); override;
    {* Обработчик события dftDrugSynchroView.OnQueryOpen }
   procedure dftDictSubEntryQueryClose(aSender: TObject); override;
    {* Обработчик события dftDictSubEntry.OnQueryClose }
   procedure dftTranslationQueryClose(aSender: TObject); override;
    {* Обработчик события dftTranslation.OnQueryClose }
   procedure dftChronologyQueryClose(aSender: TObject); override;
    {* Обработчик события dftChronology.OnQueryClose }
   procedure dftDrugSynchroViewQueryMaximized(aSender: TObject); override;
    {* Обработчик события dftDrugSynchroView.OnQueryMaximized }
   procedure dftAnnotationQueryClose(aSender: TObject); override;
    {* Обработчик события dftAnnotation.OnQueryClose }
   procedure dftDocSynchroViewQueryMaximized(aSender: TObject); override;
    {* Обработчик события dftDocSynchroView.OnQueryMaximized }
   procedure dftRelatedDocQueryClose(aSender: TObject); override;
    {* Обработчик события dftRelatedDoc.OnQueryClose }
   procedure dftTranslationQueryOpen(aSender: TObject); override;
    {* Обработчик события dftTranslation.OnQueryOpen }
   procedure dftDocSynchroViewQueryOpen(aSender: TObject); override;
    {* Обработчик события dftDocSynchroView.OnQueryOpen }
   procedure dftMedicFirmSynchroViewQueryOpen(aSender: TObject); override;
    {* Обработчик события dftMedicFirmSynchroView.OnQueryOpen }
   {$If NOT Defined(NoVCL)}
   procedure WndProc(var Message: TMessage); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure FinishDataUpdate; override;
   function DoSettingChanged(const aSettingId: TafwSettingId): Boolean; override;
    {* Обработчик изменения указанной настройки }
   procedure SettingsReplaceFinish; override;
   procedure UserSettingsChanged; override;
    {* Изменились настройки пользователя }
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
    {* Сохраняет состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
    {* Загружает состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   function CanAddToControl: Boolean; override;
    {* Можно ли поставить на контроль }
   function DoMakeLinkDocInfo(const aDocument: IDocument;
    aPointType: TDocumentPositionType;
    aSub: Cardinal): IdeDocInfo; override;
   function DoProcessLocalLink(const aDocument: IDocument;
    aPointType: TDocumentPositionType;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; override;
    {* Обработка локальных ссылок }
   function NeedsStatusBarItems: Boolean; override;
    {* Определяет, что операции в статусной строке таки надо публиковать }
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure VersionCommentsVisibleInvertedByUser(NewState: Boolean); override;
   procedure DoDocumentShowTechCommentsExecute; override;
   function pm_GetHyperlinkSubID: Integer; override;
   procedure DoSetHyperlinkCallStatus(aValue: Boolean); override;
    {* Выставляет флаг, определяющий произведенный переход по ссылке }
   {$If NOT Defined(NoVCM)}
   procedure FormInsertedIntoContainer; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure BecomeVisible; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   function GetBehaviourFromEffects(anEffects: TafwJumpToEffects): TbsProcessHyperLinkBehaviour; override;
   function GetDocumentShortName(const aDoc: IDocument;
    aExportSelection: Boolean): Il3CString; override;
   {$If NOT Defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetFormSetTabCaption: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetTabImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetCanDefineFormSetIcon: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   procedure AfterOpenHyperlinkInNewTab; override;
   function GetParaIDForSaveInWorkJournal: Integer; override;
   function NeedSaveInWorkJournal: Boolean; override;
   {$If NOT Defined(NoVCM)}
   function DoGetNeedAddFormToTasksPanel: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure OpenCorrespondentList; override;
    {* Коллеги, это что? }
   procedure OpenRespondentList; override;
    {* Коллеги, это что? }
   procedure GetAttributesFrmAct; override;
    {* Информация о документе }
   function Load: Boolean; override;
    {* Коллеги, кто может описать этот метод? }
   procedure GetRelatedDocFrmAct; override;
    {* Справка к документу }
   procedure GetCorrespondentList; override;
    {* Ссылки на документ }
   procedure GetRespondentList; override;
    {* Ссылки из документа }
   function AttributesCanBeClosed: Boolean; override;
    {* Это кандидат на перенос в Facet или что-то подобное }
   procedure CommonDocumentOpenNewWindow; override;
    {* Что это? }
   procedure TimeMachineStateChange; override;
   procedure RedactionOnID; override;
   function FindExplanation: Boolean; override;
    {* Найти толкование }
   procedure FindInDict; override;
    {* Найти в Толковом словаре }
   function SetPosition: Boolean; override;
   procedure SetActive; override;
   procedure ExportBlock; override;
   function GetCurrentPosition: Integer; override;
   procedure SelectBlock; override;
   procedure CopyBlock; override;
   procedure PrintBlock; override;
   procedure PrintDialogBlock; override;
   procedure PreviewBlock; override;
   procedure ShowRespondentListToPart; override;
   procedure ShowCorrespondentListToPart; override;
   procedure ModifyBookmarkNotify; override;
   procedure AddBookmarkFromContents; override;
   procedure GetCorrespondentListExFrmAct; override;
    {* Ссылки на документ (вид информации) }
   procedure GetRespondentListExFrmAct; override;
    {* Ссылки из документа (вид информации) }
   procedure TimeMachineOnOff; override;
   procedure TimeMachineOffAndReset; override;
   procedure OpenNotSureTopic; override;
   procedure ActualRedaction; override;
   procedure ToggleFoundWords; override;
    {* Подсвечивать найденный контекст }
   function GotoPara: Boolean; override;
   procedure TimeMachineOnOffNew; override;
    {* Включить Машину времени }
   procedure OpenRedactionListFrmAct; override;
    {* Список редакций }
   function GetParaForPositionning: IeeLeafPara; override;
   procedure GetCorrespondentList; override;
   procedure GetRespondentList; override;
   procedure GetTypedCorrespondentList; override;
   procedure GetTypedRespondentList; override;
   procedure GetAnnotationDocFrmAct; override;
   procedure SimilarDocuments; override;
   procedure UserCR1; override;
   procedure UserCR2; override;
   procedure GetTypedCorrespondentList; override;
   procedure PrevRedaction; override;
   procedure NextRedaction; override;
   procedure AddToControl; override;
   procedure ShowCorrespondentListToPart; override;
   procedure ShowRespondentListToPart; override;
   procedure ClearStatusSettings; override;
    {* Способ сброса статуса "изменен" }
   procedure TimeMachineOnOff; override;
   procedure AddBookmark; override;
   procedure ToMSWord; override;
   procedure Print; override;
   procedure PrintDialog; override;
   procedure AddBookmark; override;
    {* Установить закладку на фрагмент }
   procedure ToMSWord; override;
   procedure PrintDialog; override;
   procedure Copy; override;
   procedure Print; override;
   procedure OpenContentsFrmAct; override;
   procedure ShowDocumentPicture; override;
   procedure Open; override;
   procedure Save; override;
   procedure OpenActualRedaction; override;
   procedure ShowInfo; override;
   procedure TimeMachineOnOffNew; override;
   procedure ShowInfo; override;
   procedure ShowChanges; override;
    {* Показать изменения }
   procedure ClearStatus; override;
    {* Сбросить статус "изменен" }
   procedure Delete; override;
   procedure Edit; override;
   procedure Delete; override;
   procedure HideShow; override;
   procedure Delete; override;
   procedure AddUserComment; override;
   procedure GetGraphicImage; override;
   procedure DocumentSynchroOpenWindow; override;
   procedure DocumentSynchroOpenNewWindow; override;
   procedure DictListOpenFrmAct; override;
   procedure GotoBookmark; override;
   procedure LiteratureListForDictionary; override;
   procedure EditBookmark; override;
   procedure DeleteBookmark; override;
   procedure AddBookmark; override;
   procedure OpenNewWindow; override;
   procedure OpenProducedDrugList; override;
   procedure OpenSimilarDrugList; override;
   procedure InsertHyperlink; override;
    {* Поставить ссылку... }
   procedure GetAttributesFrmAct; override;
    {* Информация о документе }
   procedure OpenContentsFrmAct; override;
    {* Структура документа }
   procedure TimeMachineOnOffNew; override;
    {* Включить Машину времени }
   procedure HideShow; override;
    {* Скрыть/Показать }
   procedure TimeMachineOnOff; override;
    {* Включить Машину времени с календарной даты\Выключить Машину времени }
   procedure ShowInfo; override;
    {* Показать текст предупреждения }
   procedure ShowInfo; override;
    {* Показать текст предупреждения }
   procedure TimeMachineOnOffNew; override;
    {* Включить/Выключить Машину времени }
   procedure ShowInfo; override;
    {* Показать текст предупреждения }
   procedure GetTypedCorrespondentList; override;
    {* Ссылки на фрагмент (вид информации) }
   procedure UserCR1; override;
    {* Пользовательские ссылки на документ (ссылки из документа) 1 }
   procedure UserCR2; override;
    {* Пользовательские ссылки на документ (ссылки из документа) 2 }
   procedure AddToControl; override;
    {* Поставить на контроль }
   procedure PrintPreview; override;
   procedure Select; override;
   procedure ViewChangedFragments; override;
    {* Обзор изменений документа }
   procedure UpdateSubPanel; override;
   procedure OpenRedactionListFrmAct; override;
    {* Список редакций }
   procedure GoToIntranet; override;
   procedure Open; override;
    {* Открыть в текущем окне }
   procedure OpenNewWindow; override;
    {* Открыть в новом окне }
   function GetBaseSearchPresentation: InsBaseSearchPresentation; override;
   procedure SelectWord; override;
   procedure SelectPara; override;
   procedure OpenNewTab; override;
    {* Открыть в новой вкладке }
   procedure CommonDocumentOpenNewTab; override;
   procedure GetSimilarDocsToBlock; override;
   {$If NOT Defined(NoVCM)}
   procedure Copy; override;
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SetPositionByDS; override;
    {* Вызывается когда нужно изменить позицию используя источник данных. [$136258455] }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Paste; override;
    {* Вставка }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function NeedDrawCaption: Boolean; override;
    {* Нужно ли рисовать заголовок зоны }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoGetTabInfo(out theCaption: Il3CString;
    out theItemIndex: Integer): Boolean; override;
    {* Информация о закладке, в которую вставляется форма. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function NeedSetMyFocus: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure NotifyUserTypeSet; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function GetIsMainObjectForm: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If Defined(nsTest)}
   property NeedShowIntranetWarningHack: Boolean
    read f_NeedShowIntranetWarningHack
    write f_NeedShowIntranetWarningHack;
    {* Хак для эмуляции включения МГО медали }
   {$IfEnd} // Defined(nsTest)
 end;//TExTextForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , ConsultingUnit
 , DataAdapter
 {$If NOT Defined(NoVCM)}
 , vcmGUI
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmForm
 {$IfEnd} // NOT Defined(NoVCM)
 , nsConst
 , nsExternalObjectPrim
 , nsValueMaps
 , nsValueMapsIDs
 , bsChangeRedationWorker
 , eeEditorExport
 , l3Bits
 , l3Chars
 , l3String
 , evTypes
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , BaseTreeSupportUnit
 , FoldersUnit
 , BaseTypesUnit
 , nsDocumentTools
 {$If Defined(Nemesis)}
 , eePara
 {$IfEnd} // Defined(Nemesis)
 , eeInterfacesEx
 {$If Defined(Nemesis)}
 , eeParaTools
 {$IfEnd} // Defined(Nemesis)
 , F1Like_InternalOperations_Controls
 , nsSwitchVersionCommentsEvent
 , nsTextTabActivateEvent
 , nsUseDocumentSubPanelOperationEvent
 {$If NOT Defined(NoVCM)}
 , vcmUtils
 {$IfEnd} // NOT Defined(NoVCM)
 , StartUnit
 , evCustomEditor
 , FoldersDomainInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , deSimpleTree
 , F1TagDataProviderInterface
 , Graphics
 , WarningConst
 , ControlStatusUtils
 , resWarnImages
 , bsDocumentMissingMessage
 , bsUtils
 , nsInternalPictureData
 , BitmapPara_Const
 , Base_Operations_AAC_Controls
 , AACTextContainerPrim_Form
 , k2Const
 , evEditorWithOperations
 , eeEditor
 , nevRangeList
 , nevRangeListTools
 , evMultiSelectionBlock
 {$If NOT Defined(NoVGScene)}
 , vgRemindersLineManager
 {$IfEnd} // NOT Defined(NoVGScene)
 , nsTabbedInterfaceTypes
 , nscDocumentHistory
 , evSubPn
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , nsTrialSupport
 , bsDocumentContextSearcher
 , afwFacade
 , Printers
 , l3Stream
 , l3Base
 , l3Types
 , Classes
 , SysUtils
 , nsUtils
 , nsToMSWordOp
 , afwSettingsChangePublisher
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , nsExportToFileEvent
 , nsExportToWordEvent
 , nsSendDocumentByEMailEvent
 , nsDocumentPrintPreviewEvent
 , nsBaseTextOperationsConst
 , f1MultilinkResolver
 , nsQuestions
 , nsExternalObjectModelPart
 , nsSearchInDocumentEvent
 , nsSearchInDocumentDoneEvent
 , nsSearchInDocumentNextEvent
 , nsSearchInDocumentPrevEvent
 , nsSearchWindowManager
 , l3InterfacesMisc
 , nsBaseSearchService
 , nsManagers
 , LoggingUnit
 , bsConvert
 , nsTimeMachineOffEvent
 , nsHyperLinkProcessor
 , deDocInfo
 , nsOpenUtils
 , nsTabbedContainerUtils
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , nsHyperlinkProcessorTypes
 , DynamicTreeUnit
 , ExternalObjectUnit
 , nsDocumentFromListNavigationEvent
 {$If Defined(Nemesis)}
 , nscStatusBarItemDef
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscStatusBarOperationDef
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscStatusBarDelimiterDef
 {$IfEnd} // Defined(Nemesis)
 , DocumentUtil
 , Common_FormDefinitions_Controls
 , evConstStringData
 , evdHyperlinkInfo
 , nsHyperlinkToDocumentProducerConst
 , Block_Const
 , k2Tags
 , evSubImplementation
 , Document_Const
 , nsFolders
 , nsTagNodeTools
 , ParaList_Const
 , LeafPara_Const
 , LeafParaDecorationsHolder_Const
 , CommentPara_Const
;

type
 // ExcludeForChildDocuments

 // ExcludeSaveToFolder

 // ExcludeInpharmSynchro

 // ExcludeLoadFromFolder

 // ExcludeEditOperations

 // ExcludeForConsultation

 // ExcludeFindContextForInpharm

 // IncludeForLegalDocumentPrim

 // IncludeForLegalDocument

 // ExcludeUserCommentIconHideShow

 // IncludeForLegalDocumentAndDrug

 // ExcludeRedactionOnID

 // ExcludeGetAttributesFrmAct

 // ExcludeComments

 // ExcludeShowUserComments

 // ExcludeBookmarkIcon

 // ExcludeUserCommentIconDelete

 // IncludeForLegalDocumentAndDrugs

 // IncludeGetGraphicImage

 // ExcludeInsertHyperlink

 // IncludeDocumentSynchroOpen

 // IncludeDictListOpenFrmAct

 // ExcludeGotoBookmark

 // IncludeAddBookmarkFromContents

 // ExcludeAddBookmark

 // IncludeLiteratureListForDictionary

 // ExcludeShowCommentsGroup

 // ExcludeCompareEditions

 // ExcludeBookmarkOperations

 // ExcludeOpenNewWindow

 // IncludeOpenProducedDrugList

 // IncludeOpenSimilarDrugList

 // ExcludeForAACContents

 // BaseSearchPresentationForAACLeft

 TnsDocumentPointWaiter = class(TevSubWaiter)
  {* Класс для ожидания перехода на указанную точку документа }
  private
   f_Pos: TbsDocPos;
   f_Form: TExTextForm;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function TrySelectPara(const aContainer: InevDocumentContainer;
    const aSel: InevSelection;
    aParaID: Integer): Boolean; override;
  public
   constructor Create(aForm: TExTextForm;
    const aPos: TbsDocPos); reintroduce;
   class function Make(aForm: TExTextForm;
    const aPos: TbsDocPos): InevWaiter; reintroduce;
 end;//TnsDocumentPointWaiter

constructor TnsDocumentPointWaiter.Create(aForm: TExTextForm;
 const aPos: TbsDocPos);
//#UC START# *4C0669610060_4C066918002D_var*
//#UC END# *4C0669610060_4C066918002D_var*
begin
//#UC START# *4C0669610060_4C066918002D_impl*
 inherited Create(aForm.Text, aPos.rPos, DocPosTypeToEdtSubType(aPos.rRefType));
 f_Pos := aPos;
 f_Form := aForm;
//#UC END# *4C0669610060_4C066918002D_impl*
end;//TnsDocumentPointWaiter.Create

class function TnsDocumentPointWaiter.Make(aForm: TExTextForm;
 const aPos: TbsDocPos): InevWaiter;
var
 l_Inst : TnsDocumentPointWaiter;
begin
 l_Inst := Create(aForm, aPos);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsDocumentPointWaiter.Make

procedure TnsDocumentPointWaiter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4C066918002D_var*
//#UC END# *479731C50290_4C066918002D_var*
begin
//#UC START# *479731C50290_4C066918002D_impl*
 Finalize(f_Pos);
 f_Form := nil;
 inherited;
//#UC END# *479731C50290_4C066918002D_impl*
end;//TnsDocumentPointWaiter.Cleanup

function TnsDocumentPointWaiter.TrySelectPara(const aContainer: InevDocumentContainer;
 const aSel: InevSelection;
 aParaID: Integer): Boolean;
//#UC START# *4BFFA0FF01D2_4C066918002D_var*
var
 l_Para      : InevPara;
 l_View      : InevView;
 l_Block     : Tl3Variant;
 l_Doc       : Tl3Variant;
 l_Part      : IevDocumentPart;
 l_Obj       : InevObject;
 l_Fmt       : TnevFormatInfoPrim;
 l_Addr      : TevAddress;
 l_BlockObj  : InevObject;
 l_SubHandle : Integer;
//#UC END# *4BFFA0FF01D2_4C066918002D_var*
begin
//#UC START# *4BFFA0FF01D2_4C066918002D_impl*
 Result := inherited TrySelectPara(aContainer, aSel, aParaID);
 try
  if not Result then
  begin
   //http://mdp.garant.ru/pages/viewpage.action?pageId=420416039
   if ((f_Form.Text.AACLike = nev_aacLeft) and ((f_Pos.rRefType <> dptPara)
    or ((f_Pos.rRefType = dptSub) and (f_Pos.rPos <> 0)))) then
   begin
    f_Form.Text.Try2GoByHyperlinkUnderCursor;
    Exit;
   end // if Text.AACLike = nev_aacLeft then
   else
   // "Обратная синхронизация" - находим и выделяем ссылку в левой части
   // на открываемый в правой части документа
   // http://mdp.garant.ru/pages/viewpage.action?pageId=420416039
   if ((f_Form.Text.AACLike = nev_aacLeft) and (f_Pos.rRefType = dptPara)) and
      f_Form.AAC.Right.HasDoc then
   begin
    // Поищем параграф в правой части
    if f_Form.AAC.Right.Container.FindObjByID(f_Pos.rPos, l_Obj) then
    try
     if Supports(l_Obj, InevPara, l_Para) then
     try
      l_SubHandle := l_Para.AsObject.rAtomEx([k2_tiSubs, k2_tiChildren, k2_tiHandle, Ord(ev_sbtSub),
       k2_tiChildren, k2_tiByIndex, 0]).IntA[k2_tiHandle];
      if (l_SubHandle <= 0) then
       if evInPara(l_Para.AsObject, k2_typBlock, l_Block) then
       begin
        l_SubHandle := l_Block.IntA[k2_tiHandle];
        l_Block.BoolA[k2_tiCollapsed] := False;
       end; // if evInPara(l_Para.AsObject, k2_typBlock, l_Block) then
      if (l_SubHandle > 0) then
      begin
       l_Addr := TevAddress_C(-1, l_SubHandle);
       if (f_Form.Text.SearchHyperLinkAddress(true, true, l_Addr)) then
        Exit;
      end;//if (l_SubHandle > 0) then
     finally
      l_Para := nil;
     end;//try..finally
    finally
     l_Obj := nil;
    end;//try..finally
   end;// if ((f_Form.Text.AACLike = nev_aacLeft) and (f_Pos.rRefType = dptPara))
   if (f_Pos.rPara <> nil) then
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=217157085
   begin
    Result := true;
    // - будем оптимистами
    if f_Form.GotoSub(f_Pos.rPara) then
     Exit;
    if (f_Pos.rPara <> nil) then
     begin
      if f_Pos.rPara.AsObject.QT(InevPara, l_Para) then
       try
        if evInPara(l_Para.AsObject, k2_typBlock, l_Block) AND
           (l_Block.IntA[k2_tiLayerID] = Ord(ev_sbtSub)) then
        begin
         if evInPara(l_Block.AsObject, k2_typDocument, l_Doc) then
         begin
          l_Part := TevDocumentPartImplementation.Make(l_Doc,
                                                       nil,
                                                       l_Block.IntA[k2_tiHandle],
                                                       l_Block.IntA[k2_tiLayerID]);
          try
           if f_Form.GotoBlock(l_Part) then
            Exit;
          finally
           l_Part := nil;
          end;//try..finally
         end;//evInPara(l_Block, k2_typDocument, l_Doc)
        end;//evInPara(l_Para, k2_typBlock, l_Block)
       finally
        l_Para := nil;
       end;//f_Pos.rPara <> nil
     end;//try..finally
    Result := false;
   end;//f_Pos.rPara <> nil
  end;//not Result
 finally
  if Result then
  // - здесь надо будет раскрыть комментарии, если параграфа не видно
  // http://mdp.garant.ru/pages/viewpage.action?pageId=236718088
  begin
   if (f_Form <> nil) then
   begin
    with f_Form.Text do
    begin
     if TextSource.DocumentContainer.FindObjByID(aParaID, l_Obj) then
     begin
      if (l_Obj <> nil) then
      begin
       l_Fmt := View.FormatInfoByPara(l_Obj);
       if (l_Fmt <> nil) AND l_Fmt.IsHidden(true, true) then
       begin
        if not l_Obj.AsObject.QT(InevPara, l_Para) then
         Assert(false);
        if l_Para.IsLegalComment then
        begin
         if l_Para.IsComment then
          ShowComments := True
         else
         begin
          {$IfDef evNeedCollapsedVersionComments}
          View.IsObjectCollapsed[l_Para] := false;
          {$Else evNeedCollapsedVersionComments}
          ShowVersionComments := True;
          {$EndIf evNeedCollapsedVersionComments}
         end;//l_Para.IsComment
         InevSelection(Selection).SelectPoint(l_Para.MakePoint, true);
        end;//l_Para.IsLegalComment
       end;//l_Obj.IsHidden(aView.Metrics, aView.FormatInfoByPara(l_Obj), true)
      end;//l_Obj <> nil
     end;//TextSource.DocumentContainer.FindObjByID(aParaID, l_Obj)
    end;//with f_Form.Text
   end;//f_Form <> nil
  end;//Result
 end;//try..finally
//#UC END# *4BFFA0FF01D2_4C066918002D_impl*
end;//TnsDocumentPointWaiter.TrySelectPara

constructor TExTextFormState.Create(const aInnerState: IvcmBase;
 aNeedShowUserComments: Boolean;
 aNeedShowComments: Boolean;
 aNeedShowVersionComments: Boolean;
 aEeSubIdForTypedCorrespondentList: Integer);
//#UC START# *56558B510110_56558AAF003B_var*
//#UC END# *56558B510110_56558AAF003B_var*
begin
//#UC START# *56558B510110_56558AAF003B_impl*
 inherited Create;
 f_InnerState := aInnerState;
 f_NeedShowUserComments := aNeedShowUserComments;
 f_NeedShowComments := aNeedShowComments;
 f_NeedShowVersionComments := aNeedShowVersionComments;
 f_eeSubIdForTypedCorrespondentList := aEeSubIdForTypedCorrespondentList;
//#UC END# *56558B510110_56558AAF003B_impl*
end;//TExTextFormState.Create

class function TExTextFormState.Make(const aInnerState: IvcmBase;
 aNeedShowUserComments: Boolean;
 aNeedShowComments: Boolean;
 aNeedShowVersionComments: Boolean;
 aEeSubIdForTypedCorrespondentList: Integer): IExTextFormState;
var
 l_Inst : TExTextFormState;
begin
 l_Inst := Create(aInnerState, aNeedShowUserComments, aNeedShowComments, aNeedShowVersionComments, aEeSubIdForTypedCorrespondentList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TExTextFormState.Make

function TExTextFormState.pm_GetInnerState: IvcmBase;
//#UC START# *56558A84014E_56558AAF003Bget_var*
//#UC END# *56558A84014E_56558AAF003Bget_var*
begin
//#UC START# *56558A84014E_56558AAF003Bget_impl*
 Result := f_InnerState;
//#UC END# *56558A84014E_56558AAF003Bget_impl*
end;//TExTextFormState.pm_GetInnerState

function TExTextFormState.pm_GetNeedShowUserComments: Boolean;
//#UC START# *56558A99000A_56558AAF003Bget_var*
//#UC END# *56558A99000A_56558AAF003Bget_var*
begin
//#UC START# *56558A99000A_56558AAF003Bget_impl*
 Result := f_NeedShowUserComments;
//#UC END# *56558A99000A_56558AAF003Bget_impl*
end;//TExTextFormState.pm_GetNeedShowUserComments

function TExTextFormState.Get_eeSubIdForTypedCorrespondentList: Integer;
//#UC START# *5656B27E015A_56558AAF003Bget_var*
//#UC END# *5656B27E015A_56558AAF003Bget_var*
begin
//#UC START# *5656B27E015A_56558AAF003Bget_impl*
 Result := f_eeSubIdForTypedCorrespondentList;
//#UC END# *5656B27E015A_56558AAF003Bget_impl*
end;//TExTextFormState.Get_eeSubIdForTypedCorrespondentList

function TExTextFormState.pm_GetNeedShowComments: Boolean;
//#UC START# *565C49D7029F_56558AAF003Bget_var*
//#UC END# *565C49D7029F_56558AAF003Bget_var*
begin
//#UC START# *565C49D7029F_56558AAF003Bget_impl*
 Result := f_NeedShowComments;
//#UC END# *565C49D7029F_56558AAF003Bget_impl*
end;//TExTextFormState.pm_GetNeedShowComments

function TExTextFormState.pm_GetNeedShowVersionComments: Boolean;
//#UC START# *565C49E9039D_56558AAF003Bget_var*
//#UC END# *565C49E9039D_56558AAF003Bget_var*
begin
//#UC START# *565C49E9039D_56558AAF003Bget_impl*
 Result := f_NeedShowVersionComments;
//#UC END# *565C49E9039D_56558AAF003Bget_impl*
end;//TExTextFormState.pm_GetNeedShowVersionComments

procedure TExTextFormState.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56558AAF003B_var*
//#UC END# *479731C50290_56558AAF003B_var*
begin
//#UC START# *479731C50290_56558AAF003B_impl*
 f_InnerState := nil;
 inherited;
//#UC END# *479731C50290_56558AAF003B_impl*
end;//TExTextFormState.Cleanup

function TExTextFormState.QueryInterface(const IID: TGUID;
 out Obj): HResult;
//#UC START# *561145D802BB_56558AAF003B_var*
//#UC END# *561145D802BB_56558AAF003B_var*
begin
//#UC START# *561145D802BB_56558AAF003B_impl*
 // Всё это криво и костыльно. И ужасно. И очень не хотелось так делать.
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=612730339
 if (not IsEqualGUID(IID, IExTextFormState)) and (f_InnerState <> nil) then
  Result := f_InnerState.QueryInterface(IID, Obj)
 else
  Result := inherited QueryInterface(IID, Obj);
//#UC END# *561145D802BB_56558AAF003B_impl*
end;//TExTextFormState.QueryInterface

type _Instance_R_ = TExTextForm;

{$Include SearcheableText.imp.pas}

{$Include PageControlNotification.imp.pas}

{$Include TurnOnTimeMachine.imp.pas}

{$Include TurnOffTimeMachine.imp.pas}

{$Include WorkWithRedactions.imp.pas}

{$Include DocumentPresentation.imp.pas}

{$Include HyperlinkProcessor.imp.pas}

{$Include TextWithComments.imp.pas}

{$Include DocumentUserTypes.imp.pas}

{$Include BlockSelector.imp.pas}

{$Include CommonForTextAndFlashOperations.imp.pas}

{$Include HyperlinkOperations.imp.pas}

{$Include vcmChromeLikeTabCaptionProvider.imp.pas}

{$Include vcmChromeLikeTabIconUpdater.imp.pas}

function TExTextForm.CheckParamForUserType(aUserType: Integer): Boolean;
//#UC START# *4A8EEFED022C_49539DBA029D_var*
//#UC END# *4A8EEFED022C_49539DBA029D_var*
begin
//#UC START# *4A8EEFED022C_49539DBA029D_impl*
 if (aUserType = dftNone) then
  Result := true
 else
 begin
  // А нужны ли в этой проверке первые две строки?
  // Ну вторая-то точно не нужна...
  Result := (UserType <> dftNone) and
            (aUserType <> dftNone) and
            ((UserType = aUserType) or
             ((UserType in [dftAACLeft]) and
              (aUserType = dftDocument)
             )
            );
 end;
//#UC END# *4A8EEFED022C_49539DBA029D_impl*
end;//TExTextForm.CheckParamForUserType

procedure TExTextForm.DisableOperation(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3AED97022A_49539DBA029D_var*
//#UC END# *4C3AED97022A_49539DBA029D_var*
begin
//#UC START# *4C3AED97022A_49539DBA029D_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C3AED97022A_49539DBA029D_impl*
end;//TExTextForm.DisableOperation

procedure TExTextForm.CRToPartTest(const aParams: IvcmTestParamsPrim;
 aCRType: TlstCRType);
 {* общий обработчик для СКР к части }
//#UC START# *4C3B036300C4_49539DBA029D_var*
var
 l_Strings : IvcmStrings;
 l_List    : IvcmNodes;
//#UC END# *4C3B036300C4_49539DBA029D_var*
begin
//#UC START# *4C3B036300C4_49539DBA029D_impl*
 with aParams do
 begin
  if (ZoneType = vcm_ztChild) or (UserType in [dftAACRight, dftAACContentsRight]) then
   Op.Flag[vcm_ofEnabled] := False
  else
   aParams.Op.Flag[vcm_ofEnabled] := Assigned(Document) and
                                     Text.HasSelection;
  if Op.Flag[vcm_ofEnabled] and
     Assigned(dsDocument) and
     Assigned(dsDocument.DocInfo) then
  begin
   with DocumentSet do
    case aCRType of
     crtCorrespondents:
      Op.Flag[vcm_ofEnabled] := HasCorrespondents;
     crtRespondents:
      Op.Flag[vcm_ofEnabled] := HasRespondents;
    end;//case aCRType of
   l_Strings := Op.SubItems;
   if Assigned(l_Strings) then
   try
    l_Strings.Clear;
    l_List := Op.SubNodes;
    if (l_List.Count = 0) then
     l_List.Add(DefDataAdapter.CRSimpleListTypeRootNode);
   finally
    l_Strings := nil;
   end;//try..finally
  end;//if Op.Flag[vcm_ofVisible]
 end;//with aParams do
//#UC END# *4C3B036300C4_49539DBA029D_impl*
end;//TExTextForm.CRToPartTest

procedure TExTextForm.CRToPartExecute(const aParams: IvcmExecuteParamsPrim;
 aCRType: TlstCRType);
 {* общий обработчик для СКР к части }
//#UC START# *4C3B0399027D_49539DBA029D_var*
//#UC END# *4C3B0399027D_49539DBA029D_var*
begin
//#UC START# *4C3B0399027D_49539DBA029D_impl*
 if (UserType = dftDocument) then
  OpenCRListToPart(aCRType, aParams.CurrentNode);
//#UC END# *4C3B0399027D_49539DBA029D_impl*
end;//TExTextForm.CRToPartExecute

procedure TExTextForm.TurnOnTimeMachine(const aDate: Il3CString);
 {* включить машину времени на дату }
//#UC START# *4C3B040002CA_49539DBA029D_var*
var
 l_Date: BaseTypesUnit.TDate;
//#UC END# *4C3B040002CA_49539DBA029D_var*
begin
//#UC START# *4C3B040002CA_49539DBA029D_impl*
 // При щелчке в компонент даты вызывается обработчик операции
 // (TControl.Click), отслеживаем эту ситуацию:
 if l3Same(aDate, DefDataAdapter.TimeMachine.DateStr) then
  Exit;
 // Получение редакции по дате
 try
  DecodeDate(nsStrToDate(aDate),
             l_Date.rYear, l_Date.rMonth, l_Date.rDay);
 except
  on EConvertError do
  begin
   if not l3CharSetPresent(aDate, cc_Digits) then
    TimeMachineOnOff(True);
   Exit;
  end;//on EConvertError
 end;//try..except
 nsTimeMachineOn(Document, l_Date);
//#UC END# *4C3B040002CA_49539DBA029D_impl*
end;//TExTextForm.TurnOnTimeMachine

procedure TExTextForm.OpenContents(aMode: TnsContentsOpenMode);
//#UC START# *4C3B3D3A0254_49539DBA029D_var*
var
 l_ST : Il3SimpleTree;
 l_SimpleTree : IdeSimpleTree;
 l_Adornments : InsDocumentAdornments;
//#UC END# *4C3B3D3A0254_49539DBA029D_var*
begin
//#UC START# *4C3B3D3A0254_49539DBA029D_impl*
 // На InClose проверяем, потому, что форме, которая находится в состоянии
 // отложенного удаления продолжают идти сообщения и она инициирует обновление
 // сборки, в результате создадутся формы, что не правильно. Возможно это будет
 // перенесено на механизм сборок и обновление не будет осуществлено на уровне
 // vcmFormSetFactory:
 if not (Self.as_IvcmEntityForm).InClose and (DocumentWithContents <> nil) then
 begin
  l_ST := FiltrateTOCTree(Text.TextSource.ContentsTree);
  try
   if (l_ST <> nil) then
    if (l_ST.CountView = 0) then
     l_ST := nil;
   Supports(Text.TextSource.DocumentContainer, InsDocumentAdornments, l_Adornments);
   try
    l_SimpleTree := TdeSimpleTree.Make(l_ST, l_Adornments);
    try
     if not l_SimpleTree.Empty then
      DocumentWithContents.OpenContents(l_SimpleTree, aMode, Text.TextSource.DocumentContainer);
    finally
     l_SimpleTree := nil;
    end;//try..finally
   finally
    l_Adornments := nil;
   end;//try..finally
  finally
   l_ST := nil;
  end;//try..finally
 end;//not (Self.as_IvcmEntityForm).InClose and (DocumentWithContents <> nil)
//#UC END# *4C3B3D3A0254_49539DBA029D_impl*
end;//TExTextForm.OpenContents

function TExTextForm.FiltrateTOCTree(const aTOC: Il3SimpleTree;
 NeedFiltrate: Boolean = True): Il3SimpleTree;
//#UC START# *4C3B3E270109_49539DBA029D_var*
(*var
 l_FilterableTree: Il3FilterableTree;
 l_Dummy: Integer;*)
//#UC END# *4C3B3E270109_49539DBA029D_var*
begin
//#UC START# *4C3B3E270109_49539DBA029D_impl*
{ if NeedFiltrate and Supports(aTOC, Il3FilterableTree, l_FilterableTree) then
  Result := l_FilterableTree.MakeFiltered(l_FilterableTree.CloneFilters, nil, l_Dummy)
 else}
  Result := aTOC;
//#UC END# *4C3B3E270109_49539DBA029D_impl*
end;//TExTextForm.FiltrateTOCTree

procedure TExTextForm.ShowWarningPage(SwitchActivity: Boolean;
 anOffset: TnsWarningSub = DocumentAndListInterfaces.cNoneWarningSub);
//#UC START# *4C3B4CCF0068_49539DBA029D_var*

 function lp_NeedOpen: Boolean;
 begin
  if FormIsMainInDocumentSet and Assigned(dsDocument) then
  begin
   if SwitchActivity then
    Result := not Op_Warning_SwitchActive.Call(Aggregate, anOffset)
   else
    Result := not Op_Warning_BecomeActive.Call(Aggregate, anOffset);
   // http://mdp.garant.ru/pages/viewpage.action?pageId=260447845&focusedCommentId=271192159#comment-271192159
   // - поскольку тут зовётся АГРЕГАЦИЯ, то наверное поэтому и не работает,
   //   когда живой вкладки нету в сборке. 
  end//FormIsMainInDocumentSet and Assigned(dsDocument)
  else
   Result := false;
 end;//lp_NeedOpen

//#UC END# *4C3B4CCF0068_49539DBA029D_var*
begin
//#UC START# *4C3B4CCF0068_49539DBA029D_impl*
 if (DocumentSet <> nil) AND lp_NeedOpen then
  DocumentSet.OpenWarning;
//#UC END# *4C3B4CCF0068_49539DBA029D_impl*
end;//TExTextForm.ShowWarningPage

function TExTextForm.GetVisibleBookmarksCount(const aBookmarks: IeeSubList): Integer;
//#UC START# *4C3EC2DE00A4_49539DBA029D_var*
var
 I: Integer;
//#UC END# *4C3EC2DE00A4_49539DBA029D_var*
begin
//#UC START# *4C3EC2DE00A4_49539DBA029D_impl*
 Result := 0;
 if Assigned(aBookmarks) then
  for I := 0 to Pred(aBookmarks.Count) do
   if aBookmarks.Subs[I].Flags and ev_sfOwn = ev_sfOwn then
    Inc(Result);
//#UC END# *4C3EC2DE00A4_49539DBA029D_impl*
end;//TExTextForm.GetVisibleBookmarksCount

function TExTextForm.GetVisibleBookmark(const aBookmarks: IeeSubList;
 anIndex: Integer = 0): IeeSub;
//#UC START# *4C3EC308025F_49539DBA029D_var*
var
 CurIndex,
 I: Integer;
//#UC END# *4C3EC308025F_49539DBA029D_var*
begin
//#UC START# *4C3EC308025F_49539DBA029D_impl*
 Result := nil;
 CurIndex := 0;
 if Assigned(aBookmarks) then
  for I := 0 to Pred(aBookmarks.Count) do
   if aBookmarks.Subs[I].Flags and ev_sfOwn = ev_sfOwn then
   begin
    if CurIndex = anIndex then
    begin
     Result := aBookmarks.Subs[I];
     break;
    end;
    Inc(CurIndex);
   end;
//#UC END# *4C3EC308025F_49539DBA029D_impl*
end;//TExTextForm.GetVisibleBookmark

procedure TExTextForm.EditBookmark(anID: Integer);
//#UC START# *4C3EC3570265_49539DBA029D_var*
var
 l_FoldersNode : IFoldersNode;
 l_Entity      : IvcmEntity;
//#UC END# *4C3EC3570265_49539DBA029D_var*
begin
//#UC START# *4C3EC3570265_49539DBA029D_impl*
 if nsFindBookmarkForEditInFolders(anID, l_FoldersNode, l_Entity, true, Text.TextSource.DocumentContainer) then
  try
   Op_FoldersControl_EditElement.Call(l_Entity, l_FoldersNode);
  finally
   l_Entity := nil;
   l_FoldersNode := nil;
  end//try..finally
 else
  Say(war_EditMissingBookmark);
//#UC END# *4C3EC3570265_49539DBA029D_impl*
end;//TExTextForm.EditBookmark

function TExTextForm.NeedShowIntranetWarning: Boolean;
//#UC START# *4C40039C03CD_49539DBA029D_var*
//#UC END# *4C40039C03CD_49539DBA029D_var*
begin
//#UC START# *4C40039C03CD_49539DBA029D_impl*
 {$IfDef nsTest}
 if NeedShowIntranetWarningHack then
  Result := Assigned(Document)
 else
 {$EndIf nsTest}
  Result := defDataAdapter.RevisionCheckEnabled and
            Assigned(Document) and
            {Document.GetNewRevisionAvailable}
            (Document.GetChangeStatus <> 0)
            ;
//#UC END# *4C40039C03CD_49539DBA029D_impl*
end;//TExTextForm.NeedShowIntranetWarning

procedure TExTextForm.GoToIntranet;
//#UC START# *4C4003D00232_49539DBA029D_var*
//#UC END# *4C4003D00232_49539DBA029D_var*
begin
//#UC START# *4C4003D00232_49539DBA029D_impl*
 f_InGoToInternet := True;
 try
  f_NeedAnnoingCheck := False; // http://mdp.garant.ru/pages/viewpage.action?pageId=352453000
  Case MessageDlg(str_InActualDocumentAction,
                  [BsControlStatusHint(Document.GetChangeStatus, true)]) of
   -1:
    GoToIntranetPrim(true);
   -2, mrCancel : // mrCancel - для обработки закрытия окна (по Esc)
    // - ничего не делаем
    ;
   else
    Assert(false);
  end;//Case MessageDlg(str_InActualDocumentAction..
 finally
  f_InGoToInternet := False;
 end;
//#UC END# *4C4003D00232_49539DBA029D_impl*
end;//TExTextForm.GoToIntranet

procedure TExTextForm.CheckForcedQueryForIntranet;
//#UC START# *4C40042A0193_49539DBA029D_var*
//#UC END# *4C40042A0193_49539DBA029D_var*
begin
//#UC START# *4C40042A0193_49539DBA029D_impl*
 {$IfDef nsTest}
 if not NeedShowIntranetWarningHack then
 {$EndIf nsTest}
  if f_NeedAnnoingCheck and NeedShowIntranetWarning then
  begin
   f_NeedAnnoingCheck := False;
   PostMessage(Handle, g_GoToIntranetMessage, 0, 0);
  end;//f_NeedAnnoingCheck and NeedShowIntranetWarning
//#UC END# *4C40042A0193_49539DBA029D_impl*
end;//TExTextForm.CheckForcedQueryForIntranet

procedure TExTextForm.DoFindInDict;
//#UC START# *4C80FB6E0249_49539DBA029D_var*

 function DeleteEndlines(const S: Il3CString): Il3CString;
 begin//DeleteEndlines
  Result := S;
  l3Replace(Result, [#$D], cc_HardSpace);
  l3DeleteChars(Result, [#$A]);
 end;//DeleteEndlines

var
 l_Str : Il3CString;
 l_Range: InevRange;
 l_Pt: InevBasePoint;
//#UC END# *4C80FB6E0249_49539DBA029D_var*
begin
//#UC START# *4C80FB6E0249_49539DBA029D_impl*
 if (ViewArea <> nil) AND defDataAdapter.IsExplanatoryExists then
 begin
  if (Text.HasSelection) then
   l_Range := InevSelection(Text.Selection).GetBlock
  else
  begin
   l_Pt := Text.Selection.Cursor.ClonePoint(Text.View);
   l_Range := l_Pt.Obj.Range;
   l_Range.Select(Text.View, l_Pt, ev_stWord);
  end;
  if not l_Range.Collapsed(Text.View) then
   l_Str := DeleteEndlines(l3Trim(evAsString(l_Range.Data)))
  else
   l_Str := nil;
  TdmStdRes.OpenTermByContext(l_Str, ViewArea.Language);
 end;//ViewArea <> nil
//#UC END# *4C80FB6E0249_49539DBA029D_impl*
end;//TExTextForm.DoFindInDict

procedure TExTextForm.RequiestCheckForcedQueryForInternet;
//#UC START# *4C931477005F_49539DBA029D_var*
//#UC END# *4C931477005F_49539DBA029D_var*
begin
//#UC START# *4C931477005F_49539DBA029D_impl*
 f_NeedAnnoingCheck := not f_InGoToInternet and
                       afw.Application.Settings.LoadBoolean(pi_Document_ForceAskForIntranet,
                                                            dv_Document_ForceAskForIntranet);
//#UC END# *4C931477005F_49539DBA029D_impl*
end;//TExTextForm.RequiestCheckForcedQueryForInternet

procedure TExTextForm.UpdateSubPanelDescription;
//#UC START# *4DF1F81F02DE_49539DBA029D_var*
var
 l_Document : IDocument;
 l_SubDescriptors : TevSubDescriptors;
//#UC END# *4DF1F81F02DE_49539DBA029D_var*
begin
//#UC START# *4DF1F81F02DE_49539DBA029D_impl*
 if (UserType in [dftDocument, dftDrug, dftAACLeft]) then
  l_SubDescriptors := nsDocumentRes.SubDescriptors
 else
  l_SubDescriptors := nsDocumentRes.LiteSubDescriptors;
 l_Document := Document;
 with Settings, l_SubDescriptors{SubPanel.SubDescriptors} do
 begin
  SubsLayer.Flag5.Visible := (UserType = dftDocument) and
    LoadBoolean(pi_Document_SubPanel_ShowBlocks,
                dv_Document_SubPanel_ShowBlocks) and
    ((l_Document = nil) or (l_Document.GetDocType <> DT_BOOK));
  if (l_SubDescriptors = nsDocumentRes.LiteSubDescriptors) then
  begin
   BookmarksLayer.Flag2.Visible := false;
   MarksLayer.Flag0.Visible := not Text.ShowComments or
                               LoadBoolean(pi_Document_SubPanel_ShowJurorComments,
                                           dv_Document_SubPanel_ShowJurorComments);
   MarksLayer.Flag1.Visible := Op_Contents_HasUserComments.Call(Aggregate) AND
                               (not Text.ShowUserComments or
                               LoadBoolean(pi_Document_SubPanel_ShowUserComments,
                                           dv_Document_SubPanel_ShowUserComments));
   MarksLayer.Flag2.Visible := false;
   SubsLayer.Visible := LoadBoolean(pi_Document_SubPanel_ShowSubNumbers,
                                    dv_Document_SubPanel_ShowSubNumbers);
  end//l_SubDescriptors = nsDocumentRes.LiteSubDescriptors
  else
  begin
   BookmarksLayer.Flag2.Visible := Op_Contents_HasBookmarks.Call(Aggregate) AND
                                   LoadBoolean(pi_Document_SubPanel_ShowBookmarks,
                                               dv_Document_SubPanel_ShowBookmarks);
   MarksLayer.Flag0.Visible := (not Text.ShowComments or
                               LoadBoolean(pi_Document_SubPanel_ShowJurorComments,
                                           dv_Document_SubPanel_ShowJurorComments));
   MarksLayer.Flag1.Visible := Op_Contents_HasUserComments.Call(Aggregate) AND
                               (not Text.ShowUserComments or
                               LoadBoolean(pi_Document_SubPanel_ShowUserComments,
                                           dv_Document_SubPanel_ShowUserComments));
   MarksLayer.Flag2.Visible := {false}not Text.ShowVersionComments or
                                      LoadBoolean(pi_Document_SubPanel_ShowVersionComments,
                                                  dv_Document_SubPanel_ShowVersionComments);
   SubsLayer.Visible := LoadBoolean(pi_Document_SubPanel_ShowSubNumbers,
                                    dv_Document_SubPanel_ShowSubNumbers);
  end;//l_SubDescriptors = nsDocumentRes.LiteSubDescriptors
 end;//with Settings
 if (SubPanel.SubDescriptors <> l_SubDescriptors) then
  SubPanel.SubDescriptors := l_SubDescriptors;
 SubPanel.Visible := not (UserType in [dftAACRight,
                                       dftAACContentsLeft,
                                       dftAACContentsRight]);
//#UC END# *4DF1F81F02DE_49539DBA029D_impl*
end;//TExTextForm.UpdateSubPanelDescription

procedure TExTextForm.DoFocusViaMouseSet(aSender: TObject);
//#UC START# *4E7B48CB02C1_49539DBA029D_var*
//#UC END# *4E7B48CB02C1_49539DBA029D_var*
begin
//#UC START# *4E7B48CB02C1_49539DBA029D_impl*
 if Op_Contents_IsContentsVisible.Call(Aggregate) then
  Op_Contents_ToggleContentsVisibility.Call(Aggregate);
//#UC END# *4E7B48CB02C1_49539DBA029D_impl*
end;//TExTextForm.DoFocusViaMouseSet

procedure TExTextForm.InvalidateDataSources;
 {* синхронизирует новый источник данных с запомненными источниками данных }
//#UC START# *4EBA9E0201FC_49539DBA029D_var*
//#UC END# *4EBA9E0201FC_49539DBA029D_var*
begin
//#UC START# *4EBA9E0201FC_49539DBA029D_impl*
 if FormDataChangedInfo.NeedProcess then
 begin
  FormDataChangedInfo.NeedProcess := False;
   // - замок закрываем в начале, чтобы дальше можно было обращатся к контейнеру
   //   документа, это необходимо если вызов идет из MakeDocumentContainer;
  if (ViewArea <> nil) then
  begin
   //Assert(false, 'А попадаем ли мы сюда? И зачем мы это делаем?');
   // - попадаем :-(
   // Выключим машину времени:
   if ViewArea.TimeMachineOff then
    DefDataAdapter.TimeMachine.SwitchOff;
   if FormDataChangedInfo.FromHistory then
   begin
    with Text.TextSource do
     // Если документы разные, то переприсваиваем Контейнер:
     if not Assigned(DocumentContainer) or
        not DocumentContainer.IsSame(ViewArea.Container) then
      DocumentContainer := ViewArea.Container;
   end
   else//FormDataChangedInfo.FromHistory
   begin
    with Text do
    begin
     ShowUserComments := True;
     ShowComments := True;
     ShowVersionComments := Settings.LoadBoolean(pi_Document_ShowVersionsComment, dv_Document_ShowVersionsComment);
    end;//with Text
    ChangePositionByDataSource;
   end;//FormDataChangedInfo.FromHistory
   Text.IsStaticText := ViewArea.IsReadOnly;
   Text.PreviewCaleeArea := ViewArea.PreviewCaleeArea;
   CheckControllableState([dcsExitFromSystem]);
   // Название для консультации:
   if (dsConsultation <> nil) then
    CCaption := dsConsultation.DisplayName;
   // Этот код учитывает ситуацию, когда в историю записаны только формы c
   // изменившимися _DataSource (при переходе по редакциям, см. также
   // sfsOnlyIfDataSourceChanged), потому когда будем читать из истории нужно
   // дополнительно сделать синхронизацию по текущей редакции:
   if FormDataChangedInfo.FromHistory then
    SynchronizeWithRedationsForm;
   UpdateSubPanelDescription;
   RequiestCheckForcedQueryForInternet;
  end;//if (ViewArea <> nil) then
 end;//if FormDataChangedInfo.NeedProcess then
 if Assigned(f_RecallCreateTOCTree) then
  CreateTOC(f_RecallCreateTOCTree);
//#UC END# *4EBA9E0201FC_49539DBA029D_impl*
end;//TExTextForm.InvalidateDataSources

procedure TExTextForm.UpdateTechComment;
//#UC START# *4EBA9FDE0189_49539DBA029D_var*
//#UC END# *4EBA9FDE0189_49539DBA029D_var*
begin
//#UC START# *4EBA9FDE0189_49539DBA029D_impl*
 Text.ShowTechComments := afw.Application.IsInternal and
                          Settings.LoadBoolean(pi_Document_ShowTechComment,
                                               dv_Document_ShowTechComment);
//#UC END# *4EBA9FDE0189_49539DBA029D_impl*
end;//TExTextForm.UpdateTechComment

procedure TExTextForm.LoadFromSettings;
 {* применить настройки к форме }
//#UC START# *4EBAAEB20259_49539DBA029D_var*
//#UC END# *4EBAAEB20259_49539DBA029D_var*
begin
//#UC START# *4EBAAEB20259_49539DBA029D_impl*
 with Settings do
 begin
  Text.PersistentSelection :=
   LoadBoolean(pi_Document_PermanentSelection, dv_Document_PermanentSelection);
  with Text do
  begin
   ShowDocumentParts := LoadBoolean(pi_Document_ShowBlockBorders,
                                    dv_Document_ShowBlockBorders);
   DrawSpecial := LoadBoolean(pi_Document_ShowSpecial,
                              dv_Document_ShowSpecial);
  end;//with Text do
 end;//with Settings do
 UpdateSubPanelDescription;
 UpdateTechComment;
//#UC END# *4EBAAEB20259_49539DBA029D_impl*
end;//TExTextForm.LoadFromSettings

procedure TExTextForm.ShowSubNumbers;
//#UC START# *4EBAAF2F03D6_49539DBA029D_var*
//#UC END# *4EBAAF2F03D6_49539DBA029D_var*
begin
//#UC START# *4EBAAF2F03D6_49539DBA029D_impl*
 with Settings do
  SaveBoolean(pi_Document_SubPanel_ShowSubNumbers,
              not LoadBoolean(pi_Document_SubPanel_ShowSubNumbers,
                              dv_Document_SubPanel_ShowSubNumbers),
              dv_Document_SubPanel_ShowSubNumbers);
//#UC END# *4EBAAF2F03D6_49539DBA029D_impl*
end;//TExTextForm.ShowSubNumbers

procedure TExTextForm.TextSourceTOCCreated(aSender: TObject;
 const aTOC: Il3SimpleTree);
//#UC START# *4EBAB1080234_49539DBA029D_var*
var
 l_Adornments : InsDocumentAdornments;
//#UC END# *4EBAB1080234_49539DBA029D_var*
begin
//#UC START# *4EBAB1080234_49539DBA029D_impl*
 Supports(Text.TextSource.DocumentContainer, InsDocumentAdornments, l_Adornments);
 try
  CreateTOC(TdeSimpleTree.Make(aTOC, l_Adornments));
 finally
  l_Adornments := nil;
 end;//try..finally
 TdmStdRes.CheckBaseSearchDataReady(NativeMainForm);
//#UC END# *4EBAB1080234_49539DBA029D_impl*
end;//TExTextForm.TextSourceTOCCreated

procedure TExTextForm.TextSourceMakeDocumentContainer(Sender: TObject;
 var aMade: InevDocumentContainer);
//#UC START# *4EBAB3C4024F_49539DBA029D_var*
var
 l_Container : InevDocumentContainer;
//#UC END# *4EBAB3C4024F_49539DBA029D_var*
begin
//#UC START# *4EBAB3C4024F_49539DBA029D_impl*
 if (ViewArea <> nil) then
 begin
  l_Container := ViewArea.Container;
  if (l_Container <> nil) then
  begin
   aMade := l_Container;
   InvalidateDataSources;
   f_DocumentLoaded := True;
  end;//if l_Container <> nil then
 end;//ViewArea <> nil
//#UC END# *4EBAB3C4024F_49539DBA029D_impl*
end;//TExTextForm.TextSourceMakeDocumentContainer

procedure TExTextForm.TextSourceDocumentChanged(aSender: TObject;
 anOldDocument: Tl3Tag;
 aNewDocument: Tl3Tag);
//#UC START# *4EBAB40900C2_49539DBA029D_var*

 function GetDocumentName(const aDocument: IDocument): Il3CString;
 begin
  Result := nsGetDocumentName(aDocument);
 end;

var
 l_Document: IDocument;
 l_DocName: IvcmCString;
//#UC END# *4EBAB40900C2_49539DBA029D_var*
begin
//#UC START# *4EBAB40900C2_49539DBA029D_impl*
 TvgRemindersLineManager.ClosePopupForms;

 TdmStdRes.CheckBaseSearchDataReady(NativeMainForm);
 if (aNewDocument <> nil) and
    l3IOk(aNewDocument.Owner.QueryInterface(IDocument, l_Document)) then
 begin
  UpdateDocumentCaption(l_Document);
  if not (l_Document.GetDocType in [DT_AUTO_REFERAT]) then
   TnscDocumentHistory.Instance.AddDocument(l_Document.GetInternalId);
  if (UserType in [dftAACLeft, dftAACContentsRight]) then
  begin
   l_DocName := MakeCaption(l_Document, False);
   Container.SetTabCaption(l_DocName);
   CCaption := l_DocName;
   TvcmEntityForm(Container.AsForm.VCLWinControl).CCaption := CCaption;
  end;

  if (UserType in [dftAutoreferat, dftAutoreferatAfterSearch, dftAACLeft, dftAACContentsRight]) then
   Dispatcher.UpdateStatus;

  LoadFromSettings;
  ContextChanged(nil);
  CheckLinkedWindows;
 end;//aNewDocument <> nil..
//#UC END# *4EBAB40900C2_49539DBA029D_impl*
end;//TExTextForm.TextSourceDocumentChanged

procedure TExTextForm.OnHistoryState(Sender: TObject;
 var IsLast: Boolean);
//#UC START# *4EBAB68B0050_49539DBA029D_var*
//#UC END# *4EBAB68B0050_49539DBA029D_var*
begin
//#UC START# *4EBAB68B0050_49539DBA029D_impl*
 if (Dispatcher.History <> nil) then
  IsLast := Dispatcher.History.IsLast;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=565841783
//#UC END# *4EBAB68B0050_49539DBA029D_impl*
end;//TExTextForm.OnHistoryState

procedure TExTextForm.DoSettingsChanged;
 {* вызывается в случае изменения\замены настроек. }
//#UC START# *4EBABF090101_49539DBA029D_var*
//#UC END# *4EBABF090101_49539DBA029D_var*
begin
//#UC START# *4EBABF090101_49539DBA029D_impl*
 // Нужно обновить дерево "Структура документа", оно может понадобиться при
 // обновлении, если пользователь поставит галочку показать структуру документа:
 if (UserType in [dftDocument, dftDrug]) then
  OpenContents(ns_comNotForce);
 LoadFromSettings;
//#UC END# *4EBABF090101_49539DBA029D_impl*
end;//TExTextForm.DoSettingsChanged

function TExTextForm.GetCurrentCaption: Il3CString;
//#UC START# *4EBABF3902F7_49539DBA029D_var*
//#UC END# *4EBABF3902F7_49539DBA029D_var*
begin
//#UC START# *4EBABF3902F7_49539DBA029D_impl*
 if (UserType in [dftDictEntry, dftDictSubEntry]) and
   (ViewArea <> nil) then
  Result := bsLanguageCaption(ViewArea.Language)
 else
  Result := nsCStr(CurUserType.Caption);
//#UC END# *4EBABF3902F7_49539DBA029D_impl*
end;//TExTextForm.GetCurrentCaption

function TExTextForm.GetCurrentImage: Integer;
//#UC START# *4EBABF5503AA_49539DBA029D_var*
//#UC END# *4EBABF5503AA_49539DBA029D_var*
begin
//#UC START# *4EBABF5503AA_49539DBA029D_impl*
 if not (UserType in [dftDictEntry, dftDictSubEntry]) then
  Result := CurUserType.ImageIndex
 else
 if (ViewArea <> nil) and Assigned(ViewArea.DocInfo) then
  Result := bsLanguageImage(ViewArea.DocInfo.Language)
 else
  Result := -1;
//#UC END# *4EBABF5503AA_49539DBA029D_impl*
end;//TExTextForm.GetCurrentImage

procedure TExTextForm.CorrespondentsToSubTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4EDF70F902E1_49539DBA029D_var*
var
 l_Root : Il3SimpleNode;
 l_Child : Il3SimpleNode;
 l_Sub: IeeSub;
//#UC END# *4EDF70F902E1_49539DBA029D_var*
begin
//#UC START# *4EDF70F902E1_49539DBA029D_impl*
 with aParams do
 begin
  if (ZoneType = vcm_ztChild) then
   Op.Flag[vcm_ofEnabled] := False
  else
   aParams.Op.Flag[vcm_ofEnabled] := Assigned(Document);
  if Op.Flag[vcm_ofEnabled] and
     Assigned(dsDocument) then
  begin
   l_Sub := ExtractSubFromSubPanel(aParams.Target);
   if Assigned(l_Sub) then
   begin
    l_Root := nsGetFilteredCorrespondentsTypeTree(Text.Document.DocumentContainer.SubList.SubEx[l_Sub.ID, l_Sub.LayerID]);
    if Assigned(l_Root) then
    begin
     if (Op.SubItems <> nil) then
      Op.SubItems.Clear;
     Op.SubNodes.Clear;
     l_Child := l_Root.Child;
     while (l_Child <> nil) do
     begin
      Op.SubNodes.Add(l_Child);
      if l_Child.IsLast then
       break;
      l_Child := l_Child.Next; 
     end;//l_Child <> nil
     Op.SubNodes.ShowRoot := true; 
    end//Assigned(l_Root)
    else
     aParams.Op.Flag[vcm_ofEnabled] := False;
   end//Assigned(l_Sub)
   else
    aParams.Op.Flag[vcm_ofEnabled] := False;
  end//Op.Flag[vcm_ofEnabled]..
  else
   aParams.Op.Flag[vcm_ofEnabled] := False;
 end;//with aParams do
//#UC END# *4EDF70F902E1_49539DBA029D_impl*
end;//TExTextForm.CorrespondentsToSubTest

function TExTextForm.ExtractSubFromSubPanel(const aTarget: IUnknown): IeeSub;
//#UC START# *4EDF72CC0158_49539DBA029D_var*
var
 l_eeSub: IeeSub;
//#UC END# *4EDF72CC0158_49539DBA029D_var*
begin
//#UC START# *4EDF72CC0158_49539DBA029D_impl*
 if Supports(aTarget, IeeSub, l_eeSub) and
    (l_eeSub.LayerID = Ord(ev_sbtSub)) then
  Result := l_eeSub
 else
  Result := nil;
//#UC END# *4EDF72CC0158_49539DBA029D_impl*
end;//TExTextForm.ExtractSubFromSubPanel

procedure TExTextForm.GoToIntranetPrim(aNeedCheck: Boolean);
//#UC START# *4F184AD903C9_49539DBA029D_var*
var
 l_Para: IeePara;
 l_ParaID: LongWord;
//#UC END# *4F184AD903C9_49539DBA029D_var*
begin
//#UC START# *4F184AD903C9_49539DBA029D_impl*
 l_Para := GetTopParaID;
 if Assigned(l_Para) then
  l_Para := eeFindNumberedPara(l_Para, Text as IeeDocumentEx);
 if Assigned(l_Para) then
  l_ParaID := l_Para.ID
 else
  l_ParaID := 0;
 DefDataAdapter.OpenIntranetDocument(Document.GetInternalId, l_ParaID, aNeedCheck);
//#UC END# *4F184AD903C9_49539DBA029D_impl*
end;//TExTextForm.GoToIntranetPrim

procedure TExTextForm.OpenPicture(const aPara: IeePara;
 const aPicture: IeePicture;
 aOpenKind: TvcmMainFormOpenKind = vcmInterfaces.vcm_okInCurrentTab);
//#UC START# *4F6719C001DB_49539DBA029D_var*
var
 l_Cont  : IvcmContainer;
//#UC END# *4F6719C001DB_49539DBA029D_var*
begin
//#UC START# *4F6719C001DB_49539DBA029D_impl*
 if (aPicture <> nil) then
 begin
  l_Cont := nsOpenNewWindowTabbed(NativeMainForm, aOpenKind);
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=530839714
  TdmStdRes.OpenPicture(l_Cont,
                        TnsInternalPictureData.Make(aPara,
                                                    aPicture,
                                                    nsGetDocumentShortName(Document)));
 end;//aPicture <> nil
//#UC END# *4F6719C001DB_49539DBA029D_impl*
end;//TExTextForm.OpenPicture

function TExTextForm.LeafParaUnderCursor: IeePara;
//#UC START# *4F672B0E03A8_49539DBA029D_var*
//#UC END# *4F672B0E03A8_49539DBA029D_var*
begin
//#UC START# *4F672B0E03A8_49539DBA029D_impl*
 if (Text.Selection <> nil) AND
    (Text.Selection.Cursor <> nil) then
  Result := TeePara.Make(Text.Selection.Cursor.MostInner.Obj.AsPara.AsObject, Text)
 else
  Result := nil; 
//#UC END# *4F672B0E03A8_49539DBA029D_impl*
end;//TExTextForm.LeafParaUnderCursor

procedure TExTextForm.MakePositionList;
//#UC START# *4F97FB9C0324_49539DBA029D_var*
var
 l_Block: InevRange;
//#UC END# *4F97FB9C0324_49539DBA029D_var*
begin
//#UC START# *4F97FB9C0324_49539DBA029D_impl*
 l_Block := InevSelection(Text.Selection).GetBlock;
 try
  if (l_Block = nil) OR
      l_Block.Solid(Text.View) then // - выделен целый документ
   Result := nil
  else
  begin
   Result := defDataAdapter.NativeAdapter.MakePositionList;
   CollectParas(l_Block);
  end;//l_Block = nil..
 finally
  l_Block := nil;
 end;//try..finally
//#UC END# *4F97FB9C0324_49539DBA029D_impl*
end;//TExTextForm.MakePositionList

procedure TExTextForm.SetFocusToText;
//#UC START# *4FF437680128_49539DBA029D_var*
//#UC END# *4FF437680128_49539DBA029D_var*
begin
//#UC START# *4FF437680128_49539DBA029D_impl*
 if Text.CanFocus then
  Text.SetFocus;
//#UC END# *4FF437680128_49539DBA029D_impl*
end;//TExTextForm.SetFocusToText

procedure TExTextForm.SetFocusToTextInAAC;
//#UC START# *4FF4378900EB_49539DBA029D_var*
//#UC END# *4FF4378900EB_49539DBA029D_var*
begin
//#UC START# *4FF4378900EB_49539DBA029D_impl*
 if (UserType = dftAACLeft) OR (UserType = dftAACContentsLeft) then
  SetFocusToText;
//#UC END# *4FF4378900EB_49539DBA029D_impl*
end;//TExTextForm.SetFocusToTextInAAC

function TExTextForm.GetNeedsStatusBarItems: Boolean;
//#UC START# *501013340168_49539DBA029D_var*
//#UC END# *501013340168_49539DBA029D_var*
begin
//#UC START# *501013340168_49539DBA029D_impl*
 Result := UserType in [dftDocument, dftDrug, dftAACLeft, dftAACContentsRight];
//#UC END# *501013340168_49539DBA029D_impl*
end;//TExTextForm.GetNeedsStatusBarItems

function TExTextForm.GetCorrespondentListTest: Boolean;
//#UC START# *50111C6102B7_49539DBA029D_var*
//#UC END# *50111C6102B7_49539DBA029D_var*
begin
//#UC START# *50111C6102B7_49539DBA029D_impl*
//  if (ZoneType = vcm_ztChild) then
//  begin
//   Result := False;
//   Exit;
//  end;    отключается через ExcludeUserType http://mdp.garant.ru/pages/viewpage.action?pageId=379233069&focusedCommentId=379249025#comment-379249025
 Result := False;
 if Assigned(dsDocument) then
  if DocumentIsValid then
   Result := DocumentSet.HasCorrespondents;
//#UC END# *50111C6102B7_49539DBA029D_impl*
end;//TExTextForm.GetCorrespondentListTest

function TExTextForm.GetRespondentListTest: Boolean;
//#UC START# *50111CAC03B5_49539DBA029D_var*
//#UC END# *50111CAC03B5_49539DBA029D_var*
begin
//#UC START# *50111CAC03B5_49539DBA029D_impl*
//  if (ZoneType = vcm_ztChild) then
//  begin
//   Result := False;
//   Exit;
//  end;         отключается через ExcludeUserType http://mdp.garant.ru/pages/viewpage.action?pageId=379233069&focusedCommentId=379249025#comment-379249025
 Result := False;
 if Assigned(dsDocument) then
  if DocumentIsValid then
   Result := DocumentSet.HasRespondents;
//#UC END# *50111CAC03B5_49539DBA029D_impl*
end;//TExTextForm.GetRespondentListTest

function TExTextForm.NeedShowTOC: Boolean;
 {* Нужно ли показывать оглавление }
//#UC START# *502B835801B4_49539DBA029D_var*
//#UC END# *502B835801B4_49539DBA029D_var*
begin
//#UC START# *502B835801B4_49539DBA029D_impl*
 Result := (UserType in [dftDocument, dftDrug, dftAACLeft, dftAACContentsRight]);
//#UC END# *502B835801B4_49539DBA029D_impl*
end;//TExTextForm.NeedShowTOC

procedure TExTextForm.CheckLinkedWindows;
 {* Синхронизирует положения связанных окон }
//#UC START# *502D3AFC0282_49539DBA029D_var*
var
 l_Addr : TevAddress;
//#UC END# *502D3AFC0282_49539DBA029D_var*
begin
//#UC START# *502D3AFC0282_49539DBA029D_impl*
 if (UserType = dftAACContentsLeft) then
  if Assigned(dsDocument) and
     Assigned(dsDocument.DocInfo) then
  begin
   if (dsDocument.DocInfo.Pos.rRefType = dptSub) then
   begin
    //if not Dispatcher.History.InBF then
    begin
     l_Addr := TevAddress_C(0, dsDocument.DocInfo.Pos.rPos);
     if not Text.SearchHyperLinkAddress(true, true, l_Addr) then
      if (Text.Selection <> nil) then
       //if Text.Selection.Collapsed then
       if Dispatcher.History.InBF then
       begin
        Text.GotoTop;
        //Text.NextHyperlink;
       end;//Dispatcher.History.InBF
     end;//not Dispatcher.History.InBF
   end;//dsDocument.DocInfo.Pos.rRefType = dptSub
  end;//Assigned(dsDocument)
//#UC END# *502D3AFC0282_49539DBA029D_impl*
end;//TExTextForm.CheckLinkedWindows

procedure TExTextForm.DoHyperlinkNavigate(Sender: TObject);
//#UC START# *502D43D50306_49539DBA029D_var*
//#UC END# *502D43D50306_49539DBA029D_var*
begin
//#UC START# *502D43D50306_49539DBA029D_impl*
 if (UserType = dftAACContentsLeft) then
  if (dsDocument <> nil) then
   if not Dispatcher.History.InBF then
    if (Text <> nil) AND Text.HasDocument then
    begin
     Text.OnHyperlinkNavigate := nil;
     try
      Self.OpenHyperlink;
     finally
      Text.OnHyperlinkNavigate := Self.DoHyperlinkNavigate;
     end;//try..finally
    end;//Text <> nil
//#UC END# *502D43D50306_49539DBA029D_impl*
end;//TExTextForm.DoHyperlinkNavigate

procedure TExTextForm.DoTextZOrderChanging(aSender: TObject;
 var aCanChangeZOrder: Boolean);
//#UC START# *527CB40000BD_49539DBA029D_var*
//#UC END# *527CB40000BD_49539DBA029D_var*
begin
//#UC START# *527CB40000BD_49539DBA029D_impl*
 // Костыль: Не даем редактору поменять Z-order если над ним есть медали
 // http://mdp.garant.ru/pages/viewpage.action?pageId=488604061
{ aCanChangeZOrder := ((csLoading in ComponentState) or (csDestroying in ComponentState)) OR
  ((aSender is TControl) and VtFindRemindersOverControl(TControl(aSender))); }
//#UC END# *527CB40000BD_49539DBA029D_impl*
end;//TExTextForm.DoTextZOrderChanging

function TExTextForm.HasVisibleBookmarks(const aBookmarks: IeeSubList): Boolean;
//#UC START# *52876E7B02BC_49539DBA029D_var*
var
 I: Integer;
//#UC END# *52876E7B02BC_49539DBA029D_var*
begin
//#UC START# *52876E7B02BC_49539DBA029D_impl*
 Result := False;
 if Assigned(aBookmarks) then
  for I := 0 to Pred(aBookmarks.Count) do
   if aBookmarks.Subs[I].Flags and ev_sfOwn = ev_sfOwn then
   begin
    Result := True;
    Break;
   end;
//#UC END# *52876E7B02BC_49539DBA029D_impl*
end;//TExTextForm.HasVisibleBookmarks

procedure TExTextForm.ExcludeRootSub(const aParams: IvcmTestParamsPrim);
//#UC START# *5287A5D4007D_49539DBA029D_var*
var
 l_Sub: IeeSub;
//#UC END# *5287A5D4007D_49539DBA029D_var*
begin
//#UC START# *5287A5D4007D_49539DBA029D_impl*
 l_Sub := ExtractSubFromSubPanel(aParams.Target);
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(l_Sub) and (l_Sub.ID <> c_DocumentSubID);
//#UC END# *5287A5D4007D_49539DBA029D_impl*
end;//TExTextForm.ExcludeRootSub

function TExTextForm.MakePositionListBySub(aSubID: Integer): IPositionList;
//#UC START# *5287A6130217_49539DBA029D_var*
var
 l_Pos: DocumentUnit.TPosition;
//#UC END# *5287A6130217_49539DBA029D_var*
begin
//#UC START# *5287A6130217_49539DBA029D_impl*
 Result := defDataAdapter.NativeAdapter.MakePositionList;
 with l_Pos do
 begin
  rType := PT_SUB;
  rPoint := aSubID;
 end;
 Result.Add(l_Pos);
//#UC END# *5287A6130217_49539DBA029D_impl*
end;//TExTextForm.MakePositionListBySub

procedure TExTextForm.CheckIsDocumentSub(const aParams: IvcmTestParamsPrim);
//#UC START# *5287A65300FD_49539DBA029D_var*
var
 l_Sub: IeeSub;
//#UC END# *5287A65300FD_49539DBA029D_var*
begin
//#UC START# *5287A65300FD_49539DBA029D_impl*
 l_Sub := ExtractSubFromSubPanel(aParams.Target);
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(l_Sub) and (l_Sub.ID = c_DocumentSubID)
//#UC END# *5287A65300FD_49539DBA029D_impl*
end;//TExTextForm.CheckIsDocumentSub

function TExTextForm.ExtractRangeFromSubPanel(const aParams: IvcmExecuteParams): InevRange;
//#UC START# *5287A6D60096_49539DBA029D_var*
var
 l_Sub: IeeSub;
//#UC END# *5287A6D60096_49539DBA029D_var*
begin
//#UC START# *5287A6D60096_49539DBA029D_impl*
 l_Sub := ExtractSubFromSubPanel(aParams.Target);
 if Assigned(l_Sub) then
  Result := ExtractRangeFromSub(l_Sub.ID, l_Sub.LayerID)
 else
  Result := nil;
//#UC END# *5287A6D60096_49539DBA029D_impl*
end;//TExTextForm.ExtractRangeFromSubPanel

function TExTextForm.ExtractRangeFromList(const aList: InevFlatSubsList): InevRange;
//#UC START# *4F85B66E0260_49539DBA029D_var*
var
 l_Range: InevRange;
 l_Ranges: TnevRangeList;
 l_IDX: Integer;
//#UC END# *4F85B66E0260_49539DBA029D_var*
begin
//#UC START# *4F85B66E0260_49539DBA029D_impl*
 if (aList.Count = 1) then
  with aList.First do
   Result := ExtractRangeFromSub(ID, LayerID)
 else
 begin
  l_Ranges := TnevRangeList.Make;
  try
   for l_IDX := 0 to aList.Count - 1 do
   begin
    l_Range := ExtractRangeFromSub(aList.Items[l_IDX].ID, aList.Items[l_IDX].LayerID);
    if l_Range <> nil then
     nevAddRangeToList(l_Ranges, l_Range);
   end; // for l_IDX := 0 to aList.Count - 1 do
   Result := TevMultiSelectionBlock.Make(Text.TextSource.Document.AsObject, l_Ranges)
  finally
   FreeAndNil(l_Ranges);
  end;//try..finally
 end;//aList.Count = 1
//#UC END# *4F85B66E0260_49539DBA029D_impl*
end;//TExTextForm.ExtractRangeFromList

function TExTextForm.ExtractRangeFromSub(aID: Integer;
 aLayerID: Integer): InevRange;
//#UC START# *4F85B63D00DE_49539DBA029D_var*
var
 l_Para: InevPara;
//#UC END# *4F85B63D00DE_49539DBA029D_var*
begin
//#UC START# *4F85B63D00DE_49539DBA029D_impl*
 if Text.Document.DocumentContainer.SubList.SubEx[aID, aLayerID].Para.QT(InevPara, l_Para) then
  Result := l_Para.SubRange(Text.View, 0, MaxInt).ParentRange(MaxInt)
 else
  Result := nil;
//#UC END# *4F85B63D00DE_49539DBA029D_impl*
end;//TExTextForm.ExtractRangeFromSub

function TExTextForm.MakeCaption(const aDocument: IDocument;
 aShort: Boolean): Il3CString;
//#UC START# *53BE2C3D0176_49539DBA029D_var*

 function lp_GetDocumentName(const aDoc: IDocument): Il3CString;
 begin
  Result := nsGetDocumentName(aDoc);
 end;//lp_GetDocumentName

 function lp_GetDocumentShortName(const aDoc: IDocument): Il3CString;
 begin
  Result := nsGetDocumentShortName(aDoc);
 end;

//#UC END# *53BE2C3D0176_49539DBA029D_var*
begin
//#UC START# *53BE2C3D0176_49539DBA029D_impl*
 case UserType of
  dftDocument, dftDictEntry, dftTips, dftMedDictEntry, dftMedicFirm:
  begin
   if (not aShort) then
   begin
    if not TdmStdRes.IsCurEditionActual(aDocument) then
     Result := vcmFmt(str_nsRedactionCaption, [lp_GetDocumentName(aDocument)])
    else
     Result := l3Cat(CurUserType.Caption + ' : ', lp_GetDocumentName(aDocument));
   end
   else
    Result := lp_GetDocumentName(aDocument);
    // - http://mdp.garant.ru/pages/viewpage.action?pageId=531971274
  end;//dftDocument..
  dftAutoreferat,
  dftAutoreferatAfterSearch,
  dftDrug:
   if aShort then
   begin
    //http://mdp.garant.ru/pages/viewpage.action?pageId=562605136
    if (UserType in [dftAutoreferatAfterSearch, dftAutoreferat]) then
     Result := lp_GetDocumentShortName(aDocument)
    else
     Result := lp_GetDocumentName(aDocument)
   end
   else
    Result := l3Cat(CurUserType.Caption + ' : ', lp_GetDocumentName(aDocument));
  dftAACLeft,
  dftAACRight,
  dftAACContentsRight:
   if aShort then
    Result := lp_GetDocumentShortName(aDocument)
   else
    Result := l3Cat([str_dftDocumentCaption.AsCStr, vcmCStr(' : '), lp_GetDocumentName(aDocument)]);
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=571639740
 end;//case UserType
//#UC END# *53BE2C3D0176_49539DBA029D_impl*
end;//TExTextForm.MakeCaption

procedure TExTextForm.UpdateDocumentCaption(const aDocument: IDocument);
//#UC START# *53C3A82F01C0_49539DBA029D_var*
var
 l_Caption: Il3CString;
//#UC END# *53C3A82F01C0_49539DBA029D_var*
begin
//#UC START# *53C3A82F01C0_49539DBA029D_impl*
 Assert(aDocument <> nil);
 l_Caption := MakeCaption(aDocument, False);
 try
  f_TabCaption := MakeCaption(aDocument, True);
  if (not l3IsNil(l_Caption)) then
  begin
   CCaption := l_Caption;
   if (UserType in [dftAACLeft, dftAACRight, dftAACContentsRight, dftDictEntry]) then
    UpdateTabCaption(l_Caption);
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=590762358
  end;
 finally
  l_Caption := nil;
 end;
//#UC END# *53C3A82F01C0_49539DBA029D_impl*
end;//TExTextForm.UpdateDocumentCaption

function TExTextForm.IsPictureUnderCursor: Boolean;
//#UC START# *53DF35EA01CE_49539DBA029D_var*
var
 l_EP : IeePara;
//#UC END# *53DF35EA01CE_49539DBA029D_var*
begin
//#UC START# *53DF35EA01CE_49539DBA029D_impl*
 l_EP := LeafParaUnderCursor;
 Result := (l_EP <> nil);
 if Result then
  if not Supports(l_EP, IeePicture) then
   Result := false;
//#UC END# *53DF35EA01CE_49539DBA029D_impl*
end;//TExTextForm.IsPictureUnderCursor

procedure TExTextForm.OpenDocumentInNewContainer(aOpenKind: TvcmMainFormOpenKind);
//#UC START# *55546DEA0384_49539DBA029D_var*
var
 l_NewDocument : IDocument;
 l_Cont        : IvcmContainer;
 l_TopPara     : IeePara;
//#UC END# *55546DEA0384_49539DBA029D_var*
begin
//#UC START# *55546DEA0384_49539DBA029D_impl*
 if (Document <> nil) then
 begin
  l_Cont := nsOpenNewWindowTabbed(NativeMainForm, aOpenKind);
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=560729118
  if (l_Cont <> nil) then
  try
   l_TopPara := GetTopParaID;
   try
    l_NewDocument := defDataAdapter.TimeMachine.CorrectDocumentEdition(Document);
    try
     if (l_TopPara <> nil) then
      TdmStdRes.OpenDocument(TdeDocInfo.Make(l_NewDocument,
                                             TbsDocPos_P(l_TopPara)),
                             l_Cont)
     else
      TdmStdRes.OpenDocument(TdeDocInfo.Make(l_NewDocument), l_Cont);
    finally
     l_NewDocument := nil;
    end;//try..finally
   finally
    l_TopPara := nil;
   end;//try..finally
  finally
   l_Cont := nil;
  end;//try..finally
 end;//Document <> nil
//#UC END# *55546DEA0384_49539DBA029D_impl*
end;//TExTextForm.OpenDocumentInNewContainer

procedure TExTextForm.ChangePositionByDataSource;
 {* изменить позицию в документе на основе информации источника данных }
//#UC START# *49883D6D03A2_49539DBA029D_var*
//#UC END# *49883D6D03A2_49539DBA029D_var*
begin
//#UC START# *49883D6D03A2_49539DBA029D_impl*
 if (ViewArea <> nil) then
 begin
(*  Il3Lock(Text).Lock(Text);
  try*)
  Text.TextSource.DocumentContainer.LinkWaiter(TnsDocumentPointWaiter.Make(Self, ViewArea.DocInfo.Pos));
(*  finally
   Il3Lock(Text).Unlock(Text);
  end;//try..finally*)
 end;//ViewArea <> nil
//#UC END# *49883D6D03A2_49539DBA029D_impl*
end;//TExTextForm.ChangePositionByDataSource

function TExTextForm.OpenCRList(aKind: TlstCRType;
 const aType: Il3SimpleNode;
 ReConvertNode: Boolean): Boolean;
 {* Открыть список корреспондентов/респондентов }
//#UC START# *49886FBC0385_49539DBA029D_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *49886FBC0385_49539DBA029D_var*
begin
//#UC START# *49886FBC0385_49539DBA029D_impl*
 Result := true;
 if ReConvertNode then
  l_Node := bsConvertFilteredCRNode(aType)
 else
  l_Node := aType;
 OpenCRListOpExecute(aKind, l_Node);
//#UC END# *49886FBC0385_49539DBA029D_impl*
end;//TExTextForm.OpenCRList

procedure TExTextForm.TypedCRToPartTest(const aParams: IvcmTestParamsPrim;
 aCRType: TlstCRType);
//#UC START# *4988773A0053_49539DBA029D_var*
const
 CRListCaptions : array [1..2] of PvcmStringID = (@str_RespListForText, @str_RespListForPart);
var
 l_List    : IvcmNodes;
 l_Strings : IvcmStrings;
//#UC END# *4988773A0053_49539DBA029D_var*
begin
//#UC START# *4988773A0053_49539DBA029D_impl*
 OpenCRListOpTest(aParams, aCRType);
 with aParams do
 begin
  if Op.Flag[vcm_ofEnabled] then
  begin
   l_Strings := Op.SubItems;
   l_List := Op.SubNodes;
   if (l_Strings <> nil) and (l_List <> nil) then
   begin
    with DefDataAdapter do
     if Text.HasSelection then
     begin
      l_Strings.Add(vcmCStr(CRListCaptions[1]^));
      l_List.Add(CRSimpleListTypeRootNode);
      //
      l_Strings.Add(vcmCStr(CRListCaptions[2]^));
      l_List.Add(CRSimpleListTypeRootNode);
     end
     else
      l_List.Add(CRSimpleListTypeRootNode);
   end;//l_Strings <> nil
  end;
 end;
//#UC END# *4988773A0053_49539DBA029D_impl*
end;//TExTextForm.TypedCRToPartTest

procedure TExTextForm.GetCorrespondentListEx(aParamsIndex: Integer;
 const aChoosedNode: Il3SimpleNode);
 {* Коллеги, это что? }
//#UC START# *498878B60084_49539DBA029D_var*
//#UC END# *498878B60084_49539DBA029D_var*
begin
//#UC START# *498878B60084_49539DBA029D_impl*
 case aParamsIndex of
  0, 1:
   OpenCRListOpExecute(crtCorrespondents, aChoosedNode);
  2:
   OpenCRListToPart(crtCorrespondents, aChoosedNode);
  else
   Assert(False);
 end;//case aParamsIndex
//#UC END# *498878B60084_49539DBA029D_impl*
end;//TExTextForm.GetCorrespondentListEx

procedure TExTextForm.OpenCRListToPart(aCRType: TlstCRType;
 const aType: Il3SimpleNode;
 const aPositionList: IPositionList = nil);
//#UC START# *498879F203D8_49539DBA029D_var*
var
 l_PositionList : IPositionList;
 l_Node         : INodeBase;
//#UC END# *498879F203D8_49539DBA029D_var*
begin
//#UC START# *498879F203D8_49539DBA029D_impl*
 if Assigned(dsDocument) then
 begin
  if Assigned(aPositionList) then
   l_PositionList := aPositionList
  else
   l_PositionList := MakePositionList(aCRType);
  if Assigned (l_PositionList) then
  begin
   if Supports(aType, INodeBase, l_Node) then
    DocumentSet.OpenCRToPart(l_PositionList, l_Node, aCRType)
   else
    DocumentSet.OpenCRToPart(l_PositionList, nil, aCRType);
  end//Assigned(l_PositionList)
  else
  begin
   //Assert(false,'А разве когда-нибудь Assigned(l_PositionList) неверно?');
   // - да - бывают случаи когда это неверно
   // http://mdp.garant.ru/pages/viewpage.action?pageId=269063249
   // Мы не можем просто вызвать OpenCRType, потому что операции которые мы
   // собираемся вызвать управляют активность формы корр\респ и сделают форму
   // активной (CQ: OIT500017328):
   case aCRType of
    crtCorrespondents:
     op_Document_OpenCorrespondentList.Call(Self.As_IvcmEntityForm, aCRType, aType);
    crtRespondents:
     op_Document_OpenRespondentList.Call(Self.As_IvcmEntityForm, aCRType, aType);
   end;//case aCRType
   //OpenCRList(aCRType, aType);
  end;//Assigned(l_PositionList)
 end;//if Assigned(dsDocument) then
//#UC END# *498879F203D8_49539DBA029D_impl*
end;//TExTextForm.OpenCRListToPart

procedure TExTextForm.GetRespondentListEx(aParamsIndex: Integer;
 const aChoosedNode: Il3SimpleNode);
//#UC START# *49889018003E_49539DBA029D_var*
//#UC END# *49889018003E_49539DBA029D_var*
begin
//#UC START# *49889018003E_49539DBA029D_impl*
 case aParamsIndex of
  0, 1:
   OpenCRListOpExecute(crtRespondents, aChoosedNode);
  2:
   OpenCRListToPart(crtRespondents, aChoosedNode);
  else
   Assert(False);
 end;//case aParamsIndex
//#UC END# *49889018003E_49539DBA029D_impl*
end;//TExTextForm.GetRespondentListEx

procedure TExTextForm.SynchronizeWithRedationsForm;
//#UC START# *4A793A0A032F_49539DBA029D_var*
//#UC END# *4A793A0A032F_49539DBA029D_var*
begin
//#UC START# *4A793A0A032F_49539DBA029D_impl*
 op_Editions_SetCurrent.Call(Aggregate, Document);
//#UC END# *4A793A0A032F_49539DBA029D_impl*
end;//TExTextForm.SynchronizeWithRedationsForm

procedure TExTextForm.DoSwitchToFirstTab;
//#UC START# *4B043ABF0363_49539DBA029D_var*
//#UC END# *4B043ABF0363_49539DBA029D_var*
begin
//#UC START# *4B043ABF0363_49539DBA029D_impl*
 if (UserType in [dftRelatedDoc,
                              dftDictSubEntry,
                              dftAnnotation,
                              dftTranslation,
                              dftChronology]) then
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=573677603
  op_Switcher_SetFirstPageActive.Call(Container)
 else
  SafeClose;
//#UC END# *4B043ABF0363_49539DBA029D_impl*
end;//TExTextForm.DoSwitchToFirstTab

procedure TExTextForm.OpenRedactionList;
//#UC START# *4B2631930324_49539DBA029D_var*
//#UC END# *4B2631930324_49539DBA029D_var*
begin
//#UC START# *4B2631930324_49539DBA029D_impl*
 DocumentSet.OpenEditions;
//#UC END# *4B2631930324_49539DBA029D_impl*
end;//TExTextForm.OpenRedactionList

procedure TExTextForm.dftMedicFirmSynchroViewQueryMaximized(aSender: TObject);
 {* Обработчик события dftMedicFirmSynchroView.OnQueryMaximized }
//#UC START# *08687812598B_49539DBA029D_var*
//#UC END# *08687812598B_49539DBA029D_var*
begin
//#UC START# *08687812598B_49539DBA029D_impl*
  if HasDoc then
   OpenInWindow;
//#UC END# *08687812598B_49539DBA029D_impl*
end;//TExTextForm.dftMedicFirmSynchroViewQueryMaximized

procedure TExTextForm.dftTranslationQueryMaximized(aSender: TObject);
 {* Обработчик события dftTranslation.OnQueryMaximized }
//#UC START# *0B8413148796_49539DBA029D_var*
//#UC END# *0B8413148796_49539DBA029D_var*
begin
//#UC START# *0B8413148796_49539DBA029D_impl*
  if HasDoc then
   OpenInWindow;
//#UC END# *0B8413148796_49539DBA029D_impl*
end;//TExTextForm.dftTranslationQueryMaximized

procedure TExTextForm.DoTabActivate;
 {* Реакция на переключение вкладки }
//#UC START# *497F16AC015A_49539DBA029D_var*
var
 l_ActivationKind : TnsTextTabActivateKind;
//#UC END# *497F16AC015A_49539DBA029D_var*
begin
//#UC START# *497F16AC015A_49539DBA029D_impl*
 if (sdsBaseDocument <> nil) then
 begin
  case UserType of
   dftRelatedDoc:
    l_ActivationKind := ttakRelated;
   dftAnnotation:
    l_ActivationKind := ttakAnnotation;
   else
    Exit;
  end;//case UserType of
  TnsTextTabActivateEvent.Log(sdsBaseDocument.DocInfo.Doc, l_ActivationKind);
 end;//sdsBaseDocument <> nil
//#UC END# *497F16AC015A_49539DBA029D_impl*
end;//TExTextForm.DoTabActivate

procedure TExTextForm.OpenCorrespondentList;
 {* Коллеги, это что? }
//#UC START# *4988752302F4_49539DBA029D_var*
//#UC END# *4988752302F4_49539DBA029D_var*
begin
//#UC START# *4988752302F4_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4988752302F4_49539DBA029D_impl*
end;//TExTextForm.OpenCorrespondentList

procedure TExTextForm.OpenRespondentList;
 {* Коллеги, это что? }
//#UC START# *49888E8003B9_49539DBA029D_var*
//#UC END# *49888E8003B9_49539DBA029D_var*
begin
//#UC START# *49888E8003B9_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *49888E8003B9_49539DBA029D_impl*
end;//TExTextForm.OpenRespondentList

procedure TExTextForm.GetAttributesFrmAct;
 {* Информация о документе }
//#UC START# *498891640253_49539DBA029D_var*
//#UC END# *498891640253_49539DBA029D_var*
begin
//#UC START# *498891640253_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *498891640253_49539DBA029D_impl*
end;//TExTextForm.GetAttributesFrmAct

function TExTextForm.Load: Boolean;
 {* Коллеги, кто может описать этот метод? }
//#UC START# *49895A2102E8_49539DBA029D_var*
//#UC END# *49895A2102E8_49539DBA029D_var*
begin
//#UC START# *49895A2102E8_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *49895A2102E8_49539DBA029D_impl*
end;//TExTextForm.Load

procedure TExTextForm.GetRelatedDocFrmAct;
 {* Справка к документу }
//#UC START# *498993C801DC_49539DBA029D_var*
//#UC END# *498993C801DC_49539DBA029D_var*
begin
//#UC START# *498993C801DC_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *498993C801DC_49539DBA029D_impl*
end;//TExTextForm.GetRelatedDocFrmAct

procedure TExTextForm.SetBookmark;
 {* Устанавливает закладку на текущее место текущего документа }
//#UC START# *4989CD040306_49539DBA029D_var*
//#UC END# *4989CD040306_49539DBA029D_var*
begin
//#UC START# *4989CD040306_49539DBA029D_impl*
 AddBookmark(GetParaForPositionning(False));
//#UC END# *4989CD040306_49539DBA029D_impl*
end;//TExTextForm.SetBookmark

function TExTextForm.CanAddBookmark: Boolean;
 {* Можно ли сейчас добавлять закладку }
//#UC START# *4989CF90010A_49539DBA029D_var*
//#UC END# *4989CF90010A_49539DBA029D_var*
begin
//#UC START# *4989CF90010A_49539DBA029D_impl*
 Result := true;
//#UC END# *4989CF90010A_49539DBA029D_impl*
end;//TExTextForm.CanAddBookmark

procedure TExTextForm.GetCorrespondentList;
 {* Ссылки на документ }
//#UC START# *4989D65C0275_49539DBA029D_var*
//#UC END# *4989D65C0275_49539DBA029D_var*
begin
//#UC START# *4989D65C0275_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989D65C0275_49539DBA029D_impl*
end;//TExTextForm.GetCorrespondentList

procedure TExTextForm.GetRespondentList;
 {* Ссылки из документа }
//#UC START# *4989D8430128_49539DBA029D_var*
//#UC END# *4989D8430128_49539DBA029D_var*
begin
//#UC START# *4989D8430128_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989D8430128_49539DBA029D_impl*
end;//TExTextForm.GetRespondentList

function TExTextForm.AttributesCanBeClosed: Boolean;
 {* Это кандидат на перенос в Facet или что-то подобное }
//#UC START# *4989DE3702CF_49539DBA029D_var*
//#UC END# *4989DE3702CF_49539DBA029D_var*
begin
//#UC START# *4989DE3702CF_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989DE3702CF_49539DBA029D_impl*
end;//TExTextForm.AttributesCanBeClosed

function TExTextForm.DocumentIsValid: Boolean;
 {* Есть ли документ, готовый к работе }
//#UC START# *4A7C0E1A005C_49539DBA029D_var*
//#UC END# *4A7C0E1A005C_49539DBA029D_var*
begin
//#UC START# *4A7C0E1A005C_49539DBA029D_impl*
 Result := (Document <> nil);
//#UC END# *4A7C0E1A005C_49539DBA029D_impl*
end;//TExTextForm.DocumentIsValid

function TExTextForm.RedactionCurrentPara: IeeLeafPara;
 {* Текущий параграф редакции для синхронизации с окном сравннения редакций }
//#UC START# *4A7FCEA9025D_49539DBA029D_var*
//#UC END# *4A7FCEA9025D_49539DBA029D_var*
begin
//#UC START# *4A7FCEA9025D_49539DBA029D_impl*
 Result := GetParaForPositionning;
//#UC END# *4A7FCEA9025D_49539DBA029D_impl*
end;//TExTextForm.RedactionCurrentPara

function TExTextForm.DoProcessExternalOperation(const anOperation: IExternalOperation): Boolean;
 {* Обработчик внешней операции }
//#UC START# *4A815E860391_49539DBA029D_var*
var
 l_Operartion: TbsObjectId;
 l_Form: IvcmEntityForm;
const
 gc_Confirmation: array [Boolean] of PvcmMessageID = (@inf_PaymentRejected, @inf_PaymentConfirmed);
//#UC END# *4A815E860391_49539DBA029D_var*
begin
//#UC START# *4A815E860391_49539DBA029D_impl*
 Result := True;
 if Assigned(anOperation) then
 begin
  l_Operartion := anOperation.GetId;
  if l_Operartion = EOI_ESTIMATION then
  begin
   if (Consultation <> nil) then
    try
     Consultation.GiveMark;
    except
     on EbsConsultationAlreadyMark do
      Say(inf_ConsulationAlreadyMark);
     on EbsConsultationWasDeleted do
      Say(inf_ConsultationWasDeleted);
    end;//try..except
  end//l_Operartion = EOI_ESTIMATION
  else
   if l_Operartion in [EOI_PAYMENT_CONFIRM, EOI_PAYMENT_REFUSAL] then
   begin
    if (Consultation <> nil) then
     try
      Consultation.ConfirmPayment(l_Operartion = EOI_PAYMENT_CONFIRM);
      Say(gc_Confirmation[l_Operartion = EOI_PAYMENT_CONFIRM]^);
     except
      on EbsConsultationAlreadyConfirmed do
       Say(inf_ConsulationAlreadyConfirmed);
      on EbsConsultationWasDeleted do
       Say(inf_ConsultationWasDeleted);
      on EbsPaymentForbidden do
       Say(war_PaymentForbidden);
      on ENoConnection do
       Say(war_NoConnection);
      on ENoSubscription do
       Say(war_NoSubscription, [defDataAdapter.GetDealerInfo]);
     end;{try..except}
   end//l_Operartion in [EOI_PAYMENT_CONFIRM, EOI_PAYMENT_REFUSAL]
   else
    if (l_Operartion = EOI_SHOW_HELP_TOPIC) and (UserType = dftConsultation) then
     Application.HelpSystem.ShowTopicHelp(cHelpConsultingRules, '')
    else
     if (l_Operartion = EOI_CONSULTATION_CALL_GARANT) then
      nsDoShellExecute(nsStringMapManager.Map[smap_InternetCaptions].DisplayNameToValue(vcmCStr(str_ilnCatalogue)))
     else
      if (l_Operartion = EOI_SHOW_CONSULTATION_LIST) then
      begin
       if (Consultation <> nil) then
       begin
        f_HyperlinkCallStatus := false; // http://mdp.garant.ru/pages/viewpage.action?pageId=342335537       
        if NativeMainForm.HasForm(fm_efList.rFormID, vcm_ztChild, True, @l_Form) then
         l_Form.SetActiveInParent;
       end;
      end
      else
       Result := False;
 end;

//#UC END# *4A815E860391_49539DBA029D_impl*
end;//TExTextForm.DoProcessExternalOperation

procedure TExTextForm.GotoPoint(aPointID: Cardinal;
 aPointType: TDocumentPositionType = bsTypesNew.dptSub);
 {* Переход на точку в документе }
//#UC START# *4A8164E801AE_49539DBA029D_var*
var
 l_Document : IDocument;
 l_Sub      : IeeSub;
//#UC END# *4A8164E801AE_49539DBA029D_var*
begin
//#UC START# *4A8164E801AE_49539DBA029D_impl*
 if Text.TextSource.HasDocument then
 begin
  if (aPointType = dptSub) then
  begin
   if (aPointID AND POSITION_TYPE_MASK = POSITION_TYPE_PARA_ID) then
    aPointType := dptPara;
   l3ClearMask(Integer(aPointID), Integer(POSITION_TYPE_MASK));
  end;//aPointType = dptSub
  case aPointType of
   dptPara :
    try
     Text.GoToPara(aPointID);
    except
     on E: Exception do
      l3System.Exception2Log(E);
    end;//try..except
   dptSub  :
    begin
     l_Document := Document;
     try
      l_Sub := Text.Editor.Data.Document.Subs.SubsByID[aPointID];
      if (l_Sub <> nil) and
         l_Sub.Exists then
       l_Sub.Select;
     finally
      l_Document := nil;
     end;//try..finally
    end;//dptSub
   dptBookmark :
    begin
     l_Sub := Text.Editor.Data.Document.Bookmarks.SubsByID[aPointID];
     if (l_Sub <> nil) and
        l_Sub.Exists then
      l_Sub.Select;
    end;//dptBookmark
   dptMarker :
    begin
     l_Sub := Text.Editor.Data.Document.Markers.SubsByID[aPointID];
     if (l_Sub <> nil) and
        l_Sub.Exists then
      l_Sub.Select;
    end;//dptMarker
   dptMark :
    begin
     l_Sub := Text.Editor.Data.Document.Marks.SubsByID[aPointID];
     if (l_Sub <> nil) and
        l_Sub.Exists then
      l_Sub.Select;
    end;//dptMark
   dptDocumentPlace:
    if aPointID = LongWord(Ord(ev_dpEnd)) then
     Text.GotoBottom;
  end;//case aPointType
 end//Text.TextSource.HasDocument
 else
 if (ViewArea <> nil) then
  ViewArea.DocInfo.SetPosition(TbsDocPos_C(aPointType, aPointID));
//#UC END# *4A8164E801AE_49539DBA029D_impl*
end;//TExTextForm.GotoPoint

procedure TExTextForm.OpenRedactionLocalLink(const aDocument: IDocument;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour);
 {* Открывает локальную ссылку на другую редакцию }
//#UC START# *4A81650B014A_49539DBA029D_var*
//#UC END# *4A81650B014A_49539DBA029D_var*
begin
//#UC START# *4A81650B014A_49539DBA029D_impl*
 OpenRedactionGlobalLink(aDocument, aSub, aBehaviour);
//#UC END# *4A81650B014A_49539DBA029D_impl*
end;//TExTextForm.OpenRedactionLocalLink

function TExTextForm.HyperlinkDocument: IDocument;
 {* Документ ИЗ которого ведёт ссылка }
//#UC START# *4A8168BB0217_49539DBA029D_var*
//#UC END# *4A8168BB0217_49539DBA029D_var*
begin
//#UC START# *4A8168BB0217_49539DBA029D_impl*
 Result := Document;
//#UC END# *4A8168BB0217_49539DBA029D_impl*
end;//TExTextForm.HyperlinkDocument

function TExTextForm.pm_GetHyperlinkText: TevCustomEditorWindow;
//#UC START# *4A82BC390036_49539DBA029Dget_var*
//#UC END# *4A82BC390036_49539DBA029Dget_var*
begin
//#UC START# *4A82BC390036_49539DBA029Dget_impl*
 Result := Text;
//#UC END# *4A82BC390036_49539DBA029Dget_impl*
end;//TExTextForm.pm_GetHyperlinkText

function TExTextForm.CanBeChanged: Boolean;
 {* Может ли документ быть изменён }
//#UC START# *4A8931130363_49539DBA029D_var*
//#UC END# *4A8931130363_49539DBA029D_var*
begin
//#UC START# *4A8931130363_49539DBA029D_impl*
 Result := true;
//#UC END# *4A8931130363_49539DBA029D_impl*
end;//TExTextForm.CanBeChanged

function TExTextForm.IsFloating: Boolean;
 {* Форма плавающая }
//#UC START# *4A8A9DB0001A_49539DBA029D_var*
//#UC END# *4A8A9DB0001A_49539DBA029D_var*
begin
//#UC START# *4A8A9DB0001A_49539DBA029D_impl*
 Result := false;
//#UC END# *4A8A9DB0001A_49539DBA029D_impl*
end;//TExTextForm.IsFloating

function TExTextForm.pm_GetTextWithComments: TevCustomEditorWindow;
//#UC START# *4A8AAD450084_49539DBA029Dget_var*
//#UC END# *4A8AAD450084_49539DBA029Dget_var*
begin
//#UC START# *4A8AAD450084_49539DBA029Dget_impl*
 Result := Text;
//#UC END# *4A8AAD450084_49539DBA029Dget_impl*
end;//TExTextForm.pm_GetTextWithComments

procedure TExTextForm.CommonDocumentOpenNewWindow;
 {* Что это? }
//#UC START# *4A8EF02E007D_49539DBA029D_var*
//#UC END# *4A8EF02E007D_49539DBA029D_var*
begin
//#UC START# *4A8EF02E007D_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8EF02E007D_49539DBA029D_impl*
end;//TExTextForm.CommonDocumentOpenNewWindow

procedure TExTextForm.TimeMachineStateChange;
//#UC START# *4A8EF367029E_49539DBA029D_var*
//#UC END# *4A8EF367029E_49539DBA029D_var*
begin
//#UC START# *4A8EF367029E_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8EF367029E_49539DBA029D_impl*
end;//TExTextForm.TimeMachineStateChange

procedure TExTextForm.RedactionOnID;
//#UC START# *4A8EF4B50044_49539DBA029D_var*
//#UC END# *4A8EF4B50044_49539DBA029D_var*
begin
//#UC START# *4A8EF4B50044_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8EF4B50044_49539DBA029D_impl*
end;//TExTextForm.RedactionOnID

function TExTextForm.FindExplanation: Boolean;
 {* Найти толкование }
//#UC START# *4A9D26B80015_49539DBA029D_var*
//#UC END# *4A9D26B80015_49539DBA029D_var*
begin
//#UC START# *4A9D26B80015_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A9D26B80015_49539DBA029D_impl*
end;//TExTextForm.FindExplanation

procedure TExTextForm.FindInDict;
 {* Найти в Толковом словаре }
//#UC START# *4A9D3FC50134_49539DBA029D_var*
//#UC END# *4A9D3FC50134_49539DBA029D_var*
begin
//#UC START# *4A9D3FC50134_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A9D3FC50134_49539DBA029D_impl*
end;//TExTextForm.FindInDict

function TExTextForm.SetPosition: Boolean;
//#UC START# *4AE9D38A02DA_49539DBA029D_var*
//#UC END# *4AE9D38A02DA_49539DBA029D_var*
begin
//#UC START# *4AE9D38A02DA_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE9D38A02DA_49539DBA029D_impl*
end;//TExTextForm.SetPosition

procedure TExTextForm.SetActive;
//#UC START# *4AE9D9AF02FE_49539DBA029D_var*
//#UC END# *4AE9D9AF02FE_49539DBA029D_var*
begin
//#UC START# *4AE9D9AF02FE_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE9D9AF02FE_49539DBA029D_impl*
end;//TExTextForm.SetActive

procedure TExTextForm.ExportBlock;
//#UC START# *4AE9DC070264_49539DBA029D_var*
//#UC END# *4AE9DC070264_49539DBA029D_var*
begin
//#UC START# *4AE9DC070264_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE9DC070264_49539DBA029D_impl*
end;//TExTextForm.ExportBlock

function TExTextForm.GetCurrentPosition: Integer;
//#UC START# *4AEAF9C000D8_49539DBA029D_var*
//#UC END# *4AEAF9C000D8_49539DBA029D_var*
begin
//#UC START# *4AEAF9C000D8_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEAF9C000D8_49539DBA029D_impl*
end;//TExTextForm.GetCurrentPosition

procedure TExTextForm.SelectBlock;
//#UC START# *4AEB097001C3_49539DBA029D_var*
//#UC END# *4AEB097001C3_49539DBA029D_var*
begin
//#UC START# *4AEB097001C3_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEB097001C3_49539DBA029D_impl*
end;//TExTextForm.SelectBlock

procedure TExTextForm.CopyBlock;
//#UC START# *4AEB09C50287_49539DBA029D_var*
//#UC END# *4AEB09C50287_49539DBA029D_var*
begin
//#UC START# *4AEB09C50287_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEB09C50287_49539DBA029D_impl*
end;//TExTextForm.CopyBlock

procedure TExTextForm.PrintBlock;
//#UC START# *4AEB0A1C0270_49539DBA029D_var*
//#UC END# *4AEB0A1C0270_49539DBA029D_var*
begin
//#UC START# *4AEB0A1C0270_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEB0A1C0270_49539DBA029D_impl*
end;//TExTextForm.PrintBlock

procedure TExTextForm.PrintDialogBlock;
//#UC START# *4AEB0A550165_49539DBA029D_var*
//#UC END# *4AEB0A550165_49539DBA029D_var*
begin
//#UC START# *4AEB0A550165_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEB0A550165_49539DBA029D_impl*
end;//TExTextForm.PrintDialogBlock

procedure TExTextForm.PreviewBlock;
//#UC START# *4AEB0A8E002E_49539DBA029D_var*
//#UC END# *4AEB0A8E002E_49539DBA029D_var*
begin
//#UC START# *4AEB0A8E002E_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEB0A8E002E_49539DBA029D_impl*
end;//TExTextForm.PreviewBlock

procedure TExTextForm.ShowRespondentListToPart;
//#UC START# *4AEEEE970141_49539DBA029D_var*
//#UC END# *4AEEEE970141_49539DBA029D_var*
begin
//#UC START# *4AEEEE970141_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEEEE970141_49539DBA029D_impl*
end;//TExTextForm.ShowRespondentListToPart

procedure TExTextForm.ShowCorrespondentListToPart;
//#UC START# *4AEEEEB7027C_49539DBA029D_var*
//#UC END# *4AEEEEB7027C_49539DBA029D_var*
begin
//#UC START# *4AEEEEB7027C_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEEEEB7027C_49539DBA029D_impl*
end;//TExTextForm.ShowCorrespondentListToPart

procedure TExTextForm.ModifyBookmarkNotify;
//#UC START# *4AEEF7F40304_49539DBA029D_var*
//#UC END# *4AEEF7F40304_49539DBA029D_var*
begin
//#UC START# *4AEEF7F40304_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEEF7F40304_49539DBA029D_impl*
end;//TExTextForm.ModifyBookmarkNotify

procedure TExTextForm.AddBookmarkFromContents;
//#UC START# *4AEEF87B00E1_49539DBA029D_var*
//#UC END# *4AEEF87B00E1_49539DBA029D_var*
begin
//#UC START# *4AEEF87B00E1_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEEF87B00E1_49539DBA029D_impl*
end;//TExTextForm.AddBookmarkFromContents

procedure TExTextForm.GetCorrespondentListExFrmAct;
 {* Ссылки на документ (вид информации) }
//#UC START# *4AF329F6002A_49539DBA029D_var*
//#UC END# *4AF329F6002A_49539DBA029D_var*
begin
//#UC START# *4AF329F6002A_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF329F6002A_49539DBA029D_impl*
end;//TExTextForm.GetCorrespondentListExFrmAct

procedure TExTextForm.GetRespondentListExFrmAct;
 {* Ссылки из документа (вид информации) }
//#UC START# *4AF329FD014D_49539DBA029D_var*
//#UC END# *4AF329FD014D_49539DBA029D_var*
begin
//#UC START# *4AF329FD014D_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF329FD014D_49539DBA029D_impl*
end;//TExTextForm.GetRespondentListExFrmAct

procedure TExTextForm.TimeMachineOnOff;
//#UC START# *4AF83BDB03AE_49539DBA029D_var*
//#UC END# *4AF83BDB03AE_49539DBA029D_var*
begin
//#UC START# *4AF83BDB03AE_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF83BDB03AE_49539DBA029D_impl*
end;//TExTextForm.TimeMachineOnOff

procedure TExTextForm.TimeMachineOffAndReset;
//#UC START# *4AF83BEB0393_49539DBA029D_var*
//#UC END# *4AF83BEB0393_49539DBA029D_var*
begin
//#UC START# *4AF83BEB0393_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF83BEB0393_49539DBA029D_impl*
end;//TExTextForm.TimeMachineOffAndReset

procedure TExTextForm.OpenNotSureTopic;
//#UC START# *4AF83C3D01DA_49539DBA029D_var*
//#UC END# *4AF83C3D01DA_49539DBA029D_var*
begin
//#UC START# *4AF83C3D01DA_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF83C3D01DA_49539DBA029D_impl*
end;//TExTextForm.OpenNotSureTopic

procedure TExTextForm.ActualRedaction;
//#UC START# *4AFAF4900270_49539DBA029D_var*
//#UC END# *4AFAF4900270_49539DBA029D_var*
begin
//#UC START# *4AFAF4900270_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AFAF4900270_49539DBA029D_impl*
end;//TExTextForm.ActualRedaction

procedure TExTextForm.ToggleFoundWords;
 {* Подсвечивать найденный контекст }
//#UC START# *4AFD4230031F_49539DBA029D_var*
//#UC END# *4AFD4230031F_49539DBA029D_var*
begin
//#UC START# *4AFD4230031F_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AFD4230031F_49539DBA029D_impl*
end;//TExTextForm.ToggleFoundWords

function TExTextForm.GotoPara: Boolean;
//#UC START# *4AFD4A45003B_49539DBA029D_var*
//#UC END# *4AFD4A45003B_49539DBA029D_var*
begin
//#UC START# *4AFD4A45003B_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AFD4A45003B_49539DBA029D_impl*
end;//TExTextForm.GotoPara

procedure TExTextForm.TimeMachineOnOffNew;
 {* Включить Машину времени }
//#UC START# *4B261EC80086_49539DBA029D_var*
//#UC END# *4B261EC80086_49539DBA029D_var*
begin
//#UC START# *4B261EC80086_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B261EC80086_49539DBA029D_impl*
end;//TExTextForm.TimeMachineOnOffNew

procedure TExTextForm.OpenRedactionListFrmAct;
 {* Список редакций }
//#UC START# *4B262F9701DE_49539DBA029D_var*
//#UC END# *4B262F9701DE_49539DBA029D_var*
begin
//#UC START# *4B262F9701DE_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B262F9701DE_49539DBA029D_impl*
end;//TExTextForm.OpenRedactionListFrmAct

function TExTextForm.GetParaForPositionning: IeeLeafPara;
//#UC START# *4B506F4D0196_49539DBA029D_var*
//#UC END# *4B506F4D0196_49539DBA029D_var*
begin
//#UC START# *4B506F4D0196_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B506F4D0196_49539DBA029D_impl*
end;//TExTextForm.GetParaForPositionning

function TExTextForm.NeedGotoNeighbours: Boolean;
 {* Надо ли переходить на соседей блока }
//#UC START# *4C068AB5026A_49539DBA029D_var*
//#UC END# *4C068AB5026A_49539DBA029D_var*
begin
//#UC START# *4C068AB5026A_49539DBA029D_impl*
 Result := true;
//#UC END# *4C068AB5026A_49539DBA029D_impl*
end;//TExTextForm.NeedGotoNeighbours

procedure TExTextForm.GetCorrespondentList;
//#UC START# *4C2AEDB3003B_49539DBA029D_var*
//#UC END# *4C2AEDB3003B_49539DBA029D_var*
begin
//#UC START# *4C2AEDB3003B_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2AEDB3003B_49539DBA029D_impl*
end;//TExTextForm.GetCorrespondentList

procedure TExTextForm.GetRespondentList;
//#UC START# *4C2AEDC503CC_49539DBA029D_var*
//#UC END# *4C2AEDC503CC_49539DBA029D_var*
begin
//#UC START# *4C2AEDC503CC_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2AEDC503CC_49539DBA029D_impl*
end;//TExTextForm.GetRespondentList

procedure TExTextForm.GetTypedCorrespondentList;
//#UC START# *4C2AEDDA0335_49539DBA029D_var*
//#UC END# *4C2AEDDA0335_49539DBA029D_var*
begin
//#UC START# *4C2AEDDA0335_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2AEDDA0335_49539DBA029D_impl*
end;//TExTextForm.GetTypedCorrespondentList

procedure TExTextForm.GetTypedRespondentList;
//#UC START# *4C2AEDE7028C_49539DBA029D_var*
//#UC END# *4C2AEDE7028C_49539DBA029D_var*
begin
//#UC START# *4C2AEDE7028C_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2AEDE7028C_49539DBA029D_impl*
end;//TExTextForm.GetTypedRespondentList

procedure TExTextForm.GetAnnotationDocFrmAct;
//#UC START# *4C3AA77E00A3_49539DBA029D_var*
//#UC END# *4C3AA77E00A3_49539DBA029D_var*
begin
//#UC START# *4C3AA77E00A3_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AA77E00A3_49539DBA029D_impl*
end;//TExTextForm.GetAnnotationDocFrmAct

procedure TExTextForm.SimilarDocuments;
//#UC START# *4C3AA78E024D_49539DBA029D_var*
//#UC END# *4C3AA78E024D_49539DBA029D_var*
begin
//#UC START# *4C3AA78E024D_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AA78E024D_49539DBA029D_impl*
end;//TExTextForm.SimilarDocuments

procedure TExTextForm.UserCR1;
//#UC START# *4C3ADF860163_49539DBA029D_var*
//#UC END# *4C3ADF860163_49539DBA029D_var*
begin
//#UC START# *4C3ADF860163_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3ADF860163_49539DBA029D_impl*
end;//TExTextForm.UserCR1

procedure TExTextForm.UserCR2;
//#UC START# *4C3ADF950028_49539DBA029D_var*
//#UC END# *4C3ADF950028_49539DBA029D_var*
begin
//#UC START# *4C3ADF950028_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3ADF950028_49539DBA029D_impl*
end;//TExTextForm.UserCR2

procedure TExTextForm.GetTypedCorrespondentList;
//#UC START# *4C3ADFA5018F_49539DBA029D_var*
//#UC END# *4C3ADFA5018F_49539DBA029D_var*
begin
//#UC START# *4C3ADFA5018F_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3ADFA5018F_49539DBA029D_impl*
end;//TExTextForm.GetTypedCorrespondentList

procedure TExTextForm.PrevRedaction;
//#UC START# *4C3AE0950253_49539DBA029D_var*
//#UC END# *4C3AE0950253_49539DBA029D_var*
begin
//#UC START# *4C3AE0950253_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AE0950253_49539DBA029D_impl*
end;//TExTextForm.PrevRedaction

procedure TExTextForm.NextRedaction;
//#UC START# *4C3AE0CD0079_49539DBA029D_var*
//#UC END# *4C3AE0CD0079_49539DBA029D_var*
begin
//#UC START# *4C3AE0CD0079_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AE0CD0079_49539DBA029D_impl*
end;//TExTextForm.NextRedaction

procedure TExTextForm.AddToControl;
//#UC START# *4C3AFAD90234_49539DBA029D_var*
//#UC END# *4C3AFAD90234_49539DBA029D_var*
begin
//#UC START# *4C3AFAD90234_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AFAD90234_49539DBA029D_impl*
end;//TExTextForm.AddToControl

procedure TExTextForm.ShowCorrespondentListToPart;
//#UC START# *4C3AFB450234_49539DBA029D_var*
//#UC END# *4C3AFB450234_49539DBA029D_var*
begin
//#UC START# *4C3AFB450234_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AFB450234_49539DBA029D_impl*
end;//TExTextForm.ShowCorrespondentListToPart

procedure TExTextForm.ShowRespondentListToPart;
//#UC START# *4C3AFB51020D_49539DBA029D_var*
//#UC END# *4C3AFB51020D_49539DBA029D_var*
begin
//#UC START# *4C3AFB51020D_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AFB51020D_49539DBA029D_impl*
end;//TExTextForm.ShowRespondentListToPart

procedure TExTextForm.ClearStatusSettings;
 {* Способ сброса статуса "изменен" }
//#UC START# *4C3AFBA702E4_49539DBA029D_var*
//#UC END# *4C3AFBA702E4_49539DBA029D_var*
begin
//#UC START# *4C3AFBA702E4_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AFBA702E4_49539DBA029D_impl*
end;//TExTextForm.ClearStatusSettings

procedure TExTextForm.TimeMachineOnOff;
//#UC START# *4C3AFC1302FF_49539DBA029D_var*
//#UC END# *4C3AFC1302FF_49539DBA029D_var*
begin
//#UC START# *4C3AFC1302FF_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AFC1302FF_49539DBA029D_impl*
end;//TExTextForm.TimeMachineOnOff

procedure TExTextForm.AddBookmark;
//#UC START# *4C3B17DC02C4_49539DBA029D_var*
//#UC END# *4C3B17DC02C4_49539DBA029D_var*
begin
//#UC START# *4C3B17DC02C4_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B17DC02C4_49539DBA029D_impl*
end;//TExTextForm.AddBookmark

procedure TExTextForm.ToMSWord;
//#UC START# *4C3B17ED0192_49539DBA029D_var*
//#UC END# *4C3B17ED0192_49539DBA029D_var*
begin
//#UC START# *4C3B17ED0192_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B17ED0192_49539DBA029D_impl*
end;//TExTextForm.ToMSWord

procedure TExTextForm.Print;
//#UC START# *4C3B17FF03D2_49539DBA029D_var*
//#UC END# *4C3B17FF03D2_49539DBA029D_var*
begin
//#UC START# *4C3B17FF03D2_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B17FF03D2_49539DBA029D_impl*
end;//TExTextForm.Print

procedure TExTextForm.PrintDialog;
//#UC START# *4C3B180E038F_49539DBA029D_var*
//#UC END# *4C3B180E038F_49539DBA029D_var*
begin
//#UC START# *4C3B180E038F_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B180E038F_49539DBA029D_impl*
end;//TExTextForm.PrintDialog

procedure TExTextForm.AddBookmark;
 {* Установить закладку на фрагмент }
//#UC START# *4C3B1AEA0127_49539DBA029D_var*
//#UC END# *4C3B1AEA0127_49539DBA029D_var*
begin
//#UC START# *4C3B1AEA0127_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B1AEA0127_49539DBA029D_impl*
end;//TExTextForm.AddBookmark

procedure TExTextForm.ToMSWord;
//#UC START# *4C3B1AFB0270_49539DBA029D_var*
//#UC END# *4C3B1AFB0270_49539DBA029D_var*
begin
//#UC START# *4C3B1AFB0270_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B1AFB0270_49539DBA029D_impl*
end;//TExTextForm.ToMSWord

procedure TExTextForm.PrintDialog;
//#UC START# *4C3B1B0F0237_49539DBA029D_var*
//#UC END# *4C3B1B0F0237_49539DBA029D_var*
begin
//#UC START# *4C3B1B0F0237_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B1B0F0237_49539DBA029D_impl*
end;//TExTextForm.PrintDialog

procedure TExTextForm.Copy;
//#UC START# *4C3B1B1D003C_49539DBA029D_var*
//#UC END# *4C3B1B1D003C_49539DBA029D_var*
begin
//#UC START# *4C3B1B1D003C_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B1B1D003C_49539DBA029D_impl*
end;//TExTextForm.Copy

procedure TExTextForm.Print;
//#UC START# *4C3B241401AA_49539DBA029D_var*
//#UC END# *4C3B241401AA_49539DBA029D_var*
begin
//#UC START# *4C3B241401AA_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B241401AA_49539DBA029D_impl*
end;//TExTextForm.Print

procedure TExTextForm.OpenContentsFrmAct;
//#UC START# *4C3B3754034D_49539DBA029D_var*
//#UC END# *4C3B3754034D_49539DBA029D_var*
begin
//#UC START# *4C3B3754034D_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B3754034D_49539DBA029D_impl*
end;//TExTextForm.OpenContentsFrmAct

procedure TExTextForm.ShowDocumentPicture;
//#UC START# *4C3B3792000E_49539DBA029D_var*
//#UC END# *4C3B3792000E_49539DBA029D_var*
begin
//#UC START# *4C3B3792000E_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B3792000E_49539DBA029D_impl*
end;//TExTextForm.ShowDocumentPicture

procedure TExTextForm.Open;
//#UC START# *4C3B49DB03BC_49539DBA029D_var*
//#UC END# *4C3B49DB03BC_49539DBA029D_var*
begin
//#UC START# *4C3B49DB03BC_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B49DB03BC_49539DBA029D_impl*
end;//TExTextForm.Open

procedure TExTextForm.Save;
//#UC START# *4C3B49EA00C4_49539DBA029D_var*
//#UC END# *4C3B49EA00C4_49539DBA029D_var*
begin
//#UC START# *4C3B49EA00C4_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B49EA00C4_49539DBA029D_impl*
end;//TExTextForm.Save

procedure TExTextForm.OpenActualRedaction;
//#UC START# *4C3B4A7D029B_49539DBA029D_var*
//#UC END# *4C3B4A7D029B_49539DBA029D_var*
begin
//#UC START# *4C3B4A7D029B_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B4A7D029B_49539DBA029D_impl*
end;//TExTextForm.OpenActualRedaction

procedure TExTextForm.ShowInfo;
//#UC START# *4C3B500B0126_49539DBA029D_var*
//#UC END# *4C3B500B0126_49539DBA029D_var*
begin
//#UC START# *4C3B500B0126_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B500B0126_49539DBA029D_impl*
end;//TExTextForm.ShowInfo

procedure TExTextForm.TimeMachineOnOffNew;
//#UC START# *4C3B504A0202_49539DBA029D_var*
//#UC END# *4C3B504A0202_49539DBA029D_var*
begin
//#UC START# *4C3B504A0202_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B504A0202_49539DBA029D_impl*
end;//TExTextForm.TimeMachineOnOffNew

procedure TExTextForm.ShowInfo;
//#UC START# *4C3B52D6021F_49539DBA029D_var*
//#UC END# *4C3B52D6021F_49539DBA029D_var*
begin
//#UC START# *4C3B52D6021F_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B52D6021F_49539DBA029D_impl*
end;//TExTextForm.ShowInfo

procedure TExTextForm.ShowChanges;
 {* Показать изменения }
//#UC START# *4C3B5337022E_49539DBA029D_var*
//#UC END# *4C3B5337022E_49539DBA029D_var*
begin
//#UC START# *4C3B5337022E_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B5337022E_49539DBA029D_impl*
end;//TExTextForm.ShowChanges

procedure TExTextForm.ClearStatus;
 {* Сбросить статус "изменен" }
//#UC START# *4C3B535F0064_49539DBA029D_var*
//#UC END# *4C3B535F0064_49539DBA029D_var*
begin
//#UC START# *4C3B535F0064_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B535F0064_49539DBA029D_impl*
end;//TExTextForm.ClearStatus

procedure TExTextForm.Delete;
//#UC START# *4C3C71290115_49539DBA029D_var*
//#UC END# *4C3C71290115_49539DBA029D_var*
begin
//#UC START# *4C3C71290115_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3C71290115_49539DBA029D_impl*
end;//TExTextForm.Delete

procedure TExTextForm.Edit;
//#UC START# *4C3C7131036E_49539DBA029D_var*
//#UC END# *4C3C7131036E_49539DBA029D_var*
begin
//#UC START# *4C3C7131036E_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3C7131036E_49539DBA029D_impl*
end;//TExTextForm.Edit

procedure TExTextForm.Delete;
//#UC START# *4C3C71D20351_49539DBA029D_var*
//#UC END# *4C3C71D20351_49539DBA029D_var*
begin
//#UC START# *4C3C71D20351_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3C71D20351_49539DBA029D_impl*
end;//TExTextForm.Delete

procedure TExTextForm.HideShow;
//#UC START# *4C3C71E4033D_49539DBA029D_var*
//#UC END# *4C3C71E4033D_49539DBA029D_var*
begin
//#UC START# *4C3C71E4033D_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3C71E4033D_49539DBA029D_impl*
end;//TExTextForm.HideShow

procedure TExTextForm.Delete;
//#UC START# *4C3C74C603B6_49539DBA029D_var*
//#UC END# *4C3C74C603B6_49539DBA029D_var*
begin
//#UC START# *4C3C74C603B6_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3C74C603B6_49539DBA029D_impl*
end;//TExTextForm.Delete

procedure TExTextForm.AddUserComment;
//#UC START# *4C3C75240091_49539DBA029D_var*
//#UC END# *4C3C75240091_49539DBA029D_var*
begin
//#UC START# *4C3C75240091_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3C75240091_49539DBA029D_impl*
end;//TExTextForm.AddUserComment

procedure TExTextForm.GetGraphicImage;
//#UC START# *4C3C77CC012A_49539DBA029D_var*
//#UC END# *4C3C77CC012A_49539DBA029D_var*
begin
//#UC START# *4C3C77CC012A_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3C77CC012A_49539DBA029D_impl*
end;//TExTextForm.GetGraphicImage

procedure TExTextForm.DocumentSynchroOpenWindow;
//#UC START# *4C3EA65F0233_49539DBA029D_var*
//#UC END# *4C3EA65F0233_49539DBA029D_var*
begin
//#UC START# *4C3EA65F0233_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3EA65F0233_49539DBA029D_impl*
end;//TExTextForm.DocumentSynchroOpenWindow

procedure TExTextForm.DocumentSynchroOpenNewWindow;
//#UC START# *4C3EA671007A_49539DBA029D_var*
//#UC END# *4C3EA671007A_49539DBA029D_var*
begin
//#UC START# *4C3EA671007A_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3EA671007A_49539DBA029D_impl*
end;//TExTextForm.DocumentSynchroOpenNewWindow

procedure TExTextForm.DictListOpenFrmAct;
//#UC START# *4C3EA90300E1_49539DBA029D_var*
//#UC END# *4C3EA90300E1_49539DBA029D_var*
begin
//#UC START# *4C3EA90300E1_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3EA90300E1_49539DBA029D_impl*
end;//TExTextForm.DictListOpenFrmAct

procedure TExTextForm.GotoBookmark;
//#UC START# *4C3EBF860139_49539DBA029D_var*
//#UC END# *4C3EBF860139_49539DBA029D_var*
begin
//#UC START# *4C3EBF860139_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3EBF860139_49539DBA029D_impl*
end;//TExTextForm.GotoBookmark

procedure TExTextForm.LiteratureListForDictionary;
//#UC START# *4C3ED13D03A5_49539DBA029D_var*
//#UC END# *4C3ED13D03A5_49539DBA029D_var*
begin
//#UC START# *4C3ED13D03A5_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3ED13D03A5_49539DBA029D_impl*
end;//TExTextForm.LiteratureListForDictionary

procedure TExTextForm.EditBookmark;
//#UC START# *4C3ED54100A2_49539DBA029D_var*
//#UC END# *4C3ED54100A2_49539DBA029D_var*
begin
//#UC START# *4C3ED54100A2_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3ED54100A2_49539DBA029D_impl*
end;//TExTextForm.EditBookmark

procedure TExTextForm.DeleteBookmark;
//#UC START# *4C3ED54D03D4_49539DBA029D_var*
//#UC END# *4C3ED54D03D4_49539DBA029D_var*
begin
//#UC START# *4C3ED54D03D4_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3ED54D03D4_49539DBA029D_impl*
end;//TExTextForm.DeleteBookmark

procedure TExTextForm.AddBookmark;
//#UC START# *4C3ED5D502AE_49539DBA029D_var*
//#UC END# *4C3ED5D502AE_49539DBA029D_var*
begin
//#UC START# *4C3ED5D502AE_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3ED5D502AE_49539DBA029D_impl*
end;//TExTextForm.AddBookmark

procedure TExTextForm.OpenNewWindow;
//#UC START# *4C3ED7190010_49539DBA029D_var*
//#UC END# *4C3ED7190010_49539DBA029D_var*
begin
//#UC START# *4C3ED7190010_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3ED7190010_49539DBA029D_impl*
end;//TExTextForm.OpenNewWindow

procedure TExTextForm.OpenProducedDrugList;
//#UC START# *4C3EDBA7030C_49539DBA029D_var*
//#UC END# *4C3EDBA7030C_49539DBA029D_var*
begin
//#UC START# *4C3EDBA7030C_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3EDBA7030C_49539DBA029D_impl*
end;//TExTextForm.OpenProducedDrugList

procedure TExTextForm.OpenSimilarDrugList;
//#UC START# *4C3EDBB80283_49539DBA029D_var*
//#UC END# *4C3EDBB80283_49539DBA029D_var*
begin
//#UC START# *4C3EDBB80283_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3EDBB80283_49539DBA029D_impl*
end;//TExTextForm.OpenSimilarDrugList

procedure TExTextForm.InsertHyperlink;
 {* Поставить ссылку... }
//#UC START# *4C7B96FA02DA_49539DBA029D_var*
//#UC END# *4C7B96FA02DA_49539DBA029D_var*
begin
//#UC START# *4C7B96FA02DA_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7B96FA02DA_49539DBA029D_impl*
end;//TExTextForm.InsertHyperlink

procedure TExTextForm.GetAttributesFrmAct;
 {* Информация о документе }
//#UC START# *4C7B9EBC01AC_49539DBA029D_var*
//#UC END# *4C7B9EBC01AC_49539DBA029D_var*
begin
//#UC START# *4C7B9EBC01AC_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7B9EBC01AC_49539DBA029D_impl*
end;//TExTextForm.GetAttributesFrmAct

procedure TExTextForm.OpenContentsFrmAct;
 {* Структура документа }
//#UC START# *4C7BA9CB0179_49539DBA029D_var*
//#UC END# *4C7BA9CB0179_49539DBA029D_var*
begin
//#UC START# *4C7BA9CB0179_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BA9CB0179_49539DBA029D_impl*
end;//TExTextForm.OpenContentsFrmAct

procedure TExTextForm.TimeMachineOnOffNew;
 {* Включить Машину времени }
//#UC START# *4C7BD34501EB_49539DBA029D_var*
//#UC END# *4C7BD34501EB_49539DBA029D_var*
begin
//#UC START# *4C7BD34501EB_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BD34501EB_49539DBA029D_impl*
end;//TExTextForm.TimeMachineOnOffNew

procedure TExTextForm.HideShow;
 {* Скрыть/Показать }
//#UC START# *4C7BD3C2000C_49539DBA029D_var*
//#UC END# *4C7BD3C2000C_49539DBA029D_var*
begin
//#UC START# *4C7BD3C2000C_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BD3C2000C_49539DBA029D_impl*
end;//TExTextForm.HideShow

procedure TExTextForm.TimeMachineOnOff;
 {* Включить Машину времени с календарной даты\Выключить Машину времени }
//#UC START# *4C7BD60003B6_49539DBA029D_var*
//#UC END# *4C7BD60003B6_49539DBA029D_var*
begin
//#UC START# *4C7BD60003B6_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BD60003B6_49539DBA029D_impl*
end;//TExTextForm.TimeMachineOnOff

procedure TExTextForm.ShowInfo;
 {* Показать текст предупреждения }
//#UC START# *4C7D345C006D_49539DBA029D_var*
//#UC END# *4C7D345C006D_49539DBA029D_var*
begin
//#UC START# *4C7D345C006D_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D345C006D_49539DBA029D_impl*
end;//TExTextForm.ShowInfo

procedure TExTextForm.ShowInfo;
 {* Показать текст предупреждения }
//#UC START# *4C7D34A903C5_49539DBA029D_var*
//#UC END# *4C7D34A903C5_49539DBA029D_var*
begin
//#UC START# *4C7D34A903C5_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D34A903C5_49539DBA029D_impl*
end;//TExTextForm.ShowInfo

procedure TExTextForm.TimeMachineOnOffNew;
 {* Включить/Выключить Машину времени }
//#UC START# *4C7D34DE02D2_49539DBA029D_var*
//#UC END# *4C7D34DE02D2_49539DBA029D_var*
begin
//#UC START# *4C7D34DE02D2_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D34DE02D2_49539DBA029D_impl*
end;//TExTextForm.TimeMachineOnOffNew

procedure TExTextForm.ShowInfo;
 {* Показать текст предупреждения }
//#UC START# *4C7D354603D3_49539DBA029D_var*
//#UC END# *4C7D354603D3_49539DBA029D_var*
begin
//#UC START# *4C7D354603D3_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D354603D3_49539DBA029D_impl*
end;//TExTextForm.ShowInfo

procedure TExTextForm.GetTypedCorrespondentList;
 {* Ссылки на фрагмент (вид информации) }
//#UC START# *4C7D362C01B2_49539DBA029D_var*
//#UC END# *4C7D362C01B2_49539DBA029D_var*
begin
//#UC START# *4C7D362C01B2_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D362C01B2_49539DBA029D_impl*
end;//TExTextForm.GetTypedCorrespondentList

procedure TExTextForm.UserCR1;
 {* Пользовательские ссылки на документ (ссылки из документа) 1 }
//#UC START# *4C7D36900317_49539DBA029D_var*
//#UC END# *4C7D36900317_49539DBA029D_var*
begin
//#UC START# *4C7D36900317_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D36900317_49539DBA029D_impl*
end;//TExTextForm.UserCR1

procedure TExTextForm.UserCR2;
 {* Пользовательские ссылки на документ (ссылки из документа) 2 }
//#UC START# *4C7D36C40097_49539DBA029D_var*
//#UC END# *4C7D36C40097_49539DBA029D_var*
begin
//#UC START# *4C7D36C40097_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D36C40097_49539DBA029D_impl*
end;//TExTextForm.UserCR2

procedure TExTextForm.AddToControl;
 {* Поставить на контроль }
//#UC START# *4C7D39A7029B_49539DBA029D_var*
//#UC END# *4C7D39A7029B_49539DBA029D_var*
begin
//#UC START# *4C7D39A7029B_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D39A7029B_49539DBA029D_impl*
end;//TExTextForm.AddToControl

procedure TExTextForm.PrintPreview;
//#UC START# *4C879306001C_49539DBA029D_var*
//#UC END# *4C879306001C_49539DBA029D_var*
begin
//#UC START# *4C879306001C_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C879306001C_49539DBA029D_impl*
end;//TExTextForm.PrintPreview

procedure TExTextForm.Select;
//#UC START# *4C87931D00FC_49539DBA029D_var*
//#UC END# *4C87931D00FC_49539DBA029D_var*
begin
//#UC START# *4C87931D00FC_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C87931D00FC_49539DBA029D_impl*
end;//TExTextForm.Select

procedure TExTextForm.ViewChangedFragments;
 {* Обзор изменений документа }
//#UC START# *4DDCBABC03B7_49539DBA029D_var*
//#UC END# *4DDCBABC03B7_49539DBA029D_var*
begin
//#UC START# *4DDCBABC03B7_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDCBABC03B7_49539DBA029D_impl*
end;//TExTextForm.ViewChangedFragments

procedure TExTextForm.UpdateSubPanel;
//#UC START# *4DF20436002A_49539DBA029D_var*
//#UC END# *4DF20436002A_49539DBA029D_var*
begin
//#UC START# *4DF20436002A_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DF20436002A_49539DBA029D_impl*
end;//TExTextForm.UpdateSubPanel

procedure TExTextForm.OpenRedactionListFrmAct;
 {* Список редакций }
//#UC START# *4ED8CF5700E7_49539DBA029D_var*
//#UC END# *4ED8CF5700E7_49539DBA029D_var*
begin
//#UC START# *4ED8CF5700E7_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ED8CF5700E7_49539DBA029D_impl*
end;//TExTextForm.OpenRedactionListFrmAct

procedure TExTextForm.GoToIntranet;
//#UC START# *4F184B42019E_49539DBA029D_var*
//#UC END# *4F184B42019E_49539DBA029D_var*
begin
//#UC START# *4F184B42019E_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F184B42019E_49539DBA029D_impl*
end;//TExTextForm.GoToIntranet

procedure TExTextForm.Open;
 {* Открыть в текущем окне }
//#UC START# *4F672A7903C1_49539DBA029D_var*
//#UC END# *4F672A7903C1_49539DBA029D_var*
begin
//#UC START# *4F672A7903C1_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F672A7903C1_49539DBA029D_impl*
end;//TExTextForm.Open

procedure TExTextForm.OpenNewWindow;
 {* Открыть в новом окне }
//#UC START# *4F672A9C0083_49539DBA029D_var*
//#UC END# *4F672A9C0083_49539DBA029D_var*
begin
//#UC START# *4F672A9C0083_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F672A9C0083_49539DBA029D_impl*
end;//TExTextForm.OpenNewWindow

function TExTextForm.GetBaseSearchPresentation: InsBaseSearchPresentation;
//#UC START# *5072D45A035C_49539DBA029D_var*
//#UC END# *5072D45A035C_49539DBA029D_var*
begin
//#UC START# *5072D45A035C_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5072D45A035C_49539DBA029D_impl*
end;//TExTextForm.GetBaseSearchPresentation

procedure TExTextForm.SelectWord;
//#UC START# *528777B1010F_49539DBA029D_var*
//#UC END# *528777B1010F_49539DBA029D_var*
begin
//#UC START# *528777B1010F_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *528777B1010F_49539DBA029D_impl*
end;//TExTextForm.SelectWord

procedure TExTextForm.SelectPara;
//#UC START# *528777C803B4_49539DBA029D_var*
//#UC END# *528777C803B4_49539DBA029D_var*
begin
//#UC START# *528777C803B4_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *528777C803B4_49539DBA029D_impl*
end;//TExTextForm.SelectPara

procedure TExTextForm.OpenRedactionGlobalLink(const aDocument: IDocument;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour);
//#UC START# *53A303BE03A8_49539DBA029D_var*

 function lp_GetDocumentRedactionID(const aDoc: IDocument): TRedactionID;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=477628351 *)
 var
  l_DocState: IDocumentState;
  l_DocRedactionInfo: TRedactionInfo;
 begin
   Assert(aDoc <> nil);
   aDoc.GetCurrentState(l_DocState);
   Assert(l_DocState <> nil);
   try
    l_DocState.GetCurrentRedaction(l_DocRedactionInfo);
    Result := l_DocRedactionInfo.rID;
   finally
    l_DocState := nil;
    Finalize(l_DocRedactionInfo);
   end;//try..finally
 end;//lp_GetDocumentRedactionID

 function lp_GetDocumentRedactionIndex(const aDoc: IDocument; aRedactionID: TRedactionID): Integer;
 //http://mdp.garant.ru/pages/viewpage.action?pageId=477628351
 var
  l_RedactionItemInfo: TRedactionInfo;
  l_RedactionList: IRedactionInfoList;
  l_Index: Integer;
 begin
  aDoc.GetRedactionsList(l_RedactionList);
  try
   for l_Index := 0 to l_RedactionList.Count - 1 do
   begin
    l_RedactionList.pm_GetItem(l_Index, l_RedactionItemInfo);
    try
     if (l_RedactionItemInfo.rID = aRedactionID) then
     begin
      Result := l_Index;
      Exit;
     end;//if (l_RedactionItemInfo.rID = aRedactionID)
    finally
     Finalize(l_RedactionItemInfo);
    end;//try..finally
   end;//for l_Index := 0 to l_RedactionList.Count - 1
  finally
   l_RedactionList := nil;
  end;//try..finally
 end;//lp_GetDocumentRedactionIndex

const
 cOpenKindMap : array[TbsProcessHyperLinkBehaviour] of TvcmMainFormOpenKind = (vcm_okInCurrentTab,
  vcm_okInNewTab, vcm_okInNewTab, vcm_okInNewWindow);
var
 l_Block: Tl3Variant;
 l_Ob: InevObject;
 l_Para: IeeLeafPara;
 l_CurrentRedactionIndex: Integer;
 l_AnotherRedactionIndex: Integer;
 l_ActiveElement: InevActiveElement;
 l_LeftDocument: IDocument;
 l_RightDocument: IDocument;
 l_LP : InevLeafPara;
 l_Cont: IvcmContainer;
 l_JumpToText: Boolean; // перход в текст документа или в сравнение. 513615258
//#UC END# *53A303BE03A8_49539DBA029D_var*
begin
//#UC START# *53A303BE03A8_49539DBA029D_impl*
 // Сравнение редакций будет строиться между редакцией документа, из которого
 // ведет гиперссылка и редакцией документа, переданного в aDocument.
 // В него ведет ссылка.
 // http://mdp.garant.ru/pages/viewpage.action?pageId=476811628
 Assert(HyperlinkDocument <> nil);
 //http://mdp.garant.ru/pages/viewpage.action?pageId=477628351
 l_CurrentRedactionIndex := lp_GetDocumentRedactionIndex(HyperlinkDocument,
                                                         lp_GetDocumentRedactionID(aDocument));
 Assert(aDocument <> nil);
 l_AnotherRedactionIndex := lp_GetDocumentRedactionIndex(HyperlinkDocument,
                                                         lp_GetDocumentRedactionID(HyperlinkDocument));

 // перход в текст документа или в сравнение. 513615258
 l_JumpToText := Settings.LoadBoolean(pi_Document_ShowVersionCommentsLinkBehaviour,
                                     dv_Document_ShowVersionCommentsLinkBehaviour);

 if TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs then
  l_Cont := nsOpenNewWindowTabbed(NativeMainForm, cOpenKindMap[aBehaviour])
 else
 if (aBehaviour = phbInNewWindow) then
  l_Cont := nsOpenNewWindowParams(NativeMainForm)
 else
  l_Cont := nil;
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=557299523
  
 // Теперь для позиционирования в СР передаем TbsDocPos с указанием номера
 // блока/саба, а параграф нужен для определения места в документе, куда
 // нужно вернуться
 // http://mdp.garant.ru/pages/viewpage.action?pageId=476379343
 // http://mdp.garant.ru/pages/viewpage.action?pageId=475141260
 l_ActiveElement := (Text as TevCustomEditorWindow).ActiveElement;
 try
  // В данных ссылка на редакцию в обычном параграфе - откроем саму редакцию, без СР
  // http://mdp.garant.ru/pages/viewpage.action?pageId=495139252
  if (l_ActiveElement <> nil) and (l_ActiveElement.Para.AsObject.IntA[k2_tiStyle] <> ev_saVersionInfo) then
  begin
   TdmStdRes.OpenDocument(TdeDocInfo.Make(aDocument, TbsDocPos_C(dptSub, aSub)), l_Cont);
   Exit;
  end;//if (l_ActiveElement <> nil)
  if Assigned(l_ActiveElement) and
   evInPara(l_ActiveElement.Para.AsObject, k2_typBlock, l_Block) then
  begin
   l_Block.Child[0].QT(InevObject, l_Ob);
   l_LP := EvFindNumberedPara(l_Ob);
   if (l_LP = nil) then
    l_Para := TeeLeafPara.Make(nil, Text) as IeeLeafPara
   else
    l_Para := TeeLeafPara.Make(l_LP.AsObject, Text) as IeeLeafPara;
  end//if Assigned(l_ActiveElement)
  else
   l_Para := TeeLeafPara.Make((Text as TevCustomEditorWindow).Selection.Cursor.MostInner.Obj^.AsObject, Text) as IeeLeafPara;
 finally
  l_ActiveElement := nil;
 end;//try..finally
 try
  //Коллеги, я прошу прощения, а можно добавить еще уточнение, что выбор окна в сравнении, куда надо помещать
  //текущую редакцию, зависит от того, со старой редакцией будет сравнение, или с будущей. Если со старой -
  //текущая должна быть в правом окне. Если с будущей - в левом. Чтобы не отличалось от стандартного сравнения/
  // http://mdp.garant.ru/pages/viewpage.action?pageId=453155865
  if (l_CurrentRedactionIndex > l_AnotherRedactionIndex) then
  begin
   l_LeftDocument := aDocument;
   l_RightDocument := HyperlinkDocument;
  end//if (l_CurrentRedactionIndex > l_AnotherRedactionIndex) 
  else
  if (l_CurrentRedactionIndex < l_AnotherRedactionIndex) then
  begin
   l_LeftDocument := HyperlinkDocument;
   l_RightDocument := aDocument;
  end//if (l_CurrentRedactionIndex < l_AnotherRedactionIndex)
  else
   Assert(False, 'Для построения СР поданы два экземпляра одной и той же редакции документа');

  if l_JumpToText // перход в текст документа или в сравнение. 513615258
   then TdmStdRes.OpenDocument(TdeDocInfo.Make(aDocument, TbsDocPos_C(dptSub, aSub)), l_Cont)
   else TdmStdRes.MakeCompareEditions(l_LeftDocument, l_RightDocument, TbsDocPos_C(dptSub, aSub), HyperlinkDocument, l_Para, l_Cont);
 finally
  l_Para := nil;
  l_LeftDocument := nil;
  l_RightDocument := nil;
 end;//try..finally
//#UC END# *53A303BE03A8_49539DBA029D_impl*
end;//TExTextForm.OpenRedactionGlobalLink

procedure TExTextForm.OpenNewTab;
 {* Открыть в новой вкладке }
//#UC START# *53DF276802DD_49539DBA029D_var*
//#UC END# *53DF276802DD_49539DBA029D_var*
begin
//#UC START# *53DF276802DD_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *53DF276802DD_49539DBA029D_impl*
end;//TExTextForm.OpenNewTab

procedure TExTextForm.TabBecomeActive;
//#UC START# *54868B67034A_49539DBA029D_var*
//#UC END# *54868B67034A_49539DBA029D_var*
begin
//#UC START# *54868B67034A_49539DBA029D_impl*
 UpdateSubPanelDescription;
//#UC END# *54868B67034A_49539DBA029D_impl*
end;//TExTextForm.TabBecomeActive

procedure TExTextForm.TabBecomeInactive;
//#UC START# *54868B84029F_49539DBA029D_var*
//#UC END# *54868B84029F_49539DBA029D_var*
begin
//#UC START# *54868B84029F_49539DBA029D_impl*
 // ничего не делаем
//#UC END# *54868B84029F_49539DBA029D_impl*
end;//TExTextForm.TabBecomeInactive

procedure TExTextForm.CommonDocumentOpenNewTab;
//#UC START# *55545C63026E_49539DBA029D_var*
//#UC END# *55545C63026E_49539DBA029D_var*
begin
//#UC START# *55545C63026E_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *55545C63026E_49539DBA029D_impl*
end;//TExTextForm.CommonDocumentOpenNewTab

procedure TExTextForm.GetSimilarDocsToBlock;
//#UC START# *5587AA310201_49539DBA029D_var*
//#UC END# *5587AA310201_49539DBA029D_var*
begin
//#UC START# *5587AA310201_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5587AA310201_49539DBA029D_impl*
end;//TExTextForm.GetSimilarDocsToBlock

procedure TExTextForm.dftDrugSynchroViewQueryOpen(aSender: TObject);
 {* Обработчик события dftDrugSynchroView.OnQueryOpen }
//#UC START# *664D52829DD3_49539DBA029D_var*
//#UC END# *664D52829DD3_49539DBA029D_var*
begin
//#UC START# *664D52829DD3_49539DBA029D_impl*
 if HasDoc then
  OpenInWindow(False);
//#UC END# *664D52829DD3_49539DBA029D_impl*
end;//TExTextForm.dftDrugSynchroViewQueryOpen

procedure TExTextForm.dftDictSubEntryQueryClose(aSender: TObject);
 {* Обработчик события dftDictSubEntry.OnQueryClose }
//#UC START# *701BC3512B2B_49539DBA029D_var*
//#UC END# *701BC3512B2B_49539DBA029D_var*
begin
//#UC START# *701BC3512B2B_49539DBA029D_impl*
 DoSwitchToFirstTab;
//#UC END# *701BC3512B2B_49539DBA029D_impl*
end;//TExTextForm.dftDictSubEntryQueryClose

procedure TExTextForm.dftTranslationQueryClose(aSender: TObject);
 {* Обработчик события dftTranslation.OnQueryClose }
//#UC START# *7401AD950C39_49539DBA029D_var*
//#UC END# *7401AD950C39_49539DBA029D_var*
begin
//#UC START# *7401AD950C39_49539DBA029D_impl*
 DoSwitchToFirstTab;
//#UC END# *7401AD950C39_49539DBA029D_impl*
end;//TExTextForm.dftTranslationQueryClose

procedure TExTextForm.dftChronologyQueryClose(aSender: TObject);
 {* Обработчик события dftChronology.OnQueryClose }
//#UC START# *8418208BCCA0_49539DBA029D_var*
//#UC END# *8418208BCCA0_49539DBA029D_var*
begin
//#UC START# *8418208BCCA0_49539DBA029D_impl*
 DoSwitchToFirstTab;
//#UC END# *8418208BCCA0_49539DBA029D_impl*
end;//TExTextForm.dftChronologyQueryClose

procedure TExTextForm.dftDrugSynchroViewQueryMaximized(aSender: TObject);
 {* Обработчик события dftDrugSynchroView.OnQueryMaximized }
//#UC START# *8A8A353C1A57_49539DBA029D_var*
//#UC END# *8A8A353C1A57_49539DBA029D_var*
begin
//#UC START# *8A8A353C1A57_49539DBA029D_impl*
 if HasDoc then
  OpenInWindow;
//#UC END# *8A8A353C1A57_49539DBA029D_impl*
end;//TExTextForm.dftDrugSynchroViewQueryMaximized

procedure TExTextForm.dftAnnotationQueryClose(aSender: TObject);
 {* Обработчик события dftAnnotation.OnQueryClose }
//#UC START# *918005C1AFE3_49539DBA029D_var*
//#UC END# *918005C1AFE3_49539DBA029D_var*
begin
//#UC START# *918005C1AFE3_49539DBA029D_impl*
 DoSwitchToFirstTab;
//#UC END# *918005C1AFE3_49539DBA029D_impl*
end;//TExTextForm.dftAnnotationQueryClose

procedure TExTextForm.dftDocSynchroViewQueryMaximized(aSender: TObject);
 {* Обработчик события dftDocSynchroView.OnQueryMaximized }
//#UC START# *931EEB23421A_49539DBA029D_var*
//#UC END# *931EEB23421A_49539DBA029D_var*
begin
//#UC START# *931EEB23421A_49539DBA029D_impl*
 if HasDoc then
  OpenInWindow;
//#UC END# *931EEB23421A_49539DBA029D_impl*
end;//TExTextForm.dftDocSynchroViewQueryMaximized

procedure TExTextForm.dftRelatedDocQueryClose(aSender: TObject);
 {* Обработчик события dftRelatedDoc.OnQueryClose }
//#UC START# *A2BF852CD6C7_49539DBA029D_var*
//#UC END# *A2BF852CD6C7_49539DBA029D_var*
begin
//#UC START# *A2BF852CD6C7_49539DBA029D_impl*
 DoSwitchToFirstTab;
//#UC END# *A2BF852CD6C7_49539DBA029D_impl*
end;//TExTextForm.dftRelatedDocQueryClose

procedure TExTextForm.dftTranslationQueryOpen(aSender: TObject);
 {* Обработчик события dftTranslation.OnQueryOpen }
//#UC START# *AF0C9051AEEF_49539DBA029D_var*
//#UC END# *AF0C9051AEEF_49539DBA029D_var*
begin
//#UC START# *AF0C9051AEEF_49539DBA029D_impl*
 if HasDoc then
  OpenInWindow(False);
//#UC END# *AF0C9051AEEF_49539DBA029D_impl*
end;//TExTextForm.dftTranslationQueryOpen

procedure TExTextForm.dftDocSynchroViewQueryOpen(aSender: TObject);
 {* Обработчик события dftDocSynchroView.OnQueryOpen }
//#UC START# *BB5471A3EA8E_49539DBA029D_var*
//#UC END# *BB5471A3EA8E_49539DBA029D_var*
begin
//#UC START# *BB5471A3EA8E_49539DBA029D_impl*
 if HasDoc then
  OpenInWindow(False);
//#UC END# *BB5471A3EA8E_49539DBA029D_impl*
end;//TExTextForm.dftDocSynchroViewQueryOpen

procedure TExTextForm.dftMedicFirmSynchroViewQueryOpen(aSender: TObject);
 {* Обработчик события dftMedicFirmSynchroView.OnQueryOpen }
//#UC START# *FD0B95191C1E_49539DBA029D_var*
//#UC END# *FD0B95191C1E_49539DBA029D_var*
begin
//#UC START# *FD0B95191C1E_49539DBA029D_impl*
 if HasDoc then
  OpenInWindow(False);
//#UC END# *FD0B95191C1E_49539DBA029D_impl*
end;//TExTextForm.dftMedicFirmSynchroViewQueryOpen

{$If NOT Defined(NoVCL)}
procedure TExTextForm.WndProc(var Message: TMessage);
//#UC START# *47E136A80191_49539DBA029D_var*
//#UC END# *47E136A80191_49539DBA029D_var*
begin
//#UC START# *47E136A80191_49539DBA029D_impl*
 if Message.Msg = g_GoToIntranetMessage then
  GoToIntranet
 else
  inherited WndProc(Message);
//#UC END# *47E136A80191_49539DBA029D_impl*
end;//TExTextForm.WndProc
{$IfEnd} // NOT Defined(NoVCL)

procedure TExTextForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_49539DBA029D_var*

 function lp_ShowMessage: Boolean;
 begin
  Result := (UserType = dftDocument) and
     Assigned(ViewArea) and
     Assigned(ViewArea.DocInfo) and
    (not Assigned(ViewArea.DocInfo.Doc) or
     not ViewArea.DocInfo.Doc.IsAlive);
 end;//function lp_ShowMessage: Boolean;

//#UC END# *47EA4E9002C6_49539DBA029D_var*
begin
//#UC START# *47EA4E9002C6_49539DBA029D_impl*
 inherited;
 if lp_ShowMessage then
  TbsDocumentMissingMessage.Show;
//#UC END# *47EA4E9002C6_49539DBA029D_impl*
end;//TExTextForm.FinishDataUpdate

function TExTextForm.DoSettingChanged(const aSettingId: TafwSettingId): Boolean;
 {* Обработчик изменения указанной настройки }
//#UC START# *47EA863A035C_49539DBA029D_var*
//#UC END# *47EA863A035C_49539DBA029D_var*
begin
//#UC START# *47EA863A035C_49539DBA029D_impl*
 Result := False;
 if (aSettingId = pi_Document_PermanentSelection) then
 begin
  Text.PersistentSelection :=
   Settings.LoadBoolean(pi_Document_PermanentSelection,
                        dv_Document_PermanentSelection);
  Result := True;
 end//aSettingId = pi_Document_PermanentSelection
 else
 if (aSettingId = pi_Document_ShowBlockBorders) then
 begin
  Text.ShowDocumentParts := Settings.LoadBoolean(pi_Document_ShowBlockBorders,
                                                 dv_Document_ShowBlockBorders);
  Result := True;
 end//aSettingId = pi_Document_ShowBlockBorders
 else
 if (aSettingId = pi_Document_ShowSpecial) then
 begin
  Text.DrawSpecial := Settings.LoadBoolean(pi_Document_ShowSpecial,
                                           dv_Document_ShowSpecial);
  Result := True;
 end//aSettingId = pi_Document_ShowSpecial
 else
 if (aSettingId = pi_Document_SubPanel_ShowBlocks) or
    (aSettingId = pi_Document_SubPanel_ShowBookmarks) or
    (aSettingId = pi_Document_SubPanel_ShowJurorComments) or
    (aSettingId = pi_Document_SubPanel_ShowUserComments) or
    (aSettingId = pi_Document_SubPanel_ShowSubNumbers) then
 begin
  UpdateSubPanelDescription;
  Result := True;
 end//aSettingId = pi_Document_SubPanel_ShowBlocks..
 else
 if (aSettingId = pi_Document_ShowTechComment) then
 begin
  UpdateTechComment;
  Result := True;
 end;//aSettingId = pi_Document_ShowTechComment
//#UC END# *47EA863A035C_49539DBA029D_impl*
end;//TExTextForm.DoSettingChanged

procedure TExTextForm.SettingsReplaceFinish;
//#UC START# *47EA8B9601FE_49539DBA029D_var*
//#UC END# *47EA8B9601FE_49539DBA029D_var*
begin
//#UC START# *47EA8B9601FE_49539DBA029D_impl*
 inherited;
 DoSettingsChanged;
//#UC END# *47EA8B9601FE_49539DBA029D_impl*
end;//TExTextForm.SettingsReplaceFinish

{$If NOT Defined(NoVCM)}
procedure TExTextForm.Copy;
 {* Копировать }
//#UC START# *4951284902BD_49539DBA029D_var*
//#UC END# *4951284902BD_49539DBA029D_var*
begin
//#UC START# *4951284902BD_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4951284902BD_49539DBA029D_impl*
end;//TExTextForm.Copy
{$IfEnd} // NOT Defined(NoVCM)

procedure TExTextForm.UserSettingsChanged;
 {* Изменились настройки пользователя }
//#UC START# *4958BE910345_49539DBA029D_var*
//#UC END# *4958BE910345_49539DBA029D_var*
begin
//#UC START# *4958BE910345_49539DBA029D_impl*
 inherited;
 DoSettingsChanged;
//#UC END# *4958BE910345_49539DBA029D_impl*
end;//TExTextForm.UserSettingsChanged

{$If NOT Defined(NoVCM)}
procedure TExTextForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_49539DBA029D_var*
var
 l_Doc: IDocument;
 l_Caption: Il3CString;
//#UC END# *497469C90140_49539DBA029D_var*
begin
//#UC START# *497469C90140_49539DBA029D_impl*
 inherited;
 if (aNew <> nil) then
 begin
  CheckLinkedWindows;
  if (dsBaseDocument <> nil) AND (dsBaseDocument.DocInfo <> nil) then
   l_Doc := dsBaseDocument.DocInfo.Doc;
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=590755363
  // Нужно проставить Caption, иначе при открытии документа в новой вкладке без
  // переключения на нее заголовок у формы будет неправильный до тех пор,
  // пока не позовется TextSourceDocumentChanged, т.е. пока пользователь сам
  // не переключит вкладку. http://mdp.garant.ru/pages/viewpage.action?pageId=340174500
  if (l_Doc <> nil) then
  try
   UpdateDocumentCaption(l_Doc);
  finally
   l_Doc := nil;
  end;//try..finally
 end;//if (aNew <> nil)...

 if Assigned(ViewArea) then
  Text.IsStaticText := ViewArea.IsReadOnly; // скорее всего это должно быть не здесь или не так.
                                            // http://mdp.garant.ru/pages/viewpage.action?pageId=401506914
//#UC END# *497469C90140_49539DBA029D_impl*
end;//TExTextForm.NotifyDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TExTextForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_49539DBA029D_var*
//#UC END# *49803F5503AA_49539DBA029D_var*
begin
//#UC START# *49803F5503AA_49539DBA029D_impl*
 inherited;
 nsWarnImages;
 f_LastBookmarkIndex := -1;
 f_InGoToInternet := False;
 LoadFromSettings;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=290953654
(* with SubPanel do
 begin
  if (UserType in [dftDocument, dftDrug]) then
   SubDescriptors := nsDocumentRes.SubDescriptors
  else
   SubDescriptors := nsDocumentRes.LiteSubDescriptors;
 end;//with SubPanel do*)
 //LoadFromSettings;
 // - перенесено выше
 // http://mdp.garant.ru/pages/viewpage.action?pageId=290953654
//#UC END# *49803F5503AA_49539DBA029D_impl*
end;//TExTextForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TExTextForm.DoSaveState(out theState: IvcmBase;
 aStateType: TvcmStateType;
 aForClone: Boolean): Boolean;
 {* Сохраняет состояние формы. Для перекрытия в потомках }
//#UC START# *49806ED503D5_49539DBA029D_var*
var
 l_InnerState: IvcmBase;
 l_State: IExTextFormState;
//#UC END# *49806ED503D5_49539DBA029D_var*
begin
//#UC START# *49806ED503D5_49539DBA029D_impl*
 Result := inherited DoSaveState(l_InnerState, aStateType, aForClone);
 l_State := TExTextFormState.Make(l_InnerState,
   Text.ShowUserComments,
   Text.ShowComments,
   Text.ShowVersionComments,
   f_eeSubIdForTypedCorrespondentList);
 theState := l_State;
//#UC END# *49806ED503D5_49539DBA029D_impl*
end;//TExTextForm.DoSaveState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TExTextForm.DoLoadState(const aState: IvcmBase;
 aStateType: TvcmStateType): Boolean;
 {* Загружает состояние формы. Для перекрытия в потомках }
//#UC START# *49807428008C_49539DBA029D_var*
var
 l_State: IExTextFormState;
//#UC END# *49807428008C_49539DBA029D_var*
begin
//#UC START# *49807428008C_49539DBA029D_impl*
 if Supports(aState, IExTextFormState, l_State) then
 begin
  Text.ShowUserComments := l_State.NeedShowUserComments;
  Text.ShowComments := l_State.NeedShowComments;
  Text.ShowVersionComments := l_State.NeedShowVersionComments;
  f_eeSubIdForTypedCorrespondentList := l_State.eeSubIdForTypedCorrespondentList;
  Result := inherited DoLoadState(aState, aStateType);

  // Ниже следует кошмар, который нужен для того, чтобы Text.ShowUserComments
  // не проставился принудительно в True в InvalidateDataSources,
  // где проверяют флажки "FromHistory" и "NeedProcess"
  // на вот этом самом FormDataChangedInfo.
  // http://mdp.garant.ru/pages/viewpage.action?pageId=609420481
  FormDataChangedInfo.Init(True);
  FormDataChangedInfo.NeedProcess := True;
 end
 else
 begin
  Assert(False);
  Result := inherited DoLoadState(aState, aStateType);
 end;
//#UC END# *49807428008C_49539DBA029D_impl*
end;//TExTextForm.DoLoadState
{$IfEnd} // NOT Defined(NoVCM)

function TExTextForm.CanAddToControl: Boolean;
 {* Можно ли поставить на контроль }
//#UC START# *4988675A0308_49539DBA029D_var*
//#UC END# *4988675A0308_49539DBA029D_var*
begin
//#UC START# *4988675A0308_49539DBA029D_impl*
 Result := (UserType = dftDocument);
//#UC END# *4988675A0308_49539DBA029D_impl*
end;//TExTextForm.CanAddToControl

{$If NOT Defined(NoVCM)}
procedure TExTextForm.SetPositionByDS;
 {* Вызывается когда нужно изменить позицию используя источник данных. [$136258455] }
//#UC START# *498953170108_49539DBA029D_var*
//#UC END# *498953170108_49539DBA029D_var*
begin
//#UC START# *498953170108_49539DBA029D_impl*
 inherited;
 ChangePositionByDataSource;
//#UC END# *498953170108_49539DBA029D_impl*
end;//TExTextForm.SetPositionByDS
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TExTextForm.Paste;
 {* Вставка }
//#UC START# *49EDFA3701B0_49539DBA029D_var*
//#UC END# *49EDFA3701B0_49539DBA029D_var*
begin
//#UC START# *49EDFA3701B0_49539DBA029D_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFA3701B0_49539DBA029D_impl*
end;//TExTextForm.Paste
{$IfEnd} // NOT Defined(NoVCM)

function TExTextForm.DoMakeLinkDocInfo(const aDocument: IDocument;
 aPointType: TDocumentPositionType;
 aSub: Cardinal): IdeDocInfo;
//#UC START# *4A815FB3005D_49539DBA029D_var*
//#UC END# *4A815FB3005D_49539DBA029D_var*
begin
//#UC START# *4A815FB3005D_49539DBA029D_impl*
 Assert(ViewArea <> nil);
 Result := ViewArea.MakeGotoPointData(aDocument, aPointType, aSub);
//#UC END# *4A815FB3005D_49539DBA029D_impl*
end;//TExTextForm.DoMakeLinkDocInfo

function TExTextForm.DoProcessLocalLink(const aDocument: IDocument;
 aPointType: TDocumentPositionType;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
 {* Обработка локальных ссылок }
//#UC START# *4A8160720125_49539DBA029D_var*
//#UC END# *4A8160720125_49539DBA029D_var*
begin
//#UC START# *4A8160720125_49539DBA029D_impl*
 Result := false;
 if (UserType in [dftDocSynchroView,
                  dftRelatedSynchroView,
                  dftMedicFirmSynchroView] +
                 [dftAACLeft,
                  dftAACRight,
                  dftAACContentsLeft,
                  dftAACContentsRight])
                 // - в ААК по-любому надо открывать НОВЫЙ прецедент
                 //   т.к. может перегрузится либо правая, либо левая половины
                 //   документа 
  then
  Exit;
 if aDocument.GetDocType = DT_BOOK then
  Exit;
 Result := inherited DoProcessLocalLink(aDocument, aPointType, aSub, aBehaviour);
//#UC END# *4A8160720125_49539DBA029D_impl*
end;//TExTextForm.DoProcessLocalLink

{$If NOT Defined(NoVCM)}
function TExTextForm.NeedDrawCaption: Boolean;
 {* Нужно ли рисовать заголовок зоны }
//#UC START# *4A84183701B9_49539DBA029D_var*
//#UC END# *4A84183701B9_49539DBA029D_var*
begin
//#UC START# *4A84183701B9_49539DBA029D_impl*
 Result := not (UserType in [dftAACLeft,
                             dftAACRight,
                             dftAACContentsLeft,
                             dftAACContentsRight]);
//#UC END# *4A84183701B9_49539DBA029D_impl*
end;//TExTextForm.NeedDrawCaption
{$IfEnd} // NOT Defined(NoVCM)

function TExTextForm.NeedsStatusBarItems: Boolean;
 {* Определяет, что операции в статусной строке таки надо публиковать }
//#UC START# *4A8E5CEC021F_49539DBA029D_var*
//#UC END# *4A8E5CEC021F_49539DBA029D_var*
begin
//#UC START# *4A8E5CEC021F_49539DBA029D_impl*
 Result := GetNeedsStatusBarItems;
//#UC END# *4A8E5CEC021F_49539DBA029D_impl*
end;//TExTextForm.NeedsStatusBarItems

{$If NOT Defined(NoVCM)}
procedure TExTextForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_49539DBA029D_var*
//#UC END# *4A8E8F2E0195_49539DBA029D_var*
begin
//#UC START# *4A8E8F2E0195_49539DBA029D_impl*
 inherited;
 TextSource.OnMakeDocumentContainer := TextSourceMakeDocumentContainer;
 TextSource.OnDocumentChanged := TextSourceDocumentChanged;
 TextSource.OnTOCCreated := Self.TextSourceTOCCreated;
 SubPanel.Color := clWhite;
 Text.LeftIndentDelta := 7{2};
                      // ^ http://mdp.garant.ru/pages/viewpage.action?pageId=294590299
 Text.OnFocusViaMouseSet := Self.DoFocusViaMouseSet;
 Text.OnHistory := Self.OnHistoryState;
 Assert(not Assigned(Text.OnHyperlinkNavigate));
 Text.OnHyperlinkNavigate := Self.DoHyperlinkNavigate;
 Text.OnZOrderChanging := Self.DoTextZOrderChanging;
//#UC END# *4A8E8F2E0195_49539DBA029D_impl*
end;//TExTextForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

procedure TExTextForm.VersionCommentsVisibleInvertedByUser(NewState: Boolean);
//#UC START# *4AAA150A0244_49539DBA029D_var*
//#UC END# *4AAA150A0244_49539DBA029D_var*
begin
//#UC START# *4AAA150A0244_49539DBA029D_impl*
 TnsSwitchVersionCommentsEvent.Log(NewState);
//#UC END# *4AAA150A0244_49539DBA029D_impl*
end;//TExTextForm.VersionCommentsVisibleInvertedByUser

{$If NOT Defined(NoVCM)}
function TExTextForm.DoGetTabInfo(out theCaption: Il3CString;
 out theItemIndex: Integer): Boolean;
 {* Информация о закладке, в которую вставляется форма. Для перекрытия в потомках }
//#UC START# *4AC497FD00A2_49539DBA029D_var*
//#UC END# *4AC497FD00A2_49539DBA029D_var*
begin
//#UC START# *4AC497FD00A2_49539DBA029D_impl*
 Result := not (UserType in [dftNone,
                             dftDocument,
                             dftRelatedDoc,
                             dftDocSynchroView,
                             dftRelatedSynchroView,
                             dftDictEntry,
                             //dftDictSubEntry,
                             dftAnnotation,
                             //dftAutoreferatAfterSearch,
                             //dftConsultation,
                             dftTranslation,
                             dftAnnotationSynchroView,
                             dftTips,
                             dftMedDictEntry,
                             //dftAutoreferat,
                             //dftDrug,
                             dftMedicFirm,
                             dftMedicFirmSynchroView]);
 if Result then
 begin
  theCaption := GetCurrentCaption;
  theItemIndex := GetCurrentImage;
 end;//UserType in..
//#UC END# *4AC497FD00A2_49539DBA029D_impl*
end;//TExTextForm.DoGetTabInfo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TExTextForm.NeedSetMyFocus: Boolean;
//#UC START# *4B4F13E80365_49539DBA029D_var*
//#UC END# *4B4F13E80365_49539DBA029D_var*
begin
//#UC START# *4B4F13E80365_49539DBA029D_impl*
 Case UserType of
  dftAACContentsLeft:
   Result := true;
  dftAACRight:
   Result := false;
  dftAACContentsRight:
   Result := false;
  dftAACLeft:
   Result := true;
  else
   Result := inherited NeedSetMyFocus;
 end;//Case UserType
//#UC END# *4B4F13E80365_49539DBA029D_impl*
end;//TExTextForm.NeedSetMyFocus
{$IfEnd} // NOT Defined(NoVCM)

procedure TExTextForm.DoDocumentShowTechCommentsExecute;
//#UC START# *4C8DCD3B015C_49539DBA029D_var*
//#UC END# *4C8DCD3B015C_49539DBA029D_var*
begin
//#UC START# *4C8DCD3B015C_49539DBA029D_impl*
 with Settings do
  SaveBoolean(pi_Document_ShowTechComment,
              not LoadBoolean(pi_Document_ShowTechComment,
                              dv_Document_ShowTechComment),
              dv_Document_ShowTechComment);
//#UC END# *4C8DCD3B015C_49539DBA029D_impl*
end;//TExTextForm.DoDocumentShowTechCommentsExecute

function TExTextForm.pm_GetHyperlinkSubID: Integer;
//#UC START# *4CE41B300315_49539DBA029Dget_var*
var
 l_Para : IeePara;
//#UC END# *4CE41B300315_49539DBA029Dget_var*
begin
//#UC START# *4CE41B300315_49539DBA029Dget_impl*
 //Иначе для ААК-Содержания формировались ссылки на Para,
 //из-за чего при открытии ссылки не происходило синхронизации
 //http://mdp.garant.ru/pages/viewpage.action?pageId=401514692
 if (UserType in [dftAACContentsRight, dftAACContentsLeft])
  and Assigned(dsDocument) and Assigned(dsDocument.DocInfo) then
 begin
  if (dsDocument.DocInfo.Pos.rRefType = dptSub) then
   Result := dsDocument.DocInfo.Pos.rPos
  else//(dsDocument.DocInfo.Pos.rRefType = dptSub)
  if (dsDocument.DocInfo.Pos.rRefType = dptPara) then
   Result := Integer(Cardinal(dsDocument.DocInfo.Pos.rPos) OR POSITION_TYPE_PARA_ID);
 end//(UserType in [dftAACContentsRight, dftAACContentsLeft])
 else
 begin
  l_Para := GetParaForPositionning;
  if (l_Para = nil) then
   Result := inherited pm_GetHyperlinkSubID
  else
  begin
   if (l_Para.Subs <> nil) AND (l_Para.Subs.Count > 0) then
    Result := l_Para.Subs.Subs[0].ID
   else
   begin
    Result := l_Para.ID;
    if (Result <> 0) then
     Result := Integer(Cardinal(Result) OR POSITION_TYPE_PARA_ID);
   end;//l_Para.Subs <> nil
  end;//l_Para = nil
 end;
//#UC END# *4CE41B300315_49539DBA029Dget_impl*
end;//TExTextForm.pm_GetHyperlinkSubID

{$If NOT Defined(NoVCM)}
procedure TExTextForm.NotifyUserTypeSet;
//#UC START# *4D78E2BB0211_49539DBA029D_var*
const
 cnAACRightLeftIndentMin = 60;
var
 l_LeftIndent: Integer;
//#UC END# *4D78E2BB0211_49539DBA029D_var*
begin
//#UC START# *4D78E2BB0211_49539DBA029D_impl*
 inherited;
 if (UserType in [dftAACRight, dftAACLeft, dftAACContentsRight, dftAACContentsLeft]) then
  Text.NeedDrawDocumentEdge := False;

 case UserType of
  dftAACContentsLeft:
   begin
    Text.AACLike := nev_aacLeft;
    Text.Color := cAACContentsBackColor;
    Text.RMargin := 0;
    Text.LMargin := 0;
    Text.LeftIndentDelta := 0;
   end;
  dftAACContentsRight:
   begin
    Text.AACLike := nev_aacRight;
    l_LeftIndent := NativeMainForm.AsForm.Get_VCLWinControl.Width * 7 div 100;
    if l_LeftIndent < cnAACRightLeftIndentMin then
     l_LeftIndent := cnAACRightLeftIndentMin;
    Text.LeftIndentDelta := l_LeftIndent - Text.LMargin; // http://mdp.garant.ru/pages/viewpage.action?pageId=388860126
   end;
  dftAACLeft:
   begin
    Text.AACLike := nev_aacTextLeft;
    Text.LeftIndentDelta := 45; // http://mdp.garant.ru/pages/viewpage.action?pageId=390577778
    Text.RMargin := 45;
   end;
  dftAACRight:
   begin
    //Text.LeftIndentDelta := AACTextContainerPrim_Form.LeftIndentDeltaForAACRight;
    Text.AACLike := nev_aacTextRight;
    Text.LeftIndentDelta := 35 - Text.LMargin;
    Text.RMargin := 10;
   end;
 else
  Text.AACLike := nev_aacNone;
 end;
//#UC END# *4D78E2BB0211_49539DBA029D_impl*
end;//TExTextForm.NotifyUserTypeSet
{$IfEnd} // NOT Defined(NoVCM)

procedure TExTextForm.DoSetHyperlinkCallStatus(aValue: Boolean);
 {* Выставляет флаг, определяющий произведенный переход по ссылке }
//#UC START# *4F382E2D01C1_49539DBA029D_var*
//#UC END# *4F382E2D01C1_49539DBA029D_var*
begin
//#UC START# *4F382E2D01C1_49539DBA029D_impl*
 f_HyperlinkCallStatus := aValue;
//#UC END# *4F382E2D01C1_49539DBA029D_impl*
end;//TExTextForm.DoSetHyperlinkCallStatus

{$If NOT Defined(NoVCM)}
procedure TExTextForm.FormInsertedIntoContainer;
//#UC START# *4F7C65380244_49539DBA029D_var*
var
 l_VScroll: TvtScrollBar;
//#UC END# *4F7C65380244_49539DBA029D_var*
begin
//#UC START# *4F7C65380244_49539DBA029D_impl*
 inherited;
 SetFocusToTextInAAC;
 if (UserType in [dftAACRight, dftAACLeft, dftAACContentsRight, dftAACContentsLeft]) then
 begin
  l_VScroll := Op_AACTextContainer_GetVScrollBar.Call(Aggregate, (UserType = dftAACLeft) or (UserType = dftAACContentsLeft));
  if Assigned(l_VScroll) then
   Text.VScrollBar := l_VScroll;
  if (UserType = dftAACRight) then
   Op_AACTextContainer_SetJumpTo.Call(Aggregate, Self.JumpTo);
 end;//UserType in [dftAACRight, dftAACLeft]
//#UC END# *4F7C65380244_49539DBA029D_impl*
end;//TExTextForm.FormInsertedIntoContainer
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TExTextForm.BecomeVisible;
//#UC START# *4F7C808A0349_49539DBA029D_var*
//#UC END# *4F7C808A0349_49539DBA029D_var*
begin
//#UC START# *4F7C808A0349_49539DBA029D_impl*
 inherited;
 SetFocusToTextInAAC;
//#UC END# *4F7C808A0349_49539DBA029D_impl*
end;//TExTextForm.BecomeVisible
{$IfEnd} // NOT Defined(NoVCM)

procedure TExTextForm.ClearFields;
begin
 f_ControlMap := nil;
 f_RecallCreateTOCTree := nil;
 inherited;
end;//TExTextForm.ClearFields

{$If NOT Defined(NoVCM)}
function TExTextForm.GetIsMainObjectForm: Boolean;
//#UC START# *501174B10018_49539DBA029D_var*
//#UC END# *501174B10018_49539DBA029D_var*
begin
//#UC START# *501174B10018_49539DBA029D_impl*
 Case UserType of
  dftAACContentsLeft,
  dftAACRight:
   Result := false;
  dftAACContentsRight,
  dftAACLeft:
   Result := true;
  else
   Result := inherited GetIsMainObjectForm;
 end;//Case UserType
//#UC END# *501174B10018_49539DBA029D_impl*
end;//TExTextForm.GetIsMainObjectForm
{$IfEnd} // NOT Defined(NoVCM)

function TExTextForm.GetBehaviourFromEffects(anEffects: TafwJumpToEffects): TbsProcessHyperLinkBehaviour;
//#UC START# *53A95A1A0073_49539DBA029D_var*
//#UC END# *53A95A1A0073_49539DBA029D_var*
begin
//#UC START# *53A95A1A0073_49539DBA029D_impl*
 Result := inherited GetBehaviourFromEffects(anEffects);
 if UserType = dftAACContentsLeft then
  if Result in [phbInNewTabNoActivate, phbInNewTabActivate, phbInNewWindow] then // вообще, получается, что всегда. Но вдруг появится другое поведение, так что пусть будет с проверкой.
   Result := phbInSameContainer;
//#UC END# *53A95A1A0073_49539DBA029D_impl*
end;//TExTextForm.GetBehaviourFromEffects

function TExTextForm.GetDocumentShortName(const aDoc: IDocument;
 aExportSelection: Boolean): Il3CString;
//#UC START# *53D8E4B702E4_49539DBA029D_var*
//#UC END# *53D8E4B702E4_49539DBA029D_var*
begin
//#UC START# *53D8E4B702E4_49539DBA029D_impl*
 if (UserType in [dftAutoreferat, dftAutoreferatAfterSearch]) then
  Result := nsGetDocumentName(aDoc)
  // - потому что документ ленты прайма отдает теперь совсем короткое имя,
  // без довесков
  // http://mdp.garant.ru/pages/viewpage.action?pageId=569225205
 else
  Result := inherited GetDocumentShortName(aDoc, aExportSelection);
//#UC END# *53D8E4B702E4_49539DBA029D_impl*
end;//TExTextForm.GetDocumentShortName

{$If NOT Defined(NoVCM)}
function TExTextForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_49539DBA029D_var*
//#UC END# *53F1C6EF02C9_49539DBA029D_var*
begin
//#UC START# *53F1C6EF02C9_49539DBA029D_impl*
 Result := f_TabCaption;
//#UC END# *53F1C6EF02C9_49539DBA029D_impl*
end;//TExTextForm.DoGetTabCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TExTextForm.DoGetFormSetTabCaption: IvcmCString;
//#UC START# *54058CBC0182_49539DBA029D_var*
//#UC END# *54058CBC0182_49539DBA029D_var*
begin
//#UC START# *54058CBC0182_49539DBA029D_impl*
 Result := DoGetTabCaption
//#UC END# *54058CBC0182_49539DBA029D_impl*
end;//TExTextForm.DoGetFormSetTabCaption
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TExTextForm.DoGetTabImageIndex: Integer;
//#UC START# *543E3AA801D0_49539DBA029D_var*
//#UC END# *543E3AA801D0_49539DBA029D_var*
begin
//#UC START# *543E3AA801D0_49539DBA029D_impl*
 Result := 0;
 case UserType of
  dftDrug:
   Result := NsTabIconIndex(titDrug);
  dftMedicFirm:
   Result := NsTabIconIndex(titMedicFirm);
  dftConsultation:
   Result := NsTabIconIndex(titConsultation);   
 else
  if (DataSource <> nil) and (DataSource.UseCaseController <> nil) then
   Result := DataSource.UseCaseController.FormSetImageIndex;
 end;
 if (Result <= 0) then
  Result := NsTabIconIndex(titDocumentNormal);
//#UC END# *543E3AA801D0_49539DBA029D_impl*
end;//TExTextForm.DoGetTabImageIndex
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TExTextForm.DoGetCanDefineFormSetIcon: Boolean;
//#UC START# *544609B9032D_49539DBA029D_var*
//#UC END# *544609B9032D_49539DBA029D_var*
begin
//#UC START# *544609B9032D_49539DBA029D_impl*
 Result := (UserType <> dftMedicFirmSynchroView);
//#UC END# *544609B9032D_49539DBA029D_impl*
end;//TExTextForm.DoGetCanDefineFormSetIcon
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

procedure TExTextForm.AfterOpenHyperlinkInNewTab;
//#UC START# *544E049F00F7_49539DBA029D_var*
//#UC END# *544E049F00F7_49539DBA029D_var*
begin
//#UC START# *544E049F00F7_49539DBA029D_impl*
 UpdateSubPanelDescription;
//#UC END# *544E049F00F7_49539DBA029D_impl*
end;//TExTextForm.AfterOpenHyperlinkInNewTab

function TExTextForm.GetParaIDForSaveInWorkJournal: Integer;
//#UC START# *54EED7B70228_49539DBA029D_var*
//#UC END# *54EED7B70228_49539DBA029D_var*
begin
//#UC START# *54EED7B70228_49539DBA029D_impl*
 if Text.HasDocument then
  Result := Inherited GetParaIDFOrSaveInWorkJournal
 else
 if (not f_DocumentLoaded) then
 begin
  // Если документ реально не прогружался - отдаем позицию из DocInfo
  if (sdsBaseDocument <> nil) and
     (sdsBaseDocument.DocInfo <> nil) then
   Result := sdsBaseDocument.DocInfo.Pos.rPos
  else
   Result := 0;
 end;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=589874196 
//#UC END# *54EED7B70228_49539DBA029D_impl*
end;//TExTextForm.GetParaIDForSaveInWorkJournal

function TExTextForm.NeedSaveInWorkJournal: Boolean;
//#UC START# *54EED7DF0249_49539DBA029D_var*
//#UC END# *54EED7DF0249_49539DBA029D_var*
begin
//#UC START# *54EED7DF0249_49539DBA029D_impl*
 Result := Inherited NeedSaveInWorkJournal and
           (Text.HasDocument or
            ((not f_DocumentLoaded) and
            (sdsBaseDocument <> nil) and
            (sdsBaseDocument.DocInfo <> nil)));
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=589874196
//#UC END# *54EED7DF0249_49539DBA029D_impl*
end;//TExTextForm.NeedSaveInWorkJournal

{$If NOT Defined(NoVCM)}
function TExTextForm.DoGetNeedAddFormToTasksPanel: Boolean;
//#UC START# *54F458DD01CE_49539DBA029D_var*
//#UC END# *54F458DD01CE_49539DBA029D_var*
begin
//#UC START# *54F458DD01CE_49539DBA029D_impl*
 Result := (UserType <> dftDictSubEntry) and Inherited DoGetNeedAddFormToTasksPanel;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=588809860
//#UC END# *54F458DD01CE_49539DBA029D_impl*
end;//TExTextForm.DoGetNeedAddFormToTasksPanel
{$IfEnd} // NOT Defined(NoVCM)

initialization
//#UC START# *4C40048600C1*
 g_GoToIntranetMessage := RegisterWindowMessage('{A6BE0224-FE97-4984-8E91-B24104812165}');
//#UC END# *4C40048600C1*
 str_ViewChangesOpName.Init;
 {* Инициализация str_ViewChangesOpName }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TExTextForm);
 {* Регистрация ExText }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
