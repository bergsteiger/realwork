unit m3TOCHandle;

interface

uses
 l3IntfUses
 , m3Persistent
 , l3_String
 , m3StorageInterfaces
 , m3RootStreamManagerPrim
 , l3Interfaces
 , ActiveX
;

type
 Tm3TOCHandle = class(Tm3Persistent)
  procedure Create;
  function CreateNew(aManager: Tm3RootStreamManagerPrim;
   const aName: Tl3WString;
   aStoreType: Tm3StoreType): Tm3TOCHandle;
  procedure Load(const aStream: IStream);
  procedure Save(const aStream: IStream);
 end;//Tm3TOCHandle
 
implementation

uses
 l3ImplUses
 , l3Chars
 , SysUtils
 , m3Exceptions
;

end.
