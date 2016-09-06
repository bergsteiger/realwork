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
   procedure DoCurrentElementChangedEvent(anEvent: TmsmEvent);
   procedure DoActionElementEvent(anEvent: TmsmEvent);
   procedure LinkEventHandlers; override;
 end;//TmsmListToListBinding

implementation

uses
 l3ImplUses
 , msmListAndTreeInterfaces
 //#UC START# *57B329AF021Dimpl_uses*
 //#UC END# *57B329AF021Dimpl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}

procedure TmsmListToListBinding.DoCurrentElementChangedEvent(anEvent: TmsmEvent);
//#UC START# *57B329AF021D_57B31D1000FA_57B329AF021D_var*
//#UC END# *57B329AF021D_57B31D1000FA_57B329AF021D_var*
begin
//#UC START# *57B329AF021D_57B31D1000FA_57B329AF021D_impl*
 inherited;
 Self.ModelToFire.ShowElementRelationList(Self.ModelToListen.CurrentElement);
//#UC END# *57B329AF021D_57B31D1000FA_57B329AF021D_impl*
end;//TmsmListToListBinding.DoCurrentElementChangedEvent

procedure TmsmListToListBinding.DoActionElementEvent(anEvent: TmsmEvent);
//#UC START# *57B329AF021D_57B2B0C602DF_57B329AF021D_var*
//#UC END# *57B329AF021D_57B2B0C602DF_57B329AF021D_var*
begin
//#UC START# *57B329AF021D_57B2B0C602DF_57B329AF021D_impl*
 inherited;
 Self.ModelToFire.ShowElementAsDir(Self.ModelToListen.ElementToAction);
//#UC END# *57B329AF021D_57B2B0C602DF_57B329AF021D_impl*
end;//TmsmListToListBinding.DoActionElementEvent

procedure TmsmListToListBinding.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(CurrentElementChangedEvent.Instance, DoCurrentElementChangedEvent);
 Self.LinkEventHandler(ActionElementEvent.Instance, DoActionElementEvent);
end;//TmsmListToListBinding.LinkEventHandlers

end.
