unit evParaListHotSpotTester;

// Модуль: "w:\common\components\gui\Garant\Everest\evParaListHotSpotTester.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevParaListHotSpotTester" MUID: (4A27B7300174)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evParaListHotSpotTesterPrim
;

type
 TevParaListHotSpotTester = class(TevParaListHotSpotTesterPrim)
 end;//TevParaListHotSpotTester
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(evNeedHotSpot)

end.
