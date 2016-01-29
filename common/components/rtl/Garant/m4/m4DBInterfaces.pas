unit m4DBInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "m4"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/m4/m4DBInterfaces.pas"
// �����: 18.08.2004 21:48
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi For Archi::m4::m4DBInterfaces
//
// ���������� �������������� ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\m4\m4Define.inc}

interface

uses
  l3Interfaces,
  l3Types,
  m3Interfaces,
  m3DBInterfaces,
  m3StorageInterfaces
  ;

type
 Tm4WordAction = procedure (aHandle: Integer;
  const aStr: Tl3PCharLen);

 Im4DB = interface(IUnknown)
   ['{6C9973E5-00A7-46C0-BA8F-E28FFB54D94D}']
   procedure DeleteIndex;
     {* ������� ��������� ������ }
   procedure DeleteIndexDelta;
   function pm_GetPackedIndex: Boolean;
   procedure pm_SetPackedIndex(aValue: Boolean);
   function pm_GetFakeIndex: Boolean;
   procedure pm_SetFakeIndex(aValue: Boolean);
   function BuildIndex(aDelta: Boolean = false;
    aExitIfExists: Boolean = false;
    anIndexID: Integer = 1): Integer;
     {* ������ ����������� �����. ���������� ����� ������������������ ������. }
   procedure UpdateIndex(anIndexID: Integer = 1);
     {* ��������� ��� ������������� ������ (� ����������� �� ��� ���������). }
   property PackedIndex: Boolean
     read pm_GetPackedIndex
     write pm_SetPackedIndex;
     {* �������� �� ������? }
   property FakeIndex: Boolean
     read pm_GetFakeIndex
     write pm_SetFakeIndex;
     {* ������������� � �������? }
  // Mm3DB
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
   function Update(aNotEmpty: Boolean = true;
    aPurgeDeletedObjects: Boolean = true): Boolean;
     {* ���������� ����� �� ���������� ����� � ����������. }
   function Purge: integer;
     {* ������� �����, ���������� ��� ��������� � ���������� ����� ���������. }
   procedure Finish;
     {* ����������� ������� � �����. }
   procedure Stop;
     {* ���������� ������� �������. }
 end;//Im4DB

implementation

end.