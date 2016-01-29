unit m3StorageTableOfContentsStream;

interface

uses
 l3IntfUses
 , m3NewStorageStream
 , ActiveX
 , m3StorageInterfaces
 , m3StoreHeader
;

type
 Tm3StorageTableOfContentsStream = class(Tm3NewStorageStream)
  function Make(anAccess: Tm3StoreAccess;
   aHeader: Tm3StoreHeader): IStream;
 end;//Tm3StorageTableOfContentsStream
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
