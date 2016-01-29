unit m3CustomNewStorage;

interface

uses
 l3IntfUses
 , m3NewStoragePrim
 , m3StorageInterfaces
 , m3CommonStorage
 , l3Interfaces
 , l3_String
 , ActiveX
 , m3StoreHeader
 , m3RootStreamManagerPrim
 , m3StoreHeaderDataPrim
;

type
 Tm3CustomNewStorage = class(Tm3NewStoragePrim, Im3IndexedStorage)
  function FindItemByIndex(anIndex: Tm3StoreElementIndex;
   aStoreType: Tm3StoreType;
   anOp: Tm3StoreOperation;
   out thePosition: Int64;
   theStoreType: Pm3StoreType): Boolean;
  function FindItemByName(const aName: Tl3WString;
   anOp: Tm3StoreOperation;
   out theStoreInfo: Tm3StoreInfo): Boolean;
  function IsValidOpenMode(aMode: Integer): Boolean;
  function IsValidCreateMode(aMode: Integer): Boolean;
  procedure RemoveElementByName(aName: Tl3_String;
   const aStoreInfo: Tm3StoreInfo);
  procedure RemoveElementByTOCIndex(anIndex: Integer);
  function CreateOpenStoreByName(const aStoreInfo: Tm3StoreInfo;
   anAccess: Tm3StoreAccess;
   aName: Tl3_String;
   aMode: Tm3StoreMode;
   aUseCompression: Boolean): Tm3Store; overload;
  function CreateOpenStoreByName(const aStoreInfo: Tm3StorageElementInfo;
   anAccess: Tm3StoreAccess;
   aMode: Tm3StoreMode;
   aUseCompression: Boolean): Tm3Store; overload;
  function CreateOpenStoreByIndex(const aStoreInfo: Tm3StoreInfo;
   anAccess: Tm3StoreAccess;
   anIndex: Tm3StoreElementIndex;
   aMode: Tm3StoreMode;
   aUseCompression: Boolean): Tm3Store;
  function SaveTableOfContentsPrim(const aStream: IStream): Int64;
  procedure Create(anAccess: Tm3StoreAccess;
   aStoreHeader: Tm3StoreHeader;
   aIsRoot: Boolean);
  function SetIndexParam(aBits: byte;
   aMaxBits: byte): Boolean;
   {* устанавливает параметры "размазывания" индекса. }
  function DeleteStore(anIndex: Tm3StoreElementIndex): hResult;
   {* удаляет элемент хранилища. }
  function CreateStore(anIndex: Tm3StoreElementIndex;
   anAccess: Tm3StoreAccess;
   aStoreType: Tm3StoreType;
   out aStore: Tm3Store;
   aUseCompression: Boolean): hResult; overload;
   {* создает элемент хранилища. }
  function OpenStore(anIndex: Tm3StoreElementIndex;
   anAccess: Tm3StoreAccess;
   aStoreType: Tm3StoreType;
   out aStore: Tm3Store;
   aUseCompression: Boolean): hResult; overload;
   {* открывает элемент хранилища. }
  function CreateStore(const aName: Tl3WString;
   anAccess: Tm3StoreAccess;
   aStoreType: Tm3StoreType;
   out aStore: Tm3Store;
   aUseCompression: Boolean): hResult; overload;
   {* создает элемент хранилища }
  function OpenStore(const aName: Tl3WString;
   anAccess: Tm3StoreAccess;
   aStoreType: Tm3StoreType;
   out aStore: Tm3Store;
   aUseCompression: Boolean): hResult; overload;
   {* открывает элемент хранилища }
  function OpenStore(const aStoreInfo: Tm3StorageElementInfo;
   anAccess: Tm3StoreAccess;
   aUseCompression: Boolean): Tm3Store; overload;
   {* открывает элемент хранилища. }
  function OpenStore(const aStoreInfo: Tm3StoreInfo;
   anAccess: Tm3StoreAccess;
   anIndex: Tm3StoreElementIndex;
   aUseCompression: Boolean): Tm3Store; overload;
   {* открывает элемент хранилища }
  function RenameElementA(const aOldName: Tl3WString;
   const aNewName: Tl3WString): hResult;
   {* Переименовывает элемент хранилища }
  function ElementExists(const aName: Tl3WString): Boolean;
   {* Проверяет существование элемента с указанным именем }
  procedure CheckIndexStream(aNeedCreate: Boolean;
   aForIterate: Boolean);
  function Make(anAccess: Tm3StoreAccess;
   aName: Tl3_String;
   aManager: Tm3RootStreamManagerPrim;
   aPosition: Int64): Im3IndexedStorage;
  procedure DoSaveTableOfContents;
  procedure DoLoadTableOfContents;
  function OpenRoot(anAccess: Tm3StoreAccess;
   const aStream: IStream;
   out theManager: Tm3RootStreamManagerPrim): Im3IndexedStorage;
  function OpenFromManager(anAccess: Tm3StoreAccess;
   aManager: Tm3RootStreamManagerPrim): Im3IndexedStorage;
  procedure ClearAll;
  procedure CopyFrom(const aSource: Im3IndexedStorage);
  procedure IterateIndexedF;
  procedure IterateAllF;
 end;//Tm3CustomNewStorage
 
implementation

uses
 l3ImplUses
 , m3Const
 , l3String
 , SysUtils
 , Windows
 , m2COMLib
 , m3TOCHandle
 , l3Base
 , m3StorageTools
 , m3StorageIndexStreamForIterate
 , m3StorageIndexStream
 , m3StorageTableOfContentsStream
 , m3ReadOnlyRootStreamManager
 , m3NewRootStreamManager
 , m3Exceptions
 , m3NewStorageStream
 , ComObj
 , m2S64Lib
;

type
 Tm3StoreHeaderDataPrimHack = class(Tm3StoreHeaderDataPrim)
 end;//Tm3StoreHeaderDataPrimHack
 
end.
