{$IfNDef msmMETreeViewController_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmMETreeViewController.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmMETreeViewController" MUID: (57C981AF03C7)
// Имя типа: "_msmMETreeViewController_"

{$Define msmMETreeViewController_imp}

 _msmTreeViewController_Parent_ = _msmMETreeViewController_Parent_;
 {$Include w:\common\components\gui\Garant\msm\msmTreeViewController.imp.pas}
 _msmMEListLikeViewController_Parent_ = _msmTreeViewController_;
 {$Include w:\common\components\gui\Garant\msm\msmMEListLikeViewController.imp.pas}
 _msmMETreeViewController_ = {abstract} class(_msmMEListLikeViewController_)
  protected
   procedure DoFire(anEvent: TmsmEvent); override;
 end;//_msmMETreeViewController_

{$Else msmMETreeViewController_imp}

{$IfNDef msmMETreeViewController_imp_impl}

{$Define msmMETreeViewController_imp_impl}

{$Include w:\common\components\gui\Garant\msm\msmTreeViewController.imp.pas}

{$Include w:\common\components\gui\Garant\msm\msmMEListLikeViewController.imp.pas}

procedure _msmMETreeViewController_.DoFire(anEvent: TmsmEvent);
//#UC START# *57ADDC3A0071_57C981AF03C7_var*
//#UC END# *57ADDC3A0071_57C981AF03C7_var*
begin
//#UC START# *57ADDC3A0071_57C981AF03C7_impl*
 inherited;
 if (anEvent = CurrentElementChangedEvent.Instance) then
  OwnView.GotoOnNode(Model.Tree.NodeByElement(Model.CurrentElement));
//#UC END# *57ADDC3A0071_57C981AF03C7_impl*
end;//_msmMETreeViewController_.DoFire

{$EndIf msmMETreeViewController_imp_impl}

{$EndIf msmMETreeViewController_imp}

