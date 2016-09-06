unit IUnknownRefList;
 {* ������ ������ �� IUnknown }

// ������: "w:\common\components\SandBox\IUnknownRefList.pas"
// ���������: "SimpleClass"
// ������� ������: "TIUnknownRefList" MUID: (51E80A960173)

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
 _InterfaceRefList_Parent_ = TRefcounted;
 {$Include w:\common\components\SandBox\InterfaceRefList.imp.pas}
 TIUnknownRefList = class(_InterfaceRefList_)
  {* ������ ������ �� IUnknown }
 end;//TIUnknownRefList

implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
 //#UC START# *51E80A960173impl_uses*
 //#UC END# *51E80A960173impl_uses*
;

{$Include w:\common\components\SandBox\InterfaceRefList.imp.pas}

end.
