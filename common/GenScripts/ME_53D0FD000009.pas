unit NOT_FINISHED_evSBSRowHotSpotTester;

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evSBSRowHotSpotTester.pas"
// ���������: "SimpleClass"

{$Include evDefine.inc}

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
