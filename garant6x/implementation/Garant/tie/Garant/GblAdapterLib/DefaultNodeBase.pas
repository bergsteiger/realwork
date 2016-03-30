unit DefaultNodeBase;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DefaultNodeBase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "DefaultNodeBase" MUID: (45F7ECA8034B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , FlagNodeBase
 , DynamicTreeDefinesUnit
 , reeBase
 , DynamicTreeUnit
 , FlagNodeStub
 , BaseTypesUnit
 //#UC START# *45F7ECA8034Bintf_uses*
 //#UC END# *45F7ECA8034Bintf_uses*
;

type
 //#UC START# *45F7ECA8034Bci*
 //#UC END# *45F7ECA8034Bci*
 //#UC START# *45F7ECA8034Bcit*
 //#UC END# *45F7ECA8034Bcit*
 DefaultNodeBase = {abstract} class(FlagNodeBase)
  private
   class procedure IndexPathToNodePath(const path: INodeIndexPath;
    var node_path;
    l: Integer); virtual; stdcall;
   class procedure PrintPath(node_to_find: DefaultNodeBase;
    const path: INodeIndexPath); virtual; stdcall;
   class procedure ServerLayersIdListToAdapter(const srv;
    var adap: ILayerIdList); virtual; stdcall;
  protected
   function GetChildrenFlags: TFlagMask; virtual; stdcall;
   procedure SetOwnerTree(aValue: TreeBase); overload; virtual; stdcall;
   class function GetRealInterface(const node_): DefaultNodeBase; virtual; stdcall;
   constructor Make; reintroduce; overload; virtual; stdcall;
   procedure InvalidateChildrenCount; virtual; stdcall;
   procedure CreateViewEx(const filter: IFilterList;
    shared_flags: TFlagMask;
    sync_node: DefaultNodeBase;
    out sync_index: TVisibleIndex;
    levels: Cardinal;
    unfiltered: Boolean;
    auto_open: Boolean;
    truncate_this_view: Boolean); virtual; stdcall;
   function SetRangeFlag(from: TVisibleIndex;
    to: TVisibleIndex;
    flag: TFlagMask;
    value: Boolean;
    clean_other: Boolean;
    with_notify: Boolean): ByteBool; virtual; stdcall;
   function HasParentFlag(flag: TFlagMask): ByteBool; virtual; stdcall;
   function HasChildrenFlag(flag: TFlagMask): ByteBool; virtual; stdcall;
   function GetFlagCount(flag: TFlagMask): Cardinal; virtual; stdcall;
   function GetFirstLevelChildrenFlagCount(flag: TFlagMask): Cardinal; virtual; stdcall;
   procedure SetChildrenFlag(flag: TFlagMask;
    value: Boolean); virtual; stdcall;
   function FindNodeByInterface(const node_to_find: INodeBase): DefaultNodeBase; virtual; stdcall;
   function FindNode(const node_to_find): DefaultNodeBase; virtual; stdcall;
   function FindNodePath(var node_to_find: INodeBase): INodeIndexPath; virtual; stdcall;
   function GetVisibleDelta(var node: DefaultNodeBase): TVisibleIndex; overload; virtual; stdcall;
   function GetVisibleDelta(const node_path): TVisibleIndex; overload; virtual; stdcall;
   function GetVisibleDelta(const entity: IEntityBase): TVisibleIndex; overload; virtual; stdcall;
   function GetIndexFromParent: TVisibleIndex; virtual; stdcall;
    {* TODO: упростить, выкинув этот метод
ходить только к StaticNode-е }
   function GetAbsIndex: TVisibleIndex; virtual; stdcall; { can raise CanNotFindData }
   function GetChildPathByAbsIndex(index: TVisibleIndex): INodeIndexPath; virtual; stdcall; { can raise CanNotFindData }
   procedure AddNotifier(var notifier: INodeNotifier); virtual; stdcall;
   procedure RemoveNotifier(var notifier: INodeNotifier); virtual; stdcall;
   function FindStubForIndex(out index: Integer): FlagNodeStub; virtual; stdcall;
   procedure GetAvailableLayers(var layers: ILayerIdList); virtual; stdcall;
   function GetFirstFit(const filter: IFilterList): INodeIndexPath; virtual; stdcall;
   function Find(const filter: IFilterList;
    const find_from: TNodePosition): IFindIterator; virtual; stdcall;
   function IsRelevanceSearchSupported: ByteBool; virtual; stdcall;
   function GetNodeByPath(const path: INodeIndexPath): INodeBase; virtual; stdcall;
    {* Дублирует с CatalogBase }
   procedure NodePathToIndexPath(const path); virtual; stdcall;
   procedure Entity; virtual; stdcall; { can raise NoEntity }
   function ApplyResetDelta(var delta): ByteBool; virtual; stdcall;
   function ApplyChangeDelta(var delta): ByteBool; virtual; abstract; stdcall;
   function ApplyInsertDelta(var delta): ByteBool; virtual; stdcall;
   function ApplyDeleteDelta(var delta): ByteBool; virtual; stdcall;
   procedure RemoveMeAndSiblings(out count: Cardinal); virtual; stdcall;
   procedure Clean; virtual; stdcall;
   function IsAllExpanded: ByteBool; virtual; stdcall;
   procedure ExpandAllNodes(expand: Boolean); virtual; stdcall;
  public
   class procedure SrvPathToAdapter(const index_path;
    var adap_path: INodeIndexPath); virtual; stdcall;
   class procedure AdapterPathToSrv(const adapter_index_path: INodeIndexPath); virtual; stdcall;
   constructor Make(var owner_tree: TreeBase); reintroduce; overload; virtual; stdcall;
   procedure GetServerPointer; virtual; abstract; stdcall;
   function FindNodeByPath(const node_path): DefaultNodeBase; overload; virtual; stdcall;
   function FindNodeByPath(const node_index_path): DefaultNodeBase; overload; virtual; stdcall;
   function FindLoadedNodeByPath(const node_index_path): DefaultNodeBase; virtual; stdcall;
   function GetTreeName: PAnsiChar; virtual; stdcall;
   function GetSettingsRootId: AnsiString; virtual; stdcall;
   function NodeName: PAnsiChar; virtual; abstract; stdcall;
   procedure ServerDataVersion; virtual; stdcall;
   procedure GetServerPath(const path_type = PT_POINTER); virtual; stdcall;
   function GetTreeOwner: TreeBase; virtual; stdcall;
   function GetVisibleIndex: TVisibleIndex; virtual; stdcall;
   function OwnerTree: TreeBase; overload; virtual; stdcall;
   function OwnerTree: TreeBase; overload; virtual; stdcall;
   function SetRangeFlagExceptFirstChildrenOfRootChildren(from: TVisibleIndex;
    to: TVisibleIndex;
    flag: TFlagMask;
    value: Boolean;
    clean_other: Boolean;
    with_notify: Boolean): ByteBool; virtual; stdcall;
   procedure SetAllFlag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean); override;
   function InternalSetAllFlag(flag: TFlagMask;
    value: Boolean;
    children_only: Boolean): size; override;
    {* возвращает количество взведённых (изменённых?) флагов. }
   procedure SetAllFlagExceptFirstChildrenOfRootChildren(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean); override;
   function InternalSetAllFlagExceptFirstChildrenOfRootChildren(flag: TFlagMask;
    value: Boolean;
    children_only: Boolean): size; override;
   function SetFlag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean): ByteBool; override;
  protected
   property ChildrenFlags: TFlagMask
    read GetChildrenFlags;
   property OwnerTree: TreeBase
    write SetOwnerTree;
 //#UC START# *45F7ECA8034Bpubl*
 //#UC END# *45F7ECA8034Bpubl*
 end;//DefaultNodeBase

