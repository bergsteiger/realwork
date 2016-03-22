unit NOT_FINISHED_csCommonDataRequest;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csCommonDataRequest.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "csCommonDataRequest" MUID: (531706AF03D5)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

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
