unit m3CommonStorage;

interface

uses
 l3IntfUses
 , m3StoragePrim
 , ActiveX
 , m3TOCHandleList
 , l3Interfaces
 , m3StorageInterfaces
 , l3_String
 , m3RootStreamManagerPrim
;

type
 Tm3IndexInfo = record
  {* Информация об индексе }
 end;//Tm3IndexInfo
 
 Tm3StoreOperation = (
  {* Операция с элементом хранилища }
  m3_soOpen
  , m3_soCreate
  , m3_soDelete
 );//Tm3StoreOperation
 
 Rm3CommonStorage = class of Tm3CommonStorage;
 
 Tm3CommonStorage = class(Tm3StoragePrim)
  function IsValidName(aName: PWideChar;
   aLen: Integer): Boolean; overload;
  function IsValidName(const aName: Tl3WString): Boolean; overload;
  function IsValidName(const aName: Tl3WString;
   out anIndex: Integer): Boolean; overload;
  procedure CheckIndexStream(aNeedCreate: Boolean;
   aForIterate: Boolean);
  procedure Create(anAccess: Tm3StoreAccess);
  function Make(anAccess: Tm3StoreAccess;
   aName: Tl3_String;
   aManager: Tm3RootStreamManagerPrim;
   aPosition: Int64): Im3IndexedStorage;
  function SubStorageClass: Rm3CommonStorage;
  procedure DoSaveTableOfContents;
  procedure SaveTableOfContents;
  function Manager: Tm3RootStreamManagerPrim;
  procedure LoadTableOfContents;
  procedure DoLoadTableOfContents;
  function OpenRoot(anAccess: Tm3StoreAccess;
   const aStream: IStream;
   out theManager: Tm3RootStreamManagerPrim): Im3IndexedStorage;
  function ForPlugin: Boolean;
  function IsPacked: Boolean;
  function OpenFromManager(anAccess: Tm3StoreAccess;
   aManager: Tm3RootStreamManagerPrim): Im3IndexedStorage;
 end;//Tm3CommonStorage
 
implementation

uses
 l3ImplUses
 , m3Const
 , l3Const
 , l3String
 , SysUtils
 , l3StringEx
 , m3CommonStorageStream
 , l3Base
;

end.
