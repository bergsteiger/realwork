unit NOT_FINISHED_evEvdWriter;
 {* �������� ����� � ������� evd � ����������������� ��������� (IStorage). }

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evEvdWriter.pas"
// ���������: "UtilityPack"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdCustomNativeWriter
;

type
 TevCustomEvdStorageWriter = class(TevdCustomNativeWriter)
 end;//TevCustomEvdStorageWriter

 TevEvdStorageWriter = class(TevCustomEvdStorageWriter)
  {* �������� ����� � ������� evd � ����������������� ��������� (IStorage). (� published ����������) }
 end;//TevEvdStorageWriter

 TevPartContainer = class
 end;//TevPartContainer

implementation

uses
 l3ImplUses
;

end.
