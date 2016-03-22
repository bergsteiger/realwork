unit DocumentUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/DocumentUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Document
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  BaseTypesUnit,
  FoldersUnit,
  DynamicTreeUnit,
  ExternalObjectUnit,
  UnderControlUnit
  ;

type
 TLinkedObjectType = (
  {* ��� �������, �� ������� ��������� �������������� ������. }
   LO_DOCUMENT // ��������.
 , LO_RELATED_DOCUMENT // ������� � ���������.
 , LO_EXTERNAL_OBJECT // ������� ������.
 , LO_MULTILINK // ������������ (������ ����������).
 , LO_EXTERNAL_LINK // ������� ������.
 , LO_QUERY // ������.
 , LO_BOOKMARK // ��������
 , LO_EXTERNAL_OPERATION
 , LO_ENO // ������ �� ENO
 , LO_AUTOREFERAT // �����������
 , LO_SCRIPT // ������ ��� �271754146
 , LO_DELETED_FOLDERS_CONTENT
 );//TLinkedObjectType

 IMissingInfo = interface(IUnknown)
  {* ���������� �� ������������� ���������. }
   ['{5553DE6A-23C5-4B12-8A98-358CF08F6E59}']
   function GetObjName: IString; stdcall;
   function GetBlocksInfo: IString; stdcall;
   function IsOneBlock: ByteBool; stdcall;
     {* ������������� ������ ���������� ������ � ����� ����� (����) - ���������� ��� ����������� ��������� ��������� � ���, � �����(��) �����(��) ���������� ������������� ������.  ���� � blocks_info ���������� ������ ���� ����, �� ������������ true, � ��������� ������ false. }
   property obj_name: IString
     read GetObjName;
     {* ��� �������������� �������. }
   property blocks_info: IString
     read GetBlocksInfo;
     {* ����� ������ (���), � ������� ���������� ������������� ������. }
 end;//IMissingInfo

 InvalidParaId = class
  {* �������� ������������� ��������� }
 end;//InvalidParaId

 TTimeMachineWarningType = (
   TMWT_RED
 , TMWT_YELLOW
 );//TTimeMachineWarningType

const
  { PositionInDocument }
 POSITION_TYPE_MASK : Cardinal = 2147483648;
 POSITION_TYPE_SUB_ID : Cardinal = 0;
 POSITION_TYPE_PARA_ID : Cardinal = 2147483648;

