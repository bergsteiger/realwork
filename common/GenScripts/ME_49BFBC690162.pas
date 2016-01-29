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
  {* ��������� ��� ����������� ���� }
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
   {* ��������� �������� � ������ ��������� }
  procedure Commit(aStream: Tl3ProxyStream);
   {* ��������� ��������� � ��������� }
  procedure Revert(aStream: Tl3ProxyStream);
   {* ���������� ��������� ������ }
  function MainStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
   {* ���������� ������ ���������� ����� }
  function GetVersionsStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
   {* ���������� ������ ���������� ����� }
  function GetBackupStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
   {* ���������� ������ ��������� ����� }
  function GetDocumentObjectsIDs(aDocID: Integer): Im3StorageElementIDList;
   {* ���������� ������ ������� �������� � ��������� }
  procedure Start(aOpenMode: Tm3StoreAccess);
   {* �������� ������� � ����� }
  procedure Finish;
   {* ����������� ������� � ����� }
  procedure StartEx(aVersionsMode: Tm3StoreAccess;
   aConstMode: Tm3StoreAccess);
   {* �������� ������� � ����� }
  procedure CloseBase;
   {* ��������� �������� ����� }
  procedure IterateObjectsInDocF(aDocID: Integer;
   aDeleted: Boolean;
   anAction: Tm3DBStreamAction;
   aSkipMain: Boolean);
   {* ���������� ������� � ��������� }
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
