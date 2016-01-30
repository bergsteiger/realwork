unit IntStackFromComponent;

// Модуль: "w:\common\components\SandBox\IntStackFromComponent.pas"
// Стереотип: "SimpleClass"

{$Include sbDefine.inc}

interface

uses
 l3IntfUses
 , Classes
;

type
 _ItemType_ = Integer;
 _StackPrim_Parent_ = TComponent;
 {$Include StackPrim.imp.pas}
 TIntStackFromComponent = class(_StackPrim_)
 end;//TIntStackFromComponent

implementation

uses
 l3ImplUses
;

{$Include StackPrim.imp.pas}

end.
