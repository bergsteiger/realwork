unit NOT_FINISHED_evTableHotSpot;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evTableHotSpot.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevTableHotSpot" MUID: (4D640655011C)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evSelectingHotSpot
 , evParaListHotSpotTester
;

type
 TevTableHotSpotTester = class(TevParaListHotSpotTester)
 end;//TevTableHotSpotTester

 TevTableHotSpot = class(TevSelectingHotSpot)
 end;//TevTableHotSpot
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 //#UC START# *4D640655011Cimpl_uses*
 //#UC END# *4D640655011Cimpl_uses*
;
{$IfEnd} // Defined(evNeedHotSpot)

end.
