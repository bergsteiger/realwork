unit DefaultNodeBase;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DefaultNodeBase.pas"
// Стереотип: "SimpleClass"

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
;

type
 //#UC START# *45F7ECA8034Bci*
 //#UC END# *45F7ECA8034Bci*
 //#UC START# *45F7ECA8034Bcit*
 //#UC END# *45F7ECA8034Bcit*
 DefaultNodeBase = {abstract} class(FlagNodeBase)
  private
   class procedure index_path_to_node_path(const path: INodeIndexPath;
    var node_path;
    l: Integer); virtual;
   class procedure print_path(node_to_find: DefaultNodeBase;
    const path: INodeIndexPath); virtual;
   class procedure server_layers_id_list_to_adapter(const srv;
    var adap: ILayerIdList); virtual;
  protected
   function pm_Getchildren_flags: TFlagMask; virtual;
   procedure pm_Setowner_tree(aValue: TreeBase); overload; virtual;
   class function get_real_interface(const node_): DefaultNodeBase; virtual;
   constructor make; reintroduce; overload; virtual;
   procedure invalidate_children_count; virtual;
   procedure create_view_ex(const filter: IFilterList;
    shared_flags: TFlagMask;
    sync_node: DefaultNodeBase;
    out sync_index: TVisibleIndex;
    levels: Cardinal;
    unfiltered: Boolean;
    auto_open: Boolean;
    truncate_this_view: Boolean); virtual;
   function set_range_flag(from: TVisibleIndex;
    to: TVisibleIndex;
    flag: TFlagMask;
    value: Boolean;
    clean_other: Boolean;
    with_notify: Boolean): Boolean; virtual;
   function has_parent_flag(flag: TFlagMask): Boolean; virtual;
   function has_children_flag(flag: TFlagMask): Boolean; virtual;
   function get_flag_count(flag: TFlagMask): Cardinal; virtual;
   function get_first_level_children_flag_count(flag: TFlagMask): Cardinal; virtual;
   procedure set_children_flag(flag: TFlagMask;
    value: Boolean); virtual;
   function find_node_by_interface(const node_to_find: INodeBase): DefaultNodeBase; virtual;
   function find_node(const node_to_find): DefaultNodeBase; virtual;
   function find_node_path(var node_to_find: INodeBase): INodeIndexPath; virtual;
   function get_visible_delta(var node: DefaultNodeBase): TVisibleIndex; overload; virtual;
   function get_visible_delta(const node_path): TVisibleIndex; overload; virtual;
   function get_visible_delta(const entity: IEntityBase): TVisibleIndex; overload; virtual;
   function get_index_from_parent: TVisibleIndex; virtual;
    {* TODO: упростить, выкинув этот метод
ходить только к StaticNode-е }
   function get_abs_index: TVisibleIndex; virtual; { can raise CanNotFindData }
   function get_child_path_by_abs_index(index: TVisibleIndex): INodeIndexPath; virtual; { can raise CanNotFindData }
   procedure add_notifier(var notifier: INodeNotifier); virtual;
   procedure remove_notifier(var notifier: INodeNotifier); virtual;
   function find_stub_for_index(out index: Integer): FlagNodeStub; virtual;
   procedure get_available_layers(var layers: ILayerIdList); virtual;
   function get_first_fit(const filter: IFilterList): INodeIndexPath; virtual;
   function find(const filter: IFilterList;
    const find_from: TNodePosition): IFindIterator; virtual;
   function is_relevance_search_supported: Boolean; virtual;
   function get_node_by_path(const path: INodeIndexPath): INodeBase; virtual;
    {* Дублирует с CatalogBase }
   procedure node_path_to_index_path(const path); virtual;
   procedure entity; virtual; { can raise NoEntity }
   function apply_reset_delta(var delta): Boolean; virtual;
   function apply_change_delta(var delta): Boolean; virtual; abstract;
   function apply_insert_delta(var delta): Boolean; virtual;
   function apply_delete_delta(var delta): Boolean; virtual;
   procedure remove_me_and_siblings(out count: Cardinal); virtual;
   procedure clean; virtual;
   function is_all_expanded: Boolean; virtual;
   procedure expand_all_nodes(expand: Boolean); virtual;
  public
   class procedure srv_path_to_adapter(const index_path;
    var adap_path: INodeIndexPath); virtual;
   class procedure adapter_path_to_srv(const adapter_index_path: INodeIndexPath); virtual;
   constructor make(var owner_tree: TreeBase); reintroduce; overload; virtual;
   procedure get_server_pointer; virtual; abstract;
   function find_node_by_path(const node_path): DefaultNodeBase; overload; virtual;
   function find_node_by_path(const node_index_path): DefaultNodeBase; overload; virtual;
   function find_loaded_node_by_path(const node_index_path): DefaultNodeBase; virtual;
   function get_tree_name: PAnsiChar; virtual;
   function get_settings_root_id: AnsiString; virtual;
   function node_name: PAnsiChar; virtual; abstract;
   procedure server_data_version; virtual;
   procedure get_server_path(const path_type = PT_POINTER); virtual;
   function get_tree_owner: TreeBase; virtual;
   function get_visible_index: TVisibleIndex; virtual;
   function owner_tree: TreeBase; overload; virtual;
   function owner_tree: TreeBase; overload; virtual;
   function set_range_flag_except_first_children_of_root_children(from: TVisibleIndex;
    to: TVisibleIndex;
    flag: TFlagMask;
    value: Boolean;
    clean_other: Boolean;
    with_notify: Boolean): Boolean; virtual;
   procedure set_all_flag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean); override;
   function internal_set_all_flag(flag: TFlagMask;
    value: Boolean;
    children_only: Boolean): size; override;
    {* возвращает количество взведённых (изменённых?) флагов. }
   procedure set_all_flag_except_first_children_of_root_children(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean); override;
   function internal_set_all_flag_except_first_children_of_root_children(flag: TFlagMask;
    value: Boolean;
    children_only: Boolean): size; override;
   function set_flag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean): Boolean; override;
  protected
   property children_flags: TFlagMask
    read pm_Getchildren_flags;
   property owner_tree: TreeBase
    write pm_Setowner_tree;
 //#UC START# *45F7ECA8034Bpubl*
 //#UC END# *45F7ECA8034Bpubl*
 end;//DefaultNodeBase

