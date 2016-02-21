unit IntegerList;
 {* ������ Integer'�� }

// ������: "w:\common\components\SandBox\IntegerList.pas"
// ���������: "SimpleClass"

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
;

{$Include w:\common\components\SandBox\StandardAtomicList.imp.pas}

end.
