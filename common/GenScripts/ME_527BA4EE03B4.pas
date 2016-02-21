unit k2TypedHugeListTag;

// Модуль: "w:\common\components\rtl\Garant\K2\k2TypedHugeListTag.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , evHugeParaListPrimWithFind
 , l3BitArr
 , k2Base
 , l3Variant
 , k2BaseStruct
 , k2TagList
 , k2Prim
 , l3IID
 , k2BaseTypes
 , l3Types
 , l3Interfaces
;

 {$Define k2TagIsList}

 {$Define k2Tag_No_f_TagType}

 {$Define k2TagNoSort}

type
 _HashType_ = Tl3PtrHash;
 _k2HashTag_Parent_ = TevHugeParaListPrimWithFind;
 {$Include w:\common\components\rtl\Garant\K2\k2HashTag.imp.pas}
 Tk2TypedHugeListTag = class(_k2HashTag_)
 end;//Tk2TypedHugeListTag

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
 , l3Memory
;

{$If not Declared(_ItemType_)}type _ItemType_ = Tl3Variant;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

type _Instance_R_ = Tk2TypedHugeListTag;

{$Include w:\common\components\rtl\Garant\K2\k2HashTag.imp.pas}

end.
