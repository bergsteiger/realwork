unit m3NewStorageStream;

interface

uses
 l3IntfUses
 , m3NewStorageStreamPrim
 , ActiveX
 , m3StorageInterfaces
 , l3_String
 , m3RootStreamManagerPrim
;

type
 Tm3NewStorageStream = class(Tm3NewStorageStreamPrim)
  function Make(anAccess: Tm3StoreAccess;
   aName: Tl3_String;
   aManager: Tm3RootStreamManagerPrim;
   aPosition: Int64): IStream;
 end;//Tm3NewStorageStream
 
implementation

uses
 l3ImplUses
 , m3StoreHeader
 , SysUtils
;

end.
