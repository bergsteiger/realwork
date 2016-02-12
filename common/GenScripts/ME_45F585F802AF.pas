unit ree;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ree.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , reeBase
 , RealNodeBase
 , DefaultNodeBase
 , ViewBase
;

type
 // NewNodeMap

 // NewNodeBackMap

 // ApplyedNodeMap

 //#UC START# *45F585F802AFci*
 //#UC END# *45F585F802AFci*
 //#UC START# *45F585F802AFcit*
 //#UC END# *45F585F802AFcit*
 Tree = {abstract} class(TreeBase)
  private
   change_mutex: mutex;
  protected
   new_node_map: NewNodeMap;
   new_node_back_map: NewNodeBackMap;
  protected
   function pm_Gettree_name: AnsiString; virtual;
   procedure pm_Settree_name(const aValue: AnsiString); virtual;
   class procedure create_uid(new_node: RealNodeBase); virtual;
   function alloc_new_node(const snode): DefaultNodeBase; override;
   function alloc_new_view: ViewBase; override;
   function pm_Gettree_name: AnsiString; override;
  public
   constructor make(is_active_changeable: Boolean); reintroduce; virtual;
   function apply_created_node(const data): RealNodeBase; override;
   procedure find_created_uid(var node: RealNodeBase); override;
   procedure associate_node_with_uid(var node: RealNodeBase); override;
   procedure disassociate_node_with_uid(var node: RealNodeBase); override;
   function get_change_mutex: mutex; override;
  protected
   property tree_name: AnsiString
    read pm_Gettree_name
    write pm_Settree_name;
 //#UC START# *45F585F802AFpubl*
 //#UC END# *45F585F802AFpubl*
 end;//Tree

implementation

uses
 l3ImplUses
 , View
;

function Tree.pm_Gettree_name: AnsiString;
//#UC START# *460259A6032C_45F585F802AFget_var*
//#UC END# *460259A6032C_45F585F802AFget_var*
begin
//#UC START# *460259A6032C_45F585F802AFget_impl*
 Result := f_tree_name
//#UC END# *460259A6032C_45F585F802AFget_impl*
end;//Tree.pm_Gettree_name

procedure Tree.pm_Settree_name(const aValue: AnsiString);
//#UC START# *460259A6032C_45F585F802AFset_var*
//#UC END# *460259A6032C_45F585F802AFset_var*
begin
//#UC START# *460259A6032C_45F585F802AFset_impl*
 f_tree_name := aValue
//#UC END# *460259A6032C_45F585F802AFset_impl*
end;//Tree.pm_Settree_name

constructor Tree.make(is_active_changeable: Boolean);
//#UC START# *45F589A9009C_45F585F802AF_var*
//#UC END# *45F589A9009C_45F585F802AF_var*
begin
//#UC START# *45F589A9009C_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F589A9009C_45F585F802AF_impl*
end;//Tree.make

class procedure Tree.create_uid(new_node: RealNodeBase);
//#UC START# *4602552E0157_45F585F802AF_var*
//#UC END# *4602552E0157_45F585F802AF_var*
begin
//#UC START# *4602552E0157_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4602552E0157_45F585F802AF_impl*
end;//Tree.create_uid

function Tree.apply_created_node(const data): RealNodeBase;
//#UC START# *460125E60203_45F585F802AF_var*
//#UC END# *460125E60203_45F585F802AF_var*
begin
//#UC START# *460125E60203_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460125E60203_45F585F802AF_impl*
end;//Tree.apply_created_node

procedure Tree.find_created_uid(var node: RealNodeBase);
//#UC START# *46012631034B_45F585F802AF_var*
//#UC END# *46012631034B_45F585F802AF_var*
begin
//#UC START# *46012631034B_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012631034B_45F585F802AF_impl*
end;//Tree.find_created_uid

procedure Tree.associate_node_with_uid(var node: RealNodeBase);
//#UC START# *46012657032C_45F585F802AF_var*
//#UC END# *46012657032C_45F585F802AF_var*
begin
//#UC START# *46012657032C_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012657032C_45F585F802AF_impl*
end;//Tree.associate_node_with_uid

procedure Tree.disassociate_node_with_uid(var node: RealNodeBase);
//#UC START# *4601267E0177_45F585F802AF_var*
//#UC END# *4601267E0177_45F585F802AF_var*
begin
//#UC START# *4601267E0177_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601267E0177_45F585F802AF_impl*
end;//Tree.disassociate_node_with_uid

function Tree.alloc_new_node(const snode): DefaultNodeBase;
//#UC START# *460127AC0157_45F585F802AF_var*
//#UC END# *460127AC0157_45F585F802AF_var*
begin
//#UC START# *460127AC0157_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127AC0157_45F585F802AF_impl*
end;//Tree.alloc_new_node

function Tree.alloc_new_view: ViewBase;
//#UC START# *460127E400EA_45F585F802AF_var*
//#UC END# *460127E400EA_45F585F802AF_var*
begin
//#UC START# *460127E400EA_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127E400EA_45F585F802AF_impl*
end;//Tree.alloc_new_view

function Tree.get_change_mutex: mutex;
//#UC START# *460139CE02BF_45F585F802AF_var*
//#UC END# *460139CE02BF_45F585F802AF_var*
begin
//#UC START# *460139CE02BF_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460139CE02BF_45F585F802AF_impl*
end;//Tree.get_change_mutex

function Tree.pm_Gettree_name: AnsiString;
//#UC START# *4948E2B2038D_45F585F802AFget_var*
//#UC END# *4948E2B2038D_45F585F802AFget_var*
begin
//#UC START# *4948E2B2038D_45F585F802AFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4948E2B2038D_45F585F802AFget_impl*
end;//Tree.pm_Gettree_name

//#UC START# *45F585F802AFimpl*
//#UC END# *45F585F802AFimpl*

end.
