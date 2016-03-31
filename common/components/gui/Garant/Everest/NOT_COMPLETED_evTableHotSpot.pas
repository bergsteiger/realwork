unit NOT_COMPLETED_evTableHotSpot;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evTableHotSpot.pas"
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
;
{$IfEnd} // Defined(evNeedHotSpot)

end.
