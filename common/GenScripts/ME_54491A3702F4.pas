unit m3NewStoragePrim;

interface

uses
 l3IntfUses
 , m3CommonStorage
 , m3StoreHeader
 , m3StorageInterfaces
 , m3RootStreamManagerPrim
;

type
 Tm3NewStoragePrim = class(Tm3CommonStorage)
  procedure Create(anAccess: Tm3StoreAccess;
   aHeader: Tm3StoreHeader);
  function Manager: Tm3RootStreamManagerPrim;
 end;//Tm3NewStoragePrim
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
