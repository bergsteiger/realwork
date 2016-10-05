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
   procedure DoCurrentElementChangedEvent(anEvent: TmsmEvent);
   procedure InitOwnView; override;
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
 //LinkDataToView;
//#UC END# *57C9879A032D_57ADBA39026E_57C9879A032D_impl*
end;//_msmMEListViewController_.DoListChangedEvent

procedure _msmMEListViewController_.DoActionElementEvent(anEvent: TmsmEvent);
//#UC START# *57C9879A032D_57B2B0C602DF_57C9879A032D_var*
//#UC END# *57C9879A032D_57B2B0C602DF_57C9879A032D_var*
begin
//#UC START# *57C9879A032D_57B2B0C602DF_57C9879A032D_impl*
 inherited;
 Self.Model.ShowElementAsList(Self.Model.ElementToAction);
//#UC END# *57C9879A032D_57B2B0C602DF_57C9879A032D_impl*
end;//_msmMEListViewController_.DoActionElementEvent

procedure _msmMEListViewController_.DoCurrentElementChangedEvent(anEvent: TmsmEvent);
//#UC START# *57C9879A032D_57B31D1000FA_57C9879A032D_var*
var
 l_E : ImsmModelElement;
//#UC END# *57C9879A032D_57B31D1000FA_57C9879A032D_var*
begin
//#UC START# *57C9879A032D_57B31D1000FA_57C9879A032D_impl*
 inherited;
 if (Self.Model.List <> nil) then
 begin
  if (OwnView.Current >= 0) AND (OwnView.Current < Self.Model.List.Count) then
  begin
   l_E := Self.Model.List[OwnView.Current];
   if (l_E <> nil) AND l_E.IsSameElement(Self.Model.CurrentElement) then
    Exit;
  end;//(OwnView.Current >= 0) AND (OwnView.Current < Self.Model.List.Count)
  OwnView.Current := Self.Model.List.IndexOfElementView(Self.Model.CurrentElement);
 end;//Self.Model.List <> nil
//#UC END# *57C9879A032D_57B31D1000FA_57C9879A032D_impl*
end;//_msmMEListViewController_.DoCurrentElementChangedEvent

procedure _msmMEListViewController_.InitOwnView;
//#UC START# *57ADFB33027D_57C9879A032D_var*
//#UC END# *57ADFB33027D_57C9879A032D_var*
begin
//#UC START# *57ADFB33027D_57C9879A032D_impl*
 inherited;
 OwnView.Images := vtResources.Images;
//#UC END# *57ADFB33027D_57C9879A032D_impl*
end;//_msmMEListViewController_.InitOwnView

procedure _msmMEListViewController_.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(ListChangedEvent.Instance, DoListChangedEvent);
 Self.LinkEventHandler(ActionElementEvent.Instance, DoActionElementEvent);
 Self.LinkEventHandler(CurrentElementChangedEvent.Instance, DoCurrentElementChangedEvent);
end;//_msmMEListViewController_.LinkEventHandlers

{$EndIf msmMEListViewController_imp_impl}

{$EndIf msmMEListViewController_imp}

