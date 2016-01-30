unit IUnknownPtrList;
 {* Список УКАЗАТЕЛЕЙ на IUnknown }

// Модуль: "w:\common\components\SandBox\IUnknownPtrList.pas"
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
 _ItemType_ = IUnknown;
 _InterfacePtrList_Parent_ = TRefcounted;
 {$Include InterfacePtrList.imp.pas}
 TIUnknownPtrList = class(_InterfacePtrList_)
  {* Список УКАЗАТЕЛЕЙ на IUnknown }
 end;//TIUnknownPtrList

implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
;

{$Include InterfacePtrList.imp.pas}

end.
