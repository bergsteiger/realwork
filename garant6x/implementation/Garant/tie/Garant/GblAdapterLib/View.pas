unit View;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\View.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "View" MUID: (45F6583E001F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , ViewBase
 , RealNodeBase
 , DefaultNodeBase
 //#UC START# *45F6583E001Fintf_uses*
 //#UC END# *45F6583E001Fintf_uses*
;

type
 //#UC START# *45F6583E001Fci*
 //#UC END# *45F6583E001Fci*
 //#UC START# *45F6583E001Fcit*
 //#UC END# *45F6583E001Fcit*
 View = {abstract} class(ViewBase)
  protected
   function AllocNewNode(const snode): DefaultNodeBase; override;
   function AllocNewView: ViewBase; override;
  public
   constructor Make; reintroduce; virtual; stdcall;
   function ApplyCreatedNode(const data): RealNodeBase; override;
   procedure FindCreatedUid(var node: RealNodeBase); override;
   procedure AssociateNodeWithUid(var node: RealNodeBase); override;
   procedure DisassociateNodeWithUid(var node: RealNodeBase); override;
 //#UC START# *45F6583E001Fpubl*
 //#UC END# *45F6583E001Fpubl*
 end;//View

implementation

uses
 l3ImplUses
 //#UC START# *45F6583E001Fimpl_uses*
 //#UC END# *45F6583E001Fimpl_uses*
;

constructor View.Make;
//#UC START# *45F65B2F01B5_45F6583E001F_var*
//#UC END# *45F65B2F01B5_45F6583E001F_var*
begin
//#UC START# *45F65B2F01B5_45F6583E001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F65B2F01B5_45F6583E001F_impl*
end;//View.Make

function View.ApplyCreatedNode(const data): RealNodeBase;
//#UC START# *460125E60203_45F6583E001F_var*
//#UC END# *460125E60203_45F6583E001F_var*
begin
//#UC START# *460125E60203_45F6583E001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *460125E60203_45F6583E001F_impl*
end;//View.ApplyCreatedNode

procedure View.FindCreatedUid(var node: RealNodeBase);
//#UC START# *46012631034B_45F6583E001F_var*
//#UC END# *46012631034B_45F6583E001F_var*
begin
//#UC START# *46012631034B_45F6583E001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012631034B_45F6583E001F_impl*
end;//View.FindCreatedUid

procedure View.AssociateNodeWithUid(var node: RealNodeBase);
//#UC START# *46012657032C_45F6583E001F_var*
//#UC END# *46012657032C_45F6583E001F_var*
begin
//#UC START# *46012657032C_45F6583E001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012657032C_45F6583E001F_impl*
end;//View.AssociateNodeWithUid

procedure View.DisassociateNodeWithUid(var node: RealNodeBase);
//#UC START# *4601267E0177_45F6583E001F_var*
//#UC END# *4601267E0177_45F6583E001F_var*
begin
//#UC START# *4601267E0177_45F6583E001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601267E0177_45F6583E001F_impl*
end;//View.DisassociateNodeWithUid

function View.AllocNewNode(const snode): DefaultNodeBase;
//#UC START# *460127AC0157_45F6583E001F_var*
//#UC END# *460127AC0157_45F6583E001F_var*
begin
//#UC START# *460127AC0157_45F6583E001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127AC0157_45F6583E001F_impl*
end;//View.AllocNewNode

function View.AllocNewView: ViewBase;
//#UC START# *460127E400EA_45F6583E001F_var*
//#UC END# *460127E400EA_45F6583E001F_var*
begin
//#UC START# *460127E400EA_45F6583E001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127E400EA_45F6583E001F_impl*
end;//View.AllocNewView

//#UC START# *45F6583E001Fimpl*
//#UC END# *45F6583E001Fimpl*

end.
