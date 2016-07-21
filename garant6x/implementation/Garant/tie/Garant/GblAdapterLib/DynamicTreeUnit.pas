unit DynamicTreeUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DynamicTreeUnit.pas"
// ���������: "Interfaces"
// ������� ������: "DynamicTree" MUID: (457450470167)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , SearchDefinesUnit
 , DynamicTreeDefinesUnit
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
  node: ;
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
  function GetType: TSortType; stdcall;
  procedure SetType(aValue: TSortType); stdcall;
  function GetOrder: TSortOrder; stdcall;
  procedure SetOrder(aValue: TSortOrder); stdcall;
  procedure GetSubFilter; stdcall;
  procedure SetSubFilter(const aValue); stdcall;
  property Type: TSortType
   read GetType
   write SetType;
  property Order: TSortOrder
   read GetOrder
   write SetOrder;
  property SubFilter: 
   read GetSubFilter
   write SetSubFilter;
 end;//ISortFilter

 ITrimFilter = interface(IFilterForTree)
  ['{31549898-CEF0-46C3-94D9-1D6FA71A2C65}']
  function GetIsTrimmed: ByteBool; stdcall;
  procedure SetIsTrimmed(const aValue: ByteBool); stdcall;
  property IsTrimmed: ByteBool
   read GetIsTrimmed
   write SetIsTrimmed;
 end;//ITrimFilter

 ILayerFilter = interface(IFilterForTree)
  {* ����� �������� ��� ������������ ����������� ������ (�����) }
  ['{217D0932-BA42-439D-8CCC-77ABAB9F12D6}']
  function GetLayer: TLayerId; stdcall;
  procedure SetLayer(aValue: TLayerId); stdcall;
  property Layer: TLayerId
   read GetLayer
   write SetLayer;
 end;//ILayerFilter

 IFindIterator = interface
  {* �������� ������. }
  ['{7C8B08E1-3BA1-4122-9E2F-4FDCC7935360}']
  function GetCount: Cardinal; stdcall;
  procedure Next; stdcall;
   {* ����������� ��������� �� ��������� �������. }
  procedure Prev; stdcall;
   {* ����������� ��������� �� ���������� �������. }
  procedure GetPosition(out aRet
   {* IFindPositionList }); stdcall;
  function IsGood: ByteBool; stdcall;
   {* ���������� true, ���� �� ��������� ����� �������� ������, �.�. position. ����� �������� �� ������, �.�. ����� end ��� ������ ���� }
  function IsFirst: ByteBool; stdcall;
   {* ���������� true, ���� ������ ������� �� ���������� �������� }
  property Count: Cardinal
   read GetCount;
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
  procedure SaveInSetting(id: TPropertyID); stdcall;
   {* ��������� "������" �� ������ ��������� � ����������, �������� �� � ���������� ��������� ������. ��� ������ ������� ������� �� ����������� ������ ������������ ������� ���������. }
  procedure LoadFromSetting(id: TPropertyID;
   out aRet
   {* ISettingEntity }); stdcall;
   {* ��������������� "������" �� �������� �������� � ������ ������ � ������ ����� (�������, �������) �������. }
 end;//ISettingEntity

 INodesClipboard = interface
  {* ��������� ��� ������������� ��� }
  ['{B990C46B-9FF3-4C7C-8C61-2DD226FE644E}']
  function GetCount: Cardinal; stdcall;
  procedure AsEvd(style: TEVDGeneratorStyle;
   out aRet
   {* IStream }); stdcall;
  property Count: Cardinal
   read GetCount;
 end;//INodesClipboard

 IFakeFacetForFactory = interface
  {* ����� ����� ��������� ����������, ����� ���� �������� }
  ['{6AFFD7FC-CA48-450D-8EB7-E7E47E04F9BF}']
 end;//IFakeFacetForFactory

 INodeNotifier = interface
  {* callback ��������� ��� ���������� ����������� ������ �� ���������� �� ���� }
  ['{D368CD98-23ED-4EA2-B1A8-E72679D98593}']
  procedure ChangeChildrenCount(node_index: TVisibleIndex;
   delta: Integer;
   const index_path: INodeIndexPath;
   child_index: TIndexInParent); stdcall;
   {* ����������� �� ��������� ���-�� ������� ����� �� ���� � ��������� ��������. � ������ ���� ��������� ��� ������ ���� �� ���������������� � �� �� ������, ������ ������ ���� ����� ��� -1. 
parent_path - ���� � ���� � ������� ��������� ��������� (���� delta < 0 - ��������, ���� delta > 0 - �������)
    left_child_index - ������ ������� � ����: ���� ��������, �� ������� � �������� (������������) �� ������� delta ����������; ���� �������, �� ����� ����� �������� �� ��������� delta ���������.
    left_child_index, ����� ������� "�����������" �������� IIP_BEFORE_LEFT_CHILD (-1) - ���������� ������� "�� �������" - �������� ��� ������� � ������ �����. }
  procedure ResetChildrenCount; stdcall;
   {* ������������� ���-�� ����� = 0 }
  function IsRootVisible: ByteBool; stdcall;
   {* ������� ���������� ��� �� � ������� ����� }
  function IsOneLevel: ByteBool; stdcall;
   {* ������� ���������� ��� �� ������������� }
  procedure Invalidate(const index_path: INodeIndexPath); stdcall;
   {* ����������� � ������������� �����������. ������ ���������� ����� change_children_count (������� ����� �����������) ��� �������������� ��� ��������� ������ �� ��������� � ���-��� �����.
    parent_path - ���� � ���� � ������� ��������� ��������� }
  procedure Changing; stdcall;
   {* ������ �������� ��������� ������ }
  procedure Changed; stdcall;
   {* ����� �������� ��������� ������ }
  function GetId: TNotifierID; stdcall;
   {* ���������� ���������� ������������� ������� }
 end;//INodeNotifier

 IListForFiltering = interface
  ['{89EBBAAC-B4DA-4DAB-9FEE-FE7F4A1BD86A}']
  function GetCount: Cardinal; stdcall;
  procedure Item(index: Cardinal;
   out aRet
   {* IString }); stdcall;
  property Count: Cardinal
   read GetCount;
 end;//IListForFiltering

 INodeIterator = interface;

 INodeBase = interface(ISettingEntity)
  {* ������� ��������� ���� "�����" �������� }
  ['{954590CB-D1B3-44B3-8492-650D28A0CD8F}']
  procedure GetCaption; stdcall;
  function GetLevel: Integer; stdcall;
  function GetType: TNodeType; stdcall;
  procedure SetType(aValue: TNodeType); stdcall; { can raise ConstantModify }
  function GetChildCount: Integer; stdcall;
  function GetIsExpanded: ByteBool; stdcall;
  procedure GetEntity; stdcall; { can raise NoEntity }
  procedure SetEntity(const aValue); stdcall;
  procedure GetFirstChild; stdcall;
  procedure GetPrev; stdcall;
  procedure GetNext; stdcall;
  procedure GetParent; stdcall;
  procedure AddNotifier(var notifier: INodeNotifier); stdcall;
  procedure CreateViewEx(const filter: IFilterList;
   shared_flags: TFlagMask;
   const sync_node: INodeBase;
   out sync_index: TVisibleIndex;
   levels: Cardinal;
   unfiltered: Boolean;
   auto_open: Boolean;
   truncate_this_view: Boolean;
   out aRet
   {* INodeBase }); stdcall;
   {* ����������� ������ ������ create_view. (������� ��� ������ ��������� �� ����) }
  procedure FindNode(const node_to_find: INodeBase;
   out aRet
   {* INodeBase }); stdcall;
   {* ���� � ������� ������ ���� ������ ���������� }
  procedure FindNodePath(var node_to_find: INodeBase;
   out aRet
   {* INodeIndexPath }); stdcall;
   {* ��������� ���������� ���� ����. ������ ������ � ���� ��� ���� node_to_find }
  procedure GetBySibblingIndex(ind: TVisibleIndex;
   out aRet
   {* INodeBase }); stdcall;
   {* ���������� ����-������ (�.�. "�����" �������) �� ������� }
  procedure GetByVisibleIndex(ind: TVisibleIndex;
   out aRet
   {* INodeBase }); stdcall;
   {* ���������� ���� �� �������� ������� ������������ ������� }
  procedure GetFirstFit(const filter: IFilterList;
   out aRet
   {* INodeIndexPath }); stdcall;
  function GetFlagCount(flag: TFlagMask): Cardinal; stdcall;
   {* ���������� ���-�� ��������� ������ � ������� ��������� }
  function GetFirstLevelChildrenFlagCount(flag: TFlagMask): Cardinal; stdcall;
  function GetNodeId: TNodeId; stdcall;
   {* ��������� �������������� ����. ������ ���������� �������, �� ��� ��������� value->id (), �.�. �� ��������. }
  procedure SetNodeId(id: TNodeId); stdcall;
   {* �������� ������������� ����. ������ ������ �� ������, �� ��� ��������� �������� value->id (). }
  procedure GetAvailableLayers(out aRet
   {* ILayerIdList }); stdcall;
  function GetVisibleDelta(const node: INodeBase): TVisibleIndex; stdcall; { can raise NotFound }
   {* ���������� ������� ������� �������� ���� ��� (����� ������������� ���������� ����������� ������) }
  function GetVisibleDeltaByEntity(const entity: IEntityBase): TVisibleIndex; stdcall; { can raise NotFound }
  function GetIndexFromParent: TVisibleIndex; stdcall;
   {* ���������� ���������� ����� ���� ������������ �������� (������� � 1) }
  function GetAbsIndex: TVisibleIndex; stdcall; { can raise CanNotFindData }
   {* ���������� ���. ������ ��� ���� }
  procedure GetChildPathByAbsIndex(index: TVisibleIndex;
   out aRet
   {* INodeIndexPath }); stdcall; { can raise CanNotFindData }
   {* ���������� ���� � ���� �� � ���. ������� }
  procedure GetFrozenNode(out aRet
   {* INodeBase }); stdcall;
  procedure GetUnfilteredNode(out aRet
   {* INodeBase }); stdcall;
  function HasChildren: ByteBool; stdcall;
   {* �������� ���� �� ���� }
  function HasChildrenFlag(flag: TFlagMask): ByteBool; stdcall;
   {* ������� ������� �� � ����� ��������� ���� }
  function HasFilteredChildren: ByteBool; stdcall;
   {* ������� ���� ��� ���� ��������� ��������������� ����� }
  function HasFlag(flag: TFlagMask): ByteBool; stdcall;
   {* ������� ������� �� ��������� ���� }
  function HasParentFlag(flag: TFlagMask): ByteBool; stdcall;
   {* ������� ������� �� � ��������� ��������� ���� }
  function IsFirst: ByteBool; stdcall;
   {* ������� ������ �� ��� ������� }
  function IsItHigher(var it: INodeBase): ByteBool; stdcall;
   {* ���������� true ���� ���������� ���� (it) ���� ������� }
  function IsLast: ByteBool; stdcall;
   {* ������� ��������� �� ��� ������� }
  function IsSameNode(var node: INodeBase): ByteBool; stdcall;
   {* ��������� �� ��������� ��� ���� }
  procedure IterateNodes(with_flag: TFlagMask;
   out aRet
   {* INodeIterator }); stdcall;
   {* ���������� �������� �������� �� ����� � ��������� ������ }
  procedure MakeVisible; stdcall;
  procedure RemoveNotifier(var notifier: INodeNotifier); stdcall;
  procedure SetAllFlag(flag: TFlagMask;
   value: Boolean); stdcall;
   {* ������������� � ����� ��������� (����� ����� ���� �� ������� ���� ������� ��������) ��������� ���� (������ �������� ������ �� ����, � ������ ������ ������ ���������, ����� �������� ���������) }
  procedure SetFlag(flag: TFlagMask;
   value: Boolean); stdcall;
   {* ������� ��������� ���� }
  procedure SetRangeFlag(offset_from: TVisibleIndex;
   offset_to: TVisibleIndex;
   flag: TFlagMask;
   value: Boolean;
   clean_other: Boolean); stdcall;
   {* ������� ��������� ���� �� ���������� }
  procedure DeleteNodes(mask: TFlagMask); stdcall; { can raise ConstantModify }
   {* ������� ��� ���� �� ��������� �����. �������� ��������� � �������� �� ����!!! }
  procedure DeleteNode; stdcall;
   {* ������� ������� ���� }
  procedure CopyNodes(mask: TFlagMask;
   out aRet
   {* INodesClipboard }); stdcall;
   {* �������� ���� �� ��������� ����� � ���������� �� � ���� ���������� ��� ����������� ������� � ����� ������ ������.�������� ��������� � �������� �� ����!!! }
  procedure AddLastChilds(var nodes: INodesClipboard); stdcall;
   {* ��������� ���� �� ���������� � ����� ������ ����� - �� ����� ���� ���� ���� ���������� �� ������� ������� ����� ����� �������, �� ����������� � ��������� ������� }
  procedure AddLastChild(var node: INodeBase); stdcall; { can raise ConstantModify }
   {* ���������� add_last_childs �� ��� ����� ���� (���-���� ���������� ��������, ����� create_new_node ��� �������� �� ������, ���� ��� ���� �� ������ �� ����� ������� �����) }
  procedure AddPrevSiblings(var nodes: INodesClipboard); stdcall; { can raise ConstantModify }
   {* ���������� add_last_childs, �� ���� ����������� ����� ��������� ��� ������, �������������� ����������� ����� ������ ������� ���� }
  procedure AddPrevSibling(var node: INodeBase); stdcall; { can raise ConstantModify }
   {* ���������� add_prev_siblings �� ��� ����� ���� }
  procedure StartChangeTransaction; stdcall;
   {* ��������� �� ������ ���������� ��������� ������ ����. ���������� ����� ���� ���������� }
  procedure RollbackChangeTransaction; stdcall;
   {* ���������� �������� ���������� (������ �� ����� ����������),  ���������� ��� ��������� (������������ � ������� ��� ����������� �������) }
  procedure CommitChangeTransaction; stdcall;
   {* ��������� ����������, � ���� ��� ������ ��� "�������" �������� ���������� - ��������� ��� ��������� ��������� �� ���� (���������� ������ �� ������) }
  procedure GetNodeByPath(const path: INodeIndexPath;
   out aRet
   {* INodeBase }); stdcall; { can raise NotFound }
   {* ��������� � CatalogBase }
  procedure Find(const filter: IFilterList
   {* ������� ������. };
   const find_from: TNodePosition
   {* ������ �� �������. };
   out aRet
   {* IFindIterator }); stdcall;
   {* ����� � ������ �� �������, ��������� � �������. � ������ ������ ���������� �������� ������� ���������, ����� ������ �������� (is_good!=true). }
  function IsRelevanceSearchSupported: ByteBool; stdcall;
  procedure ExpandAll(expand: Boolean); stdcall;
   {* ������������� � ������� ���� ��������� ���� ��� � ������ }
  class function Make; overload; stdcall; { can raise CanNotFindData }
  class function Make(var owner_tree: IFakeFacetForFactory;
   const snode); overload; stdcall;
  procedure IterateAllNodes(with_flag: TFlagMask;
   out aRet
   {* INodeIterator }); stdcall;
  procedure SetAllFlagExceptFirstChildrenOfRootChildren(flag: TFlagMask;
   value: Boolean); stdcall;
  procedure SetRangeFlagExceptFirstChildrenOfRootChildren(offset_from: TVisibleIndex;
   offset_to: TVisibleIndex;
   flag: TFlagMask;
   value: Boolean;
   clean_other: Boolean); stdcall;
  property Caption: 
   read GetCaption;
   {* ���������������� �������� ���� }
  property Level: Integer
   read GetLevel;
   {* ������� ���� � ������ }
  property Type: TNodeType
   read GetType
   write SetType;
   {* ���������������� ��� ����. ����� ���������� ��� ��������� ��������, ��� ������ �������������� ��� ������������� ����������� }
  property ChildCount: Integer
   read GetChildCount;
  property IsExpanded: ByteBool
   read GetIsExpanded;
   {* ���������� true, ���� ���������� ���� ��������� ���� ��� }
  property Entity: 
   read GetEntity
   write SetEntity;
  property FirstChild: 
   read GetFirstChild;
  property Prev: 
   read GetPrev;
  property Next: 
   read GetNext;
  property Parent: 
   read GetParent;
 end;//INodeBase

 INodeIterator = interface
  {* ��������� ��� ��������� ��������� ������ ��������� ������.
������ �������������� ������������� ��� ���������� �������� � ������������ ������� ��������� ������ (��������, �� ������� ���������� ���������). }
  ['{1F4887B9-4FA9-4B90-BB5C-0D3EAB6D0792}']
  procedure GetNext; stdcall;
  property Next: 
   read GetNext;
 end;//INodeIterator

 TNodePosition = record
  {* ������� ���� � ������ � ������ ���� ����. }
  pos: Integer;
   {* ������� ������ ���� node. }
  node: ;
 end;//TNodePosition

 ICatalogBase = interface
  {* �������� �������� ���������� �� ������ NodeBase � �������������� �������� ��������� (EntityBase). �������� ���������� BaseTreeSupport::BaseCatalog }
  ['{59A590F8-FB2D-49E6-A954-1B0CC9CCAD04}']
  procedure GetName; stdcall;
  procedure SetName(const aValue); stdcall;
  procedure GetRoot; stdcall;
  procedure Clone(out aRet
   {* ICatalogBase }); stdcall;
  procedure GetNodeByPath(const path: INodeIndexPath;
   out aRet
   {* INodeBase }); stdcall; { can raise NotFound }
  procedure IntersectTree(const tree: ICatalogBase); stdcall;
  procedure MergeTree(const tree: ICatalogBase); stdcall;
  procedure MinusTree(const tree: ICatalogBase); stdcall;
  procedure Create(var nodes: INodesClipboard;
   out aRet
   {* ICatalogBase }); stdcall;
  property Name: 
   read GetName
   write SetName;
  property Root: 
   read GetRoot;
 end;//ICatalogBase

 ITrimLeafFilter = interface(IFilterForTree)
  ['{7AC01117-FE4F-4D1C-AA39-44B55E57D5F7}']
 end;//ITrimLeafFilter

 ICountryFilter = interface(IFilterForTree)
  ['{88574AB6-4C05-455B-8E61-ACC170D68E31}']
  procedure GetCountry; stdcall;
  procedure SetCountry(const aValue); stdcall;
  property Country: 
   read GetCountry
   write SetCountry;
 end;//ICountryFilter

 ICutToLeafCountFilter = interface(IFilterForTree)
  {* ��������� � ������ ���������� �����, �� ������� ��������� }
  ['{080EAE7F-D346-4600-AA65-6CD21B8C7370}']
  function GetLeafCount: Cardinal; stdcall;
  procedure SetLeafCount(aValue: Cardinal); stdcall;
  property LeafCount: Cardinal
   read GetLeafCount
   write SetLeafCount;
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
  function GetDocId: Cardinal; stdcall;
  property DocId: Cardinal
   read GetDocId;
   {* ������������� ��������� }
 end;//IVariantsForDocFilter

 IFiltered = array of Cardinal;

 IContextFilter = interface(IFilterForTree)
  {* ����� ����������� �������� }
  ['{FCB4593F-FD35-46E5-87BB-7112D61FEC5A}']
  function GetPlace: TContextPlace; stdcall;
  procedure SetPlace(aValue: TContextPlace); stdcall;
  function GetOrder: TFindOrder; stdcall;
  procedure SetOrder(aValue: TFindOrder); stdcall;
  function GetArea: TSearchArea; stdcall;
  procedure SetArea(aValue: TSearchArea); stdcall;
  procedure GetContext; stdcall;
  procedure SetContext(const aValue); stdcall;
  procedure Clone(out aRet
   {* IContextFilter }); stdcall;
  procedure Filtrate(const list: IListForFiltering;
   out aRet
   {* IFiltered }); stdcall;
  property Place: TContextPlace
   read GetPlace
   write SetPlace;
  property Order: TFindOrder
   read GetOrder
   write SetOrder;
  property Area: TSearchArea
   read GetArea
   write SetArea;
  property Context: 
   read GetContext
   write SetContext;
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

implementation

uses
 l3ImplUses
;

end.
