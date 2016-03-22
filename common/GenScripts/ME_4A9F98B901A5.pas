unit BaseSearchInterfaces;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Search\BaseSearchInterfaces.pas"
// ���������: "Interfaces"
// ������� ������: "BaseSearchInterfaces" MUID: (4A9F98B901A5)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3Interfaces
 , DynamicTreeUnit
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimBaseSearchInterfaces
 , SysUtils
 , DynamicDocListUnit
 , l3TreeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 ns_bscNone = nil;
 ns_sseAll = [ns_sseContext, ns_sseNeedShowWindow, ns_sseOpenKind, ns_sseActiveClass, ns_sseSearchArea];

type
 TnsBaseSearchOpenKind = (
  {* ���� �������� �������� ������ }
  ns_bsokLocal
   {* ��������� ����� ��������� (Ctrl+F) }
  , ns_bsokSpecify
   {* �������� }
  , ns_bsokGlobal
   {* ���������� ����� (F4) }
 );//TnsBaseSearchOpenKind

 InsBaseSearchVisibleWatcher = interface
  ['{E98658D8-1553-40D7-A6E1-840C705598C9}']
  procedure VisibleChanged(aNewVisible: Boolean);
 end;//InsBaseSearchVisibleWatcher

 InsBaseSearchContextProvider = interface
  ['{674A4919-B96A-489C-AFEC-726940684C28}']
  function pm_GetContext: Il3CString;
  procedure RepairMistakes;
  property Context: Il3CString
   read pm_GetContext;
 end;//InsBaseSearchContextProvider

 InsBaseSearchClass = interface
  ['{F376FEAE-F09B-4E92-A508-6FB991BFBFB2}']
  function pm_GetAdapterNode: INodeBase;
  function pm_GetName: Il3CString;
  function IsSame(const aAnother: InsBaseSearchClass): Boolean;
  property AdapterNode: INodeBase
   read pm_GetAdapterNode;
  property Name: Il3CString
   read pm_GetName;
 end;//InsBaseSearchClass

 InsBaseSearchClassesEnumerator = interface
  ['{A67B9BF0-F2F5-4F80-AB66-E23E6502043D}']
  function pm_GetCurrent: InsBaseSearchClass;
  procedure Reset;
  function MoveNext: Boolean;
  property Current: InsBaseSearchClass
   read pm_GetCurrent;
 end;//InsBaseSearchClassesEnumerator

 TnsBaseSearchKind = (
  ns_bskMenu
  , ns_bskList
  , ns_bskDocument
  , ns_bskQuery
 );//TnsBaseSearchKind

 TnsSearchArea = (
  ns_saEverywere
  , ns_saText
  , ns_saTitlesOnly
 );//TnsSearchArea

 InsBaseSearchDataReadyChecker = interface
  ['{F01A4C08-BF24-4300-B7E1-EA5CE47AD428}']
  procedure CheckLocalDataReady;
 end;//InsBaseSearchDataReadyChecker

 (*
 MnsSupportDisabled = interface
  function SupportDisabled: Boolean;
 end;//MnsSupportDisabled
 *)

 InsBaseSearchQueryDataProcessor = interface
  ['{40201F1F-3C11-4497-B812-5CC0D75A2355}']
  procedure SetDataFromQuery(const aQuery: IUnknown);
  procedure RequestFind;
  procedure RequestCheckFragmentsCount;
  procedure RequestCheckFindBack;
 end;//InsBaseSearchQueryDataProcessor

 InsSearchWindow = interface
  ['{793F257C-3520-4B48-AE36-4CB918875D2E}']
  function pm_GetIsActive: Boolean;
  function Get_Container: IvcmContainer;
  procedure ParamsChanged;
  procedure PresentationChanged;
  procedure ExampleChanged;
  procedure CheckFindEnabled;
  procedure ClassNamesChanged;
  procedure CloseWindow;
  procedure ActivateWindow(aNeedFlash: Boolean = True);
  procedure CheckFragmentsCount;
  procedure ForceUpdateClassForHistory;
  property IsActive: Boolean
   read pm_GetIsActive;
  property Container: IvcmContainer
   read Get_Container;
 end;//InsSearchWindow

 InsContextSearcher = interface
  ['{3E94FD76-AA33-4F11-894F-7F6344176794}']
  function pm_GetArea: TnsSearchArea;
  procedure pm_SetArea(aValue: TnsSearchArea);
  function Get_VisibleWatcher: InsBaseSearchVisibleWatcher;
  function Kind: TnsBaseSearchKind;
  function Find(const aContext: InsBaseSearchContextProvider;
   const aProcessor: InsBaseSearchResultProcessor): Boolean;
  function AllowSearchInTitles: Boolean;
  function IsLocalSearchArea: Boolean;
  procedure ContextChanged(const aNewContext: Il3CString);
  function IsLocalDataReady: Boolean;
  function FindBack(const aContext: InsBaseSearchContextProvider;
   const aProcessor: InsBaseSearchResultProcessor): Boolean;
   {* ������ ����� }
  function FindBackSupported: Boolean;
  function FindBackEnabled: Boolean;
  function FragmentsCountSuffix: Il3CString;
  function AllowPrompts: Boolean;
  function PromptsInfo: LongWord;
  function SwitchToTextIfPossible: Boolean;
  function IsSearchLocked: Boolean;
  function SupportDisabled: Boolean;
  property Area: TnsSearchArea
   read pm_GetArea
   write pm_SetArea;
  property VisibleWatcher: InsBaseSearchVisibleWatcher
   read Get_VisibleWatcher;
 end;//InsContextSearcher

 InsMistakesCorrector = interface
  ['{48789C4F-0569-4518-821B-EA5BF3A64480}']
  procedure Correct(const aCorrectedContext: Il3StringsEx;
   const aMistakesList: Il3StringsEx);
 end;//InsMistakesCorrector

 TnsContainerForBaseSearchInfo = record
  rContainer: IvcmContainer;
  rZone: TvcmZoneType;
 end;//TnsContainerForBaseSearchInfo

 (*
 MnsBaseSearchPresentationState = interface
  {* http://mdp.garant.ru/pages/viewpage.action?pageId=321989072
http://mdp.garant.ru/pages/viewpage.action?pageId=321989072&focusedCommentId=330698655#comment-330698655 }
  function FormCloseWasRequested: Boolean;
   {* ���� ��� ��������� ���������
http://mdp.garant.ru/pages/viewpage.action?pageId=321989072&focusedCommentId=330698655#comment-330698655
������ ����� ��� ������ ���������� � �������. ������ �� ���� � ����� ��, ������� �� ���� ������� }
 end;//MnsBaseSearchPresentationState
 *)

 ETryToFindEmptyContext = class(Exception)
 end;//ETryToFindEmptyContext

 InsBaseSearchWindowOpener = interface
  ['{5D504A4A-A102-4393-A6E3-7B05893425C5}']
  procedure OpenWindow(OpenKind: TnsBaseSearchOpenKind);
 end;//InsBaseSearchWindowOpener

 InsBaseSearchListSource = interface
  ['{A3EE6B9E-5CDF-4D52-9384-3ADB2C60D102}']
  function Get_SearchList: IDynList;
  property SearchList: IDynList
   read Get_SearchList;
 end;//InsBaseSearchListSource

 InsBaseSearchPresentation = interface
  {* ������������� "�������� ������" }
  ['{6F7CE717-5FD9-45EE-9487-F4F1A0F9C248}']
  function Get_ContainerForBaseSearch: TnsContainerForBaseSearchInfo;
  function Get_ContextSearcher: InsContextSearcher;
  function Get_NeedSaveActiveClassBeforeSearch: Boolean;
  function WindowRequired: Boolean;
  function WindowCloseable: Boolean;
  function CanCloseWindow: Boolean;
  function IsQueryCard: Boolean;
  function TreatSuccessSearchAsManualOpen: Boolean;
  function AutoActivateWindow: Boolean;
  function SupportDisabled: Boolean;
  function FormCloseWasRequested: Boolean;
   {* ���� ��� ��������� ���������
http://mdp.garant.ru/pages/viewpage.action?pageId=321989072&focusedCommentId=330698655#comment-330698655
������ ����� ��� ������ ���������� � �������. ������ �� ���� � ����� ��, ������� �� ���� ������� }
  property ContainerForBaseSearch: TnsContainerForBaseSearchInfo
   read Get_ContainerForBaseSearch;
  property ContextSearcher: InsContextSearcher
   read Get_ContextSearcher;
  property NeedSaveActiveClassBeforeSearch: Boolean
   read Get_NeedSaveActiveClassBeforeSearch;
   {* ��������� �� �������� ����� �� ������ (��� � ������) ��� ����� (��� � ��)
http://mdp.garant.ru/pages/viewpage.action?pageId=327826220
������ ������ ��� ���� ��� ������������ �������� - ��������� ����� ��� ����������, �.�. ��������� ��������� ����� ������ ��� ��� }
 end;//InsBaseSearchPresentation

 InsCutToLeafFilter = interface
  ['{82C20B16-25CE-4A11-A1AA-BC052236983F}']
  function pm_GetLeafCount: LongWord;
  property LeafCount: LongWord
   read pm_GetLeafCount;
 end;//InsCutToLeafFilter

 InsPromptForDocFilter = interface
  ['{37181736-0998-4C7D-9DFD-6245F00168A6}']
  function Get_InternalDocNumber: Longword;
  property InternalDocNumber: Longword
   read Get_InternalDocNumber;
 end;//InsPromptForDocFilter

 InsBaseSearchPromptFilters = interface(Il3TreeFilters)
  ['{1C61F6BE-82F5-4A17-AA9F-A2AD82FE6F96}']
  function Get_ForDoc: InsPromptForDocFilter;
  function pm_GetLeaf: InsCutToLeafFilter;
  function SetLeaf(const aFilter: InsCutToLeafFilter): InsBaseSearchPromptFilters;
  function SetPromptForDoc(const aFilter: InsPromptForDocFilter): InsBaseSearchPromptFilters;
  property ForDoc: InsPromptForDocFilter
   read Get_ForDoc;
  property Leaf: InsCutToLeafFilter
   read pm_GetLeaf;
 end;//InsBaseSearchPromptFilters

 TbsBaseSearchResult = (
  bsrNone
   {* � ������ ���� ��������� ������ �� ������ }
  , bsrContinueSearch
   {* ���������� ����� }
  , bsrSearchFinished
   {* ����� � ����� �������� }
  , bsrSearchFinishedNotFound
   {* � ������ ������ �� ������� }
  , bsrSearchFinishedAllInHidden
   {* ������ ����� �������, �� ��� � ������� ������ }
 );//TbsBaseSearchResult

 IbsBaseDocumentContextSearcher = interface
  ['{12BC458F-160F-4D3E-AE17-B95998B2B341}']
  function pm_GetCanContinue: Boolean;
  function Get_CanFindBack: Boolean;
  function pm_GetFragmentsCount: Integer;
  function pm_GetContext: Il3CString;
  function Find(const aContext: Il3CString): TbsBaseSearchResult;
   {* ����� }
  procedure ContextChanged(const aNewContext: Il3CString);
  function FindBack: TbsBaseSearchResult;
   {* �������� � ����������� ��������� }
  property CanContinue: Boolean
   read pm_GetCanContinue;
   {* ����� �� ����� ���� ��������� (F3) }
  property CanFindBack: Boolean
   read Get_CanFindBack;
  property FragmentsCount: Integer
   read pm_GetFragmentsCount;
  property Context: Il3CString
   read pm_GetContext;
 end;//IbsBaseDocumentContextSearcher

 (*
 MnsPresentationHolder = interface
  function pm_GetPresentation: InsBaseSearchPresentation;
  procedure pm_SetPresentation(const aValue: InsBaseSearchPresentation);
  function ValidateBaseSearchForm(const aForm: IvcmEntityForm): Boolean;
   {* ���������, ��� ����� �� "��� �������", �.�. �������� � �� �� ������� ����, ��� � ��� Searcher }
  procedure RemovePresentation(const aPresentation: InsBaseSearchPresentation);
  property Presentation: InsBaseSearchPresentation
   read pm_GetPresentation
   write pm_SetPresentation;
 end;//MnsPresentationHolder
 *)

 InsBaseSearchClassesListener = interface
  ['{7936540E-3122-4B48-AFEC-E517EEAC43D6}']
  procedure NotifyClassesChanged;
 end;//InsBaseSearchClassesListener

 InsMainMenuLikeBaseSearchOwner = interface
  {* ����������, ��� �������� �� �������� ������� �� �� }
  ['{DF3EF06D-56F1-477C-932A-6CC09342E7DD}']
  function IsIt: Boolean;
 end;//InsMainMenuLikeBaseSearchOwner

 TnsBaseSearchStateElement = (
  ns_sseContext
  , ns_sseNeedShowWindow
  , ns_sseOpenKind
  , ns_sseActiveClass
  , ns_sseSearchArea
 );//TnsBaseSearchStateElement

 TnsBaseSearchStateElements = set of TnsBaseSearchStateElement;

 InsBaseSearcherInitialState = interface
  ['{E92D641C-DB96-46E9-8DC6-9C0802A7FE41}']
  function pm_GetContext: Il3CString;
  function pm_GetNeedShowWindow: Boolean;
  function pm_GetOpenKind: TnsBaseSearchOpenKind;
  function pm_GetElements: TnsBaseSearchStateElements;
  function pm_GetCurrentSearchClass: InsBaseSearchClass;
  function pm_GetSearchArea: TnsSearchArea;
  function pm_GetNeedActivate: Boolean;
  property Context: Il3CString
   read pm_GetContext;
  property NeedShowWindow: Boolean
   read pm_GetNeedShowWindow;
  property OpenKind: TnsBaseSearchOpenKind
   read pm_GetOpenKind;
  property Elements: TnsBaseSearchStateElements
   read pm_GetElements;
  property CurrentSearchClass: InsBaseSearchClass
   read pm_GetCurrentSearchClass;
  property SearchArea: TnsSearchArea
   read pm_GetSearchArea;
  property NeedActivate: Boolean
   read pm_GetNeedActivate;
 end;//InsBaseSearcherInitialState

 InsBaseSearchInitialStateProvider = interface
  ['{A5D8EBF4-4701-484C-A32D-EAB41D4411B8}']
  function pm_GetInitialState: InsBaseSearcherInitialState;
  function pm_GetStateForClone: InsBaseSearcherInitialState;
  property InitialState: InsBaseSearcherInitialState
   read pm_GetInitialState;
  property StateForClone: InsBaseSearcherInitialState
   read pm_GetStateForClone;
 end;//InsBaseSearchInitialStateProvider

 InsBaseSearchClasses = interface
  ['{3D7D5C7D-2890-4D29-804A-F50E579A28CB}']
  function pm_GetFirstClass: InsBaseSearchClass;
  function GetEnumerator: InsBaseSearchClassesEnumerator;
  procedure Subscribe(const aListener: InsBaseSearchClassesListener);
  procedure Unsubscribe(const aListener: InsBaseSearchClassesListener);
  function GetClassByPath(const aPath: Tl3WString): InsBaseSearchClass;
  property FirstClass: InsBaseSearchClass
   read pm_GetFirstClass;
 end;//InsBaseSearchClasses

 TnsBaseSearchWindowState = (
  ns_wsClosed
   {* ���� ������� }
  , ns_wsOpened
   {* ���� ������� }
  , ns_wsForce
   {* ���� ���� ������� ������������� }
 );//TnsBaseSearchWindowState

 InsBaseSearcherWindowDataState = interface
  ['{FEF02F60-B5AC-4322-B2AD-D71F9F0AC310}']
  function pm_GetActiveClass: InsBaseSearchClass;
  function pm_GetContext: Il3CString;
  function pm_GetWindowState: TnsBaseSearchWindowState;
  property ActiveClass: InsBaseSearchClass
   read pm_GetActiveClass;
  property Context: Il3CString
   read pm_GetContext;
  property WindowState: TnsBaseSearchWindowState
   read pm_GetWindowState;
 end;//InsBaseSearcherWindowDataState

 TnsBaseSearcherChangeElement = (
  ns_ceContext
  , ns_ceActiveClass
  , ns_ceSearchArea
 );//TnsBaseSearcherChangeElement

 TnsBaseSearcherChangeElements = set of TnsBaseSearcherChangeElement;

 InsBaseSearchWindowDataListener = interface
  ['{077A6E65-4EFE-4D18-B636-37CE23834A28}']
  procedure NotifyBaseSearcherDataChanged(aChangedElements: TnsBaseSearcherChangeElements);
 end;//InsBaseSearchWindowDataListener

 InsBaseSearcherWindowData = interface
  ['{DD7D1F2D-820E-444C-9DF2-8780A9B6256D}']
  function pm_GetClassesAnywayDisabled: Boolean;
  function pm_GetAllowSearchInTitles: Boolean;
  function pm_GetFindEnabled: Boolean;
  function pm_GetFindBackSupported: Boolean;
  function pm_GetFindBackEnabled: Boolean;
  function pm_GetFragmentsCountSuffix: Il3CString;
  function pm_GetPromptTree: Il3SimpleTree;
  function pm_GetErrorWords: IvcmStrings;
  procedure pm_SetErrorWords(const aValue: IvcmStrings);
  function pm_GetContextKind: TnsBaseSearchKind;
  function pm_GetAvailableClasses: InsBaseSearchClasses;
  function pm_GetContext: Il3CString;
  procedure pm_SetContext(const aValue: Il3CString);
  function pm_GetActiveClass: InsBaseSearchClass;
  procedure pm_SetActiveClass(const aValue: InsBaseSearchClass);
  function pm_GetArea: TnsSearchArea;
  procedure pm_SetArea(aValue: TnsSearchArea);
  function pm_GetExampleText: Il3CString;
  function pm_GetActiveClassForSaveState: InsBaseSearchClass;
  function pm_GetPresentation: InsBaseSearchPresentation;
  procedure pm_SetPresentation(const aValue: InsBaseSearchPresentation);
  function MakeState: InsBaseSearcherWindowDataState;
  procedure AssignState(const aState: InsBaseSearcherWindowDataState);
  procedure Subscribe(const aListener: InsBaseSearchWindowDataListener);
  procedure Unsubscribe(const aListener: InsBaseSearchWindowDataListener);
  procedure StoreActiveClass;
  function ValidateBaseSearchForm(const aForm: IvcmEntityForm): Boolean;
   {* ���������, ��� ����� �� "��� �������", �.�. �������� � �� �� ������� ����, ��� � ��� Searcher }
  procedure RemovePresentation(const aPresentation: InsBaseSearchPresentation);
  property ClassesAnywayDisabled: Boolean
   read pm_GetClassesAnywayDisabled;
  property AllowSearchInTitles: Boolean
   read pm_GetAllowSearchInTitles;
  property FindEnabled: Boolean
   read pm_GetFindEnabled;
  property FindBackSupported: Boolean
   read pm_GetFindBackSupported;
   {* � �������� ����� ������ ����� }
  property FindBackEnabled: Boolean
   read pm_GetFindBackEnabled;
   {* ����� ����� �������� � ������ ������ }
  property FragmentsCountSuffix: Il3CString
   read pm_GetFragmentsCountSuffix;
  property PromptTree: Il3SimpleTree
   read pm_GetPromptTree;
  property ErrorWords: IvcmStrings
   read pm_GetErrorWords
   write pm_SetErrorWords;
  property ContextKind: TnsBaseSearchKind
   read pm_GetContextKind;
  property AvailableClasses: InsBaseSearchClasses
   read pm_GetAvailableClasses;
  property Context: Il3CString
   read pm_GetContext
   write pm_SetContext;
  property ActiveClass: InsBaseSearchClass
   read pm_GetActiveClass
   write pm_SetActiveClass;
  property Area: TnsSearchArea
   read pm_GetArea
   write pm_SetArea;
  property ExampleText: Il3CString
   read pm_GetExampleText;
  property ActiveClassForSaveState: InsBaseSearchClass
   read pm_GetActiveClassForSaveState;
   {* http://mdp.garant.ru/pages/viewpage.action?pageId=300026165 }
  property Presentation: InsBaseSearchPresentation
   read pm_GetPresentation
   write pm_SetPresentation;
 end;//InsBaseSearcherWindowData

 InsBaseSearcher = interface
  ['{A794F871-A872-47EC-B5D2-C2FFE1FF4138}']
  function pm_GetSearchWindow: InsSearchWindow;
  procedure pm_SetSearchWindow(const aValue: InsSearchWindow);
  function pm_GetWindowData: InsBaseSearcherWindowData;
  function pm_GetPresentation: InsBaseSearchPresentation;
  procedure pm_SetPresentation(const aValue: InsBaseSearchPresentation);
  procedure DropActiveClass;
   {* http://mdp.garant.ru/pages/viewpage.action?pageId=269069309&focusedCommentId=296624258#comment-296624258 }
  function MakeState: InsBaseSearcherInitialState;
  procedure AssignState(const aState: InsBaseSearcherInitialState);
  procedure ForceUpdateClassForHistory;
  function MakeStateParams(aStateElements: TnsBaseSearchStateElements;
   aForClone: Boolean): InsBaseSearcherInitialState;
  procedure ContainerIsClosing;
  procedure Find;
  procedure FindBack;
  procedure ApplyCurrentExample;
  procedure ShowWindowByUser(OpenKind: TnsBaseSearchOpenKind);
  function ValidateBaseSearchForm(const aForm: IvcmEntityForm): Boolean;
   {* ���������, ��� ����� �� "��� �������", �.�. �������� � �� �� ������� ����, ��� � ��� Searcher }
  procedure RemovePresentation(const aPresentation: InsBaseSearchPresentation);
  property SearchWindow: InsSearchWindow
   read pm_GetSearchWindow
   write pm_SetSearchWindow;
  property WindowData: InsBaseSearcherWindowData
   read pm_GetWindowData;
  property Presentation: InsBaseSearchPresentation
   read pm_GetPresentation
   write pm_SetPresentation;
 end;//InsBaseSearcher

 InsBaseSearcherProvider = interface
  ['{75F17410-E8D4-42B9-84D5-DC1EA4486A12}']
  function Get_BaseSearcher: InsBaseSearcher;
  property BaseSearcher: InsBaseSearcher
   read Get_BaseSearcher;
 end;//InsBaseSearcherProvider
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin)

end.
