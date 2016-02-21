unit m4DBInterfaces;
 {* ���������� �������������� ���������. }

// ������: "w:\common\components\rtl\Garant\m4\m4DBInterfaces.pas"
// ���������: "Interfaces"

{$Include w:\common\components\rtl\Garant\m4\m4Define.inc}

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
  ['{6C9973E5-00A7-46C0-BA8F-E28FFB54D94D}']
  function pm_GetPackedIndex: Boolean;
  procedure pm_SetPackedIndex(aValue: Boolean);
  function pm_GetFakeIndex: Boolean;
  procedure pm_SetFakeIndex(aValue: Boolean);
  procedure DeleteIndex;
   {* ������� ��������� ������ }
  procedure DeleteIndexDelta;
  function BuildIndex(aDelta: Boolean = False;
   aExitIfExists: Boolean = False;
   anIndexID: Integer = 1): Integer;
   {* ������ ����������� �����. ���������� ����� ������������������ ������. }
  procedure UpdateIndex(anIndexID: Integer = 1);
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
  function Update(aNotEmpty: Boolean = True;
   aPurgeDeletedObjects: Boolean = True): Boolean;
   {* ���������� ����� �� ���������� ����� � ����������. }
  function Purge: integer;
   {* ������� �����, ���������� ��� ��������� � ���������� ����� ���������. }
  procedure Finish;
   {* ����������� ������� � �����. }
  procedure Stop;
   {* ���������� ������� �������. }
  property PackedIndex: Boolean
   read pm_GetPackedIndex
   write pm_SetPackedIndex;
   {* �������� �� ������? }
  property FakeIndex: Boolean
   read pm_GetFakeIndex
   write pm_SetFakeIndex;
   {* ������������� � �������? }
 end;//Im4DB

implementation

uses
 l3ImplUses
;

end.