implementation

uses
 l3ImplUses
 , RealNodeBase
 , ServerAdapterConverters
 , ViewBase
;

function DefaultNodeBase.pm_Getchildren_flags: TFlagMask;
//#UC START# *45F95D2600AB_45F7ECA8034Bget_var*
//#UC END# *45F95D2600AB_45F7ECA8034Bget_var*
begin
//#UC START# *45F95D2600AB_45F7ECA8034Bget_impl*
 Result := f_children_flags
//#UC END# *45F95D2600AB_45F7ECA8034Bget_impl*
end;//DefaultNodeBase.pm_Getchildren_flags

procedure DefaultNodeBase.pm_Setowner_tree(aValue: TreeBase);
//#UC START# *45F9675A000F_45F7ECA8034Bset_var*
//#UC END# *45F9675A000F_45F7ECA8034Bset_var*
begin
//#UC START# *45F9675A000F_45F7ECA8034Bset_impl*
 f_owner_tree := aValue
//#UC END# *45F9675A000F_45F7ECA8034Bset_impl*
end;//DefaultNodeBase.pm_Setowner_tree

class procedure DefaultNodeBase.srv_path_to_adapter(const index_path;
 var adap_path: INodeIndexPath);
//#UC START# *45F945FC02DE_45F7ECA8034B_var*
//#UC END# *45F945FC02DE_45F7ECA8034B_var*
begin
//#UC START# *45F945FC02DE_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F945FC02DE_45F7ECA8034B_impl*
end;//DefaultNodeBase.srv_path_to_adapter

class procedure DefaultNodeBase.adapter_path_to_srv(const adapter_index_path: INodeIndexPath);
//#UC START# *45F9466C003E_45F7ECA8034B_var*
//#UC END# *45F9466C003E_45F7ECA8034B_var*
begin
//#UC START# *45F9466C003E_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9466C003E_45F7ECA8034B_impl*
end;//DefaultNodeBase.adapter_path_to_srv

class procedure DefaultNodeBase.index_path_to_node_path(const path: INodeIndexPath;
 var node_path;
 l: Integer);
