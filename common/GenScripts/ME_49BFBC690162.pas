unit m3PrimDB;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , m3DBInterfaces
 , l3Types
 , m3StorageInterfaces
 , l3ProxyStream
 , l3Filer
 , m3BackupTools
;

type
 Tm3PrimDB = class(Tl3CProtoObject)
  {* Заготовка для абстрактной базы }
  function NeedsFork: Boolean;
  function IsExclusive: Boolean;
  function NeedProxy: Boolean;
  function AsDB: Im3DB;
  function LastElapsed: TDateTime;
  function Stopped: Boolean;
  procedure Yield;
  procedure TuneFiler(aFiler: Tl3CustomFiler);
  procedure ModifyDeleted(anID: Integer;
   aInsert: Boolean);
  function InProcess: Boolean;
  procedure ModifyModified(anID: Integer);
   {* Добавляет документ в список изменённых }
  procedure Commit(aStream: Tl3ProxyStream);
   {* Сохраняет изменения в документе }
  procedure Revert(aStream: Tl3ProxyStream);
   {* Откатывает изменения потока }
  function MainStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
   {* Возвращает корень постоянной части }
  function GetVersionsStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
   {* Возвращает корень переменной части }
  function GetBackupStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
   {* Возвращает корень резервной копии }
  function GetDocumentObjectsIDs(aDocID: Integer): Im3StorageElementIDList;
   {* Возвращает список номеров объектов в документе }
  procedure Start(aOpenMode: Tm3StoreAccess);
   {* начинает процесс с базой }
  procedure Finish;
   {* заканчивает процесс с базой }
  procedure StartEx(aVersionsMode: Tm3StoreAccess;
   aConstMode: Tm3StoreAccess);
   {* начинает процесс с базой }
  procedure CloseBase;
   {* закрывает открытые файлы }
  procedure IterateObjectsInDocF(aDocID: Integer;
   aDeleted: Boolean;
   anAction: Tm3DBStreamAction;
   aSkipMain: Boolean);
   {* Перебирает объекты в документе }
 end;//Tm3PrimDB
 
implementation

uses
 l3ImplUses
 , l3Interfaces
 , m3DBProxyWriteStream
 , m3StorageTools
 , m2COMLib
 , SysUtils
 , ComObj
 , l3String
 , m3StorageElementIDList
 , StrUtils
 , Windows
 , l3Base
 , m3DBActions
;

end.
