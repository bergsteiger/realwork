unit NOT_FINISHED_evEvdReader;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evEvdReader.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Readers::evEvdReader
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evEvdRd
  ;

type
 TevCustomEvdStorageReader = class(TevCustomEvdReader)
  {* �������� ����� � ������� evd �� ������������������ ��������� (IStorage) }
 end;//TevCustomEvdStorageReader

 TevEvdStorageReader = class(TevCustomEvdStorageReader)
  {* �������� ����� � ������� evd (� published ����������). }
 end;//TevEvdStorageReader

implementation

end.