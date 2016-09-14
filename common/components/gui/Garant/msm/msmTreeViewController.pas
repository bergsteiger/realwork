unit msmTreeViewController;

// Модуль: "w:\common\components\gui\Garant\msm\msmTreeViewController.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmTreeViewController" MUID: (57AB57E20079)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmTreeView
 , msmConcreteModels
 , msmListAndTreeViewUtils
 , msmParentedViewController
 , msmControllers
 , msmModels
 , msmEvents
 , l3Interfaces
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 _OwnViewClass_ = TmsmTreeView;
 _ConcreteModel_ = ImsmTreeModel;
 _InitContext_ = TmsmTreeViewInitContext;
 {$Include w:\common\components\gui\Garant\msm\msmConcreteModelOwnViewController.imp.pas}
 _msmMETreeViewController_Parent_ = _msmConcreteModelOwnViewController_;
 {$Include w:\common\components\gui\Garant\msm\msmMETreeViewController.imp.pas}
 TmsmTreeViewController = class(_msmMETreeViewController_)
 end;//TmsmTreeViewController

implementation

uses
 l3ImplUses
 , vtOutliner
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
 , msmMEImages
 //#UC START# *57AB57E20079impl_uses*
 , Graphics
 , l3Tree_TLB
 , l3String
 //#UC END# *57AB57E20079impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmConcreteModelOwnViewController.imp.pas}

{$Include w:\common\components\gui\Garant\msm\msmMETreeViewController.imp.pas}

end.
