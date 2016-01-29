unit k2Dictionary;

interface

uses
 l3IntfUses
 , k2DictionaryPrim
 , k2DictionaryIDIndex
 , l3Variant
 , l3Interfaces
;

type
 Tk2Dictionary = class(_l3DictionaryPrim_)
  {* Словарь. }
  function ItemToWStr(const anItem: _ItemType_): Tl3WString;
 end;//Tk2Dictionary
 
implementation

uses
 l3ImplUses
 , l3String
 , k2Tags
 , k2BaseTypes
 , l3Base
 , SysUtils
;

end.
