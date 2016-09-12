unit msmListLikeToListAbstractBinding;

// Модуль: "w:\common\components\gui\Garant\msm\msmListLikeToListAbstractBinding.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListLikeToListAbstractBinding" MUID: (57D25CCB01BD)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmConcreteModels
 , msmControllers
 , msmController
;

type
 _ModelToFire_ = ImsmListModel;
 _ModelToListen_ = ImsmListLikeModel;
 {$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}
 TmsmListLikeToListAbstractBinding = {abstract} class(_msmModelToModelBinding_)
 end;//TmsmListLikeToListAbstractBinding

implementation

uses
 l3ImplUses
 //#UC START# *57D25CCB01BDimpl_uses*
 //#UC END# *57D25CCB01BDimpl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}

end.
