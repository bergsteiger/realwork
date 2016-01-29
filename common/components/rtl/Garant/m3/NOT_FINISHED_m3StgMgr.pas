unit NOT_FINISHED_m3StgMgr;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "m3$DB"
// ������: "w:/common/components/rtl/Garant/m3/NOT_FINISHED_m3StgMgr.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::m3$DB::m3DB::m3StgMgr
//
// ������-��������� ��� ������ � IStorage
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\m3\m3Define.inc}

interface

type
 Tm3StorageManager = class
 end;//Tm3StorageManager

 Tm3FullModeStorageManager = class(Tm3StorageManager)
 end;//Tm3FullModeStorageManager

 Tm3ReadModeStorageManager = class(Tm3StorageManager)
 end;//Tm3ReadModeStorageManager

implementation

uses
  m3FileStream,
  m3SplittedFileStream,
  m3ArchiveStorage,
  m3StorageService
  ;

end.