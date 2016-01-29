unit pgFunction;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 TpgFunction = class(Tl3ProtoObject)
  procedure Prepare;
  procedure Unprepare;
 end;//TpgFunction
 
implementation

uses
 l3ImplUses
;

end.