type
 TTimeMachineWarning = record
   warning : IString;
   type : TTimeMachineWarningType;
 end;//TTimeMachineWarning

 InvalidTopicId = class
  {* ������������ ��� ������� ��������� �������� � ���������� ��������������� ���������, �������������� � ����. }
 end;//InvalidTopicId

 TPositionType = (
   PT_SUB
 , PT_PARA
 , PT_BOOKMARK
 );//TPositionType

 TPosition = record
  {* ����� ����� � ��������. }
   type : TPositionType; // ���� ������������ �������� ���� point. ���� true �� point ��������� �� ��������, � ��������� ������ �� ��� ��� ����.
   point : Cardinal; // ����� �����.
 end;//TPosition

 IPositionList = array of TPosition;
  {* ������ ����� ��� ������ � ���������. }

 TTopic = record
  {* ���������� �������������� �������� ������ ����������. }
   pid : TPId;
   position : TPosition;
 end;//TTopic

 TParaId = Cardinal;
  {* ������������� ��������� (��� ���� ���������, ������� ������ ���������� ����) }

 TDocumentType = (
  {* ��� ��������� }
   DT_DOCUMENT
 , DT_EXPLANATORY
 , DT_AUTO_REFERAT
 , DT_BOOK
 , DT_TIP // ����� ���
 , DT_MEDICAL_EXPLANATORY // ������� ������� ���. ��������
 , DT_MEDICAL_FIRM // �������� � ��������� ����� �� ������
 , DT_MEDICAL_DOCUMENT
 , DT_FLASH // ��������-����
 , DT_ACTUAL_ANALYTICS // ���
 , DT_ACTUAL_ANALYTICS_CONTENTS // ���-����������
 , DT_REF // ����� � www ��������
 );//TDocumentType

 FolderLinkNotFound = class
  {* �� ������� ������ �� �������� ������� (�������� �� ��� ������) }
 end;//FolderLinkNotFound

 TRedactionID = Integer;
  {* ������������� �������� ������� (������ ����� ��������� � ObjectId). }

 IActiveIntervalList = array of TDateInterval;

 TNotSureInfo = record
   warning : IString;
   interval : TDateInterval;
 end;//TNotSureInfo

 INotSureIntervalList = array of TNotSureInfo;

 TRedactionType = (
  {* ��� �������� �������. }
   RT_ACTUAL // ��������
 , RT_ACTUAL_ABOLISHED // �������� �� �������� DS_ABOLISHED (������� ����)
 , RT_ACTUAL_PREACTIVE // �������� �� �������� DS_PREACTIVE (�� ������� � ����)
 , RT_OLD // �������� � ������� �������� �� ����������, � ������� ��� �� DS_ABOLISHED, �� DS_PREACTIVE
 , RT_NEW // �������� � ������� �������� ����� ����������, � ������� ��� �� DS_ABOLISHED, �� DS_PREACTIVE
 , RT_NEW_ABOLISHED
 , RT_NEW_PREACTIVE // �������� �� �������� DS_PREACTIVE (�� ������� � ����)
 );//TRedactionType

 TRedactionSourceDocumentInfo = record
   display_name : IString; // ���������� �������� (�� ��� ������������)
   doc_topic : TTopic; // ����� ��� �������� � ���������� ��������
 end;//TRedactionSourceDocumentInfo

 IRedactionSourceDocumentInfoList = array of TRedactionSourceDocumentInfo;

 RedactionNotFound = class
  {* ������������ � ������ ������� ��������� �������������� �������� �������. }
 end;//RedactionNotFound

 TLinkKind = (
  {* ��� ����� }
   LK_INTERNAL_INVALID
 , LK_REGULAR
 , LK_EXTERNAL
 , LK_ABOLISHED // ������ �� ���������� ���� ��������
 , LK_PREACTIVE // ������ �� �� ���������� � ���� ��������
 , LK_ENO // ������ �� ��
 , LK_EDITION // �������� ���������
 , LK_SCRIPT // ������ �� ������
 );//TLinkKind

 TLinkInfo = record
   kind : TLinkKind; // ��� �����
   hint : IString;
 end;//TLinkInfo

 InvalidDate = class
 end;//InvalidDate

 ExplanationDictionaryNotInstalled = class
  {* �������� ������� �� ���������� � �������.
������������ � ������ ������ �������� "����� ����������" � ���������� � ������� ��������� �������. }
 end;//ExplanationDictionaryNotInstalled

 TFactoryKey = (
   FK_DOCUMENT_MASTER
 , FK_DOCUMENT_DELEGATE
 , FK_DICT_DOCUMENT
 , FK_PHARM_DICT_DOCUMENT
 , FK_PHARM_DOCUMENT
 , FK_PHARM_FIRM_DOCUMENT
 , FK_TIP_DOCUMENT
 , FK_TRANSLATED_DOCUMENT
 , FK_SIMPLE_DOCUMENT
 , FK_FLASH_DOCUMENT
 , FK_AUTOREFERAT_DOCUMENT
 , FK_ACTUAL_ANALYTICS_CONTENTS_DOCUMENT
 , FK_ACTUAL_ANALYTICS_DOCUMENT
 , FK_REF
 , FK_BOOK
 );//TFactoryKey

 TParaNum = Integer;
  {* ������ ���������� ���������� � ������� ������ ������� ��������� }

 IDiffIterator = interface(IUnknown)
  {* [$175966492]
*  �������� "��������� ���������" � "���������� ���������" ������ �������� ������������ ������� ������� (���� �� �� ������) ��� ������������ �������� ���� ��������� � ������.
* �������� "��������� ���������" ������ �������� ������ �� ����� ��������� (�� �������� � ������ �� �����)
* �������� "���������� ���������" ������ �������� ������ �� ������ ��������� (�� �������� � ����� �� �����) }
   ['{A9AA18D9-F87F-4A47-988B-789AA069EEE0}']
   function HasNext: ByteBool; stdcall;
   function HasPrev: ByteBool; stdcall;
   function Next: TParaNum; stdcall; // can raise CanNotFindData
   function AcquireNext: TParaNum; stdcall;
   function Prev: TParaNum; stdcall; // can raise CanNotFindData
   function AcquirePrev: TParaNum; stdcall;
   procedure MoveTo(aPara: TParaNum); stdcall; // can raise CanNotFindData
 end;//IDiffIterator

 TLayerID = Cardinal;

 InvalidObjectClass = class
 end;//InvalidObjectClass

 NoPrevRedaction = class
 end;//NoPrevRedaction

 TChildID = Cardinal;

 TEntryPoint = record
   layer : TLayerID;
   child : TChildID;
