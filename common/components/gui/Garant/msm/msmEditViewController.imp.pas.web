{$IfNDef msmEditViewController_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmEditViewController.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmEditViewController" MUID: (57FBA9B70217)
// Имя типа: "_msmEditViewController_"

{$Define msmEditViewController_imp}

 _ConcreteModel_ = ImsmCaptionModel;
 _InitContext_ = TmsmEditViewInitContext;
 {$Include w:\common\components\gui\Garant\msm\msmConcreteModelOwnViewController.imp.pas}
 _msmEditViewController_ = class(_msmConcreteModelOwnViewController_)
  protected
   procedure DoTextChange(Sender: TObject); virtual;
   procedure DoCaptionChangedEvent(anEvent: TmsmEvent);
   procedure InitOwnView; override;
   procedure LinkDataToView; override;
   procedure LinkEventHandlers; override;
 end;//_msmEditViewController_

{$Else msmEditViewController_imp}

{$IfNDef msmEditViewController_imp_impl}

{$Define msmEditViewController_imp_impl}

{$Include w:\common\components\gui\Garant\msm\msmConcreteModelOwnViewController.imp.pas}

procedure _msmEditViewController_.DoTextChange(Sender: TObject);
//#UC START# *57FBAD4B01C7_57FBA9B70217_var*
//#UC END# *57FBAD4B01C7_57FBA9B70217_var*
begin
//#UC START# *57FBAD4B01C7_57FBA9B70217_impl*
 Self.Model.Caption := TtfwCStringFactory.C(OwnView.Text);
//#UC END# *57FBAD4B01C7_57FBA9B70217_impl*
end;//_msmEditViewController_.DoTextChange

procedure _msmEditViewController_.DoCaptionChangedEvent(anEvent: TmsmEvent);
//#UC START# *57FBA9B70217_57CD31A200FA_57FBA9B70217_var*
//#UC END# *57FBA9B70217_57CD31A200FA_57FBA9B70217_var*
begin
//#UC START# *57FBA9B70217_57CD31A200FA_57FBA9B70217_impl*
 inherited;
 LinkDataToView;
//#UC END# *57FBA9B70217_57CD31A200FA_57FBA9B70217_impl*
end;//_msmEditViewController_.DoCaptionChangedEvent

procedure _msmEditViewController_.InitOwnView;
//#UC START# *57ADFB33027D_57FBA9B70217_var*
//#UC END# *57ADFB33027D_57FBA9B70217_var*
begin
//#UC START# *57ADFB33027D_57FBA9B70217_impl*
 inherited;
 OwnView.AutoSelect := false;
 OwnView.OnTextChange := Self.DoTextChange;
 OwnView.Enabled := not InitContext.rDisabled;
 OwnView.ReadOnly := InitContext.rReadOnly;
//#UC END# *57ADFB33027D_57FBA9B70217_impl*
end;//_msmEditViewController_.InitOwnView

procedure _msmEditViewController_.LinkDataToView;
//#UC START# *57B6A49900F4_57FBA9B70217_var*
//#UC END# *57B6A49900F4_57FBA9B70217_var*
begin
//#UC START# *57B6A49900F4_57FBA9B70217_impl*
 inherited;
 if l3IsNil(Model.Caption) then
 begin
  if not OwnView.TextSource.HasDocument then
   OwnView.TextSource.New
  else
   OwnView.Text := '';
 end//l3IsNil(Model.Caption)
 else
  OwnView.Text := l3Str(Model.Caption);
//#UC END# *57B6A49900F4_57FBA9B70217_impl*
end;//_msmEditViewController_.LinkDataToView

procedure _msmEditViewController_.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(CaptionChangedEvent.Instance, DoCaptionChangedEvent);
end;//_msmEditViewController_.LinkEventHandlers

{$EndIf msmEditViewController_imp_impl}

{$EndIf msmEditViewController_imp}