//#UC START# *45FA6B180148_45F7ECA8034B_var*
//#UC END# *45FA6B180148_45F7ECA8034B_var*
begin
//#UC START# *45FA6B180148_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FA6B180148_45F7ECA8034B_impl*
end;//DefaultNodeBase.index_path_to_node_path

class procedure DefaultNodeBase.print_path(node_to_find: DefaultNodeBase;
 const path: INodeIndexPath);
//#UC START# *45FA6BAB0109_45F7ECA8034B_var*
//#UC END# *45FA6BAB0109_45F7ECA8034B_var*
begin
//#UC START# *45FA6BAB0109_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FA6BAB0109_45F7ECA8034B_impl*
end;//DefaultNodeBase.print_path

class procedure DefaultNodeBase.server_layers_id_list_to_adapter(const srv;
 var adap: ILayerIdList);
//#UC START# *45FA84E40213_45F7ECA8034B_var*
//#UC END# *45FA84E40213_45F7ECA8034B_var*
begin
//#UC START# *45FA84E40213_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FA84E40213_45F7ECA8034B_impl*
end;//DefaultNodeBase.server_layers_id_list_to_adapter

class function DefaultNodeBase.get_real_interface(const node_): DefaultNodeBase;
//#UC START# *45F94AF8031C_45F7ECA8034B_var*
//#UC END# *45F94AF8031C_45F7ECA8034B_var*
begin
//#UC START# *45F94AF8031C_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94AF8031C_45F7ECA8034B_impl*
end;//DefaultNodeBase.get_real_interface

constructor DefaultNodeBase.make;
//#UC START# *45F94B320109_45F7ECA8034B_var*
//#UC END# *45F94B320109_45F7ECA8034B_var*
begin
//#UC START# *45F94B320109_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94B320109_45F7ECA8034B_impl*
end;//DefaultNodeBase.make

constructor DefaultNodeBase.make(var owner_tree: TreeBase);
//#UC START# *45F94B5D0399_45F7ECA8034B_var*
//#UC END# *45F94B5D0399_45F7ECA8034B_var*
begin
//#UC START# *45F94B5D0399_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94B5D0399_45F7ECA8034B_impl*
end;//DefaultNodeBase.make

function DefaultNodeBase.find_node_by_path(const node_path): DefaultNodeBase;
//#UC START# *45F94BE501E4_45F7ECA8034B_var*
//#UC END# *45F94BE501E4_45F7ECA8034B_var*
begin
//#UC START# *45F94BE501E4_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94BE501E4_45F7ECA8034B_impl*
end;//DefaultNodeBase.find_node_by_path

function DefaultNodeBase.find_node_by_path(const node_index_path): DefaultNodeBase;
//#UC START# *45F94C8E0109_45F7ECA8034B_var*
//#UC END# *45F94C8E0109_45F7ECA8034B_var*
begin
//#UC START# *45F94C8E0109_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94C8E0109_45F7ECA8034B_impl*
end;//DefaultNodeBase.find_node_by_path

function DefaultNodeBase.find_loaded_node_by_path(const node_index_path): DefaultNodeBase;
//#UC START# *45F94CBE030D_45F7ECA8034B_var*
//#UC END# *45F94CBE030D_45F7ECA8034B_var*
begin
//#UC START# *45F94CBE030D_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94CBE030D_45F7ECA8034B_impl*
end;//DefaultNodeBase.find_loaded_node_by_path

function DefaultNodeBase.get_tree_name: PAnsiChar;
//#UC START# *45F94D1E004E_45F7ECA8034B_var*
//#UC END# *45F94D1E004E_45F7ECA8034B_var*
begin
//#UC START# *45F94D1E004E_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94D1E004E_45F7ECA8034B_impl*
end;//DefaultNodeBase.get_tree_name

function DefaultNodeBase.get_settings_root_id: AnsiString;
//#UC START# *45F94D3B0280_45F7ECA8034B_var*
//#UC END# *45F94D3B0280_45F7ECA8034B_var*
begin
//#UC START# *45F94D3B0280_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94D3B0280_45F7ECA8034B_impl*
end;//DefaultNodeBase.get_settings_root_id

procedure DefaultNodeBase.server_data_version;
//#UC START# *45F94D760203_45F7ECA8034B_var*
//#UC END# *45F94D760203_45F7ECA8034B_var*
begin
//#UC START# *45F94D760203_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94D760203_45F7ECA8034B_impl*
end;//DefaultNodeBase.server_data_version

