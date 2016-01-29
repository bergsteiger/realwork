unit DynamicTreeUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicTreeUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicTree
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	, BaseTypesUnit
	, SearchDefinesUnit
	, DynamicTreeDefinesUnit
	//#UC START# *4423F94903C8_457450470167_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_457450470167_UNIT_FOR_Stream*
	;

type

IFilterForTree = interface;
{ - ��������������� �������� IFilterForTree. }

IFilterList = interface;
{ - ��������������� �������� IFilterList. }

INodeIndexPath = interface;
{ - ��������������� �������� INodeIndexPath. }

IFindPositionList = interface;
{ - ��������������� �������� IFindPositionList. }

ILayerIdList = interface;
{ - ��������������� �������� ILayerIdList. }

ISortFilter = interface;
{ - ��������������� �������� ISortFilter. }

ITrimFilter = interface;
{ - ��������������� �������� ITrimFilter. }

ILayerFilter = interface;
{ - ��������������� �������� ILayerFilter. }

IFindIterator = interface;
{ - ��������������� �������� IFindIterator. }

ISettingEntity = interface;
{ - ��������������� �������� ISettingEntity. }

INodesClipboard = interface;
{ - ��������������� �������� INodesClipboard. }

INodeBase = interface;
{ - ��������������� �������� INodeBase. }

INodeIterator = interface;
{ - ��������������� �������� INodeIterator. }

ICatalogBase = interface;
{ - ��������������� �������� ICatalogBase. }

ITrimLeafFilter = interface;
{ - ��������������� �������� ITrimLeafFilter. }

ICountryFilter = interface;
{ - ��������������� �������� ICountryFilter. }

ICutToLeafCountFilter = interface;
{ - ��������������� �������� ICutToLeafCountFilter. }

INodeIdList = interface;
{ - ��������������� �������� INodeIdList. }

IBlocksFilter = interface;
{ - ��������������� �������� IBlocksFilter. }

IInpharmFilter = interface;
{ - ��������������� �������� IInpharmFilter. }

IVariantsForDocFilter = interface;
{ - ��������������� �������� IVariantsForDocFilter. }

IFiltered = interface;
{ - ��������������� �������� IFiltered. }

IContextFilter = interface;
{ - ��������������� �������� IContextFilter. }


PContextPlace = ^TContextPlace;
TContextPlace = (
	CP_ANY
	, CP_BEGIN_OF_WORD
	, CP_BEGIN_OF_PHRASE
	, CP_WHOLE_WORD
);

PIndexInParent = ^TIndexInParent;
TIndexInParent = Longword;

// ������� ������
PFindOrder = ^TFindOrder;
TFindOrder = (
	FO_SEQUENCE
	, FO_ANY
);

// ������� ���������� ���������.
PFindPosition = ^TFindPosition;
TFindPosition = packed record
	rNode: INodeIndexPath; // ���� � ���� ������ ������� ���������.
	rBegin: Longint; // ������ �������.
	rEnd: Longint; // ����� �������. ���� -1 - �� �� �����.
end;

// ���������������� ��� ����
PNodeType = ^TNodeType;
TNodeType = Int64;

// ������������� ���� ������
PNodeId = ^TNodeId;
TNodeId = Longint;

// ������� ������
// SA_IN_ALL_TEXT - ������������ � ����������� ������, ���� �� ����� ������, ��������� �� ������
// ���� ��� ������ ���� ��������� ������ ����� ������ ������ ����� ����.
// SA_IN_ONE_SENTENCES - ������������ � ����������� ������ ���� � ����� ����, ��������� ��� �����
// ������� ������ ���������� ������ ����������� � ����� �������
PSearchArea = ^TSearchArea;
TSearchArea = (
	SA_ONE_LEVEL
	, SA_ALL_LEVEL
	, SA_IN_ALL_TEXT
	, SA_IN_ONE_SENTENCES
);

// ������� ������ � ������
PVisibleIndex = ^TVisibleIndex;
TVisibleIndex = Longint;

