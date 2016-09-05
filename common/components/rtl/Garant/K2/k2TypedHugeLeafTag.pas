unit k2TypedHugeLeafTag;

// Модуль: "w:\common\components\rtl\Garant\K2\k2TypedHugeLeafTag.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2TypedHugeLeafTag" MUID: (53AAF9330342)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2LeafTag
 , l3BitArr
 , l3Variant
 , k2Base
 , k2BaseStruct
 , k2TagList
 , k2Prim
 , l3IID
 , k2BaseTypes
 , l3Types
 , l3Interfaces
;

 {$Define k2Tag_No_f_TagType}

type
 _HashType_ = Tl3PtrHash;
 _k2HashTag_Parent_ = Tk2LeafTag;
 {$Include w:\common\components\rtl\Garant\K2\k2HashTag.imp.pas}
 Tk2TypedHugeLeafTag = class(_k2HashTag_)
 end;//Tk2TypedHugeLeafTag

implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , l3Dict
 , k2Const
 , l3Const
 , l3String
 , k2Except
 , k2Strings
 , TypInfo
 , l3Stream
 , l3Base
 , k2Facade
 , Classes
 , k2OList_Const
 , k2Dictionary
 , k2NonOptimizeContext
 , k2VariantImpl
 , k2Bool_Const
 , k2String
 , k2NullTagImpl
 , k2Interfaces
 , k2DictionaryPrim
 , k2InterfaceFactory
 , k2List
 //#UC START# *53AAF9330342impl_uses*
 //#UC END# *53AAF9330342impl_uses*
;

type _Instance_R_ = Tk2TypedHugeLeafTag;

{$Include w:\common\components\rtl\Garant\K2\k2HashTag.imp.pas}

end.
