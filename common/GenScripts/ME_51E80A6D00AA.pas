unit IUnknownPtrList;
 {* ������ ���������� �� IUnknown }

// ������: "w:\common\components\SandBox\IUnknownPtrList.pas"
// ���������: "SimpleClass"
// ������� ������: "TIUnknownPtrList" MUID: (51E80A6D00AA)

{$Include w:\common\components\SandBox\sbDefine.inc}

interface

uses
 l3IntfUses
 , Refcounted
 , l3PtrLoc
 , Classes
;

type
 _ItemType_ = IUnknown;
 _InterfacePtrList_Parent_ = TRefcounted;
 {$Include w:\common\components\SandBox\InterfacePtrList.imp.pas}
 TIUnknownPtrList = class(_InterfacePtrList_)
  {* ������ ���������� �� IUnknown }
 end;//TIUnknownPtrList

implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
;

{$Include w:\common\components\SandBox\InterfacePtrList.imp.pas}

end.
