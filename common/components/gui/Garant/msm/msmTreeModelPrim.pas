unit msmTreeModelPrim;

// Модуль: "w:\common\components\gui\Garant\msm\msmTreeModelPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmTreeModelPrim" MUID: (57B198B401A7)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListLikeModel
 , msmConcreteModels
 , msmElementViews
 , msmModelElements
;

type
 TmsmTreeModelPrim = {abstract} class(TmsmListLikeModel, ImsmTreeModel)
  protected
   f_Tree: ImsmModelElementTree;
  protected
   function Get_Tree: ImsmModelElementTree;
   function DoGetList: ImsmModelElementStringList; override;
   procedure DoShowElementAsList(const anElement: ImsmModelElement); override;
   procedure ClearFields; override;
 end;//TmsmTreeModelPrim

implementation

uses
 l3ImplUses
 //#UC START# *57B198B401A7impl_uses*
 //#UC END# *57B198B401A7impl_uses*
;

function TmsmTreeModelPrim.Get_Tree: ImsmModelElementTree;
//#UC START# *57ADC5D70104_57B198B401A7get_var*
//#UC END# *57ADC5D70104_57B198B401A7get_var*
begin
//#UC START# *57ADC5D70104_57B198B401A7get_impl*
 Result := f_Tree;
//#UC END# *57ADC5D70104_57B198B401A7get_impl*
end;//TmsmTreeModelPrim.Get_Tree

function TmsmTreeModelPrim.DoGetList: ImsmModelElementStringList;
//#UC START# *57D271E300C2_57B198B401A7_var*
//#UC END# *57D271E300C2_57B198B401A7_var*
begin
//#UC START# *57D271E300C2_57B198B401A7_impl*
 Result := f_Tree.As_ImsmModelElementStringList;
//#UC END# *57D271E300C2_57B198B401A7_impl*
end;//TmsmTreeModelPrim.DoGetList

procedure TmsmTreeModelPrim.DoShowElementAsList(const anElement: ImsmModelElement);
//#UC START# *57D2A7D900FE_57B198B401A7_var*
//#UC END# *57D2A7D900FE_57B198B401A7_var*
begin
//#UC START# *57D2A7D900FE_57B198B401A7_impl*
 Assert(false);
 Set_CurrentElement(anElement);
//#UC END# *57D2A7D900FE_57B198B401A7_impl*
end;//TmsmTreeModelPrim.DoShowElementAsList

procedure TmsmTreeModelPrim.ClearFields;
begin
 f_Tree := nil;
 inherited;
end;//TmsmTreeModelPrim.ClearFields

end.
