unit ByteList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "ByteList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Sand Box::SandBox::FinalContainers::TByteList
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
 _ItemType_ = Byte;
 {$Include ..\SandBox\StandardAtomicList.imp.pas}
 TByteList = class(_StandardAtomicList_)
 end;//TByteList

implementation

uses
  RTLConsts,
  l3MemorySizeUtils
  ;

{$Include ..\SandBox\StandardAtomicList.imp.pas}

end.