unit DocumentUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DocumentUnit.pas"
// ���������: "Interfaces"
// ������� ������: "Document" MUID: (4570511E038A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , FoldersUnit
 , DynamicTreeUnit
 , ExternalObjectUnit
 , UnderControlUnit
;

const
 POSITION_TYPE_MASK: Cardinal = 2147483648;
 POSITION_TYPE_SUB_ID: Cardinal = 0;
 POSITION_TYPE_PARA_ID: Cardinal = 2147483648;

type
 TLinkedObjectType = (
  {* ��� �������, �� ������� ��������� �������������� ������. }
  LO_DOCUMENT
   {* ��������. }
  , LO_RELATED_DOCUMENT
   {* ������� � ���������. }
  , LO_EXTERNAL_OBJECT
   {* ������� ������. }
  , LO_MULTILINK
   {* ������������ (������ ����������). }
  , LO_EXTERNAL_LINK
   {* ������� ������. }
  , LO_QUERY
   {* ������. }
  , LO_BOOKMARK
   {* �������� }
  , LO_EXTERNAL_OPERATION
  , LO_ENO
   {* ������ �� ENO }
  , LO_AUTOREFERAT
   {* ����������� }
  , LO_SCRIPT
   {* ������ ��� �271754146 }
  , LO_DELETED_FOLDERS_CONTENT
 );//TLinkedObjectType

 IMissingInfo = interface
  {* ���������� �� ������������� ���������. }
  ['{5553DE6A-23C5-4B12-8A98-358CF08F6E59}']
  function GetObjName: IString; stdcall;
  function GetBlocksInfo: IString; stdcall;
  function IsOneBlock: ByteBool; stdcall;
   {* ������������� ������ ���������� ������ � ����� ����� (����) - ���������� ��� ����������� ��������� ��������� � ���, � �����(��) �����(��) ���������� ������������� ������.  ���� � blocks_info ���������� ������ ���� ����, �� ������������ true, � ��������� ������ false. }
  property ObjName: IString
   read GetObjName;
   {* ��� �������������� �������. }
  property BlocksInfo: IString
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

 TTimeMachineWarning = record
  warning: IString;
  type: TTimeMachineWarningType;
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
  type: TPositionType;
   {* ���� ������������ �������� ���� point. ���� true �� point ��������� �� ��������, � ��������� ������ �� ��� ��� ����. }
  point: Cardinal;
   {* ����� �����. }
 end;//TPosition

 IPositionList = array of TPosition;
  {* ������ ����� ��� ������ � ���������. }

 TTopic = record
  {* ���������� �������������� �������� ������ ����������. }
  pid: TPId;
  position: TPosition;
 end;//TTopic

 TParaId = Cardinal;
  {* ������������� ��������� (��� ���� ���������, ������� ������ ���������� ����) }

 TDocumentType = (
  {* ��� ��������� }
  DT_DOCUMENT
  , DT_EXPLANATORY
  , DT_AUTO_REFERAT
  , DT_BOOK
  , DT_TIP
   {* ����� ��� }
  , DT_MEDICAL_EXPLANATORY
   {* ������� ������� ���. �������� }
  , DT_MEDICAL_FIRM
   {* �������� � ��������� ����� �� ������ }
  , DT_MEDICAL_DOCUMENT
  , DT_FLASH
   {* ��������-���� }
  , DT_ACTUAL_ANALYTICS
   {* ��� }
  , DT_ACTUAL_ANALYTICS_CONTENTS
   {* ���-���������� }
  , DT_REF
   {* ����� � www �������� }
 );//TDocumentType

 FolderLinkNotFound = class
  {* �� ������� ������ �� �������� ������� (�������� �� ��� ������) }
 end;//FolderLinkNotFound

 TRedactionID = Integer;
  {* ������������� �������� ������� (������ ����� ��������� � ObjectId). }

 IActiveIntervalList = array of TDateInterval;

 TNotSureInfo = record
  warning: IString;
  interval: TDateInterval;
 end;//TNotSureInfo

 INotSureIntervalList = array of TNotSureInfo;

 TRedactionType = (
  {* ��� �������� �������. }
  RT_ACTUAL
   {* �������� }
  , RT_ACTUAL_ABOLISHED
   {* �������� �� �������� DS_ABOLISHED (������� ����) }
  , RT_ACTUAL_PREACTIVE
   {* �������� �� �������� DS_PREACTIVE (�� ������� � ����) }
  , RT_OLD
   {* �������� � ������� �������� �� ����������, � ������� ��� �� DS_ABOLISHED, �� DS_PREACTIVE }
  , RT_NEW
   {* �������� � ������� �������� ����� ����������, � ������� ��� �� DS_ABOLISHED, �� DS_PREACTIVE }
  , RT_NEW_ABOLISHED
  , RT_NEW_PREACTIVE
   {* �������� �� �������� DS_PREACTIVE (�� ������� � ����) }
 );//TRedactionType

 TRedactionSourceDocumentInfo = record
  display_name: IString;
   {* ���������� �������� (�� ��� ������������) }
  doc_topic: TTopic;
   {* ����� ��� �������� � ���������� �������� }
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
  , LK_ABOLISHED
   {* ������ �� ���������� ���� �������� }
  , LK_PREACTIVE
   {* ������ �� �� ���������� � ���� �������� }
  , LK_ENO
   {* ������ �� �� }
  , LK_EDITION
   {* �������� ��������� }
  , LK_SCRIPT
   {* ������ �� ������ }
 );//TLinkKind

 TLinkInfo = record
  kind: TLinkKind;
   {* ��� ����� }
  hint: IString;
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

 IDiffIterator = interface
  {* [$175966492]
*  �������� "��������� ���������" � "���������� ���������" ������ �������� ������������ ������� ������� (���� �� �� ������) ��� ������������ �������� ���� ��������� � ������.
* �������� "��������� ���������" ������ �������� ������ �� ����� ��������� (�� �������� � ������ �� �����)
* �������� "���������� ���������" ������ �������� ������ �� ������ ��������� (�� �������� � ����� �� �����) }
  ['{A9AA18D9-F87F-4A47-988B-789AA069EEE0}']
  function HasNext: ByteBool; stdcall;
  function HasPrev: ByteBool; stdcall;
  function Next: TParaNum; stdcall; { can raise CanNotFindData }
  function AcquireNext: TParaNum; stdcall;
  function Prev: TParaNum; stdcall; { can raise CanNotFindData }
  function AcquirePrev: TParaNum; stdcall;
  procedure MoveTo(para: TParaNum); stdcall; { can raise CanNotFindData }
 end;//IDiffIterator

 TLayerID = Cardinal;

 InvalidObjectClass = class
 end;//InvalidObjectClass

 NoPrevRedaction = class
 end;//NoPrevRedaction

 TChildID = Cardinal;

 TEntryPoint = record
  layer: TLayerID;
  child: TChildID;
 //#UC START# *4C5AA60F039Bpubl*
 //#UC END# *4C5AA60F039Bpubl*
 end;//TEntryPoint

 TContext = record
  path: INodeIndexPath;
  start: Integer;
  finish: Integer;
 end;//TContext

 TEVDType = Byte;

 TExternalID = Integer;

 TEVDStream = IStream;

 InvalidEntryPoint = class
 end;//InvalidEntryPoint

 InvalidLayerID = class
 end;//InvalidLayerID

 TBookmark2 = record
  para_id: TExternalID;
  eid: Cardinal;
  name: IString;
 end;//TBookmark2

 IBookmarkList = array of TBookmark2;

 IFragmentList = array of TContext;

 ISubList = array of Cardinal;

 IContextList = array of IFragmentList;

 IFoundContext = interface
  ['{2852766C-A9A5-4A40-8C9F-FD957D1D856E}']
  function GetList: IContextList; stdcall;
  property List: IContextList
   read GetList;
 end;//IFoundContext

 IDocumentTextProvider = interface
  ['{EDE34F9F-F36F-48FA-82BA-FD755CE46B4B}']
  function GetChildType(const id: TEntryPoint): TEVDType; stdcall; { can raise InvalidEntryPoint }
  function GetChildLayerId(const id: TEntryPoint): TLayerID; stdcall; { can raise InvalidEntryPoint }
  function GetChildExternalId(const id: TEntryPoint): TExternalID; stdcall; { can raise InvalidEntryPoint }
  function GetChildEvdStyle(const id: TEntryPoint): TEVDStream; stdcall; { can raise InvalidEntryPoint }
  function GetChildComment(const id: TEntryPoint): TEVDStream; stdcall; { can raise InvalidEntryPoint }
  procedure SetChildComment(const id: TEntryPoint;
   const comment: TEVDStream); stdcall; { can raise InvalidEntryPoint }
  procedure RemoveChildComment(const id: TEntryPoint); stdcall;
  function GetChildBookmarks(const id: TEntryPoint): IBookmarkList; stdcall; { can raise EmptyResult, InvalidEntryPoint }
  function GetChildText(const id: TEntryPoint): IString; stdcall; { can raise InvalidEntryPoint }
  function GetChildTechComment(const id: TEntryPoint): IString; stdcall; { can raise InvalidEntryPoint }
  function AllLeafParaCount(layer_id: TLayerID): Cardinal; stdcall; { can raise InvalidLayerID }
  function ChildrenCount(layer_id: TLayerID): Cardinal; stdcall; { can raise InvalidLayerID }
  function FindBlockOrSub(id: TExternalID): INodeIndexPath; stdcall; { can raise CanNotFindData }
  function FindPara(id: TExternalID): INodeIndexPath; stdcall; { can raise CanNotFindData }
  function FindContext(const context: IString;
   from_id: TExternalID): IFoundContext; stdcall; { can raise CanNotFindData }
  function GetSubList(const id: TEntryPoint): ISubList; stdcall;
  function GetPrefixTree(id: TExternalID): INodeBase; stdcall;
  function ShowSubPanelIcon(id: TExternalID): ByteBool; stdcall;
   {* ����� �� ���������� ������ ��� ����� �� ��������� }
  function HasSame(id: TExternalID): ByteBool; stdcall;
   {* ���� ���� ������� � sub ������ true, ����� false. }
 end;//IDocumentTextProvider

 IDocumentTextProviderList = array of IDocumentTextProvider;

 ICommentsParaList = array of TParaId;

 TExternalObjectData = record
  type: TExternalObjectType;
  para_id: TParaId;
  name: IString;
 end;//TExternalObjectData

 IExternalObjectDataList = array of TExternalObjectData;

 TDiffData = record
  diff_iterator: IDiffIterator;
  cur: IDocumentTextProvider;
  prev: IDocumentTextProvider;
 end;//TDiffData

 TDocumentTextProviderDescriptor = record
  handle: Cardinal;
  header_leaf_count: Cardinal;
  anno_leaf_count: Cardinal;
 end;//TDocumentTextProviderDescriptor

 IDocumentTextProviderDescriptorList = array of TDocumentTextProviderDescriptor;

 TSubId = Cardinal;

 TDocPoint = record
  {* ����� ����� � �������� (���� DocId SubId) }
  doc_id: TBaseTypesObjectId;
   {* ������������� ��������� }
  sub_id: TSubId;
   {* ����� ����/����� }
 end;//TDocPoint

 IDocPointList = array of TDocPoint;
  {* ������ ����� ����� � �������� }

 ILikeable = interface
  ['{CD879569-CC93-4E02-B56F-C5C1B3FBBEBC}']
  function GetCanLike: ByteBool; stdcall;
  procedure Like; stdcall;
   {* �������� }
  procedure Unlike; stdcall;
   {* �� �������� }
  property CanLike: ByteBool
   read GetCanLike;
   {* ����������� �������� ������ }
 end;//ILikeable

 TRedactionInfo = record
  {* ���������� � �������� �������. }
  name: IString;
   {* ��� ��������. }
  time_machine_date: TDate;
  doc_date: TDate;
  is_comparable: ByteBool;
  actual_type: TRedactionType;
  not_sure_intervals: INotSureIntervalList;
  active_intervals: IActiveIntervalList;
  id: TRedactionID;
  changing_documents: IRedactionSourceDocumentInfoList;
 end;//TRedactionInfo

 TDiffDocPara = record
  text: IString;
  style: TEVDStream;
  data: IStream;
  type: TEVDType;
  id: Integer;
 end;//TDiffDocPara

 IDiffDocParaList = array of TDiffDocPara;

 TChangedBlock = record
  id: Cardinal;
  header: IDiffDocParaList;
   {* �������� ����������� ������� � ��������� �� ������������ �����, ��������� � ����������,
�������  ������������ ���������� �������� (����) }
  right_text_para_list: IDiffDocParaList;
   {* ���������� �������� ������ �������� }
  left_text_para_list: IDiffDocParaList;
   {* ���������� �������� ����� �������� }
 end;//TChangedBlock

 IRedactionInfoList = array of TRedactionInfo;
  {* ������ ��������. }

 IBookmark = interface;

 IDocumentState = interface;

 IJournalBookmark = interface;

 ILink = interface;

 IDocument = interface(IEntityBase)
  {* ��������� �������������� ������ � ����������. }
  ['{2906776F-DD41-403A-AF10-DDD0F9BD6590}']
  function GetName: IString; stdcall;
  function GetShortName: IString; stdcall;
  function GetWarning: IString; stdcall;
  function GetSize: Cardinal; stdcall;
  function GetInternalId: Cardinal; stdcall;
  function GetNotTm: ByteBool; stdcall;
  function GetFilePosition: IString; stdcall; { can raise CanNotFindData }
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
  function GetContentsRoot: INodeBase; stdcall; { can raise CanNotFindData }
  function GetBookmarkList: IBookmarkList; stdcall;
  function GetCommentsParaList: ICommentsParaList; stdcall;
  function GetExternalObjectDataList: IExternalObjectDataList; stdcall;
  function CreateBookmark(para: TParaId;
   is_para: Boolean
   {* ���� ����������� �� �� ��� � ������ ��������� ����������� ��������, � ��������� ������ ���. }): IBookmark; stdcall;
   {* ������� ��������� �������� �� �������� ������������� ���������. ����������� �� � �������� �������� �������� ��� ���������. � � �������� full_name ��� ��������� � ��� ���������� (������) ���� ��� ����� (��� � �������). }
  function CreateView(var filters: IDocumentState): IDocument; stdcall;
   {* ���������� �������� - ��������, ���������� �����  filters.
���� ������� �������� ����� ���������� - ���������� NULL }
  procedure GetCorrespondentsToPart(const pos_list: IPositionList
   {* ������ �������. };
   const category: INodeBase
   {* ��������� ���������� };
   out out_list: ICatalogBase); stdcall;
   {* ���������� ������ ��������������� � ��������� ��������� (������ ����������) ��� ��������� ��������� (category).

��� ��������, ������� �� "�������", ���������� NULL }
  function GetInternetImageUrl(block_id: Integer): IExternalLink; stdcall;
   {* �������� url ��� ���������������� WWW-������ ���������. }
  procedure GetLinkedObject(doc_id: Cardinal;
   const id: TTopic;
   rid: TRedactionID;
   out obj_type: TLinkedObjectType;
   out obj: IUnknown); stdcall; { can raise InvalidTopicId, FolderLinkNotFound }
   {* �������� ��������� �������, �� ������� ��������� �������������� ������, �� ����������� ��������������.
������������ ��������� �� ������ (obj) � ��� ������� (obj_type).
������������� ����� �������� ��������� (missing_info) � �����������, � ����� ������ (�����) ���������� ������������� ������ (����� get_missing_info)
����� �������������� ��� �������� �� �������������� ������. }
  procedure GetNotSureInfo(const date: TDate;
   var start: TDate;
   var finish: TDate;
   out info: IDocument;
   out warning: IString); stdcall;
   {* ���������� ���������� �� ��������� ������������� ���������. ���� ��������� � ��������� date ���� �� �������� � �������� ������� CanNotFindData }
  procedure GetRespondentsToPart(const pos_list: IPositionList
   {* ������ �������. };
   const category: INodeBase
   {* ��������� ����������. };
   out out_list: ICatalogBase); stdcall;
   {* ���������� ������ ������������ � ��������� ��������� (������ ����������) ��� ��������� ��������� (category).

��� ��������, ������� �� "�������", ���������� NULL }
  function GetTimeMachineWarning(const date: TDate): TTimeMachineWarning; stdcall;
  function HasCorrespondents(const category: INodeBase): ByteBool; stdcall;
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
  function HasRespondents(const category: INodeBase): ByteBool; stdcall;
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
  function IsDateInNotSureInterval(const date: TDate): ByteBool; stdcall;
   {* ����� ��������� ���������� �������� �� date � �������� ������������� ���������. }
  function IsMyBookmark(const bookmark: IBookmark): ByteBool; stdcall;
  function IsSameDocument(const doc: IDocument): ByteBool; stdcall;
  function IsSameRedaction(const view: IDocument): ByteBool; stdcall;
  function IsSameView(const view: IDocument): ByteBool; stdcall;
   {* ���������� ��������� ���������� � ������ �� ��������� (� ������� �� is_same_entity, ������� ���������� ��������� ��� ����� ���������). ���������� ��������� �������� ������������ ������ ��������, ����� � ������ ����������. }
  function MayShowAttributes: ByteBool; stdcall;
   {* �������� ����������� ����������� ��������� ��������� ��� �������� ���������.
���������� true � ������, ���� ����� ��������� ��������.

��� �������� ����������� ��������, �������������� �������� (�.�. �������������� ������ �������� ) }
  procedure GetCorrespondents(const category: INodeBase;
   out out_list: ICatalogBase); stdcall;
  procedure GetRespondents(const category: INodeBase;
   out out_list: ICatalogBase); stdcall;
  function HasTranslation: ByteBool; stdcall;
   {* ���� �� � ��������� ������� }
  function HasSameDocuments: ByteBool; stdcall;
   {* �������� ������� ������� ���������� }
  procedure GetSameDocuments(out out_list: ICatalogBase); stdcall;
   {* �������� ������ ������� ���������� }
  procedure GetServerDoc; stdcall;
  class function Make(const document): BadFactoryType; overload; stdcall;
  class function Make(const pid;
   is_edition: Boolean;
   name: PAnsiChar): BadFactoryType; overload; stdcall;
  function IsMorphoSearchSupported: ByteBool; stdcall;
   {* ������������ �� �������� ��� ����������� }
  function GetLinkInfo(doc_id: Cardinal;
   const id: TTopic;
   rid: TRedactionID): TLinkInfo; stdcall;
  procedure GetMissingInfoForObject(const pid: TPId;
   out missing_info: IMissingInfo); stdcall;
   {* ���������� ����������� ���������� �� �������������� ������� (pid - ������������� � ����� ������� �� ������) }
  function GetDrugList: ICatalogBase; stdcall; { can raise CanNotFindData }
   {* �������� ������ ����������� ������ ���������� }
  function GetFlash: IExternalObject; stdcall;
   {* ��������� ����-������ }
  function CreateJournalBookmark(para: TParaId): IJournalBookmark; stdcall;
   {* ������� ���������� �������� }
  function GetAutoReferatDocCount: size; stdcall; { can raise Unsupported }
   {* ������� ����� ���������� ��� ������������ }
  function GetTextProvider(all_at_once: Boolean): IDocumentTextProvider; stdcall; { can raise Unsupported, CanNotFindData }
  function GetTextProviderDescList: IDocumentTextProviderDescriptorList; stdcall; { can raise Unsupported }
  function GetTextProviderByDesc(handle: Cardinal): IDocumentTextProvider; stdcall; { can raise Unsupported }
  function GetTextProviderList(all_at_once: Boolean): IDocumentTextProviderList; stdcall; { can raise Unsupported }
  function GetAutoreferatHeaderEvd: IStream; stdcall; { can raise Unsupported }
  function GetAnnotationHeaderEvd(handle: Cardinal): IStream; stdcall; { can raise Unsupported }
  function Diff(const pid): TDiffData; stdcall;
  function GetEvdStream: IStream; stdcall;
   {* ���������� evd ����� ��������� - ������ ��� ��� evd ����� �������� ��� �������������� � ���� ��������� ��� ��������� ������������ � ��������� }
  procedure GetSelfMissingInfo(out missing_info: IMissingInfo); stdcall;
   {* �������� ����������� ���������� �� �������� ��������� (� ������ ��� ���������� - � ����� ������ ���� �������� ������������) }
  function GetMultiLinkInfo(doc_id: Cardinal;
   const id: TTopic): IDocPointList; stdcall; { can raise CanNotFindData, InternalDatabaseError }
   {* �������� ������ �� ����n������� � ���� ������ (DocId, SubId) }
  procedure DontShowDocumentStatusChangesWarning; stdcall;
   {* �� ���������� ������ ��������� ������� ��������� � ������� ������ }
  procedure GetRedactionPid; stdcall;
  function HasChronology: ByteBool; stdcall;
   {* ���� �� � ��������� ���������� ������������ ��������� ����
K555095873 }
  function GetLink(doc_id: Cardinal;
   const id: TTopic;
   rid: TRedactionID): ILink; stdcall;
  procedure GetSameToPoint(id: TExternalID;
   out out_list: ICatalogBase); stdcall;
  property Name: IString
   read GetName;
   {* ��� ���������. }
  property ShortName: IString
   read GetShortName;
   {* ������� ��� ���������. }
  property Warning: IString
   read GetWarning;
   {* �������������� � ���������. }
  property Size: Cardinal
   read GetSize;
   {* ������ ��������� � ������ }
  property InternalId: Cardinal
   read GetInternalId;
   {* ���������� ����� ��������� � ���� }
  property NotTm: ByteBool
   read GetNotTm;
   {* True - ���� �������� �� ��������� � ������ ������� }
  property FilePosition: IString
   read GetFilePosition;
  property NewRevisionAvailable: ByteBool
   read GetNewRevisionAvailable;
   {* �������� ����� ������� ��������� (��� �������������� ������) }
  property ChangeStatus: Cardinal
   read GetChangeStatus;
   {* ������ ��������� ��������� }
  property Status: TItemStatus
   read GetStatus;
   {* ������ ��������� }
  property TextLanguages: ILanguagesList
   read GetTextLanguages;
  property AttributesRoot: INodeBase
   read GetAttributesRoot;
  property RedactionsList: IRedactionInfoList
   read GetRedactionsList;
  property CurrentState: IDocumentState
   read GetCurrentState;
  property DocType: TDocumentType
   read GetDocType;
  property Translation: IDocument
   read GetTranslation;
  property Annotation: IDocument
   read GetAnnotation;
  property RelatedDoc: IDocument
   read GetRelatedDoc;
  property ContentsRoot: INodeBase
   read GetContentsRoot;
  property BookmarkList: IBookmarkList
   read GetBookmarkList;
  property CommentsParaList: ICommentsParaList
   read GetCommentsParaList;
  property ExternalObjectDataList: IExternalObjectDataList
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
  property Name: IString
   read GetName
   write SetName;
   {* ��������� ��������. ������������ � �������� caption � ������. }
  property Comment: IString
   read GetComment
   write SetComment;
   {* ������ ��� ��������� � �����/���� �� ������� ��������� ��������. ������������ � �������� hint  � ������. }
  property Paragraph: TParaId
   read GetParagraph;
  property Pid: TPId
   read GetPid;
  property Document: IDocument
   read GetDocument;
 end;//IBookmark

 IDocumentState = interface
  {* ��������� ��� ������ � ���������� �������. }
  ['{71C2A950-3D61-44A9-A0FA-845C4A9F5B97}']
  function GetLanguage: TLanguages; stdcall;
  procedure SetLanguage(aValue: TLanguages); stdcall;
  function GetPrevRedactionsList: IRedactionInfoList; stdcall;
  function GetCurAndNextRedactionsList: IRedactionInfoList; stdcall;
  procedure SetPrevRedaction; stdcall; { can raise RedactionNotFound }
   {* �������� ������������� � �������� ������� ���������� �������� �������.
���� ���������� �������� ���, �� ������������ RedactionNotFound. }
  procedure SetNextRedaction; stdcall; { can raise RedactionNotFound }
   {* �������� ������������� � �������� ������� ��������� �������� �������.
���� ��������� �������� ���, �� ������������ RedactionNotFound. }
  procedure SetRedactionOnDate(const date: TDate); stdcall; { can raise RedactionNotFound }
  procedure SetRedactionOnId(id: TRedactionID); stdcall; { can raise RedactionNotFound }
   {* �������� ������������� � �������� ������� �������� � �������� ���������������.
���������� True � ������ ���� ������� ��������� ���������� � False, ���� �������� ��� �� �����, ��� � �� ������ ������.
���� ����� �������� ������������� ��������, �� ������������ InvalidRedactionId. }
  procedure SetActualRedaction; stdcall; { can raise RedactionNotFound }
   {* �������� ������������� � �������� ������� ��������, ���������� �������� ��� ������� ���������.
���������� True � ������ ���� ������� ��������� ���������� � False, ���� �������� ��� �� �����, ��� � �� ������ ������. }
  function Redaction: TRedactionID; stdcall;
  function GetCurrentRedaction: TRedactionInfo; stdcall;
  function IsSameRedactions(const other: IDocumentState): ByteBool; stdcall;
  function DiffWithRedactionById(id: TRedactionID): TDiffData; stdcall;
  function Clone: IDocumentState; stdcall;
  procedure SetPrevActiveRedaction; stdcall; { can raise RedactionNotFound }
   {* Get��������������������������������. [$178325284] }
  function CanCompareWithAnyOtherRedaction: ByteBool; stdcall;
   {* [$178325284] }
  function IsActual: ByteBool; stdcall;
   {* ���������� true, ���� ��� �������� ����������, �. �. ����� ���:
- RT_ACTUAL
- RT_ACTUAL_ABOLISHED
- RT_ACTUAL_PREACTIVE }
  property Language: TLanguages
   read GetLanguage
   write SetLanguage;
  property PrevRedactionsList: IRedactionInfoList
   read GetPrevRedactionsList;
  property CurAndNextRedactionsList: IRedactionInfoList
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
  property Name: IString
   read GetName;
   {* ��� }
  property FullName: IString
   read GetFullName;
   {* ������ ��� (����) }
  property ParaId: Cardinal
   read GetParaId;
  property Document: IDocument
   read GetDocument;
 end;//IJournalBookmark

 TDocumentLayerID = TLayerID;

 ILink = interface
  ['{FBA5DE98-0FAD-4647-B2DE-AB788A6DDFE6}']
  function GetObjectType: TLinkedObjectType; stdcall;
  function GetObject: IUnknown; stdcall; { can raise InvalidTopicId, FolderLinkNotFound }
  function GetLinkInfo: TLinkInfo; stdcall;
  function GetLinkedHint: IString; stdcall;
  function GetKind: TLinkKind; stdcall;
 end;//ILink

 IJournalBookmarkList = array of IJournalBookmark;

 IDiffDocDataProvider = interface
  ['{E9D2FB7F-1DE5-4C75-8998-72B6C443FF03}']
  function GetAllLeafParaCount: Cardinal; stdcall;
  function GetHeaderParaList: IDiffDocParaList; stdcall;
   {* ��������� ��������� ������� ��:

����� "����� ��������� ���������"
������� ��� ��������� (!Name)
����� "������������ ���������� �������� "������" 
����� "����� ��������� ������������ ��������� ��������:" }
  function GetDateParaRight(out para: TDiffDocPara): ByteBool; stdcall;
   {* �������� � ������ ��������� ��������� ��� ������� ��������� }
  function GetDateParaLeft(out para: TDiffDocPara): ByteBool; stdcall;
   {* �������� � ������ ��������� ��������� ��� ������ ��������� }
  function GetRedactionNameRight: TDiffDocPara; stdcall;
   {* ������ ������� ����� ��������� ���������� ����� �������� (��� ��� �������� ��� ������� ���������) }
  function GetRedactionNameLeft: TDiffDocPara; stdcall;
   {* ������ ������� ����� ��������� ���������� ����� �������� (��� ��� �������� ��� ������ ���������) }
  function GetChangedBlockCount: Cardinal; stdcall;
  function GetChangedBlock(i: Cardinal): TChangedBlock; stdcall;
 end;//IDiffDocDataProvider

 IObjectFromLink = interface
  ['{51778307-FE15-45BF-9A86-62A66BF81725}']
  function GetObject: IUnknown; stdcall;
  function GetObjectType: TLinkedObjectType; stdcall;
  class function Make(const server_link): BadFactoryType; stdcall;
 end;//IObjectFromLink

const
 ROOT_CHILD: TChildID = 0;
 ROOT_LAYER: TLayerID = 4294967295;
  {* 0xFFFFFFFF }

implementation

uses
 l3ImplUses
;

end.
