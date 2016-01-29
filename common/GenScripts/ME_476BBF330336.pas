unit m4DBInterfaces;

interface

uses
 l3IntfUses
 , l3Types
 , m3DBInterfaces
 , m3StorageInterfaces
;

type
 Tm4WordAction = procedure(aHandle: Integer;
  const aStr: Tl3PCharLen);
 
 Im4DB = interface
  procedure DeleteIndex;
   {* ������� ��������� ������ }
  procedure DeleteIndexDelta;
  function BuildIndex(aDelta: Boolean;
   aExitIfExists: Boolean;
   anIndexID: Integer): Integer;
   {* ������ ����������� �����. ���������� ����� ������������������ ������. }
  procedure UpdateIndex(anIndexID: Integer);
   {* ��������� ��� ������������� ������ (� ����������� �� ��� ���������). }
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
 end;//Im4DB
 
implementation

uses
 l3ImplUses
;

end.
