unit StringStack;

// ������: "w:\common\components\SandBox\StringStack.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\SandBox\sbDefine.inc}

interface

uses
 l3IntfUses
;

type
 _ItemType_ = AnsiString;
 {$Include w:\common\components\SandBox\Stack.imp.pas}
 TStringStack = class(_Stack_)
 end;//TStringStack

implementation

uses
 l3ImplUses
;

{$Include w:\common\components\SandBox\Stack.imp.pas}

end.
