unit msmEditViewController;

// Модуль: "w:\common\components\gui\Garant\msm\msmEditViewController.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmEditViewController" MUID: (57FCD0D10020)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmEdit
 , msmControllers
 , msmViewControllersUtils
 , msmEvents
 , msmParentedViewController
 , msmModels
;

type
 _OwnViewClass_ = TmsmEdit;
 {$Include w:\common\components\gui\Garant\msm\msmEditViewController.imp.pas}
 TmsmEditViewController = class(_msmEditViewController_)
 end;//TmsmEditViewController

implementation

uses
 l3ImplUses
 , tfwCStringFactory
 , l3String
 , SysUtils
 //#UC START# *57FCD0D10020impl_uses*
 //#UC END# *57FCD0D10020impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmEditViewController.imp.pas}

end.
