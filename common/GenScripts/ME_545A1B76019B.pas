unit m3NormalFormsManager;

interface

uses
 l3IntfUses
 , l3SizedPoolManager
;

type
 Tm3NormalFormsManager = class(Tl3SizedPoolManager)
  procedure Create;
  procedure LockFree;
  procedure UnlockFree;
  function Exists: Boolean;
 end;//Tm3NormalFormsManager
 
implementation

uses
 l3ImplUses
 , l3SimpleMM
;

end.
