unit msmTreeToListBinding;

// Модуль: "w:\common\components\gui\Garant\msm\msmTreeToListBinding.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmTreeToListBinding" MUID: (57B2BA6D0104)

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
 _ModelToListen_ = ImsmTreeModel;
 _ModelToFire_ = ImsmListModel;
 {$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}
 TmsmTreeToListBinding = class(_msmModelToModelBinding_)
  protected
   procedure DoFire(anEvent: TmsmEvent); override;
 end;//TmsmTreeToListBinding

implementation

uses
 l3ImplUses
 , msmListAndTreeInterfaces
 //#UC START# *57B2BA6D0104impl_uses*
 //#UC END# *57B2BA6D0104impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}

procedure TmsmTreeToListBinding.DoFire(anEvent: TmsmEvent);
//#UC START# *57ADDC3A0071_57B2BA6D0104_var*
//#UC END# *57ADDC3A0071_57B2BA6D0104_var*
begin
//#UC START# *57ADDC3A0071_57B2BA6D0104_impl*
 inherited;
 if (anEvent = CurrentElementChangedEvent.Instance) then
  Self.ModelToFire.ShowElementAsDir(Self.ModelToListen.CurrentElement)
 else
 if (anEvent = ActionElementEvent.Instance) then
  Self.ModelToFire.ShowElementAsDir(Self.ModelToListen.ElementToAction);
//#UC END# *57ADDC3A0071_57B2BA6D0104_impl*
end;//TmsmTreeToListBinding.DoFire

end.
