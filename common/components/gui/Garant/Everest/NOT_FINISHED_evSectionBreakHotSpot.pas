unit NOT_FINISHED_evSectionBreakHotSpot;

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evSectionBreakHotSpot.pas"
// ���������: "UtilityPack"
// ������� ������: "evSectionBreakHotSpot" MUID: (53D0B0A10259)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evHotSpot
;

type
 TevSectionBreakHotSpotTester = class(TevHotSpot)
 end;//TevSectionBreakHotSpotTester
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 //#UC START# *53D0B0A10259impl_uses*
 //#UC END# *53D0B0A10259impl_uses*
;
{$IfEnd} // Defined(evNeedHotSpot)

end.
