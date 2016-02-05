unit m3DBInterfaces;
 {* Интерфейсы для работы с хранилищем документов Архивариуса. }

// Модуль: "w:\common\components\rtl\Garant\m3\m3DBInterfaces.pas"
// Стереотип: "Interfaces"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
 , m3Interfaces
 , l3Filer
 , l3Variant
 , m3StorageInterfaces
 , ActiveX
;

const
 m3_defDocPart = m3_dsMain;
  {* Основной поток документа по умолчанию. }
 Cm3ConstVersion = High(Longint);
 Cm3LastVersion = 0;

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
  rIndexID: Integer;
  rRelID: Integer;
   {* ID справки }
  rRightsMask: Cardinal;
   {* маска прав }
  rLockedBy: Integer;
   {* пользователь, который забрал документ }
  rDocType: Cardinal;
  rExtDocID: Cardinal;
 end;//Tm3DBDocumentInfo

 Tm3DBStreamIndex = object
  {* Идентификатор потока документа. }
  public
   rID: Integer;
    {* Номер документа }
   rPart: Tm3DocPartSelector;
    {* Номер потока }
   rIdx: Integer;
    {* индекс (для объектов) }
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
 Mm3DB = interface(Im3Base)
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
  function Update(aNotEmpty: Boolean = True;
   aPurgeDeletedObjects: Boolean = True): Boolean;
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

 Im3DBObject = interface(Im3Base)
  {* Объект работающий с хранилищем документов Архивариуса. }
  ['{65B3326A-1D5A-4A83-82A8-F7219E24D20A}']
  function DB: Im3DB;
 end;//Im3DBObject

 Tm3DBStreamAction = function(const aStream: IStream;
  const anIndex: Tm3DBStreamIndex): Boolean;
  {* Подинтеративная функция для перебора потоков. }

 Im3DBDocument = interface;

 Im3DBRange = interface;

 Im3DB = interface(Im3Base)
  {* Хранилище документов Архивариуса. }
  ['{F5ED42F7-F6F8-4BD9-9C9D-224FF5108543}']
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
  function IndexedFiles(anIndexID: Integer = 1): Im3DBRange;
   {* индексированные файлы. }
  function ModifiedFiles(aNotEmpty: Boolean = False;
   aLevel: Integer = 0): Im3DBRange;
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
  function Update(aNotEmpty: Boolean = True;
   aPurgeDeletedObjects: Boolean = True): Boolean;
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
  ['{2163930B-CFA8-4339-8C2F-08A61E38F926}']
  function pm_GetDocument: Im3DBDocument;
  function pm_GetInfo: Tm3DBDocumentInfo;
  procedure pm_SetInfo(const aValue: Tm3DBDocumentInfo);
  function DateTime: TDateTime;
  function Open(aMode: Tm3StoreAccess = m3_saRead;
   aDocPart: Tm3DocPartSelector = m3_defDocPart;
   aIndex: Integer = 0): IStream;
   {* Открывает поток в документе. }
  property Document: Im3DBDocument
   read pm_GetDocument;
   {* Документ, к которому часть относится. }
  property Info: Tm3DBDocumentInfo
   read pm_GetInfo
   write pm_SetInfo;
   {* Информация о документе. }
 end;//Im3DBDocumentPart

 Im3DBDocument = interface(Im3DBObject)
  {* Документ. }
  ['{5865E540-A505-44CB-95E5-7381A86A6E65}']
  function pm_GetID: Integer;
  procedure Delete;
   {* Удаляет документ из хранилища. }
  function Undelete: Boolean;
   {* Восстанавливает документ. }
  function GetConst: Im3DBDocumentPart;
   {* Постоянная часть документа. }
  function GetVersion(aLevel: Integer = 0): Im3DBDocumentPart;
   {* Переменная часть документа. }
  function Open(aMode: Tm3StoreAccess = m3_saRead;
   aDocPart: Tm3DocPartSelector = m3_defDocPart;
   aIndex: Integer = 0): IStream;
   {* открыть документ. }
  function GetFreeObjectID: Integer;
  procedure DeleteObject(aObjID: Integer);
  property ID: Integer
   read pm_GetID;
   {* Идентификатор документа. }
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
  public
   rDBPart: Tm3DBPart;
    {* Часть базы }
   rVersion: Integer;
    {* Номер версии }
 end;//Tm3DBStreamIndexEx

 Im3DBRange = interface(Im3DBObject)
  {* Выборка документов. }
  ['{D40F6781-A93B-494A-AD5A-B6C46CA1E95E}']
  function Mul(const aRange: Im3DBRange): Im3DBRange;
   {* Пересекает выборки. }
  {$If NOT Defined(m3NoEVD)}
  function Iterate(const aFilter: Im3TagGenerator;
   aNeedWriteToBase: Boolean;
   aParts: Tm3DocPartSet = m3_AllDocParts): Integer;
  {$IfEnd} // NOT Defined(m3NoEVD)
  function IterateF(anAction: Tm3FilerAction;
   aParts: Tm3DocPartSet = m3_AllDocParts): Integer; overload;
  function IterateF(anAction: Tm3DocumentAction;
   aParts: Tm3DocPartSet = m3_AllDocParts): Integer; overload;
  function CopyTo(const aDB: Im3DB;
   aMode: Tm3DBCopyMode = m3_cmRewrite;
   aParts: Tm3DocPartSet = m3_AllDocParts): Boolean;
   {* переливает выборку в другую базу. }
 end;//Im3DBRange

 Tm3FilesProcessed = procedure(anID: Integer) of object;

 Tm3FilesProcessedEx = procedure(anID: Integer;
  aMaxID: Integer;
  aTime: TDateTime) of object;