//#UC START# *4C5AA60F039Bpubl*
//#UC END# *4C5AA60F039Bpubl*
 end;//TEntryPoint

 TContext = record
   path : INodeIndexPath;
   start : Integer;
   finish : Integer;
 end;//TContext

 TEVDType = Byte;

 TExternalID = Integer;

 TEVDStream = IOUnit.IStream;

 InvalidEntryPoint = class
 end;//InvalidEntryPoint

 InvalidLayerID = class
 end;//InvalidLayerID

 TBookmark2 = record
   para_id : TExternalID;
   eid : Cardinal;
   name : IString;
 end;//TBookmark2

 IBookmarkList = array of TBookmark2;

 IFragmentList = array of TContext;

 ISubList = array of Cardinal;

 IContextList = array of IFragmentList;

 IFoundContext = interface(IUnknown)
   ['{2852766C-A9A5-4A40-8C9F-FD957D1D856E}']
   function GetList: IContextList; stdcall;
   property list: IContextList
     read GetList;
 end;//IFoundContext

 IDocumentTextProvider = interface(IUnknown)
   ['{EDE34F9F-F36F-48FA-82BA-FD755CE46B4B}']
   function GetChildType(const aId: TEntryPoint): TEVDType; stdcall; // can raise InvalidEntryPoint
   function GetChildLayerId(const aId: TEntryPoint): TLayerID; stdcall; // can raise InvalidEntryPoint
   function GetChildExternalId(const aId: TEntryPoint): TExternalID; stdcall; // can raise InvalidEntryPoint
   procedure GetChildEvdStyle(const aId: TEntryPoint; out aRet {: TEVDStream}); stdcall; // can raise InvalidEntryPoint
   procedure GetChildComment(const aId: TEntryPoint; out aRet {: TEVDStream}); stdcall; // can raise InvalidEntryPoint
   procedure SetChildComment(const aId: TEntryPoint;
    const aComment: TEVDStream); stdcall; // can raise InvalidEntryPoint
   procedure RemoveChildComment(const aId: TEntryPoint); stdcall;
   procedure GetChildBookmarks(const aId: TEntryPoint; out aRet {: IBookmarkList}); stdcall; // can raise EmptyResult, InvalidEntryPoint
   procedure GetChildText(const aId: TEntryPoint; out aRet {: IString}); stdcall; // can raise InvalidEntryPoint
   procedure GetChildTechComment(const aId: TEntryPoint; out aRet {: IString}); stdcall; // can raise InvalidEntryPoint
   function AllLeafParaCount(aLayerId: TLayerID): Cardinal; stdcall; // can raise InvalidLayerID
   function ChildrenCount(aLayerId: TLayerID): Cardinal; stdcall; // can raise InvalidLayerID
   procedure FindBlockOrSub(aId: TExternalID; out aRet {: INodeIndexPath}); stdcall; // can raise CanNotFindData
   procedure FindPara(aId: TExternalID; out aRet {: INodeIndexPath}); stdcall; // can raise CanNotFindData
   procedure FindContext(const aContext: IString;
    aFromId: TExternalID; out aRet {: IFoundContext}); stdcall; // can raise CanNotFindData
   procedure GetSubList(const aId: TEntryPoint; out aRet {: ISubList}); stdcall;
   procedure GetPrefixTree(aId: TExternalID; out aRet {: INodeBase}); stdcall;
   function ShowSubPanelIcon(aId: TExternalID): ByteBool; stdcall;
     {* ����� �� ���������� ������ ��� ����� �� ��������� }
   function HasSame(aId: TExternalID): ByteBool; stdcall;
     {* ���� ���� ������� � sub ������ true, ����� false. }
 end;//IDocumentTextProvider

 IDocumentTextProviderList = array of IDocumentTextProvider;

const
  { TextProviderConstants }
 ROOT_CHILD : TChildID = 0;
 ROOT_LAYER : TLayerID = 4294967295;
  { 0xFFFFFFFF }

