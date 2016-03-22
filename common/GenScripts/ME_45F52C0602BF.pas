unit FlagNodeBase;
 {* нода с флагами }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\FlagNodeBase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "FlagNodeBase" MUID: (45F52C0602BF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , DynamicTreeDefinesUnit
 , DynamicTreeUnit
;

type
 //#UC START# *45F52C0602BFci*
 //#UC END# *45F52C0602BFci*
 //#UC START# *45F52C0602BFcit*
 //#UC END# *45F52C0602BFcit*
 FlagNodeBase = {abstract} class
  {* нода с флагами }
  protected
   procedure pm_Setflags(aValue: TFlagMask); virtual;
   constructor make; reintroduce; virtual;
  public
   procedure set_my_parent(var parent); virtual;
   procedure get_my_parent; virtual;
   procedure set_all_flag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean); virtual; abstract;
   function internal_set_all_flag(flag: TFlagMask;
    value: Boolean;
    children_only: Boolean): size; virtual; abstract;
    {* возвращает количество взведённых (изменённых?) флагов. }
   function set_flag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean): Boolean; virtual;
   function has_flag(flag: TFlagMask): Boolean; virtual;
   function get_flags: TFlagMask; virtual;
   procedure make_visible; virtual;
   function is_visible: Boolean; virtual;
   function get_node_by_visible_index(index: TVisibleIndex): FlagNodeBase; virtual;
   function next_with_flag(flag: TFlagMask;
    skip_stub: Boolean = False): FlagNodeBase; virtual;
   function next_visible(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; virtual;
   function plane_next(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; virtual;
   function plane_next_back(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; virtual;
   function prev_visible(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; virtual;
   function prev_visible_stop(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; virtual;
   function next_one_level(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var): FlagNodeBase; virtual;
   function prev_one_level(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var): FlagNodeBase; virtual;
   function all_visible_children_count: size; virtual;
    {* // TODO: hide in cache }
   procedure set_all_flag_except_first_children_of_root_children(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean); virtual; abstract;
   function internal_set_all_flag_except_first_children_of_root_children(flag: TFlagMask;
    value: Boolean;
    children_only: Boolean): size; virtual; abstract;
  public
   property flags: TFlagMask
    write pm_Setflags;
 //#UC START# *45F52C0602BFpubl*
 //#UC END# *45F52C0602BFpubl*
 end;//FlagNodeBase

implementation

uses
 l3ImplUses
;

procedure FlagNodeBase.pm_Setflags(aValue: TFlagMask);
//#UC START# *45F80BA20280_45F52C0602BFset_var*
//#UC END# *45F80BA20280_45F52C0602BFset_var*
begin
//#UC START# *45F80BA20280_45F52C0602BFset_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F80BA20280_45F52C0602BFset_impl*
end;//FlagNodeBase.pm_Setflags

constructor FlagNodeBase.make;
//#UC START# *45F803B0000F_45F52C0602BF_var*
//#UC END# *45F803B0000F_45F52C0602BF_var*
begin
//#UC START# *45F803B0000F_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F803B0000F_45F52C0602BF_impl*
end;//FlagNodeBase.make

procedure FlagNodeBase.set_my_parent(var parent);
//#UC START# *45F8046500FA_45F52C0602BF_var*
//#UC END# *45F8046500FA_45F52C0602BF_var*
begin
//#UC START# *45F8046500FA_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8046500FA_45F52C0602BF_impl*
end;//FlagNodeBase.set_my_parent

procedure FlagNodeBase.get_my_parent;
//#UC START# *45F8049F0128_45F52C0602BF_var*
//#UC END# *45F8049F0128_45F52C0602BF_var*
begin
//#UC START# *45F8049F0128_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8049F0128_45F52C0602BF_impl*
end;//FlagNodeBase.get_my_parent

function FlagNodeBase.set_flag(flag: TFlagMask;
 value: Boolean;
 with_notify: Boolean): Boolean;
//#UC START# *45F8123602DE_45F52C0602BF_var*
//#UC END# *45F8123602DE_45F52C0602BF_var*
begin
//#UC START# *45F8123602DE_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8123602DE_45F52C0602BF_impl*
end;//FlagNodeBase.set_flag

function FlagNodeBase.has_flag(flag: TFlagMask): Boolean;
//#UC START# *45F9305601F4_45F52C0602BF_var*
//#UC END# *45F9305601F4_45F52C0602BF_var*
begin
//#UC START# *45F9305601F4_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9305601F4_45F52C0602BF_impl*
end;//FlagNodeBase.has_flag

function FlagNodeBase.get_flags: TFlagMask;
//#UC START# *45F8124B0138_45F52C0602BF_var*
//#UC END# *45F8124B0138_45F52C0602BF_var*
begin
//#UC START# *45F8124B0138_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8124B0138_45F52C0602BF_impl*
end;//FlagNodeBase.get_flags

procedure FlagNodeBase.make_visible;
//#UC START# *45F812D20290_45F52C0602BF_var*
//#UC END# *45F812D20290_45F52C0602BF_var*
begin
//#UC START# *45F812D20290_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F812D20290_45F52C0602BF_impl*
end;//FlagNodeBase.make_visible

function FlagNodeBase.is_visible: Boolean;
//#UC START# *45F8145B0203_45F52C0602BF_var*
//#UC END# *45F8145B0203_45F52C0602BF_var*
begin
//#UC START# *45F8145B0203_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8145B0203_45F52C0602BF_impl*
end;//FlagNodeBase.is_visible

function FlagNodeBase.get_node_by_visible_index(index: TVisibleIndex): FlagNodeBase;
//#UC START# *45F8151D02CE_45F52C0602BF_var*
//#UC END# *45F8151D02CE_45F52C0602BF_var*
begin
//#UC START# *45F8151D02CE_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8151D02CE_45F52C0602BF_impl*
end;//FlagNodeBase.get_node_by_visible_index

function FlagNodeBase.next_with_flag(flag: TFlagMask;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F815330251_45F52C0602BF_var*
//#UC END# *45F815330251_45F52C0602BF_var*
begin
//#UC START# *45F815330251_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F815330251_45F52C0602BF_impl*
end;//FlagNodeBase.next_with_flag

function FlagNodeBase.next_visible(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F81F0B02BF_45F52C0602BF_var*
//#UC END# *45F81F0B02BF_45F52C0602BF_var*
begin
//#UC START# *45F81F0B02BF_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F81F0B02BF_45F52C0602BF_impl*
end;//FlagNodeBase.next_visible

function FlagNodeBase.plane_next(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F81F6B01C5_45F52C0602BF_var*
//#UC END# *45F81F6B01C5_45F52C0602BF_var*
begin
//#UC START# *45F81F6B01C5_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F81F6B01C5_45F52C0602BF_impl*
end;//FlagNodeBase.plane_next

function FlagNodeBase.plane_next_back(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F9071F035B_45F52C0602BF_var*
//#UC END# *45F9071F035B_45F52C0602BF_var*
begin
//#UC START# *45F9071F035B_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9071F035B_45F52C0602BF_impl*
end;//FlagNodeBase.plane_next_back

function FlagNodeBase.prev_visible(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F9074B034B_45F52C0602BF_var*
//#UC END# *45F9074B034B_45F52C0602BF_var*
begin
//#UC START# *45F9074B034B_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9074B034B_45F52C0602BF_impl*
end;//FlagNodeBase.prev_visible

function FlagNodeBase.prev_visible_stop(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F9077A003E_45F52C0602BF_var*
//#UC END# *45F9077A003E_45F52C0602BF_var*
begin
//#UC START# *45F9077A003E_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9077A003E_45F52C0602BF_impl*
end;//FlagNodeBase.prev_visible_stop

function FlagNodeBase.next_one_level(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var): FlagNodeBase;
//#UC START# *45F90792004E_45F52C0602BF_var*
//#UC END# *45F90792004E_45F52C0602BF_var*
begin
//#UC START# *45F90792004E_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F90792004E_45F52C0602BF_impl*
end;//FlagNodeBase.next_one_level

function FlagNodeBase.prev_one_level(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var): FlagNodeBase;
//#UC START# *45F907B000EA_45F52C0602BF_var*
//#UC END# *45F907B000EA_45F52C0602BF_var*
begin
//#UC START# *45F907B000EA_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F907B000EA_45F52C0602BF_impl*
end;//FlagNodeBase.prev_one_level

function FlagNodeBase.all_visible_children_count: size;
 {* // TODO: hide in cache }
//#UC START# *45F907DE033C_45F52C0602BF_var*
//#UC END# *45F907DE033C_45F52C0602BF_var*
begin
//#UC START# *45F907DE033C_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F907DE033C_45F52C0602BF_impl*
end;//FlagNodeBase.all_visible_children_count

//#UC START# *45F52C0602BFimpl*
//#UC END# *45F52C0602BFimpl*

end.
