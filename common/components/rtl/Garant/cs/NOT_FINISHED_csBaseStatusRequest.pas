unit NOT_FINISHED_csBaseStatusRequest;

// ������: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csBaseStatusRequest.pas"
// ���������: "UtilityPack"
// ������� ������: "csBaseStatusRequest" MUID: (531707520169)

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
 //#UC START# *531707520169impl_uses*
 //#UC END# *531707520169impl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.
