unit ByteList;

// Модуль: "w:\common\components\SandBox\ByteList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TByteList" MUID: (51DEE6440352)

{$Include w:\common\components\SandBox\sbDefine.inc}

interface

uses
 l3IntfUses
 , Refcounted
 , l3PtrLoc
 , Classes
;

type
 _ItemType_ = Byte;
 {$Include w:\common\components\SandBox\StandardAtomicList.imp.pas}
 TByteList = class(_StandardAtomicList_)
 end;//TByteList

implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
 //#UC START# *51DEE6440352impl_uses*
 //#UC END# *51DEE6440352impl_uses*
;

{$Include w:\common\components\SandBox\StandardAtomicList.imp.pas}

end.
