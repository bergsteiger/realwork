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
   action: Boolean;
  public
   constructor make(mask: TFlagMask;
    action: Boolean); reintroduce; virtual;
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
   load_in_one_direction: Boolean;
   counter_deltas: CounterDeltaMap;
   root: ;
   finded_node: FindedNodes;
   changed_layer: Boolean;
   server_data_version: ;
  protected
   notifiers: NotifierSet;
   selected_count: Cardinal;
   nodes: NodeMap;
   last_select: LastSelectMap;
   all_expanded: Boolean;
  private
   procedure calc_from_position(offset: Integer;
    const child_point;
    var current_stub;
    out from: Integer;
    out in_block_position: Cardinal); virtual;
   procedure onedir_calc_from_position(offset: Integer;
    const child_point;
    var current_stub;
    out from: Integer;
    out in_block_position: Cardinal); virtual;
   procedure bidir_calc_from_position(offset: Integer;
    const child_point;
    var current_stub;
    out from: Integer;
    out in_block_position: Cardinal); virtual;
   procedure add_to_loaded(var node: RealNodeBase); virtual;
   procedure load_children(const parent); virtual;
   procedure load_stub_node(var node);
  protected
   function pm_Getactive_changeble: Boolean; virtual;
   procedure pm_Setactive_changeble(aValue: Boolean); virtual;
   procedure pm_Getserver_tree; virtual;
   function pm_Getflags_map: NodeFlagMap; virtual;
   function pm_Getis_changed: Boolean; virtual;
   function pm_Gettree_name: AnsiString; virtual; abstract;
   constructor make; reintroduce; overload; virtual;
   function get_load_block_half_size: Integer; virtual;
   procedure set_load_block_half_size(new_size: Integer); virtual;
   function is_load_in_one_direction: Boolean; virtual;
   procedure set_load_in_one_direction(yes: Boolean); virtual;
   function master_tree: TreeBase; virtual;
   function alloc_new_node(const snode): DefaultNodeBase; virtual; abstract;
   function alloc_new_view: ViewBase; virtual; abstract;
   procedure clear; virtual;
   procedure safety_remove; virtual;
   function changed_layer(new_val: Boolean): Boolean; virtual;
   procedure dump_flags_map(context: PAnsiChar); virtual;
   procedure apply_delta_postprocess(var fake); virtual;
    {* [timestamp_sync] }
  public
   constructor make(active_changeable: Boolean); reintroduce; overload; virtual;
   function is_loaded_node(const node_pointer): Boolean; virtual;
   procedure adapter_filters_to_server(var adap: IFilterList;
    var serv); virtual;
   procedure flush_counter_delta; virtual;
   procedure root; virtual;
   function get_last_selected(flag: TFlagMask): DefaultNodeBase; virtual;
   procedure update_counters(node: FlagNodeBase;
    flag: TFlagMask;
    value: Boolean); virtual;
   function get_children_flags_count(node: FlagNodeBase;
    flag: TFlagMask): Cardinal; virtual;
   function get_all_flags_count(node: FlagNodeBase;
    flag: TFlagMask): Cardinal; virtual;
   procedure pointer_path_to_index_path(const pointer_path); virtual;
   procedure pointer_to_index_path(const pointer); virtual;
   procedure name_path_to_index_path(const name_path); virtual;
   procedure server_data_version; virtual;
   procedure add_notifier(var root;
    var notifier: INodeNotifier); virtual;
   procedure remove_notifier(var root;
    var notifier: INodeNotifier); virtual;
   procedure create_view(const root;
    const filter;
    shared_flags: TFlagMask;
    const sync_node;
    out sync_index: TVisibleIndex;
    levels: unsigned integer;
    unfiltered: Boolean;
    auto_open: Boolean;
    truncate_this_view: Boolean); virtual;
   procedure pre_find(var filters: IFilterList); virtual;
   function is_relevance_search_supported: Boolean; virtual;
   procedure get_first_fit(const from_node;
    var filter: IFilterList); virtual;
   procedure find(const find_from;
    var filter: IFilterList); virtual;
   function is_mode(shared_flags: TFlagMask): Boolean; virtual;
   procedure build_node(const snode;
    var current_stub: FlagNodeBase;
    master_index: Integer); virtual;
   procedure load_nodes_from_server(const parent_point;
    const child_point;
    from: Integer;
    in_block_position: Cardinal;
    var current_stub); virtual; { can raise InvalidOwnerTree }
   function get_shared_mode: TFlagMask; virtual;
   procedure apply_flags(from: FlagNodeBase;
    var to: FlagNodeBase;
    shared_mask: TFlagMask); virtual;
   procedure cache_finded_node(parent: DefaultNodeBase;
    index: Integer;
    var node); virtual;
   procedure invalidate_finded_node(parent: DefaultNodeBase); virtual;
   procedure find_cached_node(parent: DefaultNodeBase;
    out index: Integer); virtual;
   procedure get_available_layers; virtual;
   procedure change_children_count(index: TVisibleIndex;
    delta: Integer;
    var index_path: INodeIndexPath;
    child_index: TIndexInParent); virtual;
   procedure invalidate(const index_path: INodeIndexPath); virtual;
   procedure changing; virtual;
   procedure changed; virtual;
   procedure apply_server_tree(const server_tree); virtual;
   function apply_created_node(const data): RealNodeBase; virtual; abstract;
   procedure find_created_uid(var node: RealNodeBase); virtual; abstract;
   procedure associate_node_with_uid(var node: RealNodeBase); virtual; abstract;
   procedure disassociate_node_with_uid(var node: RealNodeBase); virtual; abstract;
   procedure get_cached_server_tree; virtual;
   function is_all_expanded: Boolean; virtual;
   procedure expand_all(expand: Boolean); virtual;
   function is_root_visible: Boolean; virtual;
   procedure reset_children_count; virtual;
   procedure reset_by_server_tree(const new_tree); virtual;
   procedure reset_by_root(new_root_ch_count: Cardinal); virtual;
   procedure set_changed(state: Boolean); virtual;
   function get_change_mutex: mutex; virtual; abstract;
   function is_root_nil: Boolean; virtual;
   procedure root_is_dead; virtual;
    {* used by RealNodeRoot::delete_obj ONLY }
   procedure load_all_tree; virtual;
    {* прогружает дерево целиком. см. http://mdp.garant.ru/pages/viewpage.action?pageId=17334971 }
  protected
   property active_changeble: Boolean
    read pm_Getactive_changeble
    write pm_Setactive_changeble;
  public
   property server_tree: 
    read pm_Getserver_tree;
   property flags_map: NodeFlagMap
    read pm_Getflags_map;
   property is_changed: Boolean
    read pm_Getis_changed;
   property tree_name: AnsiString
    read pm_Gettree_name;
 //#UC START# *45F554750213publ*
 //#UC END# *45F554750213publ*
 end;//TreeBase

implementation

uses
 l3ImplUses
 , ApplicationHelper
 , SecurityUnit
 , ServerAdapterConverters
;

type
 NodeExpander = {final} class
  private
   all_expanded: Boolean;
   expand_root: Boolean;
  public
   constructor make(all_expanded: Boolean;
    expand_root: Boolean); reintroduce; virtual;
   procedure each_func(var static_node;
    out dummy: integer); virtual;
 end;//NodeExpander

constructor NodeExpander.make(all_expanded: Boolean;
 expand_root: Boolean);
//#UC START# *45F55B100186_45F55AA303B9_var*
//#UC END# *45F55B100186_45F55AA303B9_var*
begin
//#UC START# *45F55B100186_45F55AA303B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F55B100186_45F55AA303B9_impl*
end;//NodeExpander.make

procedure NodeExpander.each_func(var static_node;
 out dummy: integer);
//#UC START# *45F55B5A03B9_45F55AA303B9_var*
//#UC END# *45F55B5A03B9_45F55AA303B9_var*
begin
//#UC START# *45F55B5A03B9_45F55AA303B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F55B5A03B9_45F55AA303B9_impl*
end;//NodeExpander.each_func

constructor FlagMaskStubPostProcess.make(mask: TFlagMask;
 action: Boolean);
//#UC START# *46013DEC02CE_46013DB90157_var*
//#UC END# *46013DEC02CE_46013DB90157_var*
begin
//#UC START# *46013DEC02CE_46013DB90157_impl*
 !!! Needs to be implemented !!!
//#UC END# *46013DEC02CE_46013DB90157_impl*
end;//FlagMaskStubPostProcess.make

//#UC START# *46013DB90157impl*
//#UC END# *46013DB90157impl*

function TreeBase.pm_Getactive_changeble: Boolean;
//#UC START# *46013A67007D_45F554750213get_var*
//#UC END# *46013A67007D_45F554750213get_var*
begin
//#UC START# *46013A67007D_45F554750213get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46013A67007D_45F554750213get_impl*
end;//TreeBase.pm_Getactive_changeble

procedure TreeBase.pm_Setactive_changeble(aValue: Boolean);
//#UC START# *46013A67007D_45F554750213set_var*
//#UC END# *46013A67007D_45F554750213set_var*
begin
//#UC START# *46013A67007D_45F554750213set_impl*
 !!! Needs to be implemented !!!
//#UC END# *46013A67007D_45F554750213set_impl*
end;//TreeBase.pm_Setactive_changeble

procedure TreeBase.pm_Getserver_tree;
//#UC START# *46013AE00271_45F554750213get_var*
//#UC END# *46013AE00271_45F554750213get_var*
begin
//#UC START# *46013AE00271_45F554750213get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46013AE00271_45F554750213get_impl*
end;//TreeBase.pm_Getserver_tree

function TreeBase.pm_Getflags_map: NodeFlagMap;
//#UC START# *46013B1601E4_45F554750213get_var*
//#UC END# *46013B1601E4_45F554750213get_var*
begin
//#UC START# *46013B1601E4_45F554750213get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46013B1601E4_45F554750213get_impl*
end;//TreeBase.pm_Getflags_map

function TreeBase.pm_Getis_changed: Boolean;
//#UC START# *46013B4B0251_45F554750213get_var*
//#UC END# *46013B4B0251_45F554750213get_var*
begin
//#UC START# *46013B4B0251_45F554750213get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46013B4B0251_45F554750213get_impl*
end;//TreeBase.pm_Getis_changed

constructor TreeBase.make(active_changeable: Boolean);
//#UC START# *45F56FDC0271_45F554750213_var*
//#UC END# *45F56FDC0271_45F554750213_var*
begin
//#UC START# *45F56FDC0271_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F56FDC0271_45F554750213_impl*
end;//TreeBase.make

constructor TreeBase.make;
//#UC START# *46011A0C0109_45F554750213_var*
//#UC END# *46011A0C0109_45F554750213_var*
begin
//#UC START# *46011A0C0109_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011A0C0109_45F554750213_impl*
end;//TreeBase.make

procedure TreeBase.calc_from_position(offset: Integer;
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
end;//TreeBase.calc_from_position

procedure TreeBase.onedir_calc_from_position(offset: Integer;
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
end;//TreeBase.onedir_calc_from_position

procedure TreeBase.bidir_calc_from_position(offset: Integer;
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
end;//TreeBase.bidir_calc_from_position

function TreeBase.get_load_block_half_size: Integer;
//#UC START# *4601194C037A_45F554750213_var*
//#UC END# *4601194C037A_45F554750213_var*
begin
//#UC START# *4601194C037A_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601194C037A_45F554750213_impl*
end;//TreeBase.get_load_block_half_size

procedure TreeBase.set_load_block_half_size(new_size: Integer);
//#UC START# *4601195B02AF_45F554750213_var*
//#UC END# *4601195B02AF_45F554750213_var*
begin
//#UC START# *4601195B02AF_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601195B02AF_45F554750213_impl*
end;//TreeBase.set_load_block_half_size

function TreeBase.is_load_in_one_direction: Boolean;
//#UC START# *4601197B01F4_45F554750213_var*
//#UC END# *4601197B01F4_45F554750213_var*
begin
//#UC START# *4601197B01F4_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601197B01F4_45F554750213_impl*
end;//TreeBase.is_load_in_one_direction

procedure TreeBase.set_load_in_one_direction(yes: Boolean);
//#UC START# *460119830119_45F554750213_var*
//#UC END# *460119830119_45F554750213_var*
begin
//#UC START# *460119830119_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460119830119_45F554750213_impl*
end;//TreeBase.set_load_in_one_direction

function TreeBase.is_loaded_node(const node_pointer): Boolean;
//#UC START# *46011A2B0203_45F554750213_var*
//#UC END# *46011A2B0203_45F554750213_var*
begin
//#UC START# *46011A2B0203_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011A2B0203_45F554750213_impl*
end;//TreeBase.is_loaded_node

procedure TreeBase.adapter_filters_to_server(var adap: IFilterList;
 var serv);
//#UC START# *46011A8101C5_45F554750213_var*
//#UC END# *46011A8101C5_45F554750213_var*
begin
//#UC START# *46011A8101C5_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011A8101C5_45F554750213_impl*
end;//TreeBase.adapter_filters_to_server

procedure TreeBase.flush_counter_delta;
//#UC START# *46011C9A0157_45F554750213_var*
//#UC END# *46011C9A0157_45F554750213_var*
begin
//#UC START# *46011C9A0157_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011C9A0157_45F554750213_impl*
end;//TreeBase.flush_counter_delta

procedure TreeBase.root;
//#UC START# *46011CA602DE_45F554750213_var*
//#UC END# *46011CA602DE_45F554750213_var*
begin
//#UC START# *46011CA602DE_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011CA602DE_45F554750213_impl*
end;//TreeBase.root

function TreeBase.get_last_selected(flag: TFlagMask): DefaultNodeBase;
//#UC START# *46011CB9002E_45F554750213_var*
//#UC END# *46011CB9002E_45F554750213_var*
begin
//#UC START# *46011CB9002E_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011CB9002E_45F554750213_impl*
end;//TreeBase.get_last_selected

procedure TreeBase.update_counters(node: FlagNodeBase;
 flag: TFlagMask;
 value: Boolean);
//#UC START# *46011CE503A9_45F554750213_var*
//#UC END# *46011CE503A9_45F554750213_var*
begin
//#UC START# *46011CE503A9_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011CE503A9_45F554750213_impl*
end;//TreeBase.update_counters

function TreeBase.get_children_flags_count(node: FlagNodeBase;
 flag: TFlagMask): Cardinal;
//#UC START# *46011D100242_45F554750213_var*
//#UC END# *46011D100242_45F554750213_var*
begin
//#UC START# *46011D100242_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011D100242_45F554750213_impl*
end;//TreeBase.get_children_flags_count

function TreeBase.get_all_flags_count(node: FlagNodeBase;
 flag: TFlagMask): Cardinal;
//#UC START# *46011D4001A5_45F554750213_var*
//#UC END# *46011D4001A5_45F554750213_var*
begin
//#UC START# *46011D4001A5_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011D4001A5_45F554750213_impl*
end;//TreeBase.get_all_flags_count

procedure TreeBase.pointer_path_to_index_path(const pointer_path);
//#UC START# *46011D5D00EA_45F554750213_var*
//#UC END# *46011D5D00EA_45F554750213_var*
begin
//#UC START# *46011D5D00EA_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011D5D00EA_45F554750213_impl*
end;//TreeBase.pointer_path_to_index_path

procedure TreeBase.pointer_to_index_path(const pointer);
//#UC START# *46011DEE0148_45F554750213_var*
//#UC END# *46011DEE0148_45F554750213_var*
begin
//#UC START# *46011DEE0148_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011DEE0148_45F554750213_impl*
end;//TreeBase.pointer_to_index_path

procedure TreeBase.name_path_to_index_path(const name_path);
//#UC START# *46011E200290_45F554750213_var*
//#UC END# *46011E200290_45F554750213_var*
begin
//#UC START# *46011E200290_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011E200290_45F554750213_impl*
end;//TreeBase.name_path_to_index_path

procedure TreeBase.server_data_version;
//#UC START# *46011E5F031C_45F554750213_var*
//#UC END# *46011E5F031C_45F554750213_var*
begin
//#UC START# *46011E5F031C_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011E5F031C_45F554750213_impl*
end;//TreeBase.server_data_version

procedure TreeBase.add_notifier(var root;
 var notifier: INodeNotifier);
//#UC START# *46011F130203_45F554750213_var*
//#UC END# *46011F130203_45F554750213_var*
begin
//#UC START# *46011F130203_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011F130203_45F554750213_impl*
end;//TreeBase.add_notifier

procedure TreeBase.remove_notifier(var root;
 var notifier: INodeNotifier);
//#UC START# *46011F2C005D_45F554750213_var*
//#UC END# *46011F2C005D_45F554750213_var*
begin
//#UC START# *46011F2C005D_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011F2C005D_45F554750213_impl*
end;//TreeBase.remove_notifier

procedure TreeBase.create_view(const root;
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
end;//TreeBase.create_view

procedure TreeBase.pre_find(var filters: IFilterList);
//#UC START# *460120C9005D_45F554750213_var*
//#UC END# *460120C9005D_45F554750213_var*
begin
//#UC START# *460120C9005D_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460120C9005D_45F554750213_impl*
end;//TreeBase.pre_find

function TreeBase.is_relevance_search_supported: Boolean;
//#UC START# *4601213B0000_45F554750213_var*
//#UC END# *4601213B0000_45F554750213_var*
begin
//#UC START# *4601213B0000_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601213B0000_45F554750213_impl*
end;//TreeBase.is_relevance_search_supported

procedure TreeBase.get_first_fit(const from_node;
 var filter: IFilterList);
//#UC START# *460121C103B9_45F554750213_var*
//#UC END# *460121C103B9_45F554750213_var*
begin
//#UC START# *460121C103B9_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460121C103B9_45F554750213_impl*
end;//TreeBase.get_first_fit

procedure TreeBase.find(const find_from;
 var filter: IFilterList);
//#UC START# *460121EC029F_45F554750213_var*
//#UC END# *460121EC029F_45F554750213_var*
begin
//#UC START# *460121EC029F_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460121EC029F_45F554750213_impl*
end;//TreeBase.find

function TreeBase.is_mode(shared_flags: TFlagMask): Boolean;
//#UC START# *4601221600DA_45F554750213_var*
//#UC END# *4601221600DA_45F554750213_var*
begin
//#UC START# *4601221600DA_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601221600DA_45F554750213_impl*
end;//TreeBase.is_mode

procedure TreeBase.build_node(const snode;
 var current_stub: FlagNodeBase;
 master_index: Integer);
//#UC START# *46012315033C_45F554750213_var*
//#UC END# *46012315033C_45F554750213_var*
begin
//#UC START# *46012315033C_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012315033C_45F554750213_impl*
end;//TreeBase.build_node

procedure TreeBase.load_nodes_from_server(const parent_point;
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
end;//TreeBase.load_nodes_from_server

function TreeBase.get_shared_mode: TFlagMask;
//#UC START# *4601240A033C_45F554750213_var*
//#UC END# *4601240A033C_45F554750213_var*
begin
//#UC START# *4601240A033C_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601240A033C_45F554750213_impl*
end;//TreeBase.get_shared_mode

procedure TreeBase.apply_flags(from: FlagNodeBase;
 var to: FlagNodeBase;
 shared_mask: TFlagMask);
//#UC START# *460124430251_45F554750213_var*
//#UC END# *460124430251_45F554750213_var*
begin
//#UC START# *460124430251_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460124430251_45F554750213_impl*
end;//TreeBase.apply_flags

procedure TreeBase.cache_finded_node(parent: DefaultNodeBase;
 index: Integer;
 var node);
//#UC START# *4601246F032C_45F554750213_var*
//#UC END# *4601246F032C_45F554750213_var*
begin
//#UC START# *4601246F032C_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601246F032C_45F554750213_impl*
end;//TreeBase.cache_finded_node

procedure TreeBase.invalidate_finded_node(parent: DefaultNodeBase);
//#UC START# *46012495038A_45F554750213_var*
//#UC END# *46012495038A_45F554750213_var*
begin
//#UC START# *46012495038A_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012495038A_45F554750213_impl*
end;//TreeBase.invalidate_finded_node

procedure TreeBase.find_cached_node(parent: DefaultNodeBase;
 out index: Integer);
//#UC START# *460124AA0271_45F554750213_var*
//#UC END# *460124AA0271_45F554750213_var*
begin
//#UC START# *460124AA0271_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460124AA0271_45F554750213_impl*
end;//TreeBase.find_cached_node

procedure TreeBase.get_available_layers;
//#UC START# *460124CD03C8_45F554750213_var*
//#UC END# *460124CD03C8_45F554750213_var*
begin
//#UC START# *460124CD03C8_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460124CD03C8_45F554750213_impl*
end;//TreeBase.get_available_layers

procedure TreeBase.change_children_count(index: TVisibleIndex;
 delta: Integer;
 var index_path: INodeIndexPath;
 child_index: TIndexInParent);
//#UC START# *460124F5001F_45F554750213_var*
//#UC END# *460124F5001F_45F554750213_var*
begin
//#UC START# *460124F5001F_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460124F5001F_45F554750213_impl*
end;//TreeBase.change_children_count

procedure TreeBase.invalidate(const index_path: INodeIndexPath);
//#UC START# *4601253B0261_45F554750213_var*
//#UC END# *4601253B0261_45F554750213_var*
begin
//#UC START# *4601253B0261_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601253B0261_45F554750213_impl*
end;//TreeBase.invalidate

procedure TreeBase.changing;
//#UC START# *4601254A0186_45F554750213_var*
//#UC END# *4601254A0186_45F554750213_var*
begin
//#UC START# *4601254A0186_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601254A0186_45F554750213_impl*
end;//TreeBase.changing

procedure TreeBase.changed;
//#UC START# *4601255202FD_45F554750213_var*
//#UC END# *4601255202FD_45F554750213_var*
begin
//#UC START# *4601255202FD_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601255202FD_45F554750213_impl*
end;//TreeBase.changed

procedure TreeBase.apply_server_tree(const server_tree);
//#UC START# *4601257D0148_45F554750213_var*
//#UC END# *4601257D0148_45F554750213_var*
begin
//#UC START# *4601257D0148_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601257D0148_45F554750213_impl*
end;//TreeBase.apply_server_tree

procedure TreeBase.get_cached_server_tree;
//#UC START# *46012710030D_45F554750213_var*
//#UC END# *46012710030D_45F554750213_var*
begin
//#UC START# *46012710030D_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012710030D_45F554750213_impl*
end;//TreeBase.get_cached_server_tree

procedure TreeBase.add_to_loaded(var node: RealNodeBase);
//#UC START# *460127420261_45F554750213_var*
//#UC END# *460127420261_45F554750213_var*
begin
//#UC START# *460127420261_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127420261_45F554750213_impl*
end;//TreeBase.add_to_loaded

function TreeBase.is_all_expanded: Boolean;
//#UC START# *460127560148_45F554750213_var*
//#UC END# *460127560148_45F554750213_var*
begin
//#UC START# *460127560148_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127560148_45F554750213_impl*
end;//TreeBase.is_all_expanded

procedure TreeBase.expand_all(expand: Boolean);
//#UC START# *460127560261_45F554750213_var*
//#UC END# *460127560261_45F554750213_var*
begin
//#UC START# *460127560261_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127560261_45F554750213_impl*
end;//TreeBase.expand_all

function TreeBase.is_root_visible: Boolean;
//#UC START# *46012775000F_45F554750213_var*
//#UC END# *46012775000F_45F554750213_var*
begin
//#UC START# *46012775000F_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012775000F_45F554750213_impl*
end;//TreeBase.is_root_visible

function TreeBase.master_tree: TreeBase;
//#UC START# *46012787038A_45F554750213_var*
//#UC END# *46012787038A_45F554750213_var*
begin
//#UC START# *46012787038A_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012787038A_45F554750213_impl*
end;//TreeBase.master_tree

procedure TreeBase.clear;
//#UC START# *460127F2000F_45F554750213_var*
//#UC END# *460127F2000F_45F554750213_var*
begin
//#UC START# *460127F2000F_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127F2000F_45F554750213_impl*
end;//TreeBase.clear

procedure TreeBase.safety_remove;
//#UC START# *460127F90186_45F554750213_var*
//#UC END# *460127F90186_45F554750213_var*
begin
//#UC START# *460127F90186_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127F90186_45F554750213_impl*
end;//TreeBase.safety_remove

procedure TreeBase.reset_children_count;
//#UC START# *46CD73470203_45F554750213_var*
//#UC END# *46CD73470203_45F554750213_var*
begin
//#UC START# *46CD73470203_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46CD73470203_45F554750213_impl*
end;//TreeBase.reset_children_count

function TreeBase.changed_layer(new_val: Boolean): Boolean;
//#UC START# *46012801002E_45F554750213_var*
//#UC END# *46012801002E_45F554750213_var*
begin
//#UC START# *46012801002E_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012801002E_45F554750213_impl*
end;//TreeBase.changed_layer

procedure TreeBase.dump_flags_map(context: PAnsiChar);
//#UC START# *4601281502FD_45F554750213_var*
//#UC END# *4601281502FD_45F554750213_var*
begin
//#UC START# *4601281502FD_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601281502FD_45F554750213_impl*
end;//TreeBase.dump_flags_map

procedure TreeBase.reset_by_server_tree(const new_tree);
//#UC START# *4601284400DA_45F554750213_var*
//#UC END# *4601284400DA_45F554750213_var*
begin
//#UC START# *4601284400DA_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601284400DA_45F554750213_impl*
end;//TreeBase.reset_by_server_tree

procedure TreeBase.reset_by_root(new_root_ch_count: Cardinal);
//#UC START# *4601287803D8_45F554750213_var*
//#UC END# *4601287803D8_45F554750213_var*
begin
//#UC START# *4601287803D8_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601287803D8_45F554750213_impl*
end;//TreeBase.reset_by_root

procedure TreeBase.set_changed(state: Boolean);
//#UC START# *46012899005D_45F554750213_var*
//#UC END# *46012899005D_45F554750213_var*
begin
//#UC START# *46012899005D_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012899005D_45F554750213_impl*
end;//TreeBase.set_changed

procedure TreeBase.apply_delta_postprocess(var fake);
 {* [timestamp_sync] }
//#UC START# *4601391C032C_45F554750213_var*
//#UC END# *4601391C032C_45F554750213_var*
begin
//#UC START# *4601391C032C_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601391C032C_45F554750213_impl*
end;//TreeBase.apply_delta_postprocess

function TreeBase.is_root_nil: Boolean;
//#UC START# *460139FF0128_45F554750213_var*
//#UC END# *460139FF0128_45F554750213_var*
begin
//#UC START# *460139FF0128_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *460139FF0128_45F554750213_impl*
end;//TreeBase.is_root_nil

procedure TreeBase.root_is_dead;
 {* used by RealNodeRoot::delete_obj ONLY }
//#UC START# *46013A110290_45F554750213_var*
//#UC END# *46013A110290_45F554750213_var*
begin
//#UC START# *46013A110290_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *46013A110290_45F554750213_impl*
end;//TreeBase.root_is_dead

procedure TreeBase.load_all_tree;
 {* прогружает дерево целиком. см. http://mdp.garant.ru/pages/viewpage.action?pageId=17334971 }
//#UC START# *466956AA02DE_45F554750213_var*
//#UC END# *466956AA02DE_45F554750213_var*
begin
//#UC START# *466956AA02DE_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *466956AA02DE_45F554750213_impl*
end;//TreeBase.load_all_tree

procedure TreeBase.load_children(const parent);
//#UC START# *466957D20290_45F554750213_var*
//#UC END# *466957D20290_45F554750213_var*
begin
//#UC START# *466957D20290_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *466957D20290_45F554750213_impl*
end;//TreeBase.load_children

procedure TreeBase.load_stub_node(var node);
//#UC START# *4755759F0391_45F554750213_var*
//#UC END# *4755759F0391_45F554750213_var*
begin
//#UC START# *4755759F0391_45F554750213_impl*
 !!! Needs to be implemented !!!
//#UC END# *4755759F0391_45F554750213_impl*
end;//TreeBase.load_stub_node

//#UC START# *45F554750213impl*
//#UC END# *45F554750213impl*

end.