implementation

uses
 l3ImplUses
 , RealNodeBase
 , ServerAdapterConverters
 , ViewBase
 //#UC START# *45F7ECA8034Bimpl_uses*
 //#UC END# *45F7ECA8034Bimpl_uses*
;

function DefaultNodeBase.GetChildrenFlags: TFlagMask;
//#UC START# *45F95D2600AB_45F7ECA8034Bget_var*
//#UC END# *45F95D2600AB_45F7ECA8034Bget_var*
begin
//#UC START# *45F95D2600AB_45F7ECA8034Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95D2600AB_45F7ECA8034Bget_impl*
end;//DefaultNodeBase.GetChildrenFlags

procedure DefaultNodeBase.SetOwnerTree(aValue: TreeBase);
//#UC START# *45F9675A000F_45F7ECA8034Bset_var*
//#UC END# *45F9675A000F_45F7ECA8034Bset_var*
begin
//#UC START# *45F9675A000F_45F7ECA8034Bset_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9675A000F_45F7ECA8034Bset_impl*
end;//DefaultNodeBase.SetOwnerTree

class procedure DefaultNodeBase.SrvPathToAdapter(const index_path;
 var adap_path: INodeIndexPath);
//#UC START# *45F945FC02DE_45F7ECA8034B_var*
//#UC END# *45F945FC02DE_45F7ECA8034B_var*
begin
//#UC START# *45F945FC02DE_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F945FC02DE_45F7ECA8034B_impl*
end;//DefaultNodeBase.SrvPathToAdapter

