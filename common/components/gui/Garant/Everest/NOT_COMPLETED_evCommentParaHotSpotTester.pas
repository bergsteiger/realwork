unit NOT_COMPLETED_evCommentParaHotSpotTester;

// ������: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evCommentParaHotSpotTester.pas"
// ���������: "SimpleClass"
// ������� ������: "TevCommentParaHotSpotTester" MUID: (53D247570237)

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
