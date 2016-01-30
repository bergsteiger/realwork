unit IntStack;

// Модуль: "w:\common\components\SandBox\IntStack.pas"
// Стереотип: "SimpleClass"

{$Include sbDefine.inc}

interface

uses
 l3IntfUses
;

type
 _ItemType_ = Integer;
 {$Include Stack.imp.pas}
 TIntStack = class(_Stack_)
 end;//TIntStack

implementation

uses
 l3ImplUses
;

{$Include Stack.imp.pas}

end.
