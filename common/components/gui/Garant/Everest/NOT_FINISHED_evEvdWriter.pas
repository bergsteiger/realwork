unit NOT_FINISHED_evEvdWriter;
 {* �������� ����� � ������� evd � ����������������� ��������� (IStorage). }

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evEvdWriter.pas"
// ���������: "UtilityPack"
// ������� ������: "evEvdWriter" MUID: (4EA52FD6034D)

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
 //#UC START# *4EA52FD6034Dimpl_uses*
 //#UC END# *4EA52FD6034Dimpl_uses*
;

end.
