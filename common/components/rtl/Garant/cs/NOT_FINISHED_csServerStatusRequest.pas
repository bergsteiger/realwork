unit NOT_FINISHED_csServerStatusRequest;

// ������: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csServerStatusRequest.pas"
// ���������: "UtilityPack"
// ������� ������: "csServerStatusRequest" MUID: (5317080B0295)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ddServerStatusRequestPrim
;

type
 TddServerStatusRequest = class(TddServerStatusRequestPrim)
 end;//TddServerStatusRequest
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
