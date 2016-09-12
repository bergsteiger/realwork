unit msmListOwnerShowAsListBinding;

// Модуль: "w:\common\components\gui\Garant\msm\msmListOwnerShowAsListBinding.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListOwnerShowAsListBinding" MUID: (57D28441029B)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListToListBinding
 , msmEvents
;

type
 TmsmListOwnerShowAsListBinding = class(TmsmListToListBinding)
  protected
   procedure DoListChangedEvent(anEvent: TmsmEvent);
   procedure LinkEventHandlers; override;
 end;//TmsmListOwnerShowAsListBinding

implementation

uses
 l3ImplUses
 , msmListAndTreeInterfaces
 //#UC START# *57D28441029Bimpl_uses*
 //#UC END# *57D28441029Bimpl_uses*
;

procedure TmsmListOwnerShowAsListBinding.DoListChangedEvent(anEvent: TmsmEvent);
//#UC START# *57D28441029B_57ADBA39026E_57D28441029B_var*
//#UC END# *57D28441029B_57ADBA39026E_57D28441029B_var*
begin
//#UC START# *57D28441029B_57ADBA39026E_57D28441029B_impl*
 inherited;
 if (Self.ModelToFire.List = nil)
    OR not Self.ModelToFire.List.Owner.IsSameElement(Self.ModelToListen.List.Owner)
  then
  Self.ModelToFire.ShowElementAsList(Self.ModelToListen.List.Owner);
//#UC END# *57D28441029B_57ADBA39026E_57D28441029B_impl*
end;//TmsmListOwnerShowAsListBinding.DoListChangedEvent

procedure TmsmListOwnerShowAsListBinding.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(ListChangedEvent.Instance, DoListChangedEvent);
end;//TmsmListOwnerShowAsListBinding.LinkEventHandlers

end.
