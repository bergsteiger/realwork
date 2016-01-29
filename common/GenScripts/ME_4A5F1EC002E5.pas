unit k2TypedSmallListTag;

interface

uses
 l3IntfUses
 , k2TypedSimpleTagListPrim
 , l3BitArr
;

 {$Define k2Tag_No_f_TagType}
 
 {$Define k2TagIsList}
 
 {$Define k2TagNoSort}
 
type
 Tk2TypedSmallListTag = class(Tk2TypedSimpleTagListPrim)
  {* Списог тегов с заранее определённым типом, имеющий ссылку на родителя и могущий иметь не более 32 (включительно) атрибутов }
 end;//Tk2TypedSmallListTag
 
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
