unit msmListController;

// Модуль: "w:\common\components\gui\Garant\msm\msmListController.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListController" MUID: (57F51BC20045)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmConcreteModels
 , msmController
 , msmControllers
;

type
 _ConcreteModel_ = ImsmListLikeModel;
 {$Include w:\common\components\gui\Garant\msm\msmConcreteModelController.imp.pas}
 TmsmListController = {abstract} class(_msmConcreteModelController_)
 end;//TmsmListController

implementation

uses
 l3ImplUses
 //#UC START# *57F51BC20045impl_uses*
 //#UC END# *57F51BC20045impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmConcreteModelController.imp.pas}

end.
