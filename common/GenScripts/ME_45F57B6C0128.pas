unit ViewBase;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ViewBase.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , reeBase
 , DynamicTreeDefinesUnit
 , DefaultNodeBase
 , FlagNodeBase
;

type
 ViewBase = {abstract} class(TreeBase)
  protected
   function pm_Getmode: TFlagMask; virtual;
   function pm_Getparent_tree_root: DefaultNodeBase; virtual;
   function pm_Getmaximum_levels_restriction: unsigned integer; virtual;
   function pm_Getauto_open: Boolean; virtual;
   function pm_Gettree_name: AnsiString; override;
   function master_tree: TreeBase; override;
  public
   constructor make; reintroduce; virtual;
   procedure build_node(snode;
    var current_stub: FlagNodeBase); virtual;
   procedure init(mode: TFlagMask;
    levels: unsigned integer;
    auto_open: Boolean;
    parent_tree: TreeBase;
    server_tree); virtual;
   function get_change_mutex: mutex; override;
   function is_mode(shared_flags: TFlagMask): Boolean; override;
   procedure load_nodes_from_server(parent_point;
    child_point;
    from: Integer;
    in_block_position: Cardinal;
    var current_stub); override; { can raise InvalidOwnerTree }
   function get_shared_mode: TFlagMask; override;
   procedure expand_all(expand: Boolean); override;
  protected
   property mode: TFlagMask
    read pm_Getmode;
   property parent_tree_root: DefaultNodeBase
    read pm_Getparent_tree_root;
   property maximum_levels_restriction: unsigned integer
    read pm_Getmaximum_levels_restriction;
   property auto_open: Boolean
    read pm_Getauto_open;
 end;//ViewBase

implementation

uses
 l3ImplUses
 , RealNodeBase
 , ApplicationHelper
;

function ViewBase.pm_Getmode: TFlagMask;
//#UC START# *46025C6602BF_45F57B6C0128get_var*
//#UC END# *46025C6602BF_45F57B6C0128get_var*
begin
//#UC START# *46025C6602BF_45F57B6C0128get_impl*
 Result := f_mode
//#UC END# *46025C6602BF_45F57B6C0128get_impl*
end;//ViewBase.pm_Getmode

function ViewBase.pm_Getparent_tree_root: DefaultNodeBase;
//#UC START# *46025C860251_45F57B6C0128get_var*
//#UC END# *46025C860251_45F57B6C0128get_var*
begin
//#UC START# *46025C860251_45F57B6C0128get_impl*
 Result := f_parent_tree_root
//#UC END# *46025C860251_45F57B6C0128get_impl*
end;//ViewBase.pm_Getparent_tree_root

function ViewBase.pm_Getmaximum_levels_restriction: unsigned integer;
//#UC START# *46025C9E01D4_45F57B6C0128get_var*
//#UC END# *46025C9E01D4_45F57B6C0128get_var*
begin
//#UC START# *46025C9E01D4_45F57B6C0128get_impl*
 Result := f_maximum_levels_restriction
//#UC END# *46025C9E01D4_45F57B6C0128get_impl*
end;//ViewBase.pm_Getmaximum_levels_restriction

function ViewBase.pm_Getauto_open: Boolean;
//#UC START# *46025CBB01B5_45F57B6C0128get_var*
//#UC END# *46025CBB01B5_45F57B6C0128get_var*
begin
//#UC START# *46025CBB01B5_45F57B6C0128get_impl*
 Result := f_auto_open
//#UC END# *46025CBB01B5_45F57B6C0128get_impl*
end;//ViewBase.pm_Getauto_open

constructor ViewBase.make;
//#UC START# *46025BAC02FD_45F57B6C0128_var*
//#UC END# *46025BAC02FD_45F57B6C0128_var*
begin
//#UC START# *46025BAC02FD_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *46025BAC02FD_45F57B6C0128_impl*
end;//ViewBase.make

procedure ViewBase.build_node(snode;
 var current_stub: FlagNodeBase);
//#UC START# *46272A80037A_45F57B6C0128_var*
//#UC END# *46272A80037A_45F57B6C0128_var*
begin
//#UC START# *46272A80037A_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *46272A80037A_45F57B6C0128_impl*
end;//ViewBase.build_node

procedure ViewBase.init(mode: TFlagMask;
 levels: unsigned integer;
 auto_open: Boolean;
 parent_tree: TreeBase;
 server_tree);
//#UC START# *46025D6F0000_45F57B6C0128_var*
//#UC END# *46025D6F0000_45F57B6C0128_var*
begin
//#UC START# *46025D6F0000_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *46025D6F0000_45F57B6C0128_impl*
end;//ViewBase.init

function ViewBase.get_change_mutex: mutex;
//#UC START# *460139CE02BF_45F57B6C0128_var*
//#UC END# *460139CE02BF_45F57B6C0128_var*
begin
//#UC START# *460139CE02BF_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *460139CE02BF_45F57B6C0128_impl*
end;//ViewBase.get_change_mutex

function ViewBase.pm_Gettree_name: AnsiString;
//#UC START# *4948E2B2038D_45F57B6C0128get_var*
//#UC END# *4948E2B2038D_45F57B6C0128get_var*
begin
//#UC START# *4948E2B2038D_45F57B6C0128get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4948E2B2038D_45F57B6C0128get_impl*
end;//ViewBase.pm_Gettree_name

function ViewBase.is_mode(shared_flags: TFlagMask): Boolean;
//#UC START# *4601221600DA_45F57B6C0128_var*
//#UC END# *4601221600DA_45F57B6C0128_var*
begin
//#UC START# *4601221600DA_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601221600DA_45F57B6C0128_impl*
end;//ViewBase.is_mode

procedure ViewBase.load_nodes_from_server(parent_point;
 child_point;
 from: Integer;
 in_block_position: Cardinal;
 var current_stub); { can raise InvalidOwnerTree }
//#UC START# *46012392006D_45F57B6C0128_var*
//#UC END# *46012392006D_45F57B6C0128_var*
begin
//#UC START# *46012392006D_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012392006D_45F57B6C0128_impl*
end;//ViewBase.load_nodes_from_server

function ViewBase.get_shared_mode: TFlagMask;
//#UC START# *4601240A033C_45F57B6C0128_var*
//#UC END# *4601240A033C_45F57B6C0128_var*
begin
//#UC START# *4601240A033C_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601240A033C_45F57B6C0128_impl*
end;//ViewBase.get_shared_mode

procedure ViewBase.expand_all(expand: Boolean);
//#UC START# *460127560261_45F57B6C0128_var*
//#UC END# *460127560261_45F57B6C0128_var*
begin
//#UC START# *460127560261_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127560261_45F57B6C0128_impl*
end;//ViewBase.expand_all

function ViewBase.master_tree: TreeBase;
//#UC START# *46012787038A_45F57B6C0128_var*
//#UC END# *46012787038A_45F57B6C0128_var*
begin
//#UC START# *46012787038A_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012787038A_45F57B6C0128_impl*
end;//ViewBase.master_tree

end.
