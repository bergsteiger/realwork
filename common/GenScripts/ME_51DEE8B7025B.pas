unit Int64List;

// Модуль: "w:\common\components\SandBox\Int64List.pas"
// Стереотип: "SimpleClass"

{$Include sbDefine.inc}

interface

uses
 l3IntfUses
 , Refcounted
 , l3PtrLoc
 , Classes
;

type
 _ItemType_ = Int64;
 {$Include StandardAtomicList.imp.pas}
 TInt64List = class(_StandardAtomicList_)
 end;//TInt64List

implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
;

{$Include StandardAtomicList.imp.pas}

end.