procedure DefaultNodeBase.get_server_path(const path_type = PT_POINTER);
//#UC START# *45F94DB201C5_45F7ECA8034B_var*
//#UC END# *45F94DB201C5_45F7ECA8034B_var*
begin
//#UC START# *45F94DB201C5_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94DB201C5_45F7ECA8034B_impl*
end;//DefaultNodeBase.get_server_path

function DefaultNodeBase.get_tree_owner: TreeBase;
//#UC START# *45F94E24035B_45F7ECA8034B_var*
//#UC END# *45F94E24035B_45F7ECA8034B_var*
begin
//#UC START# *45F94E24035B_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94E24035B_45F7ECA8034B_impl*
end;//DefaultNodeBase.get_tree_owner

function DefaultNodeBase.get_visible_index: TVisibleIndex;
//#UC START# *45F94E390000_45F7ECA8034B_var*
//#UC END# *45F94E390000_45F7ECA8034B_var*
begin
//#UC START# *45F94E390000_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94E390000_45F7ECA8034B_impl*
end;//DefaultNodeBase.get_visible_index

procedure DefaultNodeBase.invalidate_children_count;
//#UC START# *45F94E8A008C_45F7ECA8034B_var*
//#UC END# *45F94E8A008C_45F7ECA8034B_var*
begin
//#UC START# *45F94E8A008C_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94E8A008C_45F7ECA8034B_impl*
end;//DefaultNodeBase.invalidate_children_count

