unit evdParaModifier;

interface

uses
 l3IntfUses
 , l3Variant
;

type
 TevdParaModifier = class
  function MarkModified(aTag: Tl3Variant): Boolean;
 end;//TevdParaModifier
 
implementation

uses
 l3ImplUses
;

end.
