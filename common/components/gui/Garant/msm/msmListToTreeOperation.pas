unit msmListToTreeOperation;

// Модуль: "w:\common\components\gui\Garant\msm\msmListToTreeOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListToTreeOperation" MUID: (57CEBBA601F1)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmConcreteModels
 , msmOperations
 , msmOperation
;

type
 _ModelToListen_ = ImsmListLikeModel;
 _ModelToFire_ = ImsmTreeModel;
 {$Include w:\common\components\gui\Garant\msm\msmModelToModelOperation.imp.pas}
 TmsmListToTreeOperation = {abstract} class(_msmModelToModelOperation_)
 end;//TmsmListToTreeOperation

implementation

uses
 l3ImplUses
 //#UC START# *57CEBBA601F1impl_uses*
 //#UC END# *57CEBBA601F1impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmModelToModelOperation.imp.pas}

end.
