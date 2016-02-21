unit DynamicTreeUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DynamicTreeUnit.pas"
// ���������: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , DynamicTreeDefinesUnit
 , BaseTypesUnit
 , IOUnit
;

const
 {* �������������� �������� }
 AT_ANNO_INTEREST: PAnsiChar = AT_ANNO_INTEREST;
 AT_ANNO_KIND: PAnsiChar = AT_ANNO_KIND;
 AT_ANNO_ORG: PAnsiChar = AT_ANNO_ORG;
 AT_ANNO_TAX: PAnsiChar = AT_ANNO_TAX;
 AT_ANNO_USER: PAnsiChar = AT_ANNO_USER;
 AT_BASES: PAnsiChar = AT_BASES;
 AT_CLASS: PAnsiChar = AT_CLASS;
 AT_EDITION: PAnsiChar = AT_EDITION;
 AT_KW: PAnsiChar = AT_KW;
 AT_NORM: PAnsiChar = AT_NORM;
 AT_PREFIX: PAnsiChar = AT_PREFIX;
 AT_PUBLISH_SOURCE: PAnsiChar = AT_PUBLISH_SOURCE;
 AT_REG_IN_MU_NUM: PAnsiChar = AT_REG_IN_MU_NUM;
 AT_REG_IN_MU: PAnsiChar = AT_REG_IN_MU;
 AT_REG_NUM: PAnsiChar = AT_REG_NUM;
 AT_SOURCE: PAnsiChar = AT_SOURCE;
 AT_STATUS: PAnsiChar = AT_STATUS;
 AT_TERRITORY: PAnsiChar = AT_TERRITORY;
 AT_TYPE: PAnsiChar = AT_TYPE;
 AT_UC: PAnsiChar = AT_UC;
 AT_PHARM_INTERNATIONAL_NAME: PAnsiChar = AT_PHARM_INTERNATIONAL_NAME;
 AT_PHARM_TRADE_NAME: PAnsiChar = AT_PHARM_TRADE_NAME;
 AT_PHARM_CHAPTER: PAnsiChar = AT_PHARM_CHAPTER;
 AT_PHARM_COUNTRY: PAnsiChar = AT_PHARM_COUNTRY;
 AT_PHARM_FIRM: PAnsiChar = AT_PHARM_FIRM;
 AT_PHARM_REG_STATUS: PAnsiChar = AT_PHARM_REG_STATUS;
 AT_PHARM_MEDICINAL_FORM: PAnsiChar = AT_PHARM_MEDICINAL_FORM;
 AT_PHARM_ATC: PAnsiChar = AT_PHARM_ATC;
 AT_PHARM_MKB: PAnsiChar = AT_PHARM_MKB;
 AT_PHARM_GROUP: PAnsiChar = AT_PHARM_GROUP;
 AT_PHARM_EFFECT: PAnsiChar = AT_PHARM_EFFECT;
 AT_PHARM_NARCOTIC: PAnsiChar = AT_PHARM_NARCOTIC;
 AT_PHARM_UNRECIPE: PAnsiChar = AT_PHARM_UNRECIPE;
 AT_PHARM_IMPORTANT: PAnsiChar = AT_PHARM_IMPORTANT;
 AT_PHARM_COUNTRY_FOR_FILTER: PAnsiChar = AT_PHARM_COUNTRY_FOR_FILTER;
 AT_VARIANTS: PAnsiChar = AT_VARIANTS;
  {* ������ ��������� ��� �������� ������ }
 AT_PREFIX_REVIEW: PAnsiChar = AT_PREFIX_REVIEW;
  {* ������ ����� �������� ���������� � �� ��� }
 AT_PUBLISH_SOURCE_FINANCE: PAnsiChar = AT_PUBLISH_SOURCE_FINANCE;
  {* ����� ������ �������� ������������� ��� ��� �� ������� � �������� }
 AT_PUBLISH_SOURCE_LEGAL: PAnsiChar = AT_PUBLISH_SOURCE_LEGAL;
  {* ����� ������ �������� ������������� ��� ��� ��� ������ }
 AT_PUBLISH_SOURCE_HR: PAnsiChar = AT_PUBLISH_SOURCE_HR;
  {* ����� ������ �������� ������������� ��� ��� ��� ��������� }
 AT_PUBLISH_SOURCE_BUDGET_ORGS: PAnsiChar = AT_PUBLISH_SOURCE_BUDGET_ORGS;
  {* ����� ������ �������� ������������� ��� ��� ��� ��������� ����������� }
 AT_BASE_SEARCH_PANES: PAnsiChar = AT_BASE_SEARCH_PANES;
  {* ������� �������� ������ }
 AT_CLASS_REVIEW: PAnsiChar = AT_CLASS_REVIEW;
 AT_SOURCE_REVIEW: PAnsiChar = AT_SOURCE_REVIEW;
 AT_PUBLISH_SOURCE_PHARM: PAnsiChar = AT_PUBLISH_SOURCE_PHARM;
 AT_IMPORTANT_DOCUMENTS: PAnsiChar = AT_IMPORTANT_DOCUMENTS;

