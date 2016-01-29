unit m3DBInterfaces;

interface

uses
 l3IntfUses
 , m3Interfaces
 , l3Filer
 , l3Variant
 , m3StorageInterfaces
 , ActiveX
;

type
 Im3Base = m3Interfaces.Im3Base;
 
 Tm3DocPartSelector = (
  {* Составная часть документа. }
  m3_dsMain
   {* основной поток }
  , m3_dsAnno
   {* аннотация }
  , m3_dsInfo
   {* информация о документе }
  , m3_dsObject
   {* объект в документе }
 );//Tm3DocPartSelector
 
 Tm3DocPartSet = set of Tm3DocPartSelector;
  {* Множество потоков документа. }
 
 // m3_AllDocParts
 
 Tm3DBDocumentInfo = record
  {* Информация о документе. }
 end;//Tm3DBDocumentInfo
 
 Tm3DBStreamIndex = object
  {* Идентификатор потока документа. }
 end;//Tm3DBStreamIndex
 
 Tm3FilerAction = function(aFiler: Tl3CustomFiler;
  const anIndex: Tm3DBStreamIndex): Boolean;
  {* Подитеративная функция перебора файлов. }
 
 Im3TagGenerator = Ik2TagGenerator;
 
 Tm3DBCopyMode = (
  m3_cmRewrite
  , m3_cmRewriteEmpty
  , m3_cmNotRewrite
 );//Tm3DBCopyMode
 
 (*
 Mm3DB = interface
  procedure DeleteVersion;
   {* Удаляет хранилище версий }
  function CompareVersionWithBackup: Boolean;
  procedure CopyBackupToVersion;
  procedure CopyVersionToBackup;
  procedure ExtractMainTo(const aDir: AnsiString);
  procedure ExtractVersionTo(const aDir: AnsiString);
  procedure ExtractBackupTo(const aDir: AnsiString);
  procedure Start(aOpenMode: Tm3StoreAccess);
   {* начинает процесс с базой. }
  function Update(aNotEmpty: Boolean;
   aPurgeDeletedObjects: Boolean): Boolean;
   {* переливает файлы из переменной части в постоянную. }
  function Purge: integer;
   {* удаляет файлы, помеченные как удаленные и возвращает число удаленных. }
  procedure Finish;
   {* заканчивает процесс с базой. }
  procedure Stop;
   {* остановить текущий процесс. }
 end;//Mm3DB
 *)
 
 Im3DBDocumentPart = interface;
 
 Tm3DocumentAction = function(const aDoc: Im3DBDocumentPart;
  const anIndex: Tm3DBStreamIndex): Boolean;
  {* Подитеративная функция перебора документов. }
 
 Im3DB = interface;
 
 Im3DBObject = interface
  {* Объект работающий с хранилищем документов Архивариуса. }
  function DB: Im3DB;
 end;//Im3DBObject
 
 Tm3DBStreamAction = function(const aStream: IStream;
  const anIndex: Tm3DBStreamIndex): Boolean;
  {* Подинтеративная функция для перебора потоков. }
 
 Im3DBDocument = interface;
 
 Im3DBRange = interface;
 
 Im3DB = interface
  {* Хранилище документов Архивариуса. }
  procedure DeleteMain;
   {* Удаляет основную часть }
  procedure RenameMain(const aNewName: AnsiString);
   {* Переименовывает постоянную часть }
  procedure RenameVersion(const aNewName: AnsiString);
   {* Переименовывает переменную часть }
  procedure Rename(const aNewName: AnsiString);
   {* Переименовывает ВСЮ базу }
  function GetBackupStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
  function GetVersionsStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
  function MainStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
  function IndexedFiles(anIndexID: Integer): Im3DBRange;
   {* индексированные файлы. }
  function ModifiedFiles(aNotEmpty: Boolean;
   aLevel: Integer): Im3DBRange;
   {* модифицированные файла. }
  function AllFiles: Im3DBRange;
   {* все файлы базы. }
  function InProcess: Boolean;
   {* с базой идет процесс. }
  function Stopped: Boolean;
   {* предыдущий процесс был остановлен. }
  procedure FlushLists;
   {* сбрасывает кеш Modified и Deleted листов. Применяется при массовой заливке документов в конце заливки пачки. Так же вызывается при уничтожении объекта доступа к базе (Tm3DB). }
  function LastElapsed: TDateTime;
   {* время последнего процесса с базой. }
  function GetDocument(anID: Integer): Im3DBDocument;
   {* возвращает документ по номеру. }
  procedure FreeVersions;
   {* Сообщает о том, что хранилище версий можно отпустить (заплатка) }
  function FilesInList(const aList: Im3StorageElementIDList): Im3DBRange;
   {* Файлы с идентификаторами из списка }
  procedure DeleteVersion;
   {* Удаляет хранилище версий }
  function CompareVersionWithBackup: Boolean;
  procedure CopyBackupToVersion;
  procedure CopyVersionToBackup;
  procedure ExtractMainTo(const aDir: AnsiString);
  procedure ExtractVersionTo(const aDir: AnsiString);
  procedure ExtractBackupTo(const aDir: AnsiString);
  procedure Start(aOpenMode: Tm3StoreAccess);
   {* начинает процесс с базой. }
  function Update(aNotEmpty: Boolean;
   aPurgeDeletedObjects: Boolean): Boolean;
   {* переливает файлы из переменной части в постоянную. }
  function Purge: integer;
   {* удаляет файлы, помеченные как удаленные и возвращает число удаленных. }
  procedure Finish;
   {* заканчивает процесс с базой. }
  procedure Stop;
   {* остановить текущий процесс. }
 end;//Im3DB
 
 Im3DBDocumentPart = interface(Im3DBObject)
  {* Часть документа (основная или переменная). }
  function DateTime: TDateTime;
  function Open(aMode: Tm3StoreAccess;
   aDocPart: Tm3DocPartSelector;
   aIndex: Integer): IStream;
   {* Открывает поток в документе. }
 end;//Im3DBDocumentPart
 
 Im3DBDocument = interface(Im3DBObject)
  {* Документ. }
  procedure Delete;
   {* Удаляет документ из хранилища. }
  function Undelete: Boolean;
   {* Восстанавливает документ. }
  function GetConst: Im3DBDocumentPart;
   {* Постоянная часть документа. }
  function GetVersion(aLevel: Integer): Im3DBDocumentPart;
   {* Переменная часть документа. }
  function Open(aMode: Tm3StoreAccess;
   aDocPart: Tm3DocPartSelector;
   aIndex: Integer): IStream;
   {* открыть документ. }
  function GetFreeObjectID: Integer;
  procedure DeleteObject(aObjID: Integer);
 end;//Im3DBDocument
 
 Tm3DBIndexAction = function(const anIndex: Tm3DBStreamIndex): Boolean;
  {* Подинтеративная функция для перебора потоков. }
 
 Tm3DBPart = (
  {* Часть базы }
  m3_bpConst
   {* Постоянная }
  , m3_bpVersion
   {* Переменная }
  , m3_bpBackup
   {* Резервная копия }
 );//Tm3DBPart
 
 Tm3DBStreamIndexEx = object(Tm3DBStreamIndex)
  {* Идентификатор потока с указанием части }
 end;//Tm3DBStreamIndexEx
 
 Im3DBRange = interface(Im3DBObject)
  {* Выборка документов. }
  function Mul(const aRange: Im3DBRange): Im3DBRange;
   {* Пересекает выборки. }
  function Iterate(const aFilter: Im3TagGenerator;
   aNeedWriteToBase: Boolean;
   aParts: Tm3DocPartSet): Integer;
  function IterateF(anAction: Tm3FilerAction;
   aParts: Tm3DocPartSet): Integer; overload;
  function IterateF(anAction: Tm3DocumentAction;
   aParts: Tm3DocPartSet): Integer; overload;
  function CopyTo(const aDB: Im3DB;
   aMode: Tm3DBCopyMode;
   aParts: Tm3DocPartSet): Boolean;
   {* переливает выборку в другую базу. }
 end;//Im3DBRange
 
 Tm3FilesProcessed = procedure(anID: Integer) of object;
 
 Tm3FilesProcessedEx = procedure(anID: Integer;
  aMaxID: Integer;
  aTime: TDateTime) of object;
 
implementation

uses
 l3ImplUses
;

end.
