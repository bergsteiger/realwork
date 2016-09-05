unit evDocumentHotSpotTester;

// Модуль: "w:\common\components\gui\Garant\Everest\evDocumentHotSpotTester.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevDocumentHotSpotTester" MUID: (4E6E37D90203)

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
 //#UC START# *4E6E37D90203impl_uses*
 //#UC END# *4E6E37D90203impl_uses*
;
{$IfEnd} // Defined(evNeedHotSpot)

end.
