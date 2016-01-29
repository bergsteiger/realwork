unit DefaultNodeBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/DefaultNodeBase.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::DefaultNodeBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTypesUnit,
  DynamicTreeUnit,
  FlagNodeBase,
  reeBase,
  DynamicTreeDefinesUnit,
  FlagNodeStub
  ;

type
//#UC START# *45F7ECA8034Bci*
//#UC END# *45F7ECA8034Bci*
 DefaultNodeBase = {abstract} class(FlagNodeBase)
 private
 // private methods
   class procedure IndexPathToNodePath(const path: INodeIndexPath;
    var node_path;
    l: Integer); virtual;
   class procedure PrintPath(node_to_find: DefaultNodeBase;
    const path: INodeIndexPath); virtual;
   class procedure ServerLayersIdListToAdapter(srv;
    var adap: ILayerIdList); virtual;
 protected
 // property methods
   function pm_GetChildrenFlags: TFlagMask; virtual;
   procedure pm_SetOwnerTree(aValue: TreeBase); overload;  virtual;
 protected
 // realized methods
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
 public
 // overridden public methods
   function SetFlag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean): Boolean; override;
 protected
 // protected methods
   class function GetRealInterface(node_): DefaultNodeBase; virtual;
   constructor Make; overload;  virtual;
   procedure InvalidateChildrenCount; virtual;
   procedure CreateViewEx(const filter: IFilterList;
    shared_flags: TFlagMask;
    sync_node: DefaultNodeBase;
    out sync_index: TVisibleIndex;
    levels: Cardinal;
    unfiltered: Boolean;
    auto_open: Boolean;
    truncate_this_view: Boolean); virtual;
   function SetRangeFlag(from: TVisibleIndex;
    to: TVisibleIndex;
    flag: TFlagMask;
    value: Boolean;
    clean_other: Boolean;
    with_notify: Boolean): Boolean; virtual;
   function HasParentFlag(flag: TFlagMask): Boolean; virtual;
   function HasChildrenFlag(flag: TFlagMask): Boolean; virtual;
   function GetFlagCount(flag: TFlagMask): Cardinal; virtual;
   function GetFirstLevelChildrenFlagCount(flag: TFlagMask): Cardinal; virtual;
   procedure SetChildrenFlag(flag: TFlagMask;
    value: Boolean); virtual;
   function FindNodeByInterface(const node_to_find: INodeBase): DefaultNodeBase; virtual;
   function FindNode(node_to_find): DefaultNodeBase; virtual;
   function FindNodePath(var node_to_find: INodeBase): INodeIndexPath; virtual;
   function GetVisibleDelta(var node: DefaultNodeBase): TVisibleIndex; overload;  virtual;
   function GetVisibleDelta(node_path): TVisibleIndex; overload;  virtual;
   function GetVisibleDelta(const entity: IEntityBase): TVisibleIndex; overload;  virtual;
   function GetIndexFromParent: TVisibleIndex; virtual;
     {* TODO: упростить, выкинув этот метод
ходить только к StaticNode-е }
   function GetAbsIndex: TVisibleIndex; virtual; // can raise CanNotFindData
   function GetChildPathByAbsIndex(index: TVisibleIndex): INodeIndexPath; virtual; // can raise CanNotFindData
   procedure AddNotifier(var notifier: INodeNotifier); virtual;
   procedure RemoveNotifier(var notifier: INodeNotifier); virtual;
   function FindStubForIndex(out index: Integer): FlagNodeStub; virtual;
   procedure GetAvailableLayers(var layers: ILayerIdList); virtual;
   function GetFirstFit(const filter: IFilterList): INodeIndexPath; virtual;
   function Find(const filter: IFilterList;
    const find_from: TNodePosition): IFindIterator; virtual;
   function IsRelevanceSearchSupported: Boolean; virtual;
   function GetNodeByPath(const path: INodeIndexPath): INodeBase; virtual;
     {* Дублирует с CatalogBase }
   procedure NodePathToIndexPath(path); virtual;
   procedure Entity; virtual; // can raise NoEntity
   function ApplyResetDelta(var delta): Boolean; virtual;
   function ApplyChangeDelta(var delta): Boolean; virtual; abstract;
   function ApplyInsertDelta(var delta): Boolean; virtual;
   function ApplyDeleteDelta(var delta): Boolean; virtual;
   procedure RemoveMeAndSiblings(out count: Cardinal); virtual;
   procedure Clean; virtual;
   function IsAllExpanded: Boolean; virtual;
   procedure ExpandAllNodes(expand: Boolean); virtual;
 public
 // public methods
   class procedure SrvPathToAdapter(index_path;
    var adap_path: INodeIndexPath); virtual;
   class procedure AdapterPathToSrv(const adapter_index_path: INodeIndexPath); virtual;
   constructor Make(var owner_tree: TreeBase); overload;  virtual;
   procedure GetServerPointer; virtual; abstract;
   function FindNodeByPath(node_path): DefaultNodeBase; overload;  virtual;
   function FindNodeByPath(node_index_path): DefaultNodeBase; overload;  virtual;
   function FindLoadedNodeByPath(node_index_path): DefaultNodeBase; virtual;
   function GetTreeName: PAnsiChar; virtual;
   function GetSettingsRootId: AnsiString; virtual;
   function NodeName: PAnsiChar; virtual; abstract;
   procedure ServerDataVersion; virtual;
   procedure GetServerPath(path_type = PT_POINTER); virtual;
   function GetTreeOwner: TreeBase; virtual;
   function GetVisibleIndex: TVisibleIndex; virtual;
   function OwnerTree: TreeBase; overload;  virtual;
   function OwnerTree: TreeBase; overload;  virtual;
   function SetRangeFlagExceptFirstChildrenOfRootChildren(from: TVisibleIndex;
    to: TVisibleIndex;
    flag: TFlagMask;
    value: Boolean;
    clean_other: Boolean;
    with_notify: Boolean): Boolean; virtual;
 protected
 // protected properties
   property children_flags: TFlagMask
     read pm_GetChildrenFlags;
   property owner_tree: TreeBase
     write pm_SetOwnerTree;
