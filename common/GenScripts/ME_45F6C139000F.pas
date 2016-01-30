unit DelegateNodeBase;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DelegateNodeBase.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , DefaultNodeBase
 , RealNodeBase
 , reeBase
 , DynamicTreeDefinesUnit
;

type
 DelegateNodeBase = {abstract} class(DefaultNodeBase)
  protected
   function pm_Gethas_filtered_children: Boolean; virtual;
   procedure pm_Sethas_filtered_children(aValue: Boolean); virtual;
   procedure pm_Setmaster_node(aValue: RealNodeBase); virtual;
   function cached_master_node: RealNodeBase; overload; virtual;
   function cached_master_node: RealNodeBase; overload; virtual;
   function apply_change_delta(var delta): Boolean; override;
   function has_parent_flag(flag: TFlagMask): Boolean; override;
   function get_flag_count(flag: TFlagMask): Cardinal; override;
   function has_children_flag(flag: TFlagMask): Boolean; override;
   function get_first_level_children_flag_count(flag: TFlagMask): Cardinal; override;
  public
   constructor make(var owner_tree: TreeBase); reintroduce; virtual;
   procedure draw_node(level: unsigned integer;
    index: unsigned integer); virtual;
   procedure get_server_pointer; override;
   function node_name: PAnsiChar; override;
   procedure set_all_flag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean); override;
   function set_flag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean): Boolean; override;
   function get_flags: TFlagMask; override;
   function has_flag(flag: TFlagMask): Boolean; override;
  protected
   property has_filtered_children: Boolean
    read pm_Gethas_filtered_children
    write pm_Sethas_filtered_children;
  public
   property master_node: RealNodeBase
    write pm_Setmaster_node;
 end;//DelegateNodeBase

implementation

uses
 l3ImplUses
;

function DelegateNodeBase.pm_Gethas_filtered_children: Boolean;
//#UC START# *45FAC21A0148_45F6C139000Fget_var*
//#UC END# *45FAC21A0148_45F6C139000Fget_var*
begin
//#UC START# *45FAC21A0148_45F6C139000Fget_impl*
 Result := f_has_filtered_children
//#UC END# *45FAC21A0148_45F6C139000Fget_impl*
end;//DelegateNodeBase.pm_Gethas_filtered_children

procedure DelegateNodeBase.pm_Sethas_filtered_children(aValue: Boolean);
//#UC START# *45FAC21A0148_45F6C139000Fset_var*
//#UC END# *45FAC21A0148_45F6C139000Fset_var*
begin
//#UC START# *45FAC21A0148_45F6C139000Fset_impl*
 f_has_filtered_children := aValue
//#UC END# *45FAC21A0148_45F6C139000Fset_impl*
end;//DelegateNodeBase.pm_Sethas_filtered_children

procedure DelegateNodeBase.pm_Setmaster_node(aValue: RealNodeBase);
//#UC START# *47D6BA2603CF_45F6C139000Fset_var*
//#UC END# *47D6BA2603CF_45F6C139000Fset_var*
begin
//#UC START# *47D6BA2603CF_45F6C139000Fset_impl*
 f_master_node := aValue
//#UC END# *47D6BA2603CF_45F6C139000Fset_impl*
end;//DelegateNodeBase.pm_Setmaster_node

constructor DelegateNodeBase.make(var owner_tree: TreeBase);
//#UC START# *45FA90EF02AF_45F6C139000F_var*
//#UC END# *45FA90EF02AF_45F6C139000F_var*
begin
//#UC START# *45FA90EF02AF_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FA90EF02AF_45F6C139000F_impl*
end;//DelegateNodeBase.make

procedure DelegateNodeBase.draw_node(level: unsigned integer;
 index: unsigned integer);
//#UC START# *45FAC1A40222_45F6C139000F_var*
//#UC END# *45FAC1A40222_45F6C139000F_var*
begin
//#UC START# *45FAC1A40222_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FAC1A40222_45F6C139000F_impl*
end;//DelegateNodeBase.draw_node

function DelegateNodeBase.cached_master_node: RealNodeBase;
//#UC START# *47D6B83A00BD_45F6C139000F_var*
//#UC END# *47D6B83A00BD_45F6C139000F_var*
begin
//#UC START# *47D6B83A00BD_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D6B83A00BD_45F6C139000F_impl*
end;//DelegateNodeBase.cached_master_node

