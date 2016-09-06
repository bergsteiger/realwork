unit msmListOperation;

// Модуль: "w:\common\components\gui\Garant\msm\msmListOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListOperation" MUID: (57CED27203D3)

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
 TmsmListOperation = {abstract} class(_msmConcreteModelOperation_)
 end;//TmsmListOperation

implementation

uses
 l3ImplUses
 //#UC START# *57CED27203D3impl_uses*
 //#UC END# *57CED27203D3impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmConcreteModelOperation.imp.pas}

end.
