unit evParaListHotSpotTester;

// ������: "w:\common\components\gui\Garant\Everest\evParaListHotSpotTester.pas"
// ���������: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evParaListHotSpotTesterPrim
;

type
 TevParaListHotSpotTester = class(TevParaListHotSpotTesterPrim)
 end;//TevParaListHotSpotTester
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(evNeedHotSpot)

end.