procedure DefaultNodeBase.create_view_ex(const filter: IFilterList;
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
end;//DefaultNodeBase.create_view_ex

function DefaultNodeBase.set_range_flag(from: TVisibleIndex;
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
end;//DefaultNodeBase.set_range_flag

function DefaultNodeBase.has_parent_flag(flag: TFlagMask): Boolean;
//#UC START# *45F951DC0242_45F7ECA8034B_var*
//#UC END# *45F951DC0242_45F7ECA8034B_var*
begin
//#UC START# *45F951DC0242_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F951DC0242_45F7ECA8034B_impl*
end;//DefaultNodeBase.has_parent_flag

function DefaultNodeBase.has_children_flag(flag: TFlagMask): Boolean;
//#UC START# *45FA5936035B_45F7ECA8034B_var*
//#UC END# *45FA5936035B_45F7ECA8034B_var*
begin
//#UC START# *45FA5936035B_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FA5936035B_45F7ECA8034B_impl*
end;//DefaultNodeBase.has_children_flag

function DefaultNodeBase.get_flag_count(flag: TFlagMask): Cardinal;
//#UC START# *45F9522101A5_45F7ECA8034B_var*
//#UC END# *45F9522101A5_45F7ECA8034B_var*
begin
//#UC START# *45F9522101A5_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9522101A5_45F7ECA8034B_impl*
end;//DefaultNodeBase.get_flag_count

function DefaultNodeBase.get_first_level_children_flag_count(flag: TFlagMask): Cardinal;
//#UC START# *4677A98A0290_45F7ECA8034B_var*
//#UC END# *4677A98A0290_45F7ECA8034B_var*
begin
//#UC START# *4677A98A0290_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4677A98A0290_45F7ECA8034B_impl*
end;//DefaultNodeBase.get_first_level_children_flag_count

procedure DefaultNodeBase.set_children_flag(flag: TFlagMask;
 value: Boolean);
//#UC START# *45F9524B006D_45F7ECA8034B_var*
//#UC END# *45F9524B006D_45F7ECA8034B_var*
begin
//#UC START# *45F9524B006D_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9524B006D_45F7ECA8034B_impl*
end;//DefaultNodeBase.set_children_flag

function DefaultNodeBase.find_node_by_interface(const node_to_find: INodeBase): DefaultNodeBase;
//#UC START# *45F952A602DE_45F7ECA8034B_var*
//#UC END# *45F952A602DE_45F7ECA8034B_var*
begin
//#UC START# *45F952A602DE_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F952A602DE_45F7ECA8034B_impl*
end;//DefaultNodeBase.find_node_by_interface

function DefaultNodeBase.find_node(const node_to_find): DefaultNodeBase;
//#UC START# *45F9533D02AF_45F7ECA8034B_var*
//#UC END# *45F9533D02AF_45F7ECA8034B_var*
begin
//#UC START# *45F9533D02AF_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9533D02AF_45F7ECA8034B_impl*
end;//DefaultNodeBase.find_node

function DefaultNodeBase.find_node_path(var node_to_find: INodeBase): INodeIndexPath;
//#UC START# *45F9535E0213_45F7ECA8034B_var*
//#UC END# *45F9535E0213_45F7ECA8034B_var*
begin
//#UC START# *45F9535E0213_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9535E0213_45F7ECA8034B_impl*
end;//DefaultNodeBase.find_node_path

function DefaultNodeBase.get_visible_delta(var node: DefaultNodeBase): TVisibleIndex;
//#UC START# *45F953BF005D_45F7ECA8034B_var*
//#UC END# *45F953BF005D_45F7ECA8034B_var*
begin
//#UC START# *45F953BF005D_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F953BF005D_45F7ECA8034B_impl*
end;//DefaultNodeBase.get_visible_delta

function DefaultNodeBase.get_visible_delta(const node_path): TVisibleIndex;
//#UC START# *45F95412037A_45F7ECA8034B_var*
//#UC END# *45F95412037A_45F7ECA8034B_var*
begin
//#UC START# *45F95412037A_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95412037A_45F7ECA8034B_impl*
end;//DefaultNodeBase.get_visible_delta

function DefaultNodeBase.get_visible_delta(const entity: IEntityBase): TVisibleIndex;
//#UC START# *45F9542B03D8_45F7ECA8034B_var*
//#UC END# *45F9542B03D8_45F7ECA8034B_var*
begin
//#UC START# *45F9542B03D8_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9542B03D8_45F7ECA8034B_impl*
end;//DefaultNodeBase.get_visible_delta

function DefaultNodeBase.get_index_from_parent: TVisibleIndex;
 {* TODO: упростить, выкинув этот метод
ходить только к StaticNode-е }
//#UC START# *45F9547101F4_45F7ECA8034B_var*
//#UC END# *45F9547101F4_45F7ECA8034B_var*
begin
//#UC START# *45F9547101F4_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9547101F4_45F7ECA8034B_impl*
end;//DefaultNodeBase.get_index_from_parent

function DefaultNodeBase.get_abs_index: TVisibleIndex; { can raise CanNotFindData }
//#UC START# *45F954900138_45F7ECA8034B_var*
//#UC END# *45F954900138_45F7ECA8034B_var*
begin
//#UC START# *45F954900138_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F954900138_45F7ECA8034B_impl*
end;//DefaultNodeBase.get_abs_index

function DefaultNodeBase.get_child_path_by_abs_index(index: TVisibleIndex): INodeIndexPath; { can raise CanNotFindData }
//#UC START# *45F954CB0128_45F7ECA8034B_var*
//#UC END# *45F954CB0128_45F7ECA8034B_var*
begin
//#UC START# *45F954CB0128_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F954CB0128_45F7ECA8034B_impl*
end;//DefaultNodeBase.get_child_path_by_abs_index

procedure DefaultNodeBase.add_notifier(var notifier: INodeNotifier);
//#UC START# *45F95547002E_45F7ECA8034B_var*
//#UC END# *45F95547002E_45F7ECA8034B_var*
begin
//#UC START# *45F95547002E_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95547002E_45F7ECA8034B_impl*
end;//DefaultNodeBase.add_notifier

procedure DefaultNodeBase.remove_notifier(var notifier: INodeNotifier);
//#UC START# *45F9555D01B5_45F7ECA8034B_var*
//#UC END# *45F9555D01B5_45F7ECA8034B_var*
begin
//#UC START# *45F9555D01B5_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9555D01B5_45F7ECA8034B_impl*
end;//DefaultNodeBase.remove_notifier

function DefaultNodeBase.find_stub_for_index(out index: Integer): FlagNodeStub;
//#UC START# *45F955BC034B_45F7ECA8034B_var*
//#UC END# *45F955BC034B_45F7ECA8034B_var*
begin
//#UC START# *45F955BC034B_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F955BC034B_45F7ECA8034B_impl*
end;//DefaultNodeBase.find_stub_for_index

procedure DefaultNodeBase.get_available_layers(var layers: ILayerIdList);
//#UC START# *45F955DD0261_45F7ECA8034B_var*
//#UC END# *45F955DD0261_45F7ECA8034B_var*
begin
//#UC START# *45F955DD0261_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F955DD0261_45F7ECA8034B_impl*
end;//DefaultNodeBase.get_available_layers

function DefaultNodeBase.get_first_fit(const filter: IFilterList): INodeIndexPath;
//#UC START# *45F95642009C_45F7ECA8034B_var*
//#UC END# *45F95642009C_45F7ECA8034B_var*
begin
//#UC START# *45F95642009C_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95642009C_45F7ECA8034B_impl*
end;//DefaultNodeBase.get_first_fit

function DefaultNodeBase.find(const filter: IFilterList;
 const find_from: TNodePosition): IFindIterator;
//#UC START# *45F95672034B_45F7ECA8034B_var*
//#UC END# *45F95672034B_45F7ECA8034B_var*
begin
//#UC START# *45F95672034B_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95672034B_45F7ECA8034B_impl*
end;//DefaultNodeBase.find

function DefaultNodeBase.is_relevance_search_supported: Boolean;
//#UC START# *45F957E701D4_45F7ECA8034B_var*
//#UC END# *45F957E701D4_45F7ECA8034B_var*
begin
//#UC START# *45F957E701D4_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F957E701D4_45F7ECA8034B_impl*
end;//DefaultNodeBase.is_relevance_search_supported

function DefaultNodeBase.get_node_by_path(const path: INodeIndexPath): INodeBase;
 {* Дублирует с CatalogBase }
//#UC START# *45F958030280_45F7ECA8034B_var*
//#UC END# *45F958030280_45F7ECA8034B_var*
begin
//#UC START# *45F958030280_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F958030280_45F7ECA8034B_impl*
end;//DefaultNodeBase.get_node_by_path

procedure DefaultNodeBase.node_path_to_index_path(const path);
//#UC START# *45F958740203_45F7ECA8034B_var*
//#UC END# *45F958740203_45F7ECA8034B_var*
begin
//#UC START# *45F958740203_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F958740203_45F7ECA8034B_impl*
end;//DefaultNodeBase.node_path_to_index_path

procedure DefaultNodeBase.entity; { can raise NoEntity }
//#UC START# *45F95AAD0232_45F7ECA8034B_var*
//#UC END# *45F95AAD0232_45F7ECA8034B_var*
begin
//#UC START# *45F95AAD0232_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95AAD0232_45F7ECA8034B_impl*
end;//DefaultNodeBase.entity

function DefaultNodeBase.apply_reset_delta(var delta): Boolean;
//#UC START# *45F95B680232_45F7ECA8034B_var*
//#UC END# *45F95B680232_45F7ECA8034B_var*
begin
//#UC START# *45F95B680232_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95B680232_45F7ECA8034B_impl*
end;//DefaultNodeBase.apply_reset_delta

function DefaultNodeBase.apply_insert_delta(var delta): Boolean;
//#UC START# *45F95BAF02CE_45F7ECA8034B_var*
//#UC END# *45F95BAF02CE_45F7ECA8034B_var*
begin
//#UC START# *45F95BAF02CE_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95BAF02CE_45F7ECA8034B_impl*
end;//DefaultNodeBase.apply_insert_delta

function DefaultNodeBase.apply_delete_delta(var delta): Boolean;
//#UC START# *45F95BBD0271_45F7ECA8034B_var*
//#UC END# *45F95BBD0271_45F7ECA8034B_var*
begin
//#UC START# *45F95BBD0271_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95BBD0271_45F7ECA8034B_impl*
end;//DefaultNodeBase.apply_delete_delta

procedure DefaultNodeBase.remove_me_and_siblings(out count: Cardinal);
//#UC START# *45F95C3C035B_45F7ECA8034B_var*
//#UC END# *45F95C3C035B_45F7ECA8034B_var*
begin
//#UC START# *45F95C3C035B_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95C3C035B_45F7ECA8034B_impl*
end;//DefaultNodeBase.remove_me_and_siblings

procedure DefaultNodeBase.clean;
//#UC START# *45F95C64003E_45F7ECA8034B_var*
//#UC END# *45F95C64003E_45F7ECA8034B_var*
begin
//#UC START# *45F95C64003E_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95C64003E_45F7ECA8034B_impl*
end;//DefaultNodeBase.clean

function DefaultNodeBase.is_all_expanded: Boolean;
//#UC START# *45F95CBF002E_45F7ECA8034B_var*
//#UC END# *45F95CBF002E_45F7ECA8034B_var*
begin
//#UC START# *45F95CBF002E_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95CBF002E_45F7ECA8034B_impl*
end;//DefaultNodeBase.is_all_expanded

procedure DefaultNodeBase.expand_all_nodes(expand: Boolean);
//#UC START# *45F95CC40109_45F7ECA8034B_var*
//#UC END# *45F95CC40109_45F7ECA8034B_var*
begin
//#UC START# *45F95CC40109_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95CC40109_45F7ECA8034B_impl*
end;//DefaultNodeBase.expand_all_nodes

function DefaultNodeBase.owner_tree: TreeBase;
//#UC START# *47D6C0A2017A_45F7ECA8034B_var*
//#UC END# *47D6C0A2017A_45F7ECA8034B_var*
begin
//#UC START# *47D6C0A2017A_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D6C0A2017A_45F7ECA8034B_impl*
end;//DefaultNodeBase.owner_tree

function DefaultNodeBase.owner_tree: TreeBase;
//#UC START# *47D6C239024C_45F7ECA8034B_var*
//#UC END# *47D6C239024C_45F7ECA8034B_var*
begin
//#UC START# *47D6C239024C_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D6C239024C_45F7ECA8034B_impl*
end;//DefaultNodeBase.owner_tree

function DefaultNodeBase.set_range_flag_except_first_children_of_root_children(from: TVisibleIndex;
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
end;//DefaultNodeBase.set_range_flag_except_first_children_of_root_children

procedure DefaultNodeBase.set_all_flag(flag: TFlagMask;
 value: Boolean;
 with_notify: Boolean);
//#UC START# *45F80922032C_45F7ECA8034B_var*
//#UC END# *45F80922032C_45F7ECA8034B_var*
begin
//#UC START# *45F80922032C_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F80922032C_45F7ECA8034B_impl*
end;//DefaultNodeBase.set_all_flag

function DefaultNodeBase.internal_set_all_flag(flag: TFlagMask;
 value: Boolean;
 children_only: Boolean): size;
 {* возвращает количество взведённых (изменённых?) флагов. }
//#UC START# *45F810730290_45F7ECA8034B_var*
//#UC END# *45F810730290_45F7ECA8034B_var*
begin
//#UC START# *45F810730290_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F810730290_45F7ECA8034B_impl*
end;//DefaultNodeBase.internal_set_all_flag

procedure DefaultNodeBase.set_all_flag_except_first_children_of_root_children(flag: TFlagMask;
 value: Boolean;
 with_notify: Boolean);
//#UC START# *51EFC6D0015B_45F7ECA8034B_var*
//#UC END# *51EFC6D0015B_45F7ECA8034B_var*
begin
//#UC START# *51EFC6D0015B_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *51EFC6D0015B_45F7ECA8034B_impl*
end;//DefaultNodeBase.set_all_flag_except_first_children_of_root_children

function DefaultNodeBase.internal_set_all_flag_except_first_children_of_root_children(flag: TFlagMask;
 value: Boolean;
 children_only: Boolean): size;
//#UC START# *51EFC7130001_45F7ECA8034B_var*
//#UC END# *51EFC7130001_45F7ECA8034B_var*
begin
//#UC START# *51EFC7130001_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *51EFC7130001_45F7ECA8034B_impl*
end;//DefaultNodeBase.internal_set_all_flag_except_first_children_of_root_children

function DefaultNodeBase.set_flag(flag: TFlagMask;
 value: Boolean;
 with_notify: Boolean): Boolean;
//#UC START# *45F8123602DE_45F7ECA8034B_var*
//#UC END# *45F8123602DE_45F7ECA8034B_var*
begin
//#UC START# *45F8123602DE_45F7ECA8034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8123602DE_45F7ECA8034B_impl*
end;//DefaultNodeBase.set_flag

//#UC START# *45F7ECA8034Bimpl*
//#UC END# *45F7ECA8034Bimpl*

end.
