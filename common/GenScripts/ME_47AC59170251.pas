unit k2List;

interface

uses
 l3IntfUses
 , k2TagList
 , k2Base
 , l3Variant
 , k2BaseStruct
;

 {$Define k2TagIsList}
 
 {$Define k2TagComplexAssign}
 
type
 Tk2List = class(_k2Tag_)
  procedure Create(aTagType: Tk2Type);
  function Make(aTagType: Tk2Type): Il3TagRef;
  function SetAtomPrim(const aProp: _PropIn_;
   var V: Tk2Values): Boolean;
 end;//Tk2List
 
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
