unit m3CommonStorageStream;

interface

uses
 l3IntfUses
 , m3BaseStream
 , m3StorageInterfaces
 , m3RootStreamManagerPrimPrim
 , l3_String
;

type
 Tm3CommonStorageStream = class(Tm3BaseStream)
  procedure Create(anAccess: Tm3StoreAccess;
   aRootStreamManager: Tm3RootStreamManagerPrimPrim;
   aName: Tl3_String);
 end;//Tm3CommonStorageStream
 
implementation

uses
 l3ImplUses
;

end.
