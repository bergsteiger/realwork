unit NOT_FINISHED_evSBSRowHotSpotTester;

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evSBSRowHotSpotTester.pas"
// ���������: "SimpleClass"
// ������� ������: "TevSBSRowHotSpotTester" MUID: (53D0FD000009)

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
 //#UC START# *53D0FD000009impl_uses*
 //#UC END# *53D0FD000009impl_uses*
;
{$IfEnd} // Defined(evNeedHotSpot)

end.
