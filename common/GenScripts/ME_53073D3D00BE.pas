unit k2String;

interface

uses
 l3IntfUses
 , l3_String
 , k2Base
 , l3Variant
 , k2BaseStruct
;

 {$Define k2TagIsString}
 
 {$Define k2Tag_No_f_TagType}
 
type
 Tk2String = class(Tl3_String)
  procedure Create(aType: Tk2Type); overload;
  procedure Create; overload;
  function Make(aType: Tk2Type): Il3TagRef; overload;
  function SetAtomPrim(const aProp: _PropIn_;
   var V: Tk2Values): Boolean;
 end;//Tk2String
 
implementation

uses
 l3ImplUses
 , k2String_Const
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
 , k2NullTagImpl
 , k2Interfaces
 , k2DictionaryPrim
 , k2InterfaceFactory
;

end.
