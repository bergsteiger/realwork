unit l3Dictionary.imp;

interface

uses
 l3IntfUses
 , l3IDIndex
 , l3Interfaces
;

type
 _l3Dictionary_ = class(_l3DictionaryPrim_)
  function ItemToWStr(const anItem: _ItemType_): Tl3WString;
 end;//_l3Dictionary_
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , l3String
;

end.
