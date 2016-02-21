unit View;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\View.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , ViewBase
 , RealNodeBase
 , DefaultNodeBase
;

type
 //#UC START# *45F6583E001Fci*
 //#UC END# *45F6583E001Fci*
 //#UC START# *45F6583E001Fcit*
 //#UC END# *45F6583E001Fcit*
 View = {abstract} class(ViewBase)
  protected
   function alloc_new_node(const snode): DefaultNodeBase; override;
   function alloc_new_view: ViewBase; override;
  public
   constructor make; reintroduce; virtual;
   function apply_created_node(const data): RealNodeBase; override;
   procedure find_created_uid(var node: RealNodeBase); override;
   procedure associate_node_with_uid(var node: RealNodeBase); override;
   procedure disassociate_node_with_uid(var node: RealNodeBase); override;
 //#UC START# *45F6583E001Fpubl*
 //#UC END# *45F6583E001Fpubl*
 end;//View

implementation

uses
 l3ImplUses
;

constructor View.make;
//#UC START# *45F65B2F01B5_45F6583E001F_var*
//#UC END# *45F65B2F01B5_45F6583E001F_var*
begin
//#UC START# *45F65B2F01B5_45F6583E001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F65B2F01B5_45F6583E001F_impl*
end;//View.make

function View.apply_created_node(const data): RealNodeBase;
//#UC START# *460125E60203_45F6583E001F_var*
//#UC END# *460125E60203_45F6583E001F_var*
begin
//#UC START# *460125E60203_45F6583E001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *460125E60203_45F6583E001F_impl*
end;//View.apply_created_node

procedure View.find_created_uid(var node: RealNodeBase);
//#UC START# *46012631034B_45F6583E001F_var*
//#UC END# *46012631034B_45F6583E001F_var*
begin
//#UC START# *46012631034B_45F6583E001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012631034B_45F6583E001F_impl*
end;//View.find_created_uid

procedure View.associate_node_with_uid(var node: RealNodeBase);
//#UC START# *46012657032C_45F6583E001F_var*
//#UC END# *46012657032C_45F6583E001F_var*
begin
//#UC START# *46012657032C_45F6583E001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012657032C_45F6583E001F_impl*
end;//View.associate_node_with_uid

procedure View.disassociate_node_with_uid(var node: RealNodeBase);
//#UC START# *4601267E0177_45F6583E001F_var*
//#UC END# *4601267E0177_45F6583E001F_var*
begin
//#UC START# *4601267E0177_45F6583E001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601267E0177_45F6583E001F_impl*
end;//View.disassociate_node_with_uid

function View.alloc_new_node(const snode): DefaultNodeBase;
//#UC START# *460127AC0157_45F6583E001F_var*
//#UC END# *460127AC0157_45F6583E001F_var*
begin
//#UC START# *460127AC0157_45F6583E001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127AC0157_45F6583E001F_impl*
end;//View.alloc_new_node

function View.alloc_new_view: ViewBase;
//#UC START# *460127E400EA_45F6583E001F_var*
//#UC END# *460127E400EA_45F6583E001F_var*
begin
//#UC START# *460127E400EA_45F6583E001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127E400EA_45F6583E001F_impl*
end;//View.alloc_new_view

//#UC START# *45F6583E001Fimpl*
//#UC END# *45F6583E001Fimpl*

end.
