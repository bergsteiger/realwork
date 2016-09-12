unit msmListToListBinding;

// Модуль: "w:\common\components\gui\Garant\msm\msmListToListBinding.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListToListBinding" MUID: (57D25B3702FE)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmConcreteModels
 , msmControllers
 , msmController
;

type
 _ModelToListen_ = ImsmListLikeModel;
 _ModelToFire_ = ImsmListLikeModel;
 {$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}
 TmsmListToListBinding = {abstract} class(_msmModelToModelBinding_)
 end;//TmsmListToListBinding

implementation

uses
 l3ImplUses
 //#UC START# *57D25B3702FEimpl_uses*
 //#UC END# *57D25B3702FEimpl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}

end.
