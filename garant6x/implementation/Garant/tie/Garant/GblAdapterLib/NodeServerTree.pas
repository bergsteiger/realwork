unit NodeServerTree;
 {* Адаптерное дерево, с кешом сервантов (эмуляция мультифабрики) }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\NodeServerTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "NodeServerTree" MUID: (45F7C10C005D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , ree
 , NotifyUnit
 , reeBase
 , SearchDefinesUnit
 //#UC START# *45F7C10C005Dintf_uses*
 //#UC END# *45F7C10C005Dintf_uses*
;

type
 //#UC START# *45F7C10C005Dci*
 //#UC END# *45F7C10C005Dci*
 //#UC START# *45F7C10C005Dcit*
 //#UC END# *45F7C10C005Dcit*
 NodeServerTree = {abstract} class(Tree, IListener)
  {* Адаптерное дерево, с кешом сервантов (эмуляция мультифабрики) }
  public
   NodeDelegateType_: ;
  protected
   procedure Fire(const notify: INotification); stdcall;
  public
   class function MakeTree(name: TAttributeTag): TreeBase; virtual; stdcall;
 //#UC START# *45F7C10C005Dpubl*
 //#UC END# *45F7C10C005Dpubl*
 end;//NodeServerTree

implementation

uses
 l3ImplUses
 //#UC START# *45F7C10C005Dimpl_uses*
 //#UC END# *45F7C10C005Dimpl_uses*
;

class function NodeServerTree.MakeTree(name: TAttributeTag): TreeBase;
//#UC START# *45F7C1B5035B_45F7C10C005D_var*
//#UC END# *45F7C1B5035B_45F7C10C005D_var*
begin
//#UC START# *45F7C1B5035B_45F7C10C005D_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F7C1B5035B_45F7C10C005D_impl*
end;//NodeServerTree.MakeTree

procedure NodeServerTree.Fire(const notify: INotification);
//#UC START# *45EEDE9D01C5_45F7C10C005D_var*
//#UC END# *45EEDE9D01C5_45F7C10C005D_var*
begin
//#UC START# *45EEDE9D01C5_45F7C10C005D_impl*
 !!! Needs to be implemented !!!
//#UC END# *45EEDE9D01C5_45F7C10C005D_impl*
end;//NodeServerTree.Fire

//#UC START# *45F7C10C005Dimpl*
//#UC END# *45F7C10C005Dimpl*

end.
