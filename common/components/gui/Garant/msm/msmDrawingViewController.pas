unit msmDrawingViewController;

// Модуль: "w:\common\components\gui\Garant\msm\msmDrawingViewController.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmDrawingViewController" MUID: (57D00B730178)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmDrawing
 , msmConcreteModels
 , msmViewControllersUtils
 , msmEvents
 , msmControllers
 , msmParentedViewController
 , msmModels
;

type
 _OwnViewClass_ = TmsmDrawing;
 _ConcreteModel_ = ImsmDrawingModel;
 _InitContext_ = TmsmDefaultInitContext;
 {$Include w:\common\components\gui\Garant\msm\msmConcreteModelOwnViewController.imp.pas}
 TmsmDrawingViewController = class(_msmConcreteModelOwnViewController_)
  protected
   procedure DoListChangedEvent(anEvent: TmsmEvent);
   procedure InitOwnView; override;
   procedure InitViewContext(var theContext: TmsmViewContext); override;
   procedure LinkDataToView; override;
   procedure LinkEventHandlers; override;
 end;//TmsmDrawingViewController

implementation

uses
 l3ImplUses
 , msmListAndTreeInterfaces
 , SysUtils
 //#UC START# *57D00B730178impl_uses*
 //#UC END# *57D00B730178impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmConcreteModelOwnViewController.imp.pas}

procedure TmsmDrawingViewController.DoListChangedEvent(anEvent: TmsmEvent);
//#UC START# *57D00B730178_57ADBA39026E_57D00B730178_var*
//#UC END# *57D00B730178_57ADBA39026E_57D00B730178_var*
begin
//#UC START# *57D00B730178_57ADBA39026E_57D00B730178_impl*
 inherited;
 //OwnView.ModelStateChanged;
//#UC END# *57D00B730178_57ADBA39026E_57D00B730178_impl*
end;//TmsmDrawingViewController.DoListChangedEvent

procedure TmsmDrawingViewController.InitOwnView;
//#UC START# *57ADFB33027D_57D00B730178_var*
//#UC END# *57ADFB33027D_57D00B730178_var*
begin
//#UC START# *57ADFB33027D_57D00B730178_impl*
 inherited;
//#UC END# *57ADFB33027D_57D00B730178_impl*
end;//TmsmDrawingViewController.InitOwnView

procedure TmsmDrawingViewController.InitViewContext(var theContext: TmsmViewContext);
//#UC START# *57B490B60385_57D00B730178_var*
//#UC END# *57B490B60385_57D00B730178_var*
begin
//#UC START# *57B490B60385_57D00B730178_impl*
 inherited;
 theContext.rCaption := Self.Model.Caption;
//#UC END# *57B490B60385_57D00B730178_impl*
end;//TmsmDrawingViewController.InitViewContext

procedure TmsmDrawingViewController.LinkDataToView;
//#UC START# *57B6A49900F4_57D00B730178_var*
//#UC END# *57B6A49900F4_57D00B730178_var*
begin
//#UC START# *57B6A49900F4_57D00B730178_impl*
 inherited;
 OwnView.Model := Self.Model;
//#UC END# *57B6A49900F4_57D00B730178_impl*
end;//TmsmDrawingViewController.LinkDataToView

procedure TmsmDrawingViewController.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(ListChangedEvent.Instance, DoListChangedEvent);
end;//TmsmDrawingViewController.LinkEventHandlers

end.
