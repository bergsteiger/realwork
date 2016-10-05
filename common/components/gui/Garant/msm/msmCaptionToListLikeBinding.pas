unit msmCaptionToListLikeBinding;

// Модуль: "w:\common\components\gui\Garant\msm\msmCaptionToListLikeBinding.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmCaptionToListLikeBinding" MUID: (57EA870501EC)

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
 _ModelToFire_ = ImsmListLikeModel;
 {$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}
 TmsmCaptionToListLikeBinding = {abstract} class(_msmModelToModelBinding_)
 end;//TmsmCaptionToListLikeBinding

implementation

uses
 l3ImplUses
 //#UC START# *57EA870501ECimpl_uses*
 //#UC END# *57EA870501ECimpl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}

end.