// ������������� ������
PLayerId = ^TLayerId;
TLayerId = Word;

PNotifierID = ^TNotifierID;
TNotifierID = Longword;

// ����� ������� ������ ��� ��� � evd
PEVDGeneratorStyle = ^TEVDGeneratorStyle;
TEVDGeneratorStyle = (
	GS_DEFAULT // �������� ������ ������� �������, ���������� �����
	, GS_FULL_TREE // �������� ������ ���������, ���������� �����
	, GS_TOPIC_AS_NAME // �������� ������ ������� �������, ������ ��� ���������� ������ �������
);

// ������������ ��� ������� �������� �������� �� ���� ������� �� �� ��������
ENoEntity = class (Exception);

// ������������ ���� get_visible_delta �� ����� ����� ����
ENotFound = class (Exception);

PPropertyID = ^TPropertyID;
TPropertyID = PAnsiChar;

// ����� ����� ��������� ����������, ����� ���� ��������
IFakeFacetForFactory = interface (IInterface) ['{6AFFD7FC-CA48-450D-8EB7-E7E47E04F9BF}']
	function DontUseMe: Pointer;

end;

// callback ��������� ��� ���������� ����������� ������ �� ���������� �� ����
INodeNotifier = interface (IInterface) ['{D368CD98-23ED-4EA2-B1A8-E72679D98593}']
	// ����������� �� ��������� ���-�� ������� ����� �� ���� � ��������� ��������. � ������ ����
	// ��������� ��� ������ ���� �� ���������������� � �� �� ������, ������ ������ ���� ����� ��� -1.
	// parent_path - ���� � ���� � ������� ��������� ��������� (���� delta < 0 - ��������, ���� delta
	// > 0 - �������)
	// left_child_index - ������ ������� � ����: ���� ��������, �� ������� � ��������
	// (������������) �� ������� delta ����������; ���� �������, �� ����� ����� �������� �� ���������
	// delta ���������.
	// left_child_index, ����� ������� "�����������" �������� IIP_BEFORE_LEFT_CHILD (-1) -
	// ���������� ������� "�� �������" - �������� ��� ������� � ������ �����.
	procedure ChangeChildrenCount (
		aNodeIndex: TVisibleIndex;
		aDelta: Longint;
		const aIndexPath: INodeIndexPath;
		aChildIndex: TIndexInParent
	); stdcall;

	// ����� �������� ��������� ������
	procedure Changed (); stdcall;

	// ������ �������� ��������� ������
	procedure Changing (); stdcall;

	// ���������� ���������� ������������� �������
	function GetId (): TNotifierID; stdcall;

	// ����������� � ������������� �����������. ������ ���������� ����� change_children_count (�������
	// ����� �����������) ��� �������������� ��� ��������� ������ �� ��������� � ���-��� �����.
	// parent_path - ���� � ���� � ������� ��������� ���������
	procedure Invalidate (
		const aIndexPath: INodeIndexPath
	); stdcall;

	// ������� ���������� ��� �� �������������
	function IsOneLevel (): Bytebool; stdcall;

	// ������� ���������� ��� �� � ������� �����
	function IsRootVisible (): Bytebool; stdcall;

	// ������������� ���-�� ����� = 0
	procedure ResetChildrenCount (); stdcall;
end;

IListForFiltering = interface (IInterface) ['{89EBBAAC-B4DA-4DAB-9FEE-FE7F4A1BD86A}']
	function GetCount (): Longword; stdcall;

	procedure Item (
		aIndex: Longword;
		out aRet {: IString}
	); stdcall;
end;

// ������� ���� � ������ � ������ ���� ����.
PNodePosition = ^TNodePosition;
TNodePosition = packed record
	rPos: Longint; // ������� ������ ���� node.
	rNode: INodeBase;
end;

// ����������� ��������� �������� ��������
IFilterForTree = interface (IInterface) ['{2EE1EBDC-4804-47C2-964A-89BABD67A457}']
	function DontUseMe: Pointer;

end;