class procedure DefaultNodeBase.AdapterPathToSrv(const adapter_index_path: INodeIndexPath);
//#UC START# *45F9466C003E_45F7ECA8034B_var*
//#UC END# *45F9466C003E_45F7ECA8034B_var*
begin
//#UC START# *45F9466C003E_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9466C003E_45F7ECA8034B_impl*
end;//DefaultNodeBase.AdapterPathToSrv

class procedure DefaultNodeBase.IndexPathToNodePath(const path: INodeIndexPath;
 var node_path;
 l: Integer);
//#UC START# *45FA6B180148_45F7ECA8034B_var*
//#UC END# *45FA6B180148_45F7ECA8034B_var*
begin
//#UC START# *45FA6B180148_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FA6B180148_45F7ECA8034B_impl*
end;//DefaultNodeBase.IndexPathToNodePath

class procedure DefaultNodeBase.PrintPath(node_to_find: DefaultNodeBase;
 const path: INodeIndexPath);
//#UC START# *45FA6BAB0109_45F7ECA8034B_var*
//#UC END# *45FA6BAB0109_45F7ECA8034B_var*
begin
//#UC START# *45FA6BAB0109_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FA6BAB0109_45F7ECA8034B_impl*
end;//DefaultNodeBase.PrintPath

class procedure DefaultNodeBase.ServerLayersIdListToAdapter(const srv;
 var adap: ILayerIdList);
//#UC START# *45FA84E40213_45F7ECA8034B_var*
//#UC END# *45FA84E40213_45F7ECA8034B_var*
begin
//#UC START# *45FA84E40213_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FA84E40213_45F7ECA8034B_impl*
end;//DefaultNodeBase.ServerLayersIdListToAdapter

class function DefaultNodeBase.GetRealInterface(const node_): DefaultNodeBase;
//#UC START# *45F94AF8031C_45F7ECA8034B_var*
//#UC END# *45F94AF8031C_45F7ECA8034B_var*
begin
//#UC START# *45F94AF8031C_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94AF8031C_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetRealInterface

constructor DefaultNodeBase.Make;
//#UC START# *45F94B320109_45F7ECA8034B_var*
//#UC END# *45F94B320109_45F7ECA8034B_var*
begin
//#UC START# *45F94B320109_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94B320109_45F7ECA8034B_impl*
end;//DefaultNodeBase.Make

constructor DefaultNodeBase.Make(var owner_tree: TreeBase);
//#UC START# *45F94B5D0399_45F7ECA8034B_var*
//#UC END# *45F94B5D0399_45F7ECA8034B_var*
begin
//#UC START# *45F94B5D0399_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94B5D0399_45F7ECA8034B_impl*
end;//DefaultNodeBase.Make

