unit NOT_FINISHED_evEvdReader;

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evEvdReader.pas"
// ���������: "UtilityPack"
// ������� ������: "evEvdReader" MUID: (4EA536A500EB)

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
 //#UC START# *4EA536A500EBimpl_uses*
 //#UC END# *4EA536A500EBimpl_uses*
;

end.
