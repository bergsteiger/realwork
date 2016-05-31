unit k2DictRec;

// Модуль: "w:\common\components\rtl\Garant\K2\k2DictRec.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2DictRec" MUID: (47AC5ED302A1)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2DictRecTag
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

type
 _HashType_ = Tl3OneBytePtrHash;
 _k2HashTag_Parent_ = Tk2DictRecTag;
 {$Include w:\common\components\rtl\Garant\K2\k2HashTag.imp.pas}
 Tk2DictRec = class(_k2HashTag_)
 end;//Tk2DictRec

implementation

uses
 l3ImplUses
 , k2Tags
 , SysUtils
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
;

type _Instance_R_ = Tk2DictRec;

{$Include w:\common\components\rtl\Garant\K2\k2HashTag.imp.pas}

end.
