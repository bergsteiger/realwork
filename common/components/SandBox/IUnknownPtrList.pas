unit IUnknownPtrList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "IUnknownPtrList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Sand Box::SandBox::FinalContainers::TIUnknownPtrList
//
// Список УКАЗАТЕЛЕЙ на IUnknown
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
 _ItemType_ = IUnknown;
 _InterfacePtrList_Parent_ = TRefcounted;
 {$Include ..\SandBox\InterfacePtrList.imp.pas}
 TIUnknownPtrList = class(_InterfacePtrList_)
  {* Список УКАЗАТЕЛЕЙ на IUnknown }
 end;//TIUnknownPtrList

implementation

uses
  RTLConsts,
  l3MemorySizeUtils
  ;

{$Include ..\SandBox\InterfacePtrList.imp.pas}

end.