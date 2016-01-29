unit m3StorageIndexStream;

interface

uses
 l3IntfUses
 , m3NewStorageStream
 , ActiveX
 , m3StorageInterfaces
 , m3NewStoragePrim
;

type
 Tm3StorageIndexStream = class(Tm3NewStorageStream)
  function Make(anAccess: Tm3StoreAccess;
   aStep: Integer;
   aParentStorage: Tm3NewStoragePrim;
   aPosition: Int64): IStream;
  function NeedBuffering: Boolean;
 end;//Tm3StorageIndexStream
 
implementation

uses
 l3ImplUses
 , SysUtils
 , m3BuffStream
 , l3_String
 , l3String
;

end.
