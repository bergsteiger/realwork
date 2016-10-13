unit msmMemoViewController;

// Модуль: "w:\common\components\gui\Garant\msm\msmMemoViewController.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmMemoViewController" MUID: (57FCD0F30287)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmMemo
 , msmControllers
 , msmViewControllersUtils
 , msmEvents
 , msmParentedViewController
 , msmModels
;

type
 _OwnViewClass_ = TmsmMemo;
 {$Include w:\common\components\gui\Garant\msm\msmEditViewController.imp.pas}
 TmsmMemoViewController = class(_msmEditViewController_)
 end;//TmsmMemoViewController

implementation

uses
 l3ImplUses
 , tfwCStringFactory
 , l3String
 , SysUtils
 //#UC START# *57FCD0F30287impl_uses*
 //#UC END# *57FCD0F30287impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmEditViewController.imp.pas}

end.