//#UC START# *45F7ECA8034Bpubl*
//#UC END# *45F7ECA8034Bpubl*
 end;//DefaultNodeBase

implementation

uses
  RealNodeBase,
  ServerAdapterConverters,
  ViewBase
  ;

// start class DefaultNodeBase

function DefaultNodeBase.pm_GetChildrenFlags: TFlagMask;
//#UC START# *45F95D2600AB_45F7ECA8034Bget_var*
//#UC END# *45F95D2600AB_45F7ECA8034Bget_var*
begin
//#UC START# *45F95D2600AB_45F7ECA8034Bget_impl*
 Result := f_children_flags
//#UC END# *45F95D2600AB_45F7ECA8034Bget_impl*
end;//DefaultNodeBase.pm_GetChildrenFlags

procedure DefaultNodeBase.pm_SetOwnerTree(aValue: TreeBase);
//#UC START# *45F9675A000F_45F7ECA8034Bset_var*
//#UC END# *45F9675A000F_45F7ECA8034Bset_var*
begin
//#UC START# *45F9675A000F_45F7ECA8034Bset_impl*
 f_owner_tree := aValue
//#UC END# *45F9675A000F_45F7ECA8034Bset_impl*
end;//DefaultNodeBase.pm_SetOwnerTree

class procedure DefaultNodeBase.SrvPathToAdapter(index_path;
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

class procedure DefaultNodeBase.ServerLayersIdListToAdapter(srv;
  var adap: ILayerIdList);
//#UC START# *45FA84E40213_45F7ECA8034B_var*
//#UC END# *45FA84E40213_45F7ECA8034B_var*
begin
//#UC START# *45FA84E40213_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FA84E40213_45F7ECA8034B_impl*
end;//DefaultNodeBase.ServerLayersIdListToAdapter

class function DefaultNodeBase.GetRealInterface(node_): DefaultNodeBase;
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

function DefaultNodeBase.FindNodeByPath(node_path): DefaultNodeBase;
//#UC START# *45F94BE501E4_45F7ECA8034B_var*
//#UC END# *45F94BE501E4_45F7ECA8034B_var*
begin
//#UC START# *45F94BE501E4_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94BE501E4_45F7ECA8034B_impl*
end;//DefaultNodeBase.FindNodeByPath

function DefaultNodeBase.FindNodeByPath(node_index_path): DefaultNodeBase;
//#UC START# *45F94C8E0109_45F7ECA8034B_var*
//#UC END# *45F94C8E0109_45F7ECA8034B_var*
begin
//#UC START# *45F94C8E0109_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94C8E0109_45F7ECA8034B_impl*
end;//DefaultNodeBase.FindNodeByPath

function DefaultNodeBase.FindLoadedNodeByPath(node_index_path): DefaultNodeBase;
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

procedure DefaultNodeBase.GetServerPath(path_type = PT_POINTER);
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
  with_notify: Boolean): Boolean;