function DefaultNodeBase.FindNodeByPath(const node_path): DefaultNodeBase;
//#UC START# *45F94BE501E4_45F7ECA8034B_var*
//#UC END# *45F94BE501E4_45F7ECA8034B_var*
begin
//#UC START# *45F94BE501E4_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94BE501E4_45F7ECA8034B_impl*
end;//DefaultNodeBase.FindNodeByPath

function DefaultNodeBase.FindNodeByPath(const node_index_path): DefaultNodeBase;
//#UC START# *45F94C8E0109_45F7ECA8034B_var*
//#UC END# *45F94C8E0109_45F7ECA8034B_var*
begin
//#UC START# *45F94C8E0109_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94C8E0109_45F7ECA8034B_impl*
end;//DefaultNodeBase.FindNodeByPath

function DefaultNodeBase.FindLoadedNodeByPath(const node_index_path): DefaultNodeBase;
//#UC START# *45F94CBE030D_45F7ECA8034B_var*
//#UC END# *45F94CBE030D_45F7ECA8034B_var*
begin
//#UC START# *45F94CBE030D_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94CBE030D_45F7ECA8034B_impl*
end;//DefaultNodeBase.FindLoadedNodeByPath

function DefaultNodeBase.GetTreeName: PAnsiChar;
//#UC START# *45F94D1E004E_45F7ECA8034B_var*
//#UC END# *45F94D1E004E_45F7ECA8034B_var*
begin
//#UC START# *45F94D1E004E_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94D1E004E_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetTreeName

function DefaultNodeBase.GetSettingsRootId: AnsiString;
//#UC START# *45F94D3B0280_45F7ECA8034B_var*
//#UC END# *45F94D3B0280_45F7ECA8034B_var*
begin
//#UC START# *45F94D3B0280_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94D3B0280_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetSettingsRootId

procedure DefaultNodeBase.ServerDataVersion;
//#UC START# *45F94D760203_45F7ECA8034B_var*
//#UC END# *45F94D760203_45F7ECA8034B_var*
begin
//#UC START# *45F94D760203_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94D760203_45F7ECA8034B_impl*
end;//DefaultNodeBase.ServerDataVersion

procedure DefaultNodeBase.GetServerPath(const path_type = PT_POINTER);
//#UC START# *45F94DB201C5_45F7ECA8034B_var*
//#UC END# *45F94DB201C5_45F7ECA8034B_var*
begin
//#UC START# *45F94DB201C5_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94DB201C5_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetServerPath

function DefaultNodeBase.GetTreeOwner: TreeBase;
//#UC START# *45F94E24035B_45F7ECA8034B_var*
//#UC END# *45F94E24035B_45F7ECA8034B_var*
begin
//#UC START# *45F94E24035B_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94E24035B_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetTreeOwner

function DefaultNodeBase.GetVisibleIndex: TVisibleIndex;
//#UC START# *45F94E390000_45F7ECA8034B_var*
//#UC END# *45F94E390000_45F7ECA8034B_var*
begin
//#UC START# *45F94E390000_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94E390000_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetVisibleIndex

procedure DefaultNodeBase.InvalidateChildrenCount;
//#UC START# *45F94E8A008C_45F7ECA8034B_var*
//#UC END# *45F94E8A008C_45F7ECA8034B_var*
begin
//#UC START# *45F94E8A008C_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94E8A008C_45F7ECA8034B_impl*
end;//DefaultNodeBase.InvalidateChildrenCount

procedure DefaultNodeBase.CreateViewEx(const filter: IFilterList;
 shared_flags: TFlagMask;
 sync_node: DefaultNodeBase;
 out sync_index: TVisibleIndex;
 levels: Cardinal;
 unfiltered: Boolean;
 auto_open: Boolean;
 truncate_this_view: Boolean);
