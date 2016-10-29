{$IfNDef msmEventsSubscriberPrim_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmEventsSubscriberPrim.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmEventsSubscriberPrim" MUID: (57B6B5D00202)
// Имя типа: "_msmEventsSubscriberPrim_"

{$Define msmEventsSubscriberPrim_imp}

 _msmEventsSubscriberPrim_ = {abstract} class(_msmEventsSubscriberPrim_Parent_, ImsmEventsSubscriber)
  private
   f_DisabledEvents: TmsmEventList;
   f_EnabledEvents: TmsmEventList;
   f_EventHandlers: TmsmEventHandlers;
  protected
   procedure DoFire(anEvent: TmsmEvent); virtual;
   procedure LinkEventHandlers; virtual;
   procedure LinkEventHandler(anEvent: TmsmEvent;
    aHandler: TmsmEventHandler);
   procedure DoHandleEvent(anEvent: TmsmEvent); virtual;
   procedure HandleEvent(anEvent: TmsmEvent);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure BeforeRelease; override;
  public
   procedure DisableEvent(anEvent: TmsmEvent);
   procedure EnableEvent(anEvent: TmsmEvent);
 end;//_msmEventsSubscriberPrim_

{$Else msmEventsSubscriberPrim_imp}

{$IfNDef msmEventsSubscriberPrim_imp_impl}

{$Define msmEventsSubscriberPrim_imp_impl}

procedure _msmEventsSubscriberPrim_.DoFire(anEvent: TmsmEvent);
//#UC START# *57ADDC3A0071_57B6B5D00202_var*
//#UC END# *57ADDC3A0071_57B6B5D00202_var*
begin
//#UC START# *57ADDC3A0071_57B6B5D00202_impl*
//#UC END# *57ADDC3A0071_57B6B5D00202_impl*
end;//_msmEventsSubscriberPrim_.DoFire

procedure _msmEventsSubscriberPrim_.LinkEventHandlers;
//#UC START# *57CD83CA037F_57B6B5D00202_var*
//#UC END# *57CD83CA037F_57B6B5D00202_var*
begin
//#UC START# *57CD83CA037F_57B6B5D00202_impl*
 // - всё должен делать потомок
//#UC END# *57CD83CA037F_57B6B5D00202_impl*
end;//_msmEventsSubscriberPrim_.LinkEventHandlers

procedure _msmEventsSubscriberPrim_.LinkEventHandler(anEvent: TmsmEvent;
 aHandler: TmsmEventHandler);
//#UC START# *57CD83DE0170_57B6B5D00202_var*
//#UC END# *57CD83DE0170_57B6B5D00202_var*
begin
//#UC START# *57CD83DE0170_57B6B5D00202_impl*
 if (f_EventHandlers = nil) then
  f_EventHandlers := TmsmEventHandlers.Create;
 f_EventHandlers.Add(anEvent, aHandler);
//#UC END# *57CD83DE0170_57B6B5D00202_impl*
end;//_msmEventsSubscriberPrim_.LinkEventHandler

procedure _msmEventsSubscriberPrim_.DoHandleEvent(anEvent: TmsmEvent);
//#UC START# *580A1AD9019C_57B6B5D00202_var*
//#UC END# *580A1AD9019C_57B6B5D00202_var*
begin
//#UC START# *580A1AD9019C_57B6B5D00202_impl*
 if (f_DisabledEvents = nil) OR
    (f_DisabledEvents.IndexOf(anEvent) < 0) then
 begin
  if (f_EnabledEvents = nil) OR
     f_EnabledEvents.Empty OR
     (f_EnabledEvents.IndexOf(anEvent) >= 0) then
  begin
   if (f_EventHandlers<> nil) AND
      f_EventHandlers.Has(anEvent) then
    f_EventHandlers.ValueByKey(anEvent)(anEvent)
   else
    DoFire(anEvent);
  end;//f_EnabledEvents = nil..
 end;//f_DisabledEvents = nil..
//#UC END# *580A1AD9019C_57B6B5D00202_impl*
end;//_msmEventsSubscriberPrim_.DoHandleEvent

procedure _msmEventsSubscriberPrim_.HandleEvent(anEvent: TmsmEvent);
//#UC START# *57AD8E570241_57B6B5D00202_var*
//#UC END# *57AD8E570241_57B6B5D00202_var*
begin
//#UC START# *57AD8E570241_57B6B5D00202_impl*
 DoHandleEvent(anEvent);
//#UC END# *57AD8E570241_57B6B5D00202_impl*
end;//_msmEventsSubscriberPrim_.HandleEvent

procedure _msmEventsSubscriberPrim_.DisableEvent(anEvent: TmsmEvent);
//#UC START# *57B59F2B03A1_57B6B5D00202_var*
//#UC END# *57B59F2B03A1_57B6B5D00202_var*
begin
//#UC START# *57B59F2B03A1_57B6B5D00202_impl*
 if (f_DisabledEvents = nil) then
  f_DisabledEvents := TmsmEventList.Create;
 f_DisabledEvents.Add(anEvent); 
//#UC END# *57B59F2B03A1_57B6B5D00202_impl*
end;//_msmEventsSubscriberPrim_.DisableEvent

procedure _msmEventsSubscriberPrim_.EnableEvent(anEvent: TmsmEvent);
//#UC START# *57CD7F790309_57B6B5D00202_var*
//#UC END# *57CD7F790309_57B6B5D00202_var*
begin
//#UC START# *57CD7F790309_57B6B5D00202_impl*
 if (f_EnabledEvents = nil) then
  f_EnabledEvents := TmsmEventList.Create;
 f_EnabledEvents.Add(anEvent);
//#UC END# *57CD7F790309_57B6B5D00202_impl*
end;//_msmEventsSubscriberPrim_.EnableEvent

procedure _msmEventsSubscriberPrim_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57B6B5D00202_var*
//#UC END# *479731C50290_57B6B5D00202_var*
begin
//#UC START# *479731C50290_57B6B5D00202_impl*
 FreeAndNil(f_DisabledEvents);
 FreeAndNil(f_EnabledEvents);
 FreeAndNil(f_EventHandlers);
 inherited;
//#UC END# *479731C50290_57B6B5D00202_impl*
end;//_msmEventsSubscriberPrim_.Cleanup

procedure _msmEventsSubscriberPrim_.InitFields;
//#UC START# *47A042E100E2_57B6B5D00202_var*
//#UC END# *47A042E100E2_57B6B5D00202_var*
begin
//#UC START# *47A042E100E2_57B6B5D00202_impl*
 inherited;
 LinkEventHandlers;
//#UC END# *47A042E100E2_57B6B5D00202_impl*
end;//_msmEventsSubscriberPrim_.InitFields

procedure _msmEventsSubscriberPrim_.BeforeRelease;
//#UC START# *49BFC98902FF_57B6B5D00202_var*
//#UC END# *49BFC98902FF_57B6B5D00202_var*
begin
//#UC START# *49BFC98902FF_57B6B5D00202_impl*
 inherited;
//#UC END# *49BFC98902FF_57B6B5D00202_impl*
end;//_msmEventsSubscriberPrim_.BeforeRelease

{$EndIf msmEventsSubscriberPrim_imp_impl}

{$EndIf msmEventsSubscriberPrim_imp}

