unit IntStackFromPersistent;

// Модуль: "w:\common\components\SandBox\IntStackFromPersistent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TIntStackFromPersistent" MUID: (515584EB0339)

{$Include w:\common\components\SandBox\sbDefine.inc}

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
