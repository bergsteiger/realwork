unit NOT_COMPLETED_evDocumentHotSpotTester;

// ������: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evDocumentHotSpotTester.pas"
// ���������: "SimpleClass"
// ������� ������: "TevDocumentHotSpotTester" MUID: (4E6E37D90203)

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
