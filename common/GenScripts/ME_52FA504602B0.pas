unit NOT_FINISHED_csClientMessageRequest;

// ������: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csClientMessageRequest.pas"
// ���������: "UtilityPack"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ddClientMessagePrim
;

type
 TddClientMessage = class(TddClientMessagePrim)
 end;//TddClientMessage
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
