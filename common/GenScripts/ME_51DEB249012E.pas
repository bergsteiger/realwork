unit IntegerList;
 {* ������ Integer'�� }

// ������: "w:\common\components\SandBox\IntegerList.pas"
// ���������: "SimpleClass"

{$Include sbDefine.inc}

interface

uses
 l3IntfUses
 , Refcounted
 , l3PtrLoc
 , Classes
;

type
 _ItemType_ = Integer;
 {$Include StandardAtomicList.imp.pas}
 TIntegerList = class(_StandardAtomicList_)
  {* ������ Integer'�� }
 end;//TIntegerList

implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
;

{$Include StandardAtomicList.imp.pas}

end.
