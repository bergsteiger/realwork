unit IUnknownRefList;
 {* ������ ������ �� IUnknown }

// ������: "w:\common\components\SandBox\IUnknownRefList.pas"
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
;

{$Include w:\common\components\SandBox\InterfaceRefList.imp.pas}

end.