//#UC START# *45F94E980186_45F7ECA8034B_var*
//#UC END# *45F94E980186_45F7ECA8034B_var*
begin
//#UC START# *45F94E980186_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94E980186_45F7ECA8034B_impl*
end;//DefaultNodeBase.CreateViewEx

function DefaultNodeBase.SetRangeFlag(from: TVisibleIndex;
 to: TVisibleIndex;
 flag: TFlagMask;
 value: Boolean;
 clean_other: Boolean;
 with_notify: Boolean): ByteBool;
//#UC START# *45F94FF401C5_45F7ECA8034B_var*
//#UC END# *45F94FF401C5_45F7ECA8034B_var*
begin
//#UC START# *45F94FF401C5_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94FF401C5_45F7ECA8034B_impl*
end;//DefaultNodeBase.SetRangeFlag

function DefaultNodeBase.HasParentFlag(flag: TFlagMask): ByteBool;
//#UC START# *45F951DC0242_45F7ECA8034B_var*
//#UC END# *45F951DC0242_45F7ECA8034B_var*
begin
//#UC START# *45F951DC0242_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F951DC0242_45F7ECA8034B_impl*
end;//DefaultNodeBase.HasParentFlag

function DefaultNodeBase.HasChildrenFlag(flag: TFlagMask): ByteBool;
//#UC START# *45FA5936035B_45F7ECA8034B_var*
//#UC END# *45FA5936035B_45F7ECA8034B_var*
begin
//#UC START# *45FA5936035B_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FA5936035B_45F7ECA8034B_impl*
end;//DefaultNodeBase.HasChildrenFlag

function DefaultNodeBase.GetFlagCount(flag: TFlagMask): Cardinal;
//#UC START# *45F9522101A5_45F7ECA8034B_var*
//#UC END# *45F9522101A5_45F7ECA8034B_var*
begin
//#UC START# *45F9522101A5_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9522101A5_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetFlagCount

function DefaultNodeBase.GetFirstLevelChildrenFlagCount(flag: TFlagMask): Cardinal;
//#UC START# *4677A98A0290_45F7ECA8034B_var*
//#UC END# *4677A98A0290_45F7ECA8034B_var*
begin
//#UC START# *4677A98A0290_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4677A98A0290_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetFirstLevelChildrenFlagCount

procedure DefaultNodeBase.SetChildrenFlag(flag: TFlagMask;
 value: Boolean);
//#UC START# *45F9524B006D_45F7ECA8034B_var*
//#UC END# *45F9524B006D_45F7ECA8034B_var*
begin
//#UC START# *45F9524B006D_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9524B006D_45F7ECA8034B_impl*
end;//DefaultNodeBase.SetChildrenFlag

function DefaultNodeBase.FindNodeByInterface(const node_to_find: INodeBase): DefaultNodeBase;
//#UC START# *45F952A602DE_45F7ECA8034B_var*
//#UC END# *45F952A602DE_45F7ECA8034B_var*
begin
//#UC START# *45F952A602DE_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F952A602DE_45F7ECA8034B_impl*
end;//DefaultNodeBase.FindNodeByInterface

function DefaultNodeBase.FindNode(const node_to_find): DefaultNodeBase;
//#UC START# *45F9533D02AF_45F7ECA8034B_var*
//#UC END# *45F9533D02AF_45F7ECA8034B_var*
begin
//#UC START# *45F9533D02AF_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9533D02AF_45F7ECA8034B_impl*
end;//DefaultNodeBase.FindNode

function DefaultNodeBase.FindNodePath(var node_to_find: INodeBase): INodeIndexPath;
//#UC START# *45F9535E0213_45F7ECA8034B_var*
//#UC END# *45F9535E0213_45F7ECA8034B_var*
begin
//#UC START# *45F9535E0213_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9535E0213_45F7ECA8034B_impl*
end;//DefaultNodeBase.FindNodePath

function DefaultNodeBase.GetVisibleDelta(var node: DefaultNodeBase): TVisibleIndex;
//#UC START# *45F953BF005D_45F7ECA8034B_var*
//#UC END# *45F953BF005D_45F7ECA8034B_var*
begin
//#UC START# *45F953BF005D_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F953BF005D_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetVisibleDelta

