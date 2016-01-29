unit m3WideStringManager;

interface

uses
 l3IntfUses
 , l3WideStringManager
;

type
 Tm3WideStringManager = class(Tl3WideStringManager)
  procedure Create;
  procedure LockFree;
  procedure UnlockFree;
  function Exists: Boolean;
 end;//Tm3WideStringManager
 
implementation

uses
 l3ImplUses
 , l3SimpleMM
;

end.
