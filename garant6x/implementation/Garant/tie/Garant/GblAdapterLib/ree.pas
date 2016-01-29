unit ree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/ree.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::Tree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  reeBase,
  RealNodeBase,
  DefaultNodeBase,
  ViewBase
  ;

type
//#UC START# *45F585F802AFci*
//#UC END# *45F585F802AFci*
 Tree = {abstract} class(TreeBase)
 private
 // private fields
   change_mutex : mutex;
 protected
 // property methods
   function pm_GetTreeName: AnsiString; virtual;
   procedure pm_SetTreeName(const aValue: AnsiString); virtual;
 protected
 // realized methods
   function ApplyCreatedNode(data): RealNodeBase; override;
   procedure FindCreatedUid(var node: RealNodeBase); override;
   procedure AssociateNodeWithUid(var node: RealNodeBase); override;
   procedure DisassociateNodeWithUid(var node: RealNodeBase); override;
   function AllocNewNode(snode): DefaultNodeBase; override;
   function AllocNewView: ViewBase; override;
   function GetChangeMutex: mutex; override;
   function pm_GetTreeName: AnsiString; override;
 protected
 // protected fields
   new_node_map : NewNodeMap;
   new_node_back_map : NewNodeBackMap;
 protected
 // protected methods
   class procedure CreateUid(new_node: RealNodeBase); virtual;
 public
 // public methods
   constructor Make(is_active_changeable: Boolean); virtual;
 protected
 // protected properties
   property tree_name: AnsiString
     read pm_GetTreeName
     write pm_SetTreeName;
//#UC START# *45F585F802AFpubl*
//#UC END# *45F585F802AFpubl*
 end;//Tree

implementation

uses
  View
  ;

// start class Tree

function Tree.pm_GetTreeName: AnsiString;
//#UC START# *460259A6032C_45F585F802AFget_var*
//#UC END# *460259A6032C_45F585F802AFget_var*
begin
//#UC START# *460259A6032C_45F585F802AFget_impl*
 Result := f_tree_name
//#UC END# *460259A6032C_45F585F802AFget_impl*
end;//Tree.pm_GetTreeName

procedure Tree.pm_SetTreeName(const aValue: AnsiString);
//#UC START# *460259A6032C_45F585F802AFset_var*
//#UC END# *460259A6032C_45F585F802AFset_var*
begin
//#UC START# *460259A6032C_45F585F802AFset_impl*
 f_tree_name := aValue
//#UC END# *460259A6032C_45F585F802AFset_impl*
end;//Tree.pm_SetTreeName

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

function Tree.ApplyCreatedNode(data): RealNodeBase;
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

function Tree.AllocNewNode(snode): DefaultNodeBase;
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

function Tree.pm_GetTreeName: AnsiString;
//#UC START# *4948E2B2038D_45F585F802AFget_var*
//#UC END# *4948E2B2038D_45F585F802AFget_var*
begin
//#UC START# *4948E2B2038D_45F585F802AFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4948E2B2038D_45F585F802AFget_impl*
end;//Tree.pm_GetTreeName

//#UC START# *45F585F802AFimpl*
//#UC END# *45F585F802AFimpl*

end.