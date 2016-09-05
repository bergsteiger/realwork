{$IfNDef msmTreeViewController_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmTreeViewController.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmTreeViewController" MUID: (57C97EB8036C)
// Имя типа: "_msmTreeViewController_"

{$Define msmTreeViewController_imp}

 _msmListLikeViewController_Parent_ = _msmTreeViewController_Parent_;
 {$Include w:\common\components\gui\Garant\msm\msmListLikeViewController.imp.pas}
 _msmTreeViewController_ = {abstract} class(_msmListLikeViewController_)
  protected
   procedure LinkDataToView; override;
 end;//_msmTreeViewController_

{$Else msmTreeViewController_imp}

{$IfNDef msmTreeViewController_imp_impl}

{$Define msmTreeViewController_imp_impl}

{$Include w:\common\components\gui\Garant\msm\msmListLikeViewController.imp.pas}

procedure _msmTreeViewController_.LinkDataToView;
//#UC START# *57B6A49900F4_57C97EB8036C_var*
//#UC END# *57B6A49900F4_57C97EB8036C_var*
begin
//#UC START# *57B6A49900F4_57C97EB8036C_impl*
 inherited;
 OwnView.ShowRoot := Self.Model.Tree.ShowRoot;
 OwnView.TreeStruct := Self.Model.Tree;
//#UC END# *57B6A49900F4_57C97EB8036C_impl*
end;//_msmTreeViewController_.LinkDataToView

{$EndIf msmTreeViewController_imp_impl}

{$EndIf msmTreeViewController_imp}