IFilterList = interface(IInterface)
['{B0B31EED-B9B1-4C7F-9177-C090C9FB6E95}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: IFilterForTree); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IFilterForTree); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IFilterForTree): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: IFilterForTree); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IFilterList

INodeIndexPath = interface(IInterface)
['{E3DAF1B3-4170-4A80-9C3E-D372F46719CC}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    function  pm_GetItem(anIndex: Integer): TIndexInParent; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TIndexInParent); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TIndexInParent): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TIndexInParent); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
  // public properties
    property  Items[anIndex: Integer]: TIndexInParent
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - �������� ������. }
end;//INodeIndexPath

IFindPositionList = interface(IInterface)
['{DDC91DC6-F8F6-4682-AEB9-77B7D574E9A5}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: TFindPosition); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TFindPosition); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TFindPosition): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TFindPosition); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IFindPositionList

ILayerIdList = interface(IInterface)
['{65349303-26F4-4D82-A588-1C425E8040D0}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    function  pm_GetItem(anIndex: Integer): TLayerId; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TLayerId); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TLayerId): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TLayerId); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
  // public properties
    property  Items[anIndex: Integer]: TLayerId
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - �������� ������. }
end;//ILayerIdList

ISortFilter = interface (IFilterForTree) ['{D0268B80-08CD-419D-BDF5-D3DA7A12199D}']
	function GetOrder (): TSortOrder; stdcall;
	procedure SetOrder (aOrder: TSortOrder); stdcall;

	procedure GetSubFilter (out aRet {: ISortFilter}); stdcall;
	procedure SetSubFilter (const aSubFilter: ISortFilter); stdcall;

	function GetType (): TSortType; stdcall;
	procedure SetType (aType: TSortType); stdcall;
end;

ITrimFilter = interface (IFilterForTree) ['{31549898-CEF0-46C3-94D9-1D6FA71A2C65}']
	function GetIsTrimmed (): Bytebool; stdcall;
	procedure SetIsTrimmed (aIsTrimmed: Bytebool); stdcall;
end;

// ����� �������� ��� ������������ ����������� ������ (�����)
ILayerFilter = interface (IFilterForTree) ['{217D0932-BA42-439D-8CCC-77ABAB9F12D6}']
	function GetLayer (): TLayerId; stdcall;
	procedure SetLayer (aLayer: TLayerId); stdcall;
end;

// �������� ������.
IFindIterator = interface (IInterface) ['{7C8B08E1-3BA1-4122-9E2F-4FDCC7935360}']
	function DontUseMe: Pointer;
	// ���������� ��������� ����������
	function GetCount (): Longword; stdcall;

	procedure GetPosition (
		out aRet {: IFindPositionList}
	); stdcall;

	// ���������� true, ���� ������ ������� �� ���������� ��������
	function IsFirst (): Bytebool; stdcall;

	// ���������� true, ���� �� ��������� ����� �������� ������, �.�. position. ����� �������� ��
	// ������, �.�. ����� end ��� ������ ����
	function IsGood (): Bytebool; stdcall;

	// ����������� ��������� �� ��������� �������.
	procedure Next (); stdcall;

	// ����������� ��������� �� ���������� �������.
	procedure Prev (); stdcall;
end;

// ����������� ���������, ���������� �������� ����� "���������" ���� � ����������
ISettingEntity = interface (IInterface) ['{3790FA3D-D4C9-4A31-9864-F3D1CE9E97B1}']
	function DontUseMe: Pointer;
	// ��������������� "������" �� �������� �������� � ������ ������ � ������ ����� (�������, �������)
	// �������.
	procedure LoadFromSetting (
		const aId: TPropertyID;
		out aRet {: ISettingEntity}
	); stdcall;

	// ��������� "������" �� ������ ��������� � ����������, �������� �� � ���������� ��������� ������.
	// ��� ������ ������� ������� �� ����������� ������ ������������ ������� ���������.
	procedure SaveInSetting (
		const aId: TPropertyID
	); stdcall;
end;

// ��������� ��� ������������� ���
INodesClipboard = interface (IInterface) ['{B990C46B-9FF3-4C7C-8C61-2DD226FE644E}']
	function DontUseMe: Pointer;
	procedure AsEvd (
		aStyle: TEVDGeneratorStyle;
		out aRet {: IStream}
	); stdcall;

	function GetCount (): Longword; stdcall;
end;

// ������� ��������� ���� "�����" ��������
INodeBase = interface (ISettingEntity) ['{954590CB-D1B3-44B3-8492-650D28A0CD8F}']
	// ���������� add_last_childs �� ��� ����� ���� (���-���� ���������� ��������, �����
	// create_new_node ��� �������� �� ������, ���� ��� ���� �� ������ �� ����� ������� �����)
	procedure AddLastChild (
		const aNode: INodeBase
	); stdcall; // can raise EConstantModify

	// ��������� ���� �� ���������� � ����� ������ ����� - �� ����� ���� ���� ���� ���������� ��
	// ������� ������� ����� ����� �������, �� ����������� � ��������� �������
	procedure AddLastChilds (
		const aNodes: INodesClipboard
	); stdcall;

	procedure AddNotifier (
		const aNotifier: INodeNotifier
	); stdcall;

	// ���������� add_prev_siblings �� ��� ����� ����
	procedure AddPrevSibling (
		const aNode: INodeBase
	); stdcall; // can raise EConstantModify

	// ���������� add_last_childs, �� ���� ����������� ����� ��������� ��� ������, ��������������
	// ����������� ����� ������ ������� ����
	procedure AddPrevSiblings (
		const aNodes: INodesClipboard
	); stdcall; // can raise EConstantModify

	// ���������������� �������� ����
	procedure GetCaption (out aRet {: IString}); stdcall;

	function GetChildCount (): Longint; stdcall;

	// ��������� ����������, � ���� ��� ������ ��� "�������" �������� ���������� - ��������� ���
	// ��������� ��������� �� ���� (���������� ������ �� ������)
	procedure CommitChangeTransaction (); stdcall;

	// �������� ���� �� ��������� ����� � ���������� �� � ���� ���������� ��� ����������� ������� �
	// ����� ������ ������.�������� ��������� � �������� �� ����!!!
	procedure CopyNodes (
		aMask: TFlagMask;
		out aRet {: INodesClipboard}
	); stdcall;

	// ����������� ������ ������ create_view. (������� ��� ������ ��������� �� ����)
	procedure CreateViewEx (
		const aFilter: IFilterList;
		aSharedFlags: TFlagMask;
		const aSyncNode: INodeBase;
		out aSyncIndex: TVisibleIndex;
		aLevels: Longword;
		aUnfiltered: Bytebool;
		aAutoOpen: Bytebool;
		aTruncateThisView: Bytebool;
		out aRet {: INodeBase}
	); stdcall;

	// ������� ������� ����
	procedure DeleteNode (); stdcall;

	// ������� ��� ���� �� ��������� �����. �������� ��������� � �������� �� ����!!!
	procedure DeleteNodes (
		aMask: TFlagMask
	); stdcall; // can raise EConstantModify

	procedure GetEntity (out aRet {: IEntityBase}); stdcall;
	procedure SetEntity (const aEntity: IEntityBase); stdcall;

	// ������������� � ������� ���� ��������� ���� ��� � ������
	procedure ExpandAll (
		aExpand: Bytebool
	); stdcall;

	// ����� � ������ �� �������, ��������� � �������. � ������ ������ ���������� �������� �������
	// ���������, ����� ������ �������� (is_good!=true).
	procedure Find (
		const aFilter: IFilterList;
		const aFindFrom: TNodePosition;
		out aRet {: IFindIterator}
	); stdcall;

	// ���� � ������� ������ ���� ������ ����������
	procedure FindNode (
		const aNodeToFind: INodeBase;
		out aRet {: INodeBase}
	); stdcall;

	// ��������� ���������� ���� ����. ������ ������ � ���� ��� ���� node_to_find
	procedure FindNodePath (
		const aNodeToFind: INodeBase;
		out aRet {: INodeIndexPath}
	); stdcall;

	procedure GetFirstChild (out aRet {: INodeBase}); stdcall;

	// ���������� ���. ������ ��� ����
	function GetAbsIndex (): TVisibleIndex; stdcall; // can raise ECanNotFindData

	procedure GetAvailableLayers (
		out aRet {: ILayerIdList}
	); stdcall;

	// ���������� ����-������ (�.�. "�����" �������) �� �������
	procedure GetBySibblingIndex (
		aInd: TVisibleIndex;
		out aRet {: INodeBase}
	); stdcall;

	// ���������� ���� �� �������� ������� ������������ �������
	procedure GetByVisibleIndex (
		aInd: TVisibleIndex;
		out aRet {: INodeBase}
	); stdcall;

	// ���������� ���� � ���� �� � ���. �������
	procedure GetChildPathByAbsIndex (
		aIndex: TVisibleIndex;
		out aRet {: INodeIndexPath}
	); stdcall; // can raise ECanNotFindData

	procedure GetFirstFit (
		const aFilter: IFilterList;
		out aRet {: INodeIndexPath}
	); stdcall;

	function GetFirstLevelChildrenFlagCount (
		aFlag: TFlagMask
	): Longword; stdcall;

	// ���������� ���-�� ��������� ������ � ������� ���������
	function GetFlagCount (
		aFlag: TFlagMask
	): Longword; stdcall;

	procedure GetFrozenNode (
		out aRet {: INodeBase}
	); stdcall;

	// ���������� ���������� ����� ���� ������������ �������� (������� � 1)
	function GetIndexFromParent (): TVisibleIndex; stdcall;

	// ��������� � CatalogBase
	procedure GetNodeByPath (
		const aPath: INodeIndexPath;
		out aRet {: INodeBase}
	); stdcall; // can raise ENotFound

	// ��������� �������������� ����. ������ ���������� �������, �� ��� ��������� value->id (), �.�.
	// �� ��������.
	function GetNodeId (): TNodeId; stdcall;

	procedure GetUnfilteredNode (
		out aRet {: INodeBase}
	); stdcall;

	// ���������� ������� ������� �������� ���� ��� (����� ������������� ���������� ����������� ������)
	function GetVisibleDelta (
		const aNode: INodeBase
	): TVisibleIndex; stdcall; // can raise ENotFound

	function GetVisibleDeltaByEntity (
		const aEntity: IEntityBase
	): TVisibleIndex; stdcall; // can raise ENotFound

	// �������� ���� �� ����
	function HasChildren (): Bytebool; stdcall;

	// ������� ������� �� � ����� ��������� ����
	function HasChildrenFlag (
		aFlag: TFlagMask
	): Bytebool; stdcall;

	// ������� ���� ��� ���� ��������� ��������������� �����
	function HasFilteredChildren (): Bytebool; stdcall;

	// ������� ������� �� ��������� ����
	function HasFlag (
		aFlag: TFlagMask
	): Bytebool; stdcall;

	// ������� ������� �� � ��������� ��������� ����
	function HasParentFlag (
		aFlag: TFlagMask
	): Bytebool; stdcall;

	// ���������� true, ���� ���������� ���� ��������� ���� ���
	function GetIsExpanded (): Bytebool; stdcall;

	// ������� ������ �� ��� �������
	function IsFirst (): Bytebool; stdcall;

	// ���������� true ���� ���������� ���� (it) ���� �������
	function IsItHigher (
		const aIt: INodeBase
	): Bytebool; stdcall;

	// ������� ��������� �� ��� �������
	function IsLast (): Bytebool; stdcall;

	function IsRelevanceSearchSupported (): Bytebool; stdcall;

	// ��������� �� ��������� ��� ����
	function IsSameNode (
		const aNode: INodeBase
	): Bytebool; stdcall;

	procedure IterateAllNodes (
		aWithFlag: TFlagMask;
		out aRet {: INodeIterator}
	); stdcall;

	// ���������� �������� �������� �� ����� � ��������� ������
	procedure IterateNodes (
		aWithFlag: TFlagMask;
		out aRet {: INodeIterator}
	); stdcall;

	// ������� ���� � ������
	function GetLevel (): Longint; stdcall;

	procedure MakeVisible (); stdcall;

	procedure GetNext (out aRet {: INodeBase}); stdcall;

	procedure GetParent (out aRet {: INodeBase}); stdcall;

	procedure GetPrev (out aRet {: INodeBase}); stdcall;

	procedure RemoveNotifier (
		const aNotifier: INodeNotifier
	); stdcall;

	// ���������� �������� ���������� (������ �� ����� ����������),  ���������� ��� ���������
	// (������������ � ������� ��� ����������� �������)
	procedure RollbackChangeTransaction (); stdcall;

	// ������������� � ����� ��������� (����� ����� ���� �� ������� ���� ������� ��������) ���������
	// ���� (������ �������� ������ �� ����, � ������ ������ ������ ���������, ����� ��������
	// ���������)
	procedure SetAllFlag (
		aFlag: TFlagMask;
		aValue: Bytebool
	); stdcall;

	procedure SetAllFlagExceptFirstChildrenOfRootChildren (
		aFlag: TFlagMask;
		aValue: Bytebool
	); stdcall;

	// ������� ��������� ����
	procedure SetFlag (
		aFlag: TFlagMask;
		aValue: Bytebool
	); stdcall;

	// �������� ������������� ����. ������ ������ �� ������, �� ��� ��������� �������� value->id ().
	procedure SetNodeId (
		aId: TNodeId
	); stdcall;

	// ������� ��������� ���� �� ����������
	procedure SetRangeFlag (
		aOffsetFrom: TVisibleIndex;
		aOffsetTo: TVisibleIndex;
		aFlag: TFlagMask;
		aValue: Bytebool;
		aCleanOther: Bytebool
	); stdcall;

	procedure SetRangeFlagExceptFirstChildrenOfRootChildren (
		aOffsetFrom: TVisibleIndex;
		aOffsetTo: TVisibleIndex;
		aFlag: TFlagMask;
		aValue: Bytebool;
		aCleanOther: Bytebool
	); stdcall;

	// ��������� �� ������ ���������� ��������� ������ ����. ���������� ����� ���� ����������
	procedure StartChangeTransaction (); stdcall;

	// ���������������� ��� ����. ����� ���������� ��� ��������� ��������, ��� ������ ��������������
	// ��� ������������� �����������
	function GetType (): TNodeType; stdcall;
	procedure SetType (aType: TNodeType); stdcall;
end;

// ��������� ��� ��������� ��������� ������ ��������� ������.
// ������ �������������� ������������� ��� ���������� �������� � ������������ ������� ���������
// ������ (��������, �� ������� ���������� ���������).
INodeIterator = interface (IInterface) ['{1F4887B9-4FA9-4B90-BB5C-0D3EAB6D0792}']
	function DontUseMe: Pointer;
	procedure GetNext (out aRet {: INodeBase}); stdcall;
end;

// �������� �������� ���������� �� ������ NodeBase � �������������� �������� ���������
// (EntityBase). �������� ���������� BaseTreeSupport::BaseCatalog
ICatalogBase = interface (IInterface) ['{59A590F8-FB2D-49E6-A954-1B0CC9CCAD04}']
	function DontUseMe: Pointer;
	procedure Clone (
		out aRet {: ICatalogBase}
	); stdcall;

	procedure Create (
		const aNodes: INodesClipboard;
		out aRet {: ICatalogBase}
	); stdcall;

	procedure GetNodeByPath (
		const aPath: INodeIndexPath;
		out aRet {: INodeBase}
	); stdcall; // can raise ENotFound

	procedure IntersectTree (
		const aTree: ICatalogBase
	); stdcall;

	procedure MergeTree (
		const aTree: ICatalogBase
	); stdcall;

	procedure MinusTree (
		const aTree: ICatalogBase
	); stdcall;

	procedure GetName (out aRet {: IString}); stdcall;
	procedure SetName (const aName: IString); stdcall;

	procedure GetRoot (out aRet {: INodeBase}); stdcall;
end;

ITrimLeafFilter = interface (IFilterForTree) ['{7AC01117-FE4F-4D1C-AA39-44B55E57D5F7}']

end;

ICountryFilter = interface (IFilterForTree) ['{88574AB6-4C05-455B-8E61-ACC170D68E31}']
	procedure GetCountry (out aRet {: INodeBase}); stdcall;
	procedure SetCountry (const aCountry: INodeBase); stdcall;
end;

// ��������� � ������ ���������� �����, �� ������� ���������
ICutToLeafCountFilter = interface (IFilterForTree) ['{080EAE7F-D346-4600-AA65-6CD21B8C7370}']
	// �������� ����� ������� ��� �������
	function GetLeafCount (): Longword; stdcall;
	procedure SetLeafCount (aLeafCount: Longword); stdcall;
end;

INodeIdList = interface(IInterface)
['{645EE87E-58A6-4EFD-9C27-FF98DEF4AC9E}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    function  pm_GetItem(anIndex: Integer): TNodeId; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TNodeId); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TNodeId): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TNodeId); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
  // public properties
    property  Items[anIndex: Integer]: TNodeId
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - �������� ������. }
end;//INodeIdList

// ������ ��������� ������ �� �����, ������� �������� ����������� ������������
IBlocksFilter = interface (IFilterForTree) ['{30D760A8-3BA6-47C7-A2A7-08F504585CB8}']

end;

// �� ���������� � ������ ������ ����� ��� ������
IInpharmFilter = interface (IFilterForTree) ['{9F35901C-BCED-426C-9B29-45F0EFCA688C}']

end;

// �������� ��������� ��� ��������� ���������
IVariantsForDocFilter = interface (IFilterForTree) ['{7E6C4CC8-5E83-4074-BC63-93286053A532}']

end;

IFiltered = interface(IInterface)
['{B8FD4E84-685B-4A65-BA63-C4E83B8A50EE}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    function  pm_GetItem(anIndex: Integer): Longword; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: Longword); stdcall;
      {-}
  // public methods
    function  Add(const anItem: Longword): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: Longword); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
  // public properties
    property  Items[anIndex: Integer]: Longword
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - �������� ������. }
end;//IFiltered

// ����� ����������� ��������
IContextFilter = interface (IFilterForTree) ['{FCB4593F-FD35-46E5-87BB-7112D61FEC5A}']
	function GetArea (): TSearchArea; stdcall;
	procedure SetArea (aArea: TSearchArea); stdcall;

	procedure Clone (
		out aRet {: IContextFilter}
	); stdcall;

	procedure GetContext (out aRet {: IString}); stdcall;
	procedure SetContext (const aContext: IString); stdcall;

	procedure Filtrate (
		const aList: IListForFiltering;
		out aRet {: IFiltered}
	); stdcall;

	function GetOrder (): TFindOrder; stdcall;
	procedure SetOrder (aOrder: TFindOrder); stdcall;

	function GetPlace (): TContextPlace; stdcall;
	procedure SetPlace (aPlace: TContextPlace); stdcall;
end;

const

 { ��������� ��� ������ }
	FM_SHARED_NONE = TFlagMask(0);
	FM_OPEN = TFlagMask(2);
	FM_SELECTION = TFlagMask(1);
	FM_FIRST_USER_FLAG = TFlagMask(4);
	FM_USER_FLAG_MASK = TFlagMask(65532);
	FM_SHARED_ALL = TFlagMask(65535);
	IIP_BEFORE_LEFT_CHILD = TIndexInParent(4294967295);
	VI_ALL_CHILDREN = TVisibleIndex(-1);
 { ����������� �� ��������� ���� �����. }

 { ��������� ����� ���� }
	NT_UNKNOWN = TNodeType(0);

 { �������������� �������� }
	AT_ANNO_INTEREST = 'AT_ANNO_INTEREST';
	AT_ANNO_KIND = 'AT_ANNO_KIND';
	AT_ANNO_ORG = 'AT_ANNO_ORG';
	AT_ANNO_TAX = 'AT_ANNO_TAX';
	AT_ANNO_USER = 'AT_ANNO_USER';
	AT_BASES = 'AT_BASES';
	AT_CLASS = 'AT_CLASS';
	AT_EDITION = 'AT_EDITION';
	AT_KW = 'AT_KW';
	AT_NORM = 'AT_NORM';
	AT_PREFIX = 'AT_PREFIX';
	AT_PUBLISH_SOURCE = 'AT_PUBLISH_SOURCE';
	AT_REG_IN_MU_NUM = 'AT_REG_IN_MU_NUM';
	AT_REG_IN_MU = 'AT_REG_IN_MU';
	AT_REG_NUM = 'AT_REG_NUM';
	AT_SOURCE = 'AT_SOURCE';
	AT_STATUS = 'AT_STATUS';
	AT_TERRITORY = 'AT_TERRITORY';
	AT_TYPE = 'AT_TYPE';
	AT_UC = 'AT_UC';
	AT_PHARM_INTERNATIONAL_NAME = 'AT_PHARM_INTERNATIONAL_NAME';
	AT_PHARM_TRADE_NAME = 'AT_PHARM_TRADE_NAME';
	AT_PHARM_CHAPTER = 'AT_PHARM_CHAPTER';
	AT_PHARM_COUNTRY = 'AT_PHARM_COUNTRY';
	AT_PHARM_FIRM = 'AT_PHARM_FIRM';
	AT_PHARM_REG_STATUS = 'AT_PHARM_REG_STATUS';
	AT_PHARM_MEDICINAL_FORM = 'AT_PHARM_MEDICINAL_FORM';
	AT_PHARM_ATC = 'AT_PHARM_ATC';
	AT_PHARM_MKB = 'AT_PHARM_MKB';
	AT_PHARM_GROUP = 'AT_PHARM_GROUP';
	AT_PHARM_EFFECT = 'AT_PHARM_EFFECT';
	AT_PHARM_NARCOTIC = 'AT_PHARM_NARCOTIC';
	AT_PHARM_UNRECIPE = 'AT_PHARM_UNRECIPE';
	AT_PHARM_IMPORTANT = 'AT_PHARM_IMPORTANT';
	AT_PHARM_COUNTRY_FOR_FILTER = 'AT_PHARM_COUNTRY_FOR_FILTER';
	AT_VARIANTS = 'AT_VARIANTS';
 { ������ ��������� ��� �������� ������ }
	AT_PREFIX_REVIEW = 'AT_PREFIX_REVIEW';
 { ������ ����� �������� ���������� � �� ��� }
	AT_PUBLISH_SOURCE_FINANCE = 'AT_PUBLISH_SOURCE_FINANCE';
 { ����� ������ �������� ������������� ��� ��� �� ������� � �������� }
	AT_PUBLISH_SOURCE_LEGAL = 'AT_PUBLISH_SOURCE_LEGAL';
 { ����� ������ �������� ������������� ��� ��� ��� ������ }
	AT_PUBLISH_SOURCE_HR = 'AT_PUBLISH_SOURCE_HR';
 { ����� ������ �������� ������������� ��� ��� ��� ��������� }
	AT_PUBLISH_SOURCE_BUDGET_ORGS = 'AT_PUBLISH_SOURCE_BUDGET_ORGS';
 { ����� ������ �������� ������������� ��� ��� ��� ��������� ����������� }
	AT_BASE_SEARCH_PANES = 'AT_BASE_SEARCH_PANES';
 { ������� �������� ������ }
	AT_CLASS_REVIEW = 'AT_CLASS_REVIEW';
	AT_SOURCE_REVIEW = 'AT_SOURCE_REVIEW';
	AT_PUBLISH_SOURCE_PHARM = 'AT_PUBLISH_SOURCE_PHARM';
	AT_IMPORTANT_DOCUMENTS = 'AT_IMPORTANT_DOCUMENTS';

implementation
end.