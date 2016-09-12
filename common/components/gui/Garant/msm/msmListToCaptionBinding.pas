unit msmListToCaptionBinding;

// Модуль: "w:\common\components\gui\Garant\msm\msmListToCaptionBinding.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListToCaptionBinding" MUID: (57D25BE8030B)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmConcreteModels
 , msmControllers
 , msmController
;

type
 _ModelToListen_ = ImsmListModel;
 _ModelToFire_ = ImsmCaptionModel;
 {$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}
 TmsmListToCaptionBinding = {abstract} class(_msmModelToModelBinding_)
 end;//TmsmListToCaptionBinding

implementation

uses
 l3ImplUses
 //#UC START# *57D25BE8030Bimpl_uses*
 //#UC END# *57D25BE8030Bimpl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmModelToModelBinding.imp.pas}

end.
