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
  {* ��������� ����� ���������. }
  m3_dsMain
   {* �������� ����� }
  , m3_dsAnno
   {* ��������� }
  , m3_dsInfo
   {* ���������� � ��������� }
  , m3_dsObject
   {* ������ � ��������� }
 );//Tm3DocPartSelector
 
 Tm3DocPartSet = set of Tm3DocPartSelector;
  {* ��������� ������� ���������. }
 
 // m3_AllDocParts
 
 Tm3DBDocumentInfo = record
  {* ���������� � ���������. }
 end;//Tm3DBDocumentInfo
 
 Tm3DBStreamIndex = object
  {* ������������� ������ ���������. }
 end;//Tm3DBStreamIndex
 
 Tm3FilerAction = function(aFiler: Tl3CustomFiler;
  const anIndex: Tm3DBStreamIndex): Boolean;
  {* �������������� ������� �������� ������. }
 
 Im3TagGenerator = Ik2TagGenerator;
 
 Tm3DBCopyMode = (
  m3_cmRewrite
  , m3_cmRewriteEmpty
  , m3_cmNotRewrite
 );//Tm3DBCopyMode
 
 (*
 Mm3DB = interface
  procedure DeleteVersion;
   {* ������� ��������� ������ }
  function CompareVersionWithBackup: Boolean;
  procedure CopyBackupToVersion;
  procedure CopyVersionToBackup;
  procedure ExtractMainTo(const aDir: AnsiString);
  procedure ExtractVersionTo(const aDir: AnsiString);
  procedure ExtractBackupTo(const aDir: AnsiString);
  procedure Start(aOpenMode: Tm3StoreAccess);
   {* �������� ������� � �����. }
  function Update(aNotEmpty: Boolean;
   aPurgeDeletedObjects: Boolean): Boolean;
   {* ���������� ����� �� ���������� ����� � ����������. }
  function Purge: integer;
   {* ������� �����, ���������� ��� ��������� � ���������� ����� ���������. }
  procedure Finish;
   {* ����������� ������� � �����. }
  procedure Stop;
   {* ���������� ������� �������. }
 end;//Mm3DB
 *)
 
 Im3DBDocumentPart = interface;
 
 Tm3DocumentAction = function(const aDoc: Im3DBDocumentPart;
  const anIndex: Tm3DBStreamIndex): Boolean;
  {* �������������� ������� �������� ����������. }
 
 Im3DB = interface;
 
 Im3DBObject = interface
  {* ������ ���������� � ���������� ���������� �����������. }
  function DB: Im3DB;
 end;//Im3DBObject
 
 Tm3DBStreamAction = function(const aStream: IStream;
  const anIndex: Tm3DBStreamIndex): Boolean;
  {* ��������������� ������� ��� �������� �������. }
 
 Im3DBDocument = interface;
 
 Im3DBRange = interface;
 
 Im3DB = interface
  {* ��������� ���������� �����������. }
  procedure DeleteMain;
   {* ������� �������� ����� }
  procedure RenameMain(const aNewName: AnsiString);
   {* ��������������� ���������� ����� }
  procedure RenameVersion(const aNewName: AnsiString);
   {* ��������������� ���������� ����� }
  procedure Rename(const aNewName: AnsiString);
   {* ��������������� ��� ���� }
  function GetBackupStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
  function GetVersionsStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
  function MainStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
  function IndexedFiles(anIndexID: Integer): Im3DBRange;
   {* ��������������� �����. }
  function ModifiedFiles(aNotEmpty: Boolean;
   aLevel: Integer): Im3DBRange;
   {* ���������������� �����. }
  function AllFiles: Im3DBRange;
   {* ��� ����� ����. }
  function InProcess: Boolean;
   {* � ����� ���� �������. }
  function Stopped: Boolean;
   {* ���������� ������� ��� ����������. }
  procedure FlushLists;
   {* ���������� ��� Modified � Deleted ������. ����������� ��� �������� ������� ���������� � ����� ������� �����. ��� �� ���������� ��� ����������� ������� ������� � ���� (Tm3DB). }
  function LastElapsed: TDateTime;
   {* ����� ���������� �������� � �����. }
  function GetDocument(anID: Integer): Im3DBDocument;
   {* ���������� �������� �� ������. }
  procedure FreeVersions;
   {* �������� � ���, ��� ��������� ������ ����� ��������� (��������) }
  function FilesInList(const aList: Im3StorageElementIDList): Im3DBRange;
   {* ����� � ���������������� �� ������ }
  procedure DeleteVersion;
   {* ������� ��������� ������ }
  function CompareVersionWithBackup: Boolean;
  procedure CopyBackupToVersion;
  procedure CopyVersionToBackup;
  procedure ExtractMainTo(const aDir: AnsiString);
  procedure ExtractVersionTo(const aDir: AnsiString);
  procedure ExtractBackupTo(const aDir: AnsiString);
  procedure Start(aOpenMode: Tm3StoreAccess);
   {* �������� ������� � �����. }
  function Update(aNotEmpty: Boolean;
   aPurgeDeletedObjects: Boolean): Boolean;
   {* ���������� ����� �� ���������� ����� � ����������. }
  function Purge: integer;
   {* ������� �����, ���������� ��� ��������� � ���������� ����� ���������. }
  procedure Finish;
   {* ����������� ������� � �����. }
  procedure Stop;
   {* ���������� ������� �������. }
 end;//Im3DB
 
 Im3DBDocumentPart = interface(Im3DBObject)
  {* ����� ��������� (�������� ��� ����������). }
  function DateTime: TDateTime;
  function Open(aMode: Tm3StoreAccess;
   aDocPart: Tm3DocPartSelector;
   aIndex: Integer): IStream;
   {* ��������� ����� � ���������. }
 end;//Im3DBDocumentPart
 
 Im3DBDocument = interface(Im3DBObject)
  {* ��������. }
  procedure Delete;
   {* ������� �������� �� ���������. }
  function Undelete: Boolean;
   {* ��������������� ��������. }
  function GetConst: Im3DBDocumentPart;
   {* ���������� ����� ���������. }
  function GetVersion(aLevel: Integer): Im3DBDocumentPart;
   {* ���������� ����� ���������. }
  function Open(aMode: Tm3StoreAccess;
   aDocPart: Tm3DocPartSelector;
   aIndex: Integer): IStream;
   {* ������� ��������. }
  function GetFreeObjectID: Integer;
  procedure DeleteObject(aObjID: Integer);
 end;//Im3DBDocument
 
 Tm3DBIndexAction = function(const anIndex: Tm3DBStreamIndex): Boolean;
  {* ��������������� ������� ��� �������� �������. }
 
 Tm3DBPart = (
  {* ����� ���� }
  m3_bpConst
   {* ���������� }
  , m3_bpVersion
   {* ���������� }
  , m3_bpBackup
   {* ��������� ����� }
 );//Tm3DBPart
 
 Tm3DBStreamIndexEx = object(Tm3DBStreamIndex)
  {* ������������� ������ � ��������� ����� }
 end;//Tm3DBStreamIndexEx
 
 Im3DBRange = interface(Im3DBObject)
  {* ������� ����������. }
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
