unit reeBase;
 {* адаптерное дерево }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\reeBase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TreeBase" MUID: (45F554750213)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , ActiveChangeableBase
 , DynamicTreeUnit
 , DefaultNodeBase
 , DynamicTreeDefinesUnit
 , RealNodeBase
 , ViewBase
 , FlagNodeBase
 //#UC START# *45F554750213intf_uses*
 //#UC END# *45F554750213intf_uses*
;

type
 ViewBase = class;

 RealNodeBase = class;

 DefaultNodeBase = class;

 InvalidOwnerTree = class
 end;//InvalidOwnerTree

 EmptyBranch = class
 end;//EmptyBranch

 FindedData = record
  index: Integer;
  node: ;
 end;//FindedData

 // CountMap

 // NodeFlagMap

 // NotifierSet

 // CounterDeltaMap

 // FindedNodes

 // LastSelectMap

 // NodeMap

 //#UC START# *46013DB90157ci*
 //#UC END# *46013DB90157ci*
 //#UC START# *46013DB90157cit*
 //#UC END# *46013DB90157cit*
 FlagMaskStubPostProcess = class
  private
   mask: TFlagMask;
   action: ByteBool;
  public
   constructor Make(mask: TFlagMask;
    action: Boolean); reintroduce; virtual; stdcall;
 //#UC START# *46013DB90157publ*
 //#UC END# *46013DB90157publ*
 end;//FlagMaskStubPostProcess

 //#UC START# *45F554750213ci*
 //#UC END# *45F554750213ci*
 //#UC START# *45F554750213cit*
 //#UC END# *45F554750213cit*
 TreeBase = {abstract} class(ActiveChangeableBase, IFakeFacetForFactory)
  {* адаптерное дерево }
  private
   load_block_half_size: Integer;
   load_in_one_direction: ByteBool;
   counter_deltas: CounterDeltaMap;
   root: ;
   finded_node: FindedNodes;
   changed_layer: ByteBool;
   server_data_version: ;
  protected
   notifiers: NotifierSet;
   selected_count: Cardinal;
   nodes: NodeMap;
   last_select: LastSelectMap;
   all_expanded: ByteBool;
  private
   procedure CalcFromPosition(offset: Integer;
    const child_point;
    var current_stub;
    out from: Integer;
    out in_block_position: Cardinal); virtual; stdcall;
   procedure OnedirCalcFromPosition(offset: Integer;
    const child_point;
    var current_stub;
    out from: Integer;
    out in_block_position: Cardinal); virtual; stdcall;
   procedure BidirCalcFromPosition(offset: Integer;
    const child_point;
    var current_stub;
    out from: Integer;
    out in_block_position: Cardinal); virtual; stdcall;
   procedure AddToLoaded(var node: RealNodeBase); virtual; stdcall;
   procedure LoadChildren(const parent); virtual; stdcall;
   procedure LoadStubNode(var node); stdcall;
  protected
   function GetActiveChangeble: ByteBool; virtual; stdcall;
   procedure SetActiveChangeble(const aValue: ByteBool); virtual; stdcall;
   procedure GetServerTree; virtual; stdcall;
   function GetFlagsMap: NodeFlagMap; virtual; stdcall;
   function GetIsChanged: ByteBool; virtual; stdcall;
   function GetTreeName: AnsiString; virtual; abstract; stdcall;
   constructor Make; reintroduce; overload; virtual; stdcall;
   function GetLoadBlockHalfSize: Integer; virtual; stdcall;
   procedure SetLoadBlockHalfSize(new_size: Integer); virtual; stdcall;
   function IsLoadInOneDirection: ByteBool; virtual; stdcall;
   procedure SetLoadInOneDirection(yes: Boolean); virtual; stdcall;
   function MasterTree: TreeBase; virtual; stdcall;
   function AllocNewNode(const snode): DefaultNodeBase; virtual; abstract; stdcall;
   function AllocNewView: ViewBase; virtual; abstract; stdcall;
   procedure Clear; virtual; stdcall;
   procedure SafetyRemove; virtual; stdcall;
   function ChangedLayer(new_val: Boolean): ByteBool; virtual; stdcall;
   procedure DumpFlagsMap(context: PAnsiChar); virtual; stdcall;
   procedure ApplyDeltaPostprocess(var fake); virtual; stdcall;
    {* [timestamp_sync] }
  public
   constructor Make(active_changeable: Boolean); reintroduce; overload; virtual; stdcall;
   function IsLoadedNode(const node_pointer): ByteBool; virtual; stdcall;
   procedure AdapterFiltersToServer(var adap: IFilterList;
    var serv); virtual; stdcall;
   procedure FlushCounterDelta; virtual; stdcall;
   procedure Root; virtual; stdcall;
   function GetLastSelected(flag: TFlagMask): DefaultNodeBase; virtual; stdcall;
   procedure UpdateCounters(node: FlagNodeBase;
    flag: TFlagMask;
    value: Boolean); virtual; stdcall;
   function GetChildrenFlagsCount(node: FlagNodeBase;
    flag: TFlagMask): Cardinal; virtual; stdcall;
   function GetAllFlagsCount(node: FlagNodeBase;
    flag: TFlagMask): Cardinal; virtual; stdcall;
   procedure PointerPathToIndexPath(const pointer_path); virtual; stdcall;
   procedure PointerToIndexPath(const pointer); virtual; stdcall;
   procedure NamePathToIndexPath(const name_path); virtual; stdcall;
   procedure ServerDataVersion; virtual; stdcall;
   procedure AddNotifier(var root;
    var notifier: INodeNotifier); virtual; stdcall;
   procedure RemoveNotifier(var root;
    var notifier: INodeNotifier); virtual; stdcall;
   procedure CreateView(const root;
    const filter;
    shared_flags: TFlagMask;
    const sync_node;
    out sync_index: TVisibleIndex;
    levels: unsigned integer;
    unfiltered: Boolean;
    auto_open: Boolean;
    truncate_this_view: Boolean); virtual; stdcall;
   procedure PreFind(var filters: IFilterList); virtual; stdcall;
   function IsRelevanceSearchSupported: ByteBool; virtual; stdcall;
   procedure GetFirstFit(const from_node;
    var filter: IFilterList); virtual; stdcall;
   procedure Find(const find_from;
    var filter: IFilterList); virtual; stdcall;
   function IsMode(shared_flags: TFlagMask): ByteBool; virtual; stdcall;
   procedure BuildNode(const snode;
    var current_stub: FlagNodeBase;
    master_index: Integer); virtual; stdcall;
   procedure LoadNodesFromServer(const parent_point;
    const child_point;
    from: Integer;
    in_block_position: Cardinal;
    var current_stub); virtual; stdcall; { can raise InvalidOwnerTree }
   function GetSharedMode: TFlagMask; virtual; stdcall;
   procedure ApplyFlags(from: FlagNodeBase;
    var to: FlagNodeBase;
    shared_mask: TFlagMask); virtual; stdcall;
   procedure CacheFindedNode(parent: DefaultNodeBase;
    index: Integer;
    var node); virtual; stdcall;
   procedure InvalidateFindedNode(parent: DefaultNodeBase); virtual; stdcall;
   procedure FindCachedNode(parent: DefaultNodeBase;
    out index: Integer); virtual; stdcall;
   procedure GetAvailableLayers; virtual; stdcall;
   procedure ChangeChildrenCount(index: TVisibleIndex;
    delta: Integer;
    var index_path: INodeIndexPath;
    child_index: TIndexInParent); virtual; stdcall;
   procedure Invalidate(const index_path: INodeIndexPath); virtual; stdcall;
   procedure Changing; virtual; stdcall;
   procedure Changed; virtual; stdcall;
   procedure ApplyServerTree(const server_tree); virtual; stdcall;
   function ApplyCreatedNode(const data): RealNodeBase; virtual; abstract; stdcall;
   procedure FindCreatedUid(var node: RealNodeBase); virtual; abstract; stdcall;
   procedure AssociateNodeWithUid(var node: RealNodeBase); virtual; abstract; stdcall;
   procedure DisassociateNodeWithUid(var node: RealNodeBase); virtual; abstract; stdcall;
   procedure GetCachedServerTree; virtual; stdcall;
   function IsAllExpanded: ByteBool; virtual; stdcall;
   procedure ExpandAll(expand: Boolean); virtual; stdcall;
   function IsRootVisible: ByteBool; virtual; stdcall;
   procedure ResetChildrenCount; virtual; stdcall;
   procedure ResetByServerTree(const new_tree); virtual; stdcall;
   procedure ResetByRoot(new_root_ch_count: Cardinal); virtual; stdcall;
   procedure SetChanged(state: Boolean); virtual; stdcall;
   function GetChangeMutex: mutex; virtual; abstract; stdcall;
   function IsRootNil: ByteBool; virtual; stdcall;
   procedure RootIsDead; virtual; stdcall;
    {* used by RealNodeRoot::delete_obj ONLY }
   procedure LoadAllTree; virtual; stdcall;
    {* прогружает дерево целиком. см. http://mdp.garant.ru/pages/viewpage.action?pageId=17334971 }
  protected
   property ActiveChangeble: ByteBool
    read GetActiveChangeble
    write SetActiveChangeble;
  public
   property ServerTree: 
    read GetServerTree;
   property FlagsMap: NodeFlagMap
    read GetFlagsMap;
   property IsChanged: ByteBool
    read GetIsChanged;
   property TreeName: AnsiString
    read GetTreeName;
 //#UC START# *45F554750213publ*
 //#UC END# *45F554750213publ*
 end;//TreeBase

implementation

uses
 l3ImplUses
 , DelegateNodeBase
 , ApplicationHelper
 , SecurityUnit
 , ServerAdapterConverters
 //#UC START# *45F554750213impl_uses*
 //#UC END# *45F554750213impl_uses*
;

type
 NodeExpander = {final} class
  private
   all_expanded: ByteBool;
   expand_root: ByteBool;
  public
   constructor Make(all_expanded: Boolean;
    expand_root: Boolean); reintroduce; virtual; stdcall;
   procedure EachFunc(var static_node;
    out dummy: integer); virtual; stdcall;
 end;//NodeExpander

 RealNodeBaseFriend = {abstract} class(RealNodeBase)
  {* Друг к классу RealNodeBase }
 end;//RealNodeBaseFriend

 DelegateNodeBaseFriend = {abstract} class(DelegateNodeBase)
  {* Друг к классу DelegateNodeBase }
 end;//DelegateNodeBaseFriend

 DefaultNodeBaseFriend = {abstract} class(DefaultNodeBase)
  {* Друг к классу DefaultNodeBase }
 end;//DefaultNodeBaseFriend

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

function TreeBase.GetActiveChangeble: ByteBool;
//#UC START# *46013A67007D_45F554750213get_var*
//#UC END# *46013A67007D_45F554750213get_var*
begin
//#UC START# *46013A67007D_45F554750213get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46013A67007D_45F554750213get_impl*
end;//TreeBase.GetActiveChangeble

procedure TreeBase.SetActiveChangeble(const aValue: ByteBool);
//#UC START# *46013A67007D_45F554750213set_var*
//#UC END# *46013A67007D_45F554750213set_var*
begin
//#UC START# *46013A67007D_45F554750213set_impl*
 !!! Needs to be implemented !!!
//#UC END# *46013A67007D_45F554750213set_impl*
end;//TreeBase.SetActiveChangeble

procedure TreeBase.GetServerTree;
//#UC START# *46013AE00271_45F554750213get_var*
//#UC END# *46013AE00271_45F554750213get_var*
begin
//#UC START# *46013AE00271_45F554750213get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46013AE00271_45F554750213get_impl*
end;//TreeBase.GetServerTree

function TreeBase.GetFlagsMap: NodeFlagMap;
//#UC START# *46013B1601E4_45F554750213get_var*
//#UC END# *46013B1601E4_45F554750213get_var*
begin
//#UC START# *46013B1601E4_45F554750213get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46013B1601E4_45F554750213get_impl*
end;//TreeBase.GetFlagsMap

function TreeBase.GetIsChanged: ByteBool;
//#UC START# *46013B4B0251_45F554750213get_var*
//#UC END# *46013B4B0251_45F554750213get_var*
begin
//#UC START# *46013B4B0251_45F554750213get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46013B4B0251_45F554750213get_impl*
end;//TreeBase.GetIsChanged

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
 const child_point;
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
 const child_point;
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
 const child_point;
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

function TreeBase.IsLoadInOneDirection: ByteBool;
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

function TreeBase.IsLoadedNode(const node_pointer): ByteBool;
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

procedure TreeBase.PointerPathToIndexPath(const pointer_path);
//#UC START# *46011D5D00EA_45F554750213_var*
//#UC END# *46011D5D00EA_45F554750213_var*
begin
//#UC START# *46011D5D00EA_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011D5D00EA_45F554750213_impl*
end;//TreeBase.PointerPathToIndexPath

procedure TreeBase.PointerToIndexPath(const pointer);
//#UC START# *46011DEE0148_45F554750213_var*
//#UC END# *46011DEE0148_45F554750213_var*
begin
//#UC START# *46011DEE0148_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011DEE0148_45F554750213_impl*
end;//TreeBase.PointerToIndexPath

procedure TreeBase.NamePathToIndexPath(const name_path);
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

procedure TreeBase.CreateView(const root;
 const filter;
 shared_flags: TFlagMask;
 const sync_node;
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

function TreeBase.IsRelevanceSearchSupported: ByteBool;
//#UC START# *4601213B0000_45F554750213_var*
//#UC END# *4601213B0000_45F554750213_var*
begin
//#UC START# *4601213B0000_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601213B0000_45F554750213_impl*
end;//TreeBase.IsRelevanceSearchSupported

procedure TreeBase.GetFirstFit(const from_node;
 var filter: IFilterList);
//#UC START# *460121C103B9_45F554750213_var*
//#UC END# *460121C103B9_45F554750213_var*
begin
//#UC START# *460121C103B9_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460121C103B9_45F554750213_impl*
end;//TreeBase.GetFirstFit

procedure TreeBase.Find(const find_from;
 var filter: IFilterList);
//#UC START# *460121EC029F_45F554750213_var*
//#UC END# *460121EC029F_45F554750213_var*
begin
//#UC START# *460121EC029F_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460121EC029F_45F554750213_impl*
end;//TreeBase.Find

function TreeBase.IsMode(shared_flags: TFlagMask): ByteBool;
//#UC START# *4601221600DA_45F554750213_var*
//#UC END# *4601221600DA_45F554750213_var*
begin
//#UC START# *4601221600DA_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601221600DA_45F554750213_impl*
end;//TreeBase.IsMode

procedure TreeBase.BuildNode(const snode;
 var current_stub: FlagNodeBase;
 master_index: Integer);
//#UC START# *46012315033C_45F554750213_var*
//#UC END# *46012315033C_45F554750213_var*
begin
//#UC START# *46012315033C_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012315033C_45F554750213_impl*
end;//TreeBase.BuildNode

procedure TreeBase.LoadNodesFromServer(const parent_point;
 const child_point;
 from: Integer;
 in_block_position: Cardinal;
 var current_stub); { can raise InvalidOwnerTree }
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

procedure TreeBase.ApplyServerTree(const server_tree);
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

function TreeBase.IsAllExpanded: ByteBool;
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

function TreeBase.IsRootVisible: ByteBool;
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

function TreeBase.ChangedLayer(new_val: Boolean): ByteBool;
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

procedure TreeBase.ResetByServerTree(const new_tree);
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
 {* [timestamp_sync] }
//#UC START# *4601391C032C_45F554750213_var*
//#UC END# *4601391C032C_45F554750213_var*
begin
//#UC START# *4601391C032C_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601391C032C_45F554750213_impl*
end;//TreeBase.ApplyDeltaPostprocess

function TreeBase.IsRootNil: ByteBool;
//#UC START# *460139FF0128_45F554750213_var*
//#UC END# *460139FF0128_45F554750213_var*
begin
//#UC START# *460139FF0128_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460139FF0128_45F554750213_impl*
end;//TreeBase.IsRootNil

procedure TreeBase.RootIsDead;
 {* used by RealNodeRoot::delete_obj ONLY }
//#UC START# *46013A110290_45F554750213_var*
//#UC END# *46013A110290_45F554750213_var*
begin
//#UC START# *46013A110290_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46013A110290_45F554750213_impl*
end;//TreeBase.RootIsDead

procedure TreeBase.LoadAllTree;
 {* прогружает дерево целиком. см. http://mdp.garant.ru/pages/viewpage.action?pageId=17334971 }
//#UC START# *466956AA02DE_45F554750213_var*
//#UC END# *466956AA02DE_45F554750213_var*
begin
//#UC START# *466956AA02DE_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *466956AA02DE_45F554750213_impl*
end;//TreeBase.LoadAllTree

procedure TreeBase.LoadChildren(const parent);
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
