unit k2IUnknownTag;

interface

uses
 l3IntfUses
 , k2NotStructuredTag
 , l3Variant
 , k2BaseStruct
 , l3IID
;

 {$Define k2Tag_No_f_TagType}
 
type
 Tk2IUnknownTag = class(_k2Tag_)
  procedure Create(const anInterface: IUnknown);
  function Make(const anInterface: IUnknown): Il3TagRef;
  function SetAtomPrim(const aProp: _PropIn_;
   var V: Tk2Values): Boolean;
 end;//Tk2IUnknownTag
 
implementation

uses
 l3ImplUses
 , k2IUnknown_Const
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
 , k2Base
 , k2InterfaceFactory
;

end.
