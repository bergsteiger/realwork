unit l3ProtoObjectComparable;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 Tl3ProtoObjectComparable = class(Tl3ProtoObject)
  function CompareWith(anOther: Tl3ProtoObjectComparable): Integer;
 end;//Tl3ProtoObjectComparable
 
implementation

uses
 l3ImplUses
;

end.
