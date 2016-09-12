unit msmListOwnerToCurrentElementBinding;

// Модуль: "w:\common\components\gui\Garant\msm\msmListOwnerToCurrentElementBinding.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListOwnerToCurrentElementBinding" MUID: (57C9A3B200E2)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListToListBinding
 , msmEvents
;

type
 TmsmListOwnerToCurrentElementBinding = class(TmsmListToListBinding)
  protected
   procedure DoListChangedEvent(anEvent: TmsmEvent);
   procedure LinkEventHandlers; override;
 end;//TmsmListOwnerToCurrentElementBinding

implementation

uses
 l3ImplUses
 , msmListAndTreeInterfaces
 //#UC START# *57C9A3B200E2impl_uses*
 , msmModelElements
 //#UC END# *57C9A3B200E2impl_uses*
;

procedure TmsmListOwnerToCurrentElementBinding.DoListChangedEvent(anEvent: TmsmEvent);
//#UC START# *57C9A3B200E2_57ADBA39026E_57C9A3B200E2_var*
var
 l_O : ImsmModelElement;
//#UC END# *57C9A3B200E2_57ADBA39026E_57C9A3B200E2_var*
begin
//#UC START# *57C9A3B200E2_57ADBA39026E_57C9A3B200E2_impl*
 inherited;
 l_O := Self.ModelToListen.List.Owner;
 if (Self.ModelToFire.CurrentElement = nil) then
 begin
  if (l_O <> nil) then
   Self.ModelToFire.CurrentElement := l_O;
 end//Self.ModelToFire.CurrentElement
 else
 if not Self.ModelToFire.CurrentElement.IsSameElement(l_O) then
  Self.ModelToFire.CurrentElement := l_O;
//#UC END# *57C9A3B200E2_57ADBA39026E_57C9A3B200E2_impl*
end;//TmsmListOwnerToCurrentElementBinding.DoListChangedEvent

procedure TmsmListOwnerToCurrentElementBinding.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(ListChangedEvent.Instance, DoListChangedEvent);
end;//TmsmListOwnerToCurrentElementBinding.LinkEventHandlers

end.
