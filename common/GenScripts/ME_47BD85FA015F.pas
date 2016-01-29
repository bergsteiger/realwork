unit l3BaseWithID;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 Tl3BaseWithID = class(Tl3ProtoObject)
  procedure Create(aHandle: Integer);
 end;//Tl3BaseWithID
 
implementation

uses
 l3ImplUses
;

end.
