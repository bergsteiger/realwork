unit l3SimpleObject;

interface

uses
 l3IntfUses
 , l3ProtoObjectWithCOMQI
;

type
 Tl3SimpleObject = class(Tl3ProtoObjectWithCOMQI)
  procedure Create;
 end;//Tl3SimpleObject
 
implementation

uses
 l3ImplUses
;

end.
