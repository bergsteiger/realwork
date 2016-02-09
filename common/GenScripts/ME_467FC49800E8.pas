unit k2HugeTagObject;
 {* Одна из реализаций хранилища тегов. С неограниченным количеством свойств }

// Модуль: "w:\common\components\rtl\Garant\K2\k2HugeTagObject.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2NonAtomicTag
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

type
 _HashType_ = Tl3PtrHash;
 _k2HashTag_Parent_ = Tk2NonAtomicTag;
 {$Include k2HashTag.imp.pas}
 Tk2HugeTagObject = class(_k2HashTag_)
  {* Одна из реализаций хранилища тегов. С неограниченным количеством свойств }
 end;//Tk2HugeTagObject

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
;

type _Instance_R_ = Tk2HugeTagObject;

{$Include k2HashTag.imp.pas}

end.
