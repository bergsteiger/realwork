unit evDocumentHotSpotTester;

// Модуль: "w:\common\components\gui\Garant\Everest\evDocumentHotSpotTester.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evParaListHotSpotTester
;

type
 TevDocumentHotSpotTester = class(TevParaListHotSpotTester)
 end;//TevDocumentHotSpotTester
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(evNeedHotSpot)

end.