function DelegateNodeBase.cached_master_node: RealNodeBase;
//#UC START# *47D6BE690392_45F6C139000F_var*
//#UC END# *47D6BE690392_45F6C139000F_var*
begin
//#UC START# *47D6BE690392_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D6BE690392_45F6C139000F_impl*
end;//DelegateNodeBase.cached_master_node

procedure DelegateNodeBase.get_server_pointer;
//#UC START# *45F94B820290_45F6C139000F_var*
//#UC END# *45F94B820290_45F6C139000F_var*
begin
//#UC START# *45F94B820290_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94B820290_45F6C139000F_impl*
end;//DelegateNodeBase.get_server_pointer

function DelegateNodeBase.node_name: PAnsiChar;
//#UC START# *45F94D570138_45F6C139000F_var*
//#UC END# *45F94D570138_45F6C139000F_var*
begin
//#UC START# *45F94D570138_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94D570138_45F6C139000F_impl*
end;//DelegateNodeBase.node_name

function DelegateNodeBase.apply_change_delta(var delta): Boolean;
//#UC START# *45F95B9A0000_45F6C139000F_var*
//#UC END# *45F95B9A0000_45F6C139000F_var*
begin
//#UC START# *45F95B9A0000_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95B9A0000_45F6C139000F_impl*
end;//DelegateNodeBase.apply_change_delta

procedure DelegateNodeBase.set_all_flag(flag: TFlagMask;
 value: Boolean;
 with_notify: Boolean);
//#UC START# *45F80922032C_45F6C139000F_var*
//#UC END# *45F80922032C_45F6C139000F_var*
begin
//#UC START# *45F80922032C_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F80922032C_45F6C139000F_impl*
end;//DelegateNodeBase.set_all_flag

function DelegateNodeBase.set_flag(flag: TFlagMask;
 value: Boolean;
 with_notify: Boolean): Boolean;
//#UC START# *45F8123602DE_45F6C139000F_var*
//#UC END# *45F8123602DE_45F6C139000F_var*
begin
//#UC START# *45F8123602DE_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8123602DE_45F6C139000F_impl*
end;//DelegateNodeBase.set_flag

function DelegateNodeBase.get_flags: TFlagMask;
//#UC START# *45F8124B0138_45F6C139000F_var*
//#UC END# *45F8124B0138_45F6C139000F_var*
begin
//#UC START# *45F8124B0138_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8124B0138_45F6C139000F_impl*
end;//DelegateNodeBase.get_flags

function DelegateNodeBase.has_flag(flag: TFlagMask): Boolean;
//#UC START# *45F9305601F4_45F6C139000F_var*
//#UC END# *45F9305601F4_45F6C139000F_var*
begin
//#UC START# *45F9305601F4_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9305601F4_45F6C139000F_impl*
end;//DelegateNodeBase.has_flag

function DelegateNodeBase.has_parent_flag(flag: TFlagMask): Boolean;
//#UC START# *45F951DC0242_45F6C139000F_var*
//#UC END# *45F951DC0242_45F6C139000F_var*
begin
//#UC START# *45F951DC0242_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F951DC0242_45F6C139000F_impl*
end;//DelegateNodeBase.has_parent_flag

function DelegateNodeBase.get_flag_count(flag: TFlagMask): Cardinal;
//#UC START# *45F9522101A5_45F6C139000F_var*
//#UC END# *45F9522101A5_45F6C139000F_var*
begin
//#UC START# *45F9522101A5_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9522101A5_45F6C139000F_impl*
end;//DelegateNodeBase.get_flag_count

function DelegateNodeBase.has_children_flag(flag: TFlagMask): Boolean;
//#UC START# *45FA5936035B_45F6C139000F_var*
//#UC END# *45FA5936035B_45F6C139000F_var*
begin
//#UC START# *45FA5936035B_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FA5936035B_45F6C139000F_impl*
end;//DelegateNodeBase.has_children_flag

function DelegateNodeBase.get_first_level_children_flag_count(flag: TFlagMask): Cardinal;
//#UC START# *4677A98A0290_45F6C139000F_var*
//#UC END# *4677A98A0290_45F6C139000F_var*
begin
//#UC START# *4677A98A0290_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4677A98A0290_45F6C139000F_impl*
end;//DelegateNodeBase.get_first_level_children_flag_count

end.
