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
   procedure DoListChangedEvent(anEvent: TmsmEvent);
   procedure DoActionElementEvent(anEvent: TmsmEvent);
   procedure LinkEventHandlers; override;
 end;//_msmMEListViewController_

{$Else msmMEListViewController_imp}

{$IfNDef msmMEListViewController_imp_impl}

{$Define msmMEListViewController_imp_impl}

{$Include w:\common\components\gui\Garant\msm\msmListViewController.imp.pas}

{$Include w:\common\components\gui\Garant\msm\msmMEListLikeViewController.imp.pas}

procedure _msmMEListViewController_.DoListChangedEvent(anEvent: TmsmEvent);
//#UC START# *57C9879A032D_57ADBA39026E_57C9879A032D_var*
//#UC END# *57C9879A032D_57ADBA39026E_57C9879A032D_var*
begin
//#UC START# *57C9879A032D_57ADBA39026E_57C9879A032D_impl*
 inherited;
 LinkDataToView;
//#UC END# *57C9879A032D_57ADBA39026E_57C9879A032D_impl*
end;//_msmMEListViewController_.DoListChangedEvent

procedure _msmMEListViewController_.DoActionElementEvent(anEvent: TmsmEvent);
//#UC START# *57C9879A032D_57B2B0C602DF_57C9879A032D_var*
//#UC END# *57C9879A032D_57B2B0C602DF_57C9879A032D_var*
begin
//#UC START# *57C9879A032D_57B2B0C602DF_57C9879A032D_impl*
 inherited;
 Self.Model.ShowElementAsDir(Self.Model.ElementToAction);
//#UC END# *57C9879A032D_57B2B0C602DF_57C9879A032D_impl*
end;//_msmMEListViewController_.DoActionElementEvent

procedure _msmMEListViewController_.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(ListChangedEvent.Instance, DoListChangedEvent);
 Self.LinkEventHandler(ActionElementEvent.Instance, DoActionElementEvent);
end;//_msmMEListViewController_.LinkEventHandlers

{$EndIf msmMEListViewController_imp_impl}

{$EndIf msmMEListViewController_imp}

