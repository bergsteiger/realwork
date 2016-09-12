unit msmCurrentElementShowAsListBinding;

// Модуль: "w:\common\components\gui\Garant\msm\msmCurrentElementShowAsListBinding.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmCurrentElementShowAsListBinding" MUID: (57B2BA6D0104)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListToListBinding
 , msmEvents
;

type
 TmsmCurrentElementShowAsListBinding = class(TmsmListToListBinding)
  protected
   procedure DoCurrentElementChangedEvent(anEvent: TmsmEvent);
   procedure LinkEventHandlers; override;
 end;//TmsmCurrentElementShowAsListBinding

implementation

uses
 l3ImplUses
 , msmListAndTreeInterfaces
 //#UC START# *57B2BA6D0104impl_uses*
 //#UC END# *57B2BA6D0104impl_uses*
;

procedure TmsmCurrentElementShowAsListBinding.DoCurrentElementChangedEvent(anEvent: TmsmEvent);
//#UC START# *57B2BA6D0104_57B31D1000FA_57B2BA6D0104_var*
//#UC END# *57B2BA6D0104_57B31D1000FA_57B2BA6D0104_var*
begin
//#UC START# *57B2BA6D0104_57B31D1000FA_57B2BA6D0104_impl*
 inherited;
 Self.ModelToFire.ShowElementAsList(Self.ModelToListen.CurrentElement);
//#UC END# *57B2BA6D0104_57B31D1000FA_57B2BA6D0104_impl*
end;//TmsmCurrentElementShowAsListBinding.DoCurrentElementChangedEvent

procedure TmsmCurrentElementShowAsListBinding.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(CurrentElementChangedEvent.Instance, DoCurrentElementChangedEvent);
end;//TmsmCurrentElementShowAsListBinding.LinkEventHandlers

end.
