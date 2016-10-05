unit msmCaptionToListBinding;

// Модуль: "w:\common\components\gui\Garant\msm\msmCaptionToListBinding.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmCaptionToListBinding" MUID: (57EA9B7700BC)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmControllers
 , msmConcreteModels
 , msmController
;

type
 _ModelToListen_ = ImsmCaptionModel;
 _ModelToFire_ = ImsmListModel;
 {$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}
 TmsmCaptionToListBinding = {abstract} class(_msmModelToModelBinding_)
 end;//TmsmCaptionToListBinding

implementation

uses
 l3ImplUses
 //#UC START# *57EA9B7700BCimpl_uses*
 //#UC END# *57EA9B7700BCimpl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}

end.
