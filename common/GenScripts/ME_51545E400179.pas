unit StringStack;

// ������: "w:\common\components\SandBox\StringStack.pas"
// ���������: "SimpleClass"

{$Include sbDefine.inc}

interface

uses
 l3IntfUses
;

type
 _ItemType_ = AnsiString;
 {$Include Stack.imp.pas}
 TStringStack = class(_Stack_)
 end;//TStringStack

implementation

uses
 l3ImplUses
;

{$Include Stack.imp.pas}

end.