function DefaultNodeBase.GetVisibleDelta(const node_path): TVisibleIndex;
//#UC START# *45F95412037A_45F7ECA8034B_var*
//#UC END# *45F95412037A_45F7ECA8034B_var*
begin
//#UC START# *45F95412037A_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95412037A_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetVisibleDelta

function DefaultNodeBase.GetVisibleDelta(const entity: IEntityBase): TVisibleIndex;
//#UC START# *45F9542B03D8_45F7ECA8034B_var*
//#UC END# *45F9542B03D8_45F7ECA8034B_var*
begin
//#UC START# *45F9542B03D8_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9542B03D8_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetVisibleDelta

function DefaultNodeBase.GetIndexFromParent: TVisibleIndex;
 {* TODO: упростить, выкинув этот метод
ходить только к StaticNode-е }
//#UC START# *45F9547101F4_45F7ECA8034B_var*
//#UC END# *45F9547101F4_45F7ECA8034B_var*
begin
//#UC START# *45F9547101F4_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9547101F4_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetIndexFromParent

function DefaultNodeBase.GetAbsIndex: TVisibleIndex; { can raise CanNotFindData }
//#UC START# *45F954900138_45F7ECA8034B_var*
//#UC END# *45F954900138_45F7ECA8034B_var*
begin
//#UC START# *45F954900138_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F954900138_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetAbsIndex

function DefaultNodeBase.GetChildPathByAbsIndex(index: TVisibleIndex): INodeIndexPath; { can raise CanNotFindData }
//#UC START# *45F954CB0128_45F7ECA8034B_var*
//#UC END# *45F954CB0128_45F7ECA8034B_var*
begin
//#UC START# *45F954CB0128_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F954CB0128_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetChildPathByAbsIndex

procedure DefaultNodeBase.AddNotifier(var notifier: INodeNotifier);
//#UC START# *45F95547002E_45F7ECA8034B_var*
//#UC END# *45F95547002E_45F7ECA8034B_var*
begin
//#UC START# *45F95547002E_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95547002E_45F7ECA8034B_impl*
end;//DefaultNodeBase.AddNotifier

procedure DefaultNodeBase.RemoveNotifier(var notifier: INodeNotifier);
//#UC START# *45F9555D01B5_45F7ECA8034B_var*
//#UC END# *45F9555D01B5_45F7ECA8034B_var*
begin
//#UC START# *45F9555D01B5_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9555D01B5_45F7ECA8034B_impl*
end;//DefaultNodeBase.RemoveNotifier

function DefaultNodeBase.FindStubForIndex(out index: Integer): FlagNodeStub;
//#UC START# *45F955BC034B_45F7ECA8034B_var*
//#UC END# *45F955BC034B_45F7ECA8034B_var*
begin
//#UC START# *45F955BC034B_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F955BC034B_45F7ECA8034B_impl*
end;//DefaultNodeBase.FindStubForIndex

procedure DefaultNodeBase.GetAvailableLayers(var layers: ILayerIdList);
//#UC START# *45F955DD0261_45F7ECA8034B_var*
//#UC END# *45F955DD0261_45F7ECA8034B_var*
begin
//#UC START# *45F955DD0261_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F955DD0261_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetAvailableLayers

function DefaultNodeBase.GetFirstFit(const filter: IFilterList): INodeIndexPath;
//#UC START# *45F95642009C_45F7ECA8034B_var*
//#UC END# *45F95642009C_45F7ECA8034B_var*
begin
//#UC START# *45F95642009C_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95642009C_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetFirstFit

function DefaultNodeBase.Find(const filter: IFilterList;
 const find_from: TNodePosition): IFindIterator;
//#UC START# *45F95672034B_45F7ECA8034B_var*
//#UC END# *45F95672034B_45F7ECA8034B_var*
begin
//#UC START# *45F95672034B_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95672034B_45F7ECA8034B_impl*
end;//DefaultNodeBase.Find

