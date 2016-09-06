unit msmListToTreeBinding;

// Модуль: "w:\common\components\gui\Garant\msm\msmListToTreeBinding.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListToTreeBinding" MUID: (57C9A3B200E2)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmConcreteModels
 , msmEvents
 , msmControllers
 , msmController
;

type
 _ModelToListen_ = ImsmListModel;
 _ModelToFire_ = ImsmTreeModel;
 {$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}
 TmsmListToTreeBinding = class(_msmModelToModelBinding_)
  protected
   procedure DoListChangedEvent(anEvent: TmsmEvent);
   procedure LinkEventHandlers; override;
 end;//TmsmListToTreeBinding

implementation

uses
 l3ImplUses
 , msmListAndTreeInterfaces
 //#UC START# *57C9A3B200E2impl_uses*
 , msmModelElements
 //#UC END# *57C9A3B200E2impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}

procedure TmsmListToTreeBinding.DoListChangedEvent(anEvent: TmsmEvent);
//#UC START# *57C9A3B200E2_57ADBA39026E_57C9A3B200E2_var*
var
 l_O : ImsmModelElement;
//#UC END# *57C9A3B200E2_57ADBA39026E_57C9A3B200E2_var*
begin
//#UC START# *57C9A3B200E2_57ADBA39026E_57C9A3B200E2_impl*
 inherited;
 l_O := Self.ModelToListen.List.Owner;
 if (Self.ModelToFire.CurrentElement <> l_O) then
  Self.ModelToFire.CurrentElement := l_O;
//#UC END# *57C9A3B200E2_57ADBA39026E_57C9A3B200E2_impl*
end;//TmsmListToTreeBinding.DoListChangedEvent

procedure TmsmListToTreeBinding.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(ListChangedEvent.Instance, DoListChangedEvent);
end;//TmsmListToTreeBinding.LinkEventHandlers

end.