type
 ICommentsParaList = array of TParaId;

 TExternalObjectData = record
   type : TExternalObjectType;
   para_id : TParaId;
   name : IString;
 end;//TExternalObjectData

 IExternalObjectDataList = array of TExternalObjectData;

 TDiffData = record
   diff_iterator : IDiffIterator;
   cur : IDocumentTextProvider;
   prev : IDocumentTextProvider;
 end;//TDiffData

 TDocumentTextProviderDescriptor = record
   handle : Cardinal;
   header_leaf_count : Cardinal;
   anno_leaf_count : Cardinal;
 end;//TDocumentTextProviderDescriptor

 IDocumentTextProviderDescriptorList = array of TDocumentTextProviderDescriptor;

 TSubId = Cardinal;

 TDocPoint = record
  {* ����� ����� � �������� (���� DocId SubId) }
   doc_id : TBaseTypesObjectId; // ������������� ���������
   sub_id : TSubId; // ����� ����/�����
 end;//TDocPoint

 IDocPointList = array of TDocPoint;
  {* ������ ����� ����� � �������� }

 ILikeable = interface(IUnknown)
   ['{CD879569-CC93-4E02-B56F-C5C1B3FBBEBC}']
   function GetCanLike: ByteBool; stdcall;
   procedure Like; stdcall;
     {* �������� }
   procedure Unlike; stdcall;
     {* �� �������� }
   property can_like: ByteBool
     read GetCanLike;
     {* ����������� �������� ������ }
 end;//ILikeable

 TRedactionInfo = record
  {* ���������� � �������� �������. }
   name : IString; // ��� ��������.
   time_machine_date : TDate;
   doc_date : TDate;
   is_comparable : Boolean;
   actual_type : TRedactionType;
   not_sure_intervals : INotSureIntervalList;
   active_intervals : IActiveIntervalList;
   id : TRedactionID;
   changing_documents : IRedactionSourceDocumentInfoList;
 end;//TRedactionInfo

 TDiffDocPara = record
   text : IString;
   style : TEVDStream;
   data : IStream;
   type : TEVDType;
   id : Integer;
 end;//TDiffDocPara

 IDiffDocParaList = array of TDiffDocPara;

 TChangedBlock = record
   id : Cardinal;
   header : IDiffDocParaList; // �������� ����������� ������� � ��������� �� ������������ �����, ��������� � ����������,
