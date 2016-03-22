unit DynamicTreeUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/DynamicTreeUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicTree
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
  SearchDefinesUnit,
  DynamicTreeDefinesUnit
  ;

type
 IFilterForTree = interface(IUnknown)
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
   node : INodeIndexPath; // ���� � ���� ������ ������� ���������.
   begin : Integer; // ������ �������.
   end : Integer; // ����� �������. ���� -1 - �� �� �����.
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

const
  { ��������� ��� ������ }
 FM_SHARED_NONE : TFlagMask = 0;
 FM_OPEN : TFlagMask = 2;
 FM_SELECTION : TFlagMask = 1;
 FM_FIRST_USER_FLAG : TFlagMask = 4;
 FM_USER_FLAG_MASK : TFlagMask = 65532;
 FM_SHARED_ALL : TFlagMask = 65535;
 IIP_BEFORE_LEFT_CHILD : TIndexInParent = 4294967295;
 VI_ALL_CHILDREN : TVisibleIndex = -1;
  { ����������� �� ��������� ���� �����. }

type
 ILayerIdList = array of TLayerId;
  {* ������ ��������������� ������ }

 ISortFilter = interface(IFilterForTree)
   ['{D0268B80-08CD-419D-BDF5-D3DA7A12199D}']
   function GetType: TSortType; stdcall;
   procedure SetType(aValue: TSortType); stdcall;
   function GetOrder: TSortOrder; stdcall;
   procedure SetOrder(aValue: TSortOrder); stdcall;
   function GetSubFilter: ISortFilter; stdcall;
   procedure SetSubFilter(const aValue: ISortFilter); stdcall;
   property type: TSortType
     read GetType
     write SetType;
   property order: TSortOrder
     read GetOrder
     write SetOrder;
   property sub_filter: ISortFilter
     read GetSubFilter
     write SetSubFilter;
 end;//ISortFilter

 ITrimFilter = interface(IFilterForTree)
   ['{31549898-CEF0-46C3-94D9-1D6FA71A2C65}']
   function GetIsTrimmed: ByteBool; stdcall;
   procedure SetIsTrimmed(aValue: Boolean); stdcall;
   property is_trimmed: ByteBool
     read GetIsTrimmed
     write SetIsTrimmed;
 end;//ITrimFilter

 ILayerFilter = interface(IFilterForTree)
  {* ����� �������� ��� ������������ ����������� ������ (�����) }
   ['{217D0932-BA42-439D-8CCC-77ABAB9F12D6}']
   function GetLayer: TLayerId; stdcall;
   procedure SetLayer(aValue: TLayerId); stdcall;
   property layer: TLayerId
     read GetLayer
     write SetLayer;
 end;//ILayerFilter

 IFindIterator = interface(IUnknown)
  {* �������� ������. }
   ['{7C8B08E1-3BA1-4122-9E2F-4FDCC7935360}']
   function GetCount: Cardinal; stdcall;
   procedure Next; stdcall;
     {* ����������� ��������� �� ��������� �������. }
   procedure Prev; stdcall;
     {* ����������� ��������� �� ���������� �������. }
   procedure GetPosition(out aRet {: IFindPositionList}); stdcall;
   function IsGood: ByteBool; stdcall;
     {* ���������� true, ���� �� ��������� ����� �������� ������, �.�. position. ����� �������� �� ������, �.�. ����� end ��� ������ ���� }
   function IsFirst: ByteBool; stdcall;
     {* ���������� true, ���� ������ ������� �� ���������� �������� }
   property count: Cardinal
     read GetCount;
     {* ���������� ��������� ���������� }
 end;//IFindIterator

 TNotifierID = Cardinal;

 TEVDGeneratorStyle = (
  {* ����� ������� ������ ��� ��� � evd }
   GS_DEFAULT // �������� ������ ������� �������, ���������� �����
 , GS_FULL_TREE // �������� ������ ���������, ���������� �����
 , GS_TOPIC_AS_NAME // �������� ������ ������� �������, ������ ��� ���������� ������ �������
 );//TEVDGeneratorStyle

 NoEntity = class
  {* ������������ ��� ������� �������� �������� �� ���� ������� �� �� �������� }
 end;//NoEntity

 NotFound = class
  {* ������������ ���� get_visible_delta �� ����� ����� ���� }
 end;//NotFound

 TPropertyID = PAnsiChar;

 ISettingEntity = interface(IUnknown)
  {* ����������� ���������, ���������� �������� ����� "���������" ���� � ���������� }
   ['{3790FA3D-D4C9-4A31-9864-F3D1CE9E97B1}']
   procedure SaveInSetting(aId: TPropertyID); stdcall;
     {* ��������� "������" �� ������ ��������� � ����������, �������� �� � ���������� ��������� ������. ��� ������ ������� ������� �� ����������� ������ ������������ ������� ���������. }
   procedure LoadFromSetting(aId: TPropertyID; out aRet {: ISettingEntity}); stdcall;
     {* ��������������� "������" �� �������� �������� � ������ ������ � ������ ����� (�������, �������) �������. }
 end;//ISettingEntity

