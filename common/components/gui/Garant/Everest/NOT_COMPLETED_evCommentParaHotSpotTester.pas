unit NOT_COMPLETED_evCommentParaHotSpotTester;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evCommentParaHotSpotTester.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevCommentParaHotSpotTester" MUID: (53D247570237)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evDocumentPartHotSpotTester
;

type
 TevCommentParaHotSpotTester = class(TevDocumentPartHotSpotTester)
 end;//TevCommentParaHotSpotTester
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(evNeedHotSpot)

end.