function Tm3DBDocumentInfo_C(aIndexID: Integer): Tm3DBDocumentInfo;
function Tm3DBStreamIndex_C(anID: Integer;
 aPart: Tm3DocPartSelector = m3_dsMain;
 anIndex: Integer = 0): Tm3DBStreamIndex;
 {* Создаёт идентификатор }
function Tm3DBStreamIndexEx_C(const anID: Tm3DBStreamIndex;
 aPart: Tm3DBPart): Tm3DBStreamIndexEx;
function Tm3DBStreamIndexEx_CV(const anID: Tm3DBStreamIndex;
 aPart: Tm3DBPart;
 aVersion: Integer): Tm3DBStreamIndexEx;

implementation

uses
 l3ImplUses
;

function Tm3DBDocumentInfo_C(aIndexID: Integer): Tm3DBDocumentInfo;
//#UC START# *49C28081033C_4725D0080104_var*
//#UC END# *49C28081033C_4725D0080104_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *49C28081033C_4725D0080104_impl*
 Result.rIndexID := aIndexID;
//#UC END# *49C28081033C_4725D0080104_impl*
end;//Tm3DBDocumentInfo_C

function Tm3DBStreamIndex_C(anID: Integer;
 aPart: Tm3DocPartSelector = m3_dsMain;
 anIndex: Integer = 0): Tm3DBStreamIndex;
 {* Создаёт идентификатор }
//#UC START# *49BFC737039A_4725D1E4005E_var*
//#UC END# *49BFC737039A_4725D1E4005E_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *49BFC737039A_4725D1E4005E_impl*
 Result.rID := anID;
 Result.rPart := aPart;
 Result.rIdx := anIndex;
//#UC END# *49BFC737039A_4725D1E4005E_impl*
end;//Tm3DBStreamIndex_C

function Tm3DBStreamIndexEx_C(const anID: Tm3DBStreamIndex;
 aPart: Tm3DBPart): Tm3DBStreamIndexEx;
//#UC START# *49BFD0280183_49BFCF61009F_var*
//#UC END# *49BFD0280183_49BFCF61009F_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *49BFD0280183_49BFCF61009F_impl*
 Result{$IfDef XE4}.rTm3DBStreamIndex{$EndIf}.rID := anID.rID;
 Result{$IfDef XE4}.rTm3DBStreamIndex{$EndIf}.rPart := anID.rPart;
 Result{$IfDef XE4}.rTm3DBStreamIndex{$EndIf}.rIdx := anID.rIdx;
 Result.rDBPart := aPart;
 Result.rVersion := High(Result.rVersion);
//#UC END# *49BFD0280183_49BFCF61009F_impl*
end;//Tm3DBStreamIndexEx_C

function Tm3DBStreamIndexEx_CV(const anID: Tm3DBStreamIndex;
 aPart: Tm3DBPart;
 aVersion: Integer): Tm3DBStreamIndexEx;
//#UC START# *49BFDB980033_49BFCF61009F_var*
//#UC END# *49BFDB980033_49BFCF61009F_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *49BFDB980033_49BFCF61009F_impl*
 Result := Tm3DBStreamIndexEx_C(anID, aPart);
 Result.rVersion := aVersion;
//#UC END# *49BFDB980033_49BFCF61009F_impl*
end;//Tm3DBStreamIndexEx_CV

end.
