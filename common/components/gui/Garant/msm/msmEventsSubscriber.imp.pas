{$IfNDef msmEventsSubscriber_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmEventsSubscriber.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmEventsSubscriber" MUID: (57B6B5D00202)
// Имя типа: "_msmEventsSubscriber_"

{$Define msmEventsSubscriber_imp}

 _msmEventsSubscriber_ = {abstract} class(_msmEventsSubscriber_Parent_, ImsmEventsSubscriber)
  private
   f_DisabledEvents: TmsmEventList;
   f_EnabledEvents: TmsmEventList;
   f_EventHandlers: TmsmEventHandlers;
  protected
   procedure DoFire(anEvent: TmsmEvent); virtual;
   function Publisher: ImsmEventsPublisher; virtual; abstract;
   procedure LinkEventHandlers; virtual;
   procedure LinkEventHandler(anEvent: TmsmEvent;
    aHandler: TmsmEventHandler);
   procedure HandleEvent(anEvent: TmsmEvent);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure BeforeRelease; override;
  public
   procedure DisableEvent(anEvent: TmsmEvent);
   procedure EnableEvent(anEvent: TmsmEvent);
 end;//_msmEventsSubscriber_

{$Else msmEventsSubscriber_imp}

{$IfNDef msmEventsSubscriber_imp_impl}

{$Define msmEventsSubscriber_imp_impl}

procedure _msmEventsSubscriber_.DoFire(anEvent: TmsmEvent);
//#UC START# *57ADDC3A0071_57B6B5D00202_var*
//#UC END# *57ADDC3A0071_57B6B5D00202_var*
begin
//#UC START# *57ADDC3A0071_57B6B5D00202_impl*
//#UC END# *57ADDC3A0071_57B6B5D00202_impl*
end;//_msmEventsSubscriber_.DoFire

procedure _msmEventsSubscriber_.LinkEventHandlers;
//#UC START# *57CD83CA037F_57B6B5D00202_var*
//#UC END# *57CD83CA037F_57B6B5D00202_var*
begin
//#UC START# *57CD83CA037F_57B6B5D00202_impl*
 // - всё должен делать потомок
//#UC END# *57CD83CA037F_57B6B5D00202_impl*
end;//_msmEventsSubscriber_.LinkEventHandlers

procedure _msmEventsSubscriber_.LinkEventHandler(anEvent: TmsmEvent;
 aHandler: TmsmEventHandler);
//#UC START# *57CD83DE0170_57B6B5D00202_var*
//#UC END# *57CD83DE0170_57B6B5D00202_var*
begin
//#UC START# *57CD83DE0170_57B6B5D00202_impl*
 if (f_EventHandlers = nil) then
  f_EventHandlers := TmsmEventHandlers.Create;
 f_EventHandlers.Add(anEvent, aHandler);
//#UC END# *57CD83DE0170_57B6B5D00202_impl*
end;//_msmEventsSubscriber_.LinkEventHandler

procedure _msmEventsSubscriber_.HandleEvent(anEvent: TmsmEvent);
//#UC START# *57AD8E570241_57B6B5D00202_var*
//#UC END# *57AD8E570241_57B6B5D00202_var*
begin
//#UC START# *57AD8E570241_57B6B5D00202_impl*
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
//#UC END# *57AD8E570241_57B6B5D00202_impl*
end;//_msmEventsSubscriber_.HandleEvent

procedure _msmEventsSubscriber_.DisableEvent(anEvent: TmsmEvent);
//#UC START# *57B59F2B03A1_57B6B5D00202_var*
//#UC END# *57B59F2B03A1_57B6B5D00202_var*
begin
//#UC START# *57B59F2B03A1_57B6B5D00202_impl*
 if (f_DisabledEvents = nil) then
  f_DisabledEvents := TmsmEventList.Create;
 f_DisabledEvents.Add(anEvent); 
//#UC END# *57B59F2B03A1_57B6B5D00202_impl*
end;//_msmEventsSubscriber_.DisableEvent

procedure _msmEventsSubscriber_.EnableEvent(anEvent: TmsmEvent);
//#UC START# *57CD7F790309_57B6B5D00202_var*
//#UC END# *57CD7F790309_57B6B5D00202_var*
begin
//#UC START# *57CD7F790309_57B6B5D00202_impl*
 if (f_EnabledEvents = nil) then
  f_EnabledEvents := TmsmEventList.Create;
 f_EnabledEvents.Add(anEvent);
//#UC END# *57CD7F790309_57B6B5D00202_impl*
end;//_msmEventsSubscriber_.EnableEvent

procedure _msmEventsSubscriber_.Cleanup;
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
end;//_msmEventsSubscriber_.Cleanup

procedure _msmEventsSubscriber_.InitFields;
//#UC START# *47A042E100E2_57B6B5D00202_var*
//#UC END# *47A042E100E2_57B6B5D00202_var*
begin
//#UC START# *47A042E100E2_57B6B5D00202_impl*
 inherited;
 LinkEventHandlers;
 Publisher.Subscribe(Self);
//#UC END# *47A042E100E2_57B6B5D00202_impl*
end;//_msmEventsSubscriber_.InitFields

procedure _msmEventsSubscriber_.BeforeRelease;
//#UC START# *49BFC98902FF_57B6B5D00202_var*
//#UC END# *49BFC98902FF_57B6B5D00202_var*
begin
//#UC START# *49BFC98902FF_57B6B5D00202_impl*
 inherited;
 Publisher.Unsubscribe(Self);
//#UC END# *49BFC98902FF_57B6B5D00202_impl*
end;//_msmEventsSubscriber_.BeforeRelease

{$EndIf msmEventsSubscriber_imp_impl}

{$EndIf msmEventsSubscriber_imp}

