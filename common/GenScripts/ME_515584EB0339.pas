unit IntStackFromPersistent;

// Модуль: "w:\common\components\SandBox\IntStackFromPersistent.pas"
// Стереотип: "SimpleClass"

{$Include sbDefine.inc}

interface

uses
 l3IntfUses
 , Classes
;

type
 _ItemType_ = Integer;
 _StackPrim_Parent_ = TPersistent;
 {$Include StackPrim.imp.pas}
 TIntStackFromPersistent = class(_StackPrim_)
 end;//TIntStackFromPersistent

implementation

uses
 l3ImplUses
;

{$Include StackPrim.imp.pas}

end.
