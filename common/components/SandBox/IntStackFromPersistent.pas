unit IntStackFromPersistent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "SandBox"
// ������: "IntStackFromPersistent.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Sand Box::SandBox::Containers::TIntStackFromPersistent
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbDefine.inc}

interface

uses
  Classes
  ;

type
 _ItemType_ = Integer;
 _StackPrim_Parent_ = TPersistent;
 {$Include ..\SandBox\StackPrim.imp.pas}
 TIntStackFromPersistent = class(_StackPrim_)
 end;//TIntStackFromPersistent

implementation

{$Include ..\SandBox\StackPrim.imp.pas}

end.