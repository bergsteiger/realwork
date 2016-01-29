unit k2TypedAtomicTag;

interface

uses
 l3IntfUses
 , k2AtomicTag
 , k2Base
 , k2BaseStruct
;

 {$Define k2TagIsAtomic}
 
 {$Define k2Tag_No_f_TagType}
 
type
 Rk2TypedAtomicTag = class of Tk2TypedAtomicTag;
 
 Tk2TypedAtomicTag = class(_k2Tag_)
  procedure Create(aValue: Integer;
   aType: Tk2Type);
  function SetAtomPrim(const aProp: _PropIn_;
   var V: Tk2Values): Boolean;
 end;//Tk2TypedAtomicTag
 
implementation

uses
 l3ImplUses
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
 , l3Variant
 , k2InterfaceFactory
;

end.
