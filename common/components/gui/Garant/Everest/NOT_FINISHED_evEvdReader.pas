unit NOT_FINISHED_evEvdReader;

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evEvdReader.pas"
// ���������: "UtilityPack"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evEvdRd
;

type
 TevCustomEvdStorageReader = class(TevCustomEvdReader)
  {* �������� ����� � ������� evd �� ������������������ ��������� (IStorage) }
 end;//TevCustomEvdStorageReader

 TevEvdStorageReader = class(TevCustomEvdStorageReader)
  {* �������� ����� � ������� evd (� published ����������). }
 end;//TevEvdStorageReader

implementation

uses
 l3ImplUses
;

end.
