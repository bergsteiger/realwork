unit m3DB;

interface

uses
 l3IntfUses
 , m3BaseObject
 , m3DBInterfaces
 , m3PrimDB
 , m3StorageInterfaces
 , l3Filer
;

type
 Tm3BaseRangeParam = (
  {* Параметры выборки. }
  m3_brpIndexed
  , m3_brpModified
 );//Tm3BaseRangeParam
 
 Tm3BaseRangeParams = set of Tm3BaseRangeParam;
  {* Параметры выборки. }
 
 Tm3BaseRange = class(Tm3BaseObject, Im3DBRange)
  {* Базовая реализация выборки документов. }
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
 end;//Tm3BaseRange
 
 Im3BaseRangeParamsSource = interface
  {* Параметры выборки. }
 end;//Im3BaseRangeParamsSource
 
 Tm3DocListRange = class(Tm3BaseRange)
  {* Реализация выборки документов, по списку номеров. }
 end;//Tm3DocListRange
 
 Tm3BaseParametricRange = class(Tm3BaseRange, Im3BaseRangeParamsSource)
  function Params: Tm3BaseRangeParams;
   {* Параметры выборки. }
 end;//Tm3BaseParametricRange
 
 Tm3CommonListSelector = (
  clsDeleted
  , clsModified
 );//Tm3CommonListSelector
 
 Tm3CustomDB = class(Tm3PrimDB, Im3DB)
  {* Базовая реализация хранилища документов. }
  procedure SetList(aListSelector: Tm3CommonListSelector;
   anID: Integer;
   aInsert: Boolean);
   {* Исправляет список aListSelector. }
  function IndexedFiles(anIndexID: Integer): Im3DBRange;
   {* индексированные файлы. }
  function ModifiedFiles(aNotEmpty: Boolean;
   aLevel: Integer): Im3DBRange;
   {* модифицированные файла. }
  function AllFiles: Im3DBRange;
   {* все файлы базы. }
  function InProcess: Boolean; overload;
   {* с базой идет процесс. }
  function Stopped: Boolean; overload;
   {* предыдущий процесс был остановлен. }
  procedure Stop;
   {* остановить текущий процесс. }
  function Purge: integer;
   {* удаляет файлы, помеченные как удаленные и возвращает число удаленных. }
  function Update(aNotEmpty: Boolean;
   aPurgeDeletedObjects: Boolean): Boolean;
   {* переливает файлы из переменной части в постоянную. }
  procedure FlushLists;
   {* сбрасывает кеш Modified и Deleted листов. Применяется при массовой заливке документов в конце заливки пачки. Так же вызывается при уничтожении объекта доступа к базе (Tm3DB). }
  procedure Start(aOpenMode: Tm3StoreAccess);
   {* начинает процесс с базой. }
  procedure Finish;
   {* заканчивает процесс с базой. }
  function LastElapsed: TDateTime; overload;
   {* время последнего процесса с базой. }
  function GetDocument(anID: Integer): Im3DBDocument;
   {* возвращает документ по номеру. }
  procedure FreeVersions;
   {* Сообщает о том, что хранилище версий можно отпустить (заплатка) }
  procedure ModifyModified(anID: Integer);
   {* Добавляет документ в список изменённых }
  function FilesInList(const aList: Im3StorageElementIDList): Im3DBRange;
   {* Файлы с идентификаторами из списка }
  procedure DeleteVersion;
   {* Удаляет хранилище версий }
  procedure DeleteMain;
   {* Удаляет основную часть }
  procedure RenameMain(const aNewName: AnsiString);
   {* Переименовывает постоянную часть }
  procedure RenameVersion(const aNewName: AnsiString);
   {* Переименовывает переменную часть }
  procedure Rename(const aNewName: AnsiString);
   {* Переименовывает ВСЮ базу }
  function CompareVersionWithBackup: Boolean;
  procedure CopyBackupToVersion;
  procedure CopyVersionToBackup;
  procedure ExtractMainTo(const aDir: AnsiString);
  procedure ExtractVersionTo(const aDir: AnsiString);
  procedure ExtractBackupTo(const aDir: AnsiString);
  function IsExclusive: Boolean;
  function GetBackupStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
  function GetVersionsStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
  function MainStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
  function LastElapsed: TDateTime; overload;
  function Stopped: Boolean; overload;
  procedure Yield;
  procedure TuneFiler(aFiler: Tl3CustomFiler);
  procedure ModifyDeleted(anID: Integer;
   aInsert: Boolean);
  function InProcess: Boolean; overload;
 end;//Tm3CustomDB
 
 Tm3DB = class(Tm3CustomDB)
  function MainStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
   {* Возвращает корень постоянной части }
  function GetVersionsStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
   {* Возвращает корень переменной части }
  function GetBackupStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
   {* Возвращает корень резервной копии }
  procedure Start(aOpenMode: Tm3StoreAccess);
   {* начинает процесс с базой }
  procedure Finish;
   {* заканчивает процесс с базой }
  procedure StartEx(aVersionsMode: Tm3StoreAccess;
   aConstMode: Tm3StoreAccess);
   {* начинает процесс с базой }
  procedure CloseBase;
   {* закрывает открытые файлы }
 end;//Tm3DB
 
 Tm3BiCompBaseRange = class(Tm3BaseParametricRange)
  {* Вован - с тебя документация. }
 end;//Tm3BiCompBaseRange
 
implementation

uses
 l3ImplUses
 , m3BackupTools
 , m3DBDocument
 , m3DBFiler
 , k2EVDReaderService
 , k2EVDWriterService
 , l3ProxyStream
 , m3DBProxyWriteStream
 , m3NewVersionStream
;

end.