//#UC START# *45F94FF401C5_45F7ECA8034B_var*
//#UC END# *45F94FF401C5_45F7ECA8034B_var*
begin
//#UC START# *45F94FF401C5_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94FF401C5_45F7ECA8034B_impl*
end;//DefaultNodeBase.SetRangeFlag

function DefaultNodeBase.HasParentFlag(flag: TFlagMask): Boolean;
//#UC START# *45F951DC0242_45F7ECA8034B_var*
//#UC END# *45F951DC0242_45F7ECA8034B_var*
begin
//#UC START# *45F951DC0242_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F951DC0242_45F7ECA8034B_impl*
end;//DefaultNodeBase.HasParentFlag

function DefaultNodeBase.HasChildrenFlag(flag: TFlagMask): Boolean;
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

function DefaultNodeBase.FindNode(node_to_find): DefaultNodeBase;
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

function DefaultNodeBase.GetVisibleDelta(node_path): TVisibleIndex;
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
//#UC START# *45F9547101F4_45F7ECA8034B_var*
//#UC END# *45F9547101F4_45F7ECA8034B_var*
begin
//#UC START# *45F9547101F4_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9547101F4_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetIndexFromParent

function DefaultNodeBase.GetAbsIndex: TVisibleIndex; // can raise CanNotFindData
//#UC START# *45F954900138_45F7ECA8034B_var*
//#UC END# *45F954900138_45F7ECA8034B_var*
begin
//#UC START# *45F954900138_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F954900138_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetAbsIndex

function DefaultNodeBase.GetChildPathByAbsIndex(index: TVisibleIndex): INodeIndexPath; // can raise CanNotFindData
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

function DefaultNodeBase.IsRelevanceSearchSupported: Boolean;
//#UC START# *45F957E701D4_45F7ECA8034B_var*
//#UC END# *45F957E701D4_45F7ECA8034B_var*
begin
//#UC START# *45F957E701D4_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F957E701D4_45F7ECA8034B_impl*
end;//DefaultNodeBase.IsRelevanceSearchSupported

function DefaultNodeBase.GetNodeByPath(const path: INodeIndexPath): INodeBase;
//#UC START# *45F958030280_45F7ECA8034B_var*
//#UC END# *45F958030280_45F7ECA8034B_var*
begin
//#UC START# *45F958030280_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F958030280_45F7ECA8034B_impl*
end;//DefaultNodeBase.GetNodeByPath

procedure DefaultNodeBase.NodePathToIndexPath(path);
//#UC START# *45F958740203_45F7ECA8034B_var*
//#UC END# *45F958740203_45F7ECA8034B_var*
begin
//#UC START# *45F958740203_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F958740203_45F7ECA8034B_impl*
end;//DefaultNodeBase.NodePathToIndexPath

procedure DefaultNodeBase.Entity; // can raise NoEntity
//#UC START# *45F95AAD0232_45F7ECA8034B_var*
//#UC END# *45F95AAD0232_45F7ECA8034B_var*
begin
//#UC START# *45F95AAD0232_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95AAD0232_45F7ECA8034B_impl*
end;//DefaultNodeBase.Entity

function DefaultNodeBase.ApplyResetDelta(var delta): Boolean;
//#UC START# *45F95B680232_45F7ECA8034B_var*
//#UC END# *45F95B680232_45F7ECA8034B_var*
begin
//#UC START# *45F95B680232_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95B680232_45F7ECA8034B_impl*
end;//DefaultNodeBase.ApplyResetDelta

function DefaultNodeBase.ApplyInsertDelta(var delta): Boolean;
//#UC START# *45F95BAF02CE_45F7ECA8034B_var*
//#UC END# *45F95BAF02CE_45F7ECA8034B_var*
begin
//#UC START# *45F95BAF02CE_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95BAF02CE_45F7ECA8034B_impl*
end;//DefaultNodeBase.ApplyInsertDelta

function DefaultNodeBase.ApplyDeleteDelta(var delta): Boolean;
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

function DefaultNodeBase.IsAllExpanded: Boolean;
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
  with_notify: Boolean): Boolean;
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
  with_notify: Boolean): Boolean;
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