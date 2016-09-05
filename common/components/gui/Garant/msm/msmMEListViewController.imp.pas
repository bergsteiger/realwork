{$IfNDef msmMEListViewController_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmMEListViewController.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmMEListViewController" MUID: (57C9879A032D)
// Имя типа: "_msmMEListViewController_"

{$Define msmMEListViewController_imp}

 _msmListViewController_Parent_ = _msmMEListViewController_Parent_;
 {$Include w:\common\components\gui\Garant\msm\msmListViewController.imp.pas}
 _msmMEListLikeViewController_Parent_ = _msmListViewController_;
 {$Include w:\common\components\gui\Garant\msm\msmMEListLikeViewController.imp.pas}
 _msmMEListViewController_ = {abstract} class(_msmMEListLikeViewController_)
  protected
   procedure DoFire(anEvent: TmsmEvent); override;
 end;//_msmMEListViewController_

{$Else msmMEListViewController_imp}

{$IfNDef msmMEListViewController_imp_impl}

{$Define msmMEListViewController_imp_impl}

{$Include w:\common\components\gui\Garant\msm\msmListViewController.imp.pas}

{$Include w:\common\components\gui\Garant\msm\msmMEListLikeViewController.imp.pas}

procedure _msmMEListViewController_.DoFire(anEvent: TmsmEvent);
//#UC START# *57ADDC3A0071_57C9879A032D_var*
//#UC END# *57ADDC3A0071_57C9879A032D_var*
begin
//#UC START# *57ADDC3A0071_57C9879A032D_impl*
 inherited;
 if (anEvent = ListChangedEvent.Instance) then
  LinkDataToView
 else
 if (anEvent = ActionElementEvent.Instance) then
  Self.Model.ShowElementAsDir(Self.Model.ElementToAction);
//#UC END# *57ADDC3A0071_57C9879A032D_impl*
end;//_msmMEListViewController_.DoFire

{$EndIf msmMEListViewController_imp_impl}

{$EndIf msmMEListViewController_imp}