function DefaultNodeBase.IsRelevanceSearchSupported: ByteBool;
//#UC START# *45F957E701D4_45F7ECA8034B_var*
//#UC END# *45F957E701D4_45F7ECA8034B_var*
begin
//#UC START# *45F957E701D4_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F957E701D4_45F7ECA8034B_impl*
end;//DefaultNodeBase.IsRelevanceSearchSupported

function DefaultNodeBase.GetNodeByPath(const path: INodeIndexPath): INodeBase;
 {* Дублирует с CatalogBase }
//#UC START# *45F958030280_45F7ECA8034B_var*
//#UC END# *45F958030280_45F7ECA8034B_var*
begin
//#UC START# *45F958030280_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F958030280_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetNodeByPath

procedure DefaultNodeBase.NodePathToIndexPath(const path);
//#UC START# *45F958740203_45F7ECA8034B_var*
//#UC END# *45F958740203_45F7ECA8034B_var*
begin
//#UC START# *45F958740203_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F958740203_45F7ECA8034B_impl*
end;//DefaultNodeBase.NodePathToIndexPath

procedure DefaultNodeBase.Entity; { can raise NoEntity }
//#UC START# *45F95AAD0232_45F7ECA8034B_var*
//#UC END# *45F95AAD0232_45F7ECA8034B_var*
begin
//#UC START# *45F95AAD0232_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95AAD0232_45F7ECA8034B_impl*
end;//DefaultNodeBase.Entity

function DefaultNodeBase.ApplyResetDelta(var delta): ByteBool;
//#UC START# *45F95B680232_45F7ECA8034B_var*
//#UC END# *45F95B680232_45F7ECA8034B_var*
begin
//#UC START# *45F95B680232_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95B680232_45F7ECA8034B_impl*
end;//DefaultNodeBase.ApplyResetDelta

function DefaultNodeBase.ApplyInsertDelta(var delta): ByteBool;
//#UC START# *45F95BAF02CE_45F7ECA8034B_var*
//#UC END# *45F95BAF02CE_45F7ECA8034B_var*
begin
//#UC START# *45F95BAF02CE_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95BAF02CE_45F7ECA8034B_impl*
end;//DefaultNodeBase.ApplyInsertDelta

function DefaultNodeBase.ApplyDeleteDelta(var delta): ByteBool;
//#UC START# *45F95BBD0271_45F7ECA8034B_var*
//#UC END# *45F95BBD0271_45F7ECA8034B_var*
begin
//#UC START# *45F95BBD0271_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95BBD0271_45F7ECA8034B_impl*
end;//DefaultNodeBase.ApplyDeleteDelta

procedure DefaultNodeBase.RemoveMeAndSiblings(out count: Cardinal);
//#UC START# *45F95C3C035B_45F7ECA8034B_var*
//#UC END# *45F95C3C035B_45F7ECA8034B_var*
begin
//#UC START# *45F95C3C035B_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95C3C035B_45F7ECA8034B_impl*
end;//DefaultNodeBase.RemoveMeAndSiblings

procedure DefaultNodeBase.Clean;
//#UC START# *45F95C64003E_45F7ECA8034B_var*
//#UC END# *45F95C64003E_45F7ECA8034B_var*
begin
//#UC START# *45F95C64003E_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95C64003E_45F7ECA8034B_impl*
end;//DefaultNodeBase.Clean

function DefaultNodeBase.IsAllExpanded: ByteBool;
//#UC START# *45F95CBF002E_45F7ECA8034B_var*
//#UC END# *45F95CBF002E_45F7ECA8034B_var*
begin
//#UC START# *45F95CBF002E_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95CBF002E_45F7ECA8034B_impl*
end;//DefaultNodeBase.IsAllExpanded

procedure DefaultNodeBase.ExpandAllNodes(expand: Boolean);
//#UC START# *45F95CC40109_45F7ECA8034B_var*
//#UC END# *45F95CC40109_45F7ECA8034B_var*
begin
//#UC START# *45F95CC40109_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95CC40109_45F7ECA8034B_impl*
end;//DefaultNodeBase.ExpandAllNodes

