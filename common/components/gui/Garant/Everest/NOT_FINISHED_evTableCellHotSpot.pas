unit NOT_FINISHED_evTableCellHotSpot;

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evTableCellHotSpot.pas"
// ���������: "UtilityPack"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evParaListHotSpotTester
;

type
 TevTableCellHotSpotTester = class(TevParaListHotSpotTester)
 end;//TevTableCellHotSpotTester
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(evNeedHotSpot)

end.
