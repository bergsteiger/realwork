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
   procedure DoCurrentElementChangedEvent(anEvent: TmsmEvent);
   procedure DoActionElementEvent(anEvent: TmsmEvent);
   procedure LinkEventHandlers; override;
 end;//TmsmTreeToListBinding

implementation

uses
 l3ImplUses
 , msmListAndTreeInterfaces
 //#UC START# *57B2BA6D0104impl_uses*
 //#UC END# *57B2BA6D0104impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}

procedure TmsmTreeToListBinding.DoCurrentElementChangedEvent(anEvent: TmsmEvent);
//#UC START# *57B2BA6D0104_57B31D1000FA_57B2BA6D0104_var*
//#UC END# *57B2BA6D0104_57B31D1000FA_57B2BA6D0104_var*
begin
//#UC START# *57B2BA6D0104_57B31D1000FA_57B2BA6D0104_impl*
 inherited;
 Self.ModelToFire.ShowElementAsList(Self.ModelToListen.CurrentElement);
//#UC END# *57B2BA6D0104_57B31D1000FA_57B2BA6D0104_impl*
end;//TmsmTreeToListBinding.DoCurrentElementChangedEvent

procedure TmsmTreeToListBinding.DoActionElementEvent(anEvent: TmsmEvent);
//#UC START# *57B2BA6D0104_57B2B0C602DF_57B2BA6D0104_var*
//#UC END# *57B2BA6D0104_57B2B0C602DF_57B2BA6D0104_var*
begin
//#UC START# *57B2BA6D0104_57B2B0C602DF_57B2BA6D0104_impl*
 inherited;
 Self.ModelToFire.ShowElementAsList(Self.ModelToListen.ElementToAction);
//#UC END# *57B2BA6D0104_57B2B0C602DF_57B2BA6D0104_impl*
end;//TmsmTreeToListBinding.DoActionElementEvent

procedure TmsmTreeToListBinding.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(CurrentElementChangedEvent.Instance, DoCurrentElementChangedEvent);
 Self.LinkEventHandler(ActionElementEvent.Instance, DoActionElementEvent);
end;//TmsmTreeToListBinding.LinkEventHandlers

end.
