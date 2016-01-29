unit m3RootStreamManagerPrim;

interface

uses
 l3IntfUses
 , m3RootStreamManagerPrimPrim
 , m3StoreHeaderDataPrim
;

type
 Tm3RootStreamManagerPrim = class(Tm3RootStreamManagerPrimPrim)
  function StoreHeaderDataClass: Rm3StoreHeaderDataPrim;
  procedure RemoveFATElementAtPos(aPosition: Int64);
  function AllocNewFATElement: Int64;
  function ReadOnly: Boolean;
 end;//Tm3RootStreamManagerPrim
 
implementation

uses
 l3ImplUses
 , m3Exceptions
;

end.
