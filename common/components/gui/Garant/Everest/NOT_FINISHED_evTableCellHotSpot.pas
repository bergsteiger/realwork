unit NOT_FINISHED_evTableCellHotSpot;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evTableCellHotSpot.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evTableCellHotSpot" MUID: (53D0C0DD0037)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evParaListHotSpotTester
;

type
 TevTableCellHotSpotTester = class(TevParaListHotSpotTester)
 end;//TevTableCellHotSpotTester
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 //#UC START# *53D0C0DD0037impl_uses*
 //#UC END# *53D0C0DD0037impl_uses*
;
{$IfEnd} // Defined(evNeedHotSpot)

end.
