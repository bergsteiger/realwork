unit m3StorageHolder;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , m3StorageInterfaces
 , m3CommonStorage
 , m3RootStreamManagerPrim
 , ActiveX
;

type
 Tm3StorageHolder = class(Tl3CProtoObject, Im3StorageHolder)
  procedure Create(aStorageClass: Rm3CommonStorage;
   anAccess: Tm3StoreAccess;
   const aStream: IStream);
  function Make(aStorageClass: Rm3CommonStorage;
   anAccess: Tm3StoreAccess;
   const aStream: IStream): Im3StorageHolder;
  function GetFromCache(const aFileName: WideString;
   anAccess: Tm3StoreAccess;
   aType: Tm3StorageType;
   aSharedMode: Cardinal;
   out theStorage: Im3IndexedStorage): Boolean;
  function ReopenStorage(anAccess: Tm3StoreAccess): Im3IndexedStorage;
  function Storage: Im3IndexedStorage;
  function StoreToCache(const aFileName: WideString;
   aSharedMode: Cardinal): Im3IndexedStorage;
 end;//Tm3StorageHolder
 
implementation

uses
 l3ImplUses
 , SysUtils
 , m3StorageHolderList
 , Windows
;

end.
