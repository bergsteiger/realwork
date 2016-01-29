unit l3Mutex;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Windows
;

type
 Tl3Mutex = class(Tl3ProtoObject)
  procedure Enter;
  procedure Leave;
  procedure Create(const aName: AnsiString;
   InitialLocked: Boolean);
 end;//Tl3Mutex
 
implementation

uses
 l3ImplUses
;

end.
