{$IfNDef msmTreeModel_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmTreeModel.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmTreeModel" MUID: (57B198B401A7)
// Имя типа: "_msmTreeModel_"

{$Define msmTreeModel_imp}

 {$Include w:\common\components\gui\Garant\msm\msmListLikeModel.imp.pas}
 _msmTreeModel_ = {abstract} class(_msmListLikeModel_, ImsmTreeModel)
  private
   f_Tree: ImsmModelElementTree;
  protected
   function Get_Tree: ImsmModelElementTree;
   function DoGetList: ImsmModelElementStringList; override;
   procedure DoShowElementAsList(const anElement: ImsmModelElement); override;
   procedure ClearFields; override;
 end;//_msmTreeModel_

{$Else msmTreeModel_imp}

{$IfNDef msmTreeModel_imp_impl}

{$Define msmTreeModel_imp_impl}

{$Include w:\common\components\gui\Garant\msm\msmListLikeModel.imp.pas}

function _msmTreeModel_.Get_Tree: ImsmModelElementTree;
//#UC START# *57ADC5D70104_57B198B401A7get_var*
//#UC END# *57ADC5D70104_57B198B401A7get_var*
begin
//#UC START# *57ADC5D70104_57B198B401A7get_impl*
 Result := f_Tree;
//#UC END# *57ADC5D70104_57B198B401A7get_impl*
end;//_msmTreeModel_.Get_Tree

function _msmTreeModel_.DoGetList: ImsmModelElementStringList;
//#UC START# *57D271E300C2_57B198B401A7_var*
//#UC END# *57D271E300C2_57B198B401A7_var*
begin
//#UC START# *57D271E300C2_57B198B401A7_impl*
 Result := f_Tree.As_ImsmModelElementStringList;
//#UC END# *57D271E300C2_57B198B401A7_impl*
end;//_msmTreeModel_.DoGetList

procedure _msmTreeModel_.DoShowElementAsList(const anElement: ImsmModelElement);
//#UC START# *57D2A7D900FE_57B198B401A7_var*
//#UC END# *57D2A7D900FE_57B198B401A7_var*
begin
//#UC START# *57D2A7D900FE_57B198B401A7_impl*
 Assert(false);
 Set_CurrentElement(anElement);
//#UC END# *57D2A7D900FE_57B198B401A7_impl*
end;//_msmTreeModel_.DoShowElementAsList

procedure _msmTreeModel_.ClearFields;
begin
 f_Tree := nil;
 inherited;
end;//_msmTreeModel_.ClearFields

{$EndIf msmTreeModel_imp_impl}

{$EndIf msmTreeModel_imp}

