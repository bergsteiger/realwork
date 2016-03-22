unit NOT_FINISHED_evSBSRowHotSpotTester;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evSBSRowHotSpotTester.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevSBSRowHotSpotTester" MUID: (53D0FD000009)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evTableRowHotSpot
;

type
 TevSBSRowHotSpotTester = class(TevTableRowHotSpotTester)
 end;//TevSBSRowHotSpotTester
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(evNeedHotSpot)

end.
