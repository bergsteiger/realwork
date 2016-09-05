unit msmListToListBinding;

// Модуль: "w:\common\components\gui\Garant\msm\msmListToListBinding.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListToListBinding" MUID: (57B329AF021D)

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
 _ModelToFire_ = ImsmListModel;
 {$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}
 TmsmListToListBinding = class(_msmModelToModelBinding_)
  protected
   procedure DoFire(anEvent: TmsmEvent); override;
 end;//TmsmListToListBinding

implementation

uses
 l3ImplUses
 , msmListAndTreeInterfaces
 //#UC START# *57B329AF021Dimpl_uses*
 //#UC END# *57B329AF021Dimpl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}

procedure TmsmListToListBinding.DoFire(anEvent: TmsmEvent);
//#UC START# *57ADDC3A0071_57B329AF021D_var*
//#UC END# *57ADDC3A0071_57B329AF021D_var*
begin
//#UC START# *57ADDC3A0071_57B329AF021D_impl*
 inherited;
 if (anEvent = CurrentElementChangedEvent.Instance) then
  Self.ModelToFire.ShowElementRelationList(Self.ModelToListen.CurrentElement)
 else
 if (anEvent = ActionElementEvent.Instance) then
  Self.ModelToFire.ShowElementAsDir(Self.ModelToListen.ElementToAction);
//#UC END# *57ADDC3A0071_57B329AF021D_impl*
end;//TmsmListToListBinding.DoFire

end.
