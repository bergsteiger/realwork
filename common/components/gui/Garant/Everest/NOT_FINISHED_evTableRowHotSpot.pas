unit NOT_FINISHED_evTableRowHotSpot;

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evTableRowHotSpot.pas"
// ���������: "UtilityPack"
// ������� ������: "evTableRowHotSpot" MUID: (53D0FC9901A6)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evParaListHotSpotTester
;

type
 TevTableRowHotSpotTester = class(TevParaListHotSpotTester)
 end;//TevTableRowHotSpotTester
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(evNeedHotSpot)

end.
