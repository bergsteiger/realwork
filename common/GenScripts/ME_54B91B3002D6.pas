unit l3BoxMemoryManager;

interface

uses
 l3IntfUses
 , l3BoxMemoryManagerPrim
;

type
 Tl3BoxMemoryManager = class(Tl3BoxMemoryManagerPrim)
  procedure Create;
 end;//Tl3BoxMemoryManager
 
implementation

uses
 l3ImplUses
;

end.
