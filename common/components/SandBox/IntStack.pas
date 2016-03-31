unit IntStack;

// Модуль: "w:\common\components\SandBox\IntStack.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TIntStack" MUID: (51545E1E004A)

{$Include w:\common\components\SandBox\sbDefine.inc}

interface

uses
 l3IntfUses
;

type
 _ItemType_ = Integer;
 {$Include w:\common\components\SandBox\Stack.imp.pas}
 TIntStack = class(_Stack_)
 end;//TIntStack

implementation

uses
 l3ImplUses
;

{$Include w:\common\components\SandBox\Stack.imp.pas}

end.
