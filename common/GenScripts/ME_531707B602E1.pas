unit NOT_FINISHED_csNonEditableDictsRequest;

// ������: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csNonEditableDictsRequest.pas"
// ���������: "UtilityPack"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csRequestTask
;

type
 {$If Defined(RemoteDict)}
 TddNonEditableDictsRequest = class(TddRequestTask)
 end;//TddNonEditableDictsRequest
 {$IfEnd} // Defined(RemoteDict)

{$IfEnd} // NOT Defined(Nemesis)
implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;

{$If Defined(RemoteDict)}
{$IfEnd} // Defined(RemoteDict)
{$IfEnd} // NOT Defined(Nemesis)
end.
