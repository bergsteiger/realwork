unit IntStackFromComponent;

// ������: "w:\common\components\SandBox\IntStackFromComponent.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\SandBox\sbDefine.inc}

interface

uses
 l3IntfUses
 , Classes
;

type
 _ItemType_ = Integer;
 _StackPrim_Parent_ = TComponent;
 {$Include w:\common\components\SandBox\StackPrim.imp.pas}
 TIntStackFromComponent = class(_StackPrim_)
 end;//TIntStackFromComponent

implementation

uses
 l3ImplUses
;

{$Include w:\common\components\SandBox\StackPrim.imp.pas}

end.
