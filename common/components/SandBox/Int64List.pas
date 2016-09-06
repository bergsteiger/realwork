unit Int64List;

// Модуль: "w:\common\components\SandBox\Int64List.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TInt64List" MUID: (51DEE8B7025B)

{$Include w:\common\components\SandBox\sbDefine.inc}

interface

uses
 l3IntfUses
 , Refcounted
 , l3PtrLoc
 , Classes
;

type
 _ItemType_ = Int64;
 {$Include w:\common\components\SandBox\StandardAtomicList.imp.pas}
 TInt64List = class(_StandardAtomicList_)
 end;//TInt64List

implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
 //#UC START# *51DEE8B7025Bimpl_uses*
 //#UC END# *51DEE8B7025Bimpl_uses*
;

{$Include w:\common\components\SandBox\StandardAtomicList.imp.pas}

end.
