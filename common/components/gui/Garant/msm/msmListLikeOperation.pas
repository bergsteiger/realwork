unit msmListLikeOperation;

// Модуль: "w:\common\components\gui\Garant\msm\msmListLikeOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListLikeOperation" MUID: (57CED27203D3)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmConcreteModels
 , msmOperation
 , msmOperations
;

type
 _ConcreteModel_ = ImsmListLikeModel;
 {$Include w:\common\components\gui\Garant\msm\msmConcreteModelOperation.imp.pas}
 TmsmListLikeOperation = {abstract} class(_msmConcreteModelOperation_)
 end;//TmsmListLikeOperation

implementation

uses
 l3ImplUses
 //#UC START# *57CED27203D3impl_uses*
 //#UC END# *57CED27203D3impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmConcreteModelOperation.imp.pas}

end.
