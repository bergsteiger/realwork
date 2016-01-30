unit k2TypedSmallSortableListTag;

// Модуль: "w:\common\components\rtl\Garant\K2\k2TypedSmallSortableListTag.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2TypedSimpleSortableTagListPrim
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

 {$Define k2Tag_No_f_TagType}

 {$Define k2TagIsList}

type
 _HashType_ = Tl3OneBytePtrHash;
 _k2HashTag_Parent_ = Tk2TypedSimpleSortableTagListPrim;
 {$Include k2HashTag.imp.pas}
 _k2TagByIntegerSearcher_Parent_ = _k2HashTag_;
 {$Include k2TagByIntegerSearcher.imp.pas}
 Tk2TypedSmallSortableListTag = class(_k2TagByIntegerSearcher_)
 end;//Tk2TypedSmallSortableListTag

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
;

type _Instance_R_ = Tk2TypedSmallSortableListTag;

{$Include k2HashTag.imp.pas}

{$Include k2TagByIntegerSearcher.imp.pas}

end.
