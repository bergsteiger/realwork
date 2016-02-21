unit IntegerList;
 {* Список Integer'ов }

// Модуль: "w:\common\components\SandBox\IntegerList.pas"
// Стереотип: "SimpleClass"

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
  {* Список Integer'ов }
 end;//TIntegerList

implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
;

{$Include w:\common\components\SandBox\StandardAtomicList.imp.pas}

end.
