{$IfNDef Stack_imp}

// Модуль: "w:\common\components\SandBox\Stack.imp.pas"
// Стереотип: "Impurity"

{$Define Stack_imp}

 _StackPrim_Parent_ = TObject;
 {$Include w:\common\components\SandBox\StackPrim.imp.pas}
 _Stack_ = class(_StackPrim_)
 end;//_Stack_

{$Else Stack_imp}

{$IfNDef Stack_imp_impl}

{$Define Stack_imp_impl}

{$Include w:\common\components\SandBox\StackPrim.imp.pas}

{$EndIf Stack_imp_impl}

{$EndIf Stack_imp}

