unit NOT_FINISHED_csServerStatusRequest;

// ������: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csServerStatusRequest.pas"
// ���������: "UtilityPack"

{$Include CsDefine.inc}

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
