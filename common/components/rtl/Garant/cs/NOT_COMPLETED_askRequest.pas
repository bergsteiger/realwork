unit NOT_COMPLETED_askRequest;

// ������: "w:\common\components\rtl\Garant\cs\NOT_COMPLETED_askRequest.pas"
// ���������: "SimpleClass"
// ������� ������: "TaskRequest" MUID: (531708E3023A)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csRequestTask
;

type
 TaskRequest = class(TddRequestTask)
 end;//TaskRequest
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
