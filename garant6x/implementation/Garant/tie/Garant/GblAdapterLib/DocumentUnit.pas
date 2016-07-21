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
  procedure GetObjName; stdcall;
  procedure GetBlocksInfo; stdcall;
  function IsOneBlock: ByteBool; stdcall;
   {* ������������� ������ ���������� ������ � ����� ����� (����) - ���������� ��� ����������� ��������� ��������� � ���, � �����(��) �����(��) ���������� ������������� ������.  ���� � blocks_info ���������� ������ ���� ����, �� ������������ true, � ��������� ������ false. }
  property ObjName: 
   read GetObjName;
   {* ��� �������������� �������. }
  property BlocksInfo: 
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
  warning: ;
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
  pid: ;
  position: ;
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
  warning: ;
  interval: ;
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
  display_name: ;
   {* ���������� �������� (�� ��� ������������) }
  doc_topic: ;
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
  hint: ;
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
  path: ;
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
  name: ;
 end;//TBookmark2

 IBookmarkList = array of TBookmark2;

 IFragmentList = array of TContext;

 ISubList = array of Cardinal;

 IContextList = array of IFragmentList;

 IFoundContext = interface
  ['{2852766C-A9A5-4A40-8C9F-FD957D1D856E}']
  procedure GetList; stdcall;
  property List: 
   read GetList;
 end;//IFoundContext

 IDocumentTextProvider = interface
  ['{EDE34F9F-F36F-48FA-82BA-FD755CE46B4B}']
  function GetChildType(const id: TEntryPoint): TEVDType; stdcall; { can raise InvalidEntryPoint }
  function GetChildLayerId(const id: TEntryPoint): TLayerID; stdcall; { can raise InvalidEntryPoint }
  function GetChildExternalId(const id: TEntryPoint): TExternalID; stdcall; { can raise InvalidEntryPoint }
  procedure GetChildEvdStyle(const id: TEntryPoint;
   out aRet
   {* TEVDStream }); stdcall; { can raise InvalidEntryPoint }
  procedure GetChildComment(const id: TEntryPoint;
   out aRet
   {* TEVDStream }); stdcall; { can raise InvalidEntryPoint }
  procedure SetChildComment(const id: TEntryPoint;
   const comment: TEVDStream); stdcall; { can raise InvalidEntryPoint }
  procedure RemoveChildComment(const id: TEntryPoint); stdcall;
  procedure GetChildBookmarks(const id: TEntryPoint;
   out aRet
   {* IBookmarkList }); stdcall; { can raise EmptyResult, InvalidEntryPoint }
  procedure GetChildText(const id: TEntryPoint;
   out aRet
   {* IString }); stdcall; { can raise InvalidEntryPoint }
  procedure GetChildTechComment(const id: TEntryPoint;
   out aRet
   {* IString }); stdcall; { can raise InvalidEntryPoint }
  function AllLeafParaCount(layer_id: TLayerID): Cardinal; stdcall; { can raise InvalidLayerID }
  function ChildrenCount(layer_id: TLayerID): Cardinal; stdcall; { can raise InvalidLayerID }
  procedure FindBlockOrSub(id: TExternalID;
   out aRet
   {* INodeIndexPath }); stdcall; { can raise CanNotFindData }
  procedure FindPara(id: TExternalID;
   out aRet
   {* INodeIndexPath }); stdcall; { can raise CanNotFindData }
  procedure FindContext(const context: IString;
   from_id: TExternalID;
   out aRet
   {* IFoundContext }); stdcall; { can raise CanNotFindData }
  procedure GetSubList(const id: TEntryPoint;
   out aRet
   {* ISubList }); stdcall;
  procedure GetPrefixTree(id: TExternalID;
   out aRet
   {* INodeBase }); stdcall;
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
  name: ;
 end;//TExternalObjectData

 IExternalObjectDataList = array of TExternalObjectData;

 TDiffData = record
  diff_iterator: ;
  cur: ;
  prev: ;
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
  name: ;
   {* ��� ��������. }
  time_machine_date: ;
  doc_date: ;
  is_comparable: ByteBool;
  actual_type: TRedactionType;
  not_sure_intervals: ;
  active_intervals: ;
  id: TRedactionID;
  changing_documents: ;
 end;//TRedactionInfo

 TDiffDocPara = record
  text: ;
  style: ;
  data: ;
  type: TEVDType;
  id: Integer;
 end;//TDiffDocPara

 IDiffDocParaList = array of TDiffDocPara;

 TChangedBlock = record
  id: Cardinal;
  header: ;
   {* �������� ����������� ������� � ��������� �� ������������ �����, ��������� � ����������,
�������  ������������ ���������� �������� (����) }
  right_text_para_list: ;
   {* ���������� �������� ������ �������� }
  left_text_para_list: ;
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
  procedure GetName; stdcall;
  procedure GetShortName; stdcall;
  procedure GetWarning; stdcall;
  function GetSize: Cardinal; stdcall;
  function GetInternalId: Cardinal; stdcall;
  function GetNotTm: ByteBool; stdcall;
  procedure GetFilePosition; stdcall; { can raise CanNotFindData }
  function GetNewRevisionAvailable: ByteBool; stdcall;
  function GetChangeStatus: Cardinal; stdcall;
  function GetStatus: TItemStatus; stdcall;
  procedure GetTextLanguages; stdcall;
  procedure GetAttributesRoot; stdcall;
  procedure GetRedactionsList; stdcall;
  procedure GetCurrentState; stdcall;
  function GetDocType: TDocumentType; stdcall;
  procedure GetTranslation; stdcall;
  procedure GetAnnotation; stdcall;
  procedure GetRelatedDoc; stdcall;
  procedure GetContentsRoot; stdcall; { can raise CanNotFindData }
  procedure GetBookmarkList; stdcall;
  procedure GetCommentsParaList; stdcall;
  procedure GetExternalObjectDataList; stdcall;
  procedure CreateBookmark(para: TParaId;
   is_para: Boolean
   {* ���� ����������� �� �� ��� � ������ ��������� ����������� ��������, � ��������� ������ ���. };
   out aRet
   {* IBookmark }); stdcall;
   {* ������� ��������� �������� �� �������� ������������� ���������. ����������� �� � �������� �������� �������� ��� ���������. � � �������� full_name ��� ��������� � ��� ���������� (������) ���� ��� ����� (��� � �������). }
  procedure CreateView(var filters: IDocumentState;
   out aRet
   {* IDocument }); stdcall;
   {* ���������� �������� - ��������, ���������� �����  filters.
���� ������� �������� ����� ���������� - ���������� NULL }
  procedure GetCorrespondentsToPart(const pos_list: IPositionList
   {* ������ �������. };
   const category: INodeBase
   {* ��������� ���������� };
   out out_list: ICatalogBase); stdcall;
   {* ���������� ������ ��������������� � ��������� ��������� (������ ����������) ��� ��������� ��������� (category).

��� ��������, ������� �� "�������", ���������� NULL }
  procedure GetInternetImageUrl(block_id: Integer;
   out aRet
   {* IExternalLink }); stdcall;
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
  procedure GetTimeMachineWarning(const date: TDate;
   out aRet
   {* TTimeMachineWarning }); stdcall;
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
  class function Make(const document); overload; stdcall;
  class function Make(const pid;
   is_edition: Boolean;
   name: PAnsiChar); overload; stdcall;
  function IsMorphoSearchSupported: ByteBool; stdcall;
   {* ������������ �� �������� ��� ����������� }
  procedure GetLinkInfo(doc_id: Cardinal;
   const id: TTopic;
   rid: TRedactionID;
   out aRet
   {* TLinkInfo }); stdcall;
  procedure GetMissingInfoForObject(const pid: TPId;
   out missing_info: IMissingInfo); stdcall;
   {* ���������� ����������� ���������� �� �������������� ������� (pid - ������������� � ����� ������� �� ������) }
  procedure GetDrugList(out aRet
   {* ICatalogBase }); stdcall; { can raise CanNotFindData }
   {* �������� ������ ����������� ������ ���������� }
  procedure GetFlash(out aRet
   {* IExternalObject }); stdcall;
   {* ��������� ����-������ }
  procedure CreateJournalBookmark(para: TParaId;
   out aRet
   {* IJournalBookmark }); stdcall;
   {* ������� ���������� �������� }
  function GetAutoReferatDocCount: size; stdcall; { can raise Unsupported }
   {* ������� ����� ���������� ��� ������������ }
  procedure GetTextProvider(all_at_once: Boolean;
   out aRet
   {* IDocumentTextProvider }); stdcall; { can raise Unsupported, CanNotFindData }
  procedure GetTextProviderDescList(out aRet
   {* IDocumentTextProviderDescriptorList }); stdcall; { can raise Unsupported }
  procedure GetTextProviderByDesc(handle: Cardinal;
   out aRet
   {* IDocumentTextProvider }); stdcall; { can raise Unsupported }
  procedure GetTextProviderList(all_at_once: Boolean;
   out aRet
   {* IDocumentTextProviderList }); stdcall; { can raise Unsupported }
  procedure GetAutoreferatHeaderEvd(out aRet
   {* IStream }); stdcall; { can raise Unsupported }
  procedure GetAnnotationHeaderEvd(handle: Cardinal;
   out aRet
   {* IStream }); stdcall; { can raise Unsupported }
  procedure Diff(const pid;
   out aRet
   {* TDiffData }); stdcall;
  procedure GetEvdStream(out aRet
   {* IStream }); stdcall;
   {* ���������� evd ����� ��������� - ������ ��� ��� evd ����� �������� ��� �������������� � ���� ��������� ��� ��������� ������������ � ��������� }
  procedure GetSelfMissingInfo(out missing_info: IMissingInfo); stdcall;
   {* �������� ����������� ���������� �� �������� ��������� (� ������ ��� ���������� - � ����� ������ ���� �������� ������������) }
  procedure GetMultiLinkInfo(doc_id: Cardinal;
   const id: TTopic;
   out aRet
   {* IDocPointList }); stdcall; { can raise CanNotFindData, InternalDatabaseError }
   {* �������� ������ �� ����n������� � ���� ������ (DocId, SubId) }
  procedure DontShowDocumentStatusChangesWarning; stdcall;
   {* �� ���������� ������ ��������� ������� ��������� � ������� ������ }
  procedure GetRedactionPid; stdcall;
  function HasChronology: ByteBool; stdcall;
   {* ���� �� � ��������� ���������� ������������ ��������� ����
K555095873 }
  procedure GetLink(doc_id: Cardinal;
   const id: TTopic;
   rid: TRedactionID;
   out aRet
   {* ILink }); stdcall;
  procedure GetSameToPoint(id: TExternalID;
   out out_list: ICatalogBase); stdcall;
  property Name: 
   read GetName;
   {* ��� ���������. }
  property ShortName: 
   read GetShortName;
   {* ������� ��� ���������. }
  property Warning: 
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
  property FilePosition: 
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
  property TextLanguages: 
   read GetTextLanguages;
  property AttributesRoot: 
   read GetAttributesRoot;
  property RedactionsList: 
   read GetRedactionsList;
  property CurrentState: 
   read GetCurrentState;
  property DocType: TDocumentType
   read GetDocType;
  property Translation: 
   read GetTranslation;
  property Annotation: 
   read GetAnnotation;
  property RelatedDoc: 
   read GetRelatedDoc;
  property ContentsRoot: 
   read GetContentsRoot;
  property BookmarkList: 
   read GetBookmarkList;
  property CommentsParaList: 
   read GetCommentsParaList;
  property ExternalObjectDataList: 
   read GetExternalObjectDataList;
 end;//IDocument

 IBookmark = interface(IEntityBase)
  {* �������� �� ��������. ������������ ��� ���������� ��������� (� �������) � ������. }
  ['{830AC32A-C3AC-4AA1-A5A1-0ACAE229DD2A}']
  procedure GetName; stdcall;
  procedure SetName(const aValue); stdcall;
  procedure GetComment; stdcall;
  procedure SetComment(const aValue); stdcall;
  function GetParagraph: TParaId; stdcall;
  procedure GetPid; stdcall;
  procedure GetDocument; stdcall;
  property Name: 
   read GetName
   write SetName;
   {* ��������� ��������. ������������ � �������� caption � ������. }
  property Comment: 
   read GetComment
   write SetComment;
   {* ������ ��� ��������� � �����/���� �� ������� ��������� ��������. ������������ � �������� hint  � ������. }
  property Paragraph: TParaId
   read GetParagraph;
  property Pid: 
   read GetPid;
  property Document: 
   read GetDocument;
 end;//IBookmark

 IDocumentState = interface
  {* ��������� ��� ������ � ���������� �������. }
  ['{71C2A950-3D61-44A9-A0FA-845C4A9F5B97}']
  function GetLanguage: TLanguages; stdcall;
  procedure SetLanguage(aValue: TLanguages); stdcall;
  procedure GetPrevRedactionsList; stdcall;
  procedure GetCurAndNextRedactionsList; stdcall;
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
  procedure GetCurrentRedaction(out aRet
   {* TRedactionInfo }); stdcall;
  function IsSameRedactions(const other: IDocumentState): ByteBool; stdcall;
  procedure DiffWithRedactionById(id: TRedactionID;
   out aRet
   {* TDiffData }); stdcall;
  procedure Clone(out aRet
   {* IDocumentState }); stdcall;
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
  property PrevRedactionsList: 
   read GetPrevRedactionsList;
  property CurAndNextRedactionsList: 
   read GetCurAndNextRedactionsList;
   {* [$178324034] }
 end;//IDocumentState

 AllChangesInTables = class
 end;//AllChangesInTables

 IJournalBookmark = interface(IEntityBase)
  {* ���������� �������� }
  ['{7EC5D2E1-6B5C-4C7E-AE21-C98E21A8D018}']
  procedure GetName; stdcall;
  procedure GetFullName; stdcall;
  function GetParaId: Cardinal; stdcall;
  procedure GetDocument; stdcall;
  procedure GetJournalBookmark; stdcall;
   {* ��������  ��������� ���������� �������� }
  property Name: 
   read GetName;
   {* ��� }
  property FullName: 
   read GetFullName;
   {* ������ ��� (����) }
  property ParaId: Cardinal
   read GetParaId;
  property Document: 
   read GetDocument;
 end;//IJournalBookmark

 TDocumentLayerID = TLayerID;

 ILink = interface
  ['{FBA5DE98-0FAD-4647-B2DE-AB788A6DDFE6}']
  function GetObjectType: TLinkedObjectType; stdcall;
  procedure GetObject(out aRet
   {* IUnknown }); stdcall; { can raise InvalidTopicId, FolderLinkNotFound }
  procedure GetLinkInfo(out aRet
   {* TLinkInfo }); stdcall;
  procedure GetLinkedHint(out aRet
   {* IString }); stdcall;
  function GetKind: TLinkKind; stdcall;
 end;//ILink

 IJournalBookmarkList = array of IJournalBookmark;

 IDiffDocDataProvider = interface
  ['{E9D2FB7F-1DE5-4C75-8998-72B6C443FF03}']
  function GetAllLeafParaCount: Cardinal; stdcall;
  procedure GetHeaderParaList(out aRet
   {* IDiffDocParaList }); stdcall;
   {* ��������� ��������� ������� ��:

����� "����� ��������� ���������"
������� ��� ��������� (!Name)
����� "������������ ���������� �������� "������" 
����� "����� ��������� ������������ ��������� ��������:" }
  function GetDateParaRight(out para: TDiffDocPara): ByteBool; stdcall;
   {* �������� � ������ ��������� ��������� ��� ������� ��������� }
  function GetDateParaLeft(out para: TDiffDocPara): ByteBool; stdcall;
   {* �������� � ������ ��������� ��������� ��� ������ ��������� }
  procedure GetRedactionNameRight(out aRet
   {* TDiffDocPara }); stdcall;
   {* ������ ������� ����� ��������� ���������� ����� �������� (��� ��� �������� ��� ������� ���������) }
  procedure GetRedactionNameLeft(out aRet
   {* TDiffDocPara }); stdcall;
   {* ������ ������� ����� ��������� ���������� ����� �������� (��� ��� �������� ��� ������ ���������) }
  function GetChangedBlockCount: Cardinal; stdcall;
  procedure GetChangedBlock(i: Cardinal;
   out aRet
   {* TChangedBlock }); stdcall;
 end;//IDiffDocDataProvider

 IObjectFromLink = interface
  ['{51778307-FE15-45BF-9A86-62A66BF81725}']
  procedure GetObject(out aRet
   {* IUnknown }); stdcall;
  function GetObjectType: TLinkedObjectType; stdcall;
  class function Make(const server_link); stdcall;
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
