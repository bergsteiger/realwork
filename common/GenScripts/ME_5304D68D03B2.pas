unit l3DelphiStringSearcher.imp;

interface

uses
 l3IntfUses
 , l3Interfaces
;

type
 _l3DelphiStringSearcher_ = class(_l3DelphiStringSearcherPrim_)
  function ItemToWStr(const anItem: _ItemType_): Tl3WString;
 end;//_l3DelphiStringSearcher_
 
implementation

uses
 l3ImplUses
 , l3String
;

end.
