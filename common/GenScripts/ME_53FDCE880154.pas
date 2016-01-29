unit m3CustomStream;

interface

uses
 l3IntfUses
 , m3BaseStream
 , ActiveX
 , m3StorageInterfaces
;

type
 Tm3CustomStream = class(Tm3BaseStream)
  procedure Create(const aStream: IStream;
   anAccess: Tm3StoreAccess);
 end;//Tm3CustomStream
 
implementation

uses
 l3ImplUses
 , m3Exceptions
;

end.