�������  ������������ ���������� �������� (����)
   right_text_para_list : IDiffDocParaList; // ���������� �������� ������ ��������
   left_text_para_list : IDiffDocParaList; // ���������� �������� ����� ��������
 end;//TChangedBlock

 IRedactionInfoList = array of TRedactionInfo;
  {* ������ ��������. }

 IBookmark = interface;
 { - ��������������� �������� Bookmark. }

 IDocumentState = interface;
 { - ��������������� �������� DocumentState. }

 IJournalBookmark = interface;
 { - ��������������� �������� JournalBookmark. }

 ILink = interface;
 { - ��������������� �������� Link. }

 IDocument = interface(IEntityBase)
  {* ��������� �������������� ������ � ����������. }
   ['{2906776F-DD41-403A-AF10-DDD0F9BD6590}']
   function GetName: IString; stdcall;
   function GetShortName: IString; stdcall;
   function GetWarning: IString; stdcall;
   function GetSize: Cardinal; stdcall;
   function GetInternalId: Cardinal; stdcall;
   function GetNotTm: ByteBool; stdcall;
   function GetFilePosition: IString; stdcall;
   function GetNewRevisionAvailable: ByteBool; stdcall;
   function GetChangeStatus: Cardinal; stdcall;
   function GetStatus: TItemStatus; stdcall;
   function GetTextLanguages: ILanguagesList; stdcall;
   function GetAttributesRoot: INodeBase; stdcall;
   function GetRedactionsList: IRedactionInfoList; stdcall;
   function GetCurrentState: IDocumentState; stdcall;
   function GetDocType: TDocumentType; stdcall;
   function GetTranslation: IDocument; stdcall;
   function GetAnnotation: IDocument; stdcall;
   function GetRelatedDoc: IDocument; stdcall;
   function GetContentsRoot: INodeBase; stdcall;
   function GetBookmarkList: IBookmarkList; stdcall;
   function GetCommentsParaList: ICommentsParaList; stdcall;
   function GetExternalObjectDataList: IExternalObjectDataList; stdcall;
   procedure CreateBookmark(aPara: TParaId;
    aIsPara: Boolean
    {* ���� ����������� �� �� ��� � ������ ��������� ����������� ��������, � ��������� ������ ���.}; out aRet {: IBookmark}); stdcall;
     {* ������� ��������� �������� �� �������� ������������� ���������. ����������� �� � �������� �������� �������� ��� ���������. � � �������� full_name ��� ��������� � ��� ���������� (������) ���� ��� ����� (��� � �������). }
   procedure CreateView(var aFilters: IDocumentState; out aRet {: IDocument}); stdcall;
     {* ���������� �������� - ��������, ���������� �����  filters.
���� ������� �������� ����� ���������� - ���������� NULL }
   procedure GetCorrespondentsToPart(const aPosList: IPositionList
    {* ������ �������.};
    const aCategory: INodeBase
    {* ��������� ����������};
    out aOutList: ICatalogBase); stdcall;
     {* ���������� ������ ��������������� � ��������� ��������� (������ ����������) ��� ��������� ��������� (category).

��� ��������, ������� �� "�������", ���������� NULL }
   procedure GetInternetImageUrl(aBlockId: Integer; out aRet {: IExternalLink}); stdcall;
     {* �������� url ��� ���������������� WWW-������ ���������. }
   procedure GetLinkedObject(aDocId: Cardinal;
    const aId: TTopic;
    aRid: TRedactionID;
    out aObjType: TLinkedObjectType;
    out aObj: IUnknown); stdcall; // can raise InvalidTopicId, FolderLinkNotFound
     {* �������� ��������� �������, �� ������� ��������� �������������� ������, �� ����������� ��������������.
������������ ��������� �� ������ (obj) � ��� ������� (obj_type).
������������� ����� �������� ��������� (missing_info) � �����������, � ����� ������ (�����) ���������� ������������� ������ (����� get_missing_info)
����� �������������� ��� �������� �� �������������� ������. }
   procedure GetNotSureInfo(const aDate: TDate;
    var aStart: TDate;
    var aFinish: TDate;
    out aInfo: IDocument;
    out aWarning: IString); stdcall;
     {* ���������� ���������� �� ��������� ������������� ���������. ���� ��������� � ��������� date ���� �� �������� � �������� ������� CanNotFindData }
   procedure GetRespondentsToPart(const aPosList: IPositionList
    {* ������ �������.};
    const aCategory: INodeBase
    {* ��������� ����������.};
    out aOutList: ICatalogBase); stdcall;
     {* ���������� ������ ������������ � ��������� ��������� (������ ����������) ��� ��������� ��������� (category).

��� ��������, ������� �� "�������", ���������� NULL }
   function GetTimeMachineWarning(const aDate: TDate): TTimeMachineWarning; stdcall;
   function HasCorrespondents(const aCategory: INodeBase): ByteBool; stdcall;
     {* �������� ������� ��������������� (������ ���������) � �������� ���������.
���������� true � ������, ���� ������ ��������������� ��� ��������� �� ��������� CR_ALL �� ����.

��� ��������, �������� �� "�������", ���������� FALSE }
   function HasInternetImage: ByteBool; stdcall;
     {* �������� ������� WWW-������ � �������� ���������.
���������� true � ������, ���� � �������� ��������� ���� WWW-�����. }
   function HasNextRedaction: ByteBool; stdcall;
     {* ������� ���������� ������� ��������� �������� ��� �������.
��������� �������� ��������� ������������ �������� ��������� (current_redaction).
���������� True � ������ ������� ������ ����� ����� ������� (��� �������) ��������. }
   function HasPrevRedaction: ByteBool; stdcall;
     {* ������� ���������� ������� ���������� �������� ��� �������.
���������� �������� ��������� ������������ �������� ��������� (current_redaction).
���������� True � ������ ������� ������ ����� ����� ������ (��� �������) ��������. }
   function HasRelatedDoc: ByteBool; stdcall;
     {* �������� ������� ������� � �������� ���������.
���������� true � ������, ���� � �������� ��������� ���� �������.

��� ��������, �������� �� "�������", ��������� ����� �� ��� � ��� "�������" }
   function HasRespondents(const aCategory: INodeBase): ByteBool; stdcall;
     {* �������� ������� ������������ (������ ���������) � �������� ���������.
���������� true � ������, ���� ������ ������������ ��� ��������� �� ��������� CR_ALL �� ����.

��� ��������, �������� �� "�������", ���������� FALSE }
   function HasAnnotation: ByteBool; stdcall;
   function HasAttributes: ByteBool; stdcall;
     {* ��� ���������� ���� DT_BOOK ���������� false,
��� ��������� true }
   function HasWarning: ByteBool; stdcall;
     {* ����������� ��������������. }
   function IsAlive: ByteBool; stdcall;
     {* ����������� �����, ����������� �������� "���" �� �������� �� ������� ����������. ���� �������� "���" - ������������ `true` (��� ������� ����� �������� �����, ����� �������� ����� ���� ������, �������� �� ����� ���������� ����). ���������� ������� ������ �� ���������� �� ��������, �.�. ����� ����� ������ ������ ���������� � ������� ����������. }
   function IsDateInNotSureInterval(const aDate: TDate): ByteBool; stdcall;
     {* ����� ��������� ���������� �������� �� date � �������� ������������� ���������. }
   function IsMyBookmark(const aBookmark: IBookmark): ByteBool; stdcall;
   function IsSameDocument(const aDoc: IDocument): ByteBool; stdcall;
   function IsSameRedaction(const aView: IDocument): ByteBool; stdcall;
   function IsSameView(const aView: IDocument): ByteBool; stdcall;
     {* ���������� ��������� ���������� � ������ �� ��������� (� ������� �� is_same_entity, ������� ���������� ��������� ��� ����� ���������). ���������� ��������� �������� ������������ ������ ��������, ����� � ������ ����������. }
   function MayShowAttributes: ByteBool; stdcall;
     {* �������� ����������� ����������� ��������� ��������� ��� �������� ���������.
���������� true � ������, ���� ����� ��������� ��������.

��� �������� ����������� ��������, �������������� �������� (�.�. �������������� ������ �������� ) }
   procedure GetCorrespondents(const aCategory: INodeBase;
    out aOutList: ICatalogBase); stdcall;
   procedure GetRespondents(const aCategory: INodeBase;
    out aOutList: ICatalogBase); stdcall;
   function HasTranslation: ByteBool; stdcall;
     {* ���� �� � ��������� ������� }
   function HasSameDocuments: ByteBool; stdcall;
     {* �������� ������� ������� ���������� }
   procedure GetSameDocuments(out aOutList: ICatalogBase); stdcall;
     {* �������� ������ ������� ���������� }
   procedure GetServerDoc; stdcall;
   function IsMorphoSearchSupported: ByteBool; stdcall;
     {* ������������ �� �������� ��� ����������� }
   function GetLinkInfo(aDocId: Cardinal;
    const aId: TTopic;
    aRid: TRedactionID): TLinkInfo; stdcall;
   procedure GetMissingInfoForObject(const aPid: TPId;
    out aMissingInfo: IMissingInfo); stdcall;
     {* ���������� ����������� ���������� �� �������������� ������� (pid - ������������� � ����� ������� �� ������) }
   procedure GetDrugList(out aRet {: ICatalogBase}); stdcall; // can raise CanNotFindData
     {* �������� ������ ����������� ������ ���������� }
   procedure GetFlash(out aRet {: IExternalObject}); stdcall;
     {* ��������� ����-������ }
   procedure CreateJournalBookmark(aPara: TParaId; out aRet {: IJournalBookmark}); stdcall;
     {* ������� ���������� �������� }
   function GetAutoReferatDocCount: size; stdcall; // can raise Unsupported
     {* ������� ����� ���������� ��� ������������ }
   procedure GetTextProvider(aAllAtOnce: Boolean; out aRet {: IDocumentTextProvider}); stdcall; // can raise Unsupported, CanNotFindData
   procedure GetTextProviderDescList(out aRet {: IDocumentTextProviderDescriptorList}); stdcall; // can raise Unsupported
   procedure GetTextProviderByDesc(aHandle: Cardinal; out aRet {: IDocumentTextProvider}); stdcall; // can raise Unsupported
   procedure GetTextProviderList(aAllAtOnce: Boolean; out aRet {: IDocumentTextProviderList}); stdcall; // can raise Unsupported
   procedure GetAutoreferatHeaderEvd(out aRet {: IStream}); stdcall; // can raise Unsupported
   procedure GetAnnotationHeaderEvd(aHandle: Cardinal; out aRet {: IStream}); stdcall; // can raise Unsupported
   function Diff(aPid): TDiffData; stdcall;
   procedure GetEvdStream(out aRet {: IStream}); stdcall;
     {* ���������� evd ����� ��������� - ������ ��� ��� evd ����� �������� ��� �������������� � ���� ��������� ��� ��������� ������������ � ��������� }
   procedure GetSelfMissingInfo(out aMissingInfo: IMissingInfo); stdcall;
     {* �������� ����������� ���������� �� �������� ��������� (� ������ ��� ���������� - � ����� ������ ���� �������� ������������) }
   procedure GetMultiLinkInfo(aDocId: Cardinal;
    const aId: TTopic; out aRet {: IDocPointList}); stdcall; // can raise CanNotFindData, InternalDatabaseError
     {* �������� ������ �� ����n������� � ���� ������ (DocId, SubId) }
   procedure DontShowDocumentStatusChangesWarning; stdcall;
     {* �� ���������� ������ ��������� ������� ��������� � ������� ������ }
   procedure GetRedactionPid; stdcall;
   function HasChronology: ByteBool; stdcall;
     {* ���� �� � ��������� ���������� ������������ ��������� ����
K555095873 }
   procedure GetLink(aDocId: Cardinal;
    const aId: TTopic;
    aRid: TRedactionID; out aRet {: ILink}); stdcall;
   procedure GetSameToPoint(aId: TExternalID;
    out aOutList: ICatalogBase); stdcall;
   property name: IString
     read GetName;
     {* ��� ���������. }
   property short_name: IString
     read GetShortName;
     {* ������� ��� ���������. }
   property warning: IString
     read GetWarning;
     {* �������������� � ���������. }
   property size: Cardinal
     read GetSize;
     {* ������ ��������� � ������ }
   property internal_id: Cardinal
     read GetInternalId;
     {* ���������� ����� ��������� � ���� }
   property not_tm: ByteBool
     read GetNotTm;
     {* True - ���� �������� �� ��������� � ������ ������� }
   property file_position: IString
     read GetFilePosition;
   property new_revision_available: ByteBool
     read GetNewRevisionAvailable;
     {* �������� ����� ������� ��������� (��� �������������� ������) }
   property change_status: Cardinal
     read GetChangeStatus;
     {* ������ ��������� ��������� }
   property status: TItemStatus
     read GetStatus;
     {* ������ ��������� }
   property text_languages: ILanguagesList
     read GetTextLanguages;
   property attributes_root: INodeBase
     read GetAttributesRoot;
   property redactions_list: IRedactionInfoList
     read GetRedactionsList;
   property current_state: IDocumentState
     read GetCurrentState;
   property doc_type: TDocumentType
     read GetDocType;
   property translation: IDocument
     read GetTranslation;
   property annotation: IDocument
     read GetAnnotation;
   property related_doc: IDocument
     read GetRelatedDoc;
   property contents_root: INodeBase
     read GetContentsRoot;
   property bookmark_list: IBookmarkList
     read GetBookmarkList;
   property comments_para_list: ICommentsParaList
     read GetCommentsParaList;
   property external_object_data_list: IExternalObjectDataList
     read GetExternalObjectDataList;
 end;//IDocument

 IBookmark = interface(IEntityBase)
  {* �������� �� ��������. ������������ ��� ���������� ��������� (� �������) � ������. }
   ['{830AC32A-C3AC-4AA1-A5A1-0ACAE229DD2A}']
   function GetName: IString; stdcall;
   procedure SetName(const aValue: IString); stdcall;
   function GetComment: IString; stdcall;
   procedure SetComment(const aValue: IString); stdcall;
   function GetParagraph: TParaId; stdcall;
   function GetPid: TPId; stdcall;
   function GetDocument: IDocument; stdcall;
   property name: IString
     read GetName
     write SetName;
     {* ��������� ��������. ������������ � �������� caption � ������. }
   property comment: IString
     read GetComment
     write SetComment;
     {* ������ ��� ��������� � �����/���� �� ������� ��������� ��������. ������������ � �������� hint  � ������. }
   property paragraph: TParaId
     read GetParagraph;
   property pid: TPId
     read GetPid;
   property document: IDocument
     read GetDocument;
 end;//IBookmark

 IDocumentState = interface(IUnknown)
  {* ��������� ��� ������ � ���������� �������. }
   ['{71C2A950-3D61-44A9-A0FA-845C4A9F5B97}']
   function GetLanguage: TLanguages; stdcall;
   procedure SetLanguage(aValue: TLanguages); stdcall;
   function GetPrevRedactionsList: IRedactionInfoList; stdcall;
   function GetCurAndNextRedactionsList: IRedactionInfoList; stdcall;
   procedure SetPrevRedaction; stdcall; // can raise RedactionNotFound
     {* �������� ������������� � �������� ������� ���������� �������� �������.
���� ���������� �������� ���, �� ������������ RedactionNotFound. }
   procedure SetNextRedaction; stdcall; // can raise RedactionNotFound
     {* �������� ������������� � �������� ������� ��������� �������� �������.
���� ��������� �������� ���, �� ������������ RedactionNotFound. }
   procedure SetRedactionOnDate(const aDate: TDate); stdcall; // can raise RedactionNotFound
   procedure SetRedactionOnId(aId: TRedactionID); stdcall; // can raise RedactionNotFound
     {* �������� ������������� � �������� ������� �������� � �������� ���������������.
���������� True � ������ ���� ������� ��������� ���������� � False, ���� �������� ��� �� �����, ��� � �� ������ ������.
���� ����� �������� ������������� ��������, �� ������������ InvalidRedactionId. }
   procedure SetActualRedaction; stdcall; // can raise RedactionNotFound
     {* �������� ������������� � �������� ������� ��������, ���������� �������� ��� ������� ���������.
���������� True � ������ ���� ������� ��������� ���������� � False, ���� �������� ��� �� �����, ��� � �� ������ ������. }
   function Redaction: TRedactionID; stdcall;
   function GetCurrentRedaction: TRedactionInfo; stdcall;
   function IsSameRedactions(const aOther: IDocumentState): ByteBool; stdcall;
   function DiffWithRedactionById(aId: TRedactionID): TDiffData; stdcall;
   procedure Clone(out aRet {: IDocumentState}); stdcall;
   procedure SetPrevActiveRedaction; stdcall; // can raise RedactionNotFound
     {* Get��������������������������������. [$178325284] }
   function CanCompareWithAnyOtherRedaction: ByteBool; stdcall;
     {* [$178325284] }
   function IsActual: ByteBool; stdcall;
     {* ���������� true, ���� ��� �������� ����������, �. �. ����� ���:
- RT_ACTUAL
- RT_ACTUAL_ABOLISHED
- RT_ACTUAL_PREACTIVE }
   property language: TLanguages
     read GetLanguage
     write SetLanguage;
   property prev_redactions_list: IRedactionInfoList
     read GetPrevRedactionsList;
   property cur_and_next_redactions_list: IRedactionInfoList
     read GetCurAndNextRedactionsList;
     {* [$178324034] }
 end;//IDocumentState

 AllChangesInTables = class
 end;//AllChangesInTables

 IJournalBookmark = interface(IEntityBase)
  {* ���������� �������� }
   ['{7EC5D2E1-6B5C-4C7E-AE21-C98E21A8D018}']
   function GetName: IString; stdcall;
   function GetFullName: IString; stdcall;
   function GetParaId: Cardinal; stdcall;
   function GetDocument: IDocument; stdcall;
   procedure GetJournalBookmark; stdcall;
     {* ��������  ��������� ���������� �������� }
   property name: IString
     read GetName;
     {* ��� }
   property full_name: IString
     read GetFullName;
     {* ������ ��� (����) }
   property para_id: Cardinal
     read GetParaId;
   property document: IDocument
     read GetDocument;
 end;//IJournalBookmark

 TDocumentLayerID = TLayerID;

 ILink = interface(IUnknown)
   ['{FBA5DE98-0FAD-4647-B2DE-AB788A6DDFE6}']
   function GetObjectType: TLinkedObjectType; stdcall;
   procedure GetObject(out aRet {: IUnknown}); stdcall; // can raise InvalidTopicId, FolderLinkNotFound
   function GetLinkInfo: TLinkInfo; stdcall;
   procedure GetLinkedHint(out aRet {: IString}); stdcall;
   function GetKind: TLinkKind; stdcall;
 end;//ILink

 IJournalBookmarkList = array of IJournalBookmark;

 IDiffDocDataProvider = interface(IUnknown)
   ['{E9D2FB7F-1DE5-4C75-8998-72B6C443FF03}']
   function GetAllLeafParaCount: Cardinal; stdcall;
   procedure GetHeaderParaList(out aRet {: IDiffDocParaList}); stdcall;
     {* ��������� ��������� ������� ��:

����� "����� ��������� ���������"
������� ��� ��������� (!Name)
����� "������������ ���������� �������� "������" 
����� "����� ��������� ������������ ��������� ��������:" }
   function GetDateParaRight(out aPara: TDiffDocPara): ByteBool; stdcall;
     {* �������� � ������ ��������� ��������� ��� ������� ��������� }
   function GetDateParaLeft(out aPara: TDiffDocPara): ByteBool; stdcall;
     {* �������� � ������ ��������� ��������� ��� ������ ��������� }
   function GetRedactionNameRight: TDiffDocPara; stdcall;
     {* ������ ������� ����� ��������� ���������� ����� �������� (��� ��� �������� ��� ������� ���������) }
   function GetRedactionNameLeft: TDiffDocPara; stdcall;
     {* ������ ������� ����� ��������� ���������� ����� �������� (��� ��� �������� ��� ������ ���������) }
   function GetChangedBlockCount: Cardinal; stdcall;
   function GetChangedBlock(aI: Cardinal): TChangedBlock; stdcall;
 end;//IDiffDocDataProvider

 IObjectFromLink = interface(IUnknown)
   ['{51778307-FE15-45BF-9A86-62A66BF81725}']
   procedure GetObject(out aRet {: IUnknown}); stdcall;
   function GetObjectType: TLinkedObjectType; stdcall;
 end;//IObjectFromLink

implementation

end.