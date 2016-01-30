unit NOT_FINISHED_csCommonDataRequest;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csCommonDataRequest.pas"
// Стереотип: "UtilityPack"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ddCommonDataRequestPrim
;

type
 TddCommonDataRequest = class(TddCommonDataRequestPrim)
 end;//TddCommonDataRequest
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
