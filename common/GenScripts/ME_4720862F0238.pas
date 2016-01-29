unit m3StorageInterfaces;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3PureMixIns
 , ActiveX
;

type
 Tm3StoreAccess = Integer;
  {* тип доступа к хранилищу. }
 
 // Tm3StoreType
 
 Pm3StoreType = ^Tm3StoreType;
  {* Указатель на Tm3StoreType. }
 
 Tm3StoreMode = (
  {* Режим открытия элемента каталога. }
  m3_smCreate
  , m3_smOpen
 );//Tm3StoreMode
 
 Tm3StoreInfo = record
  {* Информация об элементе хранилища. }
 end;//Tm3StoreInfo
 
 Tm3StorageElementID = Integer;
 
 Tm3StorageElementInfo = record
 end;//Tm3StorageElementInfo
 
 Im3StorageElementIDList = interface
  function IndexOf(const anItem: _ItemType_): Integer;
  function Add(const anItem: _ItemType_): Integer;
 end;//Im3StorageElementIDList
 
 TStatStg = ActiveX.TStatStg;
 
 Tm3StorageType = (
  m3_stArchive
  , m3_stPlugin
  , m3_stPlain
 );//Tm3StorageType
 
 Mm3StorageIterators_IterateIndexedF_Action = function(const anItem: Tm3StoreInfo;
  anIndex: Integer): Boolean;
  {* Тип подитеративной функции для Mm3StorageIterators.IterateIndexedF }
 
 Mm3StorageIterators_IterateAllF_Action = function(const anItem: Tm3StorageElementInfo): Boolean;
  {* Тип подитеративной функции для Mm3StorageIterators.IterateAllF }
 
 (*
 Mm3StorageIterators = interface
  procedure IterateIndexedF;
  procedure IterateAllF;
 end;//Mm3StorageIterators
 *)
 
 Tm3StoreElementIndex = Tm3StorageElementID;
 
 Im3IndexedStorage = interface;
 
 Tm3Store = object
 end;//Tm3Store
 
 Im3IndexedStorage = interface(IUnknown)
  {* Хранилище с возможностью доступа по индексу. }
  procedure ClearAll;
  procedure CopyFrom(const aSource: Im3IndexedStorage);
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
  function DestroyElement(aName: PWideChar): HResult;
  function EnumElements(unused1: Integer;
   unused2: Pointer;
   unused3: Integer;
   out theStatStg: IEnumStatStg): HResult;
  function Stat(out theStatStg: TStatStg;
   aStatFlag: Integer): HResult;
  procedure IterateIndexedF;
  procedure IterateAllF;
 end;//Im3IndexedStorage
 
 Im3StorageHolder = interface
  function StoreToCache(const aFileName: WideString;
   aSharedMode: Cardinal): Im3IndexedStorage;
 end;//Im3StorageHolder
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