const
  { ��������� ����� ���� }
 NT_UNKNOWN : TNodeType = 0;

type
 INodesClipboard = interface(IUnknown)
  {* ��������� ��� ������������� ��� }
   ['{B990C46B-9FF3-4C7C-8C61-2DD226FE644E}']
   function GetCount: Cardinal; stdcall;
   procedure AsEvd(aStyle: TEVDGeneratorStyle; out aRet {: IStream}); stdcall;
   property count: Cardinal
     read GetCount;
 end;//INodesClipboard

 IFakeFacetForFactory = interface(IUnknown)
  {* ����� ����� ��������� ����������, ����� ���� �������� }
   ['{6AFFD7FC-CA48-450D-8EB7-E7E47E04F9BF}']
 end;//IFakeFacetForFactory

 INodeNotifier = interface(IUnknown)
  {* callback ��������� ��� ���������� ����������� ������ �� ���������� �� ���� }
   ['{D368CD98-23ED-4EA2-B1A8-E72679D98593}']
   procedure ChangeChildrenCount(aNodeIndex: TVisibleIndex;
    aDelta: Integer;
    const aIndexPath: INodeIndexPath;
    aChildIndex: TIndexInParent); stdcall;
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
   procedure Invalidate(const aIndexPath: INodeIndexPath); stdcall;
     {* ����������� � ������������� �����������. ������ ���������� ����� change_children_count (������� ����� �����������) ��� �������������� ��� ��������� ������ �� ��������� � ���-��� �����.
    parent_path - ���� � ���� � ������� ��������� ��������� }
   procedure Changing; stdcall;
     {* ������ �������� ��������� ������ }
   procedure Changed; stdcall;
     {* ����� �������� ��������� ������ }
   function GetId: TNotifierID; stdcall;
     {* ���������� ���������� ������������� ������� }
 end;//INodeNotifier

 IListForFiltering = interface(IUnknown)
   ['{89EBBAAC-B4DA-4DAB-9FEE-FE7F4A1BD86A}']
   function GetCount: Cardinal; stdcall;
   procedure Item(aIndex: Cardinal; out aRet {: IString}); stdcall;
   property count: Cardinal
     read GetCount;
 end;//IListForFiltering

 INodeIterator = interface;
 { - ��������������� �������� NodeIterator. }

 INodeBase = interface(ISettingEntity)
  {* ������� ��������� ���� "�����" �������� }
   ['{954590CB-D1B3-44B3-8492-650D28A0CD8F}']
   function GetCaption: IString; stdcall;
   function GetLevel: Integer; stdcall;
   function GetType: TNodeType; stdcall;
   procedure SetType(aValue: TNodeType); stdcall;
   function GetChildCount: Integer; stdcall;
   function GetIsExpanded: ByteBool; stdcall;
   function GetEntity: IEntityBase; stdcall;
   procedure SetEntity(const aValue: IEntityBase); stdcall;
   function GetFirstChild: INodeBase; stdcall;
   function GetPrev: INodeBase; stdcall;
   function GetNext: INodeBase; stdcall;
   function GetParent: INodeBase; stdcall;
   procedure AddNotifier(var aNotifier: INodeNotifier); stdcall;
   procedure CreateViewEx(const aFilter: IFilterList;
    aSharedFlags: TFlagMask;
    const aSyncNode: INodeBase;
    out aSyncIndex: TVisibleIndex;
    aLevels: Cardinal;
    aUnfiltered: Boolean;
    aAutoOpen: Boolean;
    aTruncateThisView: Boolean; out aRet {: INodeBase}); stdcall;
     {* ����������� ������ ������ create_view. (������� ��� ������ ��������� �� ����) }
   procedure FindNode(const aNodeToFind: INodeBase; out aRet {: INodeBase}); stdcall;
     {* ���� � ������� ������ ���� ������ ���������� }
   procedure FindNodePath(var aNodeToFind: INodeBase; out aRet {: INodeIndexPath}); stdcall;
     {* ��������� ���������� ���� ����. ������ ������ � ���� ��� ���� node_to_find }
   procedure GetBySibblingIndex(aInd: TVisibleIndex; out aRet {: INodeBase}); stdcall;
     {* ���������� ����-������ (�.�. "�����" �������) �� ������� }
   procedure GetByVisibleIndex(aInd: TVisibleIndex; out aRet {: INodeBase}); stdcall;
     {* ���������� ���� �� �������� ������� ������������ ������� }
   procedure GetFirstFit(const aFilter: IFilterList; out aRet {: INodeIndexPath}); stdcall;
   function GetFlagCount(aFlag: TFlagMask): Cardinal; stdcall;
     {* ���������� ���-�� ��������� ������ � ������� ��������� }
   function GetFirstLevelChildrenFlagCount(aFlag: TFlagMask): Cardinal; stdcall;
   function GetNodeId: TNodeId; stdcall;
     {* ��������� �������������� ����. ������ ���������� �������, �� ��� ��������� value->id (), �.�. �� ��������. }
   procedure SetNodeId(aId: TNodeId); stdcall;
     {* �������� ������������� ����. ������ ������ �� ������, �� ��� ��������� �������� value->id (). }
   procedure GetAvailableLayers(out aRet {: ILayerIdList}); stdcall;
   function GetVisibleDelta(const aNode: INodeBase): TVisibleIndex; stdcall; // can raise NotFound
     {* ���������� ������� ������� �������� ���� ��� (����� ������������� ���������� ����������� ������) }
   function GetVisibleDeltaByEntity(const aEntity: IEntityBase): TVisibleIndex; stdcall; // can raise NotFound
   function GetIndexFromParent: TVisibleIndex; stdcall;
     {* ���������� ���������� ����� ���� ������������ �������� (������� � 1) }
   function GetAbsIndex: TVisibleIndex; stdcall; // can raise CanNotFindData
     {* ���������� ���. ������ ��� ���� }
   procedure GetChildPathByAbsIndex(aIndex: TVisibleIndex; out aRet {: INodeIndexPath}); stdcall; // can raise CanNotFindData
     {* ���������� ���� � ���� �� � ���. ������� }
   procedure GetFrozenNode(out aRet {: INodeBase}); stdcall;
   procedure GetUnfilteredNode(out aRet {: INodeBase}); stdcall;
   function HasChildren: ByteBool; stdcall;
     {* �������� ���� �� ���� }
   function HasChildrenFlag(aFlag: TFlagMask): ByteBool; stdcall;
     {* ������� ������� �� � ����� ��������� ���� }
   function HasFilteredChildren: ByteBool; stdcall;
     {* ������� ���� ��� ���� ��������� ��������������� ����� }
   function HasFlag(aFlag: TFlagMask): ByteBool; stdcall;
     {* ������� ������� �� ��������� ���� }
   function HasParentFlag(aFlag: TFlagMask): ByteBool; stdcall;
     {* ������� ������� �� � ��������� ��������� ���� }
   function IsFirst: ByteBool; stdcall;
     {* ������� ������ �� ��� ������� }
   function IsItHigher(var aIt: INodeBase): ByteBool; stdcall;
     {* ���������� true ���� ���������� ���� (it) ���� ������� }
   function IsLast: ByteBool; stdcall;
     {* ������� ��������� �� ��� ������� }
   function IsSameNode(var aNode: INodeBase): ByteBool; stdcall;
     {* ��������� �� ��������� ��� ���� }
   procedure IterateNodes(aWithFlag: TFlagMask; out aRet {: INodeIterator}); stdcall;
     {* ���������� �������� �������� �� ����� � ��������� ������ }
   procedure MakeVisible; stdcall;
   procedure RemoveNotifier(var aNotifier: INodeNotifier); stdcall;
   procedure SetAllFlag(aFlag: TFlagMask;
    aValue: Boolean); stdcall;
     {* ������������� � ����� ��������� (����� ����� ���� �� ������� ���� ������� ��������) ��������� ���� (������ �������� ������ �� ����, � ������ ������ ������ ���������, ����� �������� ���������) }
   procedure SetFlag(aFlag: TFlagMask;
    aValue: Boolean); stdcall;
     {* ������� ��������� ���� }
   procedure SetRangeFlag(aOffsetFrom: TVisibleIndex;
    aOffsetTo: TVisibleIndex;
    aFlag: TFlagMask;
    aValue: Boolean;
    aCleanOther: Boolean); stdcall;
     {* ������� ��������� ���� �� ���������� }
   procedure DeleteNodes(aMask: TFlagMask); stdcall; // can raise ConstantModify
     {* ������� ��� ���� �� ��������� �����. �������� ��������� � �������� �� ����!!! }
   procedure DeleteNode; stdcall;
     {* ������� ������� ���� }
   procedure CopyNodes(aMask: TFlagMask; out aRet {: INodesClipboard}); stdcall;
     {* �������� ���� �� ��������� ����� � ���������� �� � ���� ���������� ��� ����������� ������� � ����� ������ ������.�������� ��������� � �������� �� ����!!! }
   procedure AddLastChilds(var aNodes: INodesClipboard); stdcall;
     {* ��������� ���� �� ���������� � ����� ������ ����� - �� ����� ���� ���� ���� ���������� �� ������� ������� ����� ����� �������, �� ����������� � ��������� ������� }
   procedure AddLastChild(var aNode: INodeBase); stdcall; // can raise ConstantModify
     {* ���������� add_last_childs �� ��� ����� ���� (���-���� ���������� ��������, ����� create_new_node ��� �������� �� ������, ���� ��� ���� �� ������ �� ����� ������� �����) }
   procedure AddPrevSiblings(var aNodes: INodesClipboard); stdcall; // can raise ConstantModify
     {* ���������� add_last_childs, �� ���� ����������� ����� ��������� ��� ������, �������������� ����������� ����� ������ ������� ���� }
   procedure AddPrevSibling(var aNode: INodeBase); stdcall; // can raise ConstantModify
     {* ���������� add_prev_siblings �� ��� ����� ���� }
   procedure StartChangeTransaction; stdcall;
     {* ��������� �� ������ ���������� ��������� ������ ����. ���������� ����� ���� ���������� }
   procedure RollbackChangeTransaction; stdcall;
     {* ���������� �������� ���������� (������ �� ����� ����������),  ���������� ��� ��������� (������������ � ������� ��� ����������� �������) }
   procedure CommitChangeTransaction; stdcall;
     {* ��������� ����������, � ���� ��� ������ ��� "�������" �������� ���������� - ��������� ��� ��������� ��������� �� ���� (���������� ������ �� ������) }
   procedure GetNodeByPath(const aPath: INodeIndexPath; out aRet {: INodeBase}); stdcall; // can raise NotFound
     {* ��������� � CatalogBase }
   procedure Find(const aFilter: IFilterList
    {* ������� ������.};
    const aFindFrom: TNodePosition
    {* ������ �� �������.}; out aRet {: IFindIterator}); stdcall;
     {* ����� � ������ �� �������, ��������� � �������. � ������ ������ ���������� �������� ������� ���������, ����� ������ �������� (is_good!=true). }
   function IsRelevanceSearchSupported: ByteBool; stdcall;
   procedure ExpandAll(aExpand: Boolean); stdcall;
     {* ������������� � ������� ���� ��������� ���� ��� � ������ }
   procedure IterateAllNodes(aWithFlag: TFlagMask; out aRet {: INodeIterator}); stdcall;
   procedure SetAllFlagExceptFirstChildrenOfRootChildren(aFlag: TFlagMask;
    aValue: Boolean); stdcall;
   procedure SetRangeFlagExceptFirstChildrenOfRootChildren(aOffsetFrom: TVisibleIndex;
    aOffsetTo: TVisibleIndex;
    aFlag: TFlagMask;
    aValue: Boolean;
    aCleanOther: Boolean); stdcall;
   property caption: IString
     read GetCaption;
     {* ���������������� �������� ���� }
   property level: Integer
     read GetLevel;
     {* ������� ���� � ������ }
   property type: TNodeType
     read GetType
     write SetType;
     {* ���������������� ��� ����. ����� ���������� ��� ��������� ��������, ��� ������ �������������� ��� ������������� ����������� }
   property child_count: Integer
     read GetChildCount;
   property is_expanded: ByteBool
     read GetIsExpanded;
     {* ���������� true, ���� ���������� ���� ��������� ���� ��� }
   property entity: IEntityBase
     read GetEntity
     write SetEntity;
   property first_child: INodeBase
     read GetFirstChild;
   property prev: INodeBase
     read GetPrev;
   property next: INodeBase
     read GetNext;
   property parent: INodeBase
     read GetParent;
 end;//INodeBase

 INodeIterator = interface(IUnknown)
  {* ��������� ��� ��������� ��������� ������ ��������� ������.
������ �������������� ������������� ��� ���������� �������� � ������������ ������� ��������� ������ (��������, �� ������� ���������� ���������). }
   ['{1F4887B9-4FA9-4B90-BB5C-0D3EAB6D0792}']
   function GetNext: INodeBase; stdcall;
   property next: INodeBase
     read GetNext;
 end;//INodeIterator

 TNodePosition = record
  {* ������� ���� � ������ � ������ ���� ����. }
   pos : Integer; // ������� ������ ���� node.
   node : INodeBase;
 end;//TNodePosition

 ICatalogBase = interface(IUnknown)
  {* �������� �������� ���������� �� ������ NodeBase � �������������� �������� ��������� (EntityBase). �������� ���������� BaseTreeSupport::BaseCatalog }
   ['{59A590F8-FB2D-49E6-A954-1B0CC9CCAD04}']
   function GetName: IString; stdcall;
   procedure SetName(const aValue: IString); stdcall;
   function GetRoot: INodeBase; stdcall;
   procedure Clone(out aRet {: ICatalogBase}); stdcall;
   procedure GetNodeByPath(const aPath: INodeIndexPath; out aRet {: INodeBase}); stdcall; // can raise NotFound
   procedure IntersectTree(const aTree: ICatalogBase); stdcall;
   procedure MergeTree(const aTree: ICatalogBase); stdcall;
   procedure MinusTree(const aTree: ICatalogBase); stdcall;
   procedure Create(var aNodes: INodesClipboard; out aRet {: ICatalogBase}); stdcall;
   property name: IString
     read GetName
     write SetName;
   property root: INodeBase
     read GetRoot;
 end;//ICatalogBase

 ITrimLeafFilter = interface(IFilterForTree)
   ['{7AC01117-FE4F-4D1C-AA39-44B55E57D5F7}']
 end;//ITrimLeafFilter

