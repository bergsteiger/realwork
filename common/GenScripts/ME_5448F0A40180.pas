unit m3NewStorageStreamPrim;

interface

uses
 l3IntfUses
 , m3CommonStorageStream
 , m3StorageBlock
 , m3StoreHeaderDataPrim
 , m3StorageInterfaces
 , Classes
;

type
 Tm3NewStorageStreamPrim = class(Tm3CommonStorageStream)
  procedure MoveStreamPointer;
  procedure Create(anAccess: Tm3StoreAccess;
   aHeaderData: Tm3StoreHeaderDataPrim);
 end;//Tm3NewStorageStreamPrim
 
implementation

uses
 l3ImplUses
 , Windows
 , l3Base
 , ComObj
 , m2COMLib
 , ActiveX
 , m2S32Lib
 , m2S64Lib
 , SysUtils
 , m2MemLib
 , m3Exceptions
;

end.
