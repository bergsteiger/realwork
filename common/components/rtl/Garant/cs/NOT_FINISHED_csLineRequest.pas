unit NOT_FINISHED_csLineRequest;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csLineRequest.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "csLineRequest" MUID: (5317098403B4)

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
 //#UC START# *5317098403B4impl_uses*
 //#UC END# *5317098403B4impl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.
