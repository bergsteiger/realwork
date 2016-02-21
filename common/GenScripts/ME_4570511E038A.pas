unit DocumentUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DocumentUnit.pas"
// ���������: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , DynamicTreeUnit
 , ExternalObjectUnit
 , UnderControlUnit
 , FoldersUnit
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
  function Get_obj_name: IString;
  function Get_blocks_info: IString;
  function is_one_block: Boolean;
   {* ������������� ������ ���������� ������ � ����� ����� (����) - ���������� ��� ����������� ��������� ��������� � ���, � �����(��) �����(��) ���������� ������������� ������.  ���� � blocks_info ���������� ������ ���� ����, �� ������������ true, � ��������� ������ false. }
  property obj_name: IString
   read Get_obj_name;
   {* ��� �������������� �������. }
  property blocks_info: IString
   read Get_blocks_info;
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

 NotAllowedInTrialMode = class
 end;//NotAllowedInTrialMode

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

 InvalidDate = class
 end;//InvalidDate

 ExplanationDictionaryNotInstalled = class
  {* �������� ������� �� ���������� � �������.
������������ � ������ ������ �������� "����� ����������" � ���������� � ������� ��������� �������. }
 end;//ExplanationDictionaryNotInstalled

 TLinkInfo = record
  kind: TLinkKind;
   {* ��� ����� }
  hint: IString;
 end;//TLinkInfo

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
  function has_next: Boolean;
  function has_prev: Boolean;
  function next: TParaNum; { can raise CanNotFindData }
  function acquire_next: TParaNum;
  function prev: TParaNum; { can raise CanNotFindData }
  function acquire_prev: TParaNum;
  procedure move_to(para: TParaNum); { can raise CanNotFindData }
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
  function Get_list: IContextList;
  property list: IContextList
   read Get_list;
 end;//IFoundContext

 IDocumentTextProvider = interface
  ['{EDE34F9F-F36F-48FA-82BA-FD755CE46B4B}']
  function get_child_type(const id: TEntryPoint): TEVDType; { can raise InvalidEntryPoint }
  function get_child_layer_id(const id: TEntryPoint): TLayerID; { can raise InvalidEntryPoint }
  function get_child_external_id(const id: TEntryPoint): TExternalID; { can raise InvalidEntryPoint }
  function get_child_evd_style(const id: TEntryPoint): TEVDStream; { can raise InvalidEntryPoint }
  function get_child_comment(const id: TEntryPoint): TEVDStream; { can raise InvalidEntryPoint }
  procedure set_child_comment(const id: TEntryPoint;
   const comment: TEVDStream); { can raise InvalidEntryPoint }
  procedure remove_child_comment(const id: TEntryPoint);
  function get_child_bookmarks(const id: TEntryPoint): IBookmarkList; { can raise EmptyResult, InvalidEntryPoint }
  function get_child_text(const id: TEntryPoint): IString; { can raise InvalidEntryPoint }
  function get_child_tech_comment(const id: TEntryPoint): IString; { can raise InvalidEntryPoint }
  function all_leaf_para_count(layer_id: TLayerID): Cardinal; { can raise InvalidLayerID }
  function children_count(layer_id: TLayerID): Cardinal; { can raise InvalidLayerID }
  function find_block_or_sub(id: TExternalID): INodeIndexPath; { can raise CanNotFindData }
  function find_para(id: TExternalID): INodeIndexPath; { can raise CanNotFindData }
  function find_context(const context: IString;
   from_id: TExternalID): IFoundContext; { can raise CanNotFindData }
  function get_sub_list(const id: TEntryPoint): ISubList;
  function get_prefix_tree(id: TExternalID): INodeBase;
  function show_sub_panel_icon(id: TExternalID): Boolean;
   {* ����� �� ���������� ������ ��� ����� �� ��������� }
  function has_same(id: TExternalID): Boolean;
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
  function Get_can_like: Boolean;
  procedure like;
   {* �������� }
  procedure unlike;
   {* �� �������� }
  property can_like: Boolean
   read Get_can_like;
   {* ����������� �������� ������ }
 end;//ILikeable

 TRedactionInfo = record
  {* ���������� � �������� �������. }
  name: IString;
   {* ��� ��������. }
  time_machine_date: TDate;
  doc_date: TDate;
  is_comparable: Boolean;
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
  function Get_name: IString;
  function Get_short_name: IString;
  function Get_warning: IString;
  function Get_size: Cardinal;
  function Get_internal_id: Cardinal;
  function Get_not_tm: Boolean;
  function Get_file_position: IString; { can raise CanNotFindData }
  function Get_new_revision_available: Boolean;
  function Get_change_status: Cardinal;
  function Get_status: TItemStatus;
  function Get_text_languages: ILanguagesList;
  function Get_attributes_root: INodeBase;
  function Get_redactions_list: IRedactionInfoList;
  function Get_current_state: IDocumentState;
  function Get_doc_type: TDocumentType;
  function Get_translation: IDocument;
  function Get_annotation: IDocument;
  function Get_related_doc: IDocument;
  function Get_contents_root: INodeBase; { can raise CanNotFindData }
  function Get_bookmark_list: IBookmarkList;
  function Get_comments_para_list: ICommentsParaList;
  function Get_external_object_data_list: IExternalObjectDataList;
  function create_bookmark(para: TParaId;
   is_para: Boolean
   {* ���� ����������� �� �� ��� � ������ ��������� ����������� ��������, � ��������� ������ ���. }): IBookmark;
   {* ������� ��������� �������� �� �������� ������������� ���������. ����������� �� � �������� �������� �������� ��� ���������. � � �������� full_name ��� ��������� � ��� ���������� (������) ���� ��� ����� (��� � �������). }
  function create_view(var filters: IDocumentState): IDocument;
   {* ���������� �������� - ��������, ���������� �����  filters.
���� ������� �������� ����� ���������� - ���������� NULL }
  procedure get_correspondents_to_part(const pos_list: IPositionList
   {* ������ �������. };
   const category: INodeBase
   {* ��������� ���������� };
   out out_list: ICatalogBase);
   {* ���������� ������ ��������������� � ��������� ��������� (������ ����������) ��� ��������� ��������� (category).

��� ��������, ������� �� "�������", ���������� NULL }
  function get_internet_image_url(block_id: Integer): IExternalLink;
   {* �������� url ��� ���������������� WWW-������ ���������. }
  procedure get_linked_object(doc_id: Cardinal;
   const id: TTopic;
   rid: TRedactionID;
   out obj_type: TLinkedObjectType;
   out obj: IUnknown); { can raise InvalidTopicId, FolderLinkNotFound, NotAllowedInTrialMode }
   {* �������� ��������� �������, �� ������� ��������� �������������� ������, �� ����������� ��������������.
������������ ��������� �� ������ (obj) � ��� ������� (obj_type).
������������� ����� �������� ��������� (missing_info) � �����������, � ����� ������ (�����) ���������� ������������� ������ (����� get_missing_info)
����� �������������� ��� �������� �� �������������� ������. }
  procedure get_not_sure_info(const date: TDate;
   var start: TDate;
   var finish: TDate;
   out info: IDocument;
   out warning: IString);
   {* ���������� ���������� �� ��������� ������������� ���������. ���� ��������� � ��������� date ���� �� �������� � �������� ������� CanNotFindData }
  procedure get_respondents_to_part(const pos_list: IPositionList
   {* ������ �������. };
   const category: INodeBase
   {* ��������� ����������. };
   out out_list: ICatalogBase);
   {* ���������� ������ ������������ � ��������� ��������� (������ ����������) ��� ��������� ��������� (category).

��� ��������, ������� �� "�������", ���������� NULL }
  function get_time_machine_warning(const date: TDate): TTimeMachineWarning;
  function has_correspondents(const category: INodeBase): Boolean;
   {* �������� ������� ��������������� (������ ���������) � �������� ���������.
���������� true � ������, ���� ������ ��������������� ��� ��������� �� ��������� CR_ALL �� ����.

��� ��������, �������� �� "�������", ���������� FALSE }
  function has_internet_image: Boolean;
   {* �������� ������� WWW-������ � �������� ���������.
���������� true � ������, ���� � �������� ��������� ���� WWW-�����. }
  function has_next_redaction: Boolean;
   {* ������� ���������� ������� ��������� �������� ��� �������.
��������� �������� ��������� ������������ �������� ��������� (current_redaction).
���������� True � ������ ������� ������ ����� ����� ������� (��� �������) ��������. }
  function has_prev_redaction: Boolean;
   {* ������� ���������� ������� ���������� �������� ��� �������.
���������� �������� ��������� ������������ �������� ��������� (current_redaction).
���������� True � ������ ������� ������ ����� ����� ������ (��� �������) ��������. }
  function has_related_doc: Boolean;
   {* �������� ������� ������� � �������� ���������.
���������� true � ������, ���� � �������� ��������� ���� �������.

��� ��������, �������� �� "�������", ��������� ����� �� ��� � ��� "�������" }
  function has_respondents(const category: INodeBase): Boolean;
   {* �������� ������� ������������ (������ ���������) � �������� ���������.
���������� true � ������, ���� ������ ������������ ��� ��������� �� ��������� CR_ALL �� ����.

��� ��������, �������� �� "�������", ���������� FALSE }
  function has_annotation: Boolean;
  function has_attributes: Boolean;
   {* ��� ���������� ���� DT_BOOK ���������� false,
��� ��������� true }
  function has_warning: Boolean;
   {* ����������� ��������������. }
  function is_alive: Boolean;
   {* ����������� �����, ����������� �������� "���" �� �������� �� ������� ����������. ���� �������� "���" - ������������ `true` (��� ������� ����� �������� �����, ����� �������� ����� ���� ������, �������� �� ����� ���������� ����). ���������� ������� ������ �� ���������� �� ��������, �.�. ����� ����� ������ ������ ���������� � ������� ����������. }
  function is_date_in_not_sure_interval(const date: TDate): Boolean;
   {* ����� ��������� ���������� �������� �� date � �������� ������������� ���������. }
  function is_my_bookmark(const bookmark: IBookmark): Boolean;
  function is_same_document(const doc: IDocument): Boolean;
  function is_same_redaction(const view: IDocument): Boolean;
  function is_same_view(const view: IDocument): Boolean;
   {* ���������� ��������� ���������� � ������ �� ��������� (� ������� �� is_same_entity, ������� ���������� ��������� ��� ����� ���������). ���������� ��������� �������� ������������ ������ ��������, ����� � ������ ����������. }
  function may_show_attributes: Boolean;
   {* �������� ����������� ����������� ��������� ��������� ��� �������� ���������.
���������� true � ������, ���� ����� ��������� ��������.

��� �������� ����������� ��������, �������������� �������� (�.�. �������������� ������ �������� ) }
  procedure get_correspondents(const category: INodeBase;
   out out_list: ICatalogBase);
  procedure get_respondents(const category: INodeBase;
   out out_list: ICatalogBase);
  function has_translation: Boolean;
   {* ���� �� � ��������� ������� }
  function has_same_documents: Boolean;
   {* �������� ������� ������� ���������� }
  procedure get_same_documents(out out_list: ICatalogBase);
   {* �������� ������ ������� ���������� }
  procedure get_server_doc;
  class function make(const document): BadFactoryType; overload;
  class function make(const pid;
   is_edition: Boolean;
   name: PAnsiChar): BadFactoryType; overload;
  function is_morpho_search_supported: Boolean;
   {* ������������ �� �������� ��� ����������� }
  function get_link_info(doc_id: Cardinal;
   const id: TTopic;
   rid: TRedactionID): TLinkInfo;
  procedure get_missing_info_for_object(const pid: TPId;
   out missing_info: IMissingInfo);
   {* ���������� ����������� ���������� �� �������������� ������� (pid - ������������� � ����� ������� �� ������) }
  function get_drug_list: ICatalogBase; { can raise CanNotFindData }
   {* �������� ������ ����������� ������ ���������� }
  function get_flash: IExternalObject;
   {* ��������� ����-������ }
  function create_journal_bookmark(para: TParaId): IJournalBookmark;
   {* ������� ���������� �������� }
  function get_auto_referat_doc_count: size; { can raise Unsupported }
   {* ������� ����� ���������� ��� ������������ }
  function get_text_provider(all_at_once: Boolean): IDocumentTextProvider; { can raise Unsupported, CanNotFindData }
  function get_text_provider_desc_list: IDocumentTextProviderDescriptorList; { can raise Unsupported }
  function get_text_provider_by_desc(handle: Cardinal): IDocumentTextProvider; { can raise Unsupported }
  function get_text_provider_list(all_at_once: Boolean): IDocumentTextProviderList; { can raise Unsupported }
  function get_autoreferat_header_evd: IStream; { can raise Unsupported }
  function get_annotation_header_evd(handle: Cardinal): IStream; { can raise Unsupported }
  function diff(const pid): TDiffData;
  function get_evd_stream: IStream;
   {* ���������� evd ����� ��������� - ������ ��� ��� evd ����� �������� ��� �������������� � ���� ��������� ��� ��������� ������������ � ��������� }
  procedure get_self_missing_info(out missing_info: IMissingInfo);
   {* �������� ����������� ���������� �� �������� ��������� (� ������ ��� ���������� - � ����� ������ ���� �������� ������������) }
  function get_multi_link_info(doc_id: Cardinal;
   const id: TTopic): IDocPointList; { can raise CanNotFindData, InternalDatabaseError }
   {* �������� ������ �� ����n������� � ���� ������ (DocId, SubId) }
  procedure dont_show_document_status_changes_warning;
   {* �� ���������� ������ ��������� ������� ��������� � ������� ������ }
  procedure get_redaction_pid;
  function has_chronology: Boolean;
   {* ���� �� � ��������� ���������� ������������ ��������� ����
K555095873 }
  function get_link(doc_id: Cardinal;
   const id: TTopic;
   rid: TRedactionID): ILink;
  procedure get_same_to_point(id: TExternalID;
   out out_list: ICatalogBase);
  property name: IString
   read Get_name;
   {* ��� ���������. }
  property short_name: IString
   read Get_short_name;
   {* ������� ��� ���������. }
  property warning: IString
   read Get_warning;
   {* �������������� � ���������. }
  property size: Cardinal
   read Get_size;
   {* ������ ��������� � ������ }
  property internal_id: Cardinal
   read Get_internal_id;
   {* ���������� ����� ��������� � ���� }
  property not_tm: Boolean
   read Get_not_tm;
   {* True - ���� �������� �� ��������� � ������ ������� }
  property file_position: IString
   read Get_file_position;
  property new_revision_available: Boolean
   read Get_new_revision_available;
   {* �������� ����� ������� ��������� (��� �������������� ������) }
  property change_status: Cardinal
   read Get_change_status;
   {* ������ ��������� ��������� }
  property status: TItemStatus
   read Get_status;
   {* ������ ��������� }
  property text_languages: ILanguagesList
   read Get_text_languages;
  property attributes_root: INodeBase
   read Get_attributes_root;
  property redactions_list: IRedactionInfoList
   read Get_redactions_list;
  property current_state: IDocumentState
   read Get_current_state;
  property doc_type: TDocumentType
   read Get_doc_type;
  property translation: IDocument
   read Get_translation;
  property annotation: IDocument
   read Get_annotation;
  property related_doc: IDocument
   read Get_related_doc;
  property contents_root: INodeBase
   read Get_contents_root;
  property bookmark_list: IBookmarkList
   read Get_bookmark_list;
  property comments_para_list: ICommentsParaList
   read Get_comments_para_list;
  property external_object_data_list: IExternalObjectDataList
   read Get_external_object_data_list;
 end;//IDocument

 IBookmark = interface(IEntityBase)
  {* �������� �� ��������. ������������ ��� ���������� ��������� (� �������) � ������. }
  ['{830AC32A-C3AC-4AA1-A5A1-0ACAE229DD2A}']
  function Get_name: IString;
  procedure Set_name(const aValue: IString);
  function Get_comment: IString;
  procedure Set_comment(const aValue: IString);
  function Get_paragraph: TParaId;
  function Get_pid: TPId;
  function Get_document: IDocument;
  property name: IString
   read Get_name
   write Set_name;
   {* ��������� ��������. ������������ � �������� caption � ������. }
  property comment: IString
   read Get_comment
   write Set_comment;
   {* ������ ��� ��������� � �����/���� �� ������� ��������� ��������. ������������ � �������� hint  � ������. }
  property paragraph: TParaId
   read Get_paragraph;
  property pid: TPId
   read Get_pid;
  property document: IDocument
   read Get_document;
 end;//IBookmark

 IDocumentState = interface
  {* ��������� ��� ������ � ���������� �������. }
  ['{71C2A950-3D61-44A9-A0FA-845C4A9F5B97}']
  function Get_language: TLanguages;
  procedure Set_language(aValue: TLanguages);
  function Get_prev_redactions_list: IRedactionInfoList;
  function Get_cur_and_next_redactions_list: IRedactionInfoList;
  procedure set_prev_redaction; { can raise RedactionNotFound }
   {* �������� ������������� � �������� ������� ���������� �������� �������.
���� ���������� �������� ���, �� ������������ RedactionNotFound. }
  procedure set_next_redaction; { can raise RedactionNotFound }
   {* �������� ������������� � �������� ������� ��������� �������� �������.
���� ��������� �������� ���, �� ������������ RedactionNotFound. }
  procedure set_redaction_on_date(const date: TDate); { can raise RedactionNotFound }
  procedure set_redaction_on_id(id: TRedactionID); { can raise RedactionNotFound }
   {* �������� ������������� � �������� ������� �������� � �������� ���������������.
���������� True � ������ ���� ������� ��������� ���������� � False, ���� �������� ��� �� �����, ��� � �� ������ ������.
���� ����� �������� ������������� ��������, �� ������������ InvalidRedactionId. }
  procedure set_actual_redaction; { can raise RedactionNotFound }
   {* �������� ������������� � �������� ������� ��������, ���������� �������� ��� ������� ���������.
���������� True � ������ ���� ������� ��������� ���������� � False, ���� �������� ��� �� �����, ��� � �� ������ ������. }
  function redaction: TRedactionID;
  function get_current_redaction: TRedactionInfo;
  function is_same_redactions(const other: IDocumentState): Boolean;
  function diff_with_redaction_by_id(id: TRedactionID): TDiffData;
  function clone: IDocumentState;
  procedure set_prev_active_redaction; { can raise RedactionNotFound }
   {* Get��������������������������������. [$178325284] }
  function can_compare_with_any_other_redaction: Boolean;
   {* [$178325284] }
  function is_actual: Boolean;
   {* ���������� true, ���� ��� �������� ����������, �. �. ����� ���:
- RT_ACTUAL
- RT_ACTUAL_ABOLISHED
- RT_ACTUAL_PREACTIVE }
  property language: TLanguages
   read Get_language
   write Set_language;
  property prev_redactions_list: IRedactionInfoList
   read Get_prev_redactions_list;
  property cur_and_next_redactions_list: IRedactionInfoList
   read Get_cur_and_next_redactions_list;
   {* [$178324034] }
 end;//IDocumentState

 AllChangesInTables = class
 end;//AllChangesInTables

 IJournalBookmark = interface(IEntityBase)
  {* ���������� �������� }
  ['{7EC5D2E1-6B5C-4C7E-AE21-C98E21A8D018}']
  function Get_name: IString;
  function Get_full_name: IString;
  function Get_para_id: Cardinal;
  function Get_document: IDocument;
  procedure get_journal_bookmark;
   {* ��������  ��������� ���������� �������� }
  property name: IString
   read Get_name;
   {* ��� }
  property full_name: IString
   read Get_full_name;
   {* ������ ��� (����) }
  property para_id: Cardinal
   read Get_para_id;
  property document: IDocument
   read Get_document;
 end;//IJournalBookmark

 TDocumentLayerID = TLayerID;

 ILink = interface
  ['{FBA5DE98-0FAD-4647-B2DE-AB788A6DDFE6}']
  function get_object_type: TLinkedObjectType;
  function get_object: IUnknown; { can raise InvalidTopicId, FolderLinkNotFound, NotAllowedInTrialMode }
  function get_link_info: TLinkInfo;
  function get_linked_hint: IString;
  function get_kind: TLinkKind;
 end;//ILink

 IJournalBookmarkList = array of IJournalBookmark;

 IDiffDocDataProvider = interface
  ['{E9D2FB7F-1DE5-4C75-8998-72B6C443FF03}']
  function get_all_leaf_para_count: Cardinal;
  function get_header_para_list: IDiffDocParaList;
   {* ��������� ��������� ������� ��:

����� "����� ��������� ���������"
������� ��� ��������� (!Name)
����� "������������ ���������� �������� "������" 
����� "����� ��������� ������������ ��������� ��������:" }
  function get_date_para_right(out para: TDiffDocPara): Boolean;
   {* �������� � ������ ��������� ��������� ��� ������� ��������� }
  function get_date_para_left(out para: TDiffDocPara): Boolean;
   {* �������� � ������ ��������� ��������� ��� ������ ��������� }
  function get_redaction_name_right: TDiffDocPara;
   {* ������ ������� ����� ��������� ���������� ����� �������� (��� ��� �������� ��� ������� ���������) }
  function get_redaction_name_left: TDiffDocPara;
   {* ������ ������� ����� ��������� ���������� ����� �������� (��� ��� �������� ��� ������ ���������) }
  function get_changed_block_count: Cardinal;
  function get_changed_block(i: Cardinal): TChangedBlock;
 end;//IDiffDocDataProvider

 IObjectFromLink = interface
  ['{51778307-FE15-45BF-9A86-62A66BF81725}']
  function get_object: IUnknown;
  function get_object_type: TLinkedObjectType;
  class function make(const server_link): BadFactoryType;
 end;//IObjectFromLink

