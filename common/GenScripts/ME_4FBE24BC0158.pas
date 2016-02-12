unit k2ParentedTypedHugeListTag;
 {* Список параграфов с числом атрибутов больше 32 }

// Модуль: "w:\common\components\rtl\Garant\K2\k2ParentedTypedHugeListTag.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2TypedHugeListTag
 , l3Variant
;

type
 _k2ParentedTagObject_Parent_ = Tk2TypedHugeListTag;
 {$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}
 Tk2ParentedTypedHugeListTag = class(_k2ParentedTagObject_)
  {* Список параграфов с числом атрибутов больше 32 }
 end;//Tk2ParentedTypedHugeListTag

implementation

uses
 l3ImplUses
 , k2Base
 , k2NullTagImpl
 , l3BitArr
 , l3Memory
;

{$If not Declared(_HashType_)}type _HashType_ = Tl3PtrHash;{$IfEnd}

{$If not Declared(_ItemType_)}type _ItemType_ = Tl3Variant;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

{$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}

end.