type
 IFilterForTree = interface
  {* ����������� ��������� �������� �������� }
  ['{2EE1EBDC-4804-47C2-964A-89BABD67A457}']
 end;//IFilterForTree

 IFilterList = array of IFilterForTree;
  {* ������ �������� }

 TContextPlace = (
  CP_ANY
  , CP_BEGIN_OF_WORD
  , CP_BEGIN_OF_PHRASE
  , CP_WHOLE_WORD
 );//TContextPlace

 TIndexInParent = Cardinal;

 TFindOrder = (
  {* ������� ������ }
  FO_SEQUENCE
  , FO_ANY
 );//TFindOrder

 INodeIndexPath = array of TIndexInParent;
  {* ���� � ������, �������� ������� �������� ��� }

 TFindPosition = record
  {* ������� ���������� ���������. }
  node: INodeIndexPath;
   {* ���� � ���� ������ ������� ���������. }
  begin: Integer;
   {* ������ �������. }
  end: Integer;
   {* ����� �������. ���� -1 - �� �� �����. }
 end;//TFindPosition

 TNodeType = unsigned long long;
  {* ���������������� ��� ���� }

 TNodeId = Integer;
  {* ������������� ���� ������ }

 TSearchArea = (
  {* ������� ������
SA_IN_ALL_TEXT - ������������ � ����������� ������, ���� �� ����� ������, ��������� �� ������ ���� ��� ������ ���� ��������� ������ ����� ������ ������ ����� ����.
SA_IN_ONE_SENTENCES - ������������ � ����������� ������ ���� � ����� ����, ��������� ��� ����� ������� ������ ���������� ������ ����������� � ����� ������� }
  SA_ONE_LEVEL
  , SA_ALL_LEVEL
  , SA_IN_ALL_TEXT
  , SA_IN_ONE_SENTENCES
 );//TSearchArea

 IFindPositionList = array of TFindPosition;
  {* ����� ������� ��������� ������. }

 TVisibleIndex = Integer;
  {* ������� ������ � ������ }

 TLayerId = unsigned short;
  {* ������������� ������ }

 ILayerIdList = array of TLayerId;
  {* ������ ��������������� ������ }

 ISortFilter = interface(IFilterForTree)
  ['{D0268B80-08CD-419D-BDF5-D3DA7A12199D}']
  function Get_type: TSortType;
  procedure Set_type(aValue: TSortType);
  function Get_order: TSortOrder;
  procedure Set_order(aValue: TSortOrder);
  function Get_sub_filter: ISortFilter;
  procedure Set_sub_filter(const aValue: ISortFilter);
  property type: TSortType
   read Get_type
   write Set_type;
  property order: TSortOrder
   read Get_order
   write Set_order;
  property sub_filter: ISortFilter
   read Get_sub_filter
   write Set_sub_filter;
 end;//ISortFilter

 ITrimFilter = interface(IFilterForTree)
  ['{31549898-CEF0-46C3-94D9-1D6FA71A2C65}']
  function Get_is_trimmed: Boolean;
  procedure Set_is_trimmed(aValue: Boolean);
  property is_trimmed: Boolean
   read Get_is_trimmed
   write Set_is_trimmed;
 end;//ITrimFilter

 ILayerFilter = interface(IFilterForTree)
  {* ����� �������� ��� ������������ ����������� ������ (�����) }
  ['{217D0932-BA42-439D-8CCC-77ABAB9F12D6}']
  function Get_layer: TLayerId;
  procedure Set_layer(aValue: TLayerId);
  property layer: TLayerId
   read Get_layer
   write Set_layer;
 end;//ILayerFilter

 IFindIterator = interface
  {* �������� ������. }
  ['{7C8B08E1-3BA1-4122-9E2F-4FDCC7935360}']
  function Get_count: Cardinal;
  procedure next;
   {* ����������� ��������� �� ��������� �������. }
  procedure prev;
   {* ����������� ��������� �� ���������� �������. }
  function get_position: IFindPositionList;
  function is_good: Boolean;
   {* ���������� true, ���� �� ��������� ����� �������� ������, �.�. position. ����� �������� �� ������, �.�. ����� end ��� ������ ���� }
  function is_first: Boolean;
   {* ���������� true, ���� ������ ������� �� ���������� �������� }
  property count: Cardinal
   read Get_count;
   {* ���������� ��������� ���������� }
 end;//IFindIterator

 TNotifierID = Cardinal;

 TEVDGeneratorStyle = (
  {* ����� ������� ������ ��� ��� � evd }
  GS_DEFAULT
   {* �������� ������ ������� �������, ���������� ����� }
  , GS_FULL_TREE
   {* �������� ������ ���������, ���������� ����� }
  , GS_TOPIC_AS_NAME
   {* �������� ������ ������� �������, ������ ��� ���������� ������ ������� }
 );//TEVDGeneratorStyle

 NoEntity = class
  {* ������������ ��� ������� �������� �������� �� ���� ������� �� �� �������� }
 end;//NoEntity

 NotFound = class
  {* ������������ ���� get_visible_delta �� ����� ����� ���� }
 end;//NotFound

 TPropertyID = PAnsiChar;

 ISettingEntity = interface
  {* ����������� ���������, ���������� �������� ����� "���������" ���� � ���������� }
  ['{3790FA3D-D4C9-4A31-9864-F3D1CE9E97B1}']
  procedure save_in_setting(id: TPropertyID);
   {* ��������� "������" �� ������ ��������� � ����������, �������� �� � ���������� ��������� ������. ��� ������ ������� ������� �� ����������� ������ ������������ ������� ���������. }
  function load_from_setting(id: TPropertyID): ISettingEntity;
   {* ��������������� "������" �� �������� �������� � ������ ������ � ������ ����� (�������, �������) �������. }
 end;//ISettingEntity

 INodesClipboard = interface
  {* ��������� ��� ������������� ��� }
  ['{B990C46B-9FF3-4C7C-8C61-2DD226FE644E}']
  function Get_count: Cardinal;
  function as_evd(style: TEVDGeneratorStyle): IStream;
  property count: Cardinal
   read Get_count;
 end;//INodesClipboard

 IFakeFacetForFactory = interface
  {* ����� ����� ��������� ����������, ����� ���� �������� }
  ['{6AFFD7FC-CA48-450D-8EB7-E7E47E04F9BF}']
 end;//IFakeFacetForFactory

 INodeNotifier = interface
  {* callback ��������� ��� ���������� ����������� ������ �� ���������� �� ���� }
  ['{D368CD98-23ED-4EA2-B1A8-E72679D98593}']
  procedure change_children_count(node_index: TVisibleIndex;
   delta: Integer;
   const index_path: INodeIndexPath;
   child_index: TIndexInParent);
   {* ����������� �� ��������� ���-�� ������� ����� �� ���� � ��������� ��������. � ������ ���� ��������� ��� ������ ���� �� ���������������� � �� �� ������, ������ ������ ���� ����� ��� -1. 
parent_path - ���� � ���� � ������� ��������� ��������� (���� delta < 0 - ��������, ���� delta > 0 - �������)
    left_child_index - ������ ������� � ����: ���� ��������, �� ������� � �������� (������������) �� ������� delta ����������; ���� �������, �� ����� ����� �������� �� ��������� delta ���������.
    left_child_index, ����� ������� "�����������" �������� IIP_BEFORE_LEFT_CHILD (-1) - ���������� ������� "�� �������" - �������� ��� ������� � ������ �����. }
  procedure reset_children_count;
   {* ������������� ���-�� ����� = 0 }
  function is_root_visible: Boolean;
   {* ������� ���������� ��� �� � ������� ����� }
  function is_one_level: Boolean;
   {* ������� ���������� ��� �� ������������� }
  procedure invalidate(const index_path: INodeIndexPath);
   {* ����������� � ������������� �����������. ������ ���������� ����� change_children_count (������� ����� �����������) ��� �������������� ��� ��������� ������ �� ��������� � ���-��� �����.
    parent_path - ���� � ���� � ������� ��������� ��������� }
  procedure changing;
   {* ������ �������� ��������� ������ }
  procedure changed;
   {* ����� �������� ��������� ������ }
  function get_id: TNotifierID;
   {* ���������� ���������� ������������� ������� }
 end;//INodeNotifier

 IListForFiltering = interface
  ['{89EBBAAC-B4DA-4DAB-9FEE-FE7F4A1BD86A}']
  function Get_count: Cardinal;
  function item(index: Cardinal): IString;
  property count: Cardinal
   read Get_count;
 end;//IListForFiltering

 INodeIterator = interface;

 INodeBase = interface(ISettingEntity)
  {* ������� ��������� ���� "�����" �������� }
  ['{954590CB-D1B3-44B3-8492-650D28A0CD8F}']
  function Get_caption: IString;
  function Get_level: Integer;
  function Get_type: TNodeType;
  procedure Set_type(aValue: TNodeType); { can raise ConstantModify }
  function Get_child_count: Integer;
  function Get_is_expanded: Boolean;
  function Get_entity: IEntityBase; { can raise NoEntity }
  procedure Set_entity(const aValue: IEntityBase);
  function Get_first_child: INodeBase;
  function Get_prev: INodeBase;
  function Get_next: INodeBase;
  function Get_parent: INodeBase;
  procedure add_notifier(var notifier: INodeNotifier);
  function create_view_ex(const filter: IFilterList;
   shared_flags: TFlagMask;
   const sync_node: INodeBase;
   out sync_index: TVisibleIndex;
   levels: Cardinal;
   unfiltered: Boolean;
   auto_open: Boolean;
   truncate_this_view: Boolean): INodeBase;
   {* ����������� ������ ������ create_view. (������� ��� ������ ��������� �� ����) }
  function find_node(const node_to_find: INodeBase): INodeBase;
   {* ���� � ������� ������ ���� ������ ���������� }
  function find_node_path(var node_to_find: INodeBase): INodeIndexPath;
   {* ��������� ���������� ���� ����. ������ ������ � ���� ��� ���� node_to_find }
  function get_by_sibbling_index(ind: TVisibleIndex): INodeBase;
   {* ���������� ����-������ (�.�. "�����" �������) �� ������� }
  function get_by_visible_index(ind: TVisibleIndex): INodeBase;
   {* ���������� ���� �� �������� ������� ������������ ������� }
  function get_first_fit(const filter: IFilterList): INodeIndexPath;
  function get_flag_count(flag: TFlagMask): Cardinal;
   {* ���������� ���-�� ��������� ������ � ������� ��������� }
  function get_first_level_children_flag_count(flag: TFlagMask): Cardinal;
  function get_node_id: TNodeId;
   {* ��������� �������������� ����. ������ ���������� �������, �� ��� ��������� value->id (), �.�. �� ��������. }
  procedure set_node_id(id: TNodeId);
   {* �������� ������������� ����. ������ ������ �� ������, �� ��� ��������� �������� value->id (). }
  function get_available_layers: ILayerIdList;
  function get_visible_delta(const node: INodeBase): TVisibleIndex; { can raise NotFound }
   {* ���������� ������� ������� �������� ���� ��� (����� ������������� ���������� ����������� ������) }
  function get_visible_delta_by_entity(const entity: IEntityBase): TVisibleIndex; { can raise NotFound }
  function get_index_from_parent: TVisibleIndex;
   {* ���������� ���������� ����� ���� ������������ �������� (������� � 1) }
  function get_abs_index: TVisibleIndex; { can raise CanNotFindData }
   {* ���������� ���. ������ ��� ���� }
  function get_child_path_by_abs_index(index: TVisibleIndex): INodeIndexPath; { can raise CanNotFindData }
   {* ���������� ���� � ���� �� � ���. ������� }
  function get_frozen_node: INodeBase;
  function get_unfiltered_node: INodeBase;
  function has_children: Boolean;
   {* �������� ���� �� ���� }
  function has_children_flag(flag: TFlagMask): Boolean;
   {* ������� ������� �� � ����� ��������� ���� }
  function has_filtered_children: Boolean;
   {* ������� ���� ��� ���� ��������� ��������������� ����� }
  function has_flag(flag: TFlagMask): Boolean;
   {* ������� ������� �� ��������� ���� }
  function has_parent_flag(flag: TFlagMask): Boolean;
   {* ������� ������� �� � ��������� ��������� ���� }
  function is_first: Boolean;
   {* ������� ������ �� ��� ������� }
  function is_it_higher(var it: INodeBase): Boolean;
   {* ���������� true ���� ���������� ���� (it) ���� ������� }
  function is_last: Boolean;
   {* ������� ��������� �� ��� ������� }
  function is_same_node(var node: INodeBase): Boolean;
   {* ��������� �� ��������� ��� ���� }
  function iterate_nodes(with_flag: TFlagMask): INodeIterator;
   {* ���������� �������� �������� �� ����� � ��������� ������ }
  procedure make_visible;
  procedure remove_notifier(var notifier: INodeNotifier);
  procedure set_all_flag(flag: TFlagMask;
   value: Boolean);
   {* ������������� � ����� ��������� (����� ����� ���� �� ������� ���� ������� ��������) ��������� ���� (������ �������� ������ �� ����, � ������ ������ ������ ���������, ����� �������� ���������) }
  procedure set_flag(flag: TFlagMask;
   value: Boolean);
   {* ������� ��������� ���� }
  procedure set_range_flag(offset_from: TVisibleIndex;
   offset_to: TVisibleIndex;
   flag: TFlagMask;
   value: Boolean;
   clean_other: Boolean);
   {* ������� ��������� ���� �� ���������� }
  procedure delete_nodes(mask: TFlagMask); { can raise ConstantModify }
   {* ������� ��� ���� �� ��������� �����. �������� ��������� � �������� �� ����!!! }
  procedure delete_node;
   {* ������� ������� ���� }
  function copy_nodes(mask: TFlagMask): INodesClipboard;
   {* �������� ���� �� ��������� ����� � ���������� �� � ���� ���������� ��� ����������� ������� � ����� ������ ������.�������� ��������� � �������� �� ����!!! }
  procedure add_last_childs(var nodes: INodesClipboard);
   {* ��������� ���� �� ���������� � ����� ������ ����� - �� ����� ���� ���� ���� ���������� �� ������� ������� ����� ����� �������, �� ����������� � ��������� ������� }
  procedure add_last_child(var node: INodeBase); { can raise ConstantModify }
   {* ���������� add_last_childs �� ��� ����� ���� (���-���� ���������� ��������, ����� create_new_node ��� �������� �� ������, ���� ��� ���� �� ������ �� ����� ������� �����) }
  procedure add_prev_siblings(var nodes: INodesClipboard); { can raise ConstantModify }
   {* ���������� add_last_childs, �� ���� ����������� ����� ��������� ��� ������, �������������� ����������� ����� ������ ������� ���� }
  procedure add_prev_sibling(var node: INodeBase); { can raise ConstantModify }
   {* ���������� add_prev_siblings �� ��� ����� ���� }
  procedure start_change_transaction;
   {* ��������� �� ������ ���������� ��������� ������ ����. ���������� ����� ���� ���������� }
  procedure rollback_change_transaction;
   {* ���������� �������� ���������� (������ �� ����� ����������),  ���������� ��� ��������� (������������ � ������� ��� ����������� �������) }
  procedure commit_change_transaction;
   {* ��������� ����������, � ���� ��� ������ ��� "�������" �������� ���������� - ��������� ��� ��������� ��������� �� ���� (���������� ������ �� ������) }
  function get_node_by_path(const path: INodeIndexPath): INodeBase; { can raise NotFound }
   {* ��������� � CatalogBase }
  function find(const filter: IFilterList
   {* ������� ������. };
   const find_from: TNodePosition
   {* ������ �� �������. }): IFindIterator;
   {* ����� � ������ �� �������, ��������� � �������. � ������ ������ ���������� �������� ������� ���������, ����� ������ �������� (is_good!=true). }
  function is_relevance_search_supported: Boolean;
  procedure expand_all(expand: Boolean);
   {* ������������� � ������� ���� ��������� ���� ��� � ������ }
  class function make: BadFactoryType; overload; { can raise CanNotFindData }
  class function make(var owner_tree: IFakeFacetForFactory;
   const snode): BadFactoryType; overload;
  function iterate_all_nodes(with_flag: TFlagMask): INodeIterator;
  procedure set_all_flag_except_first_children_of_root_children(flag: TFlagMask;
   value: Boolean);
  procedure set_range_flag_except_first_children_of_root_children(offset_from: TVisibleIndex;
   offset_to: TVisibleIndex;
   flag: TFlagMask;
   value: Boolean;
   clean_other: Boolean);
  property caption: IString
   read Get_caption;
   {* ���������������� �������� ���� }
  property level: Integer
   read Get_level;
   {* ������� ���� � ������ }
  property type: TNodeType
   read Get_type
   write Set_type;
   {* ���������������� ��� ����. ����� ���������� ��� ��������� ��������, ��� ������ �������������� ��� ������������� ����������� }
  property child_count: Integer
   read Get_child_count;
  property is_expanded: Boolean
   read Get_is_expanded;
   {* ���������� true, ���� ���������� ���� ��������� ���� ��� }
  property entity: IEntityBase
   read Get_entity
   write Set_entity;
  property first_child: INodeBase
   read Get_first_child;
  property prev: INodeBase
   read Get_prev;
  property next: INodeBase
   read Get_next;
  property parent: INodeBase
   read Get_parent;
 end;//INodeBase

 INodeIterator = interface
  {* ��������� ��� ��������� ��������� ������ ��������� ������.
������ �������������� ������������� ��� ���������� �������� � ������������ ������� ��������� ������ (��������, �� ������� ���������� ���������). }
  ['{1F4887B9-4FA9-4B90-BB5C-0D3EAB6D0792}']
  function Get_next: INodeBase;
  property next: INodeBase
   read Get_next;
 end;//INodeIterator

 TNodePosition = record
  {* ������� ���� � ������ � ������ ���� ����. }
  pos: Integer;
   {* ������� ������ ���� node. }
  node: INodeBase;
 end;//TNodePosition

 ICatalogBase = interface
  {* �������� �������� ���������� �� ������ NodeBase � �������������� �������� ��������� (EntityBase). �������� ���������� BaseTreeSupport::BaseCatalog }
  ['{59A590F8-FB2D-49E6-A954-1B0CC9CCAD04}']
  function Get_name: IString;
  procedure Set_name(const aValue: IString);
  function Get_root: INodeBase;
  function clone: ICatalogBase;
  function get_node_by_path(const path: INodeIndexPath): INodeBase; { can raise NotFound }
  procedure intersect_tree(const tree: ICatalogBase);
  procedure merge_tree(const tree: ICatalogBase);
  procedure minus_tree(const tree: ICatalogBase);
  function create(var nodes: INodesClipboard): ICatalogBase;
  property name: IString
   read Get_name
   write Set_name;
  property root: INodeBase
   read Get_root;
 end;//ICatalogBase

 ITrimLeafFilter = interface(IFilterForTree)
  ['{7AC01117-FE4F-4D1C-AA39-44B55E57D5F7}']
 end;//ITrimLeafFilter

 ICountryFilter = interface(IFilterForTree)
  ['{88574AB6-4C05-455B-8E61-ACC170D68E31}']
  function Get_country: INodeBase;
  procedure Set_country(const aValue: INodeBase);
  property country: INodeBase
   read Get_country
   write Set_country;
 end;//ICountryFilter

 ICutToLeafCountFilter = interface(IFilterForTree)
  {* ��������� � ������ ���������� �����, �� ������� ��������� }
  ['{080EAE7F-D346-4600-AA65-6CD21B8C7370}']
  function Get_leaf_count: Cardinal;
  procedure Set_leaf_count(aValue: Cardinal);
  property leaf_count: Cardinal
   read Get_leaf_count
   write Set_leaf_count;
   {* �������� ����� ������� ��� ������� }
 end;//ICutToLeafCountFilter

 INodeIdList = array of TNodeId;
  {* ������ ��������������� ��� }

 IBlocksFilter = interface(IFilterForTree)
  {* ������ ��������� ������ �� �����, ������� �������� ����������� ������������ }
  ['{30D760A8-3BA6-47C7-A2A7-08F504585CB8}']
 end;//IBlocksFilter

 IInpharmFilter = interface(IFilterForTree)
  {* �� ���������� � ������ ������ ����� ��� ������ }
  ['{9F35901C-BCED-426C-9B29-45F0EFCA688C}']
 end;//IInpharmFilter

 IVariantsForDocFilter = interface(IFilterForTree)
  {* �������� ��������� ��� ��������� ��������� }
  ['{7E6C4CC8-5E83-4074-BC63-93286053A532}']
  function Get_doc_id: Cardinal;
  property doc_id: Cardinal
   read Get_doc_id;
   {* ������������� ��������� }
 end;//IVariantsForDocFilter

 IFiltered = array of Cardinal;

 IContextFilter = interface(IFilterForTree)
  {* ����� ����������� �������� }
  ['{FCB4593F-FD35-46E5-87BB-7112D61FEC5A}']
  function Get_place: TContextPlace;
  procedure Set_place(aValue: TContextPlace);
  function Get_order: TFindOrder;
  procedure Set_order(aValue: TFindOrder);
  function Get_area: TSearchArea;
  procedure Set_area(aValue: TSearchArea);
  function Get_context: IString;
  procedure Set_context(const aValue: IString);
  function clone: IContextFilter;
  function filtrate(const list: IListForFiltering): IFiltered;
  property place: TContextPlace
   read Get_place
   write Set_place;
  property order: TFindOrder
   read Get_order
   write Set_order;
  property area: TSearchArea
   read Get_area
   write Set_area;
  property context: IString
   read Get_context
   write Set_context;
 end;//IContextFilter

