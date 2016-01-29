unit evBitmapParaBitmapContainer;

interface

uses
 l3IntfUses
 , l3IEBitmapContainer
 , k2Base
 , k2BaseStruct
 , l3Variant
;

 {$Define k2TagNoAssign}
 
 {$Define k2Tag_No_f_TagType}
 
type
 TevBitmapParaBitmapContainer = class(_k2Tag_)
  procedure Create(aType: Tk2Type);
  function SetAtomPrim(const aProp: _PropIn_;
   var V: Tk2Values): Boolean;
 end;//TevBitmapParaBitmapContainer
 
implementation

uses
 l3ImplUses
 , BitmapPara_Const
 , k2Tags
 , l3Dict
 , k2Const
 , l3Const
 , SysUtils
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
 , k2InterfaceFactory
;

end.
