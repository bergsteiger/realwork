unit k2TypedSmallLeafTag;

interface

uses
 l3IntfUses
 , k2LeafTag
 , l3BitArr
;

 {$Define k2Tag_No_f_TagType}
 
type
 Tk2TypedSmallLeafTag = class(_k2HashTag_)
  {* Листьевой тег с заранее определённым типом и могущий иметь НЕ более 32 (включительно) атрибутов }
 end;//Tk2TypedSmallLeafTag
 
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
