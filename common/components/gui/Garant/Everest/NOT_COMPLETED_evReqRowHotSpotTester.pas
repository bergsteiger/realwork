unit NOT_COMPLETED_evReqRowHotSpotTester;

// ������: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evReqRowHotSpotTester.pas"
// ���������: "SimpleClass"
// ������� ������: "TevReqRowHotSpotTester" MUID: (53D668610126)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)}
uses
 l3IntfUses
 , evTableRowHotSpot
;

type
 TevReqRowHotSpotTester = class(TevTableRowHotSpotTester)
 end;//TevReqRowHotSpotTester
{$IfEnd} // Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)

implementation

{$If Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)}
uses
 l3ImplUses
;

{$IfEnd} // Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)
end.
