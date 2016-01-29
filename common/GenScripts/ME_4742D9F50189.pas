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
  {* ��������� �������. }
  m3_brpIndexed
  , m3_brpModified
 );//Tm3BaseRangeParam
 
 Tm3BaseRangeParams = set of Tm3BaseRangeParam;
  {* ��������� �������. }
 
 Tm3BaseRange = class(Tm3BaseObject, Im3DBRange)
  {* ������� ���������� ������� ����������. }
  function Mul(const aRange: Im3DBRange): Im3DBRange;
   {* ���������� �������. }
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
   {* ���������� ������� � ������ ����. }
 end;//Tm3BaseRange
 
 Im3BaseRangeParamsSource = interface
  {* ��������� �������. }
 end;//Im3BaseRangeParamsSource
 
 Tm3DocListRange = class(Tm3BaseRange)
  {* ���������� ������� ����������, �� ������ �������. }
 end;//Tm3DocListRange
 
 Tm3BaseParametricRange = class(Tm3BaseRange, Im3BaseRangeParamsSource)
  function Params: Tm3BaseRangeParams;
   {* ��������� �������. }
 end;//Tm3BaseParametricRange
 
 Tm3CommonListSelector = (
  clsDeleted
  , clsModified
 );//Tm3CommonListSelector
 
 Tm3CustomDB = class(Tm3PrimDB, Im3DB)
  {* ������� ���������� ��������� ����������. }
  procedure SetList(aListSelector: Tm3CommonListSelector;
   anID: Integer;
   aInsert: Boolean);
   {* ���������� ������ aListSelector. }
  function IndexedFiles(anIndexID: Integer): Im3DBRange;
   {* ��������������� �����. }
  function ModifiedFiles(aNotEmpty: Boolean;
   aLevel: Integer): Im3DBRange;
   {* ���������������� �����. }
  function AllFiles: Im3DBRange;
   {* ��� ����� ����. }
  function InProcess: Boolean; overload;
   {* � ����� ���� �������. }
  function Stopped: Boolean; overload;
   {* ���������� ������� ��� ����������. }
  procedure Stop;
   {* ���������� ������� �������. }
  function Purge: integer;
   {* ������� �����, ���������� ��� ��������� � ���������� ����� ���������. }
  function Update(aNotEmpty: Boolean;
   aPurgeDeletedObjects: Boolean): Boolean;
   {* ���������� ����� �� ���������� ����� � ����������. }
  procedure FlushLists;
   {* ���������� ��� Modified � Deleted ������. ����������� ��� �������� ������� ���������� � ����� ������� �����. ��� �� ���������� ��� ����������� ������� ������� � ���� (Tm3DB). }
  procedure Start(aOpenMode: Tm3StoreAccess);
   {* �������� ������� � �����. }
  procedure Finish;
   {* ����������� ������� � �����. }
  function LastElapsed: TDateTime; overload;
   {* ����� ���������� �������� � �����. }
  function GetDocument(anID: Integer): Im3DBDocument;
   {* ���������� �������� �� ������. }
  procedure FreeVersions;
   {* �������� � ���, ��� ��������� ������ ����� ��������� (��������) }
  procedure ModifyModified(anID: Integer);
   {* ��������� �������� � ������ ��������� }
  function FilesInList(const aList: Im3StorageElementIDList): Im3DBRange;
   {* ����� � ���������������� �� ������ }
  procedure DeleteVersion;
   {* ������� ��������� ������ }
  procedure DeleteMain;
   {* ������� �������� ����� }
  procedure RenameMain(const aNewName: AnsiString);
   {* ��������������� ���������� ����� }
  procedure RenameVersion(const aNewName: AnsiString);
   {* ��������������� ���������� ����� }
  procedure Rename(const aNewName: AnsiString);
   {* ��������������� ��� ���� }
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
   {* ���������� ������ ���������� ����� }
  function GetVersionsStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
   {* ���������� ������ ���������� ����� }
  function GetBackupStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
   {* ���������� ������ ��������� ����� }
  procedure Start(aOpenMode: Tm3StoreAccess);
   {* �������� ������� � ����� }
  procedure Finish;
   {* ����������� ������� � ����� }
  procedure StartEx(aVersionsMode: Tm3StoreAccess;
   aConstMode: Tm3StoreAccess);
   {* �������� ������� � ����� }
  procedure CloseBase;
   {* ��������� �������� ����� }
 end;//Tm3DB
 
 Tm3BiCompBaseRange = class(Tm3BaseParametricRange)
  {* ����� - � ���� ������������. }
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