const
  { �������������� �������� }
 AT_ANNO_INTEREST : PAnsiChar = AT_ANNO_INTEREST;
 AT_ANNO_KIND : PAnsiChar = AT_ANNO_KIND;
 AT_ANNO_ORG : PAnsiChar = AT_ANNO_ORG;
 AT_ANNO_TAX : PAnsiChar = AT_ANNO_TAX;
 AT_ANNO_USER : PAnsiChar = AT_ANNO_USER;
 AT_BASES : PAnsiChar = AT_BASES;
 AT_CLASS : PAnsiChar = AT_CLASS;
 AT_EDITION : PAnsiChar = AT_EDITION;
 AT_KW : PAnsiChar = AT_KW;
 AT_NORM : PAnsiChar = AT_NORM;
 AT_PREFIX : PAnsiChar = AT_PREFIX;
 AT_PUBLISH_SOURCE : PAnsiChar = AT_PUBLISH_SOURCE;
 AT_REG_IN_MU_NUM : PAnsiChar = AT_REG_IN_MU_NUM;
 AT_REG_IN_MU : PAnsiChar = AT_REG_IN_MU;
 AT_REG_NUM : PAnsiChar = AT_REG_NUM;
 AT_SOURCE : PAnsiChar = AT_SOURCE;
 AT_STATUS : PAnsiChar = AT_STATUS;
 AT_TERRITORY : PAnsiChar = AT_TERRITORY;
 AT_TYPE : PAnsiChar = AT_TYPE;
 AT_UC : PAnsiChar = AT_UC;
 AT_PHARM_INTERNATIONAL_NAME : PAnsiChar = AT_PHARM_INTERNATIONAL_NAME;
 AT_PHARM_TRADE_NAME : PAnsiChar = AT_PHARM_TRADE_NAME;
 AT_PHARM_CHAPTER : PAnsiChar = AT_PHARM_CHAPTER;
 AT_PHARM_COUNTRY : PAnsiChar = AT_PHARM_COUNTRY;
 AT_PHARM_FIRM : PAnsiChar = AT_PHARM_FIRM;
 AT_PHARM_REG_STATUS : PAnsiChar = AT_PHARM_REG_STATUS;
 AT_PHARM_MEDICINAL_FORM : PAnsiChar = AT_PHARM_MEDICINAL_FORM;
 AT_PHARM_ATC : PAnsiChar = AT_PHARM_ATC;
 AT_PHARM_MKB : PAnsiChar = AT_PHARM_MKB;
 AT_PHARM_GROUP : PAnsiChar = AT_PHARM_GROUP;
 AT_PHARM_EFFECT : PAnsiChar = AT_PHARM_EFFECT;
 AT_PHARM_NARCOTIC : PAnsiChar = AT_PHARM_NARCOTIC;
 AT_PHARM_UNRECIPE : PAnsiChar = AT_PHARM_UNRECIPE;
 AT_PHARM_IMPORTANT : PAnsiChar = AT_PHARM_IMPORTANT;
 AT_PHARM_COUNTRY_FOR_FILTER : PAnsiChar = AT_PHARM_COUNTRY_FOR_FILTER;
 AT_VARIANTS : PAnsiChar = AT_VARIANTS;
  { ������ ��������� ��� �������� ������ }
 AT_PREFIX_REVIEW : PAnsiChar = AT_PREFIX_REVIEW;
  { ������ ����� �������� ���������� � �� ��� }
 AT_PUBLISH_SOURCE_FINANCE : PAnsiChar = AT_PUBLISH_SOURCE_FINANCE;
  { ����� ������ �������� ������������� ��� ��� �� ������� � �������� }
 AT_PUBLISH_SOURCE_LEGAL : PAnsiChar = AT_PUBLISH_SOURCE_LEGAL;
  { ����� ������ �������� ������������� ��� ��� ��� ������ }
 AT_PUBLISH_SOURCE_HR : PAnsiChar = AT_PUBLISH_SOURCE_HR;
  { ����� ������ �������� ������������� ��� ��� ��� ��������� }
 AT_PUBLISH_SOURCE_BUDGET_ORGS : PAnsiChar = AT_PUBLISH_SOURCE_BUDGET_ORGS;
  { ����� ������ �������� ������������� ��� ��� ��� ��������� ����������� }
 AT_BASE_SEARCH_PANES : PAnsiChar = AT_BASE_SEARCH_PANES;
  { ������� �������� ������ }
 AT_CLASS_REVIEW : PAnsiChar = AT_CLASS_REVIEW;
 AT_SOURCE_REVIEW : PAnsiChar = AT_SOURCE_REVIEW;
 AT_PUBLISH_SOURCE_PHARM : PAnsiChar = AT_PUBLISH_SOURCE_PHARM;
 AT_IMPORTANT_DOCUMENTS : PAnsiChar = AT_IMPORTANT_DOCUMENTS;

