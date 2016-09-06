unit IntegerList;
 {* ������ Integer'�� }

// ������: "w:\common\components\SandBox\IntegerList.pas"
// ���������: "SimpleClass"
// ������� ������: "TIntegerList" MUID: (51DEB249012E)

{$Include w:\common\components\SandBox\sbDefine.inc}

interface

uses
 l3IntfUses
 , Refcounted
 , l3PtrLoc
 , Classes
;

type
 _ItemType_ = Integer;
 {$Include w:\common\components\SandBox\StandardAtomicList.imp.pas}
 TIntegerList = class(_StandardAtomicList_)
  {* ������ Integer'�� }
 end;//TIntegerList

implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
 //#UC START# *51DEB249012Eimpl_uses*
 //#UC END# *51DEB249012Eimpl_uses*
;

{$Include w:\common\components\SandBox\StandardAtomicList.imp.pas}

end.
