unit IntStackFromComponent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "IntStackFromComponent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Sand Box::SandBox::Containers::TIntStackFromComponent
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbDefine.inc}

interface

uses
  Classes
  ;

type
 _ItemType_ = Integer;
 _StackPrim_Parent_ = TComponent;
 {$Include ..\SandBox\StackPrim.imp.pas}
 TIntStackFromComponent = class(_StackPrim_)
 end;//TIntStackFromComponent

implementation

{$Include ..\SandBox\StackPrim.imp.pas}

end.