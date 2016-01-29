unit k2HugeTagObject;

interface

uses
 l3IntfUses
 , k2NonAtomicTag
 , l3BitArr
;

type
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
 , k2TagList
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
 , l3Variant
 , k2Base
 , k2InterfaceFactory
;

end.