function DefaultNodeBase.OwnerTree: TreeBase;
//#UC START# *47D6C0A2017A_45F7ECA8034B_var*
//#UC END# *47D6C0A2017A_45F7ECA8034B_var*
begin
//#UC START# *47D6C0A2017A_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D6C0A2017A_45F7ECA8034B_impl*
end;//DefaultNodeBase.OwnerTree

function DefaultNodeBase.OwnerTree: TreeBase;
//#UC START# *47D6C239024C_45F7ECA8034B_var*
//#UC END# *47D6C239024C_45F7ECA8034B_var*
begin
//#UC START# *47D6C239024C_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D6C239024C_45F7ECA8034B_impl*
end;//DefaultNodeBase.OwnerTree

function DefaultNodeBase.SetRangeFlagExceptFirstChildrenOfRootChildren(from: TVisibleIndex;
 to: TVisibleIndex;
 flag: TFlagMask;
 value: Boolean;
 clean_other: Boolean;
 with_notify: Boolean): ByteBool;
//#UC START# *51EFD62F03D7_45F7ECA8034B_var*
//#UC END# *51EFD62F03D7_45F7ECA8034B_var*
begin
//#UC START# *51EFD62F03D7_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *51EFD62F03D7_45F7ECA8034B_impl*
end;//DefaultNodeBase.SetRangeFlagExceptFirstChildrenOfRootChildren

procedure DefaultNodeBase.SetAllFlag(flag: TFlagMask;
 value: Boolean;
 with_notify: Boolean);
//#UC START# *45F80922032C_45F7ECA8034B_var*
//#UC END# *45F80922032C_45F7ECA8034B_var*
begin
//#UC START# *45F80922032C_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F80922032C_45F7ECA8034B_impl*
end;//DefaultNodeBase.SetAllFlag

function DefaultNodeBase.InternalSetAllFlag(flag: TFlagMask;
 value: Boolean;
 children_only: Boolean): size;
 {* возвращает количество взведённых (изменённых?) флагов. }
//#UC START# *45F810730290_45F7ECA8034B_var*
//#UC END# *45F810730290_45F7ECA8034B_var*
begin
//#UC START# *45F810730290_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F810730290_45F7ECA8034B_impl*
end;//DefaultNodeBase.InternalSetAllFlag

procedure DefaultNodeBase.SetAllFlagExceptFirstChildrenOfRootChildren(flag: TFlagMask;
 value: Boolean;
 with_notify: Boolean);
//#UC START# *51EFC6D0015B_45F7ECA8034B_var*
//#UC END# *51EFC6D0015B_45F7ECA8034B_var*
begin
//#UC START# *51EFC6D0015B_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *51EFC6D0015B_45F7ECA8034B_impl*
end;//DefaultNodeBase.SetAllFlagExceptFirstChildrenOfRootChildren

function DefaultNodeBase.InternalSetAllFlagExceptFirstChildrenOfRootChildren(flag: TFlagMask;
 value: Boolean;
 children_only: Boolean): size;
//#UC START# *51EFC7130001_45F7ECA8034B_var*
//#UC END# *51EFC7130001_45F7ECA8034B_var*
begin
//#UC START# *51EFC7130001_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *51EFC7130001_45F7ECA8034B_impl*
end;//DefaultNodeBase.InternalSetAllFlagExceptFirstChildrenOfRootChildren

function DefaultNodeBase.SetFlag(flag: TFlagMask;
 value: Boolean;
 with_notify: Boolean): ByteBool;
//#UC START# *45F8123602DE_45F7ECA8034B_var*
//#UC END# *45F8123602DE_45F7ECA8034B_var*
begin
//#UC START# *45F8123602DE_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8123602DE_45F7ECA8034B_impl*
end;//DefaultNodeBase.SetFlag

//#UC START# *45F7ECA8034Bimpl*
//#UC END# *45F7ECA8034Bimpl*

end.
