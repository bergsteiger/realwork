unit reeBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/reeBase.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::TreeBase
//
// адаптерное дерево
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  DynamicTreeUnit,
  FlagNodeBase,
  DynamicTreeDefinesUnit,
  ActiveChangeableBase,
  DefaultNodeBase,
  RealNodeBase
  ;

type
 InvalidOwnerTree = class
 end;//InvalidOwnerTree

 EmptyBranch = class
 end;//EmptyBranch

 FindedData = record
   index : Integer;
   node : ;
 end;//FindedData

//#UC START# *46013DB90157ci*
//#UC END# *46013DB90157ci*
 FlagMaskStubPostProcess = class
 private
 // private fields
   mask : TFlagMask;
   action : Boolean;
 public
 // public methods
   constructor Make(mask: TFlagMask;
    action: Boolean); virtual;
//#UC START# *46013DB90157publ*
//#UC END# *46013DB90157publ*
 end;//FlagMaskStubPostProcess


 ViewBase = class;


 RealNodeBase = class;


 DefaultNodeBase = class;

//#UC START# *45F554750213ci*
//#UC END# *45F554750213ci*
 TreeBase = {abstract} class(ActiveChangeableBase, IFakeFacetForFactory)
  {* адаптерное дерево }
 private
 // private fields
   load_block_half_size : Integer;
   load_in_one_direction : Boolean;
   counter_deltas : CounterDeltaMap;
   root : ;
   finded_node : FindedNodes;
   changed_layer : Boolean;
   server_data_version : ;
 private
 // private methods
   procedure CalcFromPosition(offset: Integer;
    child_point;
    var current_stub;
    out from: Integer;
    out in_block_position: Cardinal); virtual;
   procedure OnedirCalcFromPosition(offset: Integer;
    child_point;
    var current_stub;
    out from: Integer;
    out in_block_position: Cardinal); virtual;
   procedure BidirCalcFromPosition(offset: Integer;
    child_point;
    var current_stub;
    out from: Integer;
    out in_block_position: Cardinal); virtual;
   procedure AddToLoaded(var node: RealNodeBase); virtual;
   procedure LoadChildren(parent); virtual;
   procedure LoadStubNode(var node);
 protected
 // property methods
   function pm_GetActiveChangeble: Boolean; virtual;
   procedure pm_SetActiveChangeble(aValue: Boolean); virtual;
   function pm_GetServerTree: ; virtual;
   function pm_GetFlagsMap: NodeFlagMap; virtual;
   function pm_GetIsChanged: Boolean; virtual;
   function pm_GetTreeName: AnsiString; virtual; abstract;
 protected
 // realized methods
 protected
 // protected fields
   notifiers : NotifierSet;
   selected_count : Cardinal;
   nodes : NodeMap;
   last_select : LastSelectMap;
   all_expanded : Boolean;
 protected
 // protected methods
   constructor Make; overload;  virtual;
   function GetLoadBlockHalfSize: Integer; virtual;
   procedure SetLoadBlockHalfSize(new_size: Integer); virtual;
   function IsLoadInOneDirection: Boolean; virtual;
   procedure SetLoadInOneDirection(yes: Boolean); virtual;
   function MasterTree: TreeBase; virtual;
   function AllocNewNode(snode): DefaultNodeBase; virtual; abstract;
   function AllocNewView: ViewBase; virtual; abstract;
   procedure Clear; virtual;
   procedure SafetyRemove; virtual;
   function ChangedLayer(new_val: Boolean): Boolean; overload;  virtual;
   procedure DumpFlagsMap(context: PAnsiChar); virtual;
   procedure ApplyDeltaPostprocess(var fake); virtual;
     {* [timestamp_sync] }
 public
 // public methods
   constructor Make(active_changeable: Boolean); overload;  virtual;
   function IsLoadedNode(node_pointer): Boolean; virtual;
   procedure AdapterFiltersToServer(var adap: IFilterList;
    var serv); virtual;
   procedure FlushCounterDelta; virtual;
   procedure Root; overload;  virtual;
   function GetLastSelected(flag: TFlagMask): DefaultNodeBase; virtual;
   procedure UpdateCounters(node: FlagNodeBase;
    flag: TFlagMask;
    value: Boolean); virtual;
   function GetChildrenFlagsCount(node: FlagNodeBase;
    flag: TFlagMask): Cardinal; virtual;
   function GetAllFlagsCount(node: FlagNodeBase;
    flag: TFlagMask): Cardinal; virtual;
   procedure PointerPathToIndexPath(pointer_path); virtual;
   procedure PointerToIndexPath(pointer); virtual;
   procedure NamePathToIndexPath(name_path); virtual;
   procedure ServerDataVersion; overload;  virtual;
   procedure AddNotifier(var root;
    var notifier: INodeNotifier); virtual;
   procedure RemoveNotifier(var root;
    var notifier: INodeNotifier); virtual;
   procedure CreateView(root;
    filter;
    shared_flags: TFlagMask;
    sync_node;
    out sync_index: TVisibleIndex;
    levels: unsigned integer;
    unfiltered: Boolean;
    auto_open: Boolean;
    truncate_this_view: Boolean); virtual;
   procedure PreFind(var filters: IFilterList); virtual;
   function IsRelevanceSearchSupported: Boolean; virtual;
   procedure GetFirstFit(from_node;
    var filter: IFilterList); virtual;
   procedure Find(find_from;
    var filter: IFilterList); virtual;
   function IsMode(shared_flags: TFlagMask): Boolean; virtual;
   procedure BuildNode(snode;
    var current_stub: FlagNodeBase;
    master_index: Integer); virtual;
   procedure LoadNodesFromServer(parent_point;
    child_point;
    from: Integer;
    in_block_position: Cardinal;
    var current_stub); virtual; // can raise InvalidOwnerTree
   function GetSharedMode: TFlagMask; virtual;
   procedure ApplyFlags(from: FlagNodeBase;
    var to: FlagNodeBase;
    shared_mask: TFlagMask); virtual;
   procedure CacheFindedNode(parent: DefaultNodeBase;
    index: Integer;
    var node); virtual;
   procedure InvalidateFindedNode(parent: DefaultNodeBase); virtual;
   procedure FindCachedNode(parent: DefaultNodeBase;
    out index: Integer); virtual;
   procedure GetAvailableLayers; virtual;
   procedure ChangeChildrenCount(index: TVisibleIndex;
    delta: Integer;
    var index_path: INodeIndexPath;
    child_index: TIndexInParent); virtual;
   procedure Invalidate(const index_path: INodeIndexPath); virtual;
   procedure Changing; virtual;
   procedure Changed; virtual;
   procedure ApplyServerTree(server_tree); virtual;
   function ApplyCreatedNode(data): RealNodeBase; virtual; abstract;
   procedure FindCreatedUid(var node: RealNodeBase); virtual; abstract;
   procedure AssociateNodeWithUid(var node: RealNodeBase); virtual; abstract;
   procedure DisassociateNodeWithUid(var node: RealNodeBase); virtual; abstract;
   procedure GetCachedServerTree; virtual;
   function IsAllExpanded: Boolean; virtual;
   procedure ExpandAll(expand: Boolean); virtual;
   function IsRootVisible: Boolean; virtual;
   procedure ResetChildrenCount; virtual;
   procedure ResetByServerTree(new_tree); virtual;
   procedure ResetByRoot(new_root_ch_count: Cardinal); virtual;
   procedure SetChanged(state: Boolean); virtual;
   function GetChangeMutex: mutex; virtual; abstract;
   function IsRootNil: Boolean; virtual;
   procedure RootIsDead; virtual;
     {* used by RealNodeRoot::delete_obj ONLY }
   procedure LoadAllTree; virtual;
     {* прогружает дерево целиком. см. http://mdp.garant.ru/pages/viewpage.action?pageId=17334971 }
 protected
 // protected properties
   property active_changeble: Boolean
     read pm_GetActiveChangeble
     write pm_SetActiveChangeble;
 public
 // public properties
   property server_tree: 
     read pm_GetServerTree;
   property flags_map: NodeFlagMap
     read pm_GetFlagsMap;
   property is_changed: Boolean
     read pm_GetIsChanged;
   property tree_name: AnsiString
     read pm_GetTreeName;
//#UC START# *45F554750213publ*
//#UC END# *45F554750213publ*
 end;//TreeBase

implementation

uses
  ApplicationHelper,
  SecurityUnit,
  ServerAdapterConverters
  ;

type
  NodeExpander = {final} class
  private
  // private fields
   all_expanded : Boolean;
   expand_root : Boolean;
  public
  // public methods
   constructor Make(all_expanded: Boolean;
     expand_root: Boolean); virtual;
   procedure EachFunc(var static_node;
     out dummy: integer); virtual;
  end;//NodeExpander

// start class NodeExpander

constructor NodeExpander.Make(all_expanded: Boolean;
  expand_root: Boolean);
//#UC START# *45F55B100186_45F55AA303B9_var*
//#UC END# *45F55B100186_45F55AA303B9_var*
begin
//#UC START# *45F55B100186_45F55AA303B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F55B100186_45F55AA303B9_impl*
end;//NodeExpander.Make

procedure NodeExpander.EachFunc(var static_node;
  out dummy: integer);
//#UC START# *45F55B5A03B9_45F55AA303B9_var*
//#UC END# *45F55B5A03B9_45F55AA303B9_var*
begin
//#UC START# *45F55B5A03B9_45F55AA303B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F55B5A03B9_45F55AA303B9_impl*
end;//NodeExpander.EachFunc
// start class FlagMaskStubPostProcess

constructor FlagMaskStubPostProcess.Make(mask: TFlagMask;
  action: Boolean);
//#UC START# *46013DEC02CE_46013DB90157_var*
//#UC END# *46013DEC02CE_46013DB90157_var*
begin
//#UC START# *46013DEC02CE_46013DB90157_impl*
 !!! Needs to be implemented !!!
//#UC END# *46013DEC02CE_46013DB90157_impl*
end;//FlagMaskStubPostProcess.Make

//#UC START# *46013DB90157impl*
//#UC END# *46013DB90157impl*

function TreeBase.pm_GetActiveChangeble: Boolean;
//#UC START# *46013A67007D_45F554750213get_var*
//#UC END# *46013A67007D_45F554750213get_var*
begin
//#UC START# *46013A67007D_45F554750213get_impl*
 Result := f_active_changeble
//#UC END# *46013A67007D_45F554750213get_impl*
end;//TreeBase.pm_GetActiveChangeble

procedure TreeBase.pm_SetActiveChangeble(aValue: Boolean);
//#UC START# *46013A67007D_45F554750213set_var*
//#UC END# *46013A67007D_45F554750213set_var*
begin
//#UC START# *46013A67007D_45F554750213set_impl*
 f_active_changeble := aValue
//#UC END# *46013A67007D_45F554750213set_impl*
end;//TreeBase.pm_SetActiveChangeble

function TreeBase.pm_GetServerTree: ;
//#UC START# *46013AE00271_45F554750213get_var*
//#UC END# *46013AE00271_45F554750213get_var*
begin
//#UC START# *46013AE00271_45F554750213get_impl*
 Result := f_server_tree
//#UC END# *46013AE00271_45F554750213get_impl*
end;//TreeBase.pm_GetServerTree

function TreeBase.pm_GetFlagsMap: NodeFlagMap;
//#UC START# *46013B1601E4_45F554750213get_var*
//#UC END# *46013B1601E4_45F554750213get_var*
begin
//#UC START# *46013B1601E4_45F554750213get_impl*
 Result := f_flags_map
//#UC END# *46013B1601E4_45F554750213get_impl*
end;//TreeBase.pm_GetFlagsMap

function TreeBase.pm_GetIsChanged: Boolean;
//#UC START# *46013B4B0251_45F554750213get_var*
//#UC END# *46013B4B0251_45F554750213get_var*
begin
//#UC START# *46013B4B0251_45F554750213get_impl*
 Result := f_is_changed
//#UC END# *46013B4B0251_45F554750213get_impl*
end;//TreeBase.pm_GetIsChanged

constructor TreeBase.Make(active_changeable: Boolean);
//#UC START# *45F56FDC0271_45F554750213_var*
//#UC END# *45F56FDC0271_45F554750213_var*
begin
//#UC START# *45F56FDC0271_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F56FDC0271_45F554750213_impl*
end;//TreeBase.Make

constructor TreeBase.Make;
//#UC START# *46011A0C0109_45F554750213_var*
//#UC END# *46011A0C0109_45F554750213_var*
begin
//#UC START# *46011A0C0109_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011A0C0109_45F554750213_impl*
end;//TreeBase.Make

procedure TreeBase.CalcFromPosition(offset: Integer;
  child_point;
  var current_stub;
  out from: Integer;
  out in_block_position: Cardinal);
//#UC START# *460118B20109_45F554750213_var*
//#UC END# *460118B20109_45F554750213_var*
begin
//#UC START# *460118B20109_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460118B20109_45F554750213_impl*
end;//TreeBase.CalcFromPosition

procedure TreeBase.OnedirCalcFromPosition(offset: Integer;
  child_point;
  var current_stub;
  out from: Integer;
  out in_block_position: Cardinal);
//#UC START# *4601190F032C_45F554750213_var*
//#UC END# *4601190F032C_45F554750213_var*
begin
//#UC START# *4601190F032C_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601190F032C_45F554750213_impl*
end;//TreeBase.OnedirCalcFromPosition

procedure TreeBase.BidirCalcFromPosition(offset: Integer;
  child_point;
  var current_stub;
  out from: Integer;
  out in_block_position: Cardinal);
//#UC START# *4601193400EA_45F554750213_var*
//#UC END# *4601193400EA_45F554750213_var*
begin
//#UC START# *4601193400EA_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601193400EA_45F554750213_impl*
end;//TreeBase.BidirCalcFromPosition

function TreeBase.GetLoadBlockHalfSize: Integer;
//#UC START# *4601194C037A_45F554750213_var*
//#UC END# *4601194C037A_45F554750213_var*
begin
//#UC START# *4601194C037A_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601194C037A_45F554750213_impl*
end;//TreeBase.GetLoadBlockHalfSize

procedure TreeBase.SetLoadBlockHalfSize(new_size: Integer);
//#UC START# *4601195B02AF_45F554750213_var*
//#UC END# *4601195B02AF_45F554750213_var*
begin
//#UC START# *4601195B02AF_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601195B02AF_45F554750213_impl*
end;//TreeBase.SetLoadBlockHalfSize

function TreeBase.IsLoadInOneDirection: Boolean;
//#UC START# *4601197B01F4_45F554750213_var*
//#UC END# *4601197B01F4_45F554750213_var*
begin
//#UC START# *4601197B01F4_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601197B01F4_45F554750213_impl*
end;//TreeBase.IsLoadInOneDirection

procedure TreeBase.SetLoadInOneDirection(yes: Boolean);
//#UC START# *460119830119_45F554750213_var*
//#UC END# *460119830119_45F554750213_var*
begin
//#UC START# *460119830119_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460119830119_45F554750213_impl*
end;//TreeBase.SetLoadInOneDirection

function TreeBase.IsLoadedNode(node_pointer): Boolean;
//#UC START# *46011A2B0203_45F554750213_var*
//#UC END# *46011A2B0203_45F554750213_var*
begin
//#UC START# *46011A2B0203_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011A2B0203_45F554750213_impl*
end;//TreeBase.IsLoadedNode

procedure TreeBase.AdapterFiltersToServer(var adap: IFilterList;
  var serv);
//#UC START# *46011A8101C5_45F554750213_var*
//#UC END# *46011A8101C5_45F554750213_var*
begin
//#UC START# *46011A8101C5_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011A8101C5_45F554750213_impl*
end;//TreeBase.AdapterFiltersToServer

procedure TreeBase.FlushCounterDelta;
//#UC START# *46011C9A0157_45F554750213_var*
//#UC END# *46011C9A0157_45F554750213_var*
begin
//#UC START# *46011C9A0157_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011C9A0157_45F554750213_impl*
end;//TreeBase.FlushCounterDelta

procedure TreeBase.Root;
//#UC START# *46011CA602DE_45F554750213_var*
//#UC END# *46011CA602DE_45F554750213_var*
begin
//#UC START# *46011CA602DE_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011CA602DE_45F554750213_impl*
end;//TreeBase.Root

function TreeBase.GetLastSelected(flag: TFlagMask): DefaultNodeBase;
//#UC START# *46011CB9002E_45F554750213_var*
//#UC END# *46011CB9002E_45F554750213_var*
begin
//#UC START# *46011CB9002E_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011CB9002E_45F554750213_impl*
end;//TreeBase.GetLastSelected

procedure TreeBase.UpdateCounters(node: FlagNodeBase;
  flag: TFlagMask;
  value: Boolean);
//#UC START# *46011CE503A9_45F554750213_var*
//#UC END# *46011CE503A9_45F554750213_var*
begin
//#UC START# *46011CE503A9_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011CE503A9_45F554750213_impl*
end;//TreeBase.UpdateCounters

function TreeBase.GetChildrenFlagsCount(node: FlagNodeBase;
  flag: TFlagMask): Cardinal;
//#UC START# *46011D100242_45F554750213_var*
//#UC END# *46011D100242_45F554750213_var*
begin
//#UC START# *46011D100242_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011D100242_45F554750213_impl*
end;//TreeBase.GetChildrenFlagsCount

function TreeBase.GetAllFlagsCount(node: FlagNodeBase;
  flag: TFlagMask): Cardinal;
//#UC START# *46011D4001A5_45F554750213_var*
//#UC END# *46011D4001A5_45F554750213_var*
begin
//#UC START# *46011D4001A5_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011D4001A5_45F554750213_impl*
end;//TreeBase.GetAllFlagsCount

procedure TreeBase.PointerPathToIndexPath(pointer_path);
//#UC START# *46011D5D00EA_45F554750213_var*
//#UC END# *46011D5D00EA_45F554750213_var*
begin
//#UC START# *46011D5D00EA_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011D5D00EA_45F554750213_impl*
end;//TreeBase.PointerPathToIndexPath

procedure TreeBase.PointerToIndexPath(pointer);
//#UC START# *46011DEE0148_45F554750213_var*
//#UC END# *46011DEE0148_45F554750213_var*
begin
//#UC START# *46011DEE0148_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011DEE0148_45F554750213_impl*
end;//TreeBase.PointerToIndexPath

procedure TreeBase.NamePathToIndexPath(name_path);
//#UC START# *46011E200290_45F554750213_var*
//#UC END# *46011E200290_45F554750213_var*
begin
//#UC START# *46011E200290_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011E200290_45F554750213_impl*
end;//TreeBase.NamePathToIndexPath

procedure TreeBase.ServerDataVersion;
//#UC START# *46011E5F031C_45F554750213_var*
//#UC END# *46011E5F031C_45F554750213_var*
begin
//#UC START# *46011E5F031C_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011E5F031C_45F554750213_impl*
end;//TreeBase.ServerDataVersion

procedure TreeBase.AddNotifier(var root;
  var notifier: INodeNotifier);
//#UC START# *46011F130203_45F554750213_var*
//#UC END# *46011F130203_45F554750213_var*
begin
//#UC START# *46011F130203_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011F130203_45F554750213_impl*
end;//TreeBase.AddNotifier

procedure TreeBase.RemoveNotifier(var root;
  var notifier: INodeNotifier);
//#UC START# *46011F2C005D_45F554750213_var*
//#UC END# *46011F2C005D_45F554750213_var*
begin
//#UC START# *46011F2C005D_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011F2C005D_45F554750213_impl*
end;//TreeBase.RemoveNotifier

procedure TreeBase.CreateView(root;
  filter;
  shared_flags: TFlagMask;
  sync_node;
  out sync_index: TVisibleIndex;
  levels: unsigned integer;
  unfiltered: Boolean;
  auto_open: Boolean;
  truncate_this_view: Boolean);
//#UC START# *46011FD501A5_45F554750213_var*
//#UC END# *46011FD501A5_45F554750213_var*
begin
//#UC START# *46011FD501A5_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011FD501A5_45F554750213_impl*
end;//TreeBase.CreateView

procedure TreeBase.PreFind(var filters: IFilterList);
//#UC START# *460120C9005D_45F554750213_var*
//#UC END# *460120C9005D_45F554750213_var*
begin
//#UC START# *460120C9005D_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460120C9005D_45F554750213_impl*
end;//TreeBase.PreFind

function TreeBase.IsRelevanceSearchSupported: Boolean;
//#UC START# *4601213B0000_45F554750213_var*
//#UC END# *4601213B0000_45F554750213_var*
begin
//#UC START# *4601213B0000_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601213B0000_45F554750213_impl*
end;//TreeBase.IsRelevanceSearchSupported

procedure TreeBase.GetFirstFit(from_node;
  var filter: IFilterList);
//#UC START# *460121C103B9_45F554750213_var*
//#UC END# *460121C103B9_45F554750213_var*
begin
//#UC START# *460121C103B9_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460121C103B9_45F554750213_impl*
end;//TreeBase.GetFirstFit

procedure TreeBase.Find(find_from;
  var filter: IFilterList);
//#UC START# *460121EC029F_45F554750213_var*
//#UC END# *460121EC029F_45F554750213_var*
begin
//#UC START# *460121EC029F_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460121EC029F_45F554750213_impl*
end;//TreeBase.Find

function TreeBase.IsMode(shared_flags: TFlagMask): Boolean;
//#UC START# *4601221600DA_45F554750213_var*
//#UC END# *4601221600DA_45F554750213_var*
begin
//#UC START# *4601221600DA_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601221600DA_45F554750213_impl*
end;//TreeBase.IsMode

procedure TreeBase.BuildNode(snode;
  var current_stub: FlagNodeBase;
  master_index: Integer);
//#UC START# *46012315033C_45F554750213_var*
//#UC END# *46012315033C_45F554750213_var*
begin
//#UC START# *46012315033C_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012315033C_45F554750213_impl*
end;//TreeBase.BuildNode

procedure TreeBase.LoadNodesFromServer(parent_point;
  child_point;
  from: Integer;
  in_block_position: Cardinal;
  var current_stub); // can raise InvalidOwnerTree
//#UC START# *46012392006D_45F554750213_var*
//#UC END# *46012392006D_45F554750213_var*
begin
//#UC START# *46012392006D_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012392006D_45F554750213_impl*
end;//TreeBase.LoadNodesFromServer

function TreeBase.GetSharedMode: TFlagMask;
//#UC START# *4601240A033C_45F554750213_var*
//#UC END# *4601240A033C_45F554750213_var*
begin
//#UC START# *4601240A033C_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601240A033C_45F554750213_impl*
end;//TreeBase.GetSharedMode

procedure TreeBase.ApplyFlags(from: FlagNodeBase;
  var to: FlagNodeBase;
  shared_mask: TFlagMask);
//#UC START# *460124430251_45F554750213_var*
//#UC END# *460124430251_45F554750213_var*
begin
//#UC START# *460124430251_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460124430251_45F554750213_impl*
end;//TreeBase.ApplyFlags

procedure TreeBase.CacheFindedNode(parent: DefaultNodeBase;
  index: Integer;
  var node);
//#UC START# *4601246F032C_45F554750213_var*
//#UC END# *4601246F032C_45F554750213_var*
begin
//#UC START# *4601246F032C_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601246F032C_45F554750213_impl*
end;//TreeBase.CacheFindedNode

procedure TreeBase.InvalidateFindedNode(parent: DefaultNodeBase);
//#UC START# *46012495038A_45F554750213_var*
//#UC END# *46012495038A_45F554750213_var*
begin
//#UC START# *46012495038A_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012495038A_45F554750213_impl*
end;//TreeBase.InvalidateFindedNode

procedure TreeBase.FindCachedNode(parent: DefaultNodeBase;
  out index: Integer);
//#UC START# *460124AA0271_45F554750213_var*
//#UC END# *460124AA0271_45F554750213_var*
begin
//#UC START# *460124AA0271_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460124AA0271_45F554750213_impl*
end;//TreeBase.FindCachedNode

procedure TreeBase.GetAvailableLayers;
//#UC START# *460124CD03C8_45F554750213_var*
//#UC END# *460124CD03C8_45F554750213_var*
begin
//#UC START# *460124CD03C8_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460124CD03C8_45F554750213_impl*
end;//TreeBase.GetAvailableLayers

procedure TreeBase.ChangeChildrenCount(index: TVisibleIndex;
  delta: Integer;
  var index_path: INodeIndexPath;
  child_index: TIndexInParent);
//#UC START# *460124F5001F_45F554750213_var*
//#UC END# *460124F5001F_45F554750213_var*
begin
//#UC START# *460124F5001F_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460124F5001F_45F554750213_impl*
end;//TreeBase.ChangeChildrenCount

procedure TreeBase.Invalidate(const index_path: INodeIndexPath);
//#UC START# *4601253B0261_45F554750213_var*
//#UC END# *4601253B0261_45F554750213_var*
begin
//#UC START# *4601253B0261_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601253B0261_45F554750213_impl*
end;//TreeBase.Invalidate

procedure TreeBase.Changing;
//#UC START# *4601254A0186_45F554750213_var*
//#UC END# *4601254A0186_45F554750213_var*
begin
//#UC START# *4601254A0186_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601254A0186_45F554750213_impl*
end;//TreeBase.Changing

procedure TreeBase.Changed;
//#UC START# *4601255202FD_45F554750213_var*
//#UC END# *4601255202FD_45F554750213_var*
begin
//#UC START# *4601255202FD_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601255202FD_45F554750213_impl*
end;//TreeBase.Changed

procedure TreeBase.ApplyServerTree(server_tree);
//#UC START# *4601257D0148_45F554750213_var*
//#UC END# *4601257D0148_45F554750213_var*
begin
//#UC START# *4601257D0148_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601257D0148_45F554750213_impl*
end;//TreeBase.ApplyServerTree

procedure TreeBase.GetCachedServerTree;
//#UC START# *46012710030D_45F554750213_var*
//#UC END# *46012710030D_45F554750213_var*
begin
//#UC START# *46012710030D_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012710030D_45F554750213_impl*
end;//TreeBase.GetCachedServerTree

procedure TreeBase.AddToLoaded(var node: RealNodeBase);
//#UC START# *460127420261_45F554750213_var*
//#UC END# *460127420261_45F554750213_var*
begin
//#UC START# *460127420261_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127420261_45F554750213_impl*
end;//TreeBase.AddToLoaded

function TreeBase.IsAllExpanded: Boolean;
//#UC START# *460127560148_45F554750213_var*
//#UC END# *460127560148_45F554750213_var*
begin
//#UC START# *460127560148_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127560148_45F554750213_impl*
end;//TreeBase.IsAllExpanded

procedure TreeBase.ExpandAll(expand: Boolean);
//#UC START# *460127560261_45F554750213_var*
//#UC END# *460127560261_45F554750213_var*
begin
//#UC START# *460127560261_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127560261_45F554750213_impl*
end;//TreeBase.ExpandAll

function TreeBase.IsRootVisible: Boolean;
//#UC START# *46012775000F_45F554750213_var*
//#UC END# *46012775000F_45F554750213_var*
begin
//#UC START# *46012775000F_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012775000F_45F554750213_impl*
end;//TreeBase.IsRootVisible

function TreeBase.MasterTree: TreeBase;
//#UC START# *46012787038A_45F554750213_var*
//#UC END# *46012787038A_45F554750213_var*
begin
//#UC START# *46012787038A_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012787038A_45F554750213_impl*
end;//TreeBase.MasterTree

procedure TreeBase.Clear;
//#UC START# *460127F2000F_45F554750213_var*
//#UC END# *460127F2000F_45F554750213_var*
begin
//#UC START# *460127F2000F_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127F2000F_45F554750213_impl*
end;//TreeBase.Clear

procedure TreeBase.SafetyRemove;
//#UC START# *460127F90186_45F554750213_var*
//#UC END# *460127F90186_45F554750213_var*
begin
//#UC START# *460127F90186_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127F90186_45F554750213_impl*
end;//TreeBase.SafetyRemove

procedure TreeBase.ResetChildrenCount;
//#UC START# *46CD73470203_45F554750213_var*
//#UC END# *46CD73470203_45F554750213_var*
begin
//#UC START# *46CD73470203_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46CD73470203_45F554750213_impl*
end;//TreeBase.ResetChildrenCount

function TreeBase.ChangedLayer(new_val: Boolean): Boolean;
//#UC START# *46012801002E_45F554750213_var*
//#UC END# *46012801002E_45F554750213_var*
begin
//#UC START# *46012801002E_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012801002E_45F554750213_impl*
end;//TreeBase.ChangedLayer

procedure TreeBase.DumpFlagsMap(context: PAnsiChar);
//#UC START# *4601281502FD_45F554750213_var*
//#UC END# *4601281502FD_45F554750213_var*
begin
//#UC START# *4601281502FD_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601281502FD_45F554750213_impl*
end;//TreeBase.DumpFlagsMap

procedure TreeBase.ResetByServerTree(new_tree);
//#UC START# *4601284400DA_45F554750213_var*
//#UC END# *4601284400DA_45F554750213_var*
begin
//#UC START# *4601284400DA_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601284400DA_45F554750213_impl*
end;//TreeBase.ResetByServerTree

procedure TreeBase.ResetByRoot(new_root_ch_count: Cardinal);
//#UC START# *4601287803D8_45F554750213_var*
//#UC END# *4601287803D8_45F554750213_var*
begin
//#UC START# *4601287803D8_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601287803D8_45F554750213_impl*
end;//TreeBase.ResetByRoot

procedure TreeBase.SetChanged(state: Boolean);
//#UC START# *46012899005D_45F554750213_var*
//#UC END# *46012899005D_45F554750213_var*
begin
//#UC START# *46012899005D_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012899005D_45F554750213_impl*
end;//TreeBase.SetChanged

procedure TreeBase.ApplyDeltaPostprocess(var fake);
//#UC START# *4601391C032C_45F554750213_var*
//#UC END# *4601391C032C_45F554750213_var*
begin
//#UC START# *4601391C032C_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601391C032C_45F554750213_impl*
end;//TreeBase.ApplyDeltaPostprocess

function TreeBase.IsRootNil: Boolean;
//#UC START# *460139FF0128_45F554750213_var*
//#UC END# *460139FF0128_45F554750213_var*
begin
//#UC START# *460139FF0128_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460139FF0128_45F554750213_impl*
end;//TreeBase.IsRootNil

procedure TreeBase.RootIsDead;
//#UC START# *46013A110290_45F554750213_var*
//#UC END# *46013A110290_45F554750213_var*
begin
//#UC START# *46013A110290_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46013A110290_45F554750213_impl*
end;//TreeBase.RootIsDead

procedure TreeBase.LoadAllTree;
//#UC START# *466956AA02DE_45F554750213_var*
//#UC END# *466956AA02DE_45F554750213_var*
begin
//#UC START# *466956AA02DE_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *466956AA02DE_45F554750213_impl*
end;//TreeBase.LoadAllTree

procedure TreeBase.LoadChildren(parent);
//#UC START# *466957D20290_45F554750213_var*
//#UC END# *466957D20290_45F554750213_var*
begin
//#UC START# *466957D20290_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *466957D20290_45F554750213_impl*
end;//TreeBase.LoadChildren

procedure TreeBase.LoadStubNode(var node);
//#UC START# *4755759F0391_45F554750213_var*
//#UC END# *4755759F0391_45F554750213_var*
begin
//#UC START# *4755759F0391_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4755759F0391_45F554750213_impl*
end;//TreeBase.LoadStubNode

//#UC START# *45F554750213impl*
//#UC END# *45F554750213impl*

end.