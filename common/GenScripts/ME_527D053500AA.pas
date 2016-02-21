unit k2ParentedTypedSmallListTag;
 {* Список тегов со ссылкой на родителя }

// Модуль: "w:\common\components\rtl\Garant\K2\k2ParentedTypedSmallListTag.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2TypedSmallListTag
 , l3Variant
;

type
 _k2ParentedTagObject_Parent_ = Tk2TypedSmallListTag;
 {$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}
 Tk2ParentedTypedSmallListTag = class(_k2ParentedTagObject_)
  {* Список тегов со ссылкой на родителя }
 end;//Tk2ParentedTypedSmallListTag

implementation

uses
 l3ImplUses
 , k2Base
 , k2NullTagImpl
 , l3BitArr
 , l3Memory
;

{$If not Declared(_HashType_)}type _HashType_ = Tl3OneBytePtrHash;{$IfEnd}

{$If not Declared(_ItemType_)}type _ItemType_ = Tl3Variant;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

{$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}

end.
