unit IUnknownPtrList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "SandBox"
// ������: "IUnknownPtrList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Sand Box::SandBox::FinalContainers::TIUnknownPtrList
//
// ������ ���������� �� IUnknown
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
  {* ������ ���������� �� IUnknown }
 end;//TIUnknownPtrList

implementation

uses
  RTLConsts,
  l3MemorySizeUtils
  ;

{$Include ..\SandBox\InterfacePtrList.imp.pas}

end.