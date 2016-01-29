unit k2HashTag.imp;

interface

uses
 l3IntfUses
 , k2Base
 , l3Variant
 , k2BaseStruct
;

type
 // _HashType_
 
 _k2HashTag_ = class(_k2Tag_, Ml3Unknown, Ml3DataContainer)
  {* Одна из реализаций хранилища тегов. }
  function Make(aTagType: Tk2Type): Il3TagRef;
  procedure Create(aTagType: Tk2Type);
  procedure ClearAtoms;
  function SetAtomPrim(const aProp: _PropIn_;
   var V: Tk2Values): Boolean;
 end;//_k2HashTag_
 
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
 , k2InterfaceFactory
;

end.
