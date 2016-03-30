unit ree;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tree" MUID: (45F585F802AF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , reeBase
 , RealNodeBase
 , DefaultNodeBase
 , ViewBase
 //#UC START# *45F585F802AFintf_uses*
 //#UC END# *45F585F802AFintf_uses*
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
   f_tree_name: AnsiString;
  protected
   new_node_map: NewNodeMap;
   new_node_back_map: NewNodeBackMap;
  protected
   function GetTreeName: AnsiString; virtual; stdcall;
   procedure SetTreeName(const aValue: AnsiString); virtual; stdcall;
   class procedure CreateUid(new_node: RealNodeBase); virtual; stdcall;
   function AllocNewNode(const snode): DefaultNodeBase; override;
   function AllocNewView: ViewBase; override;
   function GetTreeName: AnsiString; override;
  public
   constructor Make(is_active_changeable: Boolean); reintroduce; virtual; stdcall;
   function ApplyCreatedNode(const data): RealNodeBase; override;
   procedure FindCreatedUid(var node: RealNodeBase); override;
   procedure AssociateNodeWithUid(var node: RealNodeBase); override;
   procedure DisassociateNodeWithUid(var node: RealNodeBase); override;
   function GetChangeMutex: mutex; override;
  protected
   property TreeName: AnsiString
    read GetTreeName
    write SetTreeName;
 //#UC START# *45F585F802AFpubl*
 //#UC END# *45F585F802AFpubl*
 end;//Tree

implementation

uses
 l3ImplUses
 , View
 //#UC START# *45F585F802AFimpl_uses*
 //#UC END# *45F585F802AFimpl_uses*
;

function Tree.GetTreeName: AnsiString;
//#UC START# *460259A6032C_45F585F802AFget_var*
//#UC END# *460259A6032C_45F585F802AFget_var*
begin
//#UC START# *460259A6032C_45F585F802AFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *460259A6032C_45F585F802AFget_impl*
end;//Tree.GetTreeName

procedure Tree.SetTreeName(const aValue: AnsiString);
//#UC START# *460259A6032C_45F585F802AFset_var*
//#UC END# *460259A6032C_45F585F802AFset_var*
begin
//#UC START# *460259A6032C_45F585F802AFset_impl*
 !!! Needs to be implemented !!!
//#UC END# *460259A6032C_45F585F802AFset_impl*
end;//Tree.SetTreeName

constructor Tree.Make(is_active_changeable: Boolean);
//#UC START# *45F589A9009C_45F585F802AF_var*
//#UC END# *45F589A9009C_45F585F802AF_var*
begin
//#UC START# *45F589A9009C_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F589A9009C_45F585F802AF_impl*
end;//Tree.Make

class procedure Tree.CreateUid(new_node: RealNodeBase);
//#UC START# *4602552E0157_45F585F802AF_var*
//#UC END# *4602552E0157_45F585F802AF_var*
begin
//#UC START# *4602552E0157_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4602552E0157_45F585F802AF_impl*
end;//Tree.CreateUid

function Tree.ApplyCreatedNode(const data): RealNodeBase;
//#UC START# *460125E60203_45F585F802AF_var*
//#UC END# *460125E60203_45F585F802AF_var*
begin
//#UC START# *460125E60203_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460125E60203_45F585F802AF_impl*
end;//Tree.ApplyCreatedNode

procedure Tree.FindCreatedUid(var node: RealNodeBase);
//#UC START# *46012631034B_45F585F802AF_var*
//#UC END# *46012631034B_45F585F802AF_var*
begin
//#UC START# *46012631034B_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012631034B_45F585F802AF_impl*
end;//Tree.FindCreatedUid

procedure Tree.AssociateNodeWithUid(var node: RealNodeBase);
//#UC START# *46012657032C_45F585F802AF_var*
//#UC END# *46012657032C_45F585F802AF_var*
begin
//#UC START# *46012657032C_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012657032C_45F585F802AF_impl*
end;//Tree.AssociateNodeWithUid

procedure Tree.DisassociateNodeWithUid(var node: RealNodeBase);
//#UC START# *4601267E0177_45F585F802AF_var*
//#UC END# *4601267E0177_45F585F802AF_var*
begin
//#UC START# *4601267E0177_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601267E0177_45F585F802AF_impl*
end;//Tree.DisassociateNodeWithUid

function Tree.AllocNewNode(const snode): DefaultNodeBase;
//#UC START# *460127AC0157_45F585F802AF_var*
//#UC END# *460127AC0157_45F585F802AF_var*
begin
//#UC START# *460127AC0157_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127AC0157_45F585F802AF_impl*
end;//Tree.AllocNewNode

function Tree.AllocNewView: ViewBase;
//#UC START# *460127E400EA_45F585F802AF_var*
//#UC END# *460127E400EA_45F585F802AF_var*
begin
//#UC START# *460127E400EA_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127E400EA_45F585F802AF_impl*
end;//Tree.AllocNewView

function Tree.GetChangeMutex: mutex;
//#UC START# *460139CE02BF_45F585F802AF_var*
//#UC END# *460139CE02BF_45F585F802AF_var*
begin
//#UC START# *460139CE02BF_45F585F802AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460139CE02BF_45F585F802AF_impl*
end;//Tree.GetChangeMutex

function Tree.GetTreeName: AnsiString;
//#UC START# *4948E2B2038D_45F585F802AFget_var*
//#UC END# *4948E2B2038D_45F585F802AFget_var*
begin
//#UC START# *4948E2B2038D_45F585F802AFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4948E2B2038D_45F585F802AFget_impl*
end;//Tree.GetTreeName

//#UC START# *45F585F802AFimpl*
//#UC END# *45F585F802AFimpl*

end.
