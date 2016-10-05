unit msmCurrentElementSynchronizeBinding;

// Модуль: "w:\common\components\gui\Garant\msm\msmCurrentElementSynchronizeBinding.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmCurrentElementSynchronizeBinding" MUID: (57D1737F03CB)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListToListBinding
 , msmEvents
;

type
 TmsmCurrentElementSynchronizeBinding = class(TmsmListToListBinding)
  protected
   procedure DoCurrentElementChangedEvent(anEvent: TmsmEvent);
   procedure LinkEventHandlers; override;
 end;//TmsmCurrentElementSynchronizeBinding

implementation

uses
 l3ImplUses
 , msmListAndTreeInterfaces
 //#UC START# *57D1737F03CBimpl_uses*
 //#UC END# *57D1737F03CBimpl_uses*
;

procedure TmsmCurrentElementSynchronizeBinding.DoCurrentElementChangedEvent(anEvent: TmsmEvent);
//#UC START# *57D1737F03CB_57B31D1000FA_57D1737F03CB_var*
//#UC END# *57D1737F03CB_57B31D1000FA_57D1737F03CB_var*
begin
//#UC START# *57D1737F03CB_57B31D1000FA_57D1737F03CB_impl*
 if (ModelToFire.CurrentElement = nil) then
 begin
  if (ModelToListen.CurrentElement <> nil) then
   ModelToFire.CurrentElement := ModelToListen.CurrentElement;
 end//ModelToFire.CurrentElement = nil
 else
 if not ModelToFire.CurrentElement.IsSameElementView(ModelToListen.CurrentElement) then
  ModelToFire.CurrentElement := ModelToListen.CurrentElement;
//#UC END# *57D1737F03CB_57B31D1000FA_57D1737F03CB_impl*
end;//TmsmCurrentElementSynchronizeBinding.DoCurrentElementChangedEvent

procedure TmsmCurrentElementSynchronizeBinding.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(CurrentElementChangedEvent.Instance, DoCurrentElementChangedEvent);
end;//TmsmCurrentElementSynchronizeBinding.LinkEventHandlers

end.
