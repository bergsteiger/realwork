unit IntStackFromPersistent;

// ������: "w:\common\components\SandBox\IntStackFromPersistent.pas"
// ���������: "SimpleClass"

{$Include sbDefine.inc}

interface

uses
 l3IntfUses
 , Classes
;

type
 _ItemType_ = Integer;
 _StackPrim_Parent_ = TPersistent;
 {$Include w:\common\components\SandBox\StackPrim.imp.pas}
 TIntStackFromPersistent = class(_StackPrim_)
 end;//TIntStackFromPersistent

implementation

uses
 l3ImplUses
;

{$Include w:\common\components\SandBox\StackPrim.imp.pas}

end.
