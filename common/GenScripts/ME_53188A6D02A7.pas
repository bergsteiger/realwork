unit k2FontName;

interface

uses
 l3IntfUses
 , l3Variant
 , l3LogFont
 , k2BaseStruct
 , l3Interfaces
;

 {$Define k2TagIsString}
 
 {$Define k2Tag_No_f_TagType}
 
type
 Tk2FontName = class(Tl3PrimString, Il3TagRef)
  procedure Create(aLogFont: Tl3LogFont);
  function SetAtomPrim(const aProp: _PropIn_;
   var V: Tk2Values): Boolean;
 end;//Tk2FontName
 
implementation

uses
 l3ImplUses
 , k2FontName_Const
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
 , k2Base
 , k2InterfaceFactory
;

end.
