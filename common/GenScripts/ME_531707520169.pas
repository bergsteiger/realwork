unit NOT_FINISHED_csBaseStatusRequest;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csBaseStatusRequest.pas"
// Стереотип: "UtilityPack"

{$Include CsDefine.inc}

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
