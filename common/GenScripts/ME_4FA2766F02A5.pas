unit m3BaseStorage;

interface

uses
 l3IntfUses
 , m3BaseStore
 , ActiveX
 , l3Interfaces
 , m3StorageInterfaces
 , Windows
;

type
 TWindowsFileTime = TFileTime;
 
 Tm3BaseStorage = class(Tm3BaseStore, IStorage)
  procedure DoCreateStore(const aName: Tl3WString;
   anAccess: Tm3StoreAccess;
   aStoreType: Tm3StoreType;
   out theStream: Tm3Store;
   out theReturn: hResult;
   aUseCompression: Boolean);
  procedure DoOpenStore(const aName: Tl3WString;
   anAccess: Tm3StoreAccess;
   aStoreType: Tm3StoreType;
   out theStream: Tm3Store;
   out theReturn: hResult;
   aUseCompression: Boolean);
  function DestroyElement(aName: PWideChar): HResult;
  function EnumElements(unused1: Integer;
   unused2: Pointer;
   unused3: Integer;
   out theStatStg: IEnumStatStg): HResult;
  function Stat(out theStatStg: TStatStg;
   aStatFlag: Integer): HResult;
 end;//Tm3BaseStorage
 
implementation

uses
 l3ImplUses
 , l3Base
 , m2COMLib
 , l3String
 , SysUtils
 , ComObj
 , m2MemLib
;

end.
