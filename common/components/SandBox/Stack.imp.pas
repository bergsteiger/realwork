{$IfNDef Stack_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "SandBox"
// ������: "Stack.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: Impurity::Class Shared Delphi Sand Box::SandBox::Containers::Stack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define Stack_imp}
 _StackPrim_Parent_ = TObject;
 {$Include ..\SandBox\StackPrim.imp.pas}
 _Stack_ = {mixin} class(_StackPrim_)
 end;//_Stack_

{$Else Stack_imp}

{$Include ..\SandBox\StackPrim.imp.pas}


{$EndIf Stack_imp}
