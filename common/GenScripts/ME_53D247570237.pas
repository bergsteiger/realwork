unit NOT_FINISHED_evCommentParaHotSpotTester;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evCommentParaHotSpotTester.pas"
// Стереотип: "SimpleClass"

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
