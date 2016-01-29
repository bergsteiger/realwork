unit Int64List;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "Int64List.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Sand Box::SandBox::FinalContainers::TInt64List
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbDefine.inc}

interface

uses
  Refcounted,
  Classes,
  l3PtrLoc
  ;

type
 _ItemType_ = Int64;
 {$Include ..\SandBox\StandardAtomicList.imp.pas}
 TInt64List = class(_StandardAtomicList_)
 end;//TInt64List

implementation

uses
  RTLConsts,
  l3MemorySizeUtils
  ;

{$Include ..\SandBox\StandardAtomicList.imp.pas}

end.