const
 ROOT_CHILD: TChildID = 0;
 ROOT_LAYER: TLayerID = 4294967295;
  {* 0xFFFFFFFF }

class function make(const pid): BadFactoryType;
class function make(const diff_data): BadFactoryType;
class function make(const list): BadFactoryType;
class function make(const server_doc;
 const handle;
 all_at_once: Boolean): BadFactoryType; overload;
class function make(const server_doc;
 handle: Cardinal;
 all_at_once: Boolean): BadFactoryType; overload;
class function make(const bookmark;
 const doc_bookmark;
 var folders_node: IFoldersNode): BadFactoryType;
class function make(var source_doc: IDocument): BadFactoryType; overload;
class function make: BadFactoryType; overload;
class function make(doc_id: TObjectId;
 para_id: TParaId): BadFactoryType; overload;
class function make(const journal_bookmark): BadFactoryType; overload;
class function make(doc_id: Cardinal;
 const topic: TTopic;
 redaction_id: TRedactionID): BadFactoryType; overload;
class function make(const document: IDocument;
 doc_id: Cardinal;
 const topic: TTopic;
 redaction_id: TRedactionID): BadFactoryType; overload;
class function make(const left: IDocument;
 const right: IDocument): BadFactoryType; { can raise AllChangesInTables }

