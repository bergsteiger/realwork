{$IfNDef msmEventsSubscriber_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmEventsSubscriber.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmEventsSubscriber" MUID: (580A14280364)
// Имя типа: "_msmEventsSubscriber_"

{$Define msmEventsSubscriber_imp}

 _msmEventsSubscriberPrim_Parent_ = _msmEventsSubscriber_Parent_;
 {$Include w:\common\components\gui\Garant\msm\msmEventsSubscriberPrim.imp.pas}
 _msmEventsSubscriber_ = {abstract} class(_msmEventsSubscriberPrim_)
  protected
   function Publisher: ImsmEventsPublisher; virtual; abstract;
   procedure InitFields; override;
   procedure BeforeRelease; override;
 end;//_msmEventsSubscriber_

{$Else msmEventsSubscriber_imp}

{$IfNDef msmEventsSubscriber_imp_impl}

{$Define msmEventsSubscriber_imp_impl}

{$Include w:\common\components\gui\Garant\msm\msmEventsSubscriberPrim.imp.pas}

procedure _msmEventsSubscriber_.InitFields;
//#UC START# *47A042E100E2_580A14280364_var*
//#UC END# *47A042E100E2_580A14280364_var*
begin
//#UC START# *47A042E100E2_580A14280364_impl*
 inherited;
 if (Publisher <> nil) then
  Publisher.AddEventsSubscriber(Self);
//#UC END# *47A042E100E2_580A14280364_impl*
end;//_msmEventsSubscriber_.InitFields

procedure _msmEventsSubscriber_.BeforeRelease;
//#UC START# *49BFC98902FF_580A14280364_var*
//#UC END# *49BFC98902FF_580A14280364_var*
begin
//#UC START# *49BFC98902FF_580A14280364_impl*
 inherited;
 if (Publisher <> nil) then
  Publisher.RemoveEventsSubscriber(Self);
//#UC END# *49BFC98902FF_580A14280364_impl*
end;//_msmEventsSubscriber_.BeforeRelease

{$EndIf msmEventsSubscriber_imp_impl}

{$EndIf msmEventsSubscriber_imp}

