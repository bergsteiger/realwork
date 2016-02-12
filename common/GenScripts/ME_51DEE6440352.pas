unit ByteList;

// Модуль: "w:\common\components\SandBox\ByteList.pas"
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
 _ItemType_ = Byte;
 {$Include w:\common\components\SandBox\StandardAtomicList.imp.pas}
 TByteList = class(_StandardAtomicList_)
 end;//TByteList

implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
;

{$Include w:\common\components\SandBox\StandardAtomicList.imp.pas}

end.
