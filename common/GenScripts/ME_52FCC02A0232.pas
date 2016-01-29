unit l3ProtoObjectWithHandle;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Types
;

type
 Tl3ProtoObjectWithHandle = class(Tl3ProtoObject)
  function CompareWith(anOther: Tl3ProtoObjectWithHandle): Integer;
 end;//Tl3ProtoObjectWithHandle
 
implementation

uses
 l3ImplUses
;

end.
