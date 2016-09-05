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
   procedure DoFire(anEvent: TmsmEvent); override;
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

procedure TmsmListToTreeBinding.DoFire(anEvent: TmsmEvent);
//#UC START# *57ADDC3A0071_57C9A3B200E2_var*
var
 l_O : ImsmModelElement;
//#UC END# *57ADDC3A0071_57C9A3B200E2_var*
begin
//#UC START# *57ADDC3A0071_57C9A3B200E2_impl*
 inherited;
 if (anEvent = ListChangedEvent.Instance) then
 begin
  l_O := Self.ModelToListen.List.Owner;
  if (Self.ModelToFire.CurrentElement <> l_O) then
   Self.ModelToFire.CurrentElement := l_O;
 end;//anEvent = ListChangedEvent.Instance
//#UC END# *57ADDC3A0071_57C9A3B200E2_impl*
end;//TmsmListToTreeBinding.DoFire

end.
