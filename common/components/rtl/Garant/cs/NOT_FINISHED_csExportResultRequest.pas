unit NOT_FINISHED_csExportResultRequest;

// ������: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csExportResultRequest.pas"
// ���������: "UtilityPack"
// ������� ������: "csExportResultRequest" MUID: (53170931038A)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csRequestTask
;

type
 TcsExportResultRequest = class(TddRequestTask)
 end;//TcsExportResultRequest
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *53170931038Aimpl_uses*
 //#UC END# *53170931038Aimpl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.
