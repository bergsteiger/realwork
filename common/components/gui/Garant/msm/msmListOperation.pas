unit msmListOperation;

// Модуль: "w:\common\components\gui\Garant\msm\msmListOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListOperation" MUID: (57D17D37021C)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmConcreteModels
 , msmOperation
 , msmOperations
;

type
 _ConcreteModel_ = ImsmListModel;
 {$Include w:\common\components\gui\Garant\msm\msmConcreteModelOperation.imp.pas}
 TmsmListOperation = {abstract} class(_msmConcreteModelOperation_)
 end;//TmsmListOperation

implementation

uses
 l3ImplUses
 //#UC START# *57D17D37021Cimpl_uses*
 //#UC END# *57D17D37021Cimpl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmConcreteModelOperation.imp.pas}

end.
