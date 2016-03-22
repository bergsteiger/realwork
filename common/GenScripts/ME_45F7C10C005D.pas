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
   procedure fire(const notify: INotification);
  public
   class function make_tree(name: TAttributeTag): TreeBase; virtual;
 //#UC START# *45F7C10C005Dpubl*
 //#UC END# *45F7C10C005Dpubl*
 end;//NodeServerTree

implementation

uses
 l3ImplUses
;

class function NodeServerTree.make_tree(name: TAttributeTag): TreeBase;
//#UC START# *45F7C1B5035B_45F7C10C005D_var*
//#UC END# *45F7C1B5035B_45F7C10C005D_var*
begin
//#UC START# *45F7C1B5035B_45F7C10C005D_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F7C1B5035B_45F7C10C005D_impl*
end;//NodeServerTree.make_tree

procedure NodeServerTree.fire(const notify: INotification);
//#UC START# *45EEDE9D01C5_45F7C10C005D_var*
//#UC END# *45EEDE9D01C5_45F7C10C005D_var*
begin
//#UC START# *45EEDE9D01C5_45F7C10C005D_impl*
 !!! Needs to be implemented !!!
//#UC END# *45EEDE9D01C5_45F7C10C005D_impl*
end;//NodeServerTree.fire

//#UC START# *45F7C10C005Dimpl*
//#UC END# *45F7C10C005Dimpl*

end.
