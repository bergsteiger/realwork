unit msmListViewController;

// Модуль: "w:\common\components\gui\Garant\msm\msmListViewController.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListViewController" MUID: (57AAF18F0065)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmLister
 , msmConcreteModels
 , msmListAndTreeViewUtils
 , msmControllers
 , msmParentedViewController
 , msmModels
 , msmEvents
 , l3Interfaces
;

type
 _OwnViewClass_ = TmsmLister;
 _ConcreteModel_ = ImsmListModel;
 _InitContext_ = TmsmListViewtInitContext;
 {$Include w:\common\components\gui\Garant\msm\msmConcreteModelOwnViewController.imp.pas}
 _msmMEListViewController_Parent_ = _msmConcreteModelOwnViewController_;
 {$Include w:\common\components\gui\Garant\msm\msmMEListViewController.imp.pas}
 TmsmListViewController = class(_msmMEListViewController_)
  protected
   procedure CallDropDrawPoints; override;
   procedure InitViewContext(var theContext: TmsmViewContext); override;
 end;//TmsmListViewController

implementation

uses
 l3ImplUses
 , vtLister
 , SysUtils
 , msmViewControllersUtils
 , msmListAndTreeInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , msmWaitCursor
 //#UC START# *57AAF18F0065impl_uses*
 , Graphics
 , l3Base
 , l3String
 //#UC END# *57AAF18F0065impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmConcreteModelOwnViewController.imp.pas}

{$Include w:\common\components\gui\Garant\msm\msmMEListViewController.imp.pas}

procedure TmsmListViewController.CallDropDrawPoints;
//#UC START# *57B6C9A5037B_57AAF18F0065_var*
//#UC END# *57B6C9A5037B_57AAF18F0065_var*
begin
//#UC START# *57B6C9A5037B_57AAF18F0065_impl*
 inherited;
 OwnView.CallDropDrawPoints;
//#UC END# *57B6C9A5037B_57AAF18F0065_impl*
end;//TmsmListViewController.CallDropDrawPoints

procedure TmsmListViewController.InitViewContext(var theContext: TmsmViewContext);
//#UC START# *57B490B60385_57AAF18F0065_var*
//#UC END# *57B490B60385_57AAF18F0065_var*
begin
//#UC START# *57B490B60385_57AAF18F0065_impl*
 inherited;
 theContext.rCaption := Self.Model.Caption;
//#UC END# *57B490B60385_57AAF18F0065_impl*
end;//TmsmListViewController.InitViewContext

end.