type
 ICountryFilter = interface(IFilterForTree)
   ['{88574AB6-4C05-455B-8E61-ACC170D68E31}']
   function GetCountry: INodeBase; stdcall;
   procedure SetCountry(const aValue: INodeBase); stdcall;
   property country: INodeBase
     read GetCountry
     write SetCountry;
 end;//ICountryFilter

 ICutToLeafCountFilter = interface(IFilterForTree)
  {* ��������� � ������ ���������� �����, �� ������� ��������� }
   ['{080EAE7F-D346-4600-AA65-6CD21B8C7370}']
   function GetLeafCount: Cardinal; stdcall;
   procedure SetLeafCount(aValue: Cardinal); stdcall;
   property leaf_count: Cardinal
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
   property doc_id: Cardinal
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
   function GetContext: IString; stdcall;
   procedure SetContext(const aValue: IString); stdcall;
   procedure Clone(out aRet {: IContextFilter}); stdcall;
   procedure Filtrate(const aList: IListForFiltering; out aRet {: IFiltered}); stdcall;
   property place: TContextPlace
     read GetPlace
     write SetPlace;
   property order: TFindOrder
     read GetOrder
     write SetOrder;
   property area: TSearchArea
     read GetArea
     write SetArea;
   property context: IString
     read GetContext
     write SetContext;
 end;//IContextFilter

implementation

end.