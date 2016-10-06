unit msmListControllerWithExternalView;

// Модуль: "w:\common\components\gui\Garant\msm\msmListControllerWithExternalView.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListControllerWithExternalView" MUID: (57F51DC10371)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmConcreteModels
 , msmViewController
 , msmControllers
;

type
 _ConcreteModel_ = ImsmListLikeModel;
 {$Include w:\common\components\gui\Garant\msm\msmConcreteModelViewController.imp.pas}
 TmsmListControllerWithExternalView = {abstract} class(_msmConcreteModelViewController_)
 end;//TmsmListControllerWithExternalView

implementation

uses
 l3ImplUses
 //#UC START# *57F51DC10371impl_uses*
 //#UC END# *57F51DC10371impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmConcreteModelViewController.imp.pas}

end.
