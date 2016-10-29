{$IfNDef msmEventsPublisher_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmEventsPublisher.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmEventsPublisher" MUID: (57B6B275018D)
// Имя типа: "_msmEventsPublisher_"

{$Define msmEventsPublisher_imp}

 _msmEventsPublisher_ = {abstract} class(_msmEventsPublisher_Parent_)
  private
   f_Subscribers: TImsmEventsSubscriberList;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure AddEventsSubscriber(const aListener: ImsmEventsSubscriber);
   procedure RemoveEventsSubscriber(const aListener: ImsmEventsSubscriber);
 end;//_msmEventsPublisher_

{$Else msmEventsPublisher_imp}

{$IfNDef msmEventsPublisher_imp_impl}

{$Define msmEventsPublisher_imp_impl}

procedure _msmEventsPublisher_.AddEventsSubscriber(const aListener: ImsmEventsSubscriber);
//#UC START# *57B4228B001E_57B6B275018D_var*
//#UC END# *57B4228B001E_57B6B275018D_var*
begin
//#UC START# *57B4228B001E_57B6B275018D_impl*
 if (f_Subscribers = nil) then
  f_Subscribers := TImsmEventsSubscriberList.Create;
 f_Subscribers.Add(aListener);
//#UC END# *57B4228B001E_57B6B275018D_impl*
end;//_msmEventsPublisher_.AddEventsSubscriber

procedure _msmEventsPublisher_.RemoveEventsSubscriber(const aListener: ImsmEventsSubscriber);
//#UC START# *57B422AB0293_57B6B275018D_var*
//#UC END# *57B422AB0293_57B6B275018D_var*
begin
//#UC START# *57B422AB0293_57B6B275018D_impl*
 if (f_Subscribers <> nil) then
  f_Subscribers.Remove(aListener); 
//#UC END# *57B422AB0293_57B6B275018D_impl*
end;//_msmEventsPublisher_.RemoveEventsSubscriber

procedure _msmEventsPublisher_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57B6B275018D_var*
//#UC END# *479731C50290_57B6B275018D_var*
begin
//#UC START# *479731C50290_57B6B275018D_impl*
 FreeAndNil(f_Subscribers);
 inherited;
//#UC END# *479731C50290_57B6B275018D_impl*
end;//_msmEventsPublisher_.Cleanup

{$EndIf msmEventsPublisher_imp_impl}

{$EndIf msmEventsPublisher_imp}

