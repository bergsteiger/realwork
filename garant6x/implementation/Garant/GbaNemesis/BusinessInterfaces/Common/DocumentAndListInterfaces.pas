unit DocumentAndListInterfaces;
 {* ���������� ������ ���� ��� ������ � ���������� � ������� ���������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\BusinessInterfaces\Common\DocumentAndListInterfaces.pas"
// ���������: "ControllerInterfaces"
// ������� ������: "DocumentAndListInterfaces" MUID: (491B305A0096)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseTreeSupportUnit
 , DynamicDocListUnit
 , DocumentUnit
 , DynamicTreeUnit
 , ExternalObjectUnit
 , FiltersUnit
 , UnderControlUnit
 , l3Interfaces
 , l3Types
 , nevBase
 , afwInterfaces
 , l3TreeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Tree_TLB
 , nevTools
 , bsTypes
 , bsInterfaces
 , evdInterfaces
 , TreeInterfaces
 , SimpleListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , FoldersDomainInterfaces
 , PreviewInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , AdapterFacade
 , PrimListInterfaces
 , PrimPrimListInterfaces
 , DocumentInterfaces
 , F1TagDataProviderInterface
 , nsTypesNew
 , l3InternalInterfaces
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , nsTypes
 , bsTypesNew
;

const
 cEmptyWarning = [];

type
 IucpHAFMacroReplacerFactory = interface
  ['{67A4A878-44B8-4418-AB9D-05321800E866}']
  function MakeHAFMacroReplacer: IafwHAFMacroReplacer;
 end;//IucpHAFMacroReplacerFactory

 TnsContentsListType = (
  ns_cltBookmarks
  , ns_cltComments
  , ns_cltExternalObjects
 );//TnsContentsListType

 TnsContentsListIndex = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rListType: TnsContentsListType;
   rIndex: Integer;
 end;//TnsContentsListIndex

 IdsBaseContents = interface(IdsSimpleTree)
  {* ������� ���������� }
  ['{5704E0B4-AD83-4134-9F43-EDBBC57C10E1}']
  function pm_GetDocInfo: IdeDocInfo;
  function Get_Bookmarks: IBookmarkList;
  function Get_Comments: ICommentsParaList;
  function Get_ExternalObjects: IExternalObjectDataList;
  function Get_Adornments: InsDocumentAdornments;
  function Get_ContentsListCount(aListType: TnsContentsListType): Integer;
  function Get_ContentsListItem(const anIndex: TnsContentsListIndex): TnsStringPair;
  function Get_ContentsListParaID(const anIndex: TnsContentsListIndex): Integer;
  function Get_Empty: Boolean;
  function pm_GetCurrentContextFilter: InscContextFilterState;
  function FiltrateByContext(const aTreeSource: Il3SimpleTree;
   const aCurrentNode: Il3SimpleNode;
   const aFilter: InscContextFilterState;
   out aCurrent: Integer): Il3SimpleTree;
  property DocInfo: IdeDocInfo
   read pm_GetDocInfo;
  property Bookmarks: IBookmarkList
   read Get_Bookmarks;
   {* �������� }
  property Comments: ICommentsParaList
   read Get_Comments;
   {* ����������� }
  property ExternalObjects: IExternalObjectDataList
   read Get_ExternalObjects;
   {* ������� ������� }
  property Adornments: InsDocumentAdornments
   read Get_Adornments;
  property ContentsListCount[aListType: TnsContentsListType]: Integer
   read Get_ContentsListCount;
  property ContentsListItem[const anIndex: TnsContentsListIndex]: TnsStringPair
   read Get_ContentsListItem;
  property ContentsListParaID[const anIndex: TnsContentsListIndex]: Integer
   read Get_ContentsListParaID;
  property Empty: Boolean
   read Get_Empty;
  property CurrentContextFilter: InscContextFilterState
   read pm_GetCurrentContextFilter;
 end;//IdsBaseContents

 IucpFilterInfoFactory = interface
  ['{68ACB664-4779-45D2-B060-3BAF5E308E30}']
  function MakeFilterInfo(aType: TnsFolderFilter;
   aShowFolders: TnsShowFolders = FoldersDomainInterfaces.sfAll): InsFolderFilterInfo;
 end;//IucpFilterInfoFactory

 IdsAttributes = interface(IdsSimpleTree)
  {* ��������� ������ ������� ����� "AttributesForm" }
  ['{554000E9-BCBC-41E7-A349-E140BE2E9228}']
  function pm_GetDocInfo: IdeDocInfo;
  property DocInfo: IdeDocInfo
   read pm_GetDocInfo;
 end;//IdsAttributes

 IdeSimpleTree = interface
  ['{208162B7-52E3-4FC5-A7EC-89A3DA19BA4D}']
  function Get_Contents: Il3SimpleTree;
  function Get_Bookmarks: IBookmarkList;
  function Get_Comments: ICommentsParaList;
  function Get_ExternalObjects: IExternalObjectDataList;
  function Get_Empty: Boolean;
  function Get_Adornments: InsDocumentAdornments;
  property Contents: Il3SimpleTree
   read Get_Contents;
   {* ���������� }
  property Bookmarks: IBookmarkList
   read Get_Bookmarks;
  property Comments: ICommentsParaList
   read Get_Comments;
  property ExternalObjects: IExternalObjectDataList
   read Get_ExternalObjects;
  property Empty: Boolean
   read Get_Empty;
  property Adornments: InsDocumentAdornments
   read Get_Adornments;
 end;//IdeSimpleTree

 (*
 BaseSearchSupportQuery = interface
  function Get_CanRunBaseSearch: Boolean;
  property CanRunBaseSearch: Boolean
   read Get_CanRunBaseSearch;
 end;//BaseSearchSupportQuery
 *)

 IdsEditions = interface(IvcmViewAreaController)
  {* ������ ������ ����� "EditionForm" }
  ['{376B7780-9BB0-45EA-96C4-50FFD1D6F239}']
  function GetEditionsRoot: Il3SimpleRootNode;
   {* ��������� ������ �������� ��������� }
 end;//IdsEditions

 IdsWarning = interface(IvcmViewAreaController)
  {* ������ ������ ����� "WarningForm" }
  ['{30076F57-B1B0-4F48-B014-570808CE5822}']
  function pm_GetWarningContent: TWarningTypeSet;
  function Get_ForSynchroView: Boolean;
  function pm_GetDocInfo: IdeDocInfo;
  procedure GenerateWarning(const aGenerator: InevTagGenerator;
   aUserType: Integer);
   {* ��������� ������ �������������� }
  property WarningContent: TWarningTypeSet
   read pm_GetWarningContent;
  property ForSynchroView: Boolean
   read Get_ForSynchroView;
  property DocInfo: IdeDocInfo
   read pm_GetDocInfo;
 end;//IdsWarning

 IdsContents = interface(IdsBaseContents)
  {* ������ ������ ����� "ContentsForm" }
  ['{F9C554FB-FCC5-430B-8524-002B36C17D99}']
  function pm_GetHasRespondents: Boolean;
  function pm_GetHasCorrespondents: Boolean;
  function HasSimilarToFragment(anId: Integer): Boolean;
  procedure OpenSimilarDocuments;
  procedure OpenSimilarDocumentsToFragment(aBlockId: Integer);
  property HasRespondents: Boolean
   read pm_GetHasRespondents;
  property HasCorrespondents: Boolean
   read pm_GetHasCorrespondents;
 end;//IdsContents

 IucbBaseSearchSupportQuery = interface
  ['{A872F50C-123E-46E1-A201-A52A4D59361B}']
  function Get_CanRunBaseSearch: Boolean;
  property CanRunBaseSearch: Boolean
   read Get_CanRunBaseSearch;
 end;//IucbBaseSearchSupportQuery

 TnsContentsOpenMode = (
  ns_comForce
  , ns_comNotForce
 );//TnsContentsOpenMode

 TnsBooleanToContentsOpenModeConverter = array [Boolean] of TnsContentsOpenMode;

 (*
 Contents = interface
  {* ���������� }
  procedure OpenContents(const aTree: IdeSimpleTree;
   anForceOpen: TnsContentsOpenMode;
   const aContainerOfDocument: InevDocumentContainer);
 end;//Contents
 *)

 InsWarningLocker = interface
  ['{46C328AF-4FA8-4B15-94ED-0A3E5E47FF76}']
  procedure LockWarning;
  procedure UnLockWarning;
 end;//InsWarningLocker

 TnsWarningLinkHandle = (
  cNone_LinkHandle
  , cNotSure_LinkHandle
  , cTimeMachineOff_LinkHandle
  , cSwitchFiltersOff_LinkHandle
  , cnsFlashActiveXInstallLinkId
  , cUnreadConsultations_LinkHandle
  , cTimeMachineChangeDateOrOff_LinkHandle
 );//TnsWarningLinkHandle

 TnsWarningSub = (
  cNoneWarningSub
  , cEditionWarningSub
  , cNotSureWarningSub
  , cSimpleWarningSub
  , cTimeMachineWarningSub
 );//TnsWarningSub

 (*
 WarningGenerator = interface
  function Generate(const aWarning: IdsWarning;
   const aGen: InevTagGenerator;
   aUserType: TvcmUserType): TWarningTypeSet;
   {* ��������� �������� � ���, ����� �������������� ���� � ���������. ���� ��� �� ������ ��������������, �� �������� cEmptyWarning }
 end;//WarningGenerator
 *)

 (*
 DocumentFromList = interface
  function pm_GetCanOpenPrevDoc: Boolean;
  function pm_GetCanOpenNextDoc: Boolean;
  function pm_GetCanReturnToList: Boolean;
  function SwitchToDocumentFromList(aPrev: Boolean): IdeDocInfo;
  procedure ReturnToList;
  property CanOpenPrevDoc: Boolean
   read pm_GetCanOpenPrevDoc;
  property CanOpenNextDoc: Boolean
   read pm_GetCanOpenNextDoc;
  property CanReturnToList: Boolean
   read pm_GetCanReturnToList;
 end;//DocumentFromList
 *)

 IucbDocumentFromList = interface
  ['{59A1430B-E8B5-4A43-94C1-7BEAD7589C39}']
  function pm_GetCanOpenPrevDoc: Boolean;
  function pm_GetCanOpenNextDoc: Boolean;
  function pm_GetCanReturnToList: Boolean;
  function SwitchToDocumentFromList(aPrev: Boolean): IdeDocInfo;
  procedure ReturnToList;
  property CanOpenPrevDoc: Boolean
   read pm_GetCanOpenPrevDoc;
  property CanOpenNextDoc: Boolean
   read pm_GetCanOpenNextDoc;
  property CanReturnToList: Boolean
   read pm_GetCanReturnToList;
 end;//IucbDocumentFromList

 TdocLikeState = (
  dlsDefault
  , dlsUseful
  , dlsUseless
 );//TdocLikeState

 IdsBaseDocument = interface(IvcmViewAreaController)
  {* ������� ������ ������ ���������. }
  ['{6078F076-04AA-4ED2-8788-E61315390559}']
  function pm_GetHasDoc: Boolean;
  function pm_GetCanWorkWithRedactions: Boolean;
  function pm_GetHasPrevRedaction: Boolean;
  function pm_GetHasNextRedaction: Boolean;
  function pm_GetIsReadOnly: Boolean;
  function pm_GetTimeMachineOff: Boolean;
  function pm_GetIsDateCurrentRedationEmpty: Boolean;
  function pm_GetIsActualRedation: Boolean;
  function Get_PreviewCaleeArea: TafwPreviewCaleeArea;
  function pm_GetContainer: InevDocumentContainer;
  function pm_GetDocInfo: IdeDocInfo;
  function pm_GetLanguage: TbsLanguage;
  function Get_LikeState: TdocLikeState;
  procedure Set_LikeState(aValue: TdocLikeState);
  function AsLikeable: ILikeable;
  function GetDocumentShortName: Il3CString;
  function GetDocumentName: Il3CString;
  function MakeGotoPointData(const aDocument: IDocument;
   aRefType: TDocumentPositionType;
   aPos: Longword): IdeDocInfo;
   {* ������� ������. ���� ������ ������� ������������ ������, �� ������ ���
             ����� ������ ��������� ��� ��������� ��� ������ �������� ������ }
  function NewDocInfo(const aPos: TbsDocPos): IdeDocInfo;
   {* ������� �������� � ���� }
  function As_IucpHAFMacroReplacerFactory: IucpHAFMacroReplacerFactory;
   {* ����� ���������� ������ ���������� � IucpHAFMacroReplacerFactory }
  function As_IucpFilterInfoFactory: IucpFilterInfoFactory;
   {* ����� ���������� ������ ���������� � IucpFilterInfoFactory }
  property HasDoc: Boolean
   read pm_GetHasDoc;
   {* ��������� ������� ��������� }
  property CanWorkWithRedactions: Boolean
   read pm_GetCanWorkWithRedactions;
   {* ����� �� �������� � ���������� ��������� }
  property HasPrevRedaction: Boolean
   read pm_GetHasPrevRedaction;
   {* ���� ���������� �������� }
  property HasNextRedaction: Boolean
   read pm_GetHasNextRedaction;
   {* ���� �������� ��������. }
  property IsReadOnly: Boolean
   read pm_GetIsReadOnly;
   {* �������� �������� ������ ��� ������. }
  property TimeMachineOff: Boolean
   read pm_GetTimeMachineOff;
   {* ��� ��������� ��������� ������ ������ ������� ����� ���������. }
  property IsDateCurrentRedationEmpty: Boolean
   read pm_GetIsDateCurrentRedationEmpty;
   {* �������� �� ������� ���� �������� ������, ��� ���������� � ��������
             ���������� ��� }
  property IsActualRedation: Boolean
   read pm_GetIsActualRedation;
   {* ������� �������� ��������� }
  property PreviewCaleeArea: TafwPreviewCaleeArea
   read Get_PreviewCaleeArea;
  property Container: InevDocumentContainer
   read pm_GetContainer;
  property DocInfo: IdeDocInfo
   read pm_GetDocInfo;
  property Language: TbsLanguage
   read pm_GetLanguage;
  property LikeState: TdocLikeState
   read Get_LikeState
   write Set_LikeState;
 end;//IdsBaseDocument

 IdsList = interface(IdsSimpleTree)
  {* ������� ������. }
  ['{76334D96-11E8-4181-8769-B0CE31169E94}']
  function pm_GetIsSaved: Boolean;
  function pm_GetListName: Il3CString;
  function pm_GetShortListName: Il3CString;
  function pm_GetIsChanged: Boolean;
  function pm_GetIsFiltered: Boolean;
  function pm_GetIsListEmpty: Boolean;
  function pm_GetIsTimeMachineEnable: Boolean;
  function pm_GetTimeMachineOff: Boolean;
  function pm_GetListType: TbsListType;
  function pm_GetList: IDynList;
  function pm_GetIsMain: Boolean;
  function pm_GetNodeForPositioning: Il3SimpleNode;
  function pm_GetAllDocumentFiltered: Boolean;
  function pm_GetHasAttributes: Boolean;
  function Get_ActiveFilters: IFiltersFromQuery;
  procedure UpdatePreview;
   {* - �������� ��������������� ��������. }
  function MakePreview(aOnlyFirstLevel: Boolean = True): IafwComplexDocumentPreview;
   {* - ��������� preview ��� ������. }
  function OpenDocument(out theDataInfo: IdeDocInfo): Boolean;
   {* - ���������� SDS ��� �������� ������ ��������. }
  function NewListFromSelected: IDynList;
   {* - ������� ����� ������ �� ����������. }
  function NewList: IdeList;
   {* - ������� ������ � ����. }
  procedure UpdateListInfo;
   {* - ��������� ���������� � ������. }
  function CheckList(const aTree: Il3SimpleTree): Boolean;
   {* - ���������� �������� �� aControl ������. }
  function ApplyFilter(const aFilter: IFilterFromQuery;
   aAdd: Boolean = False): Boolean;
   {* - ���������\�������� ������. }
  function ClearFilters: Boolean;
   {* - �������� �������. }
  procedure DeleteNodes;
   {* - ������� ��������� ����. }
  procedure ExportDocument(const aDocument: IDocument;
   const aFileName: Il3CString;
   aFormat: TnsFileFormat);
   {* - ��������� ��������� �������� �� ���� � ��������� �������. }
  function ExportDocuments(aOnlyFirstLevel: Boolean;
   aOnlySelection: Boolean;
   const aPath: Il3CString;
   aFormat: TnsFileFormat): Boolean;
   {* - ��������� ���������� ��������� �� ���� � ��������� �������.
���������� ������� ����, ��� ����-�� ��������� }
  function ListAsText(aSaveListKind: TbsSaveListKind;
   SaveSelection: Boolean): IStream;
   {* - ��������� ������ � ���� �����.  aOnlyFirstLevel - �\��� ���������. }
  function ListAsString(aSaveListKind: TbsSaveListKind;
   SaveSelection: Boolean;
   aFormat: TnsFileFormat): Il3CString;
  function MergeDocuments(aOnlyFirstLevel: Boolean;
   aOnlySelection: Boolean;
   const aFileName: Il3CString;
   aFormat: TnsFileFormat;
   NeedPrintTopic: Boolean = True): Boolean;
   {* - ��������� ���������� ��������� � ���� ���� � ��������� �������. ��������, ���� �������, �� ������ "�����: <���������� ����� ���������>".
���������� ������� ����, ��� ����-�� ��������� }
  function RefreshFilters: Boolean;
   {* - ������������� �������. }
  function IsActiveFilter(const aFilter: IFilterFromQuery): Boolean;
   {* - �������� �� ������ ������ �����������. }
  function NodeId(const aNode: Il3SimpleNode): Integer;
   {* - �������� ������������� ����. }
  function MakeDocumentPreview: IafwComplexDocumentPreview;
   {* - ��������������� �������� ��� �������� ���������. }
  function ListNodeType(const aNode: Il3SimpleNode = nil): TbsListNodeType;
   {* - ��� ���� ������. }
  function OpenListFromSelectedNodes: IdeList;
   {* - ������� ������ �� ���������� ���������. }
  function ApplyLogicOperation(const aList: IDynList;
   aOperation: TListLogicOperation): Boolean;
   {* - ��������� ���������� �������� �� �������. }
  function ApplyContextFilter(const aFilter: IContextFilter): INodeBase;
   {* - ��������� ����������� ������. }
  procedure SaveToFile(const aFileName: Tl3WString;
   aOnlySelected: Boolean);
   {* - ��� �� �������� ���������� ���������� ECannotSave. }
  procedure ReleaseNodeForPositioning;
   {* - }
  function CreateBookmark: IBookmark;
   {* - �������� �������� �� ������� ��������. }
  function MakeSuperPreview(aOnlyFirstLevel: Boolean = True;
   WithTexts: Boolean = True): InsSuperComplexDocumentPreview;
   {* ������� ���������������� ������ }
  function MakeMultiDocumentPreview(aOnlyFirstLevel: Boolean): IafwComplexDocumentPreview;
   {* ������� ������ � �������� ���������� }
  function As_IucbBaseSearchSupportQuery: IucbBaseSearchSupportQuery;
   {* ����� ���������� ������ ���������� � IucbBaseSearchSupportQuery }
  property IsSaved: Boolean
   read pm_GetIsSaved;
   {* - ������ ��� ��������. }
  property ListName: Il3CString
   read pm_GetListName;
   {* - �������� ������. }
  property ShortListName: Il3CString
   read pm_GetShortListName;
   {* - �������� �������� ������. }
  property IsChanged: Boolean
   read pm_GetIsChanged;
   {* - ������� ������������ ������. }
  property IsFiltered: Boolean
   read pm_GetIsFiltered;
   {* - ������ ��� ������������. }
  property IsListEmpty: Boolean
   read pm_GetIsListEmpty;
   {* - ������ �� ������; }
  property IsTimeMachineEnable: Boolean
   read pm_GetIsTimeMachineEnable;
   {* - �������� �� ��� ������������� ������ �������. }
  property TimeMachineOff: Boolean
   read pm_GetTimeMachineOff;
   {* -  ��� ��������� ��������� ������ ������ ������� ����� ���������. }
  property ListType: TbsListType
   read pm_GetListType;
   {* - ��� ������. }
  property List: IDynList
   read pm_GetList;
   {* - ������. }
  property IsMain: Boolean
   read pm_GetIsMain;
   {* - ���������� ������ � �������� ���� ����������. }
  property NodeForPositioning: Il3SimpleNode
   read pm_GetNodeForPositioning;
   {* - ���� �� ������� ����� ������������������ � ����� ������ }
  property AllDocumentFiltered: Boolean
   read pm_GetAllDocumentFiltered;
   {* - ��� ��������� �������������. }
  property HasAttributes: Boolean
   read pm_GetHasAttributes;
   {* - ���� �� ���������� � ���������. }
  property ActiveFilters: IFiltersFromQuery
   read Get_ActiveFilters;
 end;//IdsList

 IdsDocumentList = interface(IdsList)
  {* C����� ���������� }
  ['{A5984F14-F052-4704-943E-AA80B8CD0595}']
  function pm_GetDocumentListType: TlstCRType;
  function pm_GetSortOrder: TbsSortOrder;
  function pm_GetSortType: TbsSortType;
  function pm_GetValidSortTypes: TbsValidSortTypes;
  function pm_GetHasSimilarDocuments: Boolean;
  function pm_GetHasAnnotation: Boolean;
  function pm_GetHasCorrespondents: Boolean;
  function pm_GetHasRelatedDoc: Boolean;
  function pm_GetHasRespondents: Boolean;
  function pm_GetIsUnderControl: Boolean;
  function pm_GetIsDocument: Boolean;
  function pm_GetCRTypeNode: Il3Node;
  function pm_GetCRTypeRoot: Il3Node;
  function pm_GetOpenFrom: TbsListOpenFrom;
  function pm_GetCRTypeName: Il3CString;
  function pm_GetIsListNotFull: Boolean;
  function pm_GetCurrentRelevance: Integer;
  function pm_GetIsShortList: Boolean;
  function pm_GetIsSnippet: Boolean;
  function Get_FullListCount: Integer;
  function ChangeCRType(const aNode: Il3Node): Boolean;
   {* - ���������� ��� ��������� ���� ���������������/������������. }
  function ChangeSortOrder(const aTreeSource: Il3SimpleTree;
   const aCurrentNode: Il3SimpleNode): Il3SimpleTree;
   {* - �������� ������� ����������. }
  function ChangeSortType(const aTreeSource: Il3SimpleTree;
   const aCurrentNode: Il3SimpleNode;
   aValue: TbsSortType): Il3SimpleTree;
   {* - �������� ��� ����������. }
  function Find(const aContext: Il3CString;
   const aFrom: Il3SimpleNode): Il3SimpleNode;
   {* - ����� ��������� ���� ������� �� ���������. }
  procedure AddToControl;
   {* - ��������� �������� �� ��������. }
  procedure DelFromControl;
   {* - ����� � ��������. }
  function CanAddToControl: Boolean;
   {* - ����� �� ������� �� ��������. }
  function MakeFullList: IdeDocumentList;
   {* ������������ �� ������ ������ }
  function CanAnalize: Boolean;
  function MakeAnalizeTree: Il3SimpleTree;
  property DocumentListType: TlstCRType
   read pm_GetDocumentListType;
   {* - ��� �������� ������. }
  property SortOrder: TbsSortOrder
   read pm_GetSortOrder;
   {* - ������� ���������� ������. }
  property SortType: TbsSortType
   read pm_GetSortType;
   {* - ��� ����������. }
  property ValidSortTypes: TbsValidSortTypes
   read pm_GetValidSortTypes;
   {* - ��������� ���� ����������. }
  property HasSimilarDocuments: Boolean
   read pm_GetHasSimilarDocuments;
   {* - ������� ������� ����������. }
  property HasAnnotation: Boolean
   read pm_GetHasAnnotation;
   {* - ���� �� ��������� � ���������. }
  property HasCorrespondents: Boolean
   read pm_GetHasCorrespondents;
   {* - ���� �� ��������������. }
  property HasRelatedDoc: Boolean
   read pm_GetHasRelatedDoc;
   {* - ���� �� � ��������� �������. }
  property HasRespondents: Boolean
   read pm_GetHasRespondents;
   {* - ���� �� �����������. }
  property IsUnderControl: Boolean
   read pm_GetIsUnderControl;
   {* - ��������� �� �������� �� ��������. }
  property IsDocument: Boolean
   read pm_GetIsDocument;
   {* - ���������� �������� �� ������� ������� ������ ���������� (��������,            ��������, ����). }
  property CRTypeNode: Il3Node
   read pm_GetCRTypeNode;
   {* - ��������� ���. }
  property CRTypeRoot: Il3Node
   read pm_GetCRTypeRoot;
   {* - Root ��� ���������� ������ ����� ���. }
  property OpenFrom: TbsListOpenFrom
   read pm_GetOpenFrom;
   {* - ������� �������� ������. }
  property CRTypeName: Il3CString
   read pm_GetCRTypeName;
   {* - �������� ���� ��, ������� ����������� ������. }
  property IsListNotFull: Boolean
   read pm_GetIsListNotFull;
   {* - ������ �������� �� ������, ��������� ��������� ��������� �             ������������� ������. }
  property CurrentRelevance: Integer
   read pm_GetCurrentRelevance;
   {* - ������������� �������� ��������. }
  property IsShortList: Boolean
   read pm_GetIsShortList;
   {* ����������� �� ������ }
  property IsSnippet: Boolean
   read pm_GetIsSnippet;
  property FullListCount: Integer
   read Get_FullListCount;
 end;//IdsDocumentList

 IucbDocumentWithContents = interface
  ['{11497B7B-E215-409B-AD0A-889B60BF9AB1}']
  function Get_DsContents: IdsBaseContents;
  procedure OpenContents(const aTree: IdeSimpleTree;
   anForceOpen: TnsContentsOpenMode;
   const aContainerOfDocument: InevDocumentContainer);
  property dsContents: IdsBaseContents
   read Get_DsContents;
 end;//IucbDocumentWithContents

 IbsChangeRedactionWorker = interface
  {* ������ �������� �������� ��������� }
  ['{9541A196-A1B9-4805-8F10-FA151733C6EF}']
  function Change(const aDocInfo: IdeDocInfo): Boolean;
   {* ������� �������� ���������, � ����������� �� �������� ������ (�������
             �� ������, �� ����, �� �������������� �������� � �.�.) }
 end;//IbsChangeRedactionWorker

 IsdsGotoPointDataMaker = interface(IUnknown)
  ['{E4C6E0F5-C12B-47C3-A977-CAF04790C58B}']
  function MakeGotoPointData(const aDocument: IDocument;
   aRefType: TDocumentPositionType;
   aPos: Longword): IdeDocInfo;
   {* ������� ������. ���� ������ ������� ������������ ������, �� ������ ���
           ����� ������ ��������� ��� ��������� ��� ������ �������� ������ }
 end;//IsdsGotoPointDataMaker

 IdsDocument = interface(IdsBaseDocument)
  {* ������ ������ ����� "TextForm" }
  ['{7AD512A9-DBE3-4E00-B836-F6FBE8C5ECF3}']
  function pm_GetHasSimilarDocuments: Boolean;
  procedure OpenSimilarDocuments;
   {* ������� ������ ������� ���������� }
  procedure OpenSimilarDocumentsToFragment(aBlockId: Integer);
  function GetSubPosition(aSubID: Integer): IevdHyperlinkInfo;
  function As_IucbDocumentWithContents: IucbDocumentWithContents;
   {* ����� ���������� ������ ���������� � IucbDocumentWithContents }
  function As_IucbDocumentFromList: IucbDocumentFromList;
   {* ����� ���������� ������ ���������� � IucbDocumentFromList }
  function As_IucbBaseSearchSupportQuery: IucbBaseSearchSupportQuery;
   {* ����� ���������� ������ ���������� � IucbBaseSearchSupportQuery }
  property HasSimilarDocuments: Boolean
   read pm_GetHasSimilarDocuments;
   {* ������� ������� ���������� }
 end;//IdsDocument

 IbsUserCRListInfo = interface
  {* ���������� � ���������������� ��� }
  ['{1A2349F4-A32F-4932-B3DE-6D2427736FE9}']
  function pm_GetHas: Boolean;
  function pm_GetKindOfList: TbsUserCRList;
  function pm_GetCaption: Il3CString;
  function pm_GetListType: TlstCRType;
  function pm_GetNode: IbsFrozenNode;
  function IsSame(const aValue: IbsUserCRListInfo): Boolean;
   {* ���������� ��������� }
  property Has: Boolean
   read pm_GetHas;
   {* ����������� ��������� ������ ��� ���������� � ���������� ������� ������ }
  property KindOfList: TbsUserCRList
   read pm_GetKindOfList;
   {* ��� ������ ���������������� ��� ������ }
  property Caption: Il3CString
   read pm_GetCaption;
   {* �������� ���������� ������� }
  property ListType: TlstCRType
   read pm_GetListType;
   {* ��� ������ ��������� ������������� (������������� ��� �����������) }
  property Node: IbsFrozenNode
   read pm_GetNode;
   {* ��������� ���������������� ������ ������ }
 end;//IbsUserCRListInfo

 IbsUserCRListInfoModify = interface(IbsUserCRListInfo)
  {* ���������� � ���������������� ��� � ������������ ��������� }
  ['{07BCD9BD-1DF2-4D65-8ECB-D9F4B576740B}']
  procedure pm_SetWListType(aValue: TlstCRType);
  procedure pm_SetWKindOfList(aValue: TbsUserCRList);
  procedure pm_SetWNode(const aValue: IbsFrozenNode);
  procedure pm_SetWHas(aValue: Boolean);
  procedure Assign(const aValue: IbsUserCRListInfo);
   {* ����������� ������ }
  property wListType: TlstCRType
   write pm_SetWListType;
  property wKindOfList: TbsUserCRList
   write pm_SetWKindOfList;
  property wNode: IbsFrozenNode
   write pm_SetWNode;
  property wHas: Boolean
   write pm_SetWHas;
 end;//IbsUserCRListInfoModify

 IdBaseDocument = interface(IvcmData)
  {* ������ ������ ���������. }
  ['{C9D189DB-86F6-437C-B191-F332CAA1899F}']
  function pm_GetDsDocumentRef: IvcmFormDataSourceRef;
  function pm_GetHasDocument: Tl3Bool;
  procedure pm_SetHasDocument(aValue: Tl3Bool);
  function pm_GetDocInfo: IdeDocInfo;
  procedure pm_SetDocInfo(const aValue: IdeDocInfo);
  property dsDocumentRef: IvcmFormDataSourceRef
   read pm_GetDsDocumentRef;
   {* ������ �� "���������� ��������" }
  property HasDocument: Tl3Bool
   read pm_GetHasDocument
   write pm_SetHasDocument;
   {* ���� �� "���������� ��������" }
  property DocInfo: IdeDocInfo
   read pm_GetDocInfo
   write pm_SetDocInfo;
   {* DocInfo }
 end;//IdBaseDocument

 IdsDocumentWithFlash = interface(IdsDocument)
  {* Flash-����� }
  ['{51FAFEE4-FD67-4ECB-AFE7-ED4F11FFEC77}']
 end;//IdsDocumentWithFlash

 InsWarningGenerator = interface
  ['{57C27A24-88D3-43F9-AC47-3177B7AC29C1}']
  function Generate(const aWarning: IdsWarning;
   const aGen: InevTagGenerator;
   aUserType: TvcmUserType): TWarningTypeSet;
   {* ��������� �������� � ���, ����� �������������� ���� � ���������. ���� ��� �� ������ ��������������, �� �������� cEmptyWarning }
 end;//InsWarningGenerator

 IsdsPrimDocument = interface(IvcmUseCaseController)
  ['{ADA58FCB-76E7-4423-BE89-EE01B5245904}']
  function pm_GetDocInfo: IdeDocInfo;
  property DocInfo: IdeDocInfo
   read pm_GetDocInfo;
 end;//IsdsPrimDocument

 IsdsBaseDocument = interface(IvcmUseCaseController)
  {* ���, ������� ��� ����������� � ���������� }
  ['{E7C1773D-11B5-4510-B3B3-50F1B2266ABA}']
  function pm_GetDsDocument: IdsBaseDocument;
  function pm_GetHasDocument: Boolean;
  function pm_GetDsDocumentRef: IvcmViewAreaControllerRef;
  function pm_GetDocInfo: IdeDocInfo;
  function ChangeDocument(const aDoc: IdeDocInfo): Boolean;
   {* ��������� �������� }
  function As_IsdsGotoPointDataMaker: IsdsGotoPointDataMaker;
   {* ����� ���������� ������ ���������� � IsdsGotoPointDataMaker }
  function As_IsdsPrimDocument: IsdsPrimDocument;
   {* ����� ���������� ������ ���������� � IsdsPrimDocument }
  property dsDocument: IdsBaseDocument
   read pm_GetDsDocument;
   {* ���������� �������� }
  property HasDocument: Boolean
   read pm_GetHasDocument;
   {* ���������� ��� ���� ������ ��� "���������� ��������" }
  property dsDocumentRef: IvcmViewAreaControllerRef
   read pm_GetDsDocumentRef;
   {* ������ �� "���������� ��������" }
  property DocInfo: IdeDocInfo
   read pm_GetDocInfo;
 end;//IsdsBaseDocument

 IsdsEditionsHolder = interface
  ['{A55DBB3A-49A5-4836-BF8A-EC33B1DFCA24}']
  function pm_GetEditionsList: IdsEditions;
  property EditionsList: IdsEditions
   read pm_GetEditionsList;
   {* ������ �������� }
 end;//IsdsEditionsHolder

 IdsAACContainer = interface(IvcmViewAreaController)
  {* ���������� �����-����������, � ������� ����������� ��� �������� ��������� ��� }
  ['{11C6F772-4065-4090-B89E-23C7A3C07A47}']
 end;//IdsAACContainer

const
 cBooleanToContentsOpenMode: TnsBooleanToContentsOpenModeConverter = (ns_comNotForce, ns_comForce);

function TnsContentsListIndex_C(aListType: TnsContentsListType;
 anIndex: Integer): TnsContentsListIndex;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

function TnsContentsListIndex_C(aListType: TnsContentsListType;
 anIndex: Integer): TnsContentsListIndex;
//#UC START# *4D41890002DF_4D4188BD030B_var*
//#UC END# *4D41890002DF_4D4188BD030B_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4D41890002DF_4D4188BD030B_impl*
 Result.rListType := aListType;
 Result.rIndex := anIndex;
//#UC END# *4D41890002DF_4D4188BD030B_impl*
end;//TnsContentsListIndex_C
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