const
 {* ��������� ��� ������ }
 FM_SHARED_NONE: TFlagMask = 0;
 FM_OPEN: TFlagMask = 2;
 FM_SELECTION: TFlagMask = 1;
 FM_FIRST_USER_FLAG: TFlagMask = 4;
 FM_USER_FLAG_MASK: TFlagMask = 65532;
 FM_SHARED_ALL: TFlagMask = 65535;
 IIP_BEFORE_LEFT_CHILD: TIndexInParent = 4294967295;
 VI_ALL_CHILDREN: TVisibleIndex = -1;
  {* ����������� �� ��������� ���� �����. }
 {* ��������� ����� ���� }
 NT_UNKNOWN: TNodeType = 0;

class function make: BadFactoryType;
class function make(const iterator): BadFactoryType;
class function make: BadFactoryType; overload;
class function make(const node_holder): BadFactoryType; overload;
class function make: BadFactoryType;
class function make(const country: INodeBase): BadFactoryType;
class function make(leaf_count: Cardinal): BadFactoryType;
 {* ������� ������, ����������� � ������ �� ����� leaf_count ������� }
class function make(doc_id: Cardinal): BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
var
 l_Inst : IFilterForTree;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const iterator): BadFactoryType;
var
 l_Inst : IFindIterator;
begin
 l_Inst := Create(iterator);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : INodesClipboard;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const node_holder): BadFactoryType;
var
 l_Inst : INodesClipboard;
begin
 l_Inst := Create(node_holder);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : INodeIterator;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const country: INodeBase): BadFactoryType;
var
 l_Inst : ICountryFilter;
begin
 l_Inst := Create(country);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(leaf_count: Cardinal): BadFactoryType;
 {* ������� ������, ����������� � ������ �� ����� leaf_count ������� }
var
 l_Inst : ICutToLeafCountFilter;
begin
 l_Inst := Create(leaf_count);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(doc_id: Cardinal): BadFactoryType;
var
 l_Inst : IVariantsForDocFilter;
begin
 l_Inst := Create(doc_id);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
