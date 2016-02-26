unit NOT_FINISHED_csLineRequest;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csLineRequest.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csLineRequestPrim
;

type
 TcsLineRequest = class(TcsLineRequestPrim)
 end;//TcsLineRequest
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
