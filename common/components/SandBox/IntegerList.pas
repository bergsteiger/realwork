unit IntegerList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "IntegerList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Sand Box::SandBox::FinalContainers::TIntegerList
//
// Список Integer'ов
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
 _ItemType_ = Integer;
 {$Include ..\SandBox\StandardAtomicList.imp.pas}
 TIntegerList = class(_StandardAtomicList_)
  {* Список Integer'ов }
 end;//TIntegerList

implementation

uses
  RTLConsts,
  l3MemorySizeUtils
  ;

{$Include ..\SandBox\StandardAtomicList.imp.pas}

end.