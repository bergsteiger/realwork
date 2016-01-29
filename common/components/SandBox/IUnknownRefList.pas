unit IUnknownRefList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "IUnknownRefList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Sand Box::SandBox::FinalContainers::TIUnknownRefList
//
// Список ССЫЛОК на IUnknown
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
 _InterfaceRefList_Parent_ = TRefcounted;
 {$Include ..\SandBox\InterfaceRefList.imp.pas}
 TIUnknownRefList = class(_InterfaceRefList_)
  {* Список ССЫЛОК на IUnknown }
 end;//TIUnknownRefList

implementation

uses
  RTLConsts,
  l3MemorySizeUtils
  ;

{$Include ..\SandBox\InterfaceRefList.imp.pas}

end.