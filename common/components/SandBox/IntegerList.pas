unit IntegerList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "SandBox"
// ������: "IntegerList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Sand Box::SandBox::FinalContainers::TIntegerList
//
// ������ Integer'��
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
  {* ������ Integer'�� }
 end;//TIntegerList

implementation

uses
  RTLConsts,
  l3MemorySizeUtils
  ;

{$Include ..\SandBox\StandardAtomicList.imp.pas}

end.