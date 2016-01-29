unit segTarget;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 TsegTarget = class(Tl3ProtoObject)
  procedure Create(aDocID: Integer;
   aSubID: Integer);
 end;//TsegTarget
 
implementation

uses
 l3ImplUses
;

end.