implementation

uses
 l3ImplUses
;

class function make(const pid): BadFactoryType;
var
 l_Inst : IMissingInfo;
begin
 l_Inst := Create(pid);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const diff_data): BadFactoryType;
var
 l_Inst : IDiffIterator;
begin
 l_Inst := Create(diff_data);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const list): BadFactoryType;
var
 l_Inst : IFoundContext;
begin
 l_Inst := Create(list);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const server_doc;
 const handle;
 all_at_once: Boolean): BadFactoryType;
var
 l_Inst : IDocumentTextProvider;
begin
 l_Inst := Create(server_doc, handle, all_at_once);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const server_doc;
 handle: Cardinal;
 all_at_once: Boolean): BadFactoryType;
var
 l_Inst : IDocumentTextProvider;
begin
 l_Inst := Create(server_doc, handle, all_at_once);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const bookmark;
 const doc_bookmark;
 var folders_node: IFoldersNode): BadFactoryType;
var
 l_Inst : IBookmark;
begin
 l_Inst := Create(bookmark, doc_bookmark, folders_node);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(var source_doc: IDocument): BadFactoryType;
var
 l_Inst : IDocumentState;
begin
 l_Inst := Create(source_doc);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IDocumentState;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(doc_id: TObjectId;
 para_id: TParaId): BadFactoryType;
var
 l_Inst : IJournalBookmark;
begin
 l_Inst := Create(doc_id, para_id);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const journal_bookmark): BadFactoryType;
var
 l_Inst : IJournalBookmark;
begin
 l_Inst := Create(journal_bookmark);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(doc_id: Cardinal;
 const topic: TTopic;
 redaction_id: TRedactionID): BadFactoryType;
var
 l_Inst : ILink;
begin
 l_Inst := Create(doc_id, topic, redaction_id);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const document: IDocument;
 doc_id: Cardinal;
 const topic: TTopic;
 redaction_id: TRedactionID): BadFactoryType;
var
 l_Inst : ILink;
begin
 l_Inst := Create(document, doc_id, topic, redaction_id);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const left: IDocument;
 const right: IDocument): BadFactoryType; { can raise AllChangesInTables }
var
 l_Inst : IDiffDocDataProvider;
begin
 l_Inst := Create(left, right);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
