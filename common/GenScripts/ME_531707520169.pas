unit NOT_FINISHED_csBaseStatusRequest;

// ������: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csBaseStatusRequest.pas"
// ���������: "UtilityPack"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csRequestTask
;

type
 TddBaseStatusRequest = class(TddRequestTask)
 end;//TddBaseStatusRequest
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
