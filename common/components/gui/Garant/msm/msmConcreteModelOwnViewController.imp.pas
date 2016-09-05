{$IfNDef msmConcreteModelOwnViewController_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmConcreteModelOwnViewController.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmConcreteModelOwnViewController" MUID: (57B179D70299)
// Имя типа: "_msmConcreteModelOwnViewController_"

{$Define msmConcreteModelOwnViewController_imp}

 {$Include w:\common\components\gui\Garant\msm\msmOwnViewController.imp.pas}
 _msmConcreteModelOwnViewControllerMixin_Parent_ = _msmOwnViewController_;
 {$Include w:\common\components\gui\Garant\msm\msmConcreteModelOwnViewControllerMixin.imp.pas}
 _msmConcreteModelOwnViewController_ = {abstract} class(_msmConcreteModelOwnViewControllerMixin_)
 end;//_msmConcreteModelOwnViewController_

{$Else msmConcreteModelOwnViewController_imp}

{$IfNDef msmConcreteModelOwnViewController_imp_impl}

{$Define msmConcreteModelOwnViewController_imp_impl}

{$Include w:\common\components\gui\Garant\msm\msmOwnViewController.imp.pas}

{$Include w:\common\components\gui\Garant\msm\msmConcreteModelOwnViewControllerMixin.imp.pas}

{$EndIf msmConcreteModelOwnViewController_imp_impl}

{$EndIf msmConcreteModelOwnViewController_imp}

