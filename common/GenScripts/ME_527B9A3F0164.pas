unit k2OwnedTypedHugeListTag;

// Модуль: "w:\common\components\rtl\Garant\K2\k2OwnedTypedHugeListTag.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2TypedHugeListTag
 , l3Variant
;

type
 _k2OwnedTagObject_Parent_ = Tk2TypedHugeListTag;
 {$Include w:\common\components\rtl\Garant\K2\k2OwnedTagObject.imp.pas}
 Tk2OwnedTypedHugeListTag = class(_k2OwnedTagObject_)
 end;//Tk2OwnedTypedHugeListTag

implementation

uses
 l3ImplUses
 , k2Base
 , SysUtils
 , k2NullTagImpl
 , l3BitArr
 , l3Memory
;

{$If not Declared(_HashType_)}type _HashType_ = Tl3PtrHash;{$IfEnd}

{$If not Declared(_ItemType_)}type _ItemType_ = Tl3Variant;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

{$Include w:\common\components\rtl\Garant\K2\k2OwnedTagObject.imp.pas}

end.